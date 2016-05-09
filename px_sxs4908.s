	.global main
	.func main

main:
	MOV R0, #0
	B _createarray

_createarray:
	CMP R0, #10
	BEQ arraycomplete
	PUSH {R0}
	BL _scanf
	MOV R4, R0
	POP {R0}
	LDR R1, =array_a
	LSL R2, R0, #2
	ADD R2, R1, R2
	STR R4, [R2]
	ADD R0, R0, #1
	B _createarray

arraycomplete:
	MOV R0, #0
	B _readloop

_readloop:
	CMP R0, #10
	BEQ readdone
	LDR R1, =array_a
	LSL R2, R0, #2
	ADD R2, R1, R2
	LDR R1, [R2]
	PUSH {R0}
	PUSH {R1}
	PUSH {R2}
	MOV R2, R1
	MOV R1, R0
	BL _printarray
	POP {R2}
	POP {R1}
	POP {R0}
	ADD R0, R0, #1
	B _readloop

readdone:
	#BL _printarray
	MOV R0, #0
	LDR R1, =array_a
	LSL R2, R0, #2
	ADD R2, R1, R2
	LDR R5, [R2]
	MOV R7, R5
	MOV R2, #0
	MOV R1, #0
	MOV R0, #0
	B _minmax

_minmax:
	CMP R0, #10
	BEQ foundminmax
	LDR R1, =array_a
	LSL R2, R0, #2
	ADD R2, R1, R2
	LDR R6, [R2]
	CMP R6, R5
	MOVLT R5, R6
	CMP R6, R7
	MOVGT R7, R6
	ADD R0, R0, #1
	B _minmax

foundminmax:
	MOV R1, R5
	BL _printminimum
	MOV R1, R7
	BL _printmaximum
	MOV R0, #0
	MOV R8, #0
	B _sum

_sum:
	CMP R0, #10
	BEQ sumdone
	LDR R1, =array_a
	LSL R2, R0, #2
	ADD R2, R1, R2
	LDR R1, [R2]
	ADD R8, R8, R1
	ADD R0, R0, #1
	B _sum
	
sumdone:
	MOV R1, R8
	BL _printsum
	B _exit

_printsum:
	PUSH {LR}
	LDR R0, =sum_str
	BL printf
	POP {PC}

_printmaximum:
	PUSH {LR}
	LDR R0, =maximum_str
	BL printf
	POP {PC}

_printminimum:
	PUSH {LR}
	LDR R0, =minimum_str
	BL printf
	POP {PC}

_printarray:
	PUSH {LR}              
    	LDR R0, =array_str    
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
format_str:	.asciz	"%d"
array_str:	.asciz	"array_a[%d] = %d\n"
minimum_str:	.asciz	"minimum = %d\n"
maximum_str:	.asciz	"maximum = %d\n"
sum_str:	.asciz	"sum = %d\n"
exit_str:	.asciz	""

