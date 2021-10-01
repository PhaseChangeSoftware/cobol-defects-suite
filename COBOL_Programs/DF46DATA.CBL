       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF46DATA.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 46 TEST DATA

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

           SELECT OUTPUT-FILE      ASSIGN TO DF46FILE
                                   FILE STATUS IS OUTPUT-STATUS.

       DATA DIVISION.

       FILE SECTION.

       FD  OUTPUT-FILE
           RECORDING MODE IS F
           RECORD CONTAINS 80 CHARACTERS
           DATA RECORD IS OUTPUT-RECORD.

       01  OUTPUT-RECORD               PIC X(80).

       WORKING-STORAGE SECTION.

       01  OUTPUT-STATUS               PIC X(02) VALUE SPACES.

       01  WS-DF46-RECORD              PIC X(80) VALUE 'DF46 RECORD'.

       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF46DATA START OF JOB' UPON CONSOLE.

       1000-OPEN-OUTPUT-FILE.

           OPEN OUTPUT OUTPUT-FILE.

           IF OUTPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF46DATA OPEN ERROR' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.

       1000-WRITE-OUTPUT-RECORD.

           WRITE OUTPUT-RECORD         FROM WS-DF46-RECORD.

           IF OUTPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF46DATA WRITE ERROR 1' UPON CONSOLE
               GO TO 1000-END-OF-JOB.

       1000-CLOSE-OUTPUT-FILE.

           CLOSE OUTPUT-FILE.

           IF OUTPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF46DATA CLOSE ERROR' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.

       1000-END-OF-JOB.

           DISPLAY 'DF46DATA END OF JOB' UPON CONSOLE.

           GOBACK.

