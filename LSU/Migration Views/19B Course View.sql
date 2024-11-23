USE [EDUCPROD];
GO

/****** Object:  View [dbo].[13_EDA_ReqDocuments]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[19B_EDA_Course] AS

SELECT 
	  NULL												AS ID
	 ,R.createddate										AS EDACREATEDDATE__c
	 ,R.createddate	
	 ,cr.id												AS CreatedById
	 ,hed__account__c									AS Source_ProviderId
	 ,B.Id											    AS ProviderId
	 ,L.Id												AS LearningId
	 ,hed__course_id__c									AS Course_id__c
	 ,hed__credit_hours__c								AS Credit_hours__c
	 ,hed__extended_description__c						AS Description
	 ,R.id												AS EDACOURSEID__c
	 ,maxceunit__c
	 ,minceunit__c
	 ,R.name
	 ,one_course_id__c
	 ,one_course_number__c
	 ,one_destiny_one_flag__c
	 ,one_destiny_one_status__c
	 ,R.systemmodstamp
	 ,termbasedcourse__c							    AS term_based_course__c 
	 --,O.Id											    AS OwnerId
	 ,Modality__c
FROM [edaprod].[dbo].[hed__course__c] R
LEFT JOIN [EDUCPROD].[dbo].[User_Lookup] cr
ON R.CreatedById = cr.Legacy_ID__c
--LEFT JOIN [EDUCPROD].[dbo].[User_Lookup] O
--ON R.OwnerId = O.Legacy_ID__c
LEFT JOIN [EDUCPROD].dbo.Account B
ON R.hed__account__c = B.Legacy_Id__c
LEFT JOIN [EDUCPROD].[dbo].[Learning] L
	ON L.EDAACCOUNTID__c = R.Id