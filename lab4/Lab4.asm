.text
main:
	#Prompt Input Number
	li $v0,4
	la $a0,greeting_prompt
	syscall

	#Take Input
	li $v0, 5
	syscall
	
	#Store Input
	move $t0, $v0
	
	#Print Message
	li $v0,4
	la $a0,message
	syscall
	
	#Print Input
	li $v0,1
	move $a0, $t0
	syscall	
									
	li $v0, 10
	syscall

.data
greeting_prompt:
.asciiz "Please Enter a Number:"
message:
.asciiz "\nYou entered: "

	
