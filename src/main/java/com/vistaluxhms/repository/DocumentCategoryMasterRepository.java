package com.vistaluxhms.repository;

import com.vistaluxhms.entity.DocumentCategoryMaster;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;



@Repository
public interface DocumentCategoryMasterRepository extends JpaRepository<DocumentCategoryMaster, Integer> {


    List<DocumentCategoryMaster> findByStatus(String status);



}