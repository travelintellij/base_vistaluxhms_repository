package com.vistaluxhms.repository; // package for repository interfaces

import org.springframework.data.jpa.repository.JpaRepository; // provides CRUD operations
import com.vistaluxhms.entity.Dsr; // import the Dsr entity

public interface DsrRepository extends JpaRepository<Dsr, Long> {
    // Spring will automatically generate all CRUD queries
}
