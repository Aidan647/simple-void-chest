local modify = function(event)
	if event.entity.name == "simple-void-chest"
	or event.entity.name == "entity-ghost" and event.entity.ghost_name == "simple-void-chest"
	then
		event.entity.remove_unfiltered_items = true
	end
end

script.on_event(defines.events.on_built_entity, modify)
script.on_event(defines.events.on_robot_built_entity, modify)
script.on_event(defines.events.on_space_platform_built_entity, modify)
script.on_event(defines.events.script_raised_built, modify)


script.on_event(defines.events.on_runtime_mod_setting_changed, function(event)
	if not event.setting == "simple-void-chest-refresh-all" then return end

	if settings.global["simple-void-chest-refresh-all"].value then
		settings.global["simple-void-chest-refresh-all"] = { value = false }
		for _, surface in pairs(game.surfaces) do
			for _, entity in pairs(surface.find_entities_filtered { name = "simple-void-chest" }) do
				entity.remove_unfiltered_items = true
			end
			for _, ghost in pairs(surface.find_entities_filtered { name = "entity-ghost", ghost_name = "simple-void-chest" }) do
				ghost.remove_unfiltered_items = true
			end
		end
		for _, player in pairs(game.players) do
			player.print({ "simple-void-chest-refresh-all-message" })
		end
	end
end)
