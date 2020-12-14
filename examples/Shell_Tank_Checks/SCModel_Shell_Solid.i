[Mesh]
  [file]
    type = FileMeshGenerator
    file = SCModel_Shell.e
  []
  # uniform_refine = 1
[]

[GlobalParams]
[]

[Variables]
  [./disp_x]
    block = '1 2 3'
  [../]
  [./disp_y]
    block = '1 2 3'
  [../]
  [./disp_z]
    block = '1 2 3'
  [../]
  [./rot_x]
    block = 1
  [../]
  [./rot_y]
    block = 1
  [../]
[]

[AuxVariables]
  [./vel_x]
    order = FIRST
    family = LAGRANGE
    block = '1 2 3'
  [../]
  [./accel_x]
    order = FIRST
    family = LAGRANGE
    block = '1 2 3'
  [../]
  [./vel_y]
    order = FIRST
    family = LAGRANGE
    block = '1 2 3'
  [../]
  [./accel_y]
    order = FIRST
    family = LAGRANGE
    block = '1 2 3'
  [../]
  [./vel_z]
    order = FIRST
    family = LAGRANGE
    block = '1 2 3'
  [../]
  [./accel_z]
    order = FIRST
    family = LAGRANGE
    block = '1 2 3'
  [../]
  [./stress_xx]
    order = CONSTANT
    family = MONOMIAL
    block = '1 2 3'
  [../]
  [./stress_yy]
    order = CONSTANT
    family = MONOMIAL
    block = '1 2 3'
  [../]
  [./stress_xy]
    order = CONSTANT
    family = MONOMIAL
    block = '1 2 3'
  [../]
  [./stress_zz]
    order = CONSTANT
    family = MONOMIAL
    block = '1 2 3'
  [../]
  [./stress_yz]
    order = CONSTANT
    family = MONOMIAL
    block = '1 2 3'
  [../]
  [./stress_xz]
    order = CONSTANT
    family = MONOMIAL
    block = '1 2 3'
  [../]
  [./rot_vel_x]
    block = 1
  [../]
  [./rot_vel_y]
    block = 1
  [../]
  [./rot_accel_x]
    block = 1
  [../]
  [./rot_accel_y]
    block = 1
  [../]
[]

[Kernels]
  [./DynamicTensorMechanics]
    displacements = 'disp_x disp_y disp_z'
    block = '2 3'
  [../]
  [./inertia_x1]
    type = InertialForce
    variable = disp_x
    block = '2 3'
  [../]
  [./inertia_y1]
    type = InertialForce
    variable = disp_y
    block = '2 3'
  [../]
  [./inertia_z1]
    type = InertialForce
    variable = disp_z
    block = '2 3'
  [../]
  [./solid_disp_x]
    type = ADStressDivergenceShell
    block = 1
    component = 0
    variable = disp_x
    through_thickness_order = SECOND
  [../]
  [./solid_disp_y]
    type = ADStressDivergenceShell
    block = 1
    component = 1
    variable = disp_y
    through_thickness_order = SECOND
  [../]
  [./solid_disp_z]
    type = ADStressDivergenceShell
    block = 1
    component = 2
    variable = disp_z
    through_thickness_order = SECOND
  [../]
  [./solid_rot_x]
    type = ADStressDivergenceShell
    block = 1
    component = 3
    variable = rot_x
    through_thickness_order = SECOND
  [../]
  [./solid_rot_y]
    type = ADStressDivergenceShell
    block = 1
    component = 4
    variable = rot_y
    through_thickness_order = SECOND
  [../]
  [./inertial_force_x]
    type = ADInertialForceShell
    block = 1
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y'
    velocities = 'vel_x vel_y vel_z'
    accelerations = 'accel_x accel_y accel_z'
    rotational_velocities = 'rot_vel_x rot_vel_y'
    rotational_accelerations = 'rot_accel_x rot_accel_y'
    component = 0
    variable = disp_x
    thickness = 0.0079
  [../]
  [./inertial_force_y]
    type = ADInertialForceShell
    block = 1
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y'
    velocities = 'vel_x vel_y vel_z'
    accelerations = 'accel_x accel_y accel_z'
    rotational_velocities = 'rot_vel_x rot_vel_y'
    rotational_accelerations = 'rot_accel_x rot_accel_y'
    component = 1
    variable = disp_y
    thickness = 0.0079
  [../]
  [./inertial_force_z]
    type = ADInertialForceShell
    block = 1
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y'
    velocities = 'vel_x vel_y vel_z'
    accelerations = 'accel_x accel_y accel_z'
    rotational_velocities = 'rot_vel_x rot_vel_y'
    rotational_accelerations = 'rot_accel_x rot_accel_y'
    component = 2
    variable = disp_z
    thickness = 0.0079
  [../]
  [./inertial_force_rot_x]
    type = ADInertialForceShell
    block = 1
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y'
    velocities = 'vel_x vel_y vel_z'
    accelerations = 'accel_x accel_y accel_z'
    rotational_velocities = 'rot_vel_x rot_vel_y'
    rotational_accelerations = 'rot_accel_x rot_accel_y'
    component = 3
    variable = rot_x
    thickness = 0.0079
  [../]
  [./inertial_force_rot_y]
    type = ADInertialForceShell
    block = 1
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y'
    velocities = 'vel_x vel_y vel_z'
    accelerations = 'accel_x accel_y accel_z'
    rotational_velocities = 'rot_vel_x rot_vel_y'
    rotational_accelerations = 'rot_accel_x rot_accel_y'
    component = 4
    variable = rot_y
    thickness = 0.0079
  [../]
[]

[AuxKernels]
  [./accel_x]
    type = TestNewmarkTI
    displacement = disp_x
    variable = accel_x
    first = false
    block = '1 2 3'
  [../]
  [./vel_x]
    type = TestNewmarkTI
    displacement = disp_x
    variable = vel_x
    block = '1 2 3'
  [../]
  [./accel_y]
    type = TestNewmarkTI
    displacement = disp_y
    variable = accel_y
    first = false
    block = '1 2 3'
  [../]
  [./vel_y]
    type = TestNewmarkTI
    displacement = disp_y
    variable = vel_y
    block = '1 2 3'
  [../]
  [./accel_z]
    type = TestNewmarkTI
    displacement = disp_z
    variable = accel_z
    first = false
    block = '1 2 3'
  [../]
  [./vel_z]
    type = TestNewmarkTI
    displacement = disp_z
    variable = vel_z
    block = '1 2 3'
  [../]
  [./stress_xx]
    type = RankTwoAux
    rank_two_tensor = stress # global_stress_t_points_0 #
    variable = stress_xx
    index_i = 0
    index_j = 0
    block = '2 3'
  [../]
  [./stress_yy]
    type = RankTwoAux
    rank_two_tensor = stress # global_stress_t_points_0 #
    variable = stress_yy
    index_i = 1
    index_j = 1
    block = '2 3'
  [../]
  [./stress_xy]
    type = RankTwoAux
    rank_two_tensor = stress # global_stress_t_points_0 #
    variable = stress_xy
    index_i = 0
    index_j = 1
    block = '2 3'
  [../]
  [./stress_zz]
    type = RankTwoAux
    rank_two_tensor = stress # global_stress_t_points_0 #
    variable = stress_zz
    index_i = 2
    index_j = 2
    block = '2 3'
  [../]
  [./stress_yz]
    type = RankTwoAux
    rank_two_tensor = stress # global_stress_t_points_0 #
    variable = stress_yz
    index_i = 1
    index_j = 2
    block = '2 3'
  [../]
  [./stress_xz]
    type = RankTwoAux
    rank_two_tensor = stress # global_stress_t_points_0 #
    variable = stress_xz
    index_i = 0
    index_j = 2
    block = '2 3'
  [../]
  [./rot_accel_x]
    block = 1
    type = TestNewmarkTI
    displacement = rot_x
    variable = rot_accel_x
    first = false
  [../]
  [./rot_vel_x]
    block = 1
    type = TestNewmarkTI
    displacement = rot_x
    variable = rot_vel_x
  [../]
  [./rot_accel_y]
    block = 1
    type = TestNewmarkTI
    displacement = rot_y
    variable = rot_accel_y
    first = false
  [../]
  [./rot_vel_y]
    block = 1
    type = TestNewmarkTI
    displacement = rot_y
    variable = rot_vel_y
  [../]
[]

# [InterfaceKernels]
#   [./interface1]
#     type =  FluidStructureInterface_Shell
#     variable = p
#     neighbor_var = disp_x
#     boundary = 'Interface'
#     D = 1e-6
#     component = 0
#   [../]
#   [./interface2]
#     type =  FluidStructureInterface_Shell
#     variable = p
#     neighbor_var = disp_y
#     boundary = 'Interface'
#     D = 1e-6
#     component = 1
#   [../]
#   [./interface3]
#     type =  FluidStructureInterface_Shell
#     variable = p
#     neighbor_var = disp_z
#     boundary = 'Interface'
#     D = 1e-6
#     component = 2
#   [../]
# []

[BCs]
  [./bottom_accel1]
    type = PresetAcceleration
    variable = disp_x
    velocity = vel_x
    acceleration = accel_x
    beta = 0.25
    function = accel_bottom
    boundary = 'Bottom'
    # type = FunctionDirichletBC
    # variable = disp_x
    # boundary = 'Bottom'
    # function = accel_bottom
  [../]
  [./disp_x2]
    type = DirichletBC
    variable = disp_y
    boundary = 'Bottom'
    value = 0.0
  [../]
  [./disp_x3]
    type = DirichletBC
    variable = disp_z
    boundary = 'Bottom'
    value = 0.0
  [../]
  # [./rot_x]
  #   type = DirichletBC
  #   variable = rot_x
  #   boundary = 'Bottom'
  #   value = 0.0
  # [../]
  # [./rot_y]
  #   type = DirichletBC
  #   variable = rot_y
  #   boundary = 'Bottom'
  #   value = 0.0
  # [../]
  # [./free]
  #   type = FluidFreeSurfaceBC
  #   variable = p
  #   boundary = 'Fluid_top'
  #   alpha = '0.1'
  # []
[]

[Functions]
  [./accel_bottom]
    type = PiecewiseLinear
    data_file = SC_ElCentro.csv # Input_1Peak_highF.csv #
    scale_factor = 9.81
    format = 'columns'
  [../]
[]

[Materials]
  # [./density]
  #   type = GenericConstantMaterial
  #   prop_names = inv_co_sq
  #   prop_values = 4.65e-7
  #   block = 2
  # [../]
  [./density0]
    type = GenericConstantMaterial
    block = '1 2 3'
    prop_names = density
    prop_values = 7.85e-6
  [../]
  [./elasticity_base]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 2e4
    poissons_ratio = 0.27
    block = 3
  [../]
  [./elasticity_base1]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 2e2
    poissons_ratio = 0.27
    block = 2
  [../]
  [./strain]
    type = ComputeFiniteStrain
    block = '2 3'
    displacements = 'disp_x disp_y disp_z'
  [../]
  [./stress]
    type =  ComputeFiniteStrainElasticStress
    block = '2 3'
  [../]
  [./elasticity]
    type = ADComputeIsotropicElasticityTensorShell
    youngs_modulus = 2e4
    poissons_ratio = 0.27
    # bulk_modulus = 2.25
    # shear_modulus = 1e-5
    block = 1
    through_thickness_order = SECOND
  [../]
  [./strain1]
    type = ADComputeIncrementalShellStrain
    block = 1
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y'
    thickness = 0.0079
    through_thickness_order = SECOND
  [../]
  [./stress1]
    type = ADComputeShellStress
    block = 1
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
  start_time = 0.0
  end_time = 7.0
  dt = 0.005
  dtmin = 0.00001
  nl_abs_tol = 1e-14 # 1e-3
  nl_rel_tol = 1e-14 # 1e-3
  l_tol = 1e-14 # 1e-3
  l_max_its = 7
  timestep_tolerance = 1e-8
  automatic_scaling = true
  [TimeIntegrator]
    type = NewmarkBeta
  []
[]

[Postprocessors]
  [./Accelx]
    type = PointValue
    point = '0.79 0.0 0.5'
    variable = accel_x
  [../]
  [./StressFluid1]
    type = PointValue
    point = '0.79 0.0 0.0079'
    variable = stress_xx
  [../]
  [./AccelxFluid1]
    type = PointValue
    point = '0.79 0.0 0.0079'
    variable = accel_x
  [../]
  [./AccelxFluid2]
    type = PointValue
    point = '0.71 0.0 1.8'
    variable = accel_x
  [../]
  [./StressFluid2]
    type = PointValue
    point = '0.71 0.0 1.8'
    variable = stress_xx
  [../]
[]

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
  print_linear_residuals = true
  file_base = Ex_SC_ElCentro_ShellSolid_2
  [./out]
    execute_on = 'TIMESTEP_BEGIN'
    type = CSV
    file_base = SC_ElCentro_ShellSolid_2
  [../]
[]
