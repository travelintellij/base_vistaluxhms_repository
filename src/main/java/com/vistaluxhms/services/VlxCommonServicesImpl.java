package com.vistaluxhms.services;


import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import com.itextpdf.text.DocumentException;
import com.vistaluxhms.entity.City_Entity;
import com.vistaluxhms.entity.Workload_Status_Entity;
import com.vistaluxhms.model.City_Obj;
import com.vistaluxhms.model.WorkLoadStatusVO;
import com.vistaluxhms.repository.LeadEntityRepository;
import com.vistaluxhms.repository.Vlx_City_Master_Repository;
import com.vistaluxhms.repository.WorkloadStatusEntityRepository;
import com.vistaluxhms.util.VistaluxConstants;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.xhtmlrenderer.pdf.ITextRenderer;


@Service
public class VlxCommonServicesImpl {

	@Autowired
	Vlx_City_Master_Repository cityRepository;

	@Autowired
	LeadEntityRepository leadRepository;
	@Autowired
	WorkloadStatusEntityRepository workloadStatusEntityRepository;

	public List<String> findCities(String query) {
		return cityRepository.findCitiesByQuery("%" + query + "%");
	}

	public boolean existsByCityNameAndCountryCode(String cityName, String countryCode) {
		return cityRepository.existsByCityNameAndCountryCodeIgnoreCase(cityName, countryCode);
	}

	public List<City_Entity> listAllActiveCities()   {
		List<City_Entity> listDestinations= cityRepository.findAllActiveUdnDestinations();
		return listDestinations;
	}
	
	public List<City_Entity> listCountry(String countryName)   {
		List<City_Entity> listDestinations= cityRepository.findAllActiveUdnCountries();
		
		return listDestinations;
	}

	public List<City_Entity> findDistinctActiveDestinationList(){
		return cityRepository.findDistinctRecordsByCountryCode();
	}

	public Page<City_Entity>  filterCities(int pageNo, int pageSize, String sortBy, City_Obj searchCityObj) {
		Pageable paging = PageRequest.of(pageNo, pageSize,Sort.by(sortBy));
		Page<City_Entity> filteredCityList = cityRepository.findAll(new Specification<City_Entity>() {
			/**
			 *
			 */
			private static final long serialVersionUID = 1L;

			@Override
			public Predicate toPredicate(Root<City_Entity> cityRootEntity, CriteriaQuery< ?> query, CriteriaBuilder criteriaBuilder) {
				List<Predicate> predicates = new ArrayList<>();
				if(!(searchCityObj.getDestinationId()== VistaluxConstants.DESTINATION_ALL_CITIES || searchCityObj.getDestinationId()==0)) {
					predicates.add(criteriaBuilder.equal(cityRootEntity.get("destinationId"), searchCityObj.getDestinationId()));
				}
				if(!searchCityObj.getCountryCode().equalsIgnoreCase(VistaluxConstants.DESTINATION_ALL_CTRY_CODE)) {
					predicates.add(criteriaBuilder.equal(cityRootEntity.get("countryCode"), searchCityObj.getCountryCode()));
				}
				if ((searchCityObj.getCityName()!= null) && (searchCityObj.getCityName().trim().length()>0)) {
					predicates.add(criteriaBuilder.like(criteriaBuilder.lower(cityRootEntity.get("cityName")),"%" + searchCityObj.getCityName().toLowerCase() + "%"));
				}


				return criteriaBuilder.and(predicates.toArray(new Predicate[0]));
			}
		},paging);

		return filteredCityList;
	}
	public City_Entity saveCity(City_Entity cityEntity) {
		cityRepository.save(cityEntity);
		return cityEntity;
	}

	public City_Entity findDestinationById(int destinationId) {
		return cityRepository.findDestinationById(destinationId);
	}

	public List<City_Entity> listAllActiveDestinations()   {
		List<City_Entity> listDestinations= cityRepository.findAllActiveUdnDestinations();
		return listDestinations;
	}

	public boolean existsByDestinationIdAndCityName(int destinationId, String cityName) {
		return cityRepository.existsByDestinationIdAndCityName(destinationId, cityName);
	}

	public List<WorkLoadStatusVO> find_All_Active_Status_Workload_Obj(String workloadObj){
		List<Workload_Status_Entity> workloadStatusEntityList = leadRepository.find_All_Status_Workload_Obj(workloadObj);
		List<WorkLoadStatusVO> workloadStatusVOList = new ArrayList();
		Iterator itrWorkloadStatusEntity = workloadStatusEntityList.iterator();

		while(itrWorkloadStatusEntity.hasNext()) {
			Workload_Status_Entity workloadStatusEntity = (Workload_Status_Entity)itrWorkloadStatusEntity.next();
			if(workloadStatusEntity.isActive()) {
				WorkLoadStatusVO workloadDealStatusVO = new WorkLoadStatusVO(workloadStatusEntity);
				workloadStatusVOList.add(workloadDealStatusVO);
			}
		}
		return workloadStatusVOList;
	}

	public Workload_Status_Entity findWorkLoadStatusById(int statusId) {
		return workloadStatusEntityRepository.findByWorkloadStatusId(statusId).get();
	}

	@Autowired(required = false)
	private javax.servlet.ServletContext servletContext;

	public String getUploadedLogoDataUri(com.vistaluxhms.model.CentralConfigEntityDTO centralConfig) {
		return getUploadedLogoDataUri(this.servletContext, centralConfig);
	}

	public String getUploadedLogoDataUri(javax.servlet.ServletContext sc, com.vistaluxhms.model.CentralConfigEntityDTO centralConfig) {
		try {
			javax.servlet.ServletContext ctx = (sc != null) ? sc : this.servletContext;
			if (ctx != null) {
				String path = VistaluxConstants.LOGO_PATH + "/" + VistaluxConstants.LOGO_FILE_NAME;
				java.io.InputStream is = ctx.getResourceAsStream(path);
				if (is != null) {
					try {
						byte[] imageBytes = org.springframework.util.StreamUtils.copyToByteArray(is);
						if (imageBytes != null && imageBytes.length > 0) {
							String mimeType = "image/png";
							if (VistaluxConstants.LOGO_FILE_NAME.toLowerCase().endsWith(".jpg") || VistaluxConstants.LOGO_FILE_NAME.toLowerCase().endsWith(".jpeg")) {
								mimeType = "image/jpeg";
							}
							return "data:" + mimeType + ";base64," + java.util.Base64.getEncoder().encodeToString(imageBytes);
						}
					} finally {
						is.close();
					}
				}

				String logoRealPath = ctx.getRealPath(VistaluxConstants.LOGO_PATH + java.io.File.separator + VistaluxConstants.LOGO_FILE_NAME);
				if (logoRealPath != null) {
					java.io.File logoFile = new java.io.File(logoRealPath);
					if (logoFile.exists() && logoFile.isFile() && logoFile.length() > 0) {
						byte[] imageBytes = java.nio.file.Files.readAllBytes(logoFile.toPath());
						String mimeType = "image/png";
						if (logoFile.getName().toLowerCase().endsWith(".jpg") || logoFile.getName().toLowerCase().endsWith(".jpeg")) {
							mimeType = "image/jpeg";
						}
						return "data:" + mimeType + ";base64," + java.util.Base64.getEncoder().encodeToString(imageBytes);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (centralConfig != null && centralConfig.getLogoPath() != null && !centralConfig.getLogoPath().trim().isEmpty()) {
			return centralConfig.getLogoPath().trim();
		}
		return "";
	}

	public byte[] generatePdfFromHtml(String htmlContent) throws  IOException, com.lowagie.text.DocumentException {
		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		org.jsoup.nodes.Document doc = org.jsoup.Jsoup.parse(htmlContent);
		doc.outputSettings().syntax(org.jsoup.nodes.Document.OutputSettings.Syntax.xml);
		doc.outputSettings().escapeMode(org.jsoup.nodes.Entities.EscapeMode.xhtml);
		doc.outputSettings().charset("UTF-8");
		org.w3c.dom.Document w3cDoc = new org.jsoup.helper.W3CDom().fromJsoup(doc);
		ITextRenderer renderer = new ITextRenderer();
		renderer.setDocument(w3cDoc, null);
		renderer.layout();
		renderer.createPDF(outputStream);
		renderer.finishPDF();
		return outputStream.toByteArray();
	}

}
