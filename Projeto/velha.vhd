library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

package TicTacToe is
  type rTabuleiro is array(0 to 2) of std_logic_vector(1 downto 0);
  type Tabuleiro is array(0 to 2) of rTabuleiro;
end package;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
use work.TicTacToe.ALL;

entity velha is
    Port ( Clk, NewGame : in STD_LOGIC;
        Marcar : in STD_LOGIC;
        Linha, Coluna : in integer range 0 to 3;
        Valida : buffer STD_LOGIC := '1';
        ttt : buffer Tabuleiro;
        GameOver : buffer std_logic;
        Winner : buffer std_logic_vector(1 downto 0);
		  Turno : out std_logic
			);
end velha;

architecture Behavioral of velha is
  signal marcar_sync : std_logic := '0';
    begin
      process(Clk, Marcar, marcar_sync, NewGame)
		variable turno_a : std_logic := '0';
		variable ttt_a : Tabuleiro;
		variable winner_a : std_logic_vector(1 downto 0);
      begin
		if(rising_edge(Clk)) then
		  if (NewGame = '1') then
				ttt_a(0)(0) :=  "00";
				ttt_a(0)(1) :=  "00";
				ttt_a(0)(2) :=  "00";
				ttt_a(1)(0) :=  "00";
				ttt_a(1)(1) :=  "00";
				ttt_a(1)(2) :=  "00";
				ttt_a(2)(0) :=  "00";
				ttt_a(2)(1) :=  "00";
				ttt_a(2)(2) :=  "00";
				
				winner_a := "00";
				GameOver <= '0';
				turno_a := '0';
				Valida <= '0';
			end if;
        if((Marcar = '1') and (not (Linha = 3)) and (not (Coluna = 3)) and (winner_a = "00")) then
          if(ttt(Linha)(Coluna) = "00") then
            Valida <= '1';
            if(turno_a = '0') then
              ttt_a(Linha)(Coluna) := "01";
				  turno_a := '1';
            else
              ttt_a(Linha)(Coluna) := "10";
				  turno_a := '0';
            end if;
          else
            Valida <= '0';
          end if;
			 
        end if;
		  --- Verifica vitoria player 1
		  if((ttt(0)(0) = "01" and ttt(0)(1) = "01" and ttt(0)(2) = "01")) then
				winner_a := "01";
			elsif ((ttt(1)(0) = "01" and ttt(1)(1) = "01" and ttt(1)(2) = "01")) then
				winner_a := "01";
			elsif ((ttt(2)(0) = "01" and ttt(2)(1) = "01" and ttt(2)(2) = "01")) then
				winner_a := "01";
			elsif ((ttt(0)(0) = "01" and ttt(1)(0) = "01" and ttt(2)(0) = "01")) then
				winner_a := "01";
			elsif ((ttt(0)(1) = "01" and ttt(1)(1) = "01" and ttt(2)(1) = "01")) then
				winner_a := "01";
			elsif ((ttt(0)(2) = "01" and ttt(1)(2) = "01" and ttt(2)(2) = "01")) then
				winner_a := "01";
			elsif ((ttt(0)(0) = "01" and ttt(1)(1) = "01" and ttt(2)(2) = "01")) then
				winner_a := "01";
			elsif ((ttt(0)(2) = "01" and ttt(1)(1) = "01" and ttt(2)(0) = "01")) then
				winner_a := "01";
			--- Verifica vitoria player 2
		  elsif((ttt(0)(0) = "10" and ttt(0)(1) = "10" and ttt(0)(2) = "10")) then
				winner_a := "10";
			elsif ((ttt(1)(0) = "10" and ttt(1)(1) = "10" and ttt(1)(2) = "10")) then
				winner_a := "10";
			elsif ((ttt(2)(0) = "10" and ttt(2)(1) = "10" and ttt(2)(2) = "10")) then
				winner_a := "10";
			elsif ((ttt(0)(0) = "10" and ttt(1)(0) = "10" and ttt(2)(0) = "10")) then
				winner_a := "10";
			elsif ((ttt(0)(1) = "10" and ttt(1)(1) = "10" and ttt(2)(1) = "10")) then
				winner_a := "10";
			elsif ((ttt(0)(2) = "10" and ttt(1)(2) = "10" and ttt(2)(2) = "10")) then
				winner_a := "10";
			elsif ((ttt(0)(0) = "10" and ttt(1)(1) = "10" and ttt(2)(2) = "10")) then
				winner_a := "10";
			elsif ((ttt(0)(2) = "10" and ttt(1)(1) = "10" and ttt(2)(0) = "10")) then
				winner_a := "10";
				
			--- Nenhum vencedor
			else
				winner_a := "00";
				
			end if;
			
		 end if;
		 Winner <= winner_a;
		 ttt <= ttt_a;
		 Turno <= turno_a;
      end process;
end Behavioral;
