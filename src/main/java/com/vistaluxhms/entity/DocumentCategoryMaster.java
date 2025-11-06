package com.vistaluxhms.entity;

import javax.persistence.*;

@Entity
@Table(name = "document_categories_master")
public class DocumentCategoryMaster {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "category_name", nullable = false)
    private String categoryName;

    @Column(name = "description", length = 500)
    private String description;

    @Column(name = "status", nullable = false)
    private String status = "Active";

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }


    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }

    public String getCategoryName() {
        return categoryName;
    }
    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
}

