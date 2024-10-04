/***** Replicate *****/
USE edcuat;


EXEC SF_Replicate 'EDCUAT','Profile','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCUAT','Recordtype','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCUAT','LearningProgram','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCUAT','Contact','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCUAT','Account','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCUAT','Case','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCUAT','User','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCUAT','Opportunity','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCUAT','Learning','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCUAT','LearningCourse','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCUAT','LearningProgramPlan','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCUAT','LearnerProgram','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCUAT','LearningProgram','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCUAT','IndividualApplication','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCUAT','AcademicTerm','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCUAT','Opportunity','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCUAT','CourseOffering','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCUAT','cfg_subscription__c','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCUAT','cfg_Subscription_Member__c','pkchunk,batchsize(50000)'