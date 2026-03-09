package com.vistaluxhms.entity; // package declaration for entity layer
import javax.persistence.*;


import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.Objects;


@Entity // marks this class as a JPA entity mapped to a database table
@Table(name = "dsr") // specify the table name in MySQL
public class Dsr {

    @Id // primary key of the table
    @GeneratedValue(strategy = GenerationType.IDENTITY) // auto-increment ID
    private Long dsrId; // unique identifier for each DSR entry

    @Column(nullable = false) // cannot be null
    private Date visitDate; // date of visit

    @Column(nullable = false)
    private Long salesPartnerId; // foreign key reference to sales_partner table

    @Column(nullable = false, columnDefinition = "TEXT")
    private String outcome; // description of visit result

    @Column(columnDefinition = "TEXT")
    private String nextSteps; // follow-up or next action items

    @Column(nullable = false)
    private Double dealAmount; // potential deal value

    @Column(nullable = false)
    private String status = "Pending"; // status of report (Pending/Approved/Rejected)

    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt = LocalDateTime.now(); // auto-set at creation

    @Column(nullable = false)
    private LocalDateTime updatedAt = LocalDateTime.now(); // auto-updated

    // Getter and Setter methods for all fields (to access private variables)
    public Long getDsrId() { return dsrId; }
    public void setDsrId(Long dsrId) { this.dsrId = dsrId; }

    public Date getVisitDate() { return visitDate; }
    public void setVisitDate(Date visitDate) { this.visitDate = visitDate; }

    public Long getSalesPartnerId() { return salesPartnerId; }
    public void setSalesPartnerId(Long salesPartnerId) { this.salesPartnerId = salesPartnerId; }

    public String getOutcome() { return outcome; }
    public void setOutcome(String outcome) { this.outcome = outcome; }

    public String getNextSteps() { return nextSteps; }
    public void setNextSteps(String nextSteps) { this.nextSteps = nextSteps; }

    public Double getDealAmount() { return dealAmount; }
    public void setDealAmount(Double dealAmount) { this.dealAmount = dealAmount; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
}
