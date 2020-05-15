INCLUDE irvine32.inc

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
;The welcome section
stringOne BYTE "Welcome! This program subtracts three integer numbers. ",0Dh, 0Ah, 0
stringTwo BYTE "Please input three integers x, y, and z: ", 0Dh, 0Ah, 0
stringThree BYTE "The result of (x-y-z) is: ", 0
stringEndline BYTE "     Please press enter to clear the console. ", 0Dh, 0Ah, 0

.code
main PROC
infiniteLoop:

mov edx, OFFSET stringOne
CALL WriteString
mov edx, OFFSET stringTwo
CALL WriteString

CALL ReadDec
mov ebx, eax
CALL ReadDec 
mov ecx, eax
CALL ReadDec 
mov edx, eax
sub ebx, ecx
sub ebx, edx
mov eax, ebx
mov edx, OFFSET stringThree
CALL WriteString
CALL WriteDec

mov edx, OFFSET stringEndline
CALL WriteString
CALL ReadDec

CALL ClrScr
JMP infiniteLoop



	INVOKE ExitProcess,0

main ENDP
END main

