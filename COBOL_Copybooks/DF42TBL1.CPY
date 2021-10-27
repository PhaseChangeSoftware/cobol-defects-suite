      *******************************************************************
      **** DCLGEN TABLE(DEFECTS.DF42.TABLE1)
      ******************************************************************
           EXEC SQL DECLARE DEFECTS.DF42.TABLE1 TABLE
           ( STORE                CHAR(20) NOT NULL,
             DEPARTMENT           CHAR(40) NOT NULL,
             PRODUCT              CHAR(40) NOT NULL
           ) END-EXEC.
      ******************************************************************
      **** COBOL DECLARATION FOR TABLE DEFECTS.DF42.TABLE1
      ******************************************************************
       01  DF42-TABLE1.
           10 DF42-STORE1              PIC X(20).
           10 DF42-DEPARTMENT1         PIC X(40).
           10 DF42-PRODUCT1            PIC X(40).
      ******************************************************************
      **** THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 3
      ******************************************************************