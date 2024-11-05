USE [edcuat];
GO

/****** Object:  View [dbo].[23A_Enr_Learning]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[23A_Enr_Learning] AS

SELECT DISTINCT
		NULL								AS ID
		,A.createddate
		,'Professional Education'			AS AcademicLevel
		,A.id								AS EDAACCOUNTID__c
		,1									AS IsActive
		,A.Offering_Code__c					AS Name
		--,'Course' as Type
		,A.Campus__c 						AS Source_ProviderID
		,B.ID								AS ProviderId
		,B.CreatedById
		,B.OwnerId
FROM  [edaprod].[dbo].[enrollment__c] A
LEFT JOIN [edcuat].dbo.Account B
ON A.Campus__c = B.Name
AND B.CreatedById = '005KT000000poMtYAI'
and B.Legacy_Id__c is not null
WHERE A.Offering_Code__c IS NOT NULL

