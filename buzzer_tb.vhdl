library IEEE; use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity buzzer_tb is
	constant DELAY: time := 10 ns;		-- delay value in testing
end entity buzzer_tb;

architecture tb of buzzer_tb is
	signal valid: std_logic;
	signal boggis0: std_logic;
	signal boggis1: std_logic;
	signal bunce0: std_logic;
	signal bunce1: std_logic;
	signal bean0: std_logic;
	signal bean1: std_logic;		
		
	component buzzer is
		port (
		valid: out std_logic;
		boggis0: in std_logic;
		boggis1: in std_logic;
		bunce0: in std_logic;
		bunce1: in std_logic;
		bean0: in std_logic;
		bean1: in std_logic		
		);	
	end component buzzer;
	
begin	--begin main bodu of the tb architecture
	--instantiate the unit under test
	UUT: component buzzer port map(valid, boggis0, boggis1, bunce0, bunce1, bean0, bean1);
	
	--main process: generate test vestores and check results
	main: process is
		variable temp: unsigned(5 downto 0);	--used in calculations
		variable expected_valid: std_logic;
		variable error_count: integer := 0; --number if simulation errors
		
		begin
			report "Start simulation.";
			
			--generate all possible input values, since max = 15
			for count in 0 to 63 loop
				temp := TO_UNSIGNED(count,6);
				boggis0 <= std_logic(temp(0)); 		--boggis in
				boggis1 <= std_logic(temp(1)); 		--boggis out
				bunce0 <= std_logic(temp(2));		--bunce in
				bunce1 <= std_logic(temp(3));		--bunce out
				bean0 <= std_logic(temp(4));		--bean in
				bean1 <= std_logic(temp(5));		--bean out
				
				--compute expected values
				if(count=0) then
					expected_valid := '0';		--all zero
				elsif (boggis0 = '1' and (boggis1 = '1' or bunce1 = '1' or bean1 = '1')) then	
					expected_valid := '1';		--boggis in and atleast 1 out = valid
				elsif (boggis1 = '1' and (bunce0 = '1' or bean0 = '1')) then 
					expected_valid := '1';		--boggis out and bunce or bean is in
				elsif (bunce0 = '1' and (bunce1 = '1' or bean1 = '1')) then
					expected_valid := '1';		--bunce in and bunce or bean out no need to check boggis
				elsif(bunce1 = '1' and bean0 = '1') then
					expected_valid := '1';		--bunce out and bean in
				elsif(bean0 = '1' and bean1 = '1') then
					expected_valid := '1';		--bean in and out
				else
					expected_valid := '0';		-- all off				
				end if; 
				
				wait for DELAY; 
				
				-- check if output of circuit is same with expected value
				assert(expected_valid = valid)
					--report "temp is" & unsigned'image(temp);
					report "ERROR: Expected valid " &
						std_logic'image(expected_valid) & " and actual " &
						std_logic'image(valid) & " at count " &
						integer'image(count);
						
				-- increment number of errors		
				if(expected_valid/=valid) then
					error_count := error_count + 1;
				end if;
			end loop;
			
			wait for DELAY;
			
			-- report errors
			assert(error_count=0)
				report "ERROR: There were " &
					integer'image(error_count) & " errors!";
					
			-- if there are no errors		
			if(error_count = 0) then
				 report "Simulation completed with NO errors.";
			end if;
			
			wait; -- terminate the simulation
		end process;
end architecture tb;

--ghdl -a buzzer.vhdl && ghdl -e buzzer
--ghdl -a buzzer_tb.vhdl && ghdl -e buzzer_tb
--ghdl -r buzzer_tb --vcd=try.vcd
-- gtkwave try.vcd
