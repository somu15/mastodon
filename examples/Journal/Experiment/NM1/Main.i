[Mesh]
  [file]
    type = FileMeshGenerator
    file = Model_Coarse.e
  []
  [interface1]
    type = SideSetsBetweenSubdomainsGenerator
    input = file
    master_block = '1'
    paired_block = '3'
    new_boundary = 'Interface1'
  []
  [interface2]
    type = SideSetsBetweenSubdomainsGenerator
    input = interface1
    master_block = '2'
    paired_block = '3'
    new_boundary = 'Interface2'
  []
[]

[GlobalParams]
[]

[Variables]
  [p]
   block = 3
  []
  [disp_x]
    block = '1 2'
  []
  [disp_y]
    block = '1 2'
  []
  [disp_z]
    block = '1 2'
  []
[]

[AuxVariables]
  [Wave1]
    block = 3
  []
  [vel_x]
    order = FIRST
    family = LAGRANGE
    block = '1 2'
  []
  [accel_x]
    order = FIRST
    family = LAGRANGE
    block = '1 2'
  []
  [vel_y]
    order = FIRST
    family = LAGRANGE
    block = '1 2'
  []
  [accel_y]
    order = FIRST
    family = LAGRANGE
    block = '1 2'
  []
  [vel_z]
    order = FIRST
    family = LAGRANGE
    block = '1 2'
  []
  [accel_z]
    order = FIRST
    family = LAGRANGE
    block = '1 2'
  []
  [stress_xx]
    order = CONSTANT
    family = MONOMIAL
    block = '1 2'
  []
  [stress_yy]
    order = CONSTANT
    family = MONOMIAL
    block = '1 2'
  []
  [stress_xy]
    order = CONSTANT
    family = MONOMIAL
    block = '1 2'
  []
  [stress_zz]
    order = CONSTANT
    family = MONOMIAL
    block = '1 2'
  []
  [stress_yz]
    order = CONSTANT
    family = MONOMIAL
    block = '1 2'
  []
  [stress_xz]
    order = CONSTANT
    family = MONOMIAL
    block = '1 2'
  []
[]

[Kernels]
  [diffusion]
    type = Diffusion
    variable = 'p'
    block = 3
  []
  [inertia]
    type = AcousticInertia
    variable = p
    block = 3
  []
  [DynamicTensorMechanics]
    displacements = 'disp_x disp_y disp_z'
    block = '1 2'
    # alpha = -0.3 # -0.1
    # zeta = 1.25e-4 # stiffness proportional damping
  []
  [inertia_x1]
    type = InertialForce
    variable = disp_x
    block = '1 2'
    # eta = 0.75 # Mass proportional Rayleigh damping
  []
  [inertia_y1]
    type = InertialForce
    variable = disp_y
    block = '1 2'
    # eta = 0.75 # Mass proportional Rayleigh damping
  []
  [inertia_z1]
    type = InertialForce
    variable = disp_z
    block = '1 2'
    # eta = 0.75 # Mass proportional Rayleigh damping
  []
[]

[AuxKernels]
  [waves]
    type = WaveHeightAuxKernel
    variable = 'Wave1'
    pressure = p
    density = 1e-6
    gravity = 9.81
    execute_on = timestep_end
    block = 3
  []
  [accel_x]
    type = TestNewmarkTI
    displacement = disp_x
    variable = accel_x
    first = false
    block = '1 2'
  []
  [vel_x]
    type = TestNewmarkTI
    displacement = disp_x
    variable = vel_x
    block = '1 2'
  []
  [accel_y]
    type = TestNewmarkTI
    displacement = disp_y
    variable = accel_y
    first = false
    block = '1 2'
  []
  [vel_y]
    type = TestNewmarkTI
    displacement = disp_y
    variable = vel_y
    block = '1 2'
  []
  [accel_z]
    type = TestNewmarkTI
    displacement = disp_z
    variable = accel_z
    first = false
    block = '1 2'
  []
  [vel_z]
    type = TestNewmarkTI
    displacement = disp_z
    variable = vel_z
    block = '1 2'
  []
  [stress_xx]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xx
    index_i = 0
    index_j = 0
    block = '1 2'
  []
  [stress_yy]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_yy
    index_i = 1
    index_j = 1
    block = '1 2'
  []
  [stress_xy]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xy
    index_i = 0
    index_j = 1
    block = '1 2'
  []
  [stress_zz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_zz
    index_i = 2
    index_j = 2
    block = '1 2'
  []
  [stress_yz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_yz
    index_i = 1
    index_j = 2
    block = '1 2'
  []
  [stress_xz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xz
    index_i = 0
    index_j = 2
    block = '1 2'
  []
[]

[InterfaceKernels]
  [interface1]
    type = FSI_test
    variable = disp_x
    neighbor_var = 'p'
    boundary = 'Interface1 Interface2'
    D = 1e-6
    component = 0
  []
  [interface2]
    type = FSI_test
    variable = disp_y
    neighbor_var = 'p'
    boundary = 'Interface1 Interface2'
    D = 1e-6
    component = 1
  []
  [interface3]
    type = FSI_test
    variable = disp_z
    neighbor_var = 'p'
    boundary = 'Interface1 Interface2'
    D = 1e-6
    component = 2
  []
[]

[BCs]
  [bottom_accel1]
    type = PresetAcceleration
    variable = disp_x
    velocity = vel_x
    acceleration = accel_x
    beta = 0.25
    function = accel_bottomx
    boundary = 'Bottom'
  []
  [free]
    type = FluidFreeSurfaceBC
    variable = p
    boundary = 'Fluid_top'
    alpha = '0.1'
  []
  [Nodx1]
    type = PresetAcceleration
    variable = disp_z
    velocity = vel_z
    acceleration = accel_z
    beta = 0.25
    function = Nodex1
    boundary = 'Nx1'
  []
  [Nodx2]
    type = PresetAcceleration
    variable = disp_z
    velocity = vel_z
    acceleration = accel_z
    beta = 0.25
    function = Nodex2
    boundary = 'Nx2'
  []
  [Nodx3]
    type = PresetAcceleration
    variable = disp_z
    velocity = vel_z
    acceleration = accel_z
    beta = 0.25
    function = Nodex3
    boundary = 'Nx3'
  []
  [Nodx4]
    type = PresetAcceleration
    variable = disp_z
    velocity = vel_z
    acceleration = accel_z
    beta = 0.25
    function = Nodex4
    boundary = 'Nx4'
  []
  [Nodx5]
    type = PresetAcceleration
    variable = disp_z
    velocity = vel_z
    acceleration = accel_z
    beta = 0.25
    function = Nodex5
    boundary = 'Nx5'
  []
  [Nodx7]
    type = PresetAcceleration
    variable = disp_z
    velocity = vel_z
    acceleration = accel_z
    beta = 0.25
    function = Nodex7
    boundary = 'Nx7'
  []
  [Nodx8]
    type = PresetAcceleration
    variable = disp_z
    velocity = vel_z
    acceleration = accel_z
    beta = 0.25
    function = Nodex8
    boundary = 'Nx8'
  []
  [Nodx9]
    type = PresetAcceleration
    variable = disp_z
    velocity = vel_z
    acceleration = accel_z
    beta = 0.25
    function = Nodex9
    boundary = 'Nx9'
  []
  [Nodx10]
    type = PresetAcceleration
    variable = disp_z
    velocity = vel_z
    acceleration = accel_z
    beta = 0.25
    function = Nodex10
    boundary = 'Nx10'
  []
  [Nodx11]
    type = PresetAcceleration
    variable = disp_z
    velocity = vel_z
    acceleration = accel_z
    beta = 0.25
    function = Nodex11
    boundary = 'Nx11'
  []
[]

[Functions]
  [accel_bottomx]
    type = PiecewiseLinear
    data_file = XT.csv
    scale_factor = 9.81
    format = 'columns'
  []
  [Nodex1]
    type = PiecewiseLinear
    data_file = XR_1.csv
    scale_factor = 0.76
    format = 'columns'
  []
  [Nodex2]
    type = PiecewiseLinear
    data_file = XR_2.csv
    scale_factor = 0.61432
    format = 'columns'
  []
  [Nodex3]
    type = PiecewiseLinear
    data_file = XR_3.csv
    scale_factor = 0.46074
    format = 'columns'
  []
  [Nodex4]
    type = PiecewiseLinear
    data_file = XR_4.csv
    scale_factor = 0.30176
    format = 'columns'
  []
  [Nodex5]
    type = PiecewiseLinear
    data_file = XR_5.csv
    scale_factor = 0.15358
    format = 'columns'
  []
  [Nodex7]
    type = PiecewiseLinear
    data_file = XR_7.csv
    scale_factor = -0.15358
    format = 'columns'
  []
  [Nodex8]
    type = PiecewiseLinear
    data_file = XR_8.csv
    scale_factor = -0.30176
    format = 'columns'
  []
  [Nodex9]
    type = PiecewiseLinear
    data_file = XR_9.csv
    scale_factor = -0.46074
    format = 'columns'
  []
  [Nodex10]
    type = PiecewiseLinear
    data_file = XR_10.csv
    scale_factor = -0.61432
    format = 'columns'
  []
  [Nodex11]
    type = PiecewiseLinear
    data_file = XR_11.csv
    scale_factor = -0.76
    format = 'columns'
  []
[]

[Materials]
  [density]
    type = GenericConstantMaterial
    prop_names = inv_co_sq
    prop_values = 4.65e-7
    block = 3
  []
  [density0]
    type = GenericConstantMaterial
    block = '1'
    prop_names = density
    prop_values = 7.88e-6
  []
  [density1]
    type = GenericConstantMaterial
    block = '2'
    prop_names = density
    prop_values = 17.571e-6
  []
  [elasticity_base1]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 2e2
    poissons_ratio = 0.27
    block = '1'
  []
  [elasticity_base2]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 2e5
    poissons_ratio = 0.27
    block = '2'
  []
  [strain]
    type = ComputeSmallStrain # ComputeFiniteStrain
    block = '1 2'
    displacements = 'disp_x disp_y disp_z'
  []
  [stress]
    type = ComputeLinearElasticStress # ComputeFiniteStrainElasticStress
    block = '1 2'
  []
[]

[Preconditioning]
  [andy]
    type = SMP
    full = true
  []
[]

[Executioner]
  type = Transient
  solve_type = 'NEWTON'
  petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
  petsc_options_value = 'lu       superlu_dist'
  start_time = 0.0
  end_time = 6.0
  dt = 0.002
  dtmin = 0.00001
  nl_abs_tol = 1e-6 # 1e-3
  nl_rel_tol = 1e-7 # 1e-3
  l_tol = 1e-8 # 1e-3
  l_max_its = 25
  timestep_tolerance = 1e-8
  automatic_scaling = true
  [TimeIntegrator]
    type = NewmarkBeta
    # beta = 0.49
    # gamma = 0.9
    # beta = 0.4225
    # gamma = 0.8
  []
[]

[Postprocessors]
  # [PW1]
  #   type = PointValue
  #   point = '-0.76 0.0 0.3495'
  #   variable = p
  # []
  # [PW2]
  #   type = PointValue
  #   point = '-0.76 0.0 0.9585'
  #   variable = p
  # []
  # [PW3]
  #   type = PointValue
  #   point = '-0.76 0.0 1.5685'
  #   variable = p
  # []
  # [Wave_E]
  #   type = PointValue
  #   point = '0.709 0.0 1.6445'
  #   variable = Wave1
  # []
  # [Wave_W]
  #   type = PointValue
  #   point = '-0.709 0.0 1.6445'
  #   variable = Wave1
  # []
  # [moment_x]
  #   type = SidesetMoment
  #   boundary = 'fluid_side fluid_bottom' #
  #   reference_point = '0.0 0.0 0.0445'
  #   moment_direction = '1 0 0'
  #   pressure = p
  # []
  [moment_y1]
    type = SidesetMoment
    boundary = 'fluid_side' #
    reference_point = '0.0 0.0 0.0'
    moment_direction = '0 1 0'
    pressure = p
  []
  [moment_y2]
    type = SidesetMoment
    boundary = 'fluid_bottom' #
    reference_point = '0.0 0.0 0.0'
    moment_direction = '0 1 0'
    pressure = p
  []
  # [moment_z]
  #   type = SidesetMoment
  #   boundary = 'fluid_side fluid_bottom' #
  #   reference_point = '0.0 0.0 0.0445'
  #   moment_direction = '0 0 1'
  #   pressure = p
  # []
  # [moment_wall]
  #   type = SidesetMoment
  #   boundary = 'fluid_side' # fluid_bottom
  #   reference_point = '0.0 0.0 0.0445'
  #   moment_direction = '1 0 0'
  #   pressure = p
  #   option = 0
  # []
  # [moment_base]
  #   type = SidesetMoment
  #   boundary = 'fluid_bottom'
  #   reference_point = '0.0 0.0 0.0445'
  #   moment_direction = '0 1 0'
  #   pressure = p
  #   option = 1
  # []
[]

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
  print_linear_residuals = true
  file_base = Ex_Main_Results
  [out]
    execute_on = 'TIMESTEP_BEGIN'
    type = CSV
    file_base = Main_Results
  []
[]
