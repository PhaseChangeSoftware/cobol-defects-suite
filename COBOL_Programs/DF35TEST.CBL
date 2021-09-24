       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF35TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 35 DEFECT

      ******************************************************************
      ****   PROBLEM WITH NOT UNSTRINGING ALL OF CSV RECORD FIELDS  ****
      ****   (CAUSED BY DEFINING ENDING TWO FIELDS AS JUST RIGHT)   ****
      ******************************************************************

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

       DATA DIVISION.

       FILE SECTION.

       WORKING-STORAGE SECTION.

       01 WS-DTL-STRING-FIELDS           PIC X(50)     VALUE IS

             'D,8201,MAIN STORE - TOTAL PURCHASED,038201,233.52,'
              
      **** BEFORE CODE BEGINS (PROBLEM)
      *01 WS-DTL-UNSTRG-FIELDS.
      *    05 WS-DTL-UNSTRG-TYPE         PIC X(01).
      *    05 WS-DTL-UNSTRG-STORE-CODE   PIC X(08).  [REMOVE JUST]
      *    05 WS-DTL-UNSTRG-STORE-DESC   PIC X(40).  [RIGHT BELOW]
      *    05 WS-DTL-UNSTRG-ACCT-NUM     PIC X(20).
      *    05 WS-DTL-UNSTRG-DEBIT-AMT    PIC X(08)   JUST RIGHT.
      *    05 WS-DTL-UNSTRG-CREDIT-AMT   PIC X(08)   JUST RIGHT.
      **** BEFORE CODE BEGINS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
       01 WS-DTL-UNSTRG-FIELDS.
           05 WS-DTL-UNSTRG-TYPE         PIC X(01).
           05 WS-DTL-UNSTRG-STORE-CODE   PIC X(08).
           05 WS-DTL-UNSTRG-STORE-DESC   PIC X(40).
           05 WS-DTL-UNSTRG-ACCT-NUM     PIC X(20).
           05 WS-DTL-UNSTRG-DEBIT-AMT    PIC X(08).
           05 WS-DTL-UNSTRG-CREDIT-AMT   PIC X(08).
      **** AFTER CODE BEGINS (CORRECT)

       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF35TEST START OF JOB' UPON CONSOLE.

       1000-UNSTRING-DETAIL-RECORD.

           INITIALIZE  WS-DTL-UNSTRG-FIELDS.

           UNSTRING WS-DTL-STRING-FIELDS DELIMITED BY ','
               INTO WS-DTL-UNSTRG-TYPE
                    WS-DTL-UNSTRG-STORE-CODE
                    WS-DTL-UNSTRG-STORE-DESC
                    WS-DTL-UNSTRG-ACCT-NUM
                    WS-DTL-UNSTRG-DEBIT-AMT
                    WS-DTL-UNSTRG-CREDIT-AMT.

           DISPLAY 'DF35TEST UNSTRING FIELDS = ' WS-DTL-UNSTRG-FIELDS
                                                 UPON CONSOLE.
           
       1000-END-OF-JOB.

           DISPLAY 'DF35TEST END OF JOB' UPON CONSOLE.

           GOBACK.
