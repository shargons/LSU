
USE edcuat;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Case
--====================================================================


--DROP TABLE IF EXISTS [dbo].[Opportunity_LOAD];
--GO
SELECT *
INTO edcuat.[dbo].[Opportunity_LOAD]
FROM edcuat.[dbo].[12_EDA_Opportunity] C
ORDER BY AccountId


SELECT count(*),RecordtypeId FROM edcuat.[dbo].[Opportunity_LOAD]
GROUP BY RecordtypeId

SELECT *
from Recordtype
where SobjectType = 'Opportunity'

--012D10000003kP9IAI - CE
--012D10000003kPAIAY - OE

/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE edcuat.[dbo].[Opportunity_LOAD]
ALTER COLUMN ID NVARCHAR(18)

--====================================================================
--INSERTING DATA USING DBAMP - Case
--====================================================================

SELECT * FROM edcuat.[dbo].[Opportunity_LOAD]

EXEC SF_TableLoader 'Upsert:BULKAPI','edcuat','Opportunity_LOAD_2','Legacy_ID__c'

--DROP TABLE Opportunity_LOAD_2
SELECT * 
INTO Opportunity_LOAD_2
FROM Opportunity_LOAD_Result where Error <> 'Operation Successful.'
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
-- Case Related Opportunity Update
SELECT C.ID,A.ID AS Related_Opportunity__c 
INTO Case_Opportunity_Lookup_Update
FROM Case_Lookup C
LEFT JOIN
[Opportunity_Lookup] A
ON C.Legacy_ID__c = A.Legacy_ID__c

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Case_Opportunity_Lookup_Update'

-- Opportunity Related Recruitment_Case__c Update
SELECT A.ID,C.ID AS Recruitment_Case__c 
INTO Opportunity_RecruitmentCase_Lookup_Update
FROM [Opportunity_Lookup] A
LEFT JOIN
Case_Lookup C
ON C.Legacy_ID__c = A.Legacy_ID__c
WHERE C.ID IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Opportunity_RecruitmentCase_Lookup_Update'


--drop table Case_Sub_Status_Update
SELECT C.ID,'Fallout' as sub_stage__c
into Opportunity_Sub_Status_Update
FROM [dbo].[12_EDA_Opportunity] A
INNER JOIN [Opportunity] C
ON A.Legacy_ID__c = c.Legacy_ID__c
WHERE A.StageName = 'Fallout'


EXEC SF_TableLoader 'Update:BULKAPI','edcdatadev','Opportunity_Sub_Status_Update'



