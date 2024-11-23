USE [EDUCPROD];
GO

/****** Object:  View [dbo].[02_EDA_OrgAccount]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[04A_EDA_ProgramParents] AS





SELECT DISTINCT
		NULL					AS ID
		,P.Accepted__c
		,P.admitted__c
		,P.amount__c
		,P.application__c
		,P.attempting__c
		,P.ce_category_sub_type__c
		,P.ce_category_type__c
		,P.ce_modality__c
		,P.cfg_affiliation_last_used__c
		,P.cfg_enrollment_concierges__c
		,P.clientemployer__c
		,P.createddate          AS EDACREATEDDATE__c
		,P.declined__c
		,CASE WHEN P.degree_level__c = 'TPP' THEN 'TPP Course'
		 ELSE P.degree_level__c
		 END AS degree_level__c
		,P.denied__c
		,P.description
		,P.enrolled__c
		,P.fallout__c
		,P.geauxforfree__c
		,P.id                   AS Legacy_Id__c
		,P.inactive__c
		,P.name
		,P.notscheduled__c
		,P.parentid				AS Source_ParentID
		,P.program_grouping__c
		,P.program_id__c
		,P.prospect__c
		,P.registered__c
		,P.scheduled__c
		,RP.ID AS RecordTypeId
		,CR.ID AS createdbyid
		,O.ID AS ownerid
		FROM [edaprod].[dbo].[Account] A
INNER JOIN [edaprod].[dbo].[Account] P
ON A.ParentId = P.Id
LEFT JOIN [edaprod].[dbo].[Recordtype] R_EDA
ON A.RecordtypeId = R_EDA.ID
LEFT JOIN [EDUCPROD].[dbo].[Recordtype] RP
ON RP.DeveloperName = 'College'
LEFT JOIN [EDUCPROD].[dbo].[User] CR
ON P.CreatedById = CR.EDAUSERID__c
LEFT JOIN [EDUCPROD].[dbo].[User] O
ON P.OwnerId = O.EDAUSERID__c
WHERE R_EDA.DeveloperName IN ('Academic_Program')