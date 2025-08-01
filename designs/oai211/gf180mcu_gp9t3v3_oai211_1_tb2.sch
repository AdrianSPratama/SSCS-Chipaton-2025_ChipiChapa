v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 775 -498.75 795 -498.75 {lab=A0}
N 775 -478.75 795 -478.75 {lab=A1}
N 775.3125 -455.9375 795.3125 -455.9375 {lab=B}
N 775 -435.9375 795 -435.9375 {lab=C}
N 997.8125 -468.4375 1047.8125 -468.4375 {lab=out}
N 795 -435.9375 795.3125 -435.9375 {lab=C}
N 1043.4375 -468.4375 1085.9375 -468.4375 {lab=out}
N 904.6875 -543.125 904.6875 -533.125 {lab=VDD}
N 903.4375 -408.75 903.4375 -401.25 {lab=GND}
C {title.sym} 170 -40 0 0 {name=l1 author="Saputra Yudika Marpaung"}
C {vsource.sym} 815 -290 0 0 {name=VS value=3.3 savecurrent=false}
C {gf180mcu_gp9t3v3_oai211_1.sym} 825 -515 0 0 {name=x1}
C {vsource.sym} 875 -290 0 0 {name=VA0 value=3.3 savecurrent=false}
C {vsource.sym} 935 -290 0 0 {name=VA1 value=3.3 savecurrent=false}
C {vsource.sym} 995 -290 0 0 {name=VB value=3.3 savecurrent=false}
C {vsource.sym} 1055 -290 0 0 {name=VC value=3.3 savecurrent=false}
C {vdd.sym} 815 -320 0 0 {name=l2 lab=VDD}
C {gnd.sym} 815 -260 0 0 {name=l3 lab=GND}
C {gnd.sym} 875 -260 0 0 {name=l4 lab=GND}
C {gnd.sym} 935 -260 0 0 {name=l5 lab=GND}
C {gnd.sym} 995 -260 0 0 {name=l6 lab=GND}
C {gnd.sym} 1055 -260 0 0 {name=l7 lab=GND}
C {lab_pin.sym} 875 -320 0 0 {name=p1_A0 sig_type=std_logic lab=A0}
C {lab_pin.sym} 935 -320 0 0 {name=p2_A1 sig_type=std_logic lab=A1}
C {lab_pin.sym} 995 -320 0 0 {name=p3_B sig_type=std_logic lab=B}
C {lab_pin.sym} 1055 -320 0 0 {name=p4_C sig_type=std_logic lab=C}
C {lab_pin.sym} 775.625 -498.75 0 0 {name=p5_A0 sig_type=std_logic lab=A0}
C {lab_pin.sym} 775 -478.75 0 0 {name=p6_A1 sig_type=std_logic lab=A1}
C {lab_pin.sym} 775.625 -455.9375 0 0 {name=p7_B sig_type=std_logic lab=B}
C {lab_pin.sym} 775 -435.9375 0 0 {name=p8_C sig_type=std_logic lab=C}
C {vdd.sym} 904.6875 -543.125 0 0 {name=l9 lab=VDD}
C {gnd.sym} 903.4375 -401.875 0 0 {name=l10 lab=GND}
C {lab_wire.sym} 1043.4375 -468.4375 3 0 {name=p1 sig_type=std_logic lab=out}
C {devices/code_shown.sym} 25 -180 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value="
.include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice typical
"}
C {devices/code_shown.sym} 15 -1075 0 0 {name=NGSPICE1 only_toplevel=true
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
meas tran TFALL_result TRIG v(out) VAL=0.33 FALL=1 TARG v(out) VAL=2.97 FALL=1 from=6.4u
meas tran TPHL_A0 TRIG v(A0) VAL=1.65 RISE=1 TARG v(out) VAL=1.65 FALL=1 from=6.4u
meas tran VPEAK MAX v(out)
plot A0+16 A1+12 B+8 C+4 out

write gf180mcu_gp9t3v3__oai211_1_tb.raw
.endc
"}
C {capa.sym} 1083.4375 -438.4375 0 0 {name=C1
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 1083.4375 -408.4375 0 0 {name=l8 lab=GND}
