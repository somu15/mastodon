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
     interfaces = '5.2'
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
    function = accel_bottome
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
  [./accel_bottom]
    type = PiecewiseLinear
    data_file = 'Ormsby.csv'
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
  # [./I_Soil]
  #   [./soil_all]
  #      block = 0
  #      layer_variable = layer_id
  #      layer_ids = '0'
  #      initial_soil_stress = 'initial_xx 0 0 0 initial_xx 0 0 0 initial_zz'
  #      poissons_ratio = '0.3'
  #      soil_type = 'gqh'
  #      number_of_points = 100
  #      ### GQ/H ####
  #      initial_shear_modulus = '125000000'
       # theta_1 = '-6.66'
       # theta_2 = '5.5'
       # theta_3 = '1.0'
       # theta_4 = '1.0'
       # theta_5 = '0.99'
  #      taumax = '292500'
  #      p_ref = '236841'
  #      ######
  #      density = '2000.0'
  #      a0 = 1.0
  #      a1 = 0.0
  #      a2 = 0.0
  #      b_exp = 0.0
  #   [../]
  # [../]
  [./sample_isoil]
    type = ComputeISoilStress
    soil_type = 'gqh'
    layer_variable = layer_id
    layer_ids = '0'
    theta_1 = '-6.66'
    theta_2 = '5.5'
    theta_3 = '1.0'
    theta_4 = '1.0'
    theta_5 = '0.99'
    taumax = '292500'
    initial_shear_modulus = '125000000'
    number_of_points = 10
    poissons_ratio = '0.3'
    initial_soil_stress = 'initial_xx 0 0 0 initial_xx 0 0 0 initial_zz'
  [../]
  [./sample_isoil_strain]
    type = ComputeIncrementalSmallStrain
    # block = '0'
    displacements = 'disp_x disp_y disp_z'
  [../]
  [./sample_isoil_elasticitytensor]
    type = ComputeIsotropicElasticityTensorSoil
    block = '0'
    shear_modulus = '125000000'
    poissons_ratio = '0.3'
    density = '2000'
    wave_speed_calculation = false
    layer_ids = '0'
    layer_variable = layer_id
  [../]
  [./material_zeta]
    type = GenericConstantMaterial
    block = 0
    prop_names = 'zeta_rayleigh'
    prop_values = '0.000781'
  [../]
  [./material_eta]
    type = GenericConstantMaterial
    block = 0
    prop_names = 'eta_rayleigh'
    prop_values = '0.64'
  [../]
  # [./material_shear]
  #   type = GenericConstantMaterial
  #   block = 0
  #   prop_names = 'init_shear'
  #   prop_values = '125000000.0'
  # [../]
[]

[Preconditioning]
  [./andy]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  type = Transient
  solve_type = PJFNK
  nl_abs_tol = 1e-6
  nl_rel_tol = 1e-6
  l_tol = 1e-6
  l_max_its = 10
  start_time = 0
  end_time = 3.0
  dt = 0.01
  timestep_tolerance = 1e-3
  petsc_options = '-snes_ksp_ew'
  petsc_options_iname = '-ksp_gmres_restart -pc_type -pc_hypre_type -pc_hypre_boomeramg_max_iter'
  petsc_options_value = '201                hypre    boomeramg      4'
  line_search = 'none'
[]

[Controls]
  [./stochastic]
    type = SamplerReceiver
  [../]
[]

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
  [./accel_hist]
    type = ResponseHistoryBuilder
    variables = 'accel_x'
    nodes = '0 20'
  [../]
  [./accel_spec]
    type = ResponseSpectraCalculator
    vectorpostprocessor = accel_hist
    regularize_dt = 0.01
    outputs = out
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
   execute_on = 'final'
   file_base = Resp_Spec
  [../]
[]
