/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_createfxmenu.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 25
 * Decompile Time: 400 ms
 * Timestamp: 10/27/2023 2:29:19 AM
*******************************************************************/

//Function Number: 1
menu(param_00)
{
	return level.create_fx_menu == param_00;
}

//Function Number: 2
setmenu(param_00)
{
	level.create_fx_menu = param_00;
}

//Function Number: 3
create_fx_menu()
{
	if(common_scripts\_createfx::button_is_clicked("escape","x"))
	{
		_exit_menu();
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
			var_00 = common_scripts\_createfx::createloopsound();
			finish_creating_entity(var_00);
			return;
		}

		if(common_scripts\_createfx::button_is_clicked("4"))
		{
			setmenu("create_exploder");
			var_00 = common_scripts\_createfx::createnewexploder();
			finish_creating_entity(var_00);
			return;
		}

		if(common_scripts\_createfx::button_is_clicked("5"))
		{
			setmenu("create_interval_sound");
			var_00 = common_scripts\_createfx::createintervalsound();
			finish_creating_entity(var_00);
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
			var_01 = get_last_selected_entity();
			if(!isdefined(level.last_displayed_ent) || var_01 != level.last_displayed_ent)
			{
				display_fx_info(var_01);
				level.last_displayed_ent = var_01;
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

//Function Number: 4
_exit_menu()
{
	common_scripts\_createfx::clear_fx_hudelements();
	common_scripts\_createfx::clear_entity_selection();
	common_scripts\_createfx::update_selected_entities();
	setmenu("none");
}

//Function Number: 5
get_last_selected_entity()
{
	return level.selected_fx_ents[level.selected_fx_ents.size - 1];
}

//Function Number: 6
menu_fx_creation()
{
	var_00 = 0;
	var_01 = undefined;
	var_02 = common_scripts\_createfx::func_get_level_fx();
	for(var_03 = level.effect_list_offset;var_03 < var_02.size;var_03++)
	{
		var_00 = var_00 + 1;
		var_04 = var_00;
		if(var_04 == 10)
		{
			var_04 = 0;
		}

		if(common_scripts\_createfx::button_is_clicked(var_04 + ""))
		{
			var_01 = var_02[var_03];
			break;
		}

		if(var_00 > level.effect_list_offset_max)
		{
			break;
		}
	}

	if(!isdefined(var_01))
	{
		return;
	}

	if(menu("change_fxid"))
	{
		apply_option_to_selected_fx(get_option("fxid"),var_01);
		level.effect_list_offset = 0;
		common_scripts\_createfx::clear_fx_hudelements();
		setmenu("none");
		return;
	}

	var_05 = undefined;
	if(menu("create_loopfx"))
	{
		var_05 = common_scripts\utility::createloopeffect(var_01);
	}

	if(menu("create_oneshot"))
	{
		var_05 = common_scripts\utility::createoneshoteffect(var_01);
	}

	finish_creating_entity(var_05);
}

//Function Number: 7
finish_creating_entity(param_00)
{
	param_00.v["angles"] = vectortoangles(param_00.v["origin"] + (0,0,100) - param_00.v["origin"]);
	param_00 common_scripts\_createfx::post_entity_creation_function();
	common_scripts\_createfx::clear_entity_selection();
	common_scripts\_createfx::select_last_entity();
	common_scripts\_createfx::move_selection_to_cursor();
	common_scripts\_createfx::update_selected_entities();
	setmenu("none");
}

//Function Number: 8
menu_init()
{
	level.createfx_options = [];
	addoption("string","fxid","The FX","nil","fx");
	addoption("float","delay","Repeat rate/start delay",0.5,"fx");
	addoption("float","fire_range","Fire damage range",0,"fx");
	addoption("string","flag","Flag","nil","exploder");
	addoption("string","firefx","2nd FX id","nil","exploder");
	addoption("float","firefxdelay","2nd FX id repeat rate",0.5,"exploder");
	addoption("float","firefxtimeout","2nd FX timeout",5,"exploder");
	addoption("string","firefxsound","2nd FX soundalias","nil","exploder");
	addoption("float","damage","Radius damage",150,"exploder");
	addoption("float","damage_radius","Radius of radius damage",250,"exploder");
	addoption("float","delay_min","Minimimum time between repeats",1,"soundfx_interval");
	addoption("float","delay_max","Maximum time between repeats",2,"soundfx_interval");
	addoption("int","repeat","Number of times to repeat",5,"exploder");
	addoption("string","exploder","Exploder","1","exploder");
	addoption("string","earthquake","Earthquake","nil","exploder");
	if(!level.mp_createfx)
	{
		addoption("string","rumble","Rumble","nil","exploder");
	}

	addoption("string","ender","Level notify for ending 2nd FX","nil","exploder");
	addoption("string","soundalias","Soundalias","nil","all");
	addoption("string","loopsound","Loopsound","nil","exploder");
	if(!level.mp_createfx)
	{
		addoption("int","stoppable","Can be stopped from script","1","all");
	}

	level.effect_list_offset = 0;
	level.effect_list_offset_max = 10;
	level.createfxmasks = [];
	level.createfxmasks["all"] = [];
	level.createfxmasks["all"]["exploder"] = 1;
	level.createfxmasks["all"]["oneshotfx"] = 1;
	level.createfxmasks["all"]["loopfx"] = 1;
	level.createfxmasks["all"]["soundfx"] = 1;
	level.createfxmasks["all"]["soundfx_interval"] = 1;
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
	level.createfxmasks["soundfx_interval"] = [];
	level.createfxmasks["soundfx_interval"]["soundfx_interval"] = 1;
}

//Function Number: 9
get_last_selected_ent()
{
	return level.selected_fx_ents[level.selected_fx_ents.size - 1];
}

//Function Number: 10
entities_are_selected()
{
	return level.selected_fx_ents.size > 0;
}

//Function Number: 11
menu_change_selected_fx()
{
	if(!level.selected_fx_ents.size)
	{
		return;
	}

	var_00 = 0;
	var_01 = 0;
	var_02 = get_last_selected_ent();
	for(var_03 = 0;var_03 < level.createfx_options.size;var_03++)
	{
		var_04 = level.createfx_options[var_03];
		if(!isdefined(var_02.v[var_04["name"]]))
		{
			continue;
		}

		var_00++;
		if(var_00 < level.effect_list_offset)
		{
			continue;
		}

		var_01++;
		var_05 = var_01;
		if(var_05 == 10)
		{
			var_05 = 0;
		}

		if(common_scripts\_createfx::button_is_clicked(var_05 + ""))
		{
			prepare_option_for_change(var_04,var_01);
			break;
		}

		if(var_01 > level.effect_list_offset_max)
		{
			var_06 = 1;
			break;
		}
	}
}

//Function Number: 12
prepare_option_for_change(param_00,param_01)
{
	if(param_00["name"] == "fxid")
	{
		setmenu("change_fxid");
		draw_effects_list();
		return;
	}

	common_scripts\_createfx::createfx_centerprint("To change " + param_00["description"] + " on selected entities, type /fx newvalue");
	level.createfx_inputlocked = 1;
	set_option_index(param_00["name"]);
	setdvar("fx","nil");
	level.createfxhudelements[param_01 + 3][0].color = (1,1,0);
}

//Function Number: 13
menu_fx_option_set()
{
	if(getdvar("fx") == "nil")
	{
		return;
	}

	var_00 = get_selected_option();
	var_01 = undefined;
	if(var_00["type"] == "string")
	{
		var_01 = getdvar("fx");
	}

	if(var_00["type"] == "int")
	{
		var_01 = getdvarint("fx");
	}

	if(var_00["type"] == "float")
	{
		var_01 = getdvarfloat("fx");
	}

	apply_option_to_selected_fx(var_00,var_01);
}

//Function Number: 14
apply_option_to_selected_fx(param_00,param_01)
{
	for(var_02 = 0;var_02 < level.selected_fx_ents.size;var_02++)
	{
		var_03 = level.selected_fx_ents[var_02];
		if(mask(param_00["mask"],var_03.v["type"]))
		{
			var_03.v[param_00["name"]] = param_01;
		}
	}

	level.last_displayed_ent = undefined;
	common_scripts\_createfx::update_selected_entities();
	common_scripts\_createfx::clear_settable_fx();
}

//Function Number: 15
set_option_index(param_00)
{
	for(var_01 = 0;var_01 < level.createfx_options.size;var_01++)
	{
		if(level.createfx_options[var_01]["name"] != param_00)
		{
			continue;
		}

		level.selected_fx_option_index = var_01;
		return;
	}
}

//Function Number: 16
get_selected_option()
{
	return level.createfx_options[level.selected_fx_option_index];
}

//Function Number: 17
mask(param_00,param_01)
{
	return isdefined(level.createfxmasks[param_00][param_01]);
}

//Function Number: 18
addoption(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = [];
	level.createfx_options[level.createfx_options.size] = var_41;
}

//Function Number: 19
get_option(param_00)
{
	for(var_01 = 0;var_01 < level.createfx_options.size;var_01++)
	{
		if(level.createfx_options[var_01]["name"] == param_00)
		{
			return level.createfx_options[var_01];
		}
	}
}

//Function Number: 20
display_fx_info(param_00)
{
	if(!menu("none"))
	{
		return;
	}

	common_scripts\_createfx::clear_fx_hudelements();
	common_scripts\_createfx::set_fx_hudelement("Name: " + param_00.v["fxid"]);
	common_scripts\_createfx::set_fx_hudelement("Type: " + param_00.v["type"]);
	common_scripts\_createfx::set_fx_hudelement("Origin: " + param_00.v["origin"]);
	common_scripts\_createfx::set_fx_hudelement("Angles: " + param_00.v["angles"]);
	if(entities_are_selected())
	{
		var_01 = 0;
		var_02 = 0;
		var_03 = 0;
		for(var_04 = 0;var_04 < level.createfx_options.size;var_04++)
		{
			var_05 = level.createfx_options[var_04];
			if(!isdefined(param_00.v[var_05["name"]]))
			{
				continue;
			}

			var_01++;
			if(var_01 < level.effect_list_offset)
			{
				continue;
			}

			var_02++;
			common_scripts\_createfx::set_fx_hudelement(var_02 + ". " + var_05["description"] + ": " + param_00.v[var_05["name"]]);
			if(var_02 > level.effect_list_offset_max)
			{
				var_03 = 1;
				break;
			}
		}

		if(var_01 > level.effect_list_offset_max)
		{
			common_scripts\_createfx::set_fx_hudelement("(m) More >");
		}

		common_scripts\_createfx::set_fx_hudelement("(a) Add >");
		common_scripts\_createfx::set_fx_hudelement("(x) Exit >");
		return;
	}

	var_01 = 0;
	var_03 = 0;
	for(var_04 = 0;var_04 < level.createfx_options.size;var_04++)
	{
		var_05 = level.createfx_options[var_04];
		if(!isdefined(param_00.v[var_05["name"]]))
		{
			continue;
		}

		var_01++;
		common_scripts\_createfx::set_fx_hudelement(var_05["description"] + ": " + param_00.v[var_05["name"]]);
		if(var_01 > level.createfx_hudelements)
		{
			break;
		}
	}
}

//Function Number: 21
display_fx_add_options(param_00)
{
	common_scripts\_createfx::clear_fx_hudelements();
	common_scripts\_createfx::set_fx_hudelement("Name: " + param_00.v["fxid"]);
	common_scripts\_createfx::set_fx_hudelement("Type: " + param_00.v["type"]);
	common_scripts\_createfx::set_fx_hudelement("Origin: " + param_00.v["origin"]);
	common_scripts\_createfx::set_fx_hudelement("Angles: " + param_00.v["angles"]);
	var_01 = 0;
	var_02 = 0;
	var_03 = 0;
	if(level.effect_list_offset >= level.createfx_options.size)
	{
		level.effect_list_offset = 0;
	}

	for(var_04 = 0;var_04 < level.createfx_options.size;var_04++)
	{
		var_05 = level.createfx_options[var_04];
		if(isdefined(param_00.v[var_05["name"]]))
		{
			continue;
		}

		if(!mask(var_05["mask"],param_00.v["type"]))
		{
			continue;
		}

		var_01++;
		if(var_01 < level.effect_list_offset)
		{
			continue;
		}

		if(var_02 >= level.effect_list_offset_max)
		{
			continue;
		}

		var_02++;
		var_06 = var_02;
		if(var_06 == 10)
		{
			var_06 = 0;
		}

		if(common_scripts\_createfx::button_is_clicked(var_06 + ""))
		{
			add_option_to_selected_entities(var_05);
			menunone();
			level.last_displayed_ent = undefined;
			return;
		}

		common_scripts\_createfx::set_fx_hudelement(var_06 + ". " + var_05["description"]);
	}

	if(var_01 > level.effect_list_offset_max)
	{
		common_scripts\_createfx::set_fx_hudelement("(m) More >");
	}

	common_scripts\_createfx::set_fx_hudelement("(x) Exit >");
}

//Function Number: 22
add_option_to_selected_entities(param_00)
{
	var_01 = undefined;
	for(var_02 = 0;var_02 < level.selected_fx_ents.size;var_02++)
	{
		var_03 = level.selected_fx_ents[var_02];
		if(mask(param_00["mask"],var_03.v["type"]))
		{
			var_03.v[param_00["name"]] = param_00["default"];
		}
	}
}

//Function Number: 23
menunone()
{
	level.effect_list_offset = 0;
	common_scripts\_createfx::clear_fx_hudelements();
	setmenu("none");
}

//Function Number: 24
draw_effects_list()
{
	common_scripts\_createfx::clear_fx_hudelements();
	common_scripts\_createfx::set_fx_hudelement("Pick an effect:");
	var_00 = 0;
	var_01 = 0;
	var_02 = common_scripts\_createfx::func_get_level_fx();
	if(level.effect_list_offset >= var_02.size)
	{
		level.effect_list_offset = 0;
	}

	for(var_03 = level.effect_list_offset;var_03 < var_02.size;var_03++)
	{
		var_00 = var_00 + 1;
		common_scripts\_createfx::set_fx_hudelement(var_00 + ". " + var_02[var_03]);
		if(var_00 >= level.effect_list_offset_max)
		{
			var_01 = 1;
			break;
		}
	}

	if(var_02.size > level.effect_list_offset_max)
	{
		common_scripts\_createfx::set_fx_hudelement("(m) More >");
	}
}

//Function Number: 25
increment_list_offset()
{
	level.effect_list_offset = level.effect_list_offset + level.effect_list_offset_max;
}