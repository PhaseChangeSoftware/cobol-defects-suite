       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF12TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 12 DEFECT

      ******************************************************************
      ****    ALPHANUMERIC FIELD NOT CONVERTD TO PACKED-DECIMAL     ****
      ****    (CAUSE OF DEFECT NOT KNOWN SINCE CODE NOT PROVIDED)   ****
      ******************************************************************

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

       DATA DIVISION.

       FILE SECTION.

       WORKING-STORAGE SECTION.

       01  WS-NUMERIC-FIELD-1          PIC X(11)   VALUE '-1234567.89'.
       01  WS-NUMERIC-FIELD-2          PIC X(11)   VALUE ' 1234'.
       01  WS-NUMERIC-FIELD-3          PIC X(11)   VALUE '-123.23'.
       01  WS-NUMERIC-FIELD-4          PIC X(11)   VALUE ' 1234567.89'.

       01  WS-NUMERIC-RESULT           PIC S9(07)V99 VALUE ZERO
                                                     USAGE COMP-3.
       01  WS-NUMERIC-DISPLAY          PIC S9(07)V99 VALUE ZERO.

       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF12TEST START OF JOB' UPON CONSOLE.

       1000-COMPUTE-NUMERIC-RESULT.

      **** BEFORE CODE BEGINS (PROBLEM)
      ******************************************************************
      ****   UNFORTUNATELY, PROGRAM DEFECT CODE WAS NOT PROVIDED    ****
      ******************************************************************
      **** BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
           COMPUTE WS-NUMERIC-RESULT = FUNCTION NUMVAL
                                       (WS-NUMERIC-FIELD-1)
           END-COMPUTE.
           
           DISPLAY 'DF12TEST NUMERIC RESULT 1 = ' WS-NUMERIC-RESULT
                                                  UPON CONSOLE.
          
           COMPUTE WS-NUMERIC-RESULT = FUNCTION NUMVAL
                                       (WS-NUMERIC-FIELD-2)
           END-COMPUTE.
           
           DISPLAY 'DF12TEST NUMERIC RESULT 2 = ' WS-NUMERIC-RESULT
                                                  UPON CONSOLE.
           
           COMPUTE WS-NUMERIC-RESULT = FUNCTION NUMVAL
                                       (WS-NUMERIC-FIELD-3)
           END-COMPUTE.
           
           DISPLAY 'DF12TEST NUMERIC RESULT 3 = ' WS-NUMERIC-RESULT
                                                  UPON CONSOLE.
          
           COMPUTE WS-NUMERIC-RESULT = FUNCTION NUMVAL
                                       (WS-NUMERIC-FIELD-4)
           END-COMPUTE.
           
           DISPLAY 'DF12TEST NUMERIC RESULT 4 = ' WS-NUMERIC-RESULT
                                                  UPON CONSOLE.
      **** AFTER CODE ENDS (CORRECT)

       1000-END-OF-JOB.

           DISPLAY 'DF12TEST END OF JOB' UPON CONSOLE.

           GOBACK.
