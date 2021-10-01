       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF14TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 14 DEFECT

      ******************************************************************
      ****    UNDEFINED OR UNSTABLE HOST VARIABLE ERROR RETURNED    ****
      ****    (CAUSE OF DEFECT IS INCORRECT PICTURE DEFINITION)     ****
      ******************************************************************

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

       DATA DIVISION.

       FILE SECTION.

       WORKING-STORAGE SECTION.

      **** BEFORE CODE BEGINS (PROBLEM)
      *01 WS-RAND                      PIC S9(1)   VALUE ZERO.
      *                                [SHOULD BE PACKED FIELD]
      *01 WS-RAND-DISPLAY              PIC S9(1)   VALUE ZERO.
      **** BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
       01 WS-RAND                      PIC S9(1)   VALUE ZERO   COMP-3.
       01 WS-RAND-DISPLAY              PIC 9(1)    VALUE ZERO.
      **** AFTER CODE ENDS (CORRECT)

       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF14TEST START OF JOB' UPON CONSOLE.

       1000-START-OF-JOB.

           EXEC SQL
           SELECT DECIMAL(RAND() * 10)
           INTO :WS-RAND
           FROM SYSIBM.SYSDUMMY1
           END-EXEC.
      
           MOVE WS-RAND                TO WS-RAND-DISPLAY.
           
           DISPLAY 'DF14TEST RANDOM NUMBER = ' WS-RAND-DISPLAY
                                               UPON CONSOLE.
           
       1000-END-OF-JOB.

           DISPLAY 'DF14TEST END OF JOB' UPON CONSOLE.

           GOBACK.
