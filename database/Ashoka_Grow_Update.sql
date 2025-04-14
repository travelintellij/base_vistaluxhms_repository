CREATE TABLE `leads_followup` (
  `leadFollowupId` bigint NOT NULL AUTO_INCREMENT,
  `leadId` bigint DEFAULT NULL,
  `followuptime` datetime DEFAULT NULL,
  `response` varchar(2000) DEFAULT NULL,
  `nextfollowuptime` datetime DEFAULT NULL,
  `nextactionplan` varchar(2000) DEFAULT NULL,
  `updatedBy` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`leadFollowupId`),
  KEY `Lead_Followup_ID_idx` (`leadId`),
  KEY `Lead_Followup_USR_idx` (`updatedBy`),
  CONSTRAINT `Lead_Followup_ID` FOREIGN KEY (`leadId`) REFERENCES `lead_master` (`leadId`),
  CONSTRAINT `Lead_Followup_USR` FOREIGN KEY (`updatedBy`) REFERENCES `ashokateam` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=20869 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;