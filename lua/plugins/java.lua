local JDK_BASE = vim.env.HOME .. "/.jdks"
local JDK17 = JDK_BASE .. "/17.0.8.1"
local JDK8 = JDK_BASE .. "/8.0.382"

vim.env.JAVA_HOME = JDK17

return {
  {
    "mfussenegger/nvim-jdtls",
    opts = {
      root_dir = function(fname)
        return vim.fs.dirname(
          vim.fs.find(
            { ".gradlew", ".gitignore", ".gitattributes", ".git", "mvnw", "build.grade.kts" },
            { upward = true }
          )[1]
        )
      end,
      jdtls = {
        settings = {
          java = {
            home = JDK17,
            errors = {
              incompleteClasspath = {
                severity = "warning",
              },
            },
            import = {
              gradle = { enabled = false },
              maven = { enabled = true },
            },
            autobuild = {
              enabled = false,
            },
            maven = {
              downloadSources = false,
              updateSnapshots = false,
            },
            format = {
              enabled = false,
            },
            saveActions = {
              organizeImports = false,
            },
            configuration = {
              updateBuildConfiguration = "disabled",
              -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
              -- And search for `interface RuntimeOption`
              -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
              runtimes = {
                {
                  name = "JavaSE-1.8",
                  path = JDK8 .. "/",
                  default = true,
                },
              },
            },
          },
        },
      },
    },
  },
}
