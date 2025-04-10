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

	public byte[] generatePdfFromHtml(String htmlContent) throws  IOException, com.lowagie.text.DocumentException {
		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		ITextRenderer renderer = new ITextRenderer();
		renderer.setDocumentFromString(htmlContent);
		renderer.layout();
		renderer.createPDF(outputStream);
		renderer.finishPDF();
		return outputStream.toByteArray();
	}

}
