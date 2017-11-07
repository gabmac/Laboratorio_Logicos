--- Julio Alves Meesquita da Silva -- 156061 --
--- Gabriel Bonani Machado 		  -- 155416 --

LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

ENTITY i9 IS
PORT ( 
	Clock, Resetn, Run : IN STD_LOGIC;
	SW: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	Done : OUT STD_LOGIC;
	LEDs: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7 : OUT STD_LOGIC_VECTOR(0 TO 6));
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
	
	Component dec3to8 IS
		PORT ( 
			W : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			En : IN STD_LOGIC;
			Y : OUT STD_LOGIC_VECTOR(0 TO 7));
	END Component;
	
	SIGNAL DIN, ADDR, DOUT, BusWires, ADDR_s, MEMOUT : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL W, wr_en, En_LED, addressstall_a, addressstall_aN: STD_LOGIC;
	SIGNAL En_Seg, En_SW: STD_LOGIC;
	SIGNAL H : STD_LOGIC_VECTOR(7 downto 0);
	
	BEGIN
	processor: proc port map (DIN, Resetn, Clock, Run, Done, BusWires, ADDR, DOUT, W, addressstall_a);
	
	addressstall_aN <= NOT addressstall_a;
	wr_en <= (NOT (ADDR_s(15) OR ADDR_s(14) OR ADDR_s(13) OR ADDR_s(12))) AND W;
	En_LED <= (NOT (ADDR_s(15) OR ADDR_s(14) OR ADDR_s(13) OR NOT ADDR_s(12))) AND W;
	
	
	ram4GB: MEMRAM port map (ADDR(6 DOWNTO 0), addressstall_a, Clock, DOUT, wr_en, MEMOUT); 
	
	reg_led: regn port map (DOUT, En_LED, Clock, LEDs);
	reg_addr: regn port map (ADDR, addressstall_aN, Clock, ADDR_s);

	
	En_Seg <= (NOT (ADDR_s(15) OR ADDR_s(14) OR NOT ADDR_s(13) OR ADDR_s(12))) AND W;
	dechex: dec3to8 port map (ADDR_s(2 downto 0), En_Seg, H);
	
	reg_hex0: regn 
		generic map (7)
		port map (DOUT(6 downto 0), H(0), Clock, HEX0);
	reg_hex1: regn 
		generic map (7)
		port map (DOUT(6 downto 0), H(1), Clock, HEX1);
	reg_hex2: regn 
		generic map (7)
		port map (DOUT(6 downto 0), H(2), Clock, HEX2);
	reg_hex3: regn 
		generic map (7)
		port map (DOUT(6 downto 0), H(3), Clock, HEX3);
	reg_hex4: regn 
		generic map (7)
		port map (DOUT(6 downto 0), H(4), Clock, HEX4);
	reg_hex5: regn 
		generic map (7)
		port map (DOUT(6 downto 0), H(5), Clock, HEX5);
	reg_hex6: regn 
		generic map (7)
		port map (DOUT(6 downto 0), H(6), Clock, HEX6);
	reg_hex7: regn 
		generic map (7)
		port map (DOUT(6 downto 0), H(7), Clock, HEX7);
	
	
	En_SW <= (NOT (ADDR_s(15) OR ADDR_s(14) OR NOT ADDR_s(13) OR NOT ADDR_s(12))) AND NOT W;
	
	DIN <= SW when En_SW = '1' else MEMOUT;
	
END Structural;

	