v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 1275 -778.75 1295 -778.75 {lab=A0}
N 1275 -758.75 1295 -758.75 {lab=A1}
N 1275.3125 -735.9375 1295.3125 -735.9375 {lab=B}
N 1275 -715.9375 1295 -715.9375 {lab=C}
N 1497.8125 -748.4375 1547.8125 -748.4375 {lab=out}
N 1295 -715.9375 1295.3125 -715.9375 {lab=C}
N 1543.4375 -748.4375 1585.9375 -748.4375 {lab=out}
N 1404.6875 -823.125 1404.6875 -813.125 {lab=VDD}
N 1403.4375 -688.75 1403.4375 -681.25 {lab=GND}
C {title.sym} 160 -40 0 0 {name=l1 author="Saputra Yudika Marpaung"}
C {vsource.sym} 1315 -570 0 0 {name=VS value=3.3 savecurrent=false}
C {gf180mcu_gp9t3v3_oai211_1.sym} 1325 -795 0 0 {name=x1}
C {vsource.sym} 1375 -570 0 0 {name=VA0 value=3.3 savecurrent=false}
C {vsource.sym} 1435 -570 0 0 {name=VA1 value=3.3 savecurrent=false}
C {vsource.sym} 1495 -570 0 0 {name=VB value=3.3 savecurrent=false}
C {vsource.sym} 1555 -570 0 0 {name=VC value=3.3 savecurrent=false}
C {vdd.sym} 1315 -600 0 0 {name=l2 lab=VDD}
C {gnd.sym} 1315 -540 0 0 {name=l3 lab=GND}
C {gnd.sym} 1375 -540 0 0 {name=l4 lab=GND}
C {gnd.sym} 1435 -540 0 0 {name=l5 lab=GND}
C {gnd.sym} 1495 -540 0 0 {name=l6 lab=GND}
C {gnd.sym} 1555 -540 0 0 {name=l7 lab=GND}
C {lab_pin.sym} 1375 -600 0 0 {name=p1_A0 sig_type=std_logic lab=A0}
C {lab_pin.sym} 1435 -600 0 0 {name=p2_A1 sig_type=std_logic lab=A1}
C {lab_pin.sym} 1495 -600 0 0 {name=p3_B sig_type=std_logic lab=B}
C {lab_pin.sym} 1555 -600 0 0 {name=p4_C sig_type=std_logic lab=C}
C {lab_pin.sym} 1275.625 -778.75 0 0 {name=p5_A0 sig_type=std_logic lab=A0}
C {lab_pin.sym} 1275 -758.75 0 0 {name=p6_A1 sig_type=std_logic lab=A1}
C {lab_pin.sym} 1275.625 -735.9375 0 0 {name=p7_B sig_type=std_logic lab=B}
C {lab_pin.sym} 1275 -715.9375 0 0 {name=p8_C sig_type=std_logic lab=C}
C {vdd.sym} 1404.6875 -823.125 0 0 {name=l9 lab=VDD}
C {gnd.sym} 1403.4375 -681.875 0 0 {name=l10 lab=GND}
C {lab_wire.sym} 1543.4375 -748.4375 3 0 {name=p1 sig_type=std_logic lab=out}
C {devices/code_shown.sym} 15 -180 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value="
.include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice typical
"}
C {capa.sym} 1583.4375 -718.4375 0 0 {name=C1
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 1583.4375 -688.4375 0 0 {name=l8 lab=GND}
C {devices/code_shown.sym} 20 -850 0 0 {name=NGSPICE2 only_toplevel=true
value="
.control
save all

let VDD = 3.3
let idx = 0
let total = 0

repeat 16
  let xa0 = (($&idx)%2)
  let xa1 = (floor($&idx/2)%2)
  let xb  = (floor($&idx/4)%2)
  let xc  = (floor($&idx/8)%2)
  let va0 = xa0*VDD
  let va1 = xa1*VDD
  let vb  = xb*VDD
  let vc  = xc*VDD
  alter @VA0[dc] = $&va0
  alter @VA1[dc] = $&va1
  alter @VB[dc]  = $&vb
  alter @VC[dc]  = $&vc
  op
  show all
  echo input combination a0a1bc = $&xc$&xb$&xa1$&xa0
  let leakage_power = I(vs)*VDD
  let total_leakage = total + leakage_power
  print leakage_power
  let idx = $&idx + 1
  end

let avg_leakage_power = total_leakage/16
print avg_leakage_power

write /foss/designs/SSCS-Chipaton-2025_ChipiChapa/designs/oai211/gf180mcu_gp9t3v3__oai211_1_tb_powerwithdcop.raw
.endc
"}
