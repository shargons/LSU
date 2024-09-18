SELECT C.Id
INTO Case_Delete_837
FROM (
SELECT A.Legacy_ID__c,O.Application_ID__c,O.Student_ID__c,O.Application_Slate_ID__c,O.StageName
FROM [dbo].[11_Case_Opp_Recruitment] A
INNER JOIN
[edaprod].[dbo].[Opportunity] O
ON A.Legacy_ID__c = O.Id
WHERE O.Application_ID__c IS NULL
AND O.Student_ID__c IS NULL
AND O.Application_Slate_ID__c IS NULL
AND StageName = 'Fallout'
)X
INNER JOIN
[edcdatadev].[dbo].[Case] C
ON X.Legacy_ID__c = C.Legacy_ID__c


EXEC SF_TableLoader 'Delete:BULKAPI','edcdatadev','Case_Delete_837'