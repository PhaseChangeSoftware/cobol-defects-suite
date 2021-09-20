       IDENTIFICATION DIVISION.
       
       PROGRAM-ID. DF08TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 08 DEFECT

      ******************************************************************
      ****   ERROR IN SEARCH STATEMENT ON USE OF INDEX SUBSCRIPT    ****
      ****   (CAUSED BY INCORRECT DEFINITION OF INDEX SUBSCRIPT)    ****
      ******************************************************************

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

       DATA DIVISION.

       FILE SECTION.

       WORKING-STORAGE SECTION.

       01  WS-SEARCH-TABLE.

           05 WS-TABLE-DETAIL.
               10 WS-TABLE-ENTRY-1      PIC X(03) VALUE '901'.
               10 WS-TABLE-ENTRY-2      PIC X(03) VALUE '902'.
               10 WS-TABLE-ENTRY-3      PIC X(03) VALUE '903'.
               10 WS-TABLE-ENTRY-4      PIC X(03) VALUE '904'.
               10 WS-TABLE-ENTRY-5      PIC X(03) VALUE '905'.

      **** BEFORE CODE BEGINS (PROBLEM)
      **** 01 WS-TABLE-MATRIX           REDEFINES WS-SEARCH-TABLE.
      ****     05 WS-TABLE-ENTRIES      OCCURS 5 TIMES.
      ****         10 WS-TABLE-ENTRY    PIC X(03).
      ****     88  WS-SUB               PIC S9(01).  [ERROR DEFINITION]
      **** BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
       01  WS-SEARCH-TABLE-R        REDEFINES WS-SEARCH-TABLE.
           05 WS-TABLE-ENTRIES      OCCURS 5 TIMES
                                    INDEXED BY WS-SUB.
               10 WS-TABLE-ENTRY    PIC X(03).
      **** AFTER CODE ENDS (CORRECT)

       01  WS-INPUT-FIELD               PIC X(3) VALUE '902'.
       01  WS-SEARCH-RESULT             PIC X(3) VALUE SPACES.

       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF08TEST START OF JOB' UPON CONSOLE.

       1000-SEARCH-TABLE.
       
           SET WS-SUB                   TO +1.

           SEARCH WS-TABLE-ENTRIES
               AT END
                   GO TO 1000-END-OF-JOB
               WHEN WS-TABLE-ENTRY (WS-SUB) = WS-INPUT-FIELD
                   MOVE WS-TABLE-ENTRY (WS-SUB)
                                       TO WS-SEARCH-RESULT
           END-SEARCH.

       1000-END-OF-JOB.

           DISPLAY 'DF08TEST END OF JOB' UPON CONSOLE.

           GOBACK.
