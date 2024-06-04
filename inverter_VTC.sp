.include 'asap7_TT_slvt.sp'

.global vdd! gnd!

.SUBCKT nfet in out
	n_pmos_finfet Vdd! in out vdd! BSIMCMG_osdi_P l=7e-009 nfin=14
	n_nmos_finfet gnd! in out gnd! BSIMCMG_osdi_N l=7e-009 nfin=14
.ENDS

v1 vdd! gnd dc=0.7
v2 gnd! gnd dc=0
v3 nfet_in gnd pulse(0 0.7 20p 10p 10p 20p 500p 1)
 
Xnfet1 nfet_in nfet_out nfet

.dc v3 0 0.7 1m 
*.tran 0.1p 100p


.control
    pre_osdi bsimcmg.osdi
    run
    set xbrushwidth=3
    plot nfet_out nfet_in
    meas dc v_th when nfet_out=nfet_in
.endc

.end
