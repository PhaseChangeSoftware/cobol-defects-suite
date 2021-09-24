       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF26TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 26 DEFECT

      ******************************************************************
      ****   ERROR IN NOT FINDING SEARCH ENTRY USING SEARCH ALL     ****
      ****   (CAUSED BY MISSING READ AT END CHECK FOR TABLE END)    ****
      ******************************************************************
                                         
       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

       DATA DIVISION.

       FILE SECTION.

       WORKING-STORAGE SECTION.

       01  WS-SEARCH-TABLE.

           05 WS-TABLE-DETAIL.
               10  WS-COMPANY-CODE-1   PIC X(03) VALUE '101'.
               10  WS-POLICY-NUMBER-1  PIC X(12) VALUE 'POLICY NBR 1'.
               10  WS-SEARCH-RESULT-1  PIC X(08) VALUE 'RESULT 1'.
               10  WS-COMPANY-CODE-2   PIC X(03) VALUE '102'.
               10  WS-POLICY-NUMBER-2  PIC X(12) VALUE 'POLICY NBR 2'.
               10  WS-SEARCH-RESULT-2  PIC X(08) VALUE 'RESULT 2'.
               10  WS-COMPANY-CODE-3   PIC X(03) VALUE '103'.
               10  WS-POLICY-NUMBER-3  PIC X(12) VALUE 'POLICY NBR 3'.
               10  WS-SEARCH-RESULT-3  PIC X(08) VALUE 'RESULT 3'.
               10  WS-COMPANY-CODE-4   PIC X(03) VALUE '104'.
               10  WS-POLICY-NUMBER-4  PIC X(12) VALUE 'POLICY NBR 4'.
               10  WS-SEARCH-RESULT-4  PIC X(08) VALUE 'RESULT 4'.
               10  WS-COMPANY-CODE-5   PIC X(03) VALUE '105'.
               10  WS-POLICY-NUMBER-5  PIC X(12) VALUE 'POLICY NBR 5'.
               10  WS-SEARCH-RESULT-5  PIC X(08) VALUE 'RESULT 5'.

       01  WS-SEARCH-TABLE-R           REDEFINES WS-SEARCH-TABLE.
           05  WS-TABLE-ENTRIES        OCCURS 5 TIMES
                                       INDEXED BY WS-SUB.
               10  WS-COMPANY-CODE     PIC X(03).
               10  WS-POLICY-NUMBER    PIC X(12).
               10  WS-SEARCH-RESULT    PIC X(08).

       01  WS-INPUT-COMPANY           PIC X(03) VALUE '103'.
       01  WS-INPUT-POLICY            PIC X(12) VALUE 'POLICY NBR 3'.
       01  WS-OUTPUT-RESULT           PIC X(08) VALUE SPACES.

       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF26TEST START OF JOB' UPON CONSOLE.

       1000-SEARCH-TABLE.

      **** BEFORE CODE BEGINS (PROBLEM)
      **** SEARCH ALL WS-TABLE-ENTRIES       [MISSING AT END STATEMENT]
      **** WHEN WS-COMPANY-CODE (WS-SUB) = WS-INPUT-COMPANY
      **** AND
      **** WS-POLICY-NUMBER (WS-SUB) = WS-INPUT-POLICY
      ****     MOVE WS-SEARCH-RESULT (WS-SUB)
      ****                             TO WS-OUTPUT-RESULT
      **** END-SEARCH.
      **** BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
           SET WS-SUB                  TO +1.
           SEARCH WS-TABLE-ENTRIES
               AT END
                   GO TO 1000-END-OF-JOB
               WHEN WS-COMPANY-CODE (WS-SUB) = WS-INPUT-COMPANY
               AND
               WS-POLICY-NUMBER (WS-SUB) = WS-INPUT-POLICY
                   MOVE WS-SEARCH-RESULT (WS-SUB)
                                       TO WS-OUTPUT-RESULT
           END-SEARCH.
      **** AFTER CODE ENDS (CORRECT)
      
           DISPLAY 'DF26TEST OUTPUT RESULT = ' WS-OUTPUT-RESULT
                                               UPON CONSOLE.
      
       1000-END-OF-JOB.

           DISPLAY 'DF26TEST END OF JOB' UPON CONSOLE.

           GOBACK.
