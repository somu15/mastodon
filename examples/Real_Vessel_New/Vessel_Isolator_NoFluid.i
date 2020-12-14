[Mesh]
  [file]
    type = FileMeshGenerator
    file = Vessel_Isolator1.e
  []
[]

[GlobalParams]
[]

[Variables]
  [./disp_x]
    block = '1 2 3 4 5'
  [../]
  [./disp_y]
    block = '1 2 3 4 5'
  [../]
  [./disp_z]
    block = '1 2 3 4 5'
  [../]
  [./rot_x]
    block = '4 5'
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_y]
    block = '4 5'
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_z]
    block = '4 5'
    order = FIRST
    family = LAGRANGE
  [../]
[]

[AuxVariables]
  [./vel_x]
    order = FIRST
    family = LAGRANGE
    block = '1 2 3 4 5'
  [../]
  [./accel_x]
    order = FIRST
    family = LAGRANGE
    block = '1 2 3 4 5'
  [../]
  [./vel_y]
    order = FIRST
    family = LAGRANGE
    block = '1 2 3 4 5'
  [../]
  [./accel_y]
    order = FIRST
    family = LAGRANGE
    block = '1 2 3 4 5'
  [../]
  [./vel_z]
    order = FIRST
    family = LAGRANGE
    block = '1 2 3 4 5'
  [../]
  [./accel_z]
    order = FIRST
    family = LAGRANGE
    block = '1 2 3 4 5'
  [../]
  [./rot_vel_x]
    block = '4 5'
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_vel_y]
    block = '4 5'
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_vel_z]
    block = '4 5'
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_accel_x]
    block = '4 5'
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_accel_y]
    block = '4 5'
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_accel_z]
    block = '4 5'
    order = FIRST
    family = LAGRANGE
  [../]
  [./reaction_x]
    block = '4 5'
  [../]
  [./reaction_y]
    block = 4
  [../]
  [./reaction_z]
    block = 4
  [../]
  [./reaction_xx]
    block = 4
  [../]
  [./reaction_yy]
    block = 4
  [../]
  [./reaction_zz]
    block = 4
  [../]
[]

[Modules/TensorMechanics/LineElementMaster]
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'

    # dynamic simulation using consistent mass/inertia matrix
    dynamic_nodal_translational_inertia = true

    velocities = 'vel_x vel_y vel_z'
    accelerations = 'accel_x accel_y accel_z'
    rotational_velocities = 'rot_vel_x rot_vel_y rot_vel_z'
    rotational_accelerations = 'rot_accel_x rot_accel_y rot_accel_z'

    beta = 0.25 # Newmark time integration parameter
    gamma = 0.5 # Newmark time integration parameter

    [./block_5]
      block = 5
      area = 130.06
      Iy = 24166.729
      Iz = 24166.729
      y_orientation = '0.0 0.0 1.0'

      nodal_mass = 1e-10
      boundary = IsoTop
    [../]
[]

[Kernels]
  [./DynamicTensorMechanics]
    displacements = 'disp_x disp_y disp_z'
    block = '1 2 3'
  [../]
  [./inertia_x1]
    type = InertialForce
    variable = disp_x
    block = '1 2 3'
  [../]
  [./inertia_y1]
    type = InertialForce
    variable = disp_y
    block = '1 2 3'
  [../]
  [./inertia_z1]
    type = InertialForce
    variable = disp_z
    block = '1 2 3'
  [../]
  [./lr_disp_x]
    block = 4
    type = StressDivergenceIsolator
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    component = 0
    variable = disp_x
    save_in = reaction_x
  [../]
  [./lr_disp_y]
    block = 4
    type = StressDivergenceIsolator
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    component = 1
    variable = disp_y
    save_in = reaction_y
  [../]
  [./lr_disp_z]
    block = 4
    type = StressDivergenceIsolator
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    component = 2
    variable = disp_z
    save_in = reaction_z
  [../]
  [./lr_rot_x]
    block = 4
    type = StressDivergenceIsolator
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    component = 3
    variable = rot_x
    save_in = reaction_xx
  [../]
  [./lr_rot_y]
    block = 4
    type = StressDivergenceIsolator
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    component = 4
    variable = rot_y
    save_in = reaction_yy
  [../]
  [./lr_rot_z]
    block = 4
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
    block = 4
    variable = disp_x
    velocity = vel_x
    acceleration = accel_x
    boundary = IsoTop
    beta = 0.25
    gamma = 0.5
    mass = 6.40745e-4 # 640745
    alpha =0
    eta =0
  [../]
  [./y_inertial1]
    type = NodalTranslationalInertia
    block = 4
    variable = disp_y
    velocity = vel_y
    acceleration = accel_y
    boundary = IsoTop
    beta = 0.25
    gamma = 0.5
    mass = 6.40745e-4 # 640745
    alpha =0
    eta =0
  [../]
  [./z_inertial1]
    type = NodalTranslationalInertia
    block = 4
    variable = disp_z
    velocity = vel_z
    acceleration = accel_z
    boundary = IsoTop
    beta = 0.25
    gamma = 0.5
    mass = 6.40745e-4 # 640745
    alpha =0
    eta =0
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
    block = '1 2 3 4'
  [../]
  [./vel_x]
    type = TestNewmarkTI
    displacement = disp_x
    variable = vel_x
    block = '1 2 3 4'
  [../]
  [./accel_y]
    type = TestNewmarkTI
    displacement = disp_y
    variable = accel_y
    first = false
    block = '1 2 3 4'
  [../]
  [./vel_y]
    type = TestNewmarkTI
    displacement = disp_y
    variable = vel_y
    block = '1 2 3 4'
  [../]
  [./accel_z]
    type = TestNewmarkTI
    displacement = disp_z
    variable = accel_z
    first = false
    block = '1 2 3 4'
  [../]
  [./vel_z]
    type = TestNewmarkTI
    displacement = disp_z
    variable = vel_z
    block = '1 2 3 4'
  [../]
  [./rot_accel_x]
    block = 4
    type = TestNewmarkTI
    displacement = rot_x
    variable = rot_accel_x
    first = false
  [../]
  [./rot_vel_x]
    block = 4
    type = TestNewmarkTI
    displacement = rot_x
    variable = rot_vel_x
  [../]
  [./rot_accel_y]
    block = 4
    type = TestNewmarkTI
    displacement = rot_y
    variable = rot_accel_y
    first = false
  [../]
  [./rot_vel_y]
    block = 4
    type = TestNewmarkTI
    displacement = rot_y
    variable = rot_vel_y
  [../]
  [./rot_accel_z]
    block = 4
    type = TestNewmarkTI
    displacement = rot_z
    variable = rot_accel_z
    first = false
  [../]
  [./rot_vel_z]
    block = 4
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
    data_file = Ormsby_USE1.csv
    scale_factor = 1.0
    format = 'columns'
  [../]
  [./force_z]
    type = PiecewiseLinear
    x='0.0 0.05 50.11'
    # y='0.0 -6285710 -6285710'
    y='0.0 -6.285471e-3 -6.285471e-3'
  [../]
[]

[Materials]
  [./density0]
    type = GenericConstantMaterial
    block = '1 2 3 4'
    prop_names = density
    prop_values = 7.85e-10
  [../]
  [./elasticity_base]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 2e2
    poissons_ratio = 0.27
    block = '1 2 3'
  [../]
  [./strain]
    type = ComputeFiniteStrain
    block = '1 2 3'
    displacements = 'disp_x disp_y disp_z'
  [../]
  [./stress]
    type =  ComputeFiniteStrainElasticStress
    block = '1 2 3'
  [../]
  [./deformation]
    type = ComputeIsolatorDeformation
    sd_ratio = 0.5
    y_orientation = '0.0 1.0 0.0'
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    velocities = 'vel_x vel_y vel_z'
    block = 4
  [../]
  [./elasticity]
    type = ComputeFPIsolatorElasticity
    mu_ref = 0.06
    p_ref = 0.05 # 50e6
    block = 4
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
  [./elasticity_beam_rigid]
    type = ComputeElasticityBeam
    youngs_modulus = 2e3
    poissons_ratio = 0.3
    shear_coefficient = 0.85
    block = '5'
  [../]
  [./stress_beam]
    type = ComputeBeamResultants
    block = '5'
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
  dt = 0.005
  dtmin = 0.00001
  nl_abs_tol = 1e-15
  nl_rel_tol = 1e-15
  l_tol = 1e-15
  l_max_its = 7
  timestep_tolerance = 1e-8
  automatic_scaling = true
  [TimeIntegrator]
    type = NewmarkBeta
  []
[]

[Postprocessors]
  [./IBottom]
    type = NodalVariableValue
    nodeid = 20191
    variable = accel_x
    # type = PointValue
    # point = '0.467647 -3.40239 4.66125'
    # variable = accel_x
  [../]
  [./ITop]
    type = NodalVariableValue
    nodeid = 19735
    variable = accel_x
    # type = PointValue
    # point = '0.467647 -3.40239 4.98125'
    # variable = accel_x
  [../]
  [./AccelTop]
    # type = NodalVariableValue
    # nodeid = 2365
    # variable = p
    type = PointValue
    point = '0.0 -0.130921 5.13125'
    variable = accel_x
  [../]
  [./AccelSide]
    # type = NodalVariableValue
    # nodeid = 2365
    # variable = p
    type = PointValue
    point = '-2.48584 -0.0908485 2.0'
    variable = accel_x
  [../]
  [./AccelFluidTop]
    # type = NodalVariableValue
    # nodeid = 2954
    # variable = Wave1
    type = PointValue
    point = '1.74688 0.0 4.0'
    variable = accel_x
  [../]
[]

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
  print_linear_residuals = true
  file_base = Ex_Vessel_Isolator_NoFluid_Ormsby
  [./out]
    execute_on = 'TIMESTEP_BEGIN'
    type = CSV
    file_base = Vessel_Isolator_NoFluid_Ormsby
  [../]
[]
