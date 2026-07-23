if mods["space-age"] then
	data:extend({
		{
			type = "bool-setting",
			name = "simple-void-chest-allow-space",
			setting_type = "startup",
			default_value = false,
			order = "a"
		}
	})
end
