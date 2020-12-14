[Mesh]
  [file]
    type = FileMeshGenerator
    file = Shell_stress.e
  []
  # uniform_refine = 2
[]

[GlobalParams]
[]

[Variables]
  [./disp_x]
    block = '1 2'
  [../]
  [./disp_y]
    block = '1 2'
  [../]
  [./disp_z]
    block = '1 2'
  [../]
  [./rot_x]
    block = '2'
  [../]
  [./rot_y]
    block = '2'
  [../]
[]

[AuxVariables]
  [./vel_x]
    block = '1 2'
  [../]
  [./accel_x]
    block = '1 2'
  [../]
  [./vel_y]
    block = '1 2'
  [../]
  [./vel_z]
    block = '1 2'
  [../]
  [./accel_y]
    block = '1 2'
  [../]
  [./accel_z]
    block = '1 2'
  [../]
  [./stress_xx]
    order = CONSTANT
    family = MONOMIAL
    block = '1 2'
  [../]
  [./stress_yy]
    order = CONSTANT
    family = MONOMIAL
    block = '1 2'
  [../]
  [./stress_xy]
    order = CONSTANT
    family = MONOMIAL
    block = '1 2'
  [../]
  [./stress_zz]
    order = CONSTANT
    family = MONOMIAL
    block = '1 2'
  [../]
  [./rot_vel_x]
    block = '2'
  [../]
  [./rot_vel_y]
    block = '2'
  [../]
  [./rot_accel_x]
    block = '2'
  [../]
  [./rot_accel_y]
    block = '2'
  [../]
  [./strain_xx]
    order = CONSTANT
    family = MONOMIAL
    block = '1 2'
  [../]
  [./strain_yy]
    order = CONSTANT
    family = MONOMIAL
    block = '1 2'
  [../]
  [./strain_xy]
    order = CONSTANT
    family = MONOMIAL
    block = '1 2'
  [../]
  [./strain_zz]
    order = CONSTANT
    family = MONOMIAL
    block = '1 2'
  [../]
  [./strain_xz]
    order = CONSTANT
    family = MONOMIAL
    block = '1 2'
  [../]
  [./strain_yz]
    order = CONSTANT
    family = MONOMIAL
    block = '1 2'
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
  [./solid_disp_x]
    type = ADStressDivergenceShell
    block = '2'
    component = 0
    variable = disp_x
    through_thickness_order = SECOND
  [../]
  [./solid_disp_y]
    type = ADStressDivergenceShell
    block = 2
    component = 1
    variable = disp_y
    through_thickness_order = SECOND
  [../]
  [./solid_disp_z]
    type = ADStressDivergenceShell
    block = 2
    component = 2
    variable = disp_z
    through_thickness_order = SECOND
  [../]
  [./solid_rot_x]
    type = ADStressDivergenceShell
    block = 2
    component = 3
    variable = rot_x
    through_thickness_order = SECOND
  [../]
  [./solid_rot_y]
    type = ADStressDivergenceShell
    block = 2
    component = 4
    variable = rot_y
    through_thickness_order = SECOND
  [../]
  # [./inertial_force_x]
  #   type = ADInertialForceShell
  #   block = 2
  #   displacements = 'disp_x disp_y disp_z'
  #   rotations = 'rot_x rot_y'
  #   velocities = 'vel_x vel_y vel_z'
  #   accelerations = 'accel_x accel_y accel_z'
  #   rotational_velocities = 'rot_vel_x rot_vel_y'
  #   rotational_accelerations = 'rot_accel_x rot_accel_y'
  #   component = 0
  #   variable = disp_x
  #   thickness = 1.0
  # [../]
  # [./inertial_force_y]
  #   type = ADInertialForceShell
  #   block = 2
  #   displacements = 'disp_x disp_y disp_z'
  #   rotations = 'rot_x rot_y'
  #   velocities = 'vel_x vel_y vel_z'
  #   accelerations = 'accel_x accel_y accel_z'
  #   rotational_velocities = 'rot_vel_x rot_vel_y'
  #   rotational_accelerations = 'rot_accel_x rot_accel_y'
  #   component = 1
  #   variable = disp_y
  #   thickness = 1.0
  # [../]
  # [./inertial_force_z]
  #   type = ADInertialForceShell
  #   block = 2
  #   displacements = 'disp_x disp_y disp_z'
  #   rotations = 'rot_x rot_y'
  #   velocities = 'vel_x vel_y vel_z'
  #   accelerations = 'accel_x accel_y accel_z'
  #   rotational_velocities = 'rot_vel_x rot_vel_y'
  #   rotational_accelerations = 'rot_accel_x rot_accel_y'
  #   component = 2
  #   variable = disp_z
  #   thickness = 1.0
  # [../]
  # [./inertial_force_rot_x]
  #   type = ADInertialForceShell
  #   block = 2
  #   displacements = 'disp_x disp_y disp_z'
  #   rotations = 'rot_x rot_y'
  #   velocities = 'vel_x vel_y vel_z'
  #   accelerations = 'accel_x accel_y accel_z'
  #   rotational_velocities = 'rot_vel_x rot_vel_y'
  #   rotational_accelerations = 'rot_accel_x rot_accel_y'
  #   component = 3
  #   variable = rot_x
  #   thickness = 1.0
  # [../]
  # [./inertial_force_rot_y]
  #   type = ADInertialForceShell
  #   block = 2
  #   displacements = 'disp_x disp_y disp_z'
  #   rotations = 'rot_x rot_y'
  #   velocities = 'vel_x vel_y vel_z'
  #   accelerations = 'accel_x accel_y accel_z'
  #   rotational_velocities = 'rot_vel_x rot_vel_y'
  #   rotational_accelerations = 'rot_accel_x rot_accel_y'
  #   component = 4
  #   variable = rot_y
  #   thickness = 1.0
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
    rank_two_tensor = global_stress_t_points_0 # stress #
    variable = stress_xx
    index_i = 0
    index_j = 0
    block = '2'
  [../]
  [./stress_yy]
    type = RankTwoAux
    rank_two_tensor = global_stress_t_points_0 # stress #
    variable = stress_yy
    index_i = 1
    index_j = 1
    block = '2'
  [../]
  [./stress_xy]
    type = RankTwoAux
    rank_two_tensor = global_stress_t_points_0 # stress #
    variable = stress_xy
    index_i = 0
    index_j = 1
    block = '2'
  [../]
  [./stress_zz]
    type = RankTwoAux
    rank_two_tensor = global_stress_t_points_0 # stress #
    variable = stress_zz
    index_i = 2
    index_j = 2
    block = '2'
  [../]
  # [./strain_xx]
  #   type = RankTwoAux
  #   rank_two_tensor = global_strain_t_points_0 # total_strain #
  #   variable = strain_xx
  #   index_i = 0
  #   index_j = 0
  #   block = '2'
  # [../]
  # [./strain_yy]
  #   type = RankTwoAux
  #   rank_two_tensor = total_strain # global_stress_t_points_0 #
  #   variable = strain_yy
  #   index_i = 1
  #   index_j = 1
  #   block = '2'
  # [../]
  # [./strain_xy]
  #   type = RankTwoAux
  #   rank_two_tensor = total_strain # global_stress_t_points_0 #
  #   variable = strain_xy
  #   index_i = 0
  #   index_j = 1
  #   block = '2'
  # [../]
  # [./strain_zz]
  #   type = RankTwoAux
  #   rank_two_tensor = total_strain # global_stress_t_points_0 #
  #   variable = strain_zz
  #   index_i = 2
  #   index_j = 2
  #   block = '2'
  # [../]
  # [./strain_xz]
  #   type = RankTwoAux
  #   rank_two_tensor = total_strain # global_stress_t_points_0 #
  #   variable = strain_xz
  #   index_i = 0
  #   index_j = 2
  #   block = '2'
  # [../]
  # [./strain_yz]
  #   type = RankTwoAux
  #   rank_two_tensor = total_strain # global_stress_t_points_0 #
  #   variable = strain_yz
  #   index_i = 1
  #   index_j = 2
  #   block = '2'
  # [../]
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
  [./density0]
    type = GenericConstantMaterial
    block = '1 2'
    prop_names = density
    prop_values = 7.85e-6
  [../]
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
  [./elasticity]
    type = ADComputeIsotropicElasticityTensorShell
    youngs_modulus = 2e2
    poissons_ratio = 0.27
    block = 2
    through_thickness_order = SECOND
  [../]
  [./strain]
    type = ADComputeIncrementalShellStrain
    block = 2
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y'
    thickness = 1.0
    through_thickness_order = SECOND
  [../]
  [./stress]
    type = ADComputeShellStress
    block = 2
    through_thickness_order = SECOND
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
    point = '0.0 0.0 2.5'
    variable = stress_xx
  [../]
  [./stress2]
    type = PointValue
    point = '0.0 0.0 2.5'
    variable = stress_yy
  [../]
  [./stress3]
    type = PointValue
    point = '0.0 0.0 2.5'
    variable = stress_zz
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
  file_base = Ex_Test_Shell_stress1
  [./out]
    execute_on = 'TIMESTEP_BEGIN'
    type = CSV
    file_base = Test_Shell_stress1
  [../]
[]
