package com.vistaluxhms.services;
import com.vistaluxhms.entity.*;
import com.vistaluxhms.model.City_Obj;
import com.vistaluxhms.model.RateType_Obj;
import com.vistaluxhms.model.SalesPartnerEntityDto;
import com.vistaluxhms.repository.*;
import com.vistaluxhms.util.VistaluxConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class SalesRelatesServicesImpl {
	@Autowired
	Vlx_City_Master_Repository cityRepository;

	@Autowired
	RateTypeRepository rateTypeRepository;

	@Autowired
	SalesPartnerEntityRepository salesPartnerRepository;

	@Autowired
	MasterRoomDetailsEntityRepository masterRoomDetailsEntityRepository;

	@Autowired
	private SessionRateMappingEntityRepository sessionRateMappingEntityRepository;

	public RateTypeEntity saveRateType(RateTypeEntity rateTypeEntity) {
		rateTypeRepository.save(rateTypeEntity);
		return rateTypeEntity;
	}

	public List<RateTypeEntity> findAllRateTypeList() {
		return rateTypeRepository.findAll();
	}

	public RateTypeEntity findById(Integer rateTypeId){
		return rateTypeRepository.findById(rateTypeId).get();
	}

    public void saveSalesPartner(SalesPartnerEntity salesPartnerEntity) {
		salesPartnerRepository.save(salesPartnerEntity);
	}

	public void saveRoomDetails(MasterRoomDetailsEntity roomDetailsEntity) {
		masterRoomDetailsEntityRepository.save(roomDetailsEntity);
	}
	public List<SalesPartnerEntity> filterSalesPartners(SalesPartnerEntityDto searchSalesPartnerObj) {
		// Fetch all filtered results without pagination
		List<SalesPartnerEntity> filteredSalesPartnerList = salesPartnerRepository.findAll(new Specification<SalesPartnerEntity>() {
			private static final long serialVersionUID = 1L;

			@Override
			public Predicate toPredicate(Root<SalesPartnerEntity> salesPartnerRootEntity, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {
				List<Predicate> predicates = new ArrayList<>();

				// Filter by Sales Partner ID
				if (searchSalesPartnerObj.getSalesPartnerId() != null && searchSalesPartnerObj.getSalesPartnerId() != 0) {
					predicates.add(criteriaBuilder.equal(salesPartnerRootEntity.get("salesPartnerId"), searchSalesPartnerObj.getSalesPartnerId()));
				}

				// Filter by Sales Partner Short Name
				if (searchSalesPartnerObj.getSalesPartnerShortName() != null && !searchSalesPartnerObj.getSalesPartnerShortName().trim().isEmpty()) {
					predicates.add(criteriaBuilder.like(criteriaBuilder.lower(salesPartnerRootEntity.get("salesPartnerShortName")),
							"%" + searchSalesPartnerObj.getSalesPartnerShortName().toLowerCase() + "%"));
				}

				// Filter by Sales Partner Name
				if (searchSalesPartnerObj.getSalesPartnerName() != null && !searchSalesPartnerObj.getSalesPartnerName().trim().isEmpty()) {
					predicates.add(criteriaBuilder.like(criteriaBuilder.lower(salesPartnerRootEntity.get("salesPartnerName")),
							"%" + searchSalesPartnerObj.getSalesPartnerName().toLowerCase() + "%"));
				}

				// Filter by City
				if (searchSalesPartnerObj.getCityId() != 0) {
					predicates.add(criteriaBuilder.equal(salesPartnerRootEntity.get("cityId"), searchSalesPartnerObj.getCityId()));
				}


				// Filter by Active Status
				if (searchSalesPartnerObj.getActive() != null) {
					predicates.add(criteriaBuilder.equal(salesPartnerRootEntity.get("active"), searchSalesPartnerObj.getActive()));
				}

				return criteriaBuilder.and(predicates.toArray(new Predicate[0]));
			}
		});

		return filteredSalesPartnerList;
	}
	public SalesPartnerEntity findSalesPartnerById(Long salesPartnerId){
		return salesPartnerRepository.findById(salesPartnerId).get();
	}

	public List<SalesPartnerEntity> findSalesPartnerByActive(boolean activeFlag){
		return salesPartnerRepository.findByActive(activeFlag);
	}

	public Map<Long, String> getActiveSalesPartnerMap(boolean activeFlag) {
		return salesPartnerRepository.findByActiveOrderBySalesPartnerShortNameAsc(activeFlag)
				.stream()
				.collect(Collectors.toMap(
						SalesPartnerEntity::getSalesPartnerId,
						SalesPartnerEntity::getSalesPartnerShortName,
						(e1, e2) -> e1, // in case of duplicate keys
						LinkedHashMap::new
				));
	}

	public List<MasterRoomDetailsEntity> findRoomsList(){
		Sort sort = Sort.by(Sort.Order.desc("active"));
		List<MasterRoomDetailsEntity> roomList = masterRoomDetailsEntityRepository.findAll(sort);
		return roomList;
	}

	public MasterRoomDetailsEntity findRoomCategoryById(int roomCategoryId){
		return masterRoomDetailsEntityRepository.findById(roomCategoryId).get();
	}

	public List<MasterRoomDetailsEntity> findActiveRoomsList(){
		Sort sort = Sort.by(Sort.Order.desc("active"));
		List<MasterRoomDetailsEntity> roomList = masterRoomDetailsEntityRepository.findByActiveTrue();
		return roomList;
	}

	public List<RateTypeEntity> findAllActiveRateTypes(boolean activeFlag){
		return rateTypeRepository.findByActive(activeFlag);
	}

	public List<SessionRateMappingEntity> findByRateTypeEntityRateTypeIdOrderByStartDateDesc(Integer rateTypeId){
		return sessionRateMappingEntityRepository.findByRateTypeEntityRateTypeIdOrderByStartDateDesc(rateTypeId);
	}
}
