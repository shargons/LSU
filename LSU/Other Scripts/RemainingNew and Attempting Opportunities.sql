
USE edcuat;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Case
--====================================================================


--DROP TABLE IF EXISTS [dbo].[Opportunity_LOAD];
--GO
SELECT *
INTO edcuat.[dbo].[Opportunity_LOAD_NEW]
FROM edcuat.[dbo].[12_EDA_Opportunity] C
ORDER BY AccountId


SELECT count(*),RecordtypeId FROM edcuat.[dbo].[Opportunity_LOAD]
GROUP BY RecordtypeId

SELECT *
from Recordtype
where SobjectType = 'Opportunity'


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE edcuat.[dbo].[Opportunity_LOAD_NEW]
ALTER COLUMN ID NVARCHAR(18)

--====================================================================
--INSERTING DATA USING DBAMP - Case
--====================================================================

SELECT * FROM edcuat.[dbo].[Opportunity_LOAD_NEW]

EXEC SF_TableLoader 'Insert:BULKAPI','edcuat','Opportunity_LOAD_NEW_3'

--DROP TABLE Opportunity_LOAD_2
SELECT * 
--INTO Opportunity_LOAD_New_3
FROM Opportunity_LOAD_New_3_Result where Error <> 'Operation Successful.'
ORDER BY AccountId

select DISTINCT  Error from Opportunity_LOAD_Result



--====================================================================
--ERROR RESOLUTION - Case
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE Opportunity_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'Opportunity_DELETE'

INSERT INTO Opportunity_DELETE(Id) SELECT Id FROM Opportunity_LOAD_New_3_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'Opportunity_DELETE'

select * from Opportunity_Delete

--====================================================================
--POPULATING LOOOKUP TABLES- Case
--====================================================================

-- Contact Lookup
--DROP TABLE IF EXISTS [dbo].[Opportunity_Lookup];
--GO

INSERT INTO edcuat.[dbo].[Opportunity_Lookup]
SELECT
 ID
,Legacy_ID__c
--INTO edcuat.[dbo].[Opportunity_Lookup]
FROM Opportunity_LOAD_2_Result
WHERE Error = 'Operation Successful.'


--====================================================================
-- UPDATE Related Opportunity Lookup - Case
--====================================================================
-- RFI Case Related Opportunity Update
--DROP TABLE Case_Opportunity_Lookup_Update
SELECT C.ID,A.ID AS Related_Opportunity__c 
--INTO Case_Opportunity_Lookup_Update
FROM [Case] C
INNER JOIN 
[edaprod].dbo.[Interaction__c] I
ON 'I-'+I.Id = C.Legacy_ID__c
LEFT JOIN
[Opportunity] A
ON I.Opportunity__c = A.Legacy_ID__c
WHERE C.Related_Opportunity__c IS NULL

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Case_Opportunity_Lookup_Update_2'

-- Rec Case Related Opportunity Update
--DROP TABLE Case_Opportunity_Lookup_Update
SELECT C.ID,A.ID AS Related_Opportunity__c 
--INTO Case_Opportunity_Lookup_Update
FROM [Case] C
INNER JOIN 
[edaprod].dbo.[Opportunity] Op
ON Op.Id = C.Legacy_ID__c
LEFT JOIN
[Opportunity] A
ON Op.Id = A.Legacy_ID__c
WHERE C.Related_Opportunity__c IS NULL

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Case_Opportunity_Lookup_Update_2'

SELECT * 
--INTO Case_Opportunity_Lookup_Update_2
FROM Case_Opportunity_Lookup_Update_2_result
WHERE Error <> 'Operation Successful.'





