[Mesh]
  [file]
    type = FileMeshGenerator
    file = Real_Vessel_lv2.e
  []
  [./interface1]
    type = SideSetsBetweenSubdomainsGenerator
    input = file
    primary_block = '1'# 99 98 97 96 95 93 92 91'
    paired_block = '2'
    new_boundary = 'Interface'
  [../]
  [subdomain_1]
    type = SubdomainBoundingBoxGenerator
    bottom_left = '-2.5 0.0 4.0'
    top_right = '-1.753652 1.753652 5.0'
    location = INSIDE
    block_id = 99
    input = interface1
  []
  [subdomain_2]
    type = SubdomainBoundingBoxGenerator
    bottom_left = '-1.767767 1.767767 4.0'
    top_right = '0.0 2.48 5.0'
    location = INSIDE
    block_id = 98
    input = subdomain_1
  []
  [subdomain_3]
    type = SubdomainBoundingBoxGenerator
    bottom_left = '0.0 2.5 4.0'
    top_right = '1.753625 1.753625 5.0'
    location = INSIDE
    block_id = 97
    input = subdomain_2
  []
  [subdomain_4]
    type = SubdomainBoundingBoxGenerator
    bottom_left = '1.767767 1.767767 4.0'
    top_right = '2.48 0.0 5.0'
    location = INSIDE
    block_id = 96
    input = subdomain_3
  []
  [subdomain_5]
    type = SubdomainBoundingBoxGenerator
    bottom_left = '2.5 0.0 4.0'
    top_right = '1.753652 -1.753652 5.0'
    location = INSIDE
    block_id = 95
    input = subdomain_4
  []
  # [subdomain_6]
  #   type = SubdomainBoundingBoxGenerator
  #   bottom_left = '1.753652 -1.753652 4.0'
  #   top_right = '0.0 -2.5 5.0'
  #   location = INSIDE
  #   block_id = 94
  #   input = subdomain_5
  # []
  [subdomain_7]
    type = SubdomainBoundingBoxGenerator
    bottom_left = '0.0 -2.48 4.0'
    top_right = '1.767767 -1.767767 5.0'
    location = INSIDE
    block_id = 93
    input = subdomain_5
  []
  [subdomain_8]
    type = SubdomainBoundingBoxGenerator
    bottom_left = '0.0 -2.5 4.0' # '1.753652 -1.753652 4.0'
    top_right = '-1.753652 -1.753652 5.0' # '-2.5 0.0 5.0'
    location = INSIDE
    block_id = 92
    input = subdomain_7
  []
  [subdomain_9]
    type = SubdomainBoundingBoxGenerator
    bottom_left = '-1.767767 -1.767767 4.0'
    top_right = '-2.48 0.0 5.0'
    location = INSIDE
    block_id = 91
    input = subdomain_8
  []
  # construct_side_list_from_node_list=true
[]

# [Adaptivity]
#   initial_marker = marker
#   initial_steps = 2
#   [./Indicators]
#     [./minimum_element_size]
#       type = ShearModulusIndicator
#       cutoff_frequency = 1000000
#       # shear_modulus = 78.74
#       # block = 1
#     [../]
#     # [./minimum_element_size_str]
#     #   type = ShearModulusIndicator
#     #   cutoff_frequency = 1000000
#     #   shear_modulus = 78.74
#     #   block = 1
#     # [../]
#     # [./minimum_element_size_fluid]
#     #   type = ShearModulusIndicator
#     #   cutoff_frequency = 25
#     #   shear_modulus = 78.74
#     #   block = 2
#     # [../]
#   [../]
#   [./Markers]
#     [./marker]
#       type = MinimumElementSizeMarker
#       indicator = minimum_element_size
#     [../]
#     # [./marker_str]
#     #   type = MinimumElementSizeMarker
#     #   indicator = minimum_element_size_str
#     # [../]
#     # [./marker_fluid]
#     #   type = MinimumElementSizeMarker
#     #   indicator = minimum_element_size_fluid
#     # [../]
#     # [./combo]
#     #   type = ComboMarker
#     #   markers = 'marker_str marker_fluid'
#     # [../]
#   []
# []

# [Adaptivity]
#   marker = combo
#   initial_steps = 5
#   # [Indicators]
#   #   [shear_wave]
#   #     type = ShearWaveIndicator
#   #     cutoff_frequency = 1000
#   #   []
#   # []
#   [Markers]
#     [marker1]
#       type = MinimumElementSizeMarker
#       element_size = 0.01
#       block = '1 99 98 97 96 95 93 92 91'
#     []
#     [marker2]
#       type = MinimumElementSizeMarker
#       element_size = 0.25
#       block = '2'
#     []
#     [combo]
#       type = ComboMarker
#       markers = 'marker1 marker2'
#       # block = '1 2 3'
#     []
#     # [marker2]
#     #   type = MinimumElementSizeMarker
#     #   indicator = shear_wave
#     #   # block = 2
#     # []
#   []
#   # [Indicators]
#   # [shear_wave]
#   #   type = ShearWaveIndicator
#   #   cutoff_frequency = 100
#   # []
#   # []
# []

[GlobalParams]
[]

[Variables]
  [./p]
   block = 2
  [../]
  [./disp_x]
    block = '1 3 99 98 97 96 95 93 92 91'
  [../]
  [./disp_y]
    block = '1 3 99 98 97 96 95 93 92 91'
  [../]
  [./disp_z]
    block = '1 3 99 98 97 96 95 93 92 91'
  [../]
[]

[AuxVariables]
  [./Wave1]
    block = 2
  [../]
  [./vel_x]
    order = FIRST
    family = LAGRANGE
    block = '1 3 99 98 97 96 95 93 92 91'
  [../]
  [./accel_x]
    order = FIRST
    family = LAGRANGE
    block = '1 3 99 98 97 96 95 93 92 91'
  [../]
  [./vel_y]
    order = FIRST
    family = LAGRANGE
    block = '1 3 99 98 97 96 95 93 92 91'
  [../]
  [./accel_y]
    order = FIRST
    family = LAGRANGE
    block = '1 3 99 98 97 96 95 93 92 91'
  [../]
  [./vel_z]
    order = FIRST
    family = LAGRANGE
    block = '1 3 99 98 97 96 95 93 92 91'
  [../]
  [./accel_z]
    order = FIRST
    family = LAGRANGE
    block = '1 3 99 98 97 96 95 93 92 91'
  [../]
  [./stress_xx]
    order = CONSTANT
    family = MONOMIAL
    block = '1 3 99 98 97 96 95 93 92 91'
  [../]
  [./stress_yy]
    order = CONSTANT
    family = MONOMIAL
    block = '1 3 99 98 97 96 95 93 92 91'
  [../]
  [./stress_xy]
    order = CONSTANT
    family = MONOMIAL
    block = '1 3 99 98 97 96 95 93 92 91'
  [../]
  [./stress_zz]
    order = CONSTANT
    family = MONOMIAL
    block = '1 3 99 98 97 96 95 93 92 91'
  [../]
  [./stress_yz]
    order = CONSTANT
    family = MONOMIAL
    block = '1 3 99 98 97 96 95 93 92 91'
  [../]
  [./stress_xz]
    order = CONSTANT
    family = MONOMIAL
    block = '1 3 99 98 97 96 95 93 92 91'
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
    block = '1 3 99 98 97 96 95 93 92 91'
    zeta = 0.00076923
  [../]
  [./inertia_x1]
    type = InertialForce
    variable = disp_x
    block = '1 3 99 98 97 96 95 93 92 91'
    eta = 0.01923
  [../]
  [./inertia_y1]
    type = InertialForce
    variable = disp_y
    block = '1 3 99 98 97 96 95 93 92 91'
    eta = 0.01923
  [../]
  [./inertia_z1]
    type = InertialForce
    variable = disp_z
    block = '1 3 99 98 97 96 95 93 92 91'
    eta = 0.01923
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
    block = '1 3 99 98 97 96 95 93 92 91'
  [../]
  [./vel_x]
    type = TestNewmarkTI
    displacement = disp_x
    variable = vel_x
    block = '1 3 99 98 97 96 95 93 92 91'
  [../]
  [./accel_y]
    type = TestNewmarkTI
    displacement = disp_y
    variable = accel_y
    first = false
    block = '1 3 99 98 97 96 95 93 92 91'
  [../]
  [./vel_y]
    type = TestNewmarkTI
    displacement = disp_y
    variable = vel_y
    block = '1 3 99 98 97 96 95 93 92 91'
  [../]
  [./accel_z]
    type = TestNewmarkTI
    displacement = disp_z
    variable = accel_z
    first = false
    block = '1 3 99 98 97 96 95 93 92 91'
  [../]
  [./vel_z]
    type = TestNewmarkTI
    displacement = disp_z
    variable = vel_z
    block = '1 3 99 98 97 96 95 93 92 91'
  [../]
  [./stress_xx]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xx
    index_i = 0
    index_j = 0
    block = '1 3 99 98 97 96 95 93 92 91'
  [../]
  [./stress_yy]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_yy
    index_i = 1
    index_j = 1
    block = '1 3 99 98 97 96 95 93 92 91'
  [../]
  [./stress_xy]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xy
    index_i = 0
    index_j = 1
    block = '1 3 99 98 97 96 95 93 92 91'
  [../]
  [./stress_zz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_zz
    index_i = 2
    index_j = 2
    block = '1 3 99 98 97 96 95 93 92 91'
  [../]
  [./stress_yz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_yz
    index_i = 1
    index_j = 2
    block = '1 3 99 98 97 96 95 93 92 91'
  [../]
  [./stress_xz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xz
    index_i = 0
    index_j = 2
    block = '1 3 99 98 97 96 95 93 92 91'
  [../]
[]

[InterfaceKernels]
  [./interface1]
    type =  FSI_test
    variable = disp_x
    neighbor_var = p
    boundary = 'Interface'
    D = 1e-6
    #D_neighbor = 1.0
    component = 0
  [../]
  [./interface2]
    type =  FSI_test
    variable = disp_y
    neighbor_var = p
    boundary = 'Interface'
    D = 1e-6
    #D_neighbor = 1.0
    component = 1
  [../]
  [./interface3]
    type =  FSI_test
    variable = disp_z
    neighbor_var = p
    boundary = 'Interface'
    D = 1e-6
    #D_neighbor = 1.0
    component = 2
  [../]
[]

[BCs]
  [./x_motion]
    type = PresetAcceleration
    # preset = true
    acceleration = accel_x
    velocity = vel_x
    variable = disp_x
    beta = 0.25
    boundary = 'Top'
    function = 'ormsby'
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
  [ormsby]
    type = OrmsbyWavelet
    f1 = 0.0
    f2 = 5.0
    f3 = 45.0
    f4 = 50.0
    ts = 1.5
    scale_factor = 4.905
  []
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
    block = '1 3 99 98 97 96 95 93 92 91'
    prop_names = density
    prop_values = 7.85e-6
  [../]
  [./elasticity_1]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 2e2
    poissons_ratio = 0.27
    block = '1 3 99 98 97 96 95 93 92 91'
  [../]
  # [./elasticity_2]
  #   type = ComputeIsotropicElasticityTensor
  #   youngs_modulus = 2e4
  #   poissons_ratio = 0.27
  #   block = '3'
  # [../]
  [./strain]
    type = ComputeFiniteStrain
    block = '1 3 99 98 97 96 95 93 92 91'
    displacements = 'disp_x disp_y disp_z'
  [../]
  [./stress]
    type =  ComputeFiniteStrainElasticStress
    block = '1 3 99 98 97 96 95 93 92 91'
  [../]
  [./dens2]
    type = GenericConstantMaterial
    block = '2'
    prop_names = density
    prop_values = 1e-6
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
  end_time = 3.0
  dt = 0.001
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
  [./Wave1]
    type = PointValue
    point = '-2.235 0.0 4.0'
    variable = Wave1
  [../]
  [./Wave2]
    type = PointValue
    point = '-1.243889 0.010704 4.0'
    variable = Wave1
  [../]
  [./Wave3]
    type = PointValue
    point = '0.0 0.0 4.0'
    variable = Wave1
  [../]
  [./Wave4]
    type = PointValue
    point = '1.243889 -0.010704 4.0'
    variable = Wave1
  [../]
  [./Wave5]
    type = PointValue
    point = '2.235 0.0 4.0'
    variable = Wave1
  [../]

  [stress_xx_99]
    type = ElementAverageValue
    variable = stress_xx
    block = '99'
  []
  [stress_yy_99]
    type = ElementAverageValue
    variable = stress_yy
    block = '99'
  []
  [stress_zz_99]
    type = ElementAverageValue
    variable = stress_zz
    block = '99'
  []
  [stress_xy_99]
    type = ElementAverageValue
    variable = stress_xy
    block = '99'
  []
  [stress_xz_99]
    type = ElementAverageValue
    variable = stress_xz
    block = '99'
  []
  [stress_yz_99]
    type = ElementAverageValue
    variable = stress_yz
    block = '99'
  []

  [stress_xx_98]
    type = ElementAverageValue
    variable = stress_xx
    block = '98'
  []
  [stress_yy_98]
    type = ElementAverageValue
    variable = stress_yy
    block = '98'
  []
  [stress_zz_98]
    type = ElementAverageValue
    variable = stress_zz
    block = '98'
  []
  [stress_xy_98]
    type = ElementAverageValue
    variable = stress_xy
    block = '98'
  []
  [stress_xz_98]
    type = ElementAverageValue
    variable = stress_xz
    block = '98'
  []
  [stress_yz_98]
    type = ElementAverageValue
    variable = stress_yz
    block = '98'
  []

  [stress_xx_97]
    type = ElementAverageValue
    variable = stress_xx
    block = '97'
  []
  [stress_yy_97]
    type = ElementAverageValue
    variable = stress_yy
    block = '97'
  []
  [stress_zz_97]
    type = ElementAverageValue
    variable = stress_zz
    block = '97'
  []
  [stress_xy_97]
    type = ElementAverageValue
    variable = stress_xy
    block = '97'
  []
  [stress_xz_97]
    type = ElementAverageValue
    variable = stress_xz
    block = '97'
  []
  [stress_yz_97]
    type = ElementAverageValue
    variable = stress_yz
    block = '97'
  []

  [stress_xx_96]
    type = ElementAverageValue
    variable = stress_xx
    block = '96'
  []
  [stress_yy_96]
    type = ElementAverageValue
    variable = stress_yy
    block = '96'
  []
  [stress_zz_96]
    type = ElementAverageValue
    variable = stress_zz
    block = '96'
  []
  [stress_xy_96]
    type = ElementAverageValue
    variable = stress_xy
    block = '96'
  []
  [stress_xz_96]
    type = ElementAverageValue
    variable = stress_xz
    block = '96'
  []
  [stress_yz_96]
    type = ElementAverageValue
    variable = stress_yz
    block = '96'
  []

  [stress_xx_95]
    type = ElementAverageValue
    variable = stress_xx
    block = '95'
  []
  [stress_yy_95]
    type = ElementAverageValue
    variable = stress_yy
    block = '95'
  []
  [stress_zz_95]
    type = ElementAverageValue
    variable = stress_zz
    block = '95'
  []
  [stress_xy_95]
    type = ElementAverageValue
    variable = stress_xy
    block = '95'
  []
  [stress_xz_95]
    type = ElementAverageValue
    variable = stress_xz
    block = '95'
  []
  [stress_yz_95]
    type = ElementAverageValue
    variable = stress_yz
    block = '95'
  []

  [stress_xx_93]
    type = ElementAverageValue
    variable = stress_xx
    block = '93'
  []
  [stress_yy_93]
    type = ElementAverageValue
    variable = stress_yy
    block = '93'
  []
  [stress_zz_93]
    type = ElementAverageValue
    variable = stress_zz
    block = '93'
  []
  [stress_xy_93]
    type = ElementAverageValue
    variable = stress_xy
    block = '93'
  []
  [stress_xz_93]
    type = ElementAverageValue
    variable = stress_xz
    block = '93'
  []
  [stress_yz_93]
    type = ElementAverageValue
    variable = stress_yz
    block = '93'
  []

  [stress_xx_92]
    type = ElementAverageValue
    variable = stress_xx
    block = '92'
  []
  [stress_yy_92]
    type = ElementAverageValue
    variable = stress_yy
    block = '92'
  []
  [stress_zz_92]
    type = ElementAverageValue
    variable = stress_zz
    block = '92'
  []
  [stress_xy_92]
    type = ElementAverageValue
    variable = stress_xy
    block = '92'
  []
  [stress_xz_92]
    type = ElementAverageValue
    variable = stress_xz
    block = '92'
  []
  [stress_yz_92]
    type = ElementAverageValue
    variable = stress_yz
    block = '92'
  []

  [stress_xx_91]
    type = ElementAverageValue
    variable = stress_xx
    block = '91'
  []
  [stress_yy_91]
    type = ElementAverageValue
    variable = stress_yy
    block = '91'
  []
  [stress_zz_91]
    type = ElementAverageValue
    variable = stress_zz
    block = '91'
  []
  [stress_xy_91]
    type = ElementAverageValue
    variable = stress_xy
    block = '91'
  []
  [stress_xz_91]
    type = ElementAverageValue
    variable = stress_xz
    block = '91'
  []
  [stress_yz_91]
    type = ElementAverageValue
    variable = stress_yz
    block = '91'
  []

  [accel_x1]
    type = PointValue
    point = '0.0 0.0 5.131750'
    variable = accel_x
  []
  [accel_x2]
    type = PointValue
    point = '2.5 0.0 4.0'
    variable = accel_x
  []

  [p1_n]
    type = PointValue
    point = '-2.48 0.0 4.0'
    variable = p
  []
  [p2_n]
    type = PointValue
    point = '-2.48 0.0 3.333333'
    variable = p
  []
  [p3_n]
    type = PointValue
    point = '-2.48 0.0 2.666667'
    variable = p
  []
  [p4_n]
    type = PointValue
    point = '-2.48 0.0 2.0'
    variable = p
  []
  [p5_n]
    type = PointValue
    point = '-2.48 0.0 1.333333'
    variable = p
  []
  [p6_n]
    type = PointValue
    point = '-2.48 0.0 0.666667'
    variable = p
  []

  [p1_p]
    type = PointValue
    point = '2.48 0.0 4.0'
    variable = p
  []
  [p2_p]
    type = PointValue
    point = '2.48 0.0 3.333333'
    variable = p
  []
  [p3_p]
    type = PointValue
    point = '2.48 0.0 2.666667'
    variable = p
  []
  [p4_p]
    type = PointValue
    point = '2.48 0.0 2.0'
    variable = p
  []
  [p5_p]
    type = PointValue
    point = '2.48 0.0 1.333333'
    variable = p
  []
  [p6_p]
    type = PointValue
    point = '2.48 0.0 0.666667'
    variable = p
  []

  [dispx_bot]
    type = PointValue
    point = '0.0 0.0 -1.0'
    variable = disp_x
  []
  [dispy_bot]
    type = PointValue
    point = '0.0 0.0 -1.0'
    variable = disp_y
  []
  [dispz_bot]
    type = PointValue
    point = '0.0 0.0 -1.0'
    variable = disp_z
  []
  [accx_bot]
    type = PointValue
    point = '0.0 0.0 -1.0'
    variable = accel_x
  []
  [accy_bot]
    type = PointValue
    point = '0.0 0.0 -1.0'
    variable = accel_y
  []
  [accz_bot]
    type = PointValue
    point = '0.0 0.0 -1.0'
    variable = accel_z
  []
  [velx_bot]
    type = PointValue
    point = '0.0 0.0 -1.0'
    variable = vel_x
  []
  [vely_bot]
    type = PointValue
    point = '0.0 0.0 -1.0'
    variable = vel_y
  []
  [velz_bot]
    type = PointValue
    point = '0.0 0.0 -1.0'
    variable = vel_z
  []

[]

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
  print_linear_residuals = true
  file_base = Ex_RealVessel_lv2_2
  [./out]
    execute_on = 'TIMESTEP_BEGIN'
    type = CSV
    file_base = RealVessel
  [../]
[]
