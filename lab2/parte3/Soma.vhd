LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Soma IS
	PORT (Ci, a , b : IN STD_LOGIC;
	Co, s : OUT STD_LOGIC);
END Soma;

ARCHITECTURE Behavior OF Soma IS
		
		BEGIN
		
		s <= (a XOR b) XOR Ci;
		Co <= (NOT (a XOR B) AND b) OR ((a XOR b) AND Ci);


	
END Behavior;