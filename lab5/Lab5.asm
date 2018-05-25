#Scott Fischer
#sifische
#CMPE12
#lab 5
.text
main:
	lw $a1, ($a1)			#Loads Stack Address from Program Argument
#-----Register Variables-----#
	li $s3, 268435456			#Stores Dec Representation of Hex Digit 
	li $t0, 2				#Offset Counter for Address
	addu $t1, $a1,$t0			#Holds Address of Current Char (3rd char) (Byte Address)
	lb $t3, ($t1)			#Holds Actual Value of Char
	
#-----Printing Prompt & Data-----#
	li $v0,4
	la $a0, Prompt
	syscall
	li $v0,4
	la $a0, ($a1)
	syscall
	li $v0,4
	la $a0, New_Line
	syscall

#----------Loop----------#	#Determines if char is Digit or Letter
	Loop_start:
	bgt $t3,0x40,Letter
	#Digit:	
	subi $t6,$t3,0x30			#If Digit subtracts 48
	b Multiply
	
	Letter:
	subi $t6,$t3,0x37			#If Letter subtracts 55
	b Multiply
	
	#Multiplies Number by Hex Digit Value (i.e if 2nd to last value then mutliplies by 16)
	Multiply:
	multu $t6,$s3
	mflo $t7
	addu $s0, $s0, $t7
	b Split
	
	Split:
	beq $t0,9,To_ASCII		#If at end of String then end
	
	#Update Hex Number We Multiply By
	divu $s3,$s3,16
	
	#Updates Hex Bit We Look At
	addi $t0,$t0,1
	addu $t1, $a1,$t0
	lb $t3, ($t1)
	b Loop_start			#Restarts Loop
	
	To_ASCII:
	#If Block to Determine if Negative or Postive
	li $t0, 0				#Reassigns $t0 to be for array offset(index) holder
	andi $t7,$s0,0x80000000		#Repurposes $t7 to hold the first bit of binary number
	srl $t7, $t7,31			
	blt $t7,1,Positive		#Skips adding '-' char to array if positive
	
	li $t2,0x2D
	sb $t2,myArray($t0)
	lb $t4,myArray($zero)
	
	Positive:				#Skips adding '-' char to array
	li $t7, 0				#Repurposing $t7
	add $t7,$t7,$s0
	xori $t7,$t7, 0xFFFFFFFF
	addi $t7,$t7,1
	#-----Loop for Numbers----# (Eventually)
	addi $t0,$t0,4 
	li $t5,0x10000000
	andi $t6,$t7,0xF0000000
	div $t6,$t6, $t5 
	addi $t6,$t6,48
	sb $t6,myArray($t0)
	
	
	b End
	
	End:
		#Prints Integer
		li $v0, 1
		la $a0, ($s0)
		syscall
		li $v0,4
		la $a0,New_Line
		syscall
		li $v0,11
		la $a0,($t4)
		syscall
		li $v0,10
		syscall
.data
Prompt:
.asciiz "Input a hex number:\n"
New_Line:
.asciiz "\n"
myArray: .space 20
