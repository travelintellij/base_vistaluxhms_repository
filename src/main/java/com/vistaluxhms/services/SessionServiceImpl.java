package com.vistaluxhms.services;
import com.vistaluxhms.entity.*;
import com.vistaluxhms.model.SalesPartnerEntityDto;
import com.vistaluxhms.model.SessionFilterDTO;
import com.vistaluxhms.model.SessionRateMappingEntityDTO;
import com.vistaluxhms.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
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
import java.util.stream.Collectors;

@Service
public class SessionServiceImpl {

	@Autowired
	SessionRepository sessionRepository;

	@Autowired
	RateTypeRepository rateTypeRepository;

	@Autowired
	SessionDetailsRepository sessionDetailsRepository;

	@Autowired
	private SessionRateMappingEntityRepository sessionRateMappingEntityRepository;

	public void saveSessionMaster(SessionEntity sessionEntity) {
		sessionRepository.save(sessionEntity);
	}

	public void saveSessionDetails(SessionDetailsEntity sessionDetailsEntity) {
		sessionDetailsRepository.save(sessionDetailsEntity);
	}

	public List<SessionEntity> filterSession(SessionFilterDTO sessionFilterDTO) {
		// Fetch all filtered results without pagination
		List<SessionEntity> filteredSessionList = sessionRepository.findAll(new Specification<SessionEntity>() {
			private static final long serialVersionUID = 1L;

			@Override
			public Predicate toPredicate(Root<SessionEntity> sessionEntityRoot, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {
				List<Predicate> predicates = new ArrayList<>();

				// Filter by Sales Partner ID
				if (sessionFilterDTO.getSessionId() != null && sessionFilterDTO.getSessionId() != 0) {
					predicates.add(criteriaBuilder.equal(sessionEntityRoot.get("sessionId"), sessionFilterDTO.getSessionId()));
				}

				// Filter by Sales Partner Short Name
				if (sessionFilterDTO.getSessionName() != null && !sessionFilterDTO.getSessionName().trim().isEmpty()) {
					predicates.add(criteriaBuilder.like(criteriaBuilder.lower(sessionEntityRoot.get("sessionName")),
							"%" + sessionFilterDTO.getSessionName().toLowerCase() + "%"));
				}



				// Filter by Active Status
				if (sessionFilterDTO.getActive() != null) {
					predicates.add(criteriaBuilder.equal(sessionEntityRoot.get("active"), sessionFilterDTO.getActive()));
				}
				//query.orderBy(criteriaBuilder.desc(sessionEntityRoot.get("updatedAt")));
				query.orderBy(
						criteriaBuilder.asc(criteriaBuilder.selectCase()
								.when(criteriaBuilder.isTrue(sessionEntityRoot.get("active")), 0)  // Active first
								.otherwise(1)), // Inactive later
						criteriaBuilder.desc(sessionEntityRoot.get("updatedAt")) // Sort by updatedAt
				);
				return criteriaBuilder.and(predicates.toArray(new Predicate[0]));
			}
		});

		return filteredSessionList;
	}

	public SessionEntity findSessionById(Integer sessionId){
		return sessionRepository.findById(sessionId).get();
	}

	public Optional<SessionDetailsEntity> findSessionDetailsEntity(int sessionId, int roomCategoryId, int mealPlanId){
		SessionDetailId sessionDetailId = new SessionDetailId(sessionId, roomCategoryId, mealPlanId);
		return sessionDetailsRepository.findById(sessionDetailId);
	}

	public List<SessionRateMappingEntity> filterSessionRateMappingBySessionId(Integer sessionId){
			return sessionRateMappingEntityRepository.findBySessionEntity_SessionIdAndActiveTrue(sessionId);
	}


	@Transactional
	public SessionRateMappingEntity addSessionRateMapping(SessionRateMappingEntity sessionRateMapping) {
		return sessionRateMappingEntityRepository.save(sessionRateMapping);
	}


	public boolean isRateTypeConflict(int rateTypeId, LocalDate startDate, LocalDate endDate) {
		return sessionRateMappingEntityRepository.existsConflictingMapping(rateTypeId, startDate, endDate);
	}

	public void saveSessionRateMapping(SessionRateMappingEntityDTO sessionRateMappingEntityDTO) {
		SessionEntity sessionEntity = sessionRepository.findById(sessionRateMappingEntityDTO.getSessionId())
				.orElseThrow(() -> new RuntimeException("Session not found"));

		RateTypeEntity rateTypeEntity = rateTypeRepository.findById(sessionRateMappingEntityDTO.getRateTypeId())
				.orElseThrow(() -> new RuntimeException("Rate Type not found"));

		SessionRateMappingEntity mapping = new SessionRateMappingEntity(
				sessionEntity, rateTypeEntity, sessionRateMappingEntityDTO.getStartDate(), sessionRateMappingEntityDTO.getEndDate());

		SessionRateMappingEntity sessionRateMappingEntity = sessionRateMappingEntityRepository.save(mapping);
		sessionRateMappingEntityDTO.setSessionRateTypeId(sessionRateMappingEntity.getSessionRateTypeId());
	}

	public void updateSessionRateMapping(SessionRateMappingEntityDTO sessionRateMappingEntityDTO) {
		SessionEntity sessionEntity = sessionRepository.findById(sessionRateMappingEntityDTO.getSessionId())
				.orElseThrow(() -> new RuntimeException("Session not found"));

		RateTypeEntity rateTypeEntity = rateTypeRepository.findById(sessionRateMappingEntityDTO.getRateTypeId())
				.orElseThrow(() -> new RuntimeException("Rate Type not found"));

		SessionRateMappingEntity mapping = sessionRateMappingEntityRepository.findById(sessionRateMappingEntityDTO.getSessionRateTypeId()).get();
		mapping.setStartDate(sessionRateMappingEntityDTO.getStartDate());
		mapping.setEndDate(sessionRateMappingEntityDTO.getEndDate());

		SessionRateMappingEntity sessionRateMappingEntity = sessionRateMappingEntityRepository.save(mapping);
		sessionRateMappingEntityDTO.setSessionRateTypeId(sessionRateMappingEntity.getSessionRateTypeId());
	}



	public SessionRateMappingEntity findSessionRateMappingEntityById(Integer sessionRateMappingId){
		return sessionRateMappingEntityRepository.findById(sessionRateMappingId).get();
	}


	public void deleteSessionRateMapping(SessionRateMappingEntityDTO sessionRateMappingEntityDTO) {
		SessionRateMappingEntity sessionRateMappingEntity = sessionRateMappingEntityRepository.findById(sessionRateMappingEntityDTO.getSessionRateTypeId()).get();
		sessionRateMappingEntity.setActive(false);
		sessionRateMappingEntityRepository.save(sessionRateMappingEntity);
	}
}
