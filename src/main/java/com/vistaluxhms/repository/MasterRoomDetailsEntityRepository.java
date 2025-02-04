package com.vistaluxhms.repository;

import com.vistaluxhms.entity.ClientEntity;
import com.vistaluxhms.entity.MasterRoomDetailsEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MasterRoomDetailsEntityRepository extends JpaRepository<MasterRoomDetailsEntity, Integer>, JpaSpecificationExecutor<MasterRoomDetailsEntity> {

    // Custom Query: Find all active rooms
    List<MasterRoomDetailsEntity> findByActiveTrue();



    // Custom Query: Find rooms by category

}