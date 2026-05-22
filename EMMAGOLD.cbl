      *================================================================*
      * PROGRAM:    EMMAGOLD                                           *
      * VERSION:    1.0.0                                              *
      * DATE:       1893-08-22  (APPROX. SEE INCIDENT RPT 1893-004)    *
      * AUTHOR:     SYSTEMS DIVISION (ORIG. AUTHOR UNKNOWN)            *
      * DEPT:       EXCEPTION MANAGEMENT / LEGACY SYSTEMS              *
      *----------------------------------------------------------------*
      * DESC:  END-OF-DAY EXCEPTION REPORT                             *
      *        SCANS FOR UNRESOLVED SYSTEMIC ANOMALIES                 *
      *        AND LOGS FOR REMEDIATION.                               *
      *                                                                *
      *        NOTE: ALL EXCEPTIONS IN THIS REPORT ARE KNOWN.          *
      *        DO NOT LOG NEW TICKETS.                                 *
      *        REMEDIATION STATUS: SEE EXCEPTION DETAIL.               *
      *----------------------------------------------------------------*
      * MAINTENANCE LOG:                                               *
      *   1893-08-22  CREATED PER INCIDENT REPORT 1893-004.            *
      *   1893-09-01  AUTHOR ON LEAVE. JOB RUNS UNATTENDED.            *
      *   1919-12-21  SUBJECT STATUS UPDATED: DEPORTED.                *
      *               EXCEPTION COUNT UNCHANGED.                       *
      *   1934-05-14  SUBJECT STATUS UPDATED: DECEASED.                *
      *               EXCEPTION COUNT UNCHANGED.                       *
      *   1987-03-14  MIGRATED FROM DOS/VSE. DO NOT TOUCH.             *
      *   2008-10-13  EXCEPTION COUNT UNCHANGED.                       *
      *================================================================*
       IDENTIFICATION DIVISION.
       PROGRAM-ID. EMMAGOLD.
       AUTHOR. SYSTEMS-DIVISION.
       DATE-WRITTEN. 1893-08-22.
       DATE-COMPILED. SEE RUNBOOK.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. IBM-370.
       OBJECT-COMPUTER. IBM-370.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT EXCEPTION-REPORT ASSIGN TO OUTFILE
               ORGANIZATION IS SEQUENTIAL
               ACCESS MODE IS SEQUENTIAL
               FILE STATUS IS WS-FILE-STATUS.

       DATA DIVISION.
       FILE SECTION.
       FD  EXCEPTION-REPORT
           LABEL RECORDS ARE OMITTED
           RECORD CONTAINS 80 CHARACTERS.
       01  REPORT-RECORD                   PIC X(80).

       WORKING-STORAGE SECTION.
       01  WS-FILE-STATUS                  PIC XX    VALUE SPACES.
       01  WS-EXCEPTION-INDEX              PIC 99    VALUE 1.
       01  WS-TOTAL-EXCEPTIONS             PIC 99    VALUE 10.
       01  WS-EOF-FLAG                     PIC X     VALUE 'N'.
           88  END-OF-EXCEPTIONS           VALUE 'Y'.
       01  WS-UNRESOLVED-COUNT             PIC 99    VALUE 0.
       01  WS-DAYS-OPEN                    PIC X(8)  VALUE 'OVERFLOW'.
       01  WS-REPORT-DATE                  PIC X(10) VALUE 'SEE CLOCK.'.
       01  WS-DIVIDER                      PIC X(72) VALUE ALL '-'.
       01  WS-THICK-DIVIDER               PIC X(72) VALUE ALL '='.

      *----------------------------------------------------------------*
      * EXCEPTION RECORD LAYOUT                                        *
      * COPYBOOK: GOLDMAN.QUOTES.CPY                                   *
      * NOTE: RECORD STRUCTURE UNCHANGED SINCE 1893.                   *
      *       ANY ATTEMPT TO MODIFY WILL BE MET WITH                   *
      *       FURTHER EXCEPTIONS.                                       *
      *----------------------------------------------------------------*
       01  WS-EXCEPTION-TABLE.
           05  WS-EX OCCURS 10 TIMES
                         INDEXED BY EX-IDX.
               10  WS-EX-ID               PIC X(12).
               10  WS-EX-DATE             PIC X(10).
               10  WS-EX-CATEGORY         PIC X(38).
               10  WS-EX-DESC-1           PIC X(68).
               10  WS-EX-DESC-2           PIC X(68).
               10  WS-EX-NOTE             PIC X(68).
               10  WS-EX-STATUS           PIC X(16).
               10  WS-EX-ASSIGNED         PIC X(36).

       PROCEDURE DIVISION.
       0000-MAIN-LOGIC.
           PERFORM 1000-INITIALIZE
           PERFORM 2000-PRINT-HEADER
           PERFORM 3000-PROCESS-EXCEPTIONS
               VARYING WS-EXCEPTION-INDEX FROM 1 BY 1
               UNTIL WS-EXCEPTION-INDEX > WS-TOTAL-EXCEPTIONS
           PERFORM 4000-PRINT-FOOTER
           PERFORM 9000-TERMINATION
           STOP RUN.

       1000-INITIALIZE.
      *--- LOAD EXCEPTION REGISTER ---*
      *--- SOURCE: GOLDMAN.QUOTES.VSAM (SEE JCL) ---*

           MOVE 'EX-1893-001'   TO WS-EX-ID(1)
           MOVE '1893-08-21'    TO WS-EX-DATE(1)
           MOVE 'UNSANCTIONED-RESOURCE-ACQUISITION'
                                TO WS-EX-CATEGORY(1)
           MOVE 'SUBJECT ADVISED HUNGRY PERSONS TO TAKE BREAD.'
                                TO WS-EX-DESC-1(1)
           MOVE 'PROPERTY DEFINITION CONFLICT. SEE ALSO: EX-1893-004.'
                                TO WS-EX-DESC-2(1)
           MOVE '"IF THEY DO NOT GIVE YOU WORK, DEMAND BREAD."'
                                TO WS-EX-NOTE(1)
           MOVE 'UNRESOLVED'    TO WS-EX-STATUS(1)
           MOVE 'GOLDMAN-E (INACTIVE. SEE HR.)'
                                TO WS-EX-ASSIGNED(1)

           MOVE 'EX-1893-002'   TO WS-EX-ID(2)
           MOVE '1893-08-21'    TO WS-EX-DATE(2)
           MOVE 'PROPERTY-DEFINITION-MISMATCH'
                                TO WS-EX-CATEGORY(2)
           MOVE 'SUBJECT DISPUTES THAT OWNERSHIP OF IDLE LAND'
                                TO WS-EX-DESC-1(2)
           MOVE 'SUPERSEDES OCCUPATION BY WORKING PERSONS.'
                                TO WS-EX-DESC-2(2)
           MOVE 'NOTE: SUBJECT HAS A POINT. EXCEPTION REMAINS OPEN.'
                                TO WS-EX-NOTE(2)
           MOVE 'UNRESOLVED'    TO WS-EX-STATUS(2)
           MOVE 'GOLDMAN-E (INACTIVE. SEE HR.)'
                                TO WS-EX-ASSIGNED(2)

           MOVE 'EX-1906-001'   TO WS-EX-ID(3)
           MOVE '1906-11-01'    TO WS-EX-DATE(3)
           MOVE 'LEGITIMATE-CHANNEL-BYPASS'
                                TO WS-EX-CATEGORY(3)
           MOVE 'SUBJECT CONTINUES TO ADVISE THAT VOTING'
                                TO WS-EX-DESC-1(3)
           MOVE 'IS NOT A VIABLE REMEDIATION PATH.'
                                TO WS-EX-DESC-2(3)
           MOVE 'ESCALATION PATH QUERY RETURNED: NULL.'
                                TO WS-EX-NOTE(3)
           MOVE 'UNRESOLVED'    TO WS-EX-STATUS(3)
           MOVE 'GOLDMAN-E (INACTIVE. SEE HR.)'
                                TO WS-EX-ASSIGNED(3)

           MOVE 'EX-1907-001'   TO WS-EX-ID(4)
           MOVE '1907-03-01'    TO WS-EX-DATE(4)
           MOVE 'CONSENT-CALCULATION-ERROR'
                                TO WS-EX-CATEGORY(4)
           MOVE 'SUBJECT ASSERTS THAT CONSENT OF GOVERNED'
                                TO WS-EX-DESC-1(4)
           MOVE 'IS NOT CURRENTLY BEING CALCULATED CORRECTLY.'
                                TO WS-EX-DESC-2(4)
           MOVE 'CALCULATION METHOD UNCHANGED. ERROR PERSISTS.'
                                TO WS-EX-NOTE(4)
           MOVE 'UNRESOLVED'    TO WS-EX-STATUS(4)
           MOVE 'GOLDMAN-E (INACTIVE. SEE HR.)'
                                TO WS-EX-ASSIGNED(4)

           MOVE 'EX-1910-001'   TO WS-EX-ID(5)
           MOVE '1910-01-01'    TO WS-EX-DATE(5)
           MOVE 'HIERARCHY-BREAK'
                                TO WS-EX-CATEGORY(5)
           MOVE 'SUBJECT NOTES THAT ALL AUTHORITY REQUIRES'
                                TO WS-EX-DESC-1(5)
           MOVE 'SUBMISSION. SUBMISSION REQUIRES FORCE OR FEAR.'
                                TO WS-EX-DESC-2(5)
           MOVE 'HIERARCHY INTACT. EXCEPTION REMAINS OPEN ANYWAY.'
                                TO WS-EX-NOTE(5)
           MOVE 'UNRESOLVED'    TO WS-EX-STATUS(5)
           MOVE 'GOLDMAN-E (INACTIVE. SEE HR.)'
                                TO WS-EX-ASSIGNED(5)

           MOVE 'EX-1910-002'   TO WS-EX-ID(6)
           MOVE '1910-01-01'    TO WS-EX-DATE(6)
           MOVE 'UNAUTH-AFFINITY-POOLING'
                                TO WS-EX-CATEGORY(6)
           MOVE 'UNAUTHORIZED SOLIDARITY DETECTED AMONG PERSONS'
                                TO WS-EX-DESC-1(6)
           MOVE 'WITH NO FORMAL ORGANIZATIONAL CHARTER.'
                                TO WS-EX-DESC-2(6)
           MOVE 'AFFINITY SELF-ORGANIZING. CANNOT BE RESOLVED'
                                TO WS-EX-NOTE(6)
           MOVE 'UNRESOLVED'    TO WS-EX-STATUS(6)
           MOVE 'GOLDMAN-E (INACTIVE. SEE HR.)'
                                TO WS-EX-ASSIGNED(6)

           MOVE 'EX-1916-001'   TO WS-EX-ID(7)
           MOVE '1916-02-11'    TO WS-EX-DATE(7)
           MOVE 'UNSANCTIONED-RESOURCE-ACQUISITION'
                                TO WS-EX-CATEGORY(7)
           MOVE 'SUBJECT DISTRIBUTED INFORMATION ENABLING PERSONS'
                                TO WS-EX-DESC-1(7)
           MOVE 'TO CONTROL THEIR OWN PRODUCTIVE CAPACITY.'
                                TO WS-EX-DESC-2(7)
           MOVE 'ARREST LOGGED. EXCEPTION PREDATES ARREST.'
                                TO WS-EX-NOTE(7)
           MOVE 'UNRESOLVED'    TO WS-EX-STATUS(7)
           MOVE 'GOLDMAN-E (INACTIVE. SEE HR.)'
                                TO WS-EX-ASSIGNED(7)

           MOVE 'EX-1917-001'   TO WS-EX-ID(8)
           MOVE '1917-06-15'    TO WS-EX-DATE(8)
           MOVE 'LEGITIMATE-CHANNEL-BYPASS'
                                TO WS-EX-CATEGORY(8)
           MOVE 'SUBJECT ADVISED PERSONS THAT WARS ARE CONDUCTED'
                                TO WS-EX-DESC-1(8)
           MOVE 'FOR CAPITAL. ADVISED NON-PARTICIPATION.'
                                TO WS-EX-DESC-2(8)
           MOVE 'SUBSEQUENT EVENTS: INCONCLUSIVE RE: SUBJECT CLAIM.'
                                TO WS-EX-NOTE(8)
           MOVE 'UNRESOLVED'    TO WS-EX-STATUS(8)
           MOVE 'GOLDMAN-E (INACTIVE. SEE HR.)'
                                TO WS-EX-ASSIGNED(8)

           MOVE 'EX-1919-001'   TO WS-EX-ID(9)
           MOVE '1919-12-21'    TO WS-EX-DATE(9)
           MOVE 'HIERARCHY-BREAK'
                                TO WS-EX-CATEGORY(9)
           MOVE 'SUBJECT DEPORTED. EXCEPTIONS NOT DEPORTED.'
                                TO WS-EX-DESC-1(9)
           MOVE 'BATCH JOB CONTINUES WITHOUT AUTHOR.'
                                TO WS-EX-DESC-2(9)
           MOVE 'THIS WAS PROBABLY NOT THE INTENDED OUTCOME.'
                                TO WS-EX-NOTE(9)
           MOVE 'UNRESOLVED'    TO WS-EX-STATUS(9)
           MOVE 'UNASSIGNED (SEE DEPORTATION ORDER 1919-12-21)'
                                TO WS-EX-ASSIGNED(9)

           MOVE 'EX-1934-001'   TO WS-EX-ID(10)
           MOVE '1934-05-14'    TO WS-EX-DATE(10)
           MOVE 'PROPERTY-DEFINITION-MISMATCH'
                                TO WS-EX-CATEGORY(10)
           MOVE 'SUBJECT DECEASED. ROOT CAUSE OF EXCEPTIONS'
                                TO WS-EX-DESC-1(10)
           MOVE 'REMAINS UNRESOLVED. BATCH CONTINUES.'
                                TO WS-EX-DESC-2(10)
           MOVE 'IF I CANNOT DANCE, I DO NOT WANT YOUR REVOLUTION.'
                                TO WS-EX-NOTE(10)
           MOVE 'UNRESOLVED'    TO WS-EX-STATUS(10)
           MOVE 'UNASSIGNED (PERMANENT)'
                                TO WS-EX-ASSIGNED(10)

           EXIT.

       2000-PRINT-HEADER.
           DISPLAY WS-THICK-DIVIDER
           DISPLAY '  EMMA GOLDMAN SACHS & CO.'
           DISPLAY '  END-OF-DAY EXCEPTION REPORT'
           DISPLAY '  SYSTEM: EMMAGOLD V1.0  DEPT: LEGACY SYSTEMS'
           DISPLAY '  JOB: EOD.PRAXIS.DAILY'
           DISPLAY '  NOTE: ALL EXCEPTIONS IN THIS REPORT ARE KNOWN.'
           DISPLAY '        DO NOT LOG NEW TICKETS.'
           DISPLAY WS-THICK-DIVIDER
           DISPLAY SPACES
           EXIT.

       3000-PROCESS-EXCEPTIONS.
           DISPLAY WS-DIVIDER
           DISPLAY '  EXCEPTION ID : ' WS-EX-ID(WS-EXCEPTION-INDEX)
           DISPLAY '  DATE LOGGED  : ' WS-EX-DATE(WS-EXCEPTION-INDEX)
           DISPLAY '  CATEGORY     : '
               WS-EX-CATEGORY(WS-EXCEPTION-INDEX)
           DISPLAY '  DESC         : '
               WS-EX-DESC-1(WS-EXCEPTION-INDEX)
           DISPLAY '               : '
               WS-EX-DESC-2(WS-EXCEPTION-INDEX)
           DISPLAY '  NOTE         : '
               WS-EX-NOTE(WS-EXCEPTION-INDEX)
           DISPLAY '  STATUS       : ' WS-EX-STATUS(WS-EXCEPTION-INDEX)
           DISPLAY '  DAYS OPEN    : ' WS-DAYS-OPEN
           DISPLAY '  ASSIGNED TO  : '
               WS-EX-ASSIGNED(WS-EXCEPTION-INDEX)
           DISPLAY SPACES
           ADD 1 TO WS-UNRESOLVED-COUNT
           EXIT.

       4000-PRINT-FOOTER.
           DISPLAY WS-THICK-DIVIDER
           DISPLAY '  TOTAL EXCEPTIONS LOGGED   : '
               WS-TOTAL-EXCEPTIONS
           DISPLAY '  TOTAL EXCEPTIONS RESOLVED : 0'
           DISPLAY '  VARIANCE                  : STRUCTURAL'
           DISPLAY '  NEXT RUN                  : EOD TOMORROW'
           DISPLAY '  AND THE DAY AFTER THAT.'
           DISPLAY WS-THICK-DIVIDER
           EXIT.

       9000-TERMINATION.
           CLOSE EXCEPTION-REPORT
           EXIT.
