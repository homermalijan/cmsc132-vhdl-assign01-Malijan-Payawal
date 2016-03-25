-------------------------------------------------------------------------------
-- File Name: tb_simple.vhdl
-- Program Description: Test Bench for Moore Machine Example
-- Reference: Lee, S. (2011). Introduction to VHDL. Singapore: Cengage
-- Learning Asia Pte Ltd
-------------------------------------------------------------------------------

-- Library Statements
library IEEE; use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Entity Definition
entity buzzer_tb is
	constant PERIOD1: time := 100 ns; -- clock period
end entity buzzer_tb;

architecture buzzer_tb of buzzer_tb is
	signal valid, boggie0, boggie1, bunce0, bunce1, bins0, bins1: std_logic;	-- data output from the state machine
	
	-- Component declaration
	component buzzer is
		 port (
			valid: out std_logic;
			boggie0: in std_logic;
			boggie1: in std_logic;
			bunce0: in std_logic;
			bunce1: in std_logic;
			bins0: in std_logic;
			bins1: in std_logic		
		);			
	end component buzzer;
begin	-- begin main body of the simple architecture
	-- instantiate the unit under test
	UUT: component buzzer port map(valid,'1','1','1','1','1','1');
	buzzer1: component buzzer port map(valid,'1','1','1','1','1','1');

	-- main process: generate test vectors and check results
	main: process is
		variable error_count: integer := 0; -- number of simulation errors
		variable expected_output: std_logic;
	begin
		report "Start simulation.";
		expected_output:='1';
		
		assert(expected_output = valid)
			report "ERROR: expected valid " & std_logic'image(valid);
		
		if(expected_output /= valid	)
			then error_count := error_count + 1;
		end if;

		-- check if there are errors
		if(error_count=0) then
			report "Simulation completed with NO errors.";
		else
			report "ERROR: There were " &
					integer'image(error_count) & " errors.";
		end if;

		wait;		-- halt this process (note: simulation
	end process;
end architecture buzzer_tb;

