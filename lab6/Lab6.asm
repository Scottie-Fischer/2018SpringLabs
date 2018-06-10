#Scott Fischer
#sifische
#lab6

.text
main:
	li $a0,0x40a1999a
	li $a1,0xc0880000
	jal AddFloats
	move $t7,$v0
	li $v0,10
	syscall
#------------------------------------------------------------------------------------
#Subroutine: 	PrintFloat
#Purpose:		Prints the sign, mantissa, and exponent of a SP FP value
#input:		$a0 = Single Precision float
#Side Effects:	None
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
	b RestoreRegisters2
	Greater:
		li $v0,1
		b RestoreRegisters2
	Lesser:
		li $v0,-1
		b RestoreRegisters2
#-----Restoring Registers-----#
	RestoreRegisters2:
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
NormalizeFloat:
li $v0,0
li $t4,0
li $t5,0
li $t6,0
li $t7,0
#-----Saving Registers-----#
	subi $sp,$sp,52
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
	sw $ra,48($sp)
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
		beqz $a2,Zero
		Continue:
		beqz $t6,ShiftA1			#Restarts Loop If Right Most 1 is not in 1's Place
		
	#add $t3,$t3,$t7				#Adding How Many Decimal Point Shifts Were Done	
	#Combine $a1 and $a2
	addi $t7,$t7,15
	srlv $t2,$t2,$t7				#Aligns $a2
	
	or $t1,$t1,$t2				#combines $a1 & $a2
	
	sll $t1,$t1,1				#Shift the 1's place out of Mantissa
	srl $t1,$t1,9				#Aligns $t1 (Mantissa)
	
	sll $t0,$t0,31				#Aligns $t0 (Sign)
	sll $t3,$t3,23				#Aligns $t3 (Exponent)
	
	or $v0,$v0,$t0				#Combining Sign into $v0
	or $v0,$v0,$t3				#Combining Exponent into $v0
	or $v0,$v0,$t1				#Combining Mantissa into $v0
	b RestoreRegisters5
	Zero:						#Hard Code for Zero Addition
		bnez $a1,Continue
		li $v0,0x00
#-----Restoring Registers-----#
	RestoreRegisters5:
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
		lw $ra,48($sp)
		addi $sp,$sp,52
#-----Close Out Function-----#
	jr $ra
#----------AddFloats Subroutine----------#
#Subroutine: 	AddFloats
#Purpose:		Adds Together two floating point values A & B
#input:		$a0 = Single Point Precision float A
#			$a1 = Single Point Precision float B
#output:		$v0 = Addition of A+B
#Side Effects:	None
.text
AddFloats:
li $t0,0
li $t1,0
li $t2,0
li $t3,0
li $t4,0
li $t5,0
li $t6,0
li $t7,0
#-----Saving Registers-----#
	subi $sp,$sp,52
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
	sw $ra,48($sp)
#---------------------------#
#Psuedo Code Outline
#Step 1: Scale Numbers
	#Check Exponents if Equal Then Branch
	#If Not Equal then figure out which one is bigger
		#Then Do Loop to Get Correct Exponent
#Step2: Add Mantissa
	#Check if adding pos/neg values
		#If Pos/Neg Check if Neg is Bigger
		#If so then flip and subtract	
	#If Both Pos then just add
#Step 3 Normalize
	#Shift Bits into correct Normalize Format
	#Call NormalizeFloat
	
andi $t0,$a0,0x7F800000			#Gets Exponent of A
andi $t1,$a1,0x7F800000			#Gets Exponent of B
srl $t0,$t0,23
srl $t1,$t1,23

andi $t2,$a0,0x007FFFFF			#Gets Mantissa of A
andi $t3,$a1,0x007FFFFF			#Gets Mantissa of B
addi $t2,$t2,0x00800000			#Adding Hidden Bit
addi $t3,$t3,0x00800000			#Adding Hidden Bit

andi $t4,$a0,0x80000000			#Get Sign of A
andi $t5,$a1,0x80000000			#Get Sign of B

beq $t0,$t1,Equal
bgt $t0,$t1,ShiftB
ShiftA:					#Shifting A b/c B's exponent is greater
	srl $t2,$t2,1			#Shift Mantissa of A
	addi $t0,$t0,1			#Add to Exponent of A
	bne $t1,$t0,ShiftA		#Restart loop if needs more shifting
	b Equal
ShiftB:					#Shifting B b/c A's exponent is greater
	srl $t3,$t3,1			#Shift Mantissa of B
	addi $t1,$t1,1			#Add to Exponent of B
	bne $t1,$t0,ShiftB		#Restart loop if needs more shifting
Equal:
	#Step 2 Add Mantissa of A & B
	bne $t4,$t5,PosNeg
	add $t7,$t2,$t3

	b Alignment
	
	PosNeg:
	#Substep of Checking if Neg is Bigger
	bnez $t5,checkSizeofNeg		#B is the Negative
	
	#Else Swap Matnissas of A & B and Signs
	move $t6,$t0
	move $t0,$t1
	move $t1,$t6
	move $t6,$t2
	move $t2,$t3
	move $t3,$t6
	checkSizeofNeg:
	bgt $t2,$t3,Subtract
	li $t4,0x80000000			#Negative is bigger so Sign is Negative
	Subtract:
	sub $t7,$t2,$t3			#Subtracting Mantissa
	#Step 3 Normalize
	Alignment:				#Alignement Substep
	li $t6,0x00				#Clearing $t6
	andi $t6,$t7,0xFF800000		#Checking if 00.yyyy
	beqz $t6,FractShift
	andi $t6,$t7,0x1000000		
	beqz $t6, Shift			#Branch if not 10.yyyy
	andi $t6,$t7,0x1			#Taking the 24th Bit and Storing into $t6
	sll $t6,$t6,22			#Shifting 24th bit into Alignment
	srl $t7,$t7,1			#Aligning The Decimal Point
	addi $t0,$t0,1			#Adding to Exponent
	
	Shift:				#Shifting into Normalizing Format
	andi $t5,$t7,0x1FF
	sll $t5,$t5,23
	add $t6,$t6,$t5			#Combining last 10 bits
	srl $t7,$t7,9			#Shifting for Normalizing Format
	b Normalize
	FractShift:			
		sll $t7,$t7,1
		subi $t0,$t0,1
		andi $t6,$t7,0x800000
		beqz $t6,FractShift
	Normalize:
	move $a0,$t4
	move $a1,$t7
	move $a2,$t6
	move $a3,$t0
	jal NormalizeFloat
	move $t7,$v0

#-----Restoring Registers-----#
	RestoreRegisters4:
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
		lw $ra,48($sp)
		addi $sp,$sp,52
#-----Close Out Function-----#
	jr $ra
.data
Pos_Neg:	.asciiz "Adding Pos Neg Floats\n"