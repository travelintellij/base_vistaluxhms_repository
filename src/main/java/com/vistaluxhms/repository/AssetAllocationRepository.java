package com.vistaluxhms.repository;

import com.vistaluxhms.entity.AssetAllocation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AssetAllocationRepository extends JpaRepository<AssetAllocation, Integer> {




    AssetAllocation findTopByAsset_AssetIdOrderByAllocatedDateDesc(int assetId);

    List<AssetAllocation> findByAsset_AssetIdOrderByAllocatedDateDesc(int assetId);



    AssetAllocation findTopByAsset_AssetIdAndAshokaTeam_UserIdOrderByAllocatedDateDesc(
            Integer assetId, Integer userId);

    @Query("Select a FROM AssetAllocation a WHERE a.asset.assetId = :assetId ORDER BY a.allocatedDate DESC, a.allocationId DESC")
    List<AssetAllocation> findLatestAllocationForAsset(@Param("assetId") Integer assetId);
    @Query("SELECT aa FROM AssetAllocation aa JOIN FETCH aa.ashokaTeam WHERE aa.asset.assetId = :assetId ORDER BY aa.allocatedDate DESC, aa.allocationId DESC")
    List<AssetAllocation> findByAssetWithAshokaTeam(@Param("assetId") int assetId);
}

