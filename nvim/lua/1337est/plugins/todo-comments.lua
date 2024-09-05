return {
	-- FIX: (or FIXME, BUG, FIXIT, ISSUE) - Something that needs fixin
	-- TODO: Something you want to do
	-- HACK: Weird code warning
	-- WARN: (or WARNING, XXX) - Warning about something, so be cautious
	-- PERF: (or OPTIM, PERFORMANCE, OPTIMIZE) - Optimization tag
	-- NOTE: Use for leaving notes.
	-- TEST: (or TESTING, PASSED, FAILED) - a test
	"folke/todo-comments.nvim",
	event = "VimEnter",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = { signs = false },
}
