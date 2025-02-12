local M = {}

M.set = function()
	local theme_set, _ = pcall(vim.cmd.colorscheme, "kanagawa")

	if theme_set then
		-- override highlight
		vim.api.nvim_set_hl(0, "diffAdded", { bg = "#283b4d" })
		vim.api.nvim_set_hl(0, "diffRemoved", { bg = "#352d3d" })
		vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#3f2d3d", fg = "#3f3f4f" })
		vim.api.nvim_set_hl(0, "diffChanged", { bg = "#272d43" })
		vim.api.nvim_set_hl(0, "LspCodeLens", { fg = "#565f89" })
		vim.api.nvim_set_hl(0, "LspCodeLensSeparator", { fg = "#565f89" })
		vim.api.nvim_set_hl(0, "FloatBorder", { link = "TelescopeBorder" })
		vim.api.nvim_set_hl(0, "TroubleNormal", { link = "Normal" })
		vim.api.nvim_set_hl(0, "TroubleNormalNC", { link = "NormalNC" })

		vim.g.border_style = "single"
	end
end

return M
