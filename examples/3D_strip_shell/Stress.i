[Mesh]
  [file]
    type = FileMeshGenerator
    file = Stress.e
  []
  # uniform_refine = 1
[]

[GlobalParams]
[]

[Variables]
  [./disp_x]
    block = '1'
  [../]
  [./disp_y]
    block = '1'
  [../]
  [./disp_z]
    block = '1'
  [../]
[]

[AuxVariables]
  [./vel_x]
    block = '1'
  [../]
  [./accel_x]
    block = '1'
  [../]
  [./vel_y]
    block = '1'
  [../]
  [./vel_z]
    block = '1'
  [../]
  [./accel_y]
    block = '1'
  [../]
  [./accel_z]
    block = '1'
  [../]
  [./stress_xx]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
  [../]
  [./stress_yy]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
  [../]
  [./stress_xy]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
  [../]
  [./stress_zz]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
  [../]
  [./stress_xz]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
  [../]
  [./stress_yz]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
  [../]
  [./strain_xx]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
  [../]
  [./strain_yy]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
  [../]
  [./strain_xy]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
  [../]
  [./strain_zz]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
  [../]
  [./strain_xz]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
  [../]
  [./strain_yz]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
  [../]
[]

[Kernels]
  [./DynamicTensorMechanics]
    displacements = 'disp_x disp_y disp_z'
    block = 1
  [../]
  # [./inertia_x1]
  #   type = InertialForce
  #   variable = disp_x
  #   block = 1
  # [../]
  # [./inertia_y1]
  #   type = InertialForce
  #   variable = disp_y
  #   block = 1
  # [../]
  # [./inertia_z1]
  #   type = InertialForce
  #   variable = disp_z
  #   block = 1
  # [../]
[]

[AuxKernels]
  # [./accel_x]
  #   type = TestNewmarkTI
  #   displacement = disp_x
  #   variable = accel_x
  #   first = false
  #   block = '1 2'
  # [../]
  # [./vel_x]
  #   type = TestNewmarkTI
  #   displacement = disp_x
  #   variable = accel_x
  #   block = '1 2'
  # [../]
  # [./accel_y]
  #   type = TestNewmarkTI
  #   displacement = disp_y
  #   variable = accel_y
  #   first = false
  #   block = '1 2'
  # [../]
  # [./vel_y]
  #   type = TestNewmarkTI
  #   displacement = disp_y
  #   variable = accel_y
  #   block = '1 2'
  # [../]
  # [./accel_z]
  #   type = TestNewmarkTI
  #   displacement = disp_z
  #   variable = accel_z
  #   first = false
  #   block = '1 2'
  # [../]
  # [./vel_z]
  #   type = TestNewmarkTI
  #   displacement = disp_z
  #   variable = accel_z
  #   block = '1 2'
  # [../]
  # [./rot_accel_x]
  #   block = '2'
  #   type = TestNewmarkTI
  #   displacement = rot_x
  #   variable = rot_accel_x
  #   first = false
  # [../]
  # [./rot_vel_x]
  #   block = '2'
  #   type = TestNewmarkTI
  #   displacement = rot_x
  #   variable = rot_vel_x
  # [../]
  # [./rot_accel_y]
  #   block = '2'
  #   type = TestNewmarkTI
  #   displacement = rot_y
  #   variable = rot_accel_y
  #   first = false
  # [../]
  # [./rot_vel_y]
  #   block = '2'
  #   type = TestNewmarkTI
  #   displacement = rot_y
  #   variable = rot_vel_y
  # [../]
  [./stress_xx]
    type = RankTwoAux
    rank_two_tensor = stress # global_stress_t_points_0 #
    variable = stress_xx
    index_i = 0
    index_j = 0
    block = '1'
  [../]
  [./stress_yy]
    type = RankTwoAux
    rank_two_tensor = stress # global_stress_t_points_0 #
    variable = stress_yy
    index_i = 1
    index_j = 1
    block = '1'
  [../]
  [./stress_xy]
    type = RankTwoAux
    rank_two_tensor = stress # global_stress_t_points_0 #
    variable = stress_xy
    index_i = 0
    index_j = 1
    block = '1'
  [../]
  [./stress_zz]
    type = RankTwoAux
    rank_two_tensor = stress # global_stress_t_points_0 #
    variable = stress_zz
    index_i = 2
    index_j = 2
    block = '1'
  [../]
  [./stress_xz]
    type = RankTwoAux
    rank_two_tensor = stress # global_stress_t_points_0 #
    variable = stress_xz
    index_i = 0
    index_j = 2
    block = '1'
  [../]
  [./stress_yz]
    type = RankTwoAux
    rank_two_tensor = stress # global_stress_t_points_0 #
    variable = stress_yz
    index_i = 1
    index_j = 2
    block = '1'
  [../]
  [./strain_xx]
    type = RankTwoAux
    rank_two_tensor = total_strain # global_stress_t_points_0 #
    variable = strain_xx
    index_i = 0
    index_j = 0
    block = '1'
  [../]
  [./strain_yy]
    type = RankTwoAux
    rank_two_tensor = total_strain # global_stress_t_points_0 #
    variable = strain_yy
    index_i = 1
    index_j = 1
    block = '1'
  [../]
  [./strain_xy]
    type = RankTwoAux
    rank_two_tensor = total_strain # global_stress_t_points_0 #
    variable = strain_xy
    index_i = 0
    index_j = 1
    block = '1'
  [../]
  [./strain_zz]
    type = RankTwoAux
    rank_two_tensor = total_strain # global_stress_t_points_0 #
    variable = strain_zz
    index_i = 2
    index_j = 2
    block = '1'
  [../]
  [./strain_xz]
    type = RankTwoAux
    rank_two_tensor = total_strain # global_stress_t_points_0 #
    variable = strain_xz
    index_i = 0
    index_j = 2
    block = '1'
  [../]
  [./strain_yz]
    type = RankTwoAux
    rank_two_tensor = total_strain # global_stress_t_points_0 #
    variable = strain_yz
    index_i = 1
    index_j = 2
    block = '1'
  [../]
[]

[BCs]
  [./disp_x1]
    type = DirichletBC
    boundary = 'Bottom'
    variable = disp_x
    value = 0.0
  [../]
  [./disp_x2]
    type = DirichletBC
    boundary = 'Bottom'
    variable = disp_y
    value = 0.0
  [../]
  [./disp_x3]
    type = DirichletBC
    boundary = 'Bottom'
    variable = disp_z
    value = 0.0
  [../]
  # [./disp_x11]
  #   type = DirichletBC
  #   boundary = 'Sides'
  #   variable = disp_x
  #   value = 0.0
  # [../]
  # [./disp_x21]
  #   type = DirichletBC
  #   boundary = 'Sides'
  #   variable = disp_y
  #   value = 0.0
  # [../]
  # [./disp_y_TB]
  #   type = NeumannBC
  #   boundary = 'Solid_surface'
  #   variable = disp_y
  #   value = 0.0
  # [../]
  # [./disp_z_TB]
  #   type = NeumannBC
  #   boundary = 'Solid_surface'
  #   variable = disp_z
  #   value = 0.0
  # [../]
[]

[NodalKernels]
  [./force_y2]
    type = ConstantRate
    variable = disp_z
    boundary = 'Nodes'
    rate = -1.0
  [../]
[]

[Materials]
  # [./density0]
  #   type = GenericConstantMaterial
  #   block = '1'
  #   prop_names = density
  #   prop_values = 7.85e-6
  # [../]
  [./elasticity_base]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 2e2
    poissons_ratio = 0.27
    block = 1
  [../]
  [./strain1]
    type = ComputeFiniteStrain
    block = 1
    displacements = 'disp_x disp_y disp_z'
  [../]
  [./stress1]
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
  nl_rel_tol = 1e-10
  nl_abs_tol = 1e-8
  dt = 1.0
  dtmin = 1.0
  end_time = 1.0
  automatic_scaling = true
  [TimeIntegrator]
    type = NewmarkBeta
  []
[]

[Postprocessors]
  [./stress1]
    type = PointValue
    point = '0.0 0.0 2.0'
    variable = stress_xx
  [../]
  [./stress2]
    type = PointValue
    point = '0.0 0.0 2.0'
    variable = stress_yy
  [../]
  [./stress3]
    type = PointValue
    point = '0.0 0.0 2.0'
    variable = stress_zz
  [../]
  [./strainxx]
    type = PointValue
    point = '0.0 0.0 2.0'
    variable = strain_xx
  [../]
  [./strainyy]
    type = PointValue
    point = '0.0 0.0 2.0'
    variable = strain_yy
  [../]
  [./strainzz]
    type = PointValue
    point = '0.0 0.0 2.0'
    variable = strain_zz
  [../]
  [./strainxy]
    type = PointValue
    point = '0.0 0.0 2.0'
    variable = strain_xy
  [../]
  [./strainxz]
    type = PointValue
    point = '0.0 0.0 2.0'
    variable = strain_xz
  [../]
  [./strainyz]
    type = PointValue
    point = '0.0 0.0 2.0'
    variable = strain_yz
  [../]
  # [./stress11]
  #   type = PointValue
  #   point = '0.0 0.0 2.5'
  #   variable = stress_xx
  # [../]
  # [./stress21]
  #   type = PointValue
  #   point = '0.0 0.0 2.5'
  #   variable = stress_yy
  # [../]
  # [./stress31]
  #   type = PointValue
  #   point = '0.0 0.0 2.5'
  #   variable = stress_zz
  # [../]
[]

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
  print_linear_residuals = true
  file_base = Ex_Test_Stress1
  [./out]
    execute_on = 'TIMESTEP_BEGIN'
    type = CSV
    file_base = Test_Stress1
  [../]
[]
