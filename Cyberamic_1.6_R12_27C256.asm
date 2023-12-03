
; Disassembly from unidasm

8000: 7e 80 50     jmp (0x8050)

8003-804f: Copyright (c) 1993 by David B. Philipsen Licensed by ShowBiz Pizza Time, Inc.

8050: 0f           sei
8051: fc 04 26     ldd (0x0426)
8054: c3 00 01     addd 0x0001
8057: fd 04 26     std (0x0426)
805a: ce ad 1d     ldx 0xAD1D
805d: ff 01 ce     stx (0x01CE)
8060: 7f 01 c7     clr (0x01C7)
8063: cc 01 c6     ldd 0x01C6
8066: fd 01 3e     std (0x013E)
8069: 7f 00 b0     clr (0x00B0)
806c: 7f 00 4e     clr (0x004E)
806f: 7f 00 b6     clr (0x00B6)
8072: 7f 00 4d     clr (0x004D)
8075: 86 03        ldaa 0x03
8077: b7 10 a8     staa (0x10A8)
807a: 18 ce 00 80  ldy 0x0080
807e: 18 09        dey
8080: 26 fc        bne [0x807E]
8082: 86 11        ldaa 0x11
8084: b7 10 a8     staa (0x10A8)
8087: c6 10        ldab 0x10
8089: bd f9 95     jsr (0xF995)
808c: b6 18 04     ldaa (0x1804)
808f: 84 bf        anda 0xBF
8091: b7 18 04     staa (0x1804)
8094: 86 ff        ldaa 0xFF
8096: 97 ac        staa (0x00AC)
8098: bd 86 c4     jsr (0x86C4)
809b: bd 99 a6     jsr (0x99A6)
809e: bd 8c 3c     jsr (0x8C3C)
80a1: bd 87 e8     jsr (0x87E8)
80a4: bd 87 bc     jsr (0x87BC)
80a7: bd 8c 7e     jsr (0x8C7E)
80aa: bd 8d 29     jsr (0x8D29)
80ad: bd 8b c0     jsr (0x8BC0)
80b0: bd 8b ee     jsr (0x8BEE)
80b3: 0e           cli
80b4: bd a2 5e     jsr (0xA25E)
80b7: b6 04 0f     ldaa (0x040F)
80ba: 81 01        cmpa 0x01
80bc: 26 03        bne [0x80C1]
80be: 7e a2 75     jmp (0xA275)
80c1: fc 04 0b     ldd (0x040B)
80c4: 1a 83 19 7b  cpd 0x197B
80c8: 26 4f        bne [0x8119]
80ca: 5f           clrb
80cb: d7 62        stab (0x0062)
80cd: bd f9 c5     jsr (0xF9C5)
80d0: bd a3 41     jsr (0xA341)
80d3: b6 04 00     ldaa (0x0400)
80d6: 81 07        cmpa 0x07
80d8: 27 42        beq [0x811C]
80da: 25 29        bcs [0x8105]
80dc: 81 06        cmpa 0x06
80de: 27 25        beq [0x8105]
80e0: cc 00 00     ldd 0x0000
80e3: fd 04 0d     std (0x040D)
80e6: cc 00 c8     ldd 0x00C8
80e9: dd 1b        std (0x001B)
80eb: dc 1b        ldd (0x001B)
80ed: 27 0b        beq [0x80FA]
80ef: bd f9 45     jsr (0xF945)
80f2: 24 f7        bcc [0x80EB]
80f4: 81 44        cmpa 0x44
80f6: 26 f3        bne [0x80EB]
80f8: 20 05        bra [0x80FF]
80fa: bd 9f 1e     jsr (0x9F1E)
80fd: 25 1a        bcs [0x8119]
80ff: bd 9e af     jsr (0x9EAF)
8102: bd 9e 92     jsr (0x9E92)
8105: 86 39        ldaa 0x39
8107: b7 04 08     staa (0x0408)
810a: bd a1 d5     jsr (0xA1D5)
810d: bd ab 17     jsr (0xAB17)
8110: b6 f7 c0     ldaa (0xF7C0)
8113: b7 04 5c     staa (0x045C)
8116: 7e f8 00     jmp (0xF800)
8119: 7e 81 19     jmp (0x8119)
811c: 7f 00 79     clr (0x0079)
811f: 7f 00 7c     clr (0x007C)
8122: bd 04 08     jsr (0x0408)
8125: bd 80 13     jsr (0x8013)
8128: c6 fd        ldab 0xFD
812a: bd 86 e7     jsr (0x86E7)
812d: c6 df        ldab 0xDF
812f: bd 87 48     jsr (0x8748)
8132: bd 87 91     jsr (0x8791)
8135: bd 9a f7     jsr (0x9AF7)
8138: bd 9c 51     jsr (0x9C51)
813b: 7f 00 62     clr (0x0062)
813e: bd 99 d9     jsr (0x99D9)
8141: 24 16        bcc [0x8159]
8143: bd 8d e4     jsr (0x8DE4)

8146: 49           rola
8147: 6e 76        jmp (X+0x76)
8149: 61           ?
814a: 6c 69        inc (X+0x69)
814c: 64 20        lsr (X+0x20)
814e: 43           coma
814f: 50           negb
8150: 55           ?
8151: a1 86        cmpa (X+0x86)
8153: 53           comb
8154: 7e 82 a4     jmp (0x82A4)
8157: 20 fe        bra [0x8157]
8159: bd a3 54     jsr (0xA354)
815c: 7f 00 aa     clr (0x00AA)
815f: 7d 00 00     tst (0x0000)
8162: 27 15        beq [0x8179]
8164: bd 8d e4     jsr (0x8DE4)
8167: 52           ?
8168: 41           ?
8169: 4d           tsta
816a: 20 74        bra [0x81E0]
816c: 65           ?
816d: 73 74 20     com (0x7420)
8170: 66 61        ror (X+0x61)
8172: 69 6c        rol (X+0x6C)
8174: 65           ?
8175: 64 a1        lsr (X+0xA1)
8177: 20 44        bra [0x81BD]
8179: bd 8d e4     jsr (0x8DE4)
817c: 33           pulb
817d: 32           pula
817e: 4b           ?
817f: 20 52        bra [0x81D3]
8181: 41           ?
8182: 4d           tsta
8183: 20 4f        bra [0x81D4]
8185: cb 7d        addb 0x7D
8187: 04           lsrd
8188: 5c           incb
8189: 26 08        bne [0x8193]
818b: cc 52 0f     ldd 0x520F
818e: bd 8d b5     jsr (0x8DB5)
8191: 20 06        bra [0x8199]
8193: cc 43 0f     ldd 0x430F
8196: bd 8d b5     jsr (0x8DB5)
8199: bd 8d dd     jsr (0x8DDD)
819c: 52           ?
819d: 4f           clra
819e: 4d           tsta
819f: 20 43        bra [0x81E4]
81a1: 68 6b        asl (X+0x6B)
81a3: 73 75 6d     com (0x756D)
81a6: bd bd 97     jsr (0xBD97)
81a9: 5f           clrb
81aa: c6 02        ldab 0x02
81ac: bd 8c 02     jsr (0x8C02)
81af: bd 9a 27     jsr (0x9A27)
81b2: bd 9e cc     jsr (0x9ECC)
81b5: bd 9b 19     jsr (0x9B19)
81b8: c6 02        ldab 0x02
81ba: bd 8c 02     jsr (0x8C02)
81bd: f6 10 2d     ldab (SCCR2)
81c0: c4 df        andb 0xDF
81c2: f7 10 2d     stab (SCCR2)
81c5: bd 9a f7     jsr (0x9AF7)
81c8: c6 fd        ldab 0xFD
81ca: bd 86 e7     jsr (0x86E7)
81cd: bd 87 91     jsr (0x8791)
81d0: c6 00        ldab 0x00
81d2: d7 62        stab (0x0062)
81d4: bd f9 c5     jsr (0xF9C5)
81d7: bd 8d e4     jsr (0x8DE4)
81da: 20 43        bra [0x821F]
81dc: 79 62 65     rol (0x6265)
81df: 72           ?
81e0: 73 74 61     com (0x7461)
81e3: 72           ?
81e4: 20 76        bra [0x825C]
81e6: 31           ins
81e7: 2e b6        bgt [0x819F]
81e9: bd a2 df     jsr (0xA2DF)
81ec: 24 11        bcc [0x81FF]
81ee: cc 52 0f     ldd 0x520F
81f1: bd 8d b5     jsr (0x8DB5)
81f4: 7d 04 2a     tst (0x042A)
81f7: 27 06        beq [0x81FF]
81f9: cc 4b 0f     ldd 0x4B0F
81fc: bd 8d b5     jsr (0x8DB5)
81ff: bd 8d 03     jsr (0x8D03)
8202: fc 02 9c     ldd (0x029C)
8205: 1a 83 00 01  cpd 0x0001
8209: 26 15        bne [0x8220]
820b: bd 8d dd     jsr (0x8DDD)
820e: 20 44        bra [0x8254]
8210: 61           ?
8211: 76 65 27     ror (0x6527)
8214: 73 20 73     com (0x2073)
8217: 79 73 74     rol (0x7374)
821a: 65           ?
821b: 6d 20        tst (X+0x20)
821d: a0 20        suba (X+0x20)
821f: 47           asra
8220: 1a 83 03 e8  cpd 0x03E8
8224: 2d 1b        blt [0x8241]
8226: 1a 83 04 4b  cpd 0x044B
822a: 22 15        bhi [0x8241]
822c: bd 8d dd     jsr (0x8DDD)
822f: 20 20        bra [0x8251]
8231: 20 53        bra [0x8286]
8233: 50           negb
8234: 54           lsrb
8235: 20 53        bra [0x828A]
8237: 74 75 64     lsr (0x7564)
823a: 69 6f        rol (X+0x6F)
823c: 20 20        bra [0x825E]
823e: a0 20        suba (X+0x20)
8240: 26 cc        bne [0x820E]
8242: 0e           cli
8243: 0c           clc
8244: dd ad        std (0x00AD)
8246: fc 04 0d     ldd (0x040D)
8249: 1a 83 02 58  cpd 0x0258
824d: 22 05        bhi [0x8254]
824f: cc 0e 09     ldd 0x0E09
8252: dd ad        std (0x00AD)
8254: c6 29        ldab 0x29
8256: ce 0e 00     ldx 0x0E00
8259: a6 00        ldaa (X+0x00)
825b: 4a           deca
825c: 08           inx
825d: 5c           incb
825e: 3c           pshx
825f: bd 8d b5     jsr (0x8DB5)
8262: 38           pulx
8263: 9c ad        cpx (0x00AD)
8265: 26 f2        bne [0x8259]
8267: bd 9c 51     jsr (0x9C51)
826a: 7f 00 5b     clr (0x005B)
826d: 7f 00 5a     clr (0x005A)
8270: 7f 00 5e     clr (0x005E)
8273: 7f 00 60     clr (0x0060)
8276: bd 9b 19     jsr (0x9B19)
8279: 96 60        ldaa (0x0060)
827b: 27 06        beq [0x8283]
827d: bd a9 7c     jsr (0xA97C)
8280: 7e f8 00     jmp (0xF800)
8283: b6 18 04     ldaa (0x1804)
8286: 84 06        anda 0x06
8288: 26 08        bne [0x8292]
828a: bd 9c f1     jsr (0x9CF1)
828d: c6 32        ldab 0x32
828f: bd 8c 22     jsr (0x8C22)
8292: bd 8e 95     jsr (0x8E95)
8295: 81 0d        cmpa 0x0D
8297: 26 03        bne [0x829C]
8299: 7e 92 92     jmp (0x9292)
829c: bd f9 45     jsr (0xF945)
829f: 25 03        bcs [0x82A4]
82a1: 7e 83 33     jmp (0x8333)
82a4: 81 44        cmpa 0x44
82a6: 26 03        bne [0x82AB]
82a8: 7e a3 66     jmp (0xA366)
82ab: 81 53        cmpa 0x53
82ad: 26 f2        bne [0x82A1]

82af: bd f9 d8     jsr (0xF9D8)

'\n\rEnter security code: '

82b2: 0a           clv  
82b3: 0d           sec
82b4: 45           ?
82b5: 6e 74        jmp (X+0x74)
82b7: 65           ?
82b8: 72           ?
82b9: 20 73        bra [0x832E]
82bb: 65           ?
82bc: 63 75        com (X+0x75)
82be: 72           ?
82bf: 69 74        rol (X+0x74)
82c1: 79 20 63     rol (0x2063)
82c4: 6f 64        clr (X+0x64)
82c6: 65           ?
82c7: 3a           abx
82c8: a0 

82c9: 0f           sei
82ca: bd a2 ea     jsr (0xA2EA)
82cd: 0e           cli
82ce: 25 61        bcs [0x8331]

82d0: bd f9 d8     jsr (0xF9D8)

'\r\nEEPROM serial number programming enabled.'
'\r\nPlease RESET the processor to continue\r\n'

82d3: 0a           clv
82d4: 0d           sec
82d5: 45           ?
82d6: 45           ?
82d7: 50           negb
82d8: 52           ?
82d9: 4f           clra
82da: 4d           tsta
82db: 20 73        bra [0x8350]
82dd: 65           ?
82de: 72           ?
82df: 69 61        rol (X+0x61)
82e1: 6c 20        inc (X+0x20)
82e3: 6e 75        jmp (X+0x75)
82e5: 6d 62        tst (X+0x62)
82e7: 65           ?
82e8: 72           ?
82e9: 20 70        bra [0x835B]
82eb: 72           ?
82ec: 6f 67        clr (X+0x67)
82ee: 72           ?
82ef: 61           ?
82f0: 6d 6d        tst (X+0x6D)
82f2: 69 6e        rol (X+0x6E)
82f4: 67 20        asr (X+0x20)
82f6: 65           ?
82f7: 6e 61        jmp (X+0x61)
82f9: 62           ?
82fa: 6c 65        inc (X+0x65)
82fc: 64 2e        lsr (X+0x2E)
82fe: 0a           clv
82ff: 0d           sec
8300: 50           negb
8301: 6c 65        inc (X+0x65)
8303: 61           ?
8304: 73 65 20     com (0x6520)
8307: 52           ?
8308: 45           ?
8309: 53           comb
830a: 45           ?
830b: 54           lsrb
830c: 20 74        bra [0x8382]
830e: 68 65        asl (X+0x65)
8310: 20 70        bra [0x8382]
8312: 72           ?
8313: 6f 63        clr (X+0x63)
8315: 65           ?
8316: 73 73 6f     com (0x736F)
8319: 72           ?
831a: 20 74        bra [0x8390]
831c: 6f 20        clr (X+0x20)
831e: 63 6f        com (X+0x6F)
8320: 6e 74        jmp (X+0x74)
8322: 69 6e        rol (X+0x6E)
8324: 75           ?
8325: 65           ?
8326: 0a           clv
8327: 8d 

8328: 86 01        ldaa 0x01
832a: b7 04 0f     staa (0x040F)
832d: 86 db        ldaa 0xDB
832f: 97 07        staa (0x0007)
8331: 20 fe        bra [0x8331]
8333: 96 aa        ldaa (0x00AA)
8335: 27 12        beq [0x8349]
8337: dc 1b        ldd (0x001B)
8339: 26 0e        bne [0x8349]
833b: d6 62        ldab (0x0062)
833d: c8 20        eorb 0x20
833f: d7 62        stab (0x0062)
8341: bd f9 c5     jsr (0xF9C5)
8344: cc 00 32     ldd 0x0032
8347: dd 1b        std (0x001B)
8349: bd 86 a4     jsr (0x86A4)
834c: 24 03        bcc [0x8351]
834e: 7e 82 76     jmp (0x8276)
8351: f6 10 2d     ldab (SCCR2)
8354: ca 20        orab 0x20
8356: f7 10 2d     stab (SCCR2)
8359: 7f 00 aa     clr (0x00AA)
835c: d6 62        ldab (0x0062)
835e: c4 df        andb 0xDF
8360: d7 62        stab (0x0062)
8362: bd f9 c5     jsr (0xF9C5)
8365: c6 02        ldab 0x02
8367: bd 8c 02     jsr (0x8C02)
836a: 96 7c        ldaa (0x007C)
836c: 27 2d        beq [0x839B]
836e: 96 7f        ldaa (0x007F)
8370: 97 4e        staa (0x004E)
8372: d6 81        ldab (0x0081)
8374: bd 87 48     jsr (0x8748)
8377: 96 82        ldaa (0x0082)
8379: 85 01        bita 0x01
837b: 26 06        bne [0x8383]
837d: 96 ac        ldaa (0x00AC)
837f: 84 fd        anda 0xFD
8381: 20 04        bra [0x8387]
8383: 96 ac        ldaa (0x00AC)
8385: 8a 02        oraa 0x02
8387: 97 ac        staa (0x00AC)
8389: b7 18 06     staa (0x1806)
838c: b6 18 04     ldaa (0x1804)
838f: 8a 20        oraa 0x20
8391: b7 18 04     staa (0x1804)
8394: 84 df        anda 0xDF
8396: b7 18 04     staa (0x1804)
8399: 20 14        bra [0x83AF]
839b: fc 04 0d     ldd (0x040D)
839e: 1a 83 fd e8  cpd 0xFDE8
83a2: 22 06        bhi [0x83AA]
83a4: c3 00 01     addd 0x0001
83a7: fd 04 0d     std (0x040D)
83aa: c6 f7        ldab 0xF7
83ac: bd 86 e7     jsr (0x86E7)
83af: 7f 00 30     clr (0x0030)
83b2: 7f 00 31     clr (0x0031)
83b5: 7f 00 32     clr (0x0032)
83b8: bd 9b 19     jsr (0x9B19)
83bb: bd 86 a4     jsr (0x86A4)
83be: 25 ef        bcs [0x83AF]
83c0: 96 79        ldaa (0x0079)
83c2: 27 17        beq [0x83DB]
83c4: 7f 00 79     clr (0x0079)
83c7: 96 b5        ldaa (0x00B5)
83c9: 81 01        cmpa 0x01
83cb: 26 07        bne [0x83D4]
83cd: 7f 00 b5     clr (0x00B5)
83d0: 86 01        ldaa 0x01
83d2: 97 7c        staa (0x007C)
83d4: 86 01        ldaa 0x01
83d6: 97 aa        staa (0x00AA)
83d8: 7e 9a 7f     jmp (0x9A7F)
83db: bd 8d e4     jsr (0x8DE4)
83de: 20 20        bra [0x8400]
83e0: 20 54        bra [0x8436]
83e2: 61           ?
83e3: 70 65 20     neg (0x6520)
83e6: 73 74 61     com (0x7461)
83e9: 72           ?
83ea: 74 20 20     lsr (0x2020)
83ed: a0 d6        suba (X+0xD6)
83ef: 62           ?
83f0: ca 80        orab 0x80
83f2: d7 62        stab (0x0062)
83f4: bd f9 c5     jsr (0xF9C5)
83f7: c6 fb        ldab 0xFB
83f9: bd 86 e7     jsr (0x86E7)
83fc: bd 8d cf     jsr (0x8DCF)
83ff: 36           psha
8400: 38           pulx
8401: 48           asla
8402: 43           coma
8403: 31           ins
8404: 31           ins
8405: 20 50        bra [0x8457]
8407: 72           ?
8408: 6f 74        clr (X+0x74)
840a: ef bd        stx (X+0xBD)
840c: 8d d6        bsr [0x83E4]
840e: 64 62        lsr (X+0x62)
8410: f0 c6 03     subb (0xC603)
8413: bd 8c 02     jsr (0x8C02)
8416: 7d 00 7c     tst (0x007C)
8419: 27 15        beq [0x8430]
841b: d6 80        ldab (0x0080)
841d: d7 62        stab (0x0062)
841f: bd f9 c5     jsr (0xF9C5)
8422: d6 7d        ldab (0x007D)
8424: d7 78        stab (0x0078)
8426: d6 7e        ldab (0x007E)
8428: f7 10 8a     stab (0x108A)
842b: 7f 00 7c     clr (0x007C)
842e: 20 1d        bra [0x844D]
8430: bd 8d 03     jsr (0x8D03)
8433: bd 9d 18     jsr (0x9D18)
8436: 24 08        bcc [0x8440]
8438: 7d 00 b8     tst (0x00B8)
843b: 27 f3        beq [0x8430]
843d: 7e 9a 60     jmp (0x9A60)
8440: 7d 00 b8     tst (0x00B8)
8443: 27 eb        beq [0x8430]
8445: 7f 00 30     clr (0x0030)
8448: 7f 00 31     clr (0x0031)
844b: 20 00        bra [0x844D]
844d: 96 49        ldaa (0x0049)
844f: 26 03        bne [0x8454]
8451: 7e 85 a4     jmp (0x85A4)
8454: 7f 00 49     clr (0x0049)
8457: 81 31        cmpa 0x31
8459: 26 08        bne [0x8463]
845b: bd a3 26     jsr (0xA326)
845e: bd 8d 42     jsr (0x8D42)
8461: 20 ea        bra [0x844D]
8463: 81 32        cmpa 0x32
8465: 26 08        bne [0x846F]
8467: bd a3 26     jsr (0xA326)
846a: bd 8d 35     jsr (0x8D35)
846d: 20 de        bra [0x844D]
846f: 81 54        cmpa 0x54
8471: 26 08        bne [0x847B]
8473: bd a3 26     jsr (0xA326)
8476: bd 8d 42     jsr (0x8D42)
8479: 20 d2        bra [0x844D]
847b: 81 5a        cmpa 0x5A
847d: 26 1c        bne [0x849B]
847f: bd a3 1e     jsr (0xA31E)
8482: bd 8e 95     jsr (0x8E95)
8485: 7f 00 32     clr (0x0032)
8488: 7f 00 31     clr (0x0031)
848b: 7f 00 30     clr (0x0030)
848e: bd 99 a6     jsr (0x99A6)
8491: d6 7b        ldab (0x007B)
8493: ca 0c        orab 0x0C
8495: bd 87 48     jsr (0x8748)
8498: 7e 81 bd     jmp (0x81BD)
849b: 81 42        cmpa 0x42
849d: 26 03        bne [0x84A2]
849f: 7e 98 3c     jmp (0x983C)
84a2: 81 4d        cmpa 0x4D
84a4: 26 03        bne [0x84A9]
84a6: 7e 98 24     jmp (0x9824)
84a9: 81 45        cmpa 0x45
84ab: 26 03        bne [0x84B0]
84ad: 7e 98 02     jmp (0x9802)
84b0: 81 58        cmpa 0x58
84b2: 26 05        bne [0x84B9]
84b4: 7e 99 3f     jmp (0x993F)
84b7: 20 94        bra [0x844D]
84b9: 81 46        cmpa 0x46
84bb: 26 03        bne [0x84C0]
84bd: 7e 99 71     jmp (0x9971)
84c0: 81 47        cmpa 0x47
84c2: 26 03        bne [0x84C7]
84c4: 7e 99 7b     jmp (0x997B)
84c7: 81 48        cmpa 0x48
84c9: 26 03        bne [0x84CE]
84cb: 7e 99 85     jmp (0x9985)
84ce: 81 49        cmpa 0x49
84d0: 26 03        bne [0x84D5]
84d2: 7e 99 8f     jmp (0x998F)
84d5: 81 53        cmpa 0x53
84d7: 26 03        bne [0x84DC]
84d9: 7e 97 ba     jmp (0x97BA)
84dc: 81 59        cmpa 0x59
84de: 26 03        bne [0x84E3]
84e0: 7e 99 d2     jmp (0x99D2)
84e3: 81 57        cmpa 0x57
84e5: 26 03        bne [0x84EA]
84e7: 7e 9a a4     jmp (0x9AA4)
84ea: 81 41        cmpa 0x41
84ec: 26 17        bne [0x8505]
84ee: bd 9d 18     jsr (0x9D18)
84f1: 25 09        bcs [0x84FC]
84f3: 7f 00 30     clr (0x0030)
84f6: 7f 00 31     clr (0x0031)
84f9: 7e 85 a4     jmp (0x85A4)
84fc: 7f 00 30     clr (0x0030)
84ff: 7f 00 31     clr (0x0031)
8502: 7e 9a 7f     jmp (0x9A7F)
8505: 81 4b        cmpa 0x4B
8507: 26 0b        bne [0x8514]
8509: bd 9d 18     jsr (0x9D18)
850c: 25 03        bcs [0x8511]
850e: 7e 85 a4     jmp (0x85A4)
8511: 7e 9a 7f     jmp (0x9A7F)
8514: 81 4a        cmpa 0x4A
8516: 26 07        bne [0x851F]
8518: 86 01        ldaa 0x01
851a: 97 af        staa (0x00AF)
851c: 7e 98 3c     jmp (0x983C)
851f: 81 4e        cmpa 0x4E
8521: 26 0b        bne [0x852E]
8523: b6 10 8a     ldaa (0x108A)
8526: 8a 02        oraa 0x02
8528: b7 10 8a     staa (0x108A)
852b: 7e 84 4d     jmp (0x844D)
852e: 81 4f        cmpa 0x4F
8530: 26 06        bne [0x8538]
8532: bd 9d 18     jsr (0x9D18)
8535: 7e 84 4d     jmp (0x844D)
8538: 81 50        cmpa 0x50
853a: 26 06        bne [0x8542]
853c: bd 9d 18     jsr (0x9D18)
853f: 7e 84 4d     jmp (0x844D)
8542: 81 51        cmpa 0x51
8544: 26 0b        bne [0x8551]
8546: b6 10 8a     ldaa (0x108A)
8549: 8a 04        oraa 0x04
854b: b7 10 8a     staa (0x108A)
854e: 7e 84 4d     jmp (0x844D)
8551: 81 55        cmpa 0x55
8553: 26 07        bne [0x855C]
8555: c6 01        ldab 0x01
8557: d7 b6        stab (0x00B6)
8559: 7e 84 4d     jmp (0x844D)
855c: 81 4c        cmpa 0x4C
855e: 26 19        bne [0x8579]
8560: 7f 00 49     clr (0x0049)
8563: bd 9d 18     jsr (0x9D18)
8566: 25 0e        bcs [0x8576]
8568: bd aa e8     jsr (0xAAE8)
856b: bd ab 56     jsr (0xAB56)
856e: 24 06        bcc [0x8576]
8570: bd ab 25     jsr (0xAB25)
8573: bd ab 46     jsr (0xAB46)
8576: 7e 84 4d     jmp (0x844D)
8579: 81 52        cmpa 0x52
857b: 26 1a        bne [0x8597]
857d: 7f 00 49     clr (0x0049)
8580: bd 9d 18     jsr (0x9D18)
8583: 25 0f        bcs [0x8594]
8585: bd aa e8     jsr (0xAAE8)
8588: bd ab 56     jsr (0xAB56)
858b: 25 07        bcs [0x8594]
858d: 86 ff        ldaa 0xFF
858f: a7 00        staa (X+0x00)
8591: bd aa e8     jsr (0xAAE8)
8594: 7e 84 4d     jmp (0x844D)
8597: 81 44        cmpa 0x44
8599: 26 09        bne [0x85A4]
859b: 7f 00 49     clr (0x0049)
859e: bd ab ae     jsr (0xABAE)
85a1: 7e 84 4d     jmp (0x844D)
85a4: 7d 00 75     tst (0x0075)
85a7: 26 56        bne [0x85FF]
85a9: 7d 00 79     tst (0x0079)
85ac: 26 51        bne [0x85FF]
85ae: 7d 00 30     tst (0x0030)
85b1: 26 07        bne [0x85BA]
85b3: 96 5b        ldaa (0x005B)
85b5: 27 48        beq [0x85FF]
85b7: 7f 00 5b     clr (0x005B)
85ba: cc 00 64     ldd 0x0064
85bd: dd 23        std (0x0023)
85bf: dc 23        ldd (0x0023)
85c1: 27 14        beq [0x85D7]
85c3: bd 9b 19     jsr (0x9B19)
85c6: b6 18 04     ldaa (0x1804)
85c9: 88 ff        eora 0xFF
85cb: 84 06        anda 0x06
85cd: 81 06        cmpa 0x06
85cf: 26 ee        bne [0x85BF]
85d1: 7f 00 30     clr (0x0030)
85d4: 7e 86 80     jmp (0x8680)
85d7: 7f 00 30     clr (0x0030)
85da: d6 62        ldab (0x0062)
85dc: c8 02        eorb 0x02
85de: d7 62        stab (0x0062)
85e0: bd f9 c5     jsr (0xF9C5)
85e3: c4 02        andb 0x02
85e5: 27 0d        beq [0x85F4]
85e7: bd aa 18     jsr (0xAA18)
85ea: c6 1e        ldab 0x1E
85ec: bd 8c 22     jsr (0x8C22)
85ef: 7f 00 30     clr (0x0030)
85f2: 20 0b        bra [0x85FF]
85f4: bd aa 1d     jsr (0xAA1D)
85f7: c6 1e        ldab 0x1E
85f9: bd 8c 22     jsr (0x8C22)
85fc: 7f 00 30     clr (0x0030)
85ff: bd 9b 19     jsr (0x9B19)
8602: b6 10 0a     ldaa (PORTE)
8605: 84 10        anda 0x10
8607: 27 0b        beq [0x8614]
8609: b6 18 04     ldaa (0x1804)
860c: 88 ff        eora 0xFF
860e: 84 07        anda 0x07
8610: 81 06        cmpa 0x06
8612: 26 1c        bne [0x8630]
8614: 7d 00 76     tst (0x0076)
8617: 26 17        bne [0x8630]
8619: 7d 00 75     tst (0x0075)
861c: 26 12        bne [0x8630]
861e: d6 62        ldab (0x0062)
8620: c4 fc        andb 0xFC
8622: d7 62        stab (0x0062)
8624: bd f9 c5     jsr (0xF9C5)
8627: bd aa 13     jsr (0xAA13)
862a: bd aa 1d     jsr (0xAA1D)
862d: 7e 9a 60     jmp (0x9A60)
8630: 7d 00 31     tst (0x0031)
8633: 26 07        bne [0x863C]
8635: 96 5a        ldaa (0x005A)
8637: 27 47        beq [0x8680]
8639: 7f 00 5a     clr (0x005A)
863c: cc 00 64     ldd 0x0064
863f: dd 23        std (0x0023)
8641: dc 23        ldd (0x0023)
8643: 27 13        beq [0x8658]
8645: bd 9b 19     jsr (0x9B19)
8648: b6 18 04     ldaa (0x1804)
864b: 88 ff        eora 0xFF
864d: 84 06        anda 0x06
864f: 81 06        cmpa 0x06
8651: 26 ee        bne [0x8641]
8653: 7f 00 31     clr (0x0031)
8656: 20 28        bra [0x8680]
8658: 7f 00 31     clr (0x0031)
865b: d6 62        ldab (0x0062)
865d: c8 01        eorb 0x01
865f: d7 62        stab (0x0062)
8661: bd f9 c5     jsr (0xF9C5)
8664: c4 01        andb 0x01
8666: 27 0d        beq [0x8675]
8668: bd aa 0c     jsr (0xAA0C)
866b: c6 1e        ldab 0x1E
866d: bd 8c 22     jsr (0x8C22)
8670: 7f 00 31     clr (0x0031)
8673: 20 0b        bra [0x8680]
8675: bd aa 13     jsr (0xAA13)
8678: c6 1e        ldab 0x1E
867a: bd 8c 22     jsr (0x8C22)
867d: 7f 00 31     clr (0x0031)
8680: bd 86 a4     jsr (0x86A4)
8683: 25 1c        bcs [0x86A1]
8685: 7f 00 4e     clr (0x004E)
8688: bd 99 a6     jsr (0x99A6)
868b: bd 86 c4     jsr (0x86C4)
868e: 5f           clrb
868f: d7 62        stab (0x0062)
8691: bd f9 c5     jsr (0xF9C5)
8694: c6 fd        ldab 0xFD
8696: bd 86 e7     jsr (0x86E7)
8699: c6 04        ldab 0x04
869b: bd 8c 02     jsr (0x8C02)
869e: 7e 84 7f     jmp (0x847F)
86a1: 7e 84 4d     jmp (0x844D)
86a4: bd 9b 19     jsr (0x9B19)
86a7: 7f 00 23     clr (0x0023)
86aa: 86 19        ldaa 0x19
86ac: 97 24        staa (0x0024)
86ae: b6 10 0a     ldaa (PORTE)
86b1: 84 80        anda 0x80
86b3: 27 02        beq [0x86B7]
86b5: 0d           sec
86b6: 39           rts
86b7: b6 10 0a     ldaa (PORTE)
86ba: 84 80        anda 0x80
86bc: 26 f7        bne [0x86B5]
86be: 96 24        ldaa (0x0024)
86c0: 26 f5        bne [0x86B7]
86c2: 0c           clc
86c3: 39           rts
86c4: ce 10 80     ldx 0x1080
86c7: 86 30        ldaa 0x30
86c9: a7 01        staa (X+0x01)
86cb: a7 03        staa (X+0x03)
86cd: 86 ff        ldaa 0xFF
86cf: a7 00        staa (X+0x00)
86d1: a7 02        staa (X+0x02)
86d3: 86 34        ldaa 0x34
86d5: a7 01        staa (X+0x01)
86d7: a7 03        staa (X+0x03)
86d9: 6f 00        clr (X+0x00)
86db: 6f 02        clr (X+0x02)
86dd: 08           inx
86de: 08           inx
86df: 08           inx
86e0: 08           inx
86e1: 8c 10 a4     cpx 0x10A4
86e4: 2f e1        ble [0x86C7]
86e6: 39           rts
86e7: 36           psha
86e8: bd 9b 19     jsr (0x9B19)
86eb: 96 ac        ldaa (0x00AC)
86ed: c1 fb        cmpb 0xFB
86ef: 26 04        bne [0x86F5]
86f1: 84 fe        anda 0xFE
86f3: 20 0e        bra [0x8703]
86f5: c1 f7        cmpb 0xF7
86f7: 26 04        bne [0x86FD]
86f9: 84 bf        anda 0xBF
86fb: 20 06        bra [0x8703]
86fd: c1 fd        cmpb 0xFD
86ff: 26 02        bne [0x8703]
8701: 84 f7        anda 0xF7
8703: 97 ac        staa (0x00AC)
8705: b7 18 06     staa (0x1806)
8708: bd 87 3a     jsr (0x873A)
870b: 96 7a        ldaa (0x007A)
870d: 84 01        anda 0x01
870f: 97 7a        staa (0x007A)
8711: c4 fe        andb 0xFE
8713: da 7a        orab (0x007A)
8715: f7 18 06     stab (0x1806)
8718: bd 87 75     jsr (0x8775)
871b: c6 32        ldab 0x32
871d: bd 8c 22     jsr (0x8C22)
8720: c6 fe        ldab 0xFE
8722: da 7a        orab (0x007A)
8724: f7 18 06     stab (0x1806)
8727: d7 7a        stab (0x007A)
8729: bd 87 75     jsr (0x8775)
872c: 96 ac        ldaa (0x00AC)
872e: 8a 49        oraa 0x49
8730: 97 ac        staa (0x00AC)
8732: b7 18 06     staa (0x1806)
8735: bd 87 3a     jsr (0x873A)
8738: 32           pula
8739: 39           rts
873a: b6 18 04     ldaa (0x1804)
873d: 8a 20        oraa 0x20
873f: b7 18 04     staa (0x1804)
8742: 84 df        anda 0xDF
8744: b7 18 04     staa (0x1804)
8747: 39           rts
8748: 36           psha
8749: 37           pshb
874a: 96 ac        ldaa (0x00AC)
874c: 8a 30        oraa 0x30
874e: 84 fd        anda 0xFD
8750: c5 20        bitb 0x20
8752: 26 02        bne [0x8756]
8754: 8a 02        oraa 0x02
8756: c5 04        bitb 0x04
8758: 26 02        bne [0x875C]
875a: 84 ef        anda 0xEF
875c: c5 08        bitb 0x08
875e: 26 02        bne [0x8762]
8760: 84 df        anda 0xDF
8762: b7 18 06     staa (0x1806)
8765: 97 ac        staa (0x00AC)
8767: bd 87 3a     jsr (0x873A)
876a: 33           pulb
876b: f7 18 06     stab (0x1806)
876e: d7 7b        stab (0x007B)
8770: bd 87 83     jsr (0x8783)
8773: 32           pula
8774: 39           rts
8775: b6 18 07     ldaa (0x1807)
8778: 8a 38        oraa 0x38
877a: b7 18 07     staa (0x1807)
877d: 84 f7        anda 0xF7
877f: b7 18 07     staa (0x1807)
8782: 39           rts
8783: b6 18 05     ldaa (0x1805)
8786: 8a 38        oraa 0x38
8788: b7 18 05     staa (0x1805)
878b: 84 f7        anda 0xF7
878d: b7 18 05     staa (0x1805)
8790: 39           rts
8791: 96 7a        ldaa (0x007A)
8793: 84 fe        anda 0xFE
8795: 36           psha
8796: 96 ac        ldaa (0x00AC)
8798: 8a 04        oraa 0x04
879a: 97 ac        staa (0x00AC)
879c: 32           pula
879d: 97 7a        staa (0x007A)
879f: b7 18 06     staa (0x1806)
87a2: bd 87 75     jsr (0x8775)
87a5: 96 ac        ldaa (0x00AC)
87a7: b7 18 06     staa (0x1806)
87aa: bd 87 3a     jsr (0x873A)
87ad: 39           rts
87ae: 96 7a        ldaa (0x007A)
87b0: 8a 01        oraa 0x01
87b2: 36           psha
87b3: 96 ac        ldaa (0x00AC)
87b5: 84 fb        anda 0xFB
87b7: 97 ac        staa (0x00AC)
87b9: 32           pula
87ba: 20 e1        bra [0x879D]
87bc: ce 87 d2     ldx 0x87D2
87bf: a6 00        ldaa (X+0x00)
87c1: 81 ff        cmpa 0xFF
87c3: 27 0c        beq [0x87D1]
87c5: 08           inx
87c6: b7 18 0d     staa (0x180D)
87c9: a6 00        ldaa (X+0x00)
87cb: 08           inx
87cc: b7 18 0d     staa (0x180D)
87cf: 20 ee        bra [0x87BF]
87d1: 39           rts
87d2: 09           dex
87d3: 8a 01        oraa 0x01
87d5: 00           test
87d6: 0c           clc
87d7: 18 0d        ?
87d9: 00           test
87da: 04           lsrd
87db: 44           lsra
87dc: 0e           cli
87dd: 63 05        com (X+0x05)
87df: 68 0b        asl (X+0x0B)
87e1: 56           rorb
87e2: 03           fdiv
87e3: c1 0f        cmpb 0x0F
87e5: 00           test
87e6: ff ff ce     stx (0xFFCE)
87e9: f8 57 a6     eorb (0x57A6)
87ec: 00           test
87ed: 81 ff        cmpa 0xFF
87ef: 27 0c        beq [0x87FD]
87f1: 08           inx
87f2: b7 18 0c     staa (0x180C)
87f5: a6 00        ldaa (X+0x00)
87f7: 08           inx
87f8: b7 18 0c     staa (0x180C)
87fb: 20 ee        bra [0x87EB]
87fd: 20 16        bra [0x8815]
87ff: 09           dex
8800: 8a 01        oraa 0x01
8802: 10           sba
8803: 0c           clc
8804: 18 0d        ?
8806: 00           test
8807: 04           lsrd
8808: 04           lsrd
8809: 0e           cli
880a: 63 05        com (X+0x05)
880c: 68 0b        asl (X+0x0B)
880e: 01           nop
880f: 03           fdiv
8810: c1 0f        cmpb 0x0F
8812: 00           test
8813: ff ff ce     stx (0xFFCE)
8816: 88 3e        eora 0x3E
8818: ff 01 28     stx (0x0128)
881b: 86 7e        ldaa 0x7E
881d: b7 01 27     staa (0x0127)
8820: ce 88 32     ldx 0x8832
8823: ff 01 01     stx (0x0101)
8826: b7 01 00     staa (0x0100)
8829: b6 10 2d     ldaa (SCCR2)
882c: 8a 20        oraa 0x20
882e: b7 10 2d     staa (SCCR2)
8831: 39           rts
8832: b6 10 2e     ldaa (SCSR)
8835: b6 10 2f     ldaa (SCDR)
8838: 7c 00 48     inc (0x0048)
883b: 7e 88 62     jmp (0x8862)
883e: 86 01        ldaa 0x01
8840: b7 18 0c     staa (0x180C)
8843: b6 18 0c     ldaa (0x180C)
8846: 84 70        anda 0x70
8848: 26 1f        bne [0x8869]
884a: 86 0a        ldaa 0x0A
884c: b7 18 0c     staa (0x180C)
884f: b6 18 0c     ldaa (0x180C)
8852: 84 c0        anda 0xC0
8854: 26 22        bne [0x8878]
8856: b6 18 0c     ldaa (0x180C)
8859: 44           lsra
885a: 24 35        bcc [0x8891]
885c: 7c 00 48     inc (0x0048)
885f: b6 18 0e     ldaa (0x180E)
8862: bd f9 6f     jsr (0xF96F)
8865: 97 4a        staa (0x004A)
8867: 20 2d        bra [0x8896]
8869: b6 18 0e     ldaa (0x180E)
886c: 86 30        ldaa 0x30
886e: b7 18 0c     staa (0x180C)
8871: 86 07        ldaa 0x07
8873: bd f9 6f     jsr (0xF96F)
8876: 0c           clc
8877: 3b           rti
8878: 86 07        ldaa 0x07
887a: bd f9 6f     jsr (0xF96F)
887d: 86 0e        ldaa 0x0E
887f: b7 18 0c     staa (0x180C)
8882: 86 43        ldaa 0x43
8884: b7 18 0c     staa (0x180C)
8887: b6 18 0e     ldaa (0x180E)
888a: 86 07        ldaa 0x07
888c: bd f9 6f     jsr (0xF96F)
888f: 0d           sec
8890: 3b           rti
8891: b6 18 0e     ldaa (0x180E)
8894: 0c           clc
8895: 3b           rti
8896: 84 7f        anda 0x7F
8898: 81 24        cmpa 0x24
889a: 27 44        beq [0x88E0]
889c: 81 25        cmpa 0x25
889e: 27 40        beq [0x88E0]
88a0: 81 20        cmpa 0x20
88a2: 27 3a        beq [0x88DE]
88a4: 81 30        cmpa 0x30
88a6: 25 35        bcs [0x88DD]
88a8: 97 12        staa (0x0012)
88aa: 96 4d        ldaa (0x004D)
88ac: 81 02        cmpa 0x02
88ae: 25 09        bcs [0x88B9]
88b0: 7f 00 4d     clr (0x004D)
88b3: 96 12        ldaa (0x0012)
88b5: 97 49        staa (0x0049)
88b7: 20 24        bra [0x88DD]
88b9: 7d 00 4e     tst (0x004E)
88bc: 27 1f        beq [0x88DD]
88be: 86 78        ldaa 0x78
88c0: 97 63        staa (0x0063)
88c2: 97 64        staa (0x0064)
88c4: 96 12        ldaa (0x0012)
88c6: 81 40        cmpa 0x40
88c8: 24 07        bcc [0x88D1]
88ca: 97 4c        staa (0x004C)
88cc: 7f 00 4d     clr (0x004D)
88cf: 20 0c        bra [0x88DD]
88d1: 81 60        cmpa 0x60
88d3: 24 08        bcc [0x88DD]
88d5: 97 4b        staa (0x004B)
88d7: 7f 00 4d     clr (0x004D)
88da: bd 88 e5     jsr (0x88E5)
88dd: 3b           rti
88de: 20 fd        bra [0x88DD]
88e0: 7c 00 4d     inc (0x004D)
88e3: 20 f9        bra [0x88DE]
88e5: d6 4b        ldab (0x004B)
88e7: 96 4c        ldaa (0x004C)
88e9: 7d 04 5c     tst (0x045C)
88ec: 27 0d        beq [0x88FB]
88ee: 81 3c        cmpa 0x3C
88f0: 25 09        bcs [0x88FB]
88f2: 81 3f        cmpa 0x3F
88f4: 22 05        bhi [0x88FB]
88f6: bd 89 93     jsr (0x8993)
88f9: 20 65        bra [0x8960]
88fb: 1a 83 30 48  cpd 0x3048
88ff: 27 79        beq [0x897A]
8901: 1a 83 31 48  cpd 0x3148
8905: 27 5a        beq [0x8961]
8907: 1a 83 34 4d  cpd 0x344D
890b: 27 6d        beq [0x897A]
890d: 1a 83 35 4d  cpd 0x354D
8911: 27 4e        beq [0x8961]
8913: 1a 83 36 4d  cpd 0x364D
8917: 27 61        beq [0x897A]
8919: 1a 83 37 4d  cpd 0x374D
891d: 27 42        beq [0x8961]
891f: ce 10 80     ldx 0x1080
8922: d6 4c        ldab (0x004C)
8924: c0 30        subb 0x30
8926: 54           lsrb
8927: 58           aslb
8928: 58           aslb
8929: 3a           abx
892a: d6 4b        ldab (0x004B)
892c: c1 50        cmpb 0x50
892e: 24 30        bcc [0x8960]
8930: c1 47        cmpb 0x47
8932: 23 02        bls [0x8936]
8934: 08           inx
8935: 08           inx
8936: c0 40        subb 0x40
8938: c4 07        andb 0x07
893a: 4f           clra
893b: 0d           sec
893c: 49           rola
893d: 5d           tstb
893e: 27 04        beq [0x8944]
8940: 49           rola
8941: 5a           decb
8942: 26 fc        bne [0x8940]
8944: 97 50        staa (0x0050)
8946: 96 4c        ldaa (0x004C)
8948: 84 01        anda 0x01
894a: 27 08        beq [0x8954]
894c: a6 00        ldaa (X+0x00)
894e: 9a 50        oraa (0x0050)
8950: a7 00        staa (X+0x00)
8952: 20 0c        bra [0x8960]
8954: 96 50        ldaa (0x0050)
8956: 88 ff        eora 0xFF
8958: 97 50        staa (0x0050)
895a: a6 00        ldaa (X+0x00)
895c: 94 50        anda (0x0050)
895e: a7 00        staa (X+0x00)
8960: 39           rts
8961: b6 10 82     ldaa (0x1082)
8964: 8a 01        oraa 0x01
8966: b7 10 82     staa (0x1082)
8969: b6 10 8a     ldaa (0x108A)
896c: 8a 20        oraa 0x20
896e: b7 10 8a     staa (0x108A)
8971: b6 10 8e     ldaa (0x108E)
8974: 8a 20        oraa 0x20
8976: b7 10 8e     staa (0x108E)
8979: 39           rts
897a: b6 10 82     ldaa (0x1082)
897d: 84 fe        anda 0xFE
897f: b7 10 82     staa (0x1082)
8982: b6 10 8a     ldaa (0x108A)
8985: 84 df        anda 0xDF
8987: b7 10 8a     staa (0x108A)
898a: b6 10 8e     ldaa (0x108E)
898d: 84 df        anda 0xDF
898f: b7 10 8e     staa (0x108E)
8992: 39           rts
8993: 3c           pshx
8994: 81 3d        cmpa 0x3D
8996: 22 05        bhi [0x899D]
8998: ce f7 80     ldx 0xF780
899b: 20 03        bra [0x89A0]
899d: ce f7 a0     ldx 0xF7A0
89a0: c0 40        subb 0x40
89a2: 58           aslb
89a3: 3a           abx
89a4: 81 3c        cmpa 0x3C
89a6: 27 34        beq [0x89DC]
89a8: 81 3d        cmpa 0x3D
89aa: 27 0a        beq [0x89B6]
89ac: 81 3e        cmpa 0x3E
89ae: 27 4b        beq [0x89FB]
89b0: 81 3f        cmpa 0x3F
89b2: 27 15        beq [0x89C9]
89b4: 38           pulx
89b5: 39           rts
89b6: b6 10 98     ldaa (0x1098)
89b9: aa 00        oraa (X+0x00)
89bb: b7 10 98     staa (0x1098)
89be: 08           inx
89bf: b6 10 9a     ldaa (0x109A)
89c2: aa 00        oraa (X+0x00)
89c4: b7 10 9a     staa (0x109A)
89c7: 38           pulx
89c8: 39           rts
89c9: b6 10 9c     ldaa (0x109C)
89cc: aa 00        oraa (X+0x00)
89ce: b7 10 9c     staa (0x109C)
89d1: 08           inx
89d2: b6 10 9e     ldaa (0x109E)
89d5: aa 00        oraa (X+0x00)
89d7: b7 10 9e     staa (0x109E)
89da: 38           pulx
89db: 39           rts
89dc: e6 00        ldab (X+0x00)
89de: c8 ff        eorb 0xFF
89e0: d7 12        stab (0x0012)
89e2: b6 10 98     ldaa (0x1098)
89e5: 94 12        anda (0x0012)
89e7: b7 10 98     staa (0x1098)
89ea: 08           inx
89eb: e6 00        ldab (X+0x00)
89ed: c8 ff        eorb 0xFF
89ef: d7 12        stab (0x0012)
89f1: b6 10 9a     ldaa (0x109A)
89f4: 94 12        anda (0x0012)
89f6: b7 10 9a     staa (0x109A)
89f9: 38           pulx
89fa: 39           rts
89fb: e6 00        ldab (X+0x00)
89fd: c8 ff        eorb 0xFF
89ff: d7 12        stab (0x0012)
8a01: b6 10 9c     ldaa (0x109C)
8a04: 94 12        anda (0x0012)
8a06: b7 10 9c     staa (0x109C)
8a09: 08           inx
8a0a: e6 00        ldab (X+0x00)
8a0c: c8 ff        eorb 0xFF
8a0e: d7 12        stab (0x0012)
8a10: b6 10 9e     ldaa (0x109E)
8a13: 94 12        anda (0x0012)
8a15: b7 10 9e     staa (0x109E)
8a18: 38           pulx
8a19: 39           rts
8a1a: 3c           pshx
8a1b: 86 04        ldaa 0x04
8a1d: b5 18 0d     bita (0x180D)
8a20: 27 f9        beq [0x8A1B]
8a22: a6 00        ldaa (X+0x00)
8a24: 26 03        bne [0x8A29]
8a26: 7e 8b 21     jmp (0x8B21)
8a29: 08           inx
8a2a: 81 5e        cmpa 0x5E
8a2c: 26 1d        bne [0x8A4B]
8a2e: a6 00        ldaa (X+0x00)
8a30: 08           inx
8a31: b7 05 92     staa (0x0592)
8a34: a6 00        ldaa (X+0x00)
8a36: 08           inx
8a37: b7 05 93     staa (0x0593)
8a3a: a6 00        ldaa (X+0x00)
8a3c: 08           inx
8a3d: b7 05 95     staa (0x0595)
8a40: a6 00        ldaa (X+0x00)
8a42: 08           inx
8a43: b7 05 96     staa (0x0596)
8a46: bd 8b 23     jsr (0x8B23)
8a49: 20 d0        bra [0x8A1B]
8a4b: 81 40        cmpa 0x40
8a4d: 26 3b        bne [0x8A8A]
8a4f: 1a ee 00     ldy (X+0x00)
8a52: 08           inx
8a53: 08           inx
8a54: 86 30        ldaa 0x30
8a56: 97 b1        staa (0x00B1)
8a58: 18 a6 00     ldaa (Y+0x00)
8a5b: 81 64        cmpa 0x64
8a5d: 25 07        bcs [0x8A66]
8a5f: 7c 00 b1     inc (0x00B1)
8a62: 80 64        suba 0x64
8a64: 20 f5        bra [0x8A5B]
8a66: 36           psha
8a67: 96 b1        ldaa (0x00B1)
8a69: bd 8b 3b     jsr (0x8B3B)
8a6c: 86 30        ldaa 0x30
8a6e: 97 b1        staa (0x00B1)
8a70: 32           pula
8a71: 81 0a        cmpa 0x0A
8a73: 25 07        bcs [0x8A7C]
8a75: 7c 00 b1     inc (0x00B1)
8a78: 80 0a        suba 0x0A
8a7a: 20 f5        bra [0x8A71]
8a7c: 36           psha
8a7d: 96 b1        ldaa (0x00B1)
8a7f: bd 8b 3b     jsr (0x8B3B)
8a82: 32           pula
8a83: 8b 30        adda 0x30
8a85: bd 8b 3b     jsr (0x8B3B)
8a88: 20 91        bra [0x8A1B]
8a8a: 81 7c        cmpa 0x7C
8a8c: 26 59        bne [0x8AE7]
8a8e: 1a ee 00     ldy (X+0x00)
8a91: 08           inx
8a92: 08           inx
8a93: 86 30        ldaa 0x30
8a95: 97 b1        staa (0x00B1)
8a97: 18 ec 00     ldd (Y+0x00)
8a9a: 1a 83 27 10  cpd 0x2710
8a9e: 25 08        bcs [0x8AA8]
8aa0: 7c 00 b1     inc (0x00B1)
8aa3: 83 27 10     subd 0x2710
8aa6: 20 f2        bra [0x8A9A]
8aa8: 36           psha
8aa9: 96 b1        ldaa (0x00B1)
8aab: bd 8b 3b     jsr (0x8B3B)
8aae: 86 30        ldaa 0x30
8ab0: 97 b1        staa (0x00B1)
8ab2: 32           pula
8ab3: 1a 83 03 e8  cpd 0x03E8
8ab7: 25 08        bcs [0x8AC1]
8ab9: 7c 00 b1     inc (0x00B1)
8abc: 83 03 e8     subd 0x03E8
8abf: 20 f2        bra [0x8AB3]
8ac1: 36           psha
8ac2: 96 b1        ldaa (0x00B1)
8ac4: bd 8b 3b     jsr (0x8B3B)
8ac7: 86 30        ldaa 0x30
8ac9: 97 b1        staa (0x00B1)
8acb: 32           pula
8acc: 1a 83 00 64  cpd 0x0064
8ad0: 25 08        bcs [0x8ADA]
8ad2: 7c 00 b1     inc (0x00B1)
8ad5: 83 00 64     subd 0x0064
8ad8: 20 f2        bra [0x8ACC]
8ada: 96 b1        ldaa (0x00B1)
8adc: bd 8b 3b     jsr (0x8B3B)
8adf: 86 30        ldaa 0x30
8ae1: 97 b1        staa (0x00B1)
8ae3: 17           tba
8ae4: 7e 8a 71     jmp (0x8A71)
8ae7: 81 7e        cmpa 0x7E
8ae9: 26 18        bne [0x8B03]
8aeb: e6 00        ldab (X+0x00)
8aed: c0 30        subb 0x30
8aef: 08           inx
8af0: 1a ee 00     ldy (X+0x00)
8af3: 08           inx
8af4: 08           inx
8af5: 18 a6 00     ldaa (Y+0x00)
8af8: 18 08        iny
8afa: bd 8b 3b     jsr (0x8B3B)
8afd: 5a           decb
8afe: 26 f5        bne [0x8AF5]
8b00: 7e 8a 1b     jmp (0x8A1B)
8b03: 81 25        cmpa 0x25
8b05: 26 14        bne [0x8B1B]
8b07: ce 05 90     ldx 0x0590
8b0a: cc 1b 5b     ldd 0x1B5B
8b0d: ed 00        std (X+0x00)
8b0f: 86 4b        ldaa 0x4B
8b11: a7 02        staa (X+0x02)
8b13: 6f 03        clr (X+0x03)
8b15: bd 8a 1a     jsr (0x8A1A)
8b18: 7e 8a 1b     jmp (0x8A1B)
8b1b: b7 18 0f     staa (0x180F)
8b1e: 7e 8a 1b     jmp (0x8A1B)
8b21: 38           pulx
8b22: 39           rts
8b23: 3c           pshx
8b24: ce 05 90     ldx 0x0590
8b27: cc 1b 5b     ldd 0x1B5B
8b2a: ed 00        std (X+0x00)
8b2c: 86 48        ldaa 0x48
8b2e: a7 07        staa (X+0x07)
8b30: 86 3b        ldaa 0x3B
8b32: a7 04        staa (X+0x04)
8b34: 6f 08        clr (X+0x08)
8b36: bd 8a 1a     jsr (0x8A1A)
8b39: 38           pulx
8b3a: 39           rts
8b3b: 36           psha
8b3c: 86 04        ldaa 0x04
8b3e: b5 18 0d     bita (0x180D)
8b41: 27 f9        beq [0x8B3C]
8b43: 32           pula
8b44: b7 18 0f     staa (0x180F)
8b47: 39           rts
8b48: bd a3 2e     jsr (0xA32E)
8b4b: bd 8d e4     jsr (0x8DE4)
8b4e: 4c           inca
8b4f: 69 67        rol (X+0x67)
8b51: 68 74        asl (X+0x74)
8b53: 20 44        bra [0x8B99]
8b55: 69 61        rol (X+0x61)
8b57: 67 6e        asr (X+0x6E)
8b59: 6f 73        clr (X+0x73)
8b5b: 74 69 e3     lsr (0x69E3)
8b5e: bd 8d dd     jsr (0x8DDD)
8b61: 43           coma
8b62: 75           ?
8b63: 72           ?
8b64: 74 61 69     lsr (0x6169)
8b67: 6e 73        jmp (X+0x73)
8b69: 20 6f        bra [0x8BDA]
8b6b: 70 65 6e     neg (0x656E)
8b6e: 69 6e        rol (X+0x6E)
8b70: e7 c6        stab (X+0xC6)
8b72: 14 bd 8c     bset (0x00BD), 0x8C
8b75: 30           tsx
8b76: c6 ff        ldab 0xFF
8b78: f7 10 98     stab (0x1098)
8b7b: f7 10 9a     stab (0x109A)
8b7e: f7 10 9c     stab (0x109C)
8b81: f7 10 9e     stab (0x109E)
8b84: bd f9 c5     jsr (0xF9C5)
8b87: b6 18 04     ldaa (0x1804)
8b8a: 8a 40        oraa 0x40
8b8c: b7 18 04     staa (0x1804)
8b8f: bd 8d e4     jsr (0x8DE4)
8b92: 20 50        bra [0x8BE4]
8b94: 72           ?
8b95: 65           ?
8b96: 73 73 20     com (0x7320)
8b99: 45           ?
8b9a: 4e           ?
8b9b: 54           lsrb
8b9c: 45           ?
8b9d: 52           ?
8b9e: 20 74        bra [0x8C14]
8ba0: 6f a0        clr (X+0xA0)
8ba2: bd 8d dd     jsr (0x8DDD)
8ba5: 74 75 72     lsr (0x7572)
8ba8: 6e 20        jmp (X+0x20)
8baa: 6c 69        inc (X+0x69)
8bac: 67 68        asr (X+0x68)
8bae: 74 73 20     lsr (0x7320)
8bb1: 20 6f        bra [0x8C22]
8bb3: 66 e6        ror (X+0xE6)
8bb5: bd 8e 95     jsr (0x8E95)
8bb8: 81 0d        cmpa 0x0D
8bba: 26 f9        bne [0x8BB5]
8bbc: bd a3 41     jsr (0xA341)
8bbf: 39           rts
8bc0: 86 80        ldaa 0x80
8bc2: b7 10 22     staa (TMSK1)
8bc5: ce ab cc     ldx 0xABCC
8bc8: ff 01 19     stx (0x0119)
8bcb: ce ad 0c     ldx 0xAD0C
8bce: ff 01 16     stx (0x0116)
8bd1: ce ad 0c     ldx 0xAD0C
8bd4: ff 01 2e     stx (0x012E)
8bd7: 86 7e        ldaa 0x7E
8bd9: b7 01 18     staa (0x0118)
8bdc: b7 01 15     staa (0x0115)
8bdf: b7 01 2d     staa (0x012D)
8be2: 4f           clra
8be3: 5f           clrb
8be4: dd 1b        std (0x001B)
8be6: dd 1d        std (0x001D)
8be8: dd 1f        std (0x001F)
8bea: dd 21        std (0x0021)
8bec: dd 23        std (0x0023)
8bee: 86 c0        ldaa 0xC0
8bf0: b7 10 23     staa (TFLG1)
8bf3: 39           rts
8bf4: b6 10 0a     ldaa (PORTE)
8bf7: 88 ff        eora 0xFF
8bf9: 16           tab
8bfa: d7 62        stab (0x0062)
8bfc: bd f9 c5     jsr (0xF9C5)
8bff: 20 f3        bra [0x8BF4]
8c01: 39           rts
8c02: 36           psha
8c03: 86 64        ldaa 0x64
8c05: 3d           mul
8c06: dd 23        std (0x0023)
8c08: bd 9b 19     jsr (0x9B19)
8c0b: dc 23        ldd (0x0023)
8c0d: 26 f9        bne [0x8C08]
8c0f: 32           pula
8c10: 39           rts
8c11: 36           psha
8c12: 86 3c        ldaa 0x3C
8c14: 97 28        staa (0x0028)
8c16: c6 01        ldab 0x01
8c18: bd 8c 02     jsr (0x8C02)
8c1b: 96 28        ldaa (0x0028)
8c1d: 4a           deca
8c1e: 26 f4        bne [0x8C14]
8c20: 32           pula
8c21: 39           rts
8c22: 36           psha
8c23: 4f           clra
8c24: dd 23        std (0x0023)
8c26: bd 9b 19     jsr (0x9B19)
8c29: 7d 00 24     tst (0x0024)
8c2c: 26 f8        bne [0x8C26]
8c2e: 32           pula
8c2f: 39           rts
8c30: 36           psha
8c31: 86 32        ldaa 0x32
8c33: 3d           mul
8c34: dd 23        std (0x0023)
8c36: dc 23        ldd (0x0023)
8c38: 26 fc        bne [0x8C36]
8c3a: 32           pula
8c3b: 39           rts
8c3c: 86 ff        ldaa 0xFF
8c3e: b7 10 01     staa (DDRA)
8c41: 86 ff        ldaa 0xFF
8c43: b7 10 03     staa (DDRG)
8c46: b6 10 02     ldaa (PORTG)
8c49: 8a 02        oraa 0x02
8c4b: b7 10 02     staa (PORTG)
8c4e: 86 38        ldaa 0x38
8c50: bd 8c 86     jsr (0x8C86)
8c53: 86 38        ldaa 0x38
8c55: bd 8c 86     jsr (0x8C86)
8c58: 86 06        ldaa 0x06
8c5a: bd 8c 86     jsr (0x8C86)
8c5d: 86 0e        ldaa 0x0E
8c5f: bd 8c 86     jsr (0x8C86)
8c62: 86 01        ldaa 0x01
8c64: bd 8c 86     jsr (0x8C86)
8c67: ce 00 ff     ldx 0x00FF
8c6a: 01           nop
8c6b: 01           nop
8c6c: 09           dex
8c6d: 26 fb        bne [0x8C6A]
8c6f: 39           rts
8c70: b6 10 02     ldaa (PORTG)
8c73: 84 fd        anda 0xFD
8c75: b7 10 02     staa (PORTG)
8c78: 8a 02        oraa 0x02
8c7a: b7 10 02     staa (PORTG)
8c7d: 39           rts
8c7e: cc 05 00     ldd 0x0500
8c81: dd 46        std (0x0046)
8c83: dd 44        std (0x0044)
8c85: 39           rts
8c86: bd 8c bd     jsr (0x8CBD)
8c89: b7 10 00     staa (PORTA)
8c8c: b6 10 02     ldaa (PORTG)
8c8f: 84 f3        anda 0xF3
8c91: b7 10 02     staa (PORTG)
8c94: bd 8c 70     jsr (0x8C70)
8c97: 39           rts
8c98: bd 8c bd     jsr (0x8CBD)
8c9b: b7 10 00     staa (PORTA)
8c9e: b6 10 02     ldaa (PORTG)
8ca1: 84 fb        anda 0xFB
8ca3: 8a 08        oraa 0x08
8ca5: 20 ea        bra [0x8C91]
8ca7: bd 8c bd     jsr (0x8CBD)
8caa: b6 10 02     ldaa (PORTG)
8cad: 84 f7        anda 0xF7
8caf: 8a 08        oraa 0x08
8cb1: 20 de        bra [0x8C91]
8cb3: bd 8c bd     jsr (0x8CBD)
8cb6: b6 10 02     ldaa (PORTG)
8cb9: 8a 0c        oraa 0x0C
8cbb: 20 d4        bra [0x8C91]
8cbd: 36           psha
8cbe: 37           pshb
8cbf: c6 ff        ldab 0xFF
8cc1: 5d           tstb
8cc2: 27 1a        beq [0x8CDE]
8cc4: b6 10 02     ldaa (PORTG)
8cc7: 84 f7        anda 0xF7
8cc9: 8a 04        oraa 0x04
8ccb: b7 10 02     staa (PORTG)
8cce: bd 8c 70     jsr (0x8C70)
8cd1: 7f 10 01     clr (DDRA)
8cd4: b6 10 00     ldaa (PORTA)
8cd7: 2b 08        bmi [0x8CE1]
8cd9: 86 ff        ldaa 0xFF
8cdb: b7 10 01     staa (DDRA)
8cde: 33           pulb
8cdf: 32           pula
8ce0: 39           rts
8ce1: 5a           decb
8ce2: 86 ff        ldaa 0xFF
8ce4: b7 10 01     staa (DDRA)
8ce7: 20 d8        bra [0x8CC1]
8ce9: bd 8c bd     jsr (0x8CBD)
8cec: 86 01        ldaa 0x01
8cee: bd 8c 86     jsr (0x8C86)
8cf1: 39           rts
8cf2: bd 8c bd     jsr (0x8CBD)
8cf5: 86 80        ldaa 0x80
8cf7: bd 8d 14     jsr (0x8D14)
8cfa: bd 8c bd     jsr (0x8CBD)
8cfd: 86 80        ldaa 0x80
8cff: bd 8c 86     jsr (0x8C86)
8d02: 39           rts
8d03: bd 8c bd     jsr (0x8CBD)
8d06: 86 c0        ldaa 0xC0
8d08: bd 8d 14     jsr (0x8D14)
8d0b: bd 8c bd     jsr (0x8CBD)
8d0e: 86 c0        ldaa 0xC0
8d10: bd 8c 86     jsr (0x8C86)
8d13: 39           rts
8d14: bd 8c 86     jsr (0x8C86)
8d17: 86 10        ldaa 0x10
8d19: 97 14        staa (0x0014)
8d1b: bd 8c bd     jsr (0x8CBD)
8d1e: 86 20        ldaa 0x20
8d20: bd 8c 98     jsr (0x8C98)
8d23: 7a 00 14     dec (0x0014)
8d26: 26 f3        bne [0x8D1B]
8d28: 39           rts
8d29: 86 0c        ldaa 0x0C
8d2b: bd 8e 4b     jsr (0x8E4B)
8d2e: 39           rts
8d2f: 86 0e        ldaa 0x0E
8d31: bd 8e 4b     jsr (0x8E4B)
8d34: 39           rts
8d35: 7f 00 4a     clr (0x004A)
8d38: 7f 00 43     clr (0x0043)
8d3b: 18 de 46     ldy (0x0046)
8d3e: 86 c0        ldaa 0xC0
8d40: 20 0b        bra [0x8D4D]
8d42: 7f 00 4a     clr (0x004A)
8d45: 7f 00 43     clr (0x0043)
8d48: 18 de 46     ldy (0x0046)
8d4b: 86 80        ldaa 0x80
8d4d: 18 a7 00     staa (Y+0x00)
8d50: 18 6f 01     clr (Y+0x01)
8d53: 18 08        iny
8d55: 18 08        iny
8d57: 18 8c 05 80  cpy 0x0580
8d5b: 25 04        bcs [0x8D61]
8d5d: 18 ce 05 00  ldy 0x0500
8d61: c6 0f        ldab 0x0F
8d63: 96 4a        ldaa (0x004A)
8d65: 27 fc        beq [0x8D63]
8d67: 7f 00 4a     clr (0x004A)
8d6a: 5a           decb
8d6b: 27 1a        beq [0x8D87]
8d6d: 81 24        cmpa 0x24
8d6f: 27 16        beq [0x8D87]
8d71: 18 6f 00     clr (Y+0x00)
8d74: 18 a7 01     staa (Y+0x01)
8d77: 18 08        iny
8d79: 18 08        iny
8d7b: 18 8c 05 80  cpy 0x0580
8d7f: 25 04        bcs [0x8D85]
8d81: 18 ce 05 00  ldy 0x0500
8d85: 20 dc        bra [0x8D63]
8d87: 5d           tstb
8d88: 27 19        beq [0x8DA3]
8d8a: 86 20        ldaa 0x20
8d8c: 18 6f 00     clr (Y+0x00)
8d8f: 18 a7 01     staa (Y+0x01)
8d92: 18 08        iny
8d94: 18 08        iny
8d96: 18 8c 05 80  cpy 0x0580
8d9a: 25 04        bcs [0x8DA0]
8d9c: 18 ce 05 00  ldy 0x0500
8da0: 5a           decb
8da1: 26 e9        bne [0x8D8C]
8da3: 18 6f 00     clr (Y+0x00)
8da6: 18 6f 01     clr (Y+0x01)
8da9: 18 df 46     sty (0x0046)
8dac: 96 19        ldaa (0x0019)
8dae: 97 4e        staa (0x004E)
8db0: 86 01        ldaa 0x01
8db2: 97 43        staa (0x0043)
8db4: 39           rts
8db5: 36           psha
8db6: 37           pshb
8db7: c1 4f        cmpb 0x4F
8db9: 22 13        bhi [0x8DCE]
8dbb: c1 28        cmpb 0x28
8dbd: 25 03        bcs [0x8DC2]
8dbf: 0c           clc
8dc0: c9 18        adcb 0x18
8dc2: 0c           clc
8dc3: c9 80        adcb 0x80
8dc5: 17           tba
8dc6: bd 8e 4b     jsr (0x8E4B)
8dc9: 33           pulb
8dca: 32           pula
8dcb: bd 8e 70     jsr (0x8E70)
8dce: 39           rts
8dcf: 18 de 46     ldy (0x0046)
8dd2: 86 90        ldaa 0x90
8dd4: 20 13        bra [0x8DE9]
8dd6: 18 de 46     ldy (0x0046)
8dd9: 86 d0        ldaa 0xD0
8ddb: 20 0c        bra [0x8DE9]
8ddd: 18 de 46     ldy (0x0046)
8de0: 86 c0        ldaa 0xC0
8de2: 20 05        bra [0x8DE9]
8de4: 18 de 46     ldy (0x0046)
8de7: 86 80        ldaa 0x80
8de9: 18 a7 00     staa (Y+0x00)
8dec: 18 6f 01     clr (Y+0x01)
8def: 18 08        iny
8df1: 18 08        iny
8df3: 18 8c 05 80  cpy 0x0580
8df7: 25 04        bcs [0x8DFD]
8df9: 18 ce 05 00  ldy 0x0500
8dfd: 38           pulx
8dfe: df 17        stx (0x0017)
8e00: a6 00        ldaa (X+0x00)
8e02: 27 36        beq [0x8E3A]
8e04: 2b 17        bmi [0x8E1D]
8e06: 18 6f 00     clr (Y+0x00)
8e09: 18 a7 01     staa (Y+0x01)
8e0c: 08           inx
8e0d: 18 08        iny
8e0f: 18 08        iny
8e11: 18 8c 05 80  cpy 0x0580
8e15: 25 e9        bcs [0x8E00]
8e17: 18 ce 05 00  ldy 0x0500
8e1b: 20 e3        bra [0x8E00]
8e1d: 84 7f        anda 0x7F
8e1f: 18 6f 00     clr (Y+0x00)
8e22: 18 a7 01     staa (Y+0x01)
8e25: 18 6f 02     clr (Y+0x02)
8e28: 18 6f 03     clr (Y+0x03)
8e2b: 08           inx
8e2c: 18 08        iny
8e2e: 18 08        iny
8e30: 18 8c 05 80  cpy 0x0580
8e34: 25 04        bcs [0x8E3A]
8e36: 18 ce 05 00  ldy 0x0500
8e3a: 3c           pshx
8e3b: 86 01        ldaa 0x01
8e3d: 97 43        staa (0x0043)
8e3f: dc 46        ldd (0x0046)
8e41: 18 6f 00     clr (Y+0x00)
8e44: 18 6f 01     clr (Y+0x01)
8e47: 18 df 46     sty (0x0046)
8e4a: 39           rts
8e4b: 18 de 46     ldy (0x0046)
8e4e: 18 a7 00     staa (Y+0x00)
8e51: 18 6f 01     clr (Y+0x01)
8e54: 18 08        iny
8e56: 18 08        iny
8e58: 18 8c 05 80  cpy 0x0580
8e5c: 25 04        bcs [0x8E62]
8e5e: 18 ce 05 00  ldy 0x0500
8e62: 18 6f 00     clr (Y+0x00)
8e65: 18 6f 01     clr (Y+0x01)
8e68: 86 01        ldaa 0x01
8e6a: 97 43        staa (0x0043)
8e6c: 18 df 46     sty (0x0046)
8e6f: 39           rts
8e70: 18 de 46     ldy (0x0046)
8e73: 18 6f 00     clr (Y+0x00)
8e76: 18 a7 01     staa (Y+0x01)
8e79: 18 08        iny
8e7b: 18 08        iny
8e7d: 18 8c 05 80  cpy 0x0580
8e81: 25 04        bcs [0x8E87]
8e83: 18 ce 05 00  ldy 0x0500
8e87: 18 6f 00     clr (Y+0x00)
8e8a: 18 6f 01     clr (Y+0x01)
8e8d: 86 01        ldaa 0x01
8e8f: 97 43        staa (0x0043)
8e91: 18 df 46     sty (0x0046)
8e94: 39           rts
8e95: 96 30        ldaa (0x0030)
8e97: 26 09        bne [0x8EA2]
8e99: 96 31        ldaa (0x0031)
8e9b: 26 11        bne [0x8EAE]
8e9d: 96 32        ldaa (0x0032)
8e9f: 26 19        bne [0x8EBA]
8ea1: 39           rts
8ea2: 7f 00 30     clr (0x0030)
8ea5: 7f 00 32     clr (0x0032)
8ea8: 7f 00 31     clr (0x0031)
8eab: 86 01        ldaa 0x01
8ead: 39           rts
8eae: 7f 00 31     clr (0x0031)
8eb1: 7f 00 30     clr (0x0030)
8eb4: 7f 00 32     clr (0x0032)
8eb7: 86 02        ldaa 0x02
8eb9: 39           rts
8eba: 7f 00 32     clr (0x0032)
8ebd: 7f 00 30     clr (0x0030)
8ec0: 7f 00 31     clr (0x0031)
8ec3: 86 0d        ldaa 0x0D
8ec5: 39           rts
8ec6: b6 18 04     ldaa (0x1804)
8ec9: 84 07        anda 0x07
8ecb: 97 2c        staa (0x002C)
8ecd: 78 00 2c     asl (0x002C)
8ed0: 78 00 2c     asl (0x002C)
8ed3: 78 00 2c     asl (0x002C)
8ed6: 78 00 2c     asl (0x002C)
8ed9: 78 00 2c     asl (0x002C)
8edc: ce 00 00     ldx 0x0000
8edf: 8c 00 03     cpx 0x0003
8ee2: 27 24        beq [0x8F08]
8ee4: 78 00 2c     asl (0x002C)
8ee7: 25 12        bcs [0x8EFB]
8ee9: a6 2d        ldaa (X+0x2D)
8eeb: 81 0f        cmpa 0x0F
8eed: 24 1a        bcc [0x8F09]
8eef: 6c 2d        inc (X+0x2D)
8ef1: a6 2d        ldaa (X+0x2D)
8ef3: 81 02        cmpa 0x02
8ef5: 26 02        bne [0x8EF9]
8ef7: a7 30        staa (X+0x30)
8ef9: 20 0a        bra [0x8F05]
8efb: 6f 2d        clr (X+0x2D)
8efd: 20 06        bra [0x8F05]
8eff: a6 2d        ldaa (X+0x2D)
8f01: 27 02        beq [0x8F05]
8f03: 6a 2d        dec (X+0x2D)
8f05: 08           inx
8f06: 20 d7        bra [0x8EDF]
8f08: 39           rts
8f09: 8c 00 02     cpx 0x0002
8f0c: 27 02        beq [0x8F10]
8f0e: 6f 2d        clr (X+0x2D)
8f10: 20 f3        bra [0x8F05]
8f12: b6 10 0a     ldaa (PORTE)
8f15: 97 51        staa (0x0051)
8f17: ce 00 00     ldx 0x0000
8f1a: 8c 00 08     cpx 0x0008
8f1d: 27 22        beq [0x8F41]
8f1f: 77 00 51     asr (0x0051)
8f22: 25 10        bcs [0x8F34]
8f24: a6 52        ldaa (X+0x52)
8f26: 81 0f        cmpa 0x0F
8f28: 6c 52        inc (X+0x52)
8f2a: a6 52        ldaa (X+0x52)
8f2c: 81 04        cmpa 0x04
8f2e: 26 02        bne [0x8F32]
8f30: a7 5a        staa (X+0x5A)
8f32: 20 0a        bra [0x8F3E]
8f34: 6f 52        clr (X+0x52)
8f36: 20 06        bra [0x8F3E]
8f38: a6 52        ldaa (X+0x52)
8f3a: 27 02        beq [0x8F3E]
8f3c: 6a 52        dec (X+0x52)
8f3e: 08           inx
8f3f: 20 d9        bra [0x8F1A]
8f41: 39           rts
8f42: 6f 52        clr (X+0x52)
8f44: 20 f8        bra [0x8F3E]
8f46: 30           tsx
8f47: 2e 35        bgt [0x8F7E]
8f49: 31           ins
8f4a: 2e 30        bgt [0x8F7C]
8f4c: 31           ins
8f4d: 2e 35        bgt [0x8F84]
8f4f: 32           pula
8f50: 2e 30        bgt [0x8F82]
8f52: 32           pula
8f53: 2e 35        bgt [0x8F8A]
8f55: 33           pulb
8f56: 2e 30        bgt [0x8F88]
8f58: 3c           pshx
8f59: 96 12        ldaa (0x0012)
8f5b: 80 01        suba 0x01
8f5d: c6 03        ldab 0x03
8f5f: 3d           mul
8f60: ce 8f 46     ldx 0x8F46
8f63: 3a           abx
8f64: c6 2c        ldab 0x2C
8f66: a6 00        ldaa (X+0x00)
8f68: 08           inx
8f69: bd 8d b5     jsr (0x8DB5)
8f6c: 5c           incb
8f6d: c1 2f        cmpb 0x2F
8f6f: 26 f5        bne [0x8F66]
8f71: 38           pulx
8f72: 39           rts
8f73: 36           psha
8f74: bd 8c f2     jsr (0x8CF2)
8f77: c6 02        ldab 0x02
8f79: bd 8c 30     jsr (0x8C30)
8f7c: 32           pula
8f7d: 97 b4        staa (0x00B4)
8f7f: 81 03        cmpa 0x03
8f81: 26 11        bne [0x8F94]
8f83: bd 8d e4     jsr (0x8DE4)
8f86: 43           coma
8f87: 68 75        asl (X+0x75)
8f89: 63 6b        com (X+0x6B)
8f8b: 20 20        bra [0x8FAD]
8f8d: 20 a0        bra [0x8F2F]
8f8f: ce 90 72     ldx 0x9072
8f92: 20 4d        bra [0x8FE1]
8f94: 81 04        cmpa 0x04
8f96: 26 11        bne [0x8FA9]
8f98: bd 8d e4     jsr (0x8DE4)
8f9b: 4a           deca
8f9c: 61           ?
8f9d: 73 70 65     com (0x7065)
8fa0: 72           ?
8fa1: 20 20        bra [0x8FC3]
8fa3: a0 ce        suba (X+0xCE)
8fa5: 90 de        suba (0x00DE)
8fa7: 20 38        bra [0x8FE1]
8fa9: 81 05        cmpa 0x05
8fab: 26 11        bne [0x8FBE]
8fad: bd 8d e4     jsr (0x8DE4)
8fb0: 50           negb
8fb1: 61           ?
8fb2: 73 71 75     com (0x7175)
8fb5: 61           ?
8fb6: 6c 6c        inc (X+0x6C)
8fb8: f9 ce 91     adcb (0xCE91)
8fbb: 45           ?
8fbc: 20 23        bra [0x8FE1]
8fbe: 81 06        cmpa 0x06
8fc0: 26 11        bne [0x8FD3]
8fc2: bd 8d e4     jsr (0x8DE4)
8fc5: 4d           tsta
8fc6: 75           ?
8fc7: 6e 63        jmp (X+0x63)
8fc9: 68 20        asl (X+0x20)
8fcb: 20 20        bra [0x8FED]
8fcd: a0 ce        suba (X+0xCE)
8fcf: 91 ba        cmpa (0x00BA)
8fd1: 20 0e        bra [0x8FE1]
8fd3: bd 8d e4     jsr (0x8DE4)
8fd6: 48           asla
8fd7: 65           ?
8fd8: 6c 65        inc (X+0x65)
8fda: 6e 20        jmp (X+0x20)
8fdc: 20 a0        bra [0x8F7E]
8fde: ce 92 26     ldx 0x9226
8fe1: 96 b4        ldaa (0x00B4)
8fe3: 80 03        suba 0x03
8fe5: 48           asla
8fe6: 48           asla
8fe7: 97 4b        staa (0x004B)
8fe9: bd 95 04     jsr (0x9504)
8fec: 97 4c        staa (0x004C)
8fee: 81 0f        cmpa 0x0F
8ff0: 26 01        bne [0x8FF3]
8ff2: 39           rts
8ff3: 81 08        cmpa 0x08
8ff5: 23 08        bls [0x8FFF]
8ff7: 80 08        suba 0x08
8ff9: d6 4b        ldab (0x004B)
8ffb: cb 02        addb 0x02
8ffd: d7 4b        stab (0x004B)
8fff: 36           psha
9000: 18 de 46     ldy (0x0046)
9003: 32           pula
9004: 5f           clrb
9005: 0d           sec
9006: 59           rolb
9007: 4a           deca
9008: 26 fc        bne [0x9006]
900a: d7 50        stab (0x0050)
900c: d6 4b        ldab (0x004B)
900e: ce 10 80     ldx 0x1080
9011: 3a           abx
9012: 86 02        ldaa 0x02
9014: 97 12        staa (0x0012)
9016: a6 00        ldaa (X+0x00)
9018: 98 50        eora (0x0050)
901a: a7 00        staa (X+0x00)
901c: 6d 00        tst (X+0x00)
901e: 27 16        beq [0x9036]
9020: 86 4f        ldaa 0x4F
9022: c6 0c        ldab 0x0C
9024: bd 8d b5     jsr (0x8DB5)
9027: 86 6e        ldaa 0x6E
9029: c6 0d        ldab 0x0D
902b: bd 8d b5     jsr (0x8DB5)
902e: cc 20 0e     ldd 0x200E
9031: bd 8d b5     jsr (0x8DB5)
9034: 20 0e        bra [0x9044]
9036: 86 66        ldaa 0x66
9038: c6 0d        ldab 0x0D
903a: bd 8d b5     jsr (0x8DB5)
903d: 86 66        ldaa 0x66
903f: c6 0e        ldab 0x0E
9041: bd 8d b5     jsr (0x8DB5)
9044: d6 12        ldab (0x0012)
9046: bd 8c 30     jsr (0x8C30)
9049: bd 8e 95     jsr (0x8E95)
904c: 81 0d        cmpa 0x0D
904e: 27 14        beq [0x9064]
9050: 20 c4        bra [0x9016]
9052: 81 02        cmpa 0x02
9054: 26 c0        bne [0x9016]
9056: 96 12        ldaa (0x0012)
9058: 81 06        cmpa 0x06
905a: 27 ba        beq [0x9016]
905c: 4c           inca
905d: 97 12        staa (0x0012)
905f: bd 8f 58     jsr (0x8F58)
9062: 20 b2        bra [0x9016]
9064: a6 00        ldaa (X+0x00)
9066: 9a 50        oraa (0x0050)
9068: 98 50        eora (0x0050)
906a: a7 00        staa (X+0x00)
906c: 96 b4        ldaa (0x00B4)
906e: 7e 8f 73     jmp (0x8F73)
9071: 39           rts
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
9292: bd 86 c4     jsr (0x86C4)
9295: c6 01        ldab 0x01
9297: bd 8c 30     jsr (0x8C30)
929a: bd 8d e4     jsr (0x8DE4)
929d: 20 20        bra [0x92BF]
929f: 44           lsra
92a0: 69 61        rol (X+0x61)
92a2: 67 6e        asr (X+0x6E)
92a4: 6f 73        clr (X+0x73)
92a6: 74 69 63     lsr (0x6963)
92a9: 73 20 20     com (0x2020)
92ac: a0 bd        suba (X+0xBD)
92ae: 8d dd        bsr [0x928D]
92b0: 20 20        bra [0x92D2]
92b2: 20 20        bra [0x92D4]
92b4: 20 20        bra [0x92D6]
92b6: 20 20        bra [0x92D8]
92b8: 20 20        bra [0x92DA]
92ba: 20 20        bra [0x92DC]
92bc: 20 20        bra [0x92DE]
92be: 20 a0        bra [0x9260]
92c0: c6 01        ldab 0x01
92c2: bd 8c 30     jsr (0x8C30)
92c5: bd 8d 03     jsr (0x8D03)
92c8: ce 93 d3     ldx 0x93D3
92cb: bd 95 04     jsr (0x9504)
92ce: 81 11        cmpa 0x11
92d0: 26 14        bne [0x92E6]
92d2: bd 86 c4     jsr (0x86C4)
92d5: 5f           clrb
92d6: d7 62        stab (0x0062)
92d8: bd f9 c5     jsr (0xF9C5)
92db: b6 18 04     ldaa (0x1804)
92de: 84 bf        anda 0xBF
92e0: b7 18 04     staa (0x1804)
92e3: 7e 81 d7     jmp (0x81D7)
92e6: 81 03        cmpa 0x03
92e8: 25 09        bcs [0x92F3]
92ea: 81 08        cmpa 0x08
92ec: 24 05        bcc [0x92F3]
92ee: bd 8f 73     jsr (0x8F73)
92f1: 20 a2        bra [0x9295]
92f3: 81 02        cmpa 0x02
92f5: 26 08        bne [0x92FF]
92f7: bd 9f 1e     jsr (0x9F1E)
92fa: 25 99        bcs [0x9295]
92fc: 7e 96 75     jmp (0x9675)
92ff: 81 0b        cmpa 0x0B
9301: 26 0d        bne [0x9310]
9303: bd 8d 03     jsr (0x8D03)
9306: bd 9e cc     jsr (0x9ECC)
9309: c6 03        ldab 0x03
930b: bd 8c 30     jsr (0x8C30)
930e: 20 85        bra [0x9295]
9310: 81 09        cmpa 0x09
9312: 26 0e        bne [0x9322]
9314: bd 9f 1e     jsr (0x9F1E)
9317: 24 03        bcc [0x931C]
9319: 7e 92 95     jmp (0x9295)
931c: bd 9e 92     jsr (0x9E92)
931f: 7e 92 95     jmp (0x9295)
9322: 81 0a        cmpa 0x0A
9324: 26 0b        bne [0x9331]
9326: bd 9f 1e     jsr (0x9F1E)
9329: 25 03        bcs [0x932E]
932b: bd 9e af     jsr (0x9EAF)
932e: 7e 92 95     jmp (0x9295)
9331: 81 01        cmpa 0x01
9333: 26 03        bne [0x9338]
9335: 7e a0 e9     jmp (0xA0E9)
9338: 81 08        cmpa 0x08
933a: 26 1f        bne [0x935B]
933c: bd 9f 1e     jsr (0x9F1E)
933f: 25 1a        bcs [0x935B]
9341: bd 8d e4     jsr (0x8DE4)
9344: 52           ?
9345: 65           ?
9346: 73 65 74     com (0x6574)
9349: 20 53        bra [0x939E]
934b: 79 73 74     rol (0x7374)
934e: 65           ?
934f: 6d a1        tst (X+0xA1)
9351: 7e a2 49     jmp (0xA249)
9354: c6 02        ldab 0x02
9356: bd 8c 30     jsr (0x8C30)
9359: 20 18        bra [0x9373]
935b: 81 0c        cmpa 0x0C
935d: 26 14        bne [0x9373]
935f: bd 8b 48     jsr (0x8B48)
9362: 5f           clrb
9363: d7 62        stab (0x0062)
9365: bd f9 c5     jsr (0xF9C5)
9368: b6 18 04     ldaa (0x1804)
936b: 84 bf        anda 0xBF
936d: b7 18 04     staa (0x1804)
9370: 7e 92 92     jmp (0x9292)
9373: 81 0d        cmpa 0x0D
9375: 26 2e        bne [0x93A5]
9377: bd 8c e9     jsr (0x8CE9)
937a: bd 8d e4     jsr (0x8DE4)
937d: 20 20        bra [0x939F]
937f: 42           ?
9380: 75           ?
9381: 74 74 6f     lsr (0x746F)
9384: 6e 20        jmp (X+0x20)
9386: 20 74        bra [0x93FC]
9388: 65           ?
9389: 73 f4 bd     com (0xF4BD)
938c: 8d dd        bsr [0x936B]
938e: 20 20        bra [0x93B0]
9390: 20 50        bra [0x93E2]
9392: 52           ?
9393: 4f           clra
9394: 47           asra
9395: 20 65        bra [0x93FC]
9397: 78 69 74     asl (0x6974)
939a: f3 bd a5     addd (0xBDA5)
939d: 26 5f        bne [0x93FE]
939f: bd f9 c5     jsr (0xF9C5)
93a2: 7e 92 95     jmp (0x9295)
93a5: 81 0e        cmpa 0x0E
93a7: 26 10        bne [0x93B9]
93a9: bd 9f 1e     jsr (0x9F1E)
93ac: 24 03        bcc [0x93B1]
93ae: 7e 92 95     jmp (0x9295)
93b1: c6 01        ldab 0x01
93b3: bd 8c 30     jsr (0x8C30)
93b6: 7e 94 9a     jmp (0x949A)
93b9: 81 0f        cmpa 0x0F
93bb: 26 06        bne [0x93C3]
93bd: bd a8 6a     jsr (0xA86A)
93c0: 7e 92 95     jmp (0x9295)
93c3: 81 10        cmpa 0x10
93c5: 26 09        bne [0x93D0]
93c7: bd 9f 1e     jsr (0x9F1E)
93ca: bd 95 ba     jsr (0x95BA)
93cd: 7e 92 95     jmp (0x9295)
93d0: 7e 92 d2     jmp (0x92D2)
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
9498: f3 00 7d     addd (0x007D)
949b: 04           lsrd
949c: 2a 27        bpl [0x94C5]
949e: 27 bd        beq [0x945D]
94a0: 8d e4        bsr [0x9486]
94a2: 4b           ?
94a3: 69 6e        rol (X+0x6E)
94a5: 67 20        asr (X+0x20)
94a7: 69 73        rol (X+0x73)
94a9: 20 45        bra [0x94F0]
94ab: 6e 61        jmp (X+0x61)
94ad: 62           ?
94ae: 6c 65        inc (X+0x65)
94b0: e4 bd        andb (X+0xBD)
94b2: 8d dd        bsr [0x9491]
94b4: 45           ?
94b5: 4e           ?
94b6: 54           lsrb
94b7: 45           ?
94b8: 52           ?
94b9: 20 74        bra [0x952F]
94bb: 6f 20        clr (X+0x20)
94bd: 64 69        lsr (X+0x69)
94bf: 73 61 62     com (0x6162)
94c2: 6c e5        inc (X+0xE5)
94c4: 20 25        bra [0x94EB]
94c6: bd 8d e4     jsr (0x8DE4)
94c9: 4b           ?
94ca: 69 6e        rol (X+0x6E)
94cc: 67 20        asr (X+0x20)
94ce: 69 73        rol (X+0x73)
94d0: 20 44        bra [0x9516]
94d2: 69 73        rol (X+0x73)
94d4: 61           ?
94d5: 62           ?
94d6: 6c 65        inc (X+0x65)
94d8: e4 bd        andb (X+0xBD)
94da: 8d dd        bsr [0x94B9]
94dc: 45           ?
94dd: 4e           ?
94de: 54           lsrb
94df: 45           ?
94e0: 52           ?
94e1: 20 74        bra [0x9557]
94e3: 6f 20        clr (X+0x20)
94e5: 65           ?
94e6: 6e 61        jmp (X+0x61)
94e8: 62           ?
94e9: 6c e5        inc (X+0xE5)
94eb: bd 8e 95     jsr (0x8E95)
94ee: 4d           tsta
94ef: 27 fa        beq [0x94EB]
94f1: 81 0d        cmpa 0x0D
94f3: 27 02        beq [0x94F7]
94f5: 20 0a        bra [0x9501]
94f7: b6 04 2a     ldaa (0x042A)
94fa: 84 01        anda 0x01
94fc: 88 01        eora 0x01
94fe: b7 04 2a     staa (0x042A)
9501: 7e 92 95     jmp (0x9295)
9504: 86 01        ldaa 0x01
9506: 97 a6        staa (0x00A6)
9508: 97 a7        staa (0x00A7)
950a: df 12        stx (0x0012)
950c: 20 09        bra [0x9517]
950e: 86 01        ldaa 0x01
9510: 97 a7        staa (0x00A7)
9512: 7f 00 a6     clr (0x00A6)
9515: df 12        stx (0x0012)
9517: 7f 00 16     clr (0x0016)
951a: 18 de 46     ldy (0x0046)
951d: 7d 00 a6     tst (0x00A6)
9520: 26 07        bne [0x9529]
9522: bd 8c f2     jsr (0x8CF2)
9525: 86 80        ldaa 0x80
9527: 20 05        bra [0x952E]
9529: bd 8d 03     jsr (0x8D03)
952c: 86 c0        ldaa 0xC0
952e: 18 a7 00     staa (Y+0x00)
9531: 18 6f 01     clr (Y+0x01)
9534: 18 08        iny
9536: 18 08        iny
9538: 18 8c 05 80  cpy 0x0580
953c: 25 04        bcs [0x9542]
953e: 18 ce 05 00  ldy 0x0500
9542: df 14        stx (0x0014)
9544: a6 00        ldaa (X+0x00)
9546: 2a 04        bpl [0x954C]
9548: c6 01        ldab 0x01
954a: d7 16        stab (0x0016)
954c: 81 2c        cmpa 0x2C
954e: 27 1e        beq [0x956E]
9550: 18 6f 00     clr (Y+0x00)
9553: 84 7f        anda 0x7F
9555: 18 a7 01     staa (Y+0x01)
9558: 18 08        iny
955a: 18 08        iny
955c: 18 8c 05 80  cpy 0x0580
9560: 25 04        bcs [0x9566]
9562: 18 ce 05 00  ldy 0x0500
9566: 7d 00 16     tst (0x0016)
9569: 26 03        bne [0x956E]
956b: 08           inx
956c: 20 d6        bra [0x9544]
956e: 08           inx
956f: 86 01        ldaa 0x01
9571: 97 43        staa (0x0043)
9573: 18 6f 00     clr (Y+0x00)
9576: 18 6f 01     clr (Y+0x01)
9579: 18 df 46     sty (0x0046)
957c: bd 8e 95     jsr (0x8E95)
957f: 27 fb        beq [0x957C]
9581: 81 02        cmpa 0x02
9583: 26 0a        bne [0x958F]
9585: 7d 00 16     tst (0x0016)
9588: 26 05        bne [0x958F]
958a: 7c 00 a7     inc (0x00A7)
958d: 20 88        bra [0x9517]
958f: 81 01        cmpa 0x01
9591: 26 20        bne [0x95B3]
9593: 18 de 14     ldy (0x0014)
9596: 18 9c 12     cpy (0x0012)
9599: 23 e1        bls [0x957C]
959b: 7a 00 a7     dec (0x00A7)
959e: de 14        ldx (0x0014)
95a0: 09           dex
95a1: 09           dex
95a2: 9c 12        cpx (0x0012)
95a4: 26 03        bne [0x95A9]
95a6: 7e 95 17     jmp (0x9517)
95a9: a6 00        ldaa (X+0x00)
95ab: 81 2c        cmpa 0x2C
95ad: 26 f2        bne [0x95A1]
95af: 08           inx
95b0: 7e 95 17     jmp (0x9517)
95b3: 81 0d        cmpa 0x0D
95b5: 26 c5        bne [0x957C]
95b7: 96 a7        ldaa (0x00A7)
95b9: 39           rts
95ba: b6 04 5c     ldaa (0x045C)
95bd: 27 14        beq [0x95D3]
95bf: bd 8d e4     jsr (0x8DE4)
95c2: 43           coma
95c3: 75           ?
95c4: 72           ?
95c5: 72           ?
95c6: 65           ?
95c7: 6e 74        jmp (X+0x74)
95c9: 3a           abx
95ca: 20 43        bra [0x960F]
95cc: 4e           ?
95cd: 52           ?
95ce: 20 20        bra [0x95F0]
95d0: a0 20        suba (X+0x20)
95d2: 12 bd 8d e4  brset (0x00BD), 0x8D, [0x95BA]
95d6: 43           coma
95d7: 75           ?
95d8: 72           ?
95d9: 72           ?
95da: 65           ?
95db: 6e 74        jmp (X+0x74)
95dd: 3a           abx
95de: 20 52        bra [0x9632]
95e0: 31           ins
95e1: 32           pula
95e2: 20 20        bra [0x9604]
95e4: a0 bd        suba (X+0xBD)
95e6: 8d dd        bsr [0x95C5]
95e8: 3c           pshx
95e9: 45           ?
95ea: 6e 74        jmp (X+0x74)
95ec: 65           ?
95ed: 72           ?
95ee: 3e           wai
95ef: 20 74        bra [0x9665]
95f1: 6f 20        clr (X+0x20)
95f3: 63 68        com (X+0x68)
95f5: 67 ae        asr (X+0xAE)
95f7: bd 8e 95     jsr (0x8E95)
95fa: 27 fb        beq [0x95F7]
95fc: 81 0d        cmpa 0x0D
95fe: 26 0f        bne [0x960F]
9600: b6 04 5c     ldaa (0x045C)
9603: 27 05        beq [0x960A]
9605: 7f 04 5c     clr (0x045C)
9608: 20 05        bra [0x960F]
960a: 86 01        ldaa 0x01
960c: b7 04 5c     staa (0x045C)
960f: 39           rts
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
9675: bd 8d e4     jsr (0x8DE4)
9678: 52           ?
9679: 61           ?
967a: 6e 64        jmp (X+0x64)
967c: 6f 6d        clr (X+0x6D)
967e: 20 20        bra [0x96A0]
9680: 20 20        bra [0x96A2]
9682: 20 20        bra [0x96A4]
9684: 20 20        bra [0x96A6]
9686: 20 a0        bra [0x9628]
9688: ce 96 10     ldx 0x9610
968b: bd 95 04     jsr (0x9504)
968e: 5f           clrb
968f: 37           pshb
9690: 81 0d        cmpa 0x0D
9692: 26 03        bne [0x9697]
9694: 7e 97 5b     jmp (0x975B)
9697: 81 0c        cmpa 0x0C
9699: 26 21        bne [0x96BC]
969b: 7f 04 01     clr (0x0401)
969e: 7f 04 2b     clr (0x042B)
96a1: bd 8d e4     jsr (0x8DE4)
96a4: 41           ?
96a5: 6c 6c        inc (X+0x6C)
96a7: 20 52        bra [0x96FB]
96a9: 6e 64        jmp (X+0x64)
96ab: 20 43        bra [0x96F0]
96ad: 6c 65        inc (X+0x65)
96af: 61           ?
96b0: 72           ?
96b1: 65           ?
96b2: 64 a1        lsr (X+0xA1)
96b4: c6 64        ldab 0x64
96b6: bd 8c 22     jsr (0x8C22)
96b9: 7e 97 5b     jmp (0x975B)
96bc: 81 09        cmpa 0x09
96be: 25 05        bcs [0x96C5]
96c0: 80 08        suba 0x08
96c2: 33           pulb
96c3: 5c           incb
96c4: 37           pshb
96c5: 5f           clrb
96c6: 0d           sec
96c7: 59           rolb
96c8: 4a           deca
96c9: 26 fc        bne [0x96C7]
96cb: d7 12        stab (0x0012)
96cd: c8 ff        eorb 0xFF
96cf: d7 13        stab (0x0013)
96d1: cc 20 34     ldd 0x2034
96d4: bd 8d b5     jsr (0x8DB5)
96d7: 33           pulb
96d8: 37           pshb
96d9: 5d           tstb
96da: 27 05        beq [0x96E1]
96dc: b6 04 2b     ldaa (0x042B)
96df: 20 03        bra [0x96E4]
96e1: b6 04 01     ldaa (0x0401)
96e4: 94 12        anda (0x0012)
96e6: 27 0a        beq [0x96F2]
96e8: 18 de 46     ldy (0x0046)
96eb: bd 8d fd     jsr (0x8DFD)
96ee: 4f           clra
96ef: ee 20        ldx (X+0x20)
96f1: 09           dex
96f2: 18 de 46     ldy (0x0046)
96f5: bd 8d fd     jsr (0x8DFD)
96f8: 4f           clra
96f9: 66 e6        ror (X+0xE6)
96fb: cc 20 34     ldd 0x2034
96fe: bd 8d b5     jsr (0x8DB5)
9701: bd 8e 95     jsr (0x8E95)
9704: 27 fb        beq [0x9701]
9706: 81 01        cmpa 0x01
9708: 26 22        bne [0x972C]
970a: 33           pulb
970b: 37           pshb
970c: 5d           tstb
970d: 27 0a        beq [0x9719]
970f: b6 04 2b     ldaa (0x042B)
9712: 9a 12        oraa (0x0012)
9714: b7 04 2b     staa (0x042B)
9717: 20 08        bra [0x9721]
9719: b6 04 01     ldaa (0x0401)
971c: 9a 12        oraa (0x0012)
971e: b7 04 01     staa (0x0401)
9721: 18 de 46     ldy (0x0046)
9724: bd 8d fd     jsr (0x8DFD)
9727: 4f           clra
9728: 6e a0        jmp (X+0xA0)
972a: 20 a5        bra [0x96D1]
972c: 81 02        cmpa 0x02
972e: 26 23        bne [0x9753]
9730: 33           pulb
9731: 37           pshb
9732: 5d           tstb
9733: 27 0a        beq [0x973F]
9735: b6 04 2b     ldaa (0x042B)
9738: 94 13        anda (0x0013)
973a: b7 04 2b     staa (0x042B)
973d: 20 08        bra [0x9747]
973f: b6 04 01     ldaa (0x0401)
9742: 94 13        anda (0x0013)
9744: b7 04 01     staa (0x0401)
9747: 18 de 46     ldy (0x0046)
974a: bd 8d fd     jsr (0x8DFD)
974d: 4f           clra
974e: 66 e6        ror (X+0xE6)
9750: 7e 96 d1     jmp (0x96D1)
9753: 81 0d        cmpa 0x0D
9755: 26 aa        bne [0x9701]
9757: 33           pulb
9758: 7e 96 75     jmp (0x9675)
975b: 33           pulb
975c: 7e 92 92     jmp (0x9292)
975f: ce 00 00     ldx 0x0000
9762: 18 ce 80 00  ldy 0x8000
9766: 18 e6 00     ldab (Y+0x00)
9769: 18 08        iny
976b: 3a           abx
976c: 18 8c 00 00  cpy 0x0000
9770: 26 f4        bne [0x9766]
9772: df 17        stx (0x0017)
9774: 96 17        ldaa (0x0017)
9776: bd 97 9b     jsr (0x979B)
9779: 96 12        ldaa (0x0012)
977b: c6 33        ldab 0x33
977d: bd 8d b5     jsr (0x8DB5)
9780: 96 13        ldaa (0x0013)
9782: c6 34        ldab 0x34
9784: bd 8d b5     jsr (0x8DB5)
9787: 96 18        ldaa (0x0018)
9789: bd 97 9b     jsr (0x979B)
978c: 96 12        ldaa (0x0012)
978e: c6 35        ldab 0x35
9790: bd 8d b5     jsr (0x8DB5)
9793: 96 13        ldaa (0x0013)
9795: c6 36        ldab 0x36
9797: bd 8d b5     jsr (0x8DB5)
979a: 39           rts
979b: 36           psha
979c: 84 0f        anda 0x0F
979e: 8b 30        adda 0x30
97a0: 81 39        cmpa 0x39
97a2: 23 02        bls [0x97A6]
97a4: 8b 07        adda 0x07
97a6: 97 13        staa (0x0013)
97a8: 32           pula
97a9: 84 f0        anda 0xF0
97ab: 44           lsra
97ac: 44           lsra
97ad: 44           lsra
97ae: 44           lsra
97af: 8b 30        adda 0x30
97b1: 81 39        cmpa 0x39
97b3: 23 02        bls [0x97B7]
97b5: 8b 07        adda 0x07
97b7: 97 12        staa (0x0012)
97b9: 39           rts
97ba: bd 9d 18     jsr (0x9D18)
97bd: 24 03        bcc [0x97C2]
97bf: 7e 9a 7f     jmp (0x9A7F)
97c2: 7d 00 79     tst (0x0079)
97c5: 26 0b        bne [0x97D2]
97c7: fc 04 10     ldd (0x0410)
97ca: c3 00 01     addd 0x0001
97cd: fd 04 10     std (0x0410)
97d0: 20 09        bra [0x97DB]
97d2: fc 04 12     ldd (0x0412)
97d5: c3 00 01     addd 0x0001
97d8: fd 04 12     std (0x0412)
97db: 86 78        ldaa 0x78
97dd: 97 63        staa (0x0063)
97df: 97 64        staa (0x0064)
97e1: bd a3 13     jsr (0xA313)
97e4: bd aa db     jsr (0xAADB)
97e7: 86 01        ldaa 0x01
97e9: 97 4e        staa (0x004E)
97eb: 97 76        staa (0x0076)
97ed: 7f 00 75     clr (0x0075)
97f0: 7f 00 77     clr (0x0077)
97f3: bd 87 ae     jsr (0x87AE)
97f6: d6 7b        ldab (0x007B)
97f8: ca 20        orab 0x20
97fa: c4 f7        andb 0xF7
97fc: bd 87 48     jsr (0x8748)
97ff: 7e 85 a4     jmp (0x85A4)
9802: 7f 00 76     clr (0x0076)
9805: 7f 00 75     clr (0x0075)
9808: 7f 00 77     clr (0x0077)
980b: 7f 00 4e     clr (0x004E)
980e: d6 7b        ldab (0x007B)
9810: ca 0c        orab 0x0C
9812: bd 87 48     jsr (0x8748)
9815: bd a3 1e     jsr (0xA31E)
9818: bd 86 c4     jsr (0x86C4)
981b: bd 9c 51     jsr (0x9C51)
981e: bd 8e 95     jsr (0x8E95)
9821: 7e 84 4d     jmp (0x844D)
9824: bd 9c 51     jsr (0x9C51)
9827: 7f 00 4e     clr (0x004E)
982a: d6 7b        ldab (0x007B)
982c: ca 24        orab 0x24
982e: c4 f7        andb 0xF7
9830: bd 87 48     jsr (0x8748)
9833: bd 87 ae     jsr (0x87AE)
9836: bd 8e 95     jsr (0x8E95)
9839: 7e 84 4d     jmp (0x844D)
983c: 7f 00 78     clr (0x0078)
983f: b6 10 8a     ldaa (0x108A)
9842: 84 f9        anda 0xF9
9844: b7 10 8a     staa (0x108A)
9847: 7d 00 af     tst (0x00AF)
984a: 26 61        bne [0x98AD]
984c: 96 62        ldaa (0x0062)
984e: 84 01        anda 0x01
9850: 27 5b        beq [0x98AD]
9852: c6 fd        ldab 0xFD
9854: bd 86 e7     jsr (0x86E7)
9857: cc 00 32     ldd 0x0032
985a: dd 1b        std (0x001B)
985c: cc 75 30     ldd 0x7530
985f: dd 1d        std (0x001D)
9861: 7f 00 5a     clr (0x005A)
9864: bd 9b 19     jsr (0x9B19)
9867: 7d 00 31     tst (0x0031)
986a: 26 04        bne [0x9870]
986c: 96 5a        ldaa (0x005A)
986e: 27 19        beq [0x9889]
9870: 7f 00 31     clr (0x0031)
9873: d6 62        ldab (0x0062)
9875: c4 fe        andb 0xFE
9877: d7 62        stab (0x0062)
9879: bd f9 c5     jsr (0xF9C5)
987c: bd aa 13     jsr (0xAA13)
987f: c6 fb        ldab 0xFB
9881: bd 86 e7     jsr (0x86E7)
9884: 7f 00 5a     clr (0x005A)
9887: 20 4b        bra [0x98D4]
9889: dc 1b        ldd (0x001B)
988b: 26 d7        bne [0x9864]
988d: d6 62        ldab (0x0062)
988f: c8 01        eorb 0x01
9891: d7 62        stab (0x0062)
9893: bd f9 c5     jsr (0xF9C5)
9896: c4 01        andb 0x01
9898: 26 05        bne [0x989F]
989a: bd aa 0c     jsr (0xAA0C)
989d: 20 03        bra [0x98A2]
989f: bd aa 13     jsr (0xAA13)
98a2: cc 00 32     ldd 0x0032
98a5: dd 1b        std (0x001B)
98a7: dc 1d        ldd (0x001D)
98a9: 27 c5        beq [0x9870]
98ab: 20 b7        bra [0x9864]
98ad: 7d 00 75     tst (0x0075)
98b0: 27 03        beq [0x98B5]
98b2: 7e 99 39     jmp (0x9939)
98b5: 96 62        ldaa (0x0062)
98b7: 84 02        anda 0x02
98b9: 27 4e        beq [0x9909]
98bb: 7d 00 af     tst (0x00AF)
98be: 26 0b        bne [0x98CB]
98c0: fc 04 24     ldd (0x0424)
98c3: c3 00 01     addd 0x0001
98c6: fd 04 24     std (0x0424)
98c9: 20 09        bra [0x98D4]
98cb: fc 04 22     ldd (0x0422)
98ce: c3 00 01     addd 0x0001
98d1: fd 04 22     std (0x0422)
98d4: fc 04 18     ldd (0x0418)
98d7: c3 00 01     addd 0x0001
98da: fd 04 18     std (0x0418)
98dd: 86 78        ldaa 0x78
98df: 97 63        staa (0x0063)
98e1: 97 64        staa (0x0064)
98e3: d6 62        ldab (0x0062)
98e5: c4 f7        andb 0xF7
98e7: ca 02        orab 0x02
98e9: d7 62        stab (0x0062)
98eb: bd f9 c5     jsr (0xF9C5)
98ee: bd aa 18     jsr (0xAA18)
98f1: 86 01        ldaa 0x01
98f3: 97 4e        staa (0x004E)
98f5: 97 75        staa (0x0075)
98f7: d6 7b        ldab (0x007B)
98f9: c4 df        andb 0xDF
98fb: bd 87 48     jsr (0x8748)
98fe: bd 87 ae     jsr (0x87AE)
9901: bd a3 13     jsr (0xA313)
9904: bd aa db     jsr (0xAADB)
9907: 20 30        bra [0x9939]
9909: d6 62        ldab (0x0062)
990b: c4 f5        andb 0xF5
990d: ca 40        orab 0x40
990f: d7 62        stab (0x0062)
9911: bd f9 c5     jsr (0xF9C5)
9914: bd aa 1d     jsr (0xAA1D)
9917: 7d 00 af     tst (0x00AF)
991a: 26 04        bne [0x9920]
991c: c6 01        ldab 0x01
991e: d7 b6        stab (0x00B6)
9920: bd 9c 51     jsr (0x9C51)
9923: 7f 00 4e     clr (0x004E)
9926: 7f 00 75     clr (0x0075)
9929: 86 01        ldaa 0x01
992b: 97 77        staa (0x0077)
992d: d6 7b        ldab (0x007B)
992f: ca 24        orab 0x24
9931: c4 f7        andb 0xF7
9933: bd 87 48     jsr (0x8748)
9936: bd 87 91     jsr (0x8791)
9939: 7f 00 af     clr (0x00AF)
993c: 7e 85 a4     jmp (0x85A4)
993f: 7f 00 77     clr (0x0077)
9942: bd 9c 51     jsr (0x9C51)
9945: 7f 00 4e     clr (0x004E)
9948: d6 62        ldab (0x0062)
994a: c4 bf        andb 0xBF
994c: 7d 00 75     tst (0x0075)
994f: 27 02        beq [0x9953]
9951: c4 fd        andb 0xFD
9953: d7 62        stab (0x0062)
9955: bd f9 c5     jsr (0xF9C5)
9958: bd aa 1d     jsr (0xAA1D)
995b: 7f 00 5b     clr (0x005B)
995e: bd 87 ae     jsr (0x87AE)
9961: d6 7b        ldab (0x007B)
9963: ca 20        orab 0x20
9965: bd 87 48     jsr (0x8748)
9968: 7f 00 75     clr (0x0075)
996b: 7f 00 76     clr (0x0076)
996e: 7e 98 15     jmp (0x9815)
9971: d6 7b        ldab (0x007B)
9973: c4 fb        andb 0xFB
9975: bd 87 48     jsr (0x8748)
9978: 7e 85 a4     jmp (0x85A4)
997b: d6 7b        ldab (0x007B)
997d: ca 04        orab 0x04
997f: bd 87 48     jsr (0x8748)
9982: 7e 85 a4     jmp (0x85A4)
9985: d6 7b        ldab (0x007B)
9987: c4 f7        andb 0xF7
9989: bd 87 48     jsr (0x8748)
998c: 7e 85 a4     jmp (0x85A4)
998f: 7d 00 77     tst (0x0077)
9992: 26 07        bne [0x999B]
9994: d6 7b        ldab (0x007B)
9996: ca 08        orab 0x08
9998: bd 87 48     jsr (0x8748)
999b: 7e 85 a4     jmp (0x85A4)
999e: d6 7b        ldab (0x007B)
99a0: c4 f3        andb 0xF3
99a2: bd 87 48     jsr (0x8748)
99a5: 39           rts
99a6: d6 7b        ldab (0x007B)
99a8: c4 df        andb 0xDF
99aa: bd 87 48     jsr (0x8748)
99ad: bd 87 91     jsr (0x8791)
99b0: 39           rts
99b1: d6 7b        ldab (0x007B)
99b3: ca 20        orab 0x20
99b5: bd 87 48     jsr (0x8748)
99b8: bd 87 ae     jsr (0x87AE)
99bb: 39           rts
99bc: d6 7b        ldab (0x007B)
99be: c4 df        andb 0xDF
99c0: bd 87 48     jsr (0x8748)
99c3: bd 87 ae     jsr (0x87AE)
99c6: 39           rts
99c7: d6 7b        ldab (0x007B)
99c9: ca 20        orab 0x20
99cb: bd 87 48     jsr (0x8748)
99ce: bd 87 91     jsr (0x8791)
99d1: 39           rts
99d2: 86 01        ldaa 0x01
99d4: 97 78        staa (0x0078)
99d6: 7e 85 a4     jmp (0x85A4)
99d9: ce 0e 20     ldx 0x0E20
99dc: a6 00        ldaa (X+0x00)
99de: 80 30        suba 0x30
99e0: c6 0a        ldab 0x0A
99e2: 3d           mul
99e3: 17           tba
99e4: c6 64        ldab 0x64
99e6: 3d           mul
99e7: dd 17        std (0x0017)
99e9: a6 01        ldaa (X+0x01)
99eb: 80 30        suba 0x30
99ed: c6 64        ldab 0x64
99ef: 3d           mul
99f0: d3 17        addd (0x0017)
99f2: dd 17        std (0x0017)
99f4: a6 02        ldaa (X+0x02)
99f6: 80 30        suba 0x30
99f8: c6 0a        ldab 0x0A
99fa: 3d           mul
99fb: d3 17        addd (0x0017)
99fd: dd 17        std (0x0017)
99ff: 4f           clra
9a00: e6 03        ldab (X+0x03)
9a02: c0 30        subb 0x30
9a04: d3 17        addd (0x0017)
9a06: fd 02 9c     std (0x029C)
9a09: ce 0e 20     ldx 0x0E20
9a0c: a6 00        ldaa (X+0x00)
9a0e: 81 30        cmpa 0x30
9a10: 25 13        bcs [0x9A25]
9a12: 81 39        cmpa 0x39
9a14: 22 0f        bhi [0x9A25]
9a16: 08           inx
9a17: 8c 0e 24     cpx 0x0E24
9a1a: 26 f0        bne [0x9A0C]
9a1c: b6 0e 24     ldaa (0x0E24)
9a1f: 81 db        cmpa 0xDB
9a21: 26 02        bne [0x9A25]
9a23: 0c           clc
9a24: 39           rts
9a25: 0d           sec
9a26: 39           rts
9a27: bd 8d e4     jsr (0x8DE4)
9a2a: 53           comb
9a2b: 65           ?
9a2c: 72           ?
9a2d: 69 61        rol (X+0x61)
9a2f: 6c 23        inc (X+0x23)
9a31: a0 bd        suba (X+0xBD)
9a33: 8d dd        bsr [0x9A12]
9a35: 20 20        bra [0x9A57]
9a37: 20 20        bra [0x9A59]
9a39: 20 20        bra [0x9A5B]
9a3b: 20 20        bra [0x9A5D]
9a3d: 20 20        bra [0x9A5F]
9a3f: 20 20        bra [0x9A61]
9a41: 20 20        bra [0x9A63]
9a43: a0 c6        suba (X+0xC6)
9a45: 08           inx
9a46: 18 ce 0e 20  ldy 0x0E20
9a4a: 18 a6 00     ldaa (Y+0x00)
9a4d: 18 3c        pshy
9a4f: 37           pshb
9a50: bd 8d b5     jsr (0x8DB5)
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
9a90: bd 86 c4     jsr (0x86C4)
9a93: bd 9c 51     jsr (0x9C51)
9a96: c6 06        ldab 0x06
9a98: bd 8c 02     jsr (0x8C02)
9a9b: bd 8e 95     jsr (0x8E95)
9a9e: bd 99 a6     jsr (0x99A6)
9aa1: 7e 81 bd     jmp (0x81BD)
9aa4: 7f 00 5c     clr (0x005C)
9aa7: 86 01        ldaa 0x01
9aa9: 97 79        staa (0x0079)
9aab: c6 fd        ldab 0xFD
9aad: bd 86 e7     jsr (0x86E7)
9ab0: bd 8e 95     jsr (0x8E95)
9ab3: cc 75 30     ldd 0x7530
9ab6: dd 1d        std (0x001D)
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
9add: dc 1d        ldd (0x001D)
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
9b19: 36           psha
9b1a: 37           pshb
9b1b: 96 4e        ldaa (0x004E)
9b1d: 27 17        beq [0x9B36]
9b1f: 96 63        ldaa (0x0063)
9b21: 26 10        bne [0x9B33]
9b23: 7d 00 64     tst (0x0064)
9b26: 27 09        beq [0x9B31]
9b28: bd 86 c4     jsr (0x86C4)
9b2b: bd 9c 51     jsr (0x9C51)
9b2e: 7f 00 64     clr (0x0064)
9b31: 20 03        bra [0x9B36]
9b33: 33           pulb
9b34: 32           pula
9b35: 39           rts
9b36: b6 04 01     ldaa (0x0401)
9b39: 84 01        anda 0x01
9b3b: 27 03        beq [0x9B40]
9b3d: bd 9b 6b     jsr (0x9B6B)
9b40: b6 04 01     ldaa (0x0401)
9b43: 84 02        anda 0x02
9b45: 27 03        beq [0x9B4A]
9b47: bd 9b 99     jsr (0x9B99)
9b4a: b6 04 01     ldaa (0x0401)
9b4d: 84 04        anda 0x04
9b4f: 27 03        beq [0x9B54]
9b51: bd 9b c7     jsr (0x9BC7)
9b54: b6 04 01     ldaa (0x0401)
9b57: 84 08        anda 0x08
9b59: 27 03        beq [0x9B5E]
9b5b: bd 9b f5     jsr (0x9BF5)
9b5e: b6 04 01     ldaa (0x0401)
9b61: 84 10        anda 0x10
9b63: 27 03        beq [0x9B68]
9b65: bd 9c 23     jsr (0x9C23)
9b68: 33           pulb
9b69: 32           pula
9b6a: 39           rts
9b6b: 18 3c        pshy
9b6d: 18 de 65     ldy (0x0065)
9b70: 18 a6 00     ldaa (Y+0x00)
9b73: 81 ff        cmpa 0xFF
9b75: 27 14        beq [0x9B8B]
9b77: 91 70        cmpa (0x0070)
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
9b94: 97 70        staa (0x0070)
9b96: 7e 9b 88     jmp (0x9B88)
9b99: 18 3c        pshy
9b9b: 18 de 67     ldy (0x0067)
9b9e: 18 a6 00     ldaa (Y+0x00)
9ba1: 81 ff        cmpa 0xFF
9ba3: 27 14        beq [0x9BB9]
9ba5: 91 71        cmpa (0x0071)
9ba7: 25 0d        bcs [0x9BB6]
9ba9: 18 08        iny
9bab: 18 a6 00     ldaa (Y+0x00)
9bae: b7 10 84     staa (0x1084)
9bb1: 18 08        iny
9bb3: 18 df 67     sty (0x0067)
9bb6: 18 38        puly
9bb8: 39           rts
9bb9: 18 ce b3 bd  ldy 0xB3BD
9bbd: 18 df 67     sty (0x0067)
9bc0: 86 e6        ldaa 0xE6
9bc2: 97 71        staa (0x0071)
9bc4: 7e 9b b6     jmp (0x9BB6)
9bc7: 18 3c        pshy
9bc9: 18 de 69     ldy (0x0069)
9bcc: 18 a6 00     ldaa (Y+0x00)
9bcf: 81 ff        cmpa 0xFF
9bd1: 27 14        beq [0x9BE7]
9bd3: 91 72        cmpa (0x0072)
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
9bf0: 97 72        staa (0x0072)
9bf2: 7e 9b e4     jmp (0x9BE4)
9bf5: 18 3c        pshy
9bf7: 18 de 6b     ldy (0x006B)
9bfa: 18 a6 00     ldaa (Y+0x00)
9bfd: 81 ff        cmpa 0xFF
9bff: 27 14        beq [0x9C15]
9c01: 91 73        cmpa (0x0073)
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
9c1e: 97 73        staa (0x0073)
9c20: 7e 9c 12     jmp (0x9C12)
9c23: 18 3c        pshy
9c25: 18 de 6d     ldy (0x006D)
9c28: 18 a6 00     ldaa (Y+0x00)
9c2b: 81 ff        cmpa 0xFF
9c2d: 27 14        beq [0x9C43]
9c2f: 91 74        cmpa (0x0074)
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
9c4c: 97 74        staa (0x0074)
9c4e: 7e 9c 40     jmp (0x9C40)
9c51: 86 fa        ldaa 0xFA
9c53: 97 70        staa (0x0070)
9c55: 86 e6        ldaa 0xE6
9c57: 97 71        staa (0x0071)
9c59: 86 d2        ldaa 0xD2
9c5b: 97 72        staa (0x0072)
9c5d: 86 be        ldaa 0xBE
9c5f: 97 73        staa (0x0073)
9c61: 86 aa        ldaa 0xAA
9c63: 97 74        staa (0x0074)
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
9cf4: 20 20        bra [0x9D16]
9cf6: 20 50        bra [0x9D48]
9cf8: 72           ?
9cf9: 6f 67        clr (X+0x67)
9cfb: 72           ?
9cfc: 61           ?
9cfd: 6d 20        tst (X+0x20)
9cff: 62           ?
9d00: 79 20 20     rol (0x2020)
9d03: a0 bd        suba (X+0xBD)
9d05: 8d dd        bsr [0x9CE4]
9d07: 44           lsra
9d08: 61           ?
9d09: 76 69 64     ror (0x6964)
9d0c: 20 20        bra [0x9D2E]
9d0e: 50           negb
9d0f: 68 69        asl (X+0x69)
9d11: 6c 69        inc (X+0x69)
9d13: 70 73 65     neg (0x7365)
9d16: ee 39        ldx (X+0x39)
9d18: 97 49        staa (0x0049)
9d1a: 7f 00 b8     clr (0x00B8)
9d1d: bd 8d 03     jsr (0x8D03)
9d20: 86 2a        ldaa 0x2A
9d22: c6 28        ldab 0x28
9d24: bd 8d b5     jsr (0x8DB5)
9d27: cc 0b b8     ldd 0x0BB8
9d2a: dd 1b        std (0x001B)
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
9d71: dc 1b        ldd (0x001B)
9d73: 26 b7        bne [0x9D2C]
9d75: 86 23        ldaa 0x23
9d77: c6 29        ldab 0x29
9d79: bd 8d b5     jsr (0x8DB5)
9d7c: 20 6c        bra [0x9DEA]
9d7e: 7f 00 49     clr (0x0049)
9d81: 86 2a        ldaa 0x2A
9d83: c6 29        ldab 0x29
9d85: bd 8d b5     jsr (0x8DB5)
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
9da7: 86 23        ldaa 0x23
9da9: c6 2a        ldab 0x2A
9dab: bd 8d b5     jsr (0x8DB5)
9dae: 20 3a        bra [0x9DEA]
9db0: 86 2a        ldaa 0x2A
9db2: c6 2a        ldab 0x2A
9db4: bd 8d b5     jsr (0x8DB5)
9db7: b6 02 99     ldaa (0x0299)
9dba: 81 39        cmpa 0x39
9dbc: 26 15        bne [0x9DD3]
9dbe: bd 8d dd     jsr (0x8DDD)
9dc1: 47           asra
9dc2: 65           ?
9dc3: 6e 65        jmp (X+0x65)
9dc5: 72           ?
9dc6: 69 63        rol (X+0x63)
9dc8: 20 53        bra [0x9E1D]
9dca: 68 6f        asl (X+0x6F)
9dcc: 77 74 61     asr (0x7461)
9dcf: 70 e5 0c     neg (0xE50C)
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
9e92: 86 30        ldaa 0x30
9e94: b7 04 02     staa (0x0402)
9e97: b7 04 03     staa (0x0403)
9e9a: b7 04 04     staa (0x0404)
9e9d: bd 8d dd     jsr (0x8DDD)
9ea0: 52           ?
9ea1: 65           ?
9ea2: 67 20        asr (X+0x20)
9ea4: 23 20        bls [0x9EC6]
9ea6: 63 6c        com (X+0x6C)
9ea8: 65           ?
9ea9: 61           ?
9eaa: 72           ?
9eab: 65           ?
9eac: 64 a1        lsr (X+0xA1)
9eae: 39           rts
9eaf: 86 30        ldaa 0x30
9eb1: b7 04 05     staa (0x0405)
9eb4: b7 04 06     staa (0x0406)
9eb7: b7 04 07     staa (0x0407)
9eba: bd 8d dd     jsr (0x8DDD)
9ebd: 4c           inca
9ebe: 69 76        rol (X+0x76)
9ec0: 20 23        bra [0x9EE5]
9ec2: 20 63        bra [0x9F27]
9ec4: 6c 65        inc (X+0x65)
9ec6: 61           ?
9ec7: 72           ?
9ec8: 65           ?
9ec9: 64 a1        lsr (X+0xA1)
9ecb: 39           rts
9ecc: 86 52        ldaa 0x52
9ece: c6 2b        ldab 0x2B
9ed0: bd 8d b5     jsr (0x8DB5)
9ed3: 86 4c        ldaa 0x4C
9ed5: c6 32        ldab 0x32
9ed7: bd 8d b5     jsr (0x8DB5)
9eda: ce 04 02     ldx 0x0402
9edd: c6 2c        ldab 0x2C
9edf: a6 00        ldaa (X+0x00)
9ee1: bd 8d b5     jsr (0x8DB5)
9ee4: 5c           incb
9ee5: 08           inx
9ee6: 8c 04 05     cpx 0x0405
9ee9: 26 f4        bne [0x9EDF]
9eeb: c6 33        ldab 0x33
9eed: a6 00        ldaa (X+0x00)
9eef: bd 8d b5     jsr (0x8DB5)
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
9f36: 50           negb
9f37: 61           ?
9f38: 73 73 77     com (0x7377)
9f3b: 6f 72        clr (X+0x72)
9f3d: 64 20        lsr (X+0x20)
9f3f: 62           ?
9f40: 79 70 61     rol (0x7061)
9f43: 73 73 a0     com (0x73A0)
9f46: c6 04        ldab 0x04
9f48: bd 8c 30     jsr (0x8C30)
9f4b: 0c           clc
9f4c: 39           rts
9f4d: bd 8c f2     jsr (0x8CF2)
9f50: bd 8d 03     jsr (0x8D03)
9f53: bd 8d e4     jsr (0x8DE4)
9f56: 43           coma
9f57: 6f 64        clr (X+0x64)
9f59: 65           ?
9f5a: ba ce 02     oraa (0xCE02)
9f5d: 90 7f        suba (0x007F)
9f5f: 00           test
9f60: 16           tab
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
9f89: 50           negb
9f8a: 73 77 64     com (0x7764)
9f8d: ba ce 02     oraa (0xCE02)
9f90: 88 86        eora 0x86
9f92: 41           ?
9f93: 97 16        staa (0x0016)
9f95: 86 c5        ldaa 0xC5
9f97: 97 15        staa (0x0015)
9f99: 96 15        ldaa (0x0015)
9f9b: bd 8c 86     jsr (0x8C86)
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
a0d3: 46           rora
a0d4: 61           ?
a0d5: 69 6c        rol (X+0x6C)
a0d7: 65           ?
a0d8: 64 21        lsr (X+0x21)
a0da: 20 20        bra [0xA0FC]
a0dc: 20 20        bra [0xA0FE]
a0de: 20 20        bra [0xA100]
a0e0: 20 20        bra [0xA102]
a0e2: a0 c6        suba (X+0xC6)
a0e4: 02           idiv
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
a0ff: 20 20        bra [0xA121]
a101: 20 56        bra [0xA159]
a103: 43           coma
a104: 52           ?
a105: 20 61        bra [0xA168]
a107: 64 6a        lsr (X+0x6A)
a109: 75           ?
a10a: 73 f4 bd     com (0xF4BD)
a10d: 8d dd        bsr [0xA0EC]
a10f: 55           ?
a110: 50           negb
a111: 20 74        bra [0xA187]
a113: 6f 20        clr (X+0x20)
a115: 63 6c        com (X+0x6C)
a117: 65           ?
a118: 61           ?
a119: 72           ?
a11a: 20 62        bra [0xA17E]
a11c: 69 74        rol (X+0x74)
a11e: f3 5f d7     addd (0x5FD7)
a121: 62           ?
a122: bd f9 c5     jsr (0xF9C5)
a125: b6 18 04     ldaa (0x1804)
a128: 84 bf        anda 0xBF
a12a: b7 18 04     staa (0x1804)
a12d: bd 8e 95     jsr (0x8E95)
a130: 7f 00 48     clr (0x0048)
a133: 7f 00 49     clr (0x0049)
a136: bd 86 c4     jsr (0x86C4)
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
a167: bd 86 c4     jsr (0x86C4)
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
a195: bd 86 c4     jsr (0x86C4)
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
a232: 18 3c        pshy
a234: c6 03        ldab 0x03
a236: f7 10 3b     stab (PPROG)
a239: 18 ce 1b 58  ldy 0x1B58
a23d: 18 09        dey
a23f: 26 fc        bne [0xA23D]
a241: c6 02        ldab 0x02
a243: f7 10 3b     stab (PPROG)
a246: 18 38        puly
a248: 39           rts
a249: 0f           sei
a24a: ce 00 10     ldx 0x0010
a24d: 6f 00        clr (X+0x00)
a24f: 08           inx
a250: 8c 0e 00     cpx 0x0E00
a253: 26 f8        bne [0xA24D]
a255: bd 9e af     jsr (0x9EAF)
a258: bd 9e 92     jsr (0x9E92)
a25b: 7e f8 00     jmp (0xF800)
a25e: 18 ce 80 03  ldy 0x8003
a262: ce 00 00     ldx 0x0000
a265: 18 e6 00     ldab (Y+0x00)
a268: 3a           abx
a269: 18 08        iny
a26b: 18 8c 80 50  cpy 0x8050
a26f: 26 f4        bne [0xA265]
a271: ff 04 0b     stx (0x040B)
a274: 39           rts
a275: 0f           sei
a276: 7f 04 0f     clr (0x040F)
a279: 86 0e        ldaa 0x0E
a27b: b7 10 3b     staa (PPROG)
a27e: 86 ff        ldaa 0xFF
a280: b7 0e 20     staa (0x0E20)
a283: b6 10 3b     ldaa (PPROG)
a286: 8a 01        oraa 0x01
a288: b7 10 3b     staa (PPROG)
a28b: ce 1b 58     ldx 0x1B58
a28e: 09           dex
a28f: 26 fd        bne [0xA28E]
a291: b6 10 3b     ldaa (PPROG)
a294: 84 fe        anda 0xFE
a296: 7f 10 3b     clr (PPROG)

a299: bd f9 d8     jsr (0xF9D8)

'Enter serial #: '

a29c: 45           ?
a29d: 6e 74        jmp (X+0x74)
a29f: 65           ?
a2a0: 72           ?
a2a1: 20 73        bra [0xA316]
a2a3: 65           ?
a2a4: 72           ?
a2a5: 69 61        rol (X+0x61)
a2a7: 6c 20        inc (X+0x20)
a2a9: 23 3a        bls [0xA2E5]
a2ab: a0 

a2ac: ce 0e 20     ldx 0x0E20
a2af: bd f9 45     jsr (0xF945)
a2b2: 24 fb        bcc [0xA2AF]
a2b4: bd f9 6f     jsr (0xF9CF)
a2b7: c6 02        ldab 0x02
a2b9: f7 10 3b     stab (PPROG)
a2bc: a7 00        staa (X+0x00)
a2be: bd a2 32     jsr (0xA232)
a2c1: 08           inx
a2c2: 8c 0e 24     cpx 0x0E24
a2c5: 26 e8        bne [0xA2AF]
a2c7: c6 02        ldab 0x02
a2c9: f7 10 3b     stab (PPROG)
a2cc: 86 db        ldaa 0xDB
a2ce: b7 0e 24     staa (0x0E24)
a2d1: bd a2 32     jsr (0xA232)
a2d4: 7f 10 3b     clr (PPROG)
a2d7: 86 1e        ldaa 0x1E
a2d9: b7 10 35     staa (BPROT)
a2dc: 7e f8 00     jmp (0xF800)
a2df: 38           pulx
a2e0: 3c           pshx
a2e1: 8c 80 00     cpx 0x8000
a2e4: 25 02        bcs [0xA2E8]
a2e6: 0c           clc
a2e7: 39           rts
a2e8: 0d           sec
a2e9: 39           rts
a2ea: ce 02 88     ldx 0x0288
a2ed: c6 03        ldab 0x03
a2ef: bd f9 45     jsr (0xF945)
a2f2: 24 fb        bcc [0xA2EF]
a2f4: a7 00        staa (X+0x00)
a2f6: 08           inx
a2f7: 5a           decb
a2f8: 26 f5        bne [0xA2EF]
a2fa: b6 02 88     ldaa (0x0288)
a2fd: 81 13        cmpa 0x13
a2ff: 26 10        bne [0xA311]
a301: b6 02 89     ldaa (0x0289)
a304: 81 10        cmpa 0x10
a306: 26 09        bne [0xA311]
a308: b6 02 8a     ldaa (0x028A)
a30b: 81 14        cmpa 0x14
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
a366: 7f 00 4e     clr (0x004E)
a369: bd 86 c4     jsr (0x86C4)
a36c: 7f 04 2a     clr (0x042A)

a36f: bd f9 d8     jsr (0xF9D8)
'Enter security code:'

a372: 45           ?
a373: 6e 74        jmp (X+0x74)
a375: 65           ?
a376: 72           ?
a377: 20 73        bra [0xA3EC]
a379: 65           ?
a37a: 63 75        com (X+0x75)
a37c: 72           ?
a37d: 69 74        rol (X+0x74)
a37f: 79 20 63     rol (0x2063)
a382: 6f 64        clr (X+0x64)
a384: 65           ?
a385: ba 

a386: bd a2 ea     jsr (0xA2EA)
a389: 24 03        bcc [0xA38E]
a38b: 7e 83 31     jmp (0x8331)

a38e: bd f9 d8     jsr (0xF9D8)
; Dave's setup utility - BIG MENU - TBD

a391: 0c           clc
a392: 0a           clv
a393: 0d           sec
a394: 44           lsra
a395: 61           ?
a396: 76 65 27     ror (0x6527)
a399: 73 20 53     com (0x2053)
a39c: 65           ?
a39d: 74 75 70     lsr (0x7570)
a3a0: 20 55        bra [0xA3F7]
a3a2: 74 69 6c     lsr (0x696C)
a3a5: 69 74        rol (X+0x74)
a3a7: 79 0a 0d     rol (0x0A0D)
a3aa: 3c           pshx
a3ab: 4b           ?
a3ac: 3e           wai
a3ad: 69 6e        rol (X+0x6E)
a3af: 67 20        asr (X+0x20)
a3b1: 65           ?
a3b2: 6e 61        jmp (X+0x61)
a3b4: 62           ?
a3b5: 6c 65        inc (X+0x65)
a3b7: 0a           clv
a3b8: 0d           sec
a3b9: 3c           pshx
a3ba: 43           coma
a3bb: 3e           wai
a3bc: 6c 65        inc (X+0x65)
a3be: 61           ?
a3bf: 72           ?
a3c0: 20 72        bra [0xA434]
a3c2: 61           ?
a3c3: 6e 64        jmp (X+0x64)
a3c5: 6f 6d        clr (X+0x6D)
a3c7: 0a           clv
a3c8: 0d           sec
a3c9: 3c           pshx
a3ca: 35           txs
a3cb: 3e           wai
a3cc: 20 63        bra [0xA431]
a3ce: 68 61        asl (X+0x61)
a3d0: 72           ?
a3d1: 61           ?
a3d2: 63 74        com (X+0x74)
a3d4: 65           ?
a3d5: 72           ?
a3d6: 20 72        bra [0xA44A]
a3d8: 61           ?
a3d9: 6e 64        jmp (X+0x64)
a3db: 6f 6d        clr (X+0x6D)
a3dd: 0a           clv
a3de: 0d           sec
a3df: 3c           pshx
a3e0: 4c           inca
a3e1: 3e           wai
a3e2: 69 76        rol (X+0x76)
a3e4: 65           ?
a3e5: 20 74        bra [0xA45B]
a3e7: 61           ?
a3e8: 70 65 20     neg (0x6520)
a3eb: 6e 75        jmp (X+0x75)
a3ed: 6d 62        tst (X+0x62)
a3ef: 65           ?
a3f0: 72           ?
a3f1: 20 63        bra [0xA456]
a3f3: 6c 65        inc (X+0x65)
a3f5: 61           ?
a3f6: 72           ?
a3f7: 0a           clv
a3f8: 0d           sec
a3f9: 3c           pshx
a3fa: 52           ?
a3fb: 3e           wai
a3fc: 65           ?
a3fd: 67 75        asr (X+0x75)
a3ff: 6c 61        inc (X+0x61)
a401: 72           ?
a402: 20 74        bra [0xA478]
a404: 61           ?
a405: 70 65 20     neg (0x6520)
a408: 6e 75        jmp (X+0x75)
a40a: 6d 62        tst (X+0x62)
a40c: 65           ?
a40d: 72           ?
a40e: 20 63        bra [0xA473]
a410: 6c 65        inc (X+0x65)
a412: 61           ?
a413: 72           ?
a414: 0a           clv
a415: 0d           sec
a416: 3c           pshx
a417: 54           lsrb
a418: 3e           wai
a419: 65           ?
a41a: 73 74 20     com (0x7420)
a41d: 64 72        lsr (X+0x72)
a41f: 69 76        rol (X+0x76)
a421: 65           ?
a422: 72           ?
a423: 20 62        bra [0xA487]
a425: 6f 61        clr (X+0x61)
a427: 72           ?
a428: 64 73        lsr (X+0x73)
a42a: 0a           clv
a42b: 0d           sec
a42c: 3c           pshx
a42d: 42           ?
a42e: 3e           wai
a42f: 75           ?
a430: 62           ?
a431: 20 74        bra [0xA4A7]
a433: 65           ?
a434: 73 74 0a     com (0x740A)
a437: 0d           sec
a438: 3c           pshx
a439: 44           lsra
a43a: 3e           wai
a43b: 65           ?
a43c: 63 6b        com (X+0x6B)
a43e: 20 74        bra [0xA4B4]
a440: 65           ?
a441: 73 74 20     com (0x7420)
a444: 28 77        bvc [0xA4BD]
a446: 69 74        rol (X+0x74)
a448: 68 20        asl (X+0x20)
a44a: 74 61 70     lsr (0x6170)
a44d: 65           ?
a44e: 20 69        bra [0xA4B9]
a450: 6e 73        jmp (X+0x73)
a452: 65           ?
a453: 72           ?
a454: 74 65 64     lsr (0x6564)
a457: 29 0a        bvs [0xA463]
a459: 0d           sec
a45a: 3c           pshx
a45b: 37           pshb
a45c: 3e           wai
a45d: 35           txs
a45e: 25 20        bcs [0xA480]
a460: 61           ?
a461: 64 6a        lsr (X+0x6A)
a463: 75           ?
a464: 73 74 6d     com (0x746D)
a467: 65           ?
a468: 6e 74        jmp (X+0x74)
a46a: 0a           clv
a46b: 0d           sec
a46c: 3c           pshx
a46d: 53           comb
a46e: 3e           wai
a46f: 68 6f        asl (X+0x6F)
a471: 77 20 72     asr (0x2072)
a474: 65           ?
a475: 2d 76        blt [0xA4ED]
a477: 61           ?
a478: 6c 69        inc (X+0x69)
a47a: 64 20        lsr (X+0x20)
a47c: 74 61 70     lsr (0x6170)
a47f: 65           ?
a480: 73 0a 0d     com (0x0A0D)
a483: 3c           pshx
a484: 4a           deca
a485: 3e           wai
a486: 75           ?
a487: 6d 70        tst (X+0x70)
a489: 20 74        bra [0xA4FF]
a48b: 6f 20        clr (X+0x20)
a48d: 73 79 73     com (0x7973)
a490: 74 65 6d     lsr (0x656D)
a493: 0a           clv
a494: 8d 

a495: bd f9 45     jsr (0xF945)
a498: 24 fb        bcc [0xA495]
a49A: 81 43        cmpa 0x43
a49c: 26 09        bne [0xA4A7]
a49e: 7f 04 01     clr (0x0401)
a4a1: 7f 04 2b     clr (0x042B)
a4a4: 7e a5 14     jmp (0xA514)
a4a7: 81 35        cmpa 0x35
a4a9: 26 0d        bne [0xA4B8]
a4ab: b6 04 01     ldaa (0x0401)
a4ae: 84 7f        anda 0x7F
a4b0: 8a 7f        oraa 0x7F
a4b2: b7 04 01     staa (0x0401)
a4b5: 7e a5 14     jmp (0xA514)
a4b8: 81 4c        cmpa 0x4C
a4ba: 26 06        bne [0xA4C2]
a4bc: bd 9e af     jsr (0x9EAF)
a4bf: 7e a5 14     jmp (0xA514)
a4c2: 81 52        cmpa 0x52
a4c4: 26 06        bne [0xA4CC]
a4c6: bd 9e 92     jsr (0x9E92)
a4c9: 7e a5 14     jmp (0xA514)
a4cc: 81 54        cmpa 0x54
a4ce: 26 06        bne [0xA4D6]
a4d0: bd a5 65     jsr (0xA565)
a4d3: 7e a5 14     jmp (0xA514)
a4d6: 81 42        cmpa 0x42
a4d8: 26 06        bne [0xA4E0]
a4da: bd a5 26     jsr (0xA526)
a4dd: 7e a5 14     jmp (0xA514)
a4e0: 81 44        cmpa 0x44
a4e2: 26 06        bne [0xA4EA]
a4e4: bd a5 3c     jsr (0xA53C)
a4e7: 7e a5 14     jmp (0xA514)
a4ea: 81 37        cmpa 0x37
a4ec: 26 08        bne [0xA4F6]
a4ee: c6 fb        ldab 0xFB
a4f0: bd 86 e7     jsr (0x86E7)
a4f3: 7e a5 14     jmp (0xA514)
a4f6: 81 4a        cmpa 0x4A
a4f8: 26 03        bne [0xA4FD]
a4fa: 7e f8 00     jmp (0xF800)
a4fd: 81 4b        cmpa 0x4B
a4ff: 26 06        bne [0xA507]
a501: 7c 04 2a     inc (0x042A)
a504: 7e a5 14     jmp (0xA514)
a507: 81 53        cmpa 0x53
a509: 26 06        bne [0xA511]
a50b: bd ab 7c     jsr (0xAB7C)
a50e: 7e a5 14     jmp (0xA514)
a511: 7e a4 95     jmp (0xA495)
a514: 86 07        ldaa 0x07
a516: bd f9 6f     jsr (0xF96F)
a519: c6 01        ldab 0x01
a51b: bd 8c 30     jsr (0x8C30)
a51e: 86 07        ldaa 0x07
a520: bd f9 6f     jsr (0xF96F)
a523: 7e a3 8e     jmp (0xA38E)
a526: 5f           clrb
a527: bd f9 c5     jsr (0xF9C5)
a52a: f6 10 0a     ldab (PORTE)
a52d: c8 ff        eorb 0xFF
a52f: bd f9 c5     jsr (0xF9C5)
a532: c1 80        cmpb 0x80
a534: 26 f4        bne [0xA52A]
a536: c6 02        ldab 0x02
a538: bd 8c 30     jsr (0x8C30)
a53b: 39           rts
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
a565: bd f9 45     jsr (0xF945)
a568: 24 08        bcc [0xA572]
a56a: 81 1b        cmpa 0x1B
a56c: 26 04        bne [0xA572]
a56e: bd 86 c4     jsr (0x86C4)
a571: 39           rts
a572: 86 08        ldaa 0x08
a574: 97 15        staa (0x0015)
a576: bd 86 c4     jsr (0x86C4)
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
a5ad: bd f9 95     jsr (0xF995)
a5b0: 37           pshb
a5b1: c6 27        ldab 0x27
a5b3: 96 15        ldaa (0x0015)
a5b5: 0c           clc
a5b6: 89 30        adca 0x30
a5b8: bd 8d b5     jsr (0x8DB5)
a5bb: 33           pulb
a5bc: 32           pula
a5bd: 5d           tstb
a5be: 26 bb        bne [0xA57B]
a5c0: 86 08        ldaa 0x08
a5c2: 97 15        staa (0x0015)
a5c4: bd 86 c4     jsr (0x86C4)
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
a5ed: bd f9 95     jsr (0xF995)
a5f0: 37           pshb
a5f1: c6 27        ldab 0x27
a5f3: 96 15        ldaa (0x0015)
a5f5: 0c           clc
a5f6: 89 30        adca 0x30
a5f8: bd 8d b5     jsr (0x8DB5)
a5fb: 33           pulb
a5fc: 32           pula
a5fd: 7d 00 15     tst (0x0015)
a600: 26 c7        bne [0xA5C9]
a602: bd 86 c4     jsr (0x86C4)
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
a61f: bd f9 95     jsr (0xF995)
a622: 37           pshb
a623: c6 27        ldab 0x27
a625: 32           pula
a626: 36           psha
a627: 0c           clc
a628: 89 30        adca 0x30
a62a: bd 8d b5     jsr (0x8DB5)
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
a654: dd 23        std (0x0023)
a656: 7d 00 24     tst (0x0024)
a659: 26 fb        bne [0xA656]
a65b: 32           pula
a65c: 39           rts
a65d: 30           tsx
a65e: 2c 43        bge [0xA6A3]
a660: 68 75        asl (X+0x75)
a662: 63 6b        com (X+0x6B)
a664: 2c 4d        bge [0xA6B3]
a666: 6f 75        clr (X+0x75)
a668: 74 68 2c     lsr (0x682C)
a66b: 31           ins
a66c: 2c 48        bge [0xA6B6]
a66e: 65           ?
a66f: 61           ?
a670: 64 20        lsr (X+0x20)
a672: 6c 65        inc (X+0x65)
a674: 66 74        ror (X+0x74)
a676: 2c 32        bge [0xA6AA]
a678: 2c 48        bge [0xA6C2]
a67a: 65           ?
a67b: 61           ?
a67c: 64 20        lsr (X+0x20)
a67e: 72           ?
a67f: 69 67        rol (X+0x67)
a681: 68 74        asl (X+0x74)
a683: 2c 32        bge [0xA6B7]
a685: 2c 48        bge [0xA6CF]
a687: 65           ?
a688: 61           ?
a689: 64 20        lsr (X+0x20)
a68b: 75           ?
a68c: 70 2c 32     neg (0x2C32)
a68f: 2c 45        bge [0xA6D6]
a691: 79 65 73     rol (0x6573)
a694: 20 72        bra [0xA708]
a696: 69 67        rol (X+0x67)
a698: 68 74        asl (X+0x74)
a69a: 2c 31        bge [0xA6CD]
a69c: 2c 45        bge [0xA6E3]
a69e: 79 65 6c     rol (0x656C)
a6a1: 69 64        rol (X+0x64)
a6a3: 73 2c 31     com (0x2C31)
a6a6: 2c 52        bge [0xA6FA]
a6a8: 69 67        rol (X+0x67)
a6aa: 68 74        asl (X+0x74)
a6ac: 20 68        bra [0xA716]
a6ae: 61           ?
a6af: 6e 64        jmp (X+0x64)
a6b1: 2c 32        bge [0xA6E5]
a6b3: 2c 45        bge [0xA6FA]
a6b5: 79 65 73     rol (0x6573)
a6b8: 20 6c        bra [0xA726]
a6ba: 65           ?
a6bb: 66 74        ror (X+0x74)
a6bd: 2c 31        bge [0xA6F0]
a6bf: 2c 38        bge [0xA6F9]
a6c1: 2c 48        bge [0xA70B]
a6c3: 65           ?
a6c4: 6c 65        inc (X+0x65)
a6c6: 6e 2c        jmp (X+0x2C)
a6c8: 4d           tsta
a6c9: 6f 75        clr (X+0x75)
a6cb: 74 68 2c     lsr (0x682C)
a6ce: 31           ins
a6cf: 2c 48        bge [0xA719]
a6d1: 65           ?
a6d2: 61           ?
a6d3: 64 20        lsr (X+0x20)
a6d5: 6c 65        inc (X+0x65)
a6d7: 66 74        ror (X+0x74)
a6d9: 2c 32        bge [0xA70D]
a6db: 2c 48        bge [0xA725]
a6dd: 65           ?
a6de: 61           ?
a6df: 64 20        lsr (X+0x20)
a6e1: 72           ?
a6e2: 69 67        rol (X+0x67)
a6e4: 68 74        asl (X+0x74)
a6e6: 2c 32        bge [0xA71A]
a6e8: 2c 48        bge [0xA732]
a6ea: 65           ?
a6eb: 61           ?
a6ec: 64 20        lsr (X+0x20)
a6ee: 75           ?
a6ef: 70 2c 32     neg (0x2C32)
a6f2: 2c 45        bge [0xA739]
a6f4: 79 65 73     rol (0x6573)
a6f7: 20 72        bra [0xA76B]
a6f9: 69 67        rol (X+0x67)
a6fb: 68 74        asl (X+0x74)
a6fd: 2c 31        bge [0xA730]
a6ff: 2c 45        bge [0xA746]
a701: 79 65 6c     rol (0x656C)
a704: 69 64        rol (X+0x64)
a706: 73 2c 31     com (0x2C31)
a709: 2c 52        bge [0xA75D]
a70b: 69 67        rol (X+0x67)
a70d: 68 74        asl (X+0x74)
a70f: 20 68        bra [0xA779]
a711: 61           ?
a712: 6e 64        jmp (X+0x64)
a714: 2c 32        bge [0xA748]
a716: 2c 45        bge [0xA75D]
a718: 79 65 73     rol (0x6573)
a71b: 20 6c        bra [0xA789]
a71d: 65           ?
a71e: 66 74        ror (X+0x74)
a720: 2c 31        bge [0xA753]
a722: 2c 36        bge [0xA75A]
a724: 2c 4d        bge [0xA773]
a726: 75           ?
a727: 6e 63        jmp (X+0x63)
a729: 68 2c        asl (X+0x2C)
a72b: 4d           tsta
a72c: 6f 75        clr (X+0x75)
a72e: 74 68 2c     lsr (0x682C)
a731: 31           ins
a732: 2c 48        bge [0xA77C]
a734: 65           ?
a735: 61           ?
a736: 64 20        lsr (X+0x20)
a738: 6c 65        inc (X+0x65)
a73a: 66 74        ror (X+0x74)
a73c: 2c 32        bge [0xA770]
a73e: 2c 48        bge [0xA788]
a740: 65           ?
a741: 61           ?
a742: 64 20        lsr (X+0x20)
a744: 72           ?
a745: 69 67        rol (X+0x67)
a747: 68 74        asl (X+0x74)
a749: 2c 32        bge [0xA77D]
a74b: 2c 4c        bge [0xA799]
a74d: 65           ?
a74e: 66 74        ror (X+0x74)
a750: 20 61        bra [0xA7B3]
a752: 72           ?
a753: 6d 2c        tst (X+0x2C)
a755: 32           pula
a756: 2c 45        bge [0xA79D]
a758: 79 65 73     rol (0x6573)
a75b: 20 72        bra [0xA7CF]
a75d: 69 67        rol (X+0x67)
a75f: 68 74        asl (X+0x74)
a761: 2c 31        bge [0xA794]
a763: 2c 45        bge [0xA7AA]
a765: 79 65 6c     rol (0x656C)
a768: 69 64        rol (X+0x64)
a76a: 73 2c 31     com (0x2C31)
a76d: 2c 52        bge [0xA7C1]
a76f: 69 67        rol (X+0x67)
a771: 68 74        asl (X+0x74)
a773: 20 61        bra [0xA7D6]
a775: 72           ?
a776: 6d 2c        tst (X+0x2C)
a778: 32           pula
a779: 2c 45        bge [0xA7C0]
a77b: 79 65 73     rol (0x6573)
a77e: 20 6c        bra [0xA7EC]
a780: 65           ?
a781: 66 74        ror (X+0x74)
a783: 2c 31        bge [0xA7B6]
a785: 2c 32        bge [0xA7B9]
a787: 2c 4a        bge [0xA7D3]
a789: 61           ?
a78a: 73 70 65     com (0x7065)
a78d: 72           ?
a78e: 2c 4d        bge [0xA7DD]
a790: 6f 75        clr (X+0x75)
a792: 74 68 2c     lsr (0x682C)
a795: 31           ins
a796: 2c 48        bge [0xA7E0]
a798: 65           ?
a799: 61           ?
a79a: 64 20        lsr (X+0x20)
a79c: 6c 65        inc (X+0x65)
a79e: 66 74        ror (X+0x74)
a7a0: 2c 32        bge [0xA7D4]
a7a2: 2c 48        bge [0xA7EC]
a7a4: 65           ?
a7a5: 61           ?
a7a6: 64 20        lsr (X+0x20)
a7a8: 72           ?
a7a9: 69 67        rol (X+0x67)
a7ab: 68 74        asl (X+0x74)
a7ad: 2c 32        bge [0xA7E1]
a7af: 2c 48        bge [0xA7F9]
a7b1: 65           ?
a7b2: 61           ?
a7b3: 64 20        lsr (X+0x20)
a7b5: 75           ?
a7b6: 70 2c 32     neg (0x2C32)
a7b9: 2c 45        bge [0xA800]
a7bb: 79 65 73     rol (0x6573)
a7be: 20 72        bra [0xA832]
a7c0: 69 67        rol (X+0x67)
a7c2: 68 74        asl (X+0x74)
a7c4: 2c 31        bge [0xA7F7]
a7c6: 2c 45        bge [0xA80D]
a7c8: 79 65 6c     rol (0x656C)
a7cb: 69 64        rol (X+0x64)
a7cd: 73 2c 31     com (0x2C31)
a7d0: 2c 48        bge [0xA81A]
a7d2: 61           ?
a7d3: 6e 64        jmp (X+0x64)
a7d5: 73 2c 32     com (0x2C32)
a7d8: 2c 45        bge [0xA81F]
a7da: 79 65 73     rol (0x6573)
a7dd: 20 6c        bra [0xA84B]
a7df: 65           ?
a7e0: 66 74        ror (X+0x74)
a7e2: 2c 31        bge [0xA815]
a7e4: 2c 34        bge [0xA81A]
a7e6: 2c 50        bge [0xA838]
a7e8: 61           ?
a7e9: 73 71 75     com (0x7175)
a7ec: 61           ?
a7ed: 6c 6c        inc (X+0x6C)
a7ef: 79 2c 4d     rol (0x2C4D)
a7f2: 6f 75        clr (X+0x75)
a7f4: 74 68 2d     lsr (0x682D)
a7f7: 4d           tsta
a7f8: 75           ?
a7f9: 73 74 61     com (0x7461)
a7fc: 63 68        com (X+0x68)
a7fe: 65           ?
a7ff: 2c 31        bge [0xA832]
a801: 2c 48        bge [0xA84B]
a803: 65           ?
a804: 61           ?
a805: 64 20        lsr (X+0x20)
a807: 6c 65        inc (X+0x65)
a809: 66 74        ror (X+0x74)
a80b: 2c 32        bge [0xA83F]
a80d: 2c 48        bge [0xA857]
a80f: 65           ?
a810: 61           ?
a811: 64 20        lsr (X+0x20)
a813: 72           ?
a814: 69 67        rol (X+0x67)
a816: 68 74        asl (X+0x74)
a818: 2c 32        bge [0xA84C]
a81a: 2c 4c        bge [0xA868]
a81c: 65           ?
a81d: 66 74        ror (X+0x74)
a81f: 20 61        bra [0xA882]
a821: 72           ?
a822: 6d 2c        tst (X+0x2C)
a824: 32           pula
a825: 2c 45        bge [0xA86C]
a827: 79 65 73     rol (0x6573)
a82a: 20 72        bra [0xA89E]
a82c: 69 67        rol (X+0x67)
a82e: 68 74        asl (X+0x74)
a830: 2c 31        bge [0xA863]
a832: 2c 45        bge [0xA879]
a834: 79 65 6c     rol (0x656C)
a837: 69 64        rol (X+0x64)
a839: 73 2c 31     com (0x2C31)
a83c: 2c 52        bge [0xA890]
a83e: 69 67        rol (X+0x67)
a840: 68 74        asl (X+0x74)
a842: 20 61        bra [0xA8A5]
a844: 72           ?
a845: 6d 2c        tst (X+0x2C)
a847: 32           pula
a848: 2c 45        bge [0xA88F]
a84a: 79 65 73     rol (0x6573)
a84d: 20 6c        bra [0xA8BB]
a84f: 65           ?
a850: 66 74        ror (X+0x74)
a852: 2c 31        bge [0xA885]
a854: 2c 3c        bge [0xA892]
a856: bd 86 c4     jsr (0x86C4)
a859: ce 10 80     ldx 0x1080
a85c: 86 20        ldaa 0x20
a85e: a7 00        staa (X+0x00)
a860: a7 04        staa (X+0x04)
a862: a7 08        staa (X+0x08)
a864: a7 0c        staa (X+0x0C)
a866: a7 10        staa (X+0x10)
a868: 38           pulx
a869: 39           rts
a86a: bd a3 2e     jsr (0xA32E)
a86d: bd 8d e4     jsr (0x8DE4)
a870: 20 20        bra [0xA892]
a872: 20 20        bra [0xA894]
a874: 57           asrb
a875: 61           ?
a876: 72           ?
a877: 6d 2d        tst (X+0x2D)
a879: 55           ?
a87a: 70 20 a0     neg (0x20A0)
a87d: bd 8d dd     jsr (0x8DDD)
a880: 43           coma
a881: 75           ?
a882: 72           ?
a883: 74 61 69     lsr (0x6169)
a886: 6e 73        jmp (X+0x73)
a888: 20 6f        bra [0xA8F9]
a88a: 70 65 6e     neg (0x656E)
a88d: 69 6e        rol (X+0x6E)
a88f: e7 c6        stab (X+0xC6)
a891: 14 bd 8c     bset (0x00BD), 0x8C
a894: 30           tsx
a895: bd a8 55     jsr (0xA855)
a898: c6 02        ldab 0x02
a89a: bd 8c 30     jsr (0x8C30)
a89d: ce a6 5d     ldx 0xA65D
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
a8c5: 86 4f        ldaa 0x4F
a8c7: c6 0c        ldab 0x0C
a8c9: bd 8d b5     jsr (0x8DB5)
a8cc: 86 6e        ldaa 0x6E
a8ce: c6 0d        ldab 0x0D
a8d0: bd 8d b5     jsr (0x8DB5)
a8d3: cc 20 0e     ldd 0x200E
a8d6: bd 8d b5     jsr (0x8DB5)
a8d9: 7a 00 4c     dec (0x004C)
a8dc: 32           pula
a8dd: 36           psha
a8de: c6 64        ldab 0x64
a8e0: 3d           mul
a8e1: dd 23        std (0x0023)
a8e3: dc 23        ldd (0x0023)
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
a908: 86 66        ldaa 0x66
a90a: c6 0d        ldab 0x0D
a90c: bd 8d b5     jsr (0x8DB5)
a90f: 86 66        ldaa 0x66
a911: c6 0e        ldab 0x0E
a913: bd 8d b5     jsr (0x8DB5)
a916: 32           pula
a917: c6 64        ldab 0x64
a919: 3d           mul
a91a: dd 23        std (0x0023)
a91c: dc 23        ldd (0x0023)
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
a93a: bd 86 c4     jsr (0x86C4)
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
a9a0: bd 86 c4     jsr (0x86C4)
a9a3: bd 8c e9     jsr (0x8CE9)
a9a6: bd 8d e4     jsr (0x8DE4)
a9a9: 20 20        bra [0xA9CB]
a9ab: 20 20        bra [0xA9CD]
a9ad: 20 53        bra [0xAA02]
a9af: 54           lsrb
a9b0: 55           ?
a9b1: 44           lsra
a9b2: 49           rola
a9b3: cf           stop
a9b4: bd 8d dd     jsr (0x8DDD)
a9b7: 70 72 6f     neg (0x726F)
a9ba: 67 72        asr (X+0x72)
a9bc: 61           ?
a9bd: 6d 6d        tst (X+0x6D)
a9bf: 69 6e        rol (X+0x6E)
a9c1: 67 20        asr (X+0x20)
a9c3: 6d 6f        tst (X+0x6F)
a9c5: 64 e5        lsr (X+0xE5)
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
aa0c: cc 48 37     ldd 0x4837
aa0f: bd 8d b5     jsr (0x8DB5)
aa12: 39           rts
aa13: cc 20 37     ldd 0x2037
aa16: 20 f7        bra [0xAA0F]
aa18: cc 42 0f     ldd 0x420F
aa1b: 20 f2        bra [0xAA0F]
aa1d: cc 20 0f     ldd 0x200F
aa20: 20 ed        bra [0xAA0F]
aa22: 7f 00 4f     clr (0x004F)
aa25: cc 00 01     ldd 0x0001
aa28: dd 1b        std (0x001B)
aa2a: ce 20 00     ldx 0x2000
aa2d: b6 10 a8     ldaa (0x10A8)
aa30: 84 01        anda 0x01
aa32: 27 f9        beq [0xAA2D]
aa34: dc 1b        ldd (0x001B)
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
aa4c: dd 1b        std (0x001B)
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
abb4: dd 23        std (0x0023)
abb6: 96 4a        ldaa (0x004A)
abb8: 26 08        bne [0xABC2]
abba: bd 9b 19     jsr (0x9B19)
abbd: dc 23        ldd (0x0023)
abbf: 26 f5        bne [0xABB6]
abc1: 39           rts
abc2: 81 31        cmpa 0x31
abc4: 26 04        bne [0xABCA]
abc6: bd ab 17     jsr (0xAB17)
abc9: 39           rts
abca: 20 f5        bra [0xABC1]
abcc: dc 10        ldd (0x0010)
abce: c3 02 71     addd 0x0271
abd1: fd 10 16     std (TOC1)
abd4: dd 10        std (0x0010)
abd6: 86 80        ldaa 0x80
abd8: b7 10 23     staa (TFLG1)
abdb: 7d 00 78     tst (0x0078)
abde: 27 1c        beq [0xABFC]
abe0: dc 25        ldd (0x0025)
abe2: c3 00 01     addd 0x0001
abe5: dd 25        std (0x0025)
abe7: 1a 83 00 c8  cpd 0x00C8
abeb: 26 0f        bne [0xABFC]
abed: 7f 00 25     clr (0x0025)
abf0: 7f 00 26     clr (0x0026)
abf3: d6 62        ldab (0x0062)
abf5: c8 08        eorb 0x08
abf7: d7 62        stab (0x0062)
abf9: bd f9 c5     jsr (0xF9C5)
abfc: 7c 00 6f     inc (0x006F)
abff: 96 6f        ldaa (0x006F)
ac01: 81 28        cmpa 0x28
ac03: 25 42        bcs [0xAC47]
ac05: 7f 00 6f     clr (0x006F)
ac08: 7d 00 63     tst (0x0063)
ac0b: 27 03        beq [0xAC10]
ac0d: 7a 00 63     dec (0x0063)
ac10: 96 70        ldaa (0x0070)
ac12: 4a           deca
ac13: 97 70        staa (0x0070)
ac15: 26 04        bne [0xAC1B]
ac17: 86 fa        ldaa 0xFA
ac19: 97 70        staa (0x0070)
ac1b: 96 71        ldaa (0x0071)
ac1d: 4a           deca
ac1e: 97 71        staa (0x0071)
ac20: 26 04        bne [0xAC26]
ac22: 86 e6        ldaa 0xE6
ac24: 97 71        staa (0x0071)
ac26: 96 72        ldaa (0x0072)
ac28: 4a           deca
ac29: 97 72        staa (0x0072)
ac2b: 26 04        bne [0xAC31]
ac2d: 86 d2        ldaa 0xD2
ac2f: 97 72        staa (0x0072)
ac31: 96 73        ldaa (0x0073)
ac33: 4a           deca
ac34: 97 73        staa (0x0073)
ac36: 26 04        bne [0xAC3C]
ac38: 86 be        ldaa 0xBE
ac3a: 97 73        staa (0x0073)
ac3c: 96 74        ldaa (0x0074)
ac3e: 4a           deca
ac3f: 97 74        staa (0x0074)
ac41: 26 04        bne [0xAC47]
ac43: 86 aa        ldaa 0xAA
ac45: 97 74        staa (0x0074)
ac47: 96 27        ldaa (0x0027)
ac49: 4c           inca
ac4a: 97 27        staa (0x0027)
ac4c: 81 0c        cmpa 0x0C
ac4e: 23 09        bls [0xAC59]
ac50: 7f 00 27     clr (0x0027)
ac53: bd 8e c6     jsr (0x8EC6)
ac56: bd 8f 12     jsr (0x8F12)
ac59: 96 43        ldaa (0x0043)
ac5b: 27 55        beq [0xACB2]
ac5d: de 44        ldx (0x0044)
ac5f: a6 00        ldaa (X+0x00)
ac61: 27 23        beq [0xAC86]
ac63: b7 10 00     staa (PORTA)
ac66: b6 10 02     ldaa (PORTG)
ac69: 84 f3        anda 0xF3
ac6b: b7 10 02     staa (PORTG)
ac6e: 84 fd        anda 0xFD
ac70: b7 10 02     staa (PORTG)
ac73: 8a 02        oraa 0x02
ac75: b7 10 02     staa (PORTG)
ac78: 08           inx
ac79: 08           inx
ac7a: 8c 05 80     cpx 0x0580
ac7d: 25 03        bcs [0xAC82]
ac7f: ce 05 00     ldx 0x0500
ac82: df 44        stx (0x0044)
ac84: 20 2c        bra [0xACB2]
ac86: a6 01        ldaa (X+0x01)
ac88: 27 25        beq [0xACAF]
ac8a: b7 10 00     staa (PORTA)
ac8d: b6 10 02     ldaa (PORTG)
ac90: 84 fb        anda 0xFB
ac92: 8a 08        oraa 0x08
ac94: b7 10 02     staa (PORTG)
ac97: 84 fd        anda 0xFD
ac99: b7 10 02     staa (PORTG)
ac9c: 8a 02        oraa 0x02
ac9e: b7 10 02     staa (PORTG)
aca1: 08           inx
aca2: 08           inx
aca3: 8c 05 80     cpx 0x0580
aca6: 25 03        bcs [0xACAB]
aca8: ce 05 00     ldx 0x0500
acab: df 44        stx (0x0044)
acad: 20 03        bra [0xACB2]
acaf: 7f 00 43     clr (0x0043)
acb2: 96 4f        ldaa (0x004F)
acb4: 4c           inca
acb5: 97 4f        staa (0x004F)
acb7: 81 04        cmpa 0x04
acb9: 26 30        bne [0xACEB]
acbb: 7f 00 4f     clr (0x004F)
acbe: dc 1b        ldd (0x001B)
acc0: 27 05        beq [0xACC7]
acc2: 83 00 01     subd 0x0001
acc5: dd 1b        std (0x001B)
acc7: dc 1d        ldd (0x001D)
acc9: 27 05        beq [0xACD0]
accb: 83 00 01     subd 0x0001
acce: dd 1d        std (0x001D)
acd0: dc 1f        ldd (0x001F)
acd2: 27 05        beq [0xACD9]
acd4: 83 00 01     subd 0x0001
acd7: dd 1f        std (0x001F)
acd9: dc 21        ldd (0x0021)
acdb: 27 05        beq [0xACE2]
acdd: 83 00 01     subd 0x0001
ace0: dd 21        std (0x0021)
ace2: dc 23        ldd (0x0023)
ace4: 27 05        beq [0xACEB]
ace6: 83 00 01     subd 0x0001
ace9: dd 23        std (0x0023)
aceb: 96 b0        ldaa (0x00B0)
aced: 88 01        eora 0x01
acef: 97 b0        staa (0x00B0)
acf1: 27 18        beq [0xAD0B]
acf3: bf 01 3c     sts (0x013C)
acf6: be 01 3e     lds (0x013E)
acf9: dc 10        ldd (0x0010)
acfb: 83 01 f4     subd 0x01F4
acfe: fd 10 18     std (TOC2)
ad01: 86 40        ldaa 0x40
ad03: b7 10 23     staa (TFLG1)
ad06: 86 c0        ldaa 0xC0
ad08: b7 10 22     staa (TMSK1)
ad0b: 3b           rti
ad0c: 86 40        ldaa 0x40
ad0e: b7 10 23     staa (TFLG1)
ad11: bf 01 3e     sts (0x013E)
ad14: be 01 3c     lds (0x013C)
ad17: 86 80        ldaa 0x80
ad19: b7 10 22     staa (TMSK1)
ad1c: 3b           rti

ad1d: 7d 04 2a     tst (0x042A)
ad20: 27 35        beq [0xAD57]
ad22: 96 b6        ldaa (0x00B6)
ad24: 26 03        bne [0xAD29]
ad26: 3f           swi
ad27: 20 f4        bra [0xAD1D]
ad29: 7f 00 b6     clr (0x00B6)
ad2c: c6 04        ldab 0x04
ad2e: 37           pshb
ad2f: ce ad 3c     ldx 0xAD3C
ad32: bd 8a 1a     jsr (0x8A1A)
ad35: 3f           swi
ad36: 33           pulb
ad37: 5a           decb
ad38: 26 f4        bne [0xAD2E]
ad3a: 20 e1        bra [0xAD1D]
ad3c: 53           comb
ad3d: 31           ins
ad3e: 00           test
ad3f: fc 02 9c     ldd (0x029C)
ad42: 1a 83 00 01  cpd 0x0001
ad46: 27 0c        beq [0xAD54]
ad48: 1a 83 03 e8  cpd 0x03E8
ad4c: 2d 09        blt [0xAD57]
ad4e: 1a 83 04 4b  cpd 0x044B
ad52: 22 03        bhi [0xAD57]
ad54: 3f           swi
ad55: 20 c6        bra [0xAD1D]
ad57: 7f 00 b3     clr (0x00B3)
ad5a: bd ad 7e     jsr (0xAD7E)
ad5d: bd ad a0     jsr (0xADA0)
ad60: 25 bb        bcs [0xAD1D]
ad62: c6 0a        ldab 0x0A
ad64: bd ae 13     jsr (0xAE13)
ad67: bd ad ae     jsr (0xADAE)
ad6a: 25 b1        bcs [0xAD1D]
ad6c: c6 14        ldab 0x14
ad6e: bd ae 13     jsr (0xAE13)
ad71: bd ad b6     jsr (0xADB6)
ad74: 25 a7        bcs [0xAD1D]
ad76: bd ad b8     jsr (0xADB8)
ad79: 0d           sec
ad7a: 25 a1        bcs [0xAD1D]
ad7c: 20 f8        bra [0xAD76]
ad7e: ce ae 1e     ldx 0xAE1E
ad81: bd 8a 1a     jsr (0x8A1A)
ad84: c6 1e        ldab 0x1E
ad86: bd ae 13     jsr (0xAE13)
ad89: ce ae 22     ldx 0xAE22
ad8c: bd 8a 1a     jsr (0x8A1A)
ad8f: c6 1e        ldab 0x1E
ad91: bd ae 13     jsr (0xAE13)
ad94: ce ae 27     ldx 0xAE27
ad97: bd 8a 1a     jsr (0x8A1A)
ad9a: c6 1e        ldab 0x1E
ad9c: bd ae 13     jsr (0xAE13)
ad9f: 39           rts
ada0: bd b1 dd     jsr (0xB1DD)
ada3: 25 fb        bcs [0xADA0]
ada5: bd b2 4f     jsr (0xB24F)
ada8: 52           ?
ada9: 49           rola
adaa: 4e           ?
adab: 47           asra
adac: 00           test
adad: 39           rts
adae: ce ae 2c     ldx 0xAE2C
adb1: bd 8a 1a     jsr (0x8A1A)
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
add1: ce b2 95     ldx 0xB295
add4: bd 8a 1a     jsr (0x8A1A)
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
ae01: ce b2 aa     ldx 0xB2AA
ae04: bd 8a 1a     jsr (0x8A1A)
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
ae1e: 2b 2b        bmi [0xAE4B]
ae20: 2b 00        bmi [0xAE22]
ae22: 41           ?
ae23: 54           lsrb
ae24: 48           asla
ae25: 0d           sec
ae26: 00           test
ae27: 41           ?
ae28: 54           lsrb
ae29: 5a           decb
ae2a: 0d           sec
ae2b: 00           test
ae2c: 41           ?
ae2d: 54           lsrb
ae2e: 41           ?
ae2f: 0d           sec
ae30: 00           test
ae31: ce ae 38     ldx 0xAE38
ae34: bd 8a 1a     jsr (0x8A1A)
ae37: 39           rts
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
b1d2: ce b1 d8     ldx 0xB1D8
b1d5: 7e 8a 1a     jmp (0x8A1A)
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
b24f: 38           pulx
b250: 18 ce 05 a0  ldy 0x05A0
b254: a6 00        ldaa (X+0x00)
b256: 27 11        beq [0xB269]
b258: 08           inx
b259: 18 a1 00     cmpa (Y+0x00)
b25c: 26 04        bne [0xB262]
b25e: 18 08        iny
b260: 20 f2        bra [0xB254]
b262: a6 00        ldaa (X+0x00)
b264: 27 07        beq [0xB26D]
b266: 08           inx
b267: 20 f9        bra [0xB262]
b269: 08           inx
b26a: 3c           pshx
b26b: 0c           clc
b26c: 39           rts
b26d: 08           inx
b26e: 3c           pshx
b26f: 0d           sec
b270: 39           rts
b271: ce 05 a0     ldx 0x05A0
b274: a6 00        ldaa (X+0x00)
b276: 08           inx
b277: 81 0d        cmpa 0x0D
b279: 26 f9        bne [0xB274]
b27b: 09           dex
b27c: 09           dex
b27d: a6 00        ldaa (X+0x00)
b27f: 09           dex
b280: 80 30        suba 0x30
b282: 97 b2        staa (0x00B2)
b284: 8c 05 9f     cpx 0x059F
b287: 27 0b        beq [0xB294]
b289: a6 00        ldaa (X+0x00)
b28b: 09           dex
b28c: 80 30        suba 0x30
b28e: c6 0a        ldab 0x0A
b290: 3d           mul
b291: 17           tba
b292: 9b b2        adda (0x00B2)
b294: 39           rts
b295: 59           rolb
b296: 6f 75        clr (X+0x75)
b298: 20 68        bra [0xB302]
b29a: 61           ?
b29b: 76 65 20     ror (0x6520)
b29e: 73 65 6c     com (0x656C)
b2a1: 65           ?
b2a2: 63 74        com (X+0x74)
b2a4: 65           ?
b2a5: 64 20        lsr (X+0x20)
b2a7: 23 31        bls [0xB2DA]
b2a9: 00           test
b2aa: 59           rolb
b2ab: 6f 75        clr (X+0x75)
b2ad: 20 68        bra [0xB317]
b2af: 61           ?
b2b0: 76 65 20     ror (0x6520)
b2b3: 73 65 6c     com (0x656C)
b2b6: 65           ?
b2b7: 63 74        com (X+0x74)
b2b9: 65           ?
b2ba: 64 20        lsr (X+0x20)
b2bc: 23 31        bls [0xB2EF]
b2be: 31           ins
b2bf: 00           test
b2c0: ce b2 c7     ldx 0xB2C7
b2c3: bd 8a 1a     jsr (0x8A1A)
b2c6: 39           rts
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

; All empty (0xFFs) in this gap

f780: 57
f781: 0b           sev
f782: 00           test
f783: 00           test
f784: 00           test
f785: 00           test
f786: 08           inx
f787: 00           test
f788: 00           test
f789: 00           test
f78a: 20 00        bra [0xF78C]
f78c: 00           test
f78d: 00           test
f78e: 80 00        suba 0x00
f790: 00           test
f791: 00           test
f792: 00           test
f793: 00           test
f794: 00           test
f795: 04           lsrd
f796: 00           test
f797: 00           test
f798: 00           test
f799: 10           sba
f79a: 00           test
f79b: 00           test
f79c: 00           test
f79d: 00           test
f79e: 00           test
f79f: 00           test
f7a0: 40           nega
f7a1: 12 20 09 80  brset (0x0020), 0x09, [0xF725]
f7a5: 24 02        bcc [0xF7A9]
f7a7: 00           test
f7a8: 40           nega
f7a9: 12 20 09 80  brset (0x0020), 0x09, [0xF72D]
f7ad: 24 04        bcc [0xF7B3]
f7af: 00           test
f7b0: 00           test
f7b1: 00           test
f7b2: 00           test
f7b3: 00           test
f7b4: 00           test
f7b5: 00           test
f7b6: 00           test
f7b7: 00           test
f7b8: 00           test
f7b9: 00           test
f7ba: 00           test
f7bb: 00           test
f7bc: 08           inx
f7bd: 00           test
f7be: 00           test
f7bf: 00           test
f7c0: 00           test
f7c1: ff ff ff     stx (0xFFFF)
f7c4: ff ff ff     stx (0xFFFF)
f7c7: ff ff ff     stx (0xFFFF)
f7ca: ff ff ff     stx (0xFFFF)
f7cd: ff ff ff     stx (0xFFFF)
f7d0: ff ff ff     stx (0xFFFF)
f7d3: ff ff ff     stx (0xFFFF)
f7d6: ff ff ff     stx (0xFFFF)
f7d9: ff ff ff     stx (0xFFFF)
f7dc: ff ff ff     stx (0xFFFF)
f7df: ff ff ff     stx (0xFFFF)
f7e2: ff ff ff     stx (0xFFFF)
f7e5: ff ff ff     stx (0xFFFF)
f7e8: ff ff ff     stx (0xFFFF)
f7eb: ff ff ff     stx (0xFFFF)
f7ee: ff ff ff     stx (0xFFFF)
f7f1: ff ff ff     stx (0xFFFF)
f7f4: ff ff ff     stx (0xFFFF)
f7f7: ff ff ff     stx (0xFFFF)
f7fa: ff ff ff     stx (0xFFFF)
f7fd: ff ff ff     stx (0xFFFF)

; Reset

f800: 0f           sei
f801: 86 03        ldaa 0x03
f803: b7 10 24     staa (TMSK2)     ; disable irqs, set prescaler to 16
f806: 86 80        ldaa 0x80
f808: b7 10 22     staa (TMSK1)     ; enable OC1 (LCD?) irq
f80b: 86 fe        ldaa 0xFE
f80d: b7 10 35     staa (BPROT)     ; protect everything except $xE00-$xE1F
f810: 96 07        ldaa (0x0007)    ; ?????
f812: 81 db        cmpa 0xDB
f814: 26 06        bne $1
f816: 7f 10 35     clr (BPROT)      ; unprotect everything
f819: 7f 00 07     clr (0x0007)     ; ?????
$1:
f81c: 8e 01 ff     lds 0x01FF       ; init SP
f81f: 86 a5        ldaa 0xA5
f821: b7 10 5d     staa (CSCTL)     ; enable external IO:
                                    ; IO1EN, BUSSEL, active LOW
                                    ; IO2EN, LCRS, active LOW
                                    ; CSPROM, ROMSEL, 32K ROM mapping $8000-FFFF

f824: 86 01        ldaa 0x01
f826: b7 10 5f     staa (CSGSIZ)    ; general purpose chip select size, 32K
f829: 86 00        ldaa 0x00
f82b: b7 10 5e     staa (CSGADR)    ; RAMSEL = $0000-$7FFF (except internal regs)
f82e: 86 f0        ldaa 0xF0
f830: b7 10 5c     staa (CSSTRH)    ; 3 cycle clock stretching on BUSSEL and LCRS
f833: 7f 00 00     clr (0x0000)
f836: 86 30        ldaa 0x30        ; '0'
f838: b7 18 05     staa (0x1805)
f83b: b7 18 07     staa (0x1807)
f83e: 86 ff        ldaa 0xFF
f840: b7 18 06     staa (0x1806)
f843: 86 78        ldaa 0x78        ; 'x'
f845: b7 18 04     staa (0x1804)
f848: 86 34        ldaa 0x34        ; '4'
f84a: b7 18 05     staa (0x1805)
f84d: b7 18 07     staa (0x1807)

f850: c6 ff        ldab 0xFF
f852: bd f9 c5     jsr (0xF9C5)
f855: 20 13        bra $1           ; jump past data table

// Data loaded into (0x180D-0x181F)
f857: 09 4a 01 
f85a: 10 0c 18 0d 00 04 44 0e
f862: 63 05 68 0b 56 03 c1 ff

$1:
f86a: ce f8 57     ldx 0xF857
f86d: a6 00        ldaa (X+0x00)
f86f: 81 ff        cmpa 0xFF
f871: 27 06        beq [0xF879]
f873: b7 18 0d     staa (0x180D)
f876: 08           inx
f877: 20 f4        bra [0xF86D]

; Setup normal SCI, 8 data bits, 1 stop bit
; Interrupts disabled, Transmitter and Receiver enabled
; prescaler = /13, SCR=/2, rate = 9600 baud at 16Mhz clock

f879: 86 00        ldaa 0x00
f87b: b7 10 2c     staa (SCCR1)
f87e: 86 0c        ldaa 0x0C
f880: b7 10 2d     staa (SCCR2)
f883: 86 31        ldaa 0x31
f885: b7 10 2b     staa (BAUD)

; Initialize all RAM vectors to RTI: 
; Opcode 0x3b into vectors at 0x0100 through 0x0139

f888: ce 01 00     ldx 0x0100
f88b: 86 3b        ldaa 0x3B        ; RTI opcode
f88d: a7 00        staa (X+0x00)
f88f: 08           inx
f890: 08           inx
f891: 08           inx
f892: 8c 01 3c     cpx 0x013C
f895: 25 f6        bcs [0xF88D]

f897: c6 f0        ldab 0xF0
f899: f7 18 04     stab (0x1804)
f89c: 86 7e        ldaa 0x7E
f89e: 97 03        staa (0x0003)

; Ram test 0x0000-0x3ff

f8a0: ce 00 00     ldx 0x0000
f8a3: e6 00        ldab (X+0x00)
f8a5: 86 55        ldaa 0x55
f8a7: a7 00        staa (X+0x00)
f8a9: a1 00        cmpa (X+0x00)
f8ab: 26 19        bne [0xF8C6]
f8ad: 49           rola
f8ae: a7 00        staa (X+0x00)
f8b0: a1 00        cmpa (X+0x00)
f8b2: 26 12        bne [0xF8C6]
f8b4: e7 00        stab (X+0x00)
f8b6: 08           inx
f8b7: 8c 04 00     cpx 0x0400
f8ba: 26 03        bne [0xF8BF]

f8bc: ce 20 00     ldx 0x2000
f8bf: 8c 80 00     cpx 0x8000
f8c2: 26 df        bne [0xF8A3]
f8c4: 20 04        bra [0xF8CA]

f8c6: 86 01        ldaa 0x01        ; Mark Failed RAM test?
f8c8: 97 00        staa (0x0000)

f8ca: c6 01        ldab 0x01
f8cc: bd f9 95     jsr (0xF995)
f8cf: b6 10 35     ldaa (BPROT)
f8d2: 26 0f        bne [0xF8E3]
f8d4: b6 30 00     ldaa (0x3000)
f8d7: 81 7e        cmpa 0x7E
f8d9: 26 08        bne [0xF8E3]
f8db: c6 0e        ldab 0x0E
f8dd: bd f9 95     jsr (0xF995)
f8e0: 7e 30 00     jmp (0x3000)
f8e3: ce f0 00     ldx 0xF000
f8e6: 01           nop
f8e7: 01           nop
f8e8: 09           dex
f8e9: 27 0b        beq [0xF8F6]
f8eb: bd f9 45     jsr (0xF945)
f8ee: 24 f6        bcc [0xF8E6]
f8f0: 81 1b        cmpa 0x1B
f8f2: 27 29        beq [0xF91D]
f8f4: 20 f0        bra [0xF8E6]
f8f6: b6 80 00     ldaa (0x8000)
f8f9: 81 7e        cmpa 0x7E
f8fb: 26 0b        bne [0xF908]
f8fd: c6 0a        ldab 0x0A
f8ff: bd f9 95     jsr (0xF995)
f902: bd 80 00     jsr (0x8000)
f905: 0f           sei
f906: 20 ee        bra [0xF8F6]
f908: c6 10        ldab 0x10
f90a: bd f9 95     jsr (0xF995)

f90d: bd f9 d8     jsr (0xF9D8)

'MINI-MO.'

f910: 4d 49 4e 49 2d 4d 4f ce

f918: c6 10        ldab 0x10
f91a: bd f9 95     jsr (0xF995)
f91d: 7f 00 05     clr (0x0005)
f920: 7f 00 04     clr (0x0004)
f923: 7f 00 02     clr (0x0002)
f926: 7f 00 06     clr (0x0006)

f929: bd f9 d8     jsr (0xF9D8)
'\r\n:'

f92c: 0d           sec
f92d: 0a           clv
f92e: be 

f92f: 36           psha
f930L 44           lsra
f931: 44           lsra
f932: 44           lsra
f933: 44           lsra
f934: bd f9 38     jsr (0xF938)
f937: 32           pula
f938: 84 0f        anda 0x0F
f93a: 8a 30        oraa 0x30
f93c: 81 3a        cmpa 0x3A
f93e: 25 02        bcs [0xF942]
f940: 8b 07        adda 0x07
f942: 7e f9 6f     jmp (0xF96F)
f945: b6 10 2e     ldaa (SCSR)
f948: 85 20        bita 0x20
f94a: 26 09        bne [0xF955]
f94c: 0c           clc
f94d: 39           rts

; wait for a serial character
f94e: b6 10 2e     ldaa (SCSR)      ; read serial status
f951: 85 20        bita 0x20
f953: 27 f9        beq [0xF94E]     ; if RDRF=0, loop

; read serial data, (assumes it's ready)
f955: b6 10 2e     ldaa (SCSR)      ; read serial status
f958: 85 02        bita 0x02
f95a: 26 09        bne [0xF965]     ; if FE=1, clear it
f95c: 85 08        bita 0x08
f95e: 26 05        bne [0xF965]     ; if OR=1, clear it
f960: b6 10 2f     ldaa (SCDR)      ; otherwise, good data
f963: 0d           sec
f964: 39           rts

f965: b6 10 2f     ldaa (SCDR)      ; clear any error
f968: 86 2f        ldaa 0x2F        ; '/'   
f96a: bd f9 6f     jsr (0xF96F)
f96d: 20 df        bra [0xF94E]     ; go to wait for a character

f96f: 81 0d        cmpa 0x0D        ; CR?
f971: 27 02        beq [0xF975]     ; if so echo CR+LF
f973: 20 07        bra [0xF97C]     ; else just echo it
f975: 86 0d        ldaa 0x0D
f977: bd f9 7c     jsr (0xF97C)
f97a: 86 0a        ldaa 0x0A

; send a char to SCI
f97c: f6 10 2e     ldab (SCSR)      ; wait for ready to send
f97f: c5 40        bitb 0x40
f981: 27 f9        beq [0xF97C]
f983: b7 10 2f     staa (SCDR)      ; send it
f986: 39           rts

f987: bd f9 4e     jsr (0xF94E)
f98a: 81 7a        cmpa 0x7A
f98c: 22 06        bhi [0xF994]
f98e: 81 61        cmpa 0x61
f990: 25 02        bcs [0xF994]
f992: 82 20        sbca 0x20
f994: 39           rts

f995: 36           psha
f996: c1 11        cmpb 0x11
f998: 25 02        bcs [0xF99C]
f99a: c6 10        ldab 0x10
f99c: ce f9 b4     ldx 0xF9B4
f99f: 3a           abx
f9a0: a6 00        ldaa (X+0x00)
f9a2: b7 18 06     staa (0x1806)
f9a5: b6 18 04     ldaa (0x1804)
f9a8: 8a 20        oraa 0x20
f9aa: b7 18 04     staa (0x1804)
f9ad: 84 df        anda 0xDF
f9af: b7 18 04     staa (0x1804)
f9b2: 32           pula
f9b3: 39           rts

f9b4: c0 f9        subb 0xF9
f9b6: a4 b0        anda (X+0xB0)
f9b8: 99 92        adca (0x0092)
f9ba: 82 f8        sbca 0xF8
f9bc: 80 90        suba 0x90
f9be: 88 83        eora 0x83
f9c0: c6 a1        ldab 0xA1
f9c2: 86 8e        ldaa 0x8E
f9c4: ff           ???

f9c5: 36           psha
f9c6: f7 18 06     stab (SCCR2)
f9c9: b6 18 04     ldaa (0x1804)
f9cc: 84 ef        anda 0xEF
f9ce: b7 18 04     staa (0x1804)
f9d1: 8a 10        oraa 0x10
f9d3: b7 18 04     staa (0x1804)
f9d6: 32           pula
f9d7: 39           rts

; Send rom message via SCI

f9d8: 18 38        puly
f9da: 18 a6 00     ldaa (Y+0x00)
f9dd: 27 09        beq [0xF9E8]     ; if zero terminated, return
f9df: 2b 0c        bmi [0xF9ED]     ; if high bit set..do last char and return
f9e1: bd f9 7c     jsr (0xF97C)     ; else send char
f9e4: 18 08        iny
f9e6: 20 f2        bra [0xF9DA]     ; and loop for next one

f9e8: 18 08        iny              ; setup return address and return
f9ea: 18 3c        pshy
f9ec: 39           rts

f9ed: 84 7f        anda 0x7F        ; remove top bit
f9ef: bd f9 7c     jsr (0xF97C)     ; send char
f9f2: 20 f4        bra [0xF9E8]     ; and we're done

f9f4: 39           rts
f9f5: 39           rts

f9f6: 3b           rti

ffa0: 7e f9 f5     jmp (0xF9F5)
ffa3: 7e f9 f5     jmp (0xF9F5)
ffa6: 7e f9 f5     jmp (0xF9F5)
ffa9: 7e f9 2f     jmp (0xF92F)
ffac: 7e f9 d8     jmp (0xF9D8)
ffaf: 7e f9 45     jmp (0xF945)
ffb2: 7e f9 6f     jmp (0xF96F)
ffb5: 7e f9 08     jmp (0xF908)
ffb8: 7e f9 95     jmp (0xF995)
ffbb: 7e f9 c5     jmp (0xF9C5)
ffbe: ff ff

; Vectors

ffc0 :f9 f6     ; Stub RTI
ffc2: f9 f6     ; Stub RTI
ffc4: f9 f6     ; Stub RTI
ffc6: f9 f6     ; Stub RTI
ffc8: f9 f6     ; Stub RTI
ffca: f9 f6     ; Stub RTI
ffcc: f9 f6     ; Stub RTI
ffce: f9 f6     ; Stub RTI
ffd0: f9 f6     ; Stub RTI
ffd2: f9 f6     ; Stub RTI
ffd4: f9 f6     ; Stub RTI

ffd6: 01 00     ; SCI
ffd8: 01 00     ; SPI
ffda: 01 06     ; PA accum. input edge
ffdc: 01 09     ; PA Overflow

ffde: f9 f6     ; Stub RTI

ffe0: 01 0c     ; TI4O5
ffe2: 01 0f     ; TOC4
ffe4: 01 12     ; TOC3
ffe6: 01 15     ; TOC2
ffe8: 01 18     ; TOC1
ffea: 01 1b     ; TIC3
ffec: 01 1e     ; TIC2
ffee: 01 21     ; TIC1
fff0: 01 24     ; RTI
fff2: 01 27     ; ~IRQ
fff4: 01 2a     ; XIRQ
fff6: 01 2d     ; SWI
fff8: 01 30     ; ILLEGAL OPCODE
fffa: 01 33     ; COP Failure
fffc: 01 36     ; COP Clock Monitor Fail

fffe: f8 00     ; Reset
