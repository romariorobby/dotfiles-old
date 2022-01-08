local status_ok, orgmode = pcall(require,"orgmode")
if not status_ok then
	return
end

orgmode.setup({
  org_agenda_files = {'~/Documents/marioorg/*'},
  org_default_notes_file = '~/Dropbox/marioorg/refile.org',
	mappings = {
		global = {
			org_agenda = '<leader>na',
			org_capture = '<leader>nc',
		}
	}
})
