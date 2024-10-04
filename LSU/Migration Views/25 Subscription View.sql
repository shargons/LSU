USE [edcuat];
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
,createddate
,description__c							AS cfg_description__c
,id										AS Legacy_ID__c
,name
	--,O.ID											AS ownerid
	--,CR.ID										AS createdbyid
FROM [edaprod].[dbo].[cfg_subscription__c] R
--LEFT JOIN [edcuat].[dbo].[User_Lookup] cr
--ON R.CreatedById = cr.Legacy_ID__c
--LEFT JOIN [edcuat].[dbo].[User_Lookup] O
--ON R.OwnerId = O.Legacy_ID__c