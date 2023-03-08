University of Maryland Baltimore County 
CMPE/ENEE 491/691 
Hardware Security 
Spring 2023 
Lab 3: Advanced Encryption Standard (AES)
Jordan Kieltyka

Prerequisites: Icarus Verilog (iverilog) installed

Part A:
    1) Navigate to the 'src' directory.
    2) To build, use command 'make aes' in the 'test' directory.
    3) Navigate to the 'test' directory.
    4) Ensure 'in.txt' is populated and in the 'test' directory.
    5) To perform a simulation, use command 'vcc aes.a' in the 'test' directory.
    6) Output will be in 'out.txt' in the 'test' directory.

    The format for 'in.txt':
    <part a flag>
    <plain text>
    <cipher text> 

Notes
    * To build everything, use the command 'make'.
    * To clean the 'test' directory of builds, use the command 'make clean'.