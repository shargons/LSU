
USE [edcdatadev];
GO

/****** Object:  View [dbo].[10_EDA_Opportunity]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[10_EDA_Opportunity] AS

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
	,stagename
	,CASE WHEN O.Campus__c = 'CE' THEN R3.Id
		  ELSE R2.Id
	 END				AS RecordtypeId
FROM [edaprod].[dbo].[Opportunity] O
--LEFT JOIN [edcdatadev].[dbo].[User_Lookup] cr
--ON A.CreatedById = cr.Legacy_ID__c
--LEFT JOIN [edcdatadev].[dbo].[User_Lookup] O
--ON A.OwnerId = O.Legacy_ID__c
LEFT JOIN [edcdatadev].[dbo].[Contact] C
ON O.contactid = C.Legacy_ID__c
LEFT JOIN [edcdatadev].[dbo].[Case_Lookup] EA
ON O.Enrolled_Affiliation__c = EA.legacy_ID__c
LEFT JOIN [edcdatadev].[dbo].[Recordtype] R2
ON R2.DeveloperName = 'OE'
LEFT JOIN [edcdatadev].[dbo].[Recordtype] R3
ON R3.DeveloperName = 'CE'

