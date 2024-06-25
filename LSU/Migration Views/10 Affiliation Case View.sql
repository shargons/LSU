USE [edcdatadev];
GO

/****** Object:  View [dbo].[02_EDA_OrgAccount]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[10_EDA_Affiliations] AS

SELECT 
	NULL						AS ID
	,C.Name+'-'+L.Legacy_ID__c  AS Subject
	,L.ID						AS Program_of_Interest__c
	,active__c
	,admitted_status__c
	,all_missing_checklist_items__c
	,alumni_entry_date__c
	,anticipated_graduation_date__c
	,application_actual_start_date__c
	,application_admitted_date__c
	,application_created_date__c
	,application_entry_term__c
	,application_fee_waiver_type__c
	,application_id__c							AS Source_application_id__c
	,application_slate_id__c
	,application_status_code_c__c
	,A.application_submitted_date__c
	,backup_pipeline_status__c
	,backup_pipeline_sub_status__c
	,ce_ce_status__c							AS CE_Status__c
	,ce_ce_sub_status__c						AS CE_Sub_Status__c
	,ce_partnership_academic_period_id__c
	,ce_partnership_financial_status__c
	,ce_partnership_funding_max__c
	,ce_partnership_funding_remaining__c
	,ce_partnership_program_cost__c
	,cfg_user__c
	,classic_contact_created_date__c
	,classic_lead_created_date_time__c
	,classic_owner_name__c
	,A.comments__c								AS Comments
	,completed_terms_rollup__c
	,contact_retention__c						AS Source_contact_retention__c
	,C2.ID										AS Contact_retention__c
	,continuing_student_entry_date__c
	--,CR.ID AS createdbyid
	,A.createddate
	,A.cumulative_gpa__c
	,current_term_enrollments__c
	,current_term_registered_hours__c
	,deferred__c
	,degree_candidate__c
	,department__c
	,CASE	WHEN CEDivision__c = 'PD' THEN 'Continuing Education'
		WHEN CEDivision__c = 'PDO Online' THEN 'LSU Online'
		WHEN CEDivision__c = 'TPP - inactive' THEN 'Continuing Education'
		WHEN CEDivision__c = 'ODL' THEN 'LSU Online'
		WHEN CEDivision__c = 'INACTIVE - Online Distance learning' THEN 'LSU Online'
		WHEN CEDivision__c = 'Zero Cost' THEN 'Continuing Education'
		WHEN CEDivision__c = 'Opt-in Cain Program' THEN 'Continuing Education'
		WHEN CEDivision__c = 'INACTIVE - Professional Development' THEN 'Continuing Education'
		WHEN CEDivision__c = 'PL' THEN 'Continuing Education'
		WHEN CEDivision__c = 'Content Partnerships' THEN 'Continuing Education'
		WHEN CEDivision__c = 'Third Party Vendors' THEN 'Continuing Education'
		WHEN CEDivision__c = 'Mindedge' THEN 'Continuing Education'
		WHEN CEDivision__c = 'OL' THEN 'LSU Online'
		WHEN CEDivision__c = 'Partnerships' THEN 'Continuing Education'
		ELSE NULL
		END AS Division__c
	,dropped_from_student_file__c
	,email__c+'.invalid'						AS email__c
	,enrollment_count__c
	,A.ext_classic_contact_id__c
	,A.ext_classic_lead_id__c
	,first_enrollment_date__c
	,first_enrollment_term__c
	,firstinteractiondate__c					AS First_Interaction_Date__c
	,A.funding_source__c
	,A.funding_source_other__c
	,future_scheduled_term__c
	,A.graduated__c
	,guild_cohorts_historical__c
	,guild_ev_history__c
	,hed__account__c							AS Source_hed__account__c
	,C.AccountId										AS AccountId
	,hed__contact__c							AS Source_hed__contact__c
	,C.ID										AS ContactId
	,hed__primary__c							AS primary__c
	,hed__status__c								AS Status__c
	,home__c
	,A.id											AS legacy_ID__c
	,inactive_application__c
	,inactive_entry_date__c
	,lastenrolledterm__c						AS last_enrolled_term__c
	,A.lead_applicant_pipeline_status__c			AS online_lead_applicant_pipeline_status__c
	,lsu_id__c
	,A.lsu_lead_source__c
	,lsua_college_attend__c
	,lsua_degree_code__c
	,lsua_grad_degree__c
	,lsua_grad_term__c
	,lsua_grad_year__c
	,lsua_matriculation_year__c
	,lsua_term_1_financial_aid_accepted__c
	,lsua_term_2_financial_aid_accepted__c
	,lsua_term_3_financial_aid_accepted__c
	,lsua_term_4_financial_aid_accepted__c
	,lsua_username__c
	,lsuam_current_term__c						AS Source_lsuam_current_term__c
	,lsuam_upcoming_term__c						AS Source_lsuam_upcoming_term__c
	,A.lsusapinitialleaddate__c					AS lsus_ap_initial_lead_date__c
	,mobile__c
	,A.name										as Description
	,not_interested__c
	,opportunity_rollup__c
	,A.original_created_date__c
	,A.owner_signature__c
	--,O.ID AS ownerid
	,p_o_created__c
	,paidforcurrentterm__c						AS paid_for_current_term__c
	,paidforupcomingterm__c						AS paid_for_upcoming_term__c
	,partner_admissions_status__c
	,partner_employer_code__c
	,partner_expected_start_term__c
	,partner_external_id__c
	,partner_internal_student_id__c
	,partner_last_updated_date_time__c
	,partner_lsu_program_id__c
	,partner_lsu_program_name__c
	,partner_name__c
	,partner_record_created_date_time__c
	,partner_status__c
	,partnership_ev__c
	,partnership_ferpa__c
	,partnership_last_ev_update_date_time__c
	,payment_status__c
	,phone__c
	,A.pipeline_status__c
	,pipeline_status_code__c
	,pipeline_sub_status__c
	,plastatus__c
	,A.preferred_name__c
	,program_not_offered__c
	,radius_application__c
	,recordtypeid							AS Source_recordtypeid
	,CASE WHEN R_EDA.DeveloperName = 'Retention_Team' THEN R1.Id
		  WHEN CO.Campus_Formula__c = 'LSU Online' THEN R2.Id
		  ELSE R3.Id
	 END									AS RecordTypeId
	,registered_for_current_term__c
	,registered_for_up_coming_term__c
	,resigned__c
	,resigned_date__c
	,resigned_terms__c
	,scheduled_for_up_coming_term__c
	,slate_application_status__c		  
	,A.source__c
	,special_designator__c					AS lsus_special_designator__c
	,stop_out_entry_date__c
	,student_admitted_date__c
	,student_file_created_date__c
	,A.student_id__c
	,student_status__c
	,term_1_2_entry_date__c
	,term_admitted__c
	,term_applied__c
	,term_deferral__c
	,term_enrolled__c
	,A.term_of_interest__c
	,term_of_return__c
	,university_email__c+'.invalid'			AS university_email__c 
	,up_coming_term_enrollments__c
	,upsert_key__c
	,welcome_call_attempts__c
	,welcome_call_scheduled_date_time__c
	,welcome_call_status__c
	,welcome_call_time_zone__c
	,welcome_email_sent__c
FROM [edaprod].[dbo].[hed__Affiliation__c]	A
--LEFT JOIN [edcdatadev].[dbo].[User_Lookup] cr
--ON A.CreatedById = cr.Legacy_ID__c
--LEFT JOIN [edcdatadev].[dbo].[User_Lookup] O
--ON A.OwnerId = O.Legacy_ID__c
LEFT JOIN [edcdatadev].[dbo].[Contact] C
ON A.hed__Contact__c = C.Legacy_ID__c
LEFT JOIN [edcdatadev].[dbo].[Contact] C2
ON A.contact_retention__c = C2.Legacy_ID__c
LEFT JOIN [edaprod].[dbo].[Recordtype] R_EDA
ON A.RecordTypeId = R_EDA.Id
LEFT JOIN [edaprod].[dbo].[Contact] CO
ON CO.Id = A.hed__Contact__c
LEFT JOIN [edcdatadev].[dbo].[Recordtype] R1
ON R1.DeveloperName = 'Academic'
LEFT JOIN [edcdatadev].[dbo].[Recordtype] R2
ON R2.DeveloperName = 'RFI_OE'
LEFT JOIN [edcdatadev].[dbo].[Recordtype] R3
ON R3.DeveloperName = 'RFI_CE'
LEFT JOIN [edcdatadev].[dbo].[LearningProgramPlan_Lookup] L
ON L.Legacy_ID__c = A.Academic_Program__c