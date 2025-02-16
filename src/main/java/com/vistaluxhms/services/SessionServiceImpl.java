package com.vistaluxhms.services;
import com.vistaluxhms.entity.MasterRoomDetailsEntity;
import com.vistaluxhms.entity.RateTypeEntity;
import com.vistaluxhms.entity.SalesPartnerEntity;
import com.vistaluxhms.model.SalesPartnerEntityDto;
import com.vistaluxhms.repository.MasterRoomDetailsEntityRepository;
import com.vistaluxhms.repository.RateTypeRepository;
import com.vistaluxhms.repository.SalesPartnerEntityRepository;
import com.vistaluxhms.repository.Vlx_City_Master_Repository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class SessionServiceImpl {
	@Autowired
	Vlx_City_Master_Repository cityRepository;

	@Autowired
	RateTypeRepository rateTypeRepository;

	@Autowired
	SalesPartnerEntityRepository salesPartnerRepository;

	@Autowired
	MasterRoomDetailsEntityRepository masterRoomDetailsEntityRepository;


}
