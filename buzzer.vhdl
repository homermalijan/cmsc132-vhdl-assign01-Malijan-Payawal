-- Library Statements
library IEEE; use IEEE.std_logic_1164.all;

-- Entity Definition
entity buzzer is
	port (
		valid: out std_logic;
		boggis0: in std_logic;
		boggis1: in std_logic;
		bunce0: in std_logic;
		bunce1: in std_logic;
		bean0: in std_logic;
		bean1: in std_logic		
	);			
end entity buzzer;

architecture buzzer of buzzer is
begin
	valid <= (boggie0 or boggie1)or(bunce0 or bunce1)or(bins0 or bins1);
end architecture buzzer;

