package com.vistaluxhms.services;

import com.vistaluxevent.entity.EventMasterServiceEntity;
import com.vistaluxhms.entity.LeadFreeHandQuotationEntity;
import com.vistaluxhms.entity.LeadSystemQuotationEntity;
import com.vistaluxhms.entity.LeadSystemQuotationRoomDetailsEntity;
import com.vistaluxhms.model.LeadSystemQuotationEntityDTO;
import com.vistaluxhms.model.LeadSystemQuotationRoomDetailsEntityDTO;
import com.vistaluxhms.repository.LeadEntityRepository;
import com.vistaluxhms.repository.LeadFreeHandQuotationRepository;
import com.vistaluxhms.repository.LeadSystemQuotationRepository;
import com.vistaluxhms.repository.LeadSystemQuotationRoomDetailsRepository;
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

    public void deleteRoomDetails(Long lsqrd) {
        roomDetailsRepository.deleteById(lsqrd);
    }

}
