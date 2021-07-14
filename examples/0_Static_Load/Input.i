[Mesh]
  [file]
    type = FileMeshGenerator
    file = Real_Vessel_2.e
  []
[]

[GlobalParams]
  displacements = 'disp_x disp_y disp_z'
[]

# [Adaptivity]
#   initial_marker = marker1
#   initial_steps = 2
#   [Markers]
#     [marker1]
#       type = UniformMarker
#       block = '1 3'
#       mark = REFINE
#     []
#   []
# []

[Variables]
  [./disp_x]
  [../]
  [./disp_y]
  [../]
  [./disp_z]
  [../]
[]

[AuxVariables]
  [./vel_x]
    order = FIRST
    family = LAGRANGE
  [../]
  [./accel_x]
    order = FIRST
    family = LAGRANGE
  [../]
  [./vel_y]
    order = FIRST
    family = LAGRANGE
  [../]
  [./accel_y]
    order = FIRST
    family = LAGRANGE
  [../]
  [./vel_z]
    order = FIRST
    family = LAGRANGE
  [../]
  [./accel_z]
    order = FIRST
    family = LAGRANGE
  [../]
  [./stress_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_yy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_xy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_zz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_yz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_xz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./vonmises]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./maxP]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./midP]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./minP]
    order = CONSTANT
    family = MONOMIAL
  [../]
[]

[Modules/TensorMechanics/Master]
  [./strain_calculator]
    strain = SMALL # FINITE #
  [../]
[]

[AuxKernels]
  [./stress_xx]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xx
    index_i = 0
    index_j = 0
  [../]
  [./stress_yy]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_yy
    index_i = 1
    index_j = 1
  [../]
  [./stress_xy]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xy
    index_i = 0
    index_j = 1
  [../]
  [./stress_zz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_zz
    index_i = 2
    index_j = 2
  [../]
  [./stress_yz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_yz
    index_i = 1
    index_j = 2
  [../]
  [./stress_xz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xz
    index_i = 0
    index_j = 2
  [../]
  [./vonmises]
    type = RankTwoScalarAux
    rank_two_tensor = stress
    variable = vonmises
    scalar_type = VonMisesStress
    execute_on = timestep_end
  [../]
  [./maxP]
    type = RankTwoScalarAux
    rank_two_tensor = stress
    variable = maxP
    scalar_type = MaxPrincipal
    execute_on = timestep_end
  [../]
  [./minP]
    type = RankTwoScalarAux
    rank_two_tensor = stress
    variable = minP
    scalar_type = MinPrincipal
    execute_on = timestep_end
  [../]
  [./midP]
    type = RankTwoScalarAux
    rank_two_tensor = stress
    variable = midP
    scalar_type = MidPrincipal
    execute_on = timestep_end
  [../]
[]

[BCs]
  [./disp_x1]
    type = DirichletBC
    variable = disp_x
    boundary = 'Top'
    value = 0.0
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
  [./disp_x11]
    type = DirichletBC
    variable = disp_x
    boundary = 'Bottom'
    value = 0.15
  [../]
  [./disp_x22]
    type = DirichletBC
    variable = disp_y
    boundary = 'Bottom'
    value = 0.0
  [../]
  [./disp_x33]
    type = DirichletBC
    variable = disp_z
    boundary = 'Bottom'
    value = 0.0
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
    block = '1 3'
  [../]
  [./elasticity_2]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 2e1
    poissons_ratio = 0.27
    block = '2'
  [../]
  [./stress]
    type =  ComputeLinearElasticStress # ComputeFiniteStrainElasticStress #
  [../]
[]

[Preconditioning]
  [./andy]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  type = Steady
  solve_type = NEWTON
  petsc_options = '-ksp_snes_ew'
  petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
  petsc_options_value = 'lu       superlu_dist'
  line_search = 'none'
  nl_rel_tol = 1e-6
  nl_abs_tol = 1e-10
[]

# [VectorPostprocessors]
#   [stress_xx1]
#     type = LineValueSampler
#     start_point = '-2.5 0.0 4.0'
#     end_point = '-2.5 0.0 4.97'
#     num_points = 10
#     sort_by = z
#     variable = stress_xx
#   []
#   [stress_yy1]
#     type = LineValueSampler
#     start_point = '-2.5 0.0 4.0'
#     end_point = '-2.5 0.0 4.97'
#     num_points = 10
#     sort_by = z
#     variable = stress_yy
#   []
#   [stress_zz1]
#     type = LineValueSampler
#     start_point = '-2.5 0.0 4.0'
#     end_point = '-2.5 0.0 4.97'
#     num_points = 10
#     sort_by = z
#     variable = stress_zz
#   []
#   [stress_xy1]
#     type = LineValueSampler
#     start_point = '-2.5 0.0 4.0'
#     end_point = '-2.5 0.0 4.97'
#     num_points = 10
#     sort_by = z
#     variable = stress_xy
#   []
#   [stress_xz1]
#     type = LineValueSampler
#     start_point = '-2.5 0.0 4.0'
#     end_point = '-2.5 0.0 4.97'
#     num_points = 10
#     sort_by = z
#     variable = stress_xz
#   []
#   [stress_yz1]
#     type = LineValueSampler
#     start_point = '-2.5 0.0 4.0'
#     end_point = '-2.5 0.0 4.97'
#     num_points = 10
#     sort_by = z
#     variable = stress_yz
#   []
#
#   [stress_xx2]
#     type = LineValueSampler
#     start_point = '-2.48 0.0 4.0'
#     end_point = '-2.48 0.0 4.97'
#     num_points = 10
#     sort_by = z
#     variable = stress_xx
#   []
#   [stress_yy2]
#     type = LineValueSampler
#     start_point = '-2.48 0.0 4.0'
#     end_point = '-2.48 0.0 4.97'
#     num_points = 10
#     sort_by = z
#     variable = stress_yy
#   []
#   [stress_zz2]
#     type = LineValueSampler
#     start_point = '-2.48 0.0 4.0'
#     end_point = '-2.48 0.0 4.97'
#     num_points = 10
#     sort_by = z
#     variable = stress_zz
#   []
#   [stress_xy2]
#     type = LineValueSampler
#     start_point = '-2.48 0.0 4.0'
#     end_point = '-2.48 0.0 4.97'
#     num_points = 10
#     sort_by = z
#     variable = stress_xy
#   []
#   [stress_xz2]
#     type = LineValueSampler
#     start_point = '-2.48 0.0 4.0'
#     end_point = '-2.48 0.0 4.97'
#     num_points = 10
#     sort_by = z
#     variable = stress_xz
#   []
#   [stress_yz2]
#     type = LineValueSampler
#     start_point = '-2.48 0.0 4.0'
#     end_point = '-2.48 0.0 4.97'
#     num_points = 10
#     sort_by = z
#     variable = stress_yz
#   []
#
#   [stress_xx3]
#     type = LineValueSampler
#     start_point = '-2.5 0.0 4.0'
#     end_point = '-2.48 0.0 4.0'
#     num_points = 10
#     sort_by = z
#     variable = stress_xx
#   []
#   [stress_yy3]
#     type = LineValueSampler
#     start_point = '-2.5 0.0 4.0'
#     end_point = '-2.48 0.0 4.0'
#     num_points = 10
#     sort_by = z
#     variable = stress_yy
#   []
#   [stress_zz3]
#     type = LineValueSampler
#     start_point = '-2.5 0.0 4.0'
#     end_point = '-2.48 0.0 4.0'
#     num_points = 10
#     sort_by = z
#     variable = stress_zz
#   []
#   [stress_xy3]
#     type = LineValueSampler
#     start_point = '-2.5 0.0 4.0'
#     end_point = '-2.48 0.0 4.0'
#     num_points = 10
#     sort_by = z
#     variable = stress_xy
#   []
#   [stress_xz3]
#     type = LineValueSampler
#     start_point = '-2.5 0.0 4.0'
#     end_point = '-2.48 0.0 4.0'
#     num_points = 10
#     sort_by = z
#     variable = stress_xz
#   []
#   [stress_yz3]
#     type = LineValueSampler
#     start_point = '-2.5 0.0 4.0'
#     end_point = '-2.48 0.0 4.0'
#     num_points = 10
#     sort_by = z
#     variable = stress_yz
#   []
# []

# [VectorPostprocessors]
#   [stress_xx1]
#     type = LineValueSampler
#     start_point = '-2.5 0.0 4.0'
#     end_point = '-2.5 0.0 4.97'
#     num_points = 10
#     sort_by = z
#     variable = stress_xx
#   []
#   [stress_yy1]
#     type = LineValueSampler
#     start_point = '-2.5 0.0 4.0'
#     end_point = '-2.5 0.0 4.97'
#     num_points = 10
#     sort_by = z
#     variable = stress_yy
#   []
#   [stress_zz1]
#     type = LineValueSampler
#     start_point = '-2.5 0.0 4.0'
#     end_point = '-2.5 0.0 4.97'
#     num_points = 10
#     sort_by = z
#     variable = stress_zz
#   []
#   [stress_von1]
#     type = LineValueSampler
#     start_point = '-2.5 0.0 4.0'
#     end_point = '-2.5 0.0 4.97'
#     num_points = 10
#     sort_by = z
#     variable = vonmises
#   []
#   [stress_max1]
#     type = LineValueSampler
#     start_point = '-2.5 0.0 4.0'
#     end_point = '-2.5 0.0 4.97'
#     num_points = 10
#     sort_by = z
#     variable = maxP
#   []
#   [stress_min1]
#     type = LineValueSampler
#     start_point = '-2.5 0.0 4.0'
#     end_point = '-2.5 0.0 4.97'
#     num_points = 10
#     sort_by = z
#     variable = minP
#   []
#   [stress_mid1]
#     type = LineValueSampler
#     start_point = '-2.5 0.0 4.0'
#     end_point = '-2.5 0.0 4.97'
#     num_points = 10
#     sort_by = z
#     variable = midP
#   []
#
#   [stress_xx2]
#     type = LineValueSampler
#     start_point = '-2.48 0.0 4.0'
#     end_point = '-2.48 0.0 4.97'
#     num_points = 10
#     sort_by = z
#     variable = stress_xx
#   []
#   [stress_yy2]
#     type = LineValueSampler
#     start_point = '-2.48 0.0 4.0'
#     end_point = '-2.48 0.0 4.97'
#     num_points = 10
#     sort_by = z
#     variable = stress_yy
#   []
#   [stress_zz2]
#     type = LineValueSampler
#     start_point = '-2.48 0.0 4.0'
#     end_point = '-2.48 0.0 4.97'
#     num_points = 10
#     sort_by = z
#     variable = stress_zz
#   []
#   [stress_von2]
#     type = LineValueSampler
#     start_point = '-2.48 0.0 4.0'
#     end_point = '-2.48 0.0 4.97'
#     num_points = 10
#     sort_by = z
#     variable = vonmises
#   []
#   [stress_max2]
#     type = LineValueSampler
#     start_point = '-2.48 0.0 4.0'
#     end_point = '-2.48 0.0 4.97'
#     num_points = 10
#     sort_by = z
#     variable = maxP
#   []
#   [stress_min2]
#     type = LineValueSampler
#     start_point = '-2.48 0.0 4.0'
#     end_point = '-2.48 0.0 4.97'
#     num_points = 10
#     sort_by = z
#     variable = minP
#   []
#   [stress_mid2]
#     type = LineValueSampler
#     start_point = '-2.48 0.0 4.0'
#     end_point = '-2.48 0.0 4.97'
#     num_points = 10
#     sort_by = z
#     variable = midP
#   []
#
#   [stress_xx3]
#     type = LineValueSampler
#     start_point = '-2.5 0.0 4.0'
#     end_point = '-2.48 0.0 4.0'
#     num_points = 10
#     sort_by = z
#     variable = stress_xx
#   []
#   [stress_yy3]
#     type = LineValueSampler
#     start_point = '-2.5 0.0 4.0'
#     end_point = '-2.48 0.0 4.0'
#     num_points = 10
#     sort_by = z
#     variable = stress_yy
#   []
#   [stress_zz3]
#     type = LineValueSampler
#     start_point = '-2.5 0.0 4.0'
#     end_point = '-2.48 0.0 4.0'
#     num_points = 10
#     sort_by = z
#     variable = stress_zz
#   []
#   [stress_von3]
#     type = LineValueSampler
#     start_point = '-2.5 0.0 4.0'
#     end_point = '-2.48 0.0 4.0'
#     num_points = 10
#     sort_by = z
#     variable = vonmises
#   []
#   [stress_max3]
#     type = LineValueSampler
#     start_point = '-2.5 0.0 4.0'
#     end_point = '-2.48 0.0 4.0'
#     num_points = 10
#     sort_by = z
#     variable = maxP
#   []
#   [stress_min3]
#     type = LineValueSampler
#     start_point = '-2.5 0.0 4.0'
#     end_point = '-2.48 0.0 4.0'
#     num_points = 10
#     sort_by = z
#     variable = minP
#   []
#   [stress_mid3]
#     type = LineValueSampler
#     start_point = '-2.5 0.0 4.0'
#     end_point = '-2.48 0.0 4.0'
#     num_points = 10
#     sort_by = z
#     variable = midP
#   []
# []

[Postprocessors]
  [./Moment_Out_y]
    type = SidesetMoment
    stress_direction = '1 0 0'
    stress_tensor = stress
    boundary = 'Outer_Surface'
    reference_point = '0.0 0.0 5.0'
    moment_direction = '0 1 0'
  [../]
  [./Moment_Out_x]
    type = SidesetMoment
    stress_direction = '1 0 0'
    stress_tensor = stress
    boundary = 'Outer_Surface'
    reference_point = '0.0 0.0 5.0'
    moment_direction = '1 0 0'
  [../]
  [./Moment_Out_z]
    type = SidesetMoment
    stress_direction = '1 0 0'
    stress_tensor = stress
    boundary = 'Outer_Surface'
    reference_point = '0.0 0.0 5.0'
    moment_direction = '0 0 1'
  [../]
  [./Moment_In_y]
    type = SidesetMoment
    stress_direction = '1 0 0'
    stress_tensor = stress
    boundary = 'Inner_Surface'
    reference_point = '0.0 0.0 5.0'
    moment_direction = '0 1 0'
  [../]
  [./Moment_In_x]
    type = SidesetMoment
    stress_direction = '1 0 0'
    stress_tensor = stress
    boundary = 'Inner_Surface'
    reference_point = '0.0 0.0 5.0'
    moment_direction = '1 0 0'
  [../]
  [./Moment_In_z]
    type = SidesetMoment
    stress_direction = '1 0 0'
    stress_tensor = stress
    boundary = 'Inner_Surface'
    reference_point = '0.0 0.0 5.0'
    moment_direction = '0 0 1'
  [../]
[]

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
  print_linear_residuals = true
  file_base = Ex_Moment_lv1
  [./out]
    execute_on = 'TIMESTEP_BEGIN'
    type = CSV
    file_base = Moment_lv1
  [../]
[]
