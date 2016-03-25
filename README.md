# cmsc132-vhdl-assign01-Malijan-Payawal

to run:

ghdl -a t2l-malijan-payawal.vhdl && ghdl -e buzzer
ghdl -a t2l-malijan-payawal-tb.vhdl && ghdl -e buzzer_tb
ghdl -r buzzer_tb --vcd=try.vcd
