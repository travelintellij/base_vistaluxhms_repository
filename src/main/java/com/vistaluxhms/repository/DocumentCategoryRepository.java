package com.vistaluxhms.repository;

import com.vistaluxhms.entity.DocumentCategoryEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DocumentCategoryRepository extends JpaRepository<DocumentCategoryEntity, Integer> {

    @Query("SELECT d FROM DocumentCategoryEntity d WHERE d.deleted = false")
    List<DocumentCategoryEntity> findAllActive();

    List<DocumentCategoryEntity> findByRestrictedFalseAndDeletedFalse();

    List<DocumentCategoryEntity> findByDeletedFalse();

    List<DocumentCategoryEntity> findByCategory_Id(Integer categoryId);
}



