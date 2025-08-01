v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 720 -300 720 -260 {lab=GND}
N 780 -300 780 -260 {lab=GND}
N 1020 -480 1020 -440 {lab=GND}
N 840 -300 840 -260 {lab=GND}
N 1020 -530 1020 -520 {lab=VDD}
N 1020 -440 1020 -430 {lab=GND}
N 1020 -500 1070 -500 {lab=Y}
N 900 -300 900 -260 {lab=GND}
N 960 -300 960 -260 {lab=GND}
N 1020 -300 1020 -260 {lab=GND}
C {vsource.sym} 780 -330 0 0 {name=vA0 value=3.3 savecurrent=false}
C {vsource.sym} 720 -330 0 0 {name=v1 value=3.3 savecurrent=false}
C {vdd.sym} 720 -360 0 0 {name=l2 lab=VDD}
C {vdd.sym} 1020 -530 0 0 {name=l3 lab=VDD}
C {gnd.sym} 780 -260 0 0 {name=l4 lab=GND}
C {gnd.sym} 720 -260 0 0 {name=l5 lab=GND}
C {gnd.sym} 1020 -430 0 0 {name=l6 lab=GND}
C {noconn.sym} 1070 -500 2 0 {name=l7}
C {lab_wire.sym} 1050 -500 0 0 {name=p2 sig_type=std_logic lab=Y}
C {devices/code_shown.sym} 0 -750 0 0 {name=NGSPICE only_toplevel=true
value="
.control
save all

** Define input signal
let fsig = 1k
let tperA0 = 1/fsig
let tperA1 = 2*tperA0
let tperB0 = 2*tperA1
let tperB1 = 2*tperB0
let tperC = 2*tperB1

let tfr = 0.01*tperA0

let tonA0 = 0.5*tperA0-tfr
let tonA1 = 0.5*tperA1-tfr
let tonB0 = 0.5*tperB0-tfr
let tonB1 = 0.5*tperB1-tfr
let tonC = 0.5*tperC-tfr

** Define transient params
let tstop = tperC
let tstep = 0.001*tperA0

** Set Sources
alter @vA0[PULSE] = [ 0 3.3 0 $&tfr $&tfr $&tonA0 $&tperA0 0 ]
alter @vA1[PULSE] = [ 0 3.3 0 $&tfr $&tfr $&tonA1 $&tperA1 0 ]
alter @vB0[PULSE] = [ 0 3.3 0 $&tfr $&tfr $&tonB0 $&tperB0 0 ]
alter @vB1[PULSE] = [ 0 3.3 0 $&tfr $&tfr $&tonB1 $&tperB1 0 ]
alter @vC[PULSE] = [ 0 3.3 0 $&tfr $&tfr $&tonC $&tperC 0 ]

** Simulations
tran $&tstep $&tstop

write oai221_tb.raw
.endc
"}
C {devices/code_shown.sym} 710 -190 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value="
.lib $::180MCU_MODELS/sm141064.ngspice typical
.include $::180MCU_MODELS/design.ngspice
"}
C {vsource.sym} 840 -330 0 0 {name=vA1 value=3.3 savecurrent=false}
C {gnd.sym} 840 -260 0 0 {name=l8 lab=GND}
C {oai221/oai221.sym} 720 -360 0 0 {name=x1}
C {lab_wire.sym} 780 -360 0 0 {name=p1 sig_type=std_logic lab=A0}
C {lab_wire.sym} 840 -360 0 0 {name=p3 sig_type=std_logic lab=A1}
C {vsource.sym} 960 -330 0 0 {name=vB1 value=3.3 savecurrent=false}
C {vsource.sym} 900 -330 0 0 {name=vB0 value=3.3 savecurrent=false}
C {gnd.sym} 960 -260 0 0 {name=l10 lab=GND}
C {gnd.sym} 900 -260 0 0 {name=l11 lab=GND}
C {vsource.sym} 1020 -330 0 0 {name=vC value=3.3 savecurrent=false}
C {gnd.sym} 1020 -260 0 0 {name=l12 lab=GND}
C {lab_wire.sym} 960 -360 0 0 {name=p4 sig_type=std_logic lab=B1}
C {lab_wire.sym} 1020 -360 0 0 {name=p5 sig_type=std_logic lab=C}
C {lab_wire.sym} 900 -360 0 0 {name=p6 sig_type=std_logic lab=B0}
C {lab_wire.sym} 720 -520 0 0 {name=p7 sig_type=std_logic lab=A0}
C {lab_wire.sym} 720 -500 0 0 {name=p8 sig_type=std_logic lab=B0}
C {lab_wire.sym} 720 -480 0 0 {name=p9 sig_type=std_logic lab=C}
C {lab_wire.sym} 720 -460 0 0 {name=p10 sig_type=std_logic lab=A1}
C {lab_wire.sym} 720 -440 0 0 {name=p11 sig_type=std_logic lab=B1}
C {title.sym} 160 -30 0 0 {name=l1 author="Nabil Raihan"}
