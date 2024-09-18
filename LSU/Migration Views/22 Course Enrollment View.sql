USE [edcuat];
GO

/****** Object:  View [dbo].[22_EDA_CourseEnrollment]    Script Date: 4/9/2024 2:20:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[22_EDA_CourseEnrollment] AS

SELECT 
	  NULL									AS ID
	,associated_guild_cohort__c
	,certificateenrollment__c				AS Source_certificate_enrollment
	,LP.Id									AS certificate_enrollment__c
	,E.createddate							AS EDACREATEDDATE__c
	,hed__affiliation__c					AS Source_Case
	,C.Id									AS Case__c
	,E.hed__contact__c						AS Source_participantcontactid
	,CO.Id									AS ParticipantContactId
	,hed__course_offering__c				AS Source_courseofferingid
	,COF.Id									AS courseofferingid
	,hed__display_grade__c					AS display_grade__c
	,E.id									AS Legacy_ID__c
	,jenzabarenrollmentid__c				AS jenzabar_enrollment_id__c
	,one_destiny_one_status__c
	,E.one_drop_date__c
	,E.one_enrollment_date__c
	,one_enrollment_end_date__c
	,one_enrollment_end_date__c				AS 	EndDate
	,one_enrollment_id__c
	,one_gclid__c
	,one_group_payor_name__c
	,E.one_last_activity_date__c
	,one_transcript_grade__c
	,one_transfer_date__c
	,one_utm_campaign__c
	,one_utm_content__c
	,one_utm_medium__c
	,one_utm_source__c
	,one_utm_term__c
	,sfceenrollmentid__c					AS SF_CE_Enrollment_ID__c
	,start_date_smd__c						AS StartDate
	,studentxnumber__c						AS student_x_number__c
	--,O.ID												AS ownerid
	,E.hed__Status__c as ParticipationStatus
	,AF.Campus__c							as Campus__c 
	,E.CEDivision__c						AS CE_Division__c
FROM  [edaprod].[dbo].[hed__course_enrollment__c] E
--LEFT JOIN [edcuat].[dbo].[User_Lookup] O
--ON E.OwnerId = O.Legacy_ID__c
LEFT JOIN [edcuat].[dbo].[LearnerProgram] LP
ON LP.EDACERTENROLLID__c = E.certificateenrollment__c
LEFT JOIN [edcuat].[dbo].[Case] C
ON C.Legacy_ID__c = E.hed__affiliation__c
LEFT JOIN [edcuat].[dbo].[Contact] CO
ON CO.Legacy_ID__c = E.hed__contact__c
LEFT JOIN [edcuat].[dbo].[CourseOffering] COF
ON COF.EDACROFRNGID__c = E.hed__course_offering__c
LEFT JOIN [edaprod].[dbo].[hed__Affiliation__c] AF
ON E.hed__Affiliation__c = AF.Id
WHERE CO.Id	 IS NOT NULL