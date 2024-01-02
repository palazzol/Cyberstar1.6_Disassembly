                              1 
                              2 ;;;;;;;;;;;;;;;;;;;;;
                              3 ; Cyberstar v1.6
                              4 ;   by
                              5 ; David B. Philipsen
                              6 ;
                              7 ; Reverse-engineering
                              8 ;   by
                              9 ; Frank Palazzolo
                             10 ;;;;;;;;;;;;;;;;;;;;;
                             11 
                             12 ; 68HC11 Register definitions
                             13 
                     1000    14 PORTA       .equ    0x1000
                     1001    15 DDRA        .equ    0x1001
                     1002    16 PORTG       .equ    0x1002
                     1003    17 DDRG        .equ    0x1003
                     100A    18 PORTE       .equ    0x100a
                     1016    19 TOC1        .equ    0x1016
                     1018    20 TOC2        .equ    0x1018
                     1022    21 TMSK1       .equ    0x1022
                     1023    22 TFLG1       .equ    0x1023
                     1024    23 TMSK2       .equ    0x1024
                     102B    24 BAUD        .equ    0x102b
                     102C    25 SCCR1       .equ    0x102c
                     102D    26 SCCR2       .equ    0x102d
                     102E    27 SCSR        .equ    0x102e
                     102F    28 SCDR        .equ    0x102f
                     1035    29 BPROT       .equ    0x1035
                     103B    30 PPROG       .equ    0x103b
                     105C    31 CSSTRH      .equ    0x105c
                     105D    32 CSCTL       .equ    0x105d
                     105E    33 CSGADR      .equ    0x105e
                     105F    34 CSGSIZ      .equ    0x105f
                             35 
                             36 ; Constants
                     197B    37 CHKSUM      .equ    0x197B
                             38 
                             39 ; RAM locations
                             40 
                     0010    41 T1NXT       .equ    0x0010      ; 0x0010/0x0011
                             42 
                             43 ; if not zero, these are decremented every 0.1 second by the timer 
                     001B    44 CDTIMR1     .equ    0x001b      ; 0x001b/0x001c
                     001D    45 CDTIMR2     .equ    0x001d      ; 0x001d/0x001e
                     001F    46 CDTIMR3     .equ    0x001f      ; 0x001f/0x0020
                     0021    47 CDTIMR4     .equ    0x0021      ; 0x0021/0x0022
                     0023    48 CDTIMR5     .equ    0x0023      ; 0x0023/0x0024
                             49 
                     0027    50 T30MS       .equ    0x0027      ; used to count t1 irqs for 30ms tasks
                             51 
                             52 ; offset counters
                     0070    53 OFFCNT1     .equ    0x0070
                     0071    54 OFFCNT2     .equ    0x0071
                     0072    55 OFFCNT3     .equ    0x0072
                     0073    56 OFFCNT4     .equ    0x0073
                     0074    57 OFFCNT5     .equ    0x0074
                             58 
                             59 ; bottom bit counts every other T1OC
                     00B0    60 TSCNT       .equ    0x00B0
                             61 
                             62 ; NVRAM locations
                             63 
                             64 ;           .equ    0x0400          ; 0x07 - CPU test at boot, others?
                             65 ;           .equ    0x0401          ; Rnd bits? (clears to 0x00)
                             66 ;           .equ    0x0402-0x0404   ; Reg digits (BCD)
                             67 ;           .equ    0x0405-0x0407   ; Liv digits (BCD)
                             68 ;           .equ    0x0408          ; 0x39 (rts) for CPU test?
                             69 
                     040B    70 CPYRTCS     .equ    0x040B          ; 0x040B/0x040C - copyright message checksum
                             71 ;           .equ    0x040D-0x040E   ; some counter? (600/65000?)
                     040F    72 ERASEFLG    .equ    0x040F          ; 0 = normal boot, 1 = erasing EEPROM
                             73 ;           .equ    0x0410-0x0411   ; some counter
                             74 ;           .equ    0x0412-0x0413   ; some counter
                             75 ;           .equ    0x0414-0x0415   ; counter - number of bad code validations
                             76 ;           .equ    0x0416-0x0417   ; counter - number of good code validations
                             77 ;           .equ    0x0418-0x0419   ; some counter
                             78 ;           .equ    0x041A-0x041B   ; some counter
                             79 
                             80 ;           .equ    0x0420-0x0421   ; some counter
                             81 ;           .equ    0x0422-0x0423   ; some counter
                             82 ;           .equ    0x0424-0x0425   ; some counter
                     0426    83 NUMBOOT     .equ    0x0426          ; counter - number of boots (0x0426/0x0427)
                             84 
                             85 ;           .equ    0x042A          ; King enable (bit 0?)
                             86 ;           .equ    0x042B          ; other Rnd? (clears to 0x00)
                             87 ;           .equ    0x042C-0x45B?   ; clears to 0xFF (revalid tapes?)
                             88 ;                                   ; relates to 0x0299-0x29B?
                             89 ;           .equ    0x045C          ; 00 from F7C0 stored here, R12/CNR?
                             90 
                             91 ;           .equ    0x0500-0x057F   ; LCD buffer: 32, 4-byte entries
                             92 
                             93 ;           .equ    0x0590-0x0598   ; buffer?
                             94 ;           .equ    0x05A0-         ; buffer?
                             95 
                             96 ;           .equ    0x2000-         ; STUDIO - programming mode ?
                             97 ;           .equ    0x3000-         ; ???
                             98 
                             99 ; EEPROM locations
                            100 
                            101 ;           .equ    0x0E00-0x0E0B   ; signature?
                            102 
                            103 ;           .equ    0x0E20-0x0E24   ; 4 bcd digit serial number + 0xDB
                            104 
                            105 ; Main PIA on CPU card
                     1804   106 PIA0PRA     .equ    0x1804      ; CRA-2 = 1
                     1804   107 PIA0DDRA    .equ    0x1804      ; CRA-2 = 0
                     1805   108 PIA0CRA     .equ    0x1805
                     1806   109 PIA0PRB     .equ    0x1806      ; CRB-2 = 1
                     1806   110 PIA0DDRB    .equ    0x1806      ; CRB-2 = 0
                     1807   111 PIA0CRB     .equ    0x1807
                            112 
                            113 ; Zilog 8530 SCC - A is aux serial, B is sync data
                     180C   114 SCCCTRLA    .equ    0x180C
                     180D   115 SCCCTRLB    .equ    0x180D
                     180E   116 SCCDATAA    .equ    0x180E
                     180F   117 SCCDATAB    .equ    0x180F
                            118 
                            119         .area   region1 (ABS)
   8000                     120         .org    0x8000
                            121 
                            122 ; Disassembly originally from unidasm
                            123 
   8000                     124 L8000:
   8000 7E 80 50      [ 3]  125         jmp     L8050           ; jump past copyright message
                            126 
   8003                     127 CPYRTMSG:
   8003 43 6F 70 79 72 69   128         .ascii  'Copyright (c) 1993 by David B. Philipsen Licensed by ShowBiz Pizza Time, Inc.'
        67 68 74 20 28 63
        29 20 31 39 39 33
        20 62 79 20 44 61
        76 69 64 20 42 2E
        20 50 68 69 6C 69
        70 73 65 6E 20 4C
        69 63 65 6E 73 65
        64 20 62 79 20 53
        68 6F 77 42 69 7A
        20 50 69 7A 7A 61
        20 54 69 6D 65 2C
        20 49 6E 63 2E
                            129 
   8050                     130 L8050:
   8050 0F            [ 2]  131         sei
                            132 
   8051 FC 04 26      [ 5]  133         ldd     NUMBOOT         ; increment boot cycle counter?
   8054 C3 00 01      [ 4]  134         addd    #0x0001
   8057 FD 04 26      [ 5]  135         std     NUMBOOT
                            136 
   805A CE AD 1D      [ 3]  137         ldx     #TASK2          ;
   805D FF 01 CE      [ 5]  138         stx     (0x01CE)        ; store this vector here?
   8060 7F 01 C7      [ 6]  139         clr     (0x01C7)        ; clear this vector?
   8063 CC 01 C6      [ 3]  140         ldd     #0x01C6         ;
   8066 FD 01 3E      [ 5]  141         std     (0x013E)        ; store this vector here? Some sort of RTI setup
   8069 7F 00 B0      [ 6]  142         clr     TSCNT
   806C 7F 00 4E      [ 6]  143         clr     (0x004E)
   806F 7F 00 B6      [ 6]  144         clr     (0x00B6)
   8072 7F 00 4D      [ 6]  145         clr     (0x004D)
   8075 86 03         [ 2]  146         ldaa    #0x03           ; ddr mode, enable CA1 L->H irq on
   8077 B7 10 A8      [ 4]  147         staa    (0x10A8)        ;   board 11
   807A 18 CE 00 80   [ 4]  148         ldy     #0x0080         ; delay loop
   807E                     149 L807E:
   807E 18 09         [ 4]  150         dey
   8080 26 FC         [ 3]  151         bne     L807E
   8082 86 11         [ 2]  152         ldaa    #0x11           ; ddr mode, enable CA1 H->L irq on
   8084 B7 10 A8      [ 4]  153         staa    (0x10A8)        ;   board 11
                            154 
   8087 C6 10         [ 2]  155         ldab    #0x10
   8089 BD F9 95      [ 6]  156         jsr     DIAGDGT         ; blank the diag display
                            157 
   808C B6 18 04      [ 4]  158         ldaa    PIA0PRA         ; turn off reset button light
   808F 84 BF         [ 2]  159         anda    #0xBF
   8091 B7 18 04      [ 4]  160         staa    PIA0PRA 
   8094 86 FF         [ 2]  161         ldaa    #0xFF
   8096 97 AC         [ 3]  162         staa    (0x00AC)        ; diagnostic indicator (all off)
                            163 
   8098 BD 86 C4      [ 6]  164         jsr     L86C4           ; Reset boards 1-10
   809B BD 99 A6      [ 6]  165         jsr     L99A6           ; do some stuff with diag digit??
   809E BD 8C 3C      [ 6]  166         jsr     L8C3C           ; reset LCD?
   80A1 BD 87 E8      [ 6]  167         jsr     L87E8           ; SCC - init aux serial
   80A4 BD 87 BC      [ 6]  168         jsr     L87BC           ; SCC - init sync data
   80A7 BD 8C 7E      [ 6]  169         jsr     L8C7E           ; reset LCD buffer
   80AA BD 8D 29      [ 6]  170         jsr     L8D29           ; some LCD command? (0C?)
   80AD BD 8B C0      [ 6]  171         jsr     L8BC0           ; setup Timer/SWI handlers
   80B0 BD 8B EE      [ 6]  172         jsr     L8BEE           ; ??? redundant?
   80B3 0E            [ 2]  173         cli
   80B4 BD A2 5E      [ 6]  174         jsr     LA25E           ; compute and store copyright checksum
   80B7 B6 04 0F      [ 4]  175         ldaa    ERASEFLG
   80BA 81 01         [ 2]  176         cmpa    #0x01           ; 1 means erase EEPROM!
   80BC 26 03         [ 3]  177         bne     L80C1
   80BE 7E A2 75      [ 3]  178         jmp     LA275           ; erase EEPROM: skipped if ERASEFLG !=1
   80C1                     179 L80C1:
   80C1 FC 04 0B      [ 5]  180         ldd     CPYRTCS         ; copyright checksum
   80C4 1A 83 19 7B   [ 5]  181         cpd     #CHKSUM         ; check against copyright checksum value
   80C8 26 4F         [ 3]  182         bne     LOCKUP          ; if fail, bye bye
   80CA 5F            [ 2]  183         clrb
   80CB D7 62         [ 3]  184         stab    (0x0062)        ; button light buffer?
   80CD BD F9 C5      [ 6]  185         jsr     BUTNLIT         ; turn off all button lights
   80D0 BD A3 41      [ 6]  186         jsr     LA341           ; fire 3 bits on board 2
   80D3 B6 04 00      [ 4]  187         ldaa    (0x0400)
   80D6 81 07         [ 2]  188         cmpa    #0x07
   80D8 27 42         [ 3]  189         beq     L811C           ; if 7, go directly to CPU test
   80DA 25 29         [ 3]  190         bcs     L8105           ; higher than 7, go to init setup, retaining L/R counts
   80DC 81 06         [ 2]  191         cmpa    #0x06
   80DE 27 25         [ 3]  192         beq     L8105           ; 6, go to init setup, retaining L/R counts
   80E0 CC 00 00      [ 3]  193         ldd     #0x0000         ; 5 or lower...
   80E3 FD 04 0D      [ 5]  194         std     (0x040D)        ; clear 040D/040E counter
   80E6 CC 00 C8      [ 3]  195         ldd     #0x00C8         ; wait up to 2 seconds for a serial byte
   80E9 DD 1B         [ 4]  196         std     CDTIMR1 
   80EB                     197 L80EB:
   80EB DC 1B         [ 4]  198         ldd     CDTIMR1
   80ED 27 0B         [ 3]  199         beq     L80FA           ; timeout
   80EF BD F9 45      [ 6]  200         jsr     SERIALR
   80F2 24 F7         [ 3]  201         bcc     L80EB
   80F4 81 44         [ 2]  202         cmpa    #0x44           ; if it's a 'D', do init setup + reset L/R counts
   80F6 26 F3         [ 3]  203         bne     L80EB           ; else keep looping for 2 seconds
   80F8 20 05         [ 3]  204         bra     L80FF           ; go to init setup
   80FA                     205 L80FA:
   80FA BD 9F 1E      [ 6]  206         jsr     L9F1E
   80FD 25 1A         [ 3]  207         bcs     LOCKUP          ; bye bye
                            208 ; init setup + reset L and R counts
   80FF                     209 L80FF:
   80FF BD 9E AF      [ 6]  210         jsr     L9EAF           ; reset L counts
   8102 BD 9E 92      [ 6]  211         jsr     L9E92           ; reset R counts
                            212 ; init setup
   8105                     213 L8105:
   8105 86 39         [ 2]  214         ldaa    #0x39
   8107 B7 04 08      [ 4]  215         staa    0x0408          ; set rts here for later CPU test
   810A BD A1 D5      [ 6]  216         jsr     LA1D5           ; set 0400 to 7, reprogram EE sig if needed
   810D BD AB 17      [ 6]  217         jsr     LAB17           ; erase revalid tape section
   8110 B6 F7 C0      [ 4]  218         ldaa    LF7C0           ; a 00
   8113 B7 04 5C      [ 4]  219         staa    0x045C          ; set to R12 mode?
   8116 7E F8 00      [ 3]  220         jmp     RESET           ; reset!
                            221 
   8119 7E 81 19      [ 3]  222 LOCKUP: jmp     LOCKUP          ; infinite loop
                            223 
                            224 ; CPU test?
   811C                     225 L811C:
   811C 7F 00 79      [ 6]  226         clr     (0x0079)
   811F 7F 00 7C      [ 6]  227         clr     (0x007C)
   8122 BD 04 08      [ 6]  228         jsr     0x0408          ; rts should be here
   8125 BD 80 13      [ 6]  229         jsr     (0x8013)        ; rts is here '9'
   8128 C6 FD         [ 2]  230         ldab    #0xFD           ; tape deck STOP
   812A BD 86 E7      [ 6]  231         jsr     L86E7
   812D C6 DF         [ 2]  232         ldab    #0xDF
   812F BD 87 48      [ 6]  233         jsr     L8748   
   8132 BD 87 91      [ 6]  234         jsr     L8791   
   8135 BD 9A F7      [ 6]  235         jsr     L9AF7
   8138 BD 9C 51      [ 6]  236         jsr     L9C51           ; Reset random motions, init board 7/8 bits
   813B 7F 00 62      [ 6]  237         clr     (0x0062)
   813E BD 99 D9      [ 6]  238         jsr     L99D9
   8141 24 16         [ 3]  239         bcc     L8159           ; if carry clear, test is passed
                            240 
   8143 BD 8D E4      [ 6]  241         jsr     LCDMSG1 
   8146 49 6E 76 61 6C 69   242         .ascis  'Invalid CPU!'
        64 20 43 50 55 A1
                            243 
   8152 86 53         [ 2]  244         ldaa    #0x53
   8154 7E 82 A4      [ 3]  245         jmp     L82A4
   8157 20 FE         [ 3]  246 L8157:  bra     L8157           ; infinite loop
                            247 
   8159                     248 L8159:
   8159 BD A3 54      [ 6]  249         jsr     LA354
   815C 7F 00 AA      [ 6]  250         clr     (0x00AA)
   815F 7D 00 00      [ 6]  251         tst     (0x0000)
   8162 27 15         [ 3]  252         beq     L8179
                            253 
   8164 BD 8D E4      [ 6]  254         jsr     LCDMSG1 
   8167 52 41 4D 20 74 65   255         .ascis  'RAM test failed!'
        73 74 20 66 61 69
        6C 65 64 A1
                            256 
   8177 20 44         [ 3]  257         bra     L81BD
                            258 
   8179                     259 L8179:
   8179 BD 8D E4      [ 6]  260         jsr     LCDMSG1 
   817C 33 32 4B 20 52 41   261         .ascis  '32K RAM OK'
        4D 20 4F CB
                            262 
                            263 ; R12 or CNR mode???
   8186 7D 04 5C      [ 6]  264         tst     (0x045C)        ; if this location is 0, good
   8189 26 08         [ 3]  265         bne     L8193
   818B CC 52 0F      [ 3]  266         ldd     #0x520F         ; else print 'R' on the far left of the first line
   818E BD 8D B5      [ 6]  267         jsr     L8DB5           ; display char here on LCD display
   8191 20 06         [ 3]  268         bra     L8199
   8193                     269 L8193:
   8193 CC 43 0F      [ 3]  270         ldd     #0x430F         ; print 'C' on the far left of the first line
   8196 BD 8D B5      [ 6]  271         jsr     L8DB5           ; display char here on LCD display
                            272 
   8199                     273 L8199:
   8199 BD 8D DD      [ 6]  274         jsr     LCDMSG2 
   819C 52 4F 4D 20 43 68   275         .ascis  'ROM Chksum='
        6B 73 75 6D BD
                            276 
   81A7 BD 97 5F      [ 6]  277         jsr     L975F           ; print the checksum on the LCD
                            278 
   81AA C6 02         [ 2]  279         ldab    #0x02           ; delay 2 secs
   81AC BD 8C 02      [ 6]  280         jsr     DLYSECS         ;
                            281 
   81AF BD 9A 27      [ 6]  282         jsr     L9A27           ; display Serial #
   81B2 BD 9E CC      [ 6]  283         jsr     L9ECC           ; display R and L counts
   81B5 BD 9B 19      [ 6]  284         jsr     L9B19           ; do the random motions if enabled
                            285 
   81B8 C6 02         [ 2]  286         ldab    #0x02           ; delay 2 secs
   81BA BD 8C 02      [ 6]  287         jsr     DLYSECS         ;
                            288 
   81BD                     289 L81BD:
   81BD F6 10 2D      [ 4]  290         ldab    SCCR2           ; disable SCI receive data interrupts
   81C0 C4 DF         [ 2]  291         andb    #0xDF
   81C2 F7 10 2D      [ 4]  292         stab    SCCR2
                            293 
   81C5 BD 9A F7      [ 6]  294         jsr     L9AF7           ; clear a bunch of ram
   81C8 C6 FD         [ 2]  295         ldab    #0xFD           ; tape deck STOP
   81CA BD 86 E7      [ 6]  296         jsr     L86E7           ;
   81CD BD 87 91      [ 6]  297         jsr     L8791           ; Reset AVSEL1
                            298 
   81D0 C6 00         [ 2]  299         ldab    #0x00           ; turn off button lights
   81D2 D7 62         [ 3]  300         stab    (0x0062)
   81D4 BD F9 C5      [ 6]  301         jsr     BUTNLIT
                            302 
   81D7                     303 L81D7:
   81D7 BD 8D E4      [ 6]  304         jsr     LCDMSG1 
   81DA 20 43 79 62 65 72   305         .ascis  ' Cyberstar v1.6'
        73 74 61 72 20 76
        31 2E B6
                            306 
   81E9 BD A2 DF      [ 6]  307         jsr     LA2DF
   81EC 24 11         [ 3]  308         bcc     L81FF
   81EE CC 52 0F      [ 3]  309         ldd     #0x520F
   81F1 BD 8D B5      [ 6]  310         jsr     L8DB5           ; display 'R' at far right of 1st line
   81F4 7D 04 2A      [ 6]  311         tst     (0x042A)
   81F7 27 06         [ 3]  312         beq     L81FF
   81F9 CC 4B 0F      [ 3]  313         ldd     #0x4B0F
   81FC BD 8D B5      [ 6]  314         jsr     L8DB5           ; display 'K' at far right of 1st line
   81FF                     315 L81FF:
   81FF BD 8D 03      [ 6]  316         jsr     L8D03
   8202 FC 02 9C      [ 5]  317         ldd     (0x029C)
   8205 1A 83 00 01   [ 5]  318         cpd     #0x0001
   8209 26 15         [ 3]  319         bne     L8220
                            320 
   820B BD 8D DD      [ 6]  321         jsr     LCDMSG2 
   820E 20 44 61 76 65 27   322         .ascis  " Dave's system  "
        73 20 73 79 73 74
        65 6D 20 A0
                            323 
   821E 20 47         [ 3]  324         bra     L8267
   8220                     325 L8220:
   8220 1A 83 03 E8   [ 5]  326         cpd     #0x03E8
   8224 2D 1B         [ 3]  327         blt     L8241
   8226 1A 83 04 4B   [ 5]  328         cpd     #0x044B
   822A 22 15         [ 3]  329         bhi     L8241
                            330 
   822C BD 8D DD      [ 6]  331         jsr     LCDMSG2 
   822F 20 20 20 53 50 54   332         .ascis  '   SPT Studio   '
        20 53 74 75 64 69
        6F 20 20 A0
                            333 
   823F 20 26         [ 3]  334         bra L8267
                            335 
   8241                     336 L8241:
   8241 CC 0E 0C      [ 3]  337         ldd     #0x0E0C
   8244 DD AD         [ 4]  338         std     (0x00AD)
   8246 FC 04 0D      [ 5]  339         ldd     (0x040D)
   8249 1A 83 02 58   [ 5]  340         cpd     #0x0258         ; 600?
   824D 22 05         [ 3]  341         bhi     L8254
   824F CC 0E 09      [ 3]  342         ldd     #0x0E09
   8252 DD AD         [ 4]  343         std     (0x00AD)
   8254                     344 L8254:
   8254 C6 29         [ 2]  345         ldab    #0x29
   8256 CE 0E 00      [ 3]  346         ldx     #0x0E00
   8259                     347 L8259:
   8259 A6 00         [ 4]  348         ldaa    0,X
   825B 4A            [ 2]  349         deca
   825C 08            [ 3]  350         inx
   825D 5C            [ 2]  351         incb
   825E 3C            [ 4]  352         pshx
   825F BD 8D B5      [ 6]  353         jsr     L8DB5           ; display char here on LCD display
   8262 38            [ 5]  354         pulx
   8263 9C AD         [ 5]  355         cpx     (0x00AD)
   8265 26 F2         [ 3]  356         bne     L8259
   8267                     357 L8267:
   8267 BD 9C 51      [ 6]  358         jsr     L9C51           ; Reset random motions, init board 7/8 bits
   826A 7F 00 5B      [ 6]  359         clr     (0x005B)
   826D 7F 00 5A      [ 6]  360         clr     (0x005A)
   8270 7F 00 5E      [ 6]  361         clr     (0x005E)
   8273 7F 00 60      [ 6]  362         clr     (0x0060)
   8276 BD 9B 19      [ 6]  363         jsr     L9B19           ; do the random motions if enabled
   8279 96 60         [ 3]  364         ldaa    (0x0060)
   827B 27 06         [ 3]  365         beq     L8283
   827D BD A9 7C      [ 6]  366         jsr     LA97C
   8280 7E F8 00      [ 3]  367         jmp     RESET           ; reset controller
   8283                     368 L8283:
   8283 B6 18 04      [ 4]  369         ldaa    PIA0PRA 
   8286 84 06         [ 2]  370         anda    #0x06
   8288 26 08         [ 3]  371         bne     L8292
   828A BD 9C F1      [ 6]  372         jsr     L9CF1           ; print credits
   828D C6 32         [ 2]  373         ldab    #0x32
   828F BD 8C 22      [ 6]  374         jsr     DLYSECSBY100    ; delay 0.5 sec
   8292                     375 L8292:
   8292 BD 8E 95      [ 6]  376         jsr     L8E95
   8295 81 0D         [ 2]  377         cmpa    #0x0D
   8297 26 03         [ 3]  378         bne     L829C
   8299 7E 92 92      [ 3]  379         jmp     L9292
   829C                     380 L829C:
   829C BD F9 45      [ 6]  381         jsr     SERIALR
   829F 25 03         [ 3]  382         bcs     L82A4
   82A1                     383 L82A1:
   82A1 7E 83 33      [ 3]  384         jmp     L8333
   82A4                     385 L82A4:
   82A4 81 44         [ 2]  386         cmpa    #0x44           ;'$'
   82A6 26 03         [ 3]  387         bne     L82AB
   82A8 7E A3 66      [ 3]  388         jmp     LA366           ; go to security code & setup utility
   82AB                     389 L82AB:
   82AB 81 53         [ 2]  390         cmpa    #0x53           ;'S'
   82AD 26 F2         [ 3]  391         bne     L82A1
                            392 
   82AF BD F9 D8      [ 6]  393         jsr     SERMSGW      
   82B2 0A 0D 45 6E 74 65   394         .ascis  '\n\rEnter security code: '
        72 20 73 65 63 75
        72 69 74 79 20 63
        6F 64 65 3A A0
                            395 
   82C9 0F            [ 2]  396         sei
   82CA BD A2 EA      [ 6]  397         jsr     LA2EA
   82CD 0E            [ 2]  398         cli
   82CE 25 61         [ 3]  399         bcs     L8331
                            400 
   82D0 BD F9 D8      [ 6]  401         jsr     SERMSGW      
   82D3 0A 0D 45 45 50 52   402         .ascii '\n\rEEPROM serial number programming enabled.'
        4F 4D 20 73 65 72
        69 61 6C 20 6E 75
        6D 62 65 72 20 70
        72 6F 67 72 61 6D
        6D 69 6E 67 20 65
        6E 61 62 6C 65 64
        2E
   82FE 0A 0D 50 6C 65 61   403         .ascis '\n\rPlease RESET the processor to continue\n\r'
        73 65 20 52 45 53
        45 54 20 74 68 65
        20 70 72 6F 63 65
        73 73 6F 72 20 74
        6F 20 63 6F 6E 74
        69 6E 75 65 0A 8D
                            404 
   8328 86 01         [ 2]  405         ldaa    #0x01           ; enable EEPROM erase
   832A B7 04 0F      [ 4]  406         staa    ERASEFLG
   832D 86 DB         [ 2]  407         ldaa    #0xDB
   832F 97 07         [ 3]  408         staa    (0x0007)
                            409 ; need to reset to get out of this 
   8331 20 FE         [ 3]  410 L8331:  bra     L8331           ; infinite loop
                            411 
   8333                     412 L8333:
   8333 96 AA         [ 3]  413         ldaa    (0x00AA)
   8335 27 12         [ 3]  414         beq     L8349
   8337 DC 1B         [ 4]  415         ldd     CDTIMR1
   8339 26 0E         [ 3]  416         bne     L8349
   833B D6 62         [ 3]  417         ldab    (0x0062)
   833D C8 20         [ 2]  418         eorb    #0x20
   833F D7 62         [ 3]  419         stab    (0x0062)
   8341 BD F9 C5      [ 6]  420         jsr     BUTNLIT 
   8344 CC 00 32      [ 3]  421         ldd     #0x0032
   8347 DD 1B         [ 4]  422         std     CDTIMR1
   8349                     423 L8349:
   8349 BD 86 A4      [ 6]  424         jsr     L86A4
   834C 24 03         [ 3]  425         bcc     L8351
   834E 7E 82 76      [ 3]  426         jmp     (0x8276)
   8351                     427 L8351:
   8351 F6 10 2D      [ 4]  428         ldab    SCCR2  
   8354 CA 20         [ 2]  429         orab    #0x20
   8356 F7 10 2D      [ 4]  430         stab    SCCR2  
   8359 7F 00 AA      [ 6]  431         clr     (0x00AA)
   835C D6 62         [ 3]  432         ldab    (0x0062)
   835E C4 DF         [ 2]  433         andb    #0xDF
   8360 D7 62         [ 3]  434         stab    (0x0062)
   8362 BD F9 C5      [ 6]  435         jsr     BUTNLIT 
   8365 C6 02         [ 2]  436         ldab    #0x02           ; delay 2 secs
   8367 BD 8C 02      [ 6]  437         jsr     DLYSECS         ;
   836A 96 7C         [ 3]  438         ldaa    (0x007C)
   836C 27 2D         [ 3]  439         beq     L839B
   836E 96 7F         [ 3]  440         ldaa    (0x007F)
   8370 97 4E         [ 3]  441         staa    (0x004E)
   8372 D6 81         [ 3]  442         ldab    (0x0081)
   8374 BD 87 48      [ 6]  443         jsr     L8748   
   8377 96 82         [ 3]  444         ldaa    (0x0082)
   8379 85 01         [ 2]  445         bita    #0x01
   837B 26 06         [ 3]  446         bne     L8383
   837D 96 AC         [ 3]  447         ldaa    (0x00AC)
   837F 84 FD         [ 2]  448         anda    #0xFD
   8381 20 04         [ 3]  449         bra     L8387
   8383                     450 L8383:
   8383 96 AC         [ 3]  451         ldaa    (0x00AC)
   8385 8A 02         [ 2]  452         oraa    #0x02
   8387                     453 L8387:
   8387 97 AC         [ 3]  454         staa    (0x00AC)
   8389 B7 18 06      [ 4]  455         staa    PIA0PRB 
   838C B6 18 04      [ 4]  456         ldaa    PIA0PRA 
   838F 8A 20         [ 2]  457         oraa    #0x20
   8391 B7 18 04      [ 4]  458         staa    PIA0PRA 
   8394 84 DF         [ 2]  459         anda    #0xDF
   8396 B7 18 04      [ 4]  460         staa    PIA0PRA 
   8399 20 14         [ 3]  461         bra     L83AF
   839B                     462 L839B:
   839B FC 04 0D      [ 5]  463         ldd     (0x040D)
   839E 1A 83 FD E8   [ 5]  464         cpd     #0xFDE8         ; 65000?
   83A2 22 06         [ 3]  465         bhi     L83AA
   83A4 C3 00 01      [ 4]  466         addd    #0x0001
   83A7 FD 04 0D      [ 5]  467         std     (0x040D)
   83AA                     468 L83AA:
   83AA C6 F7         [ 2]  469         ldab    #0xF7           ; tape deck REWIND
   83AC BD 86 E7      [ 6]  470         jsr     L86E7
   83AF                     471 L83AF:
   83AF 7F 00 30      [ 6]  472         clr     (0x0030)
   83B2 7F 00 31      [ 6]  473         clr     (0x0031)
   83B5 7F 00 32      [ 6]  474         clr     (0x0032)
   83B8 BD 9B 19      [ 6]  475         jsr     L9B19           ; do the random motions if enabled   
   83BB BD 86 A4      [ 6]  476         jsr     L86A4
   83BE 25 EF         [ 3]  477         bcs     L83AF
   83C0 96 79         [ 3]  478         ldaa    (0x0079)
   83C2 27 17         [ 3]  479         beq     L83DB
   83C4 7F 00 79      [ 6]  480         clr     (0x0079)
   83C7 96 B5         [ 3]  481         ldaa    (0x00B5)
   83C9 81 01         [ 2]  482         cmpa    #0x01
   83CB 26 07         [ 3]  483         bne     L83D4
   83CD 7F 00 B5      [ 6]  484         clr     (0x00B5)
   83D0 86 01         [ 2]  485         ldaa    #0x01
   83D2 97 7C         [ 3]  486         staa    (0x007C)
   83D4                     487 L83D4:
   83D4 86 01         [ 2]  488         ldaa    #0x01
   83D6 97 AA         [ 3]  489         staa    (0x00AA)
   83D8 7E 9A 7F      [ 3]  490         jmp     L9A7F
   83DB                     491 L83DB:
   83DB BD 8D E4      [ 6]  492         jsr     LCDMSG1 
   83DE 20 20 20 54 61 70   493         .ascis  '   Tape start   '
        65 20 73 74 61 72
        74 20 20 A0
                            494 
   83EE D6 62         [ 3]  495         ldab    (0x0062)
   83F0 CA 80         [ 2]  496         orab    #0x80
   83F2 D7 62         [ 3]  497         stab    (0x0062)
   83F4 BD F9 C5      [ 6]  498         jsr     BUTNLIT 
   83F7 C6 FB         [ 2]  499         ldab    #0xFB           ; tape deck PLAY
   83F9 BD 86 E7      [ 6]  500         jsr     L86E7
                            501 
   83FC BD 8D CF      [ 6]  502         jsr     LCDMSG1A
   83FF 36 38 48 43 31 31   503         .ascis  '68HC11 Proto'
        20 50 72 6F 74 EF
                            504 
   840B BD 8D D6      [ 6]  505         jsr     LCDMSG2A
   840E 64 62 F0            506         .ascis  'dbp'
                            507 
   8411 C6 03         [ 2]  508         ldab    #0x03           ; delay 3 secs
   8413 BD 8C 02      [ 6]  509         jsr     DLYSECS         ;
   8416 7D 00 7C      [ 6]  510         tst     (0x007C)
   8419 27 15         [ 3]  511         beq     L8430
   841B D6 80         [ 3]  512         ldab    (0x0080)
   841D D7 62         [ 3]  513         stab    (0x0062)
   841F BD F9 C5      [ 6]  514         jsr     BUTNLIT 
   8422 D6 7D         [ 3]  515         ldab    (0x007D)
   8424 D7 78         [ 3]  516         stab    (0x0078)
   8426 D6 7E         [ 3]  517         ldab    (0x007E)
   8428 F7 10 8A      [ 4]  518         stab    (0x108A)
   842B 7F 00 7C      [ 6]  519         clr     (0x007C)
   842E 20 1D         [ 3]  520         bra     L844D
   8430                     521 L8430:
   8430 BD 8D 03      [ 6]  522         jsr     L8D03
   8433 BD 9D 18      [ 6]  523         jsr     L9D18
   8436 24 08         [ 3]  524         bcc     L8440
   8438 7D 00 B8      [ 6]  525         tst     (0x00B8)
   843B 27 F3         [ 3]  526         beq     L8430
   843D 7E 9A 60      [ 3]  527         jmp     L9A60
   8440                     528 L8440:
   8440 7D 00 B8      [ 6]  529         tst     (0x00B8)
   8443 27 EB         [ 3]  530         beq     L8430
   8445 7F 00 30      [ 6]  531         clr     (0x0030)
   8448 7F 00 31      [ 6]  532         clr     (0x0031)
   844B 20 00         [ 3]  533         bra     L844D
   844D                     534 L844D:
   844D 96 49         [ 3]  535         ldaa    (0x0049)
   844F 26 03         [ 3]  536         bne     L8454
   8451 7E 85 A4      [ 3]  537         jmp     L85A4
   8454                     538 L8454:
   8454 7F 00 49      [ 6]  539         clr     (0x0049)
   8457 81 31         [ 2]  540         cmpa    #0x31
   8459 26 08         [ 3]  541         bne     L8463
   845B BD A3 26      [ 6]  542         jsr     LA326
   845E BD 8D 42      [ 6]  543         jsr     L8D42
   8461 20 EA         [ 3]  544         bra     L844D
   8463                     545 L8463:
   8463 81 32         [ 2]  546         cmpa    #0x32
   8465 26 08         [ 3]  547         bne     L846F
   8467 BD A3 26      [ 6]  548         jsr     LA326
   846A BD 8D 35      [ 6]  549         jsr     L8D35
   846D 20 DE         [ 3]  550         bra     L844D
   846F                     551 L846F:
   846F 81 54         [ 2]  552         cmpa    #0x54
   8471 26 08         [ 3]  553         bne     L847B
   8473 BD A3 26      [ 6]  554         jsr     LA326
   8476 BD 8D 42      [ 6]  555         jsr     L8D42
   8479 20 D2         [ 3]  556         bra     L844D
   847B                     557 L847B:
   847B 81 5A         [ 2]  558         cmpa    #0x5A
   847D 26 1C         [ 3]  559         bne     L849B
   847F                     560 L847F:
   847F BD A3 1E      [ 6]  561         jsr     LA31E
   8482 BD 8E 95      [ 6]  562         jsr     L8E95
   8485 7F 00 32      [ 6]  563         clr     (0x0032)
   8488 7F 00 31      [ 6]  564         clr     (0x0031)
   848B 7F 00 30      [ 6]  565         clr     (0x0030)
   848E BD 99 A6      [ 6]  566         jsr     L99A6
   8491 D6 7B         [ 3]  567         ldab    (0x007B)
   8493 CA 0C         [ 2]  568         orab    #0x0C
   8495 BD 87 48      [ 6]  569         jsr     L8748   
   8498 7E 81 BD      [ 3]  570         jmp     L81BD
   849B                     571 L849B:
   849B 81 42         [ 2]  572         cmpa    #0x42
   849D 26 03         [ 3]  573         bne     L84A2
   849F 7E 98 3C      [ 3]  574         jmp     L983C
   84A2                     575 L84A2:
   84A2 81 4D         [ 2]  576         cmpa    #0x4D
   84A4 26 03         [ 3]  577         bne     L84A9
   84A6 7E 98 24      [ 3]  578         jmp     L9824
   84A9                     579 L84A9:
   84A9 81 45         [ 2]  580         cmpa    #0x45
   84AB 26 03         [ 3]  581         bne     L84B0
   84AD 7E 98 02      [ 3]  582         jmp     L9802
   84B0                     583 L84B0:
   84B0 81 58         [ 2]  584         cmpa    #0x58
   84B2 26 05         [ 3]  585         bne     L84B9
   84B4 7E 99 3F      [ 3]  586         jmp     L993F
   84B7 20 94         [ 3]  587         bra     L844D
   84B9                     588 L84B9:
   84B9 81 46         [ 2]  589         cmpa    #0x46
   84BB 26 03         [ 3]  590         bne     L84C0
   84BD 7E 99 71      [ 3]  591         jmp     L9971
   84C0                     592 L84C0:
   84C0 81 47         [ 2]  593         cmpa    #0x47
   84C2 26 03         [ 3]  594         bne     L84C7
   84C4 7E 99 7B      [ 3]  595         jmp     L997B
   84C7                     596 L84C7:
   84C7 81 48         [ 2]  597         cmpa    #0x48
   84C9 26 03         [ 3]  598         bne     L84CE
   84CB 7E 99 85      [ 3]  599         jmp     L9985
   84CE                     600 L84CE:
   84CE 81 49         [ 2]  601         cmpa    #0x49
   84D0 26 03         [ 3]  602         bne     L84D5
   84D2 7E 99 8F      [ 3]  603         jmp     L998F
   84D5                     604 L84D5:
   84D5 81 53         [ 2]  605         cmpa    #0x53
   84D7 26 03         [ 3]  606         bne     L84DC
   84D9 7E 97 BA      [ 3]  607         jmp     L97BA
   84DC                     608 L84DC:
   84DC 81 59         [ 2]  609         cmpa    #0x59
   84DE 26 03         [ 3]  610         bne     L84E3
   84E0 7E 99 D2      [ 3]  611         jmp     L99D2
   84E3                     612 L84E3:
   84E3 81 57         [ 2]  613         cmpa    #0x57
   84E5 26 03         [ 3]  614         bne     L84EA
   84E7 7E 9A A4      [ 3]  615         jmp     L9AA4
   84EA                     616 L84EA:
   84EA 81 41         [ 2]  617         cmpa    #0x41
   84EC 26 17         [ 3]  618         bne     L8505
   84EE BD 9D 18      [ 6]  619         jsr     L9D18
   84F1 25 09         [ 3]  620         bcs     L84FC
   84F3 7F 00 30      [ 6]  621         clr     (0x0030)
   84F6 7F 00 31      [ 6]  622         clr     (0x0031)
   84F9 7E 85 A4      [ 3]  623         jmp     L85A4
   84FC                     624 L84FC:
   84FC 7F 00 30      [ 6]  625         clr     (0x0030)
   84FF 7F 00 31      [ 6]  626         clr     (0x0031)
   8502 7E 9A 7F      [ 3]  627         jmp     L9A7F
   8505                     628 L8505:
   8505 81 4B         [ 2]  629         cmpa    #0x4B
   8507 26 0B         [ 3]  630         bne     L8514
   8509 BD 9D 18      [ 6]  631         jsr     L9D18
   850C 25 03         [ 3]  632         bcs     L8511
   850E 7E 85 A4      [ 3]  633         jmp     L85A4
   8511                     634 L8511:
   8511 7E 9A 7F      [ 3]  635         jmp     L9A7F
   8514                     636 L8514:
   8514 81 4A         [ 2]  637         cmpa    #0x4A
   8516 26 07         [ 3]  638         bne     L851F
   8518 86 01         [ 2]  639         ldaa    #0x01
   851A 97 AF         [ 3]  640         staa    (0x00AF)
   851C 7E 98 3C      [ 3]  641         jmp     L983C
   851F                     642 L851F:
   851F 81 4E         [ 2]  643         cmpa    #0x4E
   8521 26 0B         [ 3]  644         bne     L852E
   8523 B6 10 8A      [ 4]  645         ldaa    (0x108A)
   8526 8A 02         [ 2]  646         oraa    #0x02
   8528 B7 10 8A      [ 4]  647         staa    (0x108A)
   852B 7E 84 4D      [ 3]  648         jmp     L844D
   852E                     649 L852E:
   852E 81 4F         [ 2]  650         cmpa    #0x4F
   8530 26 06         [ 3]  651         bne     L8538
   8532 BD 9D 18      [ 6]  652         jsr     L9D18
   8535 7E 84 4D      [ 3]  653         jmp     L844D
   8538                     654 L8538:
   8538 81 50         [ 2]  655         cmpa    #0x50
   853A 26 06         [ 3]  656         bne     L8542
   853C BD 9D 18      [ 6]  657         jsr     L9D18
   853F 7E 84 4D      [ 3]  658         jmp     L844D
   8542                     659 L8542:
   8542 81 51         [ 2]  660         cmpa    #0x51
   8544 26 0B         [ 3]  661         bne     L8551
   8546 B6 10 8A      [ 4]  662         ldaa    (0x108A)
   8549 8A 04         [ 2]  663         oraa    #0x04
   854B B7 10 8A      [ 4]  664         staa    (0x108A)
   854E 7E 84 4D      [ 3]  665         jmp     L844D
   8551                     666 L8551:
   8551 81 55         [ 2]  667         cmpa    #0x55
   8553 26 07         [ 3]  668         bne     L855C
   8555 C6 01         [ 2]  669         ldab    #0x01
   8557 D7 B6         [ 3]  670         stab    (0x00B6)
   8559 7E 84 4D      [ 3]  671         jmp     L844D
   855C                     672 L855C:
   855C 81 4C         [ 2]  673         cmpa    #0x4C
   855E 26 19         [ 3]  674         bne     L8579
   8560 7F 00 49      [ 6]  675         clr     (0x0049)
   8563 BD 9D 18      [ 6]  676         jsr     L9D18
   8566 25 0E         [ 3]  677         bcs     L8576
   8568 BD AA E8      [ 6]  678         jsr     LAAE8
   856B BD AB 56      [ 6]  679         jsr     LAB56
   856E 24 06         [ 3]  680         bcc     L8576
   8570 BD AB 25      [ 6]  681         jsr     LAB25
   8573 BD AB 46      [ 6]  682         jsr     LAB46
   8576                     683 L8576:
   8576 7E 84 4D      [ 3]  684         jmp     L844D
   8579                     685 L8579:
   8579 81 52         [ 2]  686         cmpa    #0x52
   857B 26 1A         [ 3]  687         bne     L8597
   857D 7F 00 49      [ 6]  688         clr     (0x0049)
   8580 BD 9D 18      [ 6]  689         jsr     L9D18
   8583 25 0F         [ 3]  690         bcs     L8594
   8585 BD AA E8      [ 6]  691         jsr     LAAE8
   8588 BD AB 56      [ 6]  692         jsr     LAB56
   858B 25 07         [ 3]  693         bcs     L8594
   858D 86 FF         [ 2]  694         ldaa    #0xFF
   858F A7 00         [ 4]  695         staa    0,X
   8591 BD AA E8      [ 6]  696         jsr     LAAE8
   8594                     697 L8594:
   8594 7E 84 4D      [ 3]  698         jmp     L844D
   8597                     699 L8597:
   8597 81 44         [ 2]  700         cmpa    #0x44
   8599 26 09         [ 3]  701         bne     L85A4
   859B 7F 00 49      [ 6]  702         clr     (0x0049)
   859E BD AB AE      [ 6]  703         jsr     LABAE
   85A1 7E 84 4D      [ 3]  704         jmp     L844D
   85A4                     705 L85A4:
   85A4 7D 00 75      [ 6]  706         tst     (0x0075)
   85A7 26 56         [ 3]  707         bne     L85FF
   85A9 7D 00 79      [ 6]  708         tst     (0x0079)
   85AC 26 51         [ 3]  709         bne     L85FF
   85AE 7D 00 30      [ 6]  710         tst     (0x0030)
   85B1 26 07         [ 3]  711         bne     L85BA
   85B3 96 5B         [ 3]  712         ldaa    (0x005B)
   85B5 27 48         [ 3]  713         beq     L85FF
   85B7 7F 00 5B      [ 6]  714         clr     (0x005B)
   85BA                     715 L85BA:
   85BA CC 00 64      [ 3]  716         ldd     #0x0064
   85BD DD 23         [ 4]  717         std     CDTIMR5
   85BF                     718 L85BF:
   85BF DC 23         [ 4]  719         ldd     CDTIMR5
   85C1 27 14         [ 3]  720         beq     L85D7
   85C3 BD 9B 19      [ 6]  721         jsr     L9B19           ; do the random motions if enabled
   85C6 B6 18 04      [ 4]  722         ldaa    PIA0PRA 
   85C9 88 FF         [ 2]  723         eora    #0xFF
   85CB 84 06         [ 2]  724         anda    #0x06
   85CD 81 06         [ 2]  725         cmpa    #0x06
   85CF 26 EE         [ 3]  726         bne     L85BF
   85D1 7F 00 30      [ 6]  727         clr     (0x0030)
   85D4 7E 86 80      [ 3]  728         jmp     L8680
   85D7                     729 L85D7:
   85D7 7F 00 30      [ 6]  730         clr     (0x0030)
   85DA D6 62         [ 3]  731         ldab    (0x0062)
   85DC C8 02         [ 2]  732         eorb    #0x02
   85DE D7 62         [ 3]  733         stab    (0x0062)
   85E0 BD F9 C5      [ 6]  734         jsr     BUTNLIT 
   85E3 C4 02         [ 2]  735         andb    #0x02
   85E5 27 0D         [ 3]  736         beq     L85F4
   85E7 BD AA 18      [ 6]  737         jsr     LAA18
   85EA C6 1E         [ 2]  738         ldab    #0x1E
   85EC BD 8C 22      [ 6]  739         jsr     DLYSECSBY100    ; delay 0.3 sec
   85EF 7F 00 30      [ 6]  740         clr     (0x0030)
   85F2 20 0B         [ 3]  741         bra     L85FF
   85F4                     742 L85F4:
   85F4 BD AA 1D      [ 6]  743         jsr     LAA1D
   85F7 C6 1E         [ 2]  744         ldab    #0x1E
   85F9 BD 8C 22      [ 6]  745         jsr     DLYSECSBY100    ; delay 0.3 sec
   85FC 7F 00 30      [ 6]  746         clr     (0x0030)
   85FF                     747 L85FF:
   85FF BD 9B 19      [ 6]  748         jsr     L9B19           ; do the random motions if enabled
   8602 B6 10 0A      [ 4]  749         ldaa    PORTE
   8605 84 10         [ 2]  750         anda    #0x10
   8607 27 0B         [ 3]  751         beq     L8614
   8609 B6 18 04      [ 4]  752         ldaa    PIA0PRA 
   860C 88 FF         [ 2]  753         eora    #0xFF
   860E 84 07         [ 2]  754         anda    #0x07
   8610 81 06         [ 2]  755         cmpa    #0x06
   8612 26 1C         [ 3]  756         bne     L8630
   8614                     757 L8614:
   8614 7D 00 76      [ 6]  758         tst     (0x0076)
   8617 26 17         [ 3]  759         bne     L8630
   8619 7D 00 75      [ 6]  760         tst     (0x0075)
   861C 26 12         [ 3]  761         bne     L8630
   861E D6 62         [ 3]  762         ldab    (0x0062)
   8620 C4 FC         [ 2]  763         andb    #0xFC
   8622 D7 62         [ 3]  764         stab    (0x0062)
   8624 BD F9 C5      [ 6]  765         jsr     BUTNLIT 
   8627 BD AA 13      [ 6]  766         jsr     LAA13
   862A BD AA 1D      [ 6]  767         jsr     LAA1D
   862D 7E 9A 60      [ 3]  768         jmp     L9A60
   8630                     769 L8630:
   8630 7D 00 31      [ 6]  770         tst     (0x0031)
   8633 26 07         [ 3]  771         bne     L863C
   8635 96 5A         [ 3]  772         ldaa    (0x005A)
   8637 27 47         [ 3]  773         beq     L8680
   8639 7F 00 5A      [ 6]  774         clr     (0x005A)
   863C                     775 L863C:
   863C CC 00 64      [ 3]  776         ldd     #0x0064
   863F DD 23         [ 4]  777         std     CDTIMR5
   8641                     778 L8641:
   8641 DC 23         [ 4]  779         ldd     CDTIMR5
   8643 27 13         [ 3]  780         beq     L8658
   8645 BD 9B 19      [ 6]  781         jsr     L9B19           ; do the random motions if enabled
   8648 B6 18 04      [ 4]  782         ldaa    PIA0PRA 
   864B 88 FF         [ 2]  783         eora    #0xFF
   864D 84 06         [ 2]  784         anda    #0x06
   864F 81 06         [ 2]  785         cmpa    #0x06
   8651 26 EE         [ 3]  786         bne     L8641
   8653 7F 00 31      [ 6]  787         clr     (0x0031)
   8656 20 28         [ 3]  788         bra     L8680
   8658                     789 L8658:
   8658 7F 00 31      [ 6]  790         clr     (0x0031)
   865B D6 62         [ 3]  791         ldab    (0x0062)
   865D C8 01         [ 2]  792         eorb    #0x01
   865F D7 62         [ 3]  793         stab    (0x0062)
   8661 BD F9 C5      [ 6]  794         jsr     BUTNLIT 
   8664 C4 01         [ 2]  795         andb    #0x01
   8666 27 0D         [ 3]  796         beq     L8675
   8668 BD AA 0C      [ 6]  797         jsr     LAA0C
   866B C6 1E         [ 2]  798         ldab    #0x1E
   866D BD 8C 22      [ 6]  799         jsr     DLYSECSBY100    ; delay 0.3 sec
   8670 7F 00 31      [ 6]  800         clr     (0x0031)
   8673 20 0B         [ 3]  801         bra     L8680
   8675                     802 L8675:
   8675 BD AA 13      [ 6]  803         jsr     LAA13
   8678 C6 1E         [ 2]  804         ldab    #0x1E
   867A BD 8C 22      [ 6]  805         jsr     DLYSECSBY100    ; delay 0.3 sec
   867D 7F 00 31      [ 6]  806         clr     (0x0031)
   8680                     807 L8680:
   8680 BD 86 A4      [ 6]  808         jsr     L86A4
   8683 25 1C         [ 3]  809         bcs     L86A1
   8685 7F 00 4E      [ 6]  810         clr     (0x004E)
   8688 BD 99 A6      [ 6]  811         jsr     L99A6
   868B BD 86 C4      [ 6]  812         jsr     L86C4           ; Reset boards 1-10
   868E 5F            [ 2]  813         clrb
   868F D7 62         [ 3]  814         stab    (0x0062)
   8691 BD F9 C5      [ 6]  815         jsr     BUTNLIT 
   8694 C6 FD         [ 2]  816         ldab    #0xFD           ; tape deck STOP
   8696 BD 86 E7      [ 6]  817         jsr     L86E7
   8699 C6 04         [ 2]  818         ldab    #0x04           ; delay 4 secs
   869B BD 8C 02      [ 6]  819         jsr     DLYSECS         ;
   869E 7E 84 7F      [ 3]  820         jmp     L847F
   86A1                     821 L86A1:
   86A1 7E 84 4D      [ 3]  822         jmp     L844D
   86A4                     823 L86A4:
   86A4 BD 9B 19      [ 6]  824         jsr     L9B19           ; do the random motions if enabled
   86A7 7F 00 23      [ 6]  825         clr     CDTIMR5
   86AA 86 19         [ 2]  826         ldaa    #0x19
   86AC 97 24         [ 3]  827         staa    CDTIMR5+1
   86AE B6 10 0A      [ 4]  828         ldaa    PORTE
   86B1 84 80         [ 2]  829         anda    #0x80
   86B3 27 02         [ 3]  830         beq     L86B7
   86B5                     831 L86B5:
   86B5 0D            [ 2]  832         sec
   86B6 39            [ 5]  833         rts
                            834 
   86B7                     835 L86B7:
   86B7 B6 10 0A      [ 4]  836         ldaa    PORTE
   86BA 84 80         [ 2]  837         anda    #0x80
   86BC 26 F7         [ 3]  838         bne     L86B5
   86BE 96 24         [ 3]  839         ldaa    CDTIMR5+1
   86C0 26 F5         [ 3]  840         bne     L86B7
   86C2 0C            [ 2]  841         clc
   86C3 39            [ 5]  842         rts
                            843 
                            844 ; Reset boards 1-10 at:
                            845 ;         0x1080, 0x1084, 0x1088, 0x108c
                            846 ;         0x1090, 0x1094, 0x1098, 0x109c
                            847 ;         0x10a0, 0x10a4
                            848 
   86C4                     849 L86C4:
   86C4 CE 10 80      [ 3]  850         ldx     #0x1080
   86C7                     851 L86C7:
   86C7 86 30         [ 2]  852         ldaa    #0x30
   86C9 A7 01         [ 4]  853         staa    1,X             ; 0x30 -> PIAxCRA, CA2 low, DDR
   86CB A7 03         [ 4]  854         staa    3,X             ; 0x30 -> PIAxCRB, CB2 low, DDR
   86CD 86 FF         [ 2]  855         ldaa    #0xFF
   86CF A7 00         [ 4]  856         staa    0,X             ; 0xFF -> PIAxDDRA, all outputs
   86D1 A7 02         [ 4]  857         staa    2,X             ; 0xFF -> PIAxDDRB, all outputs
   86D3 86 34         [ 2]  858         ldaa    #0x34
   86D5 A7 01         [ 4]  859         staa    1,X             ; 0x34 -> PIAxCRA, CA2 low, PR
   86D7 A7 03         [ 4]  860         staa    3,X             ; 0x34 -> PIAxCRB, CA2 low, PR
   86D9 6F 00         [ 6]  861         clr     0,X             ; 0x00 -> PIAxPRA, all outputs low
   86DB 6F 02         [ 6]  862         clr     2,X             ; 0x00 -> PIAxPRB, all outputs low
   86DD 08            [ 3]  863         inx
   86DE 08            [ 3]  864         inx
   86DF 08            [ 3]  865         inx
   86E0 08            [ 3]  866         inx
   86E1 8C 10 A4      [ 4]  867         cpx     #0x10A4
   86E4 2F E1         [ 3]  868         ble     L86C7
   86E6 39            [ 5]  869         rts
                            870 
                            871 ; Set the tape deck to STOP, PLAY, REWIND, or EJECT
                            872 ;                B =   0xFD, 0xFB,   0xF7, or  0xEF
   86E7                     873 L86E7:
   86E7 36            [ 3]  874         psha
   86E8 BD 9B 19      [ 6]  875         jsr     L9B19           ; do the random motions if enabled
   86EB 96 AC         [ 3]  876         ldaa    (0x00AC)        ; A = diag buffer?
   86ED C1 FB         [ 2]  877         cmpb    #0xFB           ; if bit 2 of B is 0 (PLAY)
   86EF 26 04         [ 3]  878         bne     L86F5
   86F1 84 FE         [ 2]  879         anda    #0xFE           ; clear A bit 0 (top)
   86F3 20 0E         [ 3]  880         bra     L8703
   86F5                     881 L86F5:
   86F5 C1 F7         [ 2]  882         cmpb    #0xF7           ; if bit 3 of B is 0 (REWIND)
   86F7 26 04         [ 3]  883         bne     L86FD
   86F9 84 BF         [ 2]  884         anda    #0xBF           ; clear A bit 6 (middle)
   86FB 20 06         [ 3]  885         bra     L8703
   86FD                     886 L86FD:
   86FD C1 FD         [ 2]  887         cmpb    #0xFD           ; if bit 1 of B is 0 (STOP)
   86FF 26 02         [ 3]  888         bne     L8703
   8701 84 F7         [ 2]  889         anda    #0xF7           ; clear A bit 3 (bottom)
   8703                     890 L8703:
   8703 97 AC         [ 3]  891         staa    (0x00AC)        ; update diag display buffer
   8705 B7 18 06      [ 4]  892         staa    PIA0PRB         ; init bus based on A
   8708 BD 87 3A      [ 6]  893         jsr     L873A           ; clock diagnostic indicator
   870B 96 7A         [ 3]  894         ldaa    (0x007A)        ; buffer for tape deck / av switcher?
   870D 84 01         [ 2]  895         anda    #0x01           ; preserve a/v switcher bit
   870F 97 7A         [ 3]  896         staa    (0x007A)        ; 
   8711 C4 FE         [ 2]  897         andb    #0xFE           ; set bits 7-1 based on B arg
   8713 DA 7A         [ 3]  898         orab    (0x007A)        
   8715 F7 18 06      [ 4]  899         stab    PIA0PRB         ; put that on the bus
   8718 BD 87 75      [ 6]  900         jsr     L8775           ; clock the tape deck
   871B C6 32         [ 2]  901         ldab    #0x32
   871D BD 8C 22      [ 6]  902         jsr     DLYSECSBY100    ; delay 0.5 sec
   8720 C6 FE         [ 2]  903         ldab    #0xFE
   8722 DA 7A         [ 3]  904         orab    (0x007A)        ; all tape bits off
   8724 F7 18 06      [ 4]  905         stab    PIA0PRB         ; unpress tape buttons
   8727 D7 7A         [ 3]  906         stab    (0x007A)
   8729 BD 87 75      [ 6]  907         jsr     L8775           ; clock the tape deck
   872C 96 AC         [ 3]  908         ldaa    (0x00AC)
   872E 8A 49         [ 2]  909         oraa    #0x49           ; reset bits top,mid,bot
   8730 97 AC         [ 3]  910         staa    (0x00AC)
   8732 B7 18 06      [ 4]  911         staa    PIA0PRB 
   8735 BD 87 3A      [ 6]  912         jsr     L873A           ; clock diagnostic indicator
   8738 32            [ 4]  913         pula
   8739 39            [ 5]  914         rts
                            915 
                            916 ; clock diagnostic indicator
   873A                     917 L873A:
   873A B6 18 04      [ 4]  918         ldaa    PIA0PRA 
   873D 8A 20         [ 2]  919         oraa    #0x20
   873F B7 18 04      [ 4]  920         staa    PIA0PRA 
   8742 84 DF         [ 2]  921         anda    #0xDF
   8744 B7 18 04      [ 4]  922         staa    PIA0PRA 
   8747 39            [ 5]  923         rts
                            924 
   8748                     925 L8748:
   8748 36            [ 3]  926         psha
   8749 37            [ 3]  927         pshb
   874A 96 AC         [ 3]  928         ldaa    (0x00AC)        ; update state machine at AC?
                            929                                 ;      gfedcba
   874C 8A 30         [ 2]  930         oraa    #0x30           ; set bb11bbbb
   874E 84 FD         [ 2]  931         anda    #0xFD           ; clr bb11bb0b
   8750 C5 20         [ 2]  932         bitb    #0x20           ; tst bit 5 (f)
   8752 26 02         [ 3]  933         bne     L8756           ; 
   8754 8A 02         [ 2]  934         oraa    #0x02           ; set bit 1 (b)
   8756                     935 L8756:
   8756 C5 04         [ 2]  936         bitb    #0x04           ; tst bit 2 (c)
   8758 26 02         [ 3]  937         bne     L875C
   875A 84 EF         [ 2]  938         anda    #0xEF           ; clr bit 4 (e)
   875C                     939 L875C:
   875C C5 08         [ 2]  940         bitb    #0x08           ; tst bit 3 (d)
   875E 26 02         [ 3]  941         bne     L8762
   8760 84 DF         [ 2]  942         anda    #0xDF           ; clr bit 5 (f)
   8762                     943 L8762:
   8762 B7 18 06      [ 4]  944         staa    PIA0PRB 
   8765 97 AC         [ 3]  945         staa    (0x00AC)
   8767 BD 87 3A      [ 6]  946         jsr     L873A           ; clock diagnostic indicator
   876A 33            [ 4]  947         pulb
   876B F7 18 06      [ 4]  948         stab    PIA0PRB 
   876E D7 7B         [ 3]  949         stab    (0x007B)
   8770 BD 87 83      [ 6]  950         jsr     L8783
   8773 32            [ 4]  951         pula
   8774 39            [ 5]  952         rts
                            953 
                            954 ; High pulse on CB2, clock bits0-4 - 4 tape deck and 1 A/V switcher bit
   8775                     955 L8775:
   8775 B6 18 07      [ 4]  956         ldaa    PIA0CRB 
   8778 8A 38         [ 2]  957         oraa    #0x38           
   877A B7 18 07      [ 4]  958         staa    PIA0CRB         ; CB2 High
   877D 84 F7         [ 2]  959         anda    #0xF7
   877F B7 18 07      [ 4]  960         staa    PIA0CRB         ; CB2 Low
   8782 39            [ 5]  961         rts
                            962 
                            963 ; High pulse on CA2
   8783                     964 L8783:
   8783 B6 18 05      [ 4]  965         ldaa    PIA0CRA 
   8786 8A 38         [ 2]  966         oraa    #0x38
   8788 B7 18 05      [ 4]  967         staa    PIA0CRA         ; CA2 High
   878B 84 F7         [ 2]  968         anda    #0xF7
   878D B7 18 05      [ 4]  969         staa    PIA0CRA         ; CA2 High
   8790 39            [ 5]  970         rts
                            971 
                            972 ; AVSEL1 = 0
   8791                     973 L8791:
   8791 96 7A         [ 3]  974         ldaa    (0x007A)
   8793 84 FE         [ 2]  975         anda    #0xFE
   8795 36            [ 3]  976         psha
   8796 96 AC         [ 3]  977         ldaa    (0x00AC)
   8798 8A 04         [ 2]  978         oraa    #0x04           ; clear segment C (lower right)
   879A 97 AC         [ 3]  979         staa    (0x00AC)
   879C 32            [ 4]  980         pula
   879D                     981 L879D:
   879D 97 7A         [ 3]  982         staa    (0x007A)        
   879F B7 18 06      [ 4]  983         staa    PIA0PRB 
   87A2 BD 87 75      [ 6]  984         jsr     L8775           ; AVSEL1 = low
   87A5 96 AC         [ 3]  985         ldaa    (0x00AC)
   87A7 B7 18 06      [ 4]  986         staa    PIA0PRB 
   87AA BD 87 3A      [ 6]  987         jsr     L873A           ; clock diagnostic indicator
   87AD 39            [ 5]  988         rts
                            989 
   87AE                     990 L87AE:
   87AE 96 7A         [ 3]  991         ldaa    (0x007A)
   87B0 8A 01         [ 2]  992         oraa    #0x01
   87B2 36            [ 3]  993         psha
   87B3 96 AC         [ 3]  994         ldaa    (0x00AC)
   87B5 84 FB         [ 2]  995         anda    #0xFB
   87B7 97 AC         [ 3]  996         staa    (0x00AC)
   87B9 32            [ 4]  997         pula
   87BA 20 E1         [ 3]  998         bra     L879D
                            999 
   87BC                    1000 L87BC:
   87BC CE 87 D2      [ 3] 1001         ldx     #L87D2
   87BF                    1002 L87BF:
   87BF A6 00         [ 4] 1003         ldaa    0,X
   87C1 81 FF         [ 2] 1004         cmpa    #0xFF
   87C3 27 0C         [ 3] 1005         beq     L87D1
   87C5 08            [ 3] 1006         inx
   87C6 B7 18 0D      [ 4] 1007         staa    SCCCTRLB
   87C9 A6 00         [ 4] 1008         ldaa    0,X
   87CB 08            [ 3] 1009         inx
   87CC B7 18 0D      [ 4] 1010         staa    SCCCTRLB
   87CF 20 EE         [ 3] 1011         bra     L87BF
   87D1                    1012 L87D1:
   87D1 39            [ 5] 1013         rts
                           1014 
                           1015 ; data table, sync data init
   87D2                    1016 L87D2:
   87D2 09 8A              1017         .byte   0x09,0x8a       ; channel reset B, MIE on, DLC off, no vector
   87D4 01 00              1018         .byte   0x01,0x00       ; irq on special condition only
   87D6 0C 18              1019         .byte   0x0c,0x18       ; Lower byte of time constant
   87D8 0D 00              1020         .byte   0x0d,0x00       ; Upper byte of time constant
   87DA 04 44              1021         .byte   0x04,0x44       ; X16 clock mode, 8-bit sync char, 1 stop bit, no parity
   87DC 0E 63              1022         .byte   0x0e,0x63       ; Disable DPLL, BR enable & source
   87DE 05 68              1023         .byte   0x05,0x68       ; No DTR/RTS, Tx 8 bits/char, Tx enable
   87E0 0B 56              1024         .byte   0x0b,0x56       ; Rx & Tx & TRxC clk from BR gen
   87E2 03 C1              1025         .byte   0x03,0xc1       ; Rx 8 bits/char, Rx Enable
                           1026         ;   tc = 4Mhz / (2 * DesiredRate * BRClockPeriod) - 2
                           1027         ;   DesiredRate=~4800 bps with tc=0x18 and BRClockPeriod=16
   87E4 0F 00              1028         .byte   0x0f,0x00       ; end of table marker
   87E6 FF FF              1029         .byte   0xff,0xff
                           1030 
                           1031 ; SCC init, aux serial
   87E8                    1032 L87E8:
   87E8 CE F8 57      [ 3] 1033         ldx     #LF857
   87EB                    1034 L87EB:
   87EB A6 00         [ 4] 1035         ldaa    0,X
   87ED 81 FF         [ 2] 1036         cmpa    #0xFF
   87EF 27 0C         [ 3] 1037         beq     L87FD
   87F1 08            [ 3] 1038         inx
   87F2 B7 18 0C      [ 4] 1039         staa    SCCCTRLA
   87F5 A6 00         [ 4] 1040         ldaa    0,X
   87F7 08            [ 3] 1041         inx
   87F8 B7 18 0C      [ 4] 1042         staa    SCCCTRLA
   87FB 20 EE         [ 3] 1043         bra     L87EB
   87FD                    1044 L87FD:
   87FD 20 16         [ 3] 1045         bra     L8815
                           1046 
                           1047 ; data table for aux serial config
   87FF 09 8A              1048         .byte   0x09,0x8a
   8801 01 10              1049         .byte   0x01,0x10
   8803 0C 18              1050         .byte   0x0c,0x18
   8805 0D 00              1051         .byte   0x0d,0x00
   8807 04 04              1052         .byte   0x04,0x04
   8809 0E 63              1053         .byte   0x0e,0x63
   880B 05 68              1054         .byte   0x05,0x68
   880D 0B 01              1055         .byte   0x0b,0x01
   880F 03 C1              1056         .byte   0x03,0xc1
   8811 0F 00              1057         .byte   0x0f,0x00
   8813 FF FF              1058         .byte   0xff,0xff
                           1059 
                           1060 ; Install IRQ and SCI interrupt handlers
   8815                    1061 L8815:
   8815 CE 88 3E      [ 3] 1062         ldx     #L883E          ; Install IRQ interrupt handler
   8818 FF 01 28      [ 5] 1063         stx     (0x0128)
   881B 86 7E         [ 2] 1064         ldaa    #0x7E
   881D B7 01 27      [ 4] 1065         staa    (0x0127)
   8820 CE 88 32      [ 3] 1066         ldx     #L8832          ; Install SCI interrupt handler
   8823 FF 01 01      [ 5] 1067         stx     (0x0101)
   8826 B7 01 00      [ 4] 1068         staa    (0x0100)
   8829 B6 10 2D      [ 4] 1069         ldaa    SCCR2           ; enable SCI receive interrupts
   882C 8A 20         [ 2] 1070         oraa    #0x20
   882E B7 10 2D      [ 4] 1071         staa    SCCR2  
   8831 39            [ 5] 1072         rts
                           1073 
                           1074 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1075 
                           1076 ; SCI Interrupt handler, normal serial
                           1077 
   8832                    1078 L8832:
   8832 B6 10 2E      [ 4] 1079         ldaa    SCSR
   8835 B6 10 2F      [ 4] 1080         ldaa    SCDR
   8838 7C 00 48      [ 6] 1081         inc     (0x0048)        ; increment bytes received
   883B 7E 88 62      [ 3] 1082         jmp     L8862           ; handle incoming data the same from SCI or SCC
                           1083 
                           1084 ; IRQ Interrupt handler, aux serial
                           1085 
   883E                    1086 L883E:
   883E 86 01         [ 2] 1087         ldaa    #0x01
   8840 B7 18 0C      [ 4] 1088         staa    SCCCTRLA
   8843 B6 18 0C      [ 4] 1089         ldaa    SCCCTRLA        ; read 3 error bits
   8846 84 70         [ 2] 1090         anda    #0x70
   8848 26 1F         [ 3] 1091         bne     L8869           ; if errors, jump ahead
   884A 86 0A         [ 2] 1092         ldaa    #0x0A
   884C B7 18 0C      [ 4] 1093         staa    SCCCTRLA
   884F B6 18 0C      [ 4] 1094         ldaa    SCCCTRLA        ; read clocks missing bits
   8852 84 C0         [ 2] 1095         anda    #0xC0
   8854 26 22         [ 3] 1096         bne     L8878           ; clocks missing, jump ahead
   8856 B6 18 0C      [ 4] 1097         ldaa    SCCCTRLA
   8859 44            [ 2] 1098         lsra
   885A 24 35         [ 3] 1099         bcc     L8891           ;
   885C 7C 00 48      [ 6] 1100         inc     (0x0048)        ; increment bytes received
   885F B6 18 0E      [ 4] 1101         ldaa    SCCDATAA        ; read good data byte
                           1102 
                           1103 ; handle incoming data byte
   8862                    1104 L8862:
   8862 BD F9 6F      [ 6] 1105         jsr     SERIALW         ; echo it to serial
   8865 97 4A         [ 3] 1106         staa    (0x004A)        ; store it here
   8867 20 2D         [ 3] 1107         bra     L8896           
                           1108 
                           1109 ; errors reading from SCC
   8869                    1110 L8869:
   8869 B6 18 0E      [ 4] 1111         ldaa    SCCDATAA        ; read bad byte
   886C 86 30         [ 2] 1112         ldaa    #0x30
   886E B7 18 0C      [ 4] 1113         staa    SCCCTRLA
   8871 86 07         [ 2] 1114         ldaa    #0x07
   8873 BD F9 6F      [ 6] 1115         jsr     SERIALW         ; bell to serial?
   8876 0C            [ 2] 1116         clc
   8877 3B            [12] 1117         rti
                           1118 
                           1119 ; clocks missing?
   8878                    1120 L8878:
   8878 86 07         [ 2] 1121         ldaa    #0x07
   887A BD F9 6F      [ 6] 1122         jsr     SERIALW         ; bell to serial?
   887D 86 0E         [ 2] 1123         ldaa    #0x0E
   887F B7 18 0C      [ 4] 1124         staa    SCCCTRLA
   8882 86 43         [ 2] 1125         ldaa    #0x43
   8884 B7 18 0C      [ 4] 1126         staa    SCCCTRLA
   8887 B6 18 0E      [ 4] 1127         ldaa    SCCDATAA
   888A 86 07         [ 2] 1128         ldaa    #0x07
   888C BD F9 6F      [ 6] 1129         jsr     SERIALW         ; 2nd bell to serial?
   888F 0D            [ 2] 1130         sec
   8890 3B            [12] 1131         rti
                           1132 
                           1133 ; ???
   8891                    1134 L8891:
   8891 B6 18 0E      [ 4] 1135         ldaa    SCCDATAA
   8894 0C            [ 2] 1136         clc
   8895 3B            [12] 1137         rti
                           1138 
                           1139 ; Parse byte from tape
   8896                    1140 L8896:
   8896 84 7F         [ 2] 1141         anda    #0x7F           ; should all be 7-bits, ignore bit 7
   8898 81 24         [ 2] 1142         cmpa    #0x24           ;'$'
   889A 27 44         [ 3] 1143         beq     L88E0           ; count it and exit
   889C 81 25         [ 2] 1144         cmpa    #0x25           ;'%'
   889E 27 40         [ 3] 1145         beq     L88E0           ; count it and exit
   88A0 81 20         [ 2] 1146         cmpa    #0x20           ;' '
   88A2 27 3A         [ 3] 1147         beq     L88DE           ; just exit
   88A4 81 30         [ 2] 1148         cmpa    #0x30           ;'0'
   88A6 25 35         [ 3] 1149         bcs     L88DD           ; < 0x30, exit
   88A8 97 12         [ 3] 1150         staa    (0x0012)        ; store it here
   88AA 96 4D         [ 3] 1151         ldaa    (0x004D)        ; check number of '$' or '%'
   88AC 81 02         [ 2] 1152         cmpa    #0x02
   88AE 25 09         [ 3] 1153         bcs     L88B9           ; < 2, jump ahead
   88B0 7F 00 4D      [ 6] 1154         clr     (0x004D)        ; clear number of '$' or '%'
   88B3 96 12         [ 3] 1155         ldaa    (0x0012)
   88B5 97 49         [ 3] 1156         staa    (0x0049)        ; store the character here - character is 0x30 or higher
   88B7 20 24         [ 3] 1157         bra     L88DD           ; exit
   88B9                    1158 L88B9:
   88B9 7D 00 4E      [ 6] 1159         tst     (0x004E)        ; is 4E 0??? (related to random motions?)
   88BC 27 1F         [ 3] 1160         beq     L88DD           ; if so, exit
   88BE 86 78         [ 2] 1161         ldaa    #0x78
   88C0 97 63         [ 3] 1162         staa    (0x0063)
   88C2 97 64         [ 3] 1163         staa    (0x0064)        ; start countdown timer
   88C4 96 12         [ 3] 1164         ldaa    (0x0012)
   88C6 81 40         [ 2] 1165         cmpa    #0x40
   88C8 24 07         [ 3] 1166         bcc     L88D1           ; if char >= 0x40, jump ahead
   88CA 97 4C         [ 3] 1167         staa    (0x004C)        ; store code from 0x30 to 0x3F here
   88CC 7F 00 4D      [ 6] 1168         clr     (0x004D)        ; more code to process
   88CF 20 0C         [ 3] 1169         bra     L88DD           ; go to rti
   88D1                    1170 L88D1:
   88D1 81 60         [ 2] 1171         cmpa    #0x60       
   88D3 24 08         [ 3] 1172         bcc     L88DD           ; if char >= 0x60, exit
   88D5 97 4B         [ 3] 1173         staa    (0x004B)        ; store code from 0x40 to 0x5F here
   88D7 7F 00 4D      [ 6] 1174         clr     (0x004D)        ; more code to process
   88DA BD 88 E5      [ 6] 1175         jsr     L88E5           ; jump ahead
   88DD                    1176 L88DD:
   88DD 3B            [12] 1177         rti
                           1178 
   88DE                    1179 L88DE:
   88DE 20 FD         [ 3] 1180         bra     L88DD           ; go to rti
   88E0                    1181 L88E0:
   88E0 7C 00 4D      [ 6] 1182         inc     (0x004D)        ; count $ or %
   88E3 20 F9         [ 3] 1183         bra     L88DE           ; exit
   88E5                    1184 L88E5:
   88E5 D6 4B         [ 3] 1185         ldab    (0x004B)        
   88E7 96 4C         [ 3] 1186         ldaa    (0x004C)
   88E9 7D 04 5C      [ 6] 1187         tst     (0x045C)        ; R12/CNR?
   88EC 27 0D         [ 3] 1188         beq     L88FB  
   88EE 81 3C         [ 2] 1189         cmpa    #0x3C
   88F0 25 09         [ 3] 1190         bcs     L88FB  
   88F2 81 3F         [ 2] 1191         cmpa    #0x3F
   88F4 22 05         [ 3] 1192         bhi     L88FB  
   88F6 BD 89 93      [ 6] 1193         jsr     L8993
   88F9 20 65         [ 3] 1194         bra     L8960  
   88FB                    1195 L88FB:
   88FB 1A 83 30 48   [ 5] 1196         cpd     #0x3048
   88FF 27 79         [ 3] 1197         beq     L897A           ; turn off 3 bits on boards 1 and 3
   8901 1A 83 31 48   [ 5] 1198         cpd     #0x3148
   8905 27 5A         [ 3] 1199         beq     L8961           ; turn on 3 bits on boards 1 and 3
   8907 1A 83 34 4D   [ 5] 1200         cpd     #0x344D
   890B 27 6D         [ 3] 1201         beq     L897A           ; turn off 3 bits on boards 1 and 3
   890D 1A 83 35 4D   [ 5] 1202         cpd     #0x354D
   8911 27 4E         [ 3] 1203         beq     L8961           ; turn on 3 bits on boards 1 and 3
   8913 1A 83 36 4D   [ 5] 1204         cpd     #0x364D
   8917 27 61         [ 3] 1205         beq     L897A           ; turn off 3 bits on boards 1 and 3
   8919 1A 83 37 4D   [ 5] 1206         cpd     #0x374D
   891D 27 42         [ 3] 1207         beq     L8961           ; turn on 3 bits on boards 1 and 3
   891F CE 10 80      [ 3] 1208         ldx     #0x1080
   8922 D6 4C         [ 3] 1209         ldab    (0x004C)
   8924 C0 30         [ 2] 1210         subb    #0x30
   8926 54            [ 2] 1211         lsrb
   8927 58            [ 2] 1212         aslb
   8928 58            [ 2] 1213         aslb
   8929 3A            [ 3] 1214         abx
   892A D6 4B         [ 3] 1215         ldab    (0x004B)
   892C C1 50         [ 2] 1216         cmpb    #0x50
   892E 24 30         [ 3] 1217         bcc     L8960  
   8930 C1 47         [ 2] 1218         cmpb    #0x47
   8932 23 02         [ 3] 1219         bls     L8936  
   8934 08            [ 3] 1220         inx
   8935 08            [ 3] 1221         inx
   8936                    1222 L8936:
   8936 C0 40         [ 2] 1223         subb    #0x40
   8938 C4 07         [ 2] 1224         andb    #0x07
   893A 4F            [ 2] 1225         clra
   893B 0D            [ 2] 1226         sec
   893C 49            [ 2] 1227         rola
   893D 5D            [ 2] 1228         tstb
   893E 27 04         [ 3] 1229         beq     L8944  
   8940                    1230 L8940:
   8940 49            [ 2] 1231         rola
   8941 5A            [ 2] 1232         decb
   8942 26 FC         [ 3] 1233         bne     L8940  
   8944                    1234 L8944:
   8944 97 50         [ 3] 1235         staa    (0x0050)
   8946 96 4C         [ 3] 1236         ldaa    (0x004C)
   8948 84 01         [ 2] 1237         anda    #0x01
   894A 27 08         [ 3] 1238         beq     L8954  
   894C A6 00         [ 4] 1239         ldaa    0,X
   894E 9A 50         [ 3] 1240         oraa    (0x0050)
   8950 A7 00         [ 4] 1241         staa    0,X
   8952 20 0C         [ 3] 1242         bra     L8960  
   8954                    1243 L8954:
   8954 96 50         [ 3] 1244         ldaa    (0x0050)
   8956 88 FF         [ 2] 1245         eora    #0xFF
   8958 97 50         [ 3] 1246         staa    (0x0050)
   895A A6 00         [ 4] 1247         ldaa    0,X
   895C 94 50         [ 3] 1248         anda    (0x0050)
   895E A7 00         [ 4] 1249         staa    0,X
   8960                    1250 L8960:
   8960 39            [ 5] 1251         rts
                           1252 
                           1253 ; turn on 3 bits on boards 1 and 3
   8961                    1254 L8961:
   8961 B6 10 82      [ 4] 1255         ldaa    (0x1082)
   8964 8A 01         [ 2] 1256         oraa    #0x01
   8966 B7 10 82      [ 4] 1257         staa    (0x1082)
   8969 B6 10 8A      [ 4] 1258         ldaa    (0x108A)
   896C 8A 20         [ 2] 1259         oraa    #0x20
   896E B7 10 8A      [ 4] 1260         staa    (0x108A)
   8971 B6 10 8E      [ 4] 1261         ldaa    (0x108E)
   8974 8A 20         [ 2] 1262         oraa    #0x20
   8976 B7 10 8E      [ 4] 1263         staa    (0x108E)
   8979 39            [ 5] 1264         rts
                           1265 
                           1266 ; turn off 3 bits on boards 1 and 3
   897A                    1267 L897A:
   897A B6 10 82      [ 4] 1268         ldaa    (0x1082)
   897D 84 FE         [ 2] 1269         anda    #0xFE
   897F B7 10 82      [ 4] 1270         staa    (0x1082)
   8982 B6 10 8A      [ 4] 1271         ldaa    (0x108A)
   8985 84 DF         [ 2] 1272         anda    #0xDF
   8987 B7 10 8A      [ 4] 1273         staa    (0x108A)
   898A B6 10 8E      [ 4] 1274         ldaa    (0x108E)
   898D 84 DF         [ 2] 1275         anda    #0xDF
   898F B7 10 8E      [ 4] 1276         staa    (0x108E)
   8992 39            [ 5] 1277         rts
                           1278 
   8993                    1279 L8993:
   8993 3C            [ 4] 1280         pshx
   8994 81 3D         [ 2] 1281         cmpa    #0x3D
   8996 22 05         [ 3] 1282         bhi     L899D  
   8998 CE F7 80      [ 3] 1283         ldx     #LF780          ; table at the end
   899B 20 03         [ 3] 1284         bra     L89A0  
   899D                    1285 L899D:
   899D CE F7 A0      [ 3] 1286         ldx     #LF7A0          ; table at the end
   89A0                    1287 L89A0:
   89A0 C0 40         [ 2] 1288         subb    #0x40
   89A2 58            [ 2] 1289         aslb
   89A3 3A            [ 3] 1290         abx
   89A4 81 3C         [ 2] 1291         cmpa    #0x3C
   89A6 27 34         [ 3] 1292         beq     L89DC           ; board 7  
   89A8 81 3D         [ 2] 1293         cmpa    #0x3D
   89AA 27 0A         [ 3] 1294         beq     L89B6           ; board 7
   89AC 81 3E         [ 2] 1295         cmpa    #0x3E
   89AE 27 4B         [ 3] 1296         beq     L89FB           ; board 8
   89B0 81 3F         [ 2] 1297         cmpa    #0x3F
   89B2 27 15         [ 3] 1298         beq     L89C9           ; board 8
   89B4 38            [ 5] 1299         pulx
   89B5 39            [ 5] 1300         rts
                           1301 
                           1302 ; board 7
   89B6                    1303 L89B6:
   89B6 B6 10 98      [ 4] 1304         ldaa    (0x1098)
   89B9 AA 00         [ 4] 1305         oraa    0,X
   89BB B7 10 98      [ 4] 1306         staa    (0x1098)
   89BE 08            [ 3] 1307         inx
   89BF B6 10 9A      [ 4] 1308         ldaa    (0x109A)
   89C2 AA 00         [ 4] 1309         oraa    0,X
   89C4 B7 10 9A      [ 4] 1310         staa    (0x109A)
   89C7 38            [ 5] 1311         pulx
   89C8 39            [ 5] 1312         rts
                           1313 
                           1314 ; board 8
   89C9                    1315 L89C9:
   89C9 B6 10 9C      [ 4] 1316         ldaa    (0x109C)
   89CC AA 00         [ 4] 1317         oraa    0,X
   89CE B7 10 9C      [ 4] 1318         staa    (0x109C)
   89D1 08            [ 3] 1319         inx
   89D2 B6 10 9E      [ 4] 1320         ldaa    (0x109E)
   89D5 AA 00         [ 4] 1321         oraa    0,X
   89D7 B7 10 9E      [ 4] 1322         staa    (0x109E)
   89DA 38            [ 5] 1323         pulx
   89DB 39            [ 5] 1324         rts
                           1325 
                           1326 ; board 7
   89DC                    1327 L89DC:
   89DC E6 00         [ 4] 1328         ldab    0,X
   89DE C8 FF         [ 2] 1329         eorb    #0xFF
   89E0 D7 12         [ 3] 1330         stab    (0x0012)
   89E2 B6 10 98      [ 4] 1331         ldaa    (0x1098)
   89E5 94 12         [ 3] 1332         anda    (0x0012)
   89E7 B7 10 98      [ 4] 1333         staa    (0x1098)
   89EA 08            [ 3] 1334         inx
   89EB E6 00         [ 4] 1335         ldab    0,X
   89ED C8 FF         [ 2] 1336         eorb    #0xFF
   89EF D7 12         [ 3] 1337         stab    (0x0012)
   89F1 B6 10 9A      [ 4] 1338         ldaa    (0x109A)
   89F4 94 12         [ 3] 1339         anda    (0x0012)
   89F6 B7 10 9A      [ 4] 1340         staa    (0x109A)
   89F9 38            [ 5] 1341         pulx
   89FA 39            [ 5] 1342         rts
                           1343 
                           1344 ; board 8
   89FB                    1345 L89FB:
   89FB E6 00         [ 4] 1346         ldab    0,X
   89FD C8 FF         [ 2] 1347         eorb    #0xFF
   89FF D7 12         [ 3] 1348         stab    (0x0012)
   8A01 B6 10 9C      [ 4] 1349         ldaa    (0x109C)
   8A04 94 12         [ 3] 1350         anda    (0x0012)
   8A06 B7 10 9C      [ 4] 1351         staa    (0x109C)
   8A09 08            [ 3] 1352         inx
   8A0A E6 00         [ 4] 1353         ldab    0,X
   8A0C C8 FF         [ 2] 1354         eorb    #0xFF
   8A0E D7 12         [ 3] 1355         stab    (0x0012)
   8A10 B6 10 9E      [ 4] 1356         ldaa    (0x109E)
   8A13 94 12         [ 3] 1357         anda    (0x0012)
   8A15 B7 10 9E      [ 4] 1358         staa    (0x109E)
   8A18 38            [ 5] 1359         pulx
   8A19 39            [ 5] 1360         rts
                           1361 
                           1362 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1363 
   8A1A                    1364 L8A1A:
                           1365 ; Parse text with compressed ANSI stuff from table location in X
   8A1A 3C            [ 4] 1366         pshx
   8A1B                    1367 L8A1B:
   8A1B 86 04         [ 2] 1368         ldaa    #0x04
   8A1D B5 18 0D      [ 4] 1369         bita    SCCCTRLB
   8A20 27 F9         [ 3] 1370         beq     L8A1B  
   8A22 A6 00         [ 4] 1371         ldaa    0,X     
   8A24 26 03         [ 3] 1372         bne     L8A29           ; if not nul, continue
   8A26 7E 8B 21      [ 3] 1373         jmp     L8B21           ; else jump to exit
                           1374 ; process ^0123 into ESC[01;23H - ANSI Cursor positioning - (1 based)
   8A29                    1375 L8A29:
   8A29 08            [ 3] 1376         inx
   8A2A 81 5E         [ 2] 1377         cmpa    #0x5E           ; is it a '^' ?
   8A2C 26 1D         [ 3] 1378         bne     L8A4B           ; no, jump ahead
   8A2E A6 00         [ 4] 1379         ldaa    0,X             ; yes, get the next char
   8A30 08            [ 3] 1380         inx
   8A31 B7 05 92      [ 4] 1381         staa    (0x0592)    
   8A34 A6 00         [ 4] 1382         ldaa    0,X     
   8A36 08            [ 3] 1383         inx
   8A37 B7 05 93      [ 4] 1384         staa    (0x0593)
   8A3A A6 00         [ 4] 1385         ldaa    0,X     
   8A3C 08            [ 3] 1386         inx
   8A3D B7 05 95      [ 4] 1387         staa    (0x0595)
   8A40 A6 00         [ 4] 1388         ldaa    0,X     
   8A42 08            [ 3] 1389         inx
   8A43 B7 05 96      [ 4] 1390         staa    (0x0596)
   8A46 BD 8B 23      [ 6] 1391         jsr     L8B23
   8A49 20 D0         [ 3] 1392         bra     L8A1B  
                           1393 ; process @...
   8A4B                    1394 L8A4B:
   8A4B 81 40         [ 2] 1395         cmpa    #0x40           ; is it a '@' ?
   8A4D 26 3B         [ 3] 1396         bne     L8A8A  
   8A4F 1A EE 00      [ 6] 1397         ldy     0,X
   8A52 08            [ 3] 1398         inx
   8A53 08            [ 3] 1399         inx
   8A54 86 30         [ 2] 1400         ldaa    #0x30
   8A56 97 B1         [ 3] 1401         staa    (0x00B1)
   8A58 18 A6 00      [ 5] 1402         ldaa    0,Y
   8A5B                    1403 L8A5B:
   8A5B 81 64         [ 2] 1404         cmpa    #0x64
   8A5D 25 07         [ 3] 1405         bcs     L8A66  
   8A5F 7C 00 B1      [ 6] 1406         inc     (0x00B1)
   8A62 80 64         [ 2] 1407         suba    #0x64
   8A64 20 F5         [ 3] 1408         bra     L8A5B  
   8A66                    1409 L8A66:
   8A66 36            [ 3] 1410         psha
   8A67 96 B1         [ 3] 1411         ldaa    (0x00B1)
   8A69 BD 8B 3B      [ 6] 1412         jsr     L8B3B
   8A6C 86 30         [ 2] 1413         ldaa    #0x30
   8A6E 97 B1         [ 3] 1414         staa    (0x00B1)
   8A70 32            [ 4] 1415         pula
   8A71                    1416 L8A71:
   8A71 81 0A         [ 2] 1417         cmpa    #0x0A
   8A73 25 07         [ 3] 1418         bcs     L8A7C  
   8A75 7C 00 B1      [ 6] 1419         inc     (0x00B1)
   8A78 80 0A         [ 2] 1420         suba    #0x0A
   8A7A 20 F5         [ 3] 1421         bra     L8A71  
   8A7C                    1422 L8A7C:
   8A7C 36            [ 3] 1423         psha
   8A7D 96 B1         [ 3] 1424         ldaa    (0x00B1)
   8A7F BD 8B 3B      [ 6] 1425         jsr     L8B3B
   8A82 32            [ 4] 1426         pula
   8A83 8B 30         [ 2] 1427         adda    #0x30
   8A85 BD 8B 3B      [ 6] 1428         jsr     L8B3B
   8A88 20 91         [ 3] 1429         bra     L8A1B
                           1430 ; process |...
   8A8A                    1431 L8A8A:
   8A8A 81 7C         [ 2] 1432         cmpa    #0x7C           ; is it a '|' ?
   8A8C 26 59         [ 3] 1433         bne     L8AE7  
   8A8E 1A EE 00      [ 6] 1434         ldy     0,X     
   8A91 08            [ 3] 1435         inx
   8A92 08            [ 3] 1436         inx
   8A93 86 30         [ 2] 1437         ldaa    #0x30
   8A95 97 B1         [ 3] 1438         staa    (0x00B1)
   8A97 18 EC 00      [ 6] 1439         ldd     0,Y     
   8A9A                    1440 L8A9A:
   8A9A 1A 83 27 10   [ 5] 1441         cpd     #0x2710
   8A9E 25 08         [ 3] 1442         bcs     L8AA8  
   8AA0 7C 00 B1      [ 6] 1443         inc     (0x00B1)
   8AA3 83 27 10      [ 4] 1444         subd    #0x2710
   8AA6 20 F2         [ 3] 1445         bra     L8A9A  
   8AA8                    1446 L8AA8:
   8AA8 36            [ 3] 1447         psha
   8AA9 96 B1         [ 3] 1448         ldaa    (0x00B1)
   8AAB BD 8B 3B      [ 6] 1449         jsr     L8B3B
   8AAE 86 30         [ 2] 1450         ldaa    #0x30
   8AB0 97 B1         [ 3] 1451         staa    (0x00B1)
   8AB2 32            [ 4] 1452         pula
   8AB3                    1453 L8AB3:
   8AB3 1A 83 03 E8   [ 5] 1454         cpd     #0x03E8
   8AB7 25 08         [ 3] 1455         bcs     L8AC1  
   8AB9 7C 00 B1      [ 6] 1456         inc     (0x00B1)
   8ABC 83 03 E8      [ 4] 1457         subd    #0x03E8
   8ABF 20 F2         [ 3] 1458         bra     L8AB3  
   8AC1                    1459 L8AC1:
   8AC1 36            [ 3] 1460         psha
   8AC2 96 B1         [ 3] 1461         ldaa    (0x00B1)
   8AC4 BD 8B 3B      [ 6] 1462         jsr     L8B3B
   8AC7 86 30         [ 2] 1463         ldaa    #0x30
   8AC9 97 B1         [ 3] 1464         staa    (0x00B1)
   8ACB 32            [ 4] 1465         pula
   8ACC                    1466 L8ACC:
   8ACC 1A 83 00 64   [ 5] 1467         cpd     #0x0064
   8AD0 25 08         [ 3] 1468         bcs     L8ADA  
   8AD2 7C 00 B1      [ 6] 1469         inc     (0x00B1)
   8AD5 83 00 64      [ 4] 1470         subd    #0x0064
   8AD8 20 F2         [ 3] 1471         bra     L8ACC  
   8ADA                    1472 L8ADA:
   8ADA 96 B1         [ 3] 1473         ldaa    (0x00B1)
   8ADC BD 8B 3B      [ 6] 1474         jsr     L8B3B
   8ADF 86 30         [ 2] 1475         ldaa    #0x30
   8AE1 97 B1         [ 3] 1476         staa    (0x00B1)
   8AE3 17            [ 2] 1477         tba
   8AE4 7E 8A 71      [ 3] 1478         jmp     L8A71
                           1479 ; process ~...
   8AE7                    1480 L8AE7:
   8AE7 81 7E         [ 2] 1481         cmpa    #0x7E           ; is it a '~' ?
   8AE9 26 18         [ 3] 1482         bne     L8B03  
   8AEB E6 00         [ 4] 1483         ldab    0,X     
   8AED C0 30         [ 2] 1484         subb    #0x30
   8AEF 08            [ 3] 1485         inx
   8AF0 1A EE 00      [ 6] 1486         ldy     0,X     
   8AF3 08            [ 3] 1487         inx
   8AF4 08            [ 3] 1488         inx
   8AF5                    1489 L8AF5:
   8AF5 18 A6 00      [ 5] 1490         ldaa    0,Y     
   8AF8 18 08         [ 4] 1491         iny
   8AFA BD 8B 3B      [ 6] 1492         jsr     L8B3B
   8AFD 5A            [ 2] 1493         decb
   8AFE 26 F5         [ 3] 1494         bne     L8AF5  
   8B00 7E 8A 1B      [ 3] 1495         jmp     L8A1B
                           1496 ; process %...
   8B03                    1497 L8B03:
   8B03 81 25         [ 2] 1498         cmpa    #0x25           ; is it a '%' ?
   8B05 26 14         [ 3] 1499         bne     L8B1B  
   8B07 CE 05 90      [ 3] 1500         ldx     #0x0590
   8B0A CC 1B 5B      [ 3] 1501         ldd     #0x1B5B
   8B0D ED 00         [ 5] 1502         std     0,X     
   8B0F 86 4B         [ 2] 1503         ldaa    #0x4B
   8B11 A7 02         [ 4] 1504         staa    2,X
   8B13 6F 03         [ 6] 1505         clr     3,X
   8B15 BD 8A 1A      [ 6] 1506         jsr     L8A1A  
   8B18 7E 8A 1B      [ 3] 1507         jmp     L8A1B
   8B1B                    1508 L8B1B:
   8B1B B7 18 0F      [ 4] 1509         staa    SCCDATAB
   8B1E 7E 8A 1B      [ 3] 1510         jmp     L8A1B
   8B21                    1511 L8B21:
   8B21 38            [ 5] 1512         pulx
   8B22 39            [ 5] 1513         rts
                           1514 
                           1515 ; generate cursor positioning code
   8B23                    1516 L8B23:
   8B23 3C            [ 4] 1517         pshx
   8B24 CE 05 90      [ 3] 1518         ldx     #0x0590
   8B27 CC 1B 5B      [ 3] 1519         ldd     #0x1B5B
   8B2A ED 00         [ 5] 1520         std     0,X     
   8B2C 86 48         [ 2] 1521         ldaa    #0x48           ;'H'
   8B2E A7 07         [ 4] 1522         staa    7,X
   8B30 86 3B         [ 2] 1523         ldaa    #0x3B           ;';'
   8B32 A7 04         [ 4] 1524         staa    4,X
   8B34 6F 08         [ 6] 1525         clr     8,X
   8B36 BD 8A 1A      [ 6] 1526         jsr     L8A1A           ;012345678 - esc[01;23H;
   8B39 38            [ 5] 1527         pulx
   8B3A 39            [ 5] 1528         rts
                           1529 
                           1530 ;
   8B3B                    1531 L8B3B:
   8B3B 36            [ 3] 1532         psha
   8B3C                    1533 L8B3C:
   8B3C 86 04         [ 2] 1534         ldaa    #0x04
   8B3E B5 18 0D      [ 4] 1535         bita    SCCCTRLB
   8B41 27 F9         [ 3] 1536         beq     L8B3C
   8B43 32            [ 4] 1537         pula
   8B44 B7 18 0F      [ 4] 1538         staa    SCCDATAB
   8B47 39            [ 5] 1539         rts
                           1540 
   8B48                    1541 L8B48:
   8B48 BD A3 2E      [ 6] 1542         jsr     LA32E
                           1543 
   8B4B BD 8D E4      [ 6] 1544         jsr     LCDMSG1 
   8B4E 4C 69 67 68 74 20  1545         .ascis  'Light Diagnostic'
        44 69 61 67 6E 6F
        73 74 69 E3
                           1546 
   8B5E BD 8D DD      [ 6] 1547         jsr     LCDMSG2 
   8B61 43 75 72 74 61 69  1548         .ascis  'Curtains opening'
        6E 73 20 6F 70 65
        6E 69 6E E7
                           1549 
   8B71 C6 14         [ 2] 1550         ldab    #0x14
   8B73 BD 8C 30      [ 6] 1551         jsr     DLYSECSBY2      ; delay 10 sec
   8B76 C6 FF         [ 2] 1552         ldab    #0xFF
   8B78 F7 10 98      [ 4] 1553         stab    (0x1098)
   8B7B F7 10 9A      [ 4] 1554         stab    (0x109A)
   8B7E F7 10 9C      [ 4] 1555         stab    (0x109C)
   8B81 F7 10 9E      [ 4] 1556         stab    (0x109E)
   8B84 BD F9 C5      [ 6] 1557         jsr     BUTNLIT 
   8B87 B6 18 04      [ 4] 1558         ldaa    PIA0PRA 
   8B8A 8A 40         [ 2] 1559         oraa    #0x40
   8B8C B7 18 04      [ 4] 1560         staa    PIA0PRA 
                           1561 
   8B8F BD 8D E4      [ 6] 1562         jsr     LCDMSG1 
   8B92 20 50 72 65 73 73  1563         .ascis  ' Press ENTER to '
        20 45 4E 54 45 52
        20 74 6F A0
                           1564 
   8BA2 BD 8D DD      [ 6] 1565         jsr     LCDMSG2 
   8BA5 74 75 72 6E 20 6C  1566         .ascis  'turn lights  off'
        69 67 68 74 73 20
        20 6F 66 E6
                           1567 
   8BB5                    1568 L8BB5:
   8BB5 BD 8E 95      [ 6] 1569         jsr     L8E95
   8BB8 81 0D         [ 2] 1570         cmpa    #0x0D
   8BBA 26 F9         [ 3] 1571         bne     L8BB5  
   8BBC BD A3 41      [ 6] 1572         jsr     LA341
   8BBF 39            [ 5] 1573         rts
                           1574 
                           1575 ; setup IRQ handlers!
   8BC0                    1576 L8BC0:
   8BC0 86 80         [ 2] 1577         ldaa    #0x80
   8BC2 B7 10 22      [ 4] 1578         staa    TMSK1
   8BC5 CE AB CC      [ 3] 1579         ldx     #LABCC
   8BC8 FF 01 19      [ 5] 1580         stx     (0x0119)        ; setup T1OC handler
   8BCB CE AD 0C      [ 3] 1581         ldx     #LAD0C
                           1582 
   8BCE FF 01 16      [ 5] 1583         stx     (0x0116)        ; setup T2OC handler
   8BD1 CE AD 0C      [ 3] 1584         ldx     #LAD0C
   8BD4 FF 01 2E      [ 5] 1585         stx     (0x012E)        ; doubles as SWI handler
   8BD7 86 7E         [ 2] 1586         ldaa    #0x7E
   8BD9 B7 01 18      [ 4] 1587         staa    (0x0118)
   8BDC B7 01 15      [ 4] 1588         staa    (0x0115)
   8BDF B7 01 2D      [ 4] 1589         staa    (0x012D)
   8BE2 4F            [ 2] 1590         clra
   8BE3 5F            [ 2] 1591         clrb
   8BE4 DD 1B         [ 4] 1592         std     CDTIMR1         ; Reset all the countdown timers
   8BE6 DD 1D         [ 4] 1593         std     CDTIMR2
   8BE8 DD 1F         [ 4] 1594         std     CDTIMR3
   8BEA DD 21         [ 4] 1595         std     CDTIMR4
   8BEC DD 23         [ 4] 1596         std     CDTIMR5
                           1597 
   8BEE                    1598 L8BEE:
   8BEE 86 C0         [ 2] 1599         ldaa    #0xC0
   8BF0 B7 10 23      [ 4] 1600         staa    TFLG1
   8BF3 39            [ 5] 1601         rts
                           1602 
   8BF4                    1603 L8BF4:
   8BF4 B6 10 0A      [ 4] 1604         ldaa    PORTE
   8BF7 88 FF         [ 2] 1605         eora    #0xFF
   8BF9 16            [ 2] 1606         tab
   8BFA D7 62         [ 3] 1607         stab    (0x0062)
   8BFC BD F9 C5      [ 6] 1608         jsr     BUTNLIT 
   8BFF 20 F3         [ 3] 1609         bra     L8BF4  
   8C01 39            [ 5] 1610         rts
                           1611 
                           1612 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1613 
                           1614 ; Delay B seconds, with random motions if enabled
   8C02                    1615 DLYSECS:
   8C02 36            [ 3] 1616         psha
   8C03 86 64         [ 2] 1617         ldaa    #0x64
   8C05 3D            [10] 1618         mul
   8C06 DD 23         [ 4] 1619         std     CDTIMR5         ; store B*100 here
   8C08                    1620 L8C08:
   8C08 BD 9B 19      [ 6] 1621         jsr     L9B19           ; do the random motions if enabled
   8C0B DC 23         [ 4] 1622         ldd     CDTIMR5
   8C0D 26 F9         [ 3] 1623         bne     L8C08  
   8C0F 32            [ 4] 1624         pula
   8C10 39            [ 5] 1625         rts
                           1626 
                           1627 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1628 
                           1629 ; Delay 1 minute, with random motions if enabled - unused?
   8C11                    1630 DLY1MIN:
   8C11 36            [ 3] 1631         psha
   8C12 86 3C         [ 2] 1632         ldaa    #0x3C
   8C14                    1633 L8C14:
   8C14 97 28         [ 3] 1634         staa    (0x0028)
   8C16 C6 01         [ 2] 1635         ldab    #0x01           ; delay 1 sec
   8C18 BD 8C 02      [ 6] 1636         jsr     DLYSECS         ;
   8C1B 96 28         [ 3] 1637         ldaa    (0x0028)
   8C1D 4A            [ 2] 1638         deca
   8C1E 26 F4         [ 3] 1639         bne     L8C14  
   8C20 32            [ 4] 1640         pula
   8C21 39            [ 5] 1641         rts
                           1642 
                           1643 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1644 
                           1645 ; Delay by B hundreths of a second, with random motions if enabled
   8C22                    1646 DLYSECSBY100:
   8C22 36            [ 3] 1647         psha
   8C23 4F            [ 2] 1648         clra
   8C24 DD 23         [ 4] 1649         std     CDTIMR5
   8C26                    1650 L8C26:
   8C26 BD 9B 19      [ 6] 1651         jsr     L9B19           ; do the random motions if enabled
   8C29 7D 00 24      [ 6] 1652         tst     CDTIMR5+1
   8C2C 26 F8         [ 3] 1653         bne     L8C26
   8C2E 32            [ 4] 1654         pula
   8C2F 39            [ 5] 1655         rts
                           1656 
                           1657 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1658 
                           1659 ; Delay by B half-seconds
   8C30                    1660 DLYSECSBY2:
   8C30 36            [ 3] 1661         psha
   8C31 86 32         [ 2] 1662         ldaa    #0x32           ; 50
   8C33 3D            [10] 1663         mul
   8C34 DD 23         [ 4] 1664         std     CDTIMR5
   8C36                    1665 L8C36:
   8C36 DC 23         [ 4] 1666         ldd     CDTIMR5
   8C38 26 FC         [ 3] 1667         bne     L8C36
   8C3A 32            [ 4] 1668         pula
   8C3B 39            [ 5] 1669         rts
                           1670 
                           1671 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1672 ; LCD routines
                           1673 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1674 
   8C3C                    1675 L8C3C:
   8C3C 86 FF         [ 2] 1676         ldaa    #0xFF
   8C3E B7 10 01      [ 4] 1677         staa    DDRA  
   8C41 86 FF         [ 2] 1678         ldaa    #0xFF
   8C43 B7 10 03      [ 4] 1679         staa    DDRG 
   8C46 B6 10 02      [ 4] 1680         ldaa    PORTG  
   8C49 8A 02         [ 2] 1681         oraa    #0x02
   8C4B B7 10 02      [ 4] 1682         staa    PORTG  
   8C4E 86 38         [ 2] 1683         ldaa    #0x38
   8C50 BD 8C 86      [ 6] 1684         jsr     L8C86           ; write byte to LCD
   8C53 86 38         [ 2] 1685         ldaa    #0x38
   8C55 BD 8C 86      [ 6] 1686         jsr     L8C86           ; write byte to LCD
   8C58 86 06         [ 2] 1687         ldaa    #0x06
   8C5A BD 8C 86      [ 6] 1688         jsr     L8C86           ; write byte to LCD
   8C5D 86 0E         [ 2] 1689         ldaa    #0x0E
   8C5F BD 8C 86      [ 6] 1690         jsr     L8C86           ; write byte to LCD
   8C62 86 01         [ 2] 1691         ldaa    #0x01
   8C64 BD 8C 86      [ 6] 1692         jsr     L8C86           ; write byte to LCD
   8C67 CE 00 FF      [ 3] 1693         ldx     #0x00FF
   8C6A                    1694 L8C6A:
   8C6A 01            [ 2] 1695         nop
   8C6B 01            [ 2] 1696         nop
   8C6C 09            [ 3] 1697         dex
   8C6D 26 FB         [ 3] 1698         bne     L8C6A  
   8C6F 39            [ 5] 1699         rts
                           1700 
                           1701 ; toggle LCD ENABLE
   8C70                    1702 L8C70:
   8C70 B6 10 02      [ 4] 1703         ldaa    PORTG  
   8C73 84 FD         [ 2] 1704         anda    #0xFD           ; clear LCD ENABLE
   8C75 B7 10 02      [ 4] 1705         staa    PORTG  
   8C78 8A 02         [ 2] 1706         oraa    #0x02           ; set LCD ENABLE
   8C7A B7 10 02      [ 4] 1707         staa    PORTG  
   8C7D 39            [ 5] 1708         rts
                           1709 
                           1710 ; Reset LCD buffer?
   8C7E                    1711 L8C7E:
   8C7E CC 05 00      [ 3] 1712         ldd     #0x0500         ; Reset LCD queue?
   8C81 DD 46         [ 4] 1713         std     (0x0046)        ; write pointer
   8C83 DD 44         [ 4] 1714         std     (0x0044)        ; read pointer?
   8C85 39            [ 5] 1715         rts
                           1716 
                           1717 ; write byte to LCD
   8C86                    1718 L8C86:
   8C86 BD 8C BD      [ 6] 1719         jsr     L8CBD           ; wait for LCD not busy
   8C89 B7 10 00      [ 4] 1720         staa    PORTA  
   8C8C B6 10 02      [ 4] 1721         ldaa    PORTG       
   8C8F 84 F3         [ 2] 1722         anda    #0xF3           ; LCD RS and LCD RW low
   8C91                    1723 L8C91:
   8C91 B7 10 02      [ 4] 1724         staa    PORTG  
   8C94 BD 8C 70      [ 6] 1725         jsr     L8C70           ; toggle LCD ENABLE
   8C97 39            [ 5] 1726         rts
                           1727 
                           1728 ; ???
   8C98                    1729 L8C98:
   8C98 BD 8C BD      [ 6] 1730         jsr     L8CBD           ; wait for LCD not busy
   8C9B B7 10 00      [ 4] 1731         staa    PORTA  
   8C9E B6 10 02      [ 4] 1732         ldaa    PORTG  
   8CA1 84 FB         [ 2] 1733         anda    #0xFB
   8CA3 8A 08         [ 2] 1734         oraa    #0x08
   8CA5 20 EA         [ 3] 1735         bra     L8C91  
   8CA7 BD 8C BD      [ 6] 1736         jsr     L8CBD           ; wait for LCD not busy
   8CAA B6 10 02      [ 4] 1737         ldaa    PORTG  
   8CAD 84 F7         [ 2] 1738         anda    #0xF7
   8CAF 8A 08         [ 2] 1739         oraa    #0x08
   8CB1 20 DE         [ 3] 1740         bra     L8C91  
   8CB3 BD 8C BD      [ 6] 1741         jsr     L8CBD           ; wait for LCD not busy
   8CB6 B6 10 02      [ 4] 1742         ldaa    PORTG  
   8CB9 8A 0C         [ 2] 1743         oraa    #0x0C
   8CBB 20 D4         [ 3] 1744         bra     L8C91  
                           1745 
                           1746 ; wait for LCD not busy (or timeout)
   8CBD                    1747 L8CBD:
   8CBD 36            [ 3] 1748         psha
   8CBE 37            [ 3] 1749         pshb
   8CBF C6 FF         [ 2] 1750         ldab    #0xFF           ; init timeout counter
   8CC1                    1751 L8CC1:
   8CC1 5D            [ 2] 1752         tstb
   8CC2 27 1A         [ 3] 1753         beq     L8CDE           ; times up, exit
   8CC4 B6 10 02      [ 4] 1754         ldaa    PORTG  
   8CC7 84 F7         [ 2] 1755         anda    #0xF7           ; bit 3 low
   8CC9 8A 04         [ 2] 1756         oraa    #0x04           ; bit 3 high
   8CCB B7 10 02      [ 4] 1757         staa    PORTG           ; LCD RS high
   8CCE BD 8C 70      [ 6] 1758         jsr     L8C70           ; toggle LCD ENABLE
   8CD1 7F 10 01      [ 6] 1759         clr     DDRA  
   8CD4 B6 10 00      [ 4] 1760         ldaa    PORTA           ; read busy flag from LCD
   8CD7 2B 08         [ 3] 1761         bmi     L8CE1           ; if busy, keep looping
   8CD9 86 FF         [ 2] 1762         ldaa    #0xFF
   8CDB B7 10 01      [ 4] 1763         staa    DDRA            ; port A back to outputs
   8CDE                    1764 L8CDE:
   8CDE 33            [ 4] 1765         pulb                    ; and exit
   8CDF 32            [ 4] 1766         pula
   8CE0 39            [ 5] 1767         rts
                           1768 
   8CE1                    1769 L8CE1:
   8CE1 5A            [ 2] 1770         decb                    ; decrement timer
   8CE2 86 FF         [ 2] 1771         ldaa    #0xFF
   8CE4 B7 10 01      [ 4] 1772         staa    DDRA            ; port A back to outputs
   8CE7 20 D8         [ 3] 1773         bra     L8CC1           ; loop
                           1774 
   8CE9                    1775 L8CE9:
   8CE9 BD 8C BD      [ 6] 1776         jsr     L8CBD           ; wait for LCD not busy
   8CEC 86 01         [ 2] 1777         ldaa    #0x01
   8CEE BD 8C 86      [ 6] 1778         jsr     L8C86           ; write byte to LCD
   8CF1 39            [ 5] 1779         rts
                           1780 
   8CF2                    1781 L8CF2:
   8CF2 BD 8C BD      [ 6] 1782         jsr     L8CBD           ; wait for LCD not busy
   8CF5 86 80         [ 2] 1783         ldaa    #0x80
   8CF7 BD 8D 14      [ 6] 1784         jsr     L8D14
   8CFA BD 8C BD      [ 6] 1785         jsr     L8CBD           ; wait for LCD not busy
   8CFD 86 80         [ 2] 1786         ldaa    #0x80
   8CFF BD 8C 86      [ 6] 1787         jsr     L8C86           ; write byte to LCD
   8D02 39            [ 5] 1788         rts
                           1789 
   8D03                    1790 L8D03:
   8D03 BD 8C BD      [ 6] 1791         jsr     L8CBD           ; wait for LCD not busy
   8D06 86 C0         [ 2] 1792         ldaa    #0xC0
   8D08 BD 8D 14      [ 6] 1793         jsr     L8D14
   8D0B BD 8C BD      [ 6] 1794         jsr     L8CBD           ; wait for LCD not busy
   8D0E 86 C0         [ 2] 1795         ldaa    #0xC0
   8D10 BD 8C 86      [ 6] 1796         jsr     L8C86           ; write byte to LCD
   8D13 39            [ 5] 1797         rts
                           1798 
   8D14                    1799 L8D14:
   8D14 BD 8C 86      [ 6] 1800         jsr     L8C86           ; write byte to LCD
   8D17 86 10         [ 2] 1801         ldaa    #0x10
   8D19 97 14         [ 3] 1802         staa    (0x0014)
   8D1B                    1803 L8D1B:
   8D1B BD 8C BD      [ 6] 1804         jsr     L8CBD           ; wait for LCD not busy
   8D1E 86 20         [ 2] 1805         ldaa    #0x20
   8D20 BD 8C 98      [ 6] 1806         jsr     L8C98
   8D23 7A 00 14      [ 6] 1807         dec     (0x0014)
   8D26 26 F3         [ 3] 1808         bne     L8D1B  
   8D28 39            [ 5] 1809         rts
                           1810 
   8D29                    1811 L8D29:
   8D29 86 0C         [ 2] 1812         ldaa    #0x0C
   8D2B BD 8E 4B      [ 6] 1813         jsr     L8E4B
   8D2E 39            [ 5] 1814         rts
                           1815 
                           1816 ; Unused?
   8D2F                    1817 L8D2F:
   8D2F 86 0E         [ 2] 1818         ldaa    #0x0E
   8D31 BD 8E 4B      [ 6] 1819         jsr     L8E4B
   8D34 39            [ 5] 1820         rts
                           1821 
   8D35                    1822 L8D35:
   8D35 7F 00 4A      [ 6] 1823         clr     (0x004A)
   8D38 7F 00 43      [ 6] 1824         clr     (0x0043)
   8D3B 18 DE 46      [ 5] 1825         ldy     (0x0046)
   8D3E 86 C0         [ 2] 1826         ldaa    #0xC0
   8D40 20 0B         [ 3] 1827         bra     L8D4D
                           1828 
   8D42                    1829 L8D42:
   8D42 7F 00 4A      [ 6] 1830         clr     (0x004A)
   8D45 7F 00 43      [ 6] 1831         clr     (0x0043)
   8D48 18 DE 46      [ 5] 1832         ldy     (0x0046)
   8D4B 86 80         [ 2] 1833         ldaa    #0x80
   8D4D                    1834 L8D4D:
   8D4D 18 A7 00      [ 5] 1835         staa    0,Y     
   8D50 18 6F 01      [ 7] 1836         clr     1,Y     
   8D53 18 08         [ 4] 1837         iny
   8D55 18 08         [ 4] 1838         iny
   8D57 18 8C 05 80   [ 5] 1839         cpy     #0x0580
   8D5B 25 04         [ 3] 1840         bcs     L8D61  
   8D5D 18 CE 05 00   [ 4] 1841         ldy     #0x0500
   8D61                    1842 L8D61:
   8D61 C6 0F         [ 2] 1843         ldab    #0x0F
   8D63                    1844 L8D63:
   8D63 96 4A         [ 3] 1845         ldaa    (0x004A)
   8D65 27 FC         [ 3] 1846         beq     L8D63  
   8D67 7F 00 4A      [ 6] 1847         clr     (0x004A)
   8D6A 5A            [ 2] 1848         decb
   8D6B 27 1A         [ 3] 1849         beq     L8D87  
   8D6D 81 24         [ 2] 1850         cmpa    #0x24
   8D6F 27 16         [ 3] 1851         beq     L8D87  
   8D71 18 6F 00      [ 7] 1852         clr     0,Y     
   8D74 18 A7 01      [ 5] 1853         staa    1,Y     
   8D77 18 08         [ 4] 1854         iny
   8D79 18 08         [ 4] 1855         iny
   8D7B 18 8C 05 80   [ 5] 1856         cpy     #0x0580
   8D7F 25 04         [ 3] 1857         bcs     L8D85  
   8D81 18 CE 05 00   [ 4] 1858         ldy     #0x0500
   8D85                    1859 L8D85:
   8D85 20 DC         [ 3] 1860         bra     L8D63  
   8D87                    1861 L8D87:
   8D87 5D            [ 2] 1862         tstb
   8D88 27 19         [ 3] 1863         beq     L8DA3  
   8D8A 86 20         [ 2] 1864         ldaa    #0x20
   8D8C                    1865 L8D8C:
   8D8C 18 6F 00      [ 7] 1866         clr     0,Y     
   8D8F 18 A7 01      [ 5] 1867         staa    1,Y     
   8D92 18 08         [ 4] 1868         iny
   8D94 18 08         [ 4] 1869         iny
   8D96 18 8C 05 80   [ 5] 1870         cpy     #0x0580
   8D9A 25 04         [ 3] 1871         bcs     L8DA0  
   8D9C 18 CE 05 00   [ 4] 1872         ldy     #0x0500
   8DA0                    1873 L8DA0:
   8DA0 5A            [ 2] 1874         decb
   8DA1 26 E9         [ 3] 1875         bne     L8D8C  
   8DA3                    1876 L8DA3:
   8DA3 18 6F 00      [ 7] 1877         clr     0,Y     
   8DA6 18 6F 01      [ 7] 1878         clr     1,Y     
   8DA9 18 DF 46      [ 5] 1879         sty     (0x0046)
   8DAC 96 19         [ 3] 1880         ldaa    (0x0019)
   8DAE 97 4E         [ 3] 1881         staa    (0x004E)
   8DB0 86 01         [ 2] 1882         ldaa    #0x01
   8DB2 97 43         [ 3] 1883         staa    (0x0043)
   8DB4 39            [ 5] 1884         rts
                           1885 
                           1886 ; display ASCII in B at location
   8DB5                    1887 L8DB5:
   8DB5 36            [ 3] 1888         psha
   8DB6 37            [ 3] 1889         pshb
   8DB7 C1 4F         [ 2] 1890         cmpb    #0x4F
   8DB9 22 13         [ 3] 1891         bhi     L8DCE  
   8DBB C1 28         [ 2] 1892         cmpb    #0x28
   8DBD 25 03         [ 3] 1893         bcs     L8DC2  
   8DBF 0C            [ 2] 1894         clc
   8DC0 C9 18         [ 2] 1895         adcb    #0x18
   8DC2                    1896 L8DC2:
   8DC2 0C            [ 2] 1897         clc
   8DC3 C9 80         [ 2] 1898         adcb    #0x80
   8DC5 17            [ 2] 1899         tba
   8DC6 BD 8E 4B      [ 6] 1900         jsr     L8E4B           ; send lcd command
   8DC9 33            [ 4] 1901         pulb
   8DCA 32            [ 4] 1902         pula
   8DCB BD 8E 70      [ 6] 1903         jsr     L8E70           ; send lcd char
   8DCE                    1904 L8DCE:
   8DCE 39            [ 5] 1905         rts
                           1906 
                           1907 ; 4 routines to write to the LCD display
                           1908 
                           1909 ; Write to the LCD 1st line - extend past the end of a normal display
   8DCF                    1910 LCDMSG1A:
   8DCF 18 DE 46      [ 5] 1911         ldy     (0x0046)        ; get buffer pointer
   8DD2 86 90         [ 2] 1912         ldaa    #0x90           ; command to set LCD RAM ptr to chr 0x10
   8DD4 20 13         [ 3] 1913         bra     L8DE9  
                           1914 
                           1915 ; Write to the LCD 2st line - extend past the end of a normal display
   8DD6                    1916 LCDMSG2A:
   8DD6 18 DE 46      [ 5] 1917         ldy     (0x0046)        ; get buffer pointer
   8DD9 86 D0         [ 2] 1918         ldaa    #0xD0           ; command to set LCD RAM ptr to chr 0x50
   8DDB 20 0C         [ 3] 1919         bra     L8DE9  
                           1920 
                           1921 ; Write to the LCD 2nd line
   8DDD                    1922 LCDMSG2:
   8DDD 18 DE 46      [ 5] 1923         ldy     (0x0046)        ; get buffer pointer
   8DE0 86 C0         [ 2] 1924         ldaa    #0xC0           ; command to set LCD RAM ptr to chr 0x40
   8DE2 20 05         [ 3] 1925         bra     L8DE9  
                           1926 
                           1927 ; Write to the LCD 1st line
   8DE4                    1928 LCDMSG1:
   8DE4 18 DE 46      [ 5] 1929         ldy     (0x0046)        ; get buffer pointer
   8DE7 86 80         [ 2] 1930         ldaa    #0x80           ; command to load LCD RAM ptr to chr 0x00
                           1931 
                           1932 ; Put LCD command into a buffer, 4 bytes for each entry?
   8DE9                    1933 L8DE9:
   8DE9 18 A7 00      [ 5] 1934         staa    0,Y             ; store command here
   8DEC 18 6F 01      [ 7] 1935         clr     1,Y             ; clear next byte
   8DEF 18 08         [ 4] 1936         iny
   8DF1 18 08         [ 4] 1937         iny
                           1938 
                           1939 ; Add characters at return address to LCD buffer
   8DF3 18 8C 05 80   [ 5] 1940         cpy     #0x0580         ; check for buffer overflow
   8DF7 25 04         [ 3] 1941         bcs     L8DFD           
   8DF9 18 CE 05 00   [ 4] 1942         ldy     #0x0500
   8DFD                    1943 L8DFD:
   8DFD 38            [ 5] 1944         pulx                    ; get start of data
   8DFE DF 17         [ 4] 1945         stx     (0x0017)        ; save this here
   8E00                    1946 L8E00:
   8E00 A6 00         [ 4] 1947         ldaa    0,X             ; get character
   8E02 27 36         [ 3] 1948         beq     L8E3A           ; is it 00, if so jump ahead
   8E04 2B 17         [ 3] 1949         bmi     L8E1D           ; high bit set, if so jump ahead
   8E06 18 6F 00      [ 7] 1950         clr     0,Y             ; add character
   8E09 18 A7 01      [ 5] 1951         staa    1,Y     
   8E0C 08            [ 3] 1952         inx
   8E0D 18 08         [ 4] 1953         iny
   8E0F 18 08         [ 4] 1954         iny
   8E11 18 8C 05 80   [ 5] 1955         cpy     #0x0580         ; check for buffer overflow
   8E15 25 E9         [ 3] 1956         bcs     L8E00  
   8E17 18 CE 05 00   [ 4] 1957         ldy     #0x0500
   8E1B 20 E3         [ 3] 1958         bra     L8E00  
                           1959 
   8E1D                    1960 L8E1D:
   8E1D 84 7F         [ 2] 1961         anda    #0x7F
   8E1F 18 6F 00      [ 7] 1962         clr     0,Y             ; add character
   8E22 18 A7 01      [ 5] 1963         staa    1,Y     
   8E25 18 6F 02      [ 7] 1964         clr     2,Y     
   8E28 18 6F 03      [ 7] 1965         clr     3,Y     
   8E2B 08            [ 3] 1966         inx
   8E2C 18 08         [ 4] 1967         iny
   8E2E 18 08         [ 4] 1968         iny
   8E30 18 8C 05 80   [ 5] 1969         cpy     #0x0580         ; check for overflow
   8E34 25 04         [ 3] 1970         bcs     L8E3A  
   8E36 18 CE 05 00   [ 4] 1971         ldy     #0x0500
                           1972 
   8E3A                    1973 L8E3A:
   8E3A 3C            [ 4] 1974         pshx                    ; put SP back
   8E3B 86 01         [ 2] 1975         ldaa    #0x01
   8E3D 97 43         [ 3] 1976         staa    (0x0043)        ; semaphore?
   8E3F DC 46         [ 4] 1977         ldd     (0x0046)
   8E41 18 6F 00      [ 7] 1978         clr     0,Y     
   8E44 18 6F 01      [ 7] 1979         clr     1,Y     
   8E47 18 DF 46      [ 5] 1980         sty     (0x0046)        ; save buffer pointer
   8E4A 39            [ 5] 1981         rts
                           1982 
                           1983 ; buffer LCD command?
   8E4B                    1984 L8E4B:
   8E4B 18 DE 46      [ 5] 1985         ldy     (0x0046)
   8E4E 18 A7 00      [ 5] 1986         staa    0,Y     
   8E51 18 6F 01      [ 7] 1987         clr     1,Y     
   8E54 18 08         [ 4] 1988         iny
   8E56 18 08         [ 4] 1989         iny
   8E58 18 8C 05 80   [ 5] 1990         cpy     #0x0580
   8E5C 25 04         [ 3] 1991         bcs     L8E62  
   8E5E 18 CE 05 00   [ 4] 1992         ldy     #0x0500
   8E62                    1993 L8E62:
   8E62 18 6F 00      [ 7] 1994         clr     0,Y     
   8E65 18 6F 01      [ 7] 1995         clr     1,Y     
   8E68 86 01         [ 2] 1996         ldaa    #0x01
   8E6A 97 43         [ 3] 1997         staa    (0x0043)
   8E6C 18 DF 46      [ 5] 1998         sty     (0x0046)
   8E6F 39            [ 5] 1999         rts
                           2000 
   8E70                    2001 L8E70:
   8E70 18 DE 46      [ 5] 2002         ldy     (0x0046)
   8E73 18 6F 00      [ 7] 2003         clr     0,Y     
   8E76 18 A7 01      [ 5] 2004         staa    1,Y     
   8E79 18 08         [ 4] 2005         iny
   8E7B 18 08         [ 4] 2006         iny
   8E7D 18 8C 05 80   [ 5] 2007         cpy     #0x0580
   8E81 25 04         [ 3] 2008         bcs     L8E87  
   8E83 18 CE 05 00   [ 4] 2009         ldy     #0x0500
   8E87                    2010 L8E87:
   8E87 18 6F 00      [ 7] 2011         clr     0,Y     
   8E8A 18 6F 01      [ 7] 2012         clr     1,Y     
   8E8D 86 01         [ 2] 2013         ldaa    #0x01
   8E8F 97 43         [ 3] 2014         staa    (0x0043)
   8E91 18 DF 46      [ 5] 2015         sty     (0x0046)
   8E94 39            [ 5] 2016         rts
                           2017 
   8E95                    2018 L8E95:
   8E95 96 30         [ 3] 2019         ldaa    (0x0030)
   8E97 26 09         [ 3] 2020         bne     L8EA2  
   8E99 96 31         [ 3] 2021         ldaa    (0x0031)
   8E9B 26 11         [ 3] 2022         bne     L8EAE  
   8E9D 96 32         [ 3] 2023         ldaa    (0x0032)
   8E9F 26 19         [ 3] 2024         bne     L8EBA  
   8EA1 39            [ 5] 2025         rts
                           2026 
                           2027 ;;;;;;;;;;;;;;;;;;;;;;;;;;
                           2028 
   8EA2                    2029 L8EA2:
   8EA2 7F 00 30      [ 6] 2030         clr     (0x0030)
   8EA5 7F 00 32      [ 6] 2031         clr     (0x0032)
   8EA8 7F 00 31      [ 6] 2032         clr     (0x0031)
   8EAB 86 01         [ 2] 2033         ldaa    #0x01
   8EAD 39            [ 5] 2034         rts
                           2035 
   8EAE                    2036 L8EAE:
   8EAE 7F 00 31      [ 6] 2037         clr     (0x0031)
   8EB1 7F 00 30      [ 6] 2038         clr     (0x0030)
   8EB4 7F 00 32      [ 6] 2039         clr     (0x0032)
   8EB7 86 02         [ 2] 2040         ldaa    #0x02
   8EB9 39            [ 5] 2041         rts
                           2042 
   8EBA                    2043 L8EBA:
   8EBA 7F 00 32      [ 6] 2044         clr     (0x0032)
   8EBD 7F 00 30      [ 6] 2045         clr     (0x0030)
   8EC0 7F 00 31      [ 6] 2046         clr     (0x0031)
   8EC3 86 0D         [ 2] 2047         ldaa    #0x0D
   8EC5 39            [ 5] 2048         rts
                           2049 
   8EC6                    2050 L8EC6:
   8EC6 B6 18 04      [ 4] 2051         ldaa    PIA0PRA 
   8EC9 84 07         [ 2] 2052         anda    #0x07
   8ECB 97 2C         [ 3] 2053         staa    (0x002C)
   8ECD 78 00 2C      [ 6] 2054         asl     (0x002C)
   8ED0 78 00 2C      [ 6] 2055         asl     (0x002C)
   8ED3 78 00 2C      [ 6] 2056         asl     (0x002C)
   8ED6 78 00 2C      [ 6] 2057         asl     (0x002C)
   8ED9 78 00 2C      [ 6] 2058         asl     (0x002C)
   8EDC CE 00 00      [ 3] 2059         ldx     #0x0000
   8EDF                    2060 L8EDF:
   8EDF 8C 00 03      [ 4] 2061         cpx     #0x0003
   8EE2 27 24         [ 3] 2062         beq     L8F08  
   8EE4 78 00 2C      [ 6] 2063         asl     (0x002C)
   8EE7 25 12         [ 3] 2064         bcs     L8EFB  
   8EE9 A6 2D         [ 4] 2065         ldaa    0x2D,X
   8EEB 81 0F         [ 2] 2066         cmpa    #0x0F
   8EED 24 1A         [ 3] 2067         bcc     L8F09  
   8EEF 6C 2D         [ 6] 2068         inc     0x2D,X
   8EF1 A6 2D         [ 4] 2069         ldaa    0x2D,X
   8EF3 81 02         [ 2] 2070         cmpa    #0x02
   8EF5 26 02         [ 3] 2071         bne     L8EF9  
   8EF7 A7 30         [ 4] 2072         staa    0x30,X
   8EF9                    2073 L8EF9:
   8EF9 20 0A         [ 3] 2074         bra     L8F05  
   8EFB                    2075 L8EFB:
   8EFB 6F 2D         [ 6] 2076         clr     0x2D,X
   8EFD 20 06         [ 3] 2077         bra     L8F05  
   8EFF A6 2D         [ 4] 2078         ldaa    0x2D,X
   8F01 27 02         [ 3] 2079         beq     L8F05  
   8F03 6A 2D         [ 6] 2080         dec     0x2D,X
   8F05                    2081 L8F05:
   8F05 08            [ 3] 2082         inx
   8F06 20 D7         [ 3] 2083         bra     L8EDF  
   8F08                    2084 L8F08:
   8F08 39            [ 5] 2085         rts
                           2086 
   8F09                    2087 L8F09:
   8F09 8C 00 02      [ 4] 2088         cpx     #0x0002
   8F0C 27 02         [ 3] 2089         beq     L8F10  
   8F0E 6F 2D         [ 6] 2090         clr     0x2D,X
   8F10                    2091 L8F10:
   8F10 20 F3         [ 3] 2092         bra     L8F05
                           2093 
   8F12                    2094 L8F12:
   8F12 B6 10 0A      [ 4] 2095         ldaa    PORTE
   8F15 97 51         [ 3] 2096         staa    (0x0051)
   8F17 CE 00 00      [ 3] 2097         ldx     #0x0000
   8F1A                    2098 L8F1A:
   8F1A 8C 00 08      [ 4] 2099         cpx     #0x0008
   8F1D 27 22         [ 3] 2100         beq     L8F41  
   8F1F 77 00 51      [ 6] 2101         asr     (0x0051)
   8F22 25 10         [ 3] 2102         bcs     L8F34  
   8F24 A6 52         [ 4] 2103         ldaa    0x52,X
   8F26 81 0F         [ 2] 2104         cmpa    #0x0F
   8F28 6C 52         [ 6] 2105         inc     0x52,X
   8F2A A6 52         [ 4] 2106         ldaa    0x52,X
   8F2C 81 04         [ 2] 2107         cmpa    #0x04
   8F2E 26 02         [ 3] 2108         bne     L8F32  
   8F30 A7 5A         [ 4] 2109         staa    0x5A,X
   8F32                    2110 L8F32:
   8F32 20 0A         [ 3] 2111         bra     L8F3E  
   8F34                    2112 L8F34:
   8F34 6F 52         [ 6] 2113         clr     0x52,X
   8F36 20 06         [ 3] 2114         bra     L8F3E  
   8F38 A6 52         [ 4] 2115         ldaa    0x52,X
   8F3A 27 02         [ 3] 2116         beq     L8F3E  
   8F3C 6A 52         [ 6] 2117         dec     0x52,X
   8F3E                    2118 L8F3E:
   8F3E 08            [ 3] 2119         inx
   8F3F 20 D9         [ 3] 2120         bra     L8F1A  
   8F41                    2121 L8F41:
   8F41 39            [ 5] 2122         rts
                           2123 
   8F42 6F 52         [ 6] 2124         clr     0x52,X
   8F44 20 F8         [ 3] 2125         bra     L8F3E  
                           2126 
   8F46                    2127 L8F46:
   8F46 30 2E 35           2128         .ascii      '0.5'
   8F49 31 2E 30           2129         .ascii      '1.0'
   8F4C 31 2E 35           2130         .ascii      '1.5'
   8F4F 32 2E 30           2131         .ascii      '2.0'
   8F52 32 2E 35           2132         .ascii      '2.5'
   8F55 33 2E 30           2133         .ascii      '3.0'
                           2134 
   8F58                    2135 L8F58:
   8F58 3C            [ 4] 2136         pshx
   8F59 96 12         [ 3] 2137         ldaa    (0x0012)
   8F5B 80 01         [ 2] 2138         suba    #0x01
   8F5D C6 03         [ 2] 2139         ldab    #0x03
   8F5F 3D            [10] 2140         mul
   8F60 CE 8F 46      [ 3] 2141         ldx     #L8F46
   8F63 3A            [ 3] 2142         abx
   8F64 C6 2C         [ 2] 2143         ldab    #0x2C
   8F66                    2144 L8F66:
   8F66 A6 00         [ 4] 2145         ldaa    0,X     
   8F68 08            [ 3] 2146         inx
   8F69 BD 8D B5      [ 6] 2147         jsr     L8DB5           ; display char here on LCD display
   8F6C 5C            [ 2] 2148         incb
   8F6D C1 2F         [ 2] 2149         cmpb    #0x2F
   8F6F 26 F5         [ 3] 2150         bne     L8F66  
   8F71 38            [ 5] 2151         pulx
   8F72 39            [ 5] 2152         rts
                           2153 
   8F73                    2154 L8F73:
   8F73 36            [ 3] 2155         psha
   8F74 BD 8C F2      [ 6] 2156         jsr     L8CF2
   8F77 C6 02         [ 2] 2157         ldab    #0x02
   8F79 BD 8C 30      [ 6] 2158         jsr     DLYSECSBY2   
   8F7C 32            [ 4] 2159         pula
   8F7D 97 B4         [ 3] 2160         staa    (0x00B4)
   8F7F 81 03         [ 2] 2161         cmpa    #0x03
   8F81 26 11         [ 3] 2162         bne     L8F94  
                           2163 
   8F83 BD 8D E4      [ 6] 2164         jsr     LCDMSG1 
   8F86 43 68 75 63 6B 20  2165         .ascis  'Chuck    '
        20 20 A0
                           2166 
   8F8F CE 90 72      [ 3] 2167         ldx     #L9072
   8F92 20 4D         [ 3] 2168         bra     L8FE1  
   8F94                    2169 L8F94:
   8F94 81 04         [ 2] 2170         cmpa    #0x04
   8F96 26 11         [ 3] 2171         bne     L8FA9  
                           2172 
   8F98 BD 8D E4      [ 6] 2173         jsr     LCDMSG1 
   8F9B 4A 61 73 70 65 72  2174         .ascis  'Jasper   '
        20 20 A0
                           2175 
   8FA4 CE 90 DE      [ 3] 2176         ldx     #0x90DE
   8FA7 20 38         [ 3] 2177         bra     L8FE1  
   8FA9                    2178 L8FA9:
   8FA9 81 05         [ 2] 2179         cmpa    #0x05
   8FAB 26 11         [ 3] 2180         bne     L8FBE  
                           2181 
   8FAD BD 8D E4      [ 6] 2182         jsr     LCDMSG1 
   8FB0 50 61 73 71 75 61  2183         .ascis  'Pasqually'
        6C 6C F9
                           2184 
   8FB9 CE 91 45      [ 3] 2185         ldx     #0x9145
   8FBC 20 23         [ 3] 2186         bra     L8FE1  
   8FBE                    2187 L8FBE:
   8FBE 81 06         [ 2] 2188         cmpa    #0x06
   8FC0 26 11         [ 3] 2189         bne     L8FD3  
                           2190 
   8FC2 BD 8D E4      [ 6] 2191         jsr     LCDMSG1 
   8FC5 4D 75 6E 63 68 20  2192         .ascis  'Munch    '
        20 20 A0
                           2193 
   8FCE CE 91 BA      [ 3] 2194         ldx     #0x91BA
   8FD1 20 0E         [ 3] 2195         bra     L8FE1  
   8FD3                    2196 L8FD3:
   8FD3 BD 8D E4      [ 6] 2197         jsr     LCDMSG1 
   8FD6 48 65 6C 65 6E 20  2198         .ascis  'Helen   '
        20 A0
                           2199 
   8FDE CE 92 26      [ 3] 2200         ldx     #0x9226
   8FE1                    2201 L8FE1:
   8FE1 96 B4         [ 3] 2202         ldaa    (0x00B4)
   8FE3 80 03         [ 2] 2203         suba    #0x03
   8FE5 48            [ 2] 2204         asla
   8FE6 48            [ 2] 2205         asla
   8FE7 97 4B         [ 3] 2206         staa    (0x004B)
   8FE9 BD 95 04      [ 6] 2207         jsr     L9504
   8FEC 97 4C         [ 3] 2208         staa    (0x004C)
   8FEE 81 0F         [ 2] 2209         cmpa    #0x0F
   8FF0 26 01         [ 3] 2210         bne     L8FF3  
   8FF2 39            [ 5] 2211         rts
                           2212 
   8FF3                    2213 L8FF3:
   8FF3 81 08         [ 2] 2214         cmpa    #0x08
   8FF5 23 08         [ 3] 2215         bls     L8FFF  
   8FF7 80 08         [ 2] 2216         suba    #0x08
   8FF9 D6 4B         [ 3] 2217         ldab    (0x004B)
   8FFB CB 02         [ 2] 2218         addb    #0x02
   8FFD D7 4B         [ 3] 2219         stab    (0x004B)
   8FFF                    2220 L8FFF:
   8FFF 36            [ 3] 2221         psha
   9000 18 DE 46      [ 5] 2222         ldy     (0x0046)
   9003 32            [ 4] 2223         pula
   9004 5F            [ 2] 2224         clrb
   9005 0D            [ 2] 2225         sec
   9006                    2226 L9006:
   9006 59            [ 2] 2227         rolb
   9007 4A            [ 2] 2228         deca
   9008 26 FC         [ 3] 2229         bne     L9006  
   900A D7 50         [ 3] 2230         stab    (0x0050)
   900C D6 4B         [ 3] 2231         ldab    (0x004B)
   900E CE 10 80      [ 3] 2232         ldx     #0x1080
   9011 3A            [ 3] 2233         abx
   9012 86 02         [ 2] 2234         ldaa    #0x02
   9014 97 12         [ 3] 2235         staa    (0x0012)
   9016                    2236 L9016:
   9016 A6 00         [ 4] 2237         ldaa    0,X     
   9018 98 50         [ 3] 2238         eora    (0x0050)
   901A A7 00         [ 4] 2239         staa    0,X     
   901C 6D 00         [ 6] 2240         tst     0,X     
   901E 27 16         [ 3] 2241         beq     L9036  
   9020 86 4F         [ 2] 2242         ldaa    #0x4F           ;'O'
   9022 C6 0C         [ 2] 2243         ldab    #0x0C        
   9024 BD 8D B5      [ 6] 2244         jsr     L8DB5           ; display char here on LCD display
   9027 86 6E         [ 2] 2245         ldaa    #0x6E           ;'n'
   9029 C6 0D         [ 2] 2246         ldab    #0x0D
   902B BD 8D B5      [ 6] 2247         jsr     L8DB5           ; display char here on LCD display
   902E CC 20 0E      [ 3] 2248         ldd     #0x200E         ;' '
   9031 BD 8D B5      [ 6] 2249         jsr     L8DB5           ; display char here on LCD display
   9034 20 0E         [ 3] 2250         bra     L9044  
   9036                    2251 L9036:
   9036 86 66         [ 2] 2252         ldaa    #0x66           ;'f'
   9038 C6 0D         [ 2] 2253         ldab    #0x0D
   903A BD 8D B5      [ 6] 2254         jsr     L8DB5           ; display char here on LCD display
   903D 86 66         [ 2] 2255         ldaa    #0x66           ;'f'
   903F C6 0E         [ 2] 2256         ldab    #0x0E
   9041 BD 8D B5      [ 6] 2257         jsr     L8DB5           ; display char here on LCD display
   9044                    2258 L9044:
   9044 D6 12         [ 3] 2259         ldab    (0x0012)
   9046 BD 8C 30      [ 6] 2260         jsr     DLYSECSBY2      ; delay in half-seconds
   9049 BD 8E 95      [ 6] 2261         jsr     L8E95
   904C 81 0D         [ 2] 2262         cmpa    #0x0D
   904E 27 14         [ 3] 2263         beq     L9064  
   9050 20 C4         [ 3] 2264         bra     L9016  
   9052 81 02         [ 2] 2265         cmpa    #0x02
   9054 26 C0         [ 3] 2266         bne     L9016  
   9056 96 12         [ 3] 2267         ldaa    (0x0012)
   9058 81 06         [ 2] 2268         cmpa    #0x06
   905A 27 BA         [ 3] 2269         beq     L9016  
   905C 4C            [ 2] 2270         inca
   905D 97 12         [ 3] 2271         staa    (0x0012)
   905F BD 8F 58      [ 6] 2272         jsr     L8F58
   9062 20 B2         [ 3] 2273         bra     L9016  
   9064                    2274 L9064:
   9064 A6 00         [ 4] 2275         ldaa    0,X     
   9066 9A 50         [ 3] 2276         oraa    (0x0050)
   9068 98 50         [ 3] 2277         eora    (0x0050)
   906A A7 00         [ 4] 2278         staa    0,X     
   906C 96 B4         [ 3] 2279         ldaa    (0x00B4)
   906E 7E 8F 73      [ 3] 2280         jmp     L8F73
   9071 39            [ 5] 2281         rts
                           2282 
   9072                    2283 L9072:
   9072 4D 6F 75 74 68 2C  2284         .ascis  'Mouth,Head left,Head right,Head up,Eyes right,Eyelids,Right hand,Eyes left,DS9,DS10,DS11,DS12,DS13,DS14,Exit'
        48 65 61 64 20 6C
        65 66 74 2C 48 65
        61 64 20 72 69 67
        68 74 2C 48 65 61
        64 20 75 70 2C 45
        79 65 73 20 72 69
        67 68 74 2C 45 79
        65 6C 69 64 73 2C
        52 69 67 68 74 20
        68 61 6E 64 2C 45
        79 65 73 20 6C 65
        66 74 2C 44 53 39
        2C 44 53 31 30 2C
        44 53 31 31 2C 44
        53 31 32 2C 44 53
        31 33 2C 44 53 31
        34 2C 45 78 69 F4
   90DE 4D 6F 75 74 68 2C  2285         .ascis  'Mouth,Head left,Head right,Head up,Eyes right,Eyelids,Hands,Eyes left,DS9,DS10,DS11,DS12,DS13,DS14,Exit'
        48 65 61 64 20 6C
        65 66 74 2C 48 65
        61 64 20 72 69 67
        68 74 2C 48 65 61
        64 20 75 70 2C 45
        79 65 73 20 72 69
        67 68 74 2C 45 79
        65 6C 69 64 73 2C
        48 61 6E 64 73 2C
        45 79 65 73 20 6C
        65 66 74 2C 44 53
        39 2C 44 53 31 30
        2C 44 53 31 31 2C
        44 53 31 32 2C 44
        53 31 33 2C 44 53
        31 34 2C 45 78 69
        F4
   9145 4D 6F 75 74 68 2D  2286         .ascis  'Mouth-Mustache,Head left,Head right,Left arm,Eyes right,Eyelids,Right arm,Eyes left,DS9,DS10,DS11,DS12,DS13,DS14,Exit'
        4D 75 73 74 61 63
        68 65 2C 48 65 61
        64 20 6C 65 66 74
        2C 48 65 61 64 20
        72 69 67 68 74 2C
        4C 65 66 74 20 61
        72 6D 2C 45 79 65
        73 20 72 69 67 68
        74 2C 45 79 65 6C
        69 64 73 2C 52 69
        67 68 74 20 61 72
        6D 2C 45 79 65 73
        20 6C 65 66 74 2C
        44 53 39 2C 44 53
        31 30 2C 44 53 31
        31 2C 44 53 31 32
        2C 44 53 31 33 2C
        44 53 31 34 2C 45
        78 69 F4
   91BA 4D 6F 75 74 68 2C  2287         .ascis  'Mouth,Head left,Head right,Left arm,Eyes right,Eyelids,Right arm,Eyes left,DS9,DS10,DS11,DS12,DS13,DS14,Exit'
        48 65 61 64 20 6C
        65 66 74 2C 48 65
        61 64 20 72 69 67
        68 74 2C 4C 65 66
        74 20 61 72 6D 2C
        45 79 65 73 20 72
        69 67 68 74 2C 45
        79 65 6C 69 64 73
        2C 52 69 67 68 74
        20 61 72 6D 2C 45
        79 65 73 20 6C 65
        66 74 2C 44 53 39
        2C 44 53 31 30 2C
        44 53 31 31 2C 44
        53 31 32 2C 44 53
        31 33 2C 44 53 31
        34 2C 45 78 69 F4
   9226 4D 6F 75 74 68 2C  2288         .ascis  'Mouth,Head left,Head right,Head up,Eyes right,Eyelids,Right hand,Eyes left,DS9,DS10,DS11,DS12,DS13,DS14,Exit'
        48 65 61 64 20 6C
        65 66 74 2C 48 65
        61 64 20 72 69 67
        68 74 2C 48 65 61
        64 20 75 70 2C 45
        79 65 73 20 72 69
        67 68 74 2C 45 79
        65 6C 69 64 73 2C
        52 69 67 68 74 20
        68 61 6E 64 2C 45
        79 65 73 20 6C 65
        66 74 2C 44 53 39
        2C 44 53 31 30 2C
        44 53 31 31 2C 44
        53 31 32 2C 44 53
        31 33 2C 44 53 31
        34 2C 45 78 69 F4
                           2289         
                           2290 ; code again
   9292                    2291 L9292:
   9292 BD 86 C4      [ 6] 2292         jsr     L86C4           ; Reset boards 1-10
   9295                    2293 L9295:
   9295 C6 01         [ 2] 2294         ldab    #0x01
   9297 BD 8C 30      [ 6] 2295         jsr     DLYSECSBY2      ; delay 0.5 sec
                           2296 
   929A BD 8D E4      [ 6] 2297         jsr     LCDMSG1 
   929D 20 20 44 69 61 67  2298         .ascis  '  Diagnostics   '
        6E 6F 73 74 69 63
        73 20 20 A0
                           2299 
   92AD BD 8D DD      [ 6] 2300         jsr     LCDMSG2 
   92B0 20 20 20 20 20 20  2301         .ascis  '                '
        20 20 20 20 20 20
        20 20 20 A0
                           2302 
   92C0 C6 01         [ 2] 2303         ldab    #0x01
   92C2 BD 8C 30      [ 6] 2304         jsr     DLYSECSBY2      ; delay 0.5 sec
   92C5 BD 8D 03      [ 6] 2305         jsr     L8D03
   92C8 CE 93 D3      [ 3] 2306         ldx     #L93D3
   92CB BD 95 04      [ 6] 2307         jsr     L9504
   92CE 81 11         [ 2] 2308         cmpa    #0x11
   92D0 26 14         [ 3] 2309         bne     L92E6
   92D2                    2310 L92D2:
   92D2 BD 86 C4      [ 6] 2311         jsr     L86C4           ; Reset boards 1-10
   92D5 5F            [ 2] 2312         clrb
   92D6 D7 62         [ 3] 2313         stab    (0x0062)
   92D8 BD F9 C5      [ 6] 2314         jsr     BUTNLIT 
   92DB B6 18 04      [ 4] 2315         ldaa    PIA0PRA 
   92DE 84 BF         [ 2] 2316         anda    #0xBF
   92E0 B7 18 04      [ 4] 2317         staa    PIA0PRA 
   92E3 7E 81 D7      [ 3] 2318         jmp     L81D7
   92E6                    2319 L92E6:
   92E6 81 03         [ 2] 2320         cmpa    #0x03
   92E8 25 09         [ 3] 2321         bcs     L92F3  
   92EA 81 08         [ 2] 2322         cmpa    #0x08
   92EC 24 05         [ 3] 2323         bcc     L92F3  
   92EE BD 8F 73      [ 6] 2324         jsr     L8F73
   92F1 20 A2         [ 3] 2325         bra     L9295  
   92F3                    2326 L92F3:
   92F3 81 02         [ 2] 2327         cmpa    #0x02
   92F5 26 08         [ 3] 2328         bne     L92FF  
   92F7 BD 9F 1E      [ 6] 2329         jsr     L9F1E
   92FA 25 99         [ 3] 2330         bcs     L9295  
   92FC 7E 96 75      [ 3] 2331         jmp     L9675
   92FF                    2332 L92FF:
   92FF 81 0B         [ 2] 2333         cmpa    #0x0B
   9301 26 0D         [ 3] 2334         bne     L9310  
   9303 BD 8D 03      [ 6] 2335         jsr     L8D03
   9306 BD 9E CC      [ 6] 2336         jsr     L9ECC
   9309 C6 03         [ 2] 2337         ldab    #0x03
   930B BD 8C 30      [ 6] 2338         jsr     DLYSECSBY2      ; delay 1.5 sec
   930E 20 85         [ 3] 2339         bra     L9295  
   9310                    2340 L9310:
   9310 81 09         [ 2] 2341         cmpa    #0x09
   9312 26 0E         [ 3] 2342         bne     L9322  
   9314 BD 9F 1E      [ 6] 2343         jsr     L9F1E
   9317 24 03         [ 3] 2344         bcc     L931C  
   9319 7E 92 95      [ 3] 2345         jmp     L9295
   931C                    2346 L931C:
   931C BD 9E 92      [ 6] 2347         jsr     L9E92           ; reset R counts
   931F 7E 92 95      [ 3] 2348         jmp     L9295
   9322                    2349 L9322:
   9322 81 0A         [ 2] 2350         cmpa    #0x0A
   9324 26 0B         [ 3] 2351         bne     L9331  
   9326 BD 9F 1E      [ 6] 2352         jsr     L9F1E
   9329 25 03         [ 3] 2353         bcs     L932E  
   932B BD 9E AF      [ 6] 2354         jsr     L9EAF           ; reset L counts
   932E                    2355 L932E:
   932E 7E 92 95      [ 3] 2356         jmp     L9295
   9331                    2357 L9331:
   9331 81 01         [ 2] 2358         cmpa    #0x01
   9333 26 03         [ 3] 2359         bne     L9338  
   9335 7E A0 E9      [ 3] 2360         jmp     LA0E9
   9338                    2361 L9338:
   9338 81 08         [ 2] 2362         cmpa    #0x08
   933A 26 1F         [ 3] 2363         bne     L935B  
   933C BD 9F 1E      [ 6] 2364         jsr     L9F1E
   933F 25 1A         [ 3] 2365         bcs     L935B  
                           2366 
   9341 BD 8D E4      [ 6] 2367         jsr     LCDMSG1 
   9344 52 65 73 65 74 20  2368         .ascis  'Reset System!'
        53 79 73 74 65 6D
        A1
                           2369 
   9351 7E A2 49      [ 3] 2370         jmp     LA249
   9354 C6 02         [ 2] 2371         ldab    #0x02
   9356 BD 8C 30      [ 6] 2372         jsr     DLYSECSBY2      ; delay 1 sec
   9359 20 18         [ 3] 2373         bra     L9373  
   935B                    2374 L935B:
   935B 81 0C         [ 2] 2375         cmpa    #0x0C
   935D 26 14         [ 3] 2376         bne     L9373  
   935F BD 8B 48      [ 6] 2377         jsr     L8B48
   9362 5F            [ 2] 2378         clrb
   9363 D7 62         [ 3] 2379         stab    (0x0062)
   9365 BD F9 C5      [ 6] 2380         jsr     BUTNLIT 
   9368 B6 18 04      [ 4] 2381         ldaa    PIA0PRA 
   936B 84 BF         [ 2] 2382         anda    #0xBF
   936D B7 18 04      [ 4] 2383         staa    PIA0PRA 
   9370 7E 92 92      [ 3] 2384         jmp     L9292
   9373                    2385 L9373:
   9373 81 0D         [ 2] 2386         cmpa    #0x0D
   9375 26 2E         [ 3] 2387         bne     L93A5  
   9377 BD 8C E9      [ 6] 2388         jsr     L8CE9
                           2389 
   937A BD 8D E4      [ 6] 2390         jsr     LCDMSG1 
   937D 20 20 42 75 74 74  2391         .ascis  '  Button  test'
        6F 6E 20 20 74 65
        73 F4
                           2392 
   938B BD 8D DD      [ 6] 2393         jsr     LCDMSG2 
   938E 20 20 20 50 52 4F  2394         .ascis  '   PROG exits'
        47 20 65 78 69 74
        F3
                           2395 
   939B BD A5 26      [ 6] 2396         jsr     LA526
   939E 5F            [ 2] 2397         clrb
   939F BD F9 C5      [ 6] 2398         jsr     BUTNLIT 
   93A2 7E 92 95      [ 3] 2399         jmp     L9295
   93A5                    2400 L93A5:
   93A5 81 0E         [ 2] 2401         cmpa    #0x0E
   93A7 26 10         [ 3] 2402         bne     L93B9  
   93A9 BD 9F 1E      [ 6] 2403         jsr     L9F1E
   93AC 24 03         [ 3] 2404         bcc     L93B1  
   93AE 7E 92 95      [ 3] 2405         jmp     L9295
   93B1                    2406 L93B1:
   93B1 C6 01         [ 2] 2407         ldab    #0x01
   93B3 BD 8C 30      [ 6] 2408         jsr     DLYSECSBY2      ; delay 0.5 sec
   93B6 7E 94 9A      [ 3] 2409         jmp     L949A
   93B9                    2410 L93B9:
   93B9 81 0F         [ 2] 2411         cmpa    #0x0F
   93BB 26 06         [ 3] 2412         bne     L93C3  
   93BD BD A8 6A      [ 6] 2413         jsr     LA86A
   93C0 7E 92 95      [ 3] 2414         jmp     L9295
   93C3                    2415 L93C3:
   93C3 81 10         [ 2] 2416         cmpa    #0x10
   93C5 26 09         [ 3] 2417         bne     L93D0  
   93C7 BD 9F 1E      [ 6] 2418         jsr     L9F1E
   93CA BD 95 BA      [ 6] 2419         jsr     L95BA
   93CD 7E 92 95      [ 3] 2420         jmp     L9295
                           2421 
   93D0                    2422 L93D0:
   93D0 7E 92 D2      [ 3] 2423         jmp     L92D2
                           2424 
   93D3                    2425 L93D3:
   93D3 56 43 52 20 61 64  2426         .ascis  "VCR adjust,Set Random,Chuck E. Cheese,Jasper,Pasqually,Munch,Helen,Reset System,Reset reg tape#,Reset liv tape#,View Tape #'s,All Lights On,Button test,King enable,Warm-Up,Show Type,Quit Diagnostics"
        6A 75 73 74 2C 53
        65 74 20 52 61 6E
        64 6F 6D 2C 43 68
        75 63 6B 20 45 2E
        20 43 68 65 65 73
        65 2C 4A 61 73 70
        65 72 2C 50 61 73
        71 75 61 6C 6C 79
        2C 4D 75 6E 63 68
        2C 48 65 6C 65 6E
        2C 52 65 73 65 74
        20 53 79 73 74 65
        6D 2C 52 65 73 65
        74 20 72 65 67 20
        74 61 70 65 23 2C
        52 65 73 65 74 20
        6C 69 76 20 74 61
        70 65 23 2C 56 69
        65 77 20 54 61 70
        65 20 23 27 73 2C
        41 6C 6C 20 4C 69
        67 68 74 73 20 4F
        6E 2C 42 75 74 74
        6F 6E 20 74 65 73
        74 2C 4B 69 6E 67
        20 65 6E 61 62 6C
        65 2C 57 61 72 6D
        2D 55 70 2C 53 68
        6F 77 20 54 79 70
        65 2C 51 75 69 74
        20 44 69 61 67 6E
        6F 73 74 69 63 F3
   9499 00                 2427         .byte   0x00
                           2428 
   949A                    2429 L949A:
   949A 7D 04 2A      [ 6] 2430         tst     (0x042A)
   949D 27 27         [ 3] 2431         beq     L94C6  
                           2432 
   949F BD 8D E4      [ 6] 2433         jsr     LCDMSG1 
   94A2 4B 69 6E 67 20 69  2434         .ascis  'King is Enabled'
        73 20 45 6E 61 62
        6C 65 E4
                           2435 
   94B1 BD 8D DD      [ 6] 2436         jsr     LCDMSG2 
   94B4 45 4E 54 45 52 20  2437         .ascis  'ENTER to disable'
        74 6F 20 64 69 73
        61 62 6C E5
                           2438 
   94C4 20 25         [ 3] 2439         bra     L94EB  
                           2440 
   94C6                    2441 L94C6:
   94C6 BD 8D E4      [ 6] 2442         jsr     LCDMSG1 
   94C9 4B 69 6E 67 20 69  2443         .ascis  'King is Disabled'
        73 20 44 69 73 61
        62 6C 65 E4
                           2444 
   94D9 BD 8D DD      [ 6] 2445         jsr     LCDMSG2 
   94DC 45 4E 54 45 52 20  2446         .ascis  'ENTER to enable'
        74 6F 20 65 6E 61
        62 6C E5
                           2447 
   94EB                    2448 L94EB:
   94EB BD 8E 95      [ 6] 2449         jsr     L8E95
   94EE 4D            [ 2] 2450         tsta
   94EF 27 FA         [ 3] 2451         beq     L94EB  
   94F1 81 0D         [ 2] 2452         cmpa    #0x0D
   94F3 27 02         [ 3] 2453         beq     L94F7  
   94F5 20 0A         [ 3] 2454         bra     L9501  
   94F7                    2455 L94F7:
   94F7 B6 04 2A      [ 4] 2456         ldaa    (0x042A)
   94FA 84 01         [ 2] 2457         anda    #0x01
   94FC 88 01         [ 2] 2458         eora    #0x01
   94FE B7 04 2A      [ 4] 2459         staa    (0x042A)
   9501                    2460 L9501:
   9501 7E 92 95      [ 3] 2461         jmp     L9295
   9504                    2462 L9504:
   9504 86 01         [ 2] 2463         ldaa    #0x01
   9506 97 A6         [ 3] 2464         staa    (0x00A6)
   9508 97 A7         [ 3] 2465         staa    (0x00A7)
   950A DF 12         [ 4] 2466         stx     (0x0012)
   950C 20 09         [ 3] 2467         bra     L9517  
   950E 86 01         [ 2] 2468         ldaa    #0x01
   9510 97 A7         [ 3] 2469         staa    (0x00A7)
   9512 7F 00 A6      [ 6] 2470         clr     (0x00A6)
   9515 DF 12         [ 4] 2471         stx     (0x0012)
   9517                    2472 L9517:
   9517 7F 00 16      [ 6] 2473         clr     (0x0016)
   951A 18 DE 46      [ 5] 2474         ldy     (0x0046)
   951D 7D 00 A6      [ 6] 2475         tst     (0x00A6)
   9520 26 07         [ 3] 2476         bne     L9529  
   9522 BD 8C F2      [ 6] 2477         jsr     L8CF2
   9525 86 80         [ 2] 2478         ldaa    #0x80
   9527 20 05         [ 3] 2479         bra     L952E  
   9529                    2480 L9529:
   9529 BD 8D 03      [ 6] 2481         jsr     L8D03
   952C 86 C0         [ 2] 2482         ldaa    #0xC0
   952E                    2483 L952E:
   952E 18 A7 00      [ 5] 2484         staa    0,Y     
   9531 18 6F 01      [ 7] 2485         clr     1,Y     
   9534 18 08         [ 4] 2486         iny
   9536 18 08         [ 4] 2487         iny
   9538 18 8C 05 80   [ 5] 2488         cpy     #0x0580
   953C 25 04         [ 3] 2489         bcs     L9542  
   953E 18 CE 05 00   [ 4] 2490         ldy     #0x0500
   9542                    2491 L9542:
   9542 DF 14         [ 4] 2492         stx     (0x0014)
   9544                    2493 L9544:
   9544 A6 00         [ 4] 2494         ldaa    0,X     
   9546 2A 04         [ 3] 2495         bpl     L954C  
   9548 C6 01         [ 2] 2496         ldab    #0x01
   954A D7 16         [ 3] 2497         stab    (0x0016)
   954C                    2498 L954C:
   954C 81 2C         [ 2] 2499         cmpa    #0x2C
   954E 27 1E         [ 3] 2500         beq     L956E  
   9550 18 6F 00      [ 7] 2501         clr     0,Y     
   9553 84 7F         [ 2] 2502         anda    #0x7F
   9555 18 A7 01      [ 5] 2503         staa    1,Y     
   9558 18 08         [ 4] 2504         iny
   955A 18 08         [ 4] 2505         iny
   955C 18 8C 05 80   [ 5] 2506         cpy     #0x0580
   9560 25 04         [ 3] 2507         bcs     L9566  
   9562 18 CE 05 00   [ 4] 2508         ldy     #0x0500
   9566                    2509 L9566:
   9566 7D 00 16      [ 6] 2510         tst     (0x0016)
   9569 26 03         [ 3] 2511         bne     L956E  
   956B 08            [ 3] 2512         inx
   956C 20 D6         [ 3] 2513         bra     L9544  
   956E                    2514 L956E:
   956E 08            [ 3] 2515         inx
   956F 86 01         [ 2] 2516         ldaa    #0x01
   9571 97 43         [ 3] 2517         staa    (0x0043)
   9573 18 6F 00      [ 7] 2518         clr     0,Y     
   9576 18 6F 01      [ 7] 2519         clr     1,Y     
   9579 18 DF 46      [ 5] 2520         sty     (0x0046)
   957C                    2521 L957C:
   957C BD 8E 95      [ 6] 2522         jsr     L8E95
   957F 27 FB         [ 3] 2523         beq     L957C  
   9581 81 02         [ 2] 2524         cmpa    #0x02
   9583 26 0A         [ 3] 2525         bne     L958F  
   9585 7D 00 16      [ 6] 2526         tst     (0x0016)
   9588 26 05         [ 3] 2527         bne     L958F  
   958A 7C 00 A7      [ 6] 2528         inc     (0x00A7)
   958D 20 88         [ 3] 2529         bra     L9517  
   958F                    2530 L958F:
   958F 81 01         [ 2] 2531         cmpa    #0x01
   9591 26 20         [ 3] 2532         bne     L95B3  
   9593 18 DE 14      [ 5] 2533         ldy     (0x0014)
   9596 18 9C 12      [ 6] 2534         cpy     (0x0012)
   9599 23 E1         [ 3] 2535         bls     L957C  
   959B 7A 00 A7      [ 6] 2536         dec     (0x00A7)
   959E DE 14         [ 4] 2537         ldx     (0x0014)
   95A0 09            [ 3] 2538         dex
   95A1                    2539 L95A1:
   95A1 09            [ 3] 2540         dex
   95A2 9C 12         [ 5] 2541         cpx     (0x0012)
   95A4 26 03         [ 3] 2542         bne     L95A9  
   95A6 7E 95 17      [ 3] 2543         jmp     L9517
   95A9                    2544 L95A9:
   95A9 A6 00         [ 4] 2545         ldaa    0,X     
   95AB 81 2C         [ 2] 2546         cmpa    #0x2C
   95AD 26 F2         [ 3] 2547         bne     L95A1  
   95AF 08            [ 3] 2548         inx
   95B0 7E 95 17      [ 3] 2549         jmp     L9517
   95B3                    2550 L95B3:
   95B3 81 0D         [ 2] 2551         cmpa    #0x0D
   95B5 26 C5         [ 3] 2552         bne     L957C  
   95B7 96 A7         [ 3] 2553         ldaa    (0x00A7)
   95B9 39            [ 5] 2554         rts
                           2555 
   95BA                    2556 L95BA:
   95BA B6 04 5C      [ 4] 2557         ldaa    (0x045C)
   95BD 27 14         [ 3] 2558         beq     L95D3  
                           2559 
   95BF BD 8D E4      [ 6] 2560         jsr     LCDMSG1 
   95C2 43 75 72 72 65 6E  2561         .ascis  'Current: CNR   '
        74 3A 20 43 4E 52
        20 20 A0
                           2562 
   95D1 20 12         [ 3] 2563         bra     L95E5  
                           2564 
   95D3                    2565 L95D3:
   95D3 BD 8D E4      [ 6] 2566         jsr     LCDMSG1 
   95D6 43 75 72 72 65 6E  2567         .ascis  'Current: R12   '
        74 3A 20 52 31 32
        20 20 A0
                           2568 
   95E5                    2569 L95E5:
   95E5 BD 8D DD      [ 6] 2570         jsr     LCDMSG2 
   95E8 3C 45 6E 74 65 72  2571         .ascis  '<Enter> to chg.'
        3E 20 74 6F 20 63
        68 67 AE
                           2572 
   95F7                    2573 L95F7:
   95F7 BD 8E 95      [ 6] 2574         jsr     L8E95
   95FA 27 FB         [ 3] 2575         beq     L95F7  
   95FC 81 0D         [ 2] 2576         cmpa    #0x0D
   95FE 26 0F         [ 3] 2577         bne     L960F  
   9600 B6 04 5C      [ 4] 2578         ldaa    (0x045C)
   9603 27 05         [ 3] 2579         beq     L960A  
   9605 7F 04 5C      [ 6] 2580         clr     (0x045C)
   9608 20 05         [ 3] 2581         bra     L960F  
   960A                    2582 L960A:
   960A 86 01         [ 2] 2583         ldaa    #0x01
   960C B7 04 5C      [ 4] 2584         staa    (0x045C)
   960F                    2585 L960F:
   960F 39            [ 5] 2586         rts
                           2587 
   9610                    2588 L9610:
   9610 43 68 75 63 6B 2C  2589         .ascis  "Chuck,Jasper,Pasqually,Munch,Helen,Light 1,Light 2,Light 3,Star EFX,Wink Spot,Gobo,Clear All Rnd,Exit"
        4A 61 73 70 65 72
        2C 50 61 73 71 75
        61 6C 6C 79 2C 4D
        75 6E 63 68 2C 48
        65 6C 65 6E 2C 4C
        69 67 68 74 20 31
        2C 4C 69 67 68 74
        20 32 2C 4C 69 67
        68 74 20 33 2C 53
        74 61 72 20 45 46
        58 2C 57 69 6E 6B
        20 53 70 6F 74 2C
        47 6F 62 6F 2C 43
        6C 65 61 72 20 41
        6C 6C 20 52 6E 64
        2C 45 78 69 F4
                           2590 
   9675                    2591 L9675:
   9675 BD 8D E4      [ 6] 2592         jsr     LCDMSG1 
   9678 52 61 6E 64 6F 6D  2593         .ascis  'Random          '
        20 20 20 20 20 20
        20 20 20 A0
                           2594 
   9688 CE 96 10      [ 3] 2595         ldx     #L9610
   968B BD 95 04      [ 6] 2596         jsr     L9504
   968E 5F            [ 2] 2597         clrb
   968F 37            [ 3] 2598         pshb
   9690 81 0D         [ 2] 2599         cmpa    #0x0D
   9692 26 03         [ 3] 2600         bne     L9697  
   9694 7E 97 5B      [ 3] 2601         jmp     L975B
   9697                    2602 L9697:
   9697 81 0C         [ 2] 2603         cmpa    #0x0C
   9699 26 21         [ 3] 2604         bne     L96BC  
   969B 7F 04 01      [ 6] 2605         clr     (0x0401)
   969E 7F 04 2B      [ 6] 2606         clr     (0x042B)
                           2607 
   96A1 BD 8D E4      [ 6] 2608         jsr     LCDMSG1 
   96A4 41 6C 6C 20 52 6E  2609         .ascis  'All Rnd Cleared!'
        64 20 43 6C 65 61
        72 65 64 A1
                           2610 
   96B4 C6 64         [ 2] 2611         ldab    #0x64           ; delay 1 sec
   96B6 BD 8C 22      [ 6] 2612         jsr     DLYSECSBY100
   96B9 7E 97 5B      [ 3] 2613         jmp     L975B
   96BC                    2614 L96BC:
   96BC 81 09         [ 2] 2615         cmpa    #0x09
   96BE 25 05         [ 3] 2616         bcs     L96C5  
   96C0 80 08         [ 2] 2617         suba    #0x08
   96C2 33            [ 4] 2618         pulb
   96C3 5C            [ 2] 2619         incb
   96C4 37            [ 3] 2620         pshb
   96C5                    2621 L96C5:
   96C5 5F            [ 2] 2622         clrb
   96C6 0D            [ 2] 2623         sec
   96C7                    2624 L96C7:
   96C7 59            [ 2] 2625         rolb
   96C8 4A            [ 2] 2626         deca
   96C9 26 FC         [ 3] 2627         bne     L96C7  
   96CB D7 12         [ 3] 2628         stab    (0x0012)
   96CD C8 FF         [ 2] 2629         eorb    #0xFF
   96CF D7 13         [ 3] 2630         stab    (0x0013)
   96D1                    2631 L96D1:
   96D1 CC 20 34      [ 3] 2632         ldd     #0x2034         ;' '
   96D4 BD 8D B5      [ 6] 2633         jsr     L8DB5           ; display char here on LCD display
   96D7 33            [ 4] 2634         pulb
   96D8 37            [ 3] 2635         pshb
   96D9 5D            [ 2] 2636         tstb
   96DA 27 05         [ 3] 2637         beq     L96E1  
   96DC B6 04 2B      [ 4] 2638         ldaa    (0x042B)
   96DF 20 03         [ 3] 2639         bra     L96E4  
   96E1                    2640 L96E1:
   96E1 B6 04 01      [ 4] 2641         ldaa    (0x0401)
   96E4                    2642 L96E4:
   96E4 94 12         [ 3] 2643         anda    (0x0012)
   96E6 27 0A         [ 3] 2644         beq     L96F2  
   96E8 18 DE 46      [ 5] 2645         ldy     (0x0046)
   96EB BD 8D FD      [ 6] 2646         jsr     L8DFD
   96EE 4F            [ 2] 2647         clra
   96EF EE 20         [ 5] 2648         ldx     0x20,X
   96F1 09            [ 3] 2649         dex
   96F2                    2650 L96F2:
   96F2 18 DE 46      [ 5] 2651         ldy     (0x0046)
   96F5 BD 8D FD      [ 6] 2652         jsr     L8DFD
   96F8 4F            [ 2] 2653         clra
   96F9 66 E6         [ 6] 2654         ror     0xE6,X
   96FB CC 20 34      [ 3] 2655         ldd     #0x2034         ;' '
   96FE BD 8D B5      [ 6] 2656         jsr     L8DB5           ; display char here on LCD display
   9701                    2657 L9701:
   9701 BD 8E 95      [ 6] 2658         jsr     L8E95
   9704 27 FB         [ 3] 2659         beq     L9701  
   9706 81 01         [ 2] 2660         cmpa    #0x01
   9708 26 22         [ 3] 2661         bne     L972C  
   970A 33            [ 4] 2662         pulb
   970B 37            [ 3] 2663         pshb
   970C 5D            [ 2] 2664         tstb
   970D 27 0A         [ 3] 2665         beq     L9719  
   970F B6 04 2B      [ 4] 2666         ldaa    (0x042B)
   9712 9A 12         [ 3] 2667         oraa    (0x0012)
   9714 B7 04 2B      [ 4] 2668         staa    (0x042B)
   9717 20 08         [ 3] 2669         bra     L9721  
   9719                    2670 L9719:
   9719 B6 04 01      [ 4] 2671         ldaa    (0x0401)
   971C 9A 12         [ 3] 2672         oraa    (0x0012)
   971E B7 04 01      [ 4] 2673         staa    (0x0401)
   9721                    2674 L9721:
   9721 18 DE 46      [ 5] 2675         ldy     (0x0046)
   9724 BD 8D FD      [ 6] 2676         jsr     L8DFD
   9727 4F            [ 2] 2677         clra
   9728 6E A0         [ 3] 2678         jmp     0xA0,X
   972A 20 A5         [ 3] 2679         bra     L96D1  
   972C                    2680 L972C:
   972C 81 02         [ 2] 2681         cmpa    #0x02
   972E 26 23         [ 3] 2682         bne     L9753  
   9730 33            [ 4] 2683         pulb
   9731 37            [ 3] 2684         pshb
   9732 5D            [ 2] 2685         tstb
   9733 27 0A         [ 3] 2686         beq     L973F  
   9735 B6 04 2B      [ 4] 2687         ldaa    (0x042B)
   9738 94 13         [ 3] 2688         anda    (0x0013)
   973A B7 04 2B      [ 4] 2689         staa    (0x042B)
   973D 20 08         [ 3] 2690         bra     L9747  
   973F                    2691 L973F:
   973F B6 04 01      [ 4] 2692         ldaa    (0x0401)
   9742 94 13         [ 3] 2693         anda    (0x0013)
   9744 B7 04 01      [ 4] 2694         staa    (0x0401)
   9747                    2695 L9747:
   9747 18 DE 46      [ 5] 2696         ldy     (0x0046)
   974A BD 8D FD      [ 6] 2697         jsr     L8DFD
   974D 4F            [ 2] 2698         clra
   974E 66 E6         [ 6] 2699         ror     0xE6,X
   9750 7E 96 D1      [ 3] 2700         jmp     L96D1
   9753                    2701 L9753:
   9753 81 0D         [ 2] 2702         cmpa    #0x0D
   9755 26 AA         [ 3] 2703         bne     L9701  
   9757 33            [ 4] 2704         pulb
   9758 7E 96 75      [ 3] 2705         jmp     L9675
   975B                    2706 L975B:
   975B 33            [ 4] 2707         pulb
   975C 7E 92 92      [ 3] 2708         jmp     L9292
                           2709 
                           2710 ; do program rom checksum, and display it on the LCD screen
   975F                    2711 L975F:
   975F CE 00 00      [ 3] 2712         ldx     #0x0000
   9762 18 CE 80 00   [ 4] 2713         ldy     #0x8000
   9766                    2714 L9766:
   9766 18 E6 00      [ 5] 2715         ldab    0,Y     
   9769 18 08         [ 4] 2716         iny
   976B 3A            [ 3] 2717         abx
   976C 18 8C 00 00   [ 5] 2718         cpy     #0x0000
   9770 26 F4         [ 3] 2719         bne     L9766  
   9772 DF 17         [ 4] 2720         stx     (0x0017)        ; store rom checksum here
   9774 96 17         [ 3] 2721         ldaa    (0x0017)        ; get high byte of checksum
   9776 BD 97 9B      [ 6] 2722         jsr     L979B           ; convert it to 2 hex chars
   9779 96 12         [ 3] 2723         ldaa    (0x0012)
   977B C6 33         [ 2] 2724         ldab    #0x33
   977D BD 8D B5      [ 6] 2725         jsr     L8DB5           ; display char 1 here on LCD display
   9780 96 13         [ 3] 2726         ldaa    (0x0013)
   9782 C6 34         [ 2] 2727         ldab    #0x34
   9784 BD 8D B5      [ 6] 2728         jsr     L8DB5           ; display char 2 here on LCD display
   9787 96 18         [ 3] 2729         ldaa    (0x0018)        ; get low byte of checksum
   9789 BD 97 9B      [ 6] 2730         jsr     L979B           ; convert it to 2 hex chars
   978C 96 12         [ 3] 2731         ldaa    (0x0012)
   978E C6 35         [ 2] 2732         ldab    #0x35
   9790 BD 8D B5      [ 6] 2733         jsr     L8DB5           ; display char 1 here on LCD display
   9793 96 13         [ 3] 2734         ldaa    (0x0013)
   9795 C6 36         [ 2] 2735         ldab    #0x36
   9797 BD 8D B5      [ 6] 2736         jsr     L8DB5           ; display char 2 here on LCD display
   979A 39            [ 5] 2737         rts
                           2738 
                           2739 ; convert A to ASCII hex digit, store in (0x0012:0x0013)
   979B                    2740 L979B:
   979B 36            [ 3] 2741         psha
   979C 84 0F         [ 2] 2742         anda    #0x0F
   979E 8B 30         [ 2] 2743         adda    #0x30
   97A0 81 39         [ 2] 2744         cmpa    #0x39
   97A2 23 02         [ 3] 2745         bls     L97A6  
   97A4 8B 07         [ 2] 2746         adda    #0x07
   97A6                    2747 L97A6:
   97A6 97 13         [ 3] 2748         staa    (0x0013)
   97A8 32            [ 4] 2749         pula
   97A9 84 F0         [ 2] 2750         anda    #0xF0
   97AB 44            [ 2] 2751         lsra
   97AC 44            [ 2] 2752         lsra
   97AD 44            [ 2] 2753         lsra
   97AE 44            [ 2] 2754         lsra
   97AF 8B 30         [ 2] 2755         adda    #0x30
   97B1 81 39         [ 2] 2756         cmpa    #0x39
   97B3 23 02         [ 3] 2757         bls     L97B7  
   97B5 8B 07         [ 2] 2758         adda    #0x07
   97B7                    2759 L97B7:
   97B7 97 12         [ 3] 2760         staa    (0x0012)
   97B9 39            [ 5] 2761         rts
                           2762 
   97BA                    2763 L97BA:
   97BA BD 9D 18      [ 6] 2764         jsr     L9D18
   97BD 24 03         [ 3] 2765         bcc     L97C2  
   97BF 7E 9A 7F      [ 3] 2766         jmp     L9A7F
   97C2                    2767 L97C2:
   97C2 7D 00 79      [ 6] 2768         tst     (0x0079)
   97C5 26 0B         [ 3] 2769         bne     L97D2  
   97C7 FC 04 10      [ 5] 2770         ldd     (0x0410)
   97CA C3 00 01      [ 4] 2771         addd    #0x0001
   97CD FD 04 10      [ 5] 2772         std     (0x0410)
   97D0 20 09         [ 3] 2773         bra     L97DB  
   97D2                    2774 L97D2:
   97D2 FC 04 12      [ 5] 2775         ldd     (0x0412)
   97D5 C3 00 01      [ 4] 2776         addd    #0x0001
   97D8 FD 04 12      [ 5] 2777         std     (0x0412)
   97DB                    2778 L97DB:
   97DB 86 78         [ 2] 2779         ldaa    #0x78
   97DD 97 63         [ 3] 2780         staa    (0x0063)
   97DF 97 64         [ 3] 2781         staa    (0x0064)
   97E1 BD A3 13      [ 6] 2782         jsr     LA313
   97E4 BD AA DB      [ 6] 2783         jsr     LAADB
   97E7 86 01         [ 2] 2784         ldaa    #0x01
   97E9 97 4E         [ 3] 2785         staa    (0x004E)
   97EB 97 76         [ 3] 2786         staa    (0x0076)
   97ED 7F 00 75      [ 6] 2787         clr     (0x0075)
   97F0 7F 00 77      [ 6] 2788         clr     (0x0077)
   97F3 BD 87 AE      [ 6] 2789         jsr     L87AE
   97F6 D6 7B         [ 3] 2790         ldab    (0x007B)
   97F8 CA 20         [ 2] 2791         orab    #0x20
   97FA C4 F7         [ 2] 2792         andb    #0xF7
   97FC BD 87 48      [ 6] 2793         jsr     L8748   
   97FF 7E 85 A4      [ 3] 2794         jmp     L85A4
   9802                    2795 L9802:
   9802 7F 00 76      [ 6] 2796         clr     (0x0076)
   9805 7F 00 75      [ 6] 2797         clr     (0x0075)
   9808 7F 00 77      [ 6] 2798         clr     (0x0077)
   980B 7F 00 4E      [ 6] 2799         clr     (0x004E)
   980E D6 7B         [ 3] 2800         ldab    (0x007B)
   9810 CA 0C         [ 2] 2801         orab    #0x0C
   9812 BD 87 48      [ 6] 2802         jsr     L8748
   9815                    2803 L9815:
   9815 BD A3 1E      [ 6] 2804         jsr     LA31E
   9818 BD 86 C4      [ 6] 2805         jsr     L86C4           ; Reset boards 1-10
   981B BD 9C 51      [ 6] 2806         jsr     L9C51           ; Reset random motions, init board 7/8 bits
   981E BD 8E 95      [ 6] 2807         jsr     L8E95
   9821 7E 84 4D      [ 3] 2808         jmp     L844D
   9824                    2809 L9824:
   9824 BD 9C 51      [ 6] 2810         jsr     L9C51           ; Reset random motions, init board 7/8 bits
   9827 7F 00 4E      [ 6] 2811         clr     (0x004E)
   982A D6 7B         [ 3] 2812         ldab    (0x007B)
   982C CA 24         [ 2] 2813         orab    #0x24
   982E C4 F7         [ 2] 2814         andb    #0xF7
   9830 BD 87 48      [ 6] 2815         jsr     L8748   
   9833 BD 87 AE      [ 6] 2816         jsr     L87AE
   9836 BD 8E 95      [ 6] 2817         jsr     L8E95
   9839 7E 84 4D      [ 3] 2818         jmp     L844D
   983C                    2819 L983C:
   983C 7F 00 78      [ 6] 2820         clr     (0x0078)
   983F B6 10 8A      [ 4] 2821         ldaa    (0x108A)
   9842 84 F9         [ 2] 2822         anda    #0xF9
   9844 B7 10 8A      [ 4] 2823         staa    (0x108A)
   9847 7D 00 AF      [ 6] 2824         tst     (0x00AF)
   984A 26 61         [ 3] 2825         bne     L98AD  
   984C 96 62         [ 3] 2826         ldaa    (0x0062)
   984E 84 01         [ 2] 2827         anda    #0x01
   9850 27 5B         [ 3] 2828         beq     L98AD  
   9852 C6 FD         [ 2] 2829         ldab    #0xFD           ; tape deck STOP
   9854 BD 86 E7      [ 6] 2830         jsr     L86E7
   9857 CC 00 32      [ 3] 2831         ldd     #0x0032
   985A DD 1B         [ 4] 2832         std     CDTIMR1
   985C CC 75 30      [ 3] 2833         ldd     #0x7530
   985F DD 1D         [ 4] 2834         std     CDTIMR2
   9861 7F 00 5A      [ 6] 2835         clr     (0x005A)
   9864                    2836 L9864:
   9864 BD 9B 19      [ 6] 2837         jsr     L9B19           ; do the random motions if enabled
   9867 7D 00 31      [ 6] 2838         tst     (0x0031)
   986A 26 04         [ 3] 2839         bne     L9870  
   986C 96 5A         [ 3] 2840         ldaa    (0x005A)
   986E 27 19         [ 3] 2841         beq     L9889  
   9870                    2842 L9870:
   9870 7F 00 31      [ 6] 2843         clr     (0x0031)
   9873 D6 62         [ 3] 2844         ldab    (0x0062)
   9875 C4 FE         [ 2] 2845         andb    #0xFE
   9877 D7 62         [ 3] 2846         stab    (0x0062)
   9879 BD F9 C5      [ 6] 2847         jsr     BUTNLIT 
   987C BD AA 13      [ 6] 2848         jsr     LAA13
   987F C6 FB         [ 2] 2849         ldab    #0xFB           ; tape deck PLAY
   9881 BD 86 E7      [ 6] 2850         jsr     L86E7
   9884 7F 00 5A      [ 6] 2851         clr     (0x005A)
   9887 20 4B         [ 3] 2852         bra     L98D4  
   9889                    2853 L9889:
   9889 DC 1B         [ 4] 2854         ldd     CDTIMR1
   988B 26 D7         [ 3] 2855         bne     L9864  
   988D D6 62         [ 3] 2856         ldab    (0x0062)
   988F C8 01         [ 2] 2857         eorb    #0x01
   9891 D7 62         [ 3] 2858         stab    (0x0062)
   9893 BD F9 C5      [ 6] 2859         jsr     BUTNLIT 
   9896 C4 01         [ 2] 2860         andb    #0x01
   9898 26 05         [ 3] 2861         bne     L989F  
   989A BD AA 0C      [ 6] 2862         jsr     LAA0C
   989D 20 03         [ 3] 2863         bra     L98A2  
   989F                    2864 L989F:
   989F BD AA 13      [ 6] 2865         jsr     LAA13
   98A2                    2866 L98A2:
   98A2 CC 00 32      [ 3] 2867         ldd     #0x0032
   98A5 DD 1B         [ 4] 2868         std     CDTIMR1
   98A7 DC 1D         [ 4] 2869         ldd     CDTIMR2
   98A9 27 C5         [ 3] 2870         beq     L9870  
   98AB 20 B7         [ 3] 2871         bra     L9864  
   98AD                    2872 L98AD:
   98AD 7D 00 75      [ 6] 2873         tst     (0x0075)
   98B0 27 03         [ 3] 2874         beq     L98B5  
   98B2 7E 99 39      [ 3] 2875         jmp     L9939
   98B5                    2876 L98B5:
   98B5 96 62         [ 3] 2877         ldaa    (0x0062)
   98B7 84 02         [ 2] 2878         anda    #0x02
   98B9 27 4E         [ 3] 2879         beq     L9909  
   98BB 7D 00 AF      [ 6] 2880         tst     (0x00AF)
   98BE 26 0B         [ 3] 2881         bne     L98CB  
   98C0 FC 04 24      [ 5] 2882         ldd     (0x0424)
   98C3 C3 00 01      [ 4] 2883         addd    #0x0001
   98C6 FD 04 24      [ 5] 2884         std     (0x0424)
   98C9 20 09         [ 3] 2885         bra     L98D4  
   98CB                    2886 L98CB:
   98CB FC 04 22      [ 5] 2887         ldd     (0x0422)
   98CE C3 00 01      [ 4] 2888         addd    #0x0001
   98D1 FD 04 22      [ 5] 2889         std     (0x0422)
   98D4                    2890 L98D4:
   98D4 FC 04 18      [ 5] 2891         ldd     (0x0418)
   98D7 C3 00 01      [ 4] 2892         addd    #0x0001
   98DA FD 04 18      [ 5] 2893         std     (0x0418)
   98DD 86 78         [ 2] 2894         ldaa    #0x78
   98DF 97 63         [ 3] 2895         staa    (0x0063)
   98E1 97 64         [ 3] 2896         staa    (0x0064)
   98E3 D6 62         [ 3] 2897         ldab    (0x0062)
   98E5 C4 F7         [ 2] 2898         andb    #0xF7
   98E7 CA 02         [ 2] 2899         orab    #0x02
   98E9 D7 62         [ 3] 2900         stab    (0x0062)
   98EB BD F9 C5      [ 6] 2901         jsr     BUTNLIT 
   98EE BD AA 18      [ 6] 2902         jsr     LAA18
   98F1 86 01         [ 2] 2903         ldaa    #0x01
   98F3 97 4E         [ 3] 2904         staa    (0x004E)
   98F5 97 75         [ 3] 2905         staa    (0x0075)
   98F7 D6 7B         [ 3] 2906         ldab    (0x007B)
   98F9 C4 DF         [ 2] 2907         andb    #0xDF
   98FB BD 87 48      [ 6] 2908         jsr     L8748   
   98FE BD 87 AE      [ 6] 2909         jsr     L87AE
   9901 BD A3 13      [ 6] 2910         jsr     LA313
   9904 BD AA DB      [ 6] 2911         jsr     LAADB
   9907 20 30         [ 3] 2912         bra     L9939  
   9909                    2913 L9909:
   9909 D6 62         [ 3] 2914         ldab    (0x0062)
   990B C4 F5         [ 2] 2915         andb    #0xF5
   990D CA 40         [ 2] 2916         orab    #0x40
   990F D7 62         [ 3] 2917         stab    (0x0062)
   9911 BD F9 C5      [ 6] 2918         jsr     BUTNLIT 
   9914 BD AA 1D      [ 6] 2919         jsr     LAA1D
   9917 7D 00 AF      [ 6] 2920         tst     (0x00AF)
   991A 26 04         [ 3] 2921         bne     L9920  
   991C C6 01         [ 2] 2922         ldab    #0x01
   991E D7 B6         [ 3] 2923         stab    (0x00B6)
   9920                    2924 L9920:
   9920 BD 9C 51      [ 6] 2925         jsr     L9C51           ; Reset random motions, init board 7/8 bits
   9923 7F 00 4E      [ 6] 2926         clr     (0x004E)
   9926 7F 00 75      [ 6] 2927         clr     (0x0075)
   9929 86 01         [ 2] 2928         ldaa    #0x01
   992B 97 77         [ 3] 2929         staa    (0x0077)
   992D D6 7B         [ 3] 2930         ldab    (0x007B)
   992F CA 24         [ 2] 2931         orab    #0x24
   9931 C4 F7         [ 2] 2932         andb    #0xF7
   9933 BD 87 48      [ 6] 2933         jsr     L8748   
   9936 BD 87 91      [ 6] 2934         jsr     L8791   
   9939                    2935 L9939:
   9939 7F 00 AF      [ 6] 2936         clr     (0x00AF)
   993C 7E 85 A4      [ 3] 2937         jmp     L85A4
   993F                    2938 L993F:
   993F 7F 00 77      [ 6] 2939         clr     (0x0077)
   9942 BD 9C 51      [ 6] 2940         jsr     L9C51           ; Reset random motions, init board 7/8 bits
   9945 7F 00 4E      [ 6] 2941         clr     (0x004E)
   9948 D6 62         [ 3] 2942         ldab    (0x0062)
   994A C4 BF         [ 2] 2943         andb    #0xBF
   994C 7D 00 75      [ 6] 2944         tst     (0x0075)
   994F 27 02         [ 3] 2945         beq     L9953  
   9951 C4 FD         [ 2] 2946         andb    #0xFD
   9953                    2947 L9953:
   9953 D7 62         [ 3] 2948         stab    (0x0062)
   9955 BD F9 C5      [ 6] 2949         jsr     BUTNLIT 
   9958 BD AA 1D      [ 6] 2950         jsr     LAA1D
   995B 7F 00 5B      [ 6] 2951         clr     (0x005B)
   995E BD 87 AE      [ 6] 2952         jsr     L87AE
   9961 D6 7B         [ 3] 2953         ldab    (0x007B)
   9963 CA 20         [ 2] 2954         orab    #0x20
   9965 BD 87 48      [ 6] 2955         jsr     L8748   
   9968 7F 00 75      [ 6] 2956         clr     (0x0075)
   996B 7F 00 76      [ 6] 2957         clr     (0x0076)
   996E 7E 98 15      [ 3] 2958         jmp     L9815
   9971                    2959 L9971:
   9971 D6 7B         [ 3] 2960         ldab    (0x007B)
   9973 C4 FB         [ 2] 2961         andb    #0xFB
   9975 BD 87 48      [ 6] 2962         jsr     L8748   
   9978 7E 85 A4      [ 3] 2963         jmp     L85A4
   997B                    2964 L997B:
   997B D6 7B         [ 3] 2965         ldab    (0x007B)
   997D CA 04         [ 2] 2966         orab    #0x04
   997F BD 87 48      [ 6] 2967         jsr     L8748   
   9982 7E 85 A4      [ 3] 2968         jmp     L85A4
   9985                    2969 L9985:
   9985 D6 7B         [ 3] 2970         ldab    (0x007B)
   9987 C4 F7         [ 2] 2971         andb    #0xF7
   9989 BD 87 48      [ 6] 2972         jsr     L8748   
   998C 7E 85 A4      [ 3] 2973         jmp     L85A4
   998F                    2974 L998F:
   998F 7D 00 77      [ 6] 2975         tst     (0x0077)
   9992 26 07         [ 3] 2976         bne     L999B
   9994 D6 7B         [ 3] 2977         ldab    (0x007B)
   9996 CA 08         [ 2] 2978         orab    #0x08
   9998 BD 87 48      [ 6] 2979         jsr     L8748   
   999B                    2980 L999B:
   999B 7E 85 A4      [ 3] 2981         jmp     L85A4
   999E                    2982 L999E:
   999E D6 7B         [ 3] 2983         ldab    (0x007B)
   99A0 C4 F3         [ 2] 2984         andb    #0xF3
   99A2 BD 87 48      [ 6] 2985         jsr     L8748   
   99A5 39            [ 5] 2986         rts
                           2987 
                           2988 ; main2
   99A6                    2989 L99A6:
   99A6 D6 7B         [ 3] 2990         ldab    (0x007B)
   99A8 C4 DF         [ 2] 2991         andb    #0xDF           ; clear bit 5
   99AA BD 87 48      [ 6] 2992         jsr     L8748
   99AD BD 87 91      [ 6] 2993         jsr     L8791   
   99B0 39            [ 5] 2994         rts
                           2995 
   99B1                    2996 L99B1:
   99B1 D6 7B         [ 3] 2997         ldab    (0x007B)
   99B3 CA 20         [ 2] 2998         orab    #0x20
   99B5 BD 87 48      [ 6] 2999         jsr     L8748   
   99B8 BD 87 AE      [ 6] 3000         jsr     L87AE
   99BB 39            [ 5] 3001         rts
                           3002 
   99BC D6 7B         [ 3] 3003         ldab    (0x007B)
   99BE C4 DF         [ 2] 3004         andb    #0xDF
   99C0 BD 87 48      [ 6] 3005         jsr     L8748   
   99C3 BD 87 AE      [ 6] 3006         jsr     L87AE
   99C6 39            [ 5] 3007         rts
                           3008 
   99C7 D6 7B         [ 3] 3009         ldab    (0x007B)
   99C9 CA 20         [ 2] 3010         orab    #0x20
   99CB BD 87 48      [ 6] 3011         jsr     L8748   
   99CE BD 87 91      [ 6] 3012         jsr     L8791   
   99D1 39            [ 5] 3013         rts
                           3014 
   99D2                    3015 L99D2:
   99D2 86 01         [ 2] 3016         ldaa    #0x01
   99D4 97 78         [ 3] 3017         staa    (0x0078)
   99D6 7E 85 A4      [ 3] 3018         jmp     L85A4
   99D9                    3019 L99D9:
   99D9 CE 0E 20      [ 3] 3020         ldx     #0x0E20
   99DC A6 00         [ 4] 3021         ldaa    0,X     
   99DE 80 30         [ 2] 3022         suba    #0x30
   99E0 C6 0A         [ 2] 3023         ldab    #0x0A
   99E2 3D            [10] 3024         mul
   99E3 17            [ 2] 3025         tba                     ; (0E20)*10 into A
   99E4 C6 64         [ 2] 3026         ldab    #0x64
   99E6 3D            [10] 3027         mul
   99E7 DD 17         [ 4] 3028         std     (0x0017)        ; (0E20)*1000 into 17:18
   99E9 A6 01         [ 4] 3029         ldaa    1,X
   99EB 80 30         [ 2] 3030         suba    #0x30
   99ED C6 64         [ 2] 3031         ldab    #0x64
   99EF 3D            [10] 3032         mul
   99F0 D3 17         [ 5] 3033         addd    (0x0017)
   99F2 DD 17         [ 4] 3034         std     (0x0017)        ; (0E20)*1000+(0E21)*100 into 17:18
   99F4 A6 02         [ 4] 3035         ldaa    2,X     
   99F6 80 30         [ 2] 3036         suba    #0x30
   99F8 C6 0A         [ 2] 3037         ldab    #0x0A
   99FA 3D            [10] 3038         mul
   99FB D3 17         [ 5] 3039         addd    (0x0017)    
   99FD DD 17         [ 4] 3040         std     (0x0017)        ; (0E20)*1000+(0E21)*100+(0E22)*10 into 17:18
   99FF 4F            [ 2] 3041         clra
   9A00 E6 03         [ 4] 3042         ldab    3,X     
   9A02 C0 30         [ 2] 3043         subb    #0x30
   9A04 D3 17         [ 5] 3044         addd    (0x0017)    
   9A06 FD 02 9C      [ 5] 3045         std     (0x029C)        ; (0E20)*1000+(0E21)*100+(0E22)*10+(0E23) into (029C:029D)
   9A09 CE 0E 20      [ 3] 3046         ldx     #0x0E20
   9A0C                    3047 L9A0C:
   9A0C A6 00         [ 4] 3048         ldaa    0,X         
   9A0E 81 30         [ 2] 3049         cmpa    #0x30
   9A10 25 13         [ 3] 3050         bcs     L9A25  
   9A12 81 39         [ 2] 3051         cmpa    #0x39
   9A14 22 0F         [ 3] 3052         bhi     L9A25  
   9A16 08            [ 3] 3053         inx
   9A17 8C 0E 24      [ 4] 3054         cpx     #0x0E24
   9A1A 26 F0         [ 3] 3055         bne     L9A0C  
   9A1C B6 0E 24      [ 4] 3056         ldaa    (0x0E24)        ; check EEPROM signature
   9A1F 81 DB         [ 2] 3057         cmpa    #0xDB
   9A21 26 02         [ 3] 3058         bne     L9A25  
   9A23 0C            [ 2] 3059         clc                     ; if sig good, return carry clear
   9A24 39            [ 5] 3060         rts
                           3061 
   9A25                    3062 L9A25:
   9A25 0D            [ 2] 3063         sec                     ; if sig bad, return carry clear
   9A26 39            [ 5] 3064         rts
                           3065 
   9A27                    3066 L9A27:
   9A27 BD 8D E4      [ 6] 3067         jsr     LCDMSG1 
   9A2A 53 65 72 69 61 6C  3068         .ascis  'Serial# '
        23 A0
                           3069 
   9A32 BD 8D DD      [ 6] 3070         jsr     LCDMSG2 
   9A35 20 20 20 20 20 20  3071         .ascis  '               '
        20 20 20 20 20 20
        20 20 A0
                           3072 
                           3073 ; display 4-digit serial number
   9A44 C6 08         [ 2] 3074         ldab    #0x08
   9A46 18 CE 0E 20   [ 4] 3075         ldy     #0x0E20
   9A4A                    3076 L9A4A:
   9A4A 18 A6 00      [ 5] 3077         ldaa    0,Y     
   9A4D 18 3C         [ 5] 3078         pshy
   9A4F 37            [ 3] 3079         pshb
   9A50 BD 8D B5      [ 6] 3080         jsr     L8DB5            ; display char here on LCD display
   9A53 33            [ 4] 3081         pulb
   9A54 18 38         [ 6] 3082         puly
   9A56 5C            [ 2] 3083         incb
   9A57 18 08         [ 4] 3084         iny
   9A59 18 8C 0E 24   [ 5] 3085         cpy     #0x0E24
   9A5D 26 EB         [ 3] 3086         bne     L9A4A  
   9A5F 39            [ 5] 3087         rts
                           3088 
                           3089 ; Unused?
   9A60                    3090 L9A60:
   9A60 86 01         [ 2] 3091         ldaa    #0x01
   9A62 97 B5         [ 3] 3092         staa    (0x00B5)
   9A64 96 4E         [ 3] 3093         ldaa    (0x004E)
   9A66 97 7F         [ 3] 3094         staa    (0x007F)
   9A68 96 62         [ 3] 3095         ldaa    (0x0062)
   9A6A 97 80         [ 3] 3096         staa    (0x0080)
   9A6C 96 7B         [ 3] 3097         ldaa    (0x007B)
   9A6E 97 81         [ 3] 3098         staa    (0x0081)
   9A70 96 7A         [ 3] 3099         ldaa    (0x007A)
   9A72 97 82         [ 3] 3100         staa    (0x0082)
   9A74 96 78         [ 3] 3101         ldaa    (0x0078)
   9A76 97 7D         [ 3] 3102         staa    (0x007D)
   9A78 B6 10 8A      [ 4] 3103         ldaa    (0x108A)
   9A7B 84 06         [ 2] 3104         anda    #0x06
   9A7D 97 7E         [ 3] 3105         staa    (0x007E)
   9A7F                    3106 L9A7F:
   9A7F C6 EF         [ 2] 3107         ldab    #0xEF           ; tape deck EJECT
   9A81 BD 86 E7      [ 6] 3108         jsr     L86E7
   9A84 D6 7B         [ 3] 3109         ldab    (0x007B)
   9A86 CA 0C         [ 2] 3110         orab    #0x0C
   9A88 C4 DF         [ 2] 3111         andb    #0xDF
   9A8A BD 87 48      [ 6] 3112         jsr     L8748   
   9A8D BD 87 91      [ 6] 3113         jsr     L8791   
   9A90 BD 86 C4      [ 6] 3114         jsr     L86C4           ; Reset boards 1-10
   9A93 BD 9C 51      [ 6] 3115         jsr     L9C51           ; Reset random motions, init board 7/8 bits
   9A96 C6 06         [ 2] 3116         ldab    #0x06           ; delay 6 secs
   9A98 BD 8C 02      [ 6] 3117         jsr     DLYSECS         ;
   9A9B BD 8E 95      [ 6] 3118         jsr     L8E95
   9A9E BD 99 A6      [ 6] 3119         jsr     L99A6
   9AA1 7E 81 BD      [ 3] 3120         jmp     L81BD
   9AA4                    3121 L9AA4:
   9AA4 7F 00 5C      [ 6] 3122         clr     (0x005C)
   9AA7 86 01         [ 2] 3123         ldaa    #0x01
   9AA9 97 79         [ 3] 3124         staa    (0x0079)
   9AAB C6 FD         [ 2] 3125         ldab    #0xFD           ; tape deck STOP
   9AAD BD 86 E7      [ 6] 3126         jsr     L86E7
   9AB0 BD 8E 95      [ 6] 3127         jsr     L8E95
   9AB3 CC 75 30      [ 3] 3128         ldd     #0x7530
   9AB6 DD 1D         [ 4] 3129         std     CDTIMR2
   9AB8                    3130 L9AB8:
   9AB8 BD 9B 19      [ 6] 3131         jsr     L9B19           ; do the random motions if enabled
   9ABB D6 62         [ 3] 3132         ldab    (0x0062)
   9ABD C8 04         [ 2] 3133         eorb    #0x04
   9ABF D7 62         [ 3] 3134         stab    (0x0062)
   9AC1 BD F9 C5      [ 6] 3135         jsr     BUTNLIT 
   9AC4 F6 18 04      [ 4] 3136         ldab    PIA0PRA 
   9AC7 C8 08         [ 2] 3137         eorb    #0x08
   9AC9 F7 18 04      [ 4] 3138         stab    PIA0PRA 
   9ACC 7D 00 5C      [ 6] 3139         tst     (0x005C)
   9ACF 26 12         [ 3] 3140         bne     L9AE3  
   9AD1 BD 8E 95      [ 6] 3141         jsr     L8E95
   9AD4 81 0D         [ 2] 3142         cmpa    #0x0D
   9AD6 27 0B         [ 3] 3143         beq     L9AE3  
   9AD8 C6 32         [ 2] 3144         ldab    #0x32           ; delay 0.5 sec
   9ADA BD 8C 22      [ 6] 3145         jsr     DLYSECSBY100
   9ADD DC 1D         [ 4] 3146         ldd     CDTIMR2
   9ADF 27 02         [ 3] 3147         beq     L9AE3  
   9AE1 20 D5         [ 3] 3148         bra     L9AB8  
   9AE3                    3149 L9AE3:
   9AE3 D6 62         [ 3] 3150         ldab    (0x0062)
   9AE5 C4 FB         [ 2] 3151         andb    #0xFB
   9AE7 D7 62         [ 3] 3152         stab    (0x0062)
   9AE9 BD F9 C5      [ 6] 3153         jsr     BUTNLIT 
   9AEC BD A3 54      [ 6] 3154         jsr     LA354
   9AEF C6 FB         [ 2] 3155         ldab    #0xFB           ; tape deck PLAY
   9AF1 BD 86 E7      [ 6] 3156         jsr     L86E7
   9AF4 7E 85 A4      [ 3] 3157         jmp     L85A4
   9AF7                    3158 L9AF7:
   9AF7 7F 00 75      [ 6] 3159         clr     (0x0075)
   9AFA 7F 00 76      [ 6] 3160         clr     (0x0076)
   9AFD 7F 00 77      [ 6] 3161         clr     (0x0077)
   9B00 7F 00 78      [ 6] 3162         clr     (0x0078)
   9B03 7F 00 25      [ 6] 3163         clr     (0x0025)
   9B06 7F 00 26      [ 6] 3164         clr     (0x0026)
   9B09 7F 00 4E      [ 6] 3165         clr     (0x004E)
   9B0C 7F 00 30      [ 6] 3166         clr     (0x0030)
   9B0F 7F 00 31      [ 6] 3167         clr     (0x0031)
   9B12 7F 00 32      [ 6] 3168         clr     (0x0032)
   9B15 7F 00 AF      [ 6] 3169         clr     (0x00AF)
   9B18 39            [ 5] 3170         rts
                           3171 
                           3172 ; do the random motions if enabled
   9B19                    3173 L9B19:
   9B19 36            [ 3] 3174         psha
   9B1A 37            [ 3] 3175         pshb
   9B1B 96 4E         [ 3] 3176         ldaa    (0x004E)
   9B1D 27 17         [ 3] 3177         beq     L9B36           ; go to 0401 logic
   9B1F 96 63         [ 3] 3178         ldaa    (0x0063)        ; check countdown timer
   9B21 26 10         [ 3] 3179         bne     L9B33           ; exit
   9B23 7D 00 64      [ 6] 3180         tst     (0x0064)
   9B26 27 09         [ 3] 3181         beq     L9B31           ; go to 0401 logic
   9B28 BD 86 C4      [ 6] 3182         jsr     L86C4           ; Reset boards 1-10
   9B2B BD 9C 51      [ 6] 3183         jsr     L9C51           ; Reset random motions, init board 7/8 bits
   9B2E 7F 00 64      [ 6] 3184         clr     (0x0064)
   9B31                    3185 L9B31:
   9B31 20 03         [ 3] 3186         bra     L9B36           ; go to 0401 logic
   9B33                    3187 L9B33:
   9B33 33            [ 4] 3188         pulb
   9B34 32            [ 4] 3189         pula
   9B35 39            [ 5] 3190         rts
                           3191 
                           3192 ; end up here immediately if:
                           3193 ; 0x004E == 00 or
                           3194 ; 0x0063, 0x0064 == 0 or
                           3195 ; 
                           3196 ; do subroutines based on bits 0-4 of 0x0401?
   9B36                    3197 L9B36:
   9B36 B6 04 01      [ 4] 3198         ldaa    (0x0401)
   9B39 84 01         [ 2] 3199         anda    #0x01
   9B3B 27 03         [ 3] 3200         beq     L9B40  
   9B3D BD 9B 6B      [ 6] 3201         jsr     L9B6B           ; bit 0 routine
   9B40                    3202 L9B40:
   9B40 B6 04 01      [ 4] 3203         ldaa    (0x0401)
   9B43 84 02         [ 2] 3204         anda    #0x02
   9B45 27 03         [ 3] 3205         beq     L9B4A  
   9B47 BD 9B 99      [ 6] 3206         jsr     L9B99           ; bit 1 routine
   9B4A                    3207 L9B4A:
   9B4A B6 04 01      [ 4] 3208         ldaa    (0x0401)
   9B4D 84 04         [ 2] 3209         anda    #0x04
   9B4F 27 03         [ 3] 3210         beq     L9B54  
   9B51 BD 9B C7      [ 6] 3211         jsr     L9BC7           ; bit 2 routine
   9B54                    3212 L9B54:
   9B54 B6 04 01      [ 4] 3213         ldaa    (0x0401)
   9B57 84 08         [ 2] 3214         anda    #0x08
   9B59 27 03         [ 3] 3215         beq     L9B5E  
   9B5B BD 9B F5      [ 6] 3216         jsr     L9BF5           ; bit 3 routine
   9B5E                    3217 L9B5E:
   9B5E B6 04 01      [ 4] 3218         ldaa    (0x0401)
   9B61 84 10         [ 2] 3219         anda    #0x10
   9B63 27 03         [ 3] 3220         beq     L9B68  
   9B65 BD 9C 23      [ 6] 3221         jsr     L9C23           ; bit 4 routine
   9B68                    3222 L9B68:
   9B68 33            [ 4] 3223         pulb
   9B69 32            [ 4] 3224         pula
   9B6A 39            [ 5] 3225         rts
                           3226 
                           3227 ; bit 0 routine
   9B6B                    3228 L9B6B:
   9B6B 18 3C         [ 5] 3229         pshy
   9B6D 18 DE 65      [ 5] 3230         ldy     (0x0065)
   9B70 18 A6 00      [ 5] 3231         ldaa    0,Y     
   9B73 81 FF         [ 2] 3232         cmpa    #0xFF
   9B75 27 14         [ 3] 3233         beq     L9B8B  
   9B77 91 70         [ 3] 3234         cmpa    OFFCNT1
   9B79 25 0D         [ 3] 3235         bcs     L9B88  
   9B7B 18 08         [ 4] 3236         iny
   9B7D 18 A6 00      [ 5] 3237         ldaa    0,Y     
   9B80 B7 10 80      [ 4] 3238         staa    (0x1080)        ; do some stuff to board 1
   9B83 18 08         [ 4] 3239         iny
   9B85 18 DF 65      [ 5] 3240         sty     (0x0065)
   9B88                    3241 L9B88:
   9B88 18 38         [ 6] 3242         puly
   9B8A 39            [ 5] 3243         rts
   9B8B                    3244 L9B8B:
   9B8B 18 CE B2 EB   [ 4] 3245         ldy     #LB2EB
   9B8F 18 DF 65      [ 5] 3246         sty     (0x0065)
   9B92 86 FA         [ 2] 3247         ldaa    #0xFA
   9B94 97 70         [ 3] 3248         staa    OFFCNT1
   9B96 7E 9B 88      [ 3] 3249         jmp     L9B88
                           3250 
                           3251 ; bit 1 routine
   9B99                    3252 L9B99:
   9B99 18 3C         [ 5] 3253         pshy
   9B9B 18 DE 67      [ 5] 3254         ldy     (0x0067)
   9B9E 18 A6 00      [ 5] 3255         ldaa    0,Y     
   9BA1 81 FF         [ 2] 3256         cmpa    #0xFF
   9BA3 27 14         [ 3] 3257         beq     L9BB9  
   9BA5 91 71         [ 3] 3258         cmpa    OFFCNT2
   9BA7 25 0D         [ 3] 3259         bcs     L9BB6  
   9BA9 18 08         [ 4] 3260         iny
   9BAB 18 A6 00      [ 5] 3261         ldaa    0,Y     
   9BAE B7 10 84      [ 4] 3262         staa    (0x1084)        ; do some stuff to board 2
   9BB1 18 08         [ 4] 3263         iny
   9BB3 18 DF 67      [ 5] 3264         sty     (0x0067)
   9BB6                    3265 L9BB6:
   9BB6 18 38         [ 6] 3266         puly
   9BB8 39            [ 5] 3267         rts
   9BB9                    3268 L9BB9:
   9BB9 18 CE B3 BD   [ 4] 3269         ldy     #LB3BD
   9BBD 18 DF 67      [ 5] 3270         sty     (0x0067)
   9BC0 86 E6         [ 2] 3271         ldaa    #0xE6
   9BC2 97 71         [ 3] 3272         staa    OFFCNT2
   9BC4 7E 9B B6      [ 3] 3273         jmp     L9BB6
                           3274 
                           3275 ; bit 2 routine
   9BC7                    3276 L9BC7:
   9BC7 18 3C         [ 5] 3277         pshy
   9BC9 18 DE 69      [ 5] 3278         ldy     (0x0069)
   9BCC 18 A6 00      [ 5] 3279         ldaa    0,Y     
   9BCF 81 FF         [ 2] 3280         cmpa    #0xFF
   9BD1 27 14         [ 3] 3281         beq     L9BE7  
   9BD3 91 72         [ 3] 3282         cmpa    OFFCNT3
   9BD5 25 0D         [ 3] 3283         bcs     L9BE4  
   9BD7 18 08         [ 4] 3284         iny
   9BD9 18 A6 00      [ 5] 3285         ldaa    0,Y     
   9BDC B7 10 88      [ 4] 3286         staa    (0x1088)        ; do some stuff to board 3
   9BDF 18 08         [ 4] 3287         iny
   9BE1 18 DF 69      [ 5] 3288         sty     (0x0069)
   9BE4                    3289 L9BE4:
   9BE4 18 38         [ 6] 3290         puly
   9BE6 39            [ 5] 3291         rts
   9BE7                    3292 L9BE7:
   9BE7 18 CE B5 31   [ 4] 3293         ldy     #LB531
   9BEB 18 DF 69      [ 5] 3294         sty     (0x0069)
   9BEE 86 D2         [ 2] 3295         ldaa    #0xD2
   9BF0 97 72         [ 3] 3296         staa    OFFCNT3
   9BF2 7E 9B E4      [ 3] 3297         jmp     L9BE4
                           3298 
                           3299 ; bit 3 routine
   9BF5                    3300 L9BF5:
   9BF5 18 3C         [ 5] 3301         pshy
   9BF7 18 DE 6B      [ 5] 3302         ldy     (0x006B)
   9BFA 18 A6 00      [ 5] 3303         ldaa    0,Y     
   9BFD 81 FF         [ 2] 3304         cmpa    #0xFF
   9BFF 27 14         [ 3] 3305         beq     L9C15  
   9C01 91 73         [ 3] 3306         cmpa    OFFCNT4
   9C03 25 0D         [ 3] 3307         bcs     L9C12  
   9C05 18 08         [ 4] 3308         iny
   9C07 18 A6 00      [ 5] 3309         ldaa    0,Y     
   9C0A B7 10 8C      [ 4] 3310         staa    (0x108C)        ; do some stuff to board 4
   9C0D 18 08         [ 4] 3311         iny
   9C0F 18 DF 6B      [ 5] 3312         sty     (0x006B)
   9C12                    3313 L9C12:
   9C12 18 38         [ 6] 3314         puly
   9C14 39            [ 5] 3315         rts
   9C15                    3316 L9C15:
   9C15 18 CE B4 75   [ 4] 3317         ldy     #LB475
   9C19 18 DF 6B      [ 5] 3318         sty     (0x006B)
   9C1C 86 BE         [ 2] 3319         ldaa    #0xBE
   9C1E 97 73         [ 3] 3320         staa    OFFCNT4
   9C20 7E 9C 12      [ 3] 3321         jmp     L9C12
                           3322 
                           3323 ; bit 4 routine
   9C23                    3324 L9C23:
   9C23 18 3C         [ 5] 3325         pshy
   9C25 18 DE 6D      [ 5] 3326         ldy     (0x006D)
   9C28 18 A6 00      [ 5] 3327         ldaa    0,Y     
   9C2B 81 FF         [ 2] 3328         cmpa    #0xFF
   9C2D 27 14         [ 3] 3329         beq     L9C43  
   9C2F 91 74         [ 3] 3330         cmpa    OFFCNT5
   9C31 25 0D         [ 3] 3331         bcs     L9C40  
   9C33 18 08         [ 4] 3332         iny
   9C35 18 A6 00      [ 5] 3333         ldaa    0,Y     
   9C38 B7 10 90      [ 4] 3334         staa    (0x1090)        ; do some stuff to board 5
   9C3B 18 08         [ 4] 3335         iny
   9C3D 18 DF 6D      [ 5] 3336         sty     (0x006D)
   9C40                    3337 L9C40:
   9C40 18 38         [ 6] 3338         puly
   9C42 39            [ 5] 3339         rts
   9C43                    3340 L9C43:
   9C43 18 CE B5 C3   [ 4] 3341         ldy     #LB5C3
   9C47 18 DF 6D      [ 5] 3342         sty     (0x006D)
   9C4A 86 AA         [ 2] 3343         ldaa    #0xAA
   9C4C 97 74         [ 3] 3344         staa    OFFCNT5
   9C4E 7E 9C 40      [ 3] 3345         jmp     L9C40
                           3346 
                           3347 ; Reset offset counters to initial values
   9C51                    3348 L9C51:
   9C51 86 FA         [ 2] 3349         ldaa    #0xFA
   9C53 97 70         [ 3] 3350         staa    OFFCNT1
   9C55 86 E6         [ 2] 3351         ldaa    #0xE6
   9C57 97 71         [ 3] 3352         staa    OFFCNT2
   9C59 86 D2         [ 2] 3353         ldaa    #0xD2
   9C5B 97 72         [ 3] 3354         staa    OFFCNT3
   9C5D 86 BE         [ 2] 3355         ldaa    #0xBE
   9C5F 97 73         [ 3] 3356         staa    OFFCNT4
   9C61 86 AA         [ 2] 3357         ldaa    #0xAA
   9C63 97 74         [ 3] 3358         staa    OFFCNT5
                           3359 
                           3360         ; int random movement table pointers
   9C65 18 CE B2 EB   [ 4] 3361         ldy     #LB2EB
   9C69 18 DF 65      [ 5] 3362         sty     (0x0065)
   9C6C 18 CE B3 BD   [ 4] 3363         ldy     #LB3BD
   9C70 18 DF 67      [ 5] 3364         sty     (0x0067)
   9C73 18 CE B5 31   [ 4] 3365         ldy     #LB531
   9C77 18 DF 69      [ 5] 3366         sty     (0x0069)
   9C7A 18 CE B4 75   [ 4] 3367         ldy     #LB475
   9C7E 18 DF 6B      [ 5] 3368         sty     (0x006B)
   9C81 18 CE B5 C3   [ 4] 3369         ldy     #LB5C3
   9C85 18 DF 6D      [ 5] 3370         sty     (0x006D)
                           3371 
                           3372         ; clear board 8
   9C88 7F 10 9C      [ 6] 3373         clr     (0x109C)
   9C8B 7F 10 9E      [ 6] 3374         clr     (0x109E)
                           3375 
                           3376         ; if bit 5 of 0401 is set, turn on 3 bits on board 8
   9C8E B6 04 01      [ 4] 3377         ldaa    (0x0401)
   9C91 84 20         [ 2] 3378         anda    #0x20
   9C93 27 08         [ 3] 3379         beq     L9C9D
   9C95 B6 10 9C      [ 4] 3380         ldaa    (0x109C)
   9C98 8A 19         [ 2] 3381         oraa    #0x19
   9C9A B7 10 9C      [ 4] 3382         staa    (0x109C)
                           3383         ; if bit 6 of 0401 is set, turn on 3 bits on board 8
   9C9D                    3384 L9C9D:
   9C9D B6 04 01      [ 4] 3385         ldaa    (0x0401)
   9CA0 84 40         [ 2] 3386         anda    #0x40
   9CA2 27 10         [ 3] 3387         beq     L9CB4  
   9CA4 B6 10 9C      [ 4] 3388         ldaa    (0x109C)
   9CA7 8A 44         [ 2] 3389         oraa    #0x44
   9CA9 B7 10 9C      [ 4] 3390         staa    (0x109C)
   9CAC B6 10 9E      [ 4] 3391         ldaa    (0x109E)
   9CAF 8A 40         [ 2] 3392         oraa    #0x40
   9CB1 B7 10 9E      [ 4] 3393         staa    (0x109E)
                           3394         ; if bit 7 of 0401 is set, turn on 3 bits on board 8
   9CB4                    3395 L9CB4:
   9CB4 B6 04 01      [ 4] 3396         ldaa    (0x0401)
   9CB7 84 80         [ 2] 3397         anda    #0x80
   9CB9 27 08         [ 3] 3398         beq     L9CC3  
   9CBB B6 10 9C      [ 4] 3399         ldaa    (0x109C)
   9CBE 8A A2         [ 2] 3400         oraa    #0xA2
   9CC0 B7 10 9C      [ 4] 3401         staa    (0x109C)
                           3402 
   9CC3                    3403 L9CC3:
                           3404         ; if bit 0 of 042B is set, turn on 1 bit on board 7
   9CC3 B6 04 2B      [ 4] 3405         ldaa    (0x042B)
   9CC6 84 01         [ 2] 3406         anda    #0x01
   9CC8 27 08         [ 3] 3407         beq     L9CD2  
   9CCA B6 10 9A      [ 4] 3408         ldaa    (0x109A)
   9CCD 8A 80         [ 2] 3409         oraa    #0x80
   9CCF B7 10 9A      [ 4] 3410         staa    (0x109A)
   9CD2                    3411 L9CD2:
                           3412         ; if bit 1 of 042B is set, turn on 1 bit on board 8
   9CD2 B6 04 2B      [ 4] 3413         ldaa    (0x042B)
   9CD5 84 02         [ 2] 3414         anda    #0x02
   9CD7 27 08         [ 3] 3415         beq     L9CE1  
   9CD9 B6 10 9E      [ 4] 3416         ldaa    (0x109E)
   9CDC 8A 04         [ 2] 3417         oraa    #0x04
   9CDE B7 10 9E      [ 4] 3418         staa    (0x109E)
   9CE1                    3419 L9CE1:
                           3420         ; if bit 2 of 042B is set, turn on 1 bit on board 8
   9CE1 B6 04 2B      [ 4] 3421         ldaa    (0x042B)
   9CE4 84 04         [ 2] 3422         anda    #0x04
   9CE6 27 08         [ 3] 3423         beq     L9CF0  
   9CE8 B6 10 9E      [ 4] 3424         ldaa    (0x109E)
   9CEB 8A 08         [ 2] 3425         oraa    #0x08
   9CED B7 10 9E      [ 4] 3426         staa    (0x109E)
   9CF0                    3427 L9CF0:
   9CF0 39            [ 5] 3428         rts
                           3429 
                           3430 ; Display Credits
   9CF1                    3431 L9CF1:
   9CF1 BD 8D E4      [ 6] 3432         jsr     LCDMSG1 
   9CF4 20 20 20 50 72 6F  3433         .ascis  '   Program by   '
        67 72 61 6D 20 62
        79 20 20 A0
                           3434 
   9D04 BD 8D DD      [ 6] 3435         jsr     LCDMSG2 
   9D07 44 61 76 69 64 20  3436         .ascis  'David  Philipsen'
        20 50 68 69 6C 69
        70 73 65 EE
                           3437 
   9D17 39            [ 5] 3438         rts
                           3439 
   9D18                    3440 L9D18:
   9D18 97 49         [ 3] 3441         staa    (0x0049)
   9D1A 7F 00 B8      [ 6] 3442         clr     (0x00B8)
   9D1D BD 8D 03      [ 6] 3443         jsr     L8D03
   9D20 86 2A         [ 2] 3444         ldaa    #0x2A           ;'*'
   9D22 C6 28         [ 2] 3445         ldab    #0x28
   9D24 BD 8D B5      [ 6] 3446         jsr     L8DB5           ; display char here on LCD display
   9D27 CC 0B B8      [ 3] 3447         ldd     #0x0BB8         ; start 30 second timer?
   9D2A DD 1B         [ 4] 3448         std     CDTIMR1
   9D2C                    3449 L9D2C:
   9D2C BD 9B 19      [ 6] 3450         jsr     L9B19           ; do the random motions if enabled
   9D2F 96 49         [ 3] 3451         ldaa    (0x0049)
   9D31 81 41         [ 2] 3452         cmpa    #0x41
   9D33 27 04         [ 3] 3453         beq     L9D39  
   9D35 81 4B         [ 2] 3454         cmpa    #0x4B
   9D37 26 04         [ 3] 3455         bne     L9D3D  
   9D39                    3456 L9D39:
   9D39 C6 01         [ 2] 3457         ldab    #0x01
   9D3B D7 B8         [ 3] 3458         stab    (0x00B8)
   9D3D                    3459 L9D3D:
   9D3D 81 41         [ 2] 3460         cmpa    #0x41
   9D3F 27 04         [ 3] 3461         beq     L9D45  
   9D41 81 4F         [ 2] 3462         cmpa    #0x4F
   9D43 26 07         [ 3] 3463         bne     L9D4C  
   9D45                    3464 L9D45:
   9D45 86 01         [ 2] 3465         ldaa    #0x01
   9D47 B7 02 98      [ 4] 3466         staa    (0x0298)
   9D4A 20 32         [ 3] 3467         bra     L9D7E  
   9D4C                    3468 L9D4C:
   9D4C 81 4B         [ 2] 3469         cmpa    #0x4B
   9D4E 27 04         [ 3] 3470         beq     L9D54  
   9D50 81 50         [ 2] 3471         cmpa    #0x50
   9D52 26 07         [ 3] 3472         bne     L9D5B  
   9D54                    3473 L9D54:
   9D54 86 02         [ 2] 3474         ldaa    #0x02
   9D56 B7 02 98      [ 4] 3475         staa    (0x0298)
   9D59 20 23         [ 3] 3476         bra     L9D7E  
   9D5B                    3477 L9D5B:
   9D5B 81 4C         [ 2] 3478         cmpa    #0x4C
   9D5D 26 07         [ 3] 3479         bne     L9D66  
   9D5F 86 03         [ 2] 3480         ldaa    #0x03
   9D61 B7 02 98      [ 4] 3481         staa    (0x0298)
   9D64 20 18         [ 3] 3482         bra     L9D7E  
   9D66                    3483 L9D66:
   9D66 81 52         [ 2] 3484         cmpa    #0x52
   9D68 26 07         [ 3] 3485         bne     L9D71  
   9D6A 86 04         [ 2] 3486         ldaa    #0x04
   9D6C B7 02 98      [ 4] 3487         staa    (0x0298)
   9D6F 20 0D         [ 3] 3488         bra     L9D7E  
   9D71                    3489 L9D71:
   9D71 DC 1B         [ 4] 3490         ldd     CDTIMR1
   9D73 26 B7         [ 3] 3491         bne     L9D2C  
   9D75 86 23         [ 2] 3492         ldaa    #0x23           ;'#'
   9D77 C6 29         [ 2] 3493         ldab    #0x29
   9D79 BD 8D B5      [ 6] 3494         jsr     L8DB5           ; display char here on LCD display
   9D7C 20 6C         [ 3] 3495         bra     L9DEA  
   9D7E                    3496 L9D7E:
   9D7E 7F 00 49      [ 6] 3497         clr     (0x0049)
   9D81 86 2A         [ 2] 3498         ldaa    #0x2A           ;'*'
   9D83 C6 29         [ 2] 3499         ldab    #0x29
   9D85 BD 8D B5      [ 6] 3500         jsr     L8DB5           ; display char here on LCD display
   9D88 7F 00 4A      [ 6] 3501         clr     (0x004A)
   9D8B CE 02 99      [ 3] 3502         ldx     #0x0299
   9D8E                    3503 L9D8E:
   9D8E BD 9B 19      [ 6] 3504         jsr     L9B19           ; do the random motions if enabled
   9D91 96 4A         [ 3] 3505         ldaa    (0x004A)
   9D93 27 F9         [ 3] 3506         beq     L9D8E  
   9D95 7F 00 4A      [ 6] 3507         clr     (0x004A)
   9D98 84 3F         [ 2] 3508         anda    #0x3F
   9D9A A7 00         [ 4] 3509         staa    0,X     
   9D9C 08            [ 3] 3510         inx
   9D9D 8C 02 9C      [ 4] 3511         cpx     #0x029C
   9DA0 26 EC         [ 3] 3512         bne     L9D8E  
   9DA2 BD 9D F5      [ 6] 3513         jsr     L9DF5
   9DA5 24 09         [ 3] 3514         bcc     L9DB0  
   9DA7 86 23         [ 2] 3515         ldaa    #0x23           ;'#'
   9DA9 C6 2A         [ 2] 3516         ldab    #0x2A
   9DAB BD 8D B5      [ 6] 3517         jsr     L8DB5           ; display char here on LCD display
   9DAE 20 3A         [ 3] 3518         bra     L9DEA  
   9DB0                    3519 L9DB0:
   9DB0 86 2A         [ 2] 3520         ldaa    #0x2A           ;'*'
   9DB2 C6 2A         [ 2] 3521         ldab    #0x2A
   9DB4 BD 8D B5      [ 6] 3522         jsr     L8DB5           ; display char here on LCD display
   9DB7 B6 02 99      [ 4] 3523         ldaa    (0x0299)
   9DBA 81 39         [ 2] 3524         cmpa    #0x39
   9DBC 26 15         [ 3] 3525         bne     L9DD3  
                           3526 
   9DBE BD 8D DD      [ 6] 3527         jsr     LCDMSG2 
   9DC1 47 65 6E 65 72 69  3528         .ascis  'Generic Showtape'
        63 20 53 68 6F 77
        74 61 70 E5
                           3529 
   9DD1 0C            [ 2] 3530         clc
   9DD2 39            [ 5] 3531         rts
                           3532 
   9DD3                    3533 L9DD3:
   9DD3 B6 02 98      [ 4] 3534         ldaa    (0x0298)
   9DD6 81 03         [ 2] 3535         cmpa    #0x03
   9DD8 27 0E         [ 3] 3536         beq     L9DE8  
   9DDA 81 04         [ 2] 3537         cmpa    #0x04
   9DDC 27 0A         [ 3] 3538         beq     L9DE8  
   9DDE 96 76         [ 3] 3539         ldaa    (0x0076)
   9DE0 26 06         [ 3] 3540         bne     L9DE8  
   9DE2 BD 9E 73      [ 6] 3541         jsr     L9E73
   9DE5 BD 9E CC      [ 6] 3542         jsr     L9ECC
   9DE8                    3543 L9DE8:
   9DE8 0C            [ 2] 3544         clc
   9DE9 39            [ 5] 3545         rts
                           3546 
   9DEA                    3547 L9DEA:
   9DEA FC 04 20      [ 5] 3548         ldd     (0x0420)
   9DED C3 00 01      [ 4] 3549         addd    #0x0001
   9DF0 FD 04 20      [ 5] 3550         std     (0x0420)
   9DF3 0D            [ 2] 3551         sec
   9DF4 39            [ 5] 3552         rts
                           3553 
   9DF5                    3554 L9DF5:
   9DF5 B6 02 99      [ 4] 3555         ldaa    (0x0299)
   9DF8 81 39         [ 2] 3556         cmpa    #0x39
   9DFA 27 6C         [ 3] 3557         beq     L9E68  
   9DFC CE 00 A8      [ 3] 3558         ldx     #0x00A8
   9DFF                    3559 L9DFF:
   9DFF BD 9B 19      [ 6] 3560         jsr     L9B19           ; do the random motions if enabled
   9E02 96 4A         [ 3] 3561         ldaa    (0x004A)
   9E04 27 F9         [ 3] 3562         beq     L9DFF  
   9E06 7F 00 4A      [ 6] 3563         clr     (0x004A)
   9E09 A7 00         [ 4] 3564         staa    0,X     
   9E0B 08            [ 3] 3565         inx
   9E0C 8C 00 AA      [ 4] 3566         cpx     #0x00AA
   9E0F 26 EE         [ 3] 3567         bne     L9DFF  
   9E11 BD 9E FA      [ 6] 3568         jsr     L9EFA
   9E14 CE 02 99      [ 3] 3569         ldx     #0x0299
   9E17 7F 00 13      [ 6] 3570         clr     (0x0013)
   9E1A                    3571 L9E1A:
   9E1A A6 00         [ 4] 3572         ldaa    0,X     
   9E1C 9B 13         [ 3] 3573         adda    (0x0013)
   9E1E 97 13         [ 3] 3574         staa    (0x0013)
   9E20 08            [ 3] 3575         inx
   9E21 8C 02 9C      [ 4] 3576         cpx     #0x029C
   9E24 26 F4         [ 3] 3577         bne     L9E1A  
   9E26 91 A8         [ 3] 3578         cmpa    (0x00A8)
   9E28 26 47         [ 3] 3579         bne     L9E71  
   9E2A CE 04 02      [ 3] 3580         ldx     #0x0402
   9E2D B6 02 98      [ 4] 3581         ldaa    (0x0298)
   9E30 81 02         [ 2] 3582         cmpa    #0x02
   9E32 26 03         [ 3] 3583         bne     L9E37  
   9E34 CE 04 05      [ 3] 3584         ldx     #0x0405
   9E37                    3585 L9E37:
   9E37 3C            [ 4] 3586         pshx
   9E38 BD AB 56      [ 6] 3587         jsr     LAB56
   9E3B 38            [ 5] 3588         pulx
   9E3C 25 07         [ 3] 3589         bcs     L9E45  
   9E3E 86 03         [ 2] 3590         ldaa    #0x03
   9E40 B7 02 98      [ 4] 3591         staa    (0x0298)
   9E43 20 23         [ 3] 3592         bra     L9E68  
   9E45                    3593 L9E45:
   9E45 B6 02 99      [ 4] 3594         ldaa    (0x0299)
   9E48 A1 00         [ 4] 3595         cmpa    0,X     
   9E4A 25 1E         [ 3] 3596         bcs     L9E6A  
   9E4C 27 02         [ 3] 3597         beq     L9E50  
   9E4E 24 18         [ 3] 3598         bcc     L9E68  
   9E50                    3599 L9E50:
   9E50 08            [ 3] 3600         inx
   9E51 B6 02 9A      [ 4] 3601         ldaa    (0x029A)
   9E54 A1 00         [ 4] 3602         cmpa    0,X     
   9E56 25 12         [ 3] 3603         bcs     L9E6A  
   9E58 27 02         [ 3] 3604         beq     L9E5C  
   9E5A 24 0C         [ 3] 3605         bcc     L9E68  
   9E5C                    3606 L9E5C:
   9E5C 08            [ 3] 3607         inx
   9E5D B6 02 9B      [ 4] 3608         ldaa    (0x029B)
   9E60 A1 00         [ 4] 3609         cmpa    0,X     
   9E62 25 06         [ 3] 3610         bcs     L9E6A  
   9E64 27 02         [ 3] 3611         beq     L9E68  
   9E66 24 00         [ 3] 3612         bcc     L9E68  
   9E68                    3613 L9E68:
   9E68 0C            [ 2] 3614         clc
   9E69 39            [ 5] 3615         rts
                           3616 
   9E6A                    3617 L9E6A:
   9E6A B6 02 98      [ 4] 3618         ldaa    (0x0298)
   9E6D 81 03         [ 2] 3619         cmpa    #0x03
   9E6F 27 F7         [ 3] 3620         beq     L9E68  
   9E71                    3621 L9E71:
   9E71 0D            [ 2] 3622         sec
   9E72 39            [ 5] 3623         rts
                           3624 
   9E73                    3625 L9E73:
   9E73 CE 04 02      [ 3] 3626         ldx     #0x0402
   9E76 B6 02 98      [ 4] 3627         ldaa    (0x0298)
   9E79 81 02         [ 2] 3628         cmpa    #0x02
   9E7B 26 03         [ 3] 3629         bne     L9E80  
   9E7D CE 04 05      [ 3] 3630         ldx     #0x0405
   9E80                    3631 L9E80:
   9E80 B6 02 99      [ 4] 3632         ldaa    (0x0299)
   9E83 A7 00         [ 4] 3633         staa    0,X     
   9E85 08            [ 3] 3634         inx
   9E86 B6 02 9A      [ 4] 3635         ldaa    (0x029A)
   9E89 A7 00         [ 4] 3636         staa    0,X     
   9E8B 08            [ 3] 3637         inx
   9E8C B6 02 9B      [ 4] 3638         ldaa    (0x029B)
   9E8F A7 00         [ 4] 3639         staa    0,X     
   9E91 39            [ 5] 3640         rts
                           3641 
                           3642 ; reset R counts
   9E92                    3643 L9E92:
   9E92 86 30         [ 2] 3644         ldaa    #0x30        
   9E94 B7 04 02      [ 4] 3645         staa    (0x0402)
   9E97 B7 04 03      [ 4] 3646         staa    (0x0403)
   9E9A B7 04 04      [ 4] 3647         staa    (0x0404)
                           3648 
   9E9D BD 8D DD      [ 6] 3649         jsr     LCDMSG2 
   9EA0 52 65 67 20 23 20  3650         .ascis  'Reg # cleared!'
        63 6C 65 61 72 65
        64 A1
                           3651 
   9EAE 39            [ 5] 3652         rts
                           3653 
                           3654 ; reset L counts
   9EAF                    3655 L9EAF:
   9EAF 86 30         [ 2] 3656         ldaa    #0x30
   9EB1 B7 04 05      [ 4] 3657         staa    (0x0405)
   9EB4 B7 04 06      [ 4] 3658         staa    (0x0406)
   9EB7 B7 04 07      [ 4] 3659         staa    (0x0407)
                           3660 
   9EBA BD 8D DD      [ 6] 3661         jsr     LCDMSG2 
   9EBD 4C 69 76 20 23 20  3662         .ascis  'Liv # cleared!'
        63 6C 65 61 72 65
        64 A1
                           3663 
   9ECB 39            [ 5] 3664         rts
                           3665 
                           3666 ; display R and L counts?
   9ECC                    3667 L9ECC:
   9ECC 86 52         [ 2] 3668         ldaa    #0x52           ;'R'
   9ECE C6 2B         [ 2] 3669         ldab    #0x2B
   9ED0 BD 8D B5      [ 6] 3670         jsr     L8DB5           ; display char here on LCD display
   9ED3 86 4C         [ 2] 3671         ldaa    #0x4C           ;'L'
   9ED5 C6 32         [ 2] 3672         ldab    #0x32
   9ED7 BD 8D B5      [ 6] 3673         jsr     L8DB5           ; display char here on LCD display
   9EDA CE 04 02      [ 3] 3674         ldx     #0x0402
   9EDD C6 2C         [ 2] 3675         ldab    #0x2C
   9EDF                    3676 L9EDF:
   9EDF A6 00         [ 4] 3677         ldaa    0,X     
   9EE1 BD 8D B5      [ 6] 3678         jsr     L8DB5           ; display 3 chars here on LCD display
   9EE4 5C            [ 2] 3679         incb
   9EE5 08            [ 3] 3680         inx
   9EE6 8C 04 05      [ 4] 3681         cpx     #0x0405
   9EE9 26 F4         [ 3] 3682         bne     L9EDF  
   9EEB C6 33         [ 2] 3683         ldab    #0x33
   9EED                    3684 L9EED:
   9EED A6 00         [ 4] 3685         ldaa    0,X     
   9EEF BD 8D B5      [ 6] 3686         jsr     L8DB5           ; display 3 chars here on LCD display
   9EF2 5C            [ 2] 3687         incb
   9EF3 08            [ 3] 3688         inx
   9EF4 8C 04 08      [ 4] 3689         cpx     #0x0408
   9EF7 26 F4         [ 3] 3690         bne     L9EED  
   9EF9 39            [ 5] 3691         rts
                           3692 
   9EFA                    3693 L9EFA:
   9EFA 96 A8         [ 3] 3694         ldaa    (0x00A8)
   9EFC BD 9F 0F      [ 6] 3695         jsr     L9F0F
   9EFF 48            [ 2] 3696         asla
   9F00 48            [ 2] 3697         asla
   9F01 48            [ 2] 3698         asla
   9F02 48            [ 2] 3699         asla
   9F03 97 13         [ 3] 3700         staa    (0x0013)
   9F05 96 A9         [ 3] 3701         ldaa    (0x00A9)
   9F07 BD 9F 0F      [ 6] 3702         jsr     L9F0F
   9F0A 9B 13         [ 3] 3703         adda    (0x0013)
   9F0C 97 A8         [ 3] 3704         staa    (0x00A8)
   9F0E 39            [ 5] 3705         rts
                           3706 
   9F0F                    3707 L9F0F:
   9F0F 81 2F         [ 2] 3708         cmpa    #0x2F
   9F11 24 02         [ 3] 3709         bcc     L9F15  
   9F13 86 30         [ 2] 3710         ldaa    #0x30
   9F15                    3711 L9F15:
   9F15 81 3A         [ 2] 3712         cmpa    #0x3A
   9F17 25 02         [ 3] 3713         bcs     L9F1B  
   9F19 80 07         [ 2] 3714         suba    #0x07
   9F1B                    3715 L9F1B:
   9F1B 80 30         [ 2] 3716         suba    #0x30
   9F1D 39            [ 5] 3717         rts
                           3718 
                           3719 ; different behavior based on serial number
   9F1E                    3720 L9F1E:
   9F1E FC 02 9C      [ 5] 3721         ldd     (0x029C)
   9F21 1A 83 00 01   [ 5] 3722         cpd     #0x0001         ; if 1, password bypass
   9F25 27 0C         [ 3] 3723         beq     L9F33           ;
   9F27 1A 83 03 E8   [ 5] 3724         cpd     #0x03E8         ; 1000
   9F2B 25 20         [ 3] 3725         bcs     L9F4D           ; if > 1000, code
   9F2D 1A 83 04 4B   [ 5] 3726         cpd     #0x044B         ; 1099
   9F31 22 1A         [ 3] 3727         bhi     L9F4D           ; if < 1099, code
                           3728                                 ; else 1 < x < 1000, bypass
                           3729 
   9F33                    3730 L9F33:
   9F33 BD 8D E4      [ 6] 3731         jsr     LCDMSG1 
   9F36 50 61 73 73 77 6F  3732         .ascis  'Password bypass '
        72 64 20 62 79 70
        61 73 73 A0
                           3733 
   9F46 C6 04         [ 2] 3734         ldab    #0x04
   9F48 BD 8C 30      [ 6] 3735         jsr     DLYSECSBY2      ; delay 2 sec
   9F4B 0C            [ 2] 3736         clc
   9F4C 39            [ 5] 3737         rts
                           3738 
   9F4D                    3739 L9F4D:
   9F4D BD 8C F2      [ 6] 3740         jsr     L8CF2
   9F50 BD 8D 03      [ 6] 3741         jsr     L8D03
                           3742 
   9F53 BD 8D E4      [ 6] 3743         jsr     LCDMSG1 
   9F56 43 6F 64 65 BA     3744         .ascis  'Code:'
                           3745 
                           3746 ; Generate a random 5-digit code in 0x0290-0x0294, and display to user
                           3747 
   9F5B CE 02 90      [ 3] 3748         ldx     #0x0290
   9F5E 7F 00 16      [ 6] 3749         clr     (0x0016)        ; 0x00
   9F61                    3750 L9F61:
   9F61 86 41         [ 2] 3751         ldaa    #0x41           ; 'A'
   9F63                    3752 L9F63:
   9F63 97 15         [ 3] 3753         staa    (0x0015)        ; 0x41
   9F65 BD 8E 95      [ 6] 3754         jsr     L8E95           ; roll the dice
   9F68 81 0D         [ 2] 3755         cmpa    #0x0D
   9F6A 26 11         [ 3] 3756         bne     L9F7D
   9F6C 96 15         [ 3] 3757         ldaa    (0x0015)
   9F6E A7 00         [ 4] 3758         staa    0,X     
   9F70 08            [ 3] 3759         inx
   9F71 BD 8C 98      [ 6] 3760         jsr     L8C98
   9F74 96 16         [ 3] 3761         ldaa    (0x0016)
   9F76 4C            [ 2] 3762         inca
   9F77 97 16         [ 3] 3763         staa    (0x0016)
   9F79 81 05         [ 2] 3764         cmpa    #0x05
   9F7B 27 09         [ 3] 3765         beq     L9F86  
   9F7D                    3766 L9F7D:
   9F7D 96 15         [ 3] 3767         ldaa    (0x0015)
   9F7F 4C            [ 2] 3768         inca
   9F80 81 5B         [ 2] 3769         cmpa    #0x5B           ; '['
   9F82 27 DD         [ 3] 3770         beq     L9F61  
   9F84 20 DD         [ 3] 3771         bra     L9F63  
                           3772 
                           3773 ; Let the user type in a corresponding password to the code
   9F86                    3774 L9F86:
   9F86 BD 8D DD      [ 6] 3775         jsr     LCDMSG2 
   9F89 50 73 77 64 BA     3776         .ascis  'Pswd:'
                           3777 
   9F8E CE 02 88      [ 3] 3778         ldx     #0x0288
   9F91 86 41         [ 2] 3779         ldaa    #0x41           ; 'A'
   9F93 97 16         [ 3] 3780         staa    (0x0016)
   9F95 86 C5         [ 2] 3781         ldaa    #0xC5           ; 
   9F97 97 15         [ 3] 3782         staa    (0x0015)
   9F99                    3783 L9F99:
   9F99 96 15         [ 3] 3784         ldaa    (0x0015)
   9F9B BD 8C 86      [ 6] 3785         jsr     L8C86           ; write byte to LCD
   9F9E 96 16         [ 3] 3786         ldaa    (0x0016)
   9FA0 BD 8C 98      [ 6] 3787         jsr     L8C98
   9FA3                    3788 L9FA3:
   9FA3 BD 8E 95      [ 6] 3789         jsr     L8E95
   9FA6 27 FB         [ 3] 3790         beq     L9FA3  
   9FA8 81 0D         [ 2] 3791         cmpa    #0x0D
   9FAA 26 10         [ 3] 3792         bne     L9FBC  
   9FAC 96 16         [ 3] 3793         ldaa    (0x0016)
   9FAE A7 00         [ 4] 3794         staa    0,X     
   9FB0 08            [ 3] 3795         inx
   9FB1 96 15         [ 3] 3796         ldaa    (0x0015)
   9FB3 4C            [ 2] 3797         inca
   9FB4 97 15         [ 3] 3798         staa    (0x0015)
   9FB6 81 CA         [ 2] 3799         cmpa    #0xCA
   9FB8 27 28         [ 3] 3800         beq     L9FE2  
   9FBA 20 DD         [ 3] 3801         bra     L9F99  
   9FBC                    3802 L9FBC:
   9FBC 81 01         [ 2] 3803         cmpa    #0x01
   9FBE 26 0F         [ 3] 3804         bne     L9FCF  
   9FC0 96 16         [ 3] 3805         ldaa    (0x0016)
   9FC2 4C            [ 2] 3806         inca
   9FC3 97 16         [ 3] 3807         staa    (0x0016)
   9FC5 81 5B         [ 2] 3808         cmpa    #0x5B
   9FC7 26 D0         [ 3] 3809         bne     L9F99  
   9FC9 86 41         [ 2] 3810         ldaa    #0x41
   9FCB 97 16         [ 3] 3811         staa    (0x0016)
   9FCD 20 CA         [ 3] 3812         bra     L9F99  
   9FCF                    3813 L9FCF:
   9FCF 81 02         [ 2] 3814         cmpa    #0x02
   9FD1 26 D0         [ 3] 3815         bne     L9FA3  
   9FD3 96 16         [ 3] 3816         ldaa    (0x0016)
   9FD5 4A            [ 2] 3817         deca
   9FD6 97 16         [ 3] 3818         staa    (0x0016)
   9FD8 81 40         [ 2] 3819         cmpa    #0x40
   9FDA 26 BD         [ 3] 3820         bne     L9F99  
   9FDC 86 5A         [ 2] 3821         ldaa    #0x5A
   9FDE 97 16         [ 3] 3822         staa    (0x0016)
   9FE0 20 B7         [ 3] 3823         bra     L9F99  
   9FE2                    3824 L9FE2:
   9FE2 BD A0 01      [ 6] 3825         jsr     LA001           ; validate
   9FE5 25 0F         [ 3] 3826         bcs     L9FF6           ; if bad, jump
   9FE7 86 DB         [ 2] 3827         ldaa    #0xDB
   9FE9 97 AB         [ 3] 3828         staa    (0x00AB)        ; good password
   9FEB FC 04 16      [ 5] 3829         ldd     (0x0416)        ; increment number of good validations counter
   9FEE C3 00 01      [ 4] 3830         addd    #0x0001
   9FF1 FD 04 16      [ 5] 3831         std     (0x0416)
   9FF4 0C            [ 2] 3832         clc
   9FF5 39            [ 5] 3833         rts
                           3834 
   9FF6                    3835 L9FF6:
   9FF6 FC 04 14      [ 5] 3836         ldd     (0x0414)        ; increment number of bad validations counter
   9FF9 C3 00 01      [ 4] 3837         addd    #0x0001
   9FFC FD 04 14      [ 5] 3838         std     (0x0414)
   9FFF 0D            [ 2] 3839         sec
   A000 39            [ 5] 3840         rts
                           3841 
                           3842 ; Validate password?
   A001                    3843 LA001:
                           3844         ; scramble 5 letters
   A001 B6 02 90      [ 4] 3845         ldaa    (0x0290)        ; 0 -> 1
   A004 B7 02 81      [ 4] 3846         staa    (0x0281)
   A007 B6 02 91      [ 4] 3847         ldaa    (0x0291)        ; 1 -> 3
   A00A B7 02 83      [ 4] 3848         staa    (0x0283)
   A00D B6 02 92      [ 4] 3849         ldaa    (0x0292)        ; 2 -> 4
   A010 B7 02 84      [ 4] 3850         staa    (0x0284)
   A013 B6 02 93      [ 4] 3851         ldaa    (0x0293)        ; 3 -> 0
   A016 B7 02 80      [ 4] 3852         staa    (0x0280)
   A019 B6 02 94      [ 4] 3853         ldaa    (0x0294)        ; 4 -> 2
   A01C B7 02 82      [ 4] 3854         staa    (0x0282)
                           3855         ; transform each letter
   A01F B6 02 80      [ 4] 3856         ldaa    (0x0280)    
   A022 88 13         [ 2] 3857         eora    #0x13
   A024 8B 03         [ 2] 3858         adda    #0x03
   A026 B7 02 80      [ 4] 3859         staa    (0x0280)
   A029 B6 02 81      [ 4] 3860         ldaa    (0x0281)
   A02C 88 04         [ 2] 3861         eora    #0x04
   A02E 8B 12         [ 2] 3862         adda    #0x12
   A030 B7 02 81      [ 4] 3863         staa    (0x0281)
   A033 B6 02 82      [ 4] 3864         ldaa    (0x0282)
   A036 88 06         [ 2] 3865         eora    #0x06
   A038 8B 04         [ 2] 3866         adda    #0x04
   A03A B7 02 82      [ 4] 3867         staa    (0x0282)
   A03D B6 02 83      [ 4] 3868         ldaa    (0x0283)
   A040 88 11         [ 2] 3869         eora    #0x11
   A042 8B 07         [ 2] 3870         adda    #0x07
   A044 B7 02 83      [ 4] 3871         staa    (0x0283)
   A047 B6 02 84      [ 4] 3872         ldaa    (0x0284)
   A04A 88 01         [ 2] 3873         eora    #0x01
   A04C 8B 10         [ 2] 3874         adda    #0x10
   A04E B7 02 84      [ 4] 3875         staa    (0x0284)
                           3876         ; keep them modulo 26 (A-Z)
   A051 BD A0 AF      [ 6] 3877         jsr     LA0AF
                           3878         ; put some of the original bits into 0x0015/0x0016
   A054 B6 02 94      [ 4] 3879         ldaa    (0x0294)
   A057 84 17         [ 2] 3880         anda    #0x17
   A059 97 15         [ 3] 3881         staa    (0x0015)
   A05B B6 02 90      [ 4] 3882         ldaa    (0x0290)
   A05E 84 17         [ 2] 3883         anda    #0x17
   A060 97 16         [ 3] 3884         staa    (0x0016)
                           3885         ; do some eoring with these bits
   A062 CE 02 80      [ 3] 3886         ldx     #0x0280
   A065                    3887 LA065:
   A065 A6 00         [ 4] 3888         ldaa    0,X
   A067 98 15         [ 3] 3889         eora    (0x0015)
   A069 98 16         [ 3] 3890         eora    (0x0016)
   A06B A7 00         [ 4] 3891         staa    0,X
   A06D 08            [ 3] 3892         inx
   A06E 8C 02 85      [ 4] 3893         cpx     #0x0285
   A071 26 F2         [ 3] 3894         bne     LA065
                           3895         ; keep them modulo 26 (A-Z)
   A073 BD A0 AF      [ 6] 3896         jsr     LA0AF
                           3897         ; compare them to code in 0x0288-0x028C
   A076 CE 02 80      [ 3] 3898         ldx     #0x0280
   A079 18 CE 02 88   [ 4] 3899         ldy     #0x0288
   A07D                    3900 LA07D:
   A07D A6 00         [ 4] 3901         ldaa    0,X     
   A07F 18 A1 00      [ 5] 3902         cmpa    0,Y     
   A082 26 0A         [ 3] 3903         bne     LA08E  
   A084 08            [ 3] 3904         inx
   A085 18 08         [ 4] 3905         iny
   A087 8C 02 85      [ 4] 3906         cpx     #0x0285
   A08A 26 F1         [ 3] 3907         bne     LA07D  
   A08C 0C            [ 2] 3908         clc                     ; carry clear if good
   A08D 39            [ 5] 3909         rts
                           3910 
   A08E                    3911 LA08E:
   A08E 0D            [ 2] 3912         sec                     ; carry set if bad
   A08F 39            [ 5] 3913         rts
                           3914 
                           3915 ; trivial password validation - not used??
   A090                    3916 LA090:
   A090 59 41 44 44 41     3917         .ascii  'YADDA'
                           3918 
   A095 CE 02 88      [ 3] 3919         ldx     #0x0288
   A098 18 CE A0 90   [ 4] 3920         ldy     #LA090
   A09C                    3921 LA09C:
   A09C A6 00         [ 4] 3922         ldaa    0,X
   A09E 18 A1 00      [ 5] 3923         cmpa    0,Y
   A0A1 26 0A         [ 3] 3924         bne     LA0AD
   A0A3 08            [ 3] 3925         inx
   A0A4 18 08         [ 4] 3926         iny
   A0A6 8C 02 8D      [ 4] 3927         cpx     #0x028D
   A0A9 26 F1         [ 3] 3928         bne     LA09C
   A0AB 0C            [ 2] 3929         clc
   A0AC 39            [ 5] 3930         rts
   A0AD                    3931 LA0AD:
   A0AD 0D            [ 2] 3932         sec
   A0AE 39            [ 5] 3933         rts
                           3934 
                           3935 ; keep the password modulo 26, each letter in range 'A-Z'
   A0AF                    3936 LA0AF:
   A0AF CE 02 80      [ 3] 3937         ldx     #0x0280
   A0B2                    3938 LA0B2:
   A0B2 A6 00         [ 4] 3939         ldaa    0,X
   A0B4 81 5B         [ 2] 3940         cmpa    #0x5B
   A0B6 25 06         [ 3] 3941         bcs     LA0BE
   A0B8 80 1A         [ 2] 3942         suba    #0x1A
   A0BA A7 00         [ 4] 3943         staa    0,X
   A0BC 20 08         [ 3] 3944         bra     LA0C6
   A0BE                    3945 LA0BE:
   A0BE 81 41         [ 2] 3946         cmpa    #0x41
   A0C0 24 04         [ 3] 3947         bcc     LA0C6
   A0C2 8B 1A         [ 2] 3948         adda    #0x1A
   A0C4 A7 00         [ 4] 3949         staa    0,X
   A0C6                    3950 LA0C6:
   A0C6 08            [ 3] 3951         inx
   A0C7 8C 02 85      [ 4] 3952         cpx     #0x0285
   A0CA 26 E6         [ 3] 3953         bne     LA0B2  
   A0CC 39            [ 5] 3954         rts
                           3955 
   A0CD BD 8C F2      [ 6] 3956         jsr     L8CF2
                           3957 
   A0D0 BD 8D DD      [ 6] 3958         jsr     LCDMSG2 
   A0D3 46 61 69 6C 65 64  3959         .ascis  'Failed!         '
        21 20 20 20 20 20
        20 20 20 A0
                           3960 
   A0E3 C6 02         [ 2] 3961         ldab    #0x02
   A0E5 BD 8C 30      [ 6] 3962         jsr     DLYSECSBY2      ; delay 1 sec
   A0E8 39            [ 5] 3963         rts
                           3964 
   A0E9                    3965 LA0E9:
   A0E9 C6 01         [ 2] 3966         ldab    #0x01
   A0EB BD 8C 30      [ 6] 3967         jsr     DLYSECSBY2      ; delay 0.5 sec
   A0EE 7F 00 4E      [ 6] 3968         clr     (0x004E)
   A0F1 C6 D3         [ 2] 3969         ldab    #0xD3
   A0F3 BD 87 48      [ 6] 3970         jsr     L8748   
   A0F6 BD 87 AE      [ 6] 3971         jsr     L87AE
   A0F9 BD 8C E9      [ 6] 3972         jsr     L8CE9
                           3973 
   A0FC BD 8D E4      [ 6] 3974         jsr     LCDMSG1 
   A0FF 20 20 20 56 43 52  3975         .ascis  '   VCR adjust'
        20 61 64 6A 75 73
        F4
                           3976 
   A10C BD 8D DD      [ 6] 3977         jsr     LCDMSG2 
   A10F 55 50 20 74 6F 20  3978         .ascis  'UP to clear bits'
        63 6C 65 61 72 20
        62 69 74 F3
                           3979 
   A11F 5F            [ 2] 3980         clrb
   A120 D7 62         [ 3] 3981         stab    (0x0062)
   A122 BD F9 C5      [ 6] 3982         jsr     BUTNLIT 
   A125 B6 18 04      [ 4] 3983         ldaa    PIA0PRA 
   A128 84 BF         [ 2] 3984         anda    #0xBF
   A12A B7 18 04      [ 4] 3985         staa    PIA0PRA 
   A12D BD 8E 95      [ 6] 3986         jsr     L8E95
   A130 7F 00 48      [ 6] 3987         clr     (0x0048)
   A133 7F 00 49      [ 6] 3988         clr     (0x0049)
   A136 BD 86 C4      [ 6] 3989         jsr     L86C4           ; Reset boards 1-10
   A139 86 28         [ 2] 3990         ldaa    #0x28
   A13B 97 63         [ 3] 3991         staa    (0x0063)
   A13D C6 FD         [ 2] 3992         ldab    #0xFD           ; tape deck STOP
   A13F BD 86 E7      [ 6] 3993         jsr     L86E7
   A142 BD A3 2E      [ 6] 3994         jsr     LA32E
   A145 7C 00 76      [ 6] 3995         inc     (0x0076)
   A148 7F 00 32      [ 6] 3996         clr     (0x0032)
   A14B                    3997 LA14B:
   A14B BD 8E 95      [ 6] 3998         jsr     L8E95
   A14E 81 0D         [ 2] 3999         cmpa    #0x0D
   A150 26 03         [ 3] 4000         bne     LA155  
   A152 7E A1 C4      [ 3] 4001         jmp     LA1C4
   A155                    4002 LA155:
   A155 86 28         [ 2] 4003         ldaa    #0x28
   A157 97 63         [ 3] 4004         staa    (0x0063)
   A159 BD 86 A4      [ 6] 4005         jsr     L86A4
   A15C 25 ED         [ 3] 4006         bcs     LA14B  
   A15E FC 04 1A      [ 5] 4007         ldd     (0x041A)
   A161 C3 00 01      [ 4] 4008         addd    #0x0001
   A164 FD 04 1A      [ 5] 4009         std     (0x041A)
   A167 BD 86 C4      [ 6] 4010         jsr     L86C4           ; Reset boards 1-10
   A16A 7C 00 4E      [ 6] 4011         inc     (0x004E)
   A16D C6 D3         [ 2] 4012         ldab    #0xD3
   A16F BD 87 48      [ 6] 4013         jsr     L8748   
   A172 BD 87 AE      [ 6] 4014         jsr     L87AE
   A175                    4015 LA175:
   A175 96 49         [ 3] 4016         ldaa    (0x0049)
   A177 81 43         [ 2] 4017         cmpa    #0x43
   A179 26 06         [ 3] 4018         bne     LA181  
   A17B 7F 00 49      [ 6] 4019         clr     (0x0049)
   A17E 7F 00 48      [ 6] 4020         clr     (0x0048)
   A181                    4021 LA181:
   A181 96 48         [ 3] 4022         ldaa    (0x0048)
   A183 81 C8         [ 2] 4023         cmpa    #0xC8
   A185 25 1F         [ 3] 4024         bcs     LA1A6  
   A187 FC 02 9C      [ 5] 4025         ldd     (0x029C)
   A18A 1A 83 00 01   [ 5] 4026         cpd     #0x0001
   A18E 27 16         [ 3] 4027         beq     LA1A6  
   A190 C6 EF         [ 2] 4028         ldab    #0xEF           ; tape deck EJECT
   A192 BD 86 E7      [ 6] 4029         jsr     L86E7
   A195 BD 86 C4      [ 6] 4030         jsr     L86C4           ; Reset boards 1-10
   A198 7F 00 4E      [ 6] 4031         clr     (0x004E)
   A19B 7F 00 76      [ 6] 4032         clr     (0x0076)
   A19E C6 0A         [ 2] 4033         ldab    #0x0A
   A1A0 BD 8C 30      [ 6] 4034         jsr     DLYSECSBY2      ; delay 5 sec
   A1A3 7E 81 D7      [ 3] 4035         jmp     L81D7
   A1A6                    4036 LA1A6:
   A1A6 BD 8E 95      [ 6] 4037         jsr     L8E95
   A1A9 81 01         [ 2] 4038         cmpa    #0x01
   A1AB 26 10         [ 3] 4039         bne     LA1BD  
   A1AD CE 10 80      [ 3] 4040         ldx     #0x1080
   A1B0 86 34         [ 2] 4041         ldaa    #0x34
   A1B2                    4042 LA1B2:
   A1B2 6F 00         [ 6] 4043         clr     0,X     
   A1B4 A7 01         [ 4] 4044         staa    1,X     
   A1B6 08            [ 3] 4045         inx
   A1B7 08            [ 3] 4046         inx
   A1B8 8C 10 A0      [ 4] 4047         cpx     #0x10A0
   A1BB 25 F5         [ 3] 4048         bcs     LA1B2  
   A1BD                    4049 LA1BD:
   A1BD 81 0D         [ 2] 4050         cmpa    #0x0D
   A1BF 27 03         [ 3] 4051         beq     LA1C4  
   A1C1 7E A1 75      [ 3] 4052         jmp     LA175
   A1C4                    4053 LA1C4:
   A1C4 7F 00 76      [ 6] 4054         clr     (0x0076)
   A1C7 7F 00 4E      [ 6] 4055         clr     (0x004E)
   A1CA C6 DF         [ 2] 4056         ldab    #0xDF
   A1CC BD 87 48      [ 6] 4057         jsr     L8748   
   A1CF BD 87 91      [ 6] 4058         jsr     L8791   
   A1D2 7E 81 D7      [ 3] 4059         jmp     L81D7
                           4060 
                           4061 ; reprogram EEPROM signature if needed
   A1D5                    4062 LA1D5:
   A1D5 86 07         [ 2] 4063         ldaa    #0x07
   A1D7 B7 04 00      [ 4] 4064         staa    (0x0400)
   A1DA CC 0E 09      [ 3] 4065         ldd     #0x0E09
   A1DD 81 65         [ 2] 4066         cmpa    #0x65           ;'e'
   A1DF 26 05         [ 3] 4067         bne     LA1E6
   A1E1 C1 63         [ 2] 4068         cmpb    #0x63           ;'c'
   A1E3 26 01         [ 3] 4069         bne     LA1E6
   A1E5 39            [ 5] 4070         rts
                           4071 
                           4072 ; erase and reprogram EEPROM signature
   A1E6                    4073 LA1E6:
   A1E6 86 0E         [ 2] 4074         ldaa    #0x0E
   A1E8 B7 10 3B      [ 4] 4075         staa    PPROG
   A1EB 86 FF         [ 2] 4076         ldaa    #0xFF
   A1ED B7 0E 00      [ 4] 4077         staa    (0x0E00)
   A1F0 B6 10 3B      [ 4] 4078         ldaa    PPROG  
   A1F3 8A 01         [ 2] 4079         oraa    #0x01
   A1F5 B7 10 3B      [ 4] 4080         staa    PPROG  
   A1F8 CE 1B 58      [ 3] 4081         ldx     #0x1B58         ; 7000
   A1FB                    4082 LA1FB:
   A1FB 09            [ 3] 4083         dex
   A1FC 26 FD         [ 3] 4084         bne     LA1FB  
   A1FE B6 10 3B      [ 4] 4085         ldaa    PPROG  
   A201 84 FE         [ 2] 4086         anda    #0xFE
   A203 B7 10 3B      [ 4] 4087         staa    PPROG  
   A206 CE 0E 00      [ 3] 4088         ldx     #0x0E00
   A209 18 CE A2 26   [ 4] 4089         ldy     #LA226
   A20D                    4090 LA20D:
   A20D C6 02         [ 2] 4091         ldab    #0x02
   A20F F7 10 3B      [ 4] 4092         stab    PPROG  
   A212 18 A6 00      [ 5] 4093         ldaa    0,Y     
   A215 18 08         [ 4] 4094         iny
   A217 A7 00         [ 4] 4095         staa    0,X     
   A219 BD A2 32      [ 6] 4096         jsr     LA232
   A21C 08            [ 3] 4097         inx
   A21D 8C 0E 0C      [ 4] 4098         cpx     #0x0E0C
   A220 26 EB         [ 3] 4099         bne     LA20D  
   A222 7F 10 3B      [ 6] 4100         clr     PPROG  
   A225 39            [ 5] 4101         rts
                           4102 
                           4103 ; data for 0x0E00-0x0E0B EEPROM
   A226                    4104 LA226:
   A226 29 64 2A 21 32 3A  4105         .ascii  ')d*!2::4!ecq'
        3A 34 21 65 63 71
                           4106 
                           4107 ; program EEPROM
   A232                    4108 LA232:
   A232 18 3C         [ 5] 4109         pshy
   A234 C6 03         [ 2] 4110         ldab    #0x03
   A236 F7 10 3B      [ 4] 4111         stab    PPROG           ; start program
   A239 18 CE 1B 58   [ 4] 4112         ldy     #0x1B58
   A23D                    4113 LA23D:
   A23D 18 09         [ 4] 4114         dey
   A23F 26 FC         [ 3] 4115         bne     LA23D  
   A241 C6 02         [ 2] 4116         ldab    #0x02
   A243 F7 10 3B      [ 4] 4117         stab    PPROG           ; stop program
   A246 18 38         [ 6] 4118         puly
   A248 39            [ 5] 4119         rts
                           4120 
   A249                    4121 LA249:
   A249 0F            [ 2] 4122         sei
   A24A CE 00 10      [ 3] 4123         ldx     #0x0010
   A24D                    4124 LA24D:
   A24D 6F 00         [ 6] 4125         clr     0,X     
   A24F 08            [ 3] 4126         inx
   A250 8C 0E 00      [ 4] 4127         cpx     #0x0E00
   A253 26 F8         [ 3] 4128         bne     LA24D  
   A255 BD 9E AF      [ 6] 4129         jsr     L9EAF           ; reset L counts
   A258 BD 9E 92      [ 6] 4130         jsr     L9E92           ; reset R counts
   A25B 7E F8 00      [ 3] 4131         jmp     RESET           ; reset controller
                           4132 
                           4133 ; Compute and store copyright checksum
   A25E                    4134 LA25E:
   A25E 18 CE 80 03   [ 4] 4135         ldy     #CPYRTMSG       ; copyright message
   A262 CE 00 00      [ 3] 4136         ldx     #0x0000
   A265                    4137 LA265:
   A265 18 E6 00      [ 5] 4138         ldab    0,Y
   A268 3A            [ 3] 4139         abx
   A269 18 08         [ 4] 4140         iny
   A26B 18 8C 80 50   [ 5] 4141         cpy     #0x8050
   A26F 26 F4         [ 3] 4142         bne     LA265
   A271 FF 04 0B      [ 5] 4143         stx     CPYRTCS         ; store checksum here
   A274 39            [ 5] 4144         rts
                           4145 
                           4146 ; Erase EEPROM routine
   A275                    4147 LA275:
   A275 0F            [ 2] 4148         sei
   A276 7F 04 0F      [ 6] 4149         clr     ERASEFLG        ; Reset EEPROM Erase flag
   A279 86 0E         [ 2] 4150         ldaa    #0x0E
   A27B B7 10 3B      [ 4] 4151         staa    PPROG           ; ERASE mode!
   A27E 86 FF         [ 2] 4152         ldaa    #0xFF
   A280 B7 0E 20      [ 4] 4153         staa    (0x0E20)        ; save in NVRAM
   A283 B6 10 3B      [ 4] 4154         ldaa    PPROG  
   A286 8A 01         [ 2] 4155         oraa    #0x01
   A288 B7 10 3B      [ 4] 4156         staa    PPROG           ; do the ERASE
   A28B CE 1B 58      [ 3] 4157         ldx     #0x1B58         ; delay a bit
   A28E                    4158 LA28E:
   A28E 09            [ 3] 4159         dex
   A28F 26 FD         [ 3] 4160         bne     LA28E  
   A291 B6 10 3B      [ 4] 4161         ldaa    PPROG  
   A294 84 FE         [ 2] 4162         anda    #0xFE           ; stop erasing
   A296 7F 10 3B      [ 6] 4163         clr     PPROG  
                           4164 
   A299 BD F9 D8      [ 6] 4165         jsr     SERMSGW         ; display "enter serial number"
   A29C 45 6E 74 65 72 20  4166         .ascis  'Enter serial #: '
        73 65 72 69 61 6C
        20 23 3A A0
                           4167 
   A2AC CE 0E 20      [ 3] 4168         ldx     #0x0E20
   A2AF                    4169 LA2AF:
   A2AF BD F9 45      [ 6] 4170         jsr     SERIALR         ; wait for serial data
   A2B2 24 FB         [ 3] 4171         bcc     LA2AF  
                           4172 
   A2B4 BD F9 6F      [ 6] 4173         jsr     SERIALW         ; read serial data
   A2B7 C6 02         [ 2] 4174         ldab    #0x02
   A2B9 F7 10 3B      [ 4] 4175         stab    PPROG           ; protect only 0x0e20-0x0e5f
   A2BC A7 00         [ 4] 4176         staa    0,X         
   A2BE BD A2 32      [ 6] 4177         jsr     LA232           ; program byte
   A2C1 08            [ 3] 4178         inx
   A2C2 8C 0E 24      [ 4] 4179         cpx     #0x0E24
   A2C5 26 E8         [ 3] 4180         bne     LA2AF  
   A2C7 C6 02         [ 2] 4181         ldab    #0x02
   A2C9 F7 10 3B      [ 4] 4182         stab    PPROG  
   A2CC 86 DB         [ 2] 4183         ldaa    #0xDB           ; it's official
   A2CE B7 0E 24      [ 4] 4184         staa    (0x0E24)
   A2D1 BD A2 32      [ 6] 4185         jsr     LA232           ; program byte
   A2D4 7F 10 3B      [ 6] 4186         clr     PPROG  
   A2D7 86 1E         [ 2] 4187         ldaa    #0x1E
   A2D9 B7 10 35      [ 4] 4188         staa    BPROT           ; protect all but 0x0e00-0x0e1f
   A2DC 7E F8 00      [ 3] 4189         jmp     RESET           ; reset controller
                           4190 
   A2DF                    4191 LA2DF:
   A2DF 38            [ 5] 4192         pulx
   A2E0 3C            [ 4] 4193         pshx
   A2E1 8C 80 00      [ 4] 4194         cpx     #0x8000
   A2E4 25 02         [ 3] 4195         bcs     LA2E8           ; if 0x8000 < calling address (should be)
   A2E6 0C            [ 2] 4196         clc
   A2E7 39            [ 5] 4197         rts
                           4198 
   A2E8                    4199 LA2E8:
   A2E8 0D            [ 2] 4200         sec
   A2E9 39            [ 5] 4201         rts
                           4202 
                           4203 ; enter and validate security code via serial
   A2EA                    4204 LA2EA:
   A2EA CE 02 88      [ 3] 4205         ldx     #0x0288
   A2ED C6 03         [ 2] 4206         ldab    #0x03           ; 3 character code
                           4207 
   A2EF                    4208 LA2EF:
   A2EF BD F9 45      [ 6] 4209         jsr     SERIALR         ; check if available
   A2F2 24 FB         [ 3] 4210         bcc     LA2EF  
   A2F4 A7 00         [ 4] 4211         staa    0,X     
   A2F6 08            [ 3] 4212         inx
   A2F7 5A            [ 2] 4213         decb
   A2F8 26 F5         [ 3] 4214         bne     LA2EF  
                           4215 
   A2FA B6 02 88      [ 4] 4216         ldaa    (0x0288)
   A2FD 81 13         [ 2] 4217         cmpa    #0x13           ; 0x13
   A2FF 26 10         [ 3] 4218         bne     LA311  
   A301 B6 02 89      [ 4] 4219         ldaa    (0x0289)
   A304 81 10         [ 2] 4220         cmpa    #0x10           ; 0x10
   A306 26 09         [ 3] 4221         bne     LA311  
   A308 B6 02 8A      [ 4] 4222         ldaa    (0x028A)
   A30B 81 14         [ 2] 4223         cmpa    #0x14           ; 0x14
   A30D 26 02         [ 3] 4224         bne     LA311  
   A30F 0C            [ 2] 4225         clc
   A310 39            [ 5] 4226         rts
                           4227 
   A311                    4228 LA311:
   A311 0D            [ 2] 4229         sec
   A312 39            [ 5] 4230         rts
                           4231 
   A313                    4232 LA313:
   A313 36            [ 3] 4233         psha
   A314 B6 10 92      [ 4] 4234         ldaa    (0x1092)
   A317 8A 01         [ 2] 4235         oraa    #0x01
   A319                    4236 LA319:
   A319 B7 10 92      [ 4] 4237         staa    (0x1092)
   A31C 32            [ 4] 4238         pula
   A31D 39            [ 5] 4239         rts
                           4240 
   A31E                    4241 LA31E:
   A31E 36            [ 3] 4242         psha
   A31F B6 10 92      [ 4] 4243         ldaa    (0x1092)
   A322 84 FE         [ 2] 4244         anda    #0xFE
   A324 20 F3         [ 3] 4245         bra     LA319
                           4246 
   A326                    4247 LA326:
   A326 96 4E         [ 3] 4248         ldaa    (0x004E)
   A328 97 19         [ 3] 4249         staa    (0x0019)
   A32A 7F 00 4E      [ 6] 4250         clr     (0x004E)
   A32D 39            [ 5] 4251         rts
                           4252 
   A32E                    4253 LA32E:
   A32E B6 10 86      [ 4] 4254         ldaa    (0x1086)
   A331 8A 15         [ 2] 4255         oraa    #0x15
   A333 B7 10 86      [ 4] 4256         staa    (0x1086)
   A336 C6 01         [ 2] 4257         ldab    #0x01
   A338 BD 8C 30      [ 6] 4258         jsr     DLYSECSBY2      ; delay 0.5 sec
   A33B 84 EA         [ 2] 4259         anda    #0xEA
   A33D B7 10 86      [ 4] 4260         staa    (0x1086)
   A340 39            [ 5] 4261         rts
                           4262 
   A341                    4263 LA341:
   A341 B6 10 86      [ 4] 4264         ldaa    (0x1086)
   A344 8A 2A         [ 2] 4265         oraa    #0x2A           ; xx1x1x1x
   A346 B7 10 86      [ 4] 4266         staa    (0x1086)
   A349 C6 01         [ 2] 4267         ldab    #0x01
   A34B BD 8C 30      [ 6] 4268         jsr     DLYSECSBY2      ; delay 0.5 sec
   A34E 84 D5         [ 2] 4269         anda    #0xD5           ; xx0x0x0x
   A350 B7 10 86      [ 4] 4270         staa    (0x1086)
   A353 39            [ 5] 4271         rts
                           4272 
   A354                    4273 LA354:
   A354 F6 18 04      [ 4] 4274         ldab    PIA0PRA 
   A357 CA 08         [ 2] 4275         orab    #0x08
   A359 F7 18 04      [ 4] 4276         stab    PIA0PRA 
   A35C 39            [ 5] 4277         rts
                           4278 
   A35D F6 18 04      [ 4] 4279         ldab    PIA0PRA 
   A360 C4 F7         [ 2] 4280         andb    #0xF7
   A362 F7 18 04      [ 4] 4281         stab    PIA0PRA 
   A365 39            [ 5] 4282         rts
                           4283 
                           4284 ;'$' command goes here?
   A366                    4285 LA366:
   A366 7F 00 4E      [ 6] 4286         clr     (0x004E)
   A369 BD 86 C4      [ 6] 4287         jsr     L86C4           ; Reset boards 1-10
   A36C 7F 04 2A      [ 6] 4288         clr     (0x042A)
                           4289 
   A36F BD F9 D8      [ 6] 4290         jsr     SERMSGW
   A372 45 6E 74 65 72 20  4291         .ascis  'Enter security code:' 
        73 65 63 75 72 69
        74 79 20 63 6F 64
        65 BA
                           4292 
   A386 BD A2 EA      [ 6] 4293         jsr     LA2EA
   A389 24 03         [ 3] 4294         bcc     LA38E
   A38B 7E 83 31      [ 3] 4295         jmp     L8331
                           4296 
   A38E                    4297 LA38E:
   A38E BD F9 D8      [ 6] 4298         jsr     SERMSGW      
   A391 0C 0A 0D 44 61 76  4299         .ascii  "\f\n\rDave's Setup Utility\n\r"
        65 27 73 20 53 65
        74 75 70 20 55 74
        69 6C 69 74 79 0A
        0D
   A3AA 3C 4B 3E 69 6E 67  4300         .ascii  '<K>ing enable\n\r'
        20 65 6E 61 62 6C
        65 0A 0D
   A3B9 3C 43 3E 6C 65 61  4301         .ascii  '<C>lear random\n\r'
        72 20 72 61 6E 64
        6F 6D 0A 0D
   A3C9 3C 35 3E 20 63 68  4302         .ascii  '<5> character random\n\r'
        61 72 61 63 74 65
        72 20 72 61 6E 64
        6F 6D 0A 0D
   A3DF 3C 4C 3E 69 76 65  4303         .ascii  '<L>ive tape number clear\n\r'
        20 74 61 70 65 20
        6E 75 6D 62 65 72
        20 63 6C 65 61 72
        0A 0D
   A3F9 3C 52 3E 65 67 75  4304         .ascii  '<R>egular tape number clear\n\r'
        6C 61 72 20 74 61
        70 65 20 6E 75 6D
        62 65 72 20 63 6C
        65 61 72 0A 0D
   A416 3C 54 3E 65 73 74  4305         .ascii  '<T>est driver boards\n\r'
        20 64 72 69 76 65
        72 20 62 6F 61 72
        64 73 0A 0D
   A42C 3C 42 3E 75 62 20  4306         .ascii  '<B>ub test\n\r'
        74 65 73 74 0A 0D
   A438 3C 44 3E 65 63 6B  4307         .ascii  '<D>eck test (with tape inserted)\n\r'
        20 74 65 73 74 20
        28 77 69 74 68 20
        74 61 70 65 20 69
        6E 73 65 72 74 65
        64 29 0A 0D
   A45A 3C 37 3E 35 25 20  4308         .ascii  '<7>5% adjustment\n\r'
        61 64 6A 75 73 74
        6D 65 6E 74 0A 0D
   A46C 3C 53 3E 68 6F 77  4309         .ascii  '<S>how re-valid tapes\n\r'
        20 72 65 2D 76 61
        6C 69 64 20 74 61
        70 65 73 0A 0D
   A483 3C 4A 3E 75 6D 70  4310         .ascis  '<J>ump to system\n\r'
        20 74 6F 20 73 79
        73 74 65 6D 0A 8D
                           4311 
   A495                    4312 LA495:
   A495 BD F9 45      [ 6] 4313         jsr     SERIALR     
   A498 24 FB         [ 3] 4314         bcc     LA495  
   A49A 81 43         [ 2] 4315         cmpa    #0x43           ;'C'
   A49C 26 09         [ 3] 4316         bne     LA4A7  
   A49E 7F 04 01      [ 6] 4317         clr     (0x0401)        ;clear random
   A4A1 7F 04 2B      [ 6] 4318         clr     (0x042B)
   A4A4 7E A5 14      [ 3] 4319         jmp     LA514
   A4A7                    4320 LA4A7:
   A4A7 81 35         [ 2] 4321         cmpa    #0x35           ;'5'
   A4A9 26 0D         [ 3] 4322         bne     LA4B8  
   A4AB B6 04 01      [ 4] 4323         ldaa    (0x0401)        ;5 character random
   A4AE 84 7F         [ 2] 4324         anda    #0x7F
   A4B0 8A 7F         [ 2] 4325         oraa    #0x7F
   A4B2 B7 04 01      [ 4] 4326         staa    (0x0401)
   A4B5 7E A5 14      [ 3] 4327         jmp     LA514
   A4B8                    4328 LA4B8:
   A4B8 81 4C         [ 2] 4329         cmpa    #0x4C           ;'L'
   A4BA 26 06         [ 3] 4330         bne     LA4C2
   A4BC BD 9E AF      [ 6] 4331         jsr     L9EAF           ; reset Liv counts
   A4BF 7E A5 14      [ 3] 4332         jmp     LA514
   A4C2                    4333 LA4C2:
   A4C2 81 52         [ 2] 4334         cmpa    #0x52           ;'R'
   A4C4 26 06         [ 3] 4335         bne     LA4CC  
   A4C6 BD 9E 92      [ 6] 4336         jsr     L9E92           ; reset Reg counts
   A4C9 7E A5 14      [ 3] 4337         jmp     LA514
   A4CC                    4338 LA4CC:
   A4CC 81 54         [ 2] 4339         cmpa    #0x54           ;'T'
   A4CE 26 06         [ 3] 4340         bne     LA4D6  
   A4D0 BD A5 65      [ 6] 4341         jsr     LA565           ; test driver boards
   A4D3 7E A5 14      [ 3] 4342         jmp     LA514
   A4D6                    4343 LA4D6:
   A4D6 81 42         [ 2] 4344         cmpa    #0x42           ;'B'
   A4D8 26 06         [ 3] 4345         bne     LA4E0  
   A4DA BD A5 26      [ 6] 4346         jsr     LA526           ; bulb test?
   A4DD 7E A5 14      [ 3] 4347         jmp     LA514
   A4E0                    4348 LA4E0:
   A4E0 81 44         [ 2] 4349         cmpa    #0x44           ;'D'
   A4E2 26 06         [ 3] 4350         bne     LA4EA  
   A4E4 BD A5 3C      [ 6] 4351         jsr     LA53C           ; deck test
   A4E7 7E A5 14      [ 3] 4352         jmp     LA514
   A4EA                    4353 LA4EA:
   A4EA 81 37         [ 2] 4354         cmpa    #0x37           ;'7'
   A4EC 26 08         [ 3] 4355         bne     LA4F6  
   A4EE C6 FB         [ 2] 4356         ldab    #0xFB           ; tape deck PLAY
   A4F0 BD 86 E7      [ 6] 4357         jsr     L86E7           ; 5% adjustment
   A4F3 7E A5 14      [ 3] 4358         jmp     LA514
   A4F6                    4359 LA4F6:
   A4F6 81 4A         [ 2] 4360         cmpa    #0x4A           ;'J'
   A4F8 26 03         [ 3] 4361         bne     LA4FD  
   A4FA 7E F8 00      [ 3] 4362         jmp     RESET           ; jump to system (reset)
   A4FD                    4363 LA4FD:
   A4FD 81 4B         [ 2] 4364         cmpa    #0x4B           ;'K'
   A4FF 26 06         [ 3] 4365         bne     LA507  
   A501 7C 04 2A      [ 6] 4366         inc     (0x042A)        ; King enable
   A504 7E A5 14      [ 3] 4367         jmp     LA514
   A507                    4368 LA507:
   A507 81 53         [ 2] 4369         cmpa    #0x53           ;'S'
   A509 26 06         [ 3] 4370         bne     LA511  
   A50B BD AB 7C      [ 6] 4371         jsr     LAB7C           ; show re-valid tapes
   A50E 7E A5 14      [ 3] 4372         jmp     LA514
   A511                    4373 LA511:
   A511 7E A4 95      [ 3] 4374         jmp     LA495
   A514                    4375 LA514:
   A514 86 07         [ 2] 4376         ldaa    #0x07
   A516 BD F9 6F      [ 6] 4377         jsr     SERIALW      
   A519 C6 01         [ 2] 4378         ldab    #0x01
   A51B BD 8C 30      [ 6] 4379         jsr     DLYSECSBY2      ; delay 0.5 sec
   A51E 86 07         [ 2] 4380         ldaa    #0x07
   A520 BD F9 6F      [ 6] 4381         jsr     SERIALW      
   A523 7E A3 8E      [ 3] 4382         jmp     LA38E
                           4383 
                           4384 ; bulb test
   A526                    4385 LA526:
   A526 5F            [ 2] 4386         clrb
   A527 BD F9 C5      [ 6] 4387         jsr     BUTNLIT 
   A52A                    4388 LA52A:
   A52A F6 10 0A      [ 4] 4389         ldab    PORTE
   A52D C8 FF         [ 2] 4390         eorb    #0xFF
   A52F BD F9 C5      [ 6] 4391         jsr     BUTNLIT 
   A532 C1 80         [ 2] 4392         cmpb    #0x80
   A534 26 F4         [ 3] 4393         bne     LA52A  
   A536 C6 02         [ 2] 4394         ldab    #0x02
   A538 BD 8C 30      [ 6] 4395         jsr     DLYSECSBY2      ; delay 1 sec
   A53B 39            [ 5] 4396         rts
                           4397 
                           4398 ; deck test
   A53C                    4399 LA53C:
   A53C C6 FD         [ 2] 4400         ldab    #0xFD           ; tape deck STOP
   A53E BD 86 E7      [ 6] 4401         jsr     L86E7
   A541 C6 06         [ 2] 4402         ldab    #0x06
   A543 BD 8C 30      [ 6] 4403         jsr     DLYSECSBY2      ; delay 3 sec
   A546 C6 FB         [ 2] 4404         ldab    #0xFB           ; tape deck PLAY
   A548 BD 86 E7      [ 6] 4405         jsr     L86E7
   A54B C6 06         [ 2] 4406         ldab    #0x06
   A54D BD 8C 30      [ 6] 4407         jsr     DLYSECSBY2      ; delay 3 sec
   A550 C6 FD         [ 2] 4408         ldab    #0xFD           ; tape deck STOP
   A552 BD 86 E7      [ 6] 4409         jsr     L86E7
   A555 C6 F7         [ 2] 4410         ldab    #0xF7
   A557 BD 86 E7      [ 6] 4411         jsr     L86E7           ; tape deck REWIND
   A55A C6 06         [ 2] 4412         ldab    #0x06
   A55C BD 8C 30      [ 6] 4413         jsr     DLYSECSBY2      ; delay 3 sec
   A55F C6 EF         [ 2] 4414         ldab    #0xEF           ; tape deck EJECT
   A561 BD 86 E7      [ 6] 4415         jsr     L86E7
   A564 39            [ 5] 4416         rts
                           4417 
                           4418 ; test driver boards
   A565                    4419 LA565:
   A565 BD F9 45      [ 6] 4420         jsr     SERIALR     
   A568 24 08         [ 3] 4421         bcc     LA572  
   A56A 81 1B         [ 2] 4422         cmpa    #0x1B
   A56C 26 04         [ 3] 4423         bne     LA572  
   A56E BD 86 C4      [ 6] 4424         jsr     L86C4           ; Reset boards 1-10
   A571 39            [ 5] 4425         rts
   A572                    4426 LA572:
   A572 86 08         [ 2] 4427         ldaa    #0x08
   A574 97 15         [ 3] 4428         staa    (0x0015)
   A576 BD 86 C4      [ 6] 4429         jsr     L86C4           ; Reset boards 1-10
   A579 86 01         [ 2] 4430         ldaa    #0x01
   A57B                    4431 LA57B:
   A57B 36            [ 3] 4432         psha
   A57C 16            [ 2] 4433         tab
   A57D BD F9 C5      [ 6] 4434         jsr     BUTNLIT 
   A580 B6 18 04      [ 4] 4435         ldaa    PIA0PRA 
   A583 88 08         [ 2] 4436         eora    #0x08
   A585 B7 18 04      [ 4] 4437         staa    PIA0PRA 
   A588 32            [ 4] 4438         pula
   A589 B7 10 80      [ 4] 4439         staa    (0x1080)
   A58C B7 10 84      [ 4] 4440         staa    (0x1084)
   A58F B7 10 88      [ 4] 4441         staa    (0x1088)
   A592 B7 10 8C      [ 4] 4442         staa    (0x108C)
   A595 B7 10 90      [ 4] 4443         staa    (0x1090)
   A598 B7 10 94      [ 4] 4444         staa    (0x1094)
   A59B B7 10 98      [ 4] 4445         staa    (0x1098)
   A59E B7 10 9C      [ 4] 4446         staa    (0x109C)
   A5A1 C6 14         [ 2] 4447         ldab    #0x14
   A5A3 BD A6 52      [ 6] 4448         jsr     LA652
   A5A6 49            [ 2] 4449         rola
   A5A7 36            [ 3] 4450         psha
   A5A8 D6 15         [ 3] 4451         ldab    (0x0015)
   A5AA 5A            [ 2] 4452         decb
   A5AB D7 15         [ 3] 4453         stab    (0x0015)
   A5AD BD F9 95      [ 6] 4454         jsr     DIAGDGT         ; write digit to the diag display
   A5B0 37            [ 3] 4455         pshb
   A5B1 C6 27         [ 2] 4456         ldab    #0x27
   A5B3 96 15         [ 3] 4457         ldaa    (0x0015)
   A5B5 0C            [ 2] 4458         clc
   A5B6 89 30         [ 2] 4459         adca    #0x30
   A5B8 BD 8D B5      [ 6] 4460         jsr     L8DB5           ; display char here on LCD display
   A5BB 33            [ 4] 4461         pulb
   A5BC 32            [ 4] 4462         pula
   A5BD 5D            [ 2] 4463         tstb
   A5BE 26 BB         [ 3] 4464         bne     LA57B  
   A5C0 86 08         [ 2] 4465         ldaa    #0x08
   A5C2 97 15         [ 3] 4466         staa    (0x0015)
   A5C4 BD 86 C4      [ 6] 4467         jsr     L86C4           ; Reset boards 1-10
   A5C7 86 01         [ 2] 4468         ldaa    #0x01
   A5C9                    4469 LA5C9:
   A5C9 B7 10 82      [ 4] 4470         staa    (0x1082)
   A5CC B7 10 86      [ 4] 4471         staa    (0x1086)
   A5CF B7 10 8A      [ 4] 4472         staa    (0x108A)
   A5D2 B7 10 8E      [ 4] 4473         staa    (0x108E)
   A5D5 B7 10 92      [ 4] 4474         staa    (0x1092)
   A5D8 B7 10 96      [ 4] 4475         staa    (0x1096)
   A5DB B7 10 9A      [ 4] 4476         staa    (0x109A)
   A5DE B7 10 9E      [ 4] 4477         staa    (0x109E)
   A5E1 C6 14         [ 2] 4478         ldab    #0x14
   A5E3 BD A6 52      [ 6] 4479         jsr     LA652
   A5E6 49            [ 2] 4480         rola
   A5E7 36            [ 3] 4481         psha
   A5E8 D6 15         [ 3] 4482         ldab    (0x0015)
   A5EA 5A            [ 2] 4483         decb
   A5EB D7 15         [ 3] 4484         stab    (0x0015)
   A5ED BD F9 95      [ 6] 4485         jsr     DIAGDGT         ; write digit to the diag display
   A5F0 37            [ 3] 4486         pshb
   A5F1 C6 27         [ 2] 4487         ldab    #0x27
   A5F3 96 15         [ 3] 4488         ldaa    (0x0015)
   A5F5 0C            [ 2] 4489         clc
   A5F6 89 30         [ 2] 4490         adca    #0x30
   A5F8 BD 8D B5      [ 6] 4491         jsr     L8DB5           ; display char here on LCD display
   A5FB 33            [ 4] 4492         pulb
   A5FC 32            [ 4] 4493         pula
   A5FD 7D 00 15      [ 6] 4494         tst     (0x0015)
   A600 26 C7         [ 3] 4495         bne     LA5C9  
   A602 BD 86 C4      [ 6] 4496         jsr     L86C4           ; Reset boards 1-10
   A605 CE 10 80      [ 3] 4497         ldx     #0x1080
   A608 C6 00         [ 2] 4498         ldab    #0x00
   A60A                    4499 LA60A:
   A60A 86 FF         [ 2] 4500         ldaa    #0xFF
   A60C A7 00         [ 4] 4501         staa    0,X
   A60E A7 02         [ 4] 4502         staa    2,X     
   A610 37            [ 3] 4503         pshb
   A611 C6 1E         [ 2] 4504         ldab    #0x1E
   A613 BD A6 52      [ 6] 4505         jsr     LA652
   A616 33            [ 4] 4506         pulb
   A617 86 00         [ 2] 4507         ldaa    #0x00
   A619 A7 00         [ 4] 4508         staa    0,X     
   A61B A7 02         [ 4] 4509         staa    2,X     
   A61D 5C            [ 2] 4510         incb
   A61E 3C            [ 4] 4511         pshx
   A61F BD F9 95      [ 6] 4512         jsr     DIAGDGT         ; write digit to the diag display
   A622 37            [ 3] 4513         pshb
   A623 C6 27         [ 2] 4514         ldab    #0x27
   A625 32            [ 4] 4515         pula
   A626 36            [ 3] 4516         psha
   A627 0C            [ 2] 4517         clc
   A628 89 30         [ 2] 4518         adca    #0x30
   A62A BD 8D B5      [ 6] 4519         jsr     L8DB5           ; display char here on LCD display
   A62D 33            [ 4] 4520         pulb
   A62E 38            [ 5] 4521         pulx
   A62F 08            [ 3] 4522         inx
   A630 08            [ 3] 4523         inx
   A631 08            [ 3] 4524         inx
   A632 08            [ 3] 4525         inx
   A633 8C 10 9D      [ 4] 4526         cpx     #0x109D
   A636 25 D2         [ 3] 4527         bcs     LA60A  
   A638 CE 10 80      [ 3] 4528         ldx     #0x1080
   A63B                    4529 LA63B:
   A63B 86 FF         [ 2] 4530         ldaa    #0xFF
   A63D A7 00         [ 4] 4531         staa    0,X     
   A63F A7 02         [ 4] 4532         staa    2,X     
   A641 08            [ 3] 4533         inx
   A642 08            [ 3] 4534         inx
   A643 08            [ 3] 4535         inx
   A644 08            [ 3] 4536         inx
   A645 8C 10 9D      [ 4] 4537         cpx     #0x109D
   A648 25 F1         [ 3] 4538         bcs     LA63B  
   A64A C6 06         [ 2] 4539         ldab    #0x06
   A64C BD 8C 30      [ 6] 4540         jsr     DLYSECSBY2      ; delay 3 sec
   A64F 7E A5 65      [ 3] 4541         jmp     LA565
   A652                    4542 LA652:
   A652 36            [ 3] 4543         psha
   A653 4F            [ 2] 4544         clra
   A654 DD 23         [ 4] 4545         std     CDTIMR5
   A656                    4546 LA656:
   A656 7D 00 24      [ 6] 4547         tst     CDTIMR5+1
   A659 26 FB         [ 3] 4548         bne     LA656  
   A65B 32            [ 4] 4549         pula
   A65C 39            [ 5] 4550         rts
                           4551 
                           4552 ; Comma-seperated text
   A65D                    4553 LA65D:
   A65D 30 2C 43 68 75 63  4554         .ascii  '0,Chuck,Mouth,'
        6B 2C 4D 6F 75 74
        68 2C
   A66B 31 2C 48 65 61 64  4555         .ascii  '1,Head left,'
        20 6C 65 66 74 2C
   A677 32 2C 48 65 61 64  4556         .ascii  '2,Head right,'
        20 72 69 67 68 74
        2C
   A684 32 2C 48 65 61 64  4557         .ascii  '2,Head up,'
        20 75 70 2C
   A68E 32 2C 45 79 65 73  4558         .ascii  '2,Eyes right,'
        20 72 69 67 68 74
        2C
   A69B 31 2C 45 79 65 6C  4559         .ascii  '1,Eyelids,'
        69 64 73 2C
   A6A5 31 2C 52 69 67 68  4560         .ascii  '1,Right hand,'
        74 20 68 61 6E 64
        2C
   A6B2 32 2C 45 79 65 73  4561         .ascii  '2,Eyes left,'
        20 6C 65 66 74 2C
   A6BE 31 2C 38 2C 48 65  4562         .ascii  '1,8,Helen,Mouth,'
        6C 65 6E 2C 4D 6F
        75 74 68 2C
   A6CE 31 2C 48 65 61 64  4563         .ascii  '1,Head left,'
        20 6C 65 66 74 2C
   A6DA 32 2C 48 65 61 64  4564         .ascii  '2,Head right,'
        20 72 69 67 68 74
        2C
   A6E7 32 2C 48 65 61 64  4565         .ascii  '2,Head up,'
        20 75 70 2C
   A6F1 32 2C 45 79 65 73  4566         .ascii  '2,Eyes right,'
        20 72 69 67 68 74
        2C
   A6FE 31 2C 45 79 65 6C  4567         .ascii  '1,Eyelids,'
        69 64 73 2C
   A708 31 2C 52 69 67 68  4568         .ascii  '1,Right hand,'
        74 20 68 61 6E 64
        2C
   A715 32 2C 45 79 65 73  4569         .ascii  '2,Eyes left,'
        20 6C 65 66 74 2C
   A721 31 2C 36 2C 4D 75  4570         .ascii  '1,6,Munch,Mouth,'
        6E 63 68 2C 4D 6F
        75 74 68 2C
   A731 31 2C 48 65 61 64  4571         .ascii  '1,Head left,'
        20 6C 65 66 74 2C
   A73D 32 2C 48 65 61 64  4572         .ascii  '2,Head right,'
        20 72 69 67 68 74
        2C
   A74A 32 2C 4C 65 66 74  4573         .ascii  '2,Left arm,'
        20 61 72 6D 2C
   A755 32 2C 45 79 65 73  4574         .ascii  '2,Eyes right,'
        20 72 69 67 68 74
        2C
   A762 31 2C 45 79 65 6C  4575         .ascii  '1,Eyelids,'
        69 64 73 2C
   A76C 31 2C 52 69 67 68  4576         .ascii  '1,Right arm,'
        74 20 61 72 6D 2C
   A778 32 2C 45 79 65 73  4577         .ascii  '2,Eyes left,'
        20 6C 65 66 74 2C
   A784 31 2C 32 2C 4A 61  4578         .ascii  '1,2,Jasper,Mouth,'
        73 70 65 72 2C 4D
        6F 75 74 68 2C
   A795 31 2C 48 65 61 64  4579         .ascii  '1,Head left,'
        20 6C 65 66 74 2C
   A7A1 32 2C 48 65 61 64  4580         .ascii  '2,Head right,'
        20 72 69 67 68 74
        2C
   A7AE 32 2C 48 65 61 64  4581         .ascii  '2,Head up,'
        20 75 70 2C
   A7B8 32 2C 45 79 65 73  4582         .ascii  '2,Eyes right,'
        20 72 69 67 68 74
        2C
   A7C5 31 2C 45 79 65 6C  4583         .ascii  '1,Eyelids,'
        69 64 73 2C
   A7CF 31 2C 48 61 6E 64  4584         .ascii  '1,Hands,'
        73 2C
   A7D7 32 2C 45 79 65 73  4585         .ascii  '2,Eyes left,'
        20 6C 65 66 74 2C
   A7E3 31 2C 34 2C 50 61  4586         .ascii  '1,4,Pasqually,Mouth-Mustache,'
        73 71 75 61 6C 6C
        79 2C 4D 6F 75 74
        68 2D 4D 75 73 74
        61 63 68 65 2C
   A800 31 2C 48 65 61 64  4587         .ascii  '1,Head left,'
        20 6C 65 66 74 2C
   A80C 32 2C 48 65 61 64  4588         .ascii  '2,Head right,'
        20 72 69 67 68 74
        2C
   A819 32 2C 4C 65 66 74  4589         .ascii  '2,Left arm,'
        20 61 72 6D 2C
   A824 32 2C 45 79 65 73  4590         .ascii  '2,Eyes right,'
        20 72 69 67 68 74
        2C
   A831 31 2C 45 79 65 6C  4591         .ascii  '1,Eyelids,'
        69 64 73 2C
   A83B 31 2C 52 69 67 68  4592         .ascii  '1,Right arm,'
        74 20 61 72 6D 2C
   A847 32 2C 45 79 65 73  4593         .ascii  '2,Eyes left,1,'
        20 6C 65 66 74 2C
        31 2C
                           4594 
   A855                    4595 LA855:
   A855 3C            [ 4] 4596         pshx
   A856 BD 86 C4      [ 6] 4597         jsr     L86C4           ; Reset boards 1-10
   A859 CE 10 80      [ 3] 4598         ldx     #0x1080
   A85C 86 20         [ 2] 4599         ldaa    #0x20
   A85E A7 00         [ 4] 4600         staa    0,X
   A860 A7 04         [ 4] 4601         staa    4,X
   A862 A7 08         [ 4] 4602         staa    8,X
   A864 A7 0C         [ 4] 4603         staa    12,X
   A866 A7 10         [ 4] 4604         staa    16,X
   A868 38            [ 5] 4605         pulx
   A869 39            [ 5] 4606         rts
                           4607 
   A86A                    4608 LA86A:
   A86A BD A3 2E      [ 6] 4609         jsr     LA32E
                           4610 
   A86D BD 8D E4      [ 6] 4611         jsr     LCDMSG1 
   A870 20 20 20 20 57 61  4612         .ascis  '    Warm-Up  '
        72 6D 2D 55 70 20
        A0
                           4613 
   A87D BD 8D DD      [ 6] 4614         jsr     LCDMSG2 
   A880 43 75 72 74 61 69  4615         .ascis  'Curtains opening'
        6E 73 20 6F 70 65
        6E 69 6E E7
                           4616 
   A890 C6 14         [ 2] 4617         ldab    #0x14
   A892 BD 8C 30      [ 6] 4618         jsr     DLYSECSBY2      ; delay 10 sec
   A895                    4619 LA895:
   A895 BD A8 55      [ 6] 4620         jsr     LA855
   A898 C6 02         [ 2] 4621         ldab    #0x02
   A89A BD 8C 30      [ 6] 4622         jsr     DLYSECSBY2      ; delay 1 sec
   A89D CE A6 5D      [ 3] 4623         ldx     #LA65D
   A8A0 C6 05         [ 2] 4624         ldab    #0x05
   A8A2 D7 12         [ 3] 4625         stab    (0x0012)
   A8A4                    4626 LA8A4:
   A8A4 C6 08         [ 2] 4627         ldab    #0x08
   A8A6 D7 13         [ 3] 4628         stab    (0x0013)
   A8A8 BD A9 41      [ 6] 4629         jsr     LA941
   A8AB BD A9 4C      [ 6] 4630         jsr     LA94C
   A8AE C6 02         [ 2] 4631         ldab    #0x02
   A8B0 BD 8C 30      [ 6] 4632         jsr     DLYSECSBY2      ; delay 1 sec
   A8B3                    4633 LA8B3:
   A8B3 BD A9 5E      [ 6] 4634         jsr     LA95E
   A8B6 A6 00         [ 4] 4635         ldaa    0,X     
   A8B8 80 30         [ 2] 4636         suba    #0x30
   A8BA 08            [ 3] 4637         inx
   A8BB 08            [ 3] 4638         inx
   A8BC 36            [ 3] 4639         psha
   A8BD 7C 00 4C      [ 6] 4640         inc     (0x004C)
   A8C0 3C            [ 4] 4641         pshx
   A8C1 BD 88 E5      [ 6] 4642         jsr     L88E5
   A8C4 38            [ 5] 4643         pulx
   A8C5 86 4F         [ 2] 4644         ldaa    #0x4F           ;'O'
   A8C7 C6 0C         [ 2] 4645         ldab    #0x0C
   A8C9 BD 8D B5      [ 6] 4646         jsr     L8DB5           ; display char here on LCD display
   A8CC 86 6E         [ 2] 4647         ldaa    #0x6E           ;'n'
   A8CE C6 0D         [ 2] 4648         ldab    #0x0D
   A8D0 BD 8D B5      [ 6] 4649         jsr     L8DB5           ; display char here on LCD display
   A8D3 CC 20 0E      [ 3] 4650         ldd     #0x200E         ;' '
   A8D6 BD 8D B5      [ 6] 4651         jsr     L8DB5           ; display char here on LCD display
   A8D9 7A 00 4C      [ 6] 4652         dec     (0x004C)
   A8DC 32            [ 4] 4653         pula
   A8DD 36            [ 3] 4654         psha
   A8DE C6 64         [ 2] 4655         ldab    #0x64
   A8E0 3D            [10] 4656         mul
   A8E1 DD 23         [ 4] 4657         std     CDTIMR5
   A8E3                    4658 LA8E3:
   A8E3 DC 23         [ 4] 4659         ldd     CDTIMR5
   A8E5 26 FC         [ 3] 4660         bne     LA8E3  
   A8E7 BD 8E 95      [ 6] 4661         jsr     L8E95
   A8EA 81 0D         [ 2] 4662         cmpa    #0x0D
   A8EC 26 05         [ 3] 4663         bne     LA8F3  
   A8EE BD A9 75      [ 6] 4664         jsr     LA975
   A8F1 20 10         [ 3] 4665         bra     LA903  
   A8F3                    4666 LA8F3:
   A8F3 81 01         [ 2] 4667         cmpa    #0x01
   A8F5 26 04         [ 3] 4668         bne     LA8FB  
   A8F7 32            [ 4] 4669         pula
   A8F8 7E A8 95      [ 3] 4670         jmp     LA895
   A8FB                    4671 LA8FB:
   A8FB 81 02         [ 2] 4672         cmpa    #0x02
   A8FD 26 04         [ 3] 4673         bne     LA903  
   A8FF 32            [ 4] 4674         pula
   A900 7E A9 35      [ 3] 4675         jmp     LA935
   A903                    4676 LA903:
   A903 3C            [ 4] 4677         pshx
   A904 BD 88 E5      [ 6] 4678         jsr     L88E5
   A907 38            [ 5] 4679         pulx
   A908 86 66         [ 2] 4680         ldaa    #0x66           ;'f'
   A90A C6 0D         [ 2] 4681         ldab    #0x0D
   A90C BD 8D B5      [ 6] 4682         jsr     L8DB5           ; display char here on LCD display
   A90F 86 66         [ 2] 4683         ldaa    #0x66           ;'f'
   A911 C6 0E         [ 2] 4684         ldab    #0x0E
   A913 BD 8D B5      [ 6] 4685         jsr     L8DB5           ; display char here on LCD display
   A916 32            [ 4] 4686         pula
   A917 C6 64         [ 2] 4687         ldab    #0x64
   A919 3D            [10] 4688         mul
   A91A DD 23         [ 4] 4689         std     CDTIMR5
   A91C                    4690 LA91C:
   A91C DC 23         [ 4] 4691         ldd     CDTIMR5
   A91E 26 FC         [ 3] 4692         bne     LA91C  
   A920 BD A8 55      [ 6] 4693         jsr     LA855
   A923 7C 00 4B      [ 6] 4694         inc     (0x004B)
   A926 96 4B         [ 3] 4695         ldaa    (0x004B)
   A928 81 48         [ 2] 4696         cmpa    #0x48
   A92A 25 87         [ 3] 4697         bcs     LA8B3  
   A92C 96 4C         [ 3] 4698         ldaa    (0x004C)
   A92E 81 34         [ 2] 4699         cmpa    #0x34
   A930 27 03         [ 3] 4700         beq     LA935  
   A932 7E A8 A4      [ 3] 4701         jmp     LA8A4
   A935                    4702 LA935:
   A935 C6 02         [ 2] 4703         ldab    #0x02
   A937 BD 8C 30      [ 6] 4704         jsr     DLYSECSBY2      ; delay 1 sec
   A93A BD 86 C4      [ 6] 4705         jsr     L86C4           ; Reset boards 1-10
   A93D BD A3 41      [ 6] 4706         jsr     LA341
   A940 39            [ 5] 4707         rts
                           4708 
   A941                    4709 LA941:
   A941 A6 00         [ 4] 4710         ldaa    0,X     
   A943 08            [ 3] 4711         inx
   A944 08            [ 3] 4712         inx
   A945 97 4C         [ 3] 4713         staa    (0x004C)
   A947 86 40         [ 2] 4714         ldaa    #0x40
   A949 97 4B         [ 3] 4715         staa    (0x004B)
   A94B 39            [ 5] 4716         rts
                           4717 
   A94C                    4718 LA94C:
   A94C BD 8C F2      [ 6] 4719         jsr     L8CF2
   A94F                    4720 LA94F:
   A94F A6 00         [ 4] 4721         ldaa    0,X     
   A951 08            [ 3] 4722         inx
   A952 81 2C         [ 2] 4723         cmpa    #0x2C
   A954 27 07         [ 3] 4724         beq     LA95D  
   A956 36            [ 3] 4725         psha
   A957 BD 8E 70      [ 6] 4726         jsr     L8E70
   A95A 32            [ 4] 4727         pula
   A95B 20 F2         [ 3] 4728         bra     LA94F  
   A95D                    4729 LA95D:
   A95D 39            [ 5] 4730         rts
                           4731 
   A95E                    4732 LA95E:
   A95E BD 8D 03      [ 6] 4733         jsr     L8D03
   A961 86 C0         [ 2] 4734         ldaa    #0xC0
   A963 BD 8E 4B      [ 6] 4735         jsr     L8E4B
   A966                    4736 LA966:
   A966 A6 00         [ 4] 4737         ldaa    0,X     
   A968 08            [ 3] 4738         inx
   A969 81 2C         [ 2] 4739         cmpa    #0x2C
   A96B 27 07         [ 3] 4740         beq     LA974  
   A96D 36            [ 3] 4741         psha
   A96E BD 8E 70      [ 6] 4742         jsr     L8E70
   A971 32            [ 4] 4743         pula
   A972 20 F2         [ 3] 4744         bra     LA966  
   A974                    4745 LA974:
   A974 39            [ 5] 4746         rts
                           4747 
   A975                    4748 LA975:
   A975 BD 8E 95      [ 6] 4749         jsr     L8E95
   A978 4D            [ 2] 4750         tsta
   A979 27 FA         [ 3] 4751         beq     LA975  
   A97B 39            [ 5] 4752         rts
                           4753 
   A97C                    4754 LA97C:
   A97C 7F 00 60      [ 6] 4755         clr     (0x0060)
   A97F FC 02 9C      [ 5] 4756         ldd     (0x029C)
   A982 1A 83 00 01   [ 5] 4757         cpd     #0x0001
   A986 27 0C         [ 3] 4758         beq     LA994  
   A988 1A 83 03 E8   [ 5] 4759         cpd     #0x03E8
   A98C 2D 7D         [ 3] 4760         blt     LAA0B  
   A98E 1A 83 04 4B   [ 5] 4761         cpd     #0x044B
   A992 22 77         [ 3] 4762         bhi     LAA0B  
   A994                    4763 LA994:
   A994 C6 40         [ 2] 4764         ldab    #0x40
   A996 D7 62         [ 3] 4765         stab    (0x0062)
   A998 BD F9 C5      [ 6] 4766         jsr     BUTNLIT 
   A99B C6 64         [ 2] 4767         ldab    #0x64           ; delay 1 sec
   A99D BD 8C 22      [ 6] 4768         jsr     DLYSECSBY100
   A9A0 BD 86 C4      [ 6] 4769         jsr     L86C4           ; Reset boards 1-10
   A9A3 BD 8C E9      [ 6] 4770         jsr     L8CE9
                           4771 
   A9A6 BD 8D E4      [ 6] 4772         jsr     LCDMSG1 
   A9A9 20 20 20 20 20 53  4773         .ascis  '     STUDIO'
        54 55 44 49 CF
                           4774 
   A9B4 BD 8D DD      [ 6] 4775         jsr     LCDMSG2 
   A9B7 70 72 6F 67 72 61  4776         .ascis  'programming mode'
        6D 6D 69 6E 67 20
        6D 6F 64 E5
                           4777 
   A9C7 BD A3 2E      [ 6] 4778         jsr     LA32E
   A9CA BD 99 9E      [ 6] 4779         jsr     L999E
   A9CD BD 99 B1      [ 6] 4780         jsr     L99B1
   A9D0 CE 20 00      [ 3] 4781         ldx     #0x2000
   A9D3                    4782 LA9D3:
   A9D3 18 CE 00 C0   [ 4] 4783         ldy     #0x00C0
   A9D7                    4784 LA9D7:
   A9D7 18 09         [ 4] 4785         dey
   A9D9 26 0A         [ 3] 4786         bne     LA9E5  
   A9DB BD A9 F4      [ 6] 4787         jsr     LA9F4
   A9DE 96 60         [ 3] 4788         ldaa    (0x0060)
   A9E0 26 29         [ 3] 4789         bne     LAA0B  
   A9E2 CE 20 00      [ 3] 4790         ldx     #0x2000
   A9E5                    4791 LA9E5:
   A9E5 B6 10 A8      [ 4] 4792         ldaa    (0x10A8)
   A9E8 84 01         [ 2] 4793         anda    #0x01
   A9EA 27 EB         [ 3] 4794         beq     LA9D7  
   A9EC B6 10 A9      [ 4] 4795         ldaa    (0x10A9)
   A9EF A7 00         [ 4] 4796         staa    0,X     
   A9F1 08            [ 3] 4797         inx
   A9F2 20 DF         [ 3] 4798         bra     LA9D3
                           4799 
   A9F4                    4800 LA9F4:
   A9F4 CE 20 00      [ 3] 4801         ldx     #0x2000
   A9F7 18 CE 10 80   [ 4] 4802         ldy     #0x1080
   A9FB                    4803 LA9FB:
   A9FB A6 00         [ 4] 4804         ldaa    0,X     
   A9FD 18 A7 00      [ 5] 4805         staa    0,Y     
   AA00 08            [ 3] 4806         inx
   AA01 18 08         [ 4] 4807         iny
   AA03 18 08         [ 4] 4808         iny
   AA05 8C 20 10      [ 4] 4809         cpx     #0x2010
   AA08 25 F1         [ 3] 4810         bcs     LA9FB  
   AA0A 39            [ 5] 4811         rts
   AA0B                    4812 LAA0B:
   AA0B 39            [ 5] 4813         rts
                           4814 
   AA0C                    4815 LAA0C:
   AA0C CC 48 37      [ 3] 4816         ldd     #0x4837         ;'H'
   AA0F                    4817 LAA0F:
   AA0F BD 8D B5      [ 6] 4818         jsr     L8DB5           ; display char here on LCD display
   AA12 39            [ 5] 4819         rts
                           4820 
   AA13                    4821 LAA13:
   AA13 CC 20 37      [ 3] 4822         ldd     #0x2037         ;' '
   AA16 20 F7         [ 3] 4823         bra     LAA0F
                           4824 
   AA18                    4825 LAA18:
   AA18 CC 42 0F      [ 3] 4826         ldd     #0x420F         ;'B'
   AA1B 20 F2         [ 3] 4827         bra     LAA0F
                           4828 
   AA1D                    4829 LAA1D:
   AA1D CC 20 0F      [ 3] 4830         ldd     #0x200F         ;' '
   AA20 20 ED         [ 3] 4831         bra     LAA0F
                           4832 
   AA22                    4833 LAA22: 
   AA22 7F 00 4F      [ 6] 4834         clr     (0x004F)
   AA25 CC 00 01      [ 3] 4835         ldd     #0x0001
   AA28 DD 1B         [ 4] 4836         std     CDTIMR1
   AA2A CE 20 00      [ 3] 4837         ldx     #0x2000
   AA2D                    4838 LAA2D:
   AA2D B6 10 A8      [ 4] 4839         ldaa    (0x10A8)
   AA30 84 01         [ 2] 4840         anda    #0x01
   AA32 27 F9         [ 3] 4841         beq     LAA2D  
   AA34 DC 1B         [ 4] 4842         ldd     CDTIMR1
   AA36 0F            [ 2] 4843         sei
   AA37 26 03         [ 3] 4844         bne     LAA3C  
   AA39 CE 20 00      [ 3] 4845         ldx     #0x2000
   AA3C                    4846 LAA3C:
   AA3C B6 10 A9      [ 4] 4847         ldaa    (0x10A9)
   AA3F A7 00         [ 4] 4848         staa    0,X     
   AA41 0E            [ 2] 4849         cli
   AA42 BD F9 6F      [ 6] 4850         jsr     SERIALW      
   AA45 08            [ 3] 4851         inx
   AA46 7F 00 4F      [ 6] 4852         clr     (0x004F)
   AA49 CC 00 01      [ 3] 4853         ldd     #0x0001
   AA4C DD 1B         [ 4] 4854         std     CDTIMR1
   AA4E 8C 20 23      [ 4] 4855         cpx     #0x2023
   AA51 26 DA         [ 3] 4856         bne     LAA2D  
   AA53 CE 20 00      [ 3] 4857         ldx     #0x2000
   AA56 7F 00 B7      [ 6] 4858         clr     (0x00B7)
   AA59                    4859 LAA59:
   AA59 A6 00         [ 4] 4860         ldaa    0,X     
   AA5B 9B B7         [ 3] 4861         adda    (0x00B7)
   AA5D 97 B7         [ 3] 4862         staa    (0x00B7)
   AA5F 08            [ 3] 4863         inx
   AA60 8C 20 22      [ 4] 4864         cpx     #0x2022
   AA63 25 F4         [ 3] 4865         bcs     LAA59  
   AA65 96 B7         [ 3] 4866         ldaa    (0x00B7)
   AA67 88 FF         [ 2] 4867         eora    #0xFF
   AA69 A1 00         [ 4] 4868         cmpa    0,X     
   AA6B CE 20 00      [ 3] 4869         ldx     #0x2000
   AA6E A6 20         [ 4] 4870         ldaa    0x20,X
   AA70 2B 03         [ 3] 4871         bmi     LAA75  
   AA72 7E AA 22      [ 3] 4872         jmp     LAA22
   AA75                    4873 LAA75:
   AA75 A6 00         [ 4] 4874         ldaa    0,X     
   AA77 B7 10 80      [ 4] 4875         staa    (0x1080)
   AA7A 08            [ 3] 4876         inx
   AA7B A6 00         [ 4] 4877         ldaa    0,X     
   AA7D B7 10 82      [ 4] 4878         staa    (0x1082)
   AA80 08            [ 3] 4879         inx
   AA81 A6 00         [ 4] 4880         ldaa    0,X     
   AA83 B7 10 84      [ 4] 4881         staa    (0x1084)
   AA86 08            [ 3] 4882         inx
   AA87 A6 00         [ 4] 4883         ldaa    0,X     
   AA89 B7 10 86      [ 4] 4884         staa    (0x1086)
   AA8C 08            [ 3] 4885         inx
   AA8D A6 00         [ 4] 4886         ldaa    0,X     
   AA8F B7 10 88      [ 4] 4887         staa    (0x1088)
   AA92 08            [ 3] 4888         inx
   AA93 A6 00         [ 4] 4889         ldaa    0,X     
   AA95 B7 10 8A      [ 4] 4890         staa    (0x108A)
   AA98 08            [ 3] 4891         inx
   AA99 A6 00         [ 4] 4892         ldaa    0,X     
   AA9B B7 10 8C      [ 4] 4893         staa    (0x108C)
   AA9E 08            [ 3] 4894         inx
   AA9F A6 00         [ 4] 4895         ldaa    0,X     
   AAA1 B7 10 8E      [ 4] 4896         staa    (0x108E)
   AAA4 08            [ 3] 4897         inx
   AAA5 A6 00         [ 4] 4898         ldaa    0,X     
   AAA7 B7 10 90      [ 4] 4899         staa    (0x1090)
   AAAA 08            [ 3] 4900         inx
   AAAB A6 00         [ 4] 4901         ldaa    0,X     
   AAAD B7 10 92      [ 4] 4902         staa    (0x1092)
   AAB0 08            [ 3] 4903         inx
   AAB1 A6 00         [ 4] 4904         ldaa    0,X     
   AAB3 8A 80         [ 2] 4905         oraa    #0x80
   AAB5 B7 10 94      [ 4] 4906         staa    (0x1094)
   AAB8 08            [ 3] 4907         inx
   AAB9 A6 00         [ 4] 4908         ldaa    0,X     
   AABB 8A 01         [ 2] 4909         oraa    #0x01
   AABD B7 10 96      [ 4] 4910         staa    (0x1096)
   AAC0 08            [ 3] 4911         inx
   AAC1 A6 00         [ 4] 4912         ldaa    0,X     
   AAC3 B7 10 98      [ 4] 4913         staa    (0x1098)
   AAC6 08            [ 3] 4914         inx
   AAC7 A6 00         [ 4] 4915         ldaa    0,X     
   AAC9 B7 10 9A      [ 4] 4916         staa    (0x109A)
   AACC 08            [ 3] 4917         inx
   AACD A6 00         [ 4] 4918         ldaa    0,X     
   AACF B7 10 9C      [ 4] 4919         staa    (0x109C)
   AAD2 08            [ 3] 4920         inx
   AAD3 A6 00         [ 4] 4921         ldaa    0,X     
   AAD5 B7 10 9E      [ 4] 4922         staa    (0x109E)
   AAD8 7E AA 22      [ 3] 4923         jmp     LAA22
                           4924 
   AADB                    4925 LAADB:
   AADB 7F 10 98      [ 6] 4926         clr     (0x1098)
   AADE 7F 10 9A      [ 6] 4927         clr     (0x109A)
   AAE1 7F 10 9C      [ 6] 4928         clr     (0x109C)
   AAE4 7F 10 9E      [ 6] 4929         clr     (0x109E)
   AAE7 39            [ 5] 4930         rts
   AAE8                    4931 LAAE8:
   AAE8 CE 04 2C      [ 3] 4932         ldx     #0x042C
   AAEB C6 10         [ 2] 4933         ldab    #0x10
   AAED                    4934 LAAED:
   AAED 5D            [ 2] 4935         tstb
   AAEE 27 12         [ 3] 4936         beq     LAB02  
   AAF0 A6 00         [ 4] 4937         ldaa    0,X     
   AAF2 81 30         [ 2] 4938         cmpa    #0x30
   AAF4 25 0D         [ 3] 4939         bcs     LAB03  
   AAF6 81 39         [ 2] 4940         cmpa    #0x39
   AAF8 22 09         [ 3] 4941         bhi     LAB03  
   AAFA 08            [ 3] 4942         inx
   AAFB 08            [ 3] 4943         inx
   AAFC 08            [ 3] 4944         inx
   AAFD 8C 04 59      [ 4] 4945         cpx     #0x0459
   AB00 23 EB         [ 3] 4946         bls     LAAED  
   AB02                    4947 LAB02:
   AB02 39            [ 5] 4948         rts
                           4949 
   AB03                    4950 LAB03:
   AB03 5A            [ 2] 4951         decb
   AB04 3C            [ 4] 4952         pshx
   AB05                    4953 LAB05:
   AB05 A6 03         [ 4] 4954         ldaa    3,X     
   AB07 A7 00         [ 4] 4955         staa    0,X     
   AB09 08            [ 3] 4956         inx
   AB0A 8C 04 5C      [ 4] 4957         cpx     #0x045C
   AB0D 25 F6         [ 3] 4958         bcs     LAB05  
   AB0F 86 FF         [ 2] 4959         ldaa    #0xFF
   AB11 B7 04 59      [ 4] 4960         staa    (0x0459)
   AB14 38            [ 5] 4961         pulx
   AB15 20 D6         [ 3] 4962         bra     LAAED
                           4963 
                           4964 ; erase revalid tape section in EEPROM
   AB17                    4965 LAB17:
   AB17 CE 04 2C      [ 3] 4966         ldx     #0x042C
   AB1A 86 FF         [ 2] 4967         ldaa    #0xFF
   AB1C                    4968 LAB1C:
   AB1C A7 00         [ 4] 4969         staa    0,X     
   AB1E 08            [ 3] 4970         inx
   AB1F 8C 04 5C      [ 4] 4971         cpx     #0x045C
   AB22 25 F8         [ 3] 4972         bcs     LAB1C
   AB24 39            [ 5] 4973         rts
                           4974 
   AB25                    4975 LAB25:
   AB25 CE 04 2C      [ 3] 4976         ldx     #0x042C
   AB28                    4977 LAB28:
   AB28 A6 00         [ 4] 4978         ldaa    0,X     
   AB2A 81 30         [ 2] 4979         cmpa    #0x30
   AB2C 25 17         [ 3] 4980         bcs     LAB45  
   AB2E 81 39         [ 2] 4981         cmpa    #0x39
   AB30 22 13         [ 3] 4982         bhi     LAB45  
   AB32 08            [ 3] 4983         inx
   AB33 08            [ 3] 4984         inx
   AB34 08            [ 3] 4985         inx
   AB35 8C 04 5C      [ 4] 4986         cpx     #0x045C
   AB38 25 EE         [ 3] 4987         bcs     LAB28  
   AB3A 86 FF         [ 2] 4988         ldaa    #0xFF
   AB3C B7 04 2C      [ 4] 4989         staa    (0x042C)
   AB3F BD AA E8      [ 6] 4990         jsr     LAAE8
   AB42 CE 04 59      [ 3] 4991         ldx     #0x0459
   AB45                    4992 LAB45:
   AB45 39            [ 5] 4993         rts
                           4994 
   AB46                    4995 LAB46:
   AB46 B6 02 99      [ 4] 4996         ldaa    (0x0299)
   AB49 A7 00         [ 4] 4997         staa    0,X     
   AB4B B6 02 9A      [ 4] 4998         ldaa    (0x029A)
   AB4E A7 01         [ 4] 4999         staa    1,X     
   AB50 B6 02 9B      [ 4] 5000         ldaa    (0x029B)
   AB53 A7 02         [ 4] 5001         staa    2,X     
   AB55 39            [ 5] 5002         rts
                           5003 
   AB56                    5004 LAB56:
   AB56 CE 04 2C      [ 3] 5005         ldx     #0x042C
   AB59                    5006 LAB59:
   AB59 B6 02 99      [ 4] 5007         ldaa    (0x0299)
   AB5C A1 00         [ 4] 5008         cmpa    0,X     
   AB5E 26 10         [ 3] 5009         bne     LAB70  
   AB60 B6 02 9A      [ 4] 5010         ldaa    (0x029A)
   AB63 A1 01         [ 4] 5011         cmpa    1,X     
   AB65 26 09         [ 3] 5012         bne     LAB70  
   AB67 B6 02 9B      [ 4] 5013         ldaa    (0x029B)
   AB6A A1 02         [ 4] 5014         cmpa    2,X     
   AB6C 26 02         [ 3] 5015         bne     LAB70  
   AB6E 20 0A         [ 3] 5016         bra     LAB7A  
   AB70                    5017 LAB70:
   AB70 08            [ 3] 5018         inx
   AB71 08            [ 3] 5019         inx
   AB72 08            [ 3] 5020         inx
   AB73 8C 04 5C      [ 4] 5021         cpx     #0x045C
   AB76 25 E1         [ 3] 5022         bcs     LAB59  
   AB78 0D            [ 2] 5023         sec
   AB79 39            [ 5] 5024         rts
                           5025 
   AB7A                    5026 LAB7A:
   AB7A 0C            [ 2] 5027         clc
   AB7B 39            [ 5] 5028         rts
                           5029 
                           5030 ;show re-valid tapes
   AB7C                    5031 LAB7C:
   AB7C CE 04 2C      [ 3] 5032         ldx     #0x042C
   AB7F                    5033 LAB7F:
   AB7F A6 00         [ 4] 5034         ldaa    0,X     
   AB81 81 30         [ 2] 5035         cmpa    #0x30
   AB83 25 1E         [ 3] 5036         bcs     LABA3  
   AB85 81 39         [ 2] 5037         cmpa    #0x39
   AB87 22 1A         [ 3] 5038         bhi     LABA3  
   AB89 BD F9 6F      [ 6] 5039         jsr     SERIALW      
   AB8C 08            [ 3] 5040         inx
   AB8D A6 00         [ 4] 5041         ldaa    0,X     
   AB8F BD F9 6F      [ 6] 5042         jsr     SERIALW      
   AB92 08            [ 3] 5043         inx
   AB93 A6 00         [ 4] 5044         ldaa    0,X     
   AB95 BD F9 6F      [ 6] 5045         jsr     SERIALW      
   AB98 08            [ 3] 5046         inx
   AB99 86 20         [ 2] 5047         ldaa    #0x20
   AB9B BD F9 6F      [ 6] 5048         jsr     SERIALW      
   AB9E 8C 04 5C      [ 4] 5049         cpx     #0x045C
   ABA1 25 DC         [ 3] 5050         bcs     LAB7F  
   ABA3                    5051 LABA3:
   ABA3 86 0D         [ 2] 5052         ldaa    #0x0D
   ABA5 BD F9 6F      [ 6] 5053         jsr     SERIALW      
   ABA8 86 0A         [ 2] 5054         ldaa    #0x0A
   ABAA BD F9 6F      [ 6] 5055         jsr     SERIALW      
   ABAD 39            [ 5] 5056         rts
                           5057 
   ABAE                    5058 LABAE:
   ABAE 7F 00 4A      [ 6] 5059         clr     (0x004A)
   ABB1 CC 00 64      [ 3] 5060         ldd     #0x0064
   ABB4 DD 23         [ 4] 5061         std     CDTIMR5
   ABB6                    5062 LABB6:
   ABB6 96 4A         [ 3] 5063         ldaa    (0x004A)
   ABB8 26 08         [ 3] 5064         bne     LABC2  
   ABBA BD 9B 19      [ 6] 5065         jsr     L9B19           ; do the random motions if enabled
   ABBD DC 23         [ 4] 5066         ldd     CDTIMR5
   ABBF 26 F5         [ 3] 5067         bne     LABB6  
   ABC1                    5068 LABC1:
   ABC1 39            [ 5] 5069         rts
                           5070 
   ABC2                    5071 LABC2:
   ABC2 81 31         [ 2] 5072         cmpa    #0x31
   ABC4 26 04         [ 3] 5073         bne     LABCA  
   ABC6 BD AB 17      [ 6] 5074         jsr     LAB17
   ABC9 39            [ 5] 5075         rts
                           5076 
   ABCA                    5077 LABCA:
   ABCA 20 F5         [ 3] 5078         bra     LABC1  
                           5079 
                           5080 ; TOC1 timer handler
                           5081 ;
                           5082 ; Timer is running at:
                           5083 ; EXTAL = 16Mhz
                           5084 ; E Clk = 4Mhz
                           5085 ; Timer Prescaler = /16 = 250Khz
                           5086 ; Timer Period = 4us
                           5087 ; T1OC is set to previous value +625
                           5088 ; So, this routine is called every 2.5ms
                           5089 ;
   ABCC                    5090 LABCC:
   ABCC DC 10         [ 4] 5091         ldd     T1NXT           ; get ready for next time
   ABCE C3 02 71      [ 4] 5092         addd    #0x0271         ; add 625
   ABD1 FD 10 16      [ 5] 5093         std     TOC1  
   ABD4 DD 10         [ 4] 5094         std     T1NXT
                           5095 
   ABD6 86 80         [ 2] 5096         ldaa    #0x80
   ABD8 B7 10 23      [ 4] 5097         staa    TFLG1           ; clear timer1 flag
                           5098 
                           5099 ; Some blinking SPECIAL button every half second,
                           5100 ; if 0x0078 is non zero
                           5101 
   ABDB 7D 00 78      [ 6] 5102         tst     (0x0078)        ; if 78 is zero, skip ahead
   ABDE 27 1C         [ 3] 5103         beq     LABFC           ; else do some blinking button lights
   ABE0 DC 25         [ 4] 5104         ldd     (0x0025)        ; else inc 25/26
   ABE2 C3 00 01      [ 4] 5105         addd    #0x0001
   ABE5 DD 25         [ 4] 5106         std     (0x0025)
   ABE7 1A 83 00 C8   [ 5] 5107         cpd     #0x00C8         ; is it 200?
   ABEB 26 0F         [ 3] 5108         bne     LABFC           ; no, keep going
   ABED 7F 00 25      [ 6] 5109         clr     (0x0025)        ; reset 25/26
   ABF0 7F 00 26      [ 6] 5110         clr     (0x0026)
   ABF3 D6 62         [ 3] 5111         ldab    (0x0062)        ; and toggle bit 3 of 62
   ABF5 C8 08         [ 2] 5112         eorb    #0x08
   ABF7 D7 62         [ 3] 5113         stab    (0x0062)
   ABF9 BD F9 C5      [ 6] 5114         jsr     BUTNLIT         ; and toggle the "special" button light
                           5115 
                           5116 ; 
   ABFC                    5117 LABFC:
   ABFC 7C 00 6F      [ 6] 5118         inc     (0x006F)        ; count every 2.5ms
   ABFF 96 6F         [ 3] 5119         ldaa    (0x006F)
   AC01 81 28         [ 2] 5120         cmpa    #0x28           ; is it 40 intervals? (0.1 sec?)
   AC03 25 42         [ 3] 5121         bcs     LAC47           ; if not yet, jump ahead
   AC05 7F 00 6F      [ 6] 5122         clr     (0x006F)        ; clear it 2.5ms counter
   AC08 7D 00 63      [ 6] 5123         tst     (0x0063)        ; decrement 0.1s counter here
   AC0B 27 03         [ 3] 5124         beq     LAC10           ; if it's not already zero
   AC0D 7A 00 63      [ 6] 5125         dec     (0x0063)
                           5126 
                           5127 ; staggered counters - here every 100ms
                           5128 
                           5129 ; 0x0070 counts from 250 to 1, period is 25 secs
   AC10                    5130 LAC10:
   AC10 96 70         [ 3] 5131         ldaa    OFFCNT1         ; decrement 0.1s counter here
   AC12 4A            [ 2] 5132         deca
   AC13 97 70         [ 3] 5133         staa    OFFCNT1
   AC15 26 04         [ 3] 5134         bne     LAC1B       
   AC17 86 FA         [ 2] 5135         ldaa    #0xFA           ; 250
   AC19 97 70         [ 3] 5136         staa    OFFCNT1
                           5137 
                           5138 ; 0x0071 counts from 230 to 1, period is 23 secs
   AC1B                    5139 LAC1B:
   AC1B 96 71         [ 3] 5140         ldaa    OFFCNT2
   AC1D 4A            [ 2] 5141         deca
   AC1E 97 71         [ 3] 5142         staa    OFFCNT2
   AC20 26 04         [ 3] 5143         bne     LAC26  
   AC22 86 E6         [ 2] 5144         ldaa    #0xE6           ; 230
   AC24 97 71         [ 3] 5145         staa    OFFCNT2
                           5146 
                           5147 ; 0x0072 counts from 210 to 1, period is 21 secs
   AC26                    5148 LAC26:
   AC26 96 72         [ 3] 5149         ldaa    OFFCNT3
   AC28 4A            [ 2] 5150         deca
   AC29 97 72         [ 3] 5151         staa    OFFCNT3
   AC2B 26 04         [ 3] 5152         bne     LAC31  
   AC2D 86 D2         [ 2] 5153         ldaa    #0xD2           ; 210
   AC2F 97 72         [ 3] 5154         staa    OFFCNT3
                           5155 
                           5156 ; 0x0073 counts from 190 to 1, period is 19 secs
   AC31                    5157 LAC31:
   AC31 96 73         [ 3] 5158         ldaa    OFFCNT4
   AC33 4A            [ 2] 5159         deca
   AC34 97 73         [ 3] 5160         staa    OFFCNT4
   AC36 26 04         [ 3] 5161         bne     LAC3C  
   AC38 86 BE         [ 2] 5162         ldaa    #0xBE           ; 190
   AC3A 97 73         [ 3] 5163         staa    OFFCNT4
                           5164 
                           5165 ; 0x0074 counts from 170 to 1, period is 17 secs
   AC3C                    5166 LAC3C:
   AC3C 96 74         [ 3] 5167         ldaa    OFFCNT5
   AC3E 4A            [ 2] 5168         deca
   AC3F 97 74         [ 3] 5169         staa    OFFCNT5
   AC41 26 04         [ 3] 5170         bne     LAC47  
   AC43 86 AA         [ 2] 5171         ldaa    #0xAA           ; 170
   AC45 97 74         [ 3] 5172         staa    OFFCNT5
                           5173 
                           5174 ; back to 2.5ms period here
                           5175 
   AC47                    5176 LAC47:
   AC47 96 27         [ 3] 5177         ldaa    T30MS
   AC49 4C            [ 2] 5178         inca
   AC4A 97 27         [ 3] 5179         staa    T30MS
   AC4C 81 0C         [ 2] 5180         cmpa    #0x0C           ; 12 = 30ms?
   AC4E 23 09         [ 3] 5181         bls     LAC59  
   AC50 7F 00 27      [ 6] 5182         clr     T30MS
                           5183 
                           5184 ; do these two tasks every 30ms
   AC53 BD 8E C6      [ 6] 5185         jsr     L8EC6           ; ???
   AC56 BD 8F 12      [ 6] 5186         jsr     L8F12           ; ???
                           5187 
                           5188 ; back to every 2.5ms here
                           5189 ; LCD update???
                           5190 
   AC59                    5191 LAC59:
   AC59 96 43         [ 3] 5192         ldaa    (0x0043)
   AC5B 27 55         [ 3] 5193         beq     LACB2  
   AC5D DE 44         [ 4] 5194         ldx     (0x0044)
   AC5F A6 00         [ 4] 5195         ldaa    0,X     
   AC61 27 23         [ 3] 5196         beq     LAC86  
   AC63 B7 10 00      [ 4] 5197         staa    PORTA  
   AC66 B6 10 02      [ 4] 5198         ldaa    PORTG  
   AC69 84 F3         [ 2] 5199         anda    #0xF3
   AC6B B7 10 02      [ 4] 5200         staa    PORTG  
   AC6E 84 FD         [ 2] 5201         anda    #0xFD
   AC70 B7 10 02      [ 4] 5202         staa    PORTG  
   AC73 8A 02         [ 2] 5203         oraa    #0x02
   AC75 B7 10 02      [ 4] 5204         staa    PORTG  
   AC78 08            [ 3] 5205         inx
   AC79 08            [ 3] 5206         inx
   AC7A 8C 05 80      [ 4] 5207         cpx     #0x0580
   AC7D 25 03         [ 3] 5208         bcs     LAC82  
   AC7F CE 05 00      [ 3] 5209         ldx     #0x0500
   AC82                    5210 LAC82:
   AC82 DF 44         [ 4] 5211         stx     (0x0044)
   AC84 20 2C         [ 3] 5212         bra     LACB2  
   AC86                    5213 LAC86:
   AC86 A6 01         [ 4] 5214         ldaa    1,X     
   AC88 27 25         [ 3] 5215         beq     LACAF  
   AC8A B7 10 00      [ 4] 5216         staa    PORTA  
   AC8D B6 10 02      [ 4] 5217         ldaa    PORTG  
   AC90 84 FB         [ 2] 5218         anda    #0xFB
   AC92 8A 08         [ 2] 5219         oraa    #0x08
   AC94 B7 10 02      [ 4] 5220         staa    PORTG  
   AC97 84 FD         [ 2] 5221         anda    #0xFD
   AC99 B7 10 02      [ 4] 5222         staa    PORTG  
   AC9C 8A 02         [ 2] 5223         oraa    #0x02
   AC9E B7 10 02      [ 4] 5224         staa    PORTG  
   ACA1 08            [ 3] 5225         inx
   ACA2 08            [ 3] 5226         inx
   ACA3 8C 05 80      [ 4] 5227         cpx     #0x0580
   ACA6 25 03         [ 3] 5228         bcs     LACAB  
   ACA8 CE 05 00      [ 3] 5229         ldx     #0x0500
   ACAB                    5230 LACAB:
   ACAB DF 44         [ 4] 5231         stx     (0x0044)
   ACAD 20 03         [ 3] 5232         bra     LACB2  
   ACAF                    5233 LACAF:
   ACAF 7F 00 43      [ 6] 5234         clr     (0x0043)
                           5235 
                           5236 ; divide by 4
   ACB2                    5237 LACB2:
   ACB2 96 4F         [ 3] 5238         ldaa    (0x004F)
   ACB4 4C            [ 2] 5239         inca
   ACB5 97 4F         [ 3] 5240         staa    (0x004F)
   ACB7 81 04         [ 2] 5241         cmpa    #0x04
   ACB9 26 30         [ 3] 5242         bne     LACEB  
   ACBB 7F 00 4F      [ 6] 5243         clr     (0x004F)
                           5244 
                           5245 ; here every 10ms
                           5246 ; Five big countdown timers available here
                           5247 ; up to 655.35 seconds each
                           5248 
   ACBE DC 1B         [ 4] 5249         ldd     CDTIMR1         ; countdown 0x001B/1C every 10ms
   ACC0 27 05         [ 3] 5250         beq     LACC7           ; if not already 0
   ACC2 83 00 01      [ 4] 5251         subd    #0x0001
   ACC5 DD 1B         [ 4] 5252         std     CDTIMR1
                           5253 
   ACC7                    5254 LACC7:
   ACC7 DC 1D         [ 4] 5255         ldd     CDTIMR2         ; same with 0x001D/1E
   ACC9 27 05         [ 3] 5256         beq     LACD0  
   ACCB 83 00 01      [ 4] 5257         subd    #0x0001
   ACCE DD 1D         [ 4] 5258         std     CDTIMR2
                           5259 
   ACD0                    5260 LACD0:
   ACD0 DC 1F         [ 4] 5261         ldd     CDTIMR3         ; same with 0x001F/20
   ACD2 27 05         [ 3] 5262         beq     LACD9  
   ACD4 83 00 01      [ 4] 5263         subd    #0x0001
   ACD7 DD 1F         [ 4] 5264         std     CDTIMR3
                           5265 
   ACD9                    5266 LACD9:
   ACD9 DC 21         [ 4] 5267         ldd     CDTIMR4         ; same with 0x0021/22
   ACDB 27 05         [ 3] 5268         beq     LACE2  
   ACDD 83 00 01      [ 4] 5269         subd    #0x0001
   ACE0 DD 21         [ 4] 5270         std     CDTIMR4
                           5271 
   ACE2                    5272 LACE2:
   ACE2 DC 23         [ 4] 5273         ldd     CDTIMR5         ; same with 0x0023/24
   ACE4 27 05         [ 3] 5274         beq     LACEB  
   ACE6 83 00 01      [ 4] 5275         subd    #0x0001
   ACE9 DD 23         [ 4] 5276         std     CDTIMR5
                           5277 
                           5278 ; every other time through this, setup a task switch?
   ACEB                    5279 LACEB:
   ACEB 96 B0         [ 3] 5280         ldaa    (TSCNT)
   ACED 88 01         [ 2] 5281         eora    #0x01
   ACEF 97 B0         [ 3] 5282         staa    (TSCNT)
   ACF1 27 18         [ 3] 5283         beq     LAD0B  
                           5284 
   ACF3 BF 01 3C      [ 5] 5285         sts     (0x013C)        ; switch stacks???
   ACF6 BE 01 3E      [ 5] 5286         lds     (0x013E)
   ACF9 DC 10         [ 4] 5287         ldd     T1NXT
   ACFB 83 01 F4      [ 4] 5288         subd    #0x01F4         ; 625-500 = 125?
   ACFE FD 10 18      [ 5] 5289         std     TOC2            ; set this TOC2 to happen 0.5ms
   AD01 86 40         [ 2] 5290         ldaa    #0x40           ; after the current TOC1 but before the next TOC1
   AD03 B7 10 23      [ 4] 5291         staa    TFLG1           ; clear timer2 irq flag, just in case?
   AD06 86 C0         [ 2] 5292         ldaa    #0xC0           ;
   AD08 B7 10 22      [ 4] 5293         staa    TMSK1           ; enable TOC1 and TOC2
   AD0B                    5294 LAD0B:
   AD0B 3B            [12] 5295         rti
                           5296 
                           5297 ; TOC2 Timer handler and SWI handler
   AD0C                    5298 LAD0C:
   AD0C 86 40         [ 2] 5299         ldaa    #0x40
   AD0E B7 10 23      [ 4] 5300         staa    TFLG1           ; clear timer2 flag
   AD11 BF 01 3E      [ 5] 5301         sts     (0x013E)        ; switch stacks back???
   AD14 BE 01 3C      [ 5] 5302         lds     (0x013C)
   AD17 86 80         [ 2] 5303         ldaa    #0x80
   AD19 B7 10 22      [ 4] 5304         staa    TMSK1           ; enable TOC1 only
   AD1C 3B            [12] 5305         rti
                           5306 
                           5307 ; Secondary task??
                           5308 
   AD1D                    5309 TASK2:
   AD1D 7D 04 2A      [ 6] 5310         tst     (0x042A)
   AD20 27 35         [ 3] 5311         beq     LAD57
   AD22 96 B6         [ 3] 5312         ldaa    (0x00B6)
   AD24 26 03         [ 3] 5313         bne     LAD29
   AD26 3F            [14] 5314         swi
   AD27 20 F4         [ 3] 5315         bra     TASK2
   AD29                    5316 LAD29:
   AD29 7F 00 B6      [ 6] 5317         clr     (0x00B6)
   AD2C C6 04         [ 2] 5318         ldab    #0x04
   AD2E                    5319 LAD2E:
   AD2E 37            [ 3] 5320         pshb
   AD2F CE AD 3C      [ 3] 5321         ldx     #LAD3C
   AD32 BD 8A 1A      [ 6] 5322         jsr     L8A1A  
   AD35 3F            [14] 5323         swi
   AD36 33            [ 4] 5324         pulb
   AD37 5A            [ 2] 5325         decb
   AD38 26 F4         [ 3] 5326         bne     LAD2E  
   AD3A 20 E1         [ 3] 5327         bra     TASK2
                           5328 
   AD3C                    5329 LAD3C:
   AD3C 53 31 00           5330         .asciz     'S1'
                           5331 
   AD3F FC 02 9C      [ 5] 5332         ldd     (0x029C)
   AD42 1A 83 00 01   [ 5] 5333         cpd     #0x0001         ; 1
   AD46 27 0C         [ 3] 5334         beq     LAD54  
   AD48 1A 83 03 E8   [ 5] 5335         cpd     #0x03E8         ; 1000
   AD4C 2D 09         [ 3] 5336         blt     LAD57  
   AD4E 1A 83 04 4B   [ 5] 5337         cpd     #0x044B         ; 1099
   AD52 22 03         [ 3] 5338         bhi     LAD57  
   AD54                    5339 LAD54:
   AD54 3F            [14] 5340         swi
   AD55 20 C6         [ 3] 5341         bra     TASK2
   AD57                    5342 LAD57:
   AD57 7F 00 B3      [ 6] 5343         clr     (0x00B3)
   AD5A BD AD 7E      [ 6] 5344         jsr     LAD7E
   AD5D BD AD A0      [ 6] 5345         jsr     LADA0
   AD60 25 BB         [ 3] 5346         bcs     TASK2
   AD62 C6 0A         [ 2] 5347         ldab    #0x0A
   AD64 BD AE 13      [ 6] 5348         jsr     LAE13
   AD67 BD AD AE      [ 6] 5349         jsr     LADAE
   AD6A 25 B1         [ 3] 5350         bcs     TASK2
   AD6C C6 14         [ 2] 5351         ldab    #0x14
   AD6E BD AE 13      [ 6] 5352         jsr     LAE13
   AD71 BD AD B6      [ 6] 5353         jsr     LADB6
   AD74 25 A7         [ 3] 5354         bcs     TASK2
   AD76                    5355 LAD76:
   AD76 BD AD B8      [ 6] 5356         jsr     LADB8
   AD79 0D            [ 2] 5357         sec
   AD7A 25 A1         [ 3] 5358         bcs     TASK2
   AD7C 20 F8         [ 3] 5359         bra     LAD76
   AD7E                    5360 LAD7E:
   AD7E CE AE 1E      [ 3] 5361         ldx     #LAE1E          ;+++
   AD81 BD 8A 1A      [ 6] 5362         jsr     L8A1A  
   AD84 C6 1E         [ 2] 5363         ldab    #0x1E
   AD86 BD AE 13      [ 6] 5364         jsr     LAE13
   AD89 CE AE 22      [ 3] 5365         ldx     #LAE22          ;ATH
   AD8C BD 8A 1A      [ 6] 5366         jsr     L8A1A  
   AD8F C6 1E         [ 2] 5367         ldab    #0x1E
   AD91 BD AE 13      [ 6] 5368         jsr     LAE13
   AD94 CE AE 27      [ 3] 5369         ldx     #LAE27          ;ATZ
   AD97 BD 8A 1A      [ 6] 5370         jsr     L8A1A  
   AD9A C6 1E         [ 2] 5371         ldab    #0x1E
   AD9C BD AE 13      [ 6] 5372         jsr     LAE13
   AD9F 39            [ 5] 5373         rts
   ADA0                    5374 LADA0:
   ADA0 BD B1 DD      [ 6] 5375         jsr     LB1DD
   ADA3 25 FB         [ 3] 5376         bcs     LADA0  
   ADA5 BD B2 4F      [ 6] 5377         jsr     LB24F
                           5378 
   ADA8 52 49 4E 47 00     5379         .asciz  'RING'
                           5380 
   ADAD 39            [ 5] 5381         rts
                           5382 
   ADAE                    5383 LADAE:
   ADAE CE AE 2C      [ 3] 5384         ldx     #LAE2C
   ADB1 BD 8A 1A      [ 6] 5385         jsr     L8A1A           ;ATA
   ADB4 0C            [ 2] 5386         clc
   ADB5 39            [ 5] 5387         rts
   ADB6                    5388 LADB6:
   ADB6 0C            [ 2] 5389         clc
   ADB7 39            [ 5] 5390         rts
                           5391 
   ADB8                    5392 LADB8:
   ADB8 BD B1 D2      [ 6] 5393         jsr     LB1D2
   ADBB BD AE 31      [ 6] 5394         jsr     LAE31
   ADBE 86 01         [ 2] 5395         ldaa    #0x01
   ADC0 97 B3         [ 3] 5396         staa    (0x00B3)
   ADC2 BD B1 DD      [ 6] 5397         jsr     LB1DD
   ADC5 BD B2 71      [ 6] 5398         jsr     LB271
   ADC8 36            [ 3] 5399         psha
   ADC9 BD B2 C0      [ 6] 5400         jsr     LB2C0
   ADCC 32            [ 4] 5401         pula
   ADCD 81 01         [ 2] 5402         cmpa    #0x01
   ADCF 26 08         [ 3] 5403         bne     LADD9  
   ADD1 CE B2 95      [ 3] 5404         ldx     #LB295
   ADD4 BD 8A 1A      [ 6] 5405         jsr     L8A1A           ;'You have selected #1'
   ADD7 20 31         [ 3] 5406         bra     LAE0A  
   ADD9                    5407 LADD9:
   ADD9 81 02         [ 2] 5408         cmpa    #0x02
   ADDB 26 00         [ 3] 5409         bne     LADDD  
   ADDD                    5410 LADDD:
   ADDD 81 03         [ 2] 5411         cmpa    #0x03
   ADDF 26 00         [ 3] 5412         bne     LADE1  
   ADE1                    5413 LADE1:
   ADE1 81 04         [ 2] 5414         cmpa    #0x04
   ADE3 26 00         [ 3] 5415         bne     LADE5  
   ADE5                    5416 LADE5:
   ADE5 81 05         [ 2] 5417         cmpa    #0x05
   ADE7 26 00         [ 3] 5418         bne     LADE9  
   ADE9                    5419 LADE9:
   ADE9 81 06         [ 2] 5420         cmpa    #0x06
   ADEB 26 00         [ 3] 5421         bne     LADED  
   ADED                    5422 LADED:
   ADED 81 07         [ 2] 5423         cmpa    #0x07
   ADEF 26 00         [ 3] 5424         bne     LADF1  
   ADF1                    5425 LADF1:
   ADF1 81 08         [ 2] 5426         cmpa    #0x08
   ADF3 26 00         [ 3] 5427         bne     LADF5  
   ADF5                    5428 LADF5:
   ADF5 81 09         [ 2] 5429         cmpa    #0x09
   ADF7 26 00         [ 3] 5430         bne     LADF9  
   ADF9                    5431 LADF9:
   ADF9 81 0A         [ 2] 5432         cmpa    #0x0A
   ADFB 26 00         [ 3] 5433         bne     LADFD  
   ADFD                    5434 LADFD:
   ADFD 81 0B         [ 2] 5435         cmpa    #0x0B
   ADFF 26 09         [ 3] 5436         bne     LAE0A  
   AE01 CE B2 AA      [ 3] 5437         ldx     #LB2AA          ;'You have selected #11'
   AE04 BD 8A 1A      [ 6] 5438         jsr     L8A1A  
   AE07 7E AE 0A      [ 3] 5439         jmp     LAE0A
   AE0A                    5440 LAE0A:
   AE0A C6 14         [ 2] 5441         ldab    #0x14
   AE0C BD AE 13      [ 6] 5442         jsr     LAE13
   AE0F 7F 00 B3      [ 6] 5443         clr     (0x00B3)
   AE12 39            [ 5] 5444         rts
                           5445 
   AE13                    5446 LAE13:
   AE13 CE 00 20      [ 3] 5447         ldx     #0x0020
   AE16                    5448 LAE16:
   AE16 3F            [14] 5449         swi
   AE17 09            [ 3] 5450         dex
   AE18 26 FC         [ 3] 5451         bne     LAE16  
   AE1A 5A            [ 2] 5452         decb
   AE1B 26 F6         [ 3] 5453         bne     LAE13  
   AE1D 39            [ 5] 5454         rts
                           5455 
                           5456 ; text??
   AE1E                    5457 LAE1E:
   AE1E 2B 2B 2B 00        5458         .asciz      '+++'
   AE22                    5459 LAE22:
   AE22 41 54 48 0D 00     5460         .asciz      'ATH\r'
   AE27                    5461 LAE27:
   AE27 41 54 5A 0D 00     5462         .asciz      'ATZ\r'
   AE2C                    5463 LAE2C:
   AE2C 41 54 41 0D 00     5464         .asciz      'ATA\r'
                           5465 
   AE31                    5466 LAE31:
   AE31 CE AE 38      [ 3] 5467         ldx     #LAE38          ; big long string of stats, with compressed ansi codes
   AE34 BD 8A 1A      [ 6] 5468         jsr     L8A1A  
   AE37 39            [ 5] 5469         rts
                           5470 
   AE38                    5471 LAE38:
   AE38 5E 30 31 30 31 53  5472         .ascii  "^0101Serial #:^0140#0000^0111~4"
        65 72 69 61 6C 20
        23 3A 5E 30 31 34
        30 23 30 30 30 30
        5E 30 31 31 31 7E
        34
   AE57 0E 20              5473         .byte   0x0E,0x20
   AE59 5E 30 31 34 31 7C  5474         .ascii  "^0141|"
   AE5F 04 28              5475         .byte   0x04,0x28
   AE61 5E 30 33 30 31 43  5476         .ascii  "^0301CURRENT^0340HISTORY^0501Show Status:^0540Total # reg. shows:^0601Random Status:^0570|"
        55 52 52 45 4E 54
        5E 30 33 34 30 48
        49 53 54 4F 52 59
        5E 30 35 30 31 53
        68 6F 77 20 53 74
        61 74 75 73 3A 5E
        30 35 34 30 54 6F
        74 61 6C 20 23 20
        72 65 67 2E 20 73
        68 6F 77 73 3A 5E
        30 36 30 31 52 61
        6E 64 6F 6D 20 53
        74 61 74 75 73 3A
        5E 30 35 37 30 7C
   AEBB 04 10              5477         .byte   0x04,0x10
   AEBD 5E 30 36 34 30 54  5478         .ascii  "^0640Total # live shows:^0701Current Reg Tape #:^0670|"
        6F 74 61 6C 20 23
        20 6C 69 76 65 20
        73 68 6F 77 73 3A
        5E 30 37 30 31 43
        75 72 72 65 6E 74
        20 52 65 67 20 54
        61 70 65 20 23 3A
        5E 30 36 37 30 7C
   AEF3 04 12              5479         .byte   0x04,0x12
   AEF5 5E 30 37 33 30 7E  5480         .ascii  "^0730~3"
        33
   AEFC 04 02              5481         .byte   0x04,0x02
   AEFE 5E 30 37 34 30 54  5482         .ascii  "^0740Total # failed pswd attempts:^0801Current Live Tape #:^0770|"
        6F 74 61 6C 20 23
        20 66 61 69 6C 65
        64 20 70 73 77 64
        20 61 74 74 65 6D
        70 74 73 3A 5E 30
        38 30 31 43 75 72
        72 65 6E 74 20 4C
        69 76 65 20 54 61
        70 65 20 23 3A 5E
        30 37 37 30 7C
   AF3F 04 14              5483         .byte   0x04,0x14
   AF41 5E 30 38 33 30 7E  5484         .ascii  "^0830~3"
        33
   AF48 04 05              5485         .byte   0x04,0x05
   AF4A 5E 30 38 34 30 54  5486         .ascii  "^0840Total # successful pswd:^0901Current Version #:^0870|"
        6F 74 61 6C 20 23
        20 73 75 63 63 65
        73 73 66 75 6C 20
        70 73 77 64 3A 5E
        30 39 30 31 43 75
        72 72 65 6E 74 20
        56 65 72 73 69 6F
        6E 20 23 3A 5E 30
        38 37 30 7C
   AF84 04 16              5487         .byte   0x04,0x16
   AF86 5E 30 39 33 30 40  5488         .ascii  "^0930@"
   AF8C 04 00              5489         .byte   0x04,0x00
   AF8E 5E 30 39 34 30 54  5490         .ascii  "^0940Total # bdays played:^1040Total # VCR adjusts:^0970|"
        6F 74 61 6C 20 23
        20 62 64 61 79 73
        20 70 6C 61 79 65
        64 3A 5E 31 30 34
        30 54 6F 74 61 6C
        20 23 20 56 43 52
        20 61 64 6A 75 73
        74 73 3A 5E 30 39
        37 30 7C
   AFC7 04 18              5491         .byte   0x04,0x18
   AFC9 5E 31 30 37 30 7C  5492         .ascii  "^1070|"
   AFCF 04 1A              5493         .byte   0x04,0x1A
   AFD1 5E 31 31 34 30 54  5494         .ascii  "^1140Total # remote accesses:^1240Total # access attempts:^1170|"
        6F 74 61 6C 20 23
        20 72 65 6D 6F 74
        65 20 61 63 63 65
        73 73 65 73 3A 5E
        31 32 34 30 54 6F
        74 61 6C 20 23 20
        61 63 63 65 73 73
        20 61 74 74 65 6D
        70 74 73 3A 5E 31
        31 37 30 7C
   B011 04 1C              5495         .byte   0x04,0x1C
   B013 5E 31 32 37 30 7C  5496         .ascii  "^1270|"
   B019 04 1E              5497         .byte   0x04,0x1E
   B01B 5E 31 33 34 30 54  5498         .ascii  "^1340Total # rejected showtapes:^1440Total # Short bdays:^1370|"
        6F 74 61 6C 20 23
        20 72 65 6A 65 63
        74 65 64 20 73 68
        6F 77 74 61 70 65
        73 3A 5E 31 34 34
        30 54 6F 74 61 6C
        20 23 20 53 68 6F
        72 74 20 62 64 61
        79 73 3A 5E 31 33
        37 30 7C
   B05A 04 20              5499         .byte   0x04,0x20
   B05C 5E 31 34 37 30 7C  5500         .ascii  "^1470|"
   B062 04 22              5501         .byte   0x04,0x22
   B064 5E 31 35 34 30 54  5502         .ascii  "^1540Total # Reg bdays:^1640Total # resets-pwr ups:^1570|"
        6F 74 61 6C 20 23
        20 52 65 67 20 62
        64 61 79 73 3A 5E
        31 36 34 30 54 6F
        74 61 6C 20 23 20
        72 65 73 65 74 73
        2D 70 77 72 20 75
        70 73 3A 5E 31 35
        37 30 7C
   B09D 04 24              5503         .byte   0x04,0x24
   B09F 5E 31 36 37 30 7C  5504         .ascii  "^1670|"
   B0A5 04 26              5505         .byte   0x04,0x26
   B0A7 5E 31 38 30 31 46  5506         .ascii  "^1801FUNCTIONS^1823Select Function:^20011.Clear rnd enables^2028 6.Set loc name-#^205411.Diagnostics^21012.Set rnd enables^2128 7.Set Time^215412.^22013.Set reg tape #^2228 8.Disbl-enbl show^225413.^23014.Set liv tape #^2328 9.Upload program^235414.^24015.Reset history^242810.Debugger^245415.^1840"
        55 4E 43 54 49 4F
        4E 53 5E 31 38 32
        33 53 65 6C 65 63
        74 20 46 75 6E 63
        74 69 6F 6E 3A 5E
        32 30 30 31 31 2E
        43 6C 65 61 72 20
        72 6E 64 20 65 6E
        61 62 6C 65 73 5E
        32 30 32 38 20 36
        2E 53 65 74 20 6C
        6F 63 20 6E 61 6D
        65 2D 23 5E 32 30
        35 34 31 31 2E 44
        69 61 67 6E 6F 73
        74 69 63 73 5E 32
        31 30 31 32 2E 53
        65 74 20 72 6E 64
        20 65 6E 61 62 6C
        65 73 5E 32 31 32
        38 20 37 2E 53 65
        74 20 54 69 6D 65
        5E 32 31 35 34 31
        32 2E 5E 32 32 30
        31 33 2E 53 65 74
        20 72 65 67 20 74
        61 70 65 20 23 5E
        32 32 32 38 20 38
        2E 44 69 73 62 6C
        2D 65 6E 62 6C 20
        73 68 6F 77 5E 32
        32 35 34 31 33 2E
        5E 32 33 30 31 34
        2E 53 65 74 20 6C
        69 76 20 74 61 70
        65 20 23 5E 32 33
        32 38 20 39 2E 55
        70 6C 6F 61 64 20
        70 72 6F 67 72 61
        6D 5E 32 33 35 34
        31 34 2E 5E 32 34
        30 31 35 2E 52 65
        73 65 74 20 68 69
        73 74 6F 72 79 5E
        32 34 32 38 31 30
        2E 44 65 62 75 67
        67 65 72 5E 32 34
        35 34 31 35 2E 5E
        31 38 34 30
   B1D1 00                 5507         .byte   0x00
                           5508 
   B1D2                    5509 LB1D2:
   B1D2 CE B1 D8      [ 3] 5510         ldx     #LB1D8          ; escape sequence?
   B1D5 7E 8A 1A      [ 3] 5511         jmp     L8A1A  
                           5512 
                           5513 ; ANSI control sequence - Clear Screen and Home Cursor
   B1D8                    5514 LB1D8:
                           5515         ; esc[2J
   B1D8 1B                 5516         .byte   0x1b
   B1D9 5B 32 4A 00        5517         .asciz  '[2J'
                           5518 
   B1DD                    5519 LB1DD:
   B1DD CE 05 A0      [ 3] 5520         ldx     #0x05A0
   B1E0 CC 00 00      [ 3] 5521         ldd     #0x0000
   B1E3 FD 02 9E      [ 5] 5522         std     (0x029E)
   B1E6                    5523 LB1E6:
   B1E6 FC 02 9E      [ 5] 5524         ldd     (0x029E)
   B1E9 C3 00 01      [ 4] 5525         addd    #0x0001
   B1EC FD 02 9E      [ 5] 5526         std     (0x029E)
   B1EF 1A 83 0F A0   [ 5] 5527         cpd     #0x0FA0
   B1F3 24 28         [ 3] 5528         bcc     LB21D  
   B1F5 BD B2 23      [ 6] 5529         jsr     LB223
   B1F8 25 04         [ 3] 5530         bcs     LB1FE  
   B1FA 3F            [14] 5531         swi
   B1FB 20 E9         [ 3] 5532         bra     LB1E6  
   B1FD 39            [ 5] 5533         rts
                           5534 
   B1FE                    5535 LB1FE:
   B1FE A7 00         [ 4] 5536         staa    0,X     
   B200 08            [ 3] 5537         inx
   B201 81 0D         [ 2] 5538         cmpa    #0x0D
   B203 26 02         [ 3] 5539         bne     LB207  
   B205 20 18         [ 3] 5540         bra     LB21F  
   B207                    5541 LB207:
   B207 81 1B         [ 2] 5542         cmpa    #0x1B
   B209 26 02         [ 3] 5543         bne     LB20D  
   B20B 20 10         [ 3] 5544         bra     LB21D  
   B20D                    5545 LB20D:
   B20D 7D 00 B3      [ 6] 5546         tst     (0x00B3)
   B210 27 03         [ 3] 5547         beq     LB215  
   B212 BD 8B 3B      [ 6] 5548         jsr     L8B3B
   B215                    5549 LB215:
   B215 CC 00 00      [ 3] 5550         ldd     #0x0000
   B218 FD 02 9E      [ 5] 5551         std     (0x029E)
   B21B 20 C9         [ 3] 5552         bra     LB1E6  
   B21D                    5553 LB21D:
   B21D 0D            [ 2] 5554         sec
   B21E 39            [ 5] 5555         rts
                           5556 
   B21F                    5557 LB21F:
   B21F 6F 00         [ 6] 5558         clr     0,X     
   B221 0C            [ 2] 5559         clc
   B222 39            [ 5] 5560         rts
                           5561 
   B223                    5562 LB223:
   B223 B6 18 0D      [ 4] 5563         ldaa    SCCCTRLB
   B226 44            [ 2] 5564         lsra
   B227 25 0B         [ 3] 5565         bcs     LB234  
   B229 4F            [ 2] 5566         clra
   B22A B7 18 0D      [ 4] 5567         staa    SCCCTRLB
   B22D 86 30         [ 2] 5568         ldaa    #0x30
   B22F B7 18 0D      [ 4] 5569         staa    SCCCTRLB
   B232 0C            [ 2] 5570         clc
   B233 39            [ 5] 5571         rts
                           5572 
   B234                    5573 LB234:
   B234 86 01         [ 2] 5574         ldaa    #0x01
   B236 B7 18 0D      [ 4] 5575         staa    SCCCTRLB
   B239 86 70         [ 2] 5576         ldaa    #0x70
   B23B B5 18 0D      [ 4] 5577         bita    SCCCTRLB
   B23E 26 05         [ 3] 5578         bne     LB245  
   B240 0D            [ 2] 5579         sec
   B241 B6 18 0F      [ 4] 5580         ldaa    SCCDATAB
   B244 39            [ 5] 5581         rts
                           5582 
   B245                    5583 LB245:
   B245 B6 18 0F      [ 4] 5584         ldaa    SCCDATAB
   B248 86 30         [ 2] 5585         ldaa    #0x30
   B24A B7 18 0C      [ 4] 5586         staa    SCCCTRLA
   B24D 0C            [ 2] 5587         clc
   B24E 39            [ 5] 5588         rts
                           5589 
   B24F                    5590 LB24F:
   B24F 38            [ 5] 5591         pulx
   B250 18 CE 05 A0   [ 4] 5592         ldy     #0x05A0
   B254                    5593 LB254:
   B254 A6 00         [ 4] 5594         ldaa    0,X
   B256 27 11         [ 3] 5595         beq     LB269
   B258 08            [ 3] 5596         inx
   B259 18 A1 00      [ 5] 5597         cmpa    0,Y
   B25C 26 04         [ 3] 5598         bne     LB262
   B25E 18 08         [ 4] 5599         iny
   B260 20 F2         [ 3] 5600         bra     LB254
   B262                    5601 LB262:
   B262 A6 00         [ 4] 5602         ldaa    0,X
   B264 27 07         [ 3] 5603         beq     LB26D
   B266 08            [ 3] 5604         inx
   B267 20 F9         [ 3] 5605         bra     LB262
   B269                    5606 LB269:
   B269 08            [ 3] 5607         inx
   B26A 3C            [ 4] 5608         pshx
   B26B 0C            [ 2] 5609         clc
   B26C 39            [ 5] 5610         rts
   B26D                    5611 LB26D:
   B26D 08            [ 3] 5612         inx
   B26E 3C            [ 4] 5613         pshx
   B26F 0D            [ 2] 5614         sec
   B270 39            [ 5] 5615         rts
                           5616 
   B271                    5617 LB271:
   B271 CE 05 A0      [ 3] 5618         ldx     #0x05A0
   B274                    5619 LB274:
   B274 A6 00         [ 4] 5620         ldaa    0,X
   B276 08            [ 3] 5621         inx
   B277 81 0D         [ 2] 5622         cmpa    #0x0D
   B279 26 F9         [ 3] 5623         bne     LB274
   B27B 09            [ 3] 5624         dex
   B27C 09            [ 3] 5625         dex
   B27D A6 00         [ 4] 5626         ldaa    0,X
   B27F 09            [ 3] 5627         dex
   B280 80 30         [ 2] 5628         suba    #0x30
   B282 97 B2         [ 3] 5629         staa    (0x00B2)
   B284 8C 05 9F      [ 4] 5630         cpx     #0x059F
   B287 27 0B         [ 3] 5631         beq     LB294
   B289 A6 00         [ 4] 5632         ldaa    0,X
   B28B 09            [ 3] 5633         dex
   B28C 80 30         [ 2] 5634         suba    #0x30
   B28E C6 0A         [ 2] 5635         ldab    #0x0A
   B290 3D            [10] 5636         mul
   B291 17            [ 2] 5637         tba
   B292 9B B2         [ 3] 5638         adda    (0x00B2)
   B294                    5639 LB294:
   B294 39            [ 5] 5640         rts
                           5641 
   B295                    5642 LB295:
   B295 59 6F 75 20 68 61  5643         .asciz  'You have selected #1'
        76 65 20 73 65 6C
        65 63 74 65 64 20
        23 31 00
   B2AA                    5644 LB2AA:
   B2AA 59 6F 75 20 68 61  5645         .asciz  'You have selected #11'
        76 65 20 73 65 6C
        65 63 74 65 64 20
        23 31 31 00
                           5646 
   B2C0                    5647 LB2C0:
   B2C0 CE B2 C7      [ 3] 5648         ldx     #LB2C7          ; Table with compressed ANSI cursor controls
   B2C3 BD 8A 1A      [ 6] 5649         jsr     L8A1A  
   B2C6 39            [ 5] 5650         rts
                           5651 
   B2C7                    5652 LB2C7:
   B2C7 5E 32 30 30 31 25  5653         .asciz  "^2001%^2101%^2201%^2301%^2401%^2001"
        5E 32 31 30 31 25
        5E 32 32 30 31 25
        5E 32 33 30 31 25
        5E 32 34 30 31 25
        5E 32 30 30 31 00
                           5654 
                           5655 ; Random movement tables
                           5656 
                           5657 ; board 1
   B2EB                    5658 LB2EB:
   B2EB FA 20 FA 20 F6 22  5659         .byte   0xfa,0x20,0xfa,0x20,0xf6,0x22,0xf5,0x20
        F5 20
   B2F3 F5 20 F3 22 F2 20  5660         .byte   0xf5,0x20,0xf3,0x22,0xf2,0x20,0xe5,0x22
        E5 22
   B2FB E5 22 E2 20 D2 20  5661         .byte   0xe5,0x22,0xe2,0x20,0xd2,0x20,0xbe,0x00
        BE 00
   B303 BC 22 BB 30 B9 32  5662         .byte   0xbc,0x22,0xbb,0x30,0xb9,0x32,0xb9,0x32
        B9 32
   B30B B7 30 B6 32 B5 30  5663         .byte   0xb7,0x30,0xb6,0x32,0xb5,0x30,0xb4,0x32
        B4 32
   B313 B4 32 B3 20 B3 20  5664         .byte   0xb4,0x32,0xb3,0x20,0xb3,0x20,0xb1,0xa0
        B1 A0
   B31B B1 A0 B0 A2 AF A0  5665         .byte   0xb1,0xa0,0xb0,0xa2,0xaf,0xa0,0xaf,0xa6
        AF A6
   B323 AE A0 AE A6 AD A4  5666         .byte   0xae,0xa0,0xae,0xa6,0xad,0xa4,0xac,0xa0
        AC A0
   B32B AC A0 AB A0 AA A0  5667         .byte   0xac,0xa0,0xab,0xa0,0xaa,0xa0,0xaa,0xa0
        AA A0
   B333 A2 80 A0 A0 A0 A0  5668         .byte   0xa2,0x80,0xa0,0xa0,0xa0,0xa0,0x8d,0x80
        8D 80
   B33B 8A A0 7E 80 7B A0  5669         .byte   0x8a,0xa0,0x7e,0x80,0x7b,0xa0,0x79,0xa4
        79 A4
   B343 78 A0 77 A4 76 A0  5670         .byte   0x78,0xa0,0x77,0xa4,0x76,0xa0,0x75,0xa4
        75 A4
   B34B 74 A0 73 A4 72 A0  5671         .byte   0x74,0xa0,0x73,0xa4,0x72,0xa0,0x71,0xa4
        71 A4
   B353 70 A0 6F A4 6E A0  5672         .byte   0x70,0xa0,0x6f,0xa4,0x6e,0xa0,0x6d,0xa4
        6D A4
   B35B 6C A0 69 80 69 80  5673         .byte   0x6c,0xa0,0x69,0x80,0x69,0x80,0x67,0xa0
        67 A0
   B363 5E 20 58 24 57 20  5674         .byte   0x5e,0x20,0x58,0x24,0x57,0x20,0x57,0x20
        57 20
   B36B 56 24 55 20 54 24  5675         .byte   0x56,0x24,0x55,0x20,0x54,0x24,0x54,0x24
        54 24
   B373 53 20 52 24 52 24  5676         .byte   0x53,0x20,0x52,0x24,0x52,0x24,0x50,0x20
        50 20
   B37B 4F 24 4E 20 4D 24  5677         .byte   0x4f,0x24,0x4e,0x20,0x4d,0x24,0x4c,0x20
        4C 20
   B383 4C 20 4B 24 4A 20  5678         .byte   0x4c,0x20,0x4b,0x24,0x4a,0x20,0x49,0x20
        49 20
   B38B 49 00 48 20 47 20  5679         .byte   0x49,0x00,0x48,0x20,0x47,0x20,0x47,0x20
        47 20
   B393 46 20 45 24 45 24  5680         .byte   0x46,0x20,0x45,0x24,0x45,0x24,0x44,0x20
        44 20
   B39B 42 20 42 20 37 04  5681         .byte   0x42,0x20,0x42,0x20,0x37,0x04,0x35,0x20
        35 20
   B3A3 2E 04 2E 04 2D 20  5682         .byte   0x2e,0x04,0x2e,0x04,0x2d,0x20,0x23,0x24
        23 24
   B3AB 21 20 17 24 13 00  5683         .byte   0x21,0x20,0x17,0x24,0x13,0x00,0x11,0x24
        11 24
   B3B3 10 30 07 34 06 30  5684         .byte   0x10,0x30,0x07,0x34,0x06,0x30,0x05,0x30
        05 30
   B3BB FF FF              5685         .byte   0xff,0xff
                           5686 
                           5687 ; board 2
   B3BD                    5688 LB3BD:
   B3BD D7 22 D5 20 C9 22  5689         .byte   0xd7,0x22,0xd5,0x20,0xc9,0x22,0xc7,0x20
        C7 20
   B3C5 C4 24 C3 20 C2 24  5690         .byte   0xc4,0x24,0xc3,0x20,0xc2,0x24,0xc1,0x20
        C1 20
   B3CD BF 24 BF 24 BE 20  5691         .byte   0xbf,0x24,0xbf,0x24,0xbe,0x20,0xbd,0x24
        BD 24
   B3D5 BC 20 BB 24 BA 20  5692         .byte   0xbc,0x20,0xbb,0x24,0xba,0x20,0xb9,0x20
        B9 20
   B3DD B8 24 B7 20 B4 00  5693         .byte   0xb8,0x24,0xb7,0x20,0xb4,0x00,0xb4,0x00
        B4 00
   B3E5 B2 20 A9 20 A3 20  5694         .byte   0xb2,0x20,0xa9,0x20,0xa3,0x20,0xa2,0x20
        A2 20
   B3ED A1 20 A0 20 A0 20  5695         .byte   0xa1,0x20,0xa0,0x20,0xa0,0x20,0x9f,0x20
        9F 20
   B3F5 9F 20 9E 20 9D 24  5696         .byte   0x9f,0x20,0x9e,0x20,0x9d,0x24,0x9d,0x24
        9D 24
   B3FD 9B 20 9A 24 99 20  5697         .byte   0x9b,0x20,0x9a,0x24,0x99,0x20,0x98,0x20
        98 20
   B405 97 24 97 24 95 20  5698         .byte   0x97,0x24,0x97,0x24,0x95,0x20,0x95,0x20
        95 20
   B40D 94 00 94 00 93 20  5699         .byte   0x94,0x00,0x94,0x00,0x93,0x20,0x92,0x00
        92 00
   B415 92 00 91 20 90 20  5700         .byte   0x92,0x00,0x91,0x20,0x90,0x20,0x90,0x20
        90 20
   B41D 8F 20 8D 20 8D 20  5701         .byte   0x8f,0x20,0x8d,0x20,0x8d,0x20,0x81,0x00
        81 00
   B425 7F 20 79 00 79 00  5702         .byte   0x7f,0x20,0x79,0x00,0x79,0x00,0x78,0x20
        78 20
   B42D 76 20 6B 00 69 20  5703         .byte   0x76,0x20,0x6b,0x00,0x69,0x20,0x5e,0x00
        5E 00
   B435 5C 20 5B 30 52 10  5704         .byte   0x5c,0x20,0x5b,0x30,0x52,0x10,0x51,0x30
        51 30
   B43D 50 30 50 30 4F 20  5705         .byte   0x50,0x30,0x50,0x30,0x4f,0x20,0x4e,0x20
        4E 20
   B445 4E 20 4D 20 46 A0  5706         .byte   0x4e,0x20,0x4d,0x20,0x46,0xa0,0x45,0xa0
        45 A0
   B44D 3D A0 3D A0 39 20  5707         .byte   0x3d,0xa0,0x3d,0xa0,0x39,0x20,0x2a,0x00
        2A 00
   B455 28 20 1E 00 1C 22  5708         .byte   0x28,0x20,0x1e,0x00,0x1c,0x22,0x1c,0x22
        1C 22
   B45D 1B 20 1A 22 19 20  5709         .byte   0x1b,0x20,0x1a,0x22,0x19,0x20,0x18,0x22
        18 22
   B465 18 22 16 20 15 22  5710         .byte   0x18,0x22,0x16,0x20,0x15,0x22,0x15,0x22
        15 22
   B46D 14 A0 13 A2 11 A0  5711         .byte   0x14,0xa0,0x13,0xa2,0x11,0xa0,0xff,0xff
        FF FF
                           5712 
                           5713 ; board 4
   B475                    5714 LB475:
   B475 BE 00 BC 22 BB 30  5715         .byte   0xbe,0x00,0xbc,0x22,0xbb,0x30,0xb9,0x32
        B9 32
   B47D B9 32 B7 30 B6 32  5716         .byte   0xb9,0x32,0xb7,0x30,0xb6,0x32,0xb5,0x30
        B5 30
   B485 B4 32 B4 32 B3 20  5717         .byte   0xb4,0x32,0xb4,0x32,0xb3,0x20,0xb3,0x20
        B3 20
   B48D B1 A0 B1 A0 B0 A2  5718         .byte   0xb1,0xa0,0xb1,0xa0,0xb0,0xa2,0xaf,0xa0
        AF A0
   B495 AF A6 AE A0 AE A6  5719         .byte   0xaf,0xa6,0xae,0xa0,0xae,0xa6,0xad,0xa4
        AD A4
   B49D AC A0 AC A0 AB A0  5720         .byte   0xac,0xa0,0xac,0xa0,0xab,0xa0,0xaa,0xa0
        AA A0
   B4A5 AA A0 A2 80 A0 A0  5721         .byte   0xaa,0xa0,0xa2,0x80,0xa0,0xa0,0xa0,0xa0
        A0 A0
   B4AD 8D 80 8A A0 7E 80  5722         .byte   0x8d,0x80,0x8a,0xa0,0x7e,0x80,0x7b,0xa0
        7B A0
   B4B5 79 A4 78 A0 77 A4  5723         .byte   0x79,0xa4,0x78,0xa0,0x77,0xa4,0x76,0xa0
        76 A0
   B4BD 75 A4 74 A0 73 A4  5724         .byte   0x75,0xa4,0x74,0xa0,0x73,0xa4,0x72,0xa0
        72 A0
   B4C5 71 A4 70 A0 6F A4  5725         .byte   0x71,0xa4,0x70,0xa0,0x6f,0xa4,0x6e,0xa0
        6E A0
   B4CD 6D A4 6C A0 69 80  5726         .byte   0x6d,0xa4,0x6c,0xa0,0x69,0x80,0x69,0x80
        69 80
   B4D5 67 A0 5E 20 58 24  5727         .byte   0x67,0xa0,0x5e,0x20,0x58,0x24,0x57,0x20
        57 20
   B4DD 57 20 56 24 55 20  5728         .byte   0x57,0x20,0x56,0x24,0x55,0x20,0x54,0x24
        54 24
   B4E5 54 24 53 20 52 24  5729         .byte   0x54,0x24,0x53,0x20,0x52,0x24,0x52,0x24
        52 24
   B4ED 50 20 4F 24 4E 20  5730         .byte   0x50,0x20,0x4f,0x24,0x4e,0x20,0x4d,0x24
        4D 24
   B4F5 4C 20 4C 20 4B 24  5731         .byte   0x4c,0x20,0x4c,0x20,0x4b,0x24,0x4a,0x20
        4A 20
   B4FD 49 20 49 00 48 20  5732         .byte   0x49,0x20,0x49,0x00,0x48,0x20,0x47,0x20
        47 20
   B505 47 20 46 20 45 24  5733         .byte   0x47,0x20,0x46,0x20,0x45,0x24,0x45,0x24
        45 24
   B50D 44 20 42 20 42 20  5734         .byte   0x44,0x20,0x42,0x20,0x42,0x20,0x37,0x04
        37 04
   B515 35 20 2E 04 2E 04  5735         .byte   0x35,0x20,0x2e,0x04,0x2e,0x04,0x2d,0x20
        2D 20
   B51D 23 24 21 20 17 24  5736         .byte   0x23,0x24,0x21,0x20,0x17,0x24,0x13,0x00
        13 00
   B525 11 24 10 30 07 34  5737         .byte   0x11,0x24,0x10,0x30,0x07,0x34,0x06,0x30
        06 30
   B52D 05 30 FF FF        5738         .byte   0x05,0x30,0xff,0xff
                           5739 
                           5740 ; board 3
   B531                    5741 LB531:
   B531 CD 20 CC 20 CB 20  5742         .byte   0xcd,0x20,0xcc,0x20,0xcb,0x20,0xcb,0x20
        CB 20
   B539 CA 00 C9 20 C9 20  5743         .byte   0xca,0x00,0xc9,0x20,0xc9,0x20,0xc8,0x20
        C8 20
   B541 C1 A0 C0 A0 B8 A0  5744         .byte   0xc1,0xa0,0xc0,0xa0,0xb8,0xa0,0xb8,0x20
        B8 20
   B549 B4 20 A6 00 A4 20  5745         .byte   0xb4,0x20,0xa6,0x00,0xa4,0x20,0x99,0x00
        99 00
   B551 97 22 97 22 96 20  5746         .byte   0x97,0x22,0x97,0x22,0x96,0x20,0x95,0x22
        95 22
   B559 94 20 93 22 93 22  5747         .byte   0x94,0x20,0x93,0x22,0x93,0x22,0x91,0x20
        91 20
   B561 90 20 90 20 8D A0  5748         .byte   0x90,0x20,0x90,0x20,0x8d,0xa0,0x8c,0xa0
        8C A0
   B569 7D A2 7D A2 7B A0  5749         .byte   0x7d,0xa2,0x7d,0xa2,0x7b,0xa0,0x7b,0xa0
        7B A0
   B571 79 A2 79 A2 77 A0  5750         .byte   0x79,0xa2,0x79,0xa2,0x77,0xa0,0x77,0xa0
        77 A0
   B579 76 80 75 A0 6E 20  5751         .byte   0x76,0x80,0x75,0xa0,0x6e,0x20,0x67,0x24
        67 24
   B581 66 20 65 24 64 20  5752         .byte   0x66,0x20,0x65,0x24,0x64,0x20,0x63,0x24
        63 24
   B589 63 24 61 20 60 24  5753         .byte   0x63,0x24,0x61,0x20,0x60,0x24,0x5f,0x20
        5F 20
   B591 5E 20 5D 24 5C 20  5754         .byte   0x5e,0x20,0x5d,0x24,0x5c,0x20,0x5b,0x24
        5B 24
   B599 5A 20 59 24 58 20  5755         .byte   0x5a,0x20,0x59,0x24,0x58,0x20,0x56,0x20
        56 20
   B5A1 55 04 54 00 53 24  5756         .byte   0x55,0x04,0x54,0x00,0x53,0x24,0x52,0x20
        52 20
   B5A9 52 20 4F 24 4F 24  5757         .byte   0x52,0x20,0x4f,0x24,0x4f,0x24,0x4e,0x30
        4E 30
   B5B1 4D 30 47 10 45 30  5758         .byte   0x4d,0x30,0x47,0x10,0x45,0x30,0x35,0x30
        35 30
   B5B9 33 10 31 30 31 30  5759         .byte   0x33,0x10,0x31,0x30,0x31,0x30,0x1d,0x20
        1D 20
   B5C1 FF FF              5760         .byte   0xff,0xff
                           5761 
                           5762 ; board 5
   B5C3                    5763 LB5C3:
   B5C3 A9 20 A3 20 A2 20  5764         .byte   0xa9,0x20,0xa3,0x20,0xa2,0x20,0xa1,0x20
        A1 20
   B5CB A0 20 A0 20 9F 20  5765         .byte   0xa0,0x20,0xa0,0x20,0x9f,0x20,0x9f,0x20
        9F 20
   B5D3 9E 20 9D 24 9D 24  5766         .byte   0x9e,0x20,0x9d,0x24,0x9d,0x24,0x9b,0x20
        9B 20
   B5DB 9A 24 99 20 98 20  5767         .byte   0x9a,0x24,0x99,0x20,0x98,0x20,0x97,0x24
        97 24
   B5E3 97 24 95 20 95 20  5768         .byte   0x97,0x24,0x95,0x20,0x95,0x20,0x94,0x00
        94 00
   B5EB 94 00 93 20 92 00  5769         .byte   0x94,0x00,0x93,0x20,0x92,0x00,0x92,0x00
        92 00
   B5F3 91 20 90 20 90 20  5770         .byte   0x91,0x20,0x90,0x20,0x90,0x20,0x8f,0x20
        8F 20
   B5FB 8D 20 8D 20 81 00  5771         .byte   0x8d,0x20,0x8d,0x20,0x81,0x00,0x7f,0x20
        7F 20
   B603 79 00 79 00 78 20  5772         .byte   0x79,0x00,0x79,0x00,0x78,0x20,0x76,0x20
        76 20
   B60B 6B 00 69 20 5E 00  5773         .byte   0x6b,0x00,0x69,0x20,0x5e,0x00,0x5c,0x20
        5C 20
   B613 5B 30 52 10 51 30  5774         .byte   0x5b,0x30,0x52,0x10,0x51,0x30,0x50,0x30
        50 30
   B61B 50 30 4F 20 4E 20  5775         .byte   0x50,0x30,0x4f,0x20,0x4e,0x20,0x4e,0x20
        4E 20
   B623 4D 20 46 A0 45 A0  5776         .byte   0x4d,0x20,0x46,0xa0,0x45,0xa0,0x3d,0xa0
        3D A0
   B62B 3D A0 39 20 2A 00  5777         .byte   0x3d,0xa0,0x39,0x20,0x2a,0x00,0x28,0x20
        28 20
   B633 1E 00 1C 22 1C 22  5778         .byte   0x1e,0x00,0x1c,0x22,0x1c,0x22,0x1b,0x20
        1B 20
   B63B 1A 22 19 20 18 22  5779         .byte   0x1a,0x22,0x19,0x20,0x18,0x22,0x18,0x22
        18 22
   B643 16 20 15 22 15 22  5780         .byte   0x16,0x20,0x15,0x22,0x15,0x22,0x14,0xa0
        14 A0
   B64B 13 A2 11 A0        5781         .byte   0x13,0xa2,0x11,0xa0
                           5782 
                           5783 ; All empty (0xFFs) in this gap
                           5784 
   F780                    5785         .org    0xF780
                           5786 
                           5787 ; Two Tables used by data protocol handler
                           5788 
   F780                    5789 LF780:
   F780 57 0B 00 00 00 00  5790         .byte   0x57,0x0b,0x00,0x00,0x00,0x00,0x08,0x00
        08 00
   F788 00 00 20 00 00 00  5791         .byte   0x00,0x00,0x20,0x00,0x00,0x00,0x80,0x00
        80 00
   F790 00 00 00 00 00 04  5792         .byte   0x00,0x00,0x00,0x00,0x00,0x04,0x00,0x00
        00 00
   F798 00 10 00 00 00 00  5793         .byte   0x00,0x10,0x00,0x00,0x00,0x00,0x00,0x00
        00 00
                           5794 
   F7A0                    5795 LF7A0:
   F7A0 40 12 20 09 80 24  5796         .byte   0x40,0x12,0x20,0x09,0x80,0x24,0x02,0x00
        02 00
   F7A8 40 12 20 09 80 24  5797         .byte   0x40,0x12,0x20,0x09,0x80,0x24,0x04,0x00
        04 00
   F7B0 00 00 00 00 00 00  5798         .byte   0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
        00 00
   F7B8 00 00 00 00 08 00  5799         .byte   0x00,0x00,0x00,0x00,0x08,0x00,0x00,0x00
        00 00
                           5800 
   F7C0                    5801 LF7C0:
   F7C0 00                 5802         .byte   0x00
                           5803 ;
                           5804 ; All empty (0xFFs) in this gap
                           5805 ;
   F800                    5806         .org    0xF800
                           5807 ; Reset
   F800                    5808 RESET:
   F800 0F            [ 2] 5809         sei                     ; disable interrupts
   F801 86 03         [ 2] 5810         ldaa    #0x03
   F803 B7 10 24      [ 4] 5811         staa    TMSK2           ; disable irqs, set prescaler to 16
   F806 86 80         [ 2] 5812         ldaa    #0x80
   F808 B7 10 22      [ 4] 5813         staa    TMSK1           ; enable OC1 irq
   F80B 86 FE         [ 2] 5814         ldaa    #0xFE
   F80D B7 10 35      [ 4] 5815         staa    BPROT           ; protect everything except $xE00-$xE1F
   F810 96 07         [ 3] 5816         ldaa    0x0007          ;
   F812 81 DB         [ 2] 5817         cmpa    #0xDB           ; special unprotect mode???
   F814 26 06         [ 3] 5818         bne     LF81C           ; if not, jump ahead
   F816 7F 10 35      [ 6] 5819         clr     BPROT           ; else unprotect everything
   F819 7F 00 07      [ 6] 5820         clr     0x0007          ; reset special unprotect mode???
   F81C                    5821 LF81C:
   F81C 8E 01 FF      [ 3] 5822         lds     #0x01FF         ; init SP
   F81F 86 A5         [ 2] 5823         ldaa    #0xA5
   F821 B7 10 5D      [ 4] 5824         staa    CSCTL           ; enable external IO:
                           5825                                 ; IO1EN,  BUSSEL, active LOW
                           5826                                 ; IO2EN,  PIA/SCCSEL, active LOW
                           5827                                 ; CSPROG, ROMSEL priority over RAMSEL 
                           5828                                 ; CSPROG, ROMSEL enabled, 32K, $8000-$FFFF
   F824 86 01         [ 2] 5829         ldaa    #0x01
   F826 B7 10 5F      [ 4] 5830         staa    CSGSIZ          ; CSGEN,  RAMSEL active low
                           5831                                 ; CSGEN,  RAMSEL 32K
   F829 86 00         [ 2] 5832         ldaa    #0x00
   F82B B7 10 5E      [ 4] 5833         staa    CSGADR          ; CSGEN,  RAMSEL = $0000-$7FFF (except internal regs)
   F82E 86 F0         [ 2] 5834         ldaa    #0xF0
   F830 B7 10 5C      [ 4] 5835         staa    CSSTRH          ; 3 cycle clock stretching on BUSSEL and LCRS
   F833 7F 00 00      [ 6] 5836         clr     0x0000          ; ????? Done with basic init?
                           5837 
                           5838 ; Initialize Main PIA
   F836 86 30         [ 2] 5839         ldaa    #0x30           ;
   F838 B7 18 05      [ 4] 5840         staa    PIA0CRA         ; control register A, CA2=0, sel DDRA
   F83B B7 18 07      [ 4] 5841         staa    PIA0CRB         ; control register B, CB2=0, sel DDRB
   F83E 86 FF         [ 2] 5842         ldaa    #0xFF
   F840 B7 18 06      [ 4] 5843         staa    PIA0DDRB        ; select B0-B7 to be outputs
   F843 86 78         [ 2] 5844         ldaa    #0x78           ;
   F845 B7 18 04      [ 4] 5845         staa    PIA0DDRA        ; select A3-A6 to be outputs
   F848 86 34         [ 2] 5846         ldaa    #0x34           ;
   F84A B7 18 05      [ 4] 5847         staa    PIA0CRA         ; select output register A
   F84D B7 18 07      [ 4] 5848         staa    PIA0CRB         ; select output register B
   F850 C6 FF         [ 2] 5849         ldab    #0xFF
   F852 BD F9 C5      [ 6] 5850         jsr     BUTNLIT         ; turn on all button lights
   F855 20 13         [ 3] 5851         bra     LF86A           ; jump past data table
                           5852 
                           5853 ; Data loaded into SCCCTRLB SCC
   F857                    5854 LF857:
   F857 09 4A              5855         .byte   0x09,0x4a       ; channel reset B, MIE off, DLC on, no vector
   F859 01 10              5856         .byte   0x01,0x10       ; irq on all character received
   F85B 0C 18              5857         .byte   0x0c,0x18       ; Lower byte of time constant
   F85D 0D 00              5858         .byte   0x0d,0x00       ; Upper byte of time constant
   F85F 04 44              5859         .byte   0x04,0x44       ; X16 clock mode, 8-bit sync char, 1 stop bit, no parity
   F861 0E 63              5860         .byte   0x0e,0x63       ; Disable DPLL, BR enable & source
   F863 05 68              5861         .byte   0x05,0x68       ; No DTR/RTS, Tx 8 bits/char, Tx enable
   F865 0B 56              5862         .byte   0x0b,0x56       ; Rx & Tx & TRxC clk from BR gen
   F867 03 C1              5863         .byte   0x03,0xc1       ; Rx 8 bits/char, Rx Enable
                           5864         ;   tc = 4Mhz / (2 * DesiredRate * BRClockPeriod) - 2
                           5865         ;   DesiredRate=~4800 bps with tc=0x18 and BRClockPeriod=16
   F869 FF                 5866         .byte   0xff            ; end of table marker
                           5867 
                           5868 ; init SCC (8530)
   F86A                    5869 LF86A:
   F86A CE F8 57      [ 3] 5870         ldx     #LF857
   F86D                    5871 LF86D:
   F86D A6 00         [ 4] 5872         ldaa    0,X
   F86F 81 FF         [ 2] 5873         cmpa    #0xFF
   F871 27 06         [ 3] 5874         beq     LF879
   F873 B7 18 0D      [ 4] 5875         staa    SCCCTRLB
   F876 08            [ 3] 5876         inx
   F877 20 F4         [ 3] 5877         bra     LF86D
                           5878 
                           5879 ; Setup normal SCI, 8 data bits, 1 stop bit
                           5880 ; Interrupts disabled, Transmitter and Receiver enabled
                           5881 ; prescaler = /13, SCR=/2, rate = 9600 baud at 16Mhz clock
                           5882 
   F879                    5883 LF879:
   F879 86 00         [ 2] 5884         ldaa    #0x00
   F87B B7 10 2C      [ 4] 5885         staa    SCCR1  
   F87E 86 0C         [ 2] 5886         ldaa    #0x0C
   F880 B7 10 2D      [ 4] 5887         staa    SCCR2  
   F883 86 31         [ 2] 5888         ldaa    #0x31
   F885 B7 10 2B      [ 4] 5889         staa    BAUD  
                           5890 
                           5891 ; Initialize all RAM vectors to RTI: 
                           5892 ; Opcode 0x3b into vectors at 0x0100 through 0x0139
                           5893 
   F888 CE 01 00      [ 3] 5894         ldx     #0x0100
   F88B 86 3B         [ 2] 5895         ldaa    #0x3B           ; RTI opcode
   F88D                    5896 LF88D:
   F88D A7 00         [ 4] 5897         staa    0,X
   F88F 08            [ 3] 5898         inx
   F890 08            [ 3] 5899         inx
   F891 08            [ 3] 5900         inx
   F892 8C 01 3C      [ 4] 5901         cpx     #0x013C
   F895 25 F6         [ 3] 5902         bcs     LF88D
   F897 C6 F0         [ 2] 5903         ldab    #0xF0
   F899 F7 18 04      [ 4] 5904         stab    PIA0PRA         ; enable LCD backlight, disable RESET button light
   F89C 86 7E         [ 2] 5905         ldaa    #0x7E
   F89E 97 03         [ 3] 5906         staa    (0x0003)        ; Put a jump instruction here???
                           5907 
                           5908 ; Non-destructive ram test:
                           5909 ;
                           5910 ; HC11 Internal RAM: 0x0000-0x3ff
                           5911 ; External NVRAM:    0x2000-0x7fff
                           5912 ;
                           5913 ; Note:
                           5914 ; External NVRAM:    0x0400-0xfff is also available, but not tested
                           5915 
   F8A0 CE 00 00      [ 3] 5916         ldx     #0x0000
   F8A3                    5917 LF8A3:
   F8A3 E6 00         [ 4] 5918         ldab    0,X             ; save value
   F8A5 86 55         [ 2] 5919         ldaa    #0x55
   F8A7 A7 00         [ 4] 5920         staa    0,X
   F8A9 A1 00         [ 4] 5921         cmpa    0,X
   F8AB 26 19         [ 3] 5922         bne     LF8C6
   F8AD 49            [ 2] 5923         rola
   F8AE A7 00         [ 4] 5924         staa    0,X
   F8B0 A1 00         [ 4] 5925         cmpa    0,X
   F8B2 26 12         [ 3] 5926         bne     LF8C6
   F8B4 E7 00         [ 4] 5927         stab    0,X             ; restore value
   F8B6 08            [ 3] 5928         inx
   F8B7 8C 04 00      [ 4] 5929         cpx     #0x0400
   F8BA 26 03         [ 3] 5930         bne     LF8BF
   F8BC CE 20 00      [ 3] 5931         ldx     #0x2000
   F8BF                    5932 LF8BF:  
   F8BF 8C 80 00      [ 4] 5933         cpx     #0x8000
   F8C2 26 DF         [ 3] 5934         bne     LF8A3
   F8C4 20 04         [ 3] 5935         bra     LF8CA
                           5936 
   F8C6                    5937 LF8C6:
   F8C6 86 01         [ 2] 5938         ldaa    #0x01           ; Mark Failed RAM test
   F8C8 97 00         [ 3] 5939         staa    (0x0000)
                           5940 ; 
   F8CA                    5941 LF8CA:
   F8CA C6 01         [ 2] 5942         ldab    #0x01
   F8CC BD F9 95      [ 6] 5943         jsr     DIAGDGT         ; write digit 1 to diag display
   F8CF B6 10 35      [ 4] 5944         ldaa    BPROT  
   F8D2 26 0F         [ 3] 5945         bne     LF8E3           ; if something is protected, jump ahead
   F8D4 B6 30 00      [ 4] 5946         ldaa    (0x3000)        ; NVRAM
   F8D7 81 7E         [ 2] 5947         cmpa    #0x7E
   F8D9 26 08         [ 3] 5948         bne     LF8E3           ; if RAM(0x3000) == 0x7E, jump ahead anyway (special unlock?)
                           5949 
                           5950 ; error?
   F8DB C6 0E         [ 2] 5951         ldab    #0x0E
   F8DD BD F9 95      [ 6] 5952         jsr     DIAGDGT         ; write digit E to diag display
   F8E0 7E 30 00      [ 3] 5953         jmp     (0x3000)        ; jump to routine in NVRAM?
                           5954 
                           5955 ; checking for serial connection
                           5956 
   F8E3                    5957 LF8E3:
   F8E3 CE F0 00      [ 3] 5958         ldx     #0xF000         ; timeout counter
   F8E6                    5959 LF8E6:
   F8E6 01            [ 2] 5960         nop
   F8E7 01            [ 2] 5961         nop
   F8E8 09            [ 3] 5962         dex
   F8E9 27 0B         [ 3] 5963         beq     LF8F6           ; if time is up, jump ahead
   F8EB BD F9 45      [ 6] 5964         jsr     SERIALR         ; else read serial data if available
   F8EE 24 F6         [ 3] 5965         bcc     LF8E6           ; if no data available, loop
   F8F0 81 1B         [ 2] 5966         cmpa    #0x1B           ; if serial data was read, is it an ESC?
   F8F2 27 29         [ 3] 5967         beq     LF91D           ; if so, jump to echo hex char routine?
   F8F4 20 F0         [ 3] 5968         bra     LF8E6           ; else loop
   F8F6                    5969 LF8F6:
   F8F6 B6 80 00      [ 4] 5970         ldaa    L8000           ; check if this is a regular rom?
   F8F9 81 7E         [ 2] 5971         cmpa    #0x7E        
   F8FB 26 0B         [ 3] 5972         bne     MINIMON         ; if not, jump ahead
                           5973 
   F8FD C6 0A         [ 2] 5974         ldab    #0x0A
   F8FF BD F9 95      [ 6] 5975         jsr     DIAGDGT         ; else write digit A to diag display
                           5976 
   F902 BD 80 00      [ 6] 5977         jsr     L8000           ; jump to start of rom routine
   F905 0F            [ 2] 5978         sei                     ; if we ever come return, just loop and do it all again
   F906 20 EE         [ 3] 5979         bra     LF8F6
                           5980 
                           5981 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           5982 
   F908                    5983 MINIMON:
   F908 C6 10         [ 2] 5984         ldab    #0x10           ; not a regular rom
   F90A BD F9 95      [ 6] 5985         jsr     DIAGDGT         ; blank the diag display
                           5986 
   F90D BD F9 D8      [ 6] 5987         jsr     SERMSGW         ; enter the mini-monitor???
   F910 4D 49 4E 49 2D 4D  5988         .ascis  'MINI-MON'
        4F CE
                           5989 
   F918 C6 10         [ 2] 5990         ldab    #0x10
   F91A BD F9 95      [ 6] 5991         jsr     DIAGDGT         ; blank the diag display
                           5992 
   F91D                    5993 LF91D:
   F91D 7F 00 05      [ 6] 5994         clr     (0x0005)
   F920 7F 00 04      [ 6] 5995         clr     (0x0004)
   F923 7F 00 02      [ 6] 5996         clr     (0x0002)
   F926 7F 00 06      [ 6] 5997         clr     (0x0006)
                           5998 
   F929 BD F9 D8      [ 6] 5999         jsr     SERMSGW
   F92C 0D 0A BE           6000         .ascis  '\r\n>'
                           6001 
                           6002 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           6003 
                           6004 ; convert A to 2 hex digits and transmit
   F92F                    6005 SERHEXW:
   F92F 36            [ 3] 6006         psha
   F930 44            [ 2] 6007         lsra
   F931 44            [ 2] 6008         lsra
   F932 44            [ 2] 6009         lsra
   F933 44            [ 2] 6010         lsra
   F934 BD F9 38      [ 6] 6011         jsr     LF938
   F937 32            [ 4] 6012         pula
   F938                    6013 LF938:
   F938 84 0F         [ 2] 6014         anda    #0x0F
   F93A 8A 30         [ 2] 6015         oraa    #0x30
   F93C 81 3A         [ 2] 6016         cmpa    #0x3A
   F93E 25 02         [ 3] 6017         bcs     LF942
   F940 8B 07         [ 2] 6018         adda    #0x07
   F942                    6019 LF942:
   F942 7E F9 6F      [ 3] 6020         jmp     SERIALW
                           6021 
                           6022 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           6023 
                           6024 ; serial read non-blocking
   F945                    6025 SERIALR:
   F945 B6 10 2E      [ 4] 6026         ldaa    SCSR  
   F948 85 20         [ 2] 6027         bita    #0x20
   F94A 26 09         [ 3] 6028         bne     LF955
   F94C 0C            [ 2] 6029         clc
   F94D 39            [ 5] 6030         rts
                           6031 
                           6032 ; serial blocking read
   F94E                    6033 SERBLKR:
   F94E B6 10 2E      [ 4] 6034         ldaa    SCSR            ; read serial status
   F951 85 20         [ 2] 6035         bita    #0x20
   F953 27 F9         [ 3] 6036         beq     SERBLKR         ; if RDRF=0, loop
                           6037 
                           6038 ; read serial data, (assumes it's ready)
   F955                    6039 LF955:
   F955 B6 10 2E      [ 4] 6040         ldaa    SCSR            ; read serial status
   F958 85 02         [ 2] 6041         bita    #0x02
   F95A 26 09         [ 3] 6042         bne     LF965           ; if FE=1, clear it
   F95C 85 08         [ 2] 6043         bita    #0x08
   F95E 26 05         [ 3] 6044         bne     LF965           ; if OR=1, clear it
   F960 B6 10 2F      [ 4] 6045         ldaa    SCDR            ; otherwise, good data
   F963 0D            [ 2] 6046         sec
   F964 39            [ 5] 6047         rts
                           6048 
   F965                    6049 LF965:
   F965 B6 10 2F      [ 4] 6050         ldaa    SCDR            ; clear any error
   F968 86 2F         [ 2] 6051         ldaa    #0x2F           ; '/'   
   F96A BD F9 6F      [ 6] 6052         jsr     SERIALW
   F96D 20 DF         [ 3] 6053         bra     SERBLKR         ; go to wait for a character
                           6054 
                           6055 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           6056 
                           6057 ; Send A to SCI with CR turned to CRLF
   F96F                    6058 SERIALW:
   F96F 81 0D         [ 2] 6059         cmpa    #0x0D           ; CR?
   F971 27 02         [ 3] 6060         beq     LF975           ; if so echo CR+LF
   F973 20 07         [ 3] 6061         bra     SERRAWW         ; else just echo it
   F975                    6062 LF975:
   F975 86 0D         [ 2] 6063         ldaa    #0x0D
   F977 BD F9 7C      [ 6] 6064         jsr     SERRAWW
   F97A 86 0A         [ 2] 6065         ldaa    #0x0A
                           6066 
                           6067 ; send a char to SCI
   F97C                    6068 SERRAWW:
   F97C F6 10 2E      [ 4] 6069         ldab    SCSR            ; wait for ready to send
   F97F C5 40         [ 2] 6070         bitb    #0x40
   F981 27 F9         [ 3] 6071         beq     SERRAWW
   F983 B7 10 2F      [ 4] 6072         staa    SCDR            ; send it
   F986 39            [ 5] 6073         rts
                           6074 
                           6075 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           6076 
                           6077 ; Unused?
   F987                    6078 LF987:
   F987 BD F9 4E      [ 6] 6079         jsr     SERBLKR         ; get a serial char
   F98A 81 7A         [ 2] 6080         cmpa    #0x7A           ;'z'
   F98C 22 06         [ 3] 6081         bhi     LF994
   F98E 81 61         [ 2] 6082         cmpa    #0x61           ;'a'
   F990 25 02         [ 3] 6083         bcs     LF994
   F992 82 20         [ 2] 6084         sbca    #0x20           ;convert to upper case?
   F994                    6085 LF994:
   F994 39            [ 5] 6086         rts
                           6087 
                           6088 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           6089 
                           6090 ; Write hex digit arg in B to diagnostic lights
                           6091 ; or B=0x10 or higher for blank
                           6092 
   F995                    6093 DIAGDGT:
   F995 36            [ 3] 6094         psha
   F996 C1 11         [ 2] 6095         cmpb    #0x11
   F998 25 02         [ 3] 6096         bcs     LF99C
   F99A C6 10         [ 2] 6097         ldab    #0x10
   F99C                    6098 LF99C:
   F99C CE F9 B4      [ 3] 6099         ldx     #LF9B4
   F99F 3A            [ 3] 6100         abx
   F9A0 A6 00         [ 4] 6101         ldaa    0,X
   F9A2 B7 18 06      [ 4] 6102         staa    PIA0PRB         ; write arg to local data bus
   F9A5 B6 18 04      [ 4] 6103         ldaa    PIA0PRA         ; read from Port A
   F9A8 8A 20         [ 2] 6104         oraa    #0x20           ; bit 5 high
   F9AA B7 18 04      [ 4] 6105         staa    PIA0PRA         ; write back to Port A
   F9AD 84 DF         [ 2] 6106         anda    #0xDF           ; bit 5 low
   F9AF B7 18 04      [ 4] 6107         staa    PIA0PRA         ; write back to Port A
   F9B2 32            [ 4] 6108         pula
   F9B3 39            [ 5] 6109         rts
                           6110 
                           6111 ; 7 segment patterns - XGFEDCBA
   F9B4                    6112 LF9B4:
   F9B4 C0                 6113         .byte   0xc0            ; 0
   F9B5 F9                 6114         .byte   0xf9            ; 1
   F9B6 A4                 6115         .byte   0xa4            ; 2
   F9B7 B0                 6116         .byte   0xb0            ; 3
   F9B8 99                 6117         .byte   0x99            ; 4
   F9B9 92                 6118         .byte   0x92            ; 5
   F9BA 82                 6119         .byte   0x82            ; 6
   F9BB F8                 6120         .byte   0xf8            ; 7
   F9BC 80                 6121         .byte   0x80            ; 8
   F9BD 90                 6122         .byte   0x90            ; 9
   F9BE 88                 6123         .byte   0x88            ; A 
   F9BF 83                 6124         .byte   0x83            ; b
   F9C0 C6                 6125         .byte   0xc6            ; C
   F9C1 A1                 6126         .byte   0xa1            ; d
   F9C2 86                 6127         .byte   0x86            ; E
   F9C3 8E                 6128         .byte   0x8e            ; F
   F9C4 FF                 6129         .byte   0xff            ; blank
                           6130 
                           6131 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           6132 
                           6133 ; Write arg in B to Button Lights
   F9C5                    6134 BUTNLIT:
   F9C5 36            [ 3] 6135         psha
   F9C6 F7 18 06      [ 4] 6136         stab    PIA0PRB         ; write arg to local data bus
   F9C9 B6 18 04      [ 4] 6137         ldaa    PIA0PRA         ; read from Port A
   F9CC 84 EF         [ 2] 6138         anda    #0xEF           ; bit 4 low
   F9CE B7 18 04      [ 4] 6139         staa    PIA0PRA         ; write back to Port A
   F9D1 8A 10         [ 2] 6140         oraa    #0x10           ; bit 4 high
   F9D3 B7 18 04      [ 4] 6141         staa    PIA0PRA         ; write this to Port A
   F9D6 32            [ 4] 6142         pula
   F9D7 39            [ 5] 6143         rts
                           6144 
                           6145 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           6146 
                           6147 ; Send rom message via SCI
   F9D8                    6148 SERMSGW:
   F9D8 18 38         [ 6] 6149         puly
   F9DA                    6150 LF9DA:
   F9DA 18 A6 00      [ 5] 6151         ldaa    0,Y
   F9DD 27 09         [ 3] 6152         beq     LF9E8           ; if zero terminated, return
   F9DF 2B 0C         [ 3] 6153         bmi     LF9ED           ; if high bit set..do last char and return
   F9E1 BD F9 7C      [ 6] 6154         jsr     SERRAWW         ; else send char
   F9E4 18 08         [ 4] 6155         iny
   F9E6 20 F2         [ 3] 6156         bra     LF9DA           ; and loop for next one
                           6157 
   F9E8                    6158 LF9E8:
   F9E8 18 08         [ 4] 6159         iny                     ; setup return address and return
   F9EA 18 3C         [ 5] 6160         pshy
   F9EC 39            [ 5] 6161         rts
                           6162 
   F9ED                    6163 LF9ED:
   F9ED 84 7F         [ 2] 6164         anda    #0x7F           ; remove top bit
   F9EF BD F9 7C      [ 6] 6165         jsr     SERRAWW         ; send char
   F9F2 20 F4         [ 3] 6166         bra     LF9E8           ; and we're done
   F9F4 39            [ 5] 6167         rts
                           6168 
   F9F5                    6169 DORTS:
   F9F5 39            [ 5] 6170         rts
   F9F6                    6171 DORTI:        
   F9F6 3B            [12] 6172         rti
                           6173 
                           6174 ; all 0xffs in this gap
                           6175 
   FFA0                    6176         .org    0xFFA0
                           6177 
   FFA0 7E F9 F5      [ 3] 6178         jmp     DORTS
   FFA3 7E F9 F5      [ 3] 6179         jmp     DORTS
   FFA6 7E F9 F5      [ 3] 6180         jmp     DORTS
   FFA9 7E F9 2F      [ 3] 6181         jmp     SERHEXW
   FFAC 7E F9 D8      [ 3] 6182         jmp     SERMSGW      
   FFAF 7E F9 45      [ 3] 6183         jmp     SERIALR     
   FFB2 7E F9 6F      [ 3] 6184         jmp     SERIALW      
   FFB5 7E F9 08      [ 3] 6185         jmp     MINIMON
   FFB8 7E F9 95      [ 3] 6186         jmp     DIAGDGT 
   FFBB 7E F9 C5      [ 3] 6187         jmp     BUTNLIT 
                           6188 
   FFBE FF                 6189        .byte    0xff
   FFBF FF                 6190        .byte    0xff
                           6191 
                           6192 ; Vectors
                           6193 
   FFC0 F9 F6              6194        .word   DORTI            ; Stub RTI
   FFC2 F9 F6              6195        .word   DORTI            ; Stub RTI
   FFC4 F9 F6              6196        .word   DORTI            ; Stub RTI
   FFC6 F9 F6              6197        .word   DORTI            ; Stub RTI
   FFC8 F9 F6              6198        .word   DORTI            ; Stub RTI
   FFCA F9 F6              6199        .word   DORTI            ; Stub RTI
   FFCC F9 F6              6200        .word   DORTI            ; Stub RTI
   FFCE F9 F6              6201        .word   DORTI            ; Stub RTI
   FFD0 F9 F6              6202        .word   DORTI            ; Stub RTI
   FFD2 F9 F6              6203        .word   DORTI            ; Stub RTI
   FFD4 F9 F6              6204        .word   DORTI            ; Stub RTI
                           6205 
   FFD6 01 00              6206         .word  0x0100           ; SCI
   FFD8 01 03              6207         .word  0x0103           ; SPI
   FFDA 01 06              6208         .word  0x0106           ; PA accum. input edge
   FFDC 01 09              6209         .word  0x0109           ; PA Overflow
                           6210 
   FFDE F9 F6              6211         .word  DORTI            ; Stub RTI
                           6212 
   FFE0 01 0C              6213         .word  0x010c           ; TI4O5
   FFE2 01 0F              6214         .word  0x010f           ; TOC4
   FFE4 01 12              6215         .word  0x0112           ; TOC3
   FFE6 01 15              6216         .word  0x0115           ; TOC2
   FFE8 01 18              6217         .word  0x0118           ; TOC1
   FFEA 01 1B              6218         .word  0x011b           ; TIC3
   FFEC 01 1E              6219         .word  0x011e           ; TIC2
   FFEE 01 21              6220         .word  0x0121           ; TIC1
   FFF0 01 24              6221         .word  0x0124           ; RTI
   FFF2 01 27              6222         .word  0x0127           ; ~IRQ
   FFF4 01 2A              6223         .word  0x012a           ; XIRQ
   FFF6 01 2D              6224         .word  0x012d           ; SWI
   FFF8 01 30              6225         .word  0x0130           ; ILLEGAL OPCODE
   FFFA 01 33              6226         .word  0x0133           ; COP Failure
   FFFC 01 36              6227         .word  0x0136           ; COP Clock Monitor Fail
                           6228 
   FFFE F8 00              6229         .word  RESET            ; Reset
                           6230 
