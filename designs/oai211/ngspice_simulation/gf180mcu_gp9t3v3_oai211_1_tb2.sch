v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 1085 -668.75 1105 -668.75 {lab=A0}
N 1085 -648.75 1105 -648.75 {lab=A1}
N 1085.3125 -625.9375 1105.3125 -625.9375 {lab=B}
N 1085 -605.9375 1105 -605.9375 {lab=C}
N 1307.8125 -638.4375 1357.8125 -638.4375 {lab=out}
N 1105 -605.9375 1105.3125 -605.9375 {lab=C}
N 1353.4375 -638.4375 1395.9375 -638.4375 {lab=out}
N 1214.6875 -713.125 1214.6875 -703.125 {lab=VDD}
N 1213.4375 -578.75 1213.4375 -571.25 {lab=GND}
C {title.sym} 170 -40 0 0 {name=l1 author="Saputra Yudika Marpaung"}
C {vsource.sym} 1125 -460 0 0 {name=VS value=3.3 savecurrent=false}
C {gf180mcu_gp9t3v3_oai211_1.sym} 1135 -685 0 0 {name=x1}
C {vsource.sym} 1185 -460 0 0 {name=VA0 value=3.3 savecurrent=false}
C {vsource.sym} 1245 -460 0 0 {name=VA1 value=3.3 savecurrent=false}
C {vsource.sym} 1305 -460 0 0 {name=VB value=3.3 savecurrent=false}
C {vsource.sym} 1365 -460 0 0 {name=VC value=3.3 savecurrent=false}
C {vdd.sym} 1125 -490 0 0 {name=l2 lab=VDD}
C {gnd.sym} 1125 -430 0 0 {name=l3 lab=GND}
C {gnd.sym} 1185 -430 0 0 {name=l4 lab=GND}
C {gnd.sym} 1245 -430 0 0 {name=l5 lab=GND}
C {gnd.sym} 1305 -430 0 0 {name=l6 lab=GND}
C {gnd.sym} 1365 -430 0 0 {name=l7 lab=GND}
C {lab_pin.sym} 1185 -490 0 0 {name=p1_A0 sig_type=std_logic lab=A0}
C {lab_pin.sym} 1245 -490 0 0 {name=p2_A1 sig_type=std_logic lab=A1}
C {lab_pin.sym} 1305 -490 0 0 {name=p3_B sig_type=std_logic lab=B}
C {lab_pin.sym} 1365 -490 0 0 {name=p4_C sig_type=std_logic lab=C}
C {lab_pin.sym} 1085.625 -668.75 0 0 {name=p5_A0 sig_type=std_logic lab=A0}
C {lab_pin.sym} 1085 -648.75 0 0 {name=p6_A1 sig_type=std_logic lab=A1}
C {lab_pin.sym} 1085.625 -625.9375 0 0 {name=p7_B sig_type=std_logic lab=B}
C {lab_pin.sym} 1085 -605.9375 0 0 {name=p8_C sig_type=std_logic lab=C}
C {vdd.sym} 1214.6875 -713.125 0 0 {name=l9 lab=VDD}
C {gnd.sym} 1213.4375 -571.875 0 0 {name=l10 lab=GND}
C {lab_wire.sym} 1353.4375 -638.4375 3 0 {name=p1 sig_type=std_logic lab=out}
C {devices/code_shown.sym} 25 -180 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value="
.include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice typical
"}
C {devices/code_shown.sym} 5 -1195 0 0 {name=NGSPICE1 only_toplevel=true
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
alter @VA0[DC] = 0.0
alter @VA1[DC] = 0.0
alter @VB[DC] = 0.0
alter @VC[DC] = 0.0
alter @VA0[PULSE] = [ 3.3 0 0 $&tfr $&tfr $&tonA0 $&tperA0 0 ]
alter @VA1[PULSE] = [ 3.3 0 0 $&tfr $&tfr $&tonA1 $&tperA1 0 ]
alter @VB[PULSE] = [ 3.3 0 0 $&tfr $&tfr $&tonB $&tperB 0 ]
alter @VC[PULSE] = [ 3.3 0 0 $&tfr $&tfr $&tonC $&tperC 0 ]

** Simulations op
dc VA0 0 3.3 0.01
dc VA1 0 3.3 0.01
dc VB 0 3.3 0.01
dc VC 0 3.3 0.01
tran $&tstep $&tstop

**Measurement
let start_point = 0.001*tstop
  * Measure TPHL: input falling triggers output falling
  meas tran TPHL TRIG v(a0) VAL=0.5*3.3 RISE=1
  + TARG v(out) VAL=0.5*3.3 FALL=1
  + from=6.4u

  * Measure Fall Time: output from 90% to 10%
  meas tran Tfall TRIG v(out) VAL=0.9*3.3 FALL=1
  + TARG v(out) VAL=0.1*3.3 FALL=1
  + from=6.4u

meas tran Vpeak MAX v(out)
+ from=$&start_point

plot A0+16 A1+12 B+8 C+4 out

write /foss/designs/SSCS-Chipaton-2025_ChipiChapa/designs/oai211/gf180mcu_gp9t3v3__oai211_1_tb2.raw
.endc
"}
C {capa.sym} 1393.4375 -608.4375 0 0 {name=C1
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 1393.4375 -578.4375 0 0 {name=l8 lab=GND}
