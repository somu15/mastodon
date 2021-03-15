number = 2
namex = 'Eq_${fparse number}_Max.csv'
namey = 'Eq_${fparse number}_Min.csv'
namez = 'Eq_${fparse number}_V.csv'

dt1 = 0.01
dt_req = '${fparse dt1}'

end1 = 2.0
end_req = '${fparse end1}'

[Mesh]
  [mesh_gen]
    type = FileMeshGenerator
    file = Model.e
  []
  [subdomain_near]
    type = SubdomainBoundingBoxGenerator
    bottom_left = '-18.686781 3.676407 7.62500'
    top_right = '-11.323638 -3.686795 8.37500'
    location = INSIDE
    block_id = 99
    input = mesh_gen
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
[]

[Materials]
  [./elasticity_1]
    type = ComputeIsotropicElasticityTensor
    block = 'roof ext_buttresses ext_walls int_buttresses SG_bases int_wall int_slab RV_housing small_walls basemat'
    youngs_modulus = 24.8e9 # 14e9
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
    prop_values = 2400 #kg/m3
  [../]

  [./elasticity_2]
    type = ComputeIsotropicElasticityTensor
    block = 'RV SGs'
    youngs_modulus = 170e9 # 200e9
    poissons_ratio = 0.3 # 0.2
  [../]
  [./elasticity_3]
    type = ComputeIsotropicElasticityTensor
    block = '99'
    youngs_modulus = 170e12 # 200e9
    poissons_ratio = 0.3 # 0.2
  [../]
  [./strain_2]
    type = ComputeSmallStrain
    block = 'RV SGs 99'
  [../]
  [./stress_2]
    type = ComputeLinearElasticStress
    block = 'RV SGs 99'
  [../]
  [./den_rv]
    type = GenericConstantMaterial
    block = 'RV 99'
    prop_names = density
    prop_values = 7850 # 2546.5 #kg/m3
  [../]
  [./den_sg]
    type = GenericConstantMaterial
    block = 'SGs'
    prop_names = density
    prop_values = 7850 # 5052.5 #kg/m3
  [../]
[]

[Functions]
  [./accel_x]
    type = PiecewiseLinear
    data_file = 'GMs/${namex}'
    scale_factor = 9.81
    format = 'columns'
  [../]
  [./accel_y]
    type = PiecewiseLinear
    data_file = 'GMs/${namey}'
    scale_factor = 9.81
    format = 'columns'
  [../]
  [./accel_z]
    type = PiecewiseLinear
    data_file = 'GMs/${namez}'
    scale_factor = 9.81
    format = 'columns'
  [../]
[]

[BCs]
  # [./x_motion]
  #   type = PresetAcceleration
  #   # preset = true
  #   acceleration = accel_x
  #   velocity = vel_x
  #   variable = disp_x
  #   beta = 0.25
  #   boundary = 'bottom_surface'
  #   function = 'ormsby'
  # [../]
  [./x_motion]
    type = PresetAcceleration
    acceleration = accel_x
    velocity = vel_x
    variable = disp_x
    beta = 0.25
    boundary = 'bottom_surface'
    function = 'accel_x'
  [../]
  [./y_motion]
    type = PresetAcceleration
    acceleration = accel_y
    velocity = vel_y
    variable = disp_y
    beta = 0.25
    boundary = 'bottom_surface'
    function = 'accel_y'
  [../]
  [./z_motion]
    type = PresetAcceleration
    acceleration = accel_z
    velocity = vel_z
    variable = disp_z
    beta = 0.25
    boundary = 'bottom_surface'
    function = 'accel_z'
  [../]
  # [./fix_y]
  #   type = DirichletBC
  #   variable = disp_y
  #   boundary = 'bottom_surface'
  #   preset = true
  #   value = 0.0
  # [../]
  # [./fix_z]
  #   type = DirichletBC
  #   variable = disp_z
  #   boundary = 'bottom_surface'
  #   preset = true
  #   value = 0.0
  # [../]
[]

[Preconditioning]
  [./smp]
    type = SMP
    full = true
  [../]
[]

[VectorPostprocessors]
  [./accel_hist_x]
    type = ResponseHistoryBuilder
    variables = 'accel_x'
    nodes = '30771 30789 30732 30755 30780 30795 30748 30763'
  [../]
  [./accel_spec_x]
    type = ResponseSpectraCalculator
    vectorpostprocessor = accel_hist_x
    regularize_dt = 0.002
    damping_ratio = 0.05
    start_frequency = 0.1
    end_frequency = 100
    outputs = out
  [../]
  [./accel_hist_y]
    type = ResponseHistoryBuilder
    variables = 'accel_y'
    nodes = '30771 30789 30732 30755 30780 30795 30748 30763'
  [../]
  [./accel_spec_y]
    type = ResponseSpectraCalculator
    vectorpostprocessor = accel_hist_y
    regularize_dt = 0.002
    damping_ratio = 0.05
    start_frequency = 0.1
    end_frequency = 100
    outputs = out
  [../]
  [./accel_hist_z]
    type = ResponseHistoryBuilder
    variables = 'accel_z'
    nodes = '30771 30789 30732 30755 30780 30795 30748 30763'
  [../]
  [./accel_spec_z]
    type = ResponseSpectraCalculator
    vectorpostprocessor = accel_hist_z
    regularize_dt = 0.002
    damping_ratio = 0.05
    start_frequency = 0.1
    end_frequency = 100
    outputs = out
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
  end_time = ${end_req}
  dt = ${dt_req}
  timestep_tolerance = 1e-6
[]

[Controls]
  [stochastic]
    type = SamplerReceiver
  []
[]

[Outputs]
  exodus = true
  perf_graph = true
  [./out]
    type = CSV
    execute_on = 'final'
  [../]
[]
