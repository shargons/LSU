USE [EDUCPROD];
GO

/****** Object:  View [dbo].[02_EDA_OrgAccount]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[14_EDA_Affiliations] AS

SELECT DISTINCT
	NULL						AS ID
	,C.Name+'-'+L.Legacy_ID__c  AS Subject
	,L.ID						AS Program_of_Interest__c
	,academic_action__c
	,academic_action_comments__c
	,academic_action_term__c
	,A.academic_program__c		AS Source_Learning_Program_of_Interest__c
	,L2.Id						AS 	Learning_Program_of_Interest__c
	,A.active__c
	,A.admitted_status__c
	,A.all_missing_checklist_items__c
	,alumni_entry_date__c
	,A.anticipated_graduation_date__c
	,A.application_actual_start_date__c
	,A.application_admitted_date__c
	,A.application_created_date__c
	,A.application_entry_term__c
	,A.application_fee_waiver_type__c
	,A.application_id__c							AS Source_application_id__c
	,IA.Id											AS application_id__c
	,A.application_slate_id__c						AS Application_Slate_ID__c
	,A.application_status__c						AS application_status__c
	,A.application_status_code_c__c					AS application_status_code__c
	,A.application_submitted_date__c
	,backup_pipeline_status__c
	,backup_pipeline_sub_status__c
	,A.ce_activity__c								AS activity__c
	,A.ce_activity_additional_info__c				AS activity_additional_info__c
	,ce_ce_status__c								 AS CE_Status__c
	,ce_ce_sub_status__c							 AS CE_Sub_Status__c
	,ce_high_risk_date__c
	,ce_high_risk_type__c
	,A.ce_initial_guild_registration_completed__c
	,A.ce_motivation__c							AS motivation__c
	,A.ce_motivation_additional_info__c			AS CE_Motivation_Additional_Info__c
	,A.ce_partnership_academic_period_id__c
	,A.ce_partnership_financial_status__c
	,A.ce_partnership_funding_max__c
	,A.ce_partnership_funding_remaining__c
	,A.ce_partnership_program_cost__c
	,A.ce_payment_additional_info__c				AS payment_additional_info__c
	,A.ce_start_date_additional_info__c			AS start_date_additional_info__c
	,cfg_user__c								AS Source_user__c
	--,U.Id										AS user__c
	,classic_contact_created_date__c
	,classic_lead_created_date_time__c
	,classic_owner_name__c
	,A.comments__c								AS Comments
	,A.completed_terms_rollup__c
	,contact_retention__c						AS Source_contact_retention__c
	,C2.ID										AS Contact_retention__c
	,continuing_student_entry_date__c
	,CR.ID AS createdbyid
	,A.createddate
	,A.cumulative_gpa__c
	,A.current_term_enrollments__c
	,A.current_term_registered_hours__c
	,A.deferred__c
	,A.degree_candidate__c
	,A.degree_candidate_entry_date__c
	,A.department__c
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
		ELSE A.Division__c
		END AS Division__c
	,A.dropped_from_student_file__c
	,email__c+'.invalid'						AS email__c
	,A.enrollment_count__c
	,A.ext_classic_contact_id__c
	,A.ext_classic_lead_id__c
	,A.first_enrollment_date__c
	,A.first_enrollment_term__c
	,A.firstinteractiondate__c					AS First_Interaction_Date__c
	,A.funding_source__c
	,A.funding_source_other__c
	,A.future_scheduled_term__c
	,A.graduated__c
	,A.guild_cohorts_historical__c
	,A.guild_ev_history__c
	,A.guild_reporting_field__c
	,A.guild_reporting_field_last_change_date__c
	,hed__account__c							AS Source_hed__account__c
	,C.AccountId										AS AccountId
	,hed__contact__c							AS Source_hed__contact__c
	,C.ID										AS ContactId
	,hed__primary__c							AS primary__c
	,hed__role__c								AS role__c
	,hed__status__c								AS Status__c
	,A.home__c
	,A.id											AS legacy_ID__c
	,A.inactive_application__c
	,inactive_entry_date__c
	,lastenrolledterm__c						AS last_enrolled_term__c
	,A.lead_applicant_pipeline_status__c			AS online_lead_applicant_pipeline_status__c
	,A.lsu_id__c
	,A.lsu_lead_source__c
	,A.lsua_college_attend__c
	,A.lsua_degree_code__c
	,lsua_grad_degree__c
	,lsua_grad_term__c
	,lsua_grad_year__c
	,A.lsua_matriculation_year__c
	,lsua_term_1_financial_aid_accepted__c
	,lsua_term_2_financial_aid_accepted__c
	,lsua_term_3_financial_aid_accepted__c
	,lsua_term_4_financial_aid_accepted__c
	,A.lsua_username__c
	,A.lsuam_current_term__c						AS Source_lsuam_current_term__c
	,A.lsuam_upcoming_term__c						AS Source_lsuam_upcoming_term__c
	,A.lsusapinitialleaddate__c					AS lsus_ap_initial_lead_date__c
	,mobile__c
	,A.name										as Description
	,A.not_interested__c
	,A.not_qualified__c
	,opportunity_rollup__c
	,A.original_created_date__c						AS EDACreatedDate__c
	,A.owner_signature__c
	,Ou.ID AS ownerid
	,A.p_o_created__c
	,A.paidforcurrentterm__c						AS paid_for_current_term__c
	,A.paidforupcomingterm__c						AS paid_for_upcoming_term__c
	,A.partner_admissions_status__c
	,A.partner_employer_code__c
	,A.partner_expected_start_term__c
	,A.partner_external_id__c
	,A.partner_internal_student_id__c
	,A.partner_last_updated_date_time__c
	,A.partner_lsu_program_id__c
	,A.partner_lsu_program_name__c
	,A.partner_name__c
	,A.partner_record_created_date_time__c
	,A.partner_status__c
	,partnership_ev__c
	,A.partnership_ferpa__c
	,A.partnership_last_ev_update_date_time__c
	,A.pathway__c
	,A.payment_status__c
	,A.phone__c
	,A.pipeline_status__c
	,A.pipeline_status_code__c
	,pipeline_sub_status__c
	,A.plastatus__c						AS PLA_status__c 
	,A.preferred_name__c
	,A.program_not_offered__c
	,A.radius_application__c
	,A.recordtypeid							AS Source_recordtypeid
	,CASE WHEN O.Campus__c = 'CE' THEN R3.Id
		  ELSE R2.Id
	 END						AS RecordTypeId
	,A.referral_requested__c
	,A.registered_for_current_term__c
	,A.registered_for_up_coming_term__c
	,resigned__c
	,resigned_date__c
	,resigned_terms__c
	,A.scheduled_for_up_coming_term__c
	,A.slate_application_status__c		  
	,A.source__c
	,A.special_designator__c					AS lsus_special_designator__c
	,stop_out_entry_date__c
	,A.student_admitted_date__c
	,A.student_file_created_date__c
	,A.student_id__c
	,A.student_status__c
	,term_1_2_entry_date__c
	,A.term_admitted__c
	,A.term_applied__c
	,A.term_deferral__c
	,A.term_enrolled__c
	,A.term_of_interest__c
	,A.term_of_return__c
	,A.university_email__c+'.invalid'			AS university_email__c 
	,A.up_coming_term_enrollments__c
	,A.upsert_key__c
	,A.welcome_call_attempts__c
	,A.welcome_call_scheduled_date_time__c
	,A.welcome_call_status__c
	,welcome_call_time_zone__c
	,A.welcome_email_sent__c
	,OD.Id										AS Related_Opportunity__c
	,CASE WHEN ce_ce_status__c	= 'Completer'           THEN 'Completed'
		  WHEN ce_ce_status__c	= 'Continuing Student'	THEN 'Enrolled'
		  WHEN ce_ce_status__c	= 'Inactive'			THEN 'Dropped'
		  WHEN A.pipeline_status__c = 'Degree Candidate'  THEN 'Enrolled'
		  WHEN A.pipeline_status__c = 'Application'		THEN 'Awaiting Submission'
		  WHEN A.pipeline_status__c = 'Prospect'			THEN 'Prospect'
		  WHEN A.pipeline_status__c = 'Alumni'				THEN 'Completed'
		  WHEN A.pipeline_status__c = 'Fallout'			THEN 'Completed'
		  WHEN A.pipeline_status__c = 'Attempting'			THEN 'Attempting'
		  WHEN A.pipeline_status__c = 'Term 1 / 2'			THEN 'Enrolled'
		  WHEN A.pipeline_status__c = 'Continuing Student'	THEN 'Enrolled'
		  WHEN A.pipeline_status__c = 'Inactive'			THEN 'Dropped'
		  WHEN A.pipeline_status__c = 'Decision Released'	THEN 'Closed'
		  WHEN A.pipeline_status__c = 'Onboarding'			THEN 'Enrolled'
		  WHEN A.pipeline_status__c = 'Stop Out'			THEN  'Stop Out'
	 END										AS [Status]
FROM [edaprod].[dbo].[hed__Affiliation__c]	A
LEFT JOIN [EDUCPROD].[dbo].[User] cr
ON A.CreatedById = cr.EDAUSERID__c
LEFT JOIN [EDUCPROD].[dbo].[User] Ou
ON A.OwnerId = Ou.EDAUSERID__c
--LEFT JOIN [EDUCPROD].[dbo].[User_Lookup] U
--ON A.user__c = U.Legacy_ID__c
LEFT JOIN [EDUCPROD].[dbo].[Contact] C
ON A.hed__Contact__c = C.Legacy_ID__c
LEFT JOIN [EDUCPROD].[dbo].[Contact] C2
ON A.contact_retention__c = C2.Legacy_ID__c
LEFT JOIN [edaprod].[dbo].[Recordtype] R_EDA
ON A.RecordTypeId = R_EDA.Id
LEFT JOIN [edaprod].[dbo].[Opportunity] O
ON O.Affiliation__c = A.Id
LEFT JOIN [EDUCPROD].[dbo].[Recordtype] R2
ON R2.DeveloperName = 'Retention_OE'
LEFT JOIN [EDUCPROD].[dbo].[Recordtype] R3
ON R3.DeveloperName = 'Retention_CE'
LEFT JOIN [EDUCPROD].[dbo].[LearningProgramPlan] L
ON L.Name = A.Academic_Program__c
LEFT JOIN [EDUCPROD].[dbo].[LearningProgram] L2
ON L2.name = A.Academic_Program__c
AND L2.program_id__c = A.Program_ID__c
LEFT JOIN [EDUCPROD].[dbo].[Opportunity] OD
ON O.Id = OD.Legacy_ID__c
LEFT JOIN [EDUCPROD].[dbo].[IndividualApplication] IA
ON IA.Legacy_Id__c = A.application_id__c
WHERE O.StageName = 'Enrolled'