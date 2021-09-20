       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF02TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 02 DEFECT
      
      ******************************************************************
      ****     ERROR IN ARRAY SEARCH, NOT UNIQUELY DEFINED NAME     ****
      ****     (CAUSED BY SUBSCRIPT BEFORE THE QUALIFIED NAME)      ****
      ******************************************************************

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

       DATA DIVISION.

       FILE SECTION.

       WORKING-STORAGE SECTION.

       01  WS-PCS-PARTS-CONTROL.
       
           05 PCS-PARTS-ANTI-THEFT      PIC 9(01) VALUE ZERO.
           05 PCS-PARTS-MR-PLANT        PIC X(03) VALUE SPACES.
           05 PCS-TABLE-DETAIL.
               10 PCS-PARTS-PLANT-1     PIC X(03) VALUE '901'.
               10 PCS-PARTS-SELLDOWN-1  PIC 9(01) VALUE 1.
               10 PCS-PARTS-PLANT-2     PIC X(03) VALUE '902'.
               10 PCS-PARTS-SELLDOWN-2  PIC 9(01) VALUE 2.
               10 PCS-PARTS-PLANT-3     PIC X(03) VALUE '903'.
               10 PCS-PARTS-SELLDOWN-3  PIC 9(01) VALUE 3.
               10 PCS-PARTS-PLANT-4     PIC X(03) VALUE '904'.
               10 PCS-PARTS-SELLDOWN-4  PIC 9(01) VALUE 4.
               10 PCS-PARTS-PLANT-5     PIC X(03) VALUE '905'.
               10 PCS-PARTS-SELLDOWN-5  PIC 9(01) VALUE 5.
           05 PCS-PARTS-ENTRIES         REDEFINES 
           PCS-TABLE-DETAIL.
               10 PCS-PARTS-TABLE-ENTRIES OCCURS 5 TIMES.
                   15 PCS-PARTS-PLANT   PIC X(03).
                   15 PCS-PARTS-SELLDOWN PIC 9(01).

       01  WS-SUB                       PIC S9(01) VALUE +0.
       01  WS-SUB-MAX                   PIC S9(01) VALUE +5.
       01  WS-NEW-LOCATION              PIC X(3) VALUE SPACES.

       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF02TEST START OF JOB' UPON CONSOLE.

       1000-CHECK-PARTS-MR-PLANT.

           IF PCS-PARTS-MR-PLANT > SPACES
               MOVE PCS-PARTS-MR-PLANT TO WS-NEW-LOCATION
           ELSE

	  **** BEFORE CODE BEGINS (PROBLEM)
      ****    PERFORM VARYING WS-SUB FROM +1 BY +1
      ****       UNTIL PCS-PARTS-PLANT (WS-SUB)  [SUBSCRIPT POSITION]
      ****          OF PCS-PARTS-ENTRIES > SPACES
      ****         AND PCS-PARTS-SELLDOWN (WS-SUB [SUBSCRIPT POSITION]
      ****          OF-PCS-PARTS-ENTRIES NOT EQUAL ZERO OR WS-SUB-MAX
      ****        MOVE PCS-PARTS-PLANT (WS-SUB)  [SUBSCRIPT POSITION] 
      ****          OF WS-PCS-PARTS-ENTRIES TO WS-NEW-LOCATION
      ****    END-PERFORM.
      **** BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
              PERFORM VARYING WS-SUB FROM +1 BY +1
                 UNTIL PCS-PARTS-PLANT
                    OF PCS-PARTS-ENTRIES (WS-SUB) > SPACES
                  AND PCS-PARTS-SELLDOWN
                   OF PCS-PARTS-ENTRIES (WS-SUB) NOT EQUAL ZERO
                  AND WS-SUB NOT GREATER THAN WS-SUB-MAX
              END-PERFORM
              MOVE PCS-PARTS-PLANT
                  OF PCS-PARTS-ENTRIES (WS-SUB) TO WS-NEW-LOCATION.
      **** AFTER CODE ENDS (CORRECT)

       1000-END-OF-JOB.

           DISPLAY 'DF02TEST END OF JOB' UPON CONSOLE.

           GOBACK.