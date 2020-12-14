[Mesh]
  [file]
    type = FileMeshGenerator
    file = Model_isolator_baseplate.e
  []
  [./interface1]
    type = SideSetsBetweenSubdomainsGenerator
    input = file
    master_block = '1'
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
    block = '1 3 4'
  [../]
  [./disp_y]
    block = '1 3 4'
  [../]
  [./disp_z]
    block = '1 3 4'
  [../]
  [./rot_x]
    block = 3
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_y]
    block = 3
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_z]
    block = 3
    order = FIRST
    family = LAGRANGE
  [../]
[]

[AuxVariables]
  [./Wave1]
    block = 2
  [../]
  [./vel_x]
    order = FIRST
    family = LAGRANGE
    block = '1 3 4'
  [../]
  [./accel_x]
    order = FIRST
    family = LAGRANGE
    block = '1 3 4'
  [../]
  [./vel_y]
    order = FIRST
    family = LAGRANGE
    block = '1 3 4'
  [../]
  [./accel_y]
    order = FIRST
    family = LAGRANGE
    block = '1 3 4'
  [../]
  [./vel_z]
    order = FIRST
    family = LAGRANGE
    block = '1 3 4'
  [../]
  [./accel_z]
    order = FIRST
    family = LAGRANGE
    block = '1 3 4'
  [../]
  [./rot_vel_x]
    block = 3
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_vel_y]
    block = 3
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_vel_z]
    block = 3
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_accel_x]
    block = 3
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_accel_y]
    block = 3
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_accel_z]
    block = 3
    order = FIRST
    family = LAGRANGE
  [../]
  [./reaction_x]
    block = '1 3 4'
  [../]
  [./reaction_y]
    block = '1 3 4'
  [../]
  [./reaction_z]
    block = '1 3 4'
  [../]
  [./reaction_xx]
    block = '1 3 4'
  [../]
  [./reaction_yy]
    block = '1 3 4'
  [../]
  [./reaction_zz]
    block = '1 3 4'
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
    displacements = 'disp_x disp_y disp_z'
    block = '1 4'
  [../]
  [./inertia_x1]
    type = InertialForce
    variable = disp_x
    block = '1 4'
  [../]
  [./inertia_y1]
    type = InertialForce
    variable = disp_y
    block = '1 4'
  [../]
  [./inertia_z1]
    type = InertialForce
    variable = disp_z
    block = '1 4'
  [../]
  [./lr_disp_x]
    block = 3
    type = StressDivergenceIsolator
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    component = 0
    variable = disp_x
    save_in = reaction_x
  [../]
  [./lr_disp_y]
    block = 3
    type = StressDivergenceIsolator
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    component = 1
    variable = disp_y
    save_in = reaction_y
  [../]
  [./lr_disp_z]
    block = 3
    type = StressDivergenceIsolator
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    component = 2
    variable = disp_z
    save_in = reaction_z
  [../]
  [./lr_rot_x]
    block = 3
    type = StressDivergenceIsolator
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    component = 3
    variable = rot_x
    save_in = reaction_xx
  [../]
  [./lr_rot_y]
    block = 3
    type = StressDivergenceIsolator
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    component = 4
    variable = rot_y
    save_in = reaction_yy
  [../]
  [./lr_rot_z]
    block = 3
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
    mass = 1e-6 # 640745
    block = 3
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
    mass = 1e-6 # 640745
    block = 3
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
    mass = 1e-6 # 640745
    block = 3
    beta = 0.25
    gamma = 0.5
    alpha =0
    eta =0
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
    block = '1 3 4'
  [../]
  [./vel_x]
    type = TestNewmarkTI
    displacement = disp_x
    variable = vel_x
    block = '1 3 4'
  [../]
  [./accel_y]
    type = TestNewmarkTI
    displacement = disp_y
    variable = accel_y
    first = false
    block = '1 3 4'
  [../]
  [./vel_y]
    type = TestNewmarkTI
    displacement = disp_y
    variable = vel_y
    block = '1 3 4'
  [../]
  [./accel_z]
    type = TestNewmarkTI
    displacement = disp_z
    variable = accel_z
    first = false
    block = '1 3 4'
  [../]
  [./vel_z]
    type = TestNewmarkTI
    displacement = disp_z
    variable = vel_z
    block = '1 3 4'
  [../]
  [./rot_accel_x]
    block = '3'
    type = TestNewmarkTI
    displacement = rot_x
    variable = rot_accel_x
    first = false
  [../]
  [./rot_vel_x]
    block = '3'
    type = TestNewmarkTI
    displacement = rot_x
    variable = rot_vel_x
  [../]
  [./rot_accel_y]
    block = '3'
    type = TestNewmarkTI
    displacement = rot_y
    variable = rot_accel_y
    first = false
  [../]
  [./rot_vel_y]
    block = '3'
    type = TestNewmarkTI
    displacement = rot_y
    variable = rot_vel_y
  [../]
  [./rot_accel_z]
    block = '3'
    type = TestNewmarkTI
    displacement = rot_z
    variable = rot_accel_z
    first = false
  [../]
  [./rot_vel_z]
    block = '3'
    type = TestNewmarkTI
    displacement = rot_z
    variable = rot_vel_z
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
  [./fixrx0]
    type = DirichletBC
    variable = rot_x
    boundary = 'Bottom'
    value = 0.0
  [../]
  [./fixry0]
    type = DirichletBC
    variable = rot_y
    boundary = 'Bottom'
    value = 0.0
  [../]
  [./fixrz0]
    type = DirichletBC
    variable = rot_z
    boundary = 'Bottom'
    value = 0.0
  [../]
  [./fixrx1]
    type = DirichletBC
    variable = rot_x
    boundary = 'Top'
    value = 0.0
  [../]
  [./fixry1]
    type = DirichletBC
    variable = rot_y
    boundary = 'Top'
    value = 0.0
  [../]
  [./fixrz1]
    type = DirichletBC
    variable = rot_z
    boundary = 'Top'
    value = 0.0
  [../]
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
  [./density0]
    type = GenericConstantMaterial
    block = '1 4'
    prop_names = density
    prop_values = 7.85e-6
  [../]
  [./elasticity_base1]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 2e2
    poissons_ratio = 0.27
    block = 1
  [../]
  [./elasticity_base2]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 2e3
    poissons_ratio = 0.27
    block = 4
  [../]
  [./strain]
    type = ComputeFiniteStrain
    block = '1 4'
    displacements = 'disp_x disp_y disp_z'
  [../]
  [./stress]
    type =  ComputeFiniteStrainElasticStress
    block = '1 4'
  [../]
  [./deformation]
    type = ComputeIsolatorDeformation
    block = '3'
    sd_ratio = 0.5
    y_orientation = '1.0 0.0 0.0'
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    velocities = 'vel_x vel_y vel_z'
  [../]
  [./elasticity]
    type = ComputeLRIsolatorElasticity
    block = 3
    fy = 2.071e-4
    alpha = 0.0381 #unitless
    G_rubber = 8.9e-4
    K_rubber = 1.999
    D1 = 0.13968984
    D2 = 0.505
    ts = 0.00475488
    tr = 0.009525
    n = 16
    tc = 0.012697968
    kc = 20.04
    phi_m = 0.75
    ac = 1
    cd = 0
    gamma = 0.5
    beta = 0.25
    k_steel = 4.982e-8
    a_steel = 1.409e-5
    rho_lead = 5.304e-8
    c_lead = 129.971
    cavitation = false
    horizontal_stiffness_variation = false
    vertical_stiffness_variation = false
    strength_degradation = false
    buckling_load_variation = false
    # type = ComputeFPIsolatorElasticity
    # block = '3'
    # mu_ref = 0.06
    # p_ref = 50e6
    # diffusivity = 4.4e-6
    # conductivity = 18
    # a = 100
    # r_eff = 2.2352
    # r_contact = 0.2
    # uy = 0.001
    # unit = 1
    # gamma = 0.5
    # beta = 0.25
    # pressure_dependent = true
    # temperature_dependent = true
    # velocity_dependent = true
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
  end_time = 2.0
  dt = 0.001
  dtmin = 0.00001
  nl_abs_tol = 5e-11
  nl_rel_tol = 5e-11
  l_tol = 5e-11
  l_max_its = 25
  nl_max_its = 5
  timestep_tolerance = 1e-8
  automatic_scaling = true
  [TimeIntegrator]
    type = NewmarkBeta
  []
[]

[Postprocessors]
  [./PBottom]
    type = PointValue
    point = '0.79 0.0 0.0079'
    variable = p
  [../]
  [./Wave]
    type = PointValue
    point = '0.71 0.0 1.8079'
    variable = Wave1
  [../]
[]

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
  print_linear_residuals = true
  file_base = Ex_Isolator_Baseplate_Ormsby
  [./out]
    execute_on = 'TIMESTEP_BEGIN'
    type = CSV
    file_base = Isolator_Baseplate_Ormsby
  [../]
[]
