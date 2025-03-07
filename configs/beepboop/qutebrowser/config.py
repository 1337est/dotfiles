config.load_autoconfig(False)

config.source('colors.py')

c.completion.height = "25%"
c.completion.scrollbar.padding = 2
c.completion.scrollbar.width = 16

c.content.pdfjs = True

c.editor.command = ["ghostty", "-e", "nvim {file}"]

c.fileselect.folder.command = ["ghostty", "-e", "yazi", "--cwd-file={}"]
c.fileselect.multiple_files.command = ["ghostty", "-e", "yazi", "--chooser-file={}"]
c.fileselect.single_file.command = ["ghostty", "-e", "yazi", "--chooser-file={}"]

c.fonts.contextmenu = "default_size default_family"
c.fonts.default_family = ["JetBrainsMono Nerd Font", "monospace"]
c.fonts.default_size = "12pt"
c.fonts.prompts = "default_size default_family"
c.fonts.tooltip = "default_size default_family"
c.fonts.web.family.cursive = "default_family"
c.fonts.web.family.fantasy = "default_family"
c.fonts.web.family.fixed = "default_family"
c.fonts.web.family.sans_serif = "default_family"
c.fonts.web.family.serif = "default_family"
c.fonts.web.family.standard = "default_family"
c.fonts.web.size.default = 16
c.fonts.web.size.default_fixed = 16
c.fonts.web.size.minimum = 12
c.fonts.web.size.minimum_logical = 12

c.hints.find_implementation = "javascript"

c.url.default_page = "https://www.google.com/search?hl=en&q="
c.url.searchengines = {"DEFAULT": "https://google.com/search?hl=en&q={}"}
c.url.start_pages = "https://github.com"
