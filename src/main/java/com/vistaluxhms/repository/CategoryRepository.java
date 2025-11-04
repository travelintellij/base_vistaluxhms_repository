package com.vistaluxhms.repository;

import com.vistaluxhms.entity.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Integer> {


    @Query("SELECT c FROM Category c WHERE c.status = 'Active'")
    List<Category> findActiveCategories();


    List<Category> findByStatus(String status);
}

