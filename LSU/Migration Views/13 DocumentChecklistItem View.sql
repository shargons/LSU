USE [edcdatadev];
GO

/****** Object:  View [dbo].[02_EDA_OrgAccount]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--CREATE OR ALTER VIEW [dbo].[13_EDA_ReqDocuments] AS

SELECT 
	 NULL						AS ID
	,applicationid__c
	,campus__c
	,classic_contact_id__c 
	,classic_created_date__c
	,complete__c
	,contact__c
	--,CR.ID AS createdbyid
	,contact_office__c
	,created_date_time__c
	,createddate
	,document_code__c
	,document_name__c
	,dropped_from_the_file__c
	,ext_classic_id__c
	,ext_key__c
	,id
	,lsuid__c
	,name
	,no_longer_required__c
	,official__c
	--,O.ID AS ownerid
	,received_date__c
	,review_date__c
	,review_status_code__c
	,review_status_desc__c
FROM [edaprod].[dbo].[required_document__c] R
--LEFT JOIN [edcdatadev].[dbo].[User_Lookup] cr
--ON A.CreatedById = cr.Legacy_ID__c
--LEFT JOIN [edcdatadev].[dbo].[User_Lookup] O
--ON A.OwnerId = O.Legacy_ID__c