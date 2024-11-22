USE [edcuat];
GO

/****** Object:  View [dbo].[02_EDA_OrgAccount]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[04_EDA_AccountProgram] AS





SELECT
		NULL					AS ID
		,accepted__c
		,admitted__c
		,amount__c
		,application__c
		,attempting__c
		,ce_category_sub_type__c
		,ce_category_type__c
		,ce_modality__c
		,cfg_affiliation_last_used__c
		,cfg_enrollment_concierges__c
		,clientemployer__c
		,A.createddate          AS EDACREATEDDATE__c
		,declined__c
		,degree_level__c		AS AcademicLevel
		,denied__c
		,A.description
		,enrolled__c
		,fallout__c
		,geauxforfree__c
		,A.id                   AS EDAACCOUNTID__c
		,inactive__c
		,A.name
		,notscheduled__c
		,parentid				AS Source_ParentID
		,program_grouping__c
		,program_id__c
		,prospect__c
		,registered__c
		,scheduled__c
		--,CR.ID AS createdbyid
		--,O.ID AS ownerid
		FROM [edaprod].[dbo].[Account] A
LEFT JOIN [edaprod].[dbo].[Recordtype] R_EDA
ON A.RecordtypeId = R_EDA.ID
LEFT JOIN [edcuat].[dbo].[User] CR
ON A.CreatedById = CR.EDAUSERID__c
LEFT JOIN [edcuat].[dbo].[User] O
ON A.OwnerId = O.EDAUSERID__c
WHERE R_EDA.DeveloperName IN ('Academic_Program')