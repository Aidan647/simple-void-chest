if mods["space-age"] then
	data:extend({
		{
			type = "bool-setting",
			name = "simple-void-chest-allow-space",
			setting_type = "startup",
			default_value = false,
		}
	})
end
data:extend({
	{
		type = "bool-setting",
		name = "simple-void-chest-refresh-all",
		setting_type = "runtime-global",
		default_value = false,
	}
})
