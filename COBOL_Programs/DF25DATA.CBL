       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF25DATA.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 22 TEST DATA

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

           SELECT OUTPUT-FILE      ASSIGN TO DF25FIL1
                                   FILE STATUS IS OUTPUT-STATUS.

       DATA DIVISION.

       FILE SECTION.

       FD  OUTPUT-FILE
           RECORD IS VARYING IN SIZE
           FROM 20 TO 80 CHARACTERS
           DEPENDING ON WS-OUTPUT-RECSIZE
           DATA RECORD IS OUTPUT-RECORD.

       01  OUTPUT-RECORD.

           05  OUTPUT-RECORD-DATA      PIC X(01)
                                       OCCURS 20 TO 80 TIMES
                                       DEPENDING ON WS-OUTPUT-RECSIZE.

       WORKING-STORAGE SECTION.

       01  OUTPUT-STATUS               PIC X(02) VALUE SPACES.
       01  WS-OUTPUT-RECSIZE           PIC 9(08) VALUE ZERO COMP.

       01  WS-DF25-RECORD-1            PIC X(20) VALUE 'DF25 RECORD 1'.
       01  WS-DF25-RECORD-2            PIC X(40) VALUE 'DF25 RECORD 2'.
       01  WS-DF25-RECORD-3            PIC X(60) VALUE 'DF25 RECORD 3'.
       01  WS-DF25-RECORD-4            PIC X(80) VALUE 'DF25 RECORD 4'.

       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF25DATA START OF JOB' UPON CONSOLE.

       1000-OPEN-OUTPUT-FILE.

           OPEN OUTPUT OUTPUT-FILE.

           IF OUTPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF25DATA OPEN ERROR' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.

       1000-WRITE-OUTPUT-RECORDS.

           MOVE 20                     TO WS-OUTPUT-RECSIZE
           WRITE OUTPUT-RECORD         FROM WS-DF25-RECORD-1.

           IF OUTPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF25DATA WRITE ERROR 1' UPON CONSOLE
               GO TO 1000-END-OF-JOB.

           MOVE 40                     TO WS-OUTPUT-RECSIZE
           WRITE OUTPUT-RECORD         FROM WS-DF25-RECORD-2.

           IF OUTPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF25DATA WRITE ERROR 2' UPON CONSOLE
               GO TO 1000-END-OF-JOB.

           MOVE 60                     TO WS-OUTPUT-RECSIZE
           WRITE OUTPUT-RECORD         FROM WS-DF25-RECORD-3.

           IF OUTPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF25DATA WRITE ERROR 3' UPON CONSOLE
               GO TO 1000-END-OF-JOB.

           MOVE 80                     TO WS-OUTPUT-RECSIZE
           WRITE OUTPUT-RECORD         FROM WS-DF25-RECORD-4.

           IF OUTPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF25DATA WRITE ERROR 4' UPON CONSOLE
               GO TO 1000-END-OF-JOB.

       1000-CLOSE-OUTPUT-FILE.

           CLOSE OUTPUT-FILE.

           IF OUTPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF25DATA CLOSE ERROR' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.

       1000-END-OF-JOB.

           DISPLAY 'DF25DATA END OF JOB' UPON CONSOLE.

           GOBACK.
