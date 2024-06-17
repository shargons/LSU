
USE [edcdatadev];
GO

/****** Object:  View [dbo].[02_EDA_OrgAccount]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--CREATE OR ALTER VIEW [dbo].[14_EDA_Opportunity] AS

SELECT 
	 NULL						AS ID
	,accepted_entry_date__c
	,active__c
	,admitted_entry_date__c
	,admitted_status__c
	,affiliation__c				AS Source_affiliation__c
	,all_missing_checklist_items__c
	,amount
	,anticipated_graduation_date__c
	,application_actual_start_date__c
	,application_admitted_date__c
	,application_created_date__c
	,application_entry_date__c
	,application_entry_term__c
	,application_fee_waiver_type__c
	,application_id__c			AS Source_application_id__c
	,application_slate_id__c
	,application_status_code_c__c
	,application_submitted_date__c
	--,applicationbelongstopartner__c
	,appliedtermflag__c			AS term_applied_bucket__c
	,appliedtermid__c			AS applied_termid__c
	,appointmentscheduled__c	AS appointment_scheduled__c
	,attempting_entry_date__c
	,ce_activity__c
	,ce_activity_additional_info__c
	,ce_impacted_financially_by_covid_19__c
	,ce_industry__c
	--,ce_industry_detail__c
	,ce_initial_guild_registration_completed__c
	,ce_lead_source_string__c
	,ce_legacy_lead_id__c
	,ce_motivation__c
	,ce_motivation_additional_info__c		
	,ce_not_qualified_for_scholarship__c
	,ce_other_industry__c
	,ce_partner_employer_code__c				AS ce_partner_employer_code__c
	,ce_partnership_academic_period_id__c
	,ce_partnership_current_funding_gap__c
	,ce_partnership_ev__c
	,ce_partnership_financial_status__c
	,ce_partnership_funding_max__c
	,ce_partnership_funding_remaining__c
	,ce_partnership_last_ev_update_datetime__c
	,ce_partnership_program_cost_formula__c
	,ce_partnership_programcost__c					AS ce_partnership_program_cost__c
	,ce_payment__c
	,ce_payment_additional_info__c
	,ce_previous_company__c
	,ce_previous_position__c
	,ce_program_coming_soon_halted__c
	,ce_program_costing_unit_program_area__c
	,ce_program_department__c
	,ce_program_partnership__c
	,ce_qualifies_for_ce_assignment__c
	--,ce_Scheduled_Appointment__c
	,ce_scholarship_type__c
	,ce_start_date__c
	,ce_start_date_additional_info__c
	,ce_term_date__c
	--,ce_Warm_Transfer__c
	,ceroundrobinautonumber__c						AS ce_roundrobin_autonumber__c
	,cfg_batch_criteria_met__c						AS batch_criteria_met__c
	,cfg_batch_run_date_time__c						AS batch_run_date_time__c
	,cfg_execute_assignment_batch_logic__c			AS execute_assignment_batch_logic__c
	,cfg_next_task_due__c							AS next_task_due__c
	,cfg_open_tasks__c								AS open_tasks__c
	,cfg_task_push_date__c							AS task_push_date__c
	,closedate
	,comments__c
	,completed_terms_rollup__c
	,completed_terms_rollupx__c						AS completed_terms_rollup__c
	,confirmprogramisguildapproved__c				AS confirm_program_is_guild_approved__c
	,confirmstudenttoconsultguildcoach__c			AS confirm_student_to_consult_guild_coach__c
	,contact__c										as Source_contact__c
	,coordinator__c									as Source_coordinator__c
	,courseraeoisubmitteddate__c
	--,createdbyid
	,createddate
	,cumulative_gpa__c
	,current_cohort__c
	,current_term_enrollments__c
	,current_term_enrollmentsx__c					AS current_term_enrollments__c		
	,current_term_registered_hours__c
	,declined_entry_date__c
	,deferral__c									AS Source_Deferral__c
	,deferred__c									AS deferred__c
	,deferred_term__c
	,degree_candidate__c
	,denied_entry_date__c
	,description
	,direct_app__c
	,dripstartdatetime__c							AS drip_start_date_time__c
	,dropped_from_student_file__c
	,duplicate_entry_date__c
	,ec_handoff_date__c
	,employer__c
	,enrolled_affiliation__c						AS Source_enrolled_affiliation__c
	,enrolled_entry_date__c
	,expectedrevenue
	,ext_classic_contact_id__c
	,ext_classic_lead_id__c
	,fallout_entry_date__c
	,fetchceguildenrollment__c						AS first_enrollment_date__c	
	,first_enrollment_date__c
	,first_enrollment_term__c
	,first_inquiry_source__c
	,firstenrolledterm__c							AS first_enrolled_term__c
	,funding_source__c
	,funding_source_other__c
	,future_interest_term__c
	,future_scheduled_term__c
	,gclid__c
	,graduated__c
	,gs_admission_type__c
	,gs_application_type__c
	,guild_cohort_for_matching__c
	,guild_cohorts_historical__c
	,guild_ev_history__c
	,guild_reporting_field__c
	--,guild_reporting_field_has_changed_today__c
	,guild_reporting_field_last_change_date__c
	,hand_over_to_lc__c
	,high_risk__c
	,home__c
	,hot_lead__c
	,id						AS Legacy_ID__c
	,inactive_application__c
	,initial_guild_registration_completed__c
	,inquiry_date__c
	,inquiry_journey_complete__c
	,internship__c
	,lead_applicant_pipeline_status__c				AS online_lead_applicant_pipeline_status__c
	,leadsource
	,learn_more__c
	,legacy_ce_guild_opportunity__c
	,lsu_id__c
	,lsu_lead_source__c								AS recent_lsu_lead_source__c
	,lsua_degree_code__c
	,lsua_reviewed_by_counselor__c
	,lsushistoicalrecord__c							AS lsus_histoical_record__c
	,marketing_channel__c							AS first_marketing_channel__c
	,missing_documents__c
	,name
	,not_interested__c
	,not_qualified__c
	,not_scheduled_entry_date__c
	,opportunity_key__c
	,original_created_date__c
	--,ownerid
	,p_o_created__c
	,paidforcurrentterm__c
	,paidforupcomingterm__c
	,partner_admissions_flag_reason__c
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
	,partnership_discount_code__c
	,partnership_ferpa__c
	,partnership_last_ev_update_date_time__c
	,partnership_matching_id__c						AS partnershipapplicantresponseformula__c
	,partnership_matching_id_text__c
	,partnershipapprovedprogram__c
	,payment_status__c
	,phone__c
	,pipeline_status_code__c
	,plan_code__c
	,plastatus__c
	,preferred_name__c
	,primary_motivation__c
	,probability
	,program_not_offered__c
	,program_of_interest__c
	,prospect_entry_date__c
	,re_engage_date__c
	,recent_marketing_channel__c
	,recentappliedterm__c
	--,recordtypeid
	,referral_requested__c
	,registered_entry_date__c
	,registered_for_current_term__c
	,registered_for_up_coming_term__c
	,scheduled_entry_date__c
	,scheduled_for_current_term__c
	,scheduled_for_up_coming_term__c
	,sfid__c
	,sfid_dob__c
	,sfid_dob_text__c
	,sfid_text__c
	,slate_application_status__c
	,source__c
	,special_designator__c
	,stagename
	,student_admitted_date__c
	,student_file_created_date__c
	,student_id__c					AS Source_student_id__c
	,student_status__c
	,sub_stage__c
	,term_admitted__c				
	,term_applied__c
	,term_deferral__c
	,term_enrolled__c
	,term_of_interest__c
	,term_of_return__c
	,termadmitbucket__c
	,termadmittedlookup__c			AS Source_termadmittedlookup__c
	,termadmittedyear__c
	,termappliedlookup__c			AS Source_termappliedlookup__c
	,transfer_type__c
	,trigger__c
	,triggergoalsflow__c
	,up_coming_term_enrollments__c
	,up_coming_term_enrollmentsx__c
	,welcome_call_attempts__c
	,welcome_call_scheduled_date_time__c
	,welcome_call_status__c
	,welcome_call_time_zone_abbr__c
	,welcome_email_sent__c
FROM [edaprod].[dbo].[Opportunity] O