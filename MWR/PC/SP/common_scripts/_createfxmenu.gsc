/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_createfxmenu.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 40
 * Decompile Time: 599 ms
 * Timestamp: 10/27/2023 2:46:36 AM
*******************************************************************/

//Function Number: 1
init_menu()
{
	level._createfx.options = [];
	addoption("vector","origin","Origin",(0,0,0),"fx",1);
	addoption("vector","angles","Angles",(0,0,0),"fx",1);
	addoption("string","fxid","FX id","nil","fx");
	addoption("float","delay","Repeat rate/start delay",0.5,"fx");
	addoption("string","flag","Flag","nil","exploder");
	addoption("string","platform","Platform","all","all");
	addoption("vector","tintcolor","Tint Color",(1,1,1),"fx");
	addoption("float","tintalpha","Tint Alpha",1,"fx");
	addoption("vector","fadein","Fade In(base, range, 0)",(0,0,0),"fx");
	addoption("vector","fadeout","Fade Out(base, range, 0)",(0,0,0),"fx");
	addoption("float","emissive","Emissive",1,"fx");
	addoption("float","sizescale","Scale",1,"fx");
	if(!level.mp_createfx)
	{
		addoption("string","firefx","2nd FX id","nil","exploder");
		addoption("float","firefxdelay","2nd FX id repeat rate",0.5,"exploder");
		addoption("float","firefxtimeout","2nd FX timeout",5,"exploder");
		addoption("string","firefxsound","2nd FX soundalias","nil","exploder");
		addoption("float","damage","Radius damage",150,"exploder");
		addoption("float","damage_radius","Radius of radius damage",250,"exploder");
		addoption("string","earthquake","Earthquake","nil","exploder");
		addoption("string","ender","Level notify for ending 2nd FX","nil","exploder");
	}

	addoption("float","delay_min","Minimimum time between repeats",1,"soundfx_interval");
	addoption("float","delay_max","Maximum time between repeats",2,"soundfx_interval");
	addoption("int","repeat","Number of times to repeat",5,"exploder");
	addoption("string","exploder","Exploder","1","exploder");
	addoption("string","stop_on_exploder","Stop on exploder","1","all");
	setup_help_keys();
	addoption("string","soundalias","Soundalias","nil","all");
	addoption("string","loopsound","Loopsound","nil","exploder");
	addoption("int","reactive_radius","Reactive Radius",100,"reactive_fx",undefined,::input_reactive_radius);
	addoption("string","ambiencename","Ambience Name","nil","soundfx_dynamic");
	addoption("int","dynamic_distance","Dynamic Max Distance",1000,"soundfx_dynamic");
	if(!level.mp_createfx)
	{
		addoption("string","rumble","Rumble","nil","exploder");
		addoption("int","stoppable","Can be stopped from script","1","all");
	}

	level.effect_list_offset = 0;
	level.effect_list_offset_max = 10;
	level.effect_list_current_size = 0;
	level.help_list_offset = 0;
	level.help_list_offset_max = 20;
	level.createfx_help_active = 0;
	level.createfx_menu_list_active = 0;
	level.createfxmasks = [];
	level.createfxmasks["all"] = [];
	level.createfxmasks["all"]["exploder"] = 1;
	level.createfxmasks["all"]["oneshotfx"] = 1;
	level.createfxmasks["all"]["loopfx"] = 1;
	level.createfxmasks["all"]["soundfx"] = 1;
	level.createfxmasks["all"]["soundfx_interval"] = 1;
	level.createfxmasks["all"]["reactive_fx"] = 1;
	level.createfxmasks["all"]["soundfx_dynamic"] = 1;
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
	level.createfxmasks["reactive_fx"] = [];
	level.createfxmasks["reactive_fx"]["reactive_fx"] = 1;
	level.createfxmasks["soundfx_dynamic"] = [];
	level.createfxmasks["soundfx_dynamic"]["soundfx_dynamic"] = 1;
	var_00 = [];
	var_00["creation"] = ::menu_create_select;
	var_00["create_oneshot"] = ::menu_create;
	var_00["create_loopfx"] = ::menu_create;
	var_00["change_fxid"] = ::menu_create;
	var_00["none"] = ::menu_none;
	var_00["add_options"] = ::menu_add_options;
	var_00["select_by_name"] = ::menu_select_by_name;
	level._createfx.menus = var_00;
}

//Function Number: 2
menu(param_00)
{
	return level.create_fx_menu == param_00;
}

//Function Number: 3
setmenu(param_00)
{
	level.create_fx_menu = param_00;
}

//Function Number: 4
create_fx_menu()
{
	if(common_scripts\_createfx::button_is_clicked("escape","x"))
	{
		_exit_menu();
		return;
	}

	if(isdefined(level._createfx.menus[level.create_fx_menu]))
	{
		[[ level._createfx.menus[level.create_fx_menu] ]]();
	}
}

//Function Number: 5
menu_create_select()
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

	if(common_scripts\_createfx::button_is_clicked("6"))
	{
		var_00 = common_scripts\_createfx::createreactiveent();
		finish_creating_entity(var_00);
		return;
	}

	if(common_scripts\_createfx::button_is_clicked("7"))
	{
		var_00 = common_scripts\_createfx::createdynamicambience();
		finish_creating_entity(var_00);
		return;
	}
}

//Function Number: 6
menu_create()
{
	level.createfx_menu_list_active = 1;
	if(next_button())
	{
		increment_list_offset();
		draw_effects_list();
	}
	else if(previous_button())
	{
		decrement_list_offset();
		draw_effects_list();
	}

	menu_fx_creation();
}

//Function Number: 7
menu_none()
{
	if(common_scripts\_createfx::button_is_clicked("m"))
	{
		increment_list_offset();
	}

	menu_change_selected_fx();
	if(entities_are_selected())
	{
		var_00 = get_last_selected_ent();
		if(!isdefined(level.last_displayed_ent) || var_00 != level.last_displayed_ent || level._createfx.justconvertedoneshot == 1)
		{
			display_fx_info(var_00);
			level.last_displayed_ent = var_00;
			level._createfx.justconvertedoneshot = 0;
		}

		if(common_scripts\_createfx::button_is_clicked("a"))
		{
			common_scripts\_createfx::clear_settable_fx();
			setmenu("add_options");
			return;
		}

		return;
	}

	level.last_displayed_ent = undefined;
}

//Function Number: 8
menu_add_options()
{
	if(!entities_are_selected())
	{
		common_scripts\_createfx::clear_fx_hudelements();
		setmenu("none");
		return;
	}

	display_fx_add_options(get_last_selected_ent());
	if(next_button())
	{
		increment_list_offset();
	}
}

//Function Number: 9
menu_select_by_name()
{
	if(next_button())
	{
		increment_list_offset();
		draw_effects_list("Select by name");
	}
	else if(previous_button())
	{
		decrement_list_offset();
		draw_effects_list("Select by name");
	}

	select_by_name();
}

//Function Number: 10
next_button()
{
	return common_scripts\_createfx::button_is_clicked("rightarrow");
}

//Function Number: 11
previous_button()
{
	return common_scripts\_createfx::button_is_clicked("leftarrow");
}

//Function Number: 12
_exit_menu()
{
	common_scripts\_createfx::clear_fx_hudelements();
	common_scripts\_createfx::clear_entity_selection();
	common_scripts\_createfx::update_selected_entities();
	setmenu("none");
}

//Function Number: 13
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
		level.createfx_menu_list_active = 0;
		level.createfx_last_movement_timer = 0;
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

//Function Number: 14
finish_creating_entity(param_00)
{
	param_00.v["angles"] = vectortoangles(param_00.v["origin"] + (0,0,100) - param_00.v["origin"]);
	param_00 common_scripts\_createfx::post_entity_creation_function();
	common_scripts\_createfx::clear_entity_selection();
	common_scripts\_createfx::select_last_entity();
	common_scripts\_createfx::move_selection_to_cursor();
	common_scripts\_createfx::update_selected_entities();
	setmenu("none");
	level.createfx_menu_list_active = 0;
}

//Function Number: 15
entities_are_selected()
{
	return level._createfx.selected_fx_ents.size > 0;
}

//Function Number: 16
menu_change_selected_fx()
{
	if(!level._createfx.selected_fx_ents.size)
	{
		return;
	}

	var_00 = 0;
	var_01 = 0;
	var_02 = get_last_selected_ent();
	for(var_03 = 0;var_03 < level._createfx.options.size;var_03++)
	{
		var_04 = level._createfx.options[var_03];
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

//Function Number: 17
prepare_option_for_change(param_00,param_01)
{
	if(param_00["name"] == "fxid")
	{
		setmenu("change_fxid");
		draw_effects_list();
		return;
	}

	level.createfx_inputlocked = 1;
	level._createfx.hudelems[param_01 + 1][0].color = (1,1,0);
	if(isdefined(param_00["input_func"]))
	{
		thread [[ param_00["input_func"] ]](param_01 + 1);
	}
	else
	{
		common_scripts\_createfx::createfx_centerprint("To set " + param_00["description"] + ", type /fx newvalue. To remove " + param_00["description"] + ", type /fx del");
	}

	set_option_index(param_00["name"]);
	setdvar("fx","nil");
}

//Function Number: 18
menu_fx_option_set()
{
	if(getdvar("fx") == "nil")
	{
		return;
	}

	if(getdvar("fx") == "del")
	{
		common_scripts\_createfx::remove_selected_option();
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

	if(var_00["type"] == "vector")
	{
		var_01 = getdvarvector("fx");
	}

	if(isdefined(var_01))
	{
		apply_option_to_selected_fx(var_00,var_01);
		return;
	}

	setdvar("fx","nil");
}

//Function Number: 19
apply_option_to_selected_fx(param_00,param_01)
{
	common_scripts\_createfx::save_undo_buffer();
	for(var_02 = 0;var_02 < level._createfx.selected_fx_ents.size;var_02++)
	{
		var_03 = level._createfx.selected_fx_ents[var_02];
		if(mask(param_00["mask"],var_03.v["type"]))
		{
			var_03.v[param_00["name"]] = param_01;
		}
	}

	level.last_displayed_ent = undefined;
	common_scripts\_createfx::update_selected_entities();
	common_scripts\_createfx::clear_settable_fx();
	if(param_00["name"] == "origin")
	{
		level.createfx_last_movement_timer = 0;
		common_scripts\_createfx::frame_selected();
	}

	if(param_00["name"] == "angles")
	{
		level.createfx_last_movement_timer = 0;
	}

	common_scripts\_createfx::save_redo_buffer();
}

//Function Number: 20
set_option_index(param_00)
{
	for(var_01 = 0;var_01 < level._createfx.options.size;var_01++)
	{
		if(level._createfx.options[var_01]["name"] != param_00)
		{
			continue;
		}

		level._createfx.selected_fx_option_index = var_01;
		return;
	}
}

//Function Number: 21
get_selected_option()
{
	return level._createfx.options[level._createfx.selected_fx_option_index];
}

//Function Number: 22
mask(param_00,param_01)
{
	return isdefined(level.createfxmasks[param_00][param_01]);
}

//Function Number: 23
addoption(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = [];
	var_07["type"] = param_00;
	var_07["name"] = param_01;
	var_07["description"] = param_02;
	var_07["default"] = param_03;
	var_07["mask"] = param_04;
	if(isdefined(param_05) && param_05)
	{
		var_07["nowrite"] = 1;
	}
	else
	{
		var_07["nowrite"] = 0;
	}

	if(isdefined(param_06))
	{
		var_07["input_func"] = param_06;
	}

	level._createfx.options[level._createfx.options.size] = var_07;
}

//Function Number: 24
get_option(param_00)
{
	for(var_01 = 0;var_01 < level._createfx.options.size;var_01++)
	{
		if(level._createfx.options[var_01]["name"] == param_00)
		{
			return level._createfx.options[var_01];
		}
	}
}

//Function Number: 25
input_reactive_radius(param_00)
{
	for(;;)
	{
		wait(0.05);
		if(level.player buttonpressed("escape") || level.player buttonpressed("x"))
		{
			break;
		}

		var_01 = 0;
		if(level.player buttonpressed("-"))
		{
			var_01 = -10;
		}
		else if(level.player buttonpressed("="))
		{
			var_01 = 10;
		}

		if(var_01 != 0)
		{
			foreach(var_03 in level._createfx.selected_fx_ents)
			{
				if(isdefined(var_03.v["reactive_radius"]))
				{
					var_03.v["reactive_radius"] = var_03.v["reactive_radius"] + var_01;
					var_03.v["reactive_radius"] = clamp(var_03.v["reactive_radius"],10,1000);
				}
			}
		}
	}

	level.last_displayed_ent = undefined;
	common_scripts\_createfx::update_selected_entities();
	common_scripts\_createfx::clear_settable_fx();
}

//Function Number: 26
display_fx_add_options(param_00)
{
	level.createfx_menu_list_active = 1;
	common_scripts\_createfx::clear_fx_hudelements();
	common_scripts\_createfx::set_fx_hudelement("Name: " + param_00.v["fxid"]);
	common_scripts\_createfx::set_fx_hudelement("Type: " + param_00.v["type"]);
	common_scripts\_createfx::set_fx_hudelement("Origin: " + param_00.v["origin"]);
	common_scripts\_createfx::set_fx_hudelement("Angles: " + param_00.v["angles"]);
	var_01 = 0;
	var_02 = 0;
	var_03 = 0;
	if(level.effect_list_offset >= level._createfx.options.size)
	{
		level.effect_list_offset = 0;
	}

	for(var_04 = 0;var_04 < level._createfx.options.size;var_04++)
	{
		var_05 = level._createfx.options[var_04];
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
		level.effect_list_current_size = var_01;
		common_scripts\_createfx::set_fx_hudelement("(->) More >");
	}

	common_scripts\_createfx::set_fx_hudelement("(x) Exit >");
}

//Function Number: 27
add_option_to_selected_entities(param_00)
{
	var_01 = undefined;
	for(var_02 = 0;var_02 < level._createfx.selected_fx_ents.size;var_02++)
	{
		var_03 = level._createfx.selected_fx_ents[var_02];
		if(mask(param_00["mask"],var_03.v["type"]))
		{
			var_03.v[param_00["name"]] = param_00["default"];
		}
	}
}

//Function Number: 28
menunone()
{
	level.effect_list_offset = 0;
	common_scripts\_createfx::clear_fx_hudelements();
	setmenu("none");
}

//Function Number: 29
display_fx_info(param_00)
{
	if(!menu("none"))
	{
		return;
	}

	if(level.createfx_help_active)
	{
		return;
	}

	common_scripts\_createfx::clear_fx_hudelements();
	common_scripts\_createfx::set_fx_hudelement("Name: " + param_00.v["fxid"]);
	common_scripts\_createfx::set_fx_hudelement("Type: " + param_00.v["type"]);
	if(entities_are_selected())
	{
		var_01 = 0;
		var_02 = 0;
		var_03 = 0;
		for(var_04 = 0;var_04 < level._createfx.options.size;var_04++)
		{
			var_05 = level._createfx.options[var_04];
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
			level.effect_list_current_size = var_01;
			common_scripts\_createfx::set_fx_hudelement("(->) More >");
		}

		common_scripts\_createfx::set_fx_hudelement("(a) Add >");
		common_scripts\_createfx::set_fx_hudelement("(x) Exit >");
		return;
	}

	var_01 = 0;
	var_03 = 0;
	for(var_04 = 0;var_04 < level._createfx.options.size;var_04++)
	{
		var_05 = level._createfx.options[var_04];
		if(!isdefined(param_00.v[var_05["name"]]))
		{
			continue;
		}

		var_01++;
		common_scripts\_createfx::set_fx_hudelement(var_05["description"] + ": " + param_00.v[var_05["name"]]);
		if(var_01 > level._createfx.hudelem_count)
		{
			break;
		}
	}
}

//Function Number: 30
display_current_translation()
{
	var_00 = get_last_selected_ent();
	if(isdefined(var_00))
	{
		display_fx_info(var_00);
	}
}

//Function Number: 31
draw_effects_list(param_00)
{
	common_scripts\_createfx::clear_fx_hudelements();
	var_01 = 0;
	var_02 = 0;
	var_03 = common_scripts\_createfx::func_get_level_fx();
	level.effect_list_current_size = var_03.size;
	if(!isdefined(param_00))
	{
		param_00 = "Pick an effect";
	}

	common_scripts\_createfx::set_fx_hudelement(param_00 + " [" + level.effect_list_offset + " - " + var_03.size + "]:");
	for(var_04 = level.effect_list_offset;var_04 < var_03.size;var_04++)
	{
		var_01 = var_01 + 1;
		common_scripts\_createfx::set_fx_hudelement(var_01 + ". " + var_03[var_04]);
		if(var_01 >= level.effect_list_offset_max)
		{
			var_02 = 1;
			break;
		}
	}

	if(var_03.size > level.effect_list_offset_max)
	{
		common_scripts\_createfx::set_fx_hudelement("(->) More >");
		common_scripts\_createfx::set_fx_hudelement("(<-) Previous >");
	}
}

//Function Number: 32
increment_list_offset()
{
	if(level.effect_list_offset >= level.effect_list_current_size - level.effect_list_offset_max)
	{
		level.effect_list_offset = 0;
		return;
	}

	level.effect_list_offset = level.effect_list_offset + level.effect_list_offset_max;
}

//Function Number: 33
decrement_list_offset()
{
	if(level.effect_list_current_size < level.effect_list_offset_max)
	{
		level.effect_list_offset = 0;
		return;
	}

	level.effect_list_offset = level.effect_list_offset - level.effect_list_offset_max;
	if(level.effect_list_offset < 0)
	{
		level.effect_list_offset = level.effect_list_current_size - level.effect_list_offset_max;
	}
}

//Function Number: 34
draw_help_list(param_00)
{
	common_scripts\_createfx::clear_fx_hudelements();
	var_01 = 0;
	var_02 = level.createfx_help_keys;
	if(!isdefined(param_00))
	{
		param_00 = "Help";
	}

	common_scripts\_createfx::set_fx_hudelement("[" + param_00 + "]");
	for(var_03 = level.help_list_offset;var_03 < var_02.size;var_03++)
	{
		var_01 = var_01 + 1;
		common_scripts\_createfx::set_fx_hudelement(var_02[var_03]);
		if(var_01 >= level.help_list_offset_max)
		{
			var_04 = 1;
			break;
		}
	}

	if(var_02.size > level.help_list_offset_max)
	{
		level.effect_list_current_size = var_02.size;
		common_scripts\_createfx::set_fx_hudelement("(->) More >");
		common_scripts\_createfx::set_fx_hudelement("(<-) Previous >");
	}
}

//Function Number: 35
increment_help_list_offset()
{
	var_00 = level.createfx_help_keys;
	if(level.help_list_offset >= var_00.size - level.help_list_offset_max)
	{
		level.help_list_offset = 0;
		return;
	}

	level.help_list_offset = level.help_list_offset + level.help_list_offset_max;
}

//Function Number: 36
decrement_help_list_offset()
{
	level.help_list_offset = level.help_list_offset - level.help_list_offset_max;
	if(level.help_list_offset < 0)
	{
		var_00 = level.createfx_help_keys;
		level.help_list_offset = var_00.size - level.help_list_offset_max;
	}
}

//Function Number: 37
help_navigation_buttons()
{
	while(level.createfx_help_active == 1)
	{
		if(next_button())
		{
			increment_help_list_offset();
			draw_help_list();
			wait(0.1);
			continue;
		}

		if(previous_button())
		{
			decrement_help_list_offset();
			draw_help_list();
			wait(0.1);
		}

		wait 0.05;
	}
}

//Function Number: 38
setup_help_keys()
{
	level.createfx_help_keys = ["Insert             Insert entity","F2                 Toggle createfx dot and text drawing","F5                 SAVES your work","Z                  Undo","Shift-Z            Redo","F                  Frames currently selected entities in camera view","END                Drop selected entities to the ground","A                  Add option to the selected entities","P                  Reset the rotation of the selected entities","V                  Copy the angles from the most recently selected fx onto all selected fx.","O                  Orient all selected fx to point at most recently selected fx.","S                  Toggle Snap2Normal mode.","L                  Toggle 90deg Snap mode.","G                  Select all effects in level of same exploder or flag as selected.","U                  Select by name list.","C                  Convert One-Shot to Exploder.","Delete             Kill the selected entities","ESCAPE             Cancel out of option-modify-mode, must have console open","SPACE or ->        Turn on exploders","<-                 Turn off exploders","Dpad               Move selected entities on X/Y or rotate pitch/yaw","A button           Toggle the selection of the current entity","X button           Toggle entity rotation mode","Y button           Move selected entites up or rotate roll","B button           Move selected entites down or rotate roll","R Shoulder         Move selected entities to the cursor","L Shoulder         Hold to select multiple entites","L JoyClick         Copy","R JoyClick         Paste","Ctrl-C             Copy","Ctrl-V             Paste","N                  UFO","T                  Toggle Timescale FAST","Y                  Toggle Timescale SLOW","[                  Toggle FX Visibility","]                  Toggle ShowTris","F11                Toggle FX Profile"];
}

//Function Number: 39
select_by_name()
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

	var_05 = [];
	foreach(var_03, var_07 in level.createfxent)
	{
		if(issubstr(var_07.v["fxid"],var_01))
		{
			var_05[var_05.size] = var_03;
		}
	}

	common_scripts\_createfx::deselect_all_ents();
	common_scripts\_createfx::select_index_array(var_05);
	level._createfx.select_by_name = 1;
}

//Function Number: 40
get_last_selected_ent()
{
	return level._createfx.selected_fx_ents[level._createfx.selected_fx_ents.size - 1];
}