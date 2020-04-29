[Mesh]
  type = GeneratedMesh
  nx = 500
  xmin = 0
  xmax = 1
  dim = 1
  # elem_type = EDGE3
[]

[GlobalParams]
  displacements = 'disp_x'
[]

[Variables]
  [./dummy]
  [../]
[]

[AuxVariables]
  [./disp_x]
    order = FIRST
    family = LAGRANGE
    [./InitialCondition]
      type = FunctionIC
      function = sin(x)*0.1
    [../]
  [../]
[]

[Kernels]
  [./DynamicTensorMechanics]
    displacements = 'disp_x'
  [../]
  [./inertia_x]
    type = InertialForce
    variable = disp_x
    velocity = vel_x
    acceleration = accel_x
    beta = 0.25
    gamma = 0.5
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
[]

[BCs]
  [./left_x]
    type = DirichletBC
    variable = disp_x
    boundary = 'left'
    value = 0.0
  [../]
  [./right_x]
    type = DirichletBC
    variable = disp_x
    boundary = 'right'
    value = 0.0
  [../]
[]

[ICs]
  [./u_ic]
    type = FunctionIC
    variable = 'disp_x'
    function = press_space
  [../]
[]

[Functions]
  [./press_space]
    type = ParsedFunction
    value = 'sin(pi*x)+sin(3*pi*x)+sin(5*pi*x)+sin(7*pi*x)+sin(9*pi*x)'
    # value = 'sin(pi*x)'
  [../]
[]

[Materials]
  [./elastic_domain]
    type = ComputeIsotropicElasticityTensor
    lambda = -1
    shear_modulus = 1
  [../]
  [./stress_beam2]
    type = ComputeFiniteStrainElasticStress
  [../]
  [./strain_15]
    type = ComputeFiniteStrain
    displacements = 'disp_x'
  [../]
  [./density]
    type = GenericConstantMaterial
    prop_names = density
    prop_values =  1
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
  petsc_options = '-snes_ksp_ew'
  petsc_options_iname = '-ksp_gmres_restart -pc_type -pc_hypre_type -pc_hypre_boomeramg_max_iter'
  petsc_options_value = '201                hypre    boomeramg      4'
  # petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
  # petsc_options_value = 'lu       superlu_dist'
  start_time = 0.0
  end_time = 10.0
  dt = 0.001
  dtmin = 0.00001
  nl_abs_tol = 1e-7
  nl_rel_tol = 1e-7
  l_tol = 1e-7
  l_max_its = 25
  timestep_tolerance = 1e-8
[]

[VectorPostprocessors]
  [./disp_hist]
    type = ResponseHistoryBuilder
    variables = 'disp_x'
    nodes = '0 250 500'
  [../]
[]

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
  print_linear_residuals = true
  [./out]
    execute_on = 'FINAL'
    type = CSV
    file_base = Eq_Struc
  [../]
[]
