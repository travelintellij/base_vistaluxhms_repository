package com.vistaluxhms.services;

import com.vistaluxhms.entity.*;
import com.vistaluxhms.model.AssetDTO;
import com.vistaluxhms.model.TransferDTO;
import com.vistaluxhms.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class AssetServiceImpl {

    @Autowired
    private AssetRepository assetRepository;

    @Autowired
    private AssetAllocationRepository assetAllocationRepository;

    @Autowired
    private AssetTransferHistoryRepository assetTransferHistoryRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private CategoryRepository categoryRepository;


    public boolean isOwnedByUser(Integer assetId, Integer userId) {
        Optional<AssetEntity> assetOpt = assetRepository.findById(assetId);
        if (assetOpt.isPresent()) {
            return assetOpt.get().getOwnerId().equals(userId);
        }
        return false;}

    public AssetDTO saveAsset(AssetDTO assetDTO) {
        AssetEntity entity = new AssetEntity();


        entity.setAssetId(assetDTO.getAssetId());
        entity.setAssetName(assetDTO.getAssetName());

        entity.setCreationDate(new Date());
        entity.setAssetCost(assetDTO.getAssetCost());
        entity.setCategory(assetDTO.getCategory());
        entity.setActive(assetDTO.isActive());
        entity.setOwnerId(assetDTO.getAssetOwnerId());


        entity = assetRepository.save(entity);

        if (entity.getAssetCode() == null || entity.getAssetCode().trim().isEmpty()) {
            String code = String.format("AST-%04d", entity.getAssetId());
            entity.setAssetCode(code);
            assetRepository.save(entity);
        }


        if (assetDTO.getAssetOwnerId() != null) {
            AshokaTeam member = userRepository.findById(assetDTO.getAssetOwnerId()).orElse(null);
            if (member != null) {
                AssetAllocation allocation = new AssetAllocation();
                allocation.setAsset(entity);
                allocation.setAshokaTeam(member);
                allocation.setAllocatedDate(new Date());
                assetAllocationRepository.save(allocation);

                AssetTransferHistory transfer = new AssetTransferHistory();
                transfer.setAsset(entity);
                transfer.setFromAshokaTeam(null);
                transfer.setToAshokaTeam(member);
                transfer.setTransferDate(new Date());
                transfer.setRemarks("Initial allocation");
                assetTransferHistoryRepository.save(transfer);
            }
        }

        assetDTO.setAssetId(entity.getAssetId());
        assetDTO.setAssetCode(entity.getAssetCode());
        return assetDTO;
    }

    public List<AssetDTO> getAllAssets() {
        return assetRepository.findByDeletedFalse()
                .stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    private AssetDTO convertToDTO(AssetEntity entity) {
        AssetDTO dto = new AssetDTO();
        dto.setAssetId(entity.getAssetId());
        dto.setAssetName(entity.getAssetName());
        dto.setAssetCost(entity.getAssetCost());
        dto.setCategory(entity.getCategory());
        dto.setActive(entity.isActive());
        dto.setAssetCode(entity.getAssetCode());


        if (entity.getCreationDate() != null) {
            if (entity.getCreationDate() instanceof java.sql.Date) {
                dto.setCreationDate(((java.sql.Date) entity.getCreationDate()).toLocalDate());
            } else {
                dto.setCreationDate(entity.getCreationDate()
                        .toInstant()
                        .atZone(java.time.ZoneId.systemDefault())
                        .toLocalDate());
            }
        }

        if (entity.getOwnerId() != null) {
            AshokaTeam owner = userRepository.findById(entity.getOwnerId()).orElse(null);
            dto.setAssetOwnerId(entity.getOwnerId());
            dto.setAssetOwnerName(owner != null ? owner.getName() : "Unallocated");


            AssetAllocation latestAllocation =
                    assetAllocationRepository.findTopByAsset_AssetIdAndAshokaTeam_UserIdOrderByAllocatedDateDesc(
                            entity.getAssetId(),
                            entity.getOwnerId()
                    );

            if (latestAllocation != null) {
                dto.setAllocatedDate(latestAllocation.getAllocatedDate());
            } else {
                dto.setAllocatedDate(null);
            }
        } else {
            dto.setAssetOwnerId(null);
            dto.setAssetOwnerName("Unallocated");
            dto.setAllocatedDate(null);
        }
        return dto;
    }


    public void allocateAsset(int assetId, int ashokaTeamId) {
        AssetEntity asset = assetRepository.findById(assetId).orElse(null);
        AshokaTeam member = userRepository.findById(ashokaTeamId).orElse(null);

        if (asset != null && member!= null) {
            AssetAllocation allocation = new AssetAllocation();
            allocation.setAsset(asset);
            allocation.setAshokaTeam(member);
            allocation.setAllocatedDate(new Date());
            assetAllocationRepository.save(allocation);

            AssetTransferHistory transfer = new AssetTransferHistory();
            transfer.setAsset(asset);
            transfer.setFromAshokaTeam(null);
            transfer.setToAshokaTeam(member);
            transfer.setTransferDate(new Date());
            transfer.setRemarks("Allocation");
            assetTransferHistoryRepository.save(transfer);
        }
    }
    public void transferAsset(TransferDTO dto) {
        AssetEntity asset = assetRepository.findById(dto.getAssetId()).orElse(null);
        AshokaTeam toMember = userRepository.findById(dto.getToAshokaTeamId()).orElse(null);
        AshokaTeam fromMember = userRepository.findById(dto.getFromAshokaTeamId()).orElse(null);

        if (asset != null && toMember != null) {

            AssetTransferHistory transfer = new AssetTransferHistory();
            transfer.setAsset(asset);
            transfer.setFromAshokaTeam(fromMember);
            transfer.setToAshokaTeam(toMember);
            transfer.setTransferDate(dto.getTransferDate() != null ? dto.getTransferDate() : new Date());
            transfer.setRemarks(dto.getRemarks());
            assetTransferHistoryRepository.save(transfer);

            AssetAllocation newAlloc = new AssetAllocation();
            newAlloc.setAsset(asset);
            newAlloc.setAshokaTeam(toMember);
            newAlloc.setAllocatedDate(dto.getTransferDate() != null ? dto.getTransferDate() : new Date());
            assetAllocationRepository.save(newAlloc);

            asset.setOwnerId(toMember.getUserId());
            assetRepository.save(asset);
        }
    }
    public List<AssetAllocation> getAllAllocationsForAsset(int assetId) {
        return assetAllocationRepository.findByAsset_AssetIdOrderByAllocatedDateDesc(assetId);
    }

    public AssetEntity getAssetById(int assetId) {
        return assetRepository.findById(assetId).orElse(null);
    }

    public Optional<AssetEntity> findByAssetCode(String assetCode) {
        return assetRepository.findByAssetCodeAndDeletedFalse(assetCode);
    }
    public void softDeleteAsset(int assetId) {
        AssetEntity asset = assetRepository.findById(assetId).orElse(null);
        if (asset != null) {
            asset.setisDeleted(true);
            assetRepository.save(asset);
        }

    }

    public Page<AssetEntity> filterAssets(String assetCode, String assetName,
                                          String category, Integer ownerId,
                                          int page, int pageSize, String sortBy) {
        Pageable pageable = PageRequest.of(page, pageSize, Sort.by(sortBy));


        if (ownerId != null && ownerId == 0) ownerId = null;
        if (category != null && category.trim().isEmpty()) category = null;
        if (assetCode != null && assetCode.trim().isEmpty()) assetCode = null;
        if (assetName != null && assetName.trim().isEmpty()) assetName = null;


        return assetRepository.findFilteredAssets(assetCode, assetName, category, ownerId, pageable);
    }
    public List<String> getAllCategories() {

        return categoryRepository.findAll()
                .stream()
                .map(Category::getCategoryName)
                .collect(Collectors.toList());
    }
    public List<AssetDTO> convertToDTO(List<AssetEntity> entities) {
        return entities.stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }
    public List<AshokaTeam> getAllAshokaTeamMembers() {
        return userRepository.findAllActiveUsers();
    }

}

