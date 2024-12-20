

/********************** EDAPROD ***************************/
EXEC SF_Replicate 'EDAPROD','User','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDAPROD','Recordtype','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDAPROD','UserRole','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDAPROD','Account','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDAPROD','Contact','pkchunk,batchsize(50000)'

DROP TABLE edaprod.dbo.Contact
SELECT * 
INTO edaprod.dbo.Contact    --- SF_REPLICATE doesnt work with hed__course__c
FROM EDAPROD.CData.Salesforce.Contact


EXEC SF_Replicate 'EDAPROD','student__c','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDAPROD','hed__Affiliation__c','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDAPROD','hed__Term__c','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDAPROD','Case','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDAPROD','Opportunity','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDAPROD','application__c','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDAPROD','Interaction__c','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDAPROD','required_document__c','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDAPROD','financial_aid_record__c','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDAPROD','enrollment__c','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDAPROD','one_certificate_enrollment__c','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDAPROD','hed__Program_Plan__c','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDAPROD','hed__plan_requirement__c','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDAPROD','hed__course_offering__c','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDAPROD','EmailMessage','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDAPROD','cfg_subscription__c','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDAPROD','cfg_Subscription_Member__c','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDAPROD','LiveChatTranscript','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDAPROD','ContentVersion','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDAPROD','ContentDocument','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDAPROD','ContentDocumentLink','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDAPROD','ContentNote','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDAPROD','Task','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDAPROD','EmailMessageRelation','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDAPROD','hed__Course__c','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDAPROD','hed__course_offering__c','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDAPROD','hed__course_enrollment__c','pkchunk,batchsize(50000)'

--DROP TABLE edaprod.dbo.hed__Course__c
SELECT * 
INTO edaprod.dbo.hed__Course__c    --- SF_REPLICATE doesnt work with hed__course__c
FROM EDAPROD.CData.Salesforce.hed__Course__c

--DROP TABLE edaprod.dbo.hed__course_offering__c
SELECT * 
INTO edaprod.dbo.hed__course_offering__c    --- SF_REPLICATE doesnt work with hed__course_offering__c
FROM EDAPROD.CData.Salesforce.hed__course_offering__c

--DROP TABLE edaprod.dbo.hed__course_enrollment__c
SELECT * 
INTO edaprod.dbo.hed__course_enrollment__c    --- SF_REPLICATE doesnt work with hed__course_offering__c
FROM EDAPROD.CData.Salesforce.hed__course_enrollment__c

/********************** EDCDATADEV ***************************/

EXEC SF_Replicate 'EDCDATADEV','Recordtype','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCDATADEV','Account','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCDATADEV','User','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCDATADEV','Case','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCDATADEV','Opportunity','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCDATADEV','Contact','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCDATADEV','LearnerProgram','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCDATADEV','LearningProgram','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCDATADEV','LearningProgramPlan','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCDATADEV','Learning','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCDATADEV','LearningCourse','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCDATADEV','IndividualApplication','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCDATADEV','AcademicTerm','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCDATADEV','ProgramTermApplnTimeline','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCDATADEV','CourseOffering','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCDATADEV','cfg_subscription__c','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCDATADEV','EmailMessage','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCDATADEV','ContentNote','pkchunk,batchsize(50000)'