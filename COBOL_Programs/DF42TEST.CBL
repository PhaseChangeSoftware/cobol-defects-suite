        IDENTIFICATION DIVISION.

       PROGRAM-ID. DF42TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 42 DEFECT

      ******************************************************************
      ****   ERROR USING CURSOR LOOPING WHICH IS NOT RECOMMENDED    ****
      ****   (CAUSED BY CHECKING SQLSTATE INSTEAD OF CURSOR END)    ****
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
           EXEC SQL INCLUDE DF42TBL1 END-EXEC.
           EXEC SQL INCLUDE DF42TBL2 END-EXEC.

       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF42TEST START OF JOB' UPON CONSOLE.

       1000-PROCESS-DF42-TABLE1.

           INITIALIZE DF42-TABLE1.

           MOVE WS-STORE               TO DF42-STORE1.
           MOVE WS-DEPARTMENT          TO DF42-DEPARTMENT1.
                                     
       1000-DECLARE-DF42-CURSOR1. 

           EXEC SQL DECLARE  DF42_CURSOR1 CURSOR FOR 
                    SELECT   PRODUCT
                    FROM     DEFECTS.DF42.TABLE1
                    WHERE    STORE        = :DF42-STORE1
                      AND    DEPARTMENT   = :DF42-DEPARTMENT1
                    ORDER BY PRODUCT
           END-EXEC.

       1000-OPEN-DF42-CURSOR1.

           EXEC SQL OPEN DF42_CURSOR1 END-EXEC.

           EVALUATE SQLCODE
               WHEN ZERO
                   CONTINUE
               WHEN OTHER
                   DISPLAY 'DF42TEST CURSOR1 OPEN ERROR = ' SQLCODE
                                                       UPON CONSOLE
                   GO TO 1000-END-OF-JOB
           END-EVALUATE.

       1000-FETCH-DF42-CURSOR1.

           EXEC SQL FETCH DF42_CURSOR1
                    INTO :DF42-PRODUCT1
           END-EXEC.
           
      **** BEFORE CODE BEGINS (PROBLEM)
      ****  IF SQLSTATE = '02000'          [SHOULD CHECK FOR CURSOR END]
      ****      GO TO 1000-END-OF-JOB
      **** BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
           EVALUATE SQLCODE
               WHEN ZERO
                   CONTINUE
               WHEN +100
                   GO TO 1000-CLOSE-DF42-CURSOR1
               WHEN OTHER
                   DISPLAY 'DF42TEST CURSOR1 FETCH ERROR = ' SQLCODE
                                                        UPON CONSOLE
                   GO TO 1000-END-OF-JOB
           END-EVALUATE.
      **** AFTER CODE ENDS (CORRECT)

           DISPLAY 'DF42TEST TABLE1 STORE = ' DF42-STORE1
                                              UPON CONSOLE.

           DISPLAY 'DF42TEST TABLE1 DEPARTMENT = ' DF42-DEPARTMENT1
                                                   UPON CONSOLE.

           DISPLAY 'DF42TEST TABLE1 PRODUCT = ' DF42-PRODUCT1
                                                UPON CONSOLE.

           GO TO 1000-FETCH-DF42-CURSOR1.

       1000-CLOSE-DF42-CURSOR1.

           EXEC SQL CLOSE DF42_CURSOR1 END-EXEC.

           EVALUATE SQLCODE
               WHEN ZERO
                   CONTINUE
               WHEN OTHER
                   DISPLAY 'DF42TEST CURSOR1 CLOSE ERROR = ' SQLCODE
                                                        UPON CONSOLE
           END-EVALUATE.  
           
       1000-PROCESS-DF42-TABLE2.

           INITIALIZE DF42-TABLE2.

           MOVE WS-STORE               TO DF42-STORE2.
           MOVE WS-DEPARTMENT          TO DF42-DEPARTMENT2.
       
       1000-DECLARE-DF42-CURSOR2.

           EXEC SQL DECLARE  DF42_CURSOR2 CURSOR FOR
                    SELECT   CLERK
                    FROM     DEFECTS.DF42.TABLE2
                    WHERE    STORE       = :DF42-STORE2
                      AND    DEPARTMENT  = :DF42-DEPARTMENT2
                    ORDER BY CLERK
           END-EXEC.

       1000-OPEN-DF42-CURSOR2.

           EXEC SQL OPEN DF42_CURSOR2 END-EXEC.

           EVALUATE SQLCODE
               WHEN ZERO
                   CONTINUE
               WHEN OTHER
                   DISPLAY 'DF42TEST CURSOR2 OPEN ERROR = ' SQLCODE
                                                      UPON CONSOLE
                   GO TO 1000-END-OF-JOB
           END-EVALUATE.

       1000-FETCH-DF42-CURSOR2.

           EXEC SQL FETCH DF42_CURSOR2
                    INTO :DF42-CLERK2
           END-EXEC.

      *** BEFORE CODE BEGINS (PROBLEM)
      ***  IF SQLSTATE = '02000'          [SHOULD CHECK FOR CURSOR END]
      ***      GO TO 1000-END-OF-JOB
      *** BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
           EVALUATE SQLCODE
               WHEN ZERO
                   CONTINUE
               WHEN +100
                   GO TO 1000-CLOSE-DF42-CURSOR2
               WHEN OTHER
                   DISPLAY 'DF42TEST CURSOR2 FETCH ERROR = ' SQLCODE
                                                        UPON CONSOLE
                   GO TO 1000-END-OF-JOB
           END-EVALUATE.
      **** AFTER CODE ENDS (CORRECT) 

           DISPLAY 'DF42TEST TABLE2 STORE = ' DF42-STORE2
                                              UPON CONSOLE.

           DISPLAY 'DF42TEST TABLE2 DEPARTMENT = ' DF42-DEPARTMENT2
                                                   UPON CONSOLE.

           DISPLAY 'DF42TEST TABLE2 CLERK = ' DF42-CLERK2
                                              UPON CONSOLE.

           GO TO 1000-FETCH-DF42-CURSOR2. 

       1000-CLOSE-DF42-CURSOR2.

           EXEC SQL CLOSE DF42_CURSOR2 END-EXEC.

           EVALUATE SQLCODE
               WHEN ZERO
                   CONTINUE
               WHEN OTHER
                   DISPLAY 'DF42TEST CURSOR2 CLOSE ERROR = ' SQLCODE
                                                        UPON CONSOLE
           END-EVALUATE.

       1000-END-OF-JOB.

           DISPLAY 'DF42TEST END OF JOB' UPON CONSOLE.

           GOBACK.
