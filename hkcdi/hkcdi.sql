

-- Dumping structure for table hkcdi_db.tb_api_txn_log
CREATE TABLE IF NOT EXISTS `tb_api_txn_log` (
  `api_txn_log_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `api_name` varchar(100) DEFAULT NULL,
  `hkcdi_id` varchar(36) DEFAULT NULL,
  `request` longtext DEFAULT NULL,
  `response` longtext DEFAULT NULL,
  `request_dt` datetime DEFAULT NULL,
  `response_dt` datetime DEFAULT NULL,
  `status_code` varchar(10) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `source` varchar(256) DEFAULT NULL,
  `destination` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`api_txn_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='API Transaction Log Table';

-- Data exporting was unselected.

-- Dumping structure for table hkcdi_db.tb_batch_log
CREATE TABLE IF NOT EXISTS `tb_batch_log` (
  `batch_ref_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `entity_name` varchar(100) DEFAULT NULL COMMENT 'The identifier of the batch job',
  `batch_type` varchar(100) DEFAULT NULL,
  `description` varchar(256) DEFAULT NULL COMMENT 'Details of the action',
  `batch_status` varchar(20) DEFAULT NULL,
  `start_dt` datetime DEFAULT NULL COMMENT 'The start time of the batch',
  `end_dt` datetime DEFAULT NULL COMMENT 'The end time of the batch',
  PRIMARY KEY (`batch_ref_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Batch Log Table';

-- Data exporting was unselected.

-- Dumping structure for table hkcdi_db.tb_cdims_action_audit
CREATE TABLE IF NOT EXISTS `tb_cdims_action_audit` (
  `cdims_action_audit_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user` varchar(20) DEFAULT NULL,
  `user_role` varchar(20) DEFAULT NULL,
  `action_type` varchar(20) DEFAULT NULL,
  `action_time` datetime DEFAULT NULL,
  `action_description` varchar(100) DEFAULT NULL,
  `session_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cdims_action_audit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='This table log the user action in the CDIMS';

-- Data exporting was unselected.

-- Dumping structure for table hkcdi_db.tb_cdims_ccra_case_details
CREATE TABLE IF NOT EXISTS `tb_cdims_ccra_case_details` (
  `cdims_ccra_case_details_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `hkcdi_id` varchar(36) DEFAULT NULL COMMENT 'in relation to tb_hcdi_case.hkcdi_id',
  `application_no` varchar(50) DEFAULT NULL,
  `application_type` varchar(50) DEFAULT NULL,
  `application_status` varchar(50) DEFAULT NULL,
  `relationship_manager` varchar(50) DEFAULT NULL,
  `segment` varchar(5) DEFAULT NULL,
  `rm_team` varchar(20) DEFAULT NULL COMMENT 'FK: tb_ibg_rm_team.ibg_rm_team',
  `company_contact` varchar(256) DEFAULT NULL,
  `relationship_nature` varchar(20) DEFAULT NULL,
  `request_date` datetime DEFAULT NULL,
  `request_status` varchar(20) DEFAULT NULL,
  `request_error_code` varchar(20) DEFAULT NULL,
  `request_status_description` varchar(256) DEFAULT NULL,
  `date_of_ordering` datetime DEFAULT NULL,
  `br_number` varchar(20) DEFAULT NULL,
  `cr_number` varchar(20) DEFAULT NULL,
  `country_of_issue` varchar(3) DEFAULT NULL COMMENT 'FK: tb_iso_ctry_code.country_alpha_3_code',
  PRIMARY KEY (`cdims_ccra_case_details_id`),
  KEY `FK_tb_cdims_ccra_case_details_tb_ibg_rm_team` (`rm_team`),
  KEY `FK_tb_cdims_ccra_case_details_tb_iso_ctry_code` (`country_of_issue`),
  CONSTRAINT `FK_tb_cdims_ccra_case_details_tb_ibg_rm_team` FOREIGN KEY (`rm_team`) REFERENCES `tb_ibg_rm_team` (`ibg_rm_team`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_tb_cdims_ccra_case_details_tb_iso_ctry_code` FOREIGN KEY (`country_of_issue`) REFERENCES `tb_iso_ctry_code` (`country_alpha_3_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='The data in this table is specific for CCRA use case';

-- Data exporting was unselected.

-- Dumping structure for table hkcdi_db.tb_cdims_ccra_credit_data_resp
CREATE TABLE IF NOT EXISTS `tb_cdims_ccra_credit_data_resp` (
  `credit_data_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `hkcdi_id` varchar(36) DEFAULT NULL COMMENT 'in relation to tb_hcdi_case.hkcdi_id',
  `ccra_data_resp_status` varchar(4) DEFAULT NULL,
  `created_dt` datetime DEFAULT NULL,
  `modified_dt` datetime DEFAULT NULL,
  `ccra_data_json` longtext DEFAULT NULL,
  `ccra_data_html` blob DEFAULT NULL,
  PRIMARY KEY (`credit_data_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='The data in this table is specific for CCRA use case';

-- Data exporting was unselected.

-- Dumping structure for table hkcdi_db.tb_cdims_ccra_disposal_record
CREATE TABLE IF NOT EXISTS `tb_cdims_ccra_disposal_record` (
  `disposal_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `source` varchar(20) DEFAULT NULL COMMENT '"Allowed value:\n\nAuto disposal, Manual Disposal, Disposal by API"',
  `created_dt` datetime DEFAULT NULL COMMENT '"Default: CURRENT_TIMESTAMP\nFormat: YYYY-MM-DD HH:MM:DD"',
  `action_dt` datetime DEFAULT NULL,
  `update_user` varchar(20) DEFAULT NULL,
  `hkcdi_id` varchar(36) DEFAULT NULL COMMENT 'in relation to tb_hcdi_case.hkcdi_id',
  PRIMARY KEY (`disposal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='This table record all the CCRA credit data disposal action';

-- Data exporting was unselected.

-- Dumping structure for table hkcdi_db.tb_hcdi_case
CREATE TABLE IF NOT EXISTS `tb_hcdi_case` (
  `hkcdi_id` varchar(36) NOT NULL COMMENT 'The unique ID across HKCDI application',
  `source` varchar(10) DEFAULT NULL COMMENT 'SFW / CDIMS',
  `use_case` varchar(15) DEFAULT NULL COMMENT 'CDI-CCRA',
  `is_external_api_request` varchar(2) DEFAULT NULL COMMENT 'Y / N',
  `api_callback_url` varchar(512) DEFAULT NULL COMMENT 'The result callback to the external request system',
  `api_callback_status` varchar(5) DEFAULT NULL,
  `created_dt` datetime DEFAULT NULL,
  `modified_dt` datetime DEFAULT NULL,
  PRIMARY KEY (`hkcdi_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='The base table of the case created in HCD';

-- Data exporting was unselected.

-- Dumping structure for table hkcdi_db.tb_hcdi_ccra_dnb_data_request
CREATE TABLE IF NOT EXISTS `tb_hcdi_ccra_dnb_data_request` (
  `ccra_dnb_data_request_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `hkcdi_id` varchar(36) DEFAULT NULL COMMENT 'in relation to tb_hcdi_data_request.hcdi_data_request_id',
  `report_type` varchar(4) DEFAULT NULL,
  `reason_code` varchar(2) DEFAULT NULL,
  `aiRefCode1` varchar(30) DEFAULT NULL,
  `aiRefCode2` varchar(30) DEFAULT NULL,
  `aiRefCode3` varchar(30) DEFAULT NULL,
  `reorder_in_7_days` tinyint(2) DEFAULT NULL COMMENT '1:true 0:false',
  `company_id` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ccra_dnb_data_request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='The data fields are CCRA specific, the data is sent to DNB';

-- Data exporting was unselected.

-- Dumping structure for table hkcdi_db.tb_hcdi_consent
CREATE TABLE IF NOT EXISTS `tb_hcdi_consent` (
  `hcdi_consent_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `hkcdi_id` varchar(36) DEFAULT NULL COMMENT 'in relation to tb_hcdi_case.hkcdi_id',
  `hcdi_data_owner_id` bigint(20) DEFAULT NULL COMMENT 'in relation to tb_hcdi_data_owner.hcdi_date_owner_id',
  `use_case` varchar(15) DEFAULT NULL,
  `consent_type` varchar(30) DEFAULT NULL COMMENT '"3 consent types that a participant can submit\n\nAllowed value:\nConsentTypeSignedDocRequired, ConsentTypeSignedDocNotRequired, ConsentTypeConsentNotRequired \n\nCCRA user case: ConsentTypeConsentNotRequired"',
  `scope_type` varchar(30) DEFAULT NULL COMMENT 'CCRA use case: DataScopeTypeUDR',
  `scope_document_type` varchar(20) DEFAULT NULL COMMENT 'CCRA use case: CCRA Report',
  `scope_udr` varchar(20) DEFAULT NULL COMMENT 'CCRA use case: CCRA Report',
  `scope_start_date` datetime DEFAULT NULL,
  `scope_end_date` datetime DEFAULT NULL,
  `expire_time` datetime DEFAULT NULL,
  `public_purpose` varchar(100) DEFAULT NULL,
  `private_purpose` varchar(100) DEFAULT NULL,
  `consent_id_cdi` varchar(36) DEFAULT NULL COMMENT 'the consent Id generated and returned from CDI API, it is UUID format.',
  `consent_status_cdi` varchar(50) DEFAULT NULL COMMENT 'The status of data owner creation',
  `created_dt` datetime DEFAULT NULL,
  `modified_dt` datetime DEFAULT NULL,
  PRIMARY KEY (`hcdi_consent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='This table are generic for all CDI use case, the data is sent to CDI';

-- Data exporting was unselected.

-- Dumping structure for table hkcdi_db.tb_hcdi_consent_tmp
CREATE TABLE IF NOT EXISTS `tb_hcdi_consent_tmp` (
  `hcdi_consent_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `hkcdi_id` varchar(36) DEFAULT NULL COMMENT 'in relation to tb_hcdi_case.hkcdi_id',
  `hcdi_data_owner_id` bigint(20) DEFAULT NULL COMMENT 'in relation to tb_hcdi_data_owner.hcdi_date_owner_id',
  `use_case` varchar(15) DEFAULT NULL,
  `consent_type` varchar(30) DEFAULT NULL COMMENT '"3 consent types that a participant can submit\n\nAllowed value:\nConsentTypeSignedDocRequired, ConsentTypeSignedDocNotRequired, ConsentTypeConsentNotRequired \n\nCCRA user case: ConsentTypeConsentNotRequired"',
  `scope_type` varchar(30) DEFAULT NULL COMMENT 'CCRA use case: DataScopeTypeUDR',
  `scope_document_type` varchar(30) DEFAULT NULL COMMENT 'CCRA use case: CCRA Report',
  `scope_udr` varchar(20) DEFAULT NULL COMMENT 'CCRA use case: CCRA Report',
  `scope_start_date` datetime DEFAULT NULL,
  `scope_end_date` datetime DEFAULT NULL,
  `expire_time` datetime DEFAULT NULL COMMENT '"Unix time format in the API call\n\nCCRA use case: 0"',
  `public_purpose` varchar(100) DEFAULT NULL,
  `private_purpose` varchar(100) DEFAULT NULL,
  `consent_id_cdi` varchar(36) DEFAULT NULL COMMENT 'the consent Id generated and returned from CDI API, it is UUID format.',
  `consent_status_cdi` varchar(50) DEFAULT NULL COMMENT 'The status of data owner creation',
  `created_dt` datetime DEFAULT NULL,
  `modified_dt` datetime DEFAULT NULL,
  PRIMARY KEY (`hcdi_consent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='This table are generic for all CDI use case, the data is sent to CDI';

-- Data exporting was unselected.

-- Dumping structure for table hkcdi_db.tb_hcdi_data_access_info
CREATE TABLE IF NOT EXISTS `tb_hcdi_data_access_info` (
  `data_access_info_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `hcdi_data_request_id` bigint(20) DEFAULT NULL COMMENT 'in relation to tb_hcdi_data_request.hcdi_data_request_id',
  `response_id_cdi` varchar(36) DEFAULT NULL,
  `status_confirm_reception` varchar(2) DEFAULT NULL,
  `hkcdi_id` varchar(36) DEFAULT NULL,
  `cdi_channel` varchar(50) DEFAULT NULL,
  `cdi_endpoint` varchar(250) DEFAULT NULL,
  `cdi_token` varchar(250) DEFAULT NULL,
  `cdi_file_type` varchar(50) DEFAULT NULL,
  `cdi_file_path` varchar(250) DEFAULT NULL,
  `cdi_file_hash` varchar(250) DEFAULT NULL,
  `data_owner_reference_dp_cdi` varchar(200) DEFAULT NULL,
  `created_dt` datetime DEFAULT NULL,
  `modified_dt` datetime DEFAULT NULL,
  PRIMARY KEY (`data_access_info_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='This table are generic for all CDI use case, the data is sent to CDI';

-- Data exporting was unselected.

-- Dumping structure for table hkcdi_db.tb_hcdi_data_owner
CREATE TABLE IF NOT EXISTS `tb_hcdi_data_owner` (
  `hcdi_data_owner_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `hkcdi_id` varchar(36) DEFAULT NULL COMMENT 'in relation to tb_hcdi_case.hkcdi_id',
  `data_owner_name` varchar(512) DEFAULT NULL COMMENT 'The name of the data owner',
  `br_no` varchar(20) DEFAULT NULL COMMENT '"To input in the create data owner request. Business Reference Number which is assigned by IRD at the date of incorporation. This can also support entity registered overseas. \n\nExample:\nHKG:12345678\nVGB:98765"',
  `cr_no` varchar(20) DEFAULT NULL COMMENT '"To input in the create data owner request. Company Reference Number. It serves as the secondary identifier of the data owner in CDI. This is applicable to limited company\n\nExample:\nHKG:28282828"',
  `lei` varchar(30) DEFAULT NULL COMMENT '"To input in the create data owner request, NA for CDI-CCRA use case\n\nLegal Entity Identifier of the data owner, which is a 20 character alphanumeric code that is unique to a legal entity"',
  `data_owner_reference` varchar(50) DEFAULT NULL COMMENT '"To input in the create data owner request\n\nReference field to identify the data owner for data provider. It can input the ID and branch name in data provider context, depending on data provider’s requirements."',
  `remark` varchar(100) DEFAULT NULL,
  `data_owner_id_cdi` varchar(36) DEFAULT NULL COMMENT 'The unique identifier returned in CDI API',
  `status_cdi` varchar(20) DEFAULT NULL COMMENT 'The status of data owner creation',
  `created_dt` datetime DEFAULT NULL COMMENT 'The timestamp that the record is created',
  `modified_dt` datetime DEFAULT NULL COMMENT 'The timestamp that the record is modified',
  PRIMARY KEY (`hcdi_data_owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='This table are generic for all CDI use case, the data is sent to CDI';

-- Data exporting was unselected.

-- Dumping structure for table hkcdi_db.tb_hcdi_data_request
CREATE TABLE IF NOT EXISTS `tb_hcdi_data_request` (
  `hcdi_data_request_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `hkcdi_id` varchar(36) DEFAULT NULL COMMENT 'in relation to tb_hcdi_case.hkcdi_id',
  `hcdi_consent_id` bigint(20) DEFAULT NULL COMMENT 'in relation to tb_hcdi_consent.hcdi_consent_id',
  `scope_type` varchar(30) DEFAULT NULL COMMENT 'CCRA use case: DataScopeTypeUDR',
  `scope_document_type` varchar(20) DEFAULT NULL COMMENT 'CCRA use case: CCRA Report',
  `scope_udr` varchar(20) DEFAULT NULL COMMENT 'CCRA use case: CCRA Report',
  `scope_start_date` datetime DEFAULT NULL,
  `scope_end_date` datetime DEFAULT NULL,
  `public_purpose` varchar(100) DEFAULT NULL,
  `private_purpose` varchar(100) DEFAULT NULL,
  `data_request_status_cdi` varchar(50) DEFAULT NULL,
  `data_request_id_cdi` varchar(50) DEFAULT NULL COMMENT 'The data request id returned from CDI, the format is UUID',
  `reject_reason_code_cdi` varchar(50) DEFAULT NULL,
  `reject_reason_detail_cdi` varchar(200) DEFAULT NULL,
  `created_dt` datetime DEFAULT NULL,
  `modified_dt` datetime DEFAULT NULL,
  PRIMARY KEY (`hcdi_data_request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='This table are generic for all CDI use case, the data is sent to CDI';

-- Data exporting was unselected.

-- Dumping structure for table hkcdi_db.tb_hcdi_data_request_tmp
CREATE TABLE IF NOT EXISTS `tb_hcdi_data_request_tmp` (
  `hcdi_data_request_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `hkcdi_id` varchar(36) DEFAULT NULL COMMENT 'in relation to tb_hcdi_case.hkcdi_id',
  `hcdi_consent_id` bigint(20) DEFAULT NULL COMMENT 'in relation to tb_hcdi_consent.hcdi_consent_id',
  `scope_type` varchar(30) DEFAULT NULL COMMENT 'CCRA use case: DataScopeTypeUDR',
  `scope_document_type` varchar(20) DEFAULT NULL COMMENT 'CCRA use case: CCRA Report',
  `scope_udr` varchar(20) DEFAULT NULL COMMENT 'CCRA use case: CCRA Report',
  `scope_start_date` datetime DEFAULT NULL,
  `scope_end_date` datetime DEFAULT NULL,
  `public_purpose` varchar(100) DEFAULT NULL,
  `private_purpose` varchar(100) DEFAULT NULL,
  `data_request_status_cdi` varchar(50) DEFAULT NULL,
  `data_request_id_cdi` varchar(50) DEFAULT NULL COMMENT 'The data request id returned from CDI, the format is UUID',
  `reject_reason_code_cdi` varchar(50) DEFAULT NULL,
  `reject_reason_detail_cdi` varchar(200) DEFAULT NULL,
  `created_dt` datetime DEFAULT NULL,
  `modified_dt` datetime DEFAULT NULL,
  PRIMARY KEY (`hcdi_data_request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='This table are generic for all CDI use case, the data is sent to CDI';

-- Data exporting was unselected.

-- Dumping structure for table hkcdi_db.tb_ibg_rm_team
CREATE TABLE IF NOT EXISTS `tb_ibg_rm_team` (
  `ibg_rm_team` varchar(32) NOT NULL,
  `ibg_rm_team_display_name` varchar(256) DEFAULT NULL,
  `pc_code` varchar(10) DEFAULT NULL,
  `created_dt` datetime DEFAULT NULL,
  PRIMARY KEY (`ibg_rm_team`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='IBG RM Team Table';

-- Data exporting was unselected.

-- Dumping structure for table hkcdi_db.tb_iso_ctry_code
CREATE TABLE IF NOT EXISTS `tb_iso_ctry_code` (
  `country_alpha_3_code` varchar(8) NOT NULL COMMENT '"Example:\nIDN"',
  `country_display_name` varchar(50) DEFAULT NULL COMMENT '"Example:\nIndonesia"',
  `created_dt` datetime DEFAULT NULL,
  PRIMARY KEY (`country_alpha_3_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='ISO Country Code Table';

-- Data exporting was unselected.
