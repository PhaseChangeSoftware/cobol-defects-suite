       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF11TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 11 DEFECT

      ******************************************************************
      ****    STRINGING OF FILE NAME ENCLOSED BY DOUBLE QUOTE (")   ****
      ****   (CAUSED BY IMPROPER USE OF QUOTE VALUE (") IN STRING)  ****
      ******************************************************************

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

       DATA DIVISION.

       FILE SECTION.

       WORKING-STORAGE SECTION.
       
       01  WS-USER-ID            PIC X(06)   VALUE 'USERID'.
       01  WS-USER-FILE          PIC X(12)   VALUE 'NAME OF FILE'.
       01  WS-USER-CHAR          PIC X(01)   VALUE '9'.
       01  WS-FILE-NAME          PIC X(32)   VALUE SPACES.

       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF11TEST START OF JOB' UPON CONSOLE.

       1000-STRING-FILE-NAME.

      **** BEFORE CODE BEGINS (PROBLEM)
      **** STRING '(' QUOTE WS-USER-ID '.'   [USE OF QUOTE]
      ****         WS-USER-FILE '.J'
      ****         WS-USER-CHAR '.CNTL' QUOTE ')' DELIMITED BY SIZE
      ****             INTO  WS-FILE-NAME  OF WS-SELECT-PARM-1
      **** END-STRING.
      **** BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
           STRING '(''' WS-USER-ID '.'
                  WS-USER-FILE '.J'
                  WS-USER-CHAR '.CNTL'')' DELIMITED BY SIZE
                       INTO  WS-FILE-NAME
           END-STRING.
      **** AFTER CODE ENDS (CORRECT)
      
           DISPLAY 'DF11TEST FILE NAME = ' WS-FILE-NAME
                                           UPON CONSOLE. 

           GOBACK.
