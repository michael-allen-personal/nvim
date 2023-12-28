--require('rose-pine').setup({
--    variant = 'moon'
--})
--vim.cmd [[colorscheme rose-pine]]

vim.cmd [[colorscheme nightfly]]

--local function set_color_scheme_based_on_night_mode()
--    local handle = io.popen('./check_gnome_nighttime.sh')
--    if handle == nil then
--        print("GNOME Nighttime setting could not be detected")
--        vim.cmd [[colorscheme nightfly]]
--        return
--    end
--    local result = handle:read("*n")
--    handle:close()
--
--    if result:match(1) then
--        -- Set to night color scheme
--        print("here1")
--        vim.cmd [[colorscheme rose-pine]]
--        --        vim.cmd [[colorscheme nightfly]]
--    else
--        -- Set to day color scheme
--        print("hereelse")
--        vim.cmd [[colorscheme nightfly]]
--        --        vim.cmd [[colorscheme nightfly]]
--    end
--end
--
--set_color_scheme_based_on_night_mode()

--local function test()
--    local handle = io.popen('./check_gnome_nighttime.sh')
--    local result = handle:read("*n")
--    handle:close()
--    print(result)
--end
--
--test()
