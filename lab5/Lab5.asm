#Scott Fischer
#lab 5

#----------Peudocode Outline----------#
	#Read Input from Register
	#Convert Argument into Binary Integer
	#Store Binary Integer into $s0
	
	#Convert $s0 into ASCII decimal number:
		#Loop Start: Loop 8 times (for each hex digit)
			#Pass Through first two chars ("0x")
			
			#If Block that sets starting binary based on if digit or letter
			
			#If Block that sets value to be added if letter
	
.text
main:
	la $a1, 0x10010000	#Address of .data
	
	#Takes Address from $a1 and puts it in $s1
	la $s1, ($a1)
	#Echos String Given
	li $v0,4
	la $a0, ($s1)
	syscall
	
	#Testing Offset
	la $t1, ($a1)
	lb $t2, 2($t1)
	
	la $v0, 11			#11 is Print Char
	la $a0, ($t2)
	syscall
	
	#Testing For Adding Value With Offset
	li $t3, 0		#$t3 holds offset amt (2)
	addi $t3,$t3,1	#$t3 is now 3
	addu $t4, $1,$t3	
	lb $t5, ($t4)	#Loads the Byte of the offset address into $t5
	
	la $v0, 11		#11 is Print Char
	la $a0, ($t5)	#Prints the value of $t5 (the value of offset address)
	syscall
	
	#Exits cleanly
	li $v0, 10
	syscall


.data
String_Data:
.asciiz "0xDEADBEEF"

			
