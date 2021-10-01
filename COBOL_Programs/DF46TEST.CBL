       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF46TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 46 DEFECT

      ******************************************************************
      ****    PROGRAM LOGIC HAS OCCURRED WHEN REWRITING A RCORD     ****
      ****    (CAUSED BY USING WRITE WHEN REWRITE SHOULD BE USED)   ****
      ******************************************************************

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

           SELECT IN-OUT-FILE      ASSIGN TO DF46FILE
                                   FILE STATUS IS IN-OUT-STATUS.

       DATA DIVISION.

       FILE SECTION.

       FD  IN-OUT-FILE
           RECORDING MODE IS F
           RECORD CONTAINS 80 CHARACTERS
           DATA RECORD IS IN-OUT-RECORD.

       01  IN-OUT-RECORD               PIC X(80).

       WORKING-STORAGE SECTION.

       01  IN-OUT-STATUS               PIC X(02) VALUE SPACES.

       01  WS-IN-OUT-RECORD.

           05  WS-IN-OUT-HEADER        PIC X(13)   VALUE SPACES.
           05  WS-IN-OUT-DETAIL        PIC X(67)   VALUE SPACES.

       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF46TEST START OF JOB' UPON CONSOLE.

       1000-OPEN-IN-OUT-FILE.

           OPEN I-O IN-OUT-FILE.

           IF IN-OUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF46TEST OPEN ERROR' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.

       1000-READ-IN-OUT-FILE.

           READ IN-OUT-FILE INTO WS-IN-OUT-RECORD
               AT END
                   GO TO 1000-CLOSE-IN-OUT-FILE.

            IF IN-OUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF46TEST READ ERROR' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.
           
           DISPLAY 'DF46TEST INPUT RECORD = ' WS-IN-OUT-RECORD
                                              UPON CONSOLE.
           
           MOVE 'DF46 HEADER'          TO WS-IN-OUT-HEADER.

      **** BEFORE CODE BEGINS (PROBLEM)  [INCORRECT WRITE STATEMENT]
      **** WRITE IN-OUT-RECORD       FROM WS-IN-OUT-RECORD.
      **** BEFORE CODE ENDS (PROBLEM)    [INCORRECT WRITE STATEMENT]

       1000-REWRITE-IN-OUT-RECORD.

      **** AFTER CODE BEGINS (CORRECT)
           REWRITE IN-OUT-RECORD     FROM WS-IN-OUT-RECORD.
      **** AFTER CODE ENDS (CORRECT)

           IF IN-OUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF46TEST REWRITE ERROR 2' UPON CONSOLE
               GO TO 1000-END-OF-JOB.
               
               
           DISPLAY 'DF46TEST OUTPUT RECORD = ' IN-OUT-RECORD
                                               UPON CONSOLE.
           GO TO 1000-READ-IN-OUT-FILE.

       1000-CLOSE-IN-OUT-FILE.

           CLOSE IN-OUT-FILE.

           IF IN-OUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF46TEST CLOSE ERROR' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.

       1000-END-OF-JOB.

           DISPLAY 'DF46TEST END OF JOB' UPON CONSOLE.

           GOBACK.
