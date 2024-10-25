USE [edcuat];
GO

/****** Object:  View [dbo].[02_EDA_OrgAccount]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[03_EDA_Learning] AS





SELECT
		NULL					AS ID
		,A.createddate    
		,A.Degree_Level__c AS AcademicLevel
		,A.Description 
		,A.id                   AS EDAACCOUNTID__c
		,CASE WHEN a.inactive__c = 1 THEN 0 ELSE 1 END AS IsActive
		,A.name
		,a.parentid				AS Source_ParentID
		--,'Course' as Type
		--,CR.ID AS createdbyid
		--,O.ID AS ownerid
		,A.Program_ID__c
		FROM  [EDAPROD].[dbo].[Account] A
	JOIN [EDAPROD].[dbo].Recordtype R ON A.RecordTypeId = R.Id
	--LEFT JOIN [edcuat].[dbo].[User_Lookup] CR
	--ON A.CreatedById = CR.Legacy_ID__c
	--LEFT JOIN [edcuat].[dbo].[User_Lookup] O
	--ON A.OwnerId = O.Legacy_ID__c
	WHERE R.DeveloperName IN ('Academic_Program')