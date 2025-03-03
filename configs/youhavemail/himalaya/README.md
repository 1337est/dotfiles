# Summary
The `config.toml` file is in my `.gitignore`. I didn't want my emails exposed on the internet for scrapers to send me more junk mail than I already get. The `example.toml` file has my setup at current with modifications to hide my personal data.

## Generate the config
If you go through the `himalaya` wizard, everything should be set up properly for your emails. I went through a lot of painstaking effort, reading the himalaya source code, asking for AI assistance, and lots of testing in the toml document itself in order to figure out how I could pass an environment variable or command through the toml document to no avail. Although convoluted, taking the generated config file from the nushell wizard, then updating that config file with a nushell script for reproducability, was the simpler approach. I would suggest taking a look at my himalaya nushell script located here -> `dotfiles/configs/beepboop/nushell/scripts/himalaya/gen_config.nu` in order to understand what's going on under the hood. It's a very straightforward script.

## Dependencies
- **`nushell`**: The `gen_config.nu` file is where you can see how I generate a "hidden" email scheme. This of course has a dependency on nushell itself to accomplish, but there are other tools (plural) that do what nushell can do if you don't have nushell installed on your system. I would personally suggest installing nushell and getting good at it. You don't have to make it the default shell, but its toolchain helps in a lot of applications.
- **`pass`**: The `pass` is a password manager utility that securely stores your passwords/secrets in a GPG-encrypted file, organized in a beautiful directory structure.

## Notes
- A nice way to view/read messages is `himalaya message read <id> | bat --language Email --plain`. This allows for good syntax highlighting and doesn't break up the url strings so you can still `<Ctrl>LeftMouseClick` them and have them open up.
