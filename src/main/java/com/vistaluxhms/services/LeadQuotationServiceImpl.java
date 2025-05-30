package com.vistaluxhms.services;

import com.vistaluxevent.entity.EventMasterServiceEntity;
import com.vistaluxhms.entity.LeadSystemQuotationEntity;
import com.vistaluxhms.entity.LeadSystemQuotationRoomDetailsEntity;
import com.vistaluxhms.repository.LeadEntityRepository;
import com.vistaluxhms.repository.LeadSystemQuotationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LeadQuotationServiceImpl {

    @Autowired
    LeadSystemQuotationRepository leadSystemQuotationRepository;

    @Autowired
    private LeadSystemQuotationRepository quotationRepository;

    public LeadSystemQuotationEntity createQuotationWithRooms(LeadSystemQuotationEntity quotation) {
        // Save parent; children are saved because of CascadeType.ALL
        return quotationRepository.save(quotation);
    }

    public List<LeadSystemQuotationEntity> findLeadSystemQuotations(Long leadId){
        return quotationRepository.findByLeadEntity_LeadIdOrderByVersionIdDesc(leadId);
    }

    public Integer findMaxVersionIdOfQuotationByLeadId(Long leadId){
        return quotationRepository.findMaxVersionIdOfQuotationByLeadId(leadId);
    }

}
