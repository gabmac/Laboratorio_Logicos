LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY CircA IS
	PORT ( V : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	O : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END CircA;

ARCHITECTURE Behavior OF CircA IS
		
		BEGIN
		 
		O(3) <= '0';
		O(2) <= V(2) AND V(1);
		O(1) <= NOT(V(1));
		O(0) <= V(0);

	
END Behavior;
 	
