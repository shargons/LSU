
-- Recruitment Case Opportunity Update
SELECT A.Id,O.Id as Related_Opportunity__c,I.Id
--INTO Case_Rec_Opp_Link_Update
FROM [Case] A
INNER JOIN
[edaprod].[dbo].[Opportunity] I
ON A.Legacy_Id__c = I.Id
--LEFT JOIN [edaprod].[dbo].[Opportunity] Op
--ON Op.Id = I.
LEFT JOIN
[Opportunity] O
ON O.Legacy_ID__c = I.Id
WHERE a.Related_Opportunity__c is null

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Case_Rec_Opp_Link_Update'



-- Retention Case Related Opportunity Load

SELECT Ret.Id,Op.Id as Related_Opportunity__c
--INTO Case_Ret_Opp_Link_Update
FROM [Case] Ret
INNER JOIN
[dbo].[14_EDA_Affiliations] I
ON Ret.Legacy_Id__c = I.Legacy_Id__c
LEFT JOIN
[edaprod].[dbo].[Opportunity] O
ON O.Affiliation__c = I.legacy_ID__c
LEFT JOIN
[Opportunity] Op
ON Op.Legacy_ID__c = O.Id
WHERE Ret.Related_Opportunity__c IS NULL

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Case_Ret_Opp_Link_Update'

-- Retention Case Related Recruitment Case Load

SELECT A.Id,Rec.Id as Related_Recruitment_Case__c
--INTO Case_Ret_RecCase_Link_Update
FROM [Case] A
INNER JOIN
[dbo].[14_EDA_Affiliations] I
ON A.Legacy_Id__c = I.Legacy_Id__c
LEFT JOIN [edaprod].[dbo].[Opportunity] O
ON O.Affiliation__c = I.legacy_ID__c
LEFT JOIN [Case] Rec
on O.Id = Rec.Legacy_ID__c
WHERE A.Related_Recruitment_Case__c IS NULL


