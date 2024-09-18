USE [edcuat];
GO

/****** Object:  View [dbo].[21_EDA_CourseOffering]    Script Date: 4/9/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[21_EDA_CourseOffering] AS

SELECT 
	 NULL									AS ID
	,C.createddate							AS EDACREATEDDATE__c			
	,duedatetypecode__c						AS due_date_type_code__c
	,duedaysafterenroll__c					AS duedays_after_enroll__c
	,fixedduedate__c						AS fixed_due_date__c
	,hed__capacity__c						AS capacity__c
	,LC.Id									AS LearningCourseId
	,hed__course__c							AS Source_CourseId
	,hed__end_date__c						AS ActiveToDate__c
	,hed__section_id__c						AS SectionNumber
	,hed__start_date__c						AS ActiveFromDate__c
	,hed__term__c							AS Source_Term
	,T.Id									AS Academic_Term__c
	,C.id									AS EDACROFRNGID__c
	,instructionmethod__c					AS instruction_method__c
	,instructorsid__c						AS Instructors_ID__c
	,C.name									
	,one_class_number__c					
	,C.one_destiny_one_flag__c				
	,one_destiny_one_id__c					
	,one_destiny_one_section_status__c		
	,sectionenddatews__c					AS EndDate
	,sectionstartdatews__c					AS StartDate		
	--,O.ID												AS ownerid
FROM  [edaprod].[dbo].[hed__course_offering__c] C
LEFT JOIN [edcuat].[dbo].[LearningCourse] LC
	ON C.hed__course__c = LC.EDACOURSEID__c
LEFT JOIN [edcuat].[dbo].[AcademicTerm] T
	ON C.hed__term__c = T.EDATERMID__c
--LEFT JOIN [edcuat].[dbo].[User_Lookup] cr
--ON R.CreatedById = cr.Legacy_ID__c
--LEFT JOIN [edcuat].[dbo].[User_Lookup] O
--ON R.OwnerId = O.Legacy_ID__c
