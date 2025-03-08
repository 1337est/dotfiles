config.load_autoconfig(False)

config.source('colors.py')
config.source('fonts.py')

c.completion.height = "25%"
c.completion.scrollbar.padding = 2
c.completion.scrollbar.width = 16

c.content.pdfjs = True
c.content.user_stylesheets = ['~/.config/qutebrowser/stylesheet.css']

c.editor.command = ["ghostty", "-e", "nvim {file}"]

c.fileselect.folder.command = ["ghostty", "-e", "yazi", "--cwd-file={}"]
c.fileselect.multiple_files.command = ["ghostty", "-e", "yazi", "--chooser-file={}"]
c.fileselect.single_file.command = ["ghostty", "-e", "yazi", "--chooser-file={}"]

c.hints.find_implementation = "javascript"

c.url.default_page = "https://www.google.com/search?hl=en&q="
c.url.searchengines = {"DEFAULT": "https://google.com/search?hl=en&q={}"}
c.url.start_pages = "https://github.com"

c.zoom.default = "125%"
