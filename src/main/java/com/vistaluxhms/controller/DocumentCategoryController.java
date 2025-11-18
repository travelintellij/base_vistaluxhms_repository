package com.vistaluxhms.controller;

import com.vistaluxhms.entity.AshokaTeam;
import com.vistaluxhms.entity.DocumentCategoryEntity;
import com.vistaluxhms.entity.DocumentCategoryMaster;
import com.vistaluxhms.model.DocumentCategoryDTO;
import com.vistaluxhms.repository.DocumentCategoryMasterRepository;
import com.vistaluxhms.repository.DocumentCategoryRepository;
import com.vistaluxhms.services.DocumentCategoryServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.security.core.Authentication;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import static com.vistaluxhms.services.DocumentCategoryServiceImpl.*;


@Controller
public class DocumentCategoryController {

    @Autowired
    private DocumentCategoryServiceImpl documentService;

    @Autowired
    private DocumentCategoryRepository documentCategoryRepository;

    @Autowired
    private DocumentCategoryMasterRepository documentCategoryMasterRepository;



    private boolean hasAnyRole(Authentication auth, String... roles) {
        return auth.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .anyMatch(role -> Arrays.asList(roles).contains(role));
    }

    @GetMapping("/view_documents_list")
    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_DOCUMENT_MANAGER','ROLE_DOCUMENT_ALLOWED','ROLE_RESTRICTED_DOC_ACCESS')")
    public ModelAndView viewDocumentsList(@RequestParam(required = false) Integer categoryId,
                                          Authentication authentication) {

        List<DocumentCategoryDTO> documents;

        // ✅ Get username from Authentication
        String username = (authentication != null) ? authentication.getName() : null;

        if (username == null || username.equalsIgnoreCase("anonymousUser")) {
            documents = Collections.emptyList();
            System.out.println("🔴 No logged-in user");
        } else {
            // ✅ Fetch AshokaTeam user
            AshokaTeam user = documentService.getUserByUsername(username);
            System.out.println("🟢 Logged-in user: " + user.getName() + ", ID: " + user.getUserId());

            if (categoryId != null) {
                documents = documentService.getDocumentsByCategory(categoryId);
            } else {
                // Determine if user has access to restricted documents
                documents = documentService.getDocumentsForUser(user); // NEW method
            }
        }
        // Group documents by category
        Map<String, List<DocumentCategoryDTO>> groupedDocs = documents.stream()
                .collect(Collectors.groupingBy(DocumentCategoryDTO::getCategoryName,
                        LinkedHashMap::new, Collectors.toList()));

        ModelAndView mv = new ModelAndView("others/viewDocuments");
        mv.addObject("groupedDocs", groupedDocs);
        mv.addObject("documents", documents);

        // Pass users and roles to view
        Map<Integer, String> ashokaTeams = documentService.getAllAshokaTeamMembers()
                .stream()
                .collect(Collectors.toMap(AshokaTeam::getUserId, AshokaTeam::getName));
        mv.addObject("ashokaTeams", ashokaTeams);

        String rolesStr = authentication.getAuthorities().stream()
                .map(a -> a.getAuthority())
                .collect(Collectors.joining(","));
        mv.addObject("userRoles", rolesStr);

        mv.addObject("categories", documentService.getActiveCategories());

        return mv;
    }
    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_DOCUMENT_MANAGER')")
    @GetMapping("/add_document")
    public ModelAndView showAddDocumentForm(Authentication authentication) {
        ModelAndView mv = new ModelAndView("others/addDocument");
        mv.addObject("documentDTO", new DocumentCategoryDTO());

        Map<Integer, String> ashokaTeams = documentService.getAllAshokaTeamMembers()
                .stream()
                .collect(Collectors.toMap(AshokaTeam::getUserId, AshokaTeam::getName));

        mv.addObject("ashokaTeams", ashokaTeams);


        mv.addObject("userRoles", authentication.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .collect(Collectors.joining(",")));

        List<DocumentCategoryMaster> categories = documentCategoryMasterRepository.findByStatus("Active");
        mv.addObject("categories", categories);

        return mv;
    }

    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_DOCUMENT_MANAGER')")
    @PostMapping("/save_document")
    public ModelAndView saveDocument(
            @RequestParam("file") MultipartFile file,
            @RequestParam("categoryId") Integer categoryId,
            @RequestParam String documentName,
            @RequestParam(value = "restricted", required = false) boolean restricted,
            Authentication authentication) throws IOException {


        long MAX_SIZE = 5L * 1024 * 1024;
        if (file == null || file.isEmpty()) {
            ModelAndView mv = new ModelAndView("add_document");
            mv.addObject("errorMessage", "Please choose a file to upload.");
            mv.addObject("categories", documentCategoryMasterRepository.findAll());
            return mv;
        }
        if (file.getSize() > MAX_SIZE) {
            ModelAndView mv = new ModelAndView("add_document");
            mv.addObject("errorMessage", "File size should not exceed 5 MB!");
            mv.addObject("categories", documentCategoryMasterRepository.findAll());
            return mv;
        }

        DocumentCategoryMaster selectedCategory = documentCategoryMasterRepository.findById(categoryId)
                .orElseThrow(() -> new RuntimeException("Category not found"));


        DocumentCategoryDTO dto = new DocumentCategoryDTO();
        dto.setCategoryId(categoryId);
        dto.setCategoryName(selectedCategory.getCategoryName());
        dto.setDocumentName(documentName);
        dto.setFileName(file.getOriginalFilename());
        dto.setFileType(file.getContentType());
        dto.setFileSize(file.getSize());
        dto.setFileData(file.getBytes());
        dto.setRestricted(restricted);
        String currentUsername = null;
        if (SecurityContextHolder.getContext() != null &&
                SecurityContextHolder.getContext().getAuthentication() != null) {

            currentUsername = SecurityContextHolder.getContext().getAuthentication().getName();
            System.out.println("🟢 Username from SecurityContext: " + currentUsername);
        }

        if (currentUsername == null || currentUsername.equalsIgnoreCase("anonymousUser")) {
            currentUsername = "Sushil";
            System.out.println("🟣 Using fallback username: " + currentUsername);
        }

        Integer userId = documentService.getUserIdByUsername(currentUsername);
        System.out.println("🟢 Final UploadedBy userId: " + userId);

        dto.setUploadedBy(userId);
        documentService.saveDocument(dto);

        return new ModelAndView("redirect:/view_documents_list");
    }

    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_DOCUMENT_MANAGER','ROLE_DOCUMENT_ALLOWED','ROLE_RESTRICTED_DOC_ACCESS')")
    @GetMapping("/download_document/{id}")
    public void downloadDocument(@PathVariable Integer id, HttpServletResponse response) throws IOException {
        DocumentCategoryDTO dto = documentService.getDocumentById(id);
        if (dto != null) {
            response.setContentType(dto.getFileType());
            response.setHeader("Content-Disposition", "attachment; filename=\"" + dto.getFileName() + "\"");
            response.getOutputStream().write(dto.getFileData());
            response.getOutputStream().flush();
        }
    }


    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_DOCUMENT_MANAGER')")
    @GetMapping("/delete_document/{id}")
    public ModelAndView deleteDocument(@PathVariable Integer id) {
        documentService.hardDeleteDocument(id);
        return new ModelAndView("redirect:/view_documents_list");
    }


    @GetMapping("/view_document/{documentId}")
    public void viewDocumentInBrowser(@PathVariable int documentId, HttpServletResponse response) throws IOException {
        DocumentCategoryEntity document = documentCategoryRepository.findById(documentId)
                .orElseThrow(() -> new RuntimeException("Document not found"));

        String fileName = document.getFileName().toLowerCase();
        String contentType = "application/octet-stream";

        if (fileName.endsWith(".pdf")) contentType = "application/pdf";
        else if (fileName.endsWith(".jpg") || fileName.endsWith(".jpeg")) contentType = "image/jpeg";
        else if (fileName.endsWith(".png")) contentType = "image/png";
        else if (fileName.endsWith(".docx")) contentType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document";

        response.setContentType(contentType);
        response.setHeader("Content-Disposition", "inline; filename=\"" + document.getFileName() + "\"");

        ServletOutputStream out = response.getOutputStream();
        out.write(document.getFileData());
        out.flush();
        out.close();
    }

    @GetMapping("/manage_documentcategories")
    public ModelAndView manageDocumentCategories(@RequestParam(value = "status", required = false) String status) {
        ModelAndView mv = new ModelAndView("others/manageDocumentcategories");

        List<DocumentCategoryMaster> categories;
        if (status == null || status.isEmpty()) {
            categories = documentCategoryMasterRepository.findByStatus("Active");
            status = "Active";
        } else {
            categories = documentCategoryMasterRepository.findByStatus(status);
        }

        mv.addObject("documentCategories", categories);
        mv.addObject("selectedStatus", status);
        return mv;
    }

    @GetMapping("/add_documentcategory")
    public ModelAndView addDocumentCategoryForm() {
        ModelAndView mv = new ModelAndView("others/addDocumentcategory");
        mv.addObject("category", new DocumentCategoryMaster());
        return mv;
    }


    @PostMapping("/save_documentcategory")
    public ModelAndView saveDocumentCategory(@ModelAttribute DocumentCategoryMaster category) {
        documentService.saveCategory(category);
        return new ModelAndView("redirect:/manage_documentcategories");
    }


    @PostMapping("/delete_documentcategory/{id}")
    public ModelAndView deleteDocumentCategory(@PathVariable Integer id) {
        documentService.deleteCategory(id);
        return new ModelAndView("redirect:/manage_documentcategories");
    }

    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_DOCUMENT_MANAGER')")
    @PostMapping("/doc_categories_deactivate/{id}")
    public ModelAndView deactivateDocumentCategory(@PathVariable Integer id) {
        DocumentCategoryMaster category = documentCategoryMasterRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Document Category not found"));
        category.setStatus("Inactive");
        documentCategoryMasterRepository.save(category);
        return new ModelAndView("redirect:/manage_documentcategories?status=Active");
    }

    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_DOCUMENT_MANAGER')")
    @PostMapping("/doc_categories_activate/{id}")
    public ModelAndView activateDocumentCategory(@PathVariable Integer id) {
        DocumentCategoryMaster category = documentCategoryMasterRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Document Category not found"));
        category.setStatus("Active");
        documentCategoryMasterRepository.save(category);
        return new ModelAndView("redirect:/manage_documentcategories?status=Inactive");
    }

    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_DOCUMENT_MANAGER')")
    @PostMapping("/update_document_category")
    @ResponseBody
    public ResponseEntity<String> updateDocumentCategory(@ModelAttribute DocumentCategoryMaster category) {
        DocumentCategoryMaster existingCategory = documentCategoryMasterRepository.findById(category.getId())
                .orElseThrow(() -> new RuntimeException("Document Category not found"));

        existingCategory.setCategoryName(category.getCategoryName());
        existingCategory.setDescription(category.getDescription());

        documentCategoryMasterRepository.save(existingCategory);

        return ResponseEntity.ok("Category updated successfully");
    }
}
