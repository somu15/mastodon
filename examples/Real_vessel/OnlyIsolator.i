[Mesh]
  [file]
    type = FileMeshGenerator
    file = OnlyIsolator.e
  []
[]

# [Controls]
#   [./C1]
#     type = TimePeriod
#     disable_objects = '*::x_inertial1 *::y_inertial1 *::z_inertial1 *::vel_x *::vel_y *::vel_z *::accel_x *::accel_y *::accel_z'
#     start_time = '0'
#     end_time = '0.10'
#   [../]
# []

[GlobalParams]
[]

[Variables]
  [./disp_x]
    order = FIRST
    family = LAGRANGE
  [../]
  [./disp_y]
    order = FIRST
    family = LAGRANGE
  [../]
  [./disp_z]
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_x]
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_y]
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_z]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[AuxVariables]
  [./vel_x]
    order = FIRST
    family = LAGRANGE
  [../]
  [./accel_x]
    order = FIRST
    family = LAGRANGE
  [../]
  [./vel_y]
    order = FIRST
    family = LAGRANGE
  [../]
  [./accel_y]
    order = FIRST
    family = LAGRANGE
  [../]
  [./vel_z]
    order = FIRST
    family = LAGRANGE
  [../]
  [./accel_z]
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_vel_x]
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_vel_y]
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_vel_z]
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_accel_x]
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_accel_y]
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_accel_z]
    order = FIRST
    family = LAGRANGE
  [../]
  [./reaction_x]
  [../]
  [./reaction_y]
  [../]
  [./reaction_z]
  [../]
  [./reaction_xx]
  [../]
  [./reaction_yy]
  [../]
  [./reaction_zz]
  [../]
[]

[Kernels]
  [./lr_disp_x]
    type = StressDivergenceIsolator
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    component = 0
    variable = disp_x
    save_in = reaction_x
  [../]
  [./lr_disp_y]
    type = StressDivergenceIsolator
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    component = 1
    variable = disp_y
    save_in = reaction_y
  [../]
  [./lr_disp_z]
    type = StressDivergenceIsolator
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    component = 2
    variable = disp_z
    save_in = reaction_z
  [../]
  [./lr_rot_x]
    type = StressDivergenceIsolator
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    component = 3
    variable = rot_x
    save_in = reaction_xx
  [../]
  [./lr_rot_y]
    type = StressDivergenceIsolator
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    component = 4
    variable = rot_y
    save_in = reaction_yy
  [../]
  [./lr_rot_z]
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
    variable = disp_x
    velocity = vel_x
    acceleration = accel_x
    boundary = IsoTop
    mass = 75000 #0.125
    beta = 0.25
    gamma = 0.5
    alpha =0
    eta =0
  [../]
  [./y_inertial1]
    type = NodalTranslationalInertia
    variable = disp_y
    velocity = vel_y
    acceleration = accel_y
    boundary = IsoTop
    mass = 75000 #0.125
    beta = 0.25
    gamma = 0.5
    alpha =0
    eta =0
  [../]
  [./z_inertial1]
    type = NodalTranslationalInertia
    variable = disp_z
    velocity = vel_z
    acceleration = accel_z
    boundary = IsoTop
    mass = 75000 #0.125
    beta = 0.25
    gamma = 0.5
    alpha =0
    eta =0
  [../]
  [./force_x]
    type = UserForcingFunctionNodalKernel
    variable = disp_z
    boundary = IsoTop
    function = force_x
  [../]
[]

[AuxKernels]
  [./accel_x]
    type = TestNewmarkTI
    displacement = disp_x
    variable = accel_x
    first = false
  [../]
  [./vel_x]
    type = TestNewmarkTI
    displacement = disp_x
    variable = vel_x
  [../]
  [./accel_y]
    type = TestNewmarkTI
    displacement = disp_y
    variable = accel_y
    first = false
  [../]
  [./vel_y]
    type = TestNewmarkTI
    displacement = disp_y
    variable = vel_y
  [../]
  [./accel_z]
    type = TestNewmarkTI
    displacement = disp_z
    variable = accel_z
    first = false
  [../]
  [./vel_z]
    type = TestNewmarkTI
    displacement = disp_z
    variable = vel_z
  [../]
  [./rot_accel_x]
    type = TestNewmarkTI
    displacement = rot_x
    variable = rot_accel_x
    first = false
  [../]
  [./rot_vel_x]
    type = TestNewmarkTI
    displacement = rot_x
    variable = rot_vel_x
  [../]
  [./rot_accel_y]
    type = TestNewmarkTI
    displacement = rot_y
    variable = rot_accel_y
    first = false
  [../]
  [./rot_vel_y]
    type = TestNewmarkTI
    displacement = rot_y
    variable = rot_vel_y
  [../]
  [./rot_accel_z]
    type = TestNewmarkTI
    displacement = rot_z
    variable = rot_accel_z
    first = false
  [../]
  [./rot_vel_z]
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
  [./bottom_accel1]
    type = PresetAcceleration
    variable = disp_x
    velocity = vel_x
    acceleration = accel_x
    beta = 0.25
    function = accel_bottom
    boundary = 'IsoBottom'
  [../]
  # [./disp_x2]
  #   type = DirichletBC
  #   variable = disp_y
  #   boundary = 'IsoBottom'
  #   value = 0.0
  # [../]
  # [./disp_x3]
  #   type = DirichletBC
  #   variable = disp_z
  #   boundary = 'IsoBottom'
  #   value = 0.0
  # [../]
[]

[Functions]
  [./accel_bottom]
    type = PiecewiseLinear
    data_file = ElCentro.csv
    scale_factor = 1.0
    format = 'columns'
  [../]
  [./force_x]
    type = PiecewiseLinear
    x='0.0 0.5 50.11'
    y='0.0 -750000.0 -750000.0'
  [../]
[]

[Materials]
  [./density0]
    type = GenericConstantMaterial
    prop_names = density
    prop_values = 7850 # 7.85e-6
  [../]
  [./deformation]
    type = ComputeIsolatorDeformation
    sd_ratio = 0.5
    y_orientation = '1.0 0.0 0.0'
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    velocities = 'vel_x vel_y vel_z'
  [../]
  [./elasticity]
    # type = ComputeFPIsolatorElasticity
    # mu_ref = 0.07
    # p_ref = 0.05 # 0.02
    # diffusivity = 4.2e-6
    # conductivity = 18e-9
    # a = 100
    # r_eff = 2.236 # 3.97
    # r_contact = 0.125 # 0.1
    # uy = 0.001 # 0.0005
    # unit = 9
    # gamma = 0.5
    # beta = 0.25
    # pressure_dependent = false
    # temperature_dependent = false
    # velocity_dependent = false
    # k_x = 30.679 # 327.24 # 209.439
    # k_xx = 0.095 # 0.415 # 0.415
    # k_yy = 0.119 # 1.278 # 0.523
    # k_zz = 0.119 # 1.278 # 0.523
    # tol = 1e-14
    type = ComputeFPIsolatorElasticity
    mu_ref = 0.06
    p_ref = 50e6
    diffusivity = 4.4e-6
    conductivity = 18
    a = 100
    r_eff = 2.2352
    r_contact = 0.2
    uy = 0.001
    unit = 1
    gamma = 0.5
    beta = 0.25
    pressure_dependent = true
    temperature_dependent = true
    velocity_dependent = true
    k_x = 7.853e10
    k_xx = 622820743.6
    k_yy = 311410371.8
    k_zz = 311410371.8
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
  dt = 0.001
  dtmin = 0.00001
  nl_abs_tol = 1e-12
  nl_rel_tol = 1e-12
  l_tol = 1e-12
  l_max_its = 25
  nl_max_its = 5
  timestep_tolerance = 1e-8
  # automatic_scaling = true
  [TimeIntegrator]
    type = NewmarkBeta
  []
[]

[Postprocessors]
  [./IsoAccBot]
    type = PointValue
    point = '0.467647 -3.402387 4.66125'
    variable = accel_x
  [../]
  [./IsoAccTop]
    type = PointValue
    point = '0.467647 -3.402387 4.98125'
    variable = accel_x
  [../]
[]

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
  print_linear_residuals = true
  file_base = Ex_OnlyIsolator
  [./out]
    execute_on = 'TIMESTEP_BEGIN'
    type = CSV
    file_base = OnlyIsolator
  [../]
[]
