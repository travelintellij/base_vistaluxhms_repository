package com.vistaluxevent.model;

import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class EventDetailsConfigDTO {
    private String eventType;
    private String bannerImageDataUrl;      // "data:image/png;base64,......" or null
    //private Map<Integer, String> galleryImageDataUrls = new HashMap<>(); // size up to 6; null or empty elements allowed
    private List galleryImageDataUrls; // size up to 6; null or empty elements allowed
    private List galleryImageIds;
    // banner (for preview)
    private String bannerImageBase64;

    // gallery images (index → base64 string)
    private Map<Integer, String> galleryMap = new HashMap<>();

    private MultipartFile bannerImage;
    private MultipartFile image1;
    private MultipartFile image2;
    private MultipartFile image3;
    private MultipartFile image4;
    private MultipartFile image5;
    private MultipartFile image6;

    private String resortInfo;
    private String celebrationHighlight;
    private String testimonial;
    private String termsConditions;

    public String getEventType() {
        return eventType;
    }

    public void setEventType(String eventType) {
        this.eventType = eventType;
    }

    public String getBannerImageDataUrl() {
        return bannerImageDataUrl;
    }

    public void setBannerImageDataUrl(String bannerImageDataUrl) {
        this.bannerImageDataUrl = bannerImageDataUrl;
    }

    public List getGalleryImageDataUrls() {
        return galleryImageDataUrls;
    }

    public void setGalleryImageDataUrls(List galleryImageDataUrls) {
        this.galleryImageDataUrls = galleryImageDataUrls;
    }

    public MultipartFile getBannerImage() {
        return bannerImage;
    }

    public void setBannerImage(MultipartFile bannerImage) {
        this.bannerImage = bannerImage;
    }

    public MultipartFile getImage1() {
        return image1;
    }

    public void setImage1(MultipartFile image1) {
        this.image1 = image1;
    }

    public MultipartFile getImage2() {
        return image2;
    }

    public void setImage2(MultipartFile image2) {
        this.image2 = image2;
    }

    public MultipartFile getImage3() {
        return image3;
    }

    public void setImage3(MultipartFile image3) {
        this.image3 = image3;
    }

    public MultipartFile getImage4() {
        return image4;
    }

    public void setImage4(MultipartFile image4) {
        this.image4 = image4;
    }

    public MultipartFile getImage5() {
        return image5;
    }

    public void setImage5(MultipartFile image5) {
        this.image5 = image5;
    }

    public MultipartFile getImage6() {
        return image6;
    }

    public void setImage6(MultipartFile image6) {
        this.image6 = image6;
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

    public String getBannerImageBase64() {
        return bannerImageBase64;
    }

    public void setBannerImageBase64(String bannerImageBase64) {
        this.bannerImageBase64 = bannerImageBase64;
    }

    public Map<Integer, String> getGalleryMap() {
        return galleryMap;
    }

    public void setGalleryMap(Map<Integer, String> galleryMap) {
        this.galleryMap = galleryMap;
    }

    @Override
    public String toString() {
        return "EventDetailsConfigDTO{" +
                "eventType='" + eventType + '\'' +
                ", bannerImageDataUrl='" + bannerImageDataUrl + '\'' +
                ", galleryImageDataUrls=" + galleryImageDataUrls +
                ", bannerImageBase64='" + bannerImageBase64 + '\'' +
                ", galleryMap=" + galleryMap +
                ", bannerImage=" + bannerImage +
                ", image1=" + image1 +
                ", image2=" + image2 +
                ", image3=" + image3 +
                ", image4=" + image4 +
                ", image5=" + image5 +
                ", image6=" + image6 +
                ", resortInfo='" + resortInfo + '\'' +
                ", celebrationHighlight='" + celebrationHighlight + '\'' +
                ", testimonial='" + testimonial + '\'' +
                ", termsConditions='" + termsConditions + '\'' +
                '}';
    }

    public List getGalleryImageIds() {
        return galleryImageIds;
    }

    public void setGalleryImageIds(List galleryImageIds) {
        this.galleryImageIds = galleryImageIds;
    }
}
