       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF44TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 44 DEFECT

      ******************************************************************
      ****     COMPILER ERROR STATING CHAR-COUNT IS MULTI-DEFINED   ****
      ****     (CAUSED BY NOT USING A QUALIFIER WHEN REFERENCING)  ****
      ******************************************************************

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

       DATA DIVISION.

       FILE SECTION.

       WORKING-STORAGE SECTION.

       01  WS-XXX-FIELD.

           05  CHAR-COUNT              PIC 9(09)   VALUE ZERO.

       01  WS-YYY-FIELD.

           05  CHAR-COUNT              PIC 9(09)   VALUE ZERO.

       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF44TEST START OF JOB' UPON CONSOLE.

       1000-CHECK-PARTS-MR-PLANT.

      **** BEFORE CODE BEGINS (PROBLEM)
      **** ADD 20                      TO CHAR-COUNT.    [NO QUALIFIER]
      **** ADD 40                      TO CHAR-COUNT.    [NO QUALIFIER0
      ****BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
           ADD 20                      TO CHAR-COUNT
                                       OF WS-XXX-FIELD.
           ADD 40                      TO CHAR-COUNT
                                       OF WS-YYY-FIELD.
      **** AFTER CODE ENDS (CORRECT)

           DISPLAY 'DF44TEST WS-XXX CHAR-COUNT = ' CHAR-COUNT
                                                OF WS-XXX-FIELD
                                                   UPON CONSOLE.

           DISPLAY 'DF44TEST WS-YYY CHAR-COUNT = ' CHAR-COUNT
                                                OF WS-YYY-FIELD
                                                   UPON CONSOLE.

       1000-END-OF-JOB.

           DISPLAY 'DF44TEST END OF JOB' UPON CONSOLE.

           GOBACK.
