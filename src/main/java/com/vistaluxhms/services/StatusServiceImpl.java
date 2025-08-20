package com.vistaluxhms.services;

import com.vistaluxhms.entity.*;
import com.vistaluxhms.model.SessionFilterDTO;
import com.vistaluxhms.model.SessionRateMappingEntityDTO;
import com.vistaluxhms.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class StatusServiceImpl {

	@Autowired
	StatusRepository statusRepository;

	public StatusEntity findStatusById(Integer statusId){
		if(statusRepository.findById(statusId).isPresent())
			return statusRepository.findById(statusId).get();
		else
			return null;
	}

	public List<StatusEntity> findByStatusObjAndActive(String statusObj,boolean active){
		return statusRepository.findByStatusObjAndActive(statusObj,active);
	}

	public List<StatusEntity> findAllActiveStatusList(){
		return statusRepository.findByActiveTrue();
	}


}
