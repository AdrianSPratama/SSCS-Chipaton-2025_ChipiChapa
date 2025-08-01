v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 1637.5 -377.5 1657.5 -377.5 {lab=out}
N 1657.5 -377.5 1687.5 -377.5 {lab=out}
N 1687.5 -377.5 1697.5 -377.5 {lab=out}
C {devices/code_shown.sym} 0 -1320 0 0 {name=NGSPICE1 only_toplevel=true
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
alter @VA0[PULSE] = [ 0 3.3 0 $&tfr $&tfr $&tonA0 $&tperA0 0 ]
alter @VA1[PULSE] = [ 0 3.3 0 $&tfr $&tfr $&tonA1 $&tperA1 0 ]
alter @VB[PULSE] = [ 0 3.3 0 $&tfr $&tfr $&tonB $&tperB 0 ]
alter @VC[PULSE] = [ 0 3.3 0 $&tfr $&tfr $&tonC $&tperC 0 ]

** Simulations op
** dc VA0 0 3.3 0.01
** dc VA1 0 3.3 0.01
** dc VB 0 3.3 0.01
** dc VC 0 3.3 0.01
tran $&tstep $&tstop

let start_point = 0.001*tstop

* Measure TPLH: input rising triggers output rising
  meas tran TPLH TRIG v(a0) VAL=0.5*3.3 FALL=1
  + TARG v(out) VAL=0.5*3.3 RISE=1
  + from=6u

  * Measure Rise Time: output from 10% to 90%
  meas tran Trise TRIG v(out) VAL=0.1*3.3 RISE=LAST
  + TARG v(out) VAL=0.9*3.3 RISE=lAST
  + from=$&start_point

meas tran Vpeak MAX v(out)
+ from=$&start_point
plot A0+16 A1+12 B+8 C+4 out

write /foss/designs/SSCS-Chipaton-2025_ChipiChapa/designs/aoi211/gf180mcu_gp9t3v3__aoi211_1_tb.raw
.endc
"}
C {devices/code_shown.sym} 0 -90 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value="
.include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice typical
"}
C {vsource.sym} 1160 -120 0 0 {name=VA0 value=3.3 savecurrent=false}
C {vsource.sym} 1220 -120 0 0 {name=VA1 value=3.3 savecurrent=false}
C {vsource.sym} 1280 -120 0 0 {name=VB value=3.3 savecurrent=false}
C {vsource.sym} 1340 -120 0 0 {name=VC value=3.3 savecurrent=false}
C {vsource.sym} 1100 -120 0 0 {name=VS value=3.3 savecurrent=false}
C {gnd.sym} 1340 -90 0 0 {name=l6 lab=GND}
C {gnd.sym} 1280 -90 0 0 {name=l7 lab=GND}
C {gnd.sym} 1220 -90 0 0 {name=l8 lab=GND}
C {gnd.sym} 1160 -90 0 0 {name=l9 lab=GND}
C {gnd.sym} 1100 -90 0 0 {name=l10 lab=GND}
C {vdd.sym} 1100 -150 0 0 {name=l11 lab=VDD}
C {lab_wire.sym} 1280 -150 0 0 {name=p6 sig_type=std_logic lab=B}
C {lab_wire.sym} 1160 -150 0 0 {name=p7 sig_type=std_logic lab=A0}
C {lab_wire.sym} 1340 -150 0 0 {name=p9 sig_type=std_logic lab=C}
C {lab_wire.sym} 1220 -150 0 0 {name=p10 sig_type=std_logic lab=A1}
C {lab_wire.sym} 1440 -407.5 0 0 {name=p1 sig_type=std_logic lab=A1}
C {lab_wire.sym} 1440 -427.5 0 0 {name=p2 sig_type=std_logic lab=A0}
C {lab_wire.sym} 1440 -377.5 0 0 {name=p3 sig_type=std_logic lab=B}
C {lab_wire.sym} 1440 -348.75 0 0 {name=p4 sig_type=std_logic lab=C}
C {vdd.sym} 1538.75 -466.25 0 0 {name=l2 lab=VDD}
C {gnd.sym} 1538.75 -286.25 0 0 {name=l3 lab=GND}
C {lab_wire.sym} 1697.5 -377.5 1 0 {name=p11 sig_type=std_logic lab=out}
C {SSCS-Chipaton-2025_ChipiChapa/designs/aoi211/gf180mcu_osu_sc_gp9t3v3_aoi211_1.sym} 1467.5 -447.5 0 0 {name=x211aoi1}
C {capa.sym} 1697.5 -347.5 0 0 {name=C1
m=1
value=0.001p
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 1697.5 -317.5 0 0 {name=l1 lab=GND}
