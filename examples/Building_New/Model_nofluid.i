[Mesh]
  [mesh_gen]
    type = FileMeshGenerator
    file = structure_1_solids_merged_RV.e
  []
  # [subdomain_1]
  #   type = SubdomainBoundingBoxGenerator
  #   bottom_left = '-17.5 0.0 6.655'
  #   top_right = '-16.24 2.1477430013854 7.625'
  #   location = INSIDE
  #   block_id = 99
  #   input = mesh_gen
  # []
  # [subdomain_2]
  #   type = SubdomainBoundingBoxGenerator
  #   bottom_left = '-16.75 3.0310889132455 6.655000'
  #   top_right = '-13.742095 2.137306 7.625000'
  #   location = INSIDE
  #   block_id = 98
  #   input = subdomain_1
  # []
  # [subdomain_3]
  #   type = SubdomainBoundingBoxGenerator
  #   bottom_left = '-13.75 2.165064 6.655'
  #   top_right = '-12.52 0.0 7.625'
  #   location = INSIDE
  #   block_id = 97
  #   input = subdomain_2
  # []
  # [subdomain_4]
  #   type = SubdomainBoundingBoxGenerator
  #   bottom_left = '-12.5 0.0 6.655'
  #   top_right = '-13.742095 -2.137306 7.625'
  #   location = INSIDE
  #   block_id = 96
  #   input = subdomain_3
  # []
  # [subdomain_5]
  #   type = SubdomainBoundingBoxGenerator
  #   bottom_left = '-13.742095 -3.0310889132455 6.655'
  #   top_right = '-16.257905 -2.137306 7.625'
  #   location = INSIDE
  #   block_id = 95
  #   input = subdomain_4
  # []
  # [subdomain_6]
  #   type = SubdomainBoundingBoxGenerator
  #   bottom_left = '-16.25 -2.165064 6.655'
  #   top_right = '-17.48 0.0 7.625'
  #   location = INSIDE
  #   block_id = 94
  #   input = subdomain_5
  # []

  # [subdomain_7]
  #   type = SubdomainBoundingBoxGenerator
  #   bottom_left = '-17.5 0.0 5.755'
  #   top_right = '-16.24 2.1477430013854 6.655'
  #   location = INSIDE
  #   block_id = 93
  #   input = subdomain_6
  # []
  # [subdomain_8]
  #   type = SubdomainBoundingBoxGenerator
  #   bottom_left = '-16.75 3.0310889132455 5.755'
  #   top_right = '-13.742095 2.137306 6.655'
  #   location = INSIDE
  #   block_id = 92
  #   input = subdomain_7
  # []
  # [subdomain_9]
  #   type = SubdomainBoundingBoxGenerator
  #   bottom_left = '-13.75 2.165064 5.755'
  #   top_right = '-12.52 0.0 6.655'
  #   location = INSIDE
  #   block_id = 91
  #   input = subdomain_8
  # []
  # [subdomain_10]
  #   type = SubdomainBoundingBoxGenerator
  #   bottom_left = '-12.5 0.0 5.755'
  #   top_right = '-13.742095 -2.137306 6.655'
  #   location = INSIDE
  #   block_id = 90
  #   input = subdomain_9
  # []
  # [subdomain_11]
  #   type = SubdomainBoundingBoxGenerator
  #   bottom_left = '-13.742095 -3.0310889132455 5.755'
  #   top_right = '-16.257905 -2.137306 6.655'
  #   location = INSIDE
  #   block_id = 89
  #   input = subdomain_10
  # []
  # [subdomain_12]
  #   type = SubdomainBoundingBoxGenerator
  #   bottom_left = '-16.25 -2.165064 5.755'
  #   top_right = '-17.48 0.0 6.655'
  #   location = INSIDE
  #   block_id = 88
  #   input = subdomain_11
  # []
[]

[Adaptivity]
  initial_marker = marker1
  initial_steps = 1
  [Markers]
    [marker1]
      type = UniformMarker
      block = 'RV RV_slab' # 99 98 97 96 95 94
      mark = REFINE
    []
  []
[]

[GlobalParams]
  displacements = 'disp_x disp_y disp_z'
[]

[Variables]
  [./disp_x]
    order = FIRST
    family = LAGRANGE
  [../]
  [./disp_y]
    order = FIRST
    family = LAGRANGE
  [../]
  [./disp_z]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[AuxVariables]
  [./vel_x]
  [../]
  [./accel_x]
  [../]
  [./vel_y]
  [../]
  [./accel_y]
  [../]
  [./vel_z]
  [../]
  [./accel_z]
  [../]
  [./stress_xy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_yz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_zx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_xy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_yz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_zx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_yy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_zz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_yy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_zz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./vonmises]
    order = FIRST
    family = MONOMIAL
  [../]
  [./maxP]
    order = FIRST
    family = MONOMIAL
  [../]
  [./midP]
    order = FIRST
    family = MONOMIAL
  [../]
  [./minP]
    order = FIRST
    family = MONOMIAL
  [../]
  # [./vonM]
  #   order = FIRST
  #   family = MONOMIAL
  # [../]
[]

[Kernels]
  [./DynamicTensorMechanics]
    zeta = 0.00006366
  [../]
  [./inertia_x]
    type = InertialForce
    variable = disp_x
    velocity = vel_x
    acceleration = accel_x
    beta = 0.25
    gamma = 0.5
    eta = 7.854
  [../]
  [./inertia_y]
    type = InertialForce
    variable = disp_y
    velocity = vel_y
    acceleration = accel_y
    beta = 0.25
    gamma = 0.5
    eta = 7.854
  [../]
  [./inertia_z]
    type = InertialForce
    variable = disp_z
    velocity = vel_z
    acceleration = accel_z
    beta = 0.25
    gamma = 0.5
    eta = 7.854
  [../]
  # [./gravity]
  #   type = Gravity
  #   variable = disp_z
  #   value = -9.81
  # [../]
[]

[AuxKernels]
  [./accel_x]
    type = NewmarkAccelAux
    variable = accel_x
    displacement = disp_x
    velocity = vel_x
    beta = 0.25
    execute_on = timestep_end
  [../]
  [./vel_x]
    type = NewmarkVelAux
    variable = vel_x
    acceleration = accel_x
    gamma = 0.5
    execute_on = timestep_end
  [../]
  [./accel_y]
    type = NewmarkAccelAux
    variable = accel_y
    displacement = disp_y
    velocity = vel_y
    beta = 0.25
    execute_on = timestep_end
  [../]
  [./vel_y]
    type = NewmarkVelAux
    variable = vel_y
    acceleration = accel_y
    gamma = 0.5
    execute_on = timestep_end
  [../]
  [./accel_z]
    type = NewmarkAccelAux
    variable = accel_z
    displacement = disp_z
    velocity = vel_z
    beta = 0.25
    execute_on = timestep_end
  [../]
  [./vel_z]
    type = NewmarkVelAux
    variable = vel_z
    acceleration = accel_z
    gamma = 0.5
    execute_on = timestep_end
  [../]
  [./stress_xy]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xy
    index_i = 1
    index_j = 0
  [../]
  [./stress_yz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_yz
    index_i = 2
    index_j = 1
  [../]
  [./stress_zx]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_zx
    index_i = 0
    index_j = 2
  [../]
  [./strain_xy]
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = stress_xy
    index_i = 1
    index_j = 0
  [../]
  [./strain_yz]
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = strain_yz
    index_i = 2
    index_j = 1
  [../]
  [./strain_zx]
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = strain_zx
    index_i = 0
    index_j = 2
  [../]
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
  [./stress_zz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_zz
    index_i = 2
    index_j = 2
  [../]
  [./strain_xx]
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = strain_xx
    index_i = 0
    index_j = 0
  [../]
  [./strain_yy]
    type = RankTwoAux
    rank_two_tensor =total_strain
    variable = strain_yy
    index_i = 1
    index_j = 1
  [../]
  [./strain_zz]
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = strain_zz
    index_i = 2
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

[Materials]
  [./elasticity_1]
    type = ComputeIsotropicElasticityTensor
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat'
    youngs_modulus = 24.8 # e9
    poissons_ratio = 0.2
  [../]
  [./strain_1]
    type = ComputeSmallStrain
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat'
  [../]
  [./stress_1]
    type = ComputeLinearElasticStress
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat'
  [../]
  [./den_1]
    type = GenericConstantMaterial
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat'
    prop_names = density
    prop_values = 2.4e-6 # 2400 #kg/m3
  [../]

  [./elasticity_2]
    type = ComputeIsotropicElasticityTensor
    block = 'RV SGs RV_slab' # 99 98 97 96 95 94
    youngs_modulus = 170 # e9
    poissons_ratio = 0.3
  [../]
  [./strain_2]
    type = ComputeSmallStrain
    block = 'RV SGs RV_slab' # 99 98 97 96 95 94
  [../]
  [./stress_2]
    type = ComputeLinearElasticStress
    block = 'RV SGs RV_slab' # 99 98 97 96 95 94
  [../]

  [./den_rv]
    type = GenericConstantMaterial
    block = 'RV RV_slab' # 99 98 97 96 95 94
    prop_names = density
    prop_values = 7.85e-6 # 7850.0 #kg/m3
  [../]
  [./den_sg]
    type = GenericConstantMaterial
    block = 'SGs'
    prop_names = density
    prop_values = 7.85e-6 # 7850.0 #kg/m3
  [../]

  [./elasticity_3]
    type = ComputeIsotropicElasticityTensor
    block = 'fluid_material'
    youngs_modulus = 0.14 # 14e7
    poissons_ratio = 0.27
  [../]
  [./strain_3]
    type = ComputeSmallStrain
    block = 'fluid_material'
  [../]
  [./stress_3]
    type = ComputeLinearElasticStress
    block = 'fluid_material'
  [../]
  [./den_fluid]
    type = GenericConstantMaterial
    block = 'fluid_material'
    prop_names = density
    prop_values = 1e-6 # 1000.0 #kg/m3
  [../]
[]

[Functions]
  # [input_motion]
  #   type = PiecewiseLinear
  #   data_file = '../ormsby_0_1_50_55_halfG.csv'
  #   format = columns
  # []
  [ormsby]
    type = OrmsbyWavelet
    f1 = 0.0
    f2 = 0.1
    f3 = 50.0
    f4 = 55.0
    ts = 0.25
    scale_factor = 4.905
  []
[]

[BCs]
  [./x_motion]
    type = PresetAcceleration
    # preset = true
    acceleration = accel_x
    velocity = vel_x
    variable = disp_x
    beta = 0.25
    boundary = 'bottom_surface'
    function = 'ormsby'
  [../]
  # [./x_motion]
  #   type = FunctionDirichletBC
  #   variable = disp_x
  #   boundary = 'bottom_surface'
  #   function = 'input_motion'
  #   preset = true
  # [../]
  [./fix_y]
    type = DirichletBC
    variable = disp_y
    boundary = 'bottom_surface'
    preset = true
    value = 0.0
  [../]
  [./fix_z]
    type = DirichletBC
    variable = disp_z
    boundary = 'bottom_surface'
    preset = true
    value = 0.0
  [../]
[]

[Preconditioning]
  [./smp]
    type = SMP
    full = true
  [../]
[]

# [VectorPostprocessors]
#   [./accel_hist]
#     type = ResponseHistoryBuilder
#     variables = 'accel_x'
#     nodes = '34579 34566 38419 37936 5073 5840 121 5252 2759 25805 25493 25182 24869 25541 25229 24917 24605 30946 31233'
#   [../]
#   [./accel_spec]
#     type = ResponseSpectraCalculator
#     vectorpostprocessor = accel_hist
#     regularize_dt = 0.002
#     damping_ratio = 0.05
#     start_frequency = 0.1
#     end_frequency = 100
#     outputs = out
#   [../]
# []

[Executioner]
  type = Transient
  petsc_options = '-ksp_snes_ew'
  petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
  petsc_options_value = 'lu       superlu_dist'
  solve_type = 'NEWTON'
  nl_rel_tol = 1e-10
  nl_abs_tol = 1e-8
  # l_tol = 1e-2
  dt = 0.0025
  end_time = 0.5
  timestep_tolerance = 1e-6
[]

[Postprocessors]

  [./SYY_0_Out_1]
    type = SideAverageValue
    variable = stress_yy
    boundary = '0_Out_1'
  [../]
  [./SYY_90_Out_1]
    type = SideAverageValue
    variable = stress_yy
    boundary = '90_Out_1'
  [../]
  [./SYY_180_Out_1]
    type = SideAverageValue
    variable = stress_yy
    boundary = '180_Out_1'
  [../]
  [./SYY_270_Out_1]
    type = SideAverageValue
    variable = stress_yy
    boundary = '270_Out_1'
  [../]
  [./SYY_0_In_1]
    type = SideAverageValue
    variable = stress_yy
    boundary = '0_In_1'
  [../]
  [./SYY_90_In_1]
    type = SideAverageValue
    variable = stress_yy
    boundary = '90_In_1'
  [../]
  [./SYY_180_In_1]
    type = SideAverageValue
    variable = stress_yy
    boundary = '180_In_1'
  [../]
  [./SYY_270_In_1]
    type = SideAverageValue
    variable = stress_yy
    boundary = '270_In_1'
  [../]

  [./SZZ_0_Out_1]
    type = SideAverageValue
    variable = stress_zz
    boundary = '0_Out_1'
  [../]
  [./SZZ_90_Out_1]
    type = SideAverageValue
    variable = stress_zz
    boundary = '90_Out_1'
  [../]
  [./SZZ_180_Out_1]
    type = SideAverageValue
    variable = stress_zz
    boundary = '180_Out_1'
  [../]
  [./SZZ_270_Out_1]
    type = SideAverageValue
    variable = stress_zz
    boundary = '270_Out_1'
  [../]
  [./SZZ_0_In_1]
    type = SideAverageValue
    variable = stress_zz
    boundary = '0_In_1'
  [../]
  [./SZZ_90_In_1]
    type = SideAverageValue
    variable = stress_zz
    boundary = '90_In_1'
  [../]
  [./SZZ_180_In_1]
    type = SideAverageValue
    variable = stress_zz
    boundary = '180_In_1'
  [../]
  [./SZZ_270_In_1]
    type = SideAverageValue
    variable = stress_zz
    boundary = '270_In_1'
  [../]

  [./MaxP_0_Out_1]
    type = SideAverageValue
    variable = maxP
    boundary = '0_Out_1'
  [../]
  [./MaxP_90_Out_1]
    type = SideAverageValue
    variable = maxP
    boundary = '90_Out_1'
  [../]
  [./MaxP_180_Out_1]
    type = SideAverageValue
    variable = maxP
    boundary = '180_Out_1'
  [../]
  [./MaxP_270_Out_1]
    type = SideAverageValue
    variable = maxP
    boundary = '270_Out_1'
  [../]
  [./MaxP_0_In_1]
    type = SideAverageValue
    variable = maxP
    boundary = '0_In_1'
  [../]
  [./MaxP_90_In_1]
    type = SideAverageValue
    variable = maxP
    boundary = '90_In_1'
  [../]
  [./MaxP_180_In_1]
    type = SideAverageValue
    variable = maxP
    boundary = '180_In_1'
  [../]
  [./MaxP_270_In_1]
    type = SideAverageValue
    variable = maxP
    boundary = '270_In_1'
  [../]

  [./MidP_0_Out_1]
    type = SideAverageValue
    variable = midP
    boundary = '0_Out_1'
  [../]
  [./MidP_90_Out_1]
    type = SideAverageValue
    variable = midP
    boundary = '90_Out_1'
  [../]
  [./MidP_180_Out_1]
    type = SideAverageValue
    variable = midP
    boundary = '180_Out_1'
  [../]
  [./MidP_270_Out_1]
    type = SideAverageValue
    variable = midP
    boundary = '270_Out_1'
  [../]
  [./MidP_0_In_1]
    type = SideAverageValue
    variable = midP
    boundary = '0_In_1'
  [../]
  [./MidP_90_In_1]
    type = SideAverageValue
    variable = midP
    boundary = '90_In_1'
  [../]
  [./MidP_180_In_1]
    type = SideAverageValue
    variable = midP
    boundary = '180_In_1'
  [../]
  [./MidP_270_In_1]
    type = SideAverageValue
    variable = midP
    boundary = '270_In_1'
  [../]

  [./MinP_0_Out_1]
    type = SideAverageValue
    variable = minP
    boundary = '0_Out_1'
  [../]
  [./MinP_90_Out_1]
    type = SideAverageValue
    variable = minP
    boundary = '90_Out_1'
  [../]
  [./MinP_180_Out_1]
    type = SideAverageValue
    variable = minP
    boundary = '180_Out_1'
  [../]
  [./MinP_270_Out_1]
    type = SideAverageValue
    variable = minP
    boundary = '270_Out_1'
  [../]
  [./MinP_0_In_1]
    type = SideAverageValue
    variable = minP
    boundary = '0_In_1'
  [../]
  [./MinP_90_In_1]
    type = SideAverageValue
    variable = minP
    boundary = '90_In_1'
  [../]
  [./MinP_180_In_1]
    type = SideAverageValue
    variable = minP
    boundary = '180_In_1'
  [../]
  [./MinP_270_In_1]
    type = SideAverageValue
    variable = minP
    boundary = '270_In_1'
  [../]

  [./VonM_0_Out_1]
    type = SideAverageValue
    variable = vonmises
    boundary = '0_Out_1'
  [../]
  [./VonM_90_Out_1]
    type = SideAverageValue
    variable = vonmises
    boundary = '90_Out_1'
  [../]
  [./VonM_180_Out_1]
    type = SideAverageValue
    variable = vonmises
    boundary = '180_Out_1'
  [../]
  [./VonM_270_Out_1]
    type = SideAverageValue
    variable = vonmises
    boundary = '270_Out_1'
  [../]
  [./VonM_0_In_1]
    type = SideAverageValue
    variable = vonmises
    boundary = '0_In_1'
  [../]
  [./VonM_90_In_1]
    type = SideAverageValue
    variable = vonmises
    boundary = '90_In_1'
  [../]
  [./VonM_180_In_1]
    type = SideAverageValue
    variable = vonmises
    boundary = '180_In_1'
  [../]
  [./VonM_270_In_1]
    type = SideAverageValue
    variable = vonmises
    boundary = '270_In_1'
  [../]

  # [./SYY_99]
  #   type = ElementAverageValue
  #   variable = stress_yy
  #   block = '99'
  # [../]
  # [./SZZ_99]
  #   type = ElementAverageValue
  #   variable = stress_zz
  #   block = '99'
  # [../]
  # [./MaxP_99]
  #   type = ElementAverageValue
  #   variable = maxP
  #   block = '99'
  # [../]
  # [./MinP_99]
  #   type = ElementAverageValue
  #   variable = minP
  #   block = '99'
  # [../]
  # [./MidP_99]
  #   type = ElementAverageValue
  #   variable = midP
  #   block = '99'
  # [../]
  #
  # [./SYY_98]
  #   type = ElementAverageValue
  #   variable = stress_yy
  #   block = '98'
  # [../]
  # [./SZZ_98]
  #   type = ElementAverageValue
  #   variable = stress_zz
  #   block = '98'
  # [../]
  # [./MaxP_98]
  #   type = ElementAverageValue
  #   variable = maxP
  #   block = '98'
  # [../]
  # [./MinP_98]
  #   type = ElementAverageValue
  #   variable = minP
  #   block = '98'
  # [../]
  # [./MidP_98]
  #   type = ElementAverageValue
  #   variable = midP
  #   block = '98'
  # [../]
  #
  # [./SYY_97]
  #   type = ElementAverageValue
  #   variable = stress_yy
  #   block = '97'
  # [../]
  # [./SZZ_97]
  #   type = ElementAverageValue
  #   variable = stress_zz
  #   block = '97'
  # [../]
  # [./MaxP_97]
  #   type = ElementAverageValue
  #   variable = maxP
  #   block = '97'
  # [../]
  # [./MinP_97]
  #   type = ElementAverageValue
  #   variable = minP
  #   block = '97'
  # [../]
  # [./MidP_97]
  #   type = ElementAverageValue
  #   variable = midP
  #   block = '97'
  # [../]
  #
  # [./SYY_96]
  #   type = ElementAverageValue
  #   variable = stress_yy
  #   block = '96'
  # [../]
  # [./SZZ_96]
  #   type = ElementAverageValue
  #   variable = stress_zz
  #   block = '96'
  # [../]
  # [./MaxP_96]
  #   type = ElementAverageValue
  #   variable = maxP
  #   block = '96'
  # [../]
  # [./MinP_96]
  #   type = ElementAverageValue
  #   variable = minP
  #   block = '96'
  # [../]
  # [./MidP_96]
  #   type = ElementAverageValue
  #   variable = midP
  #   block = '96'
  # [../]
  #
  # [./SYY_95]
  #   type = ElementAverageValue
  #   variable = stress_yy
  #   block = '95'
  # [../]
  # [./SZZ_95]
  #   type = ElementAverageValue
  #   variable = stress_zz
  #   block = '95'
  # [../]
  # [./MaxP_95]
  #   type = ElementAverageValue
  #   variable = maxP
  #   block = '95'
  # [../]
  # [./MinP_95]
  #   type = ElementAverageValue
  #   variable = minP
  #   block = '95'
  # [../]
  # [./MidP_95]
  #   type = ElementAverageValue
  #   variable = midP
  #   block = '95'
  # [../]
  #
  # [./SYY_94]
  #   type = ElementAverageValue
  #   variable = stress_yy
  #   block = '94'
  # [../]
  # [./SZZ_94]
  #   type = ElementAverageValue
  #   variable = stress_zz
  #   block = '94'
  # [../]
  # [./MaxP_94]
  #   type = ElementAverageValue
  #   variable = maxP
  #   block = '94'
  # [../]
  # [./MinP_94]
  #   type = ElementAverageValue
  #   variable = minP
  #   block = '94'
  # [../]
  # [./MidP_94]
  #   type = ElementAverageValue
  #   variable = midP
  #   block = '94'
  # [../]

  [./Moment_Out_y]
    type = SidesetMoment
    stress_direction = '0 0 1'
    stress_tensor = stress
    boundary = 'Top'
    reference_point = '-15.0 0.0 7.625'
    moment_direction = '0 1 0'
  [../]
  [./Moment_Out_x]
    type = SidesetMoment
    stress_direction = '0 0 1'
    stress_tensor = stress
    boundary = 'Top'
    reference_point = '-15.0 0.0 7.625'
    moment_direction = '1 0 0'
  [../]
  [./Moment_Out_z]
    type = SidesetMoment
    stress_direction = '0 0 1'
    stress_tensor = stress
    boundary = 'Top'
    reference_point = '-15.0 0.0 7.625'
    moment_direction = '0 0 1'
  [../]

[]

[VectorPostprocessors]
  [./accel_hist_x]
    type = ResponseHistoryBuilder
    variables = 'accel_x'
    # nodes = '26918 26847 26907 26889 26865 24060 24081 20555 18754 29852 30165 30483 30795'
    nodes = '52144 51279 71084 70273 68582 71070 50554 29363 28905 29203 28493 25808 25495 25183 24871'
    outputs = out1
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94
  [../]
  [./accel_spec_x]
    type = ResponseSpectraCalculator
    vectorpostprocessor = accel_hist_x
    regularize_dt = 0.001
    damping_ratio = 0.05
    start_frequency = 0.1
    end_frequency = 1000
    outputs = out1
  [../]

  [./accel_hist_y]
    type = ResponseHistoryBuilder
    variables = 'accel_y'
    # nodes = '26918 26847 26907 26889 26865 24060 24081 20555 18754 29852 30165 30483 30795'
    nodes = '52144 51279 71084 70273 68582 71070 50554 29363 28905 29203 28493 25808 25495 25183 24871'
    outputs = out1
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94
  [../]
  [./accel_spec_y]
    type = ResponseSpectraCalculator
    vectorpostprocessor = accel_hist_y
    regularize_dt = 0.001
    damping_ratio = 0.05
    start_frequency = 0.1
    end_frequency = 1000
    outputs = out1
  [../]

  [./accel_hist_z]
    type = ResponseHistoryBuilder
    variables = 'accel_z'
    # nodes = '26918 26847 26907 26889 26865 24060 24081 20555 18754 29852 30165 30483 30795'
    nodes = '52144 51279 71084 70273 68582 71070 50554 29363 28905 29203 28493 25808 25495 25183 24871'
    outputs = out1
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94
  [../]
  [./accel_spec_z]
    type = ResponseSpectraCalculator
    vectorpostprocessor = accel_hist_z
    regularize_dt = 0.001
    damping_ratio = 0.05
    start_frequency = 0.1
    end_frequency = 1000
    outputs = out1
  [../]
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
