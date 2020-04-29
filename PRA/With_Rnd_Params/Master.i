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
    pattern = 'GMs/GM*.csv'
  [../]
  [./hazard]
    # Bins hazard curves into number_of_bins and scales ground motions
    type = HazardCurve
    filename = 'GMs/Haz.csv'
    number_of_bins = 1
    ground_motions = motions
    reference_acceleration = 0.252
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
    function = accel_x # Function in sub.i that receives the scaled ground motions
    component = x # component that is being transferred
  [../]
[]

[Executioner]
  # governs the PRA execution in case of conflict with sub.i or subsub.i
  type = Transient
  end_time = 45.0
  dt = 0.05
[]

[Outputs]
  csv = true
[]
