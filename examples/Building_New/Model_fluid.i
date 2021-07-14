[Mesh]
  [mesh_gen]
    type = FileMeshGenerator
    file = structure_1_solids_merged_RV.e
  []
  [./interface1]
    type = SideSetsBetweenSubdomainsGenerator
    input = mesh_gen
    primary_block = 'RV'
    paired_block = 'fluid_material'
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
      block = 'RV RV_slab' # 99 98 97 96 95 94
      mark = REFINE
    []
  []
[]

[Variables]
  [./disp_x]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' #' # 99 98 97 96 95 94'
    order = FIRST
    family = LAGRANGE
  [../]
  [./disp_y]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    order = FIRST
    family = LAGRANGE
  [../]
  [./disp_z]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    order = FIRST
    family = LAGRANGE
  [../]
  [./p]
    block = 'fluid_material'
  [../]
[]

[AuxVariables]
  [./Wave1]
    block = 'fluid_material'
  [../]
  [./vel_x]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
  [../]
  [./accel_x]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
  [../]
  [./vel_y]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
  [../]
  [./accel_y]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
  [../]
  [./vel_z]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
  [../]
  [./accel_z]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
  [../]
  [./stress_xy]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_yz]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_zx]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_xy]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_yz]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_zx]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_xx]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_yy]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_zz]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_xx]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_yy]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_zz]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./vonmises]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    order = FIRST
    family = MONOMIAL
  [../]
  [./maxP]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    order = FIRST
    family = MONOMIAL
  [../]
  [./midP]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    order = FIRST
    family = MONOMIAL
  [../]
  [./minP]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    order = FIRST
    family = MONOMIAL
  [../]
  [./vonM]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    order = FIRST
    family = MONOMIAL
  [../]
[]

[Kernels]
  [./diffusion]
    type = Diffusion
    variable = 'p'
    block = 'fluid_material'
    use_displaced_mesh = false
  [../]
  [./inertia]
    type = AcousticInertia
    variable = p
    block = 'fluid_material'
    use_displaced_mesh = false
  [../]
  [./DynamicTensorMechanics]
    zeta = 0.00006366
    displacements = 'disp_x disp_y disp_z'
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
  [../]
  [./inertia_x]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    type = InertialForce
    variable = disp_x
    eta = 7.854
  [../]
  [./inertia_y]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    type = InertialForce
    variable = disp_y
    eta = 7.854
  [../]
  [./inertia_z]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    type = InertialForce
    variable = disp_z
    eta = 7.854
  [../]
  # [./gravity]
  #   type = Gravity
  #   variable = disp_z
  #   value = -9.81
  #   block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab'
  # [../]
[]

[AuxKernels]
  [./accel_x]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    type = TestNewmarkTI
    displacement = disp_x
    variable = accel_x
    first = false
  [../]
  [./vel_x]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    type = TestNewmarkTI
    displacement = disp_x
    variable = vel_x
  [../]
  [./accel_y]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    type = TestNewmarkTI
    displacement = disp_y
    variable = accel_y
    first = false
  [../]
  [./vel_y]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    type = TestNewmarkTI
    displacement = disp_y
    variable = vel_y
  [../]
  [./accel_z]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    type = TestNewmarkTI
    displacement = disp_z
    variable = accel_z
    first = false
  [../]
  [./vel_z]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    type = TestNewmarkTI
    displacement = disp_z
    variable = vel_z
  [../]
  [./stress_xy]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xy
    index_i = 1
    index_j = 0
  [../]
  [./stress_yz]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_yz
    index_i = 2
    index_j = 1
  [../]
  [./stress_zx]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_zx
    index_i = 0
    index_j = 2
  [../]
  [./strain_xy]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = stress_xy
    index_i = 1
    index_j = 0
  [../]
  [./strain_yz]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = strain_yz
    index_i = 2
    index_j = 1
  [../]
  [./strain_zx]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = strain_zx
    index_i = 0
    index_j = 2
  [../]
  [./stress_xx]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xx
    index_i = 0
    index_j = 0
  [../]
  [./stress_yy]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_yy
    index_i = 1
    index_j = 1
  [../]
  [./stress_zz]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_zz
    index_i = 2
    index_j = 2
  [../]
  [./strain_xx]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = strain_xx
    index_i = 0
    index_j = 0
  [../]
  [./strain_yy]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = strain_yy
    index_i = 1
    index_j = 1
  [../]
  [./strain_zz]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = strain_zz
    index_i = 2
    index_j = 2
  [../]
  [./vonmises]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    type = RankTwoScalarAux
    rank_two_tensor = stress
    variable = vonmises
    scalar_type = VonMisesStress
    execute_on = timestep_end
  [../]
  [./maxP]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    type = RankTwoScalarAux
    rank_two_tensor = stress
    variable = maxP
    scalar_type = MaxPrincipal
    execute_on = timestep_end
  [../]
  [./minP]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    type = RankTwoScalarAux
    rank_two_tensor = stress
    variable = minP
    scalar_type = MinPrincipal
    execute_on = timestep_end
  [../]
  [./midP]
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
    type = RankTwoScalarAux
    rank_two_tensor = stress
    variable = midP
    scalar_type = MidPrincipal
    execute_on = timestep_end
  [../]
  [./waves]
    type = WaveHeightAuxKernel
    variable = 'Wave1'
    pressure = p
    density = 1e-6
    gravity = 9.81
    execute_on = timestep_end
    block = 'fluid_material'
  [../]
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

[Materials]
  [./elasticity_1]
    type = ComputeIsotropicElasticityTensor
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat'
    youngs_modulus = 24.8
    poissons_ratio = 0.2
  [../]
  [./strain_1]
    type = ComputeSmallStrain
    displacements = 'disp_x disp_y disp_z'
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
    prop_values = 2.4e-6 #kg/m3
  [../]

  [./elasticity_2]
    type = ComputeIsotropicElasticityTensor
    block = 'RV SGs RV_slab' # 99 98 97 96 95 94'
    youngs_modulus = 170
    poissons_ratio = 0.3
  [../]
  [./strain_2]
    type = ComputeSmallStrain
    displacements = 'disp_x disp_y disp_z'
    block = 'RV SGs RV_slab' # 99 98 97 96 95 94'
  [../]
  [./stress_2]
    type = ComputeLinearElasticStress
    block = 'RV SGs RV_slab' # 99 98 97 96 95 94'
  [../]

  [./den_rv]
    type = GenericConstantMaterial
    block = 'RV RV_slab' # 99 98 97 96 95 94'
    prop_names = density
    prop_values = 7.85e-6 #kg/m3
  [../]
  [./den_sg]
    type = GenericConstantMaterial
    block = 'SGs'
    prop_names = density
    prop_values = 7.85e-6 #kg/m3
  [../]

  [./density_fluid]
    type = GenericConstantMaterial
    prop_names = inv_co_sq
    prop_values = 4.65e-7
    block = 'fluid_material'
  [../]
  [./dens2]
    type = GenericConstantMaterial
    block = 'fluid_material'
    prop_names = density
    prop_values = 1e-6
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
  [./free]
    type = FluidFreeSurfaceBC
    variable = p
    boundary = 'Fluid_top'
  []
[]

[Preconditioning]
  [./smp]
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
  nl_rel_tol = 1e-10
  nl_abs_tol = 1e-8
  # l_tol = 1e-2
  dt = 0.0025
  end_time = 0.5
  timestep_tolerance = 1e-6
  [TimeIntegrator]
    type = NewmarkBeta
    beta = 0.25 # 0.3025
    gamma = 0.5 # 0.6
  []
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

  [./Wave1]
    type = PointValue
    point = '-17.235 0.0 6.655'
    variable = Wave1
  [../]
  [./Wave2]
    type = PointValue
    point = '-16.337652 0.00157 6.655'
    variable = Wave1
  [../]
  [./Wave3]
    type = PointValue
    point = '-15.0 0.0 6.655'
    variable = Wave1
  [../]
  [./Wave4]
    type = PointValue
    point = '-13.662403 -0.0011 6.655'
    variable = Wave1
  [../]
  [./Wave5]
    type = PointValue
    point = '-12.765 0.0 6.655'
    variable = Wave1
  [../]

  [p1_n]
    type = PointValue
    point = '-17.48 0.0 6.655'
    variable = p
  []
  [p2_n]
    type = PointValue
    point = '-17.48 0.0 5.855'
    variable = p
  []
  [p3_n]
    type = PointValue
    point = '-17.48 0.0 5.255'
    variable = p
  []
  [p4_n]
    type = PointValue
    point = '-17.48 0.0 4.455'
    variable = p
  []
  [p5_n]
    type = PointValue
    point = '-17.48 0.0 3.655'
    variable = p
  []
  [p6_n]
    type = PointValue
    point = '-17.48 0.0 2.855'
    variable = p
  []

  [p1_p]
    type = PointValue
    point = '-12.52 0.0 6.655'
    variable = p
  []
  [p2_p]
    type = PointValue
    point = '-12.52 0.0 5.855'
    variable = p
  []
  [p3_p]
    type = PointValue
    point = '-12.52 0.0 5.255'
    variable = p
  []
  [p4_p]
    type = PointValue
    point = '-12.52 0.0 4.455'
    variable = p
  []
  [p5_p]
    type = PointValue
    point = '-12.52 0.0 3.655'
    variable = p
  []
  [p6_p]
    type = PointValue
    point = '-12.52 0.0 2.855'
    variable = p
  []

[]

[VectorPostprocessors]
  [./accel_hist_x]
    type = ResponseHistoryBuilder
    variables = 'accel_x'
    # nodes = '52144 51279 71084 70273 68582 71070 50554 29363 28905 29203 28493 25808 25495 25183 24871'
    nodes = '71386 28493 29363 29203 28905 51462 31249'
    outputs = out1
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
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
    # nodes = '52144 51279 71084 70273 68582 71070 50554 29363 28905 29203 28493 25808 25495 25183 24871'
    nodes = '71386 28493 29363 29203 28905 51462 31249'
    outputs = out1
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
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
    # nodes = '52144 51279 71084 70273 68582 71070 50554 29363 28905 29203 28493 25808 25495 25183 24871'
    nodes = '71386 28493 29363 29203 28905 51462 31249'
    outputs = out1
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat RV SGs RV_slab' # 99 98 97 96 95 94'
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
