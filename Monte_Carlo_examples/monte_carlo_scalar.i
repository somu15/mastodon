[Mesh]
  type = GeneratedMesh
  nx = 1
  ny = 1
  nz = 20
  xmin = -0.5
  ymin = -0.5
  zmin = 0.0
  xmax = 0.5
  ymax = 0.5
  zmax = 20.0
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
  [./layer_id]
    order = CONSTANT
    family = MONOMIAL
  [../]
[]

[Distributions]
  [./uniform_zeta]
    type = UniformDistribution
    lower_bound = 0.0001
    upper_bound = 0.001
  [../]
  [./uniform_eta]
    type = UniformDistribution
    lower_bound = 0.5
    upper_bound = 0.7
  [../]
  [./uniform_a0]
    type = UniformDistribution
    lower_bound = 0.9
    upper_bound = 1.1
  [../]
[]

[Samplers]
  [./sample]
    type = MonteCarloSampler
    n_samples = 3
    distributions = 'uniform_zeta uniform_eta uniform_a0'
    execute_on = INITIAL # create random numbers on initial and use them for each timestep
  [../]
[]

[MultiApps]
  [./sub]
    type = SamplerTransientMultiApp
    input_files = sub_vector.i
    sampler = sample
  [../]
[]

[Transfers]
  [./sub]
    type = SamplerTransfer
    multi_app = sub
    parameters = 'Materials/material_zeta/prop_values Materials/material_eta/prop_values Material::stress_0/a0'
    to_control = 'stochastic'
    execute_on = INITIAL
    check_multiapp_execute_on = false
  [../]
[]

[Executioner]
  type = Transient
  start_time = 0
  end_time = 85.4
  dt = 0.1
[]

[Problem]
  solve = false
  kernel_coverage_check = false
[]

[VectorPostprocessors]
  [./data]
    type = SamplerData
    sampler = sample
    execute_on = 'INITIAL'
  [../]
[]

[Outputs]
  execute_on = 'FINAL'
  csv = true
[]
