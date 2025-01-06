package com.vistaluxhms.services;
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

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.List;

@Service
public class ClientServicesImpl {
	@Autowired
	Vlx_City_Master_Repository cityRepository;

	@Autowired
	ClientEntityRepository clientRepository;

	public void saveClient(ClientEntity clientEntity) {
		clientRepository.save(clientEntity);
	}


	public List<ClientEntity> filterClients(ClientEntityDTO searchClientObj) {
		// Fetch all filtered results without pagination
		List<ClientEntity> filteredClientList = clientRepository.findAll(new Specification<ClientEntity>() {
			private static final long serialVersionUID = 1L;

			@Override
			public Predicate toPredicate(Root<ClientEntity> clientRootEntity, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {
				List<Predicate> predicates = new ArrayList<>();

				// Filter by Client ID
				if (searchClientObj.getClientId() != null && searchClientObj.getClientId() != 0) {
					predicates.add(criteriaBuilder.equal(clientRootEntity.get("clientId"), searchClientObj.getClientId()));
				}

				// Filter by Client Name
				if (searchClientObj.getClientName() != null && !searchClientObj.getClientName().trim().isEmpty()) {
					predicates.add(criteriaBuilder.like(criteriaBuilder.lower(clientRootEntity.get("clientName")),
							"%" + searchClientObj.getClientName().toLowerCase() + "%"));
				}

				return criteriaBuilder.and(predicates.toArray(new Predicate[0]));
			}
		});

		return filteredClientList;
	}

}
