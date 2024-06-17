
USE edcdatadev;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Account
--====================================================================
--DROP TABLE IF EXISTS [dbo].[LearningProgram_LOAD];
--GO
SELECT C.*,L.ID AS LearningId
INTO [edcuat].dbo.LearningProgram_LOAD
FROM [edcdatadev].[dbo].[04_EDA_AccountProgram] C
LEFT JOIN [edcuat].[dbo].[Learning_Lookup] L
ON C.EDAACCOUNTID__c = L.Legacy_ID__c


/******* Check Load table *********/
SELECT * FROM [edcuat].dbo.LearningProgram_LOAD


--====================================================================
--INSERTING DATA USING DBAMP - Account
--====================================================================


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE LearningProgram_LOAD
ALTER COLUMN ID NVARCHAR(18)


EXEC SF_TableLoader 'Insert:BULKAPI','EDCUAT','LearningProgram_LOAD_2'

SELECT * 
INTO LearningProgram_LOAD_2
FROM LearningProgram_LOAD_Result where Error <> 'Operation Successful.'

select DISTINCT  Error from LearningProgram_LOAD_Result

--====================================================================
--ERROR RESOLUTION - Account
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE LearningProgram_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'LearningProgram_DELETE'

INSERT INTO LearningProgram_DELETE(Id) SELECT Id FROM LearningProgram WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'LearningProgram_DELETE'

--====================================================================
--POPULATING LOOOKUP TABLES- Account
--====================================================================

-- Contact Lookup
DROP TABLE IF EXISTS [dbo].[Account_Program_Lookup];
GO
INSERT INTO [edcuat].[dbo].[Account_Program_Lookup]
SELECT
 ID
,EDAACCOUNTID__c as Legacy_ID__c
FROM LearningProgram_LOAD_2_Result
WHERE Error = 'Operation Successful.'


