as6811.exe -o -p -s -l cyberstar.asm
aslink.exe -n -m -u -s cyberstar.rel
srec2bin -q -o 8000 -a 8000 -f ff cyberstar.s19 cyberstar.bin
fc Cyberamic_1.6_R12_27C256.BIN cyberstar.bin


