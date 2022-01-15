local status_ok, luasnip = pcall(require, "luasnip")
if not status_ok then
	return
end
local snippet = luasnip.snippet
local text = luasnip.text_node
local f = luasnip.function_node
local insert = luasnip.insert_node

luasnip.config.set_config {
  history = true,
  region_check_events = "CursorMoved,CursorHold,InsertEnter",
  delete_check_events = "InsertLeave",
  enable_autosnippets = true,
}

luasnip.snippets = {
  lua = {
    -- credit: akinsho
    snippet({
      trig = "use",
      name = "packer use",
      dscr = {
        "packer use plugin block",
        "e.g.",
        'use ({"author/plugin"})',
      },
    }, {
      text "use ({'",
      -- Get the author and URL in the clipboard and auto populate the author and project
      f(function(_)
        local default = "author/plugin"
        local clip = vim.fn.getreg "*"
        if not vim.startswith(clip, "https://github.com/") then
          return default
        end
        local parts = vim.split(clip, "/")
        if #parts < 2 then
          return default
				elseif #parts > 5 then
					author, project = parts[4], parts[5]
				else
        	author, project = parts[#parts - 1], parts[#parts]
				end
        return author .. "/" .. project
      end, {}),
      text "'",
      -- insert(2, { ", config = function()", "", "end" }),
      insert(2, {",", "\t config = function()", "", "end" }),
      text "})",
    }),
		snippet("test-trigger", {
			text({"", "After expanding, the cursor is here ->"}), insert(1),
			text({"After jumping forward once, cursor is here ->"}), insert(2),
			text({"", "After jumping once more, the snippet is exited there ->"}), insert(0),
		}),
  },
}

require("luasnip.loaders.from_vscode").load {
  paths = vim.fn.stdpath "config" .. "/snippets",
}
