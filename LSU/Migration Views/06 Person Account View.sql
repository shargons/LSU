USE [edcuat];
GO

/****** Object:  View [dbo].[02_EDA_OrgAccount]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[06_EDA_PersonAccount] AS

SELECT  NULL AS ID
		,age_25__c AS age_25__pc
		,aggregate_match_id_1__c as aggregate_match_id_1__pc
		,aggregate_match_id_2__c as aggregate_match_id_2__pc
		,answering_machine_call_count__c as answering_machine_call_count__pc
		,asap_call__c as asap_call__pc
		,auto_dailer_call_count__c as auto_dailer_call_count__pc
		,bad_email__c as bad_email__pc
		,bad_phone__c as bad_phone__pc
		,birthdate    as PersonBirthdate
		,call_activity_count__c as call_activity_count__pc
		,call_count__c as call_count__pc
		,campus__c as campus__pc
		,ce_city__c as ce_city__pc
		,ce_city_code__c as ce_city_code__pc
		,ce_country_code__c as ce_country_code__pc
		,ce_country_name__c as ce_country_name__pc
		,ce_created_datetime__c as ce_created_datetime__pc
		,ce_enrollment_coach__c as Source_ce_enrollment_coach__pc
		,ce_enrollment_coordinator__c as Source_ce_enrollment_coordinator__pc
		,ce_guild_cohorts_historical__c as ce_guild_cohorts_historical__pc
		,ce_guild_student__c as ce_guild_student__pc
		,ce_guildreportingfieldhaschangedtoday__c as ce_guildreportingfieldhaschangedtoday__pc
		,ce_lead_applicant_pipeline_status__c as ce_lead_applicant_pipeline_status__pc
		,ce_lead_applicant_pipeline_sub_statuses__c as ce_lead_applicant_pipeline_sub_statuses__pc
		,ce_lead_applicatnt_pipeline_status__c as ce_lead_applicatnt_pipeline_status__pc
		,ce_legacy_accountid__c as ce_legacy_accountid__pc
		,ce_most_recent_completed_course__c as ce_most_recent_completed_course__pc
		,ce_student_success_coach__c as Source_ce_student_success_coach__pc
		,celsuid__c as celsuid__pc
		,celsuidchanged__c as celsuidchanged__pc
		,classic_created_date__c as classic_created_date__pc
		--,classic_last_activity_date__c as classic_last_activity_date__pc  -- changed as per lcec-525
		,comments__c as comments__pc
		,company__c as company__pc
		,convertedleadid__c as convertedleadid__pc
		,covid_19_deferment_reason__c as covid_19_deferment_reason__pc
		--,CR.ID AS createdbyid
		,C.createddate
		,current_program_for_reference__c as current_program_for_reference__pc
		,deferred_due_to_covid_19__c as deferred_due_to_covid_19__pc
		,C.description
		,donotcall AS PersonDoNotCall
		,donotuse__c as donotuse__pc
		,LEFT(email, 247) +'.invalid' as Personemail
		,emailsaftermerge__c as emailsaftermerge__pc
		,employee_position__c as employee_position__pc
		,employer__c as employer__pc
		,enrollment_concierge__c as Source_enrollment_concierge__pc
		,enrollment_coordinator__c as Source_enrollment_coordinator__pc
		,et4ae5__hasoptedoutofmobile__c as et4ae5__hasoptedoutofmobile__pc
		,et4ae5__mobile_country_code__c as et4ae5__mobile_country_code__pc
		,ext_classic_contact_id__c as ext_classic_contact_id__pc
		,ext_classic_lead_id__c as ext_classic_lead_id__pc
		,extcontactaftrermerge__c as extcontactaftrermerge__pc
		,extid_missingclassicid__c as extid_missingclassicid__pc
		,extleadaftermerge__c as extleadaftermerge__pc
		,firstceenrollmentdate__c as firstceenrollmentdate__pc
		,firstceenrollmentdatetime__c as firstceenrollmentdatetime__pc
		,firstname
		,five9_home_phone__c as five9_home_phone__pc
		,five9_mobile_number__c as five9_mobile_number__pc
		,five9_phone_number__c as five9_phone_number__pc
		,funding_source__c as funding_source__pc
		,funding_source_other__c as funding_source_other__pc
		--,gender__c  as gender__pc
		,graduated__c as graduated__pc
		,graduation_term__c AS Source_graduation_term__pc
		,grouppayor__c as grouppayor__pc
		,guild_student__c as guild_student__pc
		,guildcleanup__c as guildcleanup__pc
		,hasoptedoutofemail AS Personhasoptedoutofemail
		,hasoptedoutoffax AS Personhasoptedoutoffax
		,hed__alternateemail__c                  AS alternateemail__pc
		,hed__deceased__c                        AS deceased__pc
		,hed__do_not_contact__c                  AS do_not_contact__pc
		,hed__financial_aid_applicant__c         AS financial_aid_applicant__pc
		,hed__gender__c                          AS PersonGenderIdentity
		,hed__universityemail__c                 AS universityemail__pc
		,hed__workemail__c                       AS workemail__pc
		,hed__workphone__c                       AS workphone__pc
		,highest_level_of_education__c as highest_level_of_education__pc
		,homephone AS Personhomephone
		,hot_lead__c
		,C.id                                       AS Legacy_Id__pc
		,inquiry_date_time__c as inquiry_date_time__pc
		,interaction_rollup_beforeappsubmission__c as interaction_rollup_beforeappsubmission__pc
		,lastname
		,lead_applicant_pipeline_status__c as lead_applicant_pipeline_status__pc
		,lead_creation_date_time__c as lead_creation_date_time__pc
		,lead_email__c as lead_email__pc
		,leadsource AS Personleadsource
		,learner_concierge__c as Source_learner_concierge__pc
		,lsu_affiliation_pipeline_status__c as lsu_affiliation_pipeline_status__pc
		,lsu_affiliation_pipeline_sub_status__c as lsu_affiliation_pipeline_sub_status__pc
		,lsu_campaign_id__c as Source_lsu_campaign_id__pc
		,lsu_online_mainframe_match_id__c as lsu_online_mainframe_match_id__pc
		,lsua_application_id__c as lsua_application_id__pc
		,lsuamstudentprogramcode__c as lsuamstudentprogramcode__pc
		,lsuf_id__c as lsuf_id__pc
		,lsusapinitialleaddate__c as lsusapinitialleaddate__pc
		,mailingcity AS Personmailingcity
		,CASE
			WHEN mailingcity = 'United States'
			THEN 'United States'
			WHEN mailingcountry = 'US'
			THEN 'United States'
			WHEN mailingcountry = 'USA'
			THEN 'United States'			
			WHEN (mailingcountry IS NULL OR mailingcountry = '*') AND mailingstate IS NOT NULL
			THEN 'United States'		
			WHEN mailingcountry = 'CA'
			THEN 'Canada'
			WHEN mailingcountry = 'FR'
			THEN 'France'
			WHEN mailingcountry = 'GH'
			THEN 'Ghana'
			WHEN mailingcountry = 'QA'
			THEN 'Qatar'
			WHEN mailingcountry = 'AV'
			THEN 'Anguilla'
			WHEN mailingcountry = 'AS'
			THEN NULL
			WHEN mailingcountry = 'GM'
			THEN 'Gambia'
			WHEN mailingcountry = 'TD'
			THEN 'Trinidad and Tobago'
			WHEN mailingcountry = 'IN'
			THEN 'India'
			WHEN mailingcountry = 'SA'
			THEN 'Saudi Arabia'
			WHEN mailingcountry = 'KW'
			THEN 'Kuwait'
			WHEN mailingcountry = 'KS'
			THEN 'Korea, Republic of'
			WHEN mailingcountry = 'DO'
			THEN 'Dominican Republic'
			WHEN mailingcountry = 'TH'
			THEN 'Thailand'
			WHEN mailingcountry = 'United States of America'
			THEN 'United States'
			WHEN mailingcountry = '*'
			THEN NULL
			WHEN mailingcountry = 'BM'
			THEN 'Bermuda'
			WHEN mailingcountry = 'UG'
			THEN 'Uganda'
			WHEN mailingcountry = 'JA'
			THEN 'Japan'
			WHEN mailingcountry = 'UK'
			THEN 'United Kingdom'
			WHEN mailingcountry = 'BF'
			THEN 'Burkina Faso'
			WHEN mailingcountry = 'SL'
			THEN 'Sierra Leone'
			WHEN mailingcountry = 'IND'
			THEN 'India'
			WHEN mailingcountry = 'PK'
			THEN 'Pakistan'
			WHEN mailingcountry = 'NGA'
			THEN 'Nigeria'
			WHEN mailingcountry = 'CS'
			THEN 'Costa Rica'
			WHEN mailingcountry = 'RP'
			THEN 'Philippines'
			WHEN mailingcountry = 'CF'
			THEN 'Central African Republic'
			WHEN mailingcountry = 'JOR'
			THEN 'Jordan'
			WHEN mailingcountry = 'EG'
			THEN 'Egypt'
			WHEN mailingcountry = 'CAN'
			THEN 'Canada'
			WHEN mailingcountry = 'CHN'
			THEN 'China'
			WHEN mailingcountry = 'NI'
			THEN 'Nicaragua'
			WHEN mailingcountry = 'LA'
			THEN 'Lao People''s Democratic Republic'
			WHEN mailingcountry = 'LCA'
			THEN 'Saint Lucia'
			WHEN mailingcountry = 'PP'
			THEN 'Papua New Guinea'
			WHEN mailingcountry = 'VGB'
			THEN 'Virgin Islands, British'
			WHEN mailingcountry = 'GHA'
			THEN 'Ghana'
			WHEN mailingcountry = 'CE'
			THEN 'Sri Lanka'
			WHEN mailingcountry = 'ET'
			THEN 'Ethopia'
			WHEN mailingcountry = 'AU'
			THEN 'Austria'
			WHEN mailingcountry = 'LKA'
			THEN 'Sri Lanka'
			WHEN mailingcountry = 'LBN'
			THEN 'Lebanon'
			WHEN mailingcountry = 'YM'
			THEN 'Yemen'
			WHEN mailingcountry = 'ZMB'
			THEN 'Zimbabwe'
			WHEN mailingcountry = 'CI'
			THEN 'Cote d''Ivoire'
			WHEN mailingcountry = 'MOZ'
			THEN 'Mozambique'
			WHEN mailingcountry = 'KE'
			THEN 'Kenya'
			WHEN mailingcountry = 'JM'
			THEN 'Jamaica'
			WHEN mailingcountry = 'CO'
			THEN 'Colombia'
			WHEN mailingcountry = 'CN'
			THEN 'China'
			WHEN mailingcountry = 'JO'
			THEN 'Jordan'
			WHEN mailingcountry = 'MX'
			THEN 'Mexico'
			WHEN mailingcountry = 'NG'
			THEN 'Nigeria'
			WHEN mailingcountry = 'EC'
			THEN 'Ecuador'
			WHEN mailingcountry = 'NU'
			THEN 'Niue'
			WHEN mailingcountry = 'SU'
			THEN 'Sudan'
			WHEN mailingcountry = 'ES'
			THEN 'Spain'
			WHEN mailingcountry = 'CM'
			THEN 'Cameroon'
			WHEN mailingcountry = 'NA'
			THEN 'Namibia'
			WHEN mailingcountry = 'SN'
			THEN 'Senegal'
			WHEN mailingcountry = 'UV'
			THEN 'Burkina Faso'
			WHEN mailingcountry = 'KN'
			THEN 'Saint Kitts and Nevis'
			WHEN mailingcountry = 'IO'
			THEN 'British Indian Ocean Territory'
			WHEN mailingcountry = 'SG'
			THEN 'Singapore'
			WHEN mailingcountry = 'TS'
			THEN 'Tunisia'
			WHEN mailingcountry = 'ECU'
			THEN 'Ecuador'
			WHEN mailingcountry = 'CB'
			THEN 'Japan'
			WHEN mailingcountry = 'LE'
			THEN 'Lebanon'
			WHEN mailingcountry = 'OD'
			THEN 'South Sudan'
			WHEN mailingcountry = 'CH'
			THEN 'China'
			WHEN mailingcountry = 'PAK'
			THEN 'Pakistan'
			WHEN mailingcountry = 'GBR'
			THEN 'United Kingdom'
			WHEN mailingcountry = 'HO'
			THEN 'Honduras'
			WHEN mailingcountry = 'LBR'
			THEN 'Liberia'
			WHEN mailingcountry = 'ETH'
			THEN 'Ethiopia'
			WHEN mailingcountry = 'SF'
			THEN 'South Africa'
			WHEN mailingcountry = 'TC'
			THEN 'Turks and Caicos Islands'
			WHEN mailingcountry = 'BHS'
			THEN 'Bahamas'
			WHEN mailingcountry = 'ARE'
			THEN 'United Arab Emirates'
			WHEN mailingcountry = 'TC'
			THEN 'Turks and Caicos Islands'
			WHEN mailingcountry = 'BG'
			THEN 'Bulgaria'
			ELSE mailingcountry	
		END AS Personmailingcountry
		,mailingpostalcode AS Personmailingpostalcode
		,CASE
		WHEN mailingstate = 'VA'
		THEN 'Virginia'
		WHEN mailingstate = 'RI'
		THEN 'Rhode Island'
		WHEN mailingstate = 'NC'
		THEN 'North Carolina'
		WHEN mailingstate = 'MD'
		THEN 'Maryland'
		WHEN mailingstate = 'CA'
		THEN 'California'
		WHEN mailingstate = 'PA'
		THEN 'Pennsylvania'
		WHEN mailingstate = 'MO'
		THEN 'Missouri'
		WHEN mailingstate = 'NJ'
		THEN 'New Jersey'
		WHEN mailingstate = 'IL'
		THEN 'Illinois'
		WHEN mailingstate = 'DE'
		THEN 'Delaware'
		WHEN mailingstate = 'DC'
		THEN 'District of Columbia'
		WHEN mailingstate = 'MN'
		THEN 'Minnesota'
		WHEN mailingstate = 'AE'
		THEN 'Armed Forces Europe'
		WHEN mailingstate = 'VI'
		THEN 'Virgin Islands'
		WHEN mailingstate = 'NY'
		THEN 'New York'
		WHEN mailingstate = 'GA'
		THEN 'Georgia'
		WHEN mailingstate = 'MI'
		THEN 'Michigan'
		WHEN mailingstate = 'SC'
		THEN 'South Carolina'
		WHEN mailingstate = 'CO'
		THEN 'Colorado'
		WHEN mailingstate = 'TN'
		THEN 'Tennessee'
		WHEN mailingstate = 'VT'
		THEN 'Vermont'
		WHEN mailingstate = 'LA'
		THEN 'Louisiana'
		WHEN mailingstate = 'TX'
		THEN 'Texas'
		WHEN mailingstate = 'AL'
		THEN 'Alabama'
		WHEN mailingstate = 'IN'
		THEN 'Indiana'
		WHEN mailingstate = 'ND'
		THEN 'North Dakota'
		WHEN mailingstate = 'WA'
		THEN 'Washington'
		WHEN mailingstate = 'FL'
		THEN 'Florida'
		WHEN mailingstate = 'AR'
		THEN 'Arkansas'
		WHEN mailingstate = 'KY'
		THEN 'Kentucky'
		WHEN mailingstate = 'MA'
		THEN 'Massachusetts'
		WHEN mailingstate = 'OH'
		THEN 'Ohio'
		WHEN mailingstate = 'MS'
		THEN 'Mississippi'
		WHEN mailingstate = 'OR'
		THEN 'Oregon'
		WHEN mailingstate = 'NV'
		THEN 'Nevada'
		WHEN mailingstate = 'NM'
		THEN 'New Mexico'
		WHEN mailingstate = 'KS'
		THEN 'Kansas'
		WHEN mailingstate = 'PR'
		THEN 'Puerto Rico'
		WHEN mailingstate = 'WV'
		THEN 'West Virginia'
		WHEN mailingstate = 'OK'
		THEN 'Oklahoma'
		WHEN mailingstate = 'HI'
		THEN 'Hawaii'
		WHEN mailingstate = 'CT'
		THEN 'Connecticut'
		WHEN mailingstate = 'UT'
		THEN 'Utah'
		WHEN mailingstate = 'AZ'
		THEN 'Arizona'
		WHEN mailingstate = 'ON'
		THEN 'Ontario'
		WHEN mailingstate = 'WI'
		THEN 'Wisconsin'
		WHEN mailingstate = 'SD'
		THEN 'South Dakota'
		WHEN mailingstate = 'MT'
		THEN 'Montana'
		WHEN mailingstate = 'NE'
		THEN 'Nebraska'
		WHEN mailingstate = 'WY'
		THEN 'Wyoming'
		WHEN mailingstate = 'ID'
		THEN 'Idaho'
		WHEN mailingstate = 'IA'
		THEN 'Iowa'
		WHEN mailingstate = 'ZZ'
		THEN NULL
		WHEN mailingcity = 'KAMLOOPS'
		THEN 'BC'
		WHEN mailingstate = 'AK'
		THEN 'Alaska'
		WHEN mailingstate = 'ME'
		THEN 'Maine'
		WHEN mailingstate = 'AP'
		THEN 'Armed Forces Pacific'
		WHEN mailingstate = 'NH'
		THEN 'New Hampshire'
		WHEN mailingstate = '*'
		THEN NULL
		WHEN mailingstate = 'NULL'
		THEN NULL
		WHEN mailingstate = 'AA'
		THEN 'Armed Forces Americas'
		WHEN mailingstate = 'QC'
		THEN 'Quebec'
		WHEN mailingstate = 'AB'
		THEN 'Alberta'
		WHEN mailingstate = 'Unknown'
		THEN NULL
		WHEN mailingstate = 'GU'
		THEN 'Guam'
		WHEN mailingstate = 'XX'
		THEN NULL
		WHEN mailingstate = 'NS'
		THEN 'Nova Scotia'
		WHEN mailingstate = 'MB'
		THEN 'Manitoba'
		WHEN mailingstate = 'UNKN'
		THEN NULL
		WHEN mailingstate = 'BC'
		THEN 'British Columbia'
		WHEN mailingstate = 'NL'
		THEN 'Newfoundland and Labrador'
		WHEN mailingstate = 'AS'
		THEN 'American Samoa'
		ELSE mailingstate
		END AS Personmailingstate
		,mailingstreet AS Personmailingstreet
		,manual_guild_id_field__c as manual_guild_id_field__pc
		,manual_trigger__c as manual_trigger__pc
		,manualcalls__c as manualcalls__pc
		,manually_created__c as manually_created__pc
		,matchesaplead__c as matchesaplead__pc
		,middlename
		,mobilephone AS Personmobilephone
		,most_recent_ce_guild_cohort__c as most_recent_ce_guild_cohort__pc
		,number_of_primary_address_records__c as number_of_primary_address_records__pc
		,one_login_id__c as one_login_id__pc
		,one_school_id__c as one_school_id__pc
		,one_student_x_number__c as one_student_x_number__pc
		,one_version__c as one_version__pc
		,original_created_date__c as original_created_date__pc
		,original_last_activity_date__c as classic_last_activity_date__pc
		,other_email_address__c as other_email_address__pc
		,othercity AS Personothercity
		,CASE
			WHEN othercity = 'United States'
			THEN 'United States'
			WHEN othercountry = 'US'
			THEN 'United States'
			WHEN othercountry = 'USA'
			THEN 'United States'			
			WHEN (othercountry IS NULL OR othercountry = '*') AND otherstate IS NOT NULL
			THEN 'United States'			
			WHEN othercountry = 'CA'
			THEN 'Canada'
			WHEN othercountry = 'FR'
			THEN 'France'
			WHEN othercountry = 'GH'
			THEN 'Ghana'
			WHEN othercountry = 'QA'
			THEN 'Qatar'
			WHEN othercountry = 'AV'
			THEN 'Anguilla'
			WHEN othercountry = 'AS'
			THEN NULL
			WHEN othercountry = 'GM'
			THEN 'Gambia'
			WHEN othercountry = 'TD'
			THEN 'Trinidad and Tobago'
			WHEN othercountry = 'IN'
			THEN 'India'
			WHEN othercountry = 'SA'
			THEN 'Saudi Arabia'
			WHEN othercountry = 'KW'
			THEN 'Kuwait'
			WHEN othercountry = 'KS'
			THEN 'Korea, Republic of'
			WHEN othercountry = 'DO'
			THEN 'Dominican Republic'
			WHEN othercountry = 'TH'
			THEN 'Thailand'
			WHEN othercountry = 'United States of America'
			THEN 'United States'
			WHEN othercountry = '*'
			THEN NULL
			WHEN othercountry = 'BM'
			THEN 'Bermuda'
			WHEN othercountry = 'UG'
			THEN 'Uganda'
			WHEN othercountry = 'JA'
			THEN 'Japan'
			WHEN othercountry = 'UK'
			THEN 'United Kingdom'
			WHEN othercountry = 'BF'
			THEN 'Burkina Faso'
			WHEN othercountry = 'SL'
			THEN 'Sierra Leone'
			WHEN othercountry = 'IND'
			THEN 'India'
			WHEN othercountry = 'PK'
			THEN 'Pakistan'
			WHEN othercountry = 'NGA'
			THEN 'Nigeria'
			WHEN othercountry = 'CS'
			THEN 'Costa Rica'
			WHEN othercountry = 'RP'
			THEN 'Philippines'
			WHEN othercountry = 'CF'
			THEN 'Central African Republic'
			WHEN othercountry = 'JOR'
			THEN 'Jordan'
			WHEN othercountry = 'EG'
			THEN 'Egypt'
			WHEN othercountry = 'CAN'
			THEN 'Canada'
			WHEN othercountry = 'CHN'
			THEN 'China'
			WHEN othercountry = 'NI'
			THEN 'Nicaragua'
			WHEN othercountry = 'LA'
			THEN 'Lao People''s Democratic Republic'
			WHEN othercountry = 'LCA'
			THEN 'Saint Lucia'
			WHEN othercountry = 'PP'
			THEN 'Papua New Guinea'
			WHEN othercountry = 'VGB'
			THEN 'Virgin Islands, British'
			WHEN othercountry = 'GHA'
			THEN 'Ghana'
			WHEN othercountry = 'CE'
			THEN 'Sri Lanka'
			WHEN othercountry = 'ET'
			THEN 'Ethopia'
			WHEN othercountry = 'AU'
			THEN 'Austria'
			WHEN othercountry = 'LKA'
			THEN 'Sri Lanka'
			WHEN othercountry = 'LBN'
			THEN 'Lebanon'
			WHEN othercountry = 'YM'
			THEN 'Yemen'
			WHEN othercountry = 'ZMB'
			THEN 'Zimbabwe'
			WHEN othercountry = 'CI'
			THEN 'Cote d''Ivoire'
			WHEN othercountry = 'MOZ'
			THEN 'Mozambique'
			WHEN othercountry = 'KE'
			THEN 'Kenya'
			WHEN othercountry = 'JM'
			THEN 'Jamaica'
			WHEN othercountry = 'CO'
			THEN 'Colombia'
			WHEN othercountry = 'CN'
			THEN 'China'
			WHEN othercountry = 'JO'
			THEN 'Jordan'
			WHEN othercountry = 'MX'
			THEN 'Mexico'
			WHEN othercountry = 'NG'
			THEN 'Nigeria'
			WHEN othercountry = 'EC'
			THEN 'Ecuador'
			WHEN othercountry = 'NU'
			THEN 'Niue'
			WHEN othercountry = 'SU'
			THEN 'Sudan'
			WHEN othercountry = 'ES'
			THEN 'Spain'
			WHEN othercountry = 'CM'
			THEN 'Cameroon'
			WHEN othercountry = 'NA'
			THEN 'Namibia'
			WHEN othercountry = 'SN'
			THEN 'Senegal'
			WHEN othercountry = 'UV'
			THEN 'Burkina Faso'
			WHEN othercountry = 'KN'
			THEN 'Saint Kitts and Nevis'
			WHEN othercountry = 'IO'
			THEN 'British Indian Ocean Territory'
			WHEN othercountry = 'SG'
			THEN 'Singapore'
			WHEN othercountry = 'TS'
			THEN 'Tunisia'
			WHEN othercountry = 'ECU'
			THEN 'Ecuador'
			WHEN othercountry = 'CB'
			THEN 'Japan'
			WHEN othercountry = 'LE'
			THEN 'Lebanon'
			WHEN othercountry = 'OD'
			THEN 'South Sudan'
			WHEN othercountry = 'CH'
			THEN 'China'
			WHEN othercountry = 'PAK'
			THEN 'Pakistan'
			WHEN othercountry = 'GBR'
			THEN 'United Kingdom'
			WHEN othercountry = 'HO'
			THEN 'Honduras'
			WHEN othercountry = 'LBR'
			THEN 'Liberia'
			WHEN othercountry = 'ETH'
			THEN 'Ethiopia'
			WHEN othercountry = 'SF'
			THEN 'South Africa'
			WHEN othercountry = 'TC'
			THEN 'Turks and Caicos Islands'
			WHEN othercountry = 'BHS'
			THEN 'Bahamas'
			WHEN othercountry = 'ARE'
			THEN 'United Arab Emirates'
			WHEN othercountry = 'TC'
			THEN 'Turks and Caicos Islands'
			WHEN othercountry = 'BG'
			THEN 'Bulgaria'
			ELSE othercountry	
		END AS Personothercountry
		,otherphone AS Personotherphone
		,otherpostalcode AS Personotherpostalcode
		,CASE
		WHEN otherstate = 'VA'
		THEN 'Virginia'
		WHEN otherstate = 'RI'
		THEN 'Rhode Island'
		WHEN otherstate = 'NC'
		THEN 'North Carolina'
		WHEN otherstate = 'MD'
		THEN 'Maryland'
		WHEN otherstate = 'CA'
		THEN 'California'
		WHEN otherstate = 'PA'
		THEN 'Pennsylvania'
		WHEN otherstate = 'MO'
		THEN 'Missouri'
		WHEN otherstate = 'NJ'
		THEN 'New Jersey'
		WHEN otherstate = 'IL'
		THEN 'Illinois'
		WHEN otherstate = 'DE'
		THEN 'Delaware'
		WHEN otherstate = 'DC'
		THEN 'District of Columbia'
		WHEN otherstate = 'MN'
		THEN 'Minnesota'
		WHEN otherstate = 'AE'
		THEN 'Armed Forces Europe'
		WHEN otherstate = 'VI'
		THEN 'Virgin Islands'
		WHEN otherstate = 'NY'
		THEN 'New York'
		WHEN otherstate = 'GA'
		THEN 'Georgia'
		WHEN otherstate = 'MI'
		THEN 'Michigan'
		WHEN otherstate = 'SC'
		THEN 'South Carolina'
		WHEN otherstate = 'CO'
		THEN 'Colorado'
		WHEN otherstate = 'TN'
		THEN 'Tennessee'
		WHEN otherstate = 'VT'
		THEN 'Vermont'
		WHEN otherstate = 'LA'
		THEN 'Louisiana'
		WHEN otherstate = 'TX'
		THEN 'Texas'
		WHEN otherstate = 'AL'
		THEN 'Alabama'
		WHEN otherstate = 'IN'
		THEN 'Indiana'
		WHEN otherstate = 'ND'
		THEN 'North Dakota'
		WHEN otherstate = 'WA'
		THEN 'Washington'
		WHEN otherstate = 'FL'
		THEN 'Florida'
		WHEN otherstate = 'AR'
		THEN 'Arkansas'
		WHEN otherstate = 'KY'
		THEN 'Kentucky'
		WHEN otherstate = 'MA'
		THEN 'Massachusetts'
		WHEN otherstate = 'OH'
		THEN 'Ohio'
		WHEN otherstate = 'MS'
		THEN 'Mississippi'
		WHEN otherstate = 'OR'
		THEN 'Oregon'
		WHEN otherstate = 'NV'
		THEN 'Nevada'
		WHEN otherstate = 'NM'
		THEN 'New Mexico'
		WHEN otherstate = 'KS'
		THEN 'Kansas'
		WHEN otherstate = 'PR'
		THEN 'Puerto Rico'
		WHEN otherstate = 'WV'
		THEN 'West Virginia'
		WHEN otherstate = 'OK'
		THEN 'Oklahoma'
		WHEN otherstate = 'HI'
		THEN 'Hawaii'
		WHEN otherstate = 'CT'
		THEN 'Connecticut'
		WHEN otherstate = 'UT'
		THEN 'Utah'
		WHEN otherstate = 'AZ'
		THEN 'Arizona'
		WHEN otherstate = 'ON'
		THEN 'Ontario'
		WHEN otherstate = 'WI'
		THEN 'Wisconsin'
		WHEN otherstate = 'SD'
		THEN 'South Dakota'
		WHEN otherstate = 'MT'
		THEN 'Montana'
		WHEN otherstate = 'NE'
		THEN 'Nebraska'
		WHEN otherstate = 'WY'
		THEN 'Wyoming'
		WHEN otherstate = 'ID'
		THEN 'Idaho'
		WHEN otherstate = 'IA'
		THEN 'Iowa'
		WHEN otherstate = 'ZZ'
		THEN NULL
		WHEN othercity = 'KAMLOOPS'
		THEN 'BC'
		WHEN otherstate = 'AK'
		THEN 'Alaska'
		WHEN otherstate = 'ME'
		THEN 'Maine'
		WHEN otherstate = 'AP'
		THEN 'Armed Forces Pacific'
		WHEN otherstate = 'NH'
		THEN 'New Hampshire'
		WHEN otherstate = '*'
		THEN NULL
		WHEN otherstate = 'NULL'
		THEN NULL
		WHEN otherstate = 'AA'
		THEN 'Armed Forces Americas'
		WHEN otherstate = 'QC'
		THEN 'Quebec'
		WHEN otherstate = 'AB'
		THEN 'Alberta'
		WHEN otherstate = 'Unknown'
		THEN NULL
		WHEN otherstate = 'GU'
		THEN 'Guam'
		WHEN otherstate = 'XX'
		THEN NULL
		WHEN otherstate = 'NS'
		THEN 'Nova Scotia'
		WHEN otherstate = 'MB'
		THEN 'Manitoba'
		WHEN otherstate = 'UNKN'
		THEN NULL
		WHEN otherstate = 'BC'
		THEN 'British Columbia'
		WHEN otherstate = 'NL'
		THEN 'Newfoundland and Labrador'
		WHEN otherstate = 'AS'
		THEN 'American Samoa'
		ELSE otherstate
		END AS Personotherstate
		,otherstreet AS Personotherstreet
		--,O.ID AS ownerid
		,partnershipname__c as partnershipname__pc
		,personid_int__c as personid_int__pc
		,phone
		,phone_numbers_count__c as phone_numbers_count__pc
		,phone_opt_out__c as phone_opt_out__pc
		,phonemergematch__c as phonemergematch__pc
		,pipeline_status__c as pipeline_status__pc
		,pipeline_status_change_date_time__c as pipeline_status_change_date_time__pc
		,preferred_email__c as preferred_email__pc
		,preferred_name__c as preferred_name__pc
		,preferred_phone__c as preferred_phone__pc
		,P.ID as primary_academic_program__pc
		,primary_academic_program_text__c as primary_academic_program_text__pc
		,privacy_statement_agreement__c as privacy_statement_agreement__pc
		,qualified__c as qualified__pc
		,recent_campus__c as recent_campus__pc
		,record_type_text__c as record_type_text__pc
		,rollupcertificateenrollments__c as rollupcertificateenrollments__pc
		,salutation
		,sfid__c as sfid__pc
		,slate_phone_number__c as slate_phone_number__pc
		,sms_text_opt_out__c as sms_text_opt_out__pc
		,ssnonfile__c as ssnonfile__pc
		,state__c as state__pc
		,status__c as status__pc
		,stop_auto_dialer__c as stop_auto_dialer__pc
		,stoppardotautocomms__c as stoppardotautocomms__pc
		,studentssn__c as studentssn__pc
		,suffix
		,Term_of_Interest__c AS Source_term_of_interest__pc
		,LEFT(title, 128) AS Persontitle
		,total_no_of_affiliations__c as total_no_of_affiliations__pc
		,total_open_opportunities__c as total_open_opportunities__pc
		,transcriptreceivedandreviewed__c as transcriptreceivedandreviewed__pc
		,transcriptreceivednotreviewed__c as transcriptreceivednotreviewed__pc
		,trigger__c as trigger__pc
		,triggerd1webservice__c as triggerd1webservice__pc
		,vcitaappointmentid__c as vcitaappointmentid__pc
		,vcitaappointmentstatus__c as vcitaappointmentstatus__pc
		,x89_number_lsu_id__c as x89_number_lsu_id__pc
		,x999number__c as x999number__pc
		,zip_postal_code__c as zip_postal_code__pc
		,R.ID AS RecordTypeId
FROM [edaprod].[dbo].[Contact] C
LEFT JOIN [edcuat].dbo.Recordtype R
ON R.DeveloperName = 'PersonAccount'
--LEFT JOIN [edcuat].[dbo].[User_Lookup] CR
--ON C.CreatedById = CR.Legacy_ID__c
--LEFT JOIN [edcuat].[dbo].[User_Lookup] O
--ON C.OwnerId = O.Legacy_ID__c
--LEFT JOIN [edcuat].[dbo].[AcademicTerm_Lookup] A
--ON A.Name = C.graduation_term__c
--LEFT JOIN [edcuat].[dbo].[AcademicTerm_Lookup] B
--ON B.Name = C.Term_of_Interest__c
LEFT JOIN [edcuat].[dbo].Account_Program_Lookup P
ON C.Primary_Academic_Program__c = P.Legacy_ID__c