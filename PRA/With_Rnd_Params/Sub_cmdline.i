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

[Distributions]
  # [./uniform_zeta]
  #   type = UniformDistribution
  #   lower_bound = 0.0001
  #   upper_bound = 0.001
  # [../]
  # [./uniform_eta]
  #   type = UniformDistribution
  #   lower_bound = 0.5
  #   upper_bound = 0.7
  # [../]
  [./zeta]
    type = BoostLognormal
    location = -6.5662
    scale = 0.3379
  [../]
  [./eta]
    type = BoostLognormal
    location = -3.3473
    scale = 0.3379
  [../]
[]

[Samplers]
  [./sample]
    type = MonteCarloSampler
    # n_samples = 1
    distributions = 'zeta eta' # uniform_zeta uniform_eta
    execute_on = 'PRE_MULTIAPP_SETUP' # create random numbers on initial and use them for each timestep
    num_rows = 1
  [../]
[]

[MultiApps]
  [./sub]
    # creates sub files for each monte carlo sample and each scaled ground motion
    # Total number of simulations = number_of_bins * num_gms * n_samples
    type = SamplerTransientMultiApp
    input_files = 'SubSub_NA.i'
    sampler = sample
    execute_on = TIMESTEP_BEGIN
  [../]
[]

[Transfers]
  # [./sub]
  #   # transfers monte carlo samples to multiapp
  #   type = SamplerTransfer
  #   multi_app = sub
  #   parameters = 'Materials/material_zeta Materials/material_eta' # Materials/material_zeta/prop_values Materials/material_eta/prop_values
  #   to_control = 'stochastic'
  #   execute_on = INITIAL
  #   check_multiapp_execute_on = false
  # [../]
  [./transfer]
    # transfers scaled ground motions to multiapp
    type = PiecewiseFunctionTransfer
    multi_app = sub
    direction = to_multiapp
    to_function = accel_bottom # name of function in subsub.i which uses the scaled ground motions
    from_function = accel_bottom # name of the function in sub.i, which receives the scaled ground motions
  [../]
[]

[Controls]
  [cmdline]
    type = MultiAppCommandLineControl
    multi_app = sub
    sampler = sample
    param_names = 'Mesh/xmax Mesh/ymax'
  []
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
