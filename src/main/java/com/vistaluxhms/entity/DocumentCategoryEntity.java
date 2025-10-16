package com.vistaluxhms.entity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "document_category")
public class DocumentCategoryEntity {



    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "document_id")
    private Integer documentId;

    @ManyToOne
    @JoinColumn(name = "category_id", referencedColumnName = "id")
    private DocumentCategoryMaster category;


    @Column(name = "category_name")
    private String categoryName;

    @Column(name = "file_name")
    private String fileName;

    @Column(name = "file_type")
    private String fileType;

    @Column(name = "file_size")
    private Long fileSize;

    @Column(name = "uploaded_by")
    private Integer uploadedBy;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "uploaded_date")
    private Date uploadedDate;

    @Lob
    @Column(name = "file_data")
    private byte[] fileData;

    @Column(name= "is_deleted")
    private boolean deleted = false;

    @Column(name = "restricted", nullable = false)
    private boolean restricted = false;


    public Integer getDocumentId() {
        return documentId;
    }
    public void setDocumentId(Integer documentId) {
        this.documentId = documentId;
    }

    public String getCategoryName() {
        return categoryName;
    }
    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getFileName() {
        return fileName;
    }
    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getFileType() {
        return fileType;
    }
    public void setFileType(String fileType) {
        this.fileType = fileType;
    }

    public Long getFileSize() {
        return fileSize;
    }
    public void setFileSize(Long fileSize) {
        this.fileSize = fileSize;
    }

    public Integer getUploadedBy() {
        return uploadedBy;
    }
    public void setUploadedBy(Integer uploadedBy) {
        this.uploadedBy = uploadedBy;
    }

    public Date getUploadedDate() {
        return uploadedDate;
    }
    public void setUploadedDate(Date uploadedDate) {
        this.uploadedDate = uploadedDate;
    }

    public byte[] getFileData() {
        return fileData;
    }
    public void setFileData(byte[] fileData) {
        this.fileData = fileData;
    }


    public boolean isDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }

    public boolean isRestricted() {
        return restricted;
    }

    public void setRestricted(boolean restricted) {
        this.restricted = restricted;
    }

    public DocumentCategoryMaster getCategory() {
        return category;
    }

    public void setCategory(DocumentCategoryMaster category) {
        this.category = category;
    }
}

