[Mesh]
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
    input = subdomain1
    type = SideSetsBetweenSubdomainsGenerator
    master_block = '0'
    paired_block = '1'
    new_boundary = 'master0_interface'
  [../]
[]

[Variables]
  [./u]
    order = FIRST
    family = LAGRANGE
    block = '0'
  [../]
  [./v]
    order = FIRST
    family = LAGRANGE
    block = '1'
  [../]
[]

[AuxVariables]
  [./flux_u]
      order = FIRST
      family = MONOMIAL
      block = 0
  [../]
  [./flux_v]
      order = FIRST
      family = MONOMIAL
      block = 1
  [../]
[]

[Kernels]
  [./diff_u]
    type = Diffusion
    variable = u
    # D = 4
    block = 0
  [../]
  [./diff_v]
    type = Diffusion
    variable = v
    # D = 2
    block = 1
  [../]
[]

[AuxKernels]
  [./grad_press1]
    block = 0
    type = FluidFluxAuxKernel
    variable = 'flux_u'
    pressure = 'u'
    fluiddens = 1
  [../]
  [./grad_press2]
    block = 1
    type = FluidFluxAuxKernel
    variable = 'flux_v'
    pressure = 'v'
    fluiddens = 1
  [../]
[]

[InterfaceKernels]
  active = 'interface'
  [./interface]
    type = IntDiff # IntDiffFlxMat
    variable = u
    neighbor_var = v
    boundary = master0_interface
    D = 2
    D_neighbor = 2
  [../]
  # [./penalty_interface]
  #   type = PenaltyInterfaceDiffusion
  #   variable = u
  #   neighbor_var = v
  #   boundary = master0_interface
  #   penalty = 1e6
  # [../]
[]

[BCs]
  # active = 'left right middle'
  # [./left]
  #   type = DirichletBC
  #   variable = u
  #   boundary = 'left'
  #   value = 1
  # [../]
  # [./right]
  #   type = DirichletBC
  #   variable = v
  #   boundary = 'right'
  #   value = 0
  # [../]
  # [./middle]
  #   type = MatchedValueBC
  #   variable = v
  #   boundary = 'master0_interface'
  #   v = u
  # [../]
  [./bottom_accel]
    type = FunctionDirichletBC
    variable = v
    boundary = 'right'
    function = accel_bottom
  [../]
  # [./disp_x]
  #   type = PresetBC
  #   boundary = 'left'
  #   variable = u
  #   value = 0.0
  #   # type = DiffusionFluxBC
  #   # variable = u
  #   # boundary = 'left'
  # [../]

[]

[Materials]
  # [./stateful]
  #   type = StatefulMaterial
  #   initial_diffusivity = 1
  #   boundary = master0_interface
  # [../]
  [./block0]
    type = GenericConstantMaterial
    block = '0'
    prop_names = 'D'
    prop_values = '2'
  [../]
  [./block1]
    type = GenericConstantMaterial
    block = '1'
    prop_names = 'D'
    prop_values = '2'
  [../]
[]

[Functions]
  [./accel_bottom]
    type = PiecewiseLinear
    data_file = Input.csv
    scale_factor = 1000000.0
    format = 'columns'
  [../]
  # [./accel_bottom]
  #   type = ParsedFunction
  #   value = pi*sin(alpha*pi*t)
  #   # vars = 'alpha'
  #   # vals = '16'
  # [../]
[]

[Preconditioning]
  [./smp]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  type = Transient
  solve_type = 'PJFNK'
  petsc_options = '-snes_ksp_ew'
  petsc_options_iname = '-ksp_gmres_restart -pc_type -pc_hypre_type -pc_hypre_boomeramg_max_iter'
  petsc_options_value = '201                hypre    boomeramg      4'
  start_time = 0.0
  end_time = 0.4
  dt = 0.001
  dtmin = 0.0001
  nl_abs_tol = 5e-5
  nl_rel_tol = 5e-5
  l_tol = 5e-5
  l_max_its = 25
  timestep_tolerance = 1e-8
[]
[Postprocessors]
  [./u_flux]
    type = PointValue
    point = '0.0 0.0 0.0'
    variable = flux_u
  [../]
  [./v_flux]
    type = PointValue
    point = '0.0 0.0 0.0'
    variable = flux_v
  [../]
  # [./u_1]
  #   type = PointValue
  #   point = '0.0 0.0 0.0'
  #   variable = u
  # [../]
  # [./v_1]
  #   type = PointValue
  #   point = '0.0 0.0 0.0'
  #   variable = v
  # [../]
[]

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
  print_linear_residuals = true
  file_base = Exodus_Test
  [./out]
    execute_on = 'TIMESTEP_BEGIN'
    type = CSV
    file_base = Test_1
  [../]
[]

[Debug]
  show_var_residual_norms = true
[]
