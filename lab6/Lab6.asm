#Scott Fischer
#sifische
#lab6

#Subroutine: 	PrintFloat
#Purpose:		Prints the sign, mantissa, and exponent of a SP FP value
#input:		$a0 = Single Precision float
#Side Effects:	None
.text
main:
	li $a0,0x44800000
	li $a1,0x3F000000
	jal CompareFloats
	move $t1,$v0
	li $v0,1
	la $a0,($t1)
	syscall
	li $a0,0x44800000
	li $a1,0x44800000
	jal CompareFloats
	move $t1,$v0
	li $v0,1
	la $a0,($t1)
	syscall
	li $a0,0x3F000000
	li $a1,0x44800000
	jal CompareFloats
	move $t1,$v0
	li $v0,1
	la $a0,($t1)
	syscall
	
	li $v0,10
	syscall
#------------------------------------------------------------------------------------
.text
PrintFloat:

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
	
	#Printing Sign
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
	#Printing Exponent
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
	jr $ra

.data
Output_Msg:		.asciiz "Output:\n"
Sign_Msg:		.asciiz "Sign: "
Exponent_Msg:	.asciiz "Exponent: "
Mantissa_Msg:	.asciiz "Mantissa: "
PNL:			.asciiz "\n"

#----------Compare Floats Subroutine----------#
#Subroutine: 	CompareFloats
#Purpose:		Compares two floating precision A and B.
#input:		$a0 = Single Precision float A
#			$a1 = Single Precision float B
#output:		$v0 = Comparison result
#Side Effects:	None
.text
CompareFloats:
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
#-----Comparing Floats-----#
	#Finding The Signs of Both Floats
	andi $t0,$a0,0x80000000
	srl $t0,$t0,31
	andi $t1,$a1,0x80000000
	srl $t1,$t1,31
	#Comparing Signs
	bgt $t0,$t1,Greater
	blt $t0,$t1,Lesser
	#Signs Are Equal, so Get Exponents
	andi $t0,$a0,0x7F800000
	srl $t0,$t0,23
	andi $t1,$a1,0x7F800000
	srl $t1,$t1,23
	#Comparing
	bgt $t0,$t1,Greater
	blt $t0,$t1,Lesser
	#Exp are Equal, so Get Mantissa
	andi $t0,$a0,0x007FFFFF
	andi $t1,$a1,0x007FFFFF
	#Comparing
	bgt $t0,$t1,Greater
	blt $t0,$t1,Lesser
	li $v0,0
	b RestoreRegisters
	Greater:
		li $v0,1
		b RestoreRegisters
	Lesser:
		li $v0,-1
		b RestoreRegisters
#-----Restoring Registers-----#
	RestoreRegisters:
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
#-----Close Out Function-----#
	jr $ra			
	
#----------Normalize Float Subroutine---------#
#Subroutine: 	NormalizeFloat
#Purpose:		Normalizes, rounds, and "packs" a floating point value
#input:		$a0 = 1-bit  Sign bit (right aligned)
#			$a1 = [63:32] of Mantissa
#			$a2 = [31:0] of Mantissa
#			$a3 = 8 bit Biased Exponent (right aligned)
#output:		$v0 = Normalized FP result of $a0,$a1,$a2
#Side Effects:	None
.text
NormalizeFloats:
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
#-----Normalizing-----#
	move $t0, $a0
	move $t1, $a1
	move $t2, $a2
	move $t3, $a3
	
	li $t7,17					#Counter For Decimal Point Shifts
	ShiftA1:
		sll $t1,$t1,1			
		subi $t7,$t7,1			#Counts How Many Decimal Point Shifts are Going to Be Done
		andi $t6,$t1,0x80000000		#Mask to Find The 1's Place of $t1
		beqz $t6,ShiftA1			#Restarts Loop If Right Most 1 is not in 1's Place
	
	add $t3,$t3,$t7				#Adding How Many Decimal Point Shifts Were Done
	#Combine $a1 and $a2
	addi $t7,$t7,15
	srlv $t2,$t2,$t7				#Aligns $a2
	
	or $t1,$t1,$t2				#combines $a1 & $a2
	sll $t1,$t1,1				#Shift the 1's place out of Mantissa
	srl $t1,$t1,9				#Aligns $t1 (Mantissa)
	
	sll $t0,$t0,31				#Aligns $t0 (Sign)
	sll $t3,$t3,23				#Aligns $t3 (Exponent)
	
	or $v0,$v0,$t0				#Combining Sign into $v0
	or $v0,$t0,$t3				#Combining Exponent into $v0
	or $v0,$t0,$t1				#Combining Mantissa into $v0
#-----Restoring Registers-----#
	RestoreRegisters:
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
#-----Close Out Function-----#
	jr $ra