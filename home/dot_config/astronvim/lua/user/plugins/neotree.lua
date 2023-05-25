return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    sort_case_insensitive = true,
    filesystem = {
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = true,
        always_show = {
          ".gitignore",
          ".env",
        }
      },
    },
  }
}
