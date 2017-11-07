 library ieee;
use ieee.std_logic_1164.all;

entity Main is
	port (
		SW : in STD_LOGIC_VECTOR (15 DOWNTO 0);
		KEY: in STD_LOGIC_VECTOR(1 DOWNTO 0);
		CLOCK_50: IN STD_LOGIC;
		HEX7, HEX6, HEX5, HEX4, HEX3, HEX2: OUT STD_LOGIC_VECTOR(0 TO 6)
	);
end entity;

architecture arc of Main is

	SIGNAL clks: STD_LOGIC;
	SIGNAL ended: STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL HD, HU, HM, MD, MU, SD, SU : STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	COMPONENT counter is 
		generic (
			n : natural := 4
		);
		port (
			clock : in STD_LOGIC;
			reset_n : in STD_LOGIC;
			Atual : in STD_LOGIC_VECTOR(n-1 downto 0);
			ValMax : in STD_LOGIC_VECTOR(n-1 downto 0);
			Q : out STD_LOGIC_VECTOR(n-1 downto 0);
			ended : out STD_LOGIC
		); 
	end component;
	
	component seg IS
		PORT (  SW : IN std_logic_vector (3 DOWNTO 0) ;
		HEX0 : OUT std_logic_vector (0 TO 6) ) ;
	END component;
		
	component Clk IS
		PORT ( 
			CLOCK_50: IN STD_LOGIC;
			SEC: OUT STD_LOGIC);
	END component;
	
	
	begin
	
	PROCESS(HD, HM)
	begin
	
	IF(HD="0010") THEN
		HM <= "0100";
	ELSE
		HM <= "1010";
	END IF;
	
	end process;
	
	clk_50: Clk port map(CLOCK_50, clks);
		
	hour_dec: counter
		generic map( 4 )
		port map (ended(4), KEY(1), SW(15 DOWNTO 12), "0011", HD, ended(5));
	hour_uni: counter
		generic map( 4 )
		port map (ended(3), KEY(1), SW(11 DOWNTO 8), HM, HU, ended(4));
	
	min_dec: counter
		generic map( 4 )
		port map (ended(2), KEY(1), SW(7 DOWNTO 4), "0110", MD, ended(3));
	min_uni: counter
		generic map( 4 )
		port map (ended(1), KEY(1), SW(3 DOWNTO 0), "1010", MU, ended(2));
	
	sec_dec: counter
		generic map( 4 )
		port map (ended(0), KEY(1), "0000", "0110", SD, ended(1));
	sec_uni: counter
		generic map( 4 )
		port map (clks, KEY(1), "0000", "1010", SU, ended(0));
	
	h7: seg port map (HD, HEX7);
	h6: seg port map (HU, HEX6);
	h5: seg port map (MD, HEX5);
	h4: seg port map (MU, HEX4);
	h3: seg port map (SD, HEX3);
	h2: seg port map (SU, HEX2);
	
end arc;
