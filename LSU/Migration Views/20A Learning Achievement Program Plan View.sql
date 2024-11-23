USE [EDUCPROD];
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
	,O.ID												AS ownerid
	,r.CreatedById										AS CreatedById
FROM [edaprod].[dbo].[hed__program_plan__c] R
LEFT JOIN EDUCPROD.dbo.[User] cr
ON R.CreatedById = cr.EDAUSERID__c
LEFT JOIN [EDUCPROD].[dbo].[User] O
ON R.OwnerId = o.EDAUSERID__c
