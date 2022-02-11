within Buildings.Examples.ScalableBenchmarks.ZoneScaling.EnergyPlus;
model LargeBuilding "Model of a large building with EnergyPlus envelope model"
  extends Modelica.Icons.Example;
  extends
    Buildings.Examples.ScalableBenchmarks.ZoneScaling.BaseClasses.HVACMultiFloorBuilding(
    bldgSize=Buildings.Examples.ScalableBenchmarks.ZoneScaling.BaseClasses.Types.BuildingSize.TwoFloors,
    redeclare final Buildings.Examples.ScalableBenchmarks.ZoneScaling.EnergyPlus.BaseClasses.LargeOfficeFloor flo(floId=0:(numFlo - 1)),
    redeclare final Buildings.Examples.VAVReheat.BaseClasses.Guideline36 hvac);

protected
  parameter String idfName=Modelica.Utilities.Files.loadResource(
    "modelica://Buildings/Resources/Data/Examples/ZoneScaling/" +
    "ScaledLargeOfficeNew2004_Chicago_" + String(numFlo) + "floors.idf")
    "Name of the IDF file";

  parameter String epwName = Modelica.Utilities.Files.loadResource(
    "modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.epw")
    "Name of the weather file";

  inner Buildings.ThermalZones.EnergyPlus.Building building(
    idfName=idfName,
    weaName=weaName,
    epwName=epwName,
    computeWetBulbTemperature=false)
    "Building-level declarations"
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));

    annotation (
experiment(
      StopTime=432000,
      Tolerance=1e-05),
Documentation(revisions="<html>
<ul>
<li>
March 25, 2021, by Baptiste Ravache:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>
Example model of a large office building. By default,
the model has 2 floors and 10 thermal zones that are 
supplied by 2 multizone VAV air handling units.<br/>
The size of the building can be scaled by selecting parameter
<code>bldgSize</code> from the enumeration
<a href=\"modelica://Buildings.Examples.ScalableBenchmarks.ZoneScaling.BaseClasses.Types.BuildingSize\">
Buildings.Examples.ScalableBenchmarks.ZoneScaling.BaseClasses.Types.BuildingSize</a>.
<br/>
The thermal zones are modeled using
<a href=\"modelica://Buildings.ThermalZones.EnergyPlus.ThermalZone\">
Buildings.ThermalZones.EnergyPlus.ThermalZone</a> objects.
</p>
</html>"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Examples/ScalableBenchmarks/ZoneScaling/EnergyPlus/LargeBuilding.mos"
        "Simulate and Plot"));
end LargeBuilding;