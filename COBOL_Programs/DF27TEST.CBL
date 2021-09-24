       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF27TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 27 DEFECT

      ******************************************************************
      ****     ERROR MOVING VALUE FROM ARRAYS IN WORKING STORAGE    ****
      ****     (CAUSED BY NOT SETTING INDEX FOR RECEIVING ARRAY)    ****
      ******************************************************************

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

       DATA DIVISION.

       FILE SECTION.

       WORKING-STORAGE SECTION.

       01  WS-XXX-TABLE.

           10  WS-XXX-PRODUCT-CODE-1       PIC 9(04)   VALUE 1001.
           10  WS-XXX-TEXT-CODE-1          PIC 9(02)   VALUE 01.
           10  WS-XXX-TABLE-CODE-1         PIC 9(02)   VALUE 01.
           10  WS-XXX-TABLE-NBR-1          PIC 9(04)   VALUE 0001.
           10  WS-XXX-PRODUCT-CODE-2       PIC 9(04)   VALUE 2001.
           10  WS-XXX-TEXT-CODE-2          PIC 9(02)   VALUE 02.
           10  WS-XXX-TABLE-CODE-2         PIC 9(02)   VALUE 02.
           10  WS-XXX-TABLE-NBR-2          PIC 9(04)   VALUE 0002.
           10  WS-XXX-PRODUCT-CODE-3       PIC 9(04)   VALUE 3001.
           10  WS-XXX-TEXT-CODE-3          PIC 9(02)   VALUE 03.
           10  WS-XXX-TABLE-CODE-3         PIC 9(02)   VALUE 03.
           10  WS-XXX-TABLE-NBR-3          PIC 9(04)   VALUE 0003.
           10  WS-XXX-PRODUCT-CODE-4       PIC 9(04)   VALUE 4001.
           10  WS-XXX-TEXT-CODE-4          PIC 9(02)   VALUE 04.
           10  WS-XXX-TABLE-CODE-4         PIC 9(02)   VALUE 04.
           10  WS-XXX-TABLE-NBR-4          PIC 9(04)   VALUE 0004.
           10  WS-XXX-PRODUCT-CODE-4       PIC 9(04)   VALUE 5001.
           10  WS-XXX-TEXT-CODE-5          PIC 9(02)   VALUE 05.
           10  WS-XXX-TABLE-CODE-5         PIC 9(02)   VALUE 05.
           10  WS-XXX-TABLE-NBR-5          PIC 9(04)   VALUE 0005.

       01  RD-XXX-TABLE                    REDEFINES WS-XXX-TABLE.

           05  RD-XXX-ENTRY                OCCURS 5 TIMES
                                           INDEXED BY RD-XXX-SUB.
               10  RD-XXX-PRODUCT-CODE     PIC 9(04).
               10  RD-XXX-TEXT-CODE        PIC 9(02).
               10  RD-XXX-TABLE-CODE       PIC 9(02).
               10  RD-XXX-TABLE-NBR        PIC 9(04)

       01  WS-YYY-TABLE.

           05  WS-YYY-PRODUCT-CODE-1       PIC 9(04)   VALUE ZERO.
           05  WS-YYY-TABLE-NBR-1          PIC 9(04)   VALUE ZERO.
           05  WS-YYY-PRODUCT-CODE-2       PIC 9(04)   VALUE ZERO.
           05  WS-YYY-TABLE-NBR-2          PIC 9(04)   VALUE ZERO.
           05  WS-YYY-PRODUCT-CODE-3       PIC 9(04)   VALUE ZERO.
           05  WS-YYY-TABLE-NBR-3          PIC 9(04)   VALUE ZERO.
           05  WS-YYY-PRODUCT-CODE-4       PIC 9(04)   VALUE ZERO.
           05  WS-YYY-TABLE-NBR-4          PIC 9(04)   VALUE ZERO.
           05  WS-YYY-PRODUCT-CODE-5       PIC 9(04)   VALUE ZERO.
           05  WS-YYY-TABLE-NBR-5          PIC 9(04)   VALUE ZERO.

       01  RD-YYY-TABLE                    REDEFINES WS-YYY-TABLE.

           05 RD-YYY-ENTRY                 OCCURS 5 TIMES
                                           INDEXED BY RD-YYY-SUB
               10  RD-YYY-PRODUCT-CODE     PIC 9(04).
               10  RD-YYY-TABLE-NBR        PIC 9(04).

       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF27TEST START OF JOB' UPON CONSOLE.

       1000-CHECK-PARTS-MR-PLANT.

      **** BEFORE CODE BEGINS (PROBLEM)
      **** PERFORM VARYING RD-XXX-SUB FROM 1 BY 1
      ****                             UNTIL RD-XXX-SUB > 5
      **** MOVE RD-XXX-PRODUCT-CODE (RD-XXX-SUB)  [RD-YYY-SUB NOT SET]
      ****                         TO RD-YYY-PRODUCT-CODE (RD-YYY-SUB)
      **** MOVE RD-XXX-TABLE-NBR (RD-XXX-SUB, 1)
      ****                         TO RD-YYY-TABLE-NBR (RD-YYY-SUB).
      ****BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
           PERFORM VARYING RD-XXX-SUB FROM 1 BY 1
                                       UNTIL RD-XXX-SUB > 5
           SET RD-YYY-SUB          TO RD-XXX-SUB
           MOVE RD-XXX-PRODUCT-CODE (RD-XXX-SUB)
                                   TO RD-YYY-PRODUCT-CODE (RD-YYY-SUB)
           MOVE RD-XXX-TABLE-NBR (RD-XXX-SUB)
                                   TO RD-YYY-TABLE-NBR (RD-YYY-SUB)
           END-PERFORM.
      **** AFTER CODE ENDS (CORRECT)

           DISPLAY 'DF27TEST PRODUCT CODE = ' RD-YYY-PRODUCT-CODE
                                              (RD-YYY-SUB)
                                              UPON CONSOLE.
           
           DISPLAY 'DF21TEST TABLE NUMBER = ' RD-YYY-TABLE-NBR
                                              (RD-YYY-SUB)
                                              UPON CONSOLE.

       1000-END-OF-JOB.

           DISPLAY 'DF27TEST END OF JOB' UPON CONSOLE.

           GOBACK.
