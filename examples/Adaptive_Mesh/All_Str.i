[Mesh]
  [file]
    type = FileMeshGenerator
    file = Only_Tank.e
  []
  # [./interface1]
  #   type = SideSetsBetweenSubdomainsGenerator
  #   input = file
  #   primary_block = '2'
  #   paired_block = '1'
  #   new_boundary = 'Interface'
  # [../]
[]

[GlobalParams]
[]

[Variables]
  [./disp_x]
    # block = '1 2'
  [../]
  [./disp_y]
    # block = '1 2'
  [../]
  [./disp_z]
    # block = '1 2'
  [../]
[]

[AuxVariables]
  [./vel_x]
    order = FIRST
    family = LAGRANGE
    # block = '1 2'
  [../]
  [./accel_x]
    order = FIRST
    family = LAGRANGE
    # block = '1 2'
  [../]
  [./vel_y]
    order = FIRST
    family = LAGRANGE
    # block = '1 2'
  [../]
  [./accel_y]
    order = FIRST
    family = LAGRANGE
    # block = '1 2'
  [../]
  [./vel_z]
    order = FIRST
    family = LAGRANGE
    # block = '1 2'
  [../]
  [./accel_z]
    order = FIRST
    family = LAGRANGE
    # block = '1 2'
  [../]
  [./stress_xx]
    order = CONSTANT
    family = MONOMIAL
    # block = '1 2'
  [../]
  [./stress_yy]
    order = CONSTANT
    family = MONOMIAL
    # block = '1 2'
  [../]
  [./stress_xy]
    order = CONSTANT
    family = MONOMIAL
    # block = '1 2'
  [../]
  [./stress_zz]
    order = CONSTANT
    family = MONOMIAL
    # block = '1 2'
  [../]
  [./stress_yz]
    order = CONSTANT
    family = MONOMIAL
    # block = '1 2'
  [../]
  [./stress_xz]
    order = CONSTANT
    family = MONOMIAL
    # block = '1 2'
  [../]
[]

[Kernels]
  [./DynamicTensorMechanics]
    displacements = 'disp_x disp_y disp_z'
    # block = '1 2'
    # alpha = -0.1
  [../]
  [./inertia_x1]
    type = InertialForce
    variable = disp_x
    # block = '1 2'
  [../]
  [./inertia_y1]
    type = InertialForce
    variable = disp_y
    # block = '1 2'
  [../]
  [./inertia_z1]
    type = InertialForce
    variable = disp_z
    # block = '1 2'
  [../]
[]

[AuxKernels]
  [./accel_x]
    type = TestNewmarkTI
    displacement = disp_x
    variable = accel_x
    first = false
    # block = '1 2'
  [../]
  [./vel_x]
    type = TestNewmarkTI
    displacement = disp_x
    variable = vel_x
    # block = '1 2'
  [../]
  [./accel_y]
    type = TestNewmarkTI
    displacement = disp_y
    variable = accel_y
    first = false
    # block = '1 2'
  [../]
  [./vel_y]
    type = TestNewmarkTI
    displacement = disp_y
    variable = vel_y
    # block = '1 2'
  [../]
  [./accel_z]
    type = TestNewmarkTI
    displacement = disp_z
    variable = accel_z
    first = false
    # block = '1 2'
  [../]
  [./vel_z]
    type = TestNewmarkTI
    displacement = disp_z
    variable = vel_z
    # block = '1 2'
  [../]
  [./stress_xx]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xx
    index_i = 0
    index_j = 0
    # block = '1 2'
  [../]
  [./stress_yy]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_yy
    index_i = 1
    index_j = 1
    # block = '1 2'
  [../]
  [./stress_xy]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xy
    index_i = 0
    index_j = 1
    # block = '1 2'
  [../]
  [./stress_zz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_zz
    index_i = 2
    index_j = 2
    # block = '1 2'
  [../]
  [./stress_yz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_yz
    index_i = 1
    index_j = 2
    # block = '1 2'
  [../]
  [./stress_xz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xz
    index_i = 0
    index_j = 2
    # block = '1 2'
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
  [./density0]
    type = GenericConstantMaterial
    # block = '1 2'
    prop_names = density
    prop_values = 7.85e-6
  [../]
  # [./elasticity_base]
  #   type = ComputeIsotropicElasticityTensor
  #   youngs_modulus = 2e1
  #   poissons_ratio = 0.27
  #   block = '1'
  # [../]
  [./elasticity_base1]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 2e2
    poissons_ratio = 0.27
    # block = '2'
  [../]
  [./strain]
    type = ComputeFiniteStrain
    # block = '1 2'
    displacements = 'disp_x disp_y disp_z'
  [../]
  [./stress]
    type =  ComputeFiniteStrainElasticStress
    # block = '1 2'
  [../]
[]

[Preconditioning]
  [./andy]
    type = SMP
    full = true
  [../]
[]

[Adaptivity]
  max_h_level = 2
  marker = combo
  # initial_marker = 'initial_x initial_y initial_z'
  initial_steps = 2
  [./Indicators]
    [./indicator_x]
      type = GradientJumpIndicator
      variable = disp_x
      # block = 2
      # scale_by_flux_faces = true
    [../]
    [./indicator_y]
      type = GradientJumpIndicator
      variable = disp_y
      # block = 2
    [../]
    [./indicator_z]
      type = GradientJumpIndicator
      variable = disp_z
      # block = 2
    [../]
  [../]
  [./Markers]
    [./marker_x]
      type = ErrorFractionMarker
      indicator = indicator_x
      refine = 0.7
      coarsen = 0.15
      # type = ErrorToleranceMarker
      # # coarsen = 4e-9
      # indicator = indicator_x
      # refine = 1e-6
    [../]
    [./marker_y]
      type = ErrorFractionMarker
      indicator = indicator_y
      refine = 0.7
      coarsen = 0.15
      # type = ErrorToleranceMarker
      # # coarsen = 4e-9
      # indicator = indicator_y
      # refine = 1e-6
    [../]
    [./marker_z]
      type = ErrorFractionMarker
      indicator = indicator_z
      refine = 0.7
      coarsen = 0.15
      # type = ErrorToleranceMarker
      # # coarsen = 4e-9
      # indicator = indicator_z
      # refine = 1e-6
    [../]
    [./combo]
      type = ComboMarker
      markers = 'marker_x marker_y marker_z'
    [../]
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
  # [./Adaptivity]
  #   interval = 2
  #   refine_fraction = 0.2
  #   coarsen_fraction = 0.3
  #   max_h_level = 4
  # [../]
[]

# [Postprocessors]
#   [./Pressure1]
#     type = PointValue
#     point = '2.45 0.0 2.38333'
#     variable = p
#   [../]
#   [./Pressure2]
#     type = PointValue
#     point = '2.45 0.0 4.38333'
#     variable = p
#   [../]
#   [./Pressure3]
#     type = PointValue
#     point = '2.45 0.0 0.716667'
#     variable = p
#   [../]
#   [./Pressure4]
#     type = PointValue
#     point = '0.0 -2.45 2.38333'
#     variable = p
#   [../]
#   [./Pressure5]
#     type = PointValue
#     point = '0.0 -2.45 4.38333'
#     variable = p
#   [../]
#   [./Pressure6]
#     type = PointValue
#     point = '0.0 -2.45 0.716667'
#     variable = p
#   [../]
#   [./Pressure7]
#     type = PointValue
#     point = '2.0146 -0.00264 0.05'
#     variable = p
#   [../]
#   [./Pressure8]
#     type = PointValue
#     point = '-2.06422 0.02308 0.05'
#     variable = p
#   [../]
#   [./Wave1]
#     type = PointValue
#     point = '2.0146 -0.00264 5.05'
#     variable = Wave1
#   [../]
#   [./Wave2]
#     type = PointValue
#     point = '-2.06422 0.02308 5.05'
#     variable = Wave1
#   [../]
#   [./Wave3]
#     type = PointValue
#     point = '0.0 2.4 5.05'
#     variable = Wave1
#   [../]
#   [./Wave4]
#     type = PointValue
#     point = '0.0 -2.4 5.05'
#     variable = Wave1
#   [../]
# []

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
  print_linear_residuals = true
  file_base = Ex_Dummy1
  [./out]
    execute_on = 'TIMESTEP_BEGIN'
    type = CSV
    file_base = Dummy1
  [../]
[]
