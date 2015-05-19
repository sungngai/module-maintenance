transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/module\ maintenance/pllnrst {E:/module maintenance/pllnrst/pllnrst.v}
vlog -vlog01compat -work work +incdir+E:/module\ maintenance/pllnrst {E:/module maintenance/pllnrst/pll.v}
vlog -vlog01compat -work work +incdir+E:/module\ maintenance/pllnrst/db {E:/module maintenance/pllnrst/db/pll_altpll.v}

vlog -vlog01compat -work work +incdir+E:/module\ maintenance/pllnrst/simulation/modelsim {E:/module maintenance/pllnrst/simulation/modelsim/pllnrst.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L cycloneiii_ver -L rtl_work -L work -voptargs="+acc" pllnrst_vlg_tst

add wave *
view structure
view signals
run -all
