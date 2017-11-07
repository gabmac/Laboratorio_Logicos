---	156061	Julio Alves Mesquita da Silva
---	160190	Leonardo Pedroso Vallin Rodrigues	
---	155416	Gabriel Bonani Machado
---	156169	Laura Marchione
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
use work.TicTacToe.ALL;

entity Main is
    Port ( CLOCK_50 : in STD_LOGIC;
           SW : in STD_LOGIC_VECTOR (17 downto 0);
			  KEY : in STD_LOGIC_VECTOR(3 DOWNTO 0);
			  LEDR : out STD_LOGIC_VECTOR(17 DOWNTO 0);
			  LEDG : out STD_LOGIC_VECTOR(3 DOWNTO 0);
			  VGA_R : out STD_LOGIC_Vector (7 downto 0);
			  VGA_G : out STD_LOGIC_Vector (7 downto 0);
			  VGA_B : out STD_LOGIC_Vector (7 downto 0);
			  VGA_CLK : out STD_LOGIC;
			  VGA_BLANK_N : out STD_LOGIC;
			  VGA_HS : out STD_LOGIC;
			  VGA_vS : out STD_LOGIC;
			  VGA_SYNC_N : out STD_LOGIC
			);
end Main;

architecture Behavioral of Main is

	component vga is
		 Port ( CLOCK_50 : in STD_LOGIC;
				  SW : in STD_LOGIC_VECTOR (17 downto 0);
				  KEY : in STD_LOGIC_VECTOR(3 DOWNTO 0);
				  LEDR : out STD_LOGIC_VECTOR(17 DOWNTO 0);
				  LEDG : out STD_LOGIC_VECTOR(3 DOWNTO 0);
				  VGA_R : out STD_LOGIC_Vector (7 downto 0);
				  VGA_G : out STD_LOGIC_Vector (7 downto 0);
				  VGA_B : out STD_LOGIC_Vector (7 downto 0);
				  VGA_CLK : out STD_LOGIC;
				  VGA_BLANK_N : out STD_LOGIC;
				  VGA_HS : out STD_LOGIC;
				  VGA_vS : out STD_LOGIC;
				  VGA_SYNC_N : out STD_LOGIC
				);
	end component;
	begin
	
	vga_ttt: vga port map (CLOCK_50, SW, KEY, LEDR, LEDG, VGA_R, VGA_G, VGA_B, VGA_CLK, VGA_BLANK_N, VGA_HS, VGA_vs, VGA_SYNC_N);
	
end Behavioral;
