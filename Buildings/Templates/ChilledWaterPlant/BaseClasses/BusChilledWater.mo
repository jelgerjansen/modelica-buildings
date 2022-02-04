within Buildings.Templates.ChilledWaterPlant.BaseClasses;
expandable connector BusChilledWater
  "Generic control bus for chilled water classes"
  extends Modelica.Icons.SignalBus;

  parameter Integer nChi "Number of chillers";
  parameter Integer nPumPri "Number of primary pumps";
  parameter Integer nPumSec "Number of secondary pumps";

  Buildings.Templates.Components.Interfaces.Bus chi[nChi]
    annotation (HideResult=false);
  Buildings.Templates.Components.Interfaces.Bus valCHWChi[nChi]
    annotation (HideResult=false);
  Buildings.Templates.Components.Interfaces.Bus wse
    annotation (HideResult=false);
  Buildings.Templates.Components.Interfaces.Bus pumPri
    annotation (HideResult=false);
  Buildings.Templates.Components.Interfaces.Bus pumSec
    annotation (HideResult=false);

  annotation (
  defaultComponentName="busCon",
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Rectangle(
                  extent={{-20,2},{22,-2}},
                  lineColor={255,204,51},
                  lineThickness=0.5)}), Documentation(info="<html>

</html>"));
end BusChilledWater;