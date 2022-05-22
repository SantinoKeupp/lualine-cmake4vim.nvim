local lualine_require = require('lualine_require')
local modules = lualine_require.lazy_require {
  highlight = 'lualine.highlight',
  utils = 'lualine.utils.utils',
}

local M = lualine_require.require('lualine.component'):extend()

function M.is_cmake4vim_active()
  if vim.g.loaded_cmake4vim_plugin then
    return true
  else
    return false
  end
end

local default_options = {
  prefix = "",
  cmake4vim_separator = ">",
  colored = true,
  cond = M.is_cmake4vim_active
}

function M:init(options)
  M.super.init(self, options)
  self.options = vim.tbl_deep_extend('keep', self.options or {}, default_options)
  self.icon_hl_cache = {}
end

function M:update_status()
  local kit = vim.api.nvim_get_var('cmake_selected_kit')
  local build_type = vim.api.nvim_get_var('cmake_build_type')
  build_type = build_type ~= "" and build_type or "Release" -- if not set explicitly, cmake4vim will take Release
  local target = vim.api.nvim_get_var('cmake_build_target')
  local status = self.options.prefix

  if kit ~= "" then
    status = status .. kit .. self.options.cmake4vim_separator
  end

  status = status .. build_type

  if target ~= "" then
    status = status .. self.options.cmake4vim_separator .. target
  end

  return status
end

function M:apply_icon()

  if not self.options.icons_enabled then
    return
  end

  local icon, icon_highlight_group
  local ok, devicons = pcall(require, 'nvim-web-devicons')
  if ok then
    local f_name = "CMakeLists.txt"
    local f_extension = "txt"
    icon, icon_highlight_group = devicons.get_icon(f_name, f_extension)

    if icon and self.options.colored then
      local highlight_color = modules.utils.extract_highlight_colors(icon_highlight_group, 'fg')
      if highlight_color then
        local default_highlight = self:get_default_hl()
        local icon_highlight = self.icon_hl_cache[highlight_color]
        if not icon_highlight or not modules.highlight.highlight_exists(icon_highlight.name .. '_normal') then
          icon_highlight = self:create_hl({ fg = highlight_color }, icon_highlight_group)
          self.icon_hl_cache[highlight_color] = icon_highlight
        end

        icon = self:format_hl(icon_highlight) .. icon .. default_highlight
      end
    end
  else
    ok = vim.fn.exists('*WebDevIconsGetFileTypeSymbol')
    if ok ~= 0 then
      icon = vim.fn.WebDevIconsGetFileTypeSymbol()
    end
  end

  if not icon then
    return
  end

  self.status = icon .. ' ' .. self.status
end

return M
