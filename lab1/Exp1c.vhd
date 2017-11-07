LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Exp1c IS
	PORT ( SW : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
	LEDR : OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
	LEDG : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END Exp1c;

ARCHITECTURE Behavior OF Exp1c IS
	signal A, B, C, M : STD_LOGIC_VECTOR(2 DOWNTO 0);
	BEGIN
	LEDR <= SW;
	
	A(2) <= (NOT (SW(15)) AND SW(14)) OR (SW(15) AND SW(11));
	A(1) <= (NOT (SW(15)) AND SW(13)) OR (SW(15) AND SW(10));
	A(0) <= (NOT (SW(15)) AND SW(12)) OR (SW(15) AND SW(9));

	B(2) <= (NOT (SW(15)) AND SW(8)) OR (SW(15) AND SW(5));
	B(1) <= (NOT (SW(15)) AND SW(7)) OR (SW(15) AND SW(4));
	B(0) <= (NOT (SW(15)) AND SW(6)) OR (SW(15) AND SW(3));
	
	C(2) <= (NOT (SW(16)) AND A(2)) OR (SW(16) AND B(2));
	C(1) <= (NOT (SW(16)) AND A(1)) OR (SW(16) AND B(1));
	C(0) <= (NOT (SW(16)) AND A(0)) OR (SW(16) AND B(0));
	
	M(2) <= (NOT (SW(17)) AND C(2)) OR (SW(17) AND SW(2));
	M(1) <= (NOT (SW(17)) AND C(1)) OR (SW(17) AND SW(1));
	M(0) <= (NOT (SW(17)) AND C(0)) OR (SW(17) AND SW(0));
	
	LEDG(2 DOWNTO 0) <= M;
	
END Behavior;
