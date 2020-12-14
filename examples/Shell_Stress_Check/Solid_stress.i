[Mesh]
  [file]
    type = FileMeshGenerator
    file = Solid_stress.e
  []
  # uniform_refine = 1
[]

[Variables]
  [./disp_x]
    order = FIRST
    family = LAGRANGE
  [../]
  [./disp_y]
    order = FIRST
    family = LAGRANGE
  [../]
  [./disp_z]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[AuxVariables]
  [./stress_xx]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
  [../]
  [./stress_yy]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
  [../]
  [./stress_xy]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
  [../]
  [./stress_zz]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
  [../]
[]

[BCs]
  # [./symm_left_rot]
  #   type = DirichletBC
  #   variable = rot_y
  #   boundary = left
  #   value = 0.0
  # [../]
  # [./symm_bottom_rot]
  #   type = DirichletBC
  #   variable = rot_x
  #   boundary = bottom
  #   value = 0.0
  # [../]
  [./simply_support_x]
    type = DirichletBC
    variable = disp_x
    boundary = 'Boundaries'
    value = 0.0
  [../]
  [./simply_support_y]
    type = DirichletBC
    variable = disp_y
    boundary = 'Boundaries'
    value = 0.0
  [../]
  [./simply_support_z]
    type = DirichletBC
    variable = disp_z
    boundary = 'Boundaries'
    value = 0.0
  [../]
[]

[NodalKernels]
  [./force_y2]
    type = ConstantRate
    variable = disp_z
    boundary = 'Nodes'
    rate = -1.0
  [../]
[]

[Preconditioning]
  [./smp]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  type = Transient
  solve_type = NEWTON
  petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
  petsc_options_value = 'lu       superlu_dist'
  nl_rel_tol = 5e-6
  nl_abs_tol = 5e-6
  dt = 1.0
  dtmin = 1.0
  end_time = 2.0
[]

[Kernels]
  [./DynamicTensorMechanics]
    displacements = 'disp_x disp_y disp_z'
    block = 1
  [../]
[]

[AuxKernels]
  [./stress_xx]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xx
    index_i = 0
    index_j = 0
    block = '1'
  [../]
  [./stress_yy]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_yy
    index_i = 1
    index_j = 1
    block = '1'
  [../]
  [./stress_xy]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xy
    index_i = 0
    index_j = 1
    block = '1'
  [../]
  [./stress_zz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_zz
    index_i = 2
    index_j = 2
    block = '1'
  [../]
[]

[Materials]
  [./elasticity_base]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 1e9
    poissons_ratio = 0.3
    block = 1
  [../]
  [./strain]
    type = ComputeFiniteStrain
    block = 1
    displacements = 'disp_x disp_y disp_z'
  [../]
  [./stress]
    type =  ComputeFiniteStrainElasticStress
    block = 1
  [../]
[]

[Postprocessors]
  [./disp_z2]
    type = PointValue
    point = '0.0 0.0 0.0'
    variable = disp_z
  [../]
  [./stress1]
    type = PointValue
    point = '0.0 0.0 0.0'
    variable = stress_xx
  [../]
  [./stress2]
    type = PointValue
    point = '0.0 0.0 0.0'
    variable = stress_yy
  [../]
  [./stress3]
    type = PointValue
    point = '0.0 0.0 0.0'
    variable = stress_zz
  [../]
[]

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
  print_linear_residuals = true
  file_base = Ex_Solid_stress
  [./out]
    execute_on = 'TIMESTEP_BEGIN'
    type = CSV
    file_base = Solid_stress
  [../]
[]
