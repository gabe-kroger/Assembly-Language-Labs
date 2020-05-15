INCLUDE irvine32.inc

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

;KEY = 239
BUFMAX = 128
.data

string1 byte "Please enter a string: ",0
string2 byte "Your string is: ", 0
string3 byte "The cypher text is: ", 0
string4 byte "The decoded string is: ", 0
buffer BYTE BUFMAX+1 DUP(0)
bufSize DWORD BUFMAX
Keys byte '!', '@', '#', '$', '%', 0

.code
main PROC

Call intro						;prompts user to enter string and stores string into variable
mov edx, offset string2
call display					;displays original string
mov edx, offset string3
call encrypt					;encoding string
call display					;displays encoded string
mov edx, offset string4
call encrypt					;decoding string
call display					;displays decoded string


	INVOKE ExitProcess,0
main ENDP

Intro PROC
mov ecx,bufSize					;loop counter
mov esi,0						;assign esi to position 0
mov edx, offset string1			;prompt user to enter a string
call writestring
mov edx, offset buffer
call readstring					;store string in buffer
mov bufsize, eax			    ;move length of string into variable
call crlf
ret
Intro ENDP


Display PROC					;display procedure
call writestring
mov edx, offset buffer
call writestring 
call crlf
ret
Display ENDP


Encrypt PROC
mov ecx,bufSize					; loop counter 
mov esi,0						; set esi to position 0
mov edi,0						; ""

L1:

mov al, keys[edi]
xor buffer[esi], al				;encrypt array at position esi
inc esi							; next element in array
inc edi						    ;""
cmp edi, lengthof keys
jne next						; jump if edi != lengthof
mov edi, 0						; reset edi

next:
loop L1

ret
Encrypt ENDP

END main








