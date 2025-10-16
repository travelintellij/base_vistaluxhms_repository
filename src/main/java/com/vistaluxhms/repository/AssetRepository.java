package com.vistaluxhms.repository;

import com.vistaluxhms.entity.AssetEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

@Repository
public interface AssetRepository extends JpaRepository<AssetEntity, Integer> {

    Optional<AssetEntity> findByAssetCode(String assetCode);


    List<AssetEntity> findByDeletedFalse();


    Optional<AssetEntity> findByAssetCodeAndDeletedFalse(String assetCode);


    @Query("SELECT a FROM AssetEntity a WHERE a.deleted = false " +

            "AND (:assetCode IS NULL OR a.assetCode LIKE CONCAT('%', :assetCode, '%')) " +
            "AND (:assetName IS NULL OR a.assetName LIKE CONCAT('%', :assetName, '%')) " +
            "AND (:category IS NULL OR a.category = :category) " +
            "AND (:ownerId IS NULL OR a.ownerId = :ownerId)")
    Page<AssetEntity> findFilteredAssets(
            @Param("assetCode") String assetCode,
            @Param("assetName") String assetName,
            @Param("category") String category,
            @Param("ownerId") Integer ownerId,
            Pageable pageable);

    Page<AssetEntity> findByDeletedFalseAndOwnerIdAndCategory(Integer ownerId,String category, Pageable pageable);


}