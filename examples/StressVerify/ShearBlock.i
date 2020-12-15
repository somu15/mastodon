
[Mesh]
  type = GeneratedMesh
  dim = 2
  ny = 50
  ymin = 0.0
  ymax = 1.0
  nx = 50
  xmin = 0.0
  xmax = 1.0
  displacements = 'disp_x disp_y'
[]

[Variables]
  [./disp_x]
  [../]
  [./disp_y]
  [../]
[]

[AuxVariables]
  [./stress_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
[]

[Kernels]
  [./DynamicTensorMechanics]
    displacements = 'disp_x disp_y'
  [../]
[]

[AuxKernels]
  [./stress_xx]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xx
    index_i = 0
    index_j = 0
  [../]
[]

[BCs]
  [./fixx1]
    type = DirichletBC
    variable = disp_x
    boundary = left
    value = 0.0
  [../]
  [./fixy1]
    type = DirichletBC
    variable = disp_y
    boundary = left
    value = 0.0
  [../]
[]

[NodalKernels]
  [./force_y2]
    type = ConstantRate
    variable = disp_x
    boundary = top
    rate = 1.0e-4
  [../]
[]

[Materials]
  [./elasticity]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 2.60072400269
    poissons_ratio = 0.3
  [../]
  [./strain]
    type = ComputeFiniteStrain
    displacements = 'disp_x disp_y'
  [../]
  [./stress]
    type =  ComputeFiniteStrainElasticStress
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
  # solve_type = 'NEWTON'
  # petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
  # petsc_options_value = 'lu       superlu_dist'
  # nl_max_its = 15
  # nl_abs_tol = 1e-12
  # nl_rel_tol = 1e-12
  # l_tol = 1e-12
  # l_abs_tol = 1e-12
  solve_type = NEWTON
  line_search = 'none'
  nl_max_its = 15
  nl_rel_tol = 1e-10
  nl_abs_tol = 1e-10

  dt = 1
  dtmin = 1
  end_time = 2
[]

[Postprocessors]
  # [./disp_x]
  #   type = PointValue
  #   point = '4.0 0.0 0.0'
  #   variable = disp_x
  # [../]
  # [./disp_y]
  #   type = PointValue
  #   point = '4.0 0.0 0.0'
  #   variable = disp_y
  # [../]
  [./moment_x_bot]
    type = SidesetMoment
    direction = '1 0'
    stress_tensor = stress
    boundary = 'Moment'
    ref_point = '0.0 0.0'
  [../]
[]

[Outputs]
  file_base = 'beam_solid'
  exodus = true
[]
