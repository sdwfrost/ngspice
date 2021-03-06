** npn bipolar: table 2D (Vce, Ib) compared to q model
* bipolar transistor qinn from National Semi op-amp clc409

** Circuit Description **
Q3 2 1 3 QINN
ib 0 1 2u
vce 2 0 5
vee 3 0 0

xbip cc bb ee tbqnpn
ib2 0 bb 2u
vce2 cc 0 1
vee2 ee 0 0

.options temp=1

.subckt tbqnpn c b e
*** table model of npn bipolar transistor ***
* bip qinn from national op-amp CLC409
* table values extracted at nominal temperature of 27°C
* simple behavioral temperature model
.param fact = 0.05
.param tgain = 1. + (TEMPER / 27. - 1.) * {fact}
abip1 %vd(c e) %id(bint e) %id(c e) biptable1
.model biptable1 table2d (offset=0.0 gain={tgain} order=2 file="qinn-clc409-2d-1.table")
* CJE=1.632E-13
Cje b e 1.632E-13
* CJC=1.720E-13
Cjc b c 1.720E-13
* input diode
Dbe b bint DMOD
.model DMOD D (bv=5 is=1e-17 n=1.1)
.ends

.control
* bipolar model qinn
dc vce 0 5 0.05 ib 0.2u 1.8u 0.4u
*plot i(vee)
*plot v(1) ylimit 0 1

* bipolar from table
dc vce2 0 5 0.05 ib2 0.2u 1.8u 0.4u


plot dc1.i(vee) i(vee2) title 'table q3, q4 output current (i(vee2)) compared to bjt model (dc1.i(vee))'
plot dc1.v(1) v(bb) ylimit 0.6 0.8 title 'table q3, q4 input diode (v(bb)) compared to bjt model (dc1.v(1))'
.endc

.MODEL QINN NPN
+ IS =0.166f    BF =3.239E+02 NF =1.000E+00 VAF=8.457E+01
+ IKF=2.462E-02 ISE=2.956E-17 NE =1.197E+00 BR =3.719E+01
+ NR =1.000E+00 VAR=1.696E+00 IKR=3.964E-02 ISC=1.835E-19
+ NC =1.700E+00 RB =118       IRB=0.000E+00 RBM=65.1
+ RC =2.645E+01 CJE=1.632E-13 VJE=7.973E-01
+ MJE=4.950E-01 TF =1.948E-11 XTF=1.873E+01 VTF=2.825E+00
+ ITF=5.955E-02 PTF=0.000E+00 CJC=1.720E-13 VJC=8.046E-01
+ MJC=4.931E-01 XCJC=589m     TR =4.212E-10 CJS=629f
+ MJS=0         KF =2.000E-12 AF =1.000E+00 FC =9.765E-01
*

.end
