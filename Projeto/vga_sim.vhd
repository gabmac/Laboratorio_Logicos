library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_textio.all;
library std;
use std.textio.all;

entity vga_sim is
	port(
		Clock : IN STD_LOGIC;
		SW 	: IN STD_LOGIC_VECTOR(17 DOWNTO 0)
		);
end vga_sim;

architecture Structural of vga_sim is

	component vga is
		Port ( CLOCK_50 : in STD_LOGIC;
           SW : in STD_LOGIC_VECTOR (17 downto 0);
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

	signal Red, Green, Blue : std_logic_vector(7 downto 0);
	signal hsync, vsync, clk, blank, sync : std_logic;

	begin

	vgaport: vga port map (Clock, SW, Red, Green, Blue, clk, blank, hsync, vsync, sync);

	process (clk)
		 file file_pointer: text is out "write.txt";
		 variable line_el: line;

	begin

		 if rising_edge(clk) then

			  -- Write the time
			  write(line_el, now); -- write the line.
			  write(line_el, string'(":")); -- write the line.

			  -- Write the hsync
			  write(line_el, string'(" "));
			  write(line_el, hsync); -- write the line.

			  -- Write the vsync
			  write(line_el, string'(" "));
			  write(line_el, vsync); -- write the line.

			  -- Write the red
			  write(line_el, string'(" "));
			  write(line_el, Red); -- write the line.

			  -- Write the green
			  write(line_el, string'(" "));
			  write(line_el, Green); -- write the line.

			  -- Write the blue
			  write(line_el, string'(" "));
			  write(line_el, Blue); -- write the line.

			  writeline(file_pointer, line_el); -- write the contents into the file.

		 end if;
	end process;
end Structural;
