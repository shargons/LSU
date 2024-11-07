USE [edcuat];
GO

/****** Object:  View [dbo].[13_EDA_ReqDocuments]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[24_EDA_EmailMessages] AS

SELECT 
	NULL												AS ID
	,AutomationType
	,BccAddress
	,CcAddress
	,E.CreatedDate
	,Ext_Classic_Activity_ID__c
	,Ext_Classic_ID__c
	,Ext_Classic_ParentId__c
	,FirstOpenedDate
	--,ValidatedFromAddress
	,FromAddress+'.invalid'				as FromAddress
	,FromName
	,HasAttachment
	,Headers
	,HtmlBody
	,E.Id							as EDAEMAILMSGID__c
	,IsExternallyVisible
	,Incoming
	,MessageDate
	,E.ParentId
	,RelatedToId				as Source_RelatedtoId
	,CASE WHEN C.AccountId	IS NOT NULL THEN C.AccountId
		  WHEN C.AccountId IS NULL AND O.id IS NOT NULL THEN O.Id
		  WHEN C.Id IS NULL AND O.Id IS NULL AND Ci.Id IS NOT NULL THEN Ci.Id
		  WHEN C.Id IS NULL AND O.Id IS NULL AND Ci.Id IS NULL AND CA.Id IS NOT NULL THEN CA.Id
		END as RelatedToId
	,E.[Status]  AS Source_Status
	,5 as [Status]
	,E.Subject
	,TextBody
	,ToAddress+'.invalid'				as ToAddress
	,CR.ID										AS createdbyid
FROM [edaprod].[dbo].[EmailMessage] E
LEFT JOIN
[edaprod].[dbo].[Account] A
ON E.RelatedtoId = A.Id
LEFT JOIN [edcuat].[dbo].[Contact] C
ON A.hed__Primary_Contact__c = C.Legacy_Id__c
LEFT JOIN [edcuat].[dbo].[User] cr
ON E.CreatedById = cr.EDAUSERID__c
LEFT JOIN [edcuat].[dbo].[Opportunity] O
ON E.RelatedtoId = O.Legacy_ID__c
LEFT JOIN [edcuat].[dbo].[Case] Ci
ON 'I-'+E.RelatedtoId = Ci.Legacy_ID__c
LEFT JOIN [edcuat].[dbo].[Case] CA
ON E.RelatedtoId = CA.Legacy_ID__c
--WHERE E.RelatedtoId IS NULL