LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY Lab7 IS
PORT (KEY: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		SW: IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		LEDG: OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
		LEDR: OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
);
	
END Lab7;
	
	
	
ARCHITECTURE Structural OF Lab7 IS
	
	COMPONENT FLIPFLOP IS
		PORT ( 
		CLK,D, RESET : IN STD_LOGIC;
		Q : OUT STD_LOGIC);
	END COMPONENT;
	
	SIGNAL D: STD_LOGIC_VECTOR(8 DOWNTO 0);
	SIGNAL Q: STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
	
	BEGIN
	D(0) <= '1';
	D(1) <= NOT (SW(0)) AND (NOT (Q(0)) OR Q(8) OR Q(7) OR Q(6) OR Q(5));
	D(2) <= NOT (SW(0)) AND (Q(1));
	D(3) <= NOT (SW(0)) AND (Q(2));
	D(4) <= NOT (SW(0)) AND (Q(3) OR Q(4));
	D(5) <= SW(0) AND (NOT (Q(0)) OR Q(1) OR Q(2) OR Q(3) OR Q(4));
	D(6) <= SW(0) AND (Q(5));
	D(7) <= SW(0) AND (Q(6));
	D(8) <= SW(0) AND (Q(7) OR Q(8));
	
	FF0: FLIPFLOP port map (KEY(0), D(0),KEY(1),Q(0));
	FF1: FLIPFLOP port map (KEY(0), D(1),KEY(1),Q(1));
	FF2: FLIPFLOP port map (KEY(0), D(2),KEY(1),Q(2));
	FF3: FLIPFLOP port map (KEY(0), D(3),KEY(1),Q(3));
	FF4: FLIPFLOP port map (KEY(0), D(4),KEY(1),Q(4));
	FF5: FLIPFLOP port map (KEY(0), D(5),KEY(1),Q(5));
	FF6: FLIPFLOP port map (KEY(0), D(6),KEY(1),Q(6));
	FF7: FLIPFLOP port map (KEY(0), D(7),KEY(1),Q(7));
	FF8: FLIPFLOP port map (KEY(0), D(8),KEY(1),Q(8));
	
	LEDR <= Q;
	
	LEDG(0) <= Q(8) OR Q(4);
	
END Structural;