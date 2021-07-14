[Mesh]
  [gen]
    type = GeneratedMeshGenerator
    nx = 4000
    xmin = 0.0
    xmax = 200
    dim = 1
  []
  [subdomain1]
    type = SubdomainBoundingBoxGenerator
    input = gen
    bottom_left = '0 0 0'
    top_right = '100 0 0'
    block_id = 1
  []
  [subdomain2]
    type = SubdomainBoundingBoxGenerator
    input = subdomain1
    bottom_left = '100 0 0'
    top_right = '200 0 0'
    block_id = 2
  []
  [interface1]
    type = SideSetsBetweenSubdomainsGenerator
    input = subdomain2
    primary_block = 1
    paired_block = 2
    new_boundary = 'Interface'
  []
[]

[GlobalParams]
[]

[Variables]
  [p]
   block = 1
  []
  [disp_x]
    block = 2
  []
[]

[AuxVariables]
  [Wave1]
    block = 1
  []
  [./vel_x]
    order = FIRST
    family = LAGRANGE
    block = 2
  []
  [accel_x]
    order = FIRST
    family = LAGRANGE
    block = 2
  []
  [stress_xx]
    block = 2
    order = CONSTANT
    family = MONOMIAL
  []
[]

[Kernels]
  [diffusion]
    type = Diffusion
    variable = 'p'
    block = 1
  []
  [inertia]
    type = AcousticInertia
    variable = p
    block = 1
  []
  [DynamicTensorMechanics]
    displacements = 'disp_x'
    block = 2
  []
  [inertia_x1]
    type = InertialForce
    variable = disp_x
    block = 2
  []
[]

[AuxKernels]
  [waves]
    type = WaveHeightAuxKernel
    variable = 'Wave1'
    pressure = p
    density = 1e-6
    gravity = 9.81
    execute_on = timestep_end
    block = 1
  []
  [accel_x]
    type = TestNewmarkTI
    displacement = disp_x
    variable = accel_x
    first = false
    block = 2
  []
  [vel_x]
    type = TestNewmarkTI
    displacement = disp_x
    variable = vel_x
    block = 2
  []
  [stress_xx]
    block = 2
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xx
    index_i = 0
    index_j = 0
  []
[]

[InterfaceKernels]
  [interface1]
    type = FluidStructureInterface # FSI_test
    variable = p # disp_x
    neighbor_var = disp_x # p
    boundary = 'Interface'
    D = 1e-6
    component = 0
  []
[]

[BCs]
  [bottom_accel1]
    type = FunctionDirichletBC
    variable = p
    boundary = 'left'
    function = accel_bottom
  []
  [disp_x2]
    type = NeumannBC # DirichletBC
    variable = disp_x
    boundary = 'right'
    value = 0.0
  []
[]

[Functions]
  [accel_bottom]
    type = PiecewiseLinear
    data_file = Sine.csv
    format = 'columns'
    scale_factor = 1.0
  []
[]

[Materials]
  [density]
    type = GenericConstantMaterial
    prop_names = inv_co_sq
    prop_values = 4.65e-7
    block = 1
  []
  [density0]
    type = GenericConstantMaterial
    block = 2
    prop_names = density
    prop_values = 4.0e-6
  []
  [elasticity_base]
    type = ComputeIsotropicElasticityTensor
    shear_modulus = 0.0
    bulk_modulus = 2.25
    block = 2
  []
  [strain]
    type = ComputeFiniteStrain
    block = 2
    displacements = 'disp_x'
  []
  [stress]
    type =  ComputeFiniteStrainElasticStress
    block = 2
  []
[]

[Preconditioning]
  [andy]
    type = SMP
    full = true
  []
[]

[Executioner]
  type = Transient
  petsc_options = '-ksp_snes_ew'
  petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
  petsc_options_value = 'lu       superlu_dist'
  solve_type = 'NEWTON'
  nl_rel_tol = 1e-12 # 1e-10
  nl_abs_tol = 1e-12 # 1e-8
  # l_tol = 1e-2
  start_time = 0.0
  dt = 0.0001 # 0.0025
  end_time = 0.16
  timestep_tolerance = 1e-6
  automatic_scaling = true
  [TimeIntegrator]
    type = NewmarkBeta
    # beta = 0.3025
    # gamma = 0.6
  []
[]

[Postprocessors]
  [pressure1]
    type = PointValue
    point = '50.0 0.0 0.0'
    variable = p
  []
  [stress1]
    type = PointValue
    point = '150.0 0.0 0.0'
    variable = stress_xx
  []
[]

[Outputs]
  exodus = true
  perf_graph = true
  csv = true
  [./out1]
    type = CSV
    execute_on = 'final'
  [../]
[]
