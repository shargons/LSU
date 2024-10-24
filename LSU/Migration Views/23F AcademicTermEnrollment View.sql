USE [edcuat];
GO

/****** Object:  View [dbo].[23E_AcademicTermEnrollments]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***** Replicate CourseOfferingParticipant before running the view **********/
--EXEC SF_Replicate 'EDCUAT','CourseOfferingParticipant','pkchunk,batchsize(50000)'

CREATE OR ALTER VIEW [dbo].[23F_AcademicTermEnrollments] AS

SELECT * FROM
(
SELECT
	 CP.Id								AS UpsertKey__c
	,NULL								AS ID
	,LP.Id								AS Learner_Program__c
	,CP.Opportunity__c					AS OpportunityId
	,CP.ParticipantContactId			AS LearnerContactId
	,CP.ParticipantAccountId			AS LearnerAccountId
	,T.Id								AS AcademicTermId
	,cp.Term__c
	,LP.Status							AS Status
	--,O.Learning_Program_of_Interest__c  AS 	Learning_Program__c
	,ROW_NUMBER() OVER (PARTITION BY CP.ID ORDER BY LP.CREATEDDATE DESC ) as rownum
FROM [edcuat].[dbo].[CourseOfferingParticipant] CP
INNER JOIN [edcuat].[dbo].[LearnerProgram] LP
ON CP.ParticipantContactId = LP.LearnerContactId
AND CP.Campus__c = LP.Campus__c
LEFT JOIN [edcuat].[dbo].[Opportunity] O
ON O.Id = CP.Opportunity__c
INNER JOIN [edcuat].[dbo].[AcademicTerm] T
ON CP.Term__c = T.Term_ID__c
--WHERE cp.id = '0x6KT0000002NTNYA2'
)X
WHERE X.rownum = 1





