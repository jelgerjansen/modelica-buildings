within Buildings.Fluid.CHPs.Rankine.Validation;
model OrganicBottomingCycle "Example ORC model"
  extends Modelica.Icons.Example;

  parameter Buildings.Fluid.CHPs.Rankine.Data.WorkingFluids.R123 pro
    "Property record of the working fluid"
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  package MediumEva = Buildings.Media.Air "Medium in the evaporator";
  package MediumCon = Buildings.Media.Air "Medium in the condenser";
  parameter Modelica.Units.SI.MassFlowRate mEva_flow_nominal = 0.4
    "Medium flow rate in the evaporator";
  parameter Modelica.Units.SI.MassFlowRate mCon_flow_nominal = 1
    "Medium flow rate in the condenser";

  Buildings.Fluid.CHPs.Rankine.OrganicBottomingCycle ORC(
    preventHeatBackflow=true,
    pro=pro,
    TEva(displayUnit="degC") = 357.95,
    TCon(displayUnit="degC") = 298.15,
    etaExp=0.7) "Organic Rankine cycle"
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  Buildings.Fluid.HeatExchangers.EvaporatorCondenser eva(
    redeclare final package Medium = MediumEva,
    final allowFlowReversal=false,
    final m_flow_nominal=mEva_flow_nominal,
    final from_dp=false,
    final dp_nominal=0,
    final linearizeFlowResistance=true,
    final T_start=sinEva.T,
    final energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    final UA=50) "Evaporator"
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=180,
        origin={10,30})));

  Modelica.Blocks.Sources.Cosine TSou(
    amplitude=5,
    f=0.5,
    offset=ORC.TEva,
    y(unit="K",
      displayUnit="degC")) "Medium source temperature"
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Buildings.Fluid.Sources.MassFlowSource_T souEva(
    redeclare final package Medium = MediumEva,
    m_flow=mEva_flow_nominal,
    use_T_in=true,
    nPorts=1) "Source on the evaporator side"
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Buildings.Fluid.Sources.Boundary_pT sinCon(
    redeclare final package Medium = MediumCon,
    nPorts=1)
          "Sink on the condenser side"
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Buildings.Fluid.CHPs.Rankine.BaseClasses.HeaterCooler_Q con(
    redeclare final package Medium = MediumCon,
    final allowFlowReversal=false,
    final m_flow_nominal=mCon_flow_nominal,
    final from_dp=false,
    final dp_nominal=0,
    final T_start=sinCon.T,
    final energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState) "Condenser"
    annotation (Placement(transformation(extent={{20,-60},{0,-40}})));
  Buildings.Fluid.Sources.MassFlowSource_T souCon(
    redeclare final package Medium = MediumCon,
    m_flow=mCon_flow_nominal,
    T=288.15,
    nPorts=1) "Source on the condenser side"
    annotation (Placement(transformation(extent={{60,-60},{40,-40}})));
  Buildings.Fluid.Sources.Boundary_pT sinEva(
    redeclare final package Medium = MediumEva,
    nPorts=1) "Sink on the evaporator side"
    annotation (Placement(transformation(extent={{60,20},{40,40}})));
equation
  connect(eva.port_ref,ORC.port_a)  annotation (Line(points={{10,24},{10,0}},
                                           color={191,0,0}));
  connect(souEva.ports[1], eva.port_a)
    annotation (Line(points={{-20,30},{0,30}},   color={0,127,255}));
  connect(sinEva.ports[1], eva.port_b)
    annotation (Line(points={{40,30},{20,30}}, color={0,127,255}));
  connect(con.port_a,souCon. ports[1])
    annotation (Line(points={{20,-50},{40,-50}}, color={0,127,255}));
  connect(con.port_b,sinCon. ports[1])
    annotation (Line(points={{0,-50},{-20,-50}},   color={0,127,255}));
  connect(ORC.QCon_flow,con. Q_flow) annotation (Line(points={{21,-20},{30,-20},
          {30,-44},{22,-44}},color={0,0,127}));
  connect(TSou.y, souEva.T_in) annotation (Line(points={{-59,30},{-50,30},{-50,34},
          {-42,34}}, color={0,0,127}));
  connect(TSou.y, ORC.TUps) annotation (Line(points={{-59,30},{-50,30},{-50,-4},
          {-2,-4}}, color={0,0,127}));
annotation(experiment(StopTime=1, Tolerance=1e-6),
  __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Fluid/CHPs/Rankine/Validation/OrganicBottomingCycle.mos"
  "Simulate and plot"),
  Documentation(info="<html>
<p>
This model demonstrates the use of
<a href=\"modelica://Buildings.Fluid.CHPs.Rankine.OrganicBottomingCycle\">
Buildings.Fluid.CHPs.Rankine.BottomingCycle</a>.
Note that the component blocks reverse heat flow when the upstream fluid
temperature drops below the evaporator temperature.
</html>",revisions="<html>
<ul>
<li>
June 13, 2023, by Hongxiang Fu:<br/>
First implementation. This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/3433\">#3433</a>.
</li>
</ul>
</html>"));
end OrganicBottomingCycle;