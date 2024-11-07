USE [edcuat];
GO

/****** Object:  View [dbo].[02_EDA_OrgAccount]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[07_EDA_LearningProgramPlan] AS


SELECT
		NULL					AS ID
		,A.name
		,CR.ID AS createdbyid
		,O.ID AS ownerid
		,IIF(Inactive__c = 1,0,1) as IsActive
		,P.ID AS LearningProgramId
		,A.ID AS Legacy_Id__c
		FROM [edaprod].[dbo].[Account] A
LEFT JOIN [edaprod].[dbo].[Recordtype] R_EDA
ON A.RecordtypeId = R_EDA.ID
LEFT JOIN [edcuat].[dbo].[Account_Program_Lookup] P
ON A.ID = P.Legacy_ID__c
LEFT JOIN [edcuat].[dbo].[User_Lookup] cr
ON A.CreatedById = cr.Legacy_ID__c
LEFT JOIN [edcuat].[dbo].[User_Lookup] O
ON A.OwnerId = O.Legacy_ID__c
WHERE R_EDA.DeveloperName IN ('Academic_Program')