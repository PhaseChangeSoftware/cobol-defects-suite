       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF40TEST. 

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 40 DEFECT

      ******************************************************************
      ****    PROGRAM ERROR WHEN FETCHING THE RECORDS FROM TABLE    ****
      ****   (CAUSED BY FAILURE TO OPEN CURSOR TO FETCH RECORDS)    ****
      ******************************************************************

       ENVIRONMENT DIVISION. 

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

       DATA DIVISION.

       FILE SECTION.

       WORKING-STORAGE SECTION.

       01  WS-STORE                    PIC X(10)   VALUE 'MAIN STORE'.
       01  WS-DEPARTMENT               PIC X(10)   VALUE 'COMPUTER'.
       
           EXEC SQL INCLUDE SQLCA END-EXEC.
           EXEC SQL INCLUDE DF40TABL END-EXEC.
           
       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF40TEST START OF JOB' UPON CONSOLE.

       1000-PROCESS-DF40-TABLE.
           
           INITIALIZE DF40-TABLE.

           MOVE WS-STORE               TO DF40-STORE.
           MOVE WS-DEPARTMENT          TO DF40-DEPARTMENT.
           
       1000-DECLARE-DF40-CURSOR.
           
           EXEC SQL DECLARE  DF40_CURSOR CURSOR FOR
                    SELECT   PRODUCT
                    FROM     DEFECTS.DF40.TABLE
                    WHERE    STORE        = :DF40-STORE
                      AND    DEPARTMENT   = :DF40-DEPARTMENT
                    ORDER BY PRODUCT
           END-EXEC.

      **** BEFORE CODE BEGINS (PROBLEM)
      ****  [FAILED TO OPEN CURSOR]
      **** BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
       1000-OPEN-DF40-CURSOR.

           EXEC SQL OPEN DF40_CURSOR END-EXEC.

           EVALUATE SQLCODE
               WHEN ZERO
                   CONTINUE
               WHEN OTHER
                   DISPLAY 'DF40TEST CURSOR OPEN ERROR = ' SQLCODE
                                                      UPON CONSOLE
                   GO TO 1000-END-OF-JOB
           END-EVALUATE.
      **** AFTER CODE ENDS (CORRECT)

       1000-FETCH-DF40-CURSOR.

           EXEC SQL FETCH DF40_CURSOR
                    INTO :DF40-PRODUCT
           END-EXEC.

           EVALUATE SQLCODE
               WHEN ZERO
                   CONTINUE
               WHEN +100
                   GO TO 1000-CLOSE-DF40-CURSOR
               WHEN OTHER
                   DISPLAY 'DF40TEST CURSOR FETCH ERROR = ' SQLCODE
                                                       UPON CONSOLE
                   GO TO 1000-END-OF-JOB
           END-EVALUATE.

           DISPLAY 'DF40TEST TABLE STORE = ' DF40-STORE
                                             UPON CONSOLE.

           DISPLAY 'DF40TEST TABLE DEPARTMENT = ' DF40-DEPARTMENT
                                                  UPON CONSOLE.

           DISPLAY 'DF40TEST TABLE PRODUCT = ' DF40-PRODUCT
                                               UPON CONSOLE.

           GO TO 1000-FETCH-DF40-CURSOR.

       1000-CLOSE-DF40-CURSOR.

           EXEC SQL CLOSE DF40_CURSOR END-EXEC.

           EVALUATE SQLCODE
               WHEN ZERO
                   CONTINUE
               WHEN OTHER
                   DISPLAY 'DF40TEST CURSOR CLOSE ERROR = ' SQLCODE
                                                       UPON CONSOLE
           END-EVALUATE.

       1000-END-OF-JOB.

           DISPLAY 'DF40TEST END OF JOB' UPON CONSOLE.

           GOBACK.
