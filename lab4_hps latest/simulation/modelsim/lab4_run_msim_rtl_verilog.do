transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/julam5/Desktop/181_Lab4_current/lab4_hps {/home/julam5/Desktop/181_Lab4_current/lab4_hps/sdram_master_lab4.v}

