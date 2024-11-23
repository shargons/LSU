
USE [EDUCPROD];
GO

/****** Object:  View [dbo].[10_EDA_Opportunity]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[12_EDA_Opportunity] AS

SELECT DISTINCT
	 NULL						AS ID
	,amount
	,closedate
	,contact__c										as Source_contact__c
	,C.AccountId									AS AccountId
	,CR.ID AS createdbyid
	,O.createddate
	,expectedrevenue
	,O.gclid__c
	,O.id						AS Legacy_ID__c
	,O.leadsource
	,O.name
	,OC.ID AS ownerid
	,probability
	,CASE WHEN O.Campus__c = 'CE' THEN R3.Id
		  ELSE R2.Id
	 END				AS RecordtypeId
	 ,O.Sub_Stage__c
	, CASE -- CE
	WHEN StageName = 'Re-engage'	AND O.Campus__c = 'CE'         THEN 'Prospecting '
	WHEN StageName  = 'New'			AND O.Campus__c = 'CE'		  THEN 'Prospecting'
	WHEN StageName  = 'Prospect'	AND O.Campus__c = 'CE' 	  THEN 'Recruiting'
	WHEN StageName  = 'Application'	AND O.Campus__c = 'CE'	  THEN 'Admitted'
	WHEN StageName  = 'Duplicate'	AND O.Campus__c = 'CE'	  THEN 'Prospecting'
	WHEN StageName  = 'Fallout'									  THEN 'Closed Lost'
	WHEN StageName  = 'Denied'		AND O.Campus__c = 'CE'	  THEN 'Closed Lost'
	WHEN StageName  = 'Not Scheduled' AND O.Campus__c = 'CE'	  THEN 'Recruiting'
	WHEN StageName  = 'Scheduled'	AND O.Campus__c = 'CE'	  THEN 'Recruiting'
	WHEN StageName  = 'Attempting'	AND O.Campus__c = 'CE'	  THEN 'Qualification'
	WHEN StageName  = 'Declined'	AND O.Campus__c = 'CE'	  THEN 'Closed Lost'
	WHEN StageName  = 'Admitted'	AND O.Campus__c = 'CE'	  THEN 'Admitted'
	WHEN StageName  = 'Registered'	AND O.Campus__c = 'CE'	  THEN 'Registered'
	WHEN StageName  = '3rd Party Program' AND O.Campus__c = 'CE' THEN '3rd Party Program'
	WHEN StageName  = 'Closed Won'	AND O.Campus__c = 'CE'	  THEN 'Closed Won'
	WHEN StageName  = 'Closed Lost'	AND O.Campus__c = 'CE'	  THEN 'Closed Lost'
	WHEN StageName  = 'Accepted'	AND O.Campus__c = 'CE'	  THEN 'Enrolled'
	WHEN StageName  = 'Enrolled'	AND O.Campus__c = 'CE'	  THEN 'Enrolled'
	-- OE
	WHEN StageName = 'Re-engage'	AND O.Campus__c <> 'CE'         THEN 'Prospecting '
	WHEN StageName  = 'New'			AND O.Campus__c <> 'CE'		  THEN 'Prospecting'
	WHEN StageName  = 'Prospect'	AND O.Campus__c <> 'CE' 	  THEN 'Recruiting'
	WHEN StageName  = 'Application'	AND O.Campus__c <> 'CE'	  THEN 'Application'
	WHEN StageName  = 'Duplicate'	AND O.Campus__c <> 'CE'	  THEN 'Prospecting'
	WHEN StageName  = 'Fallout'									  THEN 'Closed Lost'
	WHEN StageName  = 'Denied'		AND O.Campus__c <> 'CE'	  THEN 'Closed Lost'
	WHEN StageName  = 'Not Scheduled' AND O.Campus__c <> 'CE'	  THEN 'Recruiting'
	WHEN StageName  = 'Scheduled'	AND O.Campus__c <> 'CE'	  THEN 'Recruiting'
	WHEN StageName  = 'Attempting'	AND O.Campus__c <> 'CE'	  THEN 'Qualification'
	WHEN StageName  = 'Declined'	AND O.Campus__c <> 'CE'	  THEN 'Closed Lost'
	WHEN StageName  = 'Admitted'	AND O.Campus__c <> 'CE'	  THEN 'Admitted'
	WHEN StageName  = 'Registered'	AND O.Campus__c <> 'CE'	  THEN 'Registered'
	WHEN StageName  = '3rd Party Program' AND O.Campus__c <> 'CE' THEN '3rd Party Program'
	WHEN StageName  = 'Closed Won'	AND O.Campus__c <> 'CE'	  THEN 'Closed Won'
	WHEN StageName  = 'Closed Lost'	AND O.Campus__c <> 'CE'	  THEN 'Closed Lost'
	WHEN StageName  = 'Accepted'	AND O.Campus__c <> 'CE'	  THEN 'Accepted'
	WHEN StageName  = 'Enrolled'	AND O.Campus__c <> 'CE'	  THEN 'Enrolled'
	ELSE StageName
END AS StageName
,CASE 
	WHEN StageName  = 'Fallout'			  THEN 'Fallout'
	WHEN StageName  = 'Denied'			  THEN 'Denied'
	ELSE NULL
END AS Closed_Reason__c
,O.Application_ID__c			AS Source_application_id__c
,LP.Id							AS Learning_Program_of_Interest__c
,O.Original_Created_Date__c		AS EDACreatedDate__c
FROM [edaprod].[dbo].[Opportunity] O
LEFT JOIN [EDUCPROD].[dbo].[User] cr
ON O.CreatedById = cr.EDAUSERID__c
LEFT JOIN [EDUCPROD].[dbo].[User] OC
ON O.OwnerId = OC.EDAUSERID__c
LEFT JOIN [EDUCPROD].[dbo].[Contact] C
ON O.contactid = C.Legacy_ID__c
--LEFT JOIN [EDUCPROD].[dbo].[Case] EA
--ON O.Enrolled_Affiliation__c = EA.legacy_ID__c
LEFT JOIN [EDUCPROD].[dbo].[Recordtype] R2
ON R2.DeveloperName = 'OE'
LEFT JOIN [EDUCPROD].[dbo].[Recordtype] R3
ON R3.DeveloperName = 'CE'
LEFT JOIN [EDUCPROD].[dbo].[LearningProgram] LP
ON LP.Name =O.Academic_Program__c


