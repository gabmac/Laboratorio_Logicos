LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Tradutor IS
	PORT (V : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
	C, O: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END Tradutor;

ARCHITECTURE Behavior OF Tradutor IS
		
		BEGIN
		
		C(3 DOWNTO 1) <= "000";
		C(0) <= V(4) OR (V(3) AND V(2)) OR (V(3) AND V(1));
		O(0) <= V(0);
		O(1) <= (V(4) AND (NOT V(1))) OR ((NOT V(4)) AND (NOT V(3)) AND V(1)) OR (V(3) AND V(2) AND (NOT V(1)));
		O(2) <= ((NOT V(3)) AND V(2)) OR (V(2) AND V(1)) OR (V(4) AND (NOT V(1)));
		O(3) <= (V(4) AND V(0)) OR (V(4) AND V(1)) OR (V(3) AND (NOT V(2)) AND (NOT V(1))); 
	
END Behavior;