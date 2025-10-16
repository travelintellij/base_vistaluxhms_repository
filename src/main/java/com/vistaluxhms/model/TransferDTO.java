package com.vistaluxhms.model;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class TransferDTO {
    private Integer assetId;
    private Integer fromAshokaTeamId;
    private Integer toAshokaTeamId;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date transferDate;
    private String remarks;

    public Integer getAssetId() { return assetId; }
    public void setAssetId(Integer assetId) { this.assetId = assetId; }

    public Integer getFromAshokaTeamId() { return fromAshokaTeamId; }
    public void setFromAshokaTeamId(Integer fromAshokaTeamId) { this.fromAshokaTeamId = fromAshokaTeamId;
    }

    public Integer getToAshokaTeamId() { return toAshokaTeamId; }
    public void setToAshokaTeamId(Integer toAshokaTeamId) { this.toAshokaTeamId = toAshokaTeamId; }

    public Date getTransferDate() { return transferDate; }
    public void setTransferDate(Date transferDate) { this.transferDate = transferDate; }

    public String getRemarks() { return remarks; }
    public void setRemarks(String remarks) { this.remarks = remarks; }
}

