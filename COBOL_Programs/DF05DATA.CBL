       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF05DATA.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 05 TEST DATA

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

           SELECT OUTPUT-FILE      ASSIGN TO DF05FILE
                                   FILE STATUS IS OUTPUT-STATUS.

       DATA DIVISION.

       FILE SECTION.

       FD  OUTPUT-FILE
           RECORDING MODE IS F
           RECORD CONTAINS 80 CHARACTERS
           DATA RECORD IS OUTPUT-RECORD.

       01  OUTPUT-RECORD                PIC X(80).

       WORKING-STORAGE SECTION.

       01  OUTPUT-STATUS               PIC X(02) VALUE SPACES.

       01  WS-DF05-RECORD-1            PIC X(80) VALUE 'DF05 RECORD 1'.
       01  WS-DF05-RECORD-2            PIC X(80) VALUE 'DF05 RECORD 2'.
       01  WS-DF05-RECORD-3            PIC X(80) VALUE 'DF05 RECORD 3'.
       01  WS-DF05-RECORD-4            PIC X(80) VALUE 'DF05 RECORD 4'.
       01  WS-DF05-RECORD-5            PIC X(80) VALUE 'DF05 RECORD 5'.

       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF05DATA START OF JOB' UPON CONSOLE.

       1000-OPEN-OUTPUT-FILE.

           OPEN OUTPUT OUTPUT-FILE.

           IF OUTPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF05DATA OPEN ERROR' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.

       1000-WRITE-OUTPUT-RECORDS.

           WRITE OUTPUT-RECORD         FROM WS-DF05-RECORD-1.

           IF OUTPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF05DATA WRITE ERROR 1' UPON CONSOLE
               GO TO 1000-END-OF-JOB.

           WRITE OUTPUT-RECORD         FROM WS-DF05-RECORD-2.

           IF OUTPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF05DATA WRITE ERROR 2' UPON CONSOLE
               GO TO 1000-END-OF-JOB.

           WRITE OUTPUT-RECORD         FROM WS-DF05-RECORD-3.

           IF OUTPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF05DATA WRITE ERROR 3' UPON CONSOLE
               GO TO 1000-END-OF-JOB.
           
           WRITE OUTPUT-RECORD         FROM WS-DF05-RECORD-4.

           IF OUTPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF05DATA WRITE ERROR 4' UPON CONSOLE
               GO TO 1000-END-OF-JOB.

           WRITE OUTPUT-RECORD         FROM WS-DF05-RECORD-5.

           IF OUTPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF05DATA WRITE ERROR 5' UPON CONSOLE
               GO TO 1000-END-OF-JOB.

       1000-CLOSE-OUTPUT-FILE.

           CLOSE OUTPUT-FILE.

           IF OUTPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF05DATA CLOSE ERROR' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.

       1000-END-OF-JOB.

           DISPLAY 'DF05DATA END OF JOB' UPON CONSOLE.

           GOBACK.
