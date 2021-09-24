       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF22TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 22 DEFECT

      ******************************************************************
      ****    SOC-4 ABEND WHEN READING VARIABLE-LENGTH RECORDS      ****
      ****   (CAUSED BY NOT READING RECORDS INTO WORKING STORAGE)   ****
      ******************************************************************
       
       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

           SELECT INPUT-FILE       ASSIGN TO DF22FILE
                                   FILE STATUS IS WS-INPUT-STATUS.

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
                                     
       WORKING-STORAGE SECTION.

       01  WS-INPUT-STATUS             PIC X(02) VALUE SPACES.
       01  WS-INPUT-RECSIZE            PIC 9(08) VALUE ZERO COMP.
       01  WS-INPUT-RECORD             PIC X(80) VALUE SPACES.

       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF22TEST START OF JOB' UPON CONSOLE.

       1000-OPEN-INPUT-FILE.

           OPEN INPUT INPUT-FILE.

           IF WS-INPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF22TEST OPEN ERROR' UPON CONSOLE        
               GO TO 1000-END-OF-JOB
           END-IF.

       1000-READ-INPUT-FILE.

      **** BEFORE CODE BEGINS (PROBLEM)
      **** READ INPUT-FILE                     [INCORRECT READ FOR]
      ****     AT END                               [VARIABLE LENGTH]
      ****         GO TO 1000-CLOSE-INPUT-FILE.         [RECORDS]
      ****
      **** MOVE INPUT-RECORD-DATA (1:WS-INPUT-RECSIZE)     
      ****                             TO WS-INPUT-RECORD. 
      **** BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
           READ INPUT-FILE INTO WS-INPUT-RECORD
               AT END
                   GO TO 1000-CLOSE-INPUT-FILE.
      **** AFTER CODE ENDS (CORRECT)

            IF WS-INPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF22TEST READ ERROR' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.
           
           DISPLAY 'DF22TEST INPUT RECORD = ' INPUT-RECORD
                                               UPON CONSOLE.
           
           GO TO 1000-READ-INPUT-FILE.

       1000-CLOSE-INPUT-FILE.

           CLOSE INPUT-FILE.

           IF WS-INPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF22TEST CLOSE ERROR' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.

       1000-END-OF-JOB.

           DISPLAY 'DF22TEST END OF JOB' UPON CONSOLE.

           GOBACK.
