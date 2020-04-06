[Mesh]
  type = GeneratedMesh
  dim = 2
[]

[Variables]
  [./u]
  [../]
[]

[UserObjects]
  [./motions]
    type = GroundMotionReader
    pattern = '../../data/Ormsby_*.csv'
  [../]
  [./hazard]
    type = HazardCurve
    filename = '../../data/hazard.csv'
    number_of_bins = 2
    ground_motions = motions
    reference_acceleration = 1.0
  [../]
[]

[Problem]
  type = FEProblem
  solve = false
  kernel_coverage_check = false
[]

[MultiApps]
  [./run_hazard]
    type = HazardCurveMultiApp
    execute_on = initial
    hazard = hazard
    input_files = 'hazard_curve_sub.i'
  [../]
[]

[Executioner]
  type = Steady
[]
