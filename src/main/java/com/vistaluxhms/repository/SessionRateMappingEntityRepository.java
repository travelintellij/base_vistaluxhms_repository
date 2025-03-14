package com.vistaluxhms.repository;

import com.vistaluxhms.entity.SessionRateMappingEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;

public interface SessionRateMappingEntityRepository extends JpaRepository<SessionRateMappingEntity, Integer> {

        @Query("SELECT s.rateTypeEntity.rateTypeId FROM SessionRateMappingEntity s WHERE s.sessionEntity.sessionId = :sessionId")
        List<Integer> findRateTypeIdsBySessionId(@Param("sessionId") Integer sessionId);

        // Fetch mappings by sessionId
        List<SessionRateMappingEntity> findBySessionEntity_SessionId(Integer sessionId);

        // Fetch mappings by rateTypeId
        List<SessionRateMappingEntity> findByRateTypeEntity_RateTypeId(Integer rateTypeId);

        // Check if a rate type is already assigned to a session within a given date range (for validation)
        @Query("SELECT COUNT(srm) > 0 FROM SessionRateMappingEntity srm " +
                "WHERE srm.sessionEntity.sessionId = :sessionId " +
                "AND srm.rateTypeEntity.rateTypeId = :rateTypeId " +
                "AND (:startDate BETWEEN srm.startDate AND srm.endDate " +
                "OR :endDate BETWEEN srm.startDate AND srm.endDate " +
                "OR srm.startDate BETWEEN :startDate AND :endDate)")
        boolean existsOverlappingRate(@Param("sessionId") Integer sessionId,
                                      @Param("rateTypeId") Integer rateTypeId,
                                      @Param("startDate") LocalDate startDate,
                                      @Param("endDate") LocalDate endDate);

}