[Mesh]
  [file]
    type = FileMeshGenerator
    file = Vessel.e
  []
  [./interface1]
    type = SideSetsBetweenSubdomainsGenerator
    input = file
    primary_block = '1'
    paired_block = '2'
    new_boundary = 'Interface'
  [../]
  displacements = 'disp_x disp_y disp_z'
[]

[Adaptivity]
  initial_marker = marker1
  initial_steps = 1
  [Markers]
    [marker1]
      type = UniformMarker
      block = '1'
      mark = REFINE
    []
  []
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
  [./vonmises]
    order = CONSTANT
    family = MONOMIAL
    block = '1 3'
  [../]
  [./maxP]
    order = CONSTANT
    family = MONOMIAL
    block = '1 3'
  [../]
  [./midP]
    order = CONSTANT
    family = MONOMIAL
    block = '1 3'
  [../]
  [./minP]
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
    use_displaced_mesh = false
  [../]
  [./inertia]
    type = AcousticInertia
    variable = p
    block = 2
    use_displaced_mesh = false
  [../]
  [./DynamicTensorMechanics]
    displacements = 'disp_x disp_y disp_z'
    block = '1 3'
    zeta = 0.00076923
  [../]
  [./inertia_x1]
    type = InertialForce
    variable = disp_x
    block = '1 3'
    eta = 0.01923
  [../]
  [./inertia_y1]
    type = InertialForce
    variable = disp_y
    block = '1 3'
    eta = 0.01923
  [../]
  [./inertia_z1]
    type = InertialForce
    variable = disp_z
    block = '1 3'
    eta = 0.01923
  [../]
[]

[AuxKernels]
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
  [./vonmises]
    type = RankTwoScalarAux
    rank_two_tensor = stress
    variable = vonmises
    scalar_type = VonMisesStress
    execute_on = timestep_end
    block = '1 3'
  [../]
  [./maxP]
    type = RankTwoScalarAux
    rank_two_tensor = stress
    variable = maxP
    scalar_type = MaxPrincipal
    execute_on = timestep_end
    block = '1 3'
  [../]
  [./minP]
    type = RankTwoScalarAux
    rank_two_tensor = stress
    variable = minP
    scalar_type = MinPrincipal
    execute_on = timestep_end
    block = '1 3'
  [../]
  [./midP]
    type = RankTwoScalarAux
    rank_two_tensor = stress
    variable = midP
    scalar_type = MidPrincipal
    execute_on = timestep_end
    block = '1 3'
  [../]
  [./waves]
    type = WaveHeightAuxKernel
    variable = 'Wave1'
    pressure = p
    density = 1e-6
    gravity = 9.81
    execute_on = timestep_end
    block = 2
  [../]
[]

[Functions]
  [ormsby]
    type = OrmsbyWavelet
    f1 = 0.0
    f2 = 5.0
    f3 = 45.0
    f4 = 50.0
    ts = 0.5
    scale_factor = 4.905
  []
[]

[InterfaceKernels]
  [./interface1]
    type =  FSI_test
    variable = disp_x
    neighbor_var = p
    boundary = 'Interface'
    D = 1e-6
    component = 0
  [../]
  [./interface2]
    type =  FSI_test
    variable = disp_y
    neighbor_var = p
    boundary = 'Interface'
    D = 1e-6
    component = 1
  [../]
  [./interface3]
    type =  FSI_test
    variable = disp_z
    neighbor_var = p
    boundary = 'Interface'
    D = 1e-6
    component = 2
  [../]
[]

[BCs]
  [./x_motion]
    type = PresetAcceleration
    acceleration = accel_x
    velocity = vel_x
    variable = disp_x
    beta = 0.25
    boundary = 'Top'
    function = 'ormsby'
  [../]
  [./y_motion]
    type = DirichletBC
    variable = disp_y
    boundary = 'Top'
    value = 0.0
  [../]
  [./z_motion]
    type = DirichletBC
    variable = disp_z
    boundary = 'Top'
    value = 0.0
  [../]
  [./free]
    type = FluidFreeSurfaceBC
    variable = p
    boundary = 'Fluid_top'
  []
[]

[Contact]
  [./top]
    primary = 'Flange_bottom'
    secondary = 'Vessel_top'
    system = constraint
    model = glued
    formulation = penalty
    penalty = 5e9
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
  [./elasticity_1]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 2e2
    poissons_ratio = 0.27
    block = '1'
  [../]
  [./elasticity_3]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 2e5
    poissons_ratio = 0.27
    block = '3'
  [../]
  [./dens2]
    type = GenericConstantMaterial
    block = '2'
    prop_names = density
    prop_values = 1e-6
  [../]
  [./stress]
    type =  ComputeLinearElasticStress # ComputeFiniteStrainElasticStress #
    block = '1 3'
  [../]
  [./strain]
    type = ComputeSmallStrain
    block = '1 3'
    displacements = 'disp_x disp_y disp_z'
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
  solve_type = NEWTON
  petsc_options = '-ksp_snes_ew'
  petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
  petsc_options_value = 'lu       superlu_dist'
  line_search = 'none'
  nl_rel_tol = 1e-10
  nl_abs_tol = 1e-10
  start_time = 0.0
  end_time = 1.0
  dt = 0.0025
  dtmin = 0.00001
  [TimeIntegrator]
    type = NewmarkBeta
    beta = 0.25 # 0.3025
    gamma = 0.5 # 0.6
  []
[]

[VectorPostprocessors]
  [stress_xx1]
    type = LineValueSampler
    start_point = '-2.5 0.0 4.0'
    end_point = '-2.5 0.0 4.97'
    num_points = 10
    sort_by = z
    variable = stress_xx
  []
  [stress_yy1]
    type = LineValueSampler
    start_point = '-2.5 0.0 4.0'
    end_point = '-2.5 0.0 4.97'
    num_points = 10
    sort_by = z
    variable = stress_yy
  []
  [stress_zz1]
    type = LineValueSampler
    start_point = '-2.5 0.0 4.0'
    end_point = '-2.5 0.0 4.97'
    num_points = 10
    sort_by = z
    variable = stress_zz
  []
  [stress_von1]
    type = LineValueSampler
    start_point = '-2.5 0.0 4.0'
    end_point = '-2.5 0.0 4.97'
    num_points = 10
    sort_by = z
    variable = vonmises
  []
  [stress_max1]
    type = LineValueSampler
    start_point = '-2.5 0.0 4.0'
    end_point = '-2.5 0.0 4.97'
    num_points = 10
    sort_by = z
    variable = maxP
  []
  [stress_min1]
    type = LineValueSampler
    start_point = '-2.5 0.0 4.0'
    end_point = '-2.5 0.0 4.97'
    num_points = 10
    sort_by = z
    variable = minP
  []
  [stress_mid1]
    type = LineValueSampler
    start_point = '-2.5 0.0 4.0'
    end_point = '-2.5 0.0 4.97'
    num_points = 10
    sort_by = z
    variable = midP
  []

  [stress_xx2]
    type = LineValueSampler
    start_point = '-2.48 0.0 4.0'
    end_point = '-2.48 0.0 4.97'
    num_points = 10
    sort_by = z
    variable = stress_xx
  []
  [stress_yy2]
    type = LineValueSampler
    start_point = '-2.48 0.0 4.0'
    end_point = '-2.48 0.0 4.97'
    num_points = 10
    sort_by = z
    variable = stress_yy
  []
  [stress_zz2]
    type = LineValueSampler
    start_point = '-2.48 0.0 4.0'
    end_point = '-2.48 0.0 4.97'
    num_points = 10
    sort_by = z
    variable = stress_zz
  []
  [stress_von2]
    type = LineValueSampler
    start_point = '-2.48 0.0 4.0'
    end_point = '-2.48 0.0 4.97'
    num_points = 10
    sort_by = z
    variable = vonmises
  []
  [stress_max2]
    type = LineValueSampler
    start_point = '-2.48 0.0 4.0'
    end_point = '-2.48 0.0 4.97'
    num_points = 10
    sort_by = z
    variable = maxP
  []
  [stress_min2]
    type = LineValueSampler
    start_point = '-2.48 0.0 4.0'
    end_point = '-2.48 0.0 4.97'
    num_points = 10
    sort_by = z
    variable = minP
  []
  [stress_mid2]
    type = LineValueSampler
    start_point = '-2.48 0.0 4.0'
    end_point = '-2.48 0.0 4.97'
    num_points = 10
    sort_by = z
    variable = midP
  []

  [stress_xx3]
    type = LineValueSampler
    start_point = '-2.5 0.0 4.0'
    end_point = '-2.48 0.0 4.0'
    num_points = 10
    sort_by = z
    variable = stress_xx
  []
  [stress_yy3]
    type = LineValueSampler
    start_point = '-2.5 0.0 4.0'
    end_point = '-2.48 0.0 4.0'
    num_points = 10
    sort_by = z
    variable = stress_yy
  []
  [stress_zz3]
    type = LineValueSampler
    start_point = '-2.5 0.0 4.0'
    end_point = '-2.48 0.0 4.0'
    num_points = 10
    sort_by = z
    variable = stress_zz
  []
  [stress_von3]
    type = LineValueSampler
    start_point = '-2.5 0.0 4.0'
    end_point = '-2.48 0.0 4.0'
    num_points = 10
    sort_by = z
    variable = vonmises
  []
  [stress_max3]
    type = LineValueSampler
    start_point = '-2.5 0.0 4.0'
    end_point = '-2.48 0.0 4.0'
    num_points = 10
    sort_by = z
    variable = maxP
  []
  [stress_min3]
    type = LineValueSampler
    start_point = '-2.5 0.0 4.0'
    end_point = '-2.48 0.0 4.0'
    num_points = 10
    sort_by = z
    variable = minP
  []
  [stress_mid3]
    type = LineValueSampler
    start_point = '-2.5 0.0 4.0'
    end_point = '-2.48 0.0 4.0'
    num_points = 10
    sort_by = z
    variable = midP
  []
[]

[Postprocessors]
  [./Moment_Out_y]
    type = SidesetMoment
    stress_direction = '0 0 1'
    stress_tensor = stress
    boundary = 'Top'
    reference_point = '0.0 0.0 4.981750'
    moment_direction = '0 1 0'
  [../]
  [./Moment_Out_x]
    type = SidesetMoment
    stress_direction = '0 0 1'
    stress_tensor = stress
    boundary = 'Top'
    reference_point = '0.0 0.0 4.981750'
    moment_direction = '1 0 0'
  [../]
  [./Moment_Out_z]
    type = SidesetMoment
    stress_direction = '0 0 1'
    stress_tensor = stress
    boundary = 'Top'
    reference_point = '0.0 0.0 4.981750'
    moment_direction = '0 0 1'
  [../]

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
[]

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
  print_linear_residuals = true
  file_base = Ex_Ormsby
  [./out]
    execute_on = 'TIMESTEP_BEGIN'
    type = CSV
    file_base = Ormsby
  [../]
[]
