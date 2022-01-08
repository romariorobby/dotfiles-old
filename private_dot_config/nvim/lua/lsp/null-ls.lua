local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup{
	debug = false,
	sources = {
		formatting.stylua,
		formatting.prettier.with({
			extra_args = {
				"--no-semi",
				"--single-quote",
				"--jsx-single-quote"
			}
		}),
		formatting.black.with({
			extra_args = {
				"--fast",
			}
		}),
		diagnostics.flake8
	}
}
