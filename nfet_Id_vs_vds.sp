.include 'asap7_TT_slvt.sp'

.global vdd! gnd!

.SUBCKT nfet in out
	nmos_finfet gnd! in out gnd! BSIMCMG_osdi_N l=7e-009 nfin=14
.ENDS

v1 vdd! gnd dc=0
v2 gnd! gnd dc=0
v3 nfet_in gnd dc=0

R1 vdd! nfet_out 1k
Xnfet1 nfet_in nfet_out nfet

.dc v1 0 3 0.5m v3 0 1 0.2

.control
    pre_osdi bsimcmg.osdi
    run
    let vres=-nfet_out+vdd!
    let Id=vres/1000
    plot Id 
    
    set xbrushwidth=3
.endc

.end
