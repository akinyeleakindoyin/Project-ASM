; Reversing a String (RevStr.asm)
; This program reverses a string.

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
aName byte "Abraham Lincoln",0
nameSize = ($ - aName) - 1

.code
main proc

; Push the name on the stack.

mov	 ecx,nameSize
	mov	 esi,0

L1:	movzx eax,aName[esi]	; get character
	push eax				; push on stack
	inc	 esi
	loop L1

; Pop the name from the stack in reverse
; and store it in the aName array.

mov	 ecx,nameSize
	mov	 esi,0

L2:	pop  eax				; get character
	mov	 aName[esi],al		; store in string
	inc	 esi
	loop L2

	Invoke ExitProcess,0
main endp
end main


==========================================================================================

; Reversing a String (RevStr.asm)
; This program reverses a string.
INCLUDE irvine32.inc

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
aName byte "Abraham Lincoln",0
nameSize = ($ - aName) - 1
aName2 byte nameSize dup('X')

.code
main proc

	call prtStr
	call pushStr
	call popStr
	call prtStr


	comment !
; Pop the name from the stack in reverse
; and store it in the aName array.

mov	 ecx,nameSize
	mov	 esi,0

L2:	pop  eax				; get character
	mov	 aName[esi],al		; store in string
	inc	 esi
	loop L2
	!



	Invoke ExitProcess,0
main endp

pushStr proc
	; Push the name on the stack.

	; using index array access

mov	 ecx,nameSize
	pop edi
	mov	 esi,0

L1:	movzx eax,aName[esi]	; get character
	push eax				; push on stack
	inc	 esi
	loop L1
	push edi

	ret
pushStr endp

popStr proc
	pop edi
	; using indirect array access
	mov ecx, namesize
	mov esi, offset aName2
	 
L3:	pop  eax				; get character
	mov	 [esi],al		; store in string
	inc	 esi
	loop L3

	push edi

	ret
popStr endp

prtStr proc
	mov edx, offset aName
	call writeString
	call crlf

	ret
prtStr endp
end main


===========================================================
.data
pmt byte "Enter a value ",0

num dword ?
ans dword ?

.code
main proc
	
	call getNum
	call prt_fig


main endp
prt_fig proc
		mov ecx, num

	LP7:
		push ecx
		mov eax, 1h
	IP7:
		call writedec
		inc eax
		loop IP7
		call crlf
		pop ecx
		loop LP7

	ret
prt_fig endp

; for the 
prt_fig2 proc
		mov ecx, num
		mov edx, 1

	LP7:
		push ecx
		mov ecx, edx
		mov eax, 1h
	IP7:
		call writedec
		inc eax
		loop IP7
		call crlf
		pop ecx
		inc edx
		loop LP7

	ret
prt_fig2 endp

getNum proc
	mov edx, offset pmt
	call writestring

	call readInt

	mov num, eax

	ret
getNum endp