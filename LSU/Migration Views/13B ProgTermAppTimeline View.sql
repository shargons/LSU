USE [EDUCPROD];
GO

/****** Object:  View [dbo].[02_EDA_OrgAccount]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[13B_EDA_PTAT] AS

SELECT DISTINCT X.*,T2.Id as AcademicTermId
FROM (
SELECT
	 NULL					as ID
	,B.hed__Account__c		as Source_LearningProgram
	,AL.Id					as LearningProgramId
	,IIF(A.Term_Applied__c IS NULL,A.Term_Admitted__c,A.Term_Applied__c)		AS SourceAcademicTerm
	--,IIF(T2.Id IS NULL,T3.Id,T2.Id)				as AcademicTermId
	,A.Id					as UpsertKey__c
FROM [edaprod].[dbo].[Application__c] A
LEFT JOIN 
 [edaprod].[dbo].[hed__Affiliation__c] B
ON A.LSU_Affiliation__c = B.Id
LEFT JOIN
[EDUCPROD].[dbo].[LearningProgram] AL
ON AL.EDAACCOUNTID__c = B.hed__Account__c
)X
LEFT JOIN [edaprod].[dbo].[SF_EDA_All_Campus_Term_Codes] TC
ON X.SourceAcademicTerm = TC.Campus_Term_Code_incoming_file_term_formats
LEFT JOIN [EDUCPROD].[dbo].[AcademicTerm] T2
ON T2.Term_Id__c = TC.Stand_Term_Code
WHERE X.SourceAcademicTerm IS NOT NULL AND X.Source_LearningProgram IS NOT NULL
AND T2.ID IS NOT NULL

CREATE OR ALTER VIEW [dbo].[13B_EDA_PTAT_NEW] AS

SELECT DISTINCT X.ID,X.LearningProgramId,T2.Id as AcademicTermId
FROM (
SELECT
	 NULL					as ID
	,B.hed__Account__c		as Source_LearningProgram
	,AL.Id					as LearningProgramId
	,IIF(A.Term_Applied__c IS NULL,A.Term_Admitted__c,A.Term_Applied__c)		AS SourceAcademicTerm
	--,IIF(T2.Id IS NULL,T3.Id,T2.Id)				as AcademicTermId
	--,A.Id					as UpsertKey__c
FROM [edaprod].[dbo].[Application__c] A
LEFT JOIN 
 [edaprod].[dbo].[hed__Affiliation__c] B
ON A.LSU_Affiliation__c = B.Id
LEFT JOIN
[EDUCPROD].[dbo].[LearningProgram] AL
ON AL.EDAACCOUNTID__c = B.hed__Account__c
)X
LEFT JOIN [edaprod].[dbo].[SF_EDA_All_Campus_Term_Codes] TC
ON X.SourceAcademicTerm = TC.Campus_Term_Code_incoming_file_term_formats
LEFT JOIN [EDUCPROD].[dbo].[AcademicTerm] T2
ON T2.Term_Id__c = TC.Stand_Term_Code
WHERE X.SourceAcademicTerm IS NOT NULL AND X.Source_LearningProgram IS NOT NULL
AND T2.ID IS NOT NULL
