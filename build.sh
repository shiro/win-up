#/bin/sh

rm -r output 2>/dev/null
mkdir -p output 2>/dev/null

# only x64 as of a dependency limitation
compile/Ahk2Exe.exe /in win-up.ahk /out output/win-up.exe /bin "compile/Unicode 64-bit.bin"

cp lib/*.dll output

cd output
tar -cvzf win-up.tar.gz win-up.exe *.dll
