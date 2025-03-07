local telescope = require("telescope")

return telescope.register_extension({
  exports = {
    changes = require("telescope._extensions.git_telescope.telescope_extension").git_changes,
    staged = require("telescope._extensions.git_telescope.telescope_extension").git_staged,
    stashes = require("telescope._extensions.git_telescope.telescope_extension").git_stashes,
  },
})


