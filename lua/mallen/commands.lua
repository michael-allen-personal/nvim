_G.gitCommitAndPush = function(message)
    local cmd = string.format("git add . && git commit -m '%s' && git push", message)
    vim.cmd('! ' .. cmd)
end

vim.api.nvim_command(
    'command -nargs=1 GCP call luaeval("gitCommitAndPush(_A)", <q-args>) " [g]it add ./ && git [c]ommit -m <provided message> && git [p]ush')

vim.api.nvim_create_user_command('Term', function()
    vim.cmd('below split')
    vim.cmd('resize 14')
    vim.cmd('terminal')
end, {})
