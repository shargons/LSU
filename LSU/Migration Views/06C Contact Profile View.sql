USE [edcuat];
GO

/****** Object:  View [dbo].[06_ContactProfile]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[06_ContactProfile] AS

SELECT  
	NULL AS ID
	,C.Id							AS Legacy_Id__c
	,CASE WHEN hed__Ethnicity__c = 'Native Hawaiian or Other Pacific Islander' THEN 'Native Hawaiian or Other Pacific' 
		  WHEN hed__Ethnicity__c = 'Black' THEN 'Black or African American'
		  WHEN hed__Ethnicity__c = 'American Indian or Alaskan Native' THEN 'American Indian or Alaska Native'
		  WHEN hed__Ethnicity__c IN ('NOT REPORTED','Unknown','Y','Nonresident Alien','N','Not Specified',NULL) THEN 'Not Selected'
		ELSE hed__Ethnicity__c
	END				AS Ethnicity
	,hed__military_background__c	AS military_background__c
	,CASE WHEN hed__military_service__c	= 1 THEN 'Active Duty'
		  WHEN military__c = 'Disabled Veteran' THEN 'Veteran'
		ELSE military__c
	 END							AS MilitaryService
	,CASE WHEN hed__Ethnicity__c = 'Native Hawaiian or Other Pacific' THEN 'Native Hawaiian or Other Pacific Islander' 
		  WHEN hed__Ethnicity__c = 'Black' THEN 'Black or African American'
		  WHEN hed__Ethnicity__c = 'American Indian or Alaskan Native' THEN 'American Indian or Alaska Native'
		  WHEN hed__Ethnicity__c IN ('NOT REPORTED','Unknown','Y','Nonresident Alien','N','Not Specified',NULL) THEN NULL
		ELSE hed__Race__c
	END					AS Race
	,hed__Citizenship_Status__c		AS Citizenship_Status__c
	,Co.Id							AS ContactId
	,CASE WHEN C.graduated__c = 0 THEN 'Non-Graduate'
		  ELSE C.Highest_Level_of_Education__c 
	 END							AS GraduationAchievement
	 ,CASE WHEN C.Highest_Level_of_Education__c = 'High school graduate' THEN 'High School'
		   WHEN C.Highest_Level_of_Education__c = 'Associate degree' 
				OR C.Highest_Level_of_Education__c = 'Bachelor''s degree' 
				OR C.Highest_Level_of_Education__c = 'Professional degree' THEN 'Graduate'
		   WHEN C.Highest_Level_of_Education__c = 'Master''s degree' THEN 'Masters'
		   WHEN C.Highest_Level_of_Education__c = 'Doctorate degree' THEN 'PhD'
		   ELSE 'Other'
	 END							AS HighestEducationLevel
FROM [edaprod].[dbo].[Contact] C
LEFT JOIN
[edcuat].[dbo].[Contact] Co
ON C.Id = Co.Legacy_Id__c
