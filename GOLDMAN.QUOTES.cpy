      *================================================================*
      * COPYBOOK:  GOLDMAN.QUOTES.CPY                                  *
      * DESC:      EXCEPTION RECORD LAYOUT                             *
      *            INCLUDED IN: EMMAGOLD.CBL                           *
      * NOTE:      RECORD STRUCTURE UNCHANGED SINCE 1893.              *
      *================================================================*
       01  EXCEPTION-RECORD.
           05  EX-ID               PIC X(12).
           05  EX-DATE             PIC X(10).
           05  EX-CATEGORY         PIC X(38).
           05  EX-DESC-1           PIC X(68).
           05  EX-DESC-2           PIC X(68).
           05  EX-NOTE             PIC X(68).
           05  EX-STATUS           PIC X(16).
           05  EX-DAYS-OPEN        PIC X(8).
           05  EX-ASSIGNED         PIC X(36).
