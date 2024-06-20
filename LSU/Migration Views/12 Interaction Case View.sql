USE [edcdatadev];
GO

/****** Object:  View [dbo].[12_EDA_Interactions]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[12_EDA_Interactions] AS

SELECT 
	NULL						AS ID
	,contact__c					AS Source_Contact
	,C.Id						AS ContactId
	,C.AccountId				AS AccountId
	--,CR.ID AS createdbyid
	,event_name__c
	,gclid__c
	,new_lsu_lead_source__c
	,marketing_channel__c
	--,O.ID AS ownerid
	,'I-'+I.id							AS Legacy_Id__c
	,utm_name__c
	,utm_content__c
	,utm_lead_medium__c
	,utm_source__c
	,utm_term__c
	,Firstname+' '+Lastname+' '+new_lsu_lead_source__c AS Subject
	,R2.ID						AS RecordtypeId
FROM [edaprod].[dbo].[Interaction__c]	I
LEFT JOIN [edcdatadev].[dbo].[Contact] C
ON I.contact__c = C.Legacy_ID__c
LEFT JOIN [edcdatadev].[dbo].[Recordtype] R2
ON R2.DeveloperName = 'RFI'
--LEFT JOIN [edcdatadev].[dbo].[User_Lookup] cr
--ON A.CreatedById = cr.Legacy_ID__c
--LEFT JOIN [edcdatadev].[dbo].[User_Lookup] O
--ON A.OwnerId = O.Legacy_ID__c

