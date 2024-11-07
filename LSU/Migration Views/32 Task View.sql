USE [edcuat];
GO

/****** Object:  View [dbo].[31_EDA_ContentNotes]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[32_EDA_Tasks] AS


SELECT 
		NULL					AS Id
	  ,T.[AccountId]				AS SourceAccount					
	  ,C.AccountId					AS 	Account__c
      ,[ActivityDate]
      ,[Affiliation__c]
      ,[CallDisposition]
      ,[CallDurationInSeconds]
      ,[CallObject]
      ,[CallType]
      ,[CompletedDateTime]
      ,[Created_Date_Time__c]
      ,CR.Id								AS [CreatedById]
      ,T.[CreatedDate]
      ,T.[Description]					AS 	Description__c
	  ,[Five9__Five9Agent__c]
      ,[Five9__Five9AgentExtension__c]
      ,[Five9__Five9AgentName__c]
      ,[Five9__Five9ANI__c]
      ,[Five9__Five9CallType__c]
      ,[Five9__Five9Campaign__c]
      ,[Five9__Five9DNIS__c]
      ,[Five9__Five9HandleTime__c]
      ,[Five9__Five9SessionId__c]
      ,[Five9__Five9TalkAndHoldTimeInSeconds__c]
      ,[Five9__Five9TaskType__c]
      ,[Five9__Five9WrapTime__c]
      ,T.[Id]								AS Legacy_Id__c
      ,[IsArchived]
      ,[IsClosed]
      ,T.[IsDeleted]
      ,[IsHighPriority]
      ,[IsRecurrence]
      ,[IsReminderSet]
      ,[IsVisibleInSelfService]
      ,O.Id								AS [OwnerId]
      ,[OwnerRole__c]
      ,T.[Power_of_One__c]
      ,[Priority]
      ,T.[Type]
      ,[WhoId]								AS Source_WhoId
	  ,C.Id									AS WhoId
	  ,T.Subject
  FROM [edaprod].[dbo].[Task] T
  LEFT JOIN
  [edcuat].[dbo].[Contact] C
  ON T.WhoId = C.Legacy_Id__c
   LEFT JOIN [edcuat].[dbo].[User] cr
	ON T.CreatedById = cr.EDAUSERID__c
	LEFT JOIN [edcuat].[dbo].[User] O
	ON T.OwnerId = O.EDAUSERID__c


