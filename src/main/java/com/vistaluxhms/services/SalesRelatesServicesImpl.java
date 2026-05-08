package com.vistaluxhms.services;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

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
import java.util.stream.Collectors;import javax.annotation.PostConstruct;



@Service
public class SalesRelatesServicesImpl {


    private static final Logger logger = LoggerFactory.getLogger(SalesRelatesServicesImpl.class);
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

    @PostConstruct
    public void initSystemMapping() {

        // RATE TYPE
        RateTypeEntity b2c = rateTypeRepository.findById(1)
                .orElseGet(() -> {
                    RateTypeEntity rt = new RateTypeEntity();
                    rt.setRateTypeName("B2C_Rate_Type");
                    rt.setActive(true);
                    rt.setDescription("System default B2C RateType");
                    return rateTypeRepository.save(rt);
                });

        // SALES PARTNER
        SalesPartnerEntity sp = salesPartnerRepository.findById(1L)
                .orElseGet(() -> {
                    SalesPartnerEntity s = new SalesPartnerEntity();
                    s.setSalesPartnerName("Digital Marketing");
                    s.setSalesPartnerShortName("DIGITAL MARKETING");
                    s.setActive(true);
                    s.setCityId(VistaluxConstants.DEFAULT_CITY_ID);
                    s.setDescription("System default Sales Partner");
                    s.setReference("SYSTEM");
                    return salesPartnerRepository.save(s);
                });

        // FORCE LINK
        if (sp.getRateTypeEntity() == null ||
                !sp.getRateTypeEntity().getRateTypeId().equals(b2c.getRateTypeId())) {

            sp.setRateTypeEntity(b2c);
            salesPartnerRepository.save(sp);
        }
    }


    private SalesPartnerEntity getSystemDigitalMarketing() {

        return salesPartnerRepository.findById(1L)
                .orElseThrow(() ->
                        new IllegalStateException("System SalesPartner (ID=1) missing"));
    }
    private RateTypeEntity getSystemB2CRateType() {

        return rateTypeRepository.findById(1)
                .orElseThrow(() ->
                        new IllegalStateException("System B2C RateType (ID=1) missing"));
    }

    public List<RateTypeEntity> findAllRateTypeList() {
		return rateTypeRepository.findAll();
	}

	public RateTypeEntity findById(Integer rateTypeId) {
        return rateTypeRepository.findById(rateTypeId)
                .orElseThrow(() -> new IllegalStateException("RateType not found: " + rateTypeId));
	}

	public void saveSalesPartner(SalesPartnerEntity salesPartnerEntity) {
		salesPartnerRepository.save(salesPartnerEntity);
	}

	public void saveRoomDetails(MasterRoomDetailsEntity roomDetailsEntity) {
		masterRoomDetailsEntityRepository.save(roomDetailsEntity);
	}

	public List<SalesPartnerEntity> filterSalesPartners(SalesPartnerEntityDto searchSalesPartnerObj) {
		// Fetch all filtered results without pagination
		List<SalesPartnerEntity> filteredSalesPartnerList = salesPartnerRepository
				.findAll(new Specification<SalesPartnerEntity>() {
					private static final long serialVersionUID = 1L;

					@Override
					public Predicate toPredicate(Root<SalesPartnerEntity> salesPartnerRootEntity,
							CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {
						List<Predicate> predicates = new ArrayList<>();

						// Filter by Sales Partner ID
						if (searchSalesPartnerObj.getSalesPartnerId() != null
								&& searchSalesPartnerObj.getSalesPartnerId() != 0) {
							predicates.add(criteriaBuilder.equal(salesPartnerRootEntity.get("salesPartnerId"),
									searchSalesPartnerObj.getSalesPartnerId()));
						}

						// Filter by Sales Partner Short Name
						if (searchSalesPartnerObj.getSalesPartnerShortName() != null
								&& !searchSalesPartnerObj.getSalesPartnerShortName().trim().isEmpty()) {
							predicates.add(criteriaBuilder.like(
									criteriaBuilder.lower(salesPartnerRootEntity.get("salesPartnerShortName")),
									"%" + searchSalesPartnerObj.getSalesPartnerShortName().toLowerCase() + "%"));
						}

						// Filter by Sales Partner Name
						if (searchSalesPartnerObj.getSalesPartnerName() != null
								&& !searchSalesPartnerObj.getSalesPartnerName().trim().isEmpty()) {
							predicates.add(criteriaBuilder.like(
									criteriaBuilder.lower(salesPartnerRootEntity.get("salesPartnerName")),
									"%" + searchSalesPartnerObj.getSalesPartnerName().toLowerCase() + "%"));
						}

						// Filter by City
						if (searchSalesPartnerObj.getCityId() != 0) {
							predicates.add(criteriaBuilder.equal(salesPartnerRootEntity.get("cityId"),
									searchSalesPartnerObj.getCityId()));
						}

						// Filter by Active Status
						if (searchSalesPartnerObj.getActive() != null) {
							predicates.add(criteriaBuilder.equal(salesPartnerRootEntity.get("active"),
									searchSalesPartnerObj.getActive()));
						}

						return criteriaBuilder.and(predicates.toArray(new Predicate[0]));
					}
				});

		return filteredSalesPartnerList;
	}

	public SalesPartnerEntity findSalesPartnerById(Long salesPartnerId) {
        return salesPartnerRepository.findById(salesPartnerId)
                .orElseThrow(() -> new IllegalStateException("SalesPartner not found: " + salesPartnerId));
	}

	public List<SalesPartnerEntity> findSalesPartnerByActive(boolean activeFlag) {
		return salesPartnerRepository.findByActive(activeFlag);
	}

	/**
	 * Retrieves all active sales partners.
	 * 
	 * Modification:
	 * Added self-healing logic for the "Digital Marketing" default partner.
	 * If it doesn't exist, it's created automatically to support both
	 * manual and automated lead creation workflows.
	 */
    public Map<Long, String> getActiveSalesPartnerMap(boolean activeFlag) {

        return salesPartnerRepository.findByActiveOrderBySalesPartnerShortNameAsc(activeFlag)
                .stream()
                .collect(Collectors.toMap(
                        SalesPartnerEntity::getSalesPartnerId,
                        SalesPartnerEntity::getSalesPartnerShortName,
                        (e1, e2) -> e1,
                        LinkedHashMap::new));
    }

	public List<MasterRoomDetailsEntity> findRoomsList() {
		Sort sort = Sort.by(Sort.Order.desc("active"));
		List<MasterRoomDetailsEntity> roomList = masterRoomDetailsEntityRepository.findAll(sort);
		return roomList;
	}

	public MasterRoomDetailsEntity findRoomCategoryById(int roomCategoryId) {
		return masterRoomDetailsEntityRepository.findById(roomCategoryId).get();
	}

	public List<MasterRoomDetailsEntity> findActiveRoomsList() {
		Sort sort = Sort.by(Sort.Order.desc("active"));
		List<MasterRoomDetailsEntity> roomList = masterRoomDetailsEntityRepository.findByActiveTrue();
		return roomList;
	}

	public List<RateTypeEntity> findAllActiveRateTypes(boolean activeFlag) {
		return rateTypeRepository.findByActive(activeFlag);
	}

	public List<SessionRateMappingEntity> findByRateTypeEntityRateTypeIdOrderByStartDateDesc(Integer rateTypeId) {
		return sessionRateMappingEntityRepository.findByRateTypeEntityRateTypeIdOrderByStartDateDesc(rateTypeId);
	}

	public boolean isSalesPartnerMobileExists(Long mobile) {
		return salesPartnerRepository.existsByMobile(mobile);
	}
}
