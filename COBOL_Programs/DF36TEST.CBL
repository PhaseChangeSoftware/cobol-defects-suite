       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF36TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 36 DEFECT

      ******************************************************************
      ****   PROBLEM WITH COMPUTE STATEMENT NOT ROUNDED PROPERLY    ****
      ****   (CAUSE OF ROUNDING ERROR IS DIVIDE BEFORE MULTIPLY)    ****
     ******************************************************************

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

       DATA DIVISION.

       FILE SECTION.

       WORKING-STORAGE SECTION.

       01  WS-S1-VALUE             PIC S9(14)V99  VALUE 12024546.51.
       01  WS-S2-VALUE             PIC S9(14)V99  VALUE 11674330.16.
       01  WS-AVERAGE-RATE         PIC S9(03)V99  VALUE ZERO   COMP-3.

       PROCEDURE DIVISION.

       1000-START-OF-JOB. 

           DISPLAY 'DF36TEST START OF JOB' UPON CONSOLE.

       1000-COMPUTE-AVERAGE-RATE.

      **** BEFORE CODE BEGINS (PROBLEM)
      **** COMPUTE WS-AVERAGE-RATE ROUNDED = (WS-S1-VALUE
      ****     [DIVIDE AFTER MULTIPLY)     / (WS-S2-VALUE - 1.0)
      ****                                 * 100
      **** END-COMPUTE.
      **** BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
           COMPUTE WS-AVERAGE-RATE ROUNDED = (WS-S1-VALUE * 100)
                                           / (WS-S2-VALUE - 1.0)
           END-COMPUTE.
      **** AFTER CODE ENDS (CORRECT)

           DISPLAY 'DF36TEST AVERAGE RATE = ' WS-AVERAGE-RATE
                                              UPON CONSOLE.

       1000-END-OF-JOB.

           DISPLAY 'DF36TEST END OF JOB' UPON CONSOLE.

           GOBACK.
