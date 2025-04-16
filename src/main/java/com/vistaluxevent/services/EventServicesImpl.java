package com.vistaluxevent.services;

import com.vistaluxevent.entity.EventTypeEntity;
import com.vistaluxevent.repository.EventTypeRepository;
import com.vistaluxhms.entity.*;
import com.vistaluxhms.model.FilterLeadObj;
import com.vistaluxhms.repository.ClientEntityRepository;
import com.vistaluxhms.repository.LeadEntityRepository;
import com.vistaluxhms.repository.Leads_Followup_Repository;
import com.vistaluxhms.repository.Vlx_City_Master_Repository;
import com.vistaluxhms.util.VistaluxConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class EventServicesImpl {
	@Autowired
	Vlx_City_Master_Repository cityRepository;

	@Autowired
	LeadEntityRepository leadRepository;

	@Autowired
	EventTypeRepository eventTypeRepository;


	public List<EventTypeEntity> findAllEventType(){
		return eventTypeRepository.findAll();
	}


}
