USE [EDUCPROD];
GO

/****** Object:  View [dbo].[31_EDA_ContentNotes]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[32_EDA_Tasks] AS

SELECT * FROM
(
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
      ,T.[CreatedDate]					AS EDACreatedDate__c
      ,T.[Description]					AS 	Description__c
	  ,[Five9__Five9Agent__c]			AS Five9Agent__c
      ,[Five9__Five9AgentExtension__c]	AS Five9AgentExtension__c
      ,[Five9__Five9AgentName__c]		AS Five9AgentName__c
      ,[Five9__Five9ANI__c]				AS Five9ANI__c
      ,[Five9__Five9CallType__c]		AS Five9CallType__c
      ,[Five9__Five9Campaign__c]		AS Five9Campaign__c
      ,[Five9__Five9DNIS__c]			AS Five9DNIS__c
      ,[Five9__Five9HandleTime__c]		AS Five9HandleTime__c
      ,[Five9__Five9SessionId__c]
      ,[Five9__Five9TalkAndHoldTimeInSeconds__c] AS Five9TalkAndHoldTimeInSeconds__c
      ,[Five9__Five9TaskType__c]
      ,[Five9__Five9WrapTime__c]		AS Five9WrapTime__c
      ,T.[Id]								AS Legacy_Id__c
      ,[IsArchived]
      ,T.[IsClosed]
      ,T.[IsDeleted]
      ,[IsHighPriority]
      ,[IsRecurrence]
      ,[IsReminderSet]
      ,[IsVisibleInSelfService]
      ,O.Id								AS [OwnerId]
      ,[OwnerRole__c]
      ,T.[Power_of_One__c]
      ,T.[Priority]
	  ,T.[Status]
      ,T.[Type]
      ,[WhoId]								AS Source_WhoId
	  ,IIF(C.Id	IS NULL,L.Id,C.Id)								AS WhoId
	  ,T.WhatId				AS Source_WhatId
	 -- ,IIF(Op.ID IS NOT NULL,Op.ID,
		--IIF(A.ID IS NOT NULL,A.ID,
		--	IIF(CO.ID IS NOT NULL,CO.ID,
		--		IIF(Ca.Id IS NOT NULL,Ca.ID,
		--			IIF(I.Id IS NOT NULL,I.Id,
		--				IIF(E.Id IS NOT NULL,E.Id,
		--					IIF(LP.ID IS NOT NULL,LP.ID,C.AccountID)))))))					
	  ,NULL AS WhatID
	  ,T.Subject
	  ,T.TaskSubtype
	  ,T.CreatedDate
  FROM [edaprod].[dbo].[Task] T
  LEFT JOIN
  [EDUCPROD].[dbo].[Contact] C
  ON T.WhoId = C.Legacy_Id__c
  LEFT JOIN
  [EDUCPROD].[dbo].[Lead] L
  ON T.WhoId = L.Legacy_Id__c
  LEFT JOIN [EDUCPROD].[dbo].[User] cr
  ON T.CreatedById = cr.EDAUSERID__c
  LEFT JOIN [EDUCPROD].[dbo].[User] O
  ON T.OwnerId = O.EDAUSERID__c
  --LEFT JOIN [EDUCPROD].[dbo].[Opportunity] Op
  --ON T.WhatId = Op.Legacy_ID__c
  --LEFT JOIN [EDUCPROD].[dbo].[Account] A
  --ON T.WhatId = A.Legacy_ID__c
  --LEFT JOIN [EDUCPROD].[dbo].[Contact] CO
  --ON T.WhatId = CO.Legacy_ID__c
  --LEFT JOIN [EDUCPROD].[dbo].[Case] Ca
  --ON T.WhatId = Ca.Legacy_ID__c
  --LEFT JOIN [EDUCPROD].[dbo].[Case] I
  --ON 'I-'+T.WhatId = Ca.Legacy_ID__c
  --LEFT JOIN [EDUCPROD].[dbo].[EmailMessage] E
  ----ON T.WhatId = E.EDAEMAILMSGID__c
  --LEFT JOIN [EDUCPROD].[dbo].[LearningProgram] LP
  --ON T.WhatId = LP.EDAACCOUNTID__c
  --WHERE T.WhatId IS NOT NULL
  )X

