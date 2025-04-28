package com.vistaluxevent.services;

import com.vistaluxevent.entity.EventMasterServiceEntity;
import com.vistaluxevent.entity.EventPackageEntity;
import com.vistaluxevent.entity.EventServiceCostTypeEntity;
import com.vistaluxevent.entity.EventTypeEntity;
import com.vistaluxevent.model.FilterEventObj;
import com.vistaluxevent.repository.EventMasterServiceRepository;
import com.vistaluxevent.repository.EventPackageRepository;
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
import java.time.LocalDate;
import java.time.ZoneId;
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

	@Autowired
	EventPackageRepository eventPackageRepository;

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

	public List<EventServiceCostTypeEntity> findByEventServiceCostTypeIdAndActive(Integer eventCostTypeId, boolean active){
		return eventServiceCostTypeRepository.findByEventServiceCostTypeIdAndActive(eventCostTypeId,active);
	}

	public EventServiceCostTypeEntity findEventServiceCostTypeByID(Integer costTypeId){
		return eventServiceCostTypeRepository.findById(costTypeId).get();
	}


	public List<EventMasterServiceEntity> findActiveEventMasterServiceList(boolean active){
		//Sort sort = Sort.by(Sort.Order.desc("active"));
		List<EventMasterServiceEntity> listMasterService = eventMasterServiceRepository.findByActive(active);
		return listMasterService;
	}

	public List<EventMasterServiceEntity> findByEventTypeIdAndActiveEventMasterServiceList(Integer eventTypeId, boolean active){
		//Sort sort = Sort.by(Sort.Order.desc("active"));
		List<EventMasterServiceEntity> listMasterService = eventMasterServiceRepository.findByEventTypeIdAndActive(eventTypeId,active);
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

	public EventPackageEntity saveEventPackage(EventPackageEntity eventPackageEntity) {
		return eventPackageRepository.save(eventPackageEntity);
	}


	public Page<EventPackageEntity>  filterEvents(int pageNo, int pageSize, long leadOwner, String sorting, FilterEventObj filterEventObj, boolean isAdmin ) {
		//Pageable paging = PageRequest.of(pageNo, pageSize, Sort.by(sorting));
		Pageable paging = PageRequest.of(pageNo, pageSize, Sort.by(Sort.Direction.DESC, sorting));

		Date currentDate = Date.from(java.time.ZonedDateTime.now().toInstant());
		GregorianCalendar cal = new GregorianCalendar();
		cal.setTime(currentDate);
		cal.add(Calendar.DATE, -365);
		Date criteriaDate = cal.getTime();
		boolean isLeadAdmin=false;
		Page<EventPackageEntity> filteredLeadsList = eventPackageRepository.findAll(new Specification<EventPackageEntity>() {
			private static final long serialVersionUID = 1L;
			@Override
			public Predicate toPredicate(Root<EventPackageEntity> eventRootEntity, CriteriaQuery< ?> query, CriteriaBuilder criteriaBuilder) {
				//CriteriaQuery<Udn_Deals_Recorder_Entity> criteriaQueryDeal = criteriaBuilder.createQuery(Udn_Deals_Recorder_Entity.class);
				List<Predicate> predicates = new ArrayList<>();

				//Join<EventPackageEntity, ClientEntityRepository> clientJoin = eventRootEntity.join("guestId", JoinType.LEFT);
				Root<Workload_Status_Entity> workloadStatusEntity = query.from(Workload_Status_Entity.class);

				//if(!(isAdmin||isLeadAdmin)) {
				query.distinct(true);

				if(filterEventObj.getEventId()==0) {
					if((filterEventObj.getStartDate()!=null && (!filterEventObj.getStartDate().isEmpty())) && (filterEventObj.getEndDate()!=null && (!filterEventObj.getEndDate().isEmpty()))){
						Date dateTo;
						Date dateFrom;
						try {
							dateTo = new SimpleDateFormat("yyyy-MM-dd").parse(filterEventObj.getEndDate());
							LocalDate localEndDate = dateTo.toInstant()
									.atZone(ZoneId.systemDefault())
									.toLocalDate();

							Calendar cal = Calendar.getInstance();
							cal.setTime(dateTo);
							cal.set(Calendar.HOUR_OF_DAY, 23);
							cal.set(Calendar.MINUTE, 59);
							cal.set(Calendar.SECOND, 59);
							cal.set(Calendar.MILLISECOND, 999);
							dateTo = cal.getTime();
							dateFrom=new SimpleDateFormat("yyyy-MM-dd").parse(filterEventObj.getStartDate());
							LocalDate localStartDate = dateFrom.toInstant()
									.atZone(ZoneId.systemDefault())
									.toLocalDate();
							predicates.add(criteriaBuilder.between(eventRootEntity.get("eventStartDate"),localStartDate,localEndDate));
						} catch (ParseException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}

					if (filterEventObj.getClientName() != null && !filterEventObj.getClientName().trim().isEmpty()) {
						predicates.add(criteriaBuilder.like(
								criteriaBuilder.lower(eventRootEntity.get("guestName")),
								"%" + filterEventObj.getClientName().toLowerCase() + "%"
						));
					}

					if((filterEventObj.getLeadStatus()!=0)&&(filterEventObj.getLeadStatus()!= VistaluxConstants.VIEW_ALL_LEADS_WL_STATUS)) {
						if (filterEventObj.getLeadStatus() == VistaluxConstants.VIEW_ALL_OPEN_LEADS_WL_STATUS) {
							predicates.add(criteriaBuilder.equal(workloadStatusEntity.get("workloadCategory"), VistaluxConstants.VIEW_WL_OPEN));
							predicates.add(criteriaBuilder.equal(eventRootEntity.get("leadStatus"), workloadStatusEntity.get("workloadStatusId")));
						} else if (filterEventObj.getLeadStatus() == VistaluxConstants.VIEW_ALL_CLOSED_LEADS_WL_STATUS) {
							predicates.add(criteriaBuilder.equal(workloadStatusEntity.get("workloadCategory"), VistaluxConstants.VIEW_WL_CLOSED));
							predicates.add(criteriaBuilder.equal(eventRootEntity.get("leadStatus"), workloadStatusEntity.get("workloadStatusId")));
						}
						else{
							predicates.add(criteriaBuilder.equal(eventRootEntity.get("leadStatus"), filterEventObj.getLeadStatus() ));
						}
					}
				}
				else {
					predicates.add(criteriaBuilder.equal(eventRootEntity.get("id"), filterEventObj.getEventId()));
				}
				return criteriaBuilder.and(predicates.toArray(new Predicate[0]));
			}
		},paging);

		return filteredLeadsList;
	}

	public EventPackageEntity findEventPackageById(Long id){
		return eventPackageRepository.findById(id).get();
	}

}
