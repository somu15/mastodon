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

[Kernels]
  [./DynamicTensorMechanics]
    displacements = 'disp_x disp_y disp_z'
    zeta = 'zeta_rayleigh'
  [../]
  [./inertia_x]
    type = InertialForce
    variable = disp_x
    velocity = vel_x
    acceleration = accel_x
    beta = 0.25
    gamma = 0.5
    eta = 'eta_rayleigh'
  [../]
  [./inertia_y]
    type = InertialForce
    variable = disp_y
    velocity = vel_y
    acceleration = accel_y
    beta = 0.25
    gamma = 0.5
    eta = 'eta_rayleigh'
  [../]
  [./inertia_z]
    type = InertialForce
    variable = disp_z
    velocity = vel_z
    acceleration = accel_z
    beta = 0.25
    gamma = 0.5
    eta = 'eta_rayleigh'
  [../]
  [./gravity]
    type = Gravity
    variable = disp_z
    value = -9.81
  [../]
[]

[AuxKernels]
  [./accel_x]
    type = NewmarkAccelAux
    variable = accel_x
    displacement = disp_x
    velocity = vel_x
    beta = 0.25
    execute_on = timestep_end
  [../]
  [./vel_x]
    type = NewmarkVelAux
    variable = vel_x
    acceleration = accel_x
    gamma = 0.5
    execute_on = timestep_end
  [../]
  [./accel_y]
    type = NewmarkAccelAux
    variable = accel_y
    displacement = disp_y
    velocity = vel_y
    beta = 0.25
    execute_on = timestep_end
  [../]
  [./vel_y]
    type = NewmarkVelAux
    variable = vel_y
    acceleration = accel_y
    gamma = 0.5
    execute_on = timestep_end
  [../]
  [./accel_z]
    type = NewmarkAccelAux
    variable = accel_z
    displacement = disp_z
    velocity = vel_z
    beta = 0.25
    execute_on = timestep_end
  [../]
  [./vel_z]
    type = NewmarkVelAux
    variable = vel_z
    acceleration = accel_z
    gamma = 0.5
    execute_on = timestep_end
  [../]
  [./layer_id]
     type = UniformLayerAuxKernel
     variable = layer_id
     interfaces = '1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20.2'
     direction = '0.0 0.0 1.0'
     execute_on = initial
  [../]
[]

[BCs]
  [./bottom_z]
    type = PresetBC
    variable = disp_z
    boundary = 'back'
    value = 0.0
  [../]
  [./bottom_y]
    type = PresetBC
    variable = disp_y
    boundary = 'back'
    value = 0.0
  [../]
  [./bottom_accel]
    type = PresetAcceleration
    boundary = 'back'
    function = accel_bottom
    variable = 'disp_x'
    beta = 0.25
    acceleration = 'accel_x'
    velocity = 'vel_x'
  [../]
  [./Periodic]
    [./y_dir]
      variable = 'disp_x disp_y disp_z'
      primary = 'bottom'
      secondary = 'top'
      translation = '0.0 1.0 0.0'
    [../]
    [./x_dir]
      variable = 'disp_x disp_y disp_z'
      primary = 'left'
      secondary = 'right'
      translation = '1.0 0.0 0.0'
    [../]
  [../]
[]

[Functions]
  # PiecewiseLinear function that is receiving scaled GMs from sub.i. Inputs here are dummy.
  [./accel_bottom]
    type = PiecewiseLinear
    data_file = 'GM_00.csv'
    format = columns
    scale_factor = 1.0
    xy_in_file_only = false
  [../]
  [./initial_zz]
    type = ParsedFunction
    value = '-2000.0 * 9.81 * (20.0 - z)'
  [../]
  [./initial_xx]
    type = ParsedFunction
    value = '-2000.0 * 9.81 * (20.0 - z) * 0.3/0.7'
  [../]
  [./poiss_fun]
    type = ConstantFunction
    value = 1.0
  [../]
[]

[Materials]
  [./linear]
    type = ComputeIsotropicElasticityTensorSoil
    block = 0
    layer_variable = layer_id
    layer_ids = '0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19'
    poissons_ratio = '0.3 0.3 0.3 0.3 0.3 0.3 0.3 0.3 0.3 0.3 0.3 0.3 0.3 0.3 0.3 0.3 0.3 0.3 0.3 0.3'
    density = '2000.0 2000.0 2000.0 2000.0 2000.0 2000.0 2000.0 2000.0 2000.0 2000.0 2000.0 2000.0 2000.0 2000.0 2000.0 2000.0 2000.0 2000.0 2000.0 2000.0'
    shear_modulus = '125000000 118098000 111392000 103968000 96800000 89888000 83232000 76832000 70688000 64800000 59168000 53792000 48672000 43808000 39200000 34848000 30752000 26912000 23328000 20000000'
  [../]
  [./material_zeta]
    type = GenericConstantMaterial
    prop_names = 'zeta_rayleigh'
    prop_values = '0.000781'
  [../]
  [./material_eta]
    type = GenericConstantMaterial
    prop_names = 'eta_rayleigh'
    prop_values = '0.64'
  [../]
  [./strain]
    type = ComputeSmallStrain
    block = 0
    displacements = 'disp_x disp_y disp_z'
  [../]
  [./stress]
    type = ComputeLinearElasticStress
    block = 0
  [../]
[]

[Preconditioning]
  [./andy]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  type = Transient
  solve_type = NEWTON
  nl_abs_tol = 1e-3
  nl_rel_tol = 1e-3
  l_tol = 1e-3
  l_max_its = 20
  start_time = 0
  end_time = 48.125
  dt = 0.01
  timestep_tolerance = 1e-3
[]

[Postprocessors]
  [./accelx_top]
    type = PointValue
    point = '0.0 0.0 20.0'
    variable = accel_x
  [../]
  [./accelx_top1]
    type = PointValue
    point = '0.0 0.0 19.0'
    variable = accel_x
  [../]
  [./accelx_mid]
    type = PointValue
    point = '0.0 0.0 10.0'
    variable = accel_x
  [../]
  [./accelx_bot]
    type = PointValue
    point = '0.0 0.0 0.0'
    variable = accel_x
  [../]
[]

[Outputs]
  csv = true
  perf_graph = true
[]
