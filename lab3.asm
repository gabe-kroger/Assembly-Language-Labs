INCLUDE irvine32.inc

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
myArray1 byte 100 dup(?)			;initial array
myArray2 byte 100 dup(?)			;permutation array
arraySize dword ?
prompt byte "Please enter the size of an array: ", 0
prompt1 byte "Please enter an array of numbers: ", 0
prompt2 byte "Please enter permutation array: ", 0dh, 0ah, 0
prompt3 byte "Your array after permuation is: ", 0
space byte " ",0


.code
main PROC
	mov edx, offset prompt			;prompts user to enter array size
	call writestring
	call readdec
	mov arraySize, eax
	mov edx, offset prompt1			;prompts user to fill array
	call writestring

	mov esi, 0
	mov edi, 0
	mov ecx, arraySize				;sets loop counter
	mov eax, offset myarray1		;moves offset of index array into eax


	
Store:
	call readdec						;stores number into eax
	mov myarray1[edi], al				;moves number from al to array
	inc edi								
LOOP Store								;loops through array

	mov edx, offset prompt2				;move second prompt into edx
	call writestring					;prompt user to enter permutation array
	mov ecx, arraySize
	mov eax, offset myarray2
	mov edi, 0
Store2:
	call readdec
	mov myarray2[edi], al
	inc edi
LOOP Store2
	
	mov ecx, arraySize
	mov eax, offset myarray1
	mov edx, offset prompt3			;displays permutated array
	call writestring

Display:
	movzx edi, myarray2[esi]		;moves permutation array into edi
	mov al, myarray1[edi]			;moves array at permutation position (edi) into al
	movzx eax, al					;moves array value to eax
	call writedec					;displays array value from eax
	mov edx, offset space			;creates space between numbers
	call writestring
	inc esi							;traverses to next position in array
Loop Display


	INVOKE ExitProcess,0
main ENDP
;insert additional procedures here
END main