-Scott Fischer, sifische@ucsc.edu, 1610331, Section Number: 01F

What I learned:
-I learned how the truth tables works and the process of using POS and SOP with the truth tables to get the circuit structure. I also learned how to use the tools in MML and how to format these files.

What went Wrong:
-For me I had some trouble figuring out which to use, POS or SOP, for Part C. I had to rewatch one of the lectures and go through my notes, but after that it was very clear to me. I also had some trouble with the written questions just because I might have been overthinking them, but Piazza helped with that, and reading through the textbook also helped. Also at first in Part D I didn't understand how the 7 segment display worked, because I had wired it somewhat wrong but lecture and rewiring cleared it up. Also some of the naming covention were hard to use since MML forced me to do different names for circuits for each page.

What went Right:
-MML was very easy to use for me, so it was really easy for me to pick up and play around with the different circuit components when figuring out part C. The lecture on Thursday was also very helpful for this lab and cleared a lot of things up which made Part C and Part D much easier.


Questions:
-Question 1: In order to make a 7 segment display like the one in part B I would have each segment be seperate AND gate with its own structure behind it, meaning each is a seperate binary ouput. I would take each decimal number and convert it into binary to show which switches would be switched on to represent that number, and compare when the serperate 7 output gates need to be on or off. Then I would make a truth table to see the structure that would be required behind the 7 output gates.

-Question 2: I think the random number generator is similar to an R-S latch described in class, but there is only one input going to all the gates. The gates are grouped into pairs of AND and NAND gates that feed into eachother. This means that depending on which gate receives the voltage first deteremines the state of the output. There would be a number of these groupings depending on how many binary bits the biggest number generated is.

-Question 3: Most circuits and random functions in software are not truly random, but are psuedo-random and thus are close enough to being random that the it's not significant. The randomness in how I think the random circuit is made comes from the faultiness in timing of voltages, so because the wires and circuits are not 100% perfect one gate might be powered before another and thus making the output change each time. 
