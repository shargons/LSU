USE [edcdatadev];
GO

/****** Object:  View [dbo].[13_EDA_ReqDocuments]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[20B_EDA_Plan_Requirements] AS

SELECT 
	 NULL												AS ID
	--,CR.ID											AS createdbyid
	,R.createddate
	,hed__course__c										AS Source_Learning_Course
	,C.Id												AS Learning_Course__c
	,hed__credits__c									AS Duration
	,hed__program_plan__c								AS Source_LearningProgramPlanId
	,P.Id												AS LearningProgramPlanId
	,R.id												AS Legacy_Id__c
	,R.name
	--,O.ID												AS ownerid
	,LL.ID												AS LearningAchievementId
	,'Credit Hours'										AS DurationUnit
	,R.systemmodstamp
FROM [edaprod].[dbo].[hed__plan_requirement__c] R
--LEFT JOIN [edcdatadev].[dbo].[User_Lookup] cr
--ON R.CreatedById = cr.Legacy_ID__c
--LEFT JOIN [edcdatadev].[dbo].[User_Lookup] O
--ON R.OwnerId = O.Legacy_ID__c
LEFT JOIN [edcdatadev].[dbo].[LearningProgramPlan] P
	ON R.hed__program_plan__c = P.Legacy_ID__c
LEFT JOIN [edcdatadev].[dbo].[LearningCourse] C
	ON R.hed__course__c = C.EDACOURSEID__c
LEFT JOIN [edcdatadev].[dbo].[LearningAchievement_Lookup] LL
ON LL.Legacy_Id__c = P.Legacy_ID__c