package com.vistaluxhms.services;

import com.vistaluxhms.entity.AshokaTeam;
import com.vistaluxhms.entity.DocumentCategoryEntity;
import com.vistaluxhms.entity.DocumentCategoryMaster;
import com.vistaluxhms.model.DocumentCategoryDTO;
import com.vistaluxhms.repository.DocumentCategoryMasterRepository;
import com.vistaluxhms.repository.DocumentCategoryRepository;
import com.vistaluxhms.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class DocumentCategoryServiceImpl {

    @Autowired
    private DocumentCategoryRepository documentCategoryRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private DocumentCategoryMasterRepository documentCategoryMasterRepository;


    public DocumentCategoryDTO saveDocument(DocumentCategoryDTO dto) {
        DocumentCategoryEntity entity = new DocumentCategoryEntity();

        DocumentCategoryMaster cat = documentCategoryMasterRepository.findById(dto.getCategoryId())
                .orElseThrow(() -> new RuntimeException("Category not found"));
        entity.setCategoryName(dto.getCategoryName());

        entity.setCategory(cat);
        entity.setFileName(dto.getFileName());
        entity.setFileType(dto.getFileType());
        entity.setFileSize(dto.getFileSize());
        entity.setDocumentName(dto.getDocumentName());
        entity.setUploadedDate(new Date());
        entity.setFileData(dto.getFileData());
        entity.setRestricted(dto.isRestricted());
        entity.setUploadedBy(dto.getUploadedBy());
        entity = documentCategoryRepository.save(entity);

        dto.setDocumentId(entity.getDocumentId());
        return dto;
    }


    public DocumentCategoryDTO getDocumentById(Integer documentId) {
        Optional<DocumentCategoryEntity> opt = documentCategoryRepository.findById(documentId);
        return opt.map(this::convertToDTO).orElse(null);
    }


    public List<DocumentCategoryDTO> getAllDocuments() {
        return documentCategoryRepository.findAll()
                .stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }


    private DocumentCategoryDTO convertToDTO(DocumentCategoryEntity entity) {
        DocumentCategoryDTO dto = new DocumentCategoryDTO();
        dto.setDocumentId(entity.getDocumentId());
        if (entity.getCategory() != null) {
            dto.setCategoryId(entity.getCategory().getId());
            dto.setCategoryName(entity.getCategory().getCategoryName());
        }
        dto.setFileName(entity.getFileName());
        dto.setFileType(entity.getFileType());
        dto.setFileSize(entity.getFileSize());
        dto.setDocumentName(entity.getDocumentName());
        dto.setUploadedDate(entity.getUploadedDate());
        dto.setFileData(entity.getFileData());
        dto.setRestricted(entity.isRestricted());
        return dto;
    }


    public void hardDeleteDocument(Integer id) {
        if (documentCategoryRepository.existsById(id)) {
            documentCategoryRepository.deleteById(id);
        } else {
            throw new RuntimeException("Document not found with id: " + id);
        }
    }

    public List<DocumentCategoryDTO> getAllActiveDocuments() {
        return documentCategoryRepository.findAll()
                .stream()
                .filter(doc -> !doc.isDeleted())
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    public List<AshokaTeam> getAllAshokaTeamMembers() {
        return userRepository.findAllActiveUsers();
    }

    public List<DocumentCategoryDTO> getUnrestrictedDocuments() {
        return documentCategoryRepository.findByRestrictedFalseAndDeletedFalse()
                .stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    public List<DocumentCategoryDTO> getActiveDocuments(boolean includeRestricted) {
        List<DocumentCategoryEntity> docs;

        if (includeRestricted) {
            // Admin + Manager + Restricted-Access users
            docs = documentCategoryRepository.findByDeletedFalse();
            System.out.println("🔹 Fetching ALL active documents (restricted + unrestricted)");
        } else {
            // Normal users → Only unrestricted
            docs = documentCategoryRepository.findByRestrictedFalseAndDeletedFalse();
            System.out.println("🔹 Fetching ONLY unrestricted documents");
        }

        return docs.stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }


    public List<String> getAllCategoryNames() {
        return documentCategoryMasterRepository.findAll()
                .stream()
                .map(c -> c.getCategoryName())
                .collect(Collectors.toList());
    }


    public void saveCategory(DocumentCategoryMaster category) {
        documentCategoryMasterRepository.save(category);
    }

    public List<DocumentCategoryMaster> getAllCategories() {
        return documentCategoryMasterRepository.findAll();
    }


    public void deleteCategory(Integer id) {
        documentCategoryMasterRepository.deleteById(id);
    }

    public List<DocumentCategoryDTO> getDocumentsByCategory(Integer categoryId) {
        return documentCategoryRepository.findByCategory_Id(categoryId)
                .stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    public Integer getUserIdByUsername(String username) {
        return userRepository.findByUsername(username)
                .map(AshokaTeam::getUserId)
                .orElse(null);
    }

    public List<DocumentCategoryMaster> getActiveCategories() {
        return documentCategoryMasterRepository.findByStatus("Active");
    }



    // new helper method in service
    public AshokaTeam getUserByUsername(String username) {
        return userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("User not found: " + username));
    }
    public boolean userHasRestrictedAccess(AshokaTeam user) {
        System.out.println("🟢 Checking roles for user: " + user.getName());
        user.getRoles().forEach(r -> System.out.println("   - Role: " + r.getRoleName()));

        return user.getRoles().stream()
                .map(r -> r.getRoleName().toUpperCase())
                .anyMatch(rn -> rn.equals("ADMIN")
                        || rn.equals("DOCUMENT_MANAGER")
                        || rn.equals("RESTRICTED_DOC_ACCESS"));
    }

    public List<DocumentCategoryDTO> getDocumentsForUser(AshokaTeam user) {
        boolean hasAccess = userHasRestrictedAccess(user); // admins/managers/restricted
        System.out.println("🟢 User has access to restricted docs: " + hasAccess);

        // Fetch documents from repository
        List<DocumentCategoryEntity> docs = documentCategoryRepository.findAllAccessible(hasAccess);

        System.out.println("🟢 Fetched " + docs.size() + " documents from repository");
        for (DocumentCategoryEntity d : docs) {
            System.out.println("   - " + d.getDocumentName() + ", restricted=" + d.isRestricted() + ", deleted=" + d.isDeleted());
        }

        return docs.stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }
    public AshokaTeam getLoggedInUserFromAuth(Authentication authentication) {
        if (authentication == null) return null;

        // Use authentication.getName() directly
        String username = authentication.getName();

        if (username == null || username.equalsIgnoreCase("anonymousUser")) {
            return null;
        }

        AshokaTeam user = userRepository.findByUsername(username).orElse(null);

        if (user == null) {
            System.out.println("🔴 No AshokaTeam found for username: " + username);
        } else {
            System.out.println("🟢 Logged-in user found in service: " + user.getName() + ", ID: " + user.getUserId());
        }

        return user;
    }
}












