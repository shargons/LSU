USE [EDUCPROD];
GO

/****** Object:  View [dbo].[31_EDA_ContentNotes]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[33_EDA_EmailMessageRelation] AS

SELECT 
	   NULL					AS Id
	  ,CR.ID				AS [CreatedById]		
      ,E.[CreatedDate]
      ,[EmailMessageId]	   AS Source_EmailMessageId
	  ,EM.Id			   AS EmailMessageId
      ,E.[Id]				AS Legacy_Id__c
      ,[RelationAddress]	 
	  ,E.[RelationId]		AS [Source_RelationId]
      --,IIF(E.[RelationObjectType] = 'User',U.Id,IIF(C.Id IS NULL,L.Id,C.AccountId))	AS [RelationId]
	  ,IIF(E.[RelationObjectType] = 'User',U.Id,C.Id)	AS [RelationId]
      ,[RelationObjectType]
      ,[RelationType]
FROM [edaprod].[dbo].[EmailMessageRelation] E
   LEFT JOIN [EDUCPROD].[dbo].[User] cr
	ON E.CreatedById = cr.EDAUSERID__c
	LEFT JOIN [EDUCPROD].[dbo].[EmailMessage] EM
	ON E.[EmailMessageId] = EM.EDAEMAILMSGID__c
	LEFT JOIN [EDUCPROD].[dbo].[User] U
	ON E.[RelationId] = U.EDAUSERID__c
	LEFT JOIN  [EDUCPROD].[dbo].[Contact] C
	ON E.[RelationId] = C.Legacy_Id__c
	LEFT JOIN  [EDUCPROD].[dbo].[Lead] L
	ON E.[RelationId] = L.Legacy_Id__c
	WHERE [RelationObjectType] IN ('User','Contact')