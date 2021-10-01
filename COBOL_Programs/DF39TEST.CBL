       IDENTIFICATION DIVISION.

       PROGRAM-ID. DF39TEST.

      *REMARKS:    COBOL SOURCE CODE FOR SNIPPLET 39 DEFECT

      ******************************************************************
      ****     PROGRAM NOT ABLE TO DISPLAY VARIABLE COMP FIELDS     ****
      ****     (CAUSED BY DISPLAYING ALPHANUMERIC GROUP FIELDS)     ****
      ******************************************************************

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.
  
       FILE-CONTROL.

       DATA DIVISION.

       FILE SECTION.

       WORKING-STORAGE SECTION.

       01  DCLVPF230B.

           05 VPF230-MR-UDPRN          PIC S9(9)    VALUE 1001   COMP.
           05 VPF230-MR-UPC            PIC S9(9)    VALUE 1999   COMP.

       01  DCLVPF230A.

           05 VPF230-MR-UDPRN          PIC S9(9)    VALUE 2001   COMP.
           05 VPF230-MR-UPC            PIC S9(9)    VALUE 2999   COMP.

       PROCEDURE DIVISION.

       1000-START-OF-JOB.
           
           DISPLAY 'DF39TEST START OF JOB' UPON CONSOLE.
           
      **** BEFORE CODE BEGINS (PROBLEM)
      ****    MOVE VPF-AUDIT-BEFORE TO DCLVPF230B.  [BEFORE NOT DEFINED]
      ****    MOVE VPF-AUDIT-AFTER  TO DCLVPF230A.  [AFTER NOT DEFINED]
      ****    DISPLAY VPF230-MR-UDPRN OF DCLVPF230B SPACE
      ****            VPF230-MR-UDPRN OF DCLVPF230A SPACE 
      ****            VPF230-MR-UPC   OF DCLVPF230B SPACE
      ****            VPF230-MR-UPC   OF DCLVPF230A 
      ****BEFORE CODE ENDS (PROBLEM) 

      **** AFTER CODE BEGINS (CORRECT)
           DISPLAY 'DF39TEST UDPRN B = ' VPF230-MR-UDPRN OF DCLVPF230B 
                                         UPON CONSOLE.
           DISPLAY 'DF39TEST UDPRN A = ' VPF230-MR-UDPRN OF DCLVPF230A
                                         UPON CONSOLE.
           DISPLAY 'DF39TEST UPC B = ' VPF230-MR-UPC OF DCLVPF230B
                                         UPON CONSOLE.
           DISPLAY 'DF39TEST UPC A = ' VPF230-MR-UPC OF DCLVPF230A
                                         UPON CONSOLE.
      **** AFTER CODE ENDS (CORRECT)

       1000-END-OF-JOB.

           DISPLAY 'DF39TEST END OF JOB' UPON CONSOLE.

           GOBACK.