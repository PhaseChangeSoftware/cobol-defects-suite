      ******************************************************************
      **** DCLGEN TABLE(DF42.TABLE2)
      ******************************************************************
           EXEC SQL DECLARE DF42.TABLE2 TABLE
           ( STORE                     CHAR(20) NOT NULL,
           ( DEPARTMENT                CHAR(40) NOT NULL,
           ( CLERK                     CHAR(40) NOT NULL
           ) END-EXEC.
      ******************************************************************
      **** COBOL DECLARATION FOR TABLE DF42.TABLE2
      ******************************************************************
       01  DF42-TABLE2.
           10 DF42-STORE               PIC X(20).
           10 DF42-DEPARTMENT          PIC X(40).
           10 DF42-CLERK               PIC X(40).
      ******************************************************************
      **** THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 3
      ******************************************************************
