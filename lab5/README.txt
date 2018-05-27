--------------------------------
LAB 5: HEX TO DECIMAL CONVERSION
CMPE 012 Spring 2018

Scott Fischer, CruzID
01F —, Mike
--------------------------------


----------------
LEARNING

<<Describe what you learned, what was surprising, what worked well and what did not.>>
I learned a lot about the MIPS tools and layout. I feel really comfortable in reading the registers, and getting data from them (like hex/dec values). I also learned a lot about data conversions and how to implement these conversions. Lastly, I learned how to implement a basic array in MIPS and how to read/write data to this array. The First half of the lab was pretty easy for me. I think a large part of my success in the first part of the lab was from my outlining of the lab. What didn't go so well was the conversion from binary to ASCII. I didn't really have an idea on how to implement this and ended up overthinking it. Overall not too much went wrong or poorly in my process of this lab.


----------------
ANSWERS TO QUESTIONS

1.
There is 1 representation for 0 because the decimal version is in the format of two's complement.

2.
The largest decimal value supported in my program is 2,147,483,647 which is 0x7FFFFFFF in hex.

3.
The smallest supported value is -2147483648 which is 0x80000000 in hex.

4.
I mostly used unsiged arthmetic which gave me the advantage of just typing a hex number when I was using addition of an integer. I also used it because when I manually loaded an integer into a register I almost never needed it to be negative so it allowed me to never worry about that.

5.
In order to turn a String of binary I would first convert the string into the binary number by interating over each digit and subtracting 48 or 0x30. Then I would multiply it by a power of 2, depening on which digit it is. After that I would store the total in a register and divide by 10 until I can't anymore. This would get the decimal version of a certain digit, then you add 48 back to the digit to get the ASCII representation.
