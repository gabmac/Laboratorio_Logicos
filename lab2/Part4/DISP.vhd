LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY DISP IS
	PORT ( SW : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	Display : OUT STD_LOGIC_VECTOR(0 TO 6));
END DISP;

ARCHITECTURE Behavior OF DISP IS
	BEGIN
	
	Display(0) <= (SW(2) AND (NOT (SW(0)))) OR (NOT(SW(3)) AND NOT (SW(2)) AND (NOT (SW(1))) AND SW(0))  ;
	Display(1) <= (SW(2) AND NOT(SW(1)) AND SW(0)) OR (SW(2) AND SW(1) AND NOT(SW(0))) ;
	Display(2) <= NOT( SW(2)) AND SW(1) AND NOT(SW(0));
	Display(3) <= (NOT(SW(2)) AND (NOT SW(1)) AND SW(0)) OR (SW(2) AND NOT (SW(1)) AND NOT(SW(0))) OR (SW(2) AND SW(1) AND SW(0));
	Display(4) <= SW(0) OR (SW(2) AND (NOT SW(1)));
	Display(5) <= ((NOT SW(2)) AND SW(1)) OR (SW(1) AND SW(0)) OR ((NOT SW(3)) AND (NOT SW(2)) AND SW(0));
	Display(6) <= ((NOT SW(3)) AND (NOT SW(2)) AND (NOT SW(1))) OR (SW(2) AND SW(1) AND SW(0));
	
END Behavior;
 	