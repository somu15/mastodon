[Mesh]
  [file]
    type = FileMeshGenerator
    file = ex_new.e
  []
  [./interface1]
    type = SideSetsBetweenSubdomainsGenerator
    input = file
    primary_block = '2'
    paired_block = '1'
    new_boundary = 'Interface'
  [../]
  construct_side_list_from_node_list=true
[]

[GlobalParams]
[]

[Variables]
  [./p]
    block = 1
  [../]
  [./disp_x]
    block = 2
  [../]
  [./disp_y]
    block = 2
  [../]
  [./disp_z]
    block = 2
  [../]
  [./rot_x]
    block = 2
  [../]
  [./rot_y]
    block = 2
  [../]
[]

[AuxVariables]
  [./vel_x]
    block = 2
  [../]
  [./accel_x]
    block = 2
  [../]
  [./vel_y]
    block = 2
  [../]
  [./vel_z]
    block = 2
  [../]
  [./accel_y]
    block = 2
  [../]
  [./accel_z]
    block = 2
  [../]
  [./stress_xx]
    order = CONSTANT
    family = MONOMIAL
    block = 2
  [../]
  [./stress_yy]
    order = CONSTANT
    family = MONOMIAL
    block = 2
  [../]
  [./stress_xy]
    order = CONSTANT
    family = MONOMIAL
    block = 2
  [../]
  [./rot_vel_x]
    block = 2
  [../]
  [./rot_vel_y]
    block = 2
  [../]
  [./rot_vel_z]
    block = 2
  [../]
  [./rot_accel_x]
    block = 2
  [../]
  [./rot_accel_y]
    block = 2
  [../]
  [./rot_accel_z]
    block = 2
  [../]
[]

[Kernels]
  [./diffusion]
    type = Diffusion
    variable = 'p'
    block = 1
  [../]
  [./inertia]
    type = AcousticInertia
    variable = p
    block = 1
  [../]
  [./solid_disp_x]
    type = ADStressDivergenceShell
    block = 2
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
  [./inertial_force_x]
    type = ADInertialForceShell
    block = 2
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y'
    velocities = 'vel_x vel_y vel_z'
    accelerations = 'accel_x accel_y accel_z'
    rotational_velocities = 'rot_vel_x rot_vel_y'
    rotational_accelerations = 'rot_accel_x rot_accel_y'
    component = 0
    variable = disp_x
    thickness = 1
  [../]
  [./inertial_force_y]
    type = ADInertialForceShell
    block = 2
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y'
    velocities = 'vel_x vel_y vel_z'
    accelerations = 'accel_x accel_y accel_z'
    rotational_velocities = 'rot_vel_x rot_vel_y'
    rotational_accelerations = 'rot_accel_x rot_accel_y'
    component = 1
    variable = disp_y
    thickness = 1
  [../]
  [./inertial_force_z]
    type = ADInertialForceShell
    block = 2
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y'
    velocities = 'vel_x vel_y vel_z'
    accelerations = 'accel_x accel_y accel_z'
    rotational_velocities = 'rot_vel_x rot_vel_y'
    rotational_accelerations = 'rot_accel_x rot_accel_y'
    component = 2
    variable = disp_z
    thickness = 1
  [../]
  [./inertial_force_rot_x]
    type = ADInertialForceShell
    block = 2
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y'
    velocities = 'vel_x vel_y vel_z'
    accelerations = 'accel_x accel_y accel_z'
    rotational_velocities = 'rot_vel_x rot_vel_y'
    rotational_accelerations = 'rot_accel_x rot_accel_y'
    component = 3
    variable = rot_x
    thickness = 1
  [../]
  [./inertial_force_rot_y]
    type = ADInertialForceShell
    block = 2
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y'
    velocities = 'vel_x vel_y vel_z'
    accelerations = 'accel_x accel_y accel_z'
    rotational_velocities = 'rot_vel_x rot_vel_y'
    rotational_accelerations = 'rot_accel_x rot_accel_y'
    component = 4
    variable = rot_y
    thickness = 1
  [../]
[]

[AuxKernels]
  [./accel_x]
    type = TestNewmarkTI
    displacement = disp_x
    variable = accel_x
    first = false
    block = 2
  [../]
  [./vel_x]
    type = TestNewmarkTI
    displacement = disp_x
    variable = vel_x
    block = 2
  [../]
  [./accel_y]
    type = TestNewmarkTI
    displacement = disp_y
    variable = accel_y
    first = false
    block = 2
  [../]
  [./vel_y]
    type = TestNewmarkTI
    displacement = disp_y
    variable = vel_y
    block = 2
  [../]
  [./rot_accel_x]
    type = TestNewmarkTI
    displacement = rot_x
    variable = rot_accel_x
    first = false
    block = 2
  [../]
  [./rot_vel_x]
    type = TestNewmarkTI
    displacement = rot_x
    variable = rot_vel_x
    block = 2
  [../]
  [./rot_accel_y]
    type = TestNewmarkTI
    displacement = rot_y
    variable = rot_accel_y
    first = false
    block = 2
  [../]
  [./rot_vel_y]
    type = TestNewmarkTI
    displacement = rot_y
    variable = rot_vel_y
    block = 2
  [../]
  [./stress_xx]
    type = RankTwoAux
    rank_two_tensor = global_stress_t_points_0
    variable = stress_xx
    index_i = 0
    index_j = 0
    block = 2
  [../]
  [./stress_yy]
    type = RankTwoAux
    rank_two_tensor = global_stress_t_points_0
    variable = stress_yy
    index_i = 1
    index_j = 1
    block = 2
  [../]
  [./stress_xy]
    type = RankTwoAux
    rank_two_tensor = global_stress_t_points_0
    variable = stress_xy
    index_i = 0
    index_j = 1
    block = 2
  [../]
[]

[InterfaceKernels]
  [./interface1]
    type =  FluidStructureInterface_3D
    variable = disp_x
    neighbor_var = 'p'
    boundary = 'Interface'
    D = 1e-6
    component = 0
  [../]
  [./interface2]
    type =  FluidStructureInterface_3D
    variable = disp_y
    neighbor_var = 'p'
    boundary = 'Interface'
    D = 1e-6
    component = 1
  [../]
  [./interface3]
    type =  FluidStructureInterface_3D
    variable = disp_z
    neighbor_var = 'p'
    boundary = 'Interface'
    D = 1e-6
    component = 2
  [../]
[]

[BCs]
  [./bottom_accel]
    type = FunctionDirichletBC
    variable = p
    boundary = 'Bottom'
    function = accel_bottom
    # value = 0
  [../]
  # [./disp_x1]
  #   type = NeumannBC # DirichletBC
  #   boundary = 'right'
  #   variable = disp_x
  #   value = 0.0
  # [../]
  [./disp_x1]
    type = NeumannBC
    boundary = 'Top'
    variable = disp_x
    value = 0.0
  [../]
  [./disp_x2]
    type = NeumannBC # DirichletBC
    boundary = 'Top'
    variable = disp_y
    value = 0.0
  [../]
  # [./disp_y_TB]
  #   type = DirichletBC
  #   boundary = 'top bottom'
  #   variable = disp_y
  #   value = 0.0
  # [../]
[]

[Functions]
  [./accel_bottom]
    type = PiecewiseLinear
    data_file = Input_1Peak_highF.csv # Input_1Peak.csv
    scale_factor = 1e-2
    format = 'columns'
  [../]
[]

[Materials]
  [./density]
    type = GenericConstantMaterial
    prop_names = inv_co_sq
    prop_values = 4.65e-7
    block = 1
  [../]
  [./elasticity]
    type = ADComputeIsotropicElasticityTensorShell
    # youngs_modulus = 1e2
    # poissons_ratio = 0.3
    bulk_modulus = 2.25
    shear_modulus = 1e-4
    block = 2
    through_thickness_order = SECOND
  [../]
  [./strain]
    type = ADComputeIncrementalShellStrain
    block = 2
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y'
    thickness = 1
    through_thickness_order = SECOND
  [../]
  [./stress]
    type = ADComputeShellStress
    block = 2
    through_thickness_order = SECOND
  [../]
  [./density0]
    type = GenericConstantMaterial
    block = 2
    prop_names = 'density'
    prop_values = '1e-6'
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
  start_time = 0.0
  end_time = 0.12
  dt = 0.00025
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

# [Postprocessors]
#   [./p1]
#     type = PointValue
#     point = '5.0 0.0 0.0'
#     variable = p
#   [../]
#   [./stress1]
#     type = PointValue
#     point = '5.0 0.0 0.0'
#     variable = stress_xx
#   [../]
#   [./stress2]
#     type = PointValue
#     point = '5.0 0.0 0.0'
#     variable = stress_yy
#   [../]
#   [./stress3]
#     type = PointValue
#     point = '5.0 0.0 0.0'
#     variable = stress_xy
#   [../]
# []

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
  print_linear_residuals = true
  file_base = Ex_ex
  [./out]
    execute_on = 'TIMESTEP_BEGIN'
    type = CSV
    file_base = ex
  [../]
[]
