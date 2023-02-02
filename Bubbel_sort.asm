.data
Array:
	.word 
msg:
	.asciiz "Please enter the n : "
msg_1:
	.asciiz "\t"

.text
	li	$v0 , 4			#print String 
	la	$a0 , msg
	syscall
	li 	$v0 , 5			#Read Integer n
	syscall
	move 	$t0 , $v0
	addi 	$t0 , $t0 , 1		# n+1
	li	$t1 , 1			# i = 1
	la	$t2 , Array		# Load base Adress of Array
Loop:	
	beq	$t0 , $t1 , Sort	# if ( n == i ) than Print
	li	$v0 , 5			# Read Integer
	syscall
	move	$t3 , $v0	
	sw	$t3 , 0($t2)		#save in Memory
	addi	$t2 , $t2 , 4		# Adress of Array +=4
	addi 	$t1 , $t1 , 1		# i++
	j	Loop
Sort:
	add $a0 , $zero , $t0
	subi	$sp , $sp , 16
	sw	$t0 , 0 ($sp)
	sw	$t1 , 4 ($sp)
	sw	$t2 , 8 ($sp)
	sw	$a0 , 12 ($sp)
	jal	Bubble_sort	
	lw	$t0 , 0 ($sp)
	lw	$t1 , 4 ($sp)
	lw	$t2 , 8 ($sp)
	lw	$a0 , 12 ($sp)
	addi	$sp , $sp , 16
Print:	
	li	$t1 , 1			#i = 1
	la	$t2 , Array		# Load base Adress of Array
LoopS:	
	beq	$t0 , $t1 , Exit	# if ( n == i ) than Exit
	li	$v0 , 1			# Print Integer
	lw	$t3 , 0($t2)		# Load word in array
	move	$a0 , $t3		# Print Integer
	syscall
	li	$v0 , 4			# print
	la	$a0 , msg_1
	syscall
	addi	$t2 , $t2 , 4		# Adress of Array +=4
	addi	$t1 , $t1 , 1		# i++
	j	LoopS
Exit:	li	$v0 , 10		#Normal Exite
	syscall 
	
####################################### Bubble sort ##############################
Bubble_sort:

	subi	$sp , $sp , 48
	sw	$s0 , 20($sp)
	sw	$s1 , 24($sp)
	sw	$s2 , 28($sp)
	sw	$s3 , 32($sp)
	sw	$s4 , 36($sp)
	sw	$s5 , 40($sp)
	sw	$s6 , 44($sp)
	la	$s3 , Array		# base adress
	li	$s1 , 0			# temp = 0
	li 	$s2 , 1		       # flag = 1
	li	$s0 , 0			# i = 0
	subi	$a0 , $a0 , 1
while:
	beq	$s2 , $zero , Exit_1	# if (flag == 0) than Exit_1
	move	$s2 , $zero		# flag = 0
	addi	$s0 , $zero ,1		# i = 0
	la	$s3 , Array		# base adress
for:
	beq	$s0 , $a0 , while	#if ( i == n) than while
	lw	$s4 ,0($s3)		# array[i]
	lw	$s5 , 4($s3)		# array[i+1]
	slt	$s6 , $s5 , $s4 	# if (array[i+1] < array[i]
	beq	$s6 , $zero , Exit_2	# if ($s6 == 0) than Exite
	move	$s1 , $s4		# temp =  array[i]
	sw	$s5 , 0($s3)		# array[i] = array[i+1]
	sw	$s1 , 4($s3)		# array[i+1] = temp
	li	$s2 , 1			# flag = 1
	addi	$s0 , $s0 , 1		# i++
	addi	$s3 , $s3 , 4		# adress array +=4
	j	for	
	
Exit_2:
	addi	$s0 , $s0 , 1		# i++
	addi	$s3 , $s3 , 4		# adress array +=4
	j	for
Exit_1:
	lw	$s0 , 20($sp)
	lw	$s1 , 24($sp)
	lw	$s2 , 28($sp)
	lw	$s3 , 32($sp)
	lw	$s4 , 36($sp)
	lw	$s5 , 40($sp)
	lw	$s6 , 44($sp)
	addi 	$sp , $sp , 48
	jr	$ra	





























