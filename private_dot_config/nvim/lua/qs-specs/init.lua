require('specs').setup{
    show_jumps  = true,
    min_jump = 2,
    popup = {
        delay_ms = 0, -- delay before popup displays
        inc_ms = 10, -- time increments used for fade/resize effects
        blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
        width = 20,
        winhl = "PMenu",
		resizer = require('specs').slide_resizer,
        fader = require('specs').empty_fader
    },
	ignore_filetypes = {},
	ignore_buftypes = {
		nofile = true,
	},
}
