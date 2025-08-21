v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 1035 -748.75 1055 -748.75 {lab=A0}
N 1035 -728.75 1055 -728.75 {lab=A1}
N 1035.3125 -705.9375 1055.3125 -705.9375 {lab=B}
N 1035 -685.9375 1055 -685.9375 {lab=C}
N 1257.8125 -718.4375 1307.8125 -718.4375 {lab=out}
N 1055 -685.9375 1055.3125 -685.9375 {lab=C}
N 1303.4375 -718.4375 1345.9375 -718.4375 {lab=out}
N 1164.6875 -793.125 1164.6875 -783.125 {lab=VDD}
N 1163.4375 -658.75 1163.4375 -651.25 {lab=GND}
C {title.sym} 160 -40 0 0 {name=l1 author="Saputra Yudika Marpaung"}
C {vsource.sym} 1075 -540 0 0 {name=VS value=3.3 savecurrent=false}
C {gf180mcu_gp9t3v3_oai211_1.sym} 1085 -765 0 0 {name=x1}
C {vsource.sym} 1135 -540 0 0 {name=VA0 value=3.3 savecurrent=false}
C {vsource.sym} 1195 -540 0 0 {name=VA1 value=3.3 savecurrent=false}
C {vsource.sym} 1255 -540 0 0 {name=VB value=3.3 savecurrent=false}
C {vsource.sym} 1315 -540 0 0 {name=VC value=3.3 savecurrent=false}
C {vdd.sym} 1075 -570 0 0 {name=l2 lab=VDD}
C {gnd.sym} 1075 -510 0 0 {name=l3 lab=GND}
C {gnd.sym} 1135 -510 0 0 {name=l4 lab=GND}
C {gnd.sym} 1195 -510 0 0 {name=l5 lab=GND}
C {gnd.sym} 1255 -510 0 0 {name=l6 lab=GND}
C {gnd.sym} 1315 -510 0 0 {name=l7 lab=GND}
C {lab_pin.sym} 1135 -570 0 0 {name=p1_A0 sig_type=std_logic lab=A0}
C {lab_pin.sym} 1195 -570 0 0 {name=p2_A1 sig_type=std_logic lab=A1}
C {lab_pin.sym} 1255 -570 0 0 {name=p3_B sig_type=std_logic lab=B}
C {lab_pin.sym} 1315 -570 0 0 {name=p4_C sig_type=std_logic lab=C}
C {lab_pin.sym} 1035.625 -748.75 0 0 {name=p5_A0 sig_type=std_logic lab=A0}
C {lab_pin.sym} 1035 -728.75 0 0 {name=p6_A1 sig_type=std_logic lab=A1}
C {lab_pin.sym} 1035.625 -705.9375 0 0 {name=p7_B sig_type=std_logic lab=B}
C {lab_pin.sym} 1035 -685.9375 0 0 {name=p8_C sig_type=std_logic lab=C}
C {vdd.sym} 1164.6875 -793.125 0 0 {name=l9 lab=VDD}
C {gnd.sym} 1163.4375 -651.875 0 0 {name=l10 lab=GND}
C {lab_wire.sym} 1303.4375 -718.4375 3 0 {name=p1 sig_type=std_logic lab=out}
C {devices/code_shown.sym} 15 -180 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value="
.include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice typical
"}
C {devices/code_shown.sym} 15 -1205 0 0 {name=NGSPICE1 only_toplevel=true
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
alter @VA0[PULSE] = [ 0 3.3 0 $&tfr $&tfr $&tonA0 $&tperA0 0 ]
alter @VA1[PULSE] = [ 0 3.3 0 $&tfr $&tfr $&tonA1 $&tperA1 0 ]
alter @VB[PULSE] = [ 0 3.3 0 $&tfr $&tfr $&tonB $&tperB 0 ]
alter @VC[PULSE] = [ 0 3.3 0 $&tfr $&tfr $&tonC $&tperC 0 ]

** Simulations op
dc VA0 0 3.3 0.01
dc VA1 0 3.3 0.01
dc VB 0 3.3 0.01
dc VC 0 3.3 0.01
tran $&tstep $&tstop

**Measurement
let start_point = 0.001*tstop

* Measure TPLH: input rising triggers output rising
  meas tran TPLH TRIG v(a0) VAL=0.5*3.3 FALL=1
  + TARG v(out) VAL=0.5*3.3 RISE=1
  + from=1u

  * Measure Rise Time: output from 10% to 90%
  meas tran Trise TRIG v(out) VAL=0.1*3.3 RISE=LAST
  + TARG v(out) VAL=0.9*3.3 RISE=LAST
  + from=$&start_point

meas tran Vpeak MAX v(out)
+ from=$&start_point
plot A0+16 A1+12 B+8 C+4 out

write /foss/designs/SSCS-Chipaton-2025_ChipiChapa/designs/oai211/gf180mcu_gp9t3v3__oai211_1_tb.raw
.endc
"}
C {capa.sym} 1343.4375 -688.4375 0 0 {name=C1
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 1343.4375 -658.4375 0 0 {name=l8 lab=GND}
