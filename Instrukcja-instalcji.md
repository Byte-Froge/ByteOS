# Instrukacja instalacji NovaOS
## Windows
1. Zainstauj pakiety takie jak
   QEMU - Terminalowy emulator systemu
   NASM - Zmienianie plików .asm na .bin *(Zmiana na kod binarny)*
2. Pobierz pliki `bootloader.asm` oraz `kernel.asm` z tego repozytorium
3. Zmień z C:\ na C:\Users\user\AppData\bin\nasm używając komendy `cd C:\Users\user\AppData\bin\nasm`
4. Wpisz komendę `nasm kernel.asm -f bin -o kernel.bin` oraz `nasm bootloader.asm -f bin -o bootloader.bin`
aby zamienić pliki .asm na kod .bin
5. Połącz pliki w jeden używając komendy `copy /b bootloader.bin+kernel.bin os.img`
6. Włącz system w emulatorze QEMU `"C:\Program Files\qemu\qemu-systeem-x86_64.exe" -drive format=raw,file=os.img`


