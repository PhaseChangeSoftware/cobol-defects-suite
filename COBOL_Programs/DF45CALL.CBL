       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF45CALL.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 45 CALL PARMS

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

       DATA DIVISION.

       FILE SECTION.

       WORKING-STORAGE SECTION.

       01  WS-CALLER-PARM-1            PIC X(08)  VALUE 'CALLER 1'.
       01  WS-CALLER-PARM-2            PIC X(08)  VALUE 'CALLER 2'.

       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF45CALL START OF JOB' UPON CONSOLE.

       1000-DISPLAY-CALLER-PARMS.

           DISPLAY 'DF45CALL CALLER PARM 1 = ' WS-CALLER-PARM-1
                                               UPON CONSOLE.
           DISPLAY 'DF45CALL CALLER PARM 2 = ' WS-CALLER-PARM-2
                                               UPON CONSOLE.

       1000-CALL-DF45TEST.

           CALL 'DF45TEST'             USING WS-CALLER-PARM-1
                                             WS-CALLER-PARM-2.

        1000-DISPLAY-RETURN-PARMS.

           DISPLAY 'DF45CALL RETURN PARM 1 = ' WS-CALLER-PARM-1
                                               UPON CONSOLE.
           DISPLAY 'DF45CALL RETURN PARM 2 = ' WS-CALLER-PARM-2
                                               UPON CONSOLE.

       1000-END-OF-JOB.

           DISPLAY 'DF45CALL END OF JOB' UPON CONSOLE.

           GOBACK.
