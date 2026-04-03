vim.filetype.add({
  extension = {
    j2 = "yaml.ansible",
    jinja2 = "yaml.ansible",
  },
  pattern = {
    [".*/templates/.*%.yaml"] = "helm",
    [".*/templates/.*%.tpl"] = "helm",
    [".*/charts/.*%.yaml"] = "helm",
    ["values%.yaml"] = "helm",
    [".*/tasks/.*%.yaml"] = "yaml.ansible",
    [".*/roles/.*%.yaml"] = "yaml.ansible",
    [".*/handlers/.*%.yaml"] = "yaml.ansible",
    ["playbook%.y.*ml"] = "yaml.ansible",
    ["docker%-compose%.y.*ml"] = "yaml",
    [".*%.yaml"] = function(path, bufnr)
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 20, false)
      local content = table.concat(lines, " ")
      if content:match("apiVersion:") then
        if string.find(content, "{{") or 
           string.find(content, ".Values") or 
           string.find(content, ".Release") then
          return "helm"
        end
        return "yaml"
      end
      if string.find(content, "hosts:") or string.find(content, "tasks:") then
        return "yaml.ansible"
      end
      return "yaml"
    end,
  },
})
vim.api.nvim_create_user_command("FTA", "set ft=yaml.ansible", {})
vim.api.nvim_create_user_command("FTH", "set ft=helm", {})
