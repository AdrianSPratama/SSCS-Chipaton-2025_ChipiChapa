v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 1777.5 -317.5 1797.5 -317.5 {lab=out}
N 1797.5 -317.5 1827.5 -317.5 {lab=out}
N 1827.5 -317.5 1837.5 -317.5 {lab=out}
C {devices/code_shown.sym} 10 -1410 0 0 {name=NGSPICE1 only_toplevel=true
value="
.control
save all
** Define input signal
let fsig = 1Meg
let tperA0 = 1/fsig
let tperA1 = 2*tperA0
let tperB = 4*tperA0
let tperC = 8*tperA0
let tfr = 0.01*tperA0
let tonA0 = 0.5*tperA0-tfr
let tonA1 = 0.5*tperA1-tfr
let tonB = 0.5*tperB-tfr
let tonC = 0.5*tperC-tfr

** Define transient params
let tstop = 8*tperA0
let tstep = 0.001*tperA0

** Set Sources
** alter @VA0[DC] = 0.0
** alter @VA1[DC] = 0.0
** alter @VB[DC] = 0.0
** alter @VC[DC] = 0.0
alter @VA0[PULSE] = [ 3.3 0 0 $&tfr $&tfr $&tonA0 $&tperA0 0 ]
alter @VA1[PULSE] = [ 3.3 0 0 $&tfr $&tfr $&tonA1 $&tperA1 0 ]
alter @VB[PULSE] = [ 3.3 0 0 $&tfr $&tfr $&tonB $&tperB 0 ]
alter @VC[PULSE] = [ 3.3 0 0 $&tfr $&tfr $&tonC $&tperC 0 ]

** Simulations op
** dc VA0 0 3.3 0.01
** dc VA1 0 3.3 0.01
** dc VB 0 3.3 0.01
** dc VC 0 3.3 0.01
tran $&tstep $&tstop

let start_point = 0.001*tstop
	
  * Measure TPHL: input falling triggers output falling
  meas tran TPHL TRIG v(a0) VAL=1.65 RISE=1
  + TARG v(out) VAL=1.65 FALL=1
  + from=1.4u

  * Measure Fall Time: output from 90% to 10%
  meas tran Tfall TRIG v(out) VAL=2.97 FALL=1
  + TARG v(out) VAL=0.33 FALL=1
  + from=1.4u

meas tran Vpeak MAX v(out)
+ from=$&start_point
plot A0+16 A1+12 B+8 C+4 out 1.65 17.65

write /foss/designs/SSCS-Chipaton-2025_ChipiChapa/designs/aoi211/gf180mcu_gp9t3v3__aoi211_1_tb_2.raw
.endc
"}
C {devices/code_shown.sym} 0 -80 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value="
.include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice typical
"}
C {vsource.sym} 1260 -140 0 0 {name=VA0 value=3.3 savecurrent=false}
C {vsource.sym} 1320 -140 0 0 {name=VA1 value=3.3 savecurrent=false}
C {vsource.sym} 1380 -140 0 0 {name=VB value=3.3 savecurrent=false}
C {vsource.sym} 1440 -140 0 0 {name=VC value=3.3 savecurrent=false}
C {vsource.sym} 1200 -140 0 0 {name=VS value=3.3 savecurrent=false}
C {gnd.sym} 1440 -110 0 0 {name=l6 lab=GND}
C {gnd.sym} 1380 -110 0 0 {name=l7 lab=GND}
C {gnd.sym} 1320 -110 0 0 {name=l8 lab=GND}
C {gnd.sym} 1260 -110 0 0 {name=l9 lab=GND}
C {gnd.sym} 1200 -110 0 0 {name=l10 lab=GND}
C {vdd.sym} 1200 -170 0 0 {name=l11 lab=VDD}
C {lab_wire.sym} 1380 -170 0 0 {name=p6 sig_type=std_logic lab=B}
C {lab_wire.sym} 1260 -170 0 0 {name=p7 sig_type=std_logic lab=A0}
C {lab_wire.sym} 1440 -170 0 0 {name=p9 sig_type=std_logic lab=C}
C {lab_wire.sym} 1320 -170 0 0 {name=p10 sig_type=std_logic lab=A1}
C {lab_wire.sym} 1580 -347.5 0 0 {name=p1 sig_type=std_logic lab=A1}
C {lab_wire.sym} 1580 -367.5 0 0 {name=p2 sig_type=std_logic lab=A0}
C {lab_wire.sym} 1580 -317.5 0 0 {name=p3 sig_type=std_logic lab=B}
C {lab_wire.sym} 1580 -288.75 0 0 {name=p4 sig_type=std_logic lab=C}
C {vdd.sym} 1678.75 -406.25 0 0 {name=l2 lab=VDD}
C {gnd.sym} 1678.75 -226.25 0 0 {name=l3 lab=GND}
C {lab_wire.sym} 1837.5 -317.5 1 0 {name=p11 sig_type=std_logic lab=out}
C {SSCS-Chipaton-2025_ChipiChapa/designs/aoi211/gf180mcu_osu_sc_gp9t3v3_aoi211_1.sym} 1607.5 -387.5 0 0 {name=x211aoi1}
C {capa.sym} 1837.5 -287.5 0 0 {name=C1
m=1
value=0.001p
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 1837.5 -257.5 0 0 {name=l1 lab=GND}
