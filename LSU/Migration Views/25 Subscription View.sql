USE [EDUCPROD];
GO

/****** Object:  View [dbo].[25_EDA_Subscription]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[25_EDA_Subscription] AS

SELECT
NULL								AS ID
,cfg_display_in_subscription_center__c 
,cfg_tab__c
,cfg_type__c
,R.createddate
,description__c							AS cfg_description__c
,R.id										AS Legacy_ID__c
,R.name
	,O.ID											AS ownerid
	,CR.ID										AS createdbyid
,R.CreatedDate									AS EDACREATEDDATE__c
FROM [edaprod].[dbo].[cfg_subscription__c] R
LEFT JOIN [EDUCPROD].[dbo].[User] cr
ON R.CreatedById = cr.EDAUSERID__c
LEFT JOIN [EDUCPROD].[dbo].[User] O
ON R.OwnerId = O.EDAUSERID__c