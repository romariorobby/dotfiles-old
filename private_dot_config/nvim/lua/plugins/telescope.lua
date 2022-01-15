local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end
local actions = require "telescope.actions"
local themes = require "telescope.themes"
local fb_actions = telescope.extensions.file_browser.actions
local findcmd = vim.fn.executable("rg") and 'rg' or 'fd' or 'find'

telescope.setup {
  defaults = {

    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },

    mappings = {
      i = {
        ["<C-c>"] = actions.close,
        ["<C-u>"] = actions.cycle_history_next,
        ["<C-d>"] = actions.cycle_history_prev,

        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,

        ["<CR>"] = actions.select_default,
        ["<C-s>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<C-y>"] = actions.preview_scrolling_up,
        ["<C-e>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.complete_tag,
        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
      },

      n = {
        ["<C-[>"] = actions.close,
        ["<esc>"] = actions.close,
        ["q"] = actions.close,
        ["Q"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-s>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<C-y>"] = actions.preview_scrolling_up,
        ["<C-e>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["?"] = actions.which_key,
      },
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    file_browser = {
			theme = "ivy",
			mappings = {
				["i"] = {
					-- your custom insert mode mappings
					["<C-a>"] = fb_actions.create,
					["<A-.>"] = fb_actions.toggle_hidden,
					["<C-d>"] = fb_actions.remove,
				},
				["n"] = {
					-- your custom normal mode mappings
					["."] = fb_actions.toggle_hidden,
					["d"] = fb_actions.remove,
				},
			},
		},
		media_files = {
      -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      filetypes = {"png", "webp", "jpg", "jpeg"},
			find_cmd = findcmd

		},
  },
}


pcall(telescope.load_extension, 'media_files')
pcall(telescope.load_extension, 'file_browser')

local M = {}

function M.find_buffers()
  local opts = themes.get_ivy {
		prompt_title = "Find Buffers",
		hidden = false,
		border = false,
		previewer = false,
		winblend = 10,
		layout_config = {
--			width = 0.5,
			height = 0.4,
		},
	}
  require('telescope.builtin').buffers(opts)
end

function M.find_neovim()
  require('telescope.builtin').find_files {
    prompt_title = "~ Neovim ~",
		path_display = { "absolute" },
    file_ignore_patterns = {},
    cwd = "~/.config/nvim/",

    layout_strategy = 'flex',
		layout_config = {
      width = 0.9,
      height = 0.8,
      horizontal = {
        width = { padding = 0.15 },
      },
      vertical = {
        preview_height = 0.75,
      },
    },
  }
end

function M.find_notes()
  require('telescope.builtin').find_files {
    prompt_title = "~ Notes ~",
		path_display = { "absolute" },
    cwd = "~/Sync/Media/documents/mariodump/",
    file_ignore_patterns = {
			"logseq/bak/"
		},

    layout_strategy = 'flex',
		layout_config = {
      width = 0.9,
      height = 0.8,
      horizontal = {
        width = { padding = 0.15 },
      },
      vertical = {
        preview_height = 0.75,
      },
    },
  }
end


function M.find_dotfiles()
  require('telescope.builtin').find_files {
    prompt_title = "~ Dotfiles ~",
		path_display = { "absolute" },
    file_ignore_patterns = {
			"Logseq*" ,"gnome*","notion*", "anytype2", "Binance",
			"VirtualBox" , "Electron", "spicetify", "JetBrains", "Google",
			"*.log", "*.db", "BraveSoftware", "obsidian", "VSCodium",
			"emacs", "Notion", "Rambox", "Bitwarden", "pulse",
			"persepolis_download_manager", "mpv/watch_later/*", "Mailspring", "awesome/themes/", "transmission/resume/*",
			"transmission/torrents/*", "fontforge", "calibre", "spotify", "android"
		},
    cwd = "~/.config/",

    layout_strategy = 'horizontal',
    layout_config = {
      preview_width = 0.65,
    },
  }
end
function M.grep_prompt()
  require("telescope.builtin").grep_string {
    path_display = { "shorten" },
    search = vim.fn.input "Grep String > ",
  }
end
return M
