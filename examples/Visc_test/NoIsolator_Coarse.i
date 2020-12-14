[Mesh]
  [file]
    type = FileMeshGenerator
    file = Vessel_NoIsolator_Coarse.e
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
    block = '1'
  [../]
  [./disp_y]
    block = '1'
  [../]
  [./disp_z]
    block = '1'
  [../]
[]

[AuxVariables]
  [./Wave1]
    block = 2
  [../]
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
  [./stress_xx]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
  [../]
  [./stress_yy]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
  [../]
  [./stress_xy]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
  [../]
  [./stress_zz]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
  [../]
  [./stress_yz]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
  [../]
  [./stress_xz]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
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
    # alpha = -0.1
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
  [./stress_xx]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xx
    index_i = 0
    index_j = 0
    block = '1'
  [../]
  [./stress_yy]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_yy
    index_i = 1
    index_j = 1
    block = '1'
  [../]
  [./stress_xy]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xy
    index_i = 0
    index_j = 1
    block = '1'
  [../]
  [./stress_zz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_zz
    index_i = 2
    index_j = 2
    block = '1'
  [../]
  [./stress_yz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_yz
    index_i = 1
    index_j = 2
    block = '1'
  [../]
  [./stress_xz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xz
    index_i = 0
    index_j = 2
    block = '1'
  [../]
[]

[InterfaceKernels]
  [./interface1]
    type =  FluidStructureInterface_Damping
    variable = p
    neighbor_var = disp_x
    boundary = 'Interface'
    D = 1e-6
    component = 0
    viscosity = 1e-12
  [../]
  [./interface2]
    type =  FluidStructureInterface_Damping
    variable = p
    neighbor_var = disp_y
    boundary = 'Interface'
    D = 1e-6
    component = 1
    viscosity = 1e-12
  [../]
  [./interface3]
    type =  FluidStructureInterface_Damping
    variable = p
    neighbor_var = disp_z
    boundary = 'Interface'
    D = 1e-6
    component = 2
    viscosity = 1e-12
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
    # alpha = '0.1'
  []
[]

[Functions]
  [./accel_bottom]
    type = PiecewiseLinear
    data_file = ImperialValley.csv
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
    block = '1'
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
  end_time = 20.0
  dt = 0.005
  dtmin = 0.00001
  nl_abs_tol = 1e-12
  nl_rel_tol = 1e-12
  l_tol = 1e-12
  l_abs_tol = 1e-12
  l_max_its = 7
  timestep_tolerance = 1e-8
  automatic_scaling = true
  [TimeIntegrator]
    type = NewmarkBeta
    beta = 0.25 # 0.3025
    gamma = 0.5 # 0.6
  []
[]

[Postprocessors]
  [./Pressure1]
    type = PointValue
    point = '2.45 0.0 2.38333'
    variable = p
  [../]
  [./Pressure2]
    type = PointValue
    point = '2.45 0.0 4.38333'
    variable = p
  [../]
  [./Pressure3]
    type = PointValue
    point = '2.45 0.0 0.716667'
    variable = p
  [../]
  [./Pressure4]
    type = PointValue
    point = '0.0 -2.45 2.38333'
    variable = p
  [../]
  [./Pressure5]
    type = PointValue
    point = '0.0 -2.45 4.38333'
    variable = p
  [../]
  [./Pressure6]
    type = PointValue
    point = '0.0 -2.45 0.716667'
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
[]

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
  print_linear_residuals = true
  file_base = Ex_Vessel_NoIsolator_ChiChi_Coarse
  [./out]
    execute_on = 'TIMESTEP_BEGIN'
    type = CSV
    file_base = Vessel_NoIsolator_ChiChi_Coarse
  [../]
[]
