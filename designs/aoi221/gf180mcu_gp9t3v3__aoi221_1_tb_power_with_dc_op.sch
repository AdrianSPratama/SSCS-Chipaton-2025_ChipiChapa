v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 840 -530 860 -530 {lab=B1}
N 840 -600 860 -600 {lab=A1}
N 840 -460 860 -460 {lab=C1}
N 840 -500 860 -500 {lab=B2}
N 840 -570 860 -570 {lab=A2}
N 1120 -530 1140 -530 {lab=out}
N 1140 -530 1170 -530 {lab=out}
N 1170 -530 1180 -530 {lab=out}
C {title.sym} 160 -40 0 0 {name=l1 author="Adrian Sami Pratama"}
C {vdd.sym} 1010 -630 0 0 {name=l2 lab=VDD}
C {gnd.sym} 1010 -420 0 0 {name=l3 lab=GND}
C {vsource.sym} 910 -250 0 0 {name=VA1 value=3.3 savecurrent=false}
C {vsource.sym} 970 -250 0 0 {name=VA2 value=3.3 savecurrent=false}
C {vsource.sym} 1030 -250 0 0 {name=VB1 value=3.3 savecurrent=false}
C {vsource.sym} 1090 -250 0 0 {name=VB2 value=3.3 savecurrent=false}
C {vsource.sym} 1150 -250 0 0 {name=VC1 value=3.3 savecurrent=false}
C {vsource.sym} 850 -250 0 0 {name=VS value=3.3 savecurrent=false}
C {gnd.sym} 1150 -220 0 0 {name=l5 lab=GND}
C {gnd.sym} 1090 -220 0 0 {name=l6 lab=GND}
C {gnd.sym} 1030 -220 0 0 {name=l7 lab=GND}
C {gnd.sym} 970 -220 0 0 {name=l8 lab=GND}
C {gnd.sym} 910 -220 0 0 {name=l9 lab=GND}
C {gnd.sym} 850 -220 0 0 {name=l10 lab=GND}
C {vdd.sym} 850 -340 0 0 {name=l11 lab=VDD}
C {lab_wire.sym} 840 -530 0 0 {name=p1 sig_type=std_logic lab=B1}
C {lab_wire.sym} 840 -600 0 0 {name=p2 sig_type=std_logic lab=A1}
C {lab_wire.sym} 840 -460 0 0 {name=p3 sig_type=std_logic lab=C1}
C {lab_wire.sym} 840 -500 0 0 {name=p4 sig_type=std_logic lab=B2}
C {lab_wire.sym} 840 -570 0 0 {name=p5 sig_type=std_logic lab=A2}
C {lab_wire.sym} 1030 -340 0 0 {name=p6 sig_type=std_logic lab=B1}
C {lab_wire.sym} 910 -340 0 0 {name=p7 sig_type=std_logic lab=A1}
C {lab_wire.sym} 1150 -340 0 0 {name=p8 sig_type=std_logic lab=C1}
C {lab_wire.sym} 1090 -340 0 0 {name=p9 sig_type=std_logic lab=B2}
C {lab_wire.sym} 970 -340 0 0 {name=p10 sig_type=std_logic lab=A2}
C {devices/code_shown.sym} 60 -210 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value="
.include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice typical
"}
C {lab_wire.sym} 1160 -530 3 0 {name=p11 sig_type=std_logic lab=out}
C {gf180mcu_gp9t3v3__aoi221_1.sym} 860 -630 0 0 {name=xaoi221_1}
C {gnd.sym} 1180 -470 0 0 {name=l4 lab=GND}
C {capa.sym} 1180 -500 0 0 {name=C1
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {res.sym} 850 -310 0 0 {name=R1
value=50
footprint=1206
device=resistor
m=1}
C {res.sym} 910 -310 0 0 {name=R2
value=50
footprint=1206
device=resistor
m=1}
C {res.sym} 970 -310 0 0 {name=R3
value=50
footprint=1206
device=resistor
m=1}
C {res.sym} 1030 -310 0 0 {name=R4
value=50
footprint=1206
device=resistor
m=1}
C {res.sym} 1090 -310 0 0 {name=R5
value=50
footprint=1206
device=resistor
m=1}
C {res.sym} 1150 -310 0 0 {name=R6
value=50
footprint=1206
device=resistor
m=1}
C {devices/code_shown.sym} 20 -1420 0 0 {name=NGSPICE1 only_toplevel=true
value="
.control
save all

let VDD = 3.3
let idx = 0
let total_leakage = 0

repeat 32
  let logic_a1 = (($&idx)%2)
  let logic_a2 = (floor($&idx/2)%2)
  let logic_b1 = (floor($&idx/4)%2)
  let logic_b2 = (floor($&idx/8)%2)
  let logic_c1 = (floor($&idx/16)%2)
  let a1 = logic_a1*VDD
  let a2 = logic_a2*VDD
  let b1 = logic_b1*VDD
  let b2 = logic_b2*VDD
  let c1 = logic_c1*VDD
  alter @VA1[dc] = $&a1
  alter @VA2[dc] = $&a2
  alter @VB1[dc] = $&b1
  alter @VB2[dc] = $&b2
  alter @VC1[dc] = $&c1
  op
  echo input combination c1b2b1a2a1 = $&logic_c1$&logic_b2$&logic_b1$&logic_a2$&logic_a1
  let leakage_power = I(vs)*VDD
  let total_leakage = total_leakage + leakage_power
  print leakage_power
  let idx = $&idx + 1
end

let avg_leakage_power = total_leakage/32
print avg_leakage_power

write /foss/designs/SSCS-Chipaton-2025_ChipiChapa/designs/aoi211/gf180mcu_gp9t3v3__aoi211_1_tb_powerwithdcop.raw
.endc
"}
