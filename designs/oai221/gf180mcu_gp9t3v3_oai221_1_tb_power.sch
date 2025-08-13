v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 720 -300 720 -260 {lab=GND}
N 780 -300 780 -260 {lab=GND}
N 840 -300 840 -260 {lab=GND}
N 1040 -600 1090 -600 {lab=out}
N 900 -300 900 -260 {lab=GND}
N 960 -300 960 -260 {lab=GND}
N 1020 -300 1020 -260 {lab=GND}
N 1090 -600 1100 -600 {lab=out}
N 1100 -600 1100 -590 {lab=out}
C {vsource.sym} 780 -330 0 0 {name=vA0 value=3.3 savecurrent=false}
C {vsource.sym} 720 -330 0 0 {name=vs value=3.3 savecurrent=false}
C {vdd.sym} 720 -360 0 0 {name=l2 lab=VDD}
C {vdd.sym} 890 -760 0 0 {name=l3 lab=VDD}
C {gnd.sym} 780 -260 0 0 {name=l4 lab=GND}
C {gnd.sym} 720 -260 0 0 {name=l5 lab=GND}
C {gnd.sym} 890 -440 0 0 {name=l6 lab=GND}
C {lab_wire.sym} 1100 -600 0 0 {name=p2 sig_type=std_logic lab=out}
C {devices/code_shown.sym} 0 -880 0 0 {name=NGSPICE only_toplevel=true
value="
.control
save all

let VDD = 3.3
let idx = 0
let total = 0

repeat 32
  let xa0 = (($&idx)%2)
  let xa1 = (floor($&idx/2)%2)
  let xb0  = (floor($&idx/4)%2)
  let xb1  = (floor($&idx/8)%2)
  let xc  = (floor($&idx/16)%2)
  let va0 = xa0*VDD
  let va1 = xa1*VDD
  let vb0  = xb0*VDD
  let vb1  = xb1*VDD
  let vc  = xc*VDD

  alter @vA0[dc] = $&va0
  alter @vA1[dc] = $&va1
  alter @vB0[dc]  = $&vb0
  alter @vB1[dc]  = $&vb1
  alter @vC[dc]  = $&vc

  op

  echo input combination cb1b0a1a0 = $&xc$&xb1$&xb0$&xa1$&xa0
  let leakage_power = I(vs)*VDD
  let total = total + leakage_power
  print leakage_power
  let idx = $&idx + 1
  end

let avg_leakage_power = total/32
print avg_leakage_power

write gf180mcu_gp9t3v3__oai221_1_tb_power.raw
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
C {lab_wire.sym} 720 -680 0 0 {name=p7 sig_type=std_logic lab=A0}
C {lab_wire.sym} 720 -560 0 0 {name=p8 sig_type=std_logic lab=B0}
C {lab_wire.sym} 720 -600 0 0 {name=p9 sig_type=std_logic lab=C}
C {lab_wire.sym} 720 -640 0 0 {name=p10 sig_type=std_logic lab=A1}
C {lab_wire.sym} 720 -520 0 0 {name=p11 sig_type=std_logic lab=B1}
C {title.sym} 160 -30 0 0 {name=l1 author="Nabil Raihan"}
C {gnd.sym} 1100 -530 0 0 {name=l9 lab=GND}
C {capa.sym} 1100 -560 0 0 {name=C1
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {ChipiChapa/SSCS-Chipaton-2025_ChipiChapa/designs/oai221/gf180mcu_gp9t3v3_oai221_1.sym} 640 -220 0 0 {name=x1}
