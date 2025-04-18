package com.vistaluxevent.services;

import com.vistaluxevent.entity.EventMasterServiceEntity;
import com.vistaluxevent.entity.EventServiceCostTypeEntity;
import com.vistaluxevent.entity.EventTypeEntity;
import com.vistaluxevent.repository.EventMasterServiceRepository;
import com.vistaluxevent.repository.EventServiceCostTypeRepository;
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

	@Autowired
	EventMasterServiceRepository eventMasterServiceRepository;

	@Autowired
	EventServiceCostTypeRepository eventServiceCostTypeRepository;

	public List<EventTypeEntity> findAllEventType(){
		return eventTypeRepository.findAll();
	}

	public EventTypeEntity findEventTypeById(int eventTypeId){
		return eventTypeRepository.findById(eventTypeId).get();
	}


	public void saveEventMasterService(EventMasterServiceEntity eventMasterServiceEntity){
		eventMasterServiceRepository.save(eventMasterServiceEntity);
	}

	public List<EventServiceCostTypeEntity> findActiveEventServiceCostType(boolean active){
		return eventServiceCostTypeRepository.findByActive(active);
	}

	public List<EventMasterServiceEntity> findActiveEventMasterServiceList(boolean active){
		//Sort sort = Sort.by(Sort.Order.desc("active"));
		List<EventMasterServiceEntity> listMasterService = eventMasterServiceRepository.findByActive(active);
		return listMasterService;
	}
	public List<EventMasterServiceEntity> findEventMasterServiceList(){
		Sort sort = Sort.by(Sort.Order.desc("active"));
		List<EventMasterServiceEntity> roomList = eventMasterServiceRepository.findAll(sort);
		return roomList;
	}


	public EventMasterServiceEntity findEventMasterServiceById(Integer eventMasterServiceId){
		return eventMasterServiceRepository.findById(eventMasterServiceId).get();
	}

}
