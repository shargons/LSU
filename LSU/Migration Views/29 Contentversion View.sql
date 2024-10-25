USE [edcuat];
GO

/****** Object:  View [dbo].[29_EDA_ContentVersion]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[29_EDA_ContentVersion] AS


SELECT
 C.ID
,C.Id											AS Legacy_Id__c
,C.Title
,'C:\DBAmp\Blob\'+C.ID+'_versiondata.File'	AS PathOnClient
,'C:\DBAmp\Blob\'+C.ID+'_versiondata.File'	AS VersionData
,FirstPublishLocationId						AS Source_FirstPublishLocationId 
,IIF(Co.Id IS NOT NULL,Co.Id,
	IIF(U.Id IS NOT NULL,U.Id,
		IIF(Ca.Id IS NOT NULL,Ca.Id,
			IIF(Op.Id IS NOT NULL,Op.Id,
				IIF(Em.Id IS NOT NULL,Em.Id,
				NULL)))))				AS FirstPublishLocationId
,'P'										AS PublishStatus
,'C'										AS Origin
,'N'										AS SharingPrivacy
,'A'										AS SharingOption
FROM [edaprod].[dbo].[ContentVersion] C
LEFT JOIN
edcuat.dbo.Contact Co
ON C.FirstPublishLocationId = Co.Legacy_ID__c
LEFT JOIN
edcuat.dbo.User_Lookup U
ON C.FirstPublishLocationId = U.Legacy_ID__c
LEFT JOIN
edcuat.dbo.[Case] Ca
ON C.FirstPublishLocationId = Ca.Legacy_ID__c
LEFT JOIN
edcuat.dbo.[Opportunity] Op
ON C.FirstPublishLocationId = Op.Legacy_ID__c
LEFT JOIN
[edcuat].[dbo].[EmailMessage] Em
ON C.FirstPublishLocationId = Em.EDAEMAILMSGID__c
INNER JOIN
[edaprod].[dbo].[ContentVersion_1600001_2556037] B
ON C.Id = B.Id
