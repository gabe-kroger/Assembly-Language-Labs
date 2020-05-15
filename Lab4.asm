INCLUDE irvine32.inc

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
string0 byte "Please enter a string: ",0 
string1 byte "Invalid ",0dh, 0ah, 0
string2 byte "Valid ", 0dh, 0ah, 0
string3 byte "The overall result of the input is valid ", 0dh, 0ah, 0
string4 byte "The overall result of the input is invalid ", 0dh, 0ah, 0
myarray BYTE 10 DUP(0)
arraysize DWORD 10
Keys byte '0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F', 0
keys2 byte 'h', 0
mysize dword 0

.code
main PROC
CALL StateA

mov ecx,lengthof keys-1			
mov esi,0						
mov edi,0	
sub eax,1	
mov mysize, eax

StateB:
cmp esi, mysize 							;check if the esi is pointing to the end of myarray
JE StateC									;jump to state C if at end of myarray
mov al, keys[edi]							
cmp myarray[esi], al						;compare element in array with key
JE next 									;jump if element is equal to element in key
inc edi										;move to next element in key
LOOP StateB									;loop
JMP result2									;if no elements are equal, hex number is invalid
								
next:
mov edi, 0
mov ecx, lengthof keys-1					;move to beginning of key array
inc esi										;move to next element in myarray
jmp StateB

StateC:
mov edi,0
mov al, keys2[0]							
cmp myarray[esi], al						;check if the last character is "h"
JNE result2									;if not "h", display error

result1:
mov edx, offset string3						;display, "this is valid"
call writestring
jmp complete

result2:
mov edx, offset string4						;display "error, this is invalid"
call writestring

complete:


	INVOKE ExitProcess,0
main ENDP

StateA PROC
mov ecx,arraysize					;loop counter
mov esi,0						;assign esi to position 0
mov edx, offset string0			;prompt user to enter a string
call writestring
mov edx, offset myarray
call readstring					;store string in myarray
mov arraysize, eax			    ;move length of string into variable
call crlf
ret
StateA ENDP


END main