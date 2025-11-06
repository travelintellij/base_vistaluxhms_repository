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
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;



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


    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_DOCUMENT_MANAGER','ROLE_DOCUMENT_ALLOWED')")
    @GetMapping("/view_documents_list")
    public ModelAndView viewDocumentsList(
            @RequestParam(required = false) Integer categoryId,
            Authentication authentication) {

        List<DocumentCategoryDTO> documents;


        if (categoryId != null) {
            documents = documentService.getDocumentsByCategory(categoryId);
        } else {
            documents = documentService.getActiveDocuments(
                    hasAnyRole(authentication, "ROLE_ADMIN", "ROLE_DOCUMENT_MANAGER")
            );
        }

        ModelAndView mv = new ModelAndView("others/viewDocuments");

        mv.addObject("documents", documents);

        Map<Integer, String> ashokaTeams = documentService.getAllAshokaTeamMembers()
                .stream()
                .collect(Collectors.toMap(AshokaTeam::getUserId, AshokaTeam::getName));
        mv.addObject("ashokaTeams", ashokaTeams);

        mv.addObject("userRoles", authentication.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .collect(Collectors.joining(",")));

        List<DocumentCategoryMaster> categories = documentService.getAllCategories();
        mv.addObject("categories", categories);

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

        List<DocumentCategoryMaster> categories = documentCategoryMasterRepository.findAll();
        mv.addObject("categories", categories);

        return mv;
    }

    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_DOCUMENT_MANAGER')")
    @PostMapping("/save_document")
    public ModelAndView saveDocument(
            @RequestParam("file") MultipartFile file,
            @RequestParam("categoryId") Integer categoryId,
            @RequestParam("uploadedBy") Integer uploadedBy,
            @RequestParam(value = "restricted", required = false) boolean restricted) throws IOException {


        DocumentCategoryMaster selectedCategory = documentCategoryMasterRepository.findById(categoryId)
                .orElseThrow(() -> new RuntimeException("Category not found"));


        DocumentCategoryDTO dto = new DocumentCategoryDTO();
        dto.setCategoryId(categoryId);
        dto.setCategoryName(selectedCategory.getCategoryName());
        dto.setUploadedBy(uploadedBy);
        dto.setFileName(file.getOriginalFilename());
        dto.setFileType(file.getContentType());
        dto.setFileSize(file.getSize());
        dto.setFileData(file.getBytes());
        dto.setRestricted(restricted);

        documentService.saveDocument(dto);

        return new ModelAndView("redirect:/view_documents_list");
    }

    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_DOCUMENT_MANAGER','ROLE_DOCUMENT_ALLOWED')")
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

    @PreAuthorize("hasAnyRole('ROLE_ADMIN','DOCUMENT_MANAGER')")
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
