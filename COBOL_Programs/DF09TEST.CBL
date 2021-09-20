       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF09TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 09 DEFECT

      ******************************************************************
      ****   SOC7 SYSTEM ABEND WHEN EXECUTING UNSTRING STATEMENT    ****
      ****   (CAUSED BY IMPROPER STRUCTURE OF UNSTRING STATEMENT)    ****
      ******************************************************************

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

       DATA DIVISION.

       FILE SECTION.

       WORKING-STORAGE SECTION.

       01  WS-INPUT-FIELD              PIC X(80)   VALUE
                   '101 SOUTH MAIN STREET WILLIAMSBURG VA 12345'.

       01  WS-OUTPUT-FIELDS.

           05  WS-OUTPUT-FIELD-1       PIC X(20)   VALUE SPACES.
           05  WS-OUTPUT-FIELD-2       PIC X(20)   VALUE SPACES.
           05  WS-OUTPUT-FIELD-3       PIC X(20)   VALUE SPACES.
           05  WS-OUTPUT-FIELD-4       PIC X(20)   VALUE SPACES.
           05  WS-OUTPUT-FIELD-5       PIC X(20)   VALUE SPACES.
           05  WS-OUTPUT-FIELD-6       PIC X(20)   VALUE SPACES.
           05  WS-OUTPUT-FIELD-7       PIC X(20)   VALUE SPACES.
           05  WS-OUTPUT-FIELD-8       PIC X(20)   VALUE SPACES.
           05  WS-OUTPUT-FIELD-9       PIC X(20)   VALUE SPACES.
           05  WS-OUTPUT-FIELD-10      PIC X(20)   VALUE SPACES.

       PROCEDURE DIVISION.

       1000-START-OF-JOB.

           DISPLAY 'DF09TEST START OF JOB' UPON CONSOLE.

       1000-UNSTRING-INPUT.

      **** BEFORE CODE BEGINS (PROBLEM)
      **** SET WK-SUB-2                TO WK-NBR-1.
      **** PERFORM UNTIL WK-UNTL-EOF
      ****     UNSTRING WK-DETAIL DELIMTED BY ALL SPACES
      ****         INTO WS-DTL-REC (WK-SUB-2)   [INVALID UNSTRING]
      ****            WITH POINTER WK-POINTER
      ****                ON OVERFLOW SET WK-UNTIL-EOF TO TRUE
      ****     END-UNSTRING
      ****     SET WK-SUB-2                UP BY WK-NBR-1
      ****     DISPLAY 'WK-DTL: WK-DTL-(WK-SUB-2)
      **** END-PERFORM.
      **** BEFORE CODE ENDS (PROBLEM)

      **** AFTER CODE BEGINS (CORRECT)
           MOVE SPACES                 TO WS-OUTPUT-FIELDS.
           UNSTRING WS-INPUT-FIELD
               DELIMITED BY ALL SPACES
                   INTO WS-OUTPUT-FIELD-1
                        WS-OUTPUT-FIELD-2
                        WS-OUTPUT-FIELD-3
                        WS-OUTPUT-FIELD-4
                        WS-OUTPUT-FIELD-5
                        WS-OUTPUT-FIELD-6
                        WS-OUTPUT-FIELD-7
                        WS-OUTPUT-FIELD-8
                        WS-OUTPUT-FIELD-9
                        WS-OUTPUT-FIELD-10
           END-UNSTRING.
      **** AFTER CODE ENDS (CORRECT)

       1000-END-OF-JOB.

           DISPLAY 'DF09TEST END OF JOB' UPON CONSOLE.

           GOBACK.
