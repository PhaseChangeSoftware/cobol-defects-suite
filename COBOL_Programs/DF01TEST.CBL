       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF01TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 01 DEFECT

      ******************************************************************
      ****     INNER IF STATEMENT GOING TO OUTER IF STATEMENT       ****
      ****     (CAUSED BY END OF FILE CHECK IN READ STATEMENT)      ****
      ******************************************************************

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

           SELECT INPUT-FILE      ASSIGN TO DF01FILE
                                  FILE STATUS IS INPUT-STATUS.

       DATA DIVISION.

       FILE SECTION.

       FD  INPUT-FILE
           RECORDING MODE IS F
           RECORD CONTAINS 80 CHARACTERS
           DATA RECORD IS INPUT-RECORD.

       01  INPUT-RECORD                 PIC X(80).

       WORKING-STORAGE SECTION.

       01  WS-INPUT-FLAG                PIC X(01) VALUE SPACE.

           88 INPUT-EOF                 VALUE 'Y'.

       01  INPUT-STATUS                 PIC X(02) VALUE SPACES.

       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF01TEST START OF JOB' UPON CONSOLE.

       1000-OPEN-INPUT-FILE.

           OPEN INPUT INPUT-FILE.

           IF INPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF01TEST OPEN ERROR' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.

       1000-READ-INPUT-FILE.

      **** BEFORE CODE BEGINS (PROBLEM)
      **** READ INPUT-FILE
      ****     AT END
      ****         SET INPUT-EOF TO TRUE
      ****         IF INPUT-EOF      [ONLY CHECKED AT END OF FILE]
      ****             GO TO 1000-CLOSE-INPUT-FILE
      ****         END-IF.
      **** BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
           READ INPUT-FILE
               AT END
                   GO TO 1000-CLOSE-INPUT-FILE.
      **** AFTER CODE ENDS (CORRECT)

           IF INPUT-STATUS = '00'
               NEXT SENTENCE
           ELSE
               DISPLAY 'DF01TEST READ ERROR' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.
           
           DISPLAY 'DF01TEST INPUT RECORD = ' INPUT-RECORD
                                              UPON CONSOLE.

           GO TO 1000-READ-INPUT-FILE.

       1000-CLOSE-INPUT-FILE.

            CLOSE INPUT-FILE.

            IF INPUT-STATUS = '00'
               NEXT SENTENCE
            ELSE
               DISPLAY 'DF01TEST CLOSE ERROR' UPON CONSOLE
               GO TO 1000-END-OF-JOB
           END-IF.

       1000-END-OF-JOB.

           DISPLAY 'DF01TEST END OF JOB' UPON CONSOLE.

           GOBACK.
