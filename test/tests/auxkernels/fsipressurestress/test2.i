[Mesh]
  [file]
    type = FileMeshGenerator
    file = 2D_test.e
  []
  [./interface1]
    type = SideSetsBetweenSubdomainsGenerator
    input = file
    primary_block = '1'
    paired_block = '2'
    new_boundary = 'Interface'
  [../]
[]

[GlobalParams]
[]

[Variables]
  [./p]
    block = 2
  [../]
  [./disp_x]
    block = 1
  [../]
  [./disp_y]
    block = 1
  [../]
[]

[AuxVariables]
  [./vel_x]
    block = 1
  [../]
  [./accel_x]
    block = 1
  [../]
  [./vel_y]
    block = 1
  [../]
  [./accel_y]
    block = 1
  [../]
  [./stress_xx]
    order = CONSTANT
    family = MONOMIAL
    block = 1
  [../]
  [./stress_yy]
    order = CONSTANT
    family = MONOMIAL
    block = 1
  [../]
  [./stress_xy]
    order = CONSTANT
    family = MONOMIAL
    block = 1
  [../]
[]

[Kernels]
  [./diffusion]
    type = Diffusion
    variable = 'p'
    block = 2
  [../]
  [./inertia]
    type = AcousticInertia
    variable = p
    block = 2
  [../]
  [./DynamicTensorMechanics]
    displacements = 'disp_x disp_y'
    block = 1
  [../]
  [./inertia_x1]
    type = InertialForce
    variable = disp_x
    velocity = vel_x
    acceleration = accel_x
    beta = 0.25
    gamma = 0.5
    block = 1
  [../]
  [./inertia_y1]
    type = InertialForce
    variable = disp_y
    velocity = vel_y
    acceleration = accel_y
    beta = 0.25
    gamma = 0.5
    block = 1
  [../]
[]

[AuxKernels]
  [./accel_x]
    type = NewmarkAccelAux
    variable = accel_x
    displacement = disp_x
    velocity = vel_x
    beta = 0.25
    execute_on = 'timestep_end'
    block = 1
  [../]
  [./vel_x]
    type = NewmarkVelAux
    variable = vel_x
    acceleration = accel_x
    gamma = 0.5
    execute_on = 'timestep_end'
    block = 1
  [../]
  [./accel_y]
    type = NewmarkAccelAux
    variable = accel_y
    displacement = disp_y
    velocity = vel_y
    beta = 0.25
    execute_on = 'timestep_end'
    block = 1
  [../]
  [./vel_y]
    type = NewmarkVelAux
    variable = vel_y
    acceleration = accel_y
    gamma = 0.5
    execute_on = 'timestep_end'
    block = 1
  [../]
  [./stress_xx]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xx
    index_i = 0
    index_j = 0
    block = 1
  [../]
  [./stress_yy]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_yy
    index_i = 1
    index_j = 1
    block = 1
  [../]
  [./stress_xy]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xy
    index_i = 0
    index_j = 1
    block = 1
  [../]
[]

[InterfaceKernels]
  [./interface1]
    type =  FSI_test
    variable = 'disp_x'
    neighbor_var = 'p'
    boundary = 'Interface'
    D = 1e-6
    component = 0
  [../]
  [./interface2]
    type =  FSI_test
    variable = 'disp_y'
    neighbor_var = 'p'
    boundary = 'Interface'
    D = 1e-6
    component = 1
  [../]
[]

[BCs]
  [./bottom_accel]
    type = FunctionDirichletBC
    variable = p
    boundary = 'Right'
    function = accel_bottom
    # value = 0
  [../]
  [./disp_x1]
    type = DirichletBC
    boundary = 'Left'
    variable = disp_x
    value = 0.0
  [../]
  [./disp_x2]
    type = DirichletBC
    boundary = 'Left'
    variable = disp_y
    value = 0.0
  [../]
[]

[Functions]
  [./accel_bottom]
    type = PiecewiseLinear
    data_file = Input_1Peak_highF.csv
    scale_factor = 1e-2
    format = 'columns'
  [../]
[]

[Materials]
  [./density]
    type = GenericConstantMaterial
    prop_names = inv_co_sq
    prop_values = 4.44e-7
    block = 2
  [../]
  [./density0]
    type = GenericConstantMaterial
    block = 1
    prop_names = density
    prop_values = 7.7e-6
  [../]
  [./elasticity_base]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 2e2
    poissons_ratio = 0.3
    block = 1
  [../]
  [./strain]
    type = ComputeFiniteStrain
    block = 1
    displacements = 'disp_x disp_y'
  [../]
  [./stress]
    type =  ComputeFiniteStrainElasticStress
    block = 1
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
  petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
  petsc_options_value = 'lu       superlu_dist'
  start_time = 0.0
  end_time = 0.12
  dt = 0.0001
  dtmin = 0.00001
  nl_abs_tol = 1e-12 # 1e-3
  nl_rel_tol = 1e-12 # 1e-3
  l_tol = 1e-12 # 1e-3
  l_max_its = 25
  timestep_tolerance = 1e-8
  automatic_scaling = true
  [TimeIntegrator]
    type = NewmarkBeta
  []
[]

[Postprocessors]
  # [./S_xx]
  #   type = PointValue
  #   point = '10.0 2.5 0.0'
  #   variable = stress_xx
  # [../]
  # [./S_yy]
  #   type = PointValue
  #   point = '10.0 2.5 0.0'
  #   variable = stress_yy
  # [../]
  # [./S_xy]
  #   type = PointValue
  #   point = '10.0 2.5 0.0'
  #   variable = stress_xy
  # [../]
  # [./p]
  #   type = PointValue
  #   point = '10.0 2.5 0.0'
  #   variable = p
  # [../]
  [./S_1]
    type = PointValue
    point = '-1.25 0.5 0.0'
    variable = sdummy
  [../]
  [./S_2]
    type = PointValue
    point = '3.75 0.5 0.0'
    variable = sdummy
  [../]
  # [./p_int]
  #   type = PointValue
  #   point = '2.5 10.0 0.0'
  #   variable = p
  # [../]
  # [./stress1_int]
  #   type = PointValue
  #   point = '2.5 10.0 0.0'
  #   variable = stress_xx
  # [../]
  # [./stress2_int]
  #   type = PointValue
  #   point = '2.5 10.0 0.0'
  #   variable = stress_yy
  # [../]
  # [./dispx_int]
  #   type = PointValue
  #   point = '2.5 10.0 0.0'
  #   variable = disp_x
  # [../]
  # [./dispy_int]
  #   type = PointValue
  #   point = '2.5 10.0 0.0'
  #   variable = disp_y
  # [../]
  # [./p_30]
  #   type = PointValue
  #   point = '2.5 30.0 0.0'
  #   variable = p
  # [../]
  # [./stress1_mid]
  #   type = PointValue
  #   point = '2.5 5.0 0.0'
  #   variable = stress_xx
  # [../]
  # [./stress2_mid]
  #   type = PointValue
  #   point = '2.5 5.0 0.0'
  #   variable = stress_yy
  # [../]
  # [./dispx_mid]
  #   type = PointValue
  #   point = '2.5 5.0 0.0'
  #   variable = disp_x
  # [../]
  # [./dispy_mid]
  #   type = PointValue
  #   point = '2.5 5.0 0.0'
  #   variable = disp_y
  # [../]
[]

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
  print_linear_residuals = true
  file_base = Ex_2D_Test
  [./out]
    execute_on = 'TIMESTEP_BEGIN'
    type = CSV
    file_base = 2D_Test
  [../]
[]
