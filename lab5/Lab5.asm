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
	#Takes Address from $a1 and puts it in $s1
	la $s1, ($a1)
	#Echos String Given
	li $v0,4
	la $a0, ($t1)
	syscall
	
	#Exits cleanly
	li $v0, 10
	syscall


.data
String_Data:
.asciiz "0xDEADBEEF"

			
