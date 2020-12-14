[Mesh]
  [file]
    type = FileMeshGenerator
    file = 3D_model_fakeshell_nosolid.e
  []
  uniform_refine = 1
[]

[GlobalParams]
[]

[Variables]
  [./p]
    block = '1'
  [../]
  [./disp_x]
    block = '2'
  [../]
  [./disp_y]
    block = '2'
  [../]
  [./disp_z]
    block = '2'
  [../]
[]

[AuxVariables]
  [./vel_x]
    block = '2'
  [../]
  [./accel_x]
    block = '2'
  [../]
  [./vel_y]
    block = '2'
  [../]
  [./vel_z]
    block = '2'
  [../]
  [./accel_y]
    block = '2'
  [../]
  [./accel_z]
    block = '2'
  [../]
  [./stress_xx]
    order = CONSTANT
    family = MONOMIAL
    block = '2'
  [../]
  [./stress_yy]
    order = CONSTANT
    family = MONOMIAL
    block = '2'
  [../]
  [./stress_xy]
    order = CONSTANT
    family = MONOMIAL
    block = '2'
  [../]
  [./stress_zz]
    order = CONSTANT
    family = MONOMIAL
    block = '2'
  [../]
[]

[Kernels]
  [./diffusion]
    type = Diffusion
    variable = 'p'
    block = 1
  [../]
  [./inertia]
    type = AcousticInertia
    variable = p
    block = 1
  [../]
  [./DynamicTensorMechanics]
    displacements = 'disp_x disp_y disp_z'
    block = 2
  [../]
  [./inertia_x1]
    type = InertialForce
    variable = disp_x
    block = 2
  [../]
  [./inertia_y1]
    type = InertialForce
    variable = disp_y
    block = 2
  [../]
  [./inertia_z1]
    type = InertialForce
    variable = disp_z
    block = 2
  [../]
[]

[AuxKernels]
  [./accel_x]
    type = TestNewmarkTI
    displacement = disp_x
    variable = accel_x
    first = false
    block = '2'
  [../]
  [./vel_x]
    type = TestNewmarkTI
    displacement = disp_x
    variable = vel_x
    block = '2'
  [../]
  [./accel_y]
    type = TestNewmarkTI
    displacement = disp_y
    variable = accel_y
    first = false
    block = '2'
  [../]
  [./vel_y]
    type = TestNewmarkTI
    displacement = disp_y
    variable = vel_y
    block = '2'
  [../]
  [./accel_z]
    type = TestNewmarkTI
    displacement = disp_z
    variable = accel_z
    first = false
    block = '2'
  [../]
  [./vel_z]
    type = TestNewmarkTI
    displacement = disp_z
    variable = vel_z
    block = '2'
  [../]
  [./stress_xx]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xx
    index_i = 0
    index_j = 0
    block = '2'
  [../]
  [./stress_yy]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_yy
    index_i = 1
    index_j = 1
    block = '2'
  [../]
  [./stress_xy]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xy
    index_i = 0
    index_j = 1
    block = '2'
  [../]
  [./stress_zz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_zz
    index_i = 2
    index_j = 2
    block = '2'
  [../]
[]

[InterfaceKernels]
  # [./interface1]
  #   type =  FluidStructureInterface_Shell
  #   variable = p
  #   neighbor_var = disp_x
  #   boundary = 'Interface'
  #   D = 1e-6
  #   component = 0
  # [../]
  # [./interface2]
  #   type =  FluidStructureInterface_Shell
  #   variable = p
  #   neighbor_var = disp_y
  #   boundary = 'Interface'
  #   D = 1e-6
  #   component = 1
  # [../]
  # [./interface3]
  #   type =  FluidStructureInterface_Shell
  #   variable = p
  #   neighbor_var = disp_z
  #   boundary = 'Interface'
  #   D = 1e-6
  #   component = 2
  # [../]
  [./interface1]
    type =  FluidStructureInterface_3D
    variable = disp_x
    neighbor_var = p
    boundary = 'Interface'
    D = 1e-6
    component = 0
  [../]
  [./interface2]
    type =  FluidStructureInterface_3D
    variable = disp_y
    neighbor_var = p
    boundary = 'Interface'
    D = 1e-6
    component = 1
  [../]
  [./interface3]
    type =  FluidStructureInterface_3D
    variable = disp_z
    neighbor_var = p
    boundary = 'Interface'
    D = 1e-6
    component = 2
  [../]
[]

[BCs]
  [./bottom_accel]
    type = FunctionDirichletBC
    variable = p
    boundary = 'Left'
    function = accel_bottom
  [../]
  [./disp_x1]
    type = DirichletBC # NeumannBC #
    boundary = 'ShellB'
    variable = disp_x
    value = 0.0
  [../]
  [./disp_x2]
    type = DirichletBC # NeumannBC #
    boundary = 'ShellB'
    variable = disp_y
    value = 0.0
  [../]
  [./disp_x3]
    type = DirichletBC # NeumannBC #
    boundary = 'ShellB'
    variable = disp_z
    value = 0.0
  [../]
  # [./disp_y_TB]
  #   type = NeumannBC
  #   boundary = 'Solid_surface'
  #   variable = disp_y
  #   value = 0.0
  # [../]
  # [./disp_z_TB]
  #   type = NeumannBC
  #   boundary = 'Solid_surface'
  #   variable = disp_z
  #   value = 0.0
  # [../]
[]

[Functions]
  [./accel_bottom]
    type = PiecewiseLinear
    data_file = Input_1Peak_highF.csv # Input_1Peak.csv
    scale_factor = 1e-2
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
    prop_names = inv_co_sq
    prop_values = 4.65e-7
    block = 1
  [../]
  [./density0]
    type = GenericConstantMaterial
    block = '2'
    prop_names = density
    prop_values = 7.85e-6
  [../]
  [./elasticity_base]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 2e2
    poissons_ratio = 0.27
    # bulk_modulus = 2.25
    # shear_modulus = 0.0
    block = 2
  [../]
  [./strain]
    type = ComputeFiniteStrain
    block = 2
    displacements = 'disp_x disp_y disp_z'
  [../]
  [./stress]
    type =  ComputeFiniteStrainElasticStress
    block = 2
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
  solve_type = 'PJFNK'
  # petsc_options = '-snes_ksp_ew'
  # petsc_options_iname = '-ksp_gmres_restart -pc_type -pc_hypre_type -pc_hypre_boomeramg_max_iter'
  # petsc_options_value = '201                hypre    boomeramg      4'
  petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
  petsc_options_value = 'lu       superlu_dist'
  start_time = 0.0
  end_time = 0.09
  dt = 0.0005
  dtmin = 0.00001
  nl_abs_tol = 1e-12 # 1e-3
  nl_rel_tol = 1e-12 # 1e-3
  l_tol = 1e-12 # 1e-3
  l_max_its = 12
  timestep_tolerance = 1e-8
  automatic_scaling = true
  [TimeIntegrator]
    type = NewmarkBeta
  []
[]

[Postprocessors]
  [./p1]
    type = PointValue
    point = '2.5 0.0 0.0'
    variable = p
  [../]
  [./stress1]
    type = PointValue
    point = '2.5 0.0 0.0'
    variable = stress_xx
  [../]
  [./stress2]
    type = PointValue
    point = '2.5 0.0 0.0'
    variable = stress_yy
  [../]
  [./stress3]
    type = PointValue
    point = '2.5 0.0 0.0'
    variable = stress_zz
  [../]
  [./disp1]
    type = PointValue
    point = '2.5 0.0 0.0'
    variable = disp_x
  [../]
[]

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
  print_linear_residuals = true
  file_base = Ex_Test_fakeshell_nosolid
  [./out]
    execute_on = 'TIMESTEP_BEGIN'
    type = CSV
    file_base = Test_fakeshell_nosolid
  [../]
[]
