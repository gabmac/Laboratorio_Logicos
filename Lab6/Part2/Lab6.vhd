LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

ENTITY Lab6 IS
PORT ( 
	SW : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	KEY :IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	LEDR: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	LEDG: OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
END ENTITY;

ARCHITECTURE Structural OF Lab6 IS


	BEGIN
	PROCESS(KEY, SW)
	
	variable SUM, MUDA : std_logic_vector(8 downto 0);

	
	
	BEGIN
	IF (SW(8) = '1') THEN
		MUDA(0) := NOT SW(0);
		MUDA(1) := NOT SW(1);
		MUDA(2) := NOT SW(2);
		MUDA(3) := NOT SW(3);
		MUDA(4) := NOT SW(4);
		MUDA(5) := NOT SW(5);
		MUDA(6) := NOT SW(6);
		MUDA(7) := NOT SW(7);
		
		MUDA:= MUDA + '1';
		
	ELSIF(SW(8) = '0') THEN
		MUDA(7 DOWNTO 0) := SW(7 DOWNTO 0);
		
	END IF;
	MUDA(8) := '0';
	
	IF(KEY(0) = '0') THEN
		SUM := "000000000";
	ELSIF(rising_edge(KEY(1))) THEN
		SUM(8) := '0';
		SUM := MUDA + SUM;
	END IF;	
	LEDR <= SUM(7 DOWNTO 0);
	LEDG(0) <= SUM(8);
	END PROCESS;
	

END Structural;

	