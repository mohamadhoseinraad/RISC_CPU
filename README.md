## RISC CPU in Verilog with 8 commands and 16*8 memory
KNTU University 
Students : Mohammadhosein Shabaniraad , Mohammadreza Abedin 
Teacher : Dr.Atena Abdi
spring 2024 , Computer architecture lecture

## commands :
# ADD 
Add the operand of instruction to the value of a specific register
add AC register with M[AR] 

# ASHL 
Arithmetic shifting the operand of instruction to left
AC register <<< 1

# XNOR 
Applying Xnor to the operand of instruction and the value of a specific register
xnor AC register with M[AR] 

# DIV2
Divide the operand of instruction by 2
AC register >> 1

# LOAD 
Load the value of the operand of instruction to a specific register
AC register <- M[AR] 

# STORE 
Store the value of specific register to the operand of instruction
AC register -> M[AR]

# COMP2S 
Two’s complement the operand of instruction
AC register <- not AC register + 1

# ROUND
Load the value of the operand of instruction to a specific register and round up to the nearest power of 2 then store it
M[AR] <- Round of M[AR]

## BUS decoder codes:

# AR register (1)
# PC register (2)
# DR register (3)
# AC register (4)
# IR register (5)
# Memory unit (7)

## Commands decoder codes and end time:

# AND D(0) T(5)
# ASHL D(1) T(5)
# XNOR D(2) T(5)
# DIV D(3) T(5)
# LOAD D(4) T(5)
# LOAD D(4) T(5)
# STORE D(5) T(4)
# COMP2S D(6) T(5)
# ROUND D(7) T(7)

## Micro instructions describe in pdf in rep
[a link] (https://github.com/mohamadhoseinraad/CPUMAMADS/blob/master/micro%20instructions.pdf)
