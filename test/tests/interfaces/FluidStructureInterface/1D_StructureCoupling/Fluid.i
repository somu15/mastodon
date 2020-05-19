[Mesh]
  [gen]
    type = GeneratedMeshGenerator
    dim = 1
    nx = 10000
    xmax = 5000
  []
[]

[GlobalParams]
[]

[Variables]
  [./p]
  [../]
[]

[AuxVariables]
  [./flux_p]
    order = FIRST
    family = MONOMIAL
  [../]
[]

[Kernels]
  [./diffusion]
    type = CoeffDiff
    variable = 'p'
    D =  1.0
  [../]
  [./inertia]
    type = InertialForce
    variable = p
  [../]
[]

[AuxKernels]
  [./grad_press]
    type = FluidFluxAuxKernel
    variable = 'flux_p'
    pressure = 'p'
    fluiddens = 1.8181e-4 #1.24e-4
  [../]
[]

[BCs]
  [./bottom_accel]
    type = FunctionDirichletBC
    variable = p
    boundary = 'right'
    function = accel_bottom
  [../]
  [./left]
    type = DirichletBC
    variable = p
    boundary = 'left'
    value = 0
  [../]
[]

[Functions]
  [./accel_bottom]
    type = PiecewiseLinear
    data_file = Input_5Sines.csv
    scale_factor = 1.0
    format = 'columns'
  [../]
[]

[Materials]
  [./density]
    type = GenericConstantMaterial
    prop_names = density
    prop_values = 4.44e-7
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
  start_time = 0.0
  end_time = 0.4
  dt = 0.001
  dtmin = 0.0001
  nl_abs_tol = 1e-4 # 1e-3
  nl_rel_tol = 1e-4 # 1e-3
  l_tol = 1e-4 # 1e-3
  l_max_its = 25
  timestep_tolerance = 1e-8
  [TimeIntegrator]
    type = NewmarkBeta
  []
[]

[Postprocessors]
  [./p_flux]
    type = PointValue
    point = '5000.0 0.0 0.0'
    variable = flux_p
  [../]
[]

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
  print_linear_residuals = true
  file_base = Exodus_Extract_GradP_5Sines
  [./out]
    execute_on = 'TIMESTEP_BEGIN'
    type = CSV
    file_base = Extract_GradP_5Sines
  [../]
[]
