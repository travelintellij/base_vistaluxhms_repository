package com.vistaluxhms.services;

import com.vistaluxevent.entity.EventMasterServiceEntity;
import com.vistaluxhms.entity.LeadSystemQuotationEntity;
import com.vistaluxhms.repository.LeadEntityRepository;
import com.vistaluxhms.repository.LeadSystemQuotationRepository;
import org.springframework.beans.factory.annotation.Autowired;

public class LeadQuotationServiceImpl {

    @Autowired
    LeadSystemQuotationRepository leadSystemQuotationRepository;

    public void saveLeadSystemQuotation(LeadSystemQuotationEntity leadSystemQuotationEntity){
        leadSystemQuotationRepository.save(leadSystemQuotationEntity);
    }
}
