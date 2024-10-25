USE [edcuat];
GO

/****** Object:  View [dbo].[02_EDA_OrgAccount]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[08_EDA_Student] AS

SELECT 
	NULL						AS ID
	,acadacd__c
	,acadacds__c
	,actlstrt__c
	,addr1__c
	,addr2__c
	,addr3__c
	,admterm__c
	,aggregate_match_id_1__c
	,aggregate_match_id_2__c
	,applid__c
	,birthdte__c
	,S.campus__c
	,city__c
	,classic_created_date__c
	,college_attend__c
	,collegeacademicaction__c					AS college_academic_action__c
	,collegeacademicactiondescription__c		AS college_academic_action_description__c
	,concentration__c
	,contact__c as Source_contact__c
	,country__c
	,cphone__c
	,curriccd__c
	,curricds__c
	,drop_balance_due__c
	,drop_balance_due_date__c
	,drop_indicator__c
	,drop_start_date__c
	,drop_term_code__c
	,S.dropped_from_student_file__c
	,emplcode__c
	,S.employer__c
	,enrolled_hours__c
	,ext_classic_id__c
	,ext_key__c
	,finaidaccept1__c
	,finaidaccept2__c
	,finaidaccept3__c
	,finaidaccept4__c
	,frstname__c
	,gender__c
	,financial_aid_indicator__c
	,graddate__c
	,holddate1__c
	,holddate2__c
	,holddesc1__c
	,holddesc2__c
	,holdstat1__c
	,holdstat2__c
	,holdstatdesc1__c
	,holdstatdesc2__c
	,holdtype1__c
	,holdtype2__c
	,holdtype3__c
	,hours__c
	,instdate__c
	,internl__c
	,S.ID			AS EDACERTENROLLID__c
	,S.lsua_degree_code__c
	,S.lsua_grad_degree__c
	,S.lsua_grad_status__c
	,S.lsua_grad_term__c
	,S.lsua_grad_year__c
	,S.lsua_matriculation_year__c
	,S.lsua_term_1_financial_aid_status_codes__c
	,S.lsua_term_2_financial_aid_status_codes__c
	,S.lsua_term_3_financial_aid_status_codes__c
	,S.lsua_term_4_financial_aid_status_codes__c
	,S.lsua_total_earned_credits__c
	,lsuemail__c
	,lsufice__c
	,lsuhourscarried__c
	,middname__c
	,lsuid__c
	,minor_1__c
	,minor_2__c
	,minor_3__c
	,minor_4__c
	,missingdocs1__c
	,missingdocs2__c
	,missingdocs3__c
	,missingdocs4__c
	,moddegcd__c
	,moddegds__c
	,nextterm__c
	,S.noteligibletoreturn__c					AS not_eligible_to_return__c
	,online_term__c
	,origterm__c
	,othrname__c
	,ovrlgpa__c
	,ovrlhrsca__c
	,ovrlhrsen__c
	,paymentdate__c								as Payment_Date__c
	,paystatus__c
	,pgmadmdt__c
	,pgmcode__c  AS Source_pgmcode__c
	,S.phone__c
	,previous_term_academic_action__c
	,previous_term_academic_action_desc__c
	,program_enrollment_status_code__c
	,program_enrollment_status_description__c
	,semgpm__c
	,semhoursearned__c
	,sponsor1__c
	,sponsor2__c
	,sponsor3__c
	,S.state__c
	,status_code__c 
	,status_date__c
	,status_description__c
	,stopreason1__c
	,stopreason2__c
	,studentcurrentgpa__c
	,studenttotalcredits__c
	,suffix__c
	,termpay1__c
	,termpay2__c
	,termpay3__c
	,termpay4__c
	,total_balance_due__c
	,tpayflag1__c
	,tpayflag2__c
	,tpayflag3__c
	,tpayflag4__c
	,LSU_Affiliation__c
	,null as LearningProgramPlanId
	,null as LearnerContactId
	,curricds__c as Name
	,RACE__c
	,RACEDESC__c
	,ETHNIC__c
	,ETHNDESC__c
	--,CR.ID AS createdbyid
	--,O.ID AS ownerid
	,EMAIL1__c+'.invalid'			AS EMAIL1__c
	,CASE WHEN A.ce_ce_status__c	= 'Completer'           THEN 'Completed'
		  WHEN A.ce_ce_status__c	= 'Continuing Student'	THEN 'Enrolled'
		  WHEN A.ce_ce_status__c	= 'Inactive'			THEN 'Dropped'
		  WHEN A.pipeline_status__c = 'Degree Candidate'  THEN 'Enrolled'
		  WHEN A.pipeline_status__c = 'Application'		THEN 'Active'
		  WHEN A.pipeline_status__c = 'Prospect'			THEN 'Active'
		  WHEN A.pipeline_status__c = 'Alumni'				THEN 'Completed'
		  WHEN A.pipeline_status__c = 'Fallout'			THEN 'Completed'
		  WHEN A.pipeline_status__c = 'Attempting'			THEN 'Active'
		  WHEN A.pipeline_status__c = 'Term 1 / 2'			THEN 'Enrolled'
		  WHEN A.pipeline_status__c = 'Continuing Student'	THEN 'Enrolled'
		  WHEN A.pipeline_status__c = 'Inactive'			THEN 'Dropped'
		  WHEN A.pipeline_status__c = 'Decision Released'	THEN 'Completed'
		  WHEN A.pipeline_status__c = 'Onboarding'			THEN 'Enrolled'
		  WHEN A.pipeline_status__c = 'Stop Out'			THEN  'Inactive'
	 END										AS [Status]
	 ,wphone__c
	 ,zip__c
FROM [edaprod].[dbo].[student__c] S
--LEFT JOIN [edcuat].[dbo].[User_Lookup] cr
--ON A.CreatedById = cr.Legacy_ID__c
--LEFT JOIN [edcuat].[dbo].[User_Lookup] O
--ON A.OwnerId = O.Legacy_ID__c
LEFT JOIN [edaprod].[dbo].[hed__Affiliation__c] A
ON A.Id = S.LSU_Affiliation__c
