


SELECT DISTINCT x.ID,X.StageName
--INTO EDA_Leads
FROM (
SELECT C.Id,O.Id as OpportunityID,O.StageName
FROM [edaprod].[dbo].Contact C
INNER JOIN
[edaprod].[dbo].Opportunity O
ON O.Contact__c = C.Id
AND O.StageName IN ('Attempting','New','Fallout') AND O.Application_ID__c IS NULL AND O.Student_id__c IS NULL
)X


SELECT A.id
INTO Account_Lead_PersonAccount_Delete
FROM Account A
INNER JOIN
EDA_Leads B
ON A.Legacy_Id__pc = B.Id


EXEC SF_TableLoader 'Delete:BULKAPI','EDUCPROD','Account_Lead_PersonAccount_Delete'

SELECT * FROM Account_Lead_PersonAccount_Delete_Result
WHERE Error = 'Operation Successful.'
WHERE ID = '001Hu00003UMChEIAX'


SELECT DISTINCT A.RECORDTYPEID
FROM [Case] A
INNER JOIN
[Contact_Delete] B
ON A.ContactId = B.Id


SELECT * FROM Recordtype WHERE SobjectType = 'Case'



SELECT DISTINCT x.ID,X.StageName
--INTO EDA_Leads
FROM (
SELECT C.Id,O.Id as OpportunityID,O.StageName
FROM [edaprod].[dbo].Contact C
INNER JOIN
[edaprod].[dbo].Opportunity O
ON O.Contact__c = C.Id
AND O.StageName IN ('Attempting','New') AND O.Application_ID__c IS NOT NULL AND O.Student_id__c IS NOT NULL
)X
LEFT JOIN
Lead_Lookup LL
ON X.ID = LL.Legacy_Id__c