[Mesh]
  [file]
    type = FileMeshGenerator
    file = Tank_New.e
  []
  [./interface1]
    type = SideSetsBetweenSubdomainsGenerator
    input = file
    primary_block = 'Tank'
    paired_block = 'Fluid'
    new_boundary = 'Interface'
  [../]
[]

[GlobalParams]
[]

[Variables]
  [./p]
   block = 'Fluid'
  [../]
  [./disp_x]
    block = 'Tank'
  [../]
  [./disp_y]
    block = 'Tank'
  [../]
  [./disp_z]
    block = 'Tank'
  [../]
[]

[AuxVariables]
  [./Wave1]
    block = 'Fluid'
  [../]
  [./vel_x]
    order = FIRST
    family = LAGRANGE
    block = 'Tank'
  [../]
  [./accel_x]
    order = FIRST
    family = LAGRANGE
    block = 'Tank'
  [../]
  [./vel_y]
    order = FIRST
    family = LAGRANGE
    block = 'Tank'
  [../]
  [./accel_y]
    order = FIRST
    family = LAGRANGE
    block = 'Tank'
  [../]
  [./vel_z]
    order = FIRST
    family = LAGRANGE
    block = 'Tank'
  [../]
  [./accel_z]
    order = FIRST
    family = LAGRANGE
    block = 'Tank'
  [../]
[]

[Kernels]
  [./diffusion]
    type = Diffusion
    variable = 'p'
    block = 'Fluid'
  [../]
  [./inertia]
    type = AcousticInertia
    variable = p
    block = 'Fluid'
  [../]
  [./DynamicTensorMechanics]
    displacements = 'disp_x disp_y disp_z'
    block = 'Tank'
    # alpha = -0.3
  [../]
  [./inertia_x1]
    type = InertialForce
    variable = disp_x
    block = 'Tank'
  [../]
  [./inertia_y1]
    type = InertialForce
    variable = disp_y
    block = 'Tank'
  [../]
  [./inertia_z1]
    type = InertialForce
    variable = disp_z
    block = 'Tank'
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
    block = 'Fluid'
  [../]
  [./accel_x]
    type = TestNewmarkTI
    displacement = disp_x
    variable = accel_x
    first = false
    block = 'Tank'
  [../]
  [./vel_x]
    type = TestNewmarkTI
    displacement = disp_x
    variable = vel_x
    block = 'Tank'
  [../]
  [./accel_y]
    type = TestNewmarkTI
    displacement = disp_y
    variable = accel_y
    first = false
    block = 'Tank'
  [../]
  [./vel_y]
    type = TestNewmarkTI
    displacement = disp_y
    variable = vel_y
    block = 'Tank'
  [../]
  [./accel_z]
    type = TestNewmarkTI
    displacement = disp_z
    variable = accel_z
    first = false
    block = 'Tank'
  [../]
  [./vel_z]
    type = TestNewmarkTI
    displacement = disp_z
    variable = vel_z
    block = 'Tank'
  [../]
[]

[InterfaceKernels]
  [./interface1]
    type = FSI_test
    variable = disp_x
    neighbor_var = p
    boundary = 'Interface'
    D = 1e-6
    component = 0
  [../]
  [./interface2]
    type = FSI_test
    variable = disp_y
    neighbor_var = p
    boundary = 'Interface'
    D = 1e-6
    component = 1
  [../]
  [./interface3]
    type = FSI_test
    variable = disp_z
    neighbor_var = p
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
    beta = 0.25
    function = 'ormsby'
    boundary = 'Top'
    # type = FunctionDirichletBC
    # variable = disp_x
    # boundary = 'IsoBottom'
    # function = accel_bottom
  [../]
  [./disp_x2]
    type = DirichletBC
    variable = disp_y
    boundary = 'Top'
    value = 0.0
  [../]
  [./disp_x3]
    type = DirichletBC
    variable = disp_z
    boundary = 'Top'
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
  [ormsby]
    type = OrmsbyWavelet
    f1 = 0.0
    f2 = 5.0
    f3 = 45.0
    f4 = 50.0
    ts = 1.0
    scale_factor = 4.905
  []
  # [accel_bottom]
  #   type = PiecewiseLinear
  #   data_file = Sine.csv
  #   format = 'columns'
  #   scale_factor = 9.81
  # []
[]

[Materials]
  [./density]
    type = GenericConstantMaterial
    prop_names = inv_co_sq
    prop_values = 4.65e-7
    block = 'Fluid'
  [../]
  [./density0]
    type = GenericConstantMaterial
    block = 'Tank'
    prop_names = density
    prop_values = 7.85e-6
  [../]
  [./elasticity_base]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 2e5
    poissons_ratio = 0.27
    block = 'Tank'
  [../]
  [./strain]
    type = ComputeSmallStrain # ComputeFiniteStrain
    block = 'Tank'
    displacements = 'disp_x disp_y disp_z'
  [../]
  [./stress]
    type = ComputeLinearElasticStress # ComputeFiniteStrainElasticStress
    block = 'Tank'
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
  petsc_options = '-ksp_snes_ew'
  petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
  petsc_options_value = 'lu       superlu_dist'
  solve_type = 'NEWTON'
  nl_rel_tol = 1e-12 # 1e-10
  nl_abs_tol = 1e-12 # 1e-8
  # l_tol = 1e-2
  # start_time = 2.0
  dt = 0.0025 # 0.0025
  end_time = 2.0 # 0.4
  timestep_tolerance = 1e-6
  automatic_scaling = true
  [TimeIntegrator]
    type = NewmarkBeta
    # beta = 0.3025
    # gamma = 0.6
    # beta = 0.4225
    # gamma = 0.8
  []
[]

[Postprocessors]
  [Wave1N]
    type = PointValue
    point = '-0.79 0.0 1.805'
    variable = Wave1
  []
  [Wave2N]
    type = PointValue
    point = '-0.7 0.0 1.805'
    variable = Wave1
  []
  [Wave3N]
    type = PointValue
    point = '-0.6 0.0 1.805'
    variable = Wave1
  []
  [Wave4N]
    type = PointValue
    point = '-0.5 0.0 1.805'
    variable = Wave1
  []
  [Wave5N]
    type = PointValue
    point = '-0.4 0.0 1.805'
    variable = Wave1
  []
  [Wave6N]
    type = PointValue
    point = '-0.3 0.0 1.805'
    variable = Wave1
  []
  [Wave7N]
    type = PointValue
    point = '-0.2 0.0 1.805'
    variable = Wave1
  []
  [Wave8N]
    type = PointValue
    point = '-0.1 0.0 1.805'
    variable = Wave1
  []

  [Wave0]
    type = PointValue
    point = '0.0 0.0 1.805'
    variable = Wave1
  []

  [Wave1P]
    type = PointValue
    point = '0.1 0.0 1.805'
    variable = Wave1
  []
  [Wave2P]
    type = PointValue
    point = '0.2 0.0 1.805'
    variable = Wave1
  []
  [Wave3P]
    type = PointValue
    point = '0.3 0.0 1.805'
    variable = Wave1
  []
  [Wave4P]
    type = PointValue
    point = '0.4 0.0 1.805'
    variable = Wave1
  []
  [Wave5P]
    type = PointValue
    point = '0.5 0.0 1.805'
    variable = Wave1
  []
  [Wave6P]
    type = PointValue
    point = '0.6 0.0 1.805'
    variable = Wave1
  []
  [Wave7P]
    type = PointValue
    point = '0.7 0.0 1.805'
    variable = Wave1
  []
  [Wave8P]
    type = PointValue
    point = '0.79 0.0 1.805'
    variable = Wave1
  []

  [P1N]
    type = PointValue
    point = '-0.79 0.0 1.805'
    variable = p
  []
  [P2N]
    type = PointValue
    point = '-0.79 0.0 1.605'
    variable = p
  []
  [P3N]
    type = PointValue
    point = '-0.79 0.0 1.405'
    variable = p
  []
  [P4N]
    type = PointValue
    point = '-0.79 0.0 1.205'
    variable = p
  []
  [P5N]
    type = PointValue
    point = '-0.79 0.0 1.005'
    variable = p
  []
  [P6N]
    type = PointValue
    point = '-0.79 0.0 0.805'
    variable = p
  []
  [P7N]
    type = PointValue
    point = '-0.79 0.0 0.605'
    variable = p
  []
  [P8N]
    type = PointValue
    point = '-0.79 0.0 0.405'
    variable = p
  []
  [P9N]
    type = PointValue
    point = '-0.79 0.0 0.205'
    variable = p
  []
  [P10N]
    type = PointValue
    point = '-0.79 0.0 0.005'
    variable = p
  []

  [P1P]
    type = PointValue
    point = '0.79 0.0 1.805'
    variable = p
  []
  [P2P]
    type = PointValue
    point = '0.79 0.0 1.605'
    variable = p
  []
  [P3P]
    type = PointValue
    point = '0.79 0.0 1.405'
    variable = p
  []
  [P4P]
    type = PointValue
    point = '0.79 0.0 1.205'
    variable = p
  []
  [P5P]
    type = PointValue
    point = '0.79 0.0 1.005'
    variable = p
  []
  [P6P]
    type = PointValue
    point = '0.79 0.0 0.805'
    variable = p
  []
  [P7P]
    type = PointValue
    point = '0.79 0.0 0.605'
    variable = p
  []
  [P8P]
    type = PointValue
    point = '0.79 0.0 0.405'
    variable = p
  []
  [P9P]
    type = PointValue
    point = '0.79 0.0 0.205'
    variable = p
  []
  [P10P]
    type = PointValue
    point = '0.79 0.0 0.005'
    variable = p
  []

  [moment_x]
    type = SidesetMoment
    boundary = 'Fluid_Side'
    reference_point = '0.0 0.0 0.005'
    moment_direction = '1 0 0'
    pressure = p
  []
  [moment_y]
    type = SidesetMoment
    boundary = 'Fluid_Side'
    reference_point = '0.0 0.0 0.005'
    moment_direction = '0 1 0'
    pressure = p
  []
  [moment_z]
    type = SidesetMoment
    boundary = 'Fluid_Side'
    reference_point = '0.0 0.0 0.005'
    moment_direction = '0 0 1'
    pressure = p
  []
[]

[Outputs]
  exodus = true
  perf_graph = true
  csv = true
  [./out1]
    type = CSV
    execute_on = 'final'
  [../]
[]
