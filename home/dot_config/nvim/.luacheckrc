ignore = {
  '212/_.*', -- unused argument, for vars with "_" prefix
  '214', -- used variable with unused hint ("_" prefix)
}

-- Global objects defined by the C code
read_globals = {
  'vim',
}
