within Buildings.Templates.Components.Routing;
model MultipleToSingle "Multiple inlet port, single outlet ports"
  replaceable package Medium =
    Modelica.Media.Interfaces.PartialMedium "Medium in the component"
      annotation (choices(
        choice(redeclare package Medium = Buildings.Media.Air "Moist air"),
        choice(redeclare package Medium = Buildings.Media.Water "Water"),
        choice(redeclare package Medium =
            Buildings.Media.Antifreeze.PropyleneGlycolWater (
          property_T=293.15,
          X_a=0.40)
          "Propylene glycol water, 40% mass fraction")));
  parameter Integer nPorts
    "Number of ports"
    annotation(Evaluate=true, Dialog(group="Configuration"));
  parameter Boolean allowFlowReversal=true
    "Set to true to allow flow reversal, false restricts to design direction (ports_a -> port_b)"
    annotation (Evaluate=true, Dialog(tab="Assumptions"));
  // Diagnostics
   parameter Boolean show_T = false
    "Set to true if actual temperature at port is computed"
    annotation (
      Dialog(tab="Advanced", group="Diagnostics"),
      HideResult=true);
  Modelica.Fluid.Interfaces.FluidPorts_a ports_a[nPorts](
    redeclare each final package Medium = Medium,
    each m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
    each h_outflow(start=Medium.h_default, nominal=Medium.h_default))
    "Fluid connector a (positive design flow direction is from ports_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-40},{-90,40}}),
        iconTransformation(extent={{-110,-40},{-90,40}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(
    redeclare final package Medium = Medium,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
    h_outflow(start=Medium.h_default, nominal=Medium.h_default))
    "Fluid connectors b (positive design flow direction is from ports_a to port_b)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Medium.ThermodynamicState sta_a[nPorts]=
      Medium.setState_phX(ports_a.p,
                          noEvent(actualStream(ports_a.h_outflow)),
                          noEvent(actualStream(ports_a.Xi_outflow)))
      if show_T "Medium properties in ports_a";
  Medium.ThermodynamicState sta_b=
      Medium.setState_phX(port_b.p,
                          noEvent(actualStream(port_b.h_outflow)),
                          noEvent(actualStream(port_b.Xi_outflow)))
      if show_T "Medium properties in port_b";
equation
  for i in 1:nPorts loop
    connect(ports_a[i], port_b)
      annotation (Line(points={{-100,0},{100,0}}, color={0,127,255}));
  end for;
  annotation (
    defaultComponentName="rou",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
    Line( points={{100,0},{0,0}},
          color={0,0,0},
          thickness=1),
    Line( visible=nPorts <= 1,
          points={{0,0},{-100,0}},
          color={0,0,0},
          thickness=1),
        Line(visible=nPorts==2,
          points={{-100,50},{0,50},{0,-50},{-100,-50}},
          color={0,0,0},
          thickness=1),
        Text(
          extent={{-149,-114},{151,-154}},
          textColor={0,0,255},
          textString="%name")}),
    Diagram(
      coordinateSystem(preserveAspectRatio=false)));
end MultipleToSingle;