require("meow")
function _G.SetFiletype()
  local file_path = vim.fn.expand("%:p")

  if string.match(file_path, "/charts/") or string.match(file_path, "templates/") then
    vim.bo.filetype = "helm"
    return
  end

  local ansible_indicators = { "hosts", "tasks", "vars", "playbook", "ansible.builtin" }
  for _, keyword in ipairs(ansible_indicators) do
    if vim.fn.search(keyword, "nw") > 0 then
      vim.bo.filetype = "yaml.ansible"
      return
    end
  end

  vim.bo.filetype = "yaml"
end

vim.cmd [[
  augroup FiletypeDetection
    autocmd!
    autocmd BufRead,BufNewFile *.yaml,*.yml lua SetFiletype()
  augroup END
]]
