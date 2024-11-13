USE [edcuat];
GO

/****** Object:  View [dbo].[31_EDA_ContentNotes]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[31_EDA_ContentNotes] AS



SELECT DISTINCT
	   NULL							AS ID
      --,CR.ID						AS [CreatedById]
      ,C.[CreatedDate]				AS EDACREATEDDATE__c
	  ,C.CreatedDate
      ,C.ID+'-'+DL.LinkedEntityId							AS Legacy_ID__c
      --,O.ID						AS [OwnerId]
      ,C.[TextPreview]				AS MeetingNotes
      ,C.[Title]					AS Subject__c
	  ,C.[Title]					AS Name
	  ,IIF(CO.Id IS NULL,IIF(O.Id IS NULL,CA.Id,O.Id),CO.Id)						AS RelatedRecordID
	  ,CO.AccountId					AS AccountID
	  ,DL.LinkedEntityId
	  ,'Published'					AS Status
  FROM 
  [edaprod].[dbo].[ContentVersion] C
  LEFT JOIN 
  [edaprod].[dbo].[ContentDocumentLink] DL
  ON C.ContentDocumentId = DL.ContentDocumentId
  LEFT JOIN
  [edcuat].[dbo].[Contact] CO
  ON DL.LinkedEntityId = CO.Legacy_Id__c
  LEFT JOIN
  [edcuat].[dbo].[Opportunity] O
  ON DL.LinkedEntityId = O.Legacy_Id__c
  LEFT JOIN
  [edcuat].[dbo].[Case] Ca
  ON DL.LinkedEntityId = Ca.Legacy_Id__c
  --LEFT JOIN [edcuat].[dbo].[User_Lookup] cr
	--ON C.CreatedById = cr.Legacy_ID__c
	--LEFT JOIN [edcuat].[dbo].[User_Lookup] O
--ON C.OwnerId = O.Legacy_ID__c
  WHERE 
  FileType = 'Snote'
  AND 
  DL.LinkedEntityId NOT LIKE '0053%'
  AND (CO.Id is not null OR CA.Id is not null OR O.Id is not null)
  AND C.IsLatest = 1

  --select * from ContentVersion where FileType = 'Snote'


