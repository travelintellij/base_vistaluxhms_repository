package com.vistaluxhms.services;

import com.vistaluxhms.entity.*;
import com.vistaluxhms.model.ClientEntityDTO;
import com.vistaluxhms.repository.ClientEntityRepository;
import com.vistaluxhms.repository.MyTravelClaimsEntityRepository;
import com.vistaluxhms.repository.TravelClaimBillRepository;
import com.vistaluxhms.repository.Vlx_City_Master_Repository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.criteria.*;
import javax.transaction.Transactional;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Service
public class MyClaimsServicesImpl {
    @Autowired
    TravelClaimBillRepository travelClaimBillRepository;

    @Autowired
    MyTravelClaimsEntityRepository travelClaimRepository;

    @Transactional
    public MyTravelClaimsEntity saveClaimWithBills(MyTravelClaimsEntity claim, List<MultipartFile> files) throws IOException {
        MyTravelClaimsEntity savedClaim = travelClaimRepository.save(claim);

        for (MultipartFile file : files) {
            TravelClaimBillEntity bill = new TravelClaimBillEntity();
            bill.setClaim(savedClaim);
            bill.setFileName(file.getOriginalFilename());
            bill.setFileType(file.getContentType());
            bill.setBillFile(file.getBytes());

            travelClaimBillRepository.save(bill);
        }

        return savedClaim;
    }


}
