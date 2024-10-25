
USE edcuat;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Account
--====================================================================
--DROP TABLE IF EXISTS [dbo].[LearningProgram_LOAD];
--GO
SELECT C.*,L.ID AS LearningId
INTO [edcuat].dbo.LearningProgram_LOAD
FROM [edcuat].[dbo].[04_EDA_AccountProgram] C
LEFT JOIN [edcuat].[dbo].[Learning] L
ON C.EDAACCOUNTID__c = L.EDAACCOUNTID__c


/******* Check Load table *********/
SELECT * FROM [edcuat].dbo.LearningProgram_LOAD


--====================================================================
--INSERTING DATA USING DBAMP - Account
--====================================================================


/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE LearningProgram_LOAD
ALTER COLUMN ID NVARCHAR(18)


EXEC SF_TableLoader 'Insert:BULKAPI','EDCUAT','LearningProgram_LOAD_3'

--DROP TABLE LearningProgram_LOAD_2
SELECT * 
--INTO LearningProgram_LOAD_3
FROM LearningProgram_LOAD_2_Result where Error <> 'Operation Successful.'
and Error like 'INVALID_OR_NULL_FOR_RESTRICTED_PICKLIST%'

INVALID_OR_NULL_FOR_RESTRICTED_PICKLIST:Client/Employer: bad value for restricted picklist field: Macy&#39;s:clientemployer__c --

UPDATE LearningProgram_LOAD_3
SET clientemployer__c = REPLACE(clientemployer__c,'Macy''s','Macys')
WHERE clientemployer__c like'%Macy%'

select DISTINCT  Error from LearningProgram_LOAD_Result

--====================================================================
--ERROR RESOLUTION - Account
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE LearningProgram_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'LearningProgram_DELETE'

INSERT INTO LearningProgram_DELETE(Id) SELECT Id FROM LearningProgram_LOAD_Result WHERE Error = 'Operation Successful.'

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
--INTO [edcuat].[dbo].[Account_Program_Lookup]
FROM LearningProgram_LOAD_3_Result
WHERE Error = 'Operation Successful.'



SELECT * FROM [Account_Program_Lookup]


