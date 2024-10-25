USE edcuat;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW - Certificate Enrollment
--====================================================================


--DROP TABLE IF EXISTS [dbo].[LearnerProgram_CertEnrol_LOAD];
--GO
SELECT *
INTO [edcuat].dbo.LearnerProgram_CertEnrol_LOAD
FROM [edcuat].[dbo].[18_EDA_CertificateEnrollments] C
ORDER BY Case__c,one_Student_Id__c

SELECT * FROM [edcuat].dbo.LearnerProgram_CertEnrol_LOAD

/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE LearnerProgram_CertEnrol_LOAD
ALTER COLUMN ID NVARCHAR(18)

--====================================================================
--INSERTING DATA USING DBAMP -  Certificate Enrollment
--====================================================================

SELECT * FROM LearnerProgram_CertEnrol_LOAD

EXEC SF_TableLoader 'Insert:BULKAPI','edcuat','LearnerProgram_CertEnrol_LOAD'

SELECT *
--INTO LearnerProgram_CertEnrol_LOAD_2
FROM LearnerProgram_CertEnrol_LOAD_Result where Error <> 'Operation Successful.'
ORDER BY Case__c,one_Student_Id__c

select DISTINCT  Error from LearnerProgram_CertEnrol_LOAD_Result

--====================================================================
--ERROR RESOLUTION -  Certificate Enrollment
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE LearnerProgram_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'LearnerProgram_DELETE'

INSERT INTO LearnerProgram_DELETE(Id) SELECT Id FROM LearnerProgram_CertEnrol_LOAD_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'LearnerProgram_DELETE'

--====================================================================
--POPULATING LOOKUP TABLES-  Certificate Enrollment
--====================================================================


--DROP TABLE IF EXISTS [dbo].[LearnerProgram_CertEnrol_Lookup];
--GO
INSERT INTO LearnerProgram_CertEnrol_Lookup
SELECT
 ID
,EDACERTENROLLID__c AS Legacy_ID__c
INTO LearnerProgram_CertEnrol_Lookup
FROM LearnerProgram_CertEnrol_LOAD_Result
WHERE Error = 'Operation Successful.'

SELECT * FROM LearnerProgram_CertEnrol_Lookup





SELECT Id,ParentLearnerProgramId,OpportunityId
--INTO LearnerProgram_CertEnrol_Update
FROM LearnerProgram_CertEnrol_LOAD_Result

EXEC SF_TableLoader 'Update:BULKAPI2','edcuat','LearnerProgram_CertEnrol_Update'