[Mesh]
  type = GeneratedMesh
  nx = 2
  ny = 2
  nz = 2
  xmin = 0
  ymin = 0
  zmin = 0.0
  xmax = 1.0
  ymax = 1.0
  zmax = 1.0
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
    function = accel_bottom # ormsby
    variable = 'disp_x'
    beta = 0.25
    acceleration = 'accel_x'
    velocity = 'vel_x'
  [../]
[]

[Functions]
  # [./ormsby]
  #   type = OrmsbyWavelet
  #   f1 = 0.0
  #   f2 = 5.0
  #   f3 = 45.0
  #   f4 = 50.0
  #   ts = 1.0
  #   scale_factor = 4.905
  # [../]
  [accel_bottom]
    type = PiecewiseLinear
    data_file = Sine.csv
    format = 'columns'
    scale_factor = 9.81
  []
[]

[Materials]
  [./elastic_soil]
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

[Postprocessors]
  [Accx]
    type = PointValue
    point = '0.0 0.0 0.0'
    variable = accel_x
  []
[]

[Executioner]
  type = Transient
  solve_type = 'NEWTON'
  petsc_options = '-ksp_snes_ew'
  petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
  petsc_options_value = 'lu       superlu_dist'
  start_time = 0.0
  dt = 0.0025 # 0.0025
  end_time = 0.4 # 0.5
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

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
  print_linear_residuals = true
[]
