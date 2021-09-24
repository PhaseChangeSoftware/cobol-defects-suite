       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF29TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 29 DEFECT

      ******************************************************************
      ****    PROBLEM WITH INVALID DATE WRITTEN TO TRAILER RECORD   ****
      ****    (CAUSE COULD NOT BE REPLICATED -- OLDER COMPILER?)    ****
      ****    (NOTE: CODE CHANGES NOT NEEDED TO RESOLVE DEFECT)     ****
      ******************************************************************

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

           SELECT OUTPUT-FILE      ASSIGN TO DF29FILE
                                   FILE STATUS IS OUTPUT-STATUS.

       DATA DIVISION.

       FILE SECTION.

       FD  OUTPUT-FILE
           RECORD CONTAINS 80 CHARACTERS
           DATA RECORD IS OUTPUT-RECORD.

       01  OUTPUT-RECORD               PIC X(80).

       WORKING-STORAGE SECTION.

       01  OUTPUT-STATUS               PIC X(02)   VALUE SPACES.

       01  WS-SYSTEM-DATE.
           05  WS-DATE-YYYY            PIC 9(04)   VALUE 2021.
           05  FILLER                  PIC X(01)   VALUE SPACES.
           05  WS-DATE-MM              PIC 9(02)   VALUE 09.
           05  FILLER                  PIC X(01)   VALUE SPACES.
           05  WS-DATE-DD              PIC 9(02)   VALUE 01.

       01  WS-TRAILER-RECORD.

           05  WS-SOURCE-MF            PIC X(02)   VALUE 'MF'.
           05  FILLER                  PIC X(01)   VALUE ','.
           05  WS-SOURCE-PTS           PIC X(3)    VALUE 'PTS'.
           05  FILLER                  PIC X(01)   VALUE ','.
           05  WS-TRAILER-DATE.
               10  WS-DATE-YYYY        PIC 9(04)   VALUE ZERO.
               10  FILLER              PIC X(01)   VALUE '-'.
               10  WS-DATE-MM          PIC 9(02)   VALUE ZERO.
               10  FILLER              PIC X(01)   VALUE '-'.
               10  WS-DATE-DD          PIC 9(02)   VALUE ZERO.
           05  FILLER                  PIC X(63)   VALUE SPACES

       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF29TEST START OF JOB' UPON CONSOLE.

       1000-OPEN-OUTPUT-FILE.

           OPEN OUTPUT OUTPUT-FILE.

           IF OUTPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF29TEST OPEN ERROR' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.

       1000-POST-TRAILER-DATE.

           MOVE CORR WS-SYSTEM-DATE    TO WS-TRAILER-DATE.

       1000-WRITE-OUTPUT-RECORD.

           WRITE OUTPUT-RECORD         FROM WS-TRAILER-RECORD.

           IF OUTPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF29TEST WRITE ERROR' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.
           
           DISPLAY 'DF29TEST TRAILER DATE = ' WS-TRAILER-DATE
                                              UPON CONSOLE.
           
        1000-CLOSE-OUTPUT-FILE.

           CLOSE OUTPUT-FILE.

           IF OUTPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF29TEST CLOSE ERROR' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.

       1000-END-OF-JOB.

           DISPLAY 'DF29TEST END OF JOB' UPON CONSOLE.

           GOBACK.
