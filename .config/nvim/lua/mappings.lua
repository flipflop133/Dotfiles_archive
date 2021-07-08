local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local o = {}

-- Format
map("n", "<A-f>", [[<Cmd> Neoformat<CR>]],opt)
map("n" , "<C-n>",[[<Cmd> NvimTreeToggle<CR>]],opt)
map("n", "<leader>r", [[<Cmd> NvimTreeRefresh<CR>]], opt)
map("n", "<leader>n", [[<Cmd> NvimTreeFindFile<CR>]], opt)

