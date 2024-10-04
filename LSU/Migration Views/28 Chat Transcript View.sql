USE [edcuat];
GO

/****** Object:  View [dbo].[12_EDA_Interactions]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[28_EDA_ChatTranscripts] AS


SELECT
NULL									AS ID
,abandoned								AS abandoned__c
,averageresponsetimeoperator			AS Average_Response_Time_Operator__c
,averageresponsetimevisitor				AS averageresponsetimevisitor__c
,body									AS body__c
,browser								AS browser__c
,browserlanguage						AS browserlanguage__c
,caseid									AS Source_Case
,Ca.Id									AS Case__c
,chatduration							AS chatduration__c
,T.contactid							AS Source_Contact
,C.Id									AS Contact__c
,T.createddate
,endedby								AS endedby__c
,endtime								AS endtime__c
,T.id									AS Legacy_ID__c
,ipaddress								AS ipaddress__c
,[location]								AS location__c
,maxresponsetimeoperator				AS maxresponsetimeoperator__c
,maxresponsetimevisitor					AS maxresponsetimevisitor__c
,T.[name]
,operatormessagecount					AS operatormessagecount__c	
,[platform]								AS platform__c
,referreruri							AS referreruri__c
,requesttime							AS requesttime__c
,screenresolution						AS screenresolution__c
,starttime								AS starttime__c
,T.[status]								AS status__c
--,student_type__c						AS student_type__c
,supervisortranscriptbody				AS supervisortranscriptbody__c
,useragent								AS useragent__c
,visitormessagecount					AS visitormessagecount__c
,visitornetwork							AS visitornetwork__c
,waittime								AS waittime__c
--,O.ID											AS ownerid
--,CR.ID										AS createdbyid
FROM  [edaprod].[dbo].[livechattranscript] T
LEFT JOIN [edcuat].[dbo].[Contact] C
ON C.Legacy_ID__c = T.contactid
LEFT JOIN [edcuat].[dbo].[Case] Ca
ON Ca.Legacy_ID__c = T.caseid
--LEFT JOIN [edcuat].[dbo].[User_Lookup] cr
--ON T.CreatedById = cr.Legacy_ID__c
--LEFT JOIN [edcuat].[dbo].[User_Lookup] O
--ON T.OwnerId = O.Legacy_ID__c