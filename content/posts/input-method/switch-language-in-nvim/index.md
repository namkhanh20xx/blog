+++
date = '2026-02-26T15:40:03+07:00'
draft = true
title = 'Switch Language in Nvim'
summary = 'Lua code to automate switching languages in Neovim'
+++
# Automating Language Switching While Coding

Desired Behavior:
- When changing to Insert mode: switch to the previously used language layout (e.g., Vietnamese, Chinese, English).
- When changing to Normal mode: switch to the English layout.

Here is how to achieve this:

```lua
-- set language based on vim mode
-- requires macism (macOS) or fcitx5-remote (Linux)
-- NOTE: using Fcitx5.fcitx5 in macos keyboard (not Fcitx5.zhHans)
local vim = vim
local sysname = vim.loop.os_uname().sysname
local is_mac = sysname == "Darwin" and vim.fn.executable("macism") == 1
local is_linux = sysname == "Linux" and vim.fn.executable("fcitx5-remote") == 1

local noop = function() end

if not (is_mac or is_linux) then
	return {
		switch_to_vietnamese = noop,
		switch_to_english = noop,
	}
end

local english = is_mac and "com.apple.keylayout.ABC" or "keyboard-us"
local vietnamese = is_mac and "org.fcitx.inputmethod.Fcitx5.fcitx5" or "keyboard-vietnamese"
local last_layout = english

local function get_layout()
	local cmd = is_mac and "macism" or "fcitx5-remote -n"
	local f = io.popen(cmd)
	if f then
		local result = f:read("*all"):gsub("%s+", "")
		f:close()
		return result
	end
	return english
end

local function set_layout(layout)
	local cmd = is_mac and ("macism " .. layout) or ("fcitx5-remote -s " .. layout)
	os.execute(cmd)
end

local function switch_to_vietnamese()
  set_layout(vietnamese)
end

local function switch_to_english()
  set_layout(english)
end

vim.api.nvim_create_autocmd("InsertLeave", {
	callback = function()
		last_layout = get_layout()
		set_layout(english)
	end,
})

vim.api.nvim_create_autocmd("InsertEnter", {
	callback = function()
		set_layout(last_layout)
	end,
})

vim.api.nvim_create_autocmd("FocusGained", {
	callback = function()
		if vim.fn.mode() == "i" then
			set_layout(last_layout)
		else
			set_layout(english)
		end
	end,
})

return {
	switch_to_vietnamese = switch_to_vietnamese,
  switch_to_english = switch_to_english,
}

```

# Automating Language Switching in ToggleTerm

I use ToggleTerm with shortcuts like `Alt + 1`, `2`, `3` to toggle the terminal, `gemini-cli`, and `claude-cli`. I want to automatically switch to the Vietnamese layout when opening these terminals to easily write prompts. Here is how I set it up:

```lua
local switch_to_vietnamese = require("extras.language-nvim").switch_to_vietnamese
local switch_to_english = require("extras.language-nvim").switch_to_english

-- delay a bit to fix bug
local function start_insert()
  vim.defer_fn(function()
    vim.cmd("startinsert!")
  end, 50)
end

-- toggle claude terminal
vim.keymap.set({ "n", "t" }, "<A-2>", function()
	require("toggleterm.terminal").Terminal
		:new({
			id = 2,
			cmd = "claude",
			on_open = function(term)
        start_insert()
        switch_to_vietnamese()
			end,
			on_close = switch_to_english,
			direction = "float",
			float_opts = opts.float_opts,
		})
		:toggle()
end, { desc = "Toggle claude terminal" })

```