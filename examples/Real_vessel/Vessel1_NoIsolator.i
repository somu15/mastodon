[Mesh]
  [file]
    type = FileMeshGenerator
    file = Vessel1_NoIsolator.e
  []
  [./interface1]
    type = SideSetsBetweenSubdomainsGenerator
    input = file
    primary_block = '1'
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
    block = '1 3'
  [../]
  [./disp_y]
    block = '1 3'
  [../]
  [./disp_z]
    block = '1 3'
  [../]
[]

[AuxVariables]
  [./Wave1]
    block = 2
  [../]
  [./vel_x]
    order = FIRST
    family = LAGRANGE
    block = '1 3'
  [../]
  [./accel_x]
    order = FIRST
    family = LAGRANGE
    block = '1 3'
  [../]
  [./vel_y]
    order = FIRST
    family = LAGRANGE
    block = '1 3'
  [../]
  [./accel_y]
    order = FIRST
    family = LAGRANGE
    block = '1 3'
  [../]
  [./vel_z]
    order = FIRST
    family = LAGRANGE
    block = '1 3'
  [../]
  [./accel_z]
    order = FIRST
    family = LAGRANGE
    block = '1 3'
  [../]
  [./stress_xx]
    order = CONSTANT
    family = MONOMIAL
    block = '1 3'
  [../]
  [./stress_yy]
    order = CONSTANT
    family = MONOMIAL
    block = '1 3'
  [../]
  [./stress_xy]
    order = CONSTANT
    family = MONOMIAL
    block = '1 3'
  [../]
  [./stress_zz]
    order = CONSTANT
    family = MONOMIAL
    block = '1 3'
  [../]
  [./stress_yz]
    order = CONSTANT
    family = MONOMIAL
    block = '1 3'
  [../]
  [./stress_xz]
    order = CONSTANT
    family = MONOMIAL
    block = '1 3'
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
    block = '1 3'
  [../]
  [./inertia_x1]
    type = InertialForce
    variable = disp_x
    block = '1 3'
  [../]
  [./inertia_y1]
    type = InertialForce
    variable = disp_y
    block = '1 3'
  [../]
  [./inertia_z1]
    type = InertialForce
    variable = disp_z
    block = '1 3'
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
    block = '1 3'
  [../]
  [./vel_x]
    type = TestNewmarkTI
    displacement = disp_x
    variable = vel_x
    block = '1 3'
  [../]
  [./accel_y]
    type = TestNewmarkTI
    displacement = disp_y
    variable = accel_y
    first = false
    block = '1 3'
  [../]
  [./vel_y]
    type = TestNewmarkTI
    displacement = disp_y
    variable = vel_y
    block = '1 3'
  [../]
  [./accel_z]
    type = TestNewmarkTI
    displacement = disp_z
    variable = accel_z
    first = false
    block = '1 3'
  [../]
  [./vel_z]
    type = TestNewmarkTI
    displacement = disp_z
    variable = vel_z
    block = '1 3'
  [../]
  [./stress_xx]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xx
    index_i = 0
    index_j = 0
    block = '1 3'
  [../]
  [./stress_yy]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_yy
    index_i = 1
    index_j = 1
    block = '1 3'
  [../]
  [./stress_xy]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xy
    index_i = 0
    index_j = 1
    block = '1 3'
  [../]
  [./stress_zz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_zz
    index_i = 2
    index_j = 2
    block = '1 3'
  [../]
  [./stress_yz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_yz
    index_i = 1
    index_j = 2
    block = '1 3'
  [../]
  [./stress_xz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xz
    index_i = 0
    index_j = 2
    block = '1 3'
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
  [./bottom_accel1]
    type = PresetAcceleration
    variable = disp_x
    velocity = vel_x
    acceleration = accel_x
    beta = 0.25
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
    block = '1 3'
    prop_names = density
    prop_values = 7.85e-6
  [../]
  [./elasticity_base]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 2e2
    poissons_ratio = 0.27
    block = '1 3'
  [../]
  [./strain]
    type = ComputeFiniteStrain
    block = '1 3'
    displacements = 'disp_x disp_y disp_z'
  [../]
  [./stress]
    type =  ComputeFiniteStrainElasticStress
    block = '1 3'
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
  nl_abs_tol = 1e-13
  nl_rel_tol = 1e-13
  l_tol = 1e-13
  l_max_its = 5
  timestep_tolerance = 1e-8
  automatic_scaling = true
  [TimeIntegrator]
    type = NewmarkBeta
  []
[]

[Postprocessors]
  [./PBottom]
    # type = NodalVariableValue
    # variable = p
    # nodeid = 6285
    type = PointValue
    point = '1.19836 -2.17981 2.13333'
    variable = p
  [../]
  [./Wave]
    # type = NodalVariableValue
    # variable = Wave1
    # nodeid = 13499
    type = PointValue
    point = '-1.08635 1.49524 4.0'
    variable = Wave1
  [../]
[]

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
  print_linear_residuals = true
  file_base = Ex_Vessel1_NoIsolator2_Ormsby
  [./out]
    execute_on = 'TIMESTEP_BEGIN'
    type = CSV
    file_base = Vessel1_NoIsolator2_Ormsby
  [../]
[]
