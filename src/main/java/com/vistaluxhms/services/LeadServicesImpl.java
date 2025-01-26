package com.vistaluxhms.services;

import com.vistaluxhms.entity.City_Entity;
import com.vistaluxhms.entity.ClientEntity;
import com.vistaluxhms.entity.LeadEntity;
import com.vistaluxhms.entity.SalesPartnerEntity;
import com.vistaluxhms.model.ClientEntityDTO;
import com.vistaluxhms.model.FilterLeadObj;
import com.vistaluxhms.repository.ClientEntityRepository;
import com.vistaluxhms.repository.LeadEntityRepository;
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
public class LeadServicesImpl {
	@Autowired
	Vlx_City_Master_Repository cityRepository;

	@Autowired
	LeadEntityRepository leadRepository;

	public void saveLead(LeadEntity leadEntity) {
		leadRepository.save(leadEntity);
	}


	public Page<LeadEntity>  filterLeads(int pageNo, int pageSize, long leadOwner, String sorting, FilterLeadObj filterLeadObj, boolean isAdmin ) {
		Pageable paging = PageRequest.of(pageNo, pageSize, Sort.by(sorting));
		Date currentDate = Date.from(java.time.ZonedDateTime.now().toInstant());
		GregorianCalendar cal = new GregorianCalendar();
		cal.setTime(currentDate);
		cal.add(Calendar.DATE, -365);
		Date criteriaDate = cal.getTime();
		boolean isLeadAdmin=false;
		Page<LeadEntity> filteredLeadsList = leadRepository.findAll(new Specification<LeadEntity>() {
			private static final long serialVersionUID = 1L;
			@Override
			public Predicate toPredicate(Root<LeadEntity> leadsRootEntity, CriteriaQuery< ?> query, CriteriaBuilder criteriaBuilder) {
				//CriteriaQuery<Udn_Deals_Recorder_Entity> criteriaQueryDeal = criteriaBuilder.createQuery(Udn_Deals_Recorder_Entity.class);
				List<Predicate> predicates = new ArrayList<>();
				//if(!(isAdmin||isLeadAdmin)) {
				query.distinct(true);
				if(leadOwner!=0) {
					if(filterLeadObj.isOnlyLeadOwner()) {
						predicates.add(criteriaBuilder.equal(leadsRootEntity.get("leadOwner"), leadOwner));
					}
					else {
						Root<LeadEntity> rootLeadsTeamMapEntity = query.from(LeadEntity.class);
						List<Predicate> teamListPredicatesList = new ArrayList<>();
						Predicate notNullPredicate = criteriaBuilder.isNotNull(rootLeadsTeamMapEntity.get("leadId"));
						Predicate serviceCityPredcate =criteriaBuilder.equal( rootLeadsTeamMapEntity.get("userId"),leadOwner);
						Predicate supplierPredcate =criteriaBuilder.equal(leadsRootEntity.get("leadId"), rootLeadsTeamMapEntity.get("leadId"));
						Predicate finalJoinPredicate = criteriaBuilder.and(serviceCityPredcate,supplierPredcate,notNullPredicate);
						Predicate leadOwnerPredicatee = criteriaBuilder.equal(leadsRootEntity.get("leadOwner"), leadOwner);
						Predicate finalUltimatePredicate = criteriaBuilder.or(leadOwnerPredicatee,finalJoinPredicate);
						//teamListPredicatesList.add(leadOwnerPredicatee);
						teamListPredicatesList.add(finalUltimatePredicate);
						predicates.addAll(teamListPredicatesList);
					}
				}
				//}
				if(filterLeadObj.getLeadId()==0) {
					if(filterLeadObj.getDateCriteria()!=0) {
						String dateCriteria="";
						if(filterLeadObj.getDateCriteria()==1) {
							dateCriteria="createdAt";
						}
						else {
							dateCriteria="travelStartDate";
						}
						Date dateTo;
						Date dateFrom;
						try {
							dateTo = new SimpleDateFormat("yyyy-MM-dd").parse(filterLeadObj.getEndDate());
							dateFrom=new SimpleDateFormat("yyyy-MM-dd").parse(filterLeadObj.getStartDate());
							predicates.add(criteriaBuilder.between(leadsRootEntity.get(dateCriteria),dateFrom,dateTo));
						} catch (ParseException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}else {
						predicates.add(criteriaBuilder.greaterThanOrEqualTo(leadsRootEntity.get("createdAt"),criteriaDate));
					}
					if(filterLeadObj.getClientId()!=0) {
						predicates.add(criteriaBuilder.equal(leadsRootEntity.get("contactId"), filterLeadObj.getClientId()));
					}
					if(filterLeadObj.getSource()!=0) {
						predicates.add(criteriaBuilder.equal(leadsRootEntity.get("source"), filterLeadObj.getSource()));
					}

					/*if((filterLeadObj.getLeadStatus()!=0)&&(filterLeadObj.getLeadStatus()!= VistaluxConstants.VIEW_ALL_CLOSED_LEADS_WL_STATUS)&&(filterLeadObj.getLeadStatus()!=VistaluxConstants.VIEW_ALL_OPEN_LEADS_WL_STATUS)) {
						predicates.add(criteriaBuilder.equal(leadsRootEntity.get("leadStatus"), filterLeadObj.getLeadStatus()));
					}else if(filterLeadObj.getLeadStatus()==VistaluxConstants.VIEW_ALL_CLOSED_LEADS_WL_STATUS){
						predicates.add(criteriaBuilder.greaterThan(leadsRootEntity.get("leadStatus"), VistaluxConstants.LEAD_WL_STATUS_THRESHOLD_OPEN));
					}

					else if(filterLeadObj.getLeadStatus()==VistaluxConstants.VIEW_ALL_OPEN_LEADS_WL_STATUS){
						predicates.add(criteriaBuilder.lessThanOrEqualTo(leadsRootEntity.get("leadStatus"), VistaluxConstants.LEAD_WL_STATUS_THRESHOLD_OPEN));
					}

					 */
					if(filterLeadObj.getLeadSource()!=0) {
						predicates.add(criteriaBuilder.equal(leadsRootEntity.get("leadSource"), filterLeadObj.getLeadSource()));
					}
					if(filterLeadObj.isQualified()) {
						predicates.add(criteriaBuilder.equal(leadsRootEntity.get("isQualified"), filterLeadObj.isQualified()));
					}
					if(filterLeadObj.isFlagged()) {
						predicates.add(criteriaBuilder.equal(leadsRootEntity.get("isFlagged"), filterLeadObj.isFlagged()));
					}
				}
				else {
					predicates.add(criteriaBuilder.equal(leadsRootEntity.get("leadId"), filterLeadObj.getLeadId()));
				}
				return criteriaBuilder.and(predicates.toArray(new Predicate[0]));
			}
		},paging);

		return filteredLeadsList;
	}

	public LeadEntity findLeadById(Long leadId){
		return leadRepository.findById(leadId).get();
	}
}
