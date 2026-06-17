package com.vistaluxhms.repository;

import com.vistaluxhms.entity.EmailConfigEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EmailConfigRepository extends JpaRepository<EmailConfigEntity, Integer> {
    EmailConfigEntity findTopByOrderByIdAsc();
}
