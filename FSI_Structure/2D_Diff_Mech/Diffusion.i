[Mesh]
  type = GeneratedMesh
  nx = 100
  ny = 20
  xmin = 0
  ymin = 0
  xmax = 10
  ymax = 10
  dim = 2
[]

[Variables]
  [./p]
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

[BCs]
  # [./bottom_y]
  #   type = DirichletBC
  #   variable = p
  #   boundary = 'bottom'
  #   value = 0.0
  # [../]
  # [./top_y]
  #   type = DirichletBC
  #   variable = p
  #   boundary = 'top'
  #   value = 0.0
  # [../]
  # [./left_y]
  #   type = DirichletBC
  #   variable = p
  #   boundary = 'left'
  #   value = 0.0
  # [../]
  # [./right_y]
  #   type = DirichletBC
  #   variable = p
  #   boundary = 'right'
  #   value = 0.0
  # [../]
  [./bottom_accel]
    # type = ArrayVacuumBC
    type = FunctionDirichletBC
    variable = p
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
    data_file = Sin9x_Disp.csv
    scale_factor = 1.0
    format = 'columns'
  [../]
[]

[Materials]
  # [./elastic_domain]
  #   type = ComputeIsotropicElasticityTensor
  #   bulk_modulus = 2200000000
  #   poissons_ratio = 0.499
  # [../]
  # [./stress_beam2]
  #   type = ComputeFiniteStrainElasticStress
  # [../]
  # [./strain_15]
  #   type = ComputeFiniteStrain
  #   displacements = 'disp_x disp_y'
  # [../]
  [./density]
    type = GenericConstantMaterial
    prop_names = density
    prop_values =  4.756e-7
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
  end_time = 10.0
  dt = 0.01
  dtmin = 0.0001
  nl_abs_tol = 1e-8
  nl_rel_tol = 1e-8
  l_tol = 1e-8
  l_max_its = 25
  timestep_tolerance = 1e-8
  [TimeIntegrator]
    type = NewmarkBeta
  []
[]

[VectorPostprocessors]
  [./disp_hist]
    type = ResponseHistoryBuilder
    variables = 'p'
    # nodes = '0 115'
    nodes = '0 2070'
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
    file_base = Diffusion_Sin9x
  [../]
[]
