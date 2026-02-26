+++
date = '2026-02-26T11:44:19+07:00'
draft = false
title = 'Fcitx5 for macOS'
summary = "A guide on installing and using the Fcitx5 input method on macOS for smooth Vietnamese typing."
+++

# Installation

[GitHub Repository](https://github.com/fcitx/fcitx5-macos)

You can find the installation command instructions [here](https://github.com/fcitx-contrib/fcitx5-macos-installer/blob/master/README.zh-CN.md).

```bash
cd /tmp && rm -rf Fcitx5Installer.app && curl -LO https://github.com/fcitx-contrib/fcitx5-macos-installer/releases/download/latest/Fcitx5Installer.zip && unzip Fcitx5Installer.zip && open Fcitx5Installer.app
```

# Pros and Cons

- Unlike tools such as Unikey, EVKey, or Bamboo, Fcitx5 feels more native to macOS. It integrates seamlessly with the system, allowing you to switch languages using the default macOS keyboard shortcuts.
- It is easy to automate with Hammerspoon and `macism` to change the input language via code or the CLI.

# Note
- When installing Fcitx5 and adding an input source, be sure to select the English version (Fcitx5 provides both English and Chinese versions).

# macism 
`macism` is a command-line tool for switching input sources on macOS.

- [GitHub Repository](https://github.com/laishulu/macism)
- **Installation:**
```bash
brew tap laishulu/homebrew
brew install macism
```