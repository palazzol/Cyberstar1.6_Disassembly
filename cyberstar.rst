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
                             68 ;           .equ    0x0408          ; 0x29 (rts) for CPU test?
                             69 
                     040B    70 CPYRTCS     .equ    0x040B          ; 0x040B/0x040C - copyright message checksum
                             71 ;           .equ    0x040D-0x040E   ; some counter? (600/65000?)
                     040F    72 ERASEFLG    .equ    0x040F          ; 0 = normal boot, 1 = erasing EEPROM
                             73 ;           .equ    0x0410-0x0411   ; some counter
                             74 ;           .equ    0x0412-0x0413   ; some counter
                             75 ;           .equ    0x0414-0x0415   ; some counter
                             76 ;           .equ    0x0416-0x0417   ; some counter
                             77 ;           .equ    0x0418-0x0419   ; some counter
                             78 ;           .equ    0x041A-0x041B   ; some counter
                             79 
                             80 ;           .equ    0x0420-0x0421   ; some counter
                             81 ;           .equ    0x0422-0x0423   ; some counter
                             82 ;           .equ    0x0424-0x0425   ; some counter
                     0426    83 NUMBOOT     .equ    0x0426          ; 0x0426/0x0427
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
   8096 97 AC         [ 3]  162         staa    (0x00AC)        ; ???
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
   80C8 26 4F         [ 3]  182         bne     LOCKUP          ; bye bye
   80CA 5F            [ 2]  183         clrb
   80CB D7 62         [ 3]  184         stab    (0x0062)        ; button light buffer?
   80CD BD F9 C5      [ 6]  185         jsr     BUTNLIT         ; turn off all button lights
   80D0 BD A3 41      [ 6]  186         jsr     LA341           ; fire 3 bits on board 2
   80D3 B6 04 00      [ 4]  187         ldaa    (0x0400)
   80D6 81 07         [ 2]  188         cmpa    #0x07
   80D8 27 42         [ 3]  189         beq     L811C           ; go to CPU test?
   80DA 25 29         [ 3]  190         bcs     L8105           ; go to init setup for CPU test?
   80DC 81 06         [ 2]  191         cmpa    #0x06
   80DE 27 25         [ 3]  192         beq     L8105           ; go to init setup for CPU test?
   80E0 CC 00 00      [ 3]  193         ldd     #0x0000
   80E3 FD 04 0D      [ 5]  194         std     (0x040D)
   80E6 CC 00 C8      [ 3]  195         ldd     #0x00C8
   80E9 DD 1B         [ 4]  196         std     CDTIMR1
   80EB                     197 L80EB:
   80EB DC 1B         [ 4]  198         ldd     CDTIMR1
   80ED 27 0B         [ 3]  199         beq     L80FA
   80EF BD F9 45      [ 6]  200         jsr     SERIALR     
   80F2 24 F7         [ 3]  201         bcc     L80EB
   80F4 81 44         [ 2]  202         cmpa    #0x44           ; 'D'
   80F6 26 F3         [ 3]  203         bne     L80EB
   80F8 20 05         [ 3]  204         bra     L80FF
   80FA                     205 L80FA:
   80FA BD 9F 1E      [ 6]  206         jsr     L9F1E
   80FD 25 1A         [ 3]  207         bcs     LOCKUP          ; bye bye
   80FF                     208 L80FF:
   80FF BD 9E AF      [ 6]  209         jsr     L9EAF           ; reset L counts
   8102 BD 9E 92      [ 6]  210         jsr     L9E92           ; reset R counts
   8105                     211 L8105:
   8105 86 39         [ 2]  212         ldaa    #0x39
   8107 B7 04 08      [ 4]  213         staa    0x0408          ; rts here for later CPU test
   810A BD A1 D5      [ 6]  214         jsr     LA1D5
   810D BD AB 17      [ 6]  215         jsr     LAB17
   8110 B6 F7 C0      [ 4]  216         ldaa    LF7C0           ; a 00
   8113 B7 04 5C      [ 4]  217         staa    0x045C          ; ??? NVRAM
   8116 7E F8 00      [ 3]  218         jmp     RESET           ; reset!
                            219 
   8119 7E 81 19      [ 3]  220 LOCKUP: jmp     LOCKUP          ; infinite loop
                            221 
                            222 ; CPU test?
   811C                     223 L811C:
   811C 7F 00 79      [ 6]  224         clr     (0x0079)
   811F 7F 00 7C      [ 6]  225         clr     (0x007C)
   8122 BD 04 08      [ 6]  226         jsr     0x0408          ; rts should be here
   8125 BD 80 13      [ 6]  227         jsr     (0x8013)        ; rts is here '9'
   8128 C6 FD         [ 2]  228         ldab    #0xFD
   812A BD 86 E7      [ 6]  229         jsr     L86E7
   812D C6 DF         [ 2]  230         ldab    #0xDF
   812F BD 87 48      [ 6]  231         jsr     L8748   
   8132 BD 87 91      [ 6]  232         jsr     L8791   
   8135 BD 9A F7      [ 6]  233         jsr     L9AF7
   8138 BD 9C 51      [ 6]  234         jsr     L9C51
   813B 7F 00 62      [ 6]  235         clr     (0x0062)
   813E BD 99 D9      [ 6]  236         jsr     L99D9
   8141 24 16         [ 3]  237         bcc     L8159           ; if carry clear, test is passed
                            238 
   8143 BD 8D E4      [ 6]  239         jsr     LCDMSG1 
   8146 49 6E 76 61 6C 69   240         .ascis  'Invalid CPU!'
        64 20 43 50 55 A1
                            241 
   8152 86 53         [ 2]  242         ldaa    #0x53
   8154 7E 82 A4      [ 3]  243         jmp     L82A4
   8157 20 FE         [ 3]  244 L8157:  bra     L8157           ; infinite loop
                            245 
   8159                     246 L8159:
   8159 BD A3 54      [ 6]  247         jsr     LA354
   815C 7F 00 AA      [ 6]  248         clr     (0x00AA)
   815F 7D 00 00      [ 6]  249         tst     (0x0000)
   8162 27 15         [ 3]  250         beq     L8179
                            251 
   8164 BD 8D E4      [ 6]  252         jsr     LCDMSG1 
   8167 52 41 4D 20 74 65   253         .ascis  'RAM test failed!'
        73 74 20 66 61 69
        6C 65 64 A1
                            254 
   8177 20 44         [ 3]  255         bra     L81BD
                            256 
   8179                     257 L8179:
   8179 BD 8D E4      [ 6]  258         jsr     LCDMSG1 
   817C 33 32 4B 20 52 41   259         .ascis  '32K RAM OK'
        4D 20 4F CB
                            260 
                            261 ; R12 or CNR mode???
   8186 7D 04 5C      [ 6]  262         tst     (0x045C)        ; if this location is 0, good
   8189 26 08         [ 3]  263         bne     L8193
   818B CC 52 0F      [ 3]  264         ldd     #0x520F         ; else print 'R' on the far left of the first line
   818E BD 8D B5      [ 6]  265         jsr     L8DB5           ; display char here on LCD display
   8191 20 06         [ 3]  266         bra     L8199
   8193                     267 L8193:
   8193 CC 43 0F      [ 3]  268         ldd     #0x430F         ; print 'C' on the far left of the first line
   8196 BD 8D B5      [ 6]  269         jsr     L8DB5           ; display char here on LCD display
                            270 
   8199                     271 L8199:
   8199 BD 8D DD      [ 6]  272         jsr     LCDMSG2 
   819C 52 4F 4D 20 43 68   273         .ascis  'ROM Chksum='
        6B 73 75 6D BD
                            274 
   81A7 BD 97 5F      [ 6]  275         jsr     L975F           ; print the checksum on the LCD
                            276 
   81AA C6 02         [ 2]  277         ldab    #0x02           ; delay 2 secs
   81AC BD 8C 02      [ 6]  278         jsr     DLYSECS         ;
                            279 
   81AF BD 9A 27      [ 6]  280         jsr     L9A27           ; display Serial #
   81B2 BD 9E CC      [ 6]  281         jsr     L9ECC           ; display R and L counts?
   81B5 BD 9B 19      [ 6]  282         jsr     L9B19           ; do the random tasks???
                            283 
   81B8 C6 02         [ 2]  284         ldab    #0x02           ; delay 2 secs
   81BA BD 8C 02      [ 6]  285         jsr     DLYSECS         ;
                            286 
   81BD                     287 L81BD:
   81BD F6 10 2D      [ 4]  288         ldab    SCCR2           ; disable receive data interrupts
   81C0 C4 DF         [ 2]  289         andb    #0xDF
   81C2 F7 10 2D      [ 4]  290         stab    SCCR2  
                            291 
   81C5 BD 9A F7      [ 6]  292         jsr     L9AF7           ; clear a bunch of ram
   81C8 C6 FD         [ 2]  293         ldab    #0xFD
   81CA BD 86 E7      [ 6]  294         jsr     L86E7
   81CD BD 87 91      [ 6]  295         jsr     L8791   
                            296 
   81D0 C6 00         [ 2]  297         ldab    #0x00           ; turn off button lights
   81D2 D7 62         [ 3]  298         stab    (0x0062)
   81D4 BD F9 C5      [ 6]  299         jsr     BUTNLIT 
                            300 
   81D7                     301 L81D7:
   81D7 BD 8D E4      [ 6]  302         jsr     LCDMSG1 
   81DA 20 43 79 62 65 72   303         .ascis  ' Cyberstar v1.6'
        73 74 61 72 20 76
        31 2E B6
                            304 
   81E9 BD A2 DF      [ 6]  305         jsr     LA2DF
   81EC 24 11         [ 3]  306         bcc     L81FF
   81EE CC 52 0F      [ 3]  307         ldd     #0x520F
   81F1 BD 8D B5      [ 6]  308         jsr     L8DB5           ; display 'R' at far right of 1st line
   81F4 7D 04 2A      [ 6]  309         tst     (0x042A)
   81F7 27 06         [ 3]  310         beq     L81FF
   81F9 CC 4B 0F      [ 3]  311         ldd     #0x4B0F
   81FC BD 8D B5      [ 6]  312         jsr     L8DB5           ; display 'K' at far right of 1st line
   81FF                     313 L81FF:
   81FF BD 8D 03      [ 6]  314         jsr     L8D03
   8202 FC 02 9C      [ 5]  315         ldd     (0x029C)
   8205 1A 83 00 01   [ 5]  316         cpd     #0x0001
   8209 26 15         [ 3]  317         bne     L8220
                            318 
   820B BD 8D DD      [ 6]  319         jsr     LCDMSG2 
   820E 20 44 61 76 65 27   320         .ascis  " Dave's system  "
        73 20 73 79 73 74
        65 6D 20 A0
                            321 
   821E 20 47         [ 3]  322         bra     L8267
   8220                     323 L8220:
   8220 1A 83 03 E8   [ 5]  324         cpd     #0x03E8
   8224 2D 1B         [ 3]  325         blt     L8241
   8226 1A 83 04 4B   [ 5]  326         cpd     #0x044B
   822A 22 15         [ 3]  327         bhi     L8241
                            328 
   822C BD 8D DD      [ 6]  329         jsr     LCDMSG2 
   822F 20 20 20 53 50 54   330         .ascis  '   SPT Studio   '
        20 53 74 75 64 69
        6F 20 20 A0
                            331 
   823F 20 26         [ 3]  332         bra L8267
                            333 
   8241                     334 L8241:
   8241 CC 0E 0C      [ 3]  335         ldd     #0x0E0C
   8244 DD AD         [ 4]  336         std     (0x00AD)
   8246 FC 04 0D      [ 5]  337         ldd     (0x040D)
   8249 1A 83 02 58   [ 5]  338         cpd     #0x0258         ; 600?
   824D 22 05         [ 3]  339         bhi     L8254
   824F CC 0E 09      [ 3]  340         ldd     #0x0E09
   8252 DD AD         [ 4]  341         std     (0x00AD)
   8254                     342 L8254:
   8254 C6 29         [ 2]  343         ldab    #0x29
   8256 CE 0E 00      [ 3]  344         ldx     #0x0E00
   8259                     345 L8259:
   8259 A6 00         [ 4]  346         ldaa    0,X
   825B 4A            [ 2]  347         deca
   825C 08            [ 3]  348         inx
   825D 5C            [ 2]  349         incb
   825E 3C            [ 4]  350         pshx
   825F BD 8D B5      [ 6]  351         jsr     L8DB5           ; display char here on LCD display
   8262 38            [ 5]  352         pulx
   8263 9C AD         [ 5]  353         cpx     (0x00AD)
   8265 26 F2         [ 3]  354         bne     L8259
   8267                     355 L8267:
   8267 BD 9C 51      [ 6]  356         jsr     L9C51
   826A 7F 00 5B      [ 6]  357         clr     (0x005B)
   826D 7F 00 5A      [ 6]  358         clr     (0x005A)
   8270 7F 00 5E      [ 6]  359         clr     (0x005E)
   8273 7F 00 60      [ 6]  360         clr     (0x0060)
   8276 BD 9B 19      [ 6]  361         jsr     L9B19   
   8279 96 60         [ 3]  362         ldaa    (0x0060)
   827B 27 06         [ 3]  363         beq     L8283
   827D BD A9 7C      [ 6]  364         jsr     LA97C
   8280 7E F8 00      [ 3]  365         jmp     RESET       ; reset controller
   8283                     366 L8283:
   8283 B6 18 04      [ 4]  367         ldaa    PIA0PRA 
   8286 84 06         [ 2]  368         anda    #0x06
   8288 26 08         [ 3]  369         bne     L8292
   828A BD 9C F1      [ 6]  370         jsr     L9CF1       ; print credits
   828D C6 32         [ 2]  371         ldab    #0x32
   828F BD 8C 22      [ 6]  372         jsr     DLYSECSBY100       ; delay 0.5 sec
   8292                     373 L8292:
   8292 BD 8E 95      [ 6]  374         jsr     L8E95
   8295 81 0D         [ 2]  375         cmpa    #0x0D
   8297 26 03         [ 3]  376         bne     L829C
   8299 7E 92 92      [ 3]  377         jmp     L9292
   829C                     378 L829C:
   829C BD F9 45      [ 6]  379         jsr     SERIALR     
   829F 25 03         [ 3]  380         bcs     L82A4
   82A1                     381 L82A1:
   82A1 7E 83 33      [ 3]  382         jmp     L8333
   82A4                     383 L82A4:
   82A4 81 44         [ 2]  384         cmpa    #0x44       ;'$'
   82A6 26 03         [ 3]  385         bne     L82AB
   82A8 7E A3 66      [ 3]  386         jmp     LA366
   82AB                     387 L82AB:
   82AB 81 53         [ 2]  388         cmpa    #0x53       ;'S'
   82AD 26 F2         [ 3]  389         bne     L82A1
                            390 
   82AF BD F9 D8      [ 6]  391         jsr     SERMSGW      
   82B2 0A 0D 45 6E 74 65   392         .ascis  '\n\rEnter security code: '
        72 20 73 65 63 75
        72 69 74 79 20 63
        6F 64 65 3A A0
                            393 
   82C9 0F            [ 2]  394         sei
   82CA BD A2 EA      [ 6]  395         jsr     LA2EA
   82CD 0E            [ 2]  396         cli
   82CE 25 61         [ 3]  397         bcs     L8331
                            398 
   82D0 BD F9 D8      [ 6]  399         jsr     SERMSGW      
   82D3 0A 0D 45 45 50 52   400         .ascii '\n\rEEPROM serial number programming enabled.'
        4F 4D 20 73 65 72
        69 61 6C 20 6E 75
        6D 62 65 72 20 70
        72 6F 67 72 61 6D
        6D 69 6E 67 20 65
        6E 61 62 6C 65 64
        2E
   82FE 0A 0D 50 6C 65 61   401         .ascis '\n\rPlease RESET the processor to continue\n\r'
        73 65 20 52 45 53
        45 54 20 74 68 65
        20 70 72 6F 63 65
        73 73 6F 72 20 74
        6F 20 63 6F 6E 74
        69 6E 75 65 0A 8D
                            402 
   8328 86 01         [ 2]  403         ldaa    #0x01       ; enable EEPROM erase
   832A B7 04 0F      [ 4]  404         staa    ERASEFLG
   832D 86 DB         [ 2]  405         ldaa    #0xDB
   832F 97 07         [ 3]  406         staa    (0x0007)
                            407 ; need to reset to get out of this 
   8331 20 FE         [ 3]  408 L8331:  bra     L8331       ; infinite loop
                            409 
   8333                     410 L8333:
   8333 96 AA         [ 3]  411         ldaa    (0x00AA)
   8335 27 12         [ 3]  412         beq     L8349
   8337 DC 1B         [ 4]  413         ldd     CDTIMR1
   8339 26 0E         [ 3]  414         bne     L8349
   833B D6 62         [ 3]  415         ldab    (0x0062)
   833D C8 20         [ 2]  416         eorb    #0x20
   833F D7 62         [ 3]  417         stab    (0x0062)
   8341 BD F9 C5      [ 6]  418         jsr     BUTNLIT 
   8344 CC 00 32      [ 3]  419         ldd     #0x0032
   8347 DD 1B         [ 4]  420         std     CDTIMR1
   8349                     421 L8349:
   8349 BD 86 A4      [ 6]  422         jsr     L86A4
   834C 24 03         [ 3]  423         bcc     L8351
   834E 7E 82 76      [ 3]  424         jmp     (0x8276)
   8351                     425 L8351:
   8351 F6 10 2D      [ 4]  426         ldab    SCCR2  
   8354 CA 20         [ 2]  427         orab    #0x20
   8356 F7 10 2D      [ 4]  428         stab    SCCR2  
   8359 7F 00 AA      [ 6]  429         clr     (0x00AA)
   835C D6 62         [ 3]  430         ldab    (0x0062)
   835E C4 DF         [ 2]  431         andb    #0xDF
   8360 D7 62         [ 3]  432         stab    (0x0062)
   8362 BD F9 C5      [ 6]  433         jsr     BUTNLIT 
   8365 C6 02         [ 2]  434         ldab    #0x02           ; delay 2 secs
   8367 BD 8C 02      [ 6]  435         jsr     DLYSECS         ;
   836A 96 7C         [ 3]  436         ldaa    (0x007C)
   836C 27 2D         [ 3]  437         beq     L839B
   836E 96 7F         [ 3]  438         ldaa    (0x007F)
   8370 97 4E         [ 3]  439         staa    (0x004E)
   8372 D6 81         [ 3]  440         ldab    (0x0081)
   8374 BD 87 48      [ 6]  441         jsr     L8748   
   8377 96 82         [ 3]  442         ldaa    (0x0082)
   8379 85 01         [ 2]  443         bita    #0x01
   837B 26 06         [ 3]  444         bne     L8383
   837D 96 AC         [ 3]  445         ldaa    (0x00AC)
   837F 84 FD         [ 2]  446         anda    #0xFD
   8381 20 04         [ 3]  447         bra     L8387
   8383                     448 L8383:
   8383 96 AC         [ 3]  449         ldaa    (0x00AC)
   8385 8A 02         [ 2]  450         oraa    #0x02
   8387                     451 L8387:
   8387 97 AC         [ 3]  452         staa    (0x00AC)
   8389 B7 18 06      [ 4]  453         staa    PIA0PRB 
   838C B6 18 04      [ 4]  454         ldaa    PIA0PRA 
   838F 8A 20         [ 2]  455         oraa    #0x20
   8391 B7 18 04      [ 4]  456         staa    PIA0PRA 
   8394 84 DF         [ 2]  457         anda    #0xDF
   8396 B7 18 04      [ 4]  458         staa    PIA0PRA 
   8399 20 14         [ 3]  459         bra     L83AF
   839B                     460 L839B:
   839B FC 04 0D      [ 5]  461         ldd     (0x040D)
   839E 1A 83 FD E8   [ 5]  462         cpd     #0xFDE8         ; 65000?
   83A2 22 06         [ 3]  463         bhi     L83AA
   83A4 C3 00 01      [ 4]  464         addd    #0x0001
   83A7 FD 04 0D      [ 5]  465         std     (0x040D)
   83AA                     466 L83AA:
   83AA C6 F7         [ 2]  467         ldab    #0xF7
   83AC BD 86 E7      [ 6]  468         jsr     L86E7
   83AF                     469 L83AF:
   83AF 7F 00 30      [ 6]  470         clr     (0x0030)
   83B2 7F 00 31      [ 6]  471         clr     (0x0031)
   83B5 7F 00 32      [ 6]  472         clr     (0x0032)
   83B8 BD 9B 19      [ 6]  473         jsr     L9B19   
   83BB BD 86 A4      [ 6]  474         jsr     L86A4
   83BE 25 EF         [ 3]  475         bcs     L83AF
   83C0 96 79         [ 3]  476         ldaa    (0x0079)
   83C2 27 17         [ 3]  477         beq     L83DB
   83C4 7F 00 79      [ 6]  478         clr     (0x0079)
   83C7 96 B5         [ 3]  479         ldaa    (0x00B5)
   83C9 81 01         [ 2]  480         cmpa    #0x01
   83CB 26 07         [ 3]  481         bne     L83D4
   83CD 7F 00 B5      [ 6]  482         clr     (0x00B5)
   83D0 86 01         [ 2]  483         ldaa    #0x01
   83D2 97 7C         [ 3]  484         staa    (0x007C)
   83D4                     485 L83D4:
   83D4 86 01         [ 2]  486         ldaa    #0x01
   83D6 97 AA         [ 3]  487         staa    (0x00AA)
   83D8 7E 9A 7F      [ 3]  488         jmp     L9A7F
   83DB                     489 L83DB:
   83DB BD 8D E4      [ 6]  490         jsr     LCDMSG1 
   83DE 20 20 20 54 61 70   491         .ascis  '   Tape start   '
        65 20 73 74 61 72
        74 20 20 A0
                            492 
   83EE D6 62         [ 3]  493         ldab    (0x0062)
   83F0 CA 80         [ 2]  494         orab    #0x80
   83F2 D7 62         [ 3]  495         stab    (0x0062)
   83F4 BD F9 C5      [ 6]  496         jsr     BUTNLIT 
   83F7 C6 FB         [ 2]  497         ldab    #0xFB
   83F9 BD 86 E7      [ 6]  498         jsr     L86E7
                            499 
   83FC BD 8D CF      [ 6]  500         jsr     LCDMSG1A
   83FF 36 38 48 43 31 31   501         .ascis  '68HC11 Proto'
        20 50 72 6F 74 EF
                            502 
   840B BD 8D D6      [ 6]  503         jsr     LCDMSG2A
   840E 64 62 F0            504         .ascis  'dbp'
                            505 
   8411 C6 03         [ 2]  506         ldab    #0x03           ; delay 3 secs
   8413 BD 8C 02      [ 6]  507         jsr     DLYSECS         ;
   8416 7D 00 7C      [ 6]  508         tst     (0x007C)
   8419 27 15         [ 3]  509         beq     L8430
   841B D6 80         [ 3]  510         ldab    (0x0080)
   841D D7 62         [ 3]  511         stab    (0x0062)
   841F BD F9 C5      [ 6]  512         jsr     BUTNLIT 
   8422 D6 7D         [ 3]  513         ldab    (0x007D)
   8424 D7 78         [ 3]  514         stab    (0x0078)
   8426 D6 7E         [ 3]  515         ldab    (0x007E)
   8428 F7 10 8A      [ 4]  516         stab    (0x108A)
   842B 7F 00 7C      [ 6]  517         clr     (0x007C)
   842E 20 1D         [ 3]  518         bra     L844D
   8430                     519 L8430:
   8430 BD 8D 03      [ 6]  520         jsr     L8D03
   8433 BD 9D 18      [ 6]  521         jsr     L9D18
   8436 24 08         [ 3]  522         bcc     L8440
   8438 7D 00 B8      [ 6]  523         tst     (0x00B8)
   843B 27 F3         [ 3]  524         beq     L8430
   843D 7E 9A 60      [ 3]  525         jmp     L9A60
   8440                     526 L8440:
   8440 7D 00 B8      [ 6]  527         tst     (0x00B8)
   8443 27 EB         [ 3]  528         beq     L8430
   8445 7F 00 30      [ 6]  529         clr     (0x0030)
   8448 7F 00 31      [ 6]  530         clr     (0x0031)
   844B 20 00         [ 3]  531         bra     L844D
   844D                     532 L844D:
   844D 96 49         [ 3]  533         ldaa    (0x0049)
   844F 26 03         [ 3]  534         bne     L8454
   8451 7E 85 A4      [ 3]  535         jmp     L85A4
   8454                     536 L8454:
   8454 7F 00 49      [ 6]  537         clr     (0x0049)
   8457 81 31         [ 2]  538         cmpa    #0x31
   8459 26 08         [ 3]  539         bne     L8463
   845B BD A3 26      [ 6]  540         jsr     LA326
   845E BD 8D 42      [ 6]  541         jsr     L8D42
   8461 20 EA         [ 3]  542         bra     L844D
   8463                     543 L8463:
   8463 81 32         [ 2]  544         cmpa    #0x32
   8465 26 08         [ 3]  545         bne     L846F
   8467 BD A3 26      [ 6]  546         jsr     LA326
   846A BD 8D 35      [ 6]  547         jsr     L8D35
   846D 20 DE         [ 3]  548         bra     L844D
   846F                     549 L846F:
   846F 81 54         [ 2]  550         cmpa    #0x54
   8471 26 08         [ 3]  551         bne     L847B
   8473 BD A3 26      [ 6]  552         jsr     LA326
   8476 BD 8D 42      [ 6]  553         jsr     L8D42
   8479 20 D2         [ 3]  554         bra     L844D
   847B                     555 L847B:
   847B 81 5A         [ 2]  556         cmpa    #0x5A
   847D 26 1C         [ 3]  557         bne     L849B
   847F                     558 L847F:
   847F BD A3 1E      [ 6]  559         jsr     LA31E
   8482 BD 8E 95      [ 6]  560         jsr     L8E95
   8485 7F 00 32      [ 6]  561         clr     (0x0032)
   8488 7F 00 31      [ 6]  562         clr     (0x0031)
   848B 7F 00 30      [ 6]  563         clr     (0x0030)
   848E BD 99 A6      [ 6]  564         jsr     L99A6
   8491 D6 7B         [ 3]  565         ldab    (0x007B)
   8493 CA 0C         [ 2]  566         orab    #0x0C
   8495 BD 87 48      [ 6]  567         jsr     L8748   
   8498 7E 81 BD      [ 3]  568         jmp     L81BD
   849B                     569 L849B:
   849B 81 42         [ 2]  570         cmpa    #0x42
   849D 26 03         [ 3]  571         bne     L84A2
   849F 7E 98 3C      [ 3]  572         jmp     L983C
   84A2                     573 L84A2:
   84A2 81 4D         [ 2]  574         cmpa    #0x4D
   84A4 26 03         [ 3]  575         bne     L84A9
   84A6 7E 98 24      [ 3]  576         jmp     L9824
   84A9                     577 L84A9:
   84A9 81 45         [ 2]  578         cmpa    #0x45
   84AB 26 03         [ 3]  579         bne     L84B0
   84AD 7E 98 02      [ 3]  580         jmp     L9802
   84B0                     581 L84B0:
   84B0 81 58         [ 2]  582         cmpa    #0x58
   84B2 26 05         [ 3]  583         bne     L84B9
   84B4 7E 99 3F      [ 3]  584         jmp     L993F
   84B7 20 94         [ 3]  585         bra     L844D
   84B9                     586 L84B9:
   84B9 81 46         [ 2]  587         cmpa    #0x46
   84BB 26 03         [ 3]  588         bne     L84C0
   84BD 7E 99 71      [ 3]  589         jmp     L9971
   84C0                     590 L84C0:
   84C0 81 47         [ 2]  591         cmpa    #0x47
   84C2 26 03         [ 3]  592         bne     L84C7
   84C4 7E 99 7B      [ 3]  593         jmp     L997B
   84C7                     594 L84C7:
   84C7 81 48         [ 2]  595         cmpa    #0x48
   84C9 26 03         [ 3]  596         bne     L84CE
   84CB 7E 99 85      [ 3]  597         jmp     L9985
   84CE                     598 L84CE:
   84CE 81 49         [ 2]  599         cmpa    #0x49
   84D0 26 03         [ 3]  600         bne     L84D5
   84D2 7E 99 8F      [ 3]  601         jmp     L998F
   84D5                     602 L84D5:
   84D5 81 53         [ 2]  603         cmpa    #0x53
   84D7 26 03         [ 3]  604         bne     L84DC
   84D9 7E 97 BA      [ 3]  605         jmp     L97BA
   84DC                     606 L84DC:
   84DC 81 59         [ 2]  607         cmpa    #0x59
   84DE 26 03         [ 3]  608         bne     L84E3
   84E0 7E 99 D2      [ 3]  609         jmp     L99D2
   84E3                     610 L84E3:
   84E3 81 57         [ 2]  611         cmpa    #0x57
   84E5 26 03         [ 3]  612         bne     L84EA
   84E7 7E 9A A4      [ 3]  613         jmp     L9AA4
   84EA                     614 L84EA:
   84EA 81 41         [ 2]  615         cmpa    #0x41
   84EC 26 17         [ 3]  616         bne     L8505
   84EE BD 9D 18      [ 6]  617         jsr     L9D18
   84F1 25 09         [ 3]  618         bcs     L84FC
   84F3 7F 00 30      [ 6]  619         clr     (0x0030)
   84F6 7F 00 31      [ 6]  620         clr     (0x0031)
   84F9 7E 85 A4      [ 3]  621         jmp     L85A4
   84FC                     622 L84FC:
   84FC 7F 00 30      [ 6]  623         clr     (0x0030)
   84FF 7F 00 31      [ 6]  624         clr     (0x0031)
   8502 7E 9A 7F      [ 3]  625         jmp     L9A7F
   8505                     626 L8505:
   8505 81 4B         [ 2]  627         cmpa    #0x4B
   8507 26 0B         [ 3]  628         bne     L8514
   8509 BD 9D 18      [ 6]  629         jsr     L9D18
   850C 25 03         [ 3]  630         bcs     L8511
   850E 7E 85 A4      [ 3]  631         jmp     L85A4
   8511                     632 L8511:
   8511 7E 9A 7F      [ 3]  633         jmp     L9A7F
   8514                     634 L8514:
   8514 81 4A         [ 2]  635         cmpa    #0x4A
   8516 26 07         [ 3]  636         bne     L851F
   8518 86 01         [ 2]  637         ldaa    #0x01
   851A 97 AF         [ 3]  638         staa    (0x00AF)
   851C 7E 98 3C      [ 3]  639         jmp     L983C
   851F                     640 L851F:
   851F 81 4E         [ 2]  641         cmpa    #0x4E
   8521 26 0B         [ 3]  642         bne     L852E
   8523 B6 10 8A      [ 4]  643         ldaa    (0x108A)
   8526 8A 02         [ 2]  644         oraa    #0x02
   8528 B7 10 8A      [ 4]  645         staa    (0x108A)
   852B 7E 84 4D      [ 3]  646         jmp     L844D
   852E                     647 L852E:
   852E 81 4F         [ 2]  648         cmpa    #0x4F
   8530 26 06         [ 3]  649         bne     L8538
   8532 BD 9D 18      [ 6]  650         jsr     L9D18
   8535 7E 84 4D      [ 3]  651         jmp     L844D
   8538                     652 L8538:
   8538 81 50         [ 2]  653         cmpa    #0x50
   853A 26 06         [ 3]  654         bne     L8542
   853C BD 9D 18      [ 6]  655         jsr     L9D18
   853F 7E 84 4D      [ 3]  656         jmp     L844D
   8542                     657 L8542:
   8542 81 51         [ 2]  658         cmpa    #0x51
   8544 26 0B         [ 3]  659         bne     L8551
   8546 B6 10 8A      [ 4]  660         ldaa    (0x108A)
   8549 8A 04         [ 2]  661         oraa    #0x04
   854B B7 10 8A      [ 4]  662         staa    (0x108A)
   854E 7E 84 4D      [ 3]  663         jmp     L844D
   8551                     664 L8551:
   8551 81 55         [ 2]  665         cmpa    #0x55
   8553 26 07         [ 3]  666         bne     L855C
   8555 C6 01         [ 2]  667         ldab    #0x01
   8557 D7 B6         [ 3]  668         stab    (0x00B6)
   8559 7E 84 4D      [ 3]  669         jmp     L844D
   855C                     670 L855C:
   855C 81 4C         [ 2]  671         cmpa    #0x4C
   855E 26 19         [ 3]  672         bne     L8579
   8560 7F 00 49      [ 6]  673         clr     (0x0049)
   8563 BD 9D 18      [ 6]  674         jsr     L9D18
   8566 25 0E         [ 3]  675         bcs     L8576
   8568 BD AA E8      [ 6]  676         jsr     LAAE8
   856B BD AB 56      [ 6]  677         jsr     LAB56
   856E 24 06         [ 3]  678         bcc     L8576
   8570 BD AB 25      [ 6]  679         jsr     LAB25
   8573 BD AB 46      [ 6]  680         jsr     LAB46
   8576                     681 L8576:
   8576 7E 84 4D      [ 3]  682         jmp     L844D
   8579                     683 L8579:
   8579 81 52         [ 2]  684         cmpa    #0x52
   857B 26 1A         [ 3]  685         bne     L8597
   857D 7F 00 49      [ 6]  686         clr     (0x0049)
   8580 BD 9D 18      [ 6]  687         jsr     L9D18
   8583 25 0F         [ 3]  688         bcs     L8594
   8585 BD AA E8      [ 6]  689         jsr     LAAE8
   8588 BD AB 56      [ 6]  690         jsr     LAB56
   858B 25 07         [ 3]  691         bcs     L8594
   858D 86 FF         [ 2]  692         ldaa    #0xFF
   858F A7 00         [ 4]  693         staa    0,X
   8591 BD AA E8      [ 6]  694         jsr     LAAE8
   8594                     695 L8594:
   8594 7E 84 4D      [ 3]  696         jmp     L844D
   8597                     697 L8597:
   8597 81 44         [ 2]  698         cmpa    #0x44
   8599 26 09         [ 3]  699         bne     L85A4
   859B 7F 00 49      [ 6]  700         clr     (0x0049)
   859E BD AB AE      [ 6]  701         jsr     LABAE
   85A1 7E 84 4D      [ 3]  702         jmp     L844D
   85A4                     703 L85A4:
   85A4 7D 00 75      [ 6]  704         tst     (0x0075)
   85A7 26 56         [ 3]  705         bne     L85FF
   85A9 7D 00 79      [ 6]  706         tst     (0x0079)
   85AC 26 51         [ 3]  707         bne     L85FF
   85AE 7D 00 30      [ 6]  708         tst     (0x0030)
   85B1 26 07         [ 3]  709         bne     L85BA
   85B3 96 5B         [ 3]  710         ldaa    (0x005B)
   85B5 27 48         [ 3]  711         beq     L85FF
   85B7 7F 00 5B      [ 6]  712         clr     (0x005B)
   85BA                     713 L85BA:
   85BA CC 00 64      [ 3]  714         ldd     #0x0064
   85BD DD 23         [ 4]  715         std     CDTIMR5
   85BF                     716 L85BF:
   85BF DC 23         [ 4]  717         ldd     CDTIMR5
   85C1 27 14         [ 3]  718         beq     L85D7
   85C3 BD 9B 19      [ 6]  719         jsr     L9B19   
   85C6 B6 18 04      [ 4]  720         ldaa    PIA0PRA 
   85C9 88 FF         [ 2]  721         eora    #0xFF
   85CB 84 06         [ 2]  722         anda    #0x06
   85CD 81 06         [ 2]  723         cmpa    #0x06
   85CF 26 EE         [ 3]  724         bne     L85BF
   85D1 7F 00 30      [ 6]  725         clr     (0x0030)
   85D4 7E 86 80      [ 3]  726         jmp     L8680
   85D7                     727 L85D7:
   85D7 7F 00 30      [ 6]  728         clr     (0x0030)
   85DA D6 62         [ 3]  729         ldab    (0x0062)
   85DC C8 02         [ 2]  730         eorb    #0x02
   85DE D7 62         [ 3]  731         stab    (0x0062)
   85E0 BD F9 C5      [ 6]  732         jsr     BUTNLIT 
   85E3 C4 02         [ 2]  733         andb    #0x02
   85E5 27 0D         [ 3]  734         beq     L85F4
   85E7 BD AA 18      [ 6]  735         jsr     LAA18
   85EA C6 1E         [ 2]  736         ldab    #0x1E
   85EC BD 8C 22      [ 6]  737         jsr     DLYSECSBY100           ; delay 0.3 sec
   85EF 7F 00 30      [ 6]  738         clr     (0x0030)
   85F2 20 0B         [ 3]  739         bra     L85FF
   85F4                     740 L85F4:
   85F4 BD AA 1D      [ 6]  741         jsr     LAA1D
   85F7 C6 1E         [ 2]  742         ldab    #0x1E
   85F9 BD 8C 22      [ 6]  743         jsr     DLYSECSBY100           ; delay 0.3 sec
   85FC 7F 00 30      [ 6]  744         clr     (0x0030)
   85FF                     745 L85FF:
   85FF BD 9B 19      [ 6]  746         jsr     L9B19   
   8602 B6 10 0A      [ 4]  747         ldaa    PORTE
   8605 84 10         [ 2]  748         anda    #0x10
   8607 27 0B         [ 3]  749         beq     L8614
   8609 B6 18 04      [ 4]  750         ldaa    PIA0PRA 
   860C 88 FF         [ 2]  751         eora    #0xFF
   860E 84 07         [ 2]  752         anda    #0x07
   8610 81 06         [ 2]  753         cmpa    #0x06
   8612 26 1C         [ 3]  754         bne     L8630
   8614                     755 L8614:
   8614 7D 00 76      [ 6]  756         tst     (0x0076)
   8617 26 17         [ 3]  757         bne     L8630
   8619 7D 00 75      [ 6]  758         tst     (0x0075)
   861C 26 12         [ 3]  759         bne     L8630
   861E D6 62         [ 3]  760         ldab    (0x0062)
   8620 C4 FC         [ 2]  761         andb    #0xFC
   8622 D7 62         [ 3]  762         stab    (0x0062)
   8624 BD F9 C5      [ 6]  763         jsr     BUTNLIT 
   8627 BD AA 13      [ 6]  764         jsr     LAA13
   862A BD AA 1D      [ 6]  765         jsr     LAA1D
   862D 7E 9A 60      [ 3]  766         jmp     L9A60
   8630                     767 L8630:
   8630 7D 00 31      [ 6]  768         tst     (0x0031)
   8633 26 07         [ 3]  769         bne     L863C
   8635 96 5A         [ 3]  770         ldaa    (0x005A)
   8637 27 47         [ 3]  771         beq     L8680
   8639 7F 00 5A      [ 6]  772         clr     (0x005A)
   863C                     773 L863C:
   863C CC 00 64      [ 3]  774         ldd     #0x0064
   863F DD 23         [ 4]  775         std     CDTIMR5
   8641                     776 L8641:
   8641 DC 23         [ 4]  777         ldd     CDTIMR5
   8643 27 13         [ 3]  778         beq     L8658
   8645 BD 9B 19      [ 6]  779         jsr     L9B19   
   8648 B6 18 04      [ 4]  780         ldaa    PIA0PRA 
   864B 88 FF         [ 2]  781         eora    #0xFF
   864D 84 06         [ 2]  782         anda    #0x06
   864F 81 06         [ 2]  783         cmpa    #0x06
   8651 26 EE         [ 3]  784         bne     L8641
   8653 7F 00 31      [ 6]  785         clr     (0x0031)
   8656 20 28         [ 3]  786         bra     L8680
   8658                     787 L8658:
   8658 7F 00 31      [ 6]  788         clr     (0x0031)
   865B D6 62         [ 3]  789         ldab    (0x0062)
   865D C8 01         [ 2]  790         eorb    #0x01
   865F D7 62         [ 3]  791         stab    (0x0062)
   8661 BD F9 C5      [ 6]  792         jsr     BUTNLIT 
   8664 C4 01         [ 2]  793         andb    #0x01
   8666 27 0D         [ 3]  794         beq     L8675
   8668 BD AA 0C      [ 6]  795         jsr     LAA0C
   866B C6 1E         [ 2]  796         ldab    #0x1E
   866D BD 8C 22      [ 6]  797         jsr     DLYSECSBY100           ; delay 0.3 sec
   8670 7F 00 31      [ 6]  798         clr     (0x0031)
   8673 20 0B         [ 3]  799         bra     L8680
   8675                     800 L8675:
   8675 BD AA 13      [ 6]  801         jsr     LAA13
   8678 C6 1E         [ 2]  802         ldab    #0x1E
   867A BD 8C 22      [ 6]  803         jsr     DLYSECSBY100           ; delay 0.3 sec
   867D 7F 00 31      [ 6]  804         clr     (0x0031)
   8680                     805 L8680:
   8680 BD 86 A4      [ 6]  806         jsr     L86A4
   8683 25 1C         [ 3]  807         bcs     L86A1
   8685 7F 00 4E      [ 6]  808         clr     (0x004E)
   8688 BD 99 A6      [ 6]  809         jsr     L99A6
   868B BD 86 C4      [ 6]  810         jsr     L86C4           ; Reset boards 1-10
   868E 5F            [ 2]  811         clrb
   868F D7 62         [ 3]  812         stab    (0x0062)
   8691 BD F9 C5      [ 6]  813         jsr     BUTNLIT 
   8694 C6 FD         [ 2]  814         ldab    #0xFD
   8696 BD 86 E7      [ 6]  815         jsr     L86E7
   8699 C6 04         [ 2]  816         ldab    #0x04           ; delay 4 secs
   869B BD 8C 02      [ 6]  817         jsr     DLYSECS         ;
   869E 7E 84 7F      [ 3]  818         jmp     L847F
   86A1                     819 L86A1:
   86A1 7E 84 4D      [ 3]  820         jmp     L844D
   86A4                     821 L86A4:
   86A4 BD 9B 19      [ 6]  822         jsr     L9B19   
   86A7 7F 00 23      [ 6]  823         clr     CDTIMR5
   86AA 86 19         [ 2]  824         ldaa    #0x19
   86AC 97 24         [ 3]  825         staa    CDTIMR5+1
   86AE B6 10 0A      [ 4]  826         ldaa    PORTE
   86B1 84 80         [ 2]  827         anda    #0x80
   86B3 27 02         [ 3]  828         beq     L86B7
   86B5                     829 L86B5:
   86B5 0D            [ 2]  830         sec
   86B6 39            [ 5]  831         rts
                            832 
   86B7                     833 L86B7:
   86B7 B6 10 0A      [ 4]  834         ldaa    PORTE
   86BA 84 80         [ 2]  835         anda    #0x80
   86BC 26 F7         [ 3]  836         bne     L86B5
   86BE 96 24         [ 3]  837         ldaa    CDTIMR5+1
   86C0 26 F5         [ 3]  838         bne     L86B7
   86C2 0C            [ 2]  839         clc
   86C3 39            [ 5]  840         rts
                            841 
                            842 ; Reset boards 1-10 at:
                            843 ;         0x1080, 0x1084, 0x1088, 0x108c
                            844 ;         0x1090, 0x1094, 0x1098, 0x109c
                            845 ;         0x10a0, 0x10a4
                            846 
   86C4                     847 L86C4:
   86C4 CE 10 80      [ 3]  848         ldx     #0x1080
   86C7                     849 L86C7:
   86C7 86 30         [ 2]  850         ldaa    #0x30
   86C9 A7 01         [ 4]  851         staa    1,X         ; 0x30 -> PIAxCRA, CA2 low, DDR
   86CB A7 03         [ 4]  852         staa    3,X         ; 0x30 -> PIAxCRB, CB2 low, DDR
   86CD 86 FF         [ 2]  853         ldaa    #0xFF
   86CF A7 00         [ 4]  854         staa    0,X         ; 0xFF -> PIAxDDRA, all outputs
   86D1 A7 02         [ 4]  855         staa    2,X         ; 0xFF -> PIAxDDRB, all outputs
   86D3 86 34         [ 2]  856         ldaa    #0x34
   86D5 A7 01         [ 4]  857         staa    1,X         ; 0x34 -> PIAxCRA, CA2 low, PR
   86D7 A7 03         [ 4]  858         staa    3,X         ; 0x34 -> PIAxCRB, CA2 low, PR
   86D9 6F 00         [ 6]  859         clr     0,X         ; 0x00 -> PIAxPRA, all outputs low
   86DB 6F 02         [ 6]  860         clr     2,X         ; 0x00 -> PIAxPRB, all outputs low
   86DD 08            [ 3]  861         inx
   86DE 08            [ 3]  862         inx
   86DF 08            [ 3]  863         inx
   86E0 08            [ 3]  864         inx
   86E1 8C 10 A4      [ 4]  865         cpx     #0x10A4
   86E4 2F E1         [ 3]  866         ble     L86C7
   86E6 39            [ 5]  867         rts
                            868 
                            869 ; *** Should look at this
   86E7                     870 L86E7:
   86E7 36            [ 3]  871         psha
   86E8 BD 9B 19      [ 6]  872         jsr     L9B19   
   86EB 96 AC         [ 3]  873         ldaa    (0x00AC)
   86ED C1 FB         [ 2]  874         cmpb    #0xFB
   86EF 26 04         [ 3]  875         bne     L86F5
   86F1 84 FE         [ 2]  876         anda    #0xFE
   86F3 20 0E         [ 3]  877         bra     L8703
   86F5                     878 L86F5:
   86F5 C1 F7         [ 2]  879         cmpb    #0xF7
   86F7 26 04         [ 3]  880         bne     L86FD
   86F9 84 BF         [ 2]  881         anda    #0xBF
   86FB 20 06         [ 3]  882         bra     L8703
   86FD                     883 L86FD:
   86FD C1 FD         [ 2]  884         cmpb    #0xFD
   86FF 26 02         [ 3]  885         bne     L8703
   8701 84 F7         [ 2]  886         anda    #0xF7
   8703                     887 L8703:
   8703 97 AC         [ 3]  888         staa    (0x00AC)
   8705 B7 18 06      [ 4]  889         staa    PIA0PRB 
   8708 BD 87 3A      [ 6]  890         jsr     L873A        ; clock diagnostic indicator
   870B 96 7A         [ 3]  891         ldaa    (0x007A)
   870D 84 01         [ 2]  892         anda    #0x01
   870F 97 7A         [ 3]  893         staa    (0x007A)
   8711 C4 FE         [ 2]  894         andb    #0xFE
   8713 DA 7A         [ 3]  895         orab    (0x007A)
   8715 F7 18 06      [ 4]  896         stab    PIA0PRB 
   8718 BD 87 75      [ 6]  897         jsr     L8775   
   871B C6 32         [ 2]  898         ldab    #0x32
   871D BD 8C 22      [ 6]  899         jsr     DLYSECSBY100       ; delay 0.5 sec
   8720 C6 FE         [ 2]  900         ldab    #0xFE
   8722 DA 7A         [ 3]  901         orab    (0x007A)
   8724 F7 18 06      [ 4]  902         stab    PIA0PRB 
   8727 D7 7A         [ 3]  903         stab    (0x007A)
   8729 BD 87 75      [ 6]  904         jsr     L8775   
   872C 96 AC         [ 3]  905         ldaa    (0x00AC)
   872E 8A 49         [ 2]  906         oraa    #0x49
   8730 97 AC         [ 3]  907         staa    (0x00AC)
   8732 B7 18 06      [ 4]  908         staa    PIA0PRB 
   8735 BD 87 3A      [ 6]  909         jsr     L873A        ; clock diagnostic indicator
   8738 32            [ 4]  910         pula
   8739 39            [ 5]  911         rts
                            912 
                            913 ; clock diagnostic indicator
   873A                     914 L873A:
   873A B6 18 04      [ 4]  915         ldaa    PIA0PRA 
   873D 8A 20         [ 2]  916         oraa    #0x20
   873F B7 18 04      [ 4]  917         staa    PIA0PRA 
   8742 84 DF         [ 2]  918         anda    #0xDF
   8744 B7 18 04      [ 4]  919         staa    PIA0PRA 
   8747 39            [ 5]  920         rts
                            921 
   8748                     922 L8748:
   8748 36            [ 3]  923         psha
   8749 37            [ 3]  924         pshb
   874A 96 AC         [ 3]  925         ldaa    (0x00AC)        ; update state machine at AC?
                            926                                 ;      gfedcba
   874C 8A 30         [ 2]  927         oraa    #0x30           ; set bb11bbbb
   874E 84 FD         [ 2]  928         anda    #0xFD           ; clr bb11bb0b
   8750 C5 20         [ 2]  929         bitb    #0x20           ; tst bit 5 (f)
   8752 26 02         [ 3]  930         bne     L8756           ; 
   8754 8A 02         [ 2]  931         oraa    #0x02           ; set bit 1 (b)
   8756                     932 L8756:
   8756 C5 04         [ 2]  933         bitb    #0x04           ; tst bit 2 (c)
   8758 26 02         [ 3]  934         bne     L875C
   875A 84 EF         [ 2]  935         anda    #0xEF           ; clr bit 4 (e)
   875C                     936 L875C:
   875C C5 08         [ 2]  937         bitb    #0x08           ; tst bit 3 (d)
   875E 26 02         [ 3]  938         bne     L8762
   8760 84 DF         [ 2]  939         anda    #0xDF           ; clr bit 5 (f)
   8762                     940 L8762:
   8762 B7 18 06      [ 4]  941         staa    PIA0PRB 
   8765 97 AC         [ 3]  942         staa    (0x00AC)
   8767 BD 87 3A      [ 6]  943         jsr     L873A           ; clock diagnostic indicator
   876A 33            [ 4]  944         pulb
   876B F7 18 06      [ 4]  945         stab    PIA0PRB 
   876E D7 7B         [ 3]  946         stab    (0x007B)
   8770 BD 87 83      [ 6]  947         jsr     L8783
   8773 32            [ 4]  948         pula
   8774 39            [ 5]  949         rts
                            950 
   8775                     951 L8775:
   8775 B6 18 07      [ 4]  952         ldaa    PIA0CRB 
   8778 8A 38         [ 2]  953         oraa    #0x38       ; bits 3-4-5 on
   877A B7 18 07      [ 4]  954         staa    PIA0CRB 
   877D 84 F7         [ 2]  955         anda    #0xF7       ; bit 3 off
   877F B7 18 07      [ 4]  956         staa    PIA0CRB 
   8782 39            [ 5]  957         rts
                            958 
   8783                     959 L8783:
   8783 B6 18 05      [ 4]  960         ldaa    PIA0CRA 
   8786 8A 38         [ 2]  961         oraa    #0x38       ; bits 3-4-5 on
   8788 B7 18 05      [ 4]  962         staa    PIA0CRA 
   878B 84 F7         [ 2]  963         anda    #0xF7       ; bit 3 off
   878D B7 18 05      [ 4]  964         staa    PIA0CRA 
   8790 39            [ 5]  965         rts
                            966 
   8791                     967 L8791:
   8791 96 7A         [ 3]  968         ldaa    (0x007A)
   8793 84 FE         [ 2]  969         anda    #0xFE
   8795 36            [ 3]  970         psha
   8796 96 AC         [ 3]  971         ldaa    (0x00AC)
   8798 8A 04         [ 2]  972         oraa    #0x04
   879A 97 AC         [ 3]  973         staa    (0x00AC)
   879C 32            [ 4]  974         pula
   879D                     975 L879D:
   879D 97 7A         [ 3]  976         staa    (0x007A)
   879F B7 18 06      [ 4]  977         staa    PIA0PRB 
   87A2 BD 87 75      [ 6]  978         jsr     L8775
   87A5 96 AC         [ 3]  979         ldaa    (0x00AC)
   87A7 B7 18 06      [ 4]  980         staa    PIA0PRB 
   87AA BD 87 3A      [ 6]  981         jsr     L873A           ; clock diagnostic indicator
   87AD 39            [ 5]  982         rts
                            983 
   87AE                     984 L87AE:
   87AE 96 7A         [ 3]  985         ldaa    (0x007A)
   87B0 8A 01         [ 2]  986         oraa    #0x01
   87B2 36            [ 3]  987         psha
   87B3 96 AC         [ 3]  988         ldaa    (0x00AC)
   87B5 84 FB         [ 2]  989         anda    #0xFB
   87B7 97 AC         [ 3]  990         staa    (0x00AC)
   87B9 32            [ 4]  991         pula
   87BA 20 E1         [ 3]  992         bra     L879D
                            993 
   87BC                     994 L87BC:
   87BC CE 87 D2      [ 3]  995         ldx     #L87D2
   87BF                     996 L87BF:
   87BF A6 00         [ 4]  997         ldaa    0,X
   87C1 81 FF         [ 2]  998         cmpa    #0xFF
   87C3 27 0C         [ 3]  999         beq     L87D1
   87C5 08            [ 3] 1000         inx
   87C6 B7 18 0D      [ 4] 1001         staa    SCCCTRLB
   87C9 A6 00         [ 4] 1002         ldaa    0,X
   87CB 08            [ 3] 1003         inx
   87CC B7 18 0D      [ 4] 1004         staa    SCCCTRLB
   87CF 20 EE         [ 3] 1005         bra     L87BF
   87D1                    1006 L87D1:
   87D1 39            [ 5] 1007         rts
                           1008 
                           1009 ; data table, sync data init
   87D2                    1010 L87D2:
   87D2 09 8A              1011         .byte   0x09,0x8a
   87D4 01 00              1012         .byte   0x01,0x00
   87D6 0C 18              1013         .byte   0x0c,0x18 
   87D8 0D 00              1014         .byte   0x0d,0x00
   87DA 04 44              1015         .byte   0x04,0x44
   87DC 0E 63              1016         .byte   0x0e,0x63
   87DE 05 68              1017         .byte   0x05,0x68
   87E0 0B 56              1018         .byte   0x0b,0x56
   87E2 03 C1              1019         .byte   0x03,0xc1
   87E4 0F 00              1020         .byte   0x0f,0x00
   87E6 FF FF              1021         .byte   0xff,0xff
                           1022 
                           1023 ; SCC init, aux serial
   87E8                    1024 L87E8:
   87E8 CE F8 57      [ 3] 1025         ldx     #LF857
   87EB                    1026 L87EB:
   87EB A6 00         [ 4] 1027         ldaa    0,X
   87ED 81 FF         [ 2] 1028         cmpa    #0xFF
   87EF 27 0C         [ 3] 1029         beq     L87FD
   87F1 08            [ 3] 1030         inx
   87F2 B7 18 0C      [ 4] 1031         staa    SCCCTRLA
   87F5 A6 00         [ 4] 1032         ldaa    0,X
   87F7 08            [ 3] 1033         inx
   87F8 B7 18 0C      [ 4] 1034         staa    SCCCTRLA
   87FB 20 EE         [ 3] 1035         bra     L87EB
   87FD                    1036 L87FD:
   87FD 20 16         [ 3] 1037         bra     L8815
                           1038 
                           1039 ; data table for aux serial config
   87FF 09 8A              1040         .byte   0x09,0x8a
   8801 01 10              1041         .byte   0x01,0x10
   8803 0C 18              1042         .byte   0x0c,0x18
   8805 0D 00              1043         .byte   0x0d,0x00
   8807 04 04              1044         .byte   0x04,0x04
   8809 0E 63              1045         .byte   0x0e,0x63
   880B 05 68              1046         .byte   0x05,0x68
   880D 0B 01              1047         .byte   0x0b,0x01
   880F 03 C1              1048         .byte   0x03,0xc1
   8811 0F 00              1049         .byte   0x0f,0x00
   8813 FF FF              1050         .byte   0xff,0xff
                           1051 
                           1052 ; Install IRQ and SCI interrupt handlers
   8815                    1053 L8815:
   8815 CE 88 3E      [ 3] 1054         ldx     #L883E      ; Install IRQ interrupt handler
   8818 FF 01 28      [ 5] 1055         stx     (0x0128)
   881B 86 7E         [ 2] 1056         ldaa    #0x7E
   881D B7 01 27      [ 4] 1057         staa    (0x0127)
   8820 CE 88 32      [ 3] 1058         ldx     #L8832      ; Install SCI interrupt handler
   8823 FF 01 01      [ 5] 1059         stx     (0x0101)
   8826 B7 01 00      [ 4] 1060         staa    (0x0100)
   8829 B6 10 2D      [ 4] 1061         ldaa    SCCR2  
   882C 8A 20         [ 2] 1062         oraa    #0x20
   882E B7 10 2D      [ 4] 1063         staa    SCCR2  
   8831 39            [ 5] 1064         rts
                           1065 
                           1066 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1067 
                           1068 ; SCI Interrupt handler, normal serial
                           1069 
   8832                    1070 L8832:
   8832 B6 10 2E      [ 4] 1071         ldaa    SCSR
   8835 B6 10 2F      [ 4] 1072         ldaa    SCDR
   8838 7C 00 48      [ 6] 1073         inc     (0x0048)
   883B 7E 88 62      [ 3] 1074         jmp     L8862
                           1075 
                           1076 ; IRQ Interrupt handler, aux serial
                           1077 
   883E                    1078 L883E:
   883E 86 01         [ 2] 1079         ldaa    #0x01
   8840 B7 18 0C      [ 4] 1080         staa    SCCCTRLA
   8843 B6 18 0C      [ 4] 1081         ldaa    SCCCTRLA
   8846 84 70         [ 2] 1082         anda    #0x70
   8848 26 1F         [ 3] 1083         bne     L8869  
   884A 86 0A         [ 2] 1084         ldaa    #0x0A
   884C B7 18 0C      [ 4] 1085         staa    SCCCTRLA
   884F B6 18 0C      [ 4] 1086         ldaa    SCCCTRLA
   8852 84 C0         [ 2] 1087         anda    #0xC0
   8854 26 22         [ 3] 1088         bne     L8878  
   8856 B6 18 0C      [ 4] 1089         ldaa    SCCCTRLA
   8859 44            [ 2] 1090         lsra
   885A 24 35         [ 3] 1091         bcc     L8891  
   885C 7C 00 48      [ 6] 1092         inc     (0x0048)
   885F B6 18 0E      [ 4] 1093         ldaa    SCCDATAA
   8862                    1094 L8862:
   8862 BD F9 6F      [ 6] 1095         jsr     SERIALW      
   8865 97 4A         [ 3] 1096         staa    (0x004A)
   8867 20 2D         [ 3] 1097         bra     L8896  
   8869                    1098 L8869:
   8869 B6 18 0E      [ 4] 1099         ldaa    SCCDATAA
   886C 86 30         [ 2] 1100         ldaa    #0x30
   886E B7 18 0C      [ 4] 1101         staa    SCCCTRLA
   8871 86 07         [ 2] 1102         ldaa    #0x07
   8873 BD F9 6F      [ 6] 1103         jsr     SERIALW      
   8876 0C            [ 2] 1104         clc
   8877 3B            [12] 1105         rti
                           1106 
   8878                    1107 L8878:
   8878 86 07         [ 2] 1108         ldaa    #0x07
   887A BD F9 6F      [ 6] 1109         jsr     SERIALW      
   887D 86 0E         [ 2] 1110         ldaa    #0x0E
   887F B7 18 0C      [ 4] 1111         staa    SCCCTRLA
   8882 86 43         [ 2] 1112         ldaa    #0x43
   8884 B7 18 0C      [ 4] 1113         staa    SCCCTRLA
   8887 B6 18 0E      [ 4] 1114         ldaa    SCCDATAA
   888A 86 07         [ 2] 1115         ldaa    #0x07
   888C BD F9 6F      [ 6] 1116         jsr     SERIALW      
   888F 0D            [ 2] 1117         sec
   8890 3B            [12] 1118         rti
                           1119 
   8891                    1120 L8891:
   8891 B6 18 0E      [ 4] 1121         ldaa    SCCDATAA
   8894 0C            [ 2] 1122         clc
   8895 3B            [12] 1123         rti
                           1124 
   8896                    1125 L8896:
   8896 84 7F         [ 2] 1126         anda    #0x7F
   8898 81 24         [ 2] 1127         cmpa    #0x24       ;'$'
   889A 27 44         [ 3] 1128         beq     L88E0  
   889C 81 25         [ 2] 1129         cmpa    #0x25       ;'%'
   889E 27 40         [ 3] 1130         beq     L88E0  
   88A0 81 20         [ 2] 1131         cmpa    #0x20       ;' '
   88A2 27 3A         [ 3] 1132         beq     L88DE  
   88A4 81 30         [ 2] 1133         cmpa    #0x30       ;'0'
   88A6 25 35         [ 3] 1134         bcs     L88DD
   88A8 97 12         [ 3] 1135         staa    (0x0012)
   88AA 96 4D         [ 3] 1136         ldaa    (0x004D)
   88AC 81 02         [ 2] 1137         cmpa    #0x02
   88AE 25 09         [ 3] 1138         bcs     L88B9  
   88B0 7F 00 4D      [ 6] 1139         clr     (0x004D)
   88B3 96 12         [ 3] 1140         ldaa    (0x0012)
   88B5 97 49         [ 3] 1141         staa    (0x0049)
   88B7 20 24         [ 3] 1142         bra     L88DD  
   88B9                    1143 L88B9:
   88B9 7D 00 4E      [ 6] 1144         tst     (0x004E)
   88BC 27 1F         [ 3] 1145         beq     L88DD  
   88BE 86 78         [ 2] 1146         ldaa    #0x78
   88C0 97 63         [ 3] 1147         staa    (0x0063)
   88C2 97 64         [ 3] 1148         staa    (0x0064)
   88C4 96 12         [ 3] 1149         ldaa    (0x0012)
   88C6 81 40         [ 2] 1150         cmpa    #0x40
   88C8 24 07         [ 3] 1151         bcc     L88D1  
   88CA 97 4C         [ 3] 1152         staa    (0x004C)
   88CC 7F 00 4D      [ 6] 1153         clr     (0x004D)
   88CF 20 0C         [ 3] 1154         bra     L88DD  
   88D1                    1155 L88D1:
   88D1 81 60         [ 2] 1156         cmpa    #0x60
   88D3 24 08         [ 3] 1157         bcc     L88DD  
   88D5 97 4B         [ 3] 1158         staa    (0x004B)
   88D7 7F 00 4D      [ 6] 1159         clr     (0x004D)
   88DA BD 88 E5      [ 6] 1160         jsr     L88E5
   88DD                    1161 L88DD:
   88DD 3B            [12] 1162         rti
                           1163 
   88DE                    1164 L88DE:
   88DE 20 FD         [ 3] 1165         bra     L88DD           ; Infinite loop
   88E0                    1166 L88E0:
   88E0 7C 00 4D      [ 6] 1167         inc     (0x004D)
   88E3 20 F9         [ 3] 1168         bra     L88DE
   88E5                    1169 L88E5:
   88E5 D6 4B         [ 3] 1170         ldab    (0x004B)
   88E7 96 4C         [ 3] 1171         ldaa    (0x004C)
   88E9 7D 04 5C      [ 6] 1172         tst     (0x045C)
   88EC 27 0D         [ 3] 1173         beq     L88FB  
   88EE 81 3C         [ 2] 1174         cmpa    #0x3C
   88F0 25 09         [ 3] 1175         bcs     L88FB  
   88F2 81 3F         [ 2] 1176         cmpa    #0x3F
   88F4 22 05         [ 3] 1177         bhi     L88FB  
   88F6 BD 89 93      [ 6] 1178         jsr     L8993
   88F9 20 65         [ 3] 1179         bra     L8960  
   88FB                    1180 L88FB:
   88FB 1A 83 30 48   [ 5] 1181         cpd     #0x3048
   88FF 27 79         [ 3] 1182         beq     L897A  
   8901 1A 83 31 48   [ 5] 1183         cpd     #0x3148
   8905 27 5A         [ 3] 1184         beq     L8961  
   8907 1A 83 34 4D   [ 5] 1185         cpd     #0x344D
   890B 27 6D         [ 3] 1186         beq     L897A  
   890D 1A 83 35 4D   [ 5] 1187         cpd     #0x354D
   8911 27 4E         [ 3] 1188         beq     L8961  
   8913 1A 83 36 4D   [ 5] 1189         cpd     #0x364D
   8917 27 61         [ 3] 1190         beq     L897A  
   8919 1A 83 37 4D   [ 5] 1191         cpd     #0x374D
   891D 27 42         [ 3] 1192         beq     L8961  
   891F CE 10 80      [ 3] 1193         ldx     #0x1080
   8922 D6 4C         [ 3] 1194         ldab    (0x004C)
   8924 C0 30         [ 2] 1195         subb    #0x30
   8926 54            [ 2] 1196         lsrb
   8927 58            [ 2] 1197         aslb
   8928 58            [ 2] 1198         aslb
   8929 3A            [ 3] 1199         abx
   892A D6 4B         [ 3] 1200         ldab    (0x004B)
   892C C1 50         [ 2] 1201         cmpb    #0x50
   892E 24 30         [ 3] 1202         bcc     L8960  
   8930 C1 47         [ 2] 1203         cmpb    #0x47
   8932 23 02         [ 3] 1204         bls     L8936  
   8934 08            [ 3] 1205         inx
   8935 08            [ 3] 1206         inx
   8936                    1207 L8936:
   8936 C0 40         [ 2] 1208         subb    #0x40
   8938 C4 07         [ 2] 1209         andb    #0x07
   893A 4F            [ 2] 1210         clra
   893B 0D            [ 2] 1211         sec
   893C 49            [ 2] 1212         rola
   893D 5D            [ 2] 1213         tstb
   893E 27 04         [ 3] 1214         beq     L8944  
   8940                    1215 L8940:
   8940 49            [ 2] 1216         rola
   8941 5A            [ 2] 1217         decb
   8942 26 FC         [ 3] 1218         bne     L8940  
   8944                    1219 L8944:
   8944 97 50         [ 3] 1220         staa    (0x0050)
   8946 96 4C         [ 3] 1221         ldaa    (0x004C)
   8948 84 01         [ 2] 1222         anda    #0x01
   894A 27 08         [ 3] 1223         beq     L8954  
   894C A6 00         [ 4] 1224         ldaa    0,X
   894E 9A 50         [ 3] 1225         oraa    (0x0050)
   8950 A7 00         [ 4] 1226         staa    0,X
   8952 20 0C         [ 3] 1227         bra     L8960  
   8954                    1228 L8954:
   8954 96 50         [ 3] 1229         ldaa    (0x0050)
   8956 88 FF         [ 2] 1230         eora    #0xFF
   8958 97 50         [ 3] 1231         staa    (0x0050)
   895A A6 00         [ 4] 1232         ldaa    0,X
   895C 94 50         [ 3] 1233         anda    (0x0050)
   895E A7 00         [ 4] 1234         staa    0,X
   8960                    1235 L8960:
   8960 39            [ 5] 1236         rts
                           1237 
   8961                    1238 L8961:
   8961 B6 10 82      [ 4] 1239         ldaa    (0x1082)
   8964 8A 01         [ 2] 1240         oraa    #0x01
   8966 B7 10 82      [ 4] 1241         staa    (0x1082)
   8969 B6 10 8A      [ 4] 1242         ldaa    (0x108A)
   896C 8A 20         [ 2] 1243         oraa    #0x20
   896E B7 10 8A      [ 4] 1244         staa    (0x108A)
   8971 B6 10 8E      [ 4] 1245         ldaa    (0x108E)
   8974 8A 20         [ 2] 1246         oraa    #0x20
   8976 B7 10 8E      [ 4] 1247         staa    (0x108E)
   8979 39            [ 5] 1248         rts
                           1249 
   897A                    1250 L897A:
   897A B6 10 82      [ 4] 1251         ldaa    (0x1082)
   897D 84 FE         [ 2] 1252         anda    #0xFE
   897F B7 10 82      [ 4] 1253         staa    (0x1082)
   8982 B6 10 8A      [ 4] 1254         ldaa    (0x108A)
   8985 84 DF         [ 2] 1255         anda    #0xDF
   8987 B7 10 8A      [ 4] 1256         staa    (0x108A)
   898A B6 10 8E      [ 4] 1257         ldaa    (0x108E)
   898D 84 DF         [ 2] 1258         anda    #0xDF
   898F B7 10 8E      [ 4] 1259         staa    (0x108E)
   8992 39            [ 5] 1260         rts
                           1261 
   8993                    1262 L8993:
   8993 3C            [ 4] 1263         pshx
   8994 81 3D         [ 2] 1264         cmpa    #0x3D
   8996 22 05         [ 3] 1265         bhi     L899D  
   8998 CE F7 80      [ 3] 1266         ldx     #LF780          ; table at the end
   899B 20 03         [ 3] 1267         bra     L89A0  
   899D                    1268 L899D:
   899D CE F7 A0      [ 3] 1269         ldx     #LF7A0         ; table at the end
   89A0                    1270 L89A0:
   89A0 C0 40         [ 2] 1271         subb    #0x40
   89A2 58            [ 2] 1272         aslb
   89A3 3A            [ 3] 1273         abx
   89A4 81 3C         [ 2] 1274         cmpa    #0x3C
   89A6 27 34         [ 3] 1275         beq     L89DC  
   89A8 81 3D         [ 2] 1276         cmpa    #0x3D
   89AA 27 0A         [ 3] 1277         beq     L89B6  
   89AC 81 3E         [ 2] 1278         cmpa    #0x3E
   89AE 27 4B         [ 3] 1279         beq     L89FB  
   89B0 81 3F         [ 2] 1280         cmpa    #0x3F
   89B2 27 15         [ 3] 1281         beq     L89C9  
   89B4 38            [ 5] 1282         pulx
   89B5 39            [ 5] 1283         rts
                           1284 
   89B6                    1285 L89B6:
   89B6 B6 10 98      [ 4] 1286         ldaa    (0x1098)
   89B9 AA 00         [ 4] 1287         oraa    0,X
   89BB B7 10 98      [ 4] 1288         staa    (0x1098)
   89BE 08            [ 3] 1289         inx
   89BF B6 10 9A      [ 4] 1290         ldaa    (0x109A)
   89C2 AA 00         [ 4] 1291         oraa    0,X
   89C4 B7 10 9A      [ 4] 1292         staa    (0x109A)
   89C7 38            [ 5] 1293         pulx
   89C8 39            [ 5] 1294         rts
                           1295 
   89C9                    1296 L89C9:
   89C9 B6 10 9C      [ 4] 1297         ldaa    (0x109C)
   89CC AA 00         [ 4] 1298         oraa    0,X
   89CE B7 10 9C      [ 4] 1299         staa    (0x109C)
   89D1 08            [ 3] 1300         inx
   89D2 B6 10 9E      [ 4] 1301         ldaa    (0x109E)
   89D5 AA 00         [ 4] 1302         oraa    0,X
   89D7 B7 10 9E      [ 4] 1303         staa    (0x109E)
   89DA 38            [ 5] 1304         pulx
   89DB 39            [ 5] 1305         rts
                           1306 
   89DC                    1307 L89DC:
   89DC E6 00         [ 4] 1308         ldab    0,X
   89DE C8 FF         [ 2] 1309         eorb    #0xFF
   89E0 D7 12         [ 3] 1310         stab    (0x0012)
   89E2 B6 10 98      [ 4] 1311         ldaa    (0x1098)
   89E5 94 12         [ 3] 1312         anda    (0x0012)
   89E7 B7 10 98      [ 4] 1313         staa    (0x1098)
   89EA 08            [ 3] 1314         inx
   89EB E6 00         [ 4] 1315         ldab    0,X
   89ED C8 FF         [ 2] 1316         eorb    #0xFF
   89EF D7 12         [ 3] 1317         stab    (0x0012)
   89F1 B6 10 9A      [ 4] 1318         ldaa    (0x109A)
   89F4 94 12         [ 3] 1319         anda    (0x0012)
   89F6 B7 10 9A      [ 4] 1320         staa    (0x109A)
   89F9 38            [ 5] 1321         pulx
   89FA 39            [ 5] 1322         rts
                           1323 
   89FB                    1324 L89FB:
   89FB E6 00         [ 4] 1325         ldab    0,X
   89FD C8 FF         [ 2] 1326         eorb    #0xFF
   89FF D7 12         [ 3] 1327         stab    (0x0012)
   8A01 B6 10 9C      [ 4] 1328         ldaa    (0x109C)
   8A04 94 12         [ 3] 1329         anda    (0x0012)
   8A06 B7 10 9C      [ 4] 1330         staa    (0x109C)
   8A09 08            [ 3] 1331         inx
   8A0A E6 00         [ 4] 1332         ldab    0,X
   8A0C C8 FF         [ 2] 1333         eorb    #0xFF
   8A0E D7 12         [ 3] 1334         stab    (0x0012)
   8A10 B6 10 9E      [ 4] 1335         ldaa    (0x109E)
   8A13 94 12         [ 3] 1336         anda    (0x0012)
   8A15 B7 10 9E      [ 4] 1337         staa    (0x109E)
   8A18 38            [ 5] 1338         pulx
   8A19 39            [ 5] 1339         rts
                           1340 
                           1341 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1342 
   8A1A                    1343 L8A1A:
                           1344 ; Read from table location in X
   8A1A 3C            [ 4] 1345         pshx
   8A1B                    1346 L8A1B:
   8A1B 86 04         [ 2] 1347         ldaa    #0x04
   8A1D B5 18 0D      [ 4] 1348         bita    SCCCTRLB
   8A20 27 F9         [ 3] 1349         beq     L8A1B  
   8A22 A6 00         [ 4] 1350         ldaa    0,X     
   8A24 26 03         [ 3] 1351         bne     L8A29       ; is it a nul?
   8A26 7E 8B 21      [ 3] 1352         jmp     L8B21       ; if so jump to exit
   8A29                    1353 L8A29:
   8A29 08            [ 3] 1354         inx
   8A2A 81 5E         [ 2] 1355         cmpa    #0x5E       ; is is a caret? '^'
   8A2C 26 1D         [ 3] 1356         bne     L8A4B       ; no, jump ahead
   8A2E A6 00         [ 4] 1357         ldaa    0,X         ; yes, get the next char
   8A30 08            [ 3] 1358         inx
   8A31 B7 05 92      [ 4] 1359         staa    (0x0592)    
   8A34 A6 00         [ 4] 1360         ldaa    0,X     
   8A36 08            [ 3] 1361         inx
   8A37 B7 05 93      [ 4] 1362         staa    (0x0593)
   8A3A A6 00         [ 4] 1363         ldaa    0,X     
   8A3C 08            [ 3] 1364         inx
   8A3D B7 05 95      [ 4] 1365         staa    (0x0595)
   8A40 A6 00         [ 4] 1366         ldaa    0,X     
   8A42 08            [ 3] 1367         inx
   8A43 B7 05 96      [ 4] 1368         staa    (0x0596)
   8A46 BD 8B 23      [ 6] 1369         jsr     L8B23
   8A49 20 D0         [ 3] 1370         bra     L8A1B  
                           1371 
   8A4B                    1372 L8A4B:
   8A4B 81 40         [ 2] 1373         cmpa    #0x40
   8A4D 26 3B         [ 3] 1374         bne     L8A8A  
   8A4F 1A EE 00      [ 6] 1375         ldy     0,X     
   8A52 08            [ 3] 1376         inx
   8A53 08            [ 3] 1377         inx
   8A54 86 30         [ 2] 1378         ldaa    #0x30
   8A56 97 B1         [ 3] 1379         staa    (0x00B1)
   8A58 18 A6 00      [ 5] 1380         ldaa    0,Y     
   8A5B                    1381 L8A5B:
   8A5B 81 64         [ 2] 1382         cmpa    #0x64
   8A5D 25 07         [ 3] 1383         bcs     L8A66  
   8A5F 7C 00 B1      [ 6] 1384         inc     (0x00B1)
   8A62 80 64         [ 2] 1385         suba    #0x64
   8A64 20 F5         [ 3] 1386         bra     L8A5B  
   8A66                    1387 L8A66:
   8A66 36            [ 3] 1388         psha
   8A67 96 B1         [ 3] 1389         ldaa    (0x00B1)
   8A69 BD 8B 3B      [ 6] 1390         jsr     L8B3B
   8A6C 86 30         [ 2] 1391         ldaa    #0x30
   8A6E 97 B1         [ 3] 1392         staa    (0x00B1)
   8A70 32            [ 4] 1393         pula
   8A71                    1394 L8A71:
   8A71 81 0A         [ 2] 1395         cmpa    #0x0A
   8A73 25 07         [ 3] 1396         bcs     L8A7C  
   8A75 7C 00 B1      [ 6] 1397         inc     (0x00B1)
   8A78 80 0A         [ 2] 1398         suba    #0x0A
   8A7A 20 F5         [ 3] 1399         bra     L8A71  
   8A7C                    1400 L8A7C:
   8A7C 36            [ 3] 1401         psha
   8A7D 96 B1         [ 3] 1402         ldaa    (0x00B1)
   8A7F BD 8B 3B      [ 6] 1403         jsr     L8B3B
   8A82 32            [ 4] 1404         pula
   8A83 8B 30         [ 2] 1405         adda    #0x30
   8A85 BD 8B 3B      [ 6] 1406         jsr     L8B3B
   8A88 20 91         [ 3] 1407         bra     L8A1B  
   8A8A                    1408 L8A8A:
   8A8A 81 7C         [ 2] 1409         cmpa    #0x7C
   8A8C 26 59         [ 3] 1410         bne     L8AE7  
   8A8E 1A EE 00      [ 6] 1411         ldy     0,X     
   8A91 08            [ 3] 1412         inx
   8A92 08            [ 3] 1413         inx
   8A93 86 30         [ 2] 1414         ldaa    #0x30
   8A95 97 B1         [ 3] 1415         staa    (0x00B1)
   8A97 18 EC 00      [ 6] 1416         ldd     0,Y     
   8A9A                    1417 L8A9A:
   8A9A 1A 83 27 10   [ 5] 1418         cpd     #0x2710
   8A9E 25 08         [ 3] 1419         bcs     L8AA8  
   8AA0 7C 00 B1      [ 6] 1420         inc     (0x00B1)
   8AA3 83 27 10      [ 4] 1421         subd    #0x2710
   8AA6 20 F2         [ 3] 1422         bra     L8A9A  
   8AA8                    1423 L8AA8:
   8AA8 36            [ 3] 1424         psha
   8AA9 96 B1         [ 3] 1425         ldaa    (0x00B1)
   8AAB BD 8B 3B      [ 6] 1426         jsr     L8B3B
   8AAE 86 30         [ 2] 1427         ldaa    #0x30
   8AB0 97 B1         [ 3] 1428         staa    (0x00B1)
   8AB2 32            [ 4] 1429         pula
   8AB3                    1430 L8AB3:
   8AB3 1A 83 03 E8   [ 5] 1431         cpd     #0x03E8
   8AB7 25 08         [ 3] 1432         bcs     L8AC1  
   8AB9 7C 00 B1      [ 6] 1433         inc     (0x00B1)
   8ABC 83 03 E8      [ 4] 1434         subd    #0x03E8
   8ABF 20 F2         [ 3] 1435         bra     L8AB3  
   8AC1                    1436 L8AC1:
   8AC1 36            [ 3] 1437         psha
   8AC2 96 B1         [ 3] 1438         ldaa    (0x00B1)
   8AC4 BD 8B 3B      [ 6] 1439         jsr     L8B3B
   8AC7 86 30         [ 2] 1440         ldaa    #0x30
   8AC9 97 B1         [ 3] 1441         staa    (0x00B1)
   8ACB 32            [ 4] 1442         pula
   8ACC                    1443 L8ACC:
   8ACC 1A 83 00 64   [ 5] 1444         cpd     #0x0064
   8AD0 25 08         [ 3] 1445         bcs     L8ADA  
   8AD2 7C 00 B1      [ 6] 1446         inc     (0x00B1)
   8AD5 83 00 64      [ 4] 1447         subd    #0x0064
   8AD8 20 F2         [ 3] 1448         bra     L8ACC  
   8ADA                    1449 L8ADA:
   8ADA 96 B1         [ 3] 1450         ldaa    (0x00B1)
   8ADC BD 8B 3B      [ 6] 1451         jsr     L8B3B
   8ADF 86 30         [ 2] 1452         ldaa    #0x30
   8AE1 97 B1         [ 3] 1453         staa    (0x00B1)
   8AE3 17            [ 2] 1454         tba
   8AE4 7E 8A 71      [ 3] 1455         jmp     L8A71
   8AE7                    1456 L8AE7:
   8AE7 81 7E         [ 2] 1457         cmpa    #0x7E
   8AE9 26 18         [ 3] 1458         bne     L8B03  
   8AEB E6 00         [ 4] 1459         ldab    0,X     
   8AED C0 30         [ 2] 1460         subb    #0x30
   8AEF 08            [ 3] 1461         inx
   8AF0 1A EE 00      [ 6] 1462         ldy     0,X     
   8AF3 08            [ 3] 1463         inx
   8AF4 08            [ 3] 1464         inx
   8AF5                    1465 L8AF5:
   8AF5 18 A6 00      [ 5] 1466         ldaa    0,Y     
   8AF8 18 08         [ 4] 1467         iny
   8AFA BD 8B 3B      [ 6] 1468         jsr     L8B3B
   8AFD 5A            [ 2] 1469         decb
   8AFE 26 F5         [ 3] 1470         bne     L8AF5  
   8B00 7E 8A 1B      [ 3] 1471         jmp     L8A1B
   8B03                    1472 L8B03:
   8B03 81 25         [ 2] 1473         cmpa    #0x25
   8B05 26 14         [ 3] 1474         bne     L8B1B  
   8B07 CE 05 90      [ 3] 1475         ldx     #0x0590
   8B0A CC 1B 5B      [ 3] 1476         ldd     #0x1B5B
   8B0D ED 00         [ 5] 1477         std     0,X     
   8B0F 86 4B         [ 2] 1478         ldaa    #0x4B
   8B11 A7 02         [ 4] 1479         staa    2,X
   8B13 6F 03         [ 6] 1480         clr     3,X
   8B15 BD 8A 1A      [ 6] 1481         jsr     L8A1A  
   8B18 7E 8A 1B      [ 3] 1482         jmp     L8A1B
   8B1B                    1483 L8B1B:
   8B1B B7 18 0F      [ 4] 1484         staa    SCCDATAB
   8B1E 7E 8A 1B      [ 3] 1485         jmp     L8A1B
   8B21                    1486 L8B21:
   8B21 38            [ 5] 1487         pulx
   8B22 39            [ 5] 1488         rts
                           1489 
   8B23                    1490 L8B23:
   8B23 3C            [ 4] 1491         pshx
   8B24 CE 05 90      [ 3] 1492         ldx     #0x0590
   8B27 CC 1B 5B      [ 3] 1493         ldd     #0x1B5B
   8B2A ED 00         [ 5] 1494         std     0,X     
   8B2C 86 48         [ 2] 1495         ldaa    #0x48
   8B2E A7 07         [ 4] 1496         staa    7,X
   8B30 86 3B         [ 2] 1497         ldaa    #0x3B
   8B32 A7 04         [ 4] 1498         staa    4,X
   8B34 6F 08         [ 6] 1499         clr     8,X
   8B36 BD 8A 1A      [ 6] 1500         jsr     L8A1A  
   8B39 38            [ 5] 1501         pulx
   8B3A 39            [ 5] 1502         rts
   8B3B                    1503 L8B3B:
   8B3B 36            [ 3] 1504         psha
   8B3C                    1505 L8B3C:
   8B3C 86 04         [ 2] 1506         ldaa    #0x04
   8B3E B5 18 0D      [ 4] 1507         bita    SCCCTRLB
   8B41 27 F9         [ 3] 1508         beq     L8B3C  
   8B43 32            [ 4] 1509         pula
   8B44 B7 18 0F      [ 4] 1510         staa    SCCDATAB
   8B47 39            [ 5] 1511         rts
                           1512 
   8B48                    1513 L8B48:
   8B48 BD A3 2E      [ 6] 1514         jsr     LA32E
                           1515 
   8B4B BD 8D E4      [ 6] 1516         jsr     LCDMSG1 
   8B4E 4C 69 67 68 74 20  1517         .ascis  'Light Diagnostic'
        44 69 61 67 6E 6F
        73 74 69 E3
                           1518 
   8B5E BD 8D DD      [ 6] 1519         jsr     LCDMSG2 
   8B61 43 75 72 74 61 69  1520         .ascis  'Curtains opening'
        6E 73 20 6F 70 65
        6E 69 6E E7
                           1521 
   8B71 C6 14         [ 2] 1522         ldab    #0x14
   8B73 BD 8C 30      [ 6] 1523         jsr     DLYSECSBY2           ; delay 10 sec
   8B76 C6 FF         [ 2] 1524         ldab    #0xFF
   8B78 F7 10 98      [ 4] 1525         stab    (0x1098)
   8B7B F7 10 9A      [ 4] 1526         stab    (0x109A)
   8B7E F7 10 9C      [ 4] 1527         stab    (0x109C)
   8B81 F7 10 9E      [ 4] 1528         stab    (0x109E)
   8B84 BD F9 C5      [ 6] 1529         jsr     BUTNLIT 
   8B87 B6 18 04      [ 4] 1530         ldaa    PIA0PRA 
   8B8A 8A 40         [ 2] 1531         oraa    #0x40
   8B8C B7 18 04      [ 4] 1532         staa    PIA0PRA 
                           1533 
   8B8F BD 8D E4      [ 6] 1534         jsr     LCDMSG1 
   8B92 20 50 72 65 73 73  1535         .ascis  ' Press ENTER to '
        20 45 4E 54 45 52
        20 74 6F A0
                           1536 
   8BA2 BD 8D DD      [ 6] 1537         jsr     LCDMSG2 
   8BA5 74 75 72 6E 20 6C  1538         .ascis  'turn lights  off'
        69 67 68 74 73 20
        20 6F 66 E6
                           1539 
   8BB5                    1540 L8BB5:
   8BB5 BD 8E 95      [ 6] 1541         jsr     L8E95
   8BB8 81 0D         [ 2] 1542         cmpa    #0x0D
   8BBA 26 F9         [ 3] 1543         bne     L8BB5  
   8BBC BD A3 41      [ 6] 1544         jsr     LA341
   8BBF 39            [ 5] 1545         rts
                           1546 
                           1547 ; setup IRQ handlers!
   8BC0                    1548 L8BC0:
   8BC0 86 80         [ 2] 1549         ldaa    #0x80
   8BC2 B7 10 22      [ 4] 1550         staa    TMSK1
   8BC5 CE AB CC      [ 3] 1551         ldx     #LABCC
   8BC8 FF 01 19      [ 5] 1552         stx     (0x0119)    ; setup T1OC handler
   8BCB CE AD 0C      [ 3] 1553         ldx     #LAD0C
                           1554 
   8BCE FF 01 16      [ 5] 1555         stx     (0x0116)    ; setup T2OC handler
   8BD1 CE AD 0C      [ 3] 1556         ldx     #LAD0C
   8BD4 FF 01 2E      [ 5] 1557         stx     (0x012E)    ; doubles as SWI handler
   8BD7 86 7E         [ 2] 1558         ldaa    #0x7E
   8BD9 B7 01 18      [ 4] 1559         staa    (0x0118)
   8BDC B7 01 15      [ 4] 1560         staa    (0x0115)
   8BDF B7 01 2D      [ 4] 1561         staa    (0x012D)
   8BE2 4F            [ 2] 1562         clra
   8BE3 5F            [ 2] 1563         clrb
   8BE4 DD 1B         [ 4] 1564         std     CDTIMR1     ; Reset all the countdown timers
   8BE6 DD 1D         [ 4] 1565         std     CDTIMR2
   8BE8 DD 1F         [ 4] 1566         std     CDTIMR3
   8BEA DD 21         [ 4] 1567         std     CDTIMR4
   8BEC DD 23         [ 4] 1568         std     CDTIMR5
                           1569 
   8BEE                    1570 L8BEE:
   8BEE 86 C0         [ 2] 1571         ldaa    #0xC0
   8BF0 B7 10 23      [ 4] 1572         staa    TFLG1
   8BF3 39            [ 5] 1573         rts
                           1574 
   8BF4                    1575 L8BF4:
   8BF4 B6 10 0A      [ 4] 1576         ldaa    PORTE
   8BF7 88 FF         [ 2] 1577         eora    #0xFF
   8BF9 16            [ 2] 1578         tab
   8BFA D7 62         [ 3] 1579         stab    (0x0062)
   8BFC BD F9 C5      [ 6] 1580         jsr     BUTNLIT 
   8BFF 20 F3         [ 3] 1581         bra     L8BF4  
   8C01 39            [ 5] 1582         rts
                           1583 
                           1584 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1585 
                           1586 ; Delay B seconds, with housekeeping
   8C02                    1587 DLYSECS:
   8C02 36            [ 3] 1588         psha
   8C03 86 64         [ 2] 1589         ldaa    #0x64
   8C05 3D            [10] 1590         mul
   8C06 DD 23         [ 4] 1591         std     CDTIMR5     ; store B*100 here
   8C08                    1592 L8C08:
   8C08 BD 9B 19      [ 6] 1593         jsr     L9B19   
   8C0B DC 23         [ 4] 1594         ldd     CDTIMR5     ; housekeeping
   8C0D 26 F9         [ 3] 1595         bne     L8C08  
   8C0F 32            [ 4] 1596         pula
   8C10 39            [ 5] 1597         rts
                           1598 
                           1599 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1600 
                           1601 ; Delay 1 minute, with housekeeping - unused?
   8C11                    1602 DLY1MIN:
   8C11 36            [ 3] 1603         psha
   8C12 86 3C         [ 2] 1604         ldaa    #0x3C
   8C14                    1605 L8C14:
   8C14 97 28         [ 3] 1606         staa    (0x0028)
   8C16 C6 01         [ 2] 1607         ldab    #0x01       ; delay 1 sec
   8C18 BD 8C 02      [ 6] 1608         jsr     DLYSECS     ;
   8C1B 96 28         [ 3] 1609         ldaa    (0x0028)
   8C1D 4A            [ 2] 1610         deca
   8C1E 26 F4         [ 3] 1611         bne     L8C14  
   8C20 32            [ 4] 1612         pula
   8C21 39            [ 5] 1613         rts
                           1614 
                           1615 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1616 
                           1617 ; Delay by B hundreths of a second, with housekeeping
   8C22                    1618 DLYSECSBY100:
   8C22 36            [ 3] 1619         psha
   8C23 4F            [ 2] 1620         clra
   8C24 DD 23         [ 4] 1621         std     CDTIMR5
   8C26                    1622 L8C26:
   8C26 BD 9B 19      [ 6] 1623         jsr     L9B19   
   8C29 7D 00 24      [ 6] 1624         tst     CDTIMR5+1
   8C2C 26 F8         [ 3] 1625         bne     L8C26       ; housekeeping?
   8C2E 32            [ 4] 1626         pula
   8C2F 39            [ 5] 1627         rts
                           1628 
                           1629 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1630 
                           1631 ; Delay by B half-seconds, with housekeeping
   8C30                    1632 DLYSECSBY2:
   8C30 36            [ 3] 1633         psha
   8C31 86 32         [ 2] 1634         ldaa    #0x32       ; 50
   8C33 3D            [10] 1635         mul
   8C34 DD 23         [ 4] 1636         std     CDTIMR5
   8C36                    1637 L8C36:
   8C36 DC 23         [ 4] 1638         ldd     CDTIMR5
   8C38 26 FC         [ 3] 1639         bne     L8C36       ; housekeeping?
   8C3A 32            [ 4] 1640         pula
   8C3B 39            [ 5] 1641         rts
                           1642 
                           1643 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1644 ; LCD routines
                           1645 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1646 
   8C3C                    1647 L8C3C:
   8C3C 86 FF         [ 2] 1648         ldaa    #0xFF
   8C3E B7 10 01      [ 4] 1649         staa    DDRA  
   8C41 86 FF         [ 2] 1650         ldaa    #0xFF
   8C43 B7 10 03      [ 4] 1651         staa    DDRG 
   8C46 B6 10 02      [ 4] 1652         ldaa    PORTG  
   8C49 8A 02         [ 2] 1653         oraa    #0x02
   8C4B B7 10 02      [ 4] 1654         staa    PORTG  
   8C4E 86 38         [ 2] 1655         ldaa    #0x38
   8C50 BD 8C 86      [ 6] 1656         jsr     L8C86        ; write byte to LCD
   8C53 86 38         [ 2] 1657         ldaa    #0x38
   8C55 BD 8C 86      [ 6] 1658         jsr     L8C86        ; write byte to LCD
   8C58 86 06         [ 2] 1659         ldaa    #0x06
   8C5A BD 8C 86      [ 6] 1660         jsr     L8C86        ; write byte to LCD
   8C5D 86 0E         [ 2] 1661         ldaa    #0x0E
   8C5F BD 8C 86      [ 6] 1662         jsr     L8C86        ; write byte to LCD
   8C62 86 01         [ 2] 1663         ldaa    #0x01
   8C64 BD 8C 86      [ 6] 1664         jsr     L8C86        ; write byte to LCD
   8C67 CE 00 FF      [ 3] 1665         ldx     #0x00FF
   8C6A                    1666 L8C6A:
   8C6A 01            [ 2] 1667         nop
   8C6B 01            [ 2] 1668         nop
   8C6C 09            [ 3] 1669         dex
   8C6D 26 FB         [ 3] 1670         bne     L8C6A  
   8C6F 39            [ 5] 1671         rts
                           1672 
                           1673 ; toggle LCD ENABLE
   8C70                    1674 L8C70:
   8C70 B6 10 02      [ 4] 1675         ldaa    PORTG  
   8C73 84 FD         [ 2] 1676         anda    #0xFD        ; clear LCD ENABLE
   8C75 B7 10 02      [ 4] 1677         staa    PORTG  
   8C78 8A 02         [ 2] 1678         oraa    #0x02        ; set LCD ENABLE
   8C7A B7 10 02      [ 4] 1679         staa    PORTG  
   8C7D 39            [ 5] 1680         rts
                           1681 
                           1682 ; Reset LCD buffer?
   8C7E                    1683 L8C7E:
   8C7E CC 05 00      [ 3] 1684         ldd     #0x0500     ; Reset LCD queue?
   8C81 DD 46         [ 4] 1685         std     (0x0046)    ; write pointer
   8C83 DD 44         [ 4] 1686         std     (0x0044)    ; read pointer?
   8C85 39            [ 5] 1687         rts
                           1688 
                           1689 ; write byte to LCD
   8C86                    1690 L8C86:
   8C86 BD 8C BD      [ 6] 1691         jsr     L8CBD        ; wait for LCD not busy
   8C89 B7 10 00      [ 4] 1692         staa    PORTA  
   8C8C B6 10 02      [ 4] 1693         ldaa    PORTG       
   8C8F 84 F3         [ 2] 1694         anda    #0xF3        ; LCD RS and LCD RW low
   8C91                    1695 L8C91:
   8C91 B7 10 02      [ 4] 1696         staa    PORTG  
   8C94 BD 8C 70      [ 6] 1697         jsr     L8C70        ; toggle LCD ENABLE
   8C97 39            [ 5] 1698         rts
                           1699 
                           1700 ; ???
   8C98                    1701 L8C98:
   8C98 BD 8C BD      [ 6] 1702         jsr     L8CBD        ; wait for LCD not busy
   8C9B B7 10 00      [ 4] 1703         staa    PORTA  
   8C9E B6 10 02      [ 4] 1704         ldaa    PORTG  
   8CA1 84 FB         [ 2] 1705         anda    #0xFB
   8CA3 8A 08         [ 2] 1706         oraa    #0x08
   8CA5 20 EA         [ 3] 1707         bra     L8C91  
   8CA7 BD 8C BD      [ 6] 1708         jsr     L8CBD        ; wait for LCD not busy
   8CAA B6 10 02      [ 4] 1709         ldaa    PORTG  
   8CAD 84 F7         [ 2] 1710         anda    #0xF7
   8CAF 8A 08         [ 2] 1711         oraa    #0x08
   8CB1 20 DE         [ 3] 1712         bra     L8C91  
   8CB3 BD 8C BD      [ 6] 1713         jsr     L8CBD        ; wait for LCD not busy
   8CB6 B6 10 02      [ 4] 1714         ldaa    PORTG  
   8CB9 8A 0C         [ 2] 1715         oraa    #0x0C
   8CBB 20 D4         [ 3] 1716         bra     L8C91  
                           1717 
                           1718 ; wait for LCD not busy (or timeout)
   8CBD                    1719 L8CBD:
   8CBD 36            [ 3] 1720         psha
   8CBE 37            [ 3] 1721         pshb
   8CBF C6 FF         [ 2] 1722         ldab    #0xFF        ; init timeout counter
   8CC1                    1723 L8CC1:
   8CC1 5D            [ 2] 1724         tstb
   8CC2 27 1A         [ 3] 1725         beq     L8CDE       ; times up, exit
   8CC4 B6 10 02      [ 4] 1726         ldaa    PORTG  
   8CC7 84 F7         [ 2] 1727         anda    #0xF7        ; bit 3 low
   8CC9 8A 04         [ 2] 1728         oraa    #0x04        ; bit 3 high
   8CCB B7 10 02      [ 4] 1729         staa    PORTG        ; LCD RS high
   8CCE BD 8C 70      [ 6] 1730         jsr     L8C70        ; toggle LCD ENABLE
   8CD1 7F 10 01      [ 6] 1731         clr     DDRA  
   8CD4 B6 10 00      [ 4] 1732         ldaa    PORTA       ; read busy flag from LCD
   8CD7 2B 08         [ 3] 1733         bmi     L8CE1       ; if busy, keep looping
   8CD9 86 FF         [ 2] 1734         ldaa    #0xFF
   8CDB B7 10 01      [ 4] 1735         staa    DDRA        ; port A back to outputs
   8CDE                    1736 L8CDE:
   8CDE 33            [ 4] 1737         pulb                ; and exit
   8CDF 32            [ 4] 1738         pula
   8CE0 39            [ 5] 1739         rts
                           1740 
   8CE1                    1741 L8CE1:
   8CE1 5A            [ 2] 1742         decb                ; decrement timer
   8CE2 86 FF         [ 2] 1743         ldaa    #0xFF
   8CE4 B7 10 01      [ 4] 1744         staa    DDRA        ; port A back to outputs
   8CE7 20 D8         [ 3] 1745         bra     L8CC1       ; loop
                           1746 
   8CE9                    1747 L8CE9:
   8CE9 BD 8C BD      [ 6] 1748         jsr     L8CBD        ; wait for LCD not busy
   8CEC 86 01         [ 2] 1749         ldaa    #0x01
   8CEE BD 8C 86      [ 6] 1750         jsr     L8C86        ; write byte to LCD
   8CF1 39            [ 5] 1751         rts
                           1752 
   8CF2                    1753 L8CF2:
   8CF2 BD 8C BD      [ 6] 1754         jsr     L8CBD        ; wait for LCD not busy
   8CF5 86 80         [ 2] 1755         ldaa    #0x80
   8CF7 BD 8D 14      [ 6] 1756         jsr     L8D14
   8CFA BD 8C BD      [ 6] 1757         jsr     L8CBD        ; wait for LCD not busy
   8CFD 86 80         [ 2] 1758         ldaa    #0x80
   8CFF BD 8C 86      [ 6] 1759         jsr     L8C86        ; write byte to LCD
   8D02 39            [ 5] 1760         rts
                           1761 
   8D03                    1762 L8D03:
   8D03 BD 8C BD      [ 6] 1763         jsr     L8CBD        ; wait for LCD not busy
   8D06 86 C0         [ 2] 1764         ldaa    #0xC0
   8D08 BD 8D 14      [ 6] 1765         jsr     L8D14
   8D0B BD 8C BD      [ 6] 1766         jsr     L8CBD        ; wait for LCD not busy
   8D0E 86 C0         [ 2] 1767         ldaa    #0xC0
   8D10 BD 8C 86      [ 6] 1768         jsr     L8C86        ; write byte to LCD
   8D13 39            [ 5] 1769         rts
                           1770 
   8D14                    1771 L8D14:
   8D14 BD 8C 86      [ 6] 1772         jsr     L8C86        ; write byte to LCD
   8D17 86 10         [ 2] 1773         ldaa    #0x10
   8D19 97 14         [ 3] 1774         staa    (0x0014)
   8D1B                    1775 L8D1B:
   8D1B BD 8C BD      [ 6] 1776         jsr     L8CBD        ; wait for LCD not busy
   8D1E 86 20         [ 2] 1777         ldaa    #0x20
   8D20 BD 8C 98      [ 6] 1778         jsr     L8C98
   8D23 7A 00 14      [ 6] 1779         dec     (0x0014)
   8D26 26 F3         [ 3] 1780         bne     L8D1B  
   8D28 39            [ 5] 1781         rts
                           1782 
   8D29                    1783 L8D29:
   8D29 86 0C         [ 2] 1784         ldaa    #0x0C
   8D2B BD 8E 4B      [ 6] 1785         jsr     L8E4B
   8D2E 39            [ 5] 1786         rts
                           1787 
                           1788 ; Unused?
   8D2F                    1789 L8D2F:
   8D2F 86 0E         [ 2] 1790         ldaa    #0x0E
   8D31 BD 8E 4B      [ 6] 1791         jsr     L8E4B
   8D34 39            [ 5] 1792         rts
                           1793 
   8D35                    1794 L8D35:
   8D35 7F 00 4A      [ 6] 1795         clr     (0x004A)
   8D38 7F 00 43      [ 6] 1796         clr     (0x0043)
   8D3B 18 DE 46      [ 5] 1797         ldy     (0x0046)
   8D3E 86 C0         [ 2] 1798         ldaa    #0xC0
   8D40 20 0B         [ 3] 1799         bra     L8D4D
                           1800 
   8D42                    1801 L8D42:
   8D42 7F 00 4A      [ 6] 1802         clr     (0x004A)
   8D45 7F 00 43      [ 6] 1803         clr     (0x0043)
   8D48 18 DE 46      [ 5] 1804         ldy     (0x0046)
   8D4B 86 80         [ 2] 1805         ldaa    #0x80
   8D4D                    1806 L8D4D:
   8D4D 18 A7 00      [ 5] 1807         staa    0,Y     
   8D50 18 6F 01      [ 7] 1808         clr     1,Y     
   8D53 18 08         [ 4] 1809         iny
   8D55 18 08         [ 4] 1810         iny
   8D57 18 8C 05 80   [ 5] 1811         cpy     #0x0580
   8D5B 25 04         [ 3] 1812         bcs     L8D61  
   8D5D 18 CE 05 00   [ 4] 1813         ldy     #0x0500
   8D61                    1814 L8D61:
   8D61 C6 0F         [ 2] 1815         ldab    #0x0F
   8D63                    1816 L8D63:
   8D63 96 4A         [ 3] 1817         ldaa    (0x004A)
   8D65 27 FC         [ 3] 1818         beq     L8D63  
   8D67 7F 00 4A      [ 6] 1819         clr     (0x004A)
   8D6A 5A            [ 2] 1820         decb
   8D6B 27 1A         [ 3] 1821         beq     L8D87  
   8D6D 81 24         [ 2] 1822         cmpa    #0x24
   8D6F 27 16         [ 3] 1823         beq     L8D87  
   8D71 18 6F 00      [ 7] 1824         clr     0,Y     
   8D74 18 A7 01      [ 5] 1825         staa    1,Y     
   8D77 18 08         [ 4] 1826         iny
   8D79 18 08         [ 4] 1827         iny
   8D7B 18 8C 05 80   [ 5] 1828         cpy     #0x0580
   8D7F 25 04         [ 3] 1829         bcs     L8D85  
   8D81 18 CE 05 00   [ 4] 1830         ldy     #0x0500
   8D85                    1831 L8D85:
   8D85 20 DC         [ 3] 1832         bra     L8D63  
   8D87                    1833 L8D87:
   8D87 5D            [ 2] 1834         tstb
   8D88 27 19         [ 3] 1835         beq     L8DA3  
   8D8A 86 20         [ 2] 1836         ldaa    #0x20
   8D8C                    1837 L8D8C:
   8D8C 18 6F 00      [ 7] 1838         clr     0,Y     
   8D8F 18 A7 01      [ 5] 1839         staa    1,Y     
   8D92 18 08         [ 4] 1840         iny
   8D94 18 08         [ 4] 1841         iny
   8D96 18 8C 05 80   [ 5] 1842         cpy     #0x0580
   8D9A 25 04         [ 3] 1843         bcs     L8DA0  
   8D9C 18 CE 05 00   [ 4] 1844         ldy     #0x0500
   8DA0                    1845 L8DA0:
   8DA0 5A            [ 2] 1846         decb
   8DA1 26 E9         [ 3] 1847         bne     L8D8C  
   8DA3                    1848 L8DA3:
   8DA3 18 6F 00      [ 7] 1849         clr     0,Y     
   8DA6 18 6F 01      [ 7] 1850         clr     1,Y     
   8DA9 18 DF 46      [ 5] 1851         sty     (0x0046)
   8DAC 96 19         [ 3] 1852         ldaa    (0x0019)
   8DAE 97 4E         [ 3] 1853         staa    (0x004E)
   8DB0 86 01         [ 2] 1854         ldaa    #0x01
   8DB2 97 43         [ 3] 1855         staa    (0x0043)
   8DB4 39            [ 5] 1856         rts
                           1857 
                           1858 ; display ASCII in B at location
   8DB5                    1859 L8DB5:
   8DB5 36            [ 3] 1860         psha
   8DB6 37            [ 3] 1861         pshb
   8DB7 C1 4F         [ 2] 1862         cmpb    #0x4F
   8DB9 22 13         [ 3] 1863         bhi     L8DCE  
   8DBB C1 28         [ 2] 1864         cmpb    #0x28
   8DBD 25 03         [ 3] 1865         bcs     L8DC2  
   8DBF 0C            [ 2] 1866         clc
   8DC0 C9 18         [ 2] 1867         adcb    #0x18
   8DC2                    1868 L8DC2:
   8DC2 0C            [ 2] 1869         clc
   8DC3 C9 80         [ 2] 1870         adcb    #0x80
   8DC5 17            [ 2] 1871         tba
   8DC6 BD 8E 4B      [ 6] 1872         jsr     L8E4B        ; send lcd command
   8DC9 33            [ 4] 1873         pulb
   8DCA 32            [ 4] 1874         pula
   8DCB BD 8E 70      [ 6] 1875         jsr     L8E70        ; send lcd char
   8DCE                    1876 L8DCE:
   8DCE 39            [ 5] 1877         rts
                           1878 
                           1879 ; 4 routines to write to the LCD display
                           1880 
                           1881 ; Write to the LCD 1st line - extend past the end of a normal display
   8DCF                    1882 LCDMSG1A:
   8DCF 18 DE 46      [ 5] 1883         ldy     (0x0046)     ; get buffer pointer
   8DD2 86 90         [ 2] 1884         ldaa    #0x90        ; command to set LCD RAM ptr to chr 0x10
   8DD4 20 13         [ 3] 1885         bra     L8DE9  
                           1886 
                           1887 ; Write to the LCD 2st line - extend past the end of a normal display
   8DD6                    1888 LCDMSG2A:
   8DD6 18 DE 46      [ 5] 1889         ldy     (0x0046)     ; get buffer pointer
   8DD9 86 D0         [ 2] 1890         ldaa    #0xD0        ; command to set LCD RAM ptr to chr 0x50
   8DDB 20 0C         [ 3] 1891         bra     L8DE9  
                           1892 
                           1893 ; Write to the LCD 2nd line
   8DDD                    1894 LCDMSG2:
   8DDD 18 DE 46      [ 5] 1895         ldy     (0x0046)     ; get buffer pointer
   8DE0 86 C0         [ 2] 1896         ldaa    #0xC0        ; command to set LCD RAM ptr to chr 0x40
   8DE2 20 05         [ 3] 1897         bra     L8DE9  
                           1898 
                           1899 ; Write to the LCD 1st line
   8DE4                    1900 LCDMSG1:
   8DE4 18 DE 46      [ 5] 1901         ldy     (0x0046)     ; get buffer pointer
   8DE7 86 80         [ 2] 1902         ldaa    #0x80        ; command to load LCD RAM ptr to chr 0x00
                           1903 
                           1904 ; Put LCD command into a buffer, 4 bytes for each entry?
   8DE9                    1905 L8DE9:
   8DE9 18 A7 00      [ 5] 1906         staa    0,Y         ; store command here
   8DEC 18 6F 01      [ 7] 1907         clr     1,Y         ; clear next byte
   8DEF 18 08         [ 4] 1908         iny
   8DF1 18 08         [ 4] 1909         iny
                           1910 
                           1911 ; Add characters at return address to LCD buffer
   8DF3 18 8C 05 80   [ 5] 1912         cpy     #0x0580       ; check for buffer overflow
   8DF7 25 04         [ 3] 1913         bcs     L8DFD  
   8DF9 18 CE 05 00   [ 4] 1914         ldy     #0x0500
   8DFD                    1915 L8DFD:
   8DFD 38            [ 5] 1916         pulx                ; get start of data
   8DFE DF 17         [ 4] 1917         stx     (0x0017)    ; save this here
   8E00                    1918 L8E00:
   8E00 A6 00         [ 4] 1919         ldaa    0,X         ; get character
   8E02 27 36         [ 3] 1920         beq     L8E3A       ; is it 00, if so jump ahead
   8E04 2B 17         [ 3] 1921         bmi     L8E1D       ; high bit set, if so jump ahead
   8E06 18 6F 00      [ 7] 1922         clr     0,Y         ; add character
   8E09 18 A7 01      [ 5] 1923         staa    1,Y     
   8E0C 08            [ 3] 1924         inx
   8E0D 18 08         [ 4] 1925         iny
   8E0F 18 08         [ 4] 1926         iny
   8E11 18 8C 05 80   [ 5] 1927         cpy     #0x0580     ; check for buffer overflow
   8E15 25 E9         [ 3] 1928         bcs     L8E00  
   8E17 18 CE 05 00   [ 4] 1929         ldy     #0x0500
   8E1B 20 E3         [ 3] 1930         bra     L8E00  
                           1931 
   8E1D                    1932 L8E1D:
   8E1D 84 7F         [ 2] 1933         anda    #0x7F
   8E1F 18 6F 00      [ 7] 1934         clr     0,Y          ; add character
   8E22 18 A7 01      [ 5] 1935         staa    1,Y     
   8E25 18 6F 02      [ 7] 1936         clr     2,Y     
   8E28 18 6F 03      [ 7] 1937         clr     3,Y     
   8E2B 08            [ 3] 1938         inx
   8E2C 18 08         [ 4] 1939         iny
   8E2E 18 08         [ 4] 1940         iny
   8E30 18 8C 05 80   [ 5] 1941         cpy     #0x0580       ; check for overflow
   8E34 25 04         [ 3] 1942         bcs     L8E3A  
   8E36 18 CE 05 00   [ 4] 1943         ldy     #0x0500
                           1944 
   8E3A                    1945 L8E3A:
   8E3A 3C            [ 4] 1946         pshx                ; put SP back
   8E3B 86 01         [ 2] 1947         ldaa    #0x01
   8E3D 97 43         [ 3] 1948         staa    (0x0043)    ; semaphore?
   8E3F DC 46         [ 4] 1949         ldd     (0x0046)
   8E41 18 6F 00      [ 7] 1950         clr     0,Y     
   8E44 18 6F 01      [ 7] 1951         clr     1,Y     
   8E47 18 DF 46      [ 5] 1952         sty     (0x0046)     ; save buffer pointer
   8E4A 39            [ 5] 1953         rts
                           1954 
                           1955 ; buffer LCD command?
   8E4B                    1956 L8E4B:
   8E4B 18 DE 46      [ 5] 1957         ldy     (0x0046)
   8E4E 18 A7 00      [ 5] 1958         staa    0,Y     
   8E51 18 6F 01      [ 7] 1959         clr     1,Y     
   8E54 18 08         [ 4] 1960         iny
   8E56 18 08         [ 4] 1961         iny
   8E58 18 8C 05 80   [ 5] 1962         cpy     #0x0580
   8E5C 25 04         [ 3] 1963         bcs     L8E62  
   8E5E 18 CE 05 00   [ 4] 1964         ldy     #0x0500
   8E62                    1965 L8E62:
   8E62 18 6F 00      [ 7] 1966         clr     0,Y     
   8E65 18 6F 01      [ 7] 1967         clr     1,Y     
   8E68 86 01         [ 2] 1968         ldaa    #0x01
   8E6A 97 43         [ 3] 1969         staa    (0x0043)
   8E6C 18 DF 46      [ 5] 1970         sty     (0x0046)
   8E6F 39            [ 5] 1971         rts
                           1972 
   8E70                    1973 L8E70:
   8E70 18 DE 46      [ 5] 1974         ldy     (0x0046)
   8E73 18 6F 00      [ 7] 1975         clr     0,Y     
   8E76 18 A7 01      [ 5] 1976         staa    1,Y     
   8E79 18 08         [ 4] 1977         iny
   8E7B 18 08         [ 4] 1978         iny
   8E7D 18 8C 05 80   [ 5] 1979         cpy     #0x0580
   8E81 25 04         [ 3] 1980         bcs     L8E87  
   8E83 18 CE 05 00   [ 4] 1981         ldy     #0x0500
   8E87                    1982 L8E87:
   8E87 18 6F 00      [ 7] 1983         clr     0,Y     
   8E8A 18 6F 01      [ 7] 1984         clr     1,Y     
   8E8D 86 01         [ 2] 1985         ldaa    #0x01
   8E8F 97 43         [ 3] 1986         staa    (0x0043)
   8E91 18 DF 46      [ 5] 1987         sty     (0x0046)
   8E94 39            [ 5] 1988         rts
                           1989 
   8E95                    1990 L8E95:
   8E95 96 30         [ 3] 1991         ldaa    (0x0030)
   8E97 26 09         [ 3] 1992         bne     L8EA2  
   8E99 96 31         [ 3] 1993         ldaa    (0x0031)
   8E9B 26 11         [ 3] 1994         bne     L8EAE  
   8E9D 96 32         [ 3] 1995         ldaa    (0x0032)
   8E9F 26 19         [ 3] 1996         bne     L8EBA  
   8EA1 39            [ 5] 1997         rts
                           1998 
                           1999 ;;;;;;;;;;;;;;;;;;;;;;;;;;
                           2000 
   8EA2                    2001 L8EA2:
   8EA2 7F 00 30      [ 6] 2002         clr     (0x0030)
   8EA5 7F 00 32      [ 6] 2003         clr     (0x0032)
   8EA8 7F 00 31      [ 6] 2004         clr     (0x0031)
   8EAB 86 01         [ 2] 2005         ldaa    #0x01
   8EAD 39            [ 5] 2006         rts
                           2007 
   8EAE                    2008 L8EAE:
   8EAE 7F 00 31      [ 6] 2009         clr     (0x0031)
   8EB1 7F 00 30      [ 6] 2010         clr     (0x0030)
   8EB4 7F 00 32      [ 6] 2011         clr     (0x0032)
   8EB7 86 02         [ 2] 2012         ldaa    #0x02
   8EB9 39            [ 5] 2013         rts
                           2014 
   8EBA                    2015 L8EBA:
   8EBA 7F 00 32      [ 6] 2016         clr     (0x0032)
   8EBD 7F 00 30      [ 6] 2017         clr     (0x0030)
   8EC0 7F 00 31      [ 6] 2018         clr     (0x0031)
   8EC3 86 0D         [ 2] 2019         ldaa    #0x0D
   8EC5 39            [ 5] 2020         rts
                           2021 
   8EC6                    2022 L8EC6:
   8EC6 B6 18 04      [ 4] 2023         ldaa    PIA0PRA 
   8EC9 84 07         [ 2] 2024         anda    #0x07
   8ECB 97 2C         [ 3] 2025         staa    (0x002C)
   8ECD 78 00 2C      [ 6] 2026         asl     (0x002C)
   8ED0 78 00 2C      [ 6] 2027         asl     (0x002C)
   8ED3 78 00 2C      [ 6] 2028         asl     (0x002C)
   8ED6 78 00 2C      [ 6] 2029         asl     (0x002C)
   8ED9 78 00 2C      [ 6] 2030         asl     (0x002C)
   8EDC CE 00 00      [ 3] 2031         ldx     #0x0000
   8EDF                    2032 L8EDF:
   8EDF 8C 00 03      [ 4] 2033         cpx     #0x0003
   8EE2 27 24         [ 3] 2034         beq     L8F08  
   8EE4 78 00 2C      [ 6] 2035         asl     (0x002C)
   8EE7 25 12         [ 3] 2036         bcs     L8EFB  
   8EE9 A6 2D         [ 4] 2037         ldaa    0x2D,X
   8EEB 81 0F         [ 2] 2038         cmpa    #0x0F
   8EED 24 1A         [ 3] 2039         bcc     L8F09  
   8EEF 6C 2D         [ 6] 2040         inc     0x2D,X
   8EF1 A6 2D         [ 4] 2041         ldaa    0x2D,X
   8EF3 81 02         [ 2] 2042         cmpa    #0x02
   8EF5 26 02         [ 3] 2043         bne     L8EF9  
   8EF7 A7 30         [ 4] 2044         staa    0x30,X
   8EF9                    2045 L8EF9:
   8EF9 20 0A         [ 3] 2046         bra     L8F05  
   8EFB                    2047 L8EFB:
   8EFB 6F 2D         [ 6] 2048         clr     0x2D,X
   8EFD 20 06         [ 3] 2049         bra     L8F05  
   8EFF A6 2D         [ 4] 2050         ldaa    0x2D,X
   8F01 27 02         [ 3] 2051         beq     L8F05  
   8F03 6A 2D         [ 6] 2052         dec     0x2D,X
   8F05                    2053 L8F05:
   8F05 08            [ 3] 2054         inx
   8F06 20 D7         [ 3] 2055         bra     L8EDF  
   8F08                    2056 L8F08:
   8F08 39            [ 5] 2057         rts
                           2058 
   8F09                    2059 L8F09:
   8F09 8C 00 02      [ 4] 2060         cpx     #0x0002
   8F0C 27 02         [ 3] 2061         beq     L8F10  
   8F0E 6F 2D         [ 6] 2062         clr     0x2D,X
   8F10                    2063 L8F10:
   8F10 20 F3         [ 3] 2064         bra     L8F05
                           2065 
   8F12                    2066 L8F12:
   8F12 B6 10 0A      [ 4] 2067         ldaa    PORTE
   8F15 97 51         [ 3] 2068         staa    (0x0051)
   8F17 CE 00 00      [ 3] 2069         ldx     #0x0000
   8F1A                    2070 L8F1A:
   8F1A 8C 00 08      [ 4] 2071         cpx     #0x0008
   8F1D 27 22         [ 3] 2072         beq     L8F41  
   8F1F 77 00 51      [ 6] 2073         asr     (0x0051)
   8F22 25 10         [ 3] 2074         bcs     L8F34  
   8F24 A6 52         [ 4] 2075         ldaa    0x52,X
   8F26 81 0F         [ 2] 2076         cmpa    #0x0F
   8F28 6C 52         [ 6] 2077         inc     0x52,X
   8F2A A6 52         [ 4] 2078         ldaa    0x52,X
   8F2C 81 04         [ 2] 2079         cmpa    #0x04
   8F2E 26 02         [ 3] 2080         bne     L8F32  
   8F30 A7 5A         [ 4] 2081         staa    0x5A,X
   8F32                    2082 L8F32:
   8F32 20 0A         [ 3] 2083         bra     L8F3E  
   8F34                    2084 L8F34:
   8F34 6F 52         [ 6] 2085         clr     0x52,X
   8F36 20 06         [ 3] 2086         bra     L8F3E  
   8F38 A6 52         [ 4] 2087         ldaa    0x52,X
   8F3A 27 02         [ 3] 2088         beq     L8F3E  
   8F3C 6A 52         [ 6] 2089         dec     0x52,X
   8F3E                    2090 L8F3E:
   8F3E 08            [ 3] 2091         inx
   8F3F 20 D9         [ 3] 2092         bra     L8F1A  
   8F41                    2093 L8F41:
   8F41 39            [ 5] 2094         rts
                           2095 
   8F42 6F 52         [ 6] 2096         clr     0x52,X
   8F44 20 F8         [ 3] 2097         bra     L8F3E  
                           2098 
   8F46                    2099 L8F46:
   8F46 30 2E 35           2100         .ascii      '0.5'
   8F49 31 2E 30           2101         .ascii      '1.0'
   8F4C 31 2E 35           2102         .ascii      '1.5'
   8F4F 32 2E 30           2103         .ascii      '2.0'
   8F52 32 2E 35           2104         .ascii      '2.5'
   8F55 33 2E 30           2105         .ascii      '3.0'
                           2106 
   8F58                    2107 L8F58:
   8F58 3C            [ 4] 2108         pshx
   8F59 96 12         [ 3] 2109         ldaa    (0x0012)
   8F5B 80 01         [ 2] 2110         suba    #0x01
   8F5D C6 03         [ 2] 2111         ldab    #0x03
   8F5F 3D            [10] 2112         mul
   8F60 CE 8F 46      [ 3] 2113         ldx     #L8F46
   8F63 3A            [ 3] 2114         abx
   8F64 C6 2C         [ 2] 2115         ldab    #0x2C
   8F66                    2116 L8F66:
   8F66 A6 00         [ 4] 2117         ldaa    0,X     
   8F68 08            [ 3] 2118         inx
   8F69 BD 8D B5      [ 6] 2119         jsr     L8DB5         ; display char here on LCD display
   8F6C 5C            [ 2] 2120         incb
   8F6D C1 2F         [ 2] 2121         cmpb    #0x2F
   8F6F 26 F5         [ 3] 2122         bne     L8F66  
   8F71 38            [ 5] 2123         pulx
   8F72 39            [ 5] 2124         rts
                           2125 
   8F73                    2126 L8F73:
   8F73 36            [ 3] 2127         psha
   8F74 BD 8C F2      [ 6] 2128         jsr     L8CF2
   8F77 C6 02         [ 2] 2129         ldab    #0x02
   8F79 BD 8C 30      [ 6] 2130         jsr     DLYSECSBY2   
   8F7C 32            [ 4] 2131         pula
   8F7D 97 B4         [ 3] 2132         staa    (0x00B4)
   8F7F 81 03         [ 2] 2133         cmpa    #0x03
   8F81 26 11         [ 3] 2134         bne     L8F94  
                           2135 
   8F83 BD 8D E4      [ 6] 2136         jsr     LCDMSG1 
   8F86 43 68 75 63 6B 20  2137         .ascis  'Chuck    '
        20 20 A0
                           2138 
   8F8F CE 90 72      [ 3] 2139         ldx     #L9072
   8F92 20 4D         [ 3] 2140         bra     L8FE1  
   8F94                    2141 L8F94:
   8F94 81 04         [ 2] 2142         cmpa    #0x04
   8F96 26 11         [ 3] 2143         bne     L8FA9  
                           2144 
   8F98 BD 8D E4      [ 6] 2145         jsr     LCDMSG1 
   8F9B 4A 61 73 70 65 72  2146         .ascis  'Jasper   '
        20 20 A0
                           2147 
   8FA4 CE 90 DE      [ 3] 2148         ldx     #0x90DE
   8FA7 20 38         [ 3] 2149         bra     L8FE1  
   8FA9                    2150 L8FA9:
   8FA9 81 05         [ 2] 2151         cmpa    #0x05
   8FAB 26 11         [ 3] 2152         bne     L8FBE  
                           2153 
   8FAD BD 8D E4      [ 6] 2154         jsr     LCDMSG1 
   8FB0 50 61 73 71 75 61  2155         .ascis  'Pasqually'
        6C 6C F9
                           2156 
   8FB9 CE 91 45      [ 3] 2157         ldx     #0x9145
   8FBC 20 23         [ 3] 2158         bra     L8FE1  
   8FBE                    2159 L8FBE:
   8FBE 81 06         [ 2] 2160         cmpa    #0x06
   8FC0 26 11         [ 3] 2161         bne     L8FD3  
                           2162 
   8FC2 BD 8D E4      [ 6] 2163         jsr     LCDMSG1 
   8FC5 4D 75 6E 63 68 20  2164         .ascis  'Munch    '
        20 20 A0
                           2165 
   8FCE CE 91 BA      [ 3] 2166         ldx     #0x91BA
   8FD1 20 0E         [ 3] 2167         bra     L8FE1  
   8FD3                    2168 L8FD3:
   8FD3 BD 8D E4      [ 6] 2169         jsr     LCDMSG1 
   8FD6 48 65 6C 65 6E 20  2170         .ascis  'Helen   '
        20 A0
                           2171 
   8FDE CE 92 26      [ 3] 2172         ldx     #0x9226
   8FE1                    2173 L8FE1:
   8FE1 96 B4         [ 3] 2174         ldaa    (0x00B4)
   8FE3 80 03         [ 2] 2175         suba    #0x03
   8FE5 48            [ 2] 2176         asla
   8FE6 48            [ 2] 2177         asla
   8FE7 97 4B         [ 3] 2178         staa    (0x004B)
   8FE9 BD 95 04      [ 6] 2179         jsr     L9504
   8FEC 97 4C         [ 3] 2180         staa    (0x004C)
   8FEE 81 0F         [ 2] 2181         cmpa    #0x0F
   8FF0 26 01         [ 3] 2182         bne     L8FF3  
   8FF2 39            [ 5] 2183         rts
                           2184 
   8FF3                    2185 L8FF3:
   8FF3 81 08         [ 2] 2186         cmpa    #0x08
   8FF5 23 08         [ 3] 2187         bls     L8FFF  
   8FF7 80 08         [ 2] 2188         suba    #0x08
   8FF9 D6 4B         [ 3] 2189         ldab    (0x004B)
   8FFB CB 02         [ 2] 2190         addb    #0x02
   8FFD D7 4B         [ 3] 2191         stab    (0x004B)
   8FFF                    2192 L8FFF:
   8FFF 36            [ 3] 2193         psha
   9000 18 DE 46      [ 5] 2194         ldy     (0x0046)
   9003 32            [ 4] 2195         pula
   9004 5F            [ 2] 2196         clrb
   9005 0D            [ 2] 2197         sec
   9006                    2198 L9006:
   9006 59            [ 2] 2199         rolb
   9007 4A            [ 2] 2200         deca
   9008 26 FC         [ 3] 2201         bne     L9006  
   900A D7 50         [ 3] 2202         stab    (0x0050)
   900C D6 4B         [ 3] 2203         ldab    (0x004B)
   900E CE 10 80      [ 3] 2204         ldx     #0x1080
   9011 3A            [ 3] 2205         abx
   9012 86 02         [ 2] 2206         ldaa    #0x02
   9014 97 12         [ 3] 2207         staa    (0x0012)
   9016                    2208 L9016:
   9016 A6 00         [ 4] 2209         ldaa    0,X     
   9018 98 50         [ 3] 2210         eora    (0x0050)
   901A A7 00         [ 4] 2211         staa    0,X     
   901C 6D 00         [ 6] 2212         tst     0,X     
   901E 27 16         [ 3] 2213         beq     L9036  
   9020 86 4F         [ 2] 2214         ldaa    #0x4F            ;'O'
   9022 C6 0C         [ 2] 2215         ldab    #0x0C        
   9024 BD 8D B5      [ 6] 2216         jsr     L8DB5            ; display char here on LCD display
   9027 86 6E         [ 2] 2217         ldaa    #0x6E            ;'n'
   9029 C6 0D         [ 2] 2218         ldab    #0x0D
   902B BD 8D B5      [ 6] 2219         jsr     L8DB5            ; display char here on LCD display
   902E CC 20 0E      [ 3] 2220         ldd     #0x200E          ;' '
   9031 BD 8D B5      [ 6] 2221         jsr     L8DB5            ; display char here on LCD display
   9034 20 0E         [ 3] 2222         bra     L9044  
   9036                    2223 L9036:
   9036 86 66         [ 2] 2224         ldaa    #0x66            ;'f'
   9038 C6 0D         [ 2] 2225         ldab    #0x0D
   903A BD 8D B5      [ 6] 2226         jsr     L8DB5            ; display char here on LCD display
   903D 86 66         [ 2] 2227         ldaa    #0x66            ;'f'
   903F C6 0E         [ 2] 2228         ldab    #0x0E
   9041 BD 8D B5      [ 6] 2229         jsr     L8DB5            ; display char here on LCD display
   9044                    2230 L9044:
   9044 D6 12         [ 3] 2231         ldab    (0x0012)
   9046 BD 8C 30      [ 6] 2232         jsr     DLYSECSBY2            ; delay in half-seconds
   9049 BD 8E 95      [ 6] 2233         jsr     L8E95
   904C 81 0D         [ 2] 2234         cmpa    #0x0D
   904E 27 14         [ 3] 2235         beq     L9064  
   9050 20 C4         [ 3] 2236         bra     L9016  
   9052 81 02         [ 2] 2237         cmpa    #0x02
   9054 26 C0         [ 3] 2238         bne     L9016  
   9056 96 12         [ 3] 2239         ldaa    (0x0012)
   9058 81 06         [ 2] 2240         cmpa    #0x06
   905A 27 BA         [ 3] 2241         beq     L9016  
   905C 4C            [ 2] 2242         inca
   905D 97 12         [ 3] 2243         staa    (0x0012)
   905F BD 8F 58      [ 6] 2244         jsr     L8F58
   9062 20 B2         [ 3] 2245         bra     L9016  
   9064                    2246 L9064:
   9064 A6 00         [ 4] 2247         ldaa    0,X     
   9066 9A 50         [ 3] 2248         oraa    (0x0050)
   9068 98 50         [ 3] 2249         eora    (0x0050)
   906A A7 00         [ 4] 2250         staa    0,X     
   906C 96 B4         [ 3] 2251         ldaa    (0x00B4)
   906E 7E 8F 73      [ 3] 2252         jmp     L8F73
   9071 39            [ 5] 2253         rts
                           2254 
   9072                    2255 L9072:
   9072 4D 6F 75 74 68 2C  2256         .ascis  'Mouth,Head left,Head right,Head up,Eyes right,Eyelids,Right hand,Eyes left,DS9,DS10,DS11,DS12,DS13,DS14,Exit'
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
   90DE 4D 6F 75 74 68 2C  2257         .ascis  'Mouth,Head left,Head right,Head up,Eyes right,Eyelids,Hands,Eyes left,DS9,DS10,DS11,DS12,DS13,DS14,Exit'
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
   9145 4D 6F 75 74 68 2D  2258         .ascis  'Mouth-Mustache,Head left,Head right,Left arm,Eyes right,Eyelids,Right arm,Eyes left,DS9,DS10,DS11,DS12,DS13,DS14,Exit'
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
   91BA 4D 6F 75 74 68 2C  2259         .ascis  'Mouth,Head left,Head right,Left arm,Eyes right,Eyelids,Right arm,Eyes left,DS9,DS10,DS11,DS12,DS13,DS14,Exit'
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
   9226 4D 6F 75 74 68 2C  2260         .ascis  'Mouth,Head left,Head right,Head up,Eyes right,Eyelids,Right hand,Eyes left,DS9,DS10,DS11,DS12,DS13,DS14,Exit'
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
                           2261         
                           2262 ; code again
   9292                    2263 L9292:
   9292 BD 86 C4      [ 6] 2264         jsr     L86C4                ; Reset boards 1-10
   9295                    2265 L9295:
   9295 C6 01         [ 2] 2266         ldab    #0x01
   9297 BD 8C 30      [ 6] 2267         jsr     DLYSECSBY2           ; delay 0.5 sec
                           2268 
   929A BD 8D E4      [ 6] 2269         jsr     LCDMSG1 
   929D 20 20 44 69 61 67  2270         .ascis  '  Diagnostics   '
        6E 6F 73 74 69 63
        73 20 20 A0
                           2271 
   92AD BD 8D DD      [ 6] 2272         jsr     LCDMSG2 
   92B0 20 20 20 20 20 20  2273         .ascis  '                '
        20 20 20 20 20 20
        20 20 20 A0
                           2274 
   92C0 C6 01         [ 2] 2275         ldab    #0x01
   92C2 BD 8C 30      [ 6] 2276         jsr     DLYSECSBY2           ; delay 0.5 sec
   92C5 BD 8D 03      [ 6] 2277         jsr     L8D03
   92C8 CE 93 D3      [ 3] 2278         ldx     #L93D3
   92CB BD 95 04      [ 6] 2279         jsr     L9504
   92CE 81 11         [ 2] 2280         cmpa    #0x11
   92D0 26 14         [ 3] 2281         bne     L92E6
   92D2                    2282 L92D2:
   92D2 BD 86 C4      [ 6] 2283         jsr     L86C4               ; Reset boards 1-10
   92D5 5F            [ 2] 2284         clrb
   92D6 D7 62         [ 3] 2285         stab    (0x0062)
   92D8 BD F9 C5      [ 6] 2286         jsr     BUTNLIT 
   92DB B6 18 04      [ 4] 2287         ldaa    PIA0PRA 
   92DE 84 BF         [ 2] 2288         anda    #0xBF
   92E0 B7 18 04      [ 4] 2289         staa    PIA0PRA 
   92E3 7E 81 D7      [ 3] 2290         jmp     L81D7
   92E6                    2291 L92E6:
   92E6 81 03         [ 2] 2292         cmpa    #0x03
   92E8 25 09         [ 3] 2293         bcs     L92F3  
   92EA 81 08         [ 2] 2294         cmpa    #0x08
   92EC 24 05         [ 3] 2295         bcc     L92F3  
   92EE BD 8F 73      [ 6] 2296         jsr     L8F73
   92F1 20 A2         [ 3] 2297         bra     L9295  
   92F3                    2298 L92F3:
   92F3 81 02         [ 2] 2299         cmpa    #0x02
   92F5 26 08         [ 3] 2300         bne     L92FF  
   92F7 BD 9F 1E      [ 6] 2301         jsr     L9F1E
   92FA 25 99         [ 3] 2302         bcs     L9295  
   92FC 7E 96 75      [ 3] 2303         jmp     L9675
   92FF                    2304 L92FF:
   92FF 81 0B         [ 2] 2305         cmpa    #0x0B
   9301 26 0D         [ 3] 2306         bne     L9310  
   9303 BD 8D 03      [ 6] 2307         jsr     L8D03
   9306 BD 9E CC      [ 6] 2308         jsr     L9ECC
   9309 C6 03         [ 2] 2309         ldab    #0x03
   930B BD 8C 30      [ 6] 2310         jsr     DLYSECSBY2           ; delay 1.5 sec
   930E 20 85         [ 3] 2311         bra     L9295  
   9310                    2312 L9310:
   9310 81 09         [ 2] 2313         cmpa    #0x09
   9312 26 0E         [ 3] 2314         bne     L9322  
   9314 BD 9F 1E      [ 6] 2315         jsr     L9F1E
   9317 24 03         [ 3] 2316         bcc     L931C  
   9319 7E 92 95      [ 3] 2317         jmp     L9295
   931C                    2318 L931C:
   931C BD 9E 92      [ 6] 2319         jsr     L9E92               ; reset R counts
   931F 7E 92 95      [ 3] 2320         jmp     L9295
   9322                    2321 L9322:
   9322 81 0A         [ 2] 2322         cmpa    #0x0A
   9324 26 0B         [ 3] 2323         bne     L9331  
   9326 BD 9F 1E      [ 6] 2324         jsr     L9F1E
   9329 25 03         [ 3] 2325         bcs     L932E  
   932B BD 9E AF      [ 6] 2326         jsr     L9EAF               ; reset L counts
   932E                    2327 L932E:
   932E 7E 92 95      [ 3] 2328         jmp     L9295
   9331                    2329 L9331:
   9331 81 01         [ 2] 2330         cmpa    #0x01
   9333 26 03         [ 3] 2331         bne     L9338  
   9335 7E A0 E9      [ 3] 2332         jmp     LA0E9
   9338                    2333 L9338:
   9338 81 08         [ 2] 2334         cmpa    #0x08
   933A 26 1F         [ 3] 2335         bne     L935B  
   933C BD 9F 1E      [ 6] 2336         jsr     L9F1E
   933F 25 1A         [ 3] 2337         bcs     L935B  
                           2338 
   9341 BD 8D E4      [ 6] 2339         jsr     LCDMSG1 
   9344 52 65 73 65 74 20  2340         .ascis  'Reset System!'
        53 79 73 74 65 6D
        A1
                           2341 
   9351 7E A2 49      [ 3] 2342         jmp     LA249
   9354 C6 02         [ 2] 2343         ldab    #0x02
   9356 BD 8C 30      [ 6] 2344         jsr     DLYSECSBY2           ; delay 1 sec
   9359 20 18         [ 3] 2345         bra     L9373  
   935B                    2346 L935B:
   935B 81 0C         [ 2] 2347         cmpa    #0x0C
   935D 26 14         [ 3] 2348         bne     L9373  
   935F BD 8B 48      [ 6] 2349         jsr     L8B48
   9362 5F            [ 2] 2350         clrb
   9363 D7 62         [ 3] 2351         stab    (0x0062)
   9365 BD F9 C5      [ 6] 2352         jsr     BUTNLIT 
   9368 B6 18 04      [ 4] 2353         ldaa    PIA0PRA 
   936B 84 BF         [ 2] 2354         anda    #0xBF
   936D B7 18 04      [ 4] 2355         staa    PIA0PRA 
   9370 7E 92 92      [ 3] 2356         jmp     L9292
   9373                    2357 L9373:
   9373 81 0D         [ 2] 2358         cmpa    #0x0D
   9375 26 2E         [ 3] 2359         bne     L93A5  
   9377 BD 8C E9      [ 6] 2360         jsr     L8CE9
                           2361 
   937A BD 8D E4      [ 6] 2362         jsr     LCDMSG1 
   937D 20 20 42 75 74 74  2363         .ascis  '  Button  test'
        6F 6E 20 20 74 65
        73 F4
                           2364 
   938B BD 8D DD      [ 6] 2365         jsr     LCDMSG2 
   938E 20 20 20 50 52 4F  2366         .ascis  '   PROG exits'
        47 20 65 78 69 74
        F3
                           2367 
   939B BD A5 26      [ 6] 2368         jsr     LA526
   939E 5F            [ 2] 2369         clrb
   939F BD F9 C5      [ 6] 2370         jsr     BUTNLIT 
   93A2 7E 92 95      [ 3] 2371         jmp     L9295
   93A5                    2372 L93A5:
   93A5 81 0E         [ 2] 2373         cmpa    #0x0E
   93A7 26 10         [ 3] 2374         bne     L93B9  
   93A9 BD 9F 1E      [ 6] 2375         jsr     L9F1E
   93AC 24 03         [ 3] 2376         bcc     L93B1  
   93AE 7E 92 95      [ 3] 2377         jmp     L9295
   93B1                    2378 L93B1:
   93B1 C6 01         [ 2] 2379         ldab    #0x01
   93B3 BD 8C 30      [ 6] 2380         jsr     DLYSECSBY2           ; delay 0.5 sec
   93B6 7E 94 9A      [ 3] 2381         jmp     L949A
   93B9                    2382 L93B9:
   93B9 81 0F         [ 2] 2383         cmpa    #0x0F
   93BB 26 06         [ 3] 2384         bne     L93C3  
   93BD BD A8 6A      [ 6] 2385         jsr     LA86A
   93C0 7E 92 95      [ 3] 2386         jmp     L9295
   93C3                    2387 L93C3:
   93C3 81 10         [ 2] 2388         cmpa    #0x10
   93C5 26 09         [ 3] 2389         bne     L93D0  
   93C7 BD 9F 1E      [ 6] 2390         jsr     L9F1E
   93CA BD 95 BA      [ 6] 2391         jsr     L95BA
   93CD 7E 92 95      [ 3] 2392         jmp     L9295
                           2393 
   93D0                    2394 L93D0:
   93D0 7E 92 D2      [ 3] 2395         jmp     L92D2
                           2396 
   93D3                    2397 L93D3:
   93D3 56 43 52 20 61 64  2398         .ascis  "VCR adjust,Set Random,Chuck E. Cheese,Jasper,Pasqually,Munch,Helen,Reset System,Reset reg tape#,Reset liv tape#,View Tape #'s,All Lights On,Button test,King enable,Warm-Up,Show Type,Quit Diagnostics"
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
   9499 00                 2399         .byte   0x00
                           2400 
   949A                    2401 L949A:
   949A 7D 04 2A      [ 6] 2402         tst     (0x042A)
   949D 27 27         [ 3] 2403         beq     L94C6  
                           2404 
   949F BD 8D E4      [ 6] 2405         jsr     LCDMSG1 
   94A2 4B 69 6E 67 20 69  2406         .ascis  'King is Enabled'
        73 20 45 6E 61 62
        6C 65 E4
                           2407 
   94B1 BD 8D DD      [ 6] 2408         jsr     LCDMSG2 
   94B4 45 4E 54 45 52 20  2409         .ascis  'ENTER to disable'
        74 6F 20 64 69 73
        61 62 6C E5
                           2410 
   94C4 20 25         [ 3] 2411         bra     L94EB  
                           2412 
   94C6                    2413 L94C6:
   94C6 BD 8D E4      [ 6] 2414         jsr     LCDMSG1 
   94C9 4B 69 6E 67 20 69  2415         .ascis  'King is Disabled'
        73 20 44 69 73 61
        62 6C 65 E4
                           2416 
   94D9 BD 8D DD      [ 6] 2417         jsr     LCDMSG2 
   94DC 45 4E 54 45 52 20  2418         .ascis  'ENTER to enable'
        74 6F 20 65 6E 61
        62 6C E5
                           2419 
   94EB                    2420 L94EB:
   94EB BD 8E 95      [ 6] 2421         jsr     L8E95
   94EE 4D            [ 2] 2422         tsta
   94EF 27 FA         [ 3] 2423         beq     L94EB  
   94F1 81 0D         [ 2] 2424         cmpa    #0x0D
   94F3 27 02         [ 3] 2425         beq     L94F7  
   94F5 20 0A         [ 3] 2426         bra     L9501  
   94F7                    2427 L94F7:
   94F7 B6 04 2A      [ 4] 2428         ldaa    (0x042A)
   94FA 84 01         [ 2] 2429         anda    #0x01
   94FC 88 01         [ 2] 2430         eora    #0x01
   94FE B7 04 2A      [ 4] 2431         staa    (0x042A)
   9501                    2432 L9501:
   9501 7E 92 95      [ 3] 2433         jmp     L9295
   9504                    2434 L9504:
   9504 86 01         [ 2] 2435         ldaa    #0x01
   9506 97 A6         [ 3] 2436         staa    (0x00A6)
   9508 97 A7         [ 3] 2437         staa    (0x00A7)
   950A DF 12         [ 4] 2438         stx     (0x0012)
   950C 20 09         [ 3] 2439         bra     L9517  
   950E 86 01         [ 2] 2440         ldaa    #0x01
   9510 97 A7         [ 3] 2441         staa    (0x00A7)
   9512 7F 00 A6      [ 6] 2442         clr     (0x00A6)
   9515 DF 12         [ 4] 2443         stx     (0x0012)
   9517                    2444 L9517:
   9517 7F 00 16      [ 6] 2445         clr     (0x0016)
   951A 18 DE 46      [ 5] 2446         ldy     (0x0046)
   951D 7D 00 A6      [ 6] 2447         tst     (0x00A6)
   9520 26 07         [ 3] 2448         bne     L9529  
   9522 BD 8C F2      [ 6] 2449         jsr     L8CF2
   9525 86 80         [ 2] 2450         ldaa    #0x80
   9527 20 05         [ 3] 2451         bra     L952E  
   9529                    2452 L9529:
   9529 BD 8D 03      [ 6] 2453         jsr     L8D03
   952C 86 C0         [ 2] 2454         ldaa    #0xC0
   952E                    2455 L952E:
   952E 18 A7 00      [ 5] 2456         staa    0,Y     
   9531 18 6F 01      [ 7] 2457         clr     1,Y     
   9534 18 08         [ 4] 2458         iny
   9536 18 08         [ 4] 2459         iny
   9538 18 8C 05 80   [ 5] 2460         cpy     #0x0580
   953C 25 04         [ 3] 2461         bcs     L9542  
   953E 18 CE 05 00   [ 4] 2462         ldy     #0x0500
   9542                    2463 L9542:
   9542 DF 14         [ 4] 2464         stx     (0x0014)
   9544                    2465 L9544:
   9544 A6 00         [ 4] 2466         ldaa    0,X     
   9546 2A 04         [ 3] 2467         bpl     L954C  
   9548 C6 01         [ 2] 2468         ldab    #0x01
   954A D7 16         [ 3] 2469         stab    (0x0016)
   954C                    2470 L954C:
   954C 81 2C         [ 2] 2471         cmpa    #0x2C
   954E 27 1E         [ 3] 2472         beq     L956E  
   9550 18 6F 00      [ 7] 2473         clr     0,Y     
   9553 84 7F         [ 2] 2474         anda    #0x7F
   9555 18 A7 01      [ 5] 2475         staa    1,Y     
   9558 18 08         [ 4] 2476         iny
   955A 18 08         [ 4] 2477         iny
   955C 18 8C 05 80   [ 5] 2478         cpy     #0x0580
   9560 25 04         [ 3] 2479         bcs     L9566  
   9562 18 CE 05 00   [ 4] 2480         ldy     #0x0500
   9566                    2481 L9566:
   9566 7D 00 16      [ 6] 2482         tst     (0x0016)
   9569 26 03         [ 3] 2483         bne     L956E  
   956B 08            [ 3] 2484         inx
   956C 20 D6         [ 3] 2485         bra     L9544  
   956E                    2486 L956E:
   956E 08            [ 3] 2487         inx
   956F 86 01         [ 2] 2488         ldaa    #0x01
   9571 97 43         [ 3] 2489         staa    (0x0043)
   9573 18 6F 00      [ 7] 2490         clr     0,Y     
   9576 18 6F 01      [ 7] 2491         clr     1,Y     
   9579 18 DF 46      [ 5] 2492         sty     (0x0046)
   957C                    2493 L957C:
   957C BD 8E 95      [ 6] 2494         jsr     L8E95
   957F 27 FB         [ 3] 2495         beq     L957C  
   9581 81 02         [ 2] 2496         cmpa    #0x02
   9583 26 0A         [ 3] 2497         bne     L958F  
   9585 7D 00 16      [ 6] 2498         tst     (0x0016)
   9588 26 05         [ 3] 2499         bne     L958F  
   958A 7C 00 A7      [ 6] 2500         inc     (0x00A7)
   958D 20 88         [ 3] 2501         bra     L9517  
   958F                    2502 L958F:
   958F 81 01         [ 2] 2503         cmpa    #0x01
   9591 26 20         [ 3] 2504         bne     L95B3  
   9593 18 DE 14      [ 5] 2505         ldy     (0x0014)
   9596 18 9C 12      [ 6] 2506         cpy     (0x0012)
   9599 23 E1         [ 3] 2507         bls     L957C  
   959B 7A 00 A7      [ 6] 2508         dec     (0x00A7)
   959E DE 14         [ 4] 2509         ldx     (0x0014)
   95A0 09            [ 3] 2510         dex
   95A1                    2511 L95A1:
   95A1 09            [ 3] 2512         dex
   95A2 9C 12         [ 5] 2513         cpx     (0x0012)
   95A4 26 03         [ 3] 2514         bne     L95A9  
   95A6 7E 95 17      [ 3] 2515         jmp     L9517
   95A9                    2516 L95A9:
   95A9 A6 00         [ 4] 2517         ldaa    0,X     
   95AB 81 2C         [ 2] 2518         cmpa    #0x2C
   95AD 26 F2         [ 3] 2519         bne     L95A1  
   95AF 08            [ 3] 2520         inx
   95B0 7E 95 17      [ 3] 2521         jmp     L9517
   95B3                    2522 L95B3:
   95B3 81 0D         [ 2] 2523         cmpa    #0x0D
   95B5 26 C5         [ 3] 2524         bne     L957C  
   95B7 96 A7         [ 3] 2525         ldaa    (0x00A7)
   95B9 39            [ 5] 2526         rts
                           2527 
   95BA                    2528 L95BA:
   95BA B6 04 5C      [ 4] 2529         ldaa    (0x045C)
   95BD 27 14         [ 3] 2530         beq     L95D3  
                           2531 
   95BF BD 8D E4      [ 6] 2532         jsr     LCDMSG1 
   95C2 43 75 72 72 65 6E  2533         .ascis  'Current: CNR   '
        74 3A 20 43 4E 52
        20 20 A0
                           2534 
   95D1 20 12         [ 3] 2535         bra     L95E5  
                           2536 
   95D3                    2537 L95D3:
   95D3 BD 8D E4      [ 6] 2538         jsr     LCDMSG1 
   95D6 43 75 72 72 65 6E  2539         .ascis  'Current: R12   '
        74 3A 20 52 31 32
        20 20 A0
                           2540 
   95E5                    2541 L95E5:
   95E5 BD 8D DD      [ 6] 2542         jsr     LCDMSG2 
   95E8 3C 45 6E 74 65 72  2543         .ascis  '<Enter> to chg.'
        3E 20 74 6F 20 63
        68 67 AE
                           2544 
   95F7                    2545 L95F7:
   95F7 BD 8E 95      [ 6] 2546         jsr     L8E95
   95FA 27 FB         [ 3] 2547         beq     L95F7  
   95FC 81 0D         [ 2] 2548         cmpa    #0x0D
   95FE 26 0F         [ 3] 2549         bne     L960F  
   9600 B6 04 5C      [ 4] 2550         ldaa    (0x045C)
   9603 27 05         [ 3] 2551         beq     L960A  
   9605 7F 04 5C      [ 6] 2552         clr     (0x045C)
   9608 20 05         [ 3] 2553         bra     L960F  
   960A                    2554 L960A:
   960A 86 01         [ 2] 2555         ldaa    #0x01
   960C B7 04 5C      [ 4] 2556         staa    (0x045C)
   960F                    2557 L960F:
   960F 39            [ 5] 2558         rts
                           2559 
   9610                    2560 L9610:
   9610 43 68 75 63 6B 2C  2561         .ascis  "Chuck,Jasper,Pasqually,Munch,Helen,Light 1,Light 2,Light 3,Star EFX,Wink Spot,Gobo,Clear All Rnd,Exit"
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
                           2562 
   9675                    2563 L9675:
   9675 BD 8D E4      [ 6] 2564         jsr     LCDMSG1 
   9678 52 61 6E 64 6F 6D  2565         .ascis  'Random          '
        20 20 20 20 20 20
        20 20 20 A0
                           2566 
   9688 CE 96 10      [ 3] 2567         ldx     #L9610
   968B BD 95 04      [ 6] 2568         jsr     L9504
   968E 5F            [ 2] 2569         clrb
   968F 37            [ 3] 2570         pshb
   9690 81 0D         [ 2] 2571         cmpa    #0x0D
   9692 26 03         [ 3] 2572         bne     L9697  
   9694 7E 97 5B      [ 3] 2573         jmp     L975B
   9697                    2574 L9697:
   9697 81 0C         [ 2] 2575         cmpa    #0x0C
   9699 26 21         [ 3] 2576         bne     L96BC  
   969B 7F 04 01      [ 6] 2577         clr     (0x0401)
   969E 7F 04 2B      [ 6] 2578         clr     (0x042B)
                           2579 
   96A1 BD 8D E4      [ 6] 2580         jsr     LCDMSG1 
   96A4 41 6C 6C 20 52 6E  2581         .ascis  'All Rnd Cleared!'
        64 20 43 6C 65 61
        72 65 64 A1
                           2582 
   96B4 C6 64         [ 2] 2583         ldab    #0x64       ; delay 1 sec
   96B6 BD 8C 22      [ 6] 2584         jsr     DLYSECSBY100
   96B9 7E 97 5B      [ 3] 2585         jmp     L975B
   96BC                    2586 L96BC:
   96BC 81 09         [ 2] 2587         cmpa    #0x09
   96BE 25 05         [ 3] 2588         bcs     L96C5  
   96C0 80 08         [ 2] 2589         suba    #0x08
   96C2 33            [ 4] 2590         pulb
   96C3 5C            [ 2] 2591         incb
   96C4 37            [ 3] 2592         pshb
   96C5                    2593 L96C5:
   96C5 5F            [ 2] 2594         clrb
   96C6 0D            [ 2] 2595         sec
   96C7                    2596 L96C7:
   96C7 59            [ 2] 2597         rolb
   96C8 4A            [ 2] 2598         deca
   96C9 26 FC         [ 3] 2599         bne     L96C7  
   96CB D7 12         [ 3] 2600         stab    (0x0012)
   96CD C8 FF         [ 2] 2601         eorb    #0xFF
   96CF D7 13         [ 3] 2602         stab    (0x0013)
   96D1                    2603 L96D1:
   96D1 CC 20 34      [ 3] 2604         ldd     #0x2034           ;' '
   96D4 BD 8D B5      [ 6] 2605         jsr     L8DB5            ; display char here on LCD display
   96D7 33            [ 4] 2606         pulb
   96D8 37            [ 3] 2607         pshb
   96D9 5D            [ 2] 2608         tstb
   96DA 27 05         [ 3] 2609         beq     L96E1  
   96DC B6 04 2B      [ 4] 2610         ldaa    (0x042B)
   96DF 20 03         [ 3] 2611         bra     L96E4  
   96E1                    2612 L96E1:
   96E1 B6 04 01      [ 4] 2613         ldaa    (0x0401)
   96E4                    2614 L96E4:
   96E4 94 12         [ 3] 2615         anda    (0x0012)
   96E6 27 0A         [ 3] 2616         beq     L96F2  
   96E8 18 DE 46      [ 5] 2617         ldy     (0x0046)
   96EB BD 8D FD      [ 6] 2618         jsr     L8DFD
   96EE 4F            [ 2] 2619         clra
   96EF EE 20         [ 5] 2620         ldx     0x20,X
   96F1 09            [ 3] 2621         dex
   96F2                    2622 L96F2:
   96F2 18 DE 46      [ 5] 2623         ldy     (0x0046)
   96F5 BD 8D FD      [ 6] 2624         jsr     L8DFD
   96F8 4F            [ 2] 2625         clra
   96F9 66 E6         [ 6] 2626         ror     0xE6,X
   96FB CC 20 34      [ 3] 2627         ldd     #0x2034           ;' '
   96FE BD 8D B5      [ 6] 2628         jsr     L8DB5            ; display char here on LCD display
   9701                    2629 L9701:
   9701 BD 8E 95      [ 6] 2630         jsr     L8E95
   9704 27 FB         [ 3] 2631         beq     L9701  
   9706 81 01         [ 2] 2632         cmpa    #0x01
   9708 26 22         [ 3] 2633         bne     L972C  
   970A 33            [ 4] 2634         pulb
   970B 37            [ 3] 2635         pshb
   970C 5D            [ 2] 2636         tstb
   970D 27 0A         [ 3] 2637         beq     L9719  
   970F B6 04 2B      [ 4] 2638         ldaa    (0x042B)
   9712 9A 12         [ 3] 2639         oraa    (0x0012)
   9714 B7 04 2B      [ 4] 2640         staa    (0x042B)
   9717 20 08         [ 3] 2641         bra     L9721  
   9719                    2642 L9719:
   9719 B6 04 01      [ 4] 2643         ldaa    (0x0401)
   971C 9A 12         [ 3] 2644         oraa    (0x0012)
   971E B7 04 01      [ 4] 2645         staa    (0x0401)
   9721                    2646 L9721:
   9721 18 DE 46      [ 5] 2647         ldy     (0x0046)
   9724 BD 8D FD      [ 6] 2648         jsr     L8DFD
   9727 4F            [ 2] 2649         clra
   9728 6E A0         [ 3] 2650         jmp     0xA0,X
   972A 20 A5         [ 3] 2651         bra     L96D1  
   972C                    2652 L972C:
   972C 81 02         [ 2] 2653         cmpa    #0x02
   972E 26 23         [ 3] 2654         bne     L9753  
   9730 33            [ 4] 2655         pulb
   9731 37            [ 3] 2656         pshb
   9732 5D            [ 2] 2657         tstb
   9733 27 0A         [ 3] 2658         beq     L973F  
   9735 B6 04 2B      [ 4] 2659         ldaa    (0x042B)
   9738 94 13         [ 3] 2660         anda    (0x0013)
   973A B7 04 2B      [ 4] 2661         staa    (0x042B)
   973D 20 08         [ 3] 2662         bra     L9747  
   973F                    2663 L973F:
   973F B6 04 01      [ 4] 2664         ldaa    (0x0401)
   9742 94 13         [ 3] 2665         anda    (0x0013)
   9744 B7 04 01      [ 4] 2666         staa    (0x0401)
   9747                    2667 L9747:
   9747 18 DE 46      [ 5] 2668         ldy     (0x0046)
   974A BD 8D FD      [ 6] 2669         jsr     L8DFD
   974D 4F            [ 2] 2670         clra
   974E 66 E6         [ 6] 2671         ror     0xE6,X
   9750 7E 96 D1      [ 3] 2672         jmp     L96D1
   9753                    2673 L9753:
   9753 81 0D         [ 2] 2674         cmpa    #0x0D
   9755 26 AA         [ 3] 2675         bne     L9701  
   9757 33            [ 4] 2676         pulb
   9758 7E 96 75      [ 3] 2677         jmp     L9675
   975B                    2678 L975B:
   975B 33            [ 4] 2679         pulb
   975C 7E 92 92      [ 3] 2680         jmp     L9292
                           2681 
                           2682 ; do program rom checksum, and display it on the LCD screen
   975F                    2683 L975F:
   975F CE 00 00      [ 3] 2684         ldx     #0x0000
   9762 18 CE 80 00   [ 4] 2685         ldy     #0x8000
   9766                    2686 L9766:
   9766 18 E6 00      [ 5] 2687         ldab    0,Y     
   9769 18 08         [ 4] 2688         iny
   976B 3A            [ 3] 2689         abx
   976C 18 8C 00 00   [ 5] 2690         cpy     #0x0000
   9770 26 F4         [ 3] 2691         bne     L9766  
   9772 DF 17         [ 4] 2692         stx     (0x0017)        ; store rom checksum here
   9774 96 17         [ 3] 2693         ldaa    (0x0017)        ; get high byte of checksum
   9776 BD 97 9B      [ 6] 2694         jsr     L979B           ; convert it to 2 hex chars
   9779 96 12         [ 3] 2695         ldaa    (0x0012)
   977B C6 33         [ 2] 2696         ldab    #0x33
   977D BD 8D B5      [ 6] 2697         jsr     L8DB5           ; display char 1 here on LCD display
   9780 96 13         [ 3] 2698         ldaa    (0x0013)
   9782 C6 34         [ 2] 2699         ldab    #0x34
   9784 BD 8D B5      [ 6] 2700         jsr     L8DB5           ; display char 2 here on LCD display
   9787 96 18         [ 3] 2701         ldaa    (0x0018)        ; get low byte of checksum
   9789 BD 97 9B      [ 6] 2702         jsr     L979B           ; convert it to 2 hex chars
   978C 96 12         [ 3] 2703         ldaa    (0x0012)
   978E C6 35         [ 2] 2704         ldab    #0x35
   9790 BD 8D B5      [ 6] 2705         jsr     L8DB5           ; display char 1 here on LCD display
   9793 96 13         [ 3] 2706         ldaa    (0x0013)
   9795 C6 36         [ 2] 2707         ldab    #0x36
   9797 BD 8D B5      [ 6] 2708         jsr     L8DB5           ; display char 2 here on LCD display
   979A 39            [ 5] 2709         rts
                           2710 
                           2711 ; convert A to ASCII hex digit, store in (0x0012:0x0013)
   979B                    2712 L979B:
   979B 36            [ 3] 2713         psha
   979C 84 0F         [ 2] 2714         anda    #0x0F
   979E 8B 30         [ 2] 2715         adda    #0x30
   97A0 81 39         [ 2] 2716         cmpa    #0x39
   97A2 23 02         [ 3] 2717         bls     L97A6  
   97A4 8B 07         [ 2] 2718         adda    #0x07
   97A6                    2719 L97A6:
   97A6 97 13         [ 3] 2720         staa    (0x0013)
   97A8 32            [ 4] 2721         pula
   97A9 84 F0         [ 2] 2722         anda    #0xF0
   97AB 44            [ 2] 2723         lsra
   97AC 44            [ 2] 2724         lsra
   97AD 44            [ 2] 2725         lsra
   97AE 44            [ 2] 2726         lsra
   97AF 8B 30         [ 2] 2727         adda    #0x30
   97B1 81 39         [ 2] 2728         cmpa    #0x39
   97B3 23 02         [ 3] 2729         bls     L97B7  
   97B5 8B 07         [ 2] 2730         adda    #0x07
   97B7                    2731 L97B7:
   97B7 97 12         [ 3] 2732         staa    (0x0012)
   97B9 39            [ 5] 2733         rts
                           2734 
   97BA                    2735 L97BA:
   97BA BD 9D 18      [ 6] 2736         jsr     L9D18
   97BD 24 03         [ 3] 2737         bcc     L97C2  
   97BF 7E 9A 7F      [ 3] 2738         jmp     L9A7F
   97C2                    2739 L97C2:
   97C2 7D 00 79      [ 6] 2740         tst     (0x0079)
   97C5 26 0B         [ 3] 2741         bne     L97D2  
   97C7 FC 04 10      [ 5] 2742         ldd     (0x0410)
   97CA C3 00 01      [ 4] 2743         addd    #0x0001
   97CD FD 04 10      [ 5] 2744         std     (0x0410)
   97D0 20 09         [ 3] 2745         bra     L97DB  
   97D2                    2746 L97D2:
   97D2 FC 04 12      [ 5] 2747         ldd     (0x0412)
   97D5 C3 00 01      [ 4] 2748         addd    #0x0001
   97D8 FD 04 12      [ 5] 2749         std     (0x0412)
   97DB                    2750 L97DB:
   97DB 86 78         [ 2] 2751         ldaa    #0x78
   97DD 97 63         [ 3] 2752         staa    (0x0063)
   97DF 97 64         [ 3] 2753         staa    (0x0064)
   97E1 BD A3 13      [ 6] 2754         jsr     LA313
   97E4 BD AA DB      [ 6] 2755         jsr     LAADB
   97E7 86 01         [ 2] 2756         ldaa    #0x01
   97E9 97 4E         [ 3] 2757         staa    (0x004E)
   97EB 97 76         [ 3] 2758         staa    (0x0076)
   97ED 7F 00 75      [ 6] 2759         clr     (0x0075)
   97F0 7F 00 77      [ 6] 2760         clr     (0x0077)
   97F3 BD 87 AE      [ 6] 2761         jsr     L87AE
   97F6 D6 7B         [ 3] 2762         ldab    (0x007B)
   97F8 CA 20         [ 2] 2763         orab    #0x20
   97FA C4 F7         [ 2] 2764         andb    #0xF7
   97FC BD 87 48      [ 6] 2765         jsr     L8748   
   97FF 7E 85 A4      [ 3] 2766         jmp     L85A4
   9802                    2767 L9802:
   9802 7F 00 76      [ 6] 2768         clr     (0x0076)
   9805 7F 00 75      [ 6] 2769         clr     (0x0075)
   9808 7F 00 77      [ 6] 2770         clr     (0x0077)
   980B 7F 00 4E      [ 6] 2771         clr     (0x004E)
   980E D6 7B         [ 3] 2772         ldab    (0x007B)
   9810 CA 0C         [ 2] 2773         orab    #0x0C
   9812 BD 87 48      [ 6] 2774         jsr     L8748
   9815                    2775 L9815:
   9815 BD A3 1E      [ 6] 2776         jsr     LA31E
   9818 BD 86 C4      [ 6] 2777         jsr     L86C4               ; Reset boards 1-10
   981B BD 9C 51      [ 6] 2778         jsr     L9C51
   981E BD 8E 95      [ 6] 2779         jsr     L8E95
   9821 7E 84 4D      [ 3] 2780         jmp     L844D
   9824                    2781 L9824:
   9824 BD 9C 51      [ 6] 2782         jsr     L9C51
   9827 7F 00 4E      [ 6] 2783         clr     (0x004E)
   982A D6 7B         [ 3] 2784         ldab    (0x007B)
   982C CA 24         [ 2] 2785         orab    #0x24
   982E C4 F7         [ 2] 2786         andb    #0xF7
   9830 BD 87 48      [ 6] 2787         jsr     L8748   
   9833 BD 87 AE      [ 6] 2788         jsr     L87AE
   9836 BD 8E 95      [ 6] 2789         jsr     L8E95
   9839 7E 84 4D      [ 3] 2790         jmp     L844D
   983C                    2791 L983C:
   983C 7F 00 78      [ 6] 2792         clr     (0x0078)
   983F B6 10 8A      [ 4] 2793         ldaa    (0x108A)
   9842 84 F9         [ 2] 2794         anda    #0xF9
   9844 B7 10 8A      [ 4] 2795         staa    (0x108A)
   9847 7D 00 AF      [ 6] 2796         tst     (0x00AF)
   984A 26 61         [ 3] 2797         bne     L98AD  
   984C 96 62         [ 3] 2798         ldaa    (0x0062)
   984E 84 01         [ 2] 2799         anda    #0x01
   9850 27 5B         [ 3] 2800         beq     L98AD  
   9852 C6 FD         [ 2] 2801         ldab    #0xFD
   9854 BD 86 E7      [ 6] 2802         jsr     L86E7
   9857 CC 00 32      [ 3] 2803         ldd     #0x0032
   985A DD 1B         [ 4] 2804         std     CDTIMR1
   985C CC 75 30      [ 3] 2805         ldd     #0x7530
   985F DD 1D         [ 4] 2806         std     CDTIMR2
   9861 7F 00 5A      [ 6] 2807         clr     (0x005A)
   9864                    2808 L9864:
   9864 BD 9B 19      [ 6] 2809         jsr     L9B19   
   9867 7D 00 31      [ 6] 2810         tst     (0x0031)
   986A 26 04         [ 3] 2811         bne     L9870  
   986C 96 5A         [ 3] 2812         ldaa    (0x005A)
   986E 27 19         [ 3] 2813         beq     L9889  
   9870                    2814 L9870:
   9870 7F 00 31      [ 6] 2815         clr     (0x0031)
   9873 D6 62         [ 3] 2816         ldab    (0x0062)
   9875 C4 FE         [ 2] 2817         andb    #0xFE
   9877 D7 62         [ 3] 2818         stab    (0x0062)
   9879 BD F9 C5      [ 6] 2819         jsr     BUTNLIT 
   987C BD AA 13      [ 6] 2820         jsr     LAA13
   987F C6 FB         [ 2] 2821         ldab    #0xFB
   9881 BD 86 E7      [ 6] 2822         jsr     L86E7
   9884 7F 00 5A      [ 6] 2823         clr     (0x005A)
   9887 20 4B         [ 3] 2824         bra     L98D4  
   9889                    2825 L9889:
   9889 DC 1B         [ 4] 2826         ldd     CDTIMR1
   988B 26 D7         [ 3] 2827         bne     L9864  
   988D D6 62         [ 3] 2828         ldab    (0x0062)
   988F C8 01         [ 2] 2829         eorb    #0x01
   9891 D7 62         [ 3] 2830         stab    (0x0062)
   9893 BD F9 C5      [ 6] 2831         jsr     BUTNLIT 
   9896 C4 01         [ 2] 2832         andb    #0x01
   9898 26 05         [ 3] 2833         bne     L989F  
   989A BD AA 0C      [ 6] 2834         jsr     LAA0C
   989D 20 03         [ 3] 2835         bra     L98A2  
   989F                    2836 L989F:
   989F BD AA 13      [ 6] 2837         jsr     LAA13
   98A2                    2838 L98A2:
   98A2 CC 00 32      [ 3] 2839         ldd     #0x0032
   98A5 DD 1B         [ 4] 2840         std     CDTIMR1
   98A7 DC 1D         [ 4] 2841         ldd     CDTIMR2
   98A9 27 C5         [ 3] 2842         beq     L9870  
   98AB 20 B7         [ 3] 2843         bra     L9864  
   98AD                    2844 L98AD:
   98AD 7D 00 75      [ 6] 2845         tst     (0x0075)
   98B0 27 03         [ 3] 2846         beq     L98B5  
   98B2 7E 99 39      [ 3] 2847         jmp     L9939
   98B5                    2848 L98B5:
   98B5 96 62         [ 3] 2849         ldaa    (0x0062)
   98B7 84 02         [ 2] 2850         anda    #0x02
   98B9 27 4E         [ 3] 2851         beq     L9909  
   98BB 7D 00 AF      [ 6] 2852         tst     (0x00AF)
   98BE 26 0B         [ 3] 2853         bne     L98CB  
   98C0 FC 04 24      [ 5] 2854         ldd     (0x0424)
   98C3 C3 00 01      [ 4] 2855         addd    #0x0001
   98C6 FD 04 24      [ 5] 2856         std     (0x0424)
   98C9 20 09         [ 3] 2857         bra     L98D4  
   98CB                    2858 L98CB:
   98CB FC 04 22      [ 5] 2859         ldd     (0x0422)
   98CE C3 00 01      [ 4] 2860         addd    #0x0001
   98D1 FD 04 22      [ 5] 2861         std     (0x0422)
   98D4                    2862 L98D4:
   98D4 FC 04 18      [ 5] 2863         ldd     (0x0418)
   98D7 C3 00 01      [ 4] 2864         addd    #0x0001
   98DA FD 04 18      [ 5] 2865         std     (0x0418)
   98DD 86 78         [ 2] 2866         ldaa    #0x78
   98DF 97 63         [ 3] 2867         staa    (0x0063)
   98E1 97 64         [ 3] 2868         staa    (0x0064)
   98E3 D6 62         [ 3] 2869         ldab    (0x0062)
   98E5 C4 F7         [ 2] 2870         andb    #0xF7
   98E7 CA 02         [ 2] 2871         orab    #0x02
   98E9 D7 62         [ 3] 2872         stab    (0x0062)
   98EB BD F9 C5      [ 6] 2873         jsr     BUTNLIT 
   98EE BD AA 18      [ 6] 2874         jsr     LAA18
   98F1 86 01         [ 2] 2875         ldaa    #0x01
   98F3 97 4E         [ 3] 2876         staa    (0x004E)
   98F5 97 75         [ 3] 2877         staa    (0x0075)
   98F7 D6 7B         [ 3] 2878         ldab    (0x007B)
   98F9 C4 DF         [ 2] 2879         andb    #0xDF
   98FB BD 87 48      [ 6] 2880         jsr     L8748   
   98FE BD 87 AE      [ 6] 2881         jsr     L87AE
   9901 BD A3 13      [ 6] 2882         jsr     LA313
   9904 BD AA DB      [ 6] 2883         jsr     LAADB
   9907 20 30         [ 3] 2884         bra     L9939  
   9909                    2885 L9909:
   9909 D6 62         [ 3] 2886         ldab    (0x0062)
   990B C4 F5         [ 2] 2887         andb    #0xF5
   990D CA 40         [ 2] 2888         orab    #0x40
   990F D7 62         [ 3] 2889         stab    (0x0062)
   9911 BD F9 C5      [ 6] 2890         jsr     BUTNLIT 
   9914 BD AA 1D      [ 6] 2891         jsr     LAA1D
   9917 7D 00 AF      [ 6] 2892         tst     (0x00AF)
   991A 26 04         [ 3] 2893         bne     L9920  
   991C C6 01         [ 2] 2894         ldab    #0x01
   991E D7 B6         [ 3] 2895         stab    (0x00B6)
   9920                    2896 L9920:
   9920 BD 9C 51      [ 6] 2897         jsr     L9C51
   9923 7F 00 4E      [ 6] 2898         clr     (0x004E)
   9926 7F 00 75      [ 6] 2899         clr     (0x0075)
   9929 86 01         [ 2] 2900         ldaa    #0x01
   992B 97 77         [ 3] 2901         staa    (0x0077)
   992D D6 7B         [ 3] 2902         ldab    (0x007B)
   992F CA 24         [ 2] 2903         orab    #0x24
   9931 C4 F7         [ 2] 2904         andb    #0xF7
   9933 BD 87 48      [ 6] 2905         jsr     L8748   
   9936 BD 87 91      [ 6] 2906         jsr     L8791   
   9939                    2907 L9939:
   9939 7F 00 AF      [ 6] 2908         clr     (0x00AF)
   993C 7E 85 A4      [ 3] 2909         jmp     L85A4
   993F                    2910 L993F:
   993F 7F 00 77      [ 6] 2911         clr     (0x0077)
   9942 BD 9C 51      [ 6] 2912         jsr     L9C51
   9945 7F 00 4E      [ 6] 2913         clr     (0x004E)
   9948 D6 62         [ 3] 2914         ldab    (0x0062)
   994A C4 BF         [ 2] 2915         andb    #0xBF
   994C 7D 00 75      [ 6] 2916         tst     (0x0075)
   994F 27 02         [ 3] 2917         beq     L9953  
   9951 C4 FD         [ 2] 2918         andb    #0xFD
   9953                    2919 L9953:
   9953 D7 62         [ 3] 2920         stab    (0x0062)
   9955 BD F9 C5      [ 6] 2921         jsr     BUTNLIT 
   9958 BD AA 1D      [ 6] 2922         jsr     LAA1D
   995B 7F 00 5B      [ 6] 2923         clr     (0x005B)
   995E BD 87 AE      [ 6] 2924         jsr     L87AE
   9961 D6 7B         [ 3] 2925         ldab    (0x007B)
   9963 CA 20         [ 2] 2926         orab    #0x20
   9965 BD 87 48      [ 6] 2927         jsr     L8748   
   9968 7F 00 75      [ 6] 2928         clr     (0x0075)
   996B 7F 00 76      [ 6] 2929         clr     (0x0076)
   996E 7E 98 15      [ 3] 2930         jmp     L9815
   9971                    2931 L9971:
   9971 D6 7B         [ 3] 2932         ldab    (0x007B)
   9973 C4 FB         [ 2] 2933         andb    #0xFB
   9975 BD 87 48      [ 6] 2934         jsr     L8748   
   9978 7E 85 A4      [ 3] 2935         jmp     L85A4
   997B                    2936 L997B:
   997B D6 7B         [ 3] 2937         ldab    (0x007B)
   997D CA 04         [ 2] 2938         orab    #0x04
   997F BD 87 48      [ 6] 2939         jsr     L8748   
   9982 7E 85 A4      [ 3] 2940         jmp     L85A4
   9985                    2941 L9985:
   9985 D6 7B         [ 3] 2942         ldab    (0x007B)
   9987 C4 F7         [ 2] 2943         andb    #0xF7
   9989 BD 87 48      [ 6] 2944         jsr     L8748   
   998C 7E 85 A4      [ 3] 2945         jmp     L85A4
   998F                    2946 L998F:
   998F 7D 00 77      [ 6] 2947         tst     (0x0077)
   9992 26 07         [ 3] 2948         bne     L999B
   9994 D6 7B         [ 3] 2949         ldab    (0x007B)
   9996 CA 08         [ 2] 2950         orab    #0x08
   9998 BD 87 48      [ 6] 2951         jsr     L8748   
   999B                    2952 L999B:
   999B 7E 85 A4      [ 3] 2953         jmp     L85A4
   999E                    2954 L999E:
   999E D6 7B         [ 3] 2955         ldab    (0x007B)
   99A0 C4 F3         [ 2] 2956         andb    #0xF3
   99A2 BD 87 48      [ 6] 2957         jsr     L8748   
   99A5 39            [ 5] 2958         rts
                           2959 
                           2960 ; main2
   99A6                    2961 L99A6:
   99A6 D6 7B         [ 3] 2962         ldab    (0x007B)
   99A8 C4 DF         [ 2] 2963         andb    #0xDF        ; clear bit 5
   99AA BD 87 48      [ 6] 2964         jsr     L8748
   99AD BD 87 91      [ 6] 2965         jsr     L8791   
   99B0 39            [ 5] 2966         rts
                           2967 
   99B1                    2968 L99B1:
   99B1 D6 7B         [ 3] 2969         ldab    (0x007B)
   99B3 CA 20         [ 2] 2970         orab    #0x20
   99B5 BD 87 48      [ 6] 2971         jsr     L8748   
   99B8 BD 87 AE      [ 6] 2972         jsr     L87AE
   99BB 39            [ 5] 2973         rts
                           2974 
   99BC D6 7B         [ 3] 2975         ldab    (0x007B)
   99BE C4 DF         [ 2] 2976         andb    #0xDF
   99C0 BD 87 48      [ 6] 2977         jsr     L8748   
   99C3 BD 87 AE      [ 6] 2978         jsr     L87AE
   99C6 39            [ 5] 2979         rts
                           2980 
   99C7 D6 7B         [ 3] 2981         ldab    (0x007B)
   99C9 CA 20         [ 2] 2982         orab    #0x20
   99CB BD 87 48      [ 6] 2983         jsr     L8748   
   99CE BD 87 91      [ 6] 2984         jsr     L8791   
   99D1 39            [ 5] 2985         rts
                           2986 
   99D2                    2987 L99D2:
   99D2 86 01         [ 2] 2988         ldaa    #0x01
   99D4 97 78         [ 3] 2989         staa    (0x0078)
   99D6 7E 85 A4      [ 3] 2990         jmp     L85A4
   99D9                    2991 L99D9:
   99D9 CE 0E 20      [ 3] 2992         ldx     #0x0E20
   99DC A6 00         [ 4] 2993         ldaa    0,X     
   99DE 80 30         [ 2] 2994         suba    #0x30
   99E0 C6 0A         [ 2] 2995         ldab    #0x0A
   99E2 3D            [10] 2996         mul
   99E3 17            [ 2] 2997         tba                 ; (0E20)*10 into A
   99E4 C6 64         [ 2] 2998         ldab    #0x64
   99E6 3D            [10] 2999         mul
   99E7 DD 17         [ 4] 3000         std     (0x0017)    ; (0E20)*1000 into 17:18
   99E9 A6 01         [ 4] 3001         ldaa    1,X
   99EB 80 30         [ 2] 3002         suba    #0x30
   99ED C6 64         [ 2] 3003         ldab    #0x64
   99EF 3D            [10] 3004         mul
   99F0 D3 17         [ 5] 3005         addd    (0x0017)
   99F2 DD 17         [ 4] 3006         std     (0x0017)    ; (0E20)*1000+(0E21)*100 into 17:18
   99F4 A6 02         [ 4] 3007         ldaa    2,X     
   99F6 80 30         [ 2] 3008         suba    #0x30
   99F8 C6 0A         [ 2] 3009         ldab    #0x0A
   99FA 3D            [10] 3010         mul
   99FB D3 17         [ 5] 3011         addd    (0x0017)    
   99FD DD 17         [ 4] 3012         std     (0x0017)    ; (0E20)*1000+(0E21)*100+(0E22)*10 into 17:18
   99FF 4F            [ 2] 3013         clra
   9A00 E6 03         [ 4] 3014         ldab    3,X     
   9A02 C0 30         [ 2] 3015         subb    #0x30
   9A04 D3 17         [ 5] 3016         addd    (0x0017)    
   9A06 FD 02 9C      [ 5] 3017         std     (0x029C)    ; (0E20)*1000+(0E21)*100+(0E22)*10+(0E23) into (029C:029D)
   9A09 CE 0E 20      [ 3] 3018         ldx     #0x0E20
   9A0C                    3019 L9A0C:
   9A0C A6 00         [ 4] 3020         ldaa    0,X         
   9A0E 81 30         [ 2] 3021         cmpa    #0x30
   9A10 25 13         [ 3] 3022         bcs     L9A25  
   9A12 81 39         [ 2] 3023         cmpa    #0x39
   9A14 22 0F         [ 3] 3024         bhi     L9A25  
   9A16 08            [ 3] 3025         inx
   9A17 8C 0E 24      [ 4] 3026         cpx     #0x0E24
   9A1A 26 F0         [ 3] 3027         bne     L9A0C  
   9A1C B6 0E 24      [ 4] 3028         ldaa    (0x0E24)    ; check EEPROM signature
   9A1F 81 DB         [ 2] 3029         cmpa    #0xDB
   9A21 26 02         [ 3] 3030         bne     L9A25  
   9A23 0C            [ 2] 3031         clc                 ; if sig good, return carry clear
   9A24 39            [ 5] 3032         rts
                           3033 
   9A25                    3034 L9A25:
   9A25 0D            [ 2] 3035         sec                 ; if sig bad, return carry clear
   9A26 39            [ 5] 3036         rts
                           3037 
   9A27                    3038 L9A27:
   9A27 BD 8D E4      [ 6] 3039         jsr     LCDMSG1 
   9A2A 53 65 72 69 61 6C  3040         .ascis  'Serial# '
        23 A0
                           3041 
   9A32 BD 8D DD      [ 6] 3042         jsr     LCDMSG2 
   9A35 20 20 20 20 20 20  3043         .ascis  '               '
        20 20 20 20 20 20
        20 20 A0
                           3044 
                           3045 ; display 4-digit serial number
   9A44 C6 08         [ 2] 3046         ldab    #0x08
   9A46 18 CE 0E 20   [ 4] 3047         ldy     #0x0E20
   9A4A                    3048 L9A4A:
   9A4A 18 A6 00      [ 5] 3049         ldaa    0,Y     
   9A4D 18 3C         [ 5] 3050         pshy
   9A4F 37            [ 3] 3051         pshb
   9A50 BD 8D B5      [ 6] 3052         jsr     L8DB5            ; display char here on LCD display
   9A53 33            [ 4] 3053         pulb
   9A54 18 38         [ 6] 3054         puly
   9A56 5C            [ 2] 3055         incb
   9A57 18 08         [ 4] 3056         iny
   9A59 18 8C 0E 24   [ 5] 3057         cpy     #0x0E24
   9A5D 26 EB         [ 3] 3058         bne     L9A4A  
   9A5F 39            [ 5] 3059         rts
                           3060 
                           3061 ; Unused?
   9A60                    3062 L9A60:
   9A60 86 01         [ 2] 3063         ldaa    #0x01
   9A62 97 B5         [ 3] 3064         staa    (0x00B5)
   9A64 96 4E         [ 3] 3065         ldaa    (0x004E)
   9A66 97 7F         [ 3] 3066         staa    (0x007F)
   9A68 96 62         [ 3] 3067         ldaa    (0x0062)
   9A6A 97 80         [ 3] 3068         staa    (0x0080)
   9A6C 96 7B         [ 3] 3069         ldaa    (0x007B)
   9A6E 97 81         [ 3] 3070         staa    (0x0081)
   9A70 96 7A         [ 3] 3071         ldaa    (0x007A)
   9A72 97 82         [ 3] 3072         staa    (0x0082)
   9A74 96 78         [ 3] 3073         ldaa    (0x0078)
   9A76 97 7D         [ 3] 3074         staa    (0x007D)
   9A78 B6 10 8A      [ 4] 3075         ldaa    (0x108A)
   9A7B 84 06         [ 2] 3076         anda    #0x06
   9A7D 97 7E         [ 3] 3077         staa    (0x007E)
   9A7F                    3078 L9A7F:
   9A7F C6 EF         [ 2] 3079         ldab    #0xEF
   9A81 BD 86 E7      [ 6] 3080         jsr     L86E7
   9A84 D6 7B         [ 3] 3081         ldab    (0x007B)
   9A86 CA 0C         [ 2] 3082         orab    #0x0C
   9A88 C4 DF         [ 2] 3083         andb    #0xDF
   9A8A BD 87 48      [ 6] 3084         jsr     L8748   
   9A8D BD 87 91      [ 6] 3085         jsr     L8791   
   9A90 BD 86 C4      [ 6] 3086         jsr     L86C4           ; Reset boards 1-10
   9A93 BD 9C 51      [ 6] 3087         jsr     L9C51
   9A96 C6 06         [ 2] 3088         ldab    #0x06            ; delay 6 secs
   9A98 BD 8C 02      [ 6] 3089         jsr     DLYSECS          ;
   9A9B BD 8E 95      [ 6] 3090         jsr     L8E95
   9A9E BD 99 A6      [ 6] 3091         jsr     L99A6
   9AA1 7E 81 BD      [ 3] 3092         jmp     L81BD
   9AA4                    3093 L9AA4:
   9AA4 7F 00 5C      [ 6] 3094         clr     (0x005C)
   9AA7 86 01         [ 2] 3095         ldaa    #0x01
   9AA9 97 79         [ 3] 3096         staa    (0x0079)
   9AAB C6 FD         [ 2] 3097         ldab    #0xFD
   9AAD BD 86 E7      [ 6] 3098         jsr     L86E7
   9AB0 BD 8E 95      [ 6] 3099         jsr     L8E95
   9AB3 CC 75 30      [ 3] 3100         ldd     #0x7530
   9AB6 DD 1D         [ 4] 3101         std     CDTIMR2
   9AB8                    3102 L9AB8:
   9AB8 BD 9B 19      [ 6] 3103         jsr     L9B19   
   9ABB D6 62         [ 3] 3104         ldab    (0x0062)
   9ABD C8 04         [ 2] 3105         eorb    #0x04
   9ABF D7 62         [ 3] 3106         stab    (0x0062)
   9AC1 BD F9 C5      [ 6] 3107         jsr     BUTNLIT 
   9AC4 F6 18 04      [ 4] 3108         ldab    PIA0PRA 
   9AC7 C8 08         [ 2] 3109         eorb    #0x08
   9AC9 F7 18 04      [ 4] 3110         stab    PIA0PRA 
   9ACC 7D 00 5C      [ 6] 3111         tst     (0x005C)
   9ACF 26 12         [ 3] 3112         bne     L9AE3  
   9AD1 BD 8E 95      [ 6] 3113         jsr     L8E95
   9AD4 81 0D         [ 2] 3114         cmpa    #0x0D
   9AD6 27 0B         [ 3] 3115         beq     L9AE3  
   9AD8 C6 32         [ 2] 3116         ldab    #0x32       ; delay 0.5 sec
   9ADA BD 8C 22      [ 6] 3117         jsr     DLYSECSBY100
   9ADD DC 1D         [ 4] 3118         ldd     CDTIMR2
   9ADF 27 02         [ 3] 3119         beq     L9AE3  
   9AE1 20 D5         [ 3] 3120         bra     L9AB8  
   9AE3                    3121 L9AE3:
   9AE3 D6 62         [ 3] 3122         ldab    (0x0062)
   9AE5 C4 FB         [ 2] 3123         andb    #0xFB
   9AE7 D7 62         [ 3] 3124         stab    (0x0062)
   9AE9 BD F9 C5      [ 6] 3125         jsr     BUTNLIT 
   9AEC BD A3 54      [ 6] 3126         jsr     LA354
   9AEF C6 FB         [ 2] 3127         ldab    #0xFB
   9AF1 BD 86 E7      [ 6] 3128         jsr     L86E7
   9AF4 7E 85 A4      [ 3] 3129         jmp     L85A4
   9AF7                    3130 L9AF7:
   9AF7 7F 00 75      [ 6] 3131         clr     (0x0075)
   9AFA 7F 00 76      [ 6] 3132         clr     (0x0076)
   9AFD 7F 00 77      [ 6] 3133         clr     (0x0077)
   9B00 7F 00 78      [ 6] 3134         clr     (0x0078)
   9B03 7F 00 25      [ 6] 3135         clr     (0x0025)
   9B06 7F 00 26      [ 6] 3136         clr     (0x0026)
   9B09 7F 00 4E      [ 6] 3137         clr     (0x004E)
   9B0C 7F 00 30      [ 6] 3138         clr     (0x0030)
   9B0F 7F 00 31      [ 6] 3139         clr     (0x0031)
   9B12 7F 00 32      [ 6] 3140         clr     (0x0032)
   9B15 7F 00 AF      [ 6] 3141         clr     (0x00AF)
   9B18 39            [ 5] 3142         rts
                           3143 
                           3144 ; validate a bunch of ram locations against bytes in ROM???
   9B19                    3145 L9B19:
   9B19 36            [ 3] 3146         psha
   9B1A 37            [ 3] 3147         pshb
   9B1B 96 4E         [ 3] 3148         ldaa    (0x004E)
   9B1D 27 17         [ 3] 3149         beq     L9B36       ; go to 0401 logic
   9B1F 96 63         [ 3] 3150         ldaa    (0x0063)
   9B21 26 10         [ 3] 3151         bne     L9B33       ; exit
   9B23 7D 00 64      [ 6] 3152         tst     (0x0064)
   9B26 27 09         [ 3] 3153         beq     L9B31       ; go to 0401 logic
   9B28 BD 86 C4      [ 6] 3154         jsr     L86C4       ; Reset boards 1-10
   9B2B BD 9C 51      [ 6] 3155         jsr     L9C51       ; RTC stuff???
   9B2E 7F 00 64      [ 6] 3156         clr     (0x0064)
   9B31                    3157 L9B31:
   9B31 20 03         [ 3] 3158         bra     L9B36       ; go to 0401 logic
   9B33                    3159 L9B33:
   9B33 33            [ 4] 3160         pulb
   9B34 32            [ 4] 3161         pula
   9B35 39            [ 5] 3162         rts
                           3163 
                           3164 ; end up here immediately if:
                           3165 ; 0x004E == 00 or
                           3166 ; 0x0063, 0x0064 == 0 or
                           3167 ; 
                           3168 ; do subroutines based on bits 0-4 of 0x0401?
   9B36                    3169 L9B36:
   9B36 B6 04 01      [ 4] 3170         ldaa    (0x0401)
   9B39 84 01         [ 2] 3171         anda    #0x01
   9B3B 27 03         [ 3] 3172         beq     L9B40  
   9B3D BD 9B 6B      [ 6] 3173         jsr     L9B6B       ; bit 0 routine
   9B40                    3174 L9B40:
   9B40 B6 04 01      [ 4] 3175         ldaa    (0x0401)
   9B43 84 02         [ 2] 3176         anda    #0x02
   9B45 27 03         [ 3] 3177         beq     L9B4A  
   9B47 BD 9B 99      [ 6] 3178         jsr     L9B99       ; bit 1 routine
   9B4A                    3179 L9B4A:
   9B4A B6 04 01      [ 4] 3180         ldaa    (0x0401)
   9B4D 84 04         [ 2] 3181         anda    #0x04
   9B4F 27 03         [ 3] 3182         beq     L9B54  
   9B51 BD 9B C7      [ 6] 3183         jsr     L9BC7       ; bit 2 routine
   9B54                    3184 L9B54:
   9B54 B6 04 01      [ 4] 3185         ldaa    (0x0401)
   9B57 84 08         [ 2] 3186         anda    #0x08
   9B59 27 03         [ 3] 3187         beq     L9B5E  
   9B5B BD 9B F5      [ 6] 3188         jsr     L9BF5       ; bit 3 routine
   9B5E                    3189 L9B5E:
   9B5E B6 04 01      [ 4] 3190         ldaa    (0x0401)
   9B61 84 10         [ 2] 3191         anda    #0x10
   9B63 27 03         [ 3] 3192         beq     L9B68  
   9B65 BD 9C 23      [ 6] 3193         jsr     L9C23       ; bit 4 routine
   9B68                    3194 L9B68:
   9B68 33            [ 4] 3195         pulb
   9B69 32            [ 4] 3196         pula
   9B6A 39            [ 5] 3197         rts
                           3198 
                           3199 ; bit 0 routine
   9B6B                    3200 L9B6B:
   9B6B 18 3C         [ 5] 3201         pshy
   9B6D 18 DE 65      [ 5] 3202         ldy     (0x0065)
   9B70 18 A6 00      [ 5] 3203         ldaa    0,Y     
   9B73 81 FF         [ 2] 3204         cmpa    #0xFF
   9B75 27 14         [ 3] 3205         beq     L9B8B  
   9B77 91 70         [ 3] 3206         cmpa    OFFCNT1
   9B79 25 0D         [ 3] 3207         bcs     L9B88  
   9B7B 18 08         [ 4] 3208         iny
   9B7D 18 A6 00      [ 5] 3209         ldaa    0,Y     
   9B80 B7 10 80      [ 4] 3210         staa    (0x1080)
   9B83 18 08         [ 4] 3211         iny
   9B85 18 DF 65      [ 5] 3212         sty     (0x0065)
   9B88                    3213 L9B88:
   9B88 18 38         [ 6] 3214         puly
   9B8A 39            [ 5] 3215         rts
   9B8B                    3216 L9B8B:
   9B8B 18 CE B2 EB   [ 4] 3217         ldy     #LB2EB
   9B8F 18 DF 65      [ 5] 3218         sty     (0x0065)
   9B92 86 FA         [ 2] 3219         ldaa    #0xFA
   9B94 97 70         [ 3] 3220         staa    OFFCNT1
   9B96 7E 9B 88      [ 3] 3221         jmp     L9B88
   9B99                    3222 L9B99:
   9B99 18 3C         [ 5] 3223         pshy
   9B9B 18 DE 67      [ 5] 3224         ldy     (0x0067)
   9B9E 18 A6 00      [ 5] 3225         ldaa    0,Y     
   9BA1 81 FF         [ 2] 3226         cmpa    #0xFF
   9BA3 27 14         [ 3] 3227         beq     L9BB9  
   9BA5 91 71         [ 3] 3228         cmpa    OFFCNT2
   9BA7 25 0D         [ 3] 3229         bcs     L9BB6  
   9BA9 18 08         [ 4] 3230         iny
   9BAB 18 A6 00      [ 5] 3231         ldaa    0,Y     
   9BAE B7 10 84      [ 4] 3232         staa    (0x1084)
   9BB1 18 08         [ 4] 3233         iny
   9BB3 18 DF 67      [ 5] 3234         sty     (0x0067)
   9BB6                    3235 L9BB6:
   9BB6 18 38         [ 6] 3236         puly
   9BB8 39            [ 5] 3237         rts
                           3238 
                           3239 ; bit 1 routine
   9BB9                    3240 L9BB9:
   9BB9 18 CE B3 BD   [ 4] 3241         ldy     #LB3BD
   9BBD 18 DF 67      [ 5] 3242         sty     (0x0067)
   9BC0 86 E6         [ 2] 3243         ldaa    #0xE6
   9BC2 97 71         [ 3] 3244         staa    OFFCNT2
   9BC4 7E 9B B6      [ 3] 3245         jmp     L9BB6
                           3246 
                           3247 ; bit 2 routine
   9BC7                    3248 L9BC7:
   9BC7 18 3C         [ 5] 3249         pshy
   9BC9 18 DE 69      [ 5] 3250         ldy     (0x0069)
   9BCC 18 A6 00      [ 5] 3251         ldaa    0,Y     
   9BCF 81 FF         [ 2] 3252         cmpa    #0xFF
   9BD1 27 14         [ 3] 3253         beq     L9BE7  
   9BD3 91 72         [ 3] 3254         cmpa    OFFCNT3
   9BD5 25 0D         [ 3] 3255         bcs     L9BE4  
   9BD7 18 08         [ 4] 3256         iny
   9BD9 18 A6 00      [ 5] 3257         ldaa    0,Y     
   9BDC B7 10 88      [ 4] 3258         staa    (0x1088)
   9BDF 18 08         [ 4] 3259         iny
   9BE1 18 DF 69      [ 5] 3260         sty     (0x0069)
   9BE4                    3261 L9BE4:
   9BE4 18 38         [ 6] 3262         puly
   9BE6 39            [ 5] 3263         rts
   9BE7                    3264 L9BE7:
   9BE7 18 CE B5 31   [ 4] 3265         ldy     #LB531
   9BEB 18 DF 69      [ 5] 3266         sty     (0x0069)
   9BEE 86 D2         [ 2] 3267         ldaa    #0xD2
   9BF0 97 72         [ 3] 3268         staa    OFFCNT3
   9BF2 7E 9B E4      [ 3] 3269         jmp     L9BE4
                           3270 
                           3271 ; bit 3 routine
   9BF5                    3272 L9BF5:
   9BF5 18 3C         [ 5] 3273         pshy
   9BF7 18 DE 6B      [ 5] 3274         ldy     (0x006B)
   9BFA 18 A6 00      [ 5] 3275         ldaa    0,Y     
   9BFD 81 FF         [ 2] 3276         cmpa    #0xFF
   9BFF 27 14         [ 3] 3277         beq     L9C15  
   9C01 91 73         [ 3] 3278         cmpa    OFFCNT4
   9C03 25 0D         [ 3] 3279         bcs     L9C12  
   9C05 18 08         [ 4] 3280         iny
   9C07 18 A6 00      [ 5] 3281         ldaa    0,Y     
   9C0A B7 10 8C      [ 4] 3282         staa    (0x108C)
   9C0D 18 08         [ 4] 3283         iny
   9C0F 18 DF 6B      [ 5] 3284         sty     (0x006B)
   9C12                    3285 L9C12:
   9C12 18 38         [ 6] 3286         puly
   9C14 39            [ 5] 3287         rts
   9C15                    3288 L9C15:
   9C15 18 CE B4 75   [ 4] 3289         ldy     #LB475
   9C19 18 DF 6B      [ 5] 3290         sty     (0x006B)
   9C1C 86 BE         [ 2] 3291         ldaa    #0xBE
   9C1E 97 73         [ 3] 3292         staa    OFFCNT4
   9C20 7E 9C 12      [ 3] 3293         jmp     L9C12
                           3294 
                           3295 ; bit 4 routine
   9C23                    3296 L9C23:
   9C23 18 3C         [ 5] 3297         pshy
   9C25 18 DE 6D      [ 5] 3298         ldy     (0x006D)
   9C28 18 A6 00      [ 5] 3299         ldaa    0,Y     
   9C2B 81 FF         [ 2] 3300         cmpa    #0xFF
   9C2D 27 14         [ 3] 3301         beq     L9C43  
   9C2F 91 74         [ 3] 3302         cmpa    OFFCNT5
   9C31 25 0D         [ 3] 3303         bcs     L9C40  
   9C33 18 08         [ 4] 3304         iny
   9C35 18 A6 00      [ 5] 3305         ldaa    0,Y     
   9C38 B7 10 90      [ 4] 3306         staa    (0x1090)
   9C3B 18 08         [ 4] 3307         iny
   9C3D 18 DF 6D      [ 5] 3308         sty     (0x006D)
   9C40                    3309 L9C40:
   9C40 18 38         [ 6] 3310         puly
   9C42 39            [ 5] 3311         rts
   9C43                    3312 L9C43:
   9C43 18 CE B5 C3   [ 4] 3313         ldy     #LB5C3
   9C47 18 DF 6D      [ 5] 3314         sty     (0x006D)
   9C4A 86 AA         [ 2] 3315         ldaa    #0xAA
   9C4C 97 74         [ 3] 3316         staa    OFFCNT5
   9C4E 7E 9C 40      [ 3] 3317         jmp     L9C40
                           3318 
                           3319 ; Reset offset counters to initial values
   9C51                    3320 L9C51:
   9C51 86 FA         [ 2] 3321         ldaa    #0xFA
   9C53 97 70         [ 3] 3322         staa    OFFCNT1
   9C55 86 E6         [ 2] 3323         ldaa    #0xE6
   9C57 97 71         [ 3] 3324         staa    OFFCNT2
   9C59 86 D2         [ 2] 3325         ldaa    #0xD2
   9C5B 97 72         [ 3] 3326         staa    OFFCNT3
   9C5D 86 BE         [ 2] 3327         ldaa    #0xBE
   9C5F 97 73         [ 3] 3328         staa    OFFCNT4
   9C61 86 AA         [ 2] 3329         ldaa    #0xAA
   9C63 97 74         [ 3] 3330         staa    OFFCNT5
                           3331 
   9C65 18 CE B2 EB   [ 4] 3332         ldy     #LB2EB
   9C69 18 DF 65      [ 5] 3333         sty     (0x0065)
   9C6C 18 CE B3 BD   [ 4] 3334         ldy     #LB3BD
   9C70 18 DF 67      [ 5] 3335         sty     (0x0067)
   9C73 18 CE B5 31   [ 4] 3336         ldy     #LB531
   9C77 18 DF 69      [ 5] 3337         sty     (0x0069)
   9C7A 18 CE B4 75   [ 4] 3338         ldy     #LB475
   9C7E 18 DF 6B      [ 5] 3339         sty     (0x006B)
   9C81 18 CE B5 C3   [ 4] 3340         ldy     #LB5C3
   9C85 18 DF 6D      [ 5] 3341         sty     (0x006D)
                           3342 
   9C88 7F 10 9C      [ 6] 3343         clr     (0x109C)
   9C8B 7F 10 9E      [ 6] 3344         clr     (0x109E)
                           3345 
   9C8E B6 04 01      [ 4] 3346         ldaa    (0x0401)
   9C91 84 20         [ 2] 3347         anda    #0x20
   9C93 27 08         [ 3] 3348         beq     L9C9D  
   9C95 B6 10 9C      [ 4] 3349         ldaa    (0x109C)
   9C98 8A 19         [ 2] 3350         oraa    #0x19
   9C9A B7 10 9C      [ 4] 3351         staa    (0x109C)
   9C9D                    3352 L9C9D:
   9C9D B6 04 01      [ 4] 3353         ldaa    (0x0401)
   9CA0 84 40         [ 2] 3354         anda    #0x40
   9CA2 27 10         [ 3] 3355         beq     L9CB4  
   9CA4 B6 10 9C      [ 4] 3356         ldaa    (0x109C)
   9CA7 8A 44         [ 2] 3357         oraa    #0x44
   9CA9 B7 10 9C      [ 4] 3358         staa    (0x109C)
   9CAC B6 10 9E      [ 4] 3359         ldaa    (0x109E)
   9CAF 8A 40         [ 2] 3360         oraa    #0x40
   9CB1 B7 10 9E      [ 4] 3361         staa    (0x109E)
   9CB4                    3362 L9CB4:
   9CB4 B6 04 01      [ 4] 3363         ldaa    (0x0401)
   9CB7 84 80         [ 2] 3364         anda    #0x80
   9CB9 27 08         [ 3] 3365         beq     L9CC3  
   9CBB B6 10 9C      [ 4] 3366         ldaa    (0x109C)
   9CBE 8A A2         [ 2] 3367         oraa    #0xA2
   9CC0 B7 10 9C      [ 4] 3368         staa    (0x109C)
   9CC3                    3369 L9CC3:
   9CC3 B6 04 2B      [ 4] 3370         ldaa    (0x042B)
   9CC6 84 01         [ 2] 3371         anda    #0x01
   9CC8 27 08         [ 3] 3372         beq     L9CD2  
   9CCA B6 10 9A      [ 4] 3373         ldaa    (0x109A)
   9CCD 8A 80         [ 2] 3374         oraa    #0x80
   9CCF B7 10 9A      [ 4] 3375         staa    (0x109A)
   9CD2                    3376 L9CD2:
   9CD2 B6 04 2B      [ 4] 3377         ldaa    (0x042B)
   9CD5 84 02         [ 2] 3378         anda    #0x02
   9CD7 27 08         [ 3] 3379         beq     L9CE1  
   9CD9 B6 10 9E      [ 4] 3380         ldaa    (0x109E)
   9CDC 8A 04         [ 2] 3381         oraa    #0x04
   9CDE B7 10 9E      [ 4] 3382         staa    (0x109E)
   9CE1                    3383 L9CE1:
   9CE1 B6 04 2B      [ 4] 3384         ldaa    (0x042B)
   9CE4 84 04         [ 2] 3385         anda    #0x04
   9CE6 27 08         [ 3] 3386         beq     L9CF0  
   9CE8 B6 10 9E      [ 4] 3387         ldaa    (0x109E)
   9CEB 8A 08         [ 2] 3388         oraa    #0x08
   9CED B7 10 9E      [ 4] 3389         staa    (0x109E)
   9CF0                    3390 L9CF0:
   9CF0 39            [ 5] 3391         rts
                           3392 
                           3393 ; Display Credits
   9CF1                    3394 L9CF1:
   9CF1 BD 8D E4      [ 6] 3395         jsr     LCDMSG1 
   9CF4 20 20 20 50 72 6F  3396         .ascis  '   Program by   '
        67 72 61 6D 20 62
        79 20 20 A0
                           3397 
   9D04 BD 8D DD      [ 6] 3398         jsr     LCDMSG2 
   9D07 44 61 76 69 64 20  3399         .ascis  'David  Philipsen'
        20 50 68 69 6C 69
        70 73 65 EE
                           3400 
   9D17 39            [ 5] 3401         rts
                           3402 
   9D18                    3403 L9D18:
   9D18 97 49         [ 3] 3404         staa    (0x0049)
   9D1A 7F 00 B8      [ 6] 3405         clr     (0x00B8)
   9D1D BD 8D 03      [ 6] 3406         jsr     L8D03
   9D20 86 2A         [ 2] 3407         ldaa    #0x2A           ;'*'
   9D22 C6 28         [ 2] 3408         ldab    #0x28
   9D24 BD 8D B5      [ 6] 3409         jsr     L8DB5           ; display char here on LCD display
   9D27 CC 0B B8      [ 3] 3410         ldd     #0x0BB8         ; start 30 second timer?
   9D2A DD 1B         [ 4] 3411         std     CDTIMR1
   9D2C                    3412 L9D2C:
   9D2C BD 9B 19      [ 6] 3413         jsr     L9B19   
   9D2F 96 49         [ 3] 3414         ldaa    (0x0049)
   9D31 81 41         [ 2] 3415         cmpa    #0x41
   9D33 27 04         [ 3] 3416         beq     L9D39  
   9D35 81 4B         [ 2] 3417         cmpa    #0x4B
   9D37 26 04         [ 3] 3418         bne     L9D3D  
   9D39                    3419 L9D39:
   9D39 C6 01         [ 2] 3420         ldab    #0x01
   9D3B D7 B8         [ 3] 3421         stab    (0x00B8)
   9D3D                    3422 L9D3D:
   9D3D 81 41         [ 2] 3423         cmpa    #0x41
   9D3F 27 04         [ 3] 3424         beq     L9D45  
   9D41 81 4F         [ 2] 3425         cmpa    #0x4F
   9D43 26 07         [ 3] 3426         bne     L9D4C  
   9D45                    3427 L9D45:
   9D45 86 01         [ 2] 3428         ldaa    #0x01
   9D47 B7 02 98      [ 4] 3429         staa    (0x0298)
   9D4A 20 32         [ 3] 3430         bra     L9D7E  
   9D4C                    3431 L9D4C:
   9D4C 81 4B         [ 2] 3432         cmpa    #0x4B
   9D4E 27 04         [ 3] 3433         beq     L9D54  
   9D50 81 50         [ 2] 3434         cmpa    #0x50
   9D52 26 07         [ 3] 3435         bne     L9D5B  
   9D54                    3436 L9D54:
   9D54 86 02         [ 2] 3437         ldaa    #0x02
   9D56 B7 02 98      [ 4] 3438         staa    (0x0298)
   9D59 20 23         [ 3] 3439         bra     L9D7E  
   9D5B                    3440 L9D5B:
   9D5B 81 4C         [ 2] 3441         cmpa    #0x4C
   9D5D 26 07         [ 3] 3442         bne     L9D66  
   9D5F 86 03         [ 2] 3443         ldaa    #0x03
   9D61 B7 02 98      [ 4] 3444         staa    (0x0298)
   9D64 20 18         [ 3] 3445         bra     L9D7E  
   9D66                    3446 L9D66:
   9D66 81 52         [ 2] 3447         cmpa    #0x52
   9D68 26 07         [ 3] 3448         bne     L9D71  
   9D6A 86 04         [ 2] 3449         ldaa    #0x04
   9D6C B7 02 98      [ 4] 3450         staa    (0x0298)
   9D6F 20 0D         [ 3] 3451         bra     L9D7E  
   9D71                    3452 L9D71:
   9D71 DC 1B         [ 4] 3453         ldd     CDTIMR1
   9D73 26 B7         [ 3] 3454         bne     L9D2C  
   9D75 86 23         [ 2] 3455         ldaa    #0x23            ;'#'
   9D77 C6 29         [ 2] 3456         ldab    #0x29
   9D79 BD 8D B5      [ 6] 3457         jsr     L8DB5            ; display char here on LCD display
   9D7C 20 6C         [ 3] 3458         bra     L9DEA  
   9D7E                    3459 L9D7E:
   9D7E 7F 00 49      [ 6] 3460         clr     (0x0049)
   9D81 86 2A         [ 2] 3461         ldaa    #0x2A            ;'*'
   9D83 C6 29         [ 2] 3462         ldab    #0x29
   9D85 BD 8D B5      [ 6] 3463         jsr     L8DB5            ; display char here on LCD display
   9D88 7F 00 4A      [ 6] 3464         clr     (0x004A)
   9D8B CE 02 99      [ 3] 3465         ldx     #0x0299
   9D8E                    3466 L9D8E:
   9D8E BD 9B 19      [ 6] 3467         jsr     L9B19   
   9D91 96 4A         [ 3] 3468         ldaa    (0x004A)
   9D93 27 F9         [ 3] 3469         beq     L9D8E  
   9D95 7F 00 4A      [ 6] 3470         clr     (0x004A)
   9D98 84 3F         [ 2] 3471         anda    #0x3F
   9D9A A7 00         [ 4] 3472         staa    0,X     
   9D9C 08            [ 3] 3473         inx
   9D9D 8C 02 9C      [ 4] 3474         cpx     #0x029C
   9DA0 26 EC         [ 3] 3475         bne     L9D8E  
   9DA2 BD 9D F5      [ 6] 3476         jsr     L9DF5
   9DA5 24 09         [ 3] 3477         bcc     L9DB0  
   9DA7 86 23         [ 2] 3478         ldaa    #0x23            ;'#'
   9DA9 C6 2A         [ 2] 3479         ldab    #0x2A
   9DAB BD 8D B5      [ 6] 3480         jsr     L8DB5            ; display char here on LCD display
   9DAE 20 3A         [ 3] 3481         bra     L9DEA  
   9DB0                    3482 L9DB0:
   9DB0 86 2A         [ 2] 3483         ldaa    #0x2A            ;'*'
   9DB2 C6 2A         [ 2] 3484         ldab    #0x2A
   9DB4 BD 8D B5      [ 6] 3485         jsr     L8DB5            ; display char here on LCD display
   9DB7 B6 02 99      [ 4] 3486         ldaa    (0x0299)
   9DBA 81 39         [ 2] 3487         cmpa    #0x39
   9DBC 26 15         [ 3] 3488         bne     L9DD3  
                           3489 
   9DBE BD 8D DD      [ 6] 3490         jsr     LCDMSG2 
   9DC1 47 65 6E 65 72 69  3491         .ascis  'Generic Showtape'
        63 20 53 68 6F 77
        74 61 70 E5
                           3492 
   9DD1 0C            [ 2] 3493         clc
   9DD2 39            [ 5] 3494         rts
                           3495 
   9DD3                    3496 L9DD3:
   9DD3 B6 02 98      [ 4] 3497         ldaa    (0x0298)
   9DD6 81 03         [ 2] 3498         cmpa    #0x03
   9DD8 27 0E         [ 3] 3499         beq     L9DE8  
   9DDA 81 04         [ 2] 3500         cmpa    #0x04
   9DDC 27 0A         [ 3] 3501         beq     L9DE8  
   9DDE 96 76         [ 3] 3502         ldaa    (0x0076)
   9DE0 26 06         [ 3] 3503         bne     L9DE8  
   9DE2 BD 9E 73      [ 6] 3504         jsr     L9E73
   9DE5 BD 9E CC      [ 6] 3505         jsr     L9ECC
   9DE8                    3506 L9DE8:
   9DE8 0C            [ 2] 3507         clc
   9DE9 39            [ 5] 3508         rts
                           3509 
   9DEA                    3510 L9DEA:
   9DEA FC 04 20      [ 5] 3511         ldd     (0x0420)
   9DED C3 00 01      [ 4] 3512         addd    #0x0001
   9DF0 FD 04 20      [ 5] 3513         std     (0x0420)
   9DF3 0D            [ 2] 3514         sec
   9DF4 39            [ 5] 3515         rts
                           3516 
   9DF5                    3517 L9DF5:
   9DF5 B6 02 99      [ 4] 3518         ldaa    (0x0299)
   9DF8 81 39         [ 2] 3519         cmpa    #0x39
   9DFA 27 6C         [ 3] 3520         beq     L9E68  
   9DFC CE 00 A8      [ 3] 3521         ldx     #0x00A8
   9DFF                    3522 L9DFF:
   9DFF BD 9B 19      [ 6] 3523         jsr     L9B19   
   9E02 96 4A         [ 3] 3524         ldaa    (0x004A)
   9E04 27 F9         [ 3] 3525         beq     L9DFF  
   9E06 7F 00 4A      [ 6] 3526         clr     (0x004A)
   9E09 A7 00         [ 4] 3527         staa    0,X     
   9E0B 08            [ 3] 3528         inx
   9E0C 8C 00 AA      [ 4] 3529         cpx     #0x00AA
   9E0F 26 EE         [ 3] 3530         bne     L9DFF  
   9E11 BD 9E FA      [ 6] 3531         jsr     L9EFA
   9E14 CE 02 99      [ 3] 3532         ldx     #0x0299
   9E17 7F 00 13      [ 6] 3533         clr     (0x0013)
   9E1A                    3534 L9E1A:
   9E1A A6 00         [ 4] 3535         ldaa    0,X     
   9E1C 9B 13         [ 3] 3536         adda    (0x0013)
   9E1E 97 13         [ 3] 3537         staa    (0x0013)
   9E20 08            [ 3] 3538         inx
   9E21 8C 02 9C      [ 4] 3539         cpx     #0x029C
   9E24 26 F4         [ 3] 3540         bne     L9E1A  
   9E26 91 A8         [ 3] 3541         cmpa    (0x00A8)
   9E28 26 47         [ 3] 3542         bne     L9E71  
   9E2A CE 04 02      [ 3] 3543         ldx     #0x0402
   9E2D B6 02 98      [ 4] 3544         ldaa    (0x0298)
   9E30 81 02         [ 2] 3545         cmpa    #0x02
   9E32 26 03         [ 3] 3546         bne     L9E37  
   9E34 CE 04 05      [ 3] 3547         ldx     #0x0405
   9E37                    3548 L9E37:
   9E37 3C            [ 4] 3549         pshx
   9E38 BD AB 56      [ 6] 3550         jsr     LAB56
   9E3B 38            [ 5] 3551         pulx
   9E3C 25 07         [ 3] 3552         bcs     L9E45  
   9E3E 86 03         [ 2] 3553         ldaa    #0x03
   9E40 B7 02 98      [ 4] 3554         staa    (0x0298)
   9E43 20 23         [ 3] 3555         bra     L9E68  
   9E45                    3556 L9E45:
   9E45 B6 02 99      [ 4] 3557         ldaa    (0x0299)
   9E48 A1 00         [ 4] 3558         cmpa    0,X     
   9E4A 25 1E         [ 3] 3559         bcs     L9E6A  
   9E4C 27 02         [ 3] 3560         beq     L9E50  
   9E4E 24 18         [ 3] 3561         bcc     L9E68  
   9E50                    3562 L9E50:
   9E50 08            [ 3] 3563         inx
   9E51 B6 02 9A      [ 4] 3564         ldaa    (0x029A)
   9E54 A1 00         [ 4] 3565         cmpa    0,X     
   9E56 25 12         [ 3] 3566         bcs     L9E6A  
   9E58 27 02         [ 3] 3567         beq     L9E5C  
   9E5A 24 0C         [ 3] 3568         bcc     L9E68  
   9E5C                    3569 L9E5C:
   9E5C 08            [ 3] 3570         inx
   9E5D B6 02 9B      [ 4] 3571         ldaa    (0x029B)
   9E60 A1 00         [ 4] 3572         cmpa    0,X     
   9E62 25 06         [ 3] 3573         bcs     L9E6A  
   9E64 27 02         [ 3] 3574         beq     L9E68  
   9E66 24 00         [ 3] 3575         bcc     L9E68  
   9E68                    3576 L9E68:
   9E68 0C            [ 2] 3577         clc
   9E69 39            [ 5] 3578         rts
                           3579 
   9E6A                    3580 L9E6A:
   9E6A B6 02 98      [ 4] 3581         ldaa    (0x0298)
   9E6D 81 03         [ 2] 3582         cmpa    #0x03
   9E6F 27 F7         [ 3] 3583         beq     L9E68  
   9E71                    3584 L9E71:
   9E71 0D            [ 2] 3585         sec
   9E72 39            [ 5] 3586         rts
                           3587 
   9E73                    3588 L9E73:
   9E73 CE 04 02      [ 3] 3589         ldx     #0x0402
   9E76 B6 02 98      [ 4] 3590         ldaa    (0x0298)
   9E79 81 02         [ 2] 3591         cmpa    #0x02
   9E7B 26 03         [ 3] 3592         bne     L9E80  
   9E7D CE 04 05      [ 3] 3593         ldx     #0x0405
   9E80                    3594 L9E80:
   9E80 B6 02 99      [ 4] 3595         ldaa    (0x0299)
   9E83 A7 00         [ 4] 3596         staa    0,X     
   9E85 08            [ 3] 3597         inx
   9E86 B6 02 9A      [ 4] 3598         ldaa    (0x029A)
   9E89 A7 00         [ 4] 3599         staa    0,X     
   9E8B 08            [ 3] 3600         inx
   9E8C B6 02 9B      [ 4] 3601         ldaa    (0x029B)
   9E8F A7 00         [ 4] 3602         staa    0,X     
   9E91 39            [ 5] 3603         rts
                           3604 
                           3605 ; reset R counts
   9E92                    3606 L9E92:
   9E92 86 30         [ 2] 3607         ldaa    #0x30        
   9E94 B7 04 02      [ 4] 3608         staa    (0x0402)
   9E97 B7 04 03      [ 4] 3609         staa    (0x0403)
   9E9A B7 04 04      [ 4] 3610         staa    (0x0404)
                           3611 
   9E9D BD 8D DD      [ 6] 3612         jsr     LCDMSG2 
   9EA0 52 65 67 20 23 20  3613         .ascis  'Reg # cleared!'
        63 6C 65 61 72 65
        64 A1
                           3614 
   9EAE 39            [ 5] 3615         rts
                           3616 
                           3617 ; reset L counts
   9EAF                    3618 L9EAF:
   9EAF 86 30         [ 2] 3619         ldaa    #0x30
   9EB1 B7 04 05      [ 4] 3620         staa    (0x0405)
   9EB4 B7 04 06      [ 4] 3621         staa    (0x0406)
   9EB7 B7 04 07      [ 4] 3622         staa    (0x0407)
                           3623 
   9EBA BD 8D DD      [ 6] 3624         jsr     LCDMSG2 
   9EBD 4C 69 76 20 23 20  3625         .ascis  'Liv # cleared!'
        63 6C 65 61 72 65
        64 A1
                           3626 
   9ECB 39            [ 5] 3627         rts
                           3628 
                           3629 ; display R and L counts?
   9ECC                    3630 L9ECC:
   9ECC 86 52         [ 2] 3631         ldaa    #0x52            ;'R'
   9ECE C6 2B         [ 2] 3632         ldab    #0x2B
   9ED0 BD 8D B5      [ 6] 3633         jsr     L8DB5            ; display char here on LCD display
   9ED3 86 4C         [ 2] 3634         ldaa    #0x4C            ;'L'
   9ED5 C6 32         [ 2] 3635         ldab    #0x32
   9ED7 BD 8D B5      [ 6] 3636         jsr     L8DB5            ; display char here on LCD display
   9EDA CE 04 02      [ 3] 3637         ldx     #0x0402
   9EDD C6 2C         [ 2] 3638         ldab    #0x2C
   9EDF                    3639 L9EDF:
   9EDF A6 00         [ 4] 3640         ldaa    0,X     
   9EE1 BD 8D B5      [ 6] 3641         jsr     L8DB5            ; display 3 chars here on LCD display
   9EE4 5C            [ 2] 3642         incb
   9EE5 08            [ 3] 3643         inx
   9EE6 8C 04 05      [ 4] 3644         cpx     #0x0405
   9EE9 26 F4         [ 3] 3645         bne     L9EDF  
   9EEB C6 33         [ 2] 3646         ldab    #0x33
   9EED                    3647 L9EED:
   9EED A6 00         [ 4] 3648         ldaa    0,X     
   9EEF BD 8D B5      [ 6] 3649         jsr     L8DB5            ; display 3 chars here on LCD display
   9EF2 5C            [ 2] 3650         incb
   9EF3 08            [ 3] 3651         inx
   9EF4 8C 04 08      [ 4] 3652         cpx     #0x0408
   9EF7 26 F4         [ 3] 3653         bne     L9EED  
   9EF9 39            [ 5] 3654         rts
                           3655 
   9EFA                    3656 L9EFA:
   9EFA 96 A8         [ 3] 3657         ldaa    (0x00A8)
   9EFC BD 9F 0F      [ 6] 3658         jsr     L9F0F
   9EFF 48            [ 2] 3659         asla
   9F00 48            [ 2] 3660         asla
   9F01 48            [ 2] 3661         asla
   9F02 48            [ 2] 3662         asla
   9F03 97 13         [ 3] 3663         staa    (0x0013)
   9F05 96 A9         [ 3] 3664         ldaa    (0x00A9)
   9F07 BD 9F 0F      [ 6] 3665         jsr     L9F0F
   9F0A 9B 13         [ 3] 3666         adda    (0x0013)
   9F0C 97 A8         [ 3] 3667         staa    (0x00A8)
   9F0E 39            [ 5] 3668         rts
                           3669 
   9F0F                    3670 L9F0F:
   9F0F 81 2F         [ 2] 3671         cmpa    #0x2F
   9F11 24 02         [ 3] 3672         bcc     L9F15  
   9F13 86 30         [ 2] 3673         ldaa    #0x30
   9F15                    3674 L9F15:
   9F15 81 3A         [ 2] 3675         cmpa    #0x3A
   9F17 25 02         [ 3] 3676         bcs     L9F1B  
   9F19 80 07         [ 2] 3677         suba    #0x07
   9F1B                    3678 L9F1B:
   9F1B 80 30         [ 2] 3679         suba    #0x30
   9F1D 39            [ 5] 3680         rts
                           3681 
   9F1E                    3682 L9F1E:
   9F1E FC 02 9C      [ 5] 3683         ldd     (0x029C)
   9F21 1A 83 00 01   [ 5] 3684         cpd     #0x0001     ; 1
   9F25 27 0C         [ 3] 3685         beq     L9F33       ; password bypass?
   9F27 1A 83 03 E8   [ 5] 3686         cpd     #0x03E8     ; 1000
   9F2B 25 20         [ 3] 3687         bcs     L9F4D       ; code
   9F2D 1A 83 04 4B   [ 5] 3688         cpd     #0x044B     ; 1099
   9F31 22 1A         [ 3] 3689         bhi     L9F4D       ; code
                           3690 
   9F33                    3691 L9F33:
   9F33 BD 8D E4      [ 6] 3692         jsr     LCDMSG1 
   9F36 50 61 73 73 77 6F  3693         .ascis  'Password bypass '
        72 64 20 62 79 70
        61 73 73 A0
                           3694 
   9F46 C6 04         [ 2] 3695         ldab    #0x04
   9F48 BD 8C 30      [ 6] 3696         jsr     DLYSECSBY2           ; delay 2 sec
   9F4B 0C            [ 2] 3697         clc
   9F4C 39            [ 5] 3698         rts
                           3699 
   9F4D                    3700 L9F4D:
   9F4D BD 8C F2      [ 6] 3701         jsr     L8CF2
   9F50 BD 8D 03      [ 6] 3702         jsr     L8D03
                           3703 
   9F53 BD 8D E4      [ 6] 3704         jsr     LCDMSG1 
   9F56 43 6F 64 65 BA     3705         .ascis  'Code:'
                           3706 
   9F5B CE 02 90      [ 3] 3707         ldx     #0x0290
   9F5E 7F 00 16      [ 6] 3708         clr     (0x0016)
   9F61                    3709 L9F61:
   9F61 86 41         [ 2] 3710         ldaa    #0x41
   9F63                    3711 L9F63:
   9F63 97 15         [ 3] 3712         staa    (0x0015)
   9F65 BD 8E 95      [ 6] 3713         jsr     L8E95
   9F68 81 0D         [ 2] 3714         cmpa    #0x0D
   9F6A 26 11         [ 3] 3715         bne     L9F7D  
   9F6C 96 15         [ 3] 3716         ldaa    (0x0015)
   9F6E A7 00         [ 4] 3717         staa    0,X     
   9F70 08            [ 3] 3718         inx
   9F71 BD 8C 98      [ 6] 3719         jsr     L8C98
   9F74 96 16         [ 3] 3720         ldaa    (0x0016)
   9F76 4C            [ 2] 3721         inca
   9F77 97 16         [ 3] 3722         staa    (0x0016)
   9F79 81 05         [ 2] 3723         cmpa    #0x05
   9F7B 27 09         [ 3] 3724         beq     L9F86  
   9F7D                    3725 L9F7D:
   9F7D 96 15         [ 3] 3726         ldaa    (0x0015)
   9F7F 4C            [ 2] 3727         inca
   9F80 81 5B         [ 2] 3728         cmpa    #0x5B
   9F82 27 DD         [ 3] 3729         beq     L9F61  
   9F84 20 DD         [ 3] 3730         bra     L9F63  
                           3731 
   9F86                    3732 L9F86:
   9F86 BD 8D DD      [ 6] 3733         jsr     LCDMSG2 
   9F89 50 73 77 64 BA     3734         .ascis  'Pswd:'
                           3735 
   9F8E CE 02 88      [ 3] 3736         ldx     #0x0288
   9F91 86 41         [ 2] 3737         ldaa    #0x41
   9F93 97 16         [ 3] 3738         staa    (0x0016)
   9F95 86 C5         [ 2] 3739         ldaa    #0xC5
   9F97 97 15         [ 3] 3740         staa    (0x0015)
   9F99                    3741 L9F99:
   9F99 96 15         [ 3] 3742         ldaa    (0x0015)
   9F9B BD 8C 86      [ 6] 3743         jsr     L8C86        ; write byte to LCD
   9F9E 96 16         [ 3] 3744         ldaa    (0x0016)
   9FA0 BD 8C 98      [ 6] 3745         jsr     L8C98
   9FA3                    3746 L9FA3:
   9FA3 BD 8E 95      [ 6] 3747         jsr     L8E95
   9FA6 27 FB         [ 3] 3748         beq     L9FA3  
   9FA8 81 0D         [ 2] 3749         cmpa    #0x0D
   9FAA 26 10         [ 3] 3750         bne     L9FBC  
   9FAC 96 16         [ 3] 3751         ldaa    (0x0016)
   9FAE A7 00         [ 4] 3752         staa    0,X     
   9FB0 08            [ 3] 3753         inx
   9FB1 96 15         [ 3] 3754         ldaa    (0x0015)
   9FB3 4C            [ 2] 3755         inca
   9FB4 97 15         [ 3] 3756         staa    (0x0015)
   9FB6 81 CA         [ 2] 3757         cmpa    #0xCA
   9FB8 27 28         [ 3] 3758         beq     L9FE2  
   9FBA 20 DD         [ 3] 3759         bra     L9F99  
   9FBC                    3760 L9FBC:
   9FBC 81 01         [ 2] 3761         cmpa    #0x01
   9FBE 26 0F         [ 3] 3762         bne     L9FCF  
   9FC0 96 16         [ 3] 3763         ldaa    (0x0016)
   9FC2 4C            [ 2] 3764         inca
   9FC3 97 16         [ 3] 3765         staa    (0x0016)
   9FC5 81 5B         [ 2] 3766         cmpa    #0x5B
   9FC7 26 D0         [ 3] 3767         bne     L9F99  
   9FC9 86 41         [ 2] 3768         ldaa    #0x41
   9FCB 97 16         [ 3] 3769         staa    (0x0016)
   9FCD 20 CA         [ 3] 3770         bra     L9F99  
   9FCF                    3771 L9FCF:
   9FCF 81 02         [ 2] 3772         cmpa    #0x02
   9FD1 26 D0         [ 3] 3773         bne     L9FA3  
   9FD3 96 16         [ 3] 3774         ldaa    (0x0016)
   9FD5 4A            [ 2] 3775         deca
   9FD6 97 16         [ 3] 3776         staa    (0x0016)
   9FD8 81 40         [ 2] 3777         cmpa    #0x40
   9FDA 26 BD         [ 3] 3778         bne     L9F99  
   9FDC 86 5A         [ 2] 3779         ldaa    #0x5A
   9FDE 97 16         [ 3] 3780         staa    (0x0016)
   9FE0 20 B7         [ 3] 3781         bra     L9F99  
   9FE2                    3782 L9FE2:
   9FE2 BD A0 01      [ 6] 3783         jsr     LA001
   9FE5 25 0F         [ 3] 3784         bcs     L9FF6  
   9FE7 86 DB         [ 2] 3785         ldaa    #0xDB
   9FE9 97 AB         [ 3] 3786         staa    (0x00AB)
   9FEB FC 04 16      [ 5] 3787         ldd     (0x0416)
   9FEE C3 00 01      [ 4] 3788         addd    #0x0001
   9FF1 FD 04 16      [ 5] 3789         std     (0x0416)
   9FF4 0C            [ 2] 3790         clc
   9FF5 39            [ 5] 3791         rts
                           3792 
   9FF6                    3793 L9FF6:
   9FF6 FC 04 14      [ 5] 3794         ldd     (0x0414)
   9FF9 C3 00 01      [ 4] 3795         addd    #0x0001
   9FFC FD 04 14      [ 5] 3796         std     (0x0414)
   9FFF 0D            [ 2] 3797         sec
   A000 39            [ 5] 3798         rts
                           3799 
   A001                    3800 LA001:
   A001 B6 02 90      [ 4] 3801         ldaa    (0x0290)
   A004 B7 02 81      [ 4] 3802         staa    (0x0281)
   A007 B6 02 91      [ 4] 3803         ldaa    (0x0291)
   A00A B7 02 83      [ 4] 3804         staa    (0x0283)
   A00D B6 02 92      [ 4] 3805         ldaa    (0x0292)
   A010 B7 02 84      [ 4] 3806         staa    (0x0284)
   A013 B6 02 93      [ 4] 3807         ldaa    (0x0293)
   A016 B7 02 80      [ 4] 3808         staa    (0x0280)
   A019 B6 02 94      [ 4] 3809         ldaa    (0x0294)
   A01C B7 02 82      [ 4] 3810         staa    (0x0282)
   A01F B6 02 80      [ 4] 3811         ldaa    (0x0280)
   A022 88 13         [ 2] 3812         eora    #0x13
   A024 8B 03         [ 2] 3813         adda    #0x03
   A026 B7 02 80      [ 4] 3814         staa    (0x0280)
   A029 B6 02 81      [ 4] 3815         ldaa    (0x0281)
   A02C 88 04         [ 2] 3816         eora    #0x04
   A02E 8B 12         [ 2] 3817         adda    #0x12
   A030 B7 02 81      [ 4] 3818         staa    (0x0281)
   A033 B6 02 82      [ 4] 3819         ldaa    (0x0282)
   A036 88 06         [ 2] 3820         eora    #0x06
   A038 8B 04         [ 2] 3821         adda    #0x04
   A03A B7 02 82      [ 4] 3822         staa    (0x0282)
   A03D B6 02 83      [ 4] 3823         ldaa    (0x0283)
   A040 88 11         [ 2] 3824         eora    #0x11
   A042 8B 07         [ 2] 3825         adda    #0x07
   A044 B7 02 83      [ 4] 3826         staa    (0x0283)
   A047 B6 02 84      [ 4] 3827         ldaa    (0x0284)
   A04A 88 01         [ 2] 3828         eora    #0x01
   A04C 8B 10         [ 2] 3829         adda    #0x10
   A04E B7 02 84      [ 4] 3830         staa    (0x0284)
   A051 BD A0 AF      [ 6] 3831         jsr     LA0AF
   A054 B6 02 94      [ 4] 3832         ldaa    (0x0294)
   A057 84 17         [ 2] 3833         anda    #0x17
   A059 97 15         [ 3] 3834         staa    (0x0015)
   A05B B6 02 90      [ 4] 3835         ldaa    (0x0290)
   A05E 84 17         [ 2] 3836         anda    #0x17
   A060 97 16         [ 3] 3837         staa    (0x0016)
   A062 CE 02 80      [ 3] 3838         ldx     #0x0280
   A065                    3839 LA065:
   A065 A6 00         [ 4] 3840         ldaa    0,X     
   A067 98 15         [ 3] 3841         eora    (0x0015)
   A069 98 16         [ 3] 3842         eora    (0x0016)
   A06B A7 00         [ 4] 3843         staa    0,X     
   A06D 08            [ 3] 3844         inx
   A06E 8C 02 85      [ 4] 3845         cpx     #0x0285
   A071 26 F2         [ 3] 3846         bne     LA065  
   A073 BD A0 AF      [ 6] 3847         jsr     LA0AF
   A076 CE 02 80      [ 3] 3848         ldx     #0x0280
   A079 18 CE 02 88   [ 4] 3849         ldy     #0x0288
   A07D                    3850 LA07D:
   A07D A6 00         [ 4] 3851         ldaa    0,X     
   A07F 18 A1 00      [ 5] 3852         cmpa    0,Y     
   A082 26 0A         [ 3] 3853         bne     LA08E  
   A084 08            [ 3] 3854         inx
   A085 18 08         [ 4] 3855         iny
   A087 8C 02 85      [ 4] 3856         cpx     #0x0285
   A08A 26 F1         [ 3] 3857         bne     LA07D  
   A08C 0C            [ 2] 3858         clc
   A08D 39            [ 5] 3859         rts
                           3860 
   A08E                    3861 LA08E:
   A08E 0D            [ 2] 3862         sec
   A08F 39            [ 5] 3863         rts
                           3864 
   A090                    3865 LA090:
   A090 59 41 44 44 41     3866         .ascii  'YADDA'
                           3867 
   A095 CE 02 88      [ 3] 3868         ldx     #0x0288
   A098 18 CE A0 90   [ 4] 3869         ldy     #LA090
   A09C                    3870 LA09C:
   A09C A6 00         [ 4] 3871         ldaa    0,X
   A09E 18 A1 00      [ 5] 3872         cmpa    0,Y
   A0A1 26 0A         [ 3] 3873         bne     LA0AD
   A0A3 08            [ 3] 3874         inx
   A0A4 18 08         [ 4] 3875         iny
   A0A6 8C 02 8D      [ 4] 3876         cpx     #0x028D
   A0A9 26 F1         [ 3] 3877         bne     LA09C
   A0AB 0C            [ 2] 3878         clc
   A0AC 39            [ 5] 3879         rts
   A0AD                    3880 LA0AD:
   A0AD 0D            [ 2] 3881         sec
   A0AE 39            [ 5] 3882         rts
                           3883 
   A0AF                    3884 LA0AF:
   A0AF CE 02 80      [ 3] 3885         ldx     #0x0280
   A0B2                    3886 LA0B2:
   A0B2 A6 00         [ 4] 3887         ldaa    0,X     
   A0B4 81 5B         [ 2] 3888         cmpa    #0x5B
   A0B6 25 06         [ 3] 3889         bcs     LA0BE  
   A0B8 80 1A         [ 2] 3890         suba    #0x1A
   A0BA A7 00         [ 4] 3891         staa    0,X     
   A0BC 20 08         [ 3] 3892         bra     LA0C6  
   A0BE                    3893 LA0BE:
   A0BE 81 41         [ 2] 3894         cmpa    #0x41
   A0C0 24 04         [ 3] 3895         bcc     LA0C6  
   A0C2 8B 1A         [ 2] 3896         adda    #0x1A
   A0C4 A7 00         [ 4] 3897         staa    0,X     
   A0C6                    3898 LA0C6:
   A0C6 08            [ 3] 3899         inx
   A0C7 8C 02 85      [ 4] 3900         cpx     #0x0285
   A0CA 26 E6         [ 3] 3901         bne     LA0B2  
   A0CC 39            [ 5] 3902         rts
                           3903 
   A0CD BD 8C F2      [ 6] 3904         jsr     L8CF2
                           3905 
   A0D0 BD 8D DD      [ 6] 3906         jsr     LCDMSG2 
   A0D3 46 61 69 6C 65 64  3907         .ascis  'Failed!         '
        21 20 20 20 20 20
        20 20 20 A0
                           3908 
   A0E3 C6 02         [ 2] 3909         ldab    #0x02
   A0E5 BD 8C 30      [ 6] 3910         jsr     DLYSECSBY2           ; delay 1 sec
   A0E8 39            [ 5] 3911         rts
                           3912 
   A0E9                    3913 LA0E9:
   A0E9 C6 01         [ 2] 3914         ldab    #0x01
   A0EB BD 8C 30      [ 6] 3915         jsr     DLYSECSBY2           ; delay 0.5 sec
   A0EE 7F 00 4E      [ 6] 3916         clr     (0x004E)
   A0F1 C6 D3         [ 2] 3917         ldab    #0xD3
   A0F3 BD 87 48      [ 6] 3918         jsr     L8748   
   A0F6 BD 87 AE      [ 6] 3919         jsr     L87AE
   A0F9 BD 8C E9      [ 6] 3920         jsr     L8CE9
                           3921 
   A0FC BD 8D E4      [ 6] 3922         jsr     LCDMSG1 
   A0FF 20 20 20 56 43 52  3923         .ascis  '   VCR adjust'
        20 61 64 6A 75 73
        F4
                           3924 
   A10C BD 8D DD      [ 6] 3925         jsr     LCDMSG2 
   A10F 55 50 20 74 6F 20  3926         .ascis  'UP to clear bits'
        63 6C 65 61 72 20
        62 69 74 F3
                           3927 
   A11F 5F            [ 2] 3928         clrb
   A120 D7 62         [ 3] 3929         stab    (0x0062)
   A122 BD F9 C5      [ 6] 3930         jsr     BUTNLIT 
   A125 B6 18 04      [ 4] 3931         ldaa    PIA0PRA 
   A128 84 BF         [ 2] 3932         anda    #0xBF
   A12A B7 18 04      [ 4] 3933         staa    PIA0PRA 
   A12D BD 8E 95      [ 6] 3934         jsr     L8E95
   A130 7F 00 48      [ 6] 3935         clr     (0x0048)
   A133 7F 00 49      [ 6] 3936         clr     (0x0049)
   A136 BD 86 C4      [ 6] 3937         jsr     L86C4               ; Reset boards 1-10
   A139 86 28         [ 2] 3938         ldaa    #0x28
   A13B 97 63         [ 3] 3939         staa    (0x0063)
   A13D C6 FD         [ 2] 3940         ldab    #0xFD
   A13F BD 86 E7      [ 6] 3941         jsr     L86E7
   A142 BD A3 2E      [ 6] 3942         jsr     LA32E
   A145 7C 00 76      [ 6] 3943         inc     (0x0076)
   A148 7F 00 32      [ 6] 3944         clr     (0x0032)
   A14B                    3945 LA14B:
   A14B BD 8E 95      [ 6] 3946         jsr     L8E95
   A14E 81 0D         [ 2] 3947         cmpa    #0x0D
   A150 26 03         [ 3] 3948         bne     LA155  
   A152 7E A1 C4      [ 3] 3949         jmp     LA1C4
   A155                    3950 LA155:
   A155 86 28         [ 2] 3951         ldaa    #0x28
   A157 97 63         [ 3] 3952         staa    (0x0063)
   A159 BD 86 A4      [ 6] 3953         jsr     L86A4
   A15C 25 ED         [ 3] 3954         bcs     LA14B  
   A15E FC 04 1A      [ 5] 3955         ldd     (0x041A)
   A161 C3 00 01      [ 4] 3956         addd    #0x0001
   A164 FD 04 1A      [ 5] 3957         std     (0x041A)
   A167 BD 86 C4      [ 6] 3958         jsr     L86C4           ; Reset boards 1-10
   A16A 7C 00 4E      [ 6] 3959         inc     (0x004E)
   A16D C6 D3         [ 2] 3960         ldab    #0xD3
   A16F BD 87 48      [ 6] 3961         jsr     L8748   
   A172 BD 87 AE      [ 6] 3962         jsr     L87AE
   A175                    3963 LA175:
   A175 96 49         [ 3] 3964         ldaa    (0x0049)
   A177 81 43         [ 2] 3965         cmpa    #0x43
   A179 26 06         [ 3] 3966         bne     LA181  
   A17B 7F 00 49      [ 6] 3967         clr     (0x0049)
   A17E 7F 00 48      [ 6] 3968         clr     (0x0048)
   A181                    3969 LA181:
   A181 96 48         [ 3] 3970         ldaa    (0x0048)
   A183 81 C8         [ 2] 3971         cmpa    #0xC8
   A185 25 1F         [ 3] 3972         bcs     LA1A6  
   A187 FC 02 9C      [ 5] 3973         ldd     (0x029C)
   A18A 1A 83 00 01   [ 5] 3974         cpd     #0x0001
   A18E 27 16         [ 3] 3975         beq     LA1A6  
   A190 C6 EF         [ 2] 3976         ldab    #0xEF
   A192 BD 86 E7      [ 6] 3977         jsr     L86E7
   A195 BD 86 C4      [ 6] 3978         jsr     L86C4               ; Reset boards 1-10
   A198 7F 00 4E      [ 6] 3979         clr     (0x004E)
   A19B 7F 00 76      [ 6] 3980         clr     (0x0076)
   A19E C6 0A         [ 2] 3981         ldab    #0x0A
   A1A0 BD 8C 30      [ 6] 3982         jsr     DLYSECSBY2           ; delay 5 sec
   A1A3 7E 81 D7      [ 3] 3983         jmp     L81D7
   A1A6                    3984 LA1A6:
   A1A6 BD 8E 95      [ 6] 3985         jsr     L8E95
   A1A9 81 01         [ 2] 3986         cmpa    #0x01
   A1AB 26 10         [ 3] 3987         bne     LA1BD  
   A1AD CE 10 80      [ 3] 3988         ldx     #0x1080
   A1B0 86 34         [ 2] 3989         ldaa    #0x34
   A1B2                    3990 LA1B2:
   A1B2 6F 00         [ 6] 3991         clr     0,X     
   A1B4 A7 01         [ 4] 3992         staa    1,X     
   A1B6 08            [ 3] 3993         inx
   A1B7 08            [ 3] 3994         inx
   A1B8 8C 10 A0      [ 4] 3995         cpx     #0x10A0
   A1BB 25 F5         [ 3] 3996         bcs     LA1B2  
   A1BD                    3997 LA1BD:
   A1BD 81 0D         [ 2] 3998         cmpa    #0x0D
   A1BF 27 03         [ 3] 3999         beq     LA1C4  
   A1C1 7E A1 75      [ 3] 4000         jmp     LA175
   A1C4                    4001 LA1C4:
   A1C4 7F 00 76      [ 6] 4002         clr     (0x0076)
   A1C7 7F 00 4E      [ 6] 4003         clr     (0x004E)
   A1CA C6 DF         [ 2] 4004         ldab    #0xDF
   A1CC BD 87 48      [ 6] 4005         jsr     L8748   
   A1CF BD 87 91      [ 6] 4006         jsr     L8791   
   A1D2 7E 81 D7      [ 3] 4007         jmp     L81D7
                           4008 
   A1D5                    4009 LA1D5:
   A1D5 86 07         [ 2] 4010         ldaa    #0x07
   A1D7 B7 04 00      [ 4] 4011         staa    (0x0400)
   A1DA CC 0E 09      [ 3] 4012         ldd     #0x0E09
   A1DD 81 65         [ 2] 4013         cmpa    #0x65
   A1DF 26 05         [ 3] 4014         bne     LA1E6  
   A1E1 C1 63         [ 2] 4015         cmpb    #0x63
   A1E3 26 01         [ 3] 4016         bne     LA1E6  
   A1E5 39            [ 5] 4017         rts
                           4018 
   A1E6                    4019 LA1E6:
   A1E6 86 0E         [ 2] 4020         ldaa    #0x0E
   A1E8 B7 10 3B      [ 4] 4021         staa    PPROG  
   A1EB 86 FF         [ 2] 4022         ldaa    #0xFF
   A1ED B7 0E 00      [ 4] 4023         staa    (0x0E00)
   A1F0 B6 10 3B      [ 4] 4024         ldaa    PPROG  
   A1F3 8A 01         [ 2] 4025         oraa    #0x01
   A1F5 B7 10 3B      [ 4] 4026         staa    PPROG  
   A1F8 CE 1B 58      [ 3] 4027         ldx     #0x1B58         ; 7000
   A1FB                    4028 LA1FB:
   A1FB 09            [ 3] 4029         dex
   A1FC 26 FD         [ 3] 4030         bne     LA1FB  
   A1FE B6 10 3B      [ 4] 4031         ldaa    PPROG  
   A201 84 FE         [ 2] 4032         anda    #0xFE
   A203 B7 10 3B      [ 4] 4033         staa    PPROG  
   A206 CE 0E 00      [ 3] 4034         ldx     #0x0E00
   A209 18 CE A2 26   [ 4] 4035         ldy     #LA226
   A20D                    4036 LA20D:
   A20D C6 02         [ 2] 4037         ldab    #0x02
   A20F F7 10 3B      [ 4] 4038         stab    PPROG  
   A212 18 A6 00      [ 5] 4039         ldaa    0,Y     
   A215 18 08         [ 4] 4040         iny
   A217 A7 00         [ 4] 4041         staa    0,X     
   A219 BD A2 32      [ 6] 4042         jsr     LA232
   A21C 08            [ 3] 4043         inx
   A21D 8C 0E 0C      [ 4] 4044         cpx     #0x0E0C
   A220 26 EB         [ 3] 4045         bne     LA20D  
   A222 7F 10 3B      [ 6] 4046         clr     PPROG  
   A225 39            [ 5] 4047         rts
                           4048 
                           4049 ; initial data for 0x0E00 NVRAM??
   A226                    4050 LA226:
   A226 29 64 2A 21 32 3A  4051         .ascii  ')d*!2::4!ecq'
        3A 34 21 65 63 71
                           4052 
                           4053 ; program EEPROM
   A232                    4054 LA232:
   A232 18 3C         [ 5] 4055         pshy
   A234 C6 03         [ 2] 4056         ldab    #0x03
   A236 F7 10 3B      [ 4] 4057         stab    PPROG       ; start program
   A239 18 CE 1B 58   [ 4] 4058         ldy     #0x1B58
   A23D                    4059 LA23D:
   A23D 18 09         [ 4] 4060         dey
   A23F 26 FC         [ 3] 4061         bne     LA23D  
   A241 C6 02         [ 2] 4062         ldab    #0x02
   A243 F7 10 3B      [ 4] 4063         stab    PPROG       ; stop program
   A246 18 38         [ 6] 4064         puly
   A248 39            [ 5] 4065         rts
                           4066 
   A249                    4067 LA249:
   A249 0F            [ 2] 4068         sei
   A24A CE 00 10      [ 3] 4069         ldx     #0x0010
   A24D                    4070 LA24D:
   A24D 6F 00         [ 6] 4071         clr     0,X     
   A24F 08            [ 3] 4072         inx
   A250 8C 0E 00      [ 4] 4073         cpx     #0x0E00
   A253 26 F8         [ 3] 4074         bne     LA24D  
   A255 BD 9E AF      [ 6] 4075         jsr     L9EAF     ; reset L counts
   A258 BD 9E 92      [ 6] 4076         jsr     L9E92     ; reset R counts
   A25B 7E F8 00      [ 3] 4077         jmp     RESET     ; reset controller
                           4078 
                           4079 ; Compute and store copyright checksum
   A25E                    4080 LA25E:
   A25E 18 CE 80 03   [ 4] 4081         ldy     #CPYRTMSG       ; copyright message
   A262 CE 00 00      [ 3] 4082         ldx     #0x0000
   A265                    4083 LA265:
   A265 18 E6 00      [ 5] 4084         ldab    0,Y
   A268 3A            [ 3] 4085         abx
   A269 18 08         [ 4] 4086         iny
   A26B 18 8C 80 50   [ 5] 4087         cpy     #0x8050
   A26F 26 F4         [ 3] 4088         bne     LA265
   A271 FF 04 0B      [ 5] 4089         stx     CPYRTCS         ; store checksum here
   A274 39            [ 5] 4090         rts
                           4091 
                           4092 ; Erase EEPROM routine
   A275                    4093 LA275:
   A275 0F            [ 2] 4094         sei
   A276 7F 04 0F      [ 6] 4095         clr     ERASEFLG     ; Reset EEPROM Erase flag
   A279 86 0E         [ 2] 4096         ldaa    #0x0E
   A27B B7 10 3B      [ 4] 4097         staa    PPROG       ; ERASE mode!
   A27E 86 FF         [ 2] 4098         ldaa    #0xFF
   A280 B7 0E 20      [ 4] 4099         staa    (0x0E20)    ; save in NVRAM
   A283 B6 10 3B      [ 4] 4100         ldaa    PPROG  
   A286 8A 01         [ 2] 4101         oraa    #0x01
   A288 B7 10 3B      [ 4] 4102         staa    PPROG       ; do the ERASE
   A28B CE 1B 58      [ 3] 4103         ldx     #0x1B58       ; delay a bit
   A28E                    4104 LA28E:
   A28E 09            [ 3] 4105         dex
   A28F 26 FD         [ 3] 4106         bne     LA28E  
   A291 B6 10 3B      [ 4] 4107         ldaa    PPROG  
   A294 84 FE         [ 2] 4108         anda    #0xFE        ; stop erasing
   A296 7F 10 3B      [ 6] 4109         clr     PPROG  
                           4110 
   A299 BD F9 D8      [ 6] 4111         jsr     SERMSGW           ; display "enter serial number"
   A29C 45 6E 74 65 72 20  4112         .ascis  'Enter serial #: '
        73 65 72 69 61 6C
        20 23 3A A0
                           4113 
   A2AC CE 0E 20      [ 3] 4114         ldx     #0x0E20
   A2AF                    4115 LA2AF:
   A2AF BD F9 45      [ 6] 4116         jsr     SERIALR     ; wait for serial data
   A2B2 24 FB         [ 3] 4117         bcc     LA2AF  
                           4118 
   A2B4 BD F9 6F      [ 6] 4119         jsr     SERIALW     ; read serial data
   A2B7 C6 02         [ 2] 4120         ldab    #0x02
   A2B9 F7 10 3B      [ 4] 4121         stab    PPROG       ; protect only 0x0e20-0x0e5f
   A2BC A7 00         [ 4] 4122         staa    0,X         
   A2BE BD A2 32      [ 6] 4123         jsr     LA232       ; program byte
   A2C1 08            [ 3] 4124         inx
   A2C2 8C 0E 24      [ 4] 4125         cpx     #0x0E24
   A2C5 26 E8         [ 3] 4126         bne     LA2AF  
   A2C7 C6 02         [ 2] 4127         ldab    #0x02
   A2C9 F7 10 3B      [ 4] 4128         stab    PPROG  
   A2CC 86 DB         [ 2] 4129         ldaa    #0xDB       ; it's official
   A2CE B7 0E 24      [ 4] 4130         staa    (0x0E24)
   A2D1 BD A2 32      [ 6] 4131         jsr     LA232       ; program byte
   A2D4 7F 10 3B      [ 6] 4132         clr     PPROG  
   A2D7 86 1E         [ 2] 4133         ldaa    #0x1E
   A2D9 B7 10 35      [ 4] 4134         staa    BPROT       ; protect all but 0x0e00-0x0e1f
   A2DC 7E F8 00      [ 3] 4135         jmp     RESET       ; reset controller
                           4136 
   A2DF                    4137 LA2DF:
   A2DF 38            [ 5] 4138         pulx
   A2E0 3C            [ 4] 4139         pshx
   A2E1 8C 80 00      [ 4] 4140         cpx     #0x8000
   A2E4 25 02         [ 3] 4141         bcs     LA2E8  
   A2E6 0C            [ 2] 4142         clc
   A2E7 39            [ 5] 4143         rts
                           4144 
   A2E8                    4145 LA2E8:
   A2E8 0D            [ 2] 4146         sec
   A2E9 39            [ 5] 4147         rts
                           4148 
                           4149 ; enter and validate security code
   A2EA                    4150 LA2EA:
   A2EA CE 02 88      [ 3] 4151         ldx     #0x0288
   A2ED C6 03         [ 2] 4152         ldab    #0x03       ; 3 character code
                           4153 
   A2EF                    4154 LA2EF:
   A2EF BD F9 45      [ 6] 4155         jsr     SERIALR     ; check if available
   A2F2 24 FB         [ 3] 4156         bcc     LA2EF  
   A2F4 A7 00         [ 4] 4157         staa    0,X     
   A2F6 08            [ 3] 4158         inx
   A2F7 5A            [ 2] 4159         decb
   A2F8 26 F5         [ 3] 4160         bne     LA2EF  
                           4161 
   A2FA B6 02 88      [ 4] 4162         ldaa    (0x0288)
   A2FD 81 13         [ 2] 4163         cmpa    #0x13        ; 0x13
   A2FF 26 10         [ 3] 4164         bne     LA311  
   A301 B6 02 89      [ 4] 4165         ldaa    (0x0289)
   A304 81 10         [ 2] 4166         cmpa    #0x10        ; 0x10
   A306 26 09         [ 3] 4167         bne     LA311  
   A308 B6 02 8A      [ 4] 4168         ldaa    (0x028A)
   A30B 81 14         [ 2] 4169         cmpa    #0x14        ; 0x14
   A30D 26 02         [ 3] 4170         bne     LA311  
   A30F 0C            [ 2] 4171         clc
   A310 39            [ 5] 4172         rts
                           4173 
   A311                    4174 LA311:
   A311 0D            [ 2] 4175         sec
   A312 39            [ 5] 4176         rts
                           4177 
   A313                    4178 LA313:
   A313 36            [ 3] 4179         psha
   A314 B6 10 92      [ 4] 4180         ldaa    (0x1092)
   A317 8A 01         [ 2] 4181         oraa    #0x01
   A319                    4182 LA319:
   A319 B7 10 92      [ 4] 4183         staa    (0x1092)
   A31C 32            [ 4] 4184         pula
   A31D 39            [ 5] 4185         rts
                           4186 
   A31E                    4187 LA31E:
   A31E 36            [ 3] 4188         psha
   A31F B6 10 92      [ 4] 4189         ldaa    (0x1092)
   A322 84 FE         [ 2] 4190         anda    #0xFE
   A324 20 F3         [ 3] 4191         bra     LA319
                           4192 
   A326                    4193 LA326:
   A326 96 4E         [ 3] 4194         ldaa    (0x004E)
   A328 97 19         [ 3] 4195         staa    (0x0019)
   A32A 7F 00 4E      [ 6] 4196         clr     (0x004E)
   A32D 39            [ 5] 4197         rts
                           4198 
   A32E                    4199 LA32E:
   A32E B6 10 86      [ 4] 4200         ldaa    (0x1086)
   A331 8A 15         [ 2] 4201         oraa    #0x15
   A333 B7 10 86      [ 4] 4202         staa    (0x1086)
   A336 C6 01         [ 2] 4203         ldab    #0x01
   A338 BD 8C 30      [ 6] 4204         jsr     DLYSECSBY2           ; delay 0.5 sec
   A33B 84 EA         [ 2] 4205         anda    #0xEA
   A33D B7 10 86      [ 4] 4206         staa    (0x1086)
   A340 39            [ 5] 4207         rts
                           4208 
   A341                    4209 LA341:
   A341 B6 10 86      [ 4] 4210         ldaa    (0x1086)
   A344 8A 2A         [ 2] 4211         oraa    #0x2A               ; xx1x1x1x
   A346 B7 10 86      [ 4] 4212         staa    (0x1086)
   A349 C6 01         [ 2] 4213         ldab    #0x01
   A34B BD 8C 30      [ 6] 4214         jsr     DLYSECSBY2          ; delay 0.5 sec
   A34E 84 D5         [ 2] 4215         anda    #0xD5               ; xx0x0x0x
   A350 B7 10 86      [ 4] 4216         staa    (0x1086)
   A353 39            [ 5] 4217         rts
                           4218 
   A354                    4219 LA354:
   A354 F6 18 04      [ 4] 4220         ldab    PIA0PRA 
   A357 CA 08         [ 2] 4221         orab    #0x08
   A359 F7 18 04      [ 4] 4222         stab    PIA0PRA 
   A35C 39            [ 5] 4223         rts
                           4224 
   A35D F6 18 04      [ 4] 4225         ldab    PIA0PRA 
   A360 C4 F7         [ 2] 4226         andb    #0xF7
   A362 F7 18 04      [ 4] 4227         stab    PIA0PRA 
   A365 39            [ 5] 4228         rts
                           4229 
                           4230 ;'$' command goes here?
   A366                    4231 LA366:
   A366 7F 00 4E      [ 6] 4232         clr     (0x004E)
   A369 BD 86 C4      [ 6] 4233         jsr     L86C4           ; Reset boards 1-10
   A36C 7F 04 2A      [ 6] 4234         clr     (0x042A)
                           4235 
   A36F BD F9 D8      [ 6] 4236         jsr     SERMSGW      
   A372 45 6E 74 65 72 20  4237         .ascis  'Enter security code:' 
        73 65 63 75 72 69
        74 79 20 63 6F 64
        65 BA
                           4238 
   A386 BD A2 EA      [ 6] 4239         jsr     LA2EA
   A389 24 03         [ 3] 4240         bcc     LA38E  
   A38B 7E 83 31      [ 3] 4241         jmp     L8331
                           4242 
   A38E                    4243 LA38E:
   A38E BD F9 D8      [ 6] 4244         jsr     SERMSGW      
   A391 0C 0A 0D 44 61 76  4245         .ascii  "\f\n\rDave's Setup Utility\n\r"
        65 27 73 20 53 65
        74 75 70 20 55 74
        69 6C 69 74 79 0A
        0D
   A3AA 3C 4B 3E 69 6E 67  4246         .ascii  '<K>ing enable\n\r'
        20 65 6E 61 62 6C
        65 0A 0D
   A3B9 3C 43 3E 6C 65 61  4247         .ascii  '<C>lear random\n\r'
        72 20 72 61 6E 64
        6F 6D 0A 0D
   A3C9 3C 35 3E 20 63 68  4248         .ascii  '<5> character random\n\r'
        61 72 61 63 74 65
        72 20 72 61 6E 64
        6F 6D 0A 0D
   A3DF 3C 4C 3E 69 76 65  4249         .ascii  '<L>ive tape number clear\n\r'
        20 74 61 70 65 20
        6E 75 6D 62 65 72
        20 63 6C 65 61 72
        0A 0D
   A3F9 3C 52 3E 65 67 75  4250         .ascii  '<R>egular tape number clear\n\r'
        6C 61 72 20 74 61
        70 65 20 6E 75 6D
        62 65 72 20 63 6C
        65 61 72 0A 0D
   A416 3C 54 3E 65 73 74  4251         .ascii  '<T>est driver boards\n\r'
        20 64 72 69 76 65
        72 20 62 6F 61 72
        64 73 0A 0D
   A42C 3C 42 3E 75 62 20  4252         .ascii  '<B>ub test\n\r'
        74 65 73 74 0A 0D
   A438 3C 44 3E 65 63 6B  4253         .ascii  '<D>eck test (with tape inserted)\n\r'
        20 74 65 73 74 20
        28 77 69 74 68 20
        74 61 70 65 20 69
        6E 73 65 72 74 65
        64 29 0A 0D
   A45A 3C 37 3E 35 25 20  4254         .ascii  '<7>5% adjustment\n\r'
        61 64 6A 75 73 74
        6D 65 6E 74 0A 0D
   A46C 3C 53 3E 68 6F 77  4255         .ascii  '<S>how re-valid tapes\n\r'
        20 72 65 2D 76 61
        6C 69 64 20 74 61
        70 65 73 0A 0D
   A483 3C 4A 3E 75 6D 70  4256         .ascis  '<J>ump to system\n\r'
        20 74 6F 20 73 79
        73 74 65 6D 0A 8D
                           4257 
   A495                    4258 LA495:
   A495 BD F9 45      [ 6] 4259         jsr     SERIALR     
   A498 24 FB         [ 3] 4260         bcc     LA495  
   A49A 81 43         [ 2] 4261         cmpa    #0x43        ;'C'
   A49C 26 09         [ 3] 4262         bne     LA4A7  
   A49E 7F 04 01      [ 6] 4263         clr     (0x0401)     ;clear random
   A4A1 7F 04 2B      [ 6] 4264         clr     (0x042B)
   A4A4 7E A5 14      [ 3] 4265         jmp     LA514
   A4A7                    4266 LA4A7:
   A4A7 81 35         [ 2] 4267         cmpa    #0x35        ;'5'
   A4A9 26 0D         [ 3] 4268         bne     LA4B8  
   A4AB B6 04 01      [ 4] 4269         ldaa    (0x0401)    ;5 character random
   A4AE 84 7F         [ 2] 4270         anda    #0x7F
   A4B0 8A 7F         [ 2] 4271         oraa    #0x7F
   A4B2 B7 04 01      [ 4] 4272         staa    (0x0401)
   A4B5 7E A5 14      [ 3] 4273         jmp     LA514
   A4B8                    4274 LA4B8:
   A4B8 81 4C         [ 2] 4275         cmpa    #0x4C       ;'L'
   A4BA 26 06         [ 3] 4276         bne     LA4C2
   A4BC BD 9E AF      [ 6] 4277         jsr     L9EAF       ; reset Liv counts
   A4BF 7E A5 14      [ 3] 4278         jmp     LA514
   A4C2                    4279 LA4C2:
   A4C2 81 52         [ 2] 4280         cmpa    #0x52       ;'R'
   A4C4 26 06         [ 3] 4281         bne     LA4CC  
   A4C6 BD 9E 92      [ 6] 4282         jsr     L9E92       ; reset Reg counts
   A4C9 7E A5 14      [ 3] 4283         jmp     LA514
   A4CC                    4284 LA4CC:
   A4CC 81 54         [ 2] 4285         cmpa    #0x54       ;'T'
   A4CE 26 06         [ 3] 4286         bne     LA4D6  
   A4D0 BD A5 65      [ 6] 4287         jsr     LA565       ;test driver boards
   A4D3 7E A5 14      [ 3] 4288         jmp     LA514
   A4D6                    4289 LA4D6:
   A4D6 81 42         [ 2] 4290         cmpa    #0x42       ;'B'
   A4D8 26 06         [ 3] 4291         bne     LA4E0  
   A4DA BD A5 26      [ 6] 4292         jsr     LA526       ;bulb test?
   A4DD 7E A5 14      [ 3] 4293         jmp     LA514
   A4E0                    4294 LA4E0:
   A4E0 81 44         [ 2] 4295         cmpa    #0x44       ;'D'
   A4E2 26 06         [ 3] 4296         bne     LA4EA  
   A4E4 BD A5 3C      [ 6] 4297         jsr     LA53C       ;deck test
   A4E7 7E A5 14      [ 3] 4298         jmp     LA514
   A4EA                    4299 LA4EA:
   A4EA 81 37         [ 2] 4300         cmpa    #0x37       ;'7'
   A4EC 26 08         [ 3] 4301         bne     LA4F6  
   A4EE C6 FB         [ 2] 4302         ldab    #0xFB
   A4F0 BD 86 E7      [ 6] 4303         jsr     L86E7       ;5% adjustment
   A4F3 7E A5 14      [ 3] 4304         jmp     LA514
   A4F6                    4305 LA4F6:
   A4F6 81 4A         [ 2] 4306         cmpa    #0x4A       ;'J'
   A4F8 26 03         [ 3] 4307         bne     LA4FD  
   A4FA 7E F8 00      [ 3] 4308         jmp     RESET       ;jump to system (reset)
   A4FD                    4309 LA4FD:
   A4FD 81 4B         [ 2] 4310         cmpa    #0x4B       ;'K'
   A4FF 26 06         [ 3] 4311         bne     LA507  
   A501 7C 04 2A      [ 6] 4312         inc     (0x042A)    ;King enable
   A504 7E A5 14      [ 3] 4313         jmp     LA514
   A507                    4314 LA507:
   A507 81 53         [ 2] 4315         cmpa    #0x53       ;'S'
   A509 26 06         [ 3] 4316         bne     LA511  
   A50B BD AB 7C      [ 6] 4317         jsr     LAB7C       ;show re-valid tapes
   A50E 7E A5 14      [ 3] 4318         jmp     LA514
   A511                    4319 LA511:
   A511 7E A4 95      [ 3] 4320         jmp     LA495
   A514                    4321 LA514:
   A514 86 07         [ 2] 4322         ldaa    #0x07
   A516 BD F9 6F      [ 6] 4323         jsr     SERIALW      
   A519 C6 01         [ 2] 4324         ldab    #0x01
   A51B BD 8C 30      [ 6] 4325         jsr     DLYSECSBY2  ; delay 0.5 sec
   A51E 86 07         [ 2] 4326         ldaa    #0x07
   A520 BD F9 6F      [ 6] 4327         jsr     SERIALW      
   A523 7E A3 8E      [ 3] 4328         jmp     LA38E
                           4329 
                           4330 ; bulb test
   A526                    4331 LA526:
   A526 5F            [ 2] 4332         clrb
   A527 BD F9 C5      [ 6] 4333         jsr     BUTNLIT 
   A52A                    4334 LA52A:
   A52A F6 10 0A      [ 4] 4335         ldab    PORTE
   A52D C8 FF         [ 2] 4336         eorb    #0xFF
   A52F BD F9 C5      [ 6] 4337         jsr     BUTNLIT 
   A532 C1 80         [ 2] 4338         cmpb    #0x80
   A534 26 F4         [ 3] 4339         bne     LA52A  
   A536 C6 02         [ 2] 4340         ldab    #0x02
   A538 BD 8C 30      [ 6] 4341         jsr     DLYSECSBY2           ; delay 1 sec
   A53B 39            [ 5] 4342         rts
                           4343 
                           4344 ; deck test
   A53C                    4345 LA53C:
   A53C C6 FD         [ 2] 4346         ldab    #0xFD
   A53E BD 86 E7      [ 6] 4347         jsr     L86E7
   A541 C6 06         [ 2] 4348         ldab    #0x06
   A543 BD 8C 30      [ 6] 4349         jsr     DLYSECSBY2           ; delay 3 sec
   A546 C6 FB         [ 2] 4350         ldab    #0xFB
   A548 BD 86 E7      [ 6] 4351         jsr     L86E7
   A54B C6 06         [ 2] 4352         ldab    #0x06
   A54D BD 8C 30      [ 6] 4353         jsr     DLYSECSBY2           ; delay 3 sec
   A550 C6 FD         [ 2] 4354         ldab    #0xFD
   A552 BD 86 E7      [ 6] 4355         jsr     L86E7
   A555 C6 F7         [ 2] 4356         ldab    #0xF7
   A557 BD 86 E7      [ 6] 4357         jsr     L86E7
   A55A C6 06         [ 2] 4358         ldab    #0x06
   A55C BD 8C 30      [ 6] 4359         jsr     DLYSECSBY2           ; delay 3 sec
   A55F C6 EF         [ 2] 4360         ldab    #0xEF
   A561 BD 86 E7      [ 6] 4361         jsr     L86E7
   A564 39            [ 5] 4362         rts
                           4363 
                           4364 ; test driver boards
   A565                    4365 LA565:
   A565 BD F9 45      [ 6] 4366         jsr     SERIALR     
   A568 24 08         [ 3] 4367         bcc     LA572  
   A56A 81 1B         [ 2] 4368         cmpa    #0x1B
   A56C 26 04         [ 3] 4369         bne     LA572  
   A56E BD 86 C4      [ 6] 4370         jsr     L86C4           ; Reset boards 1-10
   A571 39            [ 5] 4371         rts
   A572                    4372 LA572:
   A572 86 08         [ 2] 4373         ldaa    #0x08
   A574 97 15         [ 3] 4374         staa    (0x0015)
   A576 BD 86 C4      [ 6] 4375         jsr     L86C4           ; Reset boards 1-10
   A579 86 01         [ 2] 4376         ldaa    #0x01
   A57B                    4377 LA57B:
   A57B 36            [ 3] 4378         psha
   A57C 16            [ 2] 4379         tab
   A57D BD F9 C5      [ 6] 4380         jsr     BUTNLIT 
   A580 B6 18 04      [ 4] 4381         ldaa    PIA0PRA 
   A583 88 08         [ 2] 4382         eora    #0x08
   A585 B7 18 04      [ 4] 4383         staa    PIA0PRA 
   A588 32            [ 4] 4384         pula
   A589 B7 10 80      [ 4] 4385         staa    (0x1080)
   A58C B7 10 84      [ 4] 4386         staa    (0x1084)
   A58F B7 10 88      [ 4] 4387         staa    (0x1088)
   A592 B7 10 8C      [ 4] 4388         staa    (0x108C)
   A595 B7 10 90      [ 4] 4389         staa    (0x1090)
   A598 B7 10 94      [ 4] 4390         staa    (0x1094)
   A59B B7 10 98      [ 4] 4391         staa    (0x1098)
   A59E B7 10 9C      [ 4] 4392         staa    (0x109C)
   A5A1 C6 14         [ 2] 4393         ldab    #0x14
   A5A3 BD A6 52      [ 6] 4394         jsr     LA652
   A5A6 49            [ 2] 4395         rola
   A5A7 36            [ 3] 4396         psha
   A5A8 D6 15         [ 3] 4397         ldab    (0x0015)
   A5AA 5A            [ 2] 4398         decb
   A5AB D7 15         [ 3] 4399         stab    (0x0015)
   A5AD BD F9 95      [ 6] 4400         jsr     DIAGDGT          ; write digit to the diag display
   A5B0 37            [ 3] 4401         pshb
   A5B1 C6 27         [ 2] 4402         ldab    #0x27
   A5B3 96 15         [ 3] 4403         ldaa    (0x0015)
   A5B5 0C            [ 2] 4404         clc
   A5B6 89 30         [ 2] 4405         adca    #0x30
   A5B8 BD 8D B5      [ 6] 4406         jsr     L8DB5            ; display char here on LCD display
   A5BB 33            [ 4] 4407         pulb
   A5BC 32            [ 4] 4408         pula
   A5BD 5D            [ 2] 4409         tstb
   A5BE 26 BB         [ 3] 4410         bne     LA57B  
   A5C0 86 08         [ 2] 4411         ldaa    #0x08
   A5C2 97 15         [ 3] 4412         staa    (0x0015)
   A5C4 BD 86 C4      [ 6] 4413         jsr     L86C4           ; Reset boards 1-10
   A5C7 86 01         [ 2] 4414         ldaa    #0x01
   A5C9                    4415 LA5C9:
   A5C9 B7 10 82      [ 4] 4416         staa    (0x1082)
   A5CC B7 10 86      [ 4] 4417         staa    (0x1086)
   A5CF B7 10 8A      [ 4] 4418         staa    (0x108A)
   A5D2 B7 10 8E      [ 4] 4419         staa    (0x108E)
   A5D5 B7 10 92      [ 4] 4420         staa    (0x1092)
   A5D8 B7 10 96      [ 4] 4421         staa    (0x1096)
   A5DB B7 10 9A      [ 4] 4422         staa    (0x109A)
   A5DE B7 10 9E      [ 4] 4423         staa    (0x109E)
   A5E1 C6 14         [ 2] 4424         ldab    #0x14
   A5E3 BD A6 52      [ 6] 4425         jsr     LA652
   A5E6 49            [ 2] 4426         rola
   A5E7 36            [ 3] 4427         psha
   A5E8 D6 15         [ 3] 4428         ldab    (0x0015)
   A5EA 5A            [ 2] 4429         decb
   A5EB D7 15         [ 3] 4430         stab    (0x0015)
   A5ED BD F9 95      [ 6] 4431         jsr     DIAGDGT           ; write digit to the diag display
   A5F0 37            [ 3] 4432         pshb
   A5F1 C6 27         [ 2] 4433         ldab    #0x27
   A5F3 96 15         [ 3] 4434         ldaa    (0x0015)
   A5F5 0C            [ 2] 4435         clc
   A5F6 89 30         [ 2] 4436         adca    #0x30
   A5F8 BD 8D B5      [ 6] 4437         jsr     L8DB5            ; display char here on LCD display
   A5FB 33            [ 4] 4438         pulb
   A5FC 32            [ 4] 4439         pula
   A5FD 7D 00 15      [ 6] 4440         tst     (0x0015)
   A600 26 C7         [ 3] 4441         bne     LA5C9  
   A602 BD 86 C4      [ 6] 4442         jsr     L86C4           ; Reset boards 1-10
   A605 CE 10 80      [ 3] 4443         ldx     #0x1080
   A608 C6 00         [ 2] 4444         ldab    #0x00
   A60A                    4445 LA60A:
   A60A 86 FF         [ 2] 4446         ldaa    #0xFF
   A60C A7 00         [ 4] 4447         staa    0,X
   A60E A7 02         [ 4] 4448         staa    2,X     
   A610 37            [ 3] 4449         pshb
   A611 C6 1E         [ 2] 4450         ldab    #0x1E
   A613 BD A6 52      [ 6] 4451         jsr     LA652
   A616 33            [ 4] 4452         pulb
   A617 86 00         [ 2] 4453         ldaa    #0x00
   A619 A7 00         [ 4] 4454         staa    0,X     
   A61B A7 02         [ 4] 4455         staa    2,X     
   A61D 5C            [ 2] 4456         incb
   A61E 3C            [ 4] 4457         pshx
   A61F BD F9 95      [ 6] 4458         jsr     DIAGDGT               ; write digit to the diag display
   A622 37            [ 3] 4459         pshb
   A623 C6 27         [ 2] 4460         ldab    #0x27
   A625 32            [ 4] 4461         pula
   A626 36            [ 3] 4462         psha
   A627 0C            [ 2] 4463         clc
   A628 89 30         [ 2] 4464         adca    #0x30
   A62A BD 8D B5      [ 6] 4465         jsr     L8DB5            ; display char here on LCD display
   A62D 33            [ 4] 4466         pulb
   A62E 38            [ 5] 4467         pulx
   A62F 08            [ 3] 4468         inx
   A630 08            [ 3] 4469         inx
   A631 08            [ 3] 4470         inx
   A632 08            [ 3] 4471         inx
   A633 8C 10 9D      [ 4] 4472         cpx     #0x109D
   A636 25 D2         [ 3] 4473         bcs     LA60A  
   A638 CE 10 80      [ 3] 4474         ldx     #0x1080
   A63B                    4475 LA63B:
   A63B 86 FF         [ 2] 4476         ldaa    #0xFF
   A63D A7 00         [ 4] 4477         staa    0,X     
   A63F A7 02         [ 4] 4478         staa    2,X     
   A641 08            [ 3] 4479         inx
   A642 08            [ 3] 4480         inx
   A643 08            [ 3] 4481         inx
   A644 08            [ 3] 4482         inx
   A645 8C 10 9D      [ 4] 4483         cpx     #0x109D
   A648 25 F1         [ 3] 4484         bcs     LA63B  
   A64A C6 06         [ 2] 4485         ldab    #0x06
   A64C BD 8C 30      [ 6] 4486         jsr     DLYSECSBY2           ; delay 3 sec
   A64F 7E A5 65      [ 3] 4487         jmp     LA565
   A652                    4488 LA652:
   A652 36            [ 3] 4489         psha
   A653 4F            [ 2] 4490         clra
   A654 DD 23         [ 4] 4491         std     CDTIMR5
   A656                    4492 LA656:
   A656 7D 00 24      [ 6] 4493         tst     CDTIMR5+1
   A659 26 FB         [ 3] 4494         bne     LA656  
   A65B 32            [ 4] 4495         pula
   A65C 39            [ 5] 4496         rts
                           4497 
                           4498 ; Comma-seperated text
   A65D                    4499 LA65D:
   A65D 30 2C 43 68 75 63  4500         .ascii  '0,Chuck,Mouth,'
        6B 2C 4D 6F 75 74
        68 2C
   A66B 31 2C 48 65 61 64  4501         .ascii  '1,Head left,'
        20 6C 65 66 74 2C
   A677 32 2C 48 65 61 64  4502         .ascii  '2,Head right,'
        20 72 69 67 68 74
        2C
   A684 32 2C 48 65 61 64  4503         .ascii  '2,Head up,'
        20 75 70 2C
   A68E 32 2C 45 79 65 73  4504         .ascii  '2,Eyes right,'
        20 72 69 67 68 74
        2C
   A69B 31 2C 45 79 65 6C  4505         .ascii  '1,Eyelids,'
        69 64 73 2C
   A6A5 31 2C 52 69 67 68  4506         .ascii  '1,Right hand,'
        74 20 68 61 6E 64
        2C
   A6B2 32 2C 45 79 65 73  4507         .ascii  '2,Eyes left,'
        20 6C 65 66 74 2C
   A6BE 31 2C 38 2C 48 65  4508         .ascii  '1,8,Helen,Mouth,'
        6C 65 6E 2C 4D 6F
        75 74 68 2C
   A6CE 31 2C 48 65 61 64  4509         .ascii  '1,Head left,'
        20 6C 65 66 74 2C
   A6DA 32 2C 48 65 61 64  4510         .ascii  '2,Head right,'
        20 72 69 67 68 74
        2C
   A6E7 32 2C 48 65 61 64  4511         .ascii  '2,Head up,'
        20 75 70 2C
   A6F1 32 2C 45 79 65 73  4512         .ascii  '2,Eyes right,'
        20 72 69 67 68 74
        2C
   A6FE 31 2C 45 79 65 6C  4513         .ascii  '1,Eyelids,'
        69 64 73 2C
   A708 31 2C 52 69 67 68  4514         .ascii  '1,Right hand,'
        74 20 68 61 6E 64
        2C
   A715 32 2C 45 79 65 73  4515         .ascii  '2,Eyes left,'
        20 6C 65 66 74 2C
   A721 31 2C 36 2C 4D 75  4516         .ascii  '1,6,Munch,Mouth,'
        6E 63 68 2C 4D 6F
        75 74 68 2C
   A731 31 2C 48 65 61 64  4517         .ascii  '1,Head left,'
        20 6C 65 66 74 2C
   A73D 32 2C 48 65 61 64  4518         .ascii  '2,Head right,'
        20 72 69 67 68 74
        2C
   A74A 32 2C 4C 65 66 74  4519         .ascii  '2,Left arm,'
        20 61 72 6D 2C
   A755 32 2C 45 79 65 73  4520         .ascii  '2,Eyes right,'
        20 72 69 67 68 74
        2C
   A762 31 2C 45 79 65 6C  4521         .ascii  '1,Eyelids,'
        69 64 73 2C
   A76C 31 2C 52 69 67 68  4522         .ascii  '1,Right arm,'
        74 20 61 72 6D 2C
   A778 32 2C 45 79 65 73  4523         .ascii  '2,Eyes left,'
        20 6C 65 66 74 2C
   A784 31 2C 32 2C 4A 61  4524         .ascii  '1,2,Jasper,Mouth,'
        73 70 65 72 2C 4D
        6F 75 74 68 2C
   A795 31 2C 48 65 61 64  4525         .ascii  '1,Head left,'
        20 6C 65 66 74 2C
   A7A1 32 2C 48 65 61 64  4526         .ascii  '2,Head right,'
        20 72 69 67 68 74
        2C
   A7AE 32 2C 48 65 61 64  4527         .ascii  '2,Head up,'
        20 75 70 2C
   A7B8 32 2C 45 79 65 73  4528         .ascii  '2,Eyes right,'
        20 72 69 67 68 74
        2C
   A7C5 31 2C 45 79 65 6C  4529         .ascii  '1,Eyelids,'
        69 64 73 2C
   A7CF 31 2C 48 61 6E 64  4530         .ascii  '1,Hands,'
        73 2C
   A7D7 32 2C 45 79 65 73  4531         .ascii  '2,Eyes left,'
        20 6C 65 66 74 2C
   A7E3 31 2C 34 2C 50 61  4532         .ascii  '1,4,Pasqually,Mouth-Mustache,'
        73 71 75 61 6C 6C
        79 2C 4D 6F 75 74
        68 2D 4D 75 73 74
        61 63 68 65 2C
   A800 31 2C 48 65 61 64  4533         .ascii  '1,Head left,'
        20 6C 65 66 74 2C
   A80C 32 2C 48 65 61 64  4534         .ascii  '2,Head right,'
        20 72 69 67 68 74
        2C
   A819 32 2C 4C 65 66 74  4535         .ascii  '2,Left arm,'
        20 61 72 6D 2C
   A824 32 2C 45 79 65 73  4536         .ascii  '2,Eyes right,'
        20 72 69 67 68 74
        2C
   A831 31 2C 45 79 65 6C  4537         .ascii  '1,Eyelids,'
        69 64 73 2C
   A83B 31 2C 52 69 67 68  4538         .ascii  '1,Right arm,'
        74 20 61 72 6D 2C
   A847 32 2C 45 79 65 73  4539         .ascii  '2,Eyes left,1,'
        20 6C 65 66 74 2C
        31 2C
                           4540 
   A855                    4541 LA855:
   A855 3C            [ 4] 4542         pshx
   A856 BD 86 C4      [ 6] 4543         jsr     L86C4           ; Reset boards 1-10
   A859 CE 10 80      [ 3] 4544         ldx     #0x1080
   A85C 86 20         [ 2] 4545         ldaa    #0x20
   A85E A7 00         [ 4] 4546         staa    0,X
   A860 A7 04         [ 4] 4547         staa    4,X
   A862 A7 08         [ 4] 4548         staa    8,X
   A864 A7 0C         [ 4] 4549         staa    12,X
   A866 A7 10         [ 4] 4550         staa    16,X
   A868 38            [ 5] 4551         pulx
   A869 39            [ 5] 4552         rts
                           4553 
   A86A                    4554 LA86A:
   A86A BD A3 2E      [ 6] 4555         jsr     LA32E
                           4556 
   A86D BD 8D E4      [ 6] 4557         jsr     LCDMSG1 
   A870 20 20 20 20 57 61  4558         .ascis  '    Warm-Up  '
        72 6D 2D 55 70 20
        A0
                           4559 
   A87D BD 8D DD      [ 6] 4560         jsr     LCDMSG2 
   A880 43 75 72 74 61 69  4561         .ascis  'Curtains opening'
        6E 73 20 6F 70 65
        6E 69 6E E7
                           4562 
   A890 C6 14         [ 2] 4563         ldab    #0x14
   A892 BD 8C 30      [ 6] 4564         jsr     DLYSECSBY2           ; delay 10 sec
   A895                    4565 LA895:
   A895 BD A8 55      [ 6] 4566         jsr     LA855
   A898 C6 02         [ 2] 4567         ldab    #0x02
   A89A BD 8C 30      [ 6] 4568         jsr     DLYSECSBY2           ; delay 1 sec
   A89D CE A6 5D      [ 3] 4569         ldx     #LA65D
   A8A0 C6 05         [ 2] 4570         ldab    #0x05
   A8A2 D7 12         [ 3] 4571         stab    (0x0012)
   A8A4                    4572 LA8A4:
   A8A4 C6 08         [ 2] 4573         ldab    #0x08
   A8A6 D7 13         [ 3] 4574         stab    (0x0013)
   A8A8 BD A9 41      [ 6] 4575         jsr     LA941
   A8AB BD A9 4C      [ 6] 4576         jsr     LA94C
   A8AE C6 02         [ 2] 4577         ldab    #0x02
   A8B0 BD 8C 30      [ 6] 4578         jsr     DLYSECSBY2           ; delay 1 sec
   A8B3                    4579 LA8B3:
   A8B3 BD A9 5E      [ 6] 4580         jsr     LA95E
   A8B6 A6 00         [ 4] 4581         ldaa    0,X     
   A8B8 80 30         [ 2] 4582         suba    #0x30
   A8BA 08            [ 3] 4583         inx
   A8BB 08            [ 3] 4584         inx
   A8BC 36            [ 3] 4585         psha
   A8BD 7C 00 4C      [ 6] 4586         inc     (0x004C)
   A8C0 3C            [ 4] 4587         pshx
   A8C1 BD 88 E5      [ 6] 4588         jsr     L88E5
   A8C4 38            [ 5] 4589         pulx
   A8C5 86 4F         [ 2] 4590         ldaa    #0x4F            ;'O'
   A8C7 C6 0C         [ 2] 4591         ldab    #0x0C
   A8C9 BD 8D B5      [ 6] 4592         jsr     L8DB5            ; display char here on LCD display
   A8CC 86 6E         [ 2] 4593         ldaa    #0x6E            ;'n'
   A8CE C6 0D         [ 2] 4594         ldab    #0x0D
   A8D0 BD 8D B5      [ 6] 4595         jsr     L8DB5            ; display char here on LCD display
   A8D3 CC 20 0E      [ 3] 4596         ldd     #0x200E           ;' '
   A8D6 BD 8D B5      [ 6] 4597         jsr     L8DB5            ; display char here on LCD display
   A8D9 7A 00 4C      [ 6] 4598         dec     (0x004C)
   A8DC 32            [ 4] 4599         pula
   A8DD 36            [ 3] 4600         psha
   A8DE C6 64         [ 2] 4601         ldab    #0x64
   A8E0 3D            [10] 4602         mul
   A8E1 DD 23         [ 4] 4603         std     CDTIMR5
   A8E3                    4604 LA8E3:
   A8E3 DC 23         [ 4] 4605         ldd     CDTIMR5
   A8E5 26 FC         [ 3] 4606         bne     LA8E3  
   A8E7 BD 8E 95      [ 6] 4607         jsr     L8E95
   A8EA 81 0D         [ 2] 4608         cmpa    #0x0D
   A8EC 26 05         [ 3] 4609         bne     LA8F3  
   A8EE BD A9 75      [ 6] 4610         jsr     LA975
   A8F1 20 10         [ 3] 4611         bra     LA903  
   A8F3                    4612 LA8F3:
   A8F3 81 01         [ 2] 4613         cmpa    #0x01
   A8F5 26 04         [ 3] 4614         bne     LA8FB  
   A8F7 32            [ 4] 4615         pula
   A8F8 7E A8 95      [ 3] 4616         jmp     LA895
   A8FB                    4617 LA8FB:
   A8FB 81 02         [ 2] 4618         cmpa    #0x02
   A8FD 26 04         [ 3] 4619         bne     LA903  
   A8FF 32            [ 4] 4620         pula
   A900 7E A9 35      [ 3] 4621         jmp     LA935
   A903                    4622 LA903:
   A903 3C            [ 4] 4623         pshx
   A904 BD 88 E5      [ 6] 4624         jsr     L88E5
   A907 38            [ 5] 4625         pulx
   A908 86 66         [ 2] 4626         ldaa    #0x66            ;'f'
   A90A C6 0D         [ 2] 4627         ldab    #0x0D
   A90C BD 8D B5      [ 6] 4628         jsr     L8DB5            ; display char here on LCD display
   A90F 86 66         [ 2] 4629         ldaa    #0x66            ;'f'
   A911 C6 0E         [ 2] 4630         ldab    #0x0E
   A913 BD 8D B5      [ 6] 4631         jsr     L8DB5            ; display char here on LCD display
   A916 32            [ 4] 4632         pula
   A917 C6 64         [ 2] 4633         ldab    #0x64
   A919 3D            [10] 4634         mul
   A91A DD 23         [ 4] 4635         std     CDTIMR5
   A91C                    4636 LA91C:
   A91C DC 23         [ 4] 4637         ldd     CDTIMR5
   A91E 26 FC         [ 3] 4638         bne     LA91C  
   A920 BD A8 55      [ 6] 4639         jsr     LA855
   A923 7C 00 4B      [ 6] 4640         inc     (0x004B)
   A926 96 4B         [ 3] 4641         ldaa    (0x004B)
   A928 81 48         [ 2] 4642         cmpa    #0x48
   A92A 25 87         [ 3] 4643         bcs     LA8B3  
   A92C 96 4C         [ 3] 4644         ldaa    (0x004C)
   A92E 81 34         [ 2] 4645         cmpa    #0x34
   A930 27 03         [ 3] 4646         beq     LA935  
   A932 7E A8 A4      [ 3] 4647         jmp     LA8A4
   A935                    4648 LA935:
   A935 C6 02         [ 2] 4649         ldab    #0x02
   A937 BD 8C 30      [ 6] 4650         jsr     DLYSECSBY2          ; delay 1 sec
   A93A BD 86 C4      [ 6] 4651         jsr     L86C4               ; Reset boards 1-10
   A93D BD A3 41      [ 6] 4652         jsr     LA341
   A940 39            [ 5] 4653         rts
                           4654 
   A941                    4655 LA941:
   A941 A6 00         [ 4] 4656         ldaa    0,X     
   A943 08            [ 3] 4657         inx
   A944 08            [ 3] 4658         inx
   A945 97 4C         [ 3] 4659         staa    (0x004C)
   A947 86 40         [ 2] 4660         ldaa    #0x40
   A949 97 4B         [ 3] 4661         staa    (0x004B)
   A94B 39            [ 5] 4662         rts
                           4663 
   A94C                    4664 LA94C:
   A94C BD 8C F2      [ 6] 4665         jsr     L8CF2
   A94F                    4666 LA94F:
   A94F A6 00         [ 4] 4667         ldaa    0,X     
   A951 08            [ 3] 4668         inx
   A952 81 2C         [ 2] 4669         cmpa    #0x2C
   A954 27 07         [ 3] 4670         beq     LA95D  
   A956 36            [ 3] 4671         psha
   A957 BD 8E 70      [ 6] 4672         jsr     L8E70
   A95A 32            [ 4] 4673         pula
   A95B 20 F2         [ 3] 4674         bra     LA94F  
   A95D                    4675 LA95D:
   A95D 39            [ 5] 4676         rts
                           4677 
   A95E                    4678 LA95E:
   A95E BD 8D 03      [ 6] 4679         jsr     L8D03
   A961 86 C0         [ 2] 4680         ldaa    #0xC0
   A963 BD 8E 4B      [ 6] 4681         jsr     L8E4B
   A966                    4682 LA966:
   A966 A6 00         [ 4] 4683         ldaa    0,X     
   A968 08            [ 3] 4684         inx
   A969 81 2C         [ 2] 4685         cmpa    #0x2C
   A96B 27 07         [ 3] 4686         beq     LA974  
   A96D 36            [ 3] 4687         psha
   A96E BD 8E 70      [ 6] 4688         jsr     L8E70
   A971 32            [ 4] 4689         pula
   A972 20 F2         [ 3] 4690         bra     LA966  
   A974                    4691 LA974:
   A974 39            [ 5] 4692         rts
                           4693 
   A975                    4694 LA975:
   A975 BD 8E 95      [ 6] 4695         jsr     L8E95
   A978 4D            [ 2] 4696         tsta
   A979 27 FA         [ 3] 4697         beq     LA975  
   A97B 39            [ 5] 4698         rts
                           4699 
   A97C                    4700 LA97C:
   A97C 7F 00 60      [ 6] 4701         clr     (0x0060)
   A97F FC 02 9C      [ 5] 4702         ldd     (0x029C)
   A982 1A 83 00 01   [ 5] 4703         cpd     #0x0001
   A986 27 0C         [ 3] 4704         beq     LA994  
   A988 1A 83 03 E8   [ 5] 4705         cpd     #0x03E8
   A98C 2D 7D         [ 3] 4706         blt     LAA0B  
   A98E 1A 83 04 4B   [ 5] 4707         cpd     #0x044B
   A992 22 77         [ 3] 4708         bhi     LAA0B  
   A994                    4709 LA994:
   A994 C6 40         [ 2] 4710         ldab    #0x40
   A996 D7 62         [ 3] 4711         stab    (0x0062)
   A998 BD F9 C5      [ 6] 4712         jsr     BUTNLIT 
   A99B C6 64         [ 2] 4713         ldab    #0x64           ; delay 1 sec
   A99D BD 8C 22      [ 6] 4714         jsr     DLYSECSBY100
   A9A0 BD 86 C4      [ 6] 4715         jsr     L86C4           ; Reset boards 1-10
   A9A3 BD 8C E9      [ 6] 4716         jsr     L8CE9
                           4717 
   A9A6 BD 8D E4      [ 6] 4718         jsr     LCDMSG1 
   A9A9 20 20 20 20 20 53  4719         .ascis  '     STUDIO'
        54 55 44 49 CF
                           4720 
   A9B4 BD 8D DD      [ 6] 4721         jsr     LCDMSG2 
   A9B7 70 72 6F 67 72 61  4722         .ascis  'programming mode'
        6D 6D 69 6E 67 20
        6D 6F 64 E5
                           4723 
   A9C7 BD A3 2E      [ 6] 4724         jsr     LA32E
   A9CA BD 99 9E      [ 6] 4725         jsr     L999E
   A9CD BD 99 B1      [ 6] 4726         jsr     L99B1
   A9D0 CE 20 00      [ 3] 4727         ldx     #0x2000
   A9D3                    4728 LA9D3:
   A9D3 18 CE 00 C0   [ 4] 4729         ldy     #0x00C0
   A9D7                    4730 LA9D7:
   A9D7 18 09         [ 4] 4731         dey
   A9D9 26 0A         [ 3] 4732         bne     LA9E5  
   A9DB BD A9 F4      [ 6] 4733         jsr     LA9F4
   A9DE 96 60         [ 3] 4734         ldaa    (0x0060)
   A9E0 26 29         [ 3] 4735         bne     LAA0B  
   A9E2 CE 20 00      [ 3] 4736         ldx     #0x2000
   A9E5                    4737 LA9E5:
   A9E5 B6 10 A8      [ 4] 4738         ldaa    (0x10A8)
   A9E8 84 01         [ 2] 4739         anda    #0x01
   A9EA 27 EB         [ 3] 4740         beq     LA9D7  
   A9EC B6 10 A9      [ 4] 4741         ldaa    (0x10A9)
   A9EF A7 00         [ 4] 4742         staa    0,X     
   A9F1 08            [ 3] 4743         inx
   A9F2 20 DF         [ 3] 4744         bra     LA9D3
                           4745 
   A9F4                    4746 LA9F4:
   A9F4 CE 20 00      [ 3] 4747         ldx     #0x2000
   A9F7 18 CE 10 80   [ 4] 4748         ldy     #0x1080
   A9FB                    4749 LA9FB:
   A9FB A6 00         [ 4] 4750         ldaa    0,X     
   A9FD 18 A7 00      [ 5] 4751         staa    0,Y     
   AA00 08            [ 3] 4752         inx
   AA01 18 08         [ 4] 4753         iny
   AA03 18 08         [ 4] 4754         iny
   AA05 8C 20 10      [ 4] 4755         cpx     #0x2010
   AA08 25 F1         [ 3] 4756         bcs     LA9FB  
   AA0A 39            [ 5] 4757         rts
   AA0B                    4758 LAA0B:
   AA0B 39            [ 5] 4759         rts
                           4760 
   AA0C                    4761 LAA0C:
   AA0C CC 48 37      [ 3] 4762         ldd     #0x4837           ;'H'
   AA0F                    4763 LAA0F:
   AA0F BD 8D B5      [ 6] 4764         jsr     L8DB5            ; display char here on LCD display
   AA12 39            [ 5] 4765         rts
                           4766 
   AA13                    4767 LAA13:
   AA13 CC 20 37      [ 3] 4768         ldd     #0x2037           ;' '
   AA16 20 F7         [ 3] 4769         bra     LAA0F
                           4770 
   AA18                    4771 LAA18:
   AA18 CC 42 0F      [ 3] 4772         ldd     #0x420F           ;'B'
   AA1B 20 F2         [ 3] 4773         bra     LAA0F
                           4774 
   AA1D                    4775 LAA1D:
   AA1D CC 20 0F      [ 3] 4776         ldd     #0x200F           ;' '
   AA20 20 ED         [ 3] 4777         bra     LAA0F
                           4778 
   AA22                    4779 LAA22: 
   AA22 7F 00 4F      [ 6] 4780         clr     (0x004F)
   AA25 CC 00 01      [ 3] 4781         ldd     #0x0001
   AA28 DD 1B         [ 4] 4782         std     CDTIMR1
   AA2A CE 20 00      [ 3] 4783         ldx     #0x2000
   AA2D                    4784 LAA2D:
   AA2D B6 10 A8      [ 4] 4785         ldaa    (0x10A8)
   AA30 84 01         [ 2] 4786         anda    #0x01
   AA32 27 F9         [ 3] 4787         beq     LAA2D  
   AA34 DC 1B         [ 4] 4788         ldd     CDTIMR1
   AA36 0F            [ 2] 4789         sei
   AA37 26 03         [ 3] 4790         bne     LAA3C  
   AA39 CE 20 00      [ 3] 4791         ldx     #0x2000
   AA3C                    4792 LAA3C:
   AA3C B6 10 A9      [ 4] 4793         ldaa    (0x10A9)
   AA3F A7 00         [ 4] 4794         staa    0,X     
   AA41 0E            [ 2] 4795         cli
   AA42 BD F9 6F      [ 6] 4796         jsr     SERIALW      
   AA45 08            [ 3] 4797         inx
   AA46 7F 00 4F      [ 6] 4798         clr     (0x004F)
   AA49 CC 00 01      [ 3] 4799         ldd     #0x0001
   AA4C DD 1B         [ 4] 4800         std     CDTIMR1
   AA4E 8C 20 23      [ 4] 4801         cpx     #0x2023
   AA51 26 DA         [ 3] 4802         bne     LAA2D  
   AA53 CE 20 00      [ 3] 4803         ldx     #0x2000
   AA56 7F 00 B7      [ 6] 4804         clr     (0x00B7)
   AA59                    4805 LAA59:
   AA59 A6 00         [ 4] 4806         ldaa    0,X     
   AA5B 9B B7         [ 3] 4807         adda    (0x00B7)
   AA5D 97 B7         [ 3] 4808         staa    (0x00B7)
   AA5F 08            [ 3] 4809         inx
   AA60 8C 20 22      [ 4] 4810         cpx     #0x2022
   AA63 25 F4         [ 3] 4811         bcs     LAA59  
   AA65 96 B7         [ 3] 4812         ldaa    (0x00B7)
   AA67 88 FF         [ 2] 4813         eora    #0xFF
   AA69 A1 00         [ 4] 4814         cmpa    0,X     
   AA6B CE 20 00      [ 3] 4815         ldx     #0x2000
   AA6E A6 20         [ 4] 4816         ldaa    0x20,X
   AA70 2B 03         [ 3] 4817         bmi     LAA75  
   AA72 7E AA 22      [ 3] 4818         jmp     LAA22
   AA75                    4819 LAA75:
   AA75 A6 00         [ 4] 4820         ldaa    0,X     
   AA77 B7 10 80      [ 4] 4821         staa    (0x1080)
   AA7A 08            [ 3] 4822         inx
   AA7B A6 00         [ 4] 4823         ldaa    0,X     
   AA7D B7 10 82      [ 4] 4824         staa    (0x1082)
   AA80 08            [ 3] 4825         inx
   AA81 A6 00         [ 4] 4826         ldaa    0,X     
   AA83 B7 10 84      [ 4] 4827         staa    (0x1084)
   AA86 08            [ 3] 4828         inx
   AA87 A6 00         [ 4] 4829         ldaa    0,X     
   AA89 B7 10 86      [ 4] 4830         staa    (0x1086)
   AA8C 08            [ 3] 4831         inx
   AA8D A6 00         [ 4] 4832         ldaa    0,X     
   AA8F B7 10 88      [ 4] 4833         staa    (0x1088)
   AA92 08            [ 3] 4834         inx
   AA93 A6 00         [ 4] 4835         ldaa    0,X     
   AA95 B7 10 8A      [ 4] 4836         staa    (0x108A)
   AA98 08            [ 3] 4837         inx
   AA99 A6 00         [ 4] 4838         ldaa    0,X     
   AA9B B7 10 8C      [ 4] 4839         staa    (0x108C)
   AA9E 08            [ 3] 4840         inx
   AA9F A6 00         [ 4] 4841         ldaa    0,X     
   AAA1 B7 10 8E      [ 4] 4842         staa    (0x108E)
   AAA4 08            [ 3] 4843         inx
   AAA5 A6 00         [ 4] 4844         ldaa    0,X     
   AAA7 B7 10 90      [ 4] 4845         staa    (0x1090)
   AAAA 08            [ 3] 4846         inx
   AAAB A6 00         [ 4] 4847         ldaa    0,X     
   AAAD B7 10 92      [ 4] 4848         staa    (0x1092)
   AAB0 08            [ 3] 4849         inx
   AAB1 A6 00         [ 4] 4850         ldaa    0,X     
   AAB3 8A 80         [ 2] 4851         oraa    #0x80
   AAB5 B7 10 94      [ 4] 4852         staa    (0x1094)
   AAB8 08            [ 3] 4853         inx
   AAB9 A6 00         [ 4] 4854         ldaa    0,X     
   AABB 8A 01         [ 2] 4855         oraa    #0x01
   AABD B7 10 96      [ 4] 4856         staa    (0x1096)
   AAC0 08            [ 3] 4857         inx
   AAC1 A6 00         [ 4] 4858         ldaa    0,X     
   AAC3 B7 10 98      [ 4] 4859         staa    (0x1098)
   AAC6 08            [ 3] 4860         inx
   AAC7 A6 00         [ 4] 4861         ldaa    0,X     
   AAC9 B7 10 9A      [ 4] 4862         staa    (0x109A)
   AACC 08            [ 3] 4863         inx
   AACD A6 00         [ 4] 4864         ldaa    0,X     
   AACF B7 10 9C      [ 4] 4865         staa    (0x109C)
   AAD2 08            [ 3] 4866         inx
   AAD3 A6 00         [ 4] 4867         ldaa    0,X     
   AAD5 B7 10 9E      [ 4] 4868         staa    (0x109E)
   AAD8 7E AA 22      [ 3] 4869         jmp     LAA22
                           4870 
   AADB                    4871 LAADB:
   AADB 7F 10 98      [ 6] 4872         clr     (0x1098)
   AADE 7F 10 9A      [ 6] 4873         clr     (0x109A)
   AAE1 7F 10 9C      [ 6] 4874         clr     (0x109C)
   AAE4 7F 10 9E      [ 6] 4875         clr     (0x109E)
   AAE7 39            [ 5] 4876         rts
   AAE8                    4877 LAAE8:
   AAE8 CE 04 2C      [ 3] 4878         ldx     #0x042C
   AAEB C6 10         [ 2] 4879         ldab    #0x10
   AAED                    4880 LAAED:
   AAED 5D            [ 2] 4881         tstb
   AAEE 27 12         [ 3] 4882         beq     LAB02  
   AAF0 A6 00         [ 4] 4883         ldaa    0,X     
   AAF2 81 30         [ 2] 4884         cmpa    #0x30
   AAF4 25 0D         [ 3] 4885         bcs     LAB03  
   AAF6 81 39         [ 2] 4886         cmpa    #0x39
   AAF8 22 09         [ 3] 4887         bhi     LAB03  
   AAFA 08            [ 3] 4888         inx
   AAFB 08            [ 3] 4889         inx
   AAFC 08            [ 3] 4890         inx
   AAFD 8C 04 59      [ 4] 4891         cpx     #0x0459
   AB00 23 EB         [ 3] 4892         bls     LAAED  
   AB02                    4893 LAB02:
   AB02 39            [ 5] 4894         rts
                           4895 
   AB03                    4896 LAB03:
   AB03 5A            [ 2] 4897         decb
   AB04 3C            [ 4] 4898         pshx
   AB05                    4899 LAB05:
   AB05 A6 03         [ 4] 4900         ldaa    3,X     
   AB07 A7 00         [ 4] 4901         staa    0,X     
   AB09 08            [ 3] 4902         inx
   AB0A 8C 04 5C      [ 4] 4903         cpx     #0x045C
   AB0D 25 F6         [ 3] 4904         bcs     LAB05  
   AB0F 86 FF         [ 2] 4905         ldaa    #0xFF
   AB11 B7 04 59      [ 4] 4906         staa    (0x0459)
   AB14 38            [ 5] 4907         pulx
   AB15 20 D6         [ 3] 4908         bra     LAAED
                           4909 
   AB17                    4910 LAB17:
   AB17 CE 04 2C      [ 3] 4911         ldx     #0x042C
   AB1A 86 FF         [ 2] 4912         ldaa    #0xFF
   AB1C                    4913 LAB1C:
   AB1C A7 00         [ 4] 4914         staa    0,X     
   AB1E 08            [ 3] 4915         inx
   AB1F 8C 04 5C      [ 4] 4916         cpx     #0x045C
   AB22 25 F8         [ 3] 4917         bcs     LAB1C  
   AB24 39            [ 5] 4918         rts
                           4919 
   AB25                    4920 LAB25:
   AB25 CE 04 2C      [ 3] 4921         ldx     #0x042C
   AB28                    4922 LAB28:
   AB28 A6 00         [ 4] 4923         ldaa    0,X     
   AB2A 81 30         [ 2] 4924         cmpa    #0x30
   AB2C 25 17         [ 3] 4925         bcs     LAB45  
   AB2E 81 39         [ 2] 4926         cmpa    #0x39
   AB30 22 13         [ 3] 4927         bhi     LAB45  
   AB32 08            [ 3] 4928         inx
   AB33 08            [ 3] 4929         inx
   AB34 08            [ 3] 4930         inx
   AB35 8C 04 5C      [ 4] 4931         cpx     #0x045C
   AB38 25 EE         [ 3] 4932         bcs     LAB28  
   AB3A 86 FF         [ 2] 4933         ldaa    #0xFF
   AB3C B7 04 2C      [ 4] 4934         staa    (0x042C)
   AB3F BD AA E8      [ 6] 4935         jsr     LAAE8
   AB42 CE 04 59      [ 3] 4936         ldx     #0x0459
   AB45                    4937 LAB45:
   AB45 39            [ 5] 4938         rts
                           4939 
   AB46                    4940 LAB46:
   AB46 B6 02 99      [ 4] 4941         ldaa    (0x0299)
   AB49 A7 00         [ 4] 4942         staa    0,X     
   AB4B B6 02 9A      [ 4] 4943         ldaa    (0x029A)
   AB4E A7 01         [ 4] 4944         staa    1,X     
   AB50 B6 02 9B      [ 4] 4945         ldaa    (0x029B)
   AB53 A7 02         [ 4] 4946         staa    2,X     
   AB55 39            [ 5] 4947         rts
                           4948 
   AB56                    4949 LAB56:
   AB56 CE 04 2C      [ 3] 4950         ldx     #0x042C
   AB59                    4951 LAB59:
   AB59 B6 02 99      [ 4] 4952         ldaa    (0x0299)
   AB5C A1 00         [ 4] 4953         cmpa    0,X     
   AB5E 26 10         [ 3] 4954         bne     LAB70  
   AB60 B6 02 9A      [ 4] 4955         ldaa    (0x029A)
   AB63 A1 01         [ 4] 4956         cmpa    1,X     
   AB65 26 09         [ 3] 4957         bne     LAB70  
   AB67 B6 02 9B      [ 4] 4958         ldaa    (0x029B)
   AB6A A1 02         [ 4] 4959         cmpa    2,X     
   AB6C 26 02         [ 3] 4960         bne     LAB70  
   AB6E 20 0A         [ 3] 4961         bra     LAB7A  
   AB70                    4962 LAB70:
   AB70 08            [ 3] 4963         inx
   AB71 08            [ 3] 4964         inx
   AB72 08            [ 3] 4965         inx
   AB73 8C 04 5C      [ 4] 4966         cpx     #0x045C
   AB76 25 E1         [ 3] 4967         bcs     LAB59  
   AB78 0D            [ 2] 4968         sec
   AB79 39            [ 5] 4969         rts
                           4970 
   AB7A                    4971 LAB7A:
   AB7A 0C            [ 2] 4972         clc
   AB7B 39            [ 5] 4973         rts
                           4974 
                           4975 ;show re-valid tapes
   AB7C                    4976 LAB7C:
   AB7C CE 04 2C      [ 3] 4977         ldx     #0x042C
   AB7F                    4978 LAB7F:
   AB7F A6 00         [ 4] 4979         ldaa    0,X     
   AB81 81 30         [ 2] 4980         cmpa    #0x30
   AB83 25 1E         [ 3] 4981         bcs     LABA3  
   AB85 81 39         [ 2] 4982         cmpa    #0x39
   AB87 22 1A         [ 3] 4983         bhi     LABA3  
   AB89 BD F9 6F      [ 6] 4984         jsr     SERIALW      
   AB8C 08            [ 3] 4985         inx
   AB8D A6 00         [ 4] 4986         ldaa    0,X     
   AB8F BD F9 6F      [ 6] 4987         jsr     SERIALW      
   AB92 08            [ 3] 4988         inx
   AB93 A6 00         [ 4] 4989         ldaa    0,X     
   AB95 BD F9 6F      [ 6] 4990         jsr     SERIALW      
   AB98 08            [ 3] 4991         inx
   AB99 86 20         [ 2] 4992         ldaa    #0x20
   AB9B BD F9 6F      [ 6] 4993         jsr     SERIALW      
   AB9E 8C 04 5C      [ 4] 4994         cpx     #0x045C
   ABA1 25 DC         [ 3] 4995         bcs     LAB7F  
   ABA3                    4996 LABA3:
   ABA3 86 0D         [ 2] 4997         ldaa    #0x0D
   ABA5 BD F9 6F      [ 6] 4998         jsr     SERIALW      
   ABA8 86 0A         [ 2] 4999         ldaa    #0x0A
   ABAA BD F9 6F      [ 6] 5000         jsr     SERIALW      
   ABAD 39            [ 5] 5001         rts
                           5002 
   ABAE                    5003 LABAE:
   ABAE 7F 00 4A      [ 6] 5004         clr     (0x004A)
   ABB1 CC 00 64      [ 3] 5005         ldd     #0x0064
   ABB4 DD 23         [ 4] 5006         std     CDTIMR5
   ABB6                    5007 LABB6:
   ABB6 96 4A         [ 3] 5008         ldaa    (0x004A)
   ABB8 26 08         [ 3] 5009         bne     LABC2  
   ABBA BD 9B 19      [ 6] 5010         jsr     L9B19   
   ABBD DC 23         [ 4] 5011         ldd     CDTIMR5
   ABBF 26 F5         [ 3] 5012         bne     LABB6  
   ABC1                    5013 LABC1:
   ABC1 39            [ 5] 5014         rts
                           5015 
   ABC2                    5016 LABC2:
   ABC2 81 31         [ 2] 5017         cmpa    #0x31
   ABC4 26 04         [ 3] 5018         bne     LABCA  
   ABC6 BD AB 17      [ 6] 5019         jsr     LAB17
   ABC9 39            [ 5] 5020         rts
                           5021 
   ABCA                    5022 LABCA:
   ABCA 20 F5         [ 3] 5023         bra     LABC1  
                           5024 
                           5025 ; TOC1 timer handler
                           5026 ;
                           5027 ; Timer is running at:
                           5028 ; EXTAL = 16Mhz
                           5029 ; E Clk = 4Mhz
                           5030 ; Timer Prescaler = /16 = 250Khz
                           5031 ; Timer Period = 4us
                           5032 ; T1OC is set to previous value +625
                           5033 ; So, this routine is called every 2.5ms
                           5034 ;
   ABCC                    5035 LABCC:
   ABCC DC 10         [ 4] 5036         ldd     T1NXT        ; get ready for next time
   ABCE C3 02 71      [ 4] 5037         addd    #0x0271      ; add 625
   ABD1 FD 10 16      [ 5] 5038         std     TOC1  
   ABD4 DD 10         [ 4] 5039         std     T1NXT
                           5040 
   ABD6 86 80         [ 2] 5041         ldaa    #0x80
   ABD8 B7 10 23      [ 4] 5042         staa    TFLG1       ; clear timer1 flag
                           5043 
                           5044 ; Some blinking SPECIAL button every half second,
                           5045 ; if 0x0078 is non zero
                           5046 
   ABDB 7D 00 78      [ 6] 5047         tst     (0x0078)     ; if 78 is zero, skip ahead
   ABDE 27 1C         [ 3] 5048         beq     LABFC       ; else do some blinking button lights
   ABE0 DC 25         [ 4] 5049         ldd     (0x0025)     ; else inc 25/26
   ABE2 C3 00 01      [ 4] 5050         addd    #0x0001
   ABE5 DD 25         [ 4] 5051         std     (0x0025)
   ABE7 1A 83 00 C8   [ 5] 5052         cpd     #0x00C8       ; is it 200?
   ABEB 26 0F         [ 3] 5053         bne     LABFC       ; no, keep going
   ABED 7F 00 25      [ 6] 5054         clr     (0x0025)     ; reset 25/26
   ABF0 7F 00 26      [ 6] 5055         clr     (0x0026)
   ABF3 D6 62         [ 3] 5056         ldab    (0x0062)    ; and toggle bit 3 of 62
   ABF5 C8 08         [ 2] 5057         eorb    #0x08
   ABF7 D7 62         [ 3] 5058         stab    (0x0062)
   ABF9 BD F9 C5      [ 6] 5059         jsr     BUTNLIT      ; and toggle the "special" button light
                           5060 
                           5061 ; 
   ABFC                    5062 LABFC:
   ABFC 7C 00 6F      [ 6] 5063         inc     (0x006F)     ; count every 2.5ms
   ABFF 96 6F         [ 3] 5064         ldaa    (0x006F)
   AC01 81 28         [ 2] 5065         cmpa    #0x28        ; is it 40 intervals? (0.1 sec?)
   AC03 25 42         [ 3] 5066         bcs     LAC47       ; if not yet, jump ahead
   AC05 7F 00 6F      [ 6] 5067         clr     (0x006F)     ; clear it 2.5ms counter
   AC08 7D 00 63      [ 6] 5068         tst     (0x0063)     ; decrement 0.1s counter here
   AC0B 27 03         [ 3] 5069         beq     LAC10       ; if it's not already zero
   AC0D 7A 00 63      [ 6] 5070         dec     (0x0063)
                           5071 
                           5072 ; staggered counters - here every 100ms
                           5073 
                           5074 ; 0x0070 counts from 250 to 1, period is 25 secs
   AC10                    5075 LAC10:
   AC10 96 70         [ 3] 5076         ldaa    OFFCNT1    ; decrement 0.1s counter here
   AC12 4A            [ 2] 5077         deca
   AC13 97 70         [ 3] 5078         staa    OFFCNT1
   AC15 26 04         [ 3] 5079         bne     LAC1B       
   AC17 86 FA         [ 2] 5080         ldaa    #0xFA        ; 250
   AC19 97 70         [ 3] 5081         staa    OFFCNT1
                           5082 
                           5083 ; 0x0071 counts from 230 to 1, period is 23 secs
   AC1B                    5084 LAC1B:
   AC1B 96 71         [ 3] 5085         ldaa    OFFCNT2
   AC1D 4A            [ 2] 5086         deca
   AC1E 97 71         [ 3] 5087         staa    OFFCNT2
   AC20 26 04         [ 3] 5088         bne     LAC26  
   AC22 86 E6         [ 2] 5089         ldaa    #0xE6        ; 230
   AC24 97 71         [ 3] 5090         staa    OFFCNT2
                           5091 
                           5092 ; 0x0072 counts from 210 to 1, period is 21 secs
   AC26                    5093 LAC26:
   AC26 96 72         [ 3] 5094         ldaa    OFFCNT3
   AC28 4A            [ 2] 5095         deca
   AC29 97 72         [ 3] 5096         staa    OFFCNT3
   AC2B 26 04         [ 3] 5097         bne     LAC31  
   AC2D 86 D2         [ 2] 5098         ldaa    #0xD2        ; 210
   AC2F 97 72         [ 3] 5099         staa    OFFCNT3
                           5100 
                           5101 ; 0x0073 counts from 190 to 1, period is 19 secs
   AC31                    5102 LAC31:
   AC31 96 73         [ 3] 5103         ldaa    OFFCNT4
   AC33 4A            [ 2] 5104         deca
   AC34 97 73         [ 3] 5105         staa    OFFCNT4
   AC36 26 04         [ 3] 5106         bne     LAC3C  
   AC38 86 BE         [ 2] 5107         ldaa    #0xBE        ; 190
   AC3A 97 73         [ 3] 5108         staa    OFFCNT4
                           5109 
                           5110 ; 0x0074 counts from 170 to 1, period is 17 secs
   AC3C                    5111 LAC3C:
   AC3C 96 74         [ 3] 5112         ldaa    OFFCNT5
   AC3E 4A            [ 2] 5113         deca
   AC3F 97 74         [ 3] 5114         staa    OFFCNT5
   AC41 26 04         [ 3] 5115         bne     LAC47  
   AC43 86 AA         [ 2] 5116         ldaa    #0xAA        ; 170
   AC45 97 74         [ 3] 5117         staa    OFFCNT5
                           5118 
                           5119 ; back to 2.5ms period here
                           5120 
   AC47                    5121 LAC47:
   AC47 96 27         [ 3] 5122         ldaa    T30MS
   AC49 4C            [ 2] 5123         inca
   AC4A 97 27         [ 3] 5124         staa    T30MS
   AC4C 81 0C         [ 2] 5125         cmpa    #0x0C        ; 12 = 30ms?
   AC4E 23 09         [ 3] 5126         bls     LAC59  
   AC50 7F 00 27      [ 6] 5127         clr     T30MS
                           5128 
                           5129 ; do these tasks every 30ms
   AC53 BD 8E C6      [ 6] 5130         jsr     L8EC6       ; ???
   AC56 BD 8F 12      [ 6] 5131         jsr     L8F12       ; ???
                           5132 
                           5133 ; back to every 2.5ms here
                           5134 ; LCD update???
                           5135 
   AC59                    5136 LAC59:
   AC59 96 43         [ 3] 5137         ldaa    (0x0043)
   AC5B 27 55         [ 3] 5138         beq     LACB2  
   AC5D DE 44         [ 4] 5139         ldx     (0x0044)
   AC5F A6 00         [ 4] 5140         ldaa    0,X     
   AC61 27 23         [ 3] 5141         beq     LAC86  
   AC63 B7 10 00      [ 4] 5142         staa    PORTA  
   AC66 B6 10 02      [ 4] 5143         ldaa    PORTG  
   AC69 84 F3         [ 2] 5144         anda    #0xF3
   AC6B B7 10 02      [ 4] 5145         staa    PORTG  
   AC6E 84 FD         [ 2] 5146         anda    #0xFD
   AC70 B7 10 02      [ 4] 5147         staa    PORTG  
   AC73 8A 02         [ 2] 5148         oraa    #0x02
   AC75 B7 10 02      [ 4] 5149         staa    PORTG  
   AC78 08            [ 3] 5150         inx
   AC79 08            [ 3] 5151         inx
   AC7A 8C 05 80      [ 4] 5152         cpx     #0x0580
   AC7D 25 03         [ 3] 5153         bcs     LAC82  
   AC7F CE 05 00      [ 3] 5154         ldx     #0x0500
   AC82                    5155 LAC82:
   AC82 DF 44         [ 4] 5156         stx     (0x0044)
   AC84 20 2C         [ 3] 5157         bra     LACB2  
   AC86                    5158 LAC86:
   AC86 A6 01         [ 4] 5159         ldaa    1,X     
   AC88 27 25         [ 3] 5160         beq     LACAF  
   AC8A B7 10 00      [ 4] 5161         staa    PORTA  
   AC8D B6 10 02      [ 4] 5162         ldaa    PORTG  
   AC90 84 FB         [ 2] 5163         anda    #0xFB
   AC92 8A 08         [ 2] 5164         oraa    #0x08
   AC94 B7 10 02      [ 4] 5165         staa    PORTG  
   AC97 84 FD         [ 2] 5166         anda    #0xFD
   AC99 B7 10 02      [ 4] 5167         staa    PORTG  
   AC9C 8A 02         [ 2] 5168         oraa    #0x02
   AC9E B7 10 02      [ 4] 5169         staa    PORTG  
   ACA1 08            [ 3] 5170         inx
   ACA2 08            [ 3] 5171         inx
   ACA3 8C 05 80      [ 4] 5172         cpx     #0x0580
   ACA6 25 03         [ 3] 5173         bcs     LACAB  
   ACA8 CE 05 00      [ 3] 5174         ldx     #0x0500
   ACAB                    5175 LACAB:
   ACAB DF 44         [ 4] 5176         stx     (0x0044)
   ACAD 20 03         [ 3] 5177         bra     LACB2  
   ACAF                    5178 LACAF:
   ACAF 7F 00 43      [ 6] 5179         clr     (0x0043)
                           5180 
                           5181 ; divide by 4
   ACB2                    5182 LACB2:
   ACB2 96 4F         [ 3] 5183         ldaa    (0x004F)
   ACB4 4C            [ 2] 5184         inca
   ACB5 97 4F         [ 3] 5185         staa    (0x004F)
   ACB7 81 04         [ 2] 5186         cmpa    #0x04
   ACB9 26 30         [ 3] 5187         bne     LACEB  
   ACBB 7F 00 4F      [ 6] 5188         clr     (0x004F)
                           5189 
                           5190 ; here every 10ms
                           5191 ; Five big countdown timers available here
                           5192 ; up to 655.35 seconds each
                           5193 
   ACBE DC 1B         [ 4] 5194         ldd     CDTIMR1     ; countdown 0x001B/1C every 10ms
   ACC0 27 05         [ 3] 5195         beq     LACC7       ; if not already 0
   ACC2 83 00 01      [ 4] 5196         subd    #0x0001
   ACC5 DD 1B         [ 4] 5197         std     CDTIMR1
                           5198 
   ACC7                    5199 LACC7:
   ACC7 DC 1D         [ 4] 5200         ldd     CDTIMR2     ; same with 0x001D/1E
   ACC9 27 05         [ 3] 5201         beq     LACD0  
   ACCB 83 00 01      [ 4] 5202         subd    #0x0001
   ACCE DD 1D         [ 4] 5203         std     CDTIMR2
                           5204 
   ACD0                    5205 LACD0:
   ACD0 DC 1F         [ 4] 5206         ldd     CDTIMR3     ; same with 0x001F/20
   ACD2 27 05         [ 3] 5207         beq     LACD9  
   ACD4 83 00 01      [ 4] 5208         subd    #0x0001
   ACD7 DD 1F         [ 4] 5209         std     CDTIMR3
                           5210 
   ACD9                    5211 LACD9:
   ACD9 DC 21         [ 4] 5212         ldd     CDTIMR4     ; same with 0x0021/22
   ACDB 27 05         [ 3] 5213         beq     LACE2  
   ACDD 83 00 01      [ 4] 5214         subd    #0x0001
   ACE0 DD 21         [ 4] 5215         std     CDTIMR4
                           5216 
   ACE2                    5217 LACE2:
   ACE2 DC 23         [ 4] 5218         ldd     CDTIMR5     ; same with 0x0023/24
   ACE4 27 05         [ 3] 5219         beq     LACEB  
   ACE6 83 00 01      [ 4] 5220         subd    #0x0001
   ACE9 DD 23         [ 4] 5221         std     CDTIMR5
                           5222 
                           5223 ; every other time through this, setup a task switch?
   ACEB                    5224 LACEB:
   ACEB 96 B0         [ 3] 5225         ldaa    (TSCNT)
   ACED 88 01         [ 2] 5226         eora    #0x01
   ACEF 97 B0         [ 3] 5227         staa    (TSCNT)
   ACF1 27 18         [ 3] 5228         beq     LAD0B  
                           5229 
   ACF3 BF 01 3C      [ 5] 5230         sts     (0x013C)     ; switch stacks???
   ACF6 BE 01 3E      [ 5] 5231         lds     (0x013E)
   ACF9 DC 10         [ 4] 5232         ldd     T1NXT
   ACFB 83 01 F4      [ 4] 5233         subd    #0x01F4      ; 625-500 = 125?
   ACFE FD 10 18      [ 5] 5234         std     TOC2         ; set this TOC2 to happen 0.5ms
   AD01 86 40         [ 2] 5235         ldaa    #0x40        ; after the current TOC1 but before the next TOC1
   AD03 B7 10 23      [ 4] 5236         staa    TFLG1       ; clear timer2 irq flag, just in case?
   AD06 86 C0         [ 2] 5237         ldaa    #0xC0        ;
   AD08 B7 10 22      [ 4] 5238         staa    TMSK1       ; enable TOC1 and TOC2
   AD0B                    5239 LAD0B:
   AD0B 3B            [12] 5240         rti
                           5241 
                           5242 ; TOC2 Timer handler and SWI handler
   AD0C                    5243 LAD0C:
   AD0C 86 40         [ 2] 5244         ldaa    #0x40
   AD0E B7 10 23      [ 4] 5245         staa    TFLG1       ; clear timer2 flag
   AD11 BF 01 3E      [ 5] 5246         sts     (0x013E)     ; switch stacks back???
   AD14 BE 01 3C      [ 5] 5247         lds     (0x013C)
   AD17 86 80         [ 2] 5248         ldaa    #0x80
   AD19 B7 10 22      [ 4] 5249         staa    TMSK1       ; enable TOC1 only
   AD1C 3B            [12] 5250         rti
                           5251 
                           5252 ; Secondary task??
                           5253 
   AD1D                    5254 TASK2:
   AD1D 7D 04 2A      [ 6] 5255         tst     (0x042A)
   AD20 27 35         [ 3] 5256         beq     LAD57
   AD22 96 B6         [ 3] 5257         ldaa    (0x00B6)
   AD24 26 03         [ 3] 5258         bne     LAD29
   AD26 3F            [14] 5259         swi
   AD27 20 F4         [ 3] 5260         bra     TASK2
   AD29                    5261 LAD29:
   AD29 7F 00 B6      [ 6] 5262         clr     (0x00B6)
   AD2C C6 04         [ 2] 5263         ldab    #0x04
   AD2E                    5264 LAD2E:
   AD2E 37            [ 3] 5265         pshb
   AD2F CE AD 3C      [ 3] 5266         ldx     #LAD3C
   AD32 BD 8A 1A      [ 6] 5267         jsr     L8A1A  
   AD35 3F            [14] 5268         swi
   AD36 33            [ 4] 5269         pulb
   AD37 5A            [ 2] 5270         decb
   AD38 26 F4         [ 3] 5271         bne     LAD2E  
   AD3A 20 E1         [ 3] 5272         bra     TASK2
                           5273 
   AD3C                    5274 LAD3C:
   AD3C 53 31 00           5275         .asciz     'S1'
                           5276 
   AD3F FC 02 9C      [ 5] 5277         ldd     (0x029C)
   AD42 1A 83 00 01   [ 5] 5278         cpd     #0x0001         ; 1
   AD46 27 0C         [ 3] 5279         beq     LAD54  
   AD48 1A 83 03 E8   [ 5] 5280         cpd     #0x03E8         ; 1000
   AD4C 2D 09         [ 3] 5281         blt     LAD57  
   AD4E 1A 83 04 4B   [ 5] 5282         cpd     #0x044B         ; 1099
   AD52 22 03         [ 3] 5283         bhi     LAD57  
   AD54                    5284 LAD54:
   AD54 3F            [14] 5285         swi
   AD55 20 C6         [ 3] 5286         bra     TASK2
   AD57                    5287 LAD57:
   AD57 7F 00 B3      [ 6] 5288         clr     (0x00B3)
   AD5A BD AD 7E      [ 6] 5289         jsr     LAD7E
   AD5D BD AD A0      [ 6] 5290         jsr     LADA0
   AD60 25 BB         [ 3] 5291         bcs     TASK2
   AD62 C6 0A         [ 2] 5292         ldab    #0x0A
   AD64 BD AE 13      [ 6] 5293         jsr     LAE13
   AD67 BD AD AE      [ 6] 5294         jsr     LADAE
   AD6A 25 B1         [ 3] 5295         bcs     TASK2
   AD6C C6 14         [ 2] 5296         ldab    #0x14
   AD6E BD AE 13      [ 6] 5297         jsr     LAE13
   AD71 BD AD B6      [ 6] 5298         jsr     LADB6
   AD74 25 A7         [ 3] 5299         bcs     TASK2
   AD76                    5300 LAD76:
   AD76 BD AD B8      [ 6] 5301         jsr     LADB8
   AD79 0D            [ 2] 5302         sec
   AD7A 25 A1         [ 3] 5303         bcs     TASK2
   AD7C 20 F8         [ 3] 5304         bra     LAD76
   AD7E                    5305 LAD7E:
   AD7E CE AE 1E      [ 3] 5306         ldx     #LAE1E       ;+++
   AD81 BD 8A 1A      [ 6] 5307         jsr     L8A1A  
   AD84 C6 1E         [ 2] 5308         ldab    #0x1E
   AD86 BD AE 13      [ 6] 5309         jsr     LAE13
   AD89 CE AE 22      [ 3] 5310         ldx     #LAE22       ;ATH
   AD8C BD 8A 1A      [ 6] 5311         jsr     L8A1A  
   AD8F C6 1E         [ 2] 5312         ldab    #0x1E
   AD91 BD AE 13      [ 6] 5313         jsr     LAE13
   AD94 CE AE 27      [ 3] 5314         ldx     #LAE27       ;ATZ
   AD97 BD 8A 1A      [ 6] 5315         jsr     L8A1A  
   AD9A C6 1E         [ 2] 5316         ldab    #0x1E
   AD9C BD AE 13      [ 6] 5317         jsr     LAE13
   AD9F 39            [ 5] 5318         rts
   ADA0                    5319 LADA0:
   ADA0 BD B1 DD      [ 6] 5320         jsr     LB1DD
   ADA3 25 FB         [ 3] 5321         bcs     LADA0  
   ADA5 BD B2 4F      [ 6] 5322         jsr     LB24F
                           5323 
   ADA8 52 49 4E 47 00     5324         .asciz  'RING'
                           5325 
   ADAD 39            [ 5] 5326         rts
                           5327 
   ADAE                    5328 LADAE:
   ADAE CE AE 2C      [ 3] 5329         ldx     #LAE2C
   ADB1 BD 8A 1A      [ 6] 5330         jsr     L8A1A       ;ATA
   ADB4 0C            [ 2] 5331         clc
   ADB5 39            [ 5] 5332         rts
   ADB6                    5333 LADB6:
   ADB6 0C            [ 2] 5334         clc
   ADB7 39            [ 5] 5335         rts
                           5336 
   ADB8                    5337 LADB8:
   ADB8 BD B1 D2      [ 6] 5338         jsr     LB1D2
   ADBB BD AE 31      [ 6] 5339         jsr     LAE31
   ADBE 86 01         [ 2] 5340         ldaa    #0x01
   ADC0 97 B3         [ 3] 5341         staa    (0x00B3)
   ADC2 BD B1 DD      [ 6] 5342         jsr     LB1DD
   ADC5 BD B2 71      [ 6] 5343         jsr     LB271
   ADC8 36            [ 3] 5344         psha
   ADC9 BD B2 C0      [ 6] 5345         jsr     LB2C0
   ADCC 32            [ 4] 5346         pula
   ADCD 81 01         [ 2] 5347         cmpa    #0x01
   ADCF 26 08         [ 3] 5348         bne     LADD9  
   ADD1 CE B2 95      [ 3] 5349         ldx     #LB295
   ADD4 BD 8A 1A      [ 6] 5350         jsr     L8A1A       ;'You have selected #1'
   ADD7 20 31         [ 3] 5351         bra     LAE0A  
   ADD9                    5352 LADD9:
   ADD9 81 02         [ 2] 5353         cmpa    #0x02
   ADDB 26 00         [ 3] 5354         bne     LADDD  
   ADDD                    5355 LADDD:
   ADDD 81 03         [ 2] 5356         cmpa    #0x03
   ADDF 26 00         [ 3] 5357         bne     LADE1  
   ADE1                    5358 LADE1:
   ADE1 81 04         [ 2] 5359         cmpa    #0x04
   ADE3 26 00         [ 3] 5360         bne     LADE5  
   ADE5                    5361 LADE5:
   ADE5 81 05         [ 2] 5362         cmpa    #0x05
   ADE7 26 00         [ 3] 5363         bne     LADE9  
   ADE9                    5364 LADE9:
   ADE9 81 06         [ 2] 5365         cmpa    #0x06
   ADEB 26 00         [ 3] 5366         bne     LADED  
   ADED                    5367 LADED:
   ADED 81 07         [ 2] 5368         cmpa    #0x07
   ADEF 26 00         [ 3] 5369         bne     LADF1  
   ADF1                    5370 LADF1:
   ADF1 81 08         [ 2] 5371         cmpa    #0x08
   ADF3 26 00         [ 3] 5372         bne     LADF5  
   ADF5                    5373 LADF5:
   ADF5 81 09         [ 2] 5374         cmpa    #0x09
   ADF7 26 00         [ 3] 5375         bne     LADF9  
   ADF9                    5376 LADF9:
   ADF9 81 0A         [ 2] 5377         cmpa    #0x0A
   ADFB 26 00         [ 3] 5378         bne     LADFD  
   ADFD                    5379 LADFD:
   ADFD 81 0B         [ 2] 5380         cmpa    #0x0B
   ADFF 26 09         [ 3] 5381         bne     LAE0A  
   AE01 CE B2 AA      [ 3] 5382         ldx     #LB2AA       ;'You have selected #11'
   AE04 BD 8A 1A      [ 6] 5383         jsr     L8A1A  
   AE07 7E AE 0A      [ 3] 5384         jmp     LAE0A
   AE0A                    5385 LAE0A:
   AE0A C6 14         [ 2] 5386         ldab    #0x14
   AE0C BD AE 13      [ 6] 5387         jsr     LAE13
   AE0F 7F 00 B3      [ 6] 5388         clr     (0x00B3)
   AE12 39            [ 5] 5389         rts
                           5390 
   AE13                    5391 LAE13:
   AE13 CE 00 20      [ 3] 5392         ldx     #0x0020
   AE16                    5393 LAE16:
   AE16 3F            [14] 5394         swi
   AE17 09            [ 3] 5395         dex
   AE18 26 FC         [ 3] 5396         bne     LAE16  
   AE1A 5A            [ 2] 5397         decb
   AE1B 26 F6         [ 3] 5398         bne     LAE13  
   AE1D 39            [ 5] 5399         rts
                           5400 
                           5401 ; text??
   AE1E                    5402 LAE1E:
   AE1E 2B 2B 2B 00        5403         .asciz      '+++'
   AE22                    5404 LAE22:
   AE22 41 54 48 0D 00     5405         .asciz      'ATH\r'
   AE27                    5406 LAE27:
   AE27 41 54 5A 0D 00     5407         .asciz      'ATZ\r'
   AE2C                    5408 LAE2C:
   AE2C 41 54 41 0D 00     5409         .asciz      'ATA\r'
                           5410 
   AE31                    5411 LAE31:
   AE31 CE AE 38      [ 3] 5412         ldx     #LAE38       ; big long string of stats?
   AE34 BD 8A 1A      [ 6] 5413         jsr     L8A1A  
   AE37 39            [ 5] 5414         rts
                           5415 
   AE38                    5416 LAE38:
   AE38 5E 30 31 30 31 53  5417         .ascii  "^0101Serial #:^0140#0000^0111~4"
        65 72 69 61 6C 20
        23 3A 5E 30 31 34
        30 23 30 30 30 30
        5E 30 31 31 31 7E
        34
   AE57 0E 20              5418         .byte   0x0E,0x20
   AE59 5E 30 31 34 31 7C  5419         .ascii  "^0141|"
   AE5F 04 28              5420         .byte   0x04,0x28
   AE61 5E 30 33 30 31 43  5421         .ascii  "^0301CURRENT^0340HISTORY^0501Show Status:^0540Total # reg. shows:^0601Random Status:^0570|"
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
   AEBB 04 10              5422         .byte   0x04,0x10
   AEBD 5E 30 36 34 30 54  5423         .ascii  "^0640Total # live shows:^0701Current Reg Tape #:^0670|"
        6F 74 61 6C 20 23
        20 6C 69 76 65 20
        73 68 6F 77 73 3A
        5E 30 37 30 31 43
        75 72 72 65 6E 74
        20 52 65 67 20 54
        61 70 65 20 23 3A
        5E 30 36 37 30 7C
   AEF3 04 12              5424         .byte   0x04,0x12
   AEF5 5E 30 37 33 30 7E  5425         .ascii  "^0730~3"
        33
   AEFC 04 02              5426         .byte   0x04,0x02
   AEFE 5E 30 37 34 30 54  5427         .ascii  "^0740Total # failed pswd attempts:^0801Current Live Tape #:^0770|"
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
   AF3F 04 14              5428         .byte   0x04,0x14
   AF41 5E 30 38 33 30 7E  5429         .ascii  "^0830~3"
        33
   AF48 04 05              5430         .byte   0x04,0x05
   AF4A 5E 30 38 34 30 54  5431         .ascii  "^0840Total # successful pswd:^0901Current Version #:^0870|"
        6F 74 61 6C 20 23
        20 73 75 63 63 65
        73 73 66 75 6C 20
        70 73 77 64 3A 5E
        30 39 30 31 43 75
        72 72 65 6E 74 20
        56 65 72 73 69 6F
        6E 20 23 3A 5E 30
        38 37 30 7C
   AF84 04 16              5432         .byte   0x04,0x16
   AF86 5E 30 39 33 30 40  5433         .ascii  "^0930@"
   AF8C 04 00              5434         .byte   0x04,0x00
   AF8E 5E 30 39 34 30 54  5435         .ascii  "^0940Total # bdays played:^1040Total # VCR adjusts:^0970|"
        6F 74 61 6C 20 23
        20 62 64 61 79 73
        20 70 6C 61 79 65
        64 3A 5E 31 30 34
        30 54 6F 74 61 6C
        20 23 20 56 43 52
        20 61 64 6A 75 73
        74 73 3A 5E 30 39
        37 30 7C
   AFC7 04 18              5436         .byte   0x04,0x18
   AFC9 5E 31 30 37 30 7C  5437         .ascii  "^1070|"
   AFCF 04 1A              5438         .byte   0x04,0x1A
   AFD1 5E 31 31 34 30 54  5439         .ascii  "^1140Total # remote accesses:^1240Total # access attempts:^1170|"
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
   B011 04 1C              5440         .byte   0x04,0x1C
   B013 5E 31 32 37 30 7C  5441         .ascii  "^1270|"
   B019 04 1E              5442         .byte   0x04,0x1E
   B01B 5E 31 33 34 30 54  5443         .ascii  "^1340Total # rejected showtapes:^1440Total # Short bdays:^1370|"
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
   B05A 04 20              5444         .byte   0x04,0x20
   B05C 5E 31 34 37 30 7C  5445         .ascii  "^1470|"
   B062 04 22              5446         .byte   0x04,0x22
   B064 5E 31 35 34 30 54  5447         .ascii  "^1540Total # Reg bdays:^1640Total # resets-pwr ups:^1570|"
        6F 74 61 6C 20 23
        20 52 65 67 20 62
        64 61 79 73 3A 5E
        31 36 34 30 54 6F
        74 61 6C 20 23 20
        72 65 73 65 74 73
        2D 70 77 72 20 75
        70 73 3A 5E 31 35
        37 30 7C
   B09D 04 24              5448         .byte   0x04,0x24
   B09F 5E 31 36 37 30 7C  5449         .ascii  "^1670|"
   B0A5 04 26              5450         .byte   0x04,0x26
   B0A7 5E 31 38 30 31 46  5451         .ascii  "^1801FUNCTIONS^1823Select Function:^20011.Clear rnd enables^2028 6.Set loc name-#^205411.Diagnostics^21012.Set rnd enables^2128 7.Set Time^215412.^22013.Set reg tape #^2228 8.Disbl-enbl show^225413.^23014.Set liv tape #^2328 9.Upload program^235414.^24015.Reset history^242810.Debugger^245415.^1840"
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
   B1D1 00                 5452         .byte   0x00
                           5453 
   B1D2                    5454 LB1D2:
   B1D2 CE B1 D8      [ 3] 5455         ldx     #LB1D8       ; escape sequence?
   B1D5 7E 8A 1A      [ 3] 5456         jmp     L8A1A  
                           5457 
   B1D8                    5458 LB1D8:
                           5459         ; esc[2J ?
   B1D8 1B                 5460         .byte   0x1b
   B1D9 5B 32 4A 00        5461         .asciz  '[2J'
                           5462 
   B1DD                    5463 LB1DD:
   B1DD CE 05 A0      [ 3] 5464         ldx     #0x05A0
   B1E0 CC 00 00      [ 3] 5465         ldd     #0x0000
   B1E3 FD 02 9E      [ 5] 5466         std     (0x029E)
   B1E6                    5467 LB1E6:
   B1E6 FC 02 9E      [ 5] 5468         ldd     (0x029E)
   B1E9 C3 00 01      [ 4] 5469         addd    #0x0001
   B1EC FD 02 9E      [ 5] 5470         std     (0x029E)
   B1EF 1A 83 0F A0   [ 5] 5471         cpd     #0x0FA0
   B1F3 24 28         [ 3] 5472         bcc     LB21D  
   B1F5 BD B2 23      [ 6] 5473         jsr     LB223
   B1F8 25 04         [ 3] 5474         bcs     LB1FE  
   B1FA 3F            [14] 5475         swi
   B1FB 20 E9         [ 3] 5476         bra     LB1E6  
   B1FD 39            [ 5] 5477         rts
                           5478 
   B1FE                    5479 LB1FE:
   B1FE A7 00         [ 4] 5480         staa    0,X     
   B200 08            [ 3] 5481         inx
   B201 81 0D         [ 2] 5482         cmpa    #0x0D
   B203 26 02         [ 3] 5483         bne     LB207  
   B205 20 18         [ 3] 5484         bra     LB21F  
   B207                    5485 LB207:
   B207 81 1B         [ 2] 5486         cmpa    #0x1B
   B209 26 02         [ 3] 5487         bne     LB20D  
   B20B 20 10         [ 3] 5488         bra     LB21D  
   B20D                    5489 LB20D:
   B20D 7D 00 B3      [ 6] 5490         tst     (0x00B3)
   B210 27 03         [ 3] 5491         beq     LB215  
   B212 BD 8B 3B      [ 6] 5492         jsr     L8B3B
   B215                    5493 LB215:
   B215 CC 00 00      [ 3] 5494         ldd     #0x0000
   B218 FD 02 9E      [ 5] 5495         std     (0x029E)
   B21B 20 C9         [ 3] 5496         bra     LB1E6  
   B21D                    5497 LB21D:
   B21D 0D            [ 2] 5498         sec
   B21E 39            [ 5] 5499         rts
                           5500 
   B21F                    5501 LB21F:
   B21F 6F 00         [ 6] 5502         clr     0,X     
   B221 0C            [ 2] 5503         clc
   B222 39            [ 5] 5504         rts
                           5505 
   B223                    5506 LB223:
   B223 B6 18 0D      [ 4] 5507         ldaa    SCCCTRLB
   B226 44            [ 2] 5508         lsra
   B227 25 0B         [ 3] 5509         bcs     LB234  
   B229 4F            [ 2] 5510         clra
   B22A B7 18 0D      [ 4] 5511         staa    SCCCTRLB
   B22D 86 30         [ 2] 5512         ldaa    #0x30
   B22F B7 18 0D      [ 4] 5513         staa    SCCCTRLB
   B232 0C            [ 2] 5514         clc
   B233 39            [ 5] 5515         rts
                           5516 
   B234                    5517 LB234:
   B234 86 01         [ 2] 5518         ldaa    #0x01
   B236 B7 18 0D      [ 4] 5519         staa    SCCCTRLB
   B239 86 70         [ 2] 5520         ldaa    #0x70
   B23B B5 18 0D      [ 4] 5521         bita    SCCCTRLB
   B23E 26 05         [ 3] 5522         bne     LB245  
   B240 0D            [ 2] 5523         sec
   B241 B6 18 0F      [ 4] 5524         ldaa    SCCDATAB
   B244 39            [ 5] 5525         rts
                           5526 
   B245                    5527 LB245:
   B245 B6 18 0F      [ 4] 5528         ldaa    SCCDATAB
   B248 86 30         [ 2] 5529         ldaa    #0x30
   B24A B7 18 0C      [ 4] 5530         staa    SCCCTRLA
   B24D 0C            [ 2] 5531         clc
   B24E 39            [ 5] 5532         rts
                           5533 
   B24F                    5534 LB24F:
   B24F 38            [ 5] 5535         pulx
   B250 18 CE 05 A0   [ 4] 5536         ldy     #0x05A0
   B254                    5537 LB254:
   B254 A6 00         [ 4] 5538         ldaa    0,X
   B256 27 11         [ 3] 5539         beq     LB269
   B258 08            [ 3] 5540         inx
   B259 18 A1 00      [ 5] 5541         cmpa    0,Y
   B25C 26 04         [ 3] 5542         bne     LB262
   B25E 18 08         [ 4] 5543         iny
   B260 20 F2         [ 3] 5544         bra     LB254
   B262                    5545 LB262:
   B262 A6 00         [ 4] 5546         ldaa    0,X
   B264 27 07         [ 3] 5547         beq     LB26D
   B266 08            [ 3] 5548         inx
   B267 20 F9         [ 3] 5549         bra     LB262
   B269                    5550 LB269:
   B269 08            [ 3] 5551         inx
   B26A 3C            [ 4] 5552         pshx
   B26B 0C            [ 2] 5553         clc
   B26C 39            [ 5] 5554         rts
   B26D                    5555 LB26D:
   B26D 08            [ 3] 5556         inx
   B26E 3C            [ 4] 5557         pshx
   B26F 0D            [ 2] 5558         sec
   B270 39            [ 5] 5559         rts
                           5560 
   B271                    5561 LB271:
   B271 CE 05 A0      [ 3] 5562         ldx     #0x05A0
   B274                    5563 LB274:
   B274 A6 00         [ 4] 5564         ldaa    0,X
   B276 08            [ 3] 5565         inx
   B277 81 0D         [ 2] 5566         cmpa    #0x0D
   B279 26 F9         [ 3] 5567         bne     LB274
   B27B 09            [ 3] 5568         dex
   B27C 09            [ 3] 5569         dex
   B27D A6 00         [ 4] 5570         ldaa    0,X
   B27F 09            [ 3] 5571         dex
   B280 80 30         [ 2] 5572         suba    #0x30
   B282 97 B2         [ 3] 5573         staa    (0x00B2)
   B284 8C 05 9F      [ 4] 5574         cpx     #0x059F
   B287 27 0B         [ 3] 5575         beq     LB294
   B289 A6 00         [ 4] 5576         ldaa    0,X
   B28B 09            [ 3] 5577         dex
   B28C 80 30         [ 2] 5578         suba    #0x30
   B28E C6 0A         [ 2] 5579         ldab    #0x0A
   B290 3D            [10] 5580         mul
   B291 17            [ 2] 5581         tba
   B292 9B B2         [ 3] 5582         adda    (0x00B2)
   B294                    5583 LB294:
   B294 39            [ 5] 5584         rts
                           5585 
   B295                    5586 LB295:
   B295 59 6F 75 20 68 61  5587         .asciz  'You have selected #1'
        76 65 20 73 65 6C
        65 63 74 65 64 20
        23 31 00
   B2AA                    5588 LB2AA:
   B2AA 59 6F 75 20 68 61  5589         .asciz  'You have selected #11'
        76 65 20 73 65 6C
        65 63 74 65 64 20
        23 31 31 00
                           5590 
   B2C0                    5591 LB2C0:
   B2C0 CE B2 C7      [ 3] 5592         ldx     #LB2C7      ; strange table
   B2C3 BD 8A 1A      [ 6] 5593         jsr     L8A1A  
   B2C6 39            [ 5] 5594         rts
                           5595 
   B2C7                    5596 LB2C7:
   B2C7 5E 32 30 30 31 25  5597         .asciz  "^2001%^2101%^2201%^2301%^2401%^2001"
        5E 32 31 30 31 25
        5E 32 32 30 31 25
        5E 32 33 30 31 25
        5E 32 34 30 31 25
        5E 32 30 30 31 00
                           5598 
   B2EB                    5599 LB2EB:
   B2EB FA 20 FA 20 F6 22  5600         .byte   0xfa,0x20,0xfa,0x20,0xf6,0x22,0xf5,0x20
        F5 20
   B2F3 F5 20 F3 22 F2 20  5601         .byte   0xf5,0x20,0xf3,0x22,0xf2,0x20,0xe5,0x22
        E5 22
   B2FB E5 22 E2 20 D2 20  5602         .byte   0xe5,0x22,0xe2,0x20,0xd2,0x20,0xbe,0x00
        BE 00
   B303 BC 22 BB 30 B9 32  5603         .byte   0xbc,0x22,0xbb,0x30,0xb9,0x32,0xb9,0x32
        B9 32
   B30B B7 30 B6 32 B5 30  5604         .byte   0xb7,0x30,0xb6,0x32,0xb5,0x30,0xb4,0x32
        B4 32
   B313 B4 32 B3 20 B3 20  5605         .byte   0xb4,0x32,0xb3,0x20,0xb3,0x20,0xb1,0xa0
        B1 A0
   B31B B1 A0 B0 A2 AF A0  5606         .byte   0xb1,0xa0,0xb0,0xa2,0xaf,0xa0,0xaf,0xa6
        AF A6
   B323 AE A0 AE A6 AD A4  5607         .byte   0xae,0xa0,0xae,0xa6,0xad,0xa4,0xac,0xa0
        AC A0
   B32B AC A0 AB A0 AA A0  5608         .byte   0xac,0xa0,0xab,0xa0,0xaa,0xa0,0xaa,0xa0
        AA A0
   B333 A2 80 A0 A0 A0 A0  5609         .byte   0xa2,0x80,0xa0,0xa0,0xa0,0xa0,0x8d,0x80
        8D 80
   B33B 8A A0 7E 80 7B A0  5610         .byte   0x8a,0xa0,0x7e,0x80,0x7b,0xa0,0x79,0xa4
        79 A4
   B343 78 A0 77 A4 76 A0  5611         .byte   0x78,0xa0,0x77,0xa4,0x76,0xa0,0x75,0xa4
        75 A4
   B34B 74 A0 73 A4 72 A0  5612         .byte   0x74,0xa0,0x73,0xa4,0x72,0xa0,0x71,0xa4
        71 A4
   B353 70 A0 6F A4 6E A0  5613         .byte   0x70,0xa0,0x6f,0xa4,0x6e,0xa0,0x6d,0xa4
        6D A4
   B35B 6C A0 69 80 69 80  5614         .byte   0x6c,0xa0,0x69,0x80,0x69,0x80,0x67,0xa0
        67 A0
   B363 5E 20 58 24 57 20  5615         .byte   0x5e,0x20,0x58,0x24,0x57,0x20,0x57,0x20
        57 20
   B36B 56 24 55 20 54 24  5616         .byte   0x56,0x24,0x55,0x20,0x54,0x24,0x54,0x24
        54 24
   B373 53 20 52 24 52 24  5617         .byte   0x53,0x20,0x52,0x24,0x52,0x24,0x50,0x20
        50 20
   B37B 4F 24 4E 20 4D 24  5618         .byte   0x4f,0x24,0x4e,0x20,0x4d,0x24,0x4c,0x20
        4C 20
   B383 4C 20 4B 24 4A 20  5619         .byte   0x4c,0x20,0x4b,0x24,0x4a,0x20,0x49,0x20
        49 20
   B38B 49 00 48 20 47 20  5620         .byte   0x49,0x00,0x48,0x20,0x47,0x20,0x47,0x20
        47 20
   B393 46 20 45 24 45 24  5621         .byte   0x46,0x20,0x45,0x24,0x45,0x24,0x44,0x20
        44 20
   B39B 42 20 42 20 37 04  5622         .byte   0x42,0x20,0x42,0x20,0x37,0x04,0x35,0x20
        35 20
   B3A3 2E 04 2E 04 2D 20  5623         .byte   0x2e,0x04,0x2e,0x04,0x2d,0x20,0x23,0x24
        23 24
   B3AB 21 20 17 24 13 00  5624         .byte   0x21,0x20,0x17,0x24,0x13,0x00,0x11,0x24
        11 24
   B3B3 10 30 07 34 06 30  5625         .byte   0x10,0x30,0x07,0x34,0x06,0x30,0x05,0x30
        05 30
   B3BB FF FF              5626         .byte   0xff,0xff
                           5627 
   B3BD                    5628 LB3BD:
   B3BD D7 22 D5 20 C9 22  5629         .byte   0xd7,0x22,0xd5,0x20,0xc9,0x22
   B3C3 C7 20 C4 24 C3 20  5630         .byte   0xc7,0x20,0xc4,0x24,0xc3,0x20,0xc2,0x24
        C2 24
   B3CB C1 20 BF 24 BF 24  5631         .byte   0xc1,0x20,0xbf,0x24,0xbf,0x24,0xbe,0x20
        BE 20
   B3D3 BD 24 BC 20 BB 24  5632         .byte   0xbd,0x24,0xbc,0x20,0xbb,0x24,0xba,0x20
        BA 20
   B3DB B9 20 B8 24 B7 20  5633         .byte   0xb9,0x20,0xb8,0x24,0xb7,0x20,0xb4,0x00
        B4 00
   B3E3 B4 00 B2 20 A9 20  5634         .byte   0xb4,0x00,0xb2,0x20,0xa9,0x20,0xa3,0x20
        A3 20
   B3EB A2 20 A1 20 A0 20  5635         .byte   0xa2,0x20,0xa1,0x20,0xa0,0x20,0xa0,0x20
        A0 20
   B3F3 9F 20 9F 20 9E 20  5636         .byte   0x9f,0x20,0x9f,0x20,0x9e,0x20,0x9d,0x24
        9D 24
   B3FB 9D 24 9B 20 9A 24  5637         .byte   0x9d,0x24,0x9b,0x20,0x9a,0x24,0x99,0x20
        99 20
   B403 98 20 97 24 97 24  5638         .byte   0x98,0x20,0x97,0x24,0x97,0x24,0x95,0x20
        95 20
   B40B 95 20 94 00 94 00  5639         .byte   0x95,0x20,0x94,0x00,0x94,0x00,0x93,0x20
        93 20
   B413 92 00 92 00 91 20  5640         .byte   0x92,0x00,0x92,0x00,0x91,0x20,0x90,0x20
        90 20
   B41B 90 20 8F 20 8D 20  5641         .byte   0x90,0x20,0x8f,0x20,0x8d,0x20,0x8d,0x20
        8D 20
   B423 81 00 7F 20 79 00  5642         .byte   0x81,0x00,0x7f,0x20,0x79,0x00,0x79,0x00
        79 00
   B42B 78 20 76 20 6B 00  5643         .byte   0x78,0x20,0x76,0x20,0x6b,0x00,0x69,0x20
        69 20
   B433 5E 00 5C 20 5B 30  5644         .byte   0x5e,0x00,0x5c,0x20,0x5b,0x30,0x52,0x10
        52 10
   B43B 51 30 50 30 50 30  5645         .byte   0x51,0x30,0x50,0x30,0x50,0x30,0x4f,0x20
        4F 20
   B443 4E 20 4E 20 4D 20  5646         .byte   0x4e,0x20,0x4e,0x20,0x4d,0x20,0x46,0xa0
        46 A0
   B44B 45 A0 3D A0 3D A0  5647         .byte   0x45,0xa0,0x3d,0xa0,0x3d,0xa0,0x39,0x20
        39 20
   B453 2A 00 28 20 1E 00  5648         .byte   0x2a,0x00,0x28,0x20,0x1e,0x00,0x1c,0x22
        1C 22
   B45B 1C 22 1B 20 1A 22  5649         .byte   0x1c,0x22,0x1b,0x20,0x1a,0x22,0x19,0x20
        19 20
   B463 18 22 18 22 16 20  5650         .byte   0x18,0x22,0x18,0x22,0x16,0x20,0x15,0x22
        15 22
   B46B 15 22 14 A0 13 A2  5651         .byte   0x15,0x22,0x14,0xa0,0x13,0xa2,0x11,0xa0
        11 A0
   B473 FF FF              5652         .byte   0xff,0xff
                           5653 
   B475                    5654 LB475:
   B475 BE 00 BC 22 BB 30  5655         .byte   0xbe,0x00,0xbc,0x22,0xbb,0x30
   B47B B9 32 B9 32 B7 30  5656         .byte   0xb9,0x32,0xb9,0x32,0xb7,0x30,0xb6,0x32
        B6 32
   B483 B5 30 B4 32 B4 32  5657         .byte   0xb5,0x30,0xb4,0x32,0xb4,0x32,0xb3,0x20
        B3 20
   B48B B3 20 B1 A0 B1 A0  5658         .byte   0xb3,0x20,0xb1,0xa0,0xb1,0xa0,0xb0,0xa2
        B0 A2
   B493 AF A0 AF A6 AE A0  5659         .byte   0xaf,0xa0,0xaf,0xa6,0xae,0xa0,0xae,0xa6
        AE A6
   B49B AD A4 AC A0 AC A0  5660         .byte   0xad,0xa4,0xac,0xa0,0xac,0xa0,0xab,0xa0
        AB A0
   B4A3 AA A0 AA A0 A2 80  5661         .byte   0xaa,0xa0,0xaa,0xa0,0xa2,0x80,0xa0,0xa0
        A0 A0
   B4AB A0 A0 8D 80 8A A0  5662         .byte   0xa0,0xa0,0x8d,0x80,0x8a,0xa0,0x7e,0x80
        7E 80
   B4B3 7B A0 79 A4 78 A0  5663         .byte   0x7b,0xa0,0x79,0xa4,0x78,0xa0,0x77,0xa4
        77 A4
   B4BB 76 A0 75 A4 74 A0  5664         .byte   0x76,0xa0,0x75,0xa4,0x74,0xa0,0x73,0xa4
        73 A4
   B4C3 72 A0 71 A4 70 A0  5665         .byte   0x72,0xa0,0x71,0xa4,0x70,0xa0,0x6f,0xa4
        6F A4
   B4CB 6E A0 6D A4 6C A0  5666         .byte   0x6e,0xa0,0x6d,0xa4,0x6c,0xa0,0x69,0x80
        69 80
   B4D3 69 80 67 A0 5E 20  5667         .byte   0x69,0x80,0x67,0xa0,0x5e,0x20,0x58,0x24
        58 24
   B4DB 57 20 57 20 56 24  5668         .byte   0x57,0x20,0x57,0x20,0x56,0x24,0x55,0x20
        55 20
   B4E3 54 24 54 24 53 20  5669         .byte   0x54,0x24,0x54,0x24,0x53,0x20,0x52,0x24
        52 24
   B4EB 52 24 50 20 4F 24  5670         .byte   0x52,0x24,0x50,0x20,0x4f,0x24,0x4e,0x20
        4E 20
   B4F3 4D 24 4C 20 4C 20  5671         .byte   0x4d,0x24,0x4c,0x20,0x4c,0x20,0x4b,0x24
        4B 24
   B4FB 4A 20 49 20 49 00  5672         .byte   0x4a,0x20,0x49,0x20,0x49,0x00,0x48,0x20
        48 20
   B503 47 20 47 20 46 20  5673         .byte   0x47,0x20,0x47,0x20,0x46,0x20,0x45,0x24
        45 24
   B50B 45 24 44 20 42 20  5674         .byte   0x45,0x24,0x44,0x20,0x42,0x20,0x42,0x20
        42 20
   B513 37 04 35 20 2E 04  5675         .byte   0x37,0x04,0x35,0x20,0x2e,0x04,0x2e,0x04
        2E 04
   B51B 2D 20 23 24 21 20  5676         .byte   0x2d,0x20,0x23,0x24,0x21,0x20,0x17,0x24
        17 24
   B523 13 00 11 24 10 30  5677         .byte   0x13,0x00,0x11,0x24,0x10,0x30,0x07,0x34
        07 34
   B52B 06 30 05 30 FF FF  5678         .byte   0x06,0x30,0x05,0x30,0xff,0xff
                           5679 
   B531                    5680 LB531:
   B531 CD 20              5681         .byte   0xcd,0x20
   B533 CC 20 CB 20 CB 20  5682         .byte   0xcc,0x20,0xcb,0x20,0xcb,0x20,0xca,0x00
        CA 00
   B53B C9 20 C9 20 C8 20  5683         .byte   0xc9,0x20,0xc9,0x20,0xc8,0x20,0xc1,0xa0
        C1 A0
   B543 C0 A0 B8 A0 B8 20  5684         .byte   0xc0,0xa0,0xb8,0xa0,0xb8,0x20,0xb4,0x20
        B4 20
   B54B A6 00 A4 20 99 00  5685         .byte   0xa6,0x00,0xa4,0x20,0x99,0x00,0x97,0x22
        97 22
   B553 97 22 96 20 95 22  5686         .byte   0x97,0x22,0x96,0x20,0x95,0x22,0x94,0x20
        94 20
   B55B 93 22 93 22 91 20  5687         .byte   0x93,0x22,0x93,0x22,0x91,0x20,0x90,0x20
        90 20
   B563 90 20 8D A0 8C A0  5688         .byte   0x90,0x20,0x8d,0xa0,0x8c,0xa0,0x7d,0xa2
        7D A2
   B56B 7D A2 7B A0 7B A0  5689         .byte   0x7d,0xa2,0x7b,0xa0,0x7b,0xa0,0x79,0xa2
        79 A2
   B573 79 A2 77 A0 77 A0  5690         .byte   0x79,0xa2,0x77,0xa0,0x77,0xa0,0x76,0x80
        76 80
   B57B 75 A0 6E 20 67 24  5691         .byte   0x75,0xa0,0x6e,0x20,0x67,0x24,0x66,0x20
        66 20
   B583 65 24 64 20 63 24  5692         .byte   0x65,0x24,0x64,0x20,0x63,0x24,0x63,0x24
        63 24
   B58B 61 20 60 24 5F 20  5693         .byte   0x61,0x20,0x60,0x24,0x5f,0x20,0x5e,0x20
        5E 20
   B593 5D 24 5C 20 5B 24  5694         .byte   0x5d,0x24,0x5c,0x20,0x5b,0x24,0x5a,0x20
        5A 20
   B59B 59 24 58 20 56 20  5695         .byte   0x59,0x24,0x58,0x20,0x56,0x20,0x55,0x04
        55 04
   B5A3 54 00 53 24 52 20  5696         .byte   0x54,0x00,0x53,0x24,0x52,0x20,0x52,0x20
        52 20
   B5AB 4F 24 4F 24 4E 30  5697         .byte   0x4f,0x24,0x4f,0x24,0x4e,0x30,0x4d,0x30
        4D 30
   B5B3 47 10 45 30 35 30  5698         .byte   0x47,0x10,0x45,0x30,0x35,0x30,0x33,0x10
        33 10
   B5BB 31 30 31 30 1D 20  5699         .byte   0x31,0x30,0x31,0x30,0x1d,0x20,0xff,0xff
        FF FF
                           5700 
   B5C3                    5701 LB5C3:
   B5C3 A9 20 A3 20 A2 20  5702         .byte   0xa9,0x20,0xa3,0x20,0xa2,0x20,0xa1,0x20
        A1 20
   B5CB A0 20 A0 20 9F 20  5703         .byte   0xa0,0x20,0xa0,0x20,0x9f,0x20,0x9f,0x20
        9F 20
   B5D3 9E 20 9D 24 9D 24  5704         .byte   0x9e,0x20,0x9d,0x24,0x9d,0x24,0x9b,0x20
        9B 20
   B5DB 9A 24 99 20 98 20  5705         .byte   0x9a,0x24,0x99,0x20,0x98,0x20,0x97,0x24
        97 24
   B5E3 97 24 95 20 95 20  5706         .byte   0x97,0x24,0x95,0x20,0x95,0x20,0x94,0x00
        94 00
   B5EB 94 00 93 20 92 00  5707         .byte   0x94,0x00,0x93,0x20,0x92,0x00,0x92,0x00
        92 00
   B5F3 91 20 90 20 90 20  5708         .byte   0x91,0x20,0x90,0x20,0x90,0x20,0x8f,0x20
        8F 20
   B5FB 8D 20 8D 20 81 00  5709         .byte   0x8d,0x20,0x8d,0x20,0x81,0x00,0x7f,0x20
        7F 20
   B603 79 00 79 00 78 20  5710         .byte   0x79,0x00,0x79,0x00,0x78,0x20,0x76,0x20
        76 20
   B60B 6B 00 69 20 5E 00  5711         .byte   0x6b,0x00,0x69,0x20,0x5e,0x00,0x5c,0x20
        5C 20
   B613 5B 30 52 10 51 30  5712         .byte   0x5b,0x30,0x52,0x10,0x51,0x30,0x50,0x30
        50 30
   B61B 50 30 4F 20 4E 20  5713         .byte   0x50,0x30,0x4f,0x20,0x4e,0x20,0x4e,0x20
        4E 20
   B623 4D 20 46 A0 45 A0  5714         .byte   0x4d,0x20,0x46,0xa0,0x45,0xa0,0x3d,0xa0
        3D A0
   B62B 3D A0 39 20 2A 00  5715         .byte   0x3d,0xa0,0x39,0x20,0x2a,0x00,0x28,0x20
        28 20
   B633 1E 00 1C 22 1C 22  5716         .byte   0x1e,0x00,0x1c,0x22,0x1c,0x22,0x1b,0x20
        1B 20
   B63B 1A 22 19 20 18 22  5717         .byte   0x1a,0x22,0x19,0x20,0x18,0x22,0x18,0x22
        18 22
   B643 16 20 15 22 15 22  5718         .byte   0x16,0x20,0x15,0x22,0x15,0x22,0x14,0xa0
        14 A0
   B64B 13 A2 11 A0        5719         .byte   0x13,0xa2,0x11,0xa0
                           5720 
                           5721 ; All empty (0xFFs) in this gap
                           5722 
   F780                    5723         .org    0xF780
                           5724 
                           5725 ; Tables
   F780                    5726 LF780:
   F780 57                 5727         .byte   0x57
   F781 0B                 5728         .byte   0x0b
   F782 00                 5729         .byte   0x00
   F783 00                 5730         .byte   0x00
   F784 00                 5731         .byte   0x00
   F785 00                 5732         .byte   0x00
   F786 08                 5733         .byte   0x08
   F787 00                 5734         .byte   0x00
   F788 00                 5735         .byte   0x00
   F789 00                 5736         .byte   0x00
   F78A 20                 5737         .byte   0x20
   F78B 00                 5738         .byte   0x00
   F78C 00                 5739         .byte   0x00
   F78D 00                 5740         .byte   0x00
   F78E 80                 5741         .byte   0x80
   F78F 00                 5742         .byte   0x00
   F790 00                 5743         .byte   0x00
   F791 00                 5744         .byte   0x00
   F792 00                 5745         .byte   0x00
   F793 00                 5746         .byte   0x00
   F794 00                 5747         .byte   0x00
   F795 04                 5748         .byte   0x04
   F796 00                 5749         .byte   0x00
   F797 00                 5750         .byte   0x00
   F798 00                 5751         .byte   0x00
   F799 10                 5752         .byte   0x10
   F79A 00                 5753         .byte   0x00
   F79B 00                 5754         .byte   0x00
   F79C 00                 5755         .byte   0x00
   F79D 00                 5756         .byte   0x00
   F79E 00                 5757         .byte   0x00
   F79F 00                 5758         .byte   0x00
                           5759 
   F7A0                    5760 LF7A0:
   F7A0 40                 5761         .byte   0x40
   F7A1 12                 5762         .byte   0x12
   F7A2 20                 5763         .byte   0x20
   F7A3 09                 5764         .byte   0x09
   F7A4 80                 5765         .byte   0x80
   F7A5 24                 5766         .byte   0x24
   F7A6 02                 5767         .byte   0x02
   F7A7 00                 5768         .byte   0x00
   F7A8 40                 5769         .byte   0x40
   F7A9 12                 5770         .byte   0x12
   F7AA 20                 5771         .byte   0x20
   F7AB 09                 5772         .byte   0x09
   F7AC 80                 5773         .byte   0x80
   F7AD 24                 5774         .byte   0x24
   F7AE 04                 5775         .byte   0x04
   F7AF 00                 5776         .byte   0x00
   F7B0 00                 5777         .byte   0x00
   F7B1 00                 5778         .byte   0x00
   F7B2 00                 5779         .byte   0x00
   F7B3 00                 5780         .byte   0x00
   F7B4 00                 5781         .byte   0x00
   F7B5 00                 5782         .byte   0x00
   F7B6 00                 5783         .byte   0x00
   F7B7 00                 5784         .byte   0x00
   F7B8 00                 5785         .byte   0x00
   F7B9 00                 5786         .byte   0x00
   F7BA 00                 5787         .byte   0x00
   F7BB 00                 5788         .byte   0x00
   F7BC 08                 5789         .byte   0x08
   F7BD 00                 5790         .byte   0x00
   F7BE 00                 5791         .byte   0x00
   F7BF 00                 5792         .byte   0x00
                           5793 
   F7C0                    5794 LF7C0:
   F7C0 00                 5795         .byte   0x00
                           5796 ;
                           5797 ; All empty (0xFFs) in this gap
                           5798 ;
   F800                    5799         .org    0xF800
                           5800 ; Reset
   F800                    5801 RESET:
   F800 0F            [ 2] 5802         sei                 ; disable interrupts
   F801 86 03         [ 2] 5803         ldaa    #0x03
   F803 B7 10 24      [ 4] 5804         staa    TMSK2       ; disable irqs, set prescaler to 16
   F806 86 80         [ 2] 5805         ldaa    #0x80
   F808 B7 10 22      [ 4] 5806         staa    TMSK1       ; enable OC1 irq
   F80B 86 FE         [ 2] 5807         ldaa    #0xFE
   F80D B7 10 35      [ 4] 5808         staa    BPROT       ; protect everything except $xE00-$xE1F
   F810 96 07         [ 3] 5809         ldaa    0x0007      ;
   F812 81 DB         [ 2] 5810         cmpa    #0xDB       ; special unprotect mode???
   F814 26 06         [ 3] 5811         bne     LF81C       ; if not, jump ahead
   F816 7F 10 35      [ 6] 5812         clr     BPROT       ; else unprotect everything
   F819 7F 00 07      [ 6] 5813         clr     0x0007      ; reset special unprotect mode???
   F81C                    5814 LF81C:
   F81C 8E 01 FF      [ 3] 5815         lds     #0x01FF     ; init SP
   F81F 86 A5         [ 2] 5816         ldaa    #0xA5
   F821 B7 10 5D      [ 4] 5817         staa    CSCTL       ; enable external IO:
                           5818                             ; IO1EN,  BUSSEL, active LOW
                           5819                             ; IO2EN,  PIA/SCCSEL, active LOW
                           5820                             ; CSPROG, ROMSEL priority over RAMSEL 
                           5821                             ; CSPROG, ROMSEL enabled, 32K, $8000-$FFFF
   F824 86 01         [ 2] 5822         ldaa    #0x01
   F826 B7 10 5F      [ 4] 5823         staa    CSGSIZ      ; CSGEN,  RAMSEL active low
                           5824                             ; CSGEN,  RAMSEL 32K
   F829 86 00         [ 2] 5825         ldaa    #0x00
   F82B B7 10 5E      [ 4] 5826         staa    CSGADR      ; CSGEN,  RAMSEL = $0000-$7FFF (except internal regs)
   F82E 86 F0         [ 2] 5827         ldaa    #0xF0
   F830 B7 10 5C      [ 4] 5828         staa    CSSTRH      ; 3 cycle clock stretching on BUSSEL and LCRS
   F833 7F 00 00      [ 6] 5829         clr     0x0000      ; ????? Done with basic init?
                           5830 
                           5831 ; Initialize Main PIA
   F836 86 30         [ 2] 5832         ldaa    #0x30       ;
   F838 B7 18 05      [ 4] 5833         staa    PIA0CRA     ; control register A, CA2=0, sel DDRA
   F83B B7 18 07      [ 4] 5834         staa    PIA0CRB     ; control register B, CB2=0, sel DDRB
   F83E 86 FF         [ 2] 5835         ldaa    #0xFF
   F840 B7 18 06      [ 4] 5836         staa    PIA0DDRB    ; select B0-B7 to be outputs
   F843 86 78         [ 2] 5837         ldaa    #0x78       ;
   F845 B7 18 04      [ 4] 5838         staa    PIA0DDRA    ; select A3-A6 to be outputs
   F848 86 34         [ 2] 5839         ldaa    #0x34       ;
   F84A B7 18 05      [ 4] 5840         staa    PIA0CRA     ; select output register A
   F84D B7 18 07      [ 4] 5841         staa    PIA0CRB     ; select output register B
   F850 C6 FF         [ 2] 5842         ldab    #0xFF
   F852 BD F9 C5      [ 6] 5843         jsr     BUTNLIT     ; turn on all button lights
   F855 20 13         [ 3] 5844         bra     LF86A       ; jump past data table
                           5845 
                           5846 ; Data loaded into SCCCTRLB SCC
   F857                    5847 LF857:
   F857 09 4A              5848         .byte   0x09,0x4a   ; channel reset B, master irq enable, no vector
   F859 01 10              5849         .byte   0x01,0x10   ; irq on all character received
   F85B 0C 18              5850         .byte   0x0c,0x18   ; Lower byte of time constant
   F85D 0D 00              5851         .byte   0x0d,0x00   ; Upper byte of time constant
   F85F 04 44              5852         .byte   0x04,0x44   ; X16 clock mode, 8-bit sync char, 1 stop bit, no parity
   F861 0E 63              5853         .byte   0x0e,0x63   ; Disable DPLL, BR enable & source
   F863 05 68              5854         .byte   0x05,0x68   ; No DTR/RTS, Tx 8 bits/char, Tx enable
   F865 0B 56              5855         .byte   0x0b,0x56   ; Rx & Tx & TRxC clk from BR gen
   F867 03 C1              5856         .byte   0x03,0xc1   ; Rx 8 bits/char, Rx Enable
                           5857         ;   tc = 4Mhz / (2 * DesiredRate * BRClockPeriod) - 2
                           5858         ;   DesiredRate=~4800 bps with tc=0x18 and BRClockPeriod=16
   F869 FF                 5859         .byte   0xff        ; end of table marker
                           5860 
                           5861 ; init SCC (8530)
   F86A                    5862 LF86A:
   F86A CE F8 57      [ 3] 5863         ldx     #LF857
   F86D                    5864 LF86D:
   F86D A6 00         [ 4] 5865         ldaa    0,X
   F86F 81 FF         [ 2] 5866         cmpa    #0xFF
   F871 27 06         [ 3] 5867         beq     LF879
   F873 B7 18 0D      [ 4] 5868         staa    SCCCTRLB
   F876 08            [ 3] 5869         inx
   F877 20 F4         [ 3] 5870         bra     LF86D
                           5871 
                           5872 ; Setup normal SCI, 8 data bits, 1 stop bit
                           5873 ; Interrupts disabled, Transmitter and Receiver enabled
                           5874 ; prescaler = /13, SCR=/2, rate = 9600 baud at 16Mhz clock
                           5875 
   F879                    5876 LF879:
   F879 86 00         [ 2] 5877         ldaa    #0x00
   F87B B7 10 2C      [ 4] 5878         staa    SCCR1  
   F87E 86 0C         [ 2] 5879         ldaa    #0x0C
   F880 B7 10 2D      [ 4] 5880         staa    SCCR2  
   F883 86 31         [ 2] 5881         ldaa    #0x31
   F885 B7 10 2B      [ 4] 5882         staa    BAUD  
                           5883 
                           5884 ; Initialize all RAM vectors to RTI: 
                           5885 ; Opcode 0x3b into vectors at 0x0100 through 0x0139
                           5886 
   F888 CE 01 00      [ 3] 5887         ldx     #0x0100
   F88B 86 3B         [ 2] 5888         ldaa    #0x3B       ; RTI opcode
   F88D                    5889 LF88D:
   F88D A7 00         [ 4] 5890         staa    0,X
   F88F 08            [ 3] 5891         inx
   F890 08            [ 3] 5892         inx
   F891 08            [ 3] 5893         inx
   F892 8C 01 3C      [ 4] 5894         cpx     #0x013C
   F895 25 F6         [ 3] 5895         bcs     LF88D
   F897 C6 F0         [ 2] 5896         ldab    #0xF0
   F899 F7 18 04      [ 4] 5897         stab    PIA0PRA     ; enable LCD backlight, disable RESET button light
   F89C 86 7E         [ 2] 5898         ldaa    #0x7E
   F89E 97 03         [ 3] 5899         staa    (0x0003)    ; Put a jump instruction here???
                           5900 
                           5901 ; Non-destructive ram test:
                           5902 ;
                           5903 ; HC11 Internal RAM: 0x0000-0x3ff
                           5904 ; External NVRAM:    0x2000-0x7fff
                           5905 ;
                           5906 ; Note:
                           5907 ; External NVRAM:    0x0400-0xfff is also available, but not tested
                           5908 
   F8A0 CE 00 00      [ 3] 5909         ldx     #0x0000
   F8A3                    5910 LF8A3:
   F8A3 E6 00         [ 4] 5911         ldab    0,X         ; save value
   F8A5 86 55         [ 2] 5912         ldaa    #0x55
   F8A7 A7 00         [ 4] 5913         staa    0,X
   F8A9 A1 00         [ 4] 5914         cmpa    0,X
   F8AB 26 19         [ 3] 5915         bne     LF8C6
   F8AD 49            [ 2] 5916         rola
   F8AE A7 00         [ 4] 5917         staa    0,X
   F8B0 A1 00         [ 4] 5918         cmpa    0,X
   F8B2 26 12         [ 3] 5919         bne     LF8C6
   F8B4 E7 00         [ 4] 5920         stab    0,X         ; restore value
   F8B6 08            [ 3] 5921         inx
   F8B7 8C 04 00      [ 4] 5922         cpx     #0x0400
   F8BA 26 03         [ 3] 5923         bne     LF8BF
   F8BC CE 20 00      [ 3] 5924         ldx     #0x2000
   F8BF                    5925 LF8BF:  
   F8BF 8C 80 00      [ 4] 5926         cpx     #0x8000
   F8C2 26 DF         [ 3] 5927         bne     LF8A3
   F8C4 20 04         [ 3] 5928         bra     LF8CA
                           5929 
   F8C6                    5930 LF8C6:
   F8C6 86 01         [ 2] 5931         ldaa    #0x01       ; Mark Failed RAM test
   F8C8 97 00         [ 3] 5932         staa    (0x0000)
                           5933 ; 
   F8CA                    5934 LF8CA:
   F8CA C6 01         [ 2] 5935         ldab    #0x01
   F8CC BD F9 95      [ 6] 5936         jsr     DIAGDGT     ; write digit 1 to diag display
   F8CF B6 10 35      [ 4] 5937         ldaa    BPROT  
   F8D2 26 0F         [ 3] 5938         bne     LF8E3       ; if something is protected, jump ahead
   F8D4 B6 30 00      [ 4] 5939         ldaa    (0x3000)    ; NVRAM
   F8D7 81 7E         [ 2] 5940         cmpa    #0x7E
   F8D9 26 08         [ 3] 5941         bne     LF8E3       ; if RAM(0x3000) == 0x7E, jump ahead anyway (special unlock?)
                           5942 
                           5943 ; error?
   F8DB C6 0E         [ 2] 5944         ldab    #0x0E
   F8DD BD F9 95      [ 6] 5945         jsr     DIAGDGT      ; write digit E to diag display
   F8E0 7E 30 00      [ 3] 5946         jmp     (0x3000)     ; jump to routine in NVRAM?
                           5947 
                           5948 ; checking for serial connection
                           5949 
   F8E3                    5950 LF8E3:
   F8E3 CE F0 00      [ 3] 5951         ldx     #0xF000     ; timeout counter
   F8E6                    5952 LF8E6:
   F8E6 01            [ 2] 5953         nop
   F8E7 01            [ 2] 5954         nop
   F8E8 09            [ 3] 5955         dex
   F8E9 27 0B         [ 3] 5956         beq     LF8F6       ; if time is up, jump ahead
   F8EB BD F9 45      [ 6] 5957         jsr     SERIALR     ; else read serial data if available
   F8EE 24 F6         [ 3] 5958         bcc     LF8E6       ; if no data available, loop
   F8F0 81 1B         [ 2] 5959         cmpa    #0x1B       ; if serial data was read, is it an ESC?
   F8F2 27 29         [ 3] 5960         beq     LF91D       ; if so, jump to echo hex char routine?
   F8F4 20 F0         [ 3] 5961         bra     LF8E6       ; else loop
   F8F6                    5962 LF8F6:
   F8F6 B6 80 00      [ 4] 5963         ldaa    L8000       ; check if this is a regular rom?
   F8F9 81 7E         [ 2] 5964         cmpa    #0x7E        
   F8FB 26 0B         [ 3] 5965         bne     MINIMON     ; if not, jump ahead
                           5966 
   F8FD C6 0A         [ 2] 5967         ldab    #0x0A
   F8FF BD F9 95      [ 6] 5968         jsr     DIAGDGT     ; else write digit A to diag display
                           5969 
   F902 BD 80 00      [ 6] 5970         jsr     L8000       ; jump to start of rom routine
   F905 0F            [ 2] 5971         sei                 ; if we ever come return, just loop and do it all again
   F906 20 EE         [ 3] 5972         bra     LF8F6
                           5973 
                           5974 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           5975 
   F908                    5976 MINIMON:
   F908 C6 10         [ 2] 5977         ldab    #0x10       ; not a regular rom
   F90A BD F9 95      [ 6] 5978         jsr     DIAGDGT     ; blank the diag display
                           5979 
   F90D BD F9 D8      [ 6] 5980         jsr     SERMSGW     ; enter the mini-monitor???
   F910 4D 49 4E 49 2D 4D  5981         .ascis  'MINI-MON'
        4F CE
                           5982 
   F918 C6 10         [ 2] 5983         ldab    #0x10
   F91A BD F9 95      [ 6] 5984         jsr     DIAGDGT     ; blank the diag display
                           5985 
   F91D                    5986 LF91D:
   F91D 7F 00 05      [ 6] 5987         clr     (0x0005)
   F920 7F 00 04      [ 6] 5988         clr     (0x0004)
   F923 7F 00 02      [ 6] 5989         clr     (0x0002)
   F926 7F 00 06      [ 6] 5990         clr     (0x0006)
                           5991 
   F929 BD F9 D8      [ 6] 5992         jsr     SERMSGW
   F92C 0D 0A BE           5993         .ascis  '\r\n>'
                           5994 
                           5995 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           5996 
                           5997 ; convert A to 2 hex digits and transmit
   F92F                    5998 SERHEXW:
   F92F 36            [ 3] 5999         psha
   F930 44            [ 2] 6000         lsra
   F931 44            [ 2] 6001         lsra
   F932 44            [ 2] 6002         lsra
   F933 44            [ 2] 6003         lsra
   F934 BD F9 38      [ 6] 6004         jsr     LF938
   F937 32            [ 4] 6005         pula
   F938                    6006 LF938:
   F938 84 0F         [ 2] 6007         anda    #0x0F
   F93A 8A 30         [ 2] 6008         oraa    #0x30
   F93C 81 3A         [ 2] 6009         cmpa    #0x3A
   F93E 25 02         [ 3] 6010         bcs     LF942
   F940 8B 07         [ 2] 6011         adda    #0x07
   F942                    6012 LF942:
   F942 7E F9 6F      [ 3] 6013         jmp     SERIALW
                           6014 
                           6015 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           6016 
                           6017 ; serial read non-blocking
   F945                    6018 SERIALR:
   F945 B6 10 2E      [ 4] 6019         ldaa    SCSR  
   F948 85 20         [ 2] 6020         bita    #0x20
   F94A 26 09         [ 3] 6021         bne     LF955
   F94C 0C            [ 2] 6022         clc
   F94D 39            [ 5] 6023         rts
                           6024 
                           6025 ; serial blocking read
   F94E                    6026 SERBLKR:
   F94E B6 10 2E      [ 4] 6027         ldaa    SCSR        ; read serial status
   F951 85 20         [ 2] 6028         bita    #0x20
   F953 27 F9         [ 3] 6029         beq     SERBLKR     ; if RDRF=0, loop
                           6030 
                           6031 ; read serial data, (assumes it's ready)
   F955                    6032 LF955:
   F955 B6 10 2E      [ 4] 6033         ldaa    SCSR        ; read serial status
   F958 85 02         [ 2] 6034         bita    #0x02
   F95A 26 09         [ 3] 6035         bne     LF965       ; if FE=1, clear it
   F95C 85 08         [ 2] 6036         bita    #0x08
   F95E 26 05         [ 3] 6037         bne     LF965       ; if OR=1, clear it
   F960 B6 10 2F      [ 4] 6038         ldaa    SCDR        ; otherwise, good data
   F963 0D            [ 2] 6039         sec
   F964 39            [ 5] 6040         rts
                           6041 
   F965                    6042 LF965:
   F965 B6 10 2F      [ 4] 6043         ldaa    SCDR        ; clear any error
   F968 86 2F         [ 2] 6044         ldaa    #0x2F       ; '/'   
   F96A BD F9 6F      [ 6] 6045         jsr     SERIALW
   F96D 20 DF         [ 3] 6046         bra     SERBLKR     ; go to wait for a character
                           6047 
                           6048 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           6049 
                           6050 ; Send A to SCI with CR turned to CRLF
   F96F                    6051 SERIALW:
   F96F 81 0D         [ 2] 6052         cmpa    #0x0D       ; CR?
   F971 27 02         [ 3] 6053         beq     LF975       ; if so echo CR+LF
   F973 20 07         [ 3] 6054         bra     SERRAWW     ; else just echo it
   F975                    6055 LF975:
   F975 86 0D         [ 2] 6056         ldaa    #0x0D
   F977 BD F9 7C      [ 6] 6057         jsr     SERRAWW
   F97A 86 0A         [ 2] 6058         ldaa    #0x0A
                           6059 
                           6060 ; send a char to SCI
   F97C                    6061 SERRAWW:
   F97C F6 10 2E      [ 4] 6062         ldab    SCSR        ; wait for ready to send
   F97F C5 40         [ 2] 6063         bitb    #0x40
   F981 27 F9         [ 3] 6064         beq     SERRAWW
   F983 B7 10 2F      [ 4] 6065         staa    SCDR        ; send it
   F986 39            [ 5] 6066         rts
                           6067 
                           6068 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           6069 
                           6070 ; Unused?
   F987                    6071 LF987:
   F987 BD F9 4E      [ 6] 6072         jsr     SERBLKR     ; get a serial char
   F98A 81 7A         [ 2] 6073         cmpa    #0x7A       ;'z'
   F98C 22 06         [ 3] 6074         bhi     LF994
   F98E 81 61         [ 2] 6075         cmpa    #0x61       ;'a'
   F990 25 02         [ 3] 6076         bcs     LF994
   F992 82 20         [ 2] 6077         sbca    #0x20       ;convert to upper case?
   F994                    6078 LF994:
   F994 39            [ 5] 6079         rts
                           6080 
                           6081 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           6082 
                           6083 ; Write hex digit arg in B to diagnostic lights
                           6084 ; or B=0x10 or higher for blank
                           6085 
   F995                    6086 DIAGDGT:
   F995 36            [ 3] 6087         psha
   F996 C1 11         [ 2] 6088         cmpb    #0x11
   F998 25 02         [ 3] 6089         bcs     LF99C
   F99A C6 10         [ 2] 6090         ldab    #0x10
   F99C                    6091 LF99C:
   F99C CE F9 B4      [ 3] 6092         ldx     #LF9B4
   F99F 3A            [ 3] 6093         abx
   F9A0 A6 00         [ 4] 6094         ldaa    0,X
   F9A2 B7 18 06      [ 4] 6095         staa    PIA0PRB     ; write arg to local data bus
   F9A5 B6 18 04      [ 4] 6096         ldaa    PIA0PRA     ; read from Port A
   F9A8 8A 20         [ 2] 6097         oraa    #0x20       ; bit 5 high
   F9AA B7 18 04      [ 4] 6098         staa    PIA0PRA     ; write back to Port A
   F9AD 84 DF         [ 2] 6099         anda    #0xDF       ; bit 5 low
   F9AF B7 18 04      [ 4] 6100         staa    PIA0PRA     ; write back to Port A
   F9B2 32            [ 4] 6101         pula
   F9B3 39            [ 5] 6102         rts
                           6103 
                           6104 ; 7 segment patterns - XGFEDCBA
   F9B4                    6105 LF9B4:
   F9B4 C0                 6106         .byte   0xc0    ; 0
   F9B5 F9                 6107         .byte   0xf9    ; 1
   F9B6 A4                 6108         .byte   0xa4    ; 2
   F9B7 B0                 6109         .byte   0xb0    ; 3
   F9B8 99                 6110         .byte   0x99    ; 4
   F9B9 92                 6111         .byte   0x92    ; 5
   F9BA 82                 6112         .byte   0x82    ; 6
   F9BB F8                 6113         .byte   0xf8    ; 7
   F9BC 80                 6114         .byte   0x80    ; 8
   F9BD 90                 6115         .byte   0x90    ; 9
   F9BE 88                 6116         .byte   0x88    ; A 
   F9BF 83                 6117         .byte   0x83    ; b
   F9C0 C6                 6118         .byte   0xc6    ; C
   F9C1 A1                 6119         .byte   0xa1    ; d
   F9C2 86                 6120         .byte   0x86    ; E
   F9C3 8E                 6121         .byte   0x8e    ; F
   F9C4 FF                 6122         .byte   0xff    ; blank
                           6123 
                           6124 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           6125 
                           6126 ; Write arg in B to Button Lights
   F9C5                    6127 BUTNLIT:
   F9C5 36            [ 3] 6128         psha
   F9C6 F7 18 06      [ 4] 6129         stab    PIA0PRB     ; write arg to local data bus
   F9C9 B6 18 04      [ 4] 6130         ldaa    PIA0PRA     ; read from Port A
   F9CC 84 EF         [ 2] 6131         anda    #0xEF       ; bit 4 low
   F9CE B7 18 04      [ 4] 6132         staa    PIA0PRA     ; write back to Port A
   F9D1 8A 10         [ 2] 6133         oraa    #0x10       ; bit 4 high
   F9D3 B7 18 04      [ 4] 6134         staa    PIA0PRA     ; write this to Port A
   F9D6 32            [ 4] 6135         pula
   F9D7 39            [ 5] 6136         rts
                           6137 
                           6138 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           6139 
                           6140 ; Send rom message via SCI
   F9D8                    6141 SERMSGW:
   F9D8 18 38         [ 6] 6142         puly
   F9DA                    6143 LF9DA:
   F9DA 18 A6 00      [ 5] 6144         ldaa    0,Y
   F9DD 27 09         [ 3] 6145         beq     LF9E8       ; if zero terminated, return
   F9DF 2B 0C         [ 3] 6146         bmi     LF9ED       ; if high bit set..do last char and return
   F9E1 BD F9 7C      [ 6] 6147         jsr     SERRAWW     ; else send char
   F9E4 18 08         [ 4] 6148         iny
   F9E6 20 F2         [ 3] 6149         bra     LF9DA       ; and loop for next one
                           6150 
   F9E8                    6151 LF9E8:
   F9E8 18 08         [ 4] 6152         iny                 ; setup return address and return
   F9EA 18 3C         [ 5] 6153         pshy
   F9EC 39            [ 5] 6154         rts
                           6155 
   F9ED                    6156 LF9ED:
   F9ED 84 7F         [ 2] 6157         anda    #0x7F       ; remove top bit
   F9EF BD F9 7C      [ 6] 6158         jsr     SERRAWW     ; send char
   F9F2 20 F4         [ 3] 6159         bra     LF9E8       ; and we're done
   F9F4 39            [ 5] 6160         rts
                           6161 
   F9F5                    6162 DORTS:
   F9F5 39            [ 5] 6163         rts
   F9F6                    6164 DORTI:        
   F9F6 3B            [12] 6165         rti
                           6166 
                           6167 ; all 0xffs in this gap
                           6168 
   FFA0                    6169         .org    0xFFA0
                           6170 
   FFA0 7E F9 F5      [ 3] 6171         jmp     DORTS
   FFA3 7E F9 F5      [ 3] 6172         jmp     DORTS
   FFA6 7E F9 F5      [ 3] 6173         jmp     DORTS
   FFA9 7E F9 2F      [ 3] 6174         jmp     SERHEXW
   FFAC 7E F9 D8      [ 3] 6175         jmp     SERMSGW      
   FFAF 7E F9 45      [ 3] 6176         jmp     SERIALR     
   FFB2 7E F9 6F      [ 3] 6177         jmp     SERIALW      
   FFB5 7E F9 08      [ 3] 6178         jmp     MINIMON
   FFB8 7E F9 95      [ 3] 6179         jmp     DIAGDGT 
   FFBB 7E F9 C5      [ 3] 6180         jmp     BUTNLIT 
                           6181 
   FFBE FF                 6182        .byte    0xff
   FFBF FF                 6183        .byte    0xff
                           6184 
                           6185 ; Vectors
                           6186 
   FFC0 F9 F6              6187        .word   DORTI        ; Stub RTI
   FFC2 F9 F6              6188        .word   DORTI        ; Stub RTI
   FFC4 F9 F6              6189        .word   DORTI        ; Stub RTI
   FFC6 F9 F6              6190        .word   DORTI        ; Stub RTI
   FFC8 F9 F6              6191        .word   DORTI        ; Stub RTI
   FFCA F9 F6              6192        .word   DORTI        ; Stub RTI
   FFCC F9 F6              6193        .word   DORTI        ; Stub RTI
   FFCE F9 F6              6194        .word   DORTI        ; Stub RTI
   FFD0 F9 F6              6195        .word   DORTI        ; Stub RTI
   FFD2 F9 F6              6196        .word   DORTI        ; Stub RTI
   FFD4 F9 F6              6197        .word   DORTI        ; Stub RTI
                           6198 
   FFD6 01 00              6199         .word  0x0100       ; SCI
   FFD8 01 03              6200         .word  0x0103       ; SPI
   FFDA 01 06              6201         .word  0x0106       ; PA accum. input edge
   FFDC 01 09              6202         .word  0x0109       ; PA Overflow
                           6203 
   FFDE F9 F6              6204         .word  DORTI        ; Stub RTI
                           6205 
   FFE0 01 0C              6206         .word  0x010c       ; TI4O5
   FFE2 01 0F              6207         .word  0x010f       ; TOC4
   FFE4 01 12              6208         .word  0x0112       ; TOC3
   FFE6 01 15              6209         .word  0x0115       ; TOC2
   FFE8 01 18              6210         .word  0x0118       ; TOC1
   FFEA 01 1B              6211         .word  0x011b       ; TIC3
   FFEC 01 1E              6212         .word  0x011e       ; TIC2
   FFEE 01 21              6213         .word  0x0121       ; TIC1
   FFF0 01 24              6214         .word  0x0124       ; RTI
   FFF2 01 27              6215         .word  0x0127       ; ~IRQ
   FFF4 01 2A              6216         .word  0x012a       ; XIRQ
   FFF6 01 2D              6217         .word  0x012d       ; SWI
   FFF8 01 30              6218         .word  0x0130       ; ILLEGAL OPCODE
   FFFA 01 33              6219         .word  0x0133       ; COP Failure
   FFFC 01 36              6220         .word  0x0136       ; COP Clock Monitor Fail
                           6221 
   FFFE F8 00              6222         .word  RESET        ; Reset
                           6223 
