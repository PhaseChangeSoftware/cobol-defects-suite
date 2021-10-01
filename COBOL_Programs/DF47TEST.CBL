       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF47TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 47 DEFECT

      ******************************************************************
      ****     COMPILER ERROR WHEN USING SET STATEMENT TO FALSE     ****
      ****     (CAUSED BY SETTING FALSE NOT ALLOWED IN CONTEXT)     ****
      ******************************************************************

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

       DATA DIVISION.

       FILE SECTION.

       WORKING-STORAGE SECTION.

      **** BEFORE CODE BEGINS (PROBLEM)
      *01  WS-RECORD-FOUND-IND             PIC X(01)   VALUE SPACES.
      *    88  WS-RECORD-FOUND             VALUE 'Y'.
      ****BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
       01  WS-RECORD-FOUND-IND             PIC X(01)   VALUE SPACES.
           88  WS-RECORD-FOUND             VALUE 'Y'.
           88  WS-RECORD-NOT-FOUND         VALUE 'N'.
      **** AFTER CODE ENDS (CORRECT)

       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF47TEST START OF JOB' UPON CONSOLE.

       1000-SET-RECORD-INDICATOR.

      **** BEFORE CODE BEGINS (PROBLEM)
      **** SET WS-RECORD-FOUND         TO FALSE.   [INCORRECT STATEMENT]
      ****BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
           SET WS-RECORD-NOT-FOUND     TO TRUE.
      **** AFTER CODE ENDS (CORRECT)

           DISPLAY 'DF47TEST RECORD INDICATOR = ' WS-RECORD-FOUND-IND
                                                  UPON CONSOLE.

       1000-END-OF-JOB.

           DISPLAY 'DF47TEST END OF JOB' UPON CONSOLE.

           GOBACK.

