--- Julio Alves Meesquita da Silva -- 156061 --
--- Gabriel Bonani Machado 		  -- 155416 --

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY regn IS
	GENERIC (n : INTEGER := 16);
	
	PORT ( R : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		Rin, Clock : IN STD_LOGIC;
		Q : BUFFER STD_LOGIC_VECTOR(n-1 DOWNTO 0) := (OTHERS => '0'));
END regn;

ARCHITECTURE Behavior OF regn IS
	BEGIN
	
	PROCESS (Clock)
	BEGIN
	IF Clock'EVENT AND Clock = '1' THEN
		IF Rin = '1' THEN
			Q <= R;
		END IF;
	END IF;
	
	END PROCESS;

END Behavior;