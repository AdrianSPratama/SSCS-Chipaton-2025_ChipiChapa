v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 1787.5 -327.5 1807.5 -327.5 {lab=out}
N 1807.5 -327.5 1837.5 -327.5 {lab=out}
N 1837.5 -327.5 1847.5 -327.5 {lab=out}
C {devices/code_shown.sym} 0 -670 0 0 {name=NGSPICE1 only_toplevel=true
value="
.control
save all

let idx = 0
let total = 0

repeat 16
  let a0 = (($&idx)%2)*3.3
  let a1 = (floor($&idx/2)%2)*3.3
  let b  = (floor($&idx/4)%2)*3.3
  let c  = (floor($&idx/8)%2)*3.3

  alter @VA0[dc] = $&a0
  alter @VA1[dc] = $&a1
  alter @VB[dc]  = $&b
  alter @VC[dc]  = $&c
  op
  echo no.$&idx of input combination
  let total = total + I(vs)*3.3
  print I(vs)*3.3
  let idx = $&idx + 1
  end
let avg_leakage_power = total/16
print avg_leakage_power

write /foss/designs/SSCS-Chipaton-2025_ChipiChapa/designs/aoi211/gf180mcu_gp9t3v3__aoi211_1_tb_powerwithdcop.raw
.endc
"}
C {devices/code_shown.sym} 10 -90 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value="
.include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice typical
"}
C {vsource.sym} 1270 -150 0 0 {name=VA0 value=3.3 savecurrent=false}
C {vsource.sym} 1330 -150 0 0 {name=VA1 value=3.3 savecurrent=false}
C {vsource.sym} 1390 -150 0 0 {name=VB value=3.3 savecurrent=false}
C {vsource.sym} 1450 -150 0 0 {name=VC value=3.3 savecurrent=false}
C {vsource.sym} 1210 -150 0 0 {name=VS value=3.3 savecurrent=false}
C {gnd.sym} 1450 -120 0 0 {name=l6 lab=GND}
C {gnd.sym} 1390 -120 0 0 {name=l7 lab=GND}
C {gnd.sym} 1330 -120 0 0 {name=l8 lab=GND}
C {gnd.sym} 1270 -120 0 0 {name=l9 lab=GND}
C {gnd.sym} 1210 -120 0 0 {name=l10 lab=GND}
C {vdd.sym} 1210 -180 0 0 {name=l11 lab=VDD}
C {lab_wire.sym} 1390 -180 0 0 {name=p6 sig_type=std_logic lab=B}
C {lab_wire.sym} 1270 -180 0 0 {name=p7 sig_type=std_logic lab=A0}
C {lab_wire.sym} 1450 -180 0 0 {name=p9 sig_type=std_logic lab=C}
C {lab_wire.sym} 1330 -180 0 0 {name=p10 sig_type=std_logic lab=A1}
C {lab_wire.sym} 1590 -357.5 0 0 {name=p1 sig_type=std_logic lab=A1}
C {lab_wire.sym} 1590 -377.5 0 0 {name=p2 sig_type=std_logic lab=A0}
C {lab_wire.sym} 1590 -327.5 0 0 {name=p3 sig_type=std_logic lab=B}
C {lab_wire.sym} 1590 -298.75 0 0 {name=p4 sig_type=std_logic lab=C}
C {vdd.sym} 1688.75 -416.25 0 0 {name=l2 lab=VDD}
C {gnd.sym} 1688.75 -236.25 0 0 {name=l3 lab=GND}
C {lab_wire.sym} 1847.5 -327.5 1 0 {name=p11 sig_type=std_logic lab=out}
C {SSCS-Chipaton-2025_ChipiChapa/designs/aoi211/gf180mcu_osu_sc_gp9t3v3_aoi211_1.sym} 1617.5 -397.5 0 0 {name=x211aoi1}
C {capa.sym} 1847.5 -297.5 0 0 {name=C1
m=1
value=0.001p
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 1847.5 -267.5 0 0 {name=l1 lab=GND}
