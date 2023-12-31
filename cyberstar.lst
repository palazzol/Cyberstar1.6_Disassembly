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
   81BD F6 10 2D      [ 4]  290         ldab    SCCR2           ; disable receive data interrupts
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
   81E9 BD A2 DF      [ 6]  307         jsr     LA2DF           ; was I called from jsr 0x8000?
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
   8280 7E F8 00      [ 3]  367         jmp     RESET       ; reset controller
   8283                     368 L8283:
   8283 B6 18 04      [ 4]  369         ldaa    PIA0PRA 
   8286 84 06         [ 2]  370         anda    #0x06
   8288 26 08         [ 3]  371         bne     L8292
   828A BD 9C F1      [ 6]  372         jsr     L9CF1       ; print credits
   828D C6 32         [ 2]  373         ldab    #0x32
   828F BD 8C 22      [ 6]  374         jsr     DLYSECSBY100       ; delay 0.5 sec
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
   82A4 81 44         [ 2]  386         cmpa    #0x44       ;'$'
   82A6 26 03         [ 3]  387         bne     L82AB
   82A8 7E A3 66      [ 3]  388         jmp     LA366       ; go to security code & setup utility
   82AB                     389 L82AB:
   82AB 81 53         [ 2]  390         cmpa    #0x53       ;'S'
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
   8328 86 01         [ 2]  405         ldaa    #0x01       ; enable EEPROM erase
   832A B7 04 0F      [ 4]  406         staa    ERASEFLG
   832D 86 DB         [ 2]  407         ldaa    #0xDB
   832F 97 07         [ 3]  408         staa    (0x0007)
                            409 ; need to reset to get out of this 
   8331 20 FE         [ 3]  410 L8331:  bra     L8331       ; infinite loop
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
   85EC BD 8C 22      [ 6]  739         jsr     DLYSECSBY100           ; delay 0.3 sec
   85EF 7F 00 30      [ 6]  740         clr     (0x0030)
   85F2 20 0B         [ 3]  741         bra     L85FF
   85F4                     742 L85F4:
   85F4 BD AA 1D      [ 6]  743         jsr     LAA1D
   85F7 C6 1E         [ 2]  744         ldab    #0x1E
   85F9 BD 8C 22      [ 6]  745         jsr     DLYSECSBY100           ; delay 0.3 sec
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
   866D BD 8C 22      [ 6]  799         jsr     DLYSECSBY100           ; delay 0.3 sec
   8670 7F 00 31      [ 6]  800         clr     (0x0031)
   8673 20 0B         [ 3]  801         bra     L8680
   8675                     802 L8675:
   8675 BD AA 13      [ 6]  803         jsr     LAA13
   8678 C6 1E         [ 2]  804         ldab    #0x1E
   867A BD 8C 22      [ 6]  805         jsr     DLYSECSBY100           ; delay 0.3 sec
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
   86C9 A7 01         [ 4]  853         staa    1,X         ; 0x30 -> PIAxCRA, CA2 low, DDR
   86CB A7 03         [ 4]  854         staa    3,X         ; 0x30 -> PIAxCRB, CB2 low, DDR
   86CD 86 FF         [ 2]  855         ldaa    #0xFF
   86CF A7 00         [ 4]  856         staa    0,X         ; 0xFF -> PIAxDDRA, all outputs
   86D1 A7 02         [ 4]  857         staa    2,X         ; 0xFF -> PIAxDDRB, all outputs
   86D3 86 34         [ 2]  858         ldaa    #0x34
   86D5 A7 01         [ 4]  859         staa    1,X         ; 0x34 -> PIAxCRA, CA2 low, PR
   86D7 A7 03         [ 4]  860         staa    3,X         ; 0x34 -> PIAxCRB, CA2 low, PR
   86D9 6F 00         [ 6]  861         clr     0,X         ; 0x00 -> PIAxPRA, all outputs low
   86DB 6F 02         [ 6]  862         clr     2,X         ; 0x00 -> PIAxPRB, all outputs low
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
   87D2 09 8A              1017         .byte   0x09,0x8a
   87D4 01 00              1018         .byte   0x01,0x00
   87D6 0C 18              1019         .byte   0x0c,0x18 
   87D8 0D 00              1020         .byte   0x0d,0x00
   87DA 04 44              1021         .byte   0x04,0x44
   87DC 0E 63              1022         .byte   0x0e,0x63
   87DE 05 68              1023         .byte   0x05,0x68
   87E0 0B 56              1024         .byte   0x0b,0x56
   87E2 03 C1              1025         .byte   0x03,0xc1
   87E4 0F 00              1026         .byte   0x0f,0x00
   87E6 FF FF              1027         .byte   0xff,0xff
                           1028 
                           1029 ; SCC init, aux serial
   87E8                    1030 L87E8:
   87E8 CE F8 57      [ 3] 1031         ldx     #LF857
   87EB                    1032 L87EB:
   87EB A6 00         [ 4] 1033         ldaa    0,X
   87ED 81 FF         [ 2] 1034         cmpa    #0xFF
   87EF 27 0C         [ 3] 1035         beq     L87FD
   87F1 08            [ 3] 1036         inx
   87F2 B7 18 0C      [ 4] 1037         staa    SCCCTRLA
   87F5 A6 00         [ 4] 1038         ldaa    0,X
   87F7 08            [ 3] 1039         inx
   87F8 B7 18 0C      [ 4] 1040         staa    SCCCTRLA
   87FB 20 EE         [ 3] 1041         bra     L87EB
   87FD                    1042 L87FD:
   87FD 20 16         [ 3] 1043         bra     L8815
                           1044 
                           1045 ; data table for aux serial config
   87FF 09 8A              1046         .byte   0x09,0x8a
   8801 01 10              1047         .byte   0x01,0x10
   8803 0C 18              1048         .byte   0x0c,0x18
   8805 0D 00              1049         .byte   0x0d,0x00
   8807 04 04              1050         .byte   0x04,0x04
   8809 0E 63              1051         .byte   0x0e,0x63
   880B 05 68              1052         .byte   0x05,0x68
   880D 0B 01              1053         .byte   0x0b,0x01
   880F 03 C1              1054         .byte   0x03,0xc1
   8811 0F 00              1055         .byte   0x0f,0x00
   8813 FF FF              1056         .byte   0xff,0xff
                           1057 
                           1058 ; Install IRQ and SCI interrupt handlers
   8815                    1059 L8815:
   8815 CE 88 3E      [ 3] 1060         ldx     #L883E      ; Install IRQ interrupt handler
   8818 FF 01 28      [ 5] 1061         stx     (0x0128)
   881B 86 7E         [ 2] 1062         ldaa    #0x7E
   881D B7 01 27      [ 4] 1063         staa    (0x0127)
   8820 CE 88 32      [ 3] 1064         ldx     #L8832      ; Install SCI interrupt handler
   8823 FF 01 01      [ 5] 1065         stx     (0x0101)
   8826 B7 01 00      [ 4] 1066         staa    (0x0100)
   8829 B6 10 2D      [ 4] 1067         ldaa    SCCR2  
   882C 8A 20         [ 2] 1068         oraa    #0x20
   882E B7 10 2D      [ 4] 1069         staa    SCCR2  
   8831 39            [ 5] 1070         rts
                           1071 
                           1072 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1073 
                           1074 ; SCI Interrupt handler, normal serial
                           1075 
   8832                    1076 L8832:
   8832 B6 10 2E      [ 4] 1077         ldaa    SCSR
   8835 B6 10 2F      [ 4] 1078         ldaa    SCDR
   8838 7C 00 48      [ 6] 1079         inc     (0x0048)
   883B 7E 88 62      [ 3] 1080         jmp     L8862
                           1081 
                           1082 ; IRQ Interrupt handler, aux serial
                           1083 
   883E                    1084 L883E:
   883E 86 01         [ 2] 1085         ldaa    #0x01
   8840 B7 18 0C      [ 4] 1086         staa    SCCCTRLA
   8843 B6 18 0C      [ 4] 1087         ldaa    SCCCTRLA
   8846 84 70         [ 2] 1088         anda    #0x70
   8848 26 1F         [ 3] 1089         bne     L8869  
   884A 86 0A         [ 2] 1090         ldaa    #0x0A
   884C B7 18 0C      [ 4] 1091         staa    SCCCTRLA
   884F B6 18 0C      [ 4] 1092         ldaa    SCCCTRLA
   8852 84 C0         [ 2] 1093         anda    #0xC0
   8854 26 22         [ 3] 1094         bne     L8878  
   8856 B6 18 0C      [ 4] 1095         ldaa    SCCCTRLA
   8859 44            [ 2] 1096         lsra
   885A 24 35         [ 3] 1097         bcc     L8891  
   885C 7C 00 48      [ 6] 1098         inc     (0x0048)
   885F B6 18 0E      [ 4] 1099         ldaa    SCCDATAA
   8862                    1100 L8862:
   8862 BD F9 6F      [ 6] 1101         jsr     SERIALW      
   8865 97 4A         [ 3] 1102         staa    (0x004A)
   8867 20 2D         [ 3] 1103         bra     L8896  
   8869                    1104 L8869:
   8869 B6 18 0E      [ 4] 1105         ldaa    SCCDATAA
   886C 86 30         [ 2] 1106         ldaa    #0x30
   886E B7 18 0C      [ 4] 1107         staa    SCCCTRLA
   8871 86 07         [ 2] 1108         ldaa    #0x07
   8873 BD F9 6F      [ 6] 1109         jsr     SERIALW      
   8876 0C            [ 2] 1110         clc
   8877 3B            [12] 1111         rti
                           1112 
   8878                    1113 L8878:
   8878 86 07         [ 2] 1114         ldaa    #0x07
   887A BD F9 6F      [ 6] 1115         jsr     SERIALW      
   887D 86 0E         [ 2] 1116         ldaa    #0x0E
   887F B7 18 0C      [ 4] 1117         staa    SCCCTRLA
   8882 86 43         [ 2] 1118         ldaa    #0x43
   8884 B7 18 0C      [ 4] 1119         staa    SCCCTRLA
   8887 B6 18 0E      [ 4] 1120         ldaa    SCCDATAA
   888A 86 07         [ 2] 1121         ldaa    #0x07
   888C BD F9 6F      [ 6] 1122         jsr     SERIALW      
   888F 0D            [ 2] 1123         sec
   8890 3B            [12] 1124         rti
                           1125 
   8891                    1126 L8891:
   8891 B6 18 0E      [ 4] 1127         ldaa    SCCDATAA
   8894 0C            [ 2] 1128         clc
   8895 3B            [12] 1129         rti
                           1130 
   8896                    1131 L8896:
   8896 84 7F         [ 2] 1132         anda    #0x7F
   8898 81 24         [ 2] 1133         cmpa    #0x24       ;'$'
   889A 27 44         [ 3] 1134         beq     L88E0  
   889C 81 25         [ 2] 1135         cmpa    #0x25       ;'%'
   889E 27 40         [ 3] 1136         beq     L88E0  
   88A0 81 20         [ 2] 1137         cmpa    #0x20       ;' '
   88A2 27 3A         [ 3] 1138         beq     L88DE  
   88A4 81 30         [ 2] 1139         cmpa    #0x30       ;'0'
   88A6 25 35         [ 3] 1140         bcs     L88DD
   88A8 97 12         [ 3] 1141         staa    (0x0012)
   88AA 96 4D         [ 3] 1142         ldaa    (0x004D)
   88AC 81 02         [ 2] 1143         cmpa    #0x02
   88AE 25 09         [ 3] 1144         bcs     L88B9  
   88B0 7F 00 4D      [ 6] 1145         clr     (0x004D)
   88B3 96 12         [ 3] 1146         ldaa    (0x0012)
   88B5 97 49         [ 3] 1147         staa    (0x0049)
   88B7 20 24         [ 3] 1148         bra     L88DD  
   88B9                    1149 L88B9:
   88B9 7D 00 4E      [ 6] 1150         tst     (0x004E)
   88BC 27 1F         [ 3] 1151         beq     L88DD  
   88BE 86 78         [ 2] 1152         ldaa    #0x78
   88C0 97 63         [ 3] 1153         staa    (0x0063)
   88C2 97 64         [ 3] 1154         staa    (0x0064)
   88C4 96 12         [ 3] 1155         ldaa    (0x0012)
   88C6 81 40         [ 2] 1156         cmpa    #0x40
   88C8 24 07         [ 3] 1157         bcc     L88D1  
   88CA 97 4C         [ 3] 1158         staa    (0x004C)
   88CC 7F 00 4D      [ 6] 1159         clr     (0x004D)
   88CF 20 0C         [ 3] 1160         bra     L88DD  
   88D1                    1161 L88D1:
   88D1 81 60         [ 2] 1162         cmpa    #0x60
   88D3 24 08         [ 3] 1163         bcc     L88DD  
   88D5 97 4B         [ 3] 1164         staa    (0x004B)
   88D7 7F 00 4D      [ 6] 1165         clr     (0x004D)
   88DA BD 88 E5      [ 6] 1166         jsr     L88E5
   88DD                    1167 L88DD:
   88DD 3B            [12] 1168         rti
                           1169 
   88DE                    1170 L88DE:
   88DE 20 FD         [ 3] 1171         bra     L88DD           ; Infinite loop
   88E0                    1172 L88E0:
   88E0 7C 00 4D      [ 6] 1173         inc     (0x004D)
   88E3 20 F9         [ 3] 1174         bra     L88DE
   88E5                    1175 L88E5:
   88E5 D6 4B         [ 3] 1176         ldab    (0x004B)
   88E7 96 4C         [ 3] 1177         ldaa    (0x004C)
   88E9 7D 04 5C      [ 6] 1178         tst     (0x045C)
   88EC 27 0D         [ 3] 1179         beq     L88FB  
   88EE 81 3C         [ 2] 1180         cmpa    #0x3C
   88F0 25 09         [ 3] 1181         bcs     L88FB  
   88F2 81 3F         [ 2] 1182         cmpa    #0x3F
   88F4 22 05         [ 3] 1183         bhi     L88FB  
   88F6 BD 89 93      [ 6] 1184         jsr     L8993
   88F9 20 65         [ 3] 1185         bra     L8960  
   88FB                    1186 L88FB:
   88FB 1A 83 30 48   [ 5] 1187         cpd     #0x3048
   88FF 27 79         [ 3] 1188         beq     L897A  
   8901 1A 83 31 48   [ 5] 1189         cpd     #0x3148
   8905 27 5A         [ 3] 1190         beq     L8961  
   8907 1A 83 34 4D   [ 5] 1191         cpd     #0x344D
   890B 27 6D         [ 3] 1192         beq     L897A  
   890D 1A 83 35 4D   [ 5] 1193         cpd     #0x354D
   8911 27 4E         [ 3] 1194         beq     L8961  
   8913 1A 83 36 4D   [ 5] 1195         cpd     #0x364D
   8917 27 61         [ 3] 1196         beq     L897A  
   8919 1A 83 37 4D   [ 5] 1197         cpd     #0x374D
   891D 27 42         [ 3] 1198         beq     L8961  
   891F CE 10 80      [ 3] 1199         ldx     #0x1080
   8922 D6 4C         [ 3] 1200         ldab    (0x004C)
   8924 C0 30         [ 2] 1201         subb    #0x30
   8926 54            [ 2] 1202         lsrb
   8927 58            [ 2] 1203         aslb
   8928 58            [ 2] 1204         aslb
   8929 3A            [ 3] 1205         abx
   892A D6 4B         [ 3] 1206         ldab    (0x004B)
   892C C1 50         [ 2] 1207         cmpb    #0x50
   892E 24 30         [ 3] 1208         bcc     L8960  
   8930 C1 47         [ 2] 1209         cmpb    #0x47
   8932 23 02         [ 3] 1210         bls     L8936  
   8934 08            [ 3] 1211         inx
   8935 08            [ 3] 1212         inx
   8936                    1213 L8936:
   8936 C0 40         [ 2] 1214         subb    #0x40
   8938 C4 07         [ 2] 1215         andb    #0x07
   893A 4F            [ 2] 1216         clra
   893B 0D            [ 2] 1217         sec
   893C 49            [ 2] 1218         rola
   893D 5D            [ 2] 1219         tstb
   893E 27 04         [ 3] 1220         beq     L8944  
   8940                    1221 L8940:
   8940 49            [ 2] 1222         rola
   8941 5A            [ 2] 1223         decb
   8942 26 FC         [ 3] 1224         bne     L8940  
   8944                    1225 L8944:
   8944 97 50         [ 3] 1226         staa    (0x0050)
   8946 96 4C         [ 3] 1227         ldaa    (0x004C)
   8948 84 01         [ 2] 1228         anda    #0x01
   894A 27 08         [ 3] 1229         beq     L8954  
   894C A6 00         [ 4] 1230         ldaa    0,X
   894E 9A 50         [ 3] 1231         oraa    (0x0050)
   8950 A7 00         [ 4] 1232         staa    0,X
   8952 20 0C         [ 3] 1233         bra     L8960  
   8954                    1234 L8954:
   8954 96 50         [ 3] 1235         ldaa    (0x0050)
   8956 88 FF         [ 2] 1236         eora    #0xFF
   8958 97 50         [ 3] 1237         staa    (0x0050)
   895A A6 00         [ 4] 1238         ldaa    0,X
   895C 94 50         [ 3] 1239         anda    (0x0050)
   895E A7 00         [ 4] 1240         staa    0,X
   8960                    1241 L8960:
   8960 39            [ 5] 1242         rts
                           1243 
   8961                    1244 L8961:
   8961 B6 10 82      [ 4] 1245         ldaa    (0x1082)
   8964 8A 01         [ 2] 1246         oraa    #0x01
   8966 B7 10 82      [ 4] 1247         staa    (0x1082)
   8969 B6 10 8A      [ 4] 1248         ldaa    (0x108A)
   896C 8A 20         [ 2] 1249         oraa    #0x20
   896E B7 10 8A      [ 4] 1250         staa    (0x108A)
   8971 B6 10 8E      [ 4] 1251         ldaa    (0x108E)
   8974 8A 20         [ 2] 1252         oraa    #0x20
   8976 B7 10 8E      [ 4] 1253         staa    (0x108E)
   8979 39            [ 5] 1254         rts
                           1255 
   897A                    1256 L897A:
   897A B6 10 82      [ 4] 1257         ldaa    (0x1082)
   897D 84 FE         [ 2] 1258         anda    #0xFE
   897F B7 10 82      [ 4] 1259         staa    (0x1082)
   8982 B6 10 8A      [ 4] 1260         ldaa    (0x108A)
   8985 84 DF         [ 2] 1261         anda    #0xDF
   8987 B7 10 8A      [ 4] 1262         staa    (0x108A)
   898A B6 10 8E      [ 4] 1263         ldaa    (0x108E)
   898D 84 DF         [ 2] 1264         anda    #0xDF
   898F B7 10 8E      [ 4] 1265         staa    (0x108E)
   8992 39            [ 5] 1266         rts
                           1267 
   8993                    1268 L8993:
   8993 3C            [ 4] 1269         pshx
   8994 81 3D         [ 2] 1270         cmpa    #0x3D
   8996 22 05         [ 3] 1271         bhi     L899D  
   8998 CE F7 80      [ 3] 1272         ldx     #LF780          ; table at the end
   899B 20 03         [ 3] 1273         bra     L89A0  
   899D                    1274 L899D:
   899D CE F7 A0      [ 3] 1275         ldx     #LF7A0         ; table at the end
   89A0                    1276 L89A0:
   89A0 C0 40         [ 2] 1277         subb    #0x40
   89A2 58            [ 2] 1278         aslb
   89A3 3A            [ 3] 1279         abx
   89A4 81 3C         [ 2] 1280         cmpa    #0x3C
   89A6 27 34         [ 3] 1281         beq     L89DC  
   89A8 81 3D         [ 2] 1282         cmpa    #0x3D
   89AA 27 0A         [ 3] 1283         beq     L89B6  
   89AC 81 3E         [ 2] 1284         cmpa    #0x3E
   89AE 27 4B         [ 3] 1285         beq     L89FB  
   89B0 81 3F         [ 2] 1286         cmpa    #0x3F
   89B2 27 15         [ 3] 1287         beq     L89C9  
   89B4 38            [ 5] 1288         pulx
   89B5 39            [ 5] 1289         rts
                           1290 
   89B6                    1291 L89B6:
   89B6 B6 10 98      [ 4] 1292         ldaa    (0x1098)
   89B9 AA 00         [ 4] 1293         oraa    0,X
   89BB B7 10 98      [ 4] 1294         staa    (0x1098)
   89BE 08            [ 3] 1295         inx
   89BF B6 10 9A      [ 4] 1296         ldaa    (0x109A)
   89C2 AA 00         [ 4] 1297         oraa    0,X
   89C4 B7 10 9A      [ 4] 1298         staa    (0x109A)
   89C7 38            [ 5] 1299         pulx
   89C8 39            [ 5] 1300         rts
                           1301 
   89C9                    1302 L89C9:
   89C9 B6 10 9C      [ 4] 1303         ldaa    (0x109C)
   89CC AA 00         [ 4] 1304         oraa    0,X
   89CE B7 10 9C      [ 4] 1305         staa    (0x109C)
   89D1 08            [ 3] 1306         inx
   89D2 B6 10 9E      [ 4] 1307         ldaa    (0x109E)
   89D5 AA 00         [ 4] 1308         oraa    0,X
   89D7 B7 10 9E      [ 4] 1309         staa    (0x109E)
   89DA 38            [ 5] 1310         pulx
   89DB 39            [ 5] 1311         rts
                           1312 
   89DC                    1313 L89DC:
   89DC E6 00         [ 4] 1314         ldab    0,X
   89DE C8 FF         [ 2] 1315         eorb    #0xFF
   89E0 D7 12         [ 3] 1316         stab    (0x0012)
   89E2 B6 10 98      [ 4] 1317         ldaa    (0x1098)
   89E5 94 12         [ 3] 1318         anda    (0x0012)
   89E7 B7 10 98      [ 4] 1319         staa    (0x1098)
   89EA 08            [ 3] 1320         inx
   89EB E6 00         [ 4] 1321         ldab    0,X
   89ED C8 FF         [ 2] 1322         eorb    #0xFF
   89EF D7 12         [ 3] 1323         stab    (0x0012)
   89F1 B6 10 9A      [ 4] 1324         ldaa    (0x109A)
   89F4 94 12         [ 3] 1325         anda    (0x0012)
   89F6 B7 10 9A      [ 4] 1326         staa    (0x109A)
   89F9 38            [ 5] 1327         pulx
   89FA 39            [ 5] 1328         rts
                           1329 
   89FB                    1330 L89FB:
   89FB E6 00         [ 4] 1331         ldab    0,X
   89FD C8 FF         [ 2] 1332         eorb    #0xFF
   89FF D7 12         [ 3] 1333         stab    (0x0012)
   8A01 B6 10 9C      [ 4] 1334         ldaa    (0x109C)
   8A04 94 12         [ 3] 1335         anda    (0x0012)
   8A06 B7 10 9C      [ 4] 1336         staa    (0x109C)
   8A09 08            [ 3] 1337         inx
   8A0A E6 00         [ 4] 1338         ldab    0,X
   8A0C C8 FF         [ 2] 1339         eorb    #0xFF
   8A0E D7 12         [ 3] 1340         stab    (0x0012)
   8A10 B6 10 9E      [ 4] 1341         ldaa    (0x109E)
   8A13 94 12         [ 3] 1342         anda    (0x0012)
   8A15 B7 10 9E      [ 4] 1343         staa    (0x109E)
   8A18 38            [ 5] 1344         pulx
   8A19 39            [ 5] 1345         rts
                           1346 
                           1347 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1348 
   8A1A                    1349 L8A1A:
                           1350 ; Parse text with compressed ANSI stuff from table location in X
   8A1A 3C            [ 4] 1351         pshx
   8A1B                    1352 L8A1B:
   8A1B 86 04         [ 2] 1353         ldaa    #0x04
   8A1D B5 18 0D      [ 4] 1354         bita    SCCCTRLB
   8A20 27 F9         [ 3] 1355         beq     L8A1B  
   8A22 A6 00         [ 4] 1356         ldaa    0,X     
   8A24 26 03         [ 3] 1357         bne     L8A29       ; if not nul, continue
   8A26 7E 8B 21      [ 3] 1358         jmp     L8B21       ; else jump to exit
                           1359 ; process ^0123 into ESC[01;23H - ANSI Cursor positioning - (1 based)
   8A29                    1360 L8A29:
   8A29 08            [ 3] 1361         inx
   8A2A 81 5E         [ 2] 1362         cmpa    #0x5E       ; is it a '^' ?
   8A2C 26 1D         [ 3] 1363         bne     L8A4B       ; no, jump ahead
   8A2E A6 00         [ 4] 1364         ldaa    0,X         ; yes, get the next char
   8A30 08            [ 3] 1365         inx
   8A31 B7 05 92      [ 4] 1366         staa    (0x0592)    
   8A34 A6 00         [ 4] 1367         ldaa    0,X     
   8A36 08            [ 3] 1368         inx
   8A37 B7 05 93      [ 4] 1369         staa    (0x0593)
   8A3A A6 00         [ 4] 1370         ldaa    0,X     
   8A3C 08            [ 3] 1371         inx
   8A3D B7 05 95      [ 4] 1372         staa    (0x0595)
   8A40 A6 00         [ 4] 1373         ldaa    0,X     
   8A42 08            [ 3] 1374         inx
   8A43 B7 05 96      [ 4] 1375         staa    (0x0596)
   8A46 BD 8B 23      [ 6] 1376         jsr     L8B23
   8A49 20 D0         [ 3] 1377         bra     L8A1B  
                           1378 ; process @...
   8A4B                    1379 L8A4B:
   8A4B 81 40         [ 2] 1380         cmpa    #0x40       ; is it a '@' ?
   8A4D 26 3B         [ 3] 1381         bne     L8A8A  
   8A4F 1A EE 00      [ 6] 1382         ldy     0,X
   8A52 08            [ 3] 1383         inx
   8A53 08            [ 3] 1384         inx
   8A54 86 30         [ 2] 1385         ldaa    #0x30
   8A56 97 B1         [ 3] 1386         staa    (0x00B1)
   8A58 18 A6 00      [ 5] 1387         ldaa    0,Y
   8A5B                    1388 L8A5B:
   8A5B 81 64         [ 2] 1389         cmpa    #0x64
   8A5D 25 07         [ 3] 1390         bcs     L8A66  
   8A5F 7C 00 B1      [ 6] 1391         inc     (0x00B1)
   8A62 80 64         [ 2] 1392         suba    #0x64
   8A64 20 F5         [ 3] 1393         bra     L8A5B  
   8A66                    1394 L8A66:
   8A66 36            [ 3] 1395         psha
   8A67 96 B1         [ 3] 1396         ldaa    (0x00B1)
   8A69 BD 8B 3B      [ 6] 1397         jsr     L8B3B
   8A6C 86 30         [ 2] 1398         ldaa    #0x30
   8A6E 97 B1         [ 3] 1399         staa    (0x00B1)
   8A70 32            [ 4] 1400         pula
   8A71                    1401 L8A71:
   8A71 81 0A         [ 2] 1402         cmpa    #0x0A
   8A73 25 07         [ 3] 1403         bcs     L8A7C  
   8A75 7C 00 B1      [ 6] 1404         inc     (0x00B1)
   8A78 80 0A         [ 2] 1405         suba    #0x0A
   8A7A 20 F5         [ 3] 1406         bra     L8A71  
   8A7C                    1407 L8A7C:
   8A7C 36            [ 3] 1408         psha
   8A7D 96 B1         [ 3] 1409         ldaa    (0x00B1)
   8A7F BD 8B 3B      [ 6] 1410         jsr     L8B3B
   8A82 32            [ 4] 1411         pula
   8A83 8B 30         [ 2] 1412         adda    #0x30
   8A85 BD 8B 3B      [ 6] 1413         jsr     L8B3B
   8A88 20 91         [ 3] 1414         bra     L8A1B
                           1415 ; process |...
   8A8A                    1416 L8A8A:
   8A8A 81 7C         [ 2] 1417         cmpa    #0x7C       ; is it a '|' ?
   8A8C 26 59         [ 3] 1418         bne     L8AE7  
   8A8E 1A EE 00      [ 6] 1419         ldy     0,X     
   8A91 08            [ 3] 1420         inx
   8A92 08            [ 3] 1421         inx
   8A93 86 30         [ 2] 1422         ldaa    #0x30
   8A95 97 B1         [ 3] 1423         staa    (0x00B1)
   8A97 18 EC 00      [ 6] 1424         ldd     0,Y     
   8A9A                    1425 L8A9A:
   8A9A 1A 83 27 10   [ 5] 1426         cpd     #0x2710
   8A9E 25 08         [ 3] 1427         bcs     L8AA8  
   8AA0 7C 00 B1      [ 6] 1428         inc     (0x00B1)
   8AA3 83 27 10      [ 4] 1429         subd    #0x2710
   8AA6 20 F2         [ 3] 1430         bra     L8A9A  
   8AA8                    1431 L8AA8:
   8AA8 36            [ 3] 1432         psha
   8AA9 96 B1         [ 3] 1433         ldaa    (0x00B1)
   8AAB BD 8B 3B      [ 6] 1434         jsr     L8B3B
   8AAE 86 30         [ 2] 1435         ldaa    #0x30
   8AB0 97 B1         [ 3] 1436         staa    (0x00B1)
   8AB2 32            [ 4] 1437         pula
   8AB3                    1438 L8AB3:
   8AB3 1A 83 03 E8   [ 5] 1439         cpd     #0x03E8
   8AB7 25 08         [ 3] 1440         bcs     L8AC1  
   8AB9 7C 00 B1      [ 6] 1441         inc     (0x00B1)
   8ABC 83 03 E8      [ 4] 1442         subd    #0x03E8
   8ABF 20 F2         [ 3] 1443         bra     L8AB3  
   8AC1                    1444 L8AC1:
   8AC1 36            [ 3] 1445         psha
   8AC2 96 B1         [ 3] 1446         ldaa    (0x00B1)
   8AC4 BD 8B 3B      [ 6] 1447         jsr     L8B3B
   8AC7 86 30         [ 2] 1448         ldaa    #0x30
   8AC9 97 B1         [ 3] 1449         staa    (0x00B1)
   8ACB 32            [ 4] 1450         pula
   8ACC                    1451 L8ACC:
   8ACC 1A 83 00 64   [ 5] 1452         cpd     #0x0064
   8AD0 25 08         [ 3] 1453         bcs     L8ADA  
   8AD2 7C 00 B1      [ 6] 1454         inc     (0x00B1)
   8AD5 83 00 64      [ 4] 1455         subd    #0x0064
   8AD8 20 F2         [ 3] 1456         bra     L8ACC  
   8ADA                    1457 L8ADA:
   8ADA 96 B1         [ 3] 1458         ldaa    (0x00B1)
   8ADC BD 8B 3B      [ 6] 1459         jsr     L8B3B
   8ADF 86 30         [ 2] 1460         ldaa    #0x30
   8AE1 97 B1         [ 3] 1461         staa    (0x00B1)
   8AE3 17            [ 2] 1462         tba
   8AE4 7E 8A 71      [ 3] 1463         jmp     L8A71
                           1464 ; process ~...
   8AE7                    1465 L8AE7:
   8AE7 81 7E         [ 2] 1466         cmpa    #0x7E       ; is it a '~' ?
   8AE9 26 18         [ 3] 1467         bne     L8B03  
   8AEB E6 00         [ 4] 1468         ldab    0,X     
   8AED C0 30         [ 2] 1469         subb    #0x30
   8AEF 08            [ 3] 1470         inx
   8AF0 1A EE 00      [ 6] 1471         ldy     0,X     
   8AF3 08            [ 3] 1472         inx
   8AF4 08            [ 3] 1473         inx
   8AF5                    1474 L8AF5:
   8AF5 18 A6 00      [ 5] 1475         ldaa    0,Y     
   8AF8 18 08         [ 4] 1476         iny
   8AFA BD 8B 3B      [ 6] 1477         jsr     L8B3B
   8AFD 5A            [ 2] 1478         decb
   8AFE 26 F5         [ 3] 1479         bne     L8AF5  
   8B00 7E 8A 1B      [ 3] 1480         jmp     L8A1B
                           1481 ; process %...
   8B03                    1482 L8B03:
   8B03 81 25         [ 2] 1483         cmpa    #0x25       ; is it a '%' ?
   8B05 26 14         [ 3] 1484         bne     L8B1B  
   8B07 CE 05 90      [ 3] 1485         ldx     #0x0590
   8B0A CC 1B 5B      [ 3] 1486         ldd     #0x1B5B
   8B0D ED 00         [ 5] 1487         std     0,X     
   8B0F 86 4B         [ 2] 1488         ldaa    #0x4B
   8B11 A7 02         [ 4] 1489         staa    2,X
   8B13 6F 03         [ 6] 1490         clr     3,X
   8B15 BD 8A 1A      [ 6] 1491         jsr     L8A1A  
   8B18 7E 8A 1B      [ 3] 1492         jmp     L8A1B
   8B1B                    1493 L8B1B:
   8B1B B7 18 0F      [ 4] 1494         staa    SCCDATAB
   8B1E 7E 8A 1B      [ 3] 1495         jmp     L8A1B
   8B21                    1496 L8B21:
   8B21 38            [ 5] 1497         pulx
   8B22 39            [ 5] 1498         rts
                           1499 
                           1500 ; generate cursor positioning code
   8B23                    1501 L8B23:
   8B23 3C            [ 4] 1502         pshx
   8B24 CE 05 90      [ 3] 1503         ldx     #0x0590
   8B27 CC 1B 5B      [ 3] 1504         ldd     #0x1B5B
   8B2A ED 00         [ 5] 1505         std     0,X     
   8B2C 86 48         [ 2] 1506         ldaa    #0x48       ;'H'
   8B2E A7 07         [ 4] 1507         staa    7,X
   8B30 86 3B         [ 2] 1508         ldaa    #0x3B       ;';'
   8B32 A7 04         [ 4] 1509         staa    4,X
   8B34 6F 08         [ 6] 1510         clr     8,X
   8B36 BD 8A 1A      [ 6] 1511         jsr     L8A1A       ;012345678 - esc[01;23H;
   8B39 38            [ 5] 1512         pulx
   8B3A 39            [ 5] 1513         rts
                           1514 
                           1515 ;
   8B3B                    1516 L8B3B:
   8B3B 36            [ 3] 1517         psha
   8B3C                    1518 L8B3C:
   8B3C 86 04         [ 2] 1519         ldaa    #0x04
   8B3E B5 18 0D      [ 4] 1520         bita    SCCCTRLB
   8B41 27 F9         [ 3] 1521         beq     L8B3C
   8B43 32            [ 4] 1522         pula
   8B44 B7 18 0F      [ 4] 1523         staa    SCCDATAB
   8B47 39            [ 5] 1524         rts
                           1525 
   8B48                    1526 L8B48:
   8B48 BD A3 2E      [ 6] 1527         jsr     LA32E
                           1528 
   8B4B BD 8D E4      [ 6] 1529         jsr     LCDMSG1 
   8B4E 4C 69 67 68 74 20  1530         .ascis  'Light Diagnostic'
        44 69 61 67 6E 6F
        73 74 69 E3
                           1531 
   8B5E BD 8D DD      [ 6] 1532         jsr     LCDMSG2 
   8B61 43 75 72 74 61 69  1533         .ascis  'Curtains opening'
        6E 73 20 6F 70 65
        6E 69 6E E7
                           1534 
   8B71 C6 14         [ 2] 1535         ldab    #0x14
   8B73 BD 8C 30      [ 6] 1536         jsr     DLYSECSBY2           ; delay 10 sec
   8B76 C6 FF         [ 2] 1537         ldab    #0xFF
   8B78 F7 10 98      [ 4] 1538         stab    (0x1098)
   8B7B F7 10 9A      [ 4] 1539         stab    (0x109A)
   8B7E F7 10 9C      [ 4] 1540         stab    (0x109C)
   8B81 F7 10 9E      [ 4] 1541         stab    (0x109E)
   8B84 BD F9 C5      [ 6] 1542         jsr     BUTNLIT 
   8B87 B6 18 04      [ 4] 1543         ldaa    PIA0PRA 
   8B8A 8A 40         [ 2] 1544         oraa    #0x40
   8B8C B7 18 04      [ 4] 1545         staa    PIA0PRA 
                           1546 
   8B8F BD 8D E4      [ 6] 1547         jsr     LCDMSG1 
   8B92 20 50 72 65 73 73  1548         .ascis  ' Press ENTER to '
        20 45 4E 54 45 52
        20 74 6F A0
                           1549 
   8BA2 BD 8D DD      [ 6] 1550         jsr     LCDMSG2 
   8BA5 74 75 72 6E 20 6C  1551         .ascis  'turn lights  off'
        69 67 68 74 73 20
        20 6F 66 E6
                           1552 
   8BB5                    1553 L8BB5:
   8BB5 BD 8E 95      [ 6] 1554         jsr     L8E95
   8BB8 81 0D         [ 2] 1555         cmpa    #0x0D
   8BBA 26 F9         [ 3] 1556         bne     L8BB5  
   8BBC BD A3 41      [ 6] 1557         jsr     LA341
   8BBF 39            [ 5] 1558         rts
                           1559 
                           1560 ; setup IRQ handlers!
   8BC0                    1561 L8BC0:
   8BC0 86 80         [ 2] 1562         ldaa    #0x80
   8BC2 B7 10 22      [ 4] 1563         staa    TMSK1
   8BC5 CE AB CC      [ 3] 1564         ldx     #LABCC
   8BC8 FF 01 19      [ 5] 1565         stx     (0x0119)    ; setup T1OC handler
   8BCB CE AD 0C      [ 3] 1566         ldx     #LAD0C
                           1567 
   8BCE FF 01 16      [ 5] 1568         stx     (0x0116)    ; setup T2OC handler
   8BD1 CE AD 0C      [ 3] 1569         ldx     #LAD0C
   8BD4 FF 01 2E      [ 5] 1570         stx     (0x012E)    ; doubles as SWI handler
   8BD7 86 7E         [ 2] 1571         ldaa    #0x7E
   8BD9 B7 01 18      [ 4] 1572         staa    (0x0118)
   8BDC B7 01 15      [ 4] 1573         staa    (0x0115)
   8BDF B7 01 2D      [ 4] 1574         staa    (0x012D)
   8BE2 4F            [ 2] 1575         clra
   8BE3 5F            [ 2] 1576         clrb
   8BE4 DD 1B         [ 4] 1577         std     CDTIMR1     ; Reset all the countdown timers
   8BE6 DD 1D         [ 4] 1578         std     CDTIMR2
   8BE8 DD 1F         [ 4] 1579         std     CDTIMR3
   8BEA DD 21         [ 4] 1580         std     CDTIMR4
   8BEC DD 23         [ 4] 1581         std     CDTIMR5
                           1582 
   8BEE                    1583 L8BEE:
   8BEE 86 C0         [ 2] 1584         ldaa    #0xC0
   8BF0 B7 10 23      [ 4] 1585         staa    TFLG1
   8BF3 39            [ 5] 1586         rts
                           1587 
   8BF4                    1588 L8BF4:
   8BF4 B6 10 0A      [ 4] 1589         ldaa    PORTE
   8BF7 88 FF         [ 2] 1590         eora    #0xFF
   8BF9 16            [ 2] 1591         tab
   8BFA D7 62         [ 3] 1592         stab    (0x0062)
   8BFC BD F9 C5      [ 6] 1593         jsr     BUTNLIT 
   8BFF 20 F3         [ 3] 1594         bra     L8BF4  
   8C01 39            [ 5] 1595         rts
                           1596 
                           1597 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1598 
                           1599 ; Delay B seconds, with housekeeping
   8C02                    1600 DLYSECS:
   8C02 36            [ 3] 1601         psha
   8C03 86 64         [ 2] 1602         ldaa    #0x64
   8C05 3D            [10] 1603         mul
   8C06 DD 23         [ 4] 1604         std     CDTIMR5     ; store B*100 here
   8C08                    1605 L8C08:
   8C08 BD 9B 19      [ 6] 1606         jsr     L9B19       ; do the random motions if enabled
   8C0B DC 23         [ 4] 1607         ldd     CDTIMR5     ; housekeeping
   8C0D 26 F9         [ 3] 1608         bne     L8C08  
   8C0F 32            [ 4] 1609         pula
   8C10 39            [ 5] 1610         rts
                           1611 
                           1612 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1613 
                           1614 ; Delay 1 minute, with housekeeping - unused?
   8C11                    1615 DLY1MIN:
   8C11 36            [ 3] 1616         psha
   8C12 86 3C         [ 2] 1617         ldaa    #0x3C
   8C14                    1618 L8C14:
   8C14 97 28         [ 3] 1619         staa    (0x0028)
   8C16 C6 01         [ 2] 1620         ldab    #0x01       ; delay 1 sec
   8C18 BD 8C 02      [ 6] 1621         jsr     DLYSECS     ;
   8C1B 96 28         [ 3] 1622         ldaa    (0x0028)
   8C1D 4A            [ 2] 1623         deca
   8C1E 26 F4         [ 3] 1624         bne     L8C14  
   8C20 32            [ 4] 1625         pula
   8C21 39            [ 5] 1626         rts
                           1627 
                           1628 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1629 
                           1630 ; Delay by B hundreths of a second, with housekeeping
   8C22                    1631 DLYSECSBY100:
   8C22 36            [ 3] 1632         psha
   8C23 4F            [ 2] 1633         clra
   8C24 DD 23         [ 4] 1634         std     CDTIMR5
   8C26                    1635 L8C26:
   8C26 BD 9B 19      [ 6] 1636         jsr     L9B19       ; do the random motions if enabled
   8C29 7D 00 24      [ 6] 1637         tst     CDTIMR5+1
   8C2C 26 F8         [ 3] 1638         bne     L8C26       ; housekeeping?
   8C2E 32            [ 4] 1639         pula
   8C2F 39            [ 5] 1640         rts
                           1641 
                           1642 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1643 
                           1644 ; Delay by B half-seconds, with housekeeping
   8C30                    1645 DLYSECSBY2:
   8C30 36            [ 3] 1646         psha
   8C31 86 32         [ 2] 1647         ldaa    #0x32       ; 50
   8C33 3D            [10] 1648         mul
   8C34 DD 23         [ 4] 1649         std     CDTIMR5
   8C36                    1650 L8C36:
   8C36 DC 23         [ 4] 1651         ldd     CDTIMR5
   8C38 26 FC         [ 3] 1652         bne     L8C36       ; housekeeping?
   8C3A 32            [ 4] 1653         pula
   8C3B 39            [ 5] 1654         rts
                           1655 
                           1656 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1657 ; LCD routines
                           1658 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1659 
   8C3C                    1660 L8C3C:
   8C3C 86 FF         [ 2] 1661         ldaa    #0xFF
   8C3E B7 10 01      [ 4] 1662         staa    DDRA  
   8C41 86 FF         [ 2] 1663         ldaa    #0xFF
   8C43 B7 10 03      [ 4] 1664         staa    DDRG 
   8C46 B6 10 02      [ 4] 1665         ldaa    PORTG  
   8C49 8A 02         [ 2] 1666         oraa    #0x02
   8C4B B7 10 02      [ 4] 1667         staa    PORTG  
   8C4E 86 38         [ 2] 1668         ldaa    #0x38
   8C50 BD 8C 86      [ 6] 1669         jsr     L8C86        ; write byte to LCD
   8C53 86 38         [ 2] 1670         ldaa    #0x38
   8C55 BD 8C 86      [ 6] 1671         jsr     L8C86        ; write byte to LCD
   8C58 86 06         [ 2] 1672         ldaa    #0x06
   8C5A BD 8C 86      [ 6] 1673         jsr     L8C86        ; write byte to LCD
   8C5D 86 0E         [ 2] 1674         ldaa    #0x0E
   8C5F BD 8C 86      [ 6] 1675         jsr     L8C86        ; write byte to LCD
   8C62 86 01         [ 2] 1676         ldaa    #0x01
   8C64 BD 8C 86      [ 6] 1677         jsr     L8C86        ; write byte to LCD
   8C67 CE 00 FF      [ 3] 1678         ldx     #0x00FF
   8C6A                    1679 L8C6A:
   8C6A 01            [ 2] 1680         nop
   8C6B 01            [ 2] 1681         nop
   8C6C 09            [ 3] 1682         dex
   8C6D 26 FB         [ 3] 1683         bne     L8C6A  
   8C6F 39            [ 5] 1684         rts
                           1685 
                           1686 ; toggle LCD ENABLE
   8C70                    1687 L8C70:
   8C70 B6 10 02      [ 4] 1688         ldaa    PORTG  
   8C73 84 FD         [ 2] 1689         anda    #0xFD        ; clear LCD ENABLE
   8C75 B7 10 02      [ 4] 1690         staa    PORTG  
   8C78 8A 02         [ 2] 1691         oraa    #0x02        ; set LCD ENABLE
   8C7A B7 10 02      [ 4] 1692         staa    PORTG  
   8C7D 39            [ 5] 1693         rts
                           1694 
                           1695 ; Reset LCD buffer?
   8C7E                    1696 L8C7E:
   8C7E CC 05 00      [ 3] 1697         ldd     #0x0500     ; Reset LCD queue?
   8C81 DD 46         [ 4] 1698         std     (0x0046)    ; write pointer
   8C83 DD 44         [ 4] 1699         std     (0x0044)    ; read pointer?
   8C85 39            [ 5] 1700         rts
                           1701 
                           1702 ; write byte to LCD
   8C86                    1703 L8C86:
   8C86 BD 8C BD      [ 6] 1704         jsr     L8CBD        ; wait for LCD not busy
   8C89 B7 10 00      [ 4] 1705         staa    PORTA  
   8C8C B6 10 02      [ 4] 1706         ldaa    PORTG       
   8C8F 84 F3         [ 2] 1707         anda    #0xF3        ; LCD RS and LCD RW low
   8C91                    1708 L8C91:
   8C91 B7 10 02      [ 4] 1709         staa    PORTG  
   8C94 BD 8C 70      [ 6] 1710         jsr     L8C70        ; toggle LCD ENABLE
   8C97 39            [ 5] 1711         rts
                           1712 
                           1713 ; ???
   8C98                    1714 L8C98:
   8C98 BD 8C BD      [ 6] 1715         jsr     L8CBD        ; wait for LCD not busy
   8C9B B7 10 00      [ 4] 1716         staa    PORTA  
   8C9E B6 10 02      [ 4] 1717         ldaa    PORTG  
   8CA1 84 FB         [ 2] 1718         anda    #0xFB
   8CA3 8A 08         [ 2] 1719         oraa    #0x08
   8CA5 20 EA         [ 3] 1720         bra     L8C91  
   8CA7 BD 8C BD      [ 6] 1721         jsr     L8CBD        ; wait for LCD not busy
   8CAA B6 10 02      [ 4] 1722         ldaa    PORTG  
   8CAD 84 F7         [ 2] 1723         anda    #0xF7
   8CAF 8A 08         [ 2] 1724         oraa    #0x08
   8CB1 20 DE         [ 3] 1725         bra     L8C91  
   8CB3 BD 8C BD      [ 6] 1726         jsr     L8CBD        ; wait for LCD not busy
   8CB6 B6 10 02      [ 4] 1727         ldaa    PORTG  
   8CB9 8A 0C         [ 2] 1728         oraa    #0x0C
   8CBB 20 D4         [ 3] 1729         bra     L8C91  
                           1730 
                           1731 ; wait for LCD not busy (or timeout)
   8CBD                    1732 L8CBD:
   8CBD 36            [ 3] 1733         psha
   8CBE 37            [ 3] 1734         pshb
   8CBF C6 FF         [ 2] 1735         ldab    #0xFF        ; init timeout counter
   8CC1                    1736 L8CC1:
   8CC1 5D            [ 2] 1737         tstb
   8CC2 27 1A         [ 3] 1738         beq     L8CDE       ; times up, exit
   8CC4 B6 10 02      [ 4] 1739         ldaa    PORTG  
   8CC7 84 F7         [ 2] 1740         anda    #0xF7        ; bit 3 low
   8CC9 8A 04         [ 2] 1741         oraa    #0x04        ; bit 3 high
   8CCB B7 10 02      [ 4] 1742         staa    PORTG        ; LCD RS high
   8CCE BD 8C 70      [ 6] 1743         jsr     L8C70        ; toggle LCD ENABLE
   8CD1 7F 10 01      [ 6] 1744         clr     DDRA  
   8CD4 B6 10 00      [ 4] 1745         ldaa    PORTA       ; read busy flag from LCD
   8CD7 2B 08         [ 3] 1746         bmi     L8CE1       ; if busy, keep looping
   8CD9 86 FF         [ 2] 1747         ldaa    #0xFF
   8CDB B7 10 01      [ 4] 1748         staa    DDRA        ; port A back to outputs
   8CDE                    1749 L8CDE:
   8CDE 33            [ 4] 1750         pulb                ; and exit
   8CDF 32            [ 4] 1751         pula
   8CE0 39            [ 5] 1752         rts
                           1753 
   8CE1                    1754 L8CE1:
   8CE1 5A            [ 2] 1755         decb                ; decrement timer
   8CE2 86 FF         [ 2] 1756         ldaa    #0xFF
   8CE4 B7 10 01      [ 4] 1757         staa    DDRA        ; port A back to outputs
   8CE7 20 D8         [ 3] 1758         bra     L8CC1       ; loop
                           1759 
   8CE9                    1760 L8CE9:
   8CE9 BD 8C BD      [ 6] 1761         jsr     L8CBD        ; wait for LCD not busy
   8CEC 86 01         [ 2] 1762         ldaa    #0x01
   8CEE BD 8C 86      [ 6] 1763         jsr     L8C86        ; write byte to LCD
   8CF1 39            [ 5] 1764         rts
                           1765 
   8CF2                    1766 L8CF2:
   8CF2 BD 8C BD      [ 6] 1767         jsr     L8CBD        ; wait for LCD not busy
   8CF5 86 80         [ 2] 1768         ldaa    #0x80
   8CF7 BD 8D 14      [ 6] 1769         jsr     L8D14
   8CFA BD 8C BD      [ 6] 1770         jsr     L8CBD        ; wait for LCD not busy
   8CFD 86 80         [ 2] 1771         ldaa    #0x80
   8CFF BD 8C 86      [ 6] 1772         jsr     L8C86        ; write byte to LCD
   8D02 39            [ 5] 1773         rts
                           1774 
   8D03                    1775 L8D03:
   8D03 BD 8C BD      [ 6] 1776         jsr     L8CBD        ; wait for LCD not busy
   8D06 86 C0         [ 2] 1777         ldaa    #0xC0
   8D08 BD 8D 14      [ 6] 1778         jsr     L8D14
   8D0B BD 8C BD      [ 6] 1779         jsr     L8CBD        ; wait for LCD not busy
   8D0E 86 C0         [ 2] 1780         ldaa    #0xC0
   8D10 BD 8C 86      [ 6] 1781         jsr     L8C86        ; write byte to LCD
   8D13 39            [ 5] 1782         rts
                           1783 
   8D14                    1784 L8D14:
   8D14 BD 8C 86      [ 6] 1785         jsr     L8C86        ; write byte to LCD
   8D17 86 10         [ 2] 1786         ldaa    #0x10
   8D19 97 14         [ 3] 1787         staa    (0x0014)
   8D1B                    1788 L8D1B:
   8D1B BD 8C BD      [ 6] 1789         jsr     L8CBD        ; wait for LCD not busy
   8D1E 86 20         [ 2] 1790         ldaa    #0x20
   8D20 BD 8C 98      [ 6] 1791         jsr     L8C98
   8D23 7A 00 14      [ 6] 1792         dec     (0x0014)
   8D26 26 F3         [ 3] 1793         bne     L8D1B  
   8D28 39            [ 5] 1794         rts
                           1795 
   8D29                    1796 L8D29:
   8D29 86 0C         [ 2] 1797         ldaa    #0x0C
   8D2B BD 8E 4B      [ 6] 1798         jsr     L8E4B
   8D2E 39            [ 5] 1799         rts
                           1800 
                           1801 ; Unused?
   8D2F                    1802 L8D2F:
   8D2F 86 0E         [ 2] 1803         ldaa    #0x0E
   8D31 BD 8E 4B      [ 6] 1804         jsr     L8E4B
   8D34 39            [ 5] 1805         rts
                           1806 
   8D35                    1807 L8D35:
   8D35 7F 00 4A      [ 6] 1808         clr     (0x004A)
   8D38 7F 00 43      [ 6] 1809         clr     (0x0043)
   8D3B 18 DE 46      [ 5] 1810         ldy     (0x0046)
   8D3E 86 C0         [ 2] 1811         ldaa    #0xC0
   8D40 20 0B         [ 3] 1812         bra     L8D4D
                           1813 
   8D42                    1814 L8D42:
   8D42 7F 00 4A      [ 6] 1815         clr     (0x004A)
   8D45 7F 00 43      [ 6] 1816         clr     (0x0043)
   8D48 18 DE 46      [ 5] 1817         ldy     (0x0046)
   8D4B 86 80         [ 2] 1818         ldaa    #0x80
   8D4D                    1819 L8D4D:
   8D4D 18 A7 00      [ 5] 1820         staa    0,Y     
   8D50 18 6F 01      [ 7] 1821         clr     1,Y     
   8D53 18 08         [ 4] 1822         iny
   8D55 18 08         [ 4] 1823         iny
   8D57 18 8C 05 80   [ 5] 1824         cpy     #0x0580
   8D5B 25 04         [ 3] 1825         bcs     L8D61  
   8D5D 18 CE 05 00   [ 4] 1826         ldy     #0x0500
   8D61                    1827 L8D61:
   8D61 C6 0F         [ 2] 1828         ldab    #0x0F
   8D63                    1829 L8D63:
   8D63 96 4A         [ 3] 1830         ldaa    (0x004A)
   8D65 27 FC         [ 3] 1831         beq     L8D63  
   8D67 7F 00 4A      [ 6] 1832         clr     (0x004A)
   8D6A 5A            [ 2] 1833         decb
   8D6B 27 1A         [ 3] 1834         beq     L8D87  
   8D6D 81 24         [ 2] 1835         cmpa    #0x24
   8D6F 27 16         [ 3] 1836         beq     L8D87  
   8D71 18 6F 00      [ 7] 1837         clr     0,Y     
   8D74 18 A7 01      [ 5] 1838         staa    1,Y     
   8D77 18 08         [ 4] 1839         iny
   8D79 18 08         [ 4] 1840         iny
   8D7B 18 8C 05 80   [ 5] 1841         cpy     #0x0580
   8D7F 25 04         [ 3] 1842         bcs     L8D85  
   8D81 18 CE 05 00   [ 4] 1843         ldy     #0x0500
   8D85                    1844 L8D85:
   8D85 20 DC         [ 3] 1845         bra     L8D63  
   8D87                    1846 L8D87:
   8D87 5D            [ 2] 1847         tstb
   8D88 27 19         [ 3] 1848         beq     L8DA3  
   8D8A 86 20         [ 2] 1849         ldaa    #0x20
   8D8C                    1850 L8D8C:
   8D8C 18 6F 00      [ 7] 1851         clr     0,Y     
   8D8F 18 A7 01      [ 5] 1852         staa    1,Y     
   8D92 18 08         [ 4] 1853         iny
   8D94 18 08         [ 4] 1854         iny
   8D96 18 8C 05 80   [ 5] 1855         cpy     #0x0580
   8D9A 25 04         [ 3] 1856         bcs     L8DA0  
   8D9C 18 CE 05 00   [ 4] 1857         ldy     #0x0500
   8DA0                    1858 L8DA0:
   8DA0 5A            [ 2] 1859         decb
   8DA1 26 E9         [ 3] 1860         bne     L8D8C  
   8DA3                    1861 L8DA3:
   8DA3 18 6F 00      [ 7] 1862         clr     0,Y     
   8DA6 18 6F 01      [ 7] 1863         clr     1,Y     
   8DA9 18 DF 46      [ 5] 1864         sty     (0x0046)
   8DAC 96 19         [ 3] 1865         ldaa    (0x0019)
   8DAE 97 4E         [ 3] 1866         staa    (0x004E)
   8DB0 86 01         [ 2] 1867         ldaa    #0x01
   8DB2 97 43         [ 3] 1868         staa    (0x0043)
   8DB4 39            [ 5] 1869         rts
                           1870 
                           1871 ; display ASCII in B at location
   8DB5                    1872 L8DB5:
   8DB5 36            [ 3] 1873         psha
   8DB6 37            [ 3] 1874         pshb
   8DB7 C1 4F         [ 2] 1875         cmpb    #0x4F
   8DB9 22 13         [ 3] 1876         bhi     L8DCE  
   8DBB C1 28         [ 2] 1877         cmpb    #0x28
   8DBD 25 03         [ 3] 1878         bcs     L8DC2  
   8DBF 0C            [ 2] 1879         clc
   8DC0 C9 18         [ 2] 1880         adcb    #0x18
   8DC2                    1881 L8DC2:
   8DC2 0C            [ 2] 1882         clc
   8DC3 C9 80         [ 2] 1883         adcb    #0x80
   8DC5 17            [ 2] 1884         tba
   8DC6 BD 8E 4B      [ 6] 1885         jsr     L8E4B        ; send lcd command
   8DC9 33            [ 4] 1886         pulb
   8DCA 32            [ 4] 1887         pula
   8DCB BD 8E 70      [ 6] 1888         jsr     L8E70        ; send lcd char
   8DCE                    1889 L8DCE:
   8DCE 39            [ 5] 1890         rts
                           1891 
                           1892 ; 4 routines to write to the LCD display
                           1893 
                           1894 ; Write to the LCD 1st line - extend past the end of a normal display
   8DCF                    1895 LCDMSG1A:
   8DCF 18 DE 46      [ 5] 1896         ldy     (0x0046)     ; get buffer pointer
   8DD2 86 90         [ 2] 1897         ldaa    #0x90        ; command to set LCD RAM ptr to chr 0x10
   8DD4 20 13         [ 3] 1898         bra     L8DE9  
                           1899 
                           1900 ; Write to the LCD 2st line - extend past the end of a normal display
   8DD6                    1901 LCDMSG2A:
   8DD6 18 DE 46      [ 5] 1902         ldy     (0x0046)     ; get buffer pointer
   8DD9 86 D0         [ 2] 1903         ldaa    #0xD0        ; command to set LCD RAM ptr to chr 0x50
   8DDB 20 0C         [ 3] 1904         bra     L8DE9  
                           1905 
                           1906 ; Write to the LCD 2nd line
   8DDD                    1907 LCDMSG2:
   8DDD 18 DE 46      [ 5] 1908         ldy     (0x0046)     ; get buffer pointer
   8DE0 86 C0         [ 2] 1909         ldaa    #0xC0        ; command to set LCD RAM ptr to chr 0x40
   8DE2 20 05         [ 3] 1910         bra     L8DE9  
                           1911 
                           1912 ; Write to the LCD 1st line
   8DE4                    1913 LCDMSG1:
   8DE4 18 DE 46      [ 5] 1914         ldy     (0x0046)     ; get buffer pointer
   8DE7 86 80         [ 2] 1915         ldaa    #0x80        ; command to load LCD RAM ptr to chr 0x00
                           1916 
                           1917 ; Put LCD command into a buffer, 4 bytes for each entry?
   8DE9                    1918 L8DE9:
   8DE9 18 A7 00      [ 5] 1919         staa    0,Y         ; store command here
   8DEC 18 6F 01      [ 7] 1920         clr     1,Y         ; clear next byte
   8DEF 18 08         [ 4] 1921         iny
   8DF1 18 08         [ 4] 1922         iny
                           1923 
                           1924 ; Add characters at return address to LCD buffer
   8DF3 18 8C 05 80   [ 5] 1925         cpy     #0x0580       ; check for buffer overflow
   8DF7 25 04         [ 3] 1926         bcs     L8DFD  
   8DF9 18 CE 05 00   [ 4] 1927         ldy     #0x0500
   8DFD                    1928 L8DFD:
   8DFD 38            [ 5] 1929         pulx                ; get start of data
   8DFE DF 17         [ 4] 1930         stx     (0x0017)    ; save this here
   8E00                    1931 L8E00:
   8E00 A6 00         [ 4] 1932         ldaa    0,X         ; get character
   8E02 27 36         [ 3] 1933         beq     L8E3A       ; is it 00, if so jump ahead
   8E04 2B 17         [ 3] 1934         bmi     L8E1D       ; high bit set, if so jump ahead
   8E06 18 6F 00      [ 7] 1935         clr     0,Y         ; add character
   8E09 18 A7 01      [ 5] 1936         staa    1,Y     
   8E0C 08            [ 3] 1937         inx
   8E0D 18 08         [ 4] 1938         iny
   8E0F 18 08         [ 4] 1939         iny
   8E11 18 8C 05 80   [ 5] 1940         cpy     #0x0580     ; check for buffer overflow
   8E15 25 E9         [ 3] 1941         bcs     L8E00  
   8E17 18 CE 05 00   [ 4] 1942         ldy     #0x0500
   8E1B 20 E3         [ 3] 1943         bra     L8E00  
                           1944 
   8E1D                    1945 L8E1D:
   8E1D 84 7F         [ 2] 1946         anda    #0x7F
   8E1F 18 6F 00      [ 7] 1947         clr     0,Y          ; add character
   8E22 18 A7 01      [ 5] 1948         staa    1,Y     
   8E25 18 6F 02      [ 7] 1949         clr     2,Y     
   8E28 18 6F 03      [ 7] 1950         clr     3,Y     
   8E2B 08            [ 3] 1951         inx
   8E2C 18 08         [ 4] 1952         iny
   8E2E 18 08         [ 4] 1953         iny
   8E30 18 8C 05 80   [ 5] 1954         cpy     #0x0580       ; check for overflow
   8E34 25 04         [ 3] 1955         bcs     L8E3A  
   8E36 18 CE 05 00   [ 4] 1956         ldy     #0x0500
                           1957 
   8E3A                    1958 L8E3A:
   8E3A 3C            [ 4] 1959         pshx                ; put SP back
   8E3B 86 01         [ 2] 1960         ldaa    #0x01
   8E3D 97 43         [ 3] 1961         staa    (0x0043)    ; semaphore?
   8E3F DC 46         [ 4] 1962         ldd     (0x0046)
   8E41 18 6F 00      [ 7] 1963         clr     0,Y     
   8E44 18 6F 01      [ 7] 1964         clr     1,Y     
   8E47 18 DF 46      [ 5] 1965         sty     (0x0046)     ; save buffer pointer
   8E4A 39            [ 5] 1966         rts
                           1967 
                           1968 ; buffer LCD command?
   8E4B                    1969 L8E4B:
   8E4B 18 DE 46      [ 5] 1970         ldy     (0x0046)
   8E4E 18 A7 00      [ 5] 1971         staa    0,Y     
   8E51 18 6F 01      [ 7] 1972         clr     1,Y     
   8E54 18 08         [ 4] 1973         iny
   8E56 18 08         [ 4] 1974         iny
   8E58 18 8C 05 80   [ 5] 1975         cpy     #0x0580
   8E5C 25 04         [ 3] 1976         bcs     L8E62  
   8E5E 18 CE 05 00   [ 4] 1977         ldy     #0x0500
   8E62                    1978 L8E62:
   8E62 18 6F 00      [ 7] 1979         clr     0,Y     
   8E65 18 6F 01      [ 7] 1980         clr     1,Y     
   8E68 86 01         [ 2] 1981         ldaa    #0x01
   8E6A 97 43         [ 3] 1982         staa    (0x0043)
   8E6C 18 DF 46      [ 5] 1983         sty     (0x0046)
   8E6F 39            [ 5] 1984         rts
                           1985 
   8E70                    1986 L8E70:
   8E70 18 DE 46      [ 5] 1987         ldy     (0x0046)
   8E73 18 6F 00      [ 7] 1988         clr     0,Y     
   8E76 18 A7 01      [ 5] 1989         staa    1,Y     
   8E79 18 08         [ 4] 1990         iny
   8E7B 18 08         [ 4] 1991         iny
   8E7D 18 8C 05 80   [ 5] 1992         cpy     #0x0580
   8E81 25 04         [ 3] 1993         bcs     L8E87  
   8E83 18 CE 05 00   [ 4] 1994         ldy     #0x0500
   8E87                    1995 L8E87:
   8E87 18 6F 00      [ 7] 1996         clr     0,Y     
   8E8A 18 6F 01      [ 7] 1997         clr     1,Y     
   8E8D 86 01         [ 2] 1998         ldaa    #0x01
   8E8F 97 43         [ 3] 1999         staa    (0x0043)
   8E91 18 DF 46      [ 5] 2000         sty     (0x0046)
   8E94 39            [ 5] 2001         rts
                           2002 
   8E95                    2003 L8E95:
   8E95 96 30         [ 3] 2004         ldaa    (0x0030)
   8E97 26 09         [ 3] 2005         bne     L8EA2  
   8E99 96 31         [ 3] 2006         ldaa    (0x0031)
   8E9B 26 11         [ 3] 2007         bne     L8EAE  
   8E9D 96 32         [ 3] 2008         ldaa    (0x0032)
   8E9F 26 19         [ 3] 2009         bne     L8EBA  
   8EA1 39            [ 5] 2010         rts
                           2011 
                           2012 ;;;;;;;;;;;;;;;;;;;;;;;;;;
                           2013 
   8EA2                    2014 L8EA2:
   8EA2 7F 00 30      [ 6] 2015         clr     (0x0030)
   8EA5 7F 00 32      [ 6] 2016         clr     (0x0032)
   8EA8 7F 00 31      [ 6] 2017         clr     (0x0031)
   8EAB 86 01         [ 2] 2018         ldaa    #0x01
   8EAD 39            [ 5] 2019         rts
                           2020 
   8EAE                    2021 L8EAE:
   8EAE 7F 00 31      [ 6] 2022         clr     (0x0031)
   8EB1 7F 00 30      [ 6] 2023         clr     (0x0030)
   8EB4 7F 00 32      [ 6] 2024         clr     (0x0032)
   8EB7 86 02         [ 2] 2025         ldaa    #0x02
   8EB9 39            [ 5] 2026         rts
                           2027 
   8EBA                    2028 L8EBA:
   8EBA 7F 00 32      [ 6] 2029         clr     (0x0032)
   8EBD 7F 00 30      [ 6] 2030         clr     (0x0030)
   8EC0 7F 00 31      [ 6] 2031         clr     (0x0031)
   8EC3 86 0D         [ 2] 2032         ldaa    #0x0D
   8EC5 39            [ 5] 2033         rts
                           2034 
   8EC6                    2035 L8EC6:
   8EC6 B6 18 04      [ 4] 2036         ldaa    PIA0PRA 
   8EC9 84 07         [ 2] 2037         anda    #0x07
   8ECB 97 2C         [ 3] 2038         staa    (0x002C)
   8ECD 78 00 2C      [ 6] 2039         asl     (0x002C)
   8ED0 78 00 2C      [ 6] 2040         asl     (0x002C)
   8ED3 78 00 2C      [ 6] 2041         asl     (0x002C)
   8ED6 78 00 2C      [ 6] 2042         asl     (0x002C)
   8ED9 78 00 2C      [ 6] 2043         asl     (0x002C)
   8EDC CE 00 00      [ 3] 2044         ldx     #0x0000
   8EDF                    2045 L8EDF:
   8EDF 8C 00 03      [ 4] 2046         cpx     #0x0003
   8EE2 27 24         [ 3] 2047         beq     L8F08  
   8EE4 78 00 2C      [ 6] 2048         asl     (0x002C)
   8EE7 25 12         [ 3] 2049         bcs     L8EFB  
   8EE9 A6 2D         [ 4] 2050         ldaa    0x2D,X
   8EEB 81 0F         [ 2] 2051         cmpa    #0x0F
   8EED 24 1A         [ 3] 2052         bcc     L8F09  
   8EEF 6C 2D         [ 6] 2053         inc     0x2D,X
   8EF1 A6 2D         [ 4] 2054         ldaa    0x2D,X
   8EF3 81 02         [ 2] 2055         cmpa    #0x02
   8EF5 26 02         [ 3] 2056         bne     L8EF9  
   8EF7 A7 30         [ 4] 2057         staa    0x30,X
   8EF9                    2058 L8EF9:
   8EF9 20 0A         [ 3] 2059         bra     L8F05  
   8EFB                    2060 L8EFB:
   8EFB 6F 2D         [ 6] 2061         clr     0x2D,X
   8EFD 20 06         [ 3] 2062         bra     L8F05  
   8EFF A6 2D         [ 4] 2063         ldaa    0x2D,X
   8F01 27 02         [ 3] 2064         beq     L8F05  
   8F03 6A 2D         [ 6] 2065         dec     0x2D,X
   8F05                    2066 L8F05:
   8F05 08            [ 3] 2067         inx
   8F06 20 D7         [ 3] 2068         bra     L8EDF  
   8F08                    2069 L8F08:
   8F08 39            [ 5] 2070         rts
                           2071 
   8F09                    2072 L8F09:
   8F09 8C 00 02      [ 4] 2073         cpx     #0x0002
   8F0C 27 02         [ 3] 2074         beq     L8F10  
   8F0E 6F 2D         [ 6] 2075         clr     0x2D,X
   8F10                    2076 L8F10:
   8F10 20 F3         [ 3] 2077         bra     L8F05
                           2078 
   8F12                    2079 L8F12:
   8F12 B6 10 0A      [ 4] 2080         ldaa    PORTE
   8F15 97 51         [ 3] 2081         staa    (0x0051)
   8F17 CE 00 00      [ 3] 2082         ldx     #0x0000
   8F1A                    2083 L8F1A:
   8F1A 8C 00 08      [ 4] 2084         cpx     #0x0008
   8F1D 27 22         [ 3] 2085         beq     L8F41  
   8F1F 77 00 51      [ 6] 2086         asr     (0x0051)
   8F22 25 10         [ 3] 2087         bcs     L8F34  
   8F24 A6 52         [ 4] 2088         ldaa    0x52,X
   8F26 81 0F         [ 2] 2089         cmpa    #0x0F
   8F28 6C 52         [ 6] 2090         inc     0x52,X
   8F2A A6 52         [ 4] 2091         ldaa    0x52,X
   8F2C 81 04         [ 2] 2092         cmpa    #0x04
   8F2E 26 02         [ 3] 2093         bne     L8F32  
   8F30 A7 5A         [ 4] 2094         staa    0x5A,X
   8F32                    2095 L8F32:
   8F32 20 0A         [ 3] 2096         bra     L8F3E  
   8F34                    2097 L8F34:
   8F34 6F 52         [ 6] 2098         clr     0x52,X
   8F36 20 06         [ 3] 2099         bra     L8F3E  
   8F38 A6 52         [ 4] 2100         ldaa    0x52,X
   8F3A 27 02         [ 3] 2101         beq     L8F3E  
   8F3C 6A 52         [ 6] 2102         dec     0x52,X
   8F3E                    2103 L8F3E:
   8F3E 08            [ 3] 2104         inx
   8F3F 20 D9         [ 3] 2105         bra     L8F1A  
   8F41                    2106 L8F41:
   8F41 39            [ 5] 2107         rts
                           2108 
   8F42 6F 52         [ 6] 2109         clr     0x52,X
   8F44 20 F8         [ 3] 2110         bra     L8F3E  
                           2111 
   8F46                    2112 L8F46:
   8F46 30 2E 35           2113         .ascii      '0.5'
   8F49 31 2E 30           2114         .ascii      '1.0'
   8F4C 31 2E 35           2115         .ascii      '1.5'
   8F4F 32 2E 30           2116         .ascii      '2.0'
   8F52 32 2E 35           2117         .ascii      '2.5'
   8F55 33 2E 30           2118         .ascii      '3.0'
                           2119 
   8F58                    2120 L8F58:
   8F58 3C            [ 4] 2121         pshx
   8F59 96 12         [ 3] 2122         ldaa    (0x0012)
   8F5B 80 01         [ 2] 2123         suba    #0x01
   8F5D C6 03         [ 2] 2124         ldab    #0x03
   8F5F 3D            [10] 2125         mul
   8F60 CE 8F 46      [ 3] 2126         ldx     #L8F46
   8F63 3A            [ 3] 2127         abx
   8F64 C6 2C         [ 2] 2128         ldab    #0x2C
   8F66                    2129 L8F66:
   8F66 A6 00         [ 4] 2130         ldaa    0,X     
   8F68 08            [ 3] 2131         inx
   8F69 BD 8D B5      [ 6] 2132         jsr     L8DB5         ; display char here on LCD display
   8F6C 5C            [ 2] 2133         incb
   8F6D C1 2F         [ 2] 2134         cmpb    #0x2F
   8F6F 26 F5         [ 3] 2135         bne     L8F66  
   8F71 38            [ 5] 2136         pulx
   8F72 39            [ 5] 2137         rts
                           2138 
   8F73                    2139 L8F73:
   8F73 36            [ 3] 2140         psha
   8F74 BD 8C F2      [ 6] 2141         jsr     L8CF2
   8F77 C6 02         [ 2] 2142         ldab    #0x02
   8F79 BD 8C 30      [ 6] 2143         jsr     DLYSECSBY2   
   8F7C 32            [ 4] 2144         pula
   8F7D 97 B4         [ 3] 2145         staa    (0x00B4)
   8F7F 81 03         [ 2] 2146         cmpa    #0x03
   8F81 26 11         [ 3] 2147         bne     L8F94  
                           2148 
   8F83 BD 8D E4      [ 6] 2149         jsr     LCDMSG1 
   8F86 43 68 75 63 6B 20  2150         .ascis  'Chuck    '
        20 20 A0
                           2151 
   8F8F CE 90 72      [ 3] 2152         ldx     #L9072
   8F92 20 4D         [ 3] 2153         bra     L8FE1  
   8F94                    2154 L8F94:
   8F94 81 04         [ 2] 2155         cmpa    #0x04
   8F96 26 11         [ 3] 2156         bne     L8FA9  
                           2157 
   8F98 BD 8D E4      [ 6] 2158         jsr     LCDMSG1 
   8F9B 4A 61 73 70 65 72  2159         .ascis  'Jasper   '
        20 20 A0
                           2160 
   8FA4 CE 90 DE      [ 3] 2161         ldx     #0x90DE
   8FA7 20 38         [ 3] 2162         bra     L8FE1  
   8FA9                    2163 L8FA9:
   8FA9 81 05         [ 2] 2164         cmpa    #0x05
   8FAB 26 11         [ 3] 2165         bne     L8FBE  
                           2166 
   8FAD BD 8D E4      [ 6] 2167         jsr     LCDMSG1 
   8FB0 50 61 73 71 75 61  2168         .ascis  'Pasqually'
        6C 6C F9
                           2169 
   8FB9 CE 91 45      [ 3] 2170         ldx     #0x9145
   8FBC 20 23         [ 3] 2171         bra     L8FE1  
   8FBE                    2172 L8FBE:
   8FBE 81 06         [ 2] 2173         cmpa    #0x06
   8FC0 26 11         [ 3] 2174         bne     L8FD3  
                           2175 
   8FC2 BD 8D E4      [ 6] 2176         jsr     LCDMSG1 
   8FC5 4D 75 6E 63 68 20  2177         .ascis  'Munch    '
        20 20 A0
                           2178 
   8FCE CE 91 BA      [ 3] 2179         ldx     #0x91BA
   8FD1 20 0E         [ 3] 2180         bra     L8FE1  
   8FD3                    2181 L8FD3:
   8FD3 BD 8D E4      [ 6] 2182         jsr     LCDMSG1 
   8FD6 48 65 6C 65 6E 20  2183         .ascis  'Helen   '
        20 A0
                           2184 
   8FDE CE 92 26      [ 3] 2185         ldx     #0x9226
   8FE1                    2186 L8FE1:
   8FE1 96 B4         [ 3] 2187         ldaa    (0x00B4)
   8FE3 80 03         [ 2] 2188         suba    #0x03
   8FE5 48            [ 2] 2189         asla
   8FE6 48            [ 2] 2190         asla
   8FE7 97 4B         [ 3] 2191         staa    (0x004B)
   8FE9 BD 95 04      [ 6] 2192         jsr     L9504
   8FEC 97 4C         [ 3] 2193         staa    (0x004C)
   8FEE 81 0F         [ 2] 2194         cmpa    #0x0F
   8FF0 26 01         [ 3] 2195         bne     L8FF3  
   8FF2 39            [ 5] 2196         rts
                           2197 
   8FF3                    2198 L8FF3:
   8FF3 81 08         [ 2] 2199         cmpa    #0x08
   8FF5 23 08         [ 3] 2200         bls     L8FFF  
   8FF7 80 08         [ 2] 2201         suba    #0x08
   8FF9 D6 4B         [ 3] 2202         ldab    (0x004B)
   8FFB CB 02         [ 2] 2203         addb    #0x02
   8FFD D7 4B         [ 3] 2204         stab    (0x004B)
   8FFF                    2205 L8FFF:
   8FFF 36            [ 3] 2206         psha
   9000 18 DE 46      [ 5] 2207         ldy     (0x0046)
   9003 32            [ 4] 2208         pula
   9004 5F            [ 2] 2209         clrb
   9005 0D            [ 2] 2210         sec
   9006                    2211 L9006:
   9006 59            [ 2] 2212         rolb
   9007 4A            [ 2] 2213         deca
   9008 26 FC         [ 3] 2214         bne     L9006  
   900A D7 50         [ 3] 2215         stab    (0x0050)
   900C D6 4B         [ 3] 2216         ldab    (0x004B)
   900E CE 10 80      [ 3] 2217         ldx     #0x1080
   9011 3A            [ 3] 2218         abx
   9012 86 02         [ 2] 2219         ldaa    #0x02
   9014 97 12         [ 3] 2220         staa    (0x0012)
   9016                    2221 L9016:
   9016 A6 00         [ 4] 2222         ldaa    0,X     
   9018 98 50         [ 3] 2223         eora    (0x0050)
   901A A7 00         [ 4] 2224         staa    0,X     
   901C 6D 00         [ 6] 2225         tst     0,X     
   901E 27 16         [ 3] 2226         beq     L9036  
   9020 86 4F         [ 2] 2227         ldaa    #0x4F            ;'O'
   9022 C6 0C         [ 2] 2228         ldab    #0x0C        
   9024 BD 8D B5      [ 6] 2229         jsr     L8DB5            ; display char here on LCD display
   9027 86 6E         [ 2] 2230         ldaa    #0x6E            ;'n'
   9029 C6 0D         [ 2] 2231         ldab    #0x0D
   902B BD 8D B5      [ 6] 2232         jsr     L8DB5            ; display char here on LCD display
   902E CC 20 0E      [ 3] 2233         ldd     #0x200E          ;' '
   9031 BD 8D B5      [ 6] 2234         jsr     L8DB5            ; display char here on LCD display
   9034 20 0E         [ 3] 2235         bra     L9044  
   9036                    2236 L9036:
   9036 86 66         [ 2] 2237         ldaa    #0x66            ;'f'
   9038 C6 0D         [ 2] 2238         ldab    #0x0D
   903A BD 8D B5      [ 6] 2239         jsr     L8DB5            ; display char here on LCD display
   903D 86 66         [ 2] 2240         ldaa    #0x66            ;'f'
   903F C6 0E         [ 2] 2241         ldab    #0x0E
   9041 BD 8D B5      [ 6] 2242         jsr     L8DB5            ; display char here on LCD display
   9044                    2243 L9044:
   9044 D6 12         [ 3] 2244         ldab    (0x0012)
   9046 BD 8C 30      [ 6] 2245         jsr     DLYSECSBY2            ; delay in half-seconds
   9049 BD 8E 95      [ 6] 2246         jsr     L8E95
   904C 81 0D         [ 2] 2247         cmpa    #0x0D
   904E 27 14         [ 3] 2248         beq     L9064  
   9050 20 C4         [ 3] 2249         bra     L9016  
   9052 81 02         [ 2] 2250         cmpa    #0x02
   9054 26 C0         [ 3] 2251         bne     L9016  
   9056 96 12         [ 3] 2252         ldaa    (0x0012)
   9058 81 06         [ 2] 2253         cmpa    #0x06
   905A 27 BA         [ 3] 2254         beq     L9016  
   905C 4C            [ 2] 2255         inca
   905D 97 12         [ 3] 2256         staa    (0x0012)
   905F BD 8F 58      [ 6] 2257         jsr     L8F58
   9062 20 B2         [ 3] 2258         bra     L9016  
   9064                    2259 L9064:
   9064 A6 00         [ 4] 2260         ldaa    0,X     
   9066 9A 50         [ 3] 2261         oraa    (0x0050)
   9068 98 50         [ 3] 2262         eora    (0x0050)
   906A A7 00         [ 4] 2263         staa    0,X     
   906C 96 B4         [ 3] 2264         ldaa    (0x00B4)
   906E 7E 8F 73      [ 3] 2265         jmp     L8F73
   9071 39            [ 5] 2266         rts
                           2267 
   9072                    2268 L9072:
   9072 4D 6F 75 74 68 2C  2269         .ascis  'Mouth,Head left,Head right,Head up,Eyes right,Eyelids,Right hand,Eyes left,DS9,DS10,DS11,DS12,DS13,DS14,Exit'
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
   90DE 4D 6F 75 74 68 2C  2270         .ascis  'Mouth,Head left,Head right,Head up,Eyes right,Eyelids,Hands,Eyes left,DS9,DS10,DS11,DS12,DS13,DS14,Exit'
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
   9145 4D 6F 75 74 68 2D  2271         .ascis  'Mouth-Mustache,Head left,Head right,Left arm,Eyes right,Eyelids,Right arm,Eyes left,DS9,DS10,DS11,DS12,DS13,DS14,Exit'
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
   91BA 4D 6F 75 74 68 2C  2272         .ascis  'Mouth,Head left,Head right,Left arm,Eyes right,Eyelids,Right arm,Eyes left,DS9,DS10,DS11,DS12,DS13,DS14,Exit'
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
   9226 4D 6F 75 74 68 2C  2273         .ascis  'Mouth,Head left,Head right,Head up,Eyes right,Eyelids,Right hand,Eyes left,DS9,DS10,DS11,DS12,DS13,DS14,Exit'
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
                           2274         
                           2275 ; code again
   9292                    2276 L9292:
   9292 BD 86 C4      [ 6] 2277         jsr     L86C4                ; Reset boards 1-10
   9295                    2278 L9295:
   9295 C6 01         [ 2] 2279         ldab    #0x01
   9297 BD 8C 30      [ 6] 2280         jsr     DLYSECSBY2           ; delay 0.5 sec
                           2281 
   929A BD 8D E4      [ 6] 2282         jsr     LCDMSG1 
   929D 20 20 44 69 61 67  2283         .ascis  '  Diagnostics   '
        6E 6F 73 74 69 63
        73 20 20 A0
                           2284 
   92AD BD 8D DD      [ 6] 2285         jsr     LCDMSG2 
   92B0 20 20 20 20 20 20  2286         .ascis  '                '
        20 20 20 20 20 20
        20 20 20 A0
                           2287 
   92C0 C6 01         [ 2] 2288         ldab    #0x01
   92C2 BD 8C 30      [ 6] 2289         jsr     DLYSECSBY2           ; delay 0.5 sec
   92C5 BD 8D 03      [ 6] 2290         jsr     L8D03
   92C8 CE 93 D3      [ 3] 2291         ldx     #L93D3
   92CB BD 95 04      [ 6] 2292         jsr     L9504
   92CE 81 11         [ 2] 2293         cmpa    #0x11
   92D0 26 14         [ 3] 2294         bne     L92E6
   92D2                    2295 L92D2:
   92D2 BD 86 C4      [ 6] 2296         jsr     L86C4               ; Reset boards 1-10
   92D5 5F            [ 2] 2297         clrb
   92D6 D7 62         [ 3] 2298         stab    (0x0062)
   92D8 BD F9 C5      [ 6] 2299         jsr     BUTNLIT 
   92DB B6 18 04      [ 4] 2300         ldaa    PIA0PRA 
   92DE 84 BF         [ 2] 2301         anda    #0xBF
   92E0 B7 18 04      [ 4] 2302         staa    PIA0PRA 
   92E3 7E 81 D7      [ 3] 2303         jmp     L81D7
   92E6                    2304 L92E6:
   92E6 81 03         [ 2] 2305         cmpa    #0x03
   92E8 25 09         [ 3] 2306         bcs     L92F3  
   92EA 81 08         [ 2] 2307         cmpa    #0x08
   92EC 24 05         [ 3] 2308         bcc     L92F3  
   92EE BD 8F 73      [ 6] 2309         jsr     L8F73
   92F1 20 A2         [ 3] 2310         bra     L9295  
   92F3                    2311 L92F3:
   92F3 81 02         [ 2] 2312         cmpa    #0x02
   92F5 26 08         [ 3] 2313         bne     L92FF  
   92F7 BD 9F 1E      [ 6] 2314         jsr     L9F1E
   92FA 25 99         [ 3] 2315         bcs     L9295  
   92FC 7E 96 75      [ 3] 2316         jmp     L9675
   92FF                    2317 L92FF:
   92FF 81 0B         [ 2] 2318         cmpa    #0x0B
   9301 26 0D         [ 3] 2319         bne     L9310  
   9303 BD 8D 03      [ 6] 2320         jsr     L8D03
   9306 BD 9E CC      [ 6] 2321         jsr     L9ECC
   9309 C6 03         [ 2] 2322         ldab    #0x03
   930B BD 8C 30      [ 6] 2323         jsr     DLYSECSBY2           ; delay 1.5 sec
   930E 20 85         [ 3] 2324         bra     L9295  
   9310                    2325 L9310:
   9310 81 09         [ 2] 2326         cmpa    #0x09
   9312 26 0E         [ 3] 2327         bne     L9322  
   9314 BD 9F 1E      [ 6] 2328         jsr     L9F1E
   9317 24 03         [ 3] 2329         bcc     L931C  
   9319 7E 92 95      [ 3] 2330         jmp     L9295
   931C                    2331 L931C:
   931C BD 9E 92      [ 6] 2332         jsr     L9E92               ; reset R counts
   931F 7E 92 95      [ 3] 2333         jmp     L9295
   9322                    2334 L9322:
   9322 81 0A         [ 2] 2335         cmpa    #0x0A
   9324 26 0B         [ 3] 2336         bne     L9331  
   9326 BD 9F 1E      [ 6] 2337         jsr     L9F1E
   9329 25 03         [ 3] 2338         bcs     L932E  
   932B BD 9E AF      [ 6] 2339         jsr     L9EAF               ; reset L counts
   932E                    2340 L932E:
   932E 7E 92 95      [ 3] 2341         jmp     L9295
   9331                    2342 L9331:
   9331 81 01         [ 2] 2343         cmpa    #0x01
   9333 26 03         [ 3] 2344         bne     L9338  
   9335 7E A0 E9      [ 3] 2345         jmp     LA0E9
   9338                    2346 L9338:
   9338 81 08         [ 2] 2347         cmpa    #0x08
   933A 26 1F         [ 3] 2348         bne     L935B  
   933C BD 9F 1E      [ 6] 2349         jsr     L9F1E
   933F 25 1A         [ 3] 2350         bcs     L935B  
                           2351 
   9341 BD 8D E4      [ 6] 2352         jsr     LCDMSG1 
   9344 52 65 73 65 74 20  2353         .ascis  'Reset System!'
        53 79 73 74 65 6D
        A1
                           2354 
   9351 7E A2 49      [ 3] 2355         jmp     LA249
   9354 C6 02         [ 2] 2356         ldab    #0x02
   9356 BD 8C 30      [ 6] 2357         jsr     DLYSECSBY2           ; delay 1 sec
   9359 20 18         [ 3] 2358         bra     L9373  
   935B                    2359 L935B:
   935B 81 0C         [ 2] 2360         cmpa    #0x0C
   935D 26 14         [ 3] 2361         bne     L9373  
   935F BD 8B 48      [ 6] 2362         jsr     L8B48
   9362 5F            [ 2] 2363         clrb
   9363 D7 62         [ 3] 2364         stab    (0x0062)
   9365 BD F9 C5      [ 6] 2365         jsr     BUTNLIT 
   9368 B6 18 04      [ 4] 2366         ldaa    PIA0PRA 
   936B 84 BF         [ 2] 2367         anda    #0xBF
   936D B7 18 04      [ 4] 2368         staa    PIA0PRA 
   9370 7E 92 92      [ 3] 2369         jmp     L9292
   9373                    2370 L9373:
   9373 81 0D         [ 2] 2371         cmpa    #0x0D
   9375 26 2E         [ 3] 2372         bne     L93A5  
   9377 BD 8C E9      [ 6] 2373         jsr     L8CE9
                           2374 
   937A BD 8D E4      [ 6] 2375         jsr     LCDMSG1 
   937D 20 20 42 75 74 74  2376         .ascis  '  Button  test'
        6F 6E 20 20 74 65
        73 F4
                           2377 
   938B BD 8D DD      [ 6] 2378         jsr     LCDMSG2 
   938E 20 20 20 50 52 4F  2379         .ascis  '   PROG exits'
        47 20 65 78 69 74
        F3
                           2380 
   939B BD A5 26      [ 6] 2381         jsr     LA526
   939E 5F            [ 2] 2382         clrb
   939F BD F9 C5      [ 6] 2383         jsr     BUTNLIT 
   93A2 7E 92 95      [ 3] 2384         jmp     L9295
   93A5                    2385 L93A5:
   93A5 81 0E         [ 2] 2386         cmpa    #0x0E
   93A7 26 10         [ 3] 2387         bne     L93B9  
   93A9 BD 9F 1E      [ 6] 2388         jsr     L9F1E
   93AC 24 03         [ 3] 2389         bcc     L93B1  
   93AE 7E 92 95      [ 3] 2390         jmp     L9295
   93B1                    2391 L93B1:
   93B1 C6 01         [ 2] 2392         ldab    #0x01
   93B3 BD 8C 30      [ 6] 2393         jsr     DLYSECSBY2           ; delay 0.5 sec
   93B6 7E 94 9A      [ 3] 2394         jmp     L949A
   93B9                    2395 L93B9:
   93B9 81 0F         [ 2] 2396         cmpa    #0x0F
   93BB 26 06         [ 3] 2397         bne     L93C3  
   93BD BD A8 6A      [ 6] 2398         jsr     LA86A
   93C0 7E 92 95      [ 3] 2399         jmp     L9295
   93C3                    2400 L93C3:
   93C3 81 10         [ 2] 2401         cmpa    #0x10
   93C5 26 09         [ 3] 2402         bne     L93D0  
   93C7 BD 9F 1E      [ 6] 2403         jsr     L9F1E
   93CA BD 95 BA      [ 6] 2404         jsr     L95BA
   93CD 7E 92 95      [ 3] 2405         jmp     L9295
                           2406 
   93D0                    2407 L93D0:
   93D0 7E 92 D2      [ 3] 2408         jmp     L92D2
                           2409 
   93D3                    2410 L93D3:
   93D3 56 43 52 20 61 64  2411         .ascis  "VCR adjust,Set Random,Chuck E. Cheese,Jasper,Pasqually,Munch,Helen,Reset System,Reset reg tape#,Reset liv tape#,View Tape #'s,All Lights On,Button test,King enable,Warm-Up,Show Type,Quit Diagnostics"
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
   9499 00                 2412         .byte   0x00
                           2413 
   949A                    2414 L949A:
   949A 7D 04 2A      [ 6] 2415         tst     (0x042A)
   949D 27 27         [ 3] 2416         beq     L94C6  
                           2417 
   949F BD 8D E4      [ 6] 2418         jsr     LCDMSG1 
   94A2 4B 69 6E 67 20 69  2419         .ascis  'King is Enabled'
        73 20 45 6E 61 62
        6C 65 E4
                           2420 
   94B1 BD 8D DD      [ 6] 2421         jsr     LCDMSG2 
   94B4 45 4E 54 45 52 20  2422         .ascis  'ENTER to disable'
        74 6F 20 64 69 73
        61 62 6C E5
                           2423 
   94C4 20 25         [ 3] 2424         bra     L94EB  
                           2425 
   94C6                    2426 L94C6:
   94C6 BD 8D E4      [ 6] 2427         jsr     LCDMSG1 
   94C9 4B 69 6E 67 20 69  2428         .ascis  'King is Disabled'
        73 20 44 69 73 61
        62 6C 65 E4
                           2429 
   94D9 BD 8D DD      [ 6] 2430         jsr     LCDMSG2 
   94DC 45 4E 54 45 52 20  2431         .ascis  'ENTER to enable'
        74 6F 20 65 6E 61
        62 6C E5
                           2432 
   94EB                    2433 L94EB:
   94EB BD 8E 95      [ 6] 2434         jsr     L8E95
   94EE 4D            [ 2] 2435         tsta
   94EF 27 FA         [ 3] 2436         beq     L94EB  
   94F1 81 0D         [ 2] 2437         cmpa    #0x0D
   94F3 27 02         [ 3] 2438         beq     L94F7  
   94F5 20 0A         [ 3] 2439         bra     L9501  
   94F7                    2440 L94F7:
   94F7 B6 04 2A      [ 4] 2441         ldaa    (0x042A)
   94FA 84 01         [ 2] 2442         anda    #0x01
   94FC 88 01         [ 2] 2443         eora    #0x01
   94FE B7 04 2A      [ 4] 2444         staa    (0x042A)
   9501                    2445 L9501:
   9501 7E 92 95      [ 3] 2446         jmp     L9295
   9504                    2447 L9504:
   9504 86 01         [ 2] 2448         ldaa    #0x01
   9506 97 A6         [ 3] 2449         staa    (0x00A6)
   9508 97 A7         [ 3] 2450         staa    (0x00A7)
   950A DF 12         [ 4] 2451         stx     (0x0012)
   950C 20 09         [ 3] 2452         bra     L9517  
   950E 86 01         [ 2] 2453         ldaa    #0x01
   9510 97 A7         [ 3] 2454         staa    (0x00A7)
   9512 7F 00 A6      [ 6] 2455         clr     (0x00A6)
   9515 DF 12         [ 4] 2456         stx     (0x0012)
   9517                    2457 L9517:
   9517 7F 00 16      [ 6] 2458         clr     (0x0016)
   951A 18 DE 46      [ 5] 2459         ldy     (0x0046)
   951D 7D 00 A6      [ 6] 2460         tst     (0x00A6)
   9520 26 07         [ 3] 2461         bne     L9529  
   9522 BD 8C F2      [ 6] 2462         jsr     L8CF2
   9525 86 80         [ 2] 2463         ldaa    #0x80
   9527 20 05         [ 3] 2464         bra     L952E  
   9529                    2465 L9529:
   9529 BD 8D 03      [ 6] 2466         jsr     L8D03
   952C 86 C0         [ 2] 2467         ldaa    #0xC0
   952E                    2468 L952E:
   952E 18 A7 00      [ 5] 2469         staa    0,Y     
   9531 18 6F 01      [ 7] 2470         clr     1,Y     
   9534 18 08         [ 4] 2471         iny
   9536 18 08         [ 4] 2472         iny
   9538 18 8C 05 80   [ 5] 2473         cpy     #0x0580
   953C 25 04         [ 3] 2474         bcs     L9542  
   953E 18 CE 05 00   [ 4] 2475         ldy     #0x0500
   9542                    2476 L9542:
   9542 DF 14         [ 4] 2477         stx     (0x0014)
   9544                    2478 L9544:
   9544 A6 00         [ 4] 2479         ldaa    0,X     
   9546 2A 04         [ 3] 2480         bpl     L954C  
   9548 C6 01         [ 2] 2481         ldab    #0x01
   954A D7 16         [ 3] 2482         stab    (0x0016)
   954C                    2483 L954C:
   954C 81 2C         [ 2] 2484         cmpa    #0x2C
   954E 27 1E         [ 3] 2485         beq     L956E  
   9550 18 6F 00      [ 7] 2486         clr     0,Y     
   9553 84 7F         [ 2] 2487         anda    #0x7F
   9555 18 A7 01      [ 5] 2488         staa    1,Y     
   9558 18 08         [ 4] 2489         iny
   955A 18 08         [ 4] 2490         iny
   955C 18 8C 05 80   [ 5] 2491         cpy     #0x0580
   9560 25 04         [ 3] 2492         bcs     L9566  
   9562 18 CE 05 00   [ 4] 2493         ldy     #0x0500
   9566                    2494 L9566:
   9566 7D 00 16      [ 6] 2495         tst     (0x0016)
   9569 26 03         [ 3] 2496         bne     L956E  
   956B 08            [ 3] 2497         inx
   956C 20 D6         [ 3] 2498         bra     L9544  
   956E                    2499 L956E:
   956E 08            [ 3] 2500         inx
   956F 86 01         [ 2] 2501         ldaa    #0x01
   9571 97 43         [ 3] 2502         staa    (0x0043)
   9573 18 6F 00      [ 7] 2503         clr     0,Y     
   9576 18 6F 01      [ 7] 2504         clr     1,Y     
   9579 18 DF 46      [ 5] 2505         sty     (0x0046)
   957C                    2506 L957C:
   957C BD 8E 95      [ 6] 2507         jsr     L8E95
   957F 27 FB         [ 3] 2508         beq     L957C  
   9581 81 02         [ 2] 2509         cmpa    #0x02
   9583 26 0A         [ 3] 2510         bne     L958F  
   9585 7D 00 16      [ 6] 2511         tst     (0x0016)
   9588 26 05         [ 3] 2512         bne     L958F  
   958A 7C 00 A7      [ 6] 2513         inc     (0x00A7)
   958D 20 88         [ 3] 2514         bra     L9517  
   958F                    2515 L958F:
   958F 81 01         [ 2] 2516         cmpa    #0x01
   9591 26 20         [ 3] 2517         bne     L95B3  
   9593 18 DE 14      [ 5] 2518         ldy     (0x0014)
   9596 18 9C 12      [ 6] 2519         cpy     (0x0012)
   9599 23 E1         [ 3] 2520         bls     L957C  
   959B 7A 00 A7      [ 6] 2521         dec     (0x00A7)
   959E DE 14         [ 4] 2522         ldx     (0x0014)
   95A0 09            [ 3] 2523         dex
   95A1                    2524 L95A1:
   95A1 09            [ 3] 2525         dex
   95A2 9C 12         [ 5] 2526         cpx     (0x0012)
   95A4 26 03         [ 3] 2527         bne     L95A9  
   95A6 7E 95 17      [ 3] 2528         jmp     L9517
   95A9                    2529 L95A9:
   95A9 A6 00         [ 4] 2530         ldaa    0,X     
   95AB 81 2C         [ 2] 2531         cmpa    #0x2C
   95AD 26 F2         [ 3] 2532         bne     L95A1  
   95AF 08            [ 3] 2533         inx
   95B0 7E 95 17      [ 3] 2534         jmp     L9517
   95B3                    2535 L95B3:
   95B3 81 0D         [ 2] 2536         cmpa    #0x0D
   95B5 26 C5         [ 3] 2537         bne     L957C  
   95B7 96 A7         [ 3] 2538         ldaa    (0x00A7)
   95B9 39            [ 5] 2539         rts
                           2540 
   95BA                    2541 L95BA:
   95BA B6 04 5C      [ 4] 2542         ldaa    (0x045C)
   95BD 27 14         [ 3] 2543         beq     L95D3  
                           2544 
   95BF BD 8D E4      [ 6] 2545         jsr     LCDMSG1 
   95C2 43 75 72 72 65 6E  2546         .ascis  'Current: CNR   '
        74 3A 20 43 4E 52
        20 20 A0
                           2547 
   95D1 20 12         [ 3] 2548         bra     L95E5  
                           2549 
   95D3                    2550 L95D3:
   95D3 BD 8D E4      [ 6] 2551         jsr     LCDMSG1 
   95D6 43 75 72 72 65 6E  2552         .ascis  'Current: R12   '
        74 3A 20 52 31 32
        20 20 A0
                           2553 
   95E5                    2554 L95E5:
   95E5 BD 8D DD      [ 6] 2555         jsr     LCDMSG2 
   95E8 3C 45 6E 74 65 72  2556         .ascis  '<Enter> to chg.'
        3E 20 74 6F 20 63
        68 67 AE
                           2557 
   95F7                    2558 L95F7:
   95F7 BD 8E 95      [ 6] 2559         jsr     L8E95
   95FA 27 FB         [ 3] 2560         beq     L95F7  
   95FC 81 0D         [ 2] 2561         cmpa    #0x0D
   95FE 26 0F         [ 3] 2562         bne     L960F  
   9600 B6 04 5C      [ 4] 2563         ldaa    (0x045C)
   9603 27 05         [ 3] 2564         beq     L960A  
   9605 7F 04 5C      [ 6] 2565         clr     (0x045C)
   9608 20 05         [ 3] 2566         bra     L960F  
   960A                    2567 L960A:
   960A 86 01         [ 2] 2568         ldaa    #0x01
   960C B7 04 5C      [ 4] 2569         staa    (0x045C)
   960F                    2570 L960F:
   960F 39            [ 5] 2571         rts
                           2572 
   9610                    2573 L9610:
   9610 43 68 75 63 6B 2C  2574         .ascis  "Chuck,Jasper,Pasqually,Munch,Helen,Light 1,Light 2,Light 3,Star EFX,Wink Spot,Gobo,Clear All Rnd,Exit"
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
                           2575 
   9675                    2576 L9675:
   9675 BD 8D E4      [ 6] 2577         jsr     LCDMSG1 
   9678 52 61 6E 64 6F 6D  2578         .ascis  'Random          '
        20 20 20 20 20 20
        20 20 20 A0
                           2579 
   9688 CE 96 10      [ 3] 2580         ldx     #L9610
   968B BD 95 04      [ 6] 2581         jsr     L9504
   968E 5F            [ 2] 2582         clrb
   968F 37            [ 3] 2583         pshb
   9690 81 0D         [ 2] 2584         cmpa    #0x0D
   9692 26 03         [ 3] 2585         bne     L9697  
   9694 7E 97 5B      [ 3] 2586         jmp     L975B
   9697                    2587 L9697:
   9697 81 0C         [ 2] 2588         cmpa    #0x0C
   9699 26 21         [ 3] 2589         bne     L96BC  
   969B 7F 04 01      [ 6] 2590         clr     (0x0401)
   969E 7F 04 2B      [ 6] 2591         clr     (0x042B)
                           2592 
   96A1 BD 8D E4      [ 6] 2593         jsr     LCDMSG1 
   96A4 41 6C 6C 20 52 6E  2594         .ascis  'All Rnd Cleared!'
        64 20 43 6C 65 61
        72 65 64 A1
                           2595 
   96B4 C6 64         [ 2] 2596         ldab    #0x64       ; delay 1 sec
   96B6 BD 8C 22      [ 6] 2597         jsr     DLYSECSBY100
   96B9 7E 97 5B      [ 3] 2598         jmp     L975B
   96BC                    2599 L96BC:
   96BC 81 09         [ 2] 2600         cmpa    #0x09
   96BE 25 05         [ 3] 2601         bcs     L96C5  
   96C0 80 08         [ 2] 2602         suba    #0x08
   96C2 33            [ 4] 2603         pulb
   96C3 5C            [ 2] 2604         incb
   96C4 37            [ 3] 2605         pshb
   96C5                    2606 L96C5:
   96C5 5F            [ 2] 2607         clrb
   96C6 0D            [ 2] 2608         sec
   96C7                    2609 L96C7:
   96C7 59            [ 2] 2610         rolb
   96C8 4A            [ 2] 2611         deca
   96C9 26 FC         [ 3] 2612         bne     L96C7  
   96CB D7 12         [ 3] 2613         stab    (0x0012)
   96CD C8 FF         [ 2] 2614         eorb    #0xFF
   96CF D7 13         [ 3] 2615         stab    (0x0013)
   96D1                    2616 L96D1:
   96D1 CC 20 34      [ 3] 2617         ldd     #0x2034           ;' '
   96D4 BD 8D B5      [ 6] 2618         jsr     L8DB5            ; display char here on LCD display
   96D7 33            [ 4] 2619         pulb
   96D8 37            [ 3] 2620         pshb
   96D9 5D            [ 2] 2621         tstb
   96DA 27 05         [ 3] 2622         beq     L96E1  
   96DC B6 04 2B      [ 4] 2623         ldaa    (0x042B)
   96DF 20 03         [ 3] 2624         bra     L96E4  
   96E1                    2625 L96E1:
   96E1 B6 04 01      [ 4] 2626         ldaa    (0x0401)
   96E4                    2627 L96E4:
   96E4 94 12         [ 3] 2628         anda    (0x0012)
   96E6 27 0A         [ 3] 2629         beq     L96F2  
   96E8 18 DE 46      [ 5] 2630         ldy     (0x0046)
   96EB BD 8D FD      [ 6] 2631         jsr     L8DFD
   96EE 4F            [ 2] 2632         clra
   96EF EE 20         [ 5] 2633         ldx     0x20,X
   96F1 09            [ 3] 2634         dex
   96F2                    2635 L96F2:
   96F2 18 DE 46      [ 5] 2636         ldy     (0x0046)
   96F5 BD 8D FD      [ 6] 2637         jsr     L8DFD
   96F8 4F            [ 2] 2638         clra
   96F9 66 E6         [ 6] 2639         ror     0xE6,X
   96FB CC 20 34      [ 3] 2640         ldd     #0x2034           ;' '
   96FE BD 8D B5      [ 6] 2641         jsr     L8DB5            ; display char here on LCD display
   9701                    2642 L9701:
   9701 BD 8E 95      [ 6] 2643         jsr     L8E95
   9704 27 FB         [ 3] 2644         beq     L9701  
   9706 81 01         [ 2] 2645         cmpa    #0x01
   9708 26 22         [ 3] 2646         bne     L972C  
   970A 33            [ 4] 2647         pulb
   970B 37            [ 3] 2648         pshb
   970C 5D            [ 2] 2649         tstb
   970D 27 0A         [ 3] 2650         beq     L9719  
   970F B6 04 2B      [ 4] 2651         ldaa    (0x042B)
   9712 9A 12         [ 3] 2652         oraa    (0x0012)
   9714 B7 04 2B      [ 4] 2653         staa    (0x042B)
   9717 20 08         [ 3] 2654         bra     L9721  
   9719                    2655 L9719:
   9719 B6 04 01      [ 4] 2656         ldaa    (0x0401)
   971C 9A 12         [ 3] 2657         oraa    (0x0012)
   971E B7 04 01      [ 4] 2658         staa    (0x0401)
   9721                    2659 L9721:
   9721 18 DE 46      [ 5] 2660         ldy     (0x0046)
   9724 BD 8D FD      [ 6] 2661         jsr     L8DFD
   9727 4F            [ 2] 2662         clra
   9728 6E A0         [ 3] 2663         jmp     0xA0,X
   972A 20 A5         [ 3] 2664         bra     L96D1  
   972C                    2665 L972C:
   972C 81 02         [ 2] 2666         cmpa    #0x02
   972E 26 23         [ 3] 2667         bne     L9753  
   9730 33            [ 4] 2668         pulb
   9731 37            [ 3] 2669         pshb
   9732 5D            [ 2] 2670         tstb
   9733 27 0A         [ 3] 2671         beq     L973F  
   9735 B6 04 2B      [ 4] 2672         ldaa    (0x042B)
   9738 94 13         [ 3] 2673         anda    (0x0013)
   973A B7 04 2B      [ 4] 2674         staa    (0x042B)
   973D 20 08         [ 3] 2675         bra     L9747  
   973F                    2676 L973F:
   973F B6 04 01      [ 4] 2677         ldaa    (0x0401)
   9742 94 13         [ 3] 2678         anda    (0x0013)
   9744 B7 04 01      [ 4] 2679         staa    (0x0401)
   9747                    2680 L9747:
   9747 18 DE 46      [ 5] 2681         ldy     (0x0046)
   974A BD 8D FD      [ 6] 2682         jsr     L8DFD
   974D 4F            [ 2] 2683         clra
   974E 66 E6         [ 6] 2684         ror     0xE6,X
   9750 7E 96 D1      [ 3] 2685         jmp     L96D1
   9753                    2686 L9753:
   9753 81 0D         [ 2] 2687         cmpa    #0x0D
   9755 26 AA         [ 3] 2688         bne     L9701  
   9757 33            [ 4] 2689         pulb
   9758 7E 96 75      [ 3] 2690         jmp     L9675
   975B                    2691 L975B:
   975B 33            [ 4] 2692         pulb
   975C 7E 92 92      [ 3] 2693         jmp     L9292
                           2694 
                           2695 ; do program rom checksum, and display it on the LCD screen
   975F                    2696 L975F:
   975F CE 00 00      [ 3] 2697         ldx     #0x0000
   9762 18 CE 80 00   [ 4] 2698         ldy     #0x8000
   9766                    2699 L9766:
   9766 18 E6 00      [ 5] 2700         ldab    0,Y     
   9769 18 08         [ 4] 2701         iny
   976B 3A            [ 3] 2702         abx
   976C 18 8C 00 00   [ 5] 2703         cpy     #0x0000
   9770 26 F4         [ 3] 2704         bne     L9766  
   9772 DF 17         [ 4] 2705         stx     (0x0017)        ; store rom checksum here
   9774 96 17         [ 3] 2706         ldaa    (0x0017)        ; get high byte of checksum
   9776 BD 97 9B      [ 6] 2707         jsr     L979B           ; convert it to 2 hex chars
   9779 96 12         [ 3] 2708         ldaa    (0x0012)
   977B C6 33         [ 2] 2709         ldab    #0x33
   977D BD 8D B5      [ 6] 2710         jsr     L8DB5           ; display char 1 here on LCD display
   9780 96 13         [ 3] 2711         ldaa    (0x0013)
   9782 C6 34         [ 2] 2712         ldab    #0x34
   9784 BD 8D B5      [ 6] 2713         jsr     L8DB5           ; display char 2 here on LCD display
   9787 96 18         [ 3] 2714         ldaa    (0x0018)        ; get low byte of checksum
   9789 BD 97 9B      [ 6] 2715         jsr     L979B           ; convert it to 2 hex chars
   978C 96 12         [ 3] 2716         ldaa    (0x0012)
   978E C6 35         [ 2] 2717         ldab    #0x35
   9790 BD 8D B5      [ 6] 2718         jsr     L8DB5           ; display char 1 here on LCD display
   9793 96 13         [ 3] 2719         ldaa    (0x0013)
   9795 C6 36         [ 2] 2720         ldab    #0x36
   9797 BD 8D B5      [ 6] 2721         jsr     L8DB5           ; display char 2 here on LCD display
   979A 39            [ 5] 2722         rts
                           2723 
                           2724 ; convert A to ASCII hex digit, store in (0x0012:0x0013)
   979B                    2725 L979B:
   979B 36            [ 3] 2726         psha
   979C 84 0F         [ 2] 2727         anda    #0x0F
   979E 8B 30         [ 2] 2728         adda    #0x30
   97A0 81 39         [ 2] 2729         cmpa    #0x39
   97A2 23 02         [ 3] 2730         bls     L97A6  
   97A4 8B 07         [ 2] 2731         adda    #0x07
   97A6                    2732 L97A6:
   97A6 97 13         [ 3] 2733         staa    (0x0013)
   97A8 32            [ 4] 2734         pula
   97A9 84 F0         [ 2] 2735         anda    #0xF0
   97AB 44            [ 2] 2736         lsra
   97AC 44            [ 2] 2737         lsra
   97AD 44            [ 2] 2738         lsra
   97AE 44            [ 2] 2739         lsra
   97AF 8B 30         [ 2] 2740         adda    #0x30
   97B1 81 39         [ 2] 2741         cmpa    #0x39
   97B3 23 02         [ 3] 2742         bls     L97B7  
   97B5 8B 07         [ 2] 2743         adda    #0x07
   97B7                    2744 L97B7:
   97B7 97 12         [ 3] 2745         staa    (0x0012)
   97B9 39            [ 5] 2746         rts
                           2747 
   97BA                    2748 L97BA:
   97BA BD 9D 18      [ 6] 2749         jsr     L9D18
   97BD 24 03         [ 3] 2750         bcc     L97C2  
   97BF 7E 9A 7F      [ 3] 2751         jmp     L9A7F
   97C2                    2752 L97C2:
   97C2 7D 00 79      [ 6] 2753         tst     (0x0079)
   97C5 26 0B         [ 3] 2754         bne     L97D2  
   97C7 FC 04 10      [ 5] 2755         ldd     (0x0410)
   97CA C3 00 01      [ 4] 2756         addd    #0x0001
   97CD FD 04 10      [ 5] 2757         std     (0x0410)
   97D0 20 09         [ 3] 2758         bra     L97DB  
   97D2                    2759 L97D2:
   97D2 FC 04 12      [ 5] 2760         ldd     (0x0412)
   97D5 C3 00 01      [ 4] 2761         addd    #0x0001
   97D8 FD 04 12      [ 5] 2762         std     (0x0412)
   97DB                    2763 L97DB:
   97DB 86 78         [ 2] 2764         ldaa    #0x78
   97DD 97 63         [ 3] 2765         staa    (0x0063)
   97DF 97 64         [ 3] 2766         staa    (0x0064)
   97E1 BD A3 13      [ 6] 2767         jsr     LA313
   97E4 BD AA DB      [ 6] 2768         jsr     LAADB
   97E7 86 01         [ 2] 2769         ldaa    #0x01
   97E9 97 4E         [ 3] 2770         staa    (0x004E)
   97EB 97 76         [ 3] 2771         staa    (0x0076)
   97ED 7F 00 75      [ 6] 2772         clr     (0x0075)
   97F0 7F 00 77      [ 6] 2773         clr     (0x0077)
   97F3 BD 87 AE      [ 6] 2774         jsr     L87AE
   97F6 D6 7B         [ 3] 2775         ldab    (0x007B)
   97F8 CA 20         [ 2] 2776         orab    #0x20
   97FA C4 F7         [ 2] 2777         andb    #0xF7
   97FC BD 87 48      [ 6] 2778         jsr     L8748   
   97FF 7E 85 A4      [ 3] 2779         jmp     L85A4
   9802                    2780 L9802:
   9802 7F 00 76      [ 6] 2781         clr     (0x0076)
   9805 7F 00 75      [ 6] 2782         clr     (0x0075)
   9808 7F 00 77      [ 6] 2783         clr     (0x0077)
   980B 7F 00 4E      [ 6] 2784         clr     (0x004E)
   980E D6 7B         [ 3] 2785         ldab    (0x007B)
   9810 CA 0C         [ 2] 2786         orab    #0x0C
   9812 BD 87 48      [ 6] 2787         jsr     L8748
   9815                    2788 L9815:
   9815 BD A3 1E      [ 6] 2789         jsr     LA31E
   9818 BD 86 C4      [ 6] 2790         jsr     L86C4           ; Reset boards 1-10
   981B BD 9C 51      [ 6] 2791         jsr     L9C51           ; Reset random motions, init board 7/8 bits
   981E BD 8E 95      [ 6] 2792         jsr     L8E95
   9821 7E 84 4D      [ 3] 2793         jmp     L844D
   9824                    2794 L9824:
   9824 BD 9C 51      [ 6] 2795         jsr     L9C51           ; Reset random motions, init board 7/8 bits
   9827 7F 00 4E      [ 6] 2796         clr     (0x004E)
   982A D6 7B         [ 3] 2797         ldab    (0x007B)
   982C CA 24         [ 2] 2798         orab    #0x24
   982E C4 F7         [ 2] 2799         andb    #0xF7
   9830 BD 87 48      [ 6] 2800         jsr     L8748   
   9833 BD 87 AE      [ 6] 2801         jsr     L87AE
   9836 BD 8E 95      [ 6] 2802         jsr     L8E95
   9839 7E 84 4D      [ 3] 2803         jmp     L844D
   983C                    2804 L983C:
   983C 7F 00 78      [ 6] 2805         clr     (0x0078)
   983F B6 10 8A      [ 4] 2806         ldaa    (0x108A)
   9842 84 F9         [ 2] 2807         anda    #0xF9
   9844 B7 10 8A      [ 4] 2808         staa    (0x108A)
   9847 7D 00 AF      [ 6] 2809         tst     (0x00AF)
   984A 26 61         [ 3] 2810         bne     L98AD  
   984C 96 62         [ 3] 2811         ldaa    (0x0062)
   984E 84 01         [ 2] 2812         anda    #0x01
   9850 27 5B         [ 3] 2813         beq     L98AD  
   9852 C6 FD         [ 2] 2814         ldab    #0xFD           ; tape deck STOP
   9854 BD 86 E7      [ 6] 2815         jsr     L86E7
   9857 CC 00 32      [ 3] 2816         ldd     #0x0032
   985A DD 1B         [ 4] 2817         std     CDTIMR1
   985C CC 75 30      [ 3] 2818         ldd     #0x7530
   985F DD 1D         [ 4] 2819         std     CDTIMR2
   9861 7F 00 5A      [ 6] 2820         clr     (0x005A)
   9864                    2821 L9864:
   9864 BD 9B 19      [ 6] 2822         jsr     L9B19           ; do the random motions if enabled
   9867 7D 00 31      [ 6] 2823         tst     (0x0031)
   986A 26 04         [ 3] 2824         bne     L9870  
   986C 96 5A         [ 3] 2825         ldaa    (0x005A)
   986E 27 19         [ 3] 2826         beq     L9889  
   9870                    2827 L9870:
   9870 7F 00 31      [ 6] 2828         clr     (0x0031)
   9873 D6 62         [ 3] 2829         ldab    (0x0062)
   9875 C4 FE         [ 2] 2830         andb    #0xFE
   9877 D7 62         [ 3] 2831         stab    (0x0062)
   9879 BD F9 C5      [ 6] 2832         jsr     BUTNLIT 
   987C BD AA 13      [ 6] 2833         jsr     LAA13
   987F C6 FB         [ 2] 2834         ldab    #0xFB           ; tape deck PLAY
   9881 BD 86 E7      [ 6] 2835         jsr     L86E7
   9884 7F 00 5A      [ 6] 2836         clr     (0x005A)
   9887 20 4B         [ 3] 2837         bra     L98D4  
   9889                    2838 L9889:
   9889 DC 1B         [ 4] 2839         ldd     CDTIMR1
   988B 26 D7         [ 3] 2840         bne     L9864  
   988D D6 62         [ 3] 2841         ldab    (0x0062)
   988F C8 01         [ 2] 2842         eorb    #0x01
   9891 D7 62         [ 3] 2843         stab    (0x0062)
   9893 BD F9 C5      [ 6] 2844         jsr     BUTNLIT 
   9896 C4 01         [ 2] 2845         andb    #0x01
   9898 26 05         [ 3] 2846         bne     L989F  
   989A BD AA 0C      [ 6] 2847         jsr     LAA0C
   989D 20 03         [ 3] 2848         bra     L98A2  
   989F                    2849 L989F:
   989F BD AA 13      [ 6] 2850         jsr     LAA13
   98A2                    2851 L98A2:
   98A2 CC 00 32      [ 3] 2852         ldd     #0x0032
   98A5 DD 1B         [ 4] 2853         std     CDTIMR1
   98A7 DC 1D         [ 4] 2854         ldd     CDTIMR2
   98A9 27 C5         [ 3] 2855         beq     L9870  
   98AB 20 B7         [ 3] 2856         bra     L9864  
   98AD                    2857 L98AD:
   98AD 7D 00 75      [ 6] 2858         tst     (0x0075)
   98B0 27 03         [ 3] 2859         beq     L98B5  
   98B2 7E 99 39      [ 3] 2860         jmp     L9939
   98B5                    2861 L98B5:
   98B5 96 62         [ 3] 2862         ldaa    (0x0062)
   98B7 84 02         [ 2] 2863         anda    #0x02
   98B9 27 4E         [ 3] 2864         beq     L9909  
   98BB 7D 00 AF      [ 6] 2865         tst     (0x00AF)
   98BE 26 0B         [ 3] 2866         bne     L98CB  
   98C0 FC 04 24      [ 5] 2867         ldd     (0x0424)
   98C3 C3 00 01      [ 4] 2868         addd    #0x0001
   98C6 FD 04 24      [ 5] 2869         std     (0x0424)
   98C9 20 09         [ 3] 2870         bra     L98D4  
   98CB                    2871 L98CB:
   98CB FC 04 22      [ 5] 2872         ldd     (0x0422)
   98CE C3 00 01      [ 4] 2873         addd    #0x0001
   98D1 FD 04 22      [ 5] 2874         std     (0x0422)
   98D4                    2875 L98D4:
   98D4 FC 04 18      [ 5] 2876         ldd     (0x0418)
   98D7 C3 00 01      [ 4] 2877         addd    #0x0001
   98DA FD 04 18      [ 5] 2878         std     (0x0418)
   98DD 86 78         [ 2] 2879         ldaa    #0x78
   98DF 97 63         [ 3] 2880         staa    (0x0063)
   98E1 97 64         [ 3] 2881         staa    (0x0064)
   98E3 D6 62         [ 3] 2882         ldab    (0x0062)
   98E5 C4 F7         [ 2] 2883         andb    #0xF7
   98E7 CA 02         [ 2] 2884         orab    #0x02
   98E9 D7 62         [ 3] 2885         stab    (0x0062)
   98EB BD F9 C5      [ 6] 2886         jsr     BUTNLIT 
   98EE BD AA 18      [ 6] 2887         jsr     LAA18
   98F1 86 01         [ 2] 2888         ldaa    #0x01
   98F3 97 4E         [ 3] 2889         staa    (0x004E)
   98F5 97 75         [ 3] 2890         staa    (0x0075)
   98F7 D6 7B         [ 3] 2891         ldab    (0x007B)
   98F9 C4 DF         [ 2] 2892         andb    #0xDF
   98FB BD 87 48      [ 6] 2893         jsr     L8748   
   98FE BD 87 AE      [ 6] 2894         jsr     L87AE
   9901 BD A3 13      [ 6] 2895         jsr     LA313
   9904 BD AA DB      [ 6] 2896         jsr     LAADB
   9907 20 30         [ 3] 2897         bra     L9939  
   9909                    2898 L9909:
   9909 D6 62         [ 3] 2899         ldab    (0x0062)
   990B C4 F5         [ 2] 2900         andb    #0xF5
   990D CA 40         [ 2] 2901         orab    #0x40
   990F D7 62         [ 3] 2902         stab    (0x0062)
   9911 BD F9 C5      [ 6] 2903         jsr     BUTNLIT 
   9914 BD AA 1D      [ 6] 2904         jsr     LAA1D
   9917 7D 00 AF      [ 6] 2905         tst     (0x00AF)
   991A 26 04         [ 3] 2906         bne     L9920  
   991C C6 01         [ 2] 2907         ldab    #0x01
   991E D7 B6         [ 3] 2908         stab    (0x00B6)
   9920                    2909 L9920:
   9920 BD 9C 51      [ 6] 2910         jsr     L9C51           ; Reset random motions, init board 7/8 bits
   9923 7F 00 4E      [ 6] 2911         clr     (0x004E)
   9926 7F 00 75      [ 6] 2912         clr     (0x0075)
   9929 86 01         [ 2] 2913         ldaa    #0x01
   992B 97 77         [ 3] 2914         staa    (0x0077)
   992D D6 7B         [ 3] 2915         ldab    (0x007B)
   992F CA 24         [ 2] 2916         orab    #0x24
   9931 C4 F7         [ 2] 2917         andb    #0xF7
   9933 BD 87 48      [ 6] 2918         jsr     L8748   
   9936 BD 87 91      [ 6] 2919         jsr     L8791   
   9939                    2920 L9939:
   9939 7F 00 AF      [ 6] 2921         clr     (0x00AF)
   993C 7E 85 A4      [ 3] 2922         jmp     L85A4
   993F                    2923 L993F:
   993F 7F 00 77      [ 6] 2924         clr     (0x0077)
   9942 BD 9C 51      [ 6] 2925         jsr     L9C51           ; Reset random motions, init board 7/8 bits
   9945 7F 00 4E      [ 6] 2926         clr     (0x004E)
   9948 D6 62         [ 3] 2927         ldab    (0x0062)
   994A C4 BF         [ 2] 2928         andb    #0xBF
   994C 7D 00 75      [ 6] 2929         tst     (0x0075)
   994F 27 02         [ 3] 2930         beq     L9953  
   9951 C4 FD         [ 2] 2931         andb    #0xFD
   9953                    2932 L9953:
   9953 D7 62         [ 3] 2933         stab    (0x0062)
   9955 BD F9 C5      [ 6] 2934         jsr     BUTNLIT 
   9958 BD AA 1D      [ 6] 2935         jsr     LAA1D
   995B 7F 00 5B      [ 6] 2936         clr     (0x005B)
   995E BD 87 AE      [ 6] 2937         jsr     L87AE
   9961 D6 7B         [ 3] 2938         ldab    (0x007B)
   9963 CA 20         [ 2] 2939         orab    #0x20
   9965 BD 87 48      [ 6] 2940         jsr     L8748   
   9968 7F 00 75      [ 6] 2941         clr     (0x0075)
   996B 7F 00 76      [ 6] 2942         clr     (0x0076)
   996E 7E 98 15      [ 3] 2943         jmp     L9815
   9971                    2944 L9971:
   9971 D6 7B         [ 3] 2945         ldab    (0x007B)
   9973 C4 FB         [ 2] 2946         andb    #0xFB
   9975 BD 87 48      [ 6] 2947         jsr     L8748   
   9978 7E 85 A4      [ 3] 2948         jmp     L85A4
   997B                    2949 L997B:
   997B D6 7B         [ 3] 2950         ldab    (0x007B)
   997D CA 04         [ 2] 2951         orab    #0x04
   997F BD 87 48      [ 6] 2952         jsr     L8748   
   9982 7E 85 A4      [ 3] 2953         jmp     L85A4
   9985                    2954 L9985:
   9985 D6 7B         [ 3] 2955         ldab    (0x007B)
   9987 C4 F7         [ 2] 2956         andb    #0xF7
   9989 BD 87 48      [ 6] 2957         jsr     L8748   
   998C 7E 85 A4      [ 3] 2958         jmp     L85A4
   998F                    2959 L998F:
   998F 7D 00 77      [ 6] 2960         tst     (0x0077)
   9992 26 07         [ 3] 2961         bne     L999B
   9994 D6 7B         [ 3] 2962         ldab    (0x007B)
   9996 CA 08         [ 2] 2963         orab    #0x08
   9998 BD 87 48      [ 6] 2964         jsr     L8748   
   999B                    2965 L999B:
   999B 7E 85 A4      [ 3] 2966         jmp     L85A4
   999E                    2967 L999E:
   999E D6 7B         [ 3] 2968         ldab    (0x007B)
   99A0 C4 F3         [ 2] 2969         andb    #0xF3
   99A2 BD 87 48      [ 6] 2970         jsr     L8748   
   99A5 39            [ 5] 2971         rts
                           2972 
                           2973 ; main2
   99A6                    2974 L99A6:
   99A6 D6 7B         [ 3] 2975         ldab    (0x007B)
   99A8 C4 DF         [ 2] 2976         andb    #0xDF        ; clear bit 5
   99AA BD 87 48      [ 6] 2977         jsr     L8748
   99AD BD 87 91      [ 6] 2978         jsr     L8791   
   99B0 39            [ 5] 2979         rts
                           2980 
   99B1                    2981 L99B1:
   99B1 D6 7B         [ 3] 2982         ldab    (0x007B)
   99B3 CA 20         [ 2] 2983         orab    #0x20
   99B5 BD 87 48      [ 6] 2984         jsr     L8748   
   99B8 BD 87 AE      [ 6] 2985         jsr     L87AE
   99BB 39            [ 5] 2986         rts
                           2987 
   99BC D6 7B         [ 3] 2988         ldab    (0x007B)
   99BE C4 DF         [ 2] 2989         andb    #0xDF
   99C0 BD 87 48      [ 6] 2990         jsr     L8748   
   99C3 BD 87 AE      [ 6] 2991         jsr     L87AE
   99C6 39            [ 5] 2992         rts
                           2993 
   99C7 D6 7B         [ 3] 2994         ldab    (0x007B)
   99C9 CA 20         [ 2] 2995         orab    #0x20
   99CB BD 87 48      [ 6] 2996         jsr     L8748   
   99CE BD 87 91      [ 6] 2997         jsr     L8791   
   99D1 39            [ 5] 2998         rts
                           2999 
   99D2                    3000 L99D2:
   99D2 86 01         [ 2] 3001         ldaa    #0x01
   99D4 97 78         [ 3] 3002         staa    (0x0078)
   99D6 7E 85 A4      [ 3] 3003         jmp     L85A4
   99D9                    3004 L99D9:
   99D9 CE 0E 20      [ 3] 3005         ldx     #0x0E20
   99DC A6 00         [ 4] 3006         ldaa    0,X     
   99DE 80 30         [ 2] 3007         suba    #0x30
   99E0 C6 0A         [ 2] 3008         ldab    #0x0A
   99E2 3D            [10] 3009         mul
   99E3 17            [ 2] 3010         tba                 ; (0E20)*10 into A
   99E4 C6 64         [ 2] 3011         ldab    #0x64
   99E6 3D            [10] 3012         mul
   99E7 DD 17         [ 4] 3013         std     (0x0017)    ; (0E20)*1000 into 17:18
   99E9 A6 01         [ 4] 3014         ldaa    1,X
   99EB 80 30         [ 2] 3015         suba    #0x30
   99ED C6 64         [ 2] 3016         ldab    #0x64
   99EF 3D            [10] 3017         mul
   99F0 D3 17         [ 5] 3018         addd    (0x0017)
   99F2 DD 17         [ 4] 3019         std     (0x0017)    ; (0E20)*1000+(0E21)*100 into 17:18
   99F4 A6 02         [ 4] 3020         ldaa    2,X     
   99F6 80 30         [ 2] 3021         suba    #0x30
   99F8 C6 0A         [ 2] 3022         ldab    #0x0A
   99FA 3D            [10] 3023         mul
   99FB D3 17         [ 5] 3024         addd    (0x0017)    
   99FD DD 17         [ 4] 3025         std     (0x0017)    ; (0E20)*1000+(0E21)*100+(0E22)*10 into 17:18
   99FF 4F            [ 2] 3026         clra
   9A00 E6 03         [ 4] 3027         ldab    3,X     
   9A02 C0 30         [ 2] 3028         subb    #0x30
   9A04 D3 17         [ 5] 3029         addd    (0x0017)    
   9A06 FD 02 9C      [ 5] 3030         std     (0x029C)    ; (0E20)*1000+(0E21)*100+(0E22)*10+(0E23) into (029C:029D)
   9A09 CE 0E 20      [ 3] 3031         ldx     #0x0E20
   9A0C                    3032 L9A0C:
   9A0C A6 00         [ 4] 3033         ldaa    0,X         
   9A0E 81 30         [ 2] 3034         cmpa    #0x30
   9A10 25 13         [ 3] 3035         bcs     L9A25  
   9A12 81 39         [ 2] 3036         cmpa    #0x39
   9A14 22 0F         [ 3] 3037         bhi     L9A25  
   9A16 08            [ 3] 3038         inx
   9A17 8C 0E 24      [ 4] 3039         cpx     #0x0E24
   9A1A 26 F0         [ 3] 3040         bne     L9A0C  
   9A1C B6 0E 24      [ 4] 3041         ldaa    (0x0E24)    ; check EEPROM signature
   9A1F 81 DB         [ 2] 3042         cmpa    #0xDB
   9A21 26 02         [ 3] 3043         bne     L9A25  
   9A23 0C            [ 2] 3044         clc                 ; if sig good, return carry clear
   9A24 39            [ 5] 3045         rts
                           3046 
   9A25                    3047 L9A25:
   9A25 0D            [ 2] 3048         sec                 ; if sig bad, return carry clear
   9A26 39            [ 5] 3049         rts
                           3050 
   9A27                    3051 L9A27:
   9A27 BD 8D E4      [ 6] 3052         jsr     LCDMSG1 
   9A2A 53 65 72 69 61 6C  3053         .ascis  'Serial# '
        23 A0
                           3054 
   9A32 BD 8D DD      [ 6] 3055         jsr     LCDMSG2 
   9A35 20 20 20 20 20 20  3056         .ascis  '               '
        20 20 20 20 20 20
        20 20 A0
                           3057 
                           3058 ; display 4-digit serial number
   9A44 C6 08         [ 2] 3059         ldab    #0x08
   9A46 18 CE 0E 20   [ 4] 3060         ldy     #0x0E20
   9A4A                    3061 L9A4A:
   9A4A 18 A6 00      [ 5] 3062         ldaa    0,Y     
   9A4D 18 3C         [ 5] 3063         pshy
   9A4F 37            [ 3] 3064         pshb
   9A50 BD 8D B5      [ 6] 3065         jsr     L8DB5            ; display char here on LCD display
   9A53 33            [ 4] 3066         pulb
   9A54 18 38         [ 6] 3067         puly
   9A56 5C            [ 2] 3068         incb
   9A57 18 08         [ 4] 3069         iny
   9A59 18 8C 0E 24   [ 5] 3070         cpy     #0x0E24
   9A5D 26 EB         [ 3] 3071         bne     L9A4A  
   9A5F 39            [ 5] 3072         rts
                           3073 
                           3074 ; Unused?
   9A60                    3075 L9A60:
   9A60 86 01         [ 2] 3076         ldaa    #0x01
   9A62 97 B5         [ 3] 3077         staa    (0x00B5)
   9A64 96 4E         [ 3] 3078         ldaa    (0x004E)
   9A66 97 7F         [ 3] 3079         staa    (0x007F)
   9A68 96 62         [ 3] 3080         ldaa    (0x0062)
   9A6A 97 80         [ 3] 3081         staa    (0x0080)
   9A6C 96 7B         [ 3] 3082         ldaa    (0x007B)
   9A6E 97 81         [ 3] 3083         staa    (0x0081)
   9A70 96 7A         [ 3] 3084         ldaa    (0x007A)
   9A72 97 82         [ 3] 3085         staa    (0x0082)
   9A74 96 78         [ 3] 3086         ldaa    (0x0078)
   9A76 97 7D         [ 3] 3087         staa    (0x007D)
   9A78 B6 10 8A      [ 4] 3088         ldaa    (0x108A)
   9A7B 84 06         [ 2] 3089         anda    #0x06
   9A7D 97 7E         [ 3] 3090         staa    (0x007E)
   9A7F                    3091 L9A7F:
   9A7F C6 EF         [ 2] 3092         ldab    #0xEF           ; tape deck EJECT
   9A81 BD 86 E7      [ 6] 3093         jsr     L86E7
   9A84 D6 7B         [ 3] 3094         ldab    (0x007B)
   9A86 CA 0C         [ 2] 3095         orab    #0x0C
   9A88 C4 DF         [ 2] 3096         andb    #0xDF
   9A8A BD 87 48      [ 6] 3097         jsr     L8748   
   9A8D BD 87 91      [ 6] 3098         jsr     L8791   
   9A90 BD 86 C4      [ 6] 3099         jsr     L86C4           ; Reset boards 1-10
   9A93 BD 9C 51      [ 6] 3100         jsr     L9C51           ; Reset random motions, init board 7/8 bits
   9A96 C6 06         [ 2] 3101         ldab    #0x06           ; delay 6 secs
   9A98 BD 8C 02      [ 6] 3102         jsr     DLYSECS         ;
   9A9B BD 8E 95      [ 6] 3103         jsr     L8E95
   9A9E BD 99 A6      [ 6] 3104         jsr     L99A6
   9AA1 7E 81 BD      [ 3] 3105         jmp     L81BD
   9AA4                    3106 L9AA4:
   9AA4 7F 00 5C      [ 6] 3107         clr     (0x005C)
   9AA7 86 01         [ 2] 3108         ldaa    #0x01
   9AA9 97 79         [ 3] 3109         staa    (0x0079)
   9AAB C6 FD         [ 2] 3110         ldab    #0xFD           ; tape deck STOP
   9AAD BD 86 E7      [ 6] 3111         jsr     L86E7
   9AB0 BD 8E 95      [ 6] 3112         jsr     L8E95
   9AB3 CC 75 30      [ 3] 3113         ldd     #0x7530
   9AB6 DD 1D         [ 4] 3114         std     CDTIMR2
   9AB8                    3115 L9AB8:
   9AB8 BD 9B 19      [ 6] 3116         jsr     L9B19           ; do the random motions if enabled
   9ABB D6 62         [ 3] 3117         ldab    (0x0062)
   9ABD C8 04         [ 2] 3118         eorb    #0x04
   9ABF D7 62         [ 3] 3119         stab    (0x0062)
   9AC1 BD F9 C5      [ 6] 3120         jsr     BUTNLIT 
   9AC4 F6 18 04      [ 4] 3121         ldab    PIA0PRA 
   9AC7 C8 08         [ 2] 3122         eorb    #0x08
   9AC9 F7 18 04      [ 4] 3123         stab    PIA0PRA 
   9ACC 7D 00 5C      [ 6] 3124         tst     (0x005C)
   9ACF 26 12         [ 3] 3125         bne     L9AE3  
   9AD1 BD 8E 95      [ 6] 3126         jsr     L8E95
   9AD4 81 0D         [ 2] 3127         cmpa    #0x0D
   9AD6 27 0B         [ 3] 3128         beq     L9AE3  
   9AD8 C6 32         [ 2] 3129         ldab    #0x32       ; delay 0.5 sec
   9ADA BD 8C 22      [ 6] 3130         jsr     DLYSECSBY100
   9ADD DC 1D         [ 4] 3131         ldd     CDTIMR2
   9ADF 27 02         [ 3] 3132         beq     L9AE3  
   9AE1 20 D5         [ 3] 3133         bra     L9AB8  
   9AE3                    3134 L9AE3:
   9AE3 D6 62         [ 3] 3135         ldab    (0x0062)
   9AE5 C4 FB         [ 2] 3136         andb    #0xFB
   9AE7 D7 62         [ 3] 3137         stab    (0x0062)
   9AE9 BD F9 C5      [ 6] 3138         jsr     BUTNLIT 
   9AEC BD A3 54      [ 6] 3139         jsr     LA354
   9AEF C6 FB         [ 2] 3140         ldab    #0xFB           ; tape deck PLAY
   9AF1 BD 86 E7      [ 6] 3141         jsr     L86E7
   9AF4 7E 85 A4      [ 3] 3142         jmp     L85A4
   9AF7                    3143 L9AF7:
   9AF7 7F 00 75      [ 6] 3144         clr     (0x0075)
   9AFA 7F 00 76      [ 6] 3145         clr     (0x0076)
   9AFD 7F 00 77      [ 6] 3146         clr     (0x0077)
   9B00 7F 00 78      [ 6] 3147         clr     (0x0078)
   9B03 7F 00 25      [ 6] 3148         clr     (0x0025)
   9B06 7F 00 26      [ 6] 3149         clr     (0x0026)
   9B09 7F 00 4E      [ 6] 3150         clr     (0x004E)
   9B0C 7F 00 30      [ 6] 3151         clr     (0x0030)
   9B0F 7F 00 31      [ 6] 3152         clr     (0x0031)
   9B12 7F 00 32      [ 6] 3153         clr     (0x0032)
   9B15 7F 00 AF      [ 6] 3154         clr     (0x00AF)
   9B18 39            [ 5] 3155         rts
                           3156 
                           3157 ; do the random motions if enabled
   9B19                    3158 L9B19:
   9B19 36            [ 3] 3159         psha
   9B1A 37            [ 3] 3160         pshb
   9B1B 96 4E         [ 3] 3161         ldaa    (0x004E)
   9B1D 27 17         [ 3] 3162         beq     L9B36       ; go to 0401 logic
   9B1F 96 63         [ 3] 3163         ldaa    (0x0063)    ; check countdown timer
   9B21 26 10         [ 3] 3164         bne     L9B33       ; exit
   9B23 7D 00 64      [ 6] 3165         tst     (0x0064)
   9B26 27 09         [ 3] 3166         beq     L9B31       ; go to 0401 logic
   9B28 BD 86 C4      [ 6] 3167         jsr     L86C4       ; Reset boards 1-10
   9B2B BD 9C 51      [ 6] 3168         jsr     L9C51       ; Reset random motions, init board 7/8 bits
   9B2E 7F 00 64      [ 6] 3169         clr     (0x0064)
   9B31                    3170 L9B31:
   9B31 20 03         [ 3] 3171         bra     L9B36       ; go to 0401 logic
   9B33                    3172 L9B33:
   9B33 33            [ 4] 3173         pulb
   9B34 32            [ 4] 3174         pula
   9B35 39            [ 5] 3175         rts
                           3176 
                           3177 ; end up here immediately if:
                           3178 ; 0x004E == 00 or
                           3179 ; 0x0063, 0x0064 == 0 or
                           3180 ; 
                           3181 ; do subroutines based on bits 0-4 of 0x0401?
   9B36                    3182 L9B36:
   9B36 B6 04 01      [ 4] 3183         ldaa    (0x0401)
   9B39 84 01         [ 2] 3184         anda    #0x01
   9B3B 27 03         [ 3] 3185         beq     L9B40  
   9B3D BD 9B 6B      [ 6] 3186         jsr     L9B6B       ; bit 0 routine
   9B40                    3187 L9B40:
   9B40 B6 04 01      [ 4] 3188         ldaa    (0x0401)
   9B43 84 02         [ 2] 3189         anda    #0x02
   9B45 27 03         [ 3] 3190         beq     L9B4A  
   9B47 BD 9B 99      [ 6] 3191         jsr     L9B99       ; bit 1 routine
   9B4A                    3192 L9B4A:
   9B4A B6 04 01      [ 4] 3193         ldaa    (0x0401)
   9B4D 84 04         [ 2] 3194         anda    #0x04
   9B4F 27 03         [ 3] 3195         beq     L9B54  
   9B51 BD 9B C7      [ 6] 3196         jsr     L9BC7       ; bit 2 routine
   9B54                    3197 L9B54:
   9B54 B6 04 01      [ 4] 3198         ldaa    (0x0401)
   9B57 84 08         [ 2] 3199         anda    #0x08
   9B59 27 03         [ 3] 3200         beq     L9B5E  
   9B5B BD 9B F5      [ 6] 3201         jsr     L9BF5       ; bit 3 routine
   9B5E                    3202 L9B5E:
   9B5E B6 04 01      [ 4] 3203         ldaa    (0x0401)
   9B61 84 10         [ 2] 3204         anda    #0x10
   9B63 27 03         [ 3] 3205         beq     L9B68  
   9B65 BD 9C 23      [ 6] 3206         jsr     L9C23       ; bit 4 routine
   9B68                    3207 L9B68:
   9B68 33            [ 4] 3208         pulb
   9B69 32            [ 4] 3209         pula
   9B6A 39            [ 5] 3210         rts
                           3211 
                           3212 ; bit 0 routine
   9B6B                    3213 L9B6B:
   9B6B 18 3C         [ 5] 3214         pshy
   9B6D 18 DE 65      [ 5] 3215         ldy     (0x0065)
   9B70 18 A6 00      [ 5] 3216         ldaa    0,Y     
   9B73 81 FF         [ 2] 3217         cmpa    #0xFF
   9B75 27 14         [ 3] 3218         beq     L9B8B  
   9B77 91 70         [ 3] 3219         cmpa    OFFCNT1
   9B79 25 0D         [ 3] 3220         bcs     L9B88  
   9B7B 18 08         [ 4] 3221         iny
   9B7D 18 A6 00      [ 5] 3222         ldaa    0,Y     
   9B80 B7 10 80      [ 4] 3223         staa    (0x1080)        ; do some stuff to board 1
   9B83 18 08         [ 4] 3224         iny
   9B85 18 DF 65      [ 5] 3225         sty     (0x0065)
   9B88                    3226 L9B88:
   9B88 18 38         [ 6] 3227         puly
   9B8A 39            [ 5] 3228         rts
   9B8B                    3229 L9B8B:
   9B8B 18 CE B2 EB   [ 4] 3230         ldy     #LB2EB
   9B8F 18 DF 65      [ 5] 3231         sty     (0x0065)
   9B92 86 FA         [ 2] 3232         ldaa    #0xFA
   9B94 97 70         [ 3] 3233         staa    OFFCNT1
   9B96 7E 9B 88      [ 3] 3234         jmp     L9B88
                           3235 
                           3236 ; bit 1 routine
   9B99                    3237 L9B99:
   9B99 18 3C         [ 5] 3238         pshy
   9B9B 18 DE 67      [ 5] 3239         ldy     (0x0067)
   9B9E 18 A6 00      [ 5] 3240         ldaa    0,Y     
   9BA1 81 FF         [ 2] 3241         cmpa    #0xFF
   9BA3 27 14         [ 3] 3242         beq     L9BB9  
   9BA5 91 71         [ 3] 3243         cmpa    OFFCNT2
   9BA7 25 0D         [ 3] 3244         bcs     L9BB6  
   9BA9 18 08         [ 4] 3245         iny
   9BAB 18 A6 00      [ 5] 3246         ldaa    0,Y     
   9BAE B7 10 84      [ 4] 3247         staa    (0x1084)        ; do some stuff to board 2
   9BB1 18 08         [ 4] 3248         iny
   9BB3 18 DF 67      [ 5] 3249         sty     (0x0067)
   9BB6                    3250 L9BB6:
   9BB6 18 38         [ 6] 3251         puly
   9BB8 39            [ 5] 3252         rts
   9BB9                    3253 L9BB9:
   9BB9 18 CE B3 BD   [ 4] 3254         ldy     #LB3BD
   9BBD 18 DF 67      [ 5] 3255         sty     (0x0067)
   9BC0 86 E6         [ 2] 3256         ldaa    #0xE6
   9BC2 97 71         [ 3] 3257         staa    OFFCNT2
   9BC4 7E 9B B6      [ 3] 3258         jmp     L9BB6
                           3259 
                           3260 ; bit 2 routine
   9BC7                    3261 L9BC7:
   9BC7 18 3C         [ 5] 3262         pshy
   9BC9 18 DE 69      [ 5] 3263         ldy     (0x0069)
   9BCC 18 A6 00      [ 5] 3264         ldaa    0,Y     
   9BCF 81 FF         [ 2] 3265         cmpa    #0xFF
   9BD1 27 14         [ 3] 3266         beq     L9BE7  
   9BD3 91 72         [ 3] 3267         cmpa    OFFCNT3
   9BD5 25 0D         [ 3] 3268         bcs     L9BE4  
   9BD7 18 08         [ 4] 3269         iny
   9BD9 18 A6 00      [ 5] 3270         ldaa    0,Y     
   9BDC B7 10 88      [ 4] 3271         staa    (0x1088)        ; do some stuff to board 3
   9BDF 18 08         [ 4] 3272         iny
   9BE1 18 DF 69      [ 5] 3273         sty     (0x0069)
   9BE4                    3274 L9BE4:
   9BE4 18 38         [ 6] 3275         puly
   9BE6 39            [ 5] 3276         rts
   9BE7                    3277 L9BE7:
   9BE7 18 CE B5 31   [ 4] 3278         ldy     #LB531
   9BEB 18 DF 69      [ 5] 3279         sty     (0x0069)
   9BEE 86 D2         [ 2] 3280         ldaa    #0xD2
   9BF0 97 72         [ 3] 3281         staa    OFFCNT3
   9BF2 7E 9B E4      [ 3] 3282         jmp     L9BE4
                           3283 
                           3284 ; bit 3 routine
   9BF5                    3285 L9BF5:
   9BF5 18 3C         [ 5] 3286         pshy
   9BF7 18 DE 6B      [ 5] 3287         ldy     (0x006B)
   9BFA 18 A6 00      [ 5] 3288         ldaa    0,Y     
   9BFD 81 FF         [ 2] 3289         cmpa    #0xFF
   9BFF 27 14         [ 3] 3290         beq     L9C15  
   9C01 91 73         [ 3] 3291         cmpa    OFFCNT4
   9C03 25 0D         [ 3] 3292         bcs     L9C12  
   9C05 18 08         [ 4] 3293         iny
   9C07 18 A6 00      [ 5] 3294         ldaa    0,Y     
   9C0A B7 10 8C      [ 4] 3295         staa    (0x108C)        ; do some stuff to board 4
   9C0D 18 08         [ 4] 3296         iny
   9C0F 18 DF 6B      [ 5] 3297         sty     (0x006B)
   9C12                    3298 L9C12:
   9C12 18 38         [ 6] 3299         puly
   9C14 39            [ 5] 3300         rts
   9C15                    3301 L9C15:
   9C15 18 CE B4 75   [ 4] 3302         ldy     #LB475
   9C19 18 DF 6B      [ 5] 3303         sty     (0x006B)
   9C1C 86 BE         [ 2] 3304         ldaa    #0xBE
   9C1E 97 73         [ 3] 3305         staa    OFFCNT4
   9C20 7E 9C 12      [ 3] 3306         jmp     L9C12
                           3307 
                           3308 ; bit 4 routine
   9C23                    3309 L9C23:
   9C23 18 3C         [ 5] 3310         pshy
   9C25 18 DE 6D      [ 5] 3311         ldy     (0x006D)
   9C28 18 A6 00      [ 5] 3312         ldaa    0,Y     
   9C2B 81 FF         [ 2] 3313         cmpa    #0xFF
   9C2D 27 14         [ 3] 3314         beq     L9C43  
   9C2F 91 74         [ 3] 3315         cmpa    OFFCNT5
   9C31 25 0D         [ 3] 3316         bcs     L9C40  
   9C33 18 08         [ 4] 3317         iny
   9C35 18 A6 00      [ 5] 3318         ldaa    0,Y     
   9C38 B7 10 90      [ 4] 3319         staa    (0x1090)        ; do some stuff to board 5
   9C3B 18 08         [ 4] 3320         iny
   9C3D 18 DF 6D      [ 5] 3321         sty     (0x006D)
   9C40                    3322 L9C40:
   9C40 18 38         [ 6] 3323         puly
   9C42 39            [ 5] 3324         rts
   9C43                    3325 L9C43:
   9C43 18 CE B5 C3   [ 4] 3326         ldy     #LB5C3
   9C47 18 DF 6D      [ 5] 3327         sty     (0x006D)
   9C4A 86 AA         [ 2] 3328         ldaa    #0xAA
   9C4C 97 74         [ 3] 3329         staa    OFFCNT5
   9C4E 7E 9C 40      [ 3] 3330         jmp     L9C40
                           3331 
                           3332 ; Reset offset counters to initial values
   9C51                    3333 L9C51:
   9C51 86 FA         [ 2] 3334         ldaa    #0xFA
   9C53 97 70         [ 3] 3335         staa    OFFCNT1
   9C55 86 E6         [ 2] 3336         ldaa    #0xE6
   9C57 97 71         [ 3] 3337         staa    OFFCNT2
   9C59 86 D2         [ 2] 3338         ldaa    #0xD2
   9C5B 97 72         [ 3] 3339         staa    OFFCNT3
   9C5D 86 BE         [ 2] 3340         ldaa    #0xBE
   9C5F 97 73         [ 3] 3341         staa    OFFCNT4
   9C61 86 AA         [ 2] 3342         ldaa    #0xAA
   9C63 97 74         [ 3] 3343         staa    OFFCNT5
                           3344 
                           3345         ; int random movement table pointers
   9C65 18 CE B2 EB   [ 4] 3346         ldy     #LB2EB
   9C69 18 DF 65      [ 5] 3347         sty     (0x0065)
   9C6C 18 CE B3 BD   [ 4] 3348         ldy     #LB3BD
   9C70 18 DF 67      [ 5] 3349         sty     (0x0067)
   9C73 18 CE B5 31   [ 4] 3350         ldy     #LB531
   9C77 18 DF 69      [ 5] 3351         sty     (0x0069)
   9C7A 18 CE B4 75   [ 4] 3352         ldy     #LB475
   9C7E 18 DF 6B      [ 5] 3353         sty     (0x006B)
   9C81 18 CE B5 C3   [ 4] 3354         ldy     #LB5C3
   9C85 18 DF 6D      [ 5] 3355         sty     (0x006D)
                           3356 
                           3357         ; clear board 8
   9C88 7F 10 9C      [ 6] 3358         clr     (0x109C)
   9C8B 7F 10 9E      [ 6] 3359         clr     (0x109E)
                           3360 
                           3361         ; if bit 5 of 0401 is set, turn on 3 bits on board 8
   9C8E B6 04 01      [ 4] 3362         ldaa    (0x0401)
   9C91 84 20         [ 2] 3363         anda    #0x20
   9C93 27 08         [ 3] 3364         beq     L9C9D
   9C95 B6 10 9C      [ 4] 3365         ldaa    (0x109C)
   9C98 8A 19         [ 2] 3366         oraa    #0x19
   9C9A B7 10 9C      [ 4] 3367         staa    (0x109C)
                           3368         ; if bit 6 of 0401 is set, turn on 3 bits on board 8
   9C9D                    3369 L9C9D:
   9C9D B6 04 01      [ 4] 3370         ldaa    (0x0401)
   9CA0 84 40         [ 2] 3371         anda    #0x40
   9CA2 27 10         [ 3] 3372         beq     L9CB4  
   9CA4 B6 10 9C      [ 4] 3373         ldaa    (0x109C)
   9CA7 8A 44         [ 2] 3374         oraa    #0x44
   9CA9 B7 10 9C      [ 4] 3375         staa    (0x109C)
   9CAC B6 10 9E      [ 4] 3376         ldaa    (0x109E)
   9CAF 8A 40         [ 2] 3377         oraa    #0x40
   9CB1 B7 10 9E      [ 4] 3378         staa    (0x109E)
                           3379         ; if bit 7 of 0401 is set, turn on 3 bits on board 8
   9CB4                    3380 L9CB4:
   9CB4 B6 04 01      [ 4] 3381         ldaa    (0x0401)
   9CB7 84 80         [ 2] 3382         anda    #0x80
   9CB9 27 08         [ 3] 3383         beq     L9CC3  
   9CBB B6 10 9C      [ 4] 3384         ldaa    (0x109C)
   9CBE 8A A2         [ 2] 3385         oraa    #0xA2
   9CC0 B7 10 9C      [ 4] 3386         staa    (0x109C)
                           3387 
   9CC3                    3388 L9CC3:
                           3389         ; if bit 0 of 042B is set, turn on 1 bit on board 7
   9CC3 B6 04 2B      [ 4] 3390         ldaa    (0x042B)
   9CC6 84 01         [ 2] 3391         anda    #0x01
   9CC8 27 08         [ 3] 3392         beq     L9CD2  
   9CCA B6 10 9A      [ 4] 3393         ldaa    (0x109A)
   9CCD 8A 80         [ 2] 3394         oraa    #0x80
   9CCF B7 10 9A      [ 4] 3395         staa    (0x109A)
   9CD2                    3396 L9CD2:
                           3397         ; if bit 1 of 042B is set, turn on 1 bit on board 8
   9CD2 B6 04 2B      [ 4] 3398         ldaa    (0x042B)
   9CD5 84 02         [ 2] 3399         anda    #0x02
   9CD7 27 08         [ 3] 3400         beq     L9CE1  
   9CD9 B6 10 9E      [ 4] 3401         ldaa    (0x109E)
   9CDC 8A 04         [ 2] 3402         oraa    #0x04
   9CDE B7 10 9E      [ 4] 3403         staa    (0x109E)
   9CE1                    3404 L9CE1:
                           3405         ; if bit 2 of 042B is set, turn on 1 bit on board 8
   9CE1 B6 04 2B      [ 4] 3406         ldaa    (0x042B)
   9CE4 84 04         [ 2] 3407         anda    #0x04
   9CE6 27 08         [ 3] 3408         beq     L9CF0  
   9CE8 B6 10 9E      [ 4] 3409         ldaa    (0x109E)
   9CEB 8A 08         [ 2] 3410         oraa    #0x08
   9CED B7 10 9E      [ 4] 3411         staa    (0x109E)
   9CF0                    3412 L9CF0:
   9CF0 39            [ 5] 3413         rts
                           3414 
                           3415 ; Display Credits
   9CF1                    3416 L9CF1:
   9CF1 BD 8D E4      [ 6] 3417         jsr     LCDMSG1 
   9CF4 20 20 20 50 72 6F  3418         .ascis  '   Program by   '
        67 72 61 6D 20 62
        79 20 20 A0
                           3419 
   9D04 BD 8D DD      [ 6] 3420         jsr     LCDMSG2 
   9D07 44 61 76 69 64 20  3421         .ascis  'David  Philipsen'
        20 50 68 69 6C 69
        70 73 65 EE
                           3422 
   9D17 39            [ 5] 3423         rts
                           3424 
   9D18                    3425 L9D18:
   9D18 97 49         [ 3] 3426         staa    (0x0049)
   9D1A 7F 00 B8      [ 6] 3427         clr     (0x00B8)
   9D1D BD 8D 03      [ 6] 3428         jsr     L8D03
   9D20 86 2A         [ 2] 3429         ldaa    #0x2A           ;'*'
   9D22 C6 28         [ 2] 3430         ldab    #0x28
   9D24 BD 8D B5      [ 6] 3431         jsr     L8DB5           ; display char here on LCD display
   9D27 CC 0B B8      [ 3] 3432         ldd     #0x0BB8         ; start 30 second timer?
   9D2A DD 1B         [ 4] 3433         std     CDTIMR1
   9D2C                    3434 L9D2C:
   9D2C BD 9B 19      [ 6] 3435         jsr     L9B19           ; do the random motions if enabled
   9D2F 96 49         [ 3] 3436         ldaa    (0x0049)
   9D31 81 41         [ 2] 3437         cmpa    #0x41
   9D33 27 04         [ 3] 3438         beq     L9D39  
   9D35 81 4B         [ 2] 3439         cmpa    #0x4B
   9D37 26 04         [ 3] 3440         bne     L9D3D  
   9D39                    3441 L9D39:
   9D39 C6 01         [ 2] 3442         ldab    #0x01
   9D3B D7 B8         [ 3] 3443         stab    (0x00B8)
   9D3D                    3444 L9D3D:
   9D3D 81 41         [ 2] 3445         cmpa    #0x41
   9D3F 27 04         [ 3] 3446         beq     L9D45  
   9D41 81 4F         [ 2] 3447         cmpa    #0x4F
   9D43 26 07         [ 3] 3448         bne     L9D4C  
   9D45                    3449 L9D45:
   9D45 86 01         [ 2] 3450         ldaa    #0x01
   9D47 B7 02 98      [ 4] 3451         staa    (0x0298)
   9D4A 20 32         [ 3] 3452         bra     L9D7E  
   9D4C                    3453 L9D4C:
   9D4C 81 4B         [ 2] 3454         cmpa    #0x4B
   9D4E 27 04         [ 3] 3455         beq     L9D54  
   9D50 81 50         [ 2] 3456         cmpa    #0x50
   9D52 26 07         [ 3] 3457         bne     L9D5B  
   9D54                    3458 L9D54:
   9D54 86 02         [ 2] 3459         ldaa    #0x02
   9D56 B7 02 98      [ 4] 3460         staa    (0x0298)
   9D59 20 23         [ 3] 3461         bra     L9D7E  
   9D5B                    3462 L9D5B:
   9D5B 81 4C         [ 2] 3463         cmpa    #0x4C
   9D5D 26 07         [ 3] 3464         bne     L9D66  
   9D5F 86 03         [ 2] 3465         ldaa    #0x03
   9D61 B7 02 98      [ 4] 3466         staa    (0x0298)
   9D64 20 18         [ 3] 3467         bra     L9D7E  
   9D66                    3468 L9D66:
   9D66 81 52         [ 2] 3469         cmpa    #0x52
   9D68 26 07         [ 3] 3470         bne     L9D71  
   9D6A 86 04         [ 2] 3471         ldaa    #0x04
   9D6C B7 02 98      [ 4] 3472         staa    (0x0298)
   9D6F 20 0D         [ 3] 3473         bra     L9D7E  
   9D71                    3474 L9D71:
   9D71 DC 1B         [ 4] 3475         ldd     CDTIMR1
   9D73 26 B7         [ 3] 3476         bne     L9D2C  
   9D75 86 23         [ 2] 3477         ldaa    #0x23            ;'#'
   9D77 C6 29         [ 2] 3478         ldab    #0x29
   9D79 BD 8D B5      [ 6] 3479         jsr     L8DB5            ; display char here on LCD display
   9D7C 20 6C         [ 3] 3480         bra     L9DEA  
   9D7E                    3481 L9D7E:
   9D7E 7F 00 49      [ 6] 3482         clr     (0x0049)
   9D81 86 2A         [ 2] 3483         ldaa    #0x2A            ;'*'
   9D83 C6 29         [ 2] 3484         ldab    #0x29
   9D85 BD 8D B5      [ 6] 3485         jsr     L8DB5            ; display char here on LCD display
   9D88 7F 00 4A      [ 6] 3486         clr     (0x004A)
   9D8B CE 02 99      [ 3] 3487         ldx     #0x0299
   9D8E                    3488 L9D8E:
   9D8E BD 9B 19      [ 6] 3489         jsr     L9B19           ; do the random motions if enabled
   9D91 96 4A         [ 3] 3490         ldaa    (0x004A)
   9D93 27 F9         [ 3] 3491         beq     L9D8E  
   9D95 7F 00 4A      [ 6] 3492         clr     (0x004A)
   9D98 84 3F         [ 2] 3493         anda    #0x3F
   9D9A A7 00         [ 4] 3494         staa    0,X     
   9D9C 08            [ 3] 3495         inx
   9D9D 8C 02 9C      [ 4] 3496         cpx     #0x029C
   9DA0 26 EC         [ 3] 3497         bne     L9D8E  
   9DA2 BD 9D F5      [ 6] 3498         jsr     L9DF5
   9DA5 24 09         [ 3] 3499         bcc     L9DB0  
   9DA7 86 23         [ 2] 3500         ldaa    #0x23            ;'#'
   9DA9 C6 2A         [ 2] 3501         ldab    #0x2A
   9DAB BD 8D B5      [ 6] 3502         jsr     L8DB5            ; display char here on LCD display
   9DAE 20 3A         [ 3] 3503         bra     L9DEA  
   9DB0                    3504 L9DB0:
   9DB0 86 2A         [ 2] 3505         ldaa    #0x2A            ;'*'
   9DB2 C6 2A         [ 2] 3506         ldab    #0x2A
   9DB4 BD 8D B5      [ 6] 3507         jsr     L8DB5            ; display char here on LCD display
   9DB7 B6 02 99      [ 4] 3508         ldaa    (0x0299)
   9DBA 81 39         [ 2] 3509         cmpa    #0x39
   9DBC 26 15         [ 3] 3510         bne     L9DD3  
                           3511 
   9DBE BD 8D DD      [ 6] 3512         jsr     LCDMSG2 
   9DC1 47 65 6E 65 72 69  3513         .ascis  'Generic Showtape'
        63 20 53 68 6F 77
        74 61 70 E5
                           3514 
   9DD1 0C            [ 2] 3515         clc
   9DD2 39            [ 5] 3516         rts
                           3517 
   9DD3                    3518 L9DD3:
   9DD3 B6 02 98      [ 4] 3519         ldaa    (0x0298)
   9DD6 81 03         [ 2] 3520         cmpa    #0x03
   9DD8 27 0E         [ 3] 3521         beq     L9DE8  
   9DDA 81 04         [ 2] 3522         cmpa    #0x04
   9DDC 27 0A         [ 3] 3523         beq     L9DE8  
   9DDE 96 76         [ 3] 3524         ldaa    (0x0076)
   9DE0 26 06         [ 3] 3525         bne     L9DE8  
   9DE2 BD 9E 73      [ 6] 3526         jsr     L9E73
   9DE5 BD 9E CC      [ 6] 3527         jsr     L9ECC
   9DE8                    3528 L9DE8:
   9DE8 0C            [ 2] 3529         clc
   9DE9 39            [ 5] 3530         rts
                           3531 
   9DEA                    3532 L9DEA:
   9DEA FC 04 20      [ 5] 3533         ldd     (0x0420)
   9DED C3 00 01      [ 4] 3534         addd    #0x0001
   9DF0 FD 04 20      [ 5] 3535         std     (0x0420)
   9DF3 0D            [ 2] 3536         sec
   9DF4 39            [ 5] 3537         rts
                           3538 
   9DF5                    3539 L9DF5:
   9DF5 B6 02 99      [ 4] 3540         ldaa    (0x0299)
   9DF8 81 39         [ 2] 3541         cmpa    #0x39
   9DFA 27 6C         [ 3] 3542         beq     L9E68  
   9DFC CE 00 A8      [ 3] 3543         ldx     #0x00A8
   9DFF                    3544 L9DFF:
   9DFF BD 9B 19      [ 6] 3545         jsr     L9B19           ; do the random motions if enabled
   9E02 96 4A         [ 3] 3546         ldaa    (0x004A)
   9E04 27 F9         [ 3] 3547         beq     L9DFF  
   9E06 7F 00 4A      [ 6] 3548         clr     (0x004A)
   9E09 A7 00         [ 4] 3549         staa    0,X     
   9E0B 08            [ 3] 3550         inx
   9E0C 8C 00 AA      [ 4] 3551         cpx     #0x00AA
   9E0F 26 EE         [ 3] 3552         bne     L9DFF  
   9E11 BD 9E FA      [ 6] 3553         jsr     L9EFA
   9E14 CE 02 99      [ 3] 3554         ldx     #0x0299
   9E17 7F 00 13      [ 6] 3555         clr     (0x0013)
   9E1A                    3556 L9E1A:
   9E1A A6 00         [ 4] 3557         ldaa    0,X     
   9E1C 9B 13         [ 3] 3558         adda    (0x0013)
   9E1E 97 13         [ 3] 3559         staa    (0x0013)
   9E20 08            [ 3] 3560         inx
   9E21 8C 02 9C      [ 4] 3561         cpx     #0x029C
   9E24 26 F4         [ 3] 3562         bne     L9E1A  
   9E26 91 A8         [ 3] 3563         cmpa    (0x00A8)
   9E28 26 47         [ 3] 3564         bne     L9E71  
   9E2A CE 04 02      [ 3] 3565         ldx     #0x0402
   9E2D B6 02 98      [ 4] 3566         ldaa    (0x0298)
   9E30 81 02         [ 2] 3567         cmpa    #0x02
   9E32 26 03         [ 3] 3568         bne     L9E37  
   9E34 CE 04 05      [ 3] 3569         ldx     #0x0405
   9E37                    3570 L9E37:
   9E37 3C            [ 4] 3571         pshx
   9E38 BD AB 56      [ 6] 3572         jsr     LAB56
   9E3B 38            [ 5] 3573         pulx
   9E3C 25 07         [ 3] 3574         bcs     L9E45  
   9E3E 86 03         [ 2] 3575         ldaa    #0x03
   9E40 B7 02 98      [ 4] 3576         staa    (0x0298)
   9E43 20 23         [ 3] 3577         bra     L9E68  
   9E45                    3578 L9E45:
   9E45 B6 02 99      [ 4] 3579         ldaa    (0x0299)
   9E48 A1 00         [ 4] 3580         cmpa    0,X     
   9E4A 25 1E         [ 3] 3581         bcs     L9E6A  
   9E4C 27 02         [ 3] 3582         beq     L9E50  
   9E4E 24 18         [ 3] 3583         bcc     L9E68  
   9E50                    3584 L9E50:
   9E50 08            [ 3] 3585         inx
   9E51 B6 02 9A      [ 4] 3586         ldaa    (0x029A)
   9E54 A1 00         [ 4] 3587         cmpa    0,X     
   9E56 25 12         [ 3] 3588         bcs     L9E6A  
   9E58 27 02         [ 3] 3589         beq     L9E5C  
   9E5A 24 0C         [ 3] 3590         bcc     L9E68  
   9E5C                    3591 L9E5C:
   9E5C 08            [ 3] 3592         inx
   9E5D B6 02 9B      [ 4] 3593         ldaa    (0x029B)
   9E60 A1 00         [ 4] 3594         cmpa    0,X     
   9E62 25 06         [ 3] 3595         bcs     L9E6A  
   9E64 27 02         [ 3] 3596         beq     L9E68  
   9E66 24 00         [ 3] 3597         bcc     L9E68  
   9E68                    3598 L9E68:
   9E68 0C            [ 2] 3599         clc
   9E69 39            [ 5] 3600         rts
                           3601 
   9E6A                    3602 L9E6A:
   9E6A B6 02 98      [ 4] 3603         ldaa    (0x0298)
   9E6D 81 03         [ 2] 3604         cmpa    #0x03
   9E6F 27 F7         [ 3] 3605         beq     L9E68  
   9E71                    3606 L9E71:
   9E71 0D            [ 2] 3607         sec
   9E72 39            [ 5] 3608         rts
                           3609 
   9E73                    3610 L9E73:
   9E73 CE 04 02      [ 3] 3611         ldx     #0x0402
   9E76 B6 02 98      [ 4] 3612         ldaa    (0x0298)
   9E79 81 02         [ 2] 3613         cmpa    #0x02
   9E7B 26 03         [ 3] 3614         bne     L9E80  
   9E7D CE 04 05      [ 3] 3615         ldx     #0x0405
   9E80                    3616 L9E80:
   9E80 B6 02 99      [ 4] 3617         ldaa    (0x0299)
   9E83 A7 00         [ 4] 3618         staa    0,X     
   9E85 08            [ 3] 3619         inx
   9E86 B6 02 9A      [ 4] 3620         ldaa    (0x029A)
   9E89 A7 00         [ 4] 3621         staa    0,X     
   9E8B 08            [ 3] 3622         inx
   9E8C B6 02 9B      [ 4] 3623         ldaa    (0x029B)
   9E8F A7 00         [ 4] 3624         staa    0,X     
   9E91 39            [ 5] 3625         rts
                           3626 
                           3627 ; reset R counts
   9E92                    3628 L9E92:
   9E92 86 30         [ 2] 3629         ldaa    #0x30        
   9E94 B7 04 02      [ 4] 3630         staa    (0x0402)
   9E97 B7 04 03      [ 4] 3631         staa    (0x0403)
   9E9A B7 04 04      [ 4] 3632         staa    (0x0404)
                           3633 
   9E9D BD 8D DD      [ 6] 3634         jsr     LCDMSG2 
   9EA0 52 65 67 20 23 20  3635         .ascis  'Reg # cleared!'
        63 6C 65 61 72 65
        64 A1
                           3636 
   9EAE 39            [ 5] 3637         rts
                           3638 
                           3639 ; reset L counts
   9EAF                    3640 L9EAF:
   9EAF 86 30         [ 2] 3641         ldaa    #0x30
   9EB1 B7 04 05      [ 4] 3642         staa    (0x0405)
   9EB4 B7 04 06      [ 4] 3643         staa    (0x0406)
   9EB7 B7 04 07      [ 4] 3644         staa    (0x0407)
                           3645 
   9EBA BD 8D DD      [ 6] 3646         jsr     LCDMSG2 
   9EBD 4C 69 76 20 23 20  3647         .ascis  'Liv # cleared!'
        63 6C 65 61 72 65
        64 A1
                           3648 
   9ECB 39            [ 5] 3649         rts
                           3650 
                           3651 ; display R and L counts?
   9ECC                    3652 L9ECC:
   9ECC 86 52         [ 2] 3653         ldaa    #0x52            ;'R'
   9ECE C6 2B         [ 2] 3654         ldab    #0x2B
   9ED0 BD 8D B5      [ 6] 3655         jsr     L8DB5            ; display char here on LCD display
   9ED3 86 4C         [ 2] 3656         ldaa    #0x4C            ;'L'
   9ED5 C6 32         [ 2] 3657         ldab    #0x32
   9ED7 BD 8D B5      [ 6] 3658         jsr     L8DB5            ; display char here on LCD display
   9EDA CE 04 02      [ 3] 3659         ldx     #0x0402
   9EDD C6 2C         [ 2] 3660         ldab    #0x2C
   9EDF                    3661 L9EDF:
   9EDF A6 00         [ 4] 3662         ldaa    0,X     
   9EE1 BD 8D B5      [ 6] 3663         jsr     L8DB5            ; display 3 chars here on LCD display
   9EE4 5C            [ 2] 3664         incb
   9EE5 08            [ 3] 3665         inx
   9EE6 8C 04 05      [ 4] 3666         cpx     #0x0405
   9EE9 26 F4         [ 3] 3667         bne     L9EDF  
   9EEB C6 33         [ 2] 3668         ldab    #0x33
   9EED                    3669 L9EED:
   9EED A6 00         [ 4] 3670         ldaa    0,X     
   9EEF BD 8D B5      [ 6] 3671         jsr     L8DB5            ; display 3 chars here on LCD display
   9EF2 5C            [ 2] 3672         incb
   9EF3 08            [ 3] 3673         inx
   9EF4 8C 04 08      [ 4] 3674         cpx     #0x0408
   9EF7 26 F4         [ 3] 3675         bne     L9EED  
   9EF9 39            [ 5] 3676         rts
                           3677 
   9EFA                    3678 L9EFA:
   9EFA 96 A8         [ 3] 3679         ldaa    (0x00A8)
   9EFC BD 9F 0F      [ 6] 3680         jsr     L9F0F
   9EFF 48            [ 2] 3681         asla
   9F00 48            [ 2] 3682         asla
   9F01 48            [ 2] 3683         asla
   9F02 48            [ 2] 3684         asla
   9F03 97 13         [ 3] 3685         staa    (0x0013)
   9F05 96 A9         [ 3] 3686         ldaa    (0x00A9)
   9F07 BD 9F 0F      [ 6] 3687         jsr     L9F0F
   9F0A 9B 13         [ 3] 3688         adda    (0x0013)
   9F0C 97 A8         [ 3] 3689         staa    (0x00A8)
   9F0E 39            [ 5] 3690         rts
                           3691 
   9F0F                    3692 L9F0F:
   9F0F 81 2F         [ 2] 3693         cmpa    #0x2F
   9F11 24 02         [ 3] 3694         bcc     L9F15  
   9F13 86 30         [ 2] 3695         ldaa    #0x30
   9F15                    3696 L9F15:
   9F15 81 3A         [ 2] 3697         cmpa    #0x3A
   9F17 25 02         [ 3] 3698         bcs     L9F1B  
   9F19 80 07         [ 2] 3699         suba    #0x07
   9F1B                    3700 L9F1B:
   9F1B 80 30         [ 2] 3701         suba    #0x30
   9F1D 39            [ 5] 3702         rts
                           3703 
                           3704 ; different behavior based on serial number
   9F1E                    3705 L9F1E:
   9F1E FC 02 9C      [ 5] 3706         ldd     (0x029C)
   9F21 1A 83 00 01   [ 5] 3707         cpd     #0x0001     ; if 1, password bypass
   9F25 27 0C         [ 3] 3708         beq     L9F33       ; 
   9F27 1A 83 03 E8   [ 5] 3709         cpd     #0x03E8     ; 1000
   9F2B 25 20         [ 3] 3710         bcs     L9F4D       ; if > 1000, code
   9F2D 1A 83 04 4B   [ 5] 3711         cpd     #0x044B     ; 1099
   9F31 22 1A         [ 3] 3712         bhi     L9F4D       ; if < 1099, code
                           3713                             ; else 1 < x < 1000, bypass
                           3714                             
   9F33                    3715 L9F33:
   9F33 BD 8D E4      [ 6] 3716         jsr     LCDMSG1 
   9F36 50 61 73 73 77 6F  3717         .ascis  'Password bypass '
        72 64 20 62 79 70
        61 73 73 A0
                           3718 
   9F46 C6 04         [ 2] 3719         ldab    #0x04
   9F48 BD 8C 30      [ 6] 3720         jsr     DLYSECSBY2           ; delay 2 sec
   9F4B 0C            [ 2] 3721         clc
   9F4C 39            [ 5] 3722         rts
                           3723 
   9F4D                    3724 L9F4D:
   9F4D BD 8C F2      [ 6] 3725         jsr     L8CF2
   9F50 BD 8D 03      [ 6] 3726         jsr     L8D03
                           3727 
   9F53 BD 8D E4      [ 6] 3728         jsr     LCDMSG1 
   9F56 43 6F 64 65 BA     3729         .ascis  'Code:'
                           3730 
                           3731 ; Generate a random 5-digit code in 0x0290-0x0294, and display to user
                           3732 
   9F5B CE 02 90      [ 3] 3733         ldx     #0x0290
   9F5E 7F 00 16      [ 6] 3734         clr     (0x0016)    ; 0x00
   9F61                    3735 L9F61:
   9F61 86 41         [ 2] 3736         ldaa    #0x41       ; 'A'
   9F63                    3737 L9F63:
   9F63 97 15         [ 3] 3738         staa    (0x0015)    ; 0x41
   9F65 BD 8E 95      [ 6] 3739         jsr     L8E95       ; roll the dice
   9F68 81 0D         [ 2] 3740         cmpa    #0x0D
   9F6A 26 11         [ 3] 3741         bne     L9F7D
   9F6C 96 15         [ 3] 3742         ldaa    (0x0015)
   9F6E A7 00         [ 4] 3743         staa    0,X     
   9F70 08            [ 3] 3744         inx
   9F71 BD 8C 98      [ 6] 3745         jsr     L8C98
   9F74 96 16         [ 3] 3746         ldaa    (0x0016)
   9F76 4C            [ 2] 3747         inca
   9F77 97 16         [ 3] 3748         staa    (0x0016)
   9F79 81 05         [ 2] 3749         cmpa    #0x05
   9F7B 27 09         [ 3] 3750         beq     L9F86  
   9F7D                    3751 L9F7D:
   9F7D 96 15         [ 3] 3752         ldaa    (0x0015)
   9F7F 4C            [ 2] 3753         inca
   9F80 81 5B         [ 2] 3754         cmpa    #0x5B       ; '['
   9F82 27 DD         [ 3] 3755         beq     L9F61  
   9F84 20 DD         [ 3] 3756         bra     L9F63  
                           3757 
                           3758 ; Let the user type in a corresponding password to the code
   9F86                    3759 L9F86:
   9F86 BD 8D DD      [ 6] 3760         jsr     LCDMSG2 
   9F89 50 73 77 64 BA     3761         .ascis  'Pswd:'
                           3762 
   9F8E CE 02 88      [ 3] 3763         ldx     #0x0288
   9F91 86 41         [ 2] 3764         ldaa    #0x41       ; 'A'
   9F93 97 16         [ 3] 3765         staa    (0x0016)
   9F95 86 C5         [ 2] 3766         ldaa    #0xC5       ; 
   9F97 97 15         [ 3] 3767         staa    (0x0015)
   9F99                    3768 L9F99:
   9F99 96 15         [ 3] 3769         ldaa    (0x0015)
   9F9B BD 8C 86      [ 6] 3770         jsr     L8C86        ; write byte to LCD
   9F9E 96 16         [ 3] 3771         ldaa    (0x0016)
   9FA0 BD 8C 98      [ 6] 3772         jsr     L8C98
   9FA3                    3773 L9FA3:
   9FA3 BD 8E 95      [ 6] 3774         jsr     L8E95
   9FA6 27 FB         [ 3] 3775         beq     L9FA3  
   9FA8 81 0D         [ 2] 3776         cmpa    #0x0D
   9FAA 26 10         [ 3] 3777         bne     L9FBC  
   9FAC 96 16         [ 3] 3778         ldaa    (0x0016)
   9FAE A7 00         [ 4] 3779         staa    0,X     
   9FB0 08            [ 3] 3780         inx
   9FB1 96 15         [ 3] 3781         ldaa    (0x0015)
   9FB3 4C            [ 2] 3782         inca
   9FB4 97 15         [ 3] 3783         staa    (0x0015)
   9FB6 81 CA         [ 2] 3784         cmpa    #0xCA
   9FB8 27 28         [ 3] 3785         beq     L9FE2  
   9FBA 20 DD         [ 3] 3786         bra     L9F99  
   9FBC                    3787 L9FBC:
   9FBC 81 01         [ 2] 3788         cmpa    #0x01
   9FBE 26 0F         [ 3] 3789         bne     L9FCF  
   9FC0 96 16         [ 3] 3790         ldaa    (0x0016)
   9FC2 4C            [ 2] 3791         inca
   9FC3 97 16         [ 3] 3792         staa    (0x0016)
   9FC5 81 5B         [ 2] 3793         cmpa    #0x5B
   9FC7 26 D0         [ 3] 3794         bne     L9F99  
   9FC9 86 41         [ 2] 3795         ldaa    #0x41
   9FCB 97 16         [ 3] 3796         staa    (0x0016)
   9FCD 20 CA         [ 3] 3797         bra     L9F99  
   9FCF                    3798 L9FCF:
   9FCF 81 02         [ 2] 3799         cmpa    #0x02
   9FD1 26 D0         [ 3] 3800         bne     L9FA3  
   9FD3 96 16         [ 3] 3801         ldaa    (0x0016)
   9FD5 4A            [ 2] 3802         deca
   9FD6 97 16         [ 3] 3803         staa    (0x0016)
   9FD8 81 40         [ 2] 3804         cmpa    #0x40
   9FDA 26 BD         [ 3] 3805         bne     L9F99  
   9FDC 86 5A         [ 2] 3806         ldaa    #0x5A
   9FDE 97 16         [ 3] 3807         staa    (0x0016)
   9FE0 20 B7         [ 3] 3808         bra     L9F99  
   9FE2                    3809 L9FE2:
   9FE2 BD A0 01      [ 6] 3810         jsr     LA001           ; validate
   9FE5 25 0F         [ 3] 3811         bcs     L9FF6           ; if bad, jump
   9FE7 86 DB         [ 2] 3812         ldaa    #0xDB
   9FE9 97 AB         [ 3] 3813         staa    (0x00AB)        ; good password
   9FEB FC 04 16      [ 5] 3814         ldd     (0x0416)        ; increment number of good validations counter
   9FEE C3 00 01      [ 4] 3815         addd    #0x0001
   9FF1 FD 04 16      [ 5] 3816         std     (0x0416)
   9FF4 0C            [ 2] 3817         clc
   9FF5 39            [ 5] 3818         rts
                           3819 
   9FF6                    3820 L9FF6:
   9FF6 FC 04 14      [ 5] 3821         ldd     (0x0414)        ; increment number of bad validations counter
   9FF9 C3 00 01      [ 4] 3822         addd    #0x0001
   9FFC FD 04 14      [ 5] 3823         std     (0x0414)
   9FFF 0D            [ 2] 3824         sec
   A000 39            [ 5] 3825         rts
                           3826 
                           3827 ; Validate password?
   A001                    3828 LA001:
                           3829         ; scramble 5 letters
   A001 B6 02 90      [ 4] 3830         ldaa    (0x0290)        ; 0 -> 1
   A004 B7 02 81      [ 4] 3831         staa    (0x0281)
   A007 B6 02 91      [ 4] 3832         ldaa    (0x0291)        ; 1 -> 3
   A00A B7 02 83      [ 4] 3833         staa    (0x0283)
   A00D B6 02 92      [ 4] 3834         ldaa    (0x0292)        ; 2 -> 4
   A010 B7 02 84      [ 4] 3835         staa    (0x0284)
   A013 B6 02 93      [ 4] 3836         ldaa    (0x0293)        ; 3 -> 0
   A016 B7 02 80      [ 4] 3837         staa    (0x0280)
   A019 B6 02 94      [ 4] 3838         ldaa    (0x0294)        ; 4 -> 2
   A01C B7 02 82      [ 4] 3839         staa    (0x0282)
                           3840         ; transform each letter
   A01F B6 02 80      [ 4] 3841         ldaa    (0x0280)    
   A022 88 13         [ 2] 3842         eora    #0x13
   A024 8B 03         [ 2] 3843         adda    #0x03
   A026 B7 02 80      [ 4] 3844         staa    (0x0280)
   A029 B6 02 81      [ 4] 3845         ldaa    (0x0281)
   A02C 88 04         [ 2] 3846         eora    #0x04
   A02E 8B 12         [ 2] 3847         adda    #0x12
   A030 B7 02 81      [ 4] 3848         staa    (0x0281)
   A033 B6 02 82      [ 4] 3849         ldaa    (0x0282)
   A036 88 06         [ 2] 3850         eora    #0x06
   A038 8B 04         [ 2] 3851         adda    #0x04
   A03A B7 02 82      [ 4] 3852         staa    (0x0282)
   A03D B6 02 83      [ 4] 3853         ldaa    (0x0283)
   A040 88 11         [ 2] 3854         eora    #0x11
   A042 8B 07         [ 2] 3855         adda    #0x07
   A044 B7 02 83      [ 4] 3856         staa    (0x0283)
   A047 B6 02 84      [ 4] 3857         ldaa    (0x0284)
   A04A 88 01         [ 2] 3858         eora    #0x01
   A04C 8B 10         [ 2] 3859         adda    #0x10
   A04E B7 02 84      [ 4] 3860         staa    (0x0284)
                           3861         ; keep them modulo 26 (A-Z)
   A051 BD A0 AF      [ 6] 3862         jsr     LA0AF
                           3863         ; put some of the original bits into 0x0015/0x0016
   A054 B6 02 94      [ 4] 3864         ldaa    (0x0294)
   A057 84 17         [ 2] 3865         anda    #0x17
   A059 97 15         [ 3] 3866         staa    (0x0015)
   A05B B6 02 90      [ 4] 3867         ldaa    (0x0290)
   A05E 84 17         [ 2] 3868         anda    #0x17
   A060 97 16         [ 3] 3869         staa    (0x0016)
                           3870         ; do some eoring with these bits
   A062 CE 02 80      [ 3] 3871         ldx     #0x0280
   A065                    3872 LA065:
   A065 A6 00         [ 4] 3873         ldaa    0,X
   A067 98 15         [ 3] 3874         eora    (0x0015)
   A069 98 16         [ 3] 3875         eora    (0x0016)
   A06B A7 00         [ 4] 3876         staa    0,X
   A06D 08            [ 3] 3877         inx
   A06E 8C 02 85      [ 4] 3878         cpx     #0x0285
   A071 26 F2         [ 3] 3879         bne     LA065
                           3880         ; keep them modulo 26 (A-Z)
   A073 BD A0 AF      [ 6] 3881         jsr     LA0AF
                           3882         ; compare them to code in 0x0288-0x028C
   A076 CE 02 80      [ 3] 3883         ldx     #0x0280
   A079 18 CE 02 88   [ 4] 3884         ldy     #0x0288
   A07D                    3885 LA07D:
   A07D A6 00         [ 4] 3886         ldaa    0,X     
   A07F 18 A1 00      [ 5] 3887         cmpa    0,Y     
   A082 26 0A         [ 3] 3888         bne     LA08E  
   A084 08            [ 3] 3889         inx
   A085 18 08         [ 4] 3890         iny
   A087 8C 02 85      [ 4] 3891         cpx     #0x0285
   A08A 26 F1         [ 3] 3892         bne     LA07D  
   A08C 0C            [ 2] 3893         clc                 ; carry clear if good
   A08D 39            [ 5] 3894         rts
                           3895 
   A08E                    3896 LA08E:
   A08E 0D            [ 2] 3897         sec                 ; carry set if bad
   A08F 39            [ 5] 3898         rts
                           3899 
                           3900 ; trivial password validation - not used??
   A090                    3901 LA090:
   A090 59 41 44 44 41     3902         .ascii  'YADDA'
                           3903 
   A095 CE 02 88      [ 3] 3904         ldx     #0x0288
   A098 18 CE A0 90   [ 4] 3905         ldy     #LA090
   A09C                    3906 LA09C:
   A09C A6 00         [ 4] 3907         ldaa    0,X
   A09E 18 A1 00      [ 5] 3908         cmpa    0,Y
   A0A1 26 0A         [ 3] 3909         bne     LA0AD
   A0A3 08            [ 3] 3910         inx
   A0A4 18 08         [ 4] 3911         iny
   A0A6 8C 02 8D      [ 4] 3912         cpx     #0x028D
   A0A9 26 F1         [ 3] 3913         bne     LA09C
   A0AB 0C            [ 2] 3914         clc
   A0AC 39            [ 5] 3915         rts
   A0AD                    3916 LA0AD:
   A0AD 0D            [ 2] 3917         sec
   A0AE 39            [ 5] 3918         rts
                           3919 
                           3920 ; keep the password modulo 26, each letter in range 'A-Z'
   A0AF                    3921 LA0AF:
   A0AF CE 02 80      [ 3] 3922         ldx     #0x0280
   A0B2                    3923 LA0B2:
   A0B2 A6 00         [ 4] 3924         ldaa    0,X
   A0B4 81 5B         [ 2] 3925         cmpa    #0x5B
   A0B6 25 06         [ 3] 3926         bcs     LA0BE
   A0B8 80 1A         [ 2] 3927         suba    #0x1A
   A0BA A7 00         [ 4] 3928         staa    0,X
   A0BC 20 08         [ 3] 3929         bra     LA0C6
   A0BE                    3930 LA0BE:
   A0BE 81 41         [ 2] 3931         cmpa    #0x41
   A0C0 24 04         [ 3] 3932         bcc     LA0C6
   A0C2 8B 1A         [ 2] 3933         adda    #0x1A
   A0C4 A7 00         [ 4] 3934         staa    0,X
   A0C6                    3935 LA0C6:
   A0C6 08            [ 3] 3936         inx
   A0C7 8C 02 85      [ 4] 3937         cpx     #0x0285
   A0CA 26 E6         [ 3] 3938         bne     LA0B2  
   A0CC 39            [ 5] 3939         rts
                           3940 
   A0CD BD 8C F2      [ 6] 3941         jsr     L8CF2
                           3942 
   A0D0 BD 8D DD      [ 6] 3943         jsr     LCDMSG2 
   A0D3 46 61 69 6C 65 64  3944         .ascis  'Failed!         '
        21 20 20 20 20 20
        20 20 20 A0
                           3945 
   A0E3 C6 02         [ 2] 3946         ldab    #0x02
   A0E5 BD 8C 30      [ 6] 3947         jsr     DLYSECSBY2           ; delay 1 sec
   A0E8 39            [ 5] 3948         rts
                           3949 
   A0E9                    3950 LA0E9:
   A0E9 C6 01         [ 2] 3951         ldab    #0x01
   A0EB BD 8C 30      [ 6] 3952         jsr     DLYSECSBY2           ; delay 0.5 sec
   A0EE 7F 00 4E      [ 6] 3953         clr     (0x004E)
   A0F1 C6 D3         [ 2] 3954         ldab    #0xD3
   A0F3 BD 87 48      [ 6] 3955         jsr     L8748   
   A0F6 BD 87 AE      [ 6] 3956         jsr     L87AE
   A0F9 BD 8C E9      [ 6] 3957         jsr     L8CE9
                           3958 
   A0FC BD 8D E4      [ 6] 3959         jsr     LCDMSG1 
   A0FF 20 20 20 56 43 52  3960         .ascis  '   VCR adjust'
        20 61 64 6A 75 73
        F4
                           3961 
   A10C BD 8D DD      [ 6] 3962         jsr     LCDMSG2 
   A10F 55 50 20 74 6F 20  3963         .ascis  'UP to clear bits'
        63 6C 65 61 72 20
        62 69 74 F3
                           3964 
   A11F 5F            [ 2] 3965         clrb
   A120 D7 62         [ 3] 3966         stab    (0x0062)
   A122 BD F9 C5      [ 6] 3967         jsr     BUTNLIT 
   A125 B6 18 04      [ 4] 3968         ldaa    PIA0PRA 
   A128 84 BF         [ 2] 3969         anda    #0xBF
   A12A B7 18 04      [ 4] 3970         staa    PIA0PRA 
   A12D BD 8E 95      [ 6] 3971         jsr     L8E95
   A130 7F 00 48      [ 6] 3972         clr     (0x0048)
   A133 7F 00 49      [ 6] 3973         clr     (0x0049)
   A136 BD 86 C4      [ 6] 3974         jsr     L86C4           ; Reset boards 1-10
   A139 86 28         [ 2] 3975         ldaa    #0x28
   A13B 97 63         [ 3] 3976         staa    (0x0063)
   A13D C6 FD         [ 2] 3977         ldab    #0xFD           ; tape deck STOP
   A13F BD 86 E7      [ 6] 3978         jsr     L86E7
   A142 BD A3 2E      [ 6] 3979         jsr     LA32E
   A145 7C 00 76      [ 6] 3980         inc     (0x0076)
   A148 7F 00 32      [ 6] 3981         clr     (0x0032)
   A14B                    3982 LA14B:
   A14B BD 8E 95      [ 6] 3983         jsr     L8E95
   A14E 81 0D         [ 2] 3984         cmpa    #0x0D
   A150 26 03         [ 3] 3985         bne     LA155  
   A152 7E A1 C4      [ 3] 3986         jmp     LA1C4
   A155                    3987 LA155:
   A155 86 28         [ 2] 3988         ldaa    #0x28
   A157 97 63         [ 3] 3989         staa    (0x0063)
   A159 BD 86 A4      [ 6] 3990         jsr     L86A4
   A15C 25 ED         [ 3] 3991         bcs     LA14B  
   A15E FC 04 1A      [ 5] 3992         ldd     (0x041A)
   A161 C3 00 01      [ 4] 3993         addd    #0x0001
   A164 FD 04 1A      [ 5] 3994         std     (0x041A)
   A167 BD 86 C4      [ 6] 3995         jsr     L86C4           ; Reset boards 1-10
   A16A 7C 00 4E      [ 6] 3996         inc     (0x004E)
   A16D C6 D3         [ 2] 3997         ldab    #0xD3
   A16F BD 87 48      [ 6] 3998         jsr     L8748   
   A172 BD 87 AE      [ 6] 3999         jsr     L87AE
   A175                    4000 LA175:
   A175 96 49         [ 3] 4001         ldaa    (0x0049)
   A177 81 43         [ 2] 4002         cmpa    #0x43
   A179 26 06         [ 3] 4003         bne     LA181  
   A17B 7F 00 49      [ 6] 4004         clr     (0x0049)
   A17E 7F 00 48      [ 6] 4005         clr     (0x0048)
   A181                    4006 LA181:
   A181 96 48         [ 3] 4007         ldaa    (0x0048)
   A183 81 C8         [ 2] 4008         cmpa    #0xC8
   A185 25 1F         [ 3] 4009         bcs     LA1A6  
   A187 FC 02 9C      [ 5] 4010         ldd     (0x029C)
   A18A 1A 83 00 01   [ 5] 4011         cpd     #0x0001
   A18E 27 16         [ 3] 4012         beq     LA1A6  
   A190 C6 EF         [ 2] 4013         ldab    #0xEF           ; tape deck EJECT
   A192 BD 86 E7      [ 6] 4014         jsr     L86E7
   A195 BD 86 C4      [ 6] 4015         jsr     L86C4           ; Reset boards 1-10
   A198 7F 00 4E      [ 6] 4016         clr     (0x004E)
   A19B 7F 00 76      [ 6] 4017         clr     (0x0076)
   A19E C6 0A         [ 2] 4018         ldab    #0x0A
   A1A0 BD 8C 30      [ 6] 4019         jsr     DLYSECSBY2      ; delay 5 sec
   A1A3 7E 81 D7      [ 3] 4020         jmp     L81D7
   A1A6                    4021 LA1A6:
   A1A6 BD 8E 95      [ 6] 4022         jsr     L8E95
   A1A9 81 01         [ 2] 4023         cmpa    #0x01
   A1AB 26 10         [ 3] 4024         bne     LA1BD  
   A1AD CE 10 80      [ 3] 4025         ldx     #0x1080
   A1B0 86 34         [ 2] 4026         ldaa    #0x34
   A1B2                    4027 LA1B2:
   A1B2 6F 00         [ 6] 4028         clr     0,X     
   A1B4 A7 01         [ 4] 4029         staa    1,X     
   A1B6 08            [ 3] 4030         inx
   A1B7 08            [ 3] 4031         inx
   A1B8 8C 10 A0      [ 4] 4032         cpx     #0x10A0
   A1BB 25 F5         [ 3] 4033         bcs     LA1B2  
   A1BD                    4034 LA1BD:
   A1BD 81 0D         [ 2] 4035         cmpa    #0x0D
   A1BF 27 03         [ 3] 4036         beq     LA1C4  
   A1C1 7E A1 75      [ 3] 4037         jmp     LA175
   A1C4                    4038 LA1C4:
   A1C4 7F 00 76      [ 6] 4039         clr     (0x0076)
   A1C7 7F 00 4E      [ 6] 4040         clr     (0x004E)
   A1CA C6 DF         [ 2] 4041         ldab    #0xDF
   A1CC BD 87 48      [ 6] 4042         jsr     L8748   
   A1CF BD 87 91      [ 6] 4043         jsr     L8791   
   A1D2 7E 81 D7      [ 3] 4044         jmp     L81D7
                           4045 
                           4046 ; reprogram EEPROM signature if needed
   A1D5                    4047 LA1D5:
   A1D5 86 07         [ 2] 4048         ldaa    #0x07
   A1D7 B7 04 00      [ 4] 4049         staa    (0x0400)
   A1DA CC 0E 09      [ 3] 4050         ldd     #0x0E09
   A1DD 81 65         [ 2] 4051         cmpa    #0x65           ;'e'
   A1DF 26 05         [ 3] 4052         bne     LA1E6
   A1E1 C1 63         [ 2] 4053         cmpb    #0x63           ;'c'
   A1E3 26 01         [ 3] 4054         bne     LA1E6
   A1E5 39            [ 5] 4055         rts
                           4056 
                           4057 ; erase and reprogram EEPROM signature
   A1E6                    4058 LA1E6:
   A1E6 86 0E         [ 2] 4059         ldaa    #0x0E
   A1E8 B7 10 3B      [ 4] 4060         staa    PPROG
   A1EB 86 FF         [ 2] 4061         ldaa    #0xFF
   A1ED B7 0E 00      [ 4] 4062         staa    (0x0E00)
   A1F0 B6 10 3B      [ 4] 4063         ldaa    PPROG  
   A1F3 8A 01         [ 2] 4064         oraa    #0x01
   A1F5 B7 10 3B      [ 4] 4065         staa    PPROG  
   A1F8 CE 1B 58      [ 3] 4066         ldx     #0x1B58         ; 7000
   A1FB                    4067 LA1FB:
   A1FB 09            [ 3] 4068         dex
   A1FC 26 FD         [ 3] 4069         bne     LA1FB  
   A1FE B6 10 3B      [ 4] 4070         ldaa    PPROG  
   A201 84 FE         [ 2] 4071         anda    #0xFE
   A203 B7 10 3B      [ 4] 4072         staa    PPROG  
   A206 CE 0E 00      [ 3] 4073         ldx     #0x0E00
   A209 18 CE A2 26   [ 4] 4074         ldy     #LA226
   A20D                    4075 LA20D:
   A20D C6 02         [ 2] 4076         ldab    #0x02
   A20F F7 10 3B      [ 4] 4077         stab    PPROG  
   A212 18 A6 00      [ 5] 4078         ldaa    0,Y     
   A215 18 08         [ 4] 4079         iny
   A217 A7 00         [ 4] 4080         staa    0,X     
   A219 BD A2 32      [ 6] 4081         jsr     LA232
   A21C 08            [ 3] 4082         inx
   A21D 8C 0E 0C      [ 4] 4083         cpx     #0x0E0C
   A220 26 EB         [ 3] 4084         bne     LA20D  
   A222 7F 10 3B      [ 6] 4085         clr     PPROG  
   A225 39            [ 5] 4086         rts
                           4087 
                           4088 ; data for 0x0E00-0x0E0B EEPROM
   A226                    4089 LA226:
   A226 29 64 2A 21 32 3A  4090         .ascii  ')d*!2::4!ecq'
        3A 34 21 65 63 71
                           4091 
                           4092 ; program EEPROM
   A232                    4093 LA232:
   A232 18 3C         [ 5] 4094         pshy
   A234 C6 03         [ 2] 4095         ldab    #0x03
   A236 F7 10 3B      [ 4] 4096         stab    PPROG       ; start program
   A239 18 CE 1B 58   [ 4] 4097         ldy     #0x1B58
   A23D                    4098 LA23D:
   A23D 18 09         [ 4] 4099         dey
   A23F 26 FC         [ 3] 4100         bne     LA23D  
   A241 C6 02         [ 2] 4101         ldab    #0x02
   A243 F7 10 3B      [ 4] 4102         stab    PPROG       ; stop program
   A246 18 38         [ 6] 4103         puly
   A248 39            [ 5] 4104         rts
                           4105 
   A249                    4106 LA249:
   A249 0F            [ 2] 4107         sei
   A24A CE 00 10      [ 3] 4108         ldx     #0x0010
   A24D                    4109 LA24D:
   A24D 6F 00         [ 6] 4110         clr     0,X     
   A24F 08            [ 3] 4111         inx
   A250 8C 0E 00      [ 4] 4112         cpx     #0x0E00
   A253 26 F8         [ 3] 4113         bne     LA24D  
   A255 BD 9E AF      [ 6] 4114         jsr     L9EAF     ; reset L counts
   A258 BD 9E 92      [ 6] 4115         jsr     L9E92     ; reset R counts
   A25B 7E F8 00      [ 3] 4116         jmp     RESET     ; reset controller
                           4117 
                           4118 ; Compute and store copyright checksum
   A25E                    4119 LA25E:
   A25E 18 CE 80 03   [ 4] 4120         ldy     #CPYRTMSG       ; copyright message
   A262 CE 00 00      [ 3] 4121         ldx     #0x0000
   A265                    4122 LA265:
   A265 18 E6 00      [ 5] 4123         ldab    0,Y
   A268 3A            [ 3] 4124         abx
   A269 18 08         [ 4] 4125         iny
   A26B 18 8C 80 50   [ 5] 4126         cpy     #0x8050
   A26F 26 F4         [ 3] 4127         bne     LA265
   A271 FF 04 0B      [ 5] 4128         stx     CPYRTCS         ; store checksum here
   A274 39            [ 5] 4129         rts
                           4130 
                           4131 ; Erase EEPROM routine
   A275                    4132 LA275:
   A275 0F            [ 2] 4133         sei
   A276 7F 04 0F      [ 6] 4134         clr     ERASEFLG     ; Reset EEPROM Erase flag
   A279 86 0E         [ 2] 4135         ldaa    #0x0E
   A27B B7 10 3B      [ 4] 4136         staa    PPROG       ; ERASE mode!
   A27E 86 FF         [ 2] 4137         ldaa    #0xFF
   A280 B7 0E 20      [ 4] 4138         staa    (0x0E20)    ; save in NVRAM
   A283 B6 10 3B      [ 4] 4139         ldaa    PPROG  
   A286 8A 01         [ 2] 4140         oraa    #0x01
   A288 B7 10 3B      [ 4] 4141         staa    PPROG       ; do the ERASE
   A28B CE 1B 58      [ 3] 4142         ldx     #0x1B58       ; delay a bit
   A28E                    4143 LA28E:
   A28E 09            [ 3] 4144         dex
   A28F 26 FD         [ 3] 4145         bne     LA28E  
   A291 B6 10 3B      [ 4] 4146         ldaa    PPROG  
   A294 84 FE         [ 2] 4147         anda    #0xFE        ; stop erasing
   A296 7F 10 3B      [ 6] 4148         clr     PPROG  
                           4149 
   A299 BD F9 D8      [ 6] 4150         jsr     SERMSGW           ; display "enter serial number"
   A29C 45 6E 74 65 72 20  4151         .ascis  'Enter serial #: '
        73 65 72 69 61 6C
        20 23 3A A0
                           4152 
   A2AC CE 0E 20      [ 3] 4153         ldx     #0x0E20
   A2AF                    4154 LA2AF:
   A2AF BD F9 45      [ 6] 4155         jsr     SERIALR     ; wait for serial data
   A2B2 24 FB         [ 3] 4156         bcc     LA2AF  
                           4157 
   A2B4 BD F9 6F      [ 6] 4158         jsr     SERIALW     ; read serial data
   A2B7 C6 02         [ 2] 4159         ldab    #0x02
   A2B9 F7 10 3B      [ 4] 4160         stab    PPROG       ; protect only 0x0e20-0x0e5f
   A2BC A7 00         [ 4] 4161         staa    0,X         
   A2BE BD A2 32      [ 6] 4162         jsr     LA232       ; program byte
   A2C1 08            [ 3] 4163         inx
   A2C2 8C 0E 24      [ 4] 4164         cpx     #0x0E24
   A2C5 26 E8         [ 3] 4165         bne     LA2AF  
   A2C7 C6 02         [ 2] 4166         ldab    #0x02
   A2C9 F7 10 3B      [ 4] 4167         stab    PPROG  
   A2CC 86 DB         [ 2] 4168         ldaa    #0xDB       ; it's official
   A2CE B7 0E 24      [ 4] 4169         staa    (0x0E24)
   A2D1 BD A2 32      [ 6] 4170         jsr     LA232       ; program byte
   A2D4 7F 10 3B      [ 6] 4171         clr     PPROG  
   A2D7 86 1E         [ 2] 4172         ldaa    #0x1E
   A2D9 B7 10 35      [ 4] 4173         staa    BPROT       ; protect all but 0x0e00-0x0e1f
   A2DC 7E F8 00      [ 3] 4174         jmp     RESET       ; reset controller
                           4175 
   A2DF                    4176 LA2DF:
   A2DF 38            [ 5] 4177         pulx
   A2E0 3C            [ 4] 4178         pshx
   A2E1 8C 80 00      [ 4] 4179         cpx     #0x8000
   A2E4 25 02         [ 3] 4180         bcs     LA2E8  
   A2E6 0C            [ 2] 4181         clc
   A2E7 39            [ 5] 4182         rts
                           4183 
   A2E8                    4184 LA2E8:
   A2E8 0D            [ 2] 4185         sec
   A2E9 39            [ 5] 4186         rts
                           4187 
                           4188 ; enter and validate security code via serial
   A2EA                    4189 LA2EA:
   A2EA CE 02 88      [ 3] 4190         ldx     #0x0288
   A2ED C6 03         [ 2] 4191         ldab    #0x03       ; 3 character code
                           4192 
   A2EF                    4193 LA2EF:
   A2EF BD F9 45      [ 6] 4194         jsr     SERIALR     ; check if available
   A2F2 24 FB         [ 3] 4195         bcc     LA2EF  
   A2F4 A7 00         [ 4] 4196         staa    0,X     
   A2F6 08            [ 3] 4197         inx
   A2F7 5A            [ 2] 4198         decb
   A2F8 26 F5         [ 3] 4199         bne     LA2EF  
                           4200 
   A2FA B6 02 88      [ 4] 4201         ldaa    (0x0288)
   A2FD 81 13         [ 2] 4202         cmpa    #0x13        ; 0x13
   A2FF 26 10         [ 3] 4203         bne     LA311  
   A301 B6 02 89      [ 4] 4204         ldaa    (0x0289)
   A304 81 10         [ 2] 4205         cmpa    #0x10        ; 0x10
   A306 26 09         [ 3] 4206         bne     LA311  
   A308 B6 02 8A      [ 4] 4207         ldaa    (0x028A)
   A30B 81 14         [ 2] 4208         cmpa    #0x14        ; 0x14
   A30D 26 02         [ 3] 4209         bne     LA311  
   A30F 0C            [ 2] 4210         clc
   A310 39            [ 5] 4211         rts
                           4212 
   A311                    4213 LA311:
   A311 0D            [ 2] 4214         sec
   A312 39            [ 5] 4215         rts
                           4216 
   A313                    4217 LA313:
   A313 36            [ 3] 4218         psha
   A314 B6 10 92      [ 4] 4219         ldaa    (0x1092)
   A317 8A 01         [ 2] 4220         oraa    #0x01
   A319                    4221 LA319:
   A319 B7 10 92      [ 4] 4222         staa    (0x1092)
   A31C 32            [ 4] 4223         pula
   A31D 39            [ 5] 4224         rts
                           4225 
   A31E                    4226 LA31E:
   A31E 36            [ 3] 4227         psha
   A31F B6 10 92      [ 4] 4228         ldaa    (0x1092)
   A322 84 FE         [ 2] 4229         anda    #0xFE
   A324 20 F3         [ 3] 4230         bra     LA319
                           4231 
   A326                    4232 LA326:
   A326 96 4E         [ 3] 4233         ldaa    (0x004E)
   A328 97 19         [ 3] 4234         staa    (0x0019)
   A32A 7F 00 4E      [ 6] 4235         clr     (0x004E)
   A32D 39            [ 5] 4236         rts
                           4237 
   A32E                    4238 LA32E:
   A32E B6 10 86      [ 4] 4239         ldaa    (0x1086)
   A331 8A 15         [ 2] 4240         oraa    #0x15
   A333 B7 10 86      [ 4] 4241         staa    (0x1086)
   A336 C6 01         [ 2] 4242         ldab    #0x01
   A338 BD 8C 30      [ 6] 4243         jsr     DLYSECSBY2           ; delay 0.5 sec
   A33B 84 EA         [ 2] 4244         anda    #0xEA
   A33D B7 10 86      [ 4] 4245         staa    (0x1086)
   A340 39            [ 5] 4246         rts
                           4247 
   A341                    4248 LA341:
   A341 B6 10 86      [ 4] 4249         ldaa    (0x1086)
   A344 8A 2A         [ 2] 4250         oraa    #0x2A               ; xx1x1x1x
   A346 B7 10 86      [ 4] 4251         staa    (0x1086)
   A349 C6 01         [ 2] 4252         ldab    #0x01
   A34B BD 8C 30      [ 6] 4253         jsr     DLYSECSBY2          ; delay 0.5 sec
   A34E 84 D5         [ 2] 4254         anda    #0xD5               ; xx0x0x0x
   A350 B7 10 86      [ 4] 4255         staa    (0x1086)
   A353 39            [ 5] 4256         rts
                           4257 
   A354                    4258 LA354:
   A354 F6 18 04      [ 4] 4259         ldab    PIA0PRA 
   A357 CA 08         [ 2] 4260         orab    #0x08
   A359 F7 18 04      [ 4] 4261         stab    PIA0PRA 
   A35C 39            [ 5] 4262         rts
                           4263 
   A35D F6 18 04      [ 4] 4264         ldab    PIA0PRA 
   A360 C4 F7         [ 2] 4265         andb    #0xF7
   A362 F7 18 04      [ 4] 4266         stab    PIA0PRA 
   A365 39            [ 5] 4267         rts
                           4268 
                           4269 ;'$' command goes here?
   A366                    4270 LA366:
   A366 7F 00 4E      [ 6] 4271         clr     (0x004E)
   A369 BD 86 C4      [ 6] 4272         jsr     L86C4           ; Reset boards 1-10
   A36C 7F 04 2A      [ 6] 4273         clr     (0x042A)
                           4274 
   A36F BD F9 D8      [ 6] 4275         jsr     SERMSGW
   A372 45 6E 74 65 72 20  4276         .ascis  'Enter security code:' 
        73 65 63 75 72 69
        74 79 20 63 6F 64
        65 BA
                           4277 
   A386 BD A2 EA      [ 6] 4278         jsr     LA2EA
   A389 24 03         [ 3] 4279         bcc     LA38E
   A38B 7E 83 31      [ 3] 4280         jmp     L8331
                           4281 
   A38E                    4282 LA38E:
   A38E BD F9 D8      [ 6] 4283         jsr     SERMSGW      
   A391 0C 0A 0D 44 61 76  4284         .ascii  "\f\n\rDave's Setup Utility\n\r"
        65 27 73 20 53 65
        74 75 70 20 55 74
        69 6C 69 74 79 0A
        0D
   A3AA 3C 4B 3E 69 6E 67  4285         .ascii  '<K>ing enable\n\r'
        20 65 6E 61 62 6C
        65 0A 0D
   A3B9 3C 43 3E 6C 65 61  4286         .ascii  '<C>lear random\n\r'
        72 20 72 61 6E 64
        6F 6D 0A 0D
   A3C9 3C 35 3E 20 63 68  4287         .ascii  '<5> character random\n\r'
        61 72 61 63 74 65
        72 20 72 61 6E 64
        6F 6D 0A 0D
   A3DF 3C 4C 3E 69 76 65  4288         .ascii  '<L>ive tape number clear\n\r'
        20 74 61 70 65 20
        6E 75 6D 62 65 72
        20 63 6C 65 61 72
        0A 0D
   A3F9 3C 52 3E 65 67 75  4289         .ascii  '<R>egular tape number clear\n\r'
        6C 61 72 20 74 61
        70 65 20 6E 75 6D
        62 65 72 20 63 6C
        65 61 72 0A 0D
   A416 3C 54 3E 65 73 74  4290         .ascii  '<T>est driver boards\n\r'
        20 64 72 69 76 65
        72 20 62 6F 61 72
        64 73 0A 0D
   A42C 3C 42 3E 75 62 20  4291         .ascii  '<B>ub test\n\r'
        74 65 73 74 0A 0D
   A438 3C 44 3E 65 63 6B  4292         .ascii  '<D>eck test (with tape inserted)\n\r'
        20 74 65 73 74 20
        28 77 69 74 68 20
        74 61 70 65 20 69
        6E 73 65 72 74 65
        64 29 0A 0D
   A45A 3C 37 3E 35 25 20  4293         .ascii  '<7>5% adjustment\n\r'
        61 64 6A 75 73 74
        6D 65 6E 74 0A 0D
   A46C 3C 53 3E 68 6F 77  4294         .ascii  '<S>how re-valid tapes\n\r'
        20 72 65 2D 76 61
        6C 69 64 20 74 61
        70 65 73 0A 0D
   A483 3C 4A 3E 75 6D 70  4295         .ascis  '<J>ump to system\n\r'
        20 74 6F 20 73 79
        73 74 65 6D 0A 8D
                           4296 
   A495                    4297 LA495:
   A495 BD F9 45      [ 6] 4298         jsr     SERIALR     
   A498 24 FB         [ 3] 4299         bcc     LA495  
   A49A 81 43         [ 2] 4300         cmpa    #0x43        ;'C'
   A49C 26 09         [ 3] 4301         bne     LA4A7  
   A49E 7F 04 01      [ 6] 4302         clr     (0x0401)     ;clear random
   A4A1 7F 04 2B      [ 6] 4303         clr     (0x042B)
   A4A4 7E A5 14      [ 3] 4304         jmp     LA514
   A4A7                    4305 LA4A7:
   A4A7 81 35         [ 2] 4306         cmpa    #0x35        ;'5'
   A4A9 26 0D         [ 3] 4307         bne     LA4B8  
   A4AB B6 04 01      [ 4] 4308         ldaa    (0x0401)    ;5 character random
   A4AE 84 7F         [ 2] 4309         anda    #0x7F
   A4B0 8A 7F         [ 2] 4310         oraa    #0x7F
   A4B2 B7 04 01      [ 4] 4311         staa    (0x0401)
   A4B5 7E A5 14      [ 3] 4312         jmp     LA514
   A4B8                    4313 LA4B8:
   A4B8 81 4C         [ 2] 4314         cmpa    #0x4C       ;'L'
   A4BA 26 06         [ 3] 4315         bne     LA4C2
   A4BC BD 9E AF      [ 6] 4316         jsr     L9EAF       ; reset Liv counts
   A4BF 7E A5 14      [ 3] 4317         jmp     LA514
   A4C2                    4318 LA4C2:
   A4C2 81 52         [ 2] 4319         cmpa    #0x52       ;'R'
   A4C4 26 06         [ 3] 4320         bne     LA4CC  
   A4C6 BD 9E 92      [ 6] 4321         jsr     L9E92       ; reset Reg counts
   A4C9 7E A5 14      [ 3] 4322         jmp     LA514
   A4CC                    4323 LA4CC:
   A4CC 81 54         [ 2] 4324         cmpa    #0x54       ;'T'
   A4CE 26 06         [ 3] 4325         bne     LA4D6  
   A4D0 BD A5 65      [ 6] 4326         jsr     LA565       ;test driver boards
   A4D3 7E A5 14      [ 3] 4327         jmp     LA514
   A4D6                    4328 LA4D6:
   A4D6 81 42         [ 2] 4329         cmpa    #0x42       ;'B'
   A4D8 26 06         [ 3] 4330         bne     LA4E0  
   A4DA BD A5 26      [ 6] 4331         jsr     LA526       ;bulb test?
   A4DD 7E A5 14      [ 3] 4332         jmp     LA514
   A4E0                    4333 LA4E0:
   A4E0 81 44         [ 2] 4334         cmpa    #0x44       ;'D'
   A4E2 26 06         [ 3] 4335         bne     LA4EA  
   A4E4 BD A5 3C      [ 6] 4336         jsr     LA53C       ;deck test
   A4E7 7E A5 14      [ 3] 4337         jmp     LA514
   A4EA                    4338 LA4EA:
   A4EA 81 37         [ 2] 4339         cmpa    #0x37       ;'7'
   A4EC 26 08         [ 3] 4340         bne     LA4F6  
   A4EE C6 FB         [ 2] 4341         ldab    #0xFB       ; tape deck PLAY
   A4F0 BD 86 E7      [ 6] 4342         jsr     L86E7       ;5% adjustment
   A4F3 7E A5 14      [ 3] 4343         jmp     LA514
   A4F6                    4344 LA4F6:
   A4F6 81 4A         [ 2] 4345         cmpa    #0x4A       ;'J'
   A4F8 26 03         [ 3] 4346         bne     LA4FD  
   A4FA 7E F8 00      [ 3] 4347         jmp     RESET       ;jump to system (reset)
   A4FD                    4348 LA4FD:
   A4FD 81 4B         [ 2] 4349         cmpa    #0x4B       ;'K'
   A4FF 26 06         [ 3] 4350         bne     LA507  
   A501 7C 04 2A      [ 6] 4351         inc     (0x042A)    ;King enable
   A504 7E A5 14      [ 3] 4352         jmp     LA514
   A507                    4353 LA507:
   A507 81 53         [ 2] 4354         cmpa    #0x53       ;'S'
   A509 26 06         [ 3] 4355         bne     LA511  
   A50B BD AB 7C      [ 6] 4356         jsr     LAB7C       ;show re-valid tapes
   A50E 7E A5 14      [ 3] 4357         jmp     LA514
   A511                    4358 LA511:
   A511 7E A4 95      [ 3] 4359         jmp     LA495
   A514                    4360 LA514:
   A514 86 07         [ 2] 4361         ldaa    #0x07
   A516 BD F9 6F      [ 6] 4362         jsr     SERIALW      
   A519 C6 01         [ 2] 4363         ldab    #0x01
   A51B BD 8C 30      [ 6] 4364         jsr     DLYSECSBY2  ; delay 0.5 sec
   A51E 86 07         [ 2] 4365         ldaa    #0x07
   A520 BD F9 6F      [ 6] 4366         jsr     SERIALW      
   A523 7E A3 8E      [ 3] 4367         jmp     LA38E
                           4368 
                           4369 ; bulb test
   A526                    4370 LA526:
   A526 5F            [ 2] 4371         clrb
   A527 BD F9 C5      [ 6] 4372         jsr     BUTNLIT 
   A52A                    4373 LA52A:
   A52A F6 10 0A      [ 4] 4374         ldab    PORTE
   A52D C8 FF         [ 2] 4375         eorb    #0xFF
   A52F BD F9 C5      [ 6] 4376         jsr     BUTNLIT 
   A532 C1 80         [ 2] 4377         cmpb    #0x80
   A534 26 F4         [ 3] 4378         bne     LA52A  
   A536 C6 02         [ 2] 4379         ldab    #0x02
   A538 BD 8C 30      [ 6] 4380         jsr     DLYSECSBY2           ; delay 1 sec
   A53B 39            [ 5] 4381         rts
                           4382 
                           4383 ; deck test
   A53C                    4384 LA53C:
   A53C C6 FD         [ 2] 4385         ldab    #0xFD           ; tape deck STOP
   A53E BD 86 E7      [ 6] 4386         jsr     L86E7
   A541 C6 06         [ 2] 4387         ldab    #0x06
   A543 BD 8C 30      [ 6] 4388         jsr     DLYSECSBY2      ; delay 3 sec
   A546 C6 FB         [ 2] 4389         ldab    #0xFB           ; tape deck PLAY
   A548 BD 86 E7      [ 6] 4390         jsr     L86E7
   A54B C6 06         [ 2] 4391         ldab    #0x06
   A54D BD 8C 30      [ 6] 4392         jsr     DLYSECSBY2      ; delay 3 sec
   A550 C6 FD         [ 2] 4393         ldab    #0xFD           ; tape deck STOP
   A552 BD 86 E7      [ 6] 4394         jsr     L86E7
   A555 C6 F7         [ 2] 4395         ldab    #0xF7
   A557 BD 86 E7      [ 6] 4396         jsr     L86E7           ; tape deck REWIND
   A55A C6 06         [ 2] 4397         ldab    #0x06
   A55C BD 8C 30      [ 6] 4398         jsr     DLYSECSBY2      ; delay 3 sec
   A55F C6 EF         [ 2] 4399         ldab    #0xEF           ; tape deck EJECT
   A561 BD 86 E7      [ 6] 4400         jsr     L86E7
   A564 39            [ 5] 4401         rts
                           4402 
                           4403 ; test driver boards
   A565                    4404 LA565:
   A565 BD F9 45      [ 6] 4405         jsr     SERIALR     
   A568 24 08         [ 3] 4406         bcc     LA572  
   A56A 81 1B         [ 2] 4407         cmpa    #0x1B
   A56C 26 04         [ 3] 4408         bne     LA572  
   A56E BD 86 C4      [ 6] 4409         jsr     L86C4           ; Reset boards 1-10
   A571 39            [ 5] 4410         rts
   A572                    4411 LA572:
   A572 86 08         [ 2] 4412         ldaa    #0x08
   A574 97 15         [ 3] 4413         staa    (0x0015)
   A576 BD 86 C4      [ 6] 4414         jsr     L86C4           ; Reset boards 1-10
   A579 86 01         [ 2] 4415         ldaa    #0x01
   A57B                    4416 LA57B:
   A57B 36            [ 3] 4417         psha
   A57C 16            [ 2] 4418         tab
   A57D BD F9 C5      [ 6] 4419         jsr     BUTNLIT 
   A580 B6 18 04      [ 4] 4420         ldaa    PIA0PRA 
   A583 88 08         [ 2] 4421         eora    #0x08
   A585 B7 18 04      [ 4] 4422         staa    PIA0PRA 
   A588 32            [ 4] 4423         pula
   A589 B7 10 80      [ 4] 4424         staa    (0x1080)
   A58C B7 10 84      [ 4] 4425         staa    (0x1084)
   A58F B7 10 88      [ 4] 4426         staa    (0x1088)
   A592 B7 10 8C      [ 4] 4427         staa    (0x108C)
   A595 B7 10 90      [ 4] 4428         staa    (0x1090)
   A598 B7 10 94      [ 4] 4429         staa    (0x1094)
   A59B B7 10 98      [ 4] 4430         staa    (0x1098)
   A59E B7 10 9C      [ 4] 4431         staa    (0x109C)
   A5A1 C6 14         [ 2] 4432         ldab    #0x14
   A5A3 BD A6 52      [ 6] 4433         jsr     LA652
   A5A6 49            [ 2] 4434         rola
   A5A7 36            [ 3] 4435         psha
   A5A8 D6 15         [ 3] 4436         ldab    (0x0015)
   A5AA 5A            [ 2] 4437         decb
   A5AB D7 15         [ 3] 4438         stab    (0x0015)
   A5AD BD F9 95      [ 6] 4439         jsr     DIAGDGT          ; write digit to the diag display
   A5B0 37            [ 3] 4440         pshb
   A5B1 C6 27         [ 2] 4441         ldab    #0x27
   A5B3 96 15         [ 3] 4442         ldaa    (0x0015)
   A5B5 0C            [ 2] 4443         clc
   A5B6 89 30         [ 2] 4444         adca    #0x30
   A5B8 BD 8D B5      [ 6] 4445         jsr     L8DB5            ; display char here on LCD display
   A5BB 33            [ 4] 4446         pulb
   A5BC 32            [ 4] 4447         pula
   A5BD 5D            [ 2] 4448         tstb
   A5BE 26 BB         [ 3] 4449         bne     LA57B  
   A5C0 86 08         [ 2] 4450         ldaa    #0x08
   A5C2 97 15         [ 3] 4451         staa    (0x0015)
   A5C4 BD 86 C4      [ 6] 4452         jsr     L86C4           ; Reset boards 1-10
   A5C7 86 01         [ 2] 4453         ldaa    #0x01
   A5C9                    4454 LA5C9:
   A5C9 B7 10 82      [ 4] 4455         staa    (0x1082)
   A5CC B7 10 86      [ 4] 4456         staa    (0x1086)
   A5CF B7 10 8A      [ 4] 4457         staa    (0x108A)
   A5D2 B7 10 8E      [ 4] 4458         staa    (0x108E)
   A5D5 B7 10 92      [ 4] 4459         staa    (0x1092)
   A5D8 B7 10 96      [ 4] 4460         staa    (0x1096)
   A5DB B7 10 9A      [ 4] 4461         staa    (0x109A)
   A5DE B7 10 9E      [ 4] 4462         staa    (0x109E)
   A5E1 C6 14         [ 2] 4463         ldab    #0x14
   A5E3 BD A6 52      [ 6] 4464         jsr     LA652
   A5E6 49            [ 2] 4465         rola
   A5E7 36            [ 3] 4466         psha
   A5E8 D6 15         [ 3] 4467         ldab    (0x0015)
   A5EA 5A            [ 2] 4468         decb
   A5EB D7 15         [ 3] 4469         stab    (0x0015)
   A5ED BD F9 95      [ 6] 4470         jsr     DIAGDGT           ; write digit to the diag display
   A5F0 37            [ 3] 4471         pshb
   A5F1 C6 27         [ 2] 4472         ldab    #0x27
   A5F3 96 15         [ 3] 4473         ldaa    (0x0015)
   A5F5 0C            [ 2] 4474         clc
   A5F6 89 30         [ 2] 4475         adca    #0x30
   A5F8 BD 8D B5      [ 6] 4476         jsr     L8DB5            ; display char here on LCD display
   A5FB 33            [ 4] 4477         pulb
   A5FC 32            [ 4] 4478         pula
   A5FD 7D 00 15      [ 6] 4479         tst     (0x0015)
   A600 26 C7         [ 3] 4480         bne     LA5C9  
   A602 BD 86 C4      [ 6] 4481         jsr     L86C4           ; Reset boards 1-10
   A605 CE 10 80      [ 3] 4482         ldx     #0x1080
   A608 C6 00         [ 2] 4483         ldab    #0x00
   A60A                    4484 LA60A:
   A60A 86 FF         [ 2] 4485         ldaa    #0xFF
   A60C A7 00         [ 4] 4486         staa    0,X
   A60E A7 02         [ 4] 4487         staa    2,X     
   A610 37            [ 3] 4488         pshb
   A611 C6 1E         [ 2] 4489         ldab    #0x1E
   A613 BD A6 52      [ 6] 4490         jsr     LA652
   A616 33            [ 4] 4491         pulb
   A617 86 00         [ 2] 4492         ldaa    #0x00
   A619 A7 00         [ 4] 4493         staa    0,X     
   A61B A7 02         [ 4] 4494         staa    2,X     
   A61D 5C            [ 2] 4495         incb
   A61E 3C            [ 4] 4496         pshx
   A61F BD F9 95      [ 6] 4497         jsr     DIAGDGT               ; write digit to the diag display
   A622 37            [ 3] 4498         pshb
   A623 C6 27         [ 2] 4499         ldab    #0x27
   A625 32            [ 4] 4500         pula
   A626 36            [ 3] 4501         psha
   A627 0C            [ 2] 4502         clc
   A628 89 30         [ 2] 4503         adca    #0x30
   A62A BD 8D B5      [ 6] 4504         jsr     L8DB5            ; display char here on LCD display
   A62D 33            [ 4] 4505         pulb
   A62E 38            [ 5] 4506         pulx
   A62F 08            [ 3] 4507         inx
   A630 08            [ 3] 4508         inx
   A631 08            [ 3] 4509         inx
   A632 08            [ 3] 4510         inx
   A633 8C 10 9D      [ 4] 4511         cpx     #0x109D
   A636 25 D2         [ 3] 4512         bcs     LA60A  
   A638 CE 10 80      [ 3] 4513         ldx     #0x1080
   A63B                    4514 LA63B:
   A63B 86 FF         [ 2] 4515         ldaa    #0xFF
   A63D A7 00         [ 4] 4516         staa    0,X     
   A63F A7 02         [ 4] 4517         staa    2,X     
   A641 08            [ 3] 4518         inx
   A642 08            [ 3] 4519         inx
   A643 08            [ 3] 4520         inx
   A644 08            [ 3] 4521         inx
   A645 8C 10 9D      [ 4] 4522         cpx     #0x109D
   A648 25 F1         [ 3] 4523         bcs     LA63B  
   A64A C6 06         [ 2] 4524         ldab    #0x06
   A64C BD 8C 30      [ 6] 4525         jsr     DLYSECSBY2           ; delay 3 sec
   A64F 7E A5 65      [ 3] 4526         jmp     LA565
   A652                    4527 LA652:
   A652 36            [ 3] 4528         psha
   A653 4F            [ 2] 4529         clra
   A654 DD 23         [ 4] 4530         std     CDTIMR5
   A656                    4531 LA656:
   A656 7D 00 24      [ 6] 4532         tst     CDTIMR5+1
   A659 26 FB         [ 3] 4533         bne     LA656  
   A65B 32            [ 4] 4534         pula
   A65C 39            [ 5] 4535         rts
                           4536 
                           4537 ; Comma-seperated text
   A65D                    4538 LA65D:
   A65D 30 2C 43 68 75 63  4539         .ascii  '0,Chuck,Mouth,'
        6B 2C 4D 6F 75 74
        68 2C
   A66B 31 2C 48 65 61 64  4540         .ascii  '1,Head left,'
        20 6C 65 66 74 2C
   A677 32 2C 48 65 61 64  4541         .ascii  '2,Head right,'
        20 72 69 67 68 74
        2C
   A684 32 2C 48 65 61 64  4542         .ascii  '2,Head up,'
        20 75 70 2C
   A68E 32 2C 45 79 65 73  4543         .ascii  '2,Eyes right,'
        20 72 69 67 68 74
        2C
   A69B 31 2C 45 79 65 6C  4544         .ascii  '1,Eyelids,'
        69 64 73 2C
   A6A5 31 2C 52 69 67 68  4545         .ascii  '1,Right hand,'
        74 20 68 61 6E 64
        2C
   A6B2 32 2C 45 79 65 73  4546         .ascii  '2,Eyes left,'
        20 6C 65 66 74 2C
   A6BE 31 2C 38 2C 48 65  4547         .ascii  '1,8,Helen,Mouth,'
        6C 65 6E 2C 4D 6F
        75 74 68 2C
   A6CE 31 2C 48 65 61 64  4548         .ascii  '1,Head left,'
        20 6C 65 66 74 2C
   A6DA 32 2C 48 65 61 64  4549         .ascii  '2,Head right,'
        20 72 69 67 68 74
        2C
   A6E7 32 2C 48 65 61 64  4550         .ascii  '2,Head up,'
        20 75 70 2C
   A6F1 32 2C 45 79 65 73  4551         .ascii  '2,Eyes right,'
        20 72 69 67 68 74
        2C
   A6FE 31 2C 45 79 65 6C  4552         .ascii  '1,Eyelids,'
        69 64 73 2C
   A708 31 2C 52 69 67 68  4553         .ascii  '1,Right hand,'
        74 20 68 61 6E 64
        2C
   A715 32 2C 45 79 65 73  4554         .ascii  '2,Eyes left,'
        20 6C 65 66 74 2C
   A721 31 2C 36 2C 4D 75  4555         .ascii  '1,6,Munch,Mouth,'
        6E 63 68 2C 4D 6F
        75 74 68 2C
   A731 31 2C 48 65 61 64  4556         .ascii  '1,Head left,'
        20 6C 65 66 74 2C
   A73D 32 2C 48 65 61 64  4557         .ascii  '2,Head right,'
        20 72 69 67 68 74
        2C
   A74A 32 2C 4C 65 66 74  4558         .ascii  '2,Left arm,'
        20 61 72 6D 2C
   A755 32 2C 45 79 65 73  4559         .ascii  '2,Eyes right,'
        20 72 69 67 68 74
        2C
   A762 31 2C 45 79 65 6C  4560         .ascii  '1,Eyelids,'
        69 64 73 2C
   A76C 31 2C 52 69 67 68  4561         .ascii  '1,Right arm,'
        74 20 61 72 6D 2C
   A778 32 2C 45 79 65 73  4562         .ascii  '2,Eyes left,'
        20 6C 65 66 74 2C
   A784 31 2C 32 2C 4A 61  4563         .ascii  '1,2,Jasper,Mouth,'
        73 70 65 72 2C 4D
        6F 75 74 68 2C
   A795 31 2C 48 65 61 64  4564         .ascii  '1,Head left,'
        20 6C 65 66 74 2C
   A7A1 32 2C 48 65 61 64  4565         .ascii  '2,Head right,'
        20 72 69 67 68 74
        2C
   A7AE 32 2C 48 65 61 64  4566         .ascii  '2,Head up,'
        20 75 70 2C
   A7B8 32 2C 45 79 65 73  4567         .ascii  '2,Eyes right,'
        20 72 69 67 68 74
        2C
   A7C5 31 2C 45 79 65 6C  4568         .ascii  '1,Eyelids,'
        69 64 73 2C
   A7CF 31 2C 48 61 6E 64  4569         .ascii  '1,Hands,'
        73 2C
   A7D7 32 2C 45 79 65 73  4570         .ascii  '2,Eyes left,'
        20 6C 65 66 74 2C
   A7E3 31 2C 34 2C 50 61  4571         .ascii  '1,4,Pasqually,Mouth-Mustache,'
        73 71 75 61 6C 6C
        79 2C 4D 6F 75 74
        68 2D 4D 75 73 74
        61 63 68 65 2C
   A800 31 2C 48 65 61 64  4572         .ascii  '1,Head left,'
        20 6C 65 66 74 2C
   A80C 32 2C 48 65 61 64  4573         .ascii  '2,Head right,'
        20 72 69 67 68 74
        2C
   A819 32 2C 4C 65 66 74  4574         .ascii  '2,Left arm,'
        20 61 72 6D 2C
   A824 32 2C 45 79 65 73  4575         .ascii  '2,Eyes right,'
        20 72 69 67 68 74
        2C
   A831 31 2C 45 79 65 6C  4576         .ascii  '1,Eyelids,'
        69 64 73 2C
   A83B 31 2C 52 69 67 68  4577         .ascii  '1,Right arm,'
        74 20 61 72 6D 2C
   A847 32 2C 45 79 65 73  4578         .ascii  '2,Eyes left,1,'
        20 6C 65 66 74 2C
        31 2C
                           4579 
   A855                    4580 LA855:
   A855 3C            [ 4] 4581         pshx
   A856 BD 86 C4      [ 6] 4582         jsr     L86C4           ; Reset boards 1-10
   A859 CE 10 80      [ 3] 4583         ldx     #0x1080
   A85C 86 20         [ 2] 4584         ldaa    #0x20
   A85E A7 00         [ 4] 4585         staa    0,X
   A860 A7 04         [ 4] 4586         staa    4,X
   A862 A7 08         [ 4] 4587         staa    8,X
   A864 A7 0C         [ 4] 4588         staa    12,X
   A866 A7 10         [ 4] 4589         staa    16,X
   A868 38            [ 5] 4590         pulx
   A869 39            [ 5] 4591         rts
                           4592 
   A86A                    4593 LA86A:
   A86A BD A3 2E      [ 6] 4594         jsr     LA32E
                           4595 
   A86D BD 8D E4      [ 6] 4596         jsr     LCDMSG1 
   A870 20 20 20 20 57 61  4597         .ascis  '    Warm-Up  '
        72 6D 2D 55 70 20
        A0
                           4598 
   A87D BD 8D DD      [ 6] 4599         jsr     LCDMSG2 
   A880 43 75 72 74 61 69  4600         .ascis  'Curtains opening'
        6E 73 20 6F 70 65
        6E 69 6E E7
                           4601 
   A890 C6 14         [ 2] 4602         ldab    #0x14
   A892 BD 8C 30      [ 6] 4603         jsr     DLYSECSBY2           ; delay 10 sec
   A895                    4604 LA895:
   A895 BD A8 55      [ 6] 4605         jsr     LA855
   A898 C6 02         [ 2] 4606         ldab    #0x02
   A89A BD 8C 30      [ 6] 4607         jsr     DLYSECSBY2           ; delay 1 sec
   A89D CE A6 5D      [ 3] 4608         ldx     #LA65D
   A8A0 C6 05         [ 2] 4609         ldab    #0x05
   A8A2 D7 12         [ 3] 4610         stab    (0x0012)
   A8A4                    4611 LA8A4:
   A8A4 C6 08         [ 2] 4612         ldab    #0x08
   A8A6 D7 13         [ 3] 4613         stab    (0x0013)
   A8A8 BD A9 41      [ 6] 4614         jsr     LA941
   A8AB BD A9 4C      [ 6] 4615         jsr     LA94C
   A8AE C6 02         [ 2] 4616         ldab    #0x02
   A8B0 BD 8C 30      [ 6] 4617         jsr     DLYSECSBY2           ; delay 1 sec
   A8B3                    4618 LA8B3:
   A8B3 BD A9 5E      [ 6] 4619         jsr     LA95E
   A8B6 A6 00         [ 4] 4620         ldaa    0,X     
   A8B8 80 30         [ 2] 4621         suba    #0x30
   A8BA 08            [ 3] 4622         inx
   A8BB 08            [ 3] 4623         inx
   A8BC 36            [ 3] 4624         psha
   A8BD 7C 00 4C      [ 6] 4625         inc     (0x004C)
   A8C0 3C            [ 4] 4626         pshx
   A8C1 BD 88 E5      [ 6] 4627         jsr     L88E5
   A8C4 38            [ 5] 4628         pulx
   A8C5 86 4F         [ 2] 4629         ldaa    #0x4F            ;'O'
   A8C7 C6 0C         [ 2] 4630         ldab    #0x0C
   A8C9 BD 8D B5      [ 6] 4631         jsr     L8DB5            ; display char here on LCD display
   A8CC 86 6E         [ 2] 4632         ldaa    #0x6E            ;'n'
   A8CE C6 0D         [ 2] 4633         ldab    #0x0D
   A8D0 BD 8D B5      [ 6] 4634         jsr     L8DB5            ; display char here on LCD display
   A8D3 CC 20 0E      [ 3] 4635         ldd     #0x200E           ;' '
   A8D6 BD 8D B5      [ 6] 4636         jsr     L8DB5            ; display char here on LCD display
   A8D9 7A 00 4C      [ 6] 4637         dec     (0x004C)
   A8DC 32            [ 4] 4638         pula
   A8DD 36            [ 3] 4639         psha
   A8DE C6 64         [ 2] 4640         ldab    #0x64
   A8E0 3D            [10] 4641         mul
   A8E1 DD 23         [ 4] 4642         std     CDTIMR5
   A8E3                    4643 LA8E3:
   A8E3 DC 23         [ 4] 4644         ldd     CDTIMR5
   A8E5 26 FC         [ 3] 4645         bne     LA8E3  
   A8E7 BD 8E 95      [ 6] 4646         jsr     L8E95
   A8EA 81 0D         [ 2] 4647         cmpa    #0x0D
   A8EC 26 05         [ 3] 4648         bne     LA8F3  
   A8EE BD A9 75      [ 6] 4649         jsr     LA975
   A8F1 20 10         [ 3] 4650         bra     LA903  
   A8F3                    4651 LA8F3:
   A8F3 81 01         [ 2] 4652         cmpa    #0x01
   A8F5 26 04         [ 3] 4653         bne     LA8FB  
   A8F7 32            [ 4] 4654         pula
   A8F8 7E A8 95      [ 3] 4655         jmp     LA895
   A8FB                    4656 LA8FB:
   A8FB 81 02         [ 2] 4657         cmpa    #0x02
   A8FD 26 04         [ 3] 4658         bne     LA903  
   A8FF 32            [ 4] 4659         pula
   A900 7E A9 35      [ 3] 4660         jmp     LA935
   A903                    4661 LA903:
   A903 3C            [ 4] 4662         pshx
   A904 BD 88 E5      [ 6] 4663         jsr     L88E5
   A907 38            [ 5] 4664         pulx
   A908 86 66         [ 2] 4665         ldaa    #0x66            ;'f'
   A90A C6 0D         [ 2] 4666         ldab    #0x0D
   A90C BD 8D B5      [ 6] 4667         jsr     L8DB5            ; display char here on LCD display
   A90F 86 66         [ 2] 4668         ldaa    #0x66            ;'f'
   A911 C6 0E         [ 2] 4669         ldab    #0x0E
   A913 BD 8D B5      [ 6] 4670         jsr     L8DB5            ; display char here on LCD display
   A916 32            [ 4] 4671         pula
   A917 C6 64         [ 2] 4672         ldab    #0x64
   A919 3D            [10] 4673         mul
   A91A DD 23         [ 4] 4674         std     CDTIMR5
   A91C                    4675 LA91C:
   A91C DC 23         [ 4] 4676         ldd     CDTIMR5
   A91E 26 FC         [ 3] 4677         bne     LA91C  
   A920 BD A8 55      [ 6] 4678         jsr     LA855
   A923 7C 00 4B      [ 6] 4679         inc     (0x004B)
   A926 96 4B         [ 3] 4680         ldaa    (0x004B)
   A928 81 48         [ 2] 4681         cmpa    #0x48
   A92A 25 87         [ 3] 4682         bcs     LA8B3  
   A92C 96 4C         [ 3] 4683         ldaa    (0x004C)
   A92E 81 34         [ 2] 4684         cmpa    #0x34
   A930 27 03         [ 3] 4685         beq     LA935  
   A932 7E A8 A4      [ 3] 4686         jmp     LA8A4
   A935                    4687 LA935:
   A935 C6 02         [ 2] 4688         ldab    #0x02
   A937 BD 8C 30      [ 6] 4689         jsr     DLYSECSBY2          ; delay 1 sec
   A93A BD 86 C4      [ 6] 4690         jsr     L86C4               ; Reset boards 1-10
   A93D BD A3 41      [ 6] 4691         jsr     LA341
   A940 39            [ 5] 4692         rts
                           4693 
   A941                    4694 LA941:
   A941 A6 00         [ 4] 4695         ldaa    0,X     
   A943 08            [ 3] 4696         inx
   A944 08            [ 3] 4697         inx
   A945 97 4C         [ 3] 4698         staa    (0x004C)
   A947 86 40         [ 2] 4699         ldaa    #0x40
   A949 97 4B         [ 3] 4700         staa    (0x004B)
   A94B 39            [ 5] 4701         rts
                           4702 
   A94C                    4703 LA94C:
   A94C BD 8C F2      [ 6] 4704         jsr     L8CF2
   A94F                    4705 LA94F:
   A94F A6 00         [ 4] 4706         ldaa    0,X     
   A951 08            [ 3] 4707         inx
   A952 81 2C         [ 2] 4708         cmpa    #0x2C
   A954 27 07         [ 3] 4709         beq     LA95D  
   A956 36            [ 3] 4710         psha
   A957 BD 8E 70      [ 6] 4711         jsr     L8E70
   A95A 32            [ 4] 4712         pula
   A95B 20 F2         [ 3] 4713         bra     LA94F  
   A95D                    4714 LA95D:
   A95D 39            [ 5] 4715         rts
                           4716 
   A95E                    4717 LA95E:
   A95E BD 8D 03      [ 6] 4718         jsr     L8D03
   A961 86 C0         [ 2] 4719         ldaa    #0xC0
   A963 BD 8E 4B      [ 6] 4720         jsr     L8E4B
   A966                    4721 LA966:
   A966 A6 00         [ 4] 4722         ldaa    0,X     
   A968 08            [ 3] 4723         inx
   A969 81 2C         [ 2] 4724         cmpa    #0x2C
   A96B 27 07         [ 3] 4725         beq     LA974  
   A96D 36            [ 3] 4726         psha
   A96E BD 8E 70      [ 6] 4727         jsr     L8E70
   A971 32            [ 4] 4728         pula
   A972 20 F2         [ 3] 4729         bra     LA966  
   A974                    4730 LA974:
   A974 39            [ 5] 4731         rts
                           4732 
   A975                    4733 LA975:
   A975 BD 8E 95      [ 6] 4734         jsr     L8E95
   A978 4D            [ 2] 4735         tsta
   A979 27 FA         [ 3] 4736         beq     LA975  
   A97B 39            [ 5] 4737         rts
                           4738 
   A97C                    4739 LA97C:
   A97C 7F 00 60      [ 6] 4740         clr     (0x0060)
   A97F FC 02 9C      [ 5] 4741         ldd     (0x029C)
   A982 1A 83 00 01   [ 5] 4742         cpd     #0x0001
   A986 27 0C         [ 3] 4743         beq     LA994  
   A988 1A 83 03 E8   [ 5] 4744         cpd     #0x03E8
   A98C 2D 7D         [ 3] 4745         blt     LAA0B  
   A98E 1A 83 04 4B   [ 5] 4746         cpd     #0x044B
   A992 22 77         [ 3] 4747         bhi     LAA0B  
   A994                    4748 LA994:
   A994 C6 40         [ 2] 4749         ldab    #0x40
   A996 D7 62         [ 3] 4750         stab    (0x0062)
   A998 BD F9 C5      [ 6] 4751         jsr     BUTNLIT 
   A99B C6 64         [ 2] 4752         ldab    #0x64           ; delay 1 sec
   A99D BD 8C 22      [ 6] 4753         jsr     DLYSECSBY100
   A9A0 BD 86 C4      [ 6] 4754         jsr     L86C4           ; Reset boards 1-10
   A9A3 BD 8C E9      [ 6] 4755         jsr     L8CE9
                           4756 
   A9A6 BD 8D E4      [ 6] 4757         jsr     LCDMSG1 
   A9A9 20 20 20 20 20 53  4758         .ascis  '     STUDIO'
        54 55 44 49 CF
                           4759 
   A9B4 BD 8D DD      [ 6] 4760         jsr     LCDMSG2 
   A9B7 70 72 6F 67 72 61  4761         .ascis  'programming mode'
        6D 6D 69 6E 67 20
        6D 6F 64 E5
                           4762 
   A9C7 BD A3 2E      [ 6] 4763         jsr     LA32E
   A9CA BD 99 9E      [ 6] 4764         jsr     L999E
   A9CD BD 99 B1      [ 6] 4765         jsr     L99B1
   A9D0 CE 20 00      [ 3] 4766         ldx     #0x2000
   A9D3                    4767 LA9D3:
   A9D3 18 CE 00 C0   [ 4] 4768         ldy     #0x00C0
   A9D7                    4769 LA9D7:
   A9D7 18 09         [ 4] 4770         dey
   A9D9 26 0A         [ 3] 4771         bne     LA9E5  
   A9DB BD A9 F4      [ 6] 4772         jsr     LA9F4
   A9DE 96 60         [ 3] 4773         ldaa    (0x0060)
   A9E0 26 29         [ 3] 4774         bne     LAA0B  
   A9E2 CE 20 00      [ 3] 4775         ldx     #0x2000
   A9E5                    4776 LA9E5:
   A9E5 B6 10 A8      [ 4] 4777         ldaa    (0x10A8)
   A9E8 84 01         [ 2] 4778         anda    #0x01
   A9EA 27 EB         [ 3] 4779         beq     LA9D7  
   A9EC B6 10 A9      [ 4] 4780         ldaa    (0x10A9)
   A9EF A7 00         [ 4] 4781         staa    0,X     
   A9F1 08            [ 3] 4782         inx
   A9F2 20 DF         [ 3] 4783         bra     LA9D3
                           4784 
   A9F4                    4785 LA9F4:
   A9F4 CE 20 00      [ 3] 4786         ldx     #0x2000
   A9F7 18 CE 10 80   [ 4] 4787         ldy     #0x1080
   A9FB                    4788 LA9FB:
   A9FB A6 00         [ 4] 4789         ldaa    0,X     
   A9FD 18 A7 00      [ 5] 4790         staa    0,Y     
   AA00 08            [ 3] 4791         inx
   AA01 18 08         [ 4] 4792         iny
   AA03 18 08         [ 4] 4793         iny
   AA05 8C 20 10      [ 4] 4794         cpx     #0x2010
   AA08 25 F1         [ 3] 4795         bcs     LA9FB  
   AA0A 39            [ 5] 4796         rts
   AA0B                    4797 LAA0B:
   AA0B 39            [ 5] 4798         rts
                           4799 
   AA0C                    4800 LAA0C:
   AA0C CC 48 37      [ 3] 4801         ldd     #0x4837           ;'H'
   AA0F                    4802 LAA0F:
   AA0F BD 8D B5      [ 6] 4803         jsr     L8DB5            ; display char here on LCD display
   AA12 39            [ 5] 4804         rts
                           4805 
   AA13                    4806 LAA13:
   AA13 CC 20 37      [ 3] 4807         ldd     #0x2037           ;' '
   AA16 20 F7         [ 3] 4808         bra     LAA0F
                           4809 
   AA18                    4810 LAA18:
   AA18 CC 42 0F      [ 3] 4811         ldd     #0x420F           ;'B'
   AA1B 20 F2         [ 3] 4812         bra     LAA0F
                           4813 
   AA1D                    4814 LAA1D:
   AA1D CC 20 0F      [ 3] 4815         ldd     #0x200F           ;' '
   AA20 20 ED         [ 3] 4816         bra     LAA0F
                           4817 
   AA22                    4818 LAA22: 
   AA22 7F 00 4F      [ 6] 4819         clr     (0x004F)
   AA25 CC 00 01      [ 3] 4820         ldd     #0x0001
   AA28 DD 1B         [ 4] 4821         std     CDTIMR1
   AA2A CE 20 00      [ 3] 4822         ldx     #0x2000
   AA2D                    4823 LAA2D:
   AA2D B6 10 A8      [ 4] 4824         ldaa    (0x10A8)
   AA30 84 01         [ 2] 4825         anda    #0x01
   AA32 27 F9         [ 3] 4826         beq     LAA2D  
   AA34 DC 1B         [ 4] 4827         ldd     CDTIMR1
   AA36 0F            [ 2] 4828         sei
   AA37 26 03         [ 3] 4829         bne     LAA3C  
   AA39 CE 20 00      [ 3] 4830         ldx     #0x2000
   AA3C                    4831 LAA3C:
   AA3C B6 10 A9      [ 4] 4832         ldaa    (0x10A9)
   AA3F A7 00         [ 4] 4833         staa    0,X     
   AA41 0E            [ 2] 4834         cli
   AA42 BD F9 6F      [ 6] 4835         jsr     SERIALW      
   AA45 08            [ 3] 4836         inx
   AA46 7F 00 4F      [ 6] 4837         clr     (0x004F)
   AA49 CC 00 01      [ 3] 4838         ldd     #0x0001
   AA4C DD 1B         [ 4] 4839         std     CDTIMR1
   AA4E 8C 20 23      [ 4] 4840         cpx     #0x2023
   AA51 26 DA         [ 3] 4841         bne     LAA2D  
   AA53 CE 20 00      [ 3] 4842         ldx     #0x2000
   AA56 7F 00 B7      [ 6] 4843         clr     (0x00B7)
   AA59                    4844 LAA59:
   AA59 A6 00         [ 4] 4845         ldaa    0,X     
   AA5B 9B B7         [ 3] 4846         adda    (0x00B7)
   AA5D 97 B7         [ 3] 4847         staa    (0x00B7)
   AA5F 08            [ 3] 4848         inx
   AA60 8C 20 22      [ 4] 4849         cpx     #0x2022
   AA63 25 F4         [ 3] 4850         bcs     LAA59  
   AA65 96 B7         [ 3] 4851         ldaa    (0x00B7)
   AA67 88 FF         [ 2] 4852         eora    #0xFF
   AA69 A1 00         [ 4] 4853         cmpa    0,X     
   AA6B CE 20 00      [ 3] 4854         ldx     #0x2000
   AA6E A6 20         [ 4] 4855         ldaa    0x20,X
   AA70 2B 03         [ 3] 4856         bmi     LAA75  
   AA72 7E AA 22      [ 3] 4857         jmp     LAA22
   AA75                    4858 LAA75:
   AA75 A6 00         [ 4] 4859         ldaa    0,X     
   AA77 B7 10 80      [ 4] 4860         staa    (0x1080)
   AA7A 08            [ 3] 4861         inx
   AA7B A6 00         [ 4] 4862         ldaa    0,X     
   AA7D B7 10 82      [ 4] 4863         staa    (0x1082)
   AA80 08            [ 3] 4864         inx
   AA81 A6 00         [ 4] 4865         ldaa    0,X     
   AA83 B7 10 84      [ 4] 4866         staa    (0x1084)
   AA86 08            [ 3] 4867         inx
   AA87 A6 00         [ 4] 4868         ldaa    0,X     
   AA89 B7 10 86      [ 4] 4869         staa    (0x1086)
   AA8C 08            [ 3] 4870         inx
   AA8D A6 00         [ 4] 4871         ldaa    0,X     
   AA8F B7 10 88      [ 4] 4872         staa    (0x1088)
   AA92 08            [ 3] 4873         inx
   AA93 A6 00         [ 4] 4874         ldaa    0,X     
   AA95 B7 10 8A      [ 4] 4875         staa    (0x108A)
   AA98 08            [ 3] 4876         inx
   AA99 A6 00         [ 4] 4877         ldaa    0,X     
   AA9B B7 10 8C      [ 4] 4878         staa    (0x108C)
   AA9E 08            [ 3] 4879         inx
   AA9F A6 00         [ 4] 4880         ldaa    0,X     
   AAA1 B7 10 8E      [ 4] 4881         staa    (0x108E)
   AAA4 08            [ 3] 4882         inx
   AAA5 A6 00         [ 4] 4883         ldaa    0,X     
   AAA7 B7 10 90      [ 4] 4884         staa    (0x1090)
   AAAA 08            [ 3] 4885         inx
   AAAB A6 00         [ 4] 4886         ldaa    0,X     
   AAAD B7 10 92      [ 4] 4887         staa    (0x1092)
   AAB0 08            [ 3] 4888         inx
   AAB1 A6 00         [ 4] 4889         ldaa    0,X     
   AAB3 8A 80         [ 2] 4890         oraa    #0x80
   AAB5 B7 10 94      [ 4] 4891         staa    (0x1094)
   AAB8 08            [ 3] 4892         inx
   AAB9 A6 00         [ 4] 4893         ldaa    0,X     
   AABB 8A 01         [ 2] 4894         oraa    #0x01
   AABD B7 10 96      [ 4] 4895         staa    (0x1096)
   AAC0 08            [ 3] 4896         inx
   AAC1 A6 00         [ 4] 4897         ldaa    0,X     
   AAC3 B7 10 98      [ 4] 4898         staa    (0x1098)
   AAC6 08            [ 3] 4899         inx
   AAC7 A6 00         [ 4] 4900         ldaa    0,X     
   AAC9 B7 10 9A      [ 4] 4901         staa    (0x109A)
   AACC 08            [ 3] 4902         inx
   AACD A6 00         [ 4] 4903         ldaa    0,X     
   AACF B7 10 9C      [ 4] 4904         staa    (0x109C)
   AAD2 08            [ 3] 4905         inx
   AAD3 A6 00         [ 4] 4906         ldaa    0,X     
   AAD5 B7 10 9E      [ 4] 4907         staa    (0x109E)
   AAD8 7E AA 22      [ 3] 4908         jmp     LAA22
                           4909 
   AADB                    4910 LAADB:
   AADB 7F 10 98      [ 6] 4911         clr     (0x1098)
   AADE 7F 10 9A      [ 6] 4912         clr     (0x109A)
   AAE1 7F 10 9C      [ 6] 4913         clr     (0x109C)
   AAE4 7F 10 9E      [ 6] 4914         clr     (0x109E)
   AAE7 39            [ 5] 4915         rts
   AAE8                    4916 LAAE8:
   AAE8 CE 04 2C      [ 3] 4917         ldx     #0x042C
   AAEB C6 10         [ 2] 4918         ldab    #0x10
   AAED                    4919 LAAED:
   AAED 5D            [ 2] 4920         tstb
   AAEE 27 12         [ 3] 4921         beq     LAB02  
   AAF0 A6 00         [ 4] 4922         ldaa    0,X     
   AAF2 81 30         [ 2] 4923         cmpa    #0x30
   AAF4 25 0D         [ 3] 4924         bcs     LAB03  
   AAF6 81 39         [ 2] 4925         cmpa    #0x39
   AAF8 22 09         [ 3] 4926         bhi     LAB03  
   AAFA 08            [ 3] 4927         inx
   AAFB 08            [ 3] 4928         inx
   AAFC 08            [ 3] 4929         inx
   AAFD 8C 04 59      [ 4] 4930         cpx     #0x0459
   AB00 23 EB         [ 3] 4931         bls     LAAED  
   AB02                    4932 LAB02:
   AB02 39            [ 5] 4933         rts
                           4934 
   AB03                    4935 LAB03:
   AB03 5A            [ 2] 4936         decb
   AB04 3C            [ 4] 4937         pshx
   AB05                    4938 LAB05:
   AB05 A6 03         [ 4] 4939         ldaa    3,X     
   AB07 A7 00         [ 4] 4940         staa    0,X     
   AB09 08            [ 3] 4941         inx
   AB0A 8C 04 5C      [ 4] 4942         cpx     #0x045C
   AB0D 25 F6         [ 3] 4943         bcs     LAB05  
   AB0F 86 FF         [ 2] 4944         ldaa    #0xFF
   AB11 B7 04 59      [ 4] 4945         staa    (0x0459)
   AB14 38            [ 5] 4946         pulx
   AB15 20 D6         [ 3] 4947         bra     LAAED
                           4948 
                           4949 ; erase revalid tape section in EEPROM
   AB17                    4950 LAB17:
   AB17 CE 04 2C      [ 3] 4951         ldx     #0x042C
   AB1A 86 FF         [ 2] 4952         ldaa    #0xFF
   AB1C                    4953 LAB1C:
   AB1C A7 00         [ 4] 4954         staa    0,X     
   AB1E 08            [ 3] 4955         inx
   AB1F 8C 04 5C      [ 4] 4956         cpx     #0x045C
   AB22 25 F8         [ 3] 4957         bcs     LAB1C
   AB24 39            [ 5] 4958         rts
                           4959 
   AB25                    4960 LAB25:
   AB25 CE 04 2C      [ 3] 4961         ldx     #0x042C
   AB28                    4962 LAB28:
   AB28 A6 00         [ 4] 4963         ldaa    0,X     
   AB2A 81 30         [ 2] 4964         cmpa    #0x30
   AB2C 25 17         [ 3] 4965         bcs     LAB45  
   AB2E 81 39         [ 2] 4966         cmpa    #0x39
   AB30 22 13         [ 3] 4967         bhi     LAB45  
   AB32 08            [ 3] 4968         inx
   AB33 08            [ 3] 4969         inx
   AB34 08            [ 3] 4970         inx
   AB35 8C 04 5C      [ 4] 4971         cpx     #0x045C
   AB38 25 EE         [ 3] 4972         bcs     LAB28  
   AB3A 86 FF         [ 2] 4973         ldaa    #0xFF
   AB3C B7 04 2C      [ 4] 4974         staa    (0x042C)
   AB3F BD AA E8      [ 6] 4975         jsr     LAAE8
   AB42 CE 04 59      [ 3] 4976         ldx     #0x0459
   AB45                    4977 LAB45:
   AB45 39            [ 5] 4978         rts
                           4979 
   AB46                    4980 LAB46:
   AB46 B6 02 99      [ 4] 4981         ldaa    (0x0299)
   AB49 A7 00         [ 4] 4982         staa    0,X     
   AB4B B6 02 9A      [ 4] 4983         ldaa    (0x029A)
   AB4E A7 01         [ 4] 4984         staa    1,X     
   AB50 B6 02 9B      [ 4] 4985         ldaa    (0x029B)
   AB53 A7 02         [ 4] 4986         staa    2,X     
   AB55 39            [ 5] 4987         rts
                           4988 
   AB56                    4989 LAB56:
   AB56 CE 04 2C      [ 3] 4990         ldx     #0x042C
   AB59                    4991 LAB59:
   AB59 B6 02 99      [ 4] 4992         ldaa    (0x0299)
   AB5C A1 00         [ 4] 4993         cmpa    0,X     
   AB5E 26 10         [ 3] 4994         bne     LAB70  
   AB60 B6 02 9A      [ 4] 4995         ldaa    (0x029A)
   AB63 A1 01         [ 4] 4996         cmpa    1,X     
   AB65 26 09         [ 3] 4997         bne     LAB70  
   AB67 B6 02 9B      [ 4] 4998         ldaa    (0x029B)
   AB6A A1 02         [ 4] 4999         cmpa    2,X     
   AB6C 26 02         [ 3] 5000         bne     LAB70  
   AB6E 20 0A         [ 3] 5001         bra     LAB7A  
   AB70                    5002 LAB70:
   AB70 08            [ 3] 5003         inx
   AB71 08            [ 3] 5004         inx
   AB72 08            [ 3] 5005         inx
   AB73 8C 04 5C      [ 4] 5006         cpx     #0x045C
   AB76 25 E1         [ 3] 5007         bcs     LAB59  
   AB78 0D            [ 2] 5008         sec
   AB79 39            [ 5] 5009         rts
                           5010 
   AB7A                    5011 LAB7A:
   AB7A 0C            [ 2] 5012         clc
   AB7B 39            [ 5] 5013         rts
                           5014 
                           5015 ;show re-valid tapes
   AB7C                    5016 LAB7C:
   AB7C CE 04 2C      [ 3] 5017         ldx     #0x042C
   AB7F                    5018 LAB7F:
   AB7F A6 00         [ 4] 5019         ldaa    0,X     
   AB81 81 30         [ 2] 5020         cmpa    #0x30
   AB83 25 1E         [ 3] 5021         bcs     LABA3  
   AB85 81 39         [ 2] 5022         cmpa    #0x39
   AB87 22 1A         [ 3] 5023         bhi     LABA3  
   AB89 BD F9 6F      [ 6] 5024         jsr     SERIALW      
   AB8C 08            [ 3] 5025         inx
   AB8D A6 00         [ 4] 5026         ldaa    0,X     
   AB8F BD F9 6F      [ 6] 5027         jsr     SERIALW      
   AB92 08            [ 3] 5028         inx
   AB93 A6 00         [ 4] 5029         ldaa    0,X     
   AB95 BD F9 6F      [ 6] 5030         jsr     SERIALW      
   AB98 08            [ 3] 5031         inx
   AB99 86 20         [ 2] 5032         ldaa    #0x20
   AB9B BD F9 6F      [ 6] 5033         jsr     SERIALW      
   AB9E 8C 04 5C      [ 4] 5034         cpx     #0x045C
   ABA1 25 DC         [ 3] 5035         bcs     LAB7F  
   ABA3                    5036 LABA3:
   ABA3 86 0D         [ 2] 5037         ldaa    #0x0D
   ABA5 BD F9 6F      [ 6] 5038         jsr     SERIALW      
   ABA8 86 0A         [ 2] 5039         ldaa    #0x0A
   ABAA BD F9 6F      [ 6] 5040         jsr     SERIALW      
   ABAD 39            [ 5] 5041         rts
                           5042 
   ABAE                    5043 LABAE:
   ABAE 7F 00 4A      [ 6] 5044         clr     (0x004A)
   ABB1 CC 00 64      [ 3] 5045         ldd     #0x0064
   ABB4 DD 23         [ 4] 5046         std     CDTIMR5
   ABB6                    5047 LABB6:
   ABB6 96 4A         [ 3] 5048         ldaa    (0x004A)
   ABB8 26 08         [ 3] 5049         bne     LABC2  
   ABBA BD 9B 19      [ 6] 5050         jsr     L9B19           ; do the random motions if enabled
   ABBD DC 23         [ 4] 5051         ldd     CDTIMR5
   ABBF 26 F5         [ 3] 5052         bne     LABB6  
   ABC1                    5053 LABC1:
   ABC1 39            [ 5] 5054         rts
                           5055 
   ABC2                    5056 LABC2:
   ABC2 81 31         [ 2] 5057         cmpa    #0x31
   ABC4 26 04         [ 3] 5058         bne     LABCA  
   ABC6 BD AB 17      [ 6] 5059         jsr     LAB17
   ABC9 39            [ 5] 5060         rts
                           5061 
   ABCA                    5062 LABCA:
   ABCA 20 F5         [ 3] 5063         bra     LABC1  
                           5064 
                           5065 ; TOC1 timer handler
                           5066 ;
                           5067 ; Timer is running at:
                           5068 ; EXTAL = 16Mhz
                           5069 ; E Clk = 4Mhz
                           5070 ; Timer Prescaler = /16 = 250Khz
                           5071 ; Timer Period = 4us
                           5072 ; T1OC is set to previous value +625
                           5073 ; So, this routine is called every 2.5ms
                           5074 ;
   ABCC                    5075 LABCC:
   ABCC DC 10         [ 4] 5076         ldd     T1NXT        ; get ready for next time
   ABCE C3 02 71      [ 4] 5077         addd    #0x0271      ; add 625
   ABD1 FD 10 16      [ 5] 5078         std     TOC1  
   ABD4 DD 10         [ 4] 5079         std     T1NXT
                           5080 
   ABD6 86 80         [ 2] 5081         ldaa    #0x80
   ABD8 B7 10 23      [ 4] 5082         staa    TFLG1       ; clear timer1 flag
                           5083 
                           5084 ; Some blinking SPECIAL button every half second,
                           5085 ; if 0x0078 is non zero
                           5086 
   ABDB 7D 00 78      [ 6] 5087         tst     (0x0078)     ; if 78 is zero, skip ahead
   ABDE 27 1C         [ 3] 5088         beq     LABFC       ; else do some blinking button lights
   ABE0 DC 25         [ 4] 5089         ldd     (0x0025)     ; else inc 25/26
   ABE2 C3 00 01      [ 4] 5090         addd    #0x0001
   ABE5 DD 25         [ 4] 5091         std     (0x0025)
   ABE7 1A 83 00 C8   [ 5] 5092         cpd     #0x00C8       ; is it 200?
   ABEB 26 0F         [ 3] 5093         bne     LABFC       ; no, keep going
   ABED 7F 00 25      [ 6] 5094         clr     (0x0025)     ; reset 25/26
   ABF0 7F 00 26      [ 6] 5095         clr     (0x0026)
   ABF3 D6 62         [ 3] 5096         ldab    (0x0062)    ; and toggle bit 3 of 62
   ABF5 C8 08         [ 2] 5097         eorb    #0x08
   ABF7 D7 62         [ 3] 5098         stab    (0x0062)
   ABF9 BD F9 C5      [ 6] 5099         jsr     BUTNLIT      ; and toggle the "special" button light
                           5100 
                           5101 ; 
   ABFC                    5102 LABFC:
   ABFC 7C 00 6F      [ 6] 5103         inc     (0x006F)     ; count every 2.5ms
   ABFF 96 6F         [ 3] 5104         ldaa    (0x006F)
   AC01 81 28         [ 2] 5105         cmpa    #0x28        ; is it 40 intervals? (0.1 sec?)
   AC03 25 42         [ 3] 5106         bcs     LAC47       ; if not yet, jump ahead
   AC05 7F 00 6F      [ 6] 5107         clr     (0x006F)     ; clear it 2.5ms counter
   AC08 7D 00 63      [ 6] 5108         tst     (0x0063)     ; decrement 0.1s counter here
   AC0B 27 03         [ 3] 5109         beq     LAC10       ; if it's not already zero
   AC0D 7A 00 63      [ 6] 5110         dec     (0x0063)
                           5111 
                           5112 ; staggered counters - here every 100ms
                           5113 
                           5114 ; 0x0070 counts from 250 to 1, period is 25 secs
   AC10                    5115 LAC10:
   AC10 96 70         [ 3] 5116         ldaa    OFFCNT1    ; decrement 0.1s counter here
   AC12 4A            [ 2] 5117         deca
   AC13 97 70         [ 3] 5118         staa    OFFCNT1
   AC15 26 04         [ 3] 5119         bne     LAC1B       
   AC17 86 FA         [ 2] 5120         ldaa    #0xFA        ; 250
   AC19 97 70         [ 3] 5121         staa    OFFCNT1
                           5122 
                           5123 ; 0x0071 counts from 230 to 1, period is 23 secs
   AC1B                    5124 LAC1B:
   AC1B 96 71         [ 3] 5125         ldaa    OFFCNT2
   AC1D 4A            [ 2] 5126         deca
   AC1E 97 71         [ 3] 5127         staa    OFFCNT2
   AC20 26 04         [ 3] 5128         bne     LAC26  
   AC22 86 E6         [ 2] 5129         ldaa    #0xE6        ; 230
   AC24 97 71         [ 3] 5130         staa    OFFCNT2
                           5131 
                           5132 ; 0x0072 counts from 210 to 1, period is 21 secs
   AC26                    5133 LAC26:
   AC26 96 72         [ 3] 5134         ldaa    OFFCNT3
   AC28 4A            [ 2] 5135         deca
   AC29 97 72         [ 3] 5136         staa    OFFCNT3
   AC2B 26 04         [ 3] 5137         bne     LAC31  
   AC2D 86 D2         [ 2] 5138         ldaa    #0xD2        ; 210
   AC2F 97 72         [ 3] 5139         staa    OFFCNT3
                           5140 
                           5141 ; 0x0073 counts from 190 to 1, period is 19 secs
   AC31                    5142 LAC31:
   AC31 96 73         [ 3] 5143         ldaa    OFFCNT4
   AC33 4A            [ 2] 5144         deca
   AC34 97 73         [ 3] 5145         staa    OFFCNT4
   AC36 26 04         [ 3] 5146         bne     LAC3C  
   AC38 86 BE         [ 2] 5147         ldaa    #0xBE        ; 190
   AC3A 97 73         [ 3] 5148         staa    OFFCNT4
                           5149 
                           5150 ; 0x0074 counts from 170 to 1, period is 17 secs
   AC3C                    5151 LAC3C:
   AC3C 96 74         [ 3] 5152         ldaa    OFFCNT5
   AC3E 4A            [ 2] 5153         deca
   AC3F 97 74         [ 3] 5154         staa    OFFCNT5
   AC41 26 04         [ 3] 5155         bne     LAC47  
   AC43 86 AA         [ 2] 5156         ldaa    #0xAA        ; 170
   AC45 97 74         [ 3] 5157         staa    OFFCNT5
                           5158 
                           5159 ; back to 2.5ms period here
                           5160 
   AC47                    5161 LAC47:
   AC47 96 27         [ 3] 5162         ldaa    T30MS
   AC49 4C            [ 2] 5163         inca
   AC4A 97 27         [ 3] 5164         staa    T30MS
   AC4C 81 0C         [ 2] 5165         cmpa    #0x0C        ; 12 = 30ms?
   AC4E 23 09         [ 3] 5166         bls     LAC59  
   AC50 7F 00 27      [ 6] 5167         clr     T30MS
                           5168 
                           5169 ; do these tasks every 30ms
   AC53 BD 8E C6      [ 6] 5170         jsr     L8EC6       ; ???
   AC56 BD 8F 12      [ 6] 5171         jsr     L8F12       ; ???
                           5172 
                           5173 ; back to every 2.5ms here
                           5174 ; LCD update???
                           5175 
   AC59                    5176 LAC59:
   AC59 96 43         [ 3] 5177         ldaa    (0x0043)
   AC5B 27 55         [ 3] 5178         beq     LACB2  
   AC5D DE 44         [ 4] 5179         ldx     (0x0044)
   AC5F A6 00         [ 4] 5180         ldaa    0,X     
   AC61 27 23         [ 3] 5181         beq     LAC86  
   AC63 B7 10 00      [ 4] 5182         staa    PORTA  
   AC66 B6 10 02      [ 4] 5183         ldaa    PORTG  
   AC69 84 F3         [ 2] 5184         anda    #0xF3
   AC6B B7 10 02      [ 4] 5185         staa    PORTG  
   AC6E 84 FD         [ 2] 5186         anda    #0xFD
   AC70 B7 10 02      [ 4] 5187         staa    PORTG  
   AC73 8A 02         [ 2] 5188         oraa    #0x02
   AC75 B7 10 02      [ 4] 5189         staa    PORTG  
   AC78 08            [ 3] 5190         inx
   AC79 08            [ 3] 5191         inx
   AC7A 8C 05 80      [ 4] 5192         cpx     #0x0580
   AC7D 25 03         [ 3] 5193         bcs     LAC82  
   AC7F CE 05 00      [ 3] 5194         ldx     #0x0500
   AC82                    5195 LAC82:
   AC82 DF 44         [ 4] 5196         stx     (0x0044)
   AC84 20 2C         [ 3] 5197         bra     LACB2  
   AC86                    5198 LAC86:
   AC86 A6 01         [ 4] 5199         ldaa    1,X     
   AC88 27 25         [ 3] 5200         beq     LACAF  
   AC8A B7 10 00      [ 4] 5201         staa    PORTA  
   AC8D B6 10 02      [ 4] 5202         ldaa    PORTG  
   AC90 84 FB         [ 2] 5203         anda    #0xFB
   AC92 8A 08         [ 2] 5204         oraa    #0x08
   AC94 B7 10 02      [ 4] 5205         staa    PORTG  
   AC97 84 FD         [ 2] 5206         anda    #0xFD
   AC99 B7 10 02      [ 4] 5207         staa    PORTG  
   AC9C 8A 02         [ 2] 5208         oraa    #0x02
   AC9E B7 10 02      [ 4] 5209         staa    PORTG  
   ACA1 08            [ 3] 5210         inx
   ACA2 08            [ 3] 5211         inx
   ACA3 8C 05 80      [ 4] 5212         cpx     #0x0580
   ACA6 25 03         [ 3] 5213         bcs     LACAB  
   ACA8 CE 05 00      [ 3] 5214         ldx     #0x0500
   ACAB                    5215 LACAB:
   ACAB DF 44         [ 4] 5216         stx     (0x0044)
   ACAD 20 03         [ 3] 5217         bra     LACB2  
   ACAF                    5218 LACAF:
   ACAF 7F 00 43      [ 6] 5219         clr     (0x0043)
                           5220 
                           5221 ; divide by 4
   ACB2                    5222 LACB2:
   ACB2 96 4F         [ 3] 5223         ldaa    (0x004F)
   ACB4 4C            [ 2] 5224         inca
   ACB5 97 4F         [ 3] 5225         staa    (0x004F)
   ACB7 81 04         [ 2] 5226         cmpa    #0x04
   ACB9 26 30         [ 3] 5227         bne     LACEB  
   ACBB 7F 00 4F      [ 6] 5228         clr     (0x004F)
                           5229 
                           5230 ; here every 10ms
                           5231 ; Five big countdown timers available here
                           5232 ; up to 655.35 seconds each
                           5233 
   ACBE DC 1B         [ 4] 5234         ldd     CDTIMR1     ; countdown 0x001B/1C every 10ms
   ACC0 27 05         [ 3] 5235         beq     LACC7       ; if not already 0
   ACC2 83 00 01      [ 4] 5236         subd    #0x0001
   ACC5 DD 1B         [ 4] 5237         std     CDTIMR1
                           5238 
   ACC7                    5239 LACC7:
   ACC7 DC 1D         [ 4] 5240         ldd     CDTIMR2     ; same with 0x001D/1E
   ACC9 27 05         [ 3] 5241         beq     LACD0  
   ACCB 83 00 01      [ 4] 5242         subd    #0x0001
   ACCE DD 1D         [ 4] 5243         std     CDTIMR2
                           5244 
   ACD0                    5245 LACD0:
   ACD0 DC 1F         [ 4] 5246         ldd     CDTIMR3     ; same with 0x001F/20
   ACD2 27 05         [ 3] 5247         beq     LACD9  
   ACD4 83 00 01      [ 4] 5248         subd    #0x0001
   ACD7 DD 1F         [ 4] 5249         std     CDTIMR3
                           5250 
   ACD9                    5251 LACD9:
   ACD9 DC 21         [ 4] 5252         ldd     CDTIMR4     ; same with 0x0021/22
   ACDB 27 05         [ 3] 5253         beq     LACE2  
   ACDD 83 00 01      [ 4] 5254         subd    #0x0001
   ACE0 DD 21         [ 4] 5255         std     CDTIMR4
                           5256 
   ACE2                    5257 LACE2:
   ACE2 DC 23         [ 4] 5258         ldd     CDTIMR5     ; same with 0x0023/24
   ACE4 27 05         [ 3] 5259         beq     LACEB  
   ACE6 83 00 01      [ 4] 5260         subd    #0x0001
   ACE9 DD 23         [ 4] 5261         std     CDTIMR5
                           5262 
                           5263 ; every other time through this, setup a task switch?
   ACEB                    5264 LACEB:
   ACEB 96 B0         [ 3] 5265         ldaa    (TSCNT)
   ACED 88 01         [ 2] 5266         eora    #0x01
   ACEF 97 B0         [ 3] 5267         staa    (TSCNT)
   ACF1 27 18         [ 3] 5268         beq     LAD0B  
                           5269 
   ACF3 BF 01 3C      [ 5] 5270         sts     (0x013C)     ; switch stacks???
   ACF6 BE 01 3E      [ 5] 5271         lds     (0x013E)
   ACF9 DC 10         [ 4] 5272         ldd     T1NXT
   ACFB 83 01 F4      [ 4] 5273         subd    #0x01F4      ; 625-500 = 125?
   ACFE FD 10 18      [ 5] 5274         std     TOC2         ; set this TOC2 to happen 0.5ms
   AD01 86 40         [ 2] 5275         ldaa    #0x40        ; after the current TOC1 but before the next TOC1
   AD03 B7 10 23      [ 4] 5276         staa    TFLG1       ; clear timer2 irq flag, just in case?
   AD06 86 C0         [ 2] 5277         ldaa    #0xC0        ;
   AD08 B7 10 22      [ 4] 5278         staa    TMSK1       ; enable TOC1 and TOC2
   AD0B                    5279 LAD0B:
   AD0B 3B            [12] 5280         rti
                           5281 
                           5282 ; TOC2 Timer handler and SWI handler
   AD0C                    5283 LAD0C:
   AD0C 86 40         [ 2] 5284         ldaa    #0x40
   AD0E B7 10 23      [ 4] 5285         staa    TFLG1       ; clear timer2 flag
   AD11 BF 01 3E      [ 5] 5286         sts     (0x013E)     ; switch stacks back???
   AD14 BE 01 3C      [ 5] 5287         lds     (0x013C)
   AD17 86 80         [ 2] 5288         ldaa    #0x80
   AD19 B7 10 22      [ 4] 5289         staa    TMSK1       ; enable TOC1 only
   AD1C 3B            [12] 5290         rti
                           5291 
                           5292 ; Secondary task??
                           5293 
   AD1D                    5294 TASK2:
   AD1D 7D 04 2A      [ 6] 5295         tst     (0x042A)
   AD20 27 35         [ 3] 5296         beq     LAD57
   AD22 96 B6         [ 3] 5297         ldaa    (0x00B6)
   AD24 26 03         [ 3] 5298         bne     LAD29
   AD26 3F            [14] 5299         swi
   AD27 20 F4         [ 3] 5300         bra     TASK2
   AD29                    5301 LAD29:
   AD29 7F 00 B6      [ 6] 5302         clr     (0x00B6)
   AD2C C6 04         [ 2] 5303         ldab    #0x04
   AD2E                    5304 LAD2E:
   AD2E 37            [ 3] 5305         pshb
   AD2F CE AD 3C      [ 3] 5306         ldx     #LAD3C
   AD32 BD 8A 1A      [ 6] 5307         jsr     L8A1A  
   AD35 3F            [14] 5308         swi
   AD36 33            [ 4] 5309         pulb
   AD37 5A            [ 2] 5310         decb
   AD38 26 F4         [ 3] 5311         bne     LAD2E  
   AD3A 20 E1         [ 3] 5312         bra     TASK2
                           5313 
   AD3C                    5314 LAD3C:
   AD3C 53 31 00           5315         .asciz     'S1'
                           5316 
   AD3F FC 02 9C      [ 5] 5317         ldd     (0x029C)
   AD42 1A 83 00 01   [ 5] 5318         cpd     #0x0001         ; 1
   AD46 27 0C         [ 3] 5319         beq     LAD54  
   AD48 1A 83 03 E8   [ 5] 5320         cpd     #0x03E8         ; 1000
   AD4C 2D 09         [ 3] 5321         blt     LAD57  
   AD4E 1A 83 04 4B   [ 5] 5322         cpd     #0x044B         ; 1099
   AD52 22 03         [ 3] 5323         bhi     LAD57  
   AD54                    5324 LAD54:
   AD54 3F            [14] 5325         swi
   AD55 20 C6         [ 3] 5326         bra     TASK2
   AD57                    5327 LAD57:
   AD57 7F 00 B3      [ 6] 5328         clr     (0x00B3)
   AD5A BD AD 7E      [ 6] 5329         jsr     LAD7E
   AD5D BD AD A0      [ 6] 5330         jsr     LADA0
   AD60 25 BB         [ 3] 5331         bcs     TASK2
   AD62 C6 0A         [ 2] 5332         ldab    #0x0A
   AD64 BD AE 13      [ 6] 5333         jsr     LAE13
   AD67 BD AD AE      [ 6] 5334         jsr     LADAE
   AD6A 25 B1         [ 3] 5335         bcs     TASK2
   AD6C C6 14         [ 2] 5336         ldab    #0x14
   AD6E BD AE 13      [ 6] 5337         jsr     LAE13
   AD71 BD AD B6      [ 6] 5338         jsr     LADB6
   AD74 25 A7         [ 3] 5339         bcs     TASK2
   AD76                    5340 LAD76:
   AD76 BD AD B8      [ 6] 5341         jsr     LADB8
   AD79 0D            [ 2] 5342         sec
   AD7A 25 A1         [ 3] 5343         bcs     TASK2
   AD7C 20 F8         [ 3] 5344         bra     LAD76
   AD7E                    5345 LAD7E:
   AD7E CE AE 1E      [ 3] 5346         ldx     #LAE1E       ;+++
   AD81 BD 8A 1A      [ 6] 5347         jsr     L8A1A  
   AD84 C6 1E         [ 2] 5348         ldab    #0x1E
   AD86 BD AE 13      [ 6] 5349         jsr     LAE13
   AD89 CE AE 22      [ 3] 5350         ldx     #LAE22       ;ATH
   AD8C BD 8A 1A      [ 6] 5351         jsr     L8A1A  
   AD8F C6 1E         [ 2] 5352         ldab    #0x1E
   AD91 BD AE 13      [ 6] 5353         jsr     LAE13
   AD94 CE AE 27      [ 3] 5354         ldx     #LAE27       ;ATZ
   AD97 BD 8A 1A      [ 6] 5355         jsr     L8A1A  
   AD9A C6 1E         [ 2] 5356         ldab    #0x1E
   AD9C BD AE 13      [ 6] 5357         jsr     LAE13
   AD9F 39            [ 5] 5358         rts
   ADA0                    5359 LADA0:
   ADA0 BD B1 DD      [ 6] 5360         jsr     LB1DD
   ADA3 25 FB         [ 3] 5361         bcs     LADA0  
   ADA5 BD B2 4F      [ 6] 5362         jsr     LB24F
                           5363 
   ADA8 52 49 4E 47 00     5364         .asciz  'RING'
                           5365 
   ADAD 39            [ 5] 5366         rts
                           5367 
   ADAE                    5368 LADAE:
   ADAE CE AE 2C      [ 3] 5369         ldx     #LAE2C
   ADB1 BD 8A 1A      [ 6] 5370         jsr     L8A1A       ;ATA
   ADB4 0C            [ 2] 5371         clc
   ADB5 39            [ 5] 5372         rts
   ADB6                    5373 LADB6:
   ADB6 0C            [ 2] 5374         clc
   ADB7 39            [ 5] 5375         rts
                           5376 
   ADB8                    5377 LADB8:
   ADB8 BD B1 D2      [ 6] 5378         jsr     LB1D2
   ADBB BD AE 31      [ 6] 5379         jsr     LAE31
   ADBE 86 01         [ 2] 5380         ldaa    #0x01
   ADC0 97 B3         [ 3] 5381         staa    (0x00B3)
   ADC2 BD B1 DD      [ 6] 5382         jsr     LB1DD
   ADC5 BD B2 71      [ 6] 5383         jsr     LB271
   ADC8 36            [ 3] 5384         psha
   ADC9 BD B2 C0      [ 6] 5385         jsr     LB2C0
   ADCC 32            [ 4] 5386         pula
   ADCD 81 01         [ 2] 5387         cmpa    #0x01
   ADCF 26 08         [ 3] 5388         bne     LADD9  
   ADD1 CE B2 95      [ 3] 5389         ldx     #LB295
   ADD4 BD 8A 1A      [ 6] 5390         jsr     L8A1A       ;'You have selected #1'
   ADD7 20 31         [ 3] 5391         bra     LAE0A  
   ADD9                    5392 LADD9:
   ADD9 81 02         [ 2] 5393         cmpa    #0x02
   ADDB 26 00         [ 3] 5394         bne     LADDD  
   ADDD                    5395 LADDD:
   ADDD 81 03         [ 2] 5396         cmpa    #0x03
   ADDF 26 00         [ 3] 5397         bne     LADE1  
   ADE1                    5398 LADE1:
   ADE1 81 04         [ 2] 5399         cmpa    #0x04
   ADE3 26 00         [ 3] 5400         bne     LADE5  
   ADE5                    5401 LADE5:
   ADE5 81 05         [ 2] 5402         cmpa    #0x05
   ADE7 26 00         [ 3] 5403         bne     LADE9  
   ADE9                    5404 LADE9:
   ADE9 81 06         [ 2] 5405         cmpa    #0x06
   ADEB 26 00         [ 3] 5406         bne     LADED  
   ADED                    5407 LADED:
   ADED 81 07         [ 2] 5408         cmpa    #0x07
   ADEF 26 00         [ 3] 5409         bne     LADF1  
   ADF1                    5410 LADF1:
   ADF1 81 08         [ 2] 5411         cmpa    #0x08
   ADF3 26 00         [ 3] 5412         bne     LADF5  
   ADF5                    5413 LADF5:
   ADF5 81 09         [ 2] 5414         cmpa    #0x09
   ADF7 26 00         [ 3] 5415         bne     LADF9  
   ADF9                    5416 LADF9:
   ADF9 81 0A         [ 2] 5417         cmpa    #0x0A
   ADFB 26 00         [ 3] 5418         bne     LADFD  
   ADFD                    5419 LADFD:
   ADFD 81 0B         [ 2] 5420         cmpa    #0x0B
   ADFF 26 09         [ 3] 5421         bne     LAE0A  
   AE01 CE B2 AA      [ 3] 5422         ldx     #LB2AA       ;'You have selected #11'
   AE04 BD 8A 1A      [ 6] 5423         jsr     L8A1A  
   AE07 7E AE 0A      [ 3] 5424         jmp     LAE0A
   AE0A                    5425 LAE0A:
   AE0A C6 14         [ 2] 5426         ldab    #0x14
   AE0C BD AE 13      [ 6] 5427         jsr     LAE13
   AE0F 7F 00 B3      [ 6] 5428         clr     (0x00B3)
   AE12 39            [ 5] 5429         rts
                           5430 
   AE13                    5431 LAE13:
   AE13 CE 00 20      [ 3] 5432         ldx     #0x0020
   AE16                    5433 LAE16:
   AE16 3F            [14] 5434         swi
   AE17 09            [ 3] 5435         dex
   AE18 26 FC         [ 3] 5436         bne     LAE16  
   AE1A 5A            [ 2] 5437         decb
   AE1B 26 F6         [ 3] 5438         bne     LAE13  
   AE1D 39            [ 5] 5439         rts
                           5440 
                           5441 ; text??
   AE1E                    5442 LAE1E:
   AE1E 2B 2B 2B 00        5443         .asciz      '+++'
   AE22                    5444 LAE22:
   AE22 41 54 48 0D 00     5445         .asciz      'ATH\r'
   AE27                    5446 LAE27:
   AE27 41 54 5A 0D 00     5447         .asciz      'ATZ\r'
   AE2C                    5448 LAE2C:
   AE2C 41 54 41 0D 00     5449         .asciz      'ATA\r'
                           5450 
   AE31                    5451 LAE31:
   AE31 CE AE 38      [ 3] 5452         ldx     #LAE38       ; big long string of stats?
   AE34 BD 8A 1A      [ 6] 5453         jsr     L8A1A  
   AE37 39            [ 5] 5454         rts
                           5455 
   AE38                    5456 LAE38:
   AE38 5E 30 31 30 31 53  5457         .ascii  "^0101Serial #:^0140#0000^0111~4"
        65 72 69 61 6C 20
        23 3A 5E 30 31 34
        30 23 30 30 30 30
        5E 30 31 31 31 7E
        34
   AE57 0E 20              5458         .byte   0x0E,0x20
   AE59 5E 30 31 34 31 7C  5459         .ascii  "^0141|"
   AE5F 04 28              5460         .byte   0x04,0x28
   AE61 5E 30 33 30 31 43  5461         .ascii  "^0301CURRENT^0340HISTORY^0501Show Status:^0540Total # reg. shows:^0601Random Status:^0570|"
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
   AEBB 04 10              5462         .byte   0x04,0x10
   AEBD 5E 30 36 34 30 54  5463         .ascii  "^0640Total # live shows:^0701Current Reg Tape #:^0670|"
        6F 74 61 6C 20 23
        20 6C 69 76 65 20
        73 68 6F 77 73 3A
        5E 30 37 30 31 43
        75 72 72 65 6E 74
        20 52 65 67 20 54
        61 70 65 20 23 3A
        5E 30 36 37 30 7C
   AEF3 04 12              5464         .byte   0x04,0x12
   AEF5 5E 30 37 33 30 7E  5465         .ascii  "^0730~3"
        33
   AEFC 04 02              5466         .byte   0x04,0x02
   AEFE 5E 30 37 34 30 54  5467         .ascii  "^0740Total # failed pswd attempts:^0801Current Live Tape #:^0770|"
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
   AF3F 04 14              5468         .byte   0x04,0x14
   AF41 5E 30 38 33 30 7E  5469         .ascii  "^0830~3"
        33
   AF48 04 05              5470         .byte   0x04,0x05
   AF4A 5E 30 38 34 30 54  5471         .ascii  "^0840Total # successful pswd:^0901Current Version #:^0870|"
        6F 74 61 6C 20 23
        20 73 75 63 63 65
        73 73 66 75 6C 20
        70 73 77 64 3A 5E
        30 39 30 31 43 75
        72 72 65 6E 74 20
        56 65 72 73 69 6F
        6E 20 23 3A 5E 30
        38 37 30 7C
   AF84 04 16              5472         .byte   0x04,0x16
   AF86 5E 30 39 33 30 40  5473         .ascii  "^0930@"
   AF8C 04 00              5474         .byte   0x04,0x00
   AF8E 5E 30 39 34 30 54  5475         .ascii  "^0940Total # bdays played:^1040Total # VCR adjusts:^0970|"
        6F 74 61 6C 20 23
        20 62 64 61 79 73
        20 70 6C 61 79 65
        64 3A 5E 31 30 34
        30 54 6F 74 61 6C
        20 23 20 56 43 52
        20 61 64 6A 75 73
        74 73 3A 5E 30 39
        37 30 7C
   AFC7 04 18              5476         .byte   0x04,0x18
   AFC9 5E 31 30 37 30 7C  5477         .ascii  "^1070|"
   AFCF 04 1A              5478         .byte   0x04,0x1A
   AFD1 5E 31 31 34 30 54  5479         .ascii  "^1140Total # remote accesses:^1240Total # access attempts:^1170|"
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
   B011 04 1C              5480         .byte   0x04,0x1C
   B013 5E 31 32 37 30 7C  5481         .ascii  "^1270|"
   B019 04 1E              5482         .byte   0x04,0x1E
   B01B 5E 31 33 34 30 54  5483         .ascii  "^1340Total # rejected showtapes:^1440Total # Short bdays:^1370|"
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
   B05A 04 20              5484         .byte   0x04,0x20
   B05C 5E 31 34 37 30 7C  5485         .ascii  "^1470|"
   B062 04 22              5486         .byte   0x04,0x22
   B064 5E 31 35 34 30 54  5487         .ascii  "^1540Total # Reg bdays:^1640Total # resets-pwr ups:^1570|"
        6F 74 61 6C 20 23
        20 52 65 67 20 62
        64 61 79 73 3A 5E
        31 36 34 30 54 6F
        74 61 6C 20 23 20
        72 65 73 65 74 73
        2D 70 77 72 20 75
        70 73 3A 5E 31 35
        37 30 7C
   B09D 04 24              5488         .byte   0x04,0x24
   B09F 5E 31 36 37 30 7C  5489         .ascii  "^1670|"
   B0A5 04 26              5490         .byte   0x04,0x26
   B0A7 5E 31 38 30 31 46  5491         .ascii  "^1801FUNCTIONS^1823Select Function:^20011.Clear rnd enables^2028 6.Set loc name-#^205411.Diagnostics^21012.Set rnd enables^2128 7.Set Time^215412.^22013.Set reg tape #^2228 8.Disbl-enbl show^225413.^23014.Set liv tape #^2328 9.Upload program^235414.^24015.Reset history^242810.Debugger^245415.^1840"
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
   B1D1 00                 5492         .byte   0x00
                           5493 
   B1D2                    5494 LB1D2:
   B1D2 CE B1 D8      [ 3] 5495         ldx     #LB1D8       ; escape sequence?
   B1D5 7E 8A 1A      [ 3] 5496         jmp     L8A1A  
                           5497 
                           5498 ; ANSI control sequence - Clear Screen and Home Cursor
   B1D8                    5499 LB1D8:
                           5500         ; esc[2J
   B1D8 1B                 5501         .byte   0x1b
   B1D9 5B 32 4A 00        5502         .asciz  '[2J'
                           5503 
   B1DD                    5504 LB1DD:
   B1DD CE 05 A0      [ 3] 5505         ldx     #0x05A0
   B1E0 CC 00 00      [ 3] 5506         ldd     #0x0000
   B1E3 FD 02 9E      [ 5] 5507         std     (0x029E)
   B1E6                    5508 LB1E6:
   B1E6 FC 02 9E      [ 5] 5509         ldd     (0x029E)
   B1E9 C3 00 01      [ 4] 5510         addd    #0x0001
   B1EC FD 02 9E      [ 5] 5511         std     (0x029E)
   B1EF 1A 83 0F A0   [ 5] 5512         cpd     #0x0FA0
   B1F3 24 28         [ 3] 5513         bcc     LB21D  
   B1F5 BD B2 23      [ 6] 5514         jsr     LB223
   B1F8 25 04         [ 3] 5515         bcs     LB1FE  
   B1FA 3F            [14] 5516         swi
   B1FB 20 E9         [ 3] 5517         bra     LB1E6  
   B1FD 39            [ 5] 5518         rts
                           5519 
   B1FE                    5520 LB1FE:
   B1FE A7 00         [ 4] 5521         staa    0,X     
   B200 08            [ 3] 5522         inx
   B201 81 0D         [ 2] 5523         cmpa    #0x0D
   B203 26 02         [ 3] 5524         bne     LB207  
   B205 20 18         [ 3] 5525         bra     LB21F  
   B207                    5526 LB207:
   B207 81 1B         [ 2] 5527         cmpa    #0x1B
   B209 26 02         [ 3] 5528         bne     LB20D  
   B20B 20 10         [ 3] 5529         bra     LB21D  
   B20D                    5530 LB20D:
   B20D 7D 00 B3      [ 6] 5531         tst     (0x00B3)
   B210 27 03         [ 3] 5532         beq     LB215  
   B212 BD 8B 3B      [ 6] 5533         jsr     L8B3B
   B215                    5534 LB215:
   B215 CC 00 00      [ 3] 5535         ldd     #0x0000
   B218 FD 02 9E      [ 5] 5536         std     (0x029E)
   B21B 20 C9         [ 3] 5537         bra     LB1E6  
   B21D                    5538 LB21D:
   B21D 0D            [ 2] 5539         sec
   B21E 39            [ 5] 5540         rts
                           5541 
   B21F                    5542 LB21F:
   B21F 6F 00         [ 6] 5543         clr     0,X     
   B221 0C            [ 2] 5544         clc
   B222 39            [ 5] 5545         rts
                           5546 
   B223                    5547 LB223:
   B223 B6 18 0D      [ 4] 5548         ldaa    SCCCTRLB
   B226 44            [ 2] 5549         lsra
   B227 25 0B         [ 3] 5550         bcs     LB234  
   B229 4F            [ 2] 5551         clra
   B22A B7 18 0D      [ 4] 5552         staa    SCCCTRLB
   B22D 86 30         [ 2] 5553         ldaa    #0x30
   B22F B7 18 0D      [ 4] 5554         staa    SCCCTRLB
   B232 0C            [ 2] 5555         clc
   B233 39            [ 5] 5556         rts
                           5557 
   B234                    5558 LB234:
   B234 86 01         [ 2] 5559         ldaa    #0x01
   B236 B7 18 0D      [ 4] 5560         staa    SCCCTRLB
   B239 86 70         [ 2] 5561         ldaa    #0x70
   B23B B5 18 0D      [ 4] 5562         bita    SCCCTRLB
   B23E 26 05         [ 3] 5563         bne     LB245  
   B240 0D            [ 2] 5564         sec
   B241 B6 18 0F      [ 4] 5565         ldaa    SCCDATAB
   B244 39            [ 5] 5566         rts
                           5567 
   B245                    5568 LB245:
   B245 B6 18 0F      [ 4] 5569         ldaa    SCCDATAB
   B248 86 30         [ 2] 5570         ldaa    #0x30
   B24A B7 18 0C      [ 4] 5571         staa    SCCCTRLA
   B24D 0C            [ 2] 5572         clc
   B24E 39            [ 5] 5573         rts
                           5574 
   B24F                    5575 LB24F:
   B24F 38            [ 5] 5576         pulx
   B250 18 CE 05 A0   [ 4] 5577         ldy     #0x05A0
   B254                    5578 LB254:
   B254 A6 00         [ 4] 5579         ldaa    0,X
   B256 27 11         [ 3] 5580         beq     LB269
   B258 08            [ 3] 5581         inx
   B259 18 A1 00      [ 5] 5582         cmpa    0,Y
   B25C 26 04         [ 3] 5583         bne     LB262
   B25E 18 08         [ 4] 5584         iny
   B260 20 F2         [ 3] 5585         bra     LB254
   B262                    5586 LB262:
   B262 A6 00         [ 4] 5587         ldaa    0,X
   B264 27 07         [ 3] 5588         beq     LB26D
   B266 08            [ 3] 5589         inx
   B267 20 F9         [ 3] 5590         bra     LB262
   B269                    5591 LB269:
   B269 08            [ 3] 5592         inx
   B26A 3C            [ 4] 5593         pshx
   B26B 0C            [ 2] 5594         clc
   B26C 39            [ 5] 5595         rts
   B26D                    5596 LB26D:
   B26D 08            [ 3] 5597         inx
   B26E 3C            [ 4] 5598         pshx
   B26F 0D            [ 2] 5599         sec
   B270 39            [ 5] 5600         rts
                           5601 
   B271                    5602 LB271:
   B271 CE 05 A0      [ 3] 5603         ldx     #0x05A0
   B274                    5604 LB274:
   B274 A6 00         [ 4] 5605         ldaa    0,X
   B276 08            [ 3] 5606         inx
   B277 81 0D         [ 2] 5607         cmpa    #0x0D
   B279 26 F9         [ 3] 5608         bne     LB274
   B27B 09            [ 3] 5609         dex
   B27C 09            [ 3] 5610         dex
   B27D A6 00         [ 4] 5611         ldaa    0,X
   B27F 09            [ 3] 5612         dex
   B280 80 30         [ 2] 5613         suba    #0x30
   B282 97 B2         [ 3] 5614         staa    (0x00B2)
   B284 8C 05 9F      [ 4] 5615         cpx     #0x059F
   B287 27 0B         [ 3] 5616         beq     LB294
   B289 A6 00         [ 4] 5617         ldaa    0,X
   B28B 09            [ 3] 5618         dex
   B28C 80 30         [ 2] 5619         suba    #0x30
   B28E C6 0A         [ 2] 5620         ldab    #0x0A
   B290 3D            [10] 5621         mul
   B291 17            [ 2] 5622         tba
   B292 9B B2         [ 3] 5623         adda    (0x00B2)
   B294                    5624 LB294:
   B294 39            [ 5] 5625         rts
                           5626 
   B295                    5627 LB295:
   B295 59 6F 75 20 68 61  5628         .asciz  'You have selected #1'
        76 65 20 73 65 6C
        65 63 74 65 64 20
        23 31 00
   B2AA                    5629 LB2AA:
   B2AA 59 6F 75 20 68 61  5630         .asciz  'You have selected #11'
        76 65 20 73 65 6C
        65 63 74 65 64 20
        23 31 31 00
                           5631 
   B2C0                    5632 LB2C0:
   B2C0 CE B2 C7      [ 3] 5633         ldx     #LB2C7      ; strange table
   B2C3 BD 8A 1A      [ 6] 5634         jsr     L8A1A  
   B2C6 39            [ 5] 5635         rts
                           5636 
   B2C7                    5637 LB2C7:
   B2C7 5E 32 30 30 31 25  5638         .asciz  "^2001%^2101%^2201%^2301%^2401%^2001"
        5E 32 31 30 31 25
        5E 32 32 30 31 25
        5E 32 33 30 31 25
        5E 32 34 30 31 25
        5E 32 30 30 31 00
                           5639 
                           5640 ; Random movement tables
                           5641 
                           5642 ; board 1
   B2EB                    5643 LB2EB:
   B2EB FA 20 FA 20 F6 22  5644         .byte   0xfa,0x20,0xfa,0x20,0xf6,0x22,0xf5,0x20
        F5 20
   B2F3 F5 20 F3 22 F2 20  5645         .byte   0xf5,0x20,0xf3,0x22,0xf2,0x20,0xe5,0x22
        E5 22
   B2FB E5 22 E2 20 D2 20  5646         .byte   0xe5,0x22,0xe2,0x20,0xd2,0x20,0xbe,0x00
        BE 00
   B303 BC 22 BB 30 B9 32  5647         .byte   0xbc,0x22,0xbb,0x30,0xb9,0x32,0xb9,0x32
        B9 32
   B30B B7 30 B6 32 B5 30  5648         .byte   0xb7,0x30,0xb6,0x32,0xb5,0x30,0xb4,0x32
        B4 32
   B313 B4 32 B3 20 B3 20  5649         .byte   0xb4,0x32,0xb3,0x20,0xb3,0x20,0xb1,0xa0
        B1 A0
   B31B B1 A0 B0 A2 AF A0  5650         .byte   0xb1,0xa0,0xb0,0xa2,0xaf,0xa0,0xaf,0xa6
        AF A6
   B323 AE A0 AE A6 AD A4  5651         .byte   0xae,0xa0,0xae,0xa6,0xad,0xa4,0xac,0xa0
        AC A0
   B32B AC A0 AB A0 AA A0  5652         .byte   0xac,0xa0,0xab,0xa0,0xaa,0xa0,0xaa,0xa0
        AA A0
   B333 A2 80 A0 A0 A0 A0  5653         .byte   0xa2,0x80,0xa0,0xa0,0xa0,0xa0,0x8d,0x80
        8D 80
   B33B 8A A0 7E 80 7B A0  5654         .byte   0x8a,0xa0,0x7e,0x80,0x7b,0xa0,0x79,0xa4
        79 A4
   B343 78 A0 77 A4 76 A0  5655         .byte   0x78,0xa0,0x77,0xa4,0x76,0xa0,0x75,0xa4
        75 A4
   B34B 74 A0 73 A4 72 A0  5656         .byte   0x74,0xa0,0x73,0xa4,0x72,0xa0,0x71,0xa4
        71 A4
   B353 70 A0 6F A4 6E A0  5657         .byte   0x70,0xa0,0x6f,0xa4,0x6e,0xa0,0x6d,0xa4
        6D A4
   B35B 6C A0 69 80 69 80  5658         .byte   0x6c,0xa0,0x69,0x80,0x69,0x80,0x67,0xa0
        67 A0
   B363 5E 20 58 24 57 20  5659         .byte   0x5e,0x20,0x58,0x24,0x57,0x20,0x57,0x20
        57 20
   B36B 56 24 55 20 54 24  5660         .byte   0x56,0x24,0x55,0x20,0x54,0x24,0x54,0x24
        54 24
   B373 53 20 52 24 52 24  5661         .byte   0x53,0x20,0x52,0x24,0x52,0x24,0x50,0x20
        50 20
   B37B 4F 24 4E 20 4D 24  5662         .byte   0x4f,0x24,0x4e,0x20,0x4d,0x24,0x4c,0x20
        4C 20
   B383 4C 20 4B 24 4A 20  5663         .byte   0x4c,0x20,0x4b,0x24,0x4a,0x20,0x49,0x20
        49 20
   B38B 49 00 48 20 47 20  5664         .byte   0x49,0x00,0x48,0x20,0x47,0x20,0x47,0x20
        47 20
   B393 46 20 45 24 45 24  5665         .byte   0x46,0x20,0x45,0x24,0x45,0x24,0x44,0x20
        44 20
   B39B 42 20 42 20 37 04  5666         .byte   0x42,0x20,0x42,0x20,0x37,0x04,0x35,0x20
        35 20
   B3A3 2E 04 2E 04 2D 20  5667         .byte   0x2e,0x04,0x2e,0x04,0x2d,0x20,0x23,0x24
        23 24
   B3AB 21 20 17 24 13 00  5668         .byte   0x21,0x20,0x17,0x24,0x13,0x00,0x11,0x24
        11 24
   B3B3 10 30 07 34 06 30  5669         .byte   0x10,0x30,0x07,0x34,0x06,0x30,0x05,0x30
        05 30
   B3BB FF FF              5670         .byte   0xff,0xff
                           5671 
                           5672 ; board 2
   B3BD                    5673 LB3BD:
   B3BD D7 22 D5 20 C9 22  5674         .byte   0xd7,0x22,0xd5,0x20,0xc9,0x22
   B3C3 C7 20 C4 24 C3 20  5675         .byte   0xc7,0x20,0xc4,0x24,0xc3,0x20,0xc2,0x24
        C2 24
   B3CB C1 20 BF 24 BF 24  5676         .byte   0xc1,0x20,0xbf,0x24,0xbf,0x24,0xbe,0x20
        BE 20
   B3D3 BD 24 BC 20 BB 24  5677         .byte   0xbd,0x24,0xbc,0x20,0xbb,0x24,0xba,0x20
        BA 20
   B3DB B9 20 B8 24 B7 20  5678         .byte   0xb9,0x20,0xb8,0x24,0xb7,0x20,0xb4,0x00
        B4 00
   B3E3 B4 00 B2 20 A9 20  5679         .byte   0xb4,0x00,0xb2,0x20,0xa9,0x20,0xa3,0x20
        A3 20
   B3EB A2 20 A1 20 A0 20  5680         .byte   0xa2,0x20,0xa1,0x20,0xa0,0x20,0xa0,0x20
        A0 20
   B3F3 9F 20 9F 20 9E 20  5681         .byte   0x9f,0x20,0x9f,0x20,0x9e,0x20,0x9d,0x24
        9D 24
   B3FB 9D 24 9B 20 9A 24  5682         .byte   0x9d,0x24,0x9b,0x20,0x9a,0x24,0x99,0x20
        99 20
   B403 98 20 97 24 97 24  5683         .byte   0x98,0x20,0x97,0x24,0x97,0x24,0x95,0x20
        95 20
   B40B 95 20 94 00 94 00  5684         .byte   0x95,0x20,0x94,0x00,0x94,0x00,0x93,0x20
        93 20
   B413 92 00 92 00 91 20  5685         .byte   0x92,0x00,0x92,0x00,0x91,0x20,0x90,0x20
        90 20
   B41B 90 20 8F 20 8D 20  5686         .byte   0x90,0x20,0x8f,0x20,0x8d,0x20,0x8d,0x20
        8D 20
   B423 81 00 7F 20 79 00  5687         .byte   0x81,0x00,0x7f,0x20,0x79,0x00,0x79,0x00
        79 00
   B42B 78 20 76 20 6B 00  5688         .byte   0x78,0x20,0x76,0x20,0x6b,0x00,0x69,0x20
        69 20
   B433 5E 00 5C 20 5B 30  5689         .byte   0x5e,0x00,0x5c,0x20,0x5b,0x30,0x52,0x10
        52 10
   B43B 51 30 50 30 50 30  5690         .byte   0x51,0x30,0x50,0x30,0x50,0x30,0x4f,0x20
        4F 20
   B443 4E 20 4E 20 4D 20  5691         .byte   0x4e,0x20,0x4e,0x20,0x4d,0x20,0x46,0xa0
        46 A0
   B44B 45 A0 3D A0 3D A0  5692         .byte   0x45,0xa0,0x3d,0xa0,0x3d,0xa0,0x39,0x20
        39 20
   B453 2A 00 28 20 1E 00  5693         .byte   0x2a,0x00,0x28,0x20,0x1e,0x00,0x1c,0x22
        1C 22
   B45B 1C 22 1B 20 1A 22  5694         .byte   0x1c,0x22,0x1b,0x20,0x1a,0x22,0x19,0x20
        19 20
   B463 18 22 18 22 16 20  5695         .byte   0x18,0x22,0x18,0x22,0x16,0x20,0x15,0x22
        15 22
   B46B 15 22 14 A0 13 A2  5696         .byte   0x15,0x22,0x14,0xa0,0x13,0xa2,0x11,0xa0
        11 A0
   B473 FF FF              5697         .byte   0xff,0xff
                           5698 
                           5699 ; board 4
   B475                    5700 LB475:
   B475 BE 00 BC 22 BB 30  5701         .byte   0xbe,0x00,0xbc,0x22,0xbb,0x30
   B47B B9 32 B9 32 B7 30  5702         .byte   0xb9,0x32,0xb9,0x32,0xb7,0x30,0xb6,0x32
        B6 32
   B483 B5 30 B4 32 B4 32  5703         .byte   0xb5,0x30,0xb4,0x32,0xb4,0x32,0xb3,0x20
        B3 20
   B48B B3 20 B1 A0 B1 A0  5704         .byte   0xb3,0x20,0xb1,0xa0,0xb1,0xa0,0xb0,0xa2
        B0 A2
   B493 AF A0 AF A6 AE A0  5705         .byte   0xaf,0xa0,0xaf,0xa6,0xae,0xa0,0xae,0xa6
        AE A6
   B49B AD A4 AC A0 AC A0  5706         .byte   0xad,0xa4,0xac,0xa0,0xac,0xa0,0xab,0xa0
        AB A0
   B4A3 AA A0 AA A0 A2 80  5707         .byte   0xaa,0xa0,0xaa,0xa0,0xa2,0x80,0xa0,0xa0
        A0 A0
   B4AB A0 A0 8D 80 8A A0  5708         .byte   0xa0,0xa0,0x8d,0x80,0x8a,0xa0,0x7e,0x80
        7E 80
   B4B3 7B A0 79 A4 78 A0  5709         .byte   0x7b,0xa0,0x79,0xa4,0x78,0xa0,0x77,0xa4
        77 A4
   B4BB 76 A0 75 A4 74 A0  5710         .byte   0x76,0xa0,0x75,0xa4,0x74,0xa0,0x73,0xa4
        73 A4
   B4C3 72 A0 71 A4 70 A0  5711         .byte   0x72,0xa0,0x71,0xa4,0x70,0xa0,0x6f,0xa4
        6F A4
   B4CB 6E A0 6D A4 6C A0  5712         .byte   0x6e,0xa0,0x6d,0xa4,0x6c,0xa0,0x69,0x80
        69 80
   B4D3 69 80 67 A0 5E 20  5713         .byte   0x69,0x80,0x67,0xa0,0x5e,0x20,0x58,0x24
        58 24
   B4DB 57 20 57 20 56 24  5714         .byte   0x57,0x20,0x57,0x20,0x56,0x24,0x55,0x20
        55 20
   B4E3 54 24 54 24 53 20  5715         .byte   0x54,0x24,0x54,0x24,0x53,0x20,0x52,0x24
        52 24
   B4EB 52 24 50 20 4F 24  5716         .byte   0x52,0x24,0x50,0x20,0x4f,0x24,0x4e,0x20
        4E 20
   B4F3 4D 24 4C 20 4C 20  5717         .byte   0x4d,0x24,0x4c,0x20,0x4c,0x20,0x4b,0x24
        4B 24
   B4FB 4A 20 49 20 49 00  5718         .byte   0x4a,0x20,0x49,0x20,0x49,0x00,0x48,0x20
        48 20
   B503 47 20 47 20 46 20  5719         .byte   0x47,0x20,0x47,0x20,0x46,0x20,0x45,0x24
        45 24
   B50B 45 24 44 20 42 20  5720         .byte   0x45,0x24,0x44,0x20,0x42,0x20,0x42,0x20
        42 20
   B513 37 04 35 20 2E 04  5721         .byte   0x37,0x04,0x35,0x20,0x2e,0x04,0x2e,0x04
        2E 04
   B51B 2D 20 23 24 21 20  5722         .byte   0x2d,0x20,0x23,0x24,0x21,0x20,0x17,0x24
        17 24
   B523 13 00 11 24 10 30  5723         .byte   0x13,0x00,0x11,0x24,0x10,0x30,0x07,0x34
        07 34
   B52B 06 30 05 30 FF FF  5724         .byte   0x06,0x30,0x05,0x30,0xff,0xff
                           5725 
                           5726 ; board 3
   B531                    5727 LB531:
   B531 CD 20              5728         .byte   0xcd,0x20
   B533 CC 20 CB 20 CB 20  5729         .byte   0xcc,0x20,0xcb,0x20,0xcb,0x20,0xca,0x00
        CA 00
   B53B C9 20 C9 20 C8 20  5730         .byte   0xc9,0x20,0xc9,0x20,0xc8,0x20,0xc1,0xa0
        C1 A0
   B543 C0 A0 B8 A0 B8 20  5731         .byte   0xc0,0xa0,0xb8,0xa0,0xb8,0x20,0xb4,0x20
        B4 20
   B54B A6 00 A4 20 99 00  5732         .byte   0xa6,0x00,0xa4,0x20,0x99,0x00,0x97,0x22
        97 22
   B553 97 22 96 20 95 22  5733         .byte   0x97,0x22,0x96,0x20,0x95,0x22,0x94,0x20
        94 20
   B55B 93 22 93 22 91 20  5734         .byte   0x93,0x22,0x93,0x22,0x91,0x20,0x90,0x20
        90 20
   B563 90 20 8D A0 8C A0  5735         .byte   0x90,0x20,0x8d,0xa0,0x8c,0xa0,0x7d,0xa2
        7D A2
   B56B 7D A2 7B A0 7B A0  5736         .byte   0x7d,0xa2,0x7b,0xa0,0x7b,0xa0,0x79,0xa2
        79 A2
   B573 79 A2 77 A0 77 A0  5737         .byte   0x79,0xa2,0x77,0xa0,0x77,0xa0,0x76,0x80
        76 80
   B57B 75 A0 6E 20 67 24  5738         .byte   0x75,0xa0,0x6e,0x20,0x67,0x24,0x66,0x20
        66 20
   B583 65 24 64 20 63 24  5739         .byte   0x65,0x24,0x64,0x20,0x63,0x24,0x63,0x24
        63 24
   B58B 61 20 60 24 5F 20  5740         .byte   0x61,0x20,0x60,0x24,0x5f,0x20,0x5e,0x20
        5E 20
   B593 5D 24 5C 20 5B 24  5741         .byte   0x5d,0x24,0x5c,0x20,0x5b,0x24,0x5a,0x20
        5A 20
   B59B 59 24 58 20 56 20  5742         .byte   0x59,0x24,0x58,0x20,0x56,0x20,0x55,0x04
        55 04
   B5A3 54 00 53 24 52 20  5743         .byte   0x54,0x00,0x53,0x24,0x52,0x20,0x52,0x20
        52 20
   B5AB 4F 24 4F 24 4E 30  5744         .byte   0x4f,0x24,0x4f,0x24,0x4e,0x30,0x4d,0x30
        4D 30
   B5B3 47 10 45 30 35 30  5745         .byte   0x47,0x10,0x45,0x30,0x35,0x30,0x33,0x10
        33 10
   B5BB 31 30 31 30 1D 20  5746         .byte   0x31,0x30,0x31,0x30,0x1d,0x20,0xff,0xff
        FF FF
                           5747 
                           5748 ; board 5
   B5C3                    5749 LB5C3:
   B5C3 A9 20 A3 20 A2 20  5750         .byte   0xa9,0x20,0xa3,0x20,0xa2,0x20,0xa1,0x20
        A1 20
   B5CB A0 20 A0 20 9F 20  5751         .byte   0xa0,0x20,0xa0,0x20,0x9f,0x20,0x9f,0x20
        9F 20
   B5D3 9E 20 9D 24 9D 24  5752         .byte   0x9e,0x20,0x9d,0x24,0x9d,0x24,0x9b,0x20
        9B 20
   B5DB 9A 24 99 20 98 20  5753         .byte   0x9a,0x24,0x99,0x20,0x98,0x20,0x97,0x24
        97 24
   B5E3 97 24 95 20 95 20  5754         .byte   0x97,0x24,0x95,0x20,0x95,0x20,0x94,0x00
        94 00
   B5EB 94 00 93 20 92 00  5755         .byte   0x94,0x00,0x93,0x20,0x92,0x00,0x92,0x00
        92 00
   B5F3 91 20 90 20 90 20  5756         .byte   0x91,0x20,0x90,0x20,0x90,0x20,0x8f,0x20
        8F 20
   B5FB 8D 20 8D 20 81 00  5757         .byte   0x8d,0x20,0x8d,0x20,0x81,0x00,0x7f,0x20
        7F 20
   B603 79 00 79 00 78 20  5758         .byte   0x79,0x00,0x79,0x00,0x78,0x20,0x76,0x20
        76 20
   B60B 6B 00 69 20 5E 00  5759         .byte   0x6b,0x00,0x69,0x20,0x5e,0x00,0x5c,0x20
        5C 20
   B613 5B 30 52 10 51 30  5760         .byte   0x5b,0x30,0x52,0x10,0x51,0x30,0x50,0x30
        50 30
   B61B 50 30 4F 20 4E 20  5761         .byte   0x50,0x30,0x4f,0x20,0x4e,0x20,0x4e,0x20
        4E 20
   B623 4D 20 46 A0 45 A0  5762         .byte   0x4d,0x20,0x46,0xa0,0x45,0xa0,0x3d,0xa0
        3D A0
   B62B 3D A0 39 20 2A 00  5763         .byte   0x3d,0xa0,0x39,0x20,0x2a,0x00,0x28,0x20
        28 20
   B633 1E 00 1C 22 1C 22  5764         .byte   0x1e,0x00,0x1c,0x22,0x1c,0x22,0x1b,0x20
        1B 20
   B63B 1A 22 19 20 18 22  5765         .byte   0x1a,0x22,0x19,0x20,0x18,0x22,0x18,0x22
        18 22
   B643 16 20 15 22 15 22  5766         .byte   0x16,0x20,0x15,0x22,0x15,0x22,0x14,0xa0
        14 A0
   B64B 13 A2 11 A0        5767         .byte   0x13,0xa2,0x11,0xa0
                           5768 
                           5769 ; All empty (0xFFs) in this gap
                           5770 
   F780                    5771         .org    0xF780
                           5772 
                           5773 ; Tables
   F780                    5774 LF780:
   F780 57                 5775         .byte   0x57
   F781 0B                 5776         .byte   0x0b
   F782 00                 5777         .byte   0x00
   F783 00                 5778         .byte   0x00
   F784 00                 5779         .byte   0x00
   F785 00                 5780         .byte   0x00
   F786 08                 5781         .byte   0x08
   F787 00                 5782         .byte   0x00
   F788 00                 5783         .byte   0x00
   F789 00                 5784         .byte   0x00
   F78A 20                 5785         .byte   0x20
   F78B 00                 5786         .byte   0x00
   F78C 00                 5787         .byte   0x00
   F78D 00                 5788         .byte   0x00
   F78E 80                 5789         .byte   0x80
   F78F 00                 5790         .byte   0x00
   F790 00                 5791         .byte   0x00
   F791 00                 5792         .byte   0x00
   F792 00                 5793         .byte   0x00
   F793 00                 5794         .byte   0x00
   F794 00                 5795         .byte   0x00
   F795 04                 5796         .byte   0x04
   F796 00                 5797         .byte   0x00
   F797 00                 5798         .byte   0x00
   F798 00                 5799         .byte   0x00
   F799 10                 5800         .byte   0x10
   F79A 00                 5801         .byte   0x00
   F79B 00                 5802         .byte   0x00
   F79C 00                 5803         .byte   0x00
   F79D 00                 5804         .byte   0x00
   F79E 00                 5805         .byte   0x00
   F79F 00                 5806         .byte   0x00
                           5807 
   F7A0                    5808 LF7A0:
   F7A0 40                 5809         .byte   0x40
   F7A1 12                 5810         .byte   0x12
   F7A2 20                 5811         .byte   0x20
   F7A3 09                 5812         .byte   0x09
   F7A4 80                 5813         .byte   0x80
   F7A5 24                 5814         .byte   0x24
   F7A6 02                 5815         .byte   0x02
   F7A7 00                 5816         .byte   0x00
   F7A8 40                 5817         .byte   0x40
   F7A9 12                 5818         .byte   0x12
   F7AA 20                 5819         .byte   0x20
   F7AB 09                 5820         .byte   0x09
   F7AC 80                 5821         .byte   0x80
   F7AD 24                 5822         .byte   0x24
   F7AE 04                 5823         .byte   0x04
   F7AF 00                 5824         .byte   0x00
   F7B0 00                 5825         .byte   0x00
   F7B1 00                 5826         .byte   0x00
   F7B2 00                 5827         .byte   0x00
   F7B3 00                 5828         .byte   0x00
   F7B4 00                 5829         .byte   0x00
   F7B5 00                 5830         .byte   0x00
   F7B6 00                 5831         .byte   0x00
   F7B7 00                 5832         .byte   0x00
   F7B8 00                 5833         .byte   0x00
   F7B9 00                 5834         .byte   0x00
   F7BA 00                 5835         .byte   0x00
   F7BB 00                 5836         .byte   0x00
   F7BC 08                 5837         .byte   0x08
   F7BD 00                 5838         .byte   0x00
   F7BE 00                 5839         .byte   0x00
   F7BF 00                 5840         .byte   0x00
                           5841 
   F7C0                    5842 LF7C0:
   F7C0 00                 5843         .byte   0x00
                           5844 ;
                           5845 ; All empty (0xFFs) in this gap
                           5846 ;
   F800                    5847         .org    0xF800
                           5848 ; Reset
   F800                    5849 RESET:
   F800 0F            [ 2] 5850         sei                 ; disable interrupts
   F801 86 03         [ 2] 5851         ldaa    #0x03
   F803 B7 10 24      [ 4] 5852         staa    TMSK2       ; disable irqs, set prescaler to 16
   F806 86 80         [ 2] 5853         ldaa    #0x80
   F808 B7 10 22      [ 4] 5854         staa    TMSK1       ; enable OC1 irq
   F80B 86 FE         [ 2] 5855         ldaa    #0xFE
   F80D B7 10 35      [ 4] 5856         staa    BPROT       ; protect everything except $xE00-$xE1F
   F810 96 07         [ 3] 5857         ldaa    0x0007      ;
   F812 81 DB         [ 2] 5858         cmpa    #0xDB       ; special unprotect mode???
   F814 26 06         [ 3] 5859         bne     LF81C       ; if not, jump ahead
   F816 7F 10 35      [ 6] 5860         clr     BPROT       ; else unprotect everything
   F819 7F 00 07      [ 6] 5861         clr     0x0007      ; reset special unprotect mode???
   F81C                    5862 LF81C:
   F81C 8E 01 FF      [ 3] 5863         lds     #0x01FF     ; init SP
   F81F 86 A5         [ 2] 5864         ldaa    #0xA5
   F821 B7 10 5D      [ 4] 5865         staa    CSCTL       ; enable external IO:
                           5866                             ; IO1EN,  BUSSEL, active LOW
                           5867                             ; IO2EN,  PIA/SCCSEL, active LOW
                           5868                             ; CSPROG, ROMSEL priority over RAMSEL 
                           5869                             ; CSPROG, ROMSEL enabled, 32K, $8000-$FFFF
   F824 86 01         [ 2] 5870         ldaa    #0x01
   F826 B7 10 5F      [ 4] 5871         staa    CSGSIZ      ; CSGEN,  RAMSEL active low
                           5872                             ; CSGEN,  RAMSEL 32K
   F829 86 00         [ 2] 5873         ldaa    #0x00
   F82B B7 10 5E      [ 4] 5874         staa    CSGADR      ; CSGEN,  RAMSEL = $0000-$7FFF (except internal regs)
   F82E 86 F0         [ 2] 5875         ldaa    #0xF0
   F830 B7 10 5C      [ 4] 5876         staa    CSSTRH      ; 3 cycle clock stretching on BUSSEL and LCRS
   F833 7F 00 00      [ 6] 5877         clr     0x0000      ; ????? Done with basic init?
                           5878 
                           5879 ; Initialize Main PIA
   F836 86 30         [ 2] 5880         ldaa    #0x30       ;
   F838 B7 18 05      [ 4] 5881         staa    PIA0CRA     ; control register A, CA2=0, sel DDRA
   F83B B7 18 07      [ 4] 5882         staa    PIA0CRB     ; control register B, CB2=0, sel DDRB
   F83E 86 FF         [ 2] 5883         ldaa    #0xFF
   F840 B7 18 06      [ 4] 5884         staa    PIA0DDRB    ; select B0-B7 to be outputs
   F843 86 78         [ 2] 5885         ldaa    #0x78       ;
   F845 B7 18 04      [ 4] 5886         staa    PIA0DDRA    ; select A3-A6 to be outputs
   F848 86 34         [ 2] 5887         ldaa    #0x34       ;
   F84A B7 18 05      [ 4] 5888         staa    PIA0CRA     ; select output register A
   F84D B7 18 07      [ 4] 5889         staa    PIA0CRB     ; select output register B
   F850 C6 FF         [ 2] 5890         ldab    #0xFF
   F852 BD F9 C5      [ 6] 5891         jsr     BUTNLIT     ; turn on all button lights
   F855 20 13         [ 3] 5892         bra     LF86A       ; jump past data table
                           5893 
                           5894 ; Data loaded into SCCCTRLB SCC
   F857                    5895 LF857:
   F857 09 4A              5896         .byte   0x09,0x4a   ; channel reset B, master irq enable, no vector
   F859 01 10              5897         .byte   0x01,0x10   ; irq on all character received
   F85B 0C 18              5898         .byte   0x0c,0x18   ; Lower byte of time constant
   F85D 0D 00              5899         .byte   0x0d,0x00   ; Upper byte of time constant
   F85F 04 44              5900         .byte   0x04,0x44   ; X16 clock mode, 8-bit sync char, 1 stop bit, no parity
   F861 0E 63              5901         .byte   0x0e,0x63   ; Disable DPLL, BR enable & source
   F863 05 68              5902         .byte   0x05,0x68   ; No DTR/RTS, Tx 8 bits/char, Tx enable
   F865 0B 56              5903         .byte   0x0b,0x56   ; Rx & Tx & TRxC clk from BR gen
   F867 03 C1              5904         .byte   0x03,0xc1   ; Rx 8 bits/char, Rx Enable
                           5905         ;   tc = 4Mhz / (2 * DesiredRate * BRClockPeriod) - 2
                           5906         ;   DesiredRate=~4800 bps with tc=0x18 and BRClockPeriod=16
   F869 FF                 5907         .byte   0xff        ; end of table marker
                           5908 
                           5909 ; init SCC (8530)
   F86A                    5910 LF86A:
   F86A CE F8 57      [ 3] 5911         ldx     #LF857
   F86D                    5912 LF86D:
   F86D A6 00         [ 4] 5913         ldaa    0,X
   F86F 81 FF         [ 2] 5914         cmpa    #0xFF
   F871 27 06         [ 3] 5915         beq     LF879
   F873 B7 18 0D      [ 4] 5916         staa    SCCCTRLB
   F876 08            [ 3] 5917         inx
   F877 20 F4         [ 3] 5918         bra     LF86D
                           5919 
                           5920 ; Setup normal SCI, 8 data bits, 1 stop bit
                           5921 ; Interrupts disabled, Transmitter and Receiver enabled
                           5922 ; prescaler = /13, SCR=/2, rate = 9600 baud at 16Mhz clock
                           5923 
   F879                    5924 LF879:
   F879 86 00         [ 2] 5925         ldaa    #0x00
   F87B B7 10 2C      [ 4] 5926         staa    SCCR1  
   F87E 86 0C         [ 2] 5927         ldaa    #0x0C
   F880 B7 10 2D      [ 4] 5928         staa    SCCR2  
   F883 86 31         [ 2] 5929         ldaa    #0x31
   F885 B7 10 2B      [ 4] 5930         staa    BAUD  
                           5931 
                           5932 ; Initialize all RAM vectors to RTI: 
                           5933 ; Opcode 0x3b into vectors at 0x0100 through 0x0139
                           5934 
   F888 CE 01 00      [ 3] 5935         ldx     #0x0100
   F88B 86 3B         [ 2] 5936         ldaa    #0x3B       ; RTI opcode
   F88D                    5937 LF88D:
   F88D A7 00         [ 4] 5938         staa    0,X
   F88F 08            [ 3] 5939         inx
   F890 08            [ 3] 5940         inx
   F891 08            [ 3] 5941         inx
   F892 8C 01 3C      [ 4] 5942         cpx     #0x013C
   F895 25 F6         [ 3] 5943         bcs     LF88D
   F897 C6 F0         [ 2] 5944         ldab    #0xF0
   F899 F7 18 04      [ 4] 5945         stab    PIA0PRA     ; enable LCD backlight, disable RESET button light
   F89C 86 7E         [ 2] 5946         ldaa    #0x7E
   F89E 97 03         [ 3] 5947         staa    (0x0003)    ; Put a jump instruction here???
                           5948 
                           5949 ; Non-destructive ram test:
                           5950 ;
                           5951 ; HC11 Internal RAM: 0x0000-0x3ff
                           5952 ; External NVRAM:    0x2000-0x7fff
                           5953 ;
                           5954 ; Note:
                           5955 ; External NVRAM:    0x0400-0xfff is also available, but not tested
                           5956 
   F8A0 CE 00 00      [ 3] 5957         ldx     #0x0000
   F8A3                    5958 LF8A3:
   F8A3 E6 00         [ 4] 5959         ldab    0,X         ; save value
   F8A5 86 55         [ 2] 5960         ldaa    #0x55
   F8A7 A7 00         [ 4] 5961         staa    0,X
   F8A9 A1 00         [ 4] 5962         cmpa    0,X
   F8AB 26 19         [ 3] 5963         bne     LF8C6
   F8AD 49            [ 2] 5964         rola
   F8AE A7 00         [ 4] 5965         staa    0,X
   F8B0 A1 00         [ 4] 5966         cmpa    0,X
   F8B2 26 12         [ 3] 5967         bne     LF8C6
   F8B4 E7 00         [ 4] 5968         stab    0,X         ; restore value
   F8B6 08            [ 3] 5969         inx
   F8B7 8C 04 00      [ 4] 5970         cpx     #0x0400
   F8BA 26 03         [ 3] 5971         bne     LF8BF
   F8BC CE 20 00      [ 3] 5972         ldx     #0x2000
   F8BF                    5973 LF8BF:  
   F8BF 8C 80 00      [ 4] 5974         cpx     #0x8000
   F8C2 26 DF         [ 3] 5975         bne     LF8A3
   F8C4 20 04         [ 3] 5976         bra     LF8CA
                           5977 
   F8C6                    5978 LF8C6:
   F8C6 86 01         [ 2] 5979         ldaa    #0x01       ; Mark Failed RAM test
   F8C8 97 00         [ 3] 5980         staa    (0x0000)
                           5981 ; 
   F8CA                    5982 LF8CA:
   F8CA C6 01         [ 2] 5983         ldab    #0x01
   F8CC BD F9 95      [ 6] 5984         jsr     DIAGDGT     ; write digit 1 to diag display
   F8CF B6 10 35      [ 4] 5985         ldaa    BPROT  
   F8D2 26 0F         [ 3] 5986         bne     LF8E3       ; if something is protected, jump ahead
   F8D4 B6 30 00      [ 4] 5987         ldaa    (0x3000)    ; NVRAM
   F8D7 81 7E         [ 2] 5988         cmpa    #0x7E
   F8D9 26 08         [ 3] 5989         bne     LF8E3       ; if RAM(0x3000) == 0x7E, jump ahead anyway (special unlock?)
                           5990 
                           5991 ; error?
   F8DB C6 0E         [ 2] 5992         ldab    #0x0E
   F8DD BD F9 95      [ 6] 5993         jsr     DIAGDGT      ; write digit E to diag display
   F8E0 7E 30 00      [ 3] 5994         jmp     (0x3000)     ; jump to routine in NVRAM?
                           5995 
                           5996 ; checking for serial connection
                           5997 
   F8E3                    5998 LF8E3:
   F8E3 CE F0 00      [ 3] 5999         ldx     #0xF000     ; timeout counter
   F8E6                    6000 LF8E6:
   F8E6 01            [ 2] 6001         nop
   F8E7 01            [ 2] 6002         nop
   F8E8 09            [ 3] 6003         dex
   F8E9 27 0B         [ 3] 6004         beq     LF8F6       ; if time is up, jump ahead
   F8EB BD F9 45      [ 6] 6005         jsr     SERIALR     ; else read serial data if available
   F8EE 24 F6         [ 3] 6006         bcc     LF8E6       ; if no data available, loop
   F8F0 81 1B         [ 2] 6007         cmpa    #0x1B       ; if serial data was read, is it an ESC?
   F8F2 27 29         [ 3] 6008         beq     LF91D       ; if so, jump to echo hex char routine?
   F8F4 20 F0         [ 3] 6009         bra     LF8E6       ; else loop
   F8F6                    6010 LF8F6:
   F8F6 B6 80 00      [ 4] 6011         ldaa    L8000       ; check if this is a regular rom?
   F8F9 81 7E         [ 2] 6012         cmpa    #0x7E        
   F8FB 26 0B         [ 3] 6013         bne     MINIMON     ; if not, jump ahead
                           6014 
   F8FD C6 0A         [ 2] 6015         ldab    #0x0A
   F8FF BD F9 95      [ 6] 6016         jsr     DIAGDGT     ; else write digit A to diag display
                           6017 
   F902 BD 80 00      [ 6] 6018         jsr     L8000       ; jump to start of rom routine
   F905 0F            [ 2] 6019         sei                 ; if we ever come return, just loop and do it all again
   F906 20 EE         [ 3] 6020         bra     LF8F6
                           6021 
                           6022 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           6023 
   F908                    6024 MINIMON:
   F908 C6 10         [ 2] 6025         ldab    #0x10       ; not a regular rom
   F90A BD F9 95      [ 6] 6026         jsr     DIAGDGT     ; blank the diag display
                           6027 
   F90D BD F9 D8      [ 6] 6028         jsr     SERMSGW     ; enter the mini-monitor???
   F910 4D 49 4E 49 2D 4D  6029         .ascis  'MINI-MON'
        4F CE
                           6030 
   F918 C6 10         [ 2] 6031         ldab    #0x10
   F91A BD F9 95      [ 6] 6032         jsr     DIAGDGT     ; blank the diag display
                           6033 
   F91D                    6034 LF91D:
   F91D 7F 00 05      [ 6] 6035         clr     (0x0005)
   F920 7F 00 04      [ 6] 6036         clr     (0x0004)
   F923 7F 00 02      [ 6] 6037         clr     (0x0002)
   F926 7F 00 06      [ 6] 6038         clr     (0x0006)
                           6039 
   F929 BD F9 D8      [ 6] 6040         jsr     SERMSGW
   F92C 0D 0A BE           6041         .ascis  '\r\n>'
                           6042 
                           6043 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           6044 
                           6045 ; convert A to 2 hex digits and transmit
   F92F                    6046 SERHEXW:
   F92F 36            [ 3] 6047         psha
   F930 44            [ 2] 6048         lsra
   F931 44            [ 2] 6049         lsra
   F932 44            [ 2] 6050         lsra
   F933 44            [ 2] 6051         lsra
   F934 BD F9 38      [ 6] 6052         jsr     LF938
   F937 32            [ 4] 6053         pula
   F938                    6054 LF938:
   F938 84 0F         [ 2] 6055         anda    #0x0F
   F93A 8A 30         [ 2] 6056         oraa    #0x30
   F93C 81 3A         [ 2] 6057         cmpa    #0x3A
   F93E 25 02         [ 3] 6058         bcs     LF942
   F940 8B 07         [ 2] 6059         adda    #0x07
   F942                    6060 LF942:
   F942 7E F9 6F      [ 3] 6061         jmp     SERIALW
                           6062 
                           6063 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           6064 
                           6065 ; serial read non-blocking
   F945                    6066 SERIALR:
   F945 B6 10 2E      [ 4] 6067         ldaa    SCSR  
   F948 85 20         [ 2] 6068         bita    #0x20
   F94A 26 09         [ 3] 6069         bne     LF955
   F94C 0C            [ 2] 6070         clc
   F94D 39            [ 5] 6071         rts
                           6072 
                           6073 ; serial blocking read
   F94E                    6074 SERBLKR:
   F94E B6 10 2E      [ 4] 6075         ldaa    SCSR        ; read serial status
   F951 85 20         [ 2] 6076         bita    #0x20
   F953 27 F9         [ 3] 6077         beq     SERBLKR     ; if RDRF=0, loop
                           6078 
                           6079 ; read serial data, (assumes it's ready)
   F955                    6080 LF955:
   F955 B6 10 2E      [ 4] 6081         ldaa    SCSR        ; read serial status
   F958 85 02         [ 2] 6082         bita    #0x02
   F95A 26 09         [ 3] 6083         bne     LF965       ; if FE=1, clear it
   F95C 85 08         [ 2] 6084         bita    #0x08
   F95E 26 05         [ 3] 6085         bne     LF965       ; if OR=1, clear it
   F960 B6 10 2F      [ 4] 6086         ldaa    SCDR        ; otherwise, good data
   F963 0D            [ 2] 6087         sec
   F964 39            [ 5] 6088         rts
                           6089 
   F965                    6090 LF965:
   F965 B6 10 2F      [ 4] 6091         ldaa    SCDR        ; clear any error
   F968 86 2F         [ 2] 6092         ldaa    #0x2F       ; '/'   
   F96A BD F9 6F      [ 6] 6093         jsr     SERIALW
   F96D 20 DF         [ 3] 6094         bra     SERBLKR     ; go to wait for a character
                           6095 
                           6096 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           6097 
                           6098 ; Send A to SCI with CR turned to CRLF
   F96F                    6099 SERIALW:
   F96F 81 0D         [ 2] 6100         cmpa    #0x0D       ; CR?
   F971 27 02         [ 3] 6101         beq     LF975       ; if so echo CR+LF
   F973 20 07         [ 3] 6102         bra     SERRAWW     ; else just echo it
   F975                    6103 LF975:
   F975 86 0D         [ 2] 6104         ldaa    #0x0D
   F977 BD F9 7C      [ 6] 6105         jsr     SERRAWW
   F97A 86 0A         [ 2] 6106         ldaa    #0x0A
                           6107 
                           6108 ; send a char to SCI
   F97C                    6109 SERRAWW:
   F97C F6 10 2E      [ 4] 6110         ldab    SCSR        ; wait for ready to send
   F97F C5 40         [ 2] 6111         bitb    #0x40
   F981 27 F9         [ 3] 6112         beq     SERRAWW
   F983 B7 10 2F      [ 4] 6113         staa    SCDR        ; send it
   F986 39            [ 5] 6114         rts
                           6115 
                           6116 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           6117 
                           6118 ; Unused?
   F987                    6119 LF987:
   F987 BD F9 4E      [ 6] 6120         jsr     SERBLKR     ; get a serial char
   F98A 81 7A         [ 2] 6121         cmpa    #0x7A       ;'z'
   F98C 22 06         [ 3] 6122         bhi     LF994
   F98E 81 61         [ 2] 6123         cmpa    #0x61       ;'a'
   F990 25 02         [ 3] 6124         bcs     LF994
   F992 82 20         [ 2] 6125         sbca    #0x20       ;convert to upper case?
   F994                    6126 LF994:
   F994 39            [ 5] 6127         rts
                           6128 
                           6129 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           6130 
                           6131 ; Write hex digit arg in B to diagnostic lights
                           6132 ; or B=0x10 or higher for blank
                           6133 
   F995                    6134 DIAGDGT:
   F995 36            [ 3] 6135         psha
   F996 C1 11         [ 2] 6136         cmpb    #0x11
   F998 25 02         [ 3] 6137         bcs     LF99C
   F99A C6 10         [ 2] 6138         ldab    #0x10
   F99C                    6139 LF99C:
   F99C CE F9 B4      [ 3] 6140         ldx     #LF9B4
   F99F 3A            [ 3] 6141         abx
   F9A0 A6 00         [ 4] 6142         ldaa    0,X
   F9A2 B7 18 06      [ 4] 6143         staa    PIA0PRB     ; write arg to local data bus
   F9A5 B6 18 04      [ 4] 6144         ldaa    PIA0PRA     ; read from Port A
   F9A8 8A 20         [ 2] 6145         oraa    #0x20       ; bit 5 high
   F9AA B7 18 04      [ 4] 6146         staa    PIA0PRA     ; write back to Port A
   F9AD 84 DF         [ 2] 6147         anda    #0xDF       ; bit 5 low
   F9AF B7 18 04      [ 4] 6148         staa    PIA0PRA     ; write back to Port A
   F9B2 32            [ 4] 6149         pula
   F9B3 39            [ 5] 6150         rts
                           6151 
                           6152 ; 7 segment patterns - XGFEDCBA
   F9B4                    6153 LF9B4:
   F9B4 C0                 6154         .byte   0xc0    ; 0
   F9B5 F9                 6155         .byte   0xf9    ; 1
   F9B6 A4                 6156         .byte   0xa4    ; 2
   F9B7 B0                 6157         .byte   0xb0    ; 3
   F9B8 99                 6158         .byte   0x99    ; 4
   F9B9 92                 6159         .byte   0x92    ; 5
   F9BA 82                 6160         .byte   0x82    ; 6
   F9BB F8                 6161         .byte   0xf8    ; 7
   F9BC 80                 6162         .byte   0x80    ; 8
   F9BD 90                 6163         .byte   0x90    ; 9
   F9BE 88                 6164         .byte   0x88    ; A 
   F9BF 83                 6165         .byte   0x83    ; b
   F9C0 C6                 6166         .byte   0xc6    ; C
   F9C1 A1                 6167         .byte   0xa1    ; d
   F9C2 86                 6168         .byte   0x86    ; E
   F9C3 8E                 6169         .byte   0x8e    ; F
   F9C4 FF                 6170         .byte   0xff    ; blank
                           6171 
                           6172 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           6173 
                           6174 ; Write arg in B to Button Lights
   F9C5                    6175 BUTNLIT:
   F9C5 36            [ 3] 6176         psha
   F9C6 F7 18 06      [ 4] 6177         stab    PIA0PRB     ; write arg to local data bus
   F9C9 B6 18 04      [ 4] 6178         ldaa    PIA0PRA     ; read from Port A
   F9CC 84 EF         [ 2] 6179         anda    #0xEF       ; bit 4 low
   F9CE B7 18 04      [ 4] 6180         staa    PIA0PRA     ; write back to Port A
   F9D1 8A 10         [ 2] 6181         oraa    #0x10       ; bit 4 high
   F9D3 B7 18 04      [ 4] 6182         staa    PIA0PRA     ; write this to Port A
   F9D6 32            [ 4] 6183         pula
   F9D7 39            [ 5] 6184         rts
                           6185 
                           6186 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           6187 
                           6188 ; Send rom message via SCI
   F9D8                    6189 SERMSGW:
   F9D8 18 38         [ 6] 6190         puly
   F9DA                    6191 LF9DA:
   F9DA 18 A6 00      [ 5] 6192         ldaa    0,Y
   F9DD 27 09         [ 3] 6193         beq     LF9E8       ; if zero terminated, return
   F9DF 2B 0C         [ 3] 6194         bmi     LF9ED       ; if high bit set..do last char and return
   F9E1 BD F9 7C      [ 6] 6195         jsr     SERRAWW     ; else send char
   F9E4 18 08         [ 4] 6196         iny
   F9E6 20 F2         [ 3] 6197         bra     LF9DA       ; and loop for next one
                           6198 
   F9E8                    6199 LF9E8:
   F9E8 18 08         [ 4] 6200         iny                 ; setup return address and return
   F9EA 18 3C         [ 5] 6201         pshy
   F9EC 39            [ 5] 6202         rts
                           6203 
   F9ED                    6204 LF9ED:
   F9ED 84 7F         [ 2] 6205         anda    #0x7F       ; remove top bit
   F9EF BD F9 7C      [ 6] 6206         jsr     SERRAWW     ; send char
   F9F2 20 F4         [ 3] 6207         bra     LF9E8       ; and we're done
   F9F4 39            [ 5] 6208         rts
                           6209 
   F9F5                    6210 DORTS:
   F9F5 39            [ 5] 6211         rts
   F9F6                    6212 DORTI:        
   F9F6 3B            [12] 6213         rti
                           6214 
                           6215 ; all 0xffs in this gap
                           6216 
   FFA0                    6217         .org    0xFFA0
                           6218 
   FFA0 7E F9 F5      [ 3] 6219         jmp     DORTS
   FFA3 7E F9 F5      [ 3] 6220         jmp     DORTS
   FFA6 7E F9 F5      [ 3] 6221         jmp     DORTS
   FFA9 7E F9 2F      [ 3] 6222         jmp     SERHEXW
   FFAC 7E F9 D8      [ 3] 6223         jmp     SERMSGW      
   FFAF 7E F9 45      [ 3] 6224         jmp     SERIALR     
   FFB2 7E F9 6F      [ 3] 6225         jmp     SERIALW      
   FFB5 7E F9 08      [ 3] 6226         jmp     MINIMON
   FFB8 7E F9 95      [ 3] 6227         jmp     DIAGDGT 
   FFBB 7E F9 C5      [ 3] 6228         jmp     BUTNLIT 
                           6229 
   FFBE FF                 6230        .byte    0xff
   FFBF FF                 6231        .byte    0xff
                           6232 
                           6233 ; Vectors
                           6234 
   FFC0 F9 F6              6235        .word   DORTI        ; Stub RTI
   FFC2 F9 F6              6236        .word   DORTI        ; Stub RTI
   FFC4 F9 F6              6237        .word   DORTI        ; Stub RTI
   FFC6 F9 F6              6238        .word   DORTI        ; Stub RTI
   FFC8 F9 F6              6239        .word   DORTI        ; Stub RTI
   FFCA F9 F6              6240        .word   DORTI        ; Stub RTI
   FFCC F9 F6              6241        .word   DORTI        ; Stub RTI
   FFCE F9 F6              6242        .word   DORTI        ; Stub RTI
   FFD0 F9 F6              6243        .word   DORTI        ; Stub RTI
   FFD2 F9 F6              6244        .word   DORTI        ; Stub RTI
   FFD4 F9 F6              6245        .word   DORTI        ; Stub RTI
                           6246 
   FFD6 01 00              6247         .word  0x0100       ; SCI
   FFD8 01 03              6248         .word  0x0103       ; SPI
   FFDA 01 06              6249         .word  0x0106       ; PA accum. input edge
   FFDC 01 09              6250         .word  0x0109       ; PA Overflow
                           6251 
   FFDE F9 F6              6252         .word  DORTI        ; Stub RTI
                           6253 
   FFE0 01 0C              6254         .word  0x010c       ; TI4O5
   FFE2 01 0F              6255         .word  0x010f       ; TOC4
   FFE4 01 12              6256         .word  0x0112       ; TOC3
   FFE6 01 15              6257         .word  0x0115       ; TOC2
   FFE8 01 18              6258         .word  0x0118       ; TOC1
   FFEA 01 1B              6259         .word  0x011b       ; TIC3
   FFEC 01 1E              6260         .word  0x011e       ; TIC2
   FFEE 01 21              6261         .word  0x0121       ; TIC1
   FFF0 01 24              6262         .word  0x0124       ; RTI
   FFF2 01 27              6263         .word  0x0127       ; ~IRQ
   FFF4 01 2A              6264         .word  0x012a       ; XIRQ
   FFF6 01 2D              6265         .word  0x012d       ; SWI
   FFF8 01 30              6266         .word  0x0130       ; ILLEGAL OPCODE
   FFFA 01 33              6267         .word  0x0133       ; COP Failure
   FFFC 01 36              6268         .word  0x0136       ; COP Clock Monitor Fail
                           6269 
   FFFE F8 00              6270         .word  RESET        ; Reset
                           6271 
