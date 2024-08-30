
USE [edcuat];
GO

/****** Object:  View [dbo].[10_EDA_Opportunity]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[12_EDA_Opportunity] AS

SELECT 
	 NULL						AS ID
	,amount
	,closedate
	,contact__c										as Source_contact__c
	,C.AccountId									AS AccountId
	--,CR.ID AS createdbyid
	,O.createddate
	,expectedrevenue
	,gclid__c
	,O.id						AS Legacy_ID__c
	,O.leadsource
	,O.name
	--,O.ID AS ownerid
	,probability
	,CASE WHEN O.Campus__c = 'CE' THEN R3.Id
		  ELSE R2.Id
	 END				AS RecordtypeId
	, CASE -- CE
	WHEN StageName = 'Re-engage'	AND RecordTypeId = R2.Id         THEN 'Prospecting '
	WHEN StageName  = 'New'			AND RecordTypeId = R2.Id		  THEN 'Prospecting'
	WHEN StageName  = 'Prospect'	AND RecordTypeId = R2.Id 	  THEN 'Recruiting'
	WHEN StageName  = 'Application'	AND RecordTypeId = R2.Id	  THEN 'Admitted'
	WHEN StageName  = 'Duplicate'	AND RecordTypeId = R2.Id	  THEN 'Prospecting'
	WHEN StageName  = 'Fallout'		AND RecordTypeId = R2.Id	  THEN 'Closed Lost'
	WHEN StageName  = 'Denied'		AND RecordTypeId = R2.Id	  THEN 'Closed Lost'
	WHEN StageName  = 'Not Scheduled' AND RecordTypeId = R2.Id	  THEN 'Recruiting'
	WHEN StageName  = 'Scheduled'	AND RecordTypeId = R2.Id	  THEN 'Recruiting'
	WHEN StageName  = 'Attempting'	AND RecordTypeId = R2.Id	  THEN 'Qualification'
	WHEN StageName  = 'Declined'	AND RecordTypeId = R2.Id	  THEN 'Closed Lost'
	WHEN StageName  = 'Admitted'	AND RecordTypeId = R2.Id	  THEN 'Admitted'
	WHEN StageName  = 'Registered'	AND RecordTypeId = R2.Id	  THEN 'Registered'
	WHEN StageName  = '3rd Party Program' AND RecordTypeId = R2.Id THEN '3rd Party Program'
	WHEN StageName  = 'Closed Won'	AND RecordTypeId = R2.Id	  THEN 'Closed Won'
	WHEN StageName  = 'Closed Lost'	AND RecordTypeId = R2.Id	  THEN 'Closed Lost'
	WHEN StageName  = 'Accepted'	AND RecordTypeId = R2.Id	  THEN 'Enrolled'
	WHEN StageName  = 'Enrolled'	AND RecordTypeId = R2.Id	  THEN 'Enrolled'
	-- OE
	WHEN StageName = 'Re-engage'	AND RecordTypeId = R3.Id         THEN 'Prospecting '
	WHEN StageName  = 'New'			AND RecordTypeId = R3.ID		  THEN 'Prospecting'
	WHEN StageName  = 'Prospect'	AND RecordTypeId = R3.ID 	  THEN 'Recruiting'
	WHEN StageName  = 'Application'	AND RecordTypeId = R3.ID	  THEN 'Application'
	WHEN StageName  = 'Duplicate'	AND RecordTypeId = R3.ID	  THEN 'Prospecting'
	WHEN StageName  = 'Fallout'		AND RecordTypeId = R3.ID	  THEN 'Closed Lost'
	WHEN StageName  = 'Denied'		AND RecordTypeId = R3.ID	  THEN 'Closed Lost'
	WHEN StageName  = 'Not Scheduled' AND RecordTypeId = R3.ID	  THEN 'Recruiting'
	WHEN StageName  = 'Scheduled'	AND RecordTypeId = R3.ID	  THEN 'Recruiting'
	WHEN StageName  = 'Attempting'	AND RecordTypeId = R3.ID	  THEN 'Qualification'
	WHEN StageName  = 'Declined'	AND RecordTypeId = R3.ID	  THEN 'Closed Lost'
	WHEN StageName  = 'Admitted'	AND RecordTypeId = R3.ID	  THEN 'Admitted'
	WHEN StageName  = 'Registered'	AND RecordTypeId = R3.ID	  THEN 'Registered'
	WHEN StageName  = '3rd Party Program' AND RecordTypeId = R3.ID THEN '3rd Party Program'
	WHEN StageName  = 'Closed Won'	AND RecordTypeId = R3.ID	  THEN 'Closed Won'
	WHEN StageName  = 'Closed Lost'	AND RecordTypeId = R3.ID	  THEN 'Closed Lost'
	WHEN StageName  = 'Accepted'	AND RecordTypeId = R3.ID	  THEN 'Accepted'
	WHEN StageName  = 'Enrolled'	AND RecordTypeId = R3.ID	  THEN 'Enrolled'
	ELSE StageName
END AS StageName
,CASE 
	WHEN StageName  = 'Fallout'			  THEN 'Fallout'
	WHEN StageName  = 'Denied'			  THEN 'Denied'
	ELSE NULL
END AS Closed_Reason__c
,O.Application_ID__c			AS Source_application_id__c
FROM [edaprod].[dbo].[Opportunity] O
--LEFT JOIN [edcuat].[dbo].[User_Lookup] cr
--ON A.CreatedById = cr.Legacy_ID__c
--LEFT JOIN [edcuat].[dbo].[User_Lookup] O
--ON A.OwnerId = O.Legacy_ID__c
LEFT JOIN [edcuat].[dbo].[Contact] C
ON O.contactid = C.Legacy_ID__c
LEFT JOIN [edcuat].[dbo].[Case_Lookup] EA
ON O.Enrolled_Affiliation__c = EA.legacy_ID__c
LEFT JOIN [edcuat].[dbo].[Recordtype] R2
ON R2.DeveloperName = 'OE'
LEFT JOIN [edcuat].[dbo].[Recordtype] R3
ON R3.DeveloperName = 'CE'
WHERE O.StageName NOT IN ('New','Attempting','Qualified','Nurture','Disqualified','Duplicate')

