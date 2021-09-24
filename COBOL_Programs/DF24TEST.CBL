       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF24TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 24 DEFECT

      ******************************************************************
      ****   ERROR IN REDEFINITION OF A NUMERIC FIELD DATA FORMAT   ****
      ****   (CAUSED BY DEFINING PACKED FIELD AS NUMERIC FIELD)     ****
      ******************************************************************

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

       DATA DIVISION.

       FILE SECTION.

       WORKING-STORAGE SECTION.

       01  WS-INPUT-DATA.

           05  FILLER                  PIC X(50)       VALUE SPACES.
           05  WS-INPUT-FIELD          PIC 9(9)V9(2)   VALUE 100.00
                                                       COMP-3.

      **** BEFORE CODE BEGINS (PROBLEM)
      *01  WS-INPUT-DATA-R             REDEFINES WS-INPUT-DATA.
      *    05  FILLER                  PIC X(50).
      *    05  WS-CHECK-FIELD          PIC 9(9)V9(2).   [NOT COMP-3]
      **** BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
       01  WS-INPUT-DATA-R             REDEFINES WS-INPUT-DATA.
           05  FILLER                  PIC X(50).
           05  WS-CHECK-FIELD          PIC 9(09)V9(2)   COMP-3.
      **** AFTER CODE ENDS (CORRECT)
     
       01  WS-DISPLAY-FIELD            PIC 9(09)V9(2)   VALUE ZERO.
       
       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF24TEST START OF JOB' UPON CONSOLE.

       1000-CHECK-FOR-NUMERIC.

           IF WS-CHECK-FIELD NUMERIC
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF24TEST NUMERIC DATA ERROR' UPON CONSOLE
           END-IF.
           
           DISPLAY 'DF24TEST NUMERIC DATA = ' WS-CHECK-FIELD
                                              UPON CONSOLE.

       1000-END-OF-JOB.

           DISPLAY 'DF24TEST END OF JOB' UPON CONSOLE.

           GOBACK.
