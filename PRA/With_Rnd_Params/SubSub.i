[Mesh]
  type = FileMesh
  file = foundbeam_noded.e
[]

[Variables]
  [./disp_x]
  [../]
  [./disp_y]
  [../]
  [./disp_z]
  [../]
  [./rot_x]
    block = '1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16'
  [../]
  [./rot_y]
    block = '1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16'
  [../]
  [./rot_z]
    block = '1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16'
  [../]
[]

[AuxVariables]
  [./vel_x]
  [../]
  [./vel_y]
  [../]
  [./vel_z]
  [../]
  [./accel_x]
  [../]
  [./accel_y]
  [../]
  [./accel_z]
  [../]
  [./rot_vel_x]
    block = '1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16'
  [../]
  [./rot_vel_y]
    block = '1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16'
  [../]
  [./rot_vel_z]
    block = '1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16'
  [../]
  [./rot_accel_x]
    block = '1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16'
  [../]
  [./rot_accel_y]
    block = '1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16'
  [../]
  [./rot_accel_z]
    block = '1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16'
  [../]
[]


[Kernels]
  [./DynamicTensorMechanics]
    displacements = 'disp_x disp_y disp_z'
    zeta = 'zeta_rayleigh' # stiffness proportional damping
    block = 15
  [../]
  [./inertia_x]
    type = InertialForce
    variable = disp_x
    velocity = vel_x
    acceleration = accel_x
    beta = 0.25
    gamma = 0.5
    eta = 'eta_rayleigh' # Mass proportional Rayleigh damping
    block = 15
  [../]
  [./inertia_y]
    type = InertialForce
    variable = disp_y
    velocity = vel_y
    acceleration = accel_y
    beta = 0.25
    gamma = 0.5
    eta = 'eta_rayleigh' # Mass proportional Rayleigh damping
    block = 15
  [../]
  [./inertia_z]
    type = InertialForce
    variable = disp_z
    velocity = vel_z
    acceleration = accel_z
    beta = 0.25
    gamma = 0.5
    eta = 'eta_rayleigh' # Mass proportional Rayleigh damping
    block = 15
  [../]
[]

[AuxKernels]
  [./accel_x]
    type = NewmarkAccelAux
    variable = accel_x
    displacement = disp_x
    velocity = vel_x
    beta = 0.25
    execute_on = 'timestep_end'
  [../]
  [./vel_x]
    type = NewmarkVelAux
    variable = vel_x
    acceleration = accel_x
    gamma = 0.5
    execute_on = 'timestep_end'
  [../]
  [./accel_y]
    type = NewmarkAccelAux
    variable = accel_y
    displacement = disp_y
    velocity = vel_y
    beta = 0.25
    execute_on = 'timestep_end'
  [../]
  [./vel_y]
    type = NewmarkVelAux
    variable = vel_y
    acceleration = accel_y
    gamma = 0.5
    execute_on = 'timestep_end'
  [../]
  [./accel_z]
    type = NewmarkAccelAux
    variable = accel_z
    displacement = disp_z
    velocity = vel_z
    beta = 0.25
    execute_on = 'timestep_end'
  [../]
  [./vel_z]
    type = NewmarkVelAux
    variable = vel_z
    acceleration = accel_z
    gamma = 0.5
    execute_on = 'timestep_end'
  [../]
[]

[Modules/TensorMechanics/LineElementMaster]
#    add_variables = true
    displacements = 'disp_x disp_y disp_z'
    rotations = 'rot_x rot_y rot_z'

    # dynamic simulation using consistent mass/inertia matrix
    dynamic_nodal_translational_inertia = true

    velocities = 'vel_x vel_y vel_z'
    accelerations = 'accel_x accel_y accel_z'
    rotational_velocities = 'rot_vel_x rot_vel_y rot_vel_z'
    rotational_accelerations = 'rot_accel_x rot_accel_y rot_accel_z'

    beta = 0.25 # Newmark time integration parameter
    gamma = 0.5 # Newmark time integration parameter

    # parameters for 5% Rayleigh damping
    # zeta = 'zeta_rayleigh' # stiffness proportional damping
    # eta = 'eta_rayleigh' # Mass proportional Rayleigh damping
  [./block_1]
    block = 1
    area = 1400
    Iy = 2.8e6
    Iz = 2.8e6
    y_orientation = '0.0 1.0 0.0'

    nodal_mass = 142.860001
    boundary = 1 # vertex 2
  [../]
  [./block_2]
    block = 2
    area = 1400
    Iy = 2.8e6
    Iz = 2.8e6
    y_orientation = '0.0 1.0 0.0'

    nodal_mass = 130.429993
    boundary = 2 # vertex 4, 6, 8, 10, 12
  [../]
  [./block_3]
    block = 3
    area = 1400
    Iy = 2.8e6
    Iz = 2.8e6
    y_orientation = '0.0 1.0 0.0'

    nodal_mass = 143.169998
    boundary = 3 # vertex 12
  [../]
  [./block_4]
    block = 4
    area = 990
    Iy = 1.9e6
    Iz = 1.9e6
    y_orientation = '0.0 1.0 0.0'

    nodal_mass = 93.79000092
    boundary = 4 # vertex 14
  [../]
  [./block_5]
    block = 5
    area = 990
    Iy = 1.5e6
    Iz = 1.5e6
    y_orientation = '0.0 1.0 0.0'

    nodal_mass = 76.70999908
    boundary = 5 # vertex 16
  [../]
  [./block_6]
    block = 6
    area = 990
    Iy = 8e5
    Iz = 8e5
    y_orientation = '0.0 1.0 0.0'

    nodal_mass = 65.83999634
    boundary = 6 # vertex 18
  [../]
  [./block_7]
    block = 7
    area = 990
    Iy = 2e5
    Iz = 2e5
    y_orientation = '0.0 1.0 0.0'

    nodal_mass = 5.90000010
    boundary = 7 # vertex 20
  [../]
  # right
  [./block_8]
    block = 8
    area = 2000
    Iy = 1.1e6
    Iz = 1.1e6
    y_orientation = '0.0 1.0 0.0'

    nodal_mass = 86.95999908
    boundary = 8 # vertex 22
  [../]
  [./block_9]
    block = 9
    area = 2560
    Iy = 1.2e6
    Iz = 1.2e6
    y_orientation = '0.0 1.0 0.0'

    nodal_mass = 77.94999695
    boundary = 9 # vertex 24
  [../]
  [./block_10]
    block = 10
    area = 2210
    Iy = 1.2e6
    Iz = 1.2e6
    y_orientation = '0.0 1.0 0.0'

    nodal_mass = 195.339996
    boundary = 10 # vertex 26
  [../]
  [./block_11]
    block = 11
    area = 1960
    Iy = 1.3e6
    Iz = 1.3e6
    y_orientation = '0.0 1.0 0.0'

    nodal_mass = 116.769997
    boundary = 11 # vertex 28
  [../]
  [./block_12]
    block = 12
    area = 1740
    Iy = 9e5
    Iz = 9e5
    y_orientation = '0.0 1.0 0.0'

    nodal_mass = 265.220001
    boundary = 12 # vertex 30
  [../]
  [./block_13]
    block = 13
    area = 780
    Iy = 2e5
    Iz = 2e5
    y_orientation = '0.0 1.0 0.0'

    nodal_mass = 37.88999939
    boundary = 13 # vertex 32
  [../]
  [./block_14]
    block = 14
    area = 190
    Iy = 4000.0
    Iz = 4000.0
    y_orientation = '0.0 1.0 0.0'

    nodal_mass = 25.46999931
    boundary = 14 # vertex 34
  [../]
  [./block_16]
    block = 16
    area = 2000
    Iy = 2.8e6
    Iz = 2.8e6
    y_orientation = '0.0 0.0 1.0'
    dynamic_nodal_translational_inertia = false
  [../]
[]

[Materials]
  [./elasticity_beam_outer_1]
    type = ComputeElasticityBeam
    youngs_modulus = 6.9e5
    poissons_ratio = 0.278
    shear_coefficient = 0.5
    block = '1 2 3'
  [../]
  [./elasticity_beam_outer_2]
    type = ComputeElasticityBeam
    youngs_modulus = 6.9e5
    poissons_ratio = 0.278
    shear_coefficient = 0.505
    block = '4 5 6 7'
  [../]
  [./elasticity_beam_inner_1]
    type = ComputeElasticityBeam
    youngs_modulus = 3.45e5
    poissons_ratio = 0.278
    shear_coefficient = 0.66
    block = '8'
  [../]
  [./elasticity_beam_inner_2]
     type = ComputeElasticityBeam
     youngs_modulus = 3.45e5
     poissons_ratio = 0.278
     shear_coefficient = 0.609375
     block = '9'
  [../]
  [./elasticity_beam_inner_3]
    type = ComputeElasticityBeam
    youngs_modulus = 3.45e5
    poissons_ratio = 0.278
    shear_coefficient = 0.6606
    block = '10'
  [../]
  [./elasticity_beam_inner_4]
    type = ComputeElasticityBeam
    youngs_modulus = 3.45e5
    poissons_ratio = 0.278
    shear_coefficient = 0.372
    block = '11'
  [../]
  [./elasticity_beam_inner_5]
    type = ComputeElasticityBeam
    youngs_modulus = 3.45e5
    poissons_ratio = 0.278
    shear_coefficient = 0.345
    block = '12'
  [../]
  [./elasticity_beam_inner_6]
    type = ComputeElasticityBeam
    youngs_modulus = 3.45e5
    poissons_ratio = 0.278
    shear_coefficient = 0.462
    block = '13'
  [../]
  [./elasticity_beam_inner_7]
    type = ComputeElasticityBeam
    youngs_modulus = 3.45e5
    poissons_ratio = 0.278
    shear_coefficient = 0.368
    block = '14'
  [../]
  [./elasticity_beam_foundation]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 9e7
    poissons_ratio = 0
    block = '15'
  [../]
  [./foundation_connecting_beam]
    type = ComputeElasticityBeam
    youngs_modulus = 9e7
    poissons_ratio = 0
    shear_coefficient = 0.833
    block = '16'
  [../]
  [./stress_beam]
    type = ComputeBeamResultants
    block = '1 2 3 4 5 6 7 8 9 10 11 12 13 14 16'
  [../]
  [./stress_beam2]
    type = ComputeFiniteStrainElasticStress
    block = '15'
  [../]
  [./strain_15]
    type = ComputeFiniteStrain
    block = '15'
    displacements = 'disp_x disp_y disp_z'
  [../]
  [./density]
    type = GenericConstantMaterial
    block = '15 16'
    prop_names = density
    prop_values =  0.115
  [../]
  [./material_zeta]
    type = GenericConstantMaterial
    prop_names = 'zeta_rayleigh'
    prop_values = 0.000781
  [../]
  [./material_eta]
    type = GenericConstantMaterial
    prop_names = 'eta_rayleigh'
    prop_values = 0.64
  [../]
[]

[BCs]
  [./disp_x]
    type = PresetAcceleration
    variable = disp_x
    velocity = vel_x
    acceleration = accel_x
    beta = 0.25
    function = accel_x
    boundary = '100'
  [../]
  [./disp_y]
    type = DirichletBC
    boundary = '100'
    variable = disp_y
    value = 0.0
  [../]
  [./disp_z]
    type = DirichletBC
    boundary = '100'
    variable = disp_z
    value = 0.0
  [../]
  [./rot_x]
    type = DirichletBC
    boundary = '1002'
    variable = rot_x
    value = 0.0
  [../]
  [./rot_y]
    type = DirichletBC
    boundary = '1002'
    variable = rot_y
    value = 0.0
  [../]
  [./rot_z]
    type = DirichletBC
    boundary = '1002'
    variable = rot_z
    value = 0.0
  [../]
[]

[Functions]
  [./accel_x]
    type = PiecewiseLinear
    data_file = 'GMs/GM0.csv'
    format = 'columns'
    # scale_factor = 32.2000008
    xy_in_file_only = false
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
  solve_type = 'NEWTON'
  petsc_options = '-snes_ksp_ew'
  petsc_options_iname = '-ksp_gmres_restart -pc_type -pc_hypre_type -pc_hypre_boomeramg_max_iter'
  petsc_options_value = '201                hypre    boomeramg      4'
  end_time = 45.0
  dt = 0.05
  dtmin = 0.001
  nl_abs_tol = 1e-05
    nl_rel_tol = 1e-05
  l_tol = 1e-5
  l_max_its = 20
  timestep_tolerance = 1e-04
[]

[Postprocessors]
  [./result_bot]
    type = PointValue
    variable = accel_x
    point = '0.0 0.0 0.0'
  [../]
  [./result_top]
    type = PointValue
    variable = accel_x
    point = '0.0 0.0 217.0'
  [../]
[]

[Controls]
  [./stochastic]
    type = SamplerReceiver
  [../]
[]

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
  print_linear_residuals = true
[]
