/***** Replicate *****/
USE edcuat;


EXEC SF_Replicate 'EDCUAT','Profile','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCUAT','Recordtype','pkchunk,batchsize(50000)'

EXEC SF_Replicate 'EDCUAT','LearningProgram','pkchunk,batchsize(50000)'



