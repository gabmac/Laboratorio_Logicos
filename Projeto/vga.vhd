---	156061	Julio Alves Mesquita da Silva
---	160190	Leonardo Pedroso Vallin Rodrigues	
---	155416	Gabriel Bonani Machado
---	156169	Laura Marchione
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
use work.TicTacToe.ALL;

entity vga is
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
end vga;

architecture Behavioral of vga is

   COMPONENT sync_mod
          PORT( clk : IN std_logic;
                reset : IN std_logic;
                start : IN std_logic;
                y_control : OUT std_logic_vector(9 downto 0);
                x_control : OUT std_logic_vector(9 downto 0);
                h_s : OUT std_logic;
                v_s : OUT std_logic;
					 video_on : out STD_LOGIC );
   END COMPONENT;

  component velha is
    Port ( Clk, NewGame : in STD_LOGIC;
        Marcar : in STD_LOGIC;
        Linha, Coluna : in integer range 0 to 3;
        Valida : buffer STD_LOGIC := '1';
        ttt : buffer Tabuleiro;
        GameOver : buffer std_logic;
        Winner : buffer std_logic_vector(1 downto 0);
		  Turno : out std_logic
			);
	end component;
	
	
	signal rgb : std_logic_vector(2 downto 0);
  signal video,clk,NewGame, Marcar: std_logic;
	signal x_control, y_control : std_logic_vector(9 downto 0);
  signal x_pos : integer range 0 to 900;
  signal y_pos : integer range 0 to 900;
  signal Linha, Coluna: integer range 0 to 3;
  signal Winner : std_logic_vector(1 downto 0);
  signal data, tab: std_logic_vector(1 downto 0);
  
  SIGNAL ttt : Tabuleiro;

	begin

		process(CLOCK_50)
			variable temp : std_logic := '0';
			begin

				if(rising_edge(CLOCK_50)) then
					temp := not temp;
				end if;

				clk <= temp;
		end process;

		C2: sync_mod PORT MAP( clk, '0', '1', y_control, x_control, VGA_HS, VGA_VS, video );

    x_pos <= to_integer(unsigned(x_control));
    y_pos <= to_integer(unsigned(y_control));

	 
	 
		rgb <= NOT SW(15 downto 13);
	
		Linha <= 3 when (Winner(0) or Winner(1)) = '1' else
					2 when SW(5 downto 3) = "100" else
					1 when SW(5 downto 3) = "010" else
					0 when SW(5 downto 3) = "001" else
					3;
		Coluna <= 3 when (Winner(0) or Winner(1)) = '1' else 
					2 when SW(2 downto 0) = "100" else
					1 when SW(2 downto 0) = "010" else
					0 when SW(2 downto 0) = "001" else
					3;
		
		Marcar <= NOT KEY(0);
		
		NewGame <= NOT KEY(3);
	
		game: velha port map (CLOCK_50, NewGame, Marcar, Linha, Coluna, LEDG(0), ttt, LEDG(3), Winner, LEDR(0));

    process(x_pos, y_pos,ttt)
    variable aux : std_logic_vector(1 downto 0);
    begin
      aux := "00";
		
      if(y_pos >= 5 and y_pos < 475 and x_pos >= 10 and x_pos < 630) then
        if((x_pos >= 210 and x_pos < 220) or (x_pos >= 420 and x_pos < 430)) then
          aux := "11";
        elsif (y_pos >= 155 and y_pos < 165) or (y_pos >= 315 and y_pos < 325) then
          aux := "11";
		  elsif	(y_pos >= 30 and y_pos < 130 and x_pos >= 35 and x_pos < 185) then
			  aux := ttt(0)(0);
			elsif(y_pos >= 30 and y_pos < 130 and x_pos >= 245 and x_pos < 395) then
			  aux := ttt(0)(1);
			elsif(y_pos >= 30 and y_pos < 130 and x_pos >= 455 and x_pos < 605) then
			  aux := ttt(0)(2);
			elsif(y_pos >= 190 and y_pos < 290 and x_pos >= 35 and x_pos < 185) then
			  aux := ttt(1)(0);
			elsif(y_pos >= 190 and y_pos < 290 and x_pos >= 245 and x_pos < 395) then
			  aux := ttt(1)(1);
			elsif(y_pos >= 190 and y_pos < 290 and x_pos >= 455 and x_pos < 605) then
			  aux := ttt(1)(2);
			elsif(y_pos >= 350 and y_pos < 450 and x_pos >= 35 and x_pos < 185) then
			  aux := ttt(2)(0);
			elsif(y_pos >= 350 and y_pos < 450 and x_pos >= 245 and x_pos < 395) then
			  aux := ttt(2)(1);
			elsif(y_pos >= 350 and y_pos < 450 and x_pos >= 455 and x_pos < 605) then
			  aux := ttt(2)(2);
			end if;
      end if;
		
      
		
      tab <= aux;
    end process;

    data <= tab when video = '1' else "00";

		VGA_R <= (OTHERS => '0') when video = '0' else 
					(OTHERS => '1') when (data = "10" or data = "11" or Winner = "10") else (OTHERS => '0');
		VGA_G <= (OTHERS => '0') when video = '0' else 
					(OTHERS => '1') when (data = "11") else (OTHERS => '0');
		VGA_B <= (OTHERS => '0') when video = '0' else 
					(OTHERS => '1') when (data = "01" or data = "11" or Winner = "01") else (OTHERS => '0');

		VGA_CLK <= clk;
		VGA_BLANK_N<='1';
		VGA_SYNC_N<='0';


end Behavioral;
