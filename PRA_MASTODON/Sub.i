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
  type = GeneratedMesh
  nx = 1
  ny = 1
  nz = 5
  xmin = -0.5
  ymin = -0.5
  zmin = 0.0
  xmax = 0.5
  ymax = 0.5
  zmax = 5.0
  dim = 3
[]

[GlobalParams]
  displacements = 'disp_x disp_y disp_z'
[]

[Variables]
  [./disp_x]
  [../]
  [./disp_y]
  [../]
  [./disp_z]
  [../]
[]

[AuxVariables]
  [./vel_x]
  [../]
  [./accel_x]
  [../]
  [./vel_y]
  [../]
  [./accel_y]
  [../]
  [./vel_z]
  [../]
  [./accel_z]
  [../]
  [./stress_xy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_yz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_zx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_xy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_yz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_zx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_yy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_zz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_yy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_zz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./layer_id]
    order = CONSTANT
    family = MONOMIAL
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
  [./uniform_shear]
    type = UniformDistribution
    lower_bound = 100000000
    upper_bound = 200000000
  [../]
  [./uniform_dens]
    type = UniformDistribution
    lower_bound = 1500
    upper_bound = 2500
  [../]
[]

[Samplers]
  [./sample]
    type = MonteCarloSampler
    # n_samples = 1
    distributions = 'uniform_shear uniform_dens' # uniform_zeta uniform_eta
    execute_on = INITIAL # create random numbers on initial and use them for each timestep
    num_rows = 50
  [../]
[]

[MultiApps]
  [./sub]
    # creates sub files for each monte carlo sample and each scaled ground motion
    # Total number of simulations = number_of_bins * num_gms * n_samples
    type = SamplerTransientMultiApp
    input_files = 'SubSub.i'
    sampler = sample
    execute_on = TIMESTEP_BEGIN
  [../]
[]

[Transfers]
  [./sub]
    # transfers monte carlo samples to multiapp
    type = SamplerTransfer
    multi_app = sub
    parameters = 'Materials/elastic_soil/shear_modulus Materials/density/prop_values' # Materials/material_zeta/prop_values Materials/material_eta/prop_values
    to_control = 'stochastic'
    execute_on = INITIAL
    check_multiapp_execute_on = false
  [../]
  [./transfer]
    # transfers scaled ground motions to multiapp
    type = PiecewiseFunctionTransfer
    multi_app = sub
    direction = to_multiapp
    to_function = accel_bottom # name of function in subsub.i which uses the scaled ground motions
    from_function = accel_bottom # name of the function in sub.i, which receives the scaled ground motions
  [../]
[]

[Functions]
  [./accel_bottom]
    type = PiecewiseLinear
    data_file = 'Ormsby_50Hz.csv'
    format = columns
    scale_factor = 1.0
    xy_in_file_only = false
  [../]
[]

[Executioner]
  type = Transient
  end_time = 3.0
  dt = 0.005
[]

# [VectorPostprocessors]
#   [./data]
#     type = SamplerData
#     sampler = sample
#     execute_on = 'INITIAL'
#   [../]
# []
[Postprocessors]
  [./accelx_top]
    type = PointValue
    point = '0.0 0.0 5.0'
    variable = accel_x
  [../]
  # [./accelx_top1]
  #   type = PointValue
  #   point = '0.0 0.0 19.0'
  #   variable = accel_x
  # [../]
  # [./accelx_mid]
  #   type = PointValue
  #   point = '0.0 0.0 10.0'
  #   variable = accel_x
  # [../]
  [./accelx_bot]
    type = PointValue
    point = '0.0 0.0 0.0'
    variable = accel_x
  [../]
[]

[VectorPostprocessors]
  # [./accel_hist]
  #   type = ResponseHistoryBuilder
  #   variables = 'accel_x'
  #   nodes = '0 20'
  # [../]
  # [./accel_spec]
  #   type = ResponseSpectraCalculator
  #   vectorpostprocessor = accel_hist
  #   regularize_dt = 0.01
  #   outputs = out
  # [../]
  [./data]
    type = SamplerData
    sampler = sample
    execute_on = 'INITIAL'
  [../]
[]

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
  print_linear_residuals = true
  # print_nonlinear_residuals = true
  [./out]
   type = CSV
   execute_on = 'TIMESTEP_BEGIN'
   file_base = Resp_Spec_25Hz
  [../]
[]
