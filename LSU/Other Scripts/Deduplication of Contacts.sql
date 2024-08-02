

SELECT Id,Legacy_Id__c
--INTO Contact_Delete_6
FROM (
SELECT Id,Legacy_Id__c,ROW_NUMBER() OVER(PARTITION BY Legacy_Id__c ORDER BY Legacy_Id__c) as rownum
FROM Contact )X
WHERE X.rownum > 1 
and Legacy_Id__c IS NOT NULL

--DROP TABLE Account_Person_Delete_Legacy_Id
select A.ID,A.Legacy_Id__pc
INTO Account_Person_Delete_Legacy_Id_6
from Account A
INNER JOIN Contact_Delete_6 B
ON A.PersonContactId = B.Id


select A.ID,A.Legacy_Id__c
INTO Contact_Person_Delete_Legacy_Id_6
from Contact A
INNER JOIN Contact_Delete_6 B
ON A.Id = B.Id

select A.ID
INTO Account_Person_Delete_6
from Account A
INNER JOIN Contact_Delete_6 B
ON A.PersonContactId = B.Id

EXEC SF_TableLoader 'Delete:BULKAPI','EDCUAT','Account_Person_Delete_6'

SELECT * FROM Account_Person_Delete_6_Result
WHERE Error <> 'Operation Successful.'

SELECT Id,Legacy_Id__pc
INTO Surviving_Accounts_6
FROM Account
WHERE Legacy_Id__pc IN (SELECT Legacy_Id__pc FROM Account_Person_Delete_Legacy_Id_6)
AND ID NOT IN (SELECT Id FROM Account_Person_Delete_Legacy_Id_6)

SELECT Id,Legacy_Id__c
INTO Surviving_Contacts_6
FROM Contact
WHERE Legacy_Id__c IN (SELECT Legacy_Id__pc FROM Account_Person_Delete_Legacy_Id_6)
AND ID NOT IN (SELECT Id FROM Contact_Delete_6)

--DROP TABLE Case_Update_6
SELECT A.ID,C.Id as AccountId
INTO Case_Update_6
FROM [Case] A
INNER JOIN
Account_Person_Delete_Legacy_Id_6 B
ON A.AccountId = B.Id
INNER JOIN 
Surviving_Accounts_6 C
ON B.Legacy_Id__pc = C.Legacy_Id__pc

EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','Case_Update_6'




SELECT A.ID,C.Id as ContactID
INTO Case_ContactId_Update_6
FROM [Case] A
INNER JOIN
Contact_Person_Delete_Legacy_Id_6 B
ON A.ContactId = B.Id
INNER JOIN 
Surviving_Contacts_6 C
ON B.Legacy_Id__c = C.Legacy_Id__c

EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','Case_ContactId_Update_6'


SELECT A.ID,C.Id as AccountId
INTO Opportunity_Update_6
FROM [Opportunity] A
INNER JOIN
Account_Person_Delete_Legacy_Id_6 B
ON A.AccountId = B.Id
INNER JOIN 
Surviving_Accounts_6 C
ON B.Legacy_Id__pc = C.Legacy_Id__pc

EXEC SF_TableLoader 'Update:BULKAPI','EDCUAT','Opportunity_Update_6'

SELECT * FROM Account_Person_Delete_Legacy_Id_6
WHERE ID IN ('001D100000qvAnmIAE','001D100000qutqgIAA','001D100000quQsUIAU')

SELECT * FROM Surviving_Accounts_6
WHERE Legacy_Id__pc IN ('0033n00002ZFgc4AAD','0032E00002xxvfGQAQ','0032E00002tbvoIQAQ')





