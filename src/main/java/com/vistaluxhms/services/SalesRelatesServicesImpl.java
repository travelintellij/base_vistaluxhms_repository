package com.vistaluxhms.services;
import com.vistaluxhms.entity.City_Entity;
import com.vistaluxhms.entity.RateTypeEntity;
import com.vistaluxhms.entity.SalesPartnerEntity;
import com.vistaluxhms.model.City_Obj;
import com.vistaluxhms.model.RateType_Obj;
import com.vistaluxhms.repository.RateTypeRepository;
import com.vistaluxhms.repository.SalesPartnerEntityRepository;
import com.vistaluxhms.repository.Vlx_City_Master_Repository;
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
import java.util.List;

@Service
public class SalesRelatesServicesImpl {
	@Autowired
	Vlx_City_Master_Repository cityRepository;

	@Autowired
	RateTypeRepository rateTypeRepository;

	@Autowired
	SalesPartnerEntityRepository salesPartnerRepository;

	public RateTypeEntity saveRateType(RateTypeEntity rateTypeEntity) {
		rateTypeRepository.save(rateTypeEntity);
		return rateTypeEntity;
	}

	public List<RateTypeEntity> findAllRateTypeList() {
		return rateTypeRepository.findAll();
	}

	public RateTypeEntity findById(Long rateTypeId){
		return rateTypeRepository.findById(rateTypeId).get();
	}

    public void saveSalesPartner(SalesPartnerEntity salesPartnerEntity) {
		salesPartnerRepository.save(salesPartnerEntity);
	}
}
