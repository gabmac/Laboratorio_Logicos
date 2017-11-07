LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Mux IS
	PORT ( 
		A, B : IN STD_LOGIC_VECTOR(7 downto 0);
		Sel : IN STD_LOGIC;
		Q : OUT STD_LOGIC_VECTOR(7 downto 0));
END Mux;

ARCHITECTURE Structural OF Mux IS
	
	BEGIN
	
	Q(0) <= (NOT (Sel) AND A(0)) OR (Sel AND B(0));
	Q(1) <= (NOT (Sel) AND A(1)) OR (Sel AND B(1));
	Q(2) <= (NOT (Sel) AND A(2)) OR (Sel AND B(2));
	Q(3) <= (NOT (Sel) AND A(3)) OR (Sel AND B(3));
	Q(4) <= (NOT (Sel) AND A(4)) OR (Sel AND B(4));
	Q(5) <= (NOT (Sel) AND A(5)) OR (Sel AND B(5));
	Q(6) <= (NOT (Sel) AND A(6)) OR (Sel AND B(6));
	Q(7) <= (NOT (Sel) AND A(7)) OR (Sel AND B(7));
	
END Structural;