

SELECT count(*),Legacy_Id__c FROM Account
group by Legacy_Id__c
having count(*) > 1

SELECT Id
into Account_College_Dup_Delete
FROM (
SELECT Id,Legacy_Id__c,ROW_NUMBER() over(PARTITION BY Legacy_Id__c ORDER BY Legacy_Id__c) as rownum
FROM Account
WHERE Legacy_Id__c IS NOT NULL
)X
where rownum =2

select * from Account_College_Dup_Delete


EXEC SF_TableLoader 'Delete:BULKAPI','EDUCPROD','Account_College_Dup_Delete'