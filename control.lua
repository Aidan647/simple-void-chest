local modify = function(event)
	if event.entity.name == "simple-void-chest" then
		event.entity.remove_unfiltered_items = true
	end
end

script.on_event(defines.events.on_built_entity, modify)
script.on_event(defines.events.on_robot_built_entity, modify)
script.on_event(defines.events.on_space_platform_built_entity, modify)
script.on_event(defines.events.script_raised_built, modify)
