       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF30TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 30 DEFECT

      ******************************************************************
      ****   COMPILATION ERROR - DFHB0020 DEFINED AS A DATA NAME    ****
      ****   (CAUSED BY PROGRAM COMMENT NOT STARTING IN COLUMN 7)   ****
      ******************************************************************

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

       DATA DIVISION.

       FILE SECTION.

       WORKING-STORAGE SECTION.

      **** BEFORE CODE BEGINS (PROBLEM)
      *    **************       [PROBLEM: COMMENT ASTERISK IN COLUMN 12]
      **** ABOVE COMMENT INSERTED IN ERROR BY PROGRAM DEVELOPER
      ******************************************************************
      **** BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
      ***************            [CORRECT: COMMENT ASTERISK IN COLUMN 7]
      **** ABOVE COMMENT INSERTED IN ERROR BY PROGRAM DEVELOPER
      ******************************************************************
      **** AFTER CODE ENDS (CORRECT)

       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF30TEST START OF JOB' UPON CONSOLE.

       1000-END-OF-JOB.

           DISPLAY 'DF30TEST END OF JOB' UPON CONSOLE.

           GOBACK.
