within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Economizers.Subsequences.Validation;
model HeatExchangerPump "Validate the control of heat exchanger pump"
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Economizers.Subsequences.HeatExchangerPump wsePum
    "Economizer heat exchanger pump control"
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse ecoSta(
    final width=0.8,
    final period=3600) "Water side economizer enable/disable status"
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp entWSETem(
    final height=6,
    final duration=3600,
    final offset=285.15)
    "Economizer upstream chilled water temperature"
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse pumOn(
    final width=0.8,
    final period=3600)
    "Pump proven on"
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp entHexTem(
    final height=8,
    final duration=3600,
    final offset=283.15)
    "Entering heat exchanger return chilled water temperature"
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));

equation
  connect(ecoSta.y,wsePum. uWSE) annotation (Line(points={{-38,70},{0,70},{0,8},
          {18,8}},    color={255,0,255}));
  connect(pumOn.y, wsePum.uPum) annotation (Line(points={{-38,30},{-10,30},{-10,
          2},{18,2}}, color={255,0,255}));
  connect(entWSETem.y, wsePum.TEntWSE) annotation (Line(points={{-38,-30},{-10,-30},
          {-10,-3},{18,-3}}, color={0,0,127}));
  connect(entHexTem.y, wsePum.TEntHex) annotation (Line(points={{-38,-70},{0,-70},
          {0,-8},{18,-8}}, color={0,0,127}));
annotation (
 experiment(StopTime=3600.0, Tolerance=1e-06),
  __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/ASHRAE/PrimarySystem/ChillerPlant/Economizers/Subsequences/Validation/HeatExchangerPump.mos"
    "Simulate and plot"),
  Documentation(info="<html>
<p>
This example validates
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Economizers.Subsequences.HeatExchangerPump\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Economizers.Subsequences.HeatExchangerPump</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
July 15, 2022, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"),
Icon(graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent = {{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points = {{-36,60},{64,0},{-36,-60},{-36,60}})}),Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HeatExchangerPump;