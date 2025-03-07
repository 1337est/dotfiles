config.load_autoconfig(False)

c.editor.command = ["ghostty", "-e", "nvim {file}"]
c.url.searchengines = {"DEFAULT": "https://google.com/search?hl=en&q={}"}

config.source('colors.py')
