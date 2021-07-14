[Mesh]
  [mesh_gen]
    type = FileMeshGenerator
    file = Basemat_Isolators.e
  []
  displacements = 'disp_x disp_y disp_z'
[]

# [GlobalParams]
#   use_displaced_mesh = TRUE
# []

# [Controls]
#   [./inertia_switch]
#     type = TimePeriod
#     start_time = 0.9
#     end_time = 1.0
#     disable_objects = '*/inertia_x */inertia_y */inertia_z */vel_x */vel_y */vel_y  */accel_x */accel_y */accel_z'
#     set_sync_times = true
#     execute_on = 'timestep_begin timestep_end'
#   [../]
# []

[Variables]
  [./disp_x]
    block = 'basemat rigid_elems isolator_elems'
    order = FIRST
    family = LAGRANGE
  [../]
  [./disp_y]
    block = 'basemat rigid_elems isolator_elems'
    order = FIRST
    family = LAGRANGE
  [../]
  [./disp_z]
    block = 'basemat rigid_elems isolator_elems'
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_x]
    block = 'rigid_elems isolator_elems'
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_y]
    block = 'rigid_elems isolator_elems'
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_z]
    block = 'rigid_elems isolator_elems'
    order = FIRST
    family = LAGRANGE
  [../]
[]

[AuxVariables]
  [./vel_x]
    block = 'basemat rigid_elems isolator_elems'
  [../]
  [./accel_x]
    block = 'basemat rigid_elems isolator_elems'
  [../]
  [./vel_y]
    block = 'basemat rigid_elems isolator_elems'
  [../]
  [./accel_y]
    block = 'basemat rigid_elems isolator_elems'
  [../]
  [./vel_z]
    block = 'basemat rigid_elems isolator_elems'
  [../]
  [./accel_z]
    block = 'basemat rigid_elems isolator_elems'
  [../]
  [./stress_xy]
    block = 'basemat'
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_yz]
    block = 'basemat'
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_zx]
    block = 'basemat'
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_xy]
    block = 'basemat'
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_yz]
    block = 'basemat'
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_zx]
    block = 'basemat'
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_xx]
    block = 'basemat'
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_yy]
    block = 'basemat'
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_zz]
    block = 'basemat'
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_xx]
    block = 'basemat'
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_yy]
    block = 'basemat'
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_zz]
    block = 'basemat'
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./rot_vel_x]
    block = 'rigid_elems isolator_elems'
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_vel_y]
    block = 'rigid_elems isolator_elems'
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_vel_z]
    block = 'rigid_elems isolator_elems'
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_accel_x]
    block = 'rigid_elems isolator_elems'
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_accel_y]
    block = 'rigid_elems isolator_elems'
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_accel_z]
    block = 'rigid_elems isolator_elems'
    order = FIRST
    family = LAGRANGE
  [../]
  [./reaction_x]
    block = 'isolator_elems'
  [../]
  [./reaction_y]
    block = 'isolator_elems'
  [../]
  [./reaction_z]
    block = 'isolator_elems'
  [../]
  [./reaction_xx]
    block = 'isolator_elems'
  [../]
  [./reaction_yy]
    block = 'isolator_elems'
  [../]
  [./reaction_zz]
    block = 'isolator_elems'
  [../]
[]

[Modules/TensorMechanics/LineElementMaster]
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'

    # dynamic simulation using consistent mass/inertia matrix
    dynamic_nodal_translational_inertia = true

    velocities = 'vel_x vel_y vel_z'
    accelerations = 'accel_x accel_y accel_z'
    rotational_velocities = 'rot_vel_x rot_vel_y rot_vel_z'
    rotational_accelerations = 'rot_accel_x rot_accel_y rot_accel_z'

    # beta = 0.25 # Newmark time integration parameter
    # gamma = 0.5 # Newmark time integration parameter

    # beta = 0.4225
    # gamma = 0.8
    # alpha = -0.3

    beta = 0.3025
    gamma = 0.6
    alpha = -0.1

    [./block_16]
      block = 'rigid_elems'
      area = 130.06
      Iy = 24166.729
      Iz = 24166.729
      y_orientation = '0.0 0.0 1.0'

      nodal_mass = 1e-10
      boundary = top_isolators
    [../]
[]

[Kernels]
  [./DynamicTensorMechanics]
    zeta = 0.00006366
    alpha = -0.1
    displacements = 'disp_x disp_y disp_z'
    block = 'basemat'
  [../]
  [./inertia_x]
    block = 'basemat'
    type = InertialForce
    variable = disp_x
    eta = 7.854
  [../]
  [./inertia_y]
    block = 'basemat'
    type = InertialForce
    variable = disp_y
    eta = 7.854
  [../]
  [./inertia_z]
    block = 'basemat'
    type = InertialForce
    variable = disp_z
    eta = 7.854
  [../]
  # [./gravity]
  #   type = Gravity
  #   variable = disp_z
  #   value = -9.81
  #   block = 'basemat'
  # [../]
  [./lr_disp_x]
    block = 'isolator_elems'
    type = StressDivergenceIsolator
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    component = 0
    variable = disp_x
    save_in = reaction_x
  [../]
  [./lr_disp_y]
    block = 'isolator_elems'
    type = StressDivergenceIsolator
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    component = 1
    variable = disp_y
    save_in = reaction_y
  [../]
  [./lr_disp_z]
    block = 'isolator_elems'
    type = StressDivergenceIsolator
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    component = 2
    variable = disp_z
    save_in = reaction_z
  [../]
  [./lr_rot_x]
    block = 'isolator_elems'
    type = StressDivergenceIsolator
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    component = 3
    variable = rot_x
    save_in = reaction_xx
  [../]
  [./lr_rot_y]
    block = 'isolator_elems'
    type = StressDivergenceIsolator
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    component = 4
    variable = rot_y
    save_in = reaction_yy
  [../]
  [./lr_rot_z]
    block = 'isolator_elems'
    type = StressDivergenceIsolator
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    component = 5
    variable = rot_z
    save_in = reaction_zz
  [../]
[]

[NodalKernels]
  [./force_x]
    type = UserForcingFunctionNodalKernel
    variable = disp_z
    boundary = 'top_isolators'
    function = force_z
  [../]
[]

[AuxKernels]
  [./accel_x]
    block = 'basemat isolator_elems rigid_elems' # 99 98 97 96 95 94'
    type = TestNewmarkTI
    displacement = disp_x
    variable = accel_x
    first = false
  [../]
  [./vel_x]
    block = 'basemat isolator_elems rigid_elems' # 99 98 97 96 95 94'
    type = TestNewmarkTI
    displacement = disp_x
    variable = vel_x
  [../]
  [./accel_y]
    block = 'basemat isolator_elems rigid_elems' # 99 98 97 96 95 94'
    type = TestNewmarkTI
    displacement = disp_y
    variable = accel_y
    first = false
  [../]
  [./vel_y]
    block = 'basemat isolator_elems rigid_elems' # 99 98 97 96 95 94'
    type = TestNewmarkTI
    displacement = disp_y
    variable = vel_y
  [../]
  [./accel_z]
    block = 'basemat isolator_elems rigid_elems' # 99 98 97 96 95 94'
    type = TestNewmarkTI
    displacement = disp_z
    variable = accel_z
    first = false
  [../]
  [./vel_z]
    block = 'basemat isolator_elems rigid_elems' # 99 98 97 96 95 94'
    type = TestNewmarkTI
    displacement = disp_z
    variable = vel_z
  [../]
  [./stress_xy]
    block = 'basemat' # 99 98 97 96 95 94'
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xy
    index_i = 1
    index_j = 0
  [../]
  [./stress_yz]
    block = 'basemat' # 99 98 97 96 95 94'
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_yz
    index_i = 2
    index_j = 1
  [../]
  [./stress_zx]
    block = 'basemat' # 99 98 97 96 95 94'
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_zx
    index_i = 0
    index_j = 2
  [../]
  [./strain_xy]
    block = 'basemat' # 99 98 97 96 95 94'
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = stress_xy
    index_i = 1
    index_j = 0
  [../]
  [./strain_yz]
    block = 'basemat' # 99 98 97 96 95 94'
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = strain_yz
    index_i = 2
    index_j = 1
  [../]
  [./strain_zx]
    block = 'basemat' # 99 98 97 96 95 94'
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = strain_zx
    index_i = 0
    index_j = 2
  [../]
  [./stress_xx]
    block = 'basemat' # 99 98 97 96 95 94'
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xx
    index_i = 0
    index_j = 0
  [../]
  [./stress_yy]
    block = 'basemat' # 99 98 97 96 95 94'
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_yy
    index_i = 1
    index_j = 1
  [../]
  [./stress_zz]
    block = 'basemat' # 99 98 97 96 95 94'
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_zz
    index_i = 2
    index_j = 2
  [../]
  [./strain_xx]
    block = 'basemat' # 99 98 97 96 95 94'
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = strain_xx
    index_i = 0
    index_j = 0
  [../]
  [./strain_yy]
    block = 'basemat' # 99 98 97 96 95 94'
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = strain_yy
    index_i = 1
    index_j = 1
  [../]
  [./strain_zz]
    block = 'basemat' # 99 98 97 96 95 94'
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = strain_zz
    index_i = 2
    index_j = 2
  [../]
  [./rot_accel_x]
    block = 'isolator_elems'
    type = TestNewmarkTI
    displacement = rot_x
    variable = rot_accel_x
    first = false
  [../]
  [./rot_vel_x]
    block = 'isolator_elems'
    type = TestNewmarkTI
    displacement = rot_x
    variable = rot_vel_x
  [../]
  [./rot_accel_y]
    block = 'isolator_elems'
    type = TestNewmarkTI
    displacement = rot_y
    variable = rot_accel_y
    first = false
  [../]
  [./rot_vel_y]
    block = 'isolator_elems'
    type = TestNewmarkTI
    displacement = rot_y
    variable = rot_vel_y
  [../]
  [./rot_accel_z]
    block = 'isolator_elems'
    type = TestNewmarkTI
    displacement = rot_z
    variable = rot_accel_z
    first = false
  [../]
  [./rot_vel_z]
    block = 'isolator_elems'
    type = TestNewmarkTI
    displacement = rot_z
    variable = rot_vel_z
  [../]
[]

[Functions]
  [force_z]
    type = PiecewiseLinear
    x='0.99 1.0 150.0'
    # y='0.0 -1e-5 -1e-5'
    y='0.0 -0.0106 -0.0106'
  []
  [ormsby]
    type = OrmsbyWavelet
    f1 = 0.0
    f2 = 5.0 # 0.1
    f3 = 50.0
    f4 = 55.0
    ts = 0.25 # 0.25
    scale_factor = 1.0 # 4.905
  []
  [./accel_bottom]
    type = PiecewiseLinear
    data_file = Sine.csv
    format = 'columns'
    scale_factor = 0.01 # 1.962
  [../]
[]

[Materials]
  [./elasticity_1]
    type = ComputeIsotropicElasticityTensor
    block = 'basemat'
    youngs_modulus = 24.8 # 2e6 # 24.8
    poissons_ratio = 0.2
  [../]
  [./strain_1]
    type = ComputeSmallStrain
    displacements = 'disp_x disp_y disp_z'
    block = 'basemat'
  [../]
  [./stress_1]
    type = ComputeLinearElasticStress
    block = 'basemat'
  [../]
  [./den_1]
    type = GenericConstantMaterial
    block = 'basemat'
    prop_names = density
    prop_values = 1.39e-5 # 0.0252 #
  [../]
  [./elasticity_beam_rigid]
    type = ComputeElasticityBeam
    youngs_modulus = 2e4
    poissons_ratio = 0.27
    shear_coefficient = 0.85
    block = 'rigid_elems'
  [../]
  [./stress_beam]
    type = ComputeBeamResultants
    block = 'rigid_elems'
  [../]
  [./deformation]
    type = ComputeIsolatorDeformation
    sd_ratio = 0.5
    y_orientation = '1.0 0.0 0.0'
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'
    velocities = 'vel_x vel_y vel_z'
    block = 'isolator_elems'
  [../]
  [./elasticity]
    type = ComputeFPIsolatorElasticity
    mu_ref = 0.07 # 0.05
    p_ref = 0.05 # 50e6
    block = 'isolator_elems'
    diffusivity = 4.4e-6
    conductivity = 18
    a = 100
    r_eff = 2.23 # 4.0
    r_contact = 0.5 # 0.2
    uy = 0.001
    unit = 9
    # beta = 0.25
    # gamma = 0.5
    beta = 0.3025
    gamma = 0.6
    # beta = 0.4225
    # gamma = 0.8
    pressure_dependent = false
    temperature_dependent = false
    velocity_dependent = false
    k_x = 7e3 # 78.53 # 7.853e10
    k_xx = 0.62e3 # 0.62282 # 622820743.6
    k_yy = 0.311e3 # 0.3114 # 311410371.8
    k_zz = 0.311e3 # 0.3114 # 311410371.8
  [../]
[]

[BCs]
  [./x_motion]
    # type = PresetAcceleration
    # # preset = true
    # acceleration = accel_x
    # velocity = vel_x
    # variable = disp_x
    # beta = 0.25
    # boundary = 'bottom_isolators'
    # function = 'accel_bottom' # ormsby
    type = FunctionDirichletBC
    variable = disp_x
    boundary = 'bottom_isolators'
    function = 'accel_bottom'
    preset = true
  [../]
  [./fix_y]
    type = DirichletBC
    variable = disp_y
    boundary = 'bottom_isolators'
    preset = true
    value = 0.0
  [../]
  [./fix_z]
    type = DirichletBC
    variable = disp_z
    boundary = 'bottom_isolators'
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

[Executioner]
  type = Transient
  petsc_options = '-ksp_snes_ew'
  petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
  petsc_options_value = 'lu       superlu_dist'
  solve_type = 'NEWTON' # 'PJFNK'#
  nl_rel_tol = 1e-4 # 1e-9 #
  nl_abs_tol = 1e-10 # 1e-9 #
  start_time = 0.99
  dt = 0.005 # 0.0025
  end_time = 1.4 # 0.5
  timestep_tolerance = 1e-6
  automatic_scaling = true
  # l_max_its = 25
  [TimeIntegrator]
    type = NewmarkBeta
    beta = 0.3025
    gamma = 0.6
    # beta = 0.25
    # gamma = 0.5
    # beta = 0.4225
    # gamma = 0.8
  []
[]

[Postprocessors]

  [./Iso1_Bot_ReacX]
    type = PointValue
    point = '5.0 0.0 -1.3' # '-15.0 -2.85 8.375'
    variable = reaction_x
  [../]
  [./Iso1_Bot_DispX]
    type = PointValue
    point = '5.0 0.0 -1.3' # '-15.0 -2.85 8.375'
    variable = disp_x
  [../]
  [./Iso1_Top_ReacX]
    type = PointValue
    point = '5.0 0.0 -1.0' # '-15.0 -3.010056 8.675'
    variable = reaction_x
  [../]
  [./Iso1_Top_DispX]
    type = PointValue
    point = '5.0 0.0 -1.0' # '-15.0 -3.010056 8.675'
    variable = disp_x
  [../]

  [./App_acc_x]
    type = PointValue
    point = '5.0 0.0 -1.3' # '-15.0 -3.010056 8.675'
    variable = accel_x
  [../]

  [./Top_acc_x]
    type = PointValue
    point = '5.0 0.0 0.0' # '-15.0 -3.010056 8.675'
    variable = accel_x
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
