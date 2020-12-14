[Mesh]
  [gen]
    type = GeneratedMeshGenerator
    dim = 2
    nx = 20
    ny = 2
    xmax = 10.0
    ymax = 1.0
  []
  [./subdomain1]
    input = gen
    type = SubdomainBoundingBoxGenerator
    bottom_left = '5.0 0 0'
    block_id = 1
    top_right = '10.0 1.0 0'
  [../]
  [./interface1]
    type = SideSetsBetweenSubdomainsGenerator
    input = subdomain1
    primary_block = '1'
    paired_block = '0'
    new_boundary = 'Interface'
  [../]
[]

[GlobalParams]
[]

[Variables]
  [./p]
    block = 0
  [../]
  [./disp_x]
    block = 1
  [../]
  [./disp_y]
    block = 1
  [../]
[]

[AuxVariables]
  [./vel_x]
    order = FIRST
    family = LAGRANGE
    block = 1
  [../]
  [./accel_x]
    order = FIRST
    family = LAGRANGE
    block = 1
  [../]
  [./vel_y]
    order = FIRST
    family = LAGRANGE
    block = 1
  [../]
  [./accel_y]
    order = FIRST
    family = LAGRANGE
    block = 1
  [../]
  [./stress_xx]
    order = CONSTANT
    family = MONOMIAL
    block = 1
  [../]
  [./stress_yy]
    order = CONSTANT
    family = MONOMIAL
    block = 1
  [../]
  [./stress_xy]
    order = CONSTANT
    family = MONOMIAL
    block = 1
  [../]
[]

[Kernels]
  [./diffusion]
    type = Diffusion
    variable = 'p'
    block = 0
  [../]
  [./inertia]
    type = AcousticInertia
    variable = p
    block = 0
  [../]
  [./DynamicTensorMechanics]
    displacements = 'disp_x disp_y'
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
[]

[AuxKernels]
  [./accel_x]
    type = TestNewmarkTI
    displacement = disp_x
    variable = accel_x
    first = false
    block = 1
  [../]
  [./vel_x]
    type = TestNewmarkTI
    displacement = disp_x
    variable = vel_x
    block = 1
  [../]
  [./accel_y]
    type = TestNewmarkTI
    displacement = disp_y
    variable = accel_y
    first = false
    block = 1
  [../]
  [./vel_y]
    type = TestNewmarkTI
    displacement = disp_y
    variable = vel_y
    block = 1
  [../]
  [./stress_xx]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xx
    index_i = 0
    index_j = 0
    block = 1
  [../]
  [./stress_yy]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_yy
    index_i = 1
    index_j = 1
    block = 1
  [../]
  [./stress_xy]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xy
    index_i = 0
    index_j = 1
    block = 1
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
[]

[BCs]
  [./bottom_accel]
    type = FunctionDirichletBC
    variable = p
    boundary = 'left'
    function = accel_bottom
    # value = 0
  [../]
  [./disp_x1]
    type = NeumannBC
    boundary = 'right'
    variable = disp_x
    value = 0.0
  [../]
  [./disp_x2]
    type = DirichletBC
    boundary = 'right'
    variable = disp_y
    value = 0.0
  [../]
  [./disp_y_TB]
    type = DirichletBC
    boundary = 'top bottom'
    variable = disp_y
    value = 0.0
  [../]
  # [./bottom_accel]
  #   type = FunctionNeumannBC
  #   variable = disp_x
  #   boundary = 'right'
  #   function = accel_bottom
  #   # value = 0
  # [../]
  # [./disp_x1]
  #   type = DirichletBC
  #   boundary = 'left'
  #   variable = p
  #   value = 0.0
  # [../]
  # [./disp_x2]
  #   type = DirichletBC
  #   boundary = 'right'
  #   variable = disp_y
  #   value = 0.0
  # [../]
  # [./disp_y_TB]
  #   type = DirichletBC
  #   boundary = 'top bottom'
  #   variable = disp_y
  #   value = 0.0
  # [../]
[]

[Functions]
  [./accel_bottom]
    type = PiecewiseLinear
    data_file = Input_1Peak_highF.csv # Input_1Peak.csv
    scale_factor = 1e-2
    format = 'columns'
  [../]
[]

[Materials]
  [./density]
    type = GenericConstantMaterial
    prop_names = inv_co_sq
    prop_values = 4.65e-7
    block = 0
  [../]
  [./density0]
    type = GenericConstantMaterial
    block = 1
    prop_names = density
    prop_values = 4e-6
  [../]
  [./elasticity_base]
    type = ComputeIsotropicElasticityTensor
    bulk_modulus = 2.25
    shear_modulus = 1e-4
    block = 1
  [../]
  [./strain]
    type = ComputeFiniteStrain
    block = 1
    displacements = 'disp_x disp_y'
  [../]
  [./stress]
    type =  ComputeFiniteStrainElasticStress
    block = 1
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
  end_time = 0.08
  dt = 0.00025
  dtmin = 0.00001
  nl_abs_tol = 1e-10 # 1e-3
  nl_rel_tol = 1e-10 # 1e-3
  l_tol = 1e-10 # 1e-3
  l_max_its = 5
  timestep_tolerance = 1e-8
  automatic_scaling = true
  [TimeIntegrator]
    type = NewmarkBeta
  []
[]

[Postprocessors]
  [./p1]
    type = PointValue
    point = '5.0 0.0 0.0'
    variable = p
  [../]
  [./stress1]
    type = PointValue
    point = '5.0 0.0 0.0'
    variable = stress_xx
  [../]
  [./stress2]
    type = PointValue
    point = '5.0 0.0 0.0'
    variable = stress_yy
  [../]
  [./stress3]
    type = PointValue
    point = '5.0 0.0 0.0'
    variable = stress_xy
  [../]
[]

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
  print_linear_residuals = true
  file_base = Ex_Test_different_solid
  [./out]
    execute_on = 'TIMESTEP_BEGIN'
    type = CSV
    file_base = Test_different_solid
  [../]
[]
