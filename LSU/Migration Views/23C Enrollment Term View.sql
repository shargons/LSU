USE [EDUCPROD];
GO

/****** Object:  View [dbo].[23C_Enr_AcademicTerm]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[23C_Enr_AcademicTerm] AS

SELECT DISTINCT
	NULL						AS ID
	,campus__c
	,Term_Code__c
	,Online_Term__c				AS Name
	,A.Campus__c				AS Source_Account_ID
	,AC.Id						AS Account__c
	,Type						AS Type__c
	,A.Online_Term__c			AS EDATERMID__c
	,CR.ID AS createdbyid
	,O.ID AS ownerid
FROM [edaprod].[dbo].[enrollment__c] A
LEFT JOIN [EDUCPROD].[dbo].[User] cr
ON A.CreatedById = cr.EDAUSERID__c
LEFT JOIN [EDUCPROD].[dbo].[User] O
ON A.OwnerId = O.EDAUSERID__c
LEFT JOIN [EDUCPROD].dbo.Account AC
ON A.Campus__c = AC.Name
AND AC.CreatedById = '005D1000004gVpBIAU'
WHERE A.Online_Term__c IS NOT NULL