library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity Main is
	port (
			SW : IN STD_LOGIC_VECTOR (17 downto 0);
			LEDG: OUT STD_LOGIC_VECTOR (0 DOWNTO 0);
			KEY: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			HEX1,HEX0,HEX7,HEX6 : OUT STD_LOGIC_VECTOR (0 TO 6)
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
	
	COMPONENT seg IS
		PORT (  SW : IN std_logic_vector (3 DOWNTO 0) ;
		HEX0 : OUT std_logic_vector (0 TO 6)  ) ;
	END COMPONENT;
	
	signal CLKZ,CLKM,CLKR,ClearRegs,WrEn,SelM2,SelM1,SelRb,SelRa,AddSubR : STD_LOGIC;
	signal DADO : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL FIM : STD_LOGIC_VECTOR (4 DOWNTO 0);
	SIGNAL SAIDA : STD_LOGIC_VECTOR (7 DOWNTO 0);
	
	BEGIN
	
		CLKZ <= KEY(0);
		DADO <= SW(7 DOWNTO 0);
		FIM(3 DOWNTO 0) <= SW(11 DOWNTO 8);
		FIM(4) <= '0';
		WrEn <= SW(12);
		LEDG(0) <= SW(12);
		mem: ramlpm port map(FIM, CLKZ, DADO, WrEn, SAIDA);
		
		H0: seg port map (SAIDA(3 DOWNTO 0),HEX0);
		H1: seg port map (SAIDA(7 DOWNTO 4),HEX1);
		H6: seg port map (FIM(3 DOWNTO 0),HEX6);
		H7: seg port map ("0000",HEX7);
		
		
		
		
		
end behavior;