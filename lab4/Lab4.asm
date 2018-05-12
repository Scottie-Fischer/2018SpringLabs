.text
main:
#---------This is the Prompt--------#
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
	li $s1, 1
	#Creates Increment Variable
	li $t1,1
	
	#----Stores Dividends----#
	li $t3,3
	li $t4,4
	
	start_loop:
		move $t0,$s1
		
		#---------This is IF BLOCK For Divisibility---------#	
		start_divis3:
			div $t0,$s1,$t3		#Divide by 3
			mfhi $s2			#Saves Remained into $s2
			beqz $s2,next_divis	#If Divisible By 3 then Check x/4
		
			#Not 3 but checking 4:
			div  $s1,$t4
			mfhi $s2
			bgtz $s2,Print_Int	#If not divis then print int
		
			#divisible by 4 so print BABE and end
			li $v0,4
			la $a0,Babe_MSG
			syscall
		
		
			b Finish
		
		#Check if divis by both 3 & 4
		next_divis:
			li $v0,4
			la $a0,Feed_MSG
			syscall
		
			div  $s1,$t4
			mfhi $s2
			bgtz $s2,Finish	#If not divis by 4 jumpt to Finish
		
			#It is divis by 4
			li $v0,4
			la $a0,Babe_MSG
			syscall
		
			b Finish
		
		#Makes Sure New Line is Started#
		Finish:
			li $v0, 4
			la $a0, End_MSG
			syscall
			b closeOut
		
		Print_Int:
			li $v0, 1
			move $a0, $s1
			syscall
			b Finish
		
		closeOut:
			#Restarting Loop#	
			beq $s1,$s0,end_loop	#If counter equals user input jumps to end_loop
			add $s1,$s1,$t1		#If not equal adds 1 to counter and jumps to start_loop
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
Feed_MSG:
	.asciiz "Feed"
End_MSG:
	.asciiz "\n"
Babe_MSG:
	.asciiz "Babe"
