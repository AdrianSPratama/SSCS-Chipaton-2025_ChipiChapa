v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 820 -620 840 -620 {lab=B1}
N 820 -600 840 -600 {lab=A1}
N 820 -580 840 -580 {lab=C1}
N 820 -560 840 -560 {lab=B2}
N 820 -540 840 -540 {lab=A2}
N 1140 -600 1160 -600 {lab=out}
N 1160 -600 1190 -600 {lab=out}
N 1190 -600 1200 -600 {lab=out}
C {title.sym} 160 -40 0 0 {name=l1 author="Adrian Sami Pratama"}
C {vdd.sym} 1140 -620 1 0 {name=l2 lab=VDD}
C {gnd.sym} 1140 -580 0 0 {name=l3 lab=GND}
C {vsource.sym} 910 -340 0 0 {name=VA1 value=3.3 savecurrent=false}
C {vsource.sym} 970 -340 0 0 {name=VA2 value=3.3 savecurrent=false}
C {vsource.sym} 1030 -340 0 0 {name=VB1 value=3.3 savecurrent=false}
C {vsource.sym} 1090 -340 0 0 {name=VB2 value=3.3 savecurrent=false}
C {vsource.sym} 1150 -340 0 0 {name=VC1 value=3.3 savecurrent=false}
C {vsource.sym} 850 -340 0 0 {name=VS value=3.3 savecurrent=false}
C {gnd.sym} 1150 -310 0 0 {name=l5 lab=GND}
C {gnd.sym} 1090 -310 0 0 {name=l6 lab=GND}
C {gnd.sym} 1030 -310 0 0 {name=l7 lab=GND}
C {gnd.sym} 970 -310 0 0 {name=l8 lab=GND}
C {gnd.sym} 910 -310 0 0 {name=l9 lab=GND}
C {gnd.sym} 850 -310 0 0 {name=l10 lab=GND}
C {vdd.sym} 850 -370 0 0 {name=l11 lab=VDD}
C {lab_wire.sym} 820 -620 0 0 {name=p1 sig_type=std_logic lab=B1}
C {lab_wire.sym} 820 -600 0 0 {name=p2 sig_type=std_logic lab=A1}
C {lab_wire.sym} 820 -580 0 0 {name=p3 sig_type=std_logic lab=C1}
C {lab_wire.sym} 820 -560 0 0 {name=p4 sig_type=std_logic lab=B2}
C {lab_wire.sym} 820 -540 0 0 {name=p5 sig_type=std_logic lab=A2}
C {lab_wire.sym} 1030 -370 0 0 {name=p6 sig_type=std_logic lab=B1}
C {lab_wire.sym} 910 -370 0 0 {name=p7 sig_type=std_logic lab=A1}
C {lab_wire.sym} 1150 -370 0 0 {name=p8 sig_type=std_logic lab=C1}
C {lab_wire.sym} 1090 -370 0 0 {name=p9 sig_type=std_logic lab=B2}
C {lab_wire.sym} 970 -370 0 0 {name=p10 sig_type=std_logic lab=A2}
C {devices/code_shown.sym} 60 -210 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value="
.include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice typical
"}
C {devices/code_shown.sym} 50 -1200 0 0 {name=NGSPICE1 only_toplevel=true
value="
.control
save all
** Define input signal
let fsig = 100k
let tperA1 = 1/fsig
let tperA2 = 2*tperA1
let tperB1 = 4*tperA1
let tperB2 = 8*tperA1
let tperC1 = 16*tperA1
let tfr = 0.01*tperA1
let tonA1 = 0.5*tperA1-tfr
let tonA2 = 0.5*tperA2-tfr
let tonB1 = 0.5*tperB1-tfr
let tonB2 = 0.5*tperB2-tfr
let tonC1 = 0.5*tperC1-tfr

** Define transient params
let tstop = 16*tperA1
let tstep = 0.001*tperA1

** Set Sources
alter @VA1[DC] = 0.0
alter @VA2[DC] = 0.0
alter @VB1[DC] = 0.0
alter @VB2[DC] = 0.0
alter @VC1[DC] = 0.0
alter @VA1[PULSE] = [ 0 3.3 0 $&tfr $&tfr $&tonA1 $&tperA1 0 ]
alter @VA2[PULSE] = [ 0 3.3 0 $&tfr $&tfr $&tonA2 $&tperA2 0 ]
alter @VB1[PULSE] = [ 0 3.3 0 $&tfr $&tfr $&tonB1 $&tperB1 0 ]
alter @VB2[PULSE] = [ 0 3.3 0 $&tfr $&tfr $&tonB2 $&tperB2 0 ]
alter @VC1[PULSE] = [ 0 3.3 0 $&tfr $&tfr $&tonC1 $&tperC1 0 ]

** Simulations op
dc VA1 0 3.3 0.01
dc VA2 0 3.3 0.01
dc VB1 0 3.3 0.01
dc VB2 0 3.3 0.01
dc VC1 0 3.3 0.01
tran $&tstep $&tstop

.measure tran tplh TRIG v(in) VAL=0.9 RISE=1 TARG v(out) VAL=0.9 RISE=1
write gf180mcu_gp9t3v3__aoi221_1_tb.raw
.endc
"}
C {lab_wire.sym} 1180 -600 3 0 {name=p11 sig_type=std_logic lab=out}
C {gf180mcu_gp9t3v3__aoi221_1.sym} 860 -630 0 0 {name=aoi221}
C {gnd.sym} 1200 -540 0 0 {name=l4 lab=GND}
C {capa.sym} 1200 -570 0 0 {name=C1
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
