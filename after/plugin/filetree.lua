-- See documentation for this plugin here: https://github.com/nvim-neo-tree/neo-tree.nvim
-- or run :h neo-tree
vim.keymap.set({ 'n', 'c' }, '<leader>ft', ':Neotree toggle<CR>',
    { desc = 'Toggle [f]ile [t]ree', noremap = true, silent = true })

require 'nvim-web-devicons'.setup()

local highlights = require("neo-tree.ui.highlights")

require("neo-tree").setup({
    close_if_last_window = true,
    filesystem = {
        window = {
            position = 'left',
            width = 30,
        },
        components = {
            -- unused function input is state
            harpoon_index = function(config, node, _)
                local Marked = require("harpoon.mark")
                local path = node:get_id()
                local succuss, index = pcall(Marked.get_index_of, path)
                if succuss and index and index > 0 then
                    return {
                        text = string.format(" ⥤ %d", index), -- <-- Add your favorite harpoon like arrow here
                        highlight = config.highlight or "NeoTreeDirectoryIcon",
                    }
                else
                    return {}
                end
            end,
            -- again, unused is state
            icon = function(config, node, _)
                local icon = config.default or " "
                local padding = config.padding or " "
                local highlight = config.highlight or highlights.FILE_ICON

                if node.type == "directory" then
                    highlight = highlights.DIRECTORY_ICON
                    if node:is_expanded() then
                        icon = config.folder_open or "-"
                    else
                        icon = config.folder_closed or "+"
                    end
                elseif node.type == "file" then
                    local success, web_devicons = pcall(require, "nvim-web-devicons")
                    if success then
                        local devicon, hl = web_devicons.get_icon(node.name, node.ext)
                        icon = devicon or icon
                        highlight = hl or highlight
                    end
                end

                return {
                    text = icon .. padding,
                    highlight = highlight,
                }
            end,
        },
        renderers = {
            file = {
                { "icon" },
                { "name",         use_git_status_colors = true },
                { "harpoon_index" }, --> This is what actually adds the component in where you want it
                { "diagnostics" },
                { "git_status",   highlight = "NeoTreeDimText" },
            }
        }
    },
})

vim.cmd([[
highlight! link NeoTreeDirectoryIcon NvimTreeFolderIcon
highlight! link NeoTreeDirectoryName NvimTreeFolderName
highlight! link NeoTreeSymbolicLinkTarget NvimTreeSymlink
highlight! link NeoTreeRootName NvimTreeRootFolder
highlight! link NeoTreeDirectoryName NvimTreeOpenedFolderName
highlight! link NeoTreeFileNameOpened NvimTreeOpenedFile
]])
