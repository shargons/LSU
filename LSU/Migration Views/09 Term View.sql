USE [edcuat];
GO

/****** Object:  View [dbo].[02_EDA_OrgAccount]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[09_EDA_Term] AS

SELECT 
	NULL						AS ID
	,campus__c
	,campus_term_code__c
	,Name
	,createddate                AS EDACREATEDDATE__c
	,hed__account__c            AS Source_Account_ID
	,NULL						AS Account__c
	,hed__parent_term__c        AS Source_Parent_Term
	,NULL						AS Parent_Term__c
	,hed__type__c				AS Type__c
	,id							AS EDATERMID__c
	,one_destiny_one_flag__c
	,one_term_code__c
	,one_term_id__c
	,order__c
	,sis_end_date__c
	,sis_start_date__c
	,status__c
	,termid__c as Term_Id__c
	,termno__c as Term_No__c
	,hed__start_date__c as startdate
	,hed__end_date__c as EndDate
	,applicationdeadline__c
	,Current_Term__c
	,upcoming_term__c
	,priorterm__c 
	,cohortno__c
	,census_date__c
	--,CR.ID AS createdbyid
	--,O.ID AS ownerid
FROM [edaprod].[dbo].[hed__term__c]	A
--LEFT JOIN [edcdatadev].[dbo].[User_Lookup] cr
--ON A.CreatedById = cr.Legacy_ID__c
--LEFT JOIN [edcdatadev].[dbo].[User_Lookup] O
--ON A.OwnerId = O.Legacy_ID__c