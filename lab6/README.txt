--------------------------------
LAB 6: FLOATING POINT MATH
CMPE 012 Spring 2018

Scott Fischer, sifische: 1610331
Section 01F, TA Name:Mike
--------------------------------


----------------
LEARNING

<<Describe what you learned, what was surprising, what worked well and what did not.>>
I learned a lot of subroutines and functions: the overall structure, the jump calls, and the $ra register. I also learned how to better use the stack b/c we had to save all the registers for each function. I also learned a ton about the float data type including the overall structure, and how to do basic arithmetic operations on it. I also better understand binary just from having to shift bits, count bits,etc. 

----------------
ANSWERS TO QUESTIONS

1.
I used a lot of test code for this lab. I would often write simple code to load values into my half-baked functions and then print out the binary data of certain registers. This helped with building up my functions brick by brick. I also wrote simple test functions at the end to test all the functions, this was similar to the file provided.

2.
Floating Point Overflow is when you get a certain exponent values like 255 or 0 (in decimal) and would get pos/neg infinity or NAN (not a number). These mean the floating point you calculated are too big to represent.

3.
I had some rounding problems, and I tried to make sure it would round up when the 24th bit was 1, but couldn't come up with a full-proof solution in time.

4.
I did not write any additional functions, but if I had more time I would have created a function or a macro that saved all the $s registers and $ra register b/c this was at every function. I would also create one that shifted the bits into Normalizing format b/c this was in both AddFloats and MultFloats.

5.
<<Insert your answer>>
