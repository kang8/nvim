vim.filetype.add({
  filename = {
    ['.gitlab-ci.yml'] = 'yaml.gitlab',
    ['.gitlab-ci.yaml'] = 'yaml.gitlab',
  },
  pattern = {
    ['.env.*'] = 'sh',
    -- Custom-named GitLab CI files (e.g. templates/build.gitlab-ci.yml)
    ['.*%.gitlab%-ci%.ya?ml'] = 'yaml.gitlab',
  },
})
