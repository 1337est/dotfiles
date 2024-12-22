return {
	"nvim-neorg/neorg",
	lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
	version = "*", -- Pin Neorg to the latest stable release
	config = function()
		require("neorg").setup({
			load = {
				["core.defaults"] = {}, -- Loads the default behaviors
				["core.concealer"] = {}, -- Makes your notes pretty
				["core.dirman"] = { -- Manages Neorg workspaces
					config = {
						workspaces = {
							-- Main notes workspace
							notes = "~/Notes", -- Main notes area

							-- My desktop is covered in notes?
							help = "~/Notes/help", -- Helpful/troubleshooting program notes
							ideas = "~/Notes/ideas", -- My brain children
							projects = "~/Notes/projects", -- Personal projects notes
							research = "~/Notes/research", -- Research notes
							rum = "~/Notes/rum", -- ruminations, my brain unleashed
							school = "~/Notes/school", -- School notes
							work = "~/Notes/work", -- Work notes
						},
						default_workspace = "notes",
					},
				},
			},
		})
	end,
}
