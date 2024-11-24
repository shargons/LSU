USE [EDUCPROD];
GO

/****** Object:  View [dbo].[23E_EDA_Enrollments]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[23E_EDA_Enrollments] AS

SELECT 
	 NULL												AS ID
	,associated_ce_guild_cohort__c						AS Associated_Guild_Cohort__c
	,backend_active_from_boomi__c
	,backend_enrollment_program_id__c
	,base_course_tuition__c
	,billable_fees__c
	,billable_tuition__c
	,R.campus__c
	,R.ce_division__c
	,ce_source_certificate_enrollment__c				AS Source_Certificate_Enrollment__c
	,LP.ID												AS Certificate_Enrollment__c
	,R.classic_created_date__c							AS EDACREATEDDATE__c
	,competition_status_desc__c
	,completion_status_code__c
	,contact__c										AS Source_ParticipantContactId
	,C.Id											AS ParticipantContactId
	,coursebalance__c								AS course_balance__c
	,coursedropdate__c								AS course_drop_date__c
	,courseid__c
	,R.createddate									
	,CR.ID										AS createdbyid
	--,credit_hours_for_course__c
	,credithoursforcourse__c						AS credit_hours_for_course__c
	,current_student__c
	,dropped_from_enrollment_file__c
	,effective_date__c
	,Enrollment_Term_Start_Date__c					AS StartDate
	,Start_Date__c
	,End_Date__c
	--,CompletionDateMF__c	AS EndDate
	,enrolled_status__c
	,enrollmentid__c
	,R.ext_classic_contact_id__c
	,R.ext_classic_id__c
	,R.ext_key__c
	,final_grade__c
	,final_progress_status__c
	,R.first_enrollment_date__c
	,R.id												AS Legacy_Id__c
	,R.lsu_affiliation__c								AS Source_Affiliation
	,CL.ID											AS Case__c
	,lsua_enrollment_status_date__c
	,CL.lsuam_current_term__c
	,CL.lsuam_upcoming_term__c
	,R.lsuamstudentprogramcode__c						AS lsuam_student_program_code__c
	,lsus_enrollment_term__c
	,mainframe_dataload_id__c
	,R.online_term__c
	,opportunity__c									AS Source_Opportunity
	,OL.ID											AS Opportunity__c
	,O.ID											AS ownerid
	,paymentstautus__c								AS payment_status__c
	,program__c
	,R.role__c
	,sectionid__c
	,status_code__c
	,status_desc__c
	,status_reason_code__c
	,statusreasoncode__c							AS status_reason_description__c
	,studentid__c
	,term__c
	,termmembershipaction__c						AS Term_Membership_Action__c
	,termmembershipactionts__c						AS 	Term_Membership_Action_TS__c
	,waiver_effective_term__c
	,waivers__c
	,waivertypecode__c
	,CO.Id											AS CourseOfferingId
FROM [edaprod].[dbo].[enrollment__c] R
LEFT JOIN [EDUCPROD].[dbo].[User] cr
ON R.CreatedById = cr.EDAUSERID__c
LEFT JOIN [EDUCPROD].[dbo].[User] O
ON R.OwnerId = O.EDAUSERID__c
LEFT JOIN [EDUCPROD].[dbo].[Contact] C
ON R.contact__c = C.Legacy_ID__c
LEFT JOIN [EDUCPROD].[dbo].[LearnerProgram] LP
ON R.ce_source_certificate_enrollment__c = LP.EDACERTENROLLID__c
LEFT JOIN [EDUCPROD].[dbo].[Case] CL
ON R.lsu_affiliation__c = CL.Legacy_ID__c
LEFT JOIN [EDUCPROD].[dbo].[Opportunity] OL
ON R.opportunity__c = OL.Legacy_ID__c
LEFT JOIN [EDUCPROD].[dbo].[CourseOffering] CO
ON R.Id = EDACROFRNGID__c
WHERE CO.Id IS NOT NULL

