return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        sql = { "sqlfluff" },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "sqlfluff",
      },
    },
  },
}
