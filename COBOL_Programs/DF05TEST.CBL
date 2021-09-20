       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF05TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 05 DEFECT

      ******************************************************************
      ****     SYSTEM ERROR MESSAGE IN FASTSRT COMPILER OPTION      ****
      ****     (NOTE: SORT PROCEDURES REWRITTEN FOR STANDARDS)      ****
      ******************************************************************

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

           SELECT INPUT-FILE       ASSIGN TO DF05FILE
                                   FILE STATUS IS WS-INPUT-STATUS.

           SELECT SORT-FILE        ASSIGN TO DF05SORT.

       DATA DIVISION.

       FILE SECTION.

       FD  INPUT-FILE

           DATA RECORD IS INPUT-RECORD.

       01  INPUT-RECORD.

           05  INPUT-ID                PIC X(13).
           05  FILLER                  PIC X(67).

       SD  SORT-FILE

           DATA RECORD IS SORT-RECORD.

       01  SORT-RECORD.

           05  SORT-KEY                PIC X(13).
           05  FILLER                  PIC X(67).

       WORKING-STORAGE SECTION.

       01  WS-INPUT-STATUS             PIC X(02) VALUE SPACES.

       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF05TEST START OF JOB' UPON CONSOLE.

       1000-OPEN-INPUT-FILE.

           OPEN INPUT INPUT-FILE.

           IF WS-INPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF05TEST OPEN ERROR' UPON CONSOLE
               GO TO 5000-END-OF-JOB
           END-IF.

       1000-SORT-FILE-PROCEDURES.

      **** BEFORE CODE BEGINS (PROBLEM)
      **** SORT SORT-FILE              [NON-STANDARD SORT PROCEDURES]
      ****     ON ASCENDING KEY SORT-INPUT-ID
      ****     USING INPUT-FILE
      ****     GIVING OUTPUT-FILE      [FILE NOT NEEDED FOR TESTING]
      **** BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
           SORT SORT-FILE
               ON ASCENDING KEY SORT-KEY
                   INPUT  PROCEDURE 2000-RELEASE-SORT-RECORDS
                               THRU 2000-SORT-EXIT
                   OUTPUT PROCEDURE 3000-RETURN-SORT-RECORDS
                               THRU 3000-SORT-EXIT.
      **** AFTER CODE ENDS (CORRECT)

           GO TO 4000-CLOSE-INPUT-FILE.

       2000-RELEASE-SORT-RECORDS.

           READ INPUT-FILE
               AT END
                   GO TO 2000-SORT-EXIT.

            IF WS-INPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF05TEST READ ERROR' UPON CONSOLE
               GO TO 5000-END-OF-JOB
           END-IF.

           RELEASE SORT-RECORD          FROM INPUT-RECORD.

           GO TO 2000-RELEASE-SORT-RECORDS.

       2000-SORT-EXIT. EXIT.

       3000-RETURN-SORT-RECORDS.

           RETURN SORT-FILE
               AT END
                   GO TO 3000-SORT-EXIT.

      **** WRITE OUTPUT RECORD     [FILE NOT NEEDED FOR TESTING DEFECT]

           GO TO 3000-RETURN-SORT-RECORDS.

       3000-SORT-EXIT. EXIT.

       4000-CLOSE-INPUT-FILE.

           CLOSE INPUT-FILE.

           IF WS-INPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF05TEST CLOSE ERROR' UPON CONSOLE
               GO TO 5000-END-OF-JOB
           END-IF.

       5000-END-OF-JOB.

           DISPLAY 'DF05TEST END OF JOB' UPON CONSOLE.

           GOBACK.
