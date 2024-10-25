

SELECT EDACROFRNGID__c FROM [dbo].[21_EDA_CourseOffering]
WHERE StartDate is null


SELECT CO.ID,A.StartDate,a.EndDate
INTO CourseOffering_Date_Update
FROM [dbo].[21_EDA_CourseOffering] A
INNER JOIN
CourseOffering CO
ON A.EDACROFRNGID__c = CO.EDACROFRNGID__c


EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','CourseOffering_Date_Update'

SELECT CO.ID,A.StartDate,a.EndDate
INTO AcademicTerm_Date_Update
FROM [dbo].[09_EDA_Term] A
INNER JOIN
AcademicTerm CO
ON A.EDATERMID__c = CO.EDATERMID__c

EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','AcademicTerm_Date_Update'

SELECT COP.ID, DATEADD(HOUR,12,A.EndDate) AS EndDate
INTO CourseOfferingParticipant_EndDate_Update
FROM [dbo].[22_EDA_CourseEnrollment] A
INNER JOIN
CourseOfferingParticipant COP
ON A.Legacy_ID__c = COP.Legacy_ID__c
WHERE A.EndDate <> COP.EndDate

EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','CourseOfferingParticipant_EndDate_Update'