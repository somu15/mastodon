[Mesh]
  [file]
    type = FileMeshGenerator
    file = Model_Shell.e
  []
  # [./interface1]
  #   type = SideSetsBetweenSubdomainsGenerator
  #   input = file
  #   primary_block = '1'
  #   paired_block = '2'
  #   new_boundary = 'Interface'
  # [../]
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
  [./disp_z]
    block = 1
  [../]
  [./rot_x]
    block = 1
  [../]
  [./rot_y]
    block = 1
  [../]
[]

[AuxVariables]
  [./Wave1]
    block = 2
  [../]
  [./vel_x]
    order = FIRST
    family = LAGRANGE
    block = 1
  [../]
  [./accel_x]
    order = FIRST
    family = LAGRANGE
    block = 1
  [../]
  [./vel_y]
    order = FIRST
    family = LAGRANGE
    block = 1
  [../]
  [./accel_y]
    order = FIRST
    family = LAGRANGE
    block = 1
  [../]
  [./vel_z]
    order = FIRST
    family = LAGRANGE
    block = 1
  [../]
  [./accel_z]
    order = FIRST
    family = LAGRANGE
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
  [./rot_vel_x]
    block = 1
  [../]
  [./rot_vel_y]
    block = 1
  [../]
  [./rot_vel_z]
    block = 1
  [../]
  [./rot_accel_x]
    block = 1
  [../]
  [./rot_accel_y]
    block = 1
  [../]
  [./rot_accel_z]
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
  [./waves]
    type = WaveHeightAuxKernel
    variable = 'Wave1'
    pressure = p
    dens = 1e-6
    grav = 9.81
    execute_on = timestep_end
    block = 2
  [../]
  [./accel_x]
    type = TestNewmarkTI
    displacement = disp_x
    variable = accel_x
    first = false
    block = 1
  [../]
  [./vel_x]
    type = TestNewmarkTI
    displacement = disp_x
    variable = vel_x
    block = 1
  [../]
  [./accel_y]
    type = TestNewmarkTI
    displacement = disp_y
    variable = accel_y
    first = false
    block = 1
  [../]
  [./vel_y]
    type = TestNewmarkTI
    displacement = disp_y
    variable = vel_y
    block = 1
  [../]
  [./rot_accel_x]
    type = TestNewmarkTI
    displacement = rot_x
    variable = rot_accel_x
    first = false
    block = 1
  [../]
  [./rot_vel_x]
    type = TestNewmarkTI
    displacement = rot_x
    variable = rot_vel_x
    block = 1
  [../]
  [./rot_accel_y]
    type = TestNewmarkTI
    displacement = rot_y
    variable = rot_accel_y
    first = false
    block = 1
  [../]
  [./rot_vel_y]
    type = TestNewmarkTI
    displacement = rot_y
    variable = rot_vel_y
    block = 1
  [../]
  [./stress_xx]
    type = RankTwoAux
    rank_two_tensor = global_stress_t_points_0
    variable = stress_xx
    index_i = 0
    index_j = 0
    block = 1
  [../]
  [./stress_yy]
    type = RankTwoAux
    rank_two_tensor = global_stress_t_points_0
    variable = stress_yy
    index_i = 1
    index_j = 1
    block = 1
  [../]
  [./stress_xy]
    type = RankTwoAux
    rank_two_tensor = global_stress_t_points_0
    variable = stress_xy
    index_i = 0
    index_j = 1
    block = 1
  [../]
[]

[InterfaceKernels]
  [./interface1]
    type = FluidStructureInterface
    variable = p
    neighbor_var = disp_x
    boundary = 'Interface1 Interface2'
    D = 1e-6
    component = 0
  [../]
  [./interface2]
    type = FluidStructureInterface
    variable = p
    neighbor_var = disp_y
    boundary = 'Interface1 Interface2'
    D = 1e-6
    component = 1
  [../]
  [./interface3]
    type =  FluidStructureInterface
    variable = p
    neighbor_var = disp_z
    boundary = 'Interface1 Interface2'
    D = 1e-6
    component = 2
  [../]
[]

[BCs]
  [./bottom_accel1]
    type = PresetAcceleration
    variable = disp_x
    velocity = vel_x
    acceleration = accel_x
    beta = 0.25
    function = accel_bottom
    boundary = 'Bottom'
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
  [./free]
    type = FluidFreeSurfaceBC
    variable = p
    boundary = 'Fluid_top'
    alpha = '0.1'
  []
[]

[Functions]
  [./accel_bottom]
    type = PiecewiseLinear
    data_file = Ormsby_USE1.csv
    scale_factor = 1.0
    format = 'columns'
  [../]
[]

[Materials]
  [./density]
    type = GenericConstantMaterial
    prop_names = inv_co_sq
    prop_values = 4.65e-7
    block = 2
  [../]
  [./elasticity]
    type = ADComputeIsotropicElasticityTensorShell
    youngs_modulus = 2e2
    poissons_ratio = 0.27
    block = 1
    through_thickness_order = SECOND
  [../]
  [./strain]
    type = ADComputeIncrementalShellStrain
    block = '1'
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y'
    thickness = 0.0079
    through_thickness_order = SECOND
  [../]
  [./stress]
    type = ADComputeShellStress
    block = 1
    through_thickness_order = SECOND
  [../]
  [./density0]
    type = GenericConstantMaterial
    block = 1
    prop_names = 'density'
    prop_values = 7.85e-6
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
  petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
  petsc_options_value = 'lu       superlu_dist'
  start_time = 0.9
  end_time = 1.1
  dt = 0.005
  dtmin = 0.00001
  nl_abs_tol = 1e-8 # 1e-3
  nl_rel_tol = 1e-8 # 1e-3
  l_tol = 1e-8 # 1e-3
  l_max_its = 10
  timestep_tolerance = 1e-8
  automatic_scaling = true
  [TimeIntegrator]
    type = NewmarkBeta
  []
[]

[Postprocessors]
  [./PBottom]
    type = PointValue
    point = '0.79 0.0 0.9'
    variable = p
  [../]
  [./Wave]
    type = PointValue
    point = '0.3 0.0 1.8'
    variable = Wave1
  [../]
[]

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
  print_linear_residuals = true
  file_base = Ex_Model_Shell
  [./out]
    execute_on = 'TIMESTEP_BEGIN'
    type = CSV
    file_base = Model_Shell_Ormsby
  [../]
[]
