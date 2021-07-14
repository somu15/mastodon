[Mesh]
  type = GeneratedMesh
  nx = 91
  ny = 61
  nz = 61
  xmin = 0
  ymin = 0
  zmin = 0.0
  xmax = 90.75
  ymax = 60.75
  zmax = 60.96
  dim = 3
[]

[GlobalParams]
  # displacements = 'disp_x disp_y disp_z'
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
  # [./layer_id]
  #   order = CONSTANT
  #   family = MONOMIAL
  # [../]
[]

[Kernels]
  [./DynamicTensorMechanics]
    displacements = 'disp_x disp_y disp_z'
  [../]
  [./inertia_x]
    type = InertialForce
    variable = disp_x
  [../]
  [./inertia_y]
    type = InertialForce
    variable = disp_y
  [../]
  [./inertia_z]
    type = InertialForce
    variable = disp_z
  [../]
[]

[AuxKernels]
  [./accel_x]
    type = TestNewmarkTI
    displacement = disp_x
    variable = accel_x
    first = false
    execute_on = timestep_end
  [../]
  [./vel_x]
    type = TestNewmarkTI
    displacement = disp_x
    variable = vel_x
    execute_on = timestep_end
  [../]
  [./accel_y]
    type = TestNewmarkTI
    displacement = disp_y
    variable = accel_y
    first = false
    execute_on = timestep_end
  [../]
  [./vel_y]
    type = TestNewmarkTI
    displacement = disp_y
    variable = vel_y
    execute_on = timestep_end
  [../]
  [./accel_z]
    type = TestNewmarkTI
    displacement = disp_z
    variable = accel_z
    first = false
    execute_on = timestep_end
  [../]
  [./vel_z]
    type = TestNewmarkTI
    displacement = disp_z
    variable = vel_z
    execute_on = timestep_end
  [../]
  # [./layer_id]
  #   type = UniformLayerAuxKernel
  #   variable = layer_id
  #   interfaces = '61'
  #   direction = '0.0 0.0 1.0'
  #   execute_on = initial
  # [../]
[]

[BCs]
  [./bottom_z]
    type = DirichletBC
    variable = disp_z
    boundary = 'back'
    value = 0.0
  [../]
  [./bottom_y]
    type = DirichletBC
    variable = disp_y
    boundary = 'back'
    value = 0.0
  [../]
  [./bottom_accel]
    type = PresetAcceleration
    boundary = 'back'
    function = ormsby
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
  [./ormsby]
    type = OrmsbyWavelet
    f1 = 0.0
    f2 = 5.0
    f3 = 45.0
    f4 = 50.0
    ts = 0.25
    scale_factor = 4.905
  [../]
  # [./initial_zz]
  #   type = ParsedFunction
  #   value = '-1.697e-6 * 9.81 * (60.96 - z)'
  # [../]
  # [./initial_xx]
  #   type = ParsedFunction
  #   value = '-1.697e-6 * 9.81 * (60.96 - z) * 0.3/0.7'
  # [../]
[]

[Materials]
  [./elastic_soil]
    # type = ComputeIsotropicElasticityTensorSoil
    # layer_variable = layer_id
    # layer_ids = '0'
    # density = '1.697e-6' # 1697.95 Kg/m^3
    type = ComputeIsotropicElasticityTensor
    poissons_ratio = '0.3'
    shear_modulus = '0.511' # 511.092 MPa
  [../]
  [./density]
    type = GenericConstantMaterial
    prop_names = density
    prop_values = 1.697e-6
  [../]
  [./stress_beam2]
    type = ComputeFiniteStrainElasticStress
  [../]
  [./strain_15]
    type = ComputeFiniteStrain
    displacements = 'disp_x disp_y disp_z'
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
  solve_type = 'NEWTON'
  etsc_options = '-ksp_snes_ew'
  petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
  petsc_options_value = 'lu       superlu_dist'
  start_time = 0.0
  end_time = 0.5
  dt = 0.001
  dtmin = 0.0001
  nl_abs_tol = 1e-4
  nl_rel_tol = 1e-5
  l_tol = 1e-5
  l_max_its = 25
  timestep_tolerance = 1e-8
  [TimeIntegrator]
    type = NewmarkBeta
    # beta = 0.3025
    # gamma = 0.6
  []
[]

# [VectorPostprocessors]
#   [./accel_hist]
#     type = ResponseHistoryBuilder
#     variables = 'accel_x'
#     nodes = '3 63'
#   [../]
#   [./accel_spec]
#     type = ResponseSpectraCalculator
#     vectorpostprocessor = accel_hist
#     regularize_dt = 0.001
#     damping_ratio = 0.01
#     start_frequency = 0.1
#     end_frequency = 1000
#     outputs = out
#   [../]
# []

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
  print_linear_residuals = true
  # [./out]
  #   execute_on = 'FINAL'
  #   type = CSV
  #   file_base = Soil_Final_NoDamp
  # [../]
  # [./out2]
  #   type = Exodus
  #   file_base = Exod_Soil_Final_NoDamp
  #   interval = 10
  # [../]
[]
