package com.vistaluxhms.services;
import com.vistaluxhms.entity.*;
import com.vistaluxhms.model.SalesPartnerEntityDto;
import com.vistaluxhms.repository.*;
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
	SessionRepository sessionRepository;


	public void saveSessionMaster(SessionEntity sessionEntity) {
		sessionRepository.save(sessionEntity);
	}


}
