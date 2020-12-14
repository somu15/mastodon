[Mesh]
  [file]
    type = FileMeshGenerator
    file = foundation.e
  []
[]

# [Controls]
#   [./C1]
#     type = TimePeriod
#     disable_objects = '*::x_inertial1 *::y_inertial1 *::z_inertial1 *::vel_x *::vel_y *::vel_z *::accel_x *::accel_y *::accel_z'
#     start_time = '0'
#     end_time = '50.0'
#   [../]
# []

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
    block = 2
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_y]
    block = 2
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_z]
    block = 2
    order = FIRST
    family = LAGRANGE
  [../]
[]

[AuxVariables]
  [./vel_x]
    order = FIRST
    family = LAGRANGE
  [../]
  [./vel_y]
    order = FIRST
    family = LAGRANGE
  [../]
  [./vel_z]
    order = FIRST
    family = LAGRANGE
  [../]
  [./accel_x]
    order = FIRST
    family = LAGRANGE
  [../]
  [./accel_y]
    order = FIRST
    family = LAGRANGE
  [../]
  [./accel_z]
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_vel_x]
    block = 2
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_vel_y]
    block = 2
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_vel_z]
    block = 2
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_accel_x]
    block = 2
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_accel_y]
    block = 2
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_accel_z]
    block = 2
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
  [./DynamicTensorMechanics]
    displacements = 'disp_x disp_y disp_z'
    block = 1
  [../]
  [./inertia_x1]
    type = InertialForce
    variable = disp_x
    block = 1
  [../]
  [./inertia_y1]
    type = InertialForce
    variable = disp_y
    block = 1
  [../]
  [./inertia_z1]
    type = InertialForce
    variable = disp_z
    block = 1
  [../]
  [./lr_disp_x]
    block = 2
    type = StressDivergenceIsolator
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    component = 0
    variable = disp_x
    save_in = reaction_x
  [../]
  [./lr_disp_y]
    block = 2
    type = StressDivergenceIsolator
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    component = 1
    variable = disp_y
    save_in = reaction_y
  [../]
  [./lr_disp_z]
    block = 2
    type = StressDivergenceIsolator
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    component = 2
    variable = disp_z
    save_in = reaction_z
  [../]
  [./lr_rot_x]
    block = 2
    type = StressDivergenceIsolator
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    component = 3
    variable = rot_x
    save_in = reaction_xx
  [../]
  [./lr_rot_y]
    block = 2
    type = StressDivergenceIsolator
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    component = 4
    variable = rot_y
    save_in = reaction_yy
  [../]
  [./lr_rot_z]
    block = 2
    type = StressDivergenceIsolator
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    component = 5
    variable = rot_z
    save_in = reaction_zz
  [../]
[]

[NodalKernels]
  [./x_inertial1]
    type = NodalTranslationalInertia
    variable = disp_x
    velocity = vel_x
    acceleration = accel_x
    boundary = Top
    mass = 70 # 640745
    block = 2
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
    boundary = Top
    mass = 70 # 640745
    block = 2
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
    boundary = Top
    mass = 70 # 640745
    block = 2
    beta = 0.25
    gamma = 0.5
    alpha =0
    eta =0
  [../]
  [./force_x]
    type = UserForcingFunctionNodalKernel
    variable = disp_y
    boundary = 'Top'
    function = force_y
  [../]
[]

[AuxKernels]
  [./accel_x]
    type = TestNewmarkTI
    displacement = disp_x
    variable = accel_x
    first = false
    # block = 1
    # type = NewmarkAccelAux
    # variable = accel_x
    # displacement = disp_x
    # velocity = vel_x
    # beta = 0.25
    # execute_on = timestep_end
  [../]
  [./vel_x]
    type = TestNewmarkTI
    displacement = disp_x
    variable = vel_x
    # type = NewmarkVelAux
    # variable = vel_x
    # acceleration = accel_x
    # gamma = 0.5
    # execute_on = timestep_end
  [../]
  [./accel_y]
    type = TestNewmarkTI
    displacement = disp_y
    variable = accel_y
    first = false
    # type = NewmarkAccelAux
    # variable = accel_y
    # displacement = disp_y
    # velocity = vel_y
    # beta = 0.25
    # execute_on = timestep_end
  [../]
  [./vel_y]
    type = TestNewmarkTI
    displacement = disp_y
    variable = vel_y
    # type = NewmarkVelAux
    # variable = vel_y
    # acceleration = accel_y
    # gamma = 0.5
    # execute_on = timestep_end
  [../]
  [./accel_z]
    type = TestNewmarkTI
    displacement = disp_z
    variable = accel_z
    first = false
    # type = NewmarkAccelAux
    # variable = accel_z
    # displacement = disp_z
    # velocity = vel_z
    # beta = 0.25
    # execute_on = timestep_end
  [../]
  [./vel_z]
    type = TestNewmarkTI
    displacement = disp_z
    variable = vel_z
    # type = NewmarkVelAux
    # variable = vel_z
    # acceleration = accel_z
    # gamma = 0.5
    # execute_on = timestep_end
  [../]
  [./rot_accel_x]
    block = 2
    type = TestNewmarkTI
    displacement = rot_x
    variable = rot_accel_x
    first = false
    # type = NewmarkAccelAux
    # variable = rot_accel_x
    # displacement = rot_x
    # velocity = rot_vel_x
    # beta = 0.25
    # execute_on = timestep_end
  [../]
  [./rot_vel_x]
    block = 2
    type = TestNewmarkTI
    displacement = rot_x
    variable = rot_vel_x
    # type = NewmarkVelAux
    # variable = rot_vel_x
    # acceleration = rot_accel_x
    # gamma = 0.5
    # execute_on = timestep_end
  [../]
  [./rot_accel_y]
    block = 2
    type = TestNewmarkTI
    displacement = rot_y
    variable = rot_accel_y
    first = false
    # type = NewmarkAccelAux
    # variable = rot_accel_y
    # displacement = rot_y
    # velocity = rot_vel_y
    # beta = 0.25
    # execute_on = timestep_end
  [../]
  [./rot_vel_y]
    block = 2
    type = TestNewmarkTI
    displacement = rot_y
    variable = rot_vel_y
    # type = NewmarkVelAux
    # variable = rot_vel_y
    # acceleration = rot_accel_y
    # gamma = 0.5
    # execute_on = timestep_end
  [../]
  [./rot_accel_z]
    block = 2
    type = TestNewmarkTI
    displacement = rot_z
    variable = rot_accel_z
    first = false
    # type = NewmarkAccelAux
    # variable = rot_accel_z
    # displacement = rot_z
    # velocity = rot_vel_z
    # beta = 0.25
    # execute_on = timestep_end
  [../]
  [./rot_vel_z]
    block = 2
    type = TestNewmarkTI
    displacement = rot_z
    variable = rot_vel_z
    # type = NewmarkVelAux
    # variable = rot_vel_z
    # acceleration = rot_accel_z
    # gamma = 0.5
    # execute_on = timestep_end
  [../]
[]

[BCs]
  # [./fixrx0]
  #   type = DirichletBC
  #   variable = rot_x
  #   boundary = 'Base'
  #   value = 0.0
  # [../]
  # [./fixry0]
  #   type = DirichletBC
  #   variable = rot_y
  #   boundary = 'Base'
  #   value = 0.0
  # [../]
  # [./fixrz0]
  #   type = DirichletBC
  #   variable = rot_z
  #   boundary = 'Base'
  #   value = 0.0
  # [../]
  # [./fixrx1]
  #   type = DirichletBC
  #   variable = rot_x
  #   boundary = 'Top'
  #   value = 0.0
  # [../]
  # [./fixry1]
  #   type = DirichletBC
  #   variable = rot_y
  #   boundary = 'Top'
  #   value = 0.0
  # [../]
  # [./fixrz1]
  #   type = DirichletBC
  #   variable = rot_z
  #   boundary = 'Top'
  #   value = 0.0
  # [../]
  [./accel_x0]
    type = PresetAcceleration
    boundary = 'Base'
    function = acceleration_x
    variable = disp_x
    beta = 0.25
    acceleration = 'accel_x'
    velocity = 'vel_x'
  [../]
  [./fixy0]
    type = DirichletBC
    variable = disp_y
    boundary = 'Base'
    value = 0.0
  [../]
  [./fixz0]
    type = DirichletBC
    variable = disp_z
    boundary = 'Base'
    value = 0.0
  [../]
  # [./accel_y0]
  #   type = PresetAcceleration
  #   boundary = 'Base'
  #   function = acceleration_x
  #   variable = disp_y
  #   beta = 0.25
  #   acceleration = 'accel_y'
  #   velocity = 'vel_y'
  # [../]
  # [./accel_z0]
  #   type = PresetAcceleration
  #   boundary = 'Base'
  #   function = acceleration_x
  #   variable = disp_z
  #   beta = 0.25
  #   acceleration = 'accel_z'
  #   velocity = 'vel_z'
  # [../]
[]

[Functions]
  [./acceleration_x]
    type = PiecewiseLinear
    data_file = accel_x.csv
    scale_factor = 32.2000008
    format=columns
  [../]
  # [./acceleration_y]
  #   type = PiecewiseLinear
  #   data_file = accel_y.csv
  #   format=columns
  # [../]
  # [./acceleration_z]
  #   type = PiecewiseLinear
  #   data_file = accel_z.csv
  #   format=columns
  # [../]
  [./force_y]
    type = ConstantFunction
    value = -1.0
  [../]
[]

[Preconditioning]
  [./smp]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  type = Transient
  solve_type = PJFNK
  petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
  petsc_options_value = 'lu       superlu_dist'
  nl_rel_tol = 1e-10
  nl_abs_tol = 1e-10
  l_tol = 1e-10 # 1e-3
  l_max_its = 25
  start_time = 0
  end_time = 85.0
  dt = 0.01
  dtmin = 0.0000001
  timestep_tolerance = 1e-8
  # automatic_scaling = true
  [TimeIntegrator]
    type = NewmarkBeta
  []
[]

[Materials]
  [./density0]
    type = GenericConstantMaterial
    block = '1'
    prop_names = density
    prop_values = 150.23
  [../]
  [./elasticity_base]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 288000 # 2e10
    poissons_ratio = 0.27
    block = 1
  [../]
  [./strain]
    type = ComputeFiniteStrain
    block = 1
    displacements = 'disp_x disp_y disp_z'
  [../]
  [./stress]
    type =  ComputeFiniteStrainElasticStress
    block = 1
  [../]
  [./deformation]
    type = ComputeIsolatorDeformation
    block = '2'
    sd_ratio = 0.5
    y_orientation = '1.0 0.0 0.0'
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    velocities = 'vel_x vel_y vel_z'
  [../]
  [./elasticity]
    # type = ComputeLRIsolatorElasticity
    # block = 2
    # fy = 46.5703 #kip
    # alpha = 0.0381 #unitless
    # G_rubber = 18.59 #ksf
    # K_rubber = 41770 #ksf
    # D1 = 0.4583 #ft
    # D2 = 1.66 #ft
    # ts = 0.0156 #ft
    # tr = 0.03125 #ft
    # n = 16
    # tc = 0.04166 #ft
    # kc = 6.095 #1/ft
    # phi_m = 0.75
    # ac = 1
    # cd = 0
    # gamma = 0.5
    # beta = 0.25
    # k_steel = 0.0112 #kip/s oC
    # a_steel = 1.517e-4 #ft^2/s
    # rho_lead = 21.93 #lb s^2/ft^4
    # c_lead = 1399 #ft^2/s^2 C
    # cavitation = false
    # horizontal_stiffness_variation = false
    # vertical_stiffness_variation = false
    # strength_degradation = false
    # buckling_load_variation = false
    type = ComputeFPIsolatorElasticity
    block = '2'
    mu_ref = 0.06
    p_ref = 1044
    diffusivity = 4.54e-5
    conductivity = 10.44
    a = 100
    r_eff = 20.45
    r_contact = 1.968
    uy = 0.00984
    unit = 8
    gamma = 0.5
    beta = 0.25
    pressure_dependent = false
    temperature_dependent = false
    velocity_dependent = false
  [../]
[]

[Postprocessors]
  [./accel_x0]
    type = PointValue
    point = '0.0 -0.08 0.0'
    variable = accel_x
  [../]
  [./accel_x1]
    type = PointValue
    point = '0.0 -0.05 0.0'
    variable = accel_x
  [../]
  [./accel_x2]
    type = PointValue
    point = '0.0 0.05 0.0'
    variable = accel_x
  [../]
  [./disp_x0]
    type = PointValue
    point = '0.0 -0.08 0.0'
    variable = disp_x
  [../]
  [./disp_x1]
    type = PointValue
    point = '0.0 -0.05 0.0'
    variable = disp_x
  [../]
  [./disp_x2]
    type = PointValue
    point = '0.0 0.05 0.0'
    variable = disp_x
  [../]
  # [./vel_x0]
  #   type = NodalVariableValue
  #   nodeid = 0
  #   variable = vel_x
  # [../]
  # [./accel_x0]
  #   type = NodalVariableValue
  #   nodeid = 0
  #   variable = accel_x
  # [../]
  # [./disp_x1]
  #   type = NodalVariableValue
  #   nodeid = 1
  #   variable = disp_x
  # [../]
  # [./vel_x1]
  #   type = NodalVariableValue
  #   nodeid = 1
  #   variable = vel_x
  # [../]
  # [./accel_x1]
  #   type = NodalVariableValue
  #   nodeid = 1
  #   variable = accel_x
  # [../]
  # [./reaction_x]
  #   type = NodalSum
  #   variable = reaction_x
  #   boundary = left
  # [../]
  # [./disp_y0]
  #   type = NodalVariableValue
  #   nodeid = 0
  #   variable = disp_y
  # [../]
  # [./vel_y0]
  #   type = NodalVariableValue
  #   nodeid = 0
  #   variable = vel_y
  # [../]
  # [./accel_y0]
  #   type = NodalVariableValue
  #   nodeid = 0
  #   variable = accel_y
  # [../]
  # [./disp_y1]
  #   type = NodalVariableValue
  #   nodeid = 1
  #   variable = disp_y
  # [../]
  # [./vel_y1]
  #   type = NodalVariableValue
  #   nodeid = 1
  #   variable = vel_y
  # [../]
  # [./accel_y1]
  #   type = NodalVariableValue
  #   nodeid = 1
  #   variable = accel_y
  # [../]
  # [./reaction_y]
  #   type = NodalSum
  #   variable = reaction_y
  #   boundary = left
  # [../]
  # [./disp_z0]
  #   type = NodalVariableValue
  #   nodeid = 0
  #   variable = disp_z
  # [../]
  # [./vel_z0]
  #   type = NodalVariableValue
  #   nodeid = 0
  #   variable = vel_z
  # [../]
  # [./accel_z0]
  #   type = NodalVariableValue
  #   nodeid = 0
  #   variable = accel_z
  # [../]
  # [./disp_z1]
  #   type = NodalVariableValue
  #   nodeid = 1
  #   variable = disp_z
  # [../]
  # [./vel_z1]
  #   type = NodalVariableValue
  #   nodeid = 1
  #   variable = vel_z
  # [../]
  # [./accel_z1]
  #   type = NodalVariableValue
  #   nodeid = 1
  #   variable = accel_z
  # [../]
  # [./reaction_z]
  #   type = NodalSum
  #   variable = reaction_z
  #   boundary = left
  # [../]
[]

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
  print_linear_residuals = true
  file_base = Ex_FP_foundation_FP
  [./out]
    execute_on = 'TIMESTEP_BEGIN'
    type = CSV
    file_base = FP_foundation_FP
  [../]
[]
