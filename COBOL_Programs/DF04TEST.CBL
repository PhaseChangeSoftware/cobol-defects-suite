        IDENTIFICATION DIVISION.

       PROGRAM-ID. DF04TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 04 DEFECT

      ******************************************************************
      ****    PROBLEM WITH MOVE STATEMENT TO RIGHT-ADJUST FIELD     ****
      ****    (CAUSED BY OVERLAPPING OF DATA AFTER DATA CHANGED)    ****
      ******************************************************************

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

       DATA DIVISION.

       FILE SECTION.

       WORKING-STORAGE SECTION.

      **** AFTER CODE BEGINS (ADDED)
       01  WS-I-CTL-1                   PIC X(04)  VALUE '18'.
       01  WS-I-CTL-2                   PIC X(04)  VALUE '100'.
       01  WS-I-CTL-3                   PIC X(04)  VALUE '694'.
       01  WS-I-CTL-4                   PIC X(04)  VALUE '000'.
      **** AFTER CODE ENDS (ADDED)

       01  WS-O-CTL-1                   PIC X(04)  VALUE SPACES.
       01  WS-O-CTL-2                   PIC X(04)  VALUE SPACES.
       01  WS-O-CTL-3                   PIC X(04)  VALUE SPACES.
       01  WS-O-CTL-4                   PIC X(04)  VALUE SPACES.

       PROCEDURE DIVISION.

       1000-START-OF-JOB. 

           DISPLAY 'DF04TEST START OF JOB' UPON CONSOLE.

       1000-RIGHT-ADUST-FIELD-DATA.

      **** BEFORE CODE BEGINS (PROBLEM)
      ****     MOVE WS-O-CTL-1 (1:2)   TO WS-O-CTL-1 (3:2).  [OVERLAP]
      ****     MOVE '00'               TO WS-O-CTL-1 (1:2).
      ****     MOVE WS-O-CTL-2 (1:3)   TO WS-O-CTL-2 (2:3).  [OVERLAP]
      ****     MOVE '0'                TO WS-O-CTL-2 (1:1).
      ****     MOVE WS-O-CTL-3 (1:3)   TO WS-O-CTL-3 (2:3).  [OVERLAP]
      ****     MOVE '0'                TO WS-O-CTL-3 (1:1).
      ****     MOVE '0000'             TO WS-O-CTL-4.
      **** BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
               MOVE '0000'             TO WS-O-CTL-1.
               MOVE WS-I-CTL-1 (1:1)   TO WS-O-CTL-1 (3:1).
               MOVE WS-I-CTL-1 (2:1)   TO WS-O-CTL-1 (4:1).
               MOVE '0000'             TO WS-O-CTL-2.
               MOVE WS-I-CTL-2 (1:1)   TO WS-O-CTL-2 (2:1).
               MOVE WS-I-CTL-2 (2:1)   TO WS-O-CTL-2 (3:1).
               MOVE WS-I-CTL-2 (3:1)   TO WS-O-CTL-2 (4:1).
               MOVE '0000'             TO WS-O-CTL-3.
               MOVE WS-I-CTL-3 (1:1)   TO WS-O-CTL-3 (2:1).
               MOVE WS-I-CTL-3 (2:1)   TO WS-O-CTL-3 (3:1).
               MOVE WS-I-CTL-3 (3:1)   TO WS-O-CTL-3 (4:1).
               MOVE '0000'             TO WS-O-CTL-4.
      **** AFTER CODE ENDS (CORRECT)

           DISPLAY 'DF04TEST CONTROL 1 = ' WS-O-CTL-1
                                           UPON CONSOLE.
           DISPLAY 'DF04TEST CONTROL 2 = ' WS-O-CTL-2
                                           UPON CONSOLE.
           DISPLAY 'DF04TEST CONTROL 3 = ' WS-O-CTL-3
                                           UPON CONSOLE.
           DISPLAY 'DF04TEST CONTROL 4 = ' WS-O-CTL-4
                                           UPON CONSOLE.
          
       1000-END-OF-JOB.

           DISPLAY 'DF04TEST END OF JOB' UPON CONSOLE.

           GOBACK.
