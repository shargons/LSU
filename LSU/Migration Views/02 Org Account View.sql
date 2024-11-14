USE [edcuat];
GO

/****** Object:  View [dbo].[02_EDA_OrgAccount]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[02_EDA_OrgAccount] AS





SELECT
		 null						as id
		--,CR.ID AS createdbyid
		,A.createddate				AS EDACreatedDate__c
		,A.id						as Legacy_Id__c
        ,A.name
		,O.ID AS ownerid
		,A.parentid					as Source_ParentID
		,NULL AS parentID
		,CASE WHEN R_EDA.DeveloperName = 'LSU_College' THEN R2.Id
			  WHEN R_EDA.DeveloperName = 'Campus' THEN R3.Id
			  WHEN R_EDA.DeveloperName = 'Educational_Institution' THEN R4.Id
			  WHEN R_EDA.DeveloperName = 'University_Department' THEN R5.Id
	     ELSE R1.id 
		 END						as RecordtypeId
FROM [edaprod].[dbo].[Account] A
LEFT JOIN [edcuat].[dbo].[Recordtype] R1
ON R1.DeveloperName = 'Business_Account'
LEFT JOIN [edcuat].[dbo].[Recordtype] R2
ON R2.DeveloperName = 'College'
LEFT JOIN [edcuat].[dbo].[Recordtype] R3
ON R3.DeveloperName = 'Campus'
LEFT JOIN [edcuat].[dbo].[Recordtype] R4
ON R4.DeveloperName = 'Educational_Institution'
LEFT JOIN [edcuat].[dbo].[Recordtype] R5
ON R5.DeveloperName = 'Online_Department'
LEFT JOIN [edaprod].[dbo].[Recordtype] R_EDA
ON A.RecordtypeId = R_EDA.ID
LEFT JOIN [edcuat].[dbo].[User_Lookup] CR
ON A.CreatedById = CR.Legacy_ID__c
LEFT JOIN [edcuat].[dbo].[User_Lookup] O
ON A.OwnerId = O.Legacy_ID__c
WHERE R_EDA.DeveloperName IN ('Campus','LSU_College','Educational_Institution','University_Department')