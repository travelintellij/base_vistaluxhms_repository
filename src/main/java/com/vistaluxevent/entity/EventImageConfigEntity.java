package com.vistaluxevent.entity;

import com.vistaluxevent.model.EventMasterServiceDTO;
import com.vistaluxhms.util.EventType;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Arrays;


@Entity
@Table(name = "event_images",
        uniqueConstraints = @UniqueConstraint(columnNames = {"event_id", "image_index"}))
public class EventImageConfigEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "event_id", nullable = false)
    private EventDetailsConfigEntity eventDetails;

    @Column(name = "image_index", nullable = false)
    private int imageIndex;    // 1..6

    @Lob
    @Column(name = "image_data", columnDefinition = "LONGBLOB")
    private byte[] imageData;

    @Column(name = "mime_type")
    private String mimeType;

    @Column(name = "image_url")
    private String imageUrl;

    @Column(name = "uploaded_at")
    private LocalDateTime uploadedAt = LocalDateTime.now();

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public EventDetailsConfigEntity getEventDetails() {
        return eventDetails;
    }

    public void setEventDetails(EventDetailsConfigEntity eventDetails) {
        this.eventDetails = eventDetails;
    }

    public int getImageIndex() {
        return imageIndex;
    }

    public void setImageIndex(int imageIndex) {
        this.imageIndex = imageIndex;
    }

    public byte[] getImageData() {
        return imageData;
    }

    public void setImageData(byte[] imageData) {
        this.imageData = imageData;
    }

    public String getMimeType() {
        return mimeType;
    }

    public void setMimeType(String mimeType) {
        this.mimeType = mimeType;
    }

    public LocalDateTime getUploadedAt() {
        return uploadedAt;
    }

    public void setUploadedAt(LocalDateTime uploadedAt) {
        this.uploadedAt = uploadedAt;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    @Override
    public String toString() {
        return "EventImageConfigEntity{" +
                "id=" + id +
                ", eventDetails=" + eventDetails +
                ", imageIndex=" + imageIndex +
                ", mimeType='" + mimeType + '\'' +
                ", imageUrl='" + imageUrl + '\'' +
                ", uploadedAt=" + uploadedAt +
                '}';
    }
}
