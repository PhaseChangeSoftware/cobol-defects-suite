       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF34TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 34 DEFECT

      ******************************************************************
      ****   ISSUE IN COMPARING TWO SIGNED GROUP LEVEL VARIABLES    ****
      ****   (CAUSED BY NOT COMPARING AT FIELD LEVEL VARIABLES)     ****
      ******************************************************************

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

       DATA DIVISION.

       FILE SECTION.

       WORKING-STORAGE SECTION.

       01  WS-CONSTANT-1

           05  WS-CON-1                PIC S9(09)  VALUE 000000001.
           05  WS-CON-2                PIC S9(09)  VALUE 000000002.

       01  WS-CONSTANT-2

           05  WS-CON-3                PIC S9(09)  VALUE -000000001.
           05  WS-CON-4                PIC S9(09)  VALUE -000000002.

       01  VARIABLE-1.

           05 WS-VAR-1                 PIC S9(9) USAGE COMP.
           05 WS-VAR-2                 PIC S9(9) USAGE COMP.

       01  VARIABLE-2.

           05 WS-VAR-3                 PIC S9(9) USAGE COMP.
           05 WS-VAR-4                 PIC S9(9) USAGE COMP.

       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF34TEST START OF JOB' UPON CONSOLE.

       1000-POST-FIELDS.

           MOVE WS-CON-1               TO WS-VAR-1.
           MOVE WS-CON-2               TO WS-VAR-2.
           MOVE WS-CON-3               TO WS-VAR-3.
           MOVE WS-CON-4               TO WS-VAR-4.

       1000-COMPARE-FIELDS.

      **** BEFORE CODE BEGINS (PROBLEM)
      **** IF VARIABLE-1 < VARIABLE-2      [SHOULD COMPARE FIELD LEVELS]
      ****     DISPLAY 'DF34TEST GROUP LEVELS WORKED' UPON CONSOLE
      **** ELSE
      ****     DISPLAY 'DF34TEST GROUP LEVELS FAILED' UPON CONSOLE
      **** END-IF.
      **** BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
           IF (WS-VAR-1 < WS-VAR-3)
              AND
              (WS-VAR-2 < WS-VAR-4)
               DISPLAY 'DF34TEST FIELD LEVELS FAILED' UPON CONSOLE
           ELSE
               DISPLAY 'DF34TEST FIELD LEVELS WORKED' UPON CONSOLE
           END-IF.
      **** AFTER CODE ENDS (CORRECT)

       1000-END-OF-JOB.

           DISPLAY 'DF34TEST END OF JOB' UPON CONSOLE.

           GOBACK.
I