       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF13TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 13 DEFECT

      ******************************************************************
      ****    COMPILE ERROR WHEN VALUE CODED FOR OCCURS STATEMENT   ****
      ****    (CAUSE DUE TO VALUE NOT ALLOWED IN OCCURS STATEMENT)  ****
      ******************************************************************

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

       DATA DIVISION.

       FILE SECTION.

       WORKING-STORAGE SECTION.

       01  GRP-COUNT                   PIC 9(02)   VALUE ZERO.
       01  GRP-RESULT                  PIC X(12)   VALUE SPACES.

       01  GRP-PEPNOTES.

           05  GRP-PEPNOTE-1           PIC X(12)   VALUE '<PEPNOTE 1>'.
           05  GRP-PEPNOTE-2           PIC X(12)   VALUE '<PEPNOTE 2>'.
           05  GRP-PEPNOTE-3           PIC X(12)   VALUE '<PEPNOTE 3>'.
           05  GRP-PEPNOTE-4           PIC X(12)   VALUE '<PEPNOTE 4>'.
           05  GRP-PEPNOTE-5           PIC X(12)   VALUE '<PEPNOTE 5>'.

      **** BEFORE CODE BEGINS (PROBLEM)
      *01  GRP-PEPNOTES-R              REDEFINES GRP-PEPNOTES.
      *    05  GRP-PEPNOTE-ENTRY       OCCURS 5 TIMES.
      *                                DEPENDING ON GRP-COUNT.
      *        10  GRP-PEPNOTE-DATA    PIC X(12)
      *                                VALUE SPACES.  [NOT ALLOWED]
      **** BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
       01  GRP-PEPNOTES-R              REDEFINES GRP-PEPNOTES.
           05  GRP-PEPNOTE-ENTRY       OCCURS 5 TIMES.
               10  GRP-PEPNOTE-DATA    PIC X(12).
      **** BEFORE CODE ENDS (CORRECT)

       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF13TEST START OF JOB' UPON CONSOLE.

       1000-POST-PEP-NOTES.

           PERFORM 1000-LOOP-PEPNOTE THRU 1000-EXIT
               VARYING GRP-COUNT FROM 1 BY 1
                   UNTIL GRP-COUNT GREATER THAN 5.

           GO TO 1000-END-OF-JOB.

       1000-LOOP-PEPNOTE.

           MOVE GRP-PEPNOTE-DATA (GRP-COUNT) TO GRP-RESULT.

       1000-EXIT. EXIT.

       1000-END-OF-JOB.

           DISPLAY 'DF13TEST END OF JOB' UPON CONSOLE.

           GOBACK.
