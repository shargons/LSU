USE [edcdatadev];
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
		,birthdate 
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
		,classic_last_activity_date__c as classic_last_activity_date__pc
		,comments__c as comments__pc
		,company__c as company__pc
		,convertedleadid__c as convertedleadid__pc
		,covid_19_deferment_reason__c as covid_19_deferment_reason__pc
		--,CR.ID AS createdbyid
		,C.createddate
		,current_program_for_reference__c as current_program_for_reference__pc
		,deferred_due_to_covid_19__c as deferred_due_to_covid_19__pc
		,C.description
		,donotcall
		,donotuse__c as donotuse__pc
		,email+'.invalid' as email
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
		,gender__c  as gender__pc
		,graduated__c as graduated__pc
		,A.ID AS graduation_term__pc 
		,grouppayor__c as grouppayor__pc
		,guild_student__c as guild_student__pc
		,guildcleanup__c as guildcleanup__pc
		,hasoptedoutofemail
		,hasoptedoutoffax
		,hed__alternateemail__c                  AS alternateemail__pc
		,hed__deceased__c                        AS deceased__pc
		,hed__do_not_contact__c                  AS do_not_contact__pc
		,hed__financial_aid_applicant__c         AS financial_aid_applicant__pc
		,hed__gender__c                          AS GenderIdentity
		,hed__universityemail__c                 AS universityemail__pc
		,hed__workemail__c                       AS workemail__pc
		,hed__workphone__c                       AS workphone__pc
		,highest_level_of_education__c as highest_level_of_education__pc
		,homephone
		,hot_lead__c
		,C.id                                       AS Legacy_Id__pc
		,inquiry_date_time__c as inquiry_date_time__pc
		,interaction_rollup_beforeappsubmission__c as interaction_rollup_beforeappsubmission__pc
		,lastname
		,lead_applicant_pipeline_status__c as lead_applicant_pipeline_status__pc
		,lead_creation_date_time__c as lead_creation_date_time__pc
		,lead_email__c as lead_email__pc
		,leadsource
		,learner_concierge__c as Source_learner_concierge__pc
		,lsu_affiliation_pipeline_status__c as lsu_affiliation_pipeline_status__pc
		,lsu_affiliation_pipeline_sub_status__c as lsu_affiliation_pipeline_sub_status__pc
		,lsu_campaign_id__c as Source_lsu_campaign_id__pc
		,lsu_online_mainframe_match_id__c as lsu_online_mainframe_match_id__pc
		,lsua_application_id__c as lsua_application_id__pc
		,lsuamstudentprogramcode__c as lsuamstudentprogramcode__pc
		,lsuf_id__c as lsuf_id__pc
		,lsusapinitialleaddate__c as lsusapinitialleaddate__pc
		,mailingcity
		,mailingcountry
		,mailingpostalcode
		,mailingstate
		,mailingstreet
		,manual_guild_id_field__c as manual_guild_id_field__pc
		,manual_trigger__c as manual_trigger__pc
		,manualcalls__c as manualcalls__pc
		,manually_created__c as manually_created__pc
		,matchesaplead__c as matchesaplead__pc
		,middlename
		,mobilephone
		,most_recent_ce_guild_cohort__c as most_recent_ce_guild_cohort__pc
		,number_of_primary_address_records__c as number_of_primary_address_records__pc
		,one_login_id__c as one_login_id__pc
		,one_school_id__c as one_school_id__pc
		,one_student_x_number__c as one_student_x_number__pc
		,one_version__c as one_version__pc
		,original_created_date__c as original_created_date__pc
		,original_last_activity_date__c as original_last_activity_date__pc
		,other_email_address__c as other_email_address__pc
		,othercity
		,othercountry
		,otherphone
		,otherpostalcode
		,otherstate
		,otherstreet
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
		,B.ID AS term_of_interest__pc
		,title
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
LEFT JOIN [edcuat].[dbo].[AcademicTerm_Lookup] A
ON A.Name = C.graduation_term__c
LEFT JOIN [edcuat].[dbo].[AcademicTerm_Lookup] B
ON B.Name = C.Term_of_Interest__c
LEFT JOIN [edcuat].[dbo].Account_Program_Lookup P
ON C.Primary_Academic_Program__c = P.Legacy_ID__c