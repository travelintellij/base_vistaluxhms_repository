package com.vistaluxhms.services;

import com.vistaluxhms.entity.City_Entity;
import com.vistaluxhms.entity.ClientEntity;
import com.vistaluxhms.entity.LeadEntity;
import com.vistaluxhms.entity.SalesPartnerEntity;
import com.vistaluxhms.model.ClientEntityDTO;
import com.vistaluxhms.repository.ClientEntityRepository;
import com.vistaluxhms.repository.LeadEntityRepository;
import com.vistaluxhms.repository.Vlx_City_Master_Repository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.*;
import java.util.ArrayList;
import java.util.List;

@Service
public class LeadServicesImpl {
	@Autowired
	Vlx_City_Master_Repository cityRepository;

	@Autowired
	LeadEntityRepository leadRepository;

	public void saveLead(LeadEntity leadEntity) {
		leadRepository.save(leadEntity);
	}


	/*

	public Page<ClientEntity> filterLead(LeadEntityDTO searchLeadObj, Pageable pageable) {
		//Pageable pageable = PageRequest.of(pageable., pageSize);

		return leadRepository.findAll(new Specification<ClientEntity>() {
			private static final long serialVersionUID = 1L;

			@Override
			public Predicate toPredicate(Root<ClientEntity> clientRootEntity, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {
				List<Predicate> predicates = new ArrayList<>();

				// Join with CityEntity
				Join<ClientEntity, City_Entity> cityJoin = clientRootEntity.join("city", JoinType.LEFT);

				// Join with SalesPartnerEntity
				Join<ClientEntity, SalesPartnerEntity> salesPartnerJoin = clientRootEntity.join("salesPartner", JoinType.LEFT);

				// Filter by Client ID
				if (searchClientObj.getClientId() != null && searchClientObj.getClientId() != 0) {
					predicates.add(criteriaBuilder.equal(clientRootEntity.get("clientId"), searchClientObj.getClientId()));
				}

				if(searchClientObj.getB2b() != null){
					predicates.add(criteriaBuilder.equal(clientRootEntity.get("b2b"), searchClientObj.getB2b()));
				}

				// Filter by Active Status
				if (searchClientObj.getActive() != null) {
					predicates.add(criteriaBuilder.equal(clientRootEntity.get("active"), searchClientObj.getActive()));
				}

				// Filter by Client Name
				if (searchClientObj.getClientName() != null && !searchClientObj.getClientName().trim().isEmpty()) {
					predicates.add(criteriaBuilder.like(
							criteriaBuilder.lower(clientRootEntity.get("clientName")),
							"%" + searchClientObj.getClientName().toLowerCase() + "%"
					));
				}
				// Filter by Destination ID in CityEntity
				if (searchClientObj.getCity() != null && String.valueOf(searchClientObj.getCity().getDestinationId()).trim().length() != 0 && searchClientObj.getCity().getDestinationId() != 0) {
					predicates.add(criteriaBuilder.equal(cityJoin.get("destinationId"), searchClientObj.getCity().getDestinationId()));
				}

				// Filter by Sales Partner ID in SalesPartnerEntity
				if (searchClientObj.getSalesPartner() != null && searchClientObj.getSalesPartner().getSalesPartnerId() != null && searchClientObj.getSalesPartner().getSalesPartnerId() != 0) {
					predicates.add(criteriaBuilder.equal(salesPartnerJoin.get("salesPartnerId"), searchClientObj.getSalesPartner().getSalesPartnerId()));
				}

				return criteriaBuilder.and(predicates.toArray(new Predicate[0]));
			}
		}, pageable);
	}

	 */
	public LeadEntity findLeadById(Long leadId){
		return leadRepository.findById(leadId).get();
	}
}
