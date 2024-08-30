USE [edcuat];
GO

/****** Object:  View [dbo].[02_EDA_OrgAccount]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[13C_ApplicationDecision] AS

SELECT
	 NULL											AS ID
	,A.id											AS UpsertKey__c
	,admit_committee_decision__c					 
	,admit_with_consideration_decision__c
	,admit_with_consideration_decision_reason__c					
	,decisiondate__c								AS decision_date__c			
	,deny_decision__c
	,deny_decision_reason__c
	,most_recent_decision__c
	,refer_decision__c
	,refer_decision_reason__c
	,slate_admit_decision__c
	,Pipeline_Status__c
	,CASE WHEN Pipeline_Sub_Status__c = 'Awaiting on Department' THEN 'Enroll'
		  WHEN Pipeline_Sub_Status__c = 'Applied' THEN 'Enroll'
		  WHEN Pipeline_Sub_Status__c = 'Missing Documents' THEN 'Enroll'
		  WHEN Pipeline_Sub_Status__c = 'Awaiting Payment' THEN 'Enroll'
		  WHEN Pipeline_Sub_Status__c = 'Denied' THEN 'Deny'
		  WHEN Pipeline_Sub_Status__c = 'Admitted' THEN 'Admit'
		  WHEN Pipeline_Sub_Status__c = 'Awaiting Submission' THEN 'Enroll'
		  WHEN Pipeline_Sub_Status__c = 'Withdrawn' THEN '	Cancelled'
	END AS ApplicationDecision
	,I.ID										AS ApplicationId
FROM  [edaprod].[dbo].[Application__c] A
LEFT JOIN [edcuat].[dbo].[IndividualApplication_Lookup] I
ON I.legacy_ID__c = A.Id