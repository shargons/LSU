USE [edcuat];
GO

/****** Object:  View [dbo].[NMSS_Navigator_Individuals]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER VIEW [dbo].[01A_EDA_UserRole] AS





SELECT
		 NULL								AS ID
	  ,[CaseAccessForAccountOwner]
      ,[ContactAccessForAccountOwner]
      ,[DeveloperName]
      ,[ForecastUserId]
      ,[Id]									AS Legacy_Id__c
      --,[LastModifiedById]
      --,[LastModifiedDate]
      ,[MayForecastManagerShare]
      ,[Name]
      ,[OpportunityAccessForAccountOwner]
      ,[ParentRoleId] AS Source_Parent_Role
      ,[PortalAccountId]
      ,[PortalAccountOwnerId]
      ,[PortalRole]
      ,[PortalType]
      ,[RollupDescription]
      ,[SystemModstamp]
FROM [edaprod].[dbo].[UserRole]