       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF18CALL.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 18 CALL PARMS

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

       DATA DIVISION.

       FILE SECTION.

       WORKING-STORAGE SECTION.

       01  WS-ADDRESS                  PIC 9(04)  VALUE 1001   COMP.
       01  WS-VARIABLE                 PIC X(08)  VALUE 'LENGTH 8'.
       
       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF18CALL START OF JOB' UPON CONSOLE.

       1000-DISPLAY-CALLER-PARMS.
           
            DISPLAY 'DF18CALL WS-ADDRESS = ' WS-ADDRESS
                                             UPON CONSOLE.
           
           DISPLAY 'DF18CALL WS-VARIABLE = ' WS-VARIABLE
                                             UPON CONSOLE.
       1000-CALL-DF18TEST.

           CALL 'DF18TEST'       USING WS-ADDRESS
                                       WS-VARIABLE.

        1000-DISPLAY-RETURN-PARMS.
           
           DISPLAY 'DF18CALL WS-ADDRESS = '  WS-ADDRESS
                                             UPON CONSOLE.
           
       1000-END-OF-JOB.

           DISPLAY 'DF18CALL END OF JOB' UPON CONSOLE.

           GOBACK.
