USE [edcdatadev];
GO

/****** Object:  View [dbo].[02_EDA_OrgAccount]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[05A_EDA_AcademicYear] AS

SELECT * FROM
(
	SELECT DISTINCT 
	NULL AS ID
	,IIF(REVERSE(SUBSTRING(REVERSE(graduation_term__c),1,4)) LIKE '%[0-9]%',REVERSE(SUBSTRING(REVERSE(graduation_term__c),1,4)),NULL) AS Name
	FROM edaprod.dbo.Contact
	UNION ALL
	SELECT DISTINCT 
	NULL AS ID
	,IIF(REVERSE(SUBSTRING(REVERSE(Term_of_Interest__c),1,4)) LIKE '%[0-9]%',REVERSE(SUBSTRING(REVERSE(Term_of_Interest__c),1,4)),NULL) AS Name
	FROM edaprod.dbo.Contact
)X
WHERE X.Name IS NOT NULL