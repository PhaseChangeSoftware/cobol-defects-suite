       IDENTIFICATION DIVISION.
       
       PROGRAM-ID. DF19TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 19 DEFECT

      ******************************************************************
      ****     PROBLEM MOVING CHARACTER FIELD TO NUMERIC FIELD      ****
      ****    (CAUSE DUE TO CHARACTER INSTEAD OF NUMERIC FIELDS     ****
      ******************************************************************

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

       DATA DIVISION.

       FILE SECTION.

       WORKING-STORAGE SECTION.

       01  WS-INPUT-DUE-DATE           PIC X(19)     VALUE '2021 09 15'.

      **** BEFORE CODE BEGINS (PROBLEM)
      *01  WS-DUE-DATE-1                  [CHARACTER FIELD PICTURE]
      *    05 WS-YYYY-1                PIC X(04)     VALUE SPACES.
      *    05 FILLER                   PIC X(01)     VALUE SPACES.
      *    05 WS-MM-1                  PIC X(02)     VALUE SPACES.
      *    05 FILLER                   PIC X(01)     VALUE SPACES.
      *    05 WS-DD-1                  PIC X(02)     VALUE SPACES.
      *    05 FILLER                   PIC X(09)     VALUE SPACES.
      *01  WS-DUE-DATE-2.                  [CHARACTER FIELD PICTURE]
      *    05 WS-YYYY-2                PIC X(4)      VALUE SPACES.
      *    05 WS-MM-2                  PIC X(2)      VALUE SPACES.
      *    05 WS-DD-2                  PIC X(2)      VALUE SPACES.
      *01 WS-HOST-DUE-DATE             PIC S9(9)     VALUE ZERO  COMP.
      **** BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
       01  WS-DUE-DATE-1.
           05 WS-YYYY-1                PIC 9(04)     VALUE ZERO.
           05 FILLER                   PIC X(01)     VALUE SPACES.
           05 WS-MM-1                  PIC 9(02)     VALUE ZERO.
           05 FILLER                   PIC X(01)     VALUE SPACES.
           05 WS-DD-1                  PIC 9(02)     VALUE ZERO.
           05 FILLER                   PIC X(09)     VALUE SPACES.
       01  WS-DUE-DATE-2.
           05 WS-YYYY-2                PIC 9(4)      VALUE ZERO.
           05 WS-MM-2                  PIC 9(2)      VALUE ZERO.
           05 WS-DD-2                  PIC 9(2)      VALUE ZERO.
           05 WS-NULL-2                PIC 9(1)      VALUE ZERO.
       01 WS-HOST-DUE-DATE             PIC S9(9)     VALUE ZERO  COMP.
      **** AFTER CODE ENDS (CORRECT)

       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF19TEST START OF JOB' UPON CONSOLE.

       1000-FORMAT-HOST-DATE.
           
           MOVE WS-INPUT-DUE-DATE      TO WS-DUE-DATE-1.
           
      **** BEFORE CODE BEGINS (PROBLEM)
      **** MOVE WS-YYYY-1              TO WS-YYYY-2.
      **** MOVE WS-MM-1                TO WS-MM-2.  [CHARACTER FIELDS]
      **** MOVE WS-DD-1                TO WS-DD-2.  [ASSUMED NUMERIC]
      **** BEFORE CODE ENDS (PROBLEM)
           
      **** AFTER CODE BEGINS (CORRECT)
           IF WS-YYYY-1 NUMERIC
              AND
              WS-MM-1 NUMERIC
              AND
              WS-DD-1 NUMERIC
                MOVE WS-YYYY-1         TO WS-YYYY-2
                MOVE WS-MM-1           TO WS-MM-2
                MOVE WS-DD-1           TO WS-DD-2
                MOVE ZERO              TO WS-NULL-2
                MOVE WS-DUE-DATE-2     TO WS-HOST-DUE-DATE
           ELSE
                DISPLAY 'DF19TEST INVALID DATE' UPON CONSOLE
                GO TO 1000-END-OF-JOB
           END-IF.
      **** AFTER CODE ENDS (CORRECT)

       1000-END-OF-JOB.

           DISPLAY 'DF19TEST END OF JOB' UPON CONSOLE.

           GOBACK.
