as6811.exe -o -p -s -l cyberstar.asm
aslink.exe -n -m -u -s cyberstar.rel
srec2bin -q -o 8000 -a 8000 -f ff cyberstar.s19 cyberstar.bin

