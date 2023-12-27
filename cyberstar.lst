                              1 
                              2 ;;;;;;;;;;;;;;;;;;;;;
                              3 ; Cyberstar v1.6
                              4 ;   by
                              5 ; David B. Philipsen
                              6 ;
                              7 ; Reverse-engineered
                              8 ;   by
                              9 ; Frank Palazzolo
                             10 ;;;;;;;;;;;;;;;;;;;;
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
                     00B0    60 TSCNT       .equ    0x00b0
                             61 
                             62 ; NVRAM locations
                             63 
                     040B    64 CPYRTCS     .equ    0x040B      ; 0x040B/0x040C - copyright message checksum
                     040F    65 ERASEFLG    .equ    0x040F      ; 0 = normal boot, 1 = erasing EEPROM
                     0426    66 NUMBOOT     .equ    0x0426      ; 0x0426/0x0427
                             67 
                             68         .area   region1 (ABS)
   8000                      69         .org    0x8000
                             70 
                             71 ; Disassembly originally from unidasm
                             72 
   8000 7E 80 50      [ 3]   73         jmp     L8050           ; jump past copyright message
                             74 
   8003                      75 CPYRTMSG:
   8003 43 6F 70 79 72 69    76         .ascii  'Copyright (c) 1993 by David B. Philipsen Licensed by ShowBiz Pizza Time, Inc.'
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
                             77 
   8050                      78 L8050:
   8050 0F            [ 2]   79         sei
                             80 
   8051 FC 04 26      [ 5]   81         ldd     NUMBOOT         ; increment boot cycle counter?
   8054 C3 00 01      [ 4]   82         addd    #0x0001
   8057 FD 04 26      [ 5]   83         std     NUMBOOT
                             84 
   805A CE AD 1D      [ 3]   85         ldx     #TASK2          ;
   805D FF 01 CE      [ 5]   86         stx     (0x01CE)        ; store this vector here?
   8060 7F 01 C7      [ 6]   87         clr     (0x01C7)
   8063 CC 01 C6      [ 3]   88         ldd     #0x01C6         ;
   8066 FD 01 3E      [ 5]   89         std     (0x013E)        ; store this vector here? Some sort of RTI setup
   8069 7F 00 B0      [ 6]   90         clr     TSCNT
   806C 7F 00 4E      [ 6]   91         clr     (0x004E)
   806F 7F 00 B6      [ 6]   92         clr     (0x00B6)
   8072 7F 00 4D      [ 6]   93         clr     (0x004D)
   8075 86 03         [ 2]   94         ldaa    #0x03
   8077 B7 10 A8      [ 4]   95         staa    (0x10A8)        ; board 11??
   807A 18 CE 00 80   [ 4]   96         ldy     #0x0080         ; delay loop
   807E                      97 L807E:
   807E 18 09         [ 4]   98         dey
   8080 26 FC         [ 3]   99         bne     L807E
   8082 86 11         [ 2]  100         ldaa    #0x11
   8084 B7 10 A8      [ 4]  101         staa    (0x10A8)        ; board 11??
                            102 
   8087 C6 10         [ 2]  103         ldab    #0x10
   8089 BD F9 95      [ 6]  104         jsr     LF995           ; blank the diag display
                            105 
   808C B6 18 04      [ 4]  106         ldaa    (0x1804)        ; turn off reset button light
   808F 84 BF         [ 2]  107         anda    #0xBF
   8091 B7 18 04      [ 4]  108         staa    (0x1804)
   8094 86 FF         [ 2]  109         ldaa    #0xFF
   8096 97 AC         [ 3]  110         staa    (0x00AC)        ; ???
                            111 
   8098 BD 86 C4      [ 6]  112         jsr     L86C4           ; Init PIAs on cards?
   809B BD 99 A6      [ 6]  113         jsr     L99A6           ; main2?
   809E BD 8C 3C      [ 6]  114         jsr     L8C3C           ; reset LCD?
   80A1 BD 87 E8      [ 6]  115         jsr     L87E8           ; SCC something?
   80A4 BD 87 BC      [ 6]  116         jsr     L87BC           ; SCC something?
   80A7 BD 8C 7E      [ 6]  117         jsr     L8C7E           ; reset LCD buffer
   80AA BD 8D 29      [ 6]  118         jsr     L8D29           ; some LCD command?
   80AD BD 8B C0      [ 6]  119         jsr     L8BC0           ; setup IRQ handlers
   80B0 BD 8B EE      [ 6]  120         jsr     L8BEE
   80B3 0E            [ 2]  121         cli
   80B4 BD A2 5E      [ 6]  122         jsr     LA25E           ; compute and store copyright checksum
   80B7 B6 04 0F      [ 4]  123         ldaa    ERASEFLG
   80BA 81 01         [ 2]  124         cmpa    #0x01           ; 1 means erase EEPROM!
   80BC 26 03         [ 3]  125         bne     L80C1
   80BE 7E A2 75      [ 3]  126         jmp     LA275           ; erase EEPROM: skipped if ERASEFLG !=1
   80C1                     127 L80C1:
   80C1 FC 04 0B      [ 5]  128         ldd     CPYRTCS         ; copyright checksum
   80C4 1A 83 19 7B   [ 5]  129         cpd     #CHKSUM         ; check against copyright checksum value
   80C8 26 4F         [ 3]  130         bne     LOCKUP          ; bye bye
   80CA 5F            [ 2]  131         clrb
   80CB D7 62         [ 3]  132         stab    (0x0062)        ; button light buffer?
   80CD BD F9 C5      [ 6]  133         jsr     (0xF9C5)        ; turn off? button lights
   80D0 BD A3 41      [ 6]  134         jsr     (0xA341)
   80D3 B6 04 00      [ 4]  135         ldaa    (0x0400)
   80D6 81 07         [ 2]  136         cmpa    #0x07
   80D8 27 42         [ 3]  137         beq     L811C
   80DA 25 29         [ 3]  138         bcs     L8105
   80DC 81 06         [ 2]  139         cmpa    #0x06
   80DE 27 25         [ 3]  140         beq     L8105
   80E0 CC 00 00      [ 3]  141         ldd     #0x0000
   80E3 FD 04 0D      [ 5]  142         std     (0x040D)
   80E6 CC 00 C8      [ 3]  143         ldd     #0x00C8
   80E9 DD 1B         [ 4]  144         std     CDTIMR1
   80EB                     145 L80EB:
   80EB DC 1B         [ 4]  146         ldd     CDTIMR1
   80ED 27 0B         [ 3]  147         beq     L80FA
   80EF BD F9 45      [ 6]  148         jsr     (0xF945)
   80F2 24 F7         [ 3]  149         bcc     L80EB
   80F4 81 44         [ 2]  150         cmpa    #0x44
   80F6 26 F3         [ 3]  151         bne     L80EB
   80F8 20 05         [ 3]  152         bra     L80FF
   80FA                     153 L80FA:
   80FA BD 9F 1E      [ 6]  154         jsr     (0x9F1E)
   80FD 25 1A         [ 3]  155         bcs     LOCKUP          ; bye bye
   80FF                     156 L80FF:
   80FF BD 9E AF      [ 6]  157         jsr     (0x9EAF)        ; reset L counts
   8102 BD 9E 92      [ 6]  158         jsr     (0x9E92)        ; reset R counts
   8105                     159 L8105:
   8105 86 39         [ 2]  160         ldaa    #0x39
   8107 B7 04 08      [ 4]  161         staa    (0x0408)
   810A BD A1 D5      [ 6]  162         jsr     (0xA1D5)
   810D BD AB 17      [ 6]  163         jsr     (0xAB17)
   8110 B6 F7 C0      [ 4]  164         ldaa    (0xF7C0)        ; a 00
   8113 B7 04 5C      [ 4]  165         staa    (0x045C)        ; ??? NVRAM
   8116 7E F8 00      [ 3]  166         jmp     RESET           ; reset!
                            167 
   8119 7E 81 19      [ 3]  168 LOCKUP: jmp     LOCKUP          ; infinite loop
                            169 
   811C                     170 L811C:
   811C 7F 00 79      [ 6]  171         clr     (0x0079)
   811F 7F 00 7C      [ 6]  172         clr     (0x007C)
   8122 BD 04 08      [ 6]  173         jsr     (0x0408)        ; ????
   8125 BD 80 13      [ 6]  174         jsr     (0x8013)
   8128 C6 FD         [ 2]  175         ldab    #0xFD
   812A BD 86 E7      [ 6]  176         jsr     (0x86E7)
   812D C6 DF         [ 2]  177         ldab    #0xDF
   812F BD 87 48      [ 6]  178         jsr     (0x8748)
   8132 BD 87 91      [ 6]  179         jsr     (0x8791)
   8135 BD 9A F7      [ 6]  180         jsr     (0x9AF7)
   8138 BD 9C 51      [ 6]  181         jsr     (0x9C51)
   813B 7F 00 62      [ 6]  182         clr     (0x0062)
   813E BD 99 D9      [ 6]  183         jsr     (0x99D9)
   8141 24 16         [ 3]  184         bcc     L8159
                            185 
   8143 BD 8D E4      [ 6]  186         jsr     (0x8DE4)
   8146 49 6E 76 61 6C 69   187         .ascis  'Invalid CPU!'
        64 20 43 50 55 A1
                            188 
   8152 86 53         [ 2]  189         ldaa    #0x53
   8154 7E 82 A4      [ 3]  190         jmp     (0x82A4)
   8157 20 FE         [ 3]  191 L8157:  bra     L8157           ; infinite loop
                            192 
   8159                     193 L8159:
   8159 BD A3 54      [ 6]  194         jsr     (0xA354)
   815C 7F 00 AA      [ 6]  195         clr     (0x00AA)
   815F 7D 00 00      [ 6]  196         tst     (0x0000)
   8162 27 15         [ 3]  197         beq     L8179
                            198 
   8164 BD 8D E4      [ 6]  199         jsr     (0x8DE4)
   8167 52 41 4D 20 74 65   200         .ascis  'RAM test failed!'
        73 74 20 66 61 69
        6C 65 64 A1
                            201 
   8177 20 44         [ 3]  202         bra     L81BD
                            203 
   8179                     204 L8179:
   8179 BD 8D E4      [ 6]  205         jsr     (0x8DE4)
   817C 33 32 4B 20 52 41   206         .ascis  '32K RAM OK'
        4D 20 4F CB
                            207 
                            208 ; R12 or CNR mode???
   8186 7D 04 5C      [ 6]  209         tst     (0x045C)        ; if this location is 0, good
   8189 26 08         [ 3]  210         bne     L8193
   818B CC 52 0F      [ 3]  211         ldd     #0x520F         ; else print 'R' on the far left of the first line
   818E BD 8D B5      [ 6]  212         jsr     (0x8DB5)        ; display char here on LCD display
   8191 20 06         [ 3]  213         bra     L8199
   8193                     214 L8193:
   8193 CC 43 0F      [ 3]  215         ldd     #0x430F         ; print 'C' on the far left of the first line
   8196 BD 8D B5      [ 6]  216         jsr     (0x8DB5)        ; display char here on LCD display
                            217 
   8199                     218 L8199:
   8199 BD 8D DD      [ 6]  219         jsr     (0x8DDD)
   819C 52 4F 4D 20 43 68   220         .ascis  'ROM Chksum='
        6B 73 75 6D BD
                            221 
   81A7 BD 97 5F      [ 6]  222         jsr     (0x975F)        ; print the checksum on the LCD
                            223 
   81AA C6 02         [ 2]  224         ldab    #0x02           ; delay 2 secs
   81AC BD 8C 02      [ 6]  225         jsr     (0x8C02)        ;
                            226 
   81AF BD 9A 27      [ 6]  227         jsr     (0x9A27)        ; display Serial #
   81B2 BD 9E CC      [ 6]  228         jsr     (0x9ECC)        ; display R and L counts?
   81B5 BD 9B 19      [ 6]  229         jsr     (0x9B19)        ; do the random tasks???
                            230 
   81B8 C6 02         [ 2]  231         ldab    #0x02           ; delay 2 secs
   81BA BD 8C 02      [ 6]  232         jsr     (0x8C02)        ;
                            233 
   81BD                     234 L81BD:
   81BD F6 10 2D      [ 4]  235         ldab    SCCR2           ; disable receive data interrupts
   81C0 C4 DF         [ 2]  236         andb    #0xDF
   81C2 F7 10 2D      [ 4]  237         stab    SCCR2  
                            238 
   81C5 BD 9A F7      [ 6]  239         jsr     (0x9AF7)        ; clear a bunch of ram
   81C8 C6 FD         [ 2]  240         ldab    #0xFD
   81CA BD 86 E7      [ 6]  241         jsr     (0x86E7)
   81CD BD 87 91      [ 6]  242         jsr     (0x8791)
                            243 
   81D0 C6 00         [ 2]  244         ldab    #0x00
   81D2 D7 62         [ 3]  245         stab    (0x0062)
                            246 
   81D4 BD F9 C5      [ 6]  247         jsr     (0xF9C5)
                            248 
   81D7 BD 8D E4      [ 6]  249         jsr     (0x8DE4)
   81DA 20 43 79 62 65 72   250         .ascis  ' Cyberstar v1.6'
        73 74 61 72 20 76
        31 2E B6
                            251 
                            252 
   81E9 BD A2 DF      [ 6]  253         jsr     (0xA2DF)
   81EC 24 11         [ 3]  254         bcc     L81FF
   81EE CC 52 0F      [ 3]  255         ldd     #0x520F
   81F1 BD 8D B5      [ 6]  256         jsr     (0x8DB5)        ; display 'R' at far right of 1st line
   81F4 7D 04 2A      [ 6]  257         tst     (0x042A)
   81F7 27 06         [ 3]  258         beq     L81FF
   81F9 CC 4B 0F      [ 3]  259         ldd     #0x4B0F
   81FC BD 8D B5      [ 6]  260         jsr     (0x8DB5)        ; display 'K' at far right of 1st line
   81FF                     261 L81FF:
   81FF BD 8D 03      [ 6]  262         jsr     (0x8D03)
   8202 FC 02 9C      [ 5]  263         ldd     (0x029C)
   8205 1A 83 00 01   [ 5]  264         cpd     #0x0001
   8209 26 15         [ 3]  265         bne     L8220
                            266 
   820B BD 8D DD      [ 6]  267         jsr     (0x8DDD)
   820E 20 44 61 76 65 27   268         .ascis  " Dave's system  "
        73 20 73 79 73 74
        65 6D 20 A0
                            269 
   821E 20 47         [ 3]  270         bra     L8267
   8220                     271 L8220:
   8220 1A 83 03 E8   [ 5]  272         cpd     #0x03E8
   8224 2D 1B         [ 3]  273         blt     L8241
   8226 1A 83 04 4B   [ 5]  274         cpd     #0x044B
   822A 22 15         [ 3]  275         bhi     L8241
                            276 
   822C BD 8D DD      [ 6]  277         jsr     (0x8DDD)
   822F 20 20 20 53 50 54   278         .ascis  '   SPT Studio   '
        20 53 74 75 64 69
        6F 20 20 A0
                            279 
   823F 20 26         [ 3]  280         bra L8267
                            281 
   8241                     282 L8241:
   8241 CC 0E 0C      [ 3]  283         ldd     #0x0E0C
   8244 DD AD         [ 4]  284         std     (0x00AD)
   8246 FC 04 0D      [ 5]  285         ldd     (0x040D)
   8249 1A 83 02 58   [ 5]  286         cpd     #0x0258
   824D 22 05         [ 3]  287         bhi     L8254
   824F CC 0E 09      [ 3]  288         ldd     #0x0E09
   8252 DD AD         [ 4]  289         std     (0x00AD)
   8254                     290 L8254:
   8254 C6 29         [ 2]  291         ldab    #0x29
   8256 CE 0E 00      [ 3]  292         ldx     #0x0E00
   8259                     293 L8259:
   8259 A6 00         [ 4]  294         ldaa    0,X
   825B 4A            [ 2]  295         deca
   825C 08            [ 3]  296         inx
   825D 5C            [ 2]  297         incb
   825E 3C            [ 4]  298         pshx
   825F BD 8D B5      [ 6]  299         jsr     (0x8DB5)        ; display char here on LCD display
   8262 38            [ 5]  300         pulx
   8263 9C AD         [ 5]  301         cpx     (0x00AD)
   8265 26 F2         [ 3]  302         bne     L8259
   8267                     303 L8267:
   8267 BD 9C 51      [ 6]  304         jsr     (0x9C51)
   826A 7F 00 5B      [ 6]  305         clr     (0x005B)
   826D 7F 00 5A      [ 6]  306         clr     (0x005A)
   8270 7F 00 5E      [ 6]  307         clr     (0x005E)
   8273 7F 00 60      [ 6]  308         clr     (0x0060)
   8276 BD 9B 19      [ 6]  309         jsr     (0x9B19)
   8279 96 60         [ 3]  310         ldaa    (0x0060)
   827B 27 06         [ 3]  311         beq     L8283
   827D BD A9 7C      [ 6]  312         jsr     (0xA97C)
   8280 7E F8 00      [ 3]  313         jmp     RESET       ; reset controller
   8283                     314 L8283:
   8283 B6 18 04      [ 4]  315         ldaa    (0x1804)
   8286 84 06         [ 2]  316         anda    #0x06
   8288 26 08         [ 3]  317         bne     L8292
   828A BD 9C F1      [ 6]  318         jsr     (0x9CF1)    ; print credits
   828D C6 32         [ 2]  319         ldab    #0x32
   828F BD 8C 22      [ 6]  320         jsr     (0x8C22)
   8292                     321 L8292:
   8292 BD 8E 95      [ 6]  322         jsr     (0x8E95)
   8295 81 0D         [ 2]  323         cmpa    #0x0D
   8297 26 03         [ 3]  324         bne     L829C
   8299 7E 92 92      [ 3]  325         jmp     (0x9292)
   829C                     326 L829C:
   829C BD F9 45      [ 6]  327         jsr     (0xF945)
   829F 25 03         [ 3]  328         bcs     L82A4
   82A1                     329 L82A1:
   82A1 7E 83 33      [ 3]  330         jmp     L8333
   82A4                     331 L82A4:
   82A4 81 44         [ 2]  332         cmpa    #0x44       ;'$'
   82A6 26 03         [ 3]  333         bne     L82AB
   82A8 7E A3 66      [ 3]  334         jmp     (0xA366)
   82AB                     335 L82AB:
   82AB 81 53         [ 2]  336         cmpa    #0x53       ;'S'
   82AD 26 F2         [ 3]  337         bne     L82A1
                            338 
   82AF BD F9 D8      [ 6]  339         jsr     (0xF9D8)
   82B2 0A 0D 45 6E 74 65   340         .ascis  '\n\rEnter security code: '
        72 20 73 65 63 75
        72 69 74 79 20 63
        6F 64 65 3A A0
                            341 
   82C9 0F            [ 2]  342         sei
   82CA BD A2 EA      [ 6]  343         jsr     (0xA2EA)
   82CD 0E            [ 2]  344         cli
   82CE 25 61         [ 3]  345         bcs     L8331
                            346 
   82D0 BD F9 D8      [ 6]  347         jsr     (0xF9D8)
   82D3 0A 0D 45 45 50 52   348         .ascii '\n\rEEPROM serial number programming enabled.'
        4F 4D 20 73 65 72
        69 61 6C 20 6E 75
        6D 62 65 72 20 70
        72 6F 67 72 61 6D
        6D 69 6E 67 20 65
        6E 61 62 6C 65 64
        2E
   82FE 0A 0D 50 6C 65 61   349         .ascis '\n\rPlease RESET the processor to continue\n\r'
        73 65 20 52 45 53
        45 54 20 74 68 65
        20 70 72 6F 63 65
        73 73 6F 72 20 74
        6F 20 63 6F 6E 74
        69 6E 75 65 0A 8D
                            350 
   8328 86 01         [ 2]  351         ldaa    #0x01       ; enable EEPROM erase
   832A B7 04 0F      [ 4]  352         staa    ERASEFLG
   832D 86 DB         [ 2]  353         ldaa    #0xDB
   832F 97 07         [ 3]  354         staa    (0x0007)
                            355 ; need to reset to get out of this 
   8331 20 FE         [ 3]  356 L8331:  bra     L8331       ; infinite loop
                            357 
   8333                     358 L8333:
   8333 96 AA         [ 3]  359         ldaa    (0x00AA)
   8335 27 12         [ 3]  360         beq     L8349
   8337 DC 1B         [ 4]  361         ldd     CDTIMR1
   8339 26 0E         [ 3]  362         bne     L8349
   833B D6 62         [ 3]  363         ldab    (0x0062)
   833D C8 20         [ 2]  364         eorb    #0x20
   833F D7 62         [ 3]  365         stab    (0x0062)
   8341 BD F9 C5      [ 6]  366         jsr     (0xF9C5)
   8344 CC 00 32      [ 3]  367         ldd     #0x0032
   8347 DD 1B         [ 4]  368         std     CDTIMR1
   8349                     369 L8349:
   8349 BD 86 A4      [ 6]  370         jsr     (0x86A4)
   834C 24 03         [ 3]  371         bcc L8351
   834E 7E 82 76      [ 3]  372         jmp     (0x8276)
   8351                     373 L8351:
   8351 F6 10 2D      [ 4]  374         ldab    SCCR2  
   8354 CA 20         [ 2]  375         orab    #0x20
   8356 F7 10 2D      [ 4]  376         stab    SCCR2  
   8359 7F 00 AA      [ 6]  377         clr     (0x00AA)
   835C D6 62         [ 3]  378         ldab    (0x0062)
   835E C4 DF         [ 2]  379         andb    #0xDF
   8360 D7 62         [ 3]  380         stab    (0x0062)
   8362 BD F9 C5      [ 6]  381         jsr     (0xF9C5)
   8365 C6 02         [ 2]  382         ldab    #0x02           ; delay 2 secs
   8367 BD 8C 02      [ 6]  383         jsr     (0x8C02)        ;
   836A 96 7C         [ 3]  384         ldaa    (0x007C)
   836C 27 2D         [ 3]  385         beq     L839B
   836E 96 7F         [ 3]  386         ldaa    (0x007F)
   8370 97 4E         [ 3]  387         staa    (0x004E)
   8372 D6 81         [ 3]  388         ldab    (0x0081)
   8374 BD 87 48      [ 6]  389         jsr     (0x8748)
   8377 96 82         [ 3]  390         ldaa    (0x0082)
   8379 85 01         [ 2]  391         bita    #0x01
   837B 26 06         [ 3]  392         bne     L8383
   837D 96 AC         [ 3]  393         ldaa    (0x00AC)
   837F 84 FD         [ 2]  394         anda    #0xFD
   8381 20 04         [ 3]  395         bra     L8387
   8383                     396 L8383:
   8383 96 AC         [ 3]  397         ldaa    (0x00AC)
   8385 8A 02         [ 2]  398         oraa    #0x02
   8387                     399 L8387:
   8387 97 AC         [ 3]  400         staa    (0x00AC)
   8389 B7 18 06      [ 4]  401         staa    (0x1806)
   838C B6 18 04      [ 4]  402         ldaa    (0x1804)
   838F 8A 20         [ 2]  403         oraa    #0x20
   8391 B7 18 04      [ 4]  404         staa    (0x1804)
   8394 84 DF         [ 2]  405         anda    #0xDF
   8396 B7 18 04      [ 4]  406         staa    (0x1804)
   8399 20 14         [ 3]  407         bra     L83AF
   839B                     408 L839B:
   839B FC 04 0D      [ 5]  409         ldd     (0x040D)
   839E 1A 83 FD E8   [ 5]  410         cpd     #0xFDE8
   83A2 22 06         [ 3]  411         bhi     L83AA
   83A4 C3 00 01      [ 4]  412         addd    #0x0001
   83A7 FD 04 0D      [ 5]  413         std     (0x040D)
   83AA                     414 L83AA:
   83AA C6 F7         [ 2]  415         ldab    #0xF7
   83AC BD 86 E7      [ 6]  416         jsr     (0x86E7)
   83AF                     417 L83AF:
   83AF 7F 00 30      [ 6]  418         clr     (0x0030)
   83B2 7F 00 31      [ 6]  419         clr     (0x0031)
   83B5 7F 00 32      [ 6]  420         clr     (0x0032)
   83B8 BD 9B 19      [ 6]  421         jsr     (0x9B19)
   83BB BD 86 A4      [ 6]  422         jsr     (0x86A4)
   83BE 25 EF         [ 3]  423         bcs     L83AF
   83C0 96 79         [ 3]  424         ldaa    (0x0079)
   83C2 27 17         [ 3]  425         beq     L83DB
   83C4 7F 00 79      [ 6]  426         clr     (0x0079)
   83C7 96 B5         [ 3]  427         ldaa    (0x00B5)
   83C9 81 01         [ 2]  428         cmpa    #0x01
   83CB 26 07         [ 3]  429         bne     L83D4
   83CD 7F 00 B5      [ 6]  430         clr     (0x00B5)
   83D0 86 01         [ 2]  431         ldaa    #0x01
   83D2 97 7C         [ 3]  432         staa    (0x007C)
   83D4                     433 L83D4:
   83D4 86 01         [ 2]  434         ldaa    #0x01
   83D6 97 AA         [ 3]  435         staa    (0x00AA)
   83D8 7E 9A 7F      [ 3]  436         jmp     (0x9A7F)
   83DB                     437 L83DB:
   83DB BD 8D E4      [ 6]  438         jsr (0x8DE4)
   83DE 20 20 20 54 61 70   439         .ascis  '   Tape start   '
        65 20 73 74 61 72
        74 20 20 A0
                            440 
   83EE D6 62         [ 3]  441         ldab    (0x0062)
   83F0 CA 80         [ 2]  442         orab    #0x80
   83F2 D7 62         [ 3]  443         stab    (0x0062)
   83F4 BD F9 C5      [ 6]  444         jsr     (0xF9C5)
   83F7 C6 FB         [ 2]  445         ldab    #0xFB
   83F9 BD 86 E7      [ 6]  446         jsr     (0x86E7)
                            447 
   83FC BD 8D CF      [ 6]  448         jsr     (0x8DCF)
   83FF 36 38 48 43 31 31   449         .ascis  '68HC11 Proto'
        20 50 72 6F 74 EF
                            450 
   840B BD 8D D6      [ 6]  451         jsr     (0x8DD6)
   840E 64 62 F0            452         .ascis  'dbp'
                            453 
   8411 C6 03         [ 2]  454         ldab    #0x03           ; delay 3 secs
   8413 BD 8C 02      [ 6]  455         jsr     (0x8C02)        ;
   8416 7D 00 7C      [ 6]  456         tst     (0x007C)
   8419 27 15         [ 3]  457         beq     L8430
   841B D6 80         [ 3]  458         ldab    (0x0080)
   841D D7 62         [ 3]  459         stab    (0x0062)
   841F BD F9 C5      [ 6]  460         jsr     (0xF9C5)
   8422 D6 7D         [ 3]  461         ldab    (0x007D)
   8424 D7 78         [ 3]  462         stab    (0x0078)
   8426 D6 7E         [ 3]  463         ldab    (0x007E)
   8428 F7 10 8A      [ 4]  464         stab    (0x108A)
   842B 7F 00 7C      [ 6]  465         clr     (0x007C)
   842E 20 1D         [ 3]  466         bra     L844D
   8430                     467 L8430:
   8430 BD 8D 03      [ 6]  468         jsr     (0x8D03)
   8433 BD 9D 18      [ 6]  469         jsr     (0x9D18)
   8436 24 08         [ 3]  470         bcc     L8440
   8438 7D 00 B8      [ 6]  471         tst     (0x00B8)
   843B 27 F3         [ 3]  472         beq     L8430
   843D 7E 9A 60      [ 3]  473         jmp     (0x9A60)
   8440                     474 L8440:
   8440 7D 00 B8      [ 6]  475         tst     (0x00B8)
   8443 27 EB         [ 3]  476         beq     L8430
   8445 7F 00 30      [ 6]  477         clr     (0x0030)
   8448 7F 00 31      [ 6]  478         clr     (0x0031)
   844B 20 00         [ 3]  479         bra     L844D
   844D                     480 L844D:
   844D 96 49         [ 3]  481         ldaa    (0x0049)
   844F 26 03         [ 3]  482         bne     L8454
   8451 7E 85 A4      [ 3]  483         jmp     (0x85A4)
   8454                     484 L8454:
   8454 7F 00 49      [ 6]  485         clr     (0x0049)
   8457 81 31         [ 2]  486         cmpa    #0x31
   8459 26 08         [ 3]  487         bne     L8463
   845B BD A3 26      [ 6]  488         jsr     (0xA326)
   845E BD 8D 42      [ 6]  489         jsr     (0x8D42)
   8461 20 EA         [ 3]  490         bra     L844D
   8463                     491 L8463:
   8463 81 32         [ 2]  492         cmpa    #0x32
   8465 26 08         [ 3]  493         bne     L846F
   8467 BD A3 26      [ 6]  494         jsr     (0xA326)
   846A BD 8D 35      [ 6]  495         jsr     (0x8D35)
   846D 20 DE         [ 3]  496         bra     L844D
   846F                     497 L846F:
   846F 81 54         [ 2]  498         cmpa    #0x54
   8471 26 08         [ 3]  499         bne     L847B
   8473 BD A3 26      [ 6]  500         jsr     (0xA326)
   8476 BD 8D 42      [ 6]  501         jsr     (0x8D42)
   8479 20 D2         [ 3]  502         bra     L844D
   847B                     503 L847B:
   847B 81 5A         [ 2]  504         cmpa    #0x5A
   847D 26 1C         [ 3]  505         bne     L849B
   847F BD A3 1E      [ 6]  506         jsr     (0xA31E)
   8482 BD 8E 95      [ 6]  507         jsr     (0x8E95)
   8485 7F 00 32      [ 6]  508         clr     (0x0032)
   8488 7F 00 31      [ 6]  509         clr     (0x0031)
   848B 7F 00 30      [ 6]  510         clr     (0x0030)
   848E BD 99 A6      [ 6]  511         jsr     L99A6
   8491 D6 7B         [ 3]  512         ldab    (0x007B)
   8493 CA 0C         [ 2]  513         orab    #0x0C
   8495 BD 87 48      [ 6]  514         jsr     (0x8748)
   8498 7E 81 BD      [ 3]  515         jmp     L81BD
   849B                     516 L849B:
   849B 81 42         [ 2]  517         cmpa    #0x42
   849D 26 03         [ 3]  518         bne     L84A2
   849F 7E 98 3C      [ 3]  519         jmp     (0x983C)
   84A2                     520 L84A2:
   84A2 81 4D         [ 2]  521         cmpa    #0x4D
   84A4 26 03         [ 3]  522         bne     L84A9
   84A6 7E 98 24      [ 3]  523         jmp     (0x9824)
   84A9                     524 L84A9:
   84A9 81 45         [ 2]  525         cmpa    #0x45
   84AB 26 03         [ 3]  526         bne     L84B0
   84AD 7E 98 02      [ 3]  527         jmp     (0x9802)
   84B0                     528 L84B0:
   84B0 81 58         [ 2]  529         cmpa    #0x58
   84B2 26 05         [ 3]  530         bne     L84B9
   84B4 7E 99 3F      [ 3]  531         jmp     (0x993F)
   84B7 20 94         [ 3]  532         bra     L844D
   84B9                     533 L84B9:
   84B9 81 46         [ 2]  534         cmpa    #0x46
   84BB 26 03         [ 3]  535         bne     L84C0
   84BD 7E 99 71      [ 3]  536         jmp     (0x9971)
   84C0                     537 L84C0:
   84C0 81 47         [ 2]  538         cmpa    #0x47
   84C2 26 03         [ 3]  539         bne     L84C7
   84C4 7E 99 7B      [ 3]  540         jmp     (0x997B)
   84C7                     541 L84C7:
   84C7 81 48         [ 2]  542         cmpa    #0x48
   84C9 26 03         [ 3]  543         bne     L84CE
   84CB 7E 99 85      [ 3]  544         jmp     (0x9985)
   84CE                     545 L84CE:
   84CE 81 49         [ 2]  546         cmpa    #0x49
   84D0 26 03         [ 3]  547         bne     L84D5
   84D2 7E 99 8F      [ 3]  548         jmp     (0x998F)
   84D5                     549 L84D5:
   84D5 81 53         [ 2]  550         cmpa    #0x53
   84D7 26 03         [ 3]  551         bne     L84DC
   84D9 7E 97 BA      [ 3]  552         jmp     (0x97BA)
   84DC                     553 L84DC:
   84DC 81 59         [ 2]  554         cmpa    #0x59
   84DE 26 03         [ 3]  555         bne     L84E3
   84E0 7E 99 D2      [ 3]  556         jmp     (0x99D2)
   84E3                     557 L84E3:
   84E3 81 57         [ 2]  558         cmpa    #0x57
   84E5 26 03         [ 3]  559         bne     L84EA
   84E7 7E 9A A4      [ 3]  560         jmp     (0x9AA4)
   84EA                     561 L84EA:
   84EA 81 41         [ 2]  562         cmpa    #0x41
   84EC 26 17         [ 3]  563         bne     L8505
   84EE BD 9D 18      [ 6]  564         jsr     (0x9D18)
   84F1 25 09         [ 3]  565         bcs     L84FC
   84F3 7F 00 30      [ 6]  566         clr     (0x0030)
   84F6 7F 00 31      [ 6]  567         clr     (0x0031)
   84F9 7E 85 A4      [ 3]  568         jmp     (0x85A4)
   84FC                     569 L84FC:
   84FC 7F 00 30      [ 6]  570         clr     (0x0030)
   84FF 7F 00 31      [ 6]  571         clr     (0x0031)
   8502 7E 9A 7F      [ 3]  572         jmp     (0x9A7F)
   8505                     573 L8505:
   8505 81 4B         [ 2]  574         cmpa    #0x4B
   8507 26 0B         [ 3]  575         bne     L8514
   8509 BD 9D 18      [ 6]  576         jsr     (0x9D18)
   850C 25 03         [ 3]  577         bcs     L8511
   850E 7E 85 A4      [ 3]  578         jmp     (0x85A4)
   8511                     579 L8511:
   8511 7E 9A 7F      [ 3]  580         jmp     (0x9A7F)
   8514                     581 L8514:
   8514 81 4A         [ 2]  582         cmpa    #0x4A
   8516 26 07         [ 3]  583         bne     L851F
   8518 86 01         [ 2]  584         ldaa    #0x01
   851A 97 AF         [ 3]  585         staa    (0x00AF)
   851C 7E 98 3C      [ 3]  586         jmp     (0x983C)
   851F                     587 L851F:
   851F 81 4E         [ 2]  588         cmpa    #0x4E
   8521 26 0B         [ 3]  589         bne     L852E
   8523 B6 10 8A      [ 4]  590         ldaa    (0x108A)
   8526 8A 02         [ 2]  591         oraa    #0x02
   8528 B7 10 8A      [ 4]  592         staa    (0x108A)
   852B 7E 84 4D      [ 3]  593         jmp     (0x844D)
   852E                     594 L852E:
   852E 81 4F         [ 2]  595         cmpa    #0x4F
   8530 26 06         [ 3]  596         bne     L8538
   8532 BD 9D 18      [ 6]  597         jsr     (0x9D18)
   8535 7E 84 4D      [ 3]  598         jmp     (0x844D)
   8538                     599 L8538:
   8538 81 50         [ 2]  600         cmpa    #0x50
   853A 26 06         [ 3]  601         bne     L8542
   853C BD 9D 18      [ 6]  602         jsr     (0x9D18)
   853F 7E 84 4D      [ 3]  603         jmp     (0x844D)
   8542                     604 L8542:
   8542 81 51         [ 2]  605         cmpa    #0x51
   8544 26 0B         [ 3]  606         bne     L8551
   8546 B6 10 8A      [ 4]  607         ldaa    (0x108A)
   8549 8A 04         [ 2]  608         oraa    #0x04
   854B B7 10 8A      [ 4]  609         staa    (0x108A)
   854E 7E 84 4D      [ 3]  610         jmp     (0x844D)
   8551                     611 L8551:
   8551 81 55         [ 2]  612         cmpa    #0x55
   8553 26 07         [ 3]  613         bne     L855C
   8555 C6 01         [ 2]  614         ldab    #0x01
   8557 D7 B6         [ 3]  615         stab    (0x00B6)
   8559 7E 84 4D      [ 3]  616         jmp     (0x844D)
   855C                     617 L855C:
   855C 81 4C         [ 2]  618         cmpa    #0x4C
   855E 26 19         [ 3]  619         bne     L8579
   8560 7F 00 49      [ 6]  620         clr     (0x0049)
   8563 BD 9D 18      [ 6]  621         jsr     (0x9D18)
   8566 25 0E         [ 3]  622         bcs     L8576
   8568 BD AA E8      [ 6]  623         jsr     (0xAAE8)
   856B BD AB 56      [ 6]  624         jsr     (0xAB56)
   856E 24 06         [ 3]  625         bcc     L8576
   8570 BD AB 25      [ 6]  626         jsr     (0xAB25)
   8573 BD AB 46      [ 6]  627         jsr     (0xAB46)
   8576                     628 L8576:
   8576 7E 84 4D      [ 3]  629         jmp     (0x844D)
   8579                     630 L8579:
   8579 81 52         [ 2]  631         cmpa    #0x52
   857B 26 1A         [ 3]  632         bne     L8597
   857D 7F 00 49      [ 6]  633         clr     (0x0049)
   8580 BD 9D 18      [ 6]  634         jsr     (0x9D18)
   8583 25 0F         [ 3]  635         bcs     L8594
   8585 BD AA E8      [ 6]  636         jsr     (0xAAE8)
   8588 BD AB 56      [ 6]  637         jsr     (0xAB56)
   858B 25 07         [ 3]  638         bcs     L8594
   858D 86 FF         [ 2]  639         ldaa    #0xFF
   858F A7 00         [ 4]  640         staa    0,X
   8591 BD AA E8      [ 6]  641         jsr     (0xAAE8)
   8594                     642 L8594:
   8594 7E 84 4D      [ 3]  643         jmp     (0x844D)
   8597                     644 L8597:
   8597 81 44         [ 2]  645         cmpa    #0x44
   8599 26 09         [ 3]  646         bne     L85A4
   859B 7F 00 49      [ 6]  647         clr     (0x0049)
   859E BD AB AE      [ 6]  648         jsr     (0xABAE)
   85A1 7E 84 4D      [ 3]  649         jmp     L844D
   85A4                     650 L85A4:
   85A4 7D 00 75      [ 6]  651         tst     (0x0075)
   85A7 26 56         [ 3]  652         bne     L85FF
   85A9 7D 00 79      [ 6]  653         tst     (0x0079)
   85AC 26 51         [ 3]  654         bne     L85FF
   85AE 7D 00 30      [ 6]  655         tst     (0x0030)
   85B1 26 07         [ 3]  656         bne     L85BA
   85B3 96 5B         [ 3]  657         ldaa    (0x005B)
   85B5 27 48         [ 3]  658         beq     L85FF
   85B7 7F 00 5B      [ 6]  659         clr     (0x005B)
   85BA                     660 L85BA:
   85BA CC 00 64      [ 3]  661         ldd     #0x0064
   85BD DD 23         [ 4]  662         std     CDTIMR5
   85BF                     663 L85BF:
   85BF DC 23         [ 4]  664         ldd     CDTIMR5
   85C1 27 14         [ 3]  665         beq     L85D7
   85C3 BD 9B 19      [ 6]  666         jsr     (0x9B19)
   85C6 B6 18 04      [ 4]  667         ldaa    (0x1804)
   85C9 88 FF         [ 2]  668         eora    #0xFF
   85CB 84 06         [ 2]  669         anda    #0x06
   85CD 81 06         [ 2]  670         cmpa    #0x06
   85CF 26 EE         [ 3]  671         bne     L85BF
   85D1 7F 00 30      [ 6]  672         clr     (0x0030)
   85D4 7E 86 80      [ 3]  673         jmp     (0x8680)
   85D7                     674 L85D7:
   85D7 7F 00 30      [ 6]  675         clr     (0x0030)
   85DA D6 62         [ 3]  676         ldab    (0x0062)
   85DC C8 02         [ 2]  677         eorb    #0x02
   85DE D7 62         [ 3]  678         stab    (0x0062)
   85E0 BD F9 C5      [ 6]  679         jsr     (0xF9C5)
   85E3 C4 02         [ 2]  680         andb    #0x02
   85E5 27 0D         [ 3]  681         beq     L85F4
   85E7 BD AA 18      [ 6]  682         jsr     (0xAA18)
   85EA C6 1E         [ 2]  683         ldab    #0x1E
   85EC BD 8C 22      [ 6]  684         jsr     (0x8C22)
   85EF 7F 00 30      [ 6]  685         clr     (0x0030)
   85F2 20 0B         [ 3]  686         bra     L85FF
   85F4                     687 L85F4:
   85F4 BD AA 1D      [ 6]  688         jsr     (0xAA1D)
   85F7 C6 1E         [ 2]  689         ldab    #0x1E
   85F9 BD 8C 22      [ 6]  690         jsr     (0x8C22)
   85FC 7F 00 30      [ 6]  691         clr     (0x0030)
   85FF                     692 L85FF:
   85FF BD 9B 19      [ 6]  693         jsr     (0x9B19)
   8602 B6 10 0A      [ 4]  694         ldaa    PORTE
   8605 84 10         [ 2]  695         anda    #0x10
   8607 27 0B         [ 3]  696         beq     L8614
   8609 B6 18 04      [ 4]  697         ldaa    (0x1804)
   860C 88 FF         [ 2]  698         eora    #0xFF
   860E 84 07         [ 2]  699         anda    #0x07
   8610 81 06         [ 2]  700         cmpa    #0x06
   8612 26 1C         [ 3]  701         bne     L8630
   8614                     702 L8614:
   8614 7D 00 76      [ 6]  703         tst     (0x0076)
   8617 26 17         [ 3]  704         bne     L8630
   8619 7D 00 75      [ 6]  705         tst     (0x0075)
   861C 26 12         [ 3]  706         bne     L8630
   861E D6 62         [ 3]  707         ldab    (0x0062)
   8620 C4 FC         [ 2]  708         andb    #0xFC
   8622 D7 62         [ 3]  709         stab    (0x0062)
   8624 BD F9 C5      [ 6]  710         jsr     (0xF9C5)
   8627 BD AA 13      [ 6]  711         jsr     (0xAA13)
   862A BD AA 1D      [ 6]  712         jsr     (0xAA1D)
   862D 7E 9A 60      [ 3]  713         jmp     (0x9A60)
   8630                     714 L8630:
   8630 7D 00 31      [ 6]  715         tst     (0x0031)
   8633 26 07         [ 3]  716         bne     L863C
   8635 96 5A         [ 3]  717         ldaa    (0x005A)
   8637 27 47         [ 3]  718         beq     L8680
   8639 7F 00 5A      [ 6]  719         clr     (0x005A)
   863C                     720 L863C:
   863C CC 00 64      [ 3]  721         ldd     #0x0064
   863F DD 23         [ 4]  722         std     CDTIMR5
   8641                     723 L8641:
   8641 DC 23         [ 4]  724         ldd     CDTIMR5
   8643 27 13         [ 3]  725         beq     L8658
   8645 BD 9B 19      [ 6]  726         jsr     (0x9B19)
   8648 B6 18 04      [ 4]  727         ldaa    (0x1804)
   864B 88 FF         [ 2]  728         eora    #0xFF
   864D 84 06         [ 2]  729         anda    #0x06
   864F 81 06         [ 2]  730         cmpa    #0x06
   8651 26 EE         [ 3]  731         bne     L8641
   8653 7F 00 31      [ 6]  732         clr     (0x0031)
   8656 20 28         [ 3]  733         bra     L8680
   8658                     734 L8658:
   8658 7F 00 31      [ 6]  735         clr     (0x0031)
   865B D6 62         [ 3]  736         ldab    (0x0062)
   865D C8 01         [ 2]  737         eorb    #0x01
   865F D7 62         [ 3]  738         stab    (0x0062)
   8661 BD F9 C5      [ 6]  739         jsr     (0xF9C5)
   8664 C4 01         [ 2]  740         andb    #0x01
   8666 27 0D         [ 3]  741         beq     L8675
   8668 BD AA 0C      [ 6]  742         jsr     (0xAA0C)
   866B C6 1E         [ 2]  743         ldab    #0x1E
   866D BD 8C 22      [ 6]  744         jsr     (0x8C22)
   8670 7F 00 31      [ 6]  745         clr     (0x0031)
   8673 20 0B         [ 3]  746         bra     L8680
   8675                     747 L8675:
   8675 BD AA 13      [ 6]  748         jsr     (0xAA13)
   8678 C6 1E         [ 2]  749         ldab    #0x1E
   867A BD 8C 22      [ 6]  750         jsr     (0x8C22)
   867D 7F 00 31      [ 6]  751         clr     (0x0031)
   8680                     752 L8680:
   8680 BD 86 A4      [ 6]  753         jsr     (0x86A4)
   8683 25 1C         [ 3]  754         bcs     L86A1
   8685 7F 00 4E      [ 6]  755         clr     (0x004E)
   8688 BD 99 A6      [ 6]  756         jsr     L99A6
   868B BD 86 C4      [ 6]  757         jsr     L86C4
   868E 5F            [ 2]  758         clrb
   868F D7 62         [ 3]  759         stab    (0x0062)
   8691 BD F9 C5      [ 6]  760         jsr     (0xF9C5)
   8694 C6 FD         [ 2]  761         ldab    #0xFD
   8696 BD 86 E7      [ 6]  762         jsr     (0x86E7)
   8699 C6 04         [ 2]  763         ldab    #0x04           ; delay 4 secs
   869B BD 8C 02      [ 6]  764         jsr     (0x8C02)        ;
   869E 7E 84 7F      [ 3]  765         jmp     (0x847F)
   86A1                     766 L86A1:
   86A1 7E 84 4D      [ 3]  767         jmp     (0x844D)
   86A4 BD 9B 19      [ 6]  768         jsr     (0x9B19)
   86A7 7F 00 23      [ 6]  769         clr     CDTIMR5
   86AA 86 19         [ 2]  770         ldaa    #0x19
   86AC 97 24         [ 3]  771         staa    CDTIMR5+1
   86AE B6 10 0A      [ 4]  772         ldaa    PORTE
   86B1 84 80         [ 2]  773         anda    #0x80
   86B3 27 02         [ 3]  774         beq     L86B7
   86B5                     775 L86B5:
   86B5 0D            [ 2]  776         sec
   86B6 39            [ 5]  777         rts
                            778 
   86B7                     779 L86B7:
   86B7 B6 10 0A      [ 4]  780         ldaa    PORTE
   86BA 84 80         [ 2]  781         anda    #0x80
   86BC 26 F7         [ 3]  782         bne     L86B5
   86BE 96 24         [ 3]  783         ldaa    CDTIMR5+1
   86C0 26 F5         [ 3]  784         bne     L86B7
   86C2 0C            [ 2]  785         clc
   86C3 39            [ 5]  786         rts
                            787 
                            788 ; main1 - init boards 1-9 at:
                            789 ;         0x1080, 0x1084, 0x1088, 0x108c
                            790 ;         0x1090, 0x1094, 0x1098, 0x109c
                            791 ;         0x10a0
                            792 
   86C4                     793 L86C4:
   86C4 CE 10 80      [ 3]  794         ldx     #0x1080
   86C7                     795 L86C7:
   86C7 86 30         [ 2]  796         ldaa    #0x30
   86C9 A7 01         [ 4]  797         staa    1,X
   86CB A7 03         [ 4]  798         staa    3,X
   86CD 86 FF         [ 2]  799         ldaa    #0xFF
   86CF A7 00         [ 4]  800         staa    0,X
   86D1 A7 02         [ 4]  801         staa    2,X
   86D3 86 34         [ 2]  802         ldaa    #0x34
   86D5 A7 01         [ 4]  803         staa    1,X
   86D7 A7 03         [ 4]  804         staa    3,X
   86D9 6F 00         [ 6]  805         clr     0,X
   86DB 6F 02         [ 6]  806         clr     2,X
   86DD 08            [ 3]  807         inx
   86DE 08            [ 3]  808         inx
   86DF 08            [ 3]  809         inx
   86E0 08            [ 3]  810         inx
   86E1 8C 10 A4      [ 4]  811         cpx     #0x10A4
   86E4 2F E1         [ 3]  812         ble     L86C7
   86E6 39            [ 5]  813         rts
                            814 
                            815 ; ***
   86E7 36            [ 3]  816         psha
   86E8 BD 9B 19      [ 6]  817         jsr     (0x9B19)
   86EB 96 AC         [ 3]  818         ldaa    (0x00AC)
   86ED C1 FB         [ 2]  819         cmpb    #0xFB
   86EF 26 04         [ 3]  820         bne     L86F5
   86F1 84 FE         [ 2]  821         anda    #0xFE
   86F3 20 0E         [ 3]  822         bra     L8703
   86F5                     823 L86F5:
   86F5 C1 F7         [ 2]  824         cmpb    #0xF7
   86F7 26 04         [ 3]  825         bne     L86FD
   86F9 84 BF         [ 2]  826         anda    #0xBF
   86FB 20 06         [ 3]  827         bra     L8703
   86FD                     828 L86FD:
   86FD C1 FD         [ 2]  829         cmpb    #0xFD
   86FF 26 02         [ 3]  830         bne     L8703
   8701 84 F7         [ 2]  831         anda    #0xF7
   8703                     832 L8703:
   8703 97 AC         [ 3]  833         staa    (0x00AC)
   8705 B7 18 06      [ 4]  834         staa    (0x1806)
   8708 BD 87 3A      [ 6]  835         jsr     (0x873A)     ; clock diagnostic indicator
   870B 96 7A         [ 3]  836         ldaa    (0x007A)
   870D 84 01         [ 2]  837         anda    #0x01
   870F 97 7A         [ 3]  838         staa    (0x007A)
   8711 C4 FE         [ 2]  839         andb    #0xFE
   8713 DA 7A         [ 3]  840         orab    (0x007A)
   8715 F7 18 06      [ 4]  841         stab    (0x1806)
   8718 BD 87 75      [ 6]  842         jsr     (0x8775)
   871B C6 32         [ 2]  843         ldab    #0x32
   871D BD 8C 22      [ 6]  844         jsr     (0x8C22)
   8720 C6 FE         [ 2]  845         ldab    #0xFE
   8722 DA 7A         [ 3]  846         orab    (0x007A)
   8724 F7 18 06      [ 4]  847         stab    (0x1806)
   8727 D7 7A         [ 3]  848         stab    (0x007A)
   8729 BD 87 75      [ 6]  849         jsr     (0x8775)
   872C 96 AC         [ 3]  850         ldaa    (0x00AC)
   872E 8A 49         [ 2]  851         oraa    #0x49
   8730 97 AC         [ 3]  852         staa    (0x00AC)
   8732 B7 18 06      [ 4]  853         staa    (0x1806)
   8735 BD 87 3A      [ 6]  854         jsr     (0x873A)     ; clock diagnostic indicator
   8738 32            [ 4]  855         pula
   8739 39            [ 5]  856         rts
                            857 
                            858 ; clock diagnostic indicator
   873A B6 18 04      [ 4]  859         ldaa    (0x1804)
   873D 8A 20         [ 2]  860         oraa    #0x20
   873F B7 18 04      [ 4]  861         staa    (0x1804)
   8742 84 DF         [ 2]  862         anda    #0xDF
   8744 B7 18 04      [ 4]  863         staa    (0x1804)
   8747 39            [ 5]  864         rts
                            865 
   8748 36            [ 3]  866         psha
   8749 37            [ 3]  867         pshb
   874A 96 AC         [ 3]  868         ldaa    (0x00AC)
   874C 8A 30         [ 2]  869         oraa    #0x30
   874E 84 FD         [ 2]  870         anda    #0xFD
   8750 C5 20         [ 2]  871         bitb    #0x20
   8752 26 02         [ 3]  872         bne     L8756
   8754 8A 02         [ 2]  873         oraa    #0x02
   8756                     874 L8756:
   8756 C5 04         [ 2]  875         bitb    #0x04
   8758 26 02         [ 3]  876         bne     L875C
   875A 84 EF         [ 2]  877         anda    #0xEF
   875C                     878 L875C:
   875C C5 08         [ 2]  879         bitb    #0x08
   875E 26 02         [ 3]  880         bne     L8762
   8760 84 DF         [ 2]  881         anda    #0xDF
   8762                     882 L8762:
   8762 B7 18 06      [ 4]  883         staa    (0x1806)
   8765 97 AC         [ 3]  884         staa    (0x00AC)
   8767 BD 87 3A      [ 6]  885         jsr     (0x873A)        ; clock diagnostic indicator
   876A 33            [ 4]  886         pulb
   876B F7 18 06      [ 4]  887         stab    (0x1806)
   876E D7 7B         [ 3]  888         stab    (0x007B)
   8770 BD 87 83      [ 6]  889         jsr     (0x8783)
   8773 32            [ 4]  890         pula
   8774 39            [ 5]  891         rts
                            892 
   8775 B6 18 07      [ 4]  893         ldaa    (0x1807)
   8778 8A 38         [ 2]  894         oraa    #0x38
   877A B7 18 07      [ 4]  895         staa    (0x1807)
   877D 84 F7         [ 2]  896         anda    #0xF7
   877F B7 18 07      [ 4]  897         staa    (0x1807)
   8782 39            [ 5]  898         rts
                            899 
   8783 B6 18 05      [ 4]  900         ldaa    (0x1805)
   8786 8A 38         [ 2]  901         oraa    #0x38
   8788 B7 18 05      [ 4]  902         staa    (0x1805)
   878B 84 F7         [ 2]  903         anda    #0xF7
   878D B7 18 05      [ 4]  904         staa    (0x1805)
   8790 39            [ 5]  905         rts
                            906 
   8791 96 7A         [ 3]  907         ldaa    (0x007A)
   8793 84 FE         [ 2]  908         anda    #0xFE
   8795 36            [ 3]  909         psha
   8796 96 AC         [ 3]  910         ldaa    (0x00AC)
   8798 8A 04         [ 2]  911         oraa    #0x04
   879A 97 AC         [ 3]  912         staa    (0x00AC)
   879C 32            [ 4]  913         pula
   879D                     914 L879D:
   879D 97 7A         [ 3]  915         staa    (0x007A)
   879F B7 18 06      [ 4]  916         staa    (0x1806)
   87A2 BD 87 75      [ 6]  917         jsr     (0x8775)
   87A5 96 AC         [ 3]  918         ldaa    (0x00AC)
   87A7 B7 18 06      [ 4]  919         staa    (0x1806)
   87AA BD 87 3A      [ 6]  920         jsr     (0x873A)        ; clock diagnostic indicator
   87AD 39            [ 5]  921         rts
                            922 
   87AE 96 7A         [ 3]  923         ldaa    (0x007A)
   87B0 8A 01         [ 2]  924         oraa    #0x01
   87B2 36            [ 3]  925         psha
   87B3 96 AC         [ 3]  926         ldaa    (0x00AC)
   87B5 84 FB         [ 2]  927         anda    #0xFB
   87B7 97 AC         [ 3]  928         staa    (0x00AC)
   87B9 32            [ 4]  929         pula
   87BA 20 E1         [ 3]  930         bra     L879D
                            931 
   87BC                     932 L87BC:
   87BC CE 87 D2      [ 3]  933         ldx     #0x87D2
   87BF                     934 L87BF:
   87BF A6 00         [ 4]  935         ldaa    0,X
   87C1 81 FF         [ 2]  936         cmpa    #0xFF
   87C3 27 0C         [ 3]  937         beq     L87D1
   87C5 08            [ 3]  938         inx
   87C6 B7 18 0D      [ 4]  939         staa    (0x180D)
   87C9 A6 00         [ 4]  940         ldaa    0,X
   87CB 08            [ 3]  941         inx
   87CC B7 18 0D      [ 4]  942         staa    (0x180D)
   87CF 20 EE         [ 3]  943         bra     L87BF
   87D1                     944 L87D1:
   87D1 39            [ 5]  945         rts
                            946 
                            947 ; data table?
   87D2 09 8A               948         .byte   0x09,0x8a
   87D4 01 00               949         .byte   0x01,0x00
   87D6 0C 18               950         .byte   0x0c,0x18 
   87D8 0D 00               951         .byte   0x0d,0x00
   87DA 04 44               952         .byte   0x04,0x44
   87DC 0E 63               953         .byte   0x0e,0x63
   87DE 05 68               954         .byte   0x05,0x68
   87E0 0B 56               955         .byte   0x0b,0x56
   87E2 03 C1               956         .byte   0x03,0xc1
   87E4 0F 00               957         .byte   0x0f,0x00
   87E6 FF FF               958         .byte   0xff,0xff
                            959 
                            960 ; SCC init?
   87E8                     961 L87E8:
   87E8 CE F8 57      [ 3]  962         ldx     #0xF857
   87EB                     963 L87EB:
   87EB A6 00         [ 4]  964         ldaa    0,X
   87ED 81 FF         [ 2]  965         cmpa    #0xFF
   87EF 27 0C         [ 3]  966         beq     L87FD
   87F1 08            [ 3]  967         inx
   87F2 B7 18 0C      [ 4]  968         staa    (0x180C)
   87F5 A6 00         [ 4]  969         ldaa    0,X
   87F7 08            [ 3]  970         inx
   87F8 B7 18 0C      [ 4]  971         staa    (0x180C)
   87FB 20 EE         [ 3]  972         bra     L87EB
   87FD                     973 L87FD:
   87FD 20 16         [ 3]  974         bra     L8815
                            975 
                            976 ; data table
   87FF 09 8A               977         .byte   0x09,0x8a
   8801 01 10               978         .byte   0x01,0x10
   8803 0C 18               979         .byte   0x0c,0x18
   8805 0D 00               980         .byte   0x0d,0x00
   8807 04 04               981         .byte   0x04,0x04
   8809 0E 63               982         .byte   0x0e,0x63
   880B 05 68               983         .byte   0x05,0x68
   880D 0B 01               984         .byte   0x0b,0x01
   880F 03 C1               985         .byte   0x03,0xc1
   8811 0F 00               986         .byte   0x0f,0x00
   8813 FF FF               987         .byte   0xff,0xff
                            988 
   8815                     989 L8815:
   8815 CE 88 3E      [ 3]  990         ldx     #0x883E
   8818 FF 01 28      [ 5]  991         stx     (0x0128)
   881B 86 7E         [ 2]  992         ldaa    #0x7E
   881D B7 01 27      [ 4]  993         staa    (0x0127)
   8820 CE 88 32      [ 3]  994         ldx     #0x8832
   8823 FF 01 01      [ 5]  995         stx     (0x0101)
   8826 B7 01 00      [ 4]  996         staa    (0x0100)
   8829 B6 10 2D      [ 4]  997         ldaa    SCCR2  
   882C 8A 20         [ 2]  998         oraa    #0x20
   882E B7 10 2D      [ 4]  999         staa    SCCR2  
   8831 39            [ 5] 1000         rts
                           1001 
   8832 B6 10 2E      [ 4] 1002         ldaa    SCSR  
   8835 B6 10 2F      [ 4] 1003         ldaa    SCDR  
   8838 7C 00 48      [ 6] 1004         inc     (0x0048)
   883B 7E 88 62      [ 3] 1005         jmp     (0x8862)
   883E 86 01         [ 2] 1006         ldaa    #0x01
   8840 B7 18 0C      [ 4] 1007         staa    (0x180C)
   8843 B6 18 0C      [ 4] 1008         ldaa    (0x180C)
   8846 84 70         [ 2] 1009         anda    #0x70
   8848 26 1F         [ 3] 1010         bne     L8869  
   884A 86 0A         [ 2] 1011         ldaa    #0x0A
   884C B7 18 0C      [ 4] 1012         staa    (0x180C)
   884F B6 18 0C      [ 4] 1013         ldaa    (0x180C)
   8852 84 C0         [ 2] 1014         anda    #0xC0
   8854 26 22         [ 3] 1015         bne     L8878  
   8856 B6 18 0C      [ 4] 1016         ldaa    (0x180C)
   8859 44            [ 2] 1017         lsra
   885A 24 35         [ 3] 1018         bcc     L8891  
   885C 7C 00 48      [ 6] 1019         inc     (0x0048)
   885F B6 18 0E      [ 4] 1020         ldaa    (0x180E)
   8862 BD F9 6F      [ 6] 1021         jsr     (0xF96F)
   8865 97 4A         [ 3] 1022         staa    (0x004A)
   8867 20 2D         [ 3] 1023         bra     L8896  
   8869                    1024 L8869:
   8869 B6 18 0E      [ 4] 1025         ldaa    (0x180E)
   886C 86 30         [ 2] 1026         ldaa    #0x30
   886E B7 18 0C      [ 4] 1027         staa    (0x180C)
   8871 86 07         [ 2] 1028         ldaa    #0x07
   8873 BD F9 6F      [ 6] 1029         jsr     (0xF96F)
   8876 0C            [ 2] 1030         clc
   8877 3B            [12] 1031         rti
                           1032 
   8878                    1033 L8878:
   8878 86 07         [ 2] 1034         ldaa    #0x07
   887A BD F9 6F      [ 6] 1035         jsr     (0xF96F)
   887D 86 0E         [ 2] 1036         ldaa    #0x0E
   887F B7 18 0C      [ 4] 1037         staa    (0x180C)
   8882 86 43         [ 2] 1038         ldaa    #0x43
   8884 B7 18 0C      [ 4] 1039         staa    (0x180C)
   8887 B6 18 0E      [ 4] 1040         ldaa    (0x180E)
   888A 86 07         [ 2] 1041         ldaa    #0x07
   888C BD F9 6F      [ 6] 1042         jsr     (0xF96F)
   888F 0D            [ 2] 1043         sec
   8890 3B            [12] 1044         rti
                           1045 
   8891                    1046 L8891:
   8891 B6 18 0E      [ 4] 1047         ldaa    (0x180E)
   8894 0C            [ 2] 1048         clc
   8895 3B            [12] 1049         rti
                           1050 
   8896                    1051 L8896:
   8896 84 7F         [ 2] 1052         anda    #0x7F
   8898 81 24         [ 2] 1053         cmpa    #0x24
   889A 27 44         [ 3] 1054         beq     L88E0  
   889C 81 25         [ 2] 1055         cmpa    #0x25
   889E 27 40         [ 3] 1056         beq     L88E0  
   88A0 81 20         [ 2] 1057         cmpa    #0x20
   88A2 27 3A         [ 3] 1058         beq     L88DE  
   88A4 81 30         [ 2] 1059         cmpa    #0x30
   88A6 25 35         [ 3] 1060         bcs     L88DD  
   88A8 97 12         [ 3] 1061         staa    (0x0012)
   88AA 96 4D         [ 3] 1062         ldaa    (0x004D)
   88AC 81 02         [ 2] 1063         cmpa    #0x02
   88AE 25 09         [ 3] 1064         bcs     L88B9  
   88B0 7F 00 4D      [ 6] 1065         clr     (0x004D)
   88B3 96 12         [ 3] 1066         ldaa    (0x0012)
   88B5 97 49         [ 3] 1067         staa    (0x0049)
   88B7 20 24         [ 3] 1068         bra     L88DD  
   88B9                    1069 L88B9:
   88B9 7D 00 4E      [ 6] 1070         tst     (0x004E)
   88BC 27 1F         [ 3] 1071         beq     L88DD  
   88BE 86 78         [ 2] 1072         ldaa    #0x78
   88C0 97 63         [ 3] 1073         staa    (0x0063)
   88C2 97 64         [ 3] 1074         staa    (0x0064)
   88C4 96 12         [ 3] 1075         ldaa    (0x0012)
   88C6 81 40         [ 2] 1076         cmpa    #0x40
   88C8 24 07         [ 3] 1077         bcc     L88D1  
   88CA 97 4C         [ 3] 1078         staa    (0x004C)
   88CC 7F 00 4D      [ 6] 1079         clr     (0x004D)
   88CF 20 0C         [ 3] 1080         bra     L88DD  
   88D1                    1081 L88D1:
   88D1 81 60         [ 2] 1082         cmpa    #0x60
   88D3 24 08         [ 3] 1083         bcc     L88DD  
   88D5 97 4B         [ 3] 1084         staa    (0x004B)
   88D7 7F 00 4D      [ 6] 1085         clr     (0x004D)
   88DA BD 88 E5      [ 6] 1086         jsr     (0x88E5)
   88DD                    1087 L88DD:
   88DD 3B            [12] 1088         rti
                           1089 
   88DE                    1090 L88DE:
   88DE 20 FD         [ 3] 1091         bra     L88DD  
   88E0                    1092 L88E0:
   88E0 7C 00 4D      [ 6] 1093         inc     (0x004D)
   88E3 20 F9         [ 3] 1094         bra     L88DE  
   88E5 D6 4B         [ 3] 1095         ldab    (0x004B)
   88E7 96 4C         [ 3] 1096         ldaa    (0x004C)
   88E9 7D 04 5C      [ 6] 1097         tst     (0x045C)
   88EC 27 0D         [ 3] 1098         beq     L88FB  
   88EE 81 3C         [ 2] 1099         cmpa    #0x3C
   88F0 25 09         [ 3] 1100         bcs     L88FB  
   88F2 81 3F         [ 2] 1101         cmpa    #0x3F
   88F4 22 05         [ 3] 1102         bhi     L88FB  
   88F6 BD 89 93      [ 6] 1103         jsr     (0x8993)
   88F9 20 65         [ 3] 1104         bra     L8960  
   88FB                    1105 L88FB:
   88FB 1A 83 30 48   [ 5] 1106         cpd     #0x3048
   88FF 27 79         [ 3] 1107         beq     L897A  
   8901 1A 83 31 48   [ 5] 1108         cpd     #0x3148
   8905 27 5A         [ 3] 1109         beq     L8961  
   8907 1A 83 34 4D   [ 5] 1110         cpd     #0x344D
   890B 27 6D         [ 3] 1111         beq     L897A  
   890D 1A 83 35 4D   [ 5] 1112         cpd     #0x354D
   8911 27 4E         [ 3] 1113         beq     L8961  
   8913 1A 83 36 4D   [ 5] 1114         cpd     #0x364D
   8917 27 61         [ 3] 1115         beq     L897A  
   8919 1A 83 37 4D   [ 5] 1116         cpd     #0x374D
   891D 27 42         [ 3] 1117         beq     L8961  
   891F CE 10 80      [ 3] 1118         ldx     #0x1080
   8922 D6 4C         [ 3] 1119         ldab    (0x004C)
   8924 C0 30         [ 2] 1120         subb    #0x30
   8926 54            [ 2] 1121         lsrb
   8927 58            [ 2] 1122         aslb
   8928 58            [ 2] 1123         aslb
   8929 3A            [ 3] 1124         abx
   892A D6 4B         [ 3] 1125         ldab    (0x004B)
   892C C1 50         [ 2] 1126         cmpb    #0x50
   892E 24 30         [ 3] 1127         bcc     L8960  
   8930 C1 47         [ 2] 1128         cmpb    #0x47
   8932 23 02         [ 3] 1129         bls     L8936  
   8934 08            [ 3] 1130         inx
   8935 08            [ 3] 1131         inx
   8936                    1132 L8936:
   8936 C0 40         [ 2] 1133         subb    #0x40
   8938 C4 07         [ 2] 1134         andb    #0x07
   893A 4F            [ 2] 1135         clra
   893B 0D            [ 2] 1136         sec
   893C 49            [ 2] 1137         rola
   893D 5D            [ 2] 1138         tstb
   893E 27 04         [ 3] 1139         beq     L8944  
   8940                    1140 L8940:
   8940 49            [ 2] 1141         rola
   8941 5A            [ 2] 1142         decb
   8942 26 FC         [ 3] 1143         bne     L8940  
   8944                    1144 L8944:
   8944 97 50         [ 3] 1145         staa    (0x0050)
   8946 96 4C         [ 3] 1146         ldaa    (0x004C)
   8948 84 01         [ 2] 1147         anda    #0x01
   894A 27 08         [ 3] 1148         beq     L8954  
   894C A6 00         [ 4] 1149         ldaa    0,X
   894E 9A 50         [ 3] 1150         oraa    (0x0050)
   8950 A7 00         [ 4] 1151         staa    0,X
   8952 20 0C         [ 3] 1152         bra     L8960  
   8954                    1153 L8954:
   8954 96 50         [ 3] 1154         ldaa    (0x0050)
   8956 88 FF         [ 2] 1155         eora    #0xFF
   8958 97 50         [ 3] 1156         staa    (0x0050)
   895A A6 00         [ 4] 1157         ldaa    0,X
   895C 94 50         [ 3] 1158         anda    (0x0050)
   895E A7 00         [ 4] 1159         staa    0,X
   8960                    1160 L8960:
   8960 39            [ 5] 1161         rts
                           1162 
   8961                    1163 L8961:
   8961 B6 10 82      [ 4] 1164         ldaa    (0x1082)
   8964 8A 01         [ 2] 1165         oraa    #0x01
   8966 B7 10 82      [ 4] 1166         staa    (0x1082)
   8969 B6 10 8A      [ 4] 1167         ldaa    (0x108A)
   896C 8A 20         [ 2] 1168         oraa    #0x20
   896E B7 10 8A      [ 4] 1169         staa    (0x108A)
   8971 B6 10 8E      [ 4] 1170         ldaa    (0x108E)
   8974 8A 20         [ 2] 1171         oraa    #0x20
   8976 B7 10 8E      [ 4] 1172         staa    (0x108E)
   8979 39            [ 5] 1173         rts
                           1174 
   897A                    1175 L897A:
   897A B6 10 82      [ 4] 1176         ldaa    (0x1082)
   897D 84 FE         [ 2] 1177         anda    #0xFE
   897F B7 10 82      [ 4] 1178         staa    (0x1082)
   8982 B6 10 8A      [ 4] 1179         ldaa    (0x108A)
   8985 84 DF         [ 2] 1180         anda    #0xDF
   8987 B7 10 8A      [ 4] 1181         staa    (0x108A)
   898A B6 10 8E      [ 4] 1182         ldaa    (0x108E)
   898D 84 DF         [ 2] 1183         anda    #0xDF
   898F B7 10 8E      [ 4] 1184         staa    (0x108E)
   8992 39            [ 5] 1185         rts
                           1186 
   8993 3C            [ 4] 1187         pshx
   8994 81 3D         [ 2] 1188         cmpa    #0x3D
   8996 22 05         [ 3] 1189         bhi     L899D  
   8998 CE F7 80      [ 3] 1190         ldx     #0xF780
   899B 20 03         [ 3] 1191         bra     L89A0  
   899D                    1192 L899D:
   899D CE F7 A0      [ 3] 1193         ldx     #0xF7A0
   89A0                    1194 L89A0:
   89A0 C0 40         [ 2] 1195         subb    #0x40
   89A2 58            [ 2] 1196         aslb
   89A3 3A            [ 3] 1197         abx
   89A4 81 3C         [ 2] 1198         cmpa    #0x3C
   89A6 27 34         [ 3] 1199         beq     L89DC  
   89A8 81 3D         [ 2] 1200         cmpa    #0x3D
   89AA 27 0A         [ 3] 1201         beq     L89B6  
   89AC 81 3E         [ 2] 1202         cmpa    #0x3E
   89AE 27 4B         [ 3] 1203         beq     L89FB  
   89B0 81 3F         [ 2] 1204         cmpa    #0x3F
   89B2 27 15         [ 3] 1205         beq     L89C9  
   89B4 38            [ 5] 1206         pulx
   89B5 39            [ 5] 1207         rts
                           1208 
   89B6                    1209 L89B6:
   89B6 B6 10 98      [ 4] 1210         ldaa    (0x1098)
   89B9 AA 00         [ 4] 1211         oraa    0,X
   89BB B7 10 98      [ 4] 1212         staa    (0x1098)
   89BE 08            [ 3] 1213         inx
   89BF B6 10 9A      [ 4] 1214         ldaa    (0x109A)
   89C2 AA 00         [ 4] 1215         oraa    0,X
   89C4 B7 10 9A      [ 4] 1216         staa    (0x109A)
   89C7 38            [ 5] 1217         pulx
   89C8 39            [ 5] 1218         rts
                           1219 
   89C9                    1220 L89C9:
   89C9 B6 10 9C      [ 4] 1221         ldaa    (0x109C)
   89CC AA 00         [ 4] 1222         oraa    0,X
   89CE B7 10 9C      [ 4] 1223         staa    (0x109C)
   89D1 08            [ 3] 1224         inx
   89D2 B6 10 9E      [ 4] 1225         ldaa    (0x109E)
   89D5 AA 00         [ 4] 1226         oraa    0,X
   89D7 B7 10 9E      [ 4] 1227         staa    (0x109E)
   89DA 38            [ 5] 1228         pulx
   89DB 39            [ 5] 1229         rts
                           1230 
   89DC                    1231 L89DC:
   89DC E6 00         [ 4] 1232         ldab    0,X
   89DE C8 FF         [ 2] 1233         eorb    #0xFF
   89E0 D7 12         [ 3] 1234         stab    (0x0012)
   89E2 B6 10 98      [ 4] 1235         ldaa    (0x1098)
   89E5 94 12         [ 3] 1236         anda    (0x0012)
   89E7 B7 10 98      [ 4] 1237         staa    (0x1098)
   89EA 08            [ 3] 1238         inx
   89EB E6 00         [ 4] 1239         ldab    0,X
   89ED C8 FF         [ 2] 1240         eorb    #0xFF
   89EF D7 12         [ 3] 1241         stab    (0x0012)
   89F1 B6 10 9A      [ 4] 1242         ldaa    (0x109A)
   89F4 94 12         [ 3] 1243         anda    (0x0012)
   89F6 B7 10 9A      [ 4] 1244         staa    (0x109A)
   89F9 38            [ 5] 1245         pulx
   89FA 39            [ 5] 1246         rts
                           1247 
   89FB                    1248 L89FB:
   89FB E6 00         [ 4] 1249         ldab    0,X
   89FD C8 FF         [ 2] 1250         eorb    #0xFF
   89FF D7 12         [ 3] 1251         stab    (0x0012)
   8A01 B6 10 9C      [ 4] 1252         ldaa    (0x109C)
   8A04 94 12         [ 3] 1253         anda    (0x0012)
   8A06 B7 10 9C      [ 4] 1254         staa    (0x109C)
   8A09 08            [ 3] 1255         inx
   8A0A E6 00         [ 4] 1256         ldab    0,X
   8A0C C8 FF         [ 2] 1257         eorb    #0xFF
   8A0E D7 12         [ 3] 1258         stab    (0x0012)
   8A10 B6 10 9E      [ 4] 1259         ldaa    (0x109E)
   8A13 94 12         [ 3] 1260         anda    (0x0012)
   8A15 B7 10 9E      [ 4] 1261         staa    (0x109E)
   8A18 38            [ 5] 1262         pulx
   8A19 39            [ 5] 1263         rts
                           1264 
   8A1A                    1265 L8A1A:
                           1266 ; Read from table location in X
   8A1A 3C            [ 4] 1267         pshx
   8A1B                    1268 L8A1B:
   8A1B 86 04         [ 2] 1269         ldaa    #0x04
   8A1D B5 18 0D      [ 4] 1270         bita    (0x180D)
   8A20 27 F9         [ 3] 1271         beq     L8A1B  
   8A22 A6 00         [ 4] 1272         ldaa    0,X     
   8A24 26 03         [ 3] 1273         bne     L8A29       ; is it a nul?
   8A26 7E 8B 21      [ 3] 1274         jmp     (0x8B21)     ; if so jump to exit
   8A29                    1275 L8A29:
   8A29 08            [ 3] 1276         inx
   8A2A 81 5E         [ 2] 1277         cmpa    #0x5E        ; is is a caret? '^'
   8A2C 26 1D         [ 3] 1278         bne     L8A4B       ; no, jump ahead
   8A2E A6 00         [ 4] 1279         ldaa    0,X         ; yes, get the next char
   8A30 08            [ 3] 1280         inx
   8A31 B7 05 92      [ 4] 1281         staa    (0x0592)    
   8A34 A6 00         [ 4] 1282         ldaa    0,X     
   8A36 08            [ 3] 1283         inx
   8A37 B7 05 93      [ 4] 1284         staa    (0x0593)
   8A3A A6 00         [ 4] 1285         ldaa    0,X     
   8A3C 08            [ 3] 1286         inx
   8A3D B7 05 95      [ 4] 1287         staa    (0x0595)
   8A40 A6 00         [ 4] 1288         ldaa    0,X     
   8A42 08            [ 3] 1289         inx
   8A43 B7 05 96      [ 4] 1290         staa    (0x0596)
   8A46 BD 8B 23      [ 6] 1291         jsr     (0x8B23)
   8A49 20 D0         [ 3] 1292         bra     L8A1B  
                           1293 
   8A4B                    1294 L8A4B:
   8A4B 81 40         [ 2] 1295         cmpa    #0x40
   8A4D 26 3B         [ 3] 1296         bne     L8A8A  
   8A4F 1A EE 00      [ 6] 1297         ldy     0,X     
   8A52 08            [ 3] 1298         inx
   8A53 08            [ 3] 1299         inx
   8A54 86 30         [ 2] 1300         ldaa    #0x30
   8A56 97 B1         [ 3] 1301         staa    (0x00B1)
   8A58 18 A6 00      [ 5] 1302         ldaa    0,Y     
   8A5B                    1303 L8A5B:
   8A5B 81 64         [ 2] 1304         cmpa    #0x64
   8A5D 25 07         [ 3] 1305         bcs     L8A66  
   8A5F 7C 00 B1      [ 6] 1306         inc     (0x00B1)
   8A62 80 64         [ 2] 1307         suba    #0x64
   8A64 20 F5         [ 3] 1308         bra     L8A5B  
   8A66                    1309 L8A66:
   8A66 36            [ 3] 1310         psha
   8A67 96 B1         [ 3] 1311         ldaa    (0x00B1)
   8A69 BD 8B 3B      [ 6] 1312         jsr     (0x8B3B)
   8A6C 86 30         [ 2] 1313         ldaa    #0x30
   8A6E 97 B1         [ 3] 1314         staa    (0x00B1)
   8A70 32            [ 4] 1315         pula
   8A71                    1316 L8A71:
   8A71 81 0A         [ 2] 1317         cmpa    #0x0A
   8A73 25 07         [ 3] 1318         bcs     L8A7C  
   8A75 7C 00 B1      [ 6] 1319         inc     (0x00B1)
   8A78 80 0A         [ 2] 1320         suba    #0x0A
   8A7A 20 F5         [ 3] 1321         bra     L8A71  
   8A7C                    1322 L8A7C:
   8A7C 36            [ 3] 1323         psha
   8A7D 96 B1         [ 3] 1324         ldaa    (0x00B1)
   8A7F BD 8B 3B      [ 6] 1325         jsr     (0x8B3B)
   8A82 32            [ 4] 1326         pula
   8A83 8B 30         [ 2] 1327         adda    #0x30
   8A85 BD 8B 3B      [ 6] 1328         jsr     (0x8B3B)
   8A88 20 91         [ 3] 1329         bra     L8A1B  
   8A8A                    1330 L8A8A:
   8A8A 81 7C         [ 2] 1331         cmpa    #0x7C
   8A8C 26 59         [ 3] 1332         bne     L8AE7  
   8A8E 1A EE 00      [ 6] 1333         ldy     0,X     
   8A91 08            [ 3] 1334         inx
   8A92 08            [ 3] 1335         inx
   8A93 86 30         [ 2] 1336         ldaa    #0x30
   8A95 97 B1         [ 3] 1337         staa    (0x00B1)
   8A97 18 EC 00      [ 6] 1338         ldd     0,Y     
   8A9A                    1339 L8A9A:
   8A9A 1A 83 27 10   [ 5] 1340         cpd     #0x2710
   8A9E 25 08         [ 3] 1341         bcs     L8AA8  
   8AA0 7C 00 B1      [ 6] 1342         inc     (0x00B1)
   8AA3 83 27 10      [ 4] 1343         subd    #0x2710
   8AA6 20 F2         [ 3] 1344         bra     L8A9A  
   8AA8                    1345 L8AA8:
   8AA8 36            [ 3] 1346         psha
   8AA9 96 B1         [ 3] 1347         ldaa    (0x00B1)
   8AAB BD 8B 3B      [ 6] 1348         jsr     (0x8B3B)
   8AAE 86 30         [ 2] 1349         ldaa    #0x30
   8AB0 97 B1         [ 3] 1350         staa    (0x00B1)
   8AB2 32            [ 4] 1351         pula
   8AB3                    1352 L8AB3:
   8AB3 1A 83 03 E8   [ 5] 1353         cpd     #0x03E8
   8AB7 25 08         [ 3] 1354         bcs     L8AC1  
   8AB9 7C 00 B1      [ 6] 1355         inc     (0x00B1)
   8ABC 83 03 E8      [ 4] 1356         subd    #0x03E8
   8ABF 20 F2         [ 3] 1357         bra     L8AB3  
   8AC1                    1358 L8AC1:
   8AC1 36            [ 3] 1359         psha
   8AC2 96 B1         [ 3] 1360         ldaa    (0x00B1)
   8AC4 BD 8B 3B      [ 6] 1361         jsr     (0x8B3B)
   8AC7 86 30         [ 2] 1362         ldaa    #0x30
   8AC9 97 B1         [ 3] 1363         staa    (0x00B1)
   8ACB 32            [ 4] 1364         pula
   8ACC                    1365 L8ACC:
   8ACC 1A 83 00 64   [ 5] 1366         cpd     #0x0064
   8AD0 25 08         [ 3] 1367         bcs     L8ADA  
   8AD2 7C 00 B1      [ 6] 1368         inc     (0x00B1)
   8AD5 83 00 64      [ 4] 1369         subd    #0x0064
   8AD8 20 F2         [ 3] 1370         bra     L8ACC  
   8ADA                    1371 L8ADA:
   8ADA 96 B1         [ 3] 1372         ldaa    (0x00B1)
   8ADC BD 8B 3B      [ 6] 1373         jsr     (0x8B3B)
   8ADF 86 30         [ 2] 1374         ldaa    #0x30
   8AE1 97 B1         [ 3] 1375         staa    (0x00B1)
   8AE3 17            [ 2] 1376         tba
   8AE4 7E 8A 71      [ 3] 1377         jmp     (0x8A71)
   8AE7                    1378 L8AE7:
   8AE7 81 7E         [ 2] 1379         cmpa    #0x7E
   8AE9 26 18         [ 3] 1380         bne     L8B03  
   8AEB E6 00         [ 4] 1381         ldab    0,X     
   8AED C0 30         [ 2] 1382         subb    #0x30
   8AEF 08            [ 3] 1383         inx
   8AF0 1A EE 00      [ 6] 1384         ldy     0,X     
   8AF3 08            [ 3] 1385         inx
   8AF4 08            [ 3] 1386         inx
   8AF5                    1387 L8AF5:
   8AF5 18 A6 00      [ 5] 1388         ldaa    0,Y     
   8AF8 18 08         [ 4] 1389         iny
   8AFA BD 8B 3B      [ 6] 1390         jsr     (0x8B3B)
   8AFD 5A            [ 2] 1391         decb
   8AFE 26 F5         [ 3] 1392         bne     L8AF5  
   8B00 7E 8A 1B      [ 3] 1393         jmp     (0x8A1B)
   8B03                    1394 L8B03:
   8B03 81 25         [ 2] 1395         cmpa    #0x25
   8B05 26 14         [ 3] 1396         bne     L8B1B  
   8B07 CE 05 90      [ 3] 1397         ldx     #0x0590
   8B0A CC 1B 5B      [ 3] 1398         ldd     #0x1B5B
   8B0D ED 00         [ 5] 1399         std     0,X     
   8B0F 86 4B         [ 2] 1400         ldaa    #0x4B
   8B11 A7 02         [ 4] 1401         staa    2,X
   8B13 6F 03         [ 6] 1402         clr     3,X
   8B15 BD 8A 1A      [ 6] 1403         jsr     L8A1A  
   8B18 7E 8A 1B      [ 3] 1404         jmp     (0x8A1B)
   8B1B                    1405 L8B1B:
   8B1B B7 18 0F      [ 4] 1406         staa    (0x180F)
   8B1E 7E 8A 1B      [ 3] 1407         jmp     (0x8A1B)
   8B21 38            [ 5] 1408         pulx
   8B22 39            [ 5] 1409         rts
                           1410 
   8B23 3C            [ 4] 1411         pshx
   8B24 CE 05 90      [ 3] 1412         ldx     #0x0590
   8B27 CC 1B 5B      [ 3] 1413         ldd     #0x1B5B
   8B2A ED 00         [ 5] 1414         std     0,X     
   8B2C 86 48         [ 2] 1415         ldaa    #0x48
   8B2E A7 07         [ 4] 1416         staa    7,X
   8B30 86 3B         [ 2] 1417         ldaa    #0x3B
   8B32 A7 04         [ 4] 1418         staa    4,X
   8B34 6F 08         [ 6] 1419         clr     8,X
   8B36 BD 8A 1A      [ 6] 1420         jsr     L8A1A  
   8B39 38            [ 5] 1421         pulx
   8B3A 39            [ 5] 1422         rts
                           1423 
   8B3B 36            [ 3] 1424         psha
   8B3C                    1425 L8B3C:
   8B3C 86 04         [ 2] 1426         ldaa    #0x04
   8B3E B5 18 0D      [ 4] 1427         bita    (0x180D)
   8B41 27 F9         [ 3] 1428         beq     L8B3C  
   8B43 32            [ 4] 1429         pula
   8B44 B7 18 0F      [ 4] 1430         staa    (0x180F)
   8B47 39            [ 5] 1431         rts
                           1432 
   8B48 BD A3 2E      [ 6] 1433         jsr     (0xA32E)
                           1434 
   8B4B BD 8D E4      [ 6] 1435         jsr     (0x8DE4)
   8B4E 4C 69 67 68 74 20  1436         .ascis  'Light Diagnostic'
        44 69 61 67 6E 6F
        73 74 69 E3
                           1437 
   8B5E BD 8D DD      [ 6] 1438         jsr     (0x8DDD)
   8B61 43 75 72 74 61 69  1439         .ascis  'Curtains opening'
        6E 73 20 6F 70 65
        6E 69 6E E7
                           1440 
   8B71 C6 14         [ 2] 1441         ldab    #0x14
   8B73 BD 8C 30      [ 6] 1442         jsr     (0x8C30)
   8B76 C6 FF         [ 2] 1443         ldab    #0xFF
   8B78 F7 10 98      [ 4] 1444         stab    (0x1098)
   8B7B F7 10 9A      [ 4] 1445         stab    (0x109A)
   8B7E F7 10 9C      [ 4] 1446         stab    (0x109C)
   8B81 F7 10 9E      [ 4] 1447         stab    (0x109E)
   8B84 BD F9 C5      [ 6] 1448         jsr     (0xF9C5)
   8B87 B6 18 04      [ 4] 1449         ldaa    (0x1804)
   8B8A 8A 40         [ 2] 1450         oraa    #0x40
   8B8C B7 18 04      [ 4] 1451         staa    (0x1804)
                           1452 
   8B8F BD 8D E4      [ 6] 1453         jsr     (0x8DE4)
   8B92 20 50 72 65 73 73  1454         .ascis  ' Press ENTER to '
        20 45 4E 54 45 52
        20 74 6F A0
                           1455 
   8BA2 BD 8D DD      [ 6] 1456         jsr     (0x8DDD)
   8BA5 74 75 72 6E 20 6C  1457         .ascis  'turn lights  off'
        69 67 68 74 73 20
        20 6F 66 E6
                           1458 
   8BB5                    1459 L8BB5:
   8BB5 BD 8E 95      [ 6] 1460         jsr     (0x8E95)
   8BB8 81 0D         [ 2] 1461         cmpa    #0x0D
   8BBA 26 F9         [ 3] 1462         bne     L8BB5  
   8BBC BD A3 41      [ 6] 1463         jsr     (0xA341)
   8BBF 39            [ 5] 1464         rts
                           1465 
                           1466 ; setup IRQ handlers!
   8BC0                    1467 L8BC0:
   8BC0 86 80         [ 2] 1468         ldaa    #0x80
   8BC2 B7 10 22      [ 4] 1469         staa    TMSK1
   8BC5 CE AB CC      [ 3] 1470         ldx     #0xABCC
   8BC8 FF 01 19      [ 5] 1471         stx     (0x0119)
   8BCB CE AD 0C      [ 3] 1472         ldx     #0xAD0C
   8BCE FF 01 16      [ 5] 1473         stx     (0x0116)
   8BD1 CE AD 0C      [ 3] 1474         ldx     #0xAD0C
   8BD4 FF 01 2E      [ 5] 1475         stx     (0x012E)
   8BD7 86 7E         [ 2] 1476         ldaa    #0x7E
   8BD9 B7 01 18      [ 4] 1477         staa    (0x0118)
   8BDC B7 01 15      [ 4] 1478         staa    (0x0115)
   8BDF B7 01 2D      [ 4] 1479         staa    (0x012D)
   8BE2 4F            [ 2] 1480         clra
   8BE3 5F            [ 2] 1481         clrb
   8BE4 DD 1B         [ 4] 1482         std     CDTIMR1     ; Reset all the countdown timers
   8BE6 DD 1D         [ 4] 1483         std     CDTIMR2
   8BE8 DD 1F         [ 4] 1484         std     CDTIMR3
   8BEA DD 21         [ 4] 1485         std     CDTIMR4
   8BEC DD 23         [ 4] 1486         std     CDTIMR5
                           1487 
   8BEE                    1488 L8BEE:
   8BEE 86 C0         [ 2] 1489         ldaa    #0xC0
   8BF0 B7 10 23      [ 4] 1490         staa    TFLG1  
   8BF3 39            [ 5] 1491         rts
                           1492 
   8BF4                    1493 L8BF4:
   8BF4 B6 10 0A      [ 4] 1494         ldaa    PORTE
   8BF7 88 FF         [ 2] 1495         eora    #0xFF
   8BF9 16            [ 2] 1496         tab
   8BFA D7 62         [ 3] 1497         stab    (0x0062)
   8BFC BD F9 C5      [ 6] 1498         jsr     (0xF9C5)
   8BFF 20 F3         [ 3] 1499         bra     L8BF4  
   8C01 39            [ 5] 1500         rts
                           1501 
                           1502 ; Delay B seconds??
                           1503 
   8C02 36            [ 3] 1504         psha
   8C03 86 64         [ 2] 1505         ldaa    #0x64
   8C05 3D            [10] 1506         mul
   8C06 DD 23         [ 4] 1507         std     CDTIMR5     ; store B*100 here
   8C08                    1508 L8C08:
   8C08 BD 9B 19      [ 6] 1509         jsr     (0x9B19)     ; update 0x0023/0x0024 from RTC???
   8C0B DC 23         [ 4] 1510         ldd     CDTIMR5
   8C0D 26 F9         [ 3] 1511         bne     L8C08  
   8C0F 32            [ 4] 1512         pula
   8C10 39            [ 5] 1513         rts
                           1514 
   8C11 36            [ 3] 1515         psha
   8C12 86 3C         [ 2] 1516         ldaa    #0x3C
   8C14                    1517 L8C14:
   8C14 97 28         [ 3] 1518         staa    (0x0028)
   8C16 C6 01         [ 2] 1519         ldab    #0x01        ; delay 1 sec
   8C18 BD 8C 02      [ 6] 1520         jsr     (0x8C02)     ;
   8C1B 96 28         [ 3] 1521         ldaa    (0x0028)
   8C1D 4A            [ 2] 1522         deca
   8C1E 26 F4         [ 3] 1523         bne     L8C14  
   8C20 32            [ 4] 1524         pula
   8C21 39            [ 5] 1525         rts
                           1526 
   8C22 36            [ 3] 1527         psha
   8C23 4F            [ 2] 1528         clra
   8C24 DD 23         [ 4] 1529         std     CDTIMR5
   8C26                    1530 L8C26:
   8C26 BD 9B 19      [ 6] 1531         jsr     (0x9B19)
   8C29 7D 00 24      [ 6] 1532         tst     CDTIMR5+1
   8C2C 26 F8         [ 3] 1533         bne     L8C26  
   8C2E 32            [ 4] 1534         pula
   8C2F 39            [ 5] 1535         rts
                           1536 
   8C30 36            [ 3] 1537         psha
   8C31 86 32         [ 2] 1538         ldaa    #0x32
   8C33 3D            [10] 1539         mul
   8C34 DD 23         [ 4] 1540         std     CDTIMR5
   8C36                    1541 L8C36:
   8C36 DC 23         [ 4] 1542         ldd     CDTIMR5
   8C38 26 FC         [ 3] 1543         bne     L8C36  
   8C3A 32            [ 4] 1544         pula
   8C3B 39            [ 5] 1545         rts
                           1546 
                           1547 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1548 ; LCD routines
                           1549 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1550 
   8C3C                    1551 L8C3C:
   8C3C 86 FF         [ 2] 1552         ldaa    #0xFF
   8C3E B7 10 01      [ 4] 1553         staa    DDRA  
   8C41 86 FF         [ 2] 1554         ldaa    #0xFF
   8C43 B7 10 03      [ 4] 1555         staa    DDRG 
   8C46 B6 10 02      [ 4] 1556         ldaa    PORTG  
   8C49 8A 02         [ 2] 1557         oraa    #0x02
   8C4B B7 10 02      [ 4] 1558         staa    PORTG  
   8C4E 86 38         [ 2] 1559         ldaa    #0x38
   8C50 BD 8C 86      [ 6] 1560         jsr     (0x8C86)     ; write byte to LCD
   8C53 86 38         [ 2] 1561         ldaa    #0x38
   8C55 BD 8C 86      [ 6] 1562         jsr     (0x8C86)     ; write byte to LCD
   8C58 86 06         [ 2] 1563         ldaa    #0x06
   8C5A BD 8C 86      [ 6] 1564         jsr     (0x8C86)     ; write byte to LCD
   8C5D 86 0E         [ 2] 1565         ldaa    #0x0E
   8C5F BD 8C 86      [ 6] 1566         jsr     (0x8C86)     ; write byte to LCD
   8C62 86 01         [ 2] 1567         ldaa    #0x01
   8C64 BD 8C 86      [ 6] 1568         jsr     (0x8C86)     ; write byte to LCD
   8C67 CE 00 FF      [ 3] 1569         ldx     #0x00FF
   8C6A                    1570 L8C6A:
   8C6A 01            [ 2] 1571         nop
   8C6B 01            [ 2] 1572         nop
   8C6C 09            [ 3] 1573         dex
   8C6D 26 FB         [ 3] 1574         bne     L8C6A  
   8C6F 39            [ 5] 1575         rts
                           1576 
                           1577 ; toggle LCD ENABLE
   8C70 B6 10 02      [ 4] 1578         ldaa    PORTG  
   8C73 84 FD         [ 2] 1579         anda    #0xFD        ; clear LCD ENABLE
   8C75 B7 10 02      [ 4] 1580         staa    PORTG  
   8C78 8A 02         [ 2] 1581         oraa    #0x02        ; set LCD ENABLE
   8C7A B7 10 02      [ 4] 1582         staa    PORTG  
   8C7D 39            [ 5] 1583         rts
                           1584 
                           1585 ; Reset LCD buffer?
   8C7E                    1586 L8C7E:
   8C7E CC 05 00      [ 3] 1587         ldd     #0x0500       ; Reset LCD queue?
   8C81 DD 46         [ 4] 1588         std     (0x0046)     ; write pointer
   8C83 DD 44         [ 4] 1589         std     (0x0044)     ; read pointer?
   8C85 39            [ 5] 1590         rts
                           1591 
                           1592 ; write byte to LCD
   8C86 BD 8C BD      [ 6] 1593         jsr     (0x8CBD)     ; wait for LCD not busy
   8C89 B7 10 00      [ 4] 1594         staa    PORTA  
   8C8C B6 10 02      [ 4] 1595         ldaa    PORTG       
   8C8F 84 F3         [ 2] 1596         anda    #0xF3        ; LCD RS and LCD RW low
   8C91                    1597 L8C91:
   8C91 B7 10 02      [ 4] 1598         staa    PORTG  
   8C94 BD 8C 70      [ 6] 1599         jsr     (0x8C70)     ; toggle LCD ENABLE
   8C97 39            [ 5] 1600         rts
                           1601 
   8C98 BD 8C BD      [ 6] 1602         jsr     (0x8CBD)     ; wait for LCD not busy
   8C9B B7 10 00      [ 4] 1603         staa    PORTA  
   8C9E B6 10 02      [ 4] 1604         ldaa    PORTG  
   8CA1 84 FB         [ 2] 1605         anda    #0xFB
   8CA3 8A 08         [ 2] 1606         oraa    #0x08
   8CA5 20 EA         [ 3] 1607         bra     L8C91  
   8CA7 BD 8C BD      [ 6] 1608         jsr     (0x8CBD)     ; wait for LCD not busy
   8CAA B6 10 02      [ 4] 1609         ldaa    PORTG  
   8CAD 84 F7         [ 2] 1610         anda    #0xF7
   8CAF 8A 08         [ 2] 1611         oraa    #0x08
   8CB1 20 DE         [ 3] 1612         bra     L8C91  
   8CB3 BD 8C BD      [ 6] 1613         jsr     (0x8CBD)     ; wait for LCD not busy
   8CB6 B6 10 02      [ 4] 1614         ldaa    PORTG  
   8CB9 8A 0C         [ 2] 1615         oraa    #0x0C
   8CBB 20 D4         [ 3] 1616         bra     L8C91  
                           1617 
                           1618 ; wait for LCD not busy (or timeout)
   8CBD 36            [ 3] 1619         psha
   8CBE 37            [ 3] 1620         pshb
   8CBF C6 FF         [ 2] 1621         ldab    #0xFF        ; init timeout counter
   8CC1                    1622 L8CC1:
   8CC1 5D            [ 2] 1623         tstb
   8CC2 27 1A         [ 3] 1624         beq     L8CDE       ; times up, exit
   8CC4 B6 10 02      [ 4] 1625         ldaa    PORTG  
   8CC7 84 F7         [ 2] 1626         anda    #0xF7        ; bit 3 low
   8CC9 8A 04         [ 2] 1627         oraa    #0x04        ; bit 3 high
   8CCB B7 10 02      [ 4] 1628         staa    PORTG       ; LCD RS high
   8CCE BD 8C 70      [ 6] 1629         jsr     (0x8C70)     ; toggle LCD ENABLE
   8CD1 7F 10 01      [ 6] 1630         clr     DDRA  
   8CD4 B6 10 00      [ 4] 1631         ldaa    PORTA       ; read busy flag from LCD
   8CD7 2B 08         [ 3] 1632         bmi     L8CE1       ; if busy, keep looping
   8CD9 86 FF         [ 2] 1633         ldaa    #0xFF
   8CDB B7 10 01      [ 4] 1634         staa    DDRA        ; port A back to outputs
   8CDE                    1635 L8CDE:
   8CDE 33            [ 4] 1636         pulb                ; and exit
   8CDF 32            [ 4] 1637         pula
   8CE0 39            [ 5] 1638         rts
   8CE1                    1639 L8CE1:
   8CE1 5A            [ 2] 1640         decb                ; decrement timer
   8CE2 86 FF         [ 2] 1641         ldaa    #0xFF
   8CE4 B7 10 01      [ 4] 1642         staa    DDRA        ; port A back to outputs
   8CE7 20 D8         [ 3] 1643         bra     L8CC1       ; loop
                           1644 
   8CE9 BD 8C BD      [ 6] 1645         jsr     (0x8CBD)     ; wait for LCD not busy
   8CEC 86 01         [ 2] 1646         ldaa    #0x01
   8CEE BD 8C 86      [ 6] 1647         jsr     (0x8C86)     ; write byte to LCD
   8CF1 39            [ 5] 1648         rts
                           1649 
   8CF2 BD 8C BD      [ 6] 1650         jsr     (0x8CBD)     ; wait for LCD not busy
   8CF5 86 80         [ 2] 1651         ldaa    #0x80
   8CF7 BD 8D 14      [ 6] 1652         jsr     (0x8D14)
   8CFA BD 8C BD      [ 6] 1653         jsr     (0x8CBD)     ; wait for LCD not busy
   8CFD 86 80         [ 2] 1654         ldaa    #0x80
   8CFF BD 8C 86      [ 6] 1655         jsr     (0x8C86)     ; write byte to LCD
   8D02 39            [ 5] 1656         rts
                           1657 
   8D03 BD 8C BD      [ 6] 1658         jsr     (0x8CBD)     ; wait for LCD not busy
   8D06 86 C0         [ 2] 1659         ldaa    #0xC0
   8D08 BD 8D 14      [ 6] 1660         jsr     (0x8D14)
   8D0B BD 8C BD      [ 6] 1661         jsr     (0x8CBD)     ; wait for LCD not busy
   8D0E 86 C0         [ 2] 1662         ldaa    #0xC0
   8D10 BD 8C 86      [ 6] 1663         jsr     (0x8C86)     ; write byte to LCD
   8D13 39            [ 5] 1664         rts
                           1665 
   8D14 BD 8C 86      [ 6] 1666         jsr     (0x8C86)     ; write byte to LCD
   8D17 86 10         [ 2] 1667         ldaa    #0x10
   8D19 97 14         [ 3] 1668         staa    (0x0014)
   8D1B                    1669 L8D1B:
   8D1B BD 8C BD      [ 6] 1670         jsr     (0x8CBD)     ; wait for LCD not busy
   8D1E 86 20         [ 2] 1671         ldaa    #0x20
   8D20 BD 8C 98      [ 6] 1672         jsr     (0x8C98)
   8D23 7A 00 14      [ 6] 1673         dec     (0x0014)
   8D26 26 F3         [ 3] 1674         bne     L8D1B  
   8D28 39            [ 5] 1675         rts
                           1676 
   8D29                    1677 L8D29:
   8D29 86 0C         [ 2] 1678         ldaa    #0x0C
   8D2B BD 8E 4B      [ 6] 1679         jsr     (0x8E4B)
   8D2E 39            [ 5] 1680         rts
                           1681 
   8D2F 86 0E         [ 2] 1682         ldaa    #0x0E
   8D31 BD 8E 4B      [ 6] 1683         jsr     (0x8E4B)
   8D34 39            [ 5] 1684         rts
                           1685 
   8D35 7F 00 4A      [ 6] 1686         clr     (0x004A)
   8D38 7F 00 43      [ 6] 1687         clr     (0x0043)
   8D3B 18 DE 46      [ 5] 1688         ldy     (0x0046)
   8D3E 86 C0         [ 2] 1689         ldaa    #0xC0
   8D40 20 0B         [ 3] 1690         bra     L8D4D  
   8D42 7F 00 4A      [ 6] 1691         clr     (0x004A)
   8D45 7F 00 43      [ 6] 1692         clr     (0x0043)
   8D48 18 DE 46      [ 5] 1693         ldy     (0x0046)
   8D4B 86 80         [ 2] 1694         ldaa    #0x80
   8D4D                    1695 L8D4D:
   8D4D 18 A7 00      [ 5] 1696         staa    0,Y     
   8D50 18 6F 01      [ 7] 1697         clr     1,Y     
   8D53 18 08         [ 4] 1698         iny
   8D55 18 08         [ 4] 1699         iny
   8D57 18 8C 05 80   [ 5] 1700         cpy     #0x0580
   8D5B 25 04         [ 3] 1701         bcs     L8D61  
   8D5D 18 CE 05 00   [ 4] 1702         ldy     #0x0500
   8D61                    1703 L8D61:
   8D61 C6 0F         [ 2] 1704         ldab    #0x0F
   8D63                    1705 L8D63:
   8D63 96 4A         [ 3] 1706         ldaa    (0x004A)
   8D65 27 FC         [ 3] 1707         beq     L8D63  
   8D67 7F 00 4A      [ 6] 1708         clr     (0x004A)
   8D6A 5A            [ 2] 1709         decb
   8D6B 27 1A         [ 3] 1710         beq     L8D87  
   8D6D 81 24         [ 2] 1711         cmpa    #0x24
   8D6F 27 16         [ 3] 1712         beq     L8D87  
   8D71 18 6F 00      [ 7] 1713         clr     0,Y     
   8D74 18 A7 01      [ 5] 1714         staa    1,Y     
   8D77 18 08         [ 4] 1715         iny
   8D79 18 08         [ 4] 1716         iny
   8D7B 18 8C 05 80   [ 5] 1717         cpy     #0x0580
   8D7F 25 04         [ 3] 1718         bcs     L8D85  
   8D81 18 CE 05 00   [ 4] 1719         ldy     #0x0500
   8D85                    1720 L8D85:
   8D85 20 DC         [ 3] 1721         bra     L8D63  
   8D87                    1722 L8D87:
   8D87 5D            [ 2] 1723         tstb
   8D88 27 19         [ 3] 1724         beq     L8DA3  
   8D8A 86 20         [ 2] 1725         ldaa    #0x20
   8D8C                    1726 L8D8C:
   8D8C 18 6F 00      [ 7] 1727         clr     0,Y     
   8D8F 18 A7 01      [ 5] 1728         staa    1,Y     
   8D92 18 08         [ 4] 1729         iny
   8D94 18 08         [ 4] 1730         iny
   8D96 18 8C 05 80   [ 5] 1731         cpy     #0x0580
   8D9A 25 04         [ 3] 1732         bcs     L8DA0  
   8D9C 18 CE 05 00   [ 4] 1733         ldy     #0x0500
   8DA0                    1734 L8DA0:
   8DA0 5A            [ 2] 1735         decb
   8DA1 26 E9         [ 3] 1736         bne     L8D8C  
   8DA3                    1737 L8DA3:
   8DA3 18 6F 00      [ 7] 1738         clr     0,Y     
   8DA6 18 6F 01      [ 7] 1739         clr     1,Y     
   8DA9 18 DF 46      [ 5] 1740         sty     (0x0046)
   8DAC 96 19         [ 3] 1741         ldaa    (0x0019)
   8DAE 97 4E         [ 3] 1742         staa    (0x004E)
   8DB0 86 01         [ 2] 1743         ldaa    #0x01
   8DB2 97 43         [ 3] 1744         staa    (0x0043)
   8DB4 39            [ 5] 1745         rts
                           1746 
                           1747 ; display ASCII in B at location
   8DB5 36            [ 3] 1748         psha
   8DB6 37            [ 3] 1749         pshb
   8DB7 C1 4F         [ 2] 1750         cmpb    #0x4F
   8DB9 22 13         [ 3] 1751         bhi     L8DCE  
   8DBB C1 28         [ 2] 1752         cmpb    #0x28
   8DBD 25 03         [ 3] 1753         bcs     L8DC2  
   8DBF 0C            [ 2] 1754         clc
   8DC0 C9 18         [ 2] 1755         adcb    #0x18
   8DC2                    1756 L8DC2:
   8DC2 0C            [ 2] 1757         clc
   8DC3 C9 80         [ 2] 1758         adcb    #0x80
   8DC5 17            [ 2] 1759         tba
   8DC6 BD 8E 4B      [ 6] 1760         jsr     (0x8E4B)     ; send lcd command
   8DC9 33            [ 4] 1761         pulb
   8DCA 32            [ 4] 1762         pula
   8DCB BD 8E 70      [ 6] 1763         jsr     (0x8E70)     ; send lcd char
   8DCE                    1764 L8DCE:
   8DCE 39            [ 5] 1765         rts
                           1766 
                           1767 ; 4 routines to write to the LCD display?
                           1768 
   8DCF 18 DE 46      [ 5] 1769         ldy     (0x0046)     ; get buffer pointer
   8DD2 86 90         [ 2] 1770         ldaa    #0x90        ; command to set LCD RAM ptr to chr 0x10
   8DD4 20 13         [ 3] 1771         bra     L8DE9  
                           1772 
   8DD6 18 DE 46      [ 5] 1773         ldy     (0x0046)     ; get buffer pointer
   8DD9 86 D0         [ 2] 1774         ldaa    #0xD0        ; command to set LCD RAM ptr to chr 0x50
   8DDB 20 0C         [ 3] 1775         bra     L8DE9  
                           1776 
                           1777 ; Write to the LCD 2nd line
   8DDD 18 DE 46      [ 5] 1778         ldy     (0x0046)     ; get buffer pointer
   8DE0 86 C0         [ 2] 1779         ldaa    #0xC0        ; command to set LCD RAM ptr to chr 0x40
   8DE2 20 05         [ 3] 1780         bra     L8DE9  
                           1781 
                           1782 ; Write to the LCD 1st line
   8DE4 18 DE 46      [ 5] 1783         ldy     (0x0046)     ; get buffer pointer
   8DE7 86 80         [ 2] 1784         ldaa    #0x80        ; command to load LCD RAM ptr to chr 0x00
                           1785 
                           1786 ; Put LCD command into a buffer, 4 bytes for each entry?
   8DE9                    1787 L8DE9:
   8DE9 18 A7 00      [ 5] 1788         staa    0,Y         ; store command here
   8DEC 18 6F 01      [ 7] 1789         clr     1,Y          ; clear next byte
   8DEF 18 08         [ 4] 1790         iny
   8DF1 18 08         [ 4] 1791         iny
                           1792 
                           1793 ; Add characters at return address to LCD buffer
   8DF3 18 8C 05 80   [ 5] 1794         cpy     #0x0580       ; check for buffer overflow
   8DF7 25 04         [ 3] 1795         bcs     L8DFD  
   8DF9 18 CE 05 00   [ 4] 1796         ldy     #0x0500
   8DFD                    1797 L8DFD:
   8DFD 38            [ 5] 1798         pulx                ; get start of data
   8DFE DF 17         [ 4] 1799         stx     (0x0017)     ; save this here
   8E00                    1800 L8E00:
   8E00 A6 00         [ 4] 1801         ldaa    0,X         ; get character
   8E02 27 36         [ 3] 1802         beq     L8E3A       ; is it 00, if so jump ahead
   8E04 2B 17         [ 3] 1803         bmi     L8E1D       ; high bit set, if so jump ahead
   8E06 18 6F 00      [ 7] 1804         clr     0,Y          ; add character
   8E09 18 A7 01      [ 5] 1805         staa    1,Y     
   8E0C 08            [ 3] 1806         inx
   8E0D 18 08         [ 4] 1807         iny
   8E0F 18 08         [ 4] 1808         iny
   8E11 18 8C 05 80   [ 5] 1809         cpy     #0x0580       ; check for buffer overflow
   8E15 25 E9         [ 3] 1810         bcs     L8E00  
   8E17 18 CE 05 00   [ 4] 1811         ldy     #0x0500
   8E1B 20 E3         [ 3] 1812         bra     L8E00  
                           1813 
   8E1D                    1814 L8E1D:
   8E1D 84 7F         [ 2] 1815         anda    #0x7F
   8E1F 18 6F 00      [ 7] 1816         clr     0,Y          ; add character
   8E22 18 A7 01      [ 5] 1817         staa    1,Y     
   8E25 18 6F 02      [ 7] 1818         clr     2,Y     
   8E28 18 6F 03      [ 7] 1819         clr     3,Y     
   8E2B 08            [ 3] 1820         inx
   8E2C 18 08         [ 4] 1821         iny
   8E2E 18 08         [ 4] 1822         iny
   8E30 18 8C 05 80   [ 5] 1823         cpy     #0x0580       ; check for overflow
   8E34 25 04         [ 3] 1824         bcs     L8E3A  
   8E36 18 CE 05 00   [ 4] 1825         ldy     #0x0500
                           1826 
   8E3A                    1827 L8E3A:
   8E3A 3C            [ 4] 1828         pshx                ; put SP back
   8E3B 86 01         [ 2] 1829         ldaa    #0x01
   8E3D 97 43         [ 3] 1830         staa    (0x0043)    ; semaphore?
   8E3F DC 46         [ 4] 1831         ldd     (0x0046)
   8E41 18 6F 00      [ 7] 1832         clr     0,Y     
   8E44 18 6F 01      [ 7] 1833         clr     1,Y     
   8E47 18 DF 46      [ 5] 1834         sty     (0x0046)     ; save buffer pointer
   8E4A 39            [ 5] 1835         rts
                           1836 
                           1837 ; buffer LCD command?
   8E4B 18 DE 46      [ 5] 1838         ldy     (0x0046)
   8E4E 18 A7 00      [ 5] 1839         staa    0,Y     
   8E51 18 6F 01      [ 7] 1840         clr     1,Y     
   8E54 18 08         [ 4] 1841         iny
   8E56 18 08         [ 4] 1842         iny
   8E58 18 8C 05 80   [ 5] 1843         cpy     #0x0580
   8E5C 25 04         [ 3] 1844         bcs     L8E62  
   8E5E 18 CE 05 00   [ 4] 1845         ldy     #0x0500
   8E62                    1846 L8E62:
   8E62 18 6F 00      [ 7] 1847         clr     0,Y     
   8E65 18 6F 01      [ 7] 1848         clr     1,Y     
   8E68 86 01         [ 2] 1849         ldaa    #0x01
   8E6A 97 43         [ 3] 1850         staa    (0x0043)
   8E6C 18 DF 46      [ 5] 1851         sty     (0x0046)
   8E6F 39            [ 5] 1852         rts
                           1853 
   8E70 18 DE 46      [ 5] 1854         ldy     (0x0046)
   8E73 18 6F 00      [ 7] 1855         clr     0,Y     
   8E76 18 A7 01      [ 5] 1856         staa    1,Y     
   8E79 18 08         [ 4] 1857         iny
   8E7B 18 08         [ 4] 1858         iny
   8E7D 18 8C 05 80   [ 5] 1859         cpy     #0x0580
   8E81 25 04         [ 3] 1860         bcs     L8E87  
   8E83 18 CE 05 00   [ 4] 1861         ldy     #0x0500
   8E87                    1862 L8E87:
   8E87 18 6F 00      [ 7] 1863         clr     0,Y     
   8E8A 18 6F 01      [ 7] 1864         clr     1,Y     
   8E8D 86 01         [ 2] 1865         ldaa    #0x01
   8E8F 97 43         [ 3] 1866         staa    (0x0043)
   8E91 18 DF 46      [ 5] 1867         sty     (0x0046)
   8E94 39            [ 5] 1868         rts
                           1869 
   8E95 96 30         [ 3] 1870         ldaa    (0x0030)
   8E97 26 09         [ 3] 1871         bne     L8EA2  
   8E99 96 31         [ 3] 1872         ldaa    (0x0031)
   8E9B 26 11         [ 3] 1873         bne     L8EAE  
   8E9D 96 32         [ 3] 1874         ldaa    (0x0032)
   8E9F 26 19         [ 3] 1875         bne     L8EBA  
   8EA1 39            [ 5] 1876         rts
                           1877 
                           1878 ;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1879 
   8EA2                    1880 L8EA2:
   8EA2 7F 00 30      [ 6] 1881         clr     (0x0030)
   8EA5 7F 00 32      [ 6] 1882         clr     (0x0032)
   8EA8 7F 00 31      [ 6] 1883         clr     (0x0031)
   8EAB 86 01         [ 2] 1884         ldaa    #0x01
   8EAD 39            [ 5] 1885         rts
                           1886 
   8EAE                    1887 L8EAE:
   8EAE 7F 00 31      [ 6] 1888         clr     (0x0031)
   8EB1 7F 00 30      [ 6] 1889         clr     (0x0030)
   8EB4 7F 00 32      [ 6] 1890         clr     (0x0032)
   8EB7 86 02         [ 2] 1891         ldaa    #0x02
   8EB9 39            [ 5] 1892         rts
                           1893 
   8EBA                    1894 L8EBA:
   8EBA 7F 00 32      [ 6] 1895         clr     (0x0032)
   8EBD 7F 00 30      [ 6] 1896         clr     (0x0030)
   8EC0 7F 00 31      [ 6] 1897         clr     (0x0031)
   8EC3 86 0D         [ 2] 1898         ldaa    #0x0D
   8EC5 39            [ 5] 1899         rts
                           1900 
   8EC6 B6 18 04      [ 4] 1901         ldaa    (0x1804)
   8EC9 84 07         [ 2] 1902         anda    #0x07
   8ECB 97 2C         [ 3] 1903         staa    (0x002C)
   8ECD 78 00 2C      [ 6] 1904         asl     (0x002C)
   8ED0 78 00 2C      [ 6] 1905         asl     (0x002C)
   8ED3 78 00 2C      [ 6] 1906         asl     (0x002C)
   8ED6 78 00 2C      [ 6] 1907         asl     (0x002C)
   8ED9 78 00 2C      [ 6] 1908         asl     (0x002C)
   8EDC CE 00 00      [ 3] 1909         ldx     #0x0000
   8EDF                    1910 L8EDF:
   8EDF 8C 00 03      [ 4] 1911         cpx     #0x0003
   8EE2 27 24         [ 3] 1912         beq     L8F08  
   8EE4 78 00 2C      [ 6] 1913         asl     (0x002C)
   8EE7 25 12         [ 3] 1914         bcs     L8EFB  
   8EE9 A6 2D         [ 4] 1915         ldaa    0x2D,X
   8EEB 81 0F         [ 2] 1916         cmpa    #0x0F
   8EED 24 1A         [ 3] 1917         bcc     L8F09  
   8EEF 6C 2D         [ 6] 1918         inc     0x2D,X
   8EF1 A6 2D         [ 4] 1919         ldaa    0x2D,X
   8EF3 81 02         [ 2] 1920         cmpa    #0x02
   8EF5 26 02         [ 3] 1921         bne     L8EF9  
   8EF7 A7 30         [ 4] 1922         staa    0x30,X
   8EF9                    1923 L8EF9:
   8EF9 20 0A         [ 3] 1924         bra     L8F05  
   8EFB                    1925 L8EFB:
   8EFB 6F 2D         [ 6] 1926         clr     0x2D,X
   8EFD 20 06         [ 3] 1927         bra     L8F05  
   8EFF A6 2D         [ 4] 1928         ldaa    0x2D,X
   8F01 27 02         [ 3] 1929         beq     L8F05  
   8F03 6A 2D         [ 6] 1930         dec     0x2D,X
   8F05                    1931 L8F05:
   8F05 08            [ 3] 1932         inx
   8F06 20 D7         [ 3] 1933         bra     L8EDF  
   8F08                    1934 L8F08:
   8F08 39            [ 5] 1935         rts
                           1936 
   8F09                    1937 L8F09:
   8F09 8C 00 02      [ 4] 1938         cpx     #0x0002
   8F0C 27 02         [ 3] 1939         beq     L8F10  
   8F0E 6F 2D         [ 6] 1940         clr     0x2D,X
   8F10                    1941 L8F10:
   8F10 20 F3         [ 3] 1942         bra     L8F05  
   8F12 B6 10 0A      [ 4] 1943         ldaa    PORTE
   8F15 97 51         [ 3] 1944         staa    (0x0051)
   8F17 CE 00 00      [ 3] 1945         ldx     #0x0000
   8F1A                    1946 L8F1A:
   8F1A 8C 00 08      [ 4] 1947         cpx     #0x0008
   8F1D 27 22         [ 3] 1948         beq     L8F41  
   8F1F 77 00 51      [ 6] 1949         asr     (0x0051)
   8F22 25 10         [ 3] 1950         bcs     L8F34  
   8F24 A6 52         [ 4] 1951         ldaa    0x52,X
   8F26 81 0F         [ 2] 1952         cmpa    #0x0F
   8F28 6C 52         [ 6] 1953         inc     0x52,X
   8F2A A6 52         [ 4] 1954         ldaa    0x52,X
   8F2C 81 04         [ 2] 1955         cmpa    #0x04
   8F2E 26 02         [ 3] 1956         bne     L8F32  
   8F30 A7 5A         [ 4] 1957         staa    0x5A,X
   8F32                    1958 L8F32:
   8F32 20 0A         [ 3] 1959         bra     L8F3E  
   8F34                    1960 L8F34:
   8F34 6F 52         [ 6] 1961         clr     0x52,X
   8F36 20 06         [ 3] 1962         bra     L8F3E  
   8F38 A6 52         [ 4] 1963         ldaa    0x52,X
   8F3A 27 02         [ 3] 1964         beq     L8F3E  
   8F3C 6A 52         [ 6] 1965         dec     0x52,X
   8F3E                    1966 L8F3E:
   8F3E 08            [ 3] 1967         inx
   8F3F 20 D9         [ 3] 1968         bra     L8F1A  
   8F41                    1969 L8F41:
   8F41 39            [ 5] 1970         rts
                           1971 
   8F42 6F 52         [ 6] 1972         clr     0x52,X
   8F44 20 F8         [ 3] 1973         bra     L8F3E  
                           1974 
   8F46 30 2E 35           1975         .ascii      '0.5'
   8F49 31 2E 30           1976         .ascii      '1.0'
   8F4C 31 2E 35           1977         .ascii      '1.5'
   8F4F 32 2E 30           1978         .ascii      '2.0'
   8F52 32 2E 35           1979         .ascii      '2.5'
   8F55 33 2E 30           1980         .ascii      '3.0'
                           1981 
   8F58 3C            [ 4] 1982         pshx
   8F59 96 12         [ 3] 1983         ldaa    (0x0012)
   8F5B 80 01         [ 2] 1984         suba    #0x01
   8F5D C6 03         [ 2] 1985         ldab    #0x03
   8F5F 3D            [10] 1986         mul
                           1987 
   8F60 CE 8F 46      [ 3] 1988         ldx     #0x8F46
   8F63 3A            [ 3] 1989         abx
   8F64 C6 2C         [ 2] 1990         ldab    #0x2C
   8F66                    1991 L8F66:
   8F66 A6 00         [ 4] 1992         ldaa    0,X     
   8F68 08            [ 3] 1993         inx
   8F69 BD 8D B5      [ 6] 1994         jsr     (0x8DB5)         ; display char here on LCD display
   8F6C 5C            [ 2] 1995         incb
   8F6D C1 2F         [ 2] 1996         cmpb    #0x2F
   8F6F 26 F5         [ 3] 1997         bne     L8F66  
   8F71 38            [ 5] 1998         pulx
   8F72 39            [ 5] 1999         rts
                           2000 
   8F73 36            [ 3] 2001         psha
   8F74 BD 8C F2      [ 6] 2002         jsr     (0x8CF2)
   8F77 C6 02         [ 2] 2003         ldab    #0x02
   8F79 BD 8C 30      [ 6] 2004         jsr     (0x8C30)
   8F7C 32            [ 4] 2005         pula
   8F7D 97 B4         [ 3] 2006         staa    (0x00B4)
   8F7F 81 03         [ 2] 2007         cmpa    #0x03
   8F81 26 11         [ 3] 2008         bne     L8F94  
   8F83 BD 8D E4      [ 6] 2009         jsr     (0x8DE4)
                           2010 
   8F86 43 68 75 63 6B 20  2011         .ascis  'Chuck    '
        20 20 A0
                           2012 
   8F8F CE 90 72      [ 3] 2013         ldx     #0x9072
   8F92 20 4D         [ 3] 2014         bra     L8FE1  
   8F94                    2015 L8F94:
   8F94 81 04         [ 2] 2016         cmpa    #0x04
   8F96 26 11         [ 3] 2017         bne     L8FA9  
   8F98 BD 8D E4      [ 6] 2018         jsr     (0x8DE4)
                           2019 
   8F9B 4A 61 73 70 65 72  2020         .ascis  'Jasper   '
        20 20 A0
                           2021 
   8FA4 CE 90 DE      [ 3] 2022         ldx     #0x90DE
   8FA7 20 38         [ 3] 2023         bra     L8FE1  
   8FA9                    2024 L8FA9:
   8FA9 81 05         [ 2] 2025         cmpa    #0x05
   8FAB 26 11         [ 3] 2026         bne     L8FBE  
   8FAD BD 8D E4      [ 6] 2027         jsr     (0x8DE4)
                           2028 
   8FB0 50 61 73 71 75 61  2029         .ascis  'Pasqually'
        6C 6C F9
                           2030 
   8FB9 CE 91 45      [ 3] 2031         ldx     #0x9145
   8FBC 20 23         [ 3] 2032         bra     L8FE1  
   8FBE                    2033 L8FBE:
   8FBE 81 06         [ 2] 2034         cmpa    #0x06
   8FC0 26 11         [ 3] 2035         bne     L8FD3  
   8FC2 BD 8D E4      [ 6] 2036         jsr     (0x8DE4)
                           2037 
   8FC5 4D 75 6E 63 68 20  2038         .ascis  'Munch    '
        20 20 A0
                           2039 
   8FCE CE 91 BA      [ 3] 2040         ldx     #0x91BA
   8FD1 20 0E         [ 3] 2041         bra     L8FE1  
   8FD3                    2042 L8FD3:
   8FD3 BD 8D E4      [ 6] 2043         jsr     (0x8DE4)
                           2044 
   8FD6 48 65 6C 65 6E 20  2045         .ascis  'Helen   '
        20 A0
                           2046 
   8FDE CE 92 26      [ 3] 2047         ldx     #0x9226
   8FE1                    2048 L8FE1:
   8FE1 96 B4         [ 3] 2049         ldaa    (0x00B4)
   8FE3 80 03         [ 2] 2050         suba    #0x03
   8FE5 48            [ 2] 2051         asla
   8FE6 48            [ 2] 2052         asla
   8FE7 97 4B         [ 3] 2053         staa    (0x004B)
   8FE9 BD 95 04      [ 6] 2054         jsr     (0x9504)
   8FEC 97 4C         [ 3] 2055         staa    (0x004C)
   8FEE 81 0F         [ 2] 2056         cmpa    #0x0F
   8FF0 26 01         [ 3] 2057         bne     L8FF3  
   8FF2 39            [ 5] 2058         rts
                           2059 
   8FF3                    2060 L8FF3:
   8FF3 81 08         [ 2] 2061         cmpa    #0x08
   8FF5 23 08         [ 3] 2062         bls     L8FFF  
   8FF7 80 08         [ 2] 2063         suba    #0x08
   8FF9 D6 4B         [ 3] 2064         ldab    (0x004B)
   8FFB CB 02         [ 2] 2065         addb    #0x02
   8FFD D7 4B         [ 3] 2066         stab    (0x004B)
   8FFF                    2067 L8FFF:
   8FFF 36            [ 3] 2068         psha
   9000 18 DE 46      [ 5] 2069         ldy     (0x0046)
   9003 32            [ 4] 2070         pula
   9004 5F            [ 2] 2071         clrb
   9005 0D            [ 2] 2072         sec
   9006                    2073 L9006:
   9006 59            [ 2] 2074         rolb
   9007 4A            [ 2] 2075         deca
   9008 26 FC         [ 3] 2076         bne     L9006  
   900A D7 50         [ 3] 2077         stab    (0x0050)
   900C D6 4B         [ 3] 2078         ldab    (0x004B)
   900E CE 10 80      [ 3] 2079         ldx     #0x1080
   9011 3A            [ 3] 2080         abx
   9012 86 02         [ 2] 2081         ldaa    #0x02
   9014 97 12         [ 3] 2082         staa    (0x0012)
   9016                    2083 L9016:
   9016 A6 00         [ 4] 2084         ldaa    0,X     
   9018 98 50         [ 3] 2085         eora    (0x0050)
   901A A7 00         [ 4] 2086         staa    0,X     
   901C 6D 00         [ 6] 2087         tst     0,X     
   901E 27 16         [ 3] 2088         beq     L9036  
   9020 86 4F         [ 2] 2089         ldaa    #0x4F            ;'O'
   9022 C6 0C         [ 2] 2090         ldab    #0x0C        
   9024 BD 8D B5      [ 6] 2091         jsr     (0x8DB5)         ; display char here on LCD display
   9027 86 6E         [ 2] 2092         ldaa    #0x6E            ;'n'
   9029 C6 0D         [ 2] 2093         ldab    #0x0D
   902B BD 8D B5      [ 6] 2094         jsr     (0x8DB5)         ; display char here on LCD display
   902E CC 20 0E      [ 3] 2095         ldd     #0x200E          ;' '
   9031 BD 8D B5      [ 6] 2096         jsr     (0x8DB5)         ; display char here on LCD display
   9034 20 0E         [ 3] 2097         bra     L9044  
   9036                    2098 L9036:
   9036 86 66         [ 2] 2099         ldaa    #0x66            ;'f'
   9038 C6 0D         [ 2] 2100         ldab    #0x0D
   903A BD 8D B5      [ 6] 2101         jsr     (0x8DB5)         ; display char here on LCD display
   903D 86 66         [ 2] 2102         ldaa    #0x66            ;'f'
   903F C6 0E         [ 2] 2103         ldab    #0x0E
   9041 BD 8D B5      [ 6] 2104         jsr     (0x8DB5)         ; display char here on LCD display
   9044                    2105 L9044:
   9044 D6 12         [ 3] 2106         ldab    (0x0012)
   9046 BD 8C 30      [ 6] 2107         jsr     (0x8C30)
   9049 BD 8E 95      [ 6] 2108         jsr     (0x8E95)
   904C 81 0D         [ 2] 2109         cmpa    #0x0D
   904E 27 14         [ 3] 2110         beq     L9064  
   9050 20 C4         [ 3] 2111         bra     L9016  
   9052 81 02         [ 2] 2112         cmpa    #0x02
   9054 26 C0         [ 3] 2113         bne     L9016  
   9056 96 12         [ 3] 2114         ldaa    (0x0012)
   9058 81 06         [ 2] 2115         cmpa    #0x06
   905A 27 BA         [ 3] 2116         beq     L9016  
   905C 4C            [ 2] 2117         inca
   905D 97 12         [ 3] 2118         staa    (0x0012)
   905F BD 8F 58      [ 6] 2119         jsr     (0x8F58)
   9062 20 B2         [ 3] 2120         bra     L9016  
   9064                    2121 L9064:
   9064 A6 00         [ 4] 2122         ldaa    0,X     
   9066 9A 50         [ 3] 2123         oraa    (0x0050)
   9068 98 50         [ 3] 2124         eora    (0x0050)
   906A A7 00         [ 4] 2125         staa    0,X     
   906C 96 B4         [ 3] 2126         ldaa    (0x00B4)
   906E 7E 8F 73      [ 3] 2127         jmp     (0x8F73)
   9071 39            [ 5] 2128         rts
                           2129 
   9072 4D 6F 75 74 68 2C  2130         .ascis  'Mouth,Head left,Head right,Head up,Eyes right,Eyelids,Right hand,Eyes left,DS9,DS10,DS11,DS12,DS13,DS14,Exit'
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
   90DE 4D 6F 75 74 68 2C  2131         .ascis  'Mouth,Head left,Head right,Head up,Eyes right,Eyelids,Hands,Eyes left,DS9,DS10,DS11,DS12,DS13,DS14,Exit'
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
   9145 4D 6F 75 74 68 2D  2132         .ascis  'Mouth-Mustache,Head left,Head right,Left arm,Eyes right,Eyelids,Right arm,Eyes left,DS9,DS10,DS11,DS12,DS13,DS14,Exit'
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
   91BA 4D 6F 75 74 68 2C  2133         .ascis  'Mouth,Head left,Head right,Left arm,Eyes right,Eyelids,Right arm,Eyes left,DS9,DS10,DS11,DS12,DS13,DS14,Exit'
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
   9226 4D 6F 75 74 68 2C  2134         .ascis  'Mouth,Head left,Head right,Head up,Eyes right,Eyelids,Right hand,Eyes left,DS9,DS10,DS11,DS12,DS13,DS14,Exit'
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
                           2135         
                           2136 ; code again
   9292 BD 86 C4      [ 6] 2137         jsr     L86C4
   9295                    2138 L9295:
   9295 C6 01         [ 2] 2139         ldab    #0x01
   9297 BD 8C 30      [ 6] 2140         jsr     (0x8C30)
                           2141 
   929A BD 8D E4      [ 6] 2142         jsr     (0x8DE4)
   929D 20 20 44 69 61 67  2143         .ascis  '  Diagnostics   '
        6E 6F 73 74 69 63
        73 20 20 A0
                           2144 
   92AD BD 8D DD      [ 6] 2145         jsr     (0x8DDD)
   92B0 20 20 20 20 20 20  2146         .ascis  '                '
        20 20 20 20 20 20
        20 20 20 A0
                           2147 
   92C0 C6 01         [ 2] 2148         ldab    #0x01
   92C2 BD 8C 30      [ 6] 2149         jsr     (0x8C30)
   92C5 BD 8D 03      [ 6] 2150         jsr     (0x8D03)
   92C8 CE 93 D3      [ 3] 2151         ldx     #0x93D3
   92CB BD 95 04      [ 6] 2152         jsr     (0x9504)
   92CE 81 11         [ 2] 2153         cmpa    #0x11
   92D0 26 14         [ 3] 2154         bne     L92E6  
   92D2 BD 86 C4      [ 6] 2155         jsr     L86C4
   92D5 5F            [ 2] 2156         clrb
   92D6 D7 62         [ 3] 2157         stab    (0x0062)
   92D8 BD F9 C5      [ 6] 2158         jsr     (0xF9C5)
   92DB B6 18 04      [ 4] 2159         ldaa    (0x1804)
   92DE 84 BF         [ 2] 2160         anda    #0xBF
   92E0 B7 18 04      [ 4] 2161         staa    (0x1804)
   92E3 7E 81 D7      [ 3] 2162         jmp     (0x81D7)
   92E6                    2163 L92E6:
   92E6 81 03         [ 2] 2164         cmpa    #0x03
   92E8 25 09         [ 3] 2165         bcs     L92F3  
   92EA 81 08         [ 2] 2166         cmpa    #0x08
   92EC 24 05         [ 3] 2167         bcc     L92F3  
   92EE BD 8F 73      [ 6] 2168         jsr     (0x8F73)
   92F1 20 A2         [ 3] 2169         bra     L9295  
   92F3                    2170 L92F3:
   92F3 81 02         [ 2] 2171         cmpa    #0x02
   92F5 26 08         [ 3] 2172         bne     L92FF  
   92F7 BD 9F 1E      [ 6] 2173         jsr     (0x9F1E)
   92FA 25 99         [ 3] 2174         bcs     L9295  
   92FC 7E 96 75      [ 3] 2175         jmp     (0x9675)
   92FF                    2176 L92FF:
   92FF 81 0B         [ 2] 2177         cmpa    #0x0B
   9301 26 0D         [ 3] 2178         bne     L9310  
   9303 BD 8D 03      [ 6] 2179         jsr     (0x8D03)
   9306 BD 9E CC      [ 6] 2180         jsr     (0x9ECC)
   9309 C6 03         [ 2] 2181         ldab    #0x03
   930B BD 8C 30      [ 6] 2182         jsr     (0x8C30)
   930E 20 85         [ 3] 2183         bra     L9295  
   9310                    2184 L9310:
   9310 81 09         [ 2] 2185         cmpa    #0x09
   9312 26 0E         [ 3] 2186         bne     L9322  
   9314 BD 9F 1E      [ 6] 2187         jsr     (0x9F1E)
   9317 24 03         [ 3] 2188         bcc     L931C  
   9319 7E 92 95      [ 3] 2189         jmp     (0x9295)
   931C                    2190 L931C:
   931C BD 9E 92      [ 6] 2191         jsr     (0x9E92)     ; reset R counts
   931F 7E 92 95      [ 3] 2192         jmp     (0x9295)
   9322                    2193 L9322:
   9322 81 0A         [ 2] 2194         cmpa    #0x0A
   9324 26 0B         [ 3] 2195         bne     L9331  
   9326 BD 9F 1E      [ 6] 2196         jsr     (0x9F1E)
   9329 25 03         [ 3] 2197         bcs     L932E  
   932B BD 9E AF      [ 6] 2198         jsr     (0x9EAF)     ; reset L counts
   932E                    2199 L932E:
   932E 7E 92 95      [ 3] 2200         jmp     (0x9295)
   9331                    2201 L9331:
   9331 81 01         [ 2] 2202         cmpa    #0x01
   9333 26 03         [ 3] 2203         bne     L9338  
   9335 7E A0 E9      [ 3] 2204         jmp     (0xA0E9)
   9338                    2205 L9338:
   9338 81 08         [ 2] 2206         cmpa    #0x08
   933A 26 1F         [ 3] 2207         bne     L935B  
   933C BD 9F 1E      [ 6] 2208         jsr     (0x9F1E)
   933F 25 1A         [ 3] 2209         bcs     L935B  
                           2210 
   9341 BD 8D E4      [ 6] 2211         jsr     (0x8DE4)
   9344 52 65 73 65 74 20  2212         .ascis  'Reset System!'
        53 79 73 74 65 6D
        A1
                           2213 
   9351 7E A2 49      [ 3] 2214         jmp     (0xA249)
   9354 C6 02         [ 2] 2215         ldab    #0x02
   9356 BD 8C 30      [ 6] 2216         jsr     (0x8C30)
   9359 20 18         [ 3] 2217         bra     L9373  
   935B                    2218 L935B:
   935B 81 0C         [ 2] 2219         cmpa    #0x0C
   935D 26 14         [ 3] 2220         bne     L9373  
   935F BD 8B 48      [ 6] 2221         jsr     (0x8B48)
   9362 5F            [ 2] 2222         clrb
   9363 D7 62         [ 3] 2223         stab    (0x0062)
   9365 BD F9 C5      [ 6] 2224         jsr     (0xF9C5)
   9368 B6 18 04      [ 4] 2225         ldaa    (0x1804)
   936B 84 BF         [ 2] 2226         anda    #0xBF
   936D B7 18 04      [ 4] 2227         staa    (0x1804)
   9370 7E 92 92      [ 3] 2228         jmp     (0x9292)
   9373                    2229 L9373:
   9373 81 0D         [ 2] 2230         cmpa    #0x0D
   9375 26 2E         [ 3] 2231         bne     L93A5  
   9377 BD 8C E9      [ 6] 2232         jsr     (0x8CE9)
                           2233 
   937A BD 8D E4      [ 6] 2234         jsr     (0x8DE4)
   937D 20 20 42 75 74 74  2235         .ascis  '  Button  test'
        6F 6E 20 20 74 65
        73 F4
                           2236 
   938B BD 8D DD      [ 6] 2237         jsr     (0x8DDD)
   938E 20 20 20 50 52 4F  2238         .ascis  '   PROG exits'
        47 20 65 78 69 74
        F3
                           2239 
   939B BD A5 26      [ 6] 2240         jsr     (0xA526)
   939E 5F            [ 2] 2241         clrb
   939F BD F9 C5      [ 6] 2242         jsr     (0xF9C5)
   93A2 7E 92 95      [ 3] 2243         jmp     (0x9295)
   93A5                    2244 L93A5:
   93A5 81 0E         [ 2] 2245         cmpa    #0x0E
   93A7 26 10         [ 3] 2246         bne     L93B9  
   93A9 BD 9F 1E      [ 6] 2247         jsr     (0x9F1E)
   93AC 24 03         [ 3] 2248         bcc     L93B1  
   93AE 7E 92 95      [ 3] 2249         jmp     (0x9295)
   93B1                    2250 L93B1:
   93B1 C6 01         [ 2] 2251         ldab    #0x01
   93B3 BD 8C 30      [ 6] 2252         jsr     (0x8C30)
   93B6 7E 94 9A      [ 3] 2253         jmp     (0x949A)
   93B9                    2254 L93B9:
   93B9 81 0F         [ 2] 2255         cmpa    #0x0F
   93BB 26 06         [ 3] 2256         bne     L93C3  
   93BD BD A8 6A      [ 6] 2257         jsr     (0xA86A)
   93C0 7E 92 95      [ 3] 2258         jmp     (0x9295)
   93C3                    2259 L93C3:
   93C3 81 10         [ 2] 2260         cmpa    #0x10
   93C5 26 09         [ 3] 2261         bne     L93D0  
   93C7 BD 9F 1E      [ 6] 2262         jsr     (0x9F1E)
   93CA BD 95 BA      [ 6] 2263         jsr     (0x95BA)
   93CD 7E 92 95      [ 3] 2264         jmp     (0x9295)
                           2265 
   93D0                    2266 L93D0:
   93D0 7E 92 D2      [ 3] 2267         jmp     (0x92D2)
                           2268 
   93D3 56 43 52 20 61 64  2269         .ascis  "VCR adjust,Set Random,Chuck E. Cheese,Jasper,Pasqually,Munch,Helen,Reset System,Reset reg tape#,Reset liv tape#,View Tape #'s,All Lights On,Button test,King enable,Warm-Up,Show Type,Quit Diagnostics"
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
   9499 00                 2270         .byte   0x00
                           2271 
   949A 7D 04 2A      [ 6] 2272         tst     (0x042A)
   949D 27 27         [ 3] 2273         beq     L94C6  
                           2274 
   949F BD 8D E4      [ 6] 2275         jsr     (0x8DE4)
   94A2 4B 69 6E 67 20 69  2276         .ascis  'King is Enabled'
        73 20 45 6E 61 62
        6C 65 E4
                           2277 
   94B1 BD 8D DD      [ 6] 2278         jsr     (0x8DDD)
   94B4 45 4E 54 45 52 20  2279         .ascis  'ENTER to disable'
        74 6F 20 64 69 73
        61 62 6C E5
                           2280 
   94C4 20 25         [ 3] 2281         bra     L94EB  
                           2282 
   94C6                    2283 L94C6:
   94C6 BD 8D E4      [ 6] 2284         jsr     (0x8DE4)
   94C9 4B 69 6E 67 20 69  2285         .ascis  'King is Disabled'
        73 20 44 69 73 61
        62 6C 65 E4
                           2286 
   94D9 BD 8D DD      [ 6] 2287         jsr     (0x8DDD)
   94DC 45 4E 54 45 52 20  2288         .ascis  'ENTER to enable'
        74 6F 20 65 6E 61
        62 6C E5
                           2289 
   94EB                    2290 L94EB:
   94EB BD 8E 95      [ 6] 2291         jsr     (0x8E95)
   94EE 4D            [ 2] 2292         tsta
   94EF 27 FA         [ 3] 2293         beq     L94EB  
   94F1 81 0D         [ 2] 2294         cmpa    #0x0D
   94F3 27 02         [ 3] 2295         beq     L94F7  
   94F5 20 0A         [ 3] 2296         bra     L9501  
   94F7                    2297 L94F7:
   94F7 B6 04 2A      [ 4] 2298         ldaa    (0x042A)
   94FA 84 01         [ 2] 2299         anda    #0x01
   94FC 88 01         [ 2] 2300         eora    #0x01
   94FE B7 04 2A      [ 4] 2301         staa    (0x042A)
   9501                    2302 L9501:
   9501 7E 92 95      [ 3] 2303         jmp     (0x9295)
   9504 86 01         [ 2] 2304         ldaa    #0x01
   9506 97 A6         [ 3] 2305         staa    (0x00A6)
   9508 97 A7         [ 3] 2306         staa    (0x00A7)
   950A DF 12         [ 4] 2307         stx     (0x0012)
   950C 20 09         [ 3] 2308         bra     L9517  
   950E 86 01         [ 2] 2309         ldaa    #0x01
   9510 97 A7         [ 3] 2310         staa    (0x00A7)
   9512 7F 00 A6      [ 6] 2311         clr     (0x00A6)
   9515 DF 12         [ 4] 2312         stx     (0x0012)
   9517                    2313 L9517:
   9517 7F 00 16      [ 6] 2314         clr     (0x0016)
   951A 18 DE 46      [ 5] 2315         ldy     (0x0046)
   951D 7D 00 A6      [ 6] 2316         tst     (0x00A6)
   9520 26 07         [ 3] 2317         bne     L9529  
   9522 BD 8C F2      [ 6] 2318         jsr     (0x8CF2)
   9525 86 80         [ 2] 2319         ldaa    #0x80
   9527 20 05         [ 3] 2320         bra     L952E  
   9529                    2321 L9529:
   9529 BD 8D 03      [ 6] 2322         jsr     (0x8D03)
   952C 86 C0         [ 2] 2323         ldaa    #0xC0
   952E                    2324 L952E:
   952E 18 A7 00      [ 5] 2325         staa    0,Y     
   9531 18 6F 01      [ 7] 2326         clr     1,Y     
   9534 18 08         [ 4] 2327         iny
   9536 18 08         [ 4] 2328         iny
   9538 18 8C 05 80   [ 5] 2329         cpy     #0x0580
   953C 25 04         [ 3] 2330         bcs     L9542  
   953E 18 CE 05 00   [ 4] 2331         ldy     #0x0500
   9542                    2332 L9542:
   9542 DF 14         [ 4] 2333         stx     (0x0014)
   9544                    2334 L9544:
   9544 A6 00         [ 4] 2335         ldaa    0,X     
   9546 2A 04         [ 3] 2336         bpl     L954C  
   9548 C6 01         [ 2] 2337         ldab    #0x01
   954A D7 16         [ 3] 2338         stab    (0x0016)
   954C                    2339 L954C:
   954C 81 2C         [ 2] 2340         cmpa    #0x2C
   954E 27 1E         [ 3] 2341         beq     L956E  
   9550 18 6F 00      [ 7] 2342         clr     0,Y     
   9553 84 7F         [ 2] 2343         anda    #0x7F
   9555 18 A7 01      [ 5] 2344         staa    1,Y     
   9558 18 08         [ 4] 2345         iny
   955A 18 08         [ 4] 2346         iny
   955C 18 8C 05 80   [ 5] 2347         cpy     #0x0580
   9560 25 04         [ 3] 2348         bcs     L9566  
   9562 18 CE 05 00   [ 4] 2349         ldy     #0x0500
   9566                    2350 L9566:
   9566 7D 00 16      [ 6] 2351         tst     (0x0016)
   9569 26 03         [ 3] 2352         bne     L956E  
   956B 08            [ 3] 2353         inx
   956C 20 D6         [ 3] 2354         bra     L9544  
   956E                    2355 L956E:
   956E 08            [ 3] 2356         inx
   956F 86 01         [ 2] 2357         ldaa    #0x01
   9571 97 43         [ 3] 2358         staa    (0x0043)
   9573 18 6F 00      [ 7] 2359         clr     0,Y     
   9576 18 6F 01      [ 7] 2360         clr     1,Y     
   9579 18 DF 46      [ 5] 2361         sty     (0x0046)
   957C                    2362 L957C:
   957C BD 8E 95      [ 6] 2363         jsr     (0x8E95)
   957F 27 FB         [ 3] 2364         beq     L957C  
   9581 81 02         [ 2] 2365         cmpa    #0x02
   9583 26 0A         [ 3] 2366         bne     L958F  
   9585 7D 00 16      [ 6] 2367         tst     (0x0016)
   9588 26 05         [ 3] 2368         bne     L958F  
   958A 7C 00 A7      [ 6] 2369         inc     (0x00A7)
   958D 20 88         [ 3] 2370         bra     L9517  
   958F                    2371 L958F:
   958F 81 01         [ 2] 2372         cmpa    #0x01
   9591 26 20         [ 3] 2373         bne     L95B3  
   9593 18 DE 14      [ 5] 2374         ldy     (0x0014)
   9596 18 9C 12      [ 6] 2375         cpy     (0x0012)
   9599 23 E1         [ 3] 2376         bls     L957C  
   959B 7A 00 A7      [ 6] 2377         dec     (0x00A7)
   959E DE 14         [ 4] 2378         ldx     (0x0014)
   95A0 09            [ 3] 2379         dex
   95A1                    2380 L95A1:
   95A1 09            [ 3] 2381         dex
   95A2 9C 12         [ 5] 2382         cpx     (0x0012)
   95A4 26 03         [ 3] 2383         bne     L95A9  
   95A6 7E 95 17      [ 3] 2384         jmp     (0x9517)
   95A9                    2385 L95A9:
   95A9 A6 00         [ 4] 2386         ldaa    0,X     
   95AB 81 2C         [ 2] 2387         cmpa    #0x2C
   95AD 26 F2         [ 3] 2388         bne     L95A1  
   95AF 08            [ 3] 2389         inx
   95B0 7E 95 17      [ 3] 2390         jmp     (0x9517)
   95B3                    2391 L95B3:
   95B3 81 0D         [ 2] 2392         cmpa    #0x0D
   95B5 26 C5         [ 3] 2393         bne     L957C  
   95B7 96 A7         [ 3] 2394         ldaa    (0x00A7)
   95B9 39            [ 5] 2395         rts
                           2396 
   95BA B6 04 5C      [ 4] 2397         ldaa    (0x045C)
   95BD 27 14         [ 3] 2398         beq     L95D3  
                           2399 
   95BF BD 8D E4      [ 6] 2400         jsr     (0x8DE4)
   95C2 43 75 72 72 65 6E  2401         .ascis  'Current: CNR   '
        74 3A 20 43 4E 52
        20 20 A0
                           2402 
   95D1 20 12         [ 3] 2403         bra     L95E5  
                           2404 
   95D3                    2405 L95D3:
   95D3 BD 8D E4      [ 6] 2406         jsr     (0x8DE4)
   95D6 43 75 72 72 65 6E  2407         .ascis  'Current: R12   '
        74 3A 20 52 31 32
        20 20 A0
                           2408 
   95E5                    2409 L95E5:
   95E5 BD 8D DD      [ 6] 2410         jsr     (0x8DDD)
   95E8 3C 45 6E 74 65 72  2411         .ascis  '<Enter> to chg.'
        3E 20 74 6F 20 63
        68 67 AE
                           2412 
   95F7                    2413 L95F7:
   95F7 BD 8E 95      [ 6] 2414         jsr     (0x8E95)
   95FA 27 FB         [ 3] 2415         beq     L95F7  
   95FC 81 0D         [ 2] 2416         cmpa    #0x0D
   95FE 26 0F         [ 3] 2417         bne     L960F  
   9600 B6 04 5C      [ 4] 2418         ldaa    (0x045C)
   9603 27 05         [ 3] 2419         beq     L960A  
   9605 7F 04 5C      [ 6] 2420         clr     (0x045C)
   9608 20 05         [ 3] 2421         bra     L960F  
   960A                    2422 L960A:
   960A 86 01         [ 2] 2423         ldaa    #0x01
   960C B7 04 5C      [ 4] 2424         staa    (0x045C)
   960F                    2425 L960F:
   960F 39            [ 5] 2426         rts
                           2427 
   9610 43 68 75 63 6B 2C  2428         .ascis  "Chuck,Jasper,Pasqually,Munch,Helen,Light 1,Light 2,Light 3,Star EFX,Wink Spot,Gobo,Clear All Rnd,Exit"
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
                           2429 
                           2430 ; code again
   9675 BD 8D E4      [ 6] 2431         jsr     (0x8DE4)
   9678 52 61 6E 64 6F 6D  2432         .ascis  'Random          '
        20 20 20 20 20 20
        20 20 20 A0
                           2433 
   9688 CE 96 10      [ 3] 2434         ldx     #0x9610
   968B BD 95 04      [ 6] 2435         jsr     (0x9504)
   968E 5F            [ 2] 2436         clrb
   968F 37            [ 3] 2437         pshb
   9690 81 0D         [ 2] 2438         cmpa    #0x0D
   9692 26 03         [ 3] 2439         bne     L9697  
   9694 7E 97 5B      [ 3] 2440         jmp     (0x975B)
   9697                    2441 L9697:
   9697 81 0C         [ 2] 2442         cmpa    #0x0C
   9699 26 21         [ 3] 2443         bne     L96BC  
   969B 7F 04 01      [ 6] 2444         clr     (0x0401)
   969E 7F 04 2B      [ 6] 2445         clr     (0x042B)
                           2446 
   96A1 BD 8D E4      [ 6] 2447         jsr     (0x8DE4)
   96A4 41 6C 6C 20 52 6E  2448         .ascis  'All Rnd Cleared!'
        64 20 43 6C 65 61
        72 65 64 A1
                           2449 
   96B4 C6 64         [ 2] 2450         ldab    #0x64
   96B6 BD 8C 22      [ 6] 2451         jsr     (0x8C22)
   96B9 7E 97 5B      [ 3] 2452         jmp     (0x975B)
   96BC                    2453 L96BC:
   96BC 81 09         [ 2] 2454         cmpa    #0x09
   96BE 25 05         [ 3] 2455         bcs     L96C5  
   96C0 80 08         [ 2] 2456         suba    #0x08
   96C2 33            [ 4] 2457         pulb
   96C3 5C            [ 2] 2458         incb
   96C4 37            [ 3] 2459         pshb
   96C5                    2460 L96C5:
   96C5 5F            [ 2] 2461         clrb
   96C6 0D            [ 2] 2462         sec
   96C7                    2463 L96C7:
   96C7 59            [ 2] 2464         rolb
   96C8 4A            [ 2] 2465         deca
   96C9 26 FC         [ 3] 2466         bne     L96C7  
   96CB D7 12         [ 3] 2467         stab    (0x0012)
   96CD C8 FF         [ 2] 2468         eorb    #0xFF
   96CF D7 13         [ 3] 2469         stab    (0x0013)
   96D1                    2470 L96D1:
   96D1 CC 20 34      [ 3] 2471         ldd     #0x2034           ;' '
   96D4 BD 8D B5      [ 6] 2472         jsr     (0x8DB5)         ; display char here on LCD display
   96D7 33            [ 4] 2473         pulb
   96D8 37            [ 3] 2474         pshb
   96D9 5D            [ 2] 2475         tstb
   96DA 27 05         [ 3] 2476         beq     L96E1  
   96DC B6 04 2B      [ 4] 2477         ldaa    (0x042B)
   96DF 20 03         [ 3] 2478         bra     L96E4  
   96E1                    2479 L96E1:
   96E1 B6 04 01      [ 4] 2480         ldaa    (0x0401)
   96E4                    2481 L96E4:
   96E4 94 12         [ 3] 2482         anda    (0x0012)
   96E6 27 0A         [ 3] 2483         beq     L96F2  
   96E8 18 DE 46      [ 5] 2484         ldy     (0x0046)
   96EB BD 8D FD      [ 6] 2485         jsr     (0x8DFD)
   96EE 4F            [ 2] 2486         clra
   96EF EE 20         [ 5] 2487         ldx     0x20,X
   96F1 09            [ 3] 2488         dex
   96F2                    2489 L96F2:
   96F2 18 DE 46      [ 5] 2490         ldy     (0x0046)
   96F5 BD 8D FD      [ 6] 2491         jsr     (0x8DFD)
   96F8 4F            [ 2] 2492         clra
   96F9 66 E6         [ 6] 2493         ror     0xE6,X
   96FB CC 20 34      [ 3] 2494         ldd     #0x2034           ;' '
   96FE BD 8D B5      [ 6] 2495         jsr     (0x8DB5)         ; display char here on LCD display
   9701                    2496 L9701:
   9701 BD 8E 95      [ 6] 2497         jsr     (0x8E95)
   9704 27 FB         [ 3] 2498         beq     L9701  
   9706 81 01         [ 2] 2499         cmpa    #0x01
   9708 26 22         [ 3] 2500         bne     L972C  
   970A 33            [ 4] 2501         pulb
   970B 37            [ 3] 2502         pshb
   970C 5D            [ 2] 2503         tstb
   970D 27 0A         [ 3] 2504         beq     L9719  
   970F B6 04 2B      [ 4] 2505         ldaa    (0x042B)
   9712 9A 12         [ 3] 2506         oraa    (0x0012)
   9714 B7 04 2B      [ 4] 2507         staa    (0x042B)
   9717 20 08         [ 3] 2508         bra     L9721  
   9719                    2509 L9719:
   9719 B6 04 01      [ 4] 2510         ldaa    (0x0401)
   971C 9A 12         [ 3] 2511         oraa    (0x0012)
   971E B7 04 01      [ 4] 2512         staa    (0x0401)
   9721                    2513 L9721:
   9721 18 DE 46      [ 5] 2514         ldy     (0x0046)
   9724 BD 8D FD      [ 6] 2515         jsr     (0x8DFD)
   9727 4F            [ 2] 2516         clra
   9728 6E A0         [ 3] 2517         jmp     0xA0,X
   972A 20 A5         [ 3] 2518         bra     L96D1  
   972C                    2519 L972C:
   972C 81 02         [ 2] 2520         cmpa    #0x02
   972E 26 23         [ 3] 2521         bne     L9753  
   9730 33            [ 4] 2522         pulb
   9731 37            [ 3] 2523         pshb
   9732 5D            [ 2] 2524         tstb
   9733 27 0A         [ 3] 2525         beq     L973F  
   9735 B6 04 2B      [ 4] 2526         ldaa    (0x042B)
   9738 94 13         [ 3] 2527         anda    (0x0013)
   973A B7 04 2B      [ 4] 2528         staa    (0x042B)
   973D 20 08         [ 3] 2529         bra     L9747  
   973F                    2530 L973F:
   973F B6 04 01      [ 4] 2531         ldaa    (0x0401)
   9742 94 13         [ 3] 2532         anda    (0x0013)
   9744 B7 04 01      [ 4] 2533         staa    (0x0401)
   9747                    2534 L9747:
   9747 18 DE 46      [ 5] 2535         ldy     (0x0046)
   974A BD 8D FD      [ 6] 2536         jsr     (0x8DFD)
   974D 4F            [ 2] 2537         clra
   974E 66 E6         [ 6] 2538         ror     0xE6,X
   9750 7E 96 D1      [ 3] 2539         jmp     (0x96D1)
   9753                    2540 L9753:
   9753 81 0D         [ 2] 2541         cmpa    #0x0D
   9755 26 AA         [ 3] 2542         bne     L9701  
   9757 33            [ 4] 2543         pulb
   9758 7E 96 75      [ 3] 2544         jmp     (0x9675)
   975B 33            [ 4] 2545         pulb
   975C 7E 92 92      [ 3] 2546         jmp     (0x9292)
                           2547 
                           2548 ; do program rom checksum, and display it on the LCD screen
   975F CE 00 00      [ 3] 2549         ldx     #0x0000
   9762 18 CE 80 00   [ 4] 2550         ldy     #0x8000
   9766                    2551 L9766:
   9766 18 E6 00      [ 5] 2552         ldab    0,Y     
   9769 18 08         [ 4] 2553         iny
   976B 3A            [ 3] 2554         abx
   976C 18 8C 00 00   [ 5] 2555         cpy     #0x0000
   9770 26 F4         [ 3] 2556         bne     L9766  
   9772 DF 17         [ 4] 2557         stx     (0x0017)         ; store rom checksum here
   9774 96 17         [ 3] 2558         ldaa    (0x0017)        ; get high byte of checksum
   9776 BD 97 9B      [ 6] 2559         jsr     (0x979B)         ; convert it to 2 hex chars
   9779 96 12         [ 3] 2560         ldaa    (0x0012)
   977B C6 33         [ 2] 2561         ldab    #0x33
   977D BD 8D B5      [ 6] 2562         jsr     (0x8DB5)         ; display char 1 here on LCD display
   9780 96 13         [ 3] 2563         ldaa    (0x0013)
   9782 C6 34         [ 2] 2564         ldab    #0x34
   9784 BD 8D B5      [ 6] 2565         jsr     (0x8DB5)         ; display char 2 here on LCD display
   9787 96 18         [ 3] 2566         ldaa    (0x0018)        ; get low byte of checksum
   9789 BD 97 9B      [ 6] 2567         jsr     (0x979B)         ; convert it to 2 hex chars
   978C 96 12         [ 3] 2568         ldaa    (0x0012)
   978E C6 35         [ 2] 2569         ldab    #0x35
   9790 BD 8D B5      [ 6] 2570         jsr     (0x8DB5)         ; display char 1 here on LCD display
   9793 96 13         [ 3] 2571         ldaa    (0x0013)
   9795 C6 36         [ 2] 2572         ldab    #0x36
   9797 BD 8D B5      [ 6] 2573         jsr     (0x8DB5)         ; display char 2 here on LCD display
   979A 39            [ 5] 2574         rts
                           2575 
                           2576 ; convert A to ASCII hex digit, store in (0x0012:0x0013)
   979B 36            [ 3] 2577         psha
   979C 84 0F         [ 2] 2578         anda    #0x0F
   979E 8B 30         [ 2] 2579         adda    #0x30
   97A0 81 39         [ 2] 2580         cmpa    #0x39
   97A2 23 02         [ 3] 2581         bls     L97A6  
   97A4 8B 07         [ 2] 2582         adda    #0x07
   97A6                    2583 L97A6:
   97A6 97 13         [ 3] 2584         staa    (0x0013)
   97A8 32            [ 4] 2585         pula
   97A9 84 F0         [ 2] 2586         anda    #0xF0
   97AB 44            [ 2] 2587         lsra
   97AC 44            [ 2] 2588         lsra
   97AD 44            [ 2] 2589         lsra
   97AE 44            [ 2] 2590         lsra
   97AF 8B 30         [ 2] 2591         adda    #0x30
   97B1 81 39         [ 2] 2592         cmpa    #0x39
   97B3 23 02         [ 3] 2593         bls     L97B7  
   97B5 8B 07         [ 2] 2594         adda    #0x07
   97B7                    2595 L97B7:
   97B7 97 12         [ 3] 2596         staa    (0x0012)
   97B9 39            [ 5] 2597         rts
                           2598 
   97BA BD 9D 18      [ 6] 2599         jsr     (0x9D18)
   97BD 24 03         [ 3] 2600         bcc     L97C2  
   97BF 7E 9A 7F      [ 3] 2601         jmp     (0x9A7F)
   97C2                    2602 L97C2:
   97C2 7D 00 79      [ 6] 2603         tst     (0x0079)
   97C5 26 0B         [ 3] 2604         bne     L97D2  
   97C7 FC 04 10      [ 5] 2605         ldd     (0x0410)
   97CA C3 00 01      [ 4] 2606         addd    #0x0001
   97CD FD 04 10      [ 5] 2607         std     (0x0410)
   97D0 20 09         [ 3] 2608         bra     L97DB  
   97D2                    2609 L97D2:
   97D2 FC 04 12      [ 5] 2610         ldd     (0x0412)
   97D5 C3 00 01      [ 4] 2611         addd    #0x0001
   97D8 FD 04 12      [ 5] 2612         std     (0x0412)
   97DB                    2613 L97DB:
   97DB 86 78         [ 2] 2614         ldaa    #0x78
   97DD 97 63         [ 3] 2615         staa    (0x0063)
   97DF 97 64         [ 3] 2616         staa    (0x0064)
   97E1 BD A3 13      [ 6] 2617         jsr     (0xA313)
   97E4 BD AA DB      [ 6] 2618         jsr     (0xAADB)
   97E7 86 01         [ 2] 2619         ldaa    #0x01
   97E9 97 4E         [ 3] 2620         staa    (0x004E)
   97EB 97 76         [ 3] 2621         staa    (0x0076)
   97ED 7F 00 75      [ 6] 2622         clr     (0x0075)
   97F0 7F 00 77      [ 6] 2623         clr     (0x0077)
   97F3 BD 87 AE      [ 6] 2624         jsr     (0x87AE)
   97F6 D6 7B         [ 3] 2625         ldab    (0x007B)
   97F8 CA 20         [ 2] 2626         orab    #0x20
   97FA C4 F7         [ 2] 2627         andb    #0xF7
   97FC BD 87 48      [ 6] 2628         jsr     (0x8748)
   97FF 7E 85 A4      [ 3] 2629         jmp     (0x85A4)
   9802 7F 00 76      [ 6] 2630         clr     (0x0076)
   9805 7F 00 75      [ 6] 2631         clr     (0x0075)
   9808 7F 00 77      [ 6] 2632         clr     (0x0077)
   980B 7F 00 4E      [ 6] 2633         clr     (0x004E)
   980E D6 7B         [ 3] 2634         ldab    (0x007B)
   9810 CA 0C         [ 2] 2635         orab    #0x0C
   9812 BD 87 48      [ 6] 2636         jsr     (0x8748)
   9815 BD A3 1E      [ 6] 2637         jsr     (0xA31E)
   9818 BD 86 C4      [ 6] 2638         jsr     L86C4
   981B BD 9C 51      [ 6] 2639         jsr     (0x9C51)
   981E BD 8E 95      [ 6] 2640         jsr     (0x8E95)
   9821 7E 84 4D      [ 3] 2641         jmp     (0x844D)
   9824 BD 9C 51      [ 6] 2642         jsr     (0x9C51)
   9827 7F 00 4E      [ 6] 2643         clr     (0x004E)
   982A D6 7B         [ 3] 2644         ldab    (0x007B)
   982C CA 24         [ 2] 2645         orab    #0x24
   982E C4 F7         [ 2] 2646         andb    #0xF7
   9830 BD 87 48      [ 6] 2647         jsr     (0x8748)
   9833 BD 87 AE      [ 6] 2648         jsr     (0x87AE)
   9836 BD 8E 95      [ 6] 2649         jsr     (0x8E95)
   9839 7E 84 4D      [ 3] 2650         jmp     (0x844D)
   983C 7F 00 78      [ 6] 2651         clr     (0x0078)
   983F B6 10 8A      [ 4] 2652         ldaa    (0x108A)
   9842 84 F9         [ 2] 2653         anda    #0xF9
   9844 B7 10 8A      [ 4] 2654         staa    (0x108A)
   9847 7D 00 AF      [ 6] 2655         tst     (0x00AF)
   984A 26 61         [ 3] 2656         bne     L98AD  
   984C 96 62         [ 3] 2657         ldaa    (0x0062)
   984E 84 01         [ 2] 2658         anda    #0x01
   9850 27 5B         [ 3] 2659         beq     L98AD  
   9852 C6 FD         [ 2] 2660         ldab    #0xFD
   9854 BD 86 E7      [ 6] 2661         jsr     (0x86E7)
   9857 CC 00 32      [ 3] 2662         ldd     #0x0032
   985A DD 1B         [ 4] 2663         std     CDTIMR1
   985C CC 75 30      [ 3] 2664         ldd     #0x7530
   985F DD 1D         [ 4] 2665         std     CDTIMR2
   9861 7F 00 5A      [ 6] 2666         clr     (0x005A)
   9864                    2667 L9864:
   9864 BD 9B 19      [ 6] 2668         jsr     (0x9B19)
   9867 7D 00 31      [ 6] 2669         tst     (0x0031)
   986A 26 04         [ 3] 2670         bne     L9870  
   986C 96 5A         [ 3] 2671         ldaa    (0x005A)
   986E 27 19         [ 3] 2672         beq     L9889  
   9870                    2673 L9870:
   9870 7F 00 31      [ 6] 2674         clr     (0x0031)
   9873 D6 62         [ 3] 2675         ldab    (0x0062)
   9875 C4 FE         [ 2] 2676         andb    #0xFE
   9877 D7 62         [ 3] 2677         stab    (0x0062)
   9879 BD F9 C5      [ 6] 2678         jsr     (0xF9C5)
   987C BD AA 13      [ 6] 2679         jsr     (0xAA13)
   987F C6 FB         [ 2] 2680         ldab    #0xFB
   9881 BD 86 E7      [ 6] 2681         jsr     (0x86E7)
   9884 7F 00 5A      [ 6] 2682         clr     (0x005A)
   9887 20 4B         [ 3] 2683         bra     L98D4  
   9889                    2684 L9889:
   9889 DC 1B         [ 4] 2685         ldd     CDTIMR1
   988B 26 D7         [ 3] 2686         bne     L9864  
   988D D6 62         [ 3] 2687         ldab    (0x0062)
   988F C8 01         [ 2] 2688         eorb    #0x01
   9891 D7 62         [ 3] 2689         stab    (0x0062)
   9893 BD F9 C5      [ 6] 2690         jsr     (0xF9C5)
   9896 C4 01         [ 2] 2691         andb    #0x01
   9898 26 05         [ 3] 2692         bne     L989F  
   989A BD AA 0C      [ 6] 2693         jsr     (0xAA0C)
   989D 20 03         [ 3] 2694         bra     L98A2  
   989F                    2695 L989F:
   989F BD AA 13      [ 6] 2696         jsr     (0xAA13)
   98A2                    2697 L98A2:
   98A2 CC 00 32      [ 3] 2698         ldd     #0x0032
   98A5 DD 1B         [ 4] 2699         std     CDTIMR1
   98A7 DC 1D         [ 4] 2700         ldd     CDTIMR2
   98A9 27 C5         [ 3] 2701         beq     L9870  
   98AB 20 B7         [ 3] 2702         bra     L9864  
   98AD                    2703 L98AD:
   98AD 7D 00 75      [ 6] 2704         tst     (0x0075)
   98B0 27 03         [ 3] 2705         beq     L98B5  
   98B2 7E 99 39      [ 3] 2706         jmp     (0x9939)
   98B5                    2707 L98B5:
   98B5 96 62         [ 3] 2708         ldaa    (0x0062)
   98B7 84 02         [ 2] 2709         anda    #0x02
   98B9 27 4E         [ 3] 2710         beq     L9909  
   98BB 7D 00 AF      [ 6] 2711         tst     (0x00AF)
   98BE 26 0B         [ 3] 2712         bne     L98CB  
   98C0 FC 04 24      [ 5] 2713         ldd     (0x0424)
   98C3 C3 00 01      [ 4] 2714         addd    #0x0001
   98C6 FD 04 24      [ 5] 2715         std     (0x0424)
   98C9 20 09         [ 3] 2716         bra     L98D4  
   98CB                    2717 L98CB:
   98CB FC 04 22      [ 5] 2718         ldd     (0x0422)
   98CE C3 00 01      [ 4] 2719         addd    #0x0001
   98D1 FD 04 22      [ 5] 2720         std     (0x0422)
   98D4                    2721 L98D4:
   98D4 FC 04 18      [ 5] 2722         ldd     (0x0418)
   98D7 C3 00 01      [ 4] 2723         addd    #0x0001
   98DA FD 04 18      [ 5] 2724         std     (0x0418)
   98DD 86 78         [ 2] 2725         ldaa    #0x78
   98DF 97 63         [ 3] 2726         staa    (0x0063)
   98E1 97 64         [ 3] 2727         staa    (0x0064)
   98E3 D6 62         [ 3] 2728         ldab    (0x0062)
   98E5 C4 F7         [ 2] 2729         andb    #0xF7
   98E7 CA 02         [ 2] 2730         orab    #0x02
   98E9 D7 62         [ 3] 2731         stab    (0x0062)
   98EB BD F9 C5      [ 6] 2732         jsr     (0xF9C5)
   98EE BD AA 18      [ 6] 2733         jsr     (0xAA18)
   98F1 86 01         [ 2] 2734         ldaa    #0x01
   98F3 97 4E         [ 3] 2735         staa    (0x004E)
   98F5 97 75         [ 3] 2736         staa    (0x0075)
   98F7 D6 7B         [ 3] 2737         ldab    (0x007B)
   98F9 C4 DF         [ 2] 2738         andb    #0xDF
   98FB BD 87 48      [ 6] 2739         jsr     (0x8748)
   98FE BD 87 AE      [ 6] 2740         jsr     (0x87AE)
   9901 BD A3 13      [ 6] 2741         jsr     (0xA313)
   9904 BD AA DB      [ 6] 2742         jsr     (0xAADB)
   9907 20 30         [ 3] 2743         bra     L9939  
   9909                    2744 L9909:
   9909 D6 62         [ 3] 2745         ldab    (0x0062)
   990B C4 F5         [ 2] 2746         andb    #0xF5
   990D CA 40         [ 2] 2747         orab    #0x40
   990F D7 62         [ 3] 2748         stab    (0x0062)
   9911 BD F9 C5      [ 6] 2749         jsr     (0xF9C5)
   9914 BD AA 1D      [ 6] 2750         jsr     (0xAA1D)
   9917 7D 00 AF      [ 6] 2751         tst     (0x00AF)
   991A 26 04         [ 3] 2752         bne     L9920  
   991C C6 01         [ 2] 2753         ldab    #0x01
   991E D7 B6         [ 3] 2754         stab    (0x00B6)
   9920                    2755 L9920:
   9920 BD 9C 51      [ 6] 2756         jsr     (0x9C51)
   9923 7F 00 4E      [ 6] 2757         clr     (0x004E)
   9926 7F 00 75      [ 6] 2758         clr     (0x0075)
   9929 86 01         [ 2] 2759         ldaa    #0x01
   992B 97 77         [ 3] 2760         staa    (0x0077)
   992D D6 7B         [ 3] 2761         ldab    (0x007B)
   992F CA 24         [ 2] 2762         orab    #0x24
   9931 C4 F7         [ 2] 2763         andb    #0xF7
   9933 BD 87 48      [ 6] 2764         jsr     (0x8748)
   9936 BD 87 91      [ 6] 2765         jsr     (0x8791)
   9939                    2766 L9939:
   9939 7F 00 AF      [ 6] 2767         clr     (0x00AF)
   993C 7E 85 A4      [ 3] 2768         jmp     (0x85A4)
   993F 7F 00 77      [ 6] 2769         clr     (0x0077)
   9942 BD 9C 51      [ 6] 2770         jsr     (0x9C51)
   9945 7F 00 4E      [ 6] 2771         clr     (0x004E)
   9948 D6 62         [ 3] 2772         ldab    (0x0062)
   994A C4 BF         [ 2] 2773         andb    #0xBF
   994C 7D 00 75      [ 6] 2774         tst     (0x0075)
   994F 27 02         [ 3] 2775         beq     L9953  
   9951 C4 FD         [ 2] 2776         andb    #0xFD
   9953                    2777 L9953:
   9953 D7 62         [ 3] 2778         stab    (0x0062)
   9955 BD F9 C5      [ 6] 2779         jsr     (0xF9C5)
   9958 BD AA 1D      [ 6] 2780         jsr     (0xAA1D)
   995B 7F 00 5B      [ 6] 2781         clr     (0x005B)
   995E BD 87 AE      [ 6] 2782         jsr     (0x87AE)
   9961 D6 7B         [ 3] 2783         ldab    (0x007B)
   9963 CA 20         [ 2] 2784         orab    #0x20
   9965 BD 87 48      [ 6] 2785         jsr     (0x8748)
   9968 7F 00 75      [ 6] 2786         clr     (0x0075)
   996B 7F 00 76      [ 6] 2787         clr     (0x0076)
   996E 7E 98 15      [ 3] 2788         jmp     (0x9815)
   9971 D6 7B         [ 3] 2789         ldab    (0x007B)
   9973 C4 FB         [ 2] 2790         andb    #0xFB
   9975 BD 87 48      [ 6] 2791         jsr     (0x8748)
   9978 7E 85 A4      [ 3] 2792         jmp     (0x85A4)
   997B D6 7B         [ 3] 2793         ldab    (0x007B)
   997D CA 04         [ 2] 2794         orab    #0x04
   997F BD 87 48      [ 6] 2795         jsr     (0x8748)
   9982 7E 85 A4      [ 3] 2796         jmp     (0x85A4)
   9985 D6 7B         [ 3] 2797         ldab    (0x007B)
   9987 C4 F7         [ 2] 2798         andb    #0xF7
   9989 BD 87 48      [ 6] 2799         jsr     (0x8748)
   998C 7E 85 A4      [ 3] 2800         jmp     (0x85A4)
   998F 7D 00 77      [ 6] 2801         tst     (0x0077)
   9992 26 07         [ 3] 2802         bne     L999B  
   9994 D6 7B         [ 3] 2803         ldab    (0x007B)
   9996 CA 08         [ 2] 2804         orab    #0x08
   9998 BD 87 48      [ 6] 2805         jsr     (0x8748)
   999B                    2806 L999B:
   999B 7E 85 A4      [ 3] 2807         jmp     (0x85A4)
   999E D6 7B         [ 3] 2808         ldab    (0x007B)
   99A0 C4 F3         [ 2] 2809         andb    #0xF3
   99A2 BD 87 48      [ 6] 2810         jsr     (0x8748)
   99A5 39            [ 5] 2811         rts
                           2812 
                           2813 ; main2
   99A6                    2814 L99A6:
   99A6 D6 7B         [ 3] 2815         ldab    (0x007B)
   99A8 C4 DF         [ 2] 2816         andb    #0xDF        ; clear bit 5
   99AA BD 87 48      [ 6] 2817         jsr     (0x8748)
   99AD BD 87 91      [ 6] 2818         jsr     (0x8791)
   99B0 39            [ 5] 2819         rts
                           2820 
   99B1 D6 7B         [ 3] 2821         ldab    (0x007B)
   99B3 CA 20         [ 2] 2822         orab    #0x20
   99B5 BD 87 48      [ 6] 2823         jsr     (0x8748)
   99B8 BD 87 AE      [ 6] 2824         jsr     (0x87AE)
   99BB 39            [ 5] 2825         rts
                           2826 
   99BC D6 7B         [ 3] 2827         ldab    (0x007B)
   99BE C4 DF         [ 2] 2828         andb    #0xDF
   99C0 BD 87 48      [ 6] 2829         jsr     (0x8748)
   99C3 BD 87 AE      [ 6] 2830         jsr     (0x87AE)
   99C6 39            [ 5] 2831         rts
                           2832 
   99C7 D6 7B         [ 3] 2833         ldab    (0x007B)
   99C9 CA 20         [ 2] 2834         orab    #0x20
   99CB BD 87 48      [ 6] 2835         jsr     (0x8748)
   99CE BD 87 91      [ 6] 2836         jsr     (0x8791)
   99D1 39            [ 5] 2837         rts
                           2838 
   99D2 86 01         [ 2] 2839         ldaa    #0x01
   99D4 97 78         [ 3] 2840         staa    (0x0078)
   99D6 7E 85 A4      [ 3] 2841         jmp     (0x85A4)
   99D9 CE 0E 20      [ 3] 2842         ldx     #0x0E20
   99DC A6 00         [ 4] 2843         ldaa    0,X     
   99DE 80 30         [ 2] 2844         suba    #0x30
   99E0 C6 0A         [ 2] 2845         ldab    #0x0A
   99E2 3D            [10] 2846         mul
   99E3 17            [ 2] 2847         tba
   99E4 C6 64         [ 2] 2848         ldab    #0x64
   99E6 3D            [10] 2849         mul
   99E7 DD 17         [ 4] 2850         std     (0x0017)
   99E9 A6 01         [ 4] 2851         ldaa    1,X     
   99EB 80 30         [ 2] 2852         suba    #0x30
   99ED C6 64         [ 2] 2853         ldab    #0x64
   99EF 3D            [10] 2854         mul
   99F0 D3 17         [ 5] 2855         addd    (0x0017)
   99F2 DD 17         [ 4] 2856         std     (0x0017)
   99F4 A6 02         [ 4] 2857         ldaa    2,X     
   99F6 80 30         [ 2] 2858         suba    #0x30
   99F8 C6 0A         [ 2] 2859         ldab    #0x0A
   99FA 3D            [10] 2860         mul
   99FB D3 17         [ 5] 2861         addd    (0x0017)
   99FD DD 17         [ 4] 2862         std     (0x0017)
   99FF 4F            [ 2] 2863         clra
   9A00 E6 03         [ 4] 2864         ldab    3,X     
   9A02 C0 30         [ 2] 2865         subb    #0x30
   9A04 D3 17         [ 5] 2866         addd    (0x0017)
   9A06 FD 02 9C      [ 5] 2867         std     (0x029C)
   9A09 CE 0E 20      [ 3] 2868         ldx     #0x0E20
   9A0C                    2869 L9A0C:
   9A0C A6 00         [ 4] 2870         ldaa    0,X     
   9A0E 81 30         [ 2] 2871         cmpa    #0x30
   9A10 25 13         [ 3] 2872         bcs     L9A25  
   9A12 81 39         [ 2] 2873         cmpa    #0x39
   9A14 22 0F         [ 3] 2874         bhi     L9A25  
   9A16 08            [ 3] 2875         inx
   9A17 8C 0E 24      [ 4] 2876         cpx     #0x0E24
   9A1A 26 F0         [ 3] 2877         bne     L9A0C  
   9A1C B6 0E 24      [ 4] 2878         ldaa    (0x0E24)        ; check EEPROM signature
   9A1F 81 DB         [ 2] 2879         cmpa    #0xDB
   9A21 26 02         [ 3] 2880         bne     L9A25  
   9A23 0C            [ 2] 2881         clc
   9A24 39            [ 5] 2882         rts
                           2883 
   9A25                    2884 L9A25:
   9A25 0D            [ 2] 2885         sec
   9A26 39            [ 5] 2886         rts
                           2887 
   9A27 BD 8D E4      [ 6] 2888         jsr     (0x8DE4)
   9A2A 53 65 72 69 61 6C  2889         .ascis  'Serial# '
        23 A0
                           2890 
   9A32 BD 8D DD      [ 6] 2891         jsr     (0x8DDD)
   9A35 20 20 20 20 20 20  2892         .ascis  '               '
        20 20 20 20 20 20
        20 20 A0
                           2893 
                           2894 ; display 4-digit serial number
   9A44 C6 08         [ 2] 2895         ldab    #0x08
   9A46 18 CE 0E 20   [ 4] 2896         ldy     #0x0E20
   9A4A                    2897 L9A4A:
   9A4A 18 A6 00      [ 5] 2898         ldaa    0,Y     
   9A4D 18 3C         [ 5] 2899         pshy
   9A4F 37            [ 3] 2900         pshb
   9A50 BD 8D B5      [ 6] 2901         jsr     (0x8DB5)         ; display char here on LCD display
   9A53 33            [ 4] 2902         pulb
   9A54 18 38         [ 6] 2903         puly
   9A56 5C            [ 2] 2904         incb
   9A57 18 08         [ 4] 2905         iny
   9A59 18 8C 0E 24   [ 5] 2906         cpy     #0x0E24
   9A5D 26 EB         [ 3] 2907         bne     L9A4A  
   9A5F 39            [ 5] 2908         rts
                           2909 
   9A60 86 01         [ 2] 2910         ldaa    #0x01
   9A62 97 B5         [ 3] 2911         staa    (0x00B5)
   9A64 96 4E         [ 3] 2912         ldaa    (0x004E)
   9A66 97 7F         [ 3] 2913         staa    (0x007F)
   9A68 96 62         [ 3] 2914         ldaa    (0x0062)
   9A6A 97 80         [ 3] 2915         staa    (0x0080)
   9A6C 96 7B         [ 3] 2916         ldaa    (0x007B)
   9A6E 97 81         [ 3] 2917         staa    (0x0081)
   9A70 96 7A         [ 3] 2918         ldaa    (0x007A)
   9A72 97 82         [ 3] 2919         staa    (0x0082)
   9A74 96 78         [ 3] 2920         ldaa    (0x0078)
   9A76 97 7D         [ 3] 2921         staa    (0x007D)
   9A78 B6 10 8A      [ 4] 2922         ldaa    (0x108A)
   9A7B 84 06         [ 2] 2923         anda    #0x06
   9A7D 97 7E         [ 3] 2924         staa    (0x007E)
   9A7F C6 EF         [ 2] 2925         ldab    #0xEF
   9A81 BD 86 E7      [ 6] 2926         jsr     (0x86E7)
   9A84 D6 7B         [ 3] 2927         ldab    (0x007B)
   9A86 CA 0C         [ 2] 2928         orab    #0x0C
   9A88 C4 DF         [ 2] 2929         andb    #0xDF
   9A8A BD 87 48      [ 6] 2930         jsr     (0x8748)
   9A8D BD 87 91      [ 6] 2931         jsr     (0x8791)
   9A90 BD 86 C4      [ 6] 2932         jsr     L86C4
   9A93 BD 9C 51      [ 6] 2933         jsr     (0x9C51)
   9A96 C6 06         [ 2] 2934         ldab    #0x06            ; delay 6 secs
   9A98 BD 8C 02      [ 6] 2935         jsr     (0x8C02)         ;
   9A9B BD 8E 95      [ 6] 2936         jsr     (0x8E95)
   9A9E BD 99 A6      [ 6] 2937         jsr     L99A6
   9AA1 7E 81 BD      [ 3] 2938         jmp     (0x81BD)
   9AA4 7F 00 5C      [ 6] 2939         clr     (0x005C)
   9AA7 86 01         [ 2] 2940         ldaa    #0x01
   9AA9 97 79         [ 3] 2941         staa    (0x0079)
   9AAB C6 FD         [ 2] 2942         ldab    #0xFD
   9AAD BD 86 E7      [ 6] 2943         jsr     (0x86E7)
   9AB0 BD 8E 95      [ 6] 2944         jsr     (0x8E95)
   9AB3 CC 75 30      [ 3] 2945         ldd     #0x7530
   9AB6 DD 1D         [ 4] 2946         std     CDTIMR2
   9AB8                    2947 L9AB8:
   9AB8 BD 9B 19      [ 6] 2948         jsr     (0x9B19)
   9ABB D6 62         [ 3] 2949         ldab    (0x0062)
   9ABD C8 04         [ 2] 2950         eorb    #0x04
   9ABF D7 62         [ 3] 2951         stab    (0x0062)
   9AC1 BD F9 C5      [ 6] 2952         jsr     (0xF9C5)
   9AC4 F6 18 04      [ 4] 2953         ldab    (0x1804)
   9AC7 C8 08         [ 2] 2954         eorb    #0x08
   9AC9 F7 18 04      [ 4] 2955         stab    (0x1804)
   9ACC 7D 00 5C      [ 6] 2956         tst     (0x005C)
   9ACF 26 12         [ 3] 2957         bne     L9AE3  
   9AD1 BD 8E 95      [ 6] 2958         jsr     (0x8E95)
   9AD4 81 0D         [ 2] 2959         cmpa    #0x0D
   9AD6 27 0B         [ 3] 2960         beq     L9AE3  
   9AD8 C6 32         [ 2] 2961         ldab    #0x32
   9ADA BD 8C 22      [ 6] 2962         jsr     (0x8C22)
   9ADD DC 1D         [ 4] 2963         ldd     CDTIMR2
   9ADF 27 02         [ 3] 2964         beq     L9AE3  
   9AE1 20 D5         [ 3] 2965         bra     L9AB8  
   9AE3                    2966 L9AE3:
   9AE3 D6 62         [ 3] 2967         ldab    (0x0062)
   9AE5 C4 FB         [ 2] 2968         andb    #0xFB
   9AE7 D7 62         [ 3] 2969         stab    (0x0062)
   9AE9 BD F9 C5      [ 6] 2970         jsr     (0xF9C5)
   9AEC BD A3 54      [ 6] 2971         jsr     (0xA354)
   9AEF C6 FB         [ 2] 2972         ldab    #0xFB
   9AF1 BD 86 E7      [ 6] 2973         jsr     (0x86E7)
   9AF4 7E 85 A4      [ 3] 2974         jmp     (0x85A4)
   9AF7 7F 00 75      [ 6] 2975         clr     (0x0075)
   9AFA 7F 00 76      [ 6] 2976         clr     (0x0076)
   9AFD 7F 00 77      [ 6] 2977         clr     (0x0077)
   9B00 7F 00 78      [ 6] 2978         clr     (0x0078)
   9B03 7F 00 25      [ 6] 2979         clr     (0x0025)
   9B06 7F 00 26      [ 6] 2980         clr     (0x0026)
   9B09 7F 00 4E      [ 6] 2981         clr     (0x004E)
   9B0C 7F 00 30      [ 6] 2982         clr     (0x0030)
   9B0F 7F 00 31      [ 6] 2983         clr     (0x0031)
   9B12 7F 00 32      [ 6] 2984         clr     (0x0032)
   9B15 7F 00 AF      [ 6] 2985         clr     (0x00AF)
   9B18 39            [ 5] 2986         rts
                           2987 
                           2988 ; validate a bunch of ram locations against bytes in ROM???
   9B19 36            [ 3] 2989         psha
   9B1A 37            [ 3] 2990         pshb
   9B1B 96 4E         [ 3] 2991         ldaa    (0x004E)
   9B1D 27 17         [ 3] 2992         beq     L9B36       ; go to 0401 logic
   9B1F 96 63         [ 3] 2993         ldaa    (0x0063)
   9B21 26 10         [ 3] 2994         bne     L9B33       ; exit
   9B23 7D 00 64      [ 6] 2995         tst     (0x0064)
   9B26 27 09         [ 3] 2996         beq     L9B31       ; go to 0401 logic
   9B28 BD 86 C4      [ 6] 2997         jsr     L86C4     ; do something with boards???
   9B2B BD 9C 51      [ 6] 2998         jsr     (0x9C51)     ; RTC stuff???
   9B2E 7F 00 64      [ 6] 2999         clr     (0x0064)
   9B31                    3000 L9B31:
   9B31 20 03         [ 3] 3001         bra     L9B36       ; go to 0401 logic
   9B33                    3002 L9B33:
   9B33 33            [ 4] 3003         pulb
   9B34 32            [ 4] 3004         pula
   9B35 39            [ 5] 3005         rts
                           3006 
                           3007 ; end up here immediately if:
                           3008 ; 0x004E == 00 or
                           3009 ; 0x0063, 0x0064 == 0 or
                           3010 ; 
                           3011 ; do subroutines based on bits 0-4 of 0x0401?
   9B36                    3012 L9B36:
   9B36 B6 04 01      [ 4] 3013         ldaa    (0x0401)
   9B39 84 01         [ 2] 3014         anda    #0x01
   9B3B 27 03         [ 3] 3015         beq     L9B40  
   9B3D BD 9B 6B      [ 6] 3016         jsr     (0x9B6B)     ; bit 0 routine
   9B40                    3017 L9B40:
   9B40 B6 04 01      [ 4] 3018         ldaa    (0x0401)
   9B43 84 02         [ 2] 3019         anda    #0x02
   9B45 27 03         [ 3] 3020         beq     L9B4A  
   9B47 BD 9B 99      [ 6] 3021         jsr     (0x9B99)     ; bit 1 routine
   9B4A                    3022 L9B4A:
   9B4A B6 04 01      [ 4] 3023         ldaa    (0x0401)
   9B4D 84 04         [ 2] 3024         anda    #0x04
   9B4F 27 03         [ 3] 3025         beq     L9B54  
   9B51 BD 9B C7      [ 6] 3026         jsr     (0x9BC7)     ; bit 2 routine
   9B54                    3027 L9B54:
   9B54 B6 04 01      [ 4] 3028         ldaa    (0x0401)
   9B57 84 08         [ 2] 3029         anda    #0x08
   9B59 27 03         [ 3] 3030         beq     L9B5E  
   9B5B BD 9B F5      [ 6] 3031         jsr     (0x9BF5)     ; bit 3 routine
   9B5E                    3032 L9B5E:
   9B5E B6 04 01      [ 4] 3033         ldaa    (0x0401)
   9B61 84 10         [ 2] 3034         anda    #0x10
   9B63 27 03         [ 3] 3035         beq     L9B68  
   9B65 BD 9C 23      [ 6] 3036         jsr     (0x9C23)     ; bit 4 routine
   9B68                    3037 L9B68:
   9B68 33            [ 4] 3038         pulb
   9B69 32            [ 4] 3039         pula
   9B6A 39            [ 5] 3040         rts
                           3041 
                           3042 ; bit 0 routine
   9B6B 18 3C         [ 5] 3043         pshy
   9B6D 18 DE 65      [ 5] 3044         ldy     (0x0065)
   9B70 18 A6 00      [ 5] 3045         ldaa    0,Y     
   9B73 81 FF         [ 2] 3046         cmpa    #0xFF
   9B75 27 14         [ 3] 3047         beq     L9B8B  
   9B77 91 70         [ 3] 3048         cmpa    OFFCNT1
   9B79 25 0D         [ 3] 3049         bcs     L9B88  
   9B7B 18 08         [ 4] 3050         iny
   9B7D 18 A6 00      [ 5] 3051         ldaa    0,Y     
   9B80 B7 10 80      [ 4] 3052         staa    (0x1080)
   9B83 18 08         [ 4] 3053         iny
   9B85 18 DF 65      [ 5] 3054         sty     (0x0065)
   9B88                    3055 L9B88:
   9B88 18 38         [ 6] 3056         puly
   9B8A 39            [ 5] 3057         rts
   9B8B                    3058 L9B8B:
   9B8B 18 CE B2 EB   [ 4] 3059         ldy     #0xB2EB
   9B8F 18 DF 65      [ 5] 3060         sty     (0x0065)
   9B92 86 FA         [ 2] 3061         ldaa    #0xFA
   9B94 97 70         [ 3] 3062         staa    OFFCNT1
   9B96 7E 9B 88      [ 3] 3063         jmp     (0x9B88)
   9B99 18 3C         [ 5] 3064         pshy
   9B9B 18 DE 67      [ 5] 3065         ldy     (0x0067)
   9B9E 18 A6 00      [ 5] 3066         ldaa    0,Y     
   9BA1 81 FF         [ 2] 3067         cmpa    #0xFF
   9BA3 27 14         [ 3] 3068         beq     L9BB9  
   9BA5 91 71         [ 3] 3069         cmpa    OFFCNT2
   9BA7 25 0D         [ 3] 3070         bcs     L9BB6  
   9BA9 18 08         [ 4] 3071         iny
   9BAB 18 A6 00      [ 5] 3072         ldaa    0,Y     
   9BAE B7 10 84      [ 4] 3073         staa    (0x1084)
   9BB1 18 08         [ 4] 3074         iny
   9BB3 18 DF 67      [ 5] 3075         sty     (0x0067)
   9BB6                    3076 L9BB6:
   9BB6 18 38         [ 6] 3077         puly
   9BB8 39            [ 5] 3078         rts
                           3079 
                           3080 ; bit 1 routine
   9BB9                    3081 L9BB9:
   9BB9 18 CE B3 BD   [ 4] 3082         ldy     #0xB3BD
   9BBD 18 DF 67      [ 5] 3083         sty     (0x0067)
   9BC0 86 E6         [ 2] 3084         ldaa    #0xE6
   9BC2 97 71         [ 3] 3085         staa    OFFCNT2
   9BC4 7E 9B B6      [ 3] 3086         jmp     (0x9BB6)
                           3087 
                           3088 ; bit 2 routine
   9BC7 18 3C         [ 5] 3089         pshy
   9BC9 18 DE 69      [ 5] 3090         ldy     (0x0069)
   9BCC 18 A6 00      [ 5] 3091         ldaa    0,Y     
   9BCF 81 FF         [ 2] 3092         cmpa    #0xFF
   9BD1 27 14         [ 3] 3093         beq     L9BE7  
   9BD3 91 72         [ 3] 3094         cmpa    OFFCNT3
   9BD5 25 0D         [ 3] 3095         bcs     L9BE4  
   9BD7 18 08         [ 4] 3096         iny
   9BD9 18 A6 00      [ 5] 3097         ldaa    0,Y     
   9BDC B7 10 88      [ 4] 3098         staa    (0x1088)
   9BDF 18 08         [ 4] 3099         iny
   9BE1 18 DF 69      [ 5] 3100         sty     (0x0069)
   9BE4                    3101 L9BE4:
   9BE4 18 38         [ 6] 3102         puly
   9BE6 39            [ 5] 3103         rts
   9BE7                    3104 L9BE7:
   9BE7 18 CE B5 31   [ 4] 3105         ldy     #0xB531
   9BEB 18 DF 69      [ 5] 3106         sty     (0x0069)
   9BEE 86 D2         [ 2] 3107         ldaa    #0xD2
   9BF0 97 72         [ 3] 3108         staa    OFFCNT3
   9BF2 7E 9B E4      [ 3] 3109         jmp     (0x9BE4)
                           3110 
                           3111 ; bit 3 routine
   9BF5 18 3C         [ 5] 3112         pshy
   9BF7 18 DE 6B      [ 5] 3113         ldy     (0x006B)
   9BFA 18 A6 00      [ 5] 3114         ldaa    0,Y     
   9BFD 81 FF         [ 2] 3115         cmpa    #0xFF
   9BFF 27 14         [ 3] 3116         beq     L9C15  
   9C01 91 73         [ 3] 3117         cmpa    OFFCNT4
   9C03 25 0D         [ 3] 3118         bcs     L9C12  
   9C05 18 08         [ 4] 3119         iny
   9C07 18 A6 00      [ 5] 3120         ldaa    0,Y     
   9C0A B7 10 8C      [ 4] 3121         staa    (0x108C)
   9C0D 18 08         [ 4] 3122         iny
   9C0F 18 DF 6B      [ 5] 3123         sty     (0x006B)
   9C12                    3124 L9C12:
   9C12 18 38         [ 6] 3125         puly
   9C14 39            [ 5] 3126         rts
   9C15                    3127 L9C15:
   9C15 18 CE B4 75   [ 4] 3128         ldy     #0xB475
   9C19 18 DF 6B      [ 5] 3129         sty     (0x006B)
   9C1C 86 BE         [ 2] 3130         ldaa    #0xBE
   9C1E 97 73         [ 3] 3131         staa    OFFCNT4
   9C20 7E 9C 12      [ 3] 3132         jmp     (0x9C12)
                           3133 
                           3134 ; bit 4 routine
   9C23 18 3C         [ 5] 3135         pshy
   9C25 18 DE 6D      [ 5] 3136         ldy     (0x006D)
   9C28 18 A6 00      [ 5] 3137         ldaa    0,Y     
   9C2B 81 FF         [ 2] 3138         cmpa    #0xFF
   9C2D 27 14         [ 3] 3139         beq     L9C43  
   9C2F 91 74         [ 3] 3140         cmpa    OFFCNT5
   9C31 25 0D         [ 3] 3141         bcs     L9C40  
   9C33 18 08         [ 4] 3142         iny
   9C35 18 A6 00      [ 5] 3143         ldaa    0,Y     
   9C38 B7 10 90      [ 4] 3144         staa    (0x1090)
   9C3B 18 08         [ 4] 3145         iny
   9C3D 18 DF 6D      [ 5] 3146         sty     (0x006D)
   9C40                    3147 L9C40:
   9C40 18 38         [ 6] 3148         puly
   9C42 39            [ 5] 3149         rts
   9C43                    3150 L9C43:
   9C43 18 CE B5 C3   [ 4] 3151         ldy     #0xB5C3
   9C47 18 DF 6D      [ 5] 3152         sty     (0x006D)
   9C4A 86 AA         [ 2] 3153         ldaa    #0xAA
   9C4C 97 74         [ 3] 3154         staa    OFFCNT5
   9C4E 7E 9C 40      [ 3] 3155         jmp     (0x9C40)
                           3156 
                           3157 ; Reset offset counters to initial values
   9C51 86 FA         [ 2] 3158         ldaa    #0xFA
   9C53 97 70         [ 3] 3159         staa    OFFCNT1
   9C55 86 E6         [ 2] 3160         ldaa    #0xE6
   9C57 97 71         [ 3] 3161         staa    OFFCNT2
   9C59 86 D2         [ 2] 3162         ldaa    #0xD2
   9C5B 97 72         [ 3] 3163         staa    OFFCNT3
   9C5D 86 BE         [ 2] 3164         ldaa    #0xBE
   9C5F 97 73         [ 3] 3165         staa    OFFCNT4
   9C61 86 AA         [ 2] 3166         ldaa    #0xAA
   9C63 97 74         [ 3] 3167         staa    OFFCNT5
                           3168 
   9C65 18 CE B2 EB   [ 4] 3169         ldy     #0xB2EB
   9C69 18 DF 65      [ 5] 3170         sty     (0x0065)
   9C6C 18 CE B3 BD   [ 4] 3171         ldy     #0xB3BD
   9C70 18 DF 67      [ 5] 3172         sty     (0x0067)
   9C73 18 CE B5 31   [ 4] 3173         ldy     #0xB531
   9C77 18 DF 69      [ 5] 3174         sty     (0x0069)
   9C7A 18 CE B4 75   [ 4] 3175         ldy     #0xB475
   9C7E 18 DF 6B      [ 5] 3176         sty     (0x006B)
   9C81 18 CE B5 C3   [ 4] 3177         ldy     #0xB5C3
   9C85 18 DF 6D      [ 5] 3178         sty     (0x006D)
                           3179 
   9C88 7F 10 9C      [ 6] 3180         clr     (0x109C)
   9C8B 7F 10 9E      [ 6] 3181         clr     (0x109E)
                           3182 
   9C8E B6 04 01      [ 4] 3183         ldaa    (0x0401)
   9C91 84 20         [ 2] 3184         anda    #0x20
   9C93 27 08         [ 3] 3185         beq     L9C9D  
   9C95 B6 10 9C      [ 4] 3186         ldaa    (0x109C)
   9C98 8A 19         [ 2] 3187         oraa    #0x19
   9C9A B7 10 9C      [ 4] 3188         staa    (0x109C)
   9C9D                    3189 L9C9D:
   9C9D B6 04 01      [ 4] 3190         ldaa    (0x0401)
   9CA0 84 40         [ 2] 3191         anda    #0x40
   9CA2 27 10         [ 3] 3192         beq     L9CB4  
   9CA4 B6 10 9C      [ 4] 3193         ldaa    (0x109C)
   9CA7 8A 44         [ 2] 3194         oraa    #0x44
   9CA9 B7 10 9C      [ 4] 3195         staa    (0x109C)
   9CAC B6 10 9E      [ 4] 3196         ldaa    (0x109E)
   9CAF 8A 40         [ 2] 3197         oraa    #0x40
   9CB1 B7 10 9E      [ 4] 3198         staa    (0x109E)
   9CB4                    3199 L9CB4:
   9CB4 B6 04 01      [ 4] 3200         ldaa    (0x0401)
   9CB7 84 80         [ 2] 3201         anda    #0x80
   9CB9 27 08         [ 3] 3202         beq     L9CC3  
   9CBB B6 10 9C      [ 4] 3203         ldaa    (0x109C)
   9CBE 8A A2         [ 2] 3204         oraa    #0xA2
   9CC0 B7 10 9C      [ 4] 3205         staa    (0x109C)
   9CC3                    3206 L9CC3:
   9CC3 B6 04 2B      [ 4] 3207         ldaa    (0x042B)
   9CC6 84 01         [ 2] 3208         anda    #0x01
   9CC8 27 08         [ 3] 3209         beq     L9CD2  
   9CCA B6 10 9A      [ 4] 3210         ldaa    (0x109A)
   9CCD 8A 80         [ 2] 3211         oraa    #0x80
   9CCF B7 10 9A      [ 4] 3212         staa    (0x109A)
   9CD2                    3213 L9CD2:
   9CD2 B6 04 2B      [ 4] 3214         ldaa    (0x042B)
   9CD5 84 02         [ 2] 3215         anda    #0x02
   9CD7 27 08         [ 3] 3216         beq     L9CE1  
   9CD9 B6 10 9E      [ 4] 3217         ldaa    (0x109E)
   9CDC 8A 04         [ 2] 3218         oraa    #0x04
   9CDE B7 10 9E      [ 4] 3219         staa    (0x109E)
   9CE1                    3220 L9CE1:
   9CE1 B6 04 2B      [ 4] 3221         ldaa    (0x042B)
   9CE4 84 04         [ 2] 3222         anda    #0x04
   9CE6 27 08         [ 3] 3223         beq     L9CF0  
   9CE8 B6 10 9E      [ 4] 3224         ldaa    (0x109E)
   9CEB 8A 08         [ 2] 3225         oraa    #0x08
   9CED B7 10 9E      [ 4] 3226         staa    (0x109E)
   9CF0                    3227 L9CF0:
   9CF0 39            [ 5] 3228         rts
                           3229 
   9CF1 BD 8D E4      [ 6] 3230         jsr     (0x8DE4)
   9CF4 20 20 20 50 72 6F  3231         .ascis  '   Program by   '
        67 72 61 6D 20 62
        79 20 20 A0
                           3232 
   9D04 BD 8D DD      [ 6] 3233         jsr     (0x8DDD)
   9D07 44 61 76 69 64 20  3234         .ascis  'David  Philipsen'
        20 50 68 69 6C 69
        70 73 65 EE
                           3235 
   9D17 39            [ 5] 3236         rts
                           3237 
   9D18 97 49         [ 3] 3238         staa    (0x0049)
   9D1A 7F 00 B8      [ 6] 3239         clr     (0x00B8)
   9D1D BD 8D 03      [ 6] 3240         jsr     (0x8D03)
   9D20 86 2A         [ 2] 3241         ldaa    #0x2A            ;'*'
   9D22 C6 28         [ 2] 3242         ldab    #0x28
   9D24 BD 8D B5      [ 6] 3243         jsr     (0x8DB5)         ; display char here on LCD display
   9D27 CC 0B B8      [ 3] 3244         ldd     #0x0BB8
   9D2A DD 1B         [ 4] 3245         std     CDTIMR1
   9D2C                    3246 L9D2C:
   9D2C BD 9B 19      [ 6] 3247         jsr     (0x9B19)
   9D2F 96 49         [ 3] 3248         ldaa    (0x0049)
   9D31 81 41         [ 2] 3249         cmpa    #0x41
   9D33 27 04         [ 3] 3250         beq     L9D39  
   9D35 81 4B         [ 2] 3251         cmpa    #0x4B
   9D37 26 04         [ 3] 3252         bne     L9D3D  
   9D39                    3253 L9D39:
   9D39 C6 01         [ 2] 3254         ldab    #0x01
   9D3B D7 B8         [ 3] 3255         stab    (0x00B8)
   9D3D                    3256 L9D3D:
   9D3D 81 41         [ 2] 3257         cmpa    #0x41
   9D3F 27 04         [ 3] 3258         beq     L9D45  
   9D41 81 4F         [ 2] 3259         cmpa    #0x4F
   9D43 26 07         [ 3] 3260         bne     L9D4C  
   9D45                    3261 L9D45:
   9D45 86 01         [ 2] 3262         ldaa    #0x01
   9D47 B7 02 98      [ 4] 3263         staa    (0x0298)
   9D4A 20 32         [ 3] 3264         bra     L9D7E  
   9D4C                    3265 L9D4C:
   9D4C 81 4B         [ 2] 3266         cmpa    #0x4B
   9D4E 27 04         [ 3] 3267         beq     L9D54  
   9D50 81 50         [ 2] 3268         cmpa    #0x50
   9D52 26 07         [ 3] 3269         bne     L9D5B  
   9D54                    3270 L9D54:
   9D54 86 02         [ 2] 3271         ldaa    #0x02
   9D56 B7 02 98      [ 4] 3272         staa    (0x0298)
   9D59 20 23         [ 3] 3273         bra     L9D7E  
   9D5B                    3274 L9D5B:
   9D5B 81 4C         [ 2] 3275         cmpa    #0x4C
   9D5D 26 07         [ 3] 3276         bne     L9D66  
   9D5F 86 03         [ 2] 3277         ldaa    #0x03
   9D61 B7 02 98      [ 4] 3278         staa    (0x0298)
   9D64 20 18         [ 3] 3279         bra     L9D7E  
   9D66                    3280 L9D66:
   9D66 81 52         [ 2] 3281         cmpa    #0x52
   9D68 26 07         [ 3] 3282         bne     L9D71  
   9D6A 86 04         [ 2] 3283         ldaa    #0x04
   9D6C B7 02 98      [ 4] 3284         staa    (0x0298)
   9D6F 20 0D         [ 3] 3285         bra     L9D7E  
   9D71                    3286 L9D71:
   9D71 DC 1B         [ 4] 3287         ldd     CDTIMR1
   9D73 26 B7         [ 3] 3288         bne     L9D2C  
   9D75 86 23         [ 2] 3289         ldaa    #0x23            ;'#'
   9D77 C6 29         [ 2] 3290         ldab    #0x29
   9D79 BD 8D B5      [ 6] 3291         jsr     (0x8DB5)         ; display char here on LCD display
   9D7C 20 6C         [ 3] 3292         bra     L9DEA  
   9D7E                    3293 L9D7E:
   9D7E 7F 00 49      [ 6] 3294         clr     (0x0049)
   9D81 86 2A         [ 2] 3295         ldaa    #0x2A            ;'*'
   9D83 C6 29         [ 2] 3296         ldab    #0x29
   9D85 BD 8D B5      [ 6] 3297         jsr     (0x8DB5)         ; display char here on LCD display
   9D88 7F 00 4A      [ 6] 3298         clr     (0x004A)
   9D8B CE 02 99      [ 3] 3299         ldx     #0x0299
   9D8E                    3300 L9D8E:
   9D8E BD 9B 19      [ 6] 3301         jsr     (0x9B19)
   9D91 96 4A         [ 3] 3302         ldaa    (0x004A)
   9D93 27 F9         [ 3] 3303         beq     L9D8E  
   9D95 7F 00 4A      [ 6] 3304         clr     (0x004A)
   9D98 84 3F         [ 2] 3305         anda    #0x3F
   9D9A A7 00         [ 4] 3306         staa    0,X     
   9D9C 08            [ 3] 3307         inx
   9D9D 8C 02 9C      [ 4] 3308         cpx     #0x029C
   9DA0 26 EC         [ 3] 3309         bne     L9D8E  
   9DA2 BD 9D F5      [ 6] 3310         jsr     (0x9DF5)
   9DA5 24 09         [ 3] 3311         bcc     L9DB0  
   9DA7 86 23         [ 2] 3312         ldaa    #0x23            ;'#'
   9DA9 C6 2A         [ 2] 3313         ldab    #0x2A
   9DAB BD 8D B5      [ 6] 3314         jsr     (0x8DB5)         ; display char here on LCD display
   9DAE 20 3A         [ 3] 3315         bra     L9DEA  
   9DB0                    3316 L9DB0:
   9DB0 86 2A         [ 2] 3317         ldaa    #0x2A            ;'*'
   9DB2 C6 2A         [ 2] 3318         ldab    #0x2A
   9DB4 BD 8D B5      [ 6] 3319         jsr     (0x8DB5)         ; display char here on LCD display
   9DB7 B6 02 99      [ 4] 3320         ldaa    (0x0299)
   9DBA 81 39         [ 2] 3321         cmpa    #0x39
   9DBC 26 15         [ 3] 3322         bne     L9DD3  
                           3323 
   9DBE BD 8D DD      [ 6] 3324         jsr     (0x8DDD)
   9DC1 47 65 6E 65 72 69  3325         .ascis  'Generic Showtape'
        63 20 53 68 6F 77
        74 61 70 E5
                           3326 
   9DD1 0C            [ 2] 3327         clc
   9DD2 39            [ 5] 3328         rts
                           3329 
   9DD3                    3330 L9DD3:
   9DD3 B6 02 98      [ 4] 3331         ldaa    (0x0298)
   9DD6 81 03         [ 2] 3332         cmpa    #0x03
   9DD8 27 0E         [ 3] 3333         beq     L9DE8  
   9DDA 81 04         [ 2] 3334         cmpa    #0x04
   9DDC 27 0A         [ 3] 3335         beq     L9DE8  
   9DDE 96 76         [ 3] 3336         ldaa    (0x0076)
   9DE0 26 06         [ 3] 3337         bne     L9DE8  
   9DE2 BD 9E 73      [ 6] 3338         jsr     (0x9E73)
   9DE5 BD 9E CC      [ 6] 3339         jsr     (0x9ECC)
   9DE8                    3340 L9DE8:
   9DE8 0C            [ 2] 3341         clc
   9DE9 39            [ 5] 3342         rts
                           3343 
   9DEA                    3344 L9DEA:
   9DEA FC 04 20      [ 5] 3345         ldd     (0x0420)
   9DED C3 00 01      [ 4] 3346         addd    #0x0001
   9DF0 FD 04 20      [ 5] 3347         std     (0x0420)
   9DF3 0D            [ 2] 3348         sec
   9DF4 39            [ 5] 3349         rts
                           3350 
   9DF5 B6 02 99      [ 4] 3351         ldaa    (0x0299)
   9DF8 81 39         [ 2] 3352         cmpa    #0x39
   9DFA 27 6C         [ 3] 3353         beq     L9E68  
   9DFC CE 00 A8      [ 3] 3354         ldx     #0x00A8
   9DFF                    3355 L9DFF:
   9DFF BD 9B 19      [ 6] 3356         jsr     (0x9B19)
   9E02 96 4A         [ 3] 3357         ldaa    (0x004A)
   9E04 27 F9         [ 3] 3358         beq     L9DFF  
   9E06 7F 00 4A      [ 6] 3359         clr     (0x004A)
   9E09 A7 00         [ 4] 3360         staa    0,X     
   9E0B 08            [ 3] 3361         inx
   9E0C 8C 00 AA      [ 4] 3362         cpx     #0x00AA
   9E0F 26 EE         [ 3] 3363         bne     L9DFF  
   9E11 BD 9E FA      [ 6] 3364         jsr     (0x9EFA)
   9E14 CE 02 99      [ 3] 3365         ldx     #0x0299
   9E17 7F 00 13      [ 6] 3366         clr     (0x0013)
   9E1A                    3367 L9E1A:
   9E1A A6 00         [ 4] 3368         ldaa    0,X     
   9E1C 9B 13         [ 3] 3369         adda    (0x0013)
   9E1E 97 13         [ 3] 3370         staa    (0x0013)
   9E20 08            [ 3] 3371         inx
   9E21 8C 02 9C      [ 4] 3372         cpx     #0x029C
   9E24 26 F4         [ 3] 3373         bne     L9E1A  
   9E26 91 A8         [ 3] 3374         cmpa    (0x00A8)
   9E28 26 47         [ 3] 3375         bne     L9E71  
   9E2A CE 04 02      [ 3] 3376         ldx     #0x0402
   9E2D B6 02 98      [ 4] 3377         ldaa    (0x0298)
   9E30 81 02         [ 2] 3378         cmpa    #0x02
   9E32 26 03         [ 3] 3379         bne     L9E37  
   9E34 CE 04 05      [ 3] 3380         ldx     #0x0405
   9E37                    3381 L9E37:
   9E37 3C            [ 4] 3382         pshx
   9E38 BD AB 56      [ 6] 3383         jsr     (0xAB56)
   9E3B 38            [ 5] 3384         pulx
   9E3C 25 07         [ 3] 3385         bcs     L9E45  
   9E3E 86 03         [ 2] 3386         ldaa    #0x03
   9E40 B7 02 98      [ 4] 3387         staa    (0x0298)
   9E43 20 23         [ 3] 3388         bra     L9E68  
   9E45                    3389 L9E45:
   9E45 B6 02 99      [ 4] 3390         ldaa    (0x0299)
   9E48 A1 00         [ 4] 3391         cmpa    0,X     
   9E4A 25 1E         [ 3] 3392         bcs     L9E6A  
   9E4C 27 02         [ 3] 3393         beq     L9E50  
   9E4E 24 18         [ 3] 3394         bcc     L9E68  
   9E50                    3395 L9E50:
   9E50 08            [ 3] 3396         inx
   9E51 B6 02 9A      [ 4] 3397         ldaa    (0x029A)
   9E54 A1 00         [ 4] 3398         cmpa    0,X     
   9E56 25 12         [ 3] 3399         bcs     L9E6A  
   9E58 27 02         [ 3] 3400         beq     L9E5C  
   9E5A 24 0C         [ 3] 3401         bcc     L9E68  
   9E5C                    3402 L9E5C:
   9E5C 08            [ 3] 3403         inx
   9E5D B6 02 9B      [ 4] 3404         ldaa    (0x029B)
   9E60 A1 00         [ 4] 3405         cmpa    0,X     
   9E62 25 06         [ 3] 3406         bcs     L9E6A  
   9E64 27 02         [ 3] 3407         beq     L9E68  
   9E66 24 00         [ 3] 3408         bcc     L9E68  
   9E68                    3409 L9E68:
   9E68 0C            [ 2] 3410         clc
   9E69 39            [ 5] 3411         rts
                           3412 
   9E6A                    3413 L9E6A:
   9E6A B6 02 98      [ 4] 3414         ldaa    (0x0298)
   9E6D 81 03         [ 2] 3415         cmpa    #0x03
   9E6F 27 F7         [ 3] 3416         beq     L9E68  
   9E71                    3417 L9E71:
   9E71 0D            [ 2] 3418         sec
   9E72 39            [ 5] 3419         rts
                           3420 
   9E73 CE 04 02      [ 3] 3421         ldx     #0x0402
   9E76 B6 02 98      [ 4] 3422         ldaa    (0x0298)
   9E79 81 02         [ 2] 3423         cmpa    #0x02
   9E7B 26 03         [ 3] 3424         bne     L9E80  
   9E7D CE 04 05      [ 3] 3425         ldx     #0x0405
   9E80                    3426 L9E80:
   9E80 B6 02 99      [ 4] 3427         ldaa    (0x0299)
   9E83 A7 00         [ 4] 3428         staa    0,X     
   9E85 08            [ 3] 3429         inx
   9E86 B6 02 9A      [ 4] 3430         ldaa    (0x029A)
   9E89 A7 00         [ 4] 3431         staa    0,X     
   9E8B 08            [ 3] 3432         inx
   9E8C B6 02 9B      [ 4] 3433         ldaa    (0x029B)
   9E8F A7 00         [ 4] 3434         staa    0,X     
   9E91 39            [ 5] 3435         rts
                           3436 
                           3437 ; reset R counts
   9E92 86 30         [ 2] 3438         ldaa    #0x30        
   9E94 B7 04 02      [ 4] 3439         staa    (0x0402)
   9E97 B7 04 03      [ 4] 3440         staa    (0x0403)
   9E9A B7 04 04      [ 4] 3441         staa    (0x0404)
                           3442 
   9E9D BD 8D DD      [ 6] 3443         jsr     (0x8DDD)
   9EA0 52 65 67 20 23 20  3444         .ascis  'Reg # cleared!'
        63 6C 65 61 72 65
        64 A1
                           3445 
   9EAE 39            [ 5] 3446         rts
                           3447 
                           3448 ; reset L counts
   9EAF 86 30         [ 2] 3449         ldaa    #0x30
   9EB1 B7 04 05      [ 4] 3450         staa    (0x0405)
   9EB4 B7 04 06      [ 4] 3451         staa    (0x0406)
   9EB7 B7 04 07      [ 4] 3452         staa    (0x0407)
                           3453 
   9EBA BD 8D DD      [ 6] 3454         jsr     (0x8DDD)
   9EBD 4C 69 76 20 23 20  3455         .ascis  'Liv # cleared!'
        63 6C 65 61 72 65
        64 A1
                           3456 
   9ECB 39            [ 5] 3457         rts
                           3458 
                           3459 ; display R and L counts?
   9ECC 86 52         [ 2] 3460         ldaa    #0x52            ;'R'
   9ECE C6 2B         [ 2] 3461         ldab    #0x2B
   9ED0 BD 8D B5      [ 6] 3462         jsr     (0x8DB5)         ; display char here on LCD display
   9ED3 86 4C         [ 2] 3463         ldaa    #0x4C            ;'L'
   9ED5 C6 32         [ 2] 3464         ldab    #0x32
   9ED7 BD 8D B5      [ 6] 3465         jsr     (0x8DB5)         ; display char here on LCD display
   9EDA CE 04 02      [ 3] 3466         ldx     #0x0402
   9EDD C6 2C         [ 2] 3467         ldab    #0x2C
   9EDF                    3468 L9EDF:
   9EDF A6 00         [ 4] 3469         ldaa    0,X     
   9EE1 BD 8D B5      [ 6] 3470         jsr     (0x8DB5)         ; display 3 chars here on LCD display
   9EE4 5C            [ 2] 3471         incb
   9EE5 08            [ 3] 3472         inx
   9EE6 8C 04 05      [ 4] 3473         cpx     #0x0405
   9EE9 26 F4         [ 3] 3474         bne     L9EDF  
   9EEB C6 33         [ 2] 3475         ldab    #0x33
   9EED                    3476 L9EED:
   9EED A6 00         [ 4] 3477         ldaa    0,X     
   9EEF BD 8D B5      [ 6] 3478         jsr     (0x8DB5)         ; display 3 chars here on LCD display
   9EF2 5C            [ 2] 3479         incb
   9EF3 08            [ 3] 3480         inx
   9EF4 8C 04 08      [ 4] 3481         cpx     #0x0408
   9EF7 26 F4         [ 3] 3482         bne     L9EED  
   9EF9 39            [ 5] 3483         rts
                           3484 
   9EFA 96 A8         [ 3] 3485         ldaa    (0x00A8)
   9EFC BD 9F 0F      [ 6] 3486         jsr     (0x9F0F)
   9EFF 48            [ 2] 3487         asla
   9F00 48            [ 2] 3488         asla
   9F01 48            [ 2] 3489         asla
   9F02 48            [ 2] 3490         asla
   9F03 97 13         [ 3] 3491         staa    (0x0013)
   9F05 96 A9         [ 3] 3492         ldaa    (0x00A9)
   9F07 BD 9F 0F      [ 6] 3493         jsr     (0x9F0F)
   9F0A 9B 13         [ 3] 3494         adda    (0x0013)
   9F0C 97 A8         [ 3] 3495         staa    (0x00A8)
   9F0E 39            [ 5] 3496         rts
                           3497 
   9F0F 81 2F         [ 2] 3498         cmpa    #0x2F
   9F11 24 02         [ 3] 3499         bcc     L9F15  
   9F13 86 30         [ 2] 3500         ldaa    #0x30
   9F15                    3501 L9F15:
   9F15 81 3A         [ 2] 3502         cmpa    #0x3A
   9F17 25 02         [ 3] 3503         bcs     L9F1B  
   9F19 80 07         [ 2] 3504         suba    #0x07
   9F1B                    3505 L9F1B:
   9F1B 80 30         [ 2] 3506         suba    #0x30
   9F1D 39            [ 5] 3507         rts
                           3508 
   9F1E FC 02 9C      [ 5] 3509         ldd     (0x029C)
   9F21 1A 83 00 01   [ 5] 3510         cpd     #0x0001
   9F25 27 0C         [ 3] 3511         beq     L9F33  
   9F27 1A 83 03 E8   [ 5] 3512         cpd     #0x03E8
   9F2B 25 20         [ 3] 3513         bcs     L9F4D  
   9F2D 1A 83 04 4B   [ 5] 3514         cpd     #0x044B
   9F31 22 1A         [ 3] 3515         bhi     L9F4D  
                           3516 
   9F33                    3517 L9F33:
   9F33 BD 8D E4      [ 6] 3518         jsr     (0x8DE4)
   9F36 50 61 73 73 77 6F  3519         .ascis  'Password bypass '
        72 64 20 62 79 70
        61 73 73 A0
                           3520 
   9F46 C6 04         [ 2] 3521         ldab    #0x04
   9F48 BD 8C 30      [ 6] 3522         jsr     (0x8C30)
   9F4B 0C            [ 2] 3523         clc
   9F4C 39            [ 5] 3524         rts
                           3525 
   9F4D                    3526 L9F4D:
   9F4D BD 8C F2      [ 6] 3527         jsr     (0x8CF2)
   9F50 BD 8D 03      [ 6] 3528         jsr     (0x8D03)
                           3529 
   9F53 BD 8D E4      [ 6] 3530         jsr     (0x8DE4)
   9F56 43 6F 64 65 BA     3531         .ascis  'Code:'
                           3532 
   9F5B CE 02 90      [ 3] 3533         ldx     #0x0290
   9F5E 7F 00 16      [ 6] 3534         clr     (0x0016)
   9F61                    3535 L9F61:
   9F61 86 41         [ 2] 3536         ldaa    #0x41
   9F63                    3537 L9F63:
   9F63 97 15         [ 3] 3538         staa    (0x0015)
   9F65 BD 8E 95      [ 6] 3539         jsr     (0x8E95)
   9F68 81 0D         [ 2] 3540         cmpa    #0x0D
   9F6A 26 11         [ 3] 3541         bne     L9F7D  
   9F6C 96 15         [ 3] 3542         ldaa    (0x0015)
   9F6E A7 00         [ 4] 3543         staa    0,X     
   9F70 08            [ 3] 3544         inx
   9F71 BD 8C 98      [ 6] 3545         jsr     (0x8C98)
   9F74 96 16         [ 3] 3546         ldaa    (0x0016)
   9F76 4C            [ 2] 3547         inca
   9F77 97 16         [ 3] 3548         staa    (0x0016)
   9F79 81 05         [ 2] 3549         cmpa    #0x05
   9F7B 27 09         [ 3] 3550         beq     L9F86  
   9F7D                    3551 L9F7D:
   9F7D 96 15         [ 3] 3552         ldaa    (0x0015)
   9F7F 4C            [ 2] 3553         inca
   9F80 81 5B         [ 2] 3554         cmpa    #0x5B
   9F82 27 DD         [ 3] 3555         beq     L9F61  
   9F84 20 DD         [ 3] 3556         bra     L9F63  
                           3557 
   9F86                    3558 L9F86:
   9F86 BD 8D DD      [ 6] 3559         jsr     (0x8DDD)
   9F89 50 73 77 64 BA     3560         .ascis  'Pswd:'
                           3561 
   9F8E CE 02 88      [ 3] 3562         ldx     #0x0288
   9F91 86 41         [ 2] 3563         ldaa    #0x41
   9F93 97 16         [ 3] 3564         staa    (0x0016)
   9F95 86 C5         [ 2] 3565         ldaa    #0xC5
   9F97 97 15         [ 3] 3566         staa    (0x0015)
   9F99                    3567 L9F99:
   9F99 96 15         [ 3] 3568         ldaa    (0x0015)
   9F9B BD 8C 86      [ 6] 3569         jsr     (0x8C86)     ; write byte to LCD
   9F9E 96 16         [ 3] 3570         ldaa    (0x0016)
   9FA0 BD 8C 98      [ 6] 3571         jsr     (0x8C98)
   9FA3                    3572 L9FA3:
   9FA3 BD 8E 95      [ 6] 3573         jsr     (0x8E95)
   9FA6 27 FB         [ 3] 3574         beq     L9FA3  
   9FA8 81 0D         [ 2] 3575         cmpa    #0x0D
   9FAA 26 10         [ 3] 3576         bne     L9FBC  
   9FAC 96 16         [ 3] 3577         ldaa    (0x0016)
   9FAE A7 00         [ 4] 3578         staa    0,X     
   9FB0 08            [ 3] 3579         inx
   9FB1 96 15         [ 3] 3580         ldaa    (0x0015)
   9FB3 4C            [ 2] 3581         inca
   9FB4 97 15         [ 3] 3582         staa    (0x0015)
   9FB6 81 CA         [ 2] 3583         cmpa    #0xCA
   9FB8 27 28         [ 3] 3584         beq     L9FE2  
   9FBA 20 DD         [ 3] 3585         bra     L9F99  
   9FBC                    3586 L9FBC:
   9FBC 81 01         [ 2] 3587         cmpa    #0x01
   9FBE 26 0F         [ 3] 3588         bne     L9FCF  
   9FC0 96 16         [ 3] 3589         ldaa    (0x0016)
   9FC2 4C            [ 2] 3590         inca
   9FC3 97 16         [ 3] 3591         staa    (0x0016)
   9FC5 81 5B         [ 2] 3592         cmpa    #0x5B
   9FC7 26 D0         [ 3] 3593         bne     L9F99  
   9FC9 86 41         [ 2] 3594         ldaa    #0x41
   9FCB 97 16         [ 3] 3595         staa    (0x0016)
   9FCD 20 CA         [ 3] 3596         bra     L9F99  
   9FCF                    3597 L9FCF:
   9FCF 81 02         [ 2] 3598         cmpa    #0x02
   9FD1 26 D0         [ 3] 3599         bne     L9FA3  
   9FD3 96 16         [ 3] 3600         ldaa    (0x0016)
   9FD5 4A            [ 2] 3601         deca
   9FD6 97 16         [ 3] 3602         staa    (0x0016)
   9FD8 81 40         [ 2] 3603         cmpa    #0x40
   9FDA 26 BD         [ 3] 3604         bne     L9F99  
   9FDC 86 5A         [ 2] 3605         ldaa    #0x5A
   9FDE 97 16         [ 3] 3606         staa    (0x0016)
   9FE0 20 B7         [ 3] 3607         bra     L9F99  
   9FE2                    3608 L9FE2:
   9FE2 BD A0 01      [ 6] 3609         jsr     (0xA001)
   9FE5 25 0F         [ 3] 3610         bcs     L9FF6  
   9FE7 86 DB         [ 2] 3611         ldaa    #0xDB
   9FE9 97 AB         [ 3] 3612         staa    (0x00AB)
   9FEB FC 04 16      [ 5] 3613         ldd     (0x0416)
   9FEE C3 00 01      [ 4] 3614         addd    #0x0001
   9FF1 FD 04 16      [ 5] 3615         std     (0x0416)
   9FF4 0C            [ 2] 3616         clc
   9FF5 39            [ 5] 3617         rts
                           3618 
   9FF6                    3619 L9FF6:
   9FF6 FC 04 14      [ 5] 3620         ldd     (0x0414)
   9FF9 C3 00 01      [ 4] 3621         addd    #0x0001
   9FFC FD 04 14      [ 5] 3622         std     (0x0414)
   9FFF 0D            [ 2] 3623         sec
   A000 39            [ 5] 3624         rts
                           3625 
   A001 B6 02 90      [ 4] 3626         ldaa    (0x0290)
   A004 B7 02 81      [ 4] 3627         staa    (0x0281)
   A007 B6 02 91      [ 4] 3628         ldaa    (0x0291)
   A00A B7 02 83      [ 4] 3629         staa    (0x0283)
   A00D B6 02 92      [ 4] 3630         ldaa    (0x0292)
   A010 B7 02 84      [ 4] 3631         staa    (0x0284)
   A013 B6 02 93      [ 4] 3632         ldaa    (0x0293)
   A016 B7 02 80      [ 4] 3633         staa    (0x0280)
   A019 B6 02 94      [ 4] 3634         ldaa    (0x0294)
   A01C B7 02 82      [ 4] 3635         staa    (0x0282)
   A01F B6 02 80      [ 4] 3636         ldaa    (0x0280)
   A022 88 13         [ 2] 3637         eora    #0x13
   A024 8B 03         [ 2] 3638         adda    #0x03
   A026 B7 02 80      [ 4] 3639         staa    (0x0280)
   A029 B6 02 81      [ 4] 3640         ldaa    (0x0281)
   A02C 88 04         [ 2] 3641         eora    #0x04
   A02E 8B 12         [ 2] 3642         adda    #0x12
   A030 B7 02 81      [ 4] 3643         staa    (0x0281)
   A033 B6 02 82      [ 4] 3644         ldaa    (0x0282)
   A036 88 06         [ 2] 3645         eora    #0x06
   A038 8B 04         [ 2] 3646         adda    #0x04
   A03A B7 02 82      [ 4] 3647         staa    (0x0282)
   A03D B6 02 83      [ 4] 3648         ldaa    (0x0283)
   A040 88 11         [ 2] 3649         eora    #0x11
   A042 8B 07         [ 2] 3650         adda    #0x07
   A044 B7 02 83      [ 4] 3651         staa    (0x0283)
   A047 B6 02 84      [ 4] 3652         ldaa    (0x0284)
   A04A 88 01         [ 2] 3653         eora    #0x01
   A04C 8B 10         [ 2] 3654         adda    #0x10
   A04E B7 02 84      [ 4] 3655         staa    (0x0284)
   A051 BD A0 AF      [ 6] 3656         jsr     (0xA0AF)
   A054 B6 02 94      [ 4] 3657         ldaa    (0x0294)
   A057 84 17         [ 2] 3658         anda    #0x17
   A059 97 15         [ 3] 3659         staa    (0x0015)
   A05B B6 02 90      [ 4] 3660         ldaa    (0x0290)
   A05E 84 17         [ 2] 3661         anda    #0x17
   A060 97 16         [ 3] 3662         staa    (0x0016)
   A062 CE 02 80      [ 3] 3663         ldx     #0x0280
   A065                    3664 LA065:
   A065 A6 00         [ 4] 3665         ldaa    0,X     
   A067 98 15         [ 3] 3666         eora    (0x0015)
   A069 98 16         [ 3] 3667         eora    (0x0016)
   A06B A7 00         [ 4] 3668         staa    0,X     
   A06D 08            [ 3] 3669         inx
   A06E 8C 02 85      [ 4] 3670         cpx     #0x0285
   A071 26 F2         [ 3] 3671         bne     LA065  
   A073 BD A0 AF      [ 6] 3672         jsr     (0xA0AF)
   A076 CE 02 80      [ 3] 3673         ldx     #0x0280
   A079 18 CE 02 88   [ 4] 3674         ldy     #0x0288
   A07D                    3675 LA07D:
   A07D A6 00         [ 4] 3676         ldaa    0,X     
   A07F 18 A1 00      [ 5] 3677         cmpa    0,Y     
   A082 26 0A         [ 3] 3678         bne     LA08E  
   A084 08            [ 3] 3679         inx
   A085 18 08         [ 4] 3680         iny
   A087 8C 02 85      [ 4] 3681         cpx     #0x0285
   A08A 26 F1         [ 3] 3682         bne     LA07D  
   A08C 0C            [ 2] 3683         clc
   A08D 39            [ 5] 3684         rts
                           3685 
   A08E                    3686 LA08E:
   A08E 0D            [ 2] 3687         sec
   A08F 39            [ 5] 3688         rts
                           3689 
   A090                    3690 LA090:
   A090 59 41 44 44 41     3691         .ascii  'YADDA'
                           3692 
   A095 CE 02 88      [ 3] 3693         ldx     #0x0288
   A098 18 CE A0 90   [ 4] 3694         ldy     #LA090
   A09C                    3695 LA09C:
   A09C A6 00         [ 4] 3696         ldaa    0,X
   A09E 18 A1 00      [ 5] 3697         cmpa    0,Y
   A0A1 26 0A         [ 3] 3698         bne     LA0AD
   A0A3 08            [ 3] 3699         inx
   A0A4 18 08         [ 4] 3700         iny
   A0A6 8C 02 8D      [ 4] 3701         cpx     #0x028D
   A0A9 26 F1         [ 3] 3702         bne     LA09C
   A0AB 0C            [ 2] 3703         clc
   A0AC 39            [ 5] 3704         rts
   A0AD                    3705 LA0AD:
   A0AD 0D            [ 2] 3706         sec
   A0AE 39            [ 5] 3707         rts
                           3708 
   A0AF CE 02 80      [ 3] 3709         ldx     #0x0280
   A0B2                    3710 LA0B2:
   A0B2 A6 00         [ 4] 3711         ldaa    0,X     
   A0B4 81 5B         [ 2] 3712         cmpa    #0x5B
   A0B6 25 06         [ 3] 3713         bcs     LA0BE  
   A0B8 80 1A         [ 2] 3714         suba    #0x1A
   A0BA A7 00         [ 4] 3715         staa    0,X     
   A0BC 20 08         [ 3] 3716         bra     LA0C6  
   A0BE                    3717 LA0BE:
   A0BE 81 41         [ 2] 3718         cmpa    #0x41
   A0C0 24 04         [ 3] 3719         bcc     LA0C6  
   A0C2 8B 1A         [ 2] 3720         adda    #0x1A
   A0C4 A7 00         [ 4] 3721         staa    0,X     
   A0C6                    3722 LA0C6:
   A0C6 08            [ 3] 3723         inx
   A0C7 8C 02 85      [ 4] 3724         cpx     #0x0285
   A0CA 26 E6         [ 3] 3725         bne     LA0B2  
   A0CC 39            [ 5] 3726         rts
                           3727 
   A0CD BD 8C F2      [ 6] 3728         jsr     (0x8CF2)
                           3729 
   A0D0 BD 8D DD      [ 6] 3730         jsr     (0x8DDD)
   A0D3 46 61 69 6C 65 64  3731         .ascis  'Failed!         '
        21 20 20 20 20 20
        20 20 20 A0
                           3732 
   A0E3 C6 02         [ 2] 3733         ldab    #0x02
   A0E5 BD 8C 30      [ 6] 3734         jsr     (0x8C30)
   A0E8 39            [ 5] 3735         rts
                           3736 
   A0E9 C6 01         [ 2] 3737         ldab    #0x01
   A0EB BD 8C 30      [ 6] 3738         jsr     (0x8C30)
   A0EE 7F 00 4E      [ 6] 3739         clr     (0x004E)
   A0F1 C6 D3         [ 2] 3740         ldab    #0xD3
   A0F3 BD 87 48      [ 6] 3741         jsr     (0x8748)
   A0F6 BD 87 AE      [ 6] 3742         jsr     (0x87AE)
   A0F9 BD 8C E9      [ 6] 3743         jsr     (0x8CE9)
                           3744 
   A0FC BD 8D E4      [ 6] 3745         jsr     (0x8DE4)
   A0FF 20 20 20 56 43 52  3746         .ascis  '   VCR adjust'
        20 61 64 6A 75 73
        F4
                           3747 
   A10C BD 8D DD      [ 6] 3748         jsr     (0x8DDD)
   A10F 55 50 20 74 6F 20  3749         .ascis  'UP to clear bits'
        63 6C 65 61 72 20
        62 69 74 F3
                           3750 
   A11F 5F            [ 2] 3751         clrb
   A120 D7 62         [ 3] 3752         stab    (0x0062)
   A122 BD F9 C5      [ 6] 3753         jsr     (0xF9C5)
   A125 B6 18 04      [ 4] 3754         ldaa    (0x1804)
   A128 84 BF         [ 2] 3755         anda    #0xBF
   A12A B7 18 04      [ 4] 3756         staa    (0x1804)
   A12D BD 8E 95      [ 6] 3757         jsr     (0x8E95)
   A130 7F 00 48      [ 6] 3758         clr     (0x0048)
   A133 7F 00 49      [ 6] 3759         clr     (0x0049)
   A136 BD 86 C4      [ 6] 3760         jsr     L86C4
   A139 86 28         [ 2] 3761         ldaa    #0x28
   A13B 97 63         [ 3] 3762         staa    (0x0063)
   A13D C6 FD         [ 2] 3763         ldab    #0xFD
   A13F BD 86 E7      [ 6] 3764         jsr     (0x86E7)
   A142 BD A3 2E      [ 6] 3765         jsr     (0xA32E)
   A145 7C 00 76      [ 6] 3766         inc     (0x0076)
   A148 7F 00 32      [ 6] 3767         clr     (0x0032)
   A14B                    3768 LA14B:
   A14B BD 8E 95      [ 6] 3769         jsr     (0x8E95)
   A14E 81 0D         [ 2] 3770         cmpa    #0x0D
   A150 26 03         [ 3] 3771         bne     LA155  
   A152 7E A1 C4      [ 3] 3772         jmp     (0xA1C4)
   A155                    3773 LA155:
   A155 86 28         [ 2] 3774         ldaa    #0x28
   A157 97 63         [ 3] 3775         staa    (0x0063)
   A159 BD 86 A4      [ 6] 3776         jsr     (0x86A4)
   A15C 25 ED         [ 3] 3777         bcs     LA14B  
   A15E FC 04 1A      [ 5] 3778         ldd     (0x041A)
   A161 C3 00 01      [ 4] 3779         addd    #0x0001
   A164 FD 04 1A      [ 5] 3780         std     (0x041A)
   A167 BD 86 C4      [ 6] 3781         jsr     L86C4
   A16A 7C 00 4E      [ 6] 3782         inc     (0x004E)
   A16D C6 D3         [ 2] 3783         ldab    #0xD3
   A16F BD 87 48      [ 6] 3784         jsr     (0x8748)
   A172 BD 87 AE      [ 6] 3785         jsr     (0x87AE)
   A175 96 49         [ 3] 3786         ldaa    (0x0049)
   A177 81 43         [ 2] 3787         cmpa    #0x43
   A179 26 06         [ 3] 3788         bne     LA181  
   A17B 7F 00 49      [ 6] 3789         clr     (0x0049)
   A17E 7F 00 48      [ 6] 3790         clr     (0x0048)
   A181                    3791 LA181:
   A181 96 48         [ 3] 3792         ldaa    (0x0048)
   A183 81 C8         [ 2] 3793         cmpa    #0xC8
   A185 25 1F         [ 3] 3794         bcs     LA1A6  
   A187 FC 02 9C      [ 5] 3795         ldd     (0x029C)
   A18A 1A 83 00 01   [ 5] 3796         cpd     #0x0001
   A18E 27 16         [ 3] 3797         beq     LA1A6  
   A190 C6 EF         [ 2] 3798         ldab    #0xEF
   A192 BD 86 E7      [ 6] 3799         jsr     (0x86E7)
   A195 BD 86 C4      [ 6] 3800         jsr     L86C4
   A198 7F 00 4E      [ 6] 3801         clr     (0x004E)
   A19B 7F 00 76      [ 6] 3802         clr     (0x0076)
   A19E C6 0A         [ 2] 3803         ldab    #0x0A
   A1A0 BD 8C 30      [ 6] 3804         jsr     (0x8C30)
   A1A3 7E 81 D7      [ 3] 3805         jmp     (0x81D7)
   A1A6                    3806 LA1A6:
   A1A6 BD 8E 95      [ 6] 3807         jsr     (0x8E95)
   A1A9 81 01         [ 2] 3808         cmpa    #0x01
   A1AB 26 10         [ 3] 3809         bne     LA1BD  
   A1AD CE 10 80      [ 3] 3810         ldx     #0x1080
   A1B0 86 34         [ 2] 3811         ldaa    #0x34
   A1B2                    3812 LA1B2:
   A1B2 6F 00         [ 6] 3813         clr     0,X     
   A1B4 A7 01         [ 4] 3814         staa    1,X     
   A1B6 08            [ 3] 3815         inx
   A1B7 08            [ 3] 3816         inx
   A1B8 8C 10 A0      [ 4] 3817         cpx     #0x10A0
   A1BB 25 F5         [ 3] 3818         bcs     LA1B2  
   A1BD                    3819 LA1BD:
   A1BD 81 0D         [ 2] 3820         cmpa    #0x0D
   A1BF 27 03         [ 3] 3821         beq     LA1C4  
   A1C1 7E A1 75      [ 3] 3822         jmp     (0xA175)
   A1C4                    3823 LA1C4:
   A1C4 7F 00 76      [ 6] 3824         clr     (0x0076)
   A1C7 7F 00 4E      [ 6] 3825         clr     (0x004E)
   A1CA C6 DF         [ 2] 3826         ldab    #0xDF
   A1CC BD 87 48      [ 6] 3827         jsr     (0x8748)
   A1CF BD 87 91      [ 6] 3828         jsr     (0x8791)
   A1D2 7E 81 D7      [ 3] 3829         jmp     (0x81D7)
   A1D5 86 07         [ 2] 3830         ldaa    #0x07
   A1D7 B7 04 00      [ 4] 3831         staa    (0x0400)
   A1DA CC 0E 09      [ 3] 3832         ldd     #0x0E09
   A1DD 81 65         [ 2] 3833         cmpa    #0x65
   A1DF 26 05         [ 3] 3834         bne     LA1E6  
   A1E1 C1 63         [ 2] 3835         cmpb    #0x63
   A1E3 26 01         [ 3] 3836         bne     LA1E6  
   A1E5 39            [ 5] 3837         rts
                           3838 
   A1E6                    3839 LA1E6:
   A1E6 86 0E         [ 2] 3840         ldaa    #0x0E
   A1E8 B7 10 3B      [ 4] 3841         staa    PPROG  
   A1EB 86 FF         [ 2] 3842         ldaa    #0xFF
   A1ED B7 0E 00      [ 4] 3843         staa    (0x0E00)
   A1F0 B6 10 3B      [ 4] 3844         ldaa    PPROG  
   A1F3 8A 01         [ 2] 3845         oraa    #0x01
   A1F5 B7 10 3B      [ 4] 3846         staa    PPROG  
   A1F8 CE 1B 58      [ 3] 3847         ldx     #0x1B58
   A1FB                    3848 LA1FB:
   A1FB 09            [ 3] 3849         dex
   A1FC 26 FD         [ 3] 3850         bne     LA1FB  
   A1FE B6 10 3B      [ 4] 3851         ldaa    PPROG  
   A201 84 FE         [ 2] 3852         anda    #0xFE
   A203 B7 10 3B      [ 4] 3853         staa    PPROG  
   A206 CE 0E 00      [ 3] 3854         ldx     #0x0E00
   A209 18 CE A2 26   [ 4] 3855         ldy     #0xA226
   A20D                    3856 LA20D:
   A20D C6 02         [ 2] 3857         ldab    #0x02
   A20F F7 10 3B      [ 4] 3858         stab    PPROG  
   A212 18 A6 00      [ 5] 3859         ldaa    0,Y     
   A215 18 08         [ 4] 3860         iny
   A217 A7 00         [ 4] 3861         staa    0,X     
   A219 BD A2 32      [ 6] 3862         jsr     (0xA232)
   A21C 08            [ 3] 3863         inx
   A21D 8C 0E 0C      [ 4] 3864         cpx     #0x0E0C
   A220 26 EB         [ 3] 3865         bne     LA20D  
   A222 7F 10 3B      [ 6] 3866         clr     PPROG  
   A225 39            [ 5] 3867         rts
                           3868 
                           3869 ; data
   A226 29 64 2A 21 32 3A  3870         .ascii  ')d*!2::4!ecq'
        3A 34 21 65 63 71
                           3871 
                           3872 ; program EEPROM
   A232 18 3C         [ 5] 3873         pshy
   A234 C6 03         [ 2] 3874         ldab    #0x03
   A236 F7 10 3B      [ 4] 3875         stab    PPROG       ; start program
   A239 18 CE 1B 58   [ 4] 3876         ldy     #0x1B58
   A23D                    3877 LA23D:
   A23D 18 09         [ 4] 3878         dey
   A23F 26 FC         [ 3] 3879         bne     LA23D  
   A241 C6 02         [ 2] 3880         ldab    #0x02
   A243 F7 10 3B      [ 4] 3881         stab    PPROG       ; stop program
   A246 18 38         [ 6] 3882         puly
   A248 39            [ 5] 3883         rts
                           3884 
   A249 0F            [ 2] 3885         sei
   A24A CE 00 10      [ 3] 3886         ldx     #0x0010
   A24D                    3887 LA24D:
   A24D 6F 00         [ 6] 3888         clr     0,X     
   A24F 08            [ 3] 3889         inx
   A250 8C 0E 00      [ 4] 3890         cpx     #0x0E00
   A253 26 F8         [ 3] 3891         bne     LA24D  
   A255 BD 9E AF      [ 6] 3892         jsr     (0x9EAF)     ; reset L counts
   A258 BD 9E 92      [ 6] 3893         jsr     (0x9E92)     ; reset R counts
   A25B 7E F8 00      [ 3] 3894         jmp     RESET     ; reset controller
                           3895 
                           3896 ; Compute and store copyright checksum
   A25E                    3897 LA25E:
   A25E 18 CE 80 03   [ 4] 3898         ldy     #CPYRTMSG       ; copyright message
   A262 CE 00 00      [ 3] 3899         ldx     #0x0000
   A265                    3900 LA265:
   A265 18 E6 00      [ 5] 3901         ldab    0,Y
   A268 3A            [ 3] 3902         abx
   A269 18 08         [ 4] 3903         iny
   A26B 18 8C 80 50   [ 5] 3904         cpy     #0x8050
   A26F 26 F4         [ 3] 3905         bne     LA265
   A271 FF 04 0B      [ 5] 3906         stx     CPYRTCS         ; store checksum here
   A274 39            [ 5] 3907         rts
                           3908 
                           3909 ; Erase EEPROM routine
   A275                    3910 LA275:
   A275 0F            [ 2] 3911         sei
   A276 7F 04 0F      [ 6] 3912         clr     ERASEFLG     ; Reset EEPROM Erase flag
   A279 86 0E         [ 2] 3913         ldaa    #0x0E
   A27B B7 10 3B      [ 4] 3914         staa    PPROG       ; ERASE mode!
   A27E 86 FF         [ 2] 3915         ldaa    #0xFF
   A280 B7 0E 20      [ 4] 3916         staa    (0x0E20)    ; save in NVRAM
   A283 B6 10 3B      [ 4] 3917         ldaa    PPROG  
   A286 8A 01         [ 2] 3918         oraa    #0x01
   A288 B7 10 3B      [ 4] 3919         staa    PPROG       ; do the ERASE
   A28B CE 1B 58      [ 3] 3920         ldx     #0x1B58       ; delay a bit
   A28E                    3921 LA28E:
   A28E 09            [ 3] 3922         dex
   A28F 26 FD         [ 3] 3923         bne     LA28E  
   A291 B6 10 3B      [ 4] 3924         ldaa    PPROG  
   A294 84 FE         [ 2] 3925         anda    #0xFE        ; stop erasing
   A296 7F 10 3B      [ 6] 3926         clr     PPROG  
                           3927 
   A299 BD F9 D8      [ 6] 3928         jsr     (0xF9D8)     ; display "enter serial number"
   A29C 45 6E 74 65 72 20  3929         .ascis  'Enter serial #: '
        73 65 72 69 61 6C
        20 23 3A A0
                           3930 
   A2AC CE 0E 20      [ 3] 3931         ldx     #0x0E20
   A2AF                    3932 LA2AF:
   A2AF BD F9 45      [ 6] 3933         jsr     (0xF945)     ; wait for serial data
   A2B2 24 FB         [ 3] 3934         bcc     LA2AF  
                           3935 
   A2B4 BD F9 6F      [ 6] 3936         jsr     (0xF96F)     ; read serial data
   A2B7 C6 02         [ 2] 3937         ldab    #0x02
   A2B9 F7 10 3B      [ 4] 3938         stab    PPROG       ; protect only 0x0e20-0x0e5f
   A2BC A7 00         [ 4] 3939         staa    0,X         
   A2BE BD A2 32      [ 6] 3940         jsr     (0xA232)     ; program byte
   A2C1 08            [ 3] 3941         inx
   A2C2 8C 0E 24      [ 4] 3942         cpx     #0x0E24
   A2C5 26 E8         [ 3] 3943         bne     LA2AF  
   A2C7 C6 02         [ 2] 3944         ldab    #0x02
   A2C9 F7 10 3B      [ 4] 3945         stab    PPROG  
   A2CC 86 DB         [ 2] 3946         ldaa    #0xDB        ; it's official
   A2CE B7 0E 24      [ 4] 3947         staa    (0x0E24)
   A2D1 BD A2 32      [ 6] 3948         jsr     (0xA232)     ; program byte
   A2D4 7F 10 3B      [ 6] 3949         clr     PPROG  
   A2D7 86 1E         [ 2] 3950         ldaa    #0x1E
   A2D9 B7 10 35      [ 4] 3951         staa    BPROT       ; protect all but 0x0e00-0x0e1f
   A2DC 7E F8 00      [ 3] 3952         jmp     RESET     ; reset controller
                           3953 
   A2DF 38            [ 5] 3954         pulx
   A2E0 3C            [ 4] 3955         pshx
   A2E1 8C 80 00      [ 4] 3956         cpx     #0x8000
   A2E4 25 02         [ 3] 3957         bcs     LA2E8  
   A2E6 0C            [ 2] 3958         clc
   A2E7 39            [ 5] 3959         rts
                           3960 
   A2E8                    3961 LA2E8:
   A2E8 0D            [ 2] 3962         sec
   A2E9 39            [ 5] 3963         rts
                           3964 
                           3965 ; validate security code?
   A2EA CE 02 88      [ 3] 3966         ldx     #0x0288
   A2ED C6 03         [ 2] 3967         ldab    #0x03        ; 3 character code
                           3968 
   A2EF                    3969 LA2EF:
   A2EF BD F9 45      [ 6] 3970         jsr     (0xF945)     ; check if available
   A2F2 24 FB         [ 3] 3971         bcc     LA2EF  
   A2F4 A7 00         [ 4] 3972         staa    0,X     
   A2F6 08            [ 3] 3973         inx
   A2F7 5A            [ 2] 3974         decb
   A2F8 26 F5         [ 3] 3975         bne     LA2EF  
                           3976 
   A2FA B6 02 88      [ 4] 3977         ldaa    (0x0288)
   A2FD 81 13         [ 2] 3978         cmpa    #0x13        ; 0x13
   A2FF 26 10         [ 3] 3979         bne     LA311  
   A301 B6 02 89      [ 4] 3980         ldaa    (0x0289)
   A304 81 10         [ 2] 3981         cmpa    #0x10        ; 0x10
   A306 26 09         [ 3] 3982         bne     LA311  
   A308 B6 02 8A      [ 4] 3983         ldaa    (0x028A)
   A30B 81 14         [ 2] 3984         cmpa    #0x14        ; 0x14
   A30D 26 02         [ 3] 3985         bne     LA311  
   A30F 0C            [ 2] 3986         clc
   A310 39            [ 5] 3987         rts
                           3988 
   A311                    3989 LA311:
   A311 0D            [ 2] 3990         sec
   A312 39            [ 5] 3991         rts
                           3992 
   A313 36            [ 3] 3993         psha
   A314 B6 10 92      [ 4] 3994         ldaa    (0x1092)
   A317 8A 01         [ 2] 3995         oraa    #0x01
   A319                    3996 LA319:
   A319 B7 10 92      [ 4] 3997         staa    (0x1092)
   A31C 32            [ 4] 3998         pula
   A31D 39            [ 5] 3999         rts
                           4000 
   A31E 36            [ 3] 4001         psha
   A31F B6 10 92      [ 4] 4002         ldaa    (0x1092)
   A322 84 FE         [ 2] 4003         anda    #0xFE
   A324 20 F3         [ 3] 4004         bra     LA319  
   A326 96 4E         [ 3] 4005         ldaa    (0x004E)
   A328 97 19         [ 3] 4006         staa    (0x0019)
   A32A 7F 00 4E      [ 6] 4007         clr     (0x004E)
   A32D 39            [ 5] 4008         rts
                           4009 
   A32E B6 10 86      [ 4] 4010         ldaa    (0x1086)
   A331 8A 15         [ 2] 4011         oraa    #0x15
   A333 B7 10 86      [ 4] 4012         staa    (0x1086)
   A336 C6 01         [ 2] 4013         ldab    #0x01
   A338 BD 8C 30      [ 6] 4014         jsr     (0x8C30)
   A33B 84 EA         [ 2] 4015         anda    #0xEA
   A33D B7 10 86      [ 4] 4016         staa    (0x1086)
   A340 39            [ 5] 4017         rts
                           4018 
   A341 B6 10 86      [ 4] 4019         ldaa    (0x1086)
   A344 8A 2A         [ 2] 4020         oraa    #0x2A
   A346 B7 10 86      [ 4] 4021         staa    (0x1086)
   A349 C6 01         [ 2] 4022         ldab    #0x01
   A34B BD 8C 30      [ 6] 4023         jsr     (0x8C30)
   A34E 84 D5         [ 2] 4024         anda    #0xD5
   A350 B7 10 86      [ 4] 4025         staa    (0x1086)
   A353 39            [ 5] 4026         rts
                           4027 
   A354 F6 18 04      [ 4] 4028         ldab    (0x1804)
   A357 CA 08         [ 2] 4029         orab    #0x08
   A359 F7 18 04      [ 4] 4030         stab    (0x1804)
   A35C 39            [ 5] 4031         rts
                           4032 
   A35D F6 18 04      [ 4] 4033         ldab    (0x1804)
   A360 C4 F7         [ 2] 4034         andb    #0xF7
   A362 F7 18 04      [ 4] 4035         stab    (0x1804)
   A365 39            [ 5] 4036         rts
                           4037 
                           4038 ;'$' command goes here?
   A366 7F 00 4E      [ 6] 4039         clr     (0x004E)
   A369 BD 86 C4      [ 6] 4040         jsr     L86C4
   A36C 7F 04 2A      [ 6] 4041         clr     (0x042A)
                           4042 
   A36F BD F9 D8      [ 6] 4043         jsr     (0xF9D8)
   A372 45 6E 74 65 72 20  4044         .ascis  'Enter security code:' 
        73 65 63 75 72 69
        74 79 20 63 6F 64
        65 BA
                           4045 
   A386 BD A2 EA      [ 6] 4046         jsr     (0xA2EA)
   A389 24 03         [ 3] 4047         bcc     LA38E  
   A38B 7E 83 31      [ 3] 4048         jmp     (0x8331)
                           4049 
   A38E                    4050 LA38E:
   A38E BD F9 D8      [ 6] 4051         jsr     (0xF9D8)
   A391 0C 0A 0D 44 61 76  4052         .ascii  "\f\n\rDave's Setup Utility\n\r"
        65 27 73 20 53 65
        74 75 70 20 55 74
        69 6C 69 74 79 0A
        0D
   A3AA 3C 4B 3E 69 6E 67  4053         .ascii  '<K>ing enable\n\r'
        20 65 6E 61 62 6C
        65 0A 0D
   A3B9 3C 43 3E 6C 65 61  4054         .ascii  '<C>lear random\n\r'
        72 20 72 61 6E 64
        6F 6D 0A 0D
   A3C9 3C 35 3E 20 63 68  4055         .ascii  '<5> character random\n\r'
        61 72 61 63 74 65
        72 20 72 61 6E 64
        6F 6D 0A 0D
   A3DF 3C 4C 3E 69 76 65  4056         .ascii  '<L>ive tape number clear\n\r'
        20 74 61 70 65 20
        6E 75 6D 62 65 72
        20 63 6C 65 61 72
        0A 0D
   A3F9 3C 52 3E 65 67 75  4057         .ascii  '<R>egular tape number clear\n\r'
        6C 61 72 20 74 61
        70 65 20 6E 75 6D
        62 65 72 20 63 6C
        65 61 72 0A 0D
   A416 3C 54 3E 65 73 74  4058         .ascii  '<T>est driver boards\n\r'
        20 64 72 69 76 65
        72 20 62 6F 61 72
        64 73 0A 0D
   A42C 3C 42 3E 75 62 20  4059         .ascii  '<B>ub test\n\r'
        74 65 73 74 0A 0D
   A438 3C 44 3E 65 63 6B  4060         .ascii  '<D>eck test (with tape inserted)\n\r'
        20 74 65 73 74 20
        28 77 69 74 68 20
        74 61 70 65 20 69
        6E 73 65 72 74 65
        64 29 0A 0D
   A45A 3C 37 3E 35 25 20  4061         .ascii  '<7>5% adjustment\n\r'
        61 64 6A 75 73 74
        6D 65 6E 74 0A 0D
   A46C 3C 53 3E 68 6F 77  4062         .ascii  '<S>how re-valid tapes\n\r'
        20 72 65 2D 76 61
        6C 69 64 20 74 61
        70 65 73 0A 0D
   A483 3C 4A 3E 75 6D 70  4063         .ascis  '<J>ump to system\n\r'
        20 74 6F 20 73 79
        73 74 65 6D 0A 8D
                           4064 
   A495                    4065 LA495:
   A495 BD F9 45      [ 6] 4066         jsr     (0xF945)
   A498 24 FB         [ 3] 4067         bcc     LA495  
   A49A 81 43         [ 2] 4068         cmpa    #0x43        ;'C'
   A49C 26 09         [ 3] 4069         bne     LA4A7  
   A49E 7F 04 01      [ 6] 4070         clr     (0x0401)     ;clear random
   A4A1 7F 04 2B      [ 6] 4071         clr     (0x042B)
   A4A4 7E A5 14      [ 3] 4072         jmp     (0xA514)
   A4A7                    4073 LA4A7:
   A4A7 81 35         [ 2] 4074         cmpa    #0x35        ;'5'
   A4A9 26 0D         [ 3] 4075         bne     LA4B8  
   A4AB B6 04 01      [ 4] 4076         ldaa    (0x0401)    ;5 character random
   A4AE 84 7F         [ 2] 4077         anda    #0x7F
   A4B0 8A 7F         [ 2] 4078         oraa    #0x7F
   A4B2 B7 04 01      [ 4] 4079         staa    (0x0401)
   A4B5 7E A5 14      [ 3] 4080         jmp     (0xA514)
   A4B8                    4081 LA4B8:
   A4B8 81 4C         [ 2] 4082         cmpa    #0x4C        ;'L'
   A4BA 26 06         [ 3] 4083         bne     LA4C2  
   A4BC BD 9E AF      [ 6] 4084         jsr     (0x9EAF)     ; reset Liv counts
   A4BF 7E A5 14      [ 3] 4085         jmp     (0xA514)
   A4C2                    4086 LA4C2:
   A4C2 81 52         [ 2] 4087         cmpa    #0x52        ;'R'
   A4C4 26 06         [ 3] 4088         bne     LA4CC  
   A4C6 BD 9E 92      [ 6] 4089         jsr     (0x9E92)     ; reset Reg counts
   A4C9 7E A5 14      [ 3] 4090         jmp     (0xA514)
   A4CC                    4091 LA4CC:
   A4CC 81 54         [ 2] 4092         cmpa    #0x54        ;'T'
   A4CE 26 06         [ 3] 4093         bne     LA4D6  
   A4D0 BD A5 65      [ 6] 4094         jsr     (0xA565)     ;test driver boards
   A4D3 7E A5 14      [ 3] 4095         jmp     (0xA514)
   A4D6                    4096 LA4D6:
   A4D6 81 42         [ 2] 4097         cmpa    #0x42        ;'B'
   A4D8 26 06         [ 3] 4098         bne     LA4E0  
   A4DA BD A5 26      [ 6] 4099         jsr     (0xA526)     ;bulb test?
   A4DD 7E A5 14      [ 3] 4100         jmp     (0xA514)
   A4E0                    4101 LA4E0:
   A4E0 81 44         [ 2] 4102         cmpa    #0x44        ;'D'
   A4E2 26 06         [ 3] 4103         bne     LA4EA  
   A4E4 BD A5 3C      [ 6] 4104         jsr     (0xA53C)     ;deck test
   A4E7 7E A5 14      [ 3] 4105         jmp     (0xA514)
   A4EA                    4106 LA4EA:
   A4EA 81 37         [ 2] 4107         cmpa    #0x37        ;'7'
   A4EC 26 08         [ 3] 4108         bne     LA4F6  
   A4EE C6 FB         [ 2] 4109         ldab    #0xFB
   A4F0 BD 86 E7      [ 6] 4110         jsr     (0x86E7)     ;5% adjustment
   A4F3 7E A5 14      [ 3] 4111         jmp     (0xA514)
   A4F6                    4112 LA4F6:
   A4F6 81 4A         [ 2] 4113         cmpa    #0x4A        ;'J'
   A4F8 26 03         [ 3] 4114         bne     LA4FD  
   A4FA 7E F8 00      [ 3] 4115         jmp     RESET     ;jump to system (reset)
   A4FD                    4116 LA4FD:
   A4FD 81 4B         [ 2] 4117         cmpa    #0x4B        ;'K'
   A4FF 26 06         [ 3] 4118         bne     LA507  
   A501 7C 04 2A      [ 6] 4119         inc     (0x042A)     ;King enable
   A504 7E A5 14      [ 3] 4120         jmp     (0xA514)
   A507                    4121 LA507:
   A507 81 53         [ 2] 4122         cmpa    #0x53        ;'S'
   A509 26 06         [ 3] 4123         bne     LA511  
   A50B BD AB 7C      [ 6] 4124         jsr     (0xAB7C)     ;show re-valid tapes
   A50E 7E A5 14      [ 3] 4125         jmp     (0xA514)
   A511                    4126 LA511:
   A511 7E A4 95      [ 3] 4127         jmp     (0xA495)
   A514 86 07         [ 2] 4128         ldaa    #0x07
   A516 BD F9 6F      [ 6] 4129         jsr     (0xF96F)
   A519 C6 01         [ 2] 4130         ldab    #0x01
   A51B BD 8C 30      [ 6] 4131         jsr     (0x8C30)
   A51E 86 07         [ 2] 4132         ldaa    #0x07
   A520 BD F9 6F      [ 6] 4133         jsr     (0xF96F)
   A523 7E A3 8E      [ 3] 4134         jmp     (0xA38E)
                           4135 
                           4136 ; bulb test
   A526 5F            [ 2] 4137         clrb
   A527 BD F9 C5      [ 6] 4138         jsr     (0xF9C5)
   A52A                    4139 LA52A:
   A52A F6 10 0A      [ 4] 4140         ldab    PORTE
   A52D C8 FF         [ 2] 4141         eorb    #0xFF
   A52F BD F9 C5      [ 6] 4142         jsr     (0xF9C5)
   A532 C1 80         [ 2] 4143         cmpb    #0x80
   A534 26 F4         [ 3] 4144         bne     LA52A  
   A536 C6 02         [ 2] 4145         ldab    #0x02
   A538 BD 8C 30      [ 6] 4146         jsr     (0x8C30)
   A53B 39            [ 5] 4147         rts
                           4148 
                           4149 ; deck test
   A53C C6 FD         [ 2] 4150         ldab    #0xFD
   A53E BD 86 E7      [ 6] 4151         jsr     (0x86E7)
   A541 C6 06         [ 2] 4152         ldab    #0x06
   A543 BD 8C 30      [ 6] 4153         jsr     (0x8C30)
   A546 C6 FB         [ 2] 4154         ldab    #0xFB
   A548 BD 86 E7      [ 6] 4155         jsr     (0x86E7)
   A54B C6 06         [ 2] 4156         ldab    #0x06
   A54D BD 8C 30      [ 6] 4157         jsr     (0x8C30)
   A550 C6 FD         [ 2] 4158         ldab    #0xFD
   A552 BD 86 E7      [ 6] 4159         jsr     (0x86E7)
   A555 C6 F7         [ 2] 4160         ldab    #0xF7
   A557 BD 86 E7      [ 6] 4161         jsr     (0x86E7)
   A55A C6 06         [ 2] 4162         ldab    #0x06
   A55C BD 8C 30      [ 6] 4163         jsr     (0x8C30)
   A55F C6 EF         [ 2] 4164         ldab    #0xEF
   A561 BD 86 E7      [ 6] 4165         jsr     (0x86E7)
   A564 39            [ 5] 4166         rts
                           4167 
                           4168 ; test driver boards
   A565 BD F9 45      [ 6] 4169         jsr     (0xF945)
   A568 24 08         [ 3] 4170         bcc     LA572  
   A56A 81 1B         [ 2] 4171         cmpa    #0x1B
   A56C 26 04         [ 3] 4172         bne     LA572  
   A56E BD 86 C4      [ 6] 4173         jsr     L86C4
   A571 39            [ 5] 4174         rts
   A572                    4175 LA572:
   A572 86 08         [ 2] 4176         ldaa    #0x08
   A574 97 15         [ 3] 4177         staa    (0x0015)
   A576 BD 86 C4      [ 6] 4178         jsr     L86C4
   A579 86 01         [ 2] 4179         ldaa    #0x01
   A57B                    4180 LA57B:
   A57B 36            [ 3] 4181         psha
   A57C 16            [ 2] 4182         tab
   A57D BD F9 C5      [ 6] 4183         jsr     (0xF9C5)
   A580 B6 18 04      [ 4] 4184         ldaa    (0x1804)
   A583 88 08         [ 2] 4185         eora    #0x08
   A585 B7 18 04      [ 4] 4186         staa    (0x1804)
   A588 32            [ 4] 4187         pula
   A589 B7 10 80      [ 4] 4188         staa    (0x1080)
   A58C B7 10 84      [ 4] 4189         staa    (0x1084)
   A58F B7 10 88      [ 4] 4190         staa    (0x1088)
   A592 B7 10 8C      [ 4] 4191         staa    (0x108C)
   A595 B7 10 90      [ 4] 4192         staa    (0x1090)
   A598 B7 10 94      [ 4] 4193         staa    (0x1094)
   A59B B7 10 98      [ 4] 4194         staa    (0x1098)
   A59E B7 10 9C      [ 4] 4195         staa    (0x109C)
   A5A1 C6 14         [ 2] 4196         ldab    #0x14
   A5A3 BD A6 52      [ 6] 4197         jsr     (0xA652)
   A5A6 49            [ 2] 4198         rola
   A5A7 36            [ 3] 4199         psha
   A5A8 D6 15         [ 3] 4200         ldab    (0x0015)
   A5AA 5A            [ 2] 4201         decb
   A5AB D7 15         [ 3] 4202         stab    (0x0015)
   A5AD BD F9 95      [ 6] 4203         jsr     (0xF995)         ; write digit to the diag display
   A5B0 37            [ 3] 4204         pshb
   A5B1 C6 27         [ 2] 4205         ldab    #0x27
   A5B3 96 15         [ 3] 4206         ldaa    (0x0015)
   A5B5 0C            [ 2] 4207         clc
   A5B6 89 30         [ 2] 4208         adca    #0x30
   A5B8 BD 8D B5      [ 6] 4209         jsr     (0x8DB5)         ; display char here on LCD display
   A5BB 33            [ 4] 4210         pulb
   A5BC 32            [ 4] 4211         pula
   A5BD 5D            [ 2] 4212         tstb
   A5BE 26 BB         [ 3] 4213         bne     LA57B  
   A5C0 86 08         [ 2] 4214         ldaa    #0x08
   A5C2 97 15         [ 3] 4215         staa    (0x0015)
   A5C4 BD 86 C4      [ 6] 4216         jsr     L86C4
   A5C7 86 01         [ 2] 4217         ldaa    #0x01
   A5C9                    4218 LA5C9:
   A5C9 B7 10 82      [ 4] 4219         staa    (0x1082)
   A5CC B7 10 86      [ 4] 4220         staa    (0x1086)
   A5CF B7 10 8A      [ 4] 4221         staa    (0x108A)
   A5D2 B7 10 8E      [ 4] 4222         staa    (0x108E)
   A5D5 B7 10 92      [ 4] 4223         staa    (0x1092)
   A5D8 B7 10 96      [ 4] 4224         staa    (0x1096)
   A5DB B7 10 9A      [ 4] 4225         staa    (0x109A)
   A5DE B7 10 9E      [ 4] 4226         staa    (0x109E)
   A5E1 C6 14         [ 2] 4227         ldab    #0x14
   A5E3 BD A6 52      [ 6] 4228         jsr     (0xA652)
   A5E6 49            [ 2] 4229         rola
   A5E7 36            [ 3] 4230         psha
   A5E8 D6 15         [ 3] 4231         ldab    (0x0015)
   A5EA 5A            [ 2] 4232         decb
   A5EB D7 15         [ 3] 4233         stab    (0x0015)
   A5ED BD F9 95      [ 6] 4234         jsr     (0xF995)          ; write digit to the diag display
   A5F0 37            [ 3] 4235         pshb
   A5F1 C6 27         [ 2] 4236         ldab    #0x27
   A5F3 96 15         [ 3] 4237         ldaa    (0x0015)
   A5F5 0C            [ 2] 4238         clc
   A5F6 89 30         [ 2] 4239         adca    #0x30
   A5F8 BD 8D B5      [ 6] 4240         jsr     (0x8DB5)         ; display char here on LCD display
   A5FB 33            [ 4] 4241         pulb
   A5FC 32            [ 4] 4242         pula
   A5FD 7D 00 15      [ 6] 4243         tst     (0x0015)
   A600 26 C7         [ 3] 4244         bne     LA5C9  
   A602 BD 86 C4      [ 6] 4245         jsr     L86C4
   A605 CE 10 80      [ 3] 4246         ldx     #0x1080
   A608 C6 00         [ 2] 4247         ldab    #0x00
   A60A                    4248 LA60A:
   A60A 86 FF         [ 2] 4249         ldaa    #0xFF
   A60C A7 00         [ 4] 4250         staa    0,X     
   A60E A7 02         [ 4] 4251         staa    2,X     
   A610 37            [ 3] 4252         pshb
   A611 C6 1E         [ 2] 4253         ldab    #0x1E
   A613 BD A6 52      [ 6] 4254         jsr     (0xA652)
   A616 33            [ 4] 4255         pulb
   A617 86 00         [ 2] 4256         ldaa    #0x00
   A619 A7 00         [ 4] 4257         staa    0,X     
   A61B A7 02         [ 4] 4258         staa    2,X     
   A61D 5C            [ 2] 4259         incb
   A61E 3C            [ 4] 4260         pshx
   A61F BD F9 95      [ 6] 4261         jsr     (0xF995)              ; write digit to the diag display
   A622 37            [ 3] 4262         pshb
   A623 C6 27         [ 2] 4263         ldab    #0x27
   A625 32            [ 4] 4264         pula
   A626 36            [ 3] 4265         psha
   A627 0C            [ 2] 4266         clc
   A628 89 30         [ 2] 4267         adca    #0x30
   A62A BD 8D B5      [ 6] 4268         jsr     (0x8DB5)         ; display char here on LCD display
   A62D 33            [ 4] 4269         pulb
   A62E 38            [ 5] 4270         pulx
   A62F 08            [ 3] 4271         inx
   A630 08            [ 3] 4272         inx
   A631 08            [ 3] 4273         inx
   A632 08            [ 3] 4274         inx
   A633 8C 10 9D      [ 4] 4275         cpx     #0x109D
   A636 25 D2         [ 3] 4276         bcs     LA60A  
   A638 CE 10 80      [ 3] 4277         ldx     #0x1080
   A63B                    4278 LA63B:
   A63B 86 FF         [ 2] 4279         ldaa    #0xFF
   A63D A7 00         [ 4] 4280         staa    0,X     
   A63F A7 02         [ 4] 4281         staa    2,X     
   A641 08            [ 3] 4282         inx
   A642 08            [ 3] 4283         inx
   A643 08            [ 3] 4284         inx
   A644 08            [ 3] 4285         inx
   A645 8C 10 9D      [ 4] 4286         cpx     #0x109D
   A648 25 F1         [ 3] 4287         bcs     LA63B  
   A64A C6 06         [ 2] 4288         ldab    #0x06
   A64C BD 8C 30      [ 6] 4289         jsr     (0x8C30)
   A64F 7E A5 65      [ 3] 4290         jmp     (0xA565)
   A652 36            [ 3] 4291         psha
   A653 4F            [ 2] 4292         clra
   A654 DD 23         [ 4] 4293         std     CDTIMR5
   A656                    4294 LA656:
   A656 7D 00 24      [ 6] 4295         tst     CDTIMR5+1
   A659 26 FB         [ 3] 4296         bne     LA656  
   A65B 32            [ 4] 4297         pula
   A65C 39            [ 5] 4298         rts
                           4299 
                           4300 ; Comma-seperated text
   A65D                    4301 LA65D:
   A65D 30 2C 43 68 75 63  4302         .ascii  '0,Chuck,Mouth,'
        6B 2C 4D 6F 75 74
        68 2C
   A66B 31 2C 48 65 61 64  4303         .ascii  '1,Head left,'
        20 6C 65 66 74 2C
   A677 32 2C 48 65 61 64  4304         .ascii  '2,Head right,'
        20 72 69 67 68 74
        2C
   A684 32 2C 48 65 61 64  4305         .ascii  '2,Head up,'
        20 75 70 2C
   A68E 32 2C 45 79 65 73  4306         .ascii  '2,Eyes right,'
        20 72 69 67 68 74
        2C
   A69B 31 2C 45 79 65 6C  4307         .ascii  '1,Eyelids,'
        69 64 73 2C
   A6A5 31 2C 52 69 67 68  4308         .ascii  '1,Right hand,'
        74 20 68 61 6E 64
        2C
   A6B2 32 2C 45 79 65 73  4309         .ascii  '2,Eyes left,'
        20 6C 65 66 74 2C
   A6BE 31 2C 38 2C 48 65  4310         .ascii  '1,8,Helen,Mouth,'
        6C 65 6E 2C 4D 6F
        75 74 68 2C
   A6CE 31 2C 48 65 61 64  4311         .ascii  '1,Head left,'
        20 6C 65 66 74 2C
   A6DA 32 2C 48 65 61 64  4312         .ascii  '2,Head right,'
        20 72 69 67 68 74
        2C
   A6E7 32 2C 48 65 61 64  4313         .ascii  '2,Head up,'
        20 75 70 2C
   A6F1 32 2C 45 79 65 73  4314         .ascii  '2,Eyes right,'
        20 72 69 67 68 74
        2C
   A6FE 31 2C 45 79 65 6C  4315         .ascii  '1,Eyelids,'
        69 64 73 2C
   A708 31 2C 52 69 67 68  4316         .ascii  '1,Right hand,'
        74 20 68 61 6E 64
        2C
   A715 32 2C 45 79 65 73  4317         .ascii  '2,Eyes left,'
        20 6C 65 66 74 2C
   A721 31 2C 36 2C 4D 75  4318         .ascii  '1,6,Munch,Mouth,'
        6E 63 68 2C 4D 6F
        75 74 68 2C
   A731 31 2C 48 65 61 64  4319         .ascii  '1,Head left,'
        20 6C 65 66 74 2C
   A73D 32 2C 48 65 61 64  4320         .ascii  '2,Head right,'
        20 72 69 67 68 74
        2C
   A74A 32 2C 4C 65 66 74  4321         .ascii  '2,Left arm,'
        20 61 72 6D 2C
   A755 32 2C 45 79 65 73  4322         .ascii  '2,Eyes right,'
        20 72 69 67 68 74
        2C
   A762 31 2C 45 79 65 6C  4323         .ascii  '1,Eyelids,'
        69 64 73 2C
   A76C 31 2C 52 69 67 68  4324         .ascii  '1,Right arm,'
        74 20 61 72 6D 2C
   A778 32 2C 45 79 65 73  4325         .ascii  '2,Eyes left,'
        20 6C 65 66 74 2C
   A784 31 2C 32 2C 4A 61  4326         .ascii  '1,2,Jasper,Mouth,'
        73 70 65 72 2C 4D
        6F 75 74 68 2C
   A795 31 2C 48 65 61 64  4327         .ascii  '1,Head left,'
        20 6C 65 66 74 2C
   A7A1 32 2C 48 65 61 64  4328         .ascii  '2,Head right,'
        20 72 69 67 68 74
        2C
   A7AE 32 2C 48 65 61 64  4329         .ascii  '2,Head up,'
        20 75 70 2C
   A7B8 32 2C 45 79 65 73  4330         .ascii  '2,Eyes right,'
        20 72 69 67 68 74
        2C
   A7C5 31 2C 45 79 65 6C  4331         .ascii  '1,Eyelids,'
        69 64 73 2C
   A7CF 31 2C 48 61 6E 64  4332         .ascii  '1,Hands,'
        73 2C
   A7D7 32 2C 45 79 65 73  4333         .ascii  '2,Eyes left,'
        20 6C 65 66 74 2C
   A7E3 31 2C 34 2C 50 61  4334         .ascii  '1,4,Pasqually,Mouth-Mustache,'
        73 71 75 61 6C 6C
        79 2C 4D 6F 75 74
        68 2D 4D 75 73 74
        61 63 68 65 2C
   A800 31 2C 48 65 61 64  4335         .ascii  '1,Head left,'
        20 6C 65 66 74 2C
   A80C 32 2C 48 65 61 64  4336         .ascii  '2,Head right,'
        20 72 69 67 68 74
        2C
   A819 32 2C 4C 65 66 74  4337         .ascii  '2,Left arm,'
        20 61 72 6D 2C
   A824 32 2C 45 79 65 73  4338         .ascii  '2,Eyes right,'
        20 72 69 67 68 74
        2C
   A831 31 2C 45 79 65 6C  4339         .ascii  '1,Eyelids,'
        69 64 73 2C
   A83B 31 2C 52 69 67 68  4340         .ascii  '1,Right arm,'
        74 20 61 72 6D 2C
   A847 32 2C 45 79 65 73  4341         .ascii  '2,Eyes left,1,<'
        20 6C 65 66 74 2C
        31 2C 3C
                           4342 
   A856 BD 86 C4      [ 6] 4343         jsr     L86C4
   A859 CE 10 80      [ 3] 4344         ldx     #0x1080
   A85C 86 20         [ 2] 4345         ldaa    #0x20
   A85E A7 00         [ 4] 4346         staa    0,X
   A860 A7 04         [ 4] 4347         staa    4,X
   A862 A7 08         [ 4] 4348         staa    8,X
   A864 A7 0C         [ 4] 4349         staa    12,X
   A866 A7 10         [ 4] 4350         staa    16,X
   A868 38            [ 5] 4351         pulx
   A869 39            [ 5] 4352         rts
                           4353 
   A86A BD A3 2E      [ 6] 4354         jsr     (0xA32E)
                           4355 
   A86D BD 8D E4      [ 6] 4356         jsr     (0x8DE4)
   A870 20 20 20 20 57 61  4357         .ascis  '    Warm-Up  '
        72 6D 2D 55 70 20
        A0
                           4358 
   A87D BD 8D DD      [ 6] 4359         jsr     (0x8DDD)
   A880 43 75 72 74 61 69  4360         .ascis  'Curtains opening'
        6E 73 20 6F 70 65
        6E 69 6E E7
                           4361 
   A890 C6 14         [ 2] 4362         ldab    #0x14
   A892 BD 8C 30      [ 6] 4363         jsr     (0x8C30)
   A895 BD A8 55      [ 6] 4364         jsr     (0xA855)
   A898 C6 02         [ 2] 4365         ldab    #0x02
   A89A BD 8C 30      [ 6] 4366         jsr     (0x8C30)
   A89D CE A6 5D      [ 3] 4367         ldx     #LA65D
   A8A0 C6 05         [ 2] 4368         ldab    #0x05
   A8A2 D7 12         [ 3] 4369         stab    (0x0012)
   A8A4 C6 08         [ 2] 4370         ldab    #0x08
   A8A6 D7 13         [ 3] 4371         stab    (0x0013)
   A8A8 BD A9 41      [ 6] 4372         jsr     (0xA941)
   A8AB BD A9 4C      [ 6] 4373         jsr     (0xA94C)
   A8AE C6 02         [ 2] 4374         ldab    #0x02
   A8B0 BD 8C 30      [ 6] 4375         jsr     (0x8C30)
   A8B3                    4376 LA8B3:
   A8B3 BD A9 5E      [ 6] 4377         jsr     (0xA95E)
   A8B6 A6 00         [ 4] 4378         ldaa    0,X     
   A8B8 80 30         [ 2] 4379         suba    #0x30
   A8BA 08            [ 3] 4380         inx
   A8BB 08            [ 3] 4381         inx
   A8BC 36            [ 3] 4382         psha
   A8BD 7C 00 4C      [ 6] 4383         inc     (0x004C)
   A8C0 3C            [ 4] 4384         pshx
   A8C1 BD 88 E5      [ 6] 4385         jsr     (0x88E5)
   A8C4 38            [ 5] 4386         pulx
   A8C5 86 4F         [ 2] 4387         ldaa    #0x4F            ;'O'
   A8C7 C6 0C         [ 2] 4388         ldab    #0x0C
   A8C9 BD 8D B5      [ 6] 4389         jsr     (0x8DB5)         ; display char here on LCD display
   A8CC 86 6E         [ 2] 4390         ldaa    #0x6E            ;'n'
   A8CE C6 0D         [ 2] 4391         ldab    #0x0D
   A8D0 BD 8D B5      [ 6] 4392         jsr     (0x8DB5)         ; display char here on LCD display
   A8D3 CC 20 0E      [ 3] 4393         ldd     #0x200E           ;' '
   A8D6 BD 8D B5      [ 6] 4394         jsr     (0x8DB5)         ; display char here on LCD display
   A8D9 7A 00 4C      [ 6] 4395         dec     (0x004C)
   A8DC 32            [ 4] 4396         pula
   A8DD 36            [ 3] 4397         psha
   A8DE C6 64         [ 2] 4398         ldab    #0x64
   A8E0 3D            [10] 4399         mul
   A8E1 DD 23         [ 4] 4400         std     CDTIMR5
   A8E3                    4401 LA8E3:
   A8E3 DC 23         [ 4] 4402         ldd     CDTIMR5
   A8E5 26 FC         [ 3] 4403         bne     LA8E3  
   A8E7 BD 8E 95      [ 6] 4404         jsr     (0x8E95)
   A8EA 81 0D         [ 2] 4405         cmpa    #0x0D
   A8EC 26 05         [ 3] 4406         bne     LA8F3  
   A8EE BD A9 75      [ 6] 4407         jsr     (0xA975)
   A8F1 20 10         [ 3] 4408         bra     LA903  
   A8F3                    4409 LA8F3:
   A8F3 81 01         [ 2] 4410         cmpa    #0x01
   A8F5 26 04         [ 3] 4411         bne     LA8FB  
   A8F7 32            [ 4] 4412         pula
   A8F8 7E A8 95      [ 3] 4413         jmp     (0xA895)
   A8FB                    4414 LA8FB:
   A8FB 81 02         [ 2] 4415         cmpa    #0x02
   A8FD 26 04         [ 3] 4416         bne     LA903  
   A8FF 32            [ 4] 4417         pula
   A900 7E A9 35      [ 3] 4418         jmp     (0xA935)
   A903                    4419 LA903:
   A903 3C            [ 4] 4420         pshx
   A904 BD 88 E5      [ 6] 4421         jsr     (0x88E5)
   A907 38            [ 5] 4422         pulx
   A908 86 66         [ 2] 4423         ldaa    #0x66            ;'f'
   A90A C6 0D         [ 2] 4424         ldab    #0x0D
   A90C BD 8D B5      [ 6] 4425         jsr     (0x8DB5)         ; display char here on LCD display
   A90F 86 66         [ 2] 4426         ldaa    #0x66            ;'f'
   A911 C6 0E         [ 2] 4427         ldab    #0x0E
   A913 BD 8D B5      [ 6] 4428         jsr     (0x8DB5)         ; display char here on LCD display
   A916 32            [ 4] 4429         pula
   A917 C6 64         [ 2] 4430         ldab    #0x64
   A919 3D            [10] 4431         mul
   A91A DD 23         [ 4] 4432         std     CDTIMR5
   A91C                    4433 LA91C:
   A91C DC 23         [ 4] 4434         ldd     CDTIMR5
   A91E 26 FC         [ 3] 4435         bne     LA91C  
   A920 BD A8 55      [ 6] 4436         jsr     (0xA855)
   A923 7C 00 4B      [ 6] 4437         inc     (0x004B)
   A926 96 4B         [ 3] 4438         ldaa    (0x004B)
   A928 81 48         [ 2] 4439         cmpa    #0x48
   A92A 25 87         [ 3] 4440         bcs     LA8B3  
   A92C 96 4C         [ 3] 4441         ldaa    (0x004C)
   A92E 81 34         [ 2] 4442         cmpa    #0x34
   A930 27 03         [ 3] 4443         beq     LA935  
   A932 7E A8 A4      [ 3] 4444         jmp     (0xA8A4)
   A935                    4445 LA935:
   A935 C6 02         [ 2] 4446         ldab    #0x02
   A937 BD 8C 30      [ 6] 4447         jsr     (0x8C30)
   A93A BD 86 C4      [ 6] 4448         jsr     L86C4
   A93D BD A3 41      [ 6] 4449         jsr     (0xA341)
   A940 39            [ 5] 4450         rts
                           4451 
   A941 A6 00         [ 4] 4452         ldaa    0,X     
   A943 08            [ 3] 4453         inx
   A944 08            [ 3] 4454         inx
   A945 97 4C         [ 3] 4455         staa    (0x004C)
   A947 86 40         [ 2] 4456         ldaa    #0x40
   A949 97 4B         [ 3] 4457         staa    (0x004B)
   A94B 39            [ 5] 4458         rts
                           4459 
   A94C BD 8C F2      [ 6] 4460         jsr     (0x8CF2)
   A94F                    4461 LA94F:
   A94F A6 00         [ 4] 4462         ldaa    0,X     
   A951 08            [ 3] 4463         inx
   A952 81 2C         [ 2] 4464         cmpa    #0x2C
   A954 27 07         [ 3] 4465         beq     LA95D  
   A956 36            [ 3] 4466         psha
   A957 BD 8E 70      [ 6] 4467         jsr     (0x8E70)
   A95A 32            [ 4] 4468         pula
   A95B 20 F2         [ 3] 4469         bra     LA94F  
   A95D                    4470 LA95D:
   A95D 39            [ 5] 4471         rts
                           4472 
   A95E BD 8D 03      [ 6] 4473         jsr     (0x8D03)
   A961 86 C0         [ 2] 4474         ldaa    #0xC0
   A963 BD 8E 4B      [ 6] 4475         jsr     (0x8E4B)
   A966                    4476 LA966:
   A966 A6 00         [ 4] 4477         ldaa    0,X     
   A968 08            [ 3] 4478         inx
   A969 81 2C         [ 2] 4479         cmpa    #0x2C
   A96B 27 07         [ 3] 4480         beq     LA974  
   A96D 36            [ 3] 4481         psha
   A96E BD 8E 70      [ 6] 4482         jsr     (0x8E70)
   A971 32            [ 4] 4483         pula
   A972 20 F2         [ 3] 4484         bra     LA966  
   A974                    4485 LA974:
   A974 39            [ 5] 4486         rts
                           4487 
   A975                    4488 LA975:
   A975 BD 8E 95      [ 6] 4489         jsr     (0x8E95)
   A978 4D            [ 2] 4490         tsta
   A979 27 FA         [ 3] 4491         beq     LA975  
   A97B 39            [ 5] 4492         rts
                           4493 
   A97C 7F 00 60      [ 6] 4494         clr     (0x0060)
   A97F FC 02 9C      [ 5] 4495         ldd     (0x029C)
   A982 1A 83 00 01   [ 5] 4496         cpd     #0x0001
   A986 27 0C         [ 3] 4497         beq     LA994  
   A988 1A 83 03 E8   [ 5] 4498         cpd     #0x03E8
   A98C 2D 7D         [ 3] 4499         blt     LAA0B  
   A98E 1A 83 04 4B   [ 5] 4500         cpd     #0x044B
   A992 22 77         [ 3] 4501         bhi     LAA0B  
   A994                    4502 LA994:
   A994 C6 40         [ 2] 4503         ldab    #0x40
   A996 D7 62         [ 3] 4504         stab    (0x0062)
   A998 BD F9 C5      [ 6] 4505         jsr     (0xF9C5)
   A99B C6 64         [ 2] 4506         ldab    #0x64
   A99D BD 8C 22      [ 6] 4507         jsr     (0x8C22)
   A9A0 BD 86 C4      [ 6] 4508         jsr     L86C4
   A9A3 BD 8C E9      [ 6] 4509         jsr     (0x8CE9)
                           4510 
   A9A6 BD 8D E4      [ 6] 4511         jsr     (0x8DE4)
   A9A9 20 20 20 20 20 53  4512         .ascis  '     STUDIO'
        54 55 44 49 CF
                           4513 
   A9B4 BD 8D DD      [ 6] 4514         jsr     (0x8DDD)
   A9B7 70 72 6F 67 72 61  4515         .ascis  'programming mode'
        6D 6D 69 6E 67 20
        6D 6F 64 E5
                           4516 
   A9C7 BD A3 2E      [ 6] 4517         jsr     (0xA32E)
   A9CA BD 99 9E      [ 6] 4518         jsr     (0x999E)
   A9CD BD 99 B1      [ 6] 4519         jsr     (0x99B1)
   A9D0 CE 20 00      [ 3] 4520         ldx     #0x2000
   A9D3                    4521 LA9D3:
   A9D3 18 CE 00 C0   [ 4] 4522         ldy     #0x00C0
   A9D7                    4523 LA9D7:
   A9D7 18 09         [ 4] 4524         dey
   A9D9 26 0A         [ 3] 4525         bne     LA9E5  
   A9DB BD A9 F4      [ 6] 4526         jsr     (0xA9F4)
   A9DE 96 60         [ 3] 4527         ldaa    (0x0060)
   A9E0 26 29         [ 3] 4528         bne     LAA0B  
   A9E2 CE 20 00      [ 3] 4529         ldx     #0x2000
   A9E5                    4530 LA9E5:
   A9E5 B6 10 A8      [ 4] 4531         ldaa    (0x10A8)
   A9E8 84 01         [ 2] 4532         anda    #0x01
   A9EA 27 EB         [ 3] 4533         beq     LA9D7  
   A9EC B6 10 A9      [ 4] 4534         ldaa    (0x10A9)
   A9EF A7 00         [ 4] 4535         staa    0,X     
   A9F1 08            [ 3] 4536         inx
   A9F2 20 DF         [ 3] 4537         bra     LA9D3  
   A9F4 CE 20 00      [ 3] 4538         ldx     #0x2000
   A9F7 18 CE 10 80   [ 4] 4539         ldy     #0x1080
   A9FB                    4540 LA9FB:
   A9FB A6 00         [ 4] 4541         ldaa    0,X     
   A9FD 18 A7 00      [ 5] 4542         staa    0,Y     
   AA00 08            [ 3] 4543         inx
   AA01 18 08         [ 4] 4544         iny
   AA03 18 08         [ 4] 4545         iny
   AA05 8C 20 10      [ 4] 4546         cpx     #0x2010
   AA08 25 F1         [ 3] 4547         bcs     LA9FB  
   AA0A 39            [ 5] 4548         rts
   AA0B                    4549 LAA0B:
   AA0B 39            [ 5] 4550         rts
   AA0C CC 48 37      [ 3] 4551         ldd     #0x4837           ;'H'
   AA0F                    4552 LAA0F:
   AA0F BD 8D B5      [ 6] 4553         jsr     (0x8DB5)         ; display char here on LCD display
   AA12 39            [ 5] 4554         rts
   AA13 CC 20 37      [ 3] 4555         ldd     #0x2037           ;' '
   AA16 20 F7         [ 3] 4556         bra     LAA0F  
   AA18 CC 42 0F      [ 3] 4557         ldd     #0x420F           ;'B'
   AA1B 20 F2         [ 3] 4558         bra     LAA0F  
   AA1D CC 20 0F      [ 3] 4559         ldd     #0x200F           ;' '
   AA20 20 ED         [ 3] 4560         bra     LAA0F  
   AA22 7F 00 4F      [ 6] 4561         clr     (0x004F)
   AA25 CC 00 01      [ 3] 4562         ldd     #0x0001
   AA28 DD 1B         [ 4] 4563         std     CDTIMR1
   AA2A CE 20 00      [ 3] 4564         ldx     #0x2000
   AA2D                    4565 LAA2D:
   AA2D B6 10 A8      [ 4] 4566         ldaa    (0x10A8)
   AA30 84 01         [ 2] 4567         anda    #0x01
   AA32 27 F9         [ 3] 4568         beq     LAA2D  
   AA34 DC 1B         [ 4] 4569         ldd     CDTIMR1
   AA36 0F            [ 2] 4570         sei
   AA37 26 03         [ 3] 4571         bne     LAA3C  
   AA39 CE 20 00      [ 3] 4572         ldx     #0x2000
   AA3C                    4573 LAA3C:
   AA3C B6 10 A9      [ 4] 4574         ldaa    (0x10A9)
   AA3F A7 00         [ 4] 4575         staa    0,X     
   AA41 0E            [ 2] 4576         cli
   AA42 BD F9 6F      [ 6] 4577         jsr     (0xF96F)
   AA45 08            [ 3] 4578         inx
   AA46 7F 00 4F      [ 6] 4579         clr     (0x004F)
   AA49 CC 00 01      [ 3] 4580         ldd     #0x0001
   AA4C DD 1B         [ 4] 4581         std     CDTIMR1
   AA4E 8C 20 23      [ 4] 4582         cpx     #0x2023
   AA51 26 DA         [ 3] 4583         bne     LAA2D  
   AA53 CE 20 00      [ 3] 4584         ldx     #0x2000
   AA56 7F 00 B7      [ 6] 4585         clr     (0x00B7)
   AA59                    4586 LAA59:
   AA59 A6 00         [ 4] 4587         ldaa    0,X     
   AA5B 9B B7         [ 3] 4588         adda    (0x00B7)
   AA5D 97 B7         [ 3] 4589         staa    (0x00B7)
   AA5F 08            [ 3] 4590         inx
   AA60 8C 20 22      [ 4] 4591         cpx     #0x2022
   AA63 25 F4         [ 3] 4592         bcs     LAA59  
   AA65 96 B7         [ 3] 4593         ldaa    (0x00B7)
   AA67 88 FF         [ 2] 4594         eora    #0xFF
   AA69 A1 00         [ 4] 4595         cmpa    0,X     
   AA6B CE 20 00      [ 3] 4596         ldx     #0x2000
   AA6E A6 20         [ 4] 4597         ldaa    0x20,X
   AA70 2B 03         [ 3] 4598         bmi     LAA75  
   AA72 7E AA 22      [ 3] 4599         jmp     (0xAA22)
   AA75                    4600 LAA75:
   AA75 A6 00         [ 4] 4601         ldaa    0,X     
   AA77 B7 10 80      [ 4] 4602         staa    (0x1080)
   AA7A 08            [ 3] 4603         inx
   AA7B A6 00         [ 4] 4604         ldaa    0,X     
   AA7D B7 10 82      [ 4] 4605         staa    (0x1082)
   AA80 08            [ 3] 4606         inx
   AA81 A6 00         [ 4] 4607         ldaa    0,X     
   AA83 B7 10 84      [ 4] 4608         staa    (0x1084)
   AA86 08            [ 3] 4609         inx
   AA87 A6 00         [ 4] 4610         ldaa    0,X     
   AA89 B7 10 86      [ 4] 4611         staa    (0x1086)
   AA8C 08            [ 3] 4612         inx
   AA8D A6 00         [ 4] 4613         ldaa    0,X     
   AA8F B7 10 88      [ 4] 4614         staa    (0x1088)
   AA92 08            [ 3] 4615         inx
   AA93 A6 00         [ 4] 4616         ldaa    0,X     
   AA95 B7 10 8A      [ 4] 4617         staa    (0x108A)
   AA98 08            [ 3] 4618         inx
   AA99 A6 00         [ 4] 4619         ldaa    0,X     
   AA9B B7 10 8C      [ 4] 4620         staa    (0x108C)
   AA9E 08            [ 3] 4621         inx
   AA9F A6 00         [ 4] 4622         ldaa    0,X     
   AAA1 B7 10 8E      [ 4] 4623         staa    (0x108E)
   AAA4 08            [ 3] 4624         inx
   AAA5 A6 00         [ 4] 4625         ldaa    0,X     
   AAA7 B7 10 90      [ 4] 4626         staa    (0x1090)
   AAAA 08            [ 3] 4627         inx
   AAAB A6 00         [ 4] 4628         ldaa    0,X     
   AAAD B7 10 92      [ 4] 4629         staa    (0x1092)
   AAB0 08            [ 3] 4630         inx
   AAB1 A6 00         [ 4] 4631         ldaa    0,X     
   AAB3 8A 80         [ 2] 4632         oraa    #0x80
   AAB5 B7 10 94      [ 4] 4633         staa    (0x1094)
   AAB8 08            [ 3] 4634         inx
   AAB9 A6 00         [ 4] 4635         ldaa    0,X     
   AABB 8A 01         [ 2] 4636         oraa    #0x01
   AABD B7 10 96      [ 4] 4637         staa    (0x1096)
   AAC0 08            [ 3] 4638         inx
   AAC1 A6 00         [ 4] 4639         ldaa    0,X     
   AAC3 B7 10 98      [ 4] 4640         staa    (0x1098)
   AAC6 08            [ 3] 4641         inx
   AAC7 A6 00         [ 4] 4642         ldaa    0,X     
   AAC9 B7 10 9A      [ 4] 4643         staa    (0x109A)
   AACC 08            [ 3] 4644         inx
   AACD A6 00         [ 4] 4645         ldaa    0,X     
   AACF B7 10 9C      [ 4] 4646         staa    (0x109C)
   AAD2 08            [ 3] 4647         inx
   AAD3 A6 00         [ 4] 4648         ldaa    0,X     
   AAD5 B7 10 9E      [ 4] 4649         staa    (0x109E)
   AAD8 7E AA 22      [ 3] 4650         jmp     (0xAA22)
   AADB 7F 10 98      [ 6] 4651         clr     (0x1098)
   AADE 7F 10 9A      [ 6] 4652         clr     (0x109A)
   AAE1 7F 10 9C      [ 6] 4653         clr     (0x109C)
   AAE4 7F 10 9E      [ 6] 4654         clr     (0x109E)
   AAE7 39            [ 5] 4655         rts
                           4656 
   AAE8 CE 04 2C      [ 3] 4657         ldx     #0x042C
   AAEB C6 10         [ 2] 4658         ldab    #0x10
   AAED                    4659 LAAED:
   AAED 5D            [ 2] 4660         tstb
   AAEE 27 12         [ 3] 4661         beq     LAB02  
   AAF0 A6 00         [ 4] 4662         ldaa    0,X     
   AAF2 81 30         [ 2] 4663         cmpa    #0x30
   AAF4 25 0D         [ 3] 4664         bcs     LAB03  
   AAF6 81 39         [ 2] 4665         cmpa    #0x39
   AAF8 22 09         [ 3] 4666         bhi     LAB03  
   AAFA 08            [ 3] 4667         inx
   AAFB 08            [ 3] 4668         inx
   AAFC 08            [ 3] 4669         inx
   AAFD 8C 04 59      [ 4] 4670         cpx     #0x0459
   AB00 23 EB         [ 3] 4671         bls     LAAED  
   AB02                    4672 LAB02:
   AB02 39            [ 5] 4673         rts
                           4674 
   AB03                    4675 LAB03:
   AB03 5A            [ 2] 4676         decb
   AB04 3C            [ 4] 4677         pshx
   AB05                    4678 LAB05:
   AB05 A6 03         [ 4] 4679         ldaa    3,X     
   AB07 A7 00         [ 4] 4680         staa    0,X     
   AB09 08            [ 3] 4681         inx
   AB0A 8C 04 5C      [ 4] 4682         cpx     #0x045C
   AB0D 25 F6         [ 3] 4683         bcs     LAB05  
   AB0F 86 FF         [ 2] 4684         ldaa    #0xFF
   AB11 B7 04 59      [ 4] 4685         staa    (0x0459)
   AB14 38            [ 5] 4686         pulx
   AB15 20 D6         [ 3] 4687         bra     LAAED  
   AB17 CE 04 2C      [ 3] 4688         ldx     #0x042C
   AB1A 86 FF         [ 2] 4689         ldaa    #0xFF
   AB1C                    4690 LAB1C:
   AB1C A7 00         [ 4] 4691         staa    0,X     
   AB1E 08            [ 3] 4692         inx
   AB1F 8C 04 5C      [ 4] 4693         cpx     #0x045C
   AB22 25 F8         [ 3] 4694         bcs     LAB1C  
   AB24 39            [ 5] 4695         rts
                           4696 
   AB25 CE 04 2C      [ 3] 4697         ldx     #0x042C
   AB28                    4698 LAB28:
   AB28 A6 00         [ 4] 4699         ldaa    0,X     
   AB2A 81 30         [ 2] 4700         cmpa    #0x30
   AB2C 25 17         [ 3] 4701         bcs     LAB45  
   AB2E 81 39         [ 2] 4702         cmpa    #0x39
   AB30 22 13         [ 3] 4703         bhi     LAB45  
   AB32 08            [ 3] 4704         inx
   AB33 08            [ 3] 4705         inx
   AB34 08            [ 3] 4706         inx
   AB35 8C 04 5C      [ 4] 4707         cpx     #0x045C
   AB38 25 EE         [ 3] 4708         bcs     LAB28  
   AB3A 86 FF         [ 2] 4709         ldaa    #0xFF
   AB3C B7 04 2C      [ 4] 4710         staa    (0x042C)
   AB3F BD AA E8      [ 6] 4711         jsr     (0xAAE8)
   AB42 CE 04 59      [ 3] 4712         ldx     #0x0459
   AB45                    4713 LAB45:
   AB45 39            [ 5] 4714         rts
                           4715 
   AB46 B6 02 99      [ 4] 4716         ldaa    (0x0299)
   AB49 A7 00         [ 4] 4717         staa    0,X     
   AB4B B6 02 9A      [ 4] 4718         ldaa    (0x029A)
   AB4E A7 01         [ 4] 4719         staa    1,X     
   AB50 B6 02 9B      [ 4] 4720         ldaa    (0x029B)
   AB53 A7 02         [ 4] 4721         staa    2,X     
   AB55 39            [ 5] 4722         rts
                           4723 
   AB56 CE 04 2C      [ 3] 4724         ldx     #0x042C
   AB59                    4725 LAB59:
   AB59 B6 02 99      [ 4] 4726         ldaa    (0x0299)
   AB5C A1 00         [ 4] 4727         cmpa    0,X     
   AB5E 26 10         [ 3] 4728         bne     LAB70  
   AB60 B6 02 9A      [ 4] 4729         ldaa    (0x029A)
   AB63 A1 01         [ 4] 4730         cmpa    1,X     
   AB65 26 09         [ 3] 4731         bne     LAB70  
   AB67 B6 02 9B      [ 4] 4732         ldaa    (0x029B)
   AB6A A1 02         [ 4] 4733         cmpa    2,X     
   AB6C 26 02         [ 3] 4734         bne     LAB70  
   AB6E 20 0A         [ 3] 4735         bra     LAB7A  
   AB70                    4736 LAB70:
   AB70 08            [ 3] 4737         inx
   AB71 08            [ 3] 4738         inx
   AB72 08            [ 3] 4739         inx
   AB73 8C 04 5C      [ 4] 4740         cpx     #0x045C
   AB76 25 E1         [ 3] 4741         bcs     LAB59  
   AB78 0D            [ 2] 4742         sec
   AB79 39            [ 5] 4743         rts
                           4744 
   AB7A                    4745 LAB7A:
   AB7A 0C            [ 2] 4746         clc
   AB7B 39            [ 5] 4747         rts
                           4748 
                           4749 ;show re-valid tapes
   AB7C CE 04 2C      [ 3] 4750         ldx     #0x042C
   AB7F                    4751 LAB7F:
   AB7F A6 00         [ 4] 4752         ldaa    0,X     
   AB81 81 30         [ 2] 4753         cmpa    #0x30
   AB83 25 1E         [ 3] 4754         bcs     LABA3  
   AB85 81 39         [ 2] 4755         cmpa    #0x39
   AB87 22 1A         [ 3] 4756         bhi     LABA3  
   AB89 BD F9 6F      [ 6] 4757         jsr     (0xF96F)
   AB8C 08            [ 3] 4758         inx
   AB8D A6 00         [ 4] 4759         ldaa    0,X     
   AB8F BD F9 6F      [ 6] 4760         jsr     (0xF96F)
   AB92 08            [ 3] 4761         inx
   AB93 A6 00         [ 4] 4762         ldaa    0,X     
   AB95 BD F9 6F      [ 6] 4763         jsr     (0xF96F)
   AB98 08            [ 3] 4764         inx
   AB99 86 20         [ 2] 4765         ldaa    #0x20
   AB9B BD F9 6F      [ 6] 4766         jsr     (0xF96F)
   AB9E 8C 04 5C      [ 4] 4767         cpx     #0x045C
   ABA1 25 DC         [ 3] 4768         bcs     LAB7F  
   ABA3                    4769 LABA3:
   ABA3 86 0D         [ 2] 4770         ldaa    #0x0D
   ABA5 BD F9 6F      [ 6] 4771         jsr     (0xF96F)
   ABA8 86 0A         [ 2] 4772         ldaa    #0x0A
   ABAA BD F9 6F      [ 6] 4773         jsr     (0xF96F)
   ABAD 39            [ 5] 4774         rts
                           4775 
   ABAE 7F 00 4A      [ 6] 4776         clr     (0x004A)
   ABB1 CC 00 64      [ 3] 4777         ldd     #0x0064
   ABB4 DD 23         [ 4] 4778         std     CDTIMR5
   ABB6                    4779 LABB6:
   ABB6 96 4A         [ 3] 4780         ldaa    (0x004A)
   ABB8 26 08         [ 3] 4781         bne     LABC2  
   ABBA BD 9B 19      [ 6] 4782         jsr     (0x9B19)
   ABBD DC 23         [ 4] 4783         ldd     CDTIMR5
   ABBF 26 F5         [ 3] 4784         bne     LABB6  
   ABC1                    4785 LABC1:
   ABC1 39            [ 5] 4786         rts
                           4787 
   ABC2                    4788 LABC2:
   ABC2 81 31         [ 2] 4789         cmpa    #0x31
   ABC4 26 04         [ 3] 4790         bne     LABCA  
   ABC6 BD AB 17      [ 6] 4791         jsr     (0xAB17)
   ABC9 39            [ 5] 4792         rts
                           4793 
   ABCA                    4794 LABCA:
   ABCA 20 F5         [ 3] 4795         bra     LABC1  
                           4796 
                           4797 ; TOC1 timer handler
                           4798 ;
                           4799 ; Timer is running at:
                           4800 ; EXTAL = 16Mhz
                           4801 ; E Clk = 4Mhz
                           4802 ; Timer Prescaler = /16 = 250Khz
                           4803 ; Timer Period = 4us
                           4804 ; T1OC is set to previous value +625
                           4805 ; So, this routine is called every 2.5ms
                           4806 ;
   ABCC DC 10         [ 4] 4807         ldd     T1NXT        ; get ready for next time
   ABCE C3 02 71      [ 4] 4808         addd    #0x0271      ; add 625
   ABD1 FD 10 16      [ 5] 4809         std     TOC1  
   ABD4 DD 10         [ 4] 4810         std     T1NXT
                           4811 
   ABD6 86 80         [ 2] 4812         ldaa    #0x80
   ABD8 B7 10 23      [ 4] 4813         staa    TFLG1       ; clear timer1 flag
                           4814 
                           4815 ; Some blinking SPECIAL button every half second,
                           4816 ; if 0x0078 is non zero
                           4817 
   ABDB 7D 00 78      [ 6] 4818         tst     (0x0078)     ; if 78 is zero, skip ahead
   ABDE 27 1C         [ 3] 4819         beq     LABFC       ; else do some blinking button lights
   ABE0 DC 25         [ 4] 4820         ldd     (0x0025)     ; else inc 25/26
   ABE2 C3 00 01      [ 4] 4821         addd    #0x0001
   ABE5 DD 25         [ 4] 4822         std     (0x0025)
   ABE7 1A 83 00 C8   [ 5] 4823         cpd     #0x00C8       ; is it 200?
   ABEB 26 0F         [ 3] 4824         bne     LABFC       ; no, keep going
   ABED 7F 00 25      [ 6] 4825         clr     (0x0025)     ; reset 25/26
   ABF0 7F 00 26      [ 6] 4826         clr     (0x0026)
   ABF3 D6 62         [ 3] 4827         ldab    (0x0062)    ; and toggle bit 3 of 62
   ABF5 C8 08         [ 2] 4828         eorb    #0x08
   ABF7 D7 62         [ 3] 4829         stab    (0x0062)
   ABF9 BD F9 C5      [ 6] 4830         jsr     (0xF9C5)     ; and toggle the "special" button light
                           4831 
                           4832 ; 
   ABFC                    4833 LABFC:
   ABFC 7C 00 6F      [ 6] 4834         inc     (0x006F)     ; count every 2.5ms
   ABFF 96 6F         [ 3] 4835         ldaa    (0x006F)
   AC01 81 28         [ 2] 4836         cmpa    #0x28        ; is it 40 intervals? (0.1 sec?)
   AC03 25 42         [ 3] 4837         bcs     LAC47       ; if not yet, jump ahead
   AC05 7F 00 6F      [ 6] 4838         clr     (0x006F)     ; clear it 2.5ms counter
   AC08 7D 00 63      [ 6] 4839         tst     (0x0063)     ; decrement 0.1s counter here
   AC0B 27 03         [ 3] 4840         beq     LAC10       ; if it's not already zero
   AC0D 7A 00 63      [ 6] 4841         dec     (0x0063)
                           4842 
                           4843 ; staggered counters - here every 100ms
                           4844 
                           4845 ; 0x0070 counts from 250 to 1, period is 25 secs
   AC10                    4846 LAC10:
   AC10 96 70         [ 3] 4847         ldaa    OFFCNT1    ; decrement 0.1s counter here
   AC12 4A            [ 2] 4848         deca
   AC13 97 70         [ 3] 4849         staa    OFFCNT1
   AC15 26 04         [ 3] 4850         bne     LAC1B       
   AC17 86 FA         [ 2] 4851         ldaa    #0xFA        ; 250
   AC19 97 70         [ 3] 4852         staa    OFFCNT1
                           4853 
                           4854 ; 0x0071 counts from 230 to 1, period is 23 secs
   AC1B                    4855 LAC1B:
   AC1B 96 71         [ 3] 4856         ldaa    OFFCNT2
   AC1D 4A            [ 2] 4857         deca
   AC1E 97 71         [ 3] 4858         staa    OFFCNT2
   AC20 26 04         [ 3] 4859         bne     LAC26  
   AC22 86 E6         [ 2] 4860         ldaa    #0xE6        ; 230
   AC24 97 71         [ 3] 4861         staa    OFFCNT2
                           4862 
                           4863 ; 0x0072 counts from 210 to 1, period is 21 secs
   AC26                    4864 LAC26:
   AC26 96 72         [ 3] 4865         ldaa    OFFCNT3
   AC28 4A            [ 2] 4866         deca
   AC29 97 72         [ 3] 4867         staa    OFFCNT3
   AC2B 26 04         [ 3] 4868         bne     LAC31  
   AC2D 86 D2         [ 2] 4869         ldaa    #0xD2        ; 210
   AC2F 97 72         [ 3] 4870         staa    OFFCNT3
                           4871 
                           4872 ; 0x0073 counts from 190 to 1, period is 19 secs
   AC31                    4873 LAC31:
   AC31 96 73         [ 3] 4874         ldaa    OFFCNT4
   AC33 4A            [ 2] 4875         deca
   AC34 97 73         [ 3] 4876         staa    OFFCNT4
   AC36 26 04         [ 3] 4877         bne     LAC3C  
   AC38 86 BE         [ 2] 4878         ldaa    #0xBE        ; 190
   AC3A 97 73         [ 3] 4879         staa    OFFCNT4
                           4880 
                           4881 ; 0x0074 counts from 170 to 1, period is 17 secs
   AC3C                    4882 LAC3C:
   AC3C 96 74         [ 3] 4883         ldaa    OFFCNT5
   AC3E 4A            [ 2] 4884         deca
   AC3F 97 74         [ 3] 4885         staa    OFFCNT5
   AC41 26 04         [ 3] 4886         bne     LAC47  
   AC43 86 AA         [ 2] 4887         ldaa    #0xAA        ; 170
   AC45 97 74         [ 3] 4888         staa    OFFCNT5
                           4889 
                           4890 ; back to 2.5ms period here
                           4891 
   AC47                    4892 LAC47:
   AC47 96 27         [ 3] 4893         ldaa    T30MS
   AC49 4C            [ 2] 4894         inca
   AC4A 97 27         [ 3] 4895         staa    T30MS
   AC4C 81 0C         [ 2] 4896         cmpa    #0x0C        ; 12 = 30ms?
   AC4E 23 09         [ 3] 4897         bls     LAC59  
   AC50 7F 00 27      [ 6] 4898         clr     T30MS
                           4899 
                           4900 ; do these tasks every 30ms
   AC53 BD 8E C6      [ 6] 4901         jsr     (0x8EC6)     ; ???
   AC56 BD 8F 12      [ 6] 4902         jsr     (0x8F12)     ; ???
                           4903 
                           4904 ; back to every 2.5ms here
                           4905 ; LCD update???
                           4906 
   AC59                    4907 LAC59:
   AC59 96 43         [ 3] 4908         ldaa    (0x0043)
   AC5B 27 55         [ 3] 4909         beq     LACB2  
   AC5D DE 44         [ 4] 4910         ldx     (0x0044)
   AC5F A6 00         [ 4] 4911         ldaa    0,X     
   AC61 27 23         [ 3] 4912         beq     LAC86  
   AC63 B7 10 00      [ 4] 4913         staa    PORTA  
   AC66 B6 10 02      [ 4] 4914         ldaa    PORTG  
   AC69 84 F3         [ 2] 4915         anda    #0xF3
   AC6B B7 10 02      [ 4] 4916         staa    PORTG  
   AC6E 84 FD         [ 2] 4917         anda    #0xFD
   AC70 B7 10 02      [ 4] 4918         staa    PORTG  
   AC73 8A 02         [ 2] 4919         oraa    #0x02
   AC75 B7 10 02      [ 4] 4920         staa    PORTG  
   AC78 08            [ 3] 4921         inx
   AC79 08            [ 3] 4922         inx
   AC7A 8C 05 80      [ 4] 4923         cpx     #0x0580
   AC7D 25 03         [ 3] 4924         bcs     LAC82  
   AC7F CE 05 00      [ 3] 4925         ldx     #0x0500
   AC82                    4926 LAC82:
   AC82 DF 44         [ 4] 4927         stx     (0x0044)
   AC84 20 2C         [ 3] 4928         bra     LACB2  
   AC86                    4929 LAC86:
   AC86 A6 01         [ 4] 4930         ldaa    1,X     
   AC88 27 25         [ 3] 4931         beq     LACAF  
   AC8A B7 10 00      [ 4] 4932         staa    PORTA  
   AC8D B6 10 02      [ 4] 4933         ldaa    PORTG  
   AC90 84 FB         [ 2] 4934         anda    #0xFB
   AC92 8A 08         [ 2] 4935         oraa    #0x08
   AC94 B7 10 02      [ 4] 4936         staa    PORTG  
   AC97 84 FD         [ 2] 4937         anda    #0xFD
   AC99 B7 10 02      [ 4] 4938         staa    PORTG  
   AC9C 8A 02         [ 2] 4939         oraa    #0x02
   AC9E B7 10 02      [ 4] 4940         staa    PORTG  
   ACA1 08            [ 3] 4941         inx
   ACA2 08            [ 3] 4942         inx
   ACA3 8C 05 80      [ 4] 4943         cpx     #0x0580
   ACA6 25 03         [ 3] 4944         bcs     LACAB  
   ACA8 CE 05 00      [ 3] 4945         ldx     #0x0500
   ACAB                    4946 LACAB:
   ACAB DF 44         [ 4] 4947         stx     (0x0044)
   ACAD 20 03         [ 3] 4948         bra     LACB2  
   ACAF                    4949 LACAF:
   ACAF 7F 00 43      [ 6] 4950         clr     (0x0043)
                           4951 
                           4952 ; divide by 4
   ACB2                    4953 LACB2:
   ACB2 96 4F         [ 3] 4954         ldaa    (0x004F)
   ACB4 4C            [ 2] 4955         inca
   ACB5 97 4F         [ 3] 4956         staa    (0x004F)
   ACB7 81 04         [ 2] 4957         cmpa    #0x04
   ACB9 26 30         [ 3] 4958         bne     LACEB  
   ACBB 7F 00 4F      [ 6] 4959         clr     (0x004F)
                           4960 
                           4961 ; here every 10ms
                           4962 ; Five big countdown timers available here
                           4963 ; up to 655.35 seconds each
                           4964 
   ACBE DC 1B         [ 4] 4965         ldd     CDTIMR1     ; countdown 0x001B/1C every 10ms
   ACC0 27 05         [ 3] 4966         beq     LACC7       ; if not already 0
   ACC2 83 00 01      [ 4] 4967         subd    #0x0001
   ACC5 DD 1B         [ 4] 4968         std     CDTIMR1
                           4969 
   ACC7                    4970 LACC7:
   ACC7 DC 1D         [ 4] 4971         ldd     CDTIMR2     ; same with 0x001D/1E
   ACC9 27 05         [ 3] 4972         beq     LACD0  
   ACCB 83 00 01      [ 4] 4973         subd    #0x0001
   ACCE DD 1D         [ 4] 4974         std     CDTIMR2
                           4975 
   ACD0                    4976 LACD0:
   ACD0 DC 1F         [ 4] 4977         ldd     CDTIMR3     ; same with 0x001F/20
   ACD2 27 05         [ 3] 4978         beq     LACD9  
   ACD4 83 00 01      [ 4] 4979         subd    #0x0001
   ACD7 DD 1F         [ 4] 4980         std     CDTIMR3
                           4981 
   ACD9                    4982 LACD9:
   ACD9 DC 21         [ 4] 4983         ldd     CDTIMR4     ; same with 0x0021/22
   ACDB 27 05         [ 3] 4984         beq     LACE2  
   ACDD 83 00 01      [ 4] 4985         subd    #0x0001
   ACE0 DD 21         [ 4] 4986         std     CDTIMR4
                           4987 
   ACE2                    4988 LACE2:
   ACE2 DC 23         [ 4] 4989         ldd     CDTIMR5     ; same with 0x0023/24
   ACE4 27 05         [ 3] 4990         beq     LACEB  
   ACE6 83 00 01      [ 4] 4991         subd    #0x0001
   ACE9 DD 23         [ 4] 4992         std     CDTIMR5
                           4993 
                           4994 ; every other time through this, setup a task switch?
   ACEB                    4995 LACEB:
   ACEB 96 B0         [ 3] 4996         ldaa    (TSCNT)
   ACED 88 01         [ 2] 4997         eora    #0x01
   ACEF 97 B0         [ 3] 4998         staa    (TSCNT)
   ACF1 27 18         [ 3] 4999         beq     LAD0B  
                           5000 
   ACF3 BF 01 3C      [ 5] 5001         sts     (0x013C)     ; switch stacks???
   ACF6 BE 01 3E      [ 5] 5002         lds     (0x013E)
   ACF9 DC 10         [ 4] 5003         ldd     T1NXT
   ACFB 83 01 F4      [ 4] 5004         subd    #0x01F4      ; 625-500 = 125?
   ACFE FD 10 18      [ 5] 5005         std     TOC2         ; set this TOC2 to happen 0.5ms
   AD01 86 40         [ 2] 5006         ldaa    #0x40        ; after the current TOC1 but before the next TOC1
   AD03 B7 10 23      [ 4] 5007         staa    TFLG1       ; clear timer2 irq flag, just in case?
   AD06 86 C0         [ 2] 5008         ldaa    #0xC0        ;
   AD08 B7 10 22      [ 4] 5009         staa    TMSK1       ; enable TOC1 and TOC2
   AD0B                    5010 LAD0B:
   AD0B 3B            [12] 5011         rti
                           5012 
                           5013 ; TOC2 Timer handler
                           5014 
   AD0C 86 40         [ 2] 5015         ldaa    #0x40
   AD0E B7 10 23      [ 4] 5016         staa    TFLG1       ; clear timer2 flag
   AD11 BF 01 3E      [ 5] 5017         sts     (0x013E)     ; switch stacks back???
   AD14 BE 01 3C      [ 5] 5018         lds     (0x013C)
   AD17 86 80         [ 2] 5019         ldaa    #0x80
   AD19 B7 10 22      [ 4] 5020         staa    TMSK1       ; enable TOC1 only
   AD1C 3B            [12] 5021         rti
                           5022 
                           5023 ; Secondary task??
                           5024 
   AD1D                    5025 TASK2:
   AD1D 7D 04 2A      [ 6] 5026         tst     (0x042A)
   AD20 27 35         [ 3] 5027         beq     LAD57
   AD22 96 B6         [ 3] 5028         ldaa    (0x00B6)
   AD24 26 03         [ 3] 5029         bne     LAD29
   AD26 3F            [14] 5030         swi
   AD27 20 F4         [ 3] 5031         bra     TASK2
   AD29                    5032 LAD29:
   AD29 7F 00 B6      [ 6] 5033         clr     (0x00B6)
   AD2C C6 04         [ 2] 5034         ldab    #0x04
   AD2E                    5035 LAD2E:
   AD2E 37            [ 3] 5036         pshb
   AD2F CE AD 3C      [ 3] 5037         ldx     #LAD3C
   AD32 BD 8A 1A      [ 6] 5038         jsr     L8A1A  
   AD35 3F            [14] 5039         swi
   AD36 33            [ 4] 5040         pulb
   AD37 5A            [ 2] 5041         decb
   AD38 26 F4         [ 3] 5042         bne     LAD2E  
   AD3A 20 E1         [ 3] 5043         bra     TASK2
                           5044 
   AD3C                    5045 LAD3C:
   AD3C 53 31 00           5046         .asciz     'S1'
                           5047 
   AD3F FC 02 9C      [ 5] 5048         ldd     (0x029C)
   AD42 1A 83 00 01   [ 5] 5049         cpd     #0x0001
   AD46 27 0C         [ 3] 5050         beq     LAD54  
   AD48 1A 83 03 E8   [ 5] 5051         cpd     #0x03E8
   AD4C 2D 09         [ 3] 5052         blt     LAD57  
   AD4E 1A 83 04 4B   [ 5] 5053         cpd     #0x044B
   AD52 22 03         [ 3] 5054         bhi     LAD57  
   AD54                    5055 LAD54:
   AD54 3F            [14] 5056         swi
   AD55 20 C6         [ 3] 5057         bra     TASK2
   AD57                    5058 LAD57:
   AD57 7F 00 B3      [ 6] 5059         clr     (0x00B3)
   AD5A BD AD 7E      [ 6] 5060         jsr     (0xAD7E)
   AD5D BD AD A0      [ 6] 5061         jsr     (0xADA0)
   AD60 25 BB         [ 3] 5062         bcs     TASK2
   AD62 C6 0A         [ 2] 5063         ldab    #0x0A
   AD64 BD AE 13      [ 6] 5064         jsr     (0xAE13)
   AD67 BD AD AE      [ 6] 5065         jsr     (0xADAE)
   AD6A 25 B1         [ 3] 5066         bcs     TASK2
   AD6C C6 14         [ 2] 5067         ldab    #0x14
   AD6E BD AE 13      [ 6] 5068         jsr     (0xAE13)
   AD71 BD AD B6      [ 6] 5069         jsr     (0xADB6)
   AD74 25 A7         [ 3] 5070         bcs     TASK2
   AD76                    5071 LAD76:
   AD76 BD AD B8      [ 6] 5072         jsr     (0xADB8)
   AD79 0D            [ 2] 5073         sec
   AD7A 25 A1         [ 3] 5074         bcs     TASK2
   AD7C 20 F8         [ 3] 5075         bra     LAD76  
   AD7E CE AE 1E      [ 3] 5076         ldx     #LAE1E       ;+++
   AD81 BD 8A 1A      [ 6] 5077         jsr     L8A1A  
   AD84 C6 1E         [ 2] 5078         ldab    #0x1E
   AD86 BD AE 13      [ 6] 5079         jsr     (0xAE13)
   AD89 CE AE 22      [ 3] 5080         ldx     #LAE22       ;ATH
   AD8C BD 8A 1A      [ 6] 5081         jsr     L8A1A  
   AD8F C6 1E         [ 2] 5082         ldab    #0x1E
   AD91 BD AE 13      [ 6] 5083         jsr     (0xAE13)
   AD94 CE AE 27      [ 3] 5084         ldx     #LAE27       ;ATZ
   AD97 BD 8A 1A      [ 6] 5085         jsr     L8A1A  
   AD9A C6 1E         [ 2] 5086         ldab    #0x1E
   AD9C BD AE 13      [ 6] 5087         jsr     (0xAE13)
   AD9F 39            [ 5] 5088         rts
   ADA0                    5089 LADA0:
   ADA0 BD B1 DD      [ 6] 5090         jsr     (0xB1DD)
   ADA3 25 FB         [ 3] 5091         bcs     LADA0  
   ADA5 BD B2 4F      [ 6] 5092         jsr     (0xB24F)
                           5093 
   ADA8 52 49 4E 47 00     5094         .asciz  'RING'
                           5095 
   ADAD 39            [ 5] 5096         rts
                           5097 
   ADAE CE AE 2C      [ 3] 5098         ldx     #0xAE2C
   ADB1 BD 8A 1A      [ 6] 5099         jsr     L8A1A       ;ATA
   ADB4 0C            [ 2] 5100         clc
   ADB5 39            [ 5] 5101         rts
   ADB6 0C            [ 2] 5102         clc
   ADB7 39            [ 5] 5103         rts
   ADB8 BD B1 D2      [ 6] 5104         jsr     (0xB1D2)
   ADBB BD AE 31      [ 6] 5105         jsr     (0xAE31)
   ADBE 86 01         [ 2] 5106         ldaa    #0x01
   ADC0 97 B3         [ 3] 5107         staa    (0x00B3)
   ADC2 BD B1 DD      [ 6] 5108         jsr     (0xB1DD)
   ADC5 BD B2 71      [ 6] 5109         jsr     (0xB271)
   ADC8 36            [ 3] 5110         psha
   ADC9 BD B2 C0      [ 6] 5111         jsr     (0xB2C0)
   ADCC 32            [ 4] 5112         pula
   ADCD 81 01         [ 2] 5113         cmpa    #0x01
   ADCF 26 08         [ 3] 5114         bne     LADD9  
   ADD1 CE B2 95      [ 3] 5115         ldx     #LB295
   ADD4 BD 8A 1A      [ 6] 5116         jsr     L8A1A       ;'You have selected #1'
   ADD7 20 31         [ 3] 5117         bra     LAE0A  
   ADD9                    5118 LADD9:
   ADD9 81 02         [ 2] 5119         cmpa    #0x02
   ADDB 26 00         [ 3] 5120         bne     LADDD  
   ADDD                    5121 LADDD:
   ADDD 81 03         [ 2] 5122         cmpa    #0x03
   ADDF 26 00         [ 3] 5123         bne     LADE1  
   ADE1                    5124 LADE1:
   ADE1 81 04         [ 2] 5125         cmpa    #0x04
   ADE3 26 00         [ 3] 5126         bne     LADE5  
   ADE5                    5127 LADE5:
   ADE5 81 05         [ 2] 5128         cmpa    #0x05
   ADE7 26 00         [ 3] 5129         bne     LADE9  
   ADE9                    5130 LADE9:
   ADE9 81 06         [ 2] 5131         cmpa    #0x06
   ADEB 26 00         [ 3] 5132         bne     LADED  
   ADED                    5133 LADED:
   ADED 81 07         [ 2] 5134         cmpa    #0x07
   ADEF 26 00         [ 3] 5135         bne     LADF1  
   ADF1                    5136 LADF1:
   ADF1 81 08         [ 2] 5137         cmpa    #0x08
   ADF3 26 00         [ 3] 5138         bne     LADF5  
   ADF5                    5139 LADF5:
   ADF5 81 09         [ 2] 5140         cmpa    #0x09
   ADF7 26 00         [ 3] 5141         bne     LADF9  
   ADF9                    5142 LADF9:
   ADF9 81 0A         [ 2] 5143         cmpa    #0x0A
   ADFB 26 00         [ 3] 5144         bne     LADFD  
   ADFD                    5145 LADFD:
   ADFD 81 0B         [ 2] 5146         cmpa    #0x0B
   ADFF 26 09         [ 3] 5147         bne     LAE0A  
   AE01 CE B2 AA      [ 3] 5148         ldx     #LB2AA       ;'You have selected #11'
   AE04 BD 8A 1A      [ 6] 5149         jsr     L8A1A  
   AE07 7E AE 0A      [ 3] 5150         jmp     (0xAE0A)
   AE0A                    5151 LAE0A:
   AE0A C6 14         [ 2] 5152         ldab    #0x14
   AE0C BD AE 13      [ 6] 5153         jsr     (0xAE13)
   AE0F 7F 00 B3      [ 6] 5154         clr     (0x00B3)
   AE12 39            [ 5] 5155         rts
                           5156 
   AE13                    5157 LAE13:
   AE13 CE 00 20      [ 3] 5158         ldx     #0x0020
   AE16                    5159 LAE16:
   AE16 3F            [14] 5160         swi
   AE17 09            [ 3] 5161         dex
   AE18 26 FC         [ 3] 5162         bne     LAE16  
   AE1A 5A            [ 2] 5163         decb
   AE1B 26 F6         [ 3] 5164         bne     LAE13  
   AE1D 39            [ 5] 5165         rts
                           5166 
                           5167 ; text??
   AE1E                    5168 LAE1E:
   AE1E 2B 2B 2B 00        5169         .asciz      '+++'
   AE22                    5170 LAE22:
   AE22 41 54 48 0D 00     5171         .asciz      'ATH\r'
   AE27                    5172 LAE27:
   AE27 41 54 5A 0D 00     5173         .asciz      'ATZ\r'
   AE2C                    5174 LAE2C:
   AE2C 41 54 41 0D 00     5175         .asciz      'ATA\r'
                           5176 
   AE31 CE AE 38      [ 3] 5177         ldx     #LAE38       ; big long string of stats?
   AE34 BD 8A 1A      [ 6] 5178         jsr     L8A1A  
   AE37 39            [ 5] 5179         rts
                           5180 
   AE38                    5181 LAE38:
   AE38 5E 30 31 30 31 53  5182         .ascii  "^0101Serial #:^0140#0000^0111~4"
        65 72 69 61 6C 20
        23 3A 5E 30 31 34
        30 23 30 30 30 30
        5E 30 31 31 31 7E
        34
   AE57 0E 20              5183         .byte   0x0E,0x20
   AE59 5E 30 31 34 31 7C  5184         .ascii  "^0141|"
   AE5F 04 28              5185         .byte   0x04,0x28
   AE61 5E 30 33 30 31 43  5186         .ascii  "^0301CURRENT^0340HISTORY^0501Show Status:^0540Total # reg. shows:^0601Random Status:^0570|"
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
   AEBB 04 10              5187         .byte   0x04,0x10
   AEBD 5E 30 36 34 30 54  5188         .ascii  "^0640Total # live shows:^0701Current Reg Tape #:^0670|"
        6F 74 61 6C 20 23
        20 6C 69 76 65 20
        73 68 6F 77 73 3A
        5E 30 37 30 31 43
        75 72 72 65 6E 74
        20 52 65 67 20 54
        61 70 65 20 23 3A
        5E 30 36 37 30 7C
   AEF3 04 12              5189         .byte   0x04,0x12
   AEF5 5E 30 37 33 30 7E  5190         .ascii  "^0730~3"
        33
   AEFC 04 02              5191         .byte   0x04,0x02
   AEFE 5E 30 37 34 30 54  5192         .ascii  "^0740Total # failed pswd attempts:^0801Current Live Tape #:^0770|"
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
   AF3F 04 14              5193         .byte   0x04,0x14
   AF41 5E 30 38 33 30 7E  5194         .ascii  "^0830~3"
        33
   AF48 04 05              5195         .byte   0x04,0x05
   AF4A 5E 30 38 34 30 54  5196         .ascii  "^0840Total # successful pswd:^0901Current Version #:^0870|"
        6F 74 61 6C 20 23
        20 73 75 63 63 65
        73 73 66 75 6C 20
        70 73 77 64 3A 5E
        30 39 30 31 43 75
        72 72 65 6E 74 20
        56 65 72 73 69 6F
        6E 20 23 3A 5E 30
        38 37 30 7C
   AF84 04 16              5197         .byte   0x04,0x16
   AF86 5E 30 39 33 30 40  5198         .ascii  "^0930@"
   AF8C 04 00              5199         .byte   0x04,0x00
   AF8E 5E 30 39 34 30 54  5200         .ascii  "^0940Total # bdays played:^1040Total # VCR adjusts:^0970|"
        6F 74 61 6C 20 23
        20 62 64 61 79 73
        20 70 6C 61 79 65
        64 3A 5E 31 30 34
        30 54 6F 74 61 6C
        20 23 20 56 43 52
        20 61 64 6A 75 73
        74 73 3A 5E 30 39
        37 30 7C
   AFC7 04 18              5201         .byte   0x04,0x18
   AFC9 5E 31 30 37 30 7C  5202         .ascii  "^1070|"
   AFCF 04 1A              5203         .byte   0x04,0x1A
   AFD1 5E 31 31 34 30 54  5204         .ascii  "^1140Total # remote accesses:^1240Total # access attempts:^1170|"
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
   B011 04 1C              5205         .byte   0x04,0x1C
   B013 5E 31 32 37 30 7C  5206         .ascii  "^1270|"
   B019 04 1E              5207         .byte   0x04,0x1E
   B01B 5E 31 33 34 30 54  5208         .ascii  "^1340Total # rejected showtapes:^1440Total # Short bdays:^1370|"
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
   B05A 04 20              5209         .byte   0x04,0x20
   B05C 5E 31 34 37 30 7C  5210         .ascii  "^1470|"
   B062 04 22              5211         .byte   0x04,0x22
   B064 5E 31 35 34 30 54  5212         .ascii  "^1540Total # Reg bdays:^1640Total # resets-pwr ups:^1570|"
        6F 74 61 6C 20 23
        20 52 65 67 20 62
        64 61 79 73 3A 5E
        31 36 34 30 54 6F
        74 61 6C 20 23 20
        72 65 73 65 74 73
        2D 70 77 72 20 75
        70 73 3A 5E 31 35
        37 30 7C
   B09D 04 24              5213         .byte   0x04,0x24
   B09F 5E 31 36 37 30 7C  5214         .ascii  "^1670|"
   B0A5 04 26              5215         .byte   0x04,0x26
   B0A7 5E 31 38 30 31 46  5216         .ascii  "^1801FUNCTIONS^1823Select Function:^20011.Clear rnd enables^2028 6.Set loc name-#^205411.Diagnostics^21012.Set rnd enables^2128 7.Set Time^215412.^22013.Set reg tape #^2228 8.Disbl-enbl show^225413.^23014.Set liv tape #^2328 9.Upload program^235414.^24015.Reset history^242810.Debugger^245415.^1840"
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
   B1D1 00                 5217         .byte   0x00
                           5218 
                           5219 ; back to code
   B1D2 CE B1 D8      [ 3] 5220         ldx     #LB1D8       ; escape sequence?
   B1D5 7E 8A 1A      [ 3] 5221         jmp     L8A1A  
                           5222 
   B1D8                    5223 LB1D8:
                           5224         ; esc[2J ?
   B1D8 1B                 5225         .byte   0x1b
   B1D9 5B 32 4A 00        5226         .asciz  '[2J'
                           5227 
   B1DD CE 05 A0      [ 3] 5228         ldx     #0x05A0
   B1E0 CC 00 00      [ 3] 5229         ldd     #0x0000
   B1E3 FD 02 9E      [ 5] 5230         std     (0x029E)
   B1E6                    5231 LB1E6:
   B1E6 FC 02 9E      [ 5] 5232         ldd     (0x029E)
   B1E9 C3 00 01      [ 4] 5233         addd    #0x0001
   B1EC FD 02 9E      [ 5] 5234         std     (0x029E)
   B1EF 1A 83 0F A0   [ 5] 5235         cpd     #0x0FA0
   B1F3 24 28         [ 3] 5236         bcc     LB21D  
   B1F5 BD B2 23      [ 6] 5237         jsr     (0xB223)
   B1F8 25 04         [ 3] 5238         bcs     LB1FE  
   B1FA 3F            [14] 5239         swi
   B1FB 20 E9         [ 3] 5240         bra     LB1E6  
   B1FD 39            [ 5] 5241         rts
                           5242 
   B1FE                    5243 LB1FE:
   B1FE A7 00         [ 4] 5244         staa    0,X     
   B200 08            [ 3] 5245         inx
   B201 81 0D         [ 2] 5246         cmpa    #0x0D
   B203 26 02         [ 3] 5247         bne     LB207  
   B205 20 18         [ 3] 5248         bra     LB21F  
   B207                    5249 LB207:
   B207 81 1B         [ 2] 5250         cmpa    #0x1B
   B209 26 02         [ 3] 5251         bne     LB20D  
   B20B 20 10         [ 3] 5252         bra     LB21D  
   B20D                    5253 LB20D:
   B20D 7D 00 B3      [ 6] 5254         tst     (0x00B3)
   B210 27 03         [ 3] 5255         beq     LB215  
   B212 BD 8B 3B      [ 6] 5256         jsr     (0x8B3B)
   B215                    5257 LB215:
   B215 CC 00 00      [ 3] 5258         ldd     #0x0000
   B218 FD 02 9E      [ 5] 5259         std     (0x029E)
   B21B 20 C9         [ 3] 5260         bra     LB1E6  
   B21D                    5261 LB21D:
   B21D 0D            [ 2] 5262         sec
   B21E 39            [ 5] 5263         rts
                           5264 
   B21F                    5265 LB21F:
   B21F 6F 00         [ 6] 5266         clr     0,X     
   B221 0C            [ 2] 5267         clc
   B222 39            [ 5] 5268         rts
                           5269 
   B223 B6 18 0D      [ 4] 5270         ldaa    (0x180D)
   B226 44            [ 2] 5271         lsra
   B227 25 0B         [ 3] 5272         bcs     LB234  
   B229 4F            [ 2] 5273         clra
   B22A B7 18 0D      [ 4] 5274         staa    (0x180D)
   B22D 86 30         [ 2] 5275         ldaa    #0x30
   B22F B7 18 0D      [ 4] 5276         staa    (0x180D)
   B232 0C            [ 2] 5277         clc
   B233 39            [ 5] 5278         rts
                           5279 
   B234                    5280 LB234:
   B234 86 01         [ 2] 5281         ldaa    #0x01
   B236 B7 18 0D      [ 4] 5282         staa    (0x180D)
   B239 86 70         [ 2] 5283         ldaa    #0x70
   B23B B5 18 0D      [ 4] 5284         bita    (0x180D)
   B23E 26 05         [ 3] 5285         bne     LB245  
   B240 0D            [ 2] 5286         sec
   B241 B6 18 0F      [ 4] 5287         ldaa    (0x180F)
   B244 39            [ 5] 5288         rts
                           5289 
   B245                    5290 LB245:
   B245 B6 18 0F      [ 4] 5291         ldaa    (0x180F)
   B248 86 30         [ 2] 5292         ldaa    #0x30
   B24A B7 18 0C      [ 4] 5293         staa    (0x180C)
   B24D 0C            [ 2] 5294         clc
   B24E 39            [ 5] 5295         rts
                           5296 
   B24F 38            [ 5] 5297         pulx
   B250 18 CE 05 A0   [ 4] 5298         ldy     #0x05A0
   B254                    5299 LB254:
   B254 A6 00         [ 4] 5300         ldaa    0,X
   B256 27 11         [ 3] 5301         beq     LB269
   B258 08            [ 3] 5302         inx
   B259 18 A1 00      [ 5] 5303         cmpa    0,Y
   B25C 26 04         [ 3] 5304         bne     LB262
   B25E 18 08         [ 4] 5305         iny
   B260 20 F2         [ 3] 5306         bra     LB254
   B262                    5307 LB262:
   B262 A6 00         [ 4] 5308         ldaa    0,X
   B264 27 07         [ 3] 5309         beq     LB26D
   B266 08            [ 3] 5310         inx
   B267 20 F9         [ 3] 5311         bra     LB262
   B269                    5312 LB269:
   B269 08            [ 3] 5313         inx
   B26A 3C            [ 4] 5314         pshx
   B26B 0C            [ 2] 5315         clc
   B26C 39            [ 5] 5316         rts
   B26D                    5317 LB26D:
   B26D 08            [ 3] 5318         inx
   B26E 3C            [ 4] 5319         pshx
   B26F 0D            [ 2] 5320         sec
   B270 39            [ 5] 5321         rts
                           5322 
   B271 CE 05 A0      [ 3] 5323         ldx     #0x05A0
   B274                    5324 LB274:
   B274 A6 00         [ 4] 5325         ldaa    0,X
   B276 08            [ 3] 5326         inx
   B277 81 0D         [ 2] 5327         cmpa    #0x0D
   B279 26 F9         [ 3] 5328         bne     LB274
   B27B 09            [ 3] 5329         dex
   B27C 09            [ 3] 5330         dex
   B27D A6 00         [ 4] 5331         ldaa    0,X
   B27F 09            [ 3] 5332         dex
   B280 80 30         [ 2] 5333         suba    #0x30
   B282 97 B2         [ 3] 5334         staa    (0x00B2)
   B284 8C 05 9F      [ 4] 5335         cpx     #0x059F
   B287 27 0B         [ 3] 5336         beq     LB294
   B289 A6 00         [ 4] 5337         ldaa    0,X
   B28B 09            [ 3] 5338         dex
   B28C 80 30         [ 2] 5339         suba    #0x30
   B28E C6 0A         [ 2] 5340         ldab    #0x0A
   B290 3D            [10] 5341         mul
   B291 17            [ 2] 5342         tba
   B292 9B B2         [ 3] 5343         adda    (0x00B2)
   B294                    5344 LB294:
   B294 39            [ 5] 5345         rts
                           5346 
                           5347 ; text
   B295                    5348 LB295:
   B295 59 6F 75 20 68 61  5349         .asciz  'You have selected #1'
        76 65 20 73 65 6C
        65 63 74 65 64 20
        23 31 00
   B2AA                    5350 LB2AA:
   B2AA 59 6F 75 20 68 61  5351         .asciz  'You have selected #11'
        76 65 20 73 65 6C
        65 63 74 65 64 20
        23 31 31 00
                           5352 
                           5353 ; code
   B2C0 CE B2 C7      [ 3] 5354         ldx     #0xB2C7     ; strange table
   B2C3 BD 8A 1A      [ 6] 5355         jsr     L8A1A  
   B2C6 39            [ 5] 5356         rts
                           5357 
   B2C7 5E 32 30 30 31 25  5358         .asciz  "^2001%^2101%^2201%^2301%^2401%^2001"
        5E 32 31 30 31 25
        5E 32 32 30 31 25
        5E 32 33 30 31 25
        5E 32 34 30 31 25
        5E 32 30 30 31 00
                           5359 
   B2EB FA 20 FA 20 F6 22  5360         .byte   0xfa,0x20,0xfa,0x20,0xf6,0x22,0xf5,0x20
        F5 20
   B2F3 F5 20 F3 22 F2 20  5361         .byte   0xf5,0x20,0xf3,0x22,0xf2,0x20,0xe5,0x22
        E5 22
   B2FB E5 22 E2 20 D2 20  5362         .byte   0xe5,0x22,0xe2,0x20,0xd2,0x20,0xbe,0x00
        BE 00
   B303 BC 22 BB 30 B9 32  5363         .byte   0xbc,0x22,0xbb,0x30,0xb9,0x32,0xb9,0x32
        B9 32
   B30B B7 30 B6 32 B5 30  5364         .byte   0xb7,0x30,0xb6,0x32,0xb5,0x30,0xb4,0x32
        B4 32
   B313 B4 32 B3 20 B3 20  5365         .byte   0xb4,0x32,0xb3,0x20,0xb3,0x20,0xb1,0xa0
        B1 A0
   B31B B1 A0 B0 A2 AF A0  5366         .byte   0xb1,0xa0,0xb0,0xa2,0xaf,0xa0,0xaf,0xa6
        AF A6
   B323 AE A0 AE A6 AD A4  5367         .byte   0xae,0xa0,0xae,0xa6,0xad,0xa4,0xac,0xa0
        AC A0
   B32B AC A0 AB A0 AA A0  5368         .byte   0xac,0xa0,0xab,0xa0,0xaa,0xa0,0xaa,0xa0
        AA A0
   B333 A2 80 A0 A0 A0 A0  5369         .byte   0xa2,0x80,0xa0,0xa0,0xa0,0xa0,0x8d,0x80
        8D 80
   B33B 8A A0 7E 80 7B A0  5370         .byte   0x8a,0xa0,0x7e,0x80,0x7b,0xa0,0x79,0xa4
        79 A4
   B343 78 A0 77 A4 76 A0  5371         .byte   0x78,0xa0,0x77,0xa4,0x76,0xa0,0x75,0xa4
        75 A4
   B34B 74 A0 73 A4 72 A0  5372         .byte   0x74,0xa0,0x73,0xa4,0x72,0xa0,0x71,0xa4
        71 A4
   B353 70 A0 6F A4 6E A0  5373         .byte   0x70,0xa0,0x6f,0xa4,0x6e,0xa0,0x6d,0xa4
        6D A4
   B35B 6C A0 69 80 69 80  5374         .byte   0x6c,0xa0,0x69,0x80,0x69,0x80,0x67,0xa0
        67 A0
   B363 5E 20 58 24 57 20  5375         .byte   0x5e,0x20,0x58,0x24,0x57,0x20,0x57,0x20
        57 20
   B36B 56 24 55 20 54 24  5376         .byte   0x56,0x24,0x55,0x20,0x54,0x24,0x54,0x24
        54 24
   B373 53 20 52 24 52 24  5377         .byte   0x53,0x20,0x52,0x24,0x52,0x24,0x50,0x20
        50 20
   B37B 4F 24 4E 20 4D 24  5378         .byte   0x4f,0x24,0x4e,0x20,0x4d,0x24,0x4c,0x20
        4C 20
   B383 4C 20 4B 24 4A 20  5379         .byte   0x4c,0x20,0x4b,0x24,0x4a,0x20,0x49,0x20
        49 20
   B38B 49 00 48 20 47 20  5380         .byte   0x49,0x00,0x48,0x20,0x47,0x20,0x47,0x20
        47 20
   B393 46 20 45 24 45 24  5381         .byte   0x46,0x20,0x45,0x24,0x45,0x24,0x44,0x20
        44 20
   B39B 42 20 42 20 37 04  5382         .byte   0x42,0x20,0x42,0x20,0x37,0x04,0x35,0x20
        35 20
   B3A3 2E 04 2E 04 2D 20  5383         .byte   0x2e,0x04,0x2e,0x04,0x2d,0x20,0x23,0x24
        23 24
   B3AB 21 20 17 24 13 00  5384         .byte   0x21,0x20,0x17,0x24,0x13,0x00,0x11,0x24
        11 24
   B3B3 10 30 07 34 06 30  5385         .byte   0x10,0x30,0x07,0x34,0x06,0x30,0x05,0x30
        05 30
   B3BB FF FF D7 22 D5 20  5386         .byte   0xff,0xff,0xd7,0x22,0xd5,0x20,0xc9,0x22
        C9 22
   B3C3 C7 20 C4 24 C3 20  5387         .byte   0xc7,0x20,0xc4,0x24,0xc3,0x20,0xc2,0x24
        C2 24
   B3CB C1 20 BF 24 BF 24  5388         .byte   0xc1,0x20,0xbf,0x24,0xbf,0x24,0xbe,0x20
        BE 20
   B3D3 BD 24 BC 20 BB 24  5389         .byte   0xbd,0x24,0xbc,0x20,0xbb,0x24,0xba,0x20
        BA 20
   B3DB B9 20 B8 24 B7 20  5390         .byte   0xb9,0x20,0xb8,0x24,0xb7,0x20,0xb4,0x00
        B4 00
   B3E3 B4 00 B2 20 A9 20  5391         .byte   0xb4,0x00,0xb2,0x20,0xa9,0x20,0xa3,0x20
        A3 20
   B3EB A2 20 A1 20 A0 20  5392         .byte   0xa2,0x20,0xa1,0x20,0xa0,0x20,0xa0,0x20
        A0 20
   B3F3 9F 20 9F 20 9E 20  5393         .byte   0x9f,0x20,0x9f,0x20,0x9e,0x20,0x9d,0x24
        9D 24
   B3FB 9D 24 9B 20 9A 24  5394         .byte   0x9d,0x24,0x9b,0x20,0x9a,0x24,0x99,0x20
        99 20
   B403 98 20 97 24 97 24  5395         .byte   0x98,0x20,0x97,0x24,0x97,0x24,0x95,0x20
        95 20
   B40B 95 20 94 00 94 00  5396         .byte   0x95,0x20,0x94,0x00,0x94,0x00,0x93,0x20
        93 20
   B413 92 00 92 00 91 20  5397         .byte   0x92,0x00,0x92,0x00,0x91,0x20,0x90,0x20
        90 20
   B41B 90 20 8F 20 8D 20  5398         .byte   0x90,0x20,0x8f,0x20,0x8d,0x20,0x8d,0x20
        8D 20
   B423 81 00 7F 20 79 00  5399         .byte   0x81,0x00,0x7f,0x20,0x79,0x00,0x79,0x00
        79 00
   B42B 78 20 76 20 6B 00  5400         .byte   0x78,0x20,0x76,0x20,0x6b,0x00,0x69,0x20
        69 20
   B433 5E 00 5C 20 5B 30  5401         .byte   0x5e,0x00,0x5c,0x20,0x5b,0x30,0x52,0x10
        52 10
   B43B 51 30 50 30 50 30  5402         .byte   0x51,0x30,0x50,0x30,0x50,0x30,0x4f,0x20
        4F 20
   B443 4E 20 4E 20 4D 20  5403         .byte   0x4e,0x20,0x4e,0x20,0x4d,0x20,0x46,0xa0
        46 A0
   B44B 45 A0 3D A0 3D A0  5404         .byte   0x45,0xa0,0x3d,0xa0,0x3d,0xa0,0x39,0x20
        39 20
   B453 2A 00 28 20 1E 00  5405         .byte   0x2a,0x00,0x28,0x20,0x1e,0x00,0x1c,0x22
        1C 22
   B45B 1C 22 1B 20 1A 22  5406         .byte   0x1c,0x22,0x1b,0x20,0x1a,0x22,0x19,0x20
        19 20
   B463 18 22 18 22 16 20  5407         .byte   0x18,0x22,0x18,0x22,0x16,0x20,0x15,0x22
        15 22
   B46B 15 22 14 A0 13 A2  5408         .byte   0x15,0x22,0x14,0xa0,0x13,0xa2,0x11,0xa0
        11 A0
   B473 FF FF BE 00 BC 22  5409         .byte   0xff,0xff,0xbe,0x00,0xbc,0x22,0xbb,0x30
        BB 30
   B47B B9 32 B9 32 B7 30  5410         .byte   0xb9,0x32,0xb9,0x32,0xb7,0x30,0xb6,0x32
        B6 32
   B483 B5 30 B4 32 B4 32  5411         .byte   0xb5,0x30,0xb4,0x32,0xb4,0x32,0xb3,0x20
        B3 20
   B48B B3 20 B1 A0 B1 A0  5412         .byte   0xb3,0x20,0xb1,0xa0,0xb1,0xa0,0xb0,0xa2
        B0 A2
   B493 AF A0 AF A6 AE A0  5413         .byte   0xaf,0xa0,0xaf,0xa6,0xae,0xa0,0xae,0xa6
        AE A6
   B49B AD A4 AC A0 AC A0  5414         .byte   0xad,0xa4,0xac,0xa0,0xac,0xa0,0xab,0xa0
        AB A0
   B4A3 AA A0 AA A0 A2 80  5415         .byte   0xaa,0xa0,0xaa,0xa0,0xa2,0x80,0xa0,0xa0
        A0 A0
   B4AB A0 A0 8D 80 8A A0  5416         .byte   0xa0,0xa0,0x8d,0x80,0x8a,0xa0,0x7e,0x80
        7E 80
   B4B3 7B A0 79 A4 78 A0  5417         .byte   0x7b,0xa0,0x79,0xa4,0x78,0xa0,0x77,0xa4
        77 A4
   B4BB 76 A0 75 A4 74 A0  5418         .byte   0x76,0xa0,0x75,0xa4,0x74,0xa0,0x73,0xa4
        73 A4
   B4C3 72 A0 71 A4 70 A0  5419         .byte   0x72,0xa0,0x71,0xa4,0x70,0xa0,0x6f,0xa4
        6F A4
   B4CB 6E A0 6D A4 6C A0  5420         .byte   0x6e,0xa0,0x6d,0xa4,0x6c,0xa0,0x69,0x80
        69 80
   B4D3 69 80 67 A0 5E 20  5421         .byte   0x69,0x80,0x67,0xa0,0x5e,0x20,0x58,0x24
        58 24
   B4DB 57 20 57 20 56 24  5422         .byte   0x57,0x20,0x57,0x20,0x56,0x24,0x55,0x20
        55 20
   B4E3 54 24 54 24 53 20  5423         .byte   0x54,0x24,0x54,0x24,0x53,0x20,0x52,0x24
        52 24
   B4EB 52 24 50 20 4F 24  5424         .byte   0x52,0x24,0x50,0x20,0x4f,0x24,0x4e,0x20
        4E 20
   B4F3 4D 24 4C 20 4C 20  5425         .byte   0x4d,0x24,0x4c,0x20,0x4c,0x20,0x4b,0x24
        4B 24
   B4FB 4A 20 49 20 49 00  5426         .byte   0x4a,0x20,0x49,0x20,0x49,0x00,0x48,0x20
        48 20
   B503 47 20 47 20 46 20  5427         .byte   0x47,0x20,0x47,0x20,0x46,0x20,0x45,0x24
        45 24
   B50B 45 24 44 20 42 20  5428         .byte   0x45,0x24,0x44,0x20,0x42,0x20,0x42,0x20
        42 20
   B513 37 04 35 20 2E 04  5429         .byte   0x37,0x04,0x35,0x20,0x2e,0x04,0x2e,0x04
        2E 04
   B51B 2D 20 23 24 21 20  5430         .byte   0x2d,0x20,0x23,0x24,0x21,0x20,0x17,0x24
        17 24
   B523 13 00 11 24 10 30  5431         .byte   0x13,0x00,0x11,0x24,0x10,0x30,0x07,0x34
        07 34
   B52B 06 30 05 30 FF FF  5432         .byte   0x06,0x30,0x05,0x30,0xff,0xff,0xcd,0x20
        CD 20
   B533 CC 20 CB 20 CB 20  5433         .byte   0xcc,0x20,0xcb,0x20,0xcb,0x20,0xca,0x00
        CA 00
   B53B C9 20 C9 20 C8 20  5434         .byte   0xc9,0x20,0xc9,0x20,0xc8,0x20,0xc1,0xa0
        C1 A0
   B543 C0 A0 B8 A0 B8 20  5435         .byte   0xc0,0xa0,0xb8,0xa0,0xb8,0x20,0xb4,0x20
        B4 20
   B54B A6 00 A4 20 99 00  5436         .byte   0xa6,0x00,0xa4,0x20,0x99,0x00,0x97,0x22
        97 22
   B553 97 22 96 20 95 22  5437         .byte   0x97,0x22,0x96,0x20,0x95,0x22,0x94,0x20
        94 20
   B55B 93 22 93 22 91 20  5438         .byte   0x93,0x22,0x93,0x22,0x91,0x20,0x90,0x20
        90 20
   B563 90 20 8D A0 8C A0  5439         .byte   0x90,0x20,0x8d,0xa0,0x8c,0xa0,0x7d,0xa2
        7D A2
   B56B 7D A2 7B A0 7B A0  5440         .byte   0x7d,0xa2,0x7b,0xa0,0x7b,0xa0,0x79,0xa2
        79 A2
   B573 79 A2 77 A0 77 A0  5441         .byte   0x79,0xa2,0x77,0xa0,0x77,0xa0,0x76,0x80
        76 80
   B57B 75 A0 6E 20 67 24  5442         .byte   0x75,0xa0,0x6e,0x20,0x67,0x24,0x66,0x20
        66 20
   B583 65 24 64 20 63 24  5443         .byte   0x65,0x24,0x64,0x20,0x63,0x24,0x63,0x24
        63 24
   B58B 61 20 60 24 5F 20  5444         .byte   0x61,0x20,0x60,0x24,0x5f,0x20,0x5e,0x20
        5E 20
   B593 5D 24 5C 20 5B 24  5445         .byte   0x5d,0x24,0x5c,0x20,0x5b,0x24,0x5a,0x20
        5A 20
   B59B 59 24 58 20 56 20  5446         .byte   0x59,0x24,0x58,0x20,0x56,0x20,0x55,0x04
        55 04
   B5A3 54 00 53 24 52 20  5447         .byte   0x54,0x00,0x53,0x24,0x52,0x20,0x52,0x20
        52 20
   B5AB 4F 24 4F 24 4E 30  5448         .byte   0x4f,0x24,0x4f,0x24,0x4e,0x30,0x4d,0x30
        4D 30
   B5B3 47 10 45 30 35 30  5449         .byte   0x47,0x10,0x45,0x30,0x35,0x30,0x33,0x10
        33 10
   B5BB 31 30 31 30 1D 20  5450         .byte   0x31,0x30,0x31,0x30,0x1d,0x20,0xff,0xff
        FF FF
   B5C3 A9 20 A3 20 A2 20  5451         .byte   0xa9,0x20,0xa3,0x20,0xa2,0x20,0xa1,0x20
        A1 20
   B5CB A0 20 A0 20 9F 20  5452         .byte   0xa0,0x20,0xa0,0x20,0x9f,0x20,0x9f,0x20
        9F 20
   B5D3 9E 20 9D 24 9D 24  5453         .byte   0x9e,0x20,0x9d,0x24,0x9d,0x24,0x9b,0x20
        9B 20
   B5DB 9A 24 99 20 98 20  5454         .byte   0x9a,0x24,0x99,0x20,0x98,0x20,0x97,0x24
        97 24
   B5E3 97 24 95 20 95 20  5455         .byte   0x97,0x24,0x95,0x20,0x95,0x20,0x94,0x00
        94 00
   B5EB 94 00 93 20 92 00  5456         .byte   0x94,0x00,0x93,0x20,0x92,0x00,0x92,0x00
        92 00
   B5F3 91 20 90 20 90 20  5457         .byte   0x91,0x20,0x90,0x20,0x90,0x20,0x8f,0x20
        8F 20
   B5FB 8D 20 8D 20 81 00  5458         .byte   0x8d,0x20,0x8d,0x20,0x81,0x00,0x7f,0x20
        7F 20
   B603 79 00 79 00 78 20  5459         .byte   0x79,0x00,0x79,0x00,0x78,0x20,0x76,0x20
        76 20
   B60B 6B 00 69 20 5E 00  5460         .byte   0x6b,0x00,0x69,0x20,0x5e,0x00,0x5c,0x20
        5C 20
   B613 5B 30 52 10 51 30  5461         .byte   0x5b,0x30,0x52,0x10,0x51,0x30,0x50,0x30
        50 30
   B61B 50 30 4F 20 4E 20  5462         .byte   0x50,0x30,0x4f,0x20,0x4e,0x20,0x4e,0x20
        4E 20
   B623 4D 20 46 A0 45 A0  5463         .byte   0x4d,0x20,0x46,0xa0,0x45,0xa0,0x3d,0xa0
        3D A0
   B62B 3D A0 39 20 2A 00  5464         .byte   0x3d,0xa0,0x39,0x20,0x2a,0x00,0x28,0x20
        28 20
   B633 1E 00 1C 22 1C 22  5465         .byte   0x1e,0x00,0x1c,0x22,0x1c,0x22,0x1b,0x20
        1B 20
   B63B 1A 22 19 20 18 22  5466         .byte   0x1a,0x22,0x19,0x20,0x18,0x22,0x18,0x22
        18 22
   B643 16 20 15 22 15 22  5467         .byte   0x16,0x20,0x15,0x22,0x15,0x22,0x14,0xa0
        14 A0
   B64B 13 A2 11 A0        5468         .byte   0x13,0xa2,0x11,0xa0
                           5469 
                           5470 ; All empty (0xFFs) in this gap
                           5471 
   F780                    5472         .org    0xf780
                           5473 
                           5474 ; Table???
   F780 57                 5475         .byte   0x57
   F781 0B                 5476         .byte   0x0b
   F782 00                 5477         .byte   0x00
   F783 00                 5478         .byte   0x00
   F784 00                 5479         .byte   0x00
   F785 00                 5480         .byte   0x00
   F786 08                 5481         .byte   0x08
   F787 00                 5482         .byte   0x00
   F788 00                 5483         .byte   0x00
   F789 00                 5484         .byte   0x00
   F78A 20                 5485         .byte   0x20
   F78B 00                 5486         .byte   0x00
   F78C 00                 5487         .byte   0x00
   F78D 00                 5488         .byte   0x00
   F78E 80                 5489         .byte   0x80
   F78F 00                 5490         .byte   0x00
   F790 00                 5491         .byte   0x00
   F791 00                 5492         .byte   0x00
   F792 00                 5493         .byte   0x00
   F793 00                 5494         .byte   0x00
   F794 00                 5495         .byte   0x00
   F795 04                 5496         .byte   0x04
   F796 00                 5497         .byte   0x00
   F797 00                 5498         .byte   0x00
   F798 00                 5499         .byte   0x00
   F799 10                 5500         .byte   0x10
   F79A 00                 5501         .byte   0x00
   F79B 00                 5502         .byte   0x00
   F79C 00                 5503         .byte   0x00
   F79D 00                 5504         .byte   0x00
   F79E 00                 5505         .byte   0x00
   F79F 00                 5506         .byte   0x00
   F7A0 40                 5507         .byte   0x40
   F7A1 12                 5508         .byte   0x12
   F7A2 20                 5509         .byte   0x20
   F7A3 09                 5510         .byte   0x09
   F7A4 80                 5511         .byte   0x80
   F7A5 24                 5512         .byte   0x24
   F7A6 02                 5513         .byte   0x02
   F7A7 00                 5514         .byte   0x00
   F7A8 40                 5515         .byte   0x40
   F7A9 12                 5516         .byte   0x12
   F7AA 20                 5517         .byte   0x20
   F7AB 09                 5518         .byte   0x09
   F7AC 80                 5519         .byte   0x80
   F7AD 24                 5520         .byte   0x24
   F7AE 04                 5521         .byte   0x04
   F7AF 00                 5522         .byte   0x00
   F7B0 00                 5523         .byte   0x00
   F7B1 00                 5524         .byte   0x00
   F7B2 00                 5525         .byte   0x00
   F7B3 00                 5526         .byte   0x00
   F7B4 00                 5527         .byte   0x00
   F7B5 00                 5528         .byte   0x00
   F7B6 00                 5529         .byte   0x00
   F7B7 00                 5530         .byte   0x00
   F7B8 00                 5531         .byte   0x00
   F7B9 00                 5532         .byte   0x00
   F7BA 00                 5533         .byte   0x00
   F7BB 00                 5534         .byte   0x00
   F7BC 08                 5535         .byte   0x08
   F7BD 00                 5536         .byte   0x00
   F7BE 00                 5537         .byte   0x00
   F7BF 00                 5538         .byte   0x00
   F7C0 00                 5539         .byte   0x00
                           5540 ;
                           5541 ; is the rest of this table 0xff, or is this margin??
                           5542 ;
   F800                    5543         .org    0xf800
                           5544 ; Reset
   F800                    5545 RESET:
   F800 0F            [ 2] 5546         sei                 ; disable interrupts
   F801 86 03         [ 2] 5547         ldaa    #0x03
   F803 B7 10 24      [ 4] 5548         staa    TMSK2       ; disable irqs, set prescaler to 16
   F806 86 80         [ 2] 5549         ldaa    #0x80
   F808 B7 10 22      [ 4] 5550         staa    TMSK1       ; enable OC1 (LCD?) irq
   F80B 86 FE         [ 2] 5551         ldaa    #0xFE
   F80D B7 10 35      [ 4] 5552         staa    BPROT       ; protect everything except $xE00-$xE1F
   F810 96 07         [ 3] 5553         ldaa    (0x0007)    ;
   F812 81 DB         [ 2] 5554         cmpa    #0xDB       ; special unprotect mode???
   F814 26 06         [ 3] 5555         bne     LF81C       ; if not, jump ahead
   F816 7F 10 35      [ 6] 5556         clr     BPROT       ; else unprotect everything
   F819 7F 00 07      [ 6] 5557         clr     (0x0007)    ; reset special unprotect mode???
   F81C                    5558 LF81C:
   F81C 8E 01 FF      [ 3] 5559         lds     #0x01FF     ; init SP
   F81F 86 A5         [ 2] 5560         ldaa    #0xA5
   F821 B7 10 5D      [ 4] 5561         staa    CSCTL       ; enable external IO:
                           5562                             ; IO1EN,  BUSSEL, active LOW
                           5563                             ; IO2EN,  PIA/SCCSEL, active LOW
                           5564                             ; CSPROG, ROMSEL priority over RAMSEL 
                           5565                             ; CSPROG, ROMSEL enabled, 32K, $8000-$FFFF
   F824 86 01         [ 2] 5566         ldaa    #0x01
   F826 B7 10 5F      [ 4] 5567         staa    CSGSIZ      ; CSGEN,  RAMSEL active low
                           5568                             ; CSGEN,  RAMSEL 32K
   F829 86 00         [ 2] 5569         ldaa    #0x00
   F82B B7 10 5E      [ 4] 5570         staa    CSGADR      ; CSGEN,  RAMSEL = $0000-$7FFF (except internal regs)
   F82E 86 F0         [ 2] 5571         ldaa    #0xF0
   F830 B7 10 5C      [ 4] 5572         staa    CSSTRH      ; 3 cycle clock stretching on BUSSEL and LCRS
   F833 7F 00 00      [ 6] 5573         clr     (0x0000)    ; ????? Done with basic init?
                           5574 
                           5575 ; Initialize Main PIA
   F836 86 30         [ 2] 5576         ldaa    #0x30       ;
   F838 B7 18 05      [ 4] 5577         staa    (0x1805)    ; control register A, CA2=0, sel DDRA
   F83B B7 18 07      [ 4] 5578         staa    (0x1807)    ; control register B, CB2=0, sel DDRB
   F83E 86 FF         [ 2] 5579         ldaa    #0xFF
   F840 B7 18 06      [ 4] 5580         staa    (0x1806)    ; select B0-B7 to be outputs
   F843 86 78         [ 2] 5581         ldaa    #0x78       ;
   F845 B7 18 04      [ 4] 5582         staa    (0x1804)    ; select A3-A6 to be outputs
   F848 86 34         [ 2] 5583         ldaa    #0x34       ;
   F84A B7 18 05      [ 4] 5584         staa    (0x1805)    ; select output register A
   F84D B7 18 07      [ 4] 5585         staa    (0x1807)    ; select output register B
   F850 C6 FF         [ 2] 5586         ldab    #0xFF
   F852 BD F9 C5      [ 6] 5587         jsr     (0xF9C5)    ; clear dignostic digit display
   F855 20 13         [ 3] 5588         bra     LF86A       ; jump past data table
                           5589 
                           5590 ; Data loaded into (0x180D) SCC
   F857 09 4A              5591         .byte   0x09,0x4a   ; channel reset B, master irq enable, no vector
   F859 01 10              5592         .byte   0x01,0x10   ; irq on all character received
   F85B 0C 18              5593         .byte   0x0c,0x18   ; Lower byte of time constant
   F85D 0D 00              5594         .byte   0x0d,0x00   ; Upper byte of time constant
   F85F 04 44              5595         .byte   0x04,0x44   ; X16 clock mode, 8-bit sync char, 1 stop bit, no parity
   F861 0E 63              5596         .byte   0x0e,0x63   ; Disable DPLL, BR enable & source
   F863 05 68              5597         .byte   0x05,0x68   ; No DTR/RTS, Tx 8 bits/char, Tx enable
   F865 0B 56              5598         .byte   0x0b,0x56   ; Rx & Tx & TRxC clk from BR gen
   F867 03 C1              5599         .byte   0x03,0xc1   ; Rx 8 bits/char, Rx Enable
                           5600         ;   tc = 4Mhz / (2 * DesiredRate * BRClockPeriod) - 2
   F869 FF                 5601         .byte   0xff        ; end of table marker
                           5602 
                           5603 ; init SCC (8530)
   F86A                    5604 LF86A:
   F86A CE F8 57      [ 3] 5605         ldx     #0xF857
   F86D                    5606 LF86D:
   F86D A6 00         [ 4] 5607         ldaa    0,X
   F86F 81 FF         [ 2] 5608         cmpa    #0xFF
   F871 27 06         [ 3] 5609         beq     LF879
   F873 B7 18 0D      [ 4] 5610         staa    (0x180D)
   F876 08            [ 3] 5611         inx
   F877 20 F4         [ 3] 5612         bra     LF86D
                           5613 
                           5614 ; Setup normal SCI, 8 data bits, 1 stop bit
                           5615 ; Interrupts disabled, Transmitter and Receiver enabled
                           5616 ; prescaler = /13, SCR=/2, rate = 9600 baud at 16Mhz clock
                           5617 
   F879                    5618 LF879:
   F879 86 00         [ 2] 5619         ldaa    #0x00
   F87B B7 10 2C      [ 4] 5620         staa    SCCR1  
   F87E 86 0C         [ 2] 5621         ldaa    #0x0C
   F880 B7 10 2D      [ 4] 5622         staa    SCCR2  
   F883 86 31         [ 2] 5623         ldaa    #0x31
   F885 B7 10 2B      [ 4] 5624         staa    BAUD  
                           5625 
                           5626 ; Initialize all RAM vectors to RTI: 
                           5627 ; Opcode 0x3b into vectors at 0x0100 through 0x0139
                           5628 
   F888 CE 01 00      [ 3] 5629         ldx     #0x0100
   F88B 86 3B         [ 2] 5630         ldaa    #0x3B       ; RTI opcode
   F88D                    5631 LF88D:
   F88D A7 00         [ 4] 5632         staa    0,X
   F88F 08            [ 3] 5633         inx
   F890 08            [ 3] 5634         inx
   F891 08            [ 3] 5635         inx
   F892 8C 01 3C      [ 4] 5636         cpx     #0x013C
   F895 25 F6         [ 3] 5637         bcs     LF88D
   F897 C6 F0         [ 2] 5638         ldab    #0xF0
   F899 F7 18 04      [ 4] 5639         stab    (0x1804)    ; enable LCD backlight, disable RESET button light
   F89C 86 7E         [ 2] 5640         ldaa    #0x7E
   F89E 97 03         [ 3] 5641         staa    (0x0003)    ; Put a jump instruction here???
                           5642 
                           5643 ; Non-destructive ram test:
                           5644 ;
                           5645 ; HC11 Internal RAM: 0x0000-0x3ff
                           5646 ; External NVRAM:    0x2000-0x7fff
                           5647 ;
                           5648 ; Note:
                           5649 ; External NVRAM:    0x0400-0xfff is also available, but not tested
                           5650 
   F8A0 CE 00 00      [ 3] 5651         ldx     #0x0000
   F8A3                    5652 LF8A3:
   F8A3 E6 00         [ 4] 5653         ldab    0,X         ; save value
   F8A5 86 55         [ 2] 5654         ldaa    #0x55
   F8A7 A7 00         [ 4] 5655         staa    0,X
   F8A9 A1 00         [ 4] 5656         cmpa    0,X
   F8AB 26 19         [ 3] 5657         bne     LF8C6
   F8AD 49            [ 2] 5658         rola
   F8AE A7 00         [ 4] 5659         staa    0,X
   F8B0 A1 00         [ 4] 5660         cmpa    0,X
   F8B2 26 12         [ 3] 5661         bne     LF8C6
   F8B4 E7 00         [ 4] 5662         stab    0,X         ; restore value
   F8B6 08            [ 3] 5663         inx
   F8B7 8C 04 00      [ 4] 5664         cpx     #0x0400
   F8BA 26 03         [ 3] 5665         bne     LF8BF
   F8BC CE 20 00      [ 3] 5666         ldx     #0x2000
   F8BF                    5667 LF8BF:  
   F8BF 8C 80 00      [ 4] 5668         cpx     #0x8000
   F8C2 26 DF         [ 3] 5669         bne     LF8A3
   F8C4 20 04         [ 3] 5670         bra     LF8CA
                           5671 
   F8C6                    5672 LF8C6:
   F8C6 86 01         [ 2] 5673         ldaa    #0x01       ; Mark Failed RAM test?
   F8C8 97 00         [ 3] 5674         staa    (0x0000)
                           5675 ; 
   F8CA                    5676 LF8CA:
   F8CA C6 01         [ 2] 5677         ldab    #0x01
   F8CC BD F9 95      [ 6] 5678         jsr     (0xF995)    ; write digit 1 to diag display
   F8CF B6 10 35      [ 4] 5679         ldaa    BPROT  
   F8D2 26 0F         [ 3] 5680         bne     LF8E3       ; if something is protected, jump ahead
   F8D4 B6 30 00      [ 4] 5681         ldaa    (0x3000)    ; NVRAM
   F8D7 81 7E         [ 2] 5682         cmpa    #0x7E
   F8D9 26 08         [ 3] 5683         bne     LF8E3       ; if RAM(0x3000) == 0x7E, jump ahead anyway (special unlock?)
                           5684 
                           5685 ; error?
   F8DB C6 0E         [ 2] 5686         ldab    #0x0E
   F8DD BD F9 95      [ 6] 5687         jsr     (0xF995)     ; write digit E to diag display
   F8E0 7E 30 00      [ 3] 5688         jmp     (0x3000)     ; jump to routine in NVRAM?
                           5689 
                           5690 ; checking for serial connection
                           5691 
   F8E3                    5692 LF8E3:
   F8E3 CE F0 00      [ 3] 5693         ldx     #0xF000     ; timeout counter
   F8E6                    5694 LF8E6:
   F8E6 01            [ 2] 5695         nop
   F8E7 01            [ 2] 5696         nop
   F8E8 09            [ 3] 5697         dex
   F8E9 27 0B         [ 3] 5698         beq     LF8F6       ; if time is up, jump ahead
   F8EB BD F9 45      [ 6] 5699         jsr     (0xF945)    ; else read serial data if available
   F8EE 24 F6         [ 3] 5700         bcc     LF8E6       ; if no data available, loop
   F8F0 81 1B         [ 2] 5701         cmpa    #0x1B       ; if serial data was read, is it an ESC?
   F8F2 27 29         [ 3] 5702         beq     LF91D       ; if so, jump to echo hex char routine?
   F8F4 20 F0         [ 3] 5703         bra     LF8E6       ; else loop
   F8F6                    5704 LF8F6:
   F8F6 B6 80 00      [ 4] 5705         ldaa    (0x8000)    ; check if this is a regular rom?
   F8F9 81 7E         [ 2] 5706         cmpa    #0x7E        
   F8FB 26 0B         [ 3] 5707         bne     LF908       ; if not, jump ahead
                           5708 
   F8FD C6 0A         [ 2] 5709         ldab    #0x0A
   F8FF BD F9 95      [ 6] 5710         jsr     (0xF995)    ; else write digit A to diag display
                           5711 
   F902 BD 80 00      [ 6] 5712         jsr     (0x8000)    ; jump to start of rom routine
   F905 0F            [ 2] 5713         sei                 ; if we ever come return, just loop and do it all again
   F906 20 EE         [ 3] 5714         bra     LF8F6
                           5715 
   F908                    5716 LF908:
   F908 C6 10         [ 2] 5717         ldab    #0x10       ; not a regular rom
   F90A BD F9 95      [ 6] 5718         jsr     LF995       ; blank the diag display
                           5719 
   F90D BD F9 D8      [ 6] 5720         jsr     LF9D8       ; enter the mini-monitor???
   F910 4D 49 4E 49 2D 4D  5721         .ascis  'MINI-MON'
        4F CE
                           5722 
   F918 C6 10         [ 2] 5723         ldab    #0x10
   F91A BD F9 95      [ 6] 5724         jsr     LF995       ; blank the diag display
                           5725 
   F91D                    5726 LF91D:
   F91D 7F 00 05      [ 6] 5727         clr     (0x0005)
   F920 7F 00 04      [ 6] 5728         clr     (0x0004)
   F923 7F 00 02      [ 6] 5729         clr     (0x0002)
   F926 7F 00 06      [ 6] 5730         clr     (0x0006)
                           5731 
   F929 BD F9 D8      [ 6] 5732         jsr     LF9D8
   F92C 0D 0A BE           5733         .ascis  '\r\n>'
                           5734 
                           5735 ; convert A to 2 hex digits and transmit??
   F92F 36            [ 3] 5736         psha
   F930 44            [ 2] 5737         lsra
   F931 44            [ 2] 5738         lsra
   F932 44            [ 2] 5739         lsra
   F933 44            [ 2] 5740         lsra
   F934 BD F9 38      [ 6] 5741         jsr     LF938
   F937 32            [ 4] 5742         pula
   F938                    5743 LF938:
   F938 84 0F         [ 2] 5744         anda    #0x0F
   F93A 8A 30         [ 2] 5745         oraa    #0x30
   F93C 81 3A         [ 2] 5746         cmpa    #0x3A
   F93E 25 02         [ 3] 5747         bcs     LF942
   F940 8B 07         [ 2] 5748         adda    #0x07
   F942                    5749 LF942:
   F942 7E F9 6F      [ 3] 5750         jmp     LF96F
                           5751 
                           5752 ; get serial char if available
   F945 B6 10 2E      [ 4] 5753         ldaa    SCSR  
   F948 85 20         [ 2] 5754         bita    #0x20
   F94A 26 09         [ 3] 5755         bne     LF955
   F94C 0C            [ 2] 5756         clc
   F94D 39            [ 5] 5757         rts
                           5758 
                           5759 ; wait for a serial character
   F94E                    5760 LF94E:
   F94E B6 10 2E      [ 4] 5761         ldaa    SCSR        ; read serial status
   F951 85 20         [ 2] 5762         bita    #0x20
   F953 27 F9         [ 3] 5763         beq     LF94E       ; if RDRF=0, loop
                           5764 
                           5765 ; read serial data, (assumes it's ready)
   F955                    5766 LF955:
   F955 B6 10 2E      [ 4] 5767         ldaa    SCSR        ; read serial status
   F958 85 02         [ 2] 5768         bita    #0x02
   F95A 26 09         [ 3] 5769         bne     LF965       ; if FE=1, clear it
   F95C 85 08         [ 2] 5770         bita    #0x08
   F95E 26 05         [ 3] 5771         bne     LF965       ; if OR=1, clear it
   F960 B6 10 2F      [ 4] 5772         ldaa    SCDR        ; otherwise, good data
   F963 0D            [ 2] 5773         sec
   F964 39            [ 5] 5774         rts
                           5775 
   F965                    5776 LF965:
   F965 B6 10 2F      [ 4] 5777         ldaa    SCDR        ; clear any error
   F968 86 2F         [ 2] 5778         ldaa    #0x2F       ; '/'   
   F96A BD F9 6F      [ 6] 5779         jsr     LF96F
   F96D 20 DF         [ 3] 5780         bra     LF94E       ; go to wait for a character
                           5781 
                           5782 ; Send to SCI with CR turned to CRLF
   F96F                    5783 LF96F:
   F96F 81 0D         [ 2] 5784         cmpa    #0x0D       ; CR?
   F971 27 02         [ 3] 5785         beq     LF975       ; if so echo CR+LF
   F973 20 07         [ 3] 5786         bra     LF97C       ; else just echo it
   F975                    5787 LF975:
   F975 86 0D         [ 2] 5788         ldaa    #0x0D
   F977 BD F9 7C      [ 6] 5789         jsr     LF97C
   F97A 86 0A         [ 2] 5790         ldaa    #0x0A
                           5791 
                           5792 ; send a char to SCI
   F97C                    5793 LF97C:
   F97C F6 10 2E      [ 4] 5794         ldab    SCSR        ; wait for ready to send
   F97F C5 40         [ 2] 5795         bitb    #0x40
   F981 27 F9         [ 3] 5796         beq     LF97C
   F983 B7 10 2F      [ 4] 5797         staa    SCDR        ; send it
   F986 39            [ 5] 5798         rts
                           5799 
   F987 BD F9 4E      [ 6] 5800         jsr     LF94E       ; get a serial char
   F98A 81 7A         [ 2] 5801         cmpa    #0x7A       ;'z'
   F98C 22 06         [ 3] 5802         bhi     LF994
   F98E 81 61         [ 2] 5803         cmpa    #0x61       ;'a'
   F990 25 02         [ 3] 5804         bcs     LF994
   F992 82 20         [ 2] 5805         sbca    #0x20       ;convert to pper case?
   F994                    5806 LF994:
   F994 39            [ 5] 5807         rts
                           5808 
                           5809 ; Write hex digit arg in B to diagnostic lights
                           5810 ; or B=0x10 or higher for blank
                           5811 
   F995                    5812 LF995:
   F995 36            [ 3] 5813         psha
   F996 C1 11         [ 2] 5814         cmpb    #0x11
   F998 25 02         [ 3] 5815         bcs     LF99C
   F99A C6 10         [ 2] 5816         ldab    #0x10
   F99C                    5817 LF99C:
   F99C CE F9 B4      [ 3] 5818         ldx     #LF9B4
   F99F 3A            [ 3] 5819         abx
   F9A0 A6 00         [ 4] 5820         ldaa    0,X
   F9A2 B7 18 06      [ 4] 5821         staa    (0x1806)    ; write arg to local data bus
   F9A5 B6 18 04      [ 4] 5822         ldaa    (0x1804)    ; read from Port A
   F9A8 8A 20         [ 2] 5823         oraa    #0x20       ; bit 5 high
   F9AA B7 18 04      [ 4] 5824         staa    (0x1804)    ; write back to Port A
   F9AD 84 DF         [ 2] 5825         anda    #0xDF       ; bit 5 low
   F9AF B7 18 04      [ 4] 5826         staa    (0x1804)    ; write back to Port A
   F9B2 32            [ 4] 5827         pula
   F9B3 39            [ 5] 5828         rts
                           5829 
                           5830 ; 7 segment patterns - XGFEDCBA
   F9B4                    5831 LF9B4:
   F9B4 C0                 5832         .byte   0xc0    ; 0
   F9B5 F9                 5833         .byte   0xf9    ; 1
   F9B6 A4                 5834         .byte   0xa4    ; 2
   F9B7 B0                 5835         .byte   0xb0    ; 3
   F9B8 99                 5836         .byte   0x99    ; 4
   F9B9 92                 5837         .byte   0x92    ; 5
   F9BA 82                 5838         .byte   0x82    ; 6
   F9BB F8                 5839         .byte   0xf8    ; 7
   F9BC 80                 5840         .byte   0x80    ; 8
   F9BD 90                 5841         .byte   0x90    ; 9
   F9BE 88                 5842         .byte   0x88    ; A 
   F9BF 83                 5843         .byte   0x83    ; b
   F9C0 C6                 5844         .byte   0xc6    ; C
   F9C1 A1                 5845         .byte   0xa1    ; d
   F9C2 86                 5846         .byte   0x86    ; E
   F9C3 8E                 5847         .byte   0x8e    ; F
   F9C4 FF                 5848         .byte   0xff    ; blank
                           5849 
                           5850 ; Write arg in B to Button Lights
                           5851 
   F9C5 36            [ 3] 5852         psha
   F9C6 F7 18 06      [ 4] 5853         stab    (0x1806)    ; write arg to local data bus
   F9C9 B6 18 04      [ 4] 5854         ldaa    (0x1804)    ; read from Port A
   F9CC 84 EF         [ 2] 5855         anda    #0xEF       ; bit 4 low
   F9CE B7 18 04      [ 4] 5856         staa    (0x1804)    ; write back to Port A
   F9D1 8A 10         [ 2] 5857         oraa    #0x10       ; bit 4 high
   F9D3 B7 18 04      [ 4] 5858         staa    (0x1804)    ; write this to Port A
   F9D6 32            [ 4] 5859         pula
   F9D7 39            [ 5] 5860         rts
                           5861 
                           5862 ; Send rom message via SCI
                           5863 
   F9D8                    5864 LF9D8:
   F9D8 18 38         [ 6] 5865         puly
   F9DA                    5866 LF9DA:
   F9DA 18 A6 00      [ 5] 5867         ldaa    0,Y
   F9DD 27 09         [ 3] 5868         beq     LF9E8       ; if zero terminated, return
   F9DF 2B 0C         [ 3] 5869         bmi     LF9ED       ; if high bit set..do last char and return
   F9E1 BD F9 7C      [ 6] 5870         jsr     LF97C       ; else send char
   F9E4 18 08         [ 4] 5871         iny
   F9E6 20 F2         [ 3] 5872         bra     LF9DA       ; and loop for next one
                           5873 
   F9E8                    5874 LF9E8:
   F9E8 18 08         [ 4] 5875         iny                 ; setup return address and return
   F9EA 18 3C         [ 5] 5876         pshy
   F9EC 39            [ 5] 5877         rts
                           5878 
   F9ED                    5879 LF9ED:
   F9ED 84 7F         [ 2] 5880         anda    #0x7F       ; remove top bit
   F9EF BD F9 7C      [ 6] 5881         jsr     LF97C       ; send char
   F9F2 20 F4         [ 3] 5882         bra     LF9E8       ; and we're done
   F9F4 39            [ 5] 5883         rts
   F9F5 39            [ 5] 5884         rts
   F9F6 3B            [12] 5885         rti
                           5886 
                           5887 ; all 0xffs in this gap
                           5888 
   FFA0                    5889         .org    0xffa0
                           5890 
   FFA0 7E F9 F5      [ 3] 5891        jmp (0xF9F5)
   FFA3 7E F9 F5      [ 3] 5892        jmp (0xF9F5)
   FFA6 7E F9 F5      [ 3] 5893        jmp (0xF9F5)
   FFA9 7E F9 2F      [ 3] 5894        jmp (0xF92F)
   FFAC 7E F9 D8      [ 3] 5895        jmp (0xF9D8)
   FFAF 7E F9 45      [ 3] 5896        jmp (0xF945)
   FFB2 7E F9 6F      [ 3] 5897        jmp (0xF96F)
   FFB5 7E F9 08      [ 3] 5898        jmp (0xF908)
   FFB8 7E F9 95      [ 3] 5899        jmp (0xF995)
   FFBB 7E F9 C5      [ 3] 5900        jmp (0xF9C5)
                           5901 
   FFBE FF                 5902        .byte    0xff
   FFBF FF                 5903        .byte    0xff
                           5904 
                           5905 ; Vectors
                           5906 
   FFC0 F9 F6              5907        .word   0xf9f6       ; Stub RTI
   FFC2 F9 F6              5908        .word   0xf9f6       ; Stub RTI
   FFC4 F9 F6              5909        .word   0xf9f6       ; Stub RTI
   FFC6 F9 F6              5910        .word   0xf9f6       ; Stub RTI
   FFC8 F9 F6              5911        .word   0xf9f6       ; Stub RTI
   FFCA F9 F6              5912        .word   0xf9f6       ; Stub RTI
   FFCC F9 F6              5913        .word   0xf9f6       ; Stub RTI
   FFCE F9 F6              5914        .word   0xf9f6       ; Stub RTI
   FFD0 F9 F6              5915        .word   0xf9f6       ; Stub RTI
   FFD2 F9 F6              5916        .word   0xf9f6       ; Stub RTI
   FFD4 F9 F6              5917        .word   0xf9f6       ; Stub RTI
                           5918 
   FFD6 01 00              5919         .word  0x0100       ; SCI
   FFD8 01 03              5920         .word  0x0103       ; SPI
   FFDA 01 06              5921         .word  0x0106       ; PA accum. input edge
   FFDC 01 09              5922         .word  0x0109       ; PA Overflow
                           5923 
   FFDE F9 F6              5924         .word  0xf9f6       ; Stub RTI
                           5925 
   FFE0 01 0C              5926         .word  0x010c       ; TI4O5
   FFE2 01 0F              5927         .word  0x010f       ; TOC4
   FFE4 01 12              5928         .word  0x0112       ; TOC3
   FFE6 01 15              5929         .word  0x0115       ; TOC2
   FFE8 01 18              5930         .word  0x0118       ; TOC1
   FFEA 01 1B              5931         .word  0x011b       ; TIC3
   FFEC 01 1E              5932         .word  0x011e       ; TIC2
   FFEE 01 21              5933         .word  0x0121       ; TIC1
   FFF0 01 24              5934         .word  0x0124       ; RTI
   FFF2 01 27              5935         .word  0x0127       ; ~IRQ
   FFF4 01 2A              5936         .word  0x012a       ; XIRQ
   FFF6 01 2D              5937         .word  0x012d       ; SWI
   FFF8 01 30              5938         .word  0x0130       ; ILLEGAL OPCODE
   FFFA 01 33              5939         .word  0x0133       ; COP Failure
   FFFC 01 36              5940         .word  0x0136       ; COP Clock Monitor Fail
                           5941 
   FFFE F8 00              5942         .word  RESET        ; Reset
                           5943 
