local steel_chest = table.deepcopy(data.raw["container"]["steel-chest"])
data:extend({
	{
		type = "infinity-container",
		gui_mode = "none",
		name = "simple-void-chest",
		icon = steel_chest.icon, -- __simple-void-chest__/graphics/simple-void-chest.png
		tint = { a = 255, r = 255, g = 255, b = 255 },
		flags = { "placeable-neutral", "player-creation" },
		minable = { mining_time = 0.2, result = "simple-void-chest" },
		max_health = 350,
		corpse = "steel-chest-remnants",
		dying_explosion = "steel-chest-explosion",
		collision_box = steel_chest.collision_box,
		fast_replaceable_group = "container",
		selection_box = steel_chest.selection_box,
		damaged_trigger_effect = steel_chest.damaged_trigger_effect,
		inventory_size = 20,
		open_sound = steel_chest.open_sound,
		close_sound = steel_chest.close_sound,
		resistances = steel_chest.resistances,
		vehicle_impact_sound = steel_chest.vehicle_impact_sound,
		picture = steel_chest.picture,
		erase_contents_when_mined = true
	},
	{
		type = "recipe",
		name = "simple-void-chest",
		enabled = false,
		sort_item_ingredients = false,
		ingredients =
		{
			{ type = "item", name = "steel-chest",        amount = 1 },
			{ type = "item", name = "iron-gear-wheel",    amount = 5 }
		},
		results = { { type = "item", name = "simple-void-chest", amount = 1 } }
	},
	{
		type = "technology",
		name = "simple-void-chest",
		icon = steel_chest.icon, -- __simple-void-chest__/graphics/simple-void-chest.png
		icon_size = 64,
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
item.icon = steel_chest.icon -- __simple-void-chest__/graphics/simple-void-chest.png
item.place_result = "simple-void-chest"
item.order = item.order .. "-z[simple-void-chest]"
data:extend({ item })
