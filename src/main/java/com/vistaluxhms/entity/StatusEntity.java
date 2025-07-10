package com.vistaluxhms.entity;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.List;

@Entity
@Table(name = "status_master")
public class StatusEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "statusId")
    private Integer statusId;

    @Column(name = "status_Obj", nullable = false)
    private String statusObj;

    @Column(name = "status_Obj_type")
    private String statusObjectType;

    @Column(name = "statusName")
    private String statusName;


    @Column(name = "active")
    private Boolean active = true;

    public Integer getStatusId() {
        return statusId;
    }

    public void setStatusId(Integer statusId) {
        this.statusId = statusId;
    }

    public String getStatusObj() {
        return statusObj;
    }

    public void setStatusObj(String statusObj) {
        this.statusObj = statusObj;
    }

    public String getStatusObjectType() {
        return statusObjectType;
    }

    public void setStatusObjectType(String statusObjectType) {
        this.statusObjectType = statusObjectType;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }
}
