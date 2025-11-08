package com.vistaluxhms.services;

import com.vistaluxhms.entity.AshokaTeam;
import com.vistaluxhms.entity.DocumentCategoryEntity;
import com.vistaluxhms.entity.DocumentCategoryMaster;
import com.vistaluxhms.model.DocumentCategoryDTO;
import com.vistaluxhms.repository.DocumentCategoryMasterRepository;
import com.vistaluxhms.repository.DocumentCategoryRepository;
import com.vistaluxhms.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
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
        entity.setUploadedBy(dto.getUploadedBy());
        entity.setUploadedDate(new Date());
        entity.setFileData(dto.getFileData());

        entity.setRestricted(dto.isRestricted());

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
        dto.setUploadedBy(entity.getUploadedBy());
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

    public List<DocumentCategoryDTO> getActiveDocuments(boolean isManager) {
        List<DocumentCategoryEntity> docs;
        if (isManager) {
            docs = documentCategoryRepository.findByDeletedFalse();
        } else {
            docs = documentCategoryRepository.findByRestrictedFalseAndDeletedFalse();
        }
        return docs.stream().map(this::convertToDTO).collect(Collectors.toList());
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
}















