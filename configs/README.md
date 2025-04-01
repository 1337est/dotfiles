# At the top level perform these operations
```nu
cd ~/Github/dotfiles/configs/
```

## confighome
```nu
stow -d confighome/ de shellements youhavemail -t ~/.config/

# if errors due to atuin/carapace
rm -r ~/.config/atuin ~/.config/carapace; stow -d confighome/ de shellements youhavemail -t ~/.config/
```

## datahome
```nu
stow datahome -t ~/.local/share/
```

## gnupghome
```nu
stow gnupghome -t ~/.gnupg/
```


## systemduser
```nu
stow systemduser -t ~/.config/systemd/user/

# After successful stow, potential symlinks needed to remove
rm ~/.config/systemd/user/default.target.wants/sync-mail.service
systemctl --user daemon-reload
systemctl --user enable sync-mail.service
```

As an aside, if you don't have `~/.config/systemd/user/default.target.wants/goimapnotify@account.service`, then run the following commands:

```nu
systemctl --user enable goimapnotify@account1.service
systemctl --user start goimapnotify@account1.service
systemctl --user enable goimapnotify@account2.service
systemctl --user start goimapnotify@account2.service
# etc. You can find your `accountx` in $XDG_CONFIG_HOME/imapnotify/accountx.yaml
```
