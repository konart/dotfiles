local wezterm = require("wezterm")
local config = {}

-- config.front_end = "WebGpu"
-- config.webgpu_power_preference = "HighPerformance"

config.enable_tab_bar = false
config.color_scheme = "GruvboxDarkHard"
-- config.font = wezterm.font("MesloLGM Nerd Font Mono")
config.font = wezterm.font_with_fallback({
	{
		family = "Fira Code",
		harfbuzz_features = { "ss05", "ss03", "ss02", "ss8", "ss07", "cv02", "cv15", "cv30" },
	},
	{ family = "MesloLGM Nerd Font Mono", harfbuzz_features = { "calt=0", "clig=0", "liga=0" } },
})
config.font_rules = {
	{
		intensity = "Bold",
		italic = false,
		font = wezterm.font_with_fallback({ family = "MesloLGM Nerd Font Mono", weight = "Bold" }),
	},
	{
		intensity = "Bold",
		italic = true,
		font = wezterm.font_with_fallback({ family = "MesloLGM Nerd Font Mono", style = "Italic", weight = "Bold" }),
	},
}

config.font_size = 14
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- config.window_decorations = "MACOS_FORCE_DISABLE_SHADOW"
config.colors = require("ciapre_colors")

return config
