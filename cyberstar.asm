
;;;;;;;;;;;;;;;;;;;;;
; Cyberstar v1.6
;   by
; David B. Philipsen
;
; Reverse-engineering
;   by
; Frank Palazzolo
;;;;;;;;;;;;;;;;;;;;;

; 68HC11 Register definitions

PORTA       .equ    0x1000
DDRA        .equ    0x1001
PORTG       .equ    0x1002
DDRG        .equ    0x1003
PORTE       .equ    0x100a
TOC1        .equ    0x1016
TOC2        .equ    0x1018
TMSK1       .equ    0x1022
TFLG1       .equ    0x1023
TMSK2       .equ    0x1024
BAUD        .equ    0x102b
SCCR1       .equ    0x102c
SCCR2       .equ    0x102d
SCSR        .equ    0x102e
SCDR        .equ    0x102f
BPROT       .equ    0x1035
PPROG       .equ    0x103b
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

; Main PIA on CPU card
PIA0PRA     .equ    0x1804      ; CRA-2 = 1
PIA0DDRA    .equ    0x1804      ; CRA-2 = 0
PIA0CRA     .equ    0x1805
PIA0PRB     .equ    0x1806      ; CRB-2 = 1
PIA0DDRB    .equ    0x1806      ; CRB-2 = 0
PIA0CRB     .equ    0x1807

; Zilog 8530 SCC - A is aux serial, B is sync data
SCCCTRLA    .equ    0x180C
SCCCTRLB    .equ    0x180D
SCCDATAA    .equ    0x180E
SCCDATAB    .equ    0x180F

        .area   region1 (ABS)
        .org    0x8000

; Disassembly originally from unidasm

L8000:
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
        jsr     DIAGDGT         ; blank the diag display

        ldaa    PIA0PRA         ; turn off reset button light
        anda    #0xBF
        staa    PIA0PRA 
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
        jsr     BUTNLIT         ; turn off? button lights
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
        jsr     SERIALR     
        bcc     L80EB
        cmpa    #0x44           ; 'D'
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
        staa    0x0408          ; rts here for later CPU test
        jsr     (0xA1D5)
        jsr     (0xAB17)
        ldaa    (0xF7C0)        ; a 00
        staa    0x045C          ; ??? NVRAM
        jmp     RESET           ; reset!

LOCKUP: jmp     LOCKUP          ; infinite loop

; CPU test?
L811C:
        clr     (0x0079)
        clr     (0x007C)
        jsr     0x0408          ; rts should be here
        jsr     (0x8013)        ; rts is here '9'
        ldab    #0xFD
        jsr     (0x86E7)
        ldab    #0xDF
        jsr     L8748   
        jsr     L8791   
        jsr     (0x9AF7)
        jsr     (0x9C51)
        clr     (0x0062)
        jsr     (0x99D9)
        bcc     L8159           ; if carry clear, test is passed

        jsr     LCDMSG1 
        .ascis  'Invalid CPU!'

        ldaa    #0x53
        jmp     (0x82A4)
L8157:  bra     L8157           ; infinite loop

L8159:
        jsr     (0xA354)
        clr     (0x00AA)
        tst     (0x0000)
        beq     L8179

        jsr     LCDMSG1 
        .ascis  'RAM test failed!'

        bra     L81BD

L8179:
        jsr     LCDMSG1 
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
        jsr     LCDMSG2 
        .ascis  'ROM Chksum='

        jsr     (0x975F)        ; print the checksum on the LCD

        ldab    #0x02           ; delay 2 secs
        jsr     L8C02           ;

        jsr     (0x9A27)        ; display Serial #
        jsr     (0x9ECC)        ; display R and L counts?
        jsr     L9B19           ; do the random tasks???

        ldab    #0x02           ; delay 2 secs
        jsr     L8C02           ;

L81BD:
        ldab    SCCR2           ; disable receive data interrupts
        andb    #0xDF
        stab    SCCR2  

        jsr     (0x9AF7)        ; clear a bunch of ram
        ldab    #0xFD
        jsr     (0x86E7)
        jsr     L8791   

        ldab    #0x00           ; turn off button lights
        stab    (0x0062)
        jsr     BUTNLIT 

        jsr     LCDMSG1 
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

        jsr     LCDMSG2 
        .ascis  " Dave's system  "

        bra     L8267
L8220:
        cpd     #0x03E8
        blt     L8241
        cpd     #0x044B
        bhi     L8241

        jsr     LCDMSG2 
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
        jsr     L9B19   
        ldaa    (0x0060)
        beq     L8283
        jsr     (0xA97C)
        jmp     RESET       ; reset controller
L8283:
        ldaa    PIA0PRA 
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
        jsr     SERIALR     
        bcs     L82A4
L82A1:
        jmp     L8333
L82A4:
        cmpa    #0x44       ;'$'
        bne     L82AB
        jmp     LA366
L82AB:
        cmpa    #0x53       ;'S'
        bne     L82A1

        jsr     SERMSGW      
        .ascis  '\n\rEnter security code: '

        sei
        jsr     LA2EA
        cli
        bcs     L8331

        jsr     SERMSGW      
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
        jsr     BUTNLIT 
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
        jsr     BUTNLIT 
        ldab    #0x02           ; delay 2 secs
        jsr     L8C02           ;
        ldaa    (0x007C)
        beq     L839B
        ldaa    (0x007F)
        staa    (0x004E)
        ldab    (0x0081)
        jsr     L8748   
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
        staa    PIA0PRB 
        ldaa    PIA0PRA 
        oraa    #0x20
        staa    PIA0PRA 
        anda    #0xDF
        staa    PIA0PRA 
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
        jsr     L9B19   
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
        jsr     LCDMSG1 
        .ascis  '   Tape start   '

        ldab    (0x0062)
        orab    #0x80
        stab    (0x0062)
        jsr     BUTNLIT 
        ldab    #0xFB
        jsr     (0x86E7)

        jsr     LCDMSG1A
        .ascis  '68HC11 Proto'

        jsr     LCDMSG2A
        .ascis  'dbp'

        ldab    #0x03           ; delay 3 secs
        jsr     L8C02           ;
        tst     (0x007C)
        beq     L8430
        ldab    (0x0080)
        stab    (0x0062)
        jsr     BUTNLIT 
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
        jsr     L8748   
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
        jsr     L9B19   
        ldaa    PIA0PRA 
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
        jsr     BUTNLIT 
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
        jsr     L9B19   
        ldaa    PORTE
        anda    #0x10
        beq     L8614
        ldaa    PIA0PRA 
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
        jsr     BUTNLIT 
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
        jsr     L9B19   
        ldaa    PIA0PRA 
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
        jsr     BUTNLIT 
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
        jsr     BUTNLIT 
        ldab    #0xFD
        jsr     (0x86E7)
        ldab    #0x04           ; delay 4 secs
        jsr     L8C02           ;
        jmp     (0x847F)
L86A1:
        jmp     (0x844D)
        jsr     L9B19   
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
        jsr     L9B19   
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
        staa    PIA0PRB 
        jsr     L873A        ; clock diagnostic indicator
        ldaa    (0x007A)
        anda    #0x01
        staa    (0x007A)
        andb    #0xFE
        orab    (0x007A)
        stab    PIA0PRB 
        jsr     L8775   
        ldab    #0x32
        jsr     (0x8C22)
        ldab    #0xFE
        orab    (0x007A)
        stab    PIA0PRB 
        stab    (0x007A)
        jsr     L8775   
        ldaa    (0x00AC)
        oraa    #0x49
        staa    (0x00AC)
        staa    PIA0PRB 
        jsr     L873A        ; clock diagnostic indicator
        pula
        rts

; clock diagnostic indicator
L873A:
        ldaa    PIA0PRA 
        oraa    #0x20
        staa    PIA0PRA 
        anda    #0xDF
        staa    PIA0PRA 
        rts

L8748:
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
        staa    PIA0PRB 
        staa    (0x00AC)
        jsr     L873A           ; clock diagnostic indicator
        pulb
        stab    PIA0PRB 
        stab    (0x007B)
        jsr     L8783
        pula
        rts

L8775:
        ldaa    PIA0CRB 
        oraa    #0x38       ; bits 3-4-5 on
        staa    PIA0CRB 
        anda    #0xF7       ; bit 3 off
        staa    PIA0CRB 
        rts

L8783:
        ldaa    PIA0CRA 
        oraa    #0x38       ; bits 3-4-5 on
        staa    PIA0CRA 
        anda    #0xF7       ; bit 3 off
        staa    PIA0CRA 
        rts

L8791:
        ldaa    (0x007A)
        anda    #0xFE
        psha
        ldaa    (0x00AC)
        oraa    #0x04
        staa    (0x00AC)
        pula
L879D:
        staa    (0x007A)
        staa    PIA0PRB 
        jsr     L8775
        ldaa    (0x00AC)
        staa    PIA0PRB 
        jsr     L873A           ; clock diagnostic indicator
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
        staa    SCCCTRLB
        ldaa    0,X
        inx
        staa    SCCCTRLB
        bra     L87BF
L87D1:
        rts

; data table, sync data init
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

; SCC init, aux serial
L87E8:
        ldx     #0xF857
L87EB:
        ldaa    0,X
        cmpa    #0xFF
        beq     L87FD
        inx
        staa    SCCCTRLA
        ldaa    0,X
        inx
        staa    SCCCTRLA
        bra     L87EB
L87FD:
        bra     L8815

; data table for aux serial config
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
        staa    SCCCTRLA
        ldaa    SCCCTRLA
        anda    #0x70
        bne     L8869  
        ldaa    #0x0A
        staa    SCCCTRLA
        ldaa    SCCCTRLA
        anda    #0xC0
        bne     L8878  
        ldaa    SCCCTRLA
        lsra
        bcc     L8891  
        inc     (0x0048)
        ldaa    SCCDATAA
        jsr     SERIALW      
        staa    (0x004A)
        bra     L8896  
L8869:
        ldaa    SCCDATAA
        ldaa    #0x30
        staa    SCCCTRLA
        ldaa    #0x07
        jsr     SERIALW      
        clc
        rti

L8878:
        ldaa    #0x07
        jsr     SERIALW      
        ldaa    #0x0E
        staa    SCCCTRLA
        ldaa    #0x43
        staa    SCCCTRLA
        ldaa    SCCDATAA
        ldaa    #0x07
        jsr     SERIALW      
        sec
        rti

L8891:
        ldaa    SCCDATAA
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
        ldx     #0xF780         ; table at the end
        bra     L89A0  
L899D:
        ldx     #0xF7A0         ; table at the end
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
        bita    SCCCTRLB
        beq     L8A1B  
        ldaa    0,X     
        bne     L8A29       ; is it a nul?
        jmp     (0x8B21)    ; if so jump to exit
L8A29:
        inx
        cmpa    #0x5E       ; is is a caret? '^'
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
        staa    SCCDATAB
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
        bita    SCCCTRLB
        beq     L8B3C  
        pula
        staa    SCCDATAB
        rts

        jsr     (0xA32E)

        jsr     LCDMSG1 
        .ascis  'Light Diagnostic'

        jsr     LCDMSG2 
        .ascis  'Curtains opening'

        ldab    #0x14
        jsr     (0x8C30)
        ldab    #0xFF
        stab    (0x1098)
        stab    (0x109A)
        stab    (0x109C)
        stab    (0x109E)
        jsr     BUTNLIT 
        ldaa    PIA0PRA 
        oraa    #0x40
        staa    PIA0PRA 

        jsr     LCDMSG1 
        .ascis  ' Press ENTER to '

        jsr     LCDMSG2 
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
        jsr     BUTNLIT 
        bra     L8BF4  
        rts

; Delay B seconds
L8C02:
        psha
        ldaa    #0x64
        mul
        std     CDTIMR5     ; store B*100 here
L8C08:
        jsr     L9B19   
        ldd     CDTIMR5
        bne     L8C08  
        pula
        rts

        psha
        ldaa    #0x3C
L8C14:
        staa    (0x0028)
        ldab    #0x01       ; delay 1 sec
        jsr     L8C02       ;
        ldaa    (0x0028)
        deca
        bne     L8C14  
        pula
        rts

        psha
        clra
        std     CDTIMR5
L8C26:
        jsr     L9B19   
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
        ldd     #0x0500     ; Reset LCD queue?
        std     (0x0046)    ; write pointer
        std     (0x0044)    ; read pointer?
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
        staa    PORTG        ; LCD RS high
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

; 4 routines to write to the LCD display

; Write to the LCD 1st line - extend past the end of a normal display
LCDMSG1A:
        ldy     (0x0046)     ; get buffer pointer
        ldaa    #0x90        ; command to set LCD RAM ptr to chr 0x10
        bra     L8DE9  

; Write to the LCD 2st line - extend past the end of a normal display
LCDMSG2A:
        ldy     (0x0046)     ; get buffer pointer
        ldaa    #0xD0        ; command to set LCD RAM ptr to chr 0x50
        bra     L8DE9  

; Write to the LCD 2nd line
LCDMSG2:
        ldy     (0x0046)     ; get buffer pointer
        ldaa    #0xC0        ; command to set LCD RAM ptr to chr 0x40
        bra     L8DE9  

; Write to the LCD 1st line
LCDMSG1:
        ldy     (0x0046)     ; get buffer pointer
        ldaa    #0x80        ; command to load LCD RAM ptr to chr 0x00

; Put LCD command into a buffer, 4 bytes for each entry?
L8DE9:
        staa    0,Y         ; store command here
        clr     1,Y         ; clear next byte
        iny
        iny

; Add characters at return address to LCD buffer
        cpy     #0x0580       ; check for buffer overflow
        bcs     L8DFD  
        ldy     #0x0500
L8DFD:
        pulx                ; get start of data
        stx     (0x0017)    ; save this here
L8E00:
        ldaa    0,X         ; get character
        beq     L8E3A       ; is it 00, if so jump ahead
        bmi     L8E1D       ; high bit set, if so jump ahead
        clr     0,Y         ; add character
        staa    1,Y     
        inx
        iny
        iny
        cpy     #0x0580     ; check for buffer overflow
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

        ldaa    PIA0PRA 
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

        jsr     LCDMSG1 
        .ascis  'Chuck    '

        ldx     #0x9072
        bra     L8FE1  
L8F94:
        cmpa    #0x04
        bne     L8FA9  

        jsr     LCDMSG1 
        .ascis  'Jasper   '

        ldx     #0x90DE
        bra     L8FE1  
L8FA9:
        cmpa    #0x05
        bne     L8FBE  

        jsr     LCDMSG1 
        .ascis  'Pasqually'

        ldx     #0x9145
        bra     L8FE1  
L8FBE:
        cmpa    #0x06
        bne     L8FD3  

        jsr     LCDMSG1 
        .ascis  'Munch    '

        ldx     #0x91BA
        bra     L8FE1  
L8FD3:
        jsr     LCDMSG1 
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

        .ascis  'Mouth,Head left,Head right,Head up,Eyes right,Eyelids,Right hand,Eyes left,DS9,DS10,DS11,DS12,DS13,DS14,Exit'
        .ascis  'Mouth,Head left,Head right,Head up,Eyes right,Eyelids,Hands,Eyes left,DS9,DS10,DS11,DS12,DS13,DS14,Exit'
        .ascis  'Mouth-Mustache,Head left,Head right,Left arm,Eyes right,Eyelids,Right arm,Eyes left,DS9,DS10,DS11,DS12,DS13,DS14,Exit'
        .ascis  'Mouth,Head left,Head right,Left arm,Eyes right,Eyelids,Right arm,Eyes left,DS9,DS10,DS11,DS12,DS13,DS14,Exit'
        .ascis  'Mouth,Head left,Head right,Head up,Eyes right,Eyelids,Right hand,Eyes left,DS9,DS10,DS11,DS12,DS13,DS14,Exit'
        
; code again
        jsr     L86C4
L9295:
        ldab    #0x01
        jsr     (0x8C30)

        jsr     LCDMSG1 
        .ascis  '  Diagnostics   '

        jsr     LCDMSG2 
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
        jsr     BUTNLIT 
        ldaa    PIA0PRA 
        anda    #0xBF
        staa    PIA0PRA 
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

        jsr     LCDMSG1 
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
        jsr     BUTNLIT 
        ldaa    PIA0PRA 
        anda    #0xBF
        staa    PIA0PRA 
        jmp     (0x9292)
L9373:
        cmpa    #0x0D
        bne     L93A5  
        jsr     (0x8CE9)

        jsr     LCDMSG1 
        .ascis  '  Button  test'

        jsr     LCDMSG2 
        .ascis  '   PROG exits'

        jsr     (0xA526)
        clrb
        jsr     BUTNLIT 
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

        .ascis  "VCR adjust,Set Random,Chuck E. Cheese,Jasper,Pasqually,Munch,Helen,Reset System,Reset reg tape#,Reset liv tape#,View Tape #'s,All Lights On,Button test,King enable,Warm-Up,Show Type,Quit Diagnostics"
        .byte   0x00

        tst     (0x042A)
        beq     L94C6  

        jsr     LCDMSG1 
        .ascis  'King is Enabled'

        jsr     LCDMSG2 
        .ascis  'ENTER to disable'

        bra     L94EB  

L94C6:
        jsr     LCDMSG1 
        .ascis  'King is Disabled'

        jsr     LCDMSG2 
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

        jsr     LCDMSG1 
        .ascis  'Current: CNR   '

        bra     L95E5  

L95D3:
        jsr     LCDMSG1 
        .ascis  'Current: R12   '

L95E5:
        jsr     LCDMSG2 
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

        .ascis  "Chuck,Jasper,Pasqually,Munch,Helen,Light 1,Light 2,Light 3,Star EFX,Wink Spot,Gobo,Clear All Rnd,Exit"

; code again
        jsr     LCDMSG1 
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

        jsr     LCDMSG1 
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
        jsr     L8748   
        jmp     (0x85A4)
        clr     (0x0076)
        clr     (0x0075)
        clr     (0x0077)
        clr     (0x004E)
        ldab    (0x007B)
        orab    #0x0C
        jsr     L8748   
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
        jsr     L8748   
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
        jsr     L9B19   
        tst     (0x0031)
        bne     L9870  
        ldaa    (0x005A)
        beq     L9889  
L9870:
        clr     (0x0031)
        ldab    (0x0062)
        andb    #0xFE
        stab    (0x0062)
        jsr     BUTNLIT 
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
        jsr     BUTNLIT 
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
        jsr     BUTNLIT 
        jsr     (0xAA18)
        ldaa    #0x01
        staa    (0x004E)
        staa    (0x0075)
        ldab    (0x007B)
        andb    #0xDF
        jsr     L8748   
        jsr     (0x87AE)
        jsr     (0xA313)
        jsr     (0xAADB)
        bra     L9939  
L9909:
        ldab    (0x0062)
        andb    #0xF5
        orab    #0x40
        stab    (0x0062)
        jsr     BUTNLIT 
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
        jsr     L8748   
        jsr     L8791   
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
        jsr     BUTNLIT 
        jsr     (0xAA1D)
        clr     (0x005B)
        jsr     (0x87AE)
        ldab    (0x007B)
        orab    #0x20
        jsr     L8748   
        clr     (0x0075)
        clr     (0x0076)
        jmp     (0x9815)
        ldab    (0x007B)
        andb    #0xFB
        jsr     L8748   
        jmp     (0x85A4)
        ldab    (0x007B)
        orab    #0x04
        jsr     L8748   
        jmp     (0x85A4)
        ldab    (0x007B)
        andb    #0xF7
        jsr     L8748   
        jmp     (0x85A4)
        tst     (0x0077)
        bne     L999B  
        ldab    (0x007B)
        orab    #0x08
        jsr     L8748   
L999B:
        jmp     (0x85A4)
        ldab    (0x007B)
        andb    #0xF3
        jsr     L8748   
        rts

; main2
L99A6:
        ldab    (0x007B)
        andb    #0xDF        ; clear bit 5
        jsr     L8748
        jsr     L8791   
        rts

        ldab    (0x007B)
        orab    #0x20
        jsr     L8748   
        jsr     (0x87AE)
        rts

        ldab    (0x007B)
        andb    #0xDF
        jsr     L8748   
        jsr     (0x87AE)
        rts

        ldab    (0x007B)
        orab    #0x20
        jsr     L8748   
        jsr     L8791   
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

        jsr     LCDMSG1 
        .ascis  'Serial# '

        jsr     LCDMSG2 
        .ascis  '               '

; display 4-digit serial number
        ldab    #0x08
        ldy     #0x0E20
L9A4A:
        ldaa    0,Y     
        pshy
        pshb
        jsr     (0x8DB5)         ; display char here on LCD display
        pulb
        puly
        incb
        iny
        cpy     #0x0E24
        bne     L9A4A  
        rts

        ldaa    #0x01
        staa    (0x00B5)
        ldaa    (0x004E)
        staa    (0x007F)
        ldaa    (0x0062)
        staa    (0x0080)
        ldaa    (0x007B)
        staa    (0x0081)
        ldaa    (0x007A)
        staa    (0x0082)
        ldaa    (0x0078)
        staa    (0x007D)
        ldaa    (0x108A)
        anda    #0x06
        staa    (0x007E)
        ldab    #0xEF
        jsr     (0x86E7)
        ldab    (0x007B)
        orab    #0x0C
        andb    #0xDF
        jsr     L8748   
        jsr     L8791   
        jsr     L86C4
        jsr     (0x9C51)
        ldab    #0x06            ; delay 6 secs
        jsr     L8C02            ;
        jsr     (0x8E95)
        jsr     L99A6
        jmp     (0x81BD)
        clr     (0x005C)
        ldaa    #0x01
        staa    (0x0079)
        ldab    #0xFD
        jsr     (0x86E7)
        jsr     (0x8E95)
        ldd     #0x7530
        std     CDTIMR2
L9AB8:
        jsr     L9B19   
        ldab    (0x0062)
        eorb    #0x04
        stab    (0x0062)
        jsr     BUTNLIT 
        ldab    PIA0PRA 
        eorb    #0x08
        stab    PIA0PRA 
        tst     (0x005C)
        bne     L9AE3  
        jsr     (0x8E95)
        cmpa    #0x0D
        beq     L9AE3  
        ldab    #0x32
        jsr     (0x8C22)
        ldd     CDTIMR2
        beq     L9AE3  
        bra     L9AB8  
L9AE3:
        ldab    (0x0062)
        andb    #0xFB
        stab    (0x0062)
        jsr     BUTNLIT 
        jsr     (0xA354)
        ldab    #0xFB
        jsr     (0x86E7)
        jmp     (0x85A4)
        clr     (0x0075)
        clr     (0x0076)
        clr     (0x0077)
        clr     (0x0078)
        clr     (0x0025)
        clr     (0x0026)
        clr     (0x004E)
        clr     (0x0030)
        clr     (0x0031)
        clr     (0x0032)
        clr     (0x00AF)
        rts

; validate a bunch of ram locations against bytes in ROM???
L9B19:
        psha
        pshb
        ldaa    (0x004E)
        beq     L9B36       ; go to 0401 logic
        ldaa    (0x0063)
        bne     L9B33       ; exit
        tst     (0x0064)
        beq     L9B31       ; go to 0401 logic
        jsr     L86C4     ; do something with boards???
        jsr     (0x9C51)     ; RTC stuff???
        clr     (0x0064)
L9B31:
        bra     L9B36       ; go to 0401 logic
L9B33:
        pulb
        pula
        rts

; end up here immediately if:
; 0x004E == 00 or
; 0x0063, 0x0064 == 0 or
; 
; do subroutines based on bits 0-4 of 0x0401?
L9B36:
        ldaa    (0x0401)
        anda    #0x01
        beq     L9B40  
        jsr     (0x9B6B)     ; bit 0 routine
L9B40:
        ldaa    (0x0401)
        anda    #0x02
        beq     L9B4A  
        jsr     (0x9B99)     ; bit 1 routine
L9B4A:
        ldaa    (0x0401)
        anda    #0x04
        beq     L9B54  
        jsr     (0x9BC7)     ; bit 2 routine
L9B54:
        ldaa    (0x0401)
        anda    #0x08
        beq     L9B5E  
        jsr     (0x9BF5)     ; bit 3 routine
L9B5E:
        ldaa    (0x0401)
        anda    #0x10
        beq     L9B68  
        jsr     (0x9C23)     ; bit 4 routine
L9B68:
        pulb
        pula
        rts

; bit 0 routine
        pshy
        ldy     (0x0065)
        ldaa    0,Y     
        cmpa    #0xFF
        beq     L9B8B  
        cmpa    OFFCNT1
        bcs     L9B88  
        iny
        ldaa    0,Y     
        staa    (0x1080)
        iny
        sty     (0x0065)
L9B88:
        puly
        rts
L9B8B:
        ldy     #0xB2EB
        sty     (0x0065)
        ldaa    #0xFA
        staa    OFFCNT1
        jmp     (0x9B88)
        pshy
        ldy     (0x0067)
        ldaa    0,Y     
        cmpa    #0xFF
        beq     L9BB9  
        cmpa    OFFCNT2
        bcs     L9BB6  
        iny
        ldaa    0,Y     
        staa    (0x1084)
        iny
        sty     (0x0067)
L9BB6:
        puly
        rts

; bit 1 routine
L9BB9:
        ldy     #0xB3BD
        sty     (0x0067)
        ldaa    #0xE6
        staa    OFFCNT2
        jmp     (0x9BB6)

; bit 2 routine
        pshy
        ldy     (0x0069)
        ldaa    0,Y     
        cmpa    #0xFF
        beq     L9BE7  
        cmpa    OFFCNT3
        bcs     L9BE4  
        iny
        ldaa    0,Y     
        staa    (0x1088)
        iny
        sty     (0x0069)
L9BE4:
        puly
        rts
L9BE7:
        ldy     #0xB531
        sty     (0x0069)
        ldaa    #0xD2
        staa    OFFCNT3
        jmp     (0x9BE4)

; bit 3 routine
        pshy
        ldy     (0x006B)
        ldaa    0,Y     
        cmpa    #0xFF
        beq     L9C15  
        cmpa    OFFCNT4
        bcs     L9C12  
        iny
        ldaa    0,Y     
        staa    (0x108C)
        iny
        sty     (0x006B)
L9C12:
        puly
        rts
L9C15:
        ldy     #0xB475
        sty     (0x006B)
        ldaa    #0xBE
        staa    OFFCNT4
        jmp     (0x9C12)

; bit 4 routine
        pshy
        ldy     (0x006D)
        ldaa    0,Y     
        cmpa    #0xFF
        beq     L9C43  
        cmpa    OFFCNT5
        bcs     L9C40  
        iny
        ldaa    0,Y     
        staa    (0x1090)
        iny
        sty     (0x006D)
L9C40:
        puly
        rts
L9C43:
        ldy     #0xB5C3
        sty     (0x006D)
        ldaa    #0xAA
        staa    OFFCNT5
        jmp     (0x9C40)

; Reset offset counters to initial values
        ldaa    #0xFA
        staa    OFFCNT1
        ldaa    #0xE6
        staa    OFFCNT2
        ldaa    #0xD2
        staa    OFFCNT3
        ldaa    #0xBE
        staa    OFFCNT4
        ldaa    #0xAA
        staa    OFFCNT5

        ldy     #0xB2EB
        sty     (0x0065)
        ldy     #0xB3BD
        sty     (0x0067)
        ldy     #0xB531
        sty     (0x0069)
        ldy     #0xB475
        sty     (0x006B)
        ldy     #0xB5C3
        sty     (0x006D)

        clr     (0x109C)
        clr     (0x109E)

        ldaa    (0x0401)
        anda    #0x20
        beq     L9C9D  
        ldaa    (0x109C)
        oraa    #0x19
        staa    (0x109C)
L9C9D:
        ldaa    (0x0401)
        anda    #0x40
        beq     L9CB4  
        ldaa    (0x109C)
        oraa    #0x44
        staa    (0x109C)
        ldaa    (0x109E)
        oraa    #0x40
        staa    (0x109E)
L9CB4:
        ldaa    (0x0401)
        anda    #0x80
        beq     L9CC3  
        ldaa    (0x109C)
        oraa    #0xA2
        staa    (0x109C)
L9CC3:
        ldaa    (0x042B)
        anda    #0x01
        beq     L9CD2  
        ldaa    (0x109A)
        oraa    #0x80
        staa    (0x109A)
L9CD2:
        ldaa    (0x042B)
        anda    #0x02
        beq     L9CE1  
        ldaa    (0x109E)
        oraa    #0x04
        staa    (0x109E)
L9CE1:
        ldaa    (0x042B)
        anda    #0x04
        beq     L9CF0  
        ldaa    (0x109E)
        oraa    #0x08
        staa    (0x109E)
L9CF0:
        rts

        jsr     LCDMSG1 
        .ascis  '   Program by   '

        jsr     LCDMSG2 
        .ascis  'David  Philipsen'

        rts

        staa    (0x0049)
        clr     (0x00B8)
        jsr     (0x8D03)
        ldaa    #0x2A            ;'*'
        ldab    #0x28
        jsr     (0x8DB5)         ; display char here on LCD display
        ldd     #0x0BB8
        std     CDTIMR1
L9D2C:
        jsr     L9B19   
        ldaa    (0x0049)
        cmpa    #0x41
        beq     L9D39  
        cmpa    #0x4B
        bne     L9D3D  
L9D39:
        ldab    #0x01
        stab    (0x00B8)
L9D3D:
        cmpa    #0x41
        beq     L9D45  
        cmpa    #0x4F
        bne     L9D4C  
L9D45:
        ldaa    #0x01
        staa    (0x0298)
        bra     L9D7E  
L9D4C:
        cmpa    #0x4B
        beq     L9D54  
        cmpa    #0x50
        bne     L9D5B  
L9D54:
        ldaa    #0x02
        staa    (0x0298)
        bra     L9D7E  
L9D5B:
        cmpa    #0x4C
        bne     L9D66  
        ldaa    #0x03
        staa    (0x0298)
        bra     L9D7E  
L9D66:
        cmpa    #0x52
        bne     L9D71  
        ldaa    #0x04
        staa    (0x0298)
        bra     L9D7E  
L9D71:
        ldd     CDTIMR1
        bne     L9D2C  
        ldaa    #0x23            ;'#'
        ldab    #0x29
        jsr     (0x8DB5)         ; display char here on LCD display
        bra     L9DEA  
L9D7E:
        clr     (0x0049)
        ldaa    #0x2A            ;'*'
        ldab    #0x29
        jsr     (0x8DB5)         ; display char here on LCD display
        clr     (0x004A)
        ldx     #0x0299
L9D8E:
        jsr     L9B19   
        ldaa    (0x004A)
        beq     L9D8E  
        clr     (0x004A)
        anda    #0x3F
        staa    0,X     
        inx
        cpx     #0x029C
        bne     L9D8E  
        jsr     (0x9DF5)
        bcc     L9DB0  
        ldaa    #0x23            ;'#'
        ldab    #0x2A
        jsr     (0x8DB5)         ; display char here on LCD display
        bra     L9DEA  
L9DB0:
        ldaa    #0x2A            ;'*'
        ldab    #0x2A
        jsr     (0x8DB5)         ; display char here on LCD display
        ldaa    (0x0299)
        cmpa    #0x39
        bne     L9DD3  

        jsr     LCDMSG2 
        .ascis  'Generic Showtape'

        clc
        rts

L9DD3:
        ldaa    (0x0298)
        cmpa    #0x03
        beq     L9DE8  
        cmpa    #0x04
        beq     L9DE8  
        ldaa    (0x0076)
        bne     L9DE8  
        jsr     (0x9E73)
        jsr     (0x9ECC)
L9DE8:
        clc
        rts

L9DEA:
        ldd     (0x0420)
        addd    #0x0001
        std     (0x0420)
        sec
        rts

        ldaa    (0x0299)
        cmpa    #0x39
        beq     L9E68  
        ldx     #0x00A8
L9DFF:
        jsr     L9B19   
        ldaa    (0x004A)
        beq     L9DFF  
        clr     (0x004A)
        staa    0,X     
        inx
        cpx     #0x00AA
        bne     L9DFF  
        jsr     (0x9EFA)
        ldx     #0x0299
        clr     (0x0013)
L9E1A:
        ldaa    0,X     
        adda    (0x0013)
        staa    (0x0013)
        inx
        cpx     #0x029C
        bne     L9E1A  
        cmpa    (0x00A8)
        bne     L9E71  
        ldx     #0x0402
        ldaa    (0x0298)
        cmpa    #0x02
        bne     L9E37  
        ldx     #0x0405
L9E37:
        pshx
        jsr     (0xAB56)
        pulx
        bcs     L9E45  
        ldaa    #0x03
        staa    (0x0298)
        bra     L9E68  
L9E45:
        ldaa    (0x0299)
        cmpa    0,X     
        bcs     L9E6A  
        beq     L9E50  
        bcc     L9E68  
L9E50:
        inx
        ldaa    (0x029A)
        cmpa    0,X     
        bcs     L9E6A  
        beq     L9E5C  
        bcc     L9E68  
L9E5C:
        inx
        ldaa    (0x029B)
        cmpa    0,X     
        bcs     L9E6A  
        beq     L9E68  
        bcc     L9E68  
L9E68:
        clc
        rts

L9E6A:
        ldaa    (0x0298)
        cmpa    #0x03
        beq     L9E68  
L9E71:
        sec
        rts

        ldx     #0x0402
        ldaa    (0x0298)
        cmpa    #0x02
        bne     L9E80  
        ldx     #0x0405
L9E80:
        ldaa    (0x0299)
        staa    0,X     
        inx
        ldaa    (0x029A)
        staa    0,X     
        inx
        ldaa    (0x029B)
        staa    0,X     
        rts

; reset R counts
        ldaa    #0x30        
        staa    (0x0402)
        staa    (0x0403)
        staa    (0x0404)

        jsr     LCDMSG2 
        .ascis  'Reg # cleared!'

        rts

; reset L counts
        ldaa    #0x30
        staa    (0x0405)
        staa    (0x0406)
        staa    (0x0407)

        jsr     LCDMSG2 
        .ascis  'Liv # cleared!'

        rts

; display R and L counts?
        ldaa    #0x52            ;'R'
        ldab    #0x2B
        jsr     (0x8DB5)         ; display char here on LCD display
        ldaa    #0x4C            ;'L'
        ldab    #0x32
        jsr     (0x8DB5)         ; display char here on LCD display
        ldx     #0x0402
        ldab    #0x2C
L9EDF:
        ldaa    0,X     
        jsr     (0x8DB5)         ; display 3 chars here on LCD display
        incb
        inx
        cpx     #0x0405
        bne     L9EDF  
        ldab    #0x33
L9EED:
        ldaa    0,X     
        jsr     (0x8DB5)         ; display 3 chars here on LCD display
        incb
        inx
        cpx     #0x0408
        bne     L9EED  
        rts

        ldaa    (0x00A8)
        jsr     (0x9F0F)
        asla
        asla
        asla
        asla
        staa    (0x0013)
        ldaa    (0x00A9)
        jsr     (0x9F0F)
        adda    (0x0013)
        staa    (0x00A8)
        rts

        cmpa    #0x2F
        bcc     L9F15  
        ldaa    #0x30
L9F15:
        cmpa    #0x3A
        bcs     L9F1B  
        suba    #0x07
L9F1B:
        suba    #0x30
        rts

        ldd     (0x029C)
        cpd     #0x0001
        beq     L9F33  
        cpd     #0x03E8
        bcs     L9F4D  
        cpd     #0x044B
        bhi     L9F4D  

L9F33:
        jsr     LCDMSG1 
        .ascis  'Password bypass '

        ldab    #0x04
        jsr     (0x8C30)
        clc
        rts

L9F4D:
        jsr     (0x8CF2)
        jsr     (0x8D03)

        jsr     LCDMSG1 
        .ascis  'Code:'

        ldx     #0x0290
        clr     (0x0016)
L9F61:
        ldaa    #0x41
L9F63:
        staa    (0x0015)
        jsr     (0x8E95)
        cmpa    #0x0D
        bne     L9F7D  
        ldaa    (0x0015)
        staa    0,X     
        inx
        jsr     (0x8C98)
        ldaa    (0x0016)
        inca
        staa    (0x0016)
        cmpa    #0x05
        beq     L9F86  
L9F7D:
        ldaa    (0x0015)
        inca
        cmpa    #0x5B
        beq     L9F61  
        bra     L9F63  

L9F86:
        jsr     LCDMSG2 
        .ascis  'Pswd:'

        ldx     #0x0288
        ldaa    #0x41
        staa    (0x0016)
        ldaa    #0xC5
        staa    (0x0015)
L9F99:
        ldaa    (0x0015)
        jsr     (0x8C86)     ; write byte to LCD
        ldaa    (0x0016)
        jsr     (0x8C98)
L9FA3:
        jsr     (0x8E95)
        beq     L9FA3  
        cmpa    #0x0D
        bne     L9FBC  
        ldaa    (0x0016)
        staa    0,X     
        inx
        ldaa    (0x0015)
        inca
        staa    (0x0015)
        cmpa    #0xCA
        beq     L9FE2  
        bra     L9F99  
L9FBC:
        cmpa    #0x01
        bne     L9FCF  
        ldaa    (0x0016)
        inca
        staa    (0x0016)
        cmpa    #0x5B
        bne     L9F99  
        ldaa    #0x41
        staa    (0x0016)
        bra     L9F99  
L9FCF:
        cmpa    #0x02
        bne     L9FA3  
        ldaa    (0x0016)
        deca
        staa    (0x0016)
        cmpa    #0x40
        bne     L9F99  
        ldaa    #0x5A
        staa    (0x0016)
        bra     L9F99  
L9FE2:
        jsr     (0xA001)
        bcs     L9FF6  
        ldaa    #0xDB
        staa    (0x00AB)
        ldd     (0x0416)
        addd    #0x0001
        std     (0x0416)
        clc
        rts

L9FF6:
        ldd     (0x0414)
        addd    #0x0001
        std     (0x0414)
        sec
        rts

        ldaa    (0x0290)
        staa    (0x0281)
        ldaa    (0x0291)
        staa    (0x0283)
        ldaa    (0x0292)
        staa    (0x0284)
        ldaa    (0x0293)
        staa    (0x0280)
        ldaa    (0x0294)
        staa    (0x0282)
        ldaa    (0x0280)
        eora    #0x13
        adda    #0x03
        staa    (0x0280)
        ldaa    (0x0281)
        eora    #0x04
        adda    #0x12
        staa    (0x0281)
        ldaa    (0x0282)
        eora    #0x06
        adda    #0x04
        staa    (0x0282)
        ldaa    (0x0283)
        eora    #0x11
        adda    #0x07
        staa    (0x0283)
        ldaa    (0x0284)
        eora    #0x01
        adda    #0x10
        staa    (0x0284)
        jsr     (0xA0AF)
        ldaa    (0x0294)
        anda    #0x17
        staa    (0x0015)
        ldaa    (0x0290)
        anda    #0x17
        staa    (0x0016)
        ldx     #0x0280
LA065:
        ldaa    0,X     
        eora    (0x0015)
        eora    (0x0016)
        staa    0,X     
        inx
        cpx     #0x0285
        bne     LA065  
        jsr     (0xA0AF)
        ldx     #0x0280
        ldy     #0x0288
LA07D:
        ldaa    0,X     
        cmpa    0,Y     
        bne     LA08E  
        inx
        iny
        cpx     #0x0285
        bne     LA07D  
        clc
        rts

LA08E:
        sec
        rts

LA090:
        .ascii  'YADDA'

        ldx     #0x0288
        ldy     #LA090
LA09C:
        ldaa    0,X
        cmpa    0,Y
        bne     LA0AD
        inx
        iny
        cpx     #0x028D
        bne     LA09C
        clc
        rts
LA0AD:
        sec
        rts

        ldx     #0x0280
LA0B2:
        ldaa    0,X     
        cmpa    #0x5B
        bcs     LA0BE  
        suba    #0x1A
        staa    0,X     
        bra     LA0C6  
LA0BE:
        cmpa    #0x41
        bcc     LA0C6  
        adda    #0x1A
        staa    0,X     
LA0C6:
        inx
        cpx     #0x0285
        bne     LA0B2  
        rts

        jsr     (0x8CF2)

        jsr     LCDMSG2 
        .ascis  'Failed!         '

        ldab    #0x02
        jsr     (0x8C30)
        rts

        ldab    #0x01
        jsr     (0x8C30)
        clr     (0x004E)
        ldab    #0xD3
        jsr     L8748   
        jsr     (0x87AE)
        jsr     (0x8CE9)

        jsr     LCDMSG1 
        .ascis  '   VCR adjust'

        jsr     LCDMSG2 
        .ascis  'UP to clear bits'

        clrb
        stab    (0x0062)
        jsr     BUTNLIT 
        ldaa    PIA0PRA 
        anda    #0xBF
        staa    PIA0PRA 
        jsr     (0x8E95)
        clr     (0x0048)
        clr     (0x0049)
        jsr     L86C4
        ldaa    #0x28
        staa    (0x0063)
        ldab    #0xFD
        jsr     (0x86E7)
        jsr     (0xA32E)
        inc     (0x0076)
        clr     (0x0032)
LA14B:
        jsr     (0x8E95)
        cmpa    #0x0D
        bne     LA155  
        jmp     (0xA1C4)
LA155:
        ldaa    #0x28
        staa    (0x0063)
        jsr     (0x86A4)
        bcs     LA14B  
        ldd     (0x041A)
        addd    #0x0001
        std     (0x041A)
        jsr     L86C4
        inc     (0x004E)
        ldab    #0xD3
        jsr     L8748   
        jsr     (0x87AE)
        ldaa    (0x0049)
        cmpa    #0x43
        bne     LA181  
        clr     (0x0049)
        clr     (0x0048)
LA181:
        ldaa    (0x0048)
        cmpa    #0xC8
        bcs     LA1A6  
        ldd     (0x029C)
        cpd     #0x0001
        beq     LA1A6  
        ldab    #0xEF
        jsr     (0x86E7)
        jsr     L86C4
        clr     (0x004E)
        clr     (0x0076)
        ldab    #0x0A
        jsr     (0x8C30)
        jmp     (0x81D7)
LA1A6:
        jsr     (0x8E95)
        cmpa    #0x01
        bne     LA1BD  
        ldx     #0x1080
        ldaa    #0x34
LA1B2:
        clr     0,X     
        staa    1,X     
        inx
        inx
        cpx     #0x10A0
        bcs     LA1B2  
LA1BD:
        cmpa    #0x0D
        beq     LA1C4  
        jmp     (0xA175)
LA1C4:
        clr     (0x0076)
        clr     (0x004E)
        ldab    #0xDF
        jsr     L8748   
        jsr     L8791   
        jmp     (0x81D7)
        ldaa    #0x07
        staa    (0x0400)
        ldd     #0x0E09
        cmpa    #0x65
        bne     LA1E6  
        cmpb    #0x63
        bne     LA1E6  
        rts

LA1E6:
        ldaa    #0x0E
        staa    PPROG  
        ldaa    #0xFF
        staa    (0x0E00)
        ldaa    PPROG  
        oraa    #0x01
        staa    PPROG  
        ldx     #0x1B58
LA1FB:
        dex
        bne     LA1FB  
        ldaa    PPROG  
        anda    #0xFE
        staa    PPROG  
        ldx     #0x0E00
        ldy     #0xA226
LA20D:
        ldab    #0x02
        stab    PPROG  
        ldaa    0,Y     
        iny
        staa    0,X     
        jsr     (0xA232)
        inx
        cpx     #0x0E0C
        bne     LA20D  
        clr     PPROG  
        rts

; data
        .ascii  ')d*!2::4!ecq'

; program EEPROM
        pshy
        ldab    #0x03
        stab    PPROG       ; start program
        ldy     #0x1B58
LA23D:
        dey
        bne     LA23D  
        ldab    #0x02
        stab    PPROG       ; stop program
        puly
        rts

        sei
        ldx     #0x0010
LA24D:
        clr     0,X     
        inx
        cpx     #0x0E00
        bne     LA24D  
        jsr     (0x9EAF)     ; reset L counts
        jsr     (0x9E92)     ; reset R counts
        jmp     RESET     ; reset controller

; Compute and store copyright checksum
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
        sei
        clr     ERASEFLG     ; Reset EEPROM Erase flag
        ldaa    #0x0E
        staa    PPROG       ; ERASE mode!
        ldaa    #0xFF
        staa    (0x0E20)    ; save in NVRAM
        ldaa    PPROG  
        oraa    #0x01
        staa    PPROG       ; do the ERASE
        ldx     #0x1B58       ; delay a bit
LA28E:
        dex
        bne     LA28E  
        ldaa    PPROG  
        anda    #0xFE        ; stop erasing
        clr     PPROG  

        jsr     SERMSGW           ; display "enter serial number"
        .ascis  'Enter serial #: '

        ldx     #0x0E20
LA2AF:
        jsr     SERIALR     ; wait for serial data
        bcc     LA2AF  

        jsr     SERIALW     ; read serial data
        ldab    #0x02
        stab    PPROG       ; protect only 0x0e20-0x0e5f
        staa    0,X         
        jsr     (0xA232)     ; program byte
        inx
        cpx     #0x0E24
        bne     LA2AF  
        ldab    #0x02
        stab    PPROG  
        ldaa    #0xDB        ; it's official
        staa    (0x0E24)
        jsr     (0xA232)     ; program byte
        clr     PPROG  
        ldaa    #0x1E
        staa    BPROT       ; protect all but 0x0e00-0x0e1f
        jmp     RESET     ; reset controller

        pulx
        pshx
        cpx     #0x8000
        bcs     LA2E8  
        clc
        rts

LA2E8:
        sec
        rts

; enter and validate security code
LA2EA:
        ldx     #0x0288
        ldab    #0x03       ; 3 character code

LA2EF:
        jsr     SERIALR     ; check if available
        bcc     LA2EF  
        staa    0,X     
        inx
        decb
        bne     LA2EF  

        ldaa    (0x0288)
        cmpa    #0x13        ; 0x13
        bne     LA311  
        ldaa    (0x0289)
        cmpa    #0x10        ; 0x10
        bne     LA311  
        ldaa    (0x028A)
        cmpa    #0x14        ; 0x14
        bne     LA311  
        clc
        rts

LA311:
        sec
        rts

        psha
        ldaa    (0x1092)
        oraa    #0x01
LA319:
        staa    (0x1092)
        pula
        rts

        psha
        ldaa    (0x1092)
        anda    #0xFE
        bra     LA319  
        ldaa    (0x004E)
        staa    (0x0019)
        clr     (0x004E)
        rts

        ldaa    (0x1086)
        oraa    #0x15
        staa    (0x1086)
        ldab    #0x01
        jsr     (0x8C30)
        anda    #0xEA
        staa    (0x1086)
        rts

        ldaa    (0x1086)
        oraa    #0x2A
        staa    (0x1086)
        ldab    #0x01
        jsr     (0x8C30)
        anda    #0xD5
        staa    (0x1086)
        rts

        ldab    PIA0PRA 
        orab    #0x08
        stab    PIA0PRA 
        rts

        ldab    PIA0PRA 
        andb    #0xF7
        stab    PIA0PRA 
        rts

;'$' command goes here?
LA366:
        clr     (0x004E)
        jsr     L86C4
        clr     (0x042A)

        jsr     SERMSGW      
        .ascis  'Enter security code:' 

        jsr     LA2EA
        bcc     LA38E  
        jmp     (0x8331)

LA38E:
        jsr     SERMSGW      
        .ascii  "\f\n\rDave's Setup Utility\n\r"
        .ascii  '<K>ing enable\n\r'
        .ascii  '<C>lear random\n\r'
        .ascii  '<5> character random\n\r'
        .ascii  '<L>ive tape number clear\n\r'
        .ascii  '<R>egular tape number clear\n\r'
        .ascii  '<T>est driver boards\n\r'
        .ascii  '<B>ub test\n\r'
        .ascii  '<D>eck test (with tape inserted)\n\r'
        .ascii  '<7>5% adjustment\n\r'
        .ascii  '<S>how re-valid tapes\n\r'
        .ascis  '<J>ump to system\n\r'

LA495:
        jsr     SERIALR     
        bcc     LA495  
        cmpa    #0x43        ;'C'
        bne     LA4A7  
        clr     (0x0401)     ;clear random
        clr     (0x042B)
        jmp     (0xA514)
LA4A7:
        cmpa    #0x35        ;'5'
        bne     LA4B8  
        ldaa    (0x0401)    ;5 character random
        anda    #0x7F
        oraa    #0x7F
        staa    (0x0401)
        jmp     (0xA514)
LA4B8:
        cmpa    #0x4C        ;'L'
        bne     LA4C2  
        jsr     (0x9EAF)     ; reset Liv counts
        jmp     (0xA514)
LA4C2:
        cmpa    #0x52        ;'R'
        bne     LA4CC  
        jsr     (0x9E92)     ; reset Reg counts
        jmp     (0xA514)
LA4CC:
        cmpa    #0x54        ;'T'
        bne     LA4D6  
        jsr     (0xA565)     ;test driver boards
        jmp     (0xA514)
LA4D6:
        cmpa    #0x42        ;'B'
        bne     LA4E0  
        jsr     (0xA526)     ;bulb test?
        jmp     (0xA514)
LA4E0:
        cmpa    #0x44        ;'D'
        bne     LA4EA  
        jsr     (0xA53C)     ;deck test
        jmp     (0xA514)
LA4EA:
        cmpa    #0x37        ;'7'
        bne     LA4F6  
        ldab    #0xFB
        jsr     (0x86E7)     ;5% adjustment
        jmp     (0xA514)
LA4F6:
        cmpa    #0x4A        ;'J'
        bne     LA4FD  
        jmp     RESET     ;jump to system (reset)
LA4FD:
        cmpa    #0x4B        ;'K'
        bne     LA507  
        inc     (0x042A)     ;King enable
        jmp     (0xA514)
LA507:
        cmpa    #0x53        ;'S'
        bne     LA511  
        jsr     (0xAB7C)     ;show re-valid tapes
        jmp     (0xA514)
LA511:
        jmp     (0xA495)
        ldaa    #0x07
        jsr     SERIALW      
        ldab    #0x01
        jsr     (0x8C30)
        ldaa    #0x07
        jsr     SERIALW      
        jmp     (0xA38E)

; bulb test
        clrb
        jsr     BUTNLIT 
LA52A:
        ldab    PORTE
        eorb    #0xFF
        jsr     BUTNLIT 
        cmpb    #0x80
        bne     LA52A  
        ldab    #0x02
        jsr     (0x8C30)
        rts

; deck test
        ldab    #0xFD
        jsr     (0x86E7)
        ldab    #0x06
        jsr     (0x8C30)
        ldab    #0xFB
        jsr     (0x86E7)
        ldab    #0x06
        jsr     (0x8C30)
        ldab    #0xFD
        jsr     (0x86E7)
        ldab    #0xF7
        jsr     (0x86E7)
        ldab    #0x06
        jsr     (0x8C30)
        ldab    #0xEF
        jsr     (0x86E7)
        rts

; test driver boards
        jsr     SERIALR     
        bcc     LA572  
        cmpa    #0x1B
        bne     LA572  
        jsr     L86C4
        rts
LA572:
        ldaa    #0x08
        staa    (0x0015)
        jsr     L86C4
        ldaa    #0x01
LA57B:
        psha
        tab
        jsr     BUTNLIT 
        ldaa    PIA0PRA 
        eora    #0x08
        staa    PIA0PRA 
        pula
        staa    (0x1080)
        staa    (0x1084)
        staa    (0x1088)
        staa    (0x108C)
        staa    (0x1090)
        staa    (0x1094)
        staa    (0x1098)
        staa    (0x109C)
        ldab    #0x14
        jsr     (0xA652)
        rola
        psha
        ldab    (0x0015)
        decb
        stab    (0x0015)
        jsr     DIAGDGT          ; write digit to the diag display
        pshb
        ldab    #0x27
        ldaa    (0x0015)
        clc
        adca    #0x30
        jsr     (0x8DB5)         ; display char here on LCD display
        pulb
        pula
        tstb
        bne     LA57B  
        ldaa    #0x08
        staa    (0x0015)
        jsr     L86C4
        ldaa    #0x01
LA5C9:
        staa    (0x1082)
        staa    (0x1086)
        staa    (0x108A)
        staa    (0x108E)
        staa    (0x1092)
        staa    (0x1096)
        staa    (0x109A)
        staa    (0x109E)
        ldab    #0x14
        jsr     (0xA652)
        rola
        psha
        ldab    (0x0015)
        decb
        stab    (0x0015)
        jsr     DIAGDGT           ; write digit to the diag display
        pshb
        ldab    #0x27
        ldaa    (0x0015)
        clc
        adca    #0x30
        jsr     (0x8DB5)         ; display char here on LCD display
        pulb
        pula
        tst     (0x0015)
        bne     LA5C9  
        jsr     L86C4
        ldx     #0x1080
        ldab    #0x00
LA60A:
        ldaa    #0xFF
        staa    0,X     
        staa    2,X     
        pshb
        ldab    #0x1E
        jsr     (0xA652)
        pulb
        ldaa    #0x00
        staa    0,X     
        staa    2,X     
        incb
        pshx
        jsr     DIAGDGT               ; write digit to the diag display
        pshb
        ldab    #0x27
        pula
        psha
        clc
        adca    #0x30
        jsr     (0x8DB5)         ; display char here on LCD display
        pulb
        pulx
        inx
        inx
        inx
        inx
        cpx     #0x109D
        bcs     LA60A  
        ldx     #0x1080
LA63B:
        ldaa    #0xFF
        staa    0,X     
        staa    2,X     
        inx
        inx
        inx
        inx
        cpx     #0x109D
        bcs     LA63B  
        ldab    #0x06
        jsr     (0x8C30)
        jmp     (0xA565)
        psha
        clra
        std     CDTIMR5
LA656:
        tst     CDTIMR5+1
        bne     LA656  
        pula
        rts

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

        jsr     LCDMSG1 
        .ascis  '    Warm-Up  '

        jsr     LCDMSG2 
        .ascis  'Curtains opening'

        ldab    #0x14
        jsr     (0x8C30)
        jsr     (0xA855)
        ldab    #0x02
        jsr     (0x8C30)
        ldx     #LA65D
        ldab    #0x05
        stab    (0x0012)
        ldab    #0x08
        stab    (0x0013)
        jsr     (0xA941)
        jsr     (0xA94C)
        ldab    #0x02
        jsr     (0x8C30)
LA8B3:
        jsr     (0xA95E)
        ldaa    0,X     
        suba    #0x30
        inx
        inx
        psha
        inc     (0x004C)
        pshx
        jsr     (0x88E5)
        pulx
        ldaa    #0x4F            ;'O'
        ldab    #0x0C
        jsr     (0x8DB5)         ; display char here on LCD display
        ldaa    #0x6E            ;'n'
        ldab    #0x0D
        jsr     (0x8DB5)         ; display char here on LCD display
        ldd     #0x200E           ;' '
        jsr     (0x8DB5)         ; display char here on LCD display
        dec     (0x004C)
        pula
        psha
        ldab    #0x64
        mul
        std     CDTIMR5
LA8E3:
        ldd     CDTIMR5
        bne     LA8E3  
        jsr     (0x8E95)
        cmpa    #0x0D
        bne     LA8F3  
        jsr     (0xA975)
        bra     LA903  
LA8F3:
        cmpa    #0x01
        bne     LA8FB  
        pula
        jmp     (0xA895)
LA8FB:
        cmpa    #0x02
        bne     LA903  
        pula
        jmp     (0xA935)
LA903:
        pshx
        jsr     (0x88E5)
        pulx
        ldaa    #0x66            ;'f'
        ldab    #0x0D
        jsr     (0x8DB5)         ; display char here on LCD display
        ldaa    #0x66            ;'f'
        ldab    #0x0E
        jsr     (0x8DB5)         ; display char here on LCD display
        pula
        ldab    #0x64
        mul
        std     CDTIMR5
LA91C:
        ldd     CDTIMR5
        bne     LA91C  
        jsr     (0xA855)
        inc     (0x004B)
        ldaa    (0x004B)
        cmpa    #0x48
        bcs     LA8B3  
        ldaa    (0x004C)
        cmpa    #0x34
        beq     LA935  
        jmp     (0xA8A4)
LA935:
        ldab    #0x02
        jsr     (0x8C30)
        jsr     L86C4
        jsr     (0xA341)
        rts

        ldaa    0,X     
        inx
        inx
        staa    (0x004C)
        ldaa    #0x40
        staa    (0x004B)
        rts

        jsr     (0x8CF2)
LA94F:
        ldaa    0,X     
        inx
        cmpa    #0x2C
        beq     LA95D  
        psha
        jsr     (0x8E70)
        pula
        bra     LA94F  
LA95D:
        rts

        jsr     (0x8D03)
        ldaa    #0xC0
        jsr     (0x8E4B)
LA966:
        ldaa    0,X     
        inx
        cmpa    #0x2C
        beq     LA974  
        psha
        jsr     (0x8E70)
        pula
        bra     LA966  
LA974:
        rts

LA975:
        jsr     (0x8E95)
        tsta
        beq     LA975  
        rts

        clr     (0x0060)
        ldd     (0x029C)
        cpd     #0x0001
        beq     LA994  
        cpd     #0x03E8
        blt     LAA0B  
        cpd     #0x044B
        bhi     LAA0B  
LA994:
        ldab    #0x40
        stab    (0x0062)
        jsr     BUTNLIT 
        ldab    #0x64
        jsr     (0x8C22)
        jsr     L86C4
        jsr     (0x8CE9)

        jsr     LCDMSG1 
        .ascis  '     STUDIO'

        jsr     LCDMSG2 
        .ascis  'programming mode'

        jsr     (0xA32E)
        jsr     (0x999E)
        jsr     (0x99B1)
        ldx     #0x2000
LA9D3:
        ldy     #0x00C0
LA9D7:
        dey
        bne     LA9E5  
        jsr     (0xA9F4)
        ldaa    (0x0060)
        bne     LAA0B  
        ldx     #0x2000
LA9E5:
        ldaa    (0x10A8)
        anda    #0x01
        beq     LA9D7  
        ldaa    (0x10A9)
        staa    0,X     
        inx
        bra     LA9D3  
        ldx     #0x2000
        ldy     #0x1080
LA9FB:
        ldaa    0,X     
        staa    0,Y     
        inx
        iny
        iny
        cpx     #0x2010
        bcs     LA9FB  
        rts
LAA0B:
        rts
        ldd     #0x4837           ;'H'
LAA0F:
        jsr     (0x8DB5)         ; display char here on LCD display
        rts
        ldd     #0x2037           ;' '
        bra     LAA0F  
        ldd     #0x420F           ;'B'
        bra     LAA0F  
        ldd     #0x200F           ;' '
        bra     LAA0F  
        clr     (0x004F)
        ldd     #0x0001
        std     CDTIMR1
        ldx     #0x2000
LAA2D:
        ldaa    (0x10A8)
        anda    #0x01
        beq     LAA2D  
        ldd     CDTIMR1
        sei
        bne     LAA3C  
        ldx     #0x2000
LAA3C:
        ldaa    (0x10A9)
        staa    0,X     
        cli
        jsr     SERIALW      
        inx
        clr     (0x004F)
        ldd     #0x0001
        std     CDTIMR1
        cpx     #0x2023
        bne     LAA2D  
        ldx     #0x2000
        clr     (0x00B7)
LAA59:
        ldaa    0,X     
        adda    (0x00B7)
        staa    (0x00B7)
        inx
        cpx     #0x2022
        bcs     LAA59  
        ldaa    (0x00B7)
        eora    #0xFF
        cmpa    0,X     
        ldx     #0x2000
        ldaa    0x20,X
        bmi     LAA75  
        jmp     (0xAA22)
LAA75:
        ldaa    0,X     
        staa    (0x1080)
        inx
        ldaa    0,X     
        staa    (0x1082)
        inx
        ldaa    0,X     
        staa    (0x1084)
        inx
        ldaa    0,X     
        staa    (0x1086)
        inx
        ldaa    0,X     
        staa    (0x1088)
        inx
        ldaa    0,X     
        staa    (0x108A)
        inx
        ldaa    0,X     
        staa    (0x108C)
        inx
        ldaa    0,X     
        staa    (0x108E)
        inx
        ldaa    0,X     
        staa    (0x1090)
        inx
        ldaa    0,X     
        staa    (0x1092)
        inx
        ldaa    0,X     
        oraa    #0x80
        staa    (0x1094)
        inx
        ldaa    0,X     
        oraa    #0x01
        staa    (0x1096)
        inx
        ldaa    0,X     
        staa    (0x1098)
        inx
        ldaa    0,X     
        staa    (0x109A)
        inx
        ldaa    0,X     
        staa    (0x109C)
        inx
        ldaa    0,X     
        staa    (0x109E)
        jmp     (0xAA22)
        clr     (0x1098)
        clr     (0x109A)
        clr     (0x109C)
        clr     (0x109E)
        rts

        ldx     #0x042C
        ldab    #0x10
LAAED:
        tstb
        beq     LAB02  
        ldaa    0,X     
        cmpa    #0x30
        bcs     LAB03  
        cmpa    #0x39
        bhi     LAB03  
        inx
        inx
        inx
        cpx     #0x0459
        bls     LAAED  
LAB02:
        rts

LAB03:
        decb
        pshx
LAB05:
        ldaa    3,X     
        staa    0,X     
        inx
        cpx     #0x045C
        bcs     LAB05  
        ldaa    #0xFF
        staa    (0x0459)
        pulx
        bra     LAAED  
        ldx     #0x042C
        ldaa    #0xFF
LAB1C:
        staa    0,X     
        inx
        cpx     #0x045C
        bcs     LAB1C  
        rts

        ldx     #0x042C
LAB28:
        ldaa    0,X     
        cmpa    #0x30
        bcs     LAB45  
        cmpa    #0x39
        bhi     LAB45  
        inx
        inx
        inx
        cpx     #0x045C
        bcs     LAB28  
        ldaa    #0xFF
        staa    (0x042C)
        jsr     (0xAAE8)
        ldx     #0x0459
LAB45:
        rts

        ldaa    (0x0299)
        staa    0,X     
        ldaa    (0x029A)
        staa    1,X     
        ldaa    (0x029B)
        staa    2,X     
        rts

        ldx     #0x042C
LAB59:
        ldaa    (0x0299)
        cmpa    0,X     
        bne     LAB70  
        ldaa    (0x029A)
        cmpa    1,X     
        bne     LAB70  
        ldaa    (0x029B)
        cmpa    2,X     
        bne     LAB70  
        bra     LAB7A  
LAB70:
        inx
        inx
        inx
        cpx     #0x045C
        bcs     LAB59  
        sec
        rts

LAB7A:
        clc
        rts

;show re-valid tapes
        ldx     #0x042C
LAB7F:
        ldaa    0,X     
        cmpa    #0x30
        bcs     LABA3  
        cmpa    #0x39
        bhi     LABA3  
        jsr     SERIALW      
        inx
        ldaa    0,X     
        jsr     SERIALW      
        inx
        ldaa    0,X     
        jsr     SERIALW      
        inx
        ldaa    #0x20
        jsr     SERIALW      
        cpx     #0x045C
        bcs     LAB7F  
LABA3:
        ldaa    #0x0D
        jsr     SERIALW      
        ldaa    #0x0A
        jsr     SERIALW      
        rts

        clr     (0x004A)
        ldd     #0x0064
        std     CDTIMR5
LABB6:
        ldaa    (0x004A)
        bne     LABC2  
        jsr     L9B19   
        ldd     CDTIMR5
        bne     LABB6  
LABC1:
        rts

LABC2:
        cmpa    #0x31
        bne     LABCA  
        jsr     (0xAB17)
        rts

LABCA:
        bra     LABC1  

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
        ldd     T1NXT        ; get ready for next time
        addd    #0x0271      ; add 625
        std     TOC1  
        std     T1NXT

        ldaa    #0x80
        staa    TFLG1       ; clear timer1 flag

; Some blinking SPECIAL button every half second,
; if 0x0078 is non zero

        tst     (0x0078)     ; if 78 is zero, skip ahead
        beq     LABFC       ; else do some blinking button lights
        ldd     (0x0025)     ; else inc 25/26
        addd    #0x0001
        std     (0x0025)
        cpd     #0x00C8       ; is it 200?
        bne     LABFC       ; no, keep going
        clr     (0x0025)     ; reset 25/26
        clr     (0x0026)
        ldab    (0x0062)    ; and toggle bit 3 of 62
        eorb    #0x08
        stab    (0x0062)
        jsr     BUTNLIT      ; and toggle the "special" button light

; 
LABFC:
        inc     (0x006F)     ; count every 2.5ms
        ldaa    (0x006F)
        cmpa    #0x28        ; is it 40 intervals? (0.1 sec?)
        bcs     LAC47       ; if not yet, jump ahead
        clr     (0x006F)     ; clear it 2.5ms counter
        tst     (0x0063)     ; decrement 0.1s counter here
        beq     LAC10       ; if it's not already zero
        dec     (0x0063)

; staggered counters - here every 100ms

; 0x0070 counts from 250 to 1, period is 25 secs
LAC10:
        ldaa    OFFCNT1    ; decrement 0.1s counter here
        deca
        staa    OFFCNT1
        bne     LAC1B       
        ldaa    #0xFA        ; 250
        staa    OFFCNT1

; 0x0071 counts from 230 to 1, period is 23 secs
LAC1B:
        ldaa    OFFCNT2
        deca
        staa    OFFCNT2
        bne     LAC26  
        ldaa    #0xE6        ; 230
        staa    OFFCNT2

; 0x0072 counts from 210 to 1, period is 21 secs
LAC26:
        ldaa    OFFCNT3
        deca
        staa    OFFCNT3
        bne     LAC31  
        ldaa    #0xD2        ; 210
        staa    OFFCNT3

; 0x0073 counts from 190 to 1, period is 19 secs
LAC31:
        ldaa    OFFCNT4
        deca
        staa    OFFCNT4
        bne     LAC3C  
        ldaa    #0xBE        ; 190
        staa    OFFCNT4

; 0x0074 counts from 170 to 1, period is 17 secs
LAC3C:
        ldaa    OFFCNT5
        deca
        staa    OFFCNT5
        bne     LAC47  
        ldaa    #0xAA        ; 170
        staa    OFFCNT5

; back to 2.5ms period here

LAC47:
        ldaa    T30MS
        inca
        staa    T30MS
        cmpa    #0x0C        ; 12 = 30ms?
        bls     LAC59  
        clr     T30MS

; do these tasks every 30ms
        jsr     (0x8EC6)     ; ???
        jsr     (0x8F12)     ; ???

; back to every 2.5ms here
; LCD update???

LAC59:
        ldaa    (0x0043)
        beq     LACB2  
        ldx     (0x0044)
        ldaa    0,X     
        beq     LAC86  
        staa    PORTA  
        ldaa    PORTG  
        anda    #0xF3
        staa    PORTG  
        anda    #0xFD
        staa    PORTG  
        oraa    #0x02
        staa    PORTG  
        inx
        inx
        cpx     #0x0580
        bcs     LAC82  
        ldx     #0x0500
LAC82:
        stx     (0x0044)
        bra     LACB2  
LAC86:
        ldaa    1,X     
        beq     LACAF  
        staa    PORTA  
        ldaa    PORTG  
        anda    #0xFB
        oraa    #0x08
        staa    PORTG  
        anda    #0xFD
        staa    PORTG  
        oraa    #0x02
        staa    PORTG  
        inx
        inx
        cpx     #0x0580
        bcs     LACAB  
        ldx     #0x0500
LACAB:
        stx     (0x0044)
        bra     LACB2  
LACAF:
        clr     (0x0043)

; divide by 4
LACB2:
        ldaa    (0x004F)
        inca
        staa    (0x004F)
        cmpa    #0x04
        bne     LACEB  
        clr     (0x004F)

; here every 10ms
; Five big countdown timers available here
; up to 655.35 seconds each

        ldd     CDTIMR1     ; countdown 0x001B/1C every 10ms
        beq     LACC7       ; if not already 0
        subd    #0x0001
        std     CDTIMR1

LACC7:
        ldd     CDTIMR2     ; same with 0x001D/1E
        beq     LACD0  
        subd    #0x0001
        std     CDTIMR2

LACD0:
        ldd     CDTIMR3     ; same with 0x001F/20
        beq     LACD9  
        subd    #0x0001
        std     CDTIMR3

LACD9:
        ldd     CDTIMR4     ; same with 0x0021/22
        beq     LACE2  
        subd    #0x0001
        std     CDTIMR4

LACE2:
        ldd     CDTIMR5     ; same with 0x0023/24
        beq     LACEB  
        subd    #0x0001
        std     CDTIMR5

; every other time through this, setup a task switch?
LACEB:
        ldaa    (TSCNT)
        eora    #0x01
        staa    (TSCNT)
        beq     LAD0B  

        sts     (0x013C)     ; switch stacks???
        lds     (0x013E)
        ldd     T1NXT
        subd    #0x01F4      ; 625-500 = 125?
        std     TOC2         ; set this TOC2 to happen 0.5ms
        ldaa    #0x40        ; after the current TOC1 but before the next TOC1
        staa    TFLG1       ; clear timer2 irq flag, just in case?
        ldaa    #0xC0        ;
        staa    TMSK1       ; enable TOC1 and TOC2
LAD0B:
        rti

; TOC2 Timer handler

        ldaa    #0x40
        staa    TFLG1       ; clear timer2 flag
        sts     (0x013E)     ; switch stacks back???
        lds     (0x013C)
        ldaa    #0x80
        staa    TMSK1       ; enable TOC1 only
        rti

; Secondary task??

TASK2:
        tst     (0x042A)
        beq     LAD57
        ldaa    (0x00B6)
        bne     LAD29
        swi
        bra     TASK2
LAD29:
        clr     (0x00B6)
        ldab    #0x04
LAD2E:
        pshb
        ldx     #LAD3C
        jsr     L8A1A  
        swi
        pulb
        decb
        bne     LAD2E  
        bra     TASK2

LAD3C:
        .asciz     'S1'

        ldd     (0x029C)
        cpd     #0x0001
        beq     LAD54  
        cpd     #0x03E8
        blt     LAD57  
        cpd     #0x044B
        bhi     LAD57  
LAD54:
        swi
        bra     TASK2
LAD57:
        clr     (0x00B3)
        jsr     (0xAD7E)
        jsr     (0xADA0)
        bcs     TASK2
        ldab    #0x0A
        jsr     (0xAE13)
        jsr     (0xADAE)
        bcs     TASK2
        ldab    #0x14
        jsr     (0xAE13)
        jsr     (0xADB6)
        bcs     TASK2
LAD76:
        jsr     (0xADB8)
        sec
        bcs     TASK2
        bra     LAD76  
        ldx     #LAE1E       ;+++
        jsr     L8A1A  
        ldab    #0x1E
        jsr     (0xAE13)
        ldx     #LAE22       ;ATH
        jsr     L8A1A  
        ldab    #0x1E
        jsr     (0xAE13)
        ldx     #LAE27       ;ATZ
        jsr     L8A1A  
        ldab    #0x1E
        jsr     (0xAE13)
        rts
LADA0:
        jsr     (0xB1DD)
        bcs     LADA0  
        jsr     (0xB24F)

        .asciz  'RING'

        rts

        ldx     #0xAE2C
        jsr     L8A1A       ;ATA
        clc
        rts
        clc
        rts
        jsr     (0xB1D2)
        jsr     (0xAE31)
        ldaa    #0x01
        staa    (0x00B3)
        jsr     (0xB1DD)
        jsr     (0xB271)
        psha
        jsr     (0xB2C0)
        pula
        cmpa    #0x01
        bne     LADD9  
        ldx     #LB295
        jsr     L8A1A       ;'You have selected #1'
        bra     LAE0A  
LADD9:
        cmpa    #0x02
        bne     LADDD  
LADDD:
        cmpa    #0x03
        bne     LADE1  
LADE1:
        cmpa    #0x04
        bne     LADE5  
LADE5:
        cmpa    #0x05
        bne     LADE9  
LADE9:
        cmpa    #0x06
        bne     LADED  
LADED:
        cmpa    #0x07
        bne     LADF1  
LADF1:
        cmpa    #0x08
        bne     LADF5  
LADF5:
        cmpa    #0x09
        bne     LADF9  
LADF9:
        cmpa    #0x0A
        bne     LADFD  
LADFD:
        cmpa    #0x0B
        bne     LAE0A  
        ldx     #LB2AA       ;'You have selected #11'
        jsr     L8A1A  
        jmp     (0xAE0A)
LAE0A:
        ldab    #0x14
        jsr     (0xAE13)
        clr     (0x00B3)
        rts

LAE13:
        ldx     #0x0020
LAE16:
        swi
        dex
        bne     LAE16  
        decb
        bne     LAE13  
        rts

; text??
LAE1E:
        .asciz      '+++'
LAE22:
        .asciz      'ATH\r'
LAE27:
        .asciz      'ATZ\r'
LAE2C:
        .asciz      'ATA\r'

        ldx     #LAE38       ; big long string of stats?
        jsr     L8A1A  
        rts

LAE38:
        .ascii  "^0101Serial #:^0140#0000^0111~4"
        .byte   0x0E,0x20
        .ascii  "^0141|"
        .byte   0x04,0x28
        .ascii  "^0301CURRENT^0340HISTORY^0501Show Status:^0540Total # reg. shows:^0601Random Status:^0570|"
        .byte   0x04,0x10
        .ascii  "^0640Total # live shows:^0701Current Reg Tape #:^0670|"
        .byte   0x04,0x12
        .ascii  "^0730~3"
        .byte   0x04,0x02
        .ascii  "^0740Total # failed pswd attempts:^0801Current Live Tape #:^0770|"
        .byte   0x04,0x14
        .ascii  "^0830~3"
        .byte   0x04,0x05
        .ascii  "^0840Total # successful pswd:^0901Current Version #:^0870|"
        .byte   0x04,0x16
        .ascii  "^0930@"
        .byte   0x04,0x00
        .ascii  "^0940Total # bdays played:^1040Total # VCR adjusts:^0970|"
        .byte   0x04,0x18
        .ascii  "^1070|"
        .byte   0x04,0x1A
        .ascii  "^1140Total # remote accesses:^1240Total # access attempts:^1170|"
        .byte   0x04,0x1C
        .ascii  "^1270|"
        .byte   0x04,0x1E
        .ascii  "^1340Total # rejected showtapes:^1440Total # Short bdays:^1370|"
        .byte   0x04,0x20
        .ascii  "^1470|"
        .byte   0x04,0x22
        .ascii  "^1540Total # Reg bdays:^1640Total # resets-pwr ups:^1570|"
        .byte   0x04,0x24
        .ascii  "^1670|"
        .byte   0x04,0x26
        .ascii  "^1801FUNCTIONS^1823Select Function:^20011.Clear rnd enables^2028 6.Set loc name-#^205411.Diagnostics^21012.Set rnd enables^2128 7.Set Time^215412.^22013.Set reg tape #^2228 8.Disbl-enbl show^225413.^23014.Set liv tape #^2328 9.Upload program^235414.^24015.Reset history^242810.Debugger^245415.^1840"
        .byte   0x00

; back to code
        ldx     #LB1D8       ; escape sequence?
        jmp     L8A1A  

LB1D8:
        ; esc[2J ?
        .byte   0x1b
        .asciz  '[2J'

        ldx     #0x05A0
        ldd     #0x0000
        std     (0x029E)
LB1E6:
        ldd     (0x029E)
        addd    #0x0001
        std     (0x029E)
        cpd     #0x0FA0
        bcc     LB21D  
        jsr     (0xB223)
        bcs     LB1FE  
        swi
        bra     LB1E6  
        rts

LB1FE:
        staa    0,X     
        inx
        cmpa    #0x0D
        bne     LB207  
        bra     LB21F  
LB207:
        cmpa    #0x1B
        bne     LB20D  
        bra     LB21D  
LB20D:
        tst     (0x00B3)
        beq     LB215  
        jsr     (0x8B3B)
LB215:
        ldd     #0x0000
        std     (0x029E)
        bra     LB1E6  
LB21D:
        sec
        rts

LB21F:
        clr     0,X     
        clc
        rts

        ldaa    SCCCTRLB
        lsra
        bcs     LB234  
        clra
        staa    SCCCTRLB
        ldaa    #0x30
        staa    SCCCTRLB
        clc
        rts

LB234:
        ldaa    #0x01
        staa    SCCCTRLB
        ldaa    #0x70
        bita    SCCCTRLB
        bne     LB245  
        sec
        ldaa    SCCDATAB
        rts

LB245:
        ldaa    SCCDATAB
        ldaa    #0x30
        staa    SCCCTRLA
        clc
        rts

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

; text
LB295:
        .asciz  'You have selected #1'
LB2AA:
        .asciz  'You have selected #11'

; code
        ldx     #LB2C7      ; strange table
        jsr     L8A1A  
        rts

LB2C7:
        .asciz  "^2001%^2101%^2201%^2301%^2401%^2001"

        .byte   0xfa,0x20,0xfa,0x20,0xf6,0x22,0xf5,0x20
        .byte   0xf5,0x20,0xf3,0x22,0xf2,0x20,0xe5,0x22
        .byte   0xe5,0x22,0xe2,0x20,0xd2,0x20,0xbe,0x00
        .byte   0xbc,0x22,0xbb,0x30,0xb9,0x32,0xb9,0x32
        .byte   0xb7,0x30,0xb6,0x32,0xb5,0x30,0xb4,0x32
        .byte   0xb4,0x32,0xb3,0x20,0xb3,0x20,0xb1,0xa0
        .byte   0xb1,0xa0,0xb0,0xa2,0xaf,0xa0,0xaf,0xa6
        .byte   0xae,0xa0,0xae,0xa6,0xad,0xa4,0xac,0xa0
        .byte   0xac,0xa0,0xab,0xa0,0xaa,0xa0,0xaa,0xa0
        .byte   0xa2,0x80,0xa0,0xa0,0xa0,0xa0,0x8d,0x80
        .byte   0x8a,0xa0,0x7e,0x80,0x7b,0xa0,0x79,0xa4
        .byte   0x78,0xa0,0x77,0xa4,0x76,0xa0,0x75,0xa4
        .byte   0x74,0xa0,0x73,0xa4,0x72,0xa0,0x71,0xa4
        .byte   0x70,0xa0,0x6f,0xa4,0x6e,0xa0,0x6d,0xa4
        .byte   0x6c,0xa0,0x69,0x80,0x69,0x80,0x67,0xa0
        .byte   0x5e,0x20,0x58,0x24,0x57,0x20,0x57,0x20
        .byte   0x56,0x24,0x55,0x20,0x54,0x24,0x54,0x24
        .byte   0x53,0x20,0x52,0x24,0x52,0x24,0x50,0x20
        .byte   0x4f,0x24,0x4e,0x20,0x4d,0x24,0x4c,0x20
        .byte   0x4c,0x20,0x4b,0x24,0x4a,0x20,0x49,0x20
        .byte   0x49,0x00,0x48,0x20,0x47,0x20,0x47,0x20
        .byte   0x46,0x20,0x45,0x24,0x45,0x24,0x44,0x20
        .byte   0x42,0x20,0x42,0x20,0x37,0x04,0x35,0x20
        .byte   0x2e,0x04,0x2e,0x04,0x2d,0x20,0x23,0x24
        .byte   0x21,0x20,0x17,0x24,0x13,0x00,0x11,0x24
        .byte   0x10,0x30,0x07,0x34,0x06,0x30,0x05,0x30
        .byte   0xff,0xff,0xd7,0x22,0xd5,0x20,0xc9,0x22
        .byte   0xc7,0x20,0xc4,0x24,0xc3,0x20,0xc2,0x24
        .byte   0xc1,0x20,0xbf,0x24,0xbf,0x24,0xbe,0x20
        .byte   0xbd,0x24,0xbc,0x20,0xbb,0x24,0xba,0x20
        .byte   0xb9,0x20,0xb8,0x24,0xb7,0x20,0xb4,0x00
        .byte   0xb4,0x00,0xb2,0x20,0xa9,0x20,0xa3,0x20
        .byte   0xa2,0x20,0xa1,0x20,0xa0,0x20,0xa0,0x20
        .byte   0x9f,0x20,0x9f,0x20,0x9e,0x20,0x9d,0x24
        .byte   0x9d,0x24,0x9b,0x20,0x9a,0x24,0x99,0x20
        .byte   0x98,0x20,0x97,0x24,0x97,0x24,0x95,0x20
        .byte   0x95,0x20,0x94,0x00,0x94,0x00,0x93,0x20
        .byte   0x92,0x00,0x92,0x00,0x91,0x20,0x90,0x20
        .byte   0x90,0x20,0x8f,0x20,0x8d,0x20,0x8d,0x20
        .byte   0x81,0x00,0x7f,0x20,0x79,0x00,0x79,0x00
        .byte   0x78,0x20,0x76,0x20,0x6b,0x00,0x69,0x20
        .byte   0x5e,0x00,0x5c,0x20,0x5b,0x30,0x52,0x10
        .byte   0x51,0x30,0x50,0x30,0x50,0x30,0x4f,0x20
        .byte   0x4e,0x20,0x4e,0x20,0x4d,0x20,0x46,0xa0
        .byte   0x45,0xa0,0x3d,0xa0,0x3d,0xa0,0x39,0x20
        .byte   0x2a,0x00,0x28,0x20,0x1e,0x00,0x1c,0x22
        .byte   0x1c,0x22,0x1b,0x20,0x1a,0x22,0x19,0x20
        .byte   0x18,0x22,0x18,0x22,0x16,0x20,0x15,0x22
        .byte   0x15,0x22,0x14,0xa0,0x13,0xa2,0x11,0xa0
        .byte   0xff,0xff,0xbe,0x00,0xbc,0x22,0xbb,0x30
        .byte   0xb9,0x32,0xb9,0x32,0xb7,0x30,0xb6,0x32
        .byte   0xb5,0x30,0xb4,0x32,0xb4,0x32,0xb3,0x20
        .byte   0xb3,0x20,0xb1,0xa0,0xb1,0xa0,0xb0,0xa2
        .byte   0xaf,0xa0,0xaf,0xa6,0xae,0xa0,0xae,0xa6
        .byte   0xad,0xa4,0xac,0xa0,0xac,0xa0,0xab,0xa0
        .byte   0xaa,0xa0,0xaa,0xa0,0xa2,0x80,0xa0,0xa0
        .byte   0xa0,0xa0,0x8d,0x80,0x8a,0xa0,0x7e,0x80
        .byte   0x7b,0xa0,0x79,0xa4,0x78,0xa0,0x77,0xa4
        .byte   0x76,0xa0,0x75,0xa4,0x74,0xa0,0x73,0xa4
        .byte   0x72,0xa0,0x71,0xa4,0x70,0xa0,0x6f,0xa4
        .byte   0x6e,0xa0,0x6d,0xa4,0x6c,0xa0,0x69,0x80
        .byte   0x69,0x80,0x67,0xa0,0x5e,0x20,0x58,0x24
        .byte   0x57,0x20,0x57,0x20,0x56,0x24,0x55,0x20
        .byte   0x54,0x24,0x54,0x24,0x53,0x20,0x52,0x24
        .byte   0x52,0x24,0x50,0x20,0x4f,0x24,0x4e,0x20
        .byte   0x4d,0x24,0x4c,0x20,0x4c,0x20,0x4b,0x24
        .byte   0x4a,0x20,0x49,0x20,0x49,0x00,0x48,0x20
        .byte   0x47,0x20,0x47,0x20,0x46,0x20,0x45,0x24
        .byte   0x45,0x24,0x44,0x20,0x42,0x20,0x42,0x20
        .byte   0x37,0x04,0x35,0x20,0x2e,0x04,0x2e,0x04
        .byte   0x2d,0x20,0x23,0x24,0x21,0x20,0x17,0x24
        .byte   0x13,0x00,0x11,0x24,0x10,0x30,0x07,0x34
        .byte   0x06,0x30,0x05,0x30,0xff,0xff,0xcd,0x20
        .byte   0xcc,0x20,0xcb,0x20,0xcb,0x20,0xca,0x00
        .byte   0xc9,0x20,0xc9,0x20,0xc8,0x20,0xc1,0xa0
        .byte   0xc0,0xa0,0xb8,0xa0,0xb8,0x20,0xb4,0x20
        .byte   0xa6,0x00,0xa4,0x20,0x99,0x00,0x97,0x22
        .byte   0x97,0x22,0x96,0x20,0x95,0x22,0x94,0x20
        .byte   0x93,0x22,0x93,0x22,0x91,0x20,0x90,0x20
        .byte   0x90,0x20,0x8d,0xa0,0x8c,0xa0,0x7d,0xa2
        .byte   0x7d,0xa2,0x7b,0xa0,0x7b,0xa0,0x79,0xa2
        .byte   0x79,0xa2,0x77,0xa0,0x77,0xa0,0x76,0x80
        .byte   0x75,0xa0,0x6e,0x20,0x67,0x24,0x66,0x20
        .byte   0x65,0x24,0x64,0x20,0x63,0x24,0x63,0x24
        .byte   0x61,0x20,0x60,0x24,0x5f,0x20,0x5e,0x20
        .byte   0x5d,0x24,0x5c,0x20,0x5b,0x24,0x5a,0x20
        .byte   0x59,0x24,0x58,0x20,0x56,0x20,0x55,0x04
        .byte   0x54,0x00,0x53,0x24,0x52,0x20,0x52,0x20
        .byte   0x4f,0x24,0x4f,0x24,0x4e,0x30,0x4d,0x30
        .byte   0x47,0x10,0x45,0x30,0x35,0x30,0x33,0x10
        .byte   0x31,0x30,0x31,0x30,0x1d,0x20,0xff,0xff
        .byte   0xa9,0x20,0xa3,0x20,0xa2,0x20,0xa1,0x20
        .byte   0xa0,0x20,0xa0,0x20,0x9f,0x20,0x9f,0x20
        .byte   0x9e,0x20,0x9d,0x24,0x9d,0x24,0x9b,0x20
        .byte   0x9a,0x24,0x99,0x20,0x98,0x20,0x97,0x24
        .byte   0x97,0x24,0x95,0x20,0x95,0x20,0x94,0x00
        .byte   0x94,0x00,0x93,0x20,0x92,0x00,0x92,0x00
        .byte   0x91,0x20,0x90,0x20,0x90,0x20,0x8f,0x20
        .byte   0x8d,0x20,0x8d,0x20,0x81,0x00,0x7f,0x20
        .byte   0x79,0x00,0x79,0x00,0x78,0x20,0x76,0x20
        .byte   0x6b,0x00,0x69,0x20,0x5e,0x00,0x5c,0x20
        .byte   0x5b,0x30,0x52,0x10,0x51,0x30,0x50,0x30
        .byte   0x50,0x30,0x4f,0x20,0x4e,0x20,0x4e,0x20
        .byte   0x4d,0x20,0x46,0xa0,0x45,0xa0,0x3d,0xa0
        .byte   0x3d,0xa0,0x39,0x20,0x2a,0x00,0x28,0x20
        .byte   0x1e,0x00,0x1c,0x22,0x1c,0x22,0x1b,0x20
        .byte   0x1a,0x22,0x19,0x20,0x18,0x22,0x18,0x22
        .byte   0x16,0x20,0x15,0x22,0x15,0x22,0x14,0xa0
        .byte   0x13,0xa2,0x11,0xa0

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
        staa    TMSK1       ; enable OC1 irq
        ldaa    #0xFE
        staa    BPROT       ; protect everything except $xE00-$xE1F
        ldaa    0x0007      ;
        cmpa    #0xDB       ; special unprotect mode???
        bne     LF81C       ; if not, jump ahead
        clr     BPROT       ; else unprotect everything
        clr     0x0007     ; reset special unprotect mode???
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
        clr     0x0000      ; ????? Done with basic init?

; Initialize Main PIA
        ldaa    #0x30       ;
        staa    PIA0CRA     ; control register A, CA2=0, sel DDRA
        staa    PIA0CRB     ; control register B, CB2=0, sel DDRB
        ldaa    #0xFF
        staa    PIA0DDRB    ; select B0-B7 to be outputs
        ldaa    #0x78       ;
        staa    PIA0DDRA    ; select A3-A6 to be outputs
        ldaa    #0x34       ;
        staa    PIA0CRA     ; select output register A
        staa    PIA0CRB     ; select output register B
        ldab    #0xFF
        jsr     BUTNLIT     ; turn on all button lights
        bra     LF86A       ; jump past data table

; Data loaded into SCCCTRLB SCC
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
        ;   DesiredRate=~4800 bps with tc=0x18 and BRClockPeriod=16
        .byte   0xff        ; end of table marker

; init SCC (8530)
LF86A:
        ldx     #0xF857
LF86D:
        ldaa    0,X
        cmpa    #0xFF
        beq     LF879
        staa    SCCCTRLB
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
        stab    PIA0PRA     ; enable LCD backlight, disable RESET button light
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
        ldaa    #0x01       ; Mark Failed RAM test
        staa    (0x0000)
; 
LF8CA:
        ldab    #0x01
        jsr     DIAGDGT     ; write digit 1 to diag display
        ldaa    BPROT  
        bne     LF8E3       ; if something is protected, jump ahead
        ldaa    (0x3000)    ; NVRAM
        cmpa    #0x7E
        bne     LF8E3       ; if RAM(0x3000) == 0x7E, jump ahead anyway (special unlock?)

; error?
        ldab    #0x0E
        jsr     DIAGDGT      ; write digit E to diag display
        jmp     (0x3000)     ; jump to routine in NVRAM?

; checking for serial connection

LF8E3:
        ldx     #0xF000     ; timeout counter
LF8E6:
        nop
        nop
        dex
        beq     LF8F6       ; if time is up, jump ahead
        jsr     SERIALR     ; else read serial data if available
        bcc     LF8E6       ; if no data available, loop
        cmpa    #0x1B       ; if serial data was read, is it an ESC?
        beq     LF91D       ; if so, jump to echo hex char routine?
        bra     LF8E6       ; else loop
LF8F6:
        ldaa    L8000       ; check if this is a regular rom?
        cmpa    #0x7E        
        bne     MINIMON     ; if not, jump ahead

        ldab    #0x0A
        jsr     DIAGDGT     ; else write digit A to diag display

        jsr     L8000       ; jump to start of rom routine
        sei                 ; if we ever come return, just loop and do it all again
        bra     LF8F6

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MINIMON:
        ldab    #0x10       ; not a regular rom
        jsr     DIAGDGT     ; blank the diag display

        jsr     SERMSGW     ; enter the mini-monitor???
        .ascis  'MINI-MON'

        ldab    #0x10
        jsr     DIAGDGT     ; blank the diag display

LF91D:
        clr     (0x0005)
        clr     (0x0004)
        clr     (0x0002)
        clr     (0x0006)

        jsr     SERMSGW
        .ascis  '\r\n>'

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; convert A to 2 hex digits and transmit
SERHEXW:
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
        jmp     SERIALW

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; serial read non-blocking
SERIALR:
        ldaa    SCSR  
        bita    #0x20
        bne     LF955
        clc
        rts

; serial blocking read
SERBLKR:
        ldaa    SCSR        ; read serial status
        bita    #0x20
        beq     SERBLKR     ; if RDRF=0, loop

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
        jsr     SERIALW
        bra     SERBLKR     ; go to wait for a character

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Send A to SCI with CR turned to CRLF
SERIALW:
        cmpa    #0x0D       ; CR?
        beq     LF975       ; if so echo CR+LF
        bra     SERRAWW     ; else just echo it
LF975:
        ldaa    #0x0D
        jsr     SERRAWW
        ldaa    #0x0A

; send a char to SCI
SERRAWW:
        ldab    SCSR        ; wait for ready to send
        bitb    #0x40
        beq     SERRAWW
        staa    SCDR        ; send it
        rts

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Unused?
LF987:
        jsr     SERBLKR     ; get a serial char
        cmpa    #0x7A       ;'z'
        bhi     LF994
        cmpa    #0x61       ;'a'
        bcs     LF994
        sbca    #0x20       ;convert to upper case?
LF994:
        rts

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Write hex digit arg in B to diagnostic lights
; or B=0x10 or higher for blank

DIAGDGT:
        psha
        cmpb    #0x11
        bcs     LF99C
        ldab    #0x10
LF99C:
        ldx     #LF9B4
        abx
        ldaa    0,X
        staa    PIA0PRB     ; write arg to local data bus
        ldaa    PIA0PRA     ; read from Port A
        oraa    #0x20       ; bit 5 high
        staa    PIA0PRA     ; write back to Port A
        anda    #0xDF       ; bit 5 low
        staa    PIA0PRA     ; write back to Port A
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Write arg in B to Button Lights
BUTNLIT:
        psha
        stab    PIA0PRB     ; write arg to local data bus
        ldaa    PIA0PRA     ; read from Port A
        anda    #0xEF       ; bit 4 low
        staa    PIA0PRA     ; write back to Port A
        oraa    #0x10       ; bit 4 high
        staa    PIA0PRA     ; write this to Port A
        pula
        rts

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Send rom message via SCI
SERMSGW:
        puly
LF9DA:
        ldaa    0,Y
        beq     LF9E8       ; if zero terminated, return
        bmi     LF9ED       ; if high bit set..do last char and return
        jsr     SERRAWW     ; else send char
        iny
        bra     LF9DA       ; and loop for next one

LF9E8:
        iny                 ; setup return address and return
        pshy
        rts

LF9ED:
        anda    #0x7F       ; remove top bit
        jsr     SERRAWW     ; send char
        bra     LF9E8       ; and we're done
        rts

DORTS:
        rts
DORTI:        
        rti

; all 0xffs in this gap

        .org    0xffa0

        jmp     DORTS
        jmp     DORTS
        jmp     DORTS
        jmp     SERHEXW
        jmp     SERMSGW      
        jmp     SERIALR     
        jmp     SERIALW      
        jmp     MINIMON
        jmp     DIAGDGT 
        jmp     BUTNLIT 

       .byte    0xff
       .byte    0xff

; Vectors

       .word   DORTI        ; Stub RTI
       .word   DORTI        ; Stub RTI
       .word   DORTI        ; Stub RTI
       .word   DORTI        ; Stub RTI
       .word   DORTI        ; Stub RTI
       .word   DORTI        ; Stub RTI
       .word   DORTI        ; Stub RTI
       .word   DORTI        ; Stub RTI
       .word   DORTI        ; Stub RTI
       .word   DORTI        ; Stub RTI
       .word   DORTI        ; Stub RTI

        .word  0x0100       ; SCI
        .word  0x0103       ; SPI
        .word  0x0106       ; PA accum. input edge
        .word  0x0109       ; PA Overflow

        .word  DORTI        ; Stub RTI

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

