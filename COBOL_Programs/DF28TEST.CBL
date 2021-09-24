       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF28TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 28 DEFECT

      ******************************************************************
      ****    ALPHANUMERIC FIELD NOT CONVERTED TO NUMERIC FIELD     ****
      ****    (CAUSE COULD NOT BE REPLICATED -- OLDER COMPILER?)    ****
      ******************************************************************

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

       DATA DIVISION.

       FILE SECTION.

       WORKING-STORAGE SECTION.

       01  WS-NUMERIC-FIELD            PIC X(07)      VALUE '+400.00'.
       01  WS-NUMERIC-RESULT           PIC S9(03)V99  VALUE ZERO.
       
       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF28TEST START OF JOB' UPON CONSOLE.

       1000-COMPUTE-NUMERIC-RESULT.

      **** BEFORE CODE BEGINS (PROBLEM)
      ******************************************************************
      **** COMPUTE WS-NUMERIC-RESULT = FUNCTION NUMVAL
      ****                             (WS-NUMERIC-FIELD).
      ****
      **** IF WS-NUMERIC-RESULT NUMERIC  [FUNCTION NUMVAL NOT WORKING]
      ****     NEXT SENTENCE
      **** ELSE
      ****     DISPLAY 'DF28TEST NOT NUMERIC' UPON CONSOLE
      ****     GO TO 1000-END-OF-JOB.
      ******************************************************************
      **** BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
           COMPUTE WS-NUMERIC-RESULT = FUNCTION NUMVAL
                                       (WS-NUMERIC-FIELD)
           END-COMPUTE.

           IF WS-NUMERIC-RESULT NUMERIC
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF28TEST NOT NUMERIC' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.
      **** AFTER CODE ENDS (CORRECT)

           DISPLAY 'DF28TEST NUMERIC RESULT = ' WS-NUMERIC-RESULT 
                                                UPON CONSOLE.
           
       1000-END-OF-JOB.    

           DISPLAY 'DF28TEST END OF JOB' UPON CONSOLE.

           GOBACK.
