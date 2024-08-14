USE [edcdatadev];
GO

/****** Object:  View [dbo].[13_EDA_ReqDocuments]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[11_Case_Opp_Recruitment] AS

SELECT DISTINCT
	 NULL												AS ID
	,accepted_entry_date__c
	,R.active__c
	,admitted_entry_date__c
	,R.admitted_status__c
	,R.all_missing_checklist_items__c
	,R.anticipated_graduation_date__c
	,R.application_actual_start_date__c
	,R.application_admitted_date__c
	,R.application_created_date__c
	,R.application_entry_date__c
	,R.application_entry_term__c
	,R.application_fee_waiver_type__c
	,R.application_id__c
	,R.application_slate_id__c
	,application_status_code_c__c						as Application_Status_Code__c
	,R.application_submitted_date__c
	,appliedtermflag__c									AS 	term_applied_bucket__c	
	,appliedtermid__c									AS  Applied_TermId__c
	,appointmentscheduled__c							AS appointment_scheduled__c
	,attempting_entry_date__c
	,ce_activity__c
	,ce_activity_additional_info__c
	,ce_impacted_financially_by_covid_19__c
	,ce_industry__c
	,ce_industry_detail__c
	,ce_initial_guild_registration_completed__c
	,ce_lead_source_string__c
	,ce_legacy_lead_id__c
	,ce_motivation__c
	,ce_motivation_additional_info__c
	,R.ce_not_qualified_for_scholarship__c
	,ce_other_industry__c
	,ce_partner_employer_code__c
	,R.ce_partnership_academic_period_id__c
	,ce_partnership_ev__c
	,R.ce_partnership_financial_status__c
	,R.ce_partnership_funding_max__c
	,R.ce_partnership_funding_remaining__c
	,R.ce_partnership_last_ev_update_datetime__c
	,ce_partnership_programcost__c					    AS CE_Partnership_Program_Cost__c												
	,ce_payment__c
	,ce_payment_additional_info__c
	,ce_previous_company__c
	,ce_previous_position__c
	,ce_program_coming_soon_halted__c
	,ce_program_partnership__c
	,ce_scholarship_type__c
	,ce_start_date__c
	,ce_start_date_additional_info__c
	,ce_term_date__c
	,ceroundrobinautonumber__c					AS ce_roundrobin_autonumber__c
	,cfg_batch_criteria_met__c					AS batch_criteria_met__c
	,cfg_batch_run_date_time__c					AS batch_run_date_time__c
	,cfg_execute_assignment_batch_logic__c		AS execute_assignment_batch_logic__c
	,cfg_next_task_due__c						AS next_task_due__c
	,cfg_open_tasks__c							AS open_tasks__c
	,cfg_task_push_date__c						AS task_push_date__c
	,R.comments__c								
	,completed_terms_rollupx__c					AS Completed_Terms_Rollup__c
	,confirmprogramisguildapproved__c			AS confirm_program_is_guild_approved__c
	,confirmstudenttoconsultguildcoach__c		AS confirm_student_to_consult_guild_coach__c
	,R.contact__c								AS Source_Contact
	,C.AccountId								AS AccountId
	,coordinator__c								AS Source_coordinator__c
	--,OC.Id									AS coordinator__c
	,courseraeoisubmitteddate__c				AS Coursera_EOI_Submitted_Date__c
	--,cr.id									AS createdbyid
	,R.createddate
	,R.cumulative_gpa__c
	,current_term_enrollmentsx__c				AS Current_Term_Enrollments__c
	,R.current_term_registered_hours__c
	,declined_entry_date__c
	--,deferral__c
	,R.deferred__c
	,R.deferred_term__c
	,R.degree_candidate__c
	,denied_entry_date__c
	,R.description
	,direct_app__c
	,dripstartdatetime__c						AS Drip_Start_DateTime__c
	,R.dropped_from_student_file__c
	,duplicate_entry_date__c
	,ec_handoff_date__c
	,R.employer__c
	,enrolled_affiliation__c					AS Source_Enrolled_Affiliation
	,enrolled_entry_date__c
	,R.ext_classic_contact_id__c
	,R.ext_classic_lead_id__c
	,fallout_entry_date__c
	,fetchceguildenrollment__c					AS Fetch_CE_Guild_Enrollment__c
	,R.first_enrollment_date__c
	,R.first_enrollment_term__c
	,first_inquiry_source__c
	,firstenrolledterm__c						AS first_enrolled_term__c
	,R.funding_source__c
	,R.funding_source_other__c
	,future_interest_term__c					AS Source_future_interest_term__c
	,F.Id										AS future_interest_term__c
	,R.future_scheduled_term__c
	,R.graduated__c
	,R.gs_admission_type__c
	,R.gs_application_type__c
	,guild_cohort_for_matching__c
	,R.guild_cohorts_historical__c
	,R.guild_ev_history__c
	,guild_reporting_field__c
	,guild_reporting_field_last_change_date__c
	,hand_over_to_lc__c
	,high_risk__c
	,R.home__c
	,R.hot_lead__c
	,R.id											AS Legacy_ID__c
	,R.inactive_application__c
	,initial_guild_registration_completed__c
	,inquiry_date__c
	,inquiry_journey_complete__c
	,internship__c
	,R.lead_applicant_pipeline_status__c		AS online_lead_applicant_pipeline_status__c
	,learn_more__c
	,legacy_ce_guild_opportunity__c
	,R.lsu_id__c
	,R.lsu_lead_source__c						AS recent_lsu_lead_source__c
	,R.lsua_degree_code__c
	,R.lsua_reviewed_by_counselor__c
	,lsushistoicalrecord__c					AS lsus_histoical_record__c
	,R.marketing_channel__c					AS first_marketing_channel__c
	,missing_documents__c
	,R.name									AS 	Name__c
	,R.not_interested__c
	,not_qualified__c
	,not_scheduled_entry_date__c
	,R.opportunity_key__c
	,R.original_created_date__c
	--,O.Id									AS ownerid
	,R.p_o_created__c
	,paidforcurrentterm__c					AS Paid_for_current_Term__c
	,paidforupcomingterm__c					AS Paid_for_UpComing_Term__c
	,R.partner_admissions_flag_reason__c
	,R.partner_admissions_status__c
	,R.partner_employer_code__c
	,R.partner_expected_start_term__c
	,R.partner_external_id__c
	,R.partner_internal_student_id__c
	,R.partner_last_updated_date_time__c
	,R.partner_lsu_program_id__c
	,R.partner_lsu_program_name__c
	,R.partner_name__c
	,R.partner_record_created_date_time__c
	,R.partner_status__c
	,partnership_discount_code__c
	,R.partnership_ferpa__c
	,R.partnership_last_ev_update_date_time__c
	,R.partnership_matching_id_text__c
	,R.payment_status__c
	,R.phone__c
	,R.pipeline_status_code__c
	,plastatus__c							AS pla_status__c
	,R.preferred_name__c
	,primary_motivation__c
	,R.program_not_offered__c
	,R.program_of_interest__c				AS Program_of_Interest_List__c
	,prospect_entry_date__c
	,re_engage_date__c
	,recent_marketing_channel__c
	,recentappliedterm__c					AS recent_applied_term__c
	,referral_requested__c
	,registered_entry_date__c
	,R.registered_for_current_term__c
	,R.registered_for_up_coming_term__c
	,scheduled_entry_date__c
	,scheduled_for_current_term__c
	,R.scheduled_for_up_coming_term__c
	,R.sfid__c
	,sfid_dob__c
	,sfid_dob_text__c
	,sfid_text__c
	,R.slate_application_status__c
	,R.source__c
	,special_designator__c					AS  LSUS_Special_Designator__c
	,stagename								AS Stagename__c							
	,R.student_admitted_date__c
	,R.student_file_created_date__c
	,R.student_id__c
	,R.student_status__c
	,sub_stage__c
	,R.term_admitted__c
	,R.term_applied__c
	,R.term_deferral__c
	,R.term_enrolled__c
	,R.term_of_interest__c
	,R.term_of_return__c
	,termadmitbucket__c					AS term_admit_bucket__c
	,termadmittedlookup__c				AS Source_termadmittedlookup__c
	,T1.Id								AS term_admitted_lookup__c
	,termadmittedyear__c				AS term_admitted_year__c
	,termappliedlookup__c				AS Source_term_applied_lookup__c
	,T2.Id								AS term_applied_lookup__c
	,transfer_type__c
	,R.trigger__c
	,triggergoalsflow__c				AS Trigger_Goals_Flow__c
	,up_coming_term_enrollmentsx__c		AS up_coming_term_enrollments__c
	,R.welcome_call_attempts__c
	,R.welcome_call_scheduled_date_time__c
	,R.welcome_call_status__c
	,welcome_call_time_zone_abbr__c		AS 	Welcome_Call_Time_Zone__c
	,R.welcome_email_sent__c
	--,CA.Id									AS Source_RFI_Case__c
	,CASE WHEN R.Campus__c = 'CE' THEN R3.Id
		  ELSE R2.Id
	 END						AS RecordTypeId
	,ISNULL(C.Firstname,'')+' '+ISNULL(C.Lastname,'')+' '+COALESCE(R.First_Inquiry_Source__c,R.Recent_Marketing_Channel__c,'') AS Subject
	,C.FirstName				AS First_Name__c
	,C.LastName					AS Last_Name__c
	,CASE WHEN C.preferred_email__c	IS NULL
	      THEN C.alternateemail__c+'.invalid' 
		  ELSE C.preferred_email__c+'.invalid'
	 END						AS ContactEmail
	 ,CASE WHEN C.preferred_email__c	IS NULL
	      THEN C.alternateemail__c+'.invalid' 
		  ELSE C.preferred_email__c+'.invalid'
	 END						AS Email__c
	,C.phone					AS ContactPhone
FROM [edaprod].[dbo].[Opportunity] R
LEFT JOIN [edcdatadev].[dbo].[Contact] C
ON R.contact__c = C.Legacy_Id__c
--LEFT JOIN [edaprod].[dbo].Interaction__c I
--ON I.Opportunity__c = R.Id AND I.Interaction_Source__c = 'Student'
--LEFT JOIN [edcdatadev].[dbo].[Case] CA
--ON 'I-'+I.Id = CA.Legacy_ID__c
LEFT JOIN [edcdatadev].[dbo].[AcademicTerm] T1
ON R.termadmittedlookup__c = T1.EDATERMID__c
LEFT JOIN [edcdatadev].[dbo].[AcademicTerm] T2
ON R.termappliedlookup__c = T2.EDATERMID__c
LEFT JOIN [edcdatadev].[dbo].[AcademicTerm] F
ON R.future_interest_term__c = F.EDATERMID__c
LEFT JOIN [edcdatadev].[dbo].[Recordtype] R2
ON R2.DeveloperName = 'Recruitment_OE'
LEFT JOIN [edcdatadev].[dbo].[Recordtype] R3
ON R3.DeveloperName = 'Recruitment_CE'
--LEFT JOIN [edcdatadev].[dbo].[User_Lookup] cr
--ON R.CreatedById = cr.Legacy_ID__c
--LEFT JOIN [edcdatadev].[dbo].[User_Lookup] O
--ON R.OwnerId = O.Legacy_ID__c
--LEFT JOIN [edcdatadev].[dbo].[User_Lookup] OC
--ON R.coordinator__c = OC.Legacy_ID__c
WHERE R.StageName IN  ('Prospect','Application','Admitted','Missing Documents','Applied','Denied','Accepted','Declined','Fallout')