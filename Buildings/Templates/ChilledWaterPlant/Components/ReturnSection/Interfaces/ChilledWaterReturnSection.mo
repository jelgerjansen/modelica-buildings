within Buildings.Templates.ChilledWaterPlant.Components.ReturnSection.Interfaces;
partial model ChilledWaterReturnSection
  extends Fluid.Interfaces.PartialOptionalFourPortInterface(
    redeclare final package Medium1=MediumCW,
    redeclare final package Medium2=MediumCHW,
    final hasMedium1=not is_airCoo,
    final hasMedium2=true);

  replaceable package MediumCW = Buildings.Media.Water
    constrainedby Modelica.Media.Interfaces.PartialMedium "Medium 1 in the component"
      annotation (Dialog(enable=not is_airCoo));
  replaceable package MediumCHW = Buildings.Media.Water
    constrainedby Modelica.Media.Interfaces.PartialMedium "Medium 2 in the component";

  parameter
    Buildings.Templates.ChilledWaterPlant.Components.Types.ChilledWaterReturnSection
    typ "Type of waterside economizer"
    annotation (Evaluate=true, Dialog(group="Configuration"));

  parameter Boolean is_airCoo "Is chiller plant air cooled";

  final parameter Boolean is_none=
    typ == Buildings.Templates.ChilledWaterPlant.Components.Types.ChilledWaterReturnSection.NoEconomizer;


  outer parameter String id
    "System identifier";
  outer parameter ExternData.JSONFile dat
    "External parameter file";

  Bus busCon "Control bus" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={0,100}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,100})));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false),
    graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}), Diagram(
        coordinateSystem(preserveAspectRatio=false)));

end ChilledWaterReturnSection;