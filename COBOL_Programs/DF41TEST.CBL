       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF41TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 41 DEFECT

      ******************************************************************
      ****    ALPHANUMERIC FIELD NOT CONVERTED TO NUMERIC FIELD     ****
      ****    (CAUSED BY NOT USING FUNCTION NUMVAL CONVERSION)      ****
      ******************************************************************

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

       DATA DIVISION.

       FILE SECTION.

       WORKING-STORAGE SECTION.

       01  WS-ALPHA-FIELD              PIC X(09)    VALUE '123456789'
       01  WS-NUMERIC-FIELD            PIC 9(09)    VALUE ZERO.

       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF41TEST START OF JOB' UPON CONSOLE.

       1000-POST-NUMERIC-FIELD.

      **** BEFORE CODE BEGINS (PROBLEM)   [FIELD USAGE CONFLICT]
      **** MOVE WS-NUMERIC-FIELD       TO WS-NUMERIC-RESULT. 
      ***** BEFORE CODE ENDS (PROBLEM)    [FIELD USAGE CONFLICT]

      **** AFTER CODE BEGINS (CORRECT)
           COMPUTE WS-NUMERIC-FIELD = FUNCTION NUMVAL
                                      (WS-ALPHA-FIELD)
           END-COMPUTE.

           DISPLAY 'DF41TEST NUMERIC FIELD = ' WS-NUMERIC-FIELD
                                                  UPON CONSOLE.
      **** AFTER CODE ENDS (CORRECT)

       1000-END-OF-JOB.

           DISPLAY 'DF41TEST END OF JOB' UPON CONSOLE.

           GOBACK.
