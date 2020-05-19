[Mesh]
  [gen]
    type = GeneratedMeshGenerator
    dim = 1
    nx = 1000
    xmax = 1000
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
  # [./stress_xy]
  #   order = CONSTANT
  #   family = MONOMIAL
  # [../]
  # [./stress_yz]
  #   order = CONSTANT
  #   family = MONOMIAL
  # [../]
  # [./stress_zx]
  #   order = CONSTANT
  #   family = MONOMIAL
  # [../]
  # [./strain_xy]
  #   order = CONSTANT
  #   family = MONOMIAL
  # [../]
  # [./strain_yz]
  #   order = CONSTANT
  #   family = MONOMIAL
  # [../]
  # [./strain_zx]
  #   order = CONSTANT
  #   family = MONOMIAL
  # [../]
  [./stress_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  # [./stress_yy]
  #   order = CONSTANT
  #   family = MONOMIAL
  # [../]
  # [./stress_zz]
  #   order = CONSTANT
  #   family = MONOMIAL
  # [../]
  [./strain_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  # [./strain_yy]
  #   order = CONSTANT
  #   family = MONOMIAL
  # [../]
  # [./strain_zz]
  #   order = CONSTANT
  #   family = MONOMIAL
  # [../]
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
  # [./stress_xy]
  #   type = RankTwoAux
  #   rank_two_tensor = stress
  #   variable = stress_xy
  #   index_i = 1
  #   index_j = 0
  # [../]
  # [./stress_yz]
  #   type = RankTwoAux
  #   rank_two_tensor = stress
  #   variable = stress_yz
  #   index_i = 2
  #   index_j = 1
  # [../]
  # [./stress_zx]
  #   type = RankTwoAux
  #   rank_two_tensor = stress
  #   variable = stress_zx
  #   index_i = 0
  #   index_j = 2
  # [../]
  # [./strain_xy]
  #   type = RankTwoAux
  #   rank_two_tensor = total_strain
  #   variable = stress_xy
  #   index_i = 1
  #   index_j = 0
  # [../]
  # [./strain_yz]
  #   type = RankTwoAux
  #   rank_two_tensor = total_strain
  #   variable = strain_yz
  #   index_i = 2
  #   index_j = 1
  # [../]
  # [./strain_zx]
  #   type = RankTwoAux
  #   rank_two_tensor = total_strain
  #   variable = strain_zx
  #   index_i = 0
  #   index_j = 2
  # [../]
  [./stress_xx]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xx
    index_i = 0
    index_j = 0
  [../]
  # [./stress_yy]
  #   type = RankTwoAux
  #   rank_two_tensor = stress
  #   variable = stress_yy
  #   index_i = 1
  #   index_j = 1
  # [../]
  # [./stress_zz]
  #   type = RankTwoAux
  #   rank_two_tensor = stress
  #   variable = stress_zz
  #   index_i = 2
  #   index_j = 2
  # [../]
  [./strain_xx]
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = strain_xx
    index_i = 0
    index_j = 0
  [../]
  # [./strain_yy]
  #   type = RankTwoAux
  #   rank_two_tensor =total_strain
  #   variable = strain_yy
  #   index_i = 1
  #   index_j = 1
  # [../]
  # [./strain_zz]
  #   type = RankTwoAux
  #   rank_two_tensor = total_strain
  #   variable = strain_zz
  #   index_i = 2
  #   index_j = 2
  # [../]
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
    data_file = Input_5Sines.csv
    scale_factor = 1e-5 #1000000000.0/2e11
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
    youngs_modulus = 5500 # 2e11
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
    point = '1000.0 0.0 0.0'
    variable = stress_xx
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
