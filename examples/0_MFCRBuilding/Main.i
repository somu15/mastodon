[StochasticTools]
[]

[Samplers]
  [Acc]
    type = CSVSampler
    samples_file = 'Eq_Data0.csv'
    execute_on = 'PRE_MULTIAPP_SETUP'
  []
[]

[MultiApps]
  [sub]
    type = SamplerFullSolveMultiApp
    input_files = Model_GMs.i
    sampler = Acc
    mode = batch-reset
  []
[]

[Controls]
  [cmdline]
    type = MultiAppCommandLineControl
    multi_app = sub
    sampler = Acc
    param_names = 'number end1 dt1'
  []
[]

[Executioner]
  type = Steady
[]

[Outputs]
  csv = true
  # json = true
  exodus = false
  execute_on = 'FINAL'
[]
