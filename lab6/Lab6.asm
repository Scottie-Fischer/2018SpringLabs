#Scott Fischer
#sifische
#lab6

#Subroutine: 	PrintFloat
#Purpose:		Prints the sign, mantissa, and exponent of a SP FP value
#input:		$a0 = Single Precision float
#Side Effects:	None
.text
PrintFloat:
	#li $a0,0x44801000
	li $a0,0xBEDCFFFF
	move $t7,$a0
	#-----Saving Registers-----#
	subi $sp,$sp,48
	sw $a0,0($sp)
	sw $a1,4($sp)
	sw $a2,8($sp)
	sw $a3,12($sp)
	sw $s0,16($sp)
	sw $s1,20($sp)
	sw $s2,24($sp)
	sw $s3,28($sp)
	sw $s4,32($sp)
	sw $s5,36($sp)
	sw $s6,40($sp)
	sw $s7,44($sp)
	
	#-----Printing Sign-----#
	li $v0,4
	la $a0,Sign_Msg
	syscall
	
	andi $t1,$t7,0x80000000
	srl $t1,$t1,31
	li $v0,1
	la $a0,($t1)
	syscall
	
	li $v0,4
	la $a0,PNL
	syscall
	
	li $v0,4
	la $a0,Exponent_Msg
	syscall
	
	andi $t2,$t7,0x7F800000
	srl $t2,$t2,23
	li $t6,128
	#-----Loop Start-----#
	PrintExp:
		div $t4,$t2,$t6
		mfhi $t2
		li $v0,1
		la $a0,($t4)
		syscall	
		div $t6,$t6,2
		bnez $t6,PrintExp
	#-----Loop End-----#
	li $v0,4
	la $a0,PNL
	syscall
	
	li $v0,4
	la $a0,Mantissa_Msg
	syscall
	
	andi $t3,$t7,0x007FFFFF
	li $t6,4194304
	#-----Loop Start-----#
	PrintMant:
		div $t4,$t3,$t6
		mfhi $t3
		li $v0,1
		la $a0,($t4)
		syscall	
		div $t6,$t6,2
		bnez $t6,PrintMant
	#-----Loop End-----#
	#-----Restoring Registers-----#
	lw $a0,0($sp)
	lw $a1,4($sp)
	lw $a2,8($sp)
	lw $a3,12($sp)
	lw $s0,16($sp)
	lw $s1,20($sp)
	lw $s2,24($sp)
	lw $s3,28($sp)
	lw $s4,32($sp)
	lw $s5,36($sp)
	lw $s6,40($sp)
	lw $s7,44($sp)
	addi $sp,$sp,48
	#-----Closing-----#
	li $v0,10
	syscall

.data
Output_Msg:		.asciiz "Output:\n"
Sign_Msg:		.asciiz "Sign: "
Exponent_Msg:	.asciiz "Exponent: "
Mantissa_Msg:	.asciiz "Mantissa: "
PNL:			.asciiz "\n"