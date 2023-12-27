
;;;;;;;;;;;;;;;;;;;;;
; Cyberstar v1.6
;   by
; David B. Philipsen
;
; Reverse-engineered
;   by
; Frank Palazzolo
;;;;;;;;;;;;;;;;;;;;

; 68HC11 Register definitions

PORTA       .equ    0x1000
DDRA        .equ    0x1001
PORTG       .equ    0x1002
DDRG        .equ    0x1003
PORTE       .equ    0x100a
TMSK1       .equ    0x1022
TFLG1       .equ    0x1023
TMSK2       .equ    0x1024
BAUD        .equ    0x102b
SCCR1       .equ    0x102c
SCCR2       .equ    0x102d
SCSR        .equ    0x102e
SCDR        .equ    0x102f
BPROT       .equ    0x1035
CSSTRH      .equ    0x105c
CSCTL       .equ    0x105d
CSGADR      .equ    0x105e
CSGSIZ      .equ    0x105f

; Constants
CHKSUM      .equ    0x197B

; RAM locations

T1NXT       .equ    0x0010      ; 0x0010/0x0011

; if not zero, these are decremented every 0.1 second by the timer 
CDTIMR1     .equ    0x001b      ; 0x001b/0x001c
CDTIMR2     .equ    0x001d      ; 0x001d/0x001e
CDTIMR3     .equ    0x001f      ; 0x001f/0x0020
CDTIMR4     .equ    0x0021      ; 0x0021/0x0022
CDTIMR5     .equ    0x0023      ; 0x0023/0x0024

T30MS       .equ    0x0027      ; used to count t1 irqs for 30ms tasks

; offset counters
OFFCNT1     .equ    0x0070
OFFCNT2     .equ    0x0071
OFFCNT3     .equ    0x0072
OFFCNT4     .equ    0x0073
OFFCNT5     .equ    0x0074

; bottom bit counts every other T1OC
TSCNT       .equ    0x00b0

; NVRAM locations

CPYRTCS     .equ    0x040B      ; 0x040B/0x040C - copyright message checksum
ERASEFLG    .equ    0x040F      ; 0 = normal boot, 1 = erasing EEPROM
NUMBOOT     .equ    0x0426      ; 0x0426/0x0427

        .area   region1 (ABS)
        .org    0x8000

; Disassembly originally from unidasm

        jmp     L8050           ; jump past copyright message

CPYRTMSG:
        .ascii  'Copyright (c) 1993 by David B. Philipsen Licensed by ShowBiz Pizza Time, Inc.'

L8050:
        sei

        ldd     NUMBOOT         ; increment boot cycle counter?
        addd    #0x0001
        std     NUMBOOT

        ldx     #TASK2          ;
        stx     (0x01CE)        ; store this vector here?
        clr     (0x01C7)
        ldd     #0x01C6         ;
        std     (0x013E)        ; store this vector here? Some sort of RTI setup
        clr     TSCNT
        clr     (0x004E)
        clr     (0x00B6)
        clr     (0x004D)
        ldaa    #0x03
        staa    (0x10A8)        ; board 11??
        ldy     #0x0080         ; delay loop
L807E:
        dey
        bne     L807E
        ldaa    #0x11
        staa    (0x10A8)        ; board 11??

        ldab    #0x10
        jsr     LF995           ; blank the diag display

        ldaa    (0x1804)        ; turn off reset button light
        anda    #0xBF
        staa    (0x1804)
        ldaa    #0xFF
        staa    (0x00AC)        ; ???

        jsr     L86C4           ; Init PIAs on cards?
        jsr     L99A6           ; main2?
        jsr     L8C3C           ; reset LCD?
        jsr     L87E8           ; SCC something?
        jsr     L87BC           ; SCC something?
        jsr     L8C7E           ; reset LCD buffer
        jsr     L8D29           ; some LCD command?
        jsr     L8BC0           ; setup IRQ handlers
        jsr     L8BEE
        cli
        jsr     LA25E           ; compute and store copyright checksum
        ldaa    ERASEFLG
        cmpa    #0x01           ; 1 means erase EEPROM!
        bne     L80C1
        jmp     LA275           ; erase EEPROM: skipped if ERASEFLG !=1
L80C1:
        ldd     CPYRTCS         ; copyright checksum
        cpd     #CHKSUM         ; check against copyright checksum value
        bne     LOCKUP          ; bye bye
        clrb
        stab    (0x0062)        ; button light buffer?
        jsr     (0xF9C5)        ; turn off? button lights
        jsr     (0xA341)
        ldaa    (0x0400)
        cmpa    #0x07
        beq     L811C
        bcs     L8105
        cmpa    #0x06
        beq     L8105
        ldd     #0x0000
        std     (0x040D)
        ldd     #0x00C8
        std     CDTIMR1
L80EB:
        ldd     CDTIMR1
        beq     L80FA
        jsr     (0xF945)
        bcc     L80EB
        cmpa    #0x44
        bne     L80EB
        bra     L80FF
L80FA:
        jsr     (0x9F1E)
        bcs     LOCKUP          ; bye bye
L80FF:
        jsr     (0x9EAF)        ; reset L counts
        jsr     (0x9E92)        ; reset R counts
L8105:
        ldaa    #0x39
        staa    (0x0408)
        jsr     (0xA1D5)
        jsr     (0xAB17)
        ldaa    (0xF7C0)        ; a 00
        staa    (0x045C)        ; ??? NVRAM
        jmp     RESET           ; reset!

LOCKUP: jmp     LOCKUP          ; infinite loop

L811C:
        clr     (0x0079)
        clr     (0x007C)
        jsr     (0x0408)        ; ????
        jsr     (0x8013)
        ldab    #0xFD
        jsr     (0x86E7)
        ldab    #0xDF
        jsr     (0x8748)
        jsr     (0x8791)
        jsr     (0x9AF7)
        jsr     (0x9C51)
        clr     (0x0062)
        jsr     (0x99D9)
        bcc     L8159

        jsr     (0x8DE4)
        .ascis  'Invalid CPU!'

        ldaa    #0x53
        jmp     (0x82A4)
L8157:  bra     L8157           ; infinite loop

L8159:
        jsr     (0xA354)
        clr     (0x00AA)
        tst     (0x0000)
        beq     L8179

        jsr     (0x8DE4)
        .ascis  'RAM test failed!'

        bra     L81BD

L8179:
        jsr     (0x8DE4)
        .ascis  '32K RAM OK'

; R12 or CNR mode???
        tst     (0x045C)        ; if this location is 0, good
        bne     L8193
        ldd     #0x520F         ; else print 'R' on the far left of the first line
        jsr     (0x8DB5)        ; display char here on LCD display
        bra     L8199
L8193:
        ldd     #0x430F         ; print 'C' on the far left of the first line
        jsr     (0x8DB5)        ; display char here on LCD display

L8199:
        jsr     (0x8DDD)
        .ascis  'ROM Chksum='

        jsr     (0x975F)        ; print the checksum on the LCD

        ldab    #0x02           ; delay 2 secs
        jsr     (0x8C02)        ;

        jsr     (0x9A27)        ; display Serial #
        jsr     (0x9ECC)        ; display R and L counts?
        jsr     (0x9B19)        ; do the random tasks???

        ldab    #0x02           ; delay 2 secs
        jsr     (0x8C02)        ;

L81BD:
        ldab    SCCR2           ; disable receive data interrupts
        andb    #0xDF
        stab    SCCR2  

        jsr     (0x9AF7)        ; clear a bunch of ram
        ldab    #0xFD
        jsr     (0x86E7)
        jsr     (0x8791)

        ldab    #0x00
        stab    (0x0062)

        jsr     (0xF9C5)

        jsr     (0x8DE4)
        .ascis  ' Cyberstar v1.6'


        jsr     (0xA2DF)
        bcc     L81FF
        ldd     #0x520F
        jsr     (0x8DB5)        ; display 'R' at far right of 1st line
        tst     (0x042A)
        beq     L81FF
        ldd     #0x4B0F
        jsr     (0x8DB5)        ; display 'K' at far right of 1st line
L81FF:
        jsr     (0x8D03)
        ldd     (0x029C)
        cpd     #0x0001
        bne     L8220

        jsr     (0x8DDD)
        .ascis  " Dave's system  "

        bra     L8267
L8220:
        cpd     #0x03E8
        blt     L8241
        cpd     #0x044B
        bhi     L8241

        jsr     (0x8DDD)
        .ascis  '   SPT Studio   '

        bra L8267

L8241:
        ldd     #0x0E0C
        std     (0x00AD)
        ldd     (0x040D)
        cpd     #0x0258
        bhi     L8254
        ldd     #0x0E09
        std     (0x00AD)
L8254:
        ldab    #0x29
        ldx     #0x0E00
L8259:
        ldaa    0,X
        deca
        inx
        incb
        pshx
        jsr     (0x8DB5)        ; display char here on LCD display
        pulx
        cpx     (0x00AD)
        bne     L8259
L8267:
        jsr     (0x9C51)
        clr     (0x005B)
        clr     (0x005A)
        clr     (0x005E)
        clr     (0x0060)
        jsr     (0x9B19)
        ldaa    (0x0060)
        beq     L8283
        jsr     (0xA97C)
        jmp     RESET       ; reset controller
L8283:
        ldaa    (0x1804)
        anda    #0x06
        bne     L8292
        jsr     (0x9CF1)    ; print credits
        ldab    #0x32
        jsr     (0x8C22)
L8292:
        jsr     (0x8E95)
        cmpa    #0x0D
        bne     L829C
        jmp     (0x9292)
L829C:
        jsr     (0xF945)
        bcs     L82A4
L82A1:
        jmp     L8333
L82A4:
        cmpa    #0x44       ;'$'
        bne     L82AB
        jmp     (0xA366)
L82AB:
        cmpa    #0x53       ;'S'
        bne     L82A1

        jsr     (0xF9D8)
        .ascis  '\n\rEnter security code: '

        sei
        jsr     (0xA2EA)
        cli
        bcs     L8331

        jsr     (0xF9D8)
        .ascii '\n\rEEPROM serial number programming enabled.'
        .ascis '\n\rPlease RESET the processor to continue\n\r'

        ldaa    #0x01       ; enable EEPROM erase
        staa    ERASEFLG
        ldaa    #0xDB
        staa    (0x0007)
; need to reset to get out of this 
L8331:  bra     L8331       ; infinite loop

L8333:
        ldaa    (0x00AA)
        beq     L8349
        ldd     CDTIMR1
        bne     L8349
        ldab    (0x0062)
        eorb    #0x20
        stab    (0x0062)
        jsr     (0xF9C5)
        ldd     #0x0032
        std     CDTIMR1
L8349:
        jsr     (0x86A4)
        bcc L8351
        jmp     (0x8276)
L8351:
        ldab    SCCR2  
        orab    #0x20
        stab    SCCR2  
        clr     (0x00AA)
        ldab    (0x0062)
        andb    #0xDF
        stab    (0x0062)
        jsr     (0xF9C5)
        ldab    #0x02           ; delay 2 secs
        jsr     (0x8C02)        ;
        ldaa    (0x007C)
        beq     L839B
        ldaa    (0x007F)
        staa    (0x004E)
        ldab    (0x0081)
        jsr     (0x8748)
        ldaa    (0x0082)
        bita    #0x01
        bne     L8383
        ldaa    (0x00AC)
        anda    #0xFD
        bra     L8387
L8383:
        ldaa    (0x00AC)
        oraa    #0x02
L8387:
        staa    (0x00AC)
        staa    (0x1806)
        ldaa    (0x1804)
        oraa    #0x20
        staa    (0x1804)
        anda    #0xDF
        staa    (0x1804)
        bra     L83AF
L839B:
        ldd     (0x040D)
        cpd     #0xFDE8
        bhi     L83AA
        addd    #0x0001
        std     (0x040D)
L83AA:
        ldab    #0xF7
        jsr     (0x86E7)
L83AF:
        clr     (0x0030)
        clr     (0x0031)
        clr     (0x0032)
        jsr     (0x9B19)
        jsr     (0x86A4)
        bcs     L83AF
        ldaa    (0x0079)
        beq     L83DB
        clr     (0x0079)
        ldaa    (0x00B5)
        cmpa    #0x01
        bne     L83D4
        clr     (0x00B5)
        ldaa    #0x01
        staa    (0x007C)
L83D4:
        ldaa    #0x01
        staa    (0x00AA)
        jmp     (0x9A7F)
L83DB:
        jsr (0x8DE4)
        .ascis  '   Tape start   '

        ldab    (0x0062)
        orab    #0x80
        stab    (0x0062)
        jsr     (0xF9C5)
        ldab    #0xFB
        jsr     (0x86E7)

        jsr     (0x8DCF)
        .ascis  '68HC11 Proto'

        jsr     (0x8DD6)
        .ascis  'dbp'

        ldab    #0x03           ; delay 3 secs
        jsr     (0x8C02)        ;
        tst     (0x007C)
        beq     L8430
        ldab    (0x0080)
        stab    (0x0062)
        jsr     (0xF9C5)
        ldab    (0x007D)
        stab    (0x0078)
        ldab    (0x007E)
        stab    (0x108A)
        clr     (0x007C)
        bra     L844D
L8430:
        jsr     (0x8D03)
        jsr     (0x9D18)
        bcc     L8440
        tst     (0x00B8)
        beq     L8430
        jmp     (0x9A60)
L8440:
        tst     (0x00B8)
        beq     L8430
        clr     (0x0030)
        clr     (0x0031)
        bra     L844D
L844D:
        ldaa    (0x0049)
        bne     L8454
        jmp     (0x85A4)
L8454:
        clr     (0x0049)
        cmpa    #0x31
        bne     L8463
        jsr     (0xA326)
        jsr     (0x8D42)
        bra     L844D
L8463:
        cmpa    #0x32
        bne     L846F
        jsr     (0xA326)
        jsr     (0x8D35)
        bra     L844D
L846F:
        cmpa    #0x54
        bne     L847B
        jsr     (0xA326)
        jsr     (0x8D42)
        bra     L844D
L847B:
        cmpa    #0x5A
        bne     L849B
        jsr     (0xA31E)
        jsr     (0x8E95)
        clr     (0x0032)
        clr     (0x0031)
        clr     (0x0030)
        jsr     L99A6
        ldab    (0x007B)
        orab    #0x0C
        jsr     (0x8748)
        jmp     L81BD
L849B:
        cmpa    #0x42
        bne     L84A2
        jmp     (0x983C)
L84A2:
        cmpa    #0x4D
        bne     L84A9
        jmp     (0x9824)
L84A9:
        cmpa    #0x45
        bne     L84B0
        jmp     (0x9802)
L84B0:
        cmpa    #0x58
        bne     L84B9
        jmp     (0x993F)
        bra     L844D
L84B9:
        cmpa    #0x46
        bne     L84C0
        jmp     (0x9971)
L84C0:
        cmpa    #0x47
        bne     L84C7
        jmp     (0x997B)
L84C7:
        cmpa    #0x48
        bne     L84CE
        jmp     (0x9985)
L84CE:
        cmpa    #0x49
        bne     L84D5
        jmp     (0x998F)
L84D5:
        cmpa    #0x53
        bne     L84DC
        jmp     (0x97BA)
L84DC:
        cmpa    #0x59
        bne     L84E3
        jmp     (0x99D2)
L84E3:
        cmpa    #0x57
        bne     L84EA
        jmp     (0x9AA4)
L84EA:
        cmpa    #0x41
        bne     L8505
        jsr     (0x9D18)
        bcs     L84FC
        clr     (0x0030)
        clr     (0x0031)
        jmp     (0x85A4)
L84FC:
        clr     (0x0030)
        clr     (0x0031)
        jmp     (0x9A7F)
L8505:
        cmpa    #0x4B
        bne     L8514
        jsr     (0x9D18)
        bcs     L8511
        jmp     (0x85A4)
L8511:
        jmp     (0x9A7F)
L8514:
        cmpa    #0x4A
        bne     L851F
        ldaa    #0x01
        staa    (0x00AF)
        jmp     (0x983C)
L851F:
        cmpa    #0x4E
        bne     L852E
        ldaa    (0x108A)
        oraa    #0x02
        staa    (0x108A)
        jmp     (0x844D)
L852E:
        cmpa    #0x4F
        bne     L8538
        jsr     (0x9D18)
        jmp     (0x844D)
L8538:
        cmpa    #0x50
        bne     L8542
        jsr     (0x9D18)
        jmp     (0x844D)
L8542:
        cmpa    #0x51
        bne     L8551
        ldaa    (0x108A)
        oraa    #0x04
        staa    (0x108A)
        jmp     (0x844D)
L8551:
        cmpa    #0x55
        bne     L855C
        ldab    #0x01
        stab    (0x00B6)
        jmp     (0x844D)
L855C:
        cmpa    #0x4C
        bne     L8579
        clr     (0x0049)
        jsr     (0x9D18)
        bcs     L8576
        jsr     (0xAAE8)
        jsr     (0xAB56)
        bcc     L8576
        jsr     (0xAB25)
        jsr     (0xAB46)
L8576:
        jmp     (0x844D)
L8579:
        cmpa    #0x52
        bne     L8597
        clr     (0x0049)
        jsr     (0x9D18)
        bcs     L8594
        jsr     (0xAAE8)
        jsr     (0xAB56)
        bcs     L8594
        ldaa    #0xFF
        staa    0,X
        jsr     (0xAAE8)
L8594:
        jmp     (0x844D)
L8597:
        cmpa    #0x44
        bne     L85A4
        clr     (0x0049)
        jsr     (0xABAE)
        jmp     L844D
L85A4:
        tst     (0x0075)
        bne     L85FF
        tst     (0x0079)
        bne     L85FF
        tst     (0x0030)
        bne     L85BA
        ldaa    (0x005B)
        beq     L85FF
        clr     (0x005B)
L85BA:
        ldd     #0x0064
        std     CDTIMR5
L85BF:
        ldd     CDTIMR5
        beq     L85D7
        jsr     (0x9B19)
        ldaa    (0x1804)
        eora    #0xFF
        anda    #0x06
        cmpa    #0x06
        bne     L85BF
        clr     (0x0030)
        jmp     (0x8680)
L85D7:
        clr     (0x0030)
        ldab    (0x0062)
        eorb    #0x02
        stab    (0x0062)
        jsr     (0xF9C5)
        andb    #0x02
        beq     L85F4
        jsr     (0xAA18)
        ldab    #0x1E
        jsr     (0x8C22)
        clr     (0x0030)
        bra     L85FF
L85F4:
        jsr     (0xAA1D)
        ldab    #0x1E
        jsr     (0x8C22)
        clr     (0x0030)
L85FF:
        jsr     (0x9B19)
        ldaa    PORTE
        anda    #0x10
        beq     L8614
        ldaa    (0x1804)
        eora    #0xFF
        anda    #0x07
        cmpa    #0x06
        bne     L8630
L8614:
        tst     (0x0076)
        bne     L8630
        tst     (0x0075)
        bne     L8630
        ldab    (0x0062)
        andb    #0xFC
        stab    (0x0062)
        jsr     (0xF9C5)
        jsr     (0xAA13)
        jsr     (0xAA1D)
        jmp     (0x9A60)
L8630:
        tst     (0x0031)
        bne     L863C
        ldaa    (0x005A)
        beq     L8680
        clr     (0x005A)
L863C:
        ldd     #0x0064
        std     CDTIMR5
L8641:
        ldd     CDTIMR5
        beq     L8658
        jsr     (0x9B19)
        ldaa    (0x1804)
        eora    #0xFF
        anda    #0x06
        cmpa    #0x06
        bne     L8641
        clr     (0x0031)
        bra     L8680
L8658:
        clr     (0x0031)
        ldab    (0x0062)
        eorb    #0x01
        stab    (0x0062)
        jsr     (0xF9C5)
        andb    #0x01
        beq     L8675
        jsr     (0xAA0C)
        ldab    #0x1E
        jsr     (0x8C22)
        clr     (0x0031)
        bra     L8680
L8675:
        jsr     (0xAA13)
        ldab    #0x1E
        jsr     (0x8C22)
        clr     (0x0031)
L8680:
        jsr     (0x86A4)
        bcs     L86A1
        clr     (0x004E)
        jsr     L99A6
        jsr     L86C4
        clrb
        stab    (0x0062)
        jsr     (0xF9C5)
        ldab    #0xFD
        jsr     (0x86E7)
        ldab    #0x04           ; delay 4 secs
        jsr     (0x8C02)        ;
        jmp     (0x847F)
L86A1:
        jmp     (0x844D)
        jsr     (0x9B19)
        clr     CDTIMR5
        ldaa    #0x19
        staa    CDTIMR5+1
        ldaa    PORTE
        anda    #0x80
        beq     L86B7
L86B5:
        sec
        rts

L86B7:
        ldaa    PORTE
        anda    #0x80
        bne     L86B5
        ldaa    CDTIMR5+1
        bne     L86B7
        clc
        rts

; main1 - init boards 1-9 at:
;         0x1080, 0x1084, 0x1088, 0x108c
;         0x1090, 0x1094, 0x1098, 0x109c
;         0x10a0

L86C4:
        ldx     #0x1080
L86C7:
        ldaa    #0x30
        staa    1,X
        staa    3,X
        ldaa    #0xFF
        staa    0,X
        staa    2,X
        ldaa    #0x34
        staa    1,X
        staa    3,X
        clr     0,X
        clr     2,X
        inx
        inx
        inx
        inx
        cpx     #0x10A4
        ble     L86C7
        rts

; ***
        psha
        jsr     (0x9B19)
        ldaa    (0x00AC)
        cmpb    #0xFB
        bne     L86F5
        anda    #0xFE
        bra     L8703
L86F5:
        cmpb    #0xF7
        bne     L86FD
        anda    #0xBF
        bra     L8703
L86FD:
        cmpb    #0xFD
        bne     L8703
        anda    #0xF7
L8703:
        staa    (0x00AC)
        staa    (0x1806)
        jsr     (0x873A)     ; clock diagnostic indicator
        ldaa    (0x007A)
        anda    #0x01
        staa    (0x007A)
        andb    #0xFE
        orab    (0x007A)
        stab    (0x1806)
        jsr     (0x8775)
        ldab    #0x32
        jsr     (0x8C22)
        ldab    #0xFE
        orab    (0x007A)
        stab    (0x1806)
        stab    (0x007A)
        jsr     (0x8775)
        ldaa    (0x00AC)
        oraa    #0x49
        staa    (0x00AC)
        staa    (0x1806)
        jsr     (0x873A)     ; clock diagnostic indicator
        pula
        rts

; clock diagnostic indicator
        ldaa    (0x1804)
        oraa    #0x20
        staa    (0x1804)
        anda    #0xDF
        staa    (0x1804)
        rts

        psha
        pshb
        ldaa    (0x00AC)
        oraa    #0x30
        anda    #0xFD
        bitb    #0x20
        bne     L8756
        oraa    #0x02
L8756:
        bitb    #0x04
        bne     L875C
        anda    #0xEF
L875C:
        bitb    #0x08
        bne     L8762
        anda    #0xDF
L8762:
        staa    (0x1806)
        staa    (0x00AC)
        jsr     (0x873A)        ; clock diagnostic indicator
        pulb
        stab    (0x1806)
        stab    (0x007B)
        jsr     (0x8783)
        pula
        rts

        ldaa    (0x1807)
        oraa    #0x38
        staa    (0x1807)
        anda    #0xF7
        staa    (0x1807)
        rts

        ldaa    (0x1805)
        oraa    #0x38
        staa    (0x1805)
        anda    #0xF7
        staa    (0x1805)
        rts

        ldaa    (0x007A)
        anda    #0xFE
        psha
        ldaa    (0x00AC)
        oraa    #0x04
        staa    (0x00AC)
        pula
L879D:
        staa    (0x007A)
        staa    (0x1806)
        jsr     (0x8775)
        ldaa    (0x00AC)
        staa    (0x1806)
        jsr     (0x873A)        ; clock diagnostic indicator
        rts

        ldaa    (0x007A)
        oraa    #0x01
        psha
        ldaa    (0x00AC)
        anda    #0xFB
        staa    (0x00AC)
        pula
        bra     L879D

L87BC:
        ldx     #0x87D2
L87BF:
        ldaa    0,X
        cmpa    #0xFF
        beq     L87D1
        inx
        staa    (0x180D)
        ldaa    0,X
        inx
        staa    (0x180D)
        bra     L87BF
L87D1:
        rts

; data table?
        .byte   0x09,0x8a
        .byte   0x01,0x00
        .byte   0x0c,0x18 
        .byte   0x0d,0x00
        .byte   0x04,0x44
        .byte   0x0e,0x63
        .byte   0x05,0x68
        .byte   0x0b,0x56
        .byte   0x03,0xc1
        .byte   0x0f,0x00
        .byte   0xff,0xff

; SCC init?
L87E8:
        ldx     #0xF857
L87EB:
        ldaa    0,X
        cmpa    #0xFF
        beq     L87FD
        inx
        staa    (0x180C)
        ldaa    0,X
        inx
        staa    (0x180C)
        bra     L87EB
L87FD:
        bra     L8815

; data table
        .byte   0x09,0x8a
        .byte   0x01,0x10
        .byte   0x0c,0x18
        .byte   0x0d,0x00
        .byte   0x04,0x04
        .byte   0x0e,0x63
        .byte   0x05,0x68
        .byte   0x0b,0x01
        .byte   0x03,0xc1
        .byte   0x0f,0x00
        .byte   0xff,0xff

L8815:
        ldx     #0x883E
        stx     (0x0128)
        ldaa    #0x7E
        staa    (0x0127)
        ldx     #0x8832
        stx     (0x0101)
        staa    (0x0100)
        ldaa    SCCR2  
        oraa    #0x20
        staa    SCCR2  
        rts

        ldaa    SCSR  
        ldaa    SCDR  
        inc     (0x0048)
        jmp     (0x8862)
        ldaa    #0x01
        staa    (0x180C)
        ldaa    (0x180C)
        anda    #0x70
        bne     L8869  
        ldaa    #0x0A
        staa    (0x180C)
        ldaa    (0x180C)
        anda    #0xC0
        bne     L8878  
        ldaa    (0x180C)
        lsra
        bcc     L8891  
        inc     (0x0048)
        ldaa    (0x180E)
        jsr     (0xF96F)
        staa    (0x004A)
        bra     L8896  
L8869:
        ldaa    (0x180E)
        ldaa    #0x30
        staa    (0x180C)
        ldaa    #0x07
        jsr     (0xF96F)
        clc
        rti

L8878:
        ldaa    #0x07
        jsr     (0xF96F)
        ldaa    #0x0E
        staa    (0x180C)
        ldaa    #0x43
        staa    (0x180C)
        ldaa    (0x180E)
        ldaa    #0x07
        jsr     (0xF96F)
        sec
        rti

L8891:
        ldaa    (0x180E)
        clc
        rti

L8896:
        anda    #0x7F
        cmpa    #0x24
        beq     L88E0  
        cmpa    #0x25
        beq     L88E0  
        cmpa    #0x20
        beq     L88DE  
        cmpa    #0x30
        bcs     L88DD  
        staa    (0x0012)
        ldaa    (0x004D)
        cmpa    #0x02
        bcs     L88B9  
        clr     (0x004D)
        ldaa    (0x0012)
        staa    (0x0049)
        bra     L88DD  
L88B9:
        tst     (0x004E)
        beq     L88DD  
        ldaa    #0x78
        staa    (0x0063)
        staa    (0x0064)
        ldaa    (0x0012)
        cmpa    #0x40
        bcc     L88D1  
        staa    (0x004C)
        clr     (0x004D)
        bra     L88DD  
L88D1:
        cmpa    #0x60
        bcc     L88DD  
        staa    (0x004B)
        clr     (0x004D)
        jsr     (0x88E5)
L88DD:
        rti

L88DE:
        bra     L88DD  
L88E0:
        inc     (0x004D)
        bra     L88DE  
        ldab    (0x004B)
        ldaa    (0x004C)
        tst     (0x045C)
        beq     L88FB  
        cmpa    #0x3C
        bcs     L88FB  
        cmpa    #0x3F
        bhi     L88FB  
        jsr     (0x8993)
        bra     L8960  
L88FB:
        cpd     #0x3048
        beq     L897A  
        cpd     #0x3148
        beq     L8961  
        cpd     #0x344D
        beq     L897A  
        cpd     #0x354D
        beq     L8961  
        cpd     #0x364D
        beq     L897A  
        cpd     #0x374D
        beq     L8961  
        ldx     #0x1080
        ldab    (0x004C)
        subb    #0x30
        lsrb
        aslb
        aslb
        abx
        ldab    (0x004B)
        cmpb    #0x50
        bcc     L8960  
        cmpb    #0x47
        bls     L8936  
        inx
        inx
L8936:
        subb    #0x40
        andb    #0x07
        clra
        sec
        rola
        tstb
        beq     L8944  
L8940:
        rola
        decb
        bne     L8940  
L8944:
        staa    (0x0050)
        ldaa    (0x004C)
        anda    #0x01
        beq     L8954  
        ldaa    0,X
        oraa    (0x0050)
        staa    0,X
        bra     L8960  
L8954:
        ldaa    (0x0050)
        eora    #0xFF
        staa    (0x0050)
        ldaa    0,X
        anda    (0x0050)
        staa    0,X
L8960:
        rts

L8961:
        ldaa    (0x1082)
        oraa    #0x01
        staa    (0x1082)
        ldaa    (0x108A)
        oraa    #0x20
        staa    (0x108A)
        ldaa    (0x108E)
        oraa    #0x20
        staa    (0x108E)
        rts

L897A:
        ldaa    (0x1082)
        anda    #0xFE
        staa    (0x1082)
        ldaa    (0x108A)
        anda    #0xDF
        staa    (0x108A)
        ldaa    (0x108E)
        anda    #0xDF
        staa    (0x108E)
        rts

        pshx
        cmpa    #0x3D
        bhi     L899D  
        ldx     #0xF780
        bra     L89A0  
L899D:
        ldx     #0xF7A0
L89A0:
        subb    #0x40
        aslb
        abx
        cmpa    #0x3C
        beq     L89DC  
        cmpa    #0x3D
        beq     L89B6  
        cmpa    #0x3E
        beq     L89FB  
        cmpa    #0x3F
        beq     L89C9  
        pulx
        rts

L89B6:
        ldaa    (0x1098)
        oraa    0,X
        staa    (0x1098)
        inx
        ldaa    (0x109A)
        oraa    0,X
        staa    (0x109A)
        pulx
        rts

L89C9:
        ldaa    (0x109C)
        oraa    0,X
        staa    (0x109C)
        inx
        ldaa    (0x109E)
        oraa    0,X
        staa    (0x109E)
        pulx
        rts

L89DC:
        ldab    0,X
        eorb    #0xFF
        stab    (0x0012)
        ldaa    (0x1098)
        anda    (0x0012)
        staa    (0x1098)
        inx
        ldab    0,X
        eorb    #0xFF
        stab    (0x0012)
        ldaa    (0x109A)
        anda    (0x0012)
        staa    (0x109A)
        pulx
        rts

L89FB:
        ldab    0,X
        eorb    #0xFF
        stab    (0x0012)
        ldaa    (0x109C)
        anda    (0x0012)
        staa    (0x109C)
        inx
        ldab    0,X
        eorb    #0xFF
        stab    (0x0012)
        ldaa    (0x109E)
        anda    (0x0012)
        staa    (0x109E)
        pulx
        rts

L8A1A:
; Read from table location in X
        pshx
L8A1B:
        ldaa    #0x04
        bita    (0x180D)
        beq     L8A1B  
        ldaa    0,X     
        bne     L8A29       ; is it a nul?
        jmp     (0x8B21)     ; if so jump to exit
L8A29:
        inx
        cmpa    #0x5E        ; is is a caret? '^'
        bne     L8A4B       ; no, jump ahead
        ldaa    0,X         ; yes, get the next char
        inx
        staa    (0x0592)    
        ldaa    0,X     
        inx
        staa    (0x0593)
        ldaa    0,X     
        inx
        staa    (0x0595)
        ldaa    0,X     
        inx
        staa    (0x0596)
        jsr     (0x8B23)
        bra     L8A1B  

L8A4B:
        cmpa    #0x40
        bne     L8A8A  
        ldy     0,X     
        inx
        inx
        ldaa    #0x30
        staa    (0x00B1)
        ldaa    0,Y     
L8A5B:
        cmpa    #0x64
        bcs     L8A66  
        inc     (0x00B1)
        suba    #0x64
        bra     L8A5B  
L8A66:
        psha
        ldaa    (0x00B1)
        jsr     (0x8B3B)
        ldaa    #0x30
        staa    (0x00B1)
        pula
L8A71:
        cmpa    #0x0A
        bcs     L8A7C  
        inc     (0x00B1)
        suba    #0x0A
        bra     L8A71  
L8A7C:
        psha
        ldaa    (0x00B1)
        jsr     (0x8B3B)
        pula
        adda    #0x30
        jsr     (0x8B3B)
        bra     L8A1B  
L8A8A:
        cmpa    #0x7C
        bne     L8AE7  
        ldy     0,X     
        inx
        inx
        ldaa    #0x30
        staa    (0x00B1)
        ldd     0,Y     
L8A9A:
        cpd     #0x2710
        bcs     L8AA8  
        inc     (0x00B1)
        subd    #0x2710
        bra     L8A9A  
L8AA8:
        psha
        ldaa    (0x00B1)
        jsr     (0x8B3B)
        ldaa    #0x30
        staa    (0x00B1)
        pula
L8AB3:
        cpd     #0x03E8
        bcs     L8AC1  
        inc     (0x00B1)
        subd    #0x03E8
        bra     L8AB3  
L8AC1:
        psha
        ldaa    (0x00B1)
        jsr     (0x8B3B)
        ldaa    #0x30
        staa    (0x00B1)
        pula
L8ACC:
        cpd     #0x0064
        bcs     L8ADA  
        inc     (0x00B1)
        subd    #0x0064
        bra     L8ACC  
L8ADA:
        ldaa    (0x00B1)
        jsr     (0x8B3B)
        ldaa    #0x30
        staa    (0x00B1)
        tba
        jmp     (0x8A71)
L8AE7:
        cmpa    #0x7E
        bne     L8B03  
        ldab    0,X     
        subb    #0x30
        inx
        ldy     0,X     
        inx
        inx
L8AF5:
        ldaa    0,Y     
        iny
        jsr     (0x8B3B)
        decb
        bne     L8AF5  
        jmp     (0x8A1B)
L8B03:
        cmpa    #0x25
        bne     L8B1B  
        ldx     #0x0590
        ldd     #0x1B5B
        std     0,X     
        ldaa    #0x4B
        staa    2,X
        clr     3,X
        jsr     L8A1A  
        jmp     (0x8A1B)
L8B1B:
        staa    (0x180F)
        jmp     (0x8A1B)
        pulx
        rts

        pshx
        ldx     #0x0590
        ldd     #0x1B5B
        std     0,X     
        ldaa    #0x48
        staa    7,X
        ldaa    #0x3B
        staa    4,X
        clr     8,X
        jsr     L8A1A  
        pulx
        rts

        psha
L8B3C:
        ldaa    #0x04
        bita    (0x180D)
        beq     L8B3C  
        pula
        staa    (0x180F)
        rts

        jsr     (0xA32E)

        jsr     (0x8DE4)
        .ascis  'Light Diagnostic'

        jsr     (0x8DDD)
        .ascis  'Curtains opening'

        ldab    #0x14
        jsr     (0x8C30)
        ldab    #0xFF
        stab    (0x1098)
        stab    (0x109A)
        stab    (0x109C)
        stab    (0x109E)
        jsr     (0xF9C5)
        ldaa    (0x1804)
        oraa    #0x40
        staa    (0x1804)

        jsr     (0x8DE4)
        .ascis  ' Press ENTER to '

        jsr     (0x8DDD)
        .ascis  'turn lights  off'

L8BB5:
        jsr     (0x8E95)
        cmpa    #0x0D
        bne     L8BB5  
        jsr     (0xA341)
        rts

; setup IRQ handlers!
L8BC0:
        ldaa    #0x80
        staa    TMSK1
        ldx     #0xABCC
        stx     (0x0119)
        ldx     #0xAD0C
        stx     (0x0116)
        ldx     #0xAD0C
        stx     (0x012E)
        ldaa    #0x7E
        staa    (0x0118)
        staa    (0x0115)
        staa    (0x012D)
        clra
        clrb
        std     CDTIMR1     ; Reset all the countdown timers
        std     CDTIMR2
        std     CDTIMR3
        std     CDTIMR4
        std     CDTIMR5

L8BEE:
        ldaa    #0xC0
        staa    TFLG1  
        rts

L8BF4:
        ldaa    PORTE
        eora    #0xFF
        tab
        stab    (0x0062)
        jsr     (0xF9C5)
        bra     L8BF4  
        rts

; Delay B seconds??

        psha
        ldaa    #0x64
        mul
        std     CDTIMR5     ; store B*100 here
L8C08:
        jsr     (0x9B19)     ; update 0x0023/0x0024 from RTC???
        ldd     CDTIMR5
        bne     L8C08  
        pula
        rts

        psha
        ldaa    #0x3C
L8C14:
        staa    (0x0028)
        ldab    #0x01        ; delay 1 sec
        jsr     (0x8C02)     ;
        ldaa    (0x0028)
        deca
        bne     L8C14  
        pula
        rts

        psha
        clra
        std     CDTIMR5
L8C26:
        jsr     (0x9B19)
        tst     CDTIMR5+1
        bne     L8C26  
        pula
        rts

        psha
        ldaa    #0x32
        mul
        std     CDTIMR5
L8C36:
        ldd     CDTIMR5
        bne     L8C36  
        pula
        rts

;;;;;;;;;;;;;;;;;;;;;;;;;;;
; LCD routines
;;;;;;;;;;;;;;;;;;;;;;;;;;;

L8C3C:
        ldaa    #0xFF
        staa    DDRA  
        ldaa    #0xFF
        staa    DDRG 
        ldaa    PORTG  
        oraa    #0x02
        staa    PORTG  
        ldaa    #0x38
        jsr     (0x8C86)     ; write byte to LCD
        ldaa    #0x38
        jsr     (0x8C86)     ; write byte to LCD
        ldaa    #0x06
        jsr     (0x8C86)     ; write byte to LCD
        ldaa    #0x0E
        jsr     (0x8C86)     ; write byte to LCD
        ldaa    #0x01
        jsr     (0x8C86)     ; write byte to LCD
        ldx     #0x00FF
L8C6A:
        nop
        nop
        dex
        bne     L8C6A  
        rts

; toggle LCD ENABLE
        ldaa    PORTG  
        anda    #0xFD        ; clear LCD ENABLE
        staa    PORTG  
        oraa    #0x02        ; set LCD ENABLE
        staa    PORTG  
        rts

; Reset LCD buffer?
L8C7E:
        ldd     #0x0500       ; Reset LCD queue?
        std     (0x0046)     ; write pointer
        std     (0x0044)     ; read pointer?
        rts

; write byte to LCD
        jsr     (0x8CBD)     ; wait for LCD not busy
        staa    PORTA  
        ldaa    PORTG       
        anda    #0xF3        ; LCD RS and LCD RW low
L8C91:
        staa    PORTG  
        jsr     (0x8C70)     ; toggle LCD ENABLE
        rts

        jsr     (0x8CBD)     ; wait for LCD not busy
        staa    PORTA  
        ldaa    PORTG  
        anda    #0xFB
        oraa    #0x08
        bra     L8C91  
        jsr     (0x8CBD)     ; wait for LCD not busy
        ldaa    PORTG  
        anda    #0xF7
        oraa    #0x08
        bra     L8C91  
        jsr     (0x8CBD)     ; wait for LCD not busy
        ldaa    PORTG  
        oraa    #0x0C
        bra     L8C91  

; wait for LCD not busy (or timeout)
        psha
        pshb
        ldab    #0xFF        ; init timeout counter
L8CC1:
        tstb
        beq     L8CDE       ; times up, exit
        ldaa    PORTG  
        anda    #0xF7        ; bit 3 low
        oraa    #0x04        ; bit 3 high
        staa    PORTG       ; LCD RS high
        jsr     (0x8C70)     ; toggle LCD ENABLE
        clr     DDRA  
        ldaa    PORTA       ; read busy flag from LCD
        bmi     L8CE1       ; if busy, keep looping
        ldaa    #0xFF
        staa    DDRA        ; port A back to outputs
L8CDE:
        pulb                ; and exit
        pula
        rts
L8CE1:
        decb                ; decrement timer
        ldaa    #0xFF
        staa    DDRA        ; port A back to outputs
        bra     L8CC1       ; loop

        jsr     (0x8CBD)     ; wait for LCD not busy
        ldaa    #0x01
        jsr     (0x8C86)     ; write byte to LCD
        rts

        jsr     (0x8CBD)     ; wait for LCD not busy
        ldaa    #0x80
        jsr     (0x8D14)
        jsr     (0x8CBD)     ; wait for LCD not busy
        ldaa    #0x80
        jsr     (0x8C86)     ; write byte to LCD
        rts

        jsr     (0x8CBD)     ; wait for LCD not busy
        ldaa    #0xC0
        jsr     (0x8D14)
        jsr     (0x8CBD)     ; wait for LCD not busy
        ldaa    #0xC0
        jsr     (0x8C86)     ; write byte to LCD
        rts

        jsr     (0x8C86)     ; write byte to LCD
        ldaa    #0x10
        staa    (0x0014)
L8D1B:
        jsr     (0x8CBD)     ; wait for LCD not busy
        ldaa    #0x20
        jsr     (0x8C98)
        dec     (0x0014)
        bne     L8D1B  
        rts

L8D29:
        ldaa    #0x0C
        jsr     (0x8E4B)
        rts

        ldaa    #0x0E
        jsr     (0x8E4B)
        rts

        clr     (0x004A)
        clr     (0x0043)
        ldy     (0x0046)
        ldaa    #0xC0
        bra     L8D4D  
        clr     (0x004A)
        clr     (0x0043)
        ldy     (0x0046)
        ldaa    #0x80
L8D4D:
        staa    0,Y     
        clr     1,Y     
        iny
        iny
        cpy     #0x0580
        bcs     L8D61  
        ldy     #0x0500
L8D61:
        ldab    #0x0F
L8D63:
        ldaa    (0x004A)
        beq     L8D63  
        clr     (0x004A)
        decb
        beq     L8D87  
        cmpa    #0x24
        beq     L8D87  
        clr     0,Y     
        staa    1,Y     
        iny
        iny
        cpy     #0x0580
        bcs     L8D85  
        ldy     #0x0500
L8D85:
        bra     L8D63  
L8D87:
        tstb
        beq     L8DA3  
        ldaa    #0x20
L8D8C:
        clr     0,Y     
        staa    1,Y     
        iny
        iny
        cpy     #0x0580
        bcs     L8DA0  
        ldy     #0x0500
L8DA0:
        decb
        bne     L8D8C  
L8DA3:
        clr     0,Y     
        clr     1,Y     
        sty     (0x0046)
        ldaa    (0x0019)
        staa    (0x004E)
        ldaa    #0x01
        staa    (0x0043)
        rts

; display ASCII in B at location
        psha
        pshb
        cmpb    #0x4F
        bhi     L8DCE  
        cmpb    #0x28
        bcs     L8DC2  
        clc
        adcb    #0x18
L8DC2:
        clc
        adcb    #0x80
        tba
        jsr     (0x8E4B)     ; send lcd command
        pulb
        pula
        jsr     (0x8E70)     ; send lcd char
L8DCE:
        rts

; 4 routines to write to the LCD display?

        ldy     (0x0046)     ; get buffer pointer
        ldaa    #0x90        ; command to set LCD RAM ptr to chr 0x10
        bra     L8DE9  

        ldy     (0x0046)     ; get buffer pointer
        ldaa    #0xD0        ; command to set LCD RAM ptr to chr 0x50
        bra     L8DE9  

; Write to the LCD 2nd line
        ldy     (0x0046)     ; get buffer pointer
        ldaa    #0xC0        ; command to set LCD RAM ptr to chr 0x40
        bra     L8DE9  

; Write to the LCD 1st line
        ldy     (0x0046)     ; get buffer pointer
        ldaa    #0x80        ; command to load LCD RAM ptr to chr 0x00

; Put LCD command into a buffer, 4 bytes for each entry?
L8DE9:
        staa    0,Y         ; store command here
        clr     1,Y          ; clear next byte
        iny
        iny

; Add characters at return address to LCD buffer
        cpy     #0x0580       ; check for buffer overflow
        bcs     L8DFD  
        ldy     #0x0500
L8DFD:
        pulx                ; get start of data
        stx     (0x0017)     ; save this here
L8E00:
        ldaa    0,X         ; get character
        beq     L8E3A       ; is it 00, if so jump ahead
        bmi     L8E1D       ; high bit set, if so jump ahead
        clr     0,Y          ; add character
        staa    1,Y     
        inx
        iny
        iny
        cpy     #0x0580       ; check for buffer overflow
        bcs     L8E00  
        ldy     #0x0500
        bra     L8E00  

L8E1D:
        anda    #0x7F
        clr     0,Y          ; add character
        staa    1,Y     
        clr     2,Y     
        clr     3,Y     
        inx
        iny
        iny
        cpy     #0x0580       ; check for overflow
        bcs     L8E3A  
        ldy     #0x0500

L8E3A:
        pshx                ; put SP back
        ldaa    #0x01
        staa    (0x0043)    ; semaphore?
        ldd     (0x0046)
        clr     0,Y     
        clr     1,Y     
        sty     (0x0046)     ; save buffer pointer
        rts

; buffer LCD command?
        ldy     (0x0046)
        staa    0,Y     
        clr     1,Y     
        iny
        iny
        cpy     #0x0580
        bcs     L8E62  
        ldy     #0x0500
L8E62:
        clr     0,Y     
        clr     1,Y     
        ldaa    #0x01
        staa    (0x0043)
        sty     (0x0046)
        rts

        ldy     (0x0046)
        clr     0,Y     
        staa    1,Y     
        iny
        iny
        cpy     #0x0580
        bcs     L8E87  
        ldy     #0x0500
L8E87:
        clr     0,Y     
        clr     1,Y     
        ldaa    #0x01
        staa    (0x0043)
        sty     (0x0046)
        rts

        ldaa    (0x0030)
        bne     L8EA2  
        ldaa    (0x0031)
        bne     L8EAE  
        ldaa    (0x0032)
        bne     L8EBA  
        rts

;;;;;;;;;;;;;;;;;;;;;;;;;;

L8EA2:
        clr     (0x0030)
        clr     (0x0032)
        clr     (0x0031)
        ldaa    #0x01
        rts

L8EAE:
        clr     (0x0031)
        clr     (0x0030)
        clr     (0x0032)
        ldaa    #0x02
        rts

L8EBA:
        clr     (0x0032)
        clr     (0x0030)
        clr     (0x0031)
        ldaa    #0x0D
        rts

        ldaa    (0x1804)
        anda    #0x07
        staa    (0x002C)
        asl     (0x002C)
        asl     (0x002C)
        asl     (0x002C)
        asl     (0x002C)
        asl     (0x002C)
        ldx     #0x0000
L8EDF:
        cpx     #0x0003
        beq     L8F08  
        asl     (0x002C)
        bcs     L8EFB  
        ldaa    0x2D,X
        cmpa    #0x0F
        bcc     L8F09  
        inc     0x2D,X
        ldaa    0x2D,X
        cmpa    #0x02
        bne     L8EF9  
        staa    0x30,X
L8EF9:
        bra     L8F05  
L8EFB:
        clr     0x2D,X
        bra     L8F05  
        ldaa    0x2D,X
        beq     L8F05  
        dec     0x2D,X
L8F05:
        inx
        bra     L8EDF  
L8F08:
        rts

L8F09:
        cpx     #0x0002
        beq     L8F10  
        clr     0x2D,X
L8F10:
        bra     L8F05  
        ldaa    PORTE
        staa    (0x0051)
        ldx     #0x0000
L8F1A:
        cpx     #0x0008
        beq     L8F41  
        asr     (0x0051)
        bcs     L8F34  
        ldaa    0x52,X
        cmpa    #0x0F
        inc     0x52,X
        ldaa    0x52,X
        cmpa    #0x04
        bne     L8F32  
        staa    0x5A,X
L8F32:
        bra     L8F3E  
L8F34:
        clr     0x52,X
        bra     L8F3E  
        ldaa    0x52,X
        beq     L8F3E  
        dec     0x52,X
L8F3E:
        inx
        bra     L8F1A  
L8F41:
        rts

        clr     0x52,X
        bra     L8F3E  

        .ascii      '0.5'
        .ascii      '1.0'
        .ascii      '1.5'
        .ascii      '2.0'
        .ascii      '2.5'
        .ascii      '3.0'

        pshx
        ldaa    (0x0012)
        suba    #0x01
        ldab    #0x03
        mul

        ldx     #0x8F46
        abx
        ldab    #0x2C
L8F66:
        ldaa    0,X     
        inx
        jsr     (0x8DB5)         ; display char here on LCD display
        incb
        cmpb    #0x2F
        bne     L8F66  
        pulx
        rts

        psha
        jsr     (0x8CF2)
        ldab    #0x02
        jsr     (0x8C30)
        pula
        staa    (0x00B4)
        cmpa    #0x03
        bne     L8F94  
        jsr     (0x8DE4)

        .ascis  'Chuck    '

        ldx     #0x9072
        bra     L8FE1  
L8F94:
        cmpa    #0x04
        bne     L8FA9  
        jsr     (0x8DE4)

        .ascis  'Jasper   '

        ldx     #0x90DE
        bra     L8FE1  
L8FA9:
        cmpa    #0x05
        bne     L8FBE  
        jsr     (0x8DE4)

        .ascis  'Pasqually'

        ldx     #0x9145
        bra     L8FE1  
L8FBE:
        cmpa    #0x06
        bne     L8FD3  
        jsr     (0x8DE4)

        .ascis  'Munch    '

        ldx     #0x91BA
        bra     L8FE1  
L8FD3:
        jsr     (0x8DE4)

        .ascis  'Helen   '

        ldx     #0x9226
L8FE1:
        ldaa    (0x00B4)
        suba    #0x03
        asla
        asla
        staa    (0x004B)
        jsr     (0x9504)
        staa    (0x004C)
        cmpa    #0x0F
        bne     L8FF3  
        rts

L8FF3:
        cmpa    #0x08
        bls     L8FFF  
        suba    #0x08
        ldab    (0x004B)
        addb    #0x02
        stab    (0x004B)
L8FFF:
        psha
        ldy     (0x0046)
        pula
        clrb
        sec
L9006:
        rolb
        deca
        bne     L9006  
        stab    (0x0050)
        ldab    (0x004B)
        ldx     #0x1080
        abx
        ldaa    #0x02
        staa    (0x0012)
L9016:
        ldaa    0,X     
        eora    (0x0050)
        staa    0,X     
        tst     0,X     
        beq     L9036  
        ldaa    #0x4F            ;'O'
        ldab    #0x0C        
        jsr     (0x8DB5)         ; display char here on LCD display
        ldaa    #0x6E            ;'n'
        ldab    #0x0D
        jsr     (0x8DB5)         ; display char here on LCD display
        ldd     #0x200E          ;' '
        jsr     (0x8DB5)         ; display char here on LCD display
        bra     L9044  
L9036:
        ldaa    #0x66            ;'f'
        ldab    #0x0D
        jsr     (0x8DB5)         ; display char here on LCD display
        ldaa    #0x66            ;'f'
        ldab    #0x0E
        jsr     (0x8DB5)         ; display char here on LCD display
L9044:
        ldab    (0x0012)
        jsr     (0x8C30)
        jsr     (0x8E95)
        cmpa    #0x0D
        beq     L9064  
        bra     L9016  
        cmpa    #0x02
        bne     L9016  
        ldaa    (0x0012)
        cmpa    #0x06
        beq     L9016  
        inca
        staa    (0x0012)
        jsr     (0x8F58)
        bra     L9016  
L9064:
        ldaa    0,X     
        oraa    (0x0050)
        eora    (0x0050)
        staa    0,X     
        ldaa    (0x00B4)
        jmp     (0x8F73)
        rts

.if 0
; Comma seperated text
9072: 4d           tsta
9073: 6f 75        clr (X+0x75)
9075: 74 68 2c     lsr (0x682C)
9078: 48           asla
9079: 65           ?
907a: 61           ?
907b: 64 20        lsr (X+0x20)
907d: 6c 65        inc (X+0x65)
907f: 66 74        ror (X+0x74)
9081: 2c 48        bge [0x90CB]
9083: 65           ?
9084: 61           ?
9085: 64 20        lsr (X+0x20)
9087: 72           ?
9088: 69 67        rol (X+0x67)
908a: 68 74        asl (X+0x74)
908c: 2c 48        bge [0x90D6]
908e: 65           ?
908f: 61           ?
9090: 64 20        lsr (X+0x20)
9092: 75           ?
9093: 70 2c 45     neg (0x2C45)
9096: 79 65 73     rol (0x6573)
9099: 20 72        bra [0x910D]
909b: 69 67        rol (X+0x67)
909d: 68 74        asl (X+0x74)
909f: 2c 45        bge [0x90E6]
90a1: 79 65 6c     rol (0x656C)
90a4: 69 64        rol (X+0x64)
90a6: 73 2c 52     com (0x2C52)
90a9: 69 67        rol (X+0x67)
90ab: 68 74        asl (X+0x74)
90ad: 20 68        bra [0x9117]
90af: 61           ?
90b0: 6e 64        jmp (X+0x64)
90b2: 2c 45        bge [0x90F9]
90b4: 79 65 73     rol (0x6573)
90b7: 20 6c        bra [0x9125]
90b9: 65           ?
90ba: 66 74        ror (X+0x74)
90bc: 2c 44        bge [0x9102]
90be: 53           comb
90bf: 39           rts
90c0: 2c 44        bge [0x9106]
90c2: 53           comb
90c3: 31           ins
90c4: 30           tsx
90c5: 2c 44        bge [0x910B]
90c7: 53           comb
90c8: 31           ins
90c9: 31           ins
90ca: 2c 44        bge [0x9110]
90cc: 53           comb
90cd: 31           ins
90ce: 32           pula
90cf: 2c 44        bge [0x9115]
90d1: 53           comb
90d2: 31           ins
90d3: 33           pulb
90d4: 2c 44        bge [0x911A]
90d6: 53           comb
90d7: 31           ins
90d8: 34           des
90d9: 2c 45        bge [0x9120]
90db: 78 69 f4     asl (0x69F4)
90de: 4d           tsta
90df: 6f 75        clr (X+0x75)
90e1: 74 68 2c     lsr (0x682C)
90e4: 48           asla
90e5: 65           ?
90e6: 61           ?
90e7: 64 20        lsr (X+0x20)
90e9: 6c 65        inc (X+0x65)
90eb: 66 74        ror (X+0x74)
90ed: 2c 48        bge [0x9137]
90ef: 65           ?
90f0: 61           ?
90f1: 64 20        lsr (X+0x20)
90f3: 72           ?
90f4: 69 67        rol (X+0x67)
90f6: 68 74        asl (X+0x74)
90f8: 2c 48        bge [0x9142]
90fa: 65           ?
90fb: 61           ?
90fc: 64 20        lsr (X+0x20)
90fe: 75           ?
90ff: 70 2c 45     neg (0x2C45)
9102: 79 65 73     rol (0x6573)
9105: 20 72        bra [0x9179]
9107: 69 67        rol (X+0x67)
9109: 68 74        asl (X+0x74)
910b: 2c 45        bge [0x9152]
910d: 79 65 6c     rol (0x656C)
9110: 69 64        rol (X+0x64)
9112: 73 2c 48     com (0x2C48)
9115: 61           ?
9116: 6e 64        jmp (X+0x64)
9118: 73 2c 45     com (0x2C45)
911b: 79 65 73     rol (0x6573)
911e: 20 6c        bra [0x918C]
9120: 65           ?
9121: 66 74        ror (X+0x74)
9123: 2c 44        bge [0x9169]
9125: 53           comb
9126: 39           rts
9127: 2c 44        bge [0x916D]
9129: 53           comb
912a: 31           ins
912b: 30           tsx
912c: 2c 44        bge [0x9172]
912e: 53           comb
912f: 31           ins
9130: 31           ins
9131: 2c 44        bge [0x9177]
9133: 53           comb
9134: 31           ins
9135: 32           pula
9136: 2c 44        bge [0x917C]
9138: 53           comb
9139: 31           ins
913a: 33           pulb
913b: 2c 44        bge [0x9181]
913d: 53           comb
913e: 31           ins
913f: 34           des
9140: 2c 45        bge [0x9187]
9142: 78 69 f4     asl (0x69F4)
9145: 4d           tsta
9146: 6f 75        clr (X+0x75)
9148: 74 68 2d     lsr (0x682D)
914b: 4d           tsta
914c: 75           ?
914d: 73 74 61     com (0x7461)
9150: 63 68        com (X+0x68)
9152: 65           ?
9153: 2c 48        bge [0x919D]
9155: 65           ?
9156: 61           ?
9157: 64 20        lsr (X+0x20)
9159: 6c 65        inc (X+0x65)
915b: 66 74        ror (X+0x74)
915d: 2c 48        bge [0x91A7]
915f: 65           ?
9160: 61           ?
9161: 64 20        lsr (X+0x20)
9163: 72           ?
9164: 69 67        rol (X+0x67)
9166: 68 74        asl (X+0x74)
9168: 2c 4c        bge [0x91B6]
916a: 65           ?
916b: 66 74        ror (X+0x74)
916d: 20 61        bra [0x91D0]
916f: 72           ?
9170: 6d 2c        tst (X+0x2C)
9172: 45           ?
9173: 79 65 73     rol (0x6573)
9176: 20 72        bra [0x91EA]
9178: 69 67        rol (X+0x67)
917a: 68 74        asl (X+0x74)
917c: 2c 45        bge [0x91C3]
917e: 79 65 6c     rol (0x656C)
9181: 69 64        rol (X+0x64)
9183: 73 2c 52     com (0x2C52)
9186: 69 67        rol (X+0x67)
9188: 68 74        asl (X+0x74)
918a: 20 61        bra [0x91ED]
918c: 72           ?
918d: 6d 2c        tst (X+0x2C)
918f: 45           ?
9190: 79 65 73     rol (0x6573)
9193: 20 6c        bra [0x9201]
9195: 65           ?
9196: 66 74        ror (X+0x74)
9198: 2c 44        bge [0x91DE]
919a: 53           comb
919b: 39           rts
919c: 2c 44        bge [0x91E2]
919e: 53           comb
919f: 31           ins
91a0: 30           tsx
91a1: 2c 44        bge [0x91E7]
91a3: 53           comb
91a4: 31           ins
91a5: 31           ins
91a6: 2c 44        bge [0x91EC]
91a8: 53           comb
91a9: 31           ins
91aa: 32           pula
91ab: 2c 44        bge [0x91F1]
91ad: 53           comb
91ae: 31           ins
91af: 33           pulb
91b0: 2c 44        bge [0x91F6]
91b2: 53           comb
91b3: 31           ins
91b4: 34           des
91b5: 2c 45        bge [0x91FC]
91b7: 78 69 f4     asl (0x69F4)
91ba: 4d           tsta
91bb: 6f 75        clr (X+0x75)
91bd: 74 68 2c     lsr (0x682C)
91c0: 48           asla
91c1: 65           ?
91c2: 61           ?
91c3: 64 20        lsr (X+0x20)
91c5: 6c 65        inc (X+0x65)
91c7: 66 74        ror (X+0x74)
91c9: 2c 48        bge [0x9213]
91cb: 65           ?
91cc: 61           ?
91cd: 64 20        lsr (X+0x20)
91cf: 72           ?
91d0: 69 67        rol (X+0x67)
91d2: 68 74        asl (X+0x74)
91d4: 2c 4c        bge [0x9222]
91d6: 65           ?
91d7: 66 74        ror (X+0x74)
91d9: 20 61        bra [0x923C]
91db: 72           ?
91dc: 6d 2c        tst (X+0x2C)
91de: 45           ?
91df: 79 65 73     rol (0x6573)
91e2: 20 72        bra [0x9256]
91e4: 69 67        rol (X+0x67)
91e6: 68 74        asl (X+0x74)
91e8: 2c 45        bge [0x922F]
91ea: 79 65 6c     rol (0x656C)
91ed: 69 64        rol (X+0x64)
91ef: 73 2c 52     com (0x2C52)
91f2: 69 67        rol (X+0x67)
91f4: 68 74        asl (X+0x74)
91f6: 20 61        bra [0x9259]
91f8: 72           ?
91f9: 6d 2c        tst (X+0x2C)
91fb: 45           ?
91fc: 79 65 73     rol (0x6573)
91ff: 20 6c        bra [0x926D]
9201: 65           ?
9202: 66 74        ror (X+0x74)
9204: 2c 44        bge [0x924A]
9206: 53           comb
9207: 39           rts
9208: 2c 44        bge [0x924E]
920a: 53           comb
920b: 31           ins
920c: 30           tsx
920d: 2c 44        bge [0x9253]
920f: 53           comb
9210: 31           ins
9211: 31           ins
9212: 2c 44        bge [0x9258]
9214: 53           comb
9215: 31           ins
9216: 32           pula
9217: 2c 44        bge [0x925D]
9219: 53           comb
921a: 31           ins
921b: 33           pulb
921c: 2c 44        bge [0x9262]
921e: 53           comb
921f: 31           ins
9220: 34           des
9221: 2c 45        bge [0x9268]
9223: 78 69 f4     asl (0x69F4)
9226: 4d           tsta
9227: 6f 75        clr (X+0x75)
9229: 74 68 2c     lsr (0x682C)
922c: 48           asla
922d: 65           ?
922e: 61           ?
922f: 64 20        lsr (X+0x20)
9231: 6c 65        inc (X+0x65)
9233: 66 74        ror (X+0x74)
9235: 2c 48        bge [0x927F]
9237: 65           ?
9238: 61           ?
9239: 64 20        lsr (X+0x20)
923b: 72           ?
923c: 69 67        rol (X+0x67)
923e: 68 74        asl (X+0x74)
9240: 2c 48        bge [0x928A]
9242: 65           ?
9243: 61           ?
9244: 64 20        lsr (X+0x20)
9246: 75           ?
9247: 70 2c 45     neg (0x2C45)
924a: 79 65 73     rol (0x6573)
924d: 20 72        bra [0x92C1]
924f: 69 67        rol (X+0x67)
9251: 68 74        asl (X+0x74)
9253: 2c 45        bge [0x929A]
9255: 79 65 6c     rol (0x656C)
9258: 69 64        rol (X+0x64)
925a: 73 2c 52     com (0x2C52)
925d: 69 67        rol (X+0x67)
925f: 68 74        asl (X+0x74)
9261: 20 68        bra [0x92CB]
9263: 61           ?
9264: 6e 64        jmp (X+0x64)
9266: 2c 45        bge [0x92AD]
9268: 79 65 73     rol (0x6573)
926b: 20 6c        bra [0x92D9]
926d: 65           ?
926e: 66 74        ror (X+0x74)
9270: 2c 44        bge [0x92B6]
9272: 53           comb
9273: 39           rts
9274: 2c 44        bge [0x92BA]
9276: 53           comb
9277: 31           ins
9278: 30           tsx
9279: 2c 44        bge [0x92BF]
927b: 53           comb
927c: 31           ins
927d: 31           ins
927e: 2c 44        bge [0x92C4]
9280: 53           comb
9281: 31           ins
9282: 32           pula
9283: 2c 44        bge [0x92C9]
9285: 53           comb
9286: 31           ins
9287: 33           pulb
9288: 2c 44        bge [0x92CE]
928a: 53           comb
928b: 31           ins
928c: 34           des
928d: 2c 45        bge [0x92D4]
928f: 78 69 f4     asl (0x69F4)
.endif
        .org    0x9292
; code again
        jsr     L86C4
L9295:
        ldab    #0x01
        jsr     (0x8C30)

        jsr     (0x8DE4)
        .ascis  '  Diagnostics   '

        jsr     (0x8DDD)
        .ascis  '                '

        ldab    #0x01
        jsr     (0x8C30)
        jsr     (0x8D03)
        ldx     #0x93D3
        jsr     (0x9504)
        cmpa    #0x11
        bne     L92E6  
        jsr     L86C4
        clrb
        stab    (0x0062)
        jsr     (0xF9C5)
        ldaa    (0x1804)
        anda    #0xBF
        staa    (0x1804)
        jmp     (0x81D7)
L92E6:
        cmpa    #0x03
        bcs     L92F3  
        cmpa    #0x08
        bcc     L92F3  
        jsr     (0x8F73)
        bra     L9295  
L92F3:
        cmpa    #0x02
        bne     L92FF  
        jsr     (0x9F1E)
        bcs     L9295  
        jmp     (0x9675)
L92FF:
        cmpa    #0x0B
        bne     L9310  
        jsr     (0x8D03)
        jsr     (0x9ECC)
        ldab    #0x03
        jsr     (0x8C30)
        bra     L9295  
L9310:
        cmpa    #0x09
        bne     L9322  
        jsr     (0x9F1E)
        bcc     L931C  
        jmp     (0x9295)
L931C:
        jsr     (0x9E92)     ; reset R counts
        jmp     (0x9295)
L9322:
        cmpa    #0x0A
        bne     L9331  
        jsr     (0x9F1E)
        bcs     L932E  
        jsr     (0x9EAF)     ; reset L counts
L932E:
        jmp     (0x9295)
L9331:
        cmpa    #0x01
        bne     L9338  
        jmp     (0xA0E9)
L9338:
        cmpa    #0x08
        bne     L935B  
        jsr     (0x9F1E)
        bcs     L935B  

        jsr     (0x8DE4)
        .ascis  'Reset System!'

        jmp     (0xA249)
        ldab    #0x02
        jsr     (0x8C30)
        bra     L9373  
L935B:
        cmpa    #0x0C
        bne     L9373  
        jsr     (0x8B48)
        clrb
        stab    (0x0062)
        jsr     (0xF9C5)
        ldaa    (0x1804)
        anda    #0xBF
        staa    (0x1804)
        jmp     (0x9292)
L9373:
        cmpa    #0x0D
        bne     L93A5  
        jsr     (0x8CE9)

        jsr     (0x8DE4)
        .ascis  '  Button  test'

        jsr     (0x8DDD)
        .ascis  '   PROG exits'

        jsr     (0xA526)
        clrb
        jsr     (0xF9C5)
        jmp     (0x9295)
L93A5:
        cmpa    #0x0E
        bne     L93B9  
        jsr     (0x9F1E)
        bcc     L93B1  
        jmp     (0x9295)
L93B1:
        ldab    #0x01
        jsr     (0x8C30)
        jmp     (0x949A)
L93B9:
        cmpa    #0x0F
        bne     L93C3  
        jsr     (0xA86A)
        jmp     (0x9295)
L93C3:
        cmpa    #0x10
        bne     L93D0  
        jsr     (0x9F1E)
        jsr     (0x95BA)
        jmp     (0x9295)

L93D0:
        jmp     (0x92D2)

.if 0
; Comma seperated text
93d3: 56           rorb
93d4: 43           coma
93d5: 52           ?
93d6: 20 61        bra [0x9439]
93d8: 64 6a        lsr (X+0x6A)
93da: 75           ?
93db: 73 74 2c     com (0x742C)
93de: 53           comb
93df: 65           ?
93e0: 74 20 52     lsr (0x2052)
93e3: 61           ?
93e4: 6e 64        jmp (X+0x64)
93e6: 6f 6d        clr (X+0x6D)
93e8: 2c 43        bge [0x942D]
93ea: 68 75        asl (X+0x75)
93ec: 63 6b        com (X+0x6B)
93ee: 20 45        bra [0x9435]
93f0: 2e 20        bgt [0x9412]
93f2: 43           coma
93f3: 68 65        asl (X+0x65)
93f5: 65           ?
93f6: 73 65 2c     com (0x652C)
93f9: 4a           deca
93fa: 61           ?
93fb: 73 70 65     com (0x7065)
93fe: 72           ?
93ff: 2c 50        bge [0x9451]
9401: 61           ?
9402: 73 71 75     com (0x7175)
9405: 61           ?
9406: 6c 6c        inc (X+0x6C)
9408: 79 2c 4d     rol (0x2C4D)
940b: 75           ?
940c: 6e 63        jmp (X+0x63)
940e: 68 2c        asl (X+0x2C)
9410: 48           asla
9411: 65           ?
9412: 6c 65        inc (X+0x65)
9414: 6e 2c        jmp (X+0x2C)
9416: 52           ?
9417: 65           ?
9418: 73 65 74     com (0x6574)
941b: 20 53        bra [0x9470]
941d: 79 73 74     rol (0x7374)
9420: 65           ?
9421: 6d 2c        tst (X+0x2C)
9423: 52           ?
9424: 65           ?
9425: 73 65 74     com (0x6574)
9428: 20 72        bra [0x949C]
942a: 65           ?
942b: 67 20        asr (X+0x20)
942d: 74 61 70     lsr (0x6170)
9430: 65           ?
9431: 23 2c        bls [0x945F]
9433: 52           ?
9434: 65           ?
9435: 73 65 74     com (0x6574)
9438: 20 6c        bra [0x94A6]
943a: 69 76        rol (X+0x76)
943c: 20 74        bra [0x94B2]
943e: 61           ?
943f: 70 65 23     neg (0x6523)
9442: 2c 56        bge [0x949A]
9444: 69 65        rol (X+0x65)
9446: 77 20 54     asr (0x2054)
9449: 61           ?
944a: 70 65 20     neg (0x6520)
944d: 23 27        bls [0x9476]
944f: 73 2c 41     com (0x2C41)
9452: 6c 6c        inc (X+0x6C)
9454: 20 4c        bra [0x94A2]
9456: 69 67        rol (X+0x67)
9458: 68 74        asl (X+0x74)
945a: 73 20 4f     com (0x204F)
945d: 6e 2c        jmp (X+0x2C)
945f: 42           ?
9460: 75           ?
9461: 74 74 6f     lsr (0x746F)
9464: 6e 20        jmp (X+0x20)
9466: 74 65 73     lsr (0x6573)
9469: 74 2c 4b     lsr (0x2C4B)
946c: 69 6e        rol (X+0x6E)
946e: 67 20        asr (X+0x20)
9470: 65           ?
9471: 6e 61        jmp (X+0x61)
9473: 62           ?
9474: 6c 65        inc (X+0x65)
9476: 2c 57        bge [0x94CF]
9478: 61           ?
9479: 72           ?
947a: 6d 2d        tst (X+0x2D)
947c: 55           ?
947d: 70 2c 53     neg (0x2C53)
9480: 68 6f        asl (X+0x6F)
9482: 77 20 54     asr (0x2054)
9485: 79 70 65     rol (0x7065)
9488: 2c 51        bge [0x94DB]
948a: 75           ?
948b: 69 74        rol (X+0x74)
948d: 20 44        bra [0x94D3]
948f: 69 61        rol (X+0x61)
9491: 67 6e        asr (X+0x6E)
9493: 6f 73        clr (X+0x73)
9495: 74 69 63     lsr (0x6963)
9498: f3 
9499: 00           test

.endif
        .org    0x949A

        tst     (0x042A)
        beq     L94C6  

        jsr     (0x8DE4)
        .ascis  'King is Enabled'

        jsr     (0x8DDD)
        .ascis  'ENTER to disable'

        bra     L94EB  

L94C6:
        jsr     (0x8DE4)
        .ascis  'King is Disabled'

        jsr     (0x8DDD)
        .ascis  'ENTER to enable'

L94EB:
        jsr     (0x8E95)
        tsta
        beq     L94EB  
        cmpa    #0x0D
        beq     L94F7  
        bra     L9501  
L94F7:
        ldaa    (0x042A)
        anda    #0x01
        eora    #0x01
        staa    (0x042A)
L9501:
        jmp     (0x9295)
        ldaa    #0x01
        staa    (0x00A6)
        staa    (0x00A7)
        stx     (0x0012)
        bra     L9517  
        ldaa    #0x01
        staa    (0x00A7)
        clr     (0x00A6)
        stx     (0x0012)
L9517:
        clr     (0x0016)
        ldy     (0x0046)
        tst     (0x00A6)
        bne     L9529  
        jsr     (0x8CF2)
        ldaa    #0x80
        bra     L952E  
L9529:
        jsr     (0x8D03)
        ldaa    #0xC0
L952E:
        staa    0,Y     
        clr     1,Y     
        iny
        iny
        cpy     #0x0580
        bcs     L9542  
        ldy     #0x0500
L9542:
        stx     (0x0014)
L9544:
        ldaa    0,X     
        bpl     L954C  
        ldab    #0x01
        stab    (0x0016)
L954C:
        cmpa    #0x2C
        beq     L956E  
        clr     0,Y     
        anda    #0x7F
        staa    1,Y     
        iny
        iny
        cpy     #0x0580
        bcs     L9566  
        ldy     #0x0500
L9566:
        tst     (0x0016)
        bne     L956E  
        inx
        bra     L9544  
L956E:
        inx
        ldaa    #0x01
        staa    (0x0043)
        clr     0,Y     
        clr     1,Y     
        sty     (0x0046)
L957C:
        jsr     (0x8E95)
        beq     L957C  
        cmpa    #0x02
        bne     L958F  
        tst     (0x0016)
        bne     L958F  
        inc     (0x00A7)
        bra     L9517  
L958F:
        cmpa    #0x01
        bne     L95B3  
        ldy     (0x0014)
        cpy     (0x0012)
        bls     L957C  
        dec     (0x00A7)
        ldx     (0x0014)
        dex
L95A1:
        dex
        cpx     (0x0012)
        bne     L95A9  
        jmp     (0x9517)
L95A9:
        ldaa    0,X     
        cmpa    #0x2C
        bne     L95A1  
        inx
        jmp     (0x9517)
L95B3:
        cmpa    #0x0D
        bne     L957C  
        ldaa    (0x00A7)
        rts

        ldaa    (0x045C)
        beq     L95D3  

        jsr     (0x8DE4)
        .ascis  'Current: CNR   '

        bra     L95E5  

L95D3:
        jsr     (0x8DE4)
        .ascis  'Current: R12   '

L95E5:
        jsr     (0x8DDD)
        .ascis  '<Enter> to chg.'

L95F7:
        jsr     (0x8E95)
        beq     L95F7  
        cmpa    #0x0D
        bne     L960F  
        ldaa    (0x045C)
        beq     L960A  
        clr     (0x045C)
        bra     L960F  
L960A:
        ldaa    #0x01
        staa    (0x045C)
L960F:
        rts

.if 0
; Comma-separated text
9610: 43           coma
9611: 68 75        asl (X+0x75)
9613: 63 6b        com (X+0x6B)
9615: 2c 4a        bge [0x9661]
9617: 61           ?
9618: 73 70 65     com (0x7065)
961b: 72           ?
961c: 2c 50        bge [0x966E]
961e: 61           ?
961f: 73 71 75     com (0x7175)
9622: 61           ?
9623: 6c 6c        inc (X+0x6C)
9625: 79 2c 4d     rol (0x2C4D)
9628: 75           ?
9629: 6e 63        jmp (X+0x63)
962b: 68 2c        asl (X+0x2C)
962d: 48           asla
962e: 65           ?
962f: 6c 65        inc (X+0x65)
9631: 6e 2c        jmp (X+0x2C)
9633: 4c           inca
9634: 69 67        rol (X+0x67)
9636: 68 74        asl (X+0x74)
9638: 20 31        bra [0x966B]
963a: 2c 4c        bge [0x9688]
963c: 69 67        rol (X+0x67)
963e: 68 74        asl (X+0x74)
9640: 20 32        bra [0x9674]
9642: 2c 4c        bge [0x9690]
9644: 69 67        rol (X+0x67)
9646: 68 74        asl (X+0x74)
9648: 20 33        bra [0x967D]
964a: 2c 53        bge [0x969F]
964c: 74 61 72     lsr (0x6172)
964f: 20 45        bra [0x9696]
9651: 46           rora
9652: 58           aslb
9653: 2c 57        bge [0x96AC]
9655: 69 6e        rol (X+0x6E)
9657: 6b           ?
9658: 20 53        bra [0x96AD]
965a: 70 6f 74     neg (0x6F74)
965d: 2c 47        bge [0x96A6]
965f: 6f 62        clr (X+0x62)
9661: 6f 2c        clr (X+0x2C)
9663: 43           coma
9664: 6c 65        inc (X+0x65)
9666: 61           ?
9667: 72           ?
9668: 20 41        bra [0x96AB]
966a: 6c 6c        inc (X+0x6C)
966c: 20 52        bra [0x96C0]
966e: 6e 64        jmp (X+0x64)
9670: 2c 45        bge [0x96B7]
9672: 78 69 f4     asl (0x69F4)

.endif
        .org    0x9675

; code again
        jsr     (0x8DE4)
        .ascis  'Random          '

        ldx     #0x9610
        jsr     (0x9504)
        clrb
        pshb
        cmpa    #0x0D
        bne     L9697  
        jmp     (0x975B)
L9697:
        cmpa    #0x0C
        bne     L96BC  
        clr     (0x0401)
        clr     (0x042B)

        jsr     (0x8DE4)
        .ascis  'All Rnd Cleared!'

        ldab    #0x64
        jsr     (0x8C22)
        jmp     (0x975B)
L96BC:
        cmpa    #0x09
        bcs     L96C5  
        suba    #0x08
        pulb
        incb
        pshb
L96C5:
        clrb
        sec
L96C7:
        rolb
        deca
        bne     L96C7  
        stab    (0x0012)
        eorb    #0xFF
        stab    (0x0013)
L96D1:
        ldd     #0x2034           ;' '
        jsr     (0x8DB5)         ; display char here on LCD display
        pulb
        pshb
        tstb
        beq     L96E1  
        ldaa    (0x042B)
        bra     L96E4  
L96E1:
        ldaa    (0x0401)
L96E4:
        anda    (0x0012)
        beq     L96F2  
        ldy     (0x0046)
        jsr     (0x8DFD)
        clra
        ldx     0x20,X
        dex
L96F2:
        ldy     (0x0046)
        jsr     (0x8DFD)
        clra
        ror     0xE6,X
        ldd     #0x2034           ;' '
        jsr     (0x8DB5)         ; display char here on LCD display
L9701:
        jsr     (0x8E95)
        beq     L9701  
        cmpa    #0x01
        bne     L972C  
        pulb
        pshb
        tstb
        beq     L9719  
        ldaa    (0x042B)
        oraa    (0x0012)
        staa    (0x042B)
        bra     L9721  
L9719:
        ldaa    (0x0401)
        oraa    (0x0012)
        staa    (0x0401)
L9721:
        ldy     (0x0046)
        jsr     (0x8DFD)
        clra
        jmp     0xA0,X
        bra     L96D1  
L972C:
        cmpa    #0x02
        bne     L9753  
        pulb
        pshb
        tstb
        beq     L973F  
        ldaa    (0x042B)
        anda    (0x0013)
        staa    (0x042B)
        bra     L9747  
L973F:
        ldaa    (0x0401)
        anda    (0x0013)
        staa    (0x0401)
L9747:
        ldy     (0x0046)
        jsr     (0x8DFD)
        clra
        ror     0xE6,X
        jmp     (0x96D1)
L9753:
        cmpa    #0x0D
        bne     L9701  
        pulb
        jmp     (0x9675)
        pulb
        jmp     (0x9292)

; do program rom checksum, and display it on the LCD screen
        ldx     #0x0000
        ldy     #0x8000
L9766:
        ldab    0,Y     
        iny
        abx
        cpy     #0x0000
        bne     L9766  
        stx     (0x0017)         ; store rom checksum here
        ldaa    (0x0017)        ; get high byte of checksum
        jsr     (0x979B)         ; convert it to 2 hex chars
        ldaa    (0x0012)
        ldab    #0x33
        jsr     (0x8DB5)         ; display char 1 here on LCD display
        ldaa    (0x0013)
        ldab    #0x34
        jsr     (0x8DB5)         ; display char 2 here on LCD display
        ldaa    (0x0018)        ; get low byte of checksum
        jsr     (0x979B)         ; convert it to 2 hex chars
        ldaa    (0x0012)
        ldab    #0x35
        jsr     (0x8DB5)         ; display char 1 here on LCD display
        ldaa    (0x0013)
        ldab    #0x36
        jsr     (0x8DB5)         ; display char 2 here on LCD display
        rts

; convert A to ASCII hex digit, store in (0x0012:0x0013)
        psha
        anda    #0x0F
        adda    #0x30
        cmpa    #0x39
        bls     L97A6  
        adda    #0x07
L97A6:
        staa    (0x0013)
        pula
        anda    #0xF0
        lsra
        lsra
        lsra
        lsra
        adda    #0x30
        cmpa    #0x39
        bls     L97B7  
        adda    #0x07
L97B7:
        staa    (0x0012)
        rts

        jsr     (0x9D18)
        bcc     L97C2  
        jmp     (0x9A7F)
L97C2:
        tst     (0x0079)
        bne     L97D2  
        ldd     (0x0410)
        addd    #0x0001
        std     (0x0410)
        bra     L97DB  
L97D2:
        ldd     (0x0412)
        addd    #0x0001
        std     (0x0412)
L97DB:
        ldaa    #0x78
        staa    (0x0063)
        staa    (0x0064)
        jsr     (0xA313)
        jsr     (0xAADB)
        ldaa    #0x01
        staa    (0x004E)
        staa    (0x0076)
        clr     (0x0075)
        clr     (0x0077)
        jsr     (0x87AE)
        ldab    (0x007B)
        orab    #0x20
        andb    #0xF7
        jsr     (0x8748)
        jmp     (0x85A4)
        clr     (0x0076)
        clr     (0x0075)
        clr     (0x0077)
        clr     (0x004E)
        ldab    (0x007B)
        orab    #0x0C
        jsr     (0x8748)
        jsr     (0xA31E)
        jsr     L86C4
        jsr     (0x9C51)
        jsr     (0x8E95)
        jmp     (0x844D)
        jsr     (0x9C51)
        clr     (0x004E)
        ldab    (0x007B)
        orab    #0x24
        andb    #0xF7
        jsr     (0x8748)
        jsr     (0x87AE)
        jsr     (0x8E95)
        jmp     (0x844D)
        clr     (0x0078)
        ldaa    (0x108A)
        anda    #0xF9
        staa    (0x108A)
        tst     (0x00AF)
        bne     L98AD  
        ldaa    (0x0062)
        anda    #0x01
        beq     L98AD  
        ldab    #0xFD
        jsr     (0x86E7)
        ldd     #0x0032
        std     CDTIMR1
        ldd     #0x7530
        std     CDTIMR2
        clr     (0x005A)
L9864:
        jsr     (0x9B19)
        tst     (0x0031)
        bne     L9870  
        ldaa    (0x005A)
        beq     L9889  
L9870:
        clr     (0x0031)
        ldab    (0x0062)
        andb    #0xFE
        stab    (0x0062)
        jsr     (0xF9C5)
        jsr     (0xAA13)
        ldab    #0xFB
        jsr     (0x86E7)
        clr     (0x005A)
        bra     L98D4  
L9889:
        ldd     CDTIMR1
        bne     L9864  
        ldab    (0x0062)
        eorb    #0x01
        stab    (0x0062)
        jsr     (0xF9C5)
        andb    #0x01
        bne     L989F  
        jsr     (0xAA0C)
        bra     L98A2  
L989F:
        jsr     (0xAA13)
L98A2:
        ldd     #0x0032
        std     CDTIMR1
        ldd     CDTIMR2
        beq     L9870  
        bra     L9864  
L98AD:
        tst     (0x0075)
        beq     L98B5  
        jmp     (0x9939)
L98B5:
        ldaa    (0x0062)
        anda    #0x02
        beq     L9909  
        tst     (0x00AF)
        bne     L98CB  
        ldd     (0x0424)
        addd    #0x0001
        std     (0x0424)
        bra     L98D4  
L98CB:
        ldd     (0x0422)
        addd    #0x0001
        std     (0x0422)
L98D4:
        ldd     (0x0418)
        addd    #0x0001
        std     (0x0418)
        ldaa    #0x78
        staa    (0x0063)
        staa    (0x0064)
        ldab    (0x0062)
        andb    #0xF7
        orab    #0x02
        stab    (0x0062)
        jsr     (0xF9C5)
        jsr     (0xAA18)
        ldaa    #0x01
        staa    (0x004E)
        staa    (0x0075)
        ldab    (0x007B)
        andb    #0xDF
        jsr     (0x8748)
        jsr     (0x87AE)
        jsr     (0xA313)
        jsr     (0xAADB)
        bra     L9939  
L9909:
        ldab    (0x0062)
        andb    #0xF5
        orab    #0x40
        stab    (0x0062)
        jsr     (0xF9C5)
        jsr     (0xAA1D)
        tst     (0x00AF)
        bne     L9920  
        ldab    #0x01
        stab    (0x00B6)
L9920:
        jsr     (0x9C51)
        clr     (0x004E)
        clr     (0x0075)
        ldaa    #0x01
        staa    (0x0077)
        ldab    (0x007B)
        orab    #0x24
        andb    #0xF7
        jsr     (0x8748)
        jsr     (0x8791)
L9939:
        clr     (0x00AF)
        jmp     (0x85A4)
        clr     (0x0077)
        jsr     (0x9C51)
        clr     (0x004E)
        ldab    (0x0062)
        andb    #0xBF
        tst     (0x0075)
        beq     L9953  
        andb    #0xFD
L9953:
        stab    (0x0062)
        jsr     (0xF9C5)
        jsr     (0xAA1D)
        clr     (0x005B)
        jsr     (0x87AE)
        ldab    (0x007B)
        orab    #0x20
        jsr     (0x8748)
        clr     (0x0075)
        clr     (0x0076)
        jmp     (0x9815)
        ldab    (0x007B)
        andb    #0xFB
        jsr     (0x8748)
        jmp     (0x85A4)
        ldab    (0x007B)
        orab    #0x04
        jsr     (0x8748)
        jmp     (0x85A4)
        ldab    (0x007B)
        andb    #0xF7
        jsr     (0x8748)
        jmp     (0x85A4)
        tst     (0x0077)
        bne     L999B  
        ldab    (0x007B)
        orab    #0x08
        jsr     (0x8748)
L999B:
        jmp     (0x85A4)
        ldab    (0x007B)
        andb    #0xF3
        jsr     (0x8748)
        rts

; main2
L99A6:
        ldab    (0x007B)
        andb    #0xDF        ; clear bit 5
        jsr     (0x8748)
        jsr     (0x8791)
        rts

        ldab    (0x007B)
        orab    #0x20
        jsr     (0x8748)
        jsr     (0x87AE)
        rts

        ldab    (0x007B)
        andb    #0xDF
        jsr     (0x8748)
        jsr     (0x87AE)
        rts

        ldab    (0x007B)
        orab    #0x20
        jsr     (0x8748)
        jsr     (0x8791)
        rts

        ldaa    #0x01
        staa    (0x0078)
        jmp     (0x85A4)
        ldx     #0x0E20
        ldaa    0,X     
        suba    #0x30
        ldab    #0x0A
        mul
        tba
        ldab    #0x64
        mul
        std     (0x0017)
        ldaa    1,X     
        suba    #0x30
        ldab    #0x64
        mul
        addd    (0x0017)
        std     (0x0017)
        ldaa    2,X     
        suba    #0x30
        ldab    #0x0A
        mul
        addd    (0x0017)
        std     (0x0017)
        clra
        ldab    3,X     
        subb    #0x30
        addd    (0x0017)
        std     (0x029C)
        ldx     #0x0E20
L9A0C:
        ldaa    0,X     
        cmpa    #0x30
        bcs     L9A25  
        cmpa    #0x39
        bhi     L9A25  
        inx
        cpx     #0x0E24
        bne     L9A0C  
        ldaa    (0x0E24)        ; check EEPROM signature
        cmpa    #0xDB
        bne     L9A25  
        clc
        rts

L9A25:
        sec
        rts

.if 0
9a27: bd 8d e4     jsr (0x8DE4)

'Serial# '
9a2a: 53 65 72 69 61 6c 23 a0 

9a32: bd 8d dd     jsr (0x8DDD)

'               '
9a35: 20 20 20 20 20 20 20 20 20 20 20 20 20 20 a0 

; display 4-digit serial number
9a44: c6 08        ldab 0x08
9a46: 18 ce 0e 20  ldy 0x0E20
9a4a: 18 a6 00     ldaa (Y+0x00)
9a4d: 18 3c        pshy
9a4f: 37           pshb
9a50: bd 8d b5     jsr (0x8DB5)         ; display char here on LCD display
9a53: 33           pulb
9a54: 18 38        puly
9a56: 5c           incb
9a57: 18 08        iny
9a59: 18 8c 0e 24  cpy 0x0E24
9a5d: 26 eb        bne [0x9A4A]
9a5f: 39           rts

9a60: 86 01        ldaa 0x01
9a62: 97 b5        staa (0x00B5)
9a64: 96 4e        ldaa (0x004E)
9a66: 97 7f        staa (0x007F)
9a68: 96 62        ldaa (0x0062)
9a6a: 97 80        staa (0x0080)
9a6c: 96 7b        ldaa (0x007B)
9a6e: 97 81        staa (0x0081)
9a70: 96 7a        ldaa (0x007A)
9a72: 97 82        staa (0x0082)
9a74: 96 78        ldaa (0x0078)
9a76: 97 7d        staa (0x007D)
9a78: b6 10 8a     ldaa (0x108A)
9a7b: 84 06        anda 0x06
9a7d: 97 7e        staa (0x007E)
9a7f: c6 ef        ldab 0xEF
9a81: bd 86 e7     jsr (0x86E7)
9a84: d6 7b        ldab (0x007B)
9a86: ca 0c        orab 0x0C
9a88: c4 df        andb 0xDF
9a8a: bd 87 48     jsr (0x8748)
9a8d: bd 87 91     jsr (0x8791)
9a90: bd 86 c4     jsr L86C4
9a93: bd 9c 51     jsr (0x9C51)
9a96: c6 06        ldab 0x06            ; delay 6 secs
9a98: bd 8c 02     jsr (0x8C02)         ;
9a9b: bd 8e 95     jsr (0x8E95)
9a9e: bd 99 a6     jsr L99A6
9aa1: 7e 81 bd     jmp (0x81BD)
9aa4: 7f 00 5c     clr (0x005C)
9aa7: 86 01        ldaa 0x01
9aa9: 97 79        staa (0x0079)
9aab: c6 fd        ldab 0xFD
9aad: bd 86 e7     jsr (0x86E7)
9ab0: bd 8e 95     jsr (0x8E95)
9ab3: cc 75 30     ldd 0x7530
9ab6: dd 1d        std CDTIMR2
9ab8: bd 9b 19     jsr (0x9B19)
9abb: d6 62        ldab (0x0062)
9abd: c8 04        eorb 0x04
9abf: d7 62        stab (0x0062)
9ac1: bd f9 c5     jsr (0xF9C5)
9ac4: f6 18 04     ldab (0x1804)
9ac7: c8 08        eorb 0x08
9ac9: f7 18 04     stab (0x1804)
9acc: 7d 00 5c     tst (0x005C)
9acf: 26 12        bne [0x9AE3]
9ad1: bd 8e 95     jsr (0x8E95)
9ad4: 81 0d        cmpa 0x0D
9ad6: 27 0b        beq [0x9AE3]
9ad8: c6 32        ldab 0x32
9ada: bd 8c 22     jsr (0x8C22)
9add: dc 1d        ldd CDTIMR2
9adf: 27 02        beq [0x9AE3]
9ae1: 20 d5        bra [0x9AB8]
9ae3: d6 62        ldab (0x0062)
9ae5: c4 fb        andb 0xFB
9ae7: d7 62        stab (0x0062)
9ae9: bd f9 c5     jsr (0xF9C5)
9aec: bd a3 54     jsr (0xA354)
9aef: c6 fb        ldab 0xFB
9af1: bd 86 e7     jsr (0x86E7)
9af4: 7e 85 a4     jmp (0x85A4)
9af7: 7f 00 75     clr (0x0075)
9afa: 7f 00 76     clr (0x0076)
9afd: 7f 00 77     clr (0x0077)
9b00: 7f 00 78     clr (0x0078)
9b03: 7f 00 25     clr (0x0025)
9b06: 7f 00 26     clr (0x0026)
9b09: 7f 00 4e     clr (0x004E)
9b0c: 7f 00 30     clr (0x0030)
9b0f: 7f 00 31     clr (0x0031)
9b12: 7f 00 32     clr (0x0032)
9b15: 7f 00 af     clr (0x00AF)
9b18: 39           rts

; validate a bunch of ram locations against bytes in ROM???
9b19: 36           psha
9b1a: 37           pshb
9b1b: 96 4e        ldaa (0x004E)
9b1d: 27 17        beq [0x9B36]     ; go to 0401 logic
9b1f: 96 63        ldaa (0x0063)
9b21: 26 10        bne [0x9B33]     ; exit
9b23: 7d 00 64     tst (0x0064)
9b26: 27 09        beq [0x9B31]     ; go to 0401 logic
9b28: bd 86 c4     jsr L86C4     ; do something with boards???
9b2b: bd 9c 51     jsr (0x9C51)     ; RTC stuff???
9b2e: 7f 00 64     clr (0x0064)
9b31: 20 03        bra [0x9B36]     ; go to 0401 logic
9b33: 33           pulb
9b34: 32           pula
9b35: 39           rts

; end up here immediately if:
; 0x004E == 00 or
; 0x0063, 0x0064 == 0 or
; 
; do subroutines based on bits 0-4 of 0x0401?
9b36: b6 04 01     ldaa (0x0401)
9b39: 84 01        anda 0x01
9b3b: 27 03        beq [0x9B40]
9b3d: bd 9b 6b     jsr (0x9B6B)     ; bit 0 routine
9b40: b6 04 01     ldaa (0x0401)
9b43: 84 02        anda 0x02
9b45: 27 03        beq [0x9B4A]
9b47: bd 9b 99     jsr (0x9B99)     ; bit 1 routine
9b4a: b6 04 01     ldaa (0x0401)
9b4d: 84 04        anda 0x04
9b4f: 27 03        beq [0x9B54]
9b51: bd 9b c7     jsr (0x9BC7)     ; bit 2 routine
9b54: b6 04 01     ldaa (0x0401)
9b57: 84 08        anda 0x08
9b59: 27 03        beq [0x9B5E]
9b5b: bd 9b f5     jsr (0x9BF5)     ; bit 3 routine
9b5e: b6 04 01     ldaa (0x0401)
9b61: 84 10        anda 0x10
9b63: 27 03        beq [0x9B68]
9b65: bd 9c 23     jsr (0x9C23)     ; bit 4 routine
9b68: 33           pulb
9b69: 32           pula
9b6a: 39           rts

; bit 0 routine
9b6b: 18 3c        pshy
9b6d: 18 de 65     ldy (0x0065)
9b70: 18 a6 00     ldaa (Y+0x00)
9b73: 81 ff        cmpa 0xFF
9b75: 27 14        beq [0x9B8B]
9b77: 91 70        cmpa OFFCNT1
9b79: 25 0d        bcs [0x9B88]
9b7b: 18 08        iny
9b7d: 18 a6 00     ldaa (Y+0x00)
9b80: b7 10 80     staa (0x1080)
9b83: 18 08        iny
9b85: 18 df 65     sty (0x0065)
9b88: 18 38        puly
9b8a: 39           rts
9b8b: 18 ce b2 eb  ldy 0xB2EB
9b8f: 18 df 65     sty (0x0065)
9b92: 86 fa        ldaa 0xFA
9b94: 97 70        staa OFFCNT1
9b96: 7e 9b 88     jmp (0x9B88)
9b99: 18 3c        pshy
9b9b: 18 de 67     ldy (0x0067)
9b9e: 18 a6 00     ldaa (Y+0x00)
9ba1: 81 ff        cmpa 0xFF
9ba3: 27 14        beq [0x9BB9]
9ba5: 91 71        cmpa OFFCNT2
9ba7: 25 0d        bcs [0x9BB6]
9ba9: 18 08        iny
9bab: 18 a6 00     ldaa (Y+0x00)
9bae: b7 10 84     staa (0x1084)
9bb1: 18 08        iny
9bb3: 18 df 67     sty (0x0067)
9bb6: 18 38        puly
9bb8: 39           rts

; bit 1 routine
9bb9: 18 ce b3 bd  ldy 0xB3BD
9bbd: 18 df 67     sty (0x0067)
9bc0: 86 e6        ldaa 0xE6
9bc2: 97 71        staa OFFCNT2
9bc4: 7e 9b b6     jmp (0x9BB6)

; bit 2 routine
9bc7: 18 3c        pshy
9bc9: 18 de 69     ldy (0x0069)
9bcc: 18 a6 00     ldaa (Y+0x00)
9bcf: 81 ff        cmpa 0xFF
9bd1: 27 14        beq [0x9BE7]
9bd3: 91 72        cmpa OFFCNT3
9bd5: 25 0d        bcs [0x9BE4]
9bd7: 18 08        iny
9bd9: 18 a6 00     ldaa (Y+0x00)
9bdc: b7 10 88     staa (0x1088)
9bdf: 18 08        iny
9be1: 18 df 69     sty (0x0069)
9be4: 18 38        puly
9be6: 39           rts
9be7: 18 ce b5 31  ldy 0xB531
9beb: 18 df 69     sty (0x0069)
9bee: 86 d2        ldaa 0xD2
9bf0: 97 72        staa OFFCNT3
9bf2: 7e 9b e4     jmp (0x9BE4)

; bit 3 routine
9bf5: 18 3c        pshy
9bf7: 18 de 6b     ldy (0x006B)
9bfa: 18 a6 00     ldaa (Y+0x00)
9bfd: 81 ff        cmpa 0xFF
9bff: 27 14        beq [0x9C15]
9c01: 91 73        cmpa OFFCNT4
9c03: 25 0d        bcs [0x9C12]
9c05: 18 08        iny
9c07: 18 a6 00     ldaa (Y+0x00)
9c0a: b7 10 8c     staa (0x108C)
9c0d: 18 08        iny
9c0f: 18 df 6b     sty (0x006B)
9c12: 18 38        puly
9c14: 39           rts
9c15: 18 ce b4 75  ldy 0xB475
9c19: 18 df 6b     sty (0x006B)
9c1c: 86 be        ldaa 0xBE
9c1e: 97 73        staa OFFCNT4
9c20: 7e 9c 12     jmp (0x9C12)

; bit 4 routine
9c23: 18 3c        pshy
9c25: 18 de 6d     ldy (0x006D)
9c28: 18 a6 00     ldaa (Y+0x00)
9c2b: 81 ff        cmpa 0xFF
9c2d: 27 14        beq [0x9C43]
9c2f: 91 74        cmpa OFFCNT5
9c31: 25 0d        bcs [0x9C40]
9c33: 18 08        iny
9c35: 18 a6 00     ldaa (Y+0x00)
9c38: b7 10 90     staa (0x1090)
9c3b: 18 08        iny
9c3d: 18 df 6d     sty (0x006D)
9c40: 18 38        puly
9c42: 39           rts
9c43: 18 ce b5 c3  ldy 0xB5C3
9c47: 18 df 6d     sty (0x006D)
9c4a: 86 aa        ldaa 0xAA
9c4c: 97 74        staa OFFCNT5
9c4e: 7e 9c 40     jmp (0x9C40)

; Reset offset counters to initial values
9c51: 86 fa        ldaa 0xFA
9c53: 97 70        staa OFFCNT1
9c55: 86 e6        ldaa 0xE6
9c57: 97 71        staa OFFCNT2
9c59: 86 d2        ldaa 0xD2
9c5b: 97 72        staa OFFCNT3
9c5d: 86 be        ldaa 0xBE
9c5f: 97 73        staa OFFCNT4
9c61: 86 aa        ldaa 0xAA
9c63: 97 74        staa OFFCNT5

9c65: 18 ce b2 eb  ldy 0xB2EB
9c69: 18 df 65     sty (0x0065)
9c6c: 18 ce b3 bd  ldy 0xB3BD
9c70: 18 df 67     sty (0x0067)
9c73: 18 ce b5 31  ldy 0xB531
9c77: 18 df 69     sty (0x0069)
9c7a: 18 ce b4 75  ldy 0xB475
9c7e: 18 df 6b     sty (0x006B)
9c81: 18 ce b5 c3  ldy 0xB5C3
9c85: 18 df 6d     sty (0x006D)

9c88: 7f 10 9c     clr (0x109C)
9c8b: 7f 10 9e     clr (0x109E)

9c8e: b6 04 01     ldaa (0x0401)
9c91: 84 20        anda 0x20
9c93: 27 08        beq [0x9C9D]
9c95: b6 10 9c     ldaa (0x109C)
9c98: 8a 19        oraa 0x19
9c9a: b7 10 9c     staa (0x109C)
9c9d: b6 04 01     ldaa (0x0401)
9ca0: 84 40        anda 0x40
9ca2: 27 10        beq [0x9CB4]
9ca4: b6 10 9c     ldaa (0x109C)
9ca7: 8a 44        oraa 0x44
9ca9: b7 10 9c     staa (0x109C)
9cac: b6 10 9e     ldaa (0x109E)
9caf: 8a 40        oraa 0x40
9cb1: b7 10 9e     staa (0x109E)
9cb4: b6 04 01     ldaa (0x0401)
9cb7: 84 80        anda 0x80
9cb9: 27 08        beq [0x9CC3]
9cbb: b6 10 9c     ldaa (0x109C)
9cbe: 8a a2        oraa 0xA2
9cc0: b7 10 9c     staa (0x109C)
9cc3: b6 04 2b     ldaa (0x042B)
9cc6: 84 01        anda 0x01
9cc8: 27 08        beq [0x9CD2]
9cca: b6 10 9a     ldaa (0x109A)
9ccd: 8a 80        oraa 0x80
9ccf: b7 10 9a     staa (0x109A)
9cd2: b6 04 2b     ldaa (0x042B)
9cd5: 84 02        anda 0x02
9cd7: 27 08        beq [0x9CE1]
9cd9: b6 10 9e     ldaa (0x109E)
9cdc: 8a 04        oraa 0x04
9cde: b7 10 9e     staa (0x109E)
9ce1: b6 04 2b     ldaa (0x042B)
9ce4: 84 04        anda 0x04
9ce6: 27 08        beq [0x9CF0]
9ce8: b6 10 9e     ldaa (0x109E)
9ceb: 8a 08        oraa 0x08
9ced: b7 10 9e     staa (0x109E)
9cf0: 39           rts

9cf1: bd 8d e4     jsr (0x8DE4)

'   Program by   '
9cf4: 20 20 20 50 72 6f 67 72 61 6d 20 62 79 20 20 a0 

9d04: bd 8d dd     jsr (0x8DDD)

'David  Philipsen'
9d07: 44 61 76 69 64 20 20 50 68 69 6c 69 70 73 65 ee 

9d17: 39           rts

9d18: 97 49        staa (0x0049)
9d1a: 7f 00 b8     clr (0x00B8)
9d1d: bd 8d 03     jsr (0x8D03)
9d20: 86 2a        ldaa 0x2A            ;'*'
9d22: c6 28        ldab 0x28
9d24: bd 8d b5     jsr (0x8DB5)         ; display char here on LCD display
9d27: cc 0b b8     ldd 0x0BB8
9d2a: dd 1b        std CDTIMR1
9d2c: bd 9b 19     jsr (0x9B19)
9d2f: 96 49        ldaa (0x0049)
9d31: 81 41        cmpa 0x41
9d33: 27 04        beq [0x9D39]
9d35: 81 4b        cmpa 0x4B
9d37: 26 04        bne [0x9D3D]
9d39: c6 01        ldab 0x01
9d3b: d7 b8        stab (0x00B8)
9d3d: 81 41        cmpa 0x41
9d3f: 27 04        beq [0x9D45]
9d41: 81 4f        cmpa 0x4F
9d43: 26 07        bne [0x9D4C]
9d45: 86 01        ldaa 0x01
9d47: b7 02 98     staa (0x0298)
9d4a: 20 32        bra [0x9D7E]
9d4c: 81 4b        cmpa 0x4B
9d4e: 27 04        beq [0x9D54]
9d50: 81 50        cmpa 0x50
9d52: 26 07        bne [0x9D5B]
9d54: 86 02        ldaa 0x02
9d56: b7 02 98     staa (0x0298)
9d59: 20 23        bra [0x9D7E]
9d5b: 81 4c        cmpa 0x4C
9d5d: 26 07        bne [0x9D66]
9d5f: 86 03        ldaa 0x03
9d61: b7 02 98     staa (0x0298)
9d64: 20 18        bra [0x9D7E]
9d66: 81 52        cmpa 0x52
9d68: 26 07        bne [0x9D71]
9d6a: 86 04        ldaa 0x04
9d6c: b7 02 98     staa (0x0298)
9d6f: 20 0d        bra [0x9D7E]
9d71: dc 1b        ldd CDTIMR1
9d73: 26 b7        bne [0x9D2C]
9d75: 86 23        ldaa 0x23            ;'#'
9d77: c6 29        ldab 0x29
9d79: bd 8d b5     jsr (0x8DB5)         ; display char here on LCD display
9d7c: 20 6c        bra [0x9DEA]
9d7e: 7f 00 49     clr (0x0049)
9d81: 86 2a        ldaa 0x2A            ;'*'
9d83: c6 29        ldab 0x29
9d85: bd 8d b5     jsr (0x8DB5)         ; display char here on LCD display
9d88: 7f 00 4a     clr (0x004A)
9d8b: ce 02 99     ldx 0x0299
9d8e: bd 9b 19     jsr (0x9B19)
9d91: 96 4a        ldaa (0x004A)
9d93: 27 f9        beq [0x9D8E]
9d95: 7f 00 4a     clr (0x004A)
9d98: 84 3f        anda 0x3F
9d9a: a7 00        staa (X+0x00)
9d9c: 08           inx
9d9d: 8c 02 9c     cpx 0x029C
9da0: 26 ec        bne [0x9D8E]
9da2: bd 9d f5     jsr (0x9DF5)
9da5: 24 09        bcc [0x9DB0]
9da7: 86 23        ldaa 0x23            ;'#'
9da9: c6 2a        ldab 0x2A
9dab: bd 8d b5     jsr (0x8DB5)         ; display char here on LCD display
9dae: 20 3a        bra [0x9DEA]
9db0: 86 2a        ldaa 0x2A            ;'*'
9db2: c6 2a        ldab 0x2A
9db4: bd 8d b5     jsr (0x8DB5)         ; display char here on LCD display
9db7: b6 02 99     ldaa (0x0299)
9dba: 81 39        cmpa 0x39
9dbc: 26 15        bne [0x9DD3]
9dbe: bd 8d dd     jsr (0x8DDD)

'Generic Showtape'
9dc1: 47 65 6e 65 72 69 63 20 53 68 6f 77 74 61 70 e5 

9dd1: 0c           clc
9dd2: 39           rts

9dd3: b6 02 98     ldaa (0x0298)
9dd6: 81 03        cmpa 0x03
9dd8: 27 0e        beq [0x9DE8]
9dda: 81 04        cmpa 0x04
9ddc: 27 0a        beq [0x9DE8]
9dde: 96 76        ldaa (0x0076)
9de0: 26 06        bne [0x9DE8]
9de2: bd 9e 73     jsr (0x9E73)
9de5: bd 9e cc     jsr (0x9ECC)
9de8: 0c           clc
9de9: 39           rts

9dea: fc 04 20     ldd (0x0420)
9ded: c3 00 01     addd 0x0001
9df0: fd 04 20     std (0x0420)
9df3: 0d           sec
9df4: 39           rts

9df5: b6 02 99     ldaa (0x0299)
9df8: 81 39        cmpa 0x39
9dfa: 27 6c        beq [0x9E68]
9dfc: ce 00 a8     ldx 0x00A8
9dff: bd 9b 19     jsr (0x9B19)
9e02: 96 4a        ldaa (0x004A)
9e04: 27 f9        beq [0x9DFF]
9e06: 7f 00 4a     clr (0x004A)
9e09: a7 00        staa (X+0x00)
9e0b: 08           inx
9e0c: 8c 00 aa     cpx 0x00AA
9e0f: 26 ee        bne [0x9DFF]
9e11: bd 9e fa     jsr (0x9EFA)
9e14: ce 02 99     ldx 0x0299
9e17: 7f 00 13     clr (0x0013)
9e1a: a6 00        ldaa (X+0x00)
9e1c: 9b 13        adda (0x0013)
9e1e: 97 13        staa (0x0013)
9e20: 08           inx
9e21: 8c 02 9c     cpx 0x029C
9e24: 26 f4        bne [0x9E1A]
9e26: 91 a8        cmpa (0x00A8)
9e28: 26 47        bne [0x9E71]
9e2a: ce 04 02     ldx 0x0402
9e2d: b6 02 98     ldaa (0x0298)
9e30: 81 02        cmpa 0x02
9e32: 26 03        bne [0x9E37]
9e34: ce 04 05     ldx 0x0405
9e37: 3c           pshx
9e38: bd ab 56     jsr (0xAB56)
9e3b: 38           pulx
9e3c: 25 07        bcs [0x9E45]
9e3e: 86 03        ldaa 0x03
9e40: b7 02 98     staa (0x0298)
9e43: 20 23        bra [0x9E68]
9e45: b6 02 99     ldaa (0x0299)
9e48: a1 00        cmpa (X+0x00)
9e4a: 25 1e        bcs [0x9E6A]
9e4c: 27 02        beq [0x9E50]
9e4e: 24 18        bcc [0x9E68]
9e50: 08           inx
9e51: b6 02 9a     ldaa (0x029A)
9e54: a1 00        cmpa (X+0x00)
9e56: 25 12        bcs [0x9E6A]
9e58: 27 02        beq [0x9E5C]
9e5a: 24 0c        bcc [0x9E68]
9e5c: 08           inx
9e5d: b6 02 9b     ldaa (0x029B)
9e60: a1 00        cmpa (X+0x00)
9e62: 25 06        bcs [0x9E6A]
9e64: 27 02        beq [0x9E68]
9e66: 24 00        bcc [0x9E68]
9e68: 0c           clc
9e69: 39           rts

9e6a: b6 02 98     ldaa (0x0298)
9e6d: 81 03        cmpa 0x03
9e6f: 27 f7        beq [0x9E68]
9e71: 0d           sec
9e72: 39           rts

9e73: ce 04 02     ldx 0x0402
9e76: b6 02 98     ldaa (0x0298)
9e79: 81 02        cmpa 0x02
9e7b: 26 03        bne [0x9E80]
9e7d: ce 04 05     ldx 0x0405
9e80: b6 02 99     ldaa (0x0299)
9e83: a7 00        staa (X+0x00)
9e85: 08           inx
9e86: b6 02 9a     ldaa (0x029A)
9e89: a7 00        staa (X+0x00)
9e8b: 08           inx
9e8c: b6 02 9b     ldaa (0x029B)
9e8f: a7 00        staa (X+0x00)
9e91: 39           rts

; reset R counts
9e92: 86 30        ldaa 0x30        
9e94: b7 04 02     staa (0x0402)
9e97: b7 04 03     staa (0x0403)
9e9a: b7 04 04     staa (0x0404)
9e9d: bd 8d dd     jsr (0x8DDD)

'Reg # cleared!'
9ea0: 52 65 67 20 23 20 63 6c 65 61 72 65 64 a1

9eae: 39           rts

; reset L counts
9eaf: 86 30        ldaa 0x30
9eb1: b7 04 05     staa (0x0405)
9eb4: b7 04 06     staa (0x0406)
9eb7: b7 04 07     staa (0x0407)
9eba: bd 8d dd     jsr (0x8DDD)

'Liv # cleared!'
9ebd: 4c 69 76 20 23 20 63 6c 65 61 72 65 64 a1

9ecb: 39           rts

; display R and L counts?
9ecc: 86 52        ldaa 0x52            ;'R'
9ece: c6 2b        ldab 0x2B
9ed0: bd 8d b5     jsr (0x8DB5)         ; display char here on LCD display
9ed3: 86 4c        ldaa 0x4C            ;'L'
9ed5: c6 32        ldab 0x32
9ed7: bd 8d b5     jsr (0x8DB5)         ; display char here on LCD display
9eda: ce 04 02     ldx 0x0402
9edd: c6 2c        ldab 0x2C
9edf: a6 00        ldaa (X+0x00)
9ee1: bd 8d b5     jsr (0x8DB5)         ; display 3 chars here on LCD display
9ee4: 5c           incb
9ee5: 08           inx
9ee6: 8c 04 05     cpx 0x0405
9ee9: 26 f4        bne [0x9EDF]
9eeb: c6 33        ldab 0x33
9eed: a6 00        ldaa (X+0x00)
9eef: bd 8d b5     jsr (0x8DB5)         ; display 3 chars here on LCD display
9ef2: 5c           incb
9ef3: 08           inx
9ef4: 8c 04 08     cpx 0x0408
9ef7: 26 f4        bne [0x9EED]
9ef9: 39           rts

9efa: 96 a8        ldaa (0x00A8)
9efc: bd 9f 0f     jsr (0x9F0F)
9eff: 48           asla
9f00: 48           asla
9f01: 48           asla
9f02: 48           asla
9f03: 97 13        staa (0x0013)
9f05: 96 a9        ldaa (0x00A9)
9f07: bd 9f 0f     jsr (0x9F0F)
9f0a: 9b 13        adda (0x0013)
9f0c: 97 a8        staa (0x00A8)
9f0e: 39           rts

9f0f: 81 2f        cmpa 0x2F
9f11: 24 02        bcc [0x9F15]
9f13: 86 30        ldaa 0x30
9f15: 81 3a        cmpa 0x3A
9f17: 25 02        bcs [0x9F1B]
9f19: 80 07        suba 0x07
9f1b: 80 30        suba 0x30
9f1d: 39           rts

9f1e: fc 02 9c     ldd (0x029C)
9f21: 1a 83 00 01  cpd 0x0001
9f25: 27 0c        beq [0x9F33]
9f27: 1a 83 03 e8  cpd 0x03E8
9f2b: 25 20        bcs [0x9F4D]
9f2d: 1a 83 04 4b  cpd 0x044B
9f31: 22 1a        bhi [0x9F4D]
9f33: bd 8d e4     jsr (0x8DE4)

'Password bypass '
9f36: 50 61 73 73 77 6f 72 64 20 62 79 70 61 73 73 a0

9f46: c6 04        ldab 0x04
9f48: bd 8c 30     jsr (0x8C30)
9f4b: 0c           clc
9f4c: 39           rts

9f4d: bd 8c f2     jsr (0x8CF2)
9f50: bd 8d 03     jsr (0x8D03)
9f53: bd 8d e4     jsr (0x8DE4)

'Code:'
9f56: 43 6f 64 65 ba

9f5b: ce 02 90     ldx 0x0290
9f5e: 7f 00 16     clr (0x0016)
9f61: 86 41        ldaa 0x41
9f63: 97 15        staa (0x0015)
9f65: bd 8e 95     jsr (0x8E95)
9f68: 81 0d        cmpa 0x0D
9f6a: 26 11        bne [0x9F7D]
9f6c: 96 15        ldaa (0x0015)
9f6e: a7 00        staa (X+0x00)
9f70: 08           inx
9f71: bd 8c 98     jsr (0x8C98)
9f74: 96 16        ldaa (0x0016)
9f76: 4c           inca
9f77: 97 16        staa (0x0016)
9f79: 81 05        cmpa 0x05
9f7b: 27 09        beq [0x9F86]
9f7d: 96 15        ldaa (0x0015)
9f7f: 4c           inca
9f80: 81 5b        cmpa 0x5B
9f82: 27 dd        beq [0x9F61]
9f84: 20 dd        bra [0x9F63]
9f86: bd 8d dd     jsr (0x8DDD)

'Pswd:'
9f89: 50 73 77 64 ba 

9f8e: ce 02 88     ldx 0x0288
9f91: 86 41        ldaa 0x41
9f93: 97 16        staa (0x0016)
9f95: 86 c5        ldaa 0xC5
9f97: 97 15        staa (0x0015)
9f99: 96 15        ldaa (0x0015)
9f9b: bd 8c 86     jsr (0x8C86)     ; write byte to LCD
9f9e: 96 16        ldaa (0x0016)
9fa0: bd 8c 98     jsr (0x8C98)
9fa3: bd 8e 95     jsr (0x8E95)
9fa6: 27 fb        beq [0x9FA3]
9fa8: 81 0d        cmpa 0x0D
9faa: 26 10        bne [0x9FBC]
9fac: 96 16        ldaa (0x0016)
9fae: a7 00        staa (X+0x00)
9fb0: 08           inx
9fb1: 96 15        ldaa (0x0015)
9fb3: 4c           inca
9fb4: 97 15        staa (0x0015)
9fb6: 81 ca        cmpa 0xCA
9fb8: 27 28        beq [0x9FE2]
9fba: 20 dd        bra [0x9F99]
9fbc: 81 01        cmpa 0x01
9fbe: 26 0f        bne [0x9FCF]
9fc0: 96 16        ldaa (0x0016)
9fc2: 4c           inca
9fc3: 97 16        staa (0x0016)
9fc5: 81 5b        cmpa 0x5B
9fc7: 26 d0        bne [0x9F99]
9fc9: 86 41        ldaa 0x41
9fcb: 97 16        staa (0x0016)
9fcd: 20 ca        bra [0x9F99]
9fcf: 81 02        cmpa 0x02
9fd1: 26 d0        bne [0x9FA3]
9fd3: 96 16        ldaa (0x0016)
9fd5: 4a           deca
9fd6: 97 16        staa (0x0016)
9fd8: 81 40        cmpa 0x40
9fda: 26 bd        bne [0x9F99]
9fdc: 86 5a        ldaa 0x5A
9fde: 97 16        staa (0x0016)
9fe0: 20 b7        bra [0x9F99]
9fe2: bd a0 01     jsr (0xA001)
9fe5: 25 0f        bcs [0x9FF6]
9fe7: 86 db        ldaa 0xDB
9fe9: 97 ab        staa (0x00AB)
9feb: fc 04 16     ldd (0x0416)
9fee: c3 00 01     addd 0x0001
9ff1: fd 04 16     std (0x0416)
9ff4: 0c           clc
9ff5: 39           rts

9ff6: fc 04 14     ldd (0x0414)
9ff9: c3 00 01     addd 0x0001
9ffc: fd 04 14     std (0x0414)
9fff: 0d           sec
a000: 39           rts

a001: b6 02 90     ldaa (0x0290)
a004: b7 02 81     staa (0x0281)
a007: b6 02 91     ldaa (0x0291)
a00a: b7 02 83     staa (0x0283)
a00d: b6 02 92     ldaa (0x0292)
a010: b7 02 84     staa (0x0284)
a013: b6 02 93     ldaa (0x0293)
a016: b7 02 80     staa (0x0280)
a019: b6 02 94     ldaa (0x0294)
a01c: b7 02 82     staa (0x0282)
a01f: b6 02 80     ldaa (0x0280)
a022: 88 13        eora 0x13
a024: 8b 03        adda 0x03
a026: b7 02 80     staa (0x0280)
a029: b6 02 81     ldaa (0x0281)
a02c: 88 04        eora 0x04
a02e: 8b 12        adda 0x12
a030: b7 02 81     staa (0x0281)
a033: b6 02 82     ldaa (0x0282)
a036: 88 06        eora 0x06
a038: 8b 04        adda 0x04
a03a: b7 02 82     staa (0x0282)
a03d: b6 02 83     ldaa (0x0283)
a040: 88 11        eora 0x11
a042: 8b 07        adda 0x07
a044: b7 02 83     staa (0x0283)
a047: b6 02 84     ldaa (0x0284)
a04a: 88 01        eora 0x01
a04c: 8b 10        adda 0x10
a04e: b7 02 84     staa (0x0284)
a051: bd a0 af     jsr (0xA0AF)
a054: b6 02 94     ldaa (0x0294)
a057: 84 17        anda 0x17
a059: 97 15        staa (0x0015)
a05b: b6 02 90     ldaa (0x0290)
a05e: 84 17        anda 0x17
a060: 97 16        staa (0x0016)
a062: ce 02 80     ldx 0x0280
a065: a6 00        ldaa (X+0x00)
a067: 98 15        eora (0x0015)
a069: 98 16        eora (0x0016)
a06b: a7 00        staa (X+0x00)
a06d: 08           inx
a06e: 8c 02 85     cpx 0x0285
a071: 26 f2        bne [0xA065]
a073: bd a0 af     jsr (0xA0AF)
a076: ce 02 80     ldx 0x0280
a079: 18 ce 02 88  ldy 0x0288
a07d: a6 00        ldaa (X+0x00)
a07f: 18 a1 00     cmpa (Y+0x00)
a082: 26 0a        bne [0xA08E]
a084: 08           inx
a085: 18 08        iny
a087: 8c 02 85     cpx 0x0285
a08a: 26 f1        bne [0xA07D]
a08c: 0c           clc
a08d: 39           rts

a08e: 0d           sec
a08f: 39           rts

a090: 59           rolb
a091: 41           ?
a092: 44           lsra
a093: 44           lsra
a094: 41           ?
a095: ce 02 88     ldx 0x0288
a098: 18 ce a0 90  ldy 0xA090
a09c: a6 00        ldaa (X+0x00)
a09e: 18 a1 00     cmpa (Y+0x00)
a0a1: 26 0a        bne [0xA0AD]
a0a3: 08           inx
a0a4: 18 08        iny
a0a6: 8c 02 8d     cpx 0x028D
a0a9: 26 f1        bne [0xA09C]
a0ab: 0c           clc
a0ac: 39           rts

a0ad: 0d           sec
a0ae: 39           rts

a0af: ce 02 80     ldx 0x0280
a0b2: a6 00        ldaa (X+0x00)
a0b4: 81 5b        cmpa 0x5B
a0b6: 25 06        bcs [0xA0BE]
a0b8: 80 1a        suba 0x1A
a0ba: a7 00        staa (X+0x00)
a0bc: 20 08        bra [0xA0C6]
a0be: 81 41        cmpa 0x41
a0c0: 24 04        bcc [0xA0C6]
a0c2: 8b 1a        adda 0x1A
a0c4: a7 00        staa (X+0x00)
a0c6: 08           inx
a0c7: 8c 02 85     cpx 0x0285
a0ca: 26 e6        bne [0xA0B2]
a0cc: 39           rts

a0cd: bd 8c f2     jsr (0x8CF2)
a0d0: bd 8d dd     jsr (0x8DDD)

'Failed!         '
a0d3: 46 61 69 6c 65 64 21 20 20 20 20 20 20 20 20 a0 

a0e3: c6 02        ldab 0x02
a0e5: bd 8c 30     jsr (0x8C30)
a0e8: 39           rts

a0e9: c6 01        ldab 0x01
a0eb: bd 8c 30     jsr (0x8C30)
a0ee: 7f 00 4e     clr (0x004E)
a0f1: c6 d3        ldab 0xD3
a0f3: bd 87 48     jsr (0x8748)
a0f6: bd 87 ae     jsr (0x87AE)
a0f9: bd 8c e9     jsr (0x8CE9)
a0fc: bd 8d e4     jsr (0x8DE4)

'   VCR adjust'
a0ff: 20 20 20 56 43 52 20 61 64 6a 75 73 f4

a10c: bd 8d dd     jsr (0x8DDD)

'UP to clear bits'
a10f: 55 50 20 74 6f 20 63 6c 65 61 72 20 62 69 74 f3 

a11f: 5f           clrb
a120: d7 62        stab (0x0062)
a122: bd f9 c5     jsr (0xF9C5)
a125: b6 18 04     ldaa (0x1804)
a128: 84 bf        anda 0xBF
a12a: b7 18 04     staa (0x1804)
a12d: bd 8e 95     jsr (0x8E95)
a130: 7f 00 48     clr (0x0048)
a133: 7f 00 49     clr (0x0049)
a136: bd 86 c4     jsr L86C4
a139: 86 28        ldaa 0x28
a13b: 97 63        staa (0x0063)
a13d: c6 fd        ldab 0xFD
a13f: bd 86 e7     jsr (0x86E7)
a142: bd a3 2e     jsr (0xA32E)
a145: 7c 00 76     inc (0x0076)
a148: 7f 00 32     clr (0x0032)
a14b: bd 8e 95     jsr (0x8E95)
a14e: 81 0d        cmpa 0x0D
a150: 26 03        bne [0xA155]
a152: 7e a1 c4     jmp (0xA1C4)
a155: 86 28        ldaa 0x28
a157: 97 63        staa (0x0063)
a159: bd 86 a4     jsr (0x86A4)
a15c: 25 ed        bcs [0xA14B]
a15e: fc 04 1a     ldd (0x041A)
a161: c3 00 01     addd 0x0001
a164: fd 04 1a     std (0x041A)
a167: bd 86 c4     jsr L86C4
a16a: 7c 00 4e     inc (0x004E)
a16d: c6 d3        ldab 0xD3
a16f: bd 87 48     jsr (0x8748)
a172: bd 87 ae     jsr (0x87AE)
a175: 96 49        ldaa (0x0049)
a177: 81 43        cmpa 0x43
a179: 26 06        bne [0xA181]
a17b: 7f 00 49     clr (0x0049)
a17e: 7f 00 48     clr (0x0048)
a181: 96 48        ldaa (0x0048)
a183: 81 c8        cmpa 0xC8
a185: 25 1f        bcs [0xA1A6]
a187: fc 02 9c     ldd (0x029C)
a18a: 1a 83 00 01  cpd 0x0001
a18e: 27 16        beq [0xA1A6]
a190: c6 ef        ldab 0xEF
a192: bd 86 e7     jsr (0x86E7)
a195: bd 86 c4     jsr L86C4
a198: 7f 00 4e     clr (0x004E)
a19b: 7f 00 76     clr (0x0076)
a19e: c6 0a        ldab 0x0A
a1a0: bd 8c 30     jsr (0x8C30)
a1a3: 7e 81 d7     jmp (0x81D7)
a1a6: bd 8e 95     jsr (0x8E95)
a1a9: 81 01        cmpa 0x01
a1ab: 26 10        bne [0xA1BD]
a1ad: ce 10 80     ldx 0x1080
a1b0: 86 34        ldaa 0x34
a1b2: 6f 00        clr (X+0x00)
a1b4: a7 01        staa (X+0x01)
a1b6: 08           inx
a1b7: 08           inx
a1b8: 8c 10 a0     cpx 0x10A0
a1bb: 25 f5        bcs [0xA1B2]
a1bd: 81 0d        cmpa 0x0D
a1bf: 27 03        beq [0xA1C4]
a1c1: 7e a1 75     jmp (0xA175)
a1c4: 7f 00 76     clr (0x0076)
a1c7: 7f 00 4e     clr (0x004E)
a1ca: c6 df        ldab 0xDF
a1cc: bd 87 48     jsr (0x8748)
a1cf: bd 87 91     jsr (0x8791)
a1d2: 7e 81 d7     jmp (0x81D7)
a1d5: 86 07        ldaa 0x07
a1d7: b7 04 00     staa (0x0400)
a1da: cc 0e 09     ldd 0x0E09
a1dd: 81 65        cmpa 0x65
a1df: 26 05        bne [0xA1E6]
a1e1: c1 63        cmpb 0x63
a1e3: 26 01        bne [0xA1E6]
a1e5: 39           rts

a1e6: 86 0e        ldaa 0x0E
a1e8: b7 10 3b     staa (PPROG)
a1eb: 86 ff        ldaa 0xFF
a1ed: b7 0e 00     staa (0x0E00)
a1f0: b6 10 3b     ldaa (PPROG)
a1f3: 8a 01        oraa 0x01
a1f5: b7 10 3b     staa (PPROG)
a1f8: ce 1b 58     ldx 0x1B58
a1fb: 09           dex
a1fc: 26 fd        bne [0xA1FB]
a1fe: b6 10 3b     ldaa (PPROG)
a201: 84 fe        anda 0xFE
a203: b7 10 3b     staa (PPROG)
a206: ce 0e 00     ldx 0x0E00
a209: 18 ce a2 26  ldy 0xA226
a20d: c6 02        ldab 0x02
a20f: f7 10 3b     stab (PPROG)
a212: 18 a6 00     ldaa (Y+0x00)
a215: 18 08        iny
a217: a7 00        staa (X+0x00)
a219: bd a2 32     jsr (0xA232)
a21c: 08           inx
a21d: 8c 0e 0c     cpx 0x0E0C
a220: 26 eb        bne [0xA20D]
a222: 7f 10 3b     clr (PPROG)
a225: 39           rts

a226: 29 64        bvs [0xA28C]
a228: 2a 21        bpl [0xA24B]
a22a: 32           pula
a22b: 3a           abx
a22c: 3a           abx
a22d: 34           des
a22e: 21 65        brn [0xA295]
a230: 63 71        com (X+0x71)

; program EEPROM
a232: 18 3c        pshy
a234: c6 03        ldab 0x03
a236: f7 10 3b     stab (PPROG)     ; start program
a239: 18 ce 1b 58  ldy 0x1B58
a23d: 18 09        dey
a23f: 26 fc        bne [0xA23D]
a241: c6 02        ldab 0x02
a243: f7 10 3b     stab (PPROG)     ; stop program
a246: 18 38        puly
a248: 39           rts

a249: 0f           sei
a24a: ce 00 10     ldx 0x0010
a24d: 6f 00        clr (X+0x00)
a24f: 08           inx
a250: 8c 0e 00     cpx 0x0E00
a253: 26 f8        bne [0xA24D]
a255: bd 9e af     jsr (0x9EAF)     ; reset L counts
a258: bd 9e 92     jsr (0x9E92)     ; reset R counts
a25b: 7e f8 00     jmp RESET     ; reset controller

; Compute and store copyright checksum
.endif
        .org    0xa25e
LA25E:
        ldy     #CPYRTMSG       ; copyright message
        ldx     #0x0000
LA265:
        ldab    0,Y
        abx
        iny
        cpy     #0x8050
        bne     LA265
        stx     CPYRTCS         ; store checksum here
        rts

; Erase EEPROM routine
LA275:
.if 0
a275: 0f           sei
a276: 7f 04 0f     clr ERASEFLG     ; Reset EEPROM Erase flag
a279: 86 0e        ldaa 0x0E
a27b: b7 10 3b     staa (PPROG)     ; ERASE mode!
a27e: 86 ff        ldaa 0xFF
a280: b7 0e 20     staa (0x0E20)    ; save in NVRAM
a283: b6 10 3b     ldaa (PPROG)
a286: 8a 01        oraa 0x01
a288: b7 10 3b     staa (PPROG)     ; do the ERASE
a28b: ce 1b 58     ldx 0x1B58       ; delay a bit
a28e: 09           dex
a28f: 26 fd        bne [0xA28E]
a291: b6 10 3b     ldaa (PPROG)
a294: 84 fe        anda 0xFE        ; stop erasing
a296: 7f 10 3b     clr (PPROG)

a299: bd f9 d8     jsr (0xF9D8)     ; display "enter serial number"

'Enter serial #: '
a29c: 45 6e 74 65 72 20 73 65 72 69 61 6c 20 23 3a a0 

a2ac: ce 0e 20     ldx 0x0E20
a2af: bd f9 45     jsr (0xF945)     ; wait for serial data
a2b2: 24 fb        bcc [0xA2AF]

a2b4: bd f9 6f     jsr (0xF96F)     ; read serial data
a2b7: c6 02        ldab 0x02
a2b9: f7 10 3b     stab (PPROG)     ; protect only 0x0e20-0x0e5f
a2bc: a7 00        staa (X+0x00)    
a2be: bd a2 32     jsr (0xA232)     ; program byte
a2c1: 08           inx
a2c2: 8c 0e 24     cpx 0x0E24
a2c5: 26 e8        bne [0xA2AF]
a2c7: c6 02        ldab 0x02
a2c9: f7 10 3b     stab (PPROG)
a2cc: 86 db        ldaa 0xDB        ; it's official
a2ce: b7 0e 24     staa (0x0E24)
a2d1: bd a2 32     jsr (0xA232)     ; program byte
a2d4: 7f 10 3b     clr (PPROG)
a2d7: 86 1e        ldaa 0x1E
a2d9: b7 10 35     staa BPROT       ; protect all but 0x0e00-0x0e1f
a2dc: 7e f8 00     jmp RESET     ; reset controller

a2df: 38           pulx
a2e0: 3c           pshx
a2e1: 8c 80 00     cpx 0x8000
a2e4: 25 02        bcs [0xA2E8]
a2e6: 0c           clc
a2e7: 39           rts

a2e8: 0d           sec
a2e9: 39           rts

; validate security code?
a2ea: ce 02 88     ldx 0x0288
a2ed: c6 03        ldab 0x03        ; 3 character code

a2ef: bd f9 45     jsr (0xF945)     ; check if available
a2f2: 24 fb        bcc [0xA2EF]
a2f4: a7 00        staa (X+0x00)
a2f6: 08           inx
a2f7: 5a           decb
a2f8: 26 f5        bne [0xA2EF]

a2fa: b6 02 88     ldaa (0x0288)
a2fd: 81 13        cmpa 0x13        ; 0x13
a2ff: 26 10        bne [0xA311]
a301: b6 02 89     ldaa (0x0289)
a304: 81 10        cmpa 0x10        ; 0x10
a306: 26 09        bne [0xA311]
a308: b6 02 8a     ldaa (0x028A)
a30b: 81 14        cmpa 0x14        ; 0x14
a30d: 26 02        bne [0xA311]
a30f: 0c           clc
a310: 39           rts

a311: 0d           sec
a312: 39           rts

a313: 36           psha
a314: b6 10 92     ldaa (0x1092)
a317: 8a 01        oraa 0x01
a319: b7 10 92     staa (0x1092)
a31c: 32           pula
a31d: 39           rts

a31e: 36           psha
a31f: b6 10 92     ldaa (0x1092)
a322: 84 fe        anda 0xFE
a324: 20 f3        bra [0xA319]
a326: 96 4e        ldaa (0x004E)
a328: 97 19        staa (0x0019)
a32a: 7f 00 4e     clr (0x004E)
a32d: 39           rts

a32e: b6 10 86     ldaa (0x1086)
a331: 8a 15        oraa 0x15
a333: b7 10 86     staa (0x1086)
a336: c6 01        ldab 0x01
a338: bd 8c 30     jsr (0x8C30)
a33b: 84 ea        anda 0xEA
a33d: b7 10 86     staa (0x1086)
a340: 39           rts

a341: b6 10 86     ldaa (0x1086)
a344: 8a 2a        oraa 0x2A
a346: b7 10 86     staa (0x1086)
a349: c6 01        ldab 0x01
a34b: bd 8c 30     jsr (0x8C30)
a34e: 84 d5        anda 0xD5
a350: b7 10 86     staa (0x1086)
a353: 39           rts

a354: f6 18 04     ldab (0x1804)
a357: ca 08        orab 0x08
a359: f7 18 04     stab (0x1804)
a35c: 39           rts

a35d: f6 18 04     ldab (0x1804)
a360: c4 f7        andb 0xF7
a362: f7 18 04     stab (0x1804)
a365: 39           rts

;'$' command goes here?
a366: 7f 00 4e     clr (0x004E)
a369: bd 86 c4     jsr L86C4
a36c: 7f 04 2a     clr (0x042A)

a36f: bd f9 d8     jsr (0xF9D8)

'Enter security code:'
a372: 45 6e 74 65 72 20 73 65 63 75 72 69 74 79 20 63 6f 64 65 ba 

a386: bd a2 ea     jsr (0xA2EA)
a389: 24 03        bcc [0xA38E]
a38b: 7e 83 31     jmp (0x8331)

a38e: bd f9 d8     jsr (0xF9D8)

'\f\n\rDave's Setup Utility\n\r
 <K>ing enable\n\r
 <C>lear random\n\r
 <5> character random\n\r
 <L>ive tape number clear\n\r
 <R>egular tape number clear\n\r
 <T>est driver boards\n\r
 <B>ub test\n\r
 <D>eck test (with tape inserted)\n\r
 <7>5% adjustment\n\r
 <S>how re-valid tapes\n\r
 <J>ump to system\n\r'

a391: 0c 0a 0d 44 61 76 65 27 73 20 53 65 74 75 70 20 
a3a1: 55 74 69 6c 69 74 79 0a 0d 3c 4b 3e 69 6e 67 20
a3b1: 65 6e 61 62 6c 65 0a 0d 3c 43 3e 6c 65 61 72 20 
a3c1: 72 61 6e 64 6f 6d 0a 0d 3c 35 3e 20 63 68 61 72
a3d1: 61 63 74 65 72 20 72 61 6e 64 6f 6d 0a 0d 3c 4c
a3e1: 3e 69 76 65 20 74 61 70 65 20 6e 75 6d 62 65 72
a3f1: 20 63 6c 65 61 72 0a 0d 3c 52 3e 65 67 75 6c 61
a401: 72 20 74 61 70 65 20 6e 75 6d 62 65 72 20 63 6c
a411: 65 61 72 0a 0d 3c 54 3e 65 73 74 20 64 72 69 76
a421: 65 72 20 62 6f 61 72 64 73 0a 0d 3c 42 3e 75 62
a431: 20 74 65 73 74 0a 0d 3c 44 3e 65 63 6b 20 74 65
a441: 73 74 20 28 77 69 74 68 20 74 61 70 65 20 69 6e
a451: 73 65 72 74 65 64 29 0a 0d 3c 37 3e 35 25 20 61
a461: 64 6a 75 73 74 6d 65 6e 74 0a 0d 3c 53 3e 68 6f
a471: 77 20 72 65 2d 76 61 6c 69 64 20 74 61 70 65 73 
a481: 0a 0d 3c 4a 3e 75 6d 70 20 74 6f 20 73 79 73 74 
a491: 65 6d 0a 8d 

a495: bd f9 45     jsr (0xF945)
a498: 24 fb        bcc [0xA495]
a49A: 81 43        cmpa 0x43        ;'C'
a49c: 26 09        bne [0xA4A7]
a49e: 7f 04 01     clr (0x0401)     ;clear random
a4a1: 7f 04 2b     clr (0x042B)
a4a4: 7e a5 14     jmp (0xA514)
a4a7: 81 35        cmpa 0x35        ;'5'
a4a9: 26 0d        bne [0xA4B8]
a4ab: b6 04 01     ldaa (0x0401)    ;5 character random
a4ae: 84 7f        anda 0x7F
a4b0: 8a 7f        oraa 0x7F
a4b2: b7 04 01     staa (0x0401)
a4b5: 7e a5 14     jmp (0xA514)
a4b8: 81 4c        cmpa 0x4C        ;'L'
a4ba: 26 06        bne [0xA4C2]
a4bc: bd 9e af     jsr (0x9EAF)     ; reset Liv counts
a4bf: 7e a5 14     jmp (0xA514)
a4c2: 81 52        cmpa 0x52        ;'R'
a4c4: 26 06        bne [0xA4CC]
a4c6: bd 9e 92     jsr (0x9E92)     ; reset Reg counts
a4c9: 7e a5 14     jmp (0xA514)
a4cc: 81 54        cmpa 0x54        ;'T'
a4ce: 26 06        bne [0xA4D6]
a4d0: bd a5 65     jsr (0xA565)     ;test driver boards
a4d3: 7e a5 14     jmp (0xA514)
a4d6: 81 42        cmpa 0x42        ;'B'
a4d8: 26 06        bne [0xA4E0]
a4da: bd a5 26     jsr (0xA526)     ;bulb test?
a4dd: 7e a5 14     jmp (0xA514)
a4e0: 81 44        cmpa 0x44        ;'D'
a4e2: 26 06        bne [0xA4EA]
a4e4: bd a5 3c     jsr (0xA53C)     ;deck test
a4e7: 7e a5 14     jmp (0xA514)
a4ea: 81 37        cmpa 0x37        ;'7'
a4ec: 26 08        bne [0xA4F6]
a4ee: c6 fb        ldab 0xFB
a4f0: bd 86 e7     jsr (0x86E7)     ;5% adjustment
a4f3: 7e a5 14     jmp (0xA514)
a4f6: 81 4a        cmpa 0x4A        ;'J'
a4f8: 26 03        bne [0xA4FD]
a4fa: 7e f8 00     jmp RESET     ;jump to system (reset)
a4fd: 81 4b        cmpa 0x4B        ;'K'
a4ff: 26 06        bne [0xA507]
a501: 7c 04 2a     inc (0x042A)     ;King enable
a504: 7e a5 14     jmp (0xA514)
a507: 81 53        cmpa 0x53        ;'S'
a509: 26 06        bne [0xA511]
a50b: bd ab 7c     jsr (0xAB7C)     ;show re-valid tapes
a50e: 7e a5 14     jmp (0xA514)
a511: 7e a4 95     jmp (0xA495)
a514: 86 07        ldaa 0x07
a516: bd f9 6f     jsr (0xF96F)
a519: c6 01        ldab 0x01
a51b: bd 8c 30     jsr (0x8C30)
a51e: 86 07        ldaa 0x07
a520: bd f9 6f     jsr (0xF96F)
a523: 7e a3 8e     jmp (0xA38E)

; bulb test
a526: 5f           clrb
a527: bd f9 c5     jsr (0xF9C5)
a52a: f6 10 0a     ldab PORTE
a52d: c8 ff        eorb 0xFF
a52f: bd f9 c5     jsr (0xF9C5)
a532: c1 80        cmpb 0x80
a534: 26 f4        bne [0xA52A]
a536: c6 02        ldab 0x02
a538: bd 8c 30     jsr (0x8C30)
a53b: 39           rts

; deck test
a53c: c6 fd        ldab 0xFD
a53e: bd 86 e7     jsr (0x86E7)
a541: c6 06        ldab 0x06
a543: bd 8c 30     jsr (0x8C30)
a546: c6 fb        ldab 0xFB
a548: bd 86 e7     jsr (0x86E7)
a54b: c6 06        ldab 0x06
a54d: bd 8c 30     jsr (0x8C30)
a550: c6 fd        ldab 0xFD
a552: bd 86 e7     jsr (0x86E7)
a555: c6 f7        ldab 0xF7
a557: bd 86 e7     jsr (0x86E7)
a55a: c6 06        ldab 0x06
a55c: bd 8c 30     jsr (0x8C30)
a55f: c6 ef        ldab 0xEF
a561: bd 86 e7     jsr (0x86E7)
a564: 39           rts

; test driver boards
a565: bd f9 45     jsr (0xF945)
a568: 24 08        bcc [0xA572]
a56a: 81 1b        cmpa 0x1B
a56c: 26 04        bne [0xA572]
a56e: bd 86 c4     jsr L86C4
a571: 39           rts
a572: 86 08        ldaa 0x08
a574: 97 15        staa (0x0015)
a576: bd 86 c4     jsr L86C4
a579: 86 01        ldaa 0x01
a57b: 36           psha
a57c: 16           tab
a57d: bd f9 c5     jsr (0xF9C5)
a580: b6 18 04     ldaa (0x1804)
a583: 88 08        eora 0x08
a585: b7 18 04     staa (0x1804)
a588: 32           pula
a589: b7 10 80     staa (0x1080)
a58c: b7 10 84     staa (0x1084)
a58f: b7 10 88     staa (0x1088)
a592: b7 10 8c     staa (0x108C)
a595: b7 10 90     staa (0x1090)
a598: b7 10 94     staa (0x1094)
a59b: b7 10 98     staa (0x1098)
a59e: b7 10 9c     staa (0x109C)
a5a1: c6 14        ldab 0x14
a5a3: bd a6 52     jsr (0xA652)
a5a6: 49           rola
a5a7: 36           psha
a5a8: d6 15        ldab (0x0015)
a5aa: 5a           decb
a5ab: d7 15        stab (0x0015)
a5ad: bd f9 95     jsr (0xF995)         ; write digit to the diag display
a5b0: 37           pshb
a5b1: c6 27        ldab 0x27
a5b3: 96 15        ldaa (0x0015)
a5b5: 0c           clc
a5b6: 89 30        adca 0x30
a5b8: bd 8d b5     jsr (0x8DB5)         ; display char here on LCD display
a5bb: 33           pulb
a5bc: 32           pula
a5bd: 5d           tstb
a5be: 26 bb        bne [0xA57B]
a5c0: 86 08        ldaa 0x08
a5c2: 97 15        staa (0x0015)
a5c4: bd 86 c4     jsr L86C4
a5c7: 86 01        ldaa 0x01
a5c9: b7 10 82     staa (0x1082)
a5cc: b7 10 86     staa (0x1086)
a5cf: b7 10 8a     staa (0x108A)
a5d2: b7 10 8e     staa (0x108E)
a5d5: b7 10 92     staa (0x1092)
a5d8: b7 10 96     staa (0x1096)
a5db: b7 10 9a     staa (0x109A)
a5de: b7 10 9e     staa (0x109E)
a5e1: c6 14        ldab 0x14
a5e3: bd a6 52     jsr (0xA652)
a5e6: 49           rola
a5e7: 36           psha
a5e8: d6 15        ldab (0x0015)
a5ea: 5a           decb
a5eb: d7 15        stab (0x0015)
a5ed: bd f9 95     jsr (0xF995)          ; write digit to the diag display
a5f0: 37           pshb
a5f1: c6 27        ldab 0x27
a5f3: 96 15        ldaa (0x0015)
a5f5: 0c           clc
a5f6: 89 30        adca 0x30
a5f8: bd 8d b5     jsr (0x8DB5)         ; display char here on LCD display
a5fb: 33           pulb
a5fc: 32           pula
a5fd: 7d 00 15     tst (0x0015)
a600: 26 c7        bne [0xA5C9]
a602: bd 86 c4     jsr L86C4
a605: ce 10 80     ldx 0x1080
a608: c6 00        ldab 0x00
a60a: 86 ff        ldaa 0xFF
a60c: a7 00        staa (X+0x00)
a60e: a7 02        staa (X+0x02)
a610: 37           pshb
a611: c6 1e        ldab 0x1E
a613: bd a6 52     jsr (0xA652)
a616: 33           pulb
a617: 86 00        ldaa 0x00
a619: a7 00        staa (X+0x00)
a61b: a7 02        staa (X+0x02)
a61d: 5c           incb
a61e: 3c           pshx
a61f: bd f9 95     jsr (0xF995)              ; write digit to the diag display
a622: 37           pshb
a623: c6 27        ldab 0x27
a625: 32           pula
a626: 36           psha
a627: 0c           clc
a628: 89 30        adca 0x30
a62a: bd 8d b5     jsr (0x8DB5)         ; display char here on LCD display
a62d: 33           pulb
a62e: 38           pulx
a62f: 08           inx
a630: 08           inx
a631: 08           inx
a632: 08           inx
a633: 8c 10 9d     cpx 0x109D
a636: 25 d2        bcs [0xA60A]
a638: ce 10 80     ldx 0x1080
a63b: 86 ff        ldaa 0xFF
a63d: a7 00        staa (X+0x00)
a63f: a7 02        staa (X+0x02)
a641: 08           inx
a642: 08           inx
a643: 08           inx
a644: 08           inx
a645: 8c 10 9d     cpx 0x109D
a648: 25 f1        bcs [0xA63B]
a64a: c6 06        ldab 0x06
a64c: bd 8c 30     jsr (0x8C30)
a64f: 7e a5 65     jmp (0xA565)
a652: 36           psha
a653: 4f           clra
a654: dd 23        std CDTIMR5
a656: 7d 00 24     tst CDTIMR5+1
a659: 26 fb        bne [0xA656]
a65b: 32           pula
a65c: 39           rts
.endif

        .org    0xa65d

; Comma-seperated text
LA65D:
        .ascii  '0,Chuck,Mouth,'
        .ascii  '1,Head left,'
        .ascii  '2,Head right,'
        .ascii  '2,Head up,'
        .ascii  '2,Eyes right,'
        .ascii  '1,Eyelids,'
        .ascii  '1,Right hand,'
        .ascii  '2,Eyes left,'
        .ascii  '1,8,Helen,Mouth,'
        .ascii  '1,Head left,'
        .ascii  '2,Head right,'
        .ascii  '2,Head up,'
        .ascii  '2,Eyes right,'
        .ascii  '1,Eyelids,'
        .ascii  '1,Right hand,'
        .ascii  '2,Eyes left,'
        .ascii  '1,6,Munch,Mouth,'
        .ascii  '1,Head left,'
        .ascii  '2,Head right,'
        .ascii  '2,Left arm,'
        .ascii  '2,Eyes right,'
        .ascii  '1,Eyelids,'
        .ascii  '1,Right arm,'
        .ascii  '2,Eyes left,'
        .ascii  '1,2,Jasper,Mouth,'
        .ascii  '1,Head left,'
        .ascii  '2,Head right,'
        .ascii  '2,Head up,'
        .ascii  '2,Eyes right,'
        .ascii  '1,Eyelids,'
        .ascii  '1,Hands,'
        .ascii  '2,Eyes left,'
        .ascii  '1,4,Pasqually,Mouth-Mustache,'
        .ascii  '1,Head left,'
        .ascii  '2,Head right,'
        .ascii  '2,Left arm,'
        .ascii  '2,Eyes right,'
        .ascii  '1,Eyelids,'
        .ascii  '1,Right arm,'
        .ascii  '2,Eyes left,1,<'

        jsr     L86C4
        ldx     #0x1080
        ldaa    #0x20
        staa    0,X
        staa    4,X
        staa    8,X
        staa    12,X
        staa    16,X
        pulx
        rts

        jsr     (0xA32E)

        jsr     (0x8DE4)
        .ascis  '    Warm-Up  '

        jsr     (0x8DDD)
        .ascis  'Curtains opening'

.if 0
a890: c6 14        ldab 0x14
a892: bd 8c 30     jsr (0x8C30)
a895: bd a8 55     jsr (0xA855)
a898: c6 02        ldab 0x02
a89a: bd 8c 30     jsr (0x8C30)
a89d: ce a6 5d     ldx #LA65D
a8a0: c6 05        ldab 0x05
a8a2: d7 12        stab (0x0012)
a8a4: c6 08        ldab 0x08
a8a6: d7 13        stab (0x0013)
a8a8: bd a9 41     jsr (0xA941)
a8ab: bd a9 4c     jsr (0xA94C)
a8ae: c6 02        ldab 0x02
a8b0: bd 8c 30     jsr (0x8C30)
a8b3: bd a9 5e     jsr (0xA95E)
a8b6: a6 00        ldaa (X+0x00)
a8b8: 80 30        suba 0x30
a8ba: 08           inx
a8bb: 08           inx
a8bc: 36           psha
a8bd: 7c 00 4c     inc (0x004C)
a8c0: 3c           pshx
a8c1: bd 88 e5     jsr (0x88E5)
a8c4: 38           pulx
a8c5: 86 4f        ldaa 0x4F            ;'O'
a8c7: c6 0c        ldab 0x0C
a8c9: bd 8d b5     jsr (0x8DB5)         ; display char here on LCD display
a8cc: 86 6e        ldaa 0x6E            ;'n'
a8ce: c6 0d        ldab 0x0D
a8d0: bd 8d b5     jsr (0x8DB5)         ; display char here on LCD display
a8d3: cc 20 0e     ldd 0x200E           ;' '
a8d6: bd 8d b5     jsr (0x8DB5)         ; display char here on LCD display
a8d9: 7a 00 4c     dec (0x004C)
a8dc: 32           pula
a8dd: 36           psha
a8de: c6 64        ldab 0x64
a8e0: 3d           mul
a8e1: dd 23        std CDTIMR5
a8e3: dc 23        ldd CDTIMR5
a8e5: 26 fc        bne [0xA8E3]
a8e7: bd 8e 95     jsr (0x8E95)
a8ea: 81 0d        cmpa 0x0D
a8ec: 26 05        bne [0xA8F3]
a8ee: bd a9 75     jsr (0xA975)
a8f1: 20 10        bra [0xA903]
a8f3: 81 01        cmpa 0x01
a8f5: 26 04        bne [0xA8FB]
a8f7: 32           pula
a8f8: 7e a8 95     jmp (0xA895)
a8fb: 81 02        cmpa 0x02
a8fd: 26 04        bne [0xA903]
a8ff: 32           pula
a900: 7e a9 35     jmp (0xA935)
a903: 3c           pshx
a904: bd 88 e5     jsr (0x88E5)
a907: 38           pulx
a908: 86 66        ldaa 0x66            ;'f'
a90a: c6 0d        ldab 0x0D
a90c: bd 8d b5     jsr (0x8DB5)         ; display char here on LCD display
a90f: 86 66        ldaa 0x66            ;'f'
a911: c6 0e        ldab 0x0E
a913: bd 8d b5     jsr (0x8DB5)         ; display char here on LCD display
a916: 32           pula
a917: c6 64        ldab 0x64
a919: 3d           mul
a91a: dd 23        std CDTIMR5
a91c: dc 23        ldd CDTIMR5
a91e: 26 fc        bne [0xA91C]
a920: bd a8 55     jsr (0xA855)
a923: 7c 00 4b     inc (0x004B)
a926: 96 4b        ldaa (0x004B)
a928: 81 48        cmpa 0x48
a92a: 25 87        bcs [0xA8B3]
a92c: 96 4c        ldaa (0x004C)
a92e: 81 34        cmpa 0x34
a930: 27 03        beq [0xA935]
a932: 7e a8 a4     jmp (0xA8A4)
a935: c6 02        ldab 0x02
a937: bd 8c 30     jsr (0x8C30)
a93a: bd 86 c4     jsr L86C4
a93d: bd a3 41     jsr (0xA341)
a940: 39           rts

a941: a6 00        ldaa (X+0x00)
a943: 08           inx
a944: 08           inx
a945: 97 4c        staa (0x004C)
a947: 86 40        ldaa 0x40
a949: 97 4b        staa (0x004B)
a94b: 39           rts

a94c: bd 8c f2     jsr (0x8CF2)
a94f: a6 00        ldaa (X+0x00)
a951: 08           inx
a952: 81 2c        cmpa 0x2C
a954: 27 07        beq [0xA95D]
a956: 36           psha
a957: bd 8e 70     jsr (0x8E70)
a95a: 32           pula
a95b: 20 f2        bra [0xA94F]
a95d: 39           rts

a95e: bd 8d 03     jsr (0x8D03)
a961: 86 c0        ldaa 0xC0
a963: bd 8e 4b     jsr (0x8E4B)
a966: a6 00        ldaa (X+0x00)
a968: 08           inx
a969: 81 2c        cmpa 0x2C
a96b: 27 07        beq [0xA974]
a96d: 36           psha
a96e: bd 8e 70     jsr (0x8E70)
a971: 32           pula
a972: 20 f2        bra [0xA966]
a974: 39           rts

a975: bd 8e 95     jsr (0x8E95)
a978: 4d           tsta
a979: 27 fa        beq [0xA975]
a97b: 39           rts

a97c: 7f 00 60     clr (0x0060)
a97f: fc 02 9c     ldd (0x029C)
a982: 1a 83 00 01  cpd 0x0001
a986: 27 0c        beq [0xA994]
a988: 1a 83 03 e8  cpd 0x03E8
a98c: 2d 7d        blt [0xAA0B]
a98e: 1a 83 04 4b  cpd 0x044B
a992: 22 77        bhi [0xAA0B]
a994: c6 40        ldab 0x40
a996: d7 62        stab (0x0062)
a998: bd f9 c5     jsr (0xF9C5)
a99b: c6 64        ldab 0x64
a99d: bd 8c 22     jsr (0x8C22)
a9a0: bd 86 c4     jsr L86C4
a9a3: bd 8c e9     jsr (0x8CE9)
a9a6: bd 8d e4     jsr (0x8DE4)

'     STUDIO'
a9a9: 20 20 20 20 20 53 54 55 44 49 cf

a9b4: bd 8d dd     jsr (0x8DDD)

'programming mode'
a9b7: 70 72 6f 67 72 61 6d 6d 69 6e 67 20 6d 6f 64 e5

a9c7: bd a3 2e     jsr (0xA32E)
a9ca: bd 99 9e     jsr (0x999E)
a9cd: bd 99 b1     jsr (0x99B1)
a9d0: ce 20 00     ldx 0x2000
a9d3: 18 ce 00 c0  ldy 0x00C0
a9d7: 18 09        dey
a9d9: 26 0a        bne [0xA9E5]
a9db: bd a9 f4     jsr (0xA9F4)
a9de: 96 60        ldaa (0x0060)
a9e0: 26 29        bne [0xAA0B]
a9e2: ce 20 00     ldx 0x2000
a9e5: b6 10 a8     ldaa (0x10A8)
a9e8: 84 01        anda 0x01
a9ea: 27 eb        beq [0xA9D7]
a9ec: b6 10 a9     ldaa (0x10A9)
a9ef: a7 00        staa (X+0x00)
a9f1: 08           inx
a9f2: 20 df        bra [0xA9D3]
a9f4: ce 20 00     ldx 0x2000
a9f7: 18 ce 10 80  ldy 0x1080
a9fb: a6 00        ldaa (X+0x00)
a9fd: 18 a7 00     staa (Y+0x00)
aa00: 08           inx
aa01: 18 08        iny
aa03: 18 08        iny
aa05: 8c 20 10     cpx 0x2010
aa08: 25 f1        bcs [0xA9FB]
aa0a: 39           rts
aa0b: 39           rts
aa0c: cc 48 37     ldd 0x4837           ;'H'
aa0f: bd 8d b5     jsr (0x8DB5)         ; display char here on LCD display
aa12: 39           rts
aa13: cc 20 37     ldd 0x2037           ;' '
aa16: 20 f7        bra [0xAA0F]
aa18: cc 42 0f     ldd 0x420F           ;'B'
aa1b: 20 f2        bra [0xAA0F]
aa1d: cc 20 0f     ldd 0x200F           ;' '
aa20: 20 ed        bra [0xAA0F]
aa22: 7f 00 4f     clr (0x004F)
aa25: cc 00 01     ldd 0x0001
aa28: dd 1b        std CDTIMR1
aa2a: ce 20 00     ldx 0x2000
aa2d: b6 10 a8     ldaa (0x10A8)
aa30: 84 01        anda 0x01
aa32: 27 f9        beq [0xAA2D]
aa34: dc 1b        ldd CDTIMR1
aa36: 0f           sei
aa37: 26 03        bne [0xAA3C]
aa39: ce 20 00     ldx 0x2000
aa3c: b6 10 a9     ldaa (0x10A9)
aa3f: a7 00        staa (X+0x00)
aa41: 0e           cli
aa42: bd f9 6f     jsr (0xF96F)
aa45: 08           inx
aa46: 7f 00 4f     clr (0x004F)
aa49: cc 00 01     ldd 0x0001
aa4c: dd 1b        std CDTIMR1
aa4e: 8c 20 23     cpx 0x2023
aa51: 26 da        bne [0xAA2D]
aa53: ce 20 00     ldx 0x2000
aa56: 7f 00 b7     clr (0x00B7)
aa59: a6 00        ldaa (X+0x00)
aa5b: 9b b7        adda (0x00B7)
aa5d: 97 b7        staa (0x00B7)
aa5f: 08           inx
aa60: 8c 20 22     cpx 0x2022
aa63: 25 f4        bcs [0xAA59]
aa65: 96 b7        ldaa (0x00B7)
aa67: 88 ff        eora 0xFF
aa69: a1 00        cmpa (X+0x00)
aa6b: ce 20 00     ldx 0x2000
aa6e: a6 20        ldaa (X+0x20)
aa70: 2b 03        bmi [0xAA75]
aa72: 7e aa 22     jmp (0xAA22)
aa75: a6 00        ldaa (X+0x00)
aa77: b7 10 80     staa (0x1080)
aa7a: 08           inx
aa7b: a6 00        ldaa (X+0x00)
aa7d: b7 10 82     staa (0x1082)
aa80: 08           inx
aa81: a6 00        ldaa (X+0x00)
aa83: b7 10 84     staa (0x1084)
aa86: 08           inx
aa87: a6 00        ldaa (X+0x00)
aa89: b7 10 86     staa (0x1086)
aa8c: 08           inx
aa8d: a6 00        ldaa (X+0x00)
aa8f: b7 10 88     staa (0x1088)
aa92: 08           inx
aa93: a6 00        ldaa (X+0x00)
aa95: b7 10 8a     staa (0x108A)
aa98: 08           inx
aa99: a6 00        ldaa (X+0x00)
aa9b: b7 10 8c     staa (0x108C)
aa9e: 08           inx
aa9f: a6 00        ldaa (X+0x00)
aaa1: b7 10 8e     staa (0x108E)
aaa4: 08           inx
aaa5: a6 00        ldaa (X+0x00)
aaa7: b7 10 90     staa (0x1090)
aaaa: 08           inx
aaab: a6 00        ldaa (X+0x00)
aaad: b7 10 92     staa (0x1092)
aab0: 08           inx
aab1: a6 00        ldaa (X+0x00)
aab3: 8a 80        oraa 0x80
aab5: b7 10 94     staa (0x1094)
aab8: 08           inx
aab9: a6 00        ldaa (X+0x00)
aabb: 8a 01        oraa 0x01
aabd: b7 10 96     staa (0x1096)
aac0: 08           inx
aac1: a6 00        ldaa (X+0x00)
aac3: b7 10 98     staa (0x1098)
aac6: 08           inx
aac7: a6 00        ldaa (X+0x00)
aac9: b7 10 9a     staa (0x109A)
aacc: 08           inx
aacd: a6 00        ldaa (X+0x00)
aacf: b7 10 9c     staa (0x109C)
aad2: 08           inx
aad3: a6 00        ldaa (X+0x00)
aad5: b7 10 9e     staa (0x109E)
aad8: 7e aa 22     jmp (0xAA22)
aadb: 7f 10 98     clr (0x1098)
aade: 7f 10 9a     clr (0x109A)
aae1: 7f 10 9c     clr (0x109C)
aae4: 7f 10 9e     clr (0x109E)
aae7: 39           rts

aae8: ce 04 2c     ldx 0x042C
aaeb: c6 10        ldab 0x10
aaed: 5d           tstb
aaee: 27 12        beq [0xAB02]
aaf0: a6 00        ldaa (X+0x00)
aaf2: 81 30        cmpa 0x30
aaf4: 25 0d        bcs [0xAB03]
aaf6: 81 39        cmpa 0x39
aaf8: 22 09        bhi [0xAB03]
aafa: 08           inx
aafb: 08           inx
aafc: 08           inx
aafd: 8c 04 59     cpx 0x0459
ab00: 23 eb        bls [0xAAED]
ab02: 39           rts

ab03: 5a           decb
ab04: 3c           pshx
ab05: a6 03        ldaa (X+0x03)
ab07: a7 00        staa (X+0x00)
ab09: 08           inx
ab0a: 8c 04 5c     cpx 0x045C
ab0d: 25 f6        bcs [0xAB05]
ab0f: 86 ff        ldaa 0xFF
ab11: b7 04 59     staa (0x0459)
ab14: 38           pulx
ab15: 20 d6        bra [0xAAED]
ab17: ce 04 2c     ldx 0x042C
ab1a: 86 ff        ldaa 0xFF
ab1c: a7 00        staa (X+0x00)
ab1e: 08           inx
ab1f: 8c 04 5c     cpx 0x045C
ab22: 25 f8        bcs [0xAB1C]
ab24: 39           rts

ab25: ce 04 2c     ldx 0x042C
ab28: a6 00        ldaa (X+0x00)
ab2a: 81 30        cmpa 0x30
ab2c: 25 17        bcs [0xAB45]
ab2e: 81 39        cmpa 0x39
ab30: 22 13        bhi [0xAB45]
ab32: 08           inx
ab33: 08           inx
ab34: 08           inx
ab35: 8c 04 5c     cpx 0x045C
ab38: 25 ee        bcs [0xAB28]
ab3a: 86 ff        ldaa 0xFF
ab3c: b7 04 2c     staa (0x042C)
ab3f: bd aa e8     jsr (0xAAE8)
ab42: ce 04 59     ldx 0x0459
ab45: 39           rts

ab46: b6 02 99     ldaa (0x0299)
ab49: a7 00        staa (X+0x00)
ab4b: b6 02 9a     ldaa (0x029A)
ab4e: a7 01        staa (X+0x01)
ab50: b6 02 9b     ldaa (0x029B)
ab53: a7 02        staa (X+0x02)
ab55: 39           rts

ab56: ce 04 2c     ldx 0x042C
ab59: b6 02 99     ldaa (0x0299)
ab5c: a1 00        cmpa (X+0x00)
ab5e: 26 10        bne [0xAB70]
ab60: b6 02 9a     ldaa (0x029A)
ab63: a1 01        cmpa (X+0x01)
ab65: 26 09        bne [0xAB70]
ab67: b6 02 9b     ldaa (0x029B)
ab6a: a1 02        cmpa (X+0x02)
ab6c: 26 02        bne [0xAB70]
ab6e: 20 0a        bra [0xAB7A]
ab70: 08           inx
ab71: 08           inx
ab72: 08           inx
ab73: 8c 04 5c     cpx 0x045C
ab76: 25 e1        bcs [0xAB59]
ab78: 0d           sec
ab79: 39           rts

ab7a: 0c           clc
ab7b: 39           rts

;show re-valid tapes
ab7c: ce 04 2c     ldx 0x042C
ab7f: a6 00        ldaa (X+0x00)
ab81: 81 30        cmpa 0x30
ab83: 25 1e        bcs [0xABA3]
ab85: 81 39        cmpa 0x39
ab87: 22 1a        bhi [0xABA3]
ab89: bd f9 6f     jsr (0xF96F)
ab8c: 08           inx
ab8d: a6 00        ldaa (X+0x00)
ab8f: bd f9 6f     jsr (0xF96F)
ab92: 08           inx
ab93: a6 00        ldaa (X+0x00)
ab95: bd f9 6f     jsr (0xF96F)
ab98: 08           inx
ab99: 86 20        ldaa 0x20
ab9b: bd f9 6f     jsr (0xF96F)
ab9e: 8c 04 5c     cpx 0x045C
aba1: 25 dc        bcs [0xAB7F]
aba3: 86 0d        ldaa 0x0D
aba5: bd f9 6f     jsr (0xF96F)
aba8: 86 0a        ldaa 0x0A
abaa: bd f9 6f     jsr (0xF96F)
abad: 39           rts

abae: 7f 00 4a     clr (0x004A)
abb1: cc 00 64     ldd 0x0064
abb4: dd 23        std CDTIMR5
abb6: 96 4a        ldaa (0x004A)
abb8: 26 08        bne [0xABC2]
abba: bd 9b 19     jsr (0x9B19)
abbd: dc 23        ldd CDTIMR5
abbf: 26 f5        bne [0xABB6]
abc1: 39           rts

abc2: 81 31        cmpa 0x31
abc4: 26 04        bne [0xABCA]
abc6: bd ab 17     jsr (0xAB17)
abc9: 39           rts

abca: 20 f5        bra [0xABC1]

; TOC1 timer handler
;
; Timer is running at:
; EXTAL = 16Mhz
; E Clk = 4Mhz
; Timer Prescaler = /16 = 250Khz
; Timer Period = 4us
; T1OC is set to previous value +625
; So, this routine is called every 2.5ms
;
abcc: dc 10        ldd T1NXT        ; get ready for next time
abce: c3 02 71     addd 0x0271      ; add 625
abd1: fd 10 16     std (TOC1)
abd4: dd 10        std T1NXT

abd6: 86 80        ldaa 0x80
abd8: b7 10 23     staa TFLG1       ; clear timer1 flag

; Some blinking SPECIAL button every half second,
; if 0x0078 is non zero

abdb: 7d 00 78     tst (0x0078)     ; if 78 is zero, skip ahead
abde: 27 1c        beq [0xABFC]     ; else do some blinking button lights
abe0: dc 25        ldd (0x0025)     ; else inc 25/26
abe2: c3 00 01     addd 0x0001
abe5: dd 25        std (0x0025)
abe7: 1a 83 00 c8  cpd 0x00C8       ; is it 200?
abeb: 26 0f        bne [0xABFC]     ; no, keep going
abed: 7f 00 25     clr (0x0025)     ; reset 25/26
abf0: 7f 00 26     clr (0x0026)
abf3: d6 62        ldab (0x0062)    ; and toggle bit 3 of 62
abf5: c8 08        eorb 0x08
abf7: d7 62        stab (0x0062)
abf9: bd f9 c5     jsr (0xF9C5)     ; and toggle the "special" button light

; 
abfc: 7c 00 6f     inc (0x006F)     ; count every 2.5ms
abff: 96 6f        ldaa (0x006F)
ac01: 81 28        cmpa 0x28        ; is it 40 intervals? (0.1 sec?)
ac03: 25 42        bcs [0xAC47]     ; if not yet, jump ahead
ac05: 7f 00 6f     clr (0x006F)     ; clear it 2.5ms counter
ac08: 7d 00 63     tst (0x0063)     ; decrement 0.1s counter here
ac0b: 27 03        beq [0xAC10]     ; if it's not already zero
ac0d: 7a 00 63     dec (0x0063)

; staggered counters - here every 100ms

; 0x0070 counts from 250 to 1, period is 25 secs
ac10: 96 70        ldaa OFFCNT1    ; decrement 0.1s counter here
ac12: 4a           deca
ac13: 97 70        staa OFFCNT1
ac15: 26 04        bne [0xAC1B]     
ac17: 86 fa        ldaa 0xFA        ; 250
ac19: 97 70        staa OFFCNT1

; 0x0071 counts from 230 to 1, period is 23 secs
ac1b: 96 71        ldaa OFFCNT2
ac1d: 4a           deca
ac1e: 97 71        staa OFFCNT2
ac20: 26 04        bne [0xAC26]
ac22: 86 e6        ldaa 0xE6        ; 230
ac24: 97 71        staa OFFCNT2

; 0x0072 counts from 210 to 1, period is 21 secs
ac26: 96 72        ldaa OFFCNT3
ac28: 4a           deca
ac29: 97 72        staa OFFCNT3
ac2b: 26 04        bne [0xAC31]
ac2d: 86 d2        ldaa 0xD2        ; 210
ac2f: 97 72        staa OFFCNT3

; 0x0073 counts from 190 to 1, period is 19 secs
ac31: 96 73        ldaa OFFCNT4
ac33: 4a           deca
ac34: 97 73        staa OFFCNT4
ac36: 26 04        bne [0xAC3C]
ac38: 86 be        ldaa 0xBE        ; 190
ac3a: 97 73        staa OFFCNT4

; 0x0074 counts from 170 to 1, period is 17 secs
ac3c: 96 74        ldaa OFFCNT5
ac3e: 4a           deca
ac3f: 97 74        staa OFFCNT5
ac41: 26 04        bne [0xAC47]
ac43: 86 aa        ldaa 0xAA        ; 170
ac45: 97 74        staa OFFCNT5

; back to 2.5ms period here

ac47: 96 27        ldaa T30MS
ac49: 4c           inca
ac4a: 97 27        staa T30MS
ac4c: 81 0c        cmpa 0x0C        ; 12 = 30ms?
ac4e: 23 09        bls [0xAC59]
ac50: 7f 00 27     clr T30MS

; do these tasks every 30ms
ac53: bd 8e c6     jsr (0x8EC6)     ; ???
ac56: bd 8f 12     jsr (0x8F12)     ; ???

; back to every 2.5ms here
; LCD update???

ac59: 96 43        ldaa (0x0043)
ac5b: 27 55        beq [0xACB2]
ac5d: de 44        ldx (0x0044)
ac5f: a6 00        ldaa (X+0x00)
ac61: 27 23        beq [0xAC86]
ac63: b7 10 00     staa PORTA  
ac66: b6 10 02     ldaa PORTG  
ac69: 84 f3        anda 0xF3
ac6b: b7 10 02     staa PORTG  
ac6e: 84 fd        anda 0xFD
ac70: b7 10 02     staa PORTG  
ac73: 8a 02        oraa 0x02
ac75: b7 10 02     staa PORTG  
ac78: 08           inx
ac79: 08           inx
ac7a: 8c 05 80     cpx 0x0580
ac7d: 25 03        bcs [0xAC82]
ac7f: ce 05 00     ldx 0x0500
ac82: df 44        stx (0x0044)
ac84: 20 2c        bra [0xACB2]
ac86: a6 01        ldaa (X+0x01)
ac88: 27 25        beq [0xACAF]
ac8a: b7 10 00     staa PORTA  
ac8d: b6 10 02     ldaa PORTG  
ac90: 84 fb        anda 0xFB
ac92: 8a 08        oraa 0x08
ac94: b7 10 02     staa PORTG  
ac97: 84 fd        anda 0xFD
ac99: b7 10 02     staa PORTG  
ac9c: 8a 02        oraa 0x02
ac9e: b7 10 02     staa PORTG  
aca1: 08           inx
aca2: 08           inx
aca3: 8c 05 80     cpx 0x0580
aca6: 25 03        bcs [0xACAB]
aca8: ce 05 00     ldx 0x0500
acab: df 44        stx (0x0044)
acad: 20 03        bra [0xACB2]
acaf: 7f 00 43     clr (0x0043)

; divide by 4
acb2: 96 4f        ldaa (0x004F)
acb4: 4c           inca
acb5: 97 4f        staa (0x004F)
acb7: 81 04        cmpa 0x04
acb9: 26 30        bne [0xACEB]
acbb: 7f 00 4f     clr (0x004F)

; here every 10ms
; Five big countdown timers available here
; up to 655.35 seconds each

acbe: dc 1b        ldd CDTIMR1     ; countdown 0x001B/1C every 10ms
acc0: 27 05        beq [0xACC7]     ; if not already 0
acc2: 83 00 01     subd 0x0001
acc5: dd 1b        std CDTIMR1

acc7: dc 1d        ldd CDTIMR2     ; same with 0x001D/1E
acc9: 27 05        beq [0xACD0]
accb: 83 00 01     subd 0x0001
acce: dd 1d        std CDTIMR2

acd0: dc 1f        ldd CDTIMR3     ; same with 0x001F/20
acd2: 27 05        beq [0xACD9]
acd4: 83 00 01     subd 0x0001
acd7: dd 1f        std CDTIMR3

acd9: dc 21        ldd CDTIMR4     ; same with 0x0021/22
acdb: 27 05        beq [0xACE2]
acdd: 83 00 01     subd 0x0001
ace0: dd 21        std CDTIMR4

ace2: dc 23        ldd CDTIMR5     ; same with 0x0023/24
ace4: 27 05        beq [0xACEB]
ace6: 83 00 01     subd 0x0001
ace9: dd 23        std CDTIMR5

; every other time through this, setup a task switch?
aceb: 96 b0        ldaa (TSCNT)
aced: 88 01        eora 0x01
acef: 97 b0        staa (TSCNT)
acf1: 27 18        beq [0xAD0B]

acf3: bf 01 3c     sts (0x013C)     ; switch stacks???
acf6: be 01 3e     lds (0x013E)
acf9: dc 10        ldd T1NXT
acfb: 83 01 f4     subd 0x01F4      ; 625-500 = 125?
acfe: fd 10 18     std (TOC2)       ; set this TOC2 to happen 0.5ms
ad01: 86 40        ldaa 0x40        ; after the current TOC1 but before the next TOC1
ad03: b7 10 23     staa TFLG1       ; clear timer2 irq flag, just in case?
ad06: 86 c0        ldaa 0xC0        ;
ad08: b7 10 22     staa TMSK1       ; enable TOC1 and TOC2
ad0b: 3b           rti

; TOC2 Timer handler

ad0c: 86 40        ldaa 0x40
ad0e: b7 10 23     staa TFLG1       ; clear timer2 flag
ad11: bf 01 3e     sts (0x013E)     ; switch stacks back???
ad14: be 01 3c     lds (0x013C)
ad17: 86 80        ldaa 0x80
ad19: b7 10 22     staa TMSK1       ; enable TOC1 only
ad1c: 3b           rti

; Secondary task??

.endif
        .org    0xad1d
TASK2:
.if 0
ad1d: 7d 04 2a     tst (0x042A)
ad20: 27 35        beq LAD57
ad22: 96 b6        ldaa (0x00B6)
ad24: 26 03        bne LAD29
ad26: 3f           swi
ad27: 20 f4        bra TASK2
LAD29:
ad29: 7f 00 b6     clr (0x00B6)
ad2c: c6 04        ldab 0x04
ad2e: 37           pshb
ad2f: ce ad 3c     ldx #LAD3C
ad32: bd 8a 1a     jsr L8A1A  
ad35: 3f           swi
ad36: 33           pulb
ad37: 5a           decb
ad38: 26 f4        bne [0xAD2E]
ad3a: 20 e1        bra TASK2

LAD3C:
        .asciz     'S1'

ad3f: fc 02 9c     ldd (0x029C)
ad42: 1a 83 00 01  cpd 0x0001
ad46: 27 0c        beq [0xAD54]
ad48: 1a 83 03 e8  cpd 0x03E8
ad4c: 2d 09        blt [0xAD57]
ad4e: 1a 83 04 4b  cpd 0x044B
ad52: 22 03        bhi [0xAD57]
ad54: 3f           swi
ad55: 20 c6        bra TASK2
LAD57:
ad57: 7f 00 b3     clr (0x00B3)
ad5a: bd ad 7e     jsr (0xAD7E)
ad5d: bd ad a0     jsr (0xADA0)
ad60: 25 bb        bcs TASK2
ad62: c6 0a        ldab 0x0A
ad64: bd ae 13     jsr (0xAE13)
ad67: bd ad ae     jsr (0xADAE)
ad6a: 25 b1        bcs TASK2
ad6c: c6 14        ldab 0x14
ad6e: bd ae 13     jsr (0xAE13)
ad71: bd ad b6     jsr (0xADB6)
ad74: 25 a7        bcs TASK2
ad76: bd ad b8     jsr (0xADB8)
ad79: 0d           sec
ad7a: 25 a1        bcs TASK2
ad7c: 20 f8        bra [0xAD76]
ad7e: ce ae 1e     ldx #LAE1E       ;+++
ad81: bd 8a 1a     jsr L8A1A  
ad84: c6 1e        ldab 0x1E
ad86: bd ae 13     jsr (0xAE13)
ad89: ce ae 22     ldx #LAE22       ;ATH
ad8c: bd 8a 1a     jsr L8A1A  
ad8f: c6 1e        ldab 0x1E
ad91: bd ae 13     jsr (0xAE13)
ad94: ce ae 27     ldx #LAE27       ;ATZ
ad97: bd 8a 1a     jsr L8A1A  
ad9a: c6 1e        ldab 0x1E
ad9c: bd ae 13     jsr (0xAE13)
ad9f: 39           rts
ada0: bd b1 dd     jsr (0xB1DD)
ada3: 25 fb        bcs [0xADA0]
ada5: bd b2 4f     jsr (0xB24F)

'RING'
ada8: 52 49 4e 47 00

adad: 39           rts
adae: ce ae 2c     ldx 0xAE2C
adb1: bd 8a 1a     jsr L8A1A       ;ATA
adb4: 0c           clc
adb5: 39           rts
adb6: 0c           clc
adb7: 39           rts
adb8: bd b1 d2     jsr (0xB1D2)
adbb: bd ae 31     jsr (0xAE31)
adbe: 86 01        ldaa 0x01
adc0: 97 b3        staa (0x00B3)
adc2: bd b1 dd     jsr (0xB1DD)
adc5: bd b2 71     jsr (0xB271)
adc8: 36           psha
adc9: bd b2 c0     jsr (0xB2C0)
adcc: 32           pula
adcd: 81 01        cmpa 0x01
adcf: 26 08        bne [0xADD9]
add1: ce b2 95     ldx #LB295
add4: bd 8a 1a     jsr L8A1A       ;'You have selected #1'
add7: 20 31        bra [0xAE0A]
add9: 81 02        cmpa 0x02
addb: 26 00        bne [0xADDD]
addd: 81 03        cmpa 0x03
addf: 26 00        bne [0xADE1]
ade1: 81 04        cmpa 0x04
ade3: 26 00        bne [0xADE5]
ade5: 81 05        cmpa 0x05
ade7: 26 00        bne [0xADE9]
ade9: 81 06        cmpa 0x06
adeb: 26 00        bne [0xADED]
aded: 81 07        cmpa 0x07
adef: 26 00        bne [0xADF1]
adf1: 81 08        cmpa 0x08
adf3: 26 00        bne [0xADF5]
adf5: 81 09        cmpa 0x09
adf7: 26 00        bne [0xADF9]
adf9: 81 0a        cmpa 0x0A
adfb: 26 00        bne [0xADFD]
adfd: 81 0b        cmpa 0x0B
adff: 26 09        bne [0xAE0A]
ae01: ce b2 aa     ldx #LB2AA       ;'You have selected #11'
ae04: bd 8a 1a     jsr L8A1A  
ae07: 7e ae 0a     jmp (0xAE0A)
ae0a: c6 14        ldab 0x14
ae0c: bd ae 13     jsr (0xAE13)
ae0f: 7f 00 b3     clr (0x00B3)
ae12: 39           rts

ae13: ce 00 20     ldx 0x0020
ae16: 3f           swi
ae17: 09           dex
ae18: 26 fc        bne [0xAE16]
ae1a: 5a           decb
ae1b: 26 f6        bne [0xAE13]
ae1d: 39           rts

; text??
LAE1E:
        .asciz      '+++'
LAE22:
        .asciz      'ATH\r'
LAE27:
        .asciz      'ATZ\r'
LAE2C:
        .asciz      'ATA\r'

ae31: ce ae 38     ldx 0xAE38       ; big long string of stats?
ae34: bd 8a 1a     jsr L8A1A  
ae37: 39           rts

        .ascii      '^0101Serial #:^0140#0000^0111~4'
        ;???

ae38: 5e           ?
ae39: 30           tsx
ae3a: 31           ins
ae3b: 30           tsx
ae3c: 31           ins
ae3d: 53           comb
ae3e: 65           ?
ae3f: 72           ?
ae40: 69 61        rol (X+0x61)
ae42: 6c 20        inc (X+0x20)
ae44: 23 3a        bls [0xAE80]
ae46: 5e           ?
ae47: 30           tsx
ae48: 31           ins
ae49: 34           des
ae4a: 30           tsx
ae4b: 23 30        bls [0xAE7D]
ae4d: 30           tsx
ae4e: 30           tsx
ae4f: 30           tsx
ae50: 5e           ?
ae51: 30           tsx
ae52: 31           ins
ae53: 31           ins
ae54: 31           ins
ae55: 7e 34 0e     jmp (0x340E)
ae58: 20 5e        bra [0xAEB8]
ae5a: 30           tsx
ae5b: 31           ins
ae5c: 34           des
ae5d: 31           ins
ae5e: 7c 04 28     inc (0x0428)
ae61: 5e           ?
ae62: 30           tsx
ae63: 33           pulb
ae64: 30           tsx
ae65: 31           ins
ae66: 43           coma
ae67: 55           ?
ae68: 52           ?
ae69: 52           ?
ae6a: 45           ?
ae6b: 4e           ?
ae6c: 54           lsrb
ae6d: 5e           ?
ae6e: 30           tsx
ae6f: 33           pulb
ae70: 34           des
ae71: 30           tsx
ae72: 48           asla
ae73: 49           rola
ae74: 53           comb
ae75: 54           lsrb
ae76: 4f           clra
ae77: 52           ?
ae78: 59           rolb
ae79: 5e           ?
ae7a: 30           tsx
ae7b: 35           txs
ae7c: 30           tsx
ae7d: 31           ins
ae7e: 53           comb
ae7f: 68 6f        asl (X+0x6F)
ae81: 77 20 53     asr (0x2053)
ae84: 74 61 74     lsr (0x6174)
ae87: 75           ?
ae88: 73 3a 5e     com (0x3A5E)
ae8b: 30           tsx
ae8c: 35           txs
ae8d: 34           des
ae8e: 30           tsx
ae8f: 54           lsrb
ae90: 6f 74        clr (X+0x74)
ae92: 61           ?
ae93: 6c 20        inc (X+0x20)
ae95: 23 20        bls [0xAEB7]
ae97: 72           ?
ae98: 65           ?
ae99: 67 2e        asr (X+0x2E)
ae9b: 20 73        bra [0xAF10]
ae9d: 68 6f        asl (X+0x6F)
ae9f: 77 73 3a     asr (0x733A)
aea2: 5e           ?
aea3: 30           tsx
aea4: 36           psha
aea5: 30           tsx
aea6: 31           ins
aea7: 52           ?
aea8: 61           ?
aea9: 6e 64        jmp (X+0x64)
aeab: 6f 6d        clr (X+0x6D)
aead: 20 53        bra [0xAF02]
aeaf: 74 61 74     lsr (0x6174)
aeb2: 75           ?
aeb3: 73 3a 5e     com (0x3A5E)
aeb6: 30           tsx
aeb7: 35           txs
aeb8: 37           pshb
aeb9: 30           tsx
aeba: 7c 04 10     inc (0x0410)
aebd: 5e           ?
aebe: 30           tsx
aebf: 36           psha
aec0: 34           des
aec1: 30           tsx
aec2: 54           lsrb
aec3: 6f 74        clr (X+0x74)
aec5: 61           ?
aec6: 6c 20        inc (X+0x20)
aec8: 23 20        bls [0xAEEA]
aeca: 6c 69        inc (X+0x69)
aecc: 76 65 20     ror (0x6520)
aecf: 73 68 6f     com (0x686F)
aed2: 77 73 3a     asr (0x733A)
aed5: 5e           ?
aed6: 30           tsx
aed7: 37           pshb
aed8: 30           tsx
aed9: 31           ins
aeda: 43           coma
aedb: 75           ?
aedc: 72           ?
aedd: 72           ?
aede: 65           ?
aedf: 6e 74        jmp (X+0x74)
aee1: 20 52        bra [0xAF35]
aee3: 65           ?
aee4: 67 20        asr (X+0x20)
aee6: 54           lsrb
aee7: 61           ?
aee8: 70 65 20     neg (0x6520)
aeeb: 23 3a        bls [0xAF27]
aeed: 5e           ?
aeee: 30           tsx
aeef: 36           psha
aef0: 37           pshb
aef1: 30           tsx
aef2: 7c 04 12     inc (0x0412)
aef5: 5e           ?
aef6: 30           tsx
aef7: 37           pshb
aef8: 33           pulb
aef9: 30           tsx
aefa: 7e 33 04     jmp (0x3304)
aefd: 02           idiv
aefe: 5e           ?
aeff: 30           tsx
af00: 37           pshb
af01: 34           des
af02: 30           tsx
af03: 54           lsrb
af04: 6f 74        clr (X+0x74)
af06: 61           ?
af07: 6c 20        inc (X+0x20)
af09: 23 20        bls [0xAF2B]
af0b: 66 61        ror (X+0x61)
af0d: 69 6c        rol (X+0x6C)
af0f: 65           ?
af10: 64 20        lsr (X+0x20)
af12: 70 73 77     neg (0x7377)
af15: 64 20        lsr (X+0x20)
af17: 61           ?
af18: 74 74 65     lsr (0x7465)
af1b: 6d 70        tst (X+0x70)
af1d: 74 73 3a     lsr (0x733A)
af20: 5e           ?
af21: 30           tsx
af22: 38           pulx
af23: 30           tsx
af24: 31           ins
af25: 43           coma
af26: 75           ?
af27: 72           ?
af28: 72           ?
af29: 65           ?
af2a: 6e 74        jmp (X+0x74)
af2c: 20 4c        bra [0xAF7A]
af2e: 69 76        rol (X+0x76)
af30: 65           ?
af31: 20 54        bra [0xAF87]
af33: 61           ?
af34: 70 65 20     neg (0x6520)
af37: 23 3a        bls [0xAF73]
af39: 5e           ?
af3a: 30           tsx
af3b: 37           pshb
af3c: 37           pshb
af3d: 30           tsx
af3e: 7c 04 14     inc (0x0414)
af41: 5e           ?
af42: 30           tsx
af43: 38           pulx
af44: 33           pulb
af45: 30           tsx
af46: 7e 33 04     jmp (0x3304)
af49: 05           asld
af4a: 5e           ?
af4b: 30           tsx
af4c: 38           pulx
af4d: 34           des
af4e: 30           tsx
af4f: 54           lsrb
af50: 6f 74        clr (X+0x74)
af52: 61           ?
af53: 6c 20        inc (X+0x20)
af55: 23 20        bls [0xAF77]
af57: 73 75 63     com (0x7563)
af5a: 63 65        com (X+0x65)
af5c: 73 73 66     com (0x7366)
af5f: 75           ?
af60: 6c 20        inc (X+0x20)
af62: 70 73 77     neg (0x7377)
af65: 64 3a        lsr (X+0x3A)
af67: 5e           ?
af68: 30           tsx
af69: 39           rts
af6a: 30           tsx
af6b: 31           ins
af6c: 43           coma
af6d: 75           ?
af6e: 72           ?
af6f: 72           ?
af70: 65           ?
af71: 6e 74        jmp (X+0x74)
af73: 20 56        bra [0xAFCB]
af75: 65           ?
af76: 72           ?
af77: 73 69 6f     com (0x696F)
af7a: 6e 20        jmp (X+0x20)
af7c: 23 3a        bls [0xAFB8]
af7e: 5e           ?
af7f: 30           tsx
af80: 38           pulx
af81: 37           pshb
af82: 30           tsx
af83: 7c 04 16     inc (0x0416)
af86: 5e           ?
af87: 30           tsx
af88: 39           rts
af89: 33           pulb
af8a: 30           tsx
af8b: 40           nega
af8c: 04           lsrd
af8d: 00           test
af8e: 5e           ?
af8f: 30           tsx
af90: 39           rts
af91: 34           des
af92: 30           tsx
af93: 54           lsrb
af94: 6f 74        clr (X+0x74)
af96: 61           ?
af97: 6c 20        inc (X+0x20)
af99: 23 20        bls [0xAFBB]
af9b: 62           ?
af9c: 64 61        lsr (X+0x61)
af9e: 79 73 20     rol (0x7320)
afa1: 70 6c 61     neg (0x6C61)
afa4: 79 65 64     rol (0x6564)
afa7: 3a           abx
afa8: 5e           ?
afa9: 31           ins
afaa: 30           tsx
afab: 34           des
afac: 30           tsx
afad: 54           lsrb
afae: 6f 74        clr (X+0x74)
afb0: 61           ?
afb1: 6c 20        inc (X+0x20)
afb3: 23 20        bls [0xAFD5]
afb5: 56           rorb
afb6: 43           coma
afb7: 52           ?
afb8: 20 61        bra [0xB01B]
afba: 64 6a        lsr (X+0x6A)
afbc: 75           ?
afbd: 73 74 73     com (0x7473)
afc0: 3a           abx
afc1: 5e           ?
afc2: 30           tsx
afc3: 39           rts
afc4: 37           pshb
afc5: 30           tsx
afc6: 7c 04 18     inc (0x0418)
afc9: 5e           ?
afca: 31           ins
afcb: 30           tsx
afcc: 37           pshb
afcd: 30           tsx
afce: 7c 04 1a     inc (0x041A)
afd1: 5e           ?
afd2: 31           ins
afd3: 31           ins
afd4: 34           des
afd5: 30           tsx
afd6: 54           lsrb
afd7: 6f 74        clr (X+0x74)
afd9: 61           ?
afda: 6c 20        inc (X+0x20)
afdc: 23 20        bls [0xAFFE]
afde: 72           ?
afdf: 65           ?
afe0: 6d 6f        tst (X+0x6F)
afe2: 74 65 20     lsr (0x6520)
afe5: 61           ?
afe6: 63 63        com (X+0x63)
afe8: 65           ?
afe9: 73 73 65     com (0x7365)
afec: 73 3a 5e     com (0x3A5E)
afef: 31           ins
aff0: 32           pula
aff1: 34           des
aff2: 30           tsx
aff3: 54           lsrb
aff4: 6f 74        clr (X+0x74)
aff6: 61           ?
aff7: 6c 20        inc (X+0x20)
aff9: 23 20        bls [0xB01B]
affb: 61           ?
affc: 63 63        com (X+0x63)
affe: 65           ?
afff: 73 73 20     com (0x7320)
b002: 61           ?
b003: 74 74 65     lsr (0x7465)
b006: 6d 70        tst (X+0x70)
b008: 74 73 3a     lsr (0x733A)
b00b: 5e           ?
b00c: 31           ins
b00d: 31           ins
b00e: 37           pshb
b00f: 30           tsx
b010: 7c 04 1c     inc (0x041C)
b013: 5e           ?
b014: 31           ins
b015: 32           pula
b016: 37           pshb
b017: 30           tsx
b018: 7c 04 1e     inc (0x041E)
b01b: 5e           ?
b01c: 31           ins
b01d: 33           pulb
b01e: 34           des
b01f: 30           tsx
b020: 54           lsrb
b021: 6f 74        clr (X+0x74)
b023: 61           ?
b024: 6c 20        inc (X+0x20)
b026: 23 20        bls [0xB048]
b028: 72           ?
b029: 65           ?
b02a: 6a 65        dec (X+0x65)
b02c: 63 74        com (X+0x74)
b02e: 65           ?
b02f: 64 20        lsr (X+0x20)
b031: 73 68 6f     com (0x686F)
b034: 77 74 61     asr (0x7461)
b037: 70 65 73     neg (0x6573)
b03a: 3a           abx
b03b: 5e           ?
b03c: 31           ins
b03d: 34           des
b03e: 34           des
b03f: 30           tsx
b040: 54           lsrb
b041: 6f 74        clr (X+0x74)
b043: 61           ?
b044: 6c 20        inc (X+0x20)
b046: 23 20        bls [0xB068]
b048: 53           comb
b049: 68 6f        asl (X+0x6F)
b04b: 72           ?
b04c: 74 20 62     lsr (0x2062)
b04f: 64 61        lsr (X+0x61)
b051: 79 73 3a     rol (0x733A)
b054: 5e           ?
b055: 31           ins
b056: 33           pulb
b057: 37           pshb
b058: 30           tsx
b059: 7c 04 20     inc (0x0420)
b05c: 5e           ?
b05d: 31           ins
b05e: 34           des
b05f: 37           pshb
b060: 30           tsx
b061: 7c 04 22     inc (0x0422)
b064: 5e           ?
b065: 31           ins
b066: 35           txs
b067: 34           des
b068: 30           tsx
b069: 54           lsrb
b06a: 6f 74        clr (X+0x74)
b06c: 61           ?
b06d: 6c 20        inc (X+0x20)
b06f: 23 20        bls [0xB091]
b071: 52           ?
b072: 65           ?
b073: 67 20        asr (X+0x20)
b075: 62           ?
b076: 64 61        lsr (X+0x61)
b078: 79 73 3a     rol (0x733A)
b07b: 5e           ?
b07c: 31           ins
b07d: 36           psha
b07e: 34           des
b07f: 30           tsx
b080: 54           lsrb
b081: 6f 74        clr (X+0x74)
b083: 61           ?
b084: 6c 20        inc (X+0x20)
b086: 23 20        bls [0xB0A8]
b088: 72           ?
b089: 65           ?
b08a: 73 65 74     com (0x6574)
b08d: 73 2d 70     com (0x2D70)
b090: 77 72 20     asr (0x7220)
b093: 75           ?
b094: 70 73 3a     neg (0x733A)
b097: 5e           ?
b098: 31           ins
b099: 35           txs
b09a: 37           pshb
b09b: 30           tsx
b09c: 7c 04 24     inc (0x0424)
b09f: 5e           ?
b0a0: 31           ins
b0a1: 36           psha
b0a2: 37           pshb
b0a3: 30           tsx
b0a4: 7c 04 26     inc (0x0426)
b0a7: 5e           ?
b0a8: 31           ins
b0a9: 38           pulx
b0aa: 30           tsx
b0ab: 31           ins
b0ac: 46           rora
b0ad: 55           ?
b0ae: 4e           ?
b0af: 43           coma
b0b0: 54           lsrb
b0b1: 49           rola
b0b2: 4f           clra
b0b3: 4e           ?
b0b4: 53           comb
b0b5: 5e           ?
b0b6: 31           ins
b0b7: 38           pulx
b0b8: 32           pula
b0b9: 33           pulb
b0ba: 53           comb
b0bb: 65           ?
b0bc: 6c 65        inc (X+0x65)
b0be: 63 74        com (X+0x74)
b0c0: 20 46        bra [0xB108]
b0c2: 75           ?
b0c3: 6e 63        jmp (X+0x63)
b0c5: 74 69 6f     lsr (0x696F)
b0c8: 6e 3a        jmp (X+0x3A)
b0ca: 5e           ?
b0cb: 32           pula
b0cc: 30           tsx
b0cd: 30           tsx
b0ce: 31           ins
b0cf: 31           ins
b0d0: 2e 43        bgt [0xB115]
b0d2: 6c 65        inc (X+0x65)
b0d4: 61           ?
b0d5: 72           ?
b0d6: 20 72        bra [0xB14A]
b0d8: 6e 64        jmp (X+0x64)
b0da: 20 65        bra [0xB141]
b0dc: 6e 61        jmp (X+0x61)
b0de: 62           ?
b0df: 6c 65        inc (X+0x65)
b0e1: 73 5e 32     com (0x5E32)
b0e4: 30           tsx
b0e5: 32           pula
b0e6: 38           pulx
b0e7: 20 36        bra [0xB11F]
b0e9: 2e 53        bgt [0xB13E]
b0eb: 65           ?
b0ec: 74 20 6c     lsr (0x206C)
b0ef: 6f 63        clr (X+0x63)
b0f1: 20 6e        bra [0xB161]
b0f3: 61           ?
b0f4: 6d 65        tst (X+0x65)
b0f6: 2d 23        blt [0xB11B]
b0f8: 5e           ?
b0f9: 32           pula
b0fa: 30           tsx
b0fb: 35           txs
b0fc: 34           des
b0fd: 31           ins
b0fe: 31           ins
b0ff: 2e 44        bgt [0xB145]
b101: 69 61        rol (X+0x61)
b103: 67 6e        asr (X+0x6E)
b105: 6f 73        clr (X+0x73)
b107: 74 69 63     lsr (0x6963)
b10a: 73 5e 32     com (0x5E32)
b10d: 31           ins
b10e: 30           tsx
b10f: 31           ins
b110: 32           pula
b111: 2e 53        bgt [0xB166]
b113: 65           ?
b114: 74 20 72     lsr (0x2072)
b117: 6e 64        jmp (X+0x64)
b119: 20 65        bra [0xB180]
b11b: 6e 61        jmp (X+0x61)
b11d: 62           ?
b11e: 6c 65        inc (X+0x65)
b120: 73 5e 32     com (0x5E32)
b123: 31           ins
b124: 32           pula
b125: 38           pulx
b126: 20 37        bra [0xB15F]
b128: 2e 53        bgt [0xB17D]
b12a: 65           ?
b12b: 74 20 54     lsr (0x2054)
b12e: 69 6d        rol (X+0x6D)
b130: 65           ?
b131: 5e           ?
b132: 32           pula
b133: 31           ins
b134: 35           txs
b135: 34           des
b136: 31           ins
b137: 32           pula
b138: 2e 5e        bgt [0xB198]
b13a: 32           pula
b13b: 32           pula
b13c: 30           tsx
b13d: 31           ins
b13e: 33           pulb
b13f: 2e 53        bgt [0xB194]
b141: 65           ?
b142: 74 20 72     lsr (0x2072)
b145: 65           ?
b146: 67 20        asr (X+0x20)
b148: 74 61 70     lsr (0x6170)
b14b: 65           ?
b14c: 20 23        bra [0xB171]
b14e: 5e           ?
b14f: 32           pula
b150: 32           pula
b151: 32           pula
b152: 38           pulx
b153: 20 38        bra [0xB18D]
b155: 2e 44        bgt [0xB19B]
b157: 69 73        rol (X+0x73)
b159: 62           ?
b15a: 6c 2d        inc (X+0x2D)
b15c: 65           ?
b15d: 6e 62        jmp (X+0x62)
b15f: 6c 20        inc (X+0x20)
b161: 73 68 6f     com (0x686F)
b164: 77 5e 32     asr (0x5E32)
b167: 32           pula
b168: 35           txs
b169: 34           des
b16a: 31           ins
b16b: 33           pulb
b16c: 2e 5e        bgt [0xB1CC]
b16e: 32           pula
b16f: 33           pulb
b170: 30           tsx
b171: 31           ins
b172: 34           des
b173: 2e 53        bgt [0xB1C8]
b175: 65           ?
b176: 74 20 6c     lsr (0x206C)
b179: 69 76        rol (X+0x76)
b17b: 20 74        bra [0xB1F1]
b17d: 61           ?
b17e: 70 65 20     neg (0x6520)
b181: 23 5e        bls [0xB1E1]
b183: 32           pula
b184: 33           pulb
b185: 32           pula
b186: 38           pulx
b187: 20 39        bra [0xB1C2]
b189: 2e 55        bgt [0xB1E0]
b18b: 70 6c 6f     neg (0x6C6F)
b18e: 61           ?
b18f: 64 20        lsr (X+0x20)
b191: 70 72 6f     neg (0x726F)
b194: 67 72        asr (X+0x72)
b196: 61           ?
b197: 6d 5e        tst (X+0x5E)
b199: 32           pula
b19a: 33           pulb
b19b: 35           txs
b19c: 34           des
b19d: 31           ins
b19e: 34           des
b19f: 2e 5e        bgt [0xB1FF]
b1a1: 32           pula
b1a2: 34           des
b1a3: 30           tsx
b1a4: 31           ins
b1a5: 35           txs
b1a6: 2e 52        bgt [0xB1FA]
b1a8: 65           ?
b1a9: 73 65 74     com (0x6574)
b1ac: 20 68        bra [0xB216]
b1ae: 69 73        rol (X+0x73)
b1b0: 74 6f 72     lsr (0x6F72)
b1b3: 79 5e 32     rol (0x5E32)
b1b6: 34           des
b1b7: 32           pula
b1b8: 38           pulx
b1b9: 31           ins
b1ba: 30           tsx
b1bb: 2e 44        bgt [0xB201]
b1bd: 65           ?
b1be: 62           ?
b1bf: 75           ?
b1c0: 67 67        asr (X+0x67)
b1c2: 65           ?
b1c3: 72           ?
b1c4: 5e           ?
b1c5: 32           pula
b1c6: 34           des
b1c7: 35           txs
b1c8: 34           des
b1c9: 31           ins
b1ca: 35           txs
b1cb: 2e 5e        bgt [0xB22B]
b1cd: 31           ins
b1ce: 38           pulx
b1cf: 34           des
b1d0: 30           tsx
b1d1: 00           test

; back to code
b1d2: ce b1 d8     ldx 0xB1D8       ; escape sequence?
b1d5: 7e 8a 1a     jmp L8A1A  

; esc[2J ?
b1d8: 1b           aba
b1d9: 5b           ?
b1da: 32           pula
b1db: 4a           deca
b1dc: 00           test

b1dd: ce 05 a0     ldx 0x05A0
b1e0: cc 00 00     ldd 0x0000
b1e3: fd 02 9e     std (0x029E)
b1e6: fc 02 9e     ldd (0x029E)
b1e9: c3 00 01     addd 0x0001
b1ec: fd 02 9e     std (0x029E)
b1ef: 1a 83 0f a0  cpd 0x0FA0
b1f3: 24 28        bcc [0xB21D]
b1f5: bd b2 23     jsr (0xB223)
b1f8: 25 04        bcs [0xB1FE]
b1fa: 3f           swi
b1fb: 20 e9        bra [0xB1E6]
b1fd: 39           rts

b1fe: a7 00        staa (X+0x00)
b200: 08           inx
b201: 81 0d        cmpa 0x0D
b203: 26 02        bne [0xB207]
b205: 20 18        bra [0xB21F]
b207: 81 1b        cmpa 0x1B
b209: 26 02        bne [0xB20D]
b20b: 20 10        bra [0xB21D]
b20d: 7d 00 b3     tst (0x00B3)
b210: 27 03        beq [0xB215]
b212: bd 8b 3b     jsr (0x8B3B)
b215: cc 00 00     ldd 0x0000
b218: fd 02 9e     std (0x029E)
b21b: 20 c9        bra [0xB1E6]
b21d: 0d           sec
b21e: 39           rts

b21f: 6f 00        clr (X+0x00)
b221: 0c           clc
b222: 39           rts

b223: b6 18 0d     ldaa (0x180D)
b226: 44           lsra
b227: 25 0b        bcs [0xB234]
b229: 4f           clra
b22a: b7 18 0d     staa (0x180D)
b22d: 86 30        ldaa 0x30
b22f: b7 18 0d     staa (0x180D)
b232: 0c           clc
b233: 39           rts

b234: 86 01        ldaa 0x01
b236: b7 18 0d     staa (0x180D)
b239: 86 70        ldaa 0x70
b23b: b5 18 0d     bita (0x180D)
b23e: 26 05        bne [0xB245]
b240: 0d           sec
b241: b6 18 0f     ldaa (0x180F)
b244: 39           rts

b245: b6 18 0f     ldaa (0x180F)
b248: 86 30        ldaa 0x30
b24a: b7 18 0c     staa (0x180C)
b24d: 0c           clc
b24e: 39           rts
.endif
        .org    0xb24f

        pulx
        ldy     #0x05A0
LB254:
        ldaa    0,X
        beq     LB269
        inx
        cmpa    0,Y
        bne     LB262
        iny
        bra     LB254
LB262:
        ldaa    0,X
        beq     LB26D
        inx
        bra     LB262
LB269:
        inx
        pshx
        clc
        rts
LB26D:
        inx
        pshx
        sec
        rts

        ldx     #0x05A0
LB274:
        ldaa    0,X
        inx
        cmpa    #0x0D
        bne     LB274
        dex
        dex
        ldaa    0,X
        dex
        suba    #0x30
        staa    (0x00B2)
        cpx     #0x059F
        beq     LB294
        ldaa    0,X
        dex
        suba    #0x30
        ldab    #0x0A
        mul
        tba
        adda    (0x00B2)
LB294:
        rts

        .org    0xb295
; text
LB295:
        .asciz  'You have selected #1'
LB2AA:
        .asciz  'You have selected #11'

; code
        ldx     #0xB2C7     ; strange text
        jsr     L8A1A  
        rts

.if 0
; text
b2c7: 5e           ?
b2c8: 32           pula
b2c9: 30           tsx
b2ca: 30           tsx
b2cb: 31           ins
b2cc: 25 5e        bcs [0xB32C]
b2ce: 32           pula
b2cf: 31           ins
b2d0: 30           tsx
b2d1: 31           ins
b2d2: 25 5e        bcs [0xB332]
b2d4: 32           pula
b2d5: 32           pula
b2d6: 30           tsx
b2d7: 31           ins
b2d8: 25 5e        bcs [0xB338]
b2da: 32           pula
b2db: 33           pulb
b2dc: 30           tsx
b2dd: 31           ins
b2de: 25 5e        bcs [0xB33E]
b2e0: 32           pula
b2e1: 34           des
b2e2: 30           tsx
b2e3: 31           ins
b2e4: 25 5e        bcs [0xB344]
b2e6: 32           pula
b2e7: 30           tsx
b2e8: 30           tsx
b2e9: 31           ins
b2ea: 00           test

b2eb: fa 20 fa     orab (0x20FA)
b2ee: 20 f6        bra [0xB2E6]
b2f0: 22 f5        bhi [0xB2E7]
b2f2: 20 f5        bra [0xB2E9]
b2f4: 20 f3        bra [0xB2E9]
b2f6: 22 f2        bhi [0xB2EA]
b2f8: 20 e5        bra [0xB2DF]
b2fa: 22 e5        bhi [0xB2E1]
b2fc: 22 e2        bhi [0xB2E0]
b2fe: 20 d2        bra [0xB2D2]
b300: 20 be        bra [0xB2C0]
b302: 00           test
b303: bc 22 bb     cpx (0x22BB)
b306: 30           tsx
b307: b9 32 b9     adca (0x32B9)
b30a: 32           pula
b30b: b7 30 b6     staa (0x30B6)
b30e: 32           pula
b30f: b5 30 b4     bita (0x30B4)
b312: 32           pula
b313: b4 32 b3     anda (0x32B3)
b316: 20 b3        bra [0xB2CB]
b318: 20 b1        bra [0xB2CB]
b31a: a0 b1        suba (X+0xB1)
b31c: a0 b0        suba (X+0xB0)
b31e: a2 af        sbca (X+0xAF)
b320: a0 af        suba (X+0xAF)
b322: a6 ae        ldaa (X+0xAE)
b324: a0 ae        suba (X+0xAE)
b326: a6 ad        ldaa (X+0xAD)
b328: a4 ac        anda (X+0xAC)
b32a: a0 ac        suba (X+0xAC)
b32c: a0 ab        suba (X+0xAB)
b32e: a0 aa        suba (X+0xAA)
b330: a0 aa        suba (X+0xAA)
b332: a0 a2        suba (X+0xA2)
b334: 80 a0        suba 0xA0
b336: a0 a0        suba (X+0xA0)
b338: a0 8d        suba (X+0x8D)
b33a: 80 8a        suba 0x8A
b33c: a0 7e        suba (X+0x7E)
b33e: 80 7b        suba 0x7B
b340: a0 79        suba (X+0x79)
b342: a4 78        anda (X+0x78)
b344: a0 77        suba (X+0x77)
b346: a4 76        anda (X+0x76)
b348: a0 75        suba (X+0x75)
b34a: a4 74        anda (X+0x74)
b34c: a0 73        suba (X+0x73)
b34e: a4 72        anda (X+0x72)
b350: a0 71        suba (X+0x71)
b352: a4 70        anda (X+0x70)
b354: a0 6f        suba (X+0x6F)
b356: a4 6e        anda (X+0x6E)
b358: a0 6d        suba (X+0x6D)
b35a: a4 6c        anda (X+0x6C)
b35c: a0 69        suba (X+0x69)
b35e: 80 69        suba 0x69
b360: 80 67        suba 0x67
b362: a0 5e        suba (X+0x5E)
b364: 20 58        bra [0xB3BE]
b366: 24 57        bcc [0xB3BF]
b368: 20 57        bra [0xB3C1]
b36a: 20 56        bra [0xB3C2]
b36c: 24 55        bcc [0xB3C3]
b36e: 20 54        bra [0xB3C4]
b370: 24 54        bcc [0xB3C6]
b372: 24 53        bcc [0xB3C7]
b374: 20 52        bra [0xB3C8]
b376: 24 52        bcc [0xB3CA]
b378: 24 50        bcc [0xB3CA]
b37a: 20 4f        bra [0xB3CB]
b37c: 24 4e        bcc [0xB3CC]
b37e: 20 4d        bra [0xB3CD]
b380: 24 4c        bcc [0xB3CE]
b382: 20 4c        bra [0xB3D0]
b384: 20 4b        bra [0xB3D1]
b386: 24 4a        bcc [0xB3D2]
b388: 20 49        bra [0xB3D3]
b38a: 20 49        bra [0xB3D5]
b38c: 00           test
b38d: 48           asla
b38e: 20 47        bra [0xB3D7]
b390: 20 47        bra [0xB3D9]
b392: 20 46        bra [0xB3DA]
b394: 20 45        bra [0xB3DB]
b396: 24 45        bcc [0xB3DD]
b398: 24 44        bcc [0xB3DE]
b39a: 20 42        bra [0xB3DE]
b39c: 20 42        bra [0xB3E0]
b39e: 20 37        bra [0xB3D7]
b3a0: 04           lsrd
b3a1: 35           txs
b3a2: 20 2e        bra [0xB3D2]
b3a4: 04           lsrd
b3a5: 2e 04        bgt [0xB3AB]
b3a7: 2d 20        blt [0xB3C9]
b3a9: 23 24        bls [0xB3CF]
b3ab: 21 20        brn [0xB3CD]
b3ad: 17           tba
b3ae: 24 13        bcc [0xB3C3]
b3b0: 00           test
b3b1: 11           cba
b3b2: 24 10        bcc [0xB3C4]
b3b4: 30           tsx
b3b5: 07           tpa
b3b6: 34           des
b3b7: 06           tap
b3b8: 30           tsx
b3b9: 05           asld
b3ba: 30           tsx
b3bb: ff ff d7     stx (0xFFD7)
b3be: 22 d5        bhi [0xB395]
b3c0: 20 c9        bra [0xB38B]
b3c2: 22 c7        bhi [0xB38B]
b3c4: 20 c4        bra [0xB38A]
b3c6: 24 c3        bcc [0xB38B]
b3c8: 20 c2        bra [0xB38C]
b3ca: 24 c1        bcc [0xB38D]
b3cc: 20 bf        bra [0xB38D]
b3ce: 24 bf        bcc [0xB38F]
b3d0: 24 be        bcc [0xB390]
b3d2: 20 bd        bra [0xB391]
b3d4: 24 bc        bcc [0xB392]
b3d6: 20 bb        bra [0xB393]
b3d8: 24 ba        bcc [0xB394]
b3da: 20 b9        bra [0xB395]
b3dc: 20 b8        bra [0xB396]
b3de: 24 b7        bcc [0xB397]
b3e0: 20 b4        bra [0xB396]
b3e2: 00           test
b3e3: b4 00 b2     anda (0x00B2)
b3e6: 20 a9        bra [0xB391]
b3e8: 20 a3        bra [0xB38D]
b3ea: 20 a2        bra [0xB38E]
b3ec: 20 a1        bra [0xB38F]
b3ee: 20 a0        bra [0xB390]
b3f0: 20 a0        bra [0xB392]
b3f2: 20 9f        bra [0xB393]
b3f4: 20 9f        bra [0xB395]
b3f6: 20 9e        bra [0xB396]
b3f8: 20 9d        bra [0xB397]
b3fa: 24 9d        bcc [0xB399]
b3fc: 24 9b        bcc [0xB399]
b3fe: 20 9a        bra [0xB39A]
b400: 24 99        bcc [0xB39B]
b402: 20 98        bra [0xB39C]
b404: 20 97        bra [0xB39D]
b406: 24 97        bcc [0xB39F]
b408: 24 95        bcc [0xB39F]
b40a: 20 95        bra [0xB3A1]
b40c: 20 94        bra [0xB3A2]
b40e: 00           test
b40f: 94 00        anda (0x0000)
b411: 93 20        subd (0x0020)
b413: 92 00        sbca (0x0000)
b415: 92 00        sbca (0x0000)
b417: 91 20        cmpa (0x0020)
b419: 90 20        suba (0x0020)
b41b: 90 20        suba (0x0020)
b41d: 8f           xgdx
b41e: 20 8d        bra [0xB3AD]
b420: 20 8d        bra [0xB3AF]
b422: 20 81        bra [0xB3A5]
b424: 00           test
b425: 7f 20 79     clr (0x2079)
b428: 00           test
b429: 79 00 78     rol (0x0078)
b42c: 20 76        bra [0xB4A4]
b42e: 20 6b        bra [0xB49B]
b430: 00           test
b431: 69 20        rol (X+0x20)
b433: 5e           ?
b434: 00           test
b435: 5c           incb
b436: 20 5b        bra [0xB493]
b438: 30           tsx
b439: 52           ?
b43a: 10           sba
b43b: 51           ?
b43c: 30           tsx
b43d: 50           negb
b43e: 30           tsx
b43f: 50           negb
b440: 30           tsx
b441: 4f           clra
b442: 20 4e        bra [0xB492]
b444: 20 4e        bra [0xB494]
b446: 20 4d        bra [0xB495]
b448: 20 46        bra [0xB490]
b44a: a0 45        suba (X+0x45)
b44c: a0 3d        suba (X+0x3D)
b44e: a0 3d        suba (X+0x3D)
b450: a0 39        suba (X+0x39)
b452: 20 2a        bra [0xB47E]
b454: 00           test
b455: 28 20        bvc [0xB477]
b457: 1e 00 1c 22  brset (X+0x00), 0x1C, [0xB47D]
b45b: 1c 22 1b     bset (X+0x22), 0x1B
b45e: 20 1a        bra [0xB47A]
b460: 22 19        bhi [0xB47B]
b462: 20 18        bra [0xB47C]
b464: 22 18        bhi [0xB47E]
b466: 22 16        bhi [0xB47E]
b468: 20 15        bra [0xB47F]
b46a: 22 15        bhi [0xB481]
b46c: 22 14        bhi [0xB482]
b46e: a0 13        suba (X+0x13)
b470: a2 11        sbca (X+0x11)
b472: a0 ff        suba (X+0xFF)
b474: ff be 00     stx (0xBE00)
b477: bc 22 bb     cpx (0x22BB)
b47a: 30           tsx
b47b: b9 32 b9     adca (0x32B9)
b47e: 32           pula
b47f: b7 30 b6     staa (0x30B6)
b482: 32           pula
b483: b5 30 b4     bita (0x30B4)
b486: 32           pula
b487: b4 32 b3     anda (0x32B3)
b48a: 20 b3        bra [0xB43F]
b48c: 20 b1        bra [0xB43F]
b48e: a0 b1        suba (X+0xB1)
b490: a0 b0        suba (X+0xB0)
b492: a2 af        sbca (X+0xAF)
b494: a0 af        suba (X+0xAF)
b496: a6 ae        ldaa (X+0xAE)
b498: a0 ae        suba (X+0xAE)
b49a: a6 ad        ldaa (X+0xAD)
b49c: a4 ac        anda (X+0xAC)
b49e: a0 ac        suba (X+0xAC)
b4a0: a0 ab        suba (X+0xAB)
b4a2: a0 aa        suba (X+0xAA)
b4a4: a0 aa        suba (X+0xAA)
b4a6: a0 a2        suba (X+0xA2)
b4a8: 80 a0        suba 0xA0
b4aa: a0 a0        suba (X+0xA0)
b4ac: a0 8d        suba (X+0x8D)
b4ae: 80 8a        suba 0x8A
b4b0: a0 7e        suba (X+0x7E)
b4b2: 80 7b        suba 0x7B
b4b4: a0 79        suba (X+0x79)
b4b6: a4 78        anda (X+0x78)
b4b8: a0 77        suba (X+0x77)
b4ba: a4 76        anda (X+0x76)
b4bc: a0 75        suba (X+0x75)
b4be: a4 74        anda (X+0x74)
b4c0: a0 73        suba (X+0x73)
b4c2: a4 72        anda (X+0x72)
b4c4: a0 71        suba (X+0x71)
b4c6: a4 70        anda (X+0x70)
b4c8: a0 6f        suba (X+0x6F)
b4ca: a4 6e        anda (X+0x6E)
b4cc: a0 6d        suba (X+0x6D)
b4ce: a4 6c        anda (X+0x6C)
b4d0: a0 69        suba (X+0x69)
b4d2: 80 69        suba 0x69
b4d4: 80 67        suba 0x67
b4d6: a0 5e        suba (X+0x5E)
b4d8: 20 58        bra [0xB532]
b4da: 24 57        bcc [0xB533]
b4dc: 20 57        bra [0xB535]
b4de: 20 56        bra [0xB536]
b4e0: 24 55        bcc [0xB537]
b4e2: 20 54        bra [0xB538]
b4e4: 24 54        bcc [0xB53A]
b4e6: 24 53        bcc [0xB53B]
b4e8: 20 52        bra [0xB53C]
b4ea: 24 52        bcc [0xB53E]
b4ec: 24 50        bcc [0xB53E]
b4ee: 20 4f        bra [0xB53F]
b4f0: 24 4e        bcc [0xB540]
b4f2: 20 4d        bra [0xB541]
b4f4: 24 4c        bcc [0xB542]
b4f6: 20 4c        bra [0xB544]
b4f8: 20 4b        bra [0xB545]
b4fa: 24 4a        bcc [0xB546]
b4fc: 20 49        bra [0xB547]
b4fe: 20 49        bra [0xB549]
b500: 00           test
b501: 48           asla
b502: 20 47        bra [0xB54B]
b504: 20 47        bra [0xB54D]
b506: 20 46        bra [0xB54E]
b508: 20 45        bra [0xB54F]
b50a: 24 45        bcc [0xB551]
b50c: 24 44        bcc [0xB552]
b50e: 20 42        bra [0xB552]
b510: 20 42        bra [0xB554]
b512: 20 37        bra [0xB54B]
b514: 04           lsrd
b515: 35           txs
b516: 20 2e        bra [0xB546]
b518: 04           lsrd
b519: 2e 04        bgt [0xB51F]
b51b: 2d 20        blt [0xB53D]
b51d: 23 24        bls [0xB543]
b51f: 21 20        brn [0xB541]
b521: 17           tba
b522: 24 13        bcc [0xB537]
b524: 00           test
b525: 11           cba
b526: 24 10        bcc [0xB538]
b528: 30           tsx
b529: 07           tpa
b52a: 34           des
b52b: 06           tap
b52c: 30           tsx
b52d: 05           asld
b52e: 30           tsx
b52f: ff ff cd     stx (0xFFCD)
b532: 20 cc        bra [0xB500]
b534: 20 cb        bra [0xB501]
b536: 20 cb        bra [0xB503]
b538: 20 ca        bra [0xB504]
b53a: 00           test
b53b: c9 20        adcb 0x20
b53d: c9 20        adcb 0x20
b53f: c8 20        eorb 0x20
b541: c1 a0        cmpb 0xA0
b543: c0 a0        subb 0xA0
b545: b8 a0 b8     eora (0xA0B8)
b548: 20 b4        bra [0xB4FE]
b54a: 20 a6        bra [0xB4F2]
b54c: 00           test
b54d: a4 20        anda (X+0x20)
b54f: 99 00        adca (0x0000)
b551: 97 22        staa (0x0022)
b553: 97 22        staa (0x0022)
b555: 96 20        ldaa (0x0020)
b557: 95 22        bita (0x0022)
b559: 94 20        anda (0x0020)
b55b: 93 22        subd (0x0022)
b55d: 93 22        subd (0x0022)
b55f: 91 20        cmpa (0x0020)
b561: 90 20        suba (0x0020)
b563: 90 20        suba (0x0020)
b565: 8d a0        bsr [0xB507]
b567: 8c a0 7d     cpx 0xA07D
b56a: a2 7d        sbca (X+0x7D)
b56c: a2 7b        sbca (X+0x7B)
b56e: a0 7b        suba (X+0x7B)
b570: a0 79        suba (X+0x79)
b572: a2 79        sbca (X+0x79)
b574: a2 77        sbca (X+0x77)
b576: a0 77        suba (X+0x77)
b578: a0 76        suba (X+0x76)
b57a: 80 75        suba 0x75
b57c: a0 6e        suba (X+0x6E)
b57e: 20 67        bra [0xB5E7]
b580: 24 66        bcc [0xB5E8]
b582: 20 65        bra [0xB5E9]
b584: 24 64        bcc [0xB5EA]
b586: 20 63        bra [0xB5EB]
b588: 24 63        bcc [0xB5ED]
b58a: 24 61        bcc [0xB5ED]
b58c: 20 60        bra [0xB5EE]
b58e: 24 5f        bcc [0xB5EF]
b590: 20 5e        bra [0xB5F0]
b592: 20 5d        bra [0xB5F1]
b594: 24 5c        bcc [0xB5F2]
b596: 20 5b        bra [0xB5F3]
b598: 24 5a        bcc [0xB5F4]
b59a: 20 59        bra [0xB5F5]
b59c: 24 58        bcc [0xB5F6]
b59e: 20 56        bra [0xB5F6]
b5a0: 20 55        bra [0xB5F7]
b5a2: 04           lsrd
b5a3: 54           lsrb
b5a4: 00           test
b5a5: 53           comb
b5a6: 24 52        bcc [0xB5FA]
b5a8: 20 52        bra [0xB5FC]
b5aa: 20 4f        bra [0xB5FB]
b5ac: 24 4f        bcc [0xB5FD]
b5ae: 24 4e        bcc [0xB5FE]
b5b0: 30           tsx
b5b1: 4d           tsta
b5b2: 30           tsx
b5b3: 47           asra
b5b4: 10           sba
b5b5: 45           ?
b5b6: 30           tsx
b5b7: 35           txs
b5b8: 30           tsx
b5b9: 33           pulb
b5ba: 10           sba
b5bb: 31           ins
b5bc: 30           tsx
b5bd: 31           ins
b5be: 30           tsx
b5bf: 1d 20 ff     bclr (X+0x20), 0xFF
b5c2: ff a9 20     stx (0xA920)
b5c5: a3 20        subd (X+0x20)
b5c7: a2 20        sbca (X+0x20)
b5c9: a1 20        cmpa (X+0x20)
b5cb: a0 20        suba (X+0x20)
b5cd: a0 20        suba (X+0x20)
b5cf: 9f 20        sts (0x0020)
b5d1: 9f 20        sts (0x0020)
b5d3: 9e 20        lds (0x0020)
b5d5: 9d 24        jsr (0x0024)
b5d7: 9d 24        jsr (0x0024)
b5d9: 9b 20        adda (0x0020)
b5db: 9a 24        oraa (0x0024)
b5dd: 99 20        adca (0x0020)
b5df: 98 20        eora (0x0020)
b5e1: 97 24        staa (0x0024)
b5e3: 97 24        staa (0x0024)
b5e5: 95 20        bita (0x0020)
b5e7: 95 20        bita (0x0020)
b5e9: 94 00        anda (0x0000)
b5eb: 94 00        anda (0x0000)
b5ed: 93 20        subd (0x0020)
b5ef: 92 00        sbca (0x0000)
b5f1: 92 00        sbca (0x0000)
b5f3: 91 20        cmpa (0x0020)
b5f5: 90 20        suba (0x0020)
b5f7: 90 20        suba (0x0020)
b5f9: 8f           xgdx
b5fa: 20 8d        bra [0xB589]
b5fc: 20 8d        bra [0xB58B]
b5fe: 20 81        bra [0xB581]
b600: 00           test
b601: 7f 20 79     clr (0x2079)
b604: 00           test
b605: 79 00 78     rol (0x0078)
b608: 20 76        bra [0xB680]
b60a: 20 6b        bra [0xB677]
b60c: 00           test
b60d: 69 20        rol (X+0x20)
b60f: 5e           ?
b610: 00           test
b611: 5c           incb
b612: 20 5b        bra [0xB66F]
b614: 30           tsx
b615: 52           ?
b616: 10           sba
b617: 51           ?
b618: 30           tsx
b619: 50           negb
b61a: 30           tsx
b61b: 50           negb
b61c: 30           tsx
b61d: 4f           clra
b61e: 20 4e        bra [0xB66E]
b620: 20 4e        bra [0xB670]
b622: 20 4d        bra [0xB671]
b624: 20 46        bra [0xB66C]
b626: a0 45        suba (X+0x45)
b628: a0 3d        suba (X+0x3D)
b62a: a0 3d        suba (X+0x3D)
b62c: a0 39        suba (X+0x39)
b62e: 20 2a        bra [0xB65A]
b630: 00           test
b631: 28 20        bvc [0xB653]
b633: 1e 00 1c 22  brset (X+0x00), 0x1C, [0xB659]
b637: 1c 22 1b     bset (X+0x22), 0x1B
b63a: 20 1a        bra [0xB656]
b63c: 22 19        bhi [0xB657]
b63e: 20 18        bra [0xB658]
b640: 22 18        bhi [0xB65A]
b642: 22 16        bhi [0xB65A]
b644: 20 15        bra [0xB65B]
b646: 22 15        bhi [0xB65D]
b648: 22 14        bhi [0xB65E]
b64a: a0 13        suba (X+0x13)
b64c: a2 11        sbca (X+0x11)
b64e: a0 ff        suba (X+0xFF)

.endif

; All empty (0xFFs) in this gap

        .org    0xf780

; Table???
        .byte   0x57
        .byte   0x0b
        .byte   0x00
        .byte   0x00
        .byte   0x00
        .byte   0x00
        .byte   0x08
        .byte   0x00
        .byte   0x00
        .byte   0x00
        .byte   0x20
        .byte   0x00
        .byte   0x00
        .byte   0x00
        .byte   0x80
        .byte   0x00
        .byte   0x00
        .byte   0x00
        .byte   0x00
        .byte   0x00
        .byte   0x00
        .byte   0x04
        .byte   0x00
        .byte   0x00
        .byte   0x00
        .byte   0x10
        .byte   0x00
        .byte   0x00
        .byte   0x00
        .byte   0x00
        .byte   0x00
        .byte   0x00
        .byte   0x40
        .byte   0x12
        .byte   0x20
        .byte   0x09
        .byte   0x80
        .byte   0x24
        .byte   0x02
        .byte   0x00
        .byte   0x40
        .byte   0x12
        .byte   0x20
        .byte   0x09
        .byte   0x80
        .byte   0x24
        .byte   0x04
        .byte   0x00
        .byte   0x00
        .byte   0x00
        .byte   0x00
        .byte   0x00
        .byte   0x00
        .byte   0x00
        .byte   0x00
        .byte   0x00
        .byte   0x00
        .byte   0x00
        .byte   0x00
        .byte   0x00
        .byte   0x08
        .byte   0x00
        .byte   0x00
        .byte   0x00
        .byte   0x00
;
; is the rest of this table 0xff, or is this margin??
;
        .org    0xf800
; Reset
RESET:
        sei                 ; disable interrupts
        ldaa    #0x03
        staa    TMSK2       ; disable irqs, set prescaler to 16
        ldaa    #0x80
        staa    TMSK1       ; enable OC1 (LCD?) irq
        ldaa    #0xFE
        staa    BPROT       ; protect everything except $xE00-$xE1F
        ldaa    (0x0007)    ;
        cmpa    #0xDB       ; special unprotect mode???
        bne     LF81C       ; if not, jump ahead
        clr     BPROT       ; else unprotect everything
        clr     (0x0007)    ; reset special unprotect mode???
LF81C:
        lds     #0x01FF     ; init SP
        ldaa    #0xA5
        staa    CSCTL       ; enable external IO:
                            ; IO1EN,  BUSSEL, active LOW
                            ; IO2EN,  PIA/SCCSEL, active LOW
                            ; CSPROG, ROMSEL priority over RAMSEL 
                            ; CSPROG, ROMSEL enabled, 32K, $8000-$FFFF
        ldaa    #0x01
        staa    CSGSIZ      ; CSGEN,  RAMSEL active low
                            ; CSGEN,  RAMSEL 32K
        ldaa    #0x00
        staa    CSGADR      ; CSGEN,  RAMSEL = $0000-$7FFF (except internal regs)
        ldaa    #0xF0
        staa    CSSTRH      ; 3 cycle clock stretching on BUSSEL and LCRS
        clr     (0x0000)    ; ????? Done with basic init?

; Initialize Main PIA
        ldaa    #0x30       ;
        staa    (0x1805)    ; control register A, CA2=0, sel DDRA
        staa    (0x1807)    ; control register B, CB2=0, sel DDRB
        ldaa    #0xFF
        staa    (0x1806)    ; select B0-B7 to be outputs
        ldaa    #0x78       ;
        staa    (0x1804)    ; select A3-A6 to be outputs
        ldaa    #0x34       ;
        staa    (0x1805)    ; select output register A
        staa    (0x1807)    ; select output register B
        ldab    #0xFF
        jsr     (0xF9C5)    ; clear dignostic digit display
        bra     LF86A       ; jump past data table

; Data loaded into (0x180D) SCC
        .byte   0x09,0x4a   ; channel reset B, master irq enable, no vector
        .byte   0x01,0x10   ; irq on all character received
        .byte   0x0c,0x18   ; Lower byte of time constant
        .byte   0x0d,0x00   ; Upper byte of time constant
        .byte   0x04,0x44   ; X16 clock mode, 8-bit sync char, 1 stop bit, no parity
        .byte   0x0e,0x63   ; Disable DPLL, BR enable & source
        .byte   0x05,0x68   ; No DTR/RTS, Tx 8 bits/char, Tx enable
        .byte   0x0b,0x56   ; Rx & Tx & TRxC clk from BR gen
        .byte   0x03,0xc1   ; Rx 8 bits/char, Rx Enable
        ;   tc = 4Mhz / (2 * DesiredRate * BRClockPeriod) - 2
        .byte   0xff        ; end of table marker

; init SCC (8530)
LF86A:
        ldx     #0xF857
LF86D:
        ldaa    0,X
        cmpa    #0xFF
        beq     LF879
        staa    (0x180D)
        inx
        bra     LF86D

; Setup normal SCI, 8 data bits, 1 stop bit
; Interrupts disabled, Transmitter and Receiver enabled
; prescaler = /13, SCR=/2, rate = 9600 baud at 16Mhz clock

LF879:
        ldaa    #0x00
        staa    SCCR1  
        ldaa    #0x0C
        staa    SCCR2  
        ldaa    #0x31
        staa    BAUD  

; Initialize all RAM vectors to RTI: 
; Opcode 0x3b into vectors at 0x0100 through 0x0139

        ldx     #0x0100
        ldaa    #0x3B       ; RTI opcode
LF88D:
        staa    0,X
        inx
        inx
        inx
        cpx     #0x013C
        bcs     LF88D
        ldab    #0xF0
        stab    (0x1804)    ; enable LCD backlight, disable RESET button light
        ldaa    #0x7E
        staa    (0x0003)    ; Put a jump instruction here???

; Non-destructive ram test:
;
; HC11 Internal RAM: 0x0000-0x3ff
; External NVRAM:    0x2000-0x7fff
;
; Note:
; External NVRAM:    0x0400-0xfff is also available, but not tested

        ldx     #0x0000
LF8A3:
        ldab    0,X         ; save value
        ldaa    #0x55
        staa    0,X
        cmpa    0,X
        bne     LF8C6
        rola
        staa    0,X
        cmpa    0,X
        bne     LF8C6
        stab    0,X         ; restore value
        inx
        cpx     #0x0400
        bne     LF8BF
        ldx     #0x2000
LF8BF:  
        cpx     #0x8000
        bne     LF8A3
        bra     LF8CA

LF8C6:
        ldaa    #0x01       ; Mark Failed RAM test?
        staa    (0x0000)
; 
LF8CA:
        ldab    #0x01
        jsr     (0xF995)    ; write digit 1 to diag display
        ldaa    BPROT  
        bne     LF8E3       ; if something is protected, jump ahead
        ldaa    (0x3000)    ; NVRAM
        cmpa    #0x7E
        bne     LF8E3       ; if RAM(0x3000) == 0x7E, jump ahead anyway (special unlock?)

; error?
        ldab    #0x0E
        jsr     (0xF995)     ; write digit E to diag display
        jmp     (0x3000)     ; jump to routine in NVRAM?

; checking for serial connection

LF8E3:
        ldx     #0xF000     ; timeout counter
LF8E6:
        nop
        nop
        dex
        beq     LF8F6       ; if time is up, jump ahead
        jsr     (0xF945)    ; else read serial data if available
        bcc     LF8E6       ; if no data available, loop
        cmpa    #0x1B       ; if serial data was read, is it an ESC?
        beq     LF91D       ; if so, jump to echo hex char routine?
        bra     LF8E6       ; else loop
LF8F6:
        ldaa    (0x8000)    ; check if this is a regular rom?
        cmpa    #0x7E        
        bne     LF908       ; if not, jump ahead

        ldab    #0x0A
        jsr     (0xF995)    ; else write digit A to diag display

        jsr     (0x8000)    ; jump to start of rom routine
        sei                 ; if we ever come return, just loop and do it all again
        bra     LF8F6

LF908:
        ldab    #0x10       ; not a regular rom
        jsr     LF995       ; blank the diag display

        jsr     LF9D8       ; enter the mini-monitor???
        .ascis  'MINI-MON'

        ldab    #0x10
        jsr     LF995       ; blank the diag display

LF91D:
        clr     (0x0005)
        clr     (0x0004)
        clr     (0x0002)
        clr     (0x0006)

        jsr     LF9D8
        .ascis  '\r\n>'

; convert A to 2 hex digits and transmit??
        psha
        lsra
        lsra
        lsra
        lsra
        jsr     LF938
        pula
LF938:
        anda    #0x0F
        oraa    #0x30
        cmpa    #0x3A
        bcs     LF942
        adda    #0x07
LF942:
        jmp     LF96F

; get serial char if available
        ldaa    SCSR  
        bita    #0x20
        bne     LF955
        clc
        rts

; wait for a serial character
LF94E:
        ldaa    SCSR        ; read serial status
        bita    #0x20
        beq     LF94E       ; if RDRF=0, loop

; read serial data, (assumes it's ready)
LF955:
        ldaa    SCSR        ; read serial status
        bita    #0x02
        bne     LF965       ; if FE=1, clear it
        bita    #0x08
        bne     LF965       ; if OR=1, clear it
        ldaa    SCDR        ; otherwise, good data
        sec
        rts

LF965:
        ldaa    SCDR        ; clear any error
        ldaa    #0x2F       ; '/'   
        jsr     LF96F
        bra     LF94E       ; go to wait for a character

; Send to SCI with CR turned to CRLF
LF96F:
        cmpa    #0x0D       ; CR?
        beq     LF975       ; if so echo CR+LF
        bra     LF97C       ; else just echo it
LF975:
        ldaa    #0x0D
        jsr     LF97C
        ldaa    #0x0A

; send a char to SCI
LF97C:
        ldab    SCSR        ; wait for ready to send
        bitb    #0x40
        beq     LF97C
        staa    SCDR        ; send it
        rts

        jsr     LF94E       ; get a serial char
        cmpa    #0x7A       ;'z'
        bhi     LF994
        cmpa    #0x61       ;'a'
        bcs     LF994
        sbca    #0x20       ;convert to pper case?
LF994:
        rts

; Write hex digit arg in B to diagnostic lights
; or B=0x10 or higher for blank

LF995:
        psha
        cmpb    #0x11
        bcs     LF99C
        ldab    #0x10
LF99C:
        ldx     #LF9B4
        abx
        ldaa    0,X
        staa    (0x1806)    ; write arg to local data bus
        ldaa    (0x1804)    ; read from Port A
        oraa    #0x20       ; bit 5 high
        staa    (0x1804)    ; write back to Port A
        anda    #0xDF       ; bit 5 low
        staa    (0x1804)    ; write back to Port A
        pula
        rts

; 7 segment patterns - XGFEDCBA
LF9B4:
        .byte   0xc0    ; 0
        .byte   0xf9    ; 1
        .byte   0xa4    ; 2
        .byte   0xb0    ; 3
        .byte   0x99    ; 4
        .byte   0x92    ; 5
        .byte   0x82    ; 6
        .byte   0xf8    ; 7
        .byte   0x80    ; 8
        .byte   0x90    ; 9
        .byte   0x88    ; A 
        .byte   0x83    ; b
        .byte   0xc6    ; C
        .byte   0xa1    ; d
        .byte   0x86    ; E
        .byte   0x8e    ; F
        .byte   0xff    ; blank

; Write arg in B to Button Lights

        psha
        stab    (0x1806)    ; write arg to local data bus
        ldaa    (0x1804)    ; read from Port A
        anda    #0xEF       ; bit 4 low
        staa    (0x1804)    ; write back to Port A
        oraa    #0x10       ; bit 4 high
        staa    (0x1804)    ; write this to Port A
        pula
        rts

; Send rom message via SCI

LF9D8:
        puly
LF9DA:
        ldaa    0,Y
        beq     LF9E8       ; if zero terminated, return
        bmi     LF9ED       ; if high bit set..do last char and return
        jsr     LF97C       ; else send char
        iny
        bra     LF9DA       ; and loop for next one

LF9E8:
        iny                 ; setup return address and return
        pshy
        rts

LF9ED:
        anda    #0x7F       ; remove top bit
        jsr     LF97C       ; send char
        bra     LF9E8       ; and we're done
        rts
        rts
        rti

; all 0xffs in this gap

        .org    0xffa0

       jmp (0xF9F5)
       jmp (0xF9F5)
       jmp (0xF9F5)
       jmp (0xF92F)
       jmp (0xF9D8)
       jmp (0xF945)
       jmp (0xF96F)
       jmp (0xF908)
       jmp (0xF995)
       jmp (0xF9C5)

       .byte    0xff
       .byte    0xff

; Vectors

       .word   0xf9f6       ; Stub RTI
       .word   0xf9f6       ; Stub RTI
       .word   0xf9f6       ; Stub RTI
       .word   0xf9f6       ; Stub RTI
       .word   0xf9f6       ; Stub RTI
       .word   0xf9f6       ; Stub RTI
       .word   0xf9f6       ; Stub RTI
       .word   0xf9f6       ; Stub RTI
       .word   0xf9f6       ; Stub RTI
       .word   0xf9f6       ; Stub RTI
       .word   0xf9f6       ; Stub RTI

        .word  0x0100       ; SCI
        .word  0x0103       ; SPI
        .word  0x0106       ; PA accum. input edge
        .word  0x0109       ; PA Overflow

        .word  0xf9f6       ; Stub RTI

        .word  0x010c       ; TI4O5
        .word  0x010f       ; TOC4
        .word  0x0112       ; TOC3
        .word  0x0115       ; TOC2
        .word  0x0118       ; TOC1
        .word  0x011b       ; TIC3
        .word  0x011e       ; TIC2
        .word  0x0121       ; TIC1
        .word  0x0124       ; RTI
        .word  0x0127       ; ~IRQ
        .word  0x012a       ; XIRQ
        .word  0x012d       ; SWI
        .word  0x0130       ; ILLEGAL OPCODE
        .word  0x0133       ; COP Failure
        .word  0x0136       ; COP Clock Monitor Fail

        .word  RESET        ; Reset

