USE [EDUCPROD];
GO

/****** Object:  View [dbo].[02_EDA_OrgAccount]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[13A_EDA_Application] AS

SELECT DISTINCT
	NULL											AS ID
	,active_geomarket__c
	,active_to_date__c
	,actual_start_date__c
	,admitted_college__c
	,advisement_date__c
	,advisementrequiredflag__c						AS advisement_required_flag__c
	,advisementscheduleddate__c						AS advisement_scheduled_date__c
	,A.aggregate_match_id_1__c
	,A.aggregate_match_id_2__c
	,aggregate_match_id_3__c
	,aggregate_match_id_4__c
	,alias__c
	,alien_registration_number_arn__c
	,all_missing_checklist_items_comma__c
	,all_transcripts_received__c
	,application_fee_paid_date__c
	,application_fee_status__c
	,A.application_fee_waiver_type__c
	,application_holds__c
	,A.application_slate_id__c
	,application_state_code__c						AS application_state_code__c
	,application_status_description__c
	,application_student_type__c
	,Applied_Date__c 								AS AppliedDate
	,calculated_4_0_transcript_gpa__c
	,A.campus__c
	,class_level__c
	,college__c
	,college_disciplinary_supsension__c
	,college_scholastic_suspension_flag__c
	,college_scholastic_suspension_reason__c
	,A.Contact__c										AS Source_Contact__c
	,C.Id											AS ContactId
	,C.Id											AS SubmittedByContactId
	,C.AccountId									AS AccountId
	,common_app_id__c
	,complete_college_transcript_flag__c
	,complete_final_college_transcript_flag__c
	,complete_final_high_school_transcript_fl__c
	,country_code__c
	,A.createddate									
	,decision_released_date__c						AS Decision_Release_Date__c
	,dropped_from_application_file__c
	,education_specialization__c
	,enrolled_flag__c
	,enrollment_holds__c
	,entering_year_class__c
	,expected_start_date__c
	,ext_key__c
	,fafsa_received_flag__c
	,felony_flag__c
	,file_complete_date__c
	,A.first_enrollment_date__c
	,A.gs_application_type__c
	,A.id												AS Legacy_Id__c
	,A.inactive__c
	,inactive_date_time__c
	,inactive_reason__c
	,incomplete_flag__c
	,institution_admitted_date__c
	,A.institution_email__c
	,intended_major_1__c
	,intended_major_2__c
	,intended_start_month__c
	,international_flag__c
	,international_status__c
	,A.lsua_application_id__c
	,A.lsua_degree_code__c
	,lsua_enrollment_status_date__c
	,lsua_matriculation_year__c
	,lsua_total_earned_credits__c
	,lsua_username__c
	,lsushistoricalrecord__c						AS lsus_historical_record__c
	,online_employer_partnership__c
	,online_family_of_employer_partnership__c
	,overall_term_total_carried__c
	,overall_term_total_earned__c
	,overall_term_total_gpa__c
	,overall_term_total_quality_points__c
	,Opportunity__c									AS Source_Opportunity__c
	,O.ID											AS Opportunity__c
	,partnership_code__c
	,permanent_resident__c
	,person_slate_id__c
	,program_admitted_date__c
	,program_enrollment_status_code__c
	,program_enrollment_status_description__c
	,A.program_code__c								AS Source_ProgramTermApplnTimeline
	,questionnaire_richtext__c						AS questionnaire__c
	,questionnairetitle__c							AS questionnairetitle__c
	,readmit_term__c
	,reviewed_by_counselor__c
	,selective_service_excused_reason__c
	,selective_service_response__c
	,slate_reader_bin__c
	,A.special_designator__c
	,srr_term_flag__c
	,A.ssnonfile__c									AS ssn_on_file__c
	,status_reason_code__c
	,status_reason_description__c
	,A.term_admitted__c
	,A.term_enrolled__c
	,visa_type__c
	,'Education' AS Category
	,Pipeline_Sub_Status__c
	,CASE WHEN Pipeline_Sub_Status__c = 'Awaiting on Department' THEN 'In Review'
		  WHEN Pipeline_Sub_Status__c = 'Applied' THEN 'Processing'
		  WHEN Pipeline_Sub_Status__c = 'Missing Documents' THEN 'Missing Documents'
		  WHEN Pipeline_Sub_Status__c = 'Awaiting Payment' THEN 'Processing'
		  WHEN Pipeline_Sub_Status__c = 'Denied' THEN 'Application Decision - Denied'
		  WHEN Pipeline_Sub_Status__c = 'Admitted' THEN 'Application Decision - Admitted'
		  WHEN Pipeline_Sub_Status__c = 'Awaiting Submission' THEN 'Processing'
		  WHEN Pipeline_Sub_Status__c = 'Withdrawn' THEN 'Application Decision - Withdrawn'
		  WHEN Pipeline_Sub_Status__c = 'Declined' THEN 'Application Decision - Declined'
	END AS [Status]
	,OC.ID AS ownerid
	,CR.ID AS CreatedById
	,A.Classic_Created_Date__c						AS EDACREATEDDATE__c
FROM [edaprod].[dbo].[Application__c] A
LEFT JOIN
[EDUCPROD].[dbo].[Contact] C
ON A.Contact__c = C.Legacy_Id__c
LEFT JOIN
[edaprod].[dbo].[Opportunity] O
ON A.Opportunity__c = O.Id
LEFT JOIN [EDUCPROD].[dbo].[User] cr
ON A.CreatedById = cr.EDAUSERID__c
LEFT JOIN [EDUCPROD].[dbo].[User] OC
ON A.OwnerId = OC.EDAUSERID__c

