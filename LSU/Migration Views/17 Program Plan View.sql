USE [edcuat];
GO

/****** Object:  View [dbo].[17_EDA_ProgramPlan]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[17_EDA_ProgramPlan] AS

SELECT 
	 NULL												AS ID
	,R.createddate										AS EDACREATEDDATE__c
	,CR.ID											AS createdbyid
	,hed__account__c									AS Source_ProviderId
	--,A.Id												AS ProviderId
	,A.ID												AS LearningProgramId
	,hed__status__c										AS Status__c
	,hed__total_required_credits__c						AS Total_required_credits__c
	,R.id												AS Legacy_ID__c
	,R.name						
	,O.ID												AS ownerid
	,programlength__c									AS program_length__c
	,totalnoofcourses__c								AS total_no_of_courses__c
	,IsActive
FROM [edaprod].[dbo].[hed__program_plan__c] R
LEFT JOIN [edcdatadev].[dbo].[User_Lookup] cr
ON R.CreatedById = cr.Legacy_ID__c
LEFT JOIN [edcdatadev].[dbo].[User_Lookup] O
ON R.OwnerId = O.Legacy_ID__c
LEFT JOIN [edcuat].[dbo].[LearningProgram] A
ON R.hed__account__c = A.EDAACCOUNTID__c
