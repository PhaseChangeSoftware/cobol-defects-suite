       
       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF45TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 45 DEFECT

      ******************************************************************
      ****   REFERENCING ERROR ENCOUNTERED WHEN PROGAM EXECUTED     ****
      ****   (CAUSED BY SECOND LINKAGE PARAMETER NOT REFERENCED)    ****
      ******************************************************************

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

       DATA DIVISION.

       FILE SECTION.

       WORKING-STORAGE SECTION.

       01  WS-RETURN-PARM-1            PIC X(08)  VALUE 'RETURN 1'.
       01  WS-RETURN-PARM-2            PIC X(08)  VALUE 'RETURN 2'

       LINKAGE SECTION.

       01  CALLER-PARM-1               PIC X(08).
       01  CALLER-PARM-2               PIC X(08).

      **** BEFORE CODE BEGINS (PROBLEM)
      *PROCEDURE DIVISION              USING CALLER-PARM-1.
      *                           [CALLER-PARM-2 NOT REFERENCED]
      **** BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
       PROCEDURE DIVISION              USING CALLER-PARM-1
                                             CALLER-PARM-2.
      **** AFTER CODE ENDS (CORRECT)

       1000-START-OF-JOB.

           DISPLAY 'DF45TEST START OF JOB' UPON CONSOLE.

       1000-POST-RETURN-PARMS.

           MOVE WS-RETURN-PARM-1       TO CALLER-PARM-1.
           MOVE WS-RETURN-PARM-2       TO CALLER-PARM-2.

       1000-END-OF-JOB.

           DISPLAY 'DF45TEST END OF JOB' UPON CONSOLE.

           GOBACK.
