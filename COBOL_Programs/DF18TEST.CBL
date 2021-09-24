       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF18TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 18 DEFECT

      ******************************************************************
      ****   SET STATEMENT FOR WS-POINTER DISCARDED BY COMPILER     ****
      ****   (CAUSE OF DEFECT IS USAGE OF POINTER FOR WS-POINTER)   ****
      ****   (CAUSE OF DEFECT IS INVALID SET STATEMENTS (PENDING)   ****
      ******************************************************************

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

       DATA DIVISION.

       FILE SECTION.

       WORKING-STORAGE SECTION.
       
      **** BEFORE CODE BEGINS (PROBLEM)
      *01  WS-POINTER                  USAGE IS POINTER.
      *                                [INCORRECT USAGE OF POINTER]
      **** BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
       01  WS-POINTER                  PIC 9(08)   VALUE ZERO  COMP.
      **** AFTER CODE ENDS (CORRECT)

       LINKAGE SECTION.

       01  WS-ADDRESS                  USAGE IS POINTER.
       01  WS-VARIABLE                 PIC 9(08)   COMP.

       PROCEDURE DIVISION              USING WS-ADDRESS
                                             WS-VARIABLE.

       1000-START-OF-JOB.

           DISPLAY 'DF18TEST START OF JOB' UPON CONSOLE.

       1000-COMPUTE-POINTER.

      **** BEFORE CODE BEGINS (PROBLEM)
      **** SET ADDRESS OF WS-VARIABLE  TO WS-ADDRESS.
      **** SET WS-POINTER              TO WS-ADDRESS.   [INVALID SET]
      **** SET WS-POINTER UP BY LENGTH OF WS-VARIABLE.  [INVALID SET]
      **** BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
           SET ADDRESS OF WS-VARIABLE  TO WS-ADDRESS.
      **** SET WS-POINTER              TO WS-ADDRESS.    [PENDING SET] 
           ADD LENGTH  OF WS-VARIABLE  TO WS-POINTER.   
      **** MOVE WS-POINTER             TO WS-VARIABLE.
      **** AFTER CODE ENDS (CORRECT)

       1000-END-OF-JOB.

           DISPLAY 'DF18TEST END OF JOB' UPON CONSOLE.

           GOBACK.
