[Mesh]
  type = GeneratedMesh
  nx = 100
  ny = 20
  xmin = 0
  ymin = 0
  xmax = 100
  ymax = 20
  dim = 2
[]

[GlobalParams]
  displacements = 'disp_x disp_y'
[]

[Variables]
  [./disp_x]
  [../]
  [./disp_y]
  [../]
[]

# [AuxVariables]
#   [./vel_x]
#   [../]
#   [./accel_x]
#   [../]
#   [./vel_y]
#   [../]
#   [./accel_y]
#   [../]
# []

[Kernels]
  [./DynamicTensorMechanics]
    displacements = 'disp_x disp_y'
  [../]
  [./inertia_x]
    type = InertialForce
    variable = disp_x
    # velocity = vel_x
    # acceleration = accel_x
    # beta = 0.25
    # gamma = 0.5
  [../]
  [./inertia_y]
    type = InertialForce
    variable = disp_y
    # velocity = vel_y
    # acceleration = accel_y
    # beta = 0.25
    # gamma = 0.5
  [../]
[]

# [AuxKernels]
#   [./accel_x]
#     type = NewmarkAccelAux
#     variable = accel_x
#     displacement = disp_x
#     velocity = vel_x
#     beta = 0.25
#     execute_on = timestep_end
#   [../]
#   [./vel_x]
#     type = NewmarkVelAux
#     variable = vel_x
#     acceleration = accel_x
#     gamma = 0.5
#     execute_on = timestep_end
#   [../]
#   [./accel_y]
#     type = NewmarkAccelAux
#     variable = accel_y
#     displacement = disp_y
#     velocity = vel_y
#     beta = 0.25
#     execute_on = timestep_end
#   [../]
#   [./vel_y]
#     type = NewmarkVelAux
#     variable = vel_y
#     acceleration = accel_y
#     gamma = 0.5
#     execute_on = timestep_end
#   [../]
# []

[BCs]
  # [./back_y]
  #   type = DirichletBC
  #   variable = disp_y
  #   boundary = 'back'
  #   value = 0.0
  # [../]
  # [./front_y]
  #   type = DirichletBC
  #   variable = disp_y
  #   boundary = 'front'
  #   value = 0.0
  # [../]
  [./bottom_y]
    type = DirichletBC
    variable = disp_y
    boundary = 'bottom'
    value = 0.0
  [../]
  [./top_y]
    type = DirichletBC
    variable = disp_y
    boundary = 'top'
    value = 0.0
  [../]
  [./left_y]
    type = DirichletBC
    variable = disp_y
    boundary = 'left'
    value = 0.0
  [../]
  [./right_y]
    type = DirichletBC
    variable = disp_y
    boundary = 'right'
    value = 0.0
  [../]
  [./bottom_accel]
    type = FunctionDirichletBC
    variable = disp_x
    boundary = 'bottom'
    function = accel_bottom
    # type = PresetDisplacement
    # boundary = 'bottom'
    # function = accel_bottom
    # variable = 'disp_x'
    # beta = 0.25
    # acceleration = 'accel_x'
    # velocity = 'vel_x'
  [../]
[]

[Functions]
  [./accel_bottom]
    type = PiecewiseLinear
    data_file = Sin0_4x_Disp.csv
    scale_factor = 1.0
    format = 'columns'
  [../]
[]

[Materials]
  [./elastic_domain]
    type = ComputeIsotropicElasticityTensor
    lambda = -1e12
    shear_modulus = 1e12
  [../]
  [./stress_beam2]
    type = ComputeFiniteStrainElasticStress
  [../]
  [./strain_15]
    type = ComputeFiniteStrain
    displacements = 'disp_x disp_y'
  [../]
  [./density]
    type = GenericConstantMaterial
    prop_names = density
    prop_values =  1e12
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
  end_time = 5.0
  dt = 0.01
  dtmin = 0.0001
  nl_abs_tol = 1e-5
  nl_rel_tol = 1e-5
  l_tol = 1e-5
  l_max_its = 10
  timestep_tolerance = 1e-8
  automatic_scaling = true
  [TimeIntegrator]
    type = NewmarkBeta
  []
[]

[VectorPostprocessors]
  [./disp_hist]
    type = ResponseHistoryBuilder
    variables = 'disp_x disp_y'
    nodes = '0 4120'
  [../]
[]

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
  print_linear_residuals = true
  [./out]
    execute_on = 'FINAL'
    type = CSV
    file_base = Eq_Struc_Sin0_4x
  [../]
[]
