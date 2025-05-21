return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		local lazy = require("lazy")

		-- Set header
		dashboard.section.header.val = {
			"                         ",
			"                         ",
			"                         ",
			"                         ",
			"                         ",
			"                         ",
			"                         ",
			"                    ▀    ",
			"              █▀█▄█▀█▀█▀█",
			"                         ",
		}

		-- Set menu
		dashboard.section.buttons.val = {
			dashboard.button("o", "  Open", "<cmd>lua require('telescope').extensions.smart_open.smart_open()<CR>"),
			dashboard.button("n", "  New", "<cmd>ene | startinsert<CR>"),
			dashboard.button("r", "  Recent", "<cmd>Telescope oldfiles<CR>"),
			dashboard.button("u", "󰒲  Update", "<cmd>Lazy sync<CR>"),
			dashboard.button("s", "󱥚  Themes", "<cmd>lua require('nvchad.themes').open()<CR>"),
			dashboard.button("m", "  Keymap", "<cmd>NvCheatsheet<CR>"),
			dashboard.button("q", "  Quit", "<cmd>qa!<CR>"),
		}

		-- Footer with stats
		dashboard.section.footer.val = {
			"─",
			" " .. lazy.stats().loaded .. "/" .. lazy.stats().count .. " plugins loaded",
			"󱎫  " .. (math.floor(lazy.stats().startuptime * 100 + 0.5) / 100) .. " ms",
			"─",
		}

		-- Send config to alpha
		alpha.setup(dashboard.opts)

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
