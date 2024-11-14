USE [edcuat];
GO

/****** Object:  View [dbo].[02_EDA_OrgAccount]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[19A_EDA_Course_Learning] AS

SELECT
		NULL								AS ID
		,A.createddate
		,A.createddate						AS EDACreatedDate__c
		,'Professional Education'			AS AcademicLevel
		,A.hed__extended_description__c		AS Description
		,A.id								AS EDAACCOUNTID__c
		,1									AS IsActive
		,A.name
		--,'Course' as Type
		,A.hed__Account__c					AS Source_ProviderID
		,B.ID								AS ProviderId
FROM  [EDAPROD].[dbo].[hed__course__c] A
LEFT JOIN [edcuat].dbo.Account B
ON A.hed__Account__c = B.Legacy_Id__c