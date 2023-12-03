local ok,easypick = pcall(require,"easypick")
if not ok then
    vim.notify "easypick config not loaded"
    return
end

--- @help {easypick.nvim-configuration}
easypick.setup({
	pickers = {
		{
			name = "ls",
			command = "ls",
			previewer = easypick.previewers.default()
		},

		-- diff current branch with base_branch and show files that changed with respective diffs in preview
		--{
		--	name = "changed_files",
		--	command = "git diff --name-only $(git merge-base HEAD " .. base_branch .. " )",
		--	previewer = easypick.previewers.branch_diff({base_branch = base_branch})
		--},

		-- list files that have conflicts with diffs in preview
		{
			name = "conflicts",
			command = "git diff --name-only --diff-filter=U --relative",
			previewer = easypick.previewers.file_diff()
		},
	}
})
