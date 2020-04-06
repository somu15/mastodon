# Test to demonstrate the Seismic Probabilistic Risk Assessment (SPRA)
# infrastructure in MASTODON. This test involves three input files:
#
# 1. master.i - The Master file that bins the hazard curve and scales ground
# motions for each bin for use in probabilistic simulations.
#
# 2. sub.i - The file that obtains the scaled ground motions from master.i and
# transfers these ground motions as inputs to the finite-element model and also
# contains the parameters for probabilistic simulation. This file acts as the
# sub file for master.i and master file for subsub.i.
#
# 3. subsub.i - The file that contains the finite-element model.

[Mesh]
  # dummy mesh
  type = GeneratedMesh
  dim = 3
[]

[Variables]
  # dummy variables
  [./u]
  [../]
[]

[Problem]
  solve = false
  kernel_coverage_check = false
[]

[UserObjects]
  [./motions]
    # Reads ground motion files for input
    type = GroundMotionReader
    pattern = 'gm_data/Ormsby_*.csv'
  [../]
  [./hazard]
    # Bins hazard curves into number_of_bins and scales ground motions
    type = HazardCurve
    filename = 'gm_data/hazard.csv'
    number_of_bins = 1
    ground_motions = motions
    reference_acceleration = 0.5
  [../]
[]

[MultiApps]
  [./run_hazard]
    type = HazardCurveMultiApp
    hazard = hazard
    input_files = 'Sub.i'
    execute_on = 'initial timestep_end'
  [../]
[]

[Transfers]
  [./transfer_x]
    # Transfers scaled ground motions to multiapp
    type = HazardCurveTransfer
    multi_app = run_hazard
    function = accel_bottom # Function in sub.i that receives the scaled ground motions
    component = x # component that is being transferred
  [../]
[]

[Executioner]
  # governs the PRA execution in case of conflict with sub.i or subsub.i
  type = Transient
  end_time = 3.0
  dt = 0.01
[]

# [Postprocessors]
#   [./accelx_top]
#     type = PointValue
#     point = '0.0 0.0 5.0'
#     variable = accel_x
#   [../]
#   # [./accelx_top1]
#   #   type = PointValue
#   #   point = '0.0 0.0 19.0'
#   #   variable = accel_x
#   # [../]
#   # [./accelx_mid]
#   #   type = PointValue
#   #   point = '0.0 0.0 10.0'
#   #   variable = accel_x
#   # [../]
#   [./accelx_bot]
#     type = PointValue
#     point = '0.0 0.0 0.0'
#     variable = accel_x
#   [../]
# []
#
# [VectorPostprocessors]
#   [./accel_hist]
#     type = ResponseHistoryBuilder
#     variables = 'accel_x'
#     nodes = '0 20'
#   [../]
#   [./accel_spec]
#     type = ResponseSpectraCalculator
#     vectorpostprocessor = accel_hist
#     regularize_dt = 0.01
#     outputs = out
#   [../]
#   [./data]
#     type = SamplerData
#     sampler = sample
#     execute_on = 'INITIAL'
#   [../]
# []
#
# [Outputs]
#   csv = true
#   exodus = true
#   perf_graph = true
#   print_linear_residuals = true
#   # print_nonlinear_residuals = true
#   [./out]
#    type = CSV
#    execute_on = 'final'
#    file_base = Resp_Spec
#   [../]
# []
#
[Outputs]
  csv = true
[]
# [Mesh]
#   type = GeneratedMesh
#   dim = 2
# []
#
# [Variables]
#   [./u]
#   [../]
# []
#
# [UserObjects]
#   [./motions]
#     type = GroundMotionReader
#     pattern = 'gm_data/Ormsby_*.csv'
#   [../]
#   [./hazard]
#     type = HazardCurve
#     filename = 'gm_data/hazard.csv'
#     number_of_bins = 1
#     ground_motions = motions
#     reference_acceleration = 0.5
#   [../]
# []
#
# [Problem]
#   type = FEProblem
#   solve = false
#   kernel_coverage_check = false
# []
#
# [MultiApps]
#   [./run_hazard]
#     type = HazardCurveMultiApp
#     execute_on = initial
#     hazard = hazard
#     input_files = 'Sub.i'
#   [../]
# []
#
# [Executioner]
#   type = Transient
#   end_time = 3.0
#   dt = 0.01
# []
