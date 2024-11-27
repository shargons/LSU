
USE EDUCPROD;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Case
--====================================================================


--DROP TABLE IF EXISTS [EDUCPROD].dbo.Case_Ret_Opp_Recr_Case_LOAD];

SELECT *
INTO [EDUCPROD].dbo.Case_Ret_Opp_Recr_Case_LOAD
FROM [EDUCPROD].[dbo].[34A_Ret_Opp_Recruitment] C
ORDER BY ContactId


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE [EDUCPROD].dbo.Case_Ret_Opp_Recr_Case_LOAD
ALTER COLUMN ID NVARCHAR(18)

SELECT * FROM [EDUCPROD].dbo.Case_Ret_Opp_Recr_Case_LOAD

EXEC SF_TableLoader 'Insert:BULKAPI','EDUCPROD','Case_Ret_Opp_Recr_Case_LOAD'

select * 
--into [EDUCPROD].dbo.Case_Ret_Opp_Recr_Case_LOAD_5
from [EDUCPROD].dbo.Case_Ret_Opp_Recr_Case_LOAD_5_Result
where Error <> 'Operation Successful.'
AND Error NOT LIKE '%DUPLICATE%'


UPDATE Case_Ret_Opp_Recr_Case_LOAD_4
SET Comments__C = left(Comments__c,130999)
WHERE Error like '%comment%'

--====================================================================
--	CREATE LOOKUP TABLE - Case
--====================================================================
INSERT INTO Case_Ret_Opp_Ret_Case_Lookup
SELECT Id,Legacy_Id__c
--INTO Case_Ret_Opp_Ret_Case_Lookup
FROM [EDUCPROD].dbo.Case_Ret_Opp_Recr_Case_LOAD_2_Result
WHERE Error = 'Operation Successful.'

select * from Case_Ret_Opp_Ret_Case_Lookup

--====================================================================
--	UPDATE LOOKUPS - Case
--====================================================================

-- Recruitment Case source_RFI Update

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Case_Rec_RFI_Link_Update'

select * from Case_Rec_RFI_Link_Update

-- Related Retention Case Update
SELECT A.Id,C.Id as Related_Retention_Case__c
INTO Case_RFI_Ret_Link_Update
FROM [Case] A
INNER JOIN
[edaprod].[dbo].[Interaction__c] I
ON A.Legacy_Id__c = 'I-'+I.Id
LEFT JOIN [edaprod].[dbo].[Opportunity] Op
ON Op.Id = I.Opportunity__c AND Op.StageName = 'Enrolled'
LEFT JOIN
[edaprod].[dbo].[hed__Affiliation__c] Aff
ON Op.Affiliation__c = Aff.Id
LEFT JOIN
[Case] C
ON Aff.Id = C.Legacy_ID__c

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Case_RFI_Ret_Link_Update'




EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Case_Ret_Opp_Link_Update'



