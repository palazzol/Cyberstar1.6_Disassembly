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
                     00B0    60 TSCNT       .equ    0x00b0
                             61 
                             62 ; NVRAM locations
                             63 
                     040B    64 CPYRTCS     .equ    0x040B      ; 0x040B/0x040C - copyright message checksum
                     040F    65 ERASEFLG    .equ    0x040F      ; 0 = normal boot, 1 = erasing EEPROM
                     0426    66 NUMBOOT     .equ    0x0426      ; 0x0426/0x0427
                             67 
                             68 ; Main PIA on CPU card
                     1804    69 PIA0PRA     .equ    0x1804      ; CRA-2 = 1
                     1804    70 PIA0DDRA    .equ    0x1804      ; CRA-2 = 0
                     1805    71 PIA0CRA     .equ    0x1805
                     1806    72 PIA0PRB     .equ    0x1806      ; CRB-2 = 1
                     1806    73 PIA0DDRB    .equ    0x1806      ; CRB-2 = 0
                     1807    74 PIA0CRB     .equ    0x1807
                             75 
                             76 ; Zilog 8530 SCC - A is aux serial, B is sync data
                     180C    77 SCCCTRLA    .equ    0x180C
                     180D    78 SCCCTRLB    .equ    0x180D
                     180E    79 SCCDATAA    .equ    0x180E
                     180F    80 SCCDATAB    .equ    0x180F
                             81 
                             82         .area   region1 (ABS)
   8000                      83         .org    0x8000
                             84 
                             85 ; Disassembly originally from unidasm
                             86 
   8000                      87 L8000:
   8000 7E 80 50      [ 3]   88         jmp     L8050           ; jump past copyright message
                             89 
   8003                      90 CPYRTMSG:
   8003 43 6F 70 79 72 69    91         .ascii  'Copyright (c) 1993 by David B. Philipsen Licensed by ShowBiz Pizza Time, Inc.'
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
                             92 
   8050                      93 L8050:
   8050 0F            [ 2]   94         sei
                             95 
   8051 FC 04 26      [ 5]   96         ldd     NUMBOOT         ; increment boot cycle counter?
   8054 C3 00 01      [ 4]   97         addd    #0x0001
   8057 FD 04 26      [ 5]   98         std     NUMBOOT
                             99 
   805A CE AD 1D      [ 3]  100         ldx     #TASK2          ;
   805D FF 01 CE      [ 5]  101         stx     (0x01CE)        ; store this vector here?
   8060 7F 01 C7      [ 6]  102         clr     (0x01C7)
   8063 CC 01 C6      [ 3]  103         ldd     #0x01C6         ;
   8066 FD 01 3E      [ 5]  104         std     (0x013E)        ; store this vector here? Some sort of RTI setup
   8069 7F 00 B0      [ 6]  105         clr     TSCNT
   806C 7F 00 4E      [ 6]  106         clr     (0x004E)
   806F 7F 00 B6      [ 6]  107         clr     (0x00B6)
   8072 7F 00 4D      [ 6]  108         clr     (0x004D)
   8075 86 03         [ 2]  109         ldaa    #0x03
   8077 B7 10 A8      [ 4]  110         staa    (0x10A8)        ; board 11??
   807A 18 CE 00 80   [ 4]  111         ldy     #0x0080         ; delay loop
   807E                     112 L807E:
   807E 18 09         [ 4]  113         dey
   8080 26 FC         [ 3]  114         bne     L807E
   8082 86 11         [ 2]  115         ldaa    #0x11
   8084 B7 10 A8      [ 4]  116         staa    (0x10A8)        ; board 11??
                            117 
   8087 C6 10         [ 2]  118         ldab    #0x10
   8089 BD F9 95      [ 6]  119         jsr     DIAGDGT         ; blank the diag display
                            120 
   808C B6 18 04      [ 4]  121         ldaa    PIA0PRA         ; turn off reset button light
   808F 84 BF         [ 2]  122         anda    #0xBF
   8091 B7 18 04      [ 4]  123         staa    PIA0PRA 
   8094 86 FF         [ 2]  124         ldaa    #0xFF
   8096 97 AC         [ 3]  125         staa    (0x00AC)        ; ???
                            126 
   8098 BD 86 C4      [ 6]  127         jsr     L86C4           ; Init PIAs on cards?
   809B BD 99 A6      [ 6]  128         jsr     L99A6           ; main2?
   809E BD 8C 3C      [ 6]  129         jsr     L8C3C           ; reset LCD?
   80A1 BD 87 E8      [ 6]  130         jsr     L87E8           ; SCC something?
   80A4 BD 87 BC      [ 6]  131         jsr     L87BC           ; SCC something?
   80A7 BD 8C 7E      [ 6]  132         jsr     L8C7E           ; reset LCD buffer
   80AA BD 8D 29      [ 6]  133         jsr     L8D29           ; some LCD command?
   80AD BD 8B C0      [ 6]  134         jsr     L8BC0           ; setup IRQ handlers
   80B0 BD 8B EE      [ 6]  135         jsr     L8BEE
   80B3 0E            [ 2]  136         cli
   80B4 BD A2 5E      [ 6]  137         jsr     LA25E           ; compute and store copyright checksum
   80B7 B6 04 0F      [ 4]  138         ldaa    ERASEFLG
   80BA 81 01         [ 2]  139         cmpa    #0x01           ; 1 means erase EEPROM!
   80BC 26 03         [ 3]  140         bne     L80C1
   80BE 7E A2 75      [ 3]  141         jmp     LA275           ; erase EEPROM: skipped if ERASEFLG !=1
   80C1                     142 L80C1:
   80C1 FC 04 0B      [ 5]  143         ldd     CPYRTCS         ; copyright checksum
   80C4 1A 83 19 7B   [ 5]  144         cpd     #CHKSUM         ; check against copyright checksum value
   80C8 26 4F         [ 3]  145         bne     LOCKUP          ; bye bye
   80CA 5F            [ 2]  146         clrb
   80CB D7 62         [ 3]  147         stab    (0x0062)        ; button light buffer?
   80CD BD F9 C5      [ 6]  148         jsr     BUTNLIT         ; turn off? button lights
   80D0 BD A3 41      [ 6]  149         jsr     (0xA341)
   80D3 B6 04 00      [ 4]  150         ldaa    (0x0400)
   80D6 81 07         [ 2]  151         cmpa    #0x07
   80D8 27 42         [ 3]  152         beq     L811C
   80DA 25 29         [ 3]  153         bcs     L8105
   80DC 81 06         [ 2]  154         cmpa    #0x06
   80DE 27 25         [ 3]  155         beq     L8105
   80E0 CC 00 00      [ 3]  156         ldd     #0x0000
   80E3 FD 04 0D      [ 5]  157         std     (0x040D)
   80E6 CC 00 C8      [ 3]  158         ldd     #0x00C8
   80E9 DD 1B         [ 4]  159         std     CDTIMR1
   80EB                     160 L80EB:
   80EB DC 1B         [ 4]  161         ldd     CDTIMR1
   80ED 27 0B         [ 3]  162         beq     L80FA
   80EF BD F9 45      [ 6]  163         jsr     SERIALR     
   80F2 24 F7         [ 3]  164         bcc     L80EB
   80F4 81 44         [ 2]  165         cmpa    #0x44           ; 'D'
   80F6 26 F3         [ 3]  166         bne     L80EB
   80F8 20 05         [ 3]  167         bra     L80FF
   80FA                     168 L80FA:
   80FA BD 9F 1E      [ 6]  169         jsr     (0x9F1E)
   80FD 25 1A         [ 3]  170         bcs     LOCKUP          ; bye bye
   80FF                     171 L80FF:
   80FF BD 9E AF      [ 6]  172         jsr     (0x9EAF)        ; reset L counts
   8102 BD 9E 92      [ 6]  173         jsr     (0x9E92)        ; reset R counts
   8105                     174 L8105:
   8105 86 39         [ 2]  175         ldaa    #0x39
   8107 B7 04 08      [ 4]  176         staa    0x0408          ; rts here for later CPU test
   810A BD A1 D5      [ 6]  177         jsr     (0xA1D5)
   810D BD AB 17      [ 6]  178         jsr     (0xAB17)
   8110 B6 F7 C0      [ 4]  179         ldaa    (0xF7C0)        ; a 00
   8113 B7 04 5C      [ 4]  180         staa    0x045C          ; ??? NVRAM
   8116 7E F8 00      [ 3]  181         jmp     RESET           ; reset!
                            182 
   8119 7E 81 19      [ 3]  183 LOCKUP: jmp     LOCKUP          ; infinite loop
                            184 
                            185 ; CPU test?
   811C                     186 L811C:
   811C 7F 00 79      [ 6]  187         clr     (0x0079)
   811F 7F 00 7C      [ 6]  188         clr     (0x007C)
   8122 BD 04 08      [ 6]  189         jsr     0x0408          ; rts should be here
   8125 BD 80 13      [ 6]  190         jsr     (0x8013)        ; rts is here '9'
   8128 C6 FD         [ 2]  191         ldab    #0xFD
   812A BD 86 E7      [ 6]  192         jsr     (0x86E7)
   812D C6 DF         [ 2]  193         ldab    #0xDF
   812F BD 87 48      [ 6]  194         jsr     L8748   
   8132 BD 87 91      [ 6]  195         jsr     L8791   
   8135 BD 9A F7      [ 6]  196         jsr     (0x9AF7)
   8138 BD 9C 51      [ 6]  197         jsr     (0x9C51)
   813B 7F 00 62      [ 6]  198         clr     (0x0062)
   813E BD 99 D9      [ 6]  199         jsr     (0x99D9)
   8141 24 16         [ 3]  200         bcc     L8159           ; if carry clear, test is passed
                            201 
   8143 BD 8D E4      [ 6]  202         jsr     LCDMSG1 
   8146 49 6E 76 61 6C 69   203         .ascis  'Invalid CPU!'
        64 20 43 50 55 A1
                            204 
   8152 86 53         [ 2]  205         ldaa    #0x53
   8154 7E 82 A4      [ 3]  206         jmp     (0x82A4)
   8157 20 FE         [ 3]  207 L8157:  bra     L8157           ; infinite loop
                            208 
   8159                     209 L8159:
   8159 BD A3 54      [ 6]  210         jsr     (0xA354)
   815C 7F 00 AA      [ 6]  211         clr     (0x00AA)
   815F 7D 00 00      [ 6]  212         tst     (0x0000)
   8162 27 15         [ 3]  213         beq     L8179
                            214 
   8164 BD 8D E4      [ 6]  215         jsr     LCDMSG1 
   8167 52 41 4D 20 74 65   216         .ascis  'RAM test failed!'
        73 74 20 66 61 69
        6C 65 64 A1
                            217 
   8177 20 44         [ 3]  218         bra     L81BD
                            219 
   8179                     220 L8179:
   8179 BD 8D E4      [ 6]  221         jsr     LCDMSG1 
   817C 33 32 4B 20 52 41   222         .ascis  '32K RAM OK'
        4D 20 4F CB
                            223 
                            224 ; R12 or CNR mode???
   8186 7D 04 5C      [ 6]  225         tst     (0x045C)        ; if this location is 0, good
   8189 26 08         [ 3]  226         bne     L8193
   818B CC 52 0F      [ 3]  227         ldd     #0x520F         ; else print 'R' on the far left of the first line
   818E BD 8D B5      [ 6]  228         jsr     (0x8DB5)        ; display char here on LCD display
   8191 20 06         [ 3]  229         bra     L8199
   8193                     230 L8193:
   8193 CC 43 0F      [ 3]  231         ldd     #0x430F         ; print 'C' on the far left of the first line
   8196 BD 8D B5      [ 6]  232         jsr     (0x8DB5)        ; display char here on LCD display
                            233 
   8199                     234 L8199:
   8199 BD 8D DD      [ 6]  235         jsr     LCDMSG2 
   819C 52 4F 4D 20 43 68   236         .ascis  'ROM Chksum='
        6B 73 75 6D BD
                            237 
   81A7 BD 97 5F      [ 6]  238         jsr     (0x975F)        ; print the checksum on the LCD
                            239 
   81AA C6 02         [ 2]  240         ldab    #0x02           ; delay 2 secs
   81AC BD 8C 02      [ 6]  241         jsr     L8C02           ;
                            242 
   81AF BD 9A 27      [ 6]  243         jsr     (0x9A27)        ; display Serial #
   81B2 BD 9E CC      [ 6]  244         jsr     (0x9ECC)        ; display R and L counts?
   81B5 BD 9B 19      [ 6]  245         jsr     L9B19           ; do the random tasks???
                            246 
   81B8 C6 02         [ 2]  247         ldab    #0x02           ; delay 2 secs
   81BA BD 8C 02      [ 6]  248         jsr     L8C02           ;
                            249 
   81BD                     250 L81BD:
   81BD F6 10 2D      [ 4]  251         ldab    SCCR2           ; disable receive data interrupts
   81C0 C4 DF         [ 2]  252         andb    #0xDF
   81C2 F7 10 2D      [ 4]  253         stab    SCCR2  
                            254 
   81C5 BD 9A F7      [ 6]  255         jsr     (0x9AF7)        ; clear a bunch of ram
   81C8 C6 FD         [ 2]  256         ldab    #0xFD
   81CA BD 86 E7      [ 6]  257         jsr     (0x86E7)
   81CD BD 87 91      [ 6]  258         jsr     L8791   
                            259 
   81D0 C6 00         [ 2]  260         ldab    #0x00           ; turn off button lights
   81D2 D7 62         [ 3]  261         stab    (0x0062)
   81D4 BD F9 C5      [ 6]  262         jsr     BUTNLIT 
                            263 
   81D7 BD 8D E4      [ 6]  264         jsr     LCDMSG1 
   81DA 20 43 79 62 65 72   265         .ascis  ' Cyberstar v1.6'
        73 74 61 72 20 76
        31 2E B6
                            266 
                            267 
   81E9 BD A2 DF      [ 6]  268         jsr     (0xA2DF)
   81EC 24 11         [ 3]  269         bcc     L81FF
   81EE CC 52 0F      [ 3]  270         ldd     #0x520F
   81F1 BD 8D B5      [ 6]  271         jsr     (0x8DB5)        ; display 'R' at far right of 1st line
   81F4 7D 04 2A      [ 6]  272         tst     (0x042A)
   81F7 27 06         [ 3]  273         beq     L81FF
   81F9 CC 4B 0F      [ 3]  274         ldd     #0x4B0F
   81FC BD 8D B5      [ 6]  275         jsr     (0x8DB5)        ; display 'K' at far right of 1st line
   81FF                     276 L81FF:
   81FF BD 8D 03      [ 6]  277         jsr     (0x8D03)
   8202 FC 02 9C      [ 5]  278         ldd     (0x029C)
   8205 1A 83 00 01   [ 5]  279         cpd     #0x0001
   8209 26 15         [ 3]  280         bne     L8220
                            281 
   820B BD 8D DD      [ 6]  282         jsr     LCDMSG2 
   820E 20 44 61 76 65 27   283         .ascis  " Dave's system  "
        73 20 73 79 73 74
        65 6D 20 A0
                            284 
   821E 20 47         [ 3]  285         bra     L8267
   8220                     286 L8220:
   8220 1A 83 03 E8   [ 5]  287         cpd     #0x03E8
   8224 2D 1B         [ 3]  288         blt     L8241
   8226 1A 83 04 4B   [ 5]  289         cpd     #0x044B
   822A 22 15         [ 3]  290         bhi     L8241
                            291 
   822C BD 8D DD      [ 6]  292         jsr     LCDMSG2 
   822F 20 20 20 53 50 54   293         .ascis  '   SPT Studio   '
        20 53 74 75 64 69
        6F 20 20 A0
                            294 
   823F 20 26         [ 3]  295         bra L8267
                            296 
   8241                     297 L8241:
   8241 CC 0E 0C      [ 3]  298         ldd     #0x0E0C
   8244 DD AD         [ 4]  299         std     (0x00AD)
   8246 FC 04 0D      [ 5]  300         ldd     (0x040D)
   8249 1A 83 02 58   [ 5]  301         cpd     #0x0258
   824D 22 05         [ 3]  302         bhi     L8254
   824F CC 0E 09      [ 3]  303         ldd     #0x0E09
   8252 DD AD         [ 4]  304         std     (0x00AD)
   8254                     305 L8254:
   8254 C6 29         [ 2]  306         ldab    #0x29
   8256 CE 0E 00      [ 3]  307         ldx     #0x0E00
   8259                     308 L8259:
   8259 A6 00         [ 4]  309         ldaa    0,X
   825B 4A            [ 2]  310         deca
   825C 08            [ 3]  311         inx
   825D 5C            [ 2]  312         incb
   825E 3C            [ 4]  313         pshx
   825F BD 8D B5      [ 6]  314         jsr     (0x8DB5)        ; display char here on LCD display
   8262 38            [ 5]  315         pulx
   8263 9C AD         [ 5]  316         cpx     (0x00AD)
   8265 26 F2         [ 3]  317         bne     L8259
   8267                     318 L8267:
   8267 BD 9C 51      [ 6]  319         jsr     (0x9C51)
   826A 7F 00 5B      [ 6]  320         clr     (0x005B)
   826D 7F 00 5A      [ 6]  321         clr     (0x005A)
   8270 7F 00 5E      [ 6]  322         clr     (0x005E)
   8273 7F 00 60      [ 6]  323         clr     (0x0060)
   8276 BD 9B 19      [ 6]  324         jsr     L9B19   
   8279 96 60         [ 3]  325         ldaa    (0x0060)
   827B 27 06         [ 3]  326         beq     L8283
   827D BD A9 7C      [ 6]  327         jsr     (0xA97C)
   8280 7E F8 00      [ 3]  328         jmp     RESET       ; reset controller
   8283                     329 L8283:
   8283 B6 18 04      [ 4]  330         ldaa    PIA0PRA 
   8286 84 06         [ 2]  331         anda    #0x06
   8288 26 08         [ 3]  332         bne     L8292
   828A BD 9C F1      [ 6]  333         jsr     (0x9CF1)    ; print credits
   828D C6 32         [ 2]  334         ldab    #0x32
   828F BD 8C 22      [ 6]  335         jsr     (0x8C22)
   8292                     336 L8292:
   8292 BD 8E 95      [ 6]  337         jsr     (0x8E95)
   8295 81 0D         [ 2]  338         cmpa    #0x0D
   8297 26 03         [ 3]  339         bne     L829C
   8299 7E 92 92      [ 3]  340         jmp     (0x9292)
   829C                     341 L829C:
   829C BD F9 45      [ 6]  342         jsr     SERIALR     
   829F 25 03         [ 3]  343         bcs     L82A4
   82A1                     344 L82A1:
   82A1 7E 83 33      [ 3]  345         jmp     L8333
   82A4                     346 L82A4:
   82A4 81 44         [ 2]  347         cmpa    #0x44       ;'$'
   82A6 26 03         [ 3]  348         bne     L82AB
   82A8 7E A3 66      [ 3]  349         jmp     LA366
   82AB                     350 L82AB:
   82AB 81 53         [ 2]  351         cmpa    #0x53       ;'S'
   82AD 26 F2         [ 3]  352         bne     L82A1
                            353 
   82AF BD F9 D8      [ 6]  354         jsr     SERMSGW      
   82B2 0A 0D 45 6E 74 65   355         .ascis  '\n\rEnter security code: '
        72 20 73 65 63 75
        72 69 74 79 20 63
        6F 64 65 3A A0
                            356 
   82C9 0F            [ 2]  357         sei
   82CA BD A2 EA      [ 6]  358         jsr     LA2EA
   82CD 0E            [ 2]  359         cli
   82CE 25 61         [ 3]  360         bcs     L8331
                            361 
   82D0 BD F9 D8      [ 6]  362         jsr     SERMSGW      
   82D3 0A 0D 45 45 50 52   363         .ascii '\n\rEEPROM serial number programming enabled.'
        4F 4D 20 73 65 72
        69 61 6C 20 6E 75
        6D 62 65 72 20 70
        72 6F 67 72 61 6D
        6D 69 6E 67 20 65
        6E 61 62 6C 65 64
        2E
   82FE 0A 0D 50 6C 65 61   364         .ascis '\n\rPlease RESET the processor to continue\n\r'
        73 65 20 52 45 53
        45 54 20 74 68 65
        20 70 72 6F 63 65
        73 73 6F 72 20 74
        6F 20 63 6F 6E 74
        69 6E 75 65 0A 8D
                            365 
   8328 86 01         [ 2]  366         ldaa    #0x01       ; enable EEPROM erase
   832A B7 04 0F      [ 4]  367         staa    ERASEFLG
   832D 86 DB         [ 2]  368         ldaa    #0xDB
   832F 97 07         [ 3]  369         staa    (0x0007)
                            370 ; need to reset to get out of this 
   8331 20 FE         [ 3]  371 L8331:  bra     L8331       ; infinite loop
                            372 
   8333                     373 L8333:
   8333 96 AA         [ 3]  374         ldaa    (0x00AA)
   8335 27 12         [ 3]  375         beq     L8349
   8337 DC 1B         [ 4]  376         ldd     CDTIMR1
   8339 26 0E         [ 3]  377         bne     L8349
   833B D6 62         [ 3]  378         ldab    (0x0062)
   833D C8 20         [ 2]  379         eorb    #0x20
   833F D7 62         [ 3]  380         stab    (0x0062)
   8341 BD F9 C5      [ 6]  381         jsr     BUTNLIT 
   8344 CC 00 32      [ 3]  382         ldd     #0x0032
   8347 DD 1B         [ 4]  383         std     CDTIMR1
   8349                     384 L8349:
   8349 BD 86 A4      [ 6]  385         jsr     (0x86A4)
   834C 24 03         [ 3]  386         bcc L8351
   834E 7E 82 76      [ 3]  387         jmp     (0x8276)
   8351                     388 L8351:
   8351 F6 10 2D      [ 4]  389         ldab    SCCR2  
   8354 CA 20         [ 2]  390         orab    #0x20
   8356 F7 10 2D      [ 4]  391         stab    SCCR2  
   8359 7F 00 AA      [ 6]  392         clr     (0x00AA)
   835C D6 62         [ 3]  393         ldab    (0x0062)
   835E C4 DF         [ 2]  394         andb    #0xDF
   8360 D7 62         [ 3]  395         stab    (0x0062)
   8362 BD F9 C5      [ 6]  396         jsr     BUTNLIT 
   8365 C6 02         [ 2]  397         ldab    #0x02           ; delay 2 secs
   8367 BD 8C 02      [ 6]  398         jsr     L8C02           ;
   836A 96 7C         [ 3]  399         ldaa    (0x007C)
   836C 27 2D         [ 3]  400         beq     L839B
   836E 96 7F         [ 3]  401         ldaa    (0x007F)
   8370 97 4E         [ 3]  402         staa    (0x004E)
   8372 D6 81         [ 3]  403         ldab    (0x0081)
   8374 BD 87 48      [ 6]  404         jsr     L8748   
   8377 96 82         [ 3]  405         ldaa    (0x0082)
   8379 85 01         [ 2]  406         bita    #0x01
   837B 26 06         [ 3]  407         bne     L8383
   837D 96 AC         [ 3]  408         ldaa    (0x00AC)
   837F 84 FD         [ 2]  409         anda    #0xFD
   8381 20 04         [ 3]  410         bra     L8387
   8383                     411 L8383:
   8383 96 AC         [ 3]  412         ldaa    (0x00AC)
   8385 8A 02         [ 2]  413         oraa    #0x02
   8387                     414 L8387:
   8387 97 AC         [ 3]  415         staa    (0x00AC)
   8389 B7 18 06      [ 4]  416         staa    PIA0PRB 
   838C B6 18 04      [ 4]  417         ldaa    PIA0PRA 
   838F 8A 20         [ 2]  418         oraa    #0x20
   8391 B7 18 04      [ 4]  419         staa    PIA0PRA 
   8394 84 DF         [ 2]  420         anda    #0xDF
   8396 B7 18 04      [ 4]  421         staa    PIA0PRA 
   8399 20 14         [ 3]  422         bra     L83AF
   839B                     423 L839B:
   839B FC 04 0D      [ 5]  424         ldd     (0x040D)
   839E 1A 83 FD E8   [ 5]  425         cpd     #0xFDE8
   83A2 22 06         [ 3]  426         bhi     L83AA
   83A4 C3 00 01      [ 4]  427         addd    #0x0001
   83A7 FD 04 0D      [ 5]  428         std     (0x040D)
   83AA                     429 L83AA:
   83AA C6 F7         [ 2]  430         ldab    #0xF7
   83AC BD 86 E7      [ 6]  431         jsr     (0x86E7)
   83AF                     432 L83AF:
   83AF 7F 00 30      [ 6]  433         clr     (0x0030)
   83B2 7F 00 31      [ 6]  434         clr     (0x0031)
   83B5 7F 00 32      [ 6]  435         clr     (0x0032)
   83B8 BD 9B 19      [ 6]  436         jsr     L9B19   
   83BB BD 86 A4      [ 6]  437         jsr     (0x86A4)
   83BE 25 EF         [ 3]  438         bcs     L83AF
   83C0 96 79         [ 3]  439         ldaa    (0x0079)
   83C2 27 17         [ 3]  440         beq     L83DB
   83C4 7F 00 79      [ 6]  441         clr     (0x0079)
   83C7 96 B5         [ 3]  442         ldaa    (0x00B5)
   83C9 81 01         [ 2]  443         cmpa    #0x01
   83CB 26 07         [ 3]  444         bne     L83D4
   83CD 7F 00 B5      [ 6]  445         clr     (0x00B5)
   83D0 86 01         [ 2]  446         ldaa    #0x01
   83D2 97 7C         [ 3]  447         staa    (0x007C)
   83D4                     448 L83D4:
   83D4 86 01         [ 2]  449         ldaa    #0x01
   83D6 97 AA         [ 3]  450         staa    (0x00AA)
   83D8 7E 9A 7F      [ 3]  451         jmp     (0x9A7F)
   83DB                     452 L83DB:
   83DB BD 8D E4      [ 6]  453         jsr     LCDMSG1 
   83DE 20 20 20 54 61 70   454         .ascis  '   Tape start   '
        65 20 73 74 61 72
        74 20 20 A0
                            455 
   83EE D6 62         [ 3]  456         ldab    (0x0062)
   83F0 CA 80         [ 2]  457         orab    #0x80
   83F2 D7 62         [ 3]  458         stab    (0x0062)
   83F4 BD F9 C5      [ 6]  459         jsr     BUTNLIT 
   83F7 C6 FB         [ 2]  460         ldab    #0xFB
   83F9 BD 86 E7      [ 6]  461         jsr     (0x86E7)
                            462 
   83FC BD 8D CF      [ 6]  463         jsr     LCDMSG1A
   83FF 36 38 48 43 31 31   464         .ascis  '68HC11 Proto'
        20 50 72 6F 74 EF
                            465 
   840B BD 8D D6      [ 6]  466         jsr     LCDMSG2A
   840E 64 62 F0            467         .ascis  'dbp'
                            468 
   8411 C6 03         [ 2]  469         ldab    #0x03           ; delay 3 secs
   8413 BD 8C 02      [ 6]  470         jsr     L8C02           ;
   8416 7D 00 7C      [ 6]  471         tst     (0x007C)
   8419 27 15         [ 3]  472         beq     L8430
   841B D6 80         [ 3]  473         ldab    (0x0080)
   841D D7 62         [ 3]  474         stab    (0x0062)
   841F BD F9 C5      [ 6]  475         jsr     BUTNLIT 
   8422 D6 7D         [ 3]  476         ldab    (0x007D)
   8424 D7 78         [ 3]  477         stab    (0x0078)
   8426 D6 7E         [ 3]  478         ldab    (0x007E)
   8428 F7 10 8A      [ 4]  479         stab    (0x108A)
   842B 7F 00 7C      [ 6]  480         clr     (0x007C)
   842E 20 1D         [ 3]  481         bra     L844D
   8430                     482 L8430:
   8430 BD 8D 03      [ 6]  483         jsr     (0x8D03)
   8433 BD 9D 18      [ 6]  484         jsr     (0x9D18)
   8436 24 08         [ 3]  485         bcc     L8440
   8438 7D 00 B8      [ 6]  486         tst     (0x00B8)
   843B 27 F3         [ 3]  487         beq     L8430
   843D 7E 9A 60      [ 3]  488         jmp     (0x9A60)
   8440                     489 L8440:
   8440 7D 00 B8      [ 6]  490         tst     (0x00B8)
   8443 27 EB         [ 3]  491         beq     L8430
   8445 7F 00 30      [ 6]  492         clr     (0x0030)
   8448 7F 00 31      [ 6]  493         clr     (0x0031)
   844B 20 00         [ 3]  494         bra     L844D
   844D                     495 L844D:
   844D 96 49         [ 3]  496         ldaa    (0x0049)
   844F 26 03         [ 3]  497         bne     L8454
   8451 7E 85 A4      [ 3]  498         jmp     (0x85A4)
   8454                     499 L8454:
   8454 7F 00 49      [ 6]  500         clr     (0x0049)
   8457 81 31         [ 2]  501         cmpa    #0x31
   8459 26 08         [ 3]  502         bne     L8463
   845B BD A3 26      [ 6]  503         jsr     (0xA326)
   845E BD 8D 42      [ 6]  504         jsr     (0x8D42)
   8461 20 EA         [ 3]  505         bra     L844D
   8463                     506 L8463:
   8463 81 32         [ 2]  507         cmpa    #0x32
   8465 26 08         [ 3]  508         bne     L846F
   8467 BD A3 26      [ 6]  509         jsr     (0xA326)
   846A BD 8D 35      [ 6]  510         jsr     (0x8D35)
   846D 20 DE         [ 3]  511         bra     L844D
   846F                     512 L846F:
   846F 81 54         [ 2]  513         cmpa    #0x54
   8471 26 08         [ 3]  514         bne     L847B
   8473 BD A3 26      [ 6]  515         jsr     (0xA326)
   8476 BD 8D 42      [ 6]  516         jsr     (0x8D42)
   8479 20 D2         [ 3]  517         bra     L844D
   847B                     518 L847B:
   847B 81 5A         [ 2]  519         cmpa    #0x5A
   847D 26 1C         [ 3]  520         bne     L849B
   847F BD A3 1E      [ 6]  521         jsr     (0xA31E)
   8482 BD 8E 95      [ 6]  522         jsr     (0x8E95)
   8485 7F 00 32      [ 6]  523         clr     (0x0032)
   8488 7F 00 31      [ 6]  524         clr     (0x0031)
   848B 7F 00 30      [ 6]  525         clr     (0x0030)
   848E BD 99 A6      [ 6]  526         jsr     L99A6
   8491 D6 7B         [ 3]  527         ldab    (0x007B)
   8493 CA 0C         [ 2]  528         orab    #0x0C
   8495 BD 87 48      [ 6]  529         jsr     L8748   
   8498 7E 81 BD      [ 3]  530         jmp     L81BD
   849B                     531 L849B:
   849B 81 42         [ 2]  532         cmpa    #0x42
   849D 26 03         [ 3]  533         bne     L84A2
   849F 7E 98 3C      [ 3]  534         jmp     (0x983C)
   84A2                     535 L84A2:
   84A2 81 4D         [ 2]  536         cmpa    #0x4D
   84A4 26 03         [ 3]  537         bne     L84A9
   84A6 7E 98 24      [ 3]  538         jmp     (0x9824)
   84A9                     539 L84A9:
   84A9 81 45         [ 2]  540         cmpa    #0x45
   84AB 26 03         [ 3]  541         bne     L84B0
   84AD 7E 98 02      [ 3]  542         jmp     (0x9802)
   84B0                     543 L84B0:
   84B0 81 58         [ 2]  544         cmpa    #0x58
   84B2 26 05         [ 3]  545         bne     L84B9
   84B4 7E 99 3F      [ 3]  546         jmp     (0x993F)
   84B7 20 94         [ 3]  547         bra     L844D
   84B9                     548 L84B9:
   84B9 81 46         [ 2]  549         cmpa    #0x46
   84BB 26 03         [ 3]  550         bne     L84C0
   84BD 7E 99 71      [ 3]  551         jmp     (0x9971)
   84C0                     552 L84C0:
   84C0 81 47         [ 2]  553         cmpa    #0x47
   84C2 26 03         [ 3]  554         bne     L84C7
   84C4 7E 99 7B      [ 3]  555         jmp     (0x997B)
   84C7                     556 L84C7:
   84C7 81 48         [ 2]  557         cmpa    #0x48
   84C9 26 03         [ 3]  558         bne     L84CE
   84CB 7E 99 85      [ 3]  559         jmp     (0x9985)
   84CE                     560 L84CE:
   84CE 81 49         [ 2]  561         cmpa    #0x49
   84D0 26 03         [ 3]  562         bne     L84D5
   84D2 7E 99 8F      [ 3]  563         jmp     (0x998F)
   84D5                     564 L84D5:
   84D5 81 53         [ 2]  565         cmpa    #0x53
   84D7 26 03         [ 3]  566         bne     L84DC
   84D9 7E 97 BA      [ 3]  567         jmp     (0x97BA)
   84DC                     568 L84DC:
   84DC 81 59         [ 2]  569         cmpa    #0x59
   84DE 26 03         [ 3]  570         bne     L84E3
   84E0 7E 99 D2      [ 3]  571         jmp     (0x99D2)
   84E3                     572 L84E3:
   84E3 81 57         [ 2]  573         cmpa    #0x57
   84E5 26 03         [ 3]  574         bne     L84EA
   84E7 7E 9A A4      [ 3]  575         jmp     (0x9AA4)
   84EA                     576 L84EA:
   84EA 81 41         [ 2]  577         cmpa    #0x41
   84EC 26 17         [ 3]  578         bne     L8505
   84EE BD 9D 18      [ 6]  579         jsr     (0x9D18)
   84F1 25 09         [ 3]  580         bcs     L84FC
   84F3 7F 00 30      [ 6]  581         clr     (0x0030)
   84F6 7F 00 31      [ 6]  582         clr     (0x0031)
   84F9 7E 85 A4      [ 3]  583         jmp     (0x85A4)
   84FC                     584 L84FC:
   84FC 7F 00 30      [ 6]  585         clr     (0x0030)
   84FF 7F 00 31      [ 6]  586         clr     (0x0031)
   8502 7E 9A 7F      [ 3]  587         jmp     (0x9A7F)
   8505                     588 L8505:
   8505 81 4B         [ 2]  589         cmpa    #0x4B
   8507 26 0B         [ 3]  590         bne     L8514
   8509 BD 9D 18      [ 6]  591         jsr     (0x9D18)
   850C 25 03         [ 3]  592         bcs     L8511
   850E 7E 85 A4      [ 3]  593         jmp     (0x85A4)
   8511                     594 L8511:
   8511 7E 9A 7F      [ 3]  595         jmp     (0x9A7F)
   8514                     596 L8514:
   8514 81 4A         [ 2]  597         cmpa    #0x4A
   8516 26 07         [ 3]  598         bne     L851F
   8518 86 01         [ 2]  599         ldaa    #0x01
   851A 97 AF         [ 3]  600         staa    (0x00AF)
   851C 7E 98 3C      [ 3]  601         jmp     (0x983C)
   851F                     602 L851F:
   851F 81 4E         [ 2]  603         cmpa    #0x4E
   8521 26 0B         [ 3]  604         bne     L852E
   8523 B6 10 8A      [ 4]  605         ldaa    (0x108A)
   8526 8A 02         [ 2]  606         oraa    #0x02
   8528 B7 10 8A      [ 4]  607         staa    (0x108A)
   852B 7E 84 4D      [ 3]  608         jmp     (0x844D)
   852E                     609 L852E:
   852E 81 4F         [ 2]  610         cmpa    #0x4F
   8530 26 06         [ 3]  611         bne     L8538
   8532 BD 9D 18      [ 6]  612         jsr     (0x9D18)
   8535 7E 84 4D      [ 3]  613         jmp     (0x844D)
   8538                     614 L8538:
   8538 81 50         [ 2]  615         cmpa    #0x50
   853A 26 06         [ 3]  616         bne     L8542
   853C BD 9D 18      [ 6]  617         jsr     (0x9D18)
   853F 7E 84 4D      [ 3]  618         jmp     (0x844D)
   8542                     619 L8542:
   8542 81 51         [ 2]  620         cmpa    #0x51
   8544 26 0B         [ 3]  621         bne     L8551
   8546 B6 10 8A      [ 4]  622         ldaa    (0x108A)
   8549 8A 04         [ 2]  623         oraa    #0x04
   854B B7 10 8A      [ 4]  624         staa    (0x108A)
   854E 7E 84 4D      [ 3]  625         jmp     (0x844D)
   8551                     626 L8551:
   8551 81 55         [ 2]  627         cmpa    #0x55
   8553 26 07         [ 3]  628         bne     L855C
   8555 C6 01         [ 2]  629         ldab    #0x01
   8557 D7 B6         [ 3]  630         stab    (0x00B6)
   8559 7E 84 4D      [ 3]  631         jmp     (0x844D)
   855C                     632 L855C:
   855C 81 4C         [ 2]  633         cmpa    #0x4C
   855E 26 19         [ 3]  634         bne     L8579
   8560 7F 00 49      [ 6]  635         clr     (0x0049)
   8563 BD 9D 18      [ 6]  636         jsr     (0x9D18)
   8566 25 0E         [ 3]  637         bcs     L8576
   8568 BD AA E8      [ 6]  638         jsr     (0xAAE8)
   856B BD AB 56      [ 6]  639         jsr     (0xAB56)
   856E 24 06         [ 3]  640         bcc     L8576
   8570 BD AB 25      [ 6]  641         jsr     (0xAB25)
   8573 BD AB 46      [ 6]  642         jsr     (0xAB46)
   8576                     643 L8576:
   8576 7E 84 4D      [ 3]  644         jmp     (0x844D)
   8579                     645 L8579:
   8579 81 52         [ 2]  646         cmpa    #0x52
   857B 26 1A         [ 3]  647         bne     L8597
   857D 7F 00 49      [ 6]  648         clr     (0x0049)
   8580 BD 9D 18      [ 6]  649         jsr     (0x9D18)
   8583 25 0F         [ 3]  650         bcs     L8594
   8585 BD AA E8      [ 6]  651         jsr     (0xAAE8)
   8588 BD AB 56      [ 6]  652         jsr     (0xAB56)
   858B 25 07         [ 3]  653         bcs     L8594
   858D 86 FF         [ 2]  654         ldaa    #0xFF
   858F A7 00         [ 4]  655         staa    0,X
   8591 BD AA E8      [ 6]  656         jsr     (0xAAE8)
   8594                     657 L8594:
   8594 7E 84 4D      [ 3]  658         jmp     (0x844D)
   8597                     659 L8597:
   8597 81 44         [ 2]  660         cmpa    #0x44
   8599 26 09         [ 3]  661         bne     L85A4
   859B 7F 00 49      [ 6]  662         clr     (0x0049)
   859E BD AB AE      [ 6]  663         jsr     (0xABAE)
   85A1 7E 84 4D      [ 3]  664         jmp     L844D
   85A4                     665 L85A4:
   85A4 7D 00 75      [ 6]  666         tst     (0x0075)
   85A7 26 56         [ 3]  667         bne     L85FF
   85A9 7D 00 79      [ 6]  668         tst     (0x0079)
   85AC 26 51         [ 3]  669         bne     L85FF
   85AE 7D 00 30      [ 6]  670         tst     (0x0030)
   85B1 26 07         [ 3]  671         bne     L85BA
   85B3 96 5B         [ 3]  672         ldaa    (0x005B)
   85B5 27 48         [ 3]  673         beq     L85FF
   85B7 7F 00 5B      [ 6]  674         clr     (0x005B)
   85BA                     675 L85BA:
   85BA CC 00 64      [ 3]  676         ldd     #0x0064
   85BD DD 23         [ 4]  677         std     CDTIMR5
   85BF                     678 L85BF:
   85BF DC 23         [ 4]  679         ldd     CDTIMR5
   85C1 27 14         [ 3]  680         beq     L85D7
   85C3 BD 9B 19      [ 6]  681         jsr     L9B19   
   85C6 B6 18 04      [ 4]  682         ldaa    PIA0PRA 
   85C9 88 FF         [ 2]  683         eora    #0xFF
   85CB 84 06         [ 2]  684         anda    #0x06
   85CD 81 06         [ 2]  685         cmpa    #0x06
   85CF 26 EE         [ 3]  686         bne     L85BF
   85D1 7F 00 30      [ 6]  687         clr     (0x0030)
   85D4 7E 86 80      [ 3]  688         jmp     (0x8680)
   85D7                     689 L85D7:
   85D7 7F 00 30      [ 6]  690         clr     (0x0030)
   85DA D6 62         [ 3]  691         ldab    (0x0062)
   85DC C8 02         [ 2]  692         eorb    #0x02
   85DE D7 62         [ 3]  693         stab    (0x0062)
   85E0 BD F9 C5      [ 6]  694         jsr     BUTNLIT 
   85E3 C4 02         [ 2]  695         andb    #0x02
   85E5 27 0D         [ 3]  696         beq     L85F4
   85E7 BD AA 18      [ 6]  697         jsr     (0xAA18)
   85EA C6 1E         [ 2]  698         ldab    #0x1E
   85EC BD 8C 22      [ 6]  699         jsr     (0x8C22)
   85EF 7F 00 30      [ 6]  700         clr     (0x0030)
   85F2 20 0B         [ 3]  701         bra     L85FF
   85F4                     702 L85F4:
   85F4 BD AA 1D      [ 6]  703         jsr     (0xAA1D)
   85F7 C6 1E         [ 2]  704         ldab    #0x1E
   85F9 BD 8C 22      [ 6]  705         jsr     (0x8C22)
   85FC 7F 00 30      [ 6]  706         clr     (0x0030)
   85FF                     707 L85FF:
   85FF BD 9B 19      [ 6]  708         jsr     L9B19   
   8602 B6 10 0A      [ 4]  709         ldaa    PORTE
   8605 84 10         [ 2]  710         anda    #0x10
   8607 27 0B         [ 3]  711         beq     L8614
   8609 B6 18 04      [ 4]  712         ldaa    PIA0PRA 
   860C 88 FF         [ 2]  713         eora    #0xFF
   860E 84 07         [ 2]  714         anda    #0x07
   8610 81 06         [ 2]  715         cmpa    #0x06
   8612 26 1C         [ 3]  716         bne     L8630
   8614                     717 L8614:
   8614 7D 00 76      [ 6]  718         tst     (0x0076)
   8617 26 17         [ 3]  719         bne     L8630
   8619 7D 00 75      [ 6]  720         tst     (0x0075)
   861C 26 12         [ 3]  721         bne     L8630
   861E D6 62         [ 3]  722         ldab    (0x0062)
   8620 C4 FC         [ 2]  723         andb    #0xFC
   8622 D7 62         [ 3]  724         stab    (0x0062)
   8624 BD F9 C5      [ 6]  725         jsr     BUTNLIT 
   8627 BD AA 13      [ 6]  726         jsr     (0xAA13)
   862A BD AA 1D      [ 6]  727         jsr     (0xAA1D)
   862D 7E 9A 60      [ 3]  728         jmp     (0x9A60)
   8630                     729 L8630:
   8630 7D 00 31      [ 6]  730         tst     (0x0031)
   8633 26 07         [ 3]  731         bne     L863C
   8635 96 5A         [ 3]  732         ldaa    (0x005A)
   8637 27 47         [ 3]  733         beq     L8680
   8639 7F 00 5A      [ 6]  734         clr     (0x005A)
   863C                     735 L863C:
   863C CC 00 64      [ 3]  736         ldd     #0x0064
   863F DD 23         [ 4]  737         std     CDTIMR5
   8641                     738 L8641:
   8641 DC 23         [ 4]  739         ldd     CDTIMR5
   8643 27 13         [ 3]  740         beq     L8658
   8645 BD 9B 19      [ 6]  741         jsr     L9B19   
   8648 B6 18 04      [ 4]  742         ldaa    PIA0PRA 
   864B 88 FF         [ 2]  743         eora    #0xFF
   864D 84 06         [ 2]  744         anda    #0x06
   864F 81 06         [ 2]  745         cmpa    #0x06
   8651 26 EE         [ 3]  746         bne     L8641
   8653 7F 00 31      [ 6]  747         clr     (0x0031)
   8656 20 28         [ 3]  748         bra     L8680
   8658                     749 L8658:
   8658 7F 00 31      [ 6]  750         clr     (0x0031)
   865B D6 62         [ 3]  751         ldab    (0x0062)
   865D C8 01         [ 2]  752         eorb    #0x01
   865F D7 62         [ 3]  753         stab    (0x0062)
   8661 BD F9 C5      [ 6]  754         jsr     BUTNLIT 
   8664 C4 01         [ 2]  755         andb    #0x01
   8666 27 0D         [ 3]  756         beq     L8675
   8668 BD AA 0C      [ 6]  757         jsr     (0xAA0C)
   866B C6 1E         [ 2]  758         ldab    #0x1E
   866D BD 8C 22      [ 6]  759         jsr     (0x8C22)
   8670 7F 00 31      [ 6]  760         clr     (0x0031)
   8673 20 0B         [ 3]  761         bra     L8680
   8675                     762 L8675:
   8675 BD AA 13      [ 6]  763         jsr     (0xAA13)
   8678 C6 1E         [ 2]  764         ldab    #0x1E
   867A BD 8C 22      [ 6]  765         jsr     (0x8C22)
   867D 7F 00 31      [ 6]  766         clr     (0x0031)
   8680                     767 L8680:
   8680 BD 86 A4      [ 6]  768         jsr     (0x86A4)
   8683 25 1C         [ 3]  769         bcs     L86A1
   8685 7F 00 4E      [ 6]  770         clr     (0x004E)
   8688 BD 99 A6      [ 6]  771         jsr     L99A6
   868B BD 86 C4      [ 6]  772         jsr     L86C4
   868E 5F            [ 2]  773         clrb
   868F D7 62         [ 3]  774         stab    (0x0062)
   8691 BD F9 C5      [ 6]  775         jsr     BUTNLIT 
   8694 C6 FD         [ 2]  776         ldab    #0xFD
   8696 BD 86 E7      [ 6]  777         jsr     (0x86E7)
   8699 C6 04         [ 2]  778         ldab    #0x04           ; delay 4 secs
   869B BD 8C 02      [ 6]  779         jsr     L8C02           ;
   869E 7E 84 7F      [ 3]  780         jmp     (0x847F)
   86A1                     781 L86A1:
   86A1 7E 84 4D      [ 3]  782         jmp     (0x844D)
   86A4 BD 9B 19      [ 6]  783         jsr     L9B19   
   86A7 7F 00 23      [ 6]  784         clr     CDTIMR5
   86AA 86 19         [ 2]  785         ldaa    #0x19
   86AC 97 24         [ 3]  786         staa    CDTIMR5+1
   86AE B6 10 0A      [ 4]  787         ldaa    PORTE
   86B1 84 80         [ 2]  788         anda    #0x80
   86B3 27 02         [ 3]  789         beq     L86B7
   86B5                     790 L86B5:
   86B5 0D            [ 2]  791         sec
   86B6 39            [ 5]  792         rts
                            793 
   86B7                     794 L86B7:
   86B7 B6 10 0A      [ 4]  795         ldaa    PORTE
   86BA 84 80         [ 2]  796         anda    #0x80
   86BC 26 F7         [ 3]  797         bne     L86B5
   86BE 96 24         [ 3]  798         ldaa    CDTIMR5+1
   86C0 26 F5         [ 3]  799         bne     L86B7
   86C2 0C            [ 2]  800         clc
   86C3 39            [ 5]  801         rts
                            802 
                            803 ; main1 - init boards 1-9 at:
                            804 ;         0x1080, 0x1084, 0x1088, 0x108c
                            805 ;         0x1090, 0x1094, 0x1098, 0x109c
                            806 ;         0x10a0
                            807 
   86C4                     808 L86C4:
   86C4 CE 10 80      [ 3]  809         ldx     #0x1080
   86C7                     810 L86C7:
   86C7 86 30         [ 2]  811         ldaa    #0x30
   86C9 A7 01         [ 4]  812         staa    1,X
   86CB A7 03         [ 4]  813         staa    3,X
   86CD 86 FF         [ 2]  814         ldaa    #0xFF
   86CF A7 00         [ 4]  815         staa    0,X
   86D1 A7 02         [ 4]  816         staa    2,X
   86D3 86 34         [ 2]  817         ldaa    #0x34
   86D5 A7 01         [ 4]  818         staa    1,X
   86D7 A7 03         [ 4]  819         staa    3,X
   86D9 6F 00         [ 6]  820         clr     0,X
   86DB 6F 02         [ 6]  821         clr     2,X
   86DD 08            [ 3]  822         inx
   86DE 08            [ 3]  823         inx
   86DF 08            [ 3]  824         inx
   86E0 08            [ 3]  825         inx
   86E1 8C 10 A4      [ 4]  826         cpx     #0x10A4
   86E4 2F E1         [ 3]  827         ble     L86C7
   86E6 39            [ 5]  828         rts
                            829 
                            830 ; ***
   86E7 36            [ 3]  831         psha
   86E8 BD 9B 19      [ 6]  832         jsr     L9B19   
   86EB 96 AC         [ 3]  833         ldaa    (0x00AC)
   86ED C1 FB         [ 2]  834         cmpb    #0xFB
   86EF 26 04         [ 3]  835         bne     L86F5
   86F1 84 FE         [ 2]  836         anda    #0xFE
   86F3 20 0E         [ 3]  837         bra     L8703
   86F5                     838 L86F5:
   86F5 C1 F7         [ 2]  839         cmpb    #0xF7
   86F7 26 04         [ 3]  840         bne     L86FD
   86F9 84 BF         [ 2]  841         anda    #0xBF
   86FB 20 06         [ 3]  842         bra     L8703
   86FD                     843 L86FD:
   86FD C1 FD         [ 2]  844         cmpb    #0xFD
   86FF 26 02         [ 3]  845         bne     L8703
   8701 84 F7         [ 2]  846         anda    #0xF7
   8703                     847 L8703:
   8703 97 AC         [ 3]  848         staa    (0x00AC)
   8705 B7 18 06      [ 4]  849         staa    PIA0PRB 
   8708 BD 87 3A      [ 6]  850         jsr     L873A        ; clock diagnostic indicator
   870B 96 7A         [ 3]  851         ldaa    (0x007A)
   870D 84 01         [ 2]  852         anda    #0x01
   870F 97 7A         [ 3]  853         staa    (0x007A)
   8711 C4 FE         [ 2]  854         andb    #0xFE
   8713 DA 7A         [ 3]  855         orab    (0x007A)
   8715 F7 18 06      [ 4]  856         stab    PIA0PRB 
   8718 BD 87 75      [ 6]  857         jsr     L8775   
   871B C6 32         [ 2]  858         ldab    #0x32
   871D BD 8C 22      [ 6]  859         jsr     (0x8C22)
   8720 C6 FE         [ 2]  860         ldab    #0xFE
   8722 DA 7A         [ 3]  861         orab    (0x007A)
   8724 F7 18 06      [ 4]  862         stab    PIA0PRB 
   8727 D7 7A         [ 3]  863         stab    (0x007A)
   8729 BD 87 75      [ 6]  864         jsr     L8775   
   872C 96 AC         [ 3]  865         ldaa    (0x00AC)
   872E 8A 49         [ 2]  866         oraa    #0x49
   8730 97 AC         [ 3]  867         staa    (0x00AC)
   8732 B7 18 06      [ 4]  868         staa    PIA0PRB 
   8735 BD 87 3A      [ 6]  869         jsr     L873A        ; clock diagnostic indicator
   8738 32            [ 4]  870         pula
   8739 39            [ 5]  871         rts
                            872 
                            873 ; clock diagnostic indicator
   873A                     874 L873A:
   873A B6 18 04      [ 4]  875         ldaa    PIA0PRA 
   873D 8A 20         [ 2]  876         oraa    #0x20
   873F B7 18 04      [ 4]  877         staa    PIA0PRA 
   8742 84 DF         [ 2]  878         anda    #0xDF
   8744 B7 18 04      [ 4]  879         staa    PIA0PRA 
   8747 39            [ 5]  880         rts
                            881 
   8748                     882 L8748:
   8748 36            [ 3]  883         psha
   8749 37            [ 3]  884         pshb
   874A 96 AC         [ 3]  885         ldaa    (0x00AC)
   874C 8A 30         [ 2]  886         oraa    #0x30
   874E 84 FD         [ 2]  887         anda    #0xFD
   8750 C5 20         [ 2]  888         bitb    #0x20
   8752 26 02         [ 3]  889         bne     L8756
   8754 8A 02         [ 2]  890         oraa    #0x02
   8756                     891 L8756:
   8756 C5 04         [ 2]  892         bitb    #0x04
   8758 26 02         [ 3]  893         bne     L875C
   875A 84 EF         [ 2]  894         anda    #0xEF
   875C                     895 L875C:
   875C C5 08         [ 2]  896         bitb    #0x08
   875E 26 02         [ 3]  897         bne     L8762
   8760 84 DF         [ 2]  898         anda    #0xDF
   8762                     899 L8762:
   8762 B7 18 06      [ 4]  900         staa    PIA0PRB 
   8765 97 AC         [ 3]  901         staa    (0x00AC)
   8767 BD 87 3A      [ 6]  902         jsr     L873A           ; clock diagnostic indicator
   876A 33            [ 4]  903         pulb
   876B F7 18 06      [ 4]  904         stab    PIA0PRB 
   876E D7 7B         [ 3]  905         stab    (0x007B)
   8770 BD 87 83      [ 6]  906         jsr     L8783
   8773 32            [ 4]  907         pula
   8774 39            [ 5]  908         rts
                            909 
   8775                     910 L8775:
   8775 B6 18 07      [ 4]  911         ldaa    PIA0CRB 
   8778 8A 38         [ 2]  912         oraa    #0x38       ; bits 3-4-5 on
   877A B7 18 07      [ 4]  913         staa    PIA0CRB 
   877D 84 F7         [ 2]  914         anda    #0xF7       ; bit 3 off
   877F B7 18 07      [ 4]  915         staa    PIA0CRB 
   8782 39            [ 5]  916         rts
                            917 
   8783                     918 L8783:
   8783 B6 18 05      [ 4]  919         ldaa    PIA0CRA 
   8786 8A 38         [ 2]  920         oraa    #0x38       ; bits 3-4-5 on
   8788 B7 18 05      [ 4]  921         staa    PIA0CRA 
   878B 84 F7         [ 2]  922         anda    #0xF7       ; bit 3 off
   878D B7 18 05      [ 4]  923         staa    PIA0CRA 
   8790 39            [ 5]  924         rts
                            925 
   8791                     926 L8791:
   8791 96 7A         [ 3]  927         ldaa    (0x007A)
   8793 84 FE         [ 2]  928         anda    #0xFE
   8795 36            [ 3]  929         psha
   8796 96 AC         [ 3]  930         ldaa    (0x00AC)
   8798 8A 04         [ 2]  931         oraa    #0x04
   879A 97 AC         [ 3]  932         staa    (0x00AC)
   879C 32            [ 4]  933         pula
   879D                     934 L879D:
   879D 97 7A         [ 3]  935         staa    (0x007A)
   879F B7 18 06      [ 4]  936         staa    PIA0PRB 
   87A2 BD 87 75      [ 6]  937         jsr     L8775
   87A5 96 AC         [ 3]  938         ldaa    (0x00AC)
   87A7 B7 18 06      [ 4]  939         staa    PIA0PRB 
   87AA BD 87 3A      [ 6]  940         jsr     L873A           ; clock diagnostic indicator
   87AD 39            [ 5]  941         rts
                            942 
   87AE 96 7A         [ 3]  943         ldaa    (0x007A)
   87B0 8A 01         [ 2]  944         oraa    #0x01
   87B2 36            [ 3]  945         psha
   87B3 96 AC         [ 3]  946         ldaa    (0x00AC)
   87B5 84 FB         [ 2]  947         anda    #0xFB
   87B7 97 AC         [ 3]  948         staa    (0x00AC)
   87B9 32            [ 4]  949         pula
   87BA 20 E1         [ 3]  950         bra     L879D
                            951 
   87BC                     952 L87BC:
   87BC CE 87 D2      [ 3]  953         ldx     #0x87D2
   87BF                     954 L87BF:
   87BF A6 00         [ 4]  955         ldaa    0,X
   87C1 81 FF         [ 2]  956         cmpa    #0xFF
   87C3 27 0C         [ 3]  957         beq     L87D1
   87C5 08            [ 3]  958         inx
   87C6 B7 18 0D      [ 4]  959         staa    SCCCTRLB
   87C9 A6 00         [ 4]  960         ldaa    0,X
   87CB 08            [ 3]  961         inx
   87CC B7 18 0D      [ 4]  962         staa    SCCCTRLB
   87CF 20 EE         [ 3]  963         bra     L87BF
   87D1                     964 L87D1:
   87D1 39            [ 5]  965         rts
                            966 
                            967 ; data table, sync data init
   87D2 09 8A               968         .byte   0x09,0x8a
   87D4 01 00               969         .byte   0x01,0x00
   87D6 0C 18               970         .byte   0x0c,0x18 
   87D8 0D 00               971         .byte   0x0d,0x00
   87DA 04 44               972         .byte   0x04,0x44
   87DC 0E 63               973         .byte   0x0e,0x63
   87DE 05 68               974         .byte   0x05,0x68
   87E0 0B 56               975         .byte   0x0b,0x56
   87E2 03 C1               976         .byte   0x03,0xc1
   87E4 0F 00               977         .byte   0x0f,0x00
   87E6 FF FF               978         .byte   0xff,0xff
                            979 
                            980 ; SCC init, aux serial
   87E8                     981 L87E8:
   87E8 CE F8 57      [ 3]  982         ldx     #0xF857
   87EB                     983 L87EB:
   87EB A6 00         [ 4]  984         ldaa    0,X
   87ED 81 FF         [ 2]  985         cmpa    #0xFF
   87EF 27 0C         [ 3]  986         beq     L87FD
   87F1 08            [ 3]  987         inx
   87F2 B7 18 0C      [ 4]  988         staa    SCCCTRLA
   87F5 A6 00         [ 4]  989         ldaa    0,X
   87F7 08            [ 3]  990         inx
   87F8 B7 18 0C      [ 4]  991         staa    SCCCTRLA
   87FB 20 EE         [ 3]  992         bra     L87EB
   87FD                     993 L87FD:
   87FD 20 16         [ 3]  994         bra     L8815
                            995 
                            996 ; data table for aux serial config
   87FF 09 8A               997         .byte   0x09,0x8a
   8801 01 10               998         .byte   0x01,0x10
   8803 0C 18               999         .byte   0x0c,0x18
   8805 0D 00              1000         .byte   0x0d,0x00
   8807 04 04              1001         .byte   0x04,0x04
   8809 0E 63              1002         .byte   0x0e,0x63
   880B 05 68              1003         .byte   0x05,0x68
   880D 0B 01              1004         .byte   0x0b,0x01
   880F 03 C1              1005         .byte   0x03,0xc1
   8811 0F 00              1006         .byte   0x0f,0x00
   8813 FF FF              1007         .byte   0xff,0xff
                           1008 
   8815                    1009 L8815:
   8815 CE 88 3E      [ 3] 1010         ldx     #0x883E
   8818 FF 01 28      [ 5] 1011         stx     (0x0128)
   881B 86 7E         [ 2] 1012         ldaa    #0x7E
   881D B7 01 27      [ 4] 1013         staa    (0x0127)
   8820 CE 88 32      [ 3] 1014         ldx     #0x8832
   8823 FF 01 01      [ 5] 1015         stx     (0x0101)
   8826 B7 01 00      [ 4] 1016         staa    (0x0100)
   8829 B6 10 2D      [ 4] 1017         ldaa    SCCR2  
   882C 8A 20         [ 2] 1018         oraa    #0x20
   882E B7 10 2D      [ 4] 1019         staa    SCCR2  
   8831 39            [ 5] 1020         rts
                           1021 
   8832 B6 10 2E      [ 4] 1022         ldaa    SCSR  
   8835 B6 10 2F      [ 4] 1023         ldaa    SCDR  
   8838 7C 00 48      [ 6] 1024         inc     (0x0048)
   883B 7E 88 62      [ 3] 1025         jmp     (0x8862)
   883E 86 01         [ 2] 1026         ldaa    #0x01
   8840 B7 18 0C      [ 4] 1027         staa    SCCCTRLA
   8843 B6 18 0C      [ 4] 1028         ldaa    SCCCTRLA
   8846 84 70         [ 2] 1029         anda    #0x70
   8848 26 1F         [ 3] 1030         bne     L8869  
   884A 86 0A         [ 2] 1031         ldaa    #0x0A
   884C B7 18 0C      [ 4] 1032         staa    SCCCTRLA
   884F B6 18 0C      [ 4] 1033         ldaa    SCCCTRLA
   8852 84 C0         [ 2] 1034         anda    #0xC0
   8854 26 22         [ 3] 1035         bne     L8878  
   8856 B6 18 0C      [ 4] 1036         ldaa    SCCCTRLA
   8859 44            [ 2] 1037         lsra
   885A 24 35         [ 3] 1038         bcc     L8891  
   885C 7C 00 48      [ 6] 1039         inc     (0x0048)
   885F B6 18 0E      [ 4] 1040         ldaa    SCCDATAA
   8862 BD F9 6F      [ 6] 1041         jsr     SERIALW      
   8865 97 4A         [ 3] 1042         staa    (0x004A)
   8867 20 2D         [ 3] 1043         bra     L8896  
   8869                    1044 L8869:
   8869 B6 18 0E      [ 4] 1045         ldaa    SCCDATAA
   886C 86 30         [ 2] 1046         ldaa    #0x30
   886E B7 18 0C      [ 4] 1047         staa    SCCCTRLA
   8871 86 07         [ 2] 1048         ldaa    #0x07
   8873 BD F9 6F      [ 6] 1049         jsr     SERIALW      
   8876 0C            [ 2] 1050         clc
   8877 3B            [12] 1051         rti
                           1052 
   8878                    1053 L8878:
   8878 86 07         [ 2] 1054         ldaa    #0x07
   887A BD F9 6F      [ 6] 1055         jsr     SERIALW      
   887D 86 0E         [ 2] 1056         ldaa    #0x0E
   887F B7 18 0C      [ 4] 1057         staa    SCCCTRLA
   8882 86 43         [ 2] 1058         ldaa    #0x43
   8884 B7 18 0C      [ 4] 1059         staa    SCCCTRLA
   8887 B6 18 0E      [ 4] 1060         ldaa    SCCDATAA
   888A 86 07         [ 2] 1061         ldaa    #0x07
   888C BD F9 6F      [ 6] 1062         jsr     SERIALW      
   888F 0D            [ 2] 1063         sec
   8890 3B            [12] 1064         rti
                           1065 
   8891                    1066 L8891:
   8891 B6 18 0E      [ 4] 1067         ldaa    SCCDATAA
   8894 0C            [ 2] 1068         clc
   8895 3B            [12] 1069         rti
                           1070 
   8896                    1071 L8896:
   8896 84 7F         [ 2] 1072         anda    #0x7F
   8898 81 24         [ 2] 1073         cmpa    #0x24
   889A 27 44         [ 3] 1074         beq     L88E0  
   889C 81 25         [ 2] 1075         cmpa    #0x25
   889E 27 40         [ 3] 1076         beq     L88E0  
   88A0 81 20         [ 2] 1077         cmpa    #0x20
   88A2 27 3A         [ 3] 1078         beq     L88DE  
   88A4 81 30         [ 2] 1079         cmpa    #0x30
   88A6 25 35         [ 3] 1080         bcs     L88DD  
   88A8 97 12         [ 3] 1081         staa    (0x0012)
   88AA 96 4D         [ 3] 1082         ldaa    (0x004D)
   88AC 81 02         [ 2] 1083         cmpa    #0x02
   88AE 25 09         [ 3] 1084         bcs     L88B9  
   88B0 7F 00 4D      [ 6] 1085         clr     (0x004D)
   88B3 96 12         [ 3] 1086         ldaa    (0x0012)
   88B5 97 49         [ 3] 1087         staa    (0x0049)
   88B7 20 24         [ 3] 1088         bra     L88DD  
   88B9                    1089 L88B9:
   88B9 7D 00 4E      [ 6] 1090         tst     (0x004E)
   88BC 27 1F         [ 3] 1091         beq     L88DD  
   88BE 86 78         [ 2] 1092         ldaa    #0x78
   88C0 97 63         [ 3] 1093         staa    (0x0063)
   88C2 97 64         [ 3] 1094         staa    (0x0064)
   88C4 96 12         [ 3] 1095         ldaa    (0x0012)
   88C6 81 40         [ 2] 1096         cmpa    #0x40
   88C8 24 07         [ 3] 1097         bcc     L88D1  
   88CA 97 4C         [ 3] 1098         staa    (0x004C)
   88CC 7F 00 4D      [ 6] 1099         clr     (0x004D)
   88CF 20 0C         [ 3] 1100         bra     L88DD  
   88D1                    1101 L88D1:
   88D1 81 60         [ 2] 1102         cmpa    #0x60
   88D3 24 08         [ 3] 1103         bcc     L88DD  
   88D5 97 4B         [ 3] 1104         staa    (0x004B)
   88D7 7F 00 4D      [ 6] 1105         clr     (0x004D)
   88DA BD 88 E5      [ 6] 1106         jsr     (0x88E5)
   88DD                    1107 L88DD:
   88DD 3B            [12] 1108         rti
                           1109 
   88DE                    1110 L88DE:
   88DE 20 FD         [ 3] 1111         bra     L88DD  
   88E0                    1112 L88E0:
   88E0 7C 00 4D      [ 6] 1113         inc     (0x004D)
   88E3 20 F9         [ 3] 1114         bra     L88DE  
   88E5 D6 4B         [ 3] 1115         ldab    (0x004B)
   88E7 96 4C         [ 3] 1116         ldaa    (0x004C)
   88E9 7D 04 5C      [ 6] 1117         tst     (0x045C)
   88EC 27 0D         [ 3] 1118         beq     L88FB  
   88EE 81 3C         [ 2] 1119         cmpa    #0x3C
   88F0 25 09         [ 3] 1120         bcs     L88FB  
   88F2 81 3F         [ 2] 1121         cmpa    #0x3F
   88F4 22 05         [ 3] 1122         bhi     L88FB  
   88F6 BD 89 93      [ 6] 1123         jsr     (0x8993)
   88F9 20 65         [ 3] 1124         bra     L8960  
   88FB                    1125 L88FB:
   88FB 1A 83 30 48   [ 5] 1126         cpd     #0x3048
   88FF 27 79         [ 3] 1127         beq     L897A  
   8901 1A 83 31 48   [ 5] 1128         cpd     #0x3148
   8905 27 5A         [ 3] 1129         beq     L8961  
   8907 1A 83 34 4D   [ 5] 1130         cpd     #0x344D
   890B 27 6D         [ 3] 1131         beq     L897A  
   890D 1A 83 35 4D   [ 5] 1132         cpd     #0x354D
   8911 27 4E         [ 3] 1133         beq     L8961  
   8913 1A 83 36 4D   [ 5] 1134         cpd     #0x364D
   8917 27 61         [ 3] 1135         beq     L897A  
   8919 1A 83 37 4D   [ 5] 1136         cpd     #0x374D
   891D 27 42         [ 3] 1137         beq     L8961  
   891F CE 10 80      [ 3] 1138         ldx     #0x1080
   8922 D6 4C         [ 3] 1139         ldab    (0x004C)
   8924 C0 30         [ 2] 1140         subb    #0x30
   8926 54            [ 2] 1141         lsrb
   8927 58            [ 2] 1142         aslb
   8928 58            [ 2] 1143         aslb
   8929 3A            [ 3] 1144         abx
   892A D6 4B         [ 3] 1145         ldab    (0x004B)
   892C C1 50         [ 2] 1146         cmpb    #0x50
   892E 24 30         [ 3] 1147         bcc     L8960  
   8930 C1 47         [ 2] 1148         cmpb    #0x47
   8932 23 02         [ 3] 1149         bls     L8936  
   8934 08            [ 3] 1150         inx
   8935 08            [ 3] 1151         inx
   8936                    1152 L8936:
   8936 C0 40         [ 2] 1153         subb    #0x40
   8938 C4 07         [ 2] 1154         andb    #0x07
   893A 4F            [ 2] 1155         clra
   893B 0D            [ 2] 1156         sec
   893C 49            [ 2] 1157         rola
   893D 5D            [ 2] 1158         tstb
   893E 27 04         [ 3] 1159         beq     L8944  
   8940                    1160 L8940:
   8940 49            [ 2] 1161         rola
   8941 5A            [ 2] 1162         decb
   8942 26 FC         [ 3] 1163         bne     L8940  
   8944                    1164 L8944:
   8944 97 50         [ 3] 1165         staa    (0x0050)
   8946 96 4C         [ 3] 1166         ldaa    (0x004C)
   8948 84 01         [ 2] 1167         anda    #0x01
   894A 27 08         [ 3] 1168         beq     L8954  
   894C A6 00         [ 4] 1169         ldaa    0,X
   894E 9A 50         [ 3] 1170         oraa    (0x0050)
   8950 A7 00         [ 4] 1171         staa    0,X
   8952 20 0C         [ 3] 1172         bra     L8960  
   8954                    1173 L8954:
   8954 96 50         [ 3] 1174         ldaa    (0x0050)
   8956 88 FF         [ 2] 1175         eora    #0xFF
   8958 97 50         [ 3] 1176         staa    (0x0050)
   895A A6 00         [ 4] 1177         ldaa    0,X
   895C 94 50         [ 3] 1178         anda    (0x0050)
   895E A7 00         [ 4] 1179         staa    0,X
   8960                    1180 L8960:
   8960 39            [ 5] 1181         rts
                           1182 
   8961                    1183 L8961:
   8961 B6 10 82      [ 4] 1184         ldaa    (0x1082)
   8964 8A 01         [ 2] 1185         oraa    #0x01
   8966 B7 10 82      [ 4] 1186         staa    (0x1082)
   8969 B6 10 8A      [ 4] 1187         ldaa    (0x108A)
   896C 8A 20         [ 2] 1188         oraa    #0x20
   896E B7 10 8A      [ 4] 1189         staa    (0x108A)
   8971 B6 10 8E      [ 4] 1190         ldaa    (0x108E)
   8974 8A 20         [ 2] 1191         oraa    #0x20
   8976 B7 10 8E      [ 4] 1192         staa    (0x108E)
   8979 39            [ 5] 1193         rts
                           1194 
   897A                    1195 L897A:
   897A B6 10 82      [ 4] 1196         ldaa    (0x1082)
   897D 84 FE         [ 2] 1197         anda    #0xFE
   897F B7 10 82      [ 4] 1198         staa    (0x1082)
   8982 B6 10 8A      [ 4] 1199         ldaa    (0x108A)
   8985 84 DF         [ 2] 1200         anda    #0xDF
   8987 B7 10 8A      [ 4] 1201         staa    (0x108A)
   898A B6 10 8E      [ 4] 1202         ldaa    (0x108E)
   898D 84 DF         [ 2] 1203         anda    #0xDF
   898F B7 10 8E      [ 4] 1204         staa    (0x108E)
   8992 39            [ 5] 1205         rts
                           1206 
   8993 3C            [ 4] 1207         pshx
   8994 81 3D         [ 2] 1208         cmpa    #0x3D
   8996 22 05         [ 3] 1209         bhi     L899D  
   8998 CE F7 80      [ 3] 1210         ldx     #0xF780         ; table at the end
   899B 20 03         [ 3] 1211         bra     L89A0  
   899D                    1212 L899D:
   899D CE F7 A0      [ 3] 1213         ldx     #0xF7A0         ; table at the end
   89A0                    1214 L89A0:
   89A0 C0 40         [ 2] 1215         subb    #0x40
   89A2 58            [ 2] 1216         aslb
   89A3 3A            [ 3] 1217         abx
   89A4 81 3C         [ 2] 1218         cmpa    #0x3C
   89A6 27 34         [ 3] 1219         beq     L89DC  
   89A8 81 3D         [ 2] 1220         cmpa    #0x3D
   89AA 27 0A         [ 3] 1221         beq     L89B6  
   89AC 81 3E         [ 2] 1222         cmpa    #0x3E
   89AE 27 4B         [ 3] 1223         beq     L89FB  
   89B0 81 3F         [ 2] 1224         cmpa    #0x3F
   89B2 27 15         [ 3] 1225         beq     L89C9  
   89B4 38            [ 5] 1226         pulx
   89B5 39            [ 5] 1227         rts
                           1228 
   89B6                    1229 L89B6:
   89B6 B6 10 98      [ 4] 1230         ldaa    (0x1098)
   89B9 AA 00         [ 4] 1231         oraa    0,X
   89BB B7 10 98      [ 4] 1232         staa    (0x1098)
   89BE 08            [ 3] 1233         inx
   89BF B6 10 9A      [ 4] 1234         ldaa    (0x109A)
   89C2 AA 00         [ 4] 1235         oraa    0,X
   89C4 B7 10 9A      [ 4] 1236         staa    (0x109A)
   89C7 38            [ 5] 1237         pulx
   89C8 39            [ 5] 1238         rts
                           1239 
   89C9                    1240 L89C9:
   89C9 B6 10 9C      [ 4] 1241         ldaa    (0x109C)
   89CC AA 00         [ 4] 1242         oraa    0,X
   89CE B7 10 9C      [ 4] 1243         staa    (0x109C)
   89D1 08            [ 3] 1244         inx
   89D2 B6 10 9E      [ 4] 1245         ldaa    (0x109E)
   89D5 AA 00         [ 4] 1246         oraa    0,X
   89D7 B7 10 9E      [ 4] 1247         staa    (0x109E)
   89DA 38            [ 5] 1248         pulx
   89DB 39            [ 5] 1249         rts
                           1250 
   89DC                    1251 L89DC:
   89DC E6 00         [ 4] 1252         ldab    0,X
   89DE C8 FF         [ 2] 1253         eorb    #0xFF
   89E0 D7 12         [ 3] 1254         stab    (0x0012)
   89E2 B6 10 98      [ 4] 1255         ldaa    (0x1098)
   89E5 94 12         [ 3] 1256         anda    (0x0012)
   89E7 B7 10 98      [ 4] 1257         staa    (0x1098)
   89EA 08            [ 3] 1258         inx
   89EB E6 00         [ 4] 1259         ldab    0,X
   89ED C8 FF         [ 2] 1260         eorb    #0xFF
   89EF D7 12         [ 3] 1261         stab    (0x0012)
   89F1 B6 10 9A      [ 4] 1262         ldaa    (0x109A)
   89F4 94 12         [ 3] 1263         anda    (0x0012)
   89F6 B7 10 9A      [ 4] 1264         staa    (0x109A)
   89F9 38            [ 5] 1265         pulx
   89FA 39            [ 5] 1266         rts
                           1267 
   89FB                    1268 L89FB:
   89FB E6 00         [ 4] 1269         ldab    0,X
   89FD C8 FF         [ 2] 1270         eorb    #0xFF
   89FF D7 12         [ 3] 1271         stab    (0x0012)
   8A01 B6 10 9C      [ 4] 1272         ldaa    (0x109C)
   8A04 94 12         [ 3] 1273         anda    (0x0012)
   8A06 B7 10 9C      [ 4] 1274         staa    (0x109C)
   8A09 08            [ 3] 1275         inx
   8A0A E6 00         [ 4] 1276         ldab    0,X
   8A0C C8 FF         [ 2] 1277         eorb    #0xFF
   8A0E D7 12         [ 3] 1278         stab    (0x0012)
   8A10 B6 10 9E      [ 4] 1279         ldaa    (0x109E)
   8A13 94 12         [ 3] 1280         anda    (0x0012)
   8A15 B7 10 9E      [ 4] 1281         staa    (0x109E)
   8A18 38            [ 5] 1282         pulx
   8A19 39            [ 5] 1283         rts
                           1284 
   8A1A                    1285 L8A1A:
                           1286 ; Read from table location in X
   8A1A 3C            [ 4] 1287         pshx
   8A1B                    1288 L8A1B:
   8A1B 86 04         [ 2] 1289         ldaa    #0x04
   8A1D B5 18 0D      [ 4] 1290         bita    SCCCTRLB
   8A20 27 F9         [ 3] 1291         beq     L8A1B  
   8A22 A6 00         [ 4] 1292         ldaa    0,X     
   8A24 26 03         [ 3] 1293         bne     L8A29       ; is it a nul?
   8A26 7E 8B 21      [ 3] 1294         jmp     (0x8B21)    ; if so jump to exit
   8A29                    1295 L8A29:
   8A29 08            [ 3] 1296         inx
   8A2A 81 5E         [ 2] 1297         cmpa    #0x5E       ; is is a caret? '^'
   8A2C 26 1D         [ 3] 1298         bne     L8A4B       ; no, jump ahead
   8A2E A6 00         [ 4] 1299         ldaa    0,X         ; yes, get the next char
   8A30 08            [ 3] 1300         inx
   8A31 B7 05 92      [ 4] 1301         staa    (0x0592)    
   8A34 A6 00         [ 4] 1302         ldaa    0,X     
   8A36 08            [ 3] 1303         inx
   8A37 B7 05 93      [ 4] 1304         staa    (0x0593)
   8A3A A6 00         [ 4] 1305         ldaa    0,X     
   8A3C 08            [ 3] 1306         inx
   8A3D B7 05 95      [ 4] 1307         staa    (0x0595)
   8A40 A6 00         [ 4] 1308         ldaa    0,X     
   8A42 08            [ 3] 1309         inx
   8A43 B7 05 96      [ 4] 1310         staa    (0x0596)
   8A46 BD 8B 23      [ 6] 1311         jsr     (0x8B23)
   8A49 20 D0         [ 3] 1312         bra     L8A1B  
                           1313 
   8A4B                    1314 L8A4B:
   8A4B 81 40         [ 2] 1315         cmpa    #0x40
   8A4D 26 3B         [ 3] 1316         bne     L8A8A  
   8A4F 1A EE 00      [ 6] 1317         ldy     0,X     
   8A52 08            [ 3] 1318         inx
   8A53 08            [ 3] 1319         inx
   8A54 86 30         [ 2] 1320         ldaa    #0x30
   8A56 97 B1         [ 3] 1321         staa    (0x00B1)
   8A58 18 A6 00      [ 5] 1322         ldaa    0,Y     
   8A5B                    1323 L8A5B:
   8A5B 81 64         [ 2] 1324         cmpa    #0x64
   8A5D 25 07         [ 3] 1325         bcs     L8A66  
   8A5F 7C 00 B1      [ 6] 1326         inc     (0x00B1)
   8A62 80 64         [ 2] 1327         suba    #0x64
   8A64 20 F5         [ 3] 1328         bra     L8A5B  
   8A66                    1329 L8A66:
   8A66 36            [ 3] 1330         psha
   8A67 96 B1         [ 3] 1331         ldaa    (0x00B1)
   8A69 BD 8B 3B      [ 6] 1332         jsr     (0x8B3B)
   8A6C 86 30         [ 2] 1333         ldaa    #0x30
   8A6E 97 B1         [ 3] 1334         staa    (0x00B1)
   8A70 32            [ 4] 1335         pula
   8A71                    1336 L8A71:
   8A71 81 0A         [ 2] 1337         cmpa    #0x0A
   8A73 25 07         [ 3] 1338         bcs     L8A7C  
   8A75 7C 00 B1      [ 6] 1339         inc     (0x00B1)
   8A78 80 0A         [ 2] 1340         suba    #0x0A
   8A7A 20 F5         [ 3] 1341         bra     L8A71  
   8A7C                    1342 L8A7C:
   8A7C 36            [ 3] 1343         psha
   8A7D 96 B1         [ 3] 1344         ldaa    (0x00B1)
   8A7F BD 8B 3B      [ 6] 1345         jsr     (0x8B3B)
   8A82 32            [ 4] 1346         pula
   8A83 8B 30         [ 2] 1347         adda    #0x30
   8A85 BD 8B 3B      [ 6] 1348         jsr     (0x8B3B)
   8A88 20 91         [ 3] 1349         bra     L8A1B  
   8A8A                    1350 L8A8A:
   8A8A 81 7C         [ 2] 1351         cmpa    #0x7C
   8A8C 26 59         [ 3] 1352         bne     L8AE7  
   8A8E 1A EE 00      [ 6] 1353         ldy     0,X     
   8A91 08            [ 3] 1354         inx
   8A92 08            [ 3] 1355         inx
   8A93 86 30         [ 2] 1356         ldaa    #0x30
   8A95 97 B1         [ 3] 1357         staa    (0x00B1)
   8A97 18 EC 00      [ 6] 1358         ldd     0,Y     
   8A9A                    1359 L8A9A:
   8A9A 1A 83 27 10   [ 5] 1360         cpd     #0x2710
   8A9E 25 08         [ 3] 1361         bcs     L8AA8  
   8AA0 7C 00 B1      [ 6] 1362         inc     (0x00B1)
   8AA3 83 27 10      [ 4] 1363         subd    #0x2710
   8AA6 20 F2         [ 3] 1364         bra     L8A9A  
   8AA8                    1365 L8AA8:
   8AA8 36            [ 3] 1366         psha
   8AA9 96 B1         [ 3] 1367         ldaa    (0x00B1)
   8AAB BD 8B 3B      [ 6] 1368         jsr     (0x8B3B)
   8AAE 86 30         [ 2] 1369         ldaa    #0x30
   8AB0 97 B1         [ 3] 1370         staa    (0x00B1)
   8AB2 32            [ 4] 1371         pula
   8AB3                    1372 L8AB3:
   8AB3 1A 83 03 E8   [ 5] 1373         cpd     #0x03E8
   8AB7 25 08         [ 3] 1374         bcs     L8AC1  
   8AB9 7C 00 B1      [ 6] 1375         inc     (0x00B1)
   8ABC 83 03 E8      [ 4] 1376         subd    #0x03E8
   8ABF 20 F2         [ 3] 1377         bra     L8AB3  
   8AC1                    1378 L8AC1:
   8AC1 36            [ 3] 1379         psha
   8AC2 96 B1         [ 3] 1380         ldaa    (0x00B1)
   8AC4 BD 8B 3B      [ 6] 1381         jsr     (0x8B3B)
   8AC7 86 30         [ 2] 1382         ldaa    #0x30
   8AC9 97 B1         [ 3] 1383         staa    (0x00B1)
   8ACB 32            [ 4] 1384         pula
   8ACC                    1385 L8ACC:
   8ACC 1A 83 00 64   [ 5] 1386         cpd     #0x0064
   8AD0 25 08         [ 3] 1387         bcs     L8ADA  
   8AD2 7C 00 B1      [ 6] 1388         inc     (0x00B1)
   8AD5 83 00 64      [ 4] 1389         subd    #0x0064
   8AD8 20 F2         [ 3] 1390         bra     L8ACC  
   8ADA                    1391 L8ADA:
   8ADA 96 B1         [ 3] 1392         ldaa    (0x00B1)
   8ADC BD 8B 3B      [ 6] 1393         jsr     (0x8B3B)
   8ADF 86 30         [ 2] 1394         ldaa    #0x30
   8AE1 97 B1         [ 3] 1395         staa    (0x00B1)
   8AE3 17            [ 2] 1396         tba
   8AE4 7E 8A 71      [ 3] 1397         jmp     (0x8A71)
   8AE7                    1398 L8AE7:
   8AE7 81 7E         [ 2] 1399         cmpa    #0x7E
   8AE9 26 18         [ 3] 1400         bne     L8B03  
   8AEB E6 00         [ 4] 1401         ldab    0,X     
   8AED C0 30         [ 2] 1402         subb    #0x30
   8AEF 08            [ 3] 1403         inx
   8AF0 1A EE 00      [ 6] 1404         ldy     0,X     
   8AF3 08            [ 3] 1405         inx
   8AF4 08            [ 3] 1406         inx
   8AF5                    1407 L8AF5:
   8AF5 18 A6 00      [ 5] 1408         ldaa    0,Y     
   8AF8 18 08         [ 4] 1409         iny
   8AFA BD 8B 3B      [ 6] 1410         jsr     (0x8B3B)
   8AFD 5A            [ 2] 1411         decb
   8AFE 26 F5         [ 3] 1412         bne     L8AF5  
   8B00 7E 8A 1B      [ 3] 1413         jmp     (0x8A1B)
   8B03                    1414 L8B03:
   8B03 81 25         [ 2] 1415         cmpa    #0x25
   8B05 26 14         [ 3] 1416         bne     L8B1B  
   8B07 CE 05 90      [ 3] 1417         ldx     #0x0590
   8B0A CC 1B 5B      [ 3] 1418         ldd     #0x1B5B
   8B0D ED 00         [ 5] 1419         std     0,X     
   8B0F 86 4B         [ 2] 1420         ldaa    #0x4B
   8B11 A7 02         [ 4] 1421         staa    2,X
   8B13 6F 03         [ 6] 1422         clr     3,X
   8B15 BD 8A 1A      [ 6] 1423         jsr     L8A1A  
   8B18 7E 8A 1B      [ 3] 1424         jmp     (0x8A1B)
   8B1B                    1425 L8B1B:
   8B1B B7 18 0F      [ 4] 1426         staa    SCCDATAB
   8B1E 7E 8A 1B      [ 3] 1427         jmp     (0x8A1B)
   8B21 38            [ 5] 1428         pulx
   8B22 39            [ 5] 1429         rts
                           1430 
   8B23 3C            [ 4] 1431         pshx
   8B24 CE 05 90      [ 3] 1432         ldx     #0x0590
   8B27 CC 1B 5B      [ 3] 1433         ldd     #0x1B5B
   8B2A ED 00         [ 5] 1434         std     0,X     
   8B2C 86 48         [ 2] 1435         ldaa    #0x48
   8B2E A7 07         [ 4] 1436         staa    7,X
   8B30 86 3B         [ 2] 1437         ldaa    #0x3B
   8B32 A7 04         [ 4] 1438         staa    4,X
   8B34 6F 08         [ 6] 1439         clr     8,X
   8B36 BD 8A 1A      [ 6] 1440         jsr     L8A1A  
   8B39 38            [ 5] 1441         pulx
   8B3A 39            [ 5] 1442         rts
                           1443 
   8B3B 36            [ 3] 1444         psha
   8B3C                    1445 L8B3C:
   8B3C 86 04         [ 2] 1446         ldaa    #0x04
   8B3E B5 18 0D      [ 4] 1447         bita    SCCCTRLB
   8B41 27 F9         [ 3] 1448         beq     L8B3C  
   8B43 32            [ 4] 1449         pula
   8B44 B7 18 0F      [ 4] 1450         staa    SCCDATAB
   8B47 39            [ 5] 1451         rts
                           1452 
   8B48 BD A3 2E      [ 6] 1453         jsr     (0xA32E)
                           1454 
   8B4B BD 8D E4      [ 6] 1455         jsr     LCDMSG1 
   8B4E 4C 69 67 68 74 20  1456         .ascis  'Light Diagnostic'
        44 69 61 67 6E 6F
        73 74 69 E3
                           1457 
   8B5E BD 8D DD      [ 6] 1458         jsr     LCDMSG2 
   8B61 43 75 72 74 61 69  1459         .ascis  'Curtains opening'
        6E 73 20 6F 70 65
        6E 69 6E E7
                           1460 
   8B71 C6 14         [ 2] 1461         ldab    #0x14
   8B73 BD 8C 30      [ 6] 1462         jsr     (0x8C30)
   8B76 C6 FF         [ 2] 1463         ldab    #0xFF
   8B78 F7 10 98      [ 4] 1464         stab    (0x1098)
   8B7B F7 10 9A      [ 4] 1465         stab    (0x109A)
   8B7E F7 10 9C      [ 4] 1466         stab    (0x109C)
   8B81 F7 10 9E      [ 4] 1467         stab    (0x109E)
   8B84 BD F9 C5      [ 6] 1468         jsr     BUTNLIT 
   8B87 B6 18 04      [ 4] 1469         ldaa    PIA0PRA 
   8B8A 8A 40         [ 2] 1470         oraa    #0x40
   8B8C B7 18 04      [ 4] 1471         staa    PIA0PRA 
                           1472 
   8B8F BD 8D E4      [ 6] 1473         jsr     LCDMSG1 
   8B92 20 50 72 65 73 73  1474         .ascis  ' Press ENTER to '
        20 45 4E 54 45 52
        20 74 6F A0
                           1475 
   8BA2 BD 8D DD      [ 6] 1476         jsr     LCDMSG2 
   8BA5 74 75 72 6E 20 6C  1477         .ascis  'turn lights  off'
        69 67 68 74 73 20
        20 6F 66 E6
                           1478 
   8BB5                    1479 L8BB5:
   8BB5 BD 8E 95      [ 6] 1480         jsr     (0x8E95)
   8BB8 81 0D         [ 2] 1481         cmpa    #0x0D
   8BBA 26 F9         [ 3] 1482         bne     L8BB5  
   8BBC BD A3 41      [ 6] 1483         jsr     (0xA341)
   8BBF 39            [ 5] 1484         rts
                           1485 
                           1486 ; setup IRQ handlers!
   8BC0                    1487 L8BC0:
   8BC0 86 80         [ 2] 1488         ldaa    #0x80
   8BC2 B7 10 22      [ 4] 1489         staa    TMSK1
   8BC5 CE AB CC      [ 3] 1490         ldx     #0xABCC
   8BC8 FF 01 19      [ 5] 1491         stx     (0x0119)
   8BCB CE AD 0C      [ 3] 1492         ldx     #0xAD0C
   8BCE FF 01 16      [ 5] 1493         stx     (0x0116)
   8BD1 CE AD 0C      [ 3] 1494         ldx     #0xAD0C
   8BD4 FF 01 2E      [ 5] 1495         stx     (0x012E)
   8BD7 86 7E         [ 2] 1496         ldaa    #0x7E
   8BD9 B7 01 18      [ 4] 1497         staa    (0x0118)
   8BDC B7 01 15      [ 4] 1498         staa    (0x0115)
   8BDF B7 01 2D      [ 4] 1499         staa    (0x012D)
   8BE2 4F            [ 2] 1500         clra
   8BE3 5F            [ 2] 1501         clrb
   8BE4 DD 1B         [ 4] 1502         std     CDTIMR1     ; Reset all the countdown timers
   8BE6 DD 1D         [ 4] 1503         std     CDTIMR2
   8BE8 DD 1F         [ 4] 1504         std     CDTIMR3
   8BEA DD 21         [ 4] 1505         std     CDTIMR4
   8BEC DD 23         [ 4] 1506         std     CDTIMR5
                           1507 
   8BEE                    1508 L8BEE:
   8BEE 86 C0         [ 2] 1509         ldaa    #0xC0
   8BF0 B7 10 23      [ 4] 1510         staa    TFLG1  
   8BF3 39            [ 5] 1511         rts
                           1512 
   8BF4                    1513 L8BF4:
   8BF4 B6 10 0A      [ 4] 1514         ldaa    PORTE
   8BF7 88 FF         [ 2] 1515         eora    #0xFF
   8BF9 16            [ 2] 1516         tab
   8BFA D7 62         [ 3] 1517         stab    (0x0062)
   8BFC BD F9 C5      [ 6] 1518         jsr     BUTNLIT 
   8BFF 20 F3         [ 3] 1519         bra     L8BF4  
   8C01 39            [ 5] 1520         rts
                           1521 
                           1522 ; Delay B seconds
   8C02                    1523 L8C02:
   8C02 36            [ 3] 1524         psha
   8C03 86 64         [ 2] 1525         ldaa    #0x64
   8C05 3D            [10] 1526         mul
   8C06 DD 23         [ 4] 1527         std     CDTIMR5     ; store B*100 here
   8C08                    1528 L8C08:
   8C08 BD 9B 19      [ 6] 1529         jsr     L9B19   
   8C0B DC 23         [ 4] 1530         ldd     CDTIMR5
   8C0D 26 F9         [ 3] 1531         bne     L8C08  
   8C0F 32            [ 4] 1532         pula
   8C10 39            [ 5] 1533         rts
                           1534 
   8C11 36            [ 3] 1535         psha
   8C12 86 3C         [ 2] 1536         ldaa    #0x3C
   8C14                    1537 L8C14:
   8C14 97 28         [ 3] 1538         staa    (0x0028)
   8C16 C6 01         [ 2] 1539         ldab    #0x01       ; delay 1 sec
   8C18 BD 8C 02      [ 6] 1540         jsr     L8C02       ;
   8C1B 96 28         [ 3] 1541         ldaa    (0x0028)
   8C1D 4A            [ 2] 1542         deca
   8C1E 26 F4         [ 3] 1543         bne     L8C14  
   8C20 32            [ 4] 1544         pula
   8C21 39            [ 5] 1545         rts
                           1546 
   8C22 36            [ 3] 1547         psha
   8C23 4F            [ 2] 1548         clra
   8C24 DD 23         [ 4] 1549         std     CDTIMR5
   8C26                    1550 L8C26:
   8C26 BD 9B 19      [ 6] 1551         jsr     L9B19   
   8C29 7D 00 24      [ 6] 1552         tst     CDTIMR5+1
   8C2C 26 F8         [ 3] 1553         bne     L8C26  
   8C2E 32            [ 4] 1554         pula
   8C2F 39            [ 5] 1555         rts
                           1556 
   8C30 36            [ 3] 1557         psha
   8C31 86 32         [ 2] 1558         ldaa    #0x32
   8C33 3D            [10] 1559         mul
   8C34 DD 23         [ 4] 1560         std     CDTIMR5
   8C36                    1561 L8C36:
   8C36 DC 23         [ 4] 1562         ldd     CDTIMR5
   8C38 26 FC         [ 3] 1563         bne     L8C36  
   8C3A 32            [ 4] 1564         pula
   8C3B 39            [ 5] 1565         rts
                           1566 
                           1567 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1568 ; LCD routines
                           1569 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1570 
   8C3C                    1571 L8C3C:
   8C3C 86 FF         [ 2] 1572         ldaa    #0xFF
   8C3E B7 10 01      [ 4] 1573         staa    DDRA  
   8C41 86 FF         [ 2] 1574         ldaa    #0xFF
   8C43 B7 10 03      [ 4] 1575         staa    DDRG 
   8C46 B6 10 02      [ 4] 1576         ldaa    PORTG  
   8C49 8A 02         [ 2] 1577         oraa    #0x02
   8C4B B7 10 02      [ 4] 1578         staa    PORTG  
   8C4E 86 38         [ 2] 1579         ldaa    #0x38
   8C50 BD 8C 86      [ 6] 1580         jsr     (0x8C86)     ; write byte to LCD
   8C53 86 38         [ 2] 1581         ldaa    #0x38
   8C55 BD 8C 86      [ 6] 1582         jsr     (0x8C86)     ; write byte to LCD
   8C58 86 06         [ 2] 1583         ldaa    #0x06
   8C5A BD 8C 86      [ 6] 1584         jsr     (0x8C86)     ; write byte to LCD
   8C5D 86 0E         [ 2] 1585         ldaa    #0x0E
   8C5F BD 8C 86      [ 6] 1586         jsr     (0x8C86)     ; write byte to LCD
   8C62 86 01         [ 2] 1587         ldaa    #0x01
   8C64 BD 8C 86      [ 6] 1588         jsr     (0x8C86)     ; write byte to LCD
   8C67 CE 00 FF      [ 3] 1589         ldx     #0x00FF
   8C6A                    1590 L8C6A:
   8C6A 01            [ 2] 1591         nop
   8C6B 01            [ 2] 1592         nop
   8C6C 09            [ 3] 1593         dex
   8C6D 26 FB         [ 3] 1594         bne     L8C6A  
   8C6F 39            [ 5] 1595         rts
                           1596 
                           1597 ; toggle LCD ENABLE
   8C70 B6 10 02      [ 4] 1598         ldaa    PORTG  
   8C73 84 FD         [ 2] 1599         anda    #0xFD        ; clear LCD ENABLE
   8C75 B7 10 02      [ 4] 1600         staa    PORTG  
   8C78 8A 02         [ 2] 1601         oraa    #0x02        ; set LCD ENABLE
   8C7A B7 10 02      [ 4] 1602         staa    PORTG  
   8C7D 39            [ 5] 1603         rts
                           1604 
                           1605 ; Reset LCD buffer?
   8C7E                    1606 L8C7E:
   8C7E CC 05 00      [ 3] 1607         ldd     #0x0500     ; Reset LCD queue?
   8C81 DD 46         [ 4] 1608         std     (0x0046)    ; write pointer
   8C83 DD 44         [ 4] 1609         std     (0x0044)    ; read pointer?
   8C85 39            [ 5] 1610         rts
                           1611 
                           1612 ; write byte to LCD
   8C86 BD 8C BD      [ 6] 1613         jsr     (0x8CBD)     ; wait for LCD not busy
   8C89 B7 10 00      [ 4] 1614         staa    PORTA  
   8C8C B6 10 02      [ 4] 1615         ldaa    PORTG       
   8C8F 84 F3         [ 2] 1616         anda    #0xF3        ; LCD RS and LCD RW low
   8C91                    1617 L8C91:
   8C91 B7 10 02      [ 4] 1618         staa    PORTG  
   8C94 BD 8C 70      [ 6] 1619         jsr     (0x8C70)     ; toggle LCD ENABLE
   8C97 39            [ 5] 1620         rts
                           1621 
   8C98 BD 8C BD      [ 6] 1622         jsr     (0x8CBD)     ; wait for LCD not busy
   8C9B B7 10 00      [ 4] 1623         staa    PORTA  
   8C9E B6 10 02      [ 4] 1624         ldaa    PORTG  
   8CA1 84 FB         [ 2] 1625         anda    #0xFB
   8CA3 8A 08         [ 2] 1626         oraa    #0x08
   8CA5 20 EA         [ 3] 1627         bra     L8C91  
   8CA7 BD 8C BD      [ 6] 1628         jsr     (0x8CBD)     ; wait for LCD not busy
   8CAA B6 10 02      [ 4] 1629         ldaa    PORTG  
   8CAD 84 F7         [ 2] 1630         anda    #0xF7
   8CAF 8A 08         [ 2] 1631         oraa    #0x08
   8CB1 20 DE         [ 3] 1632         bra     L8C91  
   8CB3 BD 8C BD      [ 6] 1633         jsr     (0x8CBD)     ; wait for LCD not busy
   8CB6 B6 10 02      [ 4] 1634         ldaa    PORTG  
   8CB9 8A 0C         [ 2] 1635         oraa    #0x0C
   8CBB 20 D4         [ 3] 1636         bra     L8C91  
                           1637 
                           1638 ; wait for LCD not busy (or timeout)
   8CBD 36            [ 3] 1639         psha
   8CBE 37            [ 3] 1640         pshb
   8CBF C6 FF         [ 2] 1641         ldab    #0xFF        ; init timeout counter
   8CC1                    1642 L8CC1:
   8CC1 5D            [ 2] 1643         tstb
   8CC2 27 1A         [ 3] 1644         beq     L8CDE       ; times up, exit
   8CC4 B6 10 02      [ 4] 1645         ldaa    PORTG  
   8CC7 84 F7         [ 2] 1646         anda    #0xF7        ; bit 3 low
   8CC9 8A 04         [ 2] 1647         oraa    #0x04        ; bit 3 high
   8CCB B7 10 02      [ 4] 1648         staa    PORTG        ; LCD RS high
   8CCE BD 8C 70      [ 6] 1649         jsr     (0x8C70)     ; toggle LCD ENABLE
   8CD1 7F 10 01      [ 6] 1650         clr     DDRA  
   8CD4 B6 10 00      [ 4] 1651         ldaa    PORTA       ; read busy flag from LCD
   8CD7 2B 08         [ 3] 1652         bmi     L8CE1       ; if busy, keep looping
   8CD9 86 FF         [ 2] 1653         ldaa    #0xFF
   8CDB B7 10 01      [ 4] 1654         staa    DDRA        ; port A back to outputs
   8CDE                    1655 L8CDE:
   8CDE 33            [ 4] 1656         pulb                ; and exit
   8CDF 32            [ 4] 1657         pula
   8CE0 39            [ 5] 1658         rts
   8CE1                    1659 L8CE1:
   8CE1 5A            [ 2] 1660         decb                ; decrement timer
   8CE2 86 FF         [ 2] 1661         ldaa    #0xFF
   8CE4 B7 10 01      [ 4] 1662         staa    DDRA        ; port A back to outputs
   8CE7 20 D8         [ 3] 1663         bra     L8CC1       ; loop
                           1664 
   8CE9 BD 8C BD      [ 6] 1665         jsr     (0x8CBD)     ; wait for LCD not busy
   8CEC 86 01         [ 2] 1666         ldaa    #0x01
   8CEE BD 8C 86      [ 6] 1667         jsr     (0x8C86)     ; write byte to LCD
   8CF1 39            [ 5] 1668         rts
                           1669 
   8CF2 BD 8C BD      [ 6] 1670         jsr     (0x8CBD)     ; wait for LCD not busy
   8CF5 86 80         [ 2] 1671         ldaa    #0x80
   8CF7 BD 8D 14      [ 6] 1672         jsr     (0x8D14)
   8CFA BD 8C BD      [ 6] 1673         jsr     (0x8CBD)     ; wait for LCD not busy
   8CFD 86 80         [ 2] 1674         ldaa    #0x80
   8CFF BD 8C 86      [ 6] 1675         jsr     (0x8C86)     ; write byte to LCD
   8D02 39            [ 5] 1676         rts
                           1677 
   8D03 BD 8C BD      [ 6] 1678         jsr     (0x8CBD)     ; wait for LCD not busy
   8D06 86 C0         [ 2] 1679         ldaa    #0xC0
   8D08 BD 8D 14      [ 6] 1680         jsr     (0x8D14)
   8D0B BD 8C BD      [ 6] 1681         jsr     (0x8CBD)     ; wait for LCD not busy
   8D0E 86 C0         [ 2] 1682         ldaa    #0xC0
   8D10 BD 8C 86      [ 6] 1683         jsr     (0x8C86)     ; write byte to LCD
   8D13 39            [ 5] 1684         rts
                           1685 
   8D14 BD 8C 86      [ 6] 1686         jsr     (0x8C86)     ; write byte to LCD
   8D17 86 10         [ 2] 1687         ldaa    #0x10
   8D19 97 14         [ 3] 1688         staa    (0x0014)
   8D1B                    1689 L8D1B:
   8D1B BD 8C BD      [ 6] 1690         jsr     (0x8CBD)     ; wait for LCD not busy
   8D1E 86 20         [ 2] 1691         ldaa    #0x20
   8D20 BD 8C 98      [ 6] 1692         jsr     (0x8C98)
   8D23 7A 00 14      [ 6] 1693         dec     (0x0014)
   8D26 26 F3         [ 3] 1694         bne     L8D1B  
   8D28 39            [ 5] 1695         rts
                           1696 
   8D29                    1697 L8D29:
   8D29 86 0C         [ 2] 1698         ldaa    #0x0C
   8D2B BD 8E 4B      [ 6] 1699         jsr     (0x8E4B)
   8D2E 39            [ 5] 1700         rts
                           1701 
   8D2F 86 0E         [ 2] 1702         ldaa    #0x0E
   8D31 BD 8E 4B      [ 6] 1703         jsr     (0x8E4B)
   8D34 39            [ 5] 1704         rts
                           1705 
   8D35 7F 00 4A      [ 6] 1706         clr     (0x004A)
   8D38 7F 00 43      [ 6] 1707         clr     (0x0043)
   8D3B 18 DE 46      [ 5] 1708         ldy     (0x0046)
   8D3E 86 C0         [ 2] 1709         ldaa    #0xC0
   8D40 20 0B         [ 3] 1710         bra     L8D4D  
   8D42 7F 00 4A      [ 6] 1711         clr     (0x004A)
   8D45 7F 00 43      [ 6] 1712         clr     (0x0043)
   8D48 18 DE 46      [ 5] 1713         ldy     (0x0046)
   8D4B 86 80         [ 2] 1714         ldaa    #0x80
   8D4D                    1715 L8D4D:
   8D4D 18 A7 00      [ 5] 1716         staa    0,Y     
   8D50 18 6F 01      [ 7] 1717         clr     1,Y     
   8D53 18 08         [ 4] 1718         iny
   8D55 18 08         [ 4] 1719         iny
   8D57 18 8C 05 80   [ 5] 1720         cpy     #0x0580
   8D5B 25 04         [ 3] 1721         bcs     L8D61  
   8D5D 18 CE 05 00   [ 4] 1722         ldy     #0x0500
   8D61                    1723 L8D61:
   8D61 C6 0F         [ 2] 1724         ldab    #0x0F
   8D63                    1725 L8D63:
   8D63 96 4A         [ 3] 1726         ldaa    (0x004A)
   8D65 27 FC         [ 3] 1727         beq     L8D63  
   8D67 7F 00 4A      [ 6] 1728         clr     (0x004A)
   8D6A 5A            [ 2] 1729         decb
   8D6B 27 1A         [ 3] 1730         beq     L8D87  
   8D6D 81 24         [ 2] 1731         cmpa    #0x24
   8D6F 27 16         [ 3] 1732         beq     L8D87  
   8D71 18 6F 00      [ 7] 1733         clr     0,Y     
   8D74 18 A7 01      [ 5] 1734         staa    1,Y     
   8D77 18 08         [ 4] 1735         iny
   8D79 18 08         [ 4] 1736         iny
   8D7B 18 8C 05 80   [ 5] 1737         cpy     #0x0580
   8D7F 25 04         [ 3] 1738         bcs     L8D85  
   8D81 18 CE 05 00   [ 4] 1739         ldy     #0x0500
   8D85                    1740 L8D85:
   8D85 20 DC         [ 3] 1741         bra     L8D63  
   8D87                    1742 L8D87:
   8D87 5D            [ 2] 1743         tstb
   8D88 27 19         [ 3] 1744         beq     L8DA3  
   8D8A 86 20         [ 2] 1745         ldaa    #0x20
   8D8C                    1746 L8D8C:
   8D8C 18 6F 00      [ 7] 1747         clr     0,Y     
   8D8F 18 A7 01      [ 5] 1748         staa    1,Y     
   8D92 18 08         [ 4] 1749         iny
   8D94 18 08         [ 4] 1750         iny
   8D96 18 8C 05 80   [ 5] 1751         cpy     #0x0580
   8D9A 25 04         [ 3] 1752         bcs     L8DA0  
   8D9C 18 CE 05 00   [ 4] 1753         ldy     #0x0500
   8DA0                    1754 L8DA0:
   8DA0 5A            [ 2] 1755         decb
   8DA1 26 E9         [ 3] 1756         bne     L8D8C  
   8DA3                    1757 L8DA3:
   8DA3 18 6F 00      [ 7] 1758         clr     0,Y     
   8DA6 18 6F 01      [ 7] 1759         clr     1,Y     
   8DA9 18 DF 46      [ 5] 1760         sty     (0x0046)
   8DAC 96 19         [ 3] 1761         ldaa    (0x0019)
   8DAE 97 4E         [ 3] 1762         staa    (0x004E)
   8DB0 86 01         [ 2] 1763         ldaa    #0x01
   8DB2 97 43         [ 3] 1764         staa    (0x0043)
   8DB4 39            [ 5] 1765         rts
                           1766 
                           1767 ; display ASCII in B at location
   8DB5 36            [ 3] 1768         psha
   8DB6 37            [ 3] 1769         pshb
   8DB7 C1 4F         [ 2] 1770         cmpb    #0x4F
   8DB9 22 13         [ 3] 1771         bhi     L8DCE  
   8DBB C1 28         [ 2] 1772         cmpb    #0x28
   8DBD 25 03         [ 3] 1773         bcs     L8DC2  
   8DBF 0C            [ 2] 1774         clc
   8DC0 C9 18         [ 2] 1775         adcb    #0x18
   8DC2                    1776 L8DC2:
   8DC2 0C            [ 2] 1777         clc
   8DC3 C9 80         [ 2] 1778         adcb    #0x80
   8DC5 17            [ 2] 1779         tba
   8DC6 BD 8E 4B      [ 6] 1780         jsr     (0x8E4B)     ; send lcd command
   8DC9 33            [ 4] 1781         pulb
   8DCA 32            [ 4] 1782         pula
   8DCB BD 8E 70      [ 6] 1783         jsr     (0x8E70)     ; send lcd char
   8DCE                    1784 L8DCE:
   8DCE 39            [ 5] 1785         rts
                           1786 
                           1787 ; 4 routines to write to the LCD display
                           1788 
                           1789 ; Write to the LCD 1st line - extend past the end of a normal display
   8DCF                    1790 LCDMSG1A:
   8DCF 18 DE 46      [ 5] 1791         ldy     (0x0046)     ; get buffer pointer
   8DD2 86 90         [ 2] 1792         ldaa    #0x90        ; command to set LCD RAM ptr to chr 0x10
   8DD4 20 13         [ 3] 1793         bra     L8DE9  
                           1794 
                           1795 ; Write to the LCD 2st line - extend past the end of a normal display
   8DD6                    1796 LCDMSG2A:
   8DD6 18 DE 46      [ 5] 1797         ldy     (0x0046)     ; get buffer pointer
   8DD9 86 D0         [ 2] 1798         ldaa    #0xD0        ; command to set LCD RAM ptr to chr 0x50
   8DDB 20 0C         [ 3] 1799         bra     L8DE9  
                           1800 
                           1801 ; Write to the LCD 2nd line
   8DDD                    1802 LCDMSG2:
   8DDD 18 DE 46      [ 5] 1803         ldy     (0x0046)     ; get buffer pointer
   8DE0 86 C0         [ 2] 1804         ldaa    #0xC0        ; command to set LCD RAM ptr to chr 0x40
   8DE2 20 05         [ 3] 1805         bra     L8DE9  
                           1806 
                           1807 ; Write to the LCD 1st line
   8DE4                    1808 LCDMSG1:
   8DE4 18 DE 46      [ 5] 1809         ldy     (0x0046)     ; get buffer pointer
   8DE7 86 80         [ 2] 1810         ldaa    #0x80        ; command to load LCD RAM ptr to chr 0x00
                           1811 
                           1812 ; Put LCD command into a buffer, 4 bytes for each entry?
   8DE9                    1813 L8DE9:
   8DE9 18 A7 00      [ 5] 1814         staa    0,Y         ; store command here
   8DEC 18 6F 01      [ 7] 1815         clr     1,Y         ; clear next byte
   8DEF 18 08         [ 4] 1816         iny
   8DF1 18 08         [ 4] 1817         iny
                           1818 
                           1819 ; Add characters at return address to LCD buffer
   8DF3 18 8C 05 80   [ 5] 1820         cpy     #0x0580       ; check for buffer overflow
   8DF7 25 04         [ 3] 1821         bcs     L8DFD  
   8DF9 18 CE 05 00   [ 4] 1822         ldy     #0x0500
   8DFD                    1823 L8DFD:
   8DFD 38            [ 5] 1824         pulx                ; get start of data
   8DFE DF 17         [ 4] 1825         stx     (0x0017)    ; save this here
   8E00                    1826 L8E00:
   8E00 A6 00         [ 4] 1827         ldaa    0,X         ; get character
   8E02 27 36         [ 3] 1828         beq     L8E3A       ; is it 00, if so jump ahead
   8E04 2B 17         [ 3] 1829         bmi     L8E1D       ; high bit set, if so jump ahead
   8E06 18 6F 00      [ 7] 1830         clr     0,Y         ; add character
   8E09 18 A7 01      [ 5] 1831         staa    1,Y     
   8E0C 08            [ 3] 1832         inx
   8E0D 18 08         [ 4] 1833         iny
   8E0F 18 08         [ 4] 1834         iny
   8E11 18 8C 05 80   [ 5] 1835         cpy     #0x0580     ; check for buffer overflow
   8E15 25 E9         [ 3] 1836         bcs     L8E00  
   8E17 18 CE 05 00   [ 4] 1837         ldy     #0x0500
   8E1B 20 E3         [ 3] 1838         bra     L8E00  
                           1839 
   8E1D                    1840 L8E1D:
   8E1D 84 7F         [ 2] 1841         anda    #0x7F
   8E1F 18 6F 00      [ 7] 1842         clr     0,Y          ; add character
   8E22 18 A7 01      [ 5] 1843         staa    1,Y     
   8E25 18 6F 02      [ 7] 1844         clr     2,Y     
   8E28 18 6F 03      [ 7] 1845         clr     3,Y     
   8E2B 08            [ 3] 1846         inx
   8E2C 18 08         [ 4] 1847         iny
   8E2E 18 08         [ 4] 1848         iny
   8E30 18 8C 05 80   [ 5] 1849         cpy     #0x0580       ; check for overflow
   8E34 25 04         [ 3] 1850         bcs     L8E3A  
   8E36 18 CE 05 00   [ 4] 1851         ldy     #0x0500
                           1852 
   8E3A                    1853 L8E3A:
   8E3A 3C            [ 4] 1854         pshx                ; put SP back
   8E3B 86 01         [ 2] 1855         ldaa    #0x01
   8E3D 97 43         [ 3] 1856         staa    (0x0043)    ; semaphore?
   8E3F DC 46         [ 4] 1857         ldd     (0x0046)
   8E41 18 6F 00      [ 7] 1858         clr     0,Y     
   8E44 18 6F 01      [ 7] 1859         clr     1,Y     
   8E47 18 DF 46      [ 5] 1860         sty     (0x0046)     ; save buffer pointer
   8E4A 39            [ 5] 1861         rts
                           1862 
                           1863 ; buffer LCD command?
   8E4B 18 DE 46      [ 5] 1864         ldy     (0x0046)
   8E4E 18 A7 00      [ 5] 1865         staa    0,Y     
   8E51 18 6F 01      [ 7] 1866         clr     1,Y     
   8E54 18 08         [ 4] 1867         iny
   8E56 18 08         [ 4] 1868         iny
   8E58 18 8C 05 80   [ 5] 1869         cpy     #0x0580
   8E5C 25 04         [ 3] 1870         bcs     L8E62  
   8E5E 18 CE 05 00   [ 4] 1871         ldy     #0x0500
   8E62                    1872 L8E62:
   8E62 18 6F 00      [ 7] 1873         clr     0,Y     
   8E65 18 6F 01      [ 7] 1874         clr     1,Y     
   8E68 86 01         [ 2] 1875         ldaa    #0x01
   8E6A 97 43         [ 3] 1876         staa    (0x0043)
   8E6C 18 DF 46      [ 5] 1877         sty     (0x0046)
   8E6F 39            [ 5] 1878         rts
                           1879 
   8E70 18 DE 46      [ 5] 1880         ldy     (0x0046)
   8E73 18 6F 00      [ 7] 1881         clr     0,Y     
   8E76 18 A7 01      [ 5] 1882         staa    1,Y     
   8E79 18 08         [ 4] 1883         iny
   8E7B 18 08         [ 4] 1884         iny
   8E7D 18 8C 05 80   [ 5] 1885         cpy     #0x0580
   8E81 25 04         [ 3] 1886         bcs     L8E87  
   8E83 18 CE 05 00   [ 4] 1887         ldy     #0x0500
   8E87                    1888 L8E87:
   8E87 18 6F 00      [ 7] 1889         clr     0,Y     
   8E8A 18 6F 01      [ 7] 1890         clr     1,Y     
   8E8D 86 01         [ 2] 1891         ldaa    #0x01
   8E8F 97 43         [ 3] 1892         staa    (0x0043)
   8E91 18 DF 46      [ 5] 1893         sty     (0x0046)
   8E94 39            [ 5] 1894         rts
                           1895 
   8E95 96 30         [ 3] 1896         ldaa    (0x0030)
   8E97 26 09         [ 3] 1897         bne     L8EA2  
   8E99 96 31         [ 3] 1898         ldaa    (0x0031)
   8E9B 26 11         [ 3] 1899         bne     L8EAE  
   8E9D 96 32         [ 3] 1900         ldaa    (0x0032)
   8E9F 26 19         [ 3] 1901         bne     L8EBA  
   8EA1 39            [ 5] 1902         rts
                           1903 
                           1904 ;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1905 
   8EA2                    1906 L8EA2:
   8EA2 7F 00 30      [ 6] 1907         clr     (0x0030)
   8EA5 7F 00 32      [ 6] 1908         clr     (0x0032)
   8EA8 7F 00 31      [ 6] 1909         clr     (0x0031)
   8EAB 86 01         [ 2] 1910         ldaa    #0x01
   8EAD 39            [ 5] 1911         rts
                           1912 
   8EAE                    1913 L8EAE:
   8EAE 7F 00 31      [ 6] 1914         clr     (0x0031)
   8EB1 7F 00 30      [ 6] 1915         clr     (0x0030)
   8EB4 7F 00 32      [ 6] 1916         clr     (0x0032)
   8EB7 86 02         [ 2] 1917         ldaa    #0x02
   8EB9 39            [ 5] 1918         rts
                           1919 
   8EBA                    1920 L8EBA:
   8EBA 7F 00 32      [ 6] 1921         clr     (0x0032)
   8EBD 7F 00 30      [ 6] 1922         clr     (0x0030)
   8EC0 7F 00 31      [ 6] 1923         clr     (0x0031)
   8EC3 86 0D         [ 2] 1924         ldaa    #0x0D
   8EC5 39            [ 5] 1925         rts
                           1926 
   8EC6 B6 18 04      [ 4] 1927         ldaa    PIA0PRA 
   8EC9 84 07         [ 2] 1928         anda    #0x07
   8ECB 97 2C         [ 3] 1929         staa    (0x002C)
   8ECD 78 00 2C      [ 6] 1930         asl     (0x002C)
   8ED0 78 00 2C      [ 6] 1931         asl     (0x002C)
   8ED3 78 00 2C      [ 6] 1932         asl     (0x002C)
   8ED6 78 00 2C      [ 6] 1933         asl     (0x002C)
   8ED9 78 00 2C      [ 6] 1934         asl     (0x002C)
   8EDC CE 00 00      [ 3] 1935         ldx     #0x0000
   8EDF                    1936 L8EDF:
   8EDF 8C 00 03      [ 4] 1937         cpx     #0x0003
   8EE2 27 24         [ 3] 1938         beq     L8F08  
   8EE4 78 00 2C      [ 6] 1939         asl     (0x002C)
   8EE7 25 12         [ 3] 1940         bcs     L8EFB  
   8EE9 A6 2D         [ 4] 1941         ldaa    0x2D,X
   8EEB 81 0F         [ 2] 1942         cmpa    #0x0F
   8EED 24 1A         [ 3] 1943         bcc     L8F09  
   8EEF 6C 2D         [ 6] 1944         inc     0x2D,X
   8EF1 A6 2D         [ 4] 1945         ldaa    0x2D,X
   8EF3 81 02         [ 2] 1946         cmpa    #0x02
   8EF5 26 02         [ 3] 1947         bne     L8EF9  
   8EF7 A7 30         [ 4] 1948         staa    0x30,X
   8EF9                    1949 L8EF9:
   8EF9 20 0A         [ 3] 1950         bra     L8F05  
   8EFB                    1951 L8EFB:
   8EFB 6F 2D         [ 6] 1952         clr     0x2D,X
   8EFD 20 06         [ 3] 1953         bra     L8F05  
   8EFF A6 2D         [ 4] 1954         ldaa    0x2D,X
   8F01 27 02         [ 3] 1955         beq     L8F05  
   8F03 6A 2D         [ 6] 1956         dec     0x2D,X
   8F05                    1957 L8F05:
   8F05 08            [ 3] 1958         inx
   8F06 20 D7         [ 3] 1959         bra     L8EDF  
   8F08                    1960 L8F08:
   8F08 39            [ 5] 1961         rts
                           1962 
   8F09                    1963 L8F09:
   8F09 8C 00 02      [ 4] 1964         cpx     #0x0002
   8F0C 27 02         [ 3] 1965         beq     L8F10  
   8F0E 6F 2D         [ 6] 1966         clr     0x2D,X
   8F10                    1967 L8F10:
   8F10 20 F3         [ 3] 1968         bra     L8F05  
   8F12 B6 10 0A      [ 4] 1969         ldaa    PORTE
   8F15 97 51         [ 3] 1970         staa    (0x0051)
   8F17 CE 00 00      [ 3] 1971         ldx     #0x0000
   8F1A                    1972 L8F1A:
   8F1A 8C 00 08      [ 4] 1973         cpx     #0x0008
   8F1D 27 22         [ 3] 1974         beq     L8F41  
   8F1F 77 00 51      [ 6] 1975         asr     (0x0051)
   8F22 25 10         [ 3] 1976         bcs     L8F34  
   8F24 A6 52         [ 4] 1977         ldaa    0x52,X
   8F26 81 0F         [ 2] 1978         cmpa    #0x0F
   8F28 6C 52         [ 6] 1979         inc     0x52,X
   8F2A A6 52         [ 4] 1980         ldaa    0x52,X
   8F2C 81 04         [ 2] 1981         cmpa    #0x04
   8F2E 26 02         [ 3] 1982         bne     L8F32  
   8F30 A7 5A         [ 4] 1983         staa    0x5A,X
   8F32                    1984 L8F32:
   8F32 20 0A         [ 3] 1985         bra     L8F3E  
   8F34                    1986 L8F34:
   8F34 6F 52         [ 6] 1987         clr     0x52,X
   8F36 20 06         [ 3] 1988         bra     L8F3E  
   8F38 A6 52         [ 4] 1989         ldaa    0x52,X
   8F3A 27 02         [ 3] 1990         beq     L8F3E  
   8F3C 6A 52         [ 6] 1991         dec     0x52,X
   8F3E                    1992 L8F3E:
   8F3E 08            [ 3] 1993         inx
   8F3F 20 D9         [ 3] 1994         bra     L8F1A  
   8F41                    1995 L8F41:
   8F41 39            [ 5] 1996         rts
                           1997 
   8F42 6F 52         [ 6] 1998         clr     0x52,X
   8F44 20 F8         [ 3] 1999         bra     L8F3E  
                           2000 
   8F46 30 2E 35           2001         .ascii      '0.5'
   8F49 31 2E 30           2002         .ascii      '1.0'
   8F4C 31 2E 35           2003         .ascii      '1.5'
   8F4F 32 2E 30           2004         .ascii      '2.0'
   8F52 32 2E 35           2005         .ascii      '2.5'
   8F55 33 2E 30           2006         .ascii      '3.0'
                           2007 
   8F58 3C            [ 4] 2008         pshx
   8F59 96 12         [ 3] 2009         ldaa    (0x0012)
   8F5B 80 01         [ 2] 2010         suba    #0x01
   8F5D C6 03         [ 2] 2011         ldab    #0x03
   8F5F 3D            [10] 2012         mul
                           2013 
   8F60 CE 8F 46      [ 3] 2014         ldx     #0x8F46
   8F63 3A            [ 3] 2015         abx
   8F64 C6 2C         [ 2] 2016         ldab    #0x2C
   8F66                    2017 L8F66:
   8F66 A6 00         [ 4] 2018         ldaa    0,X     
   8F68 08            [ 3] 2019         inx
   8F69 BD 8D B5      [ 6] 2020         jsr     (0x8DB5)         ; display char here on LCD display
   8F6C 5C            [ 2] 2021         incb
   8F6D C1 2F         [ 2] 2022         cmpb    #0x2F
   8F6F 26 F5         [ 3] 2023         bne     L8F66  
   8F71 38            [ 5] 2024         pulx
   8F72 39            [ 5] 2025         rts
                           2026 
   8F73 36            [ 3] 2027         psha
   8F74 BD 8C F2      [ 6] 2028         jsr     (0x8CF2)
   8F77 C6 02         [ 2] 2029         ldab    #0x02
   8F79 BD 8C 30      [ 6] 2030         jsr     (0x8C30)
   8F7C 32            [ 4] 2031         pula
   8F7D 97 B4         [ 3] 2032         staa    (0x00B4)
   8F7F 81 03         [ 2] 2033         cmpa    #0x03
   8F81 26 11         [ 3] 2034         bne     L8F94  
                           2035 
   8F83 BD 8D E4      [ 6] 2036         jsr     LCDMSG1 
   8F86 43 68 75 63 6B 20  2037         .ascis  'Chuck    '
        20 20 A0
                           2038 
   8F8F CE 90 72      [ 3] 2039         ldx     #0x9072
   8F92 20 4D         [ 3] 2040         bra     L8FE1  
   8F94                    2041 L8F94:
   8F94 81 04         [ 2] 2042         cmpa    #0x04
   8F96 26 11         [ 3] 2043         bne     L8FA9  
                           2044 
   8F98 BD 8D E4      [ 6] 2045         jsr     LCDMSG1 
   8F9B 4A 61 73 70 65 72  2046         .ascis  'Jasper   '
        20 20 A0
                           2047 
   8FA4 CE 90 DE      [ 3] 2048         ldx     #0x90DE
   8FA7 20 38         [ 3] 2049         bra     L8FE1  
   8FA9                    2050 L8FA9:
   8FA9 81 05         [ 2] 2051         cmpa    #0x05
   8FAB 26 11         [ 3] 2052         bne     L8FBE  
                           2053 
   8FAD BD 8D E4      [ 6] 2054         jsr     LCDMSG1 
   8FB0 50 61 73 71 75 61  2055         .ascis  'Pasqually'
        6C 6C F9
                           2056 
   8FB9 CE 91 45      [ 3] 2057         ldx     #0x9145
   8FBC 20 23         [ 3] 2058         bra     L8FE1  
   8FBE                    2059 L8FBE:
   8FBE 81 06         [ 2] 2060         cmpa    #0x06
   8FC0 26 11         [ 3] 2061         bne     L8FD3  
                           2062 
   8FC2 BD 8D E4      [ 6] 2063         jsr     LCDMSG1 
   8FC5 4D 75 6E 63 68 20  2064         .ascis  'Munch    '
        20 20 A0
                           2065 
   8FCE CE 91 BA      [ 3] 2066         ldx     #0x91BA
   8FD1 20 0E         [ 3] 2067         bra     L8FE1  
   8FD3                    2068 L8FD3:
   8FD3 BD 8D E4      [ 6] 2069         jsr     LCDMSG1 
   8FD6 48 65 6C 65 6E 20  2070         .ascis  'Helen   '
        20 A0
                           2071 
   8FDE CE 92 26      [ 3] 2072         ldx     #0x9226
   8FE1                    2073 L8FE1:
   8FE1 96 B4         [ 3] 2074         ldaa    (0x00B4)
   8FE3 80 03         [ 2] 2075         suba    #0x03
   8FE5 48            [ 2] 2076         asla
   8FE6 48            [ 2] 2077         asla
   8FE7 97 4B         [ 3] 2078         staa    (0x004B)
   8FE9 BD 95 04      [ 6] 2079         jsr     (0x9504)
   8FEC 97 4C         [ 3] 2080         staa    (0x004C)
   8FEE 81 0F         [ 2] 2081         cmpa    #0x0F
   8FF0 26 01         [ 3] 2082         bne     L8FF3  
   8FF2 39            [ 5] 2083         rts
                           2084 
   8FF3                    2085 L8FF3:
   8FF3 81 08         [ 2] 2086         cmpa    #0x08
   8FF5 23 08         [ 3] 2087         bls     L8FFF  
   8FF7 80 08         [ 2] 2088         suba    #0x08
   8FF9 D6 4B         [ 3] 2089         ldab    (0x004B)
   8FFB CB 02         [ 2] 2090         addb    #0x02
   8FFD D7 4B         [ 3] 2091         stab    (0x004B)
   8FFF                    2092 L8FFF:
   8FFF 36            [ 3] 2093         psha
   9000 18 DE 46      [ 5] 2094         ldy     (0x0046)
   9003 32            [ 4] 2095         pula
   9004 5F            [ 2] 2096         clrb
   9005 0D            [ 2] 2097         sec
   9006                    2098 L9006:
   9006 59            [ 2] 2099         rolb
   9007 4A            [ 2] 2100         deca
   9008 26 FC         [ 3] 2101         bne     L9006  
   900A D7 50         [ 3] 2102         stab    (0x0050)
   900C D6 4B         [ 3] 2103         ldab    (0x004B)
   900E CE 10 80      [ 3] 2104         ldx     #0x1080
   9011 3A            [ 3] 2105         abx
   9012 86 02         [ 2] 2106         ldaa    #0x02
   9014 97 12         [ 3] 2107         staa    (0x0012)
   9016                    2108 L9016:
   9016 A6 00         [ 4] 2109         ldaa    0,X     
   9018 98 50         [ 3] 2110         eora    (0x0050)
   901A A7 00         [ 4] 2111         staa    0,X     
   901C 6D 00         [ 6] 2112         tst     0,X     
   901E 27 16         [ 3] 2113         beq     L9036  
   9020 86 4F         [ 2] 2114         ldaa    #0x4F            ;'O'
   9022 C6 0C         [ 2] 2115         ldab    #0x0C        
   9024 BD 8D B5      [ 6] 2116         jsr     (0x8DB5)         ; display char here on LCD display
   9027 86 6E         [ 2] 2117         ldaa    #0x6E            ;'n'
   9029 C6 0D         [ 2] 2118         ldab    #0x0D
   902B BD 8D B5      [ 6] 2119         jsr     (0x8DB5)         ; display char here on LCD display
   902E CC 20 0E      [ 3] 2120         ldd     #0x200E          ;' '
   9031 BD 8D B5      [ 6] 2121         jsr     (0x8DB5)         ; display char here on LCD display
   9034 20 0E         [ 3] 2122         bra     L9044  
   9036                    2123 L9036:
   9036 86 66         [ 2] 2124         ldaa    #0x66            ;'f'
   9038 C6 0D         [ 2] 2125         ldab    #0x0D
   903A BD 8D B5      [ 6] 2126         jsr     (0x8DB5)         ; display char here on LCD display
   903D 86 66         [ 2] 2127         ldaa    #0x66            ;'f'
   903F C6 0E         [ 2] 2128         ldab    #0x0E
   9041 BD 8D B5      [ 6] 2129         jsr     (0x8DB5)         ; display char here on LCD display
   9044                    2130 L9044:
   9044 D6 12         [ 3] 2131         ldab    (0x0012)
   9046 BD 8C 30      [ 6] 2132         jsr     (0x8C30)
   9049 BD 8E 95      [ 6] 2133         jsr     (0x8E95)
   904C 81 0D         [ 2] 2134         cmpa    #0x0D
   904E 27 14         [ 3] 2135         beq     L9064  
   9050 20 C4         [ 3] 2136         bra     L9016  
   9052 81 02         [ 2] 2137         cmpa    #0x02
   9054 26 C0         [ 3] 2138         bne     L9016  
   9056 96 12         [ 3] 2139         ldaa    (0x0012)
   9058 81 06         [ 2] 2140         cmpa    #0x06
   905A 27 BA         [ 3] 2141         beq     L9016  
   905C 4C            [ 2] 2142         inca
   905D 97 12         [ 3] 2143         staa    (0x0012)
   905F BD 8F 58      [ 6] 2144         jsr     (0x8F58)
   9062 20 B2         [ 3] 2145         bra     L9016  
   9064                    2146 L9064:
   9064 A6 00         [ 4] 2147         ldaa    0,X     
   9066 9A 50         [ 3] 2148         oraa    (0x0050)
   9068 98 50         [ 3] 2149         eora    (0x0050)
   906A A7 00         [ 4] 2150         staa    0,X     
   906C 96 B4         [ 3] 2151         ldaa    (0x00B4)
   906E 7E 8F 73      [ 3] 2152         jmp     (0x8F73)
   9071 39            [ 5] 2153         rts
                           2154 
   9072 4D 6F 75 74 68 2C  2155         .ascis  'Mouth,Head left,Head right,Head up,Eyes right,Eyelids,Right hand,Eyes left,DS9,DS10,DS11,DS12,DS13,DS14,Exit'
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
   90DE 4D 6F 75 74 68 2C  2156         .ascis  'Mouth,Head left,Head right,Head up,Eyes right,Eyelids,Hands,Eyes left,DS9,DS10,DS11,DS12,DS13,DS14,Exit'
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
   9145 4D 6F 75 74 68 2D  2157         .ascis  'Mouth-Mustache,Head left,Head right,Left arm,Eyes right,Eyelids,Right arm,Eyes left,DS9,DS10,DS11,DS12,DS13,DS14,Exit'
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
   91BA 4D 6F 75 74 68 2C  2158         .ascis  'Mouth,Head left,Head right,Left arm,Eyes right,Eyelids,Right arm,Eyes left,DS9,DS10,DS11,DS12,DS13,DS14,Exit'
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
   9226 4D 6F 75 74 68 2C  2159         .ascis  'Mouth,Head left,Head right,Head up,Eyes right,Eyelids,Right hand,Eyes left,DS9,DS10,DS11,DS12,DS13,DS14,Exit'
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
                           2160         
                           2161 ; code again
   9292 BD 86 C4      [ 6] 2162         jsr     L86C4
   9295                    2163 L9295:
   9295 C6 01         [ 2] 2164         ldab    #0x01
   9297 BD 8C 30      [ 6] 2165         jsr     (0x8C30)
                           2166 
   929A BD 8D E4      [ 6] 2167         jsr     LCDMSG1 
   929D 20 20 44 69 61 67  2168         .ascis  '  Diagnostics   '
        6E 6F 73 74 69 63
        73 20 20 A0
                           2169 
   92AD BD 8D DD      [ 6] 2170         jsr     LCDMSG2 
   92B0 20 20 20 20 20 20  2171         .ascis  '                '
        20 20 20 20 20 20
        20 20 20 A0
                           2172 
   92C0 C6 01         [ 2] 2173         ldab    #0x01
   92C2 BD 8C 30      [ 6] 2174         jsr     (0x8C30)
   92C5 BD 8D 03      [ 6] 2175         jsr     (0x8D03)
   92C8 CE 93 D3      [ 3] 2176         ldx     #0x93D3
   92CB BD 95 04      [ 6] 2177         jsr     (0x9504)
   92CE 81 11         [ 2] 2178         cmpa    #0x11
   92D0 26 14         [ 3] 2179         bne     L92E6  
   92D2 BD 86 C4      [ 6] 2180         jsr     L86C4
   92D5 5F            [ 2] 2181         clrb
   92D6 D7 62         [ 3] 2182         stab    (0x0062)
   92D8 BD F9 C5      [ 6] 2183         jsr     BUTNLIT 
   92DB B6 18 04      [ 4] 2184         ldaa    PIA0PRA 
   92DE 84 BF         [ 2] 2185         anda    #0xBF
   92E0 B7 18 04      [ 4] 2186         staa    PIA0PRA 
   92E3 7E 81 D7      [ 3] 2187         jmp     (0x81D7)
   92E6                    2188 L92E6:
   92E6 81 03         [ 2] 2189         cmpa    #0x03
   92E8 25 09         [ 3] 2190         bcs     L92F3  
   92EA 81 08         [ 2] 2191         cmpa    #0x08
   92EC 24 05         [ 3] 2192         bcc     L92F3  
   92EE BD 8F 73      [ 6] 2193         jsr     (0x8F73)
   92F1 20 A2         [ 3] 2194         bra     L9295  
   92F3                    2195 L92F3:
   92F3 81 02         [ 2] 2196         cmpa    #0x02
   92F5 26 08         [ 3] 2197         bne     L92FF  
   92F7 BD 9F 1E      [ 6] 2198         jsr     (0x9F1E)
   92FA 25 99         [ 3] 2199         bcs     L9295  
   92FC 7E 96 75      [ 3] 2200         jmp     (0x9675)
   92FF                    2201 L92FF:
   92FF 81 0B         [ 2] 2202         cmpa    #0x0B
   9301 26 0D         [ 3] 2203         bne     L9310  
   9303 BD 8D 03      [ 6] 2204         jsr     (0x8D03)
   9306 BD 9E CC      [ 6] 2205         jsr     (0x9ECC)
   9309 C6 03         [ 2] 2206         ldab    #0x03
   930B BD 8C 30      [ 6] 2207         jsr     (0x8C30)
   930E 20 85         [ 3] 2208         bra     L9295  
   9310                    2209 L9310:
   9310 81 09         [ 2] 2210         cmpa    #0x09
   9312 26 0E         [ 3] 2211         bne     L9322  
   9314 BD 9F 1E      [ 6] 2212         jsr     (0x9F1E)
   9317 24 03         [ 3] 2213         bcc     L931C  
   9319 7E 92 95      [ 3] 2214         jmp     (0x9295)
   931C                    2215 L931C:
   931C BD 9E 92      [ 6] 2216         jsr     (0x9E92)     ; reset R counts
   931F 7E 92 95      [ 3] 2217         jmp     (0x9295)
   9322                    2218 L9322:
   9322 81 0A         [ 2] 2219         cmpa    #0x0A
   9324 26 0B         [ 3] 2220         bne     L9331  
   9326 BD 9F 1E      [ 6] 2221         jsr     (0x9F1E)
   9329 25 03         [ 3] 2222         bcs     L932E  
   932B BD 9E AF      [ 6] 2223         jsr     (0x9EAF)     ; reset L counts
   932E                    2224 L932E:
   932E 7E 92 95      [ 3] 2225         jmp     (0x9295)
   9331                    2226 L9331:
   9331 81 01         [ 2] 2227         cmpa    #0x01
   9333 26 03         [ 3] 2228         bne     L9338  
   9335 7E A0 E9      [ 3] 2229         jmp     (0xA0E9)
   9338                    2230 L9338:
   9338 81 08         [ 2] 2231         cmpa    #0x08
   933A 26 1F         [ 3] 2232         bne     L935B  
   933C BD 9F 1E      [ 6] 2233         jsr     (0x9F1E)
   933F 25 1A         [ 3] 2234         bcs     L935B  
                           2235 
   9341 BD 8D E4      [ 6] 2236         jsr     LCDMSG1 
   9344 52 65 73 65 74 20  2237         .ascis  'Reset System!'
        53 79 73 74 65 6D
        A1
                           2238 
   9351 7E A2 49      [ 3] 2239         jmp     (0xA249)
   9354 C6 02         [ 2] 2240         ldab    #0x02
   9356 BD 8C 30      [ 6] 2241         jsr     (0x8C30)
   9359 20 18         [ 3] 2242         bra     L9373  
   935B                    2243 L935B:
   935B 81 0C         [ 2] 2244         cmpa    #0x0C
   935D 26 14         [ 3] 2245         bne     L9373  
   935F BD 8B 48      [ 6] 2246         jsr     (0x8B48)
   9362 5F            [ 2] 2247         clrb
   9363 D7 62         [ 3] 2248         stab    (0x0062)
   9365 BD F9 C5      [ 6] 2249         jsr     BUTNLIT 
   9368 B6 18 04      [ 4] 2250         ldaa    PIA0PRA 
   936B 84 BF         [ 2] 2251         anda    #0xBF
   936D B7 18 04      [ 4] 2252         staa    PIA0PRA 
   9370 7E 92 92      [ 3] 2253         jmp     (0x9292)
   9373                    2254 L9373:
   9373 81 0D         [ 2] 2255         cmpa    #0x0D
   9375 26 2E         [ 3] 2256         bne     L93A5  
   9377 BD 8C E9      [ 6] 2257         jsr     (0x8CE9)
                           2258 
   937A BD 8D E4      [ 6] 2259         jsr     LCDMSG1 
   937D 20 20 42 75 74 74  2260         .ascis  '  Button  test'
        6F 6E 20 20 74 65
        73 F4
                           2261 
   938B BD 8D DD      [ 6] 2262         jsr     LCDMSG2 
   938E 20 20 20 50 52 4F  2263         .ascis  '   PROG exits'
        47 20 65 78 69 74
        F3
                           2264 
   939B BD A5 26      [ 6] 2265         jsr     (0xA526)
   939E 5F            [ 2] 2266         clrb
   939F BD F9 C5      [ 6] 2267         jsr     BUTNLIT 
   93A2 7E 92 95      [ 3] 2268         jmp     (0x9295)
   93A5                    2269 L93A5:
   93A5 81 0E         [ 2] 2270         cmpa    #0x0E
   93A7 26 10         [ 3] 2271         bne     L93B9  
   93A9 BD 9F 1E      [ 6] 2272         jsr     (0x9F1E)
   93AC 24 03         [ 3] 2273         bcc     L93B1  
   93AE 7E 92 95      [ 3] 2274         jmp     (0x9295)
   93B1                    2275 L93B1:
   93B1 C6 01         [ 2] 2276         ldab    #0x01
   93B3 BD 8C 30      [ 6] 2277         jsr     (0x8C30)
   93B6 7E 94 9A      [ 3] 2278         jmp     (0x949A)
   93B9                    2279 L93B9:
   93B9 81 0F         [ 2] 2280         cmpa    #0x0F
   93BB 26 06         [ 3] 2281         bne     L93C3  
   93BD BD A8 6A      [ 6] 2282         jsr     (0xA86A)
   93C0 7E 92 95      [ 3] 2283         jmp     (0x9295)
   93C3                    2284 L93C3:
   93C3 81 10         [ 2] 2285         cmpa    #0x10
   93C5 26 09         [ 3] 2286         bne     L93D0  
   93C7 BD 9F 1E      [ 6] 2287         jsr     (0x9F1E)
   93CA BD 95 BA      [ 6] 2288         jsr     (0x95BA)
   93CD 7E 92 95      [ 3] 2289         jmp     (0x9295)
                           2290 
   93D0                    2291 L93D0:
   93D0 7E 92 D2      [ 3] 2292         jmp     (0x92D2)
                           2293 
   93D3 56 43 52 20 61 64  2294         .ascis  "VCR adjust,Set Random,Chuck E. Cheese,Jasper,Pasqually,Munch,Helen,Reset System,Reset reg tape#,Reset liv tape#,View Tape #'s,All Lights On,Button test,King enable,Warm-Up,Show Type,Quit Diagnostics"
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
   9499 00                 2295         .byte   0x00
                           2296 
   949A 7D 04 2A      [ 6] 2297         tst     (0x042A)
   949D 27 27         [ 3] 2298         beq     L94C6  
                           2299 
   949F BD 8D E4      [ 6] 2300         jsr     LCDMSG1 
   94A2 4B 69 6E 67 20 69  2301         .ascis  'King is Enabled'
        73 20 45 6E 61 62
        6C 65 E4
                           2302 
   94B1 BD 8D DD      [ 6] 2303         jsr     LCDMSG2 
   94B4 45 4E 54 45 52 20  2304         .ascis  'ENTER to disable'
        74 6F 20 64 69 73
        61 62 6C E5
                           2305 
   94C4 20 25         [ 3] 2306         bra     L94EB  
                           2307 
   94C6                    2308 L94C6:
   94C6 BD 8D E4      [ 6] 2309         jsr     LCDMSG1 
   94C9 4B 69 6E 67 20 69  2310         .ascis  'King is Disabled'
        73 20 44 69 73 61
        62 6C 65 E4
                           2311 
   94D9 BD 8D DD      [ 6] 2312         jsr     LCDMSG2 
   94DC 45 4E 54 45 52 20  2313         .ascis  'ENTER to enable'
        74 6F 20 65 6E 61
        62 6C E5
                           2314 
   94EB                    2315 L94EB:
   94EB BD 8E 95      [ 6] 2316         jsr     (0x8E95)
   94EE 4D            [ 2] 2317         tsta
   94EF 27 FA         [ 3] 2318         beq     L94EB  
   94F1 81 0D         [ 2] 2319         cmpa    #0x0D
   94F3 27 02         [ 3] 2320         beq     L94F7  
   94F5 20 0A         [ 3] 2321         bra     L9501  
   94F7                    2322 L94F7:
   94F7 B6 04 2A      [ 4] 2323         ldaa    (0x042A)
   94FA 84 01         [ 2] 2324         anda    #0x01
   94FC 88 01         [ 2] 2325         eora    #0x01
   94FE B7 04 2A      [ 4] 2326         staa    (0x042A)
   9501                    2327 L9501:
   9501 7E 92 95      [ 3] 2328         jmp     (0x9295)
   9504 86 01         [ 2] 2329         ldaa    #0x01
   9506 97 A6         [ 3] 2330         staa    (0x00A6)
   9508 97 A7         [ 3] 2331         staa    (0x00A7)
   950A DF 12         [ 4] 2332         stx     (0x0012)
   950C 20 09         [ 3] 2333         bra     L9517  
   950E 86 01         [ 2] 2334         ldaa    #0x01
   9510 97 A7         [ 3] 2335         staa    (0x00A7)
   9512 7F 00 A6      [ 6] 2336         clr     (0x00A6)
   9515 DF 12         [ 4] 2337         stx     (0x0012)
   9517                    2338 L9517:
   9517 7F 00 16      [ 6] 2339         clr     (0x0016)
   951A 18 DE 46      [ 5] 2340         ldy     (0x0046)
   951D 7D 00 A6      [ 6] 2341         tst     (0x00A6)
   9520 26 07         [ 3] 2342         bne     L9529  
   9522 BD 8C F2      [ 6] 2343         jsr     (0x8CF2)
   9525 86 80         [ 2] 2344         ldaa    #0x80
   9527 20 05         [ 3] 2345         bra     L952E  
   9529                    2346 L9529:
   9529 BD 8D 03      [ 6] 2347         jsr     (0x8D03)
   952C 86 C0         [ 2] 2348         ldaa    #0xC0
   952E                    2349 L952E:
   952E 18 A7 00      [ 5] 2350         staa    0,Y     
   9531 18 6F 01      [ 7] 2351         clr     1,Y     
   9534 18 08         [ 4] 2352         iny
   9536 18 08         [ 4] 2353         iny
   9538 18 8C 05 80   [ 5] 2354         cpy     #0x0580
   953C 25 04         [ 3] 2355         bcs     L9542  
   953E 18 CE 05 00   [ 4] 2356         ldy     #0x0500
   9542                    2357 L9542:
   9542 DF 14         [ 4] 2358         stx     (0x0014)
   9544                    2359 L9544:
   9544 A6 00         [ 4] 2360         ldaa    0,X     
   9546 2A 04         [ 3] 2361         bpl     L954C  
   9548 C6 01         [ 2] 2362         ldab    #0x01
   954A D7 16         [ 3] 2363         stab    (0x0016)
   954C                    2364 L954C:
   954C 81 2C         [ 2] 2365         cmpa    #0x2C
   954E 27 1E         [ 3] 2366         beq     L956E  
   9550 18 6F 00      [ 7] 2367         clr     0,Y     
   9553 84 7F         [ 2] 2368         anda    #0x7F
   9555 18 A7 01      [ 5] 2369         staa    1,Y     
   9558 18 08         [ 4] 2370         iny
   955A 18 08         [ 4] 2371         iny
   955C 18 8C 05 80   [ 5] 2372         cpy     #0x0580
   9560 25 04         [ 3] 2373         bcs     L9566  
   9562 18 CE 05 00   [ 4] 2374         ldy     #0x0500
   9566                    2375 L9566:
   9566 7D 00 16      [ 6] 2376         tst     (0x0016)
   9569 26 03         [ 3] 2377         bne     L956E  
   956B 08            [ 3] 2378         inx
   956C 20 D6         [ 3] 2379         bra     L9544  
   956E                    2380 L956E:
   956E 08            [ 3] 2381         inx
   956F 86 01         [ 2] 2382         ldaa    #0x01
   9571 97 43         [ 3] 2383         staa    (0x0043)
   9573 18 6F 00      [ 7] 2384         clr     0,Y     
   9576 18 6F 01      [ 7] 2385         clr     1,Y     
   9579 18 DF 46      [ 5] 2386         sty     (0x0046)
   957C                    2387 L957C:
   957C BD 8E 95      [ 6] 2388         jsr     (0x8E95)
   957F 27 FB         [ 3] 2389         beq     L957C  
   9581 81 02         [ 2] 2390         cmpa    #0x02
   9583 26 0A         [ 3] 2391         bne     L958F  
   9585 7D 00 16      [ 6] 2392         tst     (0x0016)
   9588 26 05         [ 3] 2393         bne     L958F  
   958A 7C 00 A7      [ 6] 2394         inc     (0x00A7)
   958D 20 88         [ 3] 2395         bra     L9517  
   958F                    2396 L958F:
   958F 81 01         [ 2] 2397         cmpa    #0x01
   9591 26 20         [ 3] 2398         bne     L95B3  
   9593 18 DE 14      [ 5] 2399         ldy     (0x0014)
   9596 18 9C 12      [ 6] 2400         cpy     (0x0012)
   9599 23 E1         [ 3] 2401         bls     L957C  
   959B 7A 00 A7      [ 6] 2402         dec     (0x00A7)
   959E DE 14         [ 4] 2403         ldx     (0x0014)
   95A0 09            [ 3] 2404         dex
   95A1                    2405 L95A1:
   95A1 09            [ 3] 2406         dex
   95A2 9C 12         [ 5] 2407         cpx     (0x0012)
   95A4 26 03         [ 3] 2408         bne     L95A9  
   95A6 7E 95 17      [ 3] 2409         jmp     (0x9517)
   95A9                    2410 L95A9:
   95A9 A6 00         [ 4] 2411         ldaa    0,X     
   95AB 81 2C         [ 2] 2412         cmpa    #0x2C
   95AD 26 F2         [ 3] 2413         bne     L95A1  
   95AF 08            [ 3] 2414         inx
   95B0 7E 95 17      [ 3] 2415         jmp     (0x9517)
   95B3                    2416 L95B3:
   95B3 81 0D         [ 2] 2417         cmpa    #0x0D
   95B5 26 C5         [ 3] 2418         bne     L957C  
   95B7 96 A7         [ 3] 2419         ldaa    (0x00A7)
   95B9 39            [ 5] 2420         rts
                           2421 
   95BA B6 04 5C      [ 4] 2422         ldaa    (0x045C)
   95BD 27 14         [ 3] 2423         beq     L95D3  
                           2424 
   95BF BD 8D E4      [ 6] 2425         jsr     LCDMSG1 
   95C2 43 75 72 72 65 6E  2426         .ascis  'Current: CNR   '
        74 3A 20 43 4E 52
        20 20 A0
                           2427 
   95D1 20 12         [ 3] 2428         bra     L95E5  
                           2429 
   95D3                    2430 L95D3:
   95D3 BD 8D E4      [ 6] 2431         jsr     LCDMSG1 
   95D6 43 75 72 72 65 6E  2432         .ascis  'Current: R12   '
        74 3A 20 52 31 32
        20 20 A0
                           2433 
   95E5                    2434 L95E5:
   95E5 BD 8D DD      [ 6] 2435         jsr     LCDMSG2 
   95E8 3C 45 6E 74 65 72  2436         .ascis  '<Enter> to chg.'
        3E 20 74 6F 20 63
        68 67 AE
                           2437 
   95F7                    2438 L95F7:
   95F7 BD 8E 95      [ 6] 2439         jsr     (0x8E95)
   95FA 27 FB         [ 3] 2440         beq     L95F7  
   95FC 81 0D         [ 2] 2441         cmpa    #0x0D
   95FE 26 0F         [ 3] 2442         bne     L960F  
   9600 B6 04 5C      [ 4] 2443         ldaa    (0x045C)
   9603 27 05         [ 3] 2444         beq     L960A  
   9605 7F 04 5C      [ 6] 2445         clr     (0x045C)
   9608 20 05         [ 3] 2446         bra     L960F  
   960A                    2447 L960A:
   960A 86 01         [ 2] 2448         ldaa    #0x01
   960C B7 04 5C      [ 4] 2449         staa    (0x045C)
   960F                    2450 L960F:
   960F 39            [ 5] 2451         rts
                           2452 
   9610 43 68 75 63 6B 2C  2453         .ascis  "Chuck,Jasper,Pasqually,Munch,Helen,Light 1,Light 2,Light 3,Star EFX,Wink Spot,Gobo,Clear All Rnd,Exit"
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
                           2454 
                           2455 ; code again
   9675 BD 8D E4      [ 6] 2456         jsr     LCDMSG1 
   9678 52 61 6E 64 6F 6D  2457         .ascis  'Random          '
        20 20 20 20 20 20
        20 20 20 A0
                           2458 
   9688 CE 96 10      [ 3] 2459         ldx     #0x9610
   968B BD 95 04      [ 6] 2460         jsr     (0x9504)
   968E 5F            [ 2] 2461         clrb
   968F 37            [ 3] 2462         pshb
   9690 81 0D         [ 2] 2463         cmpa    #0x0D
   9692 26 03         [ 3] 2464         bne     L9697  
   9694 7E 97 5B      [ 3] 2465         jmp     (0x975B)
   9697                    2466 L9697:
   9697 81 0C         [ 2] 2467         cmpa    #0x0C
   9699 26 21         [ 3] 2468         bne     L96BC  
   969B 7F 04 01      [ 6] 2469         clr     (0x0401)
   969E 7F 04 2B      [ 6] 2470         clr     (0x042B)
                           2471 
   96A1 BD 8D E4      [ 6] 2472         jsr     LCDMSG1 
   96A4 41 6C 6C 20 52 6E  2473         .ascis  'All Rnd Cleared!'
        64 20 43 6C 65 61
        72 65 64 A1
                           2474 
   96B4 C6 64         [ 2] 2475         ldab    #0x64
   96B6 BD 8C 22      [ 6] 2476         jsr     (0x8C22)
   96B9 7E 97 5B      [ 3] 2477         jmp     (0x975B)
   96BC                    2478 L96BC:
   96BC 81 09         [ 2] 2479         cmpa    #0x09
   96BE 25 05         [ 3] 2480         bcs     L96C5  
   96C0 80 08         [ 2] 2481         suba    #0x08
   96C2 33            [ 4] 2482         pulb
   96C3 5C            [ 2] 2483         incb
   96C4 37            [ 3] 2484         pshb
   96C5                    2485 L96C5:
   96C5 5F            [ 2] 2486         clrb
   96C6 0D            [ 2] 2487         sec
   96C7                    2488 L96C7:
   96C7 59            [ 2] 2489         rolb
   96C8 4A            [ 2] 2490         deca
   96C9 26 FC         [ 3] 2491         bne     L96C7  
   96CB D7 12         [ 3] 2492         stab    (0x0012)
   96CD C8 FF         [ 2] 2493         eorb    #0xFF
   96CF D7 13         [ 3] 2494         stab    (0x0013)
   96D1                    2495 L96D1:
   96D1 CC 20 34      [ 3] 2496         ldd     #0x2034           ;' '
   96D4 BD 8D B5      [ 6] 2497         jsr     (0x8DB5)         ; display char here on LCD display
   96D7 33            [ 4] 2498         pulb
   96D8 37            [ 3] 2499         pshb
   96D9 5D            [ 2] 2500         tstb
   96DA 27 05         [ 3] 2501         beq     L96E1  
   96DC B6 04 2B      [ 4] 2502         ldaa    (0x042B)
   96DF 20 03         [ 3] 2503         bra     L96E4  
   96E1                    2504 L96E1:
   96E1 B6 04 01      [ 4] 2505         ldaa    (0x0401)
   96E4                    2506 L96E4:
   96E4 94 12         [ 3] 2507         anda    (0x0012)
   96E6 27 0A         [ 3] 2508         beq     L96F2  
   96E8 18 DE 46      [ 5] 2509         ldy     (0x0046)
   96EB BD 8D FD      [ 6] 2510         jsr     (0x8DFD)
   96EE 4F            [ 2] 2511         clra
   96EF EE 20         [ 5] 2512         ldx     0x20,X
   96F1 09            [ 3] 2513         dex
   96F2                    2514 L96F2:
   96F2 18 DE 46      [ 5] 2515         ldy     (0x0046)
   96F5 BD 8D FD      [ 6] 2516         jsr     (0x8DFD)
   96F8 4F            [ 2] 2517         clra
   96F9 66 E6         [ 6] 2518         ror     0xE6,X
   96FB CC 20 34      [ 3] 2519         ldd     #0x2034           ;' '
   96FE BD 8D B5      [ 6] 2520         jsr     (0x8DB5)         ; display char here on LCD display
   9701                    2521 L9701:
   9701 BD 8E 95      [ 6] 2522         jsr     (0x8E95)
   9704 27 FB         [ 3] 2523         beq     L9701  
   9706 81 01         [ 2] 2524         cmpa    #0x01
   9708 26 22         [ 3] 2525         bne     L972C  
   970A 33            [ 4] 2526         pulb
   970B 37            [ 3] 2527         pshb
   970C 5D            [ 2] 2528         tstb
   970D 27 0A         [ 3] 2529         beq     L9719  
   970F B6 04 2B      [ 4] 2530         ldaa    (0x042B)
   9712 9A 12         [ 3] 2531         oraa    (0x0012)
   9714 B7 04 2B      [ 4] 2532         staa    (0x042B)
   9717 20 08         [ 3] 2533         bra     L9721  
   9719                    2534 L9719:
   9719 B6 04 01      [ 4] 2535         ldaa    (0x0401)
   971C 9A 12         [ 3] 2536         oraa    (0x0012)
   971E B7 04 01      [ 4] 2537         staa    (0x0401)
   9721                    2538 L9721:
   9721 18 DE 46      [ 5] 2539         ldy     (0x0046)
   9724 BD 8D FD      [ 6] 2540         jsr     (0x8DFD)
   9727 4F            [ 2] 2541         clra
   9728 6E A0         [ 3] 2542         jmp     0xA0,X
   972A 20 A5         [ 3] 2543         bra     L96D1  
   972C                    2544 L972C:
   972C 81 02         [ 2] 2545         cmpa    #0x02
   972E 26 23         [ 3] 2546         bne     L9753  
   9730 33            [ 4] 2547         pulb
   9731 37            [ 3] 2548         pshb
   9732 5D            [ 2] 2549         tstb
   9733 27 0A         [ 3] 2550         beq     L973F  
   9735 B6 04 2B      [ 4] 2551         ldaa    (0x042B)
   9738 94 13         [ 3] 2552         anda    (0x0013)
   973A B7 04 2B      [ 4] 2553         staa    (0x042B)
   973D 20 08         [ 3] 2554         bra     L9747  
   973F                    2555 L973F:
   973F B6 04 01      [ 4] 2556         ldaa    (0x0401)
   9742 94 13         [ 3] 2557         anda    (0x0013)
   9744 B7 04 01      [ 4] 2558         staa    (0x0401)
   9747                    2559 L9747:
   9747 18 DE 46      [ 5] 2560         ldy     (0x0046)
   974A BD 8D FD      [ 6] 2561         jsr     (0x8DFD)
   974D 4F            [ 2] 2562         clra
   974E 66 E6         [ 6] 2563         ror     0xE6,X
   9750 7E 96 D1      [ 3] 2564         jmp     (0x96D1)
   9753                    2565 L9753:
   9753 81 0D         [ 2] 2566         cmpa    #0x0D
   9755 26 AA         [ 3] 2567         bne     L9701  
   9757 33            [ 4] 2568         pulb
   9758 7E 96 75      [ 3] 2569         jmp     (0x9675)
   975B 33            [ 4] 2570         pulb
   975C 7E 92 92      [ 3] 2571         jmp     (0x9292)
                           2572 
                           2573 ; do program rom checksum, and display it on the LCD screen
   975F CE 00 00      [ 3] 2574         ldx     #0x0000
   9762 18 CE 80 00   [ 4] 2575         ldy     #0x8000
   9766                    2576 L9766:
   9766 18 E6 00      [ 5] 2577         ldab    0,Y     
   9769 18 08         [ 4] 2578         iny
   976B 3A            [ 3] 2579         abx
   976C 18 8C 00 00   [ 5] 2580         cpy     #0x0000
   9770 26 F4         [ 3] 2581         bne     L9766  
   9772 DF 17         [ 4] 2582         stx     (0x0017)         ; store rom checksum here
   9774 96 17         [ 3] 2583         ldaa    (0x0017)        ; get high byte of checksum
   9776 BD 97 9B      [ 6] 2584         jsr     (0x979B)         ; convert it to 2 hex chars
   9779 96 12         [ 3] 2585         ldaa    (0x0012)
   977B C6 33         [ 2] 2586         ldab    #0x33
   977D BD 8D B5      [ 6] 2587         jsr     (0x8DB5)         ; display char 1 here on LCD display
   9780 96 13         [ 3] 2588         ldaa    (0x0013)
   9782 C6 34         [ 2] 2589         ldab    #0x34
   9784 BD 8D B5      [ 6] 2590         jsr     (0x8DB5)         ; display char 2 here on LCD display
   9787 96 18         [ 3] 2591         ldaa    (0x0018)        ; get low byte of checksum
   9789 BD 97 9B      [ 6] 2592         jsr     (0x979B)         ; convert it to 2 hex chars
   978C 96 12         [ 3] 2593         ldaa    (0x0012)
   978E C6 35         [ 2] 2594         ldab    #0x35
   9790 BD 8D B5      [ 6] 2595         jsr     (0x8DB5)         ; display char 1 here on LCD display
   9793 96 13         [ 3] 2596         ldaa    (0x0013)
   9795 C6 36         [ 2] 2597         ldab    #0x36
   9797 BD 8D B5      [ 6] 2598         jsr     (0x8DB5)         ; display char 2 here on LCD display
   979A 39            [ 5] 2599         rts
                           2600 
                           2601 ; convert A to ASCII hex digit, store in (0x0012:0x0013)
   979B 36            [ 3] 2602         psha
   979C 84 0F         [ 2] 2603         anda    #0x0F
   979E 8B 30         [ 2] 2604         adda    #0x30
   97A0 81 39         [ 2] 2605         cmpa    #0x39
   97A2 23 02         [ 3] 2606         bls     L97A6  
   97A4 8B 07         [ 2] 2607         adda    #0x07
   97A6                    2608 L97A6:
   97A6 97 13         [ 3] 2609         staa    (0x0013)
   97A8 32            [ 4] 2610         pula
   97A9 84 F0         [ 2] 2611         anda    #0xF0
   97AB 44            [ 2] 2612         lsra
   97AC 44            [ 2] 2613         lsra
   97AD 44            [ 2] 2614         lsra
   97AE 44            [ 2] 2615         lsra
   97AF 8B 30         [ 2] 2616         adda    #0x30
   97B1 81 39         [ 2] 2617         cmpa    #0x39
   97B3 23 02         [ 3] 2618         bls     L97B7  
   97B5 8B 07         [ 2] 2619         adda    #0x07
   97B7                    2620 L97B7:
   97B7 97 12         [ 3] 2621         staa    (0x0012)
   97B9 39            [ 5] 2622         rts
                           2623 
   97BA BD 9D 18      [ 6] 2624         jsr     (0x9D18)
   97BD 24 03         [ 3] 2625         bcc     L97C2  
   97BF 7E 9A 7F      [ 3] 2626         jmp     (0x9A7F)
   97C2                    2627 L97C2:
   97C2 7D 00 79      [ 6] 2628         tst     (0x0079)
   97C5 26 0B         [ 3] 2629         bne     L97D2  
   97C7 FC 04 10      [ 5] 2630         ldd     (0x0410)
   97CA C3 00 01      [ 4] 2631         addd    #0x0001
   97CD FD 04 10      [ 5] 2632         std     (0x0410)
   97D0 20 09         [ 3] 2633         bra     L97DB  
   97D2                    2634 L97D2:
   97D2 FC 04 12      [ 5] 2635         ldd     (0x0412)
   97D5 C3 00 01      [ 4] 2636         addd    #0x0001
   97D8 FD 04 12      [ 5] 2637         std     (0x0412)
   97DB                    2638 L97DB:
   97DB 86 78         [ 2] 2639         ldaa    #0x78
   97DD 97 63         [ 3] 2640         staa    (0x0063)
   97DF 97 64         [ 3] 2641         staa    (0x0064)
   97E1 BD A3 13      [ 6] 2642         jsr     (0xA313)
   97E4 BD AA DB      [ 6] 2643         jsr     (0xAADB)
   97E7 86 01         [ 2] 2644         ldaa    #0x01
   97E9 97 4E         [ 3] 2645         staa    (0x004E)
   97EB 97 76         [ 3] 2646         staa    (0x0076)
   97ED 7F 00 75      [ 6] 2647         clr     (0x0075)
   97F0 7F 00 77      [ 6] 2648         clr     (0x0077)
   97F3 BD 87 AE      [ 6] 2649         jsr     (0x87AE)
   97F6 D6 7B         [ 3] 2650         ldab    (0x007B)
   97F8 CA 20         [ 2] 2651         orab    #0x20
   97FA C4 F7         [ 2] 2652         andb    #0xF7
   97FC BD 87 48      [ 6] 2653         jsr     L8748   
   97FF 7E 85 A4      [ 3] 2654         jmp     (0x85A4)
   9802 7F 00 76      [ 6] 2655         clr     (0x0076)
   9805 7F 00 75      [ 6] 2656         clr     (0x0075)
   9808 7F 00 77      [ 6] 2657         clr     (0x0077)
   980B 7F 00 4E      [ 6] 2658         clr     (0x004E)
   980E D6 7B         [ 3] 2659         ldab    (0x007B)
   9810 CA 0C         [ 2] 2660         orab    #0x0C
   9812 BD 87 48      [ 6] 2661         jsr     L8748   
   9815 BD A3 1E      [ 6] 2662         jsr     (0xA31E)
   9818 BD 86 C4      [ 6] 2663         jsr     L86C4
   981B BD 9C 51      [ 6] 2664         jsr     (0x9C51)
   981E BD 8E 95      [ 6] 2665         jsr     (0x8E95)
   9821 7E 84 4D      [ 3] 2666         jmp     (0x844D)
   9824 BD 9C 51      [ 6] 2667         jsr     (0x9C51)
   9827 7F 00 4E      [ 6] 2668         clr     (0x004E)
   982A D6 7B         [ 3] 2669         ldab    (0x007B)
   982C CA 24         [ 2] 2670         orab    #0x24
   982E C4 F7         [ 2] 2671         andb    #0xF7
   9830 BD 87 48      [ 6] 2672         jsr     L8748   
   9833 BD 87 AE      [ 6] 2673         jsr     (0x87AE)
   9836 BD 8E 95      [ 6] 2674         jsr     (0x8E95)
   9839 7E 84 4D      [ 3] 2675         jmp     (0x844D)
   983C 7F 00 78      [ 6] 2676         clr     (0x0078)
   983F B6 10 8A      [ 4] 2677         ldaa    (0x108A)
   9842 84 F9         [ 2] 2678         anda    #0xF9
   9844 B7 10 8A      [ 4] 2679         staa    (0x108A)
   9847 7D 00 AF      [ 6] 2680         tst     (0x00AF)
   984A 26 61         [ 3] 2681         bne     L98AD  
   984C 96 62         [ 3] 2682         ldaa    (0x0062)
   984E 84 01         [ 2] 2683         anda    #0x01
   9850 27 5B         [ 3] 2684         beq     L98AD  
   9852 C6 FD         [ 2] 2685         ldab    #0xFD
   9854 BD 86 E7      [ 6] 2686         jsr     (0x86E7)
   9857 CC 00 32      [ 3] 2687         ldd     #0x0032
   985A DD 1B         [ 4] 2688         std     CDTIMR1
   985C CC 75 30      [ 3] 2689         ldd     #0x7530
   985F DD 1D         [ 4] 2690         std     CDTIMR2
   9861 7F 00 5A      [ 6] 2691         clr     (0x005A)
   9864                    2692 L9864:
   9864 BD 9B 19      [ 6] 2693         jsr     L9B19   
   9867 7D 00 31      [ 6] 2694         tst     (0x0031)
   986A 26 04         [ 3] 2695         bne     L9870  
   986C 96 5A         [ 3] 2696         ldaa    (0x005A)
   986E 27 19         [ 3] 2697         beq     L9889  
   9870                    2698 L9870:
   9870 7F 00 31      [ 6] 2699         clr     (0x0031)
   9873 D6 62         [ 3] 2700         ldab    (0x0062)
   9875 C4 FE         [ 2] 2701         andb    #0xFE
   9877 D7 62         [ 3] 2702         stab    (0x0062)
   9879 BD F9 C5      [ 6] 2703         jsr     BUTNLIT 
   987C BD AA 13      [ 6] 2704         jsr     (0xAA13)
   987F C6 FB         [ 2] 2705         ldab    #0xFB
   9881 BD 86 E7      [ 6] 2706         jsr     (0x86E7)
   9884 7F 00 5A      [ 6] 2707         clr     (0x005A)
   9887 20 4B         [ 3] 2708         bra     L98D4  
   9889                    2709 L9889:
   9889 DC 1B         [ 4] 2710         ldd     CDTIMR1
   988B 26 D7         [ 3] 2711         bne     L9864  
   988D D6 62         [ 3] 2712         ldab    (0x0062)
   988F C8 01         [ 2] 2713         eorb    #0x01
   9891 D7 62         [ 3] 2714         stab    (0x0062)
   9893 BD F9 C5      [ 6] 2715         jsr     BUTNLIT 
   9896 C4 01         [ 2] 2716         andb    #0x01
   9898 26 05         [ 3] 2717         bne     L989F  
   989A BD AA 0C      [ 6] 2718         jsr     (0xAA0C)
   989D 20 03         [ 3] 2719         bra     L98A2  
   989F                    2720 L989F:
   989F BD AA 13      [ 6] 2721         jsr     (0xAA13)
   98A2                    2722 L98A2:
   98A2 CC 00 32      [ 3] 2723         ldd     #0x0032
   98A5 DD 1B         [ 4] 2724         std     CDTIMR1
   98A7 DC 1D         [ 4] 2725         ldd     CDTIMR2
   98A9 27 C5         [ 3] 2726         beq     L9870  
   98AB 20 B7         [ 3] 2727         bra     L9864  
   98AD                    2728 L98AD:
   98AD 7D 00 75      [ 6] 2729         tst     (0x0075)
   98B0 27 03         [ 3] 2730         beq     L98B5  
   98B2 7E 99 39      [ 3] 2731         jmp     (0x9939)
   98B5                    2732 L98B5:
   98B5 96 62         [ 3] 2733         ldaa    (0x0062)
   98B7 84 02         [ 2] 2734         anda    #0x02
   98B9 27 4E         [ 3] 2735         beq     L9909  
   98BB 7D 00 AF      [ 6] 2736         tst     (0x00AF)
   98BE 26 0B         [ 3] 2737         bne     L98CB  
   98C0 FC 04 24      [ 5] 2738         ldd     (0x0424)
   98C3 C3 00 01      [ 4] 2739         addd    #0x0001
   98C6 FD 04 24      [ 5] 2740         std     (0x0424)
   98C9 20 09         [ 3] 2741         bra     L98D4  
   98CB                    2742 L98CB:
   98CB FC 04 22      [ 5] 2743         ldd     (0x0422)
   98CE C3 00 01      [ 4] 2744         addd    #0x0001
   98D1 FD 04 22      [ 5] 2745         std     (0x0422)
   98D4                    2746 L98D4:
   98D4 FC 04 18      [ 5] 2747         ldd     (0x0418)
   98D7 C3 00 01      [ 4] 2748         addd    #0x0001
   98DA FD 04 18      [ 5] 2749         std     (0x0418)
   98DD 86 78         [ 2] 2750         ldaa    #0x78
   98DF 97 63         [ 3] 2751         staa    (0x0063)
   98E1 97 64         [ 3] 2752         staa    (0x0064)
   98E3 D6 62         [ 3] 2753         ldab    (0x0062)
   98E5 C4 F7         [ 2] 2754         andb    #0xF7
   98E7 CA 02         [ 2] 2755         orab    #0x02
   98E9 D7 62         [ 3] 2756         stab    (0x0062)
   98EB BD F9 C5      [ 6] 2757         jsr     BUTNLIT 
   98EE BD AA 18      [ 6] 2758         jsr     (0xAA18)
   98F1 86 01         [ 2] 2759         ldaa    #0x01
   98F3 97 4E         [ 3] 2760         staa    (0x004E)
   98F5 97 75         [ 3] 2761         staa    (0x0075)
   98F7 D6 7B         [ 3] 2762         ldab    (0x007B)
   98F9 C4 DF         [ 2] 2763         andb    #0xDF
   98FB BD 87 48      [ 6] 2764         jsr     L8748   
   98FE BD 87 AE      [ 6] 2765         jsr     (0x87AE)
   9901 BD A3 13      [ 6] 2766         jsr     (0xA313)
   9904 BD AA DB      [ 6] 2767         jsr     (0xAADB)
   9907 20 30         [ 3] 2768         bra     L9939  
   9909                    2769 L9909:
   9909 D6 62         [ 3] 2770         ldab    (0x0062)
   990B C4 F5         [ 2] 2771         andb    #0xF5
   990D CA 40         [ 2] 2772         orab    #0x40
   990F D7 62         [ 3] 2773         stab    (0x0062)
   9911 BD F9 C5      [ 6] 2774         jsr     BUTNLIT 
   9914 BD AA 1D      [ 6] 2775         jsr     (0xAA1D)
   9917 7D 00 AF      [ 6] 2776         tst     (0x00AF)
   991A 26 04         [ 3] 2777         bne     L9920  
   991C C6 01         [ 2] 2778         ldab    #0x01
   991E D7 B6         [ 3] 2779         stab    (0x00B6)
   9920                    2780 L9920:
   9920 BD 9C 51      [ 6] 2781         jsr     (0x9C51)
   9923 7F 00 4E      [ 6] 2782         clr     (0x004E)
   9926 7F 00 75      [ 6] 2783         clr     (0x0075)
   9929 86 01         [ 2] 2784         ldaa    #0x01
   992B 97 77         [ 3] 2785         staa    (0x0077)
   992D D6 7B         [ 3] 2786         ldab    (0x007B)
   992F CA 24         [ 2] 2787         orab    #0x24
   9931 C4 F7         [ 2] 2788         andb    #0xF7
   9933 BD 87 48      [ 6] 2789         jsr     L8748   
   9936 BD 87 91      [ 6] 2790         jsr     L8791   
   9939                    2791 L9939:
   9939 7F 00 AF      [ 6] 2792         clr     (0x00AF)
   993C 7E 85 A4      [ 3] 2793         jmp     (0x85A4)
   993F 7F 00 77      [ 6] 2794         clr     (0x0077)
   9942 BD 9C 51      [ 6] 2795         jsr     (0x9C51)
   9945 7F 00 4E      [ 6] 2796         clr     (0x004E)
   9948 D6 62         [ 3] 2797         ldab    (0x0062)
   994A C4 BF         [ 2] 2798         andb    #0xBF
   994C 7D 00 75      [ 6] 2799         tst     (0x0075)
   994F 27 02         [ 3] 2800         beq     L9953  
   9951 C4 FD         [ 2] 2801         andb    #0xFD
   9953                    2802 L9953:
   9953 D7 62         [ 3] 2803         stab    (0x0062)
   9955 BD F9 C5      [ 6] 2804         jsr     BUTNLIT 
   9958 BD AA 1D      [ 6] 2805         jsr     (0xAA1D)
   995B 7F 00 5B      [ 6] 2806         clr     (0x005B)
   995E BD 87 AE      [ 6] 2807         jsr     (0x87AE)
   9961 D6 7B         [ 3] 2808         ldab    (0x007B)
   9963 CA 20         [ 2] 2809         orab    #0x20
   9965 BD 87 48      [ 6] 2810         jsr     L8748   
   9968 7F 00 75      [ 6] 2811         clr     (0x0075)
   996B 7F 00 76      [ 6] 2812         clr     (0x0076)
   996E 7E 98 15      [ 3] 2813         jmp     (0x9815)
   9971 D6 7B         [ 3] 2814         ldab    (0x007B)
   9973 C4 FB         [ 2] 2815         andb    #0xFB
   9975 BD 87 48      [ 6] 2816         jsr     L8748   
   9978 7E 85 A4      [ 3] 2817         jmp     (0x85A4)
   997B D6 7B         [ 3] 2818         ldab    (0x007B)
   997D CA 04         [ 2] 2819         orab    #0x04
   997F BD 87 48      [ 6] 2820         jsr     L8748   
   9982 7E 85 A4      [ 3] 2821         jmp     (0x85A4)
   9985 D6 7B         [ 3] 2822         ldab    (0x007B)
   9987 C4 F7         [ 2] 2823         andb    #0xF7
   9989 BD 87 48      [ 6] 2824         jsr     L8748   
   998C 7E 85 A4      [ 3] 2825         jmp     (0x85A4)
   998F 7D 00 77      [ 6] 2826         tst     (0x0077)
   9992 26 07         [ 3] 2827         bne     L999B  
   9994 D6 7B         [ 3] 2828         ldab    (0x007B)
   9996 CA 08         [ 2] 2829         orab    #0x08
   9998 BD 87 48      [ 6] 2830         jsr     L8748   
   999B                    2831 L999B:
   999B 7E 85 A4      [ 3] 2832         jmp     (0x85A4)
   999E D6 7B         [ 3] 2833         ldab    (0x007B)
   99A0 C4 F3         [ 2] 2834         andb    #0xF3
   99A2 BD 87 48      [ 6] 2835         jsr     L8748   
   99A5 39            [ 5] 2836         rts
                           2837 
                           2838 ; main2
   99A6                    2839 L99A6:
   99A6 D6 7B         [ 3] 2840         ldab    (0x007B)
   99A8 C4 DF         [ 2] 2841         andb    #0xDF        ; clear bit 5
   99AA BD 87 48      [ 6] 2842         jsr     L8748
   99AD BD 87 91      [ 6] 2843         jsr     L8791   
   99B0 39            [ 5] 2844         rts
                           2845 
   99B1 D6 7B         [ 3] 2846         ldab    (0x007B)
   99B3 CA 20         [ 2] 2847         orab    #0x20
   99B5 BD 87 48      [ 6] 2848         jsr     L8748   
   99B8 BD 87 AE      [ 6] 2849         jsr     (0x87AE)
   99BB 39            [ 5] 2850         rts
                           2851 
   99BC D6 7B         [ 3] 2852         ldab    (0x007B)
   99BE C4 DF         [ 2] 2853         andb    #0xDF
   99C0 BD 87 48      [ 6] 2854         jsr     L8748   
   99C3 BD 87 AE      [ 6] 2855         jsr     (0x87AE)
   99C6 39            [ 5] 2856         rts
                           2857 
   99C7 D6 7B         [ 3] 2858         ldab    (0x007B)
   99C9 CA 20         [ 2] 2859         orab    #0x20
   99CB BD 87 48      [ 6] 2860         jsr     L8748   
   99CE BD 87 91      [ 6] 2861         jsr     L8791   
   99D1 39            [ 5] 2862         rts
                           2863 
   99D2 86 01         [ 2] 2864         ldaa    #0x01
   99D4 97 78         [ 3] 2865         staa    (0x0078)
   99D6 7E 85 A4      [ 3] 2866         jmp     (0x85A4)
   99D9 CE 0E 20      [ 3] 2867         ldx     #0x0E20
   99DC A6 00         [ 4] 2868         ldaa    0,X     
   99DE 80 30         [ 2] 2869         suba    #0x30
   99E0 C6 0A         [ 2] 2870         ldab    #0x0A
   99E2 3D            [10] 2871         mul
   99E3 17            [ 2] 2872         tba
   99E4 C6 64         [ 2] 2873         ldab    #0x64
   99E6 3D            [10] 2874         mul
   99E7 DD 17         [ 4] 2875         std     (0x0017)
   99E9 A6 01         [ 4] 2876         ldaa    1,X     
   99EB 80 30         [ 2] 2877         suba    #0x30
   99ED C6 64         [ 2] 2878         ldab    #0x64
   99EF 3D            [10] 2879         mul
   99F0 D3 17         [ 5] 2880         addd    (0x0017)
   99F2 DD 17         [ 4] 2881         std     (0x0017)
   99F4 A6 02         [ 4] 2882         ldaa    2,X     
   99F6 80 30         [ 2] 2883         suba    #0x30
   99F8 C6 0A         [ 2] 2884         ldab    #0x0A
   99FA 3D            [10] 2885         mul
   99FB D3 17         [ 5] 2886         addd    (0x0017)
   99FD DD 17         [ 4] 2887         std     (0x0017)
   99FF 4F            [ 2] 2888         clra
   9A00 E6 03         [ 4] 2889         ldab    3,X     
   9A02 C0 30         [ 2] 2890         subb    #0x30
   9A04 D3 17         [ 5] 2891         addd    (0x0017)
   9A06 FD 02 9C      [ 5] 2892         std     (0x029C)
   9A09 CE 0E 20      [ 3] 2893         ldx     #0x0E20
   9A0C                    2894 L9A0C:
   9A0C A6 00         [ 4] 2895         ldaa    0,X     
   9A0E 81 30         [ 2] 2896         cmpa    #0x30
   9A10 25 13         [ 3] 2897         bcs     L9A25  
   9A12 81 39         [ 2] 2898         cmpa    #0x39
   9A14 22 0F         [ 3] 2899         bhi     L9A25  
   9A16 08            [ 3] 2900         inx
   9A17 8C 0E 24      [ 4] 2901         cpx     #0x0E24
   9A1A 26 F0         [ 3] 2902         bne     L9A0C  
   9A1C B6 0E 24      [ 4] 2903         ldaa    (0x0E24)        ; check EEPROM signature
   9A1F 81 DB         [ 2] 2904         cmpa    #0xDB
   9A21 26 02         [ 3] 2905         bne     L9A25  
   9A23 0C            [ 2] 2906         clc
   9A24 39            [ 5] 2907         rts
                           2908 
   9A25                    2909 L9A25:
   9A25 0D            [ 2] 2910         sec
   9A26 39            [ 5] 2911         rts
                           2912 
   9A27 BD 8D E4      [ 6] 2913         jsr     LCDMSG1 
   9A2A 53 65 72 69 61 6C  2914         .ascis  'Serial# '
        23 A0
                           2915 
   9A32 BD 8D DD      [ 6] 2916         jsr     LCDMSG2 
   9A35 20 20 20 20 20 20  2917         .ascis  '               '
        20 20 20 20 20 20
        20 20 A0
                           2918 
                           2919 ; display 4-digit serial number
   9A44 C6 08         [ 2] 2920         ldab    #0x08
   9A46 18 CE 0E 20   [ 4] 2921         ldy     #0x0E20
   9A4A                    2922 L9A4A:
   9A4A 18 A6 00      [ 5] 2923         ldaa    0,Y     
   9A4D 18 3C         [ 5] 2924         pshy
   9A4F 37            [ 3] 2925         pshb
   9A50 BD 8D B5      [ 6] 2926         jsr     (0x8DB5)         ; display char here on LCD display
   9A53 33            [ 4] 2927         pulb
   9A54 18 38         [ 6] 2928         puly
   9A56 5C            [ 2] 2929         incb
   9A57 18 08         [ 4] 2930         iny
   9A59 18 8C 0E 24   [ 5] 2931         cpy     #0x0E24
   9A5D 26 EB         [ 3] 2932         bne     L9A4A  
   9A5F 39            [ 5] 2933         rts
                           2934 
   9A60 86 01         [ 2] 2935         ldaa    #0x01
   9A62 97 B5         [ 3] 2936         staa    (0x00B5)
   9A64 96 4E         [ 3] 2937         ldaa    (0x004E)
   9A66 97 7F         [ 3] 2938         staa    (0x007F)
   9A68 96 62         [ 3] 2939         ldaa    (0x0062)
   9A6A 97 80         [ 3] 2940         staa    (0x0080)
   9A6C 96 7B         [ 3] 2941         ldaa    (0x007B)
   9A6E 97 81         [ 3] 2942         staa    (0x0081)
   9A70 96 7A         [ 3] 2943         ldaa    (0x007A)
   9A72 97 82         [ 3] 2944         staa    (0x0082)
   9A74 96 78         [ 3] 2945         ldaa    (0x0078)
   9A76 97 7D         [ 3] 2946         staa    (0x007D)
   9A78 B6 10 8A      [ 4] 2947         ldaa    (0x108A)
   9A7B 84 06         [ 2] 2948         anda    #0x06
   9A7D 97 7E         [ 3] 2949         staa    (0x007E)
   9A7F C6 EF         [ 2] 2950         ldab    #0xEF
   9A81 BD 86 E7      [ 6] 2951         jsr     (0x86E7)
   9A84 D6 7B         [ 3] 2952         ldab    (0x007B)
   9A86 CA 0C         [ 2] 2953         orab    #0x0C
   9A88 C4 DF         [ 2] 2954         andb    #0xDF
   9A8A BD 87 48      [ 6] 2955         jsr     L8748   
   9A8D BD 87 91      [ 6] 2956         jsr     L8791   
   9A90 BD 86 C4      [ 6] 2957         jsr     L86C4
   9A93 BD 9C 51      [ 6] 2958         jsr     (0x9C51)
   9A96 C6 06         [ 2] 2959         ldab    #0x06            ; delay 6 secs
   9A98 BD 8C 02      [ 6] 2960         jsr     L8C02            ;
   9A9B BD 8E 95      [ 6] 2961         jsr     (0x8E95)
   9A9E BD 99 A6      [ 6] 2962         jsr     L99A6
   9AA1 7E 81 BD      [ 3] 2963         jmp     (0x81BD)
   9AA4 7F 00 5C      [ 6] 2964         clr     (0x005C)
   9AA7 86 01         [ 2] 2965         ldaa    #0x01
   9AA9 97 79         [ 3] 2966         staa    (0x0079)
   9AAB C6 FD         [ 2] 2967         ldab    #0xFD
   9AAD BD 86 E7      [ 6] 2968         jsr     (0x86E7)
   9AB0 BD 8E 95      [ 6] 2969         jsr     (0x8E95)
   9AB3 CC 75 30      [ 3] 2970         ldd     #0x7530
   9AB6 DD 1D         [ 4] 2971         std     CDTIMR2
   9AB8                    2972 L9AB8:
   9AB8 BD 9B 19      [ 6] 2973         jsr     L9B19   
   9ABB D6 62         [ 3] 2974         ldab    (0x0062)
   9ABD C8 04         [ 2] 2975         eorb    #0x04
   9ABF D7 62         [ 3] 2976         stab    (0x0062)
   9AC1 BD F9 C5      [ 6] 2977         jsr     BUTNLIT 
   9AC4 F6 18 04      [ 4] 2978         ldab    PIA0PRA 
   9AC7 C8 08         [ 2] 2979         eorb    #0x08
   9AC9 F7 18 04      [ 4] 2980         stab    PIA0PRA 
   9ACC 7D 00 5C      [ 6] 2981         tst     (0x005C)
   9ACF 26 12         [ 3] 2982         bne     L9AE3  
   9AD1 BD 8E 95      [ 6] 2983         jsr     (0x8E95)
   9AD4 81 0D         [ 2] 2984         cmpa    #0x0D
   9AD6 27 0B         [ 3] 2985         beq     L9AE3  
   9AD8 C6 32         [ 2] 2986         ldab    #0x32
   9ADA BD 8C 22      [ 6] 2987         jsr     (0x8C22)
   9ADD DC 1D         [ 4] 2988         ldd     CDTIMR2
   9ADF 27 02         [ 3] 2989         beq     L9AE3  
   9AE1 20 D5         [ 3] 2990         bra     L9AB8  
   9AE3                    2991 L9AE3:
   9AE3 D6 62         [ 3] 2992         ldab    (0x0062)
   9AE5 C4 FB         [ 2] 2993         andb    #0xFB
   9AE7 D7 62         [ 3] 2994         stab    (0x0062)
   9AE9 BD F9 C5      [ 6] 2995         jsr     BUTNLIT 
   9AEC BD A3 54      [ 6] 2996         jsr     (0xA354)
   9AEF C6 FB         [ 2] 2997         ldab    #0xFB
   9AF1 BD 86 E7      [ 6] 2998         jsr     (0x86E7)
   9AF4 7E 85 A4      [ 3] 2999         jmp     (0x85A4)
   9AF7 7F 00 75      [ 6] 3000         clr     (0x0075)
   9AFA 7F 00 76      [ 6] 3001         clr     (0x0076)
   9AFD 7F 00 77      [ 6] 3002         clr     (0x0077)
   9B00 7F 00 78      [ 6] 3003         clr     (0x0078)
   9B03 7F 00 25      [ 6] 3004         clr     (0x0025)
   9B06 7F 00 26      [ 6] 3005         clr     (0x0026)
   9B09 7F 00 4E      [ 6] 3006         clr     (0x004E)
   9B0C 7F 00 30      [ 6] 3007         clr     (0x0030)
   9B0F 7F 00 31      [ 6] 3008         clr     (0x0031)
   9B12 7F 00 32      [ 6] 3009         clr     (0x0032)
   9B15 7F 00 AF      [ 6] 3010         clr     (0x00AF)
   9B18 39            [ 5] 3011         rts
                           3012 
                           3013 ; validate a bunch of ram locations against bytes in ROM???
   9B19                    3014 L9B19:
   9B19 36            [ 3] 3015         psha
   9B1A 37            [ 3] 3016         pshb
   9B1B 96 4E         [ 3] 3017         ldaa    (0x004E)
   9B1D 27 17         [ 3] 3018         beq     L9B36       ; go to 0401 logic
   9B1F 96 63         [ 3] 3019         ldaa    (0x0063)
   9B21 26 10         [ 3] 3020         bne     L9B33       ; exit
   9B23 7D 00 64      [ 6] 3021         tst     (0x0064)
   9B26 27 09         [ 3] 3022         beq     L9B31       ; go to 0401 logic
   9B28 BD 86 C4      [ 6] 3023         jsr     L86C4     ; do something with boards???
   9B2B BD 9C 51      [ 6] 3024         jsr     (0x9C51)     ; RTC stuff???
   9B2E 7F 00 64      [ 6] 3025         clr     (0x0064)
   9B31                    3026 L9B31:
   9B31 20 03         [ 3] 3027         bra     L9B36       ; go to 0401 logic
   9B33                    3028 L9B33:
   9B33 33            [ 4] 3029         pulb
   9B34 32            [ 4] 3030         pula
   9B35 39            [ 5] 3031         rts
                           3032 
                           3033 ; end up here immediately if:
                           3034 ; 0x004E == 00 or
                           3035 ; 0x0063, 0x0064 == 0 or
                           3036 ; 
                           3037 ; do subroutines based on bits 0-4 of 0x0401?
   9B36                    3038 L9B36:
   9B36 B6 04 01      [ 4] 3039         ldaa    (0x0401)
   9B39 84 01         [ 2] 3040         anda    #0x01
   9B3B 27 03         [ 3] 3041         beq     L9B40  
   9B3D BD 9B 6B      [ 6] 3042         jsr     (0x9B6B)     ; bit 0 routine
   9B40                    3043 L9B40:
   9B40 B6 04 01      [ 4] 3044         ldaa    (0x0401)
   9B43 84 02         [ 2] 3045         anda    #0x02
   9B45 27 03         [ 3] 3046         beq     L9B4A  
   9B47 BD 9B 99      [ 6] 3047         jsr     (0x9B99)     ; bit 1 routine
   9B4A                    3048 L9B4A:
   9B4A B6 04 01      [ 4] 3049         ldaa    (0x0401)
   9B4D 84 04         [ 2] 3050         anda    #0x04
   9B4F 27 03         [ 3] 3051         beq     L9B54  
   9B51 BD 9B C7      [ 6] 3052         jsr     (0x9BC7)     ; bit 2 routine
   9B54                    3053 L9B54:
   9B54 B6 04 01      [ 4] 3054         ldaa    (0x0401)
   9B57 84 08         [ 2] 3055         anda    #0x08
   9B59 27 03         [ 3] 3056         beq     L9B5E  
   9B5B BD 9B F5      [ 6] 3057         jsr     (0x9BF5)     ; bit 3 routine
   9B5E                    3058 L9B5E:
   9B5E B6 04 01      [ 4] 3059         ldaa    (0x0401)
   9B61 84 10         [ 2] 3060         anda    #0x10
   9B63 27 03         [ 3] 3061         beq     L9B68  
   9B65 BD 9C 23      [ 6] 3062         jsr     (0x9C23)     ; bit 4 routine
   9B68                    3063 L9B68:
   9B68 33            [ 4] 3064         pulb
   9B69 32            [ 4] 3065         pula
   9B6A 39            [ 5] 3066         rts
                           3067 
                           3068 ; bit 0 routine
   9B6B 18 3C         [ 5] 3069         pshy
   9B6D 18 DE 65      [ 5] 3070         ldy     (0x0065)
   9B70 18 A6 00      [ 5] 3071         ldaa    0,Y     
   9B73 81 FF         [ 2] 3072         cmpa    #0xFF
   9B75 27 14         [ 3] 3073         beq     L9B8B  
   9B77 91 70         [ 3] 3074         cmpa    OFFCNT1
   9B79 25 0D         [ 3] 3075         bcs     L9B88  
   9B7B 18 08         [ 4] 3076         iny
   9B7D 18 A6 00      [ 5] 3077         ldaa    0,Y     
   9B80 B7 10 80      [ 4] 3078         staa    (0x1080)
   9B83 18 08         [ 4] 3079         iny
   9B85 18 DF 65      [ 5] 3080         sty     (0x0065)
   9B88                    3081 L9B88:
   9B88 18 38         [ 6] 3082         puly
   9B8A 39            [ 5] 3083         rts
   9B8B                    3084 L9B8B:
   9B8B 18 CE B2 EB   [ 4] 3085         ldy     #0xB2EB
   9B8F 18 DF 65      [ 5] 3086         sty     (0x0065)
   9B92 86 FA         [ 2] 3087         ldaa    #0xFA
   9B94 97 70         [ 3] 3088         staa    OFFCNT1
   9B96 7E 9B 88      [ 3] 3089         jmp     (0x9B88)
   9B99 18 3C         [ 5] 3090         pshy
   9B9B 18 DE 67      [ 5] 3091         ldy     (0x0067)
   9B9E 18 A6 00      [ 5] 3092         ldaa    0,Y     
   9BA1 81 FF         [ 2] 3093         cmpa    #0xFF
   9BA3 27 14         [ 3] 3094         beq     L9BB9  
   9BA5 91 71         [ 3] 3095         cmpa    OFFCNT2
   9BA7 25 0D         [ 3] 3096         bcs     L9BB6  
   9BA9 18 08         [ 4] 3097         iny
   9BAB 18 A6 00      [ 5] 3098         ldaa    0,Y     
   9BAE B7 10 84      [ 4] 3099         staa    (0x1084)
   9BB1 18 08         [ 4] 3100         iny
   9BB3 18 DF 67      [ 5] 3101         sty     (0x0067)
   9BB6                    3102 L9BB6:
   9BB6 18 38         [ 6] 3103         puly
   9BB8 39            [ 5] 3104         rts
                           3105 
                           3106 ; bit 1 routine
   9BB9                    3107 L9BB9:
   9BB9 18 CE B3 BD   [ 4] 3108         ldy     #0xB3BD
   9BBD 18 DF 67      [ 5] 3109         sty     (0x0067)
   9BC0 86 E6         [ 2] 3110         ldaa    #0xE6
   9BC2 97 71         [ 3] 3111         staa    OFFCNT2
   9BC4 7E 9B B6      [ 3] 3112         jmp     (0x9BB6)
                           3113 
                           3114 ; bit 2 routine
   9BC7 18 3C         [ 5] 3115         pshy
   9BC9 18 DE 69      [ 5] 3116         ldy     (0x0069)
   9BCC 18 A6 00      [ 5] 3117         ldaa    0,Y     
   9BCF 81 FF         [ 2] 3118         cmpa    #0xFF
   9BD1 27 14         [ 3] 3119         beq     L9BE7  
   9BD3 91 72         [ 3] 3120         cmpa    OFFCNT3
   9BD5 25 0D         [ 3] 3121         bcs     L9BE4  
   9BD7 18 08         [ 4] 3122         iny
   9BD9 18 A6 00      [ 5] 3123         ldaa    0,Y     
   9BDC B7 10 88      [ 4] 3124         staa    (0x1088)
   9BDF 18 08         [ 4] 3125         iny
   9BE1 18 DF 69      [ 5] 3126         sty     (0x0069)
   9BE4                    3127 L9BE4:
   9BE4 18 38         [ 6] 3128         puly
   9BE6 39            [ 5] 3129         rts
   9BE7                    3130 L9BE7:
   9BE7 18 CE B5 31   [ 4] 3131         ldy     #0xB531
   9BEB 18 DF 69      [ 5] 3132         sty     (0x0069)
   9BEE 86 D2         [ 2] 3133         ldaa    #0xD2
   9BF0 97 72         [ 3] 3134         staa    OFFCNT3
   9BF2 7E 9B E4      [ 3] 3135         jmp     (0x9BE4)
                           3136 
                           3137 ; bit 3 routine
   9BF5 18 3C         [ 5] 3138         pshy
   9BF7 18 DE 6B      [ 5] 3139         ldy     (0x006B)
   9BFA 18 A6 00      [ 5] 3140         ldaa    0,Y     
   9BFD 81 FF         [ 2] 3141         cmpa    #0xFF
   9BFF 27 14         [ 3] 3142         beq     L9C15  
   9C01 91 73         [ 3] 3143         cmpa    OFFCNT4
   9C03 25 0D         [ 3] 3144         bcs     L9C12  
   9C05 18 08         [ 4] 3145         iny
   9C07 18 A6 00      [ 5] 3146         ldaa    0,Y     
   9C0A B7 10 8C      [ 4] 3147         staa    (0x108C)
   9C0D 18 08         [ 4] 3148         iny
   9C0F 18 DF 6B      [ 5] 3149         sty     (0x006B)
   9C12                    3150 L9C12:
   9C12 18 38         [ 6] 3151         puly
   9C14 39            [ 5] 3152         rts
   9C15                    3153 L9C15:
   9C15 18 CE B4 75   [ 4] 3154         ldy     #0xB475
   9C19 18 DF 6B      [ 5] 3155         sty     (0x006B)
   9C1C 86 BE         [ 2] 3156         ldaa    #0xBE
   9C1E 97 73         [ 3] 3157         staa    OFFCNT4
   9C20 7E 9C 12      [ 3] 3158         jmp     (0x9C12)
                           3159 
                           3160 ; bit 4 routine
   9C23 18 3C         [ 5] 3161         pshy
   9C25 18 DE 6D      [ 5] 3162         ldy     (0x006D)
   9C28 18 A6 00      [ 5] 3163         ldaa    0,Y     
   9C2B 81 FF         [ 2] 3164         cmpa    #0xFF
   9C2D 27 14         [ 3] 3165         beq     L9C43  
   9C2F 91 74         [ 3] 3166         cmpa    OFFCNT5
   9C31 25 0D         [ 3] 3167         bcs     L9C40  
   9C33 18 08         [ 4] 3168         iny
   9C35 18 A6 00      [ 5] 3169         ldaa    0,Y     
   9C38 B7 10 90      [ 4] 3170         staa    (0x1090)
   9C3B 18 08         [ 4] 3171         iny
   9C3D 18 DF 6D      [ 5] 3172         sty     (0x006D)
   9C40                    3173 L9C40:
   9C40 18 38         [ 6] 3174         puly
   9C42 39            [ 5] 3175         rts
   9C43                    3176 L9C43:
   9C43 18 CE B5 C3   [ 4] 3177         ldy     #0xB5C3
   9C47 18 DF 6D      [ 5] 3178         sty     (0x006D)
   9C4A 86 AA         [ 2] 3179         ldaa    #0xAA
   9C4C 97 74         [ 3] 3180         staa    OFFCNT5
   9C4E 7E 9C 40      [ 3] 3181         jmp     (0x9C40)
                           3182 
                           3183 ; Reset offset counters to initial values
   9C51 86 FA         [ 2] 3184         ldaa    #0xFA
   9C53 97 70         [ 3] 3185         staa    OFFCNT1
   9C55 86 E6         [ 2] 3186         ldaa    #0xE6
   9C57 97 71         [ 3] 3187         staa    OFFCNT2
   9C59 86 D2         [ 2] 3188         ldaa    #0xD2
   9C5B 97 72         [ 3] 3189         staa    OFFCNT3
   9C5D 86 BE         [ 2] 3190         ldaa    #0xBE
   9C5F 97 73         [ 3] 3191         staa    OFFCNT4
   9C61 86 AA         [ 2] 3192         ldaa    #0xAA
   9C63 97 74         [ 3] 3193         staa    OFFCNT5
                           3194 
   9C65 18 CE B2 EB   [ 4] 3195         ldy     #0xB2EB
   9C69 18 DF 65      [ 5] 3196         sty     (0x0065)
   9C6C 18 CE B3 BD   [ 4] 3197         ldy     #0xB3BD
   9C70 18 DF 67      [ 5] 3198         sty     (0x0067)
   9C73 18 CE B5 31   [ 4] 3199         ldy     #0xB531
   9C77 18 DF 69      [ 5] 3200         sty     (0x0069)
   9C7A 18 CE B4 75   [ 4] 3201         ldy     #0xB475
   9C7E 18 DF 6B      [ 5] 3202         sty     (0x006B)
   9C81 18 CE B5 C3   [ 4] 3203         ldy     #0xB5C3
   9C85 18 DF 6D      [ 5] 3204         sty     (0x006D)
                           3205 
   9C88 7F 10 9C      [ 6] 3206         clr     (0x109C)
   9C8B 7F 10 9E      [ 6] 3207         clr     (0x109E)
                           3208 
   9C8E B6 04 01      [ 4] 3209         ldaa    (0x0401)
   9C91 84 20         [ 2] 3210         anda    #0x20
   9C93 27 08         [ 3] 3211         beq     L9C9D  
   9C95 B6 10 9C      [ 4] 3212         ldaa    (0x109C)
   9C98 8A 19         [ 2] 3213         oraa    #0x19
   9C9A B7 10 9C      [ 4] 3214         staa    (0x109C)
   9C9D                    3215 L9C9D:
   9C9D B6 04 01      [ 4] 3216         ldaa    (0x0401)
   9CA0 84 40         [ 2] 3217         anda    #0x40
   9CA2 27 10         [ 3] 3218         beq     L9CB4  
   9CA4 B6 10 9C      [ 4] 3219         ldaa    (0x109C)
   9CA7 8A 44         [ 2] 3220         oraa    #0x44
   9CA9 B7 10 9C      [ 4] 3221         staa    (0x109C)
   9CAC B6 10 9E      [ 4] 3222         ldaa    (0x109E)
   9CAF 8A 40         [ 2] 3223         oraa    #0x40
   9CB1 B7 10 9E      [ 4] 3224         staa    (0x109E)
   9CB4                    3225 L9CB4:
   9CB4 B6 04 01      [ 4] 3226         ldaa    (0x0401)
   9CB7 84 80         [ 2] 3227         anda    #0x80
   9CB9 27 08         [ 3] 3228         beq     L9CC3  
   9CBB B6 10 9C      [ 4] 3229         ldaa    (0x109C)
   9CBE 8A A2         [ 2] 3230         oraa    #0xA2
   9CC0 B7 10 9C      [ 4] 3231         staa    (0x109C)
   9CC3                    3232 L9CC3:
   9CC3 B6 04 2B      [ 4] 3233         ldaa    (0x042B)
   9CC6 84 01         [ 2] 3234         anda    #0x01
   9CC8 27 08         [ 3] 3235         beq     L9CD2  
   9CCA B6 10 9A      [ 4] 3236         ldaa    (0x109A)
   9CCD 8A 80         [ 2] 3237         oraa    #0x80
   9CCF B7 10 9A      [ 4] 3238         staa    (0x109A)
   9CD2                    3239 L9CD2:
   9CD2 B6 04 2B      [ 4] 3240         ldaa    (0x042B)
   9CD5 84 02         [ 2] 3241         anda    #0x02
   9CD7 27 08         [ 3] 3242         beq     L9CE1  
   9CD9 B6 10 9E      [ 4] 3243         ldaa    (0x109E)
   9CDC 8A 04         [ 2] 3244         oraa    #0x04
   9CDE B7 10 9E      [ 4] 3245         staa    (0x109E)
   9CE1                    3246 L9CE1:
   9CE1 B6 04 2B      [ 4] 3247         ldaa    (0x042B)
   9CE4 84 04         [ 2] 3248         anda    #0x04
   9CE6 27 08         [ 3] 3249         beq     L9CF0  
   9CE8 B6 10 9E      [ 4] 3250         ldaa    (0x109E)
   9CEB 8A 08         [ 2] 3251         oraa    #0x08
   9CED B7 10 9E      [ 4] 3252         staa    (0x109E)
   9CF0                    3253 L9CF0:
   9CF0 39            [ 5] 3254         rts
                           3255 
   9CF1 BD 8D E4      [ 6] 3256         jsr     LCDMSG1 
   9CF4 20 20 20 50 72 6F  3257         .ascis  '   Program by   '
        67 72 61 6D 20 62
        79 20 20 A0
                           3258 
   9D04 BD 8D DD      [ 6] 3259         jsr     LCDMSG2 
   9D07 44 61 76 69 64 20  3260         .ascis  'David  Philipsen'
        20 50 68 69 6C 69
        70 73 65 EE
                           3261 
   9D17 39            [ 5] 3262         rts
                           3263 
   9D18 97 49         [ 3] 3264         staa    (0x0049)
   9D1A 7F 00 B8      [ 6] 3265         clr     (0x00B8)
   9D1D BD 8D 03      [ 6] 3266         jsr     (0x8D03)
   9D20 86 2A         [ 2] 3267         ldaa    #0x2A            ;'*'
   9D22 C6 28         [ 2] 3268         ldab    #0x28
   9D24 BD 8D B5      [ 6] 3269         jsr     (0x8DB5)         ; display char here on LCD display
   9D27 CC 0B B8      [ 3] 3270         ldd     #0x0BB8
   9D2A DD 1B         [ 4] 3271         std     CDTIMR1
   9D2C                    3272 L9D2C:
   9D2C BD 9B 19      [ 6] 3273         jsr     L9B19   
   9D2F 96 49         [ 3] 3274         ldaa    (0x0049)
   9D31 81 41         [ 2] 3275         cmpa    #0x41
   9D33 27 04         [ 3] 3276         beq     L9D39  
   9D35 81 4B         [ 2] 3277         cmpa    #0x4B
   9D37 26 04         [ 3] 3278         bne     L9D3D  
   9D39                    3279 L9D39:
   9D39 C6 01         [ 2] 3280         ldab    #0x01
   9D3B D7 B8         [ 3] 3281         stab    (0x00B8)
   9D3D                    3282 L9D3D:
   9D3D 81 41         [ 2] 3283         cmpa    #0x41
   9D3F 27 04         [ 3] 3284         beq     L9D45  
   9D41 81 4F         [ 2] 3285         cmpa    #0x4F
   9D43 26 07         [ 3] 3286         bne     L9D4C  
   9D45                    3287 L9D45:
   9D45 86 01         [ 2] 3288         ldaa    #0x01
   9D47 B7 02 98      [ 4] 3289         staa    (0x0298)
   9D4A 20 32         [ 3] 3290         bra     L9D7E  
   9D4C                    3291 L9D4C:
   9D4C 81 4B         [ 2] 3292         cmpa    #0x4B
   9D4E 27 04         [ 3] 3293         beq     L9D54  
   9D50 81 50         [ 2] 3294         cmpa    #0x50
   9D52 26 07         [ 3] 3295         bne     L9D5B  
   9D54                    3296 L9D54:
   9D54 86 02         [ 2] 3297         ldaa    #0x02
   9D56 B7 02 98      [ 4] 3298         staa    (0x0298)
   9D59 20 23         [ 3] 3299         bra     L9D7E  
   9D5B                    3300 L9D5B:
   9D5B 81 4C         [ 2] 3301         cmpa    #0x4C
   9D5D 26 07         [ 3] 3302         bne     L9D66  
   9D5F 86 03         [ 2] 3303         ldaa    #0x03
   9D61 B7 02 98      [ 4] 3304         staa    (0x0298)
   9D64 20 18         [ 3] 3305         bra     L9D7E  
   9D66                    3306 L9D66:
   9D66 81 52         [ 2] 3307         cmpa    #0x52
   9D68 26 07         [ 3] 3308         bne     L9D71  
   9D6A 86 04         [ 2] 3309         ldaa    #0x04
   9D6C B7 02 98      [ 4] 3310         staa    (0x0298)
   9D6F 20 0D         [ 3] 3311         bra     L9D7E  
   9D71                    3312 L9D71:
   9D71 DC 1B         [ 4] 3313         ldd     CDTIMR1
   9D73 26 B7         [ 3] 3314         bne     L9D2C  
   9D75 86 23         [ 2] 3315         ldaa    #0x23            ;'#'
   9D77 C6 29         [ 2] 3316         ldab    #0x29
   9D79 BD 8D B5      [ 6] 3317         jsr     (0x8DB5)         ; display char here on LCD display
   9D7C 20 6C         [ 3] 3318         bra     L9DEA  
   9D7E                    3319 L9D7E:
   9D7E 7F 00 49      [ 6] 3320         clr     (0x0049)
   9D81 86 2A         [ 2] 3321         ldaa    #0x2A            ;'*'
   9D83 C6 29         [ 2] 3322         ldab    #0x29
   9D85 BD 8D B5      [ 6] 3323         jsr     (0x8DB5)         ; display char here on LCD display
   9D88 7F 00 4A      [ 6] 3324         clr     (0x004A)
   9D8B CE 02 99      [ 3] 3325         ldx     #0x0299
   9D8E                    3326 L9D8E:
   9D8E BD 9B 19      [ 6] 3327         jsr     L9B19   
   9D91 96 4A         [ 3] 3328         ldaa    (0x004A)
   9D93 27 F9         [ 3] 3329         beq     L9D8E  
   9D95 7F 00 4A      [ 6] 3330         clr     (0x004A)
   9D98 84 3F         [ 2] 3331         anda    #0x3F
   9D9A A7 00         [ 4] 3332         staa    0,X     
   9D9C 08            [ 3] 3333         inx
   9D9D 8C 02 9C      [ 4] 3334         cpx     #0x029C
   9DA0 26 EC         [ 3] 3335         bne     L9D8E  
   9DA2 BD 9D F5      [ 6] 3336         jsr     (0x9DF5)
   9DA5 24 09         [ 3] 3337         bcc     L9DB0  
   9DA7 86 23         [ 2] 3338         ldaa    #0x23            ;'#'
   9DA9 C6 2A         [ 2] 3339         ldab    #0x2A
   9DAB BD 8D B5      [ 6] 3340         jsr     (0x8DB5)         ; display char here on LCD display
   9DAE 20 3A         [ 3] 3341         bra     L9DEA  
   9DB0                    3342 L9DB0:
   9DB0 86 2A         [ 2] 3343         ldaa    #0x2A            ;'*'
   9DB2 C6 2A         [ 2] 3344         ldab    #0x2A
   9DB4 BD 8D B5      [ 6] 3345         jsr     (0x8DB5)         ; display char here on LCD display
   9DB7 B6 02 99      [ 4] 3346         ldaa    (0x0299)
   9DBA 81 39         [ 2] 3347         cmpa    #0x39
   9DBC 26 15         [ 3] 3348         bne     L9DD3  
                           3349 
   9DBE BD 8D DD      [ 6] 3350         jsr     LCDMSG2 
   9DC1 47 65 6E 65 72 69  3351         .ascis  'Generic Showtape'
        63 20 53 68 6F 77
        74 61 70 E5
                           3352 
   9DD1 0C            [ 2] 3353         clc
   9DD2 39            [ 5] 3354         rts
                           3355 
   9DD3                    3356 L9DD3:
   9DD3 B6 02 98      [ 4] 3357         ldaa    (0x0298)
   9DD6 81 03         [ 2] 3358         cmpa    #0x03
   9DD8 27 0E         [ 3] 3359         beq     L9DE8  
   9DDA 81 04         [ 2] 3360         cmpa    #0x04
   9DDC 27 0A         [ 3] 3361         beq     L9DE8  
   9DDE 96 76         [ 3] 3362         ldaa    (0x0076)
   9DE0 26 06         [ 3] 3363         bne     L9DE8  
   9DE2 BD 9E 73      [ 6] 3364         jsr     (0x9E73)
   9DE5 BD 9E CC      [ 6] 3365         jsr     (0x9ECC)
   9DE8                    3366 L9DE8:
   9DE8 0C            [ 2] 3367         clc
   9DE9 39            [ 5] 3368         rts
                           3369 
   9DEA                    3370 L9DEA:
   9DEA FC 04 20      [ 5] 3371         ldd     (0x0420)
   9DED C3 00 01      [ 4] 3372         addd    #0x0001
   9DF0 FD 04 20      [ 5] 3373         std     (0x0420)
   9DF3 0D            [ 2] 3374         sec
   9DF4 39            [ 5] 3375         rts
                           3376 
   9DF5 B6 02 99      [ 4] 3377         ldaa    (0x0299)
   9DF8 81 39         [ 2] 3378         cmpa    #0x39
   9DFA 27 6C         [ 3] 3379         beq     L9E68  
   9DFC CE 00 A8      [ 3] 3380         ldx     #0x00A8
   9DFF                    3381 L9DFF:
   9DFF BD 9B 19      [ 6] 3382         jsr     L9B19   
   9E02 96 4A         [ 3] 3383         ldaa    (0x004A)
   9E04 27 F9         [ 3] 3384         beq     L9DFF  
   9E06 7F 00 4A      [ 6] 3385         clr     (0x004A)
   9E09 A7 00         [ 4] 3386         staa    0,X     
   9E0B 08            [ 3] 3387         inx
   9E0C 8C 00 AA      [ 4] 3388         cpx     #0x00AA
   9E0F 26 EE         [ 3] 3389         bne     L9DFF  
   9E11 BD 9E FA      [ 6] 3390         jsr     (0x9EFA)
   9E14 CE 02 99      [ 3] 3391         ldx     #0x0299
   9E17 7F 00 13      [ 6] 3392         clr     (0x0013)
   9E1A                    3393 L9E1A:
   9E1A A6 00         [ 4] 3394         ldaa    0,X     
   9E1C 9B 13         [ 3] 3395         adda    (0x0013)
   9E1E 97 13         [ 3] 3396         staa    (0x0013)
   9E20 08            [ 3] 3397         inx
   9E21 8C 02 9C      [ 4] 3398         cpx     #0x029C
   9E24 26 F4         [ 3] 3399         bne     L9E1A  
   9E26 91 A8         [ 3] 3400         cmpa    (0x00A8)
   9E28 26 47         [ 3] 3401         bne     L9E71  
   9E2A CE 04 02      [ 3] 3402         ldx     #0x0402
   9E2D B6 02 98      [ 4] 3403         ldaa    (0x0298)
   9E30 81 02         [ 2] 3404         cmpa    #0x02
   9E32 26 03         [ 3] 3405         bne     L9E37  
   9E34 CE 04 05      [ 3] 3406         ldx     #0x0405
   9E37                    3407 L9E37:
   9E37 3C            [ 4] 3408         pshx
   9E38 BD AB 56      [ 6] 3409         jsr     (0xAB56)
   9E3B 38            [ 5] 3410         pulx
   9E3C 25 07         [ 3] 3411         bcs     L9E45  
   9E3E 86 03         [ 2] 3412         ldaa    #0x03
   9E40 B7 02 98      [ 4] 3413         staa    (0x0298)
   9E43 20 23         [ 3] 3414         bra     L9E68  
   9E45                    3415 L9E45:
   9E45 B6 02 99      [ 4] 3416         ldaa    (0x0299)
   9E48 A1 00         [ 4] 3417         cmpa    0,X     
   9E4A 25 1E         [ 3] 3418         bcs     L9E6A  
   9E4C 27 02         [ 3] 3419         beq     L9E50  
   9E4E 24 18         [ 3] 3420         bcc     L9E68  
   9E50                    3421 L9E50:
   9E50 08            [ 3] 3422         inx
   9E51 B6 02 9A      [ 4] 3423         ldaa    (0x029A)
   9E54 A1 00         [ 4] 3424         cmpa    0,X     
   9E56 25 12         [ 3] 3425         bcs     L9E6A  
   9E58 27 02         [ 3] 3426         beq     L9E5C  
   9E5A 24 0C         [ 3] 3427         bcc     L9E68  
   9E5C                    3428 L9E5C:
   9E5C 08            [ 3] 3429         inx
   9E5D B6 02 9B      [ 4] 3430         ldaa    (0x029B)
   9E60 A1 00         [ 4] 3431         cmpa    0,X     
   9E62 25 06         [ 3] 3432         bcs     L9E6A  
   9E64 27 02         [ 3] 3433         beq     L9E68  
   9E66 24 00         [ 3] 3434         bcc     L9E68  
   9E68                    3435 L9E68:
   9E68 0C            [ 2] 3436         clc
   9E69 39            [ 5] 3437         rts
                           3438 
   9E6A                    3439 L9E6A:
   9E6A B6 02 98      [ 4] 3440         ldaa    (0x0298)
   9E6D 81 03         [ 2] 3441         cmpa    #0x03
   9E6F 27 F7         [ 3] 3442         beq     L9E68  
   9E71                    3443 L9E71:
   9E71 0D            [ 2] 3444         sec
   9E72 39            [ 5] 3445         rts
                           3446 
   9E73 CE 04 02      [ 3] 3447         ldx     #0x0402
   9E76 B6 02 98      [ 4] 3448         ldaa    (0x0298)
   9E79 81 02         [ 2] 3449         cmpa    #0x02
   9E7B 26 03         [ 3] 3450         bne     L9E80  
   9E7D CE 04 05      [ 3] 3451         ldx     #0x0405
   9E80                    3452 L9E80:
   9E80 B6 02 99      [ 4] 3453         ldaa    (0x0299)
   9E83 A7 00         [ 4] 3454         staa    0,X     
   9E85 08            [ 3] 3455         inx
   9E86 B6 02 9A      [ 4] 3456         ldaa    (0x029A)
   9E89 A7 00         [ 4] 3457         staa    0,X     
   9E8B 08            [ 3] 3458         inx
   9E8C B6 02 9B      [ 4] 3459         ldaa    (0x029B)
   9E8F A7 00         [ 4] 3460         staa    0,X     
   9E91 39            [ 5] 3461         rts
                           3462 
                           3463 ; reset R counts
   9E92 86 30         [ 2] 3464         ldaa    #0x30        
   9E94 B7 04 02      [ 4] 3465         staa    (0x0402)
   9E97 B7 04 03      [ 4] 3466         staa    (0x0403)
   9E9A B7 04 04      [ 4] 3467         staa    (0x0404)
                           3468 
   9E9D BD 8D DD      [ 6] 3469         jsr     LCDMSG2 
   9EA0 52 65 67 20 23 20  3470         .ascis  'Reg # cleared!'
        63 6C 65 61 72 65
        64 A1
                           3471 
   9EAE 39            [ 5] 3472         rts
                           3473 
                           3474 ; reset L counts
   9EAF 86 30         [ 2] 3475         ldaa    #0x30
   9EB1 B7 04 05      [ 4] 3476         staa    (0x0405)
   9EB4 B7 04 06      [ 4] 3477         staa    (0x0406)
   9EB7 B7 04 07      [ 4] 3478         staa    (0x0407)
                           3479 
   9EBA BD 8D DD      [ 6] 3480         jsr     LCDMSG2 
   9EBD 4C 69 76 20 23 20  3481         .ascis  'Liv # cleared!'
        63 6C 65 61 72 65
        64 A1
                           3482 
   9ECB 39            [ 5] 3483         rts
                           3484 
                           3485 ; display R and L counts?
   9ECC 86 52         [ 2] 3486         ldaa    #0x52            ;'R'
   9ECE C6 2B         [ 2] 3487         ldab    #0x2B
   9ED0 BD 8D B5      [ 6] 3488         jsr     (0x8DB5)         ; display char here on LCD display
   9ED3 86 4C         [ 2] 3489         ldaa    #0x4C            ;'L'
   9ED5 C6 32         [ 2] 3490         ldab    #0x32
   9ED7 BD 8D B5      [ 6] 3491         jsr     (0x8DB5)         ; display char here on LCD display
   9EDA CE 04 02      [ 3] 3492         ldx     #0x0402
   9EDD C6 2C         [ 2] 3493         ldab    #0x2C
   9EDF                    3494 L9EDF:
   9EDF A6 00         [ 4] 3495         ldaa    0,X     
   9EE1 BD 8D B5      [ 6] 3496         jsr     (0x8DB5)         ; display 3 chars here on LCD display
   9EE4 5C            [ 2] 3497         incb
   9EE5 08            [ 3] 3498         inx
   9EE6 8C 04 05      [ 4] 3499         cpx     #0x0405
   9EE9 26 F4         [ 3] 3500         bne     L9EDF  
   9EEB C6 33         [ 2] 3501         ldab    #0x33
   9EED                    3502 L9EED:
   9EED A6 00         [ 4] 3503         ldaa    0,X     
   9EEF BD 8D B5      [ 6] 3504         jsr     (0x8DB5)         ; display 3 chars here on LCD display
   9EF2 5C            [ 2] 3505         incb
   9EF3 08            [ 3] 3506         inx
   9EF4 8C 04 08      [ 4] 3507         cpx     #0x0408
   9EF7 26 F4         [ 3] 3508         bne     L9EED  
   9EF9 39            [ 5] 3509         rts
                           3510 
   9EFA 96 A8         [ 3] 3511         ldaa    (0x00A8)
   9EFC BD 9F 0F      [ 6] 3512         jsr     (0x9F0F)
   9EFF 48            [ 2] 3513         asla
   9F00 48            [ 2] 3514         asla
   9F01 48            [ 2] 3515         asla
   9F02 48            [ 2] 3516         asla
   9F03 97 13         [ 3] 3517         staa    (0x0013)
   9F05 96 A9         [ 3] 3518         ldaa    (0x00A9)
   9F07 BD 9F 0F      [ 6] 3519         jsr     (0x9F0F)
   9F0A 9B 13         [ 3] 3520         adda    (0x0013)
   9F0C 97 A8         [ 3] 3521         staa    (0x00A8)
   9F0E 39            [ 5] 3522         rts
                           3523 
   9F0F 81 2F         [ 2] 3524         cmpa    #0x2F
   9F11 24 02         [ 3] 3525         bcc     L9F15  
   9F13 86 30         [ 2] 3526         ldaa    #0x30
   9F15                    3527 L9F15:
   9F15 81 3A         [ 2] 3528         cmpa    #0x3A
   9F17 25 02         [ 3] 3529         bcs     L9F1B  
   9F19 80 07         [ 2] 3530         suba    #0x07
   9F1B                    3531 L9F1B:
   9F1B 80 30         [ 2] 3532         suba    #0x30
   9F1D 39            [ 5] 3533         rts
                           3534 
   9F1E FC 02 9C      [ 5] 3535         ldd     (0x029C)
   9F21 1A 83 00 01   [ 5] 3536         cpd     #0x0001
   9F25 27 0C         [ 3] 3537         beq     L9F33  
   9F27 1A 83 03 E8   [ 5] 3538         cpd     #0x03E8
   9F2B 25 20         [ 3] 3539         bcs     L9F4D  
   9F2D 1A 83 04 4B   [ 5] 3540         cpd     #0x044B
   9F31 22 1A         [ 3] 3541         bhi     L9F4D  
                           3542 
   9F33                    3543 L9F33:
   9F33 BD 8D E4      [ 6] 3544         jsr     LCDMSG1 
   9F36 50 61 73 73 77 6F  3545         .ascis  'Password bypass '
        72 64 20 62 79 70
        61 73 73 A0
                           3546 
   9F46 C6 04         [ 2] 3547         ldab    #0x04
   9F48 BD 8C 30      [ 6] 3548         jsr     (0x8C30)
   9F4B 0C            [ 2] 3549         clc
   9F4C 39            [ 5] 3550         rts
                           3551 
   9F4D                    3552 L9F4D:
   9F4D BD 8C F2      [ 6] 3553         jsr     (0x8CF2)
   9F50 BD 8D 03      [ 6] 3554         jsr     (0x8D03)
                           3555 
   9F53 BD 8D E4      [ 6] 3556         jsr     LCDMSG1 
   9F56 43 6F 64 65 BA     3557         .ascis  'Code:'
                           3558 
   9F5B CE 02 90      [ 3] 3559         ldx     #0x0290
   9F5E 7F 00 16      [ 6] 3560         clr     (0x0016)
   9F61                    3561 L9F61:
   9F61 86 41         [ 2] 3562         ldaa    #0x41
   9F63                    3563 L9F63:
   9F63 97 15         [ 3] 3564         staa    (0x0015)
   9F65 BD 8E 95      [ 6] 3565         jsr     (0x8E95)
   9F68 81 0D         [ 2] 3566         cmpa    #0x0D
   9F6A 26 11         [ 3] 3567         bne     L9F7D  
   9F6C 96 15         [ 3] 3568         ldaa    (0x0015)
   9F6E A7 00         [ 4] 3569         staa    0,X     
   9F70 08            [ 3] 3570         inx
   9F71 BD 8C 98      [ 6] 3571         jsr     (0x8C98)
   9F74 96 16         [ 3] 3572         ldaa    (0x0016)
   9F76 4C            [ 2] 3573         inca
   9F77 97 16         [ 3] 3574         staa    (0x0016)
   9F79 81 05         [ 2] 3575         cmpa    #0x05
   9F7B 27 09         [ 3] 3576         beq     L9F86  
   9F7D                    3577 L9F7D:
   9F7D 96 15         [ 3] 3578         ldaa    (0x0015)
   9F7F 4C            [ 2] 3579         inca
   9F80 81 5B         [ 2] 3580         cmpa    #0x5B
   9F82 27 DD         [ 3] 3581         beq     L9F61  
   9F84 20 DD         [ 3] 3582         bra     L9F63  
                           3583 
   9F86                    3584 L9F86:
   9F86 BD 8D DD      [ 6] 3585         jsr     LCDMSG2 
   9F89 50 73 77 64 BA     3586         .ascis  'Pswd:'
                           3587 
   9F8E CE 02 88      [ 3] 3588         ldx     #0x0288
   9F91 86 41         [ 2] 3589         ldaa    #0x41
   9F93 97 16         [ 3] 3590         staa    (0x0016)
   9F95 86 C5         [ 2] 3591         ldaa    #0xC5
   9F97 97 15         [ 3] 3592         staa    (0x0015)
   9F99                    3593 L9F99:
   9F99 96 15         [ 3] 3594         ldaa    (0x0015)
   9F9B BD 8C 86      [ 6] 3595         jsr     (0x8C86)     ; write byte to LCD
   9F9E 96 16         [ 3] 3596         ldaa    (0x0016)
   9FA0 BD 8C 98      [ 6] 3597         jsr     (0x8C98)
   9FA3                    3598 L9FA3:
   9FA3 BD 8E 95      [ 6] 3599         jsr     (0x8E95)
   9FA6 27 FB         [ 3] 3600         beq     L9FA3  
   9FA8 81 0D         [ 2] 3601         cmpa    #0x0D
   9FAA 26 10         [ 3] 3602         bne     L9FBC  
   9FAC 96 16         [ 3] 3603         ldaa    (0x0016)
   9FAE A7 00         [ 4] 3604         staa    0,X     
   9FB0 08            [ 3] 3605         inx
   9FB1 96 15         [ 3] 3606         ldaa    (0x0015)
   9FB3 4C            [ 2] 3607         inca
   9FB4 97 15         [ 3] 3608         staa    (0x0015)
   9FB6 81 CA         [ 2] 3609         cmpa    #0xCA
   9FB8 27 28         [ 3] 3610         beq     L9FE2  
   9FBA 20 DD         [ 3] 3611         bra     L9F99  
   9FBC                    3612 L9FBC:
   9FBC 81 01         [ 2] 3613         cmpa    #0x01
   9FBE 26 0F         [ 3] 3614         bne     L9FCF  
   9FC0 96 16         [ 3] 3615         ldaa    (0x0016)
   9FC2 4C            [ 2] 3616         inca
   9FC3 97 16         [ 3] 3617         staa    (0x0016)
   9FC5 81 5B         [ 2] 3618         cmpa    #0x5B
   9FC7 26 D0         [ 3] 3619         bne     L9F99  
   9FC9 86 41         [ 2] 3620         ldaa    #0x41
   9FCB 97 16         [ 3] 3621         staa    (0x0016)
   9FCD 20 CA         [ 3] 3622         bra     L9F99  
   9FCF                    3623 L9FCF:
   9FCF 81 02         [ 2] 3624         cmpa    #0x02
   9FD1 26 D0         [ 3] 3625         bne     L9FA3  
   9FD3 96 16         [ 3] 3626         ldaa    (0x0016)
   9FD5 4A            [ 2] 3627         deca
   9FD6 97 16         [ 3] 3628         staa    (0x0016)
   9FD8 81 40         [ 2] 3629         cmpa    #0x40
   9FDA 26 BD         [ 3] 3630         bne     L9F99  
   9FDC 86 5A         [ 2] 3631         ldaa    #0x5A
   9FDE 97 16         [ 3] 3632         staa    (0x0016)
   9FE0 20 B7         [ 3] 3633         bra     L9F99  
   9FE2                    3634 L9FE2:
   9FE2 BD A0 01      [ 6] 3635         jsr     (0xA001)
   9FE5 25 0F         [ 3] 3636         bcs     L9FF6  
   9FE7 86 DB         [ 2] 3637         ldaa    #0xDB
   9FE9 97 AB         [ 3] 3638         staa    (0x00AB)
   9FEB FC 04 16      [ 5] 3639         ldd     (0x0416)
   9FEE C3 00 01      [ 4] 3640         addd    #0x0001
   9FF1 FD 04 16      [ 5] 3641         std     (0x0416)
   9FF4 0C            [ 2] 3642         clc
   9FF5 39            [ 5] 3643         rts
                           3644 
   9FF6                    3645 L9FF6:
   9FF6 FC 04 14      [ 5] 3646         ldd     (0x0414)
   9FF9 C3 00 01      [ 4] 3647         addd    #0x0001
   9FFC FD 04 14      [ 5] 3648         std     (0x0414)
   9FFF 0D            [ 2] 3649         sec
   A000 39            [ 5] 3650         rts
                           3651 
   A001 B6 02 90      [ 4] 3652         ldaa    (0x0290)
   A004 B7 02 81      [ 4] 3653         staa    (0x0281)
   A007 B6 02 91      [ 4] 3654         ldaa    (0x0291)
   A00A B7 02 83      [ 4] 3655         staa    (0x0283)
   A00D B6 02 92      [ 4] 3656         ldaa    (0x0292)
   A010 B7 02 84      [ 4] 3657         staa    (0x0284)
   A013 B6 02 93      [ 4] 3658         ldaa    (0x0293)
   A016 B7 02 80      [ 4] 3659         staa    (0x0280)
   A019 B6 02 94      [ 4] 3660         ldaa    (0x0294)
   A01C B7 02 82      [ 4] 3661         staa    (0x0282)
   A01F B6 02 80      [ 4] 3662         ldaa    (0x0280)
   A022 88 13         [ 2] 3663         eora    #0x13
   A024 8B 03         [ 2] 3664         adda    #0x03
   A026 B7 02 80      [ 4] 3665         staa    (0x0280)
   A029 B6 02 81      [ 4] 3666         ldaa    (0x0281)
   A02C 88 04         [ 2] 3667         eora    #0x04
   A02E 8B 12         [ 2] 3668         adda    #0x12
   A030 B7 02 81      [ 4] 3669         staa    (0x0281)
   A033 B6 02 82      [ 4] 3670         ldaa    (0x0282)
   A036 88 06         [ 2] 3671         eora    #0x06
   A038 8B 04         [ 2] 3672         adda    #0x04
   A03A B7 02 82      [ 4] 3673         staa    (0x0282)
   A03D B6 02 83      [ 4] 3674         ldaa    (0x0283)
   A040 88 11         [ 2] 3675         eora    #0x11
   A042 8B 07         [ 2] 3676         adda    #0x07
   A044 B7 02 83      [ 4] 3677         staa    (0x0283)
   A047 B6 02 84      [ 4] 3678         ldaa    (0x0284)
   A04A 88 01         [ 2] 3679         eora    #0x01
   A04C 8B 10         [ 2] 3680         adda    #0x10
   A04E B7 02 84      [ 4] 3681         staa    (0x0284)
   A051 BD A0 AF      [ 6] 3682         jsr     (0xA0AF)
   A054 B6 02 94      [ 4] 3683         ldaa    (0x0294)
   A057 84 17         [ 2] 3684         anda    #0x17
   A059 97 15         [ 3] 3685         staa    (0x0015)
   A05B B6 02 90      [ 4] 3686         ldaa    (0x0290)
   A05E 84 17         [ 2] 3687         anda    #0x17
   A060 97 16         [ 3] 3688         staa    (0x0016)
   A062 CE 02 80      [ 3] 3689         ldx     #0x0280
   A065                    3690 LA065:
   A065 A6 00         [ 4] 3691         ldaa    0,X     
   A067 98 15         [ 3] 3692         eora    (0x0015)
   A069 98 16         [ 3] 3693         eora    (0x0016)
   A06B A7 00         [ 4] 3694         staa    0,X     
   A06D 08            [ 3] 3695         inx
   A06E 8C 02 85      [ 4] 3696         cpx     #0x0285
   A071 26 F2         [ 3] 3697         bne     LA065  
   A073 BD A0 AF      [ 6] 3698         jsr     (0xA0AF)
   A076 CE 02 80      [ 3] 3699         ldx     #0x0280
   A079 18 CE 02 88   [ 4] 3700         ldy     #0x0288
   A07D                    3701 LA07D:
   A07D A6 00         [ 4] 3702         ldaa    0,X     
   A07F 18 A1 00      [ 5] 3703         cmpa    0,Y     
   A082 26 0A         [ 3] 3704         bne     LA08E  
   A084 08            [ 3] 3705         inx
   A085 18 08         [ 4] 3706         iny
   A087 8C 02 85      [ 4] 3707         cpx     #0x0285
   A08A 26 F1         [ 3] 3708         bne     LA07D  
   A08C 0C            [ 2] 3709         clc
   A08D 39            [ 5] 3710         rts
                           3711 
   A08E                    3712 LA08E:
   A08E 0D            [ 2] 3713         sec
   A08F 39            [ 5] 3714         rts
                           3715 
   A090                    3716 LA090:
   A090 59 41 44 44 41     3717         .ascii  'YADDA'
                           3718 
   A095 CE 02 88      [ 3] 3719         ldx     #0x0288
   A098 18 CE A0 90   [ 4] 3720         ldy     #LA090
   A09C                    3721 LA09C:
   A09C A6 00         [ 4] 3722         ldaa    0,X
   A09E 18 A1 00      [ 5] 3723         cmpa    0,Y
   A0A1 26 0A         [ 3] 3724         bne     LA0AD
   A0A3 08            [ 3] 3725         inx
   A0A4 18 08         [ 4] 3726         iny
   A0A6 8C 02 8D      [ 4] 3727         cpx     #0x028D
   A0A9 26 F1         [ 3] 3728         bne     LA09C
   A0AB 0C            [ 2] 3729         clc
   A0AC 39            [ 5] 3730         rts
   A0AD                    3731 LA0AD:
   A0AD 0D            [ 2] 3732         sec
   A0AE 39            [ 5] 3733         rts
                           3734 
   A0AF CE 02 80      [ 3] 3735         ldx     #0x0280
   A0B2                    3736 LA0B2:
   A0B2 A6 00         [ 4] 3737         ldaa    0,X     
   A0B4 81 5B         [ 2] 3738         cmpa    #0x5B
   A0B6 25 06         [ 3] 3739         bcs     LA0BE  
   A0B8 80 1A         [ 2] 3740         suba    #0x1A
   A0BA A7 00         [ 4] 3741         staa    0,X     
   A0BC 20 08         [ 3] 3742         bra     LA0C6  
   A0BE                    3743 LA0BE:
   A0BE 81 41         [ 2] 3744         cmpa    #0x41
   A0C0 24 04         [ 3] 3745         bcc     LA0C6  
   A0C2 8B 1A         [ 2] 3746         adda    #0x1A
   A0C4 A7 00         [ 4] 3747         staa    0,X     
   A0C6                    3748 LA0C6:
   A0C6 08            [ 3] 3749         inx
   A0C7 8C 02 85      [ 4] 3750         cpx     #0x0285
   A0CA 26 E6         [ 3] 3751         bne     LA0B2  
   A0CC 39            [ 5] 3752         rts
                           3753 
   A0CD BD 8C F2      [ 6] 3754         jsr     (0x8CF2)
                           3755 
   A0D0 BD 8D DD      [ 6] 3756         jsr     LCDMSG2 
   A0D3 46 61 69 6C 65 64  3757         .ascis  'Failed!         '
        21 20 20 20 20 20
        20 20 20 A0
                           3758 
   A0E3 C6 02         [ 2] 3759         ldab    #0x02
   A0E5 BD 8C 30      [ 6] 3760         jsr     (0x8C30)
   A0E8 39            [ 5] 3761         rts
                           3762 
   A0E9 C6 01         [ 2] 3763         ldab    #0x01
   A0EB BD 8C 30      [ 6] 3764         jsr     (0x8C30)
   A0EE 7F 00 4E      [ 6] 3765         clr     (0x004E)
   A0F1 C6 D3         [ 2] 3766         ldab    #0xD3
   A0F3 BD 87 48      [ 6] 3767         jsr     L8748   
   A0F6 BD 87 AE      [ 6] 3768         jsr     (0x87AE)
   A0F9 BD 8C E9      [ 6] 3769         jsr     (0x8CE9)
                           3770 
   A0FC BD 8D E4      [ 6] 3771         jsr     LCDMSG1 
   A0FF 20 20 20 56 43 52  3772         .ascis  '   VCR adjust'
        20 61 64 6A 75 73
        F4
                           3773 
   A10C BD 8D DD      [ 6] 3774         jsr     LCDMSG2 
   A10F 55 50 20 74 6F 20  3775         .ascis  'UP to clear bits'
        63 6C 65 61 72 20
        62 69 74 F3
                           3776 
   A11F 5F            [ 2] 3777         clrb
   A120 D7 62         [ 3] 3778         stab    (0x0062)
   A122 BD F9 C5      [ 6] 3779         jsr     BUTNLIT 
   A125 B6 18 04      [ 4] 3780         ldaa    PIA0PRA 
   A128 84 BF         [ 2] 3781         anda    #0xBF
   A12A B7 18 04      [ 4] 3782         staa    PIA0PRA 
   A12D BD 8E 95      [ 6] 3783         jsr     (0x8E95)
   A130 7F 00 48      [ 6] 3784         clr     (0x0048)
   A133 7F 00 49      [ 6] 3785         clr     (0x0049)
   A136 BD 86 C4      [ 6] 3786         jsr     L86C4
   A139 86 28         [ 2] 3787         ldaa    #0x28
   A13B 97 63         [ 3] 3788         staa    (0x0063)
   A13D C6 FD         [ 2] 3789         ldab    #0xFD
   A13F BD 86 E7      [ 6] 3790         jsr     (0x86E7)
   A142 BD A3 2E      [ 6] 3791         jsr     (0xA32E)
   A145 7C 00 76      [ 6] 3792         inc     (0x0076)
   A148 7F 00 32      [ 6] 3793         clr     (0x0032)
   A14B                    3794 LA14B:
   A14B BD 8E 95      [ 6] 3795         jsr     (0x8E95)
   A14E 81 0D         [ 2] 3796         cmpa    #0x0D
   A150 26 03         [ 3] 3797         bne     LA155  
   A152 7E A1 C4      [ 3] 3798         jmp     (0xA1C4)
   A155                    3799 LA155:
   A155 86 28         [ 2] 3800         ldaa    #0x28
   A157 97 63         [ 3] 3801         staa    (0x0063)
   A159 BD 86 A4      [ 6] 3802         jsr     (0x86A4)
   A15C 25 ED         [ 3] 3803         bcs     LA14B  
   A15E FC 04 1A      [ 5] 3804         ldd     (0x041A)
   A161 C3 00 01      [ 4] 3805         addd    #0x0001
   A164 FD 04 1A      [ 5] 3806         std     (0x041A)
   A167 BD 86 C4      [ 6] 3807         jsr     L86C4
   A16A 7C 00 4E      [ 6] 3808         inc     (0x004E)
   A16D C6 D3         [ 2] 3809         ldab    #0xD3
   A16F BD 87 48      [ 6] 3810         jsr     L8748   
   A172 BD 87 AE      [ 6] 3811         jsr     (0x87AE)
   A175 96 49         [ 3] 3812         ldaa    (0x0049)
   A177 81 43         [ 2] 3813         cmpa    #0x43
   A179 26 06         [ 3] 3814         bne     LA181  
   A17B 7F 00 49      [ 6] 3815         clr     (0x0049)
   A17E 7F 00 48      [ 6] 3816         clr     (0x0048)
   A181                    3817 LA181:
   A181 96 48         [ 3] 3818         ldaa    (0x0048)
   A183 81 C8         [ 2] 3819         cmpa    #0xC8
   A185 25 1F         [ 3] 3820         bcs     LA1A6  
   A187 FC 02 9C      [ 5] 3821         ldd     (0x029C)
   A18A 1A 83 00 01   [ 5] 3822         cpd     #0x0001
   A18E 27 16         [ 3] 3823         beq     LA1A6  
   A190 C6 EF         [ 2] 3824         ldab    #0xEF
   A192 BD 86 E7      [ 6] 3825         jsr     (0x86E7)
   A195 BD 86 C4      [ 6] 3826         jsr     L86C4
   A198 7F 00 4E      [ 6] 3827         clr     (0x004E)
   A19B 7F 00 76      [ 6] 3828         clr     (0x0076)
   A19E C6 0A         [ 2] 3829         ldab    #0x0A
   A1A0 BD 8C 30      [ 6] 3830         jsr     (0x8C30)
   A1A3 7E 81 D7      [ 3] 3831         jmp     (0x81D7)
   A1A6                    3832 LA1A6:
   A1A6 BD 8E 95      [ 6] 3833         jsr     (0x8E95)
   A1A9 81 01         [ 2] 3834         cmpa    #0x01
   A1AB 26 10         [ 3] 3835         bne     LA1BD  
   A1AD CE 10 80      [ 3] 3836         ldx     #0x1080
   A1B0 86 34         [ 2] 3837         ldaa    #0x34
   A1B2                    3838 LA1B2:
   A1B2 6F 00         [ 6] 3839         clr     0,X     
   A1B4 A7 01         [ 4] 3840         staa    1,X     
   A1B6 08            [ 3] 3841         inx
   A1B7 08            [ 3] 3842         inx
   A1B8 8C 10 A0      [ 4] 3843         cpx     #0x10A0
   A1BB 25 F5         [ 3] 3844         bcs     LA1B2  
   A1BD                    3845 LA1BD:
   A1BD 81 0D         [ 2] 3846         cmpa    #0x0D
   A1BF 27 03         [ 3] 3847         beq     LA1C4  
   A1C1 7E A1 75      [ 3] 3848         jmp     (0xA175)
   A1C4                    3849 LA1C4:
   A1C4 7F 00 76      [ 6] 3850         clr     (0x0076)
   A1C7 7F 00 4E      [ 6] 3851         clr     (0x004E)
   A1CA C6 DF         [ 2] 3852         ldab    #0xDF
   A1CC BD 87 48      [ 6] 3853         jsr     L8748   
   A1CF BD 87 91      [ 6] 3854         jsr     L8791   
   A1D2 7E 81 D7      [ 3] 3855         jmp     (0x81D7)
   A1D5 86 07         [ 2] 3856         ldaa    #0x07
   A1D7 B7 04 00      [ 4] 3857         staa    (0x0400)
   A1DA CC 0E 09      [ 3] 3858         ldd     #0x0E09
   A1DD 81 65         [ 2] 3859         cmpa    #0x65
   A1DF 26 05         [ 3] 3860         bne     LA1E6  
   A1E1 C1 63         [ 2] 3861         cmpb    #0x63
   A1E3 26 01         [ 3] 3862         bne     LA1E6  
   A1E5 39            [ 5] 3863         rts
                           3864 
   A1E6                    3865 LA1E6:
   A1E6 86 0E         [ 2] 3866         ldaa    #0x0E
   A1E8 B7 10 3B      [ 4] 3867         staa    PPROG  
   A1EB 86 FF         [ 2] 3868         ldaa    #0xFF
   A1ED B7 0E 00      [ 4] 3869         staa    (0x0E00)
   A1F0 B6 10 3B      [ 4] 3870         ldaa    PPROG  
   A1F3 8A 01         [ 2] 3871         oraa    #0x01
   A1F5 B7 10 3B      [ 4] 3872         staa    PPROG  
   A1F8 CE 1B 58      [ 3] 3873         ldx     #0x1B58
   A1FB                    3874 LA1FB:
   A1FB 09            [ 3] 3875         dex
   A1FC 26 FD         [ 3] 3876         bne     LA1FB  
   A1FE B6 10 3B      [ 4] 3877         ldaa    PPROG  
   A201 84 FE         [ 2] 3878         anda    #0xFE
   A203 B7 10 3B      [ 4] 3879         staa    PPROG  
   A206 CE 0E 00      [ 3] 3880         ldx     #0x0E00
   A209 18 CE A2 26   [ 4] 3881         ldy     #0xA226
   A20D                    3882 LA20D:
   A20D C6 02         [ 2] 3883         ldab    #0x02
   A20F F7 10 3B      [ 4] 3884         stab    PPROG  
   A212 18 A6 00      [ 5] 3885         ldaa    0,Y     
   A215 18 08         [ 4] 3886         iny
   A217 A7 00         [ 4] 3887         staa    0,X     
   A219 BD A2 32      [ 6] 3888         jsr     (0xA232)
   A21C 08            [ 3] 3889         inx
   A21D 8C 0E 0C      [ 4] 3890         cpx     #0x0E0C
   A220 26 EB         [ 3] 3891         bne     LA20D  
   A222 7F 10 3B      [ 6] 3892         clr     PPROG  
   A225 39            [ 5] 3893         rts
                           3894 
                           3895 ; data
   A226 29 64 2A 21 32 3A  3896         .ascii  ')d*!2::4!ecq'
        3A 34 21 65 63 71
                           3897 
                           3898 ; program EEPROM
   A232 18 3C         [ 5] 3899         pshy
   A234 C6 03         [ 2] 3900         ldab    #0x03
   A236 F7 10 3B      [ 4] 3901         stab    PPROG       ; start program
   A239 18 CE 1B 58   [ 4] 3902         ldy     #0x1B58
   A23D                    3903 LA23D:
   A23D 18 09         [ 4] 3904         dey
   A23F 26 FC         [ 3] 3905         bne     LA23D  
   A241 C6 02         [ 2] 3906         ldab    #0x02
   A243 F7 10 3B      [ 4] 3907         stab    PPROG       ; stop program
   A246 18 38         [ 6] 3908         puly
   A248 39            [ 5] 3909         rts
                           3910 
   A249 0F            [ 2] 3911         sei
   A24A CE 00 10      [ 3] 3912         ldx     #0x0010
   A24D                    3913 LA24D:
   A24D 6F 00         [ 6] 3914         clr     0,X     
   A24F 08            [ 3] 3915         inx
   A250 8C 0E 00      [ 4] 3916         cpx     #0x0E00
   A253 26 F8         [ 3] 3917         bne     LA24D  
   A255 BD 9E AF      [ 6] 3918         jsr     (0x9EAF)     ; reset L counts
   A258 BD 9E 92      [ 6] 3919         jsr     (0x9E92)     ; reset R counts
   A25B 7E F8 00      [ 3] 3920         jmp     RESET     ; reset controller
                           3921 
                           3922 ; Compute and store copyright checksum
   A25E                    3923 LA25E:
   A25E 18 CE 80 03   [ 4] 3924         ldy     #CPYRTMSG       ; copyright message
   A262 CE 00 00      [ 3] 3925         ldx     #0x0000
   A265                    3926 LA265:
   A265 18 E6 00      [ 5] 3927         ldab    0,Y
   A268 3A            [ 3] 3928         abx
   A269 18 08         [ 4] 3929         iny
   A26B 18 8C 80 50   [ 5] 3930         cpy     #0x8050
   A26F 26 F4         [ 3] 3931         bne     LA265
   A271 FF 04 0B      [ 5] 3932         stx     CPYRTCS         ; store checksum here
   A274 39            [ 5] 3933         rts
                           3934 
                           3935 ; Erase EEPROM routine
   A275                    3936 LA275:
   A275 0F            [ 2] 3937         sei
   A276 7F 04 0F      [ 6] 3938         clr     ERASEFLG     ; Reset EEPROM Erase flag
   A279 86 0E         [ 2] 3939         ldaa    #0x0E
   A27B B7 10 3B      [ 4] 3940         staa    PPROG       ; ERASE mode!
   A27E 86 FF         [ 2] 3941         ldaa    #0xFF
   A280 B7 0E 20      [ 4] 3942         staa    (0x0E20)    ; save in NVRAM
   A283 B6 10 3B      [ 4] 3943         ldaa    PPROG  
   A286 8A 01         [ 2] 3944         oraa    #0x01
   A288 B7 10 3B      [ 4] 3945         staa    PPROG       ; do the ERASE
   A28B CE 1B 58      [ 3] 3946         ldx     #0x1B58       ; delay a bit
   A28E                    3947 LA28E:
   A28E 09            [ 3] 3948         dex
   A28F 26 FD         [ 3] 3949         bne     LA28E  
   A291 B6 10 3B      [ 4] 3950         ldaa    PPROG  
   A294 84 FE         [ 2] 3951         anda    #0xFE        ; stop erasing
   A296 7F 10 3B      [ 6] 3952         clr     PPROG  
                           3953 
   A299 BD F9 D8      [ 6] 3954         jsr     SERMSGW           ; display "enter serial number"
   A29C 45 6E 74 65 72 20  3955         .ascis  'Enter serial #: '
        73 65 72 69 61 6C
        20 23 3A A0
                           3956 
   A2AC CE 0E 20      [ 3] 3957         ldx     #0x0E20
   A2AF                    3958 LA2AF:
   A2AF BD F9 45      [ 6] 3959         jsr     SERIALR     ; wait for serial data
   A2B2 24 FB         [ 3] 3960         bcc     LA2AF  
                           3961 
   A2B4 BD F9 6F      [ 6] 3962         jsr     SERIALW     ; read serial data
   A2B7 C6 02         [ 2] 3963         ldab    #0x02
   A2B9 F7 10 3B      [ 4] 3964         stab    PPROG       ; protect only 0x0e20-0x0e5f
   A2BC A7 00         [ 4] 3965         staa    0,X         
   A2BE BD A2 32      [ 6] 3966         jsr     (0xA232)     ; program byte
   A2C1 08            [ 3] 3967         inx
   A2C2 8C 0E 24      [ 4] 3968         cpx     #0x0E24
   A2C5 26 E8         [ 3] 3969         bne     LA2AF  
   A2C7 C6 02         [ 2] 3970         ldab    #0x02
   A2C9 F7 10 3B      [ 4] 3971         stab    PPROG  
   A2CC 86 DB         [ 2] 3972         ldaa    #0xDB        ; it's official
   A2CE B7 0E 24      [ 4] 3973         staa    (0x0E24)
   A2D1 BD A2 32      [ 6] 3974         jsr     (0xA232)     ; program byte
   A2D4 7F 10 3B      [ 6] 3975         clr     PPROG  
   A2D7 86 1E         [ 2] 3976         ldaa    #0x1E
   A2D9 B7 10 35      [ 4] 3977         staa    BPROT       ; protect all but 0x0e00-0x0e1f
   A2DC 7E F8 00      [ 3] 3978         jmp     RESET     ; reset controller
                           3979 
   A2DF 38            [ 5] 3980         pulx
   A2E0 3C            [ 4] 3981         pshx
   A2E1 8C 80 00      [ 4] 3982         cpx     #0x8000
   A2E4 25 02         [ 3] 3983         bcs     LA2E8  
   A2E6 0C            [ 2] 3984         clc
   A2E7 39            [ 5] 3985         rts
                           3986 
   A2E8                    3987 LA2E8:
   A2E8 0D            [ 2] 3988         sec
   A2E9 39            [ 5] 3989         rts
                           3990 
                           3991 ; enter and validate security code
   A2EA                    3992 LA2EA:
   A2EA CE 02 88      [ 3] 3993         ldx     #0x0288
   A2ED C6 03         [ 2] 3994         ldab    #0x03       ; 3 character code
                           3995 
   A2EF                    3996 LA2EF:
   A2EF BD F9 45      [ 6] 3997         jsr     SERIALR     ; check if available
   A2F2 24 FB         [ 3] 3998         bcc     LA2EF  
   A2F4 A7 00         [ 4] 3999         staa    0,X     
   A2F6 08            [ 3] 4000         inx
   A2F7 5A            [ 2] 4001         decb
   A2F8 26 F5         [ 3] 4002         bne     LA2EF  
                           4003 
   A2FA B6 02 88      [ 4] 4004         ldaa    (0x0288)
   A2FD 81 13         [ 2] 4005         cmpa    #0x13        ; 0x13
   A2FF 26 10         [ 3] 4006         bne     LA311  
   A301 B6 02 89      [ 4] 4007         ldaa    (0x0289)
   A304 81 10         [ 2] 4008         cmpa    #0x10        ; 0x10
   A306 26 09         [ 3] 4009         bne     LA311  
   A308 B6 02 8A      [ 4] 4010         ldaa    (0x028A)
   A30B 81 14         [ 2] 4011         cmpa    #0x14        ; 0x14
   A30D 26 02         [ 3] 4012         bne     LA311  
   A30F 0C            [ 2] 4013         clc
   A310 39            [ 5] 4014         rts
                           4015 
   A311                    4016 LA311:
   A311 0D            [ 2] 4017         sec
   A312 39            [ 5] 4018         rts
                           4019 
   A313 36            [ 3] 4020         psha
   A314 B6 10 92      [ 4] 4021         ldaa    (0x1092)
   A317 8A 01         [ 2] 4022         oraa    #0x01
   A319                    4023 LA319:
   A319 B7 10 92      [ 4] 4024         staa    (0x1092)
   A31C 32            [ 4] 4025         pula
   A31D 39            [ 5] 4026         rts
                           4027 
   A31E 36            [ 3] 4028         psha
   A31F B6 10 92      [ 4] 4029         ldaa    (0x1092)
   A322 84 FE         [ 2] 4030         anda    #0xFE
   A324 20 F3         [ 3] 4031         bra     LA319  
   A326 96 4E         [ 3] 4032         ldaa    (0x004E)
   A328 97 19         [ 3] 4033         staa    (0x0019)
   A32A 7F 00 4E      [ 6] 4034         clr     (0x004E)
   A32D 39            [ 5] 4035         rts
                           4036 
   A32E B6 10 86      [ 4] 4037         ldaa    (0x1086)
   A331 8A 15         [ 2] 4038         oraa    #0x15
   A333 B7 10 86      [ 4] 4039         staa    (0x1086)
   A336 C6 01         [ 2] 4040         ldab    #0x01
   A338 BD 8C 30      [ 6] 4041         jsr     (0x8C30)
   A33B 84 EA         [ 2] 4042         anda    #0xEA
   A33D B7 10 86      [ 4] 4043         staa    (0x1086)
   A340 39            [ 5] 4044         rts
                           4045 
   A341 B6 10 86      [ 4] 4046         ldaa    (0x1086)
   A344 8A 2A         [ 2] 4047         oraa    #0x2A
   A346 B7 10 86      [ 4] 4048         staa    (0x1086)
   A349 C6 01         [ 2] 4049         ldab    #0x01
   A34B BD 8C 30      [ 6] 4050         jsr     (0x8C30)
   A34E 84 D5         [ 2] 4051         anda    #0xD5
   A350 B7 10 86      [ 4] 4052         staa    (0x1086)
   A353 39            [ 5] 4053         rts
                           4054 
   A354 F6 18 04      [ 4] 4055         ldab    PIA0PRA 
   A357 CA 08         [ 2] 4056         orab    #0x08
   A359 F7 18 04      [ 4] 4057         stab    PIA0PRA 
   A35C 39            [ 5] 4058         rts
                           4059 
   A35D F6 18 04      [ 4] 4060         ldab    PIA0PRA 
   A360 C4 F7         [ 2] 4061         andb    #0xF7
   A362 F7 18 04      [ 4] 4062         stab    PIA0PRA 
   A365 39            [ 5] 4063         rts
                           4064 
                           4065 ;'$' command goes here?
   A366                    4066 LA366:
   A366 7F 00 4E      [ 6] 4067         clr     (0x004E)
   A369 BD 86 C4      [ 6] 4068         jsr     L86C4
   A36C 7F 04 2A      [ 6] 4069         clr     (0x042A)
                           4070 
   A36F BD F9 D8      [ 6] 4071         jsr     SERMSGW      
   A372 45 6E 74 65 72 20  4072         .ascis  'Enter security code:' 
        73 65 63 75 72 69
        74 79 20 63 6F 64
        65 BA
                           4073 
   A386 BD A2 EA      [ 6] 4074         jsr     LA2EA
   A389 24 03         [ 3] 4075         bcc     LA38E  
   A38B 7E 83 31      [ 3] 4076         jmp     (0x8331)
                           4077 
   A38E                    4078 LA38E:
   A38E BD F9 D8      [ 6] 4079         jsr     SERMSGW      
   A391 0C 0A 0D 44 61 76  4080         .ascii  "\f\n\rDave's Setup Utility\n\r"
        65 27 73 20 53 65
        74 75 70 20 55 74
        69 6C 69 74 79 0A
        0D
   A3AA 3C 4B 3E 69 6E 67  4081         .ascii  '<K>ing enable\n\r'
        20 65 6E 61 62 6C
        65 0A 0D
   A3B9 3C 43 3E 6C 65 61  4082         .ascii  '<C>lear random\n\r'
        72 20 72 61 6E 64
        6F 6D 0A 0D
   A3C9 3C 35 3E 20 63 68  4083         .ascii  '<5> character random\n\r'
        61 72 61 63 74 65
        72 20 72 61 6E 64
        6F 6D 0A 0D
   A3DF 3C 4C 3E 69 76 65  4084         .ascii  '<L>ive tape number clear\n\r'
        20 74 61 70 65 20
        6E 75 6D 62 65 72
        20 63 6C 65 61 72
        0A 0D
   A3F9 3C 52 3E 65 67 75  4085         .ascii  '<R>egular tape number clear\n\r'
        6C 61 72 20 74 61
        70 65 20 6E 75 6D
        62 65 72 20 63 6C
        65 61 72 0A 0D
   A416 3C 54 3E 65 73 74  4086         .ascii  '<T>est driver boards\n\r'
        20 64 72 69 76 65
        72 20 62 6F 61 72
        64 73 0A 0D
   A42C 3C 42 3E 75 62 20  4087         .ascii  '<B>ub test\n\r'
        74 65 73 74 0A 0D
   A438 3C 44 3E 65 63 6B  4088         .ascii  '<D>eck test (with tape inserted)\n\r'
        20 74 65 73 74 20
        28 77 69 74 68 20
        74 61 70 65 20 69
        6E 73 65 72 74 65
        64 29 0A 0D
   A45A 3C 37 3E 35 25 20  4089         .ascii  '<7>5% adjustment\n\r'
        61 64 6A 75 73 74
        6D 65 6E 74 0A 0D
   A46C 3C 53 3E 68 6F 77  4090         .ascii  '<S>how re-valid tapes\n\r'
        20 72 65 2D 76 61
        6C 69 64 20 74 61
        70 65 73 0A 0D
   A483 3C 4A 3E 75 6D 70  4091         .ascis  '<J>ump to system\n\r'
        20 74 6F 20 73 79
        73 74 65 6D 0A 8D
                           4092 
   A495                    4093 LA495:
   A495 BD F9 45      [ 6] 4094         jsr     SERIALR     
   A498 24 FB         [ 3] 4095         bcc     LA495  
   A49A 81 43         [ 2] 4096         cmpa    #0x43        ;'C'
   A49C 26 09         [ 3] 4097         bne     LA4A7  
   A49E 7F 04 01      [ 6] 4098         clr     (0x0401)     ;clear random
   A4A1 7F 04 2B      [ 6] 4099         clr     (0x042B)
   A4A4 7E A5 14      [ 3] 4100         jmp     (0xA514)
   A4A7                    4101 LA4A7:
   A4A7 81 35         [ 2] 4102         cmpa    #0x35        ;'5'
   A4A9 26 0D         [ 3] 4103         bne     LA4B8  
   A4AB B6 04 01      [ 4] 4104         ldaa    (0x0401)    ;5 character random
   A4AE 84 7F         [ 2] 4105         anda    #0x7F
   A4B0 8A 7F         [ 2] 4106         oraa    #0x7F
   A4B2 B7 04 01      [ 4] 4107         staa    (0x0401)
   A4B5 7E A5 14      [ 3] 4108         jmp     (0xA514)
   A4B8                    4109 LA4B8:
   A4B8 81 4C         [ 2] 4110         cmpa    #0x4C        ;'L'
   A4BA 26 06         [ 3] 4111         bne     LA4C2  
   A4BC BD 9E AF      [ 6] 4112         jsr     (0x9EAF)     ; reset Liv counts
   A4BF 7E A5 14      [ 3] 4113         jmp     (0xA514)
   A4C2                    4114 LA4C2:
   A4C2 81 52         [ 2] 4115         cmpa    #0x52        ;'R'
   A4C4 26 06         [ 3] 4116         bne     LA4CC  
   A4C6 BD 9E 92      [ 6] 4117         jsr     (0x9E92)     ; reset Reg counts
   A4C9 7E A5 14      [ 3] 4118         jmp     (0xA514)
   A4CC                    4119 LA4CC:
   A4CC 81 54         [ 2] 4120         cmpa    #0x54        ;'T'
   A4CE 26 06         [ 3] 4121         bne     LA4D6  
   A4D0 BD A5 65      [ 6] 4122         jsr     (0xA565)     ;test driver boards
   A4D3 7E A5 14      [ 3] 4123         jmp     (0xA514)
   A4D6                    4124 LA4D6:
   A4D6 81 42         [ 2] 4125         cmpa    #0x42        ;'B'
   A4D8 26 06         [ 3] 4126         bne     LA4E0  
   A4DA BD A5 26      [ 6] 4127         jsr     (0xA526)     ;bulb test?
   A4DD 7E A5 14      [ 3] 4128         jmp     (0xA514)
   A4E0                    4129 LA4E0:
   A4E0 81 44         [ 2] 4130         cmpa    #0x44        ;'D'
   A4E2 26 06         [ 3] 4131         bne     LA4EA  
   A4E4 BD A5 3C      [ 6] 4132         jsr     (0xA53C)     ;deck test
   A4E7 7E A5 14      [ 3] 4133         jmp     (0xA514)
   A4EA                    4134 LA4EA:
   A4EA 81 37         [ 2] 4135         cmpa    #0x37        ;'7'
   A4EC 26 08         [ 3] 4136         bne     LA4F6  
   A4EE C6 FB         [ 2] 4137         ldab    #0xFB
   A4F0 BD 86 E7      [ 6] 4138         jsr     (0x86E7)     ;5% adjustment
   A4F3 7E A5 14      [ 3] 4139         jmp     (0xA514)
   A4F6                    4140 LA4F6:
   A4F6 81 4A         [ 2] 4141         cmpa    #0x4A        ;'J'
   A4F8 26 03         [ 3] 4142         bne     LA4FD  
   A4FA 7E F8 00      [ 3] 4143         jmp     RESET     ;jump to system (reset)
   A4FD                    4144 LA4FD:
   A4FD 81 4B         [ 2] 4145         cmpa    #0x4B        ;'K'
   A4FF 26 06         [ 3] 4146         bne     LA507  
   A501 7C 04 2A      [ 6] 4147         inc     (0x042A)     ;King enable
   A504 7E A5 14      [ 3] 4148         jmp     (0xA514)
   A507                    4149 LA507:
   A507 81 53         [ 2] 4150         cmpa    #0x53        ;'S'
   A509 26 06         [ 3] 4151         bne     LA511  
   A50B BD AB 7C      [ 6] 4152         jsr     (0xAB7C)     ;show re-valid tapes
   A50E 7E A5 14      [ 3] 4153         jmp     (0xA514)
   A511                    4154 LA511:
   A511 7E A4 95      [ 3] 4155         jmp     (0xA495)
   A514 86 07         [ 2] 4156         ldaa    #0x07
   A516 BD F9 6F      [ 6] 4157         jsr     SERIALW      
   A519 C6 01         [ 2] 4158         ldab    #0x01
   A51B BD 8C 30      [ 6] 4159         jsr     (0x8C30)
   A51E 86 07         [ 2] 4160         ldaa    #0x07
   A520 BD F9 6F      [ 6] 4161         jsr     SERIALW      
   A523 7E A3 8E      [ 3] 4162         jmp     (0xA38E)
                           4163 
                           4164 ; bulb test
   A526 5F            [ 2] 4165         clrb
   A527 BD F9 C5      [ 6] 4166         jsr     BUTNLIT 
   A52A                    4167 LA52A:
   A52A F6 10 0A      [ 4] 4168         ldab    PORTE
   A52D C8 FF         [ 2] 4169         eorb    #0xFF
   A52F BD F9 C5      [ 6] 4170         jsr     BUTNLIT 
   A532 C1 80         [ 2] 4171         cmpb    #0x80
   A534 26 F4         [ 3] 4172         bne     LA52A  
   A536 C6 02         [ 2] 4173         ldab    #0x02
   A538 BD 8C 30      [ 6] 4174         jsr     (0x8C30)
   A53B 39            [ 5] 4175         rts
                           4176 
                           4177 ; deck test
   A53C C6 FD         [ 2] 4178         ldab    #0xFD
   A53E BD 86 E7      [ 6] 4179         jsr     (0x86E7)
   A541 C6 06         [ 2] 4180         ldab    #0x06
   A543 BD 8C 30      [ 6] 4181         jsr     (0x8C30)
   A546 C6 FB         [ 2] 4182         ldab    #0xFB
   A548 BD 86 E7      [ 6] 4183         jsr     (0x86E7)
   A54B C6 06         [ 2] 4184         ldab    #0x06
   A54D BD 8C 30      [ 6] 4185         jsr     (0x8C30)
   A550 C6 FD         [ 2] 4186         ldab    #0xFD
   A552 BD 86 E7      [ 6] 4187         jsr     (0x86E7)
   A555 C6 F7         [ 2] 4188         ldab    #0xF7
   A557 BD 86 E7      [ 6] 4189         jsr     (0x86E7)
   A55A C6 06         [ 2] 4190         ldab    #0x06
   A55C BD 8C 30      [ 6] 4191         jsr     (0x8C30)
   A55F C6 EF         [ 2] 4192         ldab    #0xEF
   A561 BD 86 E7      [ 6] 4193         jsr     (0x86E7)
   A564 39            [ 5] 4194         rts
                           4195 
                           4196 ; test driver boards
   A565 BD F9 45      [ 6] 4197         jsr     SERIALR     
   A568 24 08         [ 3] 4198         bcc     LA572  
   A56A 81 1B         [ 2] 4199         cmpa    #0x1B
   A56C 26 04         [ 3] 4200         bne     LA572  
   A56E BD 86 C4      [ 6] 4201         jsr     L86C4
   A571 39            [ 5] 4202         rts
   A572                    4203 LA572:
   A572 86 08         [ 2] 4204         ldaa    #0x08
   A574 97 15         [ 3] 4205         staa    (0x0015)
   A576 BD 86 C4      [ 6] 4206         jsr     L86C4
   A579 86 01         [ 2] 4207         ldaa    #0x01
   A57B                    4208 LA57B:
   A57B 36            [ 3] 4209         psha
   A57C 16            [ 2] 4210         tab
   A57D BD F9 C5      [ 6] 4211         jsr     BUTNLIT 
   A580 B6 18 04      [ 4] 4212         ldaa    PIA0PRA 
   A583 88 08         [ 2] 4213         eora    #0x08
   A585 B7 18 04      [ 4] 4214         staa    PIA0PRA 
   A588 32            [ 4] 4215         pula
   A589 B7 10 80      [ 4] 4216         staa    (0x1080)
   A58C B7 10 84      [ 4] 4217         staa    (0x1084)
   A58F B7 10 88      [ 4] 4218         staa    (0x1088)
   A592 B7 10 8C      [ 4] 4219         staa    (0x108C)
   A595 B7 10 90      [ 4] 4220         staa    (0x1090)
   A598 B7 10 94      [ 4] 4221         staa    (0x1094)
   A59B B7 10 98      [ 4] 4222         staa    (0x1098)
   A59E B7 10 9C      [ 4] 4223         staa    (0x109C)
   A5A1 C6 14         [ 2] 4224         ldab    #0x14
   A5A3 BD A6 52      [ 6] 4225         jsr     (0xA652)
   A5A6 49            [ 2] 4226         rola
   A5A7 36            [ 3] 4227         psha
   A5A8 D6 15         [ 3] 4228         ldab    (0x0015)
   A5AA 5A            [ 2] 4229         decb
   A5AB D7 15         [ 3] 4230         stab    (0x0015)
   A5AD BD F9 95      [ 6] 4231         jsr     DIAGDGT          ; write digit to the diag display
   A5B0 37            [ 3] 4232         pshb
   A5B1 C6 27         [ 2] 4233         ldab    #0x27
   A5B3 96 15         [ 3] 4234         ldaa    (0x0015)
   A5B5 0C            [ 2] 4235         clc
   A5B6 89 30         [ 2] 4236         adca    #0x30
   A5B8 BD 8D B5      [ 6] 4237         jsr     (0x8DB5)         ; display char here on LCD display
   A5BB 33            [ 4] 4238         pulb
   A5BC 32            [ 4] 4239         pula
   A5BD 5D            [ 2] 4240         tstb
   A5BE 26 BB         [ 3] 4241         bne     LA57B  
   A5C0 86 08         [ 2] 4242         ldaa    #0x08
   A5C2 97 15         [ 3] 4243         staa    (0x0015)
   A5C4 BD 86 C4      [ 6] 4244         jsr     L86C4
   A5C7 86 01         [ 2] 4245         ldaa    #0x01
   A5C9                    4246 LA5C9:
   A5C9 B7 10 82      [ 4] 4247         staa    (0x1082)
   A5CC B7 10 86      [ 4] 4248         staa    (0x1086)
   A5CF B7 10 8A      [ 4] 4249         staa    (0x108A)
   A5D2 B7 10 8E      [ 4] 4250         staa    (0x108E)
   A5D5 B7 10 92      [ 4] 4251         staa    (0x1092)
   A5D8 B7 10 96      [ 4] 4252         staa    (0x1096)
   A5DB B7 10 9A      [ 4] 4253         staa    (0x109A)
   A5DE B7 10 9E      [ 4] 4254         staa    (0x109E)
   A5E1 C6 14         [ 2] 4255         ldab    #0x14
   A5E3 BD A6 52      [ 6] 4256         jsr     (0xA652)
   A5E6 49            [ 2] 4257         rola
   A5E7 36            [ 3] 4258         psha
   A5E8 D6 15         [ 3] 4259         ldab    (0x0015)
   A5EA 5A            [ 2] 4260         decb
   A5EB D7 15         [ 3] 4261         stab    (0x0015)
   A5ED BD F9 95      [ 6] 4262         jsr     DIAGDGT           ; write digit to the diag display
   A5F0 37            [ 3] 4263         pshb
   A5F1 C6 27         [ 2] 4264         ldab    #0x27
   A5F3 96 15         [ 3] 4265         ldaa    (0x0015)
   A5F5 0C            [ 2] 4266         clc
   A5F6 89 30         [ 2] 4267         adca    #0x30
   A5F8 BD 8D B5      [ 6] 4268         jsr     (0x8DB5)         ; display char here on LCD display
   A5FB 33            [ 4] 4269         pulb
   A5FC 32            [ 4] 4270         pula
   A5FD 7D 00 15      [ 6] 4271         tst     (0x0015)
   A600 26 C7         [ 3] 4272         bne     LA5C9  
   A602 BD 86 C4      [ 6] 4273         jsr     L86C4
   A605 CE 10 80      [ 3] 4274         ldx     #0x1080
   A608 C6 00         [ 2] 4275         ldab    #0x00
   A60A                    4276 LA60A:
   A60A 86 FF         [ 2] 4277         ldaa    #0xFF
   A60C A7 00         [ 4] 4278         staa    0,X     
   A60E A7 02         [ 4] 4279         staa    2,X     
   A610 37            [ 3] 4280         pshb
   A611 C6 1E         [ 2] 4281         ldab    #0x1E
   A613 BD A6 52      [ 6] 4282         jsr     (0xA652)
   A616 33            [ 4] 4283         pulb
   A617 86 00         [ 2] 4284         ldaa    #0x00
   A619 A7 00         [ 4] 4285         staa    0,X     
   A61B A7 02         [ 4] 4286         staa    2,X     
   A61D 5C            [ 2] 4287         incb
   A61E 3C            [ 4] 4288         pshx
   A61F BD F9 95      [ 6] 4289         jsr     DIAGDGT               ; write digit to the diag display
   A622 37            [ 3] 4290         pshb
   A623 C6 27         [ 2] 4291         ldab    #0x27
   A625 32            [ 4] 4292         pula
   A626 36            [ 3] 4293         psha
   A627 0C            [ 2] 4294         clc
   A628 89 30         [ 2] 4295         adca    #0x30
   A62A BD 8D B5      [ 6] 4296         jsr     (0x8DB5)         ; display char here on LCD display
   A62D 33            [ 4] 4297         pulb
   A62E 38            [ 5] 4298         pulx
   A62F 08            [ 3] 4299         inx
   A630 08            [ 3] 4300         inx
   A631 08            [ 3] 4301         inx
   A632 08            [ 3] 4302         inx
   A633 8C 10 9D      [ 4] 4303         cpx     #0x109D
   A636 25 D2         [ 3] 4304         bcs     LA60A  
   A638 CE 10 80      [ 3] 4305         ldx     #0x1080
   A63B                    4306 LA63B:
   A63B 86 FF         [ 2] 4307         ldaa    #0xFF
   A63D A7 00         [ 4] 4308         staa    0,X     
   A63F A7 02         [ 4] 4309         staa    2,X     
   A641 08            [ 3] 4310         inx
   A642 08            [ 3] 4311         inx
   A643 08            [ 3] 4312         inx
   A644 08            [ 3] 4313         inx
   A645 8C 10 9D      [ 4] 4314         cpx     #0x109D
   A648 25 F1         [ 3] 4315         bcs     LA63B  
   A64A C6 06         [ 2] 4316         ldab    #0x06
   A64C BD 8C 30      [ 6] 4317         jsr     (0x8C30)
   A64F 7E A5 65      [ 3] 4318         jmp     (0xA565)
   A652 36            [ 3] 4319         psha
   A653 4F            [ 2] 4320         clra
   A654 DD 23         [ 4] 4321         std     CDTIMR5
   A656                    4322 LA656:
   A656 7D 00 24      [ 6] 4323         tst     CDTIMR5+1
   A659 26 FB         [ 3] 4324         bne     LA656  
   A65B 32            [ 4] 4325         pula
   A65C 39            [ 5] 4326         rts
                           4327 
                           4328 ; Comma-seperated text
   A65D                    4329 LA65D:
   A65D 30 2C 43 68 75 63  4330         .ascii  '0,Chuck,Mouth,'
        6B 2C 4D 6F 75 74
        68 2C
   A66B 31 2C 48 65 61 64  4331         .ascii  '1,Head left,'
        20 6C 65 66 74 2C
   A677 32 2C 48 65 61 64  4332         .ascii  '2,Head right,'
        20 72 69 67 68 74
        2C
   A684 32 2C 48 65 61 64  4333         .ascii  '2,Head up,'
        20 75 70 2C
   A68E 32 2C 45 79 65 73  4334         .ascii  '2,Eyes right,'
        20 72 69 67 68 74
        2C
   A69B 31 2C 45 79 65 6C  4335         .ascii  '1,Eyelids,'
        69 64 73 2C
   A6A5 31 2C 52 69 67 68  4336         .ascii  '1,Right hand,'
        74 20 68 61 6E 64
        2C
   A6B2 32 2C 45 79 65 73  4337         .ascii  '2,Eyes left,'
        20 6C 65 66 74 2C
   A6BE 31 2C 38 2C 48 65  4338         .ascii  '1,8,Helen,Mouth,'
        6C 65 6E 2C 4D 6F
        75 74 68 2C
   A6CE 31 2C 48 65 61 64  4339         .ascii  '1,Head left,'
        20 6C 65 66 74 2C
   A6DA 32 2C 48 65 61 64  4340         .ascii  '2,Head right,'
        20 72 69 67 68 74
        2C
   A6E7 32 2C 48 65 61 64  4341         .ascii  '2,Head up,'
        20 75 70 2C
   A6F1 32 2C 45 79 65 73  4342         .ascii  '2,Eyes right,'
        20 72 69 67 68 74
        2C
   A6FE 31 2C 45 79 65 6C  4343         .ascii  '1,Eyelids,'
        69 64 73 2C
   A708 31 2C 52 69 67 68  4344         .ascii  '1,Right hand,'
        74 20 68 61 6E 64
        2C
   A715 32 2C 45 79 65 73  4345         .ascii  '2,Eyes left,'
        20 6C 65 66 74 2C
   A721 31 2C 36 2C 4D 75  4346         .ascii  '1,6,Munch,Mouth,'
        6E 63 68 2C 4D 6F
        75 74 68 2C
   A731 31 2C 48 65 61 64  4347         .ascii  '1,Head left,'
        20 6C 65 66 74 2C
   A73D 32 2C 48 65 61 64  4348         .ascii  '2,Head right,'
        20 72 69 67 68 74
        2C
   A74A 32 2C 4C 65 66 74  4349         .ascii  '2,Left arm,'
        20 61 72 6D 2C
   A755 32 2C 45 79 65 73  4350         .ascii  '2,Eyes right,'
        20 72 69 67 68 74
        2C
   A762 31 2C 45 79 65 6C  4351         .ascii  '1,Eyelids,'
        69 64 73 2C
   A76C 31 2C 52 69 67 68  4352         .ascii  '1,Right arm,'
        74 20 61 72 6D 2C
   A778 32 2C 45 79 65 73  4353         .ascii  '2,Eyes left,'
        20 6C 65 66 74 2C
   A784 31 2C 32 2C 4A 61  4354         .ascii  '1,2,Jasper,Mouth,'
        73 70 65 72 2C 4D
        6F 75 74 68 2C
   A795 31 2C 48 65 61 64  4355         .ascii  '1,Head left,'
        20 6C 65 66 74 2C
   A7A1 32 2C 48 65 61 64  4356         .ascii  '2,Head right,'
        20 72 69 67 68 74
        2C
   A7AE 32 2C 48 65 61 64  4357         .ascii  '2,Head up,'
        20 75 70 2C
   A7B8 32 2C 45 79 65 73  4358         .ascii  '2,Eyes right,'
        20 72 69 67 68 74
        2C
   A7C5 31 2C 45 79 65 6C  4359         .ascii  '1,Eyelids,'
        69 64 73 2C
   A7CF 31 2C 48 61 6E 64  4360         .ascii  '1,Hands,'
        73 2C
   A7D7 32 2C 45 79 65 73  4361         .ascii  '2,Eyes left,'
        20 6C 65 66 74 2C
   A7E3 31 2C 34 2C 50 61  4362         .ascii  '1,4,Pasqually,Mouth-Mustache,'
        73 71 75 61 6C 6C
        79 2C 4D 6F 75 74
        68 2D 4D 75 73 74
        61 63 68 65 2C
   A800 31 2C 48 65 61 64  4363         .ascii  '1,Head left,'
        20 6C 65 66 74 2C
   A80C 32 2C 48 65 61 64  4364         .ascii  '2,Head right,'
        20 72 69 67 68 74
        2C
   A819 32 2C 4C 65 66 74  4365         .ascii  '2,Left arm,'
        20 61 72 6D 2C
   A824 32 2C 45 79 65 73  4366         .ascii  '2,Eyes right,'
        20 72 69 67 68 74
        2C
   A831 31 2C 45 79 65 6C  4367         .ascii  '1,Eyelids,'
        69 64 73 2C
   A83B 31 2C 52 69 67 68  4368         .ascii  '1,Right arm,'
        74 20 61 72 6D 2C
   A847 32 2C 45 79 65 73  4369         .ascii  '2,Eyes left,1,<'
        20 6C 65 66 74 2C
        31 2C 3C
                           4370 
   A856 BD 86 C4      [ 6] 4371         jsr     L86C4
   A859 CE 10 80      [ 3] 4372         ldx     #0x1080
   A85C 86 20         [ 2] 4373         ldaa    #0x20
   A85E A7 00         [ 4] 4374         staa    0,X
   A860 A7 04         [ 4] 4375         staa    4,X
   A862 A7 08         [ 4] 4376         staa    8,X
   A864 A7 0C         [ 4] 4377         staa    12,X
   A866 A7 10         [ 4] 4378         staa    16,X
   A868 38            [ 5] 4379         pulx
   A869 39            [ 5] 4380         rts
                           4381 
   A86A BD A3 2E      [ 6] 4382         jsr     (0xA32E)
                           4383 
   A86D BD 8D E4      [ 6] 4384         jsr     LCDMSG1 
   A870 20 20 20 20 57 61  4385         .ascis  '    Warm-Up  '
        72 6D 2D 55 70 20
        A0
                           4386 
   A87D BD 8D DD      [ 6] 4387         jsr     LCDMSG2 
   A880 43 75 72 74 61 69  4388         .ascis  'Curtains opening'
        6E 73 20 6F 70 65
        6E 69 6E E7
                           4389 
   A890 C6 14         [ 2] 4390         ldab    #0x14
   A892 BD 8C 30      [ 6] 4391         jsr     (0x8C30)
   A895 BD A8 55      [ 6] 4392         jsr     (0xA855)
   A898 C6 02         [ 2] 4393         ldab    #0x02
   A89A BD 8C 30      [ 6] 4394         jsr     (0x8C30)
   A89D CE A6 5D      [ 3] 4395         ldx     #LA65D
   A8A0 C6 05         [ 2] 4396         ldab    #0x05
   A8A2 D7 12         [ 3] 4397         stab    (0x0012)
   A8A4 C6 08         [ 2] 4398         ldab    #0x08
   A8A6 D7 13         [ 3] 4399         stab    (0x0013)
   A8A8 BD A9 41      [ 6] 4400         jsr     (0xA941)
   A8AB BD A9 4C      [ 6] 4401         jsr     (0xA94C)
   A8AE C6 02         [ 2] 4402         ldab    #0x02
   A8B0 BD 8C 30      [ 6] 4403         jsr     (0x8C30)
   A8B3                    4404 LA8B3:
   A8B3 BD A9 5E      [ 6] 4405         jsr     (0xA95E)
   A8B6 A6 00         [ 4] 4406         ldaa    0,X     
   A8B8 80 30         [ 2] 4407         suba    #0x30
   A8BA 08            [ 3] 4408         inx
   A8BB 08            [ 3] 4409         inx
   A8BC 36            [ 3] 4410         psha
   A8BD 7C 00 4C      [ 6] 4411         inc     (0x004C)
   A8C0 3C            [ 4] 4412         pshx
   A8C1 BD 88 E5      [ 6] 4413         jsr     (0x88E5)
   A8C4 38            [ 5] 4414         pulx
   A8C5 86 4F         [ 2] 4415         ldaa    #0x4F            ;'O'
   A8C7 C6 0C         [ 2] 4416         ldab    #0x0C
   A8C9 BD 8D B5      [ 6] 4417         jsr     (0x8DB5)         ; display char here on LCD display
   A8CC 86 6E         [ 2] 4418         ldaa    #0x6E            ;'n'
   A8CE C6 0D         [ 2] 4419         ldab    #0x0D
   A8D0 BD 8D B5      [ 6] 4420         jsr     (0x8DB5)         ; display char here on LCD display
   A8D3 CC 20 0E      [ 3] 4421         ldd     #0x200E           ;' '
   A8D6 BD 8D B5      [ 6] 4422         jsr     (0x8DB5)         ; display char here on LCD display
   A8D9 7A 00 4C      [ 6] 4423         dec     (0x004C)
   A8DC 32            [ 4] 4424         pula
   A8DD 36            [ 3] 4425         psha
   A8DE C6 64         [ 2] 4426         ldab    #0x64
   A8E0 3D            [10] 4427         mul
   A8E1 DD 23         [ 4] 4428         std     CDTIMR5
   A8E3                    4429 LA8E3:
   A8E3 DC 23         [ 4] 4430         ldd     CDTIMR5
   A8E5 26 FC         [ 3] 4431         bne     LA8E3  
   A8E7 BD 8E 95      [ 6] 4432         jsr     (0x8E95)
   A8EA 81 0D         [ 2] 4433         cmpa    #0x0D
   A8EC 26 05         [ 3] 4434         bne     LA8F3  
   A8EE BD A9 75      [ 6] 4435         jsr     (0xA975)
   A8F1 20 10         [ 3] 4436         bra     LA903  
   A8F3                    4437 LA8F3:
   A8F3 81 01         [ 2] 4438         cmpa    #0x01
   A8F5 26 04         [ 3] 4439         bne     LA8FB  
   A8F7 32            [ 4] 4440         pula
   A8F8 7E A8 95      [ 3] 4441         jmp     (0xA895)
   A8FB                    4442 LA8FB:
   A8FB 81 02         [ 2] 4443         cmpa    #0x02
   A8FD 26 04         [ 3] 4444         bne     LA903  
   A8FF 32            [ 4] 4445         pula
   A900 7E A9 35      [ 3] 4446         jmp     (0xA935)
   A903                    4447 LA903:
   A903 3C            [ 4] 4448         pshx
   A904 BD 88 E5      [ 6] 4449         jsr     (0x88E5)
   A907 38            [ 5] 4450         pulx
   A908 86 66         [ 2] 4451         ldaa    #0x66            ;'f'
   A90A C6 0D         [ 2] 4452         ldab    #0x0D
   A90C BD 8D B5      [ 6] 4453         jsr     (0x8DB5)         ; display char here on LCD display
   A90F 86 66         [ 2] 4454         ldaa    #0x66            ;'f'
   A911 C6 0E         [ 2] 4455         ldab    #0x0E
   A913 BD 8D B5      [ 6] 4456         jsr     (0x8DB5)         ; display char here on LCD display
   A916 32            [ 4] 4457         pula
   A917 C6 64         [ 2] 4458         ldab    #0x64
   A919 3D            [10] 4459         mul
   A91A DD 23         [ 4] 4460         std     CDTIMR5
   A91C                    4461 LA91C:
   A91C DC 23         [ 4] 4462         ldd     CDTIMR5
   A91E 26 FC         [ 3] 4463         bne     LA91C  
   A920 BD A8 55      [ 6] 4464         jsr     (0xA855)
   A923 7C 00 4B      [ 6] 4465         inc     (0x004B)
   A926 96 4B         [ 3] 4466         ldaa    (0x004B)
   A928 81 48         [ 2] 4467         cmpa    #0x48
   A92A 25 87         [ 3] 4468         bcs     LA8B3  
   A92C 96 4C         [ 3] 4469         ldaa    (0x004C)
   A92E 81 34         [ 2] 4470         cmpa    #0x34
   A930 27 03         [ 3] 4471         beq     LA935  
   A932 7E A8 A4      [ 3] 4472         jmp     (0xA8A4)
   A935                    4473 LA935:
   A935 C6 02         [ 2] 4474         ldab    #0x02
   A937 BD 8C 30      [ 6] 4475         jsr     (0x8C30)
   A93A BD 86 C4      [ 6] 4476         jsr     L86C4
   A93D BD A3 41      [ 6] 4477         jsr     (0xA341)
   A940 39            [ 5] 4478         rts
                           4479 
   A941 A6 00         [ 4] 4480         ldaa    0,X     
   A943 08            [ 3] 4481         inx
   A944 08            [ 3] 4482         inx
   A945 97 4C         [ 3] 4483         staa    (0x004C)
   A947 86 40         [ 2] 4484         ldaa    #0x40
   A949 97 4B         [ 3] 4485         staa    (0x004B)
   A94B 39            [ 5] 4486         rts
                           4487 
   A94C BD 8C F2      [ 6] 4488         jsr     (0x8CF2)
   A94F                    4489 LA94F:
   A94F A6 00         [ 4] 4490         ldaa    0,X     
   A951 08            [ 3] 4491         inx
   A952 81 2C         [ 2] 4492         cmpa    #0x2C
   A954 27 07         [ 3] 4493         beq     LA95D  
   A956 36            [ 3] 4494         psha
   A957 BD 8E 70      [ 6] 4495         jsr     (0x8E70)
   A95A 32            [ 4] 4496         pula
   A95B 20 F2         [ 3] 4497         bra     LA94F  
   A95D                    4498 LA95D:
   A95D 39            [ 5] 4499         rts
                           4500 
   A95E BD 8D 03      [ 6] 4501         jsr     (0x8D03)
   A961 86 C0         [ 2] 4502         ldaa    #0xC0
   A963 BD 8E 4B      [ 6] 4503         jsr     (0x8E4B)
   A966                    4504 LA966:
   A966 A6 00         [ 4] 4505         ldaa    0,X     
   A968 08            [ 3] 4506         inx
   A969 81 2C         [ 2] 4507         cmpa    #0x2C
   A96B 27 07         [ 3] 4508         beq     LA974  
   A96D 36            [ 3] 4509         psha
   A96E BD 8E 70      [ 6] 4510         jsr     (0x8E70)
   A971 32            [ 4] 4511         pula
   A972 20 F2         [ 3] 4512         bra     LA966  
   A974                    4513 LA974:
   A974 39            [ 5] 4514         rts
                           4515 
   A975                    4516 LA975:
   A975 BD 8E 95      [ 6] 4517         jsr     (0x8E95)
   A978 4D            [ 2] 4518         tsta
   A979 27 FA         [ 3] 4519         beq     LA975  
   A97B 39            [ 5] 4520         rts
                           4521 
   A97C 7F 00 60      [ 6] 4522         clr     (0x0060)
   A97F FC 02 9C      [ 5] 4523         ldd     (0x029C)
   A982 1A 83 00 01   [ 5] 4524         cpd     #0x0001
   A986 27 0C         [ 3] 4525         beq     LA994  
   A988 1A 83 03 E8   [ 5] 4526         cpd     #0x03E8
   A98C 2D 7D         [ 3] 4527         blt     LAA0B  
   A98E 1A 83 04 4B   [ 5] 4528         cpd     #0x044B
   A992 22 77         [ 3] 4529         bhi     LAA0B  
   A994                    4530 LA994:
   A994 C6 40         [ 2] 4531         ldab    #0x40
   A996 D7 62         [ 3] 4532         stab    (0x0062)
   A998 BD F9 C5      [ 6] 4533         jsr     BUTNLIT 
   A99B C6 64         [ 2] 4534         ldab    #0x64
   A99D BD 8C 22      [ 6] 4535         jsr     (0x8C22)
   A9A0 BD 86 C4      [ 6] 4536         jsr     L86C4
   A9A3 BD 8C E9      [ 6] 4537         jsr     (0x8CE9)
                           4538 
   A9A6 BD 8D E4      [ 6] 4539         jsr     LCDMSG1 
   A9A9 20 20 20 20 20 53  4540         .ascis  '     STUDIO'
        54 55 44 49 CF
                           4541 
   A9B4 BD 8D DD      [ 6] 4542         jsr     LCDMSG2 
   A9B7 70 72 6F 67 72 61  4543         .ascis  'programming mode'
        6D 6D 69 6E 67 20
        6D 6F 64 E5
                           4544 
   A9C7 BD A3 2E      [ 6] 4545         jsr     (0xA32E)
   A9CA BD 99 9E      [ 6] 4546         jsr     (0x999E)
   A9CD BD 99 B1      [ 6] 4547         jsr     (0x99B1)
   A9D0 CE 20 00      [ 3] 4548         ldx     #0x2000
   A9D3                    4549 LA9D3:
   A9D3 18 CE 00 C0   [ 4] 4550         ldy     #0x00C0
   A9D7                    4551 LA9D7:
   A9D7 18 09         [ 4] 4552         dey
   A9D9 26 0A         [ 3] 4553         bne     LA9E5  
   A9DB BD A9 F4      [ 6] 4554         jsr     (0xA9F4)
   A9DE 96 60         [ 3] 4555         ldaa    (0x0060)
   A9E0 26 29         [ 3] 4556         bne     LAA0B  
   A9E2 CE 20 00      [ 3] 4557         ldx     #0x2000
   A9E5                    4558 LA9E5:
   A9E5 B6 10 A8      [ 4] 4559         ldaa    (0x10A8)
   A9E8 84 01         [ 2] 4560         anda    #0x01
   A9EA 27 EB         [ 3] 4561         beq     LA9D7  
   A9EC B6 10 A9      [ 4] 4562         ldaa    (0x10A9)
   A9EF A7 00         [ 4] 4563         staa    0,X     
   A9F1 08            [ 3] 4564         inx
   A9F2 20 DF         [ 3] 4565         bra     LA9D3  
   A9F4 CE 20 00      [ 3] 4566         ldx     #0x2000
   A9F7 18 CE 10 80   [ 4] 4567         ldy     #0x1080
   A9FB                    4568 LA9FB:
   A9FB A6 00         [ 4] 4569         ldaa    0,X     
   A9FD 18 A7 00      [ 5] 4570         staa    0,Y     
   AA00 08            [ 3] 4571         inx
   AA01 18 08         [ 4] 4572         iny
   AA03 18 08         [ 4] 4573         iny
   AA05 8C 20 10      [ 4] 4574         cpx     #0x2010
   AA08 25 F1         [ 3] 4575         bcs     LA9FB  
   AA0A 39            [ 5] 4576         rts
   AA0B                    4577 LAA0B:
   AA0B 39            [ 5] 4578         rts
   AA0C CC 48 37      [ 3] 4579         ldd     #0x4837           ;'H'
   AA0F                    4580 LAA0F:
   AA0F BD 8D B5      [ 6] 4581         jsr     (0x8DB5)         ; display char here on LCD display
   AA12 39            [ 5] 4582         rts
   AA13 CC 20 37      [ 3] 4583         ldd     #0x2037           ;' '
   AA16 20 F7         [ 3] 4584         bra     LAA0F  
   AA18 CC 42 0F      [ 3] 4585         ldd     #0x420F           ;'B'
   AA1B 20 F2         [ 3] 4586         bra     LAA0F  
   AA1D CC 20 0F      [ 3] 4587         ldd     #0x200F           ;' '
   AA20 20 ED         [ 3] 4588         bra     LAA0F  
   AA22 7F 00 4F      [ 6] 4589         clr     (0x004F)
   AA25 CC 00 01      [ 3] 4590         ldd     #0x0001
   AA28 DD 1B         [ 4] 4591         std     CDTIMR1
   AA2A CE 20 00      [ 3] 4592         ldx     #0x2000
   AA2D                    4593 LAA2D:
   AA2D B6 10 A8      [ 4] 4594         ldaa    (0x10A8)
   AA30 84 01         [ 2] 4595         anda    #0x01
   AA32 27 F9         [ 3] 4596         beq     LAA2D  
   AA34 DC 1B         [ 4] 4597         ldd     CDTIMR1
   AA36 0F            [ 2] 4598         sei
   AA37 26 03         [ 3] 4599         bne     LAA3C  
   AA39 CE 20 00      [ 3] 4600         ldx     #0x2000
   AA3C                    4601 LAA3C:
   AA3C B6 10 A9      [ 4] 4602         ldaa    (0x10A9)
   AA3F A7 00         [ 4] 4603         staa    0,X     
   AA41 0E            [ 2] 4604         cli
   AA42 BD F9 6F      [ 6] 4605         jsr     SERIALW      
   AA45 08            [ 3] 4606         inx
   AA46 7F 00 4F      [ 6] 4607         clr     (0x004F)
   AA49 CC 00 01      [ 3] 4608         ldd     #0x0001
   AA4C DD 1B         [ 4] 4609         std     CDTIMR1
   AA4E 8C 20 23      [ 4] 4610         cpx     #0x2023
   AA51 26 DA         [ 3] 4611         bne     LAA2D  
   AA53 CE 20 00      [ 3] 4612         ldx     #0x2000
   AA56 7F 00 B7      [ 6] 4613         clr     (0x00B7)
   AA59                    4614 LAA59:
   AA59 A6 00         [ 4] 4615         ldaa    0,X     
   AA5B 9B B7         [ 3] 4616         adda    (0x00B7)
   AA5D 97 B7         [ 3] 4617         staa    (0x00B7)
   AA5F 08            [ 3] 4618         inx
   AA60 8C 20 22      [ 4] 4619         cpx     #0x2022
   AA63 25 F4         [ 3] 4620         bcs     LAA59  
   AA65 96 B7         [ 3] 4621         ldaa    (0x00B7)
   AA67 88 FF         [ 2] 4622         eora    #0xFF
   AA69 A1 00         [ 4] 4623         cmpa    0,X     
   AA6B CE 20 00      [ 3] 4624         ldx     #0x2000
   AA6E A6 20         [ 4] 4625         ldaa    0x20,X
   AA70 2B 03         [ 3] 4626         bmi     LAA75  
   AA72 7E AA 22      [ 3] 4627         jmp     (0xAA22)
   AA75                    4628 LAA75:
   AA75 A6 00         [ 4] 4629         ldaa    0,X     
   AA77 B7 10 80      [ 4] 4630         staa    (0x1080)
   AA7A 08            [ 3] 4631         inx
   AA7B A6 00         [ 4] 4632         ldaa    0,X     
   AA7D B7 10 82      [ 4] 4633         staa    (0x1082)
   AA80 08            [ 3] 4634         inx
   AA81 A6 00         [ 4] 4635         ldaa    0,X     
   AA83 B7 10 84      [ 4] 4636         staa    (0x1084)
   AA86 08            [ 3] 4637         inx
   AA87 A6 00         [ 4] 4638         ldaa    0,X     
   AA89 B7 10 86      [ 4] 4639         staa    (0x1086)
   AA8C 08            [ 3] 4640         inx
   AA8D A6 00         [ 4] 4641         ldaa    0,X     
   AA8F B7 10 88      [ 4] 4642         staa    (0x1088)
   AA92 08            [ 3] 4643         inx
   AA93 A6 00         [ 4] 4644         ldaa    0,X     
   AA95 B7 10 8A      [ 4] 4645         staa    (0x108A)
   AA98 08            [ 3] 4646         inx
   AA99 A6 00         [ 4] 4647         ldaa    0,X     
   AA9B B7 10 8C      [ 4] 4648         staa    (0x108C)
   AA9E 08            [ 3] 4649         inx
   AA9F A6 00         [ 4] 4650         ldaa    0,X     
   AAA1 B7 10 8E      [ 4] 4651         staa    (0x108E)
   AAA4 08            [ 3] 4652         inx
   AAA5 A6 00         [ 4] 4653         ldaa    0,X     
   AAA7 B7 10 90      [ 4] 4654         staa    (0x1090)
   AAAA 08            [ 3] 4655         inx
   AAAB A6 00         [ 4] 4656         ldaa    0,X     
   AAAD B7 10 92      [ 4] 4657         staa    (0x1092)
   AAB0 08            [ 3] 4658         inx
   AAB1 A6 00         [ 4] 4659         ldaa    0,X     
   AAB3 8A 80         [ 2] 4660         oraa    #0x80
   AAB5 B7 10 94      [ 4] 4661         staa    (0x1094)
   AAB8 08            [ 3] 4662         inx
   AAB9 A6 00         [ 4] 4663         ldaa    0,X     
   AABB 8A 01         [ 2] 4664         oraa    #0x01
   AABD B7 10 96      [ 4] 4665         staa    (0x1096)
   AAC0 08            [ 3] 4666         inx
   AAC1 A6 00         [ 4] 4667         ldaa    0,X     
   AAC3 B7 10 98      [ 4] 4668         staa    (0x1098)
   AAC6 08            [ 3] 4669         inx
   AAC7 A6 00         [ 4] 4670         ldaa    0,X     
   AAC9 B7 10 9A      [ 4] 4671         staa    (0x109A)
   AACC 08            [ 3] 4672         inx
   AACD A6 00         [ 4] 4673         ldaa    0,X     
   AACF B7 10 9C      [ 4] 4674         staa    (0x109C)
   AAD2 08            [ 3] 4675         inx
   AAD3 A6 00         [ 4] 4676         ldaa    0,X     
   AAD5 B7 10 9E      [ 4] 4677         staa    (0x109E)
   AAD8 7E AA 22      [ 3] 4678         jmp     (0xAA22)
   AADB 7F 10 98      [ 6] 4679         clr     (0x1098)
   AADE 7F 10 9A      [ 6] 4680         clr     (0x109A)
   AAE1 7F 10 9C      [ 6] 4681         clr     (0x109C)
   AAE4 7F 10 9E      [ 6] 4682         clr     (0x109E)
   AAE7 39            [ 5] 4683         rts
                           4684 
   AAE8 CE 04 2C      [ 3] 4685         ldx     #0x042C
   AAEB C6 10         [ 2] 4686         ldab    #0x10
   AAED                    4687 LAAED:
   AAED 5D            [ 2] 4688         tstb
   AAEE 27 12         [ 3] 4689         beq     LAB02  
   AAF0 A6 00         [ 4] 4690         ldaa    0,X     
   AAF2 81 30         [ 2] 4691         cmpa    #0x30
   AAF4 25 0D         [ 3] 4692         bcs     LAB03  
   AAF6 81 39         [ 2] 4693         cmpa    #0x39
   AAF8 22 09         [ 3] 4694         bhi     LAB03  
   AAFA 08            [ 3] 4695         inx
   AAFB 08            [ 3] 4696         inx
   AAFC 08            [ 3] 4697         inx
   AAFD 8C 04 59      [ 4] 4698         cpx     #0x0459
   AB00 23 EB         [ 3] 4699         bls     LAAED  
   AB02                    4700 LAB02:
   AB02 39            [ 5] 4701         rts
                           4702 
   AB03                    4703 LAB03:
   AB03 5A            [ 2] 4704         decb
   AB04 3C            [ 4] 4705         pshx
   AB05                    4706 LAB05:
   AB05 A6 03         [ 4] 4707         ldaa    3,X     
   AB07 A7 00         [ 4] 4708         staa    0,X     
   AB09 08            [ 3] 4709         inx
   AB0A 8C 04 5C      [ 4] 4710         cpx     #0x045C
   AB0D 25 F6         [ 3] 4711         bcs     LAB05  
   AB0F 86 FF         [ 2] 4712         ldaa    #0xFF
   AB11 B7 04 59      [ 4] 4713         staa    (0x0459)
   AB14 38            [ 5] 4714         pulx
   AB15 20 D6         [ 3] 4715         bra     LAAED  
   AB17 CE 04 2C      [ 3] 4716         ldx     #0x042C
   AB1A 86 FF         [ 2] 4717         ldaa    #0xFF
   AB1C                    4718 LAB1C:
   AB1C A7 00         [ 4] 4719         staa    0,X     
   AB1E 08            [ 3] 4720         inx
   AB1F 8C 04 5C      [ 4] 4721         cpx     #0x045C
   AB22 25 F8         [ 3] 4722         bcs     LAB1C  
   AB24 39            [ 5] 4723         rts
                           4724 
   AB25 CE 04 2C      [ 3] 4725         ldx     #0x042C
   AB28                    4726 LAB28:
   AB28 A6 00         [ 4] 4727         ldaa    0,X     
   AB2A 81 30         [ 2] 4728         cmpa    #0x30
   AB2C 25 17         [ 3] 4729         bcs     LAB45  
   AB2E 81 39         [ 2] 4730         cmpa    #0x39
   AB30 22 13         [ 3] 4731         bhi     LAB45  
   AB32 08            [ 3] 4732         inx
   AB33 08            [ 3] 4733         inx
   AB34 08            [ 3] 4734         inx
   AB35 8C 04 5C      [ 4] 4735         cpx     #0x045C
   AB38 25 EE         [ 3] 4736         bcs     LAB28  
   AB3A 86 FF         [ 2] 4737         ldaa    #0xFF
   AB3C B7 04 2C      [ 4] 4738         staa    (0x042C)
   AB3F BD AA E8      [ 6] 4739         jsr     (0xAAE8)
   AB42 CE 04 59      [ 3] 4740         ldx     #0x0459
   AB45                    4741 LAB45:
   AB45 39            [ 5] 4742         rts
                           4743 
   AB46 B6 02 99      [ 4] 4744         ldaa    (0x0299)
   AB49 A7 00         [ 4] 4745         staa    0,X     
   AB4B B6 02 9A      [ 4] 4746         ldaa    (0x029A)
   AB4E A7 01         [ 4] 4747         staa    1,X     
   AB50 B6 02 9B      [ 4] 4748         ldaa    (0x029B)
   AB53 A7 02         [ 4] 4749         staa    2,X     
   AB55 39            [ 5] 4750         rts
                           4751 
   AB56 CE 04 2C      [ 3] 4752         ldx     #0x042C
   AB59                    4753 LAB59:
   AB59 B6 02 99      [ 4] 4754         ldaa    (0x0299)
   AB5C A1 00         [ 4] 4755         cmpa    0,X     
   AB5E 26 10         [ 3] 4756         bne     LAB70  
   AB60 B6 02 9A      [ 4] 4757         ldaa    (0x029A)
   AB63 A1 01         [ 4] 4758         cmpa    1,X     
   AB65 26 09         [ 3] 4759         bne     LAB70  
   AB67 B6 02 9B      [ 4] 4760         ldaa    (0x029B)
   AB6A A1 02         [ 4] 4761         cmpa    2,X     
   AB6C 26 02         [ 3] 4762         bne     LAB70  
   AB6E 20 0A         [ 3] 4763         bra     LAB7A  
   AB70                    4764 LAB70:
   AB70 08            [ 3] 4765         inx
   AB71 08            [ 3] 4766         inx
   AB72 08            [ 3] 4767         inx
   AB73 8C 04 5C      [ 4] 4768         cpx     #0x045C
   AB76 25 E1         [ 3] 4769         bcs     LAB59  
   AB78 0D            [ 2] 4770         sec
   AB79 39            [ 5] 4771         rts
                           4772 
   AB7A                    4773 LAB7A:
   AB7A 0C            [ 2] 4774         clc
   AB7B 39            [ 5] 4775         rts
                           4776 
                           4777 ;show re-valid tapes
   AB7C CE 04 2C      [ 3] 4778         ldx     #0x042C
   AB7F                    4779 LAB7F:
   AB7F A6 00         [ 4] 4780         ldaa    0,X     
   AB81 81 30         [ 2] 4781         cmpa    #0x30
   AB83 25 1E         [ 3] 4782         bcs     LABA3  
   AB85 81 39         [ 2] 4783         cmpa    #0x39
   AB87 22 1A         [ 3] 4784         bhi     LABA3  
   AB89 BD F9 6F      [ 6] 4785         jsr     SERIALW      
   AB8C 08            [ 3] 4786         inx
   AB8D A6 00         [ 4] 4787         ldaa    0,X     
   AB8F BD F9 6F      [ 6] 4788         jsr     SERIALW      
   AB92 08            [ 3] 4789         inx
   AB93 A6 00         [ 4] 4790         ldaa    0,X     
   AB95 BD F9 6F      [ 6] 4791         jsr     SERIALW      
   AB98 08            [ 3] 4792         inx
   AB99 86 20         [ 2] 4793         ldaa    #0x20
   AB9B BD F9 6F      [ 6] 4794         jsr     SERIALW      
   AB9E 8C 04 5C      [ 4] 4795         cpx     #0x045C
   ABA1 25 DC         [ 3] 4796         bcs     LAB7F  
   ABA3                    4797 LABA3:
   ABA3 86 0D         [ 2] 4798         ldaa    #0x0D
   ABA5 BD F9 6F      [ 6] 4799         jsr     SERIALW      
   ABA8 86 0A         [ 2] 4800         ldaa    #0x0A
   ABAA BD F9 6F      [ 6] 4801         jsr     SERIALW      
   ABAD 39            [ 5] 4802         rts
                           4803 
   ABAE 7F 00 4A      [ 6] 4804         clr     (0x004A)
   ABB1 CC 00 64      [ 3] 4805         ldd     #0x0064
   ABB4 DD 23         [ 4] 4806         std     CDTIMR5
   ABB6                    4807 LABB6:
   ABB6 96 4A         [ 3] 4808         ldaa    (0x004A)
   ABB8 26 08         [ 3] 4809         bne     LABC2  
   ABBA BD 9B 19      [ 6] 4810         jsr     L9B19   
   ABBD DC 23         [ 4] 4811         ldd     CDTIMR5
   ABBF 26 F5         [ 3] 4812         bne     LABB6  
   ABC1                    4813 LABC1:
   ABC1 39            [ 5] 4814         rts
                           4815 
   ABC2                    4816 LABC2:
   ABC2 81 31         [ 2] 4817         cmpa    #0x31
   ABC4 26 04         [ 3] 4818         bne     LABCA  
   ABC6 BD AB 17      [ 6] 4819         jsr     (0xAB17)
   ABC9 39            [ 5] 4820         rts
                           4821 
   ABCA                    4822 LABCA:
   ABCA 20 F5         [ 3] 4823         bra     LABC1  
                           4824 
                           4825 ; TOC1 timer handler
                           4826 ;
                           4827 ; Timer is running at:
                           4828 ; EXTAL = 16Mhz
                           4829 ; E Clk = 4Mhz
                           4830 ; Timer Prescaler = /16 = 250Khz
                           4831 ; Timer Period = 4us
                           4832 ; T1OC is set to previous value +625
                           4833 ; So, this routine is called every 2.5ms
                           4834 ;
   ABCC DC 10         [ 4] 4835         ldd     T1NXT        ; get ready for next time
   ABCE C3 02 71      [ 4] 4836         addd    #0x0271      ; add 625
   ABD1 FD 10 16      [ 5] 4837         std     TOC1  
   ABD4 DD 10         [ 4] 4838         std     T1NXT
                           4839 
   ABD6 86 80         [ 2] 4840         ldaa    #0x80
   ABD8 B7 10 23      [ 4] 4841         staa    TFLG1       ; clear timer1 flag
                           4842 
                           4843 ; Some blinking SPECIAL button every half second,
                           4844 ; if 0x0078 is non zero
                           4845 
   ABDB 7D 00 78      [ 6] 4846         tst     (0x0078)     ; if 78 is zero, skip ahead
   ABDE 27 1C         [ 3] 4847         beq     LABFC       ; else do some blinking button lights
   ABE0 DC 25         [ 4] 4848         ldd     (0x0025)     ; else inc 25/26
   ABE2 C3 00 01      [ 4] 4849         addd    #0x0001
   ABE5 DD 25         [ 4] 4850         std     (0x0025)
   ABE7 1A 83 00 C8   [ 5] 4851         cpd     #0x00C8       ; is it 200?
   ABEB 26 0F         [ 3] 4852         bne     LABFC       ; no, keep going
   ABED 7F 00 25      [ 6] 4853         clr     (0x0025)     ; reset 25/26
   ABF0 7F 00 26      [ 6] 4854         clr     (0x0026)
   ABF3 D6 62         [ 3] 4855         ldab    (0x0062)    ; and toggle bit 3 of 62
   ABF5 C8 08         [ 2] 4856         eorb    #0x08
   ABF7 D7 62         [ 3] 4857         stab    (0x0062)
   ABF9 BD F9 C5      [ 6] 4858         jsr     BUTNLIT      ; and toggle the "special" button light
                           4859 
                           4860 ; 
   ABFC                    4861 LABFC:
   ABFC 7C 00 6F      [ 6] 4862         inc     (0x006F)     ; count every 2.5ms
   ABFF 96 6F         [ 3] 4863         ldaa    (0x006F)
   AC01 81 28         [ 2] 4864         cmpa    #0x28        ; is it 40 intervals? (0.1 sec?)
   AC03 25 42         [ 3] 4865         bcs     LAC47       ; if not yet, jump ahead
   AC05 7F 00 6F      [ 6] 4866         clr     (0x006F)     ; clear it 2.5ms counter
   AC08 7D 00 63      [ 6] 4867         tst     (0x0063)     ; decrement 0.1s counter here
   AC0B 27 03         [ 3] 4868         beq     LAC10       ; if it's not already zero
   AC0D 7A 00 63      [ 6] 4869         dec     (0x0063)
                           4870 
                           4871 ; staggered counters - here every 100ms
                           4872 
                           4873 ; 0x0070 counts from 250 to 1, period is 25 secs
   AC10                    4874 LAC10:
   AC10 96 70         [ 3] 4875         ldaa    OFFCNT1    ; decrement 0.1s counter here
   AC12 4A            [ 2] 4876         deca
   AC13 97 70         [ 3] 4877         staa    OFFCNT1
   AC15 26 04         [ 3] 4878         bne     LAC1B       
   AC17 86 FA         [ 2] 4879         ldaa    #0xFA        ; 250
   AC19 97 70         [ 3] 4880         staa    OFFCNT1
                           4881 
                           4882 ; 0x0071 counts from 230 to 1, period is 23 secs
   AC1B                    4883 LAC1B:
   AC1B 96 71         [ 3] 4884         ldaa    OFFCNT2
   AC1D 4A            [ 2] 4885         deca
   AC1E 97 71         [ 3] 4886         staa    OFFCNT2
   AC20 26 04         [ 3] 4887         bne     LAC26  
   AC22 86 E6         [ 2] 4888         ldaa    #0xE6        ; 230
   AC24 97 71         [ 3] 4889         staa    OFFCNT2
                           4890 
                           4891 ; 0x0072 counts from 210 to 1, period is 21 secs
   AC26                    4892 LAC26:
   AC26 96 72         [ 3] 4893         ldaa    OFFCNT3
   AC28 4A            [ 2] 4894         deca
   AC29 97 72         [ 3] 4895         staa    OFFCNT3
   AC2B 26 04         [ 3] 4896         bne     LAC31  
   AC2D 86 D2         [ 2] 4897         ldaa    #0xD2        ; 210
   AC2F 97 72         [ 3] 4898         staa    OFFCNT3
                           4899 
                           4900 ; 0x0073 counts from 190 to 1, period is 19 secs
   AC31                    4901 LAC31:
   AC31 96 73         [ 3] 4902         ldaa    OFFCNT4
   AC33 4A            [ 2] 4903         deca
   AC34 97 73         [ 3] 4904         staa    OFFCNT4
   AC36 26 04         [ 3] 4905         bne     LAC3C  
   AC38 86 BE         [ 2] 4906         ldaa    #0xBE        ; 190
   AC3A 97 73         [ 3] 4907         staa    OFFCNT4
                           4908 
                           4909 ; 0x0074 counts from 170 to 1, period is 17 secs
   AC3C                    4910 LAC3C:
   AC3C 96 74         [ 3] 4911         ldaa    OFFCNT5
   AC3E 4A            [ 2] 4912         deca
   AC3F 97 74         [ 3] 4913         staa    OFFCNT5
   AC41 26 04         [ 3] 4914         bne     LAC47  
   AC43 86 AA         [ 2] 4915         ldaa    #0xAA        ; 170
   AC45 97 74         [ 3] 4916         staa    OFFCNT5
                           4917 
                           4918 ; back to 2.5ms period here
                           4919 
   AC47                    4920 LAC47:
   AC47 96 27         [ 3] 4921         ldaa    T30MS
   AC49 4C            [ 2] 4922         inca
   AC4A 97 27         [ 3] 4923         staa    T30MS
   AC4C 81 0C         [ 2] 4924         cmpa    #0x0C        ; 12 = 30ms?
   AC4E 23 09         [ 3] 4925         bls     LAC59  
   AC50 7F 00 27      [ 6] 4926         clr     T30MS
                           4927 
                           4928 ; do these tasks every 30ms
   AC53 BD 8E C6      [ 6] 4929         jsr     (0x8EC6)     ; ???
   AC56 BD 8F 12      [ 6] 4930         jsr     (0x8F12)     ; ???
                           4931 
                           4932 ; back to every 2.5ms here
                           4933 ; LCD update???
                           4934 
   AC59                    4935 LAC59:
   AC59 96 43         [ 3] 4936         ldaa    (0x0043)
   AC5B 27 55         [ 3] 4937         beq     LACB2  
   AC5D DE 44         [ 4] 4938         ldx     (0x0044)
   AC5F A6 00         [ 4] 4939         ldaa    0,X     
   AC61 27 23         [ 3] 4940         beq     LAC86  
   AC63 B7 10 00      [ 4] 4941         staa    PORTA  
   AC66 B6 10 02      [ 4] 4942         ldaa    PORTG  
   AC69 84 F3         [ 2] 4943         anda    #0xF3
   AC6B B7 10 02      [ 4] 4944         staa    PORTG  
   AC6E 84 FD         [ 2] 4945         anda    #0xFD
   AC70 B7 10 02      [ 4] 4946         staa    PORTG  
   AC73 8A 02         [ 2] 4947         oraa    #0x02
   AC75 B7 10 02      [ 4] 4948         staa    PORTG  
   AC78 08            [ 3] 4949         inx
   AC79 08            [ 3] 4950         inx
   AC7A 8C 05 80      [ 4] 4951         cpx     #0x0580
   AC7D 25 03         [ 3] 4952         bcs     LAC82  
   AC7F CE 05 00      [ 3] 4953         ldx     #0x0500
   AC82                    4954 LAC82:
   AC82 DF 44         [ 4] 4955         stx     (0x0044)
   AC84 20 2C         [ 3] 4956         bra     LACB2  
   AC86                    4957 LAC86:
   AC86 A6 01         [ 4] 4958         ldaa    1,X     
   AC88 27 25         [ 3] 4959         beq     LACAF  
   AC8A B7 10 00      [ 4] 4960         staa    PORTA  
   AC8D B6 10 02      [ 4] 4961         ldaa    PORTG  
   AC90 84 FB         [ 2] 4962         anda    #0xFB
   AC92 8A 08         [ 2] 4963         oraa    #0x08
   AC94 B7 10 02      [ 4] 4964         staa    PORTG  
   AC97 84 FD         [ 2] 4965         anda    #0xFD
   AC99 B7 10 02      [ 4] 4966         staa    PORTG  
   AC9C 8A 02         [ 2] 4967         oraa    #0x02
   AC9E B7 10 02      [ 4] 4968         staa    PORTG  
   ACA1 08            [ 3] 4969         inx
   ACA2 08            [ 3] 4970         inx
   ACA3 8C 05 80      [ 4] 4971         cpx     #0x0580
   ACA6 25 03         [ 3] 4972         bcs     LACAB  
   ACA8 CE 05 00      [ 3] 4973         ldx     #0x0500
   ACAB                    4974 LACAB:
   ACAB DF 44         [ 4] 4975         stx     (0x0044)
   ACAD 20 03         [ 3] 4976         bra     LACB2  
   ACAF                    4977 LACAF:
   ACAF 7F 00 43      [ 6] 4978         clr     (0x0043)
                           4979 
                           4980 ; divide by 4
   ACB2                    4981 LACB2:
   ACB2 96 4F         [ 3] 4982         ldaa    (0x004F)
   ACB4 4C            [ 2] 4983         inca
   ACB5 97 4F         [ 3] 4984         staa    (0x004F)
   ACB7 81 04         [ 2] 4985         cmpa    #0x04
   ACB9 26 30         [ 3] 4986         bne     LACEB  
   ACBB 7F 00 4F      [ 6] 4987         clr     (0x004F)
                           4988 
                           4989 ; here every 10ms
                           4990 ; Five big countdown timers available here
                           4991 ; up to 655.35 seconds each
                           4992 
   ACBE DC 1B         [ 4] 4993         ldd     CDTIMR1     ; countdown 0x001B/1C every 10ms
   ACC0 27 05         [ 3] 4994         beq     LACC7       ; if not already 0
   ACC2 83 00 01      [ 4] 4995         subd    #0x0001
   ACC5 DD 1B         [ 4] 4996         std     CDTIMR1
                           4997 
   ACC7                    4998 LACC7:
   ACC7 DC 1D         [ 4] 4999         ldd     CDTIMR2     ; same with 0x001D/1E
   ACC9 27 05         [ 3] 5000         beq     LACD0  
   ACCB 83 00 01      [ 4] 5001         subd    #0x0001
   ACCE DD 1D         [ 4] 5002         std     CDTIMR2
                           5003 
   ACD0                    5004 LACD0:
   ACD0 DC 1F         [ 4] 5005         ldd     CDTIMR3     ; same with 0x001F/20
   ACD2 27 05         [ 3] 5006         beq     LACD9  
   ACD4 83 00 01      [ 4] 5007         subd    #0x0001
   ACD7 DD 1F         [ 4] 5008         std     CDTIMR3
                           5009 
   ACD9                    5010 LACD9:
   ACD9 DC 21         [ 4] 5011         ldd     CDTIMR4     ; same with 0x0021/22
   ACDB 27 05         [ 3] 5012         beq     LACE2  
   ACDD 83 00 01      [ 4] 5013         subd    #0x0001
   ACE0 DD 21         [ 4] 5014         std     CDTIMR4
                           5015 
   ACE2                    5016 LACE2:
   ACE2 DC 23         [ 4] 5017         ldd     CDTIMR5     ; same with 0x0023/24
   ACE4 27 05         [ 3] 5018         beq     LACEB  
   ACE6 83 00 01      [ 4] 5019         subd    #0x0001
   ACE9 DD 23         [ 4] 5020         std     CDTIMR5
                           5021 
                           5022 ; every other time through this, setup a task switch?
   ACEB                    5023 LACEB:
   ACEB 96 B0         [ 3] 5024         ldaa    (TSCNT)
   ACED 88 01         [ 2] 5025         eora    #0x01
   ACEF 97 B0         [ 3] 5026         staa    (TSCNT)
   ACF1 27 18         [ 3] 5027         beq     LAD0B  
                           5028 
   ACF3 BF 01 3C      [ 5] 5029         sts     (0x013C)     ; switch stacks???
   ACF6 BE 01 3E      [ 5] 5030         lds     (0x013E)
   ACF9 DC 10         [ 4] 5031         ldd     T1NXT
   ACFB 83 01 F4      [ 4] 5032         subd    #0x01F4      ; 625-500 = 125?
   ACFE FD 10 18      [ 5] 5033         std     TOC2         ; set this TOC2 to happen 0.5ms
   AD01 86 40         [ 2] 5034         ldaa    #0x40        ; after the current TOC1 but before the next TOC1
   AD03 B7 10 23      [ 4] 5035         staa    TFLG1       ; clear timer2 irq flag, just in case?
   AD06 86 C0         [ 2] 5036         ldaa    #0xC0        ;
   AD08 B7 10 22      [ 4] 5037         staa    TMSK1       ; enable TOC1 and TOC2
   AD0B                    5038 LAD0B:
   AD0B 3B            [12] 5039         rti
                           5040 
                           5041 ; TOC2 Timer handler
                           5042 
   AD0C 86 40         [ 2] 5043         ldaa    #0x40
   AD0E B7 10 23      [ 4] 5044         staa    TFLG1       ; clear timer2 flag
   AD11 BF 01 3E      [ 5] 5045         sts     (0x013E)     ; switch stacks back???
   AD14 BE 01 3C      [ 5] 5046         lds     (0x013C)
   AD17 86 80         [ 2] 5047         ldaa    #0x80
   AD19 B7 10 22      [ 4] 5048         staa    TMSK1       ; enable TOC1 only
   AD1C 3B            [12] 5049         rti
                           5050 
                           5051 ; Secondary task??
                           5052 
   AD1D                    5053 TASK2:
   AD1D 7D 04 2A      [ 6] 5054         tst     (0x042A)
   AD20 27 35         [ 3] 5055         beq     LAD57
   AD22 96 B6         [ 3] 5056         ldaa    (0x00B6)
   AD24 26 03         [ 3] 5057         bne     LAD29
   AD26 3F            [14] 5058         swi
   AD27 20 F4         [ 3] 5059         bra     TASK2
   AD29                    5060 LAD29:
   AD29 7F 00 B6      [ 6] 5061         clr     (0x00B6)
   AD2C C6 04         [ 2] 5062         ldab    #0x04
   AD2E                    5063 LAD2E:
   AD2E 37            [ 3] 5064         pshb
   AD2F CE AD 3C      [ 3] 5065         ldx     #LAD3C
   AD32 BD 8A 1A      [ 6] 5066         jsr     L8A1A  
   AD35 3F            [14] 5067         swi
   AD36 33            [ 4] 5068         pulb
   AD37 5A            [ 2] 5069         decb
   AD38 26 F4         [ 3] 5070         bne     LAD2E  
   AD3A 20 E1         [ 3] 5071         bra     TASK2
                           5072 
   AD3C                    5073 LAD3C:
   AD3C 53 31 00           5074         .asciz     'S1'
                           5075 
   AD3F FC 02 9C      [ 5] 5076         ldd     (0x029C)
   AD42 1A 83 00 01   [ 5] 5077         cpd     #0x0001
   AD46 27 0C         [ 3] 5078         beq     LAD54  
   AD48 1A 83 03 E8   [ 5] 5079         cpd     #0x03E8
   AD4C 2D 09         [ 3] 5080         blt     LAD57  
   AD4E 1A 83 04 4B   [ 5] 5081         cpd     #0x044B
   AD52 22 03         [ 3] 5082         bhi     LAD57  
   AD54                    5083 LAD54:
   AD54 3F            [14] 5084         swi
   AD55 20 C6         [ 3] 5085         bra     TASK2
   AD57                    5086 LAD57:
   AD57 7F 00 B3      [ 6] 5087         clr     (0x00B3)
   AD5A BD AD 7E      [ 6] 5088         jsr     (0xAD7E)
   AD5D BD AD A0      [ 6] 5089         jsr     (0xADA0)
   AD60 25 BB         [ 3] 5090         bcs     TASK2
   AD62 C6 0A         [ 2] 5091         ldab    #0x0A
   AD64 BD AE 13      [ 6] 5092         jsr     (0xAE13)
   AD67 BD AD AE      [ 6] 5093         jsr     (0xADAE)
   AD6A 25 B1         [ 3] 5094         bcs     TASK2
   AD6C C6 14         [ 2] 5095         ldab    #0x14
   AD6E BD AE 13      [ 6] 5096         jsr     (0xAE13)
   AD71 BD AD B6      [ 6] 5097         jsr     (0xADB6)
   AD74 25 A7         [ 3] 5098         bcs     TASK2
   AD76                    5099 LAD76:
   AD76 BD AD B8      [ 6] 5100         jsr     (0xADB8)
   AD79 0D            [ 2] 5101         sec
   AD7A 25 A1         [ 3] 5102         bcs     TASK2
   AD7C 20 F8         [ 3] 5103         bra     LAD76  
   AD7E CE AE 1E      [ 3] 5104         ldx     #LAE1E       ;+++
   AD81 BD 8A 1A      [ 6] 5105         jsr     L8A1A  
   AD84 C6 1E         [ 2] 5106         ldab    #0x1E
   AD86 BD AE 13      [ 6] 5107         jsr     (0xAE13)
   AD89 CE AE 22      [ 3] 5108         ldx     #LAE22       ;ATH
   AD8C BD 8A 1A      [ 6] 5109         jsr     L8A1A  
   AD8F C6 1E         [ 2] 5110         ldab    #0x1E
   AD91 BD AE 13      [ 6] 5111         jsr     (0xAE13)
   AD94 CE AE 27      [ 3] 5112         ldx     #LAE27       ;ATZ
   AD97 BD 8A 1A      [ 6] 5113         jsr     L8A1A  
   AD9A C6 1E         [ 2] 5114         ldab    #0x1E
   AD9C BD AE 13      [ 6] 5115         jsr     (0xAE13)
   AD9F 39            [ 5] 5116         rts
   ADA0                    5117 LADA0:
   ADA0 BD B1 DD      [ 6] 5118         jsr     (0xB1DD)
   ADA3 25 FB         [ 3] 5119         bcs     LADA0  
   ADA5 BD B2 4F      [ 6] 5120         jsr     (0xB24F)
                           5121 
   ADA8 52 49 4E 47 00     5122         .asciz  'RING'
                           5123 
   ADAD 39            [ 5] 5124         rts
                           5125 
   ADAE CE AE 2C      [ 3] 5126         ldx     #0xAE2C
   ADB1 BD 8A 1A      [ 6] 5127         jsr     L8A1A       ;ATA
   ADB4 0C            [ 2] 5128         clc
   ADB5 39            [ 5] 5129         rts
   ADB6 0C            [ 2] 5130         clc
   ADB7 39            [ 5] 5131         rts
   ADB8 BD B1 D2      [ 6] 5132         jsr     (0xB1D2)
   ADBB BD AE 31      [ 6] 5133         jsr     (0xAE31)
   ADBE 86 01         [ 2] 5134         ldaa    #0x01
   ADC0 97 B3         [ 3] 5135         staa    (0x00B3)
   ADC2 BD B1 DD      [ 6] 5136         jsr     (0xB1DD)
   ADC5 BD B2 71      [ 6] 5137         jsr     (0xB271)
   ADC8 36            [ 3] 5138         psha
   ADC9 BD B2 C0      [ 6] 5139         jsr     (0xB2C0)
   ADCC 32            [ 4] 5140         pula
   ADCD 81 01         [ 2] 5141         cmpa    #0x01
   ADCF 26 08         [ 3] 5142         bne     LADD9  
   ADD1 CE B2 95      [ 3] 5143         ldx     #LB295
   ADD4 BD 8A 1A      [ 6] 5144         jsr     L8A1A       ;'You have selected #1'
   ADD7 20 31         [ 3] 5145         bra     LAE0A  
   ADD9                    5146 LADD9:
   ADD9 81 02         [ 2] 5147         cmpa    #0x02
   ADDB 26 00         [ 3] 5148         bne     LADDD  
   ADDD                    5149 LADDD:
   ADDD 81 03         [ 2] 5150         cmpa    #0x03
   ADDF 26 00         [ 3] 5151         bne     LADE1  
   ADE1                    5152 LADE1:
   ADE1 81 04         [ 2] 5153         cmpa    #0x04
   ADE3 26 00         [ 3] 5154         bne     LADE5  
   ADE5                    5155 LADE5:
   ADE5 81 05         [ 2] 5156         cmpa    #0x05
   ADE7 26 00         [ 3] 5157         bne     LADE9  
   ADE9                    5158 LADE9:
   ADE9 81 06         [ 2] 5159         cmpa    #0x06
   ADEB 26 00         [ 3] 5160         bne     LADED  
   ADED                    5161 LADED:
   ADED 81 07         [ 2] 5162         cmpa    #0x07
   ADEF 26 00         [ 3] 5163         bne     LADF1  
   ADF1                    5164 LADF1:
   ADF1 81 08         [ 2] 5165         cmpa    #0x08
   ADF3 26 00         [ 3] 5166         bne     LADF5  
   ADF5                    5167 LADF5:
   ADF5 81 09         [ 2] 5168         cmpa    #0x09
   ADF7 26 00         [ 3] 5169         bne     LADF9  
   ADF9                    5170 LADF9:
   ADF9 81 0A         [ 2] 5171         cmpa    #0x0A
   ADFB 26 00         [ 3] 5172         bne     LADFD  
   ADFD                    5173 LADFD:
   ADFD 81 0B         [ 2] 5174         cmpa    #0x0B
   ADFF 26 09         [ 3] 5175         bne     LAE0A  
   AE01 CE B2 AA      [ 3] 5176         ldx     #LB2AA       ;'You have selected #11'
   AE04 BD 8A 1A      [ 6] 5177         jsr     L8A1A  
   AE07 7E AE 0A      [ 3] 5178         jmp     (0xAE0A)
   AE0A                    5179 LAE0A:
   AE0A C6 14         [ 2] 5180         ldab    #0x14
   AE0C BD AE 13      [ 6] 5181         jsr     (0xAE13)
   AE0F 7F 00 B3      [ 6] 5182         clr     (0x00B3)
   AE12 39            [ 5] 5183         rts
                           5184 
   AE13                    5185 LAE13:
   AE13 CE 00 20      [ 3] 5186         ldx     #0x0020
   AE16                    5187 LAE16:
   AE16 3F            [14] 5188         swi
   AE17 09            [ 3] 5189         dex
   AE18 26 FC         [ 3] 5190         bne     LAE16  
   AE1A 5A            [ 2] 5191         decb
   AE1B 26 F6         [ 3] 5192         bne     LAE13  
   AE1D 39            [ 5] 5193         rts
                           5194 
                           5195 ; text??
   AE1E                    5196 LAE1E:
   AE1E 2B 2B 2B 00        5197         .asciz      '+++'
   AE22                    5198 LAE22:
   AE22 41 54 48 0D 00     5199         .asciz      'ATH\r'
   AE27                    5200 LAE27:
   AE27 41 54 5A 0D 00     5201         .asciz      'ATZ\r'
   AE2C                    5202 LAE2C:
   AE2C 41 54 41 0D 00     5203         .asciz      'ATA\r'
                           5204 
   AE31 CE AE 38      [ 3] 5205         ldx     #LAE38       ; big long string of stats?
   AE34 BD 8A 1A      [ 6] 5206         jsr     L8A1A  
   AE37 39            [ 5] 5207         rts
                           5208 
   AE38                    5209 LAE38:
   AE38 5E 30 31 30 31 53  5210         .ascii  "^0101Serial #:^0140#0000^0111~4"
        65 72 69 61 6C 20
        23 3A 5E 30 31 34
        30 23 30 30 30 30
        5E 30 31 31 31 7E
        34
   AE57 0E 20              5211         .byte   0x0E,0x20
   AE59 5E 30 31 34 31 7C  5212         .ascii  "^0141|"
   AE5F 04 28              5213         .byte   0x04,0x28
   AE61 5E 30 33 30 31 43  5214         .ascii  "^0301CURRENT^0340HISTORY^0501Show Status:^0540Total # reg. shows:^0601Random Status:^0570|"
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
   AEBB 04 10              5215         .byte   0x04,0x10
   AEBD 5E 30 36 34 30 54  5216         .ascii  "^0640Total # live shows:^0701Current Reg Tape #:^0670|"
        6F 74 61 6C 20 23
        20 6C 69 76 65 20
        73 68 6F 77 73 3A
        5E 30 37 30 31 43
        75 72 72 65 6E 74
        20 52 65 67 20 54
        61 70 65 20 23 3A
        5E 30 36 37 30 7C
   AEF3 04 12              5217         .byte   0x04,0x12
   AEF5 5E 30 37 33 30 7E  5218         .ascii  "^0730~3"
        33
   AEFC 04 02              5219         .byte   0x04,0x02
   AEFE 5E 30 37 34 30 54  5220         .ascii  "^0740Total # failed pswd attempts:^0801Current Live Tape #:^0770|"
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
   AF3F 04 14              5221         .byte   0x04,0x14
   AF41 5E 30 38 33 30 7E  5222         .ascii  "^0830~3"
        33
   AF48 04 05              5223         .byte   0x04,0x05
   AF4A 5E 30 38 34 30 54  5224         .ascii  "^0840Total # successful pswd:^0901Current Version #:^0870|"
        6F 74 61 6C 20 23
        20 73 75 63 63 65
        73 73 66 75 6C 20
        70 73 77 64 3A 5E
        30 39 30 31 43 75
        72 72 65 6E 74 20
        56 65 72 73 69 6F
        6E 20 23 3A 5E 30
        38 37 30 7C
   AF84 04 16              5225         .byte   0x04,0x16
   AF86 5E 30 39 33 30 40  5226         .ascii  "^0930@"
   AF8C 04 00              5227         .byte   0x04,0x00
   AF8E 5E 30 39 34 30 54  5228         .ascii  "^0940Total # bdays played:^1040Total # VCR adjusts:^0970|"
        6F 74 61 6C 20 23
        20 62 64 61 79 73
        20 70 6C 61 79 65
        64 3A 5E 31 30 34
        30 54 6F 74 61 6C
        20 23 20 56 43 52
        20 61 64 6A 75 73
        74 73 3A 5E 30 39
        37 30 7C
   AFC7 04 18              5229         .byte   0x04,0x18
   AFC9 5E 31 30 37 30 7C  5230         .ascii  "^1070|"
   AFCF 04 1A              5231         .byte   0x04,0x1A
   AFD1 5E 31 31 34 30 54  5232         .ascii  "^1140Total # remote accesses:^1240Total # access attempts:^1170|"
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
   B011 04 1C              5233         .byte   0x04,0x1C
   B013 5E 31 32 37 30 7C  5234         .ascii  "^1270|"
   B019 04 1E              5235         .byte   0x04,0x1E
   B01B 5E 31 33 34 30 54  5236         .ascii  "^1340Total # rejected showtapes:^1440Total # Short bdays:^1370|"
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
   B05A 04 20              5237         .byte   0x04,0x20
   B05C 5E 31 34 37 30 7C  5238         .ascii  "^1470|"
   B062 04 22              5239         .byte   0x04,0x22
   B064 5E 31 35 34 30 54  5240         .ascii  "^1540Total # Reg bdays:^1640Total # resets-pwr ups:^1570|"
        6F 74 61 6C 20 23
        20 52 65 67 20 62
        64 61 79 73 3A 5E
        31 36 34 30 54 6F
        74 61 6C 20 23 20
        72 65 73 65 74 73
        2D 70 77 72 20 75
        70 73 3A 5E 31 35
        37 30 7C
   B09D 04 24              5241         .byte   0x04,0x24
   B09F 5E 31 36 37 30 7C  5242         .ascii  "^1670|"
   B0A5 04 26              5243         .byte   0x04,0x26
   B0A7 5E 31 38 30 31 46  5244         .ascii  "^1801FUNCTIONS^1823Select Function:^20011.Clear rnd enables^2028 6.Set loc name-#^205411.Diagnostics^21012.Set rnd enables^2128 7.Set Time^215412.^22013.Set reg tape #^2228 8.Disbl-enbl show^225413.^23014.Set liv tape #^2328 9.Upload program^235414.^24015.Reset history^242810.Debugger^245415.^1840"
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
   B1D1 00                 5245         .byte   0x00
                           5246 
                           5247 ; back to code
   B1D2 CE B1 D8      [ 3] 5248         ldx     #LB1D8       ; escape sequence?
   B1D5 7E 8A 1A      [ 3] 5249         jmp     L8A1A  
                           5250 
   B1D8                    5251 LB1D8:
                           5252         ; esc[2J ?
   B1D8 1B                 5253         .byte   0x1b
   B1D9 5B 32 4A 00        5254         .asciz  '[2J'
                           5255 
   B1DD CE 05 A0      [ 3] 5256         ldx     #0x05A0
   B1E0 CC 00 00      [ 3] 5257         ldd     #0x0000
   B1E3 FD 02 9E      [ 5] 5258         std     (0x029E)
   B1E6                    5259 LB1E6:
   B1E6 FC 02 9E      [ 5] 5260         ldd     (0x029E)
   B1E9 C3 00 01      [ 4] 5261         addd    #0x0001
   B1EC FD 02 9E      [ 5] 5262         std     (0x029E)
   B1EF 1A 83 0F A0   [ 5] 5263         cpd     #0x0FA0
   B1F3 24 28         [ 3] 5264         bcc     LB21D  
   B1F5 BD B2 23      [ 6] 5265         jsr     (0xB223)
   B1F8 25 04         [ 3] 5266         bcs     LB1FE  
   B1FA 3F            [14] 5267         swi
   B1FB 20 E9         [ 3] 5268         bra     LB1E6  
   B1FD 39            [ 5] 5269         rts
                           5270 
   B1FE                    5271 LB1FE:
   B1FE A7 00         [ 4] 5272         staa    0,X     
   B200 08            [ 3] 5273         inx
   B201 81 0D         [ 2] 5274         cmpa    #0x0D
   B203 26 02         [ 3] 5275         bne     LB207  
   B205 20 18         [ 3] 5276         bra     LB21F  
   B207                    5277 LB207:
   B207 81 1B         [ 2] 5278         cmpa    #0x1B
   B209 26 02         [ 3] 5279         bne     LB20D  
   B20B 20 10         [ 3] 5280         bra     LB21D  
   B20D                    5281 LB20D:
   B20D 7D 00 B3      [ 6] 5282         tst     (0x00B3)
   B210 27 03         [ 3] 5283         beq     LB215  
   B212 BD 8B 3B      [ 6] 5284         jsr     (0x8B3B)
   B215                    5285 LB215:
   B215 CC 00 00      [ 3] 5286         ldd     #0x0000
   B218 FD 02 9E      [ 5] 5287         std     (0x029E)
   B21B 20 C9         [ 3] 5288         bra     LB1E6  
   B21D                    5289 LB21D:
   B21D 0D            [ 2] 5290         sec
   B21E 39            [ 5] 5291         rts
                           5292 
   B21F                    5293 LB21F:
   B21F 6F 00         [ 6] 5294         clr     0,X     
   B221 0C            [ 2] 5295         clc
   B222 39            [ 5] 5296         rts
                           5297 
   B223 B6 18 0D      [ 4] 5298         ldaa    SCCCTRLB
   B226 44            [ 2] 5299         lsra
   B227 25 0B         [ 3] 5300         bcs     LB234  
   B229 4F            [ 2] 5301         clra
   B22A B7 18 0D      [ 4] 5302         staa    SCCCTRLB
   B22D 86 30         [ 2] 5303         ldaa    #0x30
   B22F B7 18 0D      [ 4] 5304         staa    SCCCTRLB
   B232 0C            [ 2] 5305         clc
   B233 39            [ 5] 5306         rts
                           5307 
   B234                    5308 LB234:
   B234 86 01         [ 2] 5309         ldaa    #0x01
   B236 B7 18 0D      [ 4] 5310         staa    SCCCTRLB
   B239 86 70         [ 2] 5311         ldaa    #0x70
   B23B B5 18 0D      [ 4] 5312         bita    SCCCTRLB
   B23E 26 05         [ 3] 5313         bne     LB245  
   B240 0D            [ 2] 5314         sec
   B241 B6 18 0F      [ 4] 5315         ldaa    SCCDATAB
   B244 39            [ 5] 5316         rts
                           5317 
   B245                    5318 LB245:
   B245 B6 18 0F      [ 4] 5319         ldaa    SCCDATAB
   B248 86 30         [ 2] 5320         ldaa    #0x30
   B24A B7 18 0C      [ 4] 5321         staa    SCCCTRLA
   B24D 0C            [ 2] 5322         clc
   B24E 39            [ 5] 5323         rts
                           5324 
   B24F 38            [ 5] 5325         pulx
   B250 18 CE 05 A0   [ 4] 5326         ldy     #0x05A0
   B254                    5327 LB254:
   B254 A6 00         [ 4] 5328         ldaa    0,X
   B256 27 11         [ 3] 5329         beq     LB269
   B258 08            [ 3] 5330         inx
   B259 18 A1 00      [ 5] 5331         cmpa    0,Y
   B25C 26 04         [ 3] 5332         bne     LB262
   B25E 18 08         [ 4] 5333         iny
   B260 20 F2         [ 3] 5334         bra     LB254
   B262                    5335 LB262:
   B262 A6 00         [ 4] 5336         ldaa    0,X
   B264 27 07         [ 3] 5337         beq     LB26D
   B266 08            [ 3] 5338         inx
   B267 20 F9         [ 3] 5339         bra     LB262
   B269                    5340 LB269:
   B269 08            [ 3] 5341         inx
   B26A 3C            [ 4] 5342         pshx
   B26B 0C            [ 2] 5343         clc
   B26C 39            [ 5] 5344         rts
   B26D                    5345 LB26D:
   B26D 08            [ 3] 5346         inx
   B26E 3C            [ 4] 5347         pshx
   B26F 0D            [ 2] 5348         sec
   B270 39            [ 5] 5349         rts
                           5350 
   B271 CE 05 A0      [ 3] 5351         ldx     #0x05A0
   B274                    5352 LB274:
   B274 A6 00         [ 4] 5353         ldaa    0,X
   B276 08            [ 3] 5354         inx
   B277 81 0D         [ 2] 5355         cmpa    #0x0D
   B279 26 F9         [ 3] 5356         bne     LB274
   B27B 09            [ 3] 5357         dex
   B27C 09            [ 3] 5358         dex
   B27D A6 00         [ 4] 5359         ldaa    0,X
   B27F 09            [ 3] 5360         dex
   B280 80 30         [ 2] 5361         suba    #0x30
   B282 97 B2         [ 3] 5362         staa    (0x00B2)
   B284 8C 05 9F      [ 4] 5363         cpx     #0x059F
   B287 27 0B         [ 3] 5364         beq     LB294
   B289 A6 00         [ 4] 5365         ldaa    0,X
   B28B 09            [ 3] 5366         dex
   B28C 80 30         [ 2] 5367         suba    #0x30
   B28E C6 0A         [ 2] 5368         ldab    #0x0A
   B290 3D            [10] 5369         mul
   B291 17            [ 2] 5370         tba
   B292 9B B2         [ 3] 5371         adda    (0x00B2)
   B294                    5372 LB294:
   B294 39            [ 5] 5373         rts
                           5374 
                           5375 ; text
   B295                    5376 LB295:
   B295 59 6F 75 20 68 61  5377         .asciz  'You have selected #1'
        76 65 20 73 65 6C
        65 63 74 65 64 20
        23 31 00
   B2AA                    5378 LB2AA:
   B2AA 59 6F 75 20 68 61  5379         .asciz  'You have selected #11'
        76 65 20 73 65 6C
        65 63 74 65 64 20
        23 31 31 00
                           5380 
                           5381 ; code
   B2C0 CE B2 C7      [ 3] 5382         ldx     #LB2C7      ; strange table
   B2C3 BD 8A 1A      [ 6] 5383         jsr     L8A1A  
   B2C6 39            [ 5] 5384         rts
                           5385 
   B2C7                    5386 LB2C7:
   B2C7 5E 32 30 30 31 25  5387         .asciz  "^2001%^2101%^2201%^2301%^2401%^2001"
        5E 32 31 30 31 25
        5E 32 32 30 31 25
        5E 32 33 30 31 25
        5E 32 34 30 31 25
        5E 32 30 30 31 00
                           5388 
   B2EB FA 20 FA 20 F6 22  5389         .byte   0xfa,0x20,0xfa,0x20,0xf6,0x22,0xf5,0x20
        F5 20
   B2F3 F5 20 F3 22 F2 20  5390         .byte   0xf5,0x20,0xf3,0x22,0xf2,0x20,0xe5,0x22
        E5 22
   B2FB E5 22 E2 20 D2 20  5391         .byte   0xe5,0x22,0xe2,0x20,0xd2,0x20,0xbe,0x00
        BE 00
   B303 BC 22 BB 30 B9 32  5392         .byte   0xbc,0x22,0xbb,0x30,0xb9,0x32,0xb9,0x32
        B9 32
   B30B B7 30 B6 32 B5 30  5393         .byte   0xb7,0x30,0xb6,0x32,0xb5,0x30,0xb4,0x32
        B4 32
   B313 B4 32 B3 20 B3 20  5394         .byte   0xb4,0x32,0xb3,0x20,0xb3,0x20,0xb1,0xa0
        B1 A0
   B31B B1 A0 B0 A2 AF A0  5395         .byte   0xb1,0xa0,0xb0,0xa2,0xaf,0xa0,0xaf,0xa6
        AF A6
   B323 AE A0 AE A6 AD A4  5396         .byte   0xae,0xa0,0xae,0xa6,0xad,0xa4,0xac,0xa0
        AC A0
   B32B AC A0 AB A0 AA A0  5397         .byte   0xac,0xa0,0xab,0xa0,0xaa,0xa0,0xaa,0xa0
        AA A0
   B333 A2 80 A0 A0 A0 A0  5398         .byte   0xa2,0x80,0xa0,0xa0,0xa0,0xa0,0x8d,0x80
        8D 80
   B33B 8A A0 7E 80 7B A0  5399         .byte   0x8a,0xa0,0x7e,0x80,0x7b,0xa0,0x79,0xa4
        79 A4
   B343 78 A0 77 A4 76 A0  5400         .byte   0x78,0xa0,0x77,0xa4,0x76,0xa0,0x75,0xa4
        75 A4
   B34B 74 A0 73 A4 72 A0  5401         .byte   0x74,0xa0,0x73,0xa4,0x72,0xa0,0x71,0xa4
        71 A4
   B353 70 A0 6F A4 6E A0  5402         .byte   0x70,0xa0,0x6f,0xa4,0x6e,0xa0,0x6d,0xa4
        6D A4
   B35B 6C A0 69 80 69 80  5403         .byte   0x6c,0xa0,0x69,0x80,0x69,0x80,0x67,0xa0
        67 A0
   B363 5E 20 58 24 57 20  5404         .byte   0x5e,0x20,0x58,0x24,0x57,0x20,0x57,0x20
        57 20
   B36B 56 24 55 20 54 24  5405         .byte   0x56,0x24,0x55,0x20,0x54,0x24,0x54,0x24
        54 24
   B373 53 20 52 24 52 24  5406         .byte   0x53,0x20,0x52,0x24,0x52,0x24,0x50,0x20
        50 20
   B37B 4F 24 4E 20 4D 24  5407         .byte   0x4f,0x24,0x4e,0x20,0x4d,0x24,0x4c,0x20
        4C 20
   B383 4C 20 4B 24 4A 20  5408         .byte   0x4c,0x20,0x4b,0x24,0x4a,0x20,0x49,0x20
        49 20
   B38B 49 00 48 20 47 20  5409         .byte   0x49,0x00,0x48,0x20,0x47,0x20,0x47,0x20
        47 20
   B393 46 20 45 24 45 24  5410         .byte   0x46,0x20,0x45,0x24,0x45,0x24,0x44,0x20
        44 20
   B39B 42 20 42 20 37 04  5411         .byte   0x42,0x20,0x42,0x20,0x37,0x04,0x35,0x20
        35 20
   B3A3 2E 04 2E 04 2D 20  5412         .byte   0x2e,0x04,0x2e,0x04,0x2d,0x20,0x23,0x24
        23 24
   B3AB 21 20 17 24 13 00  5413         .byte   0x21,0x20,0x17,0x24,0x13,0x00,0x11,0x24
        11 24
   B3B3 10 30 07 34 06 30  5414         .byte   0x10,0x30,0x07,0x34,0x06,0x30,0x05,0x30
        05 30
   B3BB FF FF D7 22 D5 20  5415         .byte   0xff,0xff,0xd7,0x22,0xd5,0x20,0xc9,0x22
        C9 22
   B3C3 C7 20 C4 24 C3 20  5416         .byte   0xc7,0x20,0xc4,0x24,0xc3,0x20,0xc2,0x24
        C2 24
   B3CB C1 20 BF 24 BF 24  5417         .byte   0xc1,0x20,0xbf,0x24,0xbf,0x24,0xbe,0x20
        BE 20
   B3D3 BD 24 BC 20 BB 24  5418         .byte   0xbd,0x24,0xbc,0x20,0xbb,0x24,0xba,0x20
        BA 20
   B3DB B9 20 B8 24 B7 20  5419         .byte   0xb9,0x20,0xb8,0x24,0xb7,0x20,0xb4,0x00
        B4 00
   B3E3 B4 00 B2 20 A9 20  5420         .byte   0xb4,0x00,0xb2,0x20,0xa9,0x20,0xa3,0x20
        A3 20
   B3EB A2 20 A1 20 A0 20  5421         .byte   0xa2,0x20,0xa1,0x20,0xa0,0x20,0xa0,0x20
        A0 20
   B3F3 9F 20 9F 20 9E 20  5422         .byte   0x9f,0x20,0x9f,0x20,0x9e,0x20,0x9d,0x24
        9D 24
   B3FB 9D 24 9B 20 9A 24  5423         .byte   0x9d,0x24,0x9b,0x20,0x9a,0x24,0x99,0x20
        99 20
   B403 98 20 97 24 97 24  5424         .byte   0x98,0x20,0x97,0x24,0x97,0x24,0x95,0x20
        95 20
   B40B 95 20 94 00 94 00  5425         .byte   0x95,0x20,0x94,0x00,0x94,0x00,0x93,0x20
        93 20
   B413 92 00 92 00 91 20  5426         .byte   0x92,0x00,0x92,0x00,0x91,0x20,0x90,0x20
        90 20
   B41B 90 20 8F 20 8D 20  5427         .byte   0x90,0x20,0x8f,0x20,0x8d,0x20,0x8d,0x20
        8D 20
   B423 81 00 7F 20 79 00  5428         .byte   0x81,0x00,0x7f,0x20,0x79,0x00,0x79,0x00
        79 00
   B42B 78 20 76 20 6B 00  5429         .byte   0x78,0x20,0x76,0x20,0x6b,0x00,0x69,0x20
        69 20
   B433 5E 00 5C 20 5B 30  5430         .byte   0x5e,0x00,0x5c,0x20,0x5b,0x30,0x52,0x10
        52 10
   B43B 51 30 50 30 50 30  5431         .byte   0x51,0x30,0x50,0x30,0x50,0x30,0x4f,0x20
        4F 20
   B443 4E 20 4E 20 4D 20  5432         .byte   0x4e,0x20,0x4e,0x20,0x4d,0x20,0x46,0xa0
        46 A0
   B44B 45 A0 3D A0 3D A0  5433         .byte   0x45,0xa0,0x3d,0xa0,0x3d,0xa0,0x39,0x20
        39 20
   B453 2A 00 28 20 1E 00  5434         .byte   0x2a,0x00,0x28,0x20,0x1e,0x00,0x1c,0x22
        1C 22
   B45B 1C 22 1B 20 1A 22  5435         .byte   0x1c,0x22,0x1b,0x20,0x1a,0x22,0x19,0x20
        19 20
   B463 18 22 18 22 16 20  5436         .byte   0x18,0x22,0x18,0x22,0x16,0x20,0x15,0x22
        15 22
   B46B 15 22 14 A0 13 A2  5437         .byte   0x15,0x22,0x14,0xa0,0x13,0xa2,0x11,0xa0
        11 A0
   B473 FF FF BE 00 BC 22  5438         .byte   0xff,0xff,0xbe,0x00,0xbc,0x22,0xbb,0x30
        BB 30
   B47B B9 32 B9 32 B7 30  5439         .byte   0xb9,0x32,0xb9,0x32,0xb7,0x30,0xb6,0x32
        B6 32
   B483 B5 30 B4 32 B4 32  5440         .byte   0xb5,0x30,0xb4,0x32,0xb4,0x32,0xb3,0x20
        B3 20
   B48B B3 20 B1 A0 B1 A0  5441         .byte   0xb3,0x20,0xb1,0xa0,0xb1,0xa0,0xb0,0xa2
        B0 A2
   B493 AF A0 AF A6 AE A0  5442         .byte   0xaf,0xa0,0xaf,0xa6,0xae,0xa0,0xae,0xa6
        AE A6
   B49B AD A4 AC A0 AC A0  5443         .byte   0xad,0xa4,0xac,0xa0,0xac,0xa0,0xab,0xa0
        AB A0
   B4A3 AA A0 AA A0 A2 80  5444         .byte   0xaa,0xa0,0xaa,0xa0,0xa2,0x80,0xa0,0xa0
        A0 A0
   B4AB A0 A0 8D 80 8A A0  5445         .byte   0xa0,0xa0,0x8d,0x80,0x8a,0xa0,0x7e,0x80
        7E 80
   B4B3 7B A0 79 A4 78 A0  5446         .byte   0x7b,0xa0,0x79,0xa4,0x78,0xa0,0x77,0xa4
        77 A4
   B4BB 76 A0 75 A4 74 A0  5447         .byte   0x76,0xa0,0x75,0xa4,0x74,0xa0,0x73,0xa4
        73 A4
   B4C3 72 A0 71 A4 70 A0  5448         .byte   0x72,0xa0,0x71,0xa4,0x70,0xa0,0x6f,0xa4
        6F A4
   B4CB 6E A0 6D A4 6C A0  5449         .byte   0x6e,0xa0,0x6d,0xa4,0x6c,0xa0,0x69,0x80
        69 80
   B4D3 69 80 67 A0 5E 20  5450         .byte   0x69,0x80,0x67,0xa0,0x5e,0x20,0x58,0x24
        58 24
   B4DB 57 20 57 20 56 24  5451         .byte   0x57,0x20,0x57,0x20,0x56,0x24,0x55,0x20
        55 20
   B4E3 54 24 54 24 53 20  5452         .byte   0x54,0x24,0x54,0x24,0x53,0x20,0x52,0x24
        52 24
   B4EB 52 24 50 20 4F 24  5453         .byte   0x52,0x24,0x50,0x20,0x4f,0x24,0x4e,0x20
        4E 20
   B4F3 4D 24 4C 20 4C 20  5454         .byte   0x4d,0x24,0x4c,0x20,0x4c,0x20,0x4b,0x24
        4B 24
   B4FB 4A 20 49 20 49 00  5455         .byte   0x4a,0x20,0x49,0x20,0x49,0x00,0x48,0x20
        48 20
   B503 47 20 47 20 46 20  5456         .byte   0x47,0x20,0x47,0x20,0x46,0x20,0x45,0x24
        45 24
   B50B 45 24 44 20 42 20  5457         .byte   0x45,0x24,0x44,0x20,0x42,0x20,0x42,0x20
        42 20
   B513 37 04 35 20 2E 04  5458         .byte   0x37,0x04,0x35,0x20,0x2e,0x04,0x2e,0x04
        2E 04
   B51B 2D 20 23 24 21 20  5459         .byte   0x2d,0x20,0x23,0x24,0x21,0x20,0x17,0x24
        17 24
   B523 13 00 11 24 10 30  5460         .byte   0x13,0x00,0x11,0x24,0x10,0x30,0x07,0x34
        07 34
   B52B 06 30 05 30 FF FF  5461         .byte   0x06,0x30,0x05,0x30,0xff,0xff,0xcd,0x20
        CD 20
   B533 CC 20 CB 20 CB 20  5462         .byte   0xcc,0x20,0xcb,0x20,0xcb,0x20,0xca,0x00
        CA 00
   B53B C9 20 C9 20 C8 20  5463         .byte   0xc9,0x20,0xc9,0x20,0xc8,0x20,0xc1,0xa0
        C1 A0
   B543 C0 A0 B8 A0 B8 20  5464         .byte   0xc0,0xa0,0xb8,0xa0,0xb8,0x20,0xb4,0x20
        B4 20
   B54B A6 00 A4 20 99 00  5465         .byte   0xa6,0x00,0xa4,0x20,0x99,0x00,0x97,0x22
        97 22
   B553 97 22 96 20 95 22  5466         .byte   0x97,0x22,0x96,0x20,0x95,0x22,0x94,0x20
        94 20
   B55B 93 22 93 22 91 20  5467         .byte   0x93,0x22,0x93,0x22,0x91,0x20,0x90,0x20
        90 20
   B563 90 20 8D A0 8C A0  5468         .byte   0x90,0x20,0x8d,0xa0,0x8c,0xa0,0x7d,0xa2
        7D A2
   B56B 7D A2 7B A0 7B A0  5469         .byte   0x7d,0xa2,0x7b,0xa0,0x7b,0xa0,0x79,0xa2
        79 A2
   B573 79 A2 77 A0 77 A0  5470         .byte   0x79,0xa2,0x77,0xa0,0x77,0xa0,0x76,0x80
        76 80
   B57B 75 A0 6E 20 67 24  5471         .byte   0x75,0xa0,0x6e,0x20,0x67,0x24,0x66,0x20
        66 20
   B583 65 24 64 20 63 24  5472         .byte   0x65,0x24,0x64,0x20,0x63,0x24,0x63,0x24
        63 24
   B58B 61 20 60 24 5F 20  5473         .byte   0x61,0x20,0x60,0x24,0x5f,0x20,0x5e,0x20
        5E 20
   B593 5D 24 5C 20 5B 24  5474         .byte   0x5d,0x24,0x5c,0x20,0x5b,0x24,0x5a,0x20
        5A 20
   B59B 59 24 58 20 56 20  5475         .byte   0x59,0x24,0x58,0x20,0x56,0x20,0x55,0x04
        55 04
   B5A3 54 00 53 24 52 20  5476         .byte   0x54,0x00,0x53,0x24,0x52,0x20,0x52,0x20
        52 20
   B5AB 4F 24 4F 24 4E 30  5477         .byte   0x4f,0x24,0x4f,0x24,0x4e,0x30,0x4d,0x30
        4D 30
   B5B3 47 10 45 30 35 30  5478         .byte   0x47,0x10,0x45,0x30,0x35,0x30,0x33,0x10
        33 10
   B5BB 31 30 31 30 1D 20  5479         .byte   0x31,0x30,0x31,0x30,0x1d,0x20,0xff,0xff
        FF FF
   B5C3 A9 20 A3 20 A2 20  5480         .byte   0xa9,0x20,0xa3,0x20,0xa2,0x20,0xa1,0x20
        A1 20
   B5CB A0 20 A0 20 9F 20  5481         .byte   0xa0,0x20,0xa0,0x20,0x9f,0x20,0x9f,0x20
        9F 20
   B5D3 9E 20 9D 24 9D 24  5482         .byte   0x9e,0x20,0x9d,0x24,0x9d,0x24,0x9b,0x20
        9B 20
   B5DB 9A 24 99 20 98 20  5483         .byte   0x9a,0x24,0x99,0x20,0x98,0x20,0x97,0x24
        97 24
   B5E3 97 24 95 20 95 20  5484         .byte   0x97,0x24,0x95,0x20,0x95,0x20,0x94,0x00
        94 00
   B5EB 94 00 93 20 92 00  5485         .byte   0x94,0x00,0x93,0x20,0x92,0x00,0x92,0x00
        92 00
   B5F3 91 20 90 20 90 20  5486         .byte   0x91,0x20,0x90,0x20,0x90,0x20,0x8f,0x20
        8F 20
   B5FB 8D 20 8D 20 81 00  5487         .byte   0x8d,0x20,0x8d,0x20,0x81,0x00,0x7f,0x20
        7F 20
   B603 79 00 79 00 78 20  5488         .byte   0x79,0x00,0x79,0x00,0x78,0x20,0x76,0x20
        76 20
   B60B 6B 00 69 20 5E 00  5489         .byte   0x6b,0x00,0x69,0x20,0x5e,0x00,0x5c,0x20
        5C 20
   B613 5B 30 52 10 51 30  5490         .byte   0x5b,0x30,0x52,0x10,0x51,0x30,0x50,0x30
        50 30
   B61B 50 30 4F 20 4E 20  5491         .byte   0x50,0x30,0x4f,0x20,0x4e,0x20,0x4e,0x20
        4E 20
   B623 4D 20 46 A0 45 A0  5492         .byte   0x4d,0x20,0x46,0xa0,0x45,0xa0,0x3d,0xa0
        3D A0
   B62B 3D A0 39 20 2A 00  5493         .byte   0x3d,0xa0,0x39,0x20,0x2a,0x00,0x28,0x20
        28 20
   B633 1E 00 1C 22 1C 22  5494         .byte   0x1e,0x00,0x1c,0x22,0x1c,0x22,0x1b,0x20
        1B 20
   B63B 1A 22 19 20 18 22  5495         .byte   0x1a,0x22,0x19,0x20,0x18,0x22,0x18,0x22
        18 22
   B643 16 20 15 22 15 22  5496         .byte   0x16,0x20,0x15,0x22,0x15,0x22,0x14,0xa0
        14 A0
   B64B 13 A2 11 A0        5497         .byte   0x13,0xa2,0x11,0xa0
                           5498 
                           5499 ; All empty (0xFFs) in this gap
                           5500 
   F780                    5501         .org    0xf780
                           5502 
                           5503 ; Table???
   F780 57                 5504         .byte   0x57
   F781 0B                 5505         .byte   0x0b
   F782 00                 5506         .byte   0x00
   F783 00                 5507         .byte   0x00
   F784 00                 5508         .byte   0x00
   F785 00                 5509         .byte   0x00
   F786 08                 5510         .byte   0x08
   F787 00                 5511         .byte   0x00
   F788 00                 5512         .byte   0x00
   F789 00                 5513         .byte   0x00
   F78A 20                 5514         .byte   0x20
   F78B 00                 5515         .byte   0x00
   F78C 00                 5516         .byte   0x00
   F78D 00                 5517         .byte   0x00
   F78E 80                 5518         .byte   0x80
   F78F 00                 5519         .byte   0x00
   F790 00                 5520         .byte   0x00
   F791 00                 5521         .byte   0x00
   F792 00                 5522         .byte   0x00
   F793 00                 5523         .byte   0x00
   F794 00                 5524         .byte   0x00
   F795 04                 5525         .byte   0x04
   F796 00                 5526         .byte   0x00
   F797 00                 5527         .byte   0x00
   F798 00                 5528         .byte   0x00
   F799 10                 5529         .byte   0x10
   F79A 00                 5530         .byte   0x00
   F79B 00                 5531         .byte   0x00
   F79C 00                 5532         .byte   0x00
   F79D 00                 5533         .byte   0x00
   F79E 00                 5534         .byte   0x00
   F79F 00                 5535         .byte   0x00
   F7A0 40                 5536         .byte   0x40
   F7A1 12                 5537         .byte   0x12
   F7A2 20                 5538         .byte   0x20
   F7A3 09                 5539         .byte   0x09
   F7A4 80                 5540         .byte   0x80
   F7A5 24                 5541         .byte   0x24
   F7A6 02                 5542         .byte   0x02
   F7A7 00                 5543         .byte   0x00
   F7A8 40                 5544         .byte   0x40
   F7A9 12                 5545         .byte   0x12
   F7AA 20                 5546         .byte   0x20
   F7AB 09                 5547         .byte   0x09
   F7AC 80                 5548         .byte   0x80
   F7AD 24                 5549         .byte   0x24
   F7AE 04                 5550         .byte   0x04
   F7AF 00                 5551         .byte   0x00
   F7B0 00                 5552         .byte   0x00
   F7B1 00                 5553         .byte   0x00
   F7B2 00                 5554         .byte   0x00
   F7B3 00                 5555         .byte   0x00
   F7B4 00                 5556         .byte   0x00
   F7B5 00                 5557         .byte   0x00
   F7B6 00                 5558         .byte   0x00
   F7B7 00                 5559         .byte   0x00
   F7B8 00                 5560         .byte   0x00
   F7B9 00                 5561         .byte   0x00
   F7BA 00                 5562         .byte   0x00
   F7BB 00                 5563         .byte   0x00
   F7BC 08                 5564         .byte   0x08
   F7BD 00                 5565         .byte   0x00
   F7BE 00                 5566         .byte   0x00
   F7BF 00                 5567         .byte   0x00
   F7C0 00                 5568         .byte   0x00
                           5569 ;
                           5570 ; is the rest of this table 0xff, or is this margin??
                           5571 ;
   F800                    5572         .org    0xf800
                           5573 ; Reset
   F800                    5574 RESET:
   F800 0F            [ 2] 5575         sei                 ; disable interrupts
   F801 86 03         [ 2] 5576         ldaa    #0x03
   F803 B7 10 24      [ 4] 5577         staa    TMSK2       ; disable irqs, set prescaler to 16
   F806 86 80         [ 2] 5578         ldaa    #0x80
   F808 B7 10 22      [ 4] 5579         staa    TMSK1       ; enable OC1 irq
   F80B 86 FE         [ 2] 5580         ldaa    #0xFE
   F80D B7 10 35      [ 4] 5581         staa    BPROT       ; protect everything except $xE00-$xE1F
   F810 96 07         [ 3] 5582         ldaa    0x0007      ;
   F812 81 DB         [ 2] 5583         cmpa    #0xDB       ; special unprotect mode???
   F814 26 06         [ 3] 5584         bne     LF81C       ; if not, jump ahead
   F816 7F 10 35      [ 6] 5585         clr     BPROT       ; else unprotect everything
   F819 7F 00 07      [ 6] 5586         clr     0x0007     ; reset special unprotect mode???
   F81C                    5587 LF81C:
   F81C 8E 01 FF      [ 3] 5588         lds     #0x01FF     ; init SP
   F81F 86 A5         [ 2] 5589         ldaa    #0xA5
   F821 B7 10 5D      [ 4] 5590         staa    CSCTL       ; enable external IO:
                           5591                             ; IO1EN,  BUSSEL, active LOW
                           5592                             ; IO2EN,  PIA/SCCSEL, active LOW
                           5593                             ; CSPROG, ROMSEL priority over RAMSEL 
                           5594                             ; CSPROG, ROMSEL enabled, 32K, $8000-$FFFF
   F824 86 01         [ 2] 5595         ldaa    #0x01
   F826 B7 10 5F      [ 4] 5596         staa    CSGSIZ      ; CSGEN,  RAMSEL active low
                           5597                             ; CSGEN,  RAMSEL 32K
   F829 86 00         [ 2] 5598         ldaa    #0x00
   F82B B7 10 5E      [ 4] 5599         staa    CSGADR      ; CSGEN,  RAMSEL = $0000-$7FFF (except internal regs)
   F82E 86 F0         [ 2] 5600         ldaa    #0xF0
   F830 B7 10 5C      [ 4] 5601         staa    CSSTRH      ; 3 cycle clock stretching on BUSSEL and LCRS
   F833 7F 00 00      [ 6] 5602         clr     0x0000      ; ????? Done with basic init?
                           5603 
                           5604 ; Initialize Main PIA
   F836 86 30         [ 2] 5605         ldaa    #0x30       ;
   F838 B7 18 05      [ 4] 5606         staa    PIA0CRA     ; control register A, CA2=0, sel DDRA
   F83B B7 18 07      [ 4] 5607         staa    PIA0CRB     ; control register B, CB2=0, sel DDRB
   F83E 86 FF         [ 2] 5608         ldaa    #0xFF
   F840 B7 18 06      [ 4] 5609         staa    PIA0DDRB    ; select B0-B7 to be outputs
   F843 86 78         [ 2] 5610         ldaa    #0x78       ;
   F845 B7 18 04      [ 4] 5611         staa    PIA0DDRA    ; select A3-A6 to be outputs
   F848 86 34         [ 2] 5612         ldaa    #0x34       ;
   F84A B7 18 05      [ 4] 5613         staa    PIA0CRA     ; select output register A
   F84D B7 18 07      [ 4] 5614         staa    PIA0CRB     ; select output register B
   F850 C6 FF         [ 2] 5615         ldab    #0xFF
   F852 BD F9 C5      [ 6] 5616         jsr     BUTNLIT     ; turn on all button lights
   F855 20 13         [ 3] 5617         bra     LF86A       ; jump past data table
                           5618 
                           5619 ; Data loaded into SCCCTRLB SCC
   F857 09 4A              5620         .byte   0x09,0x4a   ; channel reset B, master irq enable, no vector
   F859 01 10              5621         .byte   0x01,0x10   ; irq on all character received
   F85B 0C 18              5622         .byte   0x0c,0x18   ; Lower byte of time constant
   F85D 0D 00              5623         .byte   0x0d,0x00   ; Upper byte of time constant
   F85F 04 44              5624         .byte   0x04,0x44   ; X16 clock mode, 8-bit sync char, 1 stop bit, no parity
   F861 0E 63              5625         .byte   0x0e,0x63   ; Disable DPLL, BR enable & source
   F863 05 68              5626         .byte   0x05,0x68   ; No DTR/RTS, Tx 8 bits/char, Tx enable
   F865 0B 56              5627         .byte   0x0b,0x56   ; Rx & Tx & TRxC clk from BR gen
   F867 03 C1              5628         .byte   0x03,0xc1   ; Rx 8 bits/char, Rx Enable
                           5629         ;   tc = 4Mhz / (2 * DesiredRate * BRClockPeriod) - 2
                           5630         ;   DesiredRate=~4800 bps with tc=0x18 and BRClockPeriod=16
   F869 FF                 5631         .byte   0xff        ; end of table marker
                           5632 
                           5633 ; init SCC (8530)
   F86A                    5634 LF86A:
   F86A CE F8 57      [ 3] 5635         ldx     #0xF857
   F86D                    5636 LF86D:
   F86D A6 00         [ 4] 5637         ldaa    0,X
   F86F 81 FF         [ 2] 5638         cmpa    #0xFF
   F871 27 06         [ 3] 5639         beq     LF879
   F873 B7 18 0D      [ 4] 5640         staa    SCCCTRLB
   F876 08            [ 3] 5641         inx
   F877 20 F4         [ 3] 5642         bra     LF86D
                           5643 
                           5644 ; Setup normal SCI, 8 data bits, 1 stop bit
                           5645 ; Interrupts disabled, Transmitter and Receiver enabled
                           5646 ; prescaler = /13, SCR=/2, rate = 9600 baud at 16Mhz clock
                           5647 
   F879                    5648 LF879:
   F879 86 00         [ 2] 5649         ldaa    #0x00
   F87B B7 10 2C      [ 4] 5650         staa    SCCR1  
   F87E 86 0C         [ 2] 5651         ldaa    #0x0C
   F880 B7 10 2D      [ 4] 5652         staa    SCCR2  
   F883 86 31         [ 2] 5653         ldaa    #0x31
   F885 B7 10 2B      [ 4] 5654         staa    BAUD  
                           5655 
                           5656 ; Initialize all RAM vectors to RTI: 
                           5657 ; Opcode 0x3b into vectors at 0x0100 through 0x0139
                           5658 
   F888 CE 01 00      [ 3] 5659         ldx     #0x0100
   F88B 86 3B         [ 2] 5660         ldaa    #0x3B       ; RTI opcode
   F88D                    5661 LF88D:
   F88D A7 00         [ 4] 5662         staa    0,X
   F88F 08            [ 3] 5663         inx
   F890 08            [ 3] 5664         inx
   F891 08            [ 3] 5665         inx
   F892 8C 01 3C      [ 4] 5666         cpx     #0x013C
   F895 25 F6         [ 3] 5667         bcs     LF88D
   F897 C6 F0         [ 2] 5668         ldab    #0xF0
   F899 F7 18 04      [ 4] 5669         stab    PIA0PRA     ; enable LCD backlight, disable RESET button light
   F89C 86 7E         [ 2] 5670         ldaa    #0x7E
   F89E 97 03         [ 3] 5671         staa    (0x0003)    ; Put a jump instruction here???
                           5672 
                           5673 ; Non-destructive ram test:
                           5674 ;
                           5675 ; HC11 Internal RAM: 0x0000-0x3ff
                           5676 ; External NVRAM:    0x2000-0x7fff
                           5677 ;
                           5678 ; Note:
                           5679 ; External NVRAM:    0x0400-0xfff is also available, but not tested
                           5680 
   F8A0 CE 00 00      [ 3] 5681         ldx     #0x0000
   F8A3                    5682 LF8A3:
   F8A3 E6 00         [ 4] 5683         ldab    0,X         ; save value
   F8A5 86 55         [ 2] 5684         ldaa    #0x55
   F8A7 A7 00         [ 4] 5685         staa    0,X
   F8A9 A1 00         [ 4] 5686         cmpa    0,X
   F8AB 26 19         [ 3] 5687         bne     LF8C6
   F8AD 49            [ 2] 5688         rola
   F8AE A7 00         [ 4] 5689         staa    0,X
   F8B0 A1 00         [ 4] 5690         cmpa    0,X
   F8B2 26 12         [ 3] 5691         bne     LF8C6
   F8B4 E7 00         [ 4] 5692         stab    0,X         ; restore value
   F8B6 08            [ 3] 5693         inx
   F8B7 8C 04 00      [ 4] 5694         cpx     #0x0400
   F8BA 26 03         [ 3] 5695         bne     LF8BF
   F8BC CE 20 00      [ 3] 5696         ldx     #0x2000
   F8BF                    5697 LF8BF:  
   F8BF 8C 80 00      [ 4] 5698         cpx     #0x8000
   F8C2 26 DF         [ 3] 5699         bne     LF8A3
   F8C4 20 04         [ 3] 5700         bra     LF8CA
                           5701 
   F8C6                    5702 LF8C6:
   F8C6 86 01         [ 2] 5703         ldaa    #0x01       ; Mark Failed RAM test
   F8C8 97 00         [ 3] 5704         staa    (0x0000)
                           5705 ; 
   F8CA                    5706 LF8CA:
   F8CA C6 01         [ 2] 5707         ldab    #0x01
   F8CC BD F9 95      [ 6] 5708         jsr     DIAGDGT     ; write digit 1 to diag display
   F8CF B6 10 35      [ 4] 5709         ldaa    BPROT  
   F8D2 26 0F         [ 3] 5710         bne     LF8E3       ; if something is protected, jump ahead
   F8D4 B6 30 00      [ 4] 5711         ldaa    (0x3000)    ; NVRAM
   F8D7 81 7E         [ 2] 5712         cmpa    #0x7E
   F8D9 26 08         [ 3] 5713         bne     LF8E3       ; if RAM(0x3000) == 0x7E, jump ahead anyway (special unlock?)
                           5714 
                           5715 ; error?
   F8DB C6 0E         [ 2] 5716         ldab    #0x0E
   F8DD BD F9 95      [ 6] 5717         jsr     DIAGDGT      ; write digit E to diag display
   F8E0 7E 30 00      [ 3] 5718         jmp     (0x3000)     ; jump to routine in NVRAM?
                           5719 
                           5720 ; checking for serial connection
                           5721 
   F8E3                    5722 LF8E3:
   F8E3 CE F0 00      [ 3] 5723         ldx     #0xF000     ; timeout counter
   F8E6                    5724 LF8E6:
   F8E6 01            [ 2] 5725         nop
   F8E7 01            [ 2] 5726         nop
   F8E8 09            [ 3] 5727         dex
   F8E9 27 0B         [ 3] 5728         beq     LF8F6       ; if time is up, jump ahead
   F8EB BD F9 45      [ 6] 5729         jsr     SERIALR     ; else read serial data if available
   F8EE 24 F6         [ 3] 5730         bcc     LF8E6       ; if no data available, loop
   F8F0 81 1B         [ 2] 5731         cmpa    #0x1B       ; if serial data was read, is it an ESC?
   F8F2 27 29         [ 3] 5732         beq     LF91D       ; if so, jump to echo hex char routine?
   F8F4 20 F0         [ 3] 5733         bra     LF8E6       ; else loop
   F8F6                    5734 LF8F6:
   F8F6 B6 80 00      [ 4] 5735         ldaa    L8000       ; check if this is a regular rom?
   F8F9 81 7E         [ 2] 5736         cmpa    #0x7E        
   F8FB 26 0B         [ 3] 5737         bne     MINIMON     ; if not, jump ahead
                           5738 
   F8FD C6 0A         [ 2] 5739         ldab    #0x0A
   F8FF BD F9 95      [ 6] 5740         jsr     DIAGDGT     ; else write digit A to diag display
                           5741 
   F902 BD 80 00      [ 6] 5742         jsr     L8000       ; jump to start of rom routine
   F905 0F            [ 2] 5743         sei                 ; if we ever come return, just loop and do it all again
   F906 20 EE         [ 3] 5744         bra     LF8F6
                           5745 
                           5746 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           5747 
   F908                    5748 MINIMON:
   F908 C6 10         [ 2] 5749         ldab    #0x10       ; not a regular rom
   F90A BD F9 95      [ 6] 5750         jsr     DIAGDGT     ; blank the diag display
                           5751 
   F90D BD F9 D8      [ 6] 5752         jsr     SERMSGW     ; enter the mini-monitor???
   F910 4D 49 4E 49 2D 4D  5753         .ascis  'MINI-MON'
        4F CE
                           5754 
   F918 C6 10         [ 2] 5755         ldab    #0x10
   F91A BD F9 95      [ 6] 5756         jsr     DIAGDGT     ; blank the diag display
                           5757 
   F91D                    5758 LF91D:
   F91D 7F 00 05      [ 6] 5759         clr     (0x0005)
   F920 7F 00 04      [ 6] 5760         clr     (0x0004)
   F923 7F 00 02      [ 6] 5761         clr     (0x0002)
   F926 7F 00 06      [ 6] 5762         clr     (0x0006)
                           5763 
   F929 BD F9 D8      [ 6] 5764         jsr     SERMSGW
   F92C 0D 0A BE           5765         .ascis  '\r\n>'
                           5766 
                           5767 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           5768 
                           5769 ; convert A to 2 hex digits and transmit
   F92F                    5770 SERHEXW:
   F92F 36            [ 3] 5771         psha
   F930 44            [ 2] 5772         lsra
   F931 44            [ 2] 5773         lsra
   F932 44            [ 2] 5774         lsra
   F933 44            [ 2] 5775         lsra
   F934 BD F9 38      [ 6] 5776         jsr     LF938
   F937 32            [ 4] 5777         pula
   F938                    5778 LF938:
   F938 84 0F         [ 2] 5779         anda    #0x0F
   F93A 8A 30         [ 2] 5780         oraa    #0x30
   F93C 81 3A         [ 2] 5781         cmpa    #0x3A
   F93E 25 02         [ 3] 5782         bcs     LF942
   F940 8B 07         [ 2] 5783         adda    #0x07
   F942                    5784 LF942:
   F942 7E F9 6F      [ 3] 5785         jmp     SERIALW
                           5786 
                           5787 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           5788 
                           5789 ; serial read non-blocking
   F945                    5790 SERIALR:
   F945 B6 10 2E      [ 4] 5791         ldaa    SCSR  
   F948 85 20         [ 2] 5792         bita    #0x20
   F94A 26 09         [ 3] 5793         bne     LF955
   F94C 0C            [ 2] 5794         clc
   F94D 39            [ 5] 5795         rts
                           5796 
                           5797 ; serial blocking read
   F94E                    5798 SERBLKR:
   F94E B6 10 2E      [ 4] 5799         ldaa    SCSR        ; read serial status
   F951 85 20         [ 2] 5800         bita    #0x20
   F953 27 F9         [ 3] 5801         beq     SERBLKR     ; if RDRF=0, loop
                           5802 
                           5803 ; read serial data, (assumes it's ready)
   F955                    5804 LF955:
   F955 B6 10 2E      [ 4] 5805         ldaa    SCSR        ; read serial status
   F958 85 02         [ 2] 5806         bita    #0x02
   F95A 26 09         [ 3] 5807         bne     LF965       ; if FE=1, clear it
   F95C 85 08         [ 2] 5808         bita    #0x08
   F95E 26 05         [ 3] 5809         bne     LF965       ; if OR=1, clear it
   F960 B6 10 2F      [ 4] 5810         ldaa    SCDR        ; otherwise, good data
   F963 0D            [ 2] 5811         sec
   F964 39            [ 5] 5812         rts
                           5813 
   F965                    5814 LF965:
   F965 B6 10 2F      [ 4] 5815         ldaa    SCDR        ; clear any error
   F968 86 2F         [ 2] 5816         ldaa    #0x2F       ; '/'   
   F96A BD F9 6F      [ 6] 5817         jsr     SERIALW
   F96D 20 DF         [ 3] 5818         bra     SERBLKR     ; go to wait for a character
                           5819 
                           5820 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           5821 
                           5822 ; Send A to SCI with CR turned to CRLF
   F96F                    5823 SERIALW:
   F96F 81 0D         [ 2] 5824         cmpa    #0x0D       ; CR?
   F971 27 02         [ 3] 5825         beq     LF975       ; if so echo CR+LF
   F973 20 07         [ 3] 5826         bra     SERRAWW     ; else just echo it
   F975                    5827 LF975:
   F975 86 0D         [ 2] 5828         ldaa    #0x0D
   F977 BD F9 7C      [ 6] 5829         jsr     SERRAWW
   F97A 86 0A         [ 2] 5830         ldaa    #0x0A
                           5831 
                           5832 ; send a char to SCI
   F97C                    5833 SERRAWW:
   F97C F6 10 2E      [ 4] 5834         ldab    SCSR        ; wait for ready to send
   F97F C5 40         [ 2] 5835         bitb    #0x40
   F981 27 F9         [ 3] 5836         beq     SERRAWW
   F983 B7 10 2F      [ 4] 5837         staa    SCDR        ; send it
   F986 39            [ 5] 5838         rts
                           5839 
                           5840 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           5841 
                           5842 ; Unused?
   F987                    5843 LF987:
   F987 BD F9 4E      [ 6] 5844         jsr     SERBLKR     ; get a serial char
   F98A 81 7A         [ 2] 5845         cmpa    #0x7A       ;'z'
   F98C 22 06         [ 3] 5846         bhi     LF994
   F98E 81 61         [ 2] 5847         cmpa    #0x61       ;'a'
   F990 25 02         [ 3] 5848         bcs     LF994
   F992 82 20         [ 2] 5849         sbca    #0x20       ;convert to upper case?
   F994                    5850 LF994:
   F994 39            [ 5] 5851         rts
                           5852 
                           5853 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           5854 
                           5855 ; Write hex digit arg in B to diagnostic lights
                           5856 ; or B=0x10 or higher for blank
                           5857 
   F995                    5858 DIAGDGT:
   F995 36            [ 3] 5859         psha
   F996 C1 11         [ 2] 5860         cmpb    #0x11
   F998 25 02         [ 3] 5861         bcs     LF99C
   F99A C6 10         [ 2] 5862         ldab    #0x10
   F99C                    5863 LF99C:
   F99C CE F9 B4      [ 3] 5864         ldx     #LF9B4
   F99F 3A            [ 3] 5865         abx
   F9A0 A6 00         [ 4] 5866         ldaa    0,X
   F9A2 B7 18 06      [ 4] 5867         staa    PIA0PRB     ; write arg to local data bus
   F9A5 B6 18 04      [ 4] 5868         ldaa    PIA0PRA     ; read from Port A
   F9A8 8A 20         [ 2] 5869         oraa    #0x20       ; bit 5 high
   F9AA B7 18 04      [ 4] 5870         staa    PIA0PRA     ; write back to Port A
   F9AD 84 DF         [ 2] 5871         anda    #0xDF       ; bit 5 low
   F9AF B7 18 04      [ 4] 5872         staa    PIA0PRA     ; write back to Port A
   F9B2 32            [ 4] 5873         pula
   F9B3 39            [ 5] 5874         rts
                           5875 
                           5876 ; 7 segment patterns - XGFEDCBA
   F9B4                    5877 LF9B4:
   F9B4 C0                 5878         .byte   0xc0    ; 0
   F9B5 F9                 5879         .byte   0xf9    ; 1
   F9B6 A4                 5880         .byte   0xa4    ; 2
   F9B7 B0                 5881         .byte   0xb0    ; 3
   F9B8 99                 5882         .byte   0x99    ; 4
   F9B9 92                 5883         .byte   0x92    ; 5
   F9BA 82                 5884         .byte   0x82    ; 6
   F9BB F8                 5885         .byte   0xf8    ; 7
   F9BC 80                 5886         .byte   0x80    ; 8
   F9BD 90                 5887         .byte   0x90    ; 9
   F9BE 88                 5888         .byte   0x88    ; A 
   F9BF 83                 5889         .byte   0x83    ; b
   F9C0 C6                 5890         .byte   0xc6    ; C
   F9C1 A1                 5891         .byte   0xa1    ; d
   F9C2 86                 5892         .byte   0x86    ; E
   F9C3 8E                 5893         .byte   0x8e    ; F
   F9C4 FF                 5894         .byte   0xff    ; blank
                           5895 
                           5896 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           5897 
                           5898 ; Write arg in B to Button Lights
   F9C5                    5899 BUTNLIT:
   F9C5 36            [ 3] 5900         psha
   F9C6 F7 18 06      [ 4] 5901         stab    PIA0PRB     ; write arg to local data bus
   F9C9 B6 18 04      [ 4] 5902         ldaa    PIA0PRA     ; read from Port A
   F9CC 84 EF         [ 2] 5903         anda    #0xEF       ; bit 4 low
   F9CE B7 18 04      [ 4] 5904         staa    PIA0PRA     ; write back to Port A
   F9D1 8A 10         [ 2] 5905         oraa    #0x10       ; bit 4 high
   F9D3 B7 18 04      [ 4] 5906         staa    PIA0PRA     ; write this to Port A
   F9D6 32            [ 4] 5907         pula
   F9D7 39            [ 5] 5908         rts
                           5909 
                           5910 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           5911 
                           5912 ; Send rom message via SCI
   F9D8                    5913 SERMSGW:
   F9D8 18 38         [ 6] 5914         puly
   F9DA                    5915 LF9DA:
   F9DA 18 A6 00      [ 5] 5916         ldaa    0,Y
   F9DD 27 09         [ 3] 5917         beq     LF9E8       ; if zero terminated, return
   F9DF 2B 0C         [ 3] 5918         bmi     LF9ED       ; if high bit set..do last char and return
   F9E1 BD F9 7C      [ 6] 5919         jsr     SERRAWW     ; else send char
   F9E4 18 08         [ 4] 5920         iny
   F9E6 20 F2         [ 3] 5921         bra     LF9DA       ; and loop for next one
                           5922 
   F9E8                    5923 LF9E8:
   F9E8 18 08         [ 4] 5924         iny                 ; setup return address and return
   F9EA 18 3C         [ 5] 5925         pshy
   F9EC 39            [ 5] 5926         rts
                           5927 
   F9ED                    5928 LF9ED:
   F9ED 84 7F         [ 2] 5929         anda    #0x7F       ; remove top bit
   F9EF BD F9 7C      [ 6] 5930         jsr     SERRAWW     ; send char
   F9F2 20 F4         [ 3] 5931         bra     LF9E8       ; and we're done
   F9F4 39            [ 5] 5932         rts
                           5933 
   F9F5                    5934 DORTS:
   F9F5 39            [ 5] 5935         rts
   F9F6                    5936 DORTI:        
   F9F6 3B            [12] 5937         rti
                           5938 
                           5939 ; all 0xffs in this gap
                           5940 
   FFA0                    5941         .org    0xffa0
                           5942 
   FFA0 7E F9 F5      [ 3] 5943         jmp     DORTS
   FFA3 7E F9 F5      [ 3] 5944         jmp     DORTS
   FFA6 7E F9 F5      [ 3] 5945         jmp     DORTS
   FFA9 7E F9 2F      [ 3] 5946         jmp     SERHEXW
   FFAC 7E F9 D8      [ 3] 5947         jmp     SERMSGW      
   FFAF 7E F9 45      [ 3] 5948         jmp     SERIALR     
   FFB2 7E F9 6F      [ 3] 5949         jmp     SERIALW      
   FFB5 7E F9 08      [ 3] 5950         jmp     MINIMON
   FFB8 7E F9 95      [ 3] 5951         jmp     DIAGDGT 
   FFBB 7E F9 C5      [ 3] 5952         jmp     BUTNLIT 
                           5953 
   FFBE FF                 5954        .byte    0xff
   FFBF FF                 5955        .byte    0xff
                           5956 
                           5957 ; Vectors
                           5958 
   FFC0 F9 F6              5959        .word   DORTI        ; Stub RTI
   FFC2 F9 F6              5960        .word   DORTI        ; Stub RTI
   FFC4 F9 F6              5961        .word   DORTI        ; Stub RTI
   FFC6 F9 F6              5962        .word   DORTI        ; Stub RTI
   FFC8 F9 F6              5963        .word   DORTI        ; Stub RTI
   FFCA F9 F6              5964        .word   DORTI        ; Stub RTI
   FFCC F9 F6              5965        .word   DORTI        ; Stub RTI
   FFCE F9 F6              5966        .word   DORTI        ; Stub RTI
   FFD0 F9 F6              5967        .word   DORTI        ; Stub RTI
   FFD2 F9 F6              5968        .word   DORTI        ; Stub RTI
   FFD4 F9 F6              5969        .word   DORTI        ; Stub RTI
                           5970 
   FFD6 01 00              5971         .word  0x0100       ; SCI
   FFD8 01 03              5972         .word  0x0103       ; SPI
   FFDA 01 06              5973         .word  0x0106       ; PA accum. input edge
   FFDC 01 09              5974         .word  0x0109       ; PA Overflow
                           5975 
   FFDE F9 F6              5976         .word  DORTI        ; Stub RTI
                           5977 
   FFE0 01 0C              5978         .word  0x010c       ; TI4O5
   FFE2 01 0F              5979         .word  0x010f       ; TOC4
   FFE4 01 12              5980         .word  0x0112       ; TOC3
   FFE6 01 15              5981         .word  0x0115       ; TOC2
   FFE8 01 18              5982         .word  0x0118       ; TOC1
   FFEA 01 1B              5983         .word  0x011b       ; TIC3
   FFEC 01 1E              5984         .word  0x011e       ; TIC2
   FFEE 01 21              5985         .word  0x0121       ; TIC1
   FFF0 01 24              5986         .word  0x0124       ; RTI
   FFF2 01 27              5987         .word  0x0127       ; ~IRQ
   FFF4 01 2A              5988         .word  0x012a       ; XIRQ
   FFF6 01 2D              5989         .word  0x012d       ; SWI
   FFF8 01 30              5990         .word  0x0130       ; ILLEGAL OPCODE
   FFFA 01 33              5991         .word  0x0133       ; COP Failure
   FFFC 01 36              5992         .word  0x0136       ; COP Clock Monitor Fail
                           5993 
   FFFE F8 00              5994         .word  RESET        ; Reset
                           5995 
