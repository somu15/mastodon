[Mesh]
  [gen]
    type = GeneratedMeshGenerator
    dim = 1
    nx = 3
    xmax = 1
  []
[]

[Variables]
  # [./p]
  #   # order = FIRST
  #   # family = LAGRANGE
  #   block = 1
  # [../]
  [./disp_x]
  [../]
[]

[AuxVariables]
  [./vel_x]
  [../]
  [./accel_x]
  [../]
[]

[Kernels]
  [./DynamicTensorMechanics]
    displacements = 'disp_x'
    block = '0'
  [../]
  # [./inertia_x1]
  #   type = InertialForce
  #   variable = disp_x
  #   block = '0'
  # [../]
[]

[AuxKernels]
  [./accel_x]
    type = NewmarkAccelAux
    variable = accel_x
    displacement = disp_x
    velocity = vel_x
    beta = 0.25
    execute_on = 'timestep_end'
    # block = '1'
  [../]
  [./vel_x]
    type = NewmarkVelAux
    variable = vel_x
    acceleration = accel_x
    gamma = 0.5
    execute_on = 'timestep_end'
    # block = '1'
  [../]
[]

[BCs]
  [./bottom_accel]
    type = FunctionDirichletBC
    variable = disp_x
    boundary = 'right'
    function = accel_bottom
    # type = FunctionNeumannBC #
    # variable = disp_x
    # boundary = 'right'
    # function = accel_bottom

    # type = PresetDisplacement
    # variable = disp_x
    # velocity = vel_x
    # acceleration = accel_x
    # beta = 0.25
    # function = accel_bottom
    # boundary = 'right'
  [../]
  [./disp_x]
    type = PresetBC
    boundary = 'left'
    variable = disp_x
    value = 0.0
  [../]
[]

[Functions]
  [./accel_bottom]
    type = PiecewiseLinear
    data_file = Input_Acc.csv
    scale_factor = 1.0 #1000000000.0/2e11
    format = 'columns'
  [../]
[]

[Materials]
  # [./density0]
  #   type = GenericConstantMaterial
  #   prop_names = density
  #   prop_values =  8050 # 2700
  # [../]
  [./elasticity_base]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 7600 # 2e11
    poissons_ratio = 0.0
  [../]
  # [./stress_beam2]
  #   type = ComputeFiniteStrainElasticStress
  # [../]
  # [./strain_15]
  #   type = ComputeFiniteStrain
  #   displacements = 'disp_x'
  # [../]
  [./strain]
    type = ComputeSmallStrain
    displacements = 'disp_x'
  [../]
  [./stress]
    type = ComputeLinearElasticStress
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
  # petsc_options = '-snes_ksp_ew'
  # petsc_options_iname = '-ksp_gmres_restart -pc_type -pc_hypre_type -pc_hypre_boomeramg_max_iter'
  # petsc_options_value = '201                hypre    boomeramg      4'
  petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
  petsc_options_value = 'lu       superlu_dist'
  start_time = 0.0
  end_time = 0.4
  dt = 0.001
  dtmin = 0.0001
  nl_abs_tol = 1e-7 # 1e-3
  nl_rel_tol = 1e-7 # 1e-3
  l_tol = 1e-7 # 1e-3
  l_max_its = 25
  timestep_tolerance = 1e-8
  [TimeIntegrator]
    type = NewmarkBeta
  []
[]

[Postprocessors]
  # [./p1]
  #   type = PointValue
  #   point = '1.0 0.0 0.0'
  #   variable = p
  # [../]
  # [./a1]
  #   type = PointValue
  #   point = '1.0 0.0 0.0'
  #   variable = accel_x
  # [../]
  # [./v1]
  #   type = PointValue
  #   point = '1.0 0.0 0.0'
  #   variable = vel_x
  # [../]
  [./u1]
    type = PointValue
    point = '1.0 0.0 0.0'
    variable = disp_x
  [../]
  # [./p_flux]
  #   type = PointValue
  #   point = '1.0 0.0 0.0'
  #   variable = flux_p
  # [../]
  # [./u_flux]
  #   type = PointValue
  #   point = '1.0 0.0 0.0'
  #   variable = flux_u
  # [../]
[]

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
  print_linear_residuals = true
  file_base = Exodus_Str_1
  [./out]
    execute_on = 'TIMESTEP_BEGIN'
    type = CSV
    file_base = Str_1
  [../]
[]
