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
        List<SessionRateMappingEntity> findBySessionEntity_SessionIdAndActiveTrue(Integer sessionId);

        // Fetch mappings by rateTypeId
        List<SessionRateMappingEntity> findByRateTypeEntity_RateTypeIdAndActiveTrue(Integer rateTypeId);

        @Query("SELECT CASE WHEN COUNT(s) > 0 THEN TRUE ELSE FALSE END " +
                "FROM SessionRateMappingEntity s " +
                "WHERE s.rateTypeEntity.rateTypeId = :rateTypeId " + // ✅ Use correct PK field
                "AND ((s.startDate <= :endDate AND s.endDate >= :startDate))" +
                "AND s.active = TRUE"
        )
        boolean existsConflictingMapping(@Param("rateTypeId") int rateTypeId,
                                         @Param("startDate") LocalDate startDate,
                                         @Param("endDate") LocalDate endDate);

        List<SessionRateMappingEntity> findByRateTypeEntityRateTypeIdOrderByStartDateDesc(Integer rateTypeId);


}