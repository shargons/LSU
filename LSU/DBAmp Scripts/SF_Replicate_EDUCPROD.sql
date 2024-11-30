/***** Replicate *****/
USE EDUCPROD;

EXEC SF_Replicate 'EDUCPROD','UserRole','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDUCPROD','Profile','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDUCPROD','User','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDUCPROD','Recordtype','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDUCPROD','LearningProgram','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDUCPROD','Contact','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDUCPROD','Account','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDUCPROD','Lead','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDUCPROD','Case','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDUCPROD','Opportunity','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDUCPROD','Learning','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDUCPROD','LearningCourse','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDUCPROD','LearningProgramPlan','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDUCPROD','LearnerProgram','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDUCPROD','LearningProgramPlanRqmt','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDUCPROD','IndividualApplication','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDUCPROD','AcademicTerm','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDUCPROD','Opportunity','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDUCPROD','CourseOffering','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDUCPROD','CourseOfferingParticipant','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDUCPROD','cfg_subscription__c','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDUCPROD','cfg_Subscription_Member__c','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDUCPROD','EmailMessage','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDUCPROD','Chat_Transcript__c','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDUCPROD','DocumentChecklistItem','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDUCPROD','Financial_Aid__c','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDUCPROD','LearningAchievement','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDUCPROD','LearningProgramPlanRqmt','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDUCPROD','Task','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDUCPROD','EmailMessageRelation','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDUCPROD','AcademicTermEnrollment','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDUCPROD','InteractionSummary','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDUCPROD','ContentVersion','pkchunk,batchsize(50000)'