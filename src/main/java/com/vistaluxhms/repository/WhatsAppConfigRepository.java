package com.vistaluxhms.repository;

import com.vistaluxhms.entity.WhatsAppConfigEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface WhatsAppConfigRepository extends JpaRepository<WhatsAppConfigEntity, Integer> {
    WhatsAppConfigEntity findTopByOrderByIdAsc();
}
