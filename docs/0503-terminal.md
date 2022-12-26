### Shell Profile

The emulated terminals, [GNOME terminal](https://packages.debian.org/stretch/gnome-terminal) or [LXTerminal](https://packages.debian.org/stretch/lxterminal), are **non-login** shells. The start-up script is `~/.bashrc`, not `~/.bash_profile`. If we want to modify the `PATH` variable for the emulated GNOME terminal, for example, it should be modified in `~/.bashrc`.

On the other hand, `~/.bash_profile` is read by login shells. To go to a login shell, type Ctrl+Alt+F1 to swich to `tty1`, for example. The desktop usually runs at `tty3`, we can switch back by Ctrl+Alt+F3.

There is also `~/.profile`, which is for the generic shell `sh` (`bash` is a specific implementation of `sh`). Its documentation says "~/.profile: executed by the command interpreter for login shells. This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login exists."

To get a consistent environment across the login shells and the non-login shells, source `~/.bashrc` in `~/.bash_profile`. Also include `~/.profile` in `~/.bash_profile`. Here is what `~/.bash_profile` looks like:

```bash
if [ -r "${HOME}/.profile" ]; then
    . "${HOME}/.profile"
fi

if [ -r "${HOME}/.bashrc" ]; then
    . "${HOME}/.bashrc"
fi
```

### Mac OS and Z Shell

The terminal of Mac OS is an emulated non-login shell. That said, `~/.bashrc`, not `~/.bash_profile`, should be edited for the shell environment. Later versions of Mac OS terminal runs Z shell. To find out the name the current shell, `ps -p $$`. For zsh, edit `~/.zshrc`.

### Resources

[Debian Wiki of Environment Variables](https://wiki.debian.org/EnvironmentVariables)
