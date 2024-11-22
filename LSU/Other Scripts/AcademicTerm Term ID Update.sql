SELECT B.Id,A.TermId__c AS Term_ID__c
INTO AcademicTerm_TermID_Update
FROM hed__Term__c A
INNER JOIN
AcademicTerm B
ON A.ID = B.EDATERMID__c
WHERE A.TermId__c <> B.Term_ID__c
--WHERE TermId__c = 'SPRINGO12021'

select * from hed__Term__c
where TermId__c = '20252D'


EXEC SF_TableLoader 'Update:BULKAPI','edcuat','AcademicTerm_TermID_Update'