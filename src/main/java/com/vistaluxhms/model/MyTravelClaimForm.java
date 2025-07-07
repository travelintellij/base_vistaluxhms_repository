package com.vistaluxhms.model;

import com.vistaluxhms.entity.MyTravelClaimsEntity;
import org.springframework.web.multipart.MultipartFile;

public class MyTravelClaimForm {
    private MyTravelClaimsDTO claim;
    private MultipartFile[] bills;

    public MyTravelClaimsDTO getClaim() {
        return claim;
    }

    public void setClaim(MyTravelClaimsDTO claim) {
        this.claim = claim;
    }

    public MultipartFile[] getBills() {
        return bills;
    }

    public void setBills(MultipartFile[] bills) {
        this.bills = bills;
    }
// getters & setters
}
