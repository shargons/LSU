SELECT A.* 
INTO Case_Recruitment_Rem_Load
FROM [dbo].[11_Case_Opp_Recruitment] A
LEFT JOIN
[Case] C
ON A.Legacy_ID__c = C.Legacy_ID__c
WHERE C.Id IS NULL

/******* Change ID Column to nvarchar(18) *********/
ALTER TABLE Case_Recruitment_Rem_Load
ALTER COLUMN ID NVARCHAR(18)

--====================================================================
--INSERTING DATA USING DBAMP - Case
--====================================================================

SELECT * FROM [Case_Recruitment_Rem_Lookup]

EXEC SF_TableLoader 'Upsert:BULKAPI','edcuat','Case_Recruitment_Rem_Load_3','Legacy_Id__c'

SELECT * 
INTO Case_Recruitment_Rem_Load_3
FROM Case_Recruitment_Rem_Load_2_Result
WHERE Error <> 'Operation Successful.'

UPDATE Case_Recruitment_Rem_Load_3
SET Program_of_Interest_List__c = null

INSERT INTO Case_Recruitment_Rem_Lookup
select * 
from Case_Recruitment_Rem_Load_3_Result
WHERE Error = 'Operation Successful.'

--====================================================================
-- UPDATE LOOKUPS - Case
--====================================================================

-- Recruitment Case Opportunity Update
SELECT A.Id,O.Id as Related_Opportunity__c
INTO Case_Rec_Opp_Link_Update_2
FROM [Case_Recruitment_Rem_Lookup] A
INNER JOIN
[edaprod].[dbo].[Opportunity] I
ON A.Legacy_Id__c = I.Id
--LEFT JOIN [edaprod].[dbo].[Opportunity] Op
--ON Op.Id = I.
LEFT JOIN
[Opportunity] O
ON O.Legacy_ID__c = I.Id

EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Case_Rec_Opp_Link_Update_2'


-- Retention Related Recruitment Case Lookup
SELECT A.Id,Rec.Id as Related_Recruitment_Case__c
INTO Case_Ret_RecCase_Link_Update
FROM [Case] A
INNER JOIN
[dbo].[14_EDA_Affiliations] I
ON A.Legacy_Id__c = I.Legacy_Id__c
LEFT JOIN [edaprod].[dbo].[Opportunity] O
ON O.Affiliation__c = I.legacy_ID__c
LEFT JOIN [Case] Rec
on O.Id = Rec.Legacy_ID__c
WHERE A.Related_Recruitment_Case__c IS NULL


EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Case_Ret_RecCase_Link_Update'

SELECT * FROM Case_Ret_RecCase_Link_Update_Result
WHERE Error <> 'Operation Successful.'

-- Recruitment Case Source RFI Lookup
SELECT Rec.Id,Rfi.Id as Source_RFI_Case__c
INTO Case_Rec_SourceRFI_Link_Update
FROM [Case] Rec
INNER JOIN [edaprod].[dbo].[Opportunity] O
ON O.Id = Rec.legacy_ID__c
LEFT JOIN 
[edaprod].[dbo].[Interaction__c] I
ON I.Opportunity__c = O.Id
LEFT JOIN
[Case] RFI
on 'I-'+I.Id = RFI.Legacy_ID__c
WHERE Rec.Source_RFI_Case__c IS NULL
and Rfi.Id is not null


EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Case_Rec_SourceRFI_Link_Update'

select * from Case_Rec_SourceRFI_Link_Update_Result where Error <> 'Operation Successful.'


-- Recruitment Case Source RFI Lookup
SELECT Ret.Id,Rfi.Id as Source_RFI_Case__c
--INTO Case_Ret_SourceRFI_Link_Update
FROM [Case] Ret
INNER JOIN [edaprod].[dbo].[hed__Affiliation__c] A
ON A.Id = Ret.legacy_ID__c
LEFT JOIN 
[edaprod].[dbo].[Interaction__c] I
ON I.Affiliation_ID__c = A.Id
LEFT JOIN
[Case] RFI
on 'I-'+I.Id = RFI.Legacy_ID__c
WHERE Ret.Source_RFI_Case__c IS NULL
and Rfi.Id is NOT null


EXEC SF_TableLoader 'Update:BULKAPI','edcuat','Case_Ret_SourceRFI_Link_Update'

