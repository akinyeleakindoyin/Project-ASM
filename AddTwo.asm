; Reversing a String (RevStr.asm)
; This program reverses a string.
INCLUDE irvine32.inc

.386
; .model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
;           55#!655#!655#!6
;           A5 T5 T5 A# C! K6....
msg   byte "ATTACK AT DAWN",0
sz=($-msg)
msg2 byte "55#!6"
sz2=($-msg2)

charr byte "ABdcXYZjj#$!ABC",0
;insert #$!. in charr and veriy that UCToLC works correctly
nums  byte 1,2,3,4,5,77,112,99
odd1  byte "odd number",0
even1 byte "even number",0
specialprime byte "2 is prime number",0
notprime byte "NOT A prime number",0





.code
main proc

    call InterLeave
    call Trees
    call Trees2
    call LoopDemo	
    call UCToLC


	invoke ExitProcess,0
main endp

LoopDemo proc
; A loop to count up from 1 to 7

	mov eax, 1
	.while eax <= 7
		call writedec
		call crlf
		inc eax
	.endw
	ret

	call crlf 

; A loop to count down from 6 to 1

	mov eax, 6
	.while eax >= 1
		call writedec
		call crlf
		dec eax
	.endw
	ret


;A loop print all odd numbers from 1 to 20
	mov eax, 1
	.while eax <= 20
		call writedec
		call crlf
		add eax, 2
	.endw

;classify number

      mov esi,0
      mov ecx, lengthof nums
;      dec ecx
      .while (esi < ecx)
        mov AL, nums[esi]
        call writeDec
; put a space between number amd message
;put appropriate msg about primeness
 ;       and eax, 0FFFFFFFEh
        and eax, 01h
        jz  odd
        mov edx, offset odd1
        call writestring
        jmp dun
odd:    mov edx, offset even1
        call writestring
        .if(nums[esi] == 2 )
           mov edx, offset specialprime
           call writestring
         .else
           mov edx, offset notprime 
           call writestring
        .endif
dun:       
       inc esi
       call crlf
      .endw

	ret
LoopDemo endp

Trees proc
;outerloop
 
   mov esi,10
   mov ecx,0
   mov ebx,1
   mov AL,'*'
   mov edx,1
   .while  esi >= 1
      .while ecx < esi
	     call writechar
	     inc ecx
      .endw
      dec esi
      call crlf
      mov ecx,0
    .endw
  ret
Trees endp

Trees2 proc
;outerloop

   mov esi,10
   mov ecx,1
   mov ebx,1
   mov AL,'*'
   mov edx,1
   .while ebx <= esi 
      .while ecx <= edx
	     call writechar
	     inc ecx
      .endw
      call crlf
      inc edx
      inc ebx
      mov ecx,1

    .endw

  ret
Trees2 endp

UCToLC proc
  mov esi,0
  mov ecx, lengthof charr
  .while esi < ecx
;check for A to Z  
    .if(charr[esi] >= 65 && charr[esi] <= 90)
        or charr[esi], 32
        mov AL, charr[esi]
        call writechar
        inc esi
    .elseif(charr[esi] >= 97 && charr[esi] <= 122)
        mov AL, charr[esi]
        call writechar
        inc esi
    .else
        mov AL, charr[esi]
        call writechar
        inc esi
    .endif
  .endw
    call crlf
  ret
UCToLC  endp

Interleave proc
   mov esi, 0
  .while esi < sz-1
     mov edi, 0
     .while (edi < sz2 && esi < sz-1)
        mov AL,msg[esi]
        call writechar
        mov AL,msg2[edi]
        call writechar
        inc edi
        inc esi
        mov AL,' '
        call writechar
    .endw
     call crlf
  .endw
     ret
Interleave  endp

end main