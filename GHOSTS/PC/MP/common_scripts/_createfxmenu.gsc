/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_createfxmenu.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 34
 * Decompile Time: 473 ms
 * Timestamp: 10/27/2023 1:16:07 AM
*******************************************************************/

//Function Number: 1
func_456D()
{
	level.var_658.options = [];
	addoption("string","fxid","FX id","nil","fx");
	addoption("float","delay","Repeat rate/start delay",0.5,"fx");
	addoption("string","flag","Flag","nil","exploder");
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
	addoption("string","soundalias","Soundalias","nil","all");
	addoption("string","loopsound","Loopsound","nil","exploder");
	addoption("int","reactive_radius","Reactive Radius",100,"reactive_fx",::func_4662);
	if(!level.mp_createfx)
	{
		addoption("string","rumble","Rumble","nil","exploder");
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
	level.createfxmasks["all"]["reactive_fx"] = 1;
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
	var_00 = [];
	var_00["creation"] = ::func_51CA;
	var_00["create_oneshot"] = ::menu_create;
	var_00["create_loopfx"] = ::menu_create;
	var_00["change_fxid"] = ::menu_create;
	var_00["none"] = ::menu_none;
	var_00["add_options"] = ::func_51C7;
	var_00["select_by_name"] = ::func_51CE;
	level.var_658.menus = var_00;
}

//Function Number: 2
func_51C6(param_00)
{
	return level.create_fx_menu == param_00;
}

//Function Number: 3
func_706E(param_00)
{
	level.create_fx_menu = param_00;
}

//Function Number: 4
create_fx_menu()
{
	if(common_scripts\_createfx::button_is_clicked("escape","x"))
	{
		_exit_menu();
	}

	if(isdefined(level.var_658.menus[level.create_fx_menu]))
	{
		[[ level.var_658.menus[level.create_fx_menu] ]]();
	}
}

//Function Number: 5
func_51CA()
{
	if(common_scripts\_createfx::button_is_clicked("1"))
	{
		func_706E("create_oneshot");
		draw_effects_list();
	}

	if(common_scripts\_createfx::button_is_clicked("2"))
	{
		func_706E("create_loopsound");
		var_00 = common_scripts\_createfx::createloopsound();
		func_3293(var_00);
	}

	if(common_scripts\_createfx::button_is_clicked("3"))
	{
		func_706E("create_exploder");
		var_00 = common_scripts\_createfx::createnewexploder();
		func_3293(var_00);
	}

	if(common_scripts\_createfx::button_is_clicked("4"))
	{
		func_706E("create_interval_sound");
		var_00 = common_scripts\_createfx::createintervalsound();
		func_3293(var_00);
	}

	if(common_scripts\_createfx::button_is_clicked("5"))
	{
		var_00 = common_scripts\_createfx::func_2117();
		func_3293(var_00);
	}
}

//Function Number: 6
menu_create()
{
	if(func_55D2())
	{
		func_4483();
		draw_effects_list();
	}
	else if(func_6167())
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
		func_4483();
	}

	func_51C8();
	if(entities_are_selected())
	{
		var_00 = get_last_selected_ent();
		if(!isdefined(level.var_4BF4) || var_00 != level.var_4BF4)
		{
			func_27DD(var_00);
			level.var_4BF4 = var_00;
		}

		if(common_scripts\_createfx::button_is_clicked("a"))
		{
			common_scripts\_createfx::clear_settable_fx();
			func_706E("add_options");
		}
	}

	level.var_4BF4 = undefined;
}

//Function Number: 8
func_51C7()
{
	if(!entities_are_selected())
	{
		common_scripts\_createfx::func_1D10();
		func_706E("none");
	}

	display_fx_add_options(get_last_selected_ent());
	if(func_55D2())
	{
		func_4483();
	}
}

//Function Number: 9
func_51CE()
{
	if(func_55D2())
	{
		func_4483();
		draw_effects_list("Select by name");
	}
	else if(func_6167())
	{
		decrement_list_offset();
		draw_effects_list("Select by name");
	}

	select_by_name();
}

//Function Number: 10
func_55D2()
{
	return common_scripts\_createfx::button_is_clicked("rightarrow");
}

//Function Number: 11
func_6167()
{
	return common_scripts\_createfx::button_is_clicked("leftarrow");
}

//Function Number: 12
_exit_menu()
{
	common_scripts\_createfx::func_1D10();
	common_scripts\_createfx::clear_entity_selection();
	common_scripts\_createfx::func_86A9();
	func_706E("none");
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
	}

	if(func_51C6("change_fxid"))
	{
		func_0EA1(func_391F("fxid"),var_01);
		level.effect_list_offset = 0;
		common_scripts\_createfx::func_1D10();
		func_706E("none");
	}

	var_05 = undefined;
	if(func_51C6("create_loopfx"))
	{
		var_05 = common_scripts\utility::createloopeffect(var_01);
	}

	if(func_51C6("create_oneshot"))
	{
		var_05 = common_scripts\utility::createoneshoteffect(var_01);
	}

	func_3293(var_05);
}

//Function Number: 14
func_3293(param_00)
{
	param_00.var_880E["angles"] = vectortoangles(param_00.var_880E["origin"] + (0,0,100) - param_00.var_880E["origin"]);
	param_00 common_scripts\_createfx::func_60C3();
	common_scripts\_createfx::clear_entity_selection();
	common_scripts\_createfx::select_last_entity();
	common_scripts\_createfx::func_544F();
	common_scripts\_createfx::func_86A9();
	func_706E("none");
}

//Function Number: 15
entities_are_selected()
{
	return level.var_658.selected_fx_ents.size > 0;
}

//Function Number: 16
func_51C8()
{
	if(!level.var_658.selected_fx_ents.size)
	{
	}

	var_00 = 0;
	var_01 = 0;
	var_02 = get_last_selected_ent();
	for(var_03 = 0;var_03 < level.var_658.options.size;var_03++)
	{
		var_04 = level.var_658.options[var_03];
		if(!isdefined(var_02.var_880E[var_04["name"]]))
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
			func_613A(var_04,var_01);
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
func_613A(param_00,param_01)
{
	if(param_00["name"] == "fxid")
	{
		func_706E("change_fxid");
		draw_effects_list();
	}

	level.createfx_inputlocked = 1;
	level.var_658.hudelems[param_01 + 3][0].color = (1,1,0);
	if(isdefined(param_00["input_func"]))
	{
		thread [[ param_00["input_func"] ]](param_01 + 3);
	}
	else
	{
		common_scripts\_createfx::createfx_centerprint("To change " + param_00["description"] + " on selected entities, type /fx newvalue");
	}

	func_6F3B(param_00["name"]);
	setdvar("fx","nil");
}

//Function Number: 18
menu_fx_option_set()
{
	if(getdvar("fx") == "nil")
	{
	}

	var_00 = func_399A();
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

	func_0EA1(var_00,var_01);
}

//Function Number: 19
func_0EA1(param_00,param_01)
{
	for(var_02 = 0;var_02 < level.var_658.selected_fx_ents.size;var_02++)
	{
		var_03 = level.var_658.selected_fx_ents[var_02];
		if(func_50AC(param_00["mask"],var_03.var_880E["type"]))
		{
			var_03.var_880E[param_00["name"]] = param_01;
		}
	}

	level.var_4BF4 = undefined;
	common_scripts\_createfx::func_86A9();
	common_scripts\_createfx::clear_settable_fx();
}

//Function Number: 20
func_6F3B(param_00)
{
	for(var_01 = 0;var_01 < level.var_658.options.size;var_01++)
	{
		if(level.var_658.options[var_01]["name"] != param_00)
		{
			continue;
		}

		level.var_658.selected_fx_option_index = var_01;
	}
}

//Function Number: 21
func_399A()
{
	return level.var_658.options[level.var_658.selected_fx_option_index];
}

//Function Number: 22
func_50AC(param_00,param_01)
{
	return isdefined(level.createfxmasks[param_00][param_01]);
}

//Function Number: 23
addoption(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = [];
	var_06["type"] = param_00;
	var_06["name"] = param_01;
	var_06["description"] = param_02;
	var_06["default"] = param_03;
	var_06["mask"] = param_04;
	if(isdefined(param_05))
	{
		var_06["input_func"] = param_05;
	}

	level.var_658.options[level.var_658.options.size] = var_06;
}

//Function Number: 24
func_391F(param_00)
{
	for(var_01 = 0;var_01 < level.var_658.options.size;var_01++)
	{
		if(level.var_658.options[var_01]["name"] == param_00)
		{
			return level.var_658.options[var_01];
		}
	}
}

//Function Number: 25
func_4662(param_00)
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
			foreach(var_03 in level.var_658.selected_fx_ents)
			{
				if(isdefined(var_03.var_880E["reactive_radius"]))
				{
					var_03.var_880E["reactive_radius"] = var_03.var_880E["reactive_radius"] + var_01;
					var_03.var_880E["reactive_radius"] = clamp(var_03.var_880E["reactive_radius"],10,1000);
				}
			}
		}
	}

	level.var_4BF4 = undefined;
	common_scripts\_createfx::func_86A9();
	common_scripts\_createfx::clear_settable_fx();
}

//Function Number: 26
display_fx_add_options(param_00)
{
	common_scripts\_createfx::func_1D10();
	common_scripts\_createfx::func_6EEA("Name: " + param_00.var_880E["fxid"]);
	common_scripts\_createfx::func_6EEA("Type: " + param_00.var_880E["type"]);
	common_scripts\_createfx::func_6EEA("Origin: " + param_00.var_880E["origin"]);
	common_scripts\_createfx::func_6EEA("Angles: " + param_00.var_880E["angles"]);
	var_01 = 0;
	var_02 = 0;
	var_03 = 0;
	if(level.effect_list_offset >= level.var_658.options.size)
	{
		level.effect_list_offset = 0;
	}

	for(var_04 = 0;var_04 < level.var_658.options.size;var_04++)
	{
		var_05 = level.var_658.options[var_04];
		if(isdefined(param_00.var_880E[var_05["name"]]))
		{
			continue;
		}

		if(!func_50AC(var_05["mask"],param_00.var_880E["type"]))
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
			func_51D0();
			level.var_4BF4 = undefined;
		}

		common_scripts\_createfx::func_6EEA(var_06 + ". " + var_05["description"]);
	}

	if(var_01 > level.effect_list_offset_max)
	{
		common_scripts\_createfx::func_6EEA("(->) More >");
	}

	common_scripts\_createfx::func_6EEA("(x) Exit >");
}

//Function Number: 27
add_option_to_selected_entities(param_00)
{
	var_01 = undefined;
	for(var_02 = 0;var_02 < level.var_658.selected_fx_ents.size;var_02++)
	{
		var_03 = level.var_658.selected_fx_ents[var_02];
		if(func_50AC(param_00["mask"],var_03.var_880E["type"]))
		{
			var_03.var_880E[param_00["name"]] = param_00["default"];
		}
	}
}

//Function Number: 28
func_51D0()
{
	level.effect_list_offset = 0;
	common_scripts\_createfx::func_1D10();
	func_706E("none");
}

//Function Number: 29
func_27DD(param_00)
{
	if(!func_51C6("none"))
	{
	}

	common_scripts\_createfx::func_1D10();
	common_scripts\_createfx::func_6EEA("Name: " + param_00.var_880E["fxid"]);
	common_scripts\_createfx::func_6EEA("Type: " + param_00.var_880E["type"]);
	common_scripts\_createfx::func_6EEA("Origin: " + param_00.var_880E["origin"]);
	common_scripts\_createfx::func_6EEA("Angles: " + param_00.var_880E["angles"]);
	if(entities_are_selected())
	{
		var_01 = 0;
		var_02 = 0;
		var_03 = 0;
		for(var_04 = 0;var_04 < level.var_658.options.size;var_04++)
		{
			var_05 = level.var_658.options[var_04];
			if(!isdefined(param_00.var_880E[var_05["name"]]))
			{
				continue;
			}

			var_01++;
			if(var_01 < level.effect_list_offset)
			{
				continue;
			}

			var_02++;
			common_scripts\_createfx::func_6EEA(var_02 + ". " + var_05["description"] + ": " + param_00.var_880E[var_05["name"]]);
			if(var_02 > level.effect_list_offset_max)
			{
				var_03 = 1;
				break;
			}
		}

		if(var_01 > level.effect_list_offset_max)
		{
			common_scripts\_createfx::func_6EEA("(->) More >");
		}

		common_scripts\_createfx::func_6EEA("(a) Add >");
		common_scripts\_createfx::func_6EEA("(x) Exit >");
	}

	var_01 = 0;
	var_03 = 0;
	for(var_04 = 0;var_04 < level.var_658.options.size;var_04++)
	{
		var_05 = level.var_658.options[var_04];
		if(!isdefined(param_00.var_880E[var_05["name"]]))
		{
			continue;
		}

		var_01++;
		common_scripts\_createfx::func_6EEA(var_05["description"] + ": " + param_00.var_880E[var_05["name"]]);
		if(var_01 > level.var_658.hudelem_count)
		{
			break;
		}
	}
}

//Function Number: 30
draw_effects_list(param_00)
{
	common_scripts\_createfx::func_1D10();
	var_01 = 0;
	var_02 = 0;
	var_03 = common_scripts\_createfx::func_get_level_fx();
	if(!isdefined(param_00))
	{
		param_00 = "Pick an effect";
	}

	common_scripts\_createfx::func_6EEA(param_00 + " [" + level.effect_list_offset + " - " + var_03.size + "]:");
	for(var_04 = level.effect_list_offset;var_04 < var_03.size;var_04++)
	{
		var_01 = var_01 + 1;
		common_scripts\_createfx::func_6EEA(var_01 + ". " + var_03[var_04]);
		if(var_01 >= level.effect_list_offset_max)
		{
			var_02 = 1;
			break;
		}
	}

	if(var_03.size > level.effect_list_offset_max)
	{
		common_scripts\_createfx::func_6EEA("(->) More >");
		common_scripts\_createfx::func_6EEA("(<-) Previous >");
	}
}

//Function Number: 31
func_4483()
{
	var_00 = common_scripts\_createfx::func_get_level_fx();
	if(level.effect_list_offset >= var_00.size - level.effect_list_offset_max)
	{
		level.effect_list_offset = 0;
	}

	level.effect_list_offset = level.effect_list_offset + level.effect_list_offset_max;
}

//Function Number: 32
decrement_list_offset()
{
	level.effect_list_offset = level.effect_list_offset - level.effect_list_offset_max;
	if(level.effect_list_offset < 0)
	{
		var_00 = common_scripts\_createfx::func_get_level_fx();
		level.effect_list_offset = var_00.size - level.effect_list_offset_max;
	}
}

//Function Number: 33
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
	}

	var_05 = [];
	foreach(var_03, var_07 in level.createfxent)
	{
		if(issubstr(var_07.var_880E["fxid"],var_01))
		{
			var_05[var_05.size] = var_03;
		}
	}

	common_scripts\_createfx::func_260B();
	common_scripts\_createfx::func_6D6D(var_05);
	level.var_658.select_by_name = 1;
}

//Function Number: 34
get_last_selected_ent()
{
	return level.var_658.selected_fx_ents[level.var_658.selected_fx_ents.size - 1];
}