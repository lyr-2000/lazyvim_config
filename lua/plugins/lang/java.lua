return {

  {
    "nvim-java/nvim-java",
    optional = true,
    dependencies = {
      {
        "neovim/nvim-lspconfig",
        opts = {
          servers = {
            jdtls = {
              settings = {
                java = {
                  configuration = {
                    updateBuildConfiguration = "automatic",
                  },
                  codeGeneration = {
                    toString = {
                      template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                    },
                    useBlocks = true,
                  },
                  completion = {
                    favoriteStaticMembers = {
                      "org.assertj.core.api.Assertions.*",
                      "org.junit.Assert.*",
                      "org.junit.Assume.*",
                      "org.junit.jupiter.api.Assertions.*",
                      "org.junit.jupiter.api.Assumptions.*",
                      "org.junit.jupiter.api.DynamicContainer.*",
                      "org.junit.jupiter.api.DynamicTest.*",
                      "org.mockito.Mockito.*",
                      "org.mockito.ArgumentMatchers.*",
                      "org.mockito.Answers.*",
                    },
                    importOrder = { "#", "java", "javax", "org", "com" },
                  },
                  contentProvider = {
                    preferred = "fernflower",
                  },
                  eclipse = {
                    downloadSources = true,
                  },
                  flags = {
                    allow_incremental_sync = true,
                    server_side_fuzzy_completion = true,
                  },
                  implementationsCodeLens = {
                    enabled = false, -- Don"t automatically show implementations
                  },
                  inlayHints = {
                    parameterNames = {
                      enabled = "all",
                    },
                  },
                  maven = {
                    downloadSources = true,
                  },
                  referencesCodeLens = {
                    enabled = false, -- Don"t automatically show references
                  },
                  references = {
                    includeDecompiledSources = true,
                  },
                  saveActions = {
                    organizeImports = true,
                  },
                  signatureHelp = {
                    enabled = true,
                  },
                  sources = {
                    organizeImports = {
                      starThreshold = 9999,
                      staticStarThreshold = 9999,
                    },
                  },
                },
              },
            },
          },
        },
      },
    },
  },

}
