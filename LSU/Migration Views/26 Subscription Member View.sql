USE [EDUCPROD];
GO

/****** Object:  View [dbo].[26_EDA_SubscriptionMembers]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[26_EDA_SubscriptionMembers] AS

SELECT
NULL								AS ID
,cfg_active__c
,cfg_contact__c						AS Source_Contact
,C.Id								AS cfg_contact__c
,cfg_opt_out_date__c
,cfg_subscription__c				AS Source_Subscription
,S.Id								AS cfg_subscription__c
,R.createddate
,R.id								AS Legacy_Id__c
,R.name
,O.ID											AS ownerid
,CR.ID										AS createdbyid
FROM [edaprod].[dbo].[cfg_Subscription_Member__c] R
LEFT JOIN [EDUCPROD].[dbo].[User] cr
ON R.CreatedById = cr.EDAUSERID__c
LEFT JOIN [EDUCPROD].[dbo].[User] O
ON R.OwnerId = O.EDAUSERID__c
LEFT JOIN [EDUCPROD].[dbo].[Contact] C
ON C.Legacy_Id__c = R.cfg_contact__c
LEFT JOIN [EDUCPROD].[dbo].[cfg_subscription__c] S
ON S.Legacy_Id__c = R.cfg_subscription__c