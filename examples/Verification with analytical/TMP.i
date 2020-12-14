[Mesh]
  [file]
    type = FileMeshGenerator
    file = Vessel_Isolator.e
  []
  [./interface1]
    type = SideSetsBetweenSubdomainsGenerator
    input = file
    primary_block = '2'
    paired_block = '1'
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
    block = '3 4'
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_y]
    block = '3 4'
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_z]
    block = '3 4'
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
    block = '3 4'
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_vel_y]
    block = '3 4'
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_vel_z]
    block = '3 4'
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_accel_x]
    block = '3 4'
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_accel_y]
    block = '3 4'
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_accel_z]
    block = '3 4'
    order = FIRST
    family = LAGRANGE
  [../]
  [./reaction_x]
    block = '3'
  [../]
  [./reaction_y]
    block = '3'
  [../]
  [./reaction_z]
    block = '3'
  [../]
  [./reaction_xx]
    block = '3'
  [../]
  [./reaction_yy]
    block = '3'
  [../]
  [./reaction_zz]
    block = '3'
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

    # beta = 0.4225
    # gamma = 0.8
    # alpha = -0.3

    beta = 0.3025
    gamma = 0.6
    alpha = -0.1

    [./block_4]
      block = 4
      area = 130.06
      Iy = 24166.729
      Iz = 24166.729
      y_orientation = '0.0 0.0 1.0'
      nodal_mass = 1e-10
      boundary = IsoTop
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
    block = '1'
    alpha = -0.1
  [../]
  [./inertia_x1]
    type = InertialForce
    variable = disp_x
    block = '1'
  [../]
  [./inertia_y1]
    type = InertialForce
    variable = disp_y
    block = '1'
  [../]
  [./inertia_z1]
    type = InertialForce
    variable = disp_z
    block = '1'
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
  [./force_x]
    type = UserForcingFunctionNodalKernel
    variable = disp_z
    boundary = IsoTop
    function = force_z
  [../]
[]

[AuxKernels]
  [./waves]
    type = WaveHeightAuxKernel
    variable = 'Wave1'
    pressure = p
    density = 1e-6
    gravity = 9.81
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
    block = 3
    type = TestNewmarkTI
    displacement = rot_x
    variable = rot_accel_x
    first = false
  [../]
  [./rot_vel_x]
    block = 3
    type = TestNewmarkTI
    displacement = rot_x
    variable = rot_vel_x
  [../]
  [./rot_accel_y]
    block = 3
    type = TestNewmarkTI
    displacement = rot_y
    variable = rot_accel_y
    first = false
  [../]
  [./rot_vel_y]
    block = 3
    type = TestNewmarkTI
    displacement = rot_y
    variable = rot_vel_y
  [../]
  [./rot_accel_z]
    block = 3
    type = TestNewmarkTI
    displacement = rot_z
    variable = rot_accel_z
    first = false
  [../]
  [./rot_vel_z]
    block = 3
    type = TestNewmarkTI
    displacement = rot_z
    variable = rot_vel_z
  [../]
[]

[InterfaceKernels]
  [./interface1]
    type =  FluidStructureInterface
    variable = p
    neighbor_var = disp_x
    # boundary = 'Interface1 Interface2'
    boundary = 'Interface'
    D = 1e-6
    component = 0
  [../]
  [./interface2]
    type =  FluidStructureInterface
    variable = p
    neighbor_var = disp_y
    # boundary = 'Interface1 Interface2'
    boundary = 'Interface'
    D = 1e-6
    component = 1
  [../]
  [./interface3]
    type =  FluidStructureInterface
    variable = p
    neighbor_var = disp_z
    # boundary = 'Interface1 Interface2'
    boundary = 'Interface'
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
    beta = 0.25 # 0.3025
    function = accel_bottom
    boundary = 'Top'
  [../]
  [./disp_x2]
    type = DirichletBC
    variable = disp_y
    boundary = 'IsoBottom Top'
    value = 0.0
  [../]
  [./disp_x3]
    type = DirichletBC
    variable = disp_z
    boundary = 'IsoBottom Top'
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
    data_file = ImperialValley_Mod.csv
    scale_factor = 1.0
    format = 'columns'
  [../]
  [./force_z]
    type = PiecewiseLinear
    x='0.0 0.3 50.11'
    # y='0.0 -4.492e-4 -4.492e-4'
    y='0.0 -4.848e-4 -4.848e-4'
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
    block = '1 3 4'
    prop_names = density
    prop_values = 7.85e-6
  [../]
  [./elasticity_base]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 2e4
    poissons_ratio = 0.27
    block = '1'
  [../]
  [./strain]
    type = ComputeFiniteStrain
    block = '1'
    displacements = 'disp_x disp_y disp_z'
  [../]
  [./stress]
    type =  ComputeFiniteStrainElasticStress
    block = '1'
  [../]
  [./elasticity_beam_rigid]
    type = ComputeElasticityBeam
    youngs_modulus = 2e4
    poissons_ratio = 0.27
    shear_coefficient = 0.85
    block = '4'
  [../]
  [./stress_beam]
    type = ComputeBeamResultants
    block = '4'
  [../]
  [./deformation]
    type = ComputeIsolatorDeformation
    sd_ratio = 0.5
    y_orientation = '1.0 0.0 0.0'
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    velocities = 'vel_x vel_y vel_z'
    block = 3
  [../]
  [./elasticity]
    type = ComputeFPIsolatorElasticity
    mu_ref = 0.06
    p_ref = 0.05 # 50e6
    block = 3
    diffusivity = 4.4e-6
    conductivity = 18
    a = 100
    r_eff = 2.2352
    r_contact = 0.2
    uy = 0.001
    unit = 9
    # beta = 0.4225 # 0.25 #
    # gamma = 0.8 # 0.5 #
    beta = 0.3025
    gamma = 0.6
    pressure_dependent = false
    temperature_dependent = false
    velocity_dependent = false
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
  l_abs_tol = 1e-15
  l_max_its = 7
  timestep_tolerance = 1e-8
  automatic_scaling = true
  [TimeIntegrator]
    type = NewmarkBeta
    # beta = 0.4225
    # gamma = 0.8
    beta = 0.3025
    gamma = 0.6
  []
[]

[Postprocessors]
  [./Pressure1]
    type = PointValue
    point = '2.44857 0.0836457 2.38333'
    variable = p
  [../]
  [./Pressure2]
    type = PointValue
    point = '2.44857 0.0836457 4.38333'
    variable = p
  [../]
  [./Pressure3]
    type = PointValue
    point = '2.44857 0.0836457 0.716667'
    variable = p
  [../]
  [./Pressure4]
    type = PointValue
    point = '-2.44857 -0.0836457 2.38333'
    variable = p
  [../]
  [./Pressure5]
    type = PointValue
    point = '-2.44857 -0.0836457 4.38333'
    variable = p
  [../]
  [./Pressure6]
    type = PointValue
    point = '-2.44857 -0.0836457 0.716667'
    variable = p
  [../]
  [./Pressure7]
    type = PointValue
    point = '2.0146 -0.00264 0.05'
    variable = p
  [../]
  [./Pressure8]
    type = PointValue
    point = '-2.06422 0.02308 0.05'
    variable = p
  [../]
  [./Wave1]
    type = PointValue
    point = '2.0146 -0.00264 5.05'
    variable = Wave1
  [../]
  [./Wave2]
    type = PointValue
    point = '-2.06422 0.02308 5.05'
    variable = Wave1
  [../]
  [./Wave3]
    type = PointValue
    point = '0.0 2.4 5.05'
    variable = Wave1
  [../]
  [./Wave4]
    type = PointValue
    point = '0.0 -2.4 5.05'
    variable = Wave1
  [../]
  [./Iso1_Bot_ReacX]
    type = PointValue
    point = '0.0 -3.1 5.68'
    variable = reaction_x
  [../]
  [./Iso1_Bot_DispX]
    type = PointValue
    point = '0.0 -3.1 5.68'
    variable = disp_x
  [../]
  [./Iso1_Top_ReacX]
    type = PointValue
    point = '0.0 -3.1 6.0'
    variable = reaction_x
  [../]
  [./Iso1_Top_DispX]
    type = PointValue
    point = '0.0 -3.1 6.0'
    variable = disp_x
  [../]
  [./Iso1_Top_AccelX]
    type = PointValue
    point = '0.0 -3.1 6.0'
    variable = accel_x
  [../]
  [./Iso1_Top_AccelY]
    type = PointValue
    point = '0.0 -3.1 6.0'
    variable = accel_y
  [../]
  [./Iso1_Top_AccelZ]
    type = PointValue
    point = '0.0 -3.1 6.0'
    variable = accel_z
  [../]
  [./Top_AccelX]
    type = PointValue
    point = '0.0 0.0 6.0'
    variable = accel_x
  [../]
  [./Iso1_Bot_AccelX]
    type = PointValue
    point = '0.0 -3.1 5.68'
    variable = accel_x
  [../]
[]

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
  print_linear_residuals = true
  file_base = Ex_TMP1
  [./out]
    execute_on = 'TIMESTEP_BEGIN'
    type = CSV
    file_base = TMP1
  [../]
[]
