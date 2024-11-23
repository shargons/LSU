select A.* 
INTO EDUCPROD.[dbo].[Opportunity_Rem_LOAD]
from [dbo].[12_EDA_Opportunity] A
LEFT JOIN
Opportunity B
ON A.Legacy_ID__c = B.Legacy_ID__c
WHERE B.Id IS NULL


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE EDUCPROD.[dbo].[Opportunity_Rem_LOAD]
ALTER COLUMN ID NVARCHAR(18)

--====================================================================
--INSERTING DATA USING DBAMP - Case
--====================================================================

SELECT * FROM EDUCPROD.[dbo].[Opportunity_LOAD]

EXEC SF_TableLoader 'Insert:BULKAPI','EDUCPROD','Opportunity_Rem_LOAD'

select * from Opportunity
where Legacy_ID__c = '006Kj000010VZAUIA4'