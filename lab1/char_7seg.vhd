LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY char_7seg IS
	PORT ( C : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			Display : OUT STD_LOGIC_VECTOR(0 TO 6));
END char_7seg;

ARCHITECTURE Behavior OF char_7seg IS
	BEGIN
	Display(0) <= (NOT C(2)) AND C(0);
	Display(1) <= ((NOT C(0)) AND (NOT C(1)) AND (NOT C(2))) OR ((NOT C(2)) AND C(1) AND C(0));
	Display(2) <= ((NOT C(0)) AND (NOT C(1)) AND (NOT C(2))) OR ((NOT C(2)) AND C(1) AND C(0));
	Display(3) <= ((NOT C(2)) AND C(0)) OR ((NOT C(2)) AND C(1));
	Display(4) <= NOT C(2);
	Display(5) <= NOT C(2);
	Display(6) <= (NOT C(2)) AND (NOT C(1));

END Behavior;