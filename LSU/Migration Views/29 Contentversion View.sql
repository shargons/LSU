USE [EDUCPROD];
GO

/****** Object:  View [dbo].[29_EDA_ContentVersion]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[29_EDA_ContentVersion] AS


SELECT
 NULL AS ID
,C.Id											AS Legacy_Id__c
,C.Title
,'C:\DBAmpBlob\Blob\'+C.ID+'_versiondata.File'	AS PathOnClient
,'C:\DBAmpBlob\Blob\'+C.ID+'_versiondata.File'	AS VersionData
,FirstPublishLocationId						AS Source_FirstPublishLocationId 
,IIF(Co.Id IS NOT NULL,Co.Id,
	IIF(I.Id IS NOT NULL,I.Id,
		IIF(Ca.Id IS NOT NULL,Ca.Id,
			IIF(Op.Id IS NOT NULL,Op.Id,
				IIF(Em.Id IS NOT NULL,Em.Id,
					IIF(L.Id IS NOT NULL,L.Id,
						IIF(U.Id IS NOT NULL,U.Id,NULL)))))))				AS FirstPublishLocationId
,'P'										AS PublishStatus
,'C'										AS Origin
,'N'										AS SharingPrivacy
,'A'										AS SharingOption
FROM [edaprod].[dbo].[ContentVersion] C
LEFT JOIN
EDUCPROD.dbo.Contact Co
ON C.FirstPublishLocationId = Co.Legacy_ID__c
LEFT JOIN
EDUCPROD.dbo.[User] U
ON C.FirstPublishLocationId = U.EDAUSERID__c
LEFT JOIN
EDUCPROD.dbo.[Case] Ca
ON C.FirstPublishLocationId = Ca.Legacy_ID__c
LEFT JOIN
EDUCPROD.dbo.[Opportunity] Op
ON C.FirstPublishLocationId = Op.Legacy_ID__c
LEFT JOIN
EDUCPROD.dbo.[Lead] L
ON C.FirstPublishLocationId = L.Legacy_ID__c
LEFT JOIN
[EDUCPROD].[dbo].[EmailMessage] Em
ON C.FirstPublishLocationId = Em.EDAEMAILMSGID__c
INNER JOIN
[edaprod].[dbo].[ContentVersion_2500001_2700000] B
ON C.Id = B.Id
LEFT JOIN [EDUCPROD].[dbo].[InteractionSummary]	I
ON LEFT(I.Legacy_Id__c,18) = C.Id

