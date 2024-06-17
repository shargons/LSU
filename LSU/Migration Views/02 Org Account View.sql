USE [edcdatadev];
GO

/****** Object:  View [dbo].[02_EDA_OrgAccount]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[02_EDA_OrgAccount] AS





SELECT
		 null as id
		--,CR.ID AS createdbyid
		,A.createddate
		,A.id as Legacy_Id__c
        ,A.name
		--,O.ID AS ownerid
		,A.parentid as Source_ParentID
		,NULL AS parentID
		,r.id as RecordtypeId
FROM [edaprod].[dbo].[Account] A
LEFT JOIN [edcuat].[dbo].[Recordtype] R
ON R.DeveloperName = 'Business_Account'
LEFT JOIN [edaprod].[dbo].[Recordtype] R_EDA
ON A.RecordtypeId = R_EDA.ID
--LEFT JOIN [edcdatadev].[dbo].[User_Lookup] CR
--ON A.CreatedById = CR.Legacy_ID__c
--LEFT JOIN [edcdatadev].[dbo].[User_Lookup] O
--ON A.OwnerId = O.Legacy_ID__c
WHERE R_EDA.DeveloperName IN ('Campus','LSU_College','Educational_Institution','University_Department')