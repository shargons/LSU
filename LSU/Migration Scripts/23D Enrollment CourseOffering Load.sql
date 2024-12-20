USE EDUCPROD;

--====================================================================
--	INSERTING DATA TO THE LOAD TABLE FROM THE VIEW -  Enrollment
--====================================================================


--DROP TABLE IF EXISTS [dbo].[CourseOffering_Enr_LOAD];
--GO
SELECT *
INTO [EDUCPROD].dbo.CourseOffering_Enr_LOAD
FROM [EDUCPROD].[dbo].[23D_Enr_CourseOffering] C
ORDER BY LearningCourseId



/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE CourseOffering_Enr_LOAD
ALTER COLUMN ID NVARCHAR(18)


SELECT * FROM CourseOffering_Enr_LOAD



--====================================================================
--INSERTING DATA USING DBAMP -   Enrollment
--====================================================================

EXEC SF_TableLoader 'Insert:BULKAPI','EDUCPROD','CourseOffering_Enr_LOAD_3'

SELECT *
--INTO CourseOffering_Enr_LOAD_3
FROM CourseOffering_Enr_LOAD_3_Result where Error <> 'Operation Successful.'
AND Error LIKE '%duplicate%'

select DISTINCT  Error from CourseOffering_Enr_LOAD_Result

--====================================================================
--ERROR RESOLUTION -   Enrollment
--====================================================================
/******* DBAmp Delete Script *********/
DROP TABLE CourseOffering_DELETE
DECLARE @_table_server	nvarchar(255)	=	DB_NAME()
EXECUTE sf_generate 'Delete',@_table_server, 'CourseOffering_DELETE'

INSERT INTO CourseOffering_DELETE(Id) SELECT Id FROM CourseOffering_Enr_LOAD_Result WHERE Error = 'Operation Successful.'

DECLARE @_table_server	nvarchar(255) = DB_NAME()
EXECUTE	SF_TableLoader
		@operation		=	'Delete'
,		@table_server	=	@_table_server
,		@table_name		=	'CourseOffering_DELETE_2'

drop table CourseOffering_DELETE_2
select * 
--INTO CourseOffering_DELETE_2
from CourseOffering_DELETE_Result
where error <> 'Operation Successful.'

--====================================================================
--POPULATING LOOKUP TABLES-   Enrollment
--====================================================================

--  Lookup
--DROP TABLE IF EXISTS [dbo].[CourseOffering_Enr_Lookup];
--GO

INSERT INTO CourseOffering_Enr_Lookup
SELECT
 ID
,EDACROFRNGID__c as Legacy_ID__C 
--INTO CourseOffering_Enr_Lookup
FROM CourseOffering_Enr_LOAD_3_Result
WHERE Error = 'Operation Successful.'

SELECT * FROM CourseOffering_Enr_Lookup

