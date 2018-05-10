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
	move $s0, $v0
	
#---------This is the loop---------#
	#Creates Counter at $s1
	li $s1, 0
	#Creates Increment Variable
	li $t1,1
	
	start_loop:
		move $t0,$s1
		
		#Prints Counter Integer		
		li $v0,1
		move $a0,$t0
		syscall
		
		#If counter equals user input jumps to end_loop
		beq $s1,$s0,end_loop
		
		#If not equal adds 1 to counter and jumps to start_loop
		add $s1,$s1,$t1
		b start_loop
	
	end_loop:
	li $v0,4
	la $a0,message
	syscall
	
	#Exit Program						
	li $v0, 10
	syscall

.data
greeting_prompt:
.asciiz "Please Enter a Number:"
message:
.asciiz "\nFinished Counting!"

	
