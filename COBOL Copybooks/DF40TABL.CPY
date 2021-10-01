      ******************************************************************
      **** DCLGEN TABLE(DF40.TABLE)
      ******************************************************************
           EXEC SQL DECLARE DF40.TABLE TABLE
           ( STORE                     CHAR(20) NOT NULL,
           ( DEPARTMENT                CHAR(40) NOT NULL,
           ( PRODUCT                   CHAR(40) NOT NULL
           ) END-EXEC.
      ******************************************************************
      **** COBOL DECLARATION FOR TABLE DF40.TABLE
      ******************************************************************
       01  DF40-TABLE.
           10 DF40-STORE               PIC X(20).
           10 DF40-DEPARTMENT          PIC X(40).
           10 DF40-PRODUCT             PIC X(40).
      ******************************************************************
      **** THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 3
      ******************************************************************
