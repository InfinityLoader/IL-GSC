/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_createfx.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 114
 * Decompile Time: 1457 ms
 * Timestamp: 10/27/2023 1:16:05 AM
*******************************************************************/

//Function Number: 1
createeffect(param_00,param_01)
{
	var_02 = spawnstruct();
	if(!isdefined(level.createfxent))
	{
		level.createfxent = [];
	}

	level.createfxent[level.createfxent.size] = var_02;
	var_02.var_880E = [];
	var_02.var_880E["type"] = param_00;
	var_02.var_880E["fxid"] = param_01;
	var_02.var_880E["angles"] = (0,0,0);
	var_02.var_880E["origin"] = (0,0,0);
	var_02.drawn = 1;
	if(isdefined(param_01) && isdefined(level.createfxbyfxid))
	{
		var_03 = level.createfxbyfxid[param_01];
		if(!isdefined(var_03))
		{
			var_03 = [];
		}

		var_03[var_03.size] = var_02;
		level.createfxbyfxid[param_01] = var_03;
	}

	return var_02;
}

//Function Number: 2
func_3B1B()
{
	return 0.5;
}

//Function Number: 3
func_3B64()
{
	return -15;
}

//Function Number: 4
func_3AA4()
{
	return 0;
}

//Function Number: 5
func_3ADC()
{
	return 0.75;
}

//Function Number: 6
getintervalsounddelaymaxdefault()
{
	return 2;
}

//Function Number: 7
createloopsound()
{
	var_00 = spawnstruct();
	if(!isdefined(level.createfxent))
	{
		level.createfxent = [];
	}

	level.createfxent[level.createfxent.size] = var_00;
	var_00.var_880E = [];
	var_00.var_880E["type"] = "soundfx";
	var_00.var_880E["fxid"] = "No FX";
	var_00.var_880E["soundalias"] = "nil";
	var_00.var_880E["angles"] = (0,0,0);
	var_00.var_880E["origin"] = (0,0,0);
	var_00.var_880E["server_culled"] = 1;
	if(getdvar("serverCulledSounds") != "1")
	{
		var_00.var_880E["server_culled"] = 0;
	}

	var_00.drawn = 1;
	return var_00;
}

//Function Number: 8
createintervalsound()
{
	var_00 = createloopsound();
	var_00.var_880E["type"] = "soundfx_interval";
	var_00.var_880E["delay_min"] = func_3ADC();
	var_00.var_880E["delay_max"] = getintervalsounddelaymaxdefault();
	return var_00;
}

//Function Number: 9
createnewexploder()
{
	var_00 = spawnstruct();
	if(!isdefined(level.createfxent))
	{
		level.createfxent = [];
	}

	level.createfxent[level.createfxent.size] = var_00;
	var_00.var_880E = [];
	var_00.var_880E["type"] = "exploder";
	var_00.var_880E["fxid"] = "No FX";
	var_00.var_880E["soundalias"] = "nil";
	var_00.var_880E["loopsound"] = "nil";
	var_00.var_880E["angles"] = (0,0,0);
	var_00.var_880E["origin"] = (0,0,0);
	var_00.var_880E["exploder"] = 1;
	var_00.var_880E["flag"] = "nil";
	var_00.var_880E["exploder_type"] = "normal";
	var_00.drawn = 1;
	return var_00;
}

//Function Number: 10
createexploderex(param_00,param_01)
{
	var_02 = common_scripts\utility::createexploder(param_00);
	var_02.var_880E["exploder"] = param_01;
	return var_02;
}

//Function Number: 11
func_2117()
{
	var_00 = spawnstruct();
	level.createfxent[level.createfxent.size] = var_00;
	var_00.var_880E = [];
	var_00.var_880E["origin"] = (0,0,0);
	var_00.var_880E["reactive_radius"] = 200;
	var_00.var_880E["fxid"] = "No FX";
	var_00.var_880E["type"] = "reactive_fx";
	var_00.var_880E["soundalias"] = "nil";
	return var_00;
}

//Function Number: 12
func_6F3C(param_00,param_01)
{
	if(isdefined(level.createfx_offset))
	{
		param_00 = param_00 + level.createfx_offset;
	}

	self.var_880E["origin"] = param_00;
	self.var_880E["angles"] = param_01;
}

//Function Number: 13
func_6EE6()
{
	self.var_880E["up"] = anglestoup(self.var_880E["angles"]);
	self.var_880E["forward"] = anglestoforward(self.var_880E["angles"]);
}

//Function Number: 14
func_20E7()
{
	precacheshader("black");
	level.var_658 = spawnstruct();
	level.var_658.grenade = spawn("script_origin",(0,0,0));
	level.var_658.grenade.fx = loadfx("fx/explosions/grenadeexp_default");
	level.var_658.grenade.sound = "grenade_explode_default";
	level.var_658.grenade.radius = 256;
	if(level.mp_createfx)
	{
		func_3E6A("painter_mp");
	}
	else
	{
		func_3E6A("painter");
	}

	common_scripts\utility::func_3385("createfx_saving");
	common_scripts\utility::func_3385("createfx_started");
	if(!isdefined(level.createfx))
	{
		level.createfx = [];
	}

	level.createfx_loopcounter = 0;
	level notify("createfx_common_done");
}

//Function Number: 15
func_4562()
{
	level.var_658.selectedmove_up = 0;
	level.var_658.selectedmove_forward = 0;
	level.var_658.selectedmove_right = 0;
	level.var_658.selectedrotate_pitch = 0;
	level.var_658.selectedrotate_roll = 0;
	level.var_658.selectedrotate_yaw = 0;
	level.var_658.selected_fx = [];
	level.var_658.selected_fx_ents = [];
	level.var_658.rate = 1;
	level.var_658.snap2normal = 0;
	level.var_658.axismode = 0;
	level.var_658.select_by_name = 0;
	level.var_658.player_speed = getdvarfloat("g_speed");
	func_6F7C();
}

//Function Number: 16
func_456B()
{
	level.var_658.lockedlist = [];
	level.var_658.lockedlist["escape"] = 1;
	level.var_658.lockedlist["BUTTON_LSHLDR"] = 1;
	level.var_658.lockedlist["BUTTON_RSHLDR"] = 1;
	level.var_658.lockedlist["mouse1"] = 1;
	level.var_658.lockedlist["ctrl"] = 1;
}

//Function Number: 17
init_colors()
{
	var_00 = [];
	var_00["loopfx"]["selected"] = (1,1,0.2);
	var_00["loopfx"]["highlighted"] = (0.4,0.95,1);
	var_00["loopfx"]["default"] = (0.3,0.8,1);
	var_00["oneshotfx"]["selected"] = (1,1,0.2);
	var_00["oneshotfx"]["highlighted"] = (0.4,0.95,1);
	var_00["oneshotfx"]["default"] = (0.3,0.8,1);
	var_00["exploder"]["selected"] = (1,1,0.2);
	var_00["exploder"]["highlighted"] = (1,0.2,0.2);
	var_00["exploder"]["default"] = (1,0.1,0.1);
	var_00["rainfx"]["selected"] = (1,1,0.2);
	var_00["rainfx"]["highlighted"] = (0.95,0.4,0.95);
	var_00["rainfx"]["default"] = (0.78,0,0.73);
	var_00["soundfx"]["selected"] = (1,1,0.2);
	var_00["soundfx"]["highlighted"] = (0.5,1,0.75);
	var_00["soundfx"]["default"] = (0.2,0.9,0.2);
	var_00["soundfx_interval"]["selected"] = (1,1,0.2);
	var_00["soundfx_interval"]["highlighted"] = (0.5,1,0.75);
	var_00["soundfx_interval"]["default"] = (0.2,0.9,0.2);
	var_00["reactive_fx"]["selected"] = (1,1,0.2);
	var_00["reactive_fx"]["highlighted"] = (0.5,1,0.75);
	var_00["reactive_fx"]["default"] = (0.2,0.9,0.2);
	level.var_658.colors = var_00;
}

//Function Number: 18
createfxlogic()
{
	waittillframeend;
	wait(0.05);
	if(!isdefined(level._effect))
	{
		level._effect = [];
	}

	if(getdvar("createfx_map") == "")
	{
	}
	else if(getdvar("createfx_map") == common_scripts\utility::func_39CA())
	{
		[[ level.func_position_player ]]();
	}

	func_4532();
	common_scripts\_createfxmenu::func_456D();
	func_455D();
	func_45C0();
	func_4532();
	func_4562();
	func_456B();
	init_colors();
	if(getdvar("createfx_use_f4") == "")
	{
	}

	if(getdvar("createfx_no_autosave") == "")
	{
	}

	level.createfx_draw_enabled = 1;
	level.var_4BF4 = undefined;
	level.buttonisheld = [];
	var_00 = (0,0,0);
	common_scripts\utility::flag_set("createfx_started");
	if(!level.mp_createfx)
	{
		var_00 = level.player.origin;
	}

	var_01 = undefined;
	level.fx_rotating = 0;
	common_scripts\_createfxmenu::func_706E("none");
	level.createfx_selecting = 0;
	var_02 = newhudelem();
	var_02.x = -120;
	var_02.y = 200;
	var_02.foreground = 0;
	var_02 setshader("black",250,160);
	var_02.alpha = 0;
	level.createfx_inputlocked = 0;
	foreach(var_04 in level.createfxent)
	{
		var_04 func_60C3();
	}

	thread func_2A56();
	var_06 = undefined;
	thread func_20E4();
	for(;;)
	{
		var_07 = 0;
		var_08 = anglestoright(level.player getplayerangles());
		var_09 = anglestoforward(level.player getplayerangles());
		var_0A = anglestoup(level.player getplayerangles());
		var_0B = 0.85;
		var_0C = var_09 * 750;
		level.createfxcursor = bullettrace(level.player geteye(),level.player geteye() + var_0C,0,undefined);
		var_0D = undefined;
		level.buttonclick = [];
		level.button_is_kb = [];
		func_61BE();
		var_0E = button_is_held("ctrl","BUTTON_LSHLDR");
		var_0F = button_is_clicked("mouse1","BUTTON_A");
		var_10 = button_is_held("mouse1","BUTTON_A");
		common_scripts\_createfxmenu::create_fx_menu();
		var_11 = "F5";
		if(getdvarint("createfx_use_f4"))
		{
			var_11 = "F4";
		}

		if(button_is_clicked(var_11))
		{
		}

		if(getdvarint("scr_createfx_dump"))
		{
			func_377D();
		}

		if(button_is_clicked("F2"))
		{
			func_814B();
		}

		if(button_is_clicked("ins"))
		{
			func_4664();
		}

		if(button_is_clicked("del"))
		{
			func_2573();
		}

		if(button_is_clicked("escape"))
		{
			clear_settable_fx();
		}

		if(button_is_clicked("space"))
		{
			set_off_exploders();
		}

		if(button_is_clicked("u"))
		{
			func_6D6A();
		}

		modify_player_speed();
		if(!var_0E && button_is_clicked("g"))
		{
			func_6D66("exploder");
			func_6D66("flag");
		}

		if(button_is_held("h","F1"))
		{
			func_74E6();
			wait(0.05);
			continue;
		}

		if(button_is_clicked("BUTTON_LSTICK"))
		{
			copy_ents();
		}

		if(button_is_clicked("BUTTON_RSTICK"))
		{
			func_5B19();
		}

		if(var_0E)
		{
			if(button_is_clicked("c"))
			{
				copy_ents();
			}

			if(button_is_clicked("v"))
			{
				func_5B19();
			}

			if(button_is_clicked("g"))
			{
				spawn_grenade();
			}
		}

		if(isdefined(level.var_658.selected_fx_option_index))
		{
			common_scripts\_createfxmenu::menu_fx_option_set();
		}

		for(var_12 = 0;var_12 < level.createfxent.size;var_12++)
		{
			var_04 = level.createfxent[var_12];
			var_13 = vectornormalize(var_04.var_880E["origin"] - level.player.origin + (0,0,55));
			var_14 = vectordot(var_09,var_13);
			if(var_14 < var_0B)
			{
				continue;
			}

			var_0B = var_14;
			var_0D = var_04;
		}

		level.fx_highlightedent = var_0D;
		if(isdefined(var_0D))
		{
			if(isdefined(var_01))
			{
				if(var_01 != var_0D)
				{
					if(!func_2F52(var_01))
					{
						var_01 thread entity_highlight_disable();
					}

					if(!func_2F52(var_0D))
					{
						var_0D thread entity_highlight_enable();
					}
				}
			}
			else if(!func_2F52(var_0D))
			{
				var_0D thread entity_highlight_enable();
			}
		}

		func_5078(var_0D,var_0F,var_10,var_0E,var_08);
		var_07 = func_3F43(var_07);
		wait(0.05);
		if(var_07)
		{
			func_86A9();
		}

		if(!level.mp_createfx)
		{
			var_00 = [[ level.func_position_player_get ]](var_00);
		}

		var_01 = var_0D;
		if(func_4C1F(var_06))
		{
			level.effect_list_offset = 0;
			clear_settable_fx();
			common_scripts\_createfxmenu::func_706E("none");
		}

		if(level.var_658.selected_fx_ents.size)
		{
			var_06 = level.var_658.selected_fx_ents[level.var_658.selected_fx_ents.size - 1];
			continue;
		}

		var_06 = undefined;
	}
}

//Function Number: 19
modify_player_speed()
{
	var_00 = 0;
	var_01 = button_is_held("ctrl");
	if(button_is_held("."))
	{
		if(var_01)
		{
			if(level.var_658.player_speed < 190)
			{
				level.var_658.player_speed = 190;
			}
			else
			{
				level.var_658.player_speed = level.var_658.player_speed + 10;
			}
		}
		else
		{
			level.var_658.player_speed = level.var_658.player_speed + 5;
		}

		var_00 = 1;
	}
	else if(button_is_held(","))
	{
		if(var_01)
		{
			if(level.var_658.player_speed > 190)
			{
				level.var_658.player_speed = 190;
			}
			else
			{
				level.var_658.player_speed = level.var_658.player_speed - 10;
			}
		}
		else
		{
			level.var_658.player_speed = level.var_658.player_speed - 5;
		}

		var_00 = 1;
	}

	if(var_00)
	{
		level.var_658.player_speed = clamp(level.var_658.player_speed,5,500);
		[[ level.func_player_speed ]]();
		func_6F7C();
	}
}

//Function Number: 20
func_6F7C()
{
	if(!isdefined(level.var_658.player_speed_hud))
	{
		var_00 = newhudelem();
		var_00.alignx = "right";
		var_00.foreground = 1;
		var_00.fontscale = 1.2;
		var_00.alpha = 0.2;
		var_00.x = 320;
		var_00.y = 420;
		var_01 = newhudelem();
		var_01.alignx = "left";
		var_01.foreground = 1;
		var_01.fontscale = 1.2;
		var_01.alpha = 0.2;
		var_01.x = 320;
		var_01.y = 420;
		var_00.hud_value = var_01;
		level.var_658.player_speed_hud = var_00;
	}

	level.var_658.player_speed_hud.hud_value setvalue(level.var_658.player_speed);
}

//Function Number: 21
func_814B()
{
	level.createfx_draw_enabled = !level.createfx_draw_enabled;
}

//Function Number: 22
func_4664()
{
	common_scripts\_createfxmenu::func_706E("creation");
	level.effect_list_offset = 0;
	func_1D10();
	func_6EEA("Pick effect type to create:");
	func_6EEA("1. One Shot FX");
	func_6EEA("2. Looping sound");
	func_6EEA("3. Exploder");
	func_6EEA("4. One Shot Sound");
	func_6EEA("5. Reactive Sound");
	func_6EEA("(c) Cancel >");
	func_6EEA("(x) Exit >");
}

//Function Number: 23
func_5078(param_00,param_01,param_02,param_03,param_04)
{
	if(!level.createfx_draw_enabled)
	{
	}

	if(level.var_658.select_by_name)
	{
		level.var_658.select_by_name = 0;
		param_00 = undefined;
	}
	else if(select_by_substring())
	{
		param_00 = undefined;
	}

	for(var_05 = 0;var_05 < level.createfxent.size;var_05++)
	{
		var_06 = level.createfxent[var_05];
		if(!var_06.drawn)
		{
			continue;
		}

		var_07 = getdvarfloat("createfx_scaleid");
		if(isdefined(param_00) && var_06 == param_00)
		{
			if(!common_scripts\_createfxmenu::entities_are_selected())
			{
				common_scripts\_createfxmenu::func_27DD(var_06);
			}

			if(param_01)
			{
				var_08 = index_is_selected(var_05);
				level.createfx_selecting = !var_08;
				if(!param_03)
				{
					var_09 = level.var_658.selected_fx_ents.size;
					clear_entity_selection();
					if(var_08 && var_09 == 1)
					{
						func_6D6C(var_05,var_06);
					}
				}

				func_814C(var_05,var_06);
			}
			else if(param_02)
			{
				if(param_03)
				{
					if(level.createfx_selecting)
					{
						func_6D6C(var_05,var_06);
					}

					if(!level.createfx_selecting)
					{
						deselect_entity(var_05,var_06);
					}
				}
			}

			var_0A = "highlighted";
		}
		else
		{
			var_0A = "default";
		}

		if(index_is_selected(var_05))
		{
			var_0A = "selected";
		}

		var_06 createfx_print3d(var_0A,var_07,param_04);
	}
}

//Function Number: 24
createfx_print3d(param_00,param_01,param_02)
{
	if(self.textalpha > 0)
	{
		var_03 = func_396A();
		var_04 = param_02 * var_03.size * -2.93;
		var_05 = level.var_658.colors[self.var_880E["type"]][param_00];
		if(isdefined(self.is_playing))
		{
			var_05 = (1,0.5,0);
		}

		if(isdefined(self.var_880E["reactive_radius"]))
		{
		}
	}
}

//Function Number: 25
func_396A()
{
	switch(self.var_880E["type"])
	{
		case "reactive_fx":
			return "reactive: " + self.var_880E["soundalias"];

		default:
			return self.var_880E["fxid"];
	}
}

//Function Number: 26
func_6D6A()
{
	level.effect_list_offset = 0;
	func_1D10();
	common_scripts\_createfxmenu::func_706E("select_by_name");
	common_scripts\_createfxmenu::draw_effects_list();
}

//Function Number: 27
func_3F43(param_00)
{
	if(level.var_658.selected_fx_ents.size > 0)
	{
		param_00 = func_6D73(param_00);
		if(!current_mode_hud("selected_ents"))
		{
			func_55C1("selected_ents");
			func_6FAD("Selected Ent Mode");
			func_6FAD("Mode:","move");
			func_6FAD("Rate:",level.var_658.rate);
			func_6FAD("Snap2Normal:",level.var_658.snap2normal);
		}

		if(level.var_658.axismode && level.var_658.selected_fx_ents.size > 0)
		{
			func_6FAD("Mode:","rotate");
			thread [[ level.func_process_fx_rotater ]]();
			if(button_is_clicked("enter","p"))
			{
				func_65DF();
			}

			if(button_is_clicked("v"))
			{
				func_1F39();
			}

			for(var_01 = 0;var_01 < level.var_658.selected_fx_ents.size;var_01++)
			{
				level.var_658.selected_fx_ents[var_01] func_2A4A();
			}

			if(level.selectedrotate_pitch != 0 || level.selectedrotate_yaw != 0 || level.selectedrotate_roll != 0)
			{
				param_00 = 1;
			}
		}
		else
		{
			func_6FAD("Mode:","move");
			var_02 = get_selected_move_vector();
			for(var_01 = 0;var_01 < level.var_658.selected_fx_ents.size;var_01++)
			{
				var_03 = level.var_658.selected_fx_ents[var_01];
				if(isdefined(var_03.model))
				{
					continue;
				}

				var_03 func_2A54();
				var_03.var_880E["origin"] = var_03.var_880E["origin"] + var_02;
			}

			if(distance((0,0,0),var_02) > 0)
			{
				param_00 = 1;
			}
		}
	}
	else
	{
		clear_tool_hud();
	}

	return param_00;
}

//Function Number: 28
func_6D73(param_00)
{
	if(button_is_clicked("shift","BUTTON_X"))
	{
		func_814A();
	}

	func_5323();
	if(button_is_clicked("s"))
	{
		func_814F();
	}

	if(button_is_clicked("end","l"))
	{
		drop_selection_to_ground();
		param_00 = 1;
	}

	if(button_is_clicked("tab","BUTTON_RSHLDR"))
	{
		func_544F();
		param_00 = 1;
	}

	return param_00;
}

//Function Number: 29
func_5323()
{
	var_00 = button_is_held("shift");
	var_01 = button_is_held("ctrl");
	if(button_is_clicked("="))
	{
		if(var_00)
		{
			level.var_658.rate = level.var_658.rate + 1;
		}
		else if(var_01)
		{
			if(level.var_658.rate < 1)
			{
				level.var_658.rate = 1;
			}
			else
			{
				level.var_658.rate = level.var_658.rate + 10;
			}
		}
		else
		{
			level.var_658.rate = level.var_658.rate + 0.1;
		}
	}
	else if(button_is_clicked("-"))
	{
		if(var_00)
		{
			level.var_658.rate = level.var_658.rate - 1;
		}
		else if(var_01)
		{
			if(level.var_658.rate > 1)
			{
				level.var_658.rate = 1;
			}
			else
			{
				level.var_658.rate = 0.1;
			}
		}
		else
		{
			level.var_658.rate = level.var_658.rate - 0.1;
		}
	}

	level.var_658.rate = clamp(level.var_658.rate,0.1,100);
	func_6FAD("Rate:",level.var_658.rate);
}

//Function Number: 30
func_814A()
{
	level.var_658.axismode = !level.var_658.axismode;
}

//Function Number: 31
func_814F()
{
	level.var_658.snap2normal = !level.var_658.snap2normal;
	func_6FAD("Snap2Normal:",level.var_658.snap2normal);
}

//Function Number: 32
func_1F39()
{
	level notify("new_ent_selection");
	for(var_00 = 0;var_00 < level.var_658.selected_fx_ents.size;var_00++)
	{
		var_01 = level.var_658.selected_fx_ents[var_00];
		var_01.var_880E["angles"] = level.var_658.selected_fx_ents[level.var_658.selected_fx_ents.size - 1].var_880E["angles"];
		var_01 func_6EE6();
	}

	func_86A9();
}

//Function Number: 33
func_65DF()
{
	level notify("new_ent_selection");
	for(var_00 = 0;var_00 < level.var_658.selected_fx_ents.size;var_00++)
	{
		var_01 = level.var_658.selected_fx_ents[var_00];
		var_01.var_880E["angles"] = (0,0,0);
		var_01 func_6EE6();
	}

	func_86A9();
}

//Function Number: 34
func_4C1F(param_00)
{
	if(isdefined(param_00))
	{
		if(!common_scripts\_createfxmenu::entities_are_selected())
		{
			return 1;
		}
	}
	else
	{
		return common_scripts\_createfxmenu::entities_are_selected();
	}

	return param_00 != level.var_658.selected_fx_ents[level.var_658.selected_fx_ents.size - 1];
}

//Function Number: 35
drop_selection_to_ground()
{
	for(var_00 = 0;var_00 < level.var_658.selected_fx_ents.size;var_00++)
	{
		var_01 = level.var_658.selected_fx_ents[var_00];
		var_02 = bullettrace(var_01.var_880E["origin"],var_01.var_880E["origin"] + (0,0,-2048),0,undefined);
		var_01.var_880E["origin"] = var_02["position"];
	}
}

//Function Number: 36
set_off_exploders()
{
	level notify("createfx_exploder_reset");
	var_00 = [];
	for(var_01 = 0;var_01 < level.var_658.selected_fx_ents.size;var_01++)
	{
		var_02 = level.var_658.selected_fx_ents[var_01];
		if(isdefined(var_02.var_880E["exploder"]))
		{
			var_00[var_02.var_880E["exploder"]] = 1;
		}
	}

	var_03 = getarraykeys(var_00);
	for(var_01 = 0;var_01 < var_03.size;var_01++)
	{
		common_scripts\utility::exploder(var_03[var_01]);
	}
}

//Function Number: 37
func_2A56()
{
	var_00 = 0;
	if(getdvarint("createfx_drawdist") == 0)
	{
	}

	for(;;)
	{
		var_01 = getdvarint("createfx_drawdist");
		var_01 = var_01 * var_01;
		for(var_02 = 0;var_02 < level.createfxent.size;var_02++)
		{
			var_03 = level.createfxent[var_02];
			var_03.drawn = distancesquared(level.player.origin,var_03.var_880E["origin"]) <= var_01;
			var_00++;
			if(var_00 > 100)
			{
				var_00 = 0;
				wait(0.05);
			}
		}

		if(level.createfxent.size == 0)
		{
			wait(0.05);
		}
	}
}

//Function Number: 38
func_20E4()
{
	setdvarifuninitialized("createfx_autosave_time","300");
	for(;;)
	{
		wait(getdvarint("createfx_autosave_time"));
		common_scripts\utility::func_33A0("createfx_saving");
		if(getdvarint("createfx_no_autosave"))
		{
			continue;
		}

		func_377D(1);
	}
}

//Function Number: 39
func_686C(param_00,param_01)
{
	level endon("new_ent_selection");
	var_02 = 0.1;
	for(var_03 = 0;var_03 < var_02 * 20;var_03++)
	{
		if(level.selectedrotate_pitch != 0)
		{
			param_00 addpitch(level.selectedrotate_pitch);
		}
		else if(level.selectedrotate_yaw != 0)
		{
			param_00 addyaw(level.selectedrotate_yaw);
		}
		else
		{
			param_00 addroll(level.selectedrotate_roll);
		}

		wait(0.05);
		param_00 func_2A4A();
		for(var_04 = 0;var_04 < level.var_658.selected_fx_ents.size;var_04++)
		{
			var_05 = level.var_658.selected_fx_ents[var_04];
			if(isdefined(var_05.model))
			{
				continue;
			}

			var_05.var_880E["origin"] = param_01[var_04].origin;
			var_05.var_880E["angles"] = param_01[var_04].angles;
		}
	}
}

//Function Number: 40
func_2573()
{
	if(level.createfx_inputlocked)
	{
		func_6553();
	}

	func_2576();
}

//Function Number: 41
func_6553()
{
	if(!isdefined(level.var_658.selected_fx_option_index))
	{
	}

	var_00 = level.var_658.options[level.var_658.selected_fx_option_index]["name"];
	for(var_01 = 0;var_01 < level.createfxent.size;var_01++)
	{
		var_02 = level.createfxent[var_01];
		if(!func_2F52(var_02))
		{
			continue;
		}

		var_02 func_6546(var_00);
	}

	func_86A9();
	clear_settable_fx();
}

//Function Number: 42
func_6546(param_00)
{
	self.var_880E[param_00] = undefined;
}

//Function Number: 43
func_2576()
{
	var_00 = [];
	for(var_01 = 0;var_01 < level.createfxent.size;var_01++)
	{
		var_02 = level.createfxent[var_01];
		if(func_2F52(var_02))
		{
			if(isdefined(var_02.looper))
			{
				var_02.looper delete();
			}

			var_02 notify("stop_loop");
			continue;
		}

		var_00[var_00.size] = var_02;
	}

	level.createfxent = var_00;
	level.var_658.selected_fx = [];
	level.var_658.selected_fx_ents = [];
	func_1D10();
}

//Function Number: 44
func_544F()
{
	var_00 = level.createfxcursor["position"];
	if(level.var_658.selected_fx_ents.size <= 0)
	{
	}

	var_01 = func_37FD(level.var_658.selected_fx_ents);
	var_02 = var_01 - var_00;
	for(var_03 = 0;var_03 < level.var_658.selected_fx_ents.size;var_03++)
	{
		var_04 = level.var_658.selected_fx_ents[var_03];
		if(isdefined(var_04.model))
		{
			continue;
		}

		var_04.var_880E["origin"] = var_04.var_880E["origin"] - var_02;
		if(level.var_658.snap2normal)
		{
			if(isdefined(level.createfxcursor["normal"]))
			{
				var_04.var_880E["angles"] = vectortoangles(level.createfxcursor["normal"]);
			}
		}
	}
}

//Function Number: 45
select_last_entity()
{
	func_6D6C(level.createfxent.size - 1,level.createfxent[level.createfxent.size - 1]);
}

//Function Number: 46
func_6D66(param_00)
{
	var_01 = [];
	foreach(var_03 in level.var_658.selected_fx_ents)
	{
		if(!isdefined(var_03.var_880E[param_00]))
		{
			continue;
		}

		var_04 = var_03.var_880E[param_00];
		var_01[var_04] = 1;
	}

	foreach(var_04, var_07 in var_01)
	{
		foreach(var_09, var_03 in level.createfxent)
		{
			if(index_is_selected(var_09))
			{
				continue;
			}

			if(!isdefined(var_03.var_880E[param_00]))
			{
				continue;
			}

			if(var_03.var_880E[param_00] != var_04)
			{
				continue;
			}

			func_6D6C(var_09,var_03);
		}
	}

	func_86A9();
}

//Function Number: 47
copy_ents()
{
	if(level.var_658.selected_fx_ents.size <= 0)
	{
	}

	var_00 = [];
	for(var_01 = 0;var_01 < level.var_658.selected_fx_ents.size;var_01++)
	{
		var_02 = level.var_658.selected_fx_ents[var_01];
		var_03 = spawnstruct();
		var_03.var_880E = var_02.var_880E;
		var_03 func_60C3();
		var_00[var_00.size] = var_03;
	}

	level.stored_ents = var_00;
}

//Function Number: 48
func_60C3()
{
	self.textalpha = 0;
	self.drawn = 1;
}

//Function Number: 49
func_5B19()
{
	if(!isdefined(level.stored_ents))
	{
	}

	clear_entity_selection();
	for(var_00 = 0;var_00 < level.stored_ents.size;var_00++)
	{
		add_and_select_entity(level.stored_ents[var_00]);
	}

	func_544F();
	func_86A9();
	level.stored_ents = [];
	copy_ents();
}

//Function Number: 50
add_and_select_entity(param_00)
{
	level.createfxent[level.createfxent.size] = param_00;
	select_last_entity();
}

//Function Number: 51
func_37FD(param_00)
{
	var_01 = (0,0,0);
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_01 = (var_01[0] + param_00[var_02].var_880E["origin"][0],var_01[1] + param_00[var_02].var_880E["origin"][1],var_01[2] + param_00[var_02].var_880E["origin"][2]);
	}

	return (var_01[0] / param_00.size,var_01[1] / param_00.size,var_01[2] / param_00.size);
}

//Function Number: 52
func_2F41()
{
	self endon("death");
	for(;;)
	{
		func_2A4A();
		wait(0.05);
	}
}

//Function Number: 53
rotation_is_occuring()
{
	if(level.selectedrotate_roll != 0)
	{
		return 1;
	}

	if(level.selectedrotate_pitch != 0)
	{
		return 1;
	}

	return level.selectedrotate_yaw != 0;
}

//Function Number: 54
func_619B(param_00,param_01,param_02)
{
	for(var_03 = 0;var_03 < level.var_658.options.size;var_03++)
	{
		var_04 = level.var_658.options[var_03];
		var_05 = var_04["name"];
		if(!isdefined(param_00.var_880E[var_05]))
		{
			continue;
		}

		if(!common_scripts\_createfxmenu::func_50AC(var_04["mask"],param_00.var_880E["type"]))
		{
			continue;
		}

		if(!level.mp_createfx)
		{
			if(common_scripts\_createfxmenu::func_50AC("fx",param_00.var_880E["type"]) && var_05 == "fxid")
			{
				continue;
			}

			if(param_00.var_880E["type"] == "exploder" && var_05 == "exploder")
			{
				continue;
			}

			var_06 = param_00.var_880E["type"] + "/" + var_05;
			if(isdefined(level.var_658.defaults[var_06]) && level.var_658.defaults[var_06] == param_00.var_880E[var_05])
			{
				continue;
			}
		}

		if(var_04["type"] == "string")
		{
			var_07 = param_00.var_880E[var_05] + "";
			if(var_07 == "nil")
			{
				continue;
			}

			cfxprintln(param_01 + "ent.v[ \" + var_05 + "\" ] = \" + param_00.var_880E[var_05] + "\";");
			continue;
		}

		cfxprintln(param_01 + "ent.v[ \" + var_05 + "\" ] = " + param_00.var_880E[var_05] + ";");
	}
}

//Function Number: 55
entity_highlight_disable()
{
	self notify("highlight change");
	self endon("highlight change");
	for(;;)
	{
		self.textalpha = self.textalpha * 0.85;
		self.textalpha = self.textalpha - 0.05;
		if(self.textalpha < 0)
		{
			break;
		}

		wait(0.05);
	}

	self.textalpha = 0;
}

//Function Number: 56
entity_highlight_enable()
{
	self notify("highlight change");
	self endon("highlight change");
	for(;;)
	{
		self.textalpha = self.textalpha + 0.05;
		self.textalpha = self.textalpha * 1.25;
		if(self.textalpha > 1)
		{
			break;
		}

		wait(0.05);
	}

	self.textalpha = 1;
}

//Function Number: 57
clear_settable_fx()
{
	level.createfx_inputlocked = 0;
	level.var_658.selected_fx_option_index = undefined;
	func_65E5();
}

//Function Number: 58
func_65E5()
{
	for(var_00 = 0;var_00 < level.var_658.hudelem_count;var_00++)
	{
		level.var_658.hudelems[var_00][0].color = (1,1,1);
	}
}

//Function Number: 59
func_814C(param_00,param_01)
{
	if(isdefined(level.var_658.selected_fx[param_00]))
	{
		deselect_entity(param_00,param_01);
	}

	func_6D6C(param_00,param_01);
}

//Function Number: 60
func_6D6C(param_00,param_01)
{
	if(isdefined(level.var_658.selected_fx[param_00]))
	{
	}

	clear_settable_fx();
	level notify("new_ent_selection");
	param_01 thread entity_highlight_enable();
	level.var_658.selected_fx[param_00] = 1;
	level.var_658.selected_fx_ents[level.var_658.selected_fx_ents.size] = param_01;
}

//Function Number: 61
ent_is_highlighted(param_00)
{
	if(!isdefined(level.fx_highlightedent))
	{
		return 0;
	}

	return param_00 == level.fx_highlightedent;
}

//Function Number: 62
deselect_entity(param_00,param_01)
{
	if(!isdefined(level.var_658.selected_fx[param_00]))
	{
	}

	clear_settable_fx();
	level notify("new_ent_selection");
	level.var_658.selected_fx[param_00] = undefined;
	if(!ent_is_highlighted(param_01))
	{
		param_01 thread entity_highlight_disable();
	}

	var_02 = [];
	for(var_03 = 0;var_03 < level.var_658.selected_fx_ents.size;var_03++)
	{
		if(level.var_658.selected_fx_ents[var_03] != param_01)
		{
			var_02[var_02.size] = level.var_658.selected_fx_ents[var_03];
		}
	}

	level.var_658.selected_fx_ents = var_02;
}

//Function Number: 63
index_is_selected(param_00)
{
	return isdefined(level.var_658.selected_fx[param_00]);
}

//Function Number: 64
func_2F52(param_00)
{
	for(var_01 = 0;var_01 < level.var_658.selected_fx_ents.size;var_01++)
	{
		if(level.var_658.selected_fx_ents[var_01] == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 65
clear_entity_selection()
{
	for(var_00 = 0;var_00 < level.var_658.selected_fx_ents.size;var_00++)
	{
		if(!ent_is_highlighted(level.var_658.selected_fx_ents[var_00]))
		{
			level.var_658.selected_fx_ents[var_00] thread entity_highlight_disable();
		}
	}

	level.var_658.selected_fx = [];
	level.var_658.selected_fx_ents = [];
}

//Function Number: 66
func_2A4A()
{
}

//Function Number: 67
func_2A54()
{
}

//Function Number: 68
createfx_centerprint(param_00)
{
	thread createfx_centerprint_thread(param_00);
}

//Function Number: 69
createfx_centerprint_thread(param_00)
{
	level notify("new_createfx_centerprint");
	level endon("new_createfx_centerprint");
	for(var_01 = 0;var_01 < 5;var_01++)
	{
	}

	wait(4.5);
	for(var_01 = 0;var_01 < 5;var_01++)
	{
	}
}

//Function Number: 70
get_selected_move_vector()
{
	var_00 = level.player getplayerangles()[1];
	var_01 = (0,var_00,0);
	var_02 = anglestoright(var_01);
	var_03 = anglestoforward(var_01);
	var_04 = anglestoup(var_01);
	var_05 = 0;
	var_06 = level.var_658.rate;
	if(func_18D4("kp_uparrow","DPAD_UP"))
	{
		if(level.selectedmove_forward < 0)
		{
			level.selectedmove_forward = 0;
		}

		level.selectedmove_forward = level.selectedmove_forward + var_06;
	}
	else if(func_18D4("kp_downarrow","DPAD_DOWN"))
	{
		if(level.selectedmove_forward > 0)
		{
			level.selectedmove_forward = 0;
		}

		level.selectedmove_forward = level.selectedmove_forward - var_06;
	}
	else
	{
		level.selectedmove_forward = 0;
	}

	if(func_18D4("kp_rightarrow","DPAD_RIGHT"))
	{
		if(level.selectedmove_right < 0)
		{
			level.selectedmove_right = 0;
		}

		level.selectedmove_right = level.selectedmove_right + var_06;
	}
	else if(func_18D4("kp_leftarrow","DPAD_LEFT"))
	{
		if(level.selectedmove_right > 0)
		{
			level.selectedmove_right = 0;
		}

		level.selectedmove_right = level.selectedmove_right - var_06;
	}
	else
	{
		level.selectedmove_right = 0;
	}

	if(func_18D4("BUTTON_Y"))
	{
		if(level.selectedmove_up < 0)
		{
			level.selectedmove_up = 0;
		}

		level.selectedmove_up = level.selectedmove_up + var_06;
	}
	else if(func_18D4("BUTTON_B"))
	{
		if(level.selectedmove_up > 0)
		{
			level.selectedmove_up = 0;
		}

		level.selectedmove_up = level.selectedmove_up - var_06;
	}
	else
	{
		level.selectedmove_up = 0;
	}

	var_07 = (0,0,0);
	var_07 = var_07 + var_03 * level.selectedmove_forward;
	var_07 = var_07 + var_02 * level.selectedmove_right;
	var_07 = var_07 + var_04 * level.selectedmove_up;
	return var_07;
}

//Function Number: 71
func_6E30()
{
	var_00 = level.var_658.rate;
	if(func_18D4("kp_uparrow","DPAD_UP"))
	{
		if(level.selectedrotate_pitch < 0)
		{
			level.selectedrotate_pitch = 0;
		}

		level.selectedrotate_pitch = level.selectedrotate_pitch + var_00;
	}
	else if(func_18D4("kp_downarrow","DPAD_DOWN"))
	{
		if(level.selectedrotate_pitch > 0)
		{
			level.selectedrotate_pitch = 0;
		}

		level.selectedrotate_pitch = level.selectedrotate_pitch - var_00;
	}
	else
	{
		level.selectedrotate_pitch = 0;
	}

	if(func_18D4("kp_leftarrow","DPAD_LEFT"))
	{
		if(level.selectedrotate_yaw < 0)
		{
			level.selectedrotate_yaw = 0;
		}

		level.selectedrotate_yaw = level.selectedrotate_yaw + var_00;
	}
	else if(func_18D4("kp_rightarrow","DPAD_RIGHT"))
	{
		if(level.selectedrotate_yaw > 0)
		{
			level.selectedrotate_yaw = 0;
		}

		level.selectedrotate_yaw = level.selectedrotate_yaw - var_00;
	}
	else
	{
		level.selectedrotate_yaw = 0;
	}

	if(func_18D4("BUTTON_Y"))
	{
		if(level.selectedrotate_roll < 0)
		{
			level.selectedrotate_roll = 0;
		}

		level.selectedrotate_roll = level.selectedrotate_roll + var_00;
	}

	if(func_18D4("BUTTON_B"))
	{
		if(level.selectedrotate_roll > 0)
		{
			level.selectedrotate_roll = 0;
		}

		level.selectedrotate_roll = level.selectedrotate_roll - var_00;
	}

	level.selectedrotate_roll = 0;
}

//Function Number: 72
func_86A9()
{
	var_00 = 0;
	foreach(var_02 in level.var_658.selected_fx_ents)
	{
		if(var_02.var_880E["type"] == "reactive_fx")
		{
			var_00 = 1;
		}

		var_02 [[ level.func_updatefx ]]();
	}

	if(var_00)
	{
		refresh_reactive_fx_ents();
	}
}

//Function Number: 73
func_3E6A(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "painter_mp";
	}

	precachemenu(param_00);
	wait(0.05);
	if(param_00 == "painter_mp")
	{
	}

	level.player openpopupmenu(param_00);
	level.player closepopupmenu(param_00);
}

//Function Number: 74
func_7C2A()
{
	if(isdefined(self.looper))
	{
		self.looper delete();
	}

	stop_loopsound();
}

//Function Number: 75
stop_loopsound()
{
	self notify("stop_loop");
}

//Function Number: 76
func_get_level_fx()
{
	if(!isdefined(level._effect_keys))
	{
		var_00 = getarraykeys(level._effect);
	}
	else
	{
		var_00 = getarraykeys(level._effect);
		if(var_00.size == level._effect_keys.size)
		{
			return level._effect_keys;
		}
	}

	var_00 = common_scripts\utility::alphabetize(var_00);
	level._effect_keys = var_00;
	return var_00;
}

//Function Number: 77
func_6641()
{
	func_7C2A();
	func_6EE6();
	switch(self.var_880E["type"])
	{
		case "oneshotfx":
			common_scripts\_fx::func_20BB();
			break;

		case "soundfx":
			common_scripts\_fx::create_loopsound();
			break;

		case "soundfx_interval":
			common_scripts\_fx::func_2094();
			break;
	}
}

//Function Number: 78
refresh_reactive_fx_ents()
{
	level._fx.reactive_fx_ents = undefined;
	foreach(var_01 in level.createfxent)
	{
		if(var_01.var_880E["type"] == "reactive_fx")
		{
			var_01 func_6EE6();
			var_01 common_scripts\_fx::add_reactive_fx();
		}
	}
}

//Function Number: 79
func_61C5()
{
	if(level.fx_rotating)
	{
	}

	func_6E30();
	if(!rotation_is_occuring())
	{
	}

	level.fx_rotating = 1;
	if(level.var_658.selected_fx_ents.size > 1)
	{
		var_00 = func_37FD(level.var_658.selected_fx_ents);
		var_01 = spawn("script_origin",var_00);
		var_01.var_880E["angles"] = level.var_658.selected_fx_ents[0].var_880E["angles"];
		var_01.var_880E["origin"] = var_00;
		var_02 = [];
		for(var_03 = 0;var_03 < level.var_658.selected_fx_ents.size;var_03++)
		{
			var_02[var_03] = spawn("script_origin",level.var_658.selected_fx_ents[var_03].var_880E["origin"]);
			var_02[var_03].angles = level.var_658.selected_fx_ents[var_03].var_880E["angles"];
			var_02[var_03] linkto(var_01);
		}

		func_686C(var_01,var_02);
		var_01 delete();
		for(var_03 = 0;var_03 < var_02.size;var_03++)
		{
			var_02[var_03] delete();
		}
	}
	else if(level.var_658.selected_fx_ents.size == 1)
	{
		var_04 = level.var_658.selected_fx_ents[0];
		var_02 = spawn("script_origin",(0,0,0));
		var_02.angles = var_04.var_880E["angles"];
		if(level.selectedrotate_pitch != 0)
		{
			var_02 addpitch(level.selectedrotate_pitch);
		}
		else if(level.selectedrotate_yaw != 0)
		{
			var_02 addyaw(level.selectedrotate_yaw);
		}
		else
		{
			var_02 addroll(level.selectedrotate_roll);
		}

		var_04.var_880E["angles"] = var_02.angles;
		var_02 delete();
		wait(0.05);
	}

	level.fx_rotating = 0;
}

//Function Number: 80
spawn_grenade()
{
	playfx(level.var_658.grenade.fx,level.createfxcursor["position"]);
	level.var_658.grenade playsound(level.var_658.grenade.sound);
	radiusdamage(level.createfxcursor["position"],level.var_658.grenade.radius,50,5,undefined,"MOD_EXPLOSIVE");
	level notify("code_damageradius",undefined,level.var_658.grenade.radius,level.createfxcursor["position"]);
}

//Function Number: 81
func_74E6()
{
	func_1D10();
	func_6EEA("Help:");
	func_6EEA("Insert          Insert entity");
	func_6EEA("L               Drop selected entities to the ground");
	func_6EEA("A               Add option to the selected entities");
	func_6EEA("P               Reset the rotation of the selected entities");
	func_6EEA("V               Copy the angles from the most recently selected fx onto all selected fx.");
	func_6EEA("Delete          Kill the selected entities");
	func_6EEA("ESCAPE          Cancel out of option-modify-mode, must have console open");
	func_6EEA("Ctrl-C          Copy");
	func_6EEA("Ctrl-V          Paste");
	func_6EEA("F2              Toggle createfx dot and text drawing");
	func_6EEA("F5              SAVES your work");
	func_6EEA("Dpad            Move selected entitise on X/Y or rotate pitch/yaw");
	func_6EEA("A button        Toggle the selection of the current entity");
	func_6EEA("X button        Toggle entity rotation mode");
	func_6EEA("Y button        Move selected entites up or rotate roll");
	func_6EEA("B button        Move selected entites down or rotate roll");
	func_6EEA("R Shoulder      Move selected entities to the cursor");
	func_6EEA("L Shoulder      Hold to select multiple entites");
	func_6EEA("L JoyClick      Copy");
	func_6EEA("R JoyClick      Paste");
	func_6EEA("N               UFO");
	func_6EEA("T               Toggle Timescale FAST");
	func_6EEA("Y               Toggle Timescale SLOW");
	func_6EEA("[               Toggle FX Visibility");
	func_6EEA("]               Toggle ShowTris");
	func_6EEA("F11             Toggle FX Profile");
}

//Function Number: 82
func_377D(param_00)
{
}

//Function Number: 83
write_log(param_00,param_01,param_02,param_03)
{
	var_04 = "\t";
	cfxprintlnstart();
	cfxprintln("//_createfx generated. Do not touch!!");
	cfxprintln("#include common_scripts\\utility;");
	cfxprintln("#include common_scripts\\_createfx;\n");
	cfxprintln("");
	cfxprintln("main()");
	cfxprintln("{");
	cfxprintln(var_04 + "// CreateFX " + param_01 + " entities placed: " + param_00.size);
	foreach(var_06 in param_00)
	{
		if(level.createfx_loopcounter > 16)
		{
			level.createfx_loopcounter = 0;
			wait(0.1);
		}

		level.createfx_loopcounter++;
		if(getdvarint("scr_map_exploder_dump"))
		{
			if(!isdefined(var_06.model))
			{
				continue;
			}
		}
		else if(isdefined(var_06.model))
		{
			continue;
		}

		if(var_06.var_880E["type"] == "oneshotfx")
		{
			cfxprintln(var_04 + "ent = createOneshotEffect( \" + var_06.var_880E["fxid"] + "\" );");
		}

		if(var_06.var_880E["type"] == "exploder")
		{
			if(isdefined(var_06.var_880E["exploder"]) && !level.mp_createfx)
			{
				cfxprintln(var_04 + "ent = createExploderEx( \" + var_06.var_880E["fxid"] + "\", \" + var_06.var_880E["exploder"] + "\" );");
			}
			else
			{
				cfxprintln(var_04 + "ent = createExploder( \" + var_06.var_880E["fxid"] + "\" );");
			}
		}

		if(var_06.var_880E["type"] == "soundfx")
		{
			cfxprintln(var_04 + "ent = createLoopSound();");
		}

		if(var_06.var_880E["type"] == "soundfx_interval")
		{
			cfxprintln(var_04 + "ent = createIntervalSound();");
		}

		if(var_06.var_880E["type"] == "reactive_fx")
		{
			cfxprintln(var_04 + "ent = createReactiveEnt();");
		}

		cfxprintln(var_04 + "ent set_origin_and_angles( " + var_06.var_880E["origin"] + ", " + var_06.var_880E["angles"] + " );");
		func_619B(var_06,var_04,param_02);
		cfxprintln("");
	}

	cfxprintln("}");
	cfxprintln(" ");
	cfxprintlnend(param_02,param_03,param_01);
}

//Function Number: 84
func_20E3()
{
	var_00 = 0.1;
	foreach(var_02 in level.createfxent)
	{
		var_03 = [];
		var_04 = [];
		for(var_05 = 0;var_05 < 3;var_05++)
		{
			var_03[var_05] = var_02.var_880E["origin"][var_05];
			var_04[var_05] = var_02.var_880E["angles"][var_05];
			if(var_03[var_05] < var_00 && var_03[var_05] > var_00 * -1)
			{
				var_03[var_05] = 0;
			}

			if(var_04[var_05] < var_00 && var_04[var_05] > var_00 * -1)
			{
				var_04[var_05] = 0;
			}
		}

		var_02.var_880E["origin"] = (var_03[0],var_03[1],var_03[2]);
		var_02.var_880E["angles"] = (var_04[0],var_04[1],var_04[2]);
	}
}

//Function Number: 85
func_382A(param_00)
{
	var_01 = func_382B(param_00);
	var_02 = [];
	foreach(var_05, var_04 in var_01)
	{
		var_02[var_05] = [];
	}

	foreach(var_07 in level.createfxent)
	{
		var_08 = 0;
		foreach(var_05, param_00 in var_01)
		{
			if(var_07.var_880E["type"] != param_00)
			{
				continue;
			}

			var_08 = 1;
			var_02[var_05][var_02[var_05].size] = var_07;
			break;
		}
	}

	var_0B = [];
	for(var_0C = 0;var_0C < var_01.size;var_0C++)
	{
		foreach(var_07 in var_02[var_0C])
		{
			var_0B[var_0B.size] = var_07;
		}
	}

	return var_0B;
}

//Function Number: 86
func_382B(param_00)
{
	var_01 = [];
	if(param_00 == "fx")
	{
		var_01[0] = "oneshotfx";
		var_01[1] = "exploder";
	}
	else
	{
		var_01[0] = "soundfx";
		var_01[1] = "soundfx_interval";
		var_01[2] = "reactive_fx";
	}

	return var_01;
}

//Function Number: 87
func_47D3(param_00,param_01)
{
	var_02 = func_382B(param_01);
	foreach(var_04 in var_02)
	{
		if(param_00.var_880E["type"] == var_04)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 88
func_20EA()
{
	var_00 = [];
	var_00[0] = "soundfx";
	var_00[1] = "oneshotfx";
	var_00[2] = "exploder";
	var_00[3] = "soundfx_interval";
	var_00[4] = "reactive_fx";
	var_01 = [];
	foreach(var_04, var_03 in var_00)
	{
		var_01[var_04] = [];
	}

	foreach(var_06 in level.createfxent)
	{
		var_07 = 0;
		foreach(var_04, var_09 in var_00)
		{
			if(var_06.var_880E["type"] != var_09)
			{
				continue;
			}

			var_07 = 1;
			var_01[var_04][var_01[var_04].size] = var_06;
			break;
		}
	}

	var_0B = [];
	for(var_0C = 0;var_0C < var_00.size;var_0C++)
	{
		foreach(var_06 in var_01[var_0C])
		{
			var_0B[var_0B.size] = var_06;
		}
	}

	level.createfxent = var_0B;
}

//Function Number: 89
cfxprintlnstart()
{
	common_scripts\utility::fileprint_launcher_start_file();
}

//Function Number: 90
cfxprintln(param_00)
{
	common_scripts\utility::fileprint_launcher(param_00);
}

//Function Number: 91
cfxprintlnend(param_00,param_01,param_02)
{
	var_03 = 1;
	if(param_01 != "" || param_00)
	{
		var_03 = 0;
	}

	if(common_scripts\utility::issp())
	{
		var_04 = common_scripts\utility::func_39CA() + param_01 + "_" + param_02 + ".gsc";
		if(param_00)
		{
			var_04 = "backup_" + param_02 + ".gsc";
		}
	}
	else
	{
		var_04 = common_scripts\utility::func_39CA() + param_02 + "_" + var_03 + ".gsc";
		if(param_00)
		{
			var_04 = "backup.gsc";
		}
	}

	common_scripts\utility::func_3224("/share/raw/maps/createfx/" + var_04,var_03);
}

//Function Number: 92
func_61BE()
{
	add_button("mouse1");
	add_button("BUTTON_RSHLDR");
	add_button("BUTTON_LSHLDR");
	add_button("BUTTON_RSTICK");
	add_button("BUTTON_LSTICK");
	add_button("BUTTON_A");
	add_button("BUTTON_B");
	add_button("BUTTON_X");
	add_button("BUTTON_Y");
	add_button("DPAD_UP");
	add_button("DPAD_LEFT");
	add_button("DPAD_RIGHT");
	add_button("DPAD_DOWN");
	add_kb_button("shift");
	add_kb_button("ctrl");
	add_kb_button("escape");
	add_kb_button("F1");
	add_kb_button("F5");
	add_kb_button("F4");
	add_kb_button("F2");
	add_kb_button("a");
	add_kb_button("g");
	add_kb_button("c");
	add_kb_button("h");
	add_kb_button("i");
	add_kb_button("k");
	add_kb_button("l");
	add_kb_button("m");
	add_kb_button("p");
	add_kb_button("s");
	add_kb_button("u");
	add_kb_button("v");
	add_kb_button("x");
	add_kb_button("del");
	add_kb_button("end");
	add_kb_button("tab");
	add_kb_button("ins");
	add_kb_button("add");
	add_kb_button("space");
	add_kb_button("enter");
	add_kb_button("1");
	add_kb_button("2");
	add_kb_button("3");
	add_kb_button("4");
	add_kb_button("5");
	add_kb_button("6");
	add_kb_button("7");
	add_kb_button("8");
	add_kb_button("9");
	add_kb_button("0");
	add_kb_button("-");
	add_kb_button("=");
	add_kb_button(",");
	add_kb_button(".");
	add_kb_button("[");
	add_kb_button("]");
	add_kb_button("leftarrow");
	add_kb_button("rightarrow");
	add_kb_button("uparrow");
	add_kb_button("downarrow");
}

//Function Number: 93
func_4ED5(param_00)
{
	if(isdefined(level.var_658.lockedlist[param_00]))
	{
		return 0;
	}

	return func_4A71(param_00);
}

//Function Number: 94
func_4A71(param_00)
{
	return level.createfx_inputlocked && isdefined(level.button_is_kb[param_00]);
}

//Function Number: 95
add_button(param_00)
{
	if(func_4ED5(param_00))
	{
	}

	if(!isdefined(level.buttonisheld[param_00]))
	{
		if(level.player buttonpressed(param_00))
		{
			level.buttonisheld[param_00] = 1;
			level.buttonclick[param_00] = 1;
		}
	}

	if(!level.player buttonpressed(param_00))
	{
		level.buttonisheld[param_00] = undefined;
	}
}

//Function Number: 96
add_kb_button(param_00)
{
	level.button_is_kb[param_00] = 1;
	add_button(param_00);
}

//Function Number: 97
func_18D4(param_00,param_01)
{
	return buttonpressed_internal(param_00) || buttonpressed_internal(param_01);
}

//Function Number: 98
buttonpressed_internal(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(func_4A71(param_00))
	{
		return 0;
	}

	return level.player buttonpressed(param_00);
}

//Function Number: 99
button_is_held(param_00,param_01)
{
	if(isdefined(param_01))
	{
		if(isdefined(level.buttonisheld[param_01]))
		{
			return 1;
		}
	}

	return isdefined(level.buttonisheld[param_00]);
}

//Function Number: 100
button_is_clicked(param_00,param_01)
{
	if(isdefined(param_01))
	{
		if(isdefined(level.buttonclick[param_01]))
		{
			return 1;
		}
	}

	return isdefined(level.buttonclick[param_00]);
}

//Function Number: 101
func_455D()
{
	level.var_658.hudelems = [];
	level.var_658.hudelem_count = 30;
	var_00 = [];
	var_01 = [];
	var_00[0] = 0;
	var_01[0] = 0;
	var_00[1] = 1;
	var_01[1] = 1;
	var_00[2] = -2;
	var_01[2] = 1;
	var_00[3] = 1;
	var_01[3] = -1;
	var_00[4] = -2;
	var_01[4] = -1;
	level.var_1D57 = newhudelem();
	level.var_1D57.alpha = 0;
	for(var_02 = 0;var_02 < level.var_658.hudelem_count;var_02++)
	{
		var_03 = [];
		for(var_04 = 0;var_04 < 1;var_04++)
		{
			var_05 = newhudelem();
			var_05.alignx = "left";
			var_05.location = 0;
			var_05.foreground = 1;
			var_05.fontscale = 1.4;
			var_05.sort = 20 - var_04;
			var_05.alpha = 1;
			var_05.x = 0 + var_00[var_04];
			var_05.y = 60 + var_01[var_04] + var_02 * 15;
			if(var_04 > 0)
			{
				var_05.color = (0,0,0);
			}

			var_03[var_03.size] = var_05;
		}

		level.var_658.hudelems[var_02] = var_03;
	}

	var_03 = [];
	for(var_04 = 0;var_04 < 5;var_04++)
	{
		var_05 = newhudelem();
		var_05.alignx = "center";
		var_05.location = 0;
		var_05.foreground = 1;
		var_05.fontscale = 1.4;
		var_05.sort = 20 - var_04;
		var_05.alpha = 1;
		var_05.x = 320 + var_00[var_04];
		var_05.y = 80 + var_01[var_04];
		if(var_04 > 0)
		{
			var_05.color = (0,0,0);
		}

		var_03[var_03.size] = var_05;
	}

	level.createfx_centerprint = var_03;
}

//Function Number: 102
func_4532()
{
	var_00 = newhudelem();
	var_00.location = 0;
	var_00.alignx = "center";
	var_00.aligny = "middle";
	var_00.foreground = 1;
	var_00.fontscale = 2;
	var_00.sort = 20;
	var_00.alpha = 1;
	var_00.x = 320;
	var_00.y = 233;
}

//Function Number: 103
func_1D10()
{
	level.var_1D57 clearalltextafterhudelem();
	for(var_00 = 0;var_00 < level.var_658.hudelem_count;var_00++)
	{
		for(var_01 = 0;var_01 < 1;var_01++)
		{
		}
	}

	level.fxhudelements = 0;
}

//Function Number: 104
func_6EEA(param_00)
{
	for(var_01 = 0;var_01 < 1;var_01++)
	{
	}

	level.fxhudelements++;
}

//Function Number: 105
func_45C0()
{
	if(!isdefined(level.var_658.tool_hudelems))
	{
		level.var_658.tool_hudelems = [];
	}

	if(!isdefined(level.var_658.tool_hud_visible))
	{
		level.var_658.tool_hud_visible = 1;
	}

	if(!isdefined(level.var_658.tool_hud))
	{
		level.var_658.tool_hud = "";
	}
}

//Function Number: 106
func_55C1(param_00)
{
	foreach(var_03, var_02 in level.var_658.tool_hudelems)
	{
		if(isdefined(var_02.value_hudelem))
		{
			var_02.value_hudelem destroy();
		}

		var_02 destroy();
		level.var_658.tool_hudelems[var_03] = undefined;
	}

	level.var_658.tool_hud = param_00;
}

//Function Number: 107
current_mode_hud(param_00)
{
	return level.var_658.tool_hud == param_00;
}

//Function Number: 108
clear_tool_hud()
{
	func_55C1("");
}

//Function Number: 109
func_55C2(param_00)
{
	var_01 = newhudelem();
	var_01.alignx = "left";
	var_01.location = 0;
	var_01.foreground = 1;
	var_01.fontscale = 1.2;
	var_01.alpha = 1;
	var_01.x = 0;
	var_01.y = 320 + param_00 * 15;
	return var_01;
}

//Function Number: 110
get_tool_hudelem(param_00)
{
	if(isdefined(level.var_658.tool_hudelems[param_00]))
	{
		return level.var_658.tool_hudelems[param_00];
	}

	return undefined;
}

//Function Number: 111
func_6FAD(param_00,param_01)
{
	var_02 = get_tool_hudelem(param_00);
	if(!isdefined(var_02))
	{
		var_02 = func_55C2(level.var_658.tool_hudelems.size);
		level.var_658.tool_hudelems[param_00] = var_02;
		var_02.text = param_00;
	}

	if(isdefined(param_01))
	{
		if(isdefined(var_02.value_hudelem))
		{
			var_03 = var_02.value_hudelem;
		}
		else
		{
			var_03 = func_55C2(level.var_658.tool_hudelems.size);
			var_03.x = var_03.x + 80;
			var_03.y = var_02.y;
			var_02.value_hudelem = var_03;
		}

		if(isdefined(var_03.text) && var_03.text == param_01)
		{
		}

		var_03.text = param_01;
	}
}

//Function Number: 112
select_by_substring()
{
	var_00 = getdvar("select_by_substring");
	if(var_00 == "")
	{
		return 0;
	}

	setdvar("select_by_substring","");
	var_01 = [];
	foreach(var_04, var_03 in level.createfxent)
	{
		if(issubstr(var_03.var_880E["fxid"],var_00))
		{
			var_01[var_01.size] = var_04;
		}
	}

	if(var_01.size == 0)
	{
		return 0;
	}

	func_260B();
	func_6D6D(var_01);
	foreach(var_06 in var_01)
	{
		var_03 = level.createfxent[var_06];
		func_6D6C(var_06,var_03);
	}

	return 1;
}

//Function Number: 113
func_6D6D(param_00)
{
	foreach(var_02 in param_00)
	{
		var_03 = level.createfxent[var_02];
		func_6D6C(var_02,var_03);
	}
}

//Function Number: 114
func_260B()
{
	foreach(var_02, var_01 in level.var_658.selected_fx_ents)
	{
		deselect_entity(var_02,var_01);
	}
}