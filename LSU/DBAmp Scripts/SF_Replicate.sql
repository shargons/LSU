

/********************** EDAPROD ***************************/
EXEC SF_Replicate 'EDAPROD','hed__Affiliation__c','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDAPROD','hed__Term__c','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDAPROD','Case','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDAPROD','Opportunity','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDAPROD','application__c','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDAPROD','Interaction__c','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDAPROD','required_document__c','pkchunk,batchsize(50000)'


EXEC SF_Replicate 'EDCDATADEV','Account','pkchunk,batchsize(50000)'