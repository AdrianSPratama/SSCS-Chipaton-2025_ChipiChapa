v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 765 -500 785 -500 {lab=A0}
N 765 -480 785 -480 {lab=A1}
N 765 -460 785 -460 {lab=B}
N 765 -440 785 -440 {lab=C}
N 1085 -480 1135 -480 {lab=out}
N 1085 -500 1105 -500 {lab=VDD}
N 1085 -460 1105 -460 {lab=GND}
N 1105 -460 1105 -440 {lab=GND}
C {title.sym} 160 -40 0 0 {name=l1 author="Saputra Yudika Marpaung"}
C {vsource.sym} 805 -290 0 0 {name=VS value=3.3 savecurrent=false}
C {gf180mcu_gp9t3v3_oai211_1.sym} 775 -430 0 0 {name=x1}
C {vsource.sym} 865 -290 0 0 {name=VA0 value=3.3 savecurrent=false}
C {vsource.sym} 925 -290 0 0 {name=VA1 value=3.3 savecurrent=false}
C {vsource.sym} 985 -290 0 0 {name=VB value=3.3 savecurrent=false}
C {vsource.sym} 1045 -290 0 0 {name=VC value=3.3 savecurrent=false}
C {vdd.sym} 805 -320 0 0 {name=l2 lab=VDD}
C {gnd.sym} 805 -260 0 0 {name=l3 lab=GND}
C {gnd.sym} 865 -260 0 0 {name=l4 lab=GND}
C {gnd.sym} 925 -260 0 0 {name=l5 lab=GND}
C {gnd.sym} 985 -260 0 0 {name=l6 lab=GND}
C {gnd.sym} 1045 -260 0 0 {name=l7 lab=GND}
C {lab_pin.sym} 865 -320 0 0 {name=p1_A0 sig_type=std_logic lab=A0}
C {lab_pin.sym} 925 -320 0 0 {name=p2_A1 sig_type=std_logic lab=A1}
C {lab_pin.sym} 985 -320 0 0 {name=p3_B sig_type=std_logic lab=B}
C {lab_pin.sym} 1045 -320 0 0 {name=p4_C sig_type=std_logic lab=C}
C {lab_pin.sym} 765 -500 0 0 {name=p5_A0 sig_type=std_logic lab=A0}
C {lab_pin.sym} 765 -480 0 0 {name=p6_A1 sig_type=std_logic lab=A1}
C {lab_pin.sym} 765 -460 0 0 {name=p7_B sig_type=std_logic lab=B}
C {lab_pin.sym} 765 -440 0 0 {name=p8_C sig_type=std_logic lab=C}
C {noconn.sym} 1135 -480 2 0 {name=l8}
C {vdd.sym} 1105 -500 0 0 {name=l9 lab=VDD}
C {gnd.sym} 1105 -440 0 0 {name=l10 lab=GND}
C {lab_wire.sym} 1130 -480 3 0 {name=p1 sig_type=std_logic lab=out}
C {devices/code_shown.sym} 15 -180 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value="
.include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice typical
"}
C {devices/code_shown.sym} 15 -945 0 0 {name=NGSPICE1 only_toplevel=true
value="
.control
save all
** Define input signal
let fsig = 1k
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

write gf180mcu_gp9t3v3__oai211_1_tb.raw
.endc
"}
