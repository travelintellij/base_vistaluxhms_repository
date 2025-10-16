package com.vistaluxhms.entity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "asset_transfer_history")
public class AssetTransferHistory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @ManyToOne
    @JoinColumn(name = "asset_id")
    private AssetEntity asset;

    @ManyToOne
    @JoinColumn(name = "from_ashokateam_id", nullable = true)
    private AshokaTeam fromAshokaTeam;

    @ManyToOne
    @JoinColumn(name = "to_ashokateam_id")
    private AshokaTeam toAshokaTeam;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "transfer_date")
    private Date transferDate;

    private String remarks;



    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public AssetEntity getAsset() {
        return asset;
    }

    public void setAsset(AssetEntity asset) {
        this.asset = asset;
    }

    public AshokaTeam getFromAshokaTeam() {
        return  fromAshokaTeam;
    }

    public void setFromAshokaTeam(AshokaTeam fromAshokaTeam) {
        this.fromAshokaTeam = fromAshokaTeam;
    }

    public AshokaTeam getToAshokaTeam() {
        return toAshokaTeam;
    }

    public void setToAshokaTeam(AshokaTeam toAshokaTeam) {
        this.toAshokaTeam = toAshokaTeam;
    }

    public Date getTransferDate() {
        return transferDate;
    }

    public void setTransferDate(Date transferDate) {
        this.transferDate = transferDate;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }
}


