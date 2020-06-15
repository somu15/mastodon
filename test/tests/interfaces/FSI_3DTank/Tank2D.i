[Mesh]
  type = FileMesh
  file = 2D_Tank.e # Tank1_062920.e
  # uniform_refine = 1
[]

[GlobalParams]
[]

[Variables]
  [./p]
    block = 2
  [../]
  [./disp_x]
    block = 1
  [../]
  [./disp_y]
    block = 1
  [../]
[]

[AuxVariables]
  [./disp_y1]
    block = 2
  [../]
  [./vel_x]
    block = 1
  [../]
  [./accel_x]
    block = 1
  [../]
  [./vel_y]
    block = 1
  [../]
  [./accel_y]
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
    block = 2
  [../]
  [./inertia]
    type = InertialForce
    variable = p
    block = 2
  [../]
  [./DynamicTensorMechanics]
    displacements = 'disp_x disp_y'
    block = 1
  [../]
  [./inertia_x1]
    type = InertialForce
    variable = disp_x
    velocity = vel_x
    acceleration = accel_x
    beta = 0.25
    gamma = 0.5
    block = 1
  [../]
  [./inertia_y1]
    type = InertialForce
    variable = disp_y
    velocity = vel_y
    acceleration = accel_y
    beta = 0.25
    gamma = 0.5
    block = 1
  [../]
[]

[AuxKernels]
  [./waves]
    type = WaveHeightAuxKernel
    variable = 'disp_y1'
    pressure = p
    dens = 1e-6
    grav = 9.81
    execute_on = timestep_end
  [../]
  # [./grad_press]
  #   block = 1
  #   type = FluidFluxAuxKernel
  #   variable = 'flux_p'
  #   pressure = 'p'
  #   fluiddens = 1.0
  # [../]
  # [./acc]
  #   block = '0'
  #   type = StructureFluxAuxKernel
  #   variable = 'acc1'
  #   dispx = disp_x
  #   fluiddens = 1e-6
  # [../]
  [./accel_x]
    type = NewmarkAccelAux
    variable = accel_x
    displacement = disp_x
    velocity = vel_x
    beta = 0.25
    execute_on = 'timestep_end'
    block = 1
  [../]
  [./vel_x]
    type = NewmarkVelAux
    variable = vel_x
    acceleration = accel_x
    gamma = 0.5
    execute_on = 'timestep_end'
    block = 1
  [../]
  [./accel_y]
    type = NewmarkAccelAux
    variable = accel_y
    displacement = disp_y
    velocity = vel_y
    beta = 0.25
    execute_on = 'timestep_end'
    block = 1
  [../]
  [./vel_y]
    type = NewmarkVelAux
    variable = vel_y
    acceleration = accel_y
    gamma = 0.5
    execute_on = 'timestep_end'
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
    D_neighbor = 1.0
    component = 0
  [../]
  [./interface2]
    type =  FluidStructureInterface_3D
    variable = disp_y
    neighbor_var = 'p'
    boundary = 'Interface'
    D = 1e-6
    D_neighbor = 1.0
    component = 1
  [../]
  # [./interface1Bot]
  #   type =  FluidStructureInterface_3D
  #   variable = disp_x
  #   neighbor_var = 'p'
  #   boundary = 'Interface'
  #   D = 1e-6
  #   D_neighbor = 1.0
  #   component = 0
  # [../]
  # [./interface2Bot]
  #   type =  FluidStructureInterface_3D
  #   variable = disp_y
  #   neighbor_var = 'p'
  #   boundary = 'Interface'
  #   D = 1e-6
  #   D_neighbor = 1.0
  #   component = 1
  # [../]
[]

[BCs]
  [./bottom_accel1]
    type = PresetAcceleration
    variable = disp_x
    velocity = vel_x
    acceleration = accel_x
    beta = 0.25
    function = accel_bottom
    boundary = 'Bottom'
  [../]
  [./disp_x2]
    type = DirichletBC
    variable = disp_y
    boundary = 'Bottom'
    value = 0.0
  [../]
  [./free]
    type = FluidFreeSurfaceBC
    variable = p
    boundary = 'Fluid_top'
    alpha = '0.1'
  []
[]

[Functions]
  [./accel_bottom]
    type = PiecewiseLinear
    data_file = Ormsby_12.csv # Input_1Peak_highF.csv # Input_1Peak.csv
    scale_factor = 9.81
    format = 'columns'
  [../]
  # [./accel_bottom]
  #   type = ParsedFunction
  #   value = 1e-3-1e-3*cos(t*3.141592653*10)
  #   # data_file = Input_5Sines.csv
  #   # scale_factor = 1e-2
  #   # format = 'columns'
  # [../]
[]

[Materials]
  [./density]
    type = GenericConstantMaterial
    prop_names = density
    prop_values = 4.44e-7
    block = 2
  [../]
  [./density0]
    type = GenericConstantMaterial
    block = 1
    prop_names = density
    prop_values = 7.7e-6
  [../]
  [./elasticity_base]
    type = ComputeIsotropicElasticityTensor
    # bulk_modulus = 2.25
    # shear_modulus = 0.0
    youngs_modulus = 2e5
    poissons_ratio = 0.3
    # lambda = -1e20
    # shear_modulus = 1e20
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
  # petsc_options = '-snes_ksp_ew'
  # petsc_options_iname = '-ksp_gmres_restart -pc_type -pc_hypre_type -pc_hypre_boomeramg_max_iter'
  # petsc_options_value = '201                hypre    boomeramg      4'
  petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
  petsc_options_value = 'lu       superlu_dist'
  start_time = 0.8
  end_time = 1.2
  dt = 0.01
  dtmin = 0.00001
  nl_abs_tol = 1e-12 # 1e-3
  nl_rel_tol = 1e-12 # 1e-3
  l_tol = 1e-12 # 1e-3
  l_max_its = 25
  timestep_tolerance = 1e-8
  automatic_scaling = true
  [TimeIntegrator]
    type = NewmarkBeta
  []
[]

[Postprocessors]
  [./wave1]
    type = PointValue
    point = '-6.1 12.5 0'
    variable = disp_y1
  [../]
  [./wave2]
    type = PointValue
    point = '-5.0833 12.5 0'
    variable = disp_y1
  [../]
  [./wave3]
    type = PointValue
    point = '-4.0667 12.5 0'
    variable = disp_y1
  [../]
  [./wave4]
    type = PointValue
    point = '-3.05 12.5 0'
    variable = disp_y1
  [../]
  [./wave5]
    type = PointValue
    point = '-2.0333 12.5 0'
    variable = disp_y1
  [../]
  [./wave6]
    type = PointValue
    point = '-1.01667 12.5 0'
    variable = disp_y1
  [../]
  [./wave7]
    type = PointValue
    point = '0.0 12.5 0'
    variable = disp_y1
  [../]
  [./wave8]
    type = PointValue
    point = '1.01667 12.5 0'
    variable = disp_y1
  [../]
  [./wave9]
    type = PointValue
    point = '2.0333 12.5 0'
    variable = disp_y1
  [../]
  [./wave10]
    type = PointValue
    point = '3.05 12.5 0'
    variable = disp_y1
  [../]
  [./wave11]
    type = PointValue
    point = '4.0667 12.5 0'
    variable = disp_y1
  [../]
  [./wave12]
    type = PointValue
    point = '5.0833 12.5 0'
    variable = disp_y1
  [../]
  [./wave13]
    type = PointValue
    point = '6.1 12.5 0'
    variable = disp_y1
  [../]
  [./P1]
    type = PointValue
    point = '6.1 12.5 0'
    variable = p
  [../]
  [./P2]
    type = PointValue
    point = '6.1 12.0 0'
    variable = p
  [../]
  [./P3]
    type = PointValue
    point = '6.1 11.5 0'
    variable = p
  [../]
  [./P4]
    type = PointValue
    point = '6.1 11.0 0'
    variable = p
  [../]
  [./P5]
    type = PointValue
    point = '6.1 10.5 0'
    variable = p
  [../]
  [./P6]
    type = PointValue
    point = '6.1 10.0 0'
    variable = p
  [../]
  [./P7]
    type = PointValue
    point = '6.1 9.5 0'
    variable = p
  [../]
  [./P8]
    type = PointValue
    point = '6.1 9.0 0'
    variable = p
  [../]
  [./P9]
    type = PointValue
    point = '6.1 8.5 0'
    variable = p
  [../]
  [./P10]
    type = PointValue
    point = '6.1 8.0 0'
    variable = p
  [../]
  [./P11]
    type = PointValue
    point = '6.1 7.5 0'
    variable = p
  [../]
  [./P12]
    type = PointValue
    point = '6.1 7.0 0'
    variable = p
  [../]
  [./P13]
    type = PointValue
    point = '6.1 6.5 0'
    variable = p
  [../]
  [./P14]
    type = PointValue
    point = '6.1 6.0 0'
    variable = p
  [../]
  [./P15]
    type = PointValue
    point = '6.1 5.5 0'
    variable = p
  [../]
  [./P16]
    type = PointValue
    point = '6.1 5.0 0'
    variable = p
  [../]
  [./P17]
    type = PointValue
    point = '6.1 4.5 0'
    variable = p
  [../]
  [./P18]
    type = PointValue
    point = '6.1 4.0 0'
    variable = p
  [../]
  [./P19]
    type = PointValue
    point = '6.1 3.5 0'
    variable = p
  [../]
  [./P20]
    type = PointValue
    point = '6.1 3.0 0'
    variable = p
  [../]
  [./P21]
    type = PointValue
    point = '6.1 2.5 0'
    variable = p
  [../]
  [./P22]
    type = PointValue
    point = '6.1 2.0 0'
    variable = p
  [../]
  [./P23]
    type = PointValue
    point = '6.1 1.5 0'
    variable = p
  [../]
  [./P24]
    type = PointValue
    point = '6.1 1.0 0'
    variable = p
  [../]
[]

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
  print_linear_residuals = true
  file_base = Ex_2DTest
  [./out]
    execute_on = 'TIMESTEP_BEGIN'
    type = CSV
    file_base = 2DTest
  [../]
[]
