[Mesh]
  type = GeneratedMesh
  nx = 500
  xmin = 0
  xmax = 1
  dim = 1
[]

[Variables]
  [./p]
  [../]
[]

[Kernels]
  [./diffusion]
    type = Diffusion
    variable = 'p'
  [../]
  [./inertia]
    type = InertialForce
    variable = p
  [../]
[]

[BCs]
  # [./bottom_y]
  #   type = DirichletBC
  #   variable = p
  #   boundary = 'bottom'
  #   value = 0.0
  # [../]
  # [./top_y]
  #   type = DirichletBC
  #   variable = p
  #   boundary = 'top'
  #   value = 0.0
  # [../]
  [./left_x]
    type = DirichletBC
    variable = p
    boundary = 'left'
    value = 0.0
  [../]
  [./right_x]
    type = DirichletBC
    variable = p
    boundary = 'right'
    value = 0.0
  [../]
  # [./bottom_accel]
  #   # type = ArrayVacuumBC
  #   type = FunctionDirichletBC
  #   variable = p
  #   boundary = 'bottom'
  #   function = accel_bottom
  #   # type = PresetDisplacement
  #   # boundary = 'bottom'
  #   # function = accel_bottom
  #   # variable = 'disp_x'
  #   # beta = 0.25
  #   # acceleration = 'accel_x'
  #   # velocity = 'vel_x'
  # [../]
[]

[ICs]
  [./u_ic]
    type = FunctionIC
    variable = 'p'
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
  # [./elastic_domain]
  #   type = ComputeIsotropicElasticityTensor
  #   bulk_modulus = 2200000000
  #   poissons_ratio = 0.499
  # [../]
  # [./stress_beam2]
  #   type = ComputeFiniteStrainElasticStress
  # [../]
  # [./strain_15]
  #   type = ComputeFiniteStrain
  #   displacements = 'disp_x disp_y'
  # [../]
  [./density]
    type = GenericConstantMaterial
    prop_names = density
    prop_values =  1.0
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
  solve_type = 'PJFNK'
  petsc_options = '-snes_ksp_ew'
  petsc_options_iname = '-ksp_gmres_restart -pc_type -pc_hypre_type -pc_hypre_boomeramg_max_iter'
  petsc_options_value = '201                hypre    boomeramg      4'
  start_time = 0.0
  end_time = 10.0
  dt = 0.001
  dtmin = 0.0001
  nl_abs_tol = 1e-7
  nl_rel_tol = 1e-7
  l_tol = 1e-7
  l_max_its = 25
  timestep_tolerance = 1e-8
  [TimeIntegrator]
    type = NewmarkBeta
  []
[]

[VectorPostprocessors]
  [./disp_hist]
    type = ResponseHistoryBuilder
    variables = 'p'
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
    file_base = Diffusion
  [../]
[]
