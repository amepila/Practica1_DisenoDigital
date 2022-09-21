onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group top /tb_alu/UUT/clk
add wave -noupdate -expand -group top /tb_alu/UUT/rst
add wave -noupdate -expand -group top /tb_alu/UUT/load1
add wave -noupdate -expand -group top /tb_alu/UUT/load2
add wave -noupdate -expand -group top /tb_alu/UUT/i_control
add wave -noupdate -expand -group top /tb_alu/UUT/i_num
add wave -noupdate -expand -group top /tb_alu/UUT/o_zero
add wave -noupdate -expand -group top /tb_alu/UUT/o_ready
add wave -noupdate -expand -group top /tb_alu/UUT/o_overflow
add wave -noupdate -expand -group top /tb_alu/UUT/o_carry
add wave -noupdate -expand -group top /tb_alu/UUT/o_negative
add wave -noupdate -expand -group top -color Blue /tb_alu/UUT/o_result
add wave -noupdate -expand -group top /tb_alu/UUT/o_segments
add wave -noupdate -expand -group top /tb_alu/UUT/w_topwires
add wave -noupdate -group pipo_a /tb_alu/UUT/PIPO_A/clk
add wave -noupdate -group pipo_a /tb_alu/UUT/PIPO_A/rst
add wave -noupdate -group pipo_a /tb_alu/UUT/PIPO_A/en
add wave -noupdate -group pipo_a /tb_alu/UUT/PIPO_A/i_data
add wave -noupdate -group pipo_a /tb_alu/UUT/PIPO_A/o_data
add wave -noupdate -group pipo_b /tb_alu/UUT/PIPO_B/clk
add wave -noupdate -group pipo_b /tb_alu/UUT/PIPO_B/rst
add wave -noupdate -group pipo_b /tb_alu/UUT/PIPO_B/en
add wave -noupdate -group pipo_b /tb_alu/UUT/PIPO_B/i_data
add wave -noupdate -group pipo_b /tb_alu/UUT/PIPO_B/o_data
add wave -noupdate -group pipo_ctrl /tb_alu/UUT/PIPO_CTRL/clk
add wave -noupdate -group pipo_ctrl /tb_alu/UUT/PIPO_CTRL/rst
add wave -noupdate -group pipo_ctrl /tb_alu/UUT/PIPO_CTRL/en
add wave -noupdate -group pipo_ctrl /tb_alu/UUT/PIPO_CTRL/i_data
add wave -noupdate -group pipo_ctrl /tb_alu/UUT/PIPO_CTRL/o_data
add wave -noupdate -group control /tb_alu/UUT/CONTROL/clk
add wave -noupdate -group control /tb_alu/UUT/CONTROL/rst
add wave -noupdate -group control /tb_alu/UUT/CONTROL/i_load1
add wave -noupdate -group control /tb_alu/UUT/CONTROL/i_load2
add wave -noupdate -group control /tb_alu/UUT/CONTROL/i_ready
add wave -noupdate -group control /tb_alu/UUT/CONTROL/o_enableA
add wave -noupdate -group control /tb_alu/UUT/CONTROL/o_enableB
add wave -noupdate -group control /tb_alu/UUT/CONTROL/o_selector
add wave -noupdate -group control /tb_alu/UUT/CONTROL/o_start
add wave -noupdate -group control /tb_alu/UUT/CONTROL/o_ready
add wave -noupdate -group control /tb_alu/UUT/CONTROL/r_state
add wave -noupdate -group alu /tb_alu/UUT/ALU/i_numberA
add wave -noupdate -group alu /tb_alu/UUT/ALU/i_numberB
add wave -noupdate -group alu /tb_alu/UUT/ALU/control
add wave -noupdate -group alu /tb_alu/UUT/ALU/enable
add wave -noupdate -group alu /tb_alu/UUT/ALU/o_result
add wave -noupdate -group alu /tb_alu/UUT/ALU/o_zero
add wave -noupdate -group alu /tb_alu/UUT/ALU/o_ready
add wave -noupdate -group alu /tb_alu/UUT/ALU/o_overflow
add wave -noupdate -group alu /tb_alu/UUT/ALU/o_carry
add wave -noupdate -group alu /tb_alu/UUT/ALU/o_negative
add wave -noupdate -group pipo_flags /tb_alu/UUT/PIPO_FLAGS/clk
add wave -noupdate -group pipo_flags /tb_alu/UUT/PIPO_FLAGS/rst
add wave -noupdate -group pipo_flags /tb_alu/UUT/PIPO_FLAGS/en
add wave -noupdate -group pipo_flags /tb_alu/UUT/PIPO_FLAGS/i_data
add wave -noupdate -group pipo_flags /tb_alu/UUT/PIPO_FLAGS/o_data
add wave -noupdate -group pipo_out /tb_alu/UUT/PIPO_OUT/clk
add wave -noupdate -group pipo_out /tb_alu/UUT/PIPO_OUT/rst
add wave -noupdate -group pipo_out /tb_alu/UUT/PIPO_OUT/en
add wave -noupdate -group pipo_out /tb_alu/UUT/PIPO_OUT/i_data
add wave -noupdate -group pipo_out /tb_alu/UUT/PIPO_OUT/o_data
add wave -noupdate -group displays /tb_alu/UUT/DISPLAY/clk
add wave -noupdate -group displays /tb_alu/UUT/DISPLAY/rst
add wave -noupdate -group displays /tb_alu/UUT/DISPLAY/i_start
add wave -noupdate -group displays /tb_alu/UUT/DISPLAY/i_bin
add wave -noupdate -group displays /tb_alu/UUT/DISPLAY/o_seg
add wave -noupdate -group displays /tb_alu/UUT/DISPLAY/w_display
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {128 ns}
