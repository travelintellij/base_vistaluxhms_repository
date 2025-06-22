package com.vistaluxhms.services;

import com.vistaluxevent.entity.EventMasterServiceEntity;
import com.vistaluxhms.entity.LeadFreeHandQuotationEntity;
import com.vistaluxhms.entity.LeadFreeHandQuotationRoomDetailsEntity;
import com.vistaluxhms.entity.LeadSystemQuotationEntity;
import com.vistaluxhms.entity.LeadSystemQuotationRoomDetailsEntity;
import com.vistaluxhms.model.LeadSystemQuotationEntityDTO;
import com.vistaluxhms.model.LeadSystemQuotationRoomDetailsEntityDTO;
import com.vistaluxhms.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class LeadQuotationServiceImpl {

    @Autowired
    LeadSystemQuotationRepository leadSystemQuotationRepository;

    @Autowired
    private LeadSystemQuotationRepository quotationRepository;

    @Autowired
    private LeadFreeHandQuotationRepository  freeHandQuotationRepository;


    @Autowired
    LeadSystemQuotationRoomDetailsRepository roomDetailsRepository;

    @Autowired
    LeadFreeHandQuotationRoomDetailsRepository fhRoomDetailsRepository;

    public LeadSystemQuotationEntity createQuotationWithRooms(LeadSystemQuotationEntity quotation) {
        // Save parent; children are saved because of CascadeType.ALL
        return quotationRepository.save(quotation);
    }

    public List<LeadSystemQuotationEntity> findLeadSystemQuotations(Long leadId){
        return quotationRepository.findByLeadEntity_LeadIdOrderByVersionIdDesc(leadId);
    }

    public List<LeadFreeHandQuotationEntity> findLeadFreeHandQuotations(Long leadId){
        return freeHandQuotationRepository.findByLeadEntity_LeadIdOrderByVersionIdDesc(leadId);
    }

    public Integer findMaxVersionIdOfQuotationByLeadId(Long leadId){
        return quotationRepository.findMaxVersionIdOfQuotationByLeadId(leadId);
    }

    public LeadSystemQuotationEntity findLeadSystemQuotationByID(Long lsqid){
        Optional<LeadSystemQuotationEntity> leadSystemQuotationEntity = quotationRepository.findById(lsqid);
        if(leadSystemQuotationEntity.isPresent()){
            return leadSystemQuotationEntity.get();
        }
        return null;
    }

    public void deleteRoomDetails(List<LeadSystemQuotationRoomDetailsEntity> roomDetailsList) {
        roomDetailsRepository.deleteAll(roomDetailsList);
    }

    public void deleteFHRoomDetails(List<LeadFreeHandQuotationRoomDetailsEntity> roomDetailsList) {
        fhRoomDetailsRepository.deleteAll(roomDetailsList);
    }

    public void deleteRoomDetails(Long lsqrd) {
        roomDetailsRepository.deleteById(lsqrd);
    }

    public LeadFreeHandQuotationEntity findLeadFreeHandQuotationByID(Long lfhqid){
        Optional<LeadFreeHandQuotationEntity> leadFreeHandQuotationEntityQuotationEntity = freeHandQuotationRepository.findById(lfhqid);
        if(leadFreeHandQuotationEntityQuotationEntity.isPresent()){
            return leadFreeHandQuotationEntityQuotationEntity.get();
        }
        return null;
    }

    public LeadFreeHandQuotationEntity createFHQuotationWithRooms(LeadFreeHandQuotationEntity quotation) {
        // Save parent; children are saved because of CascadeType.ALL
        return freeHandQuotationRepository.save(quotation);
    }

    public Integer findMaxVersionIdOfFHQuotationByLeadId(Long leadId){
        return freeHandQuotationRepository.findMaxVersionIdOfQuotationByLeadId(leadId);
    }


    public LeadFreeHandQuotationEntity createLeadFHQuotationWithRooms(LeadFreeHandQuotationEntity quotation) {
        // Save parent; children are saved because of CascadeType.ALL
        return freeHandQuotationRepository.save(quotation);
    }


}
