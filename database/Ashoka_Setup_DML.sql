INSERT INTO `ashokadb`.`workload_status`(`id`,`workloadStatusId`,`workloadStatusObj`,`workloadStatusObjType`,`workloadStatusName`,`active`)
VALUES (1,101,'LEAD_STATUS','LEAD_STATUS','Open',true);

INSERT INTO `ashokadb`.`workload_status`(`id`,`workloadStatusId`,`workloadStatusObj`,`workloadStatusObjType`,`workloadStatusName`,`active`)
VALUES (2,102,'LEAD_STATUS','LEAD_STATUS','Work In Progress',true);

INSERT INTO `ashokadb`.`workload_status`(`id`,`workloadStatusId`,`workloadStatusObj`,`workloadStatusObjType`,`workloadStatusName`,`active`)
VALUES (3,103,'LEAD_STATUS','LEAD_STATUS','Closed',true);

INSERT INTO `ashokadb`.`eventtype` (`eventTypeId`, `eventTypeName`, `description`, `active`) VALUES ('1', 'Wedding', 'Wedding Event', '1');
INSERT INTO `ashokadb`.`eventtype` (`eventTypeId`, `eventTypeName`, `description`, `active`) VALUES ('2', 'Corporate Event', 'Corporate Event management', '1');

INSERT INTO `ashokadb`.`event_service_cost_type` (`eventServiceCostTypeId`, `eventServiceCostTypeName`) VALUES ('1', 'PER_GUEST_PER_NIGHT');
INSERT INTO `ashokadb`.`event_service_cost_type` (`eventServiceCostTypeId`, `eventServiceCostTypeName`) VALUES ('2', 'PER_GUEST_ONE_TIME');
INSERT INTO `ashokadb`.`event_service_cost_type` (`eventServiceCostTypeId`, `eventServiceCostTypeName`, `active`) VALUES ('3', 'PER_GUEST_PER_DAY', '1');
INSERT INTO `ashokadb`.`event_service_cost_type` (`eventServiceCostTypeId`, `eventServiceCostTypeName`, `active`) VALUES ('4', 'PER_ROOM_ONE_TIME', '1');
INSERT INTO `ashokadb`.`event_service_cost_type` (`eventServiceCostTypeId`, `eventServiceCostTypeName`, `active`) VALUES ('5', 'PER_ROOM_PER_NIGHT', '1');
INSERT INTO `ashokadb`.`event_service_cost_type` (`eventServiceCostTypeId`, `eventServiceCostTypeName`, `active`) VALUES ('6', 'PER_DAY', '1');
INSERT INTO `ashokadb`.`event_service_cost_type` (`eventServiceCostTypeId`, `eventServiceCostTypeName`, `active`) VALUES ('7', 'PER_NIGHT', '1');
INSERT INTO `ashokadb`.`event_service_cost_type` (`eventServiceCostTypeId`, `eventServiceCostTypeName`, `active`) VALUES ('8', 'ONE_TIME', '1');
