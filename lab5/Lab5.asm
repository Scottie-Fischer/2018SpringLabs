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
#-----Printing Prompt & Program Argument-----#
	li $v0,4
	la $a0, Prompt
	syscall
	li $v0,4
	la $a0, ($a1)
	syscall
	li $v0,4
	la $a0, New_Line
	syscall
#----------Turning ASCII Into Hex----------#
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
	beq $t0,9,To_Dec			#If at end of String then end
	divu $s3,$s3,16			#Update Hex Number We Multiply By
	
	#Updates Hex Bit We Look At
	addi $t0,$t0,1
	addu $t1, $a1,$t0
	lb $t3, ($t1)
	b Loop_start			#Restarts Loop
#-----End Of ASCII LOOP----#
#-----Start of Turning Binary to ASCII-----#
	To_Dec:
	li $t0, 0				#Counter for How Many Decimal Digits
	#Sets $t7 to binary version of decimal number by converting to 2SC
	move $t7,$s0
	bgtz $t7,bin2Dec			#Skips Converting Number to Positive Version
	xori $t7,$t7 0xFFFFFFFF
	addiu $t7,$t7,1
	
	bin2Dec:				#Loop converts binary $t7 to decimal number
	beqz $t7,addSign			#Branches if no more Digits
	rem $t6,$t7,10
	mflo $t7
	bltz $t6,hardCode
	pos:
	addi $t6,$t6,48
	sb $t6,myArray($t0)
	addi $t0,$t0,1
	b bin2Dec
	
	addSign:				#Adds Negative Sign in Case Decimal Number is Negative
	andi $t7,$s0,0x80000000		#Repurposes $t7 to hold the first bit of binary number
	srl $t7, $t7,31			
	blt $t7,1,End			#Skips adding '-' char to array if positive
	li $t2,0x2D
	sb $t2,myArray($t0)
	lb $t4,myArray($zero)
	addiu $t0,$t0,1
	b End
	hardCode:				#Multiplies Division by -1 to Ensure Correct ASCII Char
	li $t5,-1
	mult $t6,$t5
	mflo $t6
	b pos					#Continues Back to Process
#-----Start of Printing Process-----#
	End:
	bltz $t0,Close
	lb $t4,myArray($t0)
	li $v0,11
	la $a0,($t4)
	syscall
	subiu $t0,$t0,1
	b End
	Close:
	li $v0,10
	syscall
.data
Prompt:
.asciiz "Input a hex number:\n"
New_Line:
.asciiz "\n"
myArray: .space 32