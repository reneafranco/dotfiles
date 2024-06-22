local jdtls_path = vim.fn.expand("~/.local/share/nvim/mason/bin/jdtls")

local root_markers = { 'gradlew', '.git', 'mvnw' }
local root_dir = vim.fs.dirname(vim.fs.find(root_markers, { upward = true })[1])

local config = {
    cmd = { jdtls_path },
    root_dir = root_dir,
    settings = {
        java = {}
    },
    init_options = {
        bundles = {}
    }
}

require('jdtls').start_or_attach(config)

