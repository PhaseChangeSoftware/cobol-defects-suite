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

       01  WS-PARTS-CONTROL.

           05 WS-PARTS-ANTI-THEFT       PIC 9(01) VALUE ZERO.
           05 WS-PARTS-MR-PLANT         PIC X(03) VALUE SPACES.
           05 WS-TABLE-DETAIL.
               10 WS-PARTS-PLANT-1      PIC X(03) VALUE '901'.
               10 WS-PARTS-SELLDOWN-1   PIC 9(01) VALUE 0.
               10 WS-PARTS-PLANT-2      PIC X(03) VALUE '902'.
               10 WS-PARTS-SELLDOWN-2   PIC 9(01) VALUE 0.
               10 WS-PARTS-PLANT-3      PIC X(03) VALUE '903'.
               10 WS-PARTS-SELLDOWN-3   PIC 9(01) VALUE 3.
               10 WS-PARTS-PLANT-4      PIC X(03) VALUE '904'.
               10 WS-PARTS-SELLDOWN-4   PIC 9(01) VALUE 4.
               10 WS-PARTS-PLANT-5      PIC X(03) VALUE '905'.
               10 WS-PARTS-SELLDOWN-5   PIC 9(01) VALUE 5.
           05 WS-PARTS-ENTRIES          REDEFINES
           WS-TABLE-DETAIL.
               10 WS-PARTS-TABLE-ENTRIES OCCURS 5 TIMES.
                   15 WS-PARTS-PLANT    PIC X(03).
                   15 WS-PARTS-SELLDOWN PIC 9(01).

       01  WS-SUB                       PIC S9(01) VALUE +0.
       01  WS-SUB-MAX                   PIC S9(01) VALUE +5.
       01  WS-NEW-LOCATION              PIC X(3) VALUE SPACES.

       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF02TEST START OF JOB' UPON CONSOLE.

       1000-CHECK-PARTS-MR-PLANT.

           IF WS-PARTS-MR-PLANT > SPACES
               MOVE WS-PARTS-MR-PLANT TO WS-NEW-LOCATION
           ELSE

      **** BEFORE CODE BEGINS (PROBLEM)
      ****    PERFORM VARYING WS-SUB FROM +1 BY +1
      ****       UNTIL WS-PARTS-PLANT (WS-SUB)   [SUBSCRIPT POSITION]
      ****          OF WS-PARTS-ENTRIES > SPACES
      ****         AND WS-PARTS-SELLDOWN (WS-SUB [SUBSCRIPT POSITION]
      ****          OF-WS-PARTS-ENTRIES NOT EQUAL ZERO OR WS-SUB-MAX
      ****        MOVE WS-PARTS-PLANT (WS-SUB)   [SUBSCRIPT POSITION]
      ****          OF WS-WS-PARTS-ENTRIES TO WS-NEW-LOCATION
      ****    END-PERFORM.
      **** BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
              PERFORM VARYING WS-SUB FROM +1 BY +1
                 UNTIL WS-PARTS-PLANT
                    OF WS-PARTS-ENTRIES (WS-SUB) > SPACES
                  AND WS-PARTS-SELLDOWN
                   OF WS-PARTS-ENTRIES (WS-SUB) NOT EQUAL ZERO
                  AND WS-SUB NOT GREATER THAN WS-SUB-MAX
              END-PERFORM
              MOVE WS-PARTS-PLANT
                  OF WS-PARTS-ENTRIES (WS-SUB) TO WS-NEW-LOCATION.
      **** AFTER CODE ENDS (CORRECT)
      
           DISPLAY 'DF02TEST NEW LOCATION = ' WS-NEW-LOCATION
                                              UPON CONSOLE.

       1000-END-OF-JOB.

           DISPLAY 'DF02TEST END OF JOB' UPON CONSOLE.

           GOBACK.
