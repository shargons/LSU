USE [EDUCPROD];
GO

/****** Object:  View [dbo].[12_EDA_Interactions]    Script Date: 5/8/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[10_EDA_Interactions] AS

SELECT DISTINCT
	NULL						AS ID
	,I.academic_interest__c		AS Source_Program_of_Interest__c   -- Lookup(Plan)
	--,LP.Id						AS Program_of_Interest__c
	,I.affiliated_account__c	AS Source_Learning_Program_of_Interest__c   --- Lookup(Account)
	,LP.Id						AS Learning_Program_of_Interest__c
	,I.contact__c				AS Source_Contact
	,C.Id						AS ContactId
	,NULL						AS Lead__c
	,C.FirstName				AS First_Name__c
	,C.LastName					AS Last_Name__c
	,C.AccountId				AS AccountId
	,I.University_Email__c		AS University_Email__c
	,CASE WHEN C.preferred_email__c	IS NULL
	      THEN C.alternateemail__c 
		  ELSE C.preferred_email__c
	 END						AS ContactEmail
	 ,CASE WHEN C.preferred_email__c	IS NULL
	      THEN C.alternateemail__c 
		  ELSE C.preferred_email__c
	 END						AS Email__c
	,C.phone					AS ContactPhone
	,C.phone					AS Phone__c
	,CR.ID AS createdbyid
	,event_name__c
	,I.gclid__c
	,interaction_source__c		AS [Source__c]
	,new_lsu_lead_source__c		AS lsu_lead_source__c
	,I.marketing_channel__c
	,online_employer_partnership__c 
	,online_family_of_employer_partnership__c
	,O.ID AS ownerid
	,I.partner_admissions_flag_reason__c
	,I.Partner_Admissions_Status__c
	,I.Partner_External_ID__c
	,I.Partner_Internal_Student_ID__c
	,I.Partner_Last_Updated_Date_Time__c
	,I.Partner_LSU_Program_ID__c
	,I.Partner_LSU_Program_Name__c
	,IIF(I.Partner_Name__c IS NOT NULL,I.Partner_Name__c,I.PartnershipName__c) AS Partner_Name__c
	,I.Partner_Record_Created_Date_Time__c
	,I.Partner_Status__c
	,I.Partnership_FERPA__c
	,'I-'+I.id							AS Legacy_Id__c
	,utm_name__c
	,utm_content__c
	,utm_lead_medium__c
	,utm_medium__c
	,utm_source__c
	,utm_term__c
	,C.Firstname+' '+C.Lastname+' '+interaction_source__c AS Subject
	,CASE WHEN Op.Campus__c = 'CE' THEN R3.Id
		  ELSE R2.Id
	 END						AS RecordTypeId
	,LEFT(I.zip_postal_code__c,10) AS zip_postal_code__c
	,CASE 
		WHEN Op.StageName NOT IN ('New','Prospect','Attempting','Qualified','Nurture','Disqualified','Duplicate','Scheduled','Not Scheduled') THEN 'Closed'
		ELSE Op.StageName
		END							AS Status
	,CASE  
			WHEN Op.Sub_Stage__c = 'Not Interested'  THEN 'Not Interested'
			WHEN Op.Sub_Stage__c = 'Not Scheduled'   THEN 'Not Scheduled'
			WHEN Op.Sub_Stage__c = 'Recruitment A'   THEN 'Recruitment A'
			WHEN Op.Sub_Stage__c = 'Recruitment B'   THEN 'Recruitment B'
			WHEN Op.Sub_Stage__c = 'Future Interest' THEN 'Future Interest'
			WHEN Op.Sub_Stage__c = 'Consulting'		 THEN 'Consulting'
			WHEN Op.Sub_Stage__c = 'Scheduled'		 THEN 'Scheduled'
			WHEN Op.Sub_Stage__c = 'No Show'		 THEN 'No Show'
			WHEN Op.Sub_Stage__c = 'Complete'		 THEN 'Complete'
			WHEN Op.Sub_Stage__c = 'Awaiting Application - Submission'		THEN 'Awaiting Application - Submission'
			WHEN Op.Sub_Stage__c = 'Awaiting Application - Payment'		    THEN 'Awaiting Application - Payment'
			WHEN Op.Sub_Stage__c = 'Awaiting Registration'					THEN 'Awaiting Registration'
			WHEN Op.Sub_Stage__c = 'Enrolled'								THEN 'Enrolled'
			WHEN Op.Sub_Stage__c = 'Fallout MIA'							THEN 'Fallout MIA'
			WHEN Op.Sub_Stage__c = 'Fallout'								THEN 'Fallout'
			WHEN Op.Sub_Stage__c = 'Missing Documents'						THEN 'Missing Documents'
			WHEN Op.Sub_Stage__c = 'Awaiting Department'					THEN 'Awaiting Department'
			WHEN Op.Sub_Stage__c = 'Accepted'								THEN 'Accepted'
			WHEN Op.Sub_Stage__c = 'Declined'								THEN 'Declined'
			WHEN Op.Sub_Stage__c = 'Withdrawn'								THEN 'Withdrawn'			
			END							AS Sub_Status__c
	,CASE  
			WHEN Op.Sub_Stage__c = 'Not Interested'  THEN 'Not Interested'
			WHEN Op.Sub_Stage__c = 'Not Scheduled'   THEN 'Not Scheduled'
			WHEN Op.Sub_Stage__c = 'Recruitment A'   THEN 'Recruitment A'
			WHEN Op.Sub_Stage__c = 'Recruitment B'   THEN 'Recruitment B'
			WHEN Op.Sub_Stage__c = 'Future Interest' THEN 'Future Interest'
			WHEN Op.Sub_Stage__c = 'Consulting'		 THEN 'Consulting'
			WHEN Op.Sub_Stage__c = 'Scheduled'		 THEN 'Scheduled'
			WHEN Op.Sub_Stage__c = 'No Show'		 THEN 'No Show'
			WHEN Op.Sub_Stage__c = 'Complete'		 THEN 'Complete'
			WHEN Op.Sub_Stage__c = 'Awaiting Application - Submission'		THEN 'Awaiting Application - Submission'
			WHEN Op.Sub_Stage__c = 'Awaiting Application - Payment'		    THEN 'Awaiting Application - Payment'
			WHEN Op.Sub_Stage__c = 'Awaiting Registration'					THEN 'Awaiting Registration'
			WHEN Op.Sub_Stage__c = 'Enrolled'								THEN 'Enrolled'
			WHEN Op.Sub_Stage__c = 'Fallout MIA'							THEN 'Fallout MIA'
			WHEN Op.Sub_Stage__c = 'Fallout'								THEN 'Fallout'
			WHEN Op.Sub_Stage__c = 'Missing Documents'						THEN 'Missing Documents'
			WHEN Op.Sub_Stage__c = 'Awaiting Department'					THEN 'Awaiting Department'
			WHEN Op.Sub_Stage__c = 'Accepted'								THEN 'Accepted'
			WHEN Op.Sub_Stage__c = 'Declined'								THEN 'Declined'
			WHEN Op.Sub_Stage__c = 'Withdrawn'								THEN 'Withdrawn'			
			END							AS Sub_Stage__c
	,CASE 
			WHEN Op.Sub_Stage__c = 'Moved to LSU Online'  THEN 'Moved to LSU Online'
			WHEN Op.Sub_Stage__c = 'Student Deceased'   THEN 'Student Deceased'
			WHEN Op.Sub_Stage__c = 'Move to CE'   THEN 'Move to CE'
			WHEN Op.Sub_Stage__c = 'Program Not Offered'   THEN 'Program Not Offered'
			WHEN Op.Sub_Stage__c = 'Not Interested' THEN 'Not Interested'
			WHEN Op.Sub_Stage__c = 'Not Qualified'		 THEN 'Not Qualified'
	END AS Disqualified_Reason__c
	,I.Original_Created_Date__c					AS 	EDACreatedDate__c
	--,Op.StageName
FROM [edaprod].[dbo].[Interaction__c]	I
LEFT JOIN [EDUCPROD].[dbo].[Contact] C
ON I.contact__c = C.Legacy_ID__c
--LEFT JOIN [EDUCPROD].[dbo].[Lead] L
--ON I.Lead__c = C.Legacy_ID__c
LEFT JOIN [EDUCPROD].[dbo].[User] cr
ON I.CreatedById = cr.edauserid__c
LEFT JOIN [EDUCPROD].[dbo].[Recordtype] R2
ON R2.DeveloperName = 'RFI_OE'
LEFT JOIN [EDUCPROD].[dbo].[Recordtype] R3
ON R3.DeveloperName = 'RFI_CE'
LEFT JOIN [edaprod].[dbo].[Opportunity] Op
ON Op.Id = I.Opportunity__c
LEFT JOIN [EDUCPROD].[dbo].[User] O
ON Op.OwnerId = O.edauserid__c
LEFT JOIN [EDUCPROD].[dbo].[LearningProgram] LP
ON LP.EDAACCOUNTID__c = I.affiliated_account__c
WHERE I.Interaction_Source__c IN 
('Manual Entry','Appointment','Referral','Webform','Webchat','Bulk_Upload','Website Referral','Scheduler','Zoom Webinar','Completer Referral','Classic','Student','Application')




