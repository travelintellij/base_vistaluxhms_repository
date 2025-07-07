package com.vistaluxhms.entity;

import javax.persistence.*;

@Entity
@Table(name = "travel_claim_bills")
public class TravelClaimBillEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // The binary bill file
    @Lob
    @Column(name = "bill_file", nullable = false)
    private byte[] billFile;

    @Column(name = "file_name")
    private String fileName;

    @Column(name = "file_type")
    private String fileType;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "travelClaimId", nullable = false)
    private MyTravelClaimsEntity claim;

    // getters and setters

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public byte[] getBillFile() {
        return billFile;
    }

    public void setBillFile(byte[] billFile) {
        this.billFile = billFile;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getFileType() {
        return fileType;
    }

    public void setFileType(String fileType) {
        this.fileType = fileType;
    }

    public MyTravelClaimsEntity getClaim() {
        return claim;
    }

    public void setClaim(MyTravelClaimsEntity claim) {
        this.claim = claim;
    }
}
