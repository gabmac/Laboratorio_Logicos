LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Comparador IS
	PORT ( V : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	Z : OUT STD_LOGIC);
END Comparador;

ARCHITECTURE Behavior OF Comparador IS
		
		BEGIN
		 
		 Z <= (V(3) AND V(1)) OR (V(3) AND V(2));

	
END Behavior;
 	