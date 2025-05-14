return {
  settings = {
    yaml = {
      keyOrdering = false,
    },
    -- Haven't got this working to correctly identify K8s Schemas
    -- https://github.com/yannh/kubernetes-json-schema
    schemas = {
      kubernetes = '**/templates/**/*.yaml',
    },
  },
}
