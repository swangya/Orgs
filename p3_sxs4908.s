	.global main
	.func main

main:
	BL _scanf
	MOV R7, R0
	MOV R0, #0
	B _generate

_generate:
	CMP R0, #20
	BEQ gencomp
	LDR R1, =array_a
	LSL R2, R0, #2
	ADD R2, R1, R2
	ADD R8, R7, R0
	STR R8, [R2]
	ADD R2, R2, #4
	ADD R8, R8, #1
	NEG R8, R8
	STR R8, [R2]
	ADD R0, R0, #2
	B _generate

gencomp:
	MOV R0, #0
	B _copyarray

_copyarray:
	CMP R0, #20
	BEQ copycomplete
	LDR R1, =array_a
	LDR R2, =array_b		
	LSL R3, R0, #2		
	ADD R4, R1, R3		
	ADD R5, R2, R3		
	LDR R6, [R4]		
	STR R6, [R5]
	ADD R0, R0, #1
	B _copyarray	

copycomplete:
	MOV R0, #0
	B _sort_ascending

_sort_ascending:
	CMP R0, #19
	BEQ sortDone
	MOV R1, #0
	SUB R3,R0, #19
	NEG R3, R3
	B _Loop
	
_Loop:
	CMP R1, R3
	ADDEQ R0, R0, #1
	BEQ _sort_ascending
	LDR R4, =array_b
	LSL R5, R1, #2
	ADD R5, R4, R5
	LDR R6, [R5]
	ADD R7, R5, #4
	LDR R8, [R7]
	CMP R8, R6
	STRLT R6, [R7]
	STRLT R8, [R5]
	ADDLT R1, R1, #1
	BLT _Loop
	ADD R1, R1, #1
	B _Loop

sortDone:
	MOV R0, #0
	B _readloop

_readloop:
	CMP R0, #20
	BEQ readdone
	LDR R1, =array_a
	LDR R2, =array_b
	LSL R3, R0, #2
	ADD R4, R1, R3
	ADD R5, R2, R3
	LDR R1, [R4]
	LDR R2, [R5]
	PUSH {R0}
	PUSH {R1}
	PUSH {R2}
	PUSH {R3}
	MOV R3, R2
	MOV R2, R1
	MOV R1, R0
	BL _printf
	POP {R3}
	POP {R2}
	POP {R1}
	POP {R0}
	ADD R0, R0, #1
	B _readloop

readdone:
	B _exit

_exit:
	MOV R7, #4
    	MOV R0, #1              
    	MOV R2, #21           
    	LDR R1, =exit_str       
    	SWI 0    
    	MOV R7, #1
    	SWI 0

_printf:
    	PUSH {LR}              
    	LDR R0, =printf_str    
    	BL printf               
    	POP {PC}               

_scanf:
	PUSH {LR}
	SUB SP, SP, #4
	LDR R0, =format_str
	MOV R1, SP
	BL scanf
	LDR R0, [SP]
	ADD SP, SP, #4
	POP {PC}

.data

.balign 4
array_a:	.skip	400
array_b:	.skip	400
format_str:	.asciz	"%d"
printf_str:	.asciz	"array_a[%d] = %d, array_b = %d \n"
exit_str:	.asciz	""

