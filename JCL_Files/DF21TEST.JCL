//DF21TEST JOB 'DF21TEST',CLASS=A,MSGCLASS=X,TIME=1440,
//        COND=(8,LT),NOTIFY=MYUSERID,RESTART=*,LINES=(500,CANCEL)
//*  DF21TEST - RUN DF21TEST PROGRAM
//STEP1 EXEC PGM=DF21TEST
//DD1     DD DSN=DF21FIL1,DISP=SHR
//DD2     DD DSN=DF21FIL2,DISP=SHR
/*
/&
