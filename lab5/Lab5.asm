.text
main:
	la $a1, 0x10010000

#-----Register Variables-----#
	li $s3, 268435456
	li $t0, 2			#Offset Counter for Address
	addu $t1, $a1,$t0		#Holds Address of Current Char (3rd char) (Byte Address)
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
	
	li $v0,11
	la $a0,($t3)
	syscall

#----------IF Block----------#	#Determines if char is Digit or Letter
	Start:
	bgt $t3,0x40,Letter
	#Digit:	
	subi $t6,$t3,0x30			#If Digit subtracts 48
	b Multi
	
	Letter:
	subi $t6,$t3,0x37			#If Letter subtracts 55
	b Multi
	
	Multi:
	multu $t6,$s3
	mflo $t7
	addu $s0, $s0, $t7
	b Split
	
	Split:
	beq $t0,9,End
	#Update Hex Number We Multiply By
	divu $s3,$s3,16
	#Updates Bit We Look At
	addi $t0,$t0,1
	addu $t1, $a1,$t0
	lb $t3, ($t1)
	b Start
	
	End:
		li $v0,10
		syscall

.data
String_Data:
.asciiz "0xDEADBEEF"
Prompt:
.asciiz "Input a hex number:\n"
New_Line:
.asciiz "\n"