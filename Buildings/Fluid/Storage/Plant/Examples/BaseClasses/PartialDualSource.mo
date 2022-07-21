within Buildings.Fluid.Storage.Plant.Examples.BaseClasses;
partial model PartialDualSource
  "Base model of a district system model with two sources and three users"

  package MediumCHW = Buildings.Media.Water "Medium model for CHW";
  package MediumCDW1 = Buildings.Media.Water "Medium model for CDW of chi1";

  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=1
    "Nominal mass flow rate";
  parameter Modelica.Units.SI.PressureDifference dp_nominal(
    final displayUnit="Pa")=
     300000
    "Nominal pressure difference";
  parameter Modelica.Units.SI.Temperature T_CHWR_nominal(
    final displayUnit="degC")=
     12+273.15
    "Nominal temperature of CHW return";
  parameter Modelica.Units.SI.Temperature T_CHWS_nominal(
    final displayUnit="degC")=
     7+273.15
    "Nominal temperature of CHW supply";
  parameter Modelica.Units.SI.Power QCooLoa_flow_nominal=5*4200*0.6
    "Nominal cooling load of one consumer";

// First source: chiller only
  Buildings.Fluid.Chillers.ElectricEIR chi1(
    redeclare final package Medium1 = MediumCDW1,
    redeclare final package Medium2 = MediumCHW,
    m1_flow_nominal=1.2*chi1.m2_flow_nominal,
    m2_flow_nominal=m_flow_nominal,
    final dp1_nominal=0,
    final dp2_nominal=0,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    p2_start=500000,
    T2_start=T_CHWS_nominal,
    final per=perChi1)
    "Water cooled chiller (ports indexed 1 are on condenser side)"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-130,70})));
  parameter Buildings.Fluid.Chillers.Data.ElectricEIR.Generic perChi1(
    QEva_flow_nominal=-1E6,
    COP_nominal=3,
    PLRMax=1,
    PLRMinUnl=0.3,
    PLRMin=0.3,
    etaMotor=1,
    mEva_flow_nominal=0.7*m_flow_nominal,
    mCon_flow_nominal=1.2*perChi1.mEva_flow_nominal,
    TEvaLvg_nominal=280.15,
    capFunT={1,0,0,0,0,0},
    EIRFunT={1,0,0,0,0,0},
    EIRFunPLR={1,0,0},
    TEvaLvgMin=276.15,
    TEvaLvgMax=288.15,
    TConEnt_nominal=310.15,
    TConEntMin=303.15,
    TConEntMax=333.15) "Performance data for the chiller in plant 1"
                                                  annotation (
      choicesAllMatching=true, Placement(transformation(extent={{-180,120},{-160,
            140}})));
 Buildings.Fluid.Movers.SpeedControlled_y pumSup1(
    redeclare package Medium = MediumCHW,
    per(pressure(
          dp=dp_nominal*{2,1.2,0},
          V_flow=(1.5*m_flow_nominal)/1.2*{0,1.2,2})),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    allowFlowReversal=true,
    addPowerToMedium=false,
    y_start=0,
    T_start=T_CHWR_nominal) "CHW supply pump for chi1"
                                                 annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-70,40})));
  Buildings.Fluid.FixedResistances.CheckValve cheValPumChi1(
    redeclare package Medium = MediumCHW,
    m_flow_nominal=chi1.m2_flow_nominal,
    dpValve_nominal=0.1*dp_nominal,
    dpFixed_nominal=0.1*dp_nominal) "Check valve" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-110,40})));
  Buildings.Controls.Continuous.LimPID conPI_pumChi1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1,
    Ti=100,
    reverseActing=true) "PI controller" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-10,110})));
  Modelica.Blocks.Sources.Constant set_TRet(k=12 + 273.15)
    "CHW return setpoint"
    annotation (Placement(transformation(extent={{60,100},{80,120}})));
  Buildings.Fluid.Sources.MassFlowSource_T souCDW1(
    redeclare package Medium = MediumCDW1,
    m_flow=1.2*chi1.m2_flow_nominal,
    T=305.15,
    nPorts=1) "Source representing CDW supply line" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-170,90})));
  Buildings.Fluid.Sources.Boundary_pT sinCDW1(
    redeclare final package Medium = MediumCDW1,
    final p=300000,
    final T=310.15,
    nPorts=1) "Sink representing CDW return line" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-170,50})));
  Modelica.Blocks.Sources.Constant TEvaLvgSet(k=T_CHWS_nominal)
    "Evaporator leaving temperature setpoint" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-90,130})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant on(k=true)
    "Placeholder, chiller always on"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-130,130})));

// Second source: chiller and tank
  Buildings.Fluid.Storage.Plant.Data.NominalValues nomPla2(
    plaTyp=Buildings.Fluid.Storage.Plant.BaseClasses.Types.Setup.ClosedRemote,
    mTan_flow_nominal=0.75*m_flow_nominal,
    mChi_flow_nominal=0.75*m_flow_nominal,
    dp_nominal=dp_nominal,
    T_CHWS_nominal=T_CHWS_nominal,
    T_CHWR_nominal=T_CHWS_nominal) "Nominal values for the second plant"
    annotation (Placement(transformation(extent={{-180,-60},{-160,-40}})));
  Buildings.Fluid.Storage.Plant.TankBranch tanBra(
    tankIsOpen=false,
    preDroTanBot(final dp_nominal=nomPla2.dp_nominal*0.05),
    preDroTanTop(final dp_nominal=nomPla2.dp_nominal*0.05),
    redeclare final package Medium = MediumCHW,
    final nom=nomPla2) "Tank branch, tank can be charged remotely" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-100,-50})));
  Buildings.Fluid.Storage.Plant.Examples.BaseClasses.ChillerBranch chiBra2(
    redeclare final package Medium = MediumCHW,
    final nom=nomPla2,
    final cheVal(final dpValve_nominal=0.1*nomPla2.dp_nominal,
                 final dpFixed_nominal=0.1*nomPla2.dp_nominal)) "Chiller branch"
    annotation (Placement(transformation(extent={{-140,-60},{-120,-40}})));
  Buildings.Fluid.Storage.Plant.NetworkConnection netCon(
    redeclare final package Medium = MediumCHW,
    final nom=nomPla2,
    plaTyp=nomPla2.plaTyp)
    "Supply pump and valves that connect the plant to the district network"
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  Modelica.Blocks.Sources.BooleanTable uRemCha(table={3600/9*6,3600/9*8},
      startValue=false) "Tank is being charged remotely" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-170,-90})));
  Modelica.Blocks.Sources.BooleanTable uTanDis(table={3600/9*1,3600/9*6,3600/9*
        8}, startValue=false)
    "True = discharging; false = charging (either local or remote)" annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-170,-10})));
  Buildings.Fluid.Storage.Plant.Controls.RemoteCharging conRemCha(final
      plaTyp=nomPla2.plaTyp) "Control block for the secondary pump and valves"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,-10})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal mTanSet_flow(
    realTrue=nomPla2.mTan_flow_nominal,
    realFalse=-nomPla2.mTan_flow_nominal)
    "Set a positive flow rate when tank discharging and negative when charging"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-130,-10})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal mChiBra2Set_flow(
    realTrue=0, realFalse=nomPla2.mChi_flow_nominal)
    "Set the flow rate to a constant value whenever the tank is not being charged remotely"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-140,-90})));
  Buildings.Controls.OBC.CDL.Logical.Or or2 "Tank charging remotely OR there is load"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,-90})));

// Users
  Buildings.Fluid.Storage.Plant.Examples.BaseClasses.IdealUser usr1(
    redeclare package Medium = MediumCHW,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=0.3*dp_nominal,
    T_a_nominal=T_CHWS_nominal,
    T_b_nominal=T_CHWR_nominal) "Dummy user 1" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={60,60})));
  Buildings.Fluid.Storage.Plant.Examples.BaseClasses.IdealUser usr2(
    redeclare package Medium = MediumCHW,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=0.3*dp_nominal,
    T_a_nominal=T_CHWS_nominal,
    T_b_nominal=T_CHWR_nominal) "Dummy usr 2" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={60,0})));
  Buildings.Fluid.Storage.Plant.Examples.BaseClasses.IdealUser usr3(
    redeclare package Medium = MediumCHW,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=0.3*dp_nominal,
    T_a_nominal=T_CHWS_nominal,
    T_b_nominal=T_CHWR_nominal) "Dummy user 3" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={60,-60})));
  Buildings.Controls.OBC.CDL.Continuous.MultiMin mulMin_dpUsr(nin=3)
    "Min of pressure head measured from all users"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={30,130})));
  Modelica.Blocks.Sources.Constant set_dpUsr(k=1)
    "Normalised consumer differential pressure setpoint"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-50,130})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hysCat(uLow=0.05, uHigh=0.1)
    "Shut off at con.yVal = 0.05 and restarts at 0.1" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={10,-110})));
  Buildings.Controls.OBC.CDL.Continuous.MultiMax mulMax_yVal(nin=3)
    "Max of valve positions"
    annotation (Placement(transformation(extent={{60,-120},{40,-100}})));
  Modelica.Blocks.Sources.TimeTable set_QCooLoa1_flow(table=[0,0; 3600/9*1,0;
        3600/9*1,QCooLoa_flow_nominal; 3600/9*4,QCooLoa_flow_nominal; 3600/9*4,
        0; 3600,0])
    "Cooling load"
    annotation (Placement(transformation(extent={{120,70},{100,90}})));
  Modelica.Blocks.Sources.TimeTable set_QCooLoa2_flow(table=[0,0; 3600/9*2,0;
        3600/9*2,QCooLoa_flow_nominal; 3600/9*5,QCooLoa_flow_nominal; 3600/9*5,
        0; 3600,0])
    "Cooling load"
    annotation (Placement(transformation(extent={{120,10},{100,30}})));
  Modelica.Blocks.Sources.TimeTable set_QCooLoa3_flow(table=[0,0; 3600/9*3,0;
        3600/9*3,QCooLoa_flow_nominal; 3600/9*7,QCooLoa_flow_nominal; 3600/9*7,
        0; 3600,0])                                       "Cooling load"
    annotation (Placement(transformation(extent={{120,-50},{100,-30}})));
  Modelica.Blocks.Math.Gain gaiUsr1(k=1/usr1.dp_nominal)
    "Gain to normalise dp measurement" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={110,50})));
  Modelica.Blocks.Math.Gain gaiUsr2(k=1/usr2.dp_nominal)
    "Gain to normalise dp measurement" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={110,-10})));
  Modelica.Blocks.Math.Gain gaiUsr3(k=1/usr3.dp_nominal)
    "Gain to normalise dp measurement" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={110,-70})));

// District pipe network
  Buildings.Fluid.FixedResistances.PressureDrop preDroS2U3(
    redeclare package Medium = MediumCHW,
    final allowFlowReversal=true,
    final dp_nominal=0.3*dp_nominal,
    final m_flow_nominal=m_flow_nominal) "Flow resistance source 2 to user 3"
    annotation (Placement(transformation(extent={{-30,-50},{-10,-30}})));
  Buildings.Fluid.FixedResistances.PressureDrop preDroU3S2(
    redeclare package Medium = MediumCHW,
    final allowFlowReversal=true,
    final dp_nominal=0.3*dp_nominal,
    final m_flow_nominal=m_flow_nominal) "Flow resistance user 3 to source 2"
    annotation (Placement(transformation(extent={{30,-90},{10,-70}})));
  Buildings.Fluid.FixedResistances.PressureDrop preDroS2U2(
    redeclare package Medium = MediumCHW,
    final allowFlowReversal=true,
    final dp_nominal=0.3*dp_nominal,
    final m_flow_nominal=m_flow_nominal) "Flow resistance source 2 to user 2"
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Buildings.Fluid.FixedResistances.PressureDrop preDroU2S2(
    redeclare package Medium = MediumCHW,
    final allowFlowReversal=true,
    final dp_nominal=0.3*dp_nominal,
    final m_flow_nominal=m_flow_nominal) "Flow resistance user 2 to source 2"
    annotation (Placement(transformation(extent={{30,-30},{10,-10}})));
  Buildings.Fluid.FixedResistances.PressureDrop preDroS1U2(
    redeclare package Medium = MediumCHW,
    final allowFlowReversal=true,
    final dp_nominal=0.3*dp_nominal,
    final m_flow_nominal=m_flow_nominal) "Flow resistance source 1 to user 2"
    annotation (Placement(transformation(extent={{-30,10},{-10,30}})));
  Buildings.Fluid.FixedResistances.PressureDrop preDroU2S1(
    redeclare package Medium = MediumCHW,
    final allowFlowReversal=true,
    final dp_nominal=0.3*dp_nominal,
    final m_flow_nominal=m_flow_nominal) "Flow resistance user 2 to source 1"
    annotation (Placement(transformation(extent={{30,-10},{10,10}})));
  Buildings.Fluid.FixedResistances.PressureDrop preDroS1U1(
    redeclare package Medium = MediumCHW,
    final allowFlowReversal=true,
    final dp_nominal=0.3*dp_nominal,
    final m_flow_nominal=m_flow_nominal) "Flow resistance source 1 to user 3"
    annotation (Placement(transformation(extent={{-30,70},{-10,90}})));
  Buildings.Fluid.FixedResistances.PressureDrop preDroU1S1(
    redeclare package Medium = MediumCHW,
    final allowFlowReversal=true,
    final dp_nominal=0.3*dp_nominal,
    final m_flow_nominal=m_flow_nominal) "Flow resistance user 1 to source 1"
    annotation (Placement(transformation(extent={{30,30},{10,50}})));

equation
  connect(set_TRet.y,usr1. TSet) annotation (Line(points={{81,110},{90,110},{90,
          68},{71,68}},         color={0,0,127}));
  connect(set_TRet.y,usr2. TSet) annotation (Line(points={{81,110},{90,110},{90,
          8},{71,8}},           color={0,0,127}));
  connect(set_TRet.y,usr3. TSet) annotation (Line(points={{81,110},{90,110},{90,
          -52},{71,-52}},          color={0,0,127}));
  connect(usr3.yVal_actual, mulMax_yVal.u[1]) annotation (Line(points={{71,-64},
          {86,-64},{86,-110},{74,-110},{74,-110.667},{62,-110.667}}, color={0,0,
          127}));
  connect(usr2.yVal_actual, mulMax_yVal.u[2]) annotation (Line(points={{71,-4},{
          86,-4},{86,-110},{62,-110}},
                                   color={0,0,127}));
  connect(mulMax_yVal.y, hysCat.u)
    annotation (Line(points={{38,-110},{22,-110}}, color={0,0,127}));
  connect(set_dpUsr.y,conPI_pumChi1. u_s)
    annotation (Line(points={{-39,130},{-10,130},{-10,122}},
                                                   color={0,0,127}));
  connect(usr1.yVal_actual, mulMax_yVal.u[3]) annotation (Line(points={{71,56},
          {86,56},{86,-110},{62,-110},{62,-109.333}},color={0,0,127}));
  connect(preDroS2U3.port_b,usr3. port_a)
    annotation (Line(points={{-10,-40},{60,-40},{60,-50}}, color={0,127,255}));
  connect(usr3.port_b,preDroU3S2. port_a)
    annotation (Line(points={{60,-70},{60,-80},{30,-80}}, color={0,127,255}));
  connect(preDroS2U2.port_b,usr2. port_a) annotation (Line(points={{-10,0},{-4,
          0},{-4,20},{60,20},{60,10}},
                            color={0,127,255}));
  connect(usr2.port_b,preDroU2S2. port_a)
    annotation (Line(points={{60,-10},{60,-20},{30,-20}}, color={0,127,255}));
  connect(preDroS1U2.port_b,usr2. port_a) annotation (Line(points={{-10,20},{60,
          20},{60,10}},         color={0,127,255}));
  connect(usr2.port_b,preDroU2S1. port_a) annotation (Line(points={{60,-10},{60,
          -20},{34,-20},{34,0},{30,0}}, color={0,127,255}));
  connect(preDroS1U1.port_b,usr1. port_a)
    annotation (Line(points={{-10,80},{60,80},{60,70}}, color={0,127,255}));
  connect(usr1.port_b,preDroU1S1. port_a)
    annotation (Line(points={{60,50},{60,40},{30,40}}, color={0,127,255}));
  connect(set_QCooLoa1_flow.y,usr1. QCooLoa_flow)
    annotation (Line(points={{99,80},{94,80},{94,64},{71,64}},
                                                       color={0,0,127}));
  connect(set_QCooLoa2_flow.y,usr2. QCooLoa_flow)
    annotation (Line(points={{99,20},{94,20},{94,4},{71,4}},
                                                       color={0,0,127}));
  connect(set_QCooLoa3_flow.y,usr3. QCooLoa_flow)
    annotation (Line(points={{99,-40},{94,-40},{94,-56},{71,-56}},
                                                          color={0,0,127}));
  connect(usr1.dpUsr, gaiUsr1.u)
    annotation (Line(points={{71,52},{71,50},{98,50}}, color={0,0,127}));
  connect(usr2.dpUsr, gaiUsr2.u) annotation (Line(points={{71,-8},{71,-10},{98,-10}},
                             color={0,0,127}));
  connect(usr3.dpUsr, gaiUsr3.u) annotation (Line(points={{71,-68},{71,-70},{98,
          -70}},          color={0,0,127}));
  connect(gaiUsr1.y,mulMin_dpUsr. u[1]) annotation (Line(points={{121,50},{126,
          50},{126,129.333},{42,129.333}},
                                     color={0,0,127}));
  connect(gaiUsr2.y,mulMin_dpUsr. u[2]) annotation (Line(points={{121,-10},{126,
          -10},{126,130},{42,130}},                color={0,0,127}));
  connect(gaiUsr3.y,mulMin_dpUsr. u[3]) annotation (Line(points={{121,-70},{126,
          -70},{126,130.667},{42,130.667}},
                                          color={0,0,127}));
  connect(mulMin_dpUsr.y,conPI_pumChi1. u_m)
    annotation (Line(points={{18,130},{8,130},{8,110},{2,110}},
                                                             color={0,0,127}));
  connect(uTanDis.y, mTanSet_flow.u) annotation (Line(points={{-159,-10},{-142,-10}},
                              color={255,0,255}));
  connect(mChiBra2Set_flow.u, uRemCha.y) annotation (Line(points={{-152,-90},{-159,
          -90}},            color={255,0,255}));
  connect(chiBra2.mPumSet_flow,mChiBra2Set_flow. y)
    annotation (Line(points={{-126,-61},{-126,-90},{-128,-90}},
                                                             color={0,0,127}));
  connect(conPI_pumChi1.y,pumSup1. y) annotation (Line(points={{-10,99},{-10,94},
          {-42,94},{-42,58},{-70,58},{-70,52}},
                           color={0,0,127}));
  connect(preDroU1S1.port_b, pumSup1.port_a)
    annotation (Line(points={{10,40},{-60,40}}, color={0,127,255}));
  connect(preDroU2S1.port_b, pumSup1.port_a) annotation (Line(points={{10,0},{4,
          0},{4,40},{-60,40}}, color={0,127,255}));
  connect(pumSup1.port_b, cheValPumChi1.port_a)
    annotation (Line(points={{-80,40},{-100,40}}, color={0,127,255}));
  connect(cheValPumChi1.port_b, chi1.port_a2) annotation (Line(points={{-120,40},
          {-124,40},{-124,60}},           color={0,127,255}));
  connect(chi1.port_b2, preDroS1U1.port_a) annotation (Line(points={{-124,80},{
          -30,80}},      color={0,127,255}));
  connect(souCDW1.ports[1], chi1.port_a1) annotation (Line(points={{-160,90},{
          -136,90},{-136,80}},                  color={0,127,255}));
  connect(chi1.port_b1, sinCDW1.ports[1]) annotation (Line(points={{-136,60},{
          -136,50},{-160,50}},      color={0,127,255}));
  connect(TEvaLvgSet.y, chi1.TSet)
    annotation (Line(points={{-90,119},{-90,88},{-127,88},{-127,82}},
                                                           color={0,0,127}));
  connect(on.y, chi1.on) annotation (Line(points={{-130,118},{-133,118},{-133,
          82}},     color={255,0,255}));
  connect(preDroS1U2.port_a, chi1.port_b2) annotation (Line(points={{-30,20},{-36,
          20},{-36,80},{-124,80}}, color={0,127,255}));
  connect(uRemCha.y, or2.u1) annotation (Line(points={{-159,-90},{-156,-90},{-156,
          -116},{-70,-116},{-70,-102}},   color={255,0,255}));
  connect(hysCat.y, or2.u2) annotation (Line(points={{-2,-110},{-62,-110},{-62,-102}},
        color={255,0,255}));
  connect(preDroU3S2.port_b, netCon.port_aFroNet) annotation (Line(points={{10,-80},
          {-36,-80},{-36,-56},{-60,-56}}, color={0,127,255}));
  connect(preDroU2S2.port_b, netCon.port_aFroNet) annotation (Line(points={{10,-20},
          {4,-20},{4,-80},{-36,-80},{-36,-56},{-60,-56}}, color={0,127,255}));
  connect(netCon.port_bToNet, preDroS2U3.port_a) annotation (Line(points={{-60,-44},
          {-36,-44},{-36,-40},{-30,-40}}, color={0,127,255}));
  connect(netCon.port_bToNet, preDroS2U2.port_a) annotation (Line(points={{-60,-44},
          {-36,-44},{-36,0},{-30,0}}, color={0,127,255}));
  connect(tanBra.mTanBot_flow,conRemCha. mTanBot_flow)
    annotation (Line(points={{-92,-39},{-92,-10},{-81,-10}}, color={0,0,127}));
  connect(conRemCha.uAva, or2.y) annotation (Line(points={{-58,-6},{-52,-6},{-52,
          -72},{-70,-72},{-70,-78}},
                     color={255,0,255}));
  connect(mTanSet_flow.y,conRemCha. mTanSet_flow) annotation (Line(points={{-118,
          -10},{-100,-10},{-100,-2},{-81,-2}}, color={0,0,127}));
  connect(uRemCha.y,conRemCha. uRemCha) annotation (Line(points={{-159,-90},{-156,
          -90},{-156,-116},{-46,-116},{-46,-2},{-58,-2}},
        color={255,0,255}));
  connect(conRemCha.yPumSup,netCon. yPumSup)
    annotation (Line(points={{-72,-21},{-72,-39}}, color={0,0,127}));
  connect(conRemCha.yValSup,netCon. yValSup)
    annotation (Line(points={{-68,-21},{-68,-39}}, color={0,0,127}));
  connect(chiBra2.port_b, tanBra.port_aFroChi)
    annotation (Line(points={{-120,-44},{-110,-44}}, color={0,127,255}));
  connect(chiBra2.port_a, tanBra.port_bToChi)
    annotation (Line(points={{-120,-56},{-110,-56}}, color={0,127,255}));
  connect(tanBra.port_bToNet, netCon.port_aFroChi)
    annotation (Line(points={{-90,-44},{-80,-44}}, color={0,127,255}));
  connect(tanBra.port_aFroNet, netCon.port_bToChi)
    annotation (Line(points={{-90,-56},{-80,-56}}, color={0,127,255}));

    annotation (
        Diagram(coordinateSystem(extent={{-180,-120},{140,140}})), Icon(
        coordinateSystem(extent={{-100,-100},{100,100}})),
    Documentation(info="<html>
<p>
This is the base model of a district system model with
two CHW sources and three users with the following structure:
</p>
<p align=\"center\">
<img alt=\"DualSource\"
src=\"modelica://Buildings/Resources/Images/Fluid/Storage/DualSource.png\"/>
</p>
<p>
The first source is a simplified CHW plant with only a chiller,
a single supply pump, and a check valve (with series resistance built in).
This supply pump is controlled to ensure that all users have enough pressure head.
</p>
<p>
The second source has a chiller and a stratified CHW tank. Its piping is arranged
in a way that allows the tank to be charged remotely by the other source.
Its supply pump is controlled to maintain the flow rate setpoint of the tank.
This plant is disconnected when the largest position of user control valves
less than 5% open and connected back when this value is higher than 10%.
</p>
<p>
The timetables give the system the following behaviour:
</p>
<table summary= \"system modes\" border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<thead>
  <tr>
    <th>Time slots</th>
    <th>1</th>
    <th>2</th>
    <th>3</th>
    <th>4</th>
    <th>5</th>
    <th>6</th>
    <th>7</th>
    <th>8</th>
    <th>9</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>User 1</td>
    <td>-</td>
    <td>Has load</td>
    <td>Has load</td>
    <td>Has load</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>User 2</td>
    <td>-</td>
    <td>-</td>
    <td>Has load</td>
    <td>Has load</td>
    <td>Has load</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>User 3</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>Has load</td>
    <td>Has load</td>
    <td>Has load</td>
    <td>Has load</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Tank <br>(being charged)</td>
    <td>Local</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>Remote</td>
    <td>Remote</td>
    <td>-</td>
  </tr>
</tbody>
</table>
</html>", revisions="<html>
<ul>
<li>
May 16, 2022 by Hongxiang Fu:<br/>
First implementation. This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2859\">#2859</a>.
</li>
</ul>
</html>"));
end PartialDualSource;