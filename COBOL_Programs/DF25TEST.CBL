       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF25TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 25 DEFECT

      ******************************************************************
      ****     VARIABLE INITIALIZATION USING OUTPUT RECORD DATA     ****
      ****    (CAUSED BY OUTPUT RECORD DATA NO LONGER AVAILABLE)    ****
      ******************************************************************

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

           SELECT INPUT-FILE       ASSIGN TO DF25FIL1
                                   FILE STATUS IS WS-INPUT-STATUS.

           SELECT OUTPUT-FILE      ASSIGN TO DF25FIL2
                                   FILE STATUS IS WS-OUTPUT-STATUS.

       DATA DIVISION.

       FILE SECTION.

       FD  INPUT-FILE
           RECORD IS VARYING IN SIZE
           FROM 20 TO 80 CHARACTERS
           DEPENDING ON WS-INPUT-RECSIZE
           DATA RECORD IS INPUT-RECORD.

       01  INPUT-RECORD.

           05  INPUT-RECORD-DATA       PIC X(01)
                                       OCCURS 20 TO 80 TIMES
                                       DEPENDING ON WS-INPUT-RECSIZE.

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

       01  WS-INPUT-STATUS             PIC X(02) VALUE SPACES.
       01  WS-INPUT-RECSIZE            PIC 9(08) VALUE ZERO COMP.
       01  WS-INPUT-RECORD             PIC X(80) VALUE SPACES.

       01  WS-OUTPUT-STATUS            PIC X(02) VALUE SPACES.
       01  WS-OUTPUT-RECSIZE           PIC 9(08) VALUE ZERO COMP.
       01  WS-OUTPUT-RECORD            PIC X(80) VALUE SPACES.
       
       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF25TEST START OF JOB' UPON CONSOLE.

       1000-OPEN-INPUT-FILE.

           OPEN INPUT INPUT-FILE.

           IF WS-INPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF25TEST OPEN ERROR ON FILE 1' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.

       1000-OPEN-OUTPUT-FILE.

           OPEN OUTPUT OUTPUT-FILE.

           IF WS-OUTPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF25TEST OPEN ERROR ON FILE 2' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.

       1000-READ-INPUT-FILE.

      **** BEFORE CODE BEGINS (PROBLEM)
      **** READ INPUT-FILE                     [INCORRECT READ FOR]
      ****     AT END                             [VARIABLE LENGTH]
      ****         GO TO 1000-CLOSE-INPUT-FILE.     [RECORDS]
      **** BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
           READ INPUT-FILE INTO WS-INPUT-RECORD
               AT END
                   GO TO 1000-CLOSE-INPUT-FILE.
      **** AFTER CODE ENDS (CORRECT)

           IF WS-INPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF25TEST READ ERROR' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.

       1000-WRITE-OUTPUT-FILE.
      
      **** BEFORE CODE BEGINS (PROBLEM)    
      **** WRITE OUTPUT-RECORD      FROM INPUT-RECORD.
      **** MOVE OUTPUT-RECORD TO ....    [OUTPUT RECORD NOT AVAILABLE]
      **** BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
           MOVE WS-INPUT-RECSIZE       TO WS-OUTPUT-RECSIZE.
           MOVE WS-INPUT-RECORD        TO WS-OUTPUT-RECORD.
           WRITE OUTPUT-RECORD       FROM WS-OUTPUT-RECORD.

           IF WS-OUTPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF25TEST WRITE ERROR' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.
      **** AFTER CODE ENDS (CORRECT)
      
           DISPLAY 'DF25TEST OUTPUT RECORD = ' WS-OUTPUT-RECORD
                                               UPON CONSOLE.
      
           GO TO 1000-READ-INPUT-FILE.

       1000-CLOSE-INPUT-FILE.

           CLOSE INPUT-FILE.

           IF WS-INPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF25TEST CLOSE ERROR ON FILE 1' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.

       1000-CLOSE-OUTPUT-FILE.

           CLOSE OUTPUT-FILE.

           IF WS-INPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF25TEST CLOSE ERROR ON FILE 2' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.

       1000-END-OF-JOB.

           DISPLAY 'DF25TEST END OF JOB' UPON CONSOLE.

           GOBACK.
