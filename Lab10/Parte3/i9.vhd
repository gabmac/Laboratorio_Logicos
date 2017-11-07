--- Julio Alves Meesquita da Silva -- 156061 --
--- Gabriel Bonani Machado 		  -- 155416 --

LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

ENTITY i9 IS
PORT ( 
	Clock, Resetn, Run : IN STD_LOGIC;
	Done : OUT STD_LOGIC;
	LEDs: OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END ENTITY;

ARCHITECTURE Structural OF i9 IS

	component proc IS
		PORT ( DIN : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			Resetn, Clock, Run : IN STD_LOGIC;
			Done : BUFFER STD_LOGIC;
			BusWires : BUFFER STD_LOGIC_VECTOR(15 DOWNTO 0);
			ADDR, DOUT : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			W, addrstall : OUT STD_LOGIC);
	END component;
	
	component MEMRAM
		PORT
		(
			address		: IN STD_LOGIC_VECTOR (6 DOWNTO 0);
			addressstall_a		: IN STD_LOGIC  := '0';
			clock		: IN STD_LOGIC  := '1';
			data		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			wren		: IN STD_LOGIC ;
			q		: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
	end component;

	Component regn IS
		GENERIC (
			n : INTEGER := 16);
		PORT ( 
			R : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
			Rin, Clock : IN STD_LOGIC;
			Q : BUFFER STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END Component;
	
	
	SIGNAL DIN, ADDR, DOUT, BusWires, ADDR_s : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL W, wr_en, E, addressstall_a, addressstall_aN: STD_LOGIC;
	
	BEGIN
	processor: proc port map (DIN, Resetn, Clock, Run, Done, BusWires, ADDR, DOUT, W, addressstall_a);
	
	addressstall_aN <= NOT addressstall_a;
	wr_en <= (NOT (ADDR_s(15) OR ADDR_s(14) OR ADDR_s(13) OR ADDR_s(12))) AND W;
	E <= (NOT (ADDR_s(15) OR ADDR_s(14) OR ADDR_s(13) OR NOT ADDR_s(12))) AND W;
	
	ram4GB: MEMRAM port map (ADDR(6 DOWNTO 0), addressstall_a, Clock, DOUT, wr_en, DIN); 
	
	reg_led: regn port map (DOUT, E, Clock, LEDs);
	reg_addr: regn port map (ADDR, addressstall_aN, Clock, ADDR_s);

END Structural;

	