[Mesh]
  [gen]
    type = GeneratedMeshGenerator
    dim = 1
    nx = 10
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

[Variables]
  [./u]
    order = FIRST
    family = LAGRANGE
    block = 0
  [../]
  [./v]
    order = FIRST
    family = LAGRANGE
    block = 1
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
  [./diff0]
    type = CoeffDiff
    variable = u
    D = 4
    block = 0
  [../]
  [./diff1]
    type = CoeffDiff
    variable = v
    D = 2
    block = 1
  [../]
[]

[AuxKernels]
  [./grad_press1]
    block = 0
    type = FluidFluxAuxKernel
    variable = 'flux_u'
    pressure = 'u'
    fluiddens = 4
  [../]
  [./grad_press2]
    block = 1
    type = FluidFluxAuxKernel
    variable = 'flux_v'
    pressure = 'v'
    fluiddens = 2
  [../]
[]

[InterfaceKernels]
  [./interface]
    type = IntDiff
    variable = u
    neighbor_var = v
    boundary = master0_interface
    D = 4
    D_neighbor = 2
  [../]
[]

[BCs]
  # [./left]
  #   type = DirichletBC
  #   variable = u
  #   boundary = 'left'
  #   value = 1
  # [../]
  # [./right]
  #   type = DirichletBC
  #   variable = u
  #   boundary = 'right'
  #   value = 0
  # [../]
  [./bottom_accel]
    type = FunctionDirichletBC
    variable = v
    boundary = 'right'
    function = accel_bottom
  [../]
  [./disp_x]
    type = PresetBC
    boundary = 'left'
    variable = u
    value = 0.0
    # type = DiffusionFluxBC
    # variable = u
    # boundary = 'left'
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

# [Materials]
#   # [./stateful]
#   #   type = StatefulMaterial
#   #   initial_diffusivity = 1
#   #   boundary = master0_interface
#   # [../]
#   [./block0]
#     type = GenericConstantMaterial
#     block = '0'
#     prop_names = 'D'
#     prop_values = '4'
#   [../]
#   [./block1]
#     type = GenericConstantMaterial
#     block = '1'
#     prop_names = 'D'
#     prop_values = '2'
#   [../]
# []

[Preconditioning]
  [./smp]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  # type = Steady
  # solve_type = NEWTON
  type = Transient
  solve_type = 'NEWTON'
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
  # [./u1]
  #   type = PointValue
  #   point = '0.0 0.0 0.0'
  #   variable = u
  # [../]
  # [./u2]
  #   type = PointValue
  #   point = '0.2 0.0 0.0'
  #   variable = u
  # [../]
  # [./u3]
  #   type = PointValue
  #   point = '0.4 0.0 0.0'
  #   variable = u
  # [../]
  # [./u4]
  #   type = PointValue
  #   point = '0.6 0.0 0.0'
  #   variable = u
  # [../]
  # [./u5]
  #   type = PointValue
  #   point = '0.8 0.0 0.0'
  #   variable = u
  # [../]
  # [./u6]
  #   type = PointValue
  #   point = '1.0 0.0 0.0'
  #   variable = u
  # [../]
  # [./u7]
  #   type = PointValue
  #   point = '1.2 0.0 0.0'
  #   variable = u
  # [../]
  # [./u8]
  #   type = PointValue
  #   point = '1.4 0.0 0.0'
  #   variable = u
  # [../]
  # [./u9]
  #   type = PointValue
  #   point = '1.6 0.0 0.0'
  #   variable = u
  # [../]
  # [./u10]
  #   type = PointValue
  #   point = '1.8 0.0 0.0'
  #   variable = u
  # [../]
  # [./u11]
  #   type = PointValue
  #   point = '2.0 0.0 0.0'
  #   variable = u
  # [../]
  [./u_flux]
    type = PointValue
    point = '0.9 0.0 0.0'
    variable = flux_u
  [../]
  [./v_flux]
    type = PointValue
    point = '1.1 0.0 0.0'
    variable = flux_v
  [../]
[]

[Outputs]
  exodus = true
  csv = true
  print_linear_residuals = true
[]

[Debug]
  show_var_residual_norms = true
[]
