USE [edcuat];
GO

/****** Object:  View [dbo].[02_EDA_OrgAccount]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[05B_EDA_AcademicTerm] AS

SELECT * FROM
(
	SELECT DISTINCT 
	NULL AS ID
	,Graduation_Term__c AS Name
	,A.ID AS AcademicYearId
	FROM edaprod.dbo.Contact C
	LEFT JOIN edcuat.dbo.AcademicYear_Lookup A
	ON REVERSE(SUBSTRING(REVERSE(C.Graduation_Term__c),1,4)) = A.Name
	UNION ALL
		SELECT DISTINCT 
	NULL AS ID
	,Term_of_Interest__c AS Name
	,A.ID AS AcademicYearId
	FROM edaprod.dbo.Contact C
	LEFT JOIN edcuat.dbo.AcademicYear_Lookup A
	ON REVERSE(SUBSTRING(REVERSE(C.Term_of_Interest__c),1,4)) = A.Name
)X
WHERE X.Name <> 'Unspecified'