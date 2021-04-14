.globl _start



.data
var1: .word 15
var2: .word 19
new: .asciz "\n"

.text

_start:
	la a0, var1
	li a7, 1
	ecall # print var1
	la a0, new
	li a7, 4
	ecall # print newline
	li a7, 1
	la a0, var2
	ecall # print var2
	la a0, new
	li a7, 4
	ecall # print newline
	lw a1, var1 # load var1 value
	la a2, var1 # load var1 addr
	addi a1, a1, 1 
	sw a1, 0(a2) # store new value to var1
	lw a1, var2
	la a2, var2
	addi a3, zero, 4 
	mul a1, a1, a3 # multiplication
	sw a1, 0(a2) # store new value to var2
	lw a0, var1
	li a7, 1
	ecall # print var1
	la a0, new
	li a7, 4
	ecall # print newline
	li a7, 1
	lw a0, var2
	ecall # print var2
	la a0, new
	li a7, 4
	ecall # print newline
	lw a0, var1
	la a1, var1
	lw a2, var2
	la a3, var2
	sw a2, 0(a1) # store var2 value to var1 addr
	sw a0, 0(a3) # store var1 value to var2 addr
	lw a0, var1
	li a7, 1
	ecall # print var1
	la a0, new
	li a7, 4
	ecall # print newline
	li a7, 1
	lw a0, var2
	ecall # print var2
	la a0, new
	li a7, 4
	ecall # print newline
	

	
	
