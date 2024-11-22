USE [edcuat];
GO

/****** Object:  View [dbo].[02_EDA_OrgAccount]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[06_EDA_Lead] AS

SELECT  NULL							 AS ID
		,answering_machine_call_count__c as answering_machine_call_count__c
		,bad_phone__c as Bad_Number__c
		,call_activity_count__c 
		,call_count__c 
		,company__c as company
		,CR.ID AS createdbyid
		,O.ID AS ownerid
		,C.description
		,donotcall
		,LEFT(C.email, 246) +'.test' AS Email
		,hasoptedoutofemail
		,C.[Fax]
		,HasOptedOutOfFax
		,hed__gender__c					AS GenderIdentity
		,C.LeadSource
		,Status__c
		,C.LSU_Lead_Source__c
		,C.FirstName
		,C.Salutation
		,C.LastName
		,C.MiddleName
		,C.Suffix
		,C.Phone
		,C.SMS_Integration__SMS_Opt_Out__c
		,Stop_Auto_Dialer__c
		,C.Title
		,C.ID							AS Legacy_Id__c
		,C.Classic_Created_Date__c		AS EDACreatedDate__c
		,C.CreatedDate	
		,Op.StageName
FROM [edaprod].[dbo].[Contact] C
LEFT JOIN [edaprod].[dbo].[Opportunity] Op
ON C.Id = Op.ContactId
LEFT JOIN [edcuat].[dbo].[User] CR
ON C.CreatedById = CR.EDAUSERID__c
LEFT JOIN [edcuat].[dbo].[User] O
ON C.OwnerId = O.EDAUSERID__c
WHERE Op.StageName IN ('New','Attempting')