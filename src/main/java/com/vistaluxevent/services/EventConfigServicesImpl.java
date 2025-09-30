package com.vistaluxevent.services;

import com.vistaluxevent.entity.*;
import com.vistaluxevent.model.EventDetailsConfigDTO;
import com.vistaluxevent.model.FilterEventObj;
import com.vistaluxevent.repository.*;
import com.vistaluxhms.entity.Workload_Status_Entity;
import com.vistaluxhms.repository.LeadEntityRepository;
import com.vistaluxhms.repository.Vlx_City_Master_Repository;
import com.vistaluxhms.util.EventType;
import com.vistaluxhms.util.VistaluxConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.*;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.*;
import java.util.Base64;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.stream.Collectors;

@Service
public class EventConfigServicesImpl {

	private final EventDetailsConfigEntityRepository detailsRepo;

	@Autowired
	EventImageConfigEntityRepository imageRepo;

	public EventConfigServicesImpl(EventDetailsConfigEntityRepository detailsRepo, EventImageConfigEntityRepository imageRepo) {
		this.detailsRepo = detailsRepo;
		//this.imageRepo = imageRepo;
	}

	@Transactional(readOnly = true)
	public EventDetailsConfigDTO getEventDtoByType(String eventTypeStr) {
		EventType eventType = EventType.valueOf(eventTypeStr.toUpperCase());
		EventDetailsConfigDTO dto = new EventDetailsConfigDTO();
		dto.setEventType(eventType.name());

		EventDetailsConfigEntity details = detailsRepo.findByEventType(eventType).orElse(null);
		if (details == null) {
			// empty DTO with 6 nulls for gallery
			dto.setGalleryImageDataUrls(Arrays.asList(new String[6]));
			return dto;
		}

		// banner
		if (details.getBannerImage() != null && details.getBannerImage().length > 0) {
			String mime = Optional.ofNullable(details.getBannerMimeType()).orElse("image/jpeg");
			dto.setBannerImageDataUrl(toDataUrl(mime, details.getBannerImage()));
		}

		// gallery 1..6
		List<EventImageConfigEntity> images = imageRepo.findByEventDetailsOrderByImageIndex(details);
		// create array of size 6; fill positions by index-1
		List<String> gallery = new ArrayList<>(Collections.nCopies(6, null));
		for (EventImageConfigEntity img : images) {
			int idx = img.getImageIndex();
			if (idx >= 1 && idx <= 6 && img.getImageData() != null) {
				String mime = Optional.ofNullable(img.getMimeType()).orElse("image/jpeg");
				gallery.set(idx - 1, toDataUrl(mime, img.getImageData()));
			}
		}
		dto.setGalleryImageDataUrls(gallery);

		dto.setResortInfo(details.getResortInfo());
		dto.setCelebrationHighlight(details.getCelebrationHighlight());
		dto.setTestimonial(details.getTestimonial());
		dto.setTermsConditions(details.getTermsConditions());
		return dto;
	}

	@Transactional
	public void saveOrUpdateEvent(String eventTypeStr, EventDetailsConfigDTO form) throws IOException {
		EventType eventType = EventType.valueOf(eventTypeStr.toUpperCase());

		EventDetailsConfigEntity details = detailsRepo.findByEventType(eventType).orElseGet(() -> {
			EventDetailsConfigEntity d = new EventDetailsConfigEntity();
			d.setEventType(eventType);
			d.setCreatedAt(LocalDateTime.now());
			return d;
		});

		// update text fields
		details.setResortInfo(form.getResortInfo());
		details.setCelebrationHighlight(form.getCelebrationHighlight());
		details.setTestimonial(form.getTestimonial());
		details.setTermsConditions(form.getTermsConditions());
		details.setUpdatedAt(LocalDateTime.now());

		// banner: replace only if a new file provided
		MultipartFile banner = form.getBannerImage();
		if (banner != null && !banner.isEmpty()) {
			details.setBannerImage(banner.getBytes());
			details.setBannerMimeType(Optional.ofNullable(banner.getContentType()).orElse("image/jpeg"));
		}

		// save details first to ensure id for images
		details = detailsRepo.save(details);

		// Helper to process gallery slot i
		for (int i = 1; i <= 6; i++) {
			MultipartFile mf = getMultipartForIndex(form, i);
			if (mf != null && !mf.isEmpty()) {
				EventImageConfigEntity img = imageRepo.findByEventDetailsAndImageIndex(details, i)
						.orElse(null);

				if (img == null) {
					img = new EventImageConfigEntity();
					img.setEventDetails(details);
					img.setImageIndex(i);
				}

				img.setImageData(mf.getBytes());
				img.setMimeType(Optional.ofNullable(mf.getContentType()).orElse("image/jpeg"));
				img.setUploadedAt(LocalDateTime.now());
				imageRepo.save(img);
			}
		}
	}

	// helpers

	private static String toDataUrl(String mimeType, byte[] bytes) {
		String base64 = Base64.getEncoder().encodeToString(bytes);
		return "data:" + mimeType + ";base64," + base64;
	}

	private static MultipartFile getMultipartForIndex(EventDetailsConfigDTO form, int index) {
		switch (index) {
			case 1:
				return form.getImage1();
			case 2:
				return form.getImage2();
			case 3:
				return form.getImage3();
			case 4:
				return form.getImage4();
			case 5:
				return form.getImage5();
			case 6:
				return form.getImage6();
			default:
				return null;
		}
	}

	public EventDetailsConfigDTO getEventDetails(String eventTypeStr) {
		EventType eventType = EventType.valueOf(eventTypeStr.toUpperCase());

		EventDetailsConfigEntity entity = detailsRepo.findByEventType(eventType)
				.orElse(new EventDetailsConfigEntity());

		EventDetailsConfigDTO dto = new EventDetailsConfigDTO();
		dto.setResortInfo(entity.getResortInfo());
		dto.setCelebrationHighlight(entity.getCelebrationHighlight());
		dto.setTestimonial(entity.getTestimonial());
		dto.setTermsConditions(entity.getTermsConditions());

		// banner thumbnail (base64 string)
		if (entity.getBannerImage() != null) {
			String base64 = Base64.getEncoder().encodeToString(entity.getBannerImage());
			dto.setBannerImageBase64("data:" + entity.getBannerMimeType() + ";base64," + base64);
		}


		/*
		// gallery thumbnails
		List<EventImageConfigEntity> images = imageRepo.findByEventDetails(entity);
		for (EventImageConfigEntity img : images) {
			String base64 = Base64.getEncoder().encodeToString(img.getImageData());
			dto.getGalleryMap().put(
					img.getImageIndex(),
					"data:" + img.getMimeType() + ";base64," + base64
			);
		}

		 */
		List<EventImageConfigEntity> images = imageRepo.findByEventDetailsOrderByImageIndex(entity);
		List<Long> imageIds = new ArrayList<>(Collections.nCopies(6, null));

		System.out.println("Images Size of url is " + images.size());

		List<String> gallery = new ArrayList<>(Collections.nCopies(6, null));
		for (EventImageConfigEntity img : images) {
			int idx = img.getImageIndex();
			if (idx >= 1 && idx <= 6 && img.getImageData() != null) {
				String mime = Optional.ofNullable(img.getMimeType()).orElse("image/jpeg");
				gallery.set(idx - 1, "data:" + mime + ";base64," + Base64.getEncoder().encodeToString(img.getImageData()));
				imageIds.set(idx - 1, img.getId()); // capture ID here
			}
		}
		dto.setGalleryImageDataUrls(gallery);
		dto.setGalleryImageIds(imageIds);

		return dto;
	}

	public ResponseEntity<String> deleteImageById(Long id){
		Optional<EventImageConfigEntity> imageOpt = imageRepo.findById(id);
		if(imageOpt.isPresent()){
			imageRepo.delete(imageOpt.get());
			return ResponseEntity.ok("Deleted");
		} else{
			return ResponseEntity.notFound().build();
		}
	}

}
