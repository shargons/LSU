USE [edcdatadev];
GO

/****** Object:  View [dbo].[02_EDA_OrgAccount]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[03_EDA_Learning] AS





SELECT
		NULL					AS ID
		,A.createddate    
		,CASE
			WHEN A.Degree_Level__c = 'Professional MicroCert' THEN 'Professional Education'
			WHEN A.Degree_Level__c = 'TPP' THEN 'Graduate'
			WHEN A.Degree_Level__c = 'College Credit Certificate' THEN 'Undergraduate'
			WHEN A.Degree_Level__c = 'College Credit Specialist Certificate' THEN 'Undergraduate'
			WHEN A.Degree_Level__c = 'Professional Certificate, Technology & Data Analytics' THEN 'Professional Education'
			WHEN A.Degree_Level__c = 'Tiger Prep' THEN 'Undergraduate'
			WHEN A.Degree_Level__c = 'Paralegal' THEN 'Graduate'
			WHEN A.Degree_Level__c = 'Individual Professional Courses' THEN 'Professional Education'
			WHEN A.Degree_Level__c = 'n/a' THEN NULL
			WHEN A.Degree_Level__c = 'Doctorate' THEN 'Doctoral'
			WHEN A.Degree_Level__c = 'Associate' THEN 'Undergraduate'
			WHEN A.Degree_Level__c = 'Individual Professional Development Courses' THEN 'Professional Education'
			WHEN A.Degree_Level__c = 'UnderGrad Certificate' THEN 'Undergraduate'
			WHEN A.Degree_Level__c = 'ODL Individual Courses' THEN 'Undergraduate'
			WHEN A.Degree_Level__c = 'Professional Certificate' THEN 'Professional Education'
			WHEN A.Degree_Level__c = 'Individual ODL Courses' THEN  'Professional Education'
			WHEN A.Degree_Level__c = NULL THEN NULL
			WHEN A.Degree_Level__c = 'TPP Courses' THEN 'Professional Education'
			WHEN A.Degree_Level__c = 'Professional Specialist Certificate' THEN 'Professional Education'
			WHEN A.Degree_Level__c = 'Graduate Certificate' THEN 'Graduate'
			WHEN A.Degree_Level__c = 'OLLI' THEN 'Graduate'
			WHEN A.Degree_Level__c = 'Professional MicroCert; Individual Professional Development Courses' THEN 'Professional Education'
			WHEN A.Degree_Level__c = 'PD courses' THEN 'Professional Education'
			WHEN A.Degree_Level__c = 'Post-Bacc' THEN 'Post-Baccalaureate Certificate'
			WHEN A.Degree_Level__c = 'OLLI Membership' THEN 'Adult Education'
			WHEN A.Degree_Level__c = 'Post-Bacc Certificate' THEN 'Post-Baccalaureate Certificate'
			WHEN A.Degree_Level__c = 'Bachelors' THEN 'Graduate'
			WHEN A.Degree_Level__c = 'PD' THEN 'Professional Education'
			WHEN A.Degree_Level__c = 'Paralegal individual courses' THEN 'Professional Education'
			WHEN A.Degree_Level__c = 'MicroCred®' THEN 'Professional Education'
			WHEN A.Degree_Level__c = 'Prof Cert' THEN 'Professional Education'
			WHEN A.Degree_Level__c = 'ODL' THEN 'Professional Education'
			WHEN A.Degree_Level__c = 'Masters' THEN 'Graduate' 
			WHEN A.Degree_Level__c = 'OLLI Courses' THEN 'Adult Education'
			ELSE NULL
		END AS AcademicLevel
		,A.Description 
		,A.id                   AS EDAACCOUNTID__c
		,CASE WHEN a.inactive__c = 1 THEN 0 ELSE 1 END AS IsActive
		,A.name
		,a.parentid				AS Source_ParentID
		--,'Course' as Type
		--,CR.ID AS createdbyid
		--,O.ID AS ownerid
		FROM  [EDAPROD].[dbo].[Account] A
	JOIN [EDAPROD].[dbo].Recordtype R ON A.RecordTypeId = R.Id
	--LEFT JOIN [edcdatadev].[dbo].[User_Lookup] CR
	--ON A.CreatedById = CR.Legacy_ID__c
	--LEFT JOIN [edcdatadev].[dbo].[User_Lookup] O
	--ON A.OwnerId = O.Legacy_ID__c
	WHERE R.DeveloperName IN ('Academic_Program')