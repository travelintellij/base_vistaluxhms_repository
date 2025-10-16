package com.vistaluxhms.repository;

import com.vistaluxhms.entity.AssetTransferHistory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AssetTransferHistoryRepository extends JpaRepository<AssetTransferHistory, Integer> {

    List<AssetTransferHistory> findByAsset_AssetIdOrderByTransferDateDesc(Integer assetId);
}
