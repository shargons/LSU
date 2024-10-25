select A.* 
INTO edcuat.[dbo].[Opportunity_Rem_LOAD]
from [dbo].[12_EDA_Opportunity] A
LEFT JOIN
Opportunity B
ON A.Legacy_ID__c = B.Legacy_ID__c
WHERE B.Id IS NULL


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE edcuat.[dbo].[Opportunity_Rem_LOAD]
ALTER COLUMN ID NVARCHAR(18)

--====================================================================
--INSERTING DATA USING DBAMP - Case
--====================================================================

SELECT * FROM edcuat.[dbo].[Opportunity_LOAD]

EXEC SF_TableLoader 'Insert:BULKAPI','edcuat','Opportunity_Rem_LOAD'

select * from Opportunity
where Legacy_ID__c = '006Kj000010VZAUIA4'