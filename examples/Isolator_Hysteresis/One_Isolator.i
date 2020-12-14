[Mesh]
  [file]
    type = FileMeshGenerator
    file = One_Isolator.e
  []
[]

[GlobalParams]
[]

# [Controls]
#   [./C1]
#     type = TimePeriod
#     disable_objects = '*::x_inertial1 *::y_inertial1 *::z_inertial1 *::vel_x *::vel_y *::vel_z *::accel_x *::accel_y *::accel_z'
#     start_time = '0'
#     end_time = '0.10'
#   [../]
# []

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
  [./rot_x]
    block = '1'
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_y]
    block = '1'
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_z]
    block = '1'
    order = FIRST
    family = LAGRANGE
  [../]
[]

[AuxVariables]
  [./vel_x]
    order = FIRST
    family = LAGRANGE
    block = '1'
  [../]
  [./accel_x]
    order = FIRST
    family = LAGRANGE
    block = '1'
  [../]
  [./vel_y]
    order = FIRST
    family = LAGRANGE
    block = '1'
  [../]
  [./accel_y]
    order = FIRST
    family = LAGRANGE
    block = '1'
  [../]
  [./vel_z]
    order = FIRST
    family = LAGRANGE
    block = '1'
  [../]
  [./accel_z]
    order = FIRST
    family = LAGRANGE
    block = '1'
  [../]
  [./rot_vel_x]
    block = '1'
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_vel_y]
    block = '1'
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_vel_z]
    block = '1'
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_accel_x]
    block = '1'
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_accel_y]
    block = '1'
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_accel_z]
    block = '1'
    order = FIRST
    family = LAGRANGE
  [../]
  [./reaction_x]
    block = '1'
  [../]
  [./reaction_y]
    block = '1'
  [../]
  [./reaction_z]
    block = '1'
  [../]
  [./reaction_xx]
    block = '1'
  [../]
  [./reaction_yy]
    block = '1'
  [../]
  [./reaction_zz]
    block = '1'
  [../]
[]

[Kernels]
  [./lr_disp_x]
    block = '1'
    type = StressDivergenceIsolator
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    component = 0
    variable = disp_x
    save_in = reaction_x
  [../]
  [./lr_disp_y]
    block = '1'
    type = StressDivergenceIsolator
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    component = 1
    variable = disp_y
    save_in = reaction_y
  [../]
  [./lr_disp_z]
    block = '1'
    type = StressDivergenceIsolator
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    component = 2
    variable = disp_z
    save_in = reaction_z
  [../]
  [./lr_rot_x]
    block = '1'
    type = StressDivergenceIsolator
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    component = 3
    variable = rot_x
    save_in = reaction_xx
  [../]
  [./lr_rot_y]
    block = '1'
    type = StressDivergenceIsolator
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    component = 4
    variable = rot_y
    save_in = reaction_yy
  [../]
  [./lr_rot_z]
    block = '1'
    type = StressDivergenceIsolator
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    component = 5
    variable = rot_z
    save_in = reaction_zz
  [../]
  # [./gravity]
  #   type = Gravity
  #   variable = disp_z
  #   value = -9.81
  # [../]
[]

[NodalKernels]
  [./x_inertial1]
    type = NodalTranslationalInertia
    block = 1
    variable = disp_x
    # velocity = vel_x
    # acceleration = accel_x
    boundary = IsoTop
    # beta = 0.25
    # gamma = 0.5
    mass = 6.40745e-4 # 640745
    # alpha =0
    # eta =0
  [../]
  [./y_inertial1]
    type = NodalTranslationalInertia
    block = 1
    variable = disp_y
    # velocity = vel_y
    # acceleration = accel_y
    boundary = IsoTop
    # beta = 0.25
    # gamma = 0.5
    mass = 6.40745e-4 # 640745
    # alpha =0
    # eta =0
  [../]
  [./z_inertial1]
    type = NodalTranslationalInertia
    block = 1
    variable = disp_z
    # velocity = vel_z
    # acceleration = accel_z
    boundary = IsoTop
    # beta = 0.25
    # gamma = 0.5
    mass = 6.40745e-4 # 640745
    # alpha =0
    # eta =0
  [../]
  [./force_x]
    type = UserForcingFunctionNodalKernel
    variable = disp_z
    boundary = IsoTop
    function = force_z
  [../]
[]

[AuxKernels]
  [./accel_x]
    type = TestNewmarkTI
    displacement = disp_x
    variable = accel_x
    first = false
    block = '1'
  [../]
  [./vel_x]
    type = TestNewmarkTI
    displacement = disp_x
    variable = vel_x
    block = '1'
  [../]
  [./accel_y]
    type = TestNewmarkTI
    displacement = disp_y
    variable = accel_y
    first = false
    block = '1'
  [../]
  [./vel_y]
    type = TestNewmarkTI
    displacement = disp_y
    variable = vel_y
    block = '1'
  [../]
  [./accel_z]
    type = TestNewmarkTI
    displacement = disp_z
    variable = accel_z
    first = false
    block = '1'
  [../]
  [./vel_z]
    type = TestNewmarkTI
    displacement = disp_z
    variable = vel_z
    block = '1'
  [../]
  [./rot_accel_x]
    block = '1'
    type = TestNewmarkTI
    displacement = rot_x
    variable = rot_accel_x
    first = false
  [../]
  [./rot_vel_x]
    block = '1'
    type = TestNewmarkTI
    displacement = rot_x
    variable = rot_vel_x
  [../]
  [./rot_accel_y]
    block = '1'
    type = TestNewmarkTI
    displacement = rot_y
    variable = rot_accel_y
    first = false
  [../]
  [./rot_vel_y]
    block = '1'
    type = TestNewmarkTI
    displacement = rot_y
    variable = rot_vel_y
  [../]
  [./rot_accel_z]
    block = '1'
    type = TestNewmarkTI
    displacement = rot_z
    variable = rot_accel_z
    first = false
  [../]
  [./rot_vel_z]
    block = '1'
    type = TestNewmarkTI
    displacement = rot_z
    variable = rot_vel_z
  [../]
[]

[BCs]
  [./fixrx0]
    type = DirichletBC
    variable = rot_x
    boundary = 'IsoBottom'
    value = 0.0
  [../]
  [./fixry0]
    type = DirichletBC
    variable = rot_y
    boundary = 'IsoBottom'
    value = 0.0
  [../]
  [./fixrz0]
    type = DirichletBC
    variable = rot_z
    boundary = 'IsoBottom'
    value = 0.0
  [../]
  [./fixrx1]
    type = DirichletBC
    variable = rot_x
    boundary = 'IsoTop'
    value = 0.0
  [../]
  [./fixry1]
    type = DirichletBC
    variable = rot_y
    boundary = 'IsoTop'
    value = 0.0
  [../]
  [./fixrz1]
    type = DirichletBC
    variable = rot_z
    boundary = 'IsoTop'
    value = 0.0
  [../]
  [./disp_x1T]
    type = FunctionDirichletBC
    variable = disp_x
    boundary = 'IsoBottom'
    function = accel_bottom
  [../]
  # [./disp_x2T]
  #   type = DirichletBC
  #   variable = disp_y
  #   boundary = 'IsoTop'
  #   value = 0.0
  # [../]
  # [./disp_x3T]
  #   type = DirichletBC
  #   variable = disp_z
  #   boundary = 'IsoTop'
  #   value = 0.0
  # [../]
  # [./disp_x1]
  #   type = DirichletBC
  #   variable = disp_x
  #   boundary = 'IsoBottom'
  #   value = 0.0
  # [../]
  [./disp_x2]
    type = DirichletBC
    variable = disp_y
    boundary = 'IsoBottom'
    value = 0.0
  [../]
  [./disp_x3]
    type = DirichletBC
    variable = disp_z
    boundary = 'IsoBottom'
    value = 0.0
  [../]
[]

[Functions]
  [./accel_bottom]
    type = PiecewiseLinear
    data_file = Sine_0_5Hz.csv
    scale_factor = 0.1
    format = 'columns'
  [../]
  [./force_z]
    type = PiecewiseLinear
    x='0.0 0.5 50.11'
    y='0.0 -6.285471e-3 -6.285471e-3'
  [../]
[]

[Materials]
  # [./density]
  #   type = GenericConstantMaterial
  #   prop_names = density
  #   prop_values = 4.77e-6
  #   block = 1
  # [../]
  [./deformation]
    type = ComputeIsolatorDeformation
    sd_ratio = 0.5
    y_orientation = '0.0 1.0 0.0'
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    velocities = 'vel_x vel_y vel_z'
    block = '1'
  [../]
  [./elasticity]
    type = ComputeFPIsolatorElasticity
    mu_ref = 0.06
    p_ref = 0.05 # 50e6
    block = '1'
    diffusivity = 4.4e-6
    conductivity = 18
    a = 100
    r_eff = 2.2352
    r_contact = 0.2
    uy = 0.001
    unit = 9
    gamma = 0.5
    beta = 0.25
    pressure_dependent = true
    temperature_dependent = true
    velocity_dependent = true
    k_x = 78.53 # 7.853e10
    k_xx = 0.62282 # 622820743.6
    k_yy = 0.3114 # 311410371.8
    k_zz = 0.3114 # 311410371.8
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
  end_time = 4.5
  dt = 0.0001
  dtmin = 0.00001
  nl_abs_tol = 1e-18
  nl_rel_tol = 1e-8
  l_tol = 1e-10
  l_abs_tol = 1e-18
  l_max_its = 7
  timestep_tolerance = 1e-8
  automatic_scaling = true
  [TimeIntegrator]
    type = NewmarkBeta
  []
[]

[Postprocessors]
  [./Iso1_Bot_ReacX]
    type = NodalVariableValue
    nodeid = 0
    variable = reaction_x
  [../]
  [./Iso1_Bot_DispX]
    type = NodalVariableValue
    nodeid = 0
    variable = disp_x
  [../]
  # [./Iso1_Bot_ReacY]
  #   type = NodalVariableValue
  #   nodeid = 5161
  #   variable = reaction_y
  # [../]
  # [./Iso1_Bot_Dispy]
  #   type = NodalVariableValue
  #   nodeid = 5161
  #   variable = disp_y
  # [../]
  [./Iso1_Top_ReacX]
    type = NodalVariableValue
    nodeid = 1
    variable = reaction_x
  [../]
  [./Iso1_Top_DispX]
    type = NodalVariableValue
    nodeid = 1
    variable = disp_x
  [../]
  # [./Iso1_Top_ReacY]
  #   type = NodalVariableValue
  #   nodeid = 4869
  #   variable = reaction_y
  # [../]
  # [./Iso1_Top_Dispy]
  #   type = NodalVariableValue
  #   nodeid = 4869
  #   variable = disp_y
  # [../]
[]

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
  print_linear_residuals = true
  file_base = Ex_OneIsolator_X1_1
  [./out]
    execute_on = 'TIMESTEP_BEGIN'
    type = CSV
    file_base = OneIsolator_X1_1
  [../]
[]
