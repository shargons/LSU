USE [edcdatadev];
GO

/****** Object:  View [dbo].[13_EDA_ReqDocuments]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[18_EDA_CertificateEnrollments] AS

SELECT 
	 NULL												AS ID
	,affiliation__c										AS Source_Case
	,CL.Id												AS Case__c
	,cedivision__c										AS ce_division__c
	,coursescompleted__c								AS courses_completed__c
	,coursesenrolled__c									AS courses_enrolled__c
	,R.createddate										AS EDACREATEDDATE__c
	--,CR.ID											AS createdbyid
	,credithourscompleted__c							AS credit_hours_completed__c
	,flag__c					
	,R.id												 AS EDACERTENROLLID__c
	,R.name
	,one_certificate_code__c
	,one_certificate_id__c
	,one_certificate_status__c
	,CASE WHEN one_certificate_status__c = 'Issued'		THEN 'Completed'
		  WHEN one_certificate_status__c = 'Dropped'	THEN 'Dropped'
		  WHEN one_certificate_status__c = 'InProgress'	THEN 'Active'
		  WHEN one_certificate_status__c = 'Completed'	THEN 'Completed'
		  WHEN one_certificate_status__c = 'Expired'	THEN 'Inactive'
	 END												 AS Status
	,one_certificate_title__c
	,one_completion_date__c
	,one_completion_date__c								AS EndDate
	,one_drop_date__c
	,one_enrollment_date__c
	,one_enrollment_date__c								AS StartDate
	,one_issuance_date__c
	,one_last_activity_date__c
	,one_program_office_code__c
	,one_program_office_name__c
	,one_status__c
	,one_student_id__c									AS Source_one_Student_Id
	,C.Id												AS one_Student_Id__c
	,C.Id												AS LearnerContactId
	,C.AccountId										AS LearnerAccountId
	--,O.ID												AS ownerid
	,programplan__c										AS Source_learning_program_plan
	,LP.Id												AS Learning_Program_Plan__c
	,LP.Id												AS LearningProgramPlanId
	,totalcreditsenrolled__c							AS total_credits_enrolled__c
	,CoursesFailed__c									AS Courses_Failed__c
	,CL.Related_Opportunity__c							AS OpportunityId
FROM [edaprod].[dbo].[one_certificate_enrollment__c] R
--LEFT JOIN [edcdatadev].[dbo].[User_Lookup] cr
--ON R.CreatedById = cr.Legacy_ID__c
--LEFT JOIN [edcdatadev].[dbo].[User_Lookup] O
--ON R.OwnerId = O.Legacy_ID__c
INNER JOIN [edcdatadev].[dbo].[Contact] C
ON R.one_student_id__c = C.Legacy_ID__c
INNER JOIN [edcdatadev].[dbo].LearningProgramPlan_ProgPlan_Lookup LP
ON R.programplan__c = LP.Legacy_ID__c
INNER JOIN [edcdatadev].[dbo].[Case] CL
ON R.affiliation__c = CL.Legacy_ID__c


