--------------------------------
LAB 4: FEEDBABE IN MIPS
CMPE 012 Spring 2018

Scott Fischer, sifische
Section 01F, Mike
--------------------------------


--------------------------------
LEARNING

<<Describe what you learned, what was surprising, what worked well and what did not.>>
I learned the overall structure and syntax of loops and if-else statements. I also learned how the null terminator on ascii strings works, and when to use and not use them as I had messed around with it to see if I could make my program more efficient with the string outputs. I also learned the difference between jumping and branching. I learned how and which conditional branch functions to use as I used these in the if-else blocks. Lastly, I learned how to store a remainder number with division instead of making a whole mod function. 

--------------------------------
ANSWERS TO QUESTIONS

1.
In MIPS a word is 4 bytes which is 32 bits, so if we use unsigned integers then the number would be 2^32 -1. However, if we use signed integers it would be half of that because half of the bits would be reserved for negative numbers.

2.
The address for the reigster starts at 0x10010000 and spans 6 words. Each char is stored in a seperate address so it goes from 0x10010000 to 0x10010018 as there are 25 chars that make up the text "Please input a number:" including \0 \n as the terminating char and new line.

3.
"move" is a puesdo-op used and it is implemented using addiu a real instruction in assembly. "b" is another one I used and it just uses beq and comparing two $zero registers making it always true. "bgtz" and "begz" are also implemented in my program and they use a combination of a couple instructions to get the desired operation performed.

4.
I used 7 register in this lab and I could probably use fewer if I just used numbers for the division instead of keeping the numbers 3 & 4 in different registers. However, while writing the program this made it easier for me to map out what data was where, and which registers were being used when.
