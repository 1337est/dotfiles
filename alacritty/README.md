# Alacritty Configuration Summary

The alacritty.toml file in the Dotfiles/alacritty/ directory contains the configuration settings for the Alacritty terminal emulator. Below is a summary of the key configurations and their purposes:

## [shell]
- **program**: Specifies the shell program to use, in this case, "/usr/bin/zsh".
- **args**: Additional arguments passed to the shell program, such as "-1" for single line prompt mode.

## [window]
- **padding**: I don't want any padding around the terminal window. x=0, y=0
- **decorations**: Defines the window decorations style, here set to "Full".
- **opacity**: Sets the opacity level of the terminal window (0.90 for 90% opacity).
- **blur**: Controls whether window blur effect is enabled (false for disabled).
- **class**: Defines the window class properties for Alacritty instances.

## [scrolling]
- **history**: Specifies the scrollback history size.
- **multiplier**: Controls the scrolling speed multiplier.

## [font]
- Defines the font family, style, and size for normal, bold, italic, and bold-italic text.

## [colors]
- **draw_bold_text_with_bright_colors**: Self explanatory.
- **transparent_background_colors**: Enables transparent background colors.

## [colors.primary], [colors.normal], [colors.bright]
- Sets the color palette for foreground, background, and text colors for normal and bright modes.

## [selection]
- **save_to_clipboard**: Saves selected text to clipboard.

## [cursor]
- **style**: Defines the cursor shape and blinking behavior.
- **blink_interval**: Sets the cursor blink interval in milliseconds.
- **blink_timeout**: Sets the cursor blink timeout.

## [terminal]
- **osc52**: Specifies the OSC 52 escape sequence, which is a feature in terminal emulators like Alacritty that allows for efficient clipboard copy-paste operations. OSC stands for "Operating System Command" and is a type of control sequence used in terminal emulators to send commands and information to the terminal or underlying OS. "OSC 52" specifically deals with clipboard settings. Setting `osc52 = "CopyPaste"` will let Alacritty know to interpret selected text by copying it to the clipboard.

## [mouse]
- **hide_when_typing**: Hides the mouse cursor when typing.

## [hints]
- **alphabet**: Defines the hint characters used for quick navigation.

This summary provides an overview of the various configuration options available in my alacritty.toml file, allowing for a customized and efficient Alacritty terminal experience tailored to personal my preferences and workflow.
