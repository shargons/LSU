SELECT DISTINCT 
	lp.Id
	,IIF(cop.Id IS NULL, 'Not Started', IIF(lp.Campus__c = 'CE', 'Active', 'Enrolled')) AS [Status]
	INTO LearnerProgram_Update_LCEC_1297
	FROM LearnerProgram lp
	LEFT JOIN CourseOfferingParticipant cop ON cop.ParticipantContactId = lp.LearnerContactId
	WHERE 
		lp.Status = 'Active'
		AND lp.EDACERTENROLLID__c IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','LearnerProgram_Update_LCEC_1297'

SELECT Error FROM LearnerProgram_Update_LCEC_1297_Result

DROP TABLE Case_Update_LCEC_1296

SELECT 
	c.Id
	,u.Id AS OwnerId
INTO Case_Update_LCEC_1296
FROM [Case] c
JOIN edaprod.dbo.Opportunity o ON o.Id = c.Legacy_ID__c
JOIN Contact con ON con.Id = c.ContactId
JOIN edaprod.dbo.Contact ce ON ce.Id = con.Legacy_Id__c
JOIN [User] u ON u.EDAUSERID__c = IIF(c.RecordTypeId = '012Hu000001c6vEIAQ', ce.CE_Enrollment_Coach__c, ce.Enrollment_Concierge__c)
WHERE
	c.RecordTypeId IN ('012Hu000001c6vEIAQ','012Hu000001c6vFIAQ')
	AND (o.StageName = 'Enrolled' OR o.RecordTypeId = '0122E000000lVgkQAE')


EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Case_Update_LCEC_1296'

SELECT 
	con.Id
	,u.Id AS enrollment_concierge__c
INTO Contact_Update_LCEC_1296
FROM [Case] c
JOIN edaprod.dbo.Opportunity o ON o.Id = c.Legacy_ID__c
JOIN Contact con ON con.Id = c.ContactId
JOIN edaprod.dbo.Contact ce ON ce.Id = con.Legacy_Id__c
JOIN [User] u ON u.EDAUSERID__c = IIF(c.RecordTypeId = '012Hu000001c6vEIAQ', ce.CE_Enrollment_Coach__c, ce.Enrollment_Concierge__c)
WHERE
	c.RecordTypeId IN ('012Hu000001c6vEIAQ','012Hu000001c6vFIAQ')
	AND (o.StageName = 'Enrolled' OR o.RecordTypeId = '0122E000000lVgkQAE')


EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Contact_Update_LCEC_1296'

EXEC SF_Replicate 'EDUCPROD','Case','pkchunk,batchsize(50000)'

SELECT 
	c.Id
	,c.Welcome_Call_Scheduled_Date_Time__c AS ActivityDate
	,'Welcome Call' AS [Subject]
	,c.ContactId AS WhoId
	,'Not Started' AS Status
INTO Task_LOAD_LCEC_1261
FROM [Case] c
--LEFT JOIN (
--	SELECT * FROM Task WHERE [Subject] LIKE 'Welcome%'
--	)t ON t.WhoId = c.ContactId
WHERE
	--t.Id IS NULL
	--AND c.IsClosed = 0
	 c.Welcome_Call_Scheduled_Date_Time__c IS NOT NULL
	AND c.Welcome_Call_Scheduled_Date_Time__c > '2024-12-05T00:00:00'
	--AND c.Welcome_Call_Status__c = 'Welcome Call Scheduled'
	--AND c.Legacy_ID__c IS NOT NULL
	AND c.RecordTypeId = '012Hu000001c6vFIAQ' 
ORDER BY c.Welcome_Call_Scheduled_Date_Time__c DESC

EXEC SF_TableLoader 'Insert:BULKAPI','EDUCPROD','Task_LOAD_LCEC_1261'

SELECT 
	c.Id
	,CASE 
		WHEN cl.StageName = 'Not Scheduled' THEN 'Learner Decision'
		WHEN cl.StageName = 'Prospect' THEN 'Prospect'
		WHEN cl.StageName = 'Application' THEN 'Applied'
	END AS [Status]
INTO Case_Update_LCEC_1218
FROM [educprod].[dbo].[Case_Opp_Recruitment_LOAD] cl
JOIN [Case] c ON c.Legacy_ID__c = cl.Legacy_ID__c
WHERE cl.[Status] IS NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Case_Update_LCEC_1218'