/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_createfxmenu.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

menu(name)
{
	return level.create_fx_menu == name;
}

setmenu(name)
{
	level.create_fx_menu = name;
}

create_fx_menu()
{
	if(common_scripts\_createfx::button_is_clicked("escape", "x"))
	{
		exit_menu();
		return;
	}

	if(menu("creation"))
	{
		if(common_scripts\_createfx::button_is_clicked("1"))
		{
			setmenu("create_oneshot");
			draw_effects_list();
			return;
		}

		if(common_scripts\_createfx::button_is_clicked("2"))
		{
			setmenu("create_loopfx");
			draw_effects_list();
			return;
		}

		if(common_scripts\_createfx::button_is_clicked("3"))
		{
			setmenu("create_loopsound");
			ent = common_scripts\_createfx::createloopsound();
			finish_creating_entity(ent);
			return;
		}

		if(common_scripts\_createfx::button_is_clicked("4"))
		{
			setmenu("create_exploder");
			ent = common_scripts\_createfx::createnewexploder();
			finish_creating_entity(ent);
			return;
		}

		return;
	}

	if(menu("create_oneshot") || menu("create_loopfx") || menu("change_fxid"))
	{
		if(common_scripts\_createfx::button_is_clicked("m"))
		{
			increment_list_offset();
			draw_effects_list();
		}

		menu_fx_creation();
		return;
	}

	if(menu("none"))
	{
		if(common_scripts\_createfx::button_is_clicked("m"))
		{
			increment_list_offset();
		}

		menu_change_selected_fx();
		if(entities_are_selected())
		{
			last_selected_ent = get_last_selected_entity();
			if(!isdefined(level.last_displayed_ent) || last_selected_ent != level.last_displayed_ent)
			{
				display_fx_info(last_selected_ent);
				level.last_displayed_ent = last_selected_ent;
			}

			if(common_scripts\_createfx::button_is_clicked("a"))
			{
				common_scripts\_createfx::clear_settable_fx();
				setmenu("add_options");
				return;
			}

			return;
		}

		return;
	}

	if(menu("add_options"))
	{
		if(!entities_are_selected())
		{
			common_scripts\_createfx::clear_fx_hudelements();
			setmenu("none");
			return;
		}

		display_fx_add_options(get_last_selected_entity());
		if(common_scripts\_createfx::button_is_clicked("m"))
		{
			increment_list_offset();
			return;
		}

		return;
	}
}

exit_menu()
{
	common_scripts\_createfx::clear_fx_hudelements();
	common_scripts\_createfx::clear_entity_selection();
	common_scripts\_createfx::update_selected_entities();
	setmenu("none");
}

get_last_selected_entity()
{
	return level.selected_fx_ents[level.selected_fx_ents.size - 1];
}

menu_fx_creation()
{
	count = 0;
	picked_fx = undefined;
	keys = common_scripts\_createfx::func_get_level_fx();
	for(i = level.effect_list_offset;i < keys.size;i++)
	{
		count = count + 1;
		button_to_check = count;
		if(button_to_check == 10)
		{
			button_to_check = 0;
		}

		if(common_scripts\_createfx::button_is_clicked(button_to_check + ""))
		{
			picked_fx = keys[i];
			break;
		}

		if(count > level.effect_list_offset_max)
		{
			break;
		}
	}

	if(!isdefined(picked_fx))
	{
		return;
	}

	if(menu("change_fxid"))
	{
		apply_option_to_selected_fx(get_option("fxid"), picked_fx);
		level.effect_list_offset = 0;
		common_scripts\_createfx::clear_fx_hudelements();
		setmenu("none");
		return;
	}

	ent = undefined;
	if(menu("create_loopfx"))
	{
		ent = common_scripts\utility::createloopeffect(picked_fx);
	}

	if(menu("create_oneshot"))
	{
		ent = common_scripts\utility::createoneshoteffect(picked_fx);
	}

	finish_creating_entity(ent);
}

finish_creating_entity(ent)
{
	ent.v["angles"] = vectortoangles(ent.v["origin"] + (0,0,100) - ent.v["origin"]);
	ent common_scripts\_createfx::post_entity_creation_function();
	common_scripts\_createfx::clear_entity_selection();
	common_scripts\_createfx::select_last_entity();
	common_scripts\_createfx::move_selection_to_cursor();
	common_scripts\_createfx::update_selected_entities();
	setmenu("none");
}

menu_init()
{
	level.createfx_options = [];
	addoption("string", "fxid", "The FX", "nil", "fx");
	addoption("float", "delay", "Repeat rate/start delay", 0.5, "fx");
	addoption("float", "fire_range", "Fire damage range", 0, "fx");
	addoption("string", "flag", "Flag", "nil", "exploder");
	addoption("string", "firefx", "2nd FX id", "nil", "exploder");
	addoption("float", "firefxdelay", "2nd FX id repeat rate", 0.5, "exploder");
	addoption("float", "firefxtimeout", "2nd FX timeout", 5, "exploder");
	addoption("string", "firefxsound", "2nd FX soundalias", "nil", "exploder");
	addoption("float", "damage", "Radius damage", 150, "exploder");
	addoption("float", "damage_radius", "Radius of radius damage", 250, "exploder");
	addoption("float", "delay_min", "Minimimum time between repeats", 1, "exploder");
	addoption("float", "delay_max", "Maximum time between repeats", 2, "exploder");
	addoption("int", "repeat", "Number of times to repeat", 5, "exploder");
	addoption("string", "exploder", "Exploder", 1, "exploder");
	addoption("string", "earthquake", "Earthquake", "nil", "exploder");
	if(!level.mp_createfx)
	{
		addoption("string", "rumble", "Rumble", "nil", "exploder");
	}

	addoption("string", "ender", "Level notify for ending 2nd FX", "nil", "exploder");
	addoption("string", "soundalias", "Soundalias", "nil", "all");
	addoption("string", "loopsound", "Loopsound", "nil", "exploder");
	if(!level.mp_createfx)
	{
		addoption("int", "stoppable", "Can be stopped from script", "1", "all");
	}

	level.effect_list_offset = 0;
	level.effect_list_offset_max = 10;
	level.createfxmasks = [];
	level.createfxmasks["all"] = [];
	level.createfxmasks["all"]["exploder"] = 1;
	level.createfxmasks["all"]["oneshotfx"] = 1;
	level.createfxmasks["all"]["loopfx"] = 1;
	level.createfxmasks["all"]["soundfx"] = 1;
	level.createfxmasks["fx"] = [];
	level.createfxmasks["fx"]["exploder"] = 1;
	level.createfxmasks["fx"]["oneshotfx"] = 1;
	level.createfxmasks["fx"]["loopfx"] = 1;
	level.createfxmasks["exploder"] = [];
	level.createfxmasks["exploder"]["exploder"] = 1;
	level.createfxmasks["loopfx"] = [];
	level.createfxmasks["loopfx"]["loopfx"] = 1;
	level.createfxmasks["oneshotfx"] = [];
	level.createfxmasks["oneshotfx"]["oneshotfx"] = 1;
	level.createfxmasks["soundfx"] = [];
	level.createfxmasks["soundfx"]["soundalias"] = 1;
}

get_last_selected_ent()
{
	return level.selected_fx_ents[level.selected_fx_ents.size - 1];
}

entities_are_selected()
{
	return level.selected_fx_ents.size > 0;
}

menu_change_selected_fx()
{
	if(!level.selected_fx_ents.size)
	{
		return;
	}

	count = 0;
	drawncount = 0;
	ent = get_last_selected_ent();
	for(i = 0;i < level.createfx_options.size;i++)
	{
		option = level.createfx_options[i];
		if(!isdefined(ent.v[option["name"]]))
		{
			continue;
		}

		count++;
		if(count < level.effect_list_offset)
		{
			continue;
		}

		drawncount++;
		button_to_check = drawncount;
		if(button_to_check == 10)
		{
			button_to_check = 0;
		}

		if(common_scripts\_createfx::button_is_clicked(button_to_check + ""))
		{
			prepare_option_for_change(option, drawncount);
			break;
		}

		if(drawncount > level.effect_list_offset_max)
		{
			more = 1;
			break;
		}
	}
}

prepare_option_for_change(option, drawncount)
{
	if(option["name"] == "fxid")
	{
		setmenu("change_fxid");
		draw_effects_list();
		return;
	}

	common_scripts\_createfx::createfx_centerprint("To change " + option["description"] + " on selected entities, type /fx newvalue");
	level.createfx_inputlocked = 1;
	set_option_index(option["name"]);
	setdvar("fx", "nil");
	level.createfxhudelements[drawncount + 3][0].color = (1,1,0);
}

menu_fx_option_set()
{
	if(getdvar("fx") == "nil")
	{
		return;
	}

	option = get_selected_option();
	setting = undefined;
	if(option["type"] == "string")
	{
		setting = getdvar("fx");
	}

	if(option["type"] == "int")
	{
		setting = getdvarint("fx");
	}

	if(option["type"] == "float")
	{
		setting = getdvarfloat("fx");
	}

	apply_option_to_selected_fx(option, setting);
}

apply_option_to_selected_fx(option, setting)
{
	for(i = 0;i < level.selected_fx_ents.size;i++)
	{
		ent = level.selected_fx_ents[i];
		if(mask(option["mask"], ent.v["type"]))
		{
			ent.v[option["name"]] = setting;
		}
	}

	level.last_displayed_ent = undefined;
	common_scripts\_createfx::update_selected_entities();
	common_scripts\_createfx::clear_settable_fx();
}

set_option_index(name)
{
	for(i = 0;i < level.createfx_options.size;i++)
	{
		if(level.createfx_options[i]["name"] != name)
		{
			continue;
		}

		level.selected_fx_option_index = i;
		return;
	}
}

get_selected_option()
{
	return level.createfx_options[level.selected_fx_option_index];
}

mask(type, name)
{
	return isdefined(level.createfxmasks[type][name]);
}

addoption(type, name, description, defaultsetting, mask)
{
	option = [];
	option["type"] = type;
	option["name"] = name;
	option["description"] = description;
	option["default"] = defaultsetting;
	option["mask"] = mask;
	level.createfx_options[level.createfx_options.size] = option;
}

get_option(name)
{
	for(i = 0;i < level.createfx_options.size;i++)
	{
		if(level.createfx_options[i]["name"] == name)
		{
			return level.createfx_options[i];
		}
	}
}

display_fx_info(ent)
{
	if(!menu("none"))
	{
		return;
	}

	common_scripts\_createfx::clear_fx_hudelements();
	common_scripts\_createfx::set_fx_hudelement("Name: " + ent.v["fxid"]);
	common_scripts\_createfx::set_fx_hudelement("Type: " + ent.v["type"]);
	common_scripts\_createfx::set_fx_hudelement("Origin: " + ent.v["origin"]);
	common_scripts\_createfx::set_fx_hudelement("Angles: " + ent.v["angles"]);
	if(entities_are_selected())
	{
		count = 0;
		drawncount = 0;
		more = 0;
		for(i = 0;i < level.createfx_options.size;i++)
		{
			option = level.createfx_options[i];
			if(!isdefined(ent.v[option["name"]]))
			{
				continue;
			}

			count++;
			if(count < level.effect_list_offset)
			{
				continue;
			}

			drawncount++;
			common_scripts\_createfx::set_fx_hudelement(drawncount + ". " + option["description"] + ": " + ent.v[option["name"]]);
			if(drawncount > level.effect_list_offset_max)
			{
				more = 1;
				break;
			}
		}

		if(count > level.effect_list_offset_max)
		{
			common_scripts\_createfx::set_fx_hudelement("(m) More >");
		}

		common_scripts\_createfx::set_fx_hudelement("(a) Add >");
		common_scripts\_createfx::set_fx_hudelement("(x) Exit >");
		return;
	}

	count = 0;
	more = 0;
	for(i = 0;i < level.createfx_options.size;i++)
	{
		option = level.createfx_options[i];
		if(!isdefined(ent.v[option["name"]]))
		{
			continue;
		}

		count++;
		common_scripts\_createfx::set_fx_hudelement(option["description"] + ": " + ent.v[option["name"]]);
		if(count > level.createfx_hudelements)
		{
			break;
		}
	}
}

display_fx_add_options(ent)
{
	common_scripts\_createfx::clear_fx_hudelements();
	common_scripts\_createfx::set_fx_hudelement("Name: " + ent.v["fxid"]);
	common_scripts\_createfx::set_fx_hudelement("Type: " + ent.v["type"]);
	common_scripts\_createfx::set_fx_hudelement("Origin: " + ent.v["origin"]);
	common_scripts\_createfx::set_fx_hudelement("Angles: " + ent.v["angles"]);
	count = 0;
	drawncount = 0;
	more = 0;
	if(level.effect_list_offset >= level.createfx_options.size)
	{
		level.effect_list_offset = 0;
	}

	for(i = 0;i < level.createfx_options.size;i++)
	{
		option = level.createfx_options[i];
		if(isdefined(ent.v[option["name"]]))
		{
			continue;
		}

		if(!mask(option["mask"], ent.v["type"]))
		{
			continue;
		}

		count++;
		if(count < level.effect_list_offset)
		{
			continue;
		}

		if(drawncount >= level.effect_list_offset_max)
		{
			continue;
		}

		drawncount++;
		button_to_check = drawncount;
		if(button_to_check == 10)
		{
			button_to_check = 0;
		}

		if(common_scripts\_createfx::button_is_clicked(button_to_check + ""))
		{
			add_option_to_selected_entities(option);
			menunone();
			level.last_displayed_ent = undefined;
			return;
		}

		common_scripts\_createfx::set_fx_hudelement(button_to_check + ". " + option["description"]);
	}

	if(count > level.effect_list_offset_max)
	{
		common_scripts\_createfx::set_fx_hudelement("(m) More >");
	}

	common_scripts\_createfx::set_fx_hudelement("(x) Exit >");
}

add_option_to_selected_entities(option)
{
	setting = undefined;
	for(i = 0;i < level.selected_fx_ents.size;i++)
	{
		ent = level.selected_fx_ents[i];
		if(mask(option["mask"], ent.v["type"]))
		{
			ent.v[option["name"]] = option["default"];
		}
	}
}

menunone()
{
	level.effect_list_offset = 0;
	common_scripts\_createfx::clear_fx_hudelements();
	setmenu("none");
}

draw_effects_list()
{
	common_scripts\_createfx::clear_fx_hudelements();
	common_scripts\_createfx::set_fx_hudelement("Pick an effect:");
	count = 0;
	more = 0;
	keys = common_scripts\_createfx::func_get_level_fx();
	if(level.effect_list_offset >= keys.size)
	{
		level.effect_list_offset = 0;
	}

	for(i = level.effect_list_offset;i < keys.size;i++)
	{
		count = count + 1;
		common_scripts\_createfx::set_fx_hudelement(count + ". " + keys[i]);
		if(count >= level.effect_list_offset_max)
		{
			more = 1;
			break;
		}
	}

	if(keys.size > level.effect_list_offset_max)
	{
		common_scripts\_createfx::set_fx_hudelement("(m) More >");
		return;
	}
}

increment_list_offset()
{
	level.effect_list_offset = level.effect_list_offset + level.effect_list_offset_max;
}