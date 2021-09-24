        IDENTIFICATION DIVISION.

       PROGRAM-ID. DF03DATA.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 03 TEST DATA

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

           SELECT OUTPUT-FILE      ASSIGN TO DF03FILE
                                   ORGANIZATION IS INDEXED
                                   ACCESS IS SEQUENTIAL
                                   RECORD KEY IS OUTPUT-RECORD-KEY
                                   FILE STATUS IS OUTPUT-STATUS.

       DATA DIVISION.

       FILE SECTION.

       FD  OUTPUT-FILE
           RECORD CONTAINS 80 CHARACTERS
           DATA RECORD IS OUTPUT-RECORD.

       01  OUTPUT-RECORD.

           05 OUTPUT-RECORD-KEY         PIC X(13).
           05 OUTPUT-RECORD-DATA        PIC X(67).

       WORKING-STORAGE SECTION.

       01  OUTPUT-STATUS                PIC X(02) VALUE SPACES.

       01  WS-DF03-RECORD-1             PIC X(80) VALUE 'DF03 RECORD 1'.
       01  WS-DF03-RECORD-2             PIC X(80) VALUE 'DF03 RECORD 2'.
       01  WS-DF03-RECORD-3             PIC X(80) VALUE 'DF03 RECORD 3'.
       01  WS-DF03-RECORD-4             PIC X(80) VALUE 'DF03 RECORD 4'.
       01  WS-DF03-RECORD-5             PIC X(80) VALUE 'DF03 RECORD 5'.

       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF03DATA START OF JOB' UPON CONSOLE.

       1000-OPEN-OUTPUT-FILE.

           OPEN OUTPUT OUTPUT-FILE.

           IF OUTPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF03DATA OPEN ERROR' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.

       1000-WRITE-OUTPUT-RECORDS.

           WRITE OUTPUT-RECORD    FROM WS-DF03-RECORD-1.

           IF OUTPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF03DATA WRITE ERROR 1' UPON CONSOLE
               GO TO 1000-END-OF-JOB.

           WRITE OUTPUT-RECORD    FROM WS-DF03-RECORD-2.

           IF OUTPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF03DATA WRITE ERROR 2' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.

           WRITE OUTPUT-RECORD    FROM WS-DF03-RECORD-3.

           IF OUTPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF03DATA WRITE ERROR 3' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.

           WRITE OUTPUT-RECORD    FROM WS-DF03-RECORD-4.

           IF OUTPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF03DATA WRITE ERROR 4' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.

           WRITE OUTPUT-RECORD    FROM WS-DF03-RECORD-5.

           IF OUTPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF03DATA WRITE ERROR 5' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.

          1000-CLOSE-OUTPUT-FILE.

           CLOSE OUTPUT-FILE.

           IF OUTPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF03DATA CLOSE ERROR' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.

       1000-END-OF-JOB.

           DISPLAY 'DF03DATA END OF JOB' UPON CONSOLE.

           GOBACK.
