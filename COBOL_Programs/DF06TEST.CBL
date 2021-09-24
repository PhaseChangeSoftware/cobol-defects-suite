       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF06TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 06 DEFECT

      ******************************************************************
      ****     ERROR IN COBOL COMPUTE, NOT UNIQUELY DEFINED NAME    ****
      ****     (CAUSED BY OMITTING REFERENCE TO QUALIFIED NAME)     ****
      ******************************************************************

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

       DATA DIVISION.

       FILE SECTION.

       WORKING-STORAGE SECTION.

       01  SALES-RECORD.
           05 SALES-AMOUNT             PIC 9(04)V99    VALUE 200.00.

       01  DETAIL-LINE.
           05 SALES-AMOUNT             PIC 9(04)V99    VALUE ZERO.

       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF06TEST START OF JOB' UPON CONSOLE.

       1000-POST-SALES-AMOUNT.

      **** BEFORE CODE BEGINS (PROBLEM)
      **** COMPUTE SALES-AMOUNT * .08.  [QUALIFIED NAME OMITTED]
      **** BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
           COMPUTE SALES-AMOUNT OF DETAIL-LINE = 
                  (SALES-AMOUNT OF SALES-RECORD * .08).
      **** AFTER CODE ENDS (CORRECT)

           DISPLAY 'DF06TEST SALES AMOUNT = ' SALES-AMOUNT    
                                           OF SALES-RECORD
                                              UPON CONSOLE.

           DISPLAY 'DF06TEST SALES TAX = ' SALES-AMOUNT    
                                        OF DETAIL-LINE
                                           UPON CONSOLE.
           
       1000-END-OF-JOB.

           DISPLAY 'DF06TEST END OF JOB' UPON CONSOLE.

           GOBACK.
