USE [edcuat];
GO

/****** Object:  View [dbo].[12_EDA_Interactions]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[27_EDA_Case] AS


SELECT
NULL									AS ID
,C.academic_interest__c					AS Source_Academic_Interest
,LP.Id									AS academic_interest__c
,C.accountid							AS Source_Account
,are_you_a_current_student__c
,area_of_interest__c
,contactid								AS Source_Contact
,Co.Id									AS ContactId
,Co.AccountId							AS AccountId
,C.createddate
,C.description
,C.id									AS Legacy_Id__c
,origin
,phone__c
,primary_affiliation__c
,priority
,status
,student_type__c
,ISNULL(area_of_interest__c,'')+'-'+ISNULL(student_type__c,'')+'-'+ISNULL(Co.Name,'')	AS subject
--,O.ID											AS ownerid
--,CR.ID										AS createdbyid
,CASE WHEN A.Campus__c = 'CE' THEN R3.Id
		  ELSE R2.Id
	 END										AS RecordtypeId
,Co.FirstName							AS First_Name__c
,Co.LastName								AS Last_Name__c
,Co.Email								AS Email__c
FROM [edaprod].[dbo].[Case] C
LEFT JOIN
[edcuat].[dbo].[LearningProgram] LP
ON LP.EDAACCOUNTID__c = C.Academic_Interest__c
--LEFT JOIN [edcuat].[dbo].[User_Lookup] cr
--ON C.CreatedById = cr.Legacy_ID__c
--LEFT JOIN [edcuat].[dbo].[User_Lookup] O
--ON C.OwnerId = O.Legacy_ID__c
LEFT JOIN [edcuat].[dbo].[Contact] Co
ON Co.Legacy_Id__c = C.contactid
LEFT JOIN [edaprod].[dbo].[Account] A
ON C.Academic_Interest__c = A.Id
LEFT JOIN [edcuat].[dbo].[Recordtype] R2
ON R2.DeveloperName = 'RFI_OE'
LEFT JOIN [edcuat].[dbo].[Recordtype] R3
ON R3.DeveloperName = 'RFI_CE'