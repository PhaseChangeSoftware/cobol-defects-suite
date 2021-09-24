       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF23TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 23 DEFECT

      ******************************************************************
      ****  ERROR IN SEARCH ON USE OF INDEX ARITHMETIC EXPRESSION   ****
      ****  (CAUSED BY INCORRECT CHECK FOR MAXIMUM TABLE ENTRIES)   ****
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

       01  WS-SEARCH-TABLE-R            REDEFINES WS-SEARCH-TABLE.
           05 WS-TABLE-ENTRIES         OCCURS 5 TIMES
                                       INDEXED BY WS-SUB.
               10 WS-TABLE-ENTRY       PIC X(03).
      
       01  WS-INPUT-FIELD             PIC X(3) VALUE '903'.
       01  WS-SEARCH-RESULT           PIC X(3) VALUE SPACES.

       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF23TEST START OF JOB' UPON CONSOLE.

       1000-SEARCH-TABLE.

      **** BEFORE CODE BEGINS (PROBLEM)
      *    SEARCH WS-TABLE-ENTRIES
      *        AT END
      *            GO TO 1000-END-OF-JOB
      *        WHEN WS-TABLE-ENTRY (WS-SUB) = WS-INPUT-FIELD
      *        AND
      *        WS-SUB + 1 < 6       [INCORRECT ARITHMETIC EXPRESSION]
      *            MOVE WS-TABLE-ENTRY (WS-SUB)
      *                                TO WS-SEARCH-RESULT
      *    END-SEARCH.
      **** BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
           SET WS-SUB                  TO +1.
           SEARCH WS-TABLE-ENTRIES
               AT END
                   GO TO 1000-END-OF-JOB
               WHEN WS-TABLE-ENTRY (WS-SUB) = WS-INPUT-FIELD
                   MOVE WS-TABLE-ENTRY (WS-SUB)
                                       TO WS-SEARCH-RESULT
           END-SEARCH.
      **** AFTER CODE ENDS (CORRECT)
      
           DISPLAY 'DF23TEST SEARCH RESULT = ' WS-SEARCH-RESULT
                                               UPON CONSOLE.
      
       1000-END-OF-JOB.

           DISPLAY 'DF23TEST END OF JOB' UPON CONSOLE.

           GOBACK.
