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
	,admterm__c
	,college_attend__c
	,concentration__c
	,contact__c as Source_contact__c
	,curriccd__c
	,curricds__c
	,drop_balance_due__c
	,drop_balance_due_date__c
	,drop_indicator__c
	,drop_start_date__c
	,drop_term_code__c
	,emplcode__c
	,employer__c
	,enrolled_hours__c
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
	,ID			AS Legacy_ID__c
	,lsua_degree_code__c
	,lsua_grad_degree__c
	,lsua_grad_status__c
	,lsua_grad_term__c
	,lsua_grad_year__c
	,lsua_matriculation_year__c
	,lsua_term_1_financial_aid_status_codes__c
	,lsua_term_2_financial_aid_status_codes__c
	,lsua_term_3_financial_aid_status_codes__c
	,lsua_term_4_financial_aid_status_codes__c
	,lsua_total_earned_credits__c
	,lsufice__c
	,lsuhourscarried__c
	,lsuid__c
	,minor_1__c
	,minor_2__c
	,minor_3__c
	,minor_4__c
	,moddegcd__c
	,moddegds__c
	,nextterm__c
	,origterm__c
	,othrname__c
	,ovrlgpa__c
	,ovrlhrsca__c
	,ovrlhrsen__c
	,paystatus__c
	,pgmadmdt__c
	,pgmcode__c  AS Source_pgmcode__c
	,previous_term_academic_action__c
	,previous_term_academic_action_desc__c
	,program_enrollment_status_code__c
	,program_enrollment_status_description__c
	,semgpm__c
	,semhoursearned__c
	,sponsor1__c
	,sponsor2__c
	,sponsor3__c
	--,status_code__c
	,status_date__c
	,status_description__c
	,stopreason1__c
	,stopreason2__c
	,studentcurrentgpa__c
	,studenttotalcredits__c
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
	,BIRTHDTE__c
	,GENDER__c
	--,CR.ID AS createdbyid
	--,O.ID AS ownerid
FROM [edaprod].[dbo].[student__c]
--LEFT JOIN [edcdatadev].[dbo].[User_Lookup] cr
--ON A.CreatedById = cr.Legacy_ID__c
--LEFT JOIN [edcdatadev].[dbo].[User_Lookup] O
--ON A.OwnerId = O.Legacy_ID__c

