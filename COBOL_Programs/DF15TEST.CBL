       IDENTIFICATION SECTION.

       PROGRAM-ID. DF15TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 15 DEFECT

      ******************************************************************
      ****    EROR CONVERTING GREGORIAN DATE TO INTEGER-OF-DATE     ****
      ****    (CAUSED BY SUB-LEVEL FIELDS UNDER GREGORIAN DATE)    ****
      ******************************************************************

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

       DATA DIVISION.

       FILE SECTION.

       WORKING-STORAGE SECTION.

      **** AFTER CODE BEGINS (PROBLEM)
      *01  WS-GREGORIAN-DATE.          [SUB-LEVELS NOT ALLOWED]
      *    05  WS-GREGORAIAN-YYYY      PIC 9(04)   VALUE ZERO.
      *    05  WS-GREGORAIAN-MM        PIC 9(02)   VALUE ZERO.
      *    05  WS-GREGORAIAN-DD        PIC 9(02)   VALUE ZERO.
      **** AFTER CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
       01  WS-GREGORIAN-DATE           PIC 9(08)   VALUE 20210915.
      **** AFTER CODE ENDS (CORRECT)

       01  WS-INTEGER-DATE-1           PIC S9(09)  VALUE ZERO
                                                   USAGE COMP.
       01  WS-INTEGER-DATE-2           PIC S9(09)  VALUE ZERO.

       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF15TEST START OF JOB' UPON CONSOLE.

       1000-COMPUTE-INTEGER-DATES.

           COMPUTE WS-INTEGER-DATE-1 = FUNCTION
                   INTEGER-OF-DATE (WS-GREGORIAN-DATE).
           
           COMPUTE WS-INTEGER-DATE-2 = FUNCTION
                   INTEGER-OF-DATE (WS-GREGORIAN-DATE).
           
           DISPLAY 'DF15TEST INTEGER DATE 2 = ' WS-INTEGER-DATE-2
                                                UPON CONSOLE.

       1000-END-OF-JOB.

           DISPLAY 'DF15TEST END OF JOB' UPON CONSOLE.

           GOBACK.
