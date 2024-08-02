USE [edcuat];
GO

/****** Object:  View [dbo].[17_EDA_ProgramPlan]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER VIEW [dbo].[20A_EDA_Achievement_ProgramPlan] AS

SELECT 
	 NULL												AS ID
	,R.createddate										
	,R.id												AS ExternalKey__c
	,R.name						
	--,O.ID												AS ownerid
FROM [edaprod].[dbo].[hed__program_plan__c] R
--LEFT JOIN [edcuat].[dbo].[User_Lookup] cr
--ON R.CreatedById = cr.Legacy_ID__c
--LEFT JOIN [edcuat].[dbo].[User_Lookup] O
--ON R.OwnerId = O.Legacy_ID__c
