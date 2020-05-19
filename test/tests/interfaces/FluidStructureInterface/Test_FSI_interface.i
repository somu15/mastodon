[Mesh]
  # type = FileMesh
  # file = Test_Int.e
  # construct_side_set_from_node_set=true
  # construct_node_list_from_side_list = false
  [gen]
    type = GeneratedMeshGenerator
    dim = 1
    nx = 10
    xmax = 1.0
    xmin = -1.0
  []
  [./subdomain1]
    input = gen
    type = SubdomainBoundingBoxGenerator
    bottom_left = '0.0 0.0 0.0'
    block_id = 1
    top_right = '1.0 0.0 0.0'
  [../]
  [./interface]
    type = SideSetsBetweenSubdomainsGenerator
    input = subdomain1
    master_block = '0'
    paired_block = '1'
    new_boundary = 'master0_interface'
  [../]
[]

[GlobalParams]
  # order = SECOND
  # family = LAGRANGE
[]

[Variables]
  [./p]
    # order = SECOND
    # family = LAGRANGE
    block = 1
  [../]
  [./disp_x]
    # order = SECOND
    # family = LAGRANGE
    block = 0
  [../]
[]

# [AuxVariables]
#   [./vel_x]
#     block = 0
#   [../]
#   [./accel_x]
#     block = 0
#   [../]
# []

# [AuxVariables]
#   [./disp_x]
#     # order = SECOND
#     # family = LAGRANGE
#   [../]
#   [./disp_y]
#     # order = SECOND
#     # family = LAGRANGE
#   [../]
#   [./disp_z]
#     # order = SECOND
#     # family = LAGRANGE
#   [../]
# []

[Kernels]
  [./diffusion]
    type = Diffusion
    variable = 'p'
    block = 1
  [../]
  [./inertia]
    type = InertialForce
    variable = p
    block = 1
  [../]
  [./DynamicTensorMechanics]
    displacements = 'disp_x'
    block = '0'
  [../]
  [./inertia_x1]
    type = InertialForce
    variable = disp_x
    # velocity = vel_x
    # acceleration = accel_x
    # beta = 0.25
    # gamma = 0.5
    block = '0'
  [../]
[]

# [AuxKernels]
#   [./disp_z]
#     type = WaveHeightAuxKernel
#     variable = 'disp_z'
#     pressure = p
#     dens = 1000.0
#     grav = 9.81
#     execute_on = timestep_end
#   [../]
# []

[InterfaceKernels]
  [./interface]
    type = FluidStructureInterface
    variable = disp_x
    neighbor_var = 'p'
    boundary = 'master0_interface'
    D = 1000.0
    # D_neighbor = D
  [../]
[]

[BCs]
  [./bottom_accel]
    type = FunctionDirichletBC
    variable = p
    boundary = 'right'
    function = accel_bottom
  [../]
  [./disp_x]
    type = PresetBC
    boundary = 'left'
    variable = disp_x
    value = 0.0
  [../]
  # [./bottom_accel]
  #   type = FunctionDirichletBC
  #   variable = disp_x
  #   boundary = 'left'
  #   function = accel_bottom
  # [../]
  # [./bottom_accel1]
  #   type = DirichletBC
  #   variable = p
  #   boundary = 'right'
  #   value = 0
  # [../]
[]

[Functions]
  [./accel_bottom]
    type = PiecewiseLinear
    data_file = Input.csv
    scale_factor = 1000.0
    format = 'columns'
  [../]
  # [./accel_bottom]
  #   type = ParsedFunction
  #   value = pi*sin(alpha*pi*t)
  #   # vars = 'alpha'
  #   # vals = '16'
  # [../]
[]

[Materials]
  [./density]
    type = GenericConstantMaterial
    prop_names = density
    prop_values =  4.57e-7
    block = 1
  [../]
  [./density0]
    type = GenericConstantMaterial
    block = '0'
    prop_names = density
    prop_values =  2700
  [../]
  [./elasticity_base]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 1e14
    poissons_ratio = 0.3
    block = '0'
  [../]
  [./stress_beam2]
    type = ComputeFiniteStrainElasticStress
    block = '0'
  [../]
  [./strain_15]
    type = ComputeFiniteStrain
    block = '0'
    displacements = 'disp_x'
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
  petsc_options = '-snes_ksp_ew'
  petsc_options_iname = '-ksp_gmres_restart -pc_type -pc_hypre_type -pc_hypre_boomeramg_max_iter'
  petsc_options_value = '201                hypre    boomeramg      4'
  start_time = 0.0
  end_time = 1.0
  dt = 0.001
  dtmin = 0.0001
  nl_abs_tol = 5e-3
  nl_rel_tol = 5e-3
  l_tol = 5e-3
  l_max_its = 25
  timestep_tolerance = 1e-8
  # automatic_scaling = true
  # type = Transient
  # solve_type = 'PJFNK'
  # petsc_options = '-snes_ksp_ew'
  # petsc_options_iname = '-ksp_gmres_restart -pc_type -pc_hypre_type -pc_hypre_boomeramg_max_iter'
  # petsc_options_value = '201                hypre    boomeramg      4'
  # start_time = 0.0
  # end_time = 5.0
  # dt = 0.005
  # dtmin = 0.0001
  # nl_abs_tol = 1e-7
  # nl_rel_tol = 1e-7
  # l_tol = 1e-7
  # l_max_its = 25
  # timestep_tolerance = 1e-8
  [TimeIntegrator]
    type = NewmarkBeta
  []
[]

[Postprocessors]
  [./p1]
    type = PointValue
    point = '1.0 0.0 0.0'
    variable = p
  [../]
  [./u1]
    type = PointValue
    point = '0.0 0.0 0.0'
    variable = disp_x
  [../]
[]

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
  print_linear_residuals = true
  file_base = Exodus_Test_FSI_1
  [./out]
    execute_on = 'TIMESTEP_BEGIN'
    type = CSV
    file_base = Test_FSI_1
  [../]
[]
