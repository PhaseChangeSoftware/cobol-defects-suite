       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF21TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 21 DEFECT

      ******************************************************************
      ****    ERROR IN WRITING RECORDS TO KSDS FILE (STATUS 92)     ****
      ****    (CAUSE DUE TO RECORD SIZE CONFLICT ON KSDS FILE)      ****
      ****    (NOTE: CHANGES WERE NOT NEEDED TO RESOLVE DEFECT)     ****
      ******************************************************************

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

           SELECT INPUT-FILE       ASSIGN TO DF21FIL1
                                   FILE STATUS IS INPUT-STATUS.

           SELECT OUTPUT-FILE      ASSIGN TO DF21FIL2
                                   ORGANIZATION IS INDEXED
                                   ACCESS IS SEQUENTIAL
                                   RECORD KEY IS OUTPUT-RECORD-KEY
                                   FILE STATUS IS OUTPUT-STATUS.

       DATA DIVISION.

       FILE SECTION.

       FD  INPUT-FILE
           RECORD CONTAINS 80 CHARACTERS
           DATA RECORD IS INPUT-RECORD.

       01  INPUT-RECORD                 PIC X(80).

       FD  OUTPUT-FILE
           RECORD CONTAINS 80 CHARACTERS
           DATA RECORD IS OUTPUT-RECORD.

       01  OUTPUT-RECORD.

           05 OUTPUT-RECORD-KEY         PIC X(13).
           05 OUTPUT-RECORD-DATA        PIC X(67).

       WORKING-STORAGE SECTION.

       01  INPUT-STATUS                 PIC X(02) VALUE SPACES.
       01  OUTPUT-STATUS                PIC X(02) VALUE SPACES.

       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF21TEST START OF JOB' UPON CONSOLE.

       1000-OPEN-DATA-FILES.

           OPEN INPUT INPUT-FILE.

           IF INPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF21TEST OPEN ERROR ON FILE 1' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.

           OPEN OUTPUT OUTPUT-FILE.

           IF OUTPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF03TEST OPEN ERROR ON FILE 2' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.

       1000-READ-INPUT-FILE.

           READ INPUT-FILE
               AT END
                   GO TO 1000-CLOSE-DATA-FILES.

           IF INPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF21TEST READ ERROR ON FILE 1' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.

       1000-WRITE-OUTPUT-RECORD.

           WRITE OUTPUT-RECORD         FROM INPUT-RECORD.

           IF OUTPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF21TEST WRITE ERROR ON FILE 2' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.

       1000-READ-NEXT-INPUT-RECORD.

           GO TO 1000-READ-INPUT-FILE.

       1000-CLOSE-DATA-FILES.

           CLOSE INPUT-FILE.

           IF INPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF21TEST CLOSE ERROR ON FILE 1' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.

           CLOSE OUTPUT-FILE.

           IF OUTPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF21TEST CLOSE ERROR ON FILE 2' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.

       1000-END-OF-JOB.

           DISPLAY 'DF21TEST END OF JOB' UPON CONSOLE.

           GOBACK.
