within Buildings.Controls.OBC.Utilities.PIDWithAutotuning.Relay.Validation;
model NormalizedTimeDelay "Test model for NormalizedTimeDelay"
  Buildings.Controls.OBC.Utilities.PIDWithAutotuning.Relay.NormalizedTimeDelay norTimDel(gamma=4)
    "Calculate the normalized time delay"
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable RefDat(table=[0,0,
        2.051; 0.002,0,2.051; 0.004,0,2.051; 0.006,0,2.051; 0.008,0,2.051; 0.01,
        0,2.051; 0.012,0,2.051; 0.014,0,2.051; 0.016,0,2.051; 0.018,0,2.051;
        0.02,0,2.051; 0.022,0,2.051; 0.024,0,2.051; 0.026,0,2.051; 0.028,0,
        2.051; 0.03,0,2.051; 0.032,0,2.051; 0.034,0,2.051; 0.036,0,2.051; 0.038,
        0,2.051; 0.04,0,2.051; 0.042,0,2.051; 0.044,0,2.051; 0.046,0,2.051;
        0.048,0,2.051; 0.05,0,2.051; 0.052,0,2.051; 0.054,0,2.051; 0.056,0,
        2.051; 0.058,0,2.051; 0.06,0,2.051; 0.062,0,2.051; 0.064,0,2.051; 0.066,
        0,2.051; 0.068,0,2.051; 0.07,0,2.051; 0.072,0,2.051; 0.074,0,2.051;
        0.076,0,2.051; 0.078,0,2.051; 0.08,0,2.051; 0.082,0,2.051; 0.084,0,
        2.051; 0.086,0,2.051; 0.088,0,2.051; 0.09,0,2.051; 0.092,0,2.051; 0.094,
        0,2.051; 0.096,0,2.051; 0.098,0,2.051; 0.1,0,2.051; 0.1,0,2.051; 0.1,0,
        2.051; 0.102,0,2.051; 0.104,0,2.051; 0.106,0,2.051; 0.108,0,2.051; 0.11,
        0,2.051; 0.112,0,2.051; 0.114,0,2.051; 0.116,0,2.051; 0.118,0,2.051;
        0.12,0,2.051; 0.122,0,2.051; 0.124,0,2.051; 0.126,0,2.051; 0.128,0,
        2.051; 0.13,0,2.051; 0.132,0,2.051; 0.134,0,2.051; 0.136,0,2.051; 0.138,
        0,2.051; 0.14,0,2.051; 0.142,0,2.051; 0.144,0,2.051; 0.146,0,2.051;
        0.148,0,2.051; 0.15,0,2.051; 0.152,0,2.051; 0.154,0,2.051; 0.156,0,
        2.051; 0.158,0,2.051; 0.16,0,2.051; 0.162,0,2.051; 0.164,0,2.051; 0.166,
        0,2.051; 0.168,0,2.051; 0.17,0,2.051; 0.172,0,2.051; 0.174,0,2.051;
        0.176,0,2.051; 0.178,0,2.051; 0.18,0,2.051; 0.182,0,2.051; 0.184,0,
        2.051; 0.186,0,2.051; 0.188,0,2.051; 0.19,0,2.051; 0.192,0,2.051; 0.194,
        0,2.051; 0.196,0,2.051; 0.198,0,2.051; 0.2,0,2.051; 0.202,0,2.051;
        0.204,0,2.051; 0.206,0,2.051; 0.208,0,2.051; 0.21,0,2.051; 0.212,0,
        2.051; 0.214,0,2.051; 0.216,0,2.051; 0.218,0,2.051; 0.22,0,2.051; 0.222,
        0,2.051; 0.224,0,2.051; 0.226,0,2.051; 0.228,0,2.051; 0.23,0,2.051;
        0.232,0,2.051; 0.234,0,2.051; 0.236,0,2.051; 0.238,0,2.051; 0.24,0,
        2.051; 0.242,0,2.051; 0.244,0,2.051; 0.246,0,2.051; 0.248,0,2.051; 0.25,
        0,2.051; 0.252,0,2.051; 0.254,0,2.051; 0.256,0,2.051; 0.258,0,2.051;
        0.26,0,2.051; 0.262,0,2.051; 0.264,0,2.051; 0.266,0,2.051; 0.268,0,
        2.051; 0.27,0,2.051; 0.272,0,2.051; 0.274,0,2.051; 0.276,0,2.051; 0.278,
        0,2.051; 0.28,0,2.051; 0.282,0,2.051; 0.284,0,2.051; 0.286,0,2.051;
        0.288,0,2.051; 0.29,0,2.051; 0.292,0,2.051; 0.294,0,2.051; 0.296,0,
        2.051; 0.298,0,2.051; 0.3,0,2.051; 0.3,1,1; 0.3,1,1; 0.302,1,1; 0.304,1,
        1; 0.306,1,1; 0.308,1,1; 0.31,1,1; 0.312,1,1; 0.314,1,1; 0.316,1,1;
        0.318,1,1; 0.32,1,1; 0.322,1,1; 0.324,1,1; 0.326,1,1; 0.328,1,1; 0.33,1,
        1; 0.332,1,1; 0.334,1,1; 0.336,1,1; 0.338,1,1; 0.34,1,1; 0.342,1,1;
        0.344,1,1; 0.346,1,1; 0.348,1,1; 0.35,1,1; 0.352,1,1; 0.354,1,1; 0.356,
        1,1; 0.358,1,1; 0.36,1,1; 0.362,1,1; 0.364,1,1; 0.366,1,1; 0.368,1,1;
        0.37,1,1; 0.372,1,1; 0.374,1,1; 0.376,1,1; 0.378,1,1; 0.38,1,1; 0.382,1,
        1; 0.384,1,1; 0.386,1,1; 0.388,1,1; 0.39,1,1; 0.392,1,1; 0.394,1,1;
        0.396,1,1; 0.398,1,1; 0.4,1,1; 0.402,1,1; 0.404,1,1; 0.406,1,1; 0.408,1,
        1; 0.41,1,1; 0.412,1,1; 0.414,1,1; 0.416,1,1; 0.418,1,1; 0.42,1,1;
        0.422,1,1; 0.424,1,1; 0.426,1,1; 0.428,1,1; 0.43,1,1; 0.432,1,1; 0.434,
        1,1; 0.436,1,1; 0.438,1,1; 0.44,1,1; 0.442,1,1; 0.444,1,1; 0.446,1,1;
        0.448,1,1; 0.45,1,1; 0.452,1,1; 0.454,1,1; 0.456,1,1; 0.458,1,1; 0.46,1,
        1; 0.462,1,1; 0.464,1,1; 0.466,1,1; 0.468,1,1; 0.47,1,1; 0.472,1,1;
        0.474,1,1; 0.476,1,1; 0.478,1,1; 0.48,1,1; 0.482,1,1; 0.484,1,1; 0.486,
        1,1; 0.488,1,1; 0.49,1,1; 0.492,1,1; 0.494,1,1; 0.496,1,1; 0.498,1,1;
        0.5,1,1; 0.502,1,1; 0.504,1,1; 0.506,1,1; 0.508,1,1; 0.51,1,1; 0.512,1,
        1; 0.514,1,1; 0.516,1,1; 0.518,1,1; 0.52,1,1; 0.522,1,1; 0.524,1,1;
        0.526,1,1; 0.528,1,1; 0.53,1,1; 0.532,1,1; 0.534,1,1; 0.536,1,1; 0.538,
        1,1; 0.54,1,1; 0.542,1,1; 0.544,1,1; 0.546,1,1; 0.548,1,1; 0.55,1,1;
        0.552,1,1; 0.554,1,1; 0.556,1,1; 0.558,1,1; 0.56,1,1; 0.562,1,1; 0.564,
        1,1; 0.566,1,1; 0.568,1,1; 0.57,1,1; 0.572,1,1; 0.574,1,1; 0.576,1,1;
        0.578,1,1; 0.58,1,1; 0.582,1,1; 0.584,1,1; 0.586,1,1; 0.588,1,1; 0.59,1,
        1; 0.592,1,1; 0.594,1,1; 0.596,1,1; 0.598,1,1; 0.6,1,1; 0.602,1,1;
        0.604,1,1; 0.606,1,1; 0.608,1,1; 0.61,1,1; 0.612,1,1; 0.614,1,1; 0.616,
        1,1; 0.618,1,1; 0.62,1,1; 0.622,1,1; 0.624,1,1; 0.626,1,1; 0.628,1,1;
        0.63,1,1; 0.632,1,1; 0.634,1,1; 0.636,1,1; 0.638,1,1; 0.64,1,1; 0.642,1,
        1; 0.644,1,1; 0.646,1,1; 0.648,1,1; 0.65,1,1; 0.652,1,1; 0.654,1,1;
        0.656,1,1; 0.658,1,1; 0.66,1,1; 0.662,1,1; 0.664,1,1; 0.666,1,1; 0.668,
        1,1; 0.67,1,1; 0.672,1,1; 0.674,1,1; 0.676,1,1; 0.678,1,1; 0.68,1,1;
        0.682,1,1; 0.684,1,1; 0.686,1,1; 0.688,1,1; 0.69,1,1; 0.692,1,1; 0.694,
        1,1; 0.696,1,1; 0.698,1,1; 0.7,1,1; 0.7,1.5,0.709; 0.7,1.5,0.709; 0.702,
        1.5,0.709; 0.704,1.5,0.709; 0.706,1.5,0.709; 0.708,1.5,0.709; 0.71,1.5,
        0.709; 0.712,1.5,0.709; 0.714,1.5,0.709; 0.716,1.5,0.709; 0.718,1.5,
        0.709; 0.72,1.5,0.709; 0.722,1.5,0.709; 0.724,1.5,0.709; 0.726,1.5,
        0.709; 0.728,1.5,0.709; 0.73,1.5,0.709; 0.732,1.5,0.709; 0.734,1.5,
        0.709; 0.736,1.5,0.709; 0.738,1.5,0.709; 0.74,1.5,0.709; 0.742,1.5,
        0.709; 0.744,1.5,0.709; 0.746,1.5,0.709; 0.748,1.5,0.709; 0.75,1.5,
        0.709; 0.752,1.5,0.709; 0.754,1.5,0.709; 0.756,1.5,0.709; 0.758,1.5,
        0.709; 0.76,1.5,0.709; 0.762,1.5,0.709; 0.764,1.5,0.709; 0.766,1.5,
        0.709; 0.768,1.5,0.709; 0.77,1.5,0.709; 0.772,1.5,0.709; 0.774,1.5,
        0.709; 0.776,1.5,0.709; 0.778,1.5,0.709; 0.78,1.5,0.709; 0.782,1.5,
        0.709; 0.784,1.5,0.709; 0.786,1.5,0.709; 0.788,1.5,0.709; 0.79,1.5,
        0.709; 0.792,1.5,0.709; 0.794,1.5,0.709; 0.796,1.5,0.709; 0.798,1.5,
        0.709; 0.8,1.5,0.709; 0.802,1.5,0.709; 0.804,1.5,0.709; 0.806,1.5,0.709;
        0.808,1.5,0.709; 0.81,1.5,0.709; 0.812,1.5,0.709; 0.814,1.5,0.709;
        0.816,1.5,0.709; 0.818,1.5,0.709; 0.82,1.5,0.709; 0.822,1.5,0.709;
        0.824,1.5,0.709; 0.826,1.5,0.709; 0.828,1.5,0.709; 0.83,1.5,0.709; 0.83,
        1.5,0.709; 0.83,1.5,0.709; 0.832,1.5,0.709; 0.834,1.5,0.709; 0.836,1.5,
        0.709; 0.838,1.5,0.709; 0.84,1.5,0.709; 0.842,1.5,0.709; 0.844,1.5,
        0.709; 0.846,1.5,0.709; 0.848,1.5,0.709; 0.85,1.5,0.709; 0.85,2,0.494;
        0.85,2,0.494; 0.852,2,0.494; 0.854,2,0.494; 0.856,2,0.494; 0.858,2,
        0.494; 0.86,2,0.494; 0.862,2,0.494; 0.864,2,0.494; 0.866,2,0.494; 0.868,
        2,0.494; 0.87,2,0.494; 0.872,2,0.494; 0.874,2,0.494; 0.876,2,0.494;
        0.878,2,0.494; 0.88,2,0.494; 0.882,2,0.494; 0.884,2,0.494; 0.886,2,
        0.494; 0.888,2,0.494; 0.89,2,0.494; 0.892,2,0.494; 0.894,2,0.494; 0.896,
        2,0.494; 0.898,2,0.494; 0.9,2,0.494; 0.902,2,0.494; 0.904,2,0.494;
        0.906,2,0.494; 0.908,2,0.494; 0.91,2,0.494; 0.912,2,0.494; 0.914,2,
        0.494; 0.916,2,0.494; 0.918,2,0.494; 0.92,2,0.494; 0.922,2,0.494; 0.924,
        2,0.494; 0.926,2,0.494; 0.928,2,0.494; 0.93,2,0.494; 0.932,2,0.494;
        0.934,2,0.494; 0.936,2,0.494; 0.938,2,0.494; 0.94,2,0.494; 0.942,2,
        0.494; 0.944,2,0.494; 0.946,2,0.494; 0.948,2,0.494; 0.95,2,0.494; 0.952,
        2,0.494; 0.954,2,0.494; 0.956,2,0.494; 0.958,2,0.494; 0.96,2,0.494;
        0.962,2,0.494; 0.964,2,0.494; 0.966,2,0.494; 0.968,2,0.494; 0.97,2,
        0.494; 0.972,2,0.494; 0.974,2,0.494; 0.976,2,0.494; 0.978,2,0.494; 0.98,
        2,0.494; 0.982,2,0.494; 0.984,2,0.494; 0.986,2,0.494; 0.988,2,0.494;
        0.99,2,0.494; 0.992,2,0.494; 0.994,2,0.494; 0.996,2,0.494; 0.998,2,
        0.494; 1,2,0.494], extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.HoldLastPoint)
    "Data for validating the normalizedTimeDelay block"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));

equation
  connect(RefDat.y[1], norTimDel.rho)
    annotation (Line(points={{-38,0},{-10,0}}, color={0,0,127}));
  annotation (
      experiment(
      StopTime=1.0,
      Tolerance=1e-06),
    __Dymola_Commands(
      file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/Utilities/PIDWithAutotuning/Relay/Validation/NormalizedTimeDelay.mos" "Simulate and plot"),
      Icon(
      coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}}),
      graphics={
        Ellipse(
          lineColor={75,138,73},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-100,-100},{100,100}}),
        Polygon(
          lineColor={0,0,255},
          fillColor={75,138,73},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-36,60},{64,0},{-36,-60},{-36,60}})}), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>
June 1, 2022, by Sen Huang:<br/>
First implementation<br/>
</li>
</ul>
</html>", info="<html>
<p>
Validation test for the block
<a href=\"modelica://Buildings.Controls.OBC.Utilities.PIDWithAutotuning.Relay.NormalizedTimeDelay\">
Buildings.Controls.OBC.Utilities.PIDWithAutotuning.Relay.NormalizedTimeDelay</a>.
</p>
</html>"));
end NormalizedTimeDelay;