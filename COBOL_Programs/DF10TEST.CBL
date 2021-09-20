       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF10TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 10 DEFECT

      ******************************************************************
      ****   88 LEVEL RANGE PROBLEM NOT ALLOWING FOR ALL VALUES     ****
      ****   (CAUSED BY IMPROPER VALUE FOR 88 LEVEL DEFINITION)     ****
      ******************************************************************

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

       DATA DIVISION.

       FILE SECTION.

       WORKING-STORAGE SECTION.

      **** BEFORE CODE BEGINS (PROBLEM)
      *01  WS-INPUT-FIELD              PIC X(02)   VALUE '05'.
      *   88  WS-VALID-VALUE           VALUE '1'  [INVALID VALUE]
      *                                 THRU '10'
      **** BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
       01  WS-INPUT-FIELD              PIC X(02)   VALUE '05'.
          88  WS-VALID-VALUE                       VALUE '01' THRU '10'.
      **** AFTER CODE ENDS (CORRECT)
       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF10TEST START OF JOB' UPON CONSOLE.

       1000-VALIDATE-FIELD.

           IF WS-VALID-VALUE
               NEXT SENTENCE
           ELSE
              DISPLAY 'DF10TEST INVALID FIELD = ' WS-INPUT-FIELD
                                                  UPON CONSOLE
           END-IF.

       1000-END-OF-JOB.

           DISPLAY 'DF10TEST END OF JOB' UPON CONSOLE.

           GOBACK.
