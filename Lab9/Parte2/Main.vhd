--- Julio Alves Meesquita da Silva -- 156061 --
--- Gabriel Bonani Machado 		  -- 155416 --

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity Main is
	port (
			SW : IN STD_LOGIC_VECTOR (17 downto 0);
			LEDR : OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
			LEDG: OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
			KEY: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			HEX1,HEX0,HEX7,HEX6,HEX5,HEX4,HEX3,HEX2 : OUT STD_LOGIC_VECTOR (0 TO 6)
	);
end Main;

architecture behavior of Main is
		
	component ramlpm
		PORT
		(
			address	: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
			clock		: IN STD_LOGIC  := '1';
			data		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			wren		: IN STD_LOGIC ;
			q			: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
		);
	end component;
	
	component seg IS
		PORT (  SW : IN std_logic_vector (3 DOWNTO 0) ;
		HEX0 : OUT std_logic_vector (0 TO 6)  ) ;
	END component;
	
	component Reg IS
	PORT ( 
		CLK, RESET,Sel : IN STD_LOGIC;
		A : IN STD_LOGIC_VECTOR(7 downto 0);
		Q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
	END component;
	
	component Soma8 IS
	PORT ( 
		A, B : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		SUB : IN STD_LOGIC;
		Q: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		OVER: OUT STD_LOGIC);
	END component;
	
	component Mux IS
	PORT ( 
		A, B : IN STD_LOGIC_VECTOR(7 downto 0);
		Sel : IN STD_LOGIC;
		Q : OUT STD_LOGIC_VECTOR(7 downto 0));
	END component;

	
	signal CLKZ,CLKM,CLKR,ClearRegs,WrEn,SelM2,SelM1,SelRb,SelRa,AddSubR,Over : STD_LOGIC;
	signal TecD,Dado, Breg, Areg, Zreg, G, M : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL FIM : STD_LOGIC_VECTOR (4 DOWNTO 0);
	SIGNAL SAIDA : STD_LOGIC_VECTOR (7 DOWNTO 0);
	
	BEGIN
	
		CLKZ <= KEY(0);
		CLKM <= KEY(1);
		CLKR <= KEY(2);
		ClearRegs <= KEY(3);
		TecD <= SW(7 DOWNTO 0);
		FIM(3 DOWNTO 0) <= SW(11 DOWNTO 8);
		FIM(4) <= '0';
		WrEn <= SW(12);
		SelM2 <= SW(13);
		SelM1 <= SW(14);
		SelRa <= SW(15);
		SelRb <= SW(16);
		AddSubR <= SW(17);
		LEDG(0) <= WrEn;
		LEDG(1) <= AddSubR;
		
		RB : Reg port map(CLKR,ClearRegs,SelRb,SAIDA,Breg);
		RA : Reg port map(CLKR,ClearRegs,SelRa,SAIDA,Areg);
		M1 : Mux port map(Areg,Zreg,SelM1,G);
		AS : Soma8 port map(Breg,G,AddSubR,M,Over);
		RZ : Reg port map(CLKZ,ClearRegs,'1',M,Zreg);
		M2 : Mux port map(Zreg,TecD,SelM2,Dado);
		r1: ramlpm port map(FIM,CLKM,Dado,WrEn,SAIDA);
		
		H0 : seg port map(Breg(3 downto 0),HEX0);
		H1 : seg port map(Breg(7 downto 4),HEX1);
		H2 : seg port map(Areg(3 downto 0),HEX2);
		H3 : seg port map(Areg(7 downto 4),HEX3);
		H4 : seg port map(Zreg(3 downto 0),HEX4);
		H5 : seg port map(Zreg(7 downto 4),HEX5);
		H6 : seg port map(SAIDA(3 downto 0),HEX6);
		H7 : seg port map(SAIDA(7 downto 4),HEX7);
		
		LEDR <= SW;
		
		
		
end behavior;