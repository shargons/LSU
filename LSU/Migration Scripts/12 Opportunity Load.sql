
USE edcdatadev;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Case
--====================================================================


--DROP TABLE IF EXISTS [dbo].[Opportunity_LOAD];
--GO
SELECT *
INTO [edcdatadev].[dbo].[Opportunity_LOAD]
FROM [edcdatadev].[dbo].[12_EDA_Opportunity] C
ORDER BY AccountId

SELECT count(*),RecordtypeId FROM [edcdatadev].[dbo].[Opportunity_LOAD]
GROUP BY RecordtypeId

/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE [edcdatadev].[dbo].[Opportunity_LOAD]
ALTER COLUMN ID NVARCHAR(18)

--====================================================================
--INSERTING DATA USING DBAMP - Case
--====================================================================

SELECT * FROM [edcdatadev].[dbo].[Opportunity_LOAD]

EXEC SF_TableLoader 'Upsert:BULKAPI','edcdatadev','Opportunity_LOAD','Legacy_ID__c'

SELECT * 
--INTO Opportunity_LOAD_4
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


SELECT
 ID
,Legacy_ID__c
INTO [edcdatadev].[dbo].[Opportunity_Lookup]
FROM Opportunity_LOAD_Result
WHERE Error = 'Operation Successful.'


--====================================================================
-- UPDATE Related Opportunity Lookup - Case
--====================================================================
-- Case Related Opportunity Update
SELECT C.ID,A.ID AS Related_Opportunity__c 
INTO Case_Opportunity_Lookup_Update
FROM Case_Opp_Recruitment_LOAD_Result C
LEFT JOIN
Opportunity_LOAD_Result A
ON C.Legacy_ID__c = A.Legacy_ID__c

EXEC SF_TableLoader 'Update:BULKAPI','edcdatadev','Case_Opportunity_Lookup_Update'

-- Opportunity Related Recruitment_Case__c Update
SELECT A.ID,C.ID AS Recruitment_Case__c 
INTO Opportunity_RecruitmentCase_Lookup_Update
FROM Opportunity_LOAD_Result A
LEFT JOIN
Case_Opp_Recruitment_LOAD_Result C
ON C.Legacy_ID__c = A.Legacy_ID__c
WHERE C.ID IS NOT NULL

EXEC SF_TableLoader 'Update:BULKAPI','edcdatadev','Opportunity_RecruitmentCase_Lookup_Update'



