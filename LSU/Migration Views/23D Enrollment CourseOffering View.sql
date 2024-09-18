USE [edcuat];
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
	--,O.ID												AS ownerid
FROM  [edaprod].[dbo].[enrollment__c] C
LEFT JOIN [edcuat].[dbo].[LearningCourse] LC
	ON C.Id = LC.EDACOURSEID__c
LEFT JOIN [edcuat].[dbo].[AcademicTerm] T
	ON C.Term__c = T.EDATERMID__c
--LEFT JOIN [edcuat].[dbo].[User_Lookup] cr
--ON R.CreatedById = cr.Legacy_ID__c
--LEFT JOIN [edcuat].[dbo].[User_Lookup] O
--ON R.OwnerId = O.Legacy_ID__c
WHERE Offering_Code__c IS NOT NULL
