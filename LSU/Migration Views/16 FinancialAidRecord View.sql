USE [edcuat];
GO

/****** Object:  View [dbo].[13_EDA_ReqDocuments]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[16_EDA_Financial_Aid_Record] AS

SELECT 
	 NULL						AS ID
	,accepted_date__c
	,awardyear__c				AS award_year__c
	,R.campus__c
	,classic_contact_id__c
	,R.classic_created_date__c	
	,contact__c					AS Source_Contact
	,C.ID						AS Contact__c
	,CR.ID						AS createdbyid
	,R.createddate
	,disbursementterm__c		AS 	Disbursement_Term__c
	,documentdate__c			AS Document_Date__c
	,doepromissarynotedate__c   AS DOE_Promissary_Note_Date__c
	,ext_classic_id__c
	,ext_key__c
	,R.id							AS Legacy_ID__c
	,ineligibilitystatusflag__c AS in_eligibility_status_flag__c
	,ineligibilityterm__c		AS in_eligibility_term__c
	,interview_date__c
	,R.name
	,O.ID						AS ownerid
	,packageddate__c			AS Packaged_Date__c
	,statuscode__c				AS Status_Code__c
	,statusdate__c				AS Status_Date__c
	,statusdesc__c				AS Status_Desc__c
	,studentid__c				AS Student_Id__c
	,term__c					AS Term__c
	,verified__c				AS Verified__c
FROM [edaprod].[dbo].[financial_aid_record__c] R
LEFT JOIN [edcuat].[dbo].[User_Lookup] cr
ON R.CreatedById = cr.Legacy_ID__c
LEFT JOIN [edcuat].[dbo].[User_Lookup] O
ON R.OwnerId = O.Legacy_ID__c
LEFT JOIN [edcuat].[dbo].[Contact] C
ON R.contact__c = C.Legacy_ID__c
