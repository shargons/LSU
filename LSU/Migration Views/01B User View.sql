USE EDUCPROD;
GO

/****** Object:  View [dbo].[NMSS_Navigator_Individuals]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER VIEW [dbo].[01_EDA_User] AS





SELECT
		 NULL								AS ID
		,alias
		,city
		,communitynickname
		,companyname
		,country
		,A.createddate						as EDACREATEDDATE__c
		,defaultgroupnotificationfrequency
		,department
		,digestfrequency
		,division
		,email+'.invalid'					AS Email
		,emailencodingkey
		,emailpreferencesautobcc
		,emailpreferencesstayintouchreminder
		,employeenumber
		,extension
		,fax
		,firstname
		,forecastenabled
		,A.id									as EDAUSERID__c
		,0 as isactive
		,languagelocalekey
		,lastname
		,localesidkey
		,middlename
		,mobilephone
		,phone
		,postalcode
		,P.ID AS ProfileId
		,receivesadmininfoemails
		,receivesinfoemails
		,sendername
		,signature
		,state
		,street
		,suffix
		,timezonesidkey
		,title
		,SUBSTRING(USERNAME,1,PATINDEX('%@%',USERNAME))+'lsu.ec.edu' as username
		,'00EHu000004WY1ZMAW'				  as userroleid
FROM [edaprod].[dbo].[User] A
LEFT JOIN EDUCPROD.dbo.[Profile]	P
ON P.Name = 'Standard Platform User'


