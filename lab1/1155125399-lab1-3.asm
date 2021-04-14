.globl _start

.data 
array1 : .word -1 22 8 35 5 4 11 2 1 78

.text

_start: 
	la t0, array1 # t0 -> array[0]
	li a0, 0 # lo = 0
	li a1, 9 # hi = 9
	jal x1, quicksort
	j end
	
	quicksort:
	addi sp, sp -4
	sw x1, 0(sp)
	bge a0, a1, endif # if check
	jal x1, partition
	addi sp, sp, -16 # make stack room
	sw a0, 12(sp)# save ho, hi to stack
	sw a1, 8(sp)
	sw a2, 4(sp) #store to stack
	sw x1, 0(sp)
	addi a3, a2, -1 # a3 = p-1 = partition(A, lo, hi) - 1
	addi a1, a3, 0 # pass p-1 as hi
	jal x1, quicksort
	lw a0, 12(sp)# restore ho, hi to stack
	lw a1, 8(sp)
	lw a2, 4(sp) # restore to stack
	lw x1, 0(sp)
	addi sp, sp, 16
	addi sp, sp, -16 # make stack room
	sw a0, 12(sp)# save ho, hi to stack
	sw a1, 8(sp)
	sw a2, 4(sp) #store to stack
	sw x1, 0(sp)
	addi a3, a2, 1 # a3 = p+1 = partition(A, lo, hi) - 1
	addi a0, a3, 0 # pass p+1 as lo
	jal x1, quicksort
	lw a0, 12(sp)# restore ho, hi to stack
	lw a1, 8(sp)
	lw a2, 4(sp) # restore to stack
	lw x1, 0(sp)
	addi sp, sp, 16
	endif: 
	lw x1, 0(sp) # restore return addr back to start
	addi sp, sp 4
	jalr zero, 0(x1)
	

partition:
	addi t2, a0, -1 # i = lo-1
	addi t3, a0, 0 # j = 0
	slli t1, a1, 2 # shift 2 bit
	add t1, t1, t0 # t1 = pivot addr
	lw t1, 0(t1) # t1 = pivot
	addi t6, a1, -1 # hi - 1
	forloop:
		bgt t3, t6, end_loop # for check
		slli t4, t3 ,2 # j * 4
		add t4, t4, t0 # t4 = a[j] addr
		lw t5, 0(t4) # t5 = a[j]
		bgt t5, t1, end_if # if check
		addi t2, t2, 1 # i++
		addi sp, sp, -20
		sw x1, 16(sp) # save return addr
		sw a0, 12(sp)# save ho, hi to stack
		sw a1, 8(sp)
		sw t1, 4(sp) #store to stack
		sw t0, 0(sp)
		slli a0, t3, 2
		add a0, a0, t0 # a0 = a[j] addr
		slli a1, t2, 2
		add a1, a1, t0 # a1 = a[i] addr
		jal x1, swap
		lw x1, 16(sp) # restore return addr
		lw a0, 12(sp) # resore ho, hi to stack
		lw a1, 8(sp)
		lw t1, 4(sp) #restore from stack
		lw t0, 0(sp)
		addi sp, sp, 20
		end_if:
		addi t3, t3, 1 # j++
		j forloop
	end_loop:
	addi sp, sp, -20
	sw x1, 16(sp) # save return addr
	sw a0, 12(sp)# save ho, hi to stack
	sw a1, 8(sp)
	sw t1, 4(sp) #store to stack
	sw t0, 0(sp)
	addi t6, t2, 1 # temp t6 = i+1
	slli a0, t6, 2
	add a0, a0, t0 # a0 = a[i+1] addr
	slli a1, a1, 2
	add a1, a1, t0 # a1 = a[hi] addr
	jal x1, swap
	lw x1, 16(sp) # restore return addr
	lw a0, 12(sp) # resore ho, hi to stack
	lw a1, 8(sp)
	lw t1, 4(sp) #restore from stack
	lw t0, 0(sp)
	addi sp, sp, 20
	addi a2, t6, 0 # return value saved to a2
	jalr zero, 0(x1)
	
		
swap: 
lw t0, 0(a0) # t0 = a[j]
lw t1, 0(a1) # t1 = a[i]
sw t0, 0(a1)
sw t1, 0(a0)
jalr x0, 0(x1)

end: