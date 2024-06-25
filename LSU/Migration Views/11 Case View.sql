USE [edcdatadev];
GO

/****** Object:  View [dbo].[02_EDA_OrgAccount]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[11_EDA_Cases] AS

SELECT 
	NULL						AS ID
	,A.academic_interest__c		AS Source_academic_interest__c
	,NULL						AS academic_interest__c
	,A.accountid					AS Source_accountid
	,C.AccountId				AS AccountId
	,A.are_you_a_current_student__c
	,A.area_of_interest__c
	,A.contactid					AS Source_contactid
	,C.ID						AS ContactId
	--,CR.ID AS createdbyid
	,A.createddate
	,A.description
	,A.id							AS EDACASEID__c
	,A.origin
	--,O.ID AS ownerid
	,A.phone__c
	,A.primary_affiliation__c    AS primary__c
	,A.priority
	,A.status
	,A.student_type__c
	,A.student_type__c+'-'+A.area_of_interest__c AS Subject
	,CASE WHEN CO.Campus_Formula__c = 'LSU Online' THEN R2.Id
		  ELSE R3.Id
	 END						AS RecordTypeId
FROM [edaprod].[dbo].[Case]	A
--LEFT JOIN [edcdatadev].[dbo].[User_Lookup] cr
--ON A.CreatedById = cr.Legacy_ID__c
--LEFT JOIN [edcdatadev].[dbo].[User_Lookup] O
--ON A.OwnerId = O.Legacy_ID__c
LEFT JOIN [edcdatadev].[dbo].[Contact] C
ON A.contactid = C.Legacy_ID__c
LEFT JOIN [edcdatadev].[dbo].[Recordtype] R2
ON R2.DeveloperName = 'RFI_OE'
LEFT JOIN [edcdatadev].[dbo].[Recordtype] R3
ON R3.DeveloperName = 'RFI_CE'
LEFT JOIN [edaprod].[dbo].[Contact] CO
ON CO.Id = A.ContactId



