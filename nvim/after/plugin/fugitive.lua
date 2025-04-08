local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
--test
local function git_commit_push()
  -- Open a Telescope prompt for the commit message
  require('telescope.builtin').input({
    prompt_title = 'Commit Message',
    prompt_prefix = '✏️ ',
    default_text = '',
    on_submit = function(commit_message)
      if not commit_message or commit_message == "" then
        print("Commit message is required!")
        return
      end

      -- Prompt for remote (default: origin)
      require('telescope.builtin').input({
        prompt_title = 'Remote (default: origin)',
        default_text = 'origin',
        on_submit = function(remote)
          remote = remote or "origin"

          -- Prompt for branch (default: main)
          require('telescope.builtin').input({
            prompt_title = 'Branch (default: main)',
            default_text = 'main',
            on_submit = function(branch)
              branch = branch or "main"

              -- Run the Git commands using Fugitive
              vim.cmd("Git add .")
              vim.cmd('Git commit -m "' .. commit_message .. '"')
              vim.cmd("Git push " .. remote .. " " .. branch)

              print("Changes pushed to " .. remote .. "/" .. branch)
            end,
          })
        end,
      })
    end,
  })
end

-- Create a custom Telescope picker command
vim.api.nvim_create_user_command('Gcp', git_commit_push, {})

