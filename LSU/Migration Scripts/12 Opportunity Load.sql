
USE EDUCPROD;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Case
--====================================================================


--DROP TABLE IF EXISTS [dbo].[Opportunity_LOAD];
--GO
SELECT *
INTO EDUCPROD.[dbo].[Opportunity_LOAD]
FROM EDUCPROD.[dbo].[12_EDA_Opportunity] C
ORDER BY AccountId


SELECT count(*),RecordtypeId FROM EDUCPROD.[dbo].[Opportunity_LOAD]
GROUP BY RecordtypeId




/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE EDUCPROD.[dbo].[Opportunity_LOAD]
ALTER COLUMN ID NVARCHAR(18)

--====================================================================
--INSERTING DATA USING DBAMP - Case
--====================================================================

SELECT * FROM EDUCPROD.[dbo].[Opportunity_LOAD]

EXEC SF_TableLoader 'Insert:BULKAPI','EDUCPROD','Opportunity_LOAD_2'

--DROP TABLE Opportunity_LOAD_2
SELECT * 
--INTO Opportunity_LOAD_2
FROM Opportunity_LOAD_2_Result where Error <> 'Operation Successful.'
ORDER BY AccountId

select DISTINCT  Error from Opportunity_LOAD_Result



--====================================================================
--ERROR RESOLUTION - Case
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE Opportunity_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'Opportunity_DELETE'

INSERT INTO Opportunity_DELETE(Id) SELECT Id FROM Opportunity_LOAD_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'Opportunity_DELETE'

--====================================================================
--POPULATING LOOOKUP TABLES- Case
--====================================================================

-- Contact Lookup
--DROP TABLE IF EXISTS [dbo].[Opportunity_Lookup];
--GO

INSERT INTO EDUCPROD.[dbo].[Opportunity_Lookup]
SELECT
 ID
,Legacy_ID__c
--INTO EDUCPROD.[dbo].[Opportunity_Lookup]
FROM Opportunity_LOAD_2_Result
WHERE Error = 'Operation Successful.'


--====================================================================
-- UPDATE Related Opportunity Lookup - Case
--====================================================================
-- RFI Case Related Opportunity Update
--DROP TABLE Case_Opportunity_Lookup_Update
SELECT C.ID,A.ID AS Related_Opportunity__c 
INTO Case_Opportunity_Lookup_Update
FROM [Case] C
INNER JOIN 
[edaprod].dbo.[Interaction__c] I
ON 'I-'+I.Id = C.Legacy_ID__c
LEFT JOIN
[Opportunity] A
ON I.Opportunity__c = A.Legacy_ID__c
WHERE C.Related_Opportunity__c IS NULL

EXEC SF_TableLoader 'Update:BULKAPI','EDUCPROD','Case_Opportunity_Lookup_Update_2'

SELECT * 
--INTO Case_Opportunity_Lookup_Update_2
FROM Case_Opportunity_Lookup_Update_2_result
WHERE Error <> 'Operation Successful.'





