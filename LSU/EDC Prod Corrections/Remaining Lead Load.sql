

SELECT c.*
INTO [EDUCPROD].dbo.Lead_Rem_LOAD
FROM [Contact] A
INNER JOIN Account_Lead_PersonAccount_Delete_Result B
on A.AccountId = B.Id
LEFT JOIN
[dbo].[06_EDA_Lead] C
ON A.Legacy_Id__c = C.Legacy_Id__c
WHERE B.Error = 'Operation Successful.'


/******* Check Load table *********/
SELECT * FROM [EDUCPROD].dbo.Lead_Rem_LOAD

--====================================================================
--INSERTING DATA USING DBAMP - Account
--====================================================================


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE Lead_Rem_LOAD
ALTER COLUMN ID NVARCHAR(18)


EXEC SF_TableLoader 'Insert:BULKAPI','EDUCPROD','Lead_Rem_LOAD'

--DROP TABLE Lead_LOAD_2
SELECT * 
--INTO Lead_Rem_LOAD_2
FROM Lead_Rem_LOAD_Result where Error <> 'Operation Successful.'


select DISTINCT  Error from Lead_Rem_LOAD_Result


INSERT INTO [EDUCPROD].[dbo].[Lead_Lookup]
SELECT
 ID
,Legacy_Id__c
FROM Lead_Rem_LOAD_Result
WHERE Error = 'Operation Successful.'