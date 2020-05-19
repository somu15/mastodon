
[Mesh]
  type = FileMesh
  file = 3D_finer.e
[]

[GlobalParams]
  # order = SECOND
  # family = LAGRANGE
[]

[Variables]
  [./p]
    # order = SECOND
    # family = LAGRANGE
  [../]
[]

[AuxVariables]
  [./disp_x]
    # order = SECOND
    # family = LAGRANGE
  [../]
  [./disp_y]
    # order = SECOND
    # family = LAGRANGE
  [../]
  [./disp_z]
    # order = SECOND
    # family = LAGRANGE
  [../]
[]

[Kernels]
  [./diffusion]
    type = Diffusion
    variable = 'p'
  [../]
  [./inertia]
    type = InertialForce
    variable = p
  [../]
[]

[AuxKernels]
  [./disp_z]
    type = WaveHeightAuxKernel
    variable = 'disp_z'
    pressure = p
    dens = 1000.0
    grav = 9.81
    execute_on = timestep_end
  [../]
[]

[BCs]
  [./bottom_accel]
    type = FunctionDirichletBC
    variable = p
    boundary = 'Inner'
    function = accel_bottom
  [../]
  [./free]
    type = FluidFreeSurfaceBC
    variable = p
    boundary = 'Top'
    alpha = '0.1'
  []
#   [./right]
#   type = NeumannBC
#   variable = p
#   boundary = 'Inner'
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
  end_time = 5.0
  dt = 0.01
  dtmin = 0.0001
  nl_abs_tol = 1e-8
  nl_rel_tol = 1e-8
  l_tol = 1e-8
  l_max_its = 25
  timestep_tolerance = 1e-8
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
    point = '0.7 0.0 0.6'
    variable = p
  [../]
  [./p2]
    type = PointValue
    point = '0.63 0.0 0.6'
    variable = p
  [../]
  [./p3]
    type = PointValue
    point = '0.56 0.0 0.6'
    variable = p
  [../]
  [./p4]
    type = PointValue
    point = '0.49 0.0 0.6'
    variable = p
  [../]
  [./p5]
    type = PointValue
    point = '0.42 0.0 0.6'
    variable = p
  [../]
  [./p6]
    type = PointValue
    point = '0.35 0.0 0.6'
    variable = p
  [../]
  [./p7]
    type = PointValue
    point = '0.28 0.0 0.6'
    variable = p
  [../]
  [./p8]
    type = PointValue
    point = '0.21 0.0 0.6'
    variable = p
  [../]
  [./p9]
    type = PointValue
    point = '0.14 0.0 0.6'
    variable = p
  [../]
  [./p10]
    type = PointValue
    point = '0.07 0.0 0.6'
    variable = p
  [../]
  [./p11]
    type = PointValue
    point = '0 0.0 0.6'
    variable = p
  [../]
  [./p12]
    type = PointValue
    point = '-0.07 0.0 0.6'
    variable = p
  [../]
  [./p13]
    type = PointValue
    point = '-0.14 0.0 0.6'
    variable = p
  [../]
  [./p14]
    type = PointValue
    point = '-0.21 0.0 0.6'
    variable = p
  [../]
  [./p15]
    type = PointValue
    point = '-0.28 0.0 0.6'
    variable = p
  [../]
  [./p16]
    type = PointValue
    point = '-0.35 0.0 0.6'
    variable = p
  [../]
  [./p17]
    type = PointValue
    point = '-0.42 0.0 0.6'
    variable = p
  [../]
  [./p18]
    type = PointValue
    point = '-0.49 0.0 0.6'
    variable = p
  [../]
  [./p19]
    type = PointValue
    point = '-0.56 0.0 0.6'
    variable = p
  [../]
  [./p20]
    type = PointValue
    point = '-0.63 0.0 0.6'
    variable = p
  [../]
  [./p21]
    type = PointValue
    point = '-0.7 0.0 0.6'
    variable = p
  [../]
  # [./p8]
  #   type = PointValue
  #   point = '7.0 10.0 0.0'
  #   variable = p
  # [../]
  # [./p9]
  #   type = PointValue
  #   point = '8.0 10.0 0.0'
  #   variable = p
  # [../]
  # [./p10]
  #   type = PointValue
  #   point = '9.0 10.0 0.0'
  #   variable = p
  # [../]
  # [./p11]
  #   type = PointValue
  #   point = '10.0 10.0 0.0'
  #   variable = p
  # [../]
  [./p_C1]
    type = PointValue
    point = '0.0 0.0 0.6'
    variable = p
  [../]
  [./p_C2]
    type = PointValue
    point = '0.0 0.0 0.4'
    variable = p
  [../]
  [./p_C3]
    type = PointValue
    point = '0.0 0.0 0.2'
    variable = p
  [../]
  [./p_C4]
    type = PointValue
    point = '0.0 0.0 0.0'
    variable = p
  [../]
  [./p_C5]
    type = PointValue
    point = '0.0 0.0 -0.2'
    variable = p
  [../]
  [./p_C6]
    type = PointValue
    point = '0.0 0.0 -0.4'
    variable = p
  [../]
  [./p_C7]
    type = PointValue
    point = '0.0 0.0 -0.6'
    variable = p
  [../]
  # [./p_bot]
  #   type = PointValue
  #   point = '0.0 0.0 -0.6'
  #   variable = p
  # [../]
[]

# [Postprocessors]
#   [./p1]
#     type = PointValue
#     point = '0.0 0.7 0.6'
#     variable = p
#   [../]
#   [./p2]
#     type = PointValue
#     point = '0.0 0.63 0.6'
#     variable = p
#   [../]
#   [./p3]
#     type = PointValue
#     point = '0.0 0.56 0.6'
#     variable = p
#   [../]
#   [./p4]
#     type = PointValue
#     point = '0.0 0.49 0.6'
#     variable = p
#   [../]
#   [./p5]
#     type = PointValue
#     point = '0.0 0.42 0.6'
#     variable = p
#   [../]
#   [./p6]
#     type = PointValue
#     point = '0.0 0.35 0.6'
#     variable = p
#   [../]
#   [./p7]
#     type = PointValue
#     point = '0.0 0.28 0.6'
#     variable = p
#   [../]
#   [./p8]
#     type = PointValue
#     point = '0.0 0.21 0.6'
#     variable = p
#   [../]
#   [./p9]
#     type = PointValue
#     point = '0.0 0.14 0.6'
#     variable = p
#   [../]
#   [./p10]
#     type = PointValue
#     point = '0.0 0.07 0.6'
#     variable = p
#   [../]
#   [./p11]
#     type = PointValue
#     point = '0.0 0.0 0.6'
#     variable = p
#   [../]
#   [./p12]
#     type = PointValue
#     point = '0.0 -0.07 0.6'
#     variable = p
#   [../]
#   [./p13]
#     type = PointValue
#     point = '0.0 -0.14 0.6'
#     variable = p
#   [../]
#   [./p14]
#     type = PointValue
#     point = '0.0 -0.21 0.6'
#     variable = p
#   [../]
#   [./p15]
#     type = PointValue
#     point = '0.0 -0.28 0.6'
#     variable = p
#   [../]
#   [./p16]
#     type = PointValue
#     point = '0.0 -0.35 0.6'
#     variable = p
#   [../]
#   [./p17]
#     type = PointValue
#     point = '0.0 -0.42 0.6'
#     variable = p
#   [../]
#   [./p18]
#     type = PointValue
#     point = '0.0 -0.49 0.6'
#     variable = p
#   [../]
#   [./p19]
#     type = PointValue
#     point = '0.0 -0.56 0.6'
#     variable = p
#   [../]
#   [./p20]
#     type = PointValue
#     point = '0.0 -0.63 0.6'
#     variable = p
#   [../]
#   [./p21]
#     type = PointValue
#     point = '0.0 -0.7 0.6'
#     variable = p
#   [../]
#   # [./p8]
#   #   type = PointValue
#   #   point = '7.0 10.0 0.0'
#   #   variable = p
#   # [../]
#   # [./p9]
#   #   type = PointValue
#   #   point = '8.0 10.0 0.0'
#   #   variable = p
#   # [../]
#   # [./p10]
#   #   type = PointValue
#   #   point = '9.0 10.0 0.0'
#   #   variable = p
#   # [../]
#   # [./p11]
#   #   type = PointValue
#   #   point = '10.0 10.0 0.0'
#   #   variable = p
#   # [../]
#   [./p_C1]
#     type = PointValue
#     point = '0.0 0.0 0.6'
#     variable = p
#   [../]
#   [./p_C2]
#     type = PointValue
#     point = '0.0 0.0 0.4'
#     variable = p
#   [../]
#   [./p_C3]
#     type = PointValue
#     point = '0.0 0.0 0.2'
#     variable = p
#   [../]
#   [./p_C4]
#     type = PointValue
#     point = '0.0 0.0 0.0'
#     variable = p
#   [../]
#   [./p_C5]
#     type = PointValue
#     point = '0.0 0.0 -0.2'
#     variable = p
#   [../]
#   [./p_C6]
#     type = PointValue
#     point = '0.0 0.0 -0.4'
#     variable = p
#   [../]
#   [./p_C7]
#     type = PointValue
#     point = '0.0 0.0 -0.6'
#     variable = p
#   [../]
#   # [./p_bot]
#   #   type = PointValue
#   #   point = '0.0 0.0 -0.6'
#   #   variable = p
#   # [../]
# []

# [VectorPostprocessors]
#   [./disp_hist]
#     type = ResponseHistoryBuilder
#     variables = 'p'
#     nodes = '0 2070'
#   [../]
# []

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
  print_linear_residuals = true
  file_base = Exodus_Test2
  [./out]
    execute_on = 'TIMESTEP_BEGIN'
    type = CSV
    file_base = Test2
  [../]
[]
