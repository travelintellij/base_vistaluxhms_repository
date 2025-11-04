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
            "AND (:categoryId IS NULL OR a.category.categoryId = :categoryId) " +
            "AND (:ownerId IS NULL OR a.ownerId = :ownerId)")
    Page<AssetEntity> findFilteredAssets(
            @Param("assetCode") String assetCode,
            @Param("assetName") String assetName,
            @Param("categoryId") Integer categoryId,
            @Param("ownerId") Integer ownerId,
            Pageable pageable);




    List<AssetEntity> findByIsActive(boolean isActive);

    @Query("SELECT a FROM AssetEntity a WHERE a.deleted = false " +
            "AND a.isActive = :showActive " +
            "AND (:assetCode IS NULL OR a.assetCode LIKE CONCAT('%', :assetCode, '%')) " +
            "AND (:assetName IS NULL OR a.assetName LIKE CONCAT('%', :assetName, '%')) " +
            "AND (:categoryId IS NULL OR a.category.categoryId = :categoryId) " +
            "AND (:ownerId IS NULL OR a.ownerId = :ownerId)")
    Page<AssetEntity> findFilteredAssetsByStatus(
            @Param("assetCode") String assetCode,
            @Param("assetName") String assetName,
            @Param("categoryId") Integer categoryId,
            @Param("ownerId") Integer ownerId,
            @Param("showActive") boolean showActive,
            Pageable pageable);


    @Query("SELECT a FROM AssetEntity a WHERE a.ownerId = :userId AND a.deleted = false")
    List<AssetEntity> findByOwnerIdAndDeletedFalse(@Param("userId") Integer userId);
}

