--------------------------------
LAB 3: LOGIC UNIT WITH MEMORY
CMPE 012 Spring 2018

Scott Fischer, sifische
Section 01F—, TA: Mike
--------------------------------


----------------
LEARNING

<<Describe what you learned, what was surprising, what worked well and what did not.>>

I learned the overall design of a mux circuit, and the purpose of the circuit which is to choice a certain output/route in the circuit. So if there are 4 different possible outputs in the same circuit the mux allows you to choose 1 of these outputs. I also learned how to incorporate flip flops in order to make a register that stores bits of data. I also learned how to better approach circuit designs, and not necessarily look at it from a large picture at the start. Instead I found it better to break each piece down, make and test that peice. Then I would incorporate all peice together.

----------------
ISSUES

<<Discuss issues you had building the circuit.>>

At first I had trouble understanding what I needed to accomplish, as in what the overall structure of the circuit would be. I knew that the mux needed to select the different operations, but I didn't know if how that would work in the basic idea of the design. At first I tried making it so that it would choose one operation and give all the bits, but that I figured out that wasn't the function of the mux. I instead had to break the lab piece by piece, and made the one bit mux and copy it. After I did the lab peice by piece it was much easier.

----------------
DEBUGGING

<<Describe what you added to each module to make debugging easier.>>

Register: I started with one register and added one switch and an LED to test. When that worked I copied the register and added switches for each bit register and LEDs.
Operands: I added 4 switches and 8 LEDS. The switches were for the user inputs and the first 4 LEDs were to show the switches data, while the other 4 LEDs were for the output data.
Mux: I added 8 switches and 8 LEDs for the user input and register input bits, then I added 4 LEDs at the end to show which route was selected.
At the End: I kept the testing LEDS for the above components, while taking out the switches. I also added 4 LEDs for the user input, so that I didn't have to translate hex into binary. I then added 4 LEDs at on the register 7 segment display.


----------------
QUESTIONS

What is the difference between a bit-wise and reduction logic operation?
Bitwise operations work on only two bit patterns at once, while reduction logic operations groups two pair together in parrallels. So in bitwise if you are trying to be 1+5+3+4, you would have to do first 1+5=6 then 6+3=9 then 9+4=13 to get the result. But in reduction logic you can instead do (1+5) + (3+4) -> 6+7 = 13. 

What operations did we implement?
We implemented the AND, OR, and NOT(invert) bitwise operations, because our calculations were done bit by bit.

Why might we want to use the other type of logic operations?
We would want to user reduction logic if we had 4+ groupings of operations. In this lab it is just ANDing 2 4bit numbers, but if we had 4 4bit numbers we were ANDing or adding then we would want to use reduction.

