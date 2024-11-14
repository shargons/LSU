USE [edcuat];
GO

/****** Object:  View [dbo].[13_EDA_ReqDocuments]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[15_EDA_ReqDocuments] AS

SELECT 
	 NULL						AS ID
	,applicationid__c			
	,C.ID						AS ParentRecordId
	,R.campus__c
	,classic_contact_id__c 
	,R.classic_created_date__c	AS EDACREATEDDATE__c
	,CASE WHEN complete__c	= 1 THEN 'Accepted'
			ELSE 'New' 
	 END							AS Status
	,contact__c						AS Source_Contact__c
	,C.ID							AS WhoId
	,C.AccountId
	,CR.ID AS createdbyid
	,contact_office__c
	,created_date_time__c			 
	,R.createddate					
	,document_code__c
	,document_name__c
	,dropped_from_the_file__c
	,ext_classic_id__c
	,ext_key__c
	,R.id						AS EDAREQDOCID__c
	,lsuid__c
	,R.name
	,no_longer_required__c
	,official__c
	,O.ID AS ownerid
	,received_date__c
	,review_date__c
	,review_status_code__c
	,review_status_desc__c
FROM [edaprod].[dbo].[required_document__c] R
LEFT JOIN [edcuat].[dbo].[User_Lookup] cr
ON R.CreatedById = cr.Legacy_ID__c
LEFT JOIN [edcuat].[dbo].[User_Lookup] O
ON R.OwnerId = O.Legacy_ID__c
LEFT JOIN [edcuat].[dbo].[Contact] C
ON R.contact__c = C.Legacy_ID__c
