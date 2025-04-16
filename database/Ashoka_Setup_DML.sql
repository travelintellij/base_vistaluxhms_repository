INSERT INTO `ashokadb`.`workload_status`(`id`,`workloadStatusId`,`workloadStatusObj`,`workloadStatusObjType`,`workloadStatusName`,`active`)
VALUES (1,101,'LEAD_STATUS','LEAD_STATUS','Open',true);

INSERT INTO `ashokadb`.`workload_status`(`id`,`workloadStatusId`,`workloadStatusObj`,`workloadStatusObjType`,`workloadStatusName`,`active`)
VALUES (2,102,'LEAD_STATUS','LEAD_STATUS','Work In Progress',true);

INSERT INTO `ashokadb`.`workload_status`(`id`,`workloadStatusId`,`workloadStatusObj`,`workloadStatusObjType`,`workloadStatusName`,`active`)
VALUES (3,103,'LEAD_STATUS','LEAD_STATUS','Closed',true);

INSERT INTO `ashokadb`.`eventtype` (`eventTypeId`, `eventTypeName`, `description`, `active`) VALUES ('1', 'Wedding', 'Wedding Event', '1');
INSERT INTO `ashokadb`.`eventtype` (`eventTypeId`, `eventTypeName`, `description`, `active`) VALUES ('2', 'Corporate Event', 'Corporate Event management', '1');
