package com.vistaluxhms.model.ratecard;

import java.util.List;
import java.util.Map;

public class SessionRateMapHelperDTO {

    private List<Map<String, Object>> sessionDetailsList;



    public List<Map<String, Object>> getSessionDetailsList() {
        return sessionDetailsList;
    }

    public void setSessionDetailsList(List<Map<String, Object>> sessionDetailsList) {
        this.sessionDetailsList = sessionDetailsList;
    }
}
