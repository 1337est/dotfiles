# At the top level perform these operations

## youhavemail
Under vdirsyncer, you have a `template` file that needs to be copied as a `config` file. After you `cp template config`, change the emails to be what vdirsyncer discover shows. Then enable the vdirsyncer timer.
```nu
cp template config
nvim config
vdirsyncer discover
vdirsyncer sync
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
# etc. You can find your `accountx` in $XDG_CONFIG_HOME/imapnotify/accountx.yaml
systemctl --user enable goimapnotify@account1.service
systemctl --user enable goimapnotify@account2.service
systemctl --user start goimapnotify@account1.service
systemctl --user start goimapnotify@account2.service

systemctl --user enable vdirsyncer.timer
```
