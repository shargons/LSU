USE [edcuat];
GO

/****** Object:  View [dbo].[23B_Enr_Course]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[23B_Enr_Course] AS

SELECT DISTINCT
	  NULL												AS ID
	 ,R.createddate										AS EDACREATEDDATE__c
	 --,cr.id												AS CreatedById
	 ,AF.hed__Account__c								AS Source_ProviderId
	 ,A.Id											    AS ProviderId
	 ,L.Id												AS LearningId
	 ,R.id												AS EDACOURSEID__c
	 ,R.Offering_Code__c								AS Name
	 --,O.Id											    AS OwnerId
FROM [edaprod].[dbo].[enrollment__c] R
LEFT JOIN [edaprod].[dbo].[hed__Affiliation__c] AF
ON R.LSU_Affiliation__c = AF.Id
--LEFT JOIN [edcuat].[dbo].[User_Lookup] cr
--ON R.CreatedById = cr.Legacy_ID__c
--LEFT JOIN [edcuat].[dbo].[User_Lookup] O
--ON R.OwnerId = O.Legacy_ID__c
LEFT JOIN [edcuat].[dbo].[LearningProgram] A
	ON A.EDAACCOUNTID__c = AF.hed__Account__c
LEFT JOIN [edcuat].[dbo].[Learning] L
	ON L.EDAACCOUNTID__c = R.Id
WHERE R.Offering_Code__c IS NOT NULL