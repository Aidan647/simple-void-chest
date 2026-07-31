if mods["space-age"] and not settings.startup["simple-void-chest-allow-space"].value then
	data.raw["infinity-container"]["simple-void-chest"].surface_conditions =
	{
		{
			property = "gravity",
			min = 0.1
		}
	}
end
