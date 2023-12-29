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
   80D0 BD A3 41      [ 6]  149         jsr     LA341
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
   80FA BD 9F 1E      [ 6]  169         jsr     L9F1E
   80FD 25 1A         [ 3]  170         bcs     LOCKUP          ; bye bye
   80FF                     171 L80FF:
   80FF BD 9E AF      [ 6]  172         jsr     L9EAF           ; reset L counts
   8102 BD 9E 92      [ 6]  173         jsr     L9E92           ; reset R counts
   8105                     174 L8105:
   8105 86 39         [ 2]  175         ldaa    #0x39
   8107 B7 04 08      [ 4]  176         staa    0x0408          ; rts here for later CPU test
   810A BD A1 D5      [ 6]  177         jsr     LA1D5
   810D BD AB 17      [ 6]  178         jsr     LAB17
   8110 B6 F7 C0      [ 4]  179         ldaa    LF7C0           ; a 00
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
   812A BD 86 E7      [ 6]  192         jsr     L86E7
   812D C6 DF         [ 2]  193         ldab    #0xDF
   812F BD 87 48      [ 6]  194         jsr     L8748   
   8132 BD 87 91      [ 6]  195         jsr     L8791   
   8135 BD 9A F7      [ 6]  196         jsr     L9AF7
   8138 BD 9C 51      [ 6]  197         jsr     L9C51
   813B 7F 00 62      [ 6]  198         clr     (0x0062)
   813E BD 99 D9      [ 6]  199         jsr     L99D9
   8141 24 16         [ 3]  200         bcc     L8159           ; if carry clear, test is passed
                            201 
   8143 BD 8D E4      [ 6]  202         jsr     LCDMSG1 
   8146 49 6E 76 61 6C 69   203         .ascis  'Invalid CPU!'
        64 20 43 50 55 A1
                            204 
   8152 86 53         [ 2]  205         ldaa    #0x53
   8154 7E 82 A4      [ 3]  206         jmp     L82A4
   8157 20 FE         [ 3]  207 L8157:  bra     L8157           ; infinite loop
                            208 
   8159                     209 L8159:
   8159 BD A3 54      [ 6]  210         jsr     LA354
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
   818E BD 8D B5      [ 6]  228         jsr     L8DB5           ; display char here on LCD display
   8191 20 06         [ 3]  229         bra     L8199
   8193                     230 L8193:
   8193 CC 43 0F      [ 3]  231         ldd     #0x430F         ; print 'C' on the far left of the first line
   8196 BD 8D B5      [ 6]  232         jsr     L8DB5           ; display char here on LCD display
                            233 
   8199                     234 L8199:
   8199 BD 8D DD      [ 6]  235         jsr     LCDMSG2 
   819C 52 4F 4D 20 43 68   236         .ascis  'ROM Chksum='
        6B 73 75 6D BD
                            237 
   81A7 BD 97 5F      [ 6]  238         jsr     L975F           ; print the checksum on the LCD
                            239 
   81AA C6 02         [ 2]  240         ldab    #0x02           ; delay 2 secs
   81AC BD 8C 02      [ 6]  241         jsr     DLYSECS         ;
                            242 
   81AF BD 9A 27      [ 6]  243         jsr     L9A27           ; display Serial #
   81B2 BD 9E CC      [ 6]  244         jsr     L9ECC           ; display R and L counts?
   81B5 BD 9B 19      [ 6]  245         jsr     L9B19           ; do the random tasks???
                            246 
   81B8 C6 02         [ 2]  247         ldab    #0x02           ; delay 2 secs
   81BA BD 8C 02      [ 6]  248         jsr     DLYSECS         ;
                            249 
   81BD                     250 L81BD:
   81BD F6 10 2D      [ 4]  251         ldab    SCCR2           ; disable receive data interrupts
   81C0 C4 DF         [ 2]  252         andb    #0xDF
   81C2 F7 10 2D      [ 4]  253         stab    SCCR2  
                            254 
   81C5 BD 9A F7      [ 6]  255         jsr     L9AF7           ; clear a bunch of ram
   81C8 C6 FD         [ 2]  256         ldab    #0xFD
   81CA BD 86 E7      [ 6]  257         jsr     L86E7
   81CD BD 87 91      [ 6]  258         jsr     L8791   
                            259 
   81D0 C6 00         [ 2]  260         ldab    #0x00           ; turn off button lights
   81D2 D7 62         [ 3]  261         stab    (0x0062)
   81D4 BD F9 C5      [ 6]  262         jsr     BUTNLIT 
                            263 
   81D7                     264 L81D7:
   81D7 BD 8D E4      [ 6]  265         jsr     LCDMSG1 
   81DA 20 43 79 62 65 72   266         .ascis  ' Cyberstar v1.6'
        73 74 61 72 20 76
        31 2E B6
                            267 
   81E9 BD A2 DF      [ 6]  268         jsr     LA2DF
   81EC 24 11         [ 3]  269         bcc     L81FF
   81EE CC 52 0F      [ 3]  270         ldd     #0x520F
   81F1 BD 8D B5      [ 6]  271         jsr     L8DB5           ; display 'R' at far right of 1st line
   81F4 7D 04 2A      [ 6]  272         tst     (0x042A)
   81F7 27 06         [ 3]  273         beq     L81FF
   81F9 CC 4B 0F      [ 3]  274         ldd     #0x4B0F
   81FC BD 8D B5      [ 6]  275         jsr     L8DB5           ; display 'K' at far right of 1st line
   81FF                     276 L81FF:
   81FF BD 8D 03      [ 6]  277         jsr     L8D03
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
   825F BD 8D B5      [ 6]  314         jsr     L8DB5           ; display char here on LCD display
   8262 38            [ 5]  315         pulx
   8263 9C AD         [ 5]  316         cpx     (0x00AD)
   8265 26 F2         [ 3]  317         bne     L8259
   8267                     318 L8267:
   8267 BD 9C 51      [ 6]  319         jsr     L9C51
   826A 7F 00 5B      [ 6]  320         clr     (0x005B)
   826D 7F 00 5A      [ 6]  321         clr     (0x005A)
   8270 7F 00 5E      [ 6]  322         clr     (0x005E)
   8273 7F 00 60      [ 6]  323         clr     (0x0060)
   8276 BD 9B 19      [ 6]  324         jsr     L9B19   
   8279 96 60         [ 3]  325         ldaa    (0x0060)
   827B 27 06         [ 3]  326         beq     L8283
   827D BD A9 7C      [ 6]  327         jsr     LA97C
   8280 7E F8 00      [ 3]  328         jmp     RESET       ; reset controller
   8283                     329 L8283:
   8283 B6 18 04      [ 4]  330         ldaa    PIA0PRA 
   8286 84 06         [ 2]  331         anda    #0x06
   8288 26 08         [ 3]  332         bne     L8292
   828A BD 9C F1      [ 6]  333         jsr     L9CF1       ; print credits
   828D C6 32         [ 2]  334         ldab    #0x32
   828F BD 8C 22      [ 6]  335         jsr     DLYSECSBY100       ; delay 0.5 sec
   8292                     336 L8292:
   8292 BD 8E 95      [ 6]  337         jsr     L8E95
   8295 81 0D         [ 2]  338         cmpa    #0x0D
   8297 26 03         [ 3]  339         bne     L829C
   8299 7E 92 92      [ 3]  340         jmp     L9292
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
   8349 BD 86 A4      [ 6]  385         jsr     L86A4
   834C 24 03         [ 3]  386         bcc     L8351
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
   8367 BD 8C 02      [ 6]  398         jsr     DLYSECS         ;
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
   839E 1A 83 FD E8   [ 5]  425         cpd     #0xFDE8         ; Should be 0xFF
   83A2 22 06         [ 3]  426         bhi     L83AA
   83A4 C3 00 01      [ 4]  427         addd    #0x0001
   83A7 FD 04 0D      [ 5]  428         std     (0x040D)
   83AA                     429 L83AA:
   83AA C6 F7         [ 2]  430         ldab    #0xF7
   83AC BD 86 E7      [ 6]  431         jsr     L86E7
   83AF                     432 L83AF:
   83AF 7F 00 30      [ 6]  433         clr     (0x0030)
   83B2 7F 00 31      [ 6]  434         clr     (0x0031)
   83B5 7F 00 32      [ 6]  435         clr     (0x0032)
   83B8 BD 9B 19      [ 6]  436         jsr     L9B19   
   83BB BD 86 A4      [ 6]  437         jsr     L86A4
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
   83D8 7E 9A 7F      [ 3]  451         jmp     L9A7F
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
   83F9 BD 86 E7      [ 6]  461         jsr     L86E7
                            462 
   83FC BD 8D CF      [ 6]  463         jsr     LCDMSG1A
   83FF 36 38 48 43 31 31   464         .ascis  '68HC11 Proto'
        20 50 72 6F 74 EF
                            465 
   840B BD 8D D6      [ 6]  466         jsr     LCDMSG2A
   840E 64 62 F0            467         .ascis  'dbp'
                            468 
   8411 C6 03         [ 2]  469         ldab    #0x03           ; delay 3 secs
   8413 BD 8C 02      [ 6]  470         jsr     DLYSECS         ;
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
   8430 BD 8D 03      [ 6]  483         jsr     L8D03
   8433 BD 9D 18      [ 6]  484         jsr     L9D18
   8436 24 08         [ 3]  485         bcc     L8440
   8438 7D 00 B8      [ 6]  486         tst     (0x00B8)
   843B 27 F3         [ 3]  487         beq     L8430
   843D 7E 9A 60      [ 3]  488         jmp     L9A60
   8440                     489 L8440:
   8440 7D 00 B8      [ 6]  490         tst     (0x00B8)
   8443 27 EB         [ 3]  491         beq     L8430
   8445 7F 00 30      [ 6]  492         clr     (0x0030)
   8448 7F 00 31      [ 6]  493         clr     (0x0031)
   844B 20 00         [ 3]  494         bra     L844D
   844D                     495 L844D:
   844D 96 49         [ 3]  496         ldaa    (0x0049)
   844F 26 03         [ 3]  497         bne     L8454
   8451 7E 85 A4      [ 3]  498         jmp     L85A4
   8454                     499 L8454:
   8454 7F 00 49      [ 6]  500         clr     (0x0049)
   8457 81 31         [ 2]  501         cmpa    #0x31
   8459 26 08         [ 3]  502         bne     L8463
   845B BD A3 26      [ 6]  503         jsr     LA326
   845E BD 8D 42      [ 6]  504         jsr     L8D42
   8461 20 EA         [ 3]  505         bra     L844D
   8463                     506 L8463:
   8463 81 32         [ 2]  507         cmpa    #0x32
   8465 26 08         [ 3]  508         bne     L846F
   8467 BD A3 26      [ 6]  509         jsr     LA326
   846A BD 8D 35      [ 6]  510         jsr     L8D35
   846D 20 DE         [ 3]  511         bra     L844D
   846F                     512 L846F:
   846F 81 54         [ 2]  513         cmpa    #0x54
   8471 26 08         [ 3]  514         bne     L847B
   8473 BD A3 26      [ 6]  515         jsr     LA326
   8476 BD 8D 42      [ 6]  516         jsr     L8D42
   8479 20 D2         [ 3]  517         bra     L844D
   847B                     518 L847B:
   847B 81 5A         [ 2]  519         cmpa    #0x5A
   847D 26 1C         [ 3]  520         bne     L849B
   847F                     521 L847F:
   847F BD A3 1E      [ 6]  522         jsr     LA31E
   8482 BD 8E 95      [ 6]  523         jsr     L8E95
   8485 7F 00 32      [ 6]  524         clr     (0x0032)
   8488 7F 00 31      [ 6]  525         clr     (0x0031)
   848B 7F 00 30      [ 6]  526         clr     (0x0030)
   848E BD 99 A6      [ 6]  527         jsr     L99A6
   8491 D6 7B         [ 3]  528         ldab    (0x007B)
   8493 CA 0C         [ 2]  529         orab    #0x0C
   8495 BD 87 48      [ 6]  530         jsr     L8748   
   8498 7E 81 BD      [ 3]  531         jmp     L81BD
   849B                     532 L849B:
   849B 81 42         [ 2]  533         cmpa    #0x42
   849D 26 03         [ 3]  534         bne     L84A2
   849F 7E 98 3C      [ 3]  535         jmp     L983C
   84A2                     536 L84A2:
   84A2 81 4D         [ 2]  537         cmpa    #0x4D
   84A4 26 03         [ 3]  538         bne     L84A9
   84A6 7E 98 24      [ 3]  539         jmp     L9824
   84A9                     540 L84A9:
   84A9 81 45         [ 2]  541         cmpa    #0x45
   84AB 26 03         [ 3]  542         bne     L84B0
   84AD 7E 98 02      [ 3]  543         jmp     L9802
   84B0                     544 L84B0:
   84B0 81 58         [ 2]  545         cmpa    #0x58
   84B2 26 05         [ 3]  546         bne     L84B9
   84B4 7E 99 3F      [ 3]  547         jmp     L993F
   84B7 20 94         [ 3]  548         bra     L844D
   84B9                     549 L84B9:
   84B9 81 46         [ 2]  550         cmpa    #0x46
   84BB 26 03         [ 3]  551         bne     L84C0
   84BD 7E 99 71      [ 3]  552         jmp     L9971
   84C0                     553 L84C0:
   84C0 81 47         [ 2]  554         cmpa    #0x47
   84C2 26 03         [ 3]  555         bne     L84C7
   84C4 7E 99 7B      [ 3]  556         jmp     L997B
   84C7                     557 L84C7:
   84C7 81 48         [ 2]  558         cmpa    #0x48
   84C9 26 03         [ 3]  559         bne     L84CE
   84CB 7E 99 85      [ 3]  560         jmp     L9985
   84CE                     561 L84CE:
   84CE 81 49         [ 2]  562         cmpa    #0x49
   84D0 26 03         [ 3]  563         bne     L84D5
   84D2 7E 99 8F      [ 3]  564         jmp     L998F
   84D5                     565 L84D5:
   84D5 81 53         [ 2]  566         cmpa    #0x53
   84D7 26 03         [ 3]  567         bne     L84DC
   84D9 7E 97 BA      [ 3]  568         jmp     L97BA
   84DC                     569 L84DC:
   84DC 81 59         [ 2]  570         cmpa    #0x59
   84DE 26 03         [ 3]  571         bne     L84E3
   84E0 7E 99 D2      [ 3]  572         jmp     L99D2
   84E3                     573 L84E3:
   84E3 81 57         [ 2]  574         cmpa    #0x57
   84E5 26 03         [ 3]  575         bne     L84EA
   84E7 7E 9A A4      [ 3]  576         jmp     L9AA4
   84EA                     577 L84EA:
   84EA 81 41         [ 2]  578         cmpa    #0x41
   84EC 26 17         [ 3]  579         bne     L8505
   84EE BD 9D 18      [ 6]  580         jsr     L9D18
   84F1 25 09         [ 3]  581         bcs     L84FC
   84F3 7F 00 30      [ 6]  582         clr     (0x0030)
   84F6 7F 00 31      [ 6]  583         clr     (0x0031)
   84F9 7E 85 A4      [ 3]  584         jmp     L85A4
   84FC                     585 L84FC:
   84FC 7F 00 30      [ 6]  586         clr     (0x0030)
   84FF 7F 00 31      [ 6]  587         clr     (0x0031)
   8502 7E 9A 7F      [ 3]  588         jmp     L9A7F
   8505                     589 L8505:
   8505 81 4B         [ 2]  590         cmpa    #0x4B
   8507 26 0B         [ 3]  591         bne     L8514
   8509 BD 9D 18      [ 6]  592         jsr     L9D18
   850C 25 03         [ 3]  593         bcs     L8511
   850E 7E 85 A4      [ 3]  594         jmp     L85A4
   8511                     595 L8511:
   8511 7E 9A 7F      [ 3]  596         jmp     L9A7F
   8514                     597 L8514:
   8514 81 4A         [ 2]  598         cmpa    #0x4A
   8516 26 07         [ 3]  599         bne     L851F
   8518 86 01         [ 2]  600         ldaa    #0x01
   851A 97 AF         [ 3]  601         staa    (0x00AF)
   851C 7E 98 3C      [ 3]  602         jmp     L983C
   851F                     603 L851F:
   851F 81 4E         [ 2]  604         cmpa    #0x4E
   8521 26 0B         [ 3]  605         bne     L852E
   8523 B6 10 8A      [ 4]  606         ldaa    (0x108A)
   8526 8A 02         [ 2]  607         oraa    #0x02
   8528 B7 10 8A      [ 4]  608         staa    (0x108A)
   852B 7E 84 4D      [ 3]  609         jmp     L844D
   852E                     610 L852E:
   852E 81 4F         [ 2]  611         cmpa    #0x4F
   8530 26 06         [ 3]  612         bne     L8538
   8532 BD 9D 18      [ 6]  613         jsr     L9D18
   8535 7E 84 4D      [ 3]  614         jmp     L844D
   8538                     615 L8538:
   8538 81 50         [ 2]  616         cmpa    #0x50
   853A 26 06         [ 3]  617         bne     L8542
   853C BD 9D 18      [ 6]  618         jsr     L9D18
   853F 7E 84 4D      [ 3]  619         jmp     L844D
   8542                     620 L8542:
   8542 81 51         [ 2]  621         cmpa    #0x51
   8544 26 0B         [ 3]  622         bne     L8551
   8546 B6 10 8A      [ 4]  623         ldaa    (0x108A)
   8549 8A 04         [ 2]  624         oraa    #0x04
   854B B7 10 8A      [ 4]  625         staa    (0x108A)
   854E 7E 84 4D      [ 3]  626         jmp     L844D
   8551                     627 L8551:
   8551 81 55         [ 2]  628         cmpa    #0x55
   8553 26 07         [ 3]  629         bne     L855C
   8555 C6 01         [ 2]  630         ldab    #0x01
   8557 D7 B6         [ 3]  631         stab    (0x00B6)
   8559 7E 84 4D      [ 3]  632         jmp     L844D
   855C                     633 L855C:
   855C 81 4C         [ 2]  634         cmpa    #0x4C
   855E 26 19         [ 3]  635         bne     L8579
   8560 7F 00 49      [ 6]  636         clr     (0x0049)
   8563 BD 9D 18      [ 6]  637         jsr     L9D18
   8566 25 0E         [ 3]  638         bcs     L8576
   8568 BD AA E8      [ 6]  639         jsr     LAAE8
   856B BD AB 56      [ 6]  640         jsr     LAB56
   856E 24 06         [ 3]  641         bcc     L8576
   8570 BD AB 25      [ 6]  642         jsr     LAB25
   8573 BD AB 46      [ 6]  643         jsr     LAB46
   8576                     644 L8576:
   8576 7E 84 4D      [ 3]  645         jmp     L844D
   8579                     646 L8579:
   8579 81 52         [ 2]  647         cmpa    #0x52
   857B 26 1A         [ 3]  648         bne     L8597
   857D 7F 00 49      [ 6]  649         clr     (0x0049)
   8580 BD 9D 18      [ 6]  650         jsr     L9D18
   8583 25 0F         [ 3]  651         bcs     L8594
   8585 BD AA E8      [ 6]  652         jsr     LAAE8
   8588 BD AB 56      [ 6]  653         jsr     LAB56
   858B 25 07         [ 3]  654         bcs     L8594
   858D 86 FF         [ 2]  655         ldaa    #0xFF
   858F A7 00         [ 4]  656         staa    0,X
   8591 BD AA E8      [ 6]  657         jsr     LAAE8
   8594                     658 L8594:
   8594 7E 84 4D      [ 3]  659         jmp     L844D
   8597                     660 L8597:
   8597 81 44         [ 2]  661         cmpa    #0x44
   8599 26 09         [ 3]  662         bne     L85A4
   859B 7F 00 49      [ 6]  663         clr     (0x0049)
   859E BD AB AE      [ 6]  664         jsr     LABAE
   85A1 7E 84 4D      [ 3]  665         jmp     L844D
   85A4                     666 L85A4:
   85A4 7D 00 75      [ 6]  667         tst     (0x0075)
   85A7 26 56         [ 3]  668         bne     L85FF
   85A9 7D 00 79      [ 6]  669         tst     (0x0079)
   85AC 26 51         [ 3]  670         bne     L85FF
   85AE 7D 00 30      [ 6]  671         tst     (0x0030)
   85B1 26 07         [ 3]  672         bne     L85BA
   85B3 96 5B         [ 3]  673         ldaa    (0x005B)
   85B5 27 48         [ 3]  674         beq     L85FF
   85B7 7F 00 5B      [ 6]  675         clr     (0x005B)
   85BA                     676 L85BA:
   85BA CC 00 64      [ 3]  677         ldd     #0x0064
   85BD DD 23         [ 4]  678         std     CDTIMR5
   85BF                     679 L85BF:
   85BF DC 23         [ 4]  680         ldd     CDTIMR5
   85C1 27 14         [ 3]  681         beq     L85D7
   85C3 BD 9B 19      [ 6]  682         jsr     L9B19   
   85C6 B6 18 04      [ 4]  683         ldaa    PIA0PRA 
   85C9 88 FF         [ 2]  684         eora    #0xFF
   85CB 84 06         [ 2]  685         anda    #0x06
   85CD 81 06         [ 2]  686         cmpa    #0x06
   85CF 26 EE         [ 3]  687         bne     L85BF
   85D1 7F 00 30      [ 6]  688         clr     (0x0030)
   85D4 7E 86 80      [ 3]  689         jmp     L8680
   85D7                     690 L85D7:
   85D7 7F 00 30      [ 6]  691         clr     (0x0030)
   85DA D6 62         [ 3]  692         ldab    (0x0062)
   85DC C8 02         [ 2]  693         eorb    #0x02
   85DE D7 62         [ 3]  694         stab    (0x0062)
   85E0 BD F9 C5      [ 6]  695         jsr     BUTNLIT 
   85E3 C4 02         [ 2]  696         andb    #0x02
   85E5 27 0D         [ 3]  697         beq     L85F4
   85E7 BD AA 18      [ 6]  698         jsr     LAA18
   85EA C6 1E         [ 2]  699         ldab    #0x1E
   85EC BD 8C 22      [ 6]  700         jsr     DLYSECSBY100           ; delay 0.3 sec
   85EF 7F 00 30      [ 6]  701         clr     (0x0030)
   85F2 20 0B         [ 3]  702         bra     L85FF
   85F4                     703 L85F4:
   85F4 BD AA 1D      [ 6]  704         jsr     LAA1D
   85F7 C6 1E         [ 2]  705         ldab    #0x1E
   85F9 BD 8C 22      [ 6]  706         jsr     DLYSECSBY100           ; delay 0.3 sec
   85FC 7F 00 30      [ 6]  707         clr     (0x0030)
   85FF                     708 L85FF:
   85FF BD 9B 19      [ 6]  709         jsr     L9B19   
   8602 B6 10 0A      [ 4]  710         ldaa    PORTE
   8605 84 10         [ 2]  711         anda    #0x10
   8607 27 0B         [ 3]  712         beq     L8614
   8609 B6 18 04      [ 4]  713         ldaa    PIA0PRA 
   860C 88 FF         [ 2]  714         eora    #0xFF
   860E 84 07         [ 2]  715         anda    #0x07
   8610 81 06         [ 2]  716         cmpa    #0x06
   8612 26 1C         [ 3]  717         bne     L8630
   8614                     718 L8614:
   8614 7D 00 76      [ 6]  719         tst     (0x0076)
   8617 26 17         [ 3]  720         bne     L8630
   8619 7D 00 75      [ 6]  721         tst     (0x0075)
   861C 26 12         [ 3]  722         bne     L8630
   861E D6 62         [ 3]  723         ldab    (0x0062)
   8620 C4 FC         [ 2]  724         andb    #0xFC
   8622 D7 62         [ 3]  725         stab    (0x0062)
   8624 BD F9 C5      [ 6]  726         jsr     BUTNLIT 
   8627 BD AA 13      [ 6]  727         jsr     LAA13
   862A BD AA 1D      [ 6]  728         jsr     LAA1D
   862D 7E 9A 60      [ 3]  729         jmp     L9A60
   8630                     730 L8630:
   8630 7D 00 31      [ 6]  731         tst     (0x0031)
   8633 26 07         [ 3]  732         bne     L863C
   8635 96 5A         [ 3]  733         ldaa    (0x005A)
   8637 27 47         [ 3]  734         beq     L8680
   8639 7F 00 5A      [ 6]  735         clr     (0x005A)
   863C                     736 L863C:
   863C CC 00 64      [ 3]  737         ldd     #0x0064
   863F DD 23         [ 4]  738         std     CDTIMR5
   8641                     739 L8641:
   8641 DC 23         [ 4]  740         ldd     CDTIMR5
   8643 27 13         [ 3]  741         beq     L8658
   8645 BD 9B 19      [ 6]  742         jsr     L9B19   
   8648 B6 18 04      [ 4]  743         ldaa    PIA0PRA 
   864B 88 FF         [ 2]  744         eora    #0xFF
   864D 84 06         [ 2]  745         anda    #0x06
   864F 81 06         [ 2]  746         cmpa    #0x06
   8651 26 EE         [ 3]  747         bne     L8641
   8653 7F 00 31      [ 6]  748         clr     (0x0031)
   8656 20 28         [ 3]  749         bra     L8680
   8658                     750 L8658:
   8658 7F 00 31      [ 6]  751         clr     (0x0031)
   865B D6 62         [ 3]  752         ldab    (0x0062)
   865D C8 01         [ 2]  753         eorb    #0x01
   865F D7 62         [ 3]  754         stab    (0x0062)
   8661 BD F9 C5      [ 6]  755         jsr     BUTNLIT 
   8664 C4 01         [ 2]  756         andb    #0x01
   8666 27 0D         [ 3]  757         beq     L8675
   8668 BD AA 0C      [ 6]  758         jsr     LAA0C
   866B C6 1E         [ 2]  759         ldab    #0x1E
   866D BD 8C 22      [ 6]  760         jsr     DLYSECSBY100           ; delay 0.3 sec
   8670 7F 00 31      [ 6]  761         clr     (0x0031)
   8673 20 0B         [ 3]  762         bra     L8680
   8675                     763 L8675:
   8675 BD AA 13      [ 6]  764         jsr     LAA13
   8678 C6 1E         [ 2]  765         ldab    #0x1E
   867A BD 8C 22      [ 6]  766         jsr     DLYSECSBY100           ; delay 0.3 sec
   867D 7F 00 31      [ 6]  767         clr     (0x0031)
   8680                     768 L8680:
   8680 BD 86 A4      [ 6]  769         jsr     L86A4
   8683 25 1C         [ 3]  770         bcs     L86A1
   8685 7F 00 4E      [ 6]  771         clr     (0x004E)
   8688 BD 99 A6      [ 6]  772         jsr     L99A6
   868B BD 86 C4      [ 6]  773         jsr     L86C4
   868E 5F            [ 2]  774         clrb
   868F D7 62         [ 3]  775         stab    (0x0062)
   8691 BD F9 C5      [ 6]  776         jsr     BUTNLIT 
   8694 C6 FD         [ 2]  777         ldab    #0xFD
   8696 BD 86 E7      [ 6]  778         jsr     L86E7
   8699 C6 04         [ 2]  779         ldab    #0x04           ; delay 4 secs
   869B BD 8C 02      [ 6]  780         jsr     DLYSECS         ;
   869E 7E 84 7F      [ 3]  781         jmp     L847F
   86A1                     782 L86A1:
   86A1 7E 84 4D      [ 3]  783         jmp     L844D
   86A4                     784 L86A4:
   86A4 BD 9B 19      [ 6]  785         jsr     L9B19   
   86A7 7F 00 23      [ 6]  786         clr     CDTIMR5
   86AA 86 19         [ 2]  787         ldaa    #0x19
   86AC 97 24         [ 3]  788         staa    CDTIMR5+1
   86AE B6 10 0A      [ 4]  789         ldaa    PORTE
   86B1 84 80         [ 2]  790         anda    #0x80
   86B3 27 02         [ 3]  791         beq     L86B7
   86B5                     792 L86B5:
   86B5 0D            [ 2]  793         sec
   86B6 39            [ 5]  794         rts
                            795 
   86B7                     796 L86B7:
   86B7 B6 10 0A      [ 4]  797         ldaa    PORTE
   86BA 84 80         [ 2]  798         anda    #0x80
   86BC 26 F7         [ 3]  799         bne     L86B5
   86BE 96 24         [ 3]  800         ldaa    CDTIMR5+1
   86C0 26 F5         [ 3]  801         bne     L86B7
   86C2 0C            [ 2]  802         clc
   86C3 39            [ 5]  803         rts
                            804 
                            805 ; main1 - init boards 1-9 at:
                            806 ;         0x1080, 0x1084, 0x1088, 0x108c
                            807 ;         0x1090, 0x1094, 0x1098, 0x109c
                            808 ;         0x10a0
                            809 
   86C4                     810 L86C4:
   86C4 CE 10 80      [ 3]  811         ldx     #0x1080
   86C7                     812 L86C7:
   86C7 86 30         [ 2]  813         ldaa    #0x30
   86C9 A7 01         [ 4]  814         staa    1,X
   86CB A7 03         [ 4]  815         staa    3,X
   86CD 86 FF         [ 2]  816         ldaa    #0xFF
   86CF A7 00         [ 4]  817         staa    0,X
   86D1 A7 02         [ 4]  818         staa    2,X
   86D3 86 34         [ 2]  819         ldaa    #0x34
   86D5 A7 01         [ 4]  820         staa    1,X
   86D7 A7 03         [ 4]  821         staa    3,X
   86D9 6F 00         [ 6]  822         clr     0,X
   86DB 6F 02         [ 6]  823         clr     2,X
   86DD 08            [ 3]  824         inx
   86DE 08            [ 3]  825         inx
   86DF 08            [ 3]  826         inx
   86E0 08            [ 3]  827         inx
   86E1 8C 10 A4      [ 4]  828         cpx     #0x10A4
   86E4 2F E1         [ 3]  829         ble     L86C7
   86E6 39            [ 5]  830         rts
                            831 
                            832 ; *** Should look at this
   86E7                     833 L86E7:
   86E7 36            [ 3]  834         psha
   86E8 BD 9B 19      [ 6]  835         jsr     L9B19   
   86EB 96 AC         [ 3]  836         ldaa    (0x00AC)
   86ED C1 FB         [ 2]  837         cmpb    #0xFB
   86EF 26 04         [ 3]  838         bne     L86F5
   86F1 84 FE         [ 2]  839         anda    #0xFE
   86F3 20 0E         [ 3]  840         bra     L8703
   86F5                     841 L86F5:
   86F5 C1 F7         [ 2]  842         cmpb    #0xF7
   86F7 26 04         [ 3]  843         bne     L86FD
   86F9 84 BF         [ 2]  844         anda    #0xBF
   86FB 20 06         [ 3]  845         bra     L8703
   86FD                     846 L86FD:
   86FD C1 FD         [ 2]  847         cmpb    #0xFD
   86FF 26 02         [ 3]  848         bne     L8703
   8701 84 F7         [ 2]  849         anda    #0xF7
   8703                     850 L8703:
   8703 97 AC         [ 3]  851         staa    (0x00AC)
   8705 B7 18 06      [ 4]  852         staa    PIA0PRB 
   8708 BD 87 3A      [ 6]  853         jsr     L873A        ; clock diagnostic indicator
   870B 96 7A         [ 3]  854         ldaa    (0x007A)
   870D 84 01         [ 2]  855         anda    #0x01
   870F 97 7A         [ 3]  856         staa    (0x007A)
   8711 C4 FE         [ 2]  857         andb    #0xFE
   8713 DA 7A         [ 3]  858         orab    (0x007A)
   8715 F7 18 06      [ 4]  859         stab    PIA0PRB 
   8718 BD 87 75      [ 6]  860         jsr     L8775   
   871B C6 32         [ 2]  861         ldab    #0x32
   871D BD 8C 22      [ 6]  862         jsr     DLYSECSBY100       ; delay 0.5 sec
   8720 C6 FE         [ 2]  863         ldab    #0xFE
   8722 DA 7A         [ 3]  864         orab    (0x007A)
   8724 F7 18 06      [ 4]  865         stab    PIA0PRB 
   8727 D7 7A         [ 3]  866         stab    (0x007A)
   8729 BD 87 75      [ 6]  867         jsr     L8775   
   872C 96 AC         [ 3]  868         ldaa    (0x00AC)
   872E 8A 49         [ 2]  869         oraa    #0x49
   8730 97 AC         [ 3]  870         staa    (0x00AC)
   8732 B7 18 06      [ 4]  871         staa    PIA0PRB 
   8735 BD 87 3A      [ 6]  872         jsr     L873A        ; clock diagnostic indicator
   8738 32            [ 4]  873         pula
   8739 39            [ 5]  874         rts
                            875 
                            876 ; clock diagnostic indicator
   873A                     877 L873A:
   873A B6 18 04      [ 4]  878         ldaa    PIA0PRA 
   873D 8A 20         [ 2]  879         oraa    #0x20
   873F B7 18 04      [ 4]  880         staa    PIA0PRA 
   8742 84 DF         [ 2]  881         anda    #0xDF
   8744 B7 18 04      [ 4]  882         staa    PIA0PRA 
   8747 39            [ 5]  883         rts
                            884 
   8748                     885 L8748:
   8748 36            [ 3]  886         psha
   8749 37            [ 3]  887         pshb
   874A 96 AC         [ 3]  888         ldaa    (0x00AC)
   874C 8A 30         [ 2]  889         oraa    #0x30
   874E 84 FD         [ 2]  890         anda    #0xFD
   8750 C5 20         [ 2]  891         bitb    #0x20
   8752 26 02         [ 3]  892         bne     L8756
   8754 8A 02         [ 2]  893         oraa    #0x02
   8756                     894 L8756:
   8756 C5 04         [ 2]  895         bitb    #0x04
   8758 26 02         [ 3]  896         bne     L875C
   875A 84 EF         [ 2]  897         anda    #0xEF
   875C                     898 L875C:
   875C C5 08         [ 2]  899         bitb    #0x08
   875E 26 02         [ 3]  900         bne     L8762
   8760 84 DF         [ 2]  901         anda    #0xDF
   8762                     902 L8762:
   8762 B7 18 06      [ 4]  903         staa    PIA0PRB 
   8765 97 AC         [ 3]  904         staa    (0x00AC)
   8767 BD 87 3A      [ 6]  905         jsr     L873A           ; clock diagnostic indicator
   876A 33            [ 4]  906         pulb
   876B F7 18 06      [ 4]  907         stab    PIA0PRB 
   876E D7 7B         [ 3]  908         stab    (0x007B)
   8770 BD 87 83      [ 6]  909         jsr     L8783
   8773 32            [ 4]  910         pula
   8774 39            [ 5]  911         rts
                            912 
   8775                     913 L8775:
   8775 B6 18 07      [ 4]  914         ldaa    PIA0CRB 
   8778 8A 38         [ 2]  915         oraa    #0x38       ; bits 3-4-5 on
   877A B7 18 07      [ 4]  916         staa    PIA0CRB 
   877D 84 F7         [ 2]  917         anda    #0xF7       ; bit 3 off
   877F B7 18 07      [ 4]  918         staa    PIA0CRB 
   8782 39            [ 5]  919         rts
                            920 
   8783                     921 L8783:
   8783 B6 18 05      [ 4]  922         ldaa    PIA0CRA 
   8786 8A 38         [ 2]  923         oraa    #0x38       ; bits 3-4-5 on
   8788 B7 18 05      [ 4]  924         staa    PIA0CRA 
   878B 84 F7         [ 2]  925         anda    #0xF7       ; bit 3 off
   878D B7 18 05      [ 4]  926         staa    PIA0CRA 
   8790 39            [ 5]  927         rts
                            928 
   8791                     929 L8791:
   8791 96 7A         [ 3]  930         ldaa    (0x007A)
   8793 84 FE         [ 2]  931         anda    #0xFE
   8795 36            [ 3]  932         psha
   8796 96 AC         [ 3]  933         ldaa    (0x00AC)
   8798 8A 04         [ 2]  934         oraa    #0x04
   879A 97 AC         [ 3]  935         staa    (0x00AC)
   879C 32            [ 4]  936         pula
   879D                     937 L879D:
   879D 97 7A         [ 3]  938         staa    (0x007A)
   879F B7 18 06      [ 4]  939         staa    PIA0PRB 
   87A2 BD 87 75      [ 6]  940         jsr     L8775
   87A5 96 AC         [ 3]  941         ldaa    (0x00AC)
   87A7 B7 18 06      [ 4]  942         staa    PIA0PRB 
   87AA BD 87 3A      [ 6]  943         jsr     L873A           ; clock diagnostic indicator
   87AD 39            [ 5]  944         rts
                            945 
   87AE                     946 L87AE:
   87AE 96 7A         [ 3]  947         ldaa    (0x007A)
   87B0 8A 01         [ 2]  948         oraa    #0x01
   87B2 36            [ 3]  949         psha
   87B3 96 AC         [ 3]  950         ldaa    (0x00AC)
   87B5 84 FB         [ 2]  951         anda    #0xFB
   87B7 97 AC         [ 3]  952         staa    (0x00AC)
   87B9 32            [ 4]  953         pula
   87BA 20 E1         [ 3]  954         bra     L879D
                            955 
   87BC                     956 L87BC:
   87BC CE 87 D2      [ 3]  957         ldx     #L87D2
   87BF                     958 L87BF:
   87BF A6 00         [ 4]  959         ldaa    0,X
   87C1 81 FF         [ 2]  960         cmpa    #0xFF
   87C3 27 0C         [ 3]  961         beq     L87D1
   87C5 08            [ 3]  962         inx
   87C6 B7 18 0D      [ 4]  963         staa    SCCCTRLB
   87C9 A6 00         [ 4]  964         ldaa    0,X
   87CB 08            [ 3]  965         inx
   87CC B7 18 0D      [ 4]  966         staa    SCCCTRLB
   87CF 20 EE         [ 3]  967         bra     L87BF
   87D1                     968 L87D1:
   87D1 39            [ 5]  969         rts
                            970 
                            971 ; data table, sync data init
   87D2                     972 L87D2:
   87D2 09 8A               973         .byte   0x09,0x8a
   87D4 01 00               974         .byte   0x01,0x00
   87D6 0C 18               975         .byte   0x0c,0x18 
   87D8 0D 00               976         .byte   0x0d,0x00
   87DA 04 44               977         .byte   0x04,0x44
   87DC 0E 63               978         .byte   0x0e,0x63
   87DE 05 68               979         .byte   0x05,0x68
   87E0 0B 56               980         .byte   0x0b,0x56
   87E2 03 C1               981         .byte   0x03,0xc1
   87E4 0F 00               982         .byte   0x0f,0x00
   87E6 FF FF               983         .byte   0xff,0xff
                            984 
                            985 ; SCC init, aux serial
   87E8                     986 L87E8:
   87E8 CE F8 57      [ 3]  987         ldx     #LF857
   87EB                     988 L87EB:
   87EB A6 00         [ 4]  989         ldaa    0,X
   87ED 81 FF         [ 2]  990         cmpa    #0xFF
   87EF 27 0C         [ 3]  991         beq     L87FD
   87F1 08            [ 3]  992         inx
   87F2 B7 18 0C      [ 4]  993         staa    SCCCTRLA
   87F5 A6 00         [ 4]  994         ldaa    0,X
   87F7 08            [ 3]  995         inx
   87F8 B7 18 0C      [ 4]  996         staa    SCCCTRLA
   87FB 20 EE         [ 3]  997         bra     L87EB
   87FD                     998 L87FD:
   87FD 20 16         [ 3]  999         bra     L8815
                           1000 
                           1001 ; data table for aux serial config
   87FF 09 8A              1002         .byte   0x09,0x8a
   8801 01 10              1003         .byte   0x01,0x10
   8803 0C 18              1004         .byte   0x0c,0x18
   8805 0D 00              1005         .byte   0x0d,0x00
   8807 04 04              1006         .byte   0x04,0x04
   8809 0E 63              1007         .byte   0x0e,0x63
   880B 05 68              1008         .byte   0x05,0x68
   880D 0B 01              1009         .byte   0x0b,0x01
   880F 03 C1              1010         .byte   0x03,0xc1
   8811 0F 00              1011         .byte   0x0f,0x00
   8813 FF FF              1012         .byte   0xff,0xff
                           1013 
                           1014 ; Install IRQ and SCI interrupt handlers
   8815                    1015 L8815:
   8815 CE 88 3E      [ 3] 1016         ldx     #L883E      ; Install IRQ interrupt handler
   8818 FF 01 28      [ 5] 1017         stx     (0x0128)
   881B 86 7E         [ 2] 1018         ldaa    #0x7E
   881D B7 01 27      [ 4] 1019         staa    (0x0127)
   8820 CE 88 32      [ 3] 1020         ldx     #L8832      ; Install SCI interrupt handler
   8823 FF 01 01      [ 5] 1021         stx     (0x0101)
   8826 B7 01 00      [ 4] 1022         staa    (0x0100)
   8829 B6 10 2D      [ 4] 1023         ldaa    SCCR2  
   882C 8A 20         [ 2] 1024         oraa    #0x20
   882E B7 10 2D      [ 4] 1025         staa    SCCR2  
   8831 39            [ 5] 1026         rts
                           1027 
                           1028 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1029 
                           1030 ; SCI Interrupt handler, normal serial
                           1031 
   8832                    1032 L8832:
   8832 B6 10 2E      [ 4] 1033         ldaa    SCSR
   8835 B6 10 2F      [ 4] 1034         ldaa    SCDR
   8838 7C 00 48      [ 6] 1035         inc     (0x0048)
   883B 7E 88 62      [ 3] 1036         jmp     L8862
                           1037 
                           1038 ; IRQ Interrupt handler, aux serial
                           1039 
   883E                    1040 L883E:
   883E 86 01         [ 2] 1041         ldaa    #0x01
   8840 B7 18 0C      [ 4] 1042         staa    SCCCTRLA
   8843 B6 18 0C      [ 4] 1043         ldaa    SCCCTRLA
   8846 84 70         [ 2] 1044         anda    #0x70
   8848 26 1F         [ 3] 1045         bne     L8869  
   884A 86 0A         [ 2] 1046         ldaa    #0x0A
   884C B7 18 0C      [ 4] 1047         staa    SCCCTRLA
   884F B6 18 0C      [ 4] 1048         ldaa    SCCCTRLA
   8852 84 C0         [ 2] 1049         anda    #0xC0
   8854 26 22         [ 3] 1050         bne     L8878  
   8856 B6 18 0C      [ 4] 1051         ldaa    SCCCTRLA
   8859 44            [ 2] 1052         lsra
   885A 24 35         [ 3] 1053         bcc     L8891  
   885C 7C 00 48      [ 6] 1054         inc     (0x0048)
   885F B6 18 0E      [ 4] 1055         ldaa    SCCDATAA
   8862                    1056 L8862:
   8862 BD F9 6F      [ 6] 1057         jsr     SERIALW      
   8865 97 4A         [ 3] 1058         staa    (0x004A)
   8867 20 2D         [ 3] 1059         bra     L8896  
   8869                    1060 L8869:
   8869 B6 18 0E      [ 4] 1061         ldaa    SCCDATAA
   886C 86 30         [ 2] 1062         ldaa    #0x30
   886E B7 18 0C      [ 4] 1063         staa    SCCCTRLA
   8871 86 07         [ 2] 1064         ldaa    #0x07
   8873 BD F9 6F      [ 6] 1065         jsr     SERIALW      
   8876 0C            [ 2] 1066         clc
   8877 3B            [12] 1067         rti
                           1068 
   8878                    1069 L8878:
   8878 86 07         [ 2] 1070         ldaa    #0x07
   887A BD F9 6F      [ 6] 1071         jsr     SERIALW      
   887D 86 0E         [ 2] 1072         ldaa    #0x0E
   887F B7 18 0C      [ 4] 1073         staa    SCCCTRLA
   8882 86 43         [ 2] 1074         ldaa    #0x43
   8884 B7 18 0C      [ 4] 1075         staa    SCCCTRLA
   8887 B6 18 0E      [ 4] 1076         ldaa    SCCDATAA
   888A 86 07         [ 2] 1077         ldaa    #0x07
   888C BD F9 6F      [ 6] 1078         jsr     SERIALW      
   888F 0D            [ 2] 1079         sec
   8890 3B            [12] 1080         rti
                           1081 
   8891                    1082 L8891:
   8891 B6 18 0E      [ 4] 1083         ldaa    SCCDATAA
   8894 0C            [ 2] 1084         clc
   8895 3B            [12] 1085         rti
                           1086 
   8896                    1087 L8896:
   8896 84 7F         [ 2] 1088         anda    #0x7F
   8898 81 24         [ 2] 1089         cmpa    #0x24       ;'$'
   889A 27 44         [ 3] 1090         beq     L88E0  
   889C 81 25         [ 2] 1091         cmpa    #0x25       ;'%'
   889E 27 40         [ 3] 1092         beq     L88E0  
   88A0 81 20         [ 2] 1093         cmpa    #0x20       ;' '
   88A2 27 3A         [ 3] 1094         beq     L88DE  
   88A4 81 30         [ 2] 1095         cmpa    #0x30       ;'0'
   88A6 25 35         [ 3] 1096         bcs     L88DD
   88A8 97 12         [ 3] 1097         staa    (0x0012)
   88AA 96 4D         [ 3] 1098         ldaa    (0x004D)
   88AC 81 02         [ 2] 1099         cmpa    #0x02
   88AE 25 09         [ 3] 1100         bcs     L88B9  
   88B0 7F 00 4D      [ 6] 1101         clr     (0x004D)
   88B3 96 12         [ 3] 1102         ldaa    (0x0012)
   88B5 97 49         [ 3] 1103         staa    (0x0049)
   88B7 20 24         [ 3] 1104         bra     L88DD  
   88B9                    1105 L88B9:
   88B9 7D 00 4E      [ 6] 1106         tst     (0x004E)
   88BC 27 1F         [ 3] 1107         beq     L88DD  
   88BE 86 78         [ 2] 1108         ldaa    #0x78
   88C0 97 63         [ 3] 1109         staa    (0x0063)
   88C2 97 64         [ 3] 1110         staa    (0x0064)
   88C4 96 12         [ 3] 1111         ldaa    (0x0012)
   88C6 81 40         [ 2] 1112         cmpa    #0x40
   88C8 24 07         [ 3] 1113         bcc     L88D1  
   88CA 97 4C         [ 3] 1114         staa    (0x004C)
   88CC 7F 00 4D      [ 6] 1115         clr     (0x004D)
   88CF 20 0C         [ 3] 1116         bra     L88DD  
   88D1                    1117 L88D1:
   88D1 81 60         [ 2] 1118         cmpa    #0x60
   88D3 24 08         [ 3] 1119         bcc     L88DD  
   88D5 97 4B         [ 3] 1120         staa    (0x004B)
   88D7 7F 00 4D      [ 6] 1121         clr     (0x004D)
   88DA BD 88 E5      [ 6] 1122         jsr     L88E5
   88DD                    1123 L88DD:
   88DD 3B            [12] 1124         rti
                           1125 
   88DE                    1126 L88DE:
   88DE 20 FD         [ 3] 1127         bra     L88DD           ; Infinite loop
   88E0                    1128 L88E0:
   88E0 7C 00 4D      [ 6] 1129         inc     (0x004D)
   88E3 20 F9         [ 3] 1130         bra     L88DE
   88E5                    1131 L88E5:
   88E5 D6 4B         [ 3] 1132         ldab    (0x004B)
   88E7 96 4C         [ 3] 1133         ldaa    (0x004C)
   88E9 7D 04 5C      [ 6] 1134         tst     (0x045C)
   88EC 27 0D         [ 3] 1135         beq     L88FB  
   88EE 81 3C         [ 2] 1136         cmpa    #0x3C
   88F0 25 09         [ 3] 1137         bcs     L88FB  
   88F2 81 3F         [ 2] 1138         cmpa    #0x3F
   88F4 22 05         [ 3] 1139         bhi     L88FB  
   88F6 BD 89 93      [ 6] 1140         jsr     L8993
   88F9 20 65         [ 3] 1141         bra     L8960  
   88FB                    1142 L88FB:
   88FB 1A 83 30 48   [ 5] 1143         cpd     #0x3048
   88FF 27 79         [ 3] 1144         beq     L897A  
   8901 1A 83 31 48   [ 5] 1145         cpd     #0x3148
   8905 27 5A         [ 3] 1146         beq     L8961  
   8907 1A 83 34 4D   [ 5] 1147         cpd     #0x344D
   890B 27 6D         [ 3] 1148         beq     L897A  
   890D 1A 83 35 4D   [ 5] 1149         cpd     #0x354D
   8911 27 4E         [ 3] 1150         beq     L8961  
   8913 1A 83 36 4D   [ 5] 1151         cpd     #0x364D
   8917 27 61         [ 3] 1152         beq     L897A  
   8919 1A 83 37 4D   [ 5] 1153         cpd     #0x374D
   891D 27 42         [ 3] 1154         beq     L8961  
   891F CE 10 80      [ 3] 1155         ldx     #0x1080
   8922 D6 4C         [ 3] 1156         ldab    (0x004C)
   8924 C0 30         [ 2] 1157         subb    #0x30
   8926 54            [ 2] 1158         lsrb
   8927 58            [ 2] 1159         aslb
   8928 58            [ 2] 1160         aslb
   8929 3A            [ 3] 1161         abx
   892A D6 4B         [ 3] 1162         ldab    (0x004B)
   892C C1 50         [ 2] 1163         cmpb    #0x50
   892E 24 30         [ 3] 1164         bcc     L8960  
   8930 C1 47         [ 2] 1165         cmpb    #0x47
   8932 23 02         [ 3] 1166         bls     L8936  
   8934 08            [ 3] 1167         inx
   8935 08            [ 3] 1168         inx
   8936                    1169 L8936:
   8936 C0 40         [ 2] 1170         subb    #0x40
   8938 C4 07         [ 2] 1171         andb    #0x07
   893A 4F            [ 2] 1172         clra
   893B 0D            [ 2] 1173         sec
   893C 49            [ 2] 1174         rola
   893D 5D            [ 2] 1175         tstb
   893E 27 04         [ 3] 1176         beq     L8944  
   8940                    1177 L8940:
   8940 49            [ 2] 1178         rola
   8941 5A            [ 2] 1179         decb
   8942 26 FC         [ 3] 1180         bne     L8940  
   8944                    1181 L8944:
   8944 97 50         [ 3] 1182         staa    (0x0050)
   8946 96 4C         [ 3] 1183         ldaa    (0x004C)
   8948 84 01         [ 2] 1184         anda    #0x01
   894A 27 08         [ 3] 1185         beq     L8954  
   894C A6 00         [ 4] 1186         ldaa    0,X
   894E 9A 50         [ 3] 1187         oraa    (0x0050)
   8950 A7 00         [ 4] 1188         staa    0,X
   8952 20 0C         [ 3] 1189         bra     L8960  
   8954                    1190 L8954:
   8954 96 50         [ 3] 1191         ldaa    (0x0050)
   8956 88 FF         [ 2] 1192         eora    #0xFF
   8958 97 50         [ 3] 1193         staa    (0x0050)
   895A A6 00         [ 4] 1194         ldaa    0,X
   895C 94 50         [ 3] 1195         anda    (0x0050)
   895E A7 00         [ 4] 1196         staa    0,X
   8960                    1197 L8960:
   8960 39            [ 5] 1198         rts
                           1199 
   8961                    1200 L8961:
   8961 B6 10 82      [ 4] 1201         ldaa    (0x1082)
   8964 8A 01         [ 2] 1202         oraa    #0x01
   8966 B7 10 82      [ 4] 1203         staa    (0x1082)
   8969 B6 10 8A      [ 4] 1204         ldaa    (0x108A)
   896C 8A 20         [ 2] 1205         oraa    #0x20
   896E B7 10 8A      [ 4] 1206         staa    (0x108A)
   8971 B6 10 8E      [ 4] 1207         ldaa    (0x108E)
   8974 8A 20         [ 2] 1208         oraa    #0x20
   8976 B7 10 8E      [ 4] 1209         staa    (0x108E)
   8979 39            [ 5] 1210         rts
                           1211 
   897A                    1212 L897A:
   897A B6 10 82      [ 4] 1213         ldaa    (0x1082)
   897D 84 FE         [ 2] 1214         anda    #0xFE
   897F B7 10 82      [ 4] 1215         staa    (0x1082)
   8982 B6 10 8A      [ 4] 1216         ldaa    (0x108A)
   8985 84 DF         [ 2] 1217         anda    #0xDF
   8987 B7 10 8A      [ 4] 1218         staa    (0x108A)
   898A B6 10 8E      [ 4] 1219         ldaa    (0x108E)
   898D 84 DF         [ 2] 1220         anda    #0xDF
   898F B7 10 8E      [ 4] 1221         staa    (0x108E)
   8992 39            [ 5] 1222         rts
                           1223 
   8993                    1224 L8993:
   8993 3C            [ 4] 1225         pshx
   8994 81 3D         [ 2] 1226         cmpa    #0x3D
   8996 22 05         [ 3] 1227         bhi     L899D  
   8998 CE F7 80      [ 3] 1228         ldx     #LF780          ; table at the end
   899B 20 03         [ 3] 1229         bra     L89A0  
   899D                    1230 L899D:
   899D CE F7 A0      [ 3] 1231         ldx     #LF7A0         ; table at the end
   89A0                    1232 L89A0:
   89A0 C0 40         [ 2] 1233         subb    #0x40
   89A2 58            [ 2] 1234         aslb
   89A3 3A            [ 3] 1235         abx
   89A4 81 3C         [ 2] 1236         cmpa    #0x3C
   89A6 27 34         [ 3] 1237         beq     L89DC  
   89A8 81 3D         [ 2] 1238         cmpa    #0x3D
   89AA 27 0A         [ 3] 1239         beq     L89B6  
   89AC 81 3E         [ 2] 1240         cmpa    #0x3E
   89AE 27 4B         [ 3] 1241         beq     L89FB  
   89B0 81 3F         [ 2] 1242         cmpa    #0x3F
   89B2 27 15         [ 3] 1243         beq     L89C9  
   89B4 38            [ 5] 1244         pulx
   89B5 39            [ 5] 1245         rts
                           1246 
   89B6                    1247 L89B6:
   89B6 B6 10 98      [ 4] 1248         ldaa    (0x1098)
   89B9 AA 00         [ 4] 1249         oraa    0,X
   89BB B7 10 98      [ 4] 1250         staa    (0x1098)
   89BE 08            [ 3] 1251         inx
   89BF B6 10 9A      [ 4] 1252         ldaa    (0x109A)
   89C2 AA 00         [ 4] 1253         oraa    0,X
   89C4 B7 10 9A      [ 4] 1254         staa    (0x109A)
   89C7 38            [ 5] 1255         pulx
   89C8 39            [ 5] 1256         rts
                           1257 
   89C9                    1258 L89C9:
   89C9 B6 10 9C      [ 4] 1259         ldaa    (0x109C)
   89CC AA 00         [ 4] 1260         oraa    0,X
   89CE B7 10 9C      [ 4] 1261         staa    (0x109C)
   89D1 08            [ 3] 1262         inx
   89D2 B6 10 9E      [ 4] 1263         ldaa    (0x109E)
   89D5 AA 00         [ 4] 1264         oraa    0,X
   89D7 B7 10 9E      [ 4] 1265         staa    (0x109E)
   89DA 38            [ 5] 1266         pulx
   89DB 39            [ 5] 1267         rts
                           1268 
   89DC                    1269 L89DC:
   89DC E6 00         [ 4] 1270         ldab    0,X
   89DE C8 FF         [ 2] 1271         eorb    #0xFF
   89E0 D7 12         [ 3] 1272         stab    (0x0012)
   89E2 B6 10 98      [ 4] 1273         ldaa    (0x1098)
   89E5 94 12         [ 3] 1274         anda    (0x0012)
   89E7 B7 10 98      [ 4] 1275         staa    (0x1098)
   89EA 08            [ 3] 1276         inx
   89EB E6 00         [ 4] 1277         ldab    0,X
   89ED C8 FF         [ 2] 1278         eorb    #0xFF
   89EF D7 12         [ 3] 1279         stab    (0x0012)
   89F1 B6 10 9A      [ 4] 1280         ldaa    (0x109A)
   89F4 94 12         [ 3] 1281         anda    (0x0012)
   89F6 B7 10 9A      [ 4] 1282         staa    (0x109A)
   89F9 38            [ 5] 1283         pulx
   89FA 39            [ 5] 1284         rts
                           1285 
   89FB                    1286 L89FB:
   89FB E6 00         [ 4] 1287         ldab    0,X
   89FD C8 FF         [ 2] 1288         eorb    #0xFF
   89FF D7 12         [ 3] 1289         stab    (0x0012)
   8A01 B6 10 9C      [ 4] 1290         ldaa    (0x109C)
   8A04 94 12         [ 3] 1291         anda    (0x0012)
   8A06 B7 10 9C      [ 4] 1292         staa    (0x109C)
   8A09 08            [ 3] 1293         inx
   8A0A E6 00         [ 4] 1294         ldab    0,X
   8A0C C8 FF         [ 2] 1295         eorb    #0xFF
   8A0E D7 12         [ 3] 1296         stab    (0x0012)
   8A10 B6 10 9E      [ 4] 1297         ldaa    (0x109E)
   8A13 94 12         [ 3] 1298         anda    (0x0012)
   8A15 B7 10 9E      [ 4] 1299         staa    (0x109E)
   8A18 38            [ 5] 1300         pulx
   8A19 39            [ 5] 1301         rts
                           1302 
                           1303 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1304 
   8A1A                    1305 L8A1A:
                           1306 ; Read from table location in X
   8A1A 3C            [ 4] 1307         pshx
   8A1B                    1308 L8A1B:
   8A1B 86 04         [ 2] 1309         ldaa    #0x04
   8A1D B5 18 0D      [ 4] 1310         bita    SCCCTRLB
   8A20 27 F9         [ 3] 1311         beq     L8A1B  
   8A22 A6 00         [ 4] 1312         ldaa    0,X     
   8A24 26 03         [ 3] 1313         bne     L8A29       ; is it a nul?
   8A26 7E 8B 21      [ 3] 1314         jmp     L8B21       ; if so jump to exit
   8A29                    1315 L8A29:
   8A29 08            [ 3] 1316         inx
   8A2A 81 5E         [ 2] 1317         cmpa    #0x5E       ; is is a caret? '^'
   8A2C 26 1D         [ 3] 1318         bne     L8A4B       ; no, jump ahead
   8A2E A6 00         [ 4] 1319         ldaa    0,X         ; yes, get the next char
   8A30 08            [ 3] 1320         inx
   8A31 B7 05 92      [ 4] 1321         staa    (0x0592)    
   8A34 A6 00         [ 4] 1322         ldaa    0,X     
   8A36 08            [ 3] 1323         inx
   8A37 B7 05 93      [ 4] 1324         staa    (0x0593)
   8A3A A6 00         [ 4] 1325         ldaa    0,X     
   8A3C 08            [ 3] 1326         inx
   8A3D B7 05 95      [ 4] 1327         staa    (0x0595)
   8A40 A6 00         [ 4] 1328         ldaa    0,X     
   8A42 08            [ 3] 1329         inx
   8A43 B7 05 96      [ 4] 1330         staa    (0x0596)
   8A46 BD 8B 23      [ 6] 1331         jsr     L8B23
   8A49 20 D0         [ 3] 1332         bra     L8A1B  
                           1333 
   8A4B                    1334 L8A4B:
   8A4B 81 40         [ 2] 1335         cmpa    #0x40
   8A4D 26 3B         [ 3] 1336         bne     L8A8A  
   8A4F 1A EE 00      [ 6] 1337         ldy     0,X     
   8A52 08            [ 3] 1338         inx
   8A53 08            [ 3] 1339         inx
   8A54 86 30         [ 2] 1340         ldaa    #0x30
   8A56 97 B1         [ 3] 1341         staa    (0x00B1)
   8A58 18 A6 00      [ 5] 1342         ldaa    0,Y     
   8A5B                    1343 L8A5B:
   8A5B 81 64         [ 2] 1344         cmpa    #0x64
   8A5D 25 07         [ 3] 1345         bcs     L8A66  
   8A5F 7C 00 B1      [ 6] 1346         inc     (0x00B1)
   8A62 80 64         [ 2] 1347         suba    #0x64
   8A64 20 F5         [ 3] 1348         bra     L8A5B  
   8A66                    1349 L8A66:
   8A66 36            [ 3] 1350         psha
   8A67 96 B1         [ 3] 1351         ldaa    (0x00B1)
   8A69 BD 8B 3B      [ 6] 1352         jsr     L8B3B
   8A6C 86 30         [ 2] 1353         ldaa    #0x30
   8A6E 97 B1         [ 3] 1354         staa    (0x00B1)
   8A70 32            [ 4] 1355         pula
   8A71                    1356 L8A71:
   8A71 81 0A         [ 2] 1357         cmpa    #0x0A
   8A73 25 07         [ 3] 1358         bcs     L8A7C  
   8A75 7C 00 B1      [ 6] 1359         inc     (0x00B1)
   8A78 80 0A         [ 2] 1360         suba    #0x0A
   8A7A 20 F5         [ 3] 1361         bra     L8A71  
   8A7C                    1362 L8A7C:
   8A7C 36            [ 3] 1363         psha
   8A7D 96 B1         [ 3] 1364         ldaa    (0x00B1)
   8A7F BD 8B 3B      [ 6] 1365         jsr     L8B3B
   8A82 32            [ 4] 1366         pula
   8A83 8B 30         [ 2] 1367         adda    #0x30
   8A85 BD 8B 3B      [ 6] 1368         jsr     L8B3B
   8A88 20 91         [ 3] 1369         bra     L8A1B  
   8A8A                    1370 L8A8A:
   8A8A 81 7C         [ 2] 1371         cmpa    #0x7C
   8A8C 26 59         [ 3] 1372         bne     L8AE7  
   8A8E 1A EE 00      [ 6] 1373         ldy     0,X     
   8A91 08            [ 3] 1374         inx
   8A92 08            [ 3] 1375         inx
   8A93 86 30         [ 2] 1376         ldaa    #0x30
   8A95 97 B1         [ 3] 1377         staa    (0x00B1)
   8A97 18 EC 00      [ 6] 1378         ldd     0,Y     
   8A9A                    1379 L8A9A:
   8A9A 1A 83 27 10   [ 5] 1380         cpd     #0x2710
   8A9E 25 08         [ 3] 1381         bcs     L8AA8  
   8AA0 7C 00 B1      [ 6] 1382         inc     (0x00B1)
   8AA3 83 27 10      [ 4] 1383         subd    #0x2710
   8AA6 20 F2         [ 3] 1384         bra     L8A9A  
   8AA8                    1385 L8AA8:
   8AA8 36            [ 3] 1386         psha
   8AA9 96 B1         [ 3] 1387         ldaa    (0x00B1)
   8AAB BD 8B 3B      [ 6] 1388         jsr     L8B3B
   8AAE 86 30         [ 2] 1389         ldaa    #0x30
   8AB0 97 B1         [ 3] 1390         staa    (0x00B1)
   8AB2 32            [ 4] 1391         pula
   8AB3                    1392 L8AB3:
   8AB3 1A 83 03 E8   [ 5] 1393         cpd     #0x03E8
   8AB7 25 08         [ 3] 1394         bcs     L8AC1  
   8AB9 7C 00 B1      [ 6] 1395         inc     (0x00B1)
   8ABC 83 03 E8      [ 4] 1396         subd    #0x03E8
   8ABF 20 F2         [ 3] 1397         bra     L8AB3  
   8AC1                    1398 L8AC1:
   8AC1 36            [ 3] 1399         psha
   8AC2 96 B1         [ 3] 1400         ldaa    (0x00B1)
   8AC4 BD 8B 3B      [ 6] 1401         jsr     L8B3B
   8AC7 86 30         [ 2] 1402         ldaa    #0x30
   8AC9 97 B1         [ 3] 1403         staa    (0x00B1)
   8ACB 32            [ 4] 1404         pula
   8ACC                    1405 L8ACC:
   8ACC 1A 83 00 64   [ 5] 1406         cpd     #0x0064
   8AD0 25 08         [ 3] 1407         bcs     L8ADA  
   8AD2 7C 00 B1      [ 6] 1408         inc     (0x00B1)
   8AD5 83 00 64      [ 4] 1409         subd    #0x0064
   8AD8 20 F2         [ 3] 1410         bra     L8ACC  
   8ADA                    1411 L8ADA:
   8ADA 96 B1         [ 3] 1412         ldaa    (0x00B1)
   8ADC BD 8B 3B      [ 6] 1413         jsr     L8B3B
   8ADF 86 30         [ 2] 1414         ldaa    #0x30
   8AE1 97 B1         [ 3] 1415         staa    (0x00B1)
   8AE3 17            [ 2] 1416         tba
   8AE4 7E 8A 71      [ 3] 1417         jmp     L8A71
   8AE7                    1418 L8AE7:
   8AE7 81 7E         [ 2] 1419         cmpa    #0x7E
   8AE9 26 18         [ 3] 1420         bne     L8B03  
   8AEB E6 00         [ 4] 1421         ldab    0,X     
   8AED C0 30         [ 2] 1422         subb    #0x30
   8AEF 08            [ 3] 1423         inx
   8AF0 1A EE 00      [ 6] 1424         ldy     0,X     
   8AF3 08            [ 3] 1425         inx
   8AF4 08            [ 3] 1426         inx
   8AF5                    1427 L8AF5:
   8AF5 18 A6 00      [ 5] 1428         ldaa    0,Y     
   8AF8 18 08         [ 4] 1429         iny
   8AFA BD 8B 3B      [ 6] 1430         jsr     L8B3B
   8AFD 5A            [ 2] 1431         decb
   8AFE 26 F5         [ 3] 1432         bne     L8AF5  
   8B00 7E 8A 1B      [ 3] 1433         jmp     L8A1B
   8B03                    1434 L8B03:
   8B03 81 25         [ 2] 1435         cmpa    #0x25
   8B05 26 14         [ 3] 1436         bne     L8B1B  
   8B07 CE 05 90      [ 3] 1437         ldx     #0x0590
   8B0A CC 1B 5B      [ 3] 1438         ldd     #0x1B5B
   8B0D ED 00         [ 5] 1439         std     0,X     
   8B0F 86 4B         [ 2] 1440         ldaa    #0x4B
   8B11 A7 02         [ 4] 1441         staa    2,X
   8B13 6F 03         [ 6] 1442         clr     3,X
   8B15 BD 8A 1A      [ 6] 1443         jsr     L8A1A  
   8B18 7E 8A 1B      [ 3] 1444         jmp     L8A1B
   8B1B                    1445 L8B1B:
   8B1B B7 18 0F      [ 4] 1446         staa    SCCDATAB
   8B1E 7E 8A 1B      [ 3] 1447         jmp     L8A1B
   8B21                    1448 L8B21:
   8B21 38            [ 5] 1449         pulx
   8B22 39            [ 5] 1450         rts
                           1451 
   8B23                    1452 L8B23:
   8B23 3C            [ 4] 1453         pshx
   8B24 CE 05 90      [ 3] 1454         ldx     #0x0590
   8B27 CC 1B 5B      [ 3] 1455         ldd     #0x1B5B
   8B2A ED 00         [ 5] 1456         std     0,X     
   8B2C 86 48         [ 2] 1457         ldaa    #0x48
   8B2E A7 07         [ 4] 1458         staa    7,X
   8B30 86 3B         [ 2] 1459         ldaa    #0x3B
   8B32 A7 04         [ 4] 1460         staa    4,X
   8B34 6F 08         [ 6] 1461         clr     8,X
   8B36 BD 8A 1A      [ 6] 1462         jsr     L8A1A  
   8B39 38            [ 5] 1463         pulx
   8B3A 39            [ 5] 1464         rts
   8B3B                    1465 L8B3B:
   8B3B 36            [ 3] 1466         psha
   8B3C                    1467 L8B3C:
   8B3C 86 04         [ 2] 1468         ldaa    #0x04
   8B3E B5 18 0D      [ 4] 1469         bita    SCCCTRLB
   8B41 27 F9         [ 3] 1470         beq     L8B3C  
   8B43 32            [ 4] 1471         pula
   8B44 B7 18 0F      [ 4] 1472         staa    SCCDATAB
   8B47 39            [ 5] 1473         rts
                           1474 
   8B48                    1475 L8B48:
   8B48 BD A3 2E      [ 6] 1476         jsr     LA32E
                           1477 
   8B4B BD 8D E4      [ 6] 1478         jsr     LCDMSG1 
   8B4E 4C 69 67 68 74 20  1479         .ascis  'Light Diagnostic'
        44 69 61 67 6E 6F
        73 74 69 E3
                           1480 
   8B5E BD 8D DD      [ 6] 1481         jsr     LCDMSG2 
   8B61 43 75 72 74 61 69  1482         .ascis  'Curtains opening'
        6E 73 20 6F 70 65
        6E 69 6E E7
                           1483 
   8B71 C6 14         [ 2] 1484         ldab    #0x14
   8B73 BD 8C 30      [ 6] 1485         jsr     DLYSECSBY2           ; delay 10 sec
   8B76 C6 FF         [ 2] 1486         ldab    #0xFF
   8B78 F7 10 98      [ 4] 1487         stab    (0x1098)
   8B7B F7 10 9A      [ 4] 1488         stab    (0x109A)
   8B7E F7 10 9C      [ 4] 1489         stab    (0x109C)
   8B81 F7 10 9E      [ 4] 1490         stab    (0x109E)
   8B84 BD F9 C5      [ 6] 1491         jsr     BUTNLIT 
   8B87 B6 18 04      [ 4] 1492         ldaa    PIA0PRA 
   8B8A 8A 40         [ 2] 1493         oraa    #0x40
   8B8C B7 18 04      [ 4] 1494         staa    PIA0PRA 
                           1495 
   8B8F BD 8D E4      [ 6] 1496         jsr     LCDMSG1 
   8B92 20 50 72 65 73 73  1497         .ascis  ' Press ENTER to '
        20 45 4E 54 45 52
        20 74 6F A0
                           1498 
   8BA2 BD 8D DD      [ 6] 1499         jsr     LCDMSG2 
   8BA5 74 75 72 6E 20 6C  1500         .ascis  'turn lights  off'
        69 67 68 74 73 20
        20 6F 66 E6
                           1501 
   8BB5                    1502 L8BB5:
   8BB5 BD 8E 95      [ 6] 1503         jsr     L8E95
   8BB8 81 0D         [ 2] 1504         cmpa    #0x0D
   8BBA 26 F9         [ 3] 1505         bne     L8BB5  
   8BBC BD A3 41      [ 6] 1506         jsr     LA341
   8BBF 39            [ 5] 1507         rts
                           1508 
                           1509 ; setup IRQ handlers!
   8BC0                    1510 L8BC0:
   8BC0 86 80         [ 2] 1511         ldaa    #0x80
   8BC2 B7 10 22      [ 4] 1512         staa    TMSK1
   8BC5 CE AB CC      [ 3] 1513         ldx     #LABCC
   8BC8 FF 01 19      [ 5] 1514         stx     (0x0119)
   8BCB CE AD 0C      [ 3] 1515         ldx     #LAD0C
   8BCE FF 01 16      [ 5] 1516         stx     (0x0116)
   8BD1 CE AD 0C      [ 3] 1517         ldx     #LAD0C
   8BD4 FF 01 2E      [ 5] 1518         stx     (0x012E)
   8BD7 86 7E         [ 2] 1519         ldaa    #0x7E
   8BD9 B7 01 18      [ 4] 1520         staa    (0x0118)
   8BDC B7 01 15      [ 4] 1521         staa    (0x0115)
   8BDF B7 01 2D      [ 4] 1522         staa    (0x012D)
   8BE2 4F            [ 2] 1523         clra
   8BE3 5F            [ 2] 1524         clrb
   8BE4 DD 1B         [ 4] 1525         std     CDTIMR1     ; Reset all the countdown timers
   8BE6 DD 1D         [ 4] 1526         std     CDTIMR2
   8BE8 DD 1F         [ 4] 1527         std     CDTIMR3
   8BEA DD 21         [ 4] 1528         std     CDTIMR4
   8BEC DD 23         [ 4] 1529         std     CDTIMR5
                           1530 
   8BEE                    1531 L8BEE:
   8BEE 86 C0         [ 2] 1532         ldaa    #0xC0
   8BF0 B7 10 23      [ 4] 1533         staa    TFLG1  
   8BF3 39            [ 5] 1534         rts
                           1535 
   8BF4                    1536 L8BF4:
   8BF4 B6 10 0A      [ 4] 1537         ldaa    PORTE
   8BF7 88 FF         [ 2] 1538         eora    #0xFF
   8BF9 16            [ 2] 1539         tab
   8BFA D7 62         [ 3] 1540         stab    (0x0062)
   8BFC BD F9 C5      [ 6] 1541         jsr     BUTNLIT 
   8BFF 20 F3         [ 3] 1542         bra     L8BF4  
   8C01 39            [ 5] 1543         rts
                           1544 
                           1545 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1546 
                           1547 ; Delay B seconds, with housekeeping
   8C02                    1548 DLYSECS:
   8C02 36            [ 3] 1549         psha
   8C03 86 64         [ 2] 1550         ldaa    #0x64
   8C05 3D            [10] 1551         mul
   8C06 DD 23         [ 4] 1552         std     CDTIMR5     ; store B*100 here
   8C08                    1553 L8C08:
   8C08 BD 9B 19      [ 6] 1554         jsr     L9B19   
   8C0B DC 23         [ 4] 1555         ldd     CDTIMR5     ; housekeeping
   8C0D 26 F9         [ 3] 1556         bne     L8C08  
   8C0F 32            [ 4] 1557         pula
   8C10 39            [ 5] 1558         rts
                           1559 
                           1560 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1561 
                           1562 ; Delay 1 minute, with housekeeping - unused?
   8C11                    1563 DLY1MIN:
   8C11 36            [ 3] 1564         psha
   8C12 86 3C         [ 2] 1565         ldaa    #0x3C
   8C14                    1566 L8C14:
   8C14 97 28         [ 3] 1567         staa    (0x0028)
   8C16 C6 01         [ 2] 1568         ldab    #0x01       ; delay 1 sec
   8C18 BD 8C 02      [ 6] 1569         jsr     DLYSECS     ;
   8C1B 96 28         [ 3] 1570         ldaa    (0x0028)
   8C1D 4A            [ 2] 1571         deca
   8C1E 26 F4         [ 3] 1572         bne     L8C14  
   8C20 32            [ 4] 1573         pula
   8C21 39            [ 5] 1574         rts
                           1575 
                           1576 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1577 
                           1578 ; Delay by B hundreths of a second, with housekeeping
   8C22                    1579 DLYSECSBY100:
   8C22 36            [ 3] 1580         psha
   8C23 4F            [ 2] 1581         clra
   8C24 DD 23         [ 4] 1582         std     CDTIMR5
   8C26                    1583 L8C26:
   8C26 BD 9B 19      [ 6] 1584         jsr     L9B19   
   8C29 7D 00 24      [ 6] 1585         tst     CDTIMR5+1
   8C2C 26 F8         [ 3] 1586         bne     L8C26       ; housekeeping?
   8C2E 32            [ 4] 1587         pula
   8C2F 39            [ 5] 1588         rts
                           1589 
                           1590 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1591 
                           1592 ; Delay by B half-seconds, with housekeeping
   8C30                    1593 DLYSECSBY2:
   8C30 36            [ 3] 1594         psha
   8C31 86 32         [ 2] 1595         ldaa    #0x32       ; 50
   8C33 3D            [10] 1596         mul
   8C34 DD 23         [ 4] 1597         std     CDTIMR5
   8C36                    1598 L8C36:
   8C36 DC 23         [ 4] 1599         ldd     CDTIMR5
   8C38 26 FC         [ 3] 1600         bne     L8C36       ; housekeeping?
   8C3A 32            [ 4] 1601         pula
   8C3B 39            [ 5] 1602         rts
                           1603 
                           1604 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1605 ; LCD routines
                           1606 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1607 
   8C3C                    1608 L8C3C:
   8C3C 86 FF         [ 2] 1609         ldaa    #0xFF
   8C3E B7 10 01      [ 4] 1610         staa    DDRA  
   8C41 86 FF         [ 2] 1611         ldaa    #0xFF
   8C43 B7 10 03      [ 4] 1612         staa    DDRG 
   8C46 B6 10 02      [ 4] 1613         ldaa    PORTG  
   8C49 8A 02         [ 2] 1614         oraa    #0x02
   8C4B B7 10 02      [ 4] 1615         staa    PORTG  
   8C4E 86 38         [ 2] 1616         ldaa    #0x38
   8C50 BD 8C 86      [ 6] 1617         jsr     L8C86        ; write byte to LCD
   8C53 86 38         [ 2] 1618         ldaa    #0x38
   8C55 BD 8C 86      [ 6] 1619         jsr     L8C86        ; write byte to LCD
   8C58 86 06         [ 2] 1620         ldaa    #0x06
   8C5A BD 8C 86      [ 6] 1621         jsr     L8C86        ; write byte to LCD
   8C5D 86 0E         [ 2] 1622         ldaa    #0x0E
   8C5F BD 8C 86      [ 6] 1623         jsr     L8C86        ; write byte to LCD
   8C62 86 01         [ 2] 1624         ldaa    #0x01
   8C64 BD 8C 86      [ 6] 1625         jsr     L8C86        ; write byte to LCD
   8C67 CE 00 FF      [ 3] 1626         ldx     #0x00FF
   8C6A                    1627 L8C6A:
   8C6A 01            [ 2] 1628         nop
   8C6B 01            [ 2] 1629         nop
   8C6C 09            [ 3] 1630         dex
   8C6D 26 FB         [ 3] 1631         bne     L8C6A  
   8C6F 39            [ 5] 1632         rts
                           1633 
                           1634 ; toggle LCD ENABLE
   8C70                    1635 L8C70:
   8C70 B6 10 02      [ 4] 1636         ldaa    PORTG  
   8C73 84 FD         [ 2] 1637         anda    #0xFD        ; clear LCD ENABLE
   8C75 B7 10 02      [ 4] 1638         staa    PORTG  
   8C78 8A 02         [ 2] 1639         oraa    #0x02        ; set LCD ENABLE
   8C7A B7 10 02      [ 4] 1640         staa    PORTG  
   8C7D 39            [ 5] 1641         rts
                           1642 
                           1643 ; Reset LCD buffer?
   8C7E                    1644 L8C7E:
   8C7E CC 05 00      [ 3] 1645         ldd     #0x0500     ; Reset LCD queue?
   8C81 DD 46         [ 4] 1646         std     (0x0046)    ; write pointer
   8C83 DD 44         [ 4] 1647         std     (0x0044)    ; read pointer?
   8C85 39            [ 5] 1648         rts
                           1649 
                           1650 ; write byte to LCD
   8C86                    1651 L8C86:
   8C86 BD 8C BD      [ 6] 1652         jsr     L8CBD        ; wait for LCD not busy
   8C89 B7 10 00      [ 4] 1653         staa    PORTA  
   8C8C B6 10 02      [ 4] 1654         ldaa    PORTG       
   8C8F 84 F3         [ 2] 1655         anda    #0xF3        ; LCD RS and LCD RW low
   8C91                    1656 L8C91:
   8C91 B7 10 02      [ 4] 1657         staa    PORTG  
   8C94 BD 8C 70      [ 6] 1658         jsr     L8C70        ; toggle LCD ENABLE
   8C97 39            [ 5] 1659         rts
                           1660 
                           1661 ; ???
   8C98                    1662 L8C98:
   8C98 BD 8C BD      [ 6] 1663         jsr     L8CBD        ; wait for LCD not busy
   8C9B B7 10 00      [ 4] 1664         staa    PORTA  
   8C9E B6 10 02      [ 4] 1665         ldaa    PORTG  
   8CA1 84 FB         [ 2] 1666         anda    #0xFB
   8CA3 8A 08         [ 2] 1667         oraa    #0x08
   8CA5 20 EA         [ 3] 1668         bra     L8C91  
   8CA7 BD 8C BD      [ 6] 1669         jsr     L8CBD        ; wait for LCD not busy
   8CAA B6 10 02      [ 4] 1670         ldaa    PORTG  
   8CAD 84 F7         [ 2] 1671         anda    #0xF7
   8CAF 8A 08         [ 2] 1672         oraa    #0x08
   8CB1 20 DE         [ 3] 1673         bra     L8C91  
   8CB3 BD 8C BD      [ 6] 1674         jsr     L8CBD        ; wait for LCD not busy
   8CB6 B6 10 02      [ 4] 1675         ldaa    PORTG  
   8CB9 8A 0C         [ 2] 1676         oraa    #0x0C
   8CBB 20 D4         [ 3] 1677         bra     L8C91  
                           1678 
                           1679 ; wait for LCD not busy (or timeout)
   8CBD                    1680 L8CBD:
   8CBD 36            [ 3] 1681         psha
   8CBE 37            [ 3] 1682         pshb
   8CBF C6 FF         [ 2] 1683         ldab    #0xFF        ; init timeout counter
   8CC1                    1684 L8CC1:
   8CC1 5D            [ 2] 1685         tstb
   8CC2 27 1A         [ 3] 1686         beq     L8CDE       ; times up, exit
   8CC4 B6 10 02      [ 4] 1687         ldaa    PORTG  
   8CC7 84 F7         [ 2] 1688         anda    #0xF7        ; bit 3 low
   8CC9 8A 04         [ 2] 1689         oraa    #0x04        ; bit 3 high
   8CCB B7 10 02      [ 4] 1690         staa    PORTG        ; LCD RS high
   8CCE BD 8C 70      [ 6] 1691         jsr     L8C70        ; toggle LCD ENABLE
   8CD1 7F 10 01      [ 6] 1692         clr     DDRA  
   8CD4 B6 10 00      [ 4] 1693         ldaa    PORTA       ; read busy flag from LCD
   8CD7 2B 08         [ 3] 1694         bmi     L8CE1       ; if busy, keep looping
   8CD9 86 FF         [ 2] 1695         ldaa    #0xFF
   8CDB B7 10 01      [ 4] 1696         staa    DDRA        ; port A back to outputs
   8CDE                    1697 L8CDE:
   8CDE 33            [ 4] 1698         pulb                ; and exit
   8CDF 32            [ 4] 1699         pula
   8CE0 39            [ 5] 1700         rts
                           1701 
   8CE1                    1702 L8CE1:
   8CE1 5A            [ 2] 1703         decb                ; decrement timer
   8CE2 86 FF         [ 2] 1704         ldaa    #0xFF
   8CE4 B7 10 01      [ 4] 1705         staa    DDRA        ; port A back to outputs
   8CE7 20 D8         [ 3] 1706         bra     L8CC1       ; loop
                           1707 
   8CE9                    1708 L8CE9:
   8CE9 BD 8C BD      [ 6] 1709         jsr     L8CBD        ; wait for LCD not busy
   8CEC 86 01         [ 2] 1710         ldaa    #0x01
   8CEE BD 8C 86      [ 6] 1711         jsr     L8C86        ; write byte to LCD
   8CF1 39            [ 5] 1712         rts
                           1713 
   8CF2                    1714 L8CF2:
   8CF2 BD 8C BD      [ 6] 1715         jsr     L8CBD        ; wait for LCD not busy
   8CF5 86 80         [ 2] 1716         ldaa    #0x80
   8CF7 BD 8D 14      [ 6] 1717         jsr     L8D14
   8CFA BD 8C BD      [ 6] 1718         jsr     L8CBD        ; wait for LCD not busy
   8CFD 86 80         [ 2] 1719         ldaa    #0x80
   8CFF BD 8C 86      [ 6] 1720         jsr     L8C86        ; write byte to LCD
   8D02 39            [ 5] 1721         rts
                           1722 
   8D03                    1723 L8D03:
   8D03 BD 8C BD      [ 6] 1724         jsr     L8CBD        ; wait for LCD not busy
   8D06 86 C0         [ 2] 1725         ldaa    #0xC0
   8D08 BD 8D 14      [ 6] 1726         jsr     L8D14
   8D0B BD 8C BD      [ 6] 1727         jsr     L8CBD        ; wait for LCD not busy
   8D0E 86 C0         [ 2] 1728         ldaa    #0xC0
   8D10 BD 8C 86      [ 6] 1729         jsr     L8C86        ; write byte to LCD
   8D13 39            [ 5] 1730         rts
                           1731 
   8D14                    1732 L8D14:
   8D14 BD 8C 86      [ 6] 1733         jsr     L8C86        ; write byte to LCD
   8D17 86 10         [ 2] 1734         ldaa    #0x10
   8D19 97 14         [ 3] 1735         staa    (0x0014)
   8D1B                    1736 L8D1B:
   8D1B BD 8C BD      [ 6] 1737         jsr     L8CBD        ; wait for LCD not busy
   8D1E 86 20         [ 2] 1738         ldaa    #0x20
   8D20 BD 8C 98      [ 6] 1739         jsr     L8C98
   8D23 7A 00 14      [ 6] 1740         dec     (0x0014)
   8D26 26 F3         [ 3] 1741         bne     L8D1B  
   8D28 39            [ 5] 1742         rts
                           1743 
   8D29                    1744 L8D29:
   8D29 86 0C         [ 2] 1745         ldaa    #0x0C
   8D2B BD 8E 4B      [ 6] 1746         jsr     L8E4B
   8D2E 39            [ 5] 1747         rts
                           1748 
                           1749 ; Unused?
   8D2F                    1750 L8D2F:
   8D2F 86 0E         [ 2] 1751         ldaa    #0x0E
   8D31 BD 8E 4B      [ 6] 1752         jsr     L8E4B
   8D34 39            [ 5] 1753         rts
                           1754 
   8D35                    1755 L8D35:
   8D35 7F 00 4A      [ 6] 1756         clr     (0x004A)
   8D38 7F 00 43      [ 6] 1757         clr     (0x0043)
   8D3B 18 DE 46      [ 5] 1758         ldy     (0x0046)
   8D3E 86 C0         [ 2] 1759         ldaa    #0xC0
   8D40 20 0B         [ 3] 1760         bra     L8D4D
                           1761 
   8D42                    1762 L8D42:
   8D42 7F 00 4A      [ 6] 1763         clr     (0x004A)
   8D45 7F 00 43      [ 6] 1764         clr     (0x0043)
   8D48 18 DE 46      [ 5] 1765         ldy     (0x0046)
   8D4B 86 80         [ 2] 1766         ldaa    #0x80
   8D4D                    1767 L8D4D:
   8D4D 18 A7 00      [ 5] 1768         staa    0,Y     
   8D50 18 6F 01      [ 7] 1769         clr     1,Y     
   8D53 18 08         [ 4] 1770         iny
   8D55 18 08         [ 4] 1771         iny
   8D57 18 8C 05 80   [ 5] 1772         cpy     #0x0580
   8D5B 25 04         [ 3] 1773         bcs     L8D61  
   8D5D 18 CE 05 00   [ 4] 1774         ldy     #0x0500
   8D61                    1775 L8D61:
   8D61 C6 0F         [ 2] 1776         ldab    #0x0F
   8D63                    1777 L8D63:
   8D63 96 4A         [ 3] 1778         ldaa    (0x004A)
   8D65 27 FC         [ 3] 1779         beq     L8D63  
   8D67 7F 00 4A      [ 6] 1780         clr     (0x004A)
   8D6A 5A            [ 2] 1781         decb
   8D6B 27 1A         [ 3] 1782         beq     L8D87  
   8D6D 81 24         [ 2] 1783         cmpa    #0x24
   8D6F 27 16         [ 3] 1784         beq     L8D87  
   8D71 18 6F 00      [ 7] 1785         clr     0,Y     
   8D74 18 A7 01      [ 5] 1786         staa    1,Y     
   8D77 18 08         [ 4] 1787         iny
   8D79 18 08         [ 4] 1788         iny
   8D7B 18 8C 05 80   [ 5] 1789         cpy     #0x0580
   8D7F 25 04         [ 3] 1790         bcs     L8D85  
   8D81 18 CE 05 00   [ 4] 1791         ldy     #0x0500
   8D85                    1792 L8D85:
   8D85 20 DC         [ 3] 1793         bra     L8D63  
   8D87                    1794 L8D87:
   8D87 5D            [ 2] 1795         tstb
   8D88 27 19         [ 3] 1796         beq     L8DA3  
   8D8A 86 20         [ 2] 1797         ldaa    #0x20
   8D8C                    1798 L8D8C:
   8D8C 18 6F 00      [ 7] 1799         clr     0,Y     
   8D8F 18 A7 01      [ 5] 1800         staa    1,Y     
   8D92 18 08         [ 4] 1801         iny
   8D94 18 08         [ 4] 1802         iny
   8D96 18 8C 05 80   [ 5] 1803         cpy     #0x0580
   8D9A 25 04         [ 3] 1804         bcs     L8DA0  
   8D9C 18 CE 05 00   [ 4] 1805         ldy     #0x0500
   8DA0                    1806 L8DA0:
   8DA0 5A            [ 2] 1807         decb
   8DA1 26 E9         [ 3] 1808         bne     L8D8C  
   8DA3                    1809 L8DA3:
   8DA3 18 6F 00      [ 7] 1810         clr     0,Y     
   8DA6 18 6F 01      [ 7] 1811         clr     1,Y     
   8DA9 18 DF 46      [ 5] 1812         sty     (0x0046)
   8DAC 96 19         [ 3] 1813         ldaa    (0x0019)
   8DAE 97 4E         [ 3] 1814         staa    (0x004E)
   8DB0 86 01         [ 2] 1815         ldaa    #0x01
   8DB2 97 43         [ 3] 1816         staa    (0x0043)
   8DB4 39            [ 5] 1817         rts
                           1818 
                           1819 ; display ASCII in B at location
   8DB5                    1820 L8DB5:
   8DB5 36            [ 3] 1821         psha
   8DB6 37            [ 3] 1822         pshb
   8DB7 C1 4F         [ 2] 1823         cmpb    #0x4F
   8DB9 22 13         [ 3] 1824         bhi     L8DCE  
   8DBB C1 28         [ 2] 1825         cmpb    #0x28
   8DBD 25 03         [ 3] 1826         bcs     L8DC2  
   8DBF 0C            [ 2] 1827         clc
   8DC0 C9 18         [ 2] 1828         adcb    #0x18
   8DC2                    1829 L8DC2:
   8DC2 0C            [ 2] 1830         clc
   8DC3 C9 80         [ 2] 1831         adcb    #0x80
   8DC5 17            [ 2] 1832         tba
   8DC6 BD 8E 4B      [ 6] 1833         jsr     L8E4B        ; send lcd command
   8DC9 33            [ 4] 1834         pulb
   8DCA 32            [ 4] 1835         pula
   8DCB BD 8E 70      [ 6] 1836         jsr     L8E70        ; send lcd char
   8DCE                    1837 L8DCE:
   8DCE 39            [ 5] 1838         rts
                           1839 
                           1840 ; 4 routines to write to the LCD display
                           1841 
                           1842 ; Write to the LCD 1st line - extend past the end of a normal display
   8DCF                    1843 LCDMSG1A:
   8DCF 18 DE 46      [ 5] 1844         ldy     (0x0046)     ; get buffer pointer
   8DD2 86 90         [ 2] 1845         ldaa    #0x90        ; command to set LCD RAM ptr to chr 0x10
   8DD4 20 13         [ 3] 1846         bra     L8DE9  
                           1847 
                           1848 ; Write to the LCD 2st line - extend past the end of a normal display
   8DD6                    1849 LCDMSG2A:
   8DD6 18 DE 46      [ 5] 1850         ldy     (0x0046)     ; get buffer pointer
   8DD9 86 D0         [ 2] 1851         ldaa    #0xD0        ; command to set LCD RAM ptr to chr 0x50
   8DDB 20 0C         [ 3] 1852         bra     L8DE9  
                           1853 
                           1854 ; Write to the LCD 2nd line
   8DDD                    1855 LCDMSG2:
   8DDD 18 DE 46      [ 5] 1856         ldy     (0x0046)     ; get buffer pointer
   8DE0 86 C0         [ 2] 1857         ldaa    #0xC0        ; command to set LCD RAM ptr to chr 0x40
   8DE2 20 05         [ 3] 1858         bra     L8DE9  
                           1859 
                           1860 ; Write to the LCD 1st line
   8DE4                    1861 LCDMSG1:
   8DE4 18 DE 46      [ 5] 1862         ldy     (0x0046)     ; get buffer pointer
   8DE7 86 80         [ 2] 1863         ldaa    #0x80        ; command to load LCD RAM ptr to chr 0x00
                           1864 
                           1865 ; Put LCD command into a buffer, 4 bytes for each entry?
   8DE9                    1866 L8DE9:
   8DE9 18 A7 00      [ 5] 1867         staa    0,Y         ; store command here
   8DEC 18 6F 01      [ 7] 1868         clr     1,Y         ; clear next byte
   8DEF 18 08         [ 4] 1869         iny
   8DF1 18 08         [ 4] 1870         iny
                           1871 
                           1872 ; Add characters at return address to LCD buffer
   8DF3 18 8C 05 80   [ 5] 1873         cpy     #0x0580       ; check for buffer overflow
   8DF7 25 04         [ 3] 1874         bcs     L8DFD  
   8DF9 18 CE 05 00   [ 4] 1875         ldy     #0x0500
   8DFD                    1876 L8DFD:
   8DFD 38            [ 5] 1877         pulx                ; get start of data
   8DFE DF 17         [ 4] 1878         stx     (0x0017)    ; save this here
   8E00                    1879 L8E00:
   8E00 A6 00         [ 4] 1880         ldaa    0,X         ; get character
   8E02 27 36         [ 3] 1881         beq     L8E3A       ; is it 00, if so jump ahead
   8E04 2B 17         [ 3] 1882         bmi     L8E1D       ; high bit set, if so jump ahead
   8E06 18 6F 00      [ 7] 1883         clr     0,Y         ; add character
   8E09 18 A7 01      [ 5] 1884         staa    1,Y     
   8E0C 08            [ 3] 1885         inx
   8E0D 18 08         [ 4] 1886         iny
   8E0F 18 08         [ 4] 1887         iny
   8E11 18 8C 05 80   [ 5] 1888         cpy     #0x0580     ; check for buffer overflow
   8E15 25 E9         [ 3] 1889         bcs     L8E00  
   8E17 18 CE 05 00   [ 4] 1890         ldy     #0x0500
   8E1B 20 E3         [ 3] 1891         bra     L8E00  
                           1892 
   8E1D                    1893 L8E1D:
   8E1D 84 7F         [ 2] 1894         anda    #0x7F
   8E1F 18 6F 00      [ 7] 1895         clr     0,Y          ; add character
   8E22 18 A7 01      [ 5] 1896         staa    1,Y     
   8E25 18 6F 02      [ 7] 1897         clr     2,Y     
   8E28 18 6F 03      [ 7] 1898         clr     3,Y     
   8E2B 08            [ 3] 1899         inx
   8E2C 18 08         [ 4] 1900         iny
   8E2E 18 08         [ 4] 1901         iny
   8E30 18 8C 05 80   [ 5] 1902         cpy     #0x0580       ; check for overflow
   8E34 25 04         [ 3] 1903         bcs     L8E3A  
   8E36 18 CE 05 00   [ 4] 1904         ldy     #0x0500
                           1905 
   8E3A                    1906 L8E3A:
   8E3A 3C            [ 4] 1907         pshx                ; put SP back
   8E3B 86 01         [ 2] 1908         ldaa    #0x01
   8E3D 97 43         [ 3] 1909         staa    (0x0043)    ; semaphore?
   8E3F DC 46         [ 4] 1910         ldd     (0x0046)
   8E41 18 6F 00      [ 7] 1911         clr     0,Y     
   8E44 18 6F 01      [ 7] 1912         clr     1,Y     
   8E47 18 DF 46      [ 5] 1913         sty     (0x0046)     ; save buffer pointer
   8E4A 39            [ 5] 1914         rts
                           1915 
                           1916 ; buffer LCD command?
   8E4B                    1917 L8E4B:
   8E4B 18 DE 46      [ 5] 1918         ldy     (0x0046)
   8E4E 18 A7 00      [ 5] 1919         staa    0,Y     
   8E51 18 6F 01      [ 7] 1920         clr     1,Y     
   8E54 18 08         [ 4] 1921         iny
   8E56 18 08         [ 4] 1922         iny
   8E58 18 8C 05 80   [ 5] 1923         cpy     #0x0580
   8E5C 25 04         [ 3] 1924         bcs     L8E62  
   8E5E 18 CE 05 00   [ 4] 1925         ldy     #0x0500
   8E62                    1926 L8E62:
   8E62 18 6F 00      [ 7] 1927         clr     0,Y     
   8E65 18 6F 01      [ 7] 1928         clr     1,Y     
   8E68 86 01         [ 2] 1929         ldaa    #0x01
   8E6A 97 43         [ 3] 1930         staa    (0x0043)
   8E6C 18 DF 46      [ 5] 1931         sty     (0x0046)
   8E6F 39            [ 5] 1932         rts
                           1933 
   8E70                    1934 L8E70:
   8E70 18 DE 46      [ 5] 1935         ldy     (0x0046)
   8E73 18 6F 00      [ 7] 1936         clr     0,Y     
   8E76 18 A7 01      [ 5] 1937         staa    1,Y     
   8E79 18 08         [ 4] 1938         iny
   8E7B 18 08         [ 4] 1939         iny
   8E7D 18 8C 05 80   [ 5] 1940         cpy     #0x0580
   8E81 25 04         [ 3] 1941         bcs     L8E87  
   8E83 18 CE 05 00   [ 4] 1942         ldy     #0x0500
   8E87                    1943 L8E87:
   8E87 18 6F 00      [ 7] 1944         clr     0,Y     
   8E8A 18 6F 01      [ 7] 1945         clr     1,Y     
   8E8D 86 01         [ 2] 1946         ldaa    #0x01
   8E8F 97 43         [ 3] 1947         staa    (0x0043)
   8E91 18 DF 46      [ 5] 1948         sty     (0x0046)
   8E94 39            [ 5] 1949         rts
                           1950 
   8E95                    1951 L8E95:
   8E95 96 30         [ 3] 1952         ldaa    (0x0030)
   8E97 26 09         [ 3] 1953         bne     L8EA2  
   8E99 96 31         [ 3] 1954         ldaa    (0x0031)
   8E9B 26 11         [ 3] 1955         bne     L8EAE  
   8E9D 96 32         [ 3] 1956         ldaa    (0x0032)
   8E9F 26 19         [ 3] 1957         bne     L8EBA  
   8EA1 39            [ 5] 1958         rts
                           1959 
                           1960 ;;;;;;;;;;;;;;;;;;;;;;;;;;
                           1961 
   8EA2                    1962 L8EA2:
   8EA2 7F 00 30      [ 6] 1963         clr     (0x0030)
   8EA5 7F 00 32      [ 6] 1964         clr     (0x0032)
   8EA8 7F 00 31      [ 6] 1965         clr     (0x0031)
   8EAB 86 01         [ 2] 1966         ldaa    #0x01
   8EAD 39            [ 5] 1967         rts
                           1968 
   8EAE                    1969 L8EAE:
   8EAE 7F 00 31      [ 6] 1970         clr     (0x0031)
   8EB1 7F 00 30      [ 6] 1971         clr     (0x0030)
   8EB4 7F 00 32      [ 6] 1972         clr     (0x0032)
   8EB7 86 02         [ 2] 1973         ldaa    #0x02
   8EB9 39            [ 5] 1974         rts
                           1975 
   8EBA                    1976 L8EBA:
   8EBA 7F 00 32      [ 6] 1977         clr     (0x0032)
   8EBD 7F 00 30      [ 6] 1978         clr     (0x0030)
   8EC0 7F 00 31      [ 6] 1979         clr     (0x0031)
   8EC3 86 0D         [ 2] 1980         ldaa    #0x0D
   8EC5 39            [ 5] 1981         rts
                           1982 
   8EC6                    1983 L8EC6:
   8EC6 B6 18 04      [ 4] 1984         ldaa    PIA0PRA 
   8EC9 84 07         [ 2] 1985         anda    #0x07
   8ECB 97 2C         [ 3] 1986         staa    (0x002C)
   8ECD 78 00 2C      [ 6] 1987         asl     (0x002C)
   8ED0 78 00 2C      [ 6] 1988         asl     (0x002C)
   8ED3 78 00 2C      [ 6] 1989         asl     (0x002C)
   8ED6 78 00 2C      [ 6] 1990         asl     (0x002C)
   8ED9 78 00 2C      [ 6] 1991         asl     (0x002C)
   8EDC CE 00 00      [ 3] 1992         ldx     #0x0000
   8EDF                    1993 L8EDF:
   8EDF 8C 00 03      [ 4] 1994         cpx     #0x0003
   8EE2 27 24         [ 3] 1995         beq     L8F08  
   8EE4 78 00 2C      [ 6] 1996         asl     (0x002C)
   8EE7 25 12         [ 3] 1997         bcs     L8EFB  
   8EE9 A6 2D         [ 4] 1998         ldaa    0x2D,X
   8EEB 81 0F         [ 2] 1999         cmpa    #0x0F
   8EED 24 1A         [ 3] 2000         bcc     L8F09  
   8EEF 6C 2D         [ 6] 2001         inc     0x2D,X
   8EF1 A6 2D         [ 4] 2002         ldaa    0x2D,X
   8EF3 81 02         [ 2] 2003         cmpa    #0x02
   8EF5 26 02         [ 3] 2004         bne     L8EF9  
   8EF7 A7 30         [ 4] 2005         staa    0x30,X
   8EF9                    2006 L8EF9:
   8EF9 20 0A         [ 3] 2007         bra     L8F05  
   8EFB                    2008 L8EFB:
   8EFB 6F 2D         [ 6] 2009         clr     0x2D,X
   8EFD 20 06         [ 3] 2010         bra     L8F05  
   8EFF A6 2D         [ 4] 2011         ldaa    0x2D,X
   8F01 27 02         [ 3] 2012         beq     L8F05  
   8F03 6A 2D         [ 6] 2013         dec     0x2D,X
   8F05                    2014 L8F05:
   8F05 08            [ 3] 2015         inx
   8F06 20 D7         [ 3] 2016         bra     L8EDF  
   8F08                    2017 L8F08:
   8F08 39            [ 5] 2018         rts
                           2019 
   8F09                    2020 L8F09:
   8F09 8C 00 02      [ 4] 2021         cpx     #0x0002
   8F0C 27 02         [ 3] 2022         beq     L8F10  
   8F0E 6F 2D         [ 6] 2023         clr     0x2D,X
   8F10                    2024 L8F10:
   8F10 20 F3         [ 3] 2025         bra     L8F05
                           2026 
   8F12                    2027 L8F12:
   8F12 B6 10 0A      [ 4] 2028         ldaa    PORTE
   8F15 97 51         [ 3] 2029         staa    (0x0051)
   8F17 CE 00 00      [ 3] 2030         ldx     #0x0000
   8F1A                    2031 L8F1A:
   8F1A 8C 00 08      [ 4] 2032         cpx     #0x0008
   8F1D 27 22         [ 3] 2033         beq     L8F41  
   8F1F 77 00 51      [ 6] 2034         asr     (0x0051)
   8F22 25 10         [ 3] 2035         bcs     L8F34  
   8F24 A6 52         [ 4] 2036         ldaa    0x52,X
   8F26 81 0F         [ 2] 2037         cmpa    #0x0F
   8F28 6C 52         [ 6] 2038         inc     0x52,X
   8F2A A6 52         [ 4] 2039         ldaa    0x52,X
   8F2C 81 04         [ 2] 2040         cmpa    #0x04
   8F2E 26 02         [ 3] 2041         bne     L8F32  
   8F30 A7 5A         [ 4] 2042         staa    0x5A,X
   8F32                    2043 L8F32:
   8F32 20 0A         [ 3] 2044         bra     L8F3E  
   8F34                    2045 L8F34:
   8F34 6F 52         [ 6] 2046         clr     0x52,X
   8F36 20 06         [ 3] 2047         bra     L8F3E  
   8F38 A6 52         [ 4] 2048         ldaa    0x52,X
   8F3A 27 02         [ 3] 2049         beq     L8F3E  
   8F3C 6A 52         [ 6] 2050         dec     0x52,X
   8F3E                    2051 L8F3E:
   8F3E 08            [ 3] 2052         inx
   8F3F 20 D9         [ 3] 2053         bra     L8F1A  
   8F41                    2054 L8F41:
   8F41 39            [ 5] 2055         rts
                           2056 
   8F42 6F 52         [ 6] 2057         clr     0x52,X
   8F44 20 F8         [ 3] 2058         bra     L8F3E  
                           2059 
   8F46                    2060 L8F46:
   8F46 30 2E 35           2061         .ascii      '0.5'
   8F49 31 2E 30           2062         .ascii      '1.0'
   8F4C 31 2E 35           2063         .ascii      '1.5'
   8F4F 32 2E 30           2064         .ascii      '2.0'
   8F52 32 2E 35           2065         .ascii      '2.5'
   8F55 33 2E 30           2066         .ascii      '3.0'
                           2067 
   8F58                    2068 L8F58:
   8F58 3C            [ 4] 2069         pshx
   8F59 96 12         [ 3] 2070         ldaa    (0x0012)
   8F5B 80 01         [ 2] 2071         suba    #0x01
   8F5D C6 03         [ 2] 2072         ldab    #0x03
   8F5F 3D            [10] 2073         mul
   8F60 CE 8F 46      [ 3] 2074         ldx     #L8F46
   8F63 3A            [ 3] 2075         abx
   8F64 C6 2C         [ 2] 2076         ldab    #0x2C
   8F66                    2077 L8F66:
   8F66 A6 00         [ 4] 2078         ldaa    0,X     
   8F68 08            [ 3] 2079         inx
   8F69 BD 8D B5      [ 6] 2080         jsr     L8DB5         ; display char here on LCD display
   8F6C 5C            [ 2] 2081         incb
   8F6D C1 2F         [ 2] 2082         cmpb    #0x2F
   8F6F 26 F5         [ 3] 2083         bne     L8F66  
   8F71 38            [ 5] 2084         pulx
   8F72 39            [ 5] 2085         rts
                           2086 
   8F73                    2087 L8F73:
   8F73 36            [ 3] 2088         psha
   8F74 BD 8C F2      [ 6] 2089         jsr     L8CF2
   8F77 C6 02         [ 2] 2090         ldab    #0x02
   8F79 BD 8C 30      [ 6] 2091         jsr     DLYSECSBY2   
   8F7C 32            [ 4] 2092         pula
   8F7D 97 B4         [ 3] 2093         staa    (0x00B4)
   8F7F 81 03         [ 2] 2094         cmpa    #0x03
   8F81 26 11         [ 3] 2095         bne     L8F94  
                           2096 
   8F83 BD 8D E4      [ 6] 2097         jsr     LCDMSG1 
   8F86 43 68 75 63 6B 20  2098         .ascis  'Chuck    '
        20 20 A0
                           2099 
   8F8F CE 90 72      [ 3] 2100         ldx     #L9072
   8F92 20 4D         [ 3] 2101         bra     L8FE1  
   8F94                    2102 L8F94:
   8F94 81 04         [ 2] 2103         cmpa    #0x04
   8F96 26 11         [ 3] 2104         bne     L8FA9  
                           2105 
   8F98 BD 8D E4      [ 6] 2106         jsr     LCDMSG1 
   8F9B 4A 61 73 70 65 72  2107         .ascis  'Jasper   '
        20 20 A0
                           2108 
   8FA4 CE 90 DE      [ 3] 2109         ldx     #0x90DE
   8FA7 20 38         [ 3] 2110         bra     L8FE1  
   8FA9                    2111 L8FA9:
   8FA9 81 05         [ 2] 2112         cmpa    #0x05
   8FAB 26 11         [ 3] 2113         bne     L8FBE  
                           2114 
   8FAD BD 8D E4      [ 6] 2115         jsr     LCDMSG1 
   8FB0 50 61 73 71 75 61  2116         .ascis  'Pasqually'
        6C 6C F9
                           2117 
   8FB9 CE 91 45      [ 3] 2118         ldx     #0x9145
   8FBC 20 23         [ 3] 2119         bra     L8FE1  
   8FBE                    2120 L8FBE:
   8FBE 81 06         [ 2] 2121         cmpa    #0x06
   8FC0 26 11         [ 3] 2122         bne     L8FD3  
                           2123 
   8FC2 BD 8D E4      [ 6] 2124         jsr     LCDMSG1 
   8FC5 4D 75 6E 63 68 20  2125         .ascis  'Munch    '
        20 20 A0
                           2126 
   8FCE CE 91 BA      [ 3] 2127         ldx     #0x91BA
   8FD1 20 0E         [ 3] 2128         bra     L8FE1  
   8FD3                    2129 L8FD3:
   8FD3 BD 8D E4      [ 6] 2130         jsr     LCDMSG1 
   8FD6 48 65 6C 65 6E 20  2131         .ascis  'Helen   '
        20 A0
                           2132 
   8FDE CE 92 26      [ 3] 2133         ldx     #0x9226
   8FE1                    2134 L8FE1:
   8FE1 96 B4         [ 3] 2135         ldaa    (0x00B4)
   8FE3 80 03         [ 2] 2136         suba    #0x03
   8FE5 48            [ 2] 2137         asla
   8FE6 48            [ 2] 2138         asla
   8FE7 97 4B         [ 3] 2139         staa    (0x004B)
   8FE9 BD 95 04      [ 6] 2140         jsr     L9504
   8FEC 97 4C         [ 3] 2141         staa    (0x004C)
   8FEE 81 0F         [ 2] 2142         cmpa    #0x0F
   8FF0 26 01         [ 3] 2143         bne     L8FF3  
   8FF2 39            [ 5] 2144         rts
                           2145 
   8FF3                    2146 L8FF3:
   8FF3 81 08         [ 2] 2147         cmpa    #0x08
   8FF5 23 08         [ 3] 2148         bls     L8FFF  
   8FF7 80 08         [ 2] 2149         suba    #0x08
   8FF9 D6 4B         [ 3] 2150         ldab    (0x004B)
   8FFB CB 02         [ 2] 2151         addb    #0x02
   8FFD D7 4B         [ 3] 2152         stab    (0x004B)
   8FFF                    2153 L8FFF:
   8FFF 36            [ 3] 2154         psha
   9000 18 DE 46      [ 5] 2155         ldy     (0x0046)
   9003 32            [ 4] 2156         pula
   9004 5F            [ 2] 2157         clrb
   9005 0D            [ 2] 2158         sec
   9006                    2159 L9006:
   9006 59            [ 2] 2160         rolb
   9007 4A            [ 2] 2161         deca
   9008 26 FC         [ 3] 2162         bne     L9006  
   900A D7 50         [ 3] 2163         stab    (0x0050)
   900C D6 4B         [ 3] 2164         ldab    (0x004B)
   900E CE 10 80      [ 3] 2165         ldx     #0x1080
   9011 3A            [ 3] 2166         abx
   9012 86 02         [ 2] 2167         ldaa    #0x02
   9014 97 12         [ 3] 2168         staa    (0x0012)
   9016                    2169 L9016:
   9016 A6 00         [ 4] 2170         ldaa    0,X     
   9018 98 50         [ 3] 2171         eora    (0x0050)
   901A A7 00         [ 4] 2172         staa    0,X     
   901C 6D 00         [ 6] 2173         tst     0,X     
   901E 27 16         [ 3] 2174         beq     L9036  
   9020 86 4F         [ 2] 2175         ldaa    #0x4F            ;'O'
   9022 C6 0C         [ 2] 2176         ldab    #0x0C        
   9024 BD 8D B5      [ 6] 2177         jsr     L8DB5            ; display char here on LCD display
   9027 86 6E         [ 2] 2178         ldaa    #0x6E            ;'n'
   9029 C6 0D         [ 2] 2179         ldab    #0x0D
   902B BD 8D B5      [ 6] 2180         jsr     L8DB5            ; display char here on LCD display
   902E CC 20 0E      [ 3] 2181         ldd     #0x200E          ;' '
   9031 BD 8D B5      [ 6] 2182         jsr     L8DB5            ; display char here on LCD display
   9034 20 0E         [ 3] 2183         bra     L9044  
   9036                    2184 L9036:
   9036 86 66         [ 2] 2185         ldaa    #0x66            ;'f'
   9038 C6 0D         [ 2] 2186         ldab    #0x0D
   903A BD 8D B5      [ 6] 2187         jsr     L8DB5            ; display char here on LCD display
   903D 86 66         [ 2] 2188         ldaa    #0x66            ;'f'
   903F C6 0E         [ 2] 2189         ldab    #0x0E
   9041 BD 8D B5      [ 6] 2190         jsr     L8DB5            ; display char here on LCD display
   9044                    2191 L9044:
   9044 D6 12         [ 3] 2192         ldab    (0x0012)
   9046 BD 8C 30      [ 6] 2193         jsr     DLYSECSBY2            ; delay in half-seconds
   9049 BD 8E 95      [ 6] 2194         jsr     L8E95
   904C 81 0D         [ 2] 2195         cmpa    #0x0D
   904E 27 14         [ 3] 2196         beq     L9064  
   9050 20 C4         [ 3] 2197         bra     L9016  
   9052 81 02         [ 2] 2198         cmpa    #0x02
   9054 26 C0         [ 3] 2199         bne     L9016  
   9056 96 12         [ 3] 2200         ldaa    (0x0012)
   9058 81 06         [ 2] 2201         cmpa    #0x06
   905A 27 BA         [ 3] 2202         beq     L9016  
   905C 4C            [ 2] 2203         inca
   905D 97 12         [ 3] 2204         staa    (0x0012)
   905F BD 8F 58      [ 6] 2205         jsr     L8F58
   9062 20 B2         [ 3] 2206         bra     L9016  
   9064                    2207 L9064:
   9064 A6 00         [ 4] 2208         ldaa    0,X     
   9066 9A 50         [ 3] 2209         oraa    (0x0050)
   9068 98 50         [ 3] 2210         eora    (0x0050)
   906A A7 00         [ 4] 2211         staa    0,X     
   906C 96 B4         [ 3] 2212         ldaa    (0x00B4)
   906E 7E 8F 73      [ 3] 2213         jmp     L8F73
   9071 39            [ 5] 2214         rts
                           2215 
   9072                    2216 L9072:
   9072 4D 6F 75 74 68 2C  2217         .ascis  'Mouth,Head left,Head right,Head up,Eyes right,Eyelids,Right hand,Eyes left,DS9,DS10,DS11,DS12,DS13,DS14,Exit'
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
   90DE 4D 6F 75 74 68 2C  2218         .ascis  'Mouth,Head left,Head right,Head up,Eyes right,Eyelids,Hands,Eyes left,DS9,DS10,DS11,DS12,DS13,DS14,Exit'
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
   9145 4D 6F 75 74 68 2D  2219         .ascis  'Mouth-Mustache,Head left,Head right,Left arm,Eyes right,Eyelids,Right arm,Eyes left,DS9,DS10,DS11,DS12,DS13,DS14,Exit'
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
   91BA 4D 6F 75 74 68 2C  2220         .ascis  'Mouth,Head left,Head right,Left arm,Eyes right,Eyelids,Right arm,Eyes left,DS9,DS10,DS11,DS12,DS13,DS14,Exit'
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
   9226 4D 6F 75 74 68 2C  2221         .ascis  'Mouth,Head left,Head right,Head up,Eyes right,Eyelids,Right hand,Eyes left,DS9,DS10,DS11,DS12,DS13,DS14,Exit'
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
                           2222         
                           2223 ; code again
   9292                    2224 L9292:
   9292 BD 86 C4      [ 6] 2225         jsr     L86C4
   9295                    2226 L9295:
   9295 C6 01         [ 2] 2227         ldab    #0x01
   9297 BD 8C 30      [ 6] 2228         jsr     DLYSECSBY2           ; delay 0.5 sec
                           2229 
   929A BD 8D E4      [ 6] 2230         jsr     LCDMSG1 
   929D 20 20 44 69 61 67  2231         .ascis  '  Diagnostics   '
        6E 6F 73 74 69 63
        73 20 20 A0
                           2232 
   92AD BD 8D DD      [ 6] 2233         jsr     LCDMSG2 
   92B0 20 20 20 20 20 20  2234         .ascis  '                '
        20 20 20 20 20 20
        20 20 20 A0
                           2235 
   92C0 C6 01         [ 2] 2236         ldab    #0x01
   92C2 BD 8C 30      [ 6] 2237         jsr     DLYSECSBY2           ; delay 0.5 sec
   92C5 BD 8D 03      [ 6] 2238         jsr     L8D03
   92C8 CE 93 D3      [ 3] 2239         ldx     #L93D3
   92CB BD 95 04      [ 6] 2240         jsr     L9504
   92CE 81 11         [ 2] 2241         cmpa    #0x11
   92D0 26 14         [ 3] 2242         bne     L92E6
   92D2                    2243 L92D2:
   92D2 BD 86 C4      [ 6] 2244         jsr     L86C4
   92D5 5F            [ 2] 2245         clrb
   92D6 D7 62         [ 3] 2246         stab    (0x0062)
   92D8 BD F9 C5      [ 6] 2247         jsr     BUTNLIT 
   92DB B6 18 04      [ 4] 2248         ldaa    PIA0PRA 
   92DE 84 BF         [ 2] 2249         anda    #0xBF
   92E0 B7 18 04      [ 4] 2250         staa    PIA0PRA 
   92E3 7E 81 D7      [ 3] 2251         jmp     L81D7
   92E6                    2252 L92E6:
   92E6 81 03         [ 2] 2253         cmpa    #0x03
   92E8 25 09         [ 3] 2254         bcs     L92F3  
   92EA 81 08         [ 2] 2255         cmpa    #0x08
   92EC 24 05         [ 3] 2256         bcc     L92F3  
   92EE BD 8F 73      [ 6] 2257         jsr     L8F73
   92F1 20 A2         [ 3] 2258         bra     L9295  
   92F3                    2259 L92F3:
   92F3 81 02         [ 2] 2260         cmpa    #0x02
   92F5 26 08         [ 3] 2261         bne     L92FF  
   92F7 BD 9F 1E      [ 6] 2262         jsr     L9F1E
   92FA 25 99         [ 3] 2263         bcs     L9295  
   92FC 7E 96 75      [ 3] 2264         jmp     L9675
   92FF                    2265 L92FF:
   92FF 81 0B         [ 2] 2266         cmpa    #0x0B
   9301 26 0D         [ 3] 2267         bne     L9310  
   9303 BD 8D 03      [ 6] 2268         jsr     L8D03
   9306 BD 9E CC      [ 6] 2269         jsr     L9ECC
   9309 C6 03         [ 2] 2270         ldab    #0x03
   930B BD 8C 30      [ 6] 2271         jsr     DLYSECSBY2           ; delay 1.5 sec
   930E 20 85         [ 3] 2272         bra     L9295  
   9310                    2273 L9310:
   9310 81 09         [ 2] 2274         cmpa    #0x09
   9312 26 0E         [ 3] 2275         bne     L9322  
   9314 BD 9F 1E      [ 6] 2276         jsr     L9F1E
   9317 24 03         [ 3] 2277         bcc     L931C  
   9319 7E 92 95      [ 3] 2278         jmp     L9295
   931C                    2279 L931C:
   931C BD 9E 92      [ 6] 2280         jsr     L9E92               ; reset R counts
   931F 7E 92 95      [ 3] 2281         jmp     L9295
   9322                    2282 L9322:
   9322 81 0A         [ 2] 2283         cmpa    #0x0A
   9324 26 0B         [ 3] 2284         bne     L9331  
   9326 BD 9F 1E      [ 6] 2285         jsr     L9F1E
   9329 25 03         [ 3] 2286         bcs     L932E  
   932B BD 9E AF      [ 6] 2287         jsr     L9EAF               ; reset L counts
   932E                    2288 L932E:
   932E 7E 92 95      [ 3] 2289         jmp     L9295
   9331                    2290 L9331:
   9331 81 01         [ 2] 2291         cmpa    #0x01
   9333 26 03         [ 3] 2292         bne     L9338  
   9335 7E A0 E9      [ 3] 2293         jmp     LA0E9
   9338                    2294 L9338:
   9338 81 08         [ 2] 2295         cmpa    #0x08
   933A 26 1F         [ 3] 2296         bne     L935B  
   933C BD 9F 1E      [ 6] 2297         jsr     L9F1E
   933F 25 1A         [ 3] 2298         bcs     L935B  
                           2299 
   9341 BD 8D E4      [ 6] 2300         jsr     LCDMSG1 
   9344 52 65 73 65 74 20  2301         .ascis  'Reset System!'
        53 79 73 74 65 6D
        A1
                           2302 
   9351 7E A2 49      [ 3] 2303         jmp     LA249
   9354 C6 02         [ 2] 2304         ldab    #0x02
   9356 BD 8C 30      [ 6] 2305         jsr     DLYSECSBY2           ; delay 1 sec
   9359 20 18         [ 3] 2306         bra     L9373  
   935B                    2307 L935B:
   935B 81 0C         [ 2] 2308         cmpa    #0x0C
   935D 26 14         [ 3] 2309         bne     L9373  
   935F BD 8B 48      [ 6] 2310         jsr     L8B48
   9362 5F            [ 2] 2311         clrb
   9363 D7 62         [ 3] 2312         stab    (0x0062)
   9365 BD F9 C5      [ 6] 2313         jsr     BUTNLIT 
   9368 B6 18 04      [ 4] 2314         ldaa    PIA0PRA 
   936B 84 BF         [ 2] 2315         anda    #0xBF
   936D B7 18 04      [ 4] 2316         staa    PIA0PRA 
   9370 7E 92 92      [ 3] 2317         jmp     L9292
   9373                    2318 L9373:
   9373 81 0D         [ 2] 2319         cmpa    #0x0D
   9375 26 2E         [ 3] 2320         bne     L93A5  
   9377 BD 8C E9      [ 6] 2321         jsr     L8CE9
                           2322 
   937A BD 8D E4      [ 6] 2323         jsr     LCDMSG1 
   937D 20 20 42 75 74 74  2324         .ascis  '  Button  test'
        6F 6E 20 20 74 65
        73 F4
                           2325 
   938B BD 8D DD      [ 6] 2326         jsr     LCDMSG2 
   938E 20 20 20 50 52 4F  2327         .ascis  '   PROG exits'
        47 20 65 78 69 74
        F3
                           2328 
   939B BD A5 26      [ 6] 2329         jsr     LA526
   939E 5F            [ 2] 2330         clrb
   939F BD F9 C5      [ 6] 2331         jsr     BUTNLIT 
   93A2 7E 92 95      [ 3] 2332         jmp     L9295
   93A5                    2333 L93A5:
   93A5 81 0E         [ 2] 2334         cmpa    #0x0E
   93A7 26 10         [ 3] 2335         bne     L93B9  
   93A9 BD 9F 1E      [ 6] 2336         jsr     L9F1E
   93AC 24 03         [ 3] 2337         bcc     L93B1  
   93AE 7E 92 95      [ 3] 2338         jmp     L9295
   93B1                    2339 L93B1:
   93B1 C6 01         [ 2] 2340         ldab    #0x01
   93B3 BD 8C 30      [ 6] 2341         jsr     DLYSECSBY2           ; delay 0.5 sec
   93B6 7E 94 9A      [ 3] 2342         jmp     L949A
   93B9                    2343 L93B9:
   93B9 81 0F         [ 2] 2344         cmpa    #0x0F
   93BB 26 06         [ 3] 2345         bne     L93C3  
   93BD BD A8 6A      [ 6] 2346         jsr     LA86A
   93C0 7E 92 95      [ 3] 2347         jmp     L9295
   93C3                    2348 L93C3:
   93C3 81 10         [ 2] 2349         cmpa    #0x10
   93C5 26 09         [ 3] 2350         bne     L93D0  
   93C7 BD 9F 1E      [ 6] 2351         jsr     L9F1E
   93CA BD 95 BA      [ 6] 2352         jsr     L95BA
   93CD 7E 92 95      [ 3] 2353         jmp     L9295
                           2354 
   93D0                    2355 L93D0:
   93D0 7E 92 D2      [ 3] 2356         jmp     L92D2
                           2357 
   93D3                    2358 L93D3:
   93D3 56 43 52 20 61 64  2359         .ascis  "VCR adjust,Set Random,Chuck E. Cheese,Jasper,Pasqually,Munch,Helen,Reset System,Reset reg tape#,Reset liv tape#,View Tape #'s,All Lights On,Button test,King enable,Warm-Up,Show Type,Quit Diagnostics"
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
   9499 00                 2360         .byte   0x00
                           2361 
   949A                    2362 L949A:
   949A 7D 04 2A      [ 6] 2363         tst     (0x042A)
   949D 27 27         [ 3] 2364         beq     L94C6  
                           2365 
   949F BD 8D E4      [ 6] 2366         jsr     LCDMSG1 
   94A2 4B 69 6E 67 20 69  2367         .ascis  'King is Enabled'
        73 20 45 6E 61 62
        6C 65 E4
                           2368 
   94B1 BD 8D DD      [ 6] 2369         jsr     LCDMSG2 
   94B4 45 4E 54 45 52 20  2370         .ascis  'ENTER to disable'
        74 6F 20 64 69 73
        61 62 6C E5
                           2371 
   94C4 20 25         [ 3] 2372         bra     L94EB  
                           2373 
   94C6                    2374 L94C6:
   94C6 BD 8D E4      [ 6] 2375         jsr     LCDMSG1 
   94C9 4B 69 6E 67 20 69  2376         .ascis  'King is Disabled'
        73 20 44 69 73 61
        62 6C 65 E4
                           2377 
   94D9 BD 8D DD      [ 6] 2378         jsr     LCDMSG2 
   94DC 45 4E 54 45 52 20  2379         .ascis  'ENTER to enable'
        74 6F 20 65 6E 61
        62 6C E5
                           2380 
   94EB                    2381 L94EB:
   94EB BD 8E 95      [ 6] 2382         jsr     L8E95
   94EE 4D            [ 2] 2383         tsta
   94EF 27 FA         [ 3] 2384         beq     L94EB  
   94F1 81 0D         [ 2] 2385         cmpa    #0x0D
   94F3 27 02         [ 3] 2386         beq     L94F7  
   94F5 20 0A         [ 3] 2387         bra     L9501  
   94F7                    2388 L94F7:
   94F7 B6 04 2A      [ 4] 2389         ldaa    (0x042A)
   94FA 84 01         [ 2] 2390         anda    #0x01
   94FC 88 01         [ 2] 2391         eora    #0x01
   94FE B7 04 2A      [ 4] 2392         staa    (0x042A)
   9501                    2393 L9501:
   9501 7E 92 95      [ 3] 2394         jmp     L9295
   9504                    2395 L9504:
   9504 86 01         [ 2] 2396         ldaa    #0x01
   9506 97 A6         [ 3] 2397         staa    (0x00A6)
   9508 97 A7         [ 3] 2398         staa    (0x00A7)
   950A DF 12         [ 4] 2399         stx     (0x0012)
   950C 20 09         [ 3] 2400         bra     L9517  
   950E 86 01         [ 2] 2401         ldaa    #0x01
   9510 97 A7         [ 3] 2402         staa    (0x00A7)
   9512 7F 00 A6      [ 6] 2403         clr     (0x00A6)
   9515 DF 12         [ 4] 2404         stx     (0x0012)
   9517                    2405 L9517:
   9517 7F 00 16      [ 6] 2406         clr     (0x0016)
   951A 18 DE 46      [ 5] 2407         ldy     (0x0046)
   951D 7D 00 A6      [ 6] 2408         tst     (0x00A6)
   9520 26 07         [ 3] 2409         bne     L9529  
   9522 BD 8C F2      [ 6] 2410         jsr     L8CF2
   9525 86 80         [ 2] 2411         ldaa    #0x80
   9527 20 05         [ 3] 2412         bra     L952E  
   9529                    2413 L9529:
   9529 BD 8D 03      [ 6] 2414         jsr     L8D03
   952C 86 C0         [ 2] 2415         ldaa    #0xC0
   952E                    2416 L952E:
   952E 18 A7 00      [ 5] 2417         staa    0,Y     
   9531 18 6F 01      [ 7] 2418         clr     1,Y     
   9534 18 08         [ 4] 2419         iny
   9536 18 08         [ 4] 2420         iny
   9538 18 8C 05 80   [ 5] 2421         cpy     #0x0580
   953C 25 04         [ 3] 2422         bcs     L9542  
   953E 18 CE 05 00   [ 4] 2423         ldy     #0x0500
   9542                    2424 L9542:
   9542 DF 14         [ 4] 2425         stx     (0x0014)
   9544                    2426 L9544:
   9544 A6 00         [ 4] 2427         ldaa    0,X     
   9546 2A 04         [ 3] 2428         bpl     L954C  
   9548 C6 01         [ 2] 2429         ldab    #0x01
   954A D7 16         [ 3] 2430         stab    (0x0016)
   954C                    2431 L954C:
   954C 81 2C         [ 2] 2432         cmpa    #0x2C
   954E 27 1E         [ 3] 2433         beq     L956E  
   9550 18 6F 00      [ 7] 2434         clr     0,Y     
   9553 84 7F         [ 2] 2435         anda    #0x7F
   9555 18 A7 01      [ 5] 2436         staa    1,Y     
   9558 18 08         [ 4] 2437         iny
   955A 18 08         [ 4] 2438         iny
   955C 18 8C 05 80   [ 5] 2439         cpy     #0x0580
   9560 25 04         [ 3] 2440         bcs     L9566  
   9562 18 CE 05 00   [ 4] 2441         ldy     #0x0500
   9566                    2442 L9566:
   9566 7D 00 16      [ 6] 2443         tst     (0x0016)
   9569 26 03         [ 3] 2444         bne     L956E  
   956B 08            [ 3] 2445         inx
   956C 20 D6         [ 3] 2446         bra     L9544  
   956E                    2447 L956E:
   956E 08            [ 3] 2448         inx
   956F 86 01         [ 2] 2449         ldaa    #0x01
   9571 97 43         [ 3] 2450         staa    (0x0043)
   9573 18 6F 00      [ 7] 2451         clr     0,Y     
   9576 18 6F 01      [ 7] 2452         clr     1,Y     
   9579 18 DF 46      [ 5] 2453         sty     (0x0046)
   957C                    2454 L957C:
   957C BD 8E 95      [ 6] 2455         jsr     L8E95
   957F 27 FB         [ 3] 2456         beq     L957C  
   9581 81 02         [ 2] 2457         cmpa    #0x02
   9583 26 0A         [ 3] 2458         bne     L958F  
   9585 7D 00 16      [ 6] 2459         tst     (0x0016)
   9588 26 05         [ 3] 2460         bne     L958F  
   958A 7C 00 A7      [ 6] 2461         inc     (0x00A7)
   958D 20 88         [ 3] 2462         bra     L9517  
   958F                    2463 L958F:
   958F 81 01         [ 2] 2464         cmpa    #0x01
   9591 26 20         [ 3] 2465         bne     L95B3  
   9593 18 DE 14      [ 5] 2466         ldy     (0x0014)
   9596 18 9C 12      [ 6] 2467         cpy     (0x0012)
   9599 23 E1         [ 3] 2468         bls     L957C  
   959B 7A 00 A7      [ 6] 2469         dec     (0x00A7)
   959E DE 14         [ 4] 2470         ldx     (0x0014)
   95A0 09            [ 3] 2471         dex
   95A1                    2472 L95A1:
   95A1 09            [ 3] 2473         dex
   95A2 9C 12         [ 5] 2474         cpx     (0x0012)
   95A4 26 03         [ 3] 2475         bne     L95A9  
   95A6 7E 95 17      [ 3] 2476         jmp     L9517
   95A9                    2477 L95A9:
   95A9 A6 00         [ 4] 2478         ldaa    0,X     
   95AB 81 2C         [ 2] 2479         cmpa    #0x2C
   95AD 26 F2         [ 3] 2480         bne     L95A1  
   95AF 08            [ 3] 2481         inx
   95B0 7E 95 17      [ 3] 2482         jmp     L9517
   95B3                    2483 L95B3:
   95B3 81 0D         [ 2] 2484         cmpa    #0x0D
   95B5 26 C5         [ 3] 2485         bne     L957C  
   95B7 96 A7         [ 3] 2486         ldaa    (0x00A7)
   95B9 39            [ 5] 2487         rts
                           2488 
   95BA                    2489 L95BA:
   95BA B6 04 5C      [ 4] 2490         ldaa    (0x045C)
   95BD 27 14         [ 3] 2491         beq     L95D3  
                           2492 
   95BF BD 8D E4      [ 6] 2493         jsr     LCDMSG1 
   95C2 43 75 72 72 65 6E  2494         .ascis  'Current: CNR   '
        74 3A 20 43 4E 52
        20 20 A0
                           2495 
   95D1 20 12         [ 3] 2496         bra     L95E5  
                           2497 
   95D3                    2498 L95D3:
   95D3 BD 8D E4      [ 6] 2499         jsr     LCDMSG1 
   95D6 43 75 72 72 65 6E  2500         .ascis  'Current: R12   '
        74 3A 20 52 31 32
        20 20 A0
                           2501 
   95E5                    2502 L95E5:
   95E5 BD 8D DD      [ 6] 2503         jsr     LCDMSG2 
   95E8 3C 45 6E 74 65 72  2504         .ascis  '<Enter> to chg.'
        3E 20 74 6F 20 63
        68 67 AE
                           2505 
   95F7                    2506 L95F7:
   95F7 BD 8E 95      [ 6] 2507         jsr     L8E95
   95FA 27 FB         [ 3] 2508         beq     L95F7  
   95FC 81 0D         [ 2] 2509         cmpa    #0x0D
   95FE 26 0F         [ 3] 2510         bne     L960F  
   9600 B6 04 5C      [ 4] 2511         ldaa    (0x045C)
   9603 27 05         [ 3] 2512         beq     L960A  
   9605 7F 04 5C      [ 6] 2513         clr     (0x045C)
   9608 20 05         [ 3] 2514         bra     L960F  
   960A                    2515 L960A:
   960A 86 01         [ 2] 2516         ldaa    #0x01
   960C B7 04 5C      [ 4] 2517         staa    (0x045C)
   960F                    2518 L960F:
   960F 39            [ 5] 2519         rts
                           2520 
   9610                    2521 L9610:
   9610 43 68 75 63 6B 2C  2522         .ascis  "Chuck,Jasper,Pasqually,Munch,Helen,Light 1,Light 2,Light 3,Star EFX,Wink Spot,Gobo,Clear All Rnd,Exit"
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
                           2523 
   9675                    2524 L9675:
   9675 BD 8D E4      [ 6] 2525         jsr     LCDMSG1 
   9678 52 61 6E 64 6F 6D  2526         .ascis  'Random          '
        20 20 20 20 20 20
        20 20 20 A0
                           2527 
   9688 CE 96 10      [ 3] 2528         ldx     #L9610
   968B BD 95 04      [ 6] 2529         jsr     L9504
   968E 5F            [ 2] 2530         clrb
   968F 37            [ 3] 2531         pshb
   9690 81 0D         [ 2] 2532         cmpa    #0x0D
   9692 26 03         [ 3] 2533         bne     L9697  
   9694 7E 97 5B      [ 3] 2534         jmp     L975B
   9697                    2535 L9697:
   9697 81 0C         [ 2] 2536         cmpa    #0x0C
   9699 26 21         [ 3] 2537         bne     L96BC  
   969B 7F 04 01      [ 6] 2538         clr     (0x0401)
   969E 7F 04 2B      [ 6] 2539         clr     (0x042B)
                           2540 
   96A1 BD 8D E4      [ 6] 2541         jsr     LCDMSG1 
   96A4 41 6C 6C 20 52 6E  2542         .ascis  'All Rnd Cleared!'
        64 20 43 6C 65 61
        72 65 64 A1
                           2543 
   96B4 C6 64         [ 2] 2544         ldab    #0x64       ; delay 1 sec
   96B6 BD 8C 22      [ 6] 2545         jsr     DLYSECSBY100
   96B9 7E 97 5B      [ 3] 2546         jmp     L975B
   96BC                    2547 L96BC:
   96BC 81 09         [ 2] 2548         cmpa    #0x09
   96BE 25 05         [ 3] 2549         bcs     L96C5  
   96C0 80 08         [ 2] 2550         suba    #0x08
   96C2 33            [ 4] 2551         pulb
   96C3 5C            [ 2] 2552         incb
   96C4 37            [ 3] 2553         pshb
   96C5                    2554 L96C5:
   96C5 5F            [ 2] 2555         clrb
   96C6 0D            [ 2] 2556         sec
   96C7                    2557 L96C7:
   96C7 59            [ 2] 2558         rolb
   96C8 4A            [ 2] 2559         deca
   96C9 26 FC         [ 3] 2560         bne     L96C7  
   96CB D7 12         [ 3] 2561         stab    (0x0012)
   96CD C8 FF         [ 2] 2562         eorb    #0xFF
   96CF D7 13         [ 3] 2563         stab    (0x0013)
   96D1                    2564 L96D1:
   96D1 CC 20 34      [ 3] 2565         ldd     #0x2034           ;' '
   96D4 BD 8D B5      [ 6] 2566         jsr     L8DB5            ; display char here on LCD display
   96D7 33            [ 4] 2567         pulb
   96D8 37            [ 3] 2568         pshb
   96D9 5D            [ 2] 2569         tstb
   96DA 27 05         [ 3] 2570         beq     L96E1  
   96DC B6 04 2B      [ 4] 2571         ldaa    (0x042B)
   96DF 20 03         [ 3] 2572         bra     L96E4  
   96E1                    2573 L96E1:
   96E1 B6 04 01      [ 4] 2574         ldaa    (0x0401)
   96E4                    2575 L96E4:
   96E4 94 12         [ 3] 2576         anda    (0x0012)
   96E6 27 0A         [ 3] 2577         beq     L96F2  
   96E8 18 DE 46      [ 5] 2578         ldy     (0x0046)
   96EB BD 8D FD      [ 6] 2579         jsr     L8DFD
   96EE 4F            [ 2] 2580         clra
   96EF EE 20         [ 5] 2581         ldx     0x20,X
   96F1 09            [ 3] 2582         dex
   96F2                    2583 L96F2:
   96F2 18 DE 46      [ 5] 2584         ldy     (0x0046)
   96F5 BD 8D FD      [ 6] 2585         jsr     L8DFD
   96F8 4F            [ 2] 2586         clra
   96F9 66 E6         [ 6] 2587         ror     0xE6,X
   96FB CC 20 34      [ 3] 2588         ldd     #0x2034           ;' '
   96FE BD 8D B5      [ 6] 2589         jsr     L8DB5            ; display char here on LCD display
   9701                    2590 L9701:
   9701 BD 8E 95      [ 6] 2591         jsr     L8E95
   9704 27 FB         [ 3] 2592         beq     L9701  
   9706 81 01         [ 2] 2593         cmpa    #0x01
   9708 26 22         [ 3] 2594         bne     L972C  
   970A 33            [ 4] 2595         pulb
   970B 37            [ 3] 2596         pshb
   970C 5D            [ 2] 2597         tstb
   970D 27 0A         [ 3] 2598         beq     L9719  
   970F B6 04 2B      [ 4] 2599         ldaa    (0x042B)
   9712 9A 12         [ 3] 2600         oraa    (0x0012)
   9714 B7 04 2B      [ 4] 2601         staa    (0x042B)
   9717 20 08         [ 3] 2602         bra     L9721  
   9719                    2603 L9719:
   9719 B6 04 01      [ 4] 2604         ldaa    (0x0401)
   971C 9A 12         [ 3] 2605         oraa    (0x0012)
   971E B7 04 01      [ 4] 2606         staa    (0x0401)
   9721                    2607 L9721:
   9721 18 DE 46      [ 5] 2608         ldy     (0x0046)
   9724 BD 8D FD      [ 6] 2609         jsr     L8DFD
   9727 4F            [ 2] 2610         clra
   9728 6E A0         [ 3] 2611         jmp     0xA0,X
   972A 20 A5         [ 3] 2612         bra     L96D1  
   972C                    2613 L972C:
   972C 81 02         [ 2] 2614         cmpa    #0x02
   972E 26 23         [ 3] 2615         bne     L9753  
   9730 33            [ 4] 2616         pulb
   9731 37            [ 3] 2617         pshb
   9732 5D            [ 2] 2618         tstb
   9733 27 0A         [ 3] 2619         beq     L973F  
   9735 B6 04 2B      [ 4] 2620         ldaa    (0x042B)
   9738 94 13         [ 3] 2621         anda    (0x0013)
   973A B7 04 2B      [ 4] 2622         staa    (0x042B)
   973D 20 08         [ 3] 2623         bra     L9747  
   973F                    2624 L973F:
   973F B6 04 01      [ 4] 2625         ldaa    (0x0401)
   9742 94 13         [ 3] 2626         anda    (0x0013)
   9744 B7 04 01      [ 4] 2627         staa    (0x0401)
   9747                    2628 L9747:
   9747 18 DE 46      [ 5] 2629         ldy     (0x0046)
   974A BD 8D FD      [ 6] 2630         jsr     L8DFD
   974D 4F            [ 2] 2631         clra
   974E 66 E6         [ 6] 2632         ror     0xE6,X
   9750 7E 96 D1      [ 3] 2633         jmp     L96D1
   9753                    2634 L9753:
   9753 81 0D         [ 2] 2635         cmpa    #0x0D
   9755 26 AA         [ 3] 2636         bne     L9701  
   9757 33            [ 4] 2637         pulb
   9758 7E 96 75      [ 3] 2638         jmp     L9675
   975B                    2639 L975B:
   975B 33            [ 4] 2640         pulb
   975C 7E 92 92      [ 3] 2641         jmp     L9292
                           2642 
                           2643 ; do program rom checksum, and display it on the LCD screen
   975F                    2644 L975F:
   975F CE 00 00      [ 3] 2645         ldx     #0x0000
   9762 18 CE 80 00   [ 4] 2646         ldy     #0x8000
   9766                    2647 L9766:
   9766 18 E6 00      [ 5] 2648         ldab    0,Y     
   9769 18 08         [ 4] 2649         iny
   976B 3A            [ 3] 2650         abx
   976C 18 8C 00 00   [ 5] 2651         cpy     #0x0000
   9770 26 F4         [ 3] 2652         bne     L9766  
   9772 DF 17         [ 4] 2653         stx     (0x0017)        ; store rom checksum here
   9774 96 17         [ 3] 2654         ldaa    (0x0017)        ; get high byte of checksum
   9776 BD 97 9B      [ 6] 2655         jsr     L979B           ; convert it to 2 hex chars
   9779 96 12         [ 3] 2656         ldaa    (0x0012)
   977B C6 33         [ 2] 2657         ldab    #0x33
   977D BD 8D B5      [ 6] 2658         jsr     L8DB5           ; display char 1 here on LCD display
   9780 96 13         [ 3] 2659         ldaa    (0x0013)
   9782 C6 34         [ 2] 2660         ldab    #0x34
   9784 BD 8D B5      [ 6] 2661         jsr     L8DB5           ; display char 2 here on LCD display
   9787 96 18         [ 3] 2662         ldaa    (0x0018)        ; get low byte of checksum
   9789 BD 97 9B      [ 6] 2663         jsr     L979B           ; convert it to 2 hex chars
   978C 96 12         [ 3] 2664         ldaa    (0x0012)
   978E C6 35         [ 2] 2665         ldab    #0x35
   9790 BD 8D B5      [ 6] 2666         jsr     L8DB5           ; display char 1 here on LCD display
   9793 96 13         [ 3] 2667         ldaa    (0x0013)
   9795 C6 36         [ 2] 2668         ldab    #0x36
   9797 BD 8D B5      [ 6] 2669         jsr     L8DB5           ; display char 2 here on LCD display
   979A 39            [ 5] 2670         rts
                           2671 
                           2672 ; convert A to ASCII hex digit, store in (0x0012:0x0013)
   979B                    2673 L979B:
   979B 36            [ 3] 2674         psha
   979C 84 0F         [ 2] 2675         anda    #0x0F
   979E 8B 30         [ 2] 2676         adda    #0x30
   97A0 81 39         [ 2] 2677         cmpa    #0x39
   97A2 23 02         [ 3] 2678         bls     L97A6  
   97A4 8B 07         [ 2] 2679         adda    #0x07
   97A6                    2680 L97A6:
   97A6 97 13         [ 3] 2681         staa    (0x0013)
   97A8 32            [ 4] 2682         pula
   97A9 84 F0         [ 2] 2683         anda    #0xF0
   97AB 44            [ 2] 2684         lsra
   97AC 44            [ 2] 2685         lsra
   97AD 44            [ 2] 2686         lsra
   97AE 44            [ 2] 2687         lsra
   97AF 8B 30         [ 2] 2688         adda    #0x30
   97B1 81 39         [ 2] 2689         cmpa    #0x39
   97B3 23 02         [ 3] 2690         bls     L97B7  
   97B5 8B 07         [ 2] 2691         adda    #0x07
   97B7                    2692 L97B7:
   97B7 97 12         [ 3] 2693         staa    (0x0012)
   97B9 39            [ 5] 2694         rts
                           2695 
   97BA                    2696 L97BA:
   97BA BD 9D 18      [ 6] 2697         jsr     L9D18
   97BD 24 03         [ 3] 2698         bcc     L97C2  
   97BF 7E 9A 7F      [ 3] 2699         jmp     L9A7F
   97C2                    2700 L97C2:
   97C2 7D 00 79      [ 6] 2701         tst     (0x0079)
   97C5 26 0B         [ 3] 2702         bne     L97D2  
   97C7 FC 04 10      [ 5] 2703         ldd     (0x0410)
   97CA C3 00 01      [ 4] 2704         addd    #0x0001
   97CD FD 04 10      [ 5] 2705         std     (0x0410)
   97D0 20 09         [ 3] 2706         bra     L97DB  
   97D2                    2707 L97D2:
   97D2 FC 04 12      [ 5] 2708         ldd     (0x0412)
   97D5 C3 00 01      [ 4] 2709         addd    #0x0001
   97D8 FD 04 12      [ 5] 2710         std     (0x0412)
   97DB                    2711 L97DB:
   97DB 86 78         [ 2] 2712         ldaa    #0x78
   97DD 97 63         [ 3] 2713         staa    (0x0063)
   97DF 97 64         [ 3] 2714         staa    (0x0064)
   97E1 BD A3 13      [ 6] 2715         jsr     LA313
   97E4 BD AA DB      [ 6] 2716         jsr     LAADB
   97E7 86 01         [ 2] 2717         ldaa    #0x01
   97E9 97 4E         [ 3] 2718         staa    (0x004E)
   97EB 97 76         [ 3] 2719         staa    (0x0076)
   97ED 7F 00 75      [ 6] 2720         clr     (0x0075)
   97F0 7F 00 77      [ 6] 2721         clr     (0x0077)
   97F3 BD 87 AE      [ 6] 2722         jsr     L87AE
   97F6 D6 7B         [ 3] 2723         ldab    (0x007B)
   97F8 CA 20         [ 2] 2724         orab    #0x20
   97FA C4 F7         [ 2] 2725         andb    #0xF7
   97FC BD 87 48      [ 6] 2726         jsr     L8748   
   97FF 7E 85 A4      [ 3] 2727         jmp     L85A4
   9802                    2728 L9802:
   9802 7F 00 76      [ 6] 2729         clr     (0x0076)
   9805 7F 00 75      [ 6] 2730         clr     (0x0075)
   9808 7F 00 77      [ 6] 2731         clr     (0x0077)
   980B 7F 00 4E      [ 6] 2732         clr     (0x004E)
   980E D6 7B         [ 3] 2733         ldab    (0x007B)
   9810 CA 0C         [ 2] 2734         orab    #0x0C
   9812 BD 87 48      [ 6] 2735         jsr     L8748
   9815                    2736 L9815:
   9815 BD A3 1E      [ 6] 2737         jsr     LA31E
   9818 BD 86 C4      [ 6] 2738         jsr     L86C4
   981B BD 9C 51      [ 6] 2739         jsr     L9C51
   981E BD 8E 95      [ 6] 2740         jsr     L8E95
   9821 7E 84 4D      [ 3] 2741         jmp     L844D
   9824                    2742 L9824:
   9824 BD 9C 51      [ 6] 2743         jsr     L9C51
   9827 7F 00 4E      [ 6] 2744         clr     (0x004E)
   982A D6 7B         [ 3] 2745         ldab    (0x007B)
   982C CA 24         [ 2] 2746         orab    #0x24
   982E C4 F7         [ 2] 2747         andb    #0xF7
   9830 BD 87 48      [ 6] 2748         jsr     L8748   
   9833 BD 87 AE      [ 6] 2749         jsr     L87AE
   9836 BD 8E 95      [ 6] 2750         jsr     L8E95
   9839 7E 84 4D      [ 3] 2751         jmp     L844D
   983C                    2752 L983C:
   983C 7F 00 78      [ 6] 2753         clr     (0x0078)
   983F B6 10 8A      [ 4] 2754         ldaa    (0x108A)
   9842 84 F9         [ 2] 2755         anda    #0xF9
   9844 B7 10 8A      [ 4] 2756         staa    (0x108A)
   9847 7D 00 AF      [ 6] 2757         tst     (0x00AF)
   984A 26 61         [ 3] 2758         bne     L98AD  
   984C 96 62         [ 3] 2759         ldaa    (0x0062)
   984E 84 01         [ 2] 2760         anda    #0x01
   9850 27 5B         [ 3] 2761         beq     L98AD  
   9852 C6 FD         [ 2] 2762         ldab    #0xFD
   9854 BD 86 E7      [ 6] 2763         jsr     L86E7
   9857 CC 00 32      [ 3] 2764         ldd     #0x0032
   985A DD 1B         [ 4] 2765         std     CDTIMR1
   985C CC 75 30      [ 3] 2766         ldd     #0x7530
   985F DD 1D         [ 4] 2767         std     CDTIMR2
   9861 7F 00 5A      [ 6] 2768         clr     (0x005A)
   9864                    2769 L9864:
   9864 BD 9B 19      [ 6] 2770         jsr     L9B19   
   9867 7D 00 31      [ 6] 2771         tst     (0x0031)
   986A 26 04         [ 3] 2772         bne     L9870  
   986C 96 5A         [ 3] 2773         ldaa    (0x005A)
   986E 27 19         [ 3] 2774         beq     L9889  
   9870                    2775 L9870:
   9870 7F 00 31      [ 6] 2776         clr     (0x0031)
   9873 D6 62         [ 3] 2777         ldab    (0x0062)
   9875 C4 FE         [ 2] 2778         andb    #0xFE
   9877 D7 62         [ 3] 2779         stab    (0x0062)
   9879 BD F9 C5      [ 6] 2780         jsr     BUTNLIT 
   987C BD AA 13      [ 6] 2781         jsr     LAA13
   987F C6 FB         [ 2] 2782         ldab    #0xFB
   9881 BD 86 E7      [ 6] 2783         jsr     L86E7
   9884 7F 00 5A      [ 6] 2784         clr     (0x005A)
   9887 20 4B         [ 3] 2785         bra     L98D4  
   9889                    2786 L9889:
   9889 DC 1B         [ 4] 2787         ldd     CDTIMR1
   988B 26 D7         [ 3] 2788         bne     L9864  
   988D D6 62         [ 3] 2789         ldab    (0x0062)
   988F C8 01         [ 2] 2790         eorb    #0x01
   9891 D7 62         [ 3] 2791         stab    (0x0062)
   9893 BD F9 C5      [ 6] 2792         jsr     BUTNLIT 
   9896 C4 01         [ 2] 2793         andb    #0x01
   9898 26 05         [ 3] 2794         bne     L989F  
   989A BD AA 0C      [ 6] 2795         jsr     LAA0C
   989D 20 03         [ 3] 2796         bra     L98A2  
   989F                    2797 L989F:
   989F BD AA 13      [ 6] 2798         jsr     LAA13
   98A2                    2799 L98A2:
   98A2 CC 00 32      [ 3] 2800         ldd     #0x0032
   98A5 DD 1B         [ 4] 2801         std     CDTIMR1
   98A7 DC 1D         [ 4] 2802         ldd     CDTIMR2
   98A9 27 C5         [ 3] 2803         beq     L9870  
   98AB 20 B7         [ 3] 2804         bra     L9864  
   98AD                    2805 L98AD:
   98AD 7D 00 75      [ 6] 2806         tst     (0x0075)
   98B0 27 03         [ 3] 2807         beq     L98B5  
   98B2 7E 99 39      [ 3] 2808         jmp     L9939
   98B5                    2809 L98B5:
   98B5 96 62         [ 3] 2810         ldaa    (0x0062)
   98B7 84 02         [ 2] 2811         anda    #0x02
   98B9 27 4E         [ 3] 2812         beq     L9909  
   98BB 7D 00 AF      [ 6] 2813         tst     (0x00AF)
   98BE 26 0B         [ 3] 2814         bne     L98CB  
   98C0 FC 04 24      [ 5] 2815         ldd     (0x0424)
   98C3 C3 00 01      [ 4] 2816         addd    #0x0001
   98C6 FD 04 24      [ 5] 2817         std     (0x0424)
   98C9 20 09         [ 3] 2818         bra     L98D4  
   98CB                    2819 L98CB:
   98CB FC 04 22      [ 5] 2820         ldd     (0x0422)
   98CE C3 00 01      [ 4] 2821         addd    #0x0001
   98D1 FD 04 22      [ 5] 2822         std     (0x0422)
   98D4                    2823 L98D4:
   98D4 FC 04 18      [ 5] 2824         ldd     (0x0418)
   98D7 C3 00 01      [ 4] 2825         addd    #0x0001
   98DA FD 04 18      [ 5] 2826         std     (0x0418)
   98DD 86 78         [ 2] 2827         ldaa    #0x78
   98DF 97 63         [ 3] 2828         staa    (0x0063)
   98E1 97 64         [ 3] 2829         staa    (0x0064)
   98E3 D6 62         [ 3] 2830         ldab    (0x0062)
   98E5 C4 F7         [ 2] 2831         andb    #0xF7
   98E7 CA 02         [ 2] 2832         orab    #0x02
   98E9 D7 62         [ 3] 2833         stab    (0x0062)
   98EB BD F9 C5      [ 6] 2834         jsr     BUTNLIT 
   98EE BD AA 18      [ 6] 2835         jsr     LAA18
   98F1 86 01         [ 2] 2836         ldaa    #0x01
   98F3 97 4E         [ 3] 2837         staa    (0x004E)
   98F5 97 75         [ 3] 2838         staa    (0x0075)
   98F7 D6 7B         [ 3] 2839         ldab    (0x007B)
   98F9 C4 DF         [ 2] 2840         andb    #0xDF
   98FB BD 87 48      [ 6] 2841         jsr     L8748   
   98FE BD 87 AE      [ 6] 2842         jsr     L87AE
   9901 BD A3 13      [ 6] 2843         jsr     LA313
   9904 BD AA DB      [ 6] 2844         jsr     LAADB
   9907 20 30         [ 3] 2845         bra     L9939  
   9909                    2846 L9909:
   9909 D6 62         [ 3] 2847         ldab    (0x0062)
   990B C4 F5         [ 2] 2848         andb    #0xF5
   990D CA 40         [ 2] 2849         orab    #0x40
   990F D7 62         [ 3] 2850         stab    (0x0062)
   9911 BD F9 C5      [ 6] 2851         jsr     BUTNLIT 
   9914 BD AA 1D      [ 6] 2852         jsr     LAA1D
   9917 7D 00 AF      [ 6] 2853         tst     (0x00AF)
   991A 26 04         [ 3] 2854         bne     L9920  
   991C C6 01         [ 2] 2855         ldab    #0x01
   991E D7 B6         [ 3] 2856         stab    (0x00B6)
   9920                    2857 L9920:
   9920 BD 9C 51      [ 6] 2858         jsr     L9C51
   9923 7F 00 4E      [ 6] 2859         clr     (0x004E)
   9926 7F 00 75      [ 6] 2860         clr     (0x0075)
   9929 86 01         [ 2] 2861         ldaa    #0x01
   992B 97 77         [ 3] 2862         staa    (0x0077)
   992D D6 7B         [ 3] 2863         ldab    (0x007B)
   992F CA 24         [ 2] 2864         orab    #0x24
   9931 C4 F7         [ 2] 2865         andb    #0xF7
   9933 BD 87 48      [ 6] 2866         jsr     L8748   
   9936 BD 87 91      [ 6] 2867         jsr     L8791   
   9939                    2868 L9939:
   9939 7F 00 AF      [ 6] 2869         clr     (0x00AF)
   993C 7E 85 A4      [ 3] 2870         jmp     L85A4
   993F                    2871 L993F:
   993F 7F 00 77      [ 6] 2872         clr     (0x0077)
   9942 BD 9C 51      [ 6] 2873         jsr     L9C51
   9945 7F 00 4E      [ 6] 2874         clr     (0x004E)
   9948 D6 62         [ 3] 2875         ldab    (0x0062)
   994A C4 BF         [ 2] 2876         andb    #0xBF
   994C 7D 00 75      [ 6] 2877         tst     (0x0075)
   994F 27 02         [ 3] 2878         beq     L9953  
   9951 C4 FD         [ 2] 2879         andb    #0xFD
   9953                    2880 L9953:
   9953 D7 62         [ 3] 2881         stab    (0x0062)
   9955 BD F9 C5      [ 6] 2882         jsr     BUTNLIT 
   9958 BD AA 1D      [ 6] 2883         jsr     LAA1D
   995B 7F 00 5B      [ 6] 2884         clr     (0x005B)
   995E BD 87 AE      [ 6] 2885         jsr     L87AE
   9961 D6 7B         [ 3] 2886         ldab    (0x007B)
   9963 CA 20         [ 2] 2887         orab    #0x20
   9965 BD 87 48      [ 6] 2888         jsr     L8748   
   9968 7F 00 75      [ 6] 2889         clr     (0x0075)
   996B 7F 00 76      [ 6] 2890         clr     (0x0076)
   996E 7E 98 15      [ 3] 2891         jmp     L9815
   9971                    2892 L9971:
   9971 D6 7B         [ 3] 2893         ldab    (0x007B)
   9973 C4 FB         [ 2] 2894         andb    #0xFB
   9975 BD 87 48      [ 6] 2895         jsr     L8748   
   9978 7E 85 A4      [ 3] 2896         jmp     L85A4
   997B                    2897 L997B:
   997B D6 7B         [ 3] 2898         ldab    (0x007B)
   997D CA 04         [ 2] 2899         orab    #0x04
   997F BD 87 48      [ 6] 2900         jsr     L8748   
   9982 7E 85 A4      [ 3] 2901         jmp     L85A4
   9985                    2902 L9985:
   9985 D6 7B         [ 3] 2903         ldab    (0x007B)
   9987 C4 F7         [ 2] 2904         andb    #0xF7
   9989 BD 87 48      [ 6] 2905         jsr     L8748   
   998C 7E 85 A4      [ 3] 2906         jmp     L85A4
   998F                    2907 L998F:
   998F 7D 00 77      [ 6] 2908         tst     (0x0077)
   9992 26 07         [ 3] 2909         bne     L999B
   9994 D6 7B         [ 3] 2910         ldab    (0x007B)
   9996 CA 08         [ 2] 2911         orab    #0x08
   9998 BD 87 48      [ 6] 2912         jsr     L8748   
   999B                    2913 L999B:
   999B 7E 85 A4      [ 3] 2914         jmp     L85A4
   999E                    2915 L999E:
   999E D6 7B         [ 3] 2916         ldab    (0x007B)
   99A0 C4 F3         [ 2] 2917         andb    #0xF3
   99A2 BD 87 48      [ 6] 2918         jsr     L8748   
   99A5 39            [ 5] 2919         rts
                           2920 
                           2921 ; main2
   99A6                    2922 L99A6:
   99A6 D6 7B         [ 3] 2923         ldab    (0x007B)
   99A8 C4 DF         [ 2] 2924         andb    #0xDF        ; clear bit 5
   99AA BD 87 48      [ 6] 2925         jsr     L8748
   99AD BD 87 91      [ 6] 2926         jsr     L8791   
   99B0 39            [ 5] 2927         rts
                           2928 
   99B1                    2929 L99B1:
   99B1 D6 7B         [ 3] 2930         ldab    (0x007B)
   99B3 CA 20         [ 2] 2931         orab    #0x20
   99B5 BD 87 48      [ 6] 2932         jsr     L8748   
   99B8 BD 87 AE      [ 6] 2933         jsr     L87AE
   99BB 39            [ 5] 2934         rts
                           2935 
   99BC D6 7B         [ 3] 2936         ldab    (0x007B)
   99BE C4 DF         [ 2] 2937         andb    #0xDF
   99C0 BD 87 48      [ 6] 2938         jsr     L8748   
   99C3 BD 87 AE      [ 6] 2939         jsr     L87AE
   99C6 39            [ 5] 2940         rts
                           2941 
   99C7 D6 7B         [ 3] 2942         ldab    (0x007B)
   99C9 CA 20         [ 2] 2943         orab    #0x20
   99CB BD 87 48      [ 6] 2944         jsr     L8748   
   99CE BD 87 91      [ 6] 2945         jsr     L8791   
   99D1 39            [ 5] 2946         rts
                           2947 
   99D2                    2948 L99D2:
   99D2 86 01         [ 2] 2949         ldaa    #0x01
   99D4 97 78         [ 3] 2950         staa    (0x0078)
   99D6 7E 85 A4      [ 3] 2951         jmp     L85A4
   99D9                    2952 L99D9:
   99D9 CE 0E 20      [ 3] 2953         ldx     #0x0E20
   99DC A6 00         [ 4] 2954         ldaa    0,X     
   99DE 80 30         [ 2] 2955         suba    #0x30
   99E0 C6 0A         [ 2] 2956         ldab    #0x0A
   99E2 3D            [10] 2957         mul
   99E3 17            [ 2] 2958         tba
   99E4 C6 64         [ 2] 2959         ldab    #0x64
   99E6 3D            [10] 2960         mul
   99E7 DD 17         [ 4] 2961         std     (0x0017)
   99E9 A6 01         [ 4] 2962         ldaa    1,X     
   99EB 80 30         [ 2] 2963         suba    #0x30
   99ED C6 64         [ 2] 2964         ldab    #0x64
   99EF 3D            [10] 2965         mul
   99F0 D3 17         [ 5] 2966         addd    (0x0017)
   99F2 DD 17         [ 4] 2967         std     (0x0017)
   99F4 A6 02         [ 4] 2968         ldaa    2,X     
   99F6 80 30         [ 2] 2969         suba    #0x30
   99F8 C6 0A         [ 2] 2970         ldab    #0x0A
   99FA 3D            [10] 2971         mul
   99FB D3 17         [ 5] 2972         addd    (0x0017)
   99FD DD 17         [ 4] 2973         std     (0x0017)
   99FF 4F            [ 2] 2974         clra
   9A00 E6 03         [ 4] 2975         ldab    3,X     
   9A02 C0 30         [ 2] 2976         subb    #0x30
   9A04 D3 17         [ 5] 2977         addd    (0x0017)
   9A06 FD 02 9C      [ 5] 2978         std     (0x029C)
   9A09 CE 0E 20      [ 3] 2979         ldx     #0x0E20
   9A0C                    2980 L9A0C:
   9A0C A6 00         [ 4] 2981         ldaa    0,X     
   9A0E 81 30         [ 2] 2982         cmpa    #0x30
   9A10 25 13         [ 3] 2983         bcs     L9A25  
   9A12 81 39         [ 2] 2984         cmpa    #0x39
   9A14 22 0F         [ 3] 2985         bhi     L9A25  
   9A16 08            [ 3] 2986         inx
   9A17 8C 0E 24      [ 4] 2987         cpx     #0x0E24
   9A1A 26 F0         [ 3] 2988         bne     L9A0C  
   9A1C B6 0E 24      [ 4] 2989         ldaa    (0x0E24)        ; check EEPROM signature
   9A1F 81 DB         [ 2] 2990         cmpa    #0xDB
   9A21 26 02         [ 3] 2991         bne     L9A25  
   9A23 0C            [ 2] 2992         clc
   9A24 39            [ 5] 2993         rts
                           2994 
   9A25                    2995 L9A25:
   9A25 0D            [ 2] 2996         sec
   9A26 39            [ 5] 2997         rts
                           2998 
   9A27                    2999 L9A27:
   9A27 BD 8D E4      [ 6] 3000         jsr     LCDMSG1 
   9A2A 53 65 72 69 61 6C  3001         .ascis  'Serial# '
        23 A0
                           3002 
   9A32 BD 8D DD      [ 6] 3003         jsr     LCDMSG2 
   9A35 20 20 20 20 20 20  3004         .ascis  '               '
        20 20 20 20 20 20
        20 20 A0
                           3005 
                           3006 ; display 4-digit serial number
   9A44 C6 08         [ 2] 3007         ldab    #0x08
   9A46 18 CE 0E 20   [ 4] 3008         ldy     #0x0E20
   9A4A                    3009 L9A4A:
   9A4A 18 A6 00      [ 5] 3010         ldaa    0,Y     
   9A4D 18 3C         [ 5] 3011         pshy
   9A4F 37            [ 3] 3012         pshb
   9A50 BD 8D B5      [ 6] 3013         jsr     L8DB5            ; display char here on LCD display
   9A53 33            [ 4] 3014         pulb
   9A54 18 38         [ 6] 3015         puly
   9A56 5C            [ 2] 3016         incb
   9A57 18 08         [ 4] 3017         iny
   9A59 18 8C 0E 24   [ 5] 3018         cpy     #0x0E24
   9A5D 26 EB         [ 3] 3019         bne     L9A4A  
   9A5F 39            [ 5] 3020         rts
                           3021 
                           3022 ; Unused?
   9A60                    3023 L9A60:
   9A60 86 01         [ 2] 3024         ldaa    #0x01
   9A62 97 B5         [ 3] 3025         staa    (0x00B5)
   9A64 96 4E         [ 3] 3026         ldaa    (0x004E)
   9A66 97 7F         [ 3] 3027         staa    (0x007F)
   9A68 96 62         [ 3] 3028         ldaa    (0x0062)
   9A6A 97 80         [ 3] 3029         staa    (0x0080)
   9A6C 96 7B         [ 3] 3030         ldaa    (0x007B)
   9A6E 97 81         [ 3] 3031         staa    (0x0081)
   9A70 96 7A         [ 3] 3032         ldaa    (0x007A)
   9A72 97 82         [ 3] 3033         staa    (0x0082)
   9A74 96 78         [ 3] 3034         ldaa    (0x0078)
   9A76 97 7D         [ 3] 3035         staa    (0x007D)
   9A78 B6 10 8A      [ 4] 3036         ldaa    (0x108A)
   9A7B 84 06         [ 2] 3037         anda    #0x06
   9A7D 97 7E         [ 3] 3038         staa    (0x007E)
   9A7F                    3039 L9A7F:
   9A7F C6 EF         [ 2] 3040         ldab    #0xEF
   9A81 BD 86 E7      [ 6] 3041         jsr     L86E7
   9A84 D6 7B         [ 3] 3042         ldab    (0x007B)
   9A86 CA 0C         [ 2] 3043         orab    #0x0C
   9A88 C4 DF         [ 2] 3044         andb    #0xDF
   9A8A BD 87 48      [ 6] 3045         jsr     L8748   
   9A8D BD 87 91      [ 6] 3046         jsr     L8791   
   9A90 BD 86 C4      [ 6] 3047         jsr     L86C4
   9A93 BD 9C 51      [ 6] 3048         jsr     L9C51
   9A96 C6 06         [ 2] 3049         ldab    #0x06            ; delay 6 secs
   9A98 BD 8C 02      [ 6] 3050         jsr     DLYSECS          ;
   9A9B BD 8E 95      [ 6] 3051         jsr     L8E95
   9A9E BD 99 A6      [ 6] 3052         jsr     L99A6
   9AA1 7E 81 BD      [ 3] 3053         jmp     L81BD
   9AA4                    3054 L9AA4:
   9AA4 7F 00 5C      [ 6] 3055         clr     (0x005C)
   9AA7 86 01         [ 2] 3056         ldaa    #0x01
   9AA9 97 79         [ 3] 3057         staa    (0x0079)
   9AAB C6 FD         [ 2] 3058         ldab    #0xFD
   9AAD BD 86 E7      [ 6] 3059         jsr     L86E7
   9AB0 BD 8E 95      [ 6] 3060         jsr     L8E95
   9AB3 CC 75 30      [ 3] 3061         ldd     #0x7530
   9AB6 DD 1D         [ 4] 3062         std     CDTIMR2
   9AB8                    3063 L9AB8:
   9AB8 BD 9B 19      [ 6] 3064         jsr     L9B19   
   9ABB D6 62         [ 3] 3065         ldab    (0x0062)
   9ABD C8 04         [ 2] 3066         eorb    #0x04
   9ABF D7 62         [ 3] 3067         stab    (0x0062)
   9AC1 BD F9 C5      [ 6] 3068         jsr     BUTNLIT 
   9AC4 F6 18 04      [ 4] 3069         ldab    PIA0PRA 
   9AC7 C8 08         [ 2] 3070         eorb    #0x08
   9AC9 F7 18 04      [ 4] 3071         stab    PIA0PRA 
   9ACC 7D 00 5C      [ 6] 3072         tst     (0x005C)
   9ACF 26 12         [ 3] 3073         bne     L9AE3  
   9AD1 BD 8E 95      [ 6] 3074         jsr     L8E95
   9AD4 81 0D         [ 2] 3075         cmpa    #0x0D
   9AD6 27 0B         [ 3] 3076         beq     L9AE3  
   9AD8 C6 32         [ 2] 3077         ldab    #0x32       ; delay 0.5 sec
   9ADA BD 8C 22      [ 6] 3078         jsr     DLYSECSBY100
   9ADD DC 1D         [ 4] 3079         ldd     CDTIMR2
   9ADF 27 02         [ 3] 3080         beq     L9AE3  
   9AE1 20 D5         [ 3] 3081         bra     L9AB8  
   9AE3                    3082 L9AE3:
   9AE3 D6 62         [ 3] 3083         ldab    (0x0062)
   9AE5 C4 FB         [ 2] 3084         andb    #0xFB
   9AE7 D7 62         [ 3] 3085         stab    (0x0062)
   9AE9 BD F9 C5      [ 6] 3086         jsr     BUTNLIT 
   9AEC BD A3 54      [ 6] 3087         jsr     LA354
   9AEF C6 FB         [ 2] 3088         ldab    #0xFB
   9AF1 BD 86 E7      [ 6] 3089         jsr     L86E7
   9AF4 7E 85 A4      [ 3] 3090         jmp     L85A4
   9AF7                    3091 L9AF7:
   9AF7 7F 00 75      [ 6] 3092         clr     (0x0075)
   9AFA 7F 00 76      [ 6] 3093         clr     (0x0076)
   9AFD 7F 00 77      [ 6] 3094         clr     (0x0077)
   9B00 7F 00 78      [ 6] 3095         clr     (0x0078)
   9B03 7F 00 25      [ 6] 3096         clr     (0x0025)
   9B06 7F 00 26      [ 6] 3097         clr     (0x0026)
   9B09 7F 00 4E      [ 6] 3098         clr     (0x004E)
   9B0C 7F 00 30      [ 6] 3099         clr     (0x0030)
   9B0F 7F 00 31      [ 6] 3100         clr     (0x0031)
   9B12 7F 00 32      [ 6] 3101         clr     (0x0032)
   9B15 7F 00 AF      [ 6] 3102         clr     (0x00AF)
   9B18 39            [ 5] 3103         rts
                           3104 
                           3105 ; validate a bunch of ram locations against bytes in ROM???
   9B19                    3106 L9B19:
   9B19 36            [ 3] 3107         psha
   9B1A 37            [ 3] 3108         pshb
   9B1B 96 4E         [ 3] 3109         ldaa    (0x004E)
   9B1D 27 17         [ 3] 3110         beq     L9B36       ; go to 0401 logic
   9B1F 96 63         [ 3] 3111         ldaa    (0x0063)
   9B21 26 10         [ 3] 3112         bne     L9B33       ; exit
   9B23 7D 00 64      [ 6] 3113         tst     (0x0064)
   9B26 27 09         [ 3] 3114         beq     L9B31       ; go to 0401 logic
   9B28 BD 86 C4      [ 6] 3115         jsr     L86C4       ; do something with boards???
   9B2B BD 9C 51      [ 6] 3116         jsr     L9C51       ; RTC stuff???
   9B2E 7F 00 64      [ 6] 3117         clr     (0x0064)
   9B31                    3118 L9B31:
   9B31 20 03         [ 3] 3119         bra     L9B36       ; go to 0401 logic
   9B33                    3120 L9B33:
   9B33 33            [ 4] 3121         pulb
   9B34 32            [ 4] 3122         pula
   9B35 39            [ 5] 3123         rts
                           3124 
                           3125 ; end up here immediately if:
                           3126 ; 0x004E == 00 or
                           3127 ; 0x0063, 0x0064 == 0 or
                           3128 ; 
                           3129 ; do subroutines based on bits 0-4 of 0x0401?
   9B36                    3130 L9B36:
   9B36 B6 04 01      [ 4] 3131         ldaa    (0x0401)
   9B39 84 01         [ 2] 3132         anda    #0x01
   9B3B 27 03         [ 3] 3133         beq     L9B40  
   9B3D BD 9B 6B      [ 6] 3134         jsr     L9B6B       ; bit 0 routine
   9B40                    3135 L9B40:
   9B40 B6 04 01      [ 4] 3136         ldaa    (0x0401)
   9B43 84 02         [ 2] 3137         anda    #0x02
   9B45 27 03         [ 3] 3138         beq     L9B4A  
   9B47 BD 9B 99      [ 6] 3139         jsr     L9B99       ; bit 1 routine
   9B4A                    3140 L9B4A:
   9B4A B6 04 01      [ 4] 3141         ldaa    (0x0401)
   9B4D 84 04         [ 2] 3142         anda    #0x04
   9B4F 27 03         [ 3] 3143         beq     L9B54  
   9B51 BD 9B C7      [ 6] 3144         jsr     L9BC7       ; bit 2 routine
   9B54                    3145 L9B54:
   9B54 B6 04 01      [ 4] 3146         ldaa    (0x0401)
   9B57 84 08         [ 2] 3147         anda    #0x08
   9B59 27 03         [ 3] 3148         beq     L9B5E  
   9B5B BD 9B F5      [ 6] 3149         jsr     L9BF5       ; bit 3 routine
   9B5E                    3150 L9B5E:
   9B5E B6 04 01      [ 4] 3151         ldaa    (0x0401)
   9B61 84 10         [ 2] 3152         anda    #0x10
   9B63 27 03         [ 3] 3153         beq     L9B68  
   9B65 BD 9C 23      [ 6] 3154         jsr     L9C23       ; bit 4 routine
   9B68                    3155 L9B68:
   9B68 33            [ 4] 3156         pulb
   9B69 32            [ 4] 3157         pula
   9B6A 39            [ 5] 3158         rts
                           3159 
                           3160 ; bit 0 routine
   9B6B                    3161 L9B6B:
   9B6B 18 3C         [ 5] 3162         pshy
   9B6D 18 DE 65      [ 5] 3163         ldy     (0x0065)
   9B70 18 A6 00      [ 5] 3164         ldaa    0,Y     
   9B73 81 FF         [ 2] 3165         cmpa    #0xFF
   9B75 27 14         [ 3] 3166         beq     L9B8B  
   9B77 91 70         [ 3] 3167         cmpa    OFFCNT1
   9B79 25 0D         [ 3] 3168         bcs     L9B88  
   9B7B 18 08         [ 4] 3169         iny
   9B7D 18 A6 00      [ 5] 3170         ldaa    0,Y     
   9B80 B7 10 80      [ 4] 3171         staa    (0x1080)
   9B83 18 08         [ 4] 3172         iny
   9B85 18 DF 65      [ 5] 3173         sty     (0x0065)
   9B88                    3174 L9B88:
   9B88 18 38         [ 6] 3175         puly
   9B8A 39            [ 5] 3176         rts
   9B8B                    3177 L9B8B:
   9B8B 18 CE B2 EB   [ 4] 3178         ldy     #LB2EB
   9B8F 18 DF 65      [ 5] 3179         sty     (0x0065)
   9B92 86 FA         [ 2] 3180         ldaa    #0xFA
   9B94 97 70         [ 3] 3181         staa    OFFCNT1
   9B96 7E 9B 88      [ 3] 3182         jmp     L9B88
   9B99                    3183 L9B99:
   9B99 18 3C         [ 5] 3184         pshy
   9B9B 18 DE 67      [ 5] 3185         ldy     (0x0067)
   9B9E 18 A6 00      [ 5] 3186         ldaa    0,Y     
   9BA1 81 FF         [ 2] 3187         cmpa    #0xFF
   9BA3 27 14         [ 3] 3188         beq     L9BB9  
   9BA5 91 71         [ 3] 3189         cmpa    OFFCNT2
   9BA7 25 0D         [ 3] 3190         bcs     L9BB6  
   9BA9 18 08         [ 4] 3191         iny
   9BAB 18 A6 00      [ 5] 3192         ldaa    0,Y     
   9BAE B7 10 84      [ 4] 3193         staa    (0x1084)
   9BB1 18 08         [ 4] 3194         iny
   9BB3 18 DF 67      [ 5] 3195         sty     (0x0067)
   9BB6                    3196 L9BB6:
   9BB6 18 38         [ 6] 3197         puly
   9BB8 39            [ 5] 3198         rts
                           3199 
                           3200 ; bit 1 routine
   9BB9                    3201 L9BB9:
   9BB9 18 CE B3 BD   [ 4] 3202         ldy     #LB3BD
   9BBD 18 DF 67      [ 5] 3203         sty     (0x0067)
   9BC0 86 E6         [ 2] 3204         ldaa    #0xE6
   9BC2 97 71         [ 3] 3205         staa    OFFCNT2
   9BC4 7E 9B B6      [ 3] 3206         jmp     L9BB6
                           3207 
                           3208 ; bit 2 routine
   9BC7                    3209 L9BC7:
   9BC7 18 3C         [ 5] 3210         pshy
   9BC9 18 DE 69      [ 5] 3211         ldy     (0x0069)
   9BCC 18 A6 00      [ 5] 3212         ldaa    0,Y     
   9BCF 81 FF         [ 2] 3213         cmpa    #0xFF
   9BD1 27 14         [ 3] 3214         beq     L9BE7  
   9BD3 91 72         [ 3] 3215         cmpa    OFFCNT3
   9BD5 25 0D         [ 3] 3216         bcs     L9BE4  
   9BD7 18 08         [ 4] 3217         iny
   9BD9 18 A6 00      [ 5] 3218         ldaa    0,Y     
   9BDC B7 10 88      [ 4] 3219         staa    (0x1088)
   9BDF 18 08         [ 4] 3220         iny
   9BE1 18 DF 69      [ 5] 3221         sty     (0x0069)
   9BE4                    3222 L9BE4:
   9BE4 18 38         [ 6] 3223         puly
   9BE6 39            [ 5] 3224         rts
   9BE7                    3225 L9BE7:
   9BE7 18 CE B5 31   [ 4] 3226         ldy     #LB531
   9BEB 18 DF 69      [ 5] 3227         sty     (0x0069)
   9BEE 86 D2         [ 2] 3228         ldaa    #0xD2
   9BF0 97 72         [ 3] 3229         staa    OFFCNT3
   9BF2 7E 9B E4      [ 3] 3230         jmp     L9BE4
                           3231 
                           3232 ; bit 3 routine
   9BF5                    3233 L9BF5:
   9BF5 18 3C         [ 5] 3234         pshy
   9BF7 18 DE 6B      [ 5] 3235         ldy     (0x006B)
   9BFA 18 A6 00      [ 5] 3236         ldaa    0,Y     
   9BFD 81 FF         [ 2] 3237         cmpa    #0xFF
   9BFF 27 14         [ 3] 3238         beq     L9C15  
   9C01 91 73         [ 3] 3239         cmpa    OFFCNT4
   9C03 25 0D         [ 3] 3240         bcs     L9C12  
   9C05 18 08         [ 4] 3241         iny
   9C07 18 A6 00      [ 5] 3242         ldaa    0,Y     
   9C0A B7 10 8C      [ 4] 3243         staa    (0x108C)
   9C0D 18 08         [ 4] 3244         iny
   9C0F 18 DF 6B      [ 5] 3245         sty     (0x006B)
   9C12                    3246 L9C12:
   9C12 18 38         [ 6] 3247         puly
   9C14 39            [ 5] 3248         rts
   9C15                    3249 L9C15:
   9C15 18 CE B4 75   [ 4] 3250         ldy     #LB475
   9C19 18 DF 6B      [ 5] 3251         sty     (0x006B)
   9C1C 86 BE         [ 2] 3252         ldaa    #0xBE
   9C1E 97 73         [ 3] 3253         staa    OFFCNT4
   9C20 7E 9C 12      [ 3] 3254         jmp     L9C12
                           3255 
                           3256 ; bit 4 routine
   9C23                    3257 L9C23:
   9C23 18 3C         [ 5] 3258         pshy
   9C25 18 DE 6D      [ 5] 3259         ldy     (0x006D)
   9C28 18 A6 00      [ 5] 3260         ldaa    0,Y     
   9C2B 81 FF         [ 2] 3261         cmpa    #0xFF
   9C2D 27 14         [ 3] 3262         beq     L9C43  
   9C2F 91 74         [ 3] 3263         cmpa    OFFCNT5
   9C31 25 0D         [ 3] 3264         bcs     L9C40  
   9C33 18 08         [ 4] 3265         iny
   9C35 18 A6 00      [ 5] 3266         ldaa    0,Y     
   9C38 B7 10 90      [ 4] 3267         staa    (0x1090)
   9C3B 18 08         [ 4] 3268         iny
   9C3D 18 DF 6D      [ 5] 3269         sty     (0x006D)
   9C40                    3270 L9C40:
   9C40 18 38         [ 6] 3271         puly
   9C42 39            [ 5] 3272         rts
   9C43                    3273 L9C43:
   9C43 18 CE B5 C3   [ 4] 3274         ldy     #LB5C3
   9C47 18 DF 6D      [ 5] 3275         sty     (0x006D)
   9C4A 86 AA         [ 2] 3276         ldaa    #0xAA
   9C4C 97 74         [ 3] 3277         staa    OFFCNT5
   9C4E 7E 9C 40      [ 3] 3278         jmp     L9C40
                           3279 
                           3280 ; Reset offset counters to initial values
   9C51                    3281 L9C51:
   9C51 86 FA         [ 2] 3282         ldaa    #0xFA
   9C53 97 70         [ 3] 3283         staa    OFFCNT1
   9C55 86 E6         [ 2] 3284         ldaa    #0xE6
   9C57 97 71         [ 3] 3285         staa    OFFCNT2
   9C59 86 D2         [ 2] 3286         ldaa    #0xD2
   9C5B 97 72         [ 3] 3287         staa    OFFCNT3
   9C5D 86 BE         [ 2] 3288         ldaa    #0xBE
   9C5F 97 73         [ 3] 3289         staa    OFFCNT4
   9C61 86 AA         [ 2] 3290         ldaa    #0xAA
   9C63 97 74         [ 3] 3291         staa    OFFCNT5
                           3292 
   9C65 18 CE B2 EB   [ 4] 3293         ldy     #LB2EB
   9C69 18 DF 65      [ 5] 3294         sty     (0x0065)
   9C6C 18 CE B3 BD   [ 4] 3295         ldy     #LB3BD
   9C70 18 DF 67      [ 5] 3296         sty     (0x0067)
   9C73 18 CE B5 31   [ 4] 3297         ldy     #LB531
   9C77 18 DF 69      [ 5] 3298         sty     (0x0069)
   9C7A 18 CE B4 75   [ 4] 3299         ldy     #LB475
   9C7E 18 DF 6B      [ 5] 3300         sty     (0x006B)
   9C81 18 CE B5 C3   [ 4] 3301         ldy     #LB5C3
   9C85 18 DF 6D      [ 5] 3302         sty     (0x006D)
                           3303 
   9C88 7F 10 9C      [ 6] 3304         clr     (0x109C)
   9C8B 7F 10 9E      [ 6] 3305         clr     (0x109E)
                           3306 
   9C8E B6 04 01      [ 4] 3307         ldaa    (0x0401)
   9C91 84 20         [ 2] 3308         anda    #0x20
   9C93 27 08         [ 3] 3309         beq     L9C9D  
   9C95 B6 10 9C      [ 4] 3310         ldaa    (0x109C)
   9C98 8A 19         [ 2] 3311         oraa    #0x19
   9C9A B7 10 9C      [ 4] 3312         staa    (0x109C)
   9C9D                    3313 L9C9D:
   9C9D B6 04 01      [ 4] 3314         ldaa    (0x0401)
   9CA0 84 40         [ 2] 3315         anda    #0x40
   9CA2 27 10         [ 3] 3316         beq     L9CB4  
   9CA4 B6 10 9C      [ 4] 3317         ldaa    (0x109C)
   9CA7 8A 44         [ 2] 3318         oraa    #0x44
   9CA9 B7 10 9C      [ 4] 3319         staa    (0x109C)
   9CAC B6 10 9E      [ 4] 3320         ldaa    (0x109E)
   9CAF 8A 40         [ 2] 3321         oraa    #0x40
   9CB1 B7 10 9E      [ 4] 3322         staa    (0x109E)
   9CB4                    3323 L9CB4:
   9CB4 B6 04 01      [ 4] 3324         ldaa    (0x0401)
   9CB7 84 80         [ 2] 3325         anda    #0x80
   9CB9 27 08         [ 3] 3326         beq     L9CC3  
   9CBB B6 10 9C      [ 4] 3327         ldaa    (0x109C)
   9CBE 8A A2         [ 2] 3328         oraa    #0xA2
   9CC0 B7 10 9C      [ 4] 3329         staa    (0x109C)
   9CC3                    3330 L9CC3:
   9CC3 B6 04 2B      [ 4] 3331         ldaa    (0x042B)
   9CC6 84 01         [ 2] 3332         anda    #0x01
   9CC8 27 08         [ 3] 3333         beq     L9CD2  
   9CCA B6 10 9A      [ 4] 3334         ldaa    (0x109A)
   9CCD 8A 80         [ 2] 3335         oraa    #0x80
   9CCF B7 10 9A      [ 4] 3336         staa    (0x109A)
   9CD2                    3337 L9CD2:
   9CD2 B6 04 2B      [ 4] 3338         ldaa    (0x042B)
   9CD5 84 02         [ 2] 3339         anda    #0x02
   9CD7 27 08         [ 3] 3340         beq     L9CE1  
   9CD9 B6 10 9E      [ 4] 3341         ldaa    (0x109E)
   9CDC 8A 04         [ 2] 3342         oraa    #0x04
   9CDE B7 10 9E      [ 4] 3343         staa    (0x109E)
   9CE1                    3344 L9CE1:
   9CE1 B6 04 2B      [ 4] 3345         ldaa    (0x042B)
   9CE4 84 04         [ 2] 3346         anda    #0x04
   9CE6 27 08         [ 3] 3347         beq     L9CF0  
   9CE8 B6 10 9E      [ 4] 3348         ldaa    (0x109E)
   9CEB 8A 08         [ 2] 3349         oraa    #0x08
   9CED B7 10 9E      [ 4] 3350         staa    (0x109E)
   9CF0                    3351 L9CF0:
   9CF0 39            [ 5] 3352         rts
                           3353 
                           3354 ; Display Credits
   9CF1                    3355 L9CF1:
   9CF1 BD 8D E4      [ 6] 3356         jsr     LCDMSG1 
   9CF4 20 20 20 50 72 6F  3357         .ascis  '   Program by   '
        67 72 61 6D 20 62
        79 20 20 A0
                           3358 
   9D04 BD 8D DD      [ 6] 3359         jsr     LCDMSG2 
   9D07 44 61 76 69 64 20  3360         .ascis  'David  Philipsen'
        20 50 68 69 6C 69
        70 73 65 EE
                           3361 
   9D17 39            [ 5] 3362         rts
                           3363 
   9D18                    3364 L9D18:
   9D18 97 49         [ 3] 3365         staa    (0x0049)
   9D1A 7F 00 B8      [ 6] 3366         clr     (0x00B8)
   9D1D BD 8D 03      [ 6] 3367         jsr     L8D03
   9D20 86 2A         [ 2] 3368         ldaa    #0x2A           ;'*'
   9D22 C6 28         [ 2] 3369         ldab    #0x28
   9D24 BD 8D B5      [ 6] 3370         jsr     L8DB5           ; display char here on LCD display
   9D27 CC 0B B8      [ 3] 3371         ldd     #0x0BB8         ; start 30 second timer?
   9D2A DD 1B         [ 4] 3372         std     CDTIMR1
   9D2C                    3373 L9D2C:
   9D2C BD 9B 19      [ 6] 3374         jsr     L9B19   
   9D2F 96 49         [ 3] 3375         ldaa    (0x0049)
   9D31 81 41         [ 2] 3376         cmpa    #0x41
   9D33 27 04         [ 3] 3377         beq     L9D39  
   9D35 81 4B         [ 2] 3378         cmpa    #0x4B
   9D37 26 04         [ 3] 3379         bne     L9D3D  
   9D39                    3380 L9D39:
   9D39 C6 01         [ 2] 3381         ldab    #0x01
   9D3B D7 B8         [ 3] 3382         stab    (0x00B8)
   9D3D                    3383 L9D3D:
   9D3D 81 41         [ 2] 3384         cmpa    #0x41
   9D3F 27 04         [ 3] 3385         beq     L9D45  
   9D41 81 4F         [ 2] 3386         cmpa    #0x4F
   9D43 26 07         [ 3] 3387         bne     L9D4C  
   9D45                    3388 L9D45:
   9D45 86 01         [ 2] 3389         ldaa    #0x01
   9D47 B7 02 98      [ 4] 3390         staa    (0x0298)
   9D4A 20 32         [ 3] 3391         bra     L9D7E  
   9D4C                    3392 L9D4C:
   9D4C 81 4B         [ 2] 3393         cmpa    #0x4B
   9D4E 27 04         [ 3] 3394         beq     L9D54  
   9D50 81 50         [ 2] 3395         cmpa    #0x50
   9D52 26 07         [ 3] 3396         bne     L9D5B  
   9D54                    3397 L9D54:
   9D54 86 02         [ 2] 3398         ldaa    #0x02
   9D56 B7 02 98      [ 4] 3399         staa    (0x0298)
   9D59 20 23         [ 3] 3400         bra     L9D7E  
   9D5B                    3401 L9D5B:
   9D5B 81 4C         [ 2] 3402         cmpa    #0x4C
   9D5D 26 07         [ 3] 3403         bne     L9D66  
   9D5F 86 03         [ 2] 3404         ldaa    #0x03
   9D61 B7 02 98      [ 4] 3405         staa    (0x0298)
   9D64 20 18         [ 3] 3406         bra     L9D7E  
   9D66                    3407 L9D66:
   9D66 81 52         [ 2] 3408         cmpa    #0x52
   9D68 26 07         [ 3] 3409         bne     L9D71  
   9D6A 86 04         [ 2] 3410         ldaa    #0x04
   9D6C B7 02 98      [ 4] 3411         staa    (0x0298)
   9D6F 20 0D         [ 3] 3412         bra     L9D7E  
   9D71                    3413 L9D71:
   9D71 DC 1B         [ 4] 3414         ldd     CDTIMR1
   9D73 26 B7         [ 3] 3415         bne     L9D2C  
   9D75 86 23         [ 2] 3416         ldaa    #0x23            ;'#'
   9D77 C6 29         [ 2] 3417         ldab    #0x29
   9D79 BD 8D B5      [ 6] 3418         jsr     L8DB5            ; display char here on LCD display
   9D7C 20 6C         [ 3] 3419         bra     L9DEA  
   9D7E                    3420 L9D7E:
   9D7E 7F 00 49      [ 6] 3421         clr     (0x0049)
   9D81 86 2A         [ 2] 3422         ldaa    #0x2A            ;'*'
   9D83 C6 29         [ 2] 3423         ldab    #0x29
   9D85 BD 8D B5      [ 6] 3424         jsr     L8DB5            ; display char here on LCD display
   9D88 7F 00 4A      [ 6] 3425         clr     (0x004A)
   9D8B CE 02 99      [ 3] 3426         ldx     #0x0299
   9D8E                    3427 L9D8E:
   9D8E BD 9B 19      [ 6] 3428         jsr     L9B19   
   9D91 96 4A         [ 3] 3429         ldaa    (0x004A)
   9D93 27 F9         [ 3] 3430         beq     L9D8E  
   9D95 7F 00 4A      [ 6] 3431         clr     (0x004A)
   9D98 84 3F         [ 2] 3432         anda    #0x3F
   9D9A A7 00         [ 4] 3433         staa    0,X     
   9D9C 08            [ 3] 3434         inx
   9D9D 8C 02 9C      [ 4] 3435         cpx     #0x029C
   9DA0 26 EC         [ 3] 3436         bne     L9D8E  
   9DA2 BD 9D F5      [ 6] 3437         jsr     L9DF5
   9DA5 24 09         [ 3] 3438         bcc     L9DB0  
   9DA7 86 23         [ 2] 3439         ldaa    #0x23            ;'#'
   9DA9 C6 2A         [ 2] 3440         ldab    #0x2A
   9DAB BD 8D B5      [ 6] 3441         jsr     L8DB5            ; display char here on LCD display
   9DAE 20 3A         [ 3] 3442         bra     L9DEA  
   9DB0                    3443 L9DB0:
   9DB0 86 2A         [ 2] 3444         ldaa    #0x2A            ;'*'
   9DB2 C6 2A         [ 2] 3445         ldab    #0x2A
   9DB4 BD 8D B5      [ 6] 3446         jsr     L8DB5            ; display char here on LCD display
   9DB7 B6 02 99      [ 4] 3447         ldaa    (0x0299)
   9DBA 81 39         [ 2] 3448         cmpa    #0x39
   9DBC 26 15         [ 3] 3449         bne     L9DD3  
                           3450 
   9DBE BD 8D DD      [ 6] 3451         jsr     LCDMSG2 
   9DC1 47 65 6E 65 72 69  3452         .ascis  'Generic Showtape'
        63 20 53 68 6F 77
        74 61 70 E5
                           3453 
   9DD1 0C            [ 2] 3454         clc
   9DD2 39            [ 5] 3455         rts
                           3456 
   9DD3                    3457 L9DD3:
   9DD3 B6 02 98      [ 4] 3458         ldaa    (0x0298)
   9DD6 81 03         [ 2] 3459         cmpa    #0x03
   9DD8 27 0E         [ 3] 3460         beq     L9DE8  
   9DDA 81 04         [ 2] 3461         cmpa    #0x04
   9DDC 27 0A         [ 3] 3462         beq     L9DE8  
   9DDE 96 76         [ 3] 3463         ldaa    (0x0076)
   9DE0 26 06         [ 3] 3464         bne     L9DE8  
   9DE2 BD 9E 73      [ 6] 3465         jsr     L9E73
   9DE5 BD 9E CC      [ 6] 3466         jsr     L9ECC
   9DE8                    3467 L9DE8:
   9DE8 0C            [ 2] 3468         clc
   9DE9 39            [ 5] 3469         rts
                           3470 
   9DEA                    3471 L9DEA:
   9DEA FC 04 20      [ 5] 3472         ldd     (0x0420)
   9DED C3 00 01      [ 4] 3473         addd    #0x0001
   9DF0 FD 04 20      [ 5] 3474         std     (0x0420)
   9DF3 0D            [ 2] 3475         sec
   9DF4 39            [ 5] 3476         rts
                           3477 
   9DF5                    3478 L9DF5:
   9DF5 B6 02 99      [ 4] 3479         ldaa    (0x0299)
   9DF8 81 39         [ 2] 3480         cmpa    #0x39
   9DFA 27 6C         [ 3] 3481         beq     L9E68  
   9DFC CE 00 A8      [ 3] 3482         ldx     #0x00A8
   9DFF                    3483 L9DFF:
   9DFF BD 9B 19      [ 6] 3484         jsr     L9B19   
   9E02 96 4A         [ 3] 3485         ldaa    (0x004A)
   9E04 27 F9         [ 3] 3486         beq     L9DFF  
   9E06 7F 00 4A      [ 6] 3487         clr     (0x004A)
   9E09 A7 00         [ 4] 3488         staa    0,X     
   9E0B 08            [ 3] 3489         inx
   9E0C 8C 00 AA      [ 4] 3490         cpx     #0x00AA
   9E0F 26 EE         [ 3] 3491         bne     L9DFF  
   9E11 BD 9E FA      [ 6] 3492         jsr     L9EFA
   9E14 CE 02 99      [ 3] 3493         ldx     #0x0299
   9E17 7F 00 13      [ 6] 3494         clr     (0x0013)
   9E1A                    3495 L9E1A:
   9E1A A6 00         [ 4] 3496         ldaa    0,X     
   9E1C 9B 13         [ 3] 3497         adda    (0x0013)
   9E1E 97 13         [ 3] 3498         staa    (0x0013)
   9E20 08            [ 3] 3499         inx
   9E21 8C 02 9C      [ 4] 3500         cpx     #0x029C
   9E24 26 F4         [ 3] 3501         bne     L9E1A  
   9E26 91 A8         [ 3] 3502         cmpa    (0x00A8)
   9E28 26 47         [ 3] 3503         bne     L9E71  
   9E2A CE 04 02      [ 3] 3504         ldx     #0x0402
   9E2D B6 02 98      [ 4] 3505         ldaa    (0x0298)
   9E30 81 02         [ 2] 3506         cmpa    #0x02
   9E32 26 03         [ 3] 3507         bne     L9E37  
   9E34 CE 04 05      [ 3] 3508         ldx     #0x0405
   9E37                    3509 L9E37:
   9E37 3C            [ 4] 3510         pshx
   9E38 BD AB 56      [ 6] 3511         jsr     LAB56
   9E3B 38            [ 5] 3512         pulx
   9E3C 25 07         [ 3] 3513         bcs     L9E45  
   9E3E 86 03         [ 2] 3514         ldaa    #0x03
   9E40 B7 02 98      [ 4] 3515         staa    (0x0298)
   9E43 20 23         [ 3] 3516         bra     L9E68  
   9E45                    3517 L9E45:
   9E45 B6 02 99      [ 4] 3518         ldaa    (0x0299)
   9E48 A1 00         [ 4] 3519         cmpa    0,X     
   9E4A 25 1E         [ 3] 3520         bcs     L9E6A  
   9E4C 27 02         [ 3] 3521         beq     L9E50  
   9E4E 24 18         [ 3] 3522         bcc     L9E68  
   9E50                    3523 L9E50:
   9E50 08            [ 3] 3524         inx
   9E51 B6 02 9A      [ 4] 3525         ldaa    (0x029A)
   9E54 A1 00         [ 4] 3526         cmpa    0,X     
   9E56 25 12         [ 3] 3527         bcs     L9E6A  
   9E58 27 02         [ 3] 3528         beq     L9E5C  
   9E5A 24 0C         [ 3] 3529         bcc     L9E68  
   9E5C                    3530 L9E5C:
   9E5C 08            [ 3] 3531         inx
   9E5D B6 02 9B      [ 4] 3532         ldaa    (0x029B)
   9E60 A1 00         [ 4] 3533         cmpa    0,X     
   9E62 25 06         [ 3] 3534         bcs     L9E6A  
   9E64 27 02         [ 3] 3535         beq     L9E68  
   9E66 24 00         [ 3] 3536         bcc     L9E68  
   9E68                    3537 L9E68:
   9E68 0C            [ 2] 3538         clc
   9E69 39            [ 5] 3539         rts
                           3540 
   9E6A                    3541 L9E6A:
   9E6A B6 02 98      [ 4] 3542         ldaa    (0x0298)
   9E6D 81 03         [ 2] 3543         cmpa    #0x03
   9E6F 27 F7         [ 3] 3544         beq     L9E68  
   9E71                    3545 L9E71:
   9E71 0D            [ 2] 3546         sec
   9E72 39            [ 5] 3547         rts
                           3548 
   9E73                    3549 L9E73:
   9E73 CE 04 02      [ 3] 3550         ldx     #0x0402
   9E76 B6 02 98      [ 4] 3551         ldaa    (0x0298)
   9E79 81 02         [ 2] 3552         cmpa    #0x02
   9E7B 26 03         [ 3] 3553         bne     L9E80  
   9E7D CE 04 05      [ 3] 3554         ldx     #0x0405
   9E80                    3555 L9E80:
   9E80 B6 02 99      [ 4] 3556         ldaa    (0x0299)
   9E83 A7 00         [ 4] 3557         staa    0,X     
   9E85 08            [ 3] 3558         inx
   9E86 B6 02 9A      [ 4] 3559         ldaa    (0x029A)
   9E89 A7 00         [ 4] 3560         staa    0,X     
   9E8B 08            [ 3] 3561         inx
   9E8C B6 02 9B      [ 4] 3562         ldaa    (0x029B)
   9E8F A7 00         [ 4] 3563         staa    0,X     
   9E91 39            [ 5] 3564         rts
                           3565 
                           3566 ; reset R counts
   9E92                    3567 L9E92:
   9E92 86 30         [ 2] 3568         ldaa    #0x30        
   9E94 B7 04 02      [ 4] 3569         staa    (0x0402)
   9E97 B7 04 03      [ 4] 3570         staa    (0x0403)
   9E9A B7 04 04      [ 4] 3571         staa    (0x0404)
                           3572 
   9E9D BD 8D DD      [ 6] 3573         jsr     LCDMSG2 
   9EA0 52 65 67 20 23 20  3574         .ascis  'Reg # cleared!'
        63 6C 65 61 72 65
        64 A1
                           3575 
   9EAE 39            [ 5] 3576         rts
                           3577 
                           3578 ; reset L counts
   9EAF                    3579 L9EAF:
   9EAF 86 30         [ 2] 3580         ldaa    #0x30
   9EB1 B7 04 05      [ 4] 3581         staa    (0x0405)
   9EB4 B7 04 06      [ 4] 3582         staa    (0x0406)
   9EB7 B7 04 07      [ 4] 3583         staa    (0x0407)
                           3584 
   9EBA BD 8D DD      [ 6] 3585         jsr     LCDMSG2 
   9EBD 4C 69 76 20 23 20  3586         .ascis  'Liv # cleared!'
        63 6C 65 61 72 65
        64 A1
                           3587 
   9ECB 39            [ 5] 3588         rts
                           3589 
                           3590 ; display R and L counts?
   9ECC                    3591 L9ECC:
   9ECC 86 52         [ 2] 3592         ldaa    #0x52            ;'R'
   9ECE C6 2B         [ 2] 3593         ldab    #0x2B
   9ED0 BD 8D B5      [ 6] 3594         jsr     L8DB5            ; display char here on LCD display
   9ED3 86 4C         [ 2] 3595         ldaa    #0x4C            ;'L'
   9ED5 C6 32         [ 2] 3596         ldab    #0x32
   9ED7 BD 8D B5      [ 6] 3597         jsr     L8DB5            ; display char here on LCD display
   9EDA CE 04 02      [ 3] 3598         ldx     #0x0402
   9EDD C6 2C         [ 2] 3599         ldab    #0x2C
   9EDF                    3600 L9EDF:
   9EDF A6 00         [ 4] 3601         ldaa    0,X     
   9EE1 BD 8D B5      [ 6] 3602         jsr     L8DB5            ; display 3 chars here on LCD display
   9EE4 5C            [ 2] 3603         incb
   9EE5 08            [ 3] 3604         inx
   9EE6 8C 04 05      [ 4] 3605         cpx     #0x0405
   9EE9 26 F4         [ 3] 3606         bne     L9EDF  
   9EEB C6 33         [ 2] 3607         ldab    #0x33
   9EED                    3608 L9EED:
   9EED A6 00         [ 4] 3609         ldaa    0,X     
   9EEF BD 8D B5      [ 6] 3610         jsr     L8DB5            ; display 3 chars here on LCD display
   9EF2 5C            [ 2] 3611         incb
   9EF3 08            [ 3] 3612         inx
   9EF4 8C 04 08      [ 4] 3613         cpx     #0x0408
   9EF7 26 F4         [ 3] 3614         bne     L9EED  
   9EF9 39            [ 5] 3615         rts
                           3616 
   9EFA                    3617 L9EFA:
   9EFA 96 A8         [ 3] 3618         ldaa    (0x00A8)
   9EFC BD 9F 0F      [ 6] 3619         jsr     L9F0F
   9EFF 48            [ 2] 3620         asla
   9F00 48            [ 2] 3621         asla
   9F01 48            [ 2] 3622         asla
   9F02 48            [ 2] 3623         asla
   9F03 97 13         [ 3] 3624         staa    (0x0013)
   9F05 96 A9         [ 3] 3625         ldaa    (0x00A9)
   9F07 BD 9F 0F      [ 6] 3626         jsr     L9F0F
   9F0A 9B 13         [ 3] 3627         adda    (0x0013)
   9F0C 97 A8         [ 3] 3628         staa    (0x00A8)
   9F0E 39            [ 5] 3629         rts
                           3630 
   9F0F                    3631 L9F0F:
   9F0F 81 2F         [ 2] 3632         cmpa    #0x2F
   9F11 24 02         [ 3] 3633         bcc     L9F15  
   9F13 86 30         [ 2] 3634         ldaa    #0x30
   9F15                    3635 L9F15:
   9F15 81 3A         [ 2] 3636         cmpa    #0x3A
   9F17 25 02         [ 3] 3637         bcs     L9F1B  
   9F19 80 07         [ 2] 3638         suba    #0x07
   9F1B                    3639 L9F1B:
   9F1B 80 30         [ 2] 3640         suba    #0x30
   9F1D 39            [ 5] 3641         rts
                           3642 
   9F1E                    3643 L9F1E:
   9F1E FC 02 9C      [ 5] 3644         ldd     (0x029C)
   9F21 1A 83 00 01   [ 5] 3645         cpd     #0x0001
   9F25 27 0C         [ 3] 3646         beq     L9F33  
   9F27 1A 83 03 E8   [ 5] 3647         cpd     #0x03E8
   9F2B 25 20         [ 3] 3648         bcs     L9F4D  
   9F2D 1A 83 04 4B   [ 5] 3649         cpd     #0x044B
   9F31 22 1A         [ 3] 3650         bhi     L9F4D  
                           3651 
   9F33                    3652 L9F33:
   9F33 BD 8D E4      [ 6] 3653         jsr     LCDMSG1 
   9F36 50 61 73 73 77 6F  3654         .ascis  'Password bypass '
        72 64 20 62 79 70
        61 73 73 A0
                           3655 
   9F46 C6 04         [ 2] 3656         ldab    #0x04
   9F48 BD 8C 30      [ 6] 3657         jsr     DLYSECSBY2           ; delay 2 sec
   9F4B 0C            [ 2] 3658         clc
   9F4C 39            [ 5] 3659         rts
                           3660 
   9F4D                    3661 L9F4D:
   9F4D BD 8C F2      [ 6] 3662         jsr     L8CF2
   9F50 BD 8D 03      [ 6] 3663         jsr     L8D03
                           3664 
   9F53 BD 8D E4      [ 6] 3665         jsr     LCDMSG1 
   9F56 43 6F 64 65 BA     3666         .ascis  'Code:'
                           3667 
   9F5B CE 02 90      [ 3] 3668         ldx     #0x0290
   9F5E 7F 00 16      [ 6] 3669         clr     (0x0016)
   9F61                    3670 L9F61:
   9F61 86 41         [ 2] 3671         ldaa    #0x41
   9F63                    3672 L9F63:
   9F63 97 15         [ 3] 3673         staa    (0x0015)
   9F65 BD 8E 95      [ 6] 3674         jsr     L8E95
   9F68 81 0D         [ 2] 3675         cmpa    #0x0D
   9F6A 26 11         [ 3] 3676         bne     L9F7D  
   9F6C 96 15         [ 3] 3677         ldaa    (0x0015)
   9F6E A7 00         [ 4] 3678         staa    0,X     
   9F70 08            [ 3] 3679         inx
   9F71 BD 8C 98      [ 6] 3680         jsr     L8C98
   9F74 96 16         [ 3] 3681         ldaa    (0x0016)
   9F76 4C            [ 2] 3682         inca
   9F77 97 16         [ 3] 3683         staa    (0x0016)
   9F79 81 05         [ 2] 3684         cmpa    #0x05
   9F7B 27 09         [ 3] 3685         beq     L9F86  
   9F7D                    3686 L9F7D:
   9F7D 96 15         [ 3] 3687         ldaa    (0x0015)
   9F7F 4C            [ 2] 3688         inca
   9F80 81 5B         [ 2] 3689         cmpa    #0x5B
   9F82 27 DD         [ 3] 3690         beq     L9F61  
   9F84 20 DD         [ 3] 3691         bra     L9F63  
                           3692 
   9F86                    3693 L9F86:
   9F86 BD 8D DD      [ 6] 3694         jsr     LCDMSG2 
   9F89 50 73 77 64 BA     3695         .ascis  'Pswd:'
                           3696 
   9F8E CE 02 88      [ 3] 3697         ldx     #0x0288
   9F91 86 41         [ 2] 3698         ldaa    #0x41
   9F93 97 16         [ 3] 3699         staa    (0x0016)
   9F95 86 C5         [ 2] 3700         ldaa    #0xC5
   9F97 97 15         [ 3] 3701         staa    (0x0015)
   9F99                    3702 L9F99:
   9F99 96 15         [ 3] 3703         ldaa    (0x0015)
   9F9B BD 8C 86      [ 6] 3704         jsr     L8C86        ; write byte to LCD
   9F9E 96 16         [ 3] 3705         ldaa    (0x0016)
   9FA0 BD 8C 98      [ 6] 3706         jsr     L8C98
   9FA3                    3707 L9FA3:
   9FA3 BD 8E 95      [ 6] 3708         jsr     L8E95
   9FA6 27 FB         [ 3] 3709         beq     L9FA3  
   9FA8 81 0D         [ 2] 3710         cmpa    #0x0D
   9FAA 26 10         [ 3] 3711         bne     L9FBC  
   9FAC 96 16         [ 3] 3712         ldaa    (0x0016)
   9FAE A7 00         [ 4] 3713         staa    0,X     
   9FB0 08            [ 3] 3714         inx
   9FB1 96 15         [ 3] 3715         ldaa    (0x0015)
   9FB3 4C            [ 2] 3716         inca
   9FB4 97 15         [ 3] 3717         staa    (0x0015)
   9FB6 81 CA         [ 2] 3718         cmpa    #0xCA
   9FB8 27 28         [ 3] 3719         beq     L9FE2  
   9FBA 20 DD         [ 3] 3720         bra     L9F99  
   9FBC                    3721 L9FBC:
   9FBC 81 01         [ 2] 3722         cmpa    #0x01
   9FBE 26 0F         [ 3] 3723         bne     L9FCF  
   9FC0 96 16         [ 3] 3724         ldaa    (0x0016)
   9FC2 4C            [ 2] 3725         inca
   9FC3 97 16         [ 3] 3726         staa    (0x0016)
   9FC5 81 5B         [ 2] 3727         cmpa    #0x5B
   9FC7 26 D0         [ 3] 3728         bne     L9F99  
   9FC9 86 41         [ 2] 3729         ldaa    #0x41
   9FCB 97 16         [ 3] 3730         staa    (0x0016)
   9FCD 20 CA         [ 3] 3731         bra     L9F99  
   9FCF                    3732 L9FCF:
   9FCF 81 02         [ 2] 3733         cmpa    #0x02
   9FD1 26 D0         [ 3] 3734         bne     L9FA3  
   9FD3 96 16         [ 3] 3735         ldaa    (0x0016)
   9FD5 4A            [ 2] 3736         deca
   9FD6 97 16         [ 3] 3737         staa    (0x0016)
   9FD8 81 40         [ 2] 3738         cmpa    #0x40
   9FDA 26 BD         [ 3] 3739         bne     L9F99  
   9FDC 86 5A         [ 2] 3740         ldaa    #0x5A
   9FDE 97 16         [ 3] 3741         staa    (0x0016)
   9FE0 20 B7         [ 3] 3742         bra     L9F99  
   9FE2                    3743 L9FE2:
   9FE2 BD A0 01      [ 6] 3744         jsr     LA001
   9FE5 25 0F         [ 3] 3745         bcs     L9FF6  
   9FE7 86 DB         [ 2] 3746         ldaa    #0xDB
   9FE9 97 AB         [ 3] 3747         staa    (0x00AB)
   9FEB FC 04 16      [ 5] 3748         ldd     (0x0416)
   9FEE C3 00 01      [ 4] 3749         addd    #0x0001
   9FF1 FD 04 16      [ 5] 3750         std     (0x0416)
   9FF4 0C            [ 2] 3751         clc
   9FF5 39            [ 5] 3752         rts
                           3753 
   9FF6                    3754 L9FF6:
   9FF6 FC 04 14      [ 5] 3755         ldd     (0x0414)
   9FF9 C3 00 01      [ 4] 3756         addd    #0x0001
   9FFC FD 04 14      [ 5] 3757         std     (0x0414)
   9FFF 0D            [ 2] 3758         sec
   A000 39            [ 5] 3759         rts
                           3760 
   A001                    3761 LA001:
   A001 B6 02 90      [ 4] 3762         ldaa    (0x0290)
   A004 B7 02 81      [ 4] 3763         staa    (0x0281)
   A007 B6 02 91      [ 4] 3764         ldaa    (0x0291)
   A00A B7 02 83      [ 4] 3765         staa    (0x0283)
   A00D B6 02 92      [ 4] 3766         ldaa    (0x0292)
   A010 B7 02 84      [ 4] 3767         staa    (0x0284)
   A013 B6 02 93      [ 4] 3768         ldaa    (0x0293)
   A016 B7 02 80      [ 4] 3769         staa    (0x0280)
   A019 B6 02 94      [ 4] 3770         ldaa    (0x0294)
   A01C B7 02 82      [ 4] 3771         staa    (0x0282)
   A01F B6 02 80      [ 4] 3772         ldaa    (0x0280)
   A022 88 13         [ 2] 3773         eora    #0x13
   A024 8B 03         [ 2] 3774         adda    #0x03
   A026 B7 02 80      [ 4] 3775         staa    (0x0280)
   A029 B6 02 81      [ 4] 3776         ldaa    (0x0281)
   A02C 88 04         [ 2] 3777         eora    #0x04
   A02E 8B 12         [ 2] 3778         adda    #0x12
   A030 B7 02 81      [ 4] 3779         staa    (0x0281)
   A033 B6 02 82      [ 4] 3780         ldaa    (0x0282)
   A036 88 06         [ 2] 3781         eora    #0x06
   A038 8B 04         [ 2] 3782         adda    #0x04
   A03A B7 02 82      [ 4] 3783         staa    (0x0282)
   A03D B6 02 83      [ 4] 3784         ldaa    (0x0283)
   A040 88 11         [ 2] 3785         eora    #0x11
   A042 8B 07         [ 2] 3786         adda    #0x07
   A044 B7 02 83      [ 4] 3787         staa    (0x0283)
   A047 B6 02 84      [ 4] 3788         ldaa    (0x0284)
   A04A 88 01         [ 2] 3789         eora    #0x01
   A04C 8B 10         [ 2] 3790         adda    #0x10
   A04E B7 02 84      [ 4] 3791         staa    (0x0284)
   A051 BD A0 AF      [ 6] 3792         jsr     LA0AF
   A054 B6 02 94      [ 4] 3793         ldaa    (0x0294)
   A057 84 17         [ 2] 3794         anda    #0x17
   A059 97 15         [ 3] 3795         staa    (0x0015)
   A05B B6 02 90      [ 4] 3796         ldaa    (0x0290)
   A05E 84 17         [ 2] 3797         anda    #0x17
   A060 97 16         [ 3] 3798         staa    (0x0016)
   A062 CE 02 80      [ 3] 3799         ldx     #0x0280
   A065                    3800 LA065:
   A065 A6 00         [ 4] 3801         ldaa    0,X     
   A067 98 15         [ 3] 3802         eora    (0x0015)
   A069 98 16         [ 3] 3803         eora    (0x0016)
   A06B A7 00         [ 4] 3804         staa    0,X     
   A06D 08            [ 3] 3805         inx
   A06E 8C 02 85      [ 4] 3806         cpx     #0x0285
   A071 26 F2         [ 3] 3807         bne     LA065  
   A073 BD A0 AF      [ 6] 3808         jsr     LA0AF
   A076 CE 02 80      [ 3] 3809         ldx     #0x0280
   A079 18 CE 02 88   [ 4] 3810         ldy     #0x0288
   A07D                    3811 LA07D:
   A07D A6 00         [ 4] 3812         ldaa    0,X     
   A07F 18 A1 00      [ 5] 3813         cmpa    0,Y     
   A082 26 0A         [ 3] 3814         bne     LA08E  
   A084 08            [ 3] 3815         inx
   A085 18 08         [ 4] 3816         iny
   A087 8C 02 85      [ 4] 3817         cpx     #0x0285
   A08A 26 F1         [ 3] 3818         bne     LA07D  
   A08C 0C            [ 2] 3819         clc
   A08D 39            [ 5] 3820         rts
                           3821 
   A08E                    3822 LA08E:
   A08E 0D            [ 2] 3823         sec
   A08F 39            [ 5] 3824         rts
                           3825 
   A090                    3826 LA090:
   A090 59 41 44 44 41     3827         .ascii  'YADDA'
                           3828 
   A095 CE 02 88      [ 3] 3829         ldx     #0x0288
   A098 18 CE A0 90   [ 4] 3830         ldy     #LA090
   A09C                    3831 LA09C:
   A09C A6 00         [ 4] 3832         ldaa    0,X
   A09E 18 A1 00      [ 5] 3833         cmpa    0,Y
   A0A1 26 0A         [ 3] 3834         bne     LA0AD
   A0A3 08            [ 3] 3835         inx
   A0A4 18 08         [ 4] 3836         iny
   A0A6 8C 02 8D      [ 4] 3837         cpx     #0x028D
   A0A9 26 F1         [ 3] 3838         bne     LA09C
   A0AB 0C            [ 2] 3839         clc
   A0AC 39            [ 5] 3840         rts
   A0AD                    3841 LA0AD:
   A0AD 0D            [ 2] 3842         sec
   A0AE 39            [ 5] 3843         rts
                           3844 
   A0AF                    3845 LA0AF:
   A0AF CE 02 80      [ 3] 3846         ldx     #0x0280
   A0B2                    3847 LA0B2:
   A0B2 A6 00         [ 4] 3848         ldaa    0,X     
   A0B4 81 5B         [ 2] 3849         cmpa    #0x5B
   A0B6 25 06         [ 3] 3850         bcs     LA0BE  
   A0B8 80 1A         [ 2] 3851         suba    #0x1A
   A0BA A7 00         [ 4] 3852         staa    0,X     
   A0BC 20 08         [ 3] 3853         bra     LA0C6  
   A0BE                    3854 LA0BE:
   A0BE 81 41         [ 2] 3855         cmpa    #0x41
   A0C0 24 04         [ 3] 3856         bcc     LA0C6  
   A0C2 8B 1A         [ 2] 3857         adda    #0x1A
   A0C4 A7 00         [ 4] 3858         staa    0,X     
   A0C6                    3859 LA0C6:
   A0C6 08            [ 3] 3860         inx
   A0C7 8C 02 85      [ 4] 3861         cpx     #0x0285
   A0CA 26 E6         [ 3] 3862         bne     LA0B2  
   A0CC 39            [ 5] 3863         rts
                           3864 
   A0CD BD 8C F2      [ 6] 3865         jsr     L8CF2
                           3866 
   A0D0 BD 8D DD      [ 6] 3867         jsr     LCDMSG2 
   A0D3 46 61 69 6C 65 64  3868         .ascis  'Failed!         '
        21 20 20 20 20 20
        20 20 20 A0
                           3869 
   A0E3 C6 02         [ 2] 3870         ldab    #0x02
   A0E5 BD 8C 30      [ 6] 3871         jsr     DLYSECSBY2           ; delay 1 sec
   A0E8 39            [ 5] 3872         rts
                           3873 
   A0E9                    3874 LA0E9:
   A0E9 C6 01         [ 2] 3875         ldab    #0x01
   A0EB BD 8C 30      [ 6] 3876         jsr     DLYSECSBY2           ; delay 0.5 sec
   A0EE 7F 00 4E      [ 6] 3877         clr     (0x004E)
   A0F1 C6 D3         [ 2] 3878         ldab    #0xD3
   A0F3 BD 87 48      [ 6] 3879         jsr     L8748   
   A0F6 BD 87 AE      [ 6] 3880         jsr     L87AE
   A0F9 BD 8C E9      [ 6] 3881         jsr     L8CE9
                           3882 
   A0FC BD 8D E4      [ 6] 3883         jsr     LCDMSG1 
   A0FF 20 20 20 56 43 52  3884         .ascis  '   VCR adjust'
        20 61 64 6A 75 73
        F4
                           3885 
   A10C BD 8D DD      [ 6] 3886         jsr     LCDMSG2 
   A10F 55 50 20 74 6F 20  3887         .ascis  'UP to clear bits'
        63 6C 65 61 72 20
        62 69 74 F3
                           3888 
   A11F 5F            [ 2] 3889         clrb
   A120 D7 62         [ 3] 3890         stab    (0x0062)
   A122 BD F9 C5      [ 6] 3891         jsr     BUTNLIT 
   A125 B6 18 04      [ 4] 3892         ldaa    PIA0PRA 
   A128 84 BF         [ 2] 3893         anda    #0xBF
   A12A B7 18 04      [ 4] 3894         staa    PIA0PRA 
   A12D BD 8E 95      [ 6] 3895         jsr     L8E95
   A130 7F 00 48      [ 6] 3896         clr     (0x0048)
   A133 7F 00 49      [ 6] 3897         clr     (0x0049)
   A136 BD 86 C4      [ 6] 3898         jsr     L86C4
   A139 86 28         [ 2] 3899         ldaa    #0x28
   A13B 97 63         [ 3] 3900         staa    (0x0063)
   A13D C6 FD         [ 2] 3901         ldab    #0xFD
   A13F BD 86 E7      [ 6] 3902         jsr     L86E7
   A142 BD A3 2E      [ 6] 3903         jsr     LA32E
   A145 7C 00 76      [ 6] 3904         inc     (0x0076)
   A148 7F 00 32      [ 6] 3905         clr     (0x0032)
   A14B                    3906 LA14B:
   A14B BD 8E 95      [ 6] 3907         jsr     L8E95
   A14E 81 0D         [ 2] 3908         cmpa    #0x0D
   A150 26 03         [ 3] 3909         bne     LA155  
   A152 7E A1 C4      [ 3] 3910         jmp     LA1C4
   A155                    3911 LA155:
   A155 86 28         [ 2] 3912         ldaa    #0x28
   A157 97 63         [ 3] 3913         staa    (0x0063)
   A159 BD 86 A4      [ 6] 3914         jsr     L86A4
   A15C 25 ED         [ 3] 3915         bcs     LA14B  
   A15E FC 04 1A      [ 5] 3916         ldd     (0x041A)
   A161 C3 00 01      [ 4] 3917         addd    #0x0001
   A164 FD 04 1A      [ 5] 3918         std     (0x041A)
   A167 BD 86 C4      [ 6] 3919         jsr     L86C4
   A16A 7C 00 4E      [ 6] 3920         inc     (0x004E)
   A16D C6 D3         [ 2] 3921         ldab    #0xD3
   A16F BD 87 48      [ 6] 3922         jsr     L8748   
   A172 BD 87 AE      [ 6] 3923         jsr     L87AE
   A175                    3924 LA175:
   A175 96 49         [ 3] 3925         ldaa    (0x0049)
   A177 81 43         [ 2] 3926         cmpa    #0x43
   A179 26 06         [ 3] 3927         bne     LA181  
   A17B 7F 00 49      [ 6] 3928         clr     (0x0049)
   A17E 7F 00 48      [ 6] 3929         clr     (0x0048)
   A181                    3930 LA181:
   A181 96 48         [ 3] 3931         ldaa    (0x0048)
   A183 81 C8         [ 2] 3932         cmpa    #0xC8
   A185 25 1F         [ 3] 3933         bcs     LA1A6  
   A187 FC 02 9C      [ 5] 3934         ldd     (0x029C)
   A18A 1A 83 00 01   [ 5] 3935         cpd     #0x0001
   A18E 27 16         [ 3] 3936         beq     LA1A6  
   A190 C6 EF         [ 2] 3937         ldab    #0xEF
   A192 BD 86 E7      [ 6] 3938         jsr     L86E7
   A195 BD 86 C4      [ 6] 3939         jsr     L86C4
   A198 7F 00 4E      [ 6] 3940         clr     (0x004E)
   A19B 7F 00 76      [ 6] 3941         clr     (0x0076)
   A19E C6 0A         [ 2] 3942         ldab    #0x0A
   A1A0 BD 8C 30      [ 6] 3943         jsr     DLYSECSBY2           ; delay 5 sec
   A1A3 7E 81 D7      [ 3] 3944         jmp     L81D7
   A1A6                    3945 LA1A6:
   A1A6 BD 8E 95      [ 6] 3946         jsr     L8E95
   A1A9 81 01         [ 2] 3947         cmpa    #0x01
   A1AB 26 10         [ 3] 3948         bne     LA1BD  
   A1AD CE 10 80      [ 3] 3949         ldx     #0x1080
   A1B0 86 34         [ 2] 3950         ldaa    #0x34
   A1B2                    3951 LA1B2:
   A1B2 6F 00         [ 6] 3952         clr     0,X     
   A1B4 A7 01         [ 4] 3953         staa    1,X     
   A1B6 08            [ 3] 3954         inx
   A1B7 08            [ 3] 3955         inx
   A1B8 8C 10 A0      [ 4] 3956         cpx     #0x10A0
   A1BB 25 F5         [ 3] 3957         bcs     LA1B2  
   A1BD                    3958 LA1BD:
   A1BD 81 0D         [ 2] 3959         cmpa    #0x0D
   A1BF 27 03         [ 3] 3960         beq     LA1C4  
   A1C1 7E A1 75      [ 3] 3961         jmp     LA175
   A1C4                    3962 LA1C4:
   A1C4 7F 00 76      [ 6] 3963         clr     (0x0076)
   A1C7 7F 00 4E      [ 6] 3964         clr     (0x004E)
   A1CA C6 DF         [ 2] 3965         ldab    #0xDF
   A1CC BD 87 48      [ 6] 3966         jsr     L8748   
   A1CF BD 87 91      [ 6] 3967         jsr     L8791   
   A1D2 7E 81 D7      [ 3] 3968         jmp     L81D7
                           3969 
   A1D5                    3970 LA1D5:
   A1D5 86 07         [ 2] 3971         ldaa    #0x07
   A1D7 B7 04 00      [ 4] 3972         staa    (0x0400)
   A1DA CC 0E 09      [ 3] 3973         ldd     #0x0E09
   A1DD 81 65         [ 2] 3974         cmpa    #0x65
   A1DF 26 05         [ 3] 3975         bne     LA1E6  
   A1E1 C1 63         [ 2] 3976         cmpb    #0x63
   A1E3 26 01         [ 3] 3977         bne     LA1E6  
   A1E5 39            [ 5] 3978         rts
                           3979 
   A1E6                    3980 LA1E6:
   A1E6 86 0E         [ 2] 3981         ldaa    #0x0E
   A1E8 B7 10 3B      [ 4] 3982         staa    PPROG  
   A1EB 86 FF         [ 2] 3983         ldaa    #0xFF
   A1ED B7 0E 00      [ 4] 3984         staa    (0x0E00)
   A1F0 B6 10 3B      [ 4] 3985         ldaa    PPROG  
   A1F3 8A 01         [ 2] 3986         oraa    #0x01
   A1F5 B7 10 3B      [ 4] 3987         staa    PPROG  
   A1F8 CE 1B 58      [ 3] 3988         ldx     #0x1B58
   A1FB                    3989 LA1FB:
   A1FB 09            [ 3] 3990         dex
   A1FC 26 FD         [ 3] 3991         bne     LA1FB  
   A1FE B6 10 3B      [ 4] 3992         ldaa    PPROG  
   A201 84 FE         [ 2] 3993         anda    #0xFE
   A203 B7 10 3B      [ 4] 3994         staa    PPROG  
   A206 CE 0E 00      [ 3] 3995         ldx     #0x0E00
   A209 18 CE A2 26   [ 4] 3996         ldy     #LA226
   A20D                    3997 LA20D:
   A20D C6 02         [ 2] 3998         ldab    #0x02
   A20F F7 10 3B      [ 4] 3999         stab    PPROG  
   A212 18 A6 00      [ 5] 4000         ldaa    0,Y     
   A215 18 08         [ 4] 4001         iny
   A217 A7 00         [ 4] 4002         staa    0,X     
   A219 BD A2 32      [ 6] 4003         jsr     LA232
   A21C 08            [ 3] 4004         inx
   A21D 8C 0E 0C      [ 4] 4005         cpx     #0x0E0C
   A220 26 EB         [ 3] 4006         bne     LA20D  
   A222 7F 10 3B      [ 6] 4007         clr     PPROG  
   A225 39            [ 5] 4008         rts
                           4009 
                           4010 ; initial data for 0x0E00 NVRAM??
   A226                    4011 LA226:
   A226 29 64 2A 21 32 3A  4012         .ascii  ')d*!2::4!ecq'
        3A 34 21 65 63 71
                           4013 
                           4014 ; program EEPROM
   A232                    4015 LA232:
   A232 18 3C         [ 5] 4016         pshy
   A234 C6 03         [ 2] 4017         ldab    #0x03
   A236 F7 10 3B      [ 4] 4018         stab    PPROG       ; start program
   A239 18 CE 1B 58   [ 4] 4019         ldy     #0x1B58
   A23D                    4020 LA23D:
   A23D 18 09         [ 4] 4021         dey
   A23F 26 FC         [ 3] 4022         bne     LA23D  
   A241 C6 02         [ 2] 4023         ldab    #0x02
   A243 F7 10 3B      [ 4] 4024         stab    PPROG       ; stop program
   A246 18 38         [ 6] 4025         puly
   A248 39            [ 5] 4026         rts
                           4027 
   A249                    4028 LA249:
   A249 0F            [ 2] 4029         sei
   A24A CE 00 10      [ 3] 4030         ldx     #0x0010
   A24D                    4031 LA24D:
   A24D 6F 00         [ 6] 4032         clr     0,X     
   A24F 08            [ 3] 4033         inx
   A250 8C 0E 00      [ 4] 4034         cpx     #0x0E00
   A253 26 F8         [ 3] 4035         bne     LA24D  
   A255 BD 9E AF      [ 6] 4036         jsr     L9EAF     ; reset L counts
   A258 BD 9E 92      [ 6] 4037         jsr     L9E92     ; reset R counts
   A25B 7E F8 00      [ 3] 4038         jmp     RESET     ; reset controller
                           4039 
                           4040 ; Compute and store copyright checksum
   A25E                    4041 LA25E:
   A25E 18 CE 80 03   [ 4] 4042         ldy     #CPYRTMSG       ; copyright message
   A262 CE 00 00      [ 3] 4043         ldx     #0x0000
   A265                    4044 LA265:
   A265 18 E6 00      [ 5] 4045         ldab    0,Y
   A268 3A            [ 3] 4046         abx
   A269 18 08         [ 4] 4047         iny
   A26B 18 8C 80 50   [ 5] 4048         cpy     #0x8050
   A26F 26 F4         [ 3] 4049         bne     LA265
   A271 FF 04 0B      [ 5] 4050         stx     CPYRTCS         ; store checksum here
   A274 39            [ 5] 4051         rts
                           4052 
                           4053 ; Erase EEPROM routine
   A275                    4054 LA275:
   A275 0F            [ 2] 4055         sei
   A276 7F 04 0F      [ 6] 4056         clr     ERASEFLG     ; Reset EEPROM Erase flag
   A279 86 0E         [ 2] 4057         ldaa    #0x0E
   A27B B7 10 3B      [ 4] 4058         staa    PPROG       ; ERASE mode!
   A27E 86 FF         [ 2] 4059         ldaa    #0xFF
   A280 B7 0E 20      [ 4] 4060         staa    (0x0E20)    ; save in NVRAM
   A283 B6 10 3B      [ 4] 4061         ldaa    PPROG  
   A286 8A 01         [ 2] 4062         oraa    #0x01
   A288 B7 10 3B      [ 4] 4063         staa    PPROG       ; do the ERASE
   A28B CE 1B 58      [ 3] 4064         ldx     #0x1B58       ; delay a bit
   A28E                    4065 LA28E:
   A28E 09            [ 3] 4066         dex
   A28F 26 FD         [ 3] 4067         bne     LA28E  
   A291 B6 10 3B      [ 4] 4068         ldaa    PPROG  
   A294 84 FE         [ 2] 4069         anda    #0xFE        ; stop erasing
   A296 7F 10 3B      [ 6] 4070         clr     PPROG  
                           4071 
   A299 BD F9 D8      [ 6] 4072         jsr     SERMSGW           ; display "enter serial number"
   A29C 45 6E 74 65 72 20  4073         .ascis  'Enter serial #: '
        73 65 72 69 61 6C
        20 23 3A A0
                           4074 
   A2AC CE 0E 20      [ 3] 4075         ldx     #0x0E20
   A2AF                    4076 LA2AF:
   A2AF BD F9 45      [ 6] 4077         jsr     SERIALR     ; wait for serial data
   A2B2 24 FB         [ 3] 4078         bcc     LA2AF  
                           4079 
   A2B4 BD F9 6F      [ 6] 4080         jsr     SERIALW     ; read serial data
   A2B7 C6 02         [ 2] 4081         ldab    #0x02
   A2B9 F7 10 3B      [ 4] 4082         stab    PPROG       ; protect only 0x0e20-0x0e5f
   A2BC A7 00         [ 4] 4083         staa    0,X         
   A2BE BD A2 32      [ 6] 4084         jsr     LA232       ; program byte
   A2C1 08            [ 3] 4085         inx
   A2C2 8C 0E 24      [ 4] 4086         cpx     #0x0E24
   A2C5 26 E8         [ 3] 4087         bne     LA2AF  
   A2C7 C6 02         [ 2] 4088         ldab    #0x02
   A2C9 F7 10 3B      [ 4] 4089         stab    PPROG  
   A2CC 86 DB         [ 2] 4090         ldaa    #0xDB       ; it's official
   A2CE B7 0E 24      [ 4] 4091         staa    (0x0E24)
   A2D1 BD A2 32      [ 6] 4092         jsr     LA232       ; program byte
   A2D4 7F 10 3B      [ 6] 4093         clr     PPROG  
   A2D7 86 1E         [ 2] 4094         ldaa    #0x1E
   A2D9 B7 10 35      [ 4] 4095         staa    BPROT       ; protect all but 0x0e00-0x0e1f
   A2DC 7E F8 00      [ 3] 4096         jmp     RESET       ; reset controller
                           4097 
   A2DF                    4098 LA2DF:
   A2DF 38            [ 5] 4099         pulx
   A2E0 3C            [ 4] 4100         pshx
   A2E1 8C 80 00      [ 4] 4101         cpx     #0x8000
   A2E4 25 02         [ 3] 4102         bcs     LA2E8  
   A2E6 0C            [ 2] 4103         clc
   A2E7 39            [ 5] 4104         rts
                           4105 
   A2E8                    4106 LA2E8:
   A2E8 0D            [ 2] 4107         sec
   A2E9 39            [ 5] 4108         rts
                           4109 
                           4110 ; enter and validate security code
   A2EA                    4111 LA2EA:
   A2EA CE 02 88      [ 3] 4112         ldx     #0x0288
   A2ED C6 03         [ 2] 4113         ldab    #0x03       ; 3 character code
                           4114 
   A2EF                    4115 LA2EF:
   A2EF BD F9 45      [ 6] 4116         jsr     SERIALR     ; check if available
   A2F2 24 FB         [ 3] 4117         bcc     LA2EF  
   A2F4 A7 00         [ 4] 4118         staa    0,X     
   A2F6 08            [ 3] 4119         inx
   A2F7 5A            [ 2] 4120         decb
   A2F8 26 F5         [ 3] 4121         bne     LA2EF  
                           4122 
   A2FA B6 02 88      [ 4] 4123         ldaa    (0x0288)
   A2FD 81 13         [ 2] 4124         cmpa    #0x13        ; 0x13
   A2FF 26 10         [ 3] 4125         bne     LA311  
   A301 B6 02 89      [ 4] 4126         ldaa    (0x0289)
   A304 81 10         [ 2] 4127         cmpa    #0x10        ; 0x10
   A306 26 09         [ 3] 4128         bne     LA311  
   A308 B6 02 8A      [ 4] 4129         ldaa    (0x028A)
   A30B 81 14         [ 2] 4130         cmpa    #0x14        ; 0x14
   A30D 26 02         [ 3] 4131         bne     LA311  
   A30F 0C            [ 2] 4132         clc
   A310 39            [ 5] 4133         rts
                           4134 
   A311                    4135 LA311:
   A311 0D            [ 2] 4136         sec
   A312 39            [ 5] 4137         rts
                           4138 
   A313                    4139 LA313:
   A313 36            [ 3] 4140         psha
   A314 B6 10 92      [ 4] 4141         ldaa    (0x1092)
   A317 8A 01         [ 2] 4142         oraa    #0x01
   A319                    4143 LA319:
   A319 B7 10 92      [ 4] 4144         staa    (0x1092)
   A31C 32            [ 4] 4145         pula
   A31D 39            [ 5] 4146         rts
                           4147 
   A31E                    4148 LA31E:
   A31E 36            [ 3] 4149         psha
   A31F B6 10 92      [ 4] 4150         ldaa    (0x1092)
   A322 84 FE         [ 2] 4151         anda    #0xFE
   A324 20 F3         [ 3] 4152         bra     LA319
                           4153 
   A326                    4154 LA326:
   A326 96 4E         [ 3] 4155         ldaa    (0x004E)
   A328 97 19         [ 3] 4156         staa    (0x0019)
   A32A 7F 00 4E      [ 6] 4157         clr     (0x004E)
   A32D 39            [ 5] 4158         rts
                           4159 
   A32E                    4160 LA32E:
   A32E B6 10 86      [ 4] 4161         ldaa    (0x1086)
   A331 8A 15         [ 2] 4162         oraa    #0x15
   A333 B7 10 86      [ 4] 4163         staa    (0x1086)
   A336 C6 01         [ 2] 4164         ldab    #0x01
   A338 BD 8C 30      [ 6] 4165         jsr     DLYSECSBY2           ; delay 0.5 sec
   A33B 84 EA         [ 2] 4166         anda    #0xEA
   A33D B7 10 86      [ 4] 4167         staa    (0x1086)
   A340 39            [ 5] 4168         rts
                           4169 
   A341                    4170 LA341:
   A341 B6 10 86      [ 4] 4171         ldaa    (0x1086)
   A344 8A 2A         [ 2] 4172         oraa    #0x2A
   A346 B7 10 86      [ 4] 4173         staa    (0x1086)
   A349 C6 01         [ 2] 4174         ldab    #0x01
   A34B BD 8C 30      [ 6] 4175         jsr     DLYSECSBY2           ; delay 0.5 sec
   A34E 84 D5         [ 2] 4176         anda    #0xD5
   A350 B7 10 86      [ 4] 4177         staa    (0x1086)
   A353 39            [ 5] 4178         rts
                           4179 
   A354                    4180 LA354:
   A354 F6 18 04      [ 4] 4181         ldab    PIA0PRA 
   A357 CA 08         [ 2] 4182         orab    #0x08
   A359 F7 18 04      [ 4] 4183         stab    PIA0PRA 
   A35C 39            [ 5] 4184         rts
                           4185 
   A35D F6 18 04      [ 4] 4186         ldab    PIA0PRA 
   A360 C4 F7         [ 2] 4187         andb    #0xF7
   A362 F7 18 04      [ 4] 4188         stab    PIA0PRA 
   A365 39            [ 5] 4189         rts
                           4190 
                           4191 ;'$' command goes here?
   A366                    4192 LA366:
   A366 7F 00 4E      [ 6] 4193         clr     (0x004E)
   A369 BD 86 C4      [ 6] 4194         jsr     L86C4
   A36C 7F 04 2A      [ 6] 4195         clr     (0x042A)
                           4196 
   A36F BD F9 D8      [ 6] 4197         jsr     SERMSGW      
   A372 45 6E 74 65 72 20  4198         .ascis  'Enter security code:' 
        73 65 63 75 72 69
        74 79 20 63 6F 64
        65 BA
                           4199 
   A386 BD A2 EA      [ 6] 4200         jsr     LA2EA
   A389 24 03         [ 3] 4201         bcc     LA38E  
   A38B 7E 83 31      [ 3] 4202         jmp     L8331
                           4203 
   A38E                    4204 LA38E:
   A38E BD F9 D8      [ 6] 4205         jsr     SERMSGW      
   A391 0C 0A 0D 44 61 76  4206         .ascii  "\f\n\rDave's Setup Utility\n\r"
        65 27 73 20 53 65
        74 75 70 20 55 74
        69 6C 69 74 79 0A
        0D
   A3AA 3C 4B 3E 69 6E 67  4207         .ascii  '<K>ing enable\n\r'
        20 65 6E 61 62 6C
        65 0A 0D
   A3B9 3C 43 3E 6C 65 61  4208         .ascii  '<C>lear random\n\r'
        72 20 72 61 6E 64
        6F 6D 0A 0D
   A3C9 3C 35 3E 20 63 68  4209         .ascii  '<5> character random\n\r'
        61 72 61 63 74 65
        72 20 72 61 6E 64
        6F 6D 0A 0D
   A3DF 3C 4C 3E 69 76 65  4210         .ascii  '<L>ive tape number clear\n\r'
        20 74 61 70 65 20
        6E 75 6D 62 65 72
        20 63 6C 65 61 72
        0A 0D
   A3F9 3C 52 3E 65 67 75  4211         .ascii  '<R>egular tape number clear\n\r'
        6C 61 72 20 74 61
        70 65 20 6E 75 6D
        62 65 72 20 63 6C
        65 61 72 0A 0D
   A416 3C 54 3E 65 73 74  4212         .ascii  '<T>est driver boards\n\r'
        20 64 72 69 76 65
        72 20 62 6F 61 72
        64 73 0A 0D
   A42C 3C 42 3E 75 62 20  4213         .ascii  '<B>ub test\n\r'
        74 65 73 74 0A 0D
   A438 3C 44 3E 65 63 6B  4214         .ascii  '<D>eck test (with tape inserted)\n\r'
        20 74 65 73 74 20
        28 77 69 74 68 20
        74 61 70 65 20 69
        6E 73 65 72 74 65
        64 29 0A 0D
   A45A 3C 37 3E 35 25 20  4215         .ascii  '<7>5% adjustment\n\r'
        61 64 6A 75 73 74
        6D 65 6E 74 0A 0D
   A46C 3C 53 3E 68 6F 77  4216         .ascii  '<S>how re-valid tapes\n\r'
        20 72 65 2D 76 61
        6C 69 64 20 74 61
        70 65 73 0A 0D
   A483 3C 4A 3E 75 6D 70  4217         .ascis  '<J>ump to system\n\r'
        20 74 6F 20 73 79
        73 74 65 6D 0A 8D
                           4218 
   A495                    4219 LA495:
   A495 BD F9 45      [ 6] 4220         jsr     SERIALR     
   A498 24 FB         [ 3] 4221         bcc     LA495  
   A49A 81 43         [ 2] 4222         cmpa    #0x43        ;'C'
   A49C 26 09         [ 3] 4223         bne     LA4A7  
   A49E 7F 04 01      [ 6] 4224         clr     (0x0401)     ;clear random
   A4A1 7F 04 2B      [ 6] 4225         clr     (0x042B)
   A4A4 7E A5 14      [ 3] 4226         jmp     LA514
   A4A7                    4227 LA4A7:
   A4A7 81 35         [ 2] 4228         cmpa    #0x35        ;'5'
   A4A9 26 0D         [ 3] 4229         bne     LA4B8  
   A4AB B6 04 01      [ 4] 4230         ldaa    (0x0401)    ;5 character random
   A4AE 84 7F         [ 2] 4231         anda    #0x7F
   A4B0 8A 7F         [ 2] 4232         oraa    #0x7F
   A4B2 B7 04 01      [ 4] 4233         staa    (0x0401)
   A4B5 7E A5 14      [ 3] 4234         jmp     LA514
   A4B8                    4235 LA4B8:
   A4B8 81 4C         [ 2] 4236         cmpa    #0x4C       ;'L'
   A4BA 26 06         [ 3] 4237         bne     LA4C2
   A4BC BD 9E AF      [ 6] 4238         jsr     L9EAF       ; reset Liv counts
   A4BF 7E A5 14      [ 3] 4239         jmp     LA514
   A4C2                    4240 LA4C2:
   A4C2 81 52         [ 2] 4241         cmpa    #0x52       ;'R'
   A4C4 26 06         [ 3] 4242         bne     LA4CC  
   A4C6 BD 9E 92      [ 6] 4243         jsr     L9E92       ; reset Reg counts
   A4C9 7E A5 14      [ 3] 4244         jmp     LA514
   A4CC                    4245 LA4CC:
   A4CC 81 54         [ 2] 4246         cmpa    #0x54       ;'T'
   A4CE 26 06         [ 3] 4247         bne     LA4D6  
   A4D0 BD A5 65      [ 6] 4248         jsr     LA565       ;test driver boards
   A4D3 7E A5 14      [ 3] 4249         jmp     LA514
   A4D6                    4250 LA4D6:
   A4D6 81 42         [ 2] 4251         cmpa    #0x42       ;'B'
   A4D8 26 06         [ 3] 4252         bne     LA4E0  
   A4DA BD A5 26      [ 6] 4253         jsr     LA526       ;bulb test?
   A4DD 7E A5 14      [ 3] 4254         jmp     LA514
   A4E0                    4255 LA4E0:
   A4E0 81 44         [ 2] 4256         cmpa    #0x44       ;'D'
   A4E2 26 06         [ 3] 4257         bne     LA4EA  
   A4E4 BD A5 3C      [ 6] 4258         jsr     LA53C       ;deck test
   A4E7 7E A5 14      [ 3] 4259         jmp     LA514
   A4EA                    4260 LA4EA:
   A4EA 81 37         [ 2] 4261         cmpa    #0x37       ;'7'
   A4EC 26 08         [ 3] 4262         bne     LA4F6  
   A4EE C6 FB         [ 2] 4263         ldab    #0xFB
   A4F0 BD 86 E7      [ 6] 4264         jsr     L86E7       ;5% adjustment
   A4F3 7E A5 14      [ 3] 4265         jmp     LA514
   A4F6                    4266 LA4F6:
   A4F6 81 4A         [ 2] 4267         cmpa    #0x4A       ;'J'
   A4F8 26 03         [ 3] 4268         bne     LA4FD  
   A4FA 7E F8 00      [ 3] 4269         jmp     RESET       ;jump to system (reset)
   A4FD                    4270 LA4FD:
   A4FD 81 4B         [ 2] 4271         cmpa    #0x4B       ;'K'
   A4FF 26 06         [ 3] 4272         bne     LA507  
   A501 7C 04 2A      [ 6] 4273         inc     (0x042A)    ;King enable
   A504 7E A5 14      [ 3] 4274         jmp     LA514
   A507                    4275 LA507:
   A507 81 53         [ 2] 4276         cmpa    #0x53       ;'S'
   A509 26 06         [ 3] 4277         bne     LA511  
   A50B BD AB 7C      [ 6] 4278         jsr     LAB7C       ;show re-valid tapes
   A50E 7E A5 14      [ 3] 4279         jmp     LA514
   A511                    4280 LA511:
   A511 7E A4 95      [ 3] 4281         jmp     LA495
   A514                    4282 LA514:
   A514 86 07         [ 2] 4283         ldaa    #0x07
   A516 BD F9 6F      [ 6] 4284         jsr     SERIALW      
   A519 C6 01         [ 2] 4285         ldab    #0x01
   A51B BD 8C 30      [ 6] 4286         jsr     DLYSECSBY2  ; delay 0.5 sec
   A51E 86 07         [ 2] 4287         ldaa    #0x07
   A520 BD F9 6F      [ 6] 4288         jsr     SERIALW      
   A523 7E A3 8E      [ 3] 4289         jmp     LA38E
                           4290 
                           4291 ; bulb test
   A526                    4292 LA526:
   A526 5F            [ 2] 4293         clrb
   A527 BD F9 C5      [ 6] 4294         jsr     BUTNLIT 
   A52A                    4295 LA52A:
   A52A F6 10 0A      [ 4] 4296         ldab    PORTE
   A52D C8 FF         [ 2] 4297         eorb    #0xFF
   A52F BD F9 C5      [ 6] 4298         jsr     BUTNLIT 
   A532 C1 80         [ 2] 4299         cmpb    #0x80
   A534 26 F4         [ 3] 4300         bne     LA52A  
   A536 C6 02         [ 2] 4301         ldab    #0x02
   A538 BD 8C 30      [ 6] 4302         jsr     DLYSECSBY2           ; delay 1 sec
   A53B 39            [ 5] 4303         rts
                           4304 
                           4305 ; deck test
   A53C                    4306 LA53C:
   A53C C6 FD         [ 2] 4307         ldab    #0xFD
   A53E BD 86 E7      [ 6] 4308         jsr     L86E7
   A541 C6 06         [ 2] 4309         ldab    #0x06
   A543 BD 8C 30      [ 6] 4310         jsr     DLYSECSBY2           ; delay 3 sec
   A546 C6 FB         [ 2] 4311         ldab    #0xFB
   A548 BD 86 E7      [ 6] 4312         jsr     L86E7
   A54B C6 06         [ 2] 4313         ldab    #0x06
   A54D BD 8C 30      [ 6] 4314         jsr     DLYSECSBY2           ; delay 3 sec
   A550 C6 FD         [ 2] 4315         ldab    #0xFD
   A552 BD 86 E7      [ 6] 4316         jsr     L86E7
   A555 C6 F7         [ 2] 4317         ldab    #0xF7
   A557 BD 86 E7      [ 6] 4318         jsr     L86E7
   A55A C6 06         [ 2] 4319         ldab    #0x06
   A55C BD 8C 30      [ 6] 4320         jsr     DLYSECSBY2           ; delay 3 sec
   A55F C6 EF         [ 2] 4321         ldab    #0xEF
   A561 BD 86 E7      [ 6] 4322         jsr     L86E7
   A564 39            [ 5] 4323         rts
                           4324 
                           4325 ; test driver boards
   A565                    4326 LA565:
   A565 BD F9 45      [ 6] 4327         jsr     SERIALR     
   A568 24 08         [ 3] 4328         bcc     LA572  
   A56A 81 1B         [ 2] 4329         cmpa    #0x1B
   A56C 26 04         [ 3] 4330         bne     LA572  
   A56E BD 86 C4      [ 6] 4331         jsr     L86C4
   A571 39            [ 5] 4332         rts
   A572                    4333 LA572:
   A572 86 08         [ 2] 4334         ldaa    #0x08
   A574 97 15         [ 3] 4335         staa    (0x0015)
   A576 BD 86 C4      [ 6] 4336         jsr     L86C4
   A579 86 01         [ 2] 4337         ldaa    #0x01
   A57B                    4338 LA57B:
   A57B 36            [ 3] 4339         psha
   A57C 16            [ 2] 4340         tab
   A57D BD F9 C5      [ 6] 4341         jsr     BUTNLIT 
   A580 B6 18 04      [ 4] 4342         ldaa    PIA0PRA 
   A583 88 08         [ 2] 4343         eora    #0x08
   A585 B7 18 04      [ 4] 4344         staa    PIA0PRA 
   A588 32            [ 4] 4345         pula
   A589 B7 10 80      [ 4] 4346         staa    (0x1080)
   A58C B7 10 84      [ 4] 4347         staa    (0x1084)
   A58F B7 10 88      [ 4] 4348         staa    (0x1088)
   A592 B7 10 8C      [ 4] 4349         staa    (0x108C)
   A595 B7 10 90      [ 4] 4350         staa    (0x1090)
   A598 B7 10 94      [ 4] 4351         staa    (0x1094)
   A59B B7 10 98      [ 4] 4352         staa    (0x1098)
   A59E B7 10 9C      [ 4] 4353         staa    (0x109C)
   A5A1 C6 14         [ 2] 4354         ldab    #0x14
   A5A3 BD A6 52      [ 6] 4355         jsr     LA652
   A5A6 49            [ 2] 4356         rola
   A5A7 36            [ 3] 4357         psha
   A5A8 D6 15         [ 3] 4358         ldab    (0x0015)
   A5AA 5A            [ 2] 4359         decb
   A5AB D7 15         [ 3] 4360         stab    (0x0015)
   A5AD BD F9 95      [ 6] 4361         jsr     DIAGDGT          ; write digit to the diag display
   A5B0 37            [ 3] 4362         pshb
   A5B1 C6 27         [ 2] 4363         ldab    #0x27
   A5B3 96 15         [ 3] 4364         ldaa    (0x0015)
   A5B5 0C            [ 2] 4365         clc
   A5B6 89 30         [ 2] 4366         adca    #0x30
   A5B8 BD 8D B5      [ 6] 4367         jsr     L8DB5            ; display char here on LCD display
   A5BB 33            [ 4] 4368         pulb
   A5BC 32            [ 4] 4369         pula
   A5BD 5D            [ 2] 4370         tstb
   A5BE 26 BB         [ 3] 4371         bne     LA57B  
   A5C0 86 08         [ 2] 4372         ldaa    #0x08
   A5C2 97 15         [ 3] 4373         staa    (0x0015)
   A5C4 BD 86 C4      [ 6] 4374         jsr     L86C4
   A5C7 86 01         [ 2] 4375         ldaa    #0x01
   A5C9                    4376 LA5C9:
   A5C9 B7 10 82      [ 4] 4377         staa    (0x1082)
   A5CC B7 10 86      [ 4] 4378         staa    (0x1086)
   A5CF B7 10 8A      [ 4] 4379         staa    (0x108A)
   A5D2 B7 10 8E      [ 4] 4380         staa    (0x108E)
   A5D5 B7 10 92      [ 4] 4381         staa    (0x1092)
   A5D8 B7 10 96      [ 4] 4382         staa    (0x1096)
   A5DB B7 10 9A      [ 4] 4383         staa    (0x109A)
   A5DE B7 10 9E      [ 4] 4384         staa    (0x109E)
   A5E1 C6 14         [ 2] 4385         ldab    #0x14
   A5E3 BD A6 52      [ 6] 4386         jsr     LA652
   A5E6 49            [ 2] 4387         rola
   A5E7 36            [ 3] 4388         psha
   A5E8 D6 15         [ 3] 4389         ldab    (0x0015)
   A5EA 5A            [ 2] 4390         decb
   A5EB D7 15         [ 3] 4391         stab    (0x0015)
   A5ED BD F9 95      [ 6] 4392         jsr     DIAGDGT           ; write digit to the diag display
   A5F0 37            [ 3] 4393         pshb
   A5F1 C6 27         [ 2] 4394         ldab    #0x27
   A5F3 96 15         [ 3] 4395         ldaa    (0x0015)
   A5F5 0C            [ 2] 4396         clc
   A5F6 89 30         [ 2] 4397         adca    #0x30
   A5F8 BD 8D B5      [ 6] 4398         jsr     L8DB5            ; display char here on LCD display
   A5FB 33            [ 4] 4399         pulb
   A5FC 32            [ 4] 4400         pula
   A5FD 7D 00 15      [ 6] 4401         tst     (0x0015)
   A600 26 C7         [ 3] 4402         bne     LA5C9  
   A602 BD 86 C4      [ 6] 4403         jsr     L86C4
   A605 CE 10 80      [ 3] 4404         ldx     #0x1080
   A608 C6 00         [ 2] 4405         ldab    #0x00
   A60A                    4406 LA60A:
   A60A 86 FF         [ 2] 4407         ldaa    #0xFF
   A60C A7 00         [ 4] 4408         staa    0,X     
   A60E A7 02         [ 4] 4409         staa    2,X     
   A610 37            [ 3] 4410         pshb
   A611 C6 1E         [ 2] 4411         ldab    #0x1E
   A613 BD A6 52      [ 6] 4412         jsr     LA652
   A616 33            [ 4] 4413         pulb
   A617 86 00         [ 2] 4414         ldaa    #0x00
   A619 A7 00         [ 4] 4415         staa    0,X     
   A61B A7 02         [ 4] 4416         staa    2,X     
   A61D 5C            [ 2] 4417         incb
   A61E 3C            [ 4] 4418         pshx
   A61F BD F9 95      [ 6] 4419         jsr     DIAGDGT               ; write digit to the diag display
   A622 37            [ 3] 4420         pshb
   A623 C6 27         [ 2] 4421         ldab    #0x27
   A625 32            [ 4] 4422         pula
   A626 36            [ 3] 4423         psha
   A627 0C            [ 2] 4424         clc
   A628 89 30         [ 2] 4425         adca    #0x30
   A62A BD 8D B5      [ 6] 4426         jsr     L8DB5            ; display char here on LCD display
   A62D 33            [ 4] 4427         pulb
   A62E 38            [ 5] 4428         pulx
   A62F 08            [ 3] 4429         inx
   A630 08            [ 3] 4430         inx
   A631 08            [ 3] 4431         inx
   A632 08            [ 3] 4432         inx
   A633 8C 10 9D      [ 4] 4433         cpx     #0x109D
   A636 25 D2         [ 3] 4434         bcs     LA60A  
   A638 CE 10 80      [ 3] 4435         ldx     #0x1080
   A63B                    4436 LA63B:
   A63B 86 FF         [ 2] 4437         ldaa    #0xFF
   A63D A7 00         [ 4] 4438         staa    0,X     
   A63F A7 02         [ 4] 4439         staa    2,X     
   A641 08            [ 3] 4440         inx
   A642 08            [ 3] 4441         inx
   A643 08            [ 3] 4442         inx
   A644 08            [ 3] 4443         inx
   A645 8C 10 9D      [ 4] 4444         cpx     #0x109D
   A648 25 F1         [ 3] 4445         bcs     LA63B  
   A64A C6 06         [ 2] 4446         ldab    #0x06
   A64C BD 8C 30      [ 6] 4447         jsr     DLYSECSBY2           ; delay 3 sec
   A64F 7E A5 65      [ 3] 4448         jmp     LA565
   A652                    4449 LA652:
   A652 36            [ 3] 4450         psha
   A653 4F            [ 2] 4451         clra
   A654 DD 23         [ 4] 4452         std     CDTIMR5
   A656                    4453 LA656:
   A656 7D 00 24      [ 6] 4454         tst     CDTIMR5+1
   A659 26 FB         [ 3] 4455         bne     LA656  
   A65B 32            [ 4] 4456         pula
   A65C 39            [ 5] 4457         rts
                           4458 
                           4459 ; Comma-seperated text
   A65D                    4460 LA65D:
   A65D 30 2C 43 68 75 63  4461         .ascii  '0,Chuck,Mouth,'
        6B 2C 4D 6F 75 74
        68 2C
   A66B 31 2C 48 65 61 64  4462         .ascii  '1,Head left,'
        20 6C 65 66 74 2C
   A677 32 2C 48 65 61 64  4463         .ascii  '2,Head right,'
        20 72 69 67 68 74
        2C
   A684 32 2C 48 65 61 64  4464         .ascii  '2,Head up,'
        20 75 70 2C
   A68E 32 2C 45 79 65 73  4465         .ascii  '2,Eyes right,'
        20 72 69 67 68 74
        2C
   A69B 31 2C 45 79 65 6C  4466         .ascii  '1,Eyelids,'
        69 64 73 2C
   A6A5 31 2C 52 69 67 68  4467         .ascii  '1,Right hand,'
        74 20 68 61 6E 64
        2C
   A6B2 32 2C 45 79 65 73  4468         .ascii  '2,Eyes left,'
        20 6C 65 66 74 2C
   A6BE 31 2C 38 2C 48 65  4469         .ascii  '1,8,Helen,Mouth,'
        6C 65 6E 2C 4D 6F
        75 74 68 2C
   A6CE 31 2C 48 65 61 64  4470         .ascii  '1,Head left,'
        20 6C 65 66 74 2C
   A6DA 32 2C 48 65 61 64  4471         .ascii  '2,Head right,'
        20 72 69 67 68 74
        2C
   A6E7 32 2C 48 65 61 64  4472         .ascii  '2,Head up,'
        20 75 70 2C
   A6F1 32 2C 45 79 65 73  4473         .ascii  '2,Eyes right,'
        20 72 69 67 68 74
        2C
   A6FE 31 2C 45 79 65 6C  4474         .ascii  '1,Eyelids,'
        69 64 73 2C
   A708 31 2C 52 69 67 68  4475         .ascii  '1,Right hand,'
        74 20 68 61 6E 64
        2C
   A715 32 2C 45 79 65 73  4476         .ascii  '2,Eyes left,'
        20 6C 65 66 74 2C
   A721 31 2C 36 2C 4D 75  4477         .ascii  '1,6,Munch,Mouth,'
        6E 63 68 2C 4D 6F
        75 74 68 2C
   A731 31 2C 48 65 61 64  4478         .ascii  '1,Head left,'
        20 6C 65 66 74 2C
   A73D 32 2C 48 65 61 64  4479         .ascii  '2,Head right,'
        20 72 69 67 68 74
        2C
   A74A 32 2C 4C 65 66 74  4480         .ascii  '2,Left arm,'
        20 61 72 6D 2C
   A755 32 2C 45 79 65 73  4481         .ascii  '2,Eyes right,'
        20 72 69 67 68 74
        2C
   A762 31 2C 45 79 65 6C  4482         .ascii  '1,Eyelids,'
        69 64 73 2C
   A76C 31 2C 52 69 67 68  4483         .ascii  '1,Right arm,'
        74 20 61 72 6D 2C
   A778 32 2C 45 79 65 73  4484         .ascii  '2,Eyes left,'
        20 6C 65 66 74 2C
   A784 31 2C 32 2C 4A 61  4485         .ascii  '1,2,Jasper,Mouth,'
        73 70 65 72 2C 4D
        6F 75 74 68 2C
   A795 31 2C 48 65 61 64  4486         .ascii  '1,Head left,'
        20 6C 65 66 74 2C
   A7A1 32 2C 48 65 61 64  4487         .ascii  '2,Head right,'
        20 72 69 67 68 74
        2C
   A7AE 32 2C 48 65 61 64  4488         .ascii  '2,Head up,'
        20 75 70 2C
   A7B8 32 2C 45 79 65 73  4489         .ascii  '2,Eyes right,'
        20 72 69 67 68 74
        2C
   A7C5 31 2C 45 79 65 6C  4490         .ascii  '1,Eyelids,'
        69 64 73 2C
   A7CF 31 2C 48 61 6E 64  4491         .ascii  '1,Hands,'
        73 2C
   A7D7 32 2C 45 79 65 73  4492         .ascii  '2,Eyes left,'
        20 6C 65 66 74 2C
   A7E3 31 2C 34 2C 50 61  4493         .ascii  '1,4,Pasqually,Mouth-Mustache,'
        73 71 75 61 6C 6C
        79 2C 4D 6F 75 74
        68 2D 4D 75 73 74
        61 63 68 65 2C
   A800 31 2C 48 65 61 64  4494         .ascii  '1,Head left,'
        20 6C 65 66 74 2C
   A80C 32 2C 48 65 61 64  4495         .ascii  '2,Head right,'
        20 72 69 67 68 74
        2C
   A819 32 2C 4C 65 66 74  4496         .ascii  '2,Left arm,'
        20 61 72 6D 2C
   A824 32 2C 45 79 65 73  4497         .ascii  '2,Eyes right,'
        20 72 69 67 68 74
        2C
   A831 31 2C 45 79 65 6C  4498         .ascii  '1,Eyelids,'
        69 64 73 2C
   A83B 31 2C 52 69 67 68  4499         .ascii  '1,Right arm,'
        74 20 61 72 6D 2C
   A847 32 2C 45 79 65 73  4500         .ascii  '2,Eyes left,1,'
        20 6C 65 66 74 2C
        31 2C
                           4501 
   A855                    4502 LA855:
   A855 3C            [ 4] 4503         pshx
   A856 BD 86 C4      [ 6] 4504         jsr     L86C4
   A859 CE 10 80      [ 3] 4505         ldx     #0x1080
   A85C 86 20         [ 2] 4506         ldaa    #0x20
   A85E A7 00         [ 4] 4507         staa    0,X
   A860 A7 04         [ 4] 4508         staa    4,X
   A862 A7 08         [ 4] 4509         staa    8,X
   A864 A7 0C         [ 4] 4510         staa    12,X
   A866 A7 10         [ 4] 4511         staa    16,X
   A868 38            [ 5] 4512         pulx
   A869 39            [ 5] 4513         rts
                           4514 
   A86A                    4515 LA86A:
   A86A BD A3 2E      [ 6] 4516         jsr     LA32E
                           4517 
   A86D BD 8D E4      [ 6] 4518         jsr     LCDMSG1 
   A870 20 20 20 20 57 61  4519         .ascis  '    Warm-Up  '
        72 6D 2D 55 70 20
        A0
                           4520 
   A87D BD 8D DD      [ 6] 4521         jsr     LCDMSG2 
   A880 43 75 72 74 61 69  4522         .ascis  'Curtains opening'
        6E 73 20 6F 70 65
        6E 69 6E E7
                           4523 
   A890 C6 14         [ 2] 4524         ldab    #0x14
   A892 BD 8C 30      [ 6] 4525         jsr     DLYSECSBY2           ; delay 10 sec
   A895                    4526 LA895:
   A895 BD A8 55      [ 6] 4527         jsr     LA855
   A898 C6 02         [ 2] 4528         ldab    #0x02
   A89A BD 8C 30      [ 6] 4529         jsr     DLYSECSBY2           ; delay 1 sec
   A89D CE A6 5D      [ 3] 4530         ldx     #LA65D
   A8A0 C6 05         [ 2] 4531         ldab    #0x05
   A8A2 D7 12         [ 3] 4532         stab    (0x0012)
   A8A4                    4533 LA8A4:
   A8A4 C6 08         [ 2] 4534         ldab    #0x08
   A8A6 D7 13         [ 3] 4535         stab    (0x0013)
   A8A8 BD A9 41      [ 6] 4536         jsr     LA941
   A8AB BD A9 4C      [ 6] 4537         jsr     LA94C
   A8AE C6 02         [ 2] 4538         ldab    #0x02
   A8B0 BD 8C 30      [ 6] 4539         jsr     DLYSECSBY2           ; delay 1 sec
   A8B3                    4540 LA8B3:
   A8B3 BD A9 5E      [ 6] 4541         jsr     LA95E
   A8B6 A6 00         [ 4] 4542         ldaa    0,X     
   A8B8 80 30         [ 2] 4543         suba    #0x30
   A8BA 08            [ 3] 4544         inx
   A8BB 08            [ 3] 4545         inx
   A8BC 36            [ 3] 4546         psha
   A8BD 7C 00 4C      [ 6] 4547         inc     (0x004C)
   A8C0 3C            [ 4] 4548         pshx
   A8C1 BD 88 E5      [ 6] 4549         jsr     L88E5
   A8C4 38            [ 5] 4550         pulx
   A8C5 86 4F         [ 2] 4551         ldaa    #0x4F            ;'O'
   A8C7 C6 0C         [ 2] 4552         ldab    #0x0C
   A8C9 BD 8D B5      [ 6] 4553         jsr     L8DB5            ; display char here on LCD display
   A8CC 86 6E         [ 2] 4554         ldaa    #0x6E            ;'n'
   A8CE C6 0D         [ 2] 4555         ldab    #0x0D
   A8D0 BD 8D B5      [ 6] 4556         jsr     L8DB5            ; display char here on LCD display
   A8D3 CC 20 0E      [ 3] 4557         ldd     #0x200E           ;' '
   A8D6 BD 8D B5      [ 6] 4558         jsr     L8DB5            ; display char here on LCD display
   A8D9 7A 00 4C      [ 6] 4559         dec     (0x004C)
   A8DC 32            [ 4] 4560         pula
   A8DD 36            [ 3] 4561         psha
   A8DE C6 64         [ 2] 4562         ldab    #0x64
   A8E0 3D            [10] 4563         mul
   A8E1 DD 23         [ 4] 4564         std     CDTIMR5
   A8E3                    4565 LA8E3:
   A8E3 DC 23         [ 4] 4566         ldd     CDTIMR5
   A8E5 26 FC         [ 3] 4567         bne     LA8E3  
   A8E7 BD 8E 95      [ 6] 4568         jsr     L8E95
   A8EA 81 0D         [ 2] 4569         cmpa    #0x0D
   A8EC 26 05         [ 3] 4570         bne     LA8F3  
   A8EE BD A9 75      [ 6] 4571         jsr     LA975
   A8F1 20 10         [ 3] 4572         bra     LA903  
   A8F3                    4573 LA8F3:
   A8F3 81 01         [ 2] 4574         cmpa    #0x01
   A8F5 26 04         [ 3] 4575         bne     LA8FB  
   A8F7 32            [ 4] 4576         pula
   A8F8 7E A8 95      [ 3] 4577         jmp     LA895
   A8FB                    4578 LA8FB:
   A8FB 81 02         [ 2] 4579         cmpa    #0x02
   A8FD 26 04         [ 3] 4580         bne     LA903  
   A8FF 32            [ 4] 4581         pula
   A900 7E A9 35      [ 3] 4582         jmp     LA935
   A903                    4583 LA903:
   A903 3C            [ 4] 4584         pshx
   A904 BD 88 E5      [ 6] 4585         jsr     L88E5
   A907 38            [ 5] 4586         pulx
   A908 86 66         [ 2] 4587         ldaa    #0x66            ;'f'
   A90A C6 0D         [ 2] 4588         ldab    #0x0D
   A90C BD 8D B5      [ 6] 4589         jsr     L8DB5            ; display char here on LCD display
   A90F 86 66         [ 2] 4590         ldaa    #0x66            ;'f'
   A911 C6 0E         [ 2] 4591         ldab    #0x0E
   A913 BD 8D B5      [ 6] 4592         jsr     L8DB5            ; display char here on LCD display
   A916 32            [ 4] 4593         pula
   A917 C6 64         [ 2] 4594         ldab    #0x64
   A919 3D            [10] 4595         mul
   A91A DD 23         [ 4] 4596         std     CDTIMR5
   A91C                    4597 LA91C:
   A91C DC 23         [ 4] 4598         ldd     CDTIMR5
   A91E 26 FC         [ 3] 4599         bne     LA91C  
   A920 BD A8 55      [ 6] 4600         jsr     LA855
   A923 7C 00 4B      [ 6] 4601         inc     (0x004B)
   A926 96 4B         [ 3] 4602         ldaa    (0x004B)
   A928 81 48         [ 2] 4603         cmpa    #0x48
   A92A 25 87         [ 3] 4604         bcs     LA8B3  
   A92C 96 4C         [ 3] 4605         ldaa    (0x004C)
   A92E 81 34         [ 2] 4606         cmpa    #0x34
   A930 27 03         [ 3] 4607         beq     LA935  
   A932 7E A8 A4      [ 3] 4608         jmp     LA8A4
   A935                    4609 LA935:
   A935 C6 02         [ 2] 4610         ldab    #0x02
   A937 BD 8C 30      [ 6] 4611         jsr     DLYSECSBY2           ; delay 1 sec
   A93A BD 86 C4      [ 6] 4612         jsr     L86C4
   A93D BD A3 41      [ 6] 4613         jsr     LA341
   A940 39            [ 5] 4614         rts
                           4615 
   A941                    4616 LA941:
   A941 A6 00         [ 4] 4617         ldaa    0,X     
   A943 08            [ 3] 4618         inx
   A944 08            [ 3] 4619         inx
   A945 97 4C         [ 3] 4620         staa    (0x004C)
   A947 86 40         [ 2] 4621         ldaa    #0x40
   A949 97 4B         [ 3] 4622         staa    (0x004B)
   A94B 39            [ 5] 4623         rts
                           4624 
   A94C                    4625 LA94C:
   A94C BD 8C F2      [ 6] 4626         jsr     L8CF2
   A94F                    4627 LA94F:
   A94F A6 00         [ 4] 4628         ldaa    0,X     
   A951 08            [ 3] 4629         inx
   A952 81 2C         [ 2] 4630         cmpa    #0x2C
   A954 27 07         [ 3] 4631         beq     LA95D  
   A956 36            [ 3] 4632         psha
   A957 BD 8E 70      [ 6] 4633         jsr     L8E70
   A95A 32            [ 4] 4634         pula
   A95B 20 F2         [ 3] 4635         bra     LA94F  
   A95D                    4636 LA95D:
   A95D 39            [ 5] 4637         rts
                           4638 
   A95E                    4639 LA95E:
   A95E BD 8D 03      [ 6] 4640         jsr     L8D03
   A961 86 C0         [ 2] 4641         ldaa    #0xC0
   A963 BD 8E 4B      [ 6] 4642         jsr     L8E4B
   A966                    4643 LA966:
   A966 A6 00         [ 4] 4644         ldaa    0,X     
   A968 08            [ 3] 4645         inx
   A969 81 2C         [ 2] 4646         cmpa    #0x2C
   A96B 27 07         [ 3] 4647         beq     LA974  
   A96D 36            [ 3] 4648         psha
   A96E BD 8E 70      [ 6] 4649         jsr     L8E70
   A971 32            [ 4] 4650         pula
   A972 20 F2         [ 3] 4651         bra     LA966  
   A974                    4652 LA974:
   A974 39            [ 5] 4653         rts
                           4654 
   A975                    4655 LA975:
   A975 BD 8E 95      [ 6] 4656         jsr     L8E95
   A978 4D            [ 2] 4657         tsta
   A979 27 FA         [ 3] 4658         beq     LA975  
   A97B 39            [ 5] 4659         rts
                           4660 
   A97C                    4661 LA97C:
   A97C 7F 00 60      [ 6] 4662         clr     (0x0060)
   A97F FC 02 9C      [ 5] 4663         ldd     (0x029C)
   A982 1A 83 00 01   [ 5] 4664         cpd     #0x0001
   A986 27 0C         [ 3] 4665         beq     LA994  
   A988 1A 83 03 E8   [ 5] 4666         cpd     #0x03E8
   A98C 2D 7D         [ 3] 4667         blt     LAA0B  
   A98E 1A 83 04 4B   [ 5] 4668         cpd     #0x044B
   A992 22 77         [ 3] 4669         bhi     LAA0B  
   A994                    4670 LA994:
   A994 C6 40         [ 2] 4671         ldab    #0x40
   A996 D7 62         [ 3] 4672         stab    (0x0062)
   A998 BD F9 C5      [ 6] 4673         jsr     BUTNLIT 
   A99B C6 64         [ 2] 4674         ldab    #0x64           ; delay 1 sec
   A99D BD 8C 22      [ 6] 4675         jsr     DLYSECSBY100
   A9A0 BD 86 C4      [ 6] 4676         jsr     L86C4
   A9A3 BD 8C E9      [ 6] 4677         jsr     L8CE9
                           4678 
   A9A6 BD 8D E4      [ 6] 4679         jsr     LCDMSG1 
   A9A9 20 20 20 20 20 53  4680         .ascis  '     STUDIO'
        54 55 44 49 CF
                           4681 
   A9B4 BD 8D DD      [ 6] 4682         jsr     LCDMSG2 
   A9B7 70 72 6F 67 72 61  4683         .ascis  'programming mode'
        6D 6D 69 6E 67 20
        6D 6F 64 E5
                           4684 
   A9C7 BD A3 2E      [ 6] 4685         jsr     LA32E
   A9CA BD 99 9E      [ 6] 4686         jsr     L999E
   A9CD BD 99 B1      [ 6] 4687         jsr     L99B1
   A9D0 CE 20 00      [ 3] 4688         ldx     #0x2000
   A9D3                    4689 LA9D3:
   A9D3 18 CE 00 C0   [ 4] 4690         ldy     #0x00C0
   A9D7                    4691 LA9D7:
   A9D7 18 09         [ 4] 4692         dey
   A9D9 26 0A         [ 3] 4693         bne     LA9E5  
   A9DB BD A9 F4      [ 6] 4694         jsr     LA9F4
   A9DE 96 60         [ 3] 4695         ldaa    (0x0060)
   A9E0 26 29         [ 3] 4696         bne     LAA0B  
   A9E2 CE 20 00      [ 3] 4697         ldx     #0x2000
   A9E5                    4698 LA9E5:
   A9E5 B6 10 A8      [ 4] 4699         ldaa    (0x10A8)
   A9E8 84 01         [ 2] 4700         anda    #0x01
   A9EA 27 EB         [ 3] 4701         beq     LA9D7  
   A9EC B6 10 A9      [ 4] 4702         ldaa    (0x10A9)
   A9EF A7 00         [ 4] 4703         staa    0,X     
   A9F1 08            [ 3] 4704         inx
   A9F2 20 DF         [ 3] 4705         bra     LA9D3
                           4706 
   A9F4                    4707 LA9F4:
   A9F4 CE 20 00      [ 3] 4708         ldx     #0x2000
   A9F7 18 CE 10 80   [ 4] 4709         ldy     #0x1080
   A9FB                    4710 LA9FB:
   A9FB A6 00         [ 4] 4711         ldaa    0,X     
   A9FD 18 A7 00      [ 5] 4712         staa    0,Y     
   AA00 08            [ 3] 4713         inx
   AA01 18 08         [ 4] 4714         iny
   AA03 18 08         [ 4] 4715         iny
   AA05 8C 20 10      [ 4] 4716         cpx     #0x2010
   AA08 25 F1         [ 3] 4717         bcs     LA9FB  
   AA0A 39            [ 5] 4718         rts
   AA0B                    4719 LAA0B:
   AA0B 39            [ 5] 4720         rts
                           4721 
   AA0C                    4722 LAA0C:
   AA0C CC 48 37      [ 3] 4723         ldd     #0x4837           ;'H'
   AA0F                    4724 LAA0F:
   AA0F BD 8D B5      [ 6] 4725         jsr     L8DB5            ; display char here on LCD display
   AA12 39            [ 5] 4726         rts
                           4727 
   AA13                    4728 LAA13:
   AA13 CC 20 37      [ 3] 4729         ldd     #0x2037           ;' '
   AA16 20 F7         [ 3] 4730         bra     LAA0F
                           4731 
   AA18                    4732 LAA18:
   AA18 CC 42 0F      [ 3] 4733         ldd     #0x420F           ;'B'
   AA1B 20 F2         [ 3] 4734         bra     LAA0F
                           4735 
   AA1D                    4736 LAA1D:
   AA1D CC 20 0F      [ 3] 4737         ldd     #0x200F           ;' '
   AA20 20 ED         [ 3] 4738         bra     LAA0F
                           4739 
   AA22                    4740 LAA22: 
   AA22 7F 00 4F      [ 6] 4741         clr     (0x004F)
   AA25 CC 00 01      [ 3] 4742         ldd     #0x0001
   AA28 DD 1B         [ 4] 4743         std     CDTIMR1
   AA2A CE 20 00      [ 3] 4744         ldx     #0x2000
   AA2D                    4745 LAA2D:
   AA2D B6 10 A8      [ 4] 4746         ldaa    (0x10A8)
   AA30 84 01         [ 2] 4747         anda    #0x01
   AA32 27 F9         [ 3] 4748         beq     LAA2D  
   AA34 DC 1B         [ 4] 4749         ldd     CDTIMR1
   AA36 0F            [ 2] 4750         sei
   AA37 26 03         [ 3] 4751         bne     LAA3C  
   AA39 CE 20 00      [ 3] 4752         ldx     #0x2000
   AA3C                    4753 LAA3C:
   AA3C B6 10 A9      [ 4] 4754         ldaa    (0x10A9)
   AA3F A7 00         [ 4] 4755         staa    0,X     
   AA41 0E            [ 2] 4756         cli
   AA42 BD F9 6F      [ 6] 4757         jsr     SERIALW      
   AA45 08            [ 3] 4758         inx
   AA46 7F 00 4F      [ 6] 4759         clr     (0x004F)
   AA49 CC 00 01      [ 3] 4760         ldd     #0x0001
   AA4C DD 1B         [ 4] 4761         std     CDTIMR1
   AA4E 8C 20 23      [ 4] 4762         cpx     #0x2023
   AA51 26 DA         [ 3] 4763         bne     LAA2D  
   AA53 CE 20 00      [ 3] 4764         ldx     #0x2000
   AA56 7F 00 B7      [ 6] 4765         clr     (0x00B7)
   AA59                    4766 LAA59:
   AA59 A6 00         [ 4] 4767         ldaa    0,X     
   AA5B 9B B7         [ 3] 4768         adda    (0x00B7)
   AA5D 97 B7         [ 3] 4769         staa    (0x00B7)
   AA5F 08            [ 3] 4770         inx
   AA60 8C 20 22      [ 4] 4771         cpx     #0x2022
   AA63 25 F4         [ 3] 4772         bcs     LAA59  
   AA65 96 B7         [ 3] 4773         ldaa    (0x00B7)
   AA67 88 FF         [ 2] 4774         eora    #0xFF
   AA69 A1 00         [ 4] 4775         cmpa    0,X     
   AA6B CE 20 00      [ 3] 4776         ldx     #0x2000
   AA6E A6 20         [ 4] 4777         ldaa    0x20,X
   AA70 2B 03         [ 3] 4778         bmi     LAA75  
   AA72 7E AA 22      [ 3] 4779         jmp     LAA22
   AA75                    4780 LAA75:
   AA75 A6 00         [ 4] 4781         ldaa    0,X     
   AA77 B7 10 80      [ 4] 4782         staa    (0x1080)
   AA7A 08            [ 3] 4783         inx
   AA7B A6 00         [ 4] 4784         ldaa    0,X     
   AA7D B7 10 82      [ 4] 4785         staa    (0x1082)
   AA80 08            [ 3] 4786         inx
   AA81 A6 00         [ 4] 4787         ldaa    0,X     
   AA83 B7 10 84      [ 4] 4788         staa    (0x1084)
   AA86 08            [ 3] 4789         inx
   AA87 A6 00         [ 4] 4790         ldaa    0,X     
   AA89 B7 10 86      [ 4] 4791         staa    (0x1086)
   AA8C 08            [ 3] 4792         inx
   AA8D A6 00         [ 4] 4793         ldaa    0,X     
   AA8F B7 10 88      [ 4] 4794         staa    (0x1088)
   AA92 08            [ 3] 4795         inx
   AA93 A6 00         [ 4] 4796         ldaa    0,X     
   AA95 B7 10 8A      [ 4] 4797         staa    (0x108A)
   AA98 08            [ 3] 4798         inx
   AA99 A6 00         [ 4] 4799         ldaa    0,X     
   AA9B B7 10 8C      [ 4] 4800         staa    (0x108C)
   AA9E 08            [ 3] 4801         inx
   AA9F A6 00         [ 4] 4802         ldaa    0,X     
   AAA1 B7 10 8E      [ 4] 4803         staa    (0x108E)
   AAA4 08            [ 3] 4804         inx
   AAA5 A6 00         [ 4] 4805         ldaa    0,X     
   AAA7 B7 10 90      [ 4] 4806         staa    (0x1090)
   AAAA 08            [ 3] 4807         inx
   AAAB A6 00         [ 4] 4808         ldaa    0,X     
   AAAD B7 10 92      [ 4] 4809         staa    (0x1092)
   AAB0 08            [ 3] 4810         inx
   AAB1 A6 00         [ 4] 4811         ldaa    0,X     
   AAB3 8A 80         [ 2] 4812         oraa    #0x80
   AAB5 B7 10 94      [ 4] 4813         staa    (0x1094)
   AAB8 08            [ 3] 4814         inx
   AAB9 A6 00         [ 4] 4815         ldaa    0,X     
   AABB 8A 01         [ 2] 4816         oraa    #0x01
   AABD B7 10 96      [ 4] 4817         staa    (0x1096)
   AAC0 08            [ 3] 4818         inx
   AAC1 A6 00         [ 4] 4819         ldaa    0,X     
   AAC3 B7 10 98      [ 4] 4820         staa    (0x1098)
   AAC6 08            [ 3] 4821         inx
   AAC7 A6 00         [ 4] 4822         ldaa    0,X     
   AAC9 B7 10 9A      [ 4] 4823         staa    (0x109A)
   AACC 08            [ 3] 4824         inx
   AACD A6 00         [ 4] 4825         ldaa    0,X     
   AACF B7 10 9C      [ 4] 4826         staa    (0x109C)
   AAD2 08            [ 3] 4827         inx
   AAD3 A6 00         [ 4] 4828         ldaa    0,X     
   AAD5 B7 10 9E      [ 4] 4829         staa    (0x109E)
   AAD8 7E AA 22      [ 3] 4830         jmp     LAA22
                           4831 
   AADB                    4832 LAADB:
   AADB 7F 10 98      [ 6] 4833         clr     (0x1098)
   AADE 7F 10 9A      [ 6] 4834         clr     (0x109A)
   AAE1 7F 10 9C      [ 6] 4835         clr     (0x109C)
   AAE4 7F 10 9E      [ 6] 4836         clr     (0x109E)
   AAE7 39            [ 5] 4837         rts
   AAE8                    4838 LAAE8:
   AAE8 CE 04 2C      [ 3] 4839         ldx     #0x042C
   AAEB C6 10         [ 2] 4840         ldab    #0x10
   AAED                    4841 LAAED:
   AAED 5D            [ 2] 4842         tstb
   AAEE 27 12         [ 3] 4843         beq     LAB02  
   AAF0 A6 00         [ 4] 4844         ldaa    0,X     
   AAF2 81 30         [ 2] 4845         cmpa    #0x30
   AAF4 25 0D         [ 3] 4846         bcs     LAB03  
   AAF6 81 39         [ 2] 4847         cmpa    #0x39
   AAF8 22 09         [ 3] 4848         bhi     LAB03  
   AAFA 08            [ 3] 4849         inx
   AAFB 08            [ 3] 4850         inx
   AAFC 08            [ 3] 4851         inx
   AAFD 8C 04 59      [ 4] 4852         cpx     #0x0459
   AB00 23 EB         [ 3] 4853         bls     LAAED  
   AB02                    4854 LAB02:
   AB02 39            [ 5] 4855         rts
                           4856 
   AB03                    4857 LAB03:
   AB03 5A            [ 2] 4858         decb
   AB04 3C            [ 4] 4859         pshx
   AB05                    4860 LAB05:
   AB05 A6 03         [ 4] 4861         ldaa    3,X     
   AB07 A7 00         [ 4] 4862         staa    0,X     
   AB09 08            [ 3] 4863         inx
   AB0A 8C 04 5C      [ 4] 4864         cpx     #0x045C
   AB0D 25 F6         [ 3] 4865         bcs     LAB05  
   AB0F 86 FF         [ 2] 4866         ldaa    #0xFF
   AB11 B7 04 59      [ 4] 4867         staa    (0x0459)
   AB14 38            [ 5] 4868         pulx
   AB15 20 D6         [ 3] 4869         bra     LAAED
                           4870 
   AB17                    4871 LAB17:
   AB17 CE 04 2C      [ 3] 4872         ldx     #0x042C
   AB1A 86 FF         [ 2] 4873         ldaa    #0xFF
   AB1C                    4874 LAB1C:
   AB1C A7 00         [ 4] 4875         staa    0,X     
   AB1E 08            [ 3] 4876         inx
   AB1F 8C 04 5C      [ 4] 4877         cpx     #0x045C
   AB22 25 F8         [ 3] 4878         bcs     LAB1C  
   AB24 39            [ 5] 4879         rts
                           4880 
   AB25                    4881 LAB25:
   AB25 CE 04 2C      [ 3] 4882         ldx     #0x042C
   AB28                    4883 LAB28:
   AB28 A6 00         [ 4] 4884         ldaa    0,X     
   AB2A 81 30         [ 2] 4885         cmpa    #0x30
   AB2C 25 17         [ 3] 4886         bcs     LAB45  
   AB2E 81 39         [ 2] 4887         cmpa    #0x39
   AB30 22 13         [ 3] 4888         bhi     LAB45  
   AB32 08            [ 3] 4889         inx
   AB33 08            [ 3] 4890         inx
   AB34 08            [ 3] 4891         inx
   AB35 8C 04 5C      [ 4] 4892         cpx     #0x045C
   AB38 25 EE         [ 3] 4893         bcs     LAB28  
   AB3A 86 FF         [ 2] 4894         ldaa    #0xFF
   AB3C B7 04 2C      [ 4] 4895         staa    (0x042C)
   AB3F BD AA E8      [ 6] 4896         jsr     LAAE8
   AB42 CE 04 59      [ 3] 4897         ldx     #0x0459
   AB45                    4898 LAB45:
   AB45 39            [ 5] 4899         rts
                           4900 
   AB46                    4901 LAB46:
   AB46 B6 02 99      [ 4] 4902         ldaa    (0x0299)
   AB49 A7 00         [ 4] 4903         staa    0,X     
   AB4B B6 02 9A      [ 4] 4904         ldaa    (0x029A)
   AB4E A7 01         [ 4] 4905         staa    1,X     
   AB50 B6 02 9B      [ 4] 4906         ldaa    (0x029B)
   AB53 A7 02         [ 4] 4907         staa    2,X     
   AB55 39            [ 5] 4908         rts
                           4909 
   AB56                    4910 LAB56:
   AB56 CE 04 2C      [ 3] 4911         ldx     #0x042C
   AB59                    4912 LAB59:
   AB59 B6 02 99      [ 4] 4913         ldaa    (0x0299)
   AB5C A1 00         [ 4] 4914         cmpa    0,X     
   AB5E 26 10         [ 3] 4915         bne     LAB70  
   AB60 B6 02 9A      [ 4] 4916         ldaa    (0x029A)
   AB63 A1 01         [ 4] 4917         cmpa    1,X     
   AB65 26 09         [ 3] 4918         bne     LAB70  
   AB67 B6 02 9B      [ 4] 4919         ldaa    (0x029B)
   AB6A A1 02         [ 4] 4920         cmpa    2,X     
   AB6C 26 02         [ 3] 4921         bne     LAB70  
   AB6E 20 0A         [ 3] 4922         bra     LAB7A  
   AB70                    4923 LAB70:
   AB70 08            [ 3] 4924         inx
   AB71 08            [ 3] 4925         inx
   AB72 08            [ 3] 4926         inx
   AB73 8C 04 5C      [ 4] 4927         cpx     #0x045C
   AB76 25 E1         [ 3] 4928         bcs     LAB59  
   AB78 0D            [ 2] 4929         sec
   AB79 39            [ 5] 4930         rts
                           4931 
   AB7A                    4932 LAB7A:
   AB7A 0C            [ 2] 4933         clc
   AB7B 39            [ 5] 4934         rts
                           4935 
                           4936 ;show re-valid tapes
   AB7C                    4937 LAB7C:
   AB7C CE 04 2C      [ 3] 4938         ldx     #0x042C
   AB7F                    4939 LAB7F:
   AB7F A6 00         [ 4] 4940         ldaa    0,X     
   AB81 81 30         [ 2] 4941         cmpa    #0x30
   AB83 25 1E         [ 3] 4942         bcs     LABA3  
   AB85 81 39         [ 2] 4943         cmpa    #0x39
   AB87 22 1A         [ 3] 4944         bhi     LABA3  
   AB89 BD F9 6F      [ 6] 4945         jsr     SERIALW      
   AB8C 08            [ 3] 4946         inx
   AB8D A6 00         [ 4] 4947         ldaa    0,X     
   AB8F BD F9 6F      [ 6] 4948         jsr     SERIALW      
   AB92 08            [ 3] 4949         inx
   AB93 A6 00         [ 4] 4950         ldaa    0,X     
   AB95 BD F9 6F      [ 6] 4951         jsr     SERIALW      
   AB98 08            [ 3] 4952         inx
   AB99 86 20         [ 2] 4953         ldaa    #0x20
   AB9B BD F9 6F      [ 6] 4954         jsr     SERIALW      
   AB9E 8C 04 5C      [ 4] 4955         cpx     #0x045C
   ABA1 25 DC         [ 3] 4956         bcs     LAB7F  
   ABA3                    4957 LABA3:
   ABA3 86 0D         [ 2] 4958         ldaa    #0x0D
   ABA5 BD F9 6F      [ 6] 4959         jsr     SERIALW      
   ABA8 86 0A         [ 2] 4960         ldaa    #0x0A
   ABAA BD F9 6F      [ 6] 4961         jsr     SERIALW      
   ABAD 39            [ 5] 4962         rts
                           4963 
   ABAE                    4964 LABAE:
   ABAE 7F 00 4A      [ 6] 4965         clr     (0x004A)
   ABB1 CC 00 64      [ 3] 4966         ldd     #0x0064
   ABB4 DD 23         [ 4] 4967         std     CDTIMR5
   ABB6                    4968 LABB6:
   ABB6 96 4A         [ 3] 4969         ldaa    (0x004A)
   ABB8 26 08         [ 3] 4970         bne     LABC2  
   ABBA BD 9B 19      [ 6] 4971         jsr     L9B19   
   ABBD DC 23         [ 4] 4972         ldd     CDTIMR5
   ABBF 26 F5         [ 3] 4973         bne     LABB6  
   ABC1                    4974 LABC1:
   ABC1 39            [ 5] 4975         rts
                           4976 
   ABC2                    4977 LABC2:
   ABC2 81 31         [ 2] 4978         cmpa    #0x31
   ABC4 26 04         [ 3] 4979         bne     LABCA  
   ABC6 BD AB 17      [ 6] 4980         jsr     LAB17
   ABC9 39            [ 5] 4981         rts
                           4982 
   ABCA                    4983 LABCA:
   ABCA 20 F5         [ 3] 4984         bra     LABC1  
                           4985 
                           4986 ; TOC1 timer handler
                           4987 ;
                           4988 ; Timer is running at:
                           4989 ; EXTAL = 16Mhz
                           4990 ; E Clk = 4Mhz
                           4991 ; Timer Prescaler = /16 = 250Khz
                           4992 ; Timer Period = 4us
                           4993 ; T1OC is set to previous value +625
                           4994 ; So, this routine is called every 2.5ms
                           4995 ;
   ABCC                    4996 LABCC:
   ABCC DC 10         [ 4] 4997         ldd     T1NXT        ; get ready for next time
   ABCE C3 02 71      [ 4] 4998         addd    #0x0271      ; add 625
   ABD1 FD 10 16      [ 5] 4999         std     TOC1  
   ABD4 DD 10         [ 4] 5000         std     T1NXT
                           5001 
   ABD6 86 80         [ 2] 5002         ldaa    #0x80
   ABD8 B7 10 23      [ 4] 5003         staa    TFLG1       ; clear timer1 flag
                           5004 
                           5005 ; Some blinking SPECIAL button every half second,
                           5006 ; if 0x0078 is non zero
                           5007 
   ABDB 7D 00 78      [ 6] 5008         tst     (0x0078)     ; if 78 is zero, skip ahead
   ABDE 27 1C         [ 3] 5009         beq     LABFC       ; else do some blinking button lights
   ABE0 DC 25         [ 4] 5010         ldd     (0x0025)     ; else inc 25/26
   ABE2 C3 00 01      [ 4] 5011         addd    #0x0001
   ABE5 DD 25         [ 4] 5012         std     (0x0025)
   ABE7 1A 83 00 C8   [ 5] 5013         cpd     #0x00C8       ; is it 200?
   ABEB 26 0F         [ 3] 5014         bne     LABFC       ; no, keep going
   ABED 7F 00 25      [ 6] 5015         clr     (0x0025)     ; reset 25/26
   ABF0 7F 00 26      [ 6] 5016         clr     (0x0026)
   ABF3 D6 62         [ 3] 5017         ldab    (0x0062)    ; and toggle bit 3 of 62
   ABF5 C8 08         [ 2] 5018         eorb    #0x08
   ABF7 D7 62         [ 3] 5019         stab    (0x0062)
   ABF9 BD F9 C5      [ 6] 5020         jsr     BUTNLIT      ; and toggle the "special" button light
                           5021 
                           5022 ; 
   ABFC                    5023 LABFC:
   ABFC 7C 00 6F      [ 6] 5024         inc     (0x006F)     ; count every 2.5ms
   ABFF 96 6F         [ 3] 5025         ldaa    (0x006F)
   AC01 81 28         [ 2] 5026         cmpa    #0x28        ; is it 40 intervals? (0.1 sec?)
   AC03 25 42         [ 3] 5027         bcs     LAC47       ; if not yet, jump ahead
   AC05 7F 00 6F      [ 6] 5028         clr     (0x006F)     ; clear it 2.5ms counter
   AC08 7D 00 63      [ 6] 5029         tst     (0x0063)     ; decrement 0.1s counter here
   AC0B 27 03         [ 3] 5030         beq     LAC10       ; if it's not already zero
   AC0D 7A 00 63      [ 6] 5031         dec     (0x0063)
                           5032 
                           5033 ; staggered counters - here every 100ms
                           5034 
                           5035 ; 0x0070 counts from 250 to 1, period is 25 secs
   AC10                    5036 LAC10:
   AC10 96 70         [ 3] 5037         ldaa    OFFCNT1    ; decrement 0.1s counter here
   AC12 4A            [ 2] 5038         deca
   AC13 97 70         [ 3] 5039         staa    OFFCNT1
   AC15 26 04         [ 3] 5040         bne     LAC1B       
   AC17 86 FA         [ 2] 5041         ldaa    #0xFA        ; 250
   AC19 97 70         [ 3] 5042         staa    OFFCNT1
                           5043 
                           5044 ; 0x0071 counts from 230 to 1, period is 23 secs
   AC1B                    5045 LAC1B:
   AC1B 96 71         [ 3] 5046         ldaa    OFFCNT2
   AC1D 4A            [ 2] 5047         deca
   AC1E 97 71         [ 3] 5048         staa    OFFCNT2
   AC20 26 04         [ 3] 5049         bne     LAC26  
   AC22 86 E6         [ 2] 5050         ldaa    #0xE6        ; 230
   AC24 97 71         [ 3] 5051         staa    OFFCNT2
                           5052 
                           5053 ; 0x0072 counts from 210 to 1, period is 21 secs
   AC26                    5054 LAC26:
   AC26 96 72         [ 3] 5055         ldaa    OFFCNT3
   AC28 4A            [ 2] 5056         deca
   AC29 97 72         [ 3] 5057         staa    OFFCNT3
   AC2B 26 04         [ 3] 5058         bne     LAC31  
   AC2D 86 D2         [ 2] 5059         ldaa    #0xD2        ; 210
   AC2F 97 72         [ 3] 5060         staa    OFFCNT3
                           5061 
                           5062 ; 0x0073 counts from 190 to 1, period is 19 secs
   AC31                    5063 LAC31:
   AC31 96 73         [ 3] 5064         ldaa    OFFCNT4
   AC33 4A            [ 2] 5065         deca
   AC34 97 73         [ 3] 5066         staa    OFFCNT4
   AC36 26 04         [ 3] 5067         bne     LAC3C  
   AC38 86 BE         [ 2] 5068         ldaa    #0xBE        ; 190
   AC3A 97 73         [ 3] 5069         staa    OFFCNT4
                           5070 
                           5071 ; 0x0074 counts from 170 to 1, period is 17 secs
   AC3C                    5072 LAC3C:
   AC3C 96 74         [ 3] 5073         ldaa    OFFCNT5
   AC3E 4A            [ 2] 5074         deca
   AC3F 97 74         [ 3] 5075         staa    OFFCNT5
   AC41 26 04         [ 3] 5076         bne     LAC47  
   AC43 86 AA         [ 2] 5077         ldaa    #0xAA        ; 170
   AC45 97 74         [ 3] 5078         staa    OFFCNT5
                           5079 
                           5080 ; back to 2.5ms period here
                           5081 
   AC47                    5082 LAC47:
   AC47 96 27         [ 3] 5083         ldaa    T30MS
   AC49 4C            [ 2] 5084         inca
   AC4A 97 27         [ 3] 5085         staa    T30MS
   AC4C 81 0C         [ 2] 5086         cmpa    #0x0C        ; 12 = 30ms?
   AC4E 23 09         [ 3] 5087         bls     LAC59  
   AC50 7F 00 27      [ 6] 5088         clr     T30MS
                           5089 
                           5090 ; do these tasks every 30ms
   AC53 BD 8E C6      [ 6] 5091         jsr     L8EC6       ; ???
   AC56 BD 8F 12      [ 6] 5092         jsr     L8F12       ; ???
                           5093 
                           5094 ; back to every 2.5ms here
                           5095 ; LCD update???
                           5096 
   AC59                    5097 LAC59:
   AC59 96 43         [ 3] 5098         ldaa    (0x0043)
   AC5B 27 55         [ 3] 5099         beq     LACB2  
   AC5D DE 44         [ 4] 5100         ldx     (0x0044)
   AC5F A6 00         [ 4] 5101         ldaa    0,X     
   AC61 27 23         [ 3] 5102         beq     LAC86  
   AC63 B7 10 00      [ 4] 5103         staa    PORTA  
   AC66 B6 10 02      [ 4] 5104         ldaa    PORTG  
   AC69 84 F3         [ 2] 5105         anda    #0xF3
   AC6B B7 10 02      [ 4] 5106         staa    PORTG  
   AC6E 84 FD         [ 2] 5107         anda    #0xFD
   AC70 B7 10 02      [ 4] 5108         staa    PORTG  
   AC73 8A 02         [ 2] 5109         oraa    #0x02
   AC75 B7 10 02      [ 4] 5110         staa    PORTG  
   AC78 08            [ 3] 5111         inx
   AC79 08            [ 3] 5112         inx
   AC7A 8C 05 80      [ 4] 5113         cpx     #0x0580
   AC7D 25 03         [ 3] 5114         bcs     LAC82  
   AC7F CE 05 00      [ 3] 5115         ldx     #0x0500
   AC82                    5116 LAC82:
   AC82 DF 44         [ 4] 5117         stx     (0x0044)
   AC84 20 2C         [ 3] 5118         bra     LACB2  
   AC86                    5119 LAC86:
   AC86 A6 01         [ 4] 5120         ldaa    1,X     
   AC88 27 25         [ 3] 5121         beq     LACAF  
   AC8A B7 10 00      [ 4] 5122         staa    PORTA  
   AC8D B6 10 02      [ 4] 5123         ldaa    PORTG  
   AC90 84 FB         [ 2] 5124         anda    #0xFB
   AC92 8A 08         [ 2] 5125         oraa    #0x08
   AC94 B7 10 02      [ 4] 5126         staa    PORTG  
   AC97 84 FD         [ 2] 5127         anda    #0xFD
   AC99 B7 10 02      [ 4] 5128         staa    PORTG  
   AC9C 8A 02         [ 2] 5129         oraa    #0x02
   AC9E B7 10 02      [ 4] 5130         staa    PORTG  
   ACA1 08            [ 3] 5131         inx
   ACA2 08            [ 3] 5132         inx
   ACA3 8C 05 80      [ 4] 5133         cpx     #0x0580
   ACA6 25 03         [ 3] 5134         bcs     LACAB  
   ACA8 CE 05 00      [ 3] 5135         ldx     #0x0500
   ACAB                    5136 LACAB:
   ACAB DF 44         [ 4] 5137         stx     (0x0044)
   ACAD 20 03         [ 3] 5138         bra     LACB2  
   ACAF                    5139 LACAF:
   ACAF 7F 00 43      [ 6] 5140         clr     (0x0043)
                           5141 
                           5142 ; divide by 4
   ACB2                    5143 LACB2:
   ACB2 96 4F         [ 3] 5144         ldaa    (0x004F)
   ACB4 4C            [ 2] 5145         inca
   ACB5 97 4F         [ 3] 5146         staa    (0x004F)
   ACB7 81 04         [ 2] 5147         cmpa    #0x04
   ACB9 26 30         [ 3] 5148         bne     LACEB  
   ACBB 7F 00 4F      [ 6] 5149         clr     (0x004F)
                           5150 
                           5151 ; here every 10ms
                           5152 ; Five big countdown timers available here
                           5153 ; up to 655.35 seconds each
                           5154 
   ACBE DC 1B         [ 4] 5155         ldd     CDTIMR1     ; countdown 0x001B/1C every 10ms
   ACC0 27 05         [ 3] 5156         beq     LACC7       ; if not already 0
   ACC2 83 00 01      [ 4] 5157         subd    #0x0001
   ACC5 DD 1B         [ 4] 5158         std     CDTIMR1
                           5159 
   ACC7                    5160 LACC7:
   ACC7 DC 1D         [ 4] 5161         ldd     CDTIMR2     ; same with 0x001D/1E
   ACC9 27 05         [ 3] 5162         beq     LACD0  
   ACCB 83 00 01      [ 4] 5163         subd    #0x0001
   ACCE DD 1D         [ 4] 5164         std     CDTIMR2
                           5165 
   ACD0                    5166 LACD0:
   ACD0 DC 1F         [ 4] 5167         ldd     CDTIMR3     ; same with 0x001F/20
   ACD2 27 05         [ 3] 5168         beq     LACD9  
   ACD4 83 00 01      [ 4] 5169         subd    #0x0001
   ACD7 DD 1F         [ 4] 5170         std     CDTIMR3
                           5171 
   ACD9                    5172 LACD9:
   ACD9 DC 21         [ 4] 5173         ldd     CDTIMR4     ; same with 0x0021/22
   ACDB 27 05         [ 3] 5174         beq     LACE2  
   ACDD 83 00 01      [ 4] 5175         subd    #0x0001
   ACE0 DD 21         [ 4] 5176         std     CDTIMR4
                           5177 
   ACE2                    5178 LACE2:
   ACE2 DC 23         [ 4] 5179         ldd     CDTIMR5     ; same with 0x0023/24
   ACE4 27 05         [ 3] 5180         beq     LACEB  
   ACE6 83 00 01      [ 4] 5181         subd    #0x0001
   ACE9 DD 23         [ 4] 5182         std     CDTIMR5
                           5183 
                           5184 ; every other time through this, setup a task switch?
   ACEB                    5185 LACEB:
   ACEB 96 B0         [ 3] 5186         ldaa    (TSCNT)
   ACED 88 01         [ 2] 5187         eora    #0x01
   ACEF 97 B0         [ 3] 5188         staa    (TSCNT)
   ACF1 27 18         [ 3] 5189         beq     LAD0B  
                           5190 
   ACF3 BF 01 3C      [ 5] 5191         sts     (0x013C)     ; switch stacks???
   ACF6 BE 01 3E      [ 5] 5192         lds     (0x013E)
   ACF9 DC 10         [ 4] 5193         ldd     T1NXT
   ACFB 83 01 F4      [ 4] 5194         subd    #0x01F4      ; 625-500 = 125?
   ACFE FD 10 18      [ 5] 5195         std     TOC2         ; set this TOC2 to happen 0.5ms
   AD01 86 40         [ 2] 5196         ldaa    #0x40        ; after the current TOC1 but before the next TOC1
   AD03 B7 10 23      [ 4] 5197         staa    TFLG1       ; clear timer2 irq flag, just in case?
   AD06 86 C0         [ 2] 5198         ldaa    #0xC0        ;
   AD08 B7 10 22      [ 4] 5199         staa    TMSK1       ; enable TOC1 and TOC2
   AD0B                    5200 LAD0B:
   AD0B 3B            [12] 5201         rti
                           5202 
                           5203 ; TOC2 Timer handler
   AD0C                    5204 LAD0C:
   AD0C 86 40         [ 2] 5205         ldaa    #0x40
   AD0E B7 10 23      [ 4] 5206         staa    TFLG1       ; clear timer2 flag
   AD11 BF 01 3E      [ 5] 5207         sts     (0x013E)     ; switch stacks back???
   AD14 BE 01 3C      [ 5] 5208         lds     (0x013C)
   AD17 86 80         [ 2] 5209         ldaa    #0x80
   AD19 B7 10 22      [ 4] 5210         staa    TMSK1       ; enable TOC1 only
   AD1C 3B            [12] 5211         rti
                           5212 
                           5213 ; Secondary task??
                           5214 
   AD1D                    5215 TASK2:
   AD1D 7D 04 2A      [ 6] 5216         tst     (0x042A)
   AD20 27 35         [ 3] 5217         beq     LAD57
   AD22 96 B6         [ 3] 5218         ldaa    (0x00B6)
   AD24 26 03         [ 3] 5219         bne     LAD29
   AD26 3F            [14] 5220         swi
   AD27 20 F4         [ 3] 5221         bra     TASK2
   AD29                    5222 LAD29:
   AD29 7F 00 B6      [ 6] 5223         clr     (0x00B6)
   AD2C C6 04         [ 2] 5224         ldab    #0x04
   AD2E                    5225 LAD2E:
   AD2E 37            [ 3] 5226         pshb
   AD2F CE AD 3C      [ 3] 5227         ldx     #LAD3C
   AD32 BD 8A 1A      [ 6] 5228         jsr     L8A1A  
   AD35 3F            [14] 5229         swi
   AD36 33            [ 4] 5230         pulb
   AD37 5A            [ 2] 5231         decb
   AD38 26 F4         [ 3] 5232         bne     LAD2E  
   AD3A 20 E1         [ 3] 5233         bra     TASK2
                           5234 
   AD3C                    5235 LAD3C:
   AD3C 53 31 00           5236         .asciz     'S1'
                           5237 
   AD3F FC 02 9C      [ 5] 5238         ldd     (0x029C)
   AD42 1A 83 00 01   [ 5] 5239         cpd     #0x0001
   AD46 27 0C         [ 3] 5240         beq     LAD54  
   AD48 1A 83 03 E8   [ 5] 5241         cpd     #0x03E8
   AD4C 2D 09         [ 3] 5242         blt     LAD57  
   AD4E 1A 83 04 4B   [ 5] 5243         cpd     #0x044B
   AD52 22 03         [ 3] 5244         bhi     LAD57  
   AD54                    5245 LAD54:
   AD54 3F            [14] 5246         swi
   AD55 20 C6         [ 3] 5247         bra     TASK2
   AD57                    5248 LAD57:
   AD57 7F 00 B3      [ 6] 5249         clr     (0x00B3)
   AD5A BD AD 7E      [ 6] 5250         jsr     LAD7E
   AD5D BD AD A0      [ 6] 5251         jsr     LADA0
   AD60 25 BB         [ 3] 5252         bcs     TASK2
   AD62 C6 0A         [ 2] 5253         ldab    #0x0A
   AD64 BD AE 13      [ 6] 5254         jsr     LAE13
   AD67 BD AD AE      [ 6] 5255         jsr     LADAE
   AD6A 25 B1         [ 3] 5256         bcs     TASK2
   AD6C C6 14         [ 2] 5257         ldab    #0x14
   AD6E BD AE 13      [ 6] 5258         jsr     LAE13
   AD71 BD AD B6      [ 6] 5259         jsr     LADB6
   AD74 25 A7         [ 3] 5260         bcs     TASK2
   AD76                    5261 LAD76:
   AD76 BD AD B8      [ 6] 5262         jsr     LADB8
   AD79 0D            [ 2] 5263         sec
   AD7A 25 A1         [ 3] 5264         bcs     TASK2
   AD7C 20 F8         [ 3] 5265         bra     LAD76
   AD7E                    5266 LAD7E:
   AD7E CE AE 1E      [ 3] 5267         ldx     #LAE1E       ;+++
   AD81 BD 8A 1A      [ 6] 5268         jsr     L8A1A  
   AD84 C6 1E         [ 2] 5269         ldab    #0x1E
   AD86 BD AE 13      [ 6] 5270         jsr     LAE13
   AD89 CE AE 22      [ 3] 5271         ldx     #LAE22       ;ATH
   AD8C BD 8A 1A      [ 6] 5272         jsr     L8A1A  
   AD8F C6 1E         [ 2] 5273         ldab    #0x1E
   AD91 BD AE 13      [ 6] 5274         jsr     LAE13
   AD94 CE AE 27      [ 3] 5275         ldx     #LAE27       ;ATZ
   AD97 BD 8A 1A      [ 6] 5276         jsr     L8A1A  
   AD9A C6 1E         [ 2] 5277         ldab    #0x1E
   AD9C BD AE 13      [ 6] 5278         jsr     LAE13
   AD9F 39            [ 5] 5279         rts
   ADA0                    5280 LADA0:
   ADA0 BD B1 DD      [ 6] 5281         jsr     LB1DD
   ADA3 25 FB         [ 3] 5282         bcs     LADA0  
   ADA5 BD B2 4F      [ 6] 5283         jsr     LB24F
                           5284 
   ADA8 52 49 4E 47 00     5285         .asciz  'RING'
                           5286 
   ADAD 39            [ 5] 5287         rts
                           5288 
   ADAE                    5289 LADAE:
   ADAE CE AE 2C      [ 3] 5290         ldx     #LAE2C
   ADB1 BD 8A 1A      [ 6] 5291         jsr     L8A1A       ;ATA
   ADB4 0C            [ 2] 5292         clc
   ADB5 39            [ 5] 5293         rts
   ADB6                    5294 LADB6:
   ADB6 0C            [ 2] 5295         clc
   ADB7 39            [ 5] 5296         rts
                           5297 
   ADB8                    5298 LADB8:
   ADB8 BD B1 D2      [ 6] 5299         jsr     LB1D2
   ADBB BD AE 31      [ 6] 5300         jsr     LAE31
   ADBE 86 01         [ 2] 5301         ldaa    #0x01
   ADC0 97 B3         [ 3] 5302         staa    (0x00B3)
   ADC2 BD B1 DD      [ 6] 5303         jsr     LB1DD
   ADC5 BD B2 71      [ 6] 5304         jsr     LB271
   ADC8 36            [ 3] 5305         psha
   ADC9 BD B2 C0      [ 6] 5306         jsr     LB2C0
   ADCC 32            [ 4] 5307         pula
   ADCD 81 01         [ 2] 5308         cmpa    #0x01
   ADCF 26 08         [ 3] 5309         bne     LADD9  
   ADD1 CE B2 95      [ 3] 5310         ldx     #LB295
   ADD4 BD 8A 1A      [ 6] 5311         jsr     L8A1A       ;'You have selected #1'
   ADD7 20 31         [ 3] 5312         bra     LAE0A  
   ADD9                    5313 LADD9:
   ADD9 81 02         [ 2] 5314         cmpa    #0x02
   ADDB 26 00         [ 3] 5315         bne     LADDD  
   ADDD                    5316 LADDD:
   ADDD 81 03         [ 2] 5317         cmpa    #0x03
   ADDF 26 00         [ 3] 5318         bne     LADE1  
   ADE1                    5319 LADE1:
   ADE1 81 04         [ 2] 5320         cmpa    #0x04
   ADE3 26 00         [ 3] 5321         bne     LADE5  
   ADE5                    5322 LADE5:
   ADE5 81 05         [ 2] 5323         cmpa    #0x05
   ADE7 26 00         [ 3] 5324         bne     LADE9  
   ADE9                    5325 LADE9:
   ADE9 81 06         [ 2] 5326         cmpa    #0x06
   ADEB 26 00         [ 3] 5327         bne     LADED  
   ADED                    5328 LADED:
   ADED 81 07         [ 2] 5329         cmpa    #0x07
   ADEF 26 00         [ 3] 5330         bne     LADF1  
   ADF1                    5331 LADF1:
   ADF1 81 08         [ 2] 5332         cmpa    #0x08
   ADF3 26 00         [ 3] 5333         bne     LADF5  
   ADF5                    5334 LADF5:
   ADF5 81 09         [ 2] 5335         cmpa    #0x09
   ADF7 26 00         [ 3] 5336         bne     LADF9  
   ADF9                    5337 LADF9:
   ADF9 81 0A         [ 2] 5338         cmpa    #0x0A
   ADFB 26 00         [ 3] 5339         bne     LADFD  
   ADFD                    5340 LADFD:
   ADFD 81 0B         [ 2] 5341         cmpa    #0x0B
   ADFF 26 09         [ 3] 5342         bne     LAE0A  
   AE01 CE B2 AA      [ 3] 5343         ldx     #LB2AA       ;'You have selected #11'
   AE04 BD 8A 1A      [ 6] 5344         jsr     L8A1A  
   AE07 7E AE 0A      [ 3] 5345         jmp     LAE0A
   AE0A                    5346 LAE0A:
   AE0A C6 14         [ 2] 5347         ldab    #0x14
   AE0C BD AE 13      [ 6] 5348         jsr     LAE13
   AE0F 7F 00 B3      [ 6] 5349         clr     (0x00B3)
   AE12 39            [ 5] 5350         rts
                           5351 
   AE13                    5352 LAE13:
   AE13 CE 00 20      [ 3] 5353         ldx     #0x0020
   AE16                    5354 LAE16:
   AE16 3F            [14] 5355         swi
   AE17 09            [ 3] 5356         dex
   AE18 26 FC         [ 3] 5357         bne     LAE16  
   AE1A 5A            [ 2] 5358         decb
   AE1B 26 F6         [ 3] 5359         bne     LAE13  
   AE1D 39            [ 5] 5360         rts
                           5361 
                           5362 ; text??
   AE1E                    5363 LAE1E:
   AE1E 2B 2B 2B 00        5364         .asciz      '+++'
   AE22                    5365 LAE22:
   AE22 41 54 48 0D 00     5366         .asciz      'ATH\r'
   AE27                    5367 LAE27:
   AE27 41 54 5A 0D 00     5368         .asciz      'ATZ\r'
   AE2C                    5369 LAE2C:
   AE2C 41 54 41 0D 00     5370         .asciz      'ATA\r'
                           5371 
   AE31                    5372 LAE31:
   AE31 CE AE 38      [ 3] 5373         ldx     #LAE38       ; big long string of stats?
   AE34 BD 8A 1A      [ 6] 5374         jsr     L8A1A  
   AE37 39            [ 5] 5375         rts
                           5376 
   AE38                    5377 LAE38:
   AE38 5E 30 31 30 31 53  5378         .ascii  "^0101Serial #:^0140#0000^0111~4"
        65 72 69 61 6C 20
        23 3A 5E 30 31 34
        30 23 30 30 30 30
        5E 30 31 31 31 7E
        34
   AE57 0E 20              5379         .byte   0x0E,0x20
   AE59 5E 30 31 34 31 7C  5380         .ascii  "^0141|"
   AE5F 04 28              5381         .byte   0x04,0x28
   AE61 5E 30 33 30 31 43  5382         .ascii  "^0301CURRENT^0340HISTORY^0501Show Status:^0540Total # reg. shows:^0601Random Status:^0570|"
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
   AEBB 04 10              5383         .byte   0x04,0x10
   AEBD 5E 30 36 34 30 54  5384         .ascii  "^0640Total # live shows:^0701Current Reg Tape #:^0670|"
        6F 74 61 6C 20 23
        20 6C 69 76 65 20
        73 68 6F 77 73 3A
        5E 30 37 30 31 43
        75 72 72 65 6E 74
        20 52 65 67 20 54
        61 70 65 20 23 3A
        5E 30 36 37 30 7C
   AEF3 04 12              5385         .byte   0x04,0x12
   AEF5 5E 30 37 33 30 7E  5386         .ascii  "^0730~3"
        33
   AEFC 04 02              5387         .byte   0x04,0x02
   AEFE 5E 30 37 34 30 54  5388         .ascii  "^0740Total # failed pswd attempts:^0801Current Live Tape #:^0770|"
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
   AF3F 04 14              5389         .byte   0x04,0x14
   AF41 5E 30 38 33 30 7E  5390         .ascii  "^0830~3"
        33
   AF48 04 05              5391         .byte   0x04,0x05
   AF4A 5E 30 38 34 30 54  5392         .ascii  "^0840Total # successful pswd:^0901Current Version #:^0870|"
        6F 74 61 6C 20 23
        20 73 75 63 63 65
        73 73 66 75 6C 20
        70 73 77 64 3A 5E
        30 39 30 31 43 75
        72 72 65 6E 74 20
        56 65 72 73 69 6F
        6E 20 23 3A 5E 30
        38 37 30 7C
   AF84 04 16              5393         .byte   0x04,0x16
   AF86 5E 30 39 33 30 40  5394         .ascii  "^0930@"
   AF8C 04 00              5395         .byte   0x04,0x00
   AF8E 5E 30 39 34 30 54  5396         .ascii  "^0940Total # bdays played:^1040Total # VCR adjusts:^0970|"
        6F 74 61 6C 20 23
        20 62 64 61 79 73
        20 70 6C 61 79 65
        64 3A 5E 31 30 34
        30 54 6F 74 61 6C
        20 23 20 56 43 52
        20 61 64 6A 75 73
        74 73 3A 5E 30 39
        37 30 7C
   AFC7 04 18              5397         .byte   0x04,0x18
   AFC9 5E 31 30 37 30 7C  5398         .ascii  "^1070|"
   AFCF 04 1A              5399         .byte   0x04,0x1A
   AFD1 5E 31 31 34 30 54  5400         .ascii  "^1140Total # remote accesses:^1240Total # access attempts:^1170|"
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
   B011 04 1C              5401         .byte   0x04,0x1C
   B013 5E 31 32 37 30 7C  5402         .ascii  "^1270|"
   B019 04 1E              5403         .byte   0x04,0x1E
   B01B 5E 31 33 34 30 54  5404         .ascii  "^1340Total # rejected showtapes:^1440Total # Short bdays:^1370|"
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
   B05A 04 20              5405         .byte   0x04,0x20
   B05C 5E 31 34 37 30 7C  5406         .ascii  "^1470|"
   B062 04 22              5407         .byte   0x04,0x22
   B064 5E 31 35 34 30 54  5408         .ascii  "^1540Total # Reg bdays:^1640Total # resets-pwr ups:^1570|"
        6F 74 61 6C 20 23
        20 52 65 67 20 62
        64 61 79 73 3A 5E
        31 36 34 30 54 6F
        74 61 6C 20 23 20
        72 65 73 65 74 73
        2D 70 77 72 20 75
        70 73 3A 5E 31 35
        37 30 7C
   B09D 04 24              5409         .byte   0x04,0x24
   B09F 5E 31 36 37 30 7C  5410         .ascii  "^1670|"
   B0A5 04 26              5411         .byte   0x04,0x26
   B0A7 5E 31 38 30 31 46  5412         .ascii  "^1801FUNCTIONS^1823Select Function:^20011.Clear rnd enables^2028 6.Set loc name-#^205411.Diagnostics^21012.Set rnd enables^2128 7.Set Time^215412.^22013.Set reg tape #^2228 8.Disbl-enbl show^225413.^23014.Set liv tape #^2328 9.Upload program^235414.^24015.Reset history^242810.Debugger^245415.^1840"
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
   B1D1 00                 5413         .byte   0x00
                           5414 
   B1D2                    5415 LB1D2:
   B1D2 CE B1 D8      [ 3] 5416         ldx     #LB1D8       ; escape sequence?
   B1D5 7E 8A 1A      [ 3] 5417         jmp     L8A1A  
                           5418 
   B1D8                    5419 LB1D8:
                           5420         ; esc[2J ?
   B1D8 1B                 5421         .byte   0x1b
   B1D9 5B 32 4A 00        5422         .asciz  '[2J'
                           5423 
   B1DD                    5424 LB1DD:
   B1DD CE 05 A0      [ 3] 5425         ldx     #0x05A0
   B1E0 CC 00 00      [ 3] 5426         ldd     #0x0000
   B1E3 FD 02 9E      [ 5] 5427         std     (0x029E)
   B1E6                    5428 LB1E6:
   B1E6 FC 02 9E      [ 5] 5429         ldd     (0x029E)
   B1E9 C3 00 01      [ 4] 5430         addd    #0x0001
   B1EC FD 02 9E      [ 5] 5431         std     (0x029E)
   B1EF 1A 83 0F A0   [ 5] 5432         cpd     #0x0FA0
   B1F3 24 28         [ 3] 5433         bcc     LB21D  
   B1F5 BD B2 23      [ 6] 5434         jsr     LB223
   B1F8 25 04         [ 3] 5435         bcs     LB1FE  
   B1FA 3F            [14] 5436         swi
   B1FB 20 E9         [ 3] 5437         bra     LB1E6  
   B1FD 39            [ 5] 5438         rts
                           5439 
   B1FE                    5440 LB1FE:
   B1FE A7 00         [ 4] 5441         staa    0,X     
   B200 08            [ 3] 5442         inx
   B201 81 0D         [ 2] 5443         cmpa    #0x0D
   B203 26 02         [ 3] 5444         bne     LB207  
   B205 20 18         [ 3] 5445         bra     LB21F  
   B207                    5446 LB207:
   B207 81 1B         [ 2] 5447         cmpa    #0x1B
   B209 26 02         [ 3] 5448         bne     LB20D  
   B20B 20 10         [ 3] 5449         bra     LB21D  
   B20D                    5450 LB20D:
   B20D 7D 00 B3      [ 6] 5451         tst     (0x00B3)
   B210 27 03         [ 3] 5452         beq     LB215  
   B212 BD 8B 3B      [ 6] 5453         jsr     L8B3B
   B215                    5454 LB215:
   B215 CC 00 00      [ 3] 5455         ldd     #0x0000
   B218 FD 02 9E      [ 5] 5456         std     (0x029E)
   B21B 20 C9         [ 3] 5457         bra     LB1E6  
   B21D                    5458 LB21D:
   B21D 0D            [ 2] 5459         sec
   B21E 39            [ 5] 5460         rts
                           5461 
   B21F                    5462 LB21F:
   B21F 6F 00         [ 6] 5463         clr     0,X     
   B221 0C            [ 2] 5464         clc
   B222 39            [ 5] 5465         rts
                           5466 
   B223                    5467 LB223:
   B223 B6 18 0D      [ 4] 5468         ldaa    SCCCTRLB
   B226 44            [ 2] 5469         lsra
   B227 25 0B         [ 3] 5470         bcs     LB234  
   B229 4F            [ 2] 5471         clra
   B22A B7 18 0D      [ 4] 5472         staa    SCCCTRLB
   B22D 86 30         [ 2] 5473         ldaa    #0x30
   B22F B7 18 0D      [ 4] 5474         staa    SCCCTRLB
   B232 0C            [ 2] 5475         clc
   B233 39            [ 5] 5476         rts
                           5477 
   B234                    5478 LB234:
   B234 86 01         [ 2] 5479         ldaa    #0x01
   B236 B7 18 0D      [ 4] 5480         staa    SCCCTRLB
   B239 86 70         [ 2] 5481         ldaa    #0x70
   B23B B5 18 0D      [ 4] 5482         bita    SCCCTRLB
   B23E 26 05         [ 3] 5483         bne     LB245  
   B240 0D            [ 2] 5484         sec
   B241 B6 18 0F      [ 4] 5485         ldaa    SCCDATAB
   B244 39            [ 5] 5486         rts
                           5487 
   B245                    5488 LB245:
   B245 B6 18 0F      [ 4] 5489         ldaa    SCCDATAB
   B248 86 30         [ 2] 5490         ldaa    #0x30
   B24A B7 18 0C      [ 4] 5491         staa    SCCCTRLA
   B24D 0C            [ 2] 5492         clc
   B24E 39            [ 5] 5493         rts
                           5494 
   B24F                    5495 LB24F:
   B24F 38            [ 5] 5496         pulx
   B250 18 CE 05 A0   [ 4] 5497         ldy     #0x05A0
   B254                    5498 LB254:
   B254 A6 00         [ 4] 5499         ldaa    0,X
   B256 27 11         [ 3] 5500         beq     LB269
   B258 08            [ 3] 5501         inx
   B259 18 A1 00      [ 5] 5502         cmpa    0,Y
   B25C 26 04         [ 3] 5503         bne     LB262
   B25E 18 08         [ 4] 5504         iny
   B260 20 F2         [ 3] 5505         bra     LB254
   B262                    5506 LB262:
   B262 A6 00         [ 4] 5507         ldaa    0,X
   B264 27 07         [ 3] 5508         beq     LB26D
   B266 08            [ 3] 5509         inx
   B267 20 F9         [ 3] 5510         bra     LB262
   B269                    5511 LB269:
   B269 08            [ 3] 5512         inx
   B26A 3C            [ 4] 5513         pshx
   B26B 0C            [ 2] 5514         clc
   B26C 39            [ 5] 5515         rts
   B26D                    5516 LB26D:
   B26D 08            [ 3] 5517         inx
   B26E 3C            [ 4] 5518         pshx
   B26F 0D            [ 2] 5519         sec
   B270 39            [ 5] 5520         rts
                           5521 
   B271                    5522 LB271:
   B271 CE 05 A0      [ 3] 5523         ldx     #0x05A0
   B274                    5524 LB274:
   B274 A6 00         [ 4] 5525         ldaa    0,X
   B276 08            [ 3] 5526         inx
   B277 81 0D         [ 2] 5527         cmpa    #0x0D
   B279 26 F9         [ 3] 5528         bne     LB274
   B27B 09            [ 3] 5529         dex
   B27C 09            [ 3] 5530         dex
   B27D A6 00         [ 4] 5531         ldaa    0,X
   B27F 09            [ 3] 5532         dex
   B280 80 30         [ 2] 5533         suba    #0x30
   B282 97 B2         [ 3] 5534         staa    (0x00B2)
   B284 8C 05 9F      [ 4] 5535         cpx     #0x059F
   B287 27 0B         [ 3] 5536         beq     LB294
   B289 A6 00         [ 4] 5537         ldaa    0,X
   B28B 09            [ 3] 5538         dex
   B28C 80 30         [ 2] 5539         suba    #0x30
   B28E C6 0A         [ 2] 5540         ldab    #0x0A
   B290 3D            [10] 5541         mul
   B291 17            [ 2] 5542         tba
   B292 9B B2         [ 3] 5543         adda    (0x00B2)
   B294                    5544 LB294:
   B294 39            [ 5] 5545         rts
                           5546 
   B295                    5547 LB295:
   B295 59 6F 75 20 68 61  5548         .asciz  'You have selected #1'
        76 65 20 73 65 6C
        65 63 74 65 64 20
        23 31 00
   B2AA                    5549 LB2AA:
   B2AA 59 6F 75 20 68 61  5550         .asciz  'You have selected #11'
        76 65 20 73 65 6C
        65 63 74 65 64 20
        23 31 31 00
                           5551 
   B2C0                    5552 LB2C0:
   B2C0 CE B2 C7      [ 3] 5553         ldx     #LB2C7      ; strange table
   B2C3 BD 8A 1A      [ 6] 5554         jsr     L8A1A  
   B2C6 39            [ 5] 5555         rts
                           5556 
   B2C7                    5557 LB2C7:
   B2C7 5E 32 30 30 31 25  5558         .asciz  "^2001%^2101%^2201%^2301%^2401%^2001"
        5E 32 31 30 31 25
        5E 32 32 30 31 25
        5E 32 33 30 31 25
        5E 32 34 30 31 25
        5E 32 30 30 31 00
                           5559 
   B2EB                    5560 LB2EB:
   B2EB FA 20 FA 20 F6 22  5561         .byte   0xfa,0x20,0xfa,0x20,0xf6,0x22,0xf5,0x20
        F5 20
   B2F3 F5 20 F3 22 F2 20  5562         .byte   0xf5,0x20,0xf3,0x22,0xf2,0x20,0xe5,0x22
        E5 22
   B2FB E5 22 E2 20 D2 20  5563         .byte   0xe5,0x22,0xe2,0x20,0xd2,0x20,0xbe,0x00
        BE 00
   B303 BC 22 BB 30 B9 32  5564         .byte   0xbc,0x22,0xbb,0x30,0xb9,0x32,0xb9,0x32
        B9 32
   B30B B7 30 B6 32 B5 30  5565         .byte   0xb7,0x30,0xb6,0x32,0xb5,0x30,0xb4,0x32
        B4 32
   B313 B4 32 B3 20 B3 20  5566         .byte   0xb4,0x32,0xb3,0x20,0xb3,0x20,0xb1,0xa0
        B1 A0
   B31B B1 A0 B0 A2 AF A0  5567         .byte   0xb1,0xa0,0xb0,0xa2,0xaf,0xa0,0xaf,0xa6
        AF A6
   B323 AE A0 AE A6 AD A4  5568         .byte   0xae,0xa0,0xae,0xa6,0xad,0xa4,0xac,0xa0
        AC A0
   B32B AC A0 AB A0 AA A0  5569         .byte   0xac,0xa0,0xab,0xa0,0xaa,0xa0,0xaa,0xa0
        AA A0
   B333 A2 80 A0 A0 A0 A0  5570         .byte   0xa2,0x80,0xa0,0xa0,0xa0,0xa0,0x8d,0x80
        8D 80
   B33B 8A A0 7E 80 7B A0  5571         .byte   0x8a,0xa0,0x7e,0x80,0x7b,0xa0,0x79,0xa4
        79 A4
   B343 78 A0 77 A4 76 A0  5572         .byte   0x78,0xa0,0x77,0xa4,0x76,0xa0,0x75,0xa4
        75 A4
   B34B 74 A0 73 A4 72 A0  5573         .byte   0x74,0xa0,0x73,0xa4,0x72,0xa0,0x71,0xa4
        71 A4
   B353 70 A0 6F A4 6E A0  5574         .byte   0x70,0xa0,0x6f,0xa4,0x6e,0xa0,0x6d,0xa4
        6D A4
   B35B 6C A0 69 80 69 80  5575         .byte   0x6c,0xa0,0x69,0x80,0x69,0x80,0x67,0xa0
        67 A0
   B363 5E 20 58 24 57 20  5576         .byte   0x5e,0x20,0x58,0x24,0x57,0x20,0x57,0x20
        57 20
   B36B 56 24 55 20 54 24  5577         .byte   0x56,0x24,0x55,0x20,0x54,0x24,0x54,0x24
        54 24
   B373 53 20 52 24 52 24  5578         .byte   0x53,0x20,0x52,0x24,0x52,0x24,0x50,0x20
        50 20
   B37B 4F 24 4E 20 4D 24  5579         .byte   0x4f,0x24,0x4e,0x20,0x4d,0x24,0x4c,0x20
        4C 20
   B383 4C 20 4B 24 4A 20  5580         .byte   0x4c,0x20,0x4b,0x24,0x4a,0x20,0x49,0x20
        49 20
   B38B 49 00 48 20 47 20  5581         .byte   0x49,0x00,0x48,0x20,0x47,0x20,0x47,0x20
        47 20
   B393 46 20 45 24 45 24  5582         .byte   0x46,0x20,0x45,0x24,0x45,0x24,0x44,0x20
        44 20
   B39B 42 20 42 20 37 04  5583         .byte   0x42,0x20,0x42,0x20,0x37,0x04,0x35,0x20
        35 20
   B3A3 2E 04 2E 04 2D 20  5584         .byte   0x2e,0x04,0x2e,0x04,0x2d,0x20,0x23,0x24
        23 24
   B3AB 21 20 17 24 13 00  5585         .byte   0x21,0x20,0x17,0x24,0x13,0x00,0x11,0x24
        11 24
   B3B3 10 30 07 34 06 30  5586         .byte   0x10,0x30,0x07,0x34,0x06,0x30,0x05,0x30
        05 30
   B3BB FF FF              5587         .byte   0xff,0xff
                           5588 
   B3BD                    5589 LB3BD:
   B3BD D7 22 D5 20 C9 22  5590         .byte   0xd7,0x22,0xd5,0x20,0xc9,0x22
   B3C3 C7 20 C4 24 C3 20  5591         .byte   0xc7,0x20,0xc4,0x24,0xc3,0x20,0xc2,0x24
        C2 24
   B3CB C1 20 BF 24 BF 24  5592         .byte   0xc1,0x20,0xbf,0x24,0xbf,0x24,0xbe,0x20
        BE 20
   B3D3 BD 24 BC 20 BB 24  5593         .byte   0xbd,0x24,0xbc,0x20,0xbb,0x24,0xba,0x20
        BA 20
   B3DB B9 20 B8 24 B7 20  5594         .byte   0xb9,0x20,0xb8,0x24,0xb7,0x20,0xb4,0x00
        B4 00
   B3E3 B4 00 B2 20 A9 20  5595         .byte   0xb4,0x00,0xb2,0x20,0xa9,0x20,0xa3,0x20
        A3 20
   B3EB A2 20 A1 20 A0 20  5596         .byte   0xa2,0x20,0xa1,0x20,0xa0,0x20,0xa0,0x20
        A0 20
   B3F3 9F 20 9F 20 9E 20  5597         .byte   0x9f,0x20,0x9f,0x20,0x9e,0x20,0x9d,0x24
        9D 24
   B3FB 9D 24 9B 20 9A 24  5598         .byte   0x9d,0x24,0x9b,0x20,0x9a,0x24,0x99,0x20
        99 20
   B403 98 20 97 24 97 24  5599         .byte   0x98,0x20,0x97,0x24,0x97,0x24,0x95,0x20
        95 20
   B40B 95 20 94 00 94 00  5600         .byte   0x95,0x20,0x94,0x00,0x94,0x00,0x93,0x20
        93 20
   B413 92 00 92 00 91 20  5601         .byte   0x92,0x00,0x92,0x00,0x91,0x20,0x90,0x20
        90 20
   B41B 90 20 8F 20 8D 20  5602         .byte   0x90,0x20,0x8f,0x20,0x8d,0x20,0x8d,0x20
        8D 20
   B423 81 00 7F 20 79 00  5603         .byte   0x81,0x00,0x7f,0x20,0x79,0x00,0x79,0x00
        79 00
   B42B 78 20 76 20 6B 00  5604         .byte   0x78,0x20,0x76,0x20,0x6b,0x00,0x69,0x20
        69 20
   B433 5E 00 5C 20 5B 30  5605         .byte   0x5e,0x00,0x5c,0x20,0x5b,0x30,0x52,0x10
        52 10
   B43B 51 30 50 30 50 30  5606         .byte   0x51,0x30,0x50,0x30,0x50,0x30,0x4f,0x20
        4F 20
   B443 4E 20 4E 20 4D 20  5607         .byte   0x4e,0x20,0x4e,0x20,0x4d,0x20,0x46,0xa0
        46 A0
   B44B 45 A0 3D A0 3D A0  5608         .byte   0x45,0xa0,0x3d,0xa0,0x3d,0xa0,0x39,0x20
        39 20
   B453 2A 00 28 20 1E 00  5609         .byte   0x2a,0x00,0x28,0x20,0x1e,0x00,0x1c,0x22
        1C 22
   B45B 1C 22 1B 20 1A 22  5610         .byte   0x1c,0x22,0x1b,0x20,0x1a,0x22,0x19,0x20
        19 20
   B463 18 22 18 22 16 20  5611         .byte   0x18,0x22,0x18,0x22,0x16,0x20,0x15,0x22
        15 22
   B46B 15 22 14 A0 13 A2  5612         .byte   0x15,0x22,0x14,0xa0,0x13,0xa2,0x11,0xa0
        11 A0
   B473 FF FF              5613         .byte   0xff,0xff
                           5614 
   B475                    5615 LB475:
   B475 BE 00 BC 22 BB 30  5616         .byte   0xbe,0x00,0xbc,0x22,0xbb,0x30
   B47B B9 32 B9 32 B7 30  5617         .byte   0xb9,0x32,0xb9,0x32,0xb7,0x30,0xb6,0x32
        B6 32
   B483 B5 30 B4 32 B4 32  5618         .byte   0xb5,0x30,0xb4,0x32,0xb4,0x32,0xb3,0x20
        B3 20
   B48B B3 20 B1 A0 B1 A0  5619         .byte   0xb3,0x20,0xb1,0xa0,0xb1,0xa0,0xb0,0xa2
        B0 A2
   B493 AF A0 AF A6 AE A0  5620         .byte   0xaf,0xa0,0xaf,0xa6,0xae,0xa0,0xae,0xa6
        AE A6
   B49B AD A4 AC A0 AC A0  5621         .byte   0xad,0xa4,0xac,0xa0,0xac,0xa0,0xab,0xa0
        AB A0
   B4A3 AA A0 AA A0 A2 80  5622         .byte   0xaa,0xa0,0xaa,0xa0,0xa2,0x80,0xa0,0xa0
        A0 A0
   B4AB A0 A0 8D 80 8A A0  5623         .byte   0xa0,0xa0,0x8d,0x80,0x8a,0xa0,0x7e,0x80
        7E 80
   B4B3 7B A0 79 A4 78 A0  5624         .byte   0x7b,0xa0,0x79,0xa4,0x78,0xa0,0x77,0xa4
        77 A4
   B4BB 76 A0 75 A4 74 A0  5625         .byte   0x76,0xa0,0x75,0xa4,0x74,0xa0,0x73,0xa4
        73 A4
   B4C3 72 A0 71 A4 70 A0  5626         .byte   0x72,0xa0,0x71,0xa4,0x70,0xa0,0x6f,0xa4
        6F A4
   B4CB 6E A0 6D A4 6C A0  5627         .byte   0x6e,0xa0,0x6d,0xa4,0x6c,0xa0,0x69,0x80
        69 80
   B4D3 69 80 67 A0 5E 20  5628         .byte   0x69,0x80,0x67,0xa0,0x5e,0x20,0x58,0x24
        58 24
   B4DB 57 20 57 20 56 24  5629         .byte   0x57,0x20,0x57,0x20,0x56,0x24,0x55,0x20
        55 20
   B4E3 54 24 54 24 53 20  5630         .byte   0x54,0x24,0x54,0x24,0x53,0x20,0x52,0x24
        52 24
   B4EB 52 24 50 20 4F 24  5631         .byte   0x52,0x24,0x50,0x20,0x4f,0x24,0x4e,0x20
        4E 20
   B4F3 4D 24 4C 20 4C 20  5632         .byte   0x4d,0x24,0x4c,0x20,0x4c,0x20,0x4b,0x24
        4B 24
   B4FB 4A 20 49 20 49 00  5633         .byte   0x4a,0x20,0x49,0x20,0x49,0x00,0x48,0x20
        48 20
   B503 47 20 47 20 46 20  5634         .byte   0x47,0x20,0x47,0x20,0x46,0x20,0x45,0x24
        45 24
   B50B 45 24 44 20 42 20  5635         .byte   0x45,0x24,0x44,0x20,0x42,0x20,0x42,0x20
        42 20
   B513 37 04 35 20 2E 04  5636         .byte   0x37,0x04,0x35,0x20,0x2e,0x04,0x2e,0x04
        2E 04
   B51B 2D 20 23 24 21 20  5637         .byte   0x2d,0x20,0x23,0x24,0x21,0x20,0x17,0x24
        17 24
   B523 13 00 11 24 10 30  5638         .byte   0x13,0x00,0x11,0x24,0x10,0x30,0x07,0x34
        07 34
   B52B 06 30 05 30 FF FF  5639         .byte   0x06,0x30,0x05,0x30,0xff,0xff
                           5640 
   B531                    5641 LB531:
   B531 CD 20              5642         .byte   0xcd,0x20
   B533 CC 20 CB 20 CB 20  5643         .byte   0xcc,0x20,0xcb,0x20,0xcb,0x20,0xca,0x00
        CA 00
   B53B C9 20 C9 20 C8 20  5644         .byte   0xc9,0x20,0xc9,0x20,0xc8,0x20,0xc1,0xa0
        C1 A0
   B543 C0 A0 B8 A0 B8 20  5645         .byte   0xc0,0xa0,0xb8,0xa0,0xb8,0x20,0xb4,0x20
        B4 20
   B54B A6 00 A4 20 99 00  5646         .byte   0xa6,0x00,0xa4,0x20,0x99,0x00,0x97,0x22
        97 22
   B553 97 22 96 20 95 22  5647         .byte   0x97,0x22,0x96,0x20,0x95,0x22,0x94,0x20
        94 20
   B55B 93 22 93 22 91 20  5648         .byte   0x93,0x22,0x93,0x22,0x91,0x20,0x90,0x20
        90 20
   B563 90 20 8D A0 8C A0  5649         .byte   0x90,0x20,0x8d,0xa0,0x8c,0xa0,0x7d,0xa2
        7D A2
   B56B 7D A2 7B A0 7B A0  5650         .byte   0x7d,0xa2,0x7b,0xa0,0x7b,0xa0,0x79,0xa2
        79 A2
   B573 79 A2 77 A0 77 A0  5651         .byte   0x79,0xa2,0x77,0xa0,0x77,0xa0,0x76,0x80
        76 80
   B57B 75 A0 6E 20 67 24  5652         .byte   0x75,0xa0,0x6e,0x20,0x67,0x24,0x66,0x20
        66 20
   B583 65 24 64 20 63 24  5653         .byte   0x65,0x24,0x64,0x20,0x63,0x24,0x63,0x24
        63 24
   B58B 61 20 60 24 5F 20  5654         .byte   0x61,0x20,0x60,0x24,0x5f,0x20,0x5e,0x20
        5E 20
   B593 5D 24 5C 20 5B 24  5655         .byte   0x5d,0x24,0x5c,0x20,0x5b,0x24,0x5a,0x20
        5A 20
   B59B 59 24 58 20 56 20  5656         .byte   0x59,0x24,0x58,0x20,0x56,0x20,0x55,0x04
        55 04
   B5A3 54 00 53 24 52 20  5657         .byte   0x54,0x00,0x53,0x24,0x52,0x20,0x52,0x20
        52 20
   B5AB 4F 24 4F 24 4E 30  5658         .byte   0x4f,0x24,0x4f,0x24,0x4e,0x30,0x4d,0x30
        4D 30
   B5B3 47 10 45 30 35 30  5659         .byte   0x47,0x10,0x45,0x30,0x35,0x30,0x33,0x10
        33 10
   B5BB 31 30 31 30 1D 20  5660         .byte   0x31,0x30,0x31,0x30,0x1d,0x20,0xff,0xff
        FF FF
                           5661 
   B5C3                    5662 LB5C3:
   B5C3 A9 20 A3 20 A2 20  5663         .byte   0xa9,0x20,0xa3,0x20,0xa2,0x20,0xa1,0x20
        A1 20
   B5CB A0 20 A0 20 9F 20  5664         .byte   0xa0,0x20,0xa0,0x20,0x9f,0x20,0x9f,0x20
        9F 20
   B5D3 9E 20 9D 24 9D 24  5665         .byte   0x9e,0x20,0x9d,0x24,0x9d,0x24,0x9b,0x20
        9B 20
   B5DB 9A 24 99 20 98 20  5666         .byte   0x9a,0x24,0x99,0x20,0x98,0x20,0x97,0x24
        97 24
   B5E3 97 24 95 20 95 20  5667         .byte   0x97,0x24,0x95,0x20,0x95,0x20,0x94,0x00
        94 00
   B5EB 94 00 93 20 92 00  5668         .byte   0x94,0x00,0x93,0x20,0x92,0x00,0x92,0x00
        92 00
   B5F3 91 20 90 20 90 20  5669         .byte   0x91,0x20,0x90,0x20,0x90,0x20,0x8f,0x20
        8F 20
   B5FB 8D 20 8D 20 81 00  5670         .byte   0x8d,0x20,0x8d,0x20,0x81,0x00,0x7f,0x20
        7F 20
   B603 79 00 79 00 78 20  5671         .byte   0x79,0x00,0x79,0x00,0x78,0x20,0x76,0x20
        76 20
   B60B 6B 00 69 20 5E 00  5672         .byte   0x6b,0x00,0x69,0x20,0x5e,0x00,0x5c,0x20
        5C 20
   B613 5B 30 52 10 51 30  5673         .byte   0x5b,0x30,0x52,0x10,0x51,0x30,0x50,0x30
        50 30
   B61B 50 30 4F 20 4E 20  5674         .byte   0x50,0x30,0x4f,0x20,0x4e,0x20,0x4e,0x20
        4E 20
   B623 4D 20 46 A0 45 A0  5675         .byte   0x4d,0x20,0x46,0xa0,0x45,0xa0,0x3d,0xa0
        3D A0
   B62B 3D A0 39 20 2A 00  5676         .byte   0x3d,0xa0,0x39,0x20,0x2a,0x00,0x28,0x20
        28 20
   B633 1E 00 1C 22 1C 22  5677         .byte   0x1e,0x00,0x1c,0x22,0x1c,0x22,0x1b,0x20
        1B 20
   B63B 1A 22 19 20 18 22  5678         .byte   0x1a,0x22,0x19,0x20,0x18,0x22,0x18,0x22
        18 22
   B643 16 20 15 22 15 22  5679         .byte   0x16,0x20,0x15,0x22,0x15,0x22,0x14,0xa0
        14 A0
   B64B 13 A2 11 A0        5680         .byte   0x13,0xa2,0x11,0xa0
                           5681 
                           5682 ; All empty (0xFFs) in this gap
                           5683 
   F780                    5684         .org    0xF780
                           5685 
                           5686 ; Tables
   F780                    5687 LF780:
   F780 57                 5688         .byte   0x57
   F781 0B                 5689         .byte   0x0b
   F782 00                 5690         .byte   0x00
   F783 00                 5691         .byte   0x00
   F784 00                 5692         .byte   0x00
   F785 00                 5693         .byte   0x00
   F786 08                 5694         .byte   0x08
   F787 00                 5695         .byte   0x00
   F788 00                 5696         .byte   0x00
   F789 00                 5697         .byte   0x00
   F78A 20                 5698         .byte   0x20
   F78B 00                 5699         .byte   0x00
   F78C 00                 5700         .byte   0x00
   F78D 00                 5701         .byte   0x00
   F78E 80                 5702         .byte   0x80
   F78F 00                 5703         .byte   0x00
   F790 00                 5704         .byte   0x00
   F791 00                 5705         .byte   0x00
   F792 00                 5706         .byte   0x00
   F793 00                 5707         .byte   0x00
   F794 00                 5708         .byte   0x00
   F795 04                 5709         .byte   0x04
   F796 00                 5710         .byte   0x00
   F797 00                 5711         .byte   0x00
   F798 00                 5712         .byte   0x00
   F799 10                 5713         .byte   0x10
   F79A 00                 5714         .byte   0x00
   F79B 00                 5715         .byte   0x00
   F79C 00                 5716         .byte   0x00
   F79D 00                 5717         .byte   0x00
   F79E 00                 5718         .byte   0x00
   F79F 00                 5719         .byte   0x00
                           5720 
   F7A0                    5721 LF7A0:
   F7A0 40                 5722         .byte   0x40
   F7A1 12                 5723         .byte   0x12
   F7A2 20                 5724         .byte   0x20
   F7A3 09                 5725         .byte   0x09
   F7A4 80                 5726         .byte   0x80
   F7A5 24                 5727         .byte   0x24
   F7A6 02                 5728         .byte   0x02
   F7A7 00                 5729         .byte   0x00
   F7A8 40                 5730         .byte   0x40
   F7A9 12                 5731         .byte   0x12
   F7AA 20                 5732         .byte   0x20
   F7AB 09                 5733         .byte   0x09
   F7AC 80                 5734         .byte   0x80
   F7AD 24                 5735         .byte   0x24
   F7AE 04                 5736         .byte   0x04
   F7AF 00                 5737         .byte   0x00
   F7B0 00                 5738         .byte   0x00
   F7B1 00                 5739         .byte   0x00
   F7B2 00                 5740         .byte   0x00
   F7B3 00                 5741         .byte   0x00
   F7B4 00                 5742         .byte   0x00
   F7B5 00                 5743         .byte   0x00
   F7B6 00                 5744         .byte   0x00
   F7B7 00                 5745         .byte   0x00
   F7B8 00                 5746         .byte   0x00
   F7B9 00                 5747         .byte   0x00
   F7BA 00                 5748         .byte   0x00
   F7BB 00                 5749         .byte   0x00
   F7BC 08                 5750         .byte   0x08
   F7BD 00                 5751         .byte   0x00
   F7BE 00                 5752         .byte   0x00
   F7BF 00                 5753         .byte   0x00
                           5754 
   F7C0                    5755 LF7C0:
   F7C0 00                 5756         .byte   0x00
                           5757 ;
                           5758 ; is the rest of this table 0xff, or is this margin??
                           5759 ;
   F800                    5760         .org    0xF800
                           5761 ; Reset
   F800                    5762 RESET:
   F800 0F            [ 2] 5763         sei                 ; disable interrupts
   F801 86 03         [ 2] 5764         ldaa    #0x03
   F803 B7 10 24      [ 4] 5765         staa    TMSK2       ; disable irqs, set prescaler to 16
   F806 86 80         [ 2] 5766         ldaa    #0x80
   F808 B7 10 22      [ 4] 5767         staa    TMSK1       ; enable OC1 irq
   F80B 86 FE         [ 2] 5768         ldaa    #0xFE
   F80D B7 10 35      [ 4] 5769         staa    BPROT       ; protect everything except $xE00-$xE1F
   F810 96 07         [ 3] 5770         ldaa    0x0007      ;
   F812 81 DB         [ 2] 5771         cmpa    #0xDB       ; special unprotect mode???
   F814 26 06         [ 3] 5772         bne     LF81C       ; if not, jump ahead
   F816 7F 10 35      [ 6] 5773         clr     BPROT       ; else unprotect everything
   F819 7F 00 07      [ 6] 5774         clr     0x0007     ; reset special unprotect mode???
   F81C                    5775 LF81C:
   F81C 8E 01 FF      [ 3] 5776         lds     #0x01FF     ; init SP
   F81F 86 A5         [ 2] 5777         ldaa    #0xA5
   F821 B7 10 5D      [ 4] 5778         staa    CSCTL       ; enable external IO:
                           5779                             ; IO1EN,  BUSSEL, active LOW
                           5780                             ; IO2EN,  PIA/SCCSEL, active LOW
                           5781                             ; CSPROG, ROMSEL priority over RAMSEL 
                           5782                             ; CSPROG, ROMSEL enabled, 32K, $8000-$FFFF
   F824 86 01         [ 2] 5783         ldaa    #0x01
   F826 B7 10 5F      [ 4] 5784         staa    CSGSIZ      ; CSGEN,  RAMSEL active low
                           5785                             ; CSGEN,  RAMSEL 32K
   F829 86 00         [ 2] 5786         ldaa    #0x00
   F82B B7 10 5E      [ 4] 5787         staa    CSGADR      ; CSGEN,  RAMSEL = $0000-$7FFF (except internal regs)
   F82E 86 F0         [ 2] 5788         ldaa    #0xF0
   F830 B7 10 5C      [ 4] 5789         staa    CSSTRH      ; 3 cycle clock stretching on BUSSEL and LCRS
   F833 7F 00 00      [ 6] 5790         clr     0x0000      ; ????? Done with basic init?
                           5791 
                           5792 ; Initialize Main PIA
   F836 86 30         [ 2] 5793         ldaa    #0x30       ;
   F838 B7 18 05      [ 4] 5794         staa    PIA0CRA     ; control register A, CA2=0, sel DDRA
   F83B B7 18 07      [ 4] 5795         staa    PIA0CRB     ; control register B, CB2=0, sel DDRB
   F83E 86 FF         [ 2] 5796         ldaa    #0xFF
   F840 B7 18 06      [ 4] 5797         staa    PIA0DDRB    ; select B0-B7 to be outputs
   F843 86 78         [ 2] 5798         ldaa    #0x78       ;
   F845 B7 18 04      [ 4] 5799         staa    PIA0DDRA    ; select A3-A6 to be outputs
   F848 86 34         [ 2] 5800         ldaa    #0x34       ;
   F84A B7 18 05      [ 4] 5801         staa    PIA0CRA     ; select output register A
   F84D B7 18 07      [ 4] 5802         staa    PIA0CRB     ; select output register B
   F850 C6 FF         [ 2] 5803         ldab    #0xFF
   F852 BD F9 C5      [ 6] 5804         jsr     BUTNLIT     ; turn on all button lights
   F855 20 13         [ 3] 5805         bra     LF86A       ; jump past data table
                           5806 
                           5807 ; Data loaded into SCCCTRLB SCC
   F857                    5808 LF857:
   F857 09 4A              5809         .byte   0x09,0x4a   ; channel reset B, master irq enable, no vector
   F859 01 10              5810         .byte   0x01,0x10   ; irq on all character received
   F85B 0C 18              5811         .byte   0x0c,0x18   ; Lower byte of time constant
   F85D 0D 00              5812         .byte   0x0d,0x00   ; Upper byte of time constant
   F85F 04 44              5813         .byte   0x04,0x44   ; X16 clock mode, 8-bit sync char, 1 stop bit, no parity
   F861 0E 63              5814         .byte   0x0e,0x63   ; Disable DPLL, BR enable & source
   F863 05 68              5815         .byte   0x05,0x68   ; No DTR/RTS, Tx 8 bits/char, Tx enable
   F865 0B 56              5816         .byte   0x0b,0x56   ; Rx & Tx & TRxC clk from BR gen
   F867 03 C1              5817         .byte   0x03,0xc1   ; Rx 8 bits/char, Rx Enable
                           5818         ;   tc = 4Mhz / (2 * DesiredRate * BRClockPeriod) - 2
                           5819         ;   DesiredRate=~4800 bps with tc=0x18 and BRClockPeriod=16
   F869 FF                 5820         .byte   0xff        ; end of table marker
                           5821 
                           5822 ; init SCC (8530)
   F86A                    5823 LF86A:
   F86A CE F8 57      [ 3] 5824         ldx     #LF857
   F86D                    5825 LF86D:
   F86D A6 00         [ 4] 5826         ldaa    0,X
   F86F 81 FF         [ 2] 5827         cmpa    #0xFF
   F871 27 06         [ 3] 5828         beq     LF879
   F873 B7 18 0D      [ 4] 5829         staa    SCCCTRLB
   F876 08            [ 3] 5830         inx
   F877 20 F4         [ 3] 5831         bra     LF86D
                           5832 
                           5833 ; Setup normal SCI, 8 data bits, 1 stop bit
                           5834 ; Interrupts disabled, Transmitter and Receiver enabled
                           5835 ; prescaler = /13, SCR=/2, rate = 9600 baud at 16Mhz clock
                           5836 
   F879                    5837 LF879:
   F879 86 00         [ 2] 5838         ldaa    #0x00
   F87B B7 10 2C      [ 4] 5839         staa    SCCR1  
   F87E 86 0C         [ 2] 5840         ldaa    #0x0C
   F880 B7 10 2D      [ 4] 5841         staa    SCCR2  
   F883 86 31         [ 2] 5842         ldaa    #0x31
   F885 B7 10 2B      [ 4] 5843         staa    BAUD  
                           5844 
                           5845 ; Initialize all RAM vectors to RTI: 
                           5846 ; Opcode 0x3b into vectors at 0x0100 through 0x0139
                           5847 
   F888 CE 01 00      [ 3] 5848         ldx     #0x0100
   F88B 86 3B         [ 2] 5849         ldaa    #0x3B       ; RTI opcode
   F88D                    5850 LF88D:
   F88D A7 00         [ 4] 5851         staa    0,X
   F88F 08            [ 3] 5852         inx
   F890 08            [ 3] 5853         inx
   F891 08            [ 3] 5854         inx
   F892 8C 01 3C      [ 4] 5855         cpx     #0x013C
   F895 25 F6         [ 3] 5856         bcs     LF88D
   F897 C6 F0         [ 2] 5857         ldab    #0xF0
   F899 F7 18 04      [ 4] 5858         stab    PIA0PRA     ; enable LCD backlight, disable RESET button light
   F89C 86 7E         [ 2] 5859         ldaa    #0x7E
   F89E 97 03         [ 3] 5860         staa    (0x0003)    ; Put a jump instruction here???
                           5861 
                           5862 ; Non-destructive ram test:
                           5863 ;
                           5864 ; HC11 Internal RAM: 0x0000-0x3ff
                           5865 ; External NVRAM:    0x2000-0x7fff
                           5866 ;
                           5867 ; Note:
                           5868 ; External NVRAM:    0x0400-0xfff is also available, but not tested
                           5869 
   F8A0 CE 00 00      [ 3] 5870         ldx     #0x0000
   F8A3                    5871 LF8A3:
   F8A3 E6 00         [ 4] 5872         ldab    0,X         ; save value
   F8A5 86 55         [ 2] 5873         ldaa    #0x55
   F8A7 A7 00         [ 4] 5874         staa    0,X
   F8A9 A1 00         [ 4] 5875         cmpa    0,X
   F8AB 26 19         [ 3] 5876         bne     LF8C6
   F8AD 49            [ 2] 5877         rola
   F8AE A7 00         [ 4] 5878         staa    0,X
   F8B0 A1 00         [ 4] 5879         cmpa    0,X
   F8B2 26 12         [ 3] 5880         bne     LF8C6
   F8B4 E7 00         [ 4] 5881         stab    0,X         ; restore value
   F8B6 08            [ 3] 5882         inx
   F8B7 8C 04 00      [ 4] 5883         cpx     #0x0400
   F8BA 26 03         [ 3] 5884         bne     LF8BF
   F8BC CE 20 00      [ 3] 5885         ldx     #0x2000
   F8BF                    5886 LF8BF:  
   F8BF 8C 80 00      [ 4] 5887         cpx     #0x8000
   F8C2 26 DF         [ 3] 5888         bne     LF8A3
   F8C4 20 04         [ 3] 5889         bra     LF8CA
                           5890 
   F8C6                    5891 LF8C6:
   F8C6 86 01         [ 2] 5892         ldaa    #0x01       ; Mark Failed RAM test
   F8C8 97 00         [ 3] 5893         staa    (0x0000)
                           5894 ; 
   F8CA                    5895 LF8CA:
   F8CA C6 01         [ 2] 5896         ldab    #0x01
   F8CC BD F9 95      [ 6] 5897         jsr     DIAGDGT     ; write digit 1 to diag display
   F8CF B6 10 35      [ 4] 5898         ldaa    BPROT  
   F8D2 26 0F         [ 3] 5899         bne     LF8E3       ; if something is protected, jump ahead
   F8D4 B6 30 00      [ 4] 5900         ldaa    (0x3000)    ; NVRAM
   F8D7 81 7E         [ 2] 5901         cmpa    #0x7E
   F8D9 26 08         [ 3] 5902         bne     LF8E3       ; if RAM(0x3000) == 0x7E, jump ahead anyway (special unlock?)
                           5903 
                           5904 ; error?
   F8DB C6 0E         [ 2] 5905         ldab    #0x0E
   F8DD BD F9 95      [ 6] 5906         jsr     DIAGDGT      ; write digit E to diag display
   F8E0 7E 30 00      [ 3] 5907         jmp     (0x3000)     ; jump to routine in NVRAM?
                           5908 
                           5909 ; checking for serial connection
                           5910 
   F8E3                    5911 LF8E3:
   F8E3 CE F0 00      [ 3] 5912         ldx     #0xF000     ; timeout counter
   F8E6                    5913 LF8E6:
   F8E6 01            [ 2] 5914         nop
   F8E7 01            [ 2] 5915         nop
   F8E8 09            [ 3] 5916         dex
   F8E9 27 0B         [ 3] 5917         beq     LF8F6       ; if time is up, jump ahead
   F8EB BD F9 45      [ 6] 5918         jsr     SERIALR     ; else read serial data if available
   F8EE 24 F6         [ 3] 5919         bcc     LF8E6       ; if no data available, loop
   F8F0 81 1B         [ 2] 5920         cmpa    #0x1B       ; if serial data was read, is it an ESC?
   F8F2 27 29         [ 3] 5921         beq     LF91D       ; if so, jump to echo hex char routine?
   F8F4 20 F0         [ 3] 5922         bra     LF8E6       ; else loop
   F8F6                    5923 LF8F6:
   F8F6 B6 80 00      [ 4] 5924         ldaa    L8000       ; check if this is a regular rom?
   F8F9 81 7E         [ 2] 5925         cmpa    #0x7E        
   F8FB 26 0B         [ 3] 5926         bne     MINIMON     ; if not, jump ahead
                           5927 
   F8FD C6 0A         [ 2] 5928         ldab    #0x0A
   F8FF BD F9 95      [ 6] 5929         jsr     DIAGDGT     ; else write digit A to diag display
                           5930 
   F902 BD 80 00      [ 6] 5931         jsr     L8000       ; jump to start of rom routine
   F905 0F            [ 2] 5932         sei                 ; if we ever come return, just loop and do it all again
   F906 20 EE         [ 3] 5933         bra     LF8F6
                           5934 
                           5935 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           5936 
   F908                    5937 MINIMON:
   F908 C6 10         [ 2] 5938         ldab    #0x10       ; not a regular rom
   F90A BD F9 95      [ 6] 5939         jsr     DIAGDGT     ; blank the diag display
                           5940 
   F90D BD F9 D8      [ 6] 5941         jsr     SERMSGW     ; enter the mini-monitor???
   F910 4D 49 4E 49 2D 4D  5942         .ascis  'MINI-MON'
        4F CE
                           5943 
   F918 C6 10         [ 2] 5944         ldab    #0x10
   F91A BD F9 95      [ 6] 5945         jsr     DIAGDGT     ; blank the diag display
                           5946 
   F91D                    5947 LF91D:
   F91D 7F 00 05      [ 6] 5948         clr     (0x0005)
   F920 7F 00 04      [ 6] 5949         clr     (0x0004)
   F923 7F 00 02      [ 6] 5950         clr     (0x0002)
   F926 7F 00 06      [ 6] 5951         clr     (0x0006)
                           5952 
   F929 BD F9 D8      [ 6] 5953         jsr     SERMSGW
   F92C 0D 0A BE           5954         .ascis  '\r\n>'
                           5955 
                           5956 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           5957 
                           5958 ; convert A to 2 hex digits and transmit
   F92F                    5959 SERHEXW:
   F92F 36            [ 3] 5960         psha
   F930 44            [ 2] 5961         lsra
   F931 44            [ 2] 5962         lsra
   F932 44            [ 2] 5963         lsra
   F933 44            [ 2] 5964         lsra
   F934 BD F9 38      [ 6] 5965         jsr     LF938
   F937 32            [ 4] 5966         pula
   F938                    5967 LF938:
   F938 84 0F         [ 2] 5968         anda    #0x0F
   F93A 8A 30         [ 2] 5969         oraa    #0x30
   F93C 81 3A         [ 2] 5970         cmpa    #0x3A
   F93E 25 02         [ 3] 5971         bcs     LF942
   F940 8B 07         [ 2] 5972         adda    #0x07
   F942                    5973 LF942:
   F942 7E F9 6F      [ 3] 5974         jmp     SERIALW
                           5975 
                           5976 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           5977 
                           5978 ; serial read non-blocking
   F945                    5979 SERIALR:
   F945 B6 10 2E      [ 4] 5980         ldaa    SCSR  
   F948 85 20         [ 2] 5981         bita    #0x20
   F94A 26 09         [ 3] 5982         bne     LF955
   F94C 0C            [ 2] 5983         clc
   F94D 39            [ 5] 5984         rts
                           5985 
                           5986 ; serial blocking read
   F94E                    5987 SERBLKR:
   F94E B6 10 2E      [ 4] 5988         ldaa    SCSR        ; read serial status
   F951 85 20         [ 2] 5989         bita    #0x20
   F953 27 F9         [ 3] 5990         beq     SERBLKR     ; if RDRF=0, loop
                           5991 
                           5992 ; read serial data, (assumes it's ready)
   F955                    5993 LF955:
   F955 B6 10 2E      [ 4] 5994         ldaa    SCSR        ; read serial status
   F958 85 02         [ 2] 5995         bita    #0x02
   F95A 26 09         [ 3] 5996         bne     LF965       ; if FE=1, clear it
   F95C 85 08         [ 2] 5997         bita    #0x08
   F95E 26 05         [ 3] 5998         bne     LF965       ; if OR=1, clear it
   F960 B6 10 2F      [ 4] 5999         ldaa    SCDR        ; otherwise, good data
   F963 0D            [ 2] 6000         sec
   F964 39            [ 5] 6001         rts
                           6002 
   F965                    6003 LF965:
   F965 B6 10 2F      [ 4] 6004         ldaa    SCDR        ; clear any error
   F968 86 2F         [ 2] 6005         ldaa    #0x2F       ; '/'   
   F96A BD F9 6F      [ 6] 6006         jsr     SERIALW
   F96D 20 DF         [ 3] 6007         bra     SERBLKR     ; go to wait for a character
                           6008 
                           6009 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           6010 
                           6011 ; Send A to SCI with CR turned to CRLF
   F96F                    6012 SERIALW:
   F96F 81 0D         [ 2] 6013         cmpa    #0x0D       ; CR?
   F971 27 02         [ 3] 6014         beq     LF975       ; if so echo CR+LF
   F973 20 07         [ 3] 6015         bra     SERRAWW     ; else just echo it
   F975                    6016 LF975:
   F975 86 0D         [ 2] 6017         ldaa    #0x0D
   F977 BD F9 7C      [ 6] 6018         jsr     SERRAWW
   F97A 86 0A         [ 2] 6019         ldaa    #0x0A
                           6020 
                           6021 ; send a char to SCI
   F97C                    6022 SERRAWW:
   F97C F6 10 2E      [ 4] 6023         ldab    SCSR        ; wait for ready to send
   F97F C5 40         [ 2] 6024         bitb    #0x40
   F981 27 F9         [ 3] 6025         beq     SERRAWW
   F983 B7 10 2F      [ 4] 6026         staa    SCDR        ; send it
   F986 39            [ 5] 6027         rts
                           6028 
                           6029 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           6030 
                           6031 ; Unused?
   F987                    6032 LF987:
   F987 BD F9 4E      [ 6] 6033         jsr     SERBLKR     ; get a serial char
   F98A 81 7A         [ 2] 6034         cmpa    #0x7A       ;'z'
   F98C 22 06         [ 3] 6035         bhi     LF994
   F98E 81 61         [ 2] 6036         cmpa    #0x61       ;'a'
   F990 25 02         [ 3] 6037         bcs     LF994
   F992 82 20         [ 2] 6038         sbca    #0x20       ;convert to upper case?
   F994                    6039 LF994:
   F994 39            [ 5] 6040         rts
                           6041 
                           6042 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           6043 
                           6044 ; Write hex digit arg in B to diagnostic lights
                           6045 ; or B=0x10 or higher for blank
                           6046 
   F995                    6047 DIAGDGT:
   F995 36            [ 3] 6048         psha
   F996 C1 11         [ 2] 6049         cmpb    #0x11
   F998 25 02         [ 3] 6050         bcs     LF99C
   F99A C6 10         [ 2] 6051         ldab    #0x10
   F99C                    6052 LF99C:
   F99C CE F9 B4      [ 3] 6053         ldx     #LF9B4
   F99F 3A            [ 3] 6054         abx
   F9A0 A6 00         [ 4] 6055         ldaa    0,X
   F9A2 B7 18 06      [ 4] 6056         staa    PIA0PRB     ; write arg to local data bus
   F9A5 B6 18 04      [ 4] 6057         ldaa    PIA0PRA     ; read from Port A
   F9A8 8A 20         [ 2] 6058         oraa    #0x20       ; bit 5 high
   F9AA B7 18 04      [ 4] 6059         staa    PIA0PRA     ; write back to Port A
   F9AD 84 DF         [ 2] 6060         anda    #0xDF       ; bit 5 low
   F9AF B7 18 04      [ 4] 6061         staa    PIA0PRA     ; write back to Port A
   F9B2 32            [ 4] 6062         pula
   F9B3 39            [ 5] 6063         rts
                           6064 
                           6065 ; 7 segment patterns - XGFEDCBA
   F9B4                    6066 LF9B4:
   F9B4 C0                 6067         .byte   0xc0    ; 0
   F9B5 F9                 6068         .byte   0xf9    ; 1
   F9B6 A4                 6069         .byte   0xa4    ; 2
   F9B7 B0                 6070         .byte   0xb0    ; 3
   F9B8 99                 6071         .byte   0x99    ; 4
   F9B9 92                 6072         .byte   0x92    ; 5
   F9BA 82                 6073         .byte   0x82    ; 6
   F9BB F8                 6074         .byte   0xf8    ; 7
   F9BC 80                 6075         .byte   0x80    ; 8
   F9BD 90                 6076         .byte   0x90    ; 9
   F9BE 88                 6077         .byte   0x88    ; A 
   F9BF 83                 6078         .byte   0x83    ; b
   F9C0 C6                 6079         .byte   0xc6    ; C
   F9C1 A1                 6080         .byte   0xa1    ; d
   F9C2 86                 6081         .byte   0x86    ; E
   F9C3 8E                 6082         .byte   0x8e    ; F
   F9C4 FF                 6083         .byte   0xff    ; blank
                           6084 
                           6085 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           6086 
                           6087 ; Write arg in B to Button Lights
   F9C5                    6088 BUTNLIT:
   F9C5 36            [ 3] 6089         psha
   F9C6 F7 18 06      [ 4] 6090         stab    PIA0PRB     ; write arg to local data bus
   F9C9 B6 18 04      [ 4] 6091         ldaa    PIA0PRA     ; read from Port A
   F9CC 84 EF         [ 2] 6092         anda    #0xEF       ; bit 4 low
   F9CE B7 18 04      [ 4] 6093         staa    PIA0PRA     ; write back to Port A
   F9D1 8A 10         [ 2] 6094         oraa    #0x10       ; bit 4 high
   F9D3 B7 18 04      [ 4] 6095         staa    PIA0PRA     ; write this to Port A
   F9D6 32            [ 4] 6096         pula
   F9D7 39            [ 5] 6097         rts
                           6098 
                           6099 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           6100 
                           6101 ; Send rom message via SCI
   F9D8                    6102 SERMSGW:
   F9D8 18 38         [ 6] 6103         puly
   F9DA                    6104 LF9DA:
   F9DA 18 A6 00      [ 5] 6105         ldaa    0,Y
   F9DD 27 09         [ 3] 6106         beq     LF9E8       ; if zero terminated, return
   F9DF 2B 0C         [ 3] 6107         bmi     LF9ED       ; if high bit set..do last char and return
   F9E1 BD F9 7C      [ 6] 6108         jsr     SERRAWW     ; else send char
   F9E4 18 08         [ 4] 6109         iny
   F9E6 20 F2         [ 3] 6110         bra     LF9DA       ; and loop for next one
                           6111 
   F9E8                    6112 LF9E8:
   F9E8 18 08         [ 4] 6113         iny                 ; setup return address and return
   F9EA 18 3C         [ 5] 6114         pshy
   F9EC 39            [ 5] 6115         rts
                           6116 
   F9ED                    6117 LF9ED:
   F9ED 84 7F         [ 2] 6118         anda    #0x7F       ; remove top bit
   F9EF BD F9 7C      [ 6] 6119         jsr     SERRAWW     ; send char
   F9F2 20 F4         [ 3] 6120         bra     LF9E8       ; and we're done
   F9F4 39            [ 5] 6121         rts
                           6122 
   F9F5                    6123 DORTS:
   F9F5 39            [ 5] 6124         rts
   F9F6                    6125 DORTI:        
   F9F6 3B            [12] 6126         rti
                           6127 
                           6128 ; all 0xffs in this gap
                           6129 
   FFA0                    6130         .org    0xFFA0
                           6131 
   FFA0 7E F9 F5      [ 3] 6132         jmp     DORTS
   FFA3 7E F9 F5      [ 3] 6133         jmp     DORTS
   FFA6 7E F9 F5      [ 3] 6134         jmp     DORTS
   FFA9 7E F9 2F      [ 3] 6135         jmp     SERHEXW
   FFAC 7E F9 D8      [ 3] 6136         jmp     SERMSGW      
   FFAF 7E F9 45      [ 3] 6137         jmp     SERIALR     
   FFB2 7E F9 6F      [ 3] 6138         jmp     SERIALW      
   FFB5 7E F9 08      [ 3] 6139         jmp     MINIMON
   FFB8 7E F9 95      [ 3] 6140         jmp     DIAGDGT 
   FFBB 7E F9 C5      [ 3] 6141         jmp     BUTNLIT 
                           6142 
   FFBE FF                 6143        .byte    0xff
   FFBF FF                 6144        .byte    0xff
                           6145 
                           6146 ; Vectors
                           6147 
   FFC0 F9 F6              6148        .word   DORTI        ; Stub RTI
   FFC2 F9 F6              6149        .word   DORTI        ; Stub RTI
   FFC4 F9 F6              6150        .word   DORTI        ; Stub RTI
   FFC6 F9 F6              6151        .word   DORTI        ; Stub RTI
   FFC8 F9 F6              6152        .word   DORTI        ; Stub RTI
   FFCA F9 F6              6153        .word   DORTI        ; Stub RTI
   FFCC F9 F6              6154        .word   DORTI        ; Stub RTI
   FFCE F9 F6              6155        .word   DORTI        ; Stub RTI
   FFD0 F9 F6              6156        .word   DORTI        ; Stub RTI
   FFD2 F9 F6              6157        .word   DORTI        ; Stub RTI
   FFD4 F9 F6              6158        .word   DORTI        ; Stub RTI
                           6159 
   FFD6 01 00              6160         .word  0x0100       ; SCI
   FFD8 01 03              6161         .word  0x0103       ; SPI
   FFDA 01 06              6162         .word  0x0106       ; PA accum. input edge
   FFDC 01 09              6163         .word  0x0109       ; PA Overflow
                           6164 
   FFDE F9 F6              6165         .word  DORTI        ; Stub RTI
                           6166 
   FFE0 01 0C              6167         .word  0x010c       ; TI4O5
   FFE2 01 0F              6168         .word  0x010f       ; TOC4
   FFE4 01 12              6169         .word  0x0112       ; TOC3
   FFE6 01 15              6170         .word  0x0115       ; TOC2
   FFE8 01 18              6171         .word  0x0118       ; TOC1
   FFEA 01 1B              6172         .word  0x011b       ; TIC3
   FFEC 01 1E              6173         .word  0x011e       ; TIC2
   FFEE 01 21              6174         .word  0x0121       ; TIC1
   FFF0 01 24              6175         .word  0x0124       ; RTI
   FFF2 01 27              6176         .word  0x0127       ; ~IRQ
   FFF4 01 2A              6177         .word  0x012a       ; XIRQ
   FFF6 01 2D              6178         .word  0x012d       ; SWI
   FFF8 01 30              6179         .word  0x0130       ; ILLEGAL OPCODE
   FFFA 01 33              6180         .word  0x0133       ; COP Failure
   FFFC 01 36              6181         .word  0x0136       ; COP Clock Monitor Fail
                           6182 
   FFFE F8 00              6183         .word  RESET        ; Reset
                           6184 
