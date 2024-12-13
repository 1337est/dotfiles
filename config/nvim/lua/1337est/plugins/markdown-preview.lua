return {
	-- View markdown markups in real time
	"iamcco/markdown-preview.nvim",
	cmd = {
		"MarkdownPreviewToggle",
		"MarkdownPreview",
		"MarkdownPreviewStop",
	},
	ft = { "markdown" },
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
}
