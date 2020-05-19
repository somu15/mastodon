[Mesh]
  [gen]
    type = GeneratedMeshGenerator
    dim = 1
    nx = 1000
    xmax = 2
  []
  [./subdomain1]
    input = gen
    type = SubdomainBoundingBoxGenerator
    bottom_left = '1.0 0 0'
    block_id = 1
    top_right = '2.0 0.0 0'
  [../]
  [./interface]
    type = SideSetsBetweenSubdomainsGenerator
    input = subdomain1
    master_block = '0'
    paired_block = '1'
    new_boundary = 'master0_interface'
  [../]
  [./interface_again]
    type = SideSetsBetweenSubdomainsGenerator
    input = interface
    master_block = '1'
    paired_block = '0'
    new_boundary = 'master1_interface'
  [../]
[]

[GlobalParams]
  # order = SECOND
  # family = LAGRANGE
[]

[Variables]
  [./p]
    # order = FIRST
    # family = LAGRANGE
    block = 1
  [../]
  [./disp_x]
    # order = SECOND
    # family = LAGRANGE
    # order = FIRST
    # family = LAGRANGE
    block = 0
  [../]
[]

# [Modules/TensorMechanics/Master]
#   [./block1]
#     strain = SMALL #Small linearized strain, automatically set to XY coordinates
#     add_variables = true #Add the variables from the displacement string in GlobalParams
#     block = 0
#   [../]
# []

[AuxVariables]
  [./flux_p]
      order = FIRST
      family = MONOMIAL
      block = 1
  [../]
  [./flux_u]
      order = FIRST
      family = MONOMIAL
      block = 0
  [../]

[]

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
    type = CoeffDiff
    variable = 'p'
    block = 1
    D =  1.0 # 2250000
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
  # [./inertia_x1]
  #   type = InertialForce
  #   variable = disp_x
  #   # velocity = vel_x
  #   # acceleration = accel_x
  #   # beta = 0.25
  #   # gamma = 0.5
  #   block = '0'
  # [../]
[]

[AuxKernels]
  # [./disp_z]
  #   type = WaveHeightAuxKernel
  #   variable = 'disp_z'
  #   pressure = p
  #   dens = 1000.0
  #   grav = 9.81
  #   execute_on = timestep_end
  # [../]
  [./grad_press]
    block = 1
    type = FluidFluxAuxKernel
    variable = 'flux_p'
    pressure = 'p'
    fluiddens = 1.0
  [../]
  [./grad_dispx]
    block = 0
    type = StructureFluxAuxKernel
    variable = 'flux_u'
    dispx = 'disp_x'
    fluiddens = 0.0
  [../]
[]

[InterfaceKernels]
  [./interface]
    type = FluidStructureInterface # FluidStructureInterface
    variable = disp_x
    neighbor_var = 'p'
    boundary = 'master0_interface'
    D = 0.0
    D_neighbor = 1.0
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
    prop_values = 4.44e-7 # 4.44e-7
    block = '1'
  [../]
  # [./density0]
  #   type = GenericConstantMaterial
  #   block = '0'
  #   prop_names = density
  #   prop_values =  8050 # 2700
  # [../]
  [./elasticity_base]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 2e11 # 1e14
    poissons_ratio = 0.0
    block = '0'
  [../]
  [./strain]
    type = ComputeSmallStrain
    block = '0'
    displacements = 'disp_x'
  [../]
  [./stress]
    type = ComputeLinearElasticStress
    block = '0'
  [../]
  # [./stress_beam2]
  #   type = ComputeFiniteStrainElasticStress
  #   block = '0'
  # [../]
  # [./strain_15]
  #   type = ComputeFiniteStrain
  #   block = '0'
  #   displacements = 'disp_x'
  # [../]
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
  start_time = 0.0
  end_time = 0.4
  dt = 0.00001
  dtmin = 0.0001
  nl_abs_tol = 1e-4 # 1e-3
  nl_rel_tol = 1e-4 # 1e-3
  l_tol = 1e-4 # 1e-3
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
  # [./p1]
  #   type = PointValue
  #   point = '1.0 0.0 0.0'
  #   variable = p
  # [../]
  [./u1]
    type = PointValue
    point = '1.0 0.0 0.0'
    variable = disp_x
  [../]
  # [./p_flux]
  #   type = PointValue
  #   point = '1.0 0.0 0.0'
  #   variable = flux_p
  # [../]
  # [./u_flux]
  #   type = PointValue
  #   point = '1.0 0.0 0.0'
  #   variable = flux_u
  # [../]
[]

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
  print_linear_residuals = true
  file_base = Exodus_Test_1
  [./out]
    execute_on = 'TIMESTEP_BEGIN'
    type = CSV
    file_base = Test_1
  [../]
[]
