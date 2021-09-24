       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF07TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 07 DEFECT

      ******************************************************************
      ****     ERROR IN EVALUATE STATEMENT, IN PLACE OF NESTED IF   ****
      ****     (CAUSED BY INCORRECT CODING OF EVALUATE STATEMENT)   ****
      ******************************************************************

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

       DATA DIVISION.

       FILE SECTION.

       WORKING-STORAGE SECTION.

       01  WS-INPUT-FIELD              PIC 9(04)   VALUE 242.

           88 FUNC-SET                             VALUE 241 242
                                                         243 244.
           88 FUNC-IGEN                            VALUE 241 242.

       01  WS-OUTPUT-FIELD             PIC 9(04)   VALUE 9999.

       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF07TEST START OF JOB' UPON CONSOLE.

       1000-POST-SALES-AMOUNT.

      **** BEFORE CODE BEGINS (PROBLEM)
      **** IF FUNC-SET
      ****     EVALUATE WS-INPUT-FIELD  [INCORRECT EVALUATE] 
      ****     WHEN FUNC-IGEN
      ****         MOVE WS-INPUT-FIELD TO WS-OUTPUT-FIELD.
      **** BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
           IF FUNC-SET
              AND
              FUNC-IGEN
               MOVE WS-INPUT-FIELD     TO WS-OUTPUT-FIELD
           END-IF.
      **** AFTER CODE ENDS (CORRECT)
      
           DISPLAY 'DF07TEST OUTPUT FIELD = ' WS-OUTPUT-FIELD
                                              UPON CONSOLE.

       1000-END-OF-JOB.

           DISPLAY 'DF07TEST END OF JOB' UPON CONSOLE.

           GOBACK.
