local steel_chest = table.deepcopy(data.raw["container"]["steel-chest"])
data:extend({
	{
		type = "infinity-container",
		gui_mode = "none",
		name = "simple-void-chest",
		icons = {
			{ icon = "__base__/graphics/icons/steel-chest.png" },
			{ icon = "__simple-void-chest__/graphics/simple-void-chest-icon-mask.png" }
		},
		flags = { "placeable-neutral", "player-creation" },
		minable = { mining_time = 0.2, result = "simple-void-chest" },
		max_health = 350,
		corpse = "steel-chest-remnants",
		dying_explosion = "steel-chest-explosion",
		collision_box = steel_chest.collision_box,
		fast_replaceable_group = "container",
		selection_box = steel_chest.selection_box,
		damaged_trigger_effect = steel_chest.damaged_trigger_effect,
		inventory_size = 19,
		open_sound = steel_chest.open_sound,
		close_sound = steel_chest.close_sound,
		resistances = steel_chest.resistances,
		vehicle_impact_sound = steel_chest.vehicle_impact_sound,
		picture =
		{
			layers =
			{
				{
					filename = "__base__/graphics/entity/steel-chest/steel-chest.png",
					priority = "extra-high",
					width = 64,
					height = 80,
					shift = util.by_pixel(-0.25, -0.5),
					scale = 0.5
				},
				{
					filename = "__base__/graphics/entity/steel-chest/steel-chest-shadow.png",
					priority = "extra-high",
					width = 110,
					height = 46,
					shift = util.by_pixel(12.25, 8),
					draw_as_shadow = true,
					scale = 0.5
				},
				{
					filename = "__simple-void-chest__/graphics/simple-void-chest-mask.png",
					priority = "extra-high",
					width = 64,
					height = 80,
					shift = util.by_pixel(-0.25, -0.5),
					tint = { 1, 0, 0, 0.4 },
					scale = 0.5
				},
				{
					filename = "__simple-void-chest__/graphics/simple-void-chest-mask.png",
					priority = "extra-high",
					width = 64,
					height = 80,
					shift = util.by_pixel(-0.25, -0.5),
					tint = { 1, 0, 0, 0.05 },
					draw_as_glow = true,
					scale = 0.5
				}
			}
		},
		erase_contents_when_mined = true
	},
	{
		type = "recipe",
		name = "simple-void-chest",
		enabled = false,
		sort_item_ingredients = false,
		ingredients =
		{
			{ type = "item", name = "steel-chest",     amount = 1 },
			{ type = "item", name = "iron-gear-wheel", amount = 5 }
		},
		results = { { type = "item", name = "simple-void-chest", amount = 1 } }
	},
	{
		type = "technology",
		name = "simple-void-chest",
        icon = "__simple-void-chest__/thumbnail.png",
		icon_size = 256,
		effects =
		{
			{
				type = "unlock-recipe",
				recipe = "simple-void-chest"
			}
		},
		prerequisites = { "steel-processing", "logistic-science-pack" },
		unit =
		{
			count = 50,
			ingredients =
			{
				{ "automation-science-pack", 1 },
				{ "logistic-science-pack",   1 }
			},
			time = 30
		},
		order = "c-c-a"
	}
})

local item = table.deepcopy(data.raw["item"]["steel-chest"])
item.name = "simple-void-chest"
item.icon = nil
item.icon_size = nil
item.icons = {
	{ icon = "__base__/graphics/icons/steel-chest.png" },
	{ icon = "__simple-void-chest__/graphics/simple-void-chest-icon-mask.png" }
}
item.place_result = "simple-void-chest"
item.order = item.order .. "-z[simple-void-chest]"
data:extend({ item })
