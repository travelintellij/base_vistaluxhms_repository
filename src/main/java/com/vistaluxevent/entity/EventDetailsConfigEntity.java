package com.vistaluxevent.entity;

import com.vistaluxevent.model.EventMasterServiceDTO;
import com.vistaluxhms.util.EventType;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "event_details")
public class EventDetailsConfigEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    @Column(name = "event_type", length = 50, unique = true, nullable = false)
    private EventType eventType;

    @Lob
    @Column(name = "banner_image", columnDefinition = "LONGBLOB")
    private byte[] bannerImage;

    @Column(name = "banner_mime_type")
    private String bannerMimeType;

    @Column(name = "resort_info", columnDefinition = "TEXT")
    private String resortInfo;

    @Column(name = "celebration_highlight", columnDefinition = "TEXT")
    private String celebrationHighlight;

    @Column(name = "testimonial", columnDefinition = "TEXT")
    private String testimonial;

    @Column(name = "terms_conditions", columnDefinition = "TEXT")
    private String termsConditions;

    @Column(name = "created_at")
    private LocalDateTime createdAt = LocalDateTime.now();

    @Column(name = "updated_at")
    private LocalDateTime updatedAt = LocalDateTime.now();

    @OneToMany(mappedBy = "eventDetails", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<EventImageConfigEntity> images = new ArrayList<>();

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public EventType getEventType() {
        return eventType;
    }

    public void setEventType(EventType eventType) {
        this.eventType = eventType;
    }

    public byte[] getBannerImage() {
        return bannerImage;
    }

    public void setBannerImage(byte[] bannerImage) {
        this.bannerImage = bannerImage;
    }

    public String getBannerMimeType() {
        return bannerMimeType;
    }

    public void setBannerMimeType(String bannerMimeType) {
        this.bannerMimeType = bannerMimeType;
    }

    public String getResortInfo() {
        return resortInfo;
    }

    public void setResortInfo(String resortInfo) {
        this.resortInfo = resortInfo;
    }

    public String getCelebrationHighlight() {
        return celebrationHighlight;
    }

    public void setCelebrationHighlight(String celebrationHighlight) {
        this.celebrationHighlight = celebrationHighlight;
    }

    public String getTestimonial() {
        return testimonial;
    }

    public void setTestimonial(String testimonial) {
        this.testimonial = testimonial;
    }

    public String getTermsConditions() {
        return termsConditions;
    }

    public void setTermsConditions(String termsConditions) {
        this.termsConditions = termsConditions;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public List<EventImageConfigEntity> getImages() {
        return images;
    }

    public void setImages(List<EventImageConfigEntity> images) {
        this.images = images;
    }
}

