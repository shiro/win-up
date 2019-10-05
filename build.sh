#/bin/sh

mkdir -p output &2>/dev/null

# only x64 as of a dependency limitation
compile/Ahk2Exe.exe /in winUp.ahk /out output/winUp.exe /bin "compile/Unicode 64-bit.bin"

cp *.dll output
