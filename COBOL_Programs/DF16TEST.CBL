       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF16TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 16 DEFECT

      ******************************************************************
      ****    UNDEFINED OR UNSTABLE HOST VARIABLE ERROR RETURNED   ****
      ****    (CAUSE OF DEFECT IS INCORRECT PICTURE DEFINITION)    ****
      ******************************************************************

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

       DATA DIVISION.

       FILE SECTION.

       WORKING-STORAGE SECTION.

      **** BEFORE CODE BEGINS (PROBLEM)
      *01 WS-RAND                      PIC 9(1)V   VALUE ZEROES.
      *                                  [INCORRECT PICTURE]
      *01 WS-RAND-DISP                 PIC S9(1)   VALUE ZEROES.
      **** BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
       01 WS-RAND                      PIC S9(1)  VALUE +9
                                                  USAGE COMP-3.
       01 WS-RAND-DISP                 PIC S9(1)  VALUE ZEROES.
      **** AFTER CODE ENDS (CORRECT)

       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF16TEST START OF JOB' UPON CONSOLE.

       1000-START-OF-JOB.

      **** BEFORE CODE BEGINS (PROBLEM)
      **** EXEC SQL
      **** SELECT DECIMAL(WS-RAND() * 10)
      **** INTO :WS-RAND
      **** FROM SYSIBM.SYSDUMMY1
      **** END-EXEC.
      **** BEFORE CODE ENDS(PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
      ******************************************************************
      ****    NO SQL DIRECIVES HAVE NOT BEEN SET IN DEVELOPER YET  ****
      ******************************************************************
      **** AFTER CODE ENDS (CORRECT)

           DISPLAY 'DF16TEST RANDOM NUMBER = ' WS-RAND
                                              UPON CONSOLE.

       1000-END-OF-JOB.

           DISPLAY 'DF16TEST END OF JOB' UPON CONSOLE.

           GOBACK.
