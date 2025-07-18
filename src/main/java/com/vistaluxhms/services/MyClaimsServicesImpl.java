package com.vistaluxhms.services;

import com.vistaluxhms.entity.*;
import com.vistaluxhms.model.ClientEntityDTO;
import com.vistaluxhms.model.MyTravelClaimsDTO;
import com.vistaluxhms.repository.ClientEntityRepository;
import com.vistaluxhms.repository.MyTravelClaimsEntityRepository;
import com.vistaluxhms.repository.TravelClaimBillRepository;
import com.vistaluxhms.repository.Vlx_City_Master_Repository;
import com.vistaluxhms.util.VistaluxConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.criteria.*;
import javax.transaction.Transactional;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

@Service
public class MyClaimsServicesImpl {
    @Autowired
    TravelClaimBillRepository travelClaimBillRepository;

    @Autowired
    MyTravelClaimsEntityRepository travelClaimRepository;

    @Autowired
    StatusServiceImpl statusService;

    SimpleDateFormat formatter = new SimpleDateFormat("dd-MMM-yyyy");

    @Transactional
    public void saveOrUpdateClaim(MyTravelClaimsDTO dto, MultipartFile[] files) throws IOException {
        MyTravelClaimsEntity entity;

        if (dto.getTravelClaimId() != null) {
            entity = travelClaimRepository.findById(dto.getTravelClaimId())
                    .orElse(new MyTravelClaimsEntity());
        } else {
            entity = new MyTravelClaimsEntity();
        }

        mapDtoToEntity(dto, entity);

        // save claim first
        MyTravelClaimsEntity savedClaim = travelClaimRepository.save(entity);

        // clear old bills if updating
        if (savedClaim.getBills() != null) {
            savedClaim.getBills().clear();
        }

        if (files != null) {
            for (MultipartFile file : files) {
                if (!file.isEmpty()) {
                    TravelClaimBillEntity bill = new TravelClaimBillEntity();
                    bill.setClaim(savedClaim);
                    bill.setFileName(file.getOriginalFilename());
                    bill.setFileType(file.getContentType());
                    bill.setBillFile(file.getBytes());
                    savedClaim.getBills().add(bill);
                }
            }
        }

        travelClaimRepository.save(savedClaim);
    }

    private void mapDtoToEntity(MyTravelClaimsDTO dto, MyTravelClaimsEntity entity) {
        entity.setSource(dto.getSource());
        entity.setDestination(dto.getDestination());
        entity.setExpenseStartDate(dto.getExpenseStartDate());
        entity.setExpenseEndDate(dto.getExpenseEndDate());
        entity.setClaimDetails(dto.getClaimDetails());
        entity.setTravelMode(dto.getTravelMode());
        entity.setKms(dto.getKms());
        entity.setTravelExpense(dto.getTravelExpense());
        entity.setFoodExpense(dto.getFoodExpense());
        entity.setParkingExpense(dto.getParkingExpense());
        entity.setOtherExpense1(dto.getOtherExpense1());
        entity.setOtherExpense2(dto.getOtherExpense2());
        entity.setOtherExpense3(dto.getOtherExpense3());
        entity.setOtherExpensesDetails(dto.getOtherExpensesDetails());
        entity.setClaimentId(dto.getClaimentId());
        entity.setApproverId(dto.getApproverId());
        entity.setApproverRemarks(dto.getApproverRemarks());
        entity.setClaimStatus(dto.getClaimStatus());
    }


    public Page<MyTravelClaimsEntity> filterTravelClaims(MyTravelClaimsDTO searchTravelObj, Pageable pageable,boolean isAllowedAdmin) {
        //Pageable pageable = PageRequest.of(pageable., pageSize);

        return travelClaimRepository.findAll(new Specification<MyTravelClaimsEntity>() {
            private static final long serialVersionUID = 1L;

            @Override
            public Predicate toPredicate(Root<MyTravelClaimsEntity> travelClaimsEntityRoot, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<>();
                if (searchTravelObj.getTravelClaimId() != null && searchTravelObj.getTravelClaimId() != 0) {
                    predicates.add(criteriaBuilder.equal(travelClaimsEntityRoot.get("travelClaimId"), searchTravelObj.getTravelClaimId()));
                }
                if(!isAllowedAdmin) {
                    predicates.add(criteriaBuilder.equal(travelClaimsEntityRoot.get("claimentId"), searchTravelObj.getClaimentId()));
                }

                return criteriaBuilder.and(predicates.toArray(new Predicate[0]));
            }
        }, pageable);
    }

    public MyTravelClaimsEntity findTravelClaimById(Long travelClaimId){
        //return travelClaimRepository.findById(travelClaimId).get();

        return travelClaimRepository.findById(travelClaimId)
                .orElseThrow(() -> new IllegalArgumentException("Claim not found"));
    }

    public MyTravelClaimsDTO findTravelClaimDTOById(MyTravelClaimsDTO dto,Long travelClaimId){
        return mapEntityToDTO(dto,travelClaimRepository.findById(travelClaimId).get());
    }


    private MyTravelClaimsDTO mapEntityToDTO(MyTravelClaimsDTO dto,MyTravelClaimsEntity entity) {
        dto.setSource(entity.getSource());
        dto.setDestination(entity.getDestination());
        dto.setExpenseStartDate(entity.getExpenseStartDate());
        dto.setExpenseEndDate(entity.getExpenseEndDate());
        dto.setClaimDetails(entity.getClaimDetails());
        dto.setTravelMode(entity.getTravelMode());
        dto.setKms(entity.getKms());
        dto.setTravelExpense(entity.getTravelExpense());
        dto.setFoodExpense(entity.getFoodExpense());
        dto.setParkingExpense(entity.getParkingExpense());
        dto.setOtherExpense1(entity.getOtherExpense1());
        dto.setOtherExpense2(entity.getOtherExpense2());
        dto.setOtherExpense3(entity.getOtherExpense3());
        dto.setOtherExpensesDetails(entity.getOtherExpensesDetails());
        dto.setClaimentId(entity.getClaimentId());
        dto.setApproverId(entity.getApproverId());
        dto.setApproverRemarks(entity.getApproverRemarks());
        dto.setBillsEntity(entity.getBills());
        dto.setFormattedExpenseStartDate(formatter.format(entity.getExpenseStartDate()));
        dto.setFormattedExpenseEndDate(formatter.format(entity.getExpenseEndDate()));
        dto.setStatusName(statusService.findStatusById(entity.getClaimStatus()).getStatusName());
        dto.setTravelModeName(VistaluxConstants.CLAIM_TRAVEL_MODE.get(entity.getTravelMode()));
        int totalClaimAmount = entity.getTravelExpense() + entity.getFoodExpense() + entity.getParkingExpense() + entity.getOtherExpense1() + entity.getOtherExpense2() + entity.getOtherExpense3();
        dto.setTotalClaimAmount(totalClaimAmount);
        dto.setClaimStatus(entity.getClaimStatus());
        return dto;
    }

    public TravelClaimBillEntity findTravelClaimBillById(Long travelClaimBillId){
        return travelClaimBillRepository.findById(travelClaimBillId).get();
    }


    public void saveTravelClaimEntity(MyTravelClaimsEntity travelClaimsEntity){
        travelClaimRepository.save(travelClaimsEntity);
    }

    public void saveTravelClaimBill(TravelClaimBillEntity travelClaimBillEntity){
        travelClaimBillRepository.save(travelClaimBillEntity);
    }

    public void deleteAllTravelBills( List<TravelClaimBillEntity> travelClaimBillEntityList){
        travelClaimBillRepository.deleteAll(travelClaimBillEntityList);
    }
}
