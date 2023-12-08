local git	 = safe_require 'git'
if not git then
	return
end

git.setup({
  keymaps = {
    -- Open blame window
    blame = "<Leader>gb",
		quit_blame = "q",
    -- Open file/folder in git repository
    browse = "<Leader>go",
  }
})


