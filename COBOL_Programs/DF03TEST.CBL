       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF03TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 03 DEFECT

      ******************************************************************
      ****     ERROR IN IN READING DATA RECORDS FROM VSAM FILE      ****
      ****     (CAUSED BY INVALID "NOT EQUAL" VSAM STATUS CHECK)    ****
      ******************************************************************

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

           SELECT INPUT-FILE       ASSIGN TO DF03FILE
                                   ORGANIZATION IS INDEXED
                                   ACCESS IS SEQUENTIAL
                                   RECORD KEY IS INPUT-RECORD-KEY
                                   FILE STATUS IS INPUT-STATUS.

       DATA DIVISION.

       FILE SECTION.

       FD  INPUT-FILE
           RECORD CONTAINS 80 CHARACTERS
           DATA RECORD IS INPUT-RECORD.

       01  INPUT-RECORD.

           05 INPUT-RECORD-KEY          PIC X(13).
           05 INPUT-RECORD-DATA         PIC X(67).

       WORKING-STORAGE SECTION.

       01  INPUT-STATUS                 PIC X(02) VALUE SPACES.

       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF03TEST START OF JOB' UPON CONSOLE.

       1000-OPEN-INPUT-FILE.

           OPEN INPUT INPUT-FILE.

           IF INPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF03TEST OPEN ERROR' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.

       1000-READ-INPUT-RECORD.

           READ INPUT-FILE.

      **** BEFORE CODE BEGINS (PROBLEM)
      **** IF INPUT-STATUS NOT = '00' OR '10' [INVALID NOT EQUAL]
      ****     DISPLAY 'DF03TEST READ ERROR' UPON CONSOLE
      ****     GO TO 1000-END-OF-JOB
      **** END-IF.
      **** BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
           IF INPUT-STATUS = '00'
               GO TO 1000-PROCESS-INPUT-RECORD
           ELSE
           IF INPUT-STATUS = '10'
               GO TO 1000-CLOSE-INPUT-FILE
           ELSE
               DISPLAY 'DF03TEST READ ERROR' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.
      **** AFTER CODE ENDS (CORRECT)

       1000-PROCESS-INPUT-RECORD.

      **** ADD CODE TO PROCESS INPUT RECORD (IF NEEDED)

       1000-READ-NEXT-INPUT-RECORD.

           GO TO 1000-READ-INPUT-RECORD.

       1000-CLOSE-INPUT-FILE.

           CLOSE INPUT-FILE.

           IF INPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF03TEST CLOSE ERROR' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.

       1000-END-OF-JOB.

           DISPLAY 'DF03TEST END OF JOB' UPON CONSOLE.

           GOBACK.
