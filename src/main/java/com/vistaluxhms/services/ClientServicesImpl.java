package com.vistaluxhms.services;
import com.vistaluxhms.entity.City_Entity;
import com.vistaluxhms.entity.ClientEntity;
import com.vistaluxhms.entity.RateTypeEntity;
import com.vistaluxhms.entity.SalesPartnerEntity;
import com.vistaluxhms.model.ClientEntityDTO;
import com.vistaluxhms.model.SalesPartnerEntityDto;
import com.vistaluxhms.repository.ClientEntityRepository;
import com.vistaluxhms.repository.RateTypeRepository;
import com.vistaluxhms.repository.SalesPartnerEntityRepository;
import com.vistaluxhms.repository.Vlx_City_Master_Repository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

@Service
public class ClientServicesImpl {
	@Autowired
	Vlx_City_Master_Repository cityRepository;

	@Autowired
	ClientEntityRepository clientRepository;

	public void saveClient(ClientEntity clientEntity) {
		clientRepository.save(clientEntity);
	}


	/*	public List<ClientEntity> filterClients(ClientEntityDTO searchClientObj) {
		return clientRepository.findAll(new Specification<ClientEntity>() {
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

				if(searchClientObj.getB2b()!=null){
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
				if (searchClientObj.getCity()!=null && String.valueOf(searchClientObj.getCity().getDestinationId()).trim().length()!=0 && searchClientObj.getCity().getDestinationId() != 0) {
					predicates.add(criteriaBuilder.equal(cityJoin.get("destinationId"), searchClientObj.getCity().getDestinationId()));
				}

				// Filter by Sales Partner ID in SalesPartnerEntity
				if (searchClientObj.getSalesPartner()!=null && searchClientObj.getSalesPartner().getSalesPartnerId() != null && searchClientObj.getSalesPartner().getSalesPartnerId() != 0) {
					predicates.add(criteriaBuilder.equal(salesPartnerJoin.get("salesPartnerId"), searchClientObj.getSalesPartner().getSalesPartnerId()));
				}



				return criteriaBuilder.and(predicates.toArray(new Predicate[0]));
			}
		});
	}
*/
	public Page<ClientEntity> filterClients(ClientEntityDTO searchClientObj, Pageable pageable) {
		//Pageable pageable = PageRequest.of(pageable., pageSize);

		return clientRepository.findAll(new Specification<ClientEntity>() {
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
	public ClientEntity findClientById(Long clientId){
		return clientRepository.findById(clientId).get();
	}

	public List<ClientEntity> listAllActiveClients()   {
		List<ClientEntity> listClients= clientRepository.findAllActiveClients();
		return listClients;
	}

	public boolean existsByClientIdAndClientName(long clientId, String clientName) {
		return clientRepository.existsByclientIdAndClientName(clientId, clientName);
	}

	public ClientEntity findClientEntityForSalesPartnerId(Long salesPartnerId){
		return clientRepository.findFirstBySalesPartner_salesPartnerIdAndSalesPartnerFlag(salesPartnerId,true);
	}

}
