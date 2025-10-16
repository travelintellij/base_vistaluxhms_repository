package com.vistaluxhms.repository;

import com.vistaluxhms.entity.DocumentCategoryMaster;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DocumentCategoryMasterRepository extends JpaRepository<DocumentCategoryMaster, Integer> {

}