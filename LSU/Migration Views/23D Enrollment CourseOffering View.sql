USE [EDUCPROD];
GO

/****** Object:  View [dbo].[23C_Enr_CourseOffering]    Script Date: 4/9/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[23D_Enr_CourseOffering] AS

SELECT DISTINCT
	 NULL									AS ID
	,C.createddate							AS EDACREATEDDATE__c			
	,LC.Id									AS LearningCourseId
	,C.Id									AS Source_CourseId
	,End_Date__c							AS ActiveToDate
	,SectionID__c							AS SectionNumber
	,Start_Date__c							AS ActiveFromDate
	,C.Online_Term__c						AS Source_Term
	,T.Id									AS Academic_Term__c
	,C.id									AS EDACROFRNGID__c
	,C.Offering_Code__c						AS Name										
	,O.ID									AS ownerid
	,CR.ID									AS CreatedById
	,C.Term__c
	,TC.Campus_Term_Code_incoming_file_term_formats
FROM  [edaprod].[dbo].[enrollment__c] C
LEFT JOIN [EDUCPROD].[dbo].[LearningCourse] LC
	ON C.Id = LC.EDACOURSEID__c
LEFT JOIN [edaprod].[dbo].[SF_EDA_All_Campus_Term_Codes] TC 
ON C.Term__c = TC.Campus_Term_Code_incoming_file_term_formats
LEFT JOIN [EDUCPROD].[dbo].[AcademicTerm] T
	ON TC.Stand_Term_Code = T.Term_Id__c
LEFT JOIN [EDUCPROD].[dbo].[User] cr
ON C.CreatedById = cr.EDAUSERID__c
LEFT JOIN [EDUCPROD].[dbo].[User] O
ON C.OwnerId = O.EDAUSERID__c
WHERE C.Online_Term__c IS NOT NULL
--and C.Id = 'a2f3n000000eJ7yAAE'
