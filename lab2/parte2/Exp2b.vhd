LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Exp2b IS
	PORT ( SW : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	HEX0, HEX1 : OUT STD_LOGIC_VECTOR(0 TO 6));
	 
END Exp2b;

ARCHITECTURE Behavior OF Exp2b IS
		COMPONENT Comparador
		PORT ( V : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	Z : OUT STD_LOGIC);
	END COMPONENT;

	COMPONENT CircA
		PORT ( V : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	O : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
	END COMPONENT;
	
	
	COMPONENT DISP
		PORT ( SW : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	Display : OUT STD_LOGIC_VECTOR(0 TO 6));
	END COMPONENT;
		
		SIGNAL  M, N, Q	: STD_LOGIC_VECTOR(3 DOWNTO 0);
		SIGNAL M0 : STD_LOGIC;
		
		BEGIN
		
		Comp: Comparador PORT MAP (SW, M0);
		CircuitoA: CircA PORT MAP (SW, M);
		N(3) <= (NOT (M0) AND SW(3)) OR (M0 AND M(3));
		N(2) <= (NOT (M0) AND SW(2)) OR (M0 AND M(2));
		N(1) <= (NOT (M0) AND SW(1)) OR (M0 AND M(1));
		N(0) <= (NOT (M0) AND SW(0)) OR (M0 AND M(0)); 
		
		H0: DISP PORT MAP (N,HEX0);
		
		Q(0) <= M0;
		Q(1) <= '0';
		Q(2) <= '0';
		Q(3) <= '0';
		
		H1: DISP PORT MAP (Q,HEX1);

	
END Behavior;
 	