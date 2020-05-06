require('vis')

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
    vis:command('set autoindent')
    vis:command('set colorcolumn 80')
    vis:command('set cursorline')
    vis:command('set escdelay 0')
    vis:command('set expandtab')
    vis:command('set numbers')
    vis:command('set tabwidth 4')
end)

vis:command_register("fzf", function(argv, force, win, selection, range)
    local command = "fzf" .. " " .. "" .. " " .. table.concat(argv, " ")

    local file = io.popen(command)
    local output = file:read()
    local success, msg, status = file:close()

    if status == 0 then
        vis:feedkeys(string.format(":e '%s'<Enter>", output))
    elseif status == 1 then
        vis:info(string.format("fzf-open: No match. Command %s exited with return value %i." , command, status))
    elseif status == 2 then
        vis:info(string.format("fzf-open: Error. Command %s exited with return value %i." , command, status))
    elseif status == 130 then
        vis:info(string.format("fzf-open: Interrupted. Command %s exited with return value %i" , command, status))
    else
        vis:info(string.format("fzf-open: Unknown exit status %i. command %s exited with return value %i" , status, command, status, status))
    end

    vis:feedkeys("<vis-redraw>")

    return true;
end)
