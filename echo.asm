main:
        PUSH    BC
        PUSH    DE
        PUSH    HL
        LD      HL, fontFBF
        CALL    writeSetFont
        CALL    drawClearScreen
        CALL    screenUpdate
        LD      BC, 00505h
        LD      DE, 0
mainLoop:
        CALL    keyboardRead
        OR      A
        JR      Z, mainLoop
        CP      skEnter
        JR      Z, mainBreak
        CALL    convertKey
        LD      L, A
        CALL    drawClearRectangle
        LD      A, L
        CALL    writeCharacter
        CALL    screenUpdate
        JR      mainLoop
mainBreak:
        POP     HL
        POP     DE
        POP     BC
        CALL    drawClearScreen
        JP      screenUpdate

convertKey:
        AND     00Fh
        ADD     A, '0'
        CP      '9' + 1
        RET     C
        ADD     A, 'A' - '0'
        RET

        CP      sk0
        RET     C
        CP      sk9 + 1
        CCF
        RET     C
        ADD     A, '0' - sk0
        RET
