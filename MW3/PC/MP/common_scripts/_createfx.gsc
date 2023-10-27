/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_createfx.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 83
 * Decompile Time: 1398 ms
 * Timestamp: 10/27/2023 2:16:00 AM
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
	var_02.v = [];
	var_02.v["type"] = param_00;
	var_02.v["fxid"] = param_01;
	var_02.v["angles"] = (0,0,0);
	var_02.v["origin"] = (0,0,0);
	var_02.var_845 = 1;
	if(isdefined(param_01) && isdefined(level.createfxbyfxid))
	{
		var_03 = level.createfxbyfxid[param_01];
		if(!isdefined(var_03))
		{
			var_03 = [];
		}

		level.createfxbyfxid[var_02] = var_7B;
	}

	return var_03;
}

//Function Number: 2
getloopeffectdelaydefault()
{
	return 0.5;
}

//Function Number: 3
getoneshoteffectdelaydefault()
{
	return -15;
}

//Function Number: 4
getexploderdelaydefault()
{
	return 0;
}

//Function Number: 5
getintervalsounddelaymindefault()
{
	return 0.75;
}

//Function Number: 6
getintervalsounddelaymaxdefault()
{
	return 2;
}

//Function Number: 7
add_effect(param_00,param_01)
{
	if(!isdefined(level._effect))
	{
		level._effect = [];
	}

	level._effect[param_00] = loadfx(param_01);
}

//Function Number: 8
createloopsound()
{
	var_00 = spawnstruct();
	if(!isdefined(level.createfxent))
	{
		level.createfxent = [];
	}

	level.createfxent[level.createfxent.size] = var_00;
	var_00.v = [];
	var_00.v["type"] = "soundfx";
	var_00.v["fxid"] = "No FX";
	var_00.v["soundalias"] = "nil";
	var_00.v["angles"] = (0,0,0);
	var_00.v["origin"] = (0,0,0);
	var_00.v["server_culled"] = 1;
	if(getdvar("serverCulledSounds") != "1")
	{
		var_00.v["server_culled"] = 0;
	}

	var_00.var_845 = 1;
	return var_00;
}

//Function Number: 9
createintervalsound()
{
	var_00 = createloopsound();
	var_00.v["type"] = "soundfx_interval";
	var_00.v["delay_min"] = getintervalsounddelaymindefault();
	var_00.v["delay_max"] = getintervalsounddelaymaxdefault();
	return var_00;
}

//Function Number: 10
createnewexploder()
{
	var_00 = spawnstruct();
	if(!isdefined(level.createfxent))
	{
		level.createfxent = [];
	}

	level.createfxent[level.createfxent.size] = var_00;
	var_00.v = [];
	var_00.v["type"] = "exploder";
	var_00.v["fxid"] = "No FX";
	var_00.v["soundalias"] = "nil";
	var_00.v["loopsound"] = "nil";
	var_00.v["angles"] = (0,0,0);
	var_00.v["origin"] = (0,0,0);
	var_00.v["exploder"] = 1;
	var_00.v["flag"] = "nil";
	var_00.v["exploder_type"] = "normal";
	var_00.var_845 = 1;
	return var_00;
}

//Function Number: 11
createexploderex(param_00,param_01)
{
	var_02 = common_scripts\utility::createexploder(param_00);
	var_02.v["exploder"] = param_01;
	return var_02;
}

//Function Number: 12
set_origin_and_angles(param_00,param_01)
{
	self.v["origin"] = param_00;
	self.v["angles"] = param_01;
}

//Function Number: 13
set_forward_and_up_vectors()
{
	self.v["up"] = anglestoup(self.v["angles"]);
	self.v["forward"] = anglestoforward(self.v["angles"]);
}

//Function Number: 14
createfx_common()
{
	precacheshader("black");
	if(level.mp_createfx)
	{
		hack_start("painter_mp");
	}
	else
	{
		hack_start("painter");
	}

	common_scripts\utility::flag_init("createfx_saving");
	if(!isdefined(level.createfx))
	{
		level.createfx = [];
	}

	level.var_852 = 0;
	var_00 = getentarray();
	foreach(var_02 in var_00)
	{
		if(isspawner(var_02))
		{
			var_02 delete();
		}
	}

	var_04 = getentarray("trigger_multiple","classname");
	for(var_05 = 0;var_05 < var_04.size;var_05++)
	{
		var_04[var_05] delete();
	}

	var_04 = getentarray("trigger_radius","classname");
	for(var_05 = 0;var_05 < var_04.size;var_05++)
	{
		var_04[var_05] delete();
	}

	level notify("createfx_common_done");
}

//Function Number: 15
createfxlogic()
{
	waittillframeend;
	common_scripts\_createfxmenu::menu_init();
	if(!isdefined(level._effect))
	{
		level._effect = [];
	}

	if(getdvar("createfx_map") == "")
	{
	}
	else if(getdvar("createfx_map") == common_scripts\utility::get_template_level())
	{
		[[ level.func_position_player ]]();
	}

	level.var_833 = [];
	level.var_83E = 30;
	var_00 = [];
	var_01 = [];
	var_00[0] = 0;
	var_01[1] = 1;
	var_01[2] = -2;
	var_01[3] = 1;
	var_01[4] = -2;
	var_02 = newhudelem();
	var_02.location = 0;
	var_02.alignx = "center";
	var_02.aligny = "middle";
	var_02.foreground = 1;
	var_02.fontscale = 2;
	var_02.sort = 20;
	var_02.alpha = 1;
	var_02.x = 320;
	var_02.y = 233;
	var_02 settext(".");
	level.var_857 = newhudelem();
	level.var_857.alpha = 0;
	level.var_857 settext("marker");
	for(var_03 = 0;var_03 < level.var_83E;var_03++ = -1)
	{
		var_04 = [];
		for(var_05 = 0;var_05 < 1;var_05++ = var_7B[4])
		{
			var_06 = newhudelem();
			var_06.alignx = "left";
			var_06.location = 0;
			var_06.foreground = 1;
			var_06.fontscale = 1.4;
			var_06.sort = 20 - var_05;
			var_06.alpha = 1;
			var_06.x = 0 + var_01[var_05];
			var_06.y = 60 + var_7B[var_05] + var_03 * 15;
			if(var_05 > 0)
			{
				var_06.color = (0,0,0);
			}

			var_04[var_04.size] = var_06;
		}

		level.var_833[var_03] = var_04;
	}

	var_04 = [];
	for(var_05 = 0;var_05 < 5;var_05++ = var_7B[3])
	{
		var_06 = newhudelem();
		var_06.alignx = "center";
		var_06.location = 0;
		var_06.foreground = 1;
		var_06.fontscale = 1.4;
		var_06.sort = 20 - var_05;
		var_06.alpha = 1;
		var_06.x = 320 + var_01[var_05];
		var_06.y = 80 + var_7B[var_05];
		if(var_05 > 0)
		{
			var_06.color = (0,0,0);
		}

		var_04[var_04.size] = var_06;
	}

	level.createfx_centerprint = var_04;
	level.var_858 = 0;
	level.var_859 = 0;
	level.var_85A = 0;
	level.var_85B = 0;
	level.var_85C = 0;
	level.var_85D = 0;
	level.var_85E = [];
	level.var_81F = [];
	level.var_85F = [];
	level.var_85F["escape"] = 1;
	level.var_85F["BUTTON_LSHLDR"] = 1;
	level.var_85F["BUTTON_RSHLDR"] = 1;
	level.var_85F["mouse1"] = 1;
	level.var_85F["ctrl"] = 1;
	level.var_860 = 1;
	level.var_818 = undefined;
	level.var_861 = [];
	var_07 = 0;
	var_08 = (0,0,0);
	if(!level.mp_createfx)
	{
		var_08 = level.player.origin;
	}

	var_09 = [];
	var_1C["loopfx"] = "selected";
	var_1C["loopfx"] = "highlighted";
	var_1C["loopfx"] = "default";
	var_1C["oneshotfx"] = "selected";
	var_1C["oneshotfx"] = "highlighted";
	var_1C["oneshotfx"] = "default";
	var_1C["exploder"] = "selected";
	var_1C["exploder"] = "highlighted";
	var_1C["exploder"] = "default";
	var_1C["rainfx"] = "selected";
	var_1C["rainfx"] = "highlighted";
	var_1C["rainfx"] = "default";
	var_1C["soundfx"] = "selected";
	var_1C["soundfx"] = "highlighted";
	var_1C["soundfx"] = "default";
	var_1C["soundfx_interval"] = "selected";
	var_1C["soundfx_interval"] = "highlighted";
	var_1C["soundfx_interval"] = "default";
	var_0A = undefined;
	level.var_863 = 0;
	common_scripts\_createfxmenu::setmenu("none");
	level.var_864 = 0;
	var_0B = newhudelem();
	var_0B.x = -120;
	var_0B.y = 200;
	var_0B.foreground = 0;
	var_0B setshader("black",250,160);
	var_0B.alpha = 0;
	level.var_832 = 0;
	var_04 = 0;
	while(var_04 < level.createfxent.size)
	{
		var_0C = level.createfxent[var_04];
		var_0C post_entity_creation_function();
		var_04++ = (0.2,0.9,0.2);
	}

	thread draw_distance();
	var_0D = undefined;
	thread createfx_autosave();
	for(;;)
	{
		var_0E = 0;
		var_0F = anglestoright(level.player getplayerangles());
		var_10 = anglestoforward(level.player getplayerangles());
		var_11 = anglestoup(level.player getplayerangles());
		var_12 = 0.85;
		var_13 = var_10 * 750;
		level.var_865 = bullettrace(level.player geteye(),level.player geteye() + var_13,0,undefined);
		var_14 = undefined;
		level.var_866 = [];
		level.var_867 = [];
		process_button_held_and_clicked();
		var_15 = button_is_held("ctrl","BUTTON_LSHLDR");
		var_16 = button_is_clicked("mouse1","BUTTON_A");
		var_17 = button_is_held("mouse1","BUTTON_A");
		common_scripts\_createfxmenu::create_fx_menu();
		if(button_is_clicked("shift","BUTTON_X"))
		{
			var_08 = !var_08;
		}

		if(button_is_clicked("F5"))
		{
		}

		if(getdvarint("scr_createfx_dump"))
		{
			generate_fx_log();
		}

		if(button_is_clicked("F2"))
		{
			toggle_createfx_drawing();
		}

		if(button_is_clicked("ins"))
		{
			insert_effect();
		}

		if(button_is_clicked("del"))
		{
			delete_pressed();
		}

		if(button_is_clicked("end","l"))
		{
			drop_selection_to_ground();
			var_0E = 1;
		}

		if(button_is_clicked("escape"))
		{
			reset_fx_hud_colors();
		}

		if(button_is_clicked("space"))
		{
			turn_off_exploders();
		}

		if(button_is_clicked("g"))
		{
			select_all_exploders_of_currently_selected("exploder");
			select_all_exploders_of_currently_selected("flag");
		}

		if(button_is_clicked("tab","BUTTON_RSHLDR"))
		{
			move_selection_to_cursor();
			var_0E = 1;
		}

		if(button_is_held("h","F1"))
		{
			show_help();
			wait 0.05;
			continue;
		}

		if(button_is_clicked("BUTTON_LSTICK"))
		{
			copy_ents();
		}

		if(button_is_clicked("BUTTON_RSTICK"))
		{
			paste_ents();
		}

		if(var_15)
		{
			if(button_is_clicked("c"))
			{
				copy_ents();
			}

			if(button_is_clicked("v"))
			{
				paste_ents();
			}
		}

		if(isdefined(level.var_837))
		{
			common_scripts\_createfxmenu::menu_fx_option_set();
		}

		var_04 = 0;
		while(var_04 < level.createfxent.size)
		{
			var_0C = level.createfxent[var_04];
			var_18 = vectornormalize(var_0C.v["origin"] - level.player.origin + (0,0,55));
			var_19 = vectordot(var_10,var_18);
			if(var_19 < var_12)
			{
				continue;
			}

			var_12 = var_19;
			var_14 = var_0C;
			var_04++ = (0.5,1,0.75);
		}

		level.var_868 = var_14;
		if(isdefined(var_14))
		{
			if(isdefined(var_0A))
			{
				if(var_0A != var_14)
				{
					if(!ent_is_selected(var_0A))
					{
						var_0A thread entity_highlight_disable();
					}

					if(!ent_is_selected(var_14))
					{
						var_14 thread entity_highlight_enable();
					}
				}
			}
			else if(!ent_is_selected(var_14))
			{
				var_14 thread entity_highlight_enable();
			}
		}

		manipulate_createfx_ents(var_14,var_16,var_17,var_15,var_1C,var_0F);
		if(var_08 && level.var_81F.size > 0)
		{
			thread [[ level.func_process_fx_rotater ]]();
			if(button_is_clicked("enter","p"))
			{
				reset_axis_of_selected_ents();
			}

			if(button_is_clicked("v"))
			{
				copy_angles_of_selected_ents();
			}

			var_04 = 0;
			while(var_04 < level.var_81F.size)
			{
				level.var_81F[var_04] draw_axis();
				var_04++ = (1,1,0.2);
			}

			if(level.var_85B != 0 || level.var_85D != 0 || level.var_85C != 0)
			{
				var_0E = 1;
			}

			wait 0.05;
		}
		else
		{
			var_1A = get_selected_move_vector();
			var_04 = 0;
			while(var_04 < level.var_81F.size)
			{
				var_0C = level.var_81F[var_04];
				if(isdefined(var_0C.model))
				{
					continue;
				}

				var_0C.v["origin"] = var_0C.v["origin"] + var_1A;
				var_04++ = (0.2,0.9,0.2);
			}

			if(distance((0,0,0),var_1A) > 0)
			{
				var_0E = 1;
			}

			wait 0.05;
		}

		if(var_0E)
		{
			update_selected_entities();
		}

		if(!level.mp_createfx)
		{
			var_09 = [[ level.func_position_player_get ]](var_09);
		}

		var_0A = var_14;
		if(last_selected_entity_has_changed(var_0D))
		{
			level.var_822 = 0;
			reset_fx_hud_colors();
			common_scripts\_createfxmenu::setmenu("none");
		}

		if(level.var_81F.size)
		{
			var_0D = level.var_81F[level.var_81F.size - 1];
			continue;
		}

		var_0D = undefined;
	}
}

//Function Number: 16
copy_angles_of_selected_ents()
{
	level notify("new_ent_selection");
	for(var_00 = 0;var_00 < level.var_81F.size;var_00++)
	{
		var_01 = level.var_81F[var_00];
		var_01.v["angles"] = level.var_81F[level.var_81F.size - 1].v["angles"];
		var_01 set_forward_and_up_vectors();
	}

	update_selected_entities();
}

//Function Number: 17
reset_axis_of_selected_ents()
{
	level notify("new_ent_selection");
	for(var_00 = 0;var_00 < level.var_81F.size;var_00++)
	{
		var_01 = level.var_81F[var_00];
		var_01.v["angles"] = (0,0,0);
		var_01 set_forward_and_up_vectors();
	}

	update_selected_entities();
}

//Function Number: 18
last_selected_entity_has_changed(param_00)
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

	return param_00 != level.var_81F[level.var_81F.size - 1];
}

//Function Number: 19
createfx_showorigin(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D,param_0E,param_0F,param_10,param_11,param_12)
{
}

//Function Number: 20
drop_selection_to_ground()
{
	for(var_00 = 0;var_00 < level.var_81F.size;var_00++)
	{
		var_01 = level.var_81F[var_00];
		var_02 = bullettrace(var_01.v["origin"],var_01.v["origin"] + (0,0,-2048),0,undefined);
		var_01.v["origin"] = var_02["position"];
	}
}

//Function Number: 21
turn_off_exploders()
{
	level notify("createfx_exploder_reset");
	var_00 = [];
	for(var_01 = 0;var_01 < level.var_81F.size;var_01++)
	{
		var_02 = level.var_81F[var_01];
		if(isdefined(var_02.v["exploder"]))
		{
			var_00[var_02.v["exploder"]] = 1;
		}
	}

	var_03 = getarraykeys(var_00);
	for(var_01 = 0;var_01 < var_03.size;var_01++)
	{
		common_scripts\utility::exploder(var_03[var_01]);
	}
}

//Function Number: 22
draw_distance()
{
	var_00 = 0;
	if(getdvarint("createfx_drawdist") == 0)
	{
	}

	for(;;)
	{
		var_01 = getdvarint("createfx_drawdist");
		for(var_02 = 0;var_02 < level.createfxent.size;var_02++)
		{
			var_03 = level.createfxent[var_02];
			var_03.var_845 = distance(level.player.origin,var_03.v["origin"]) <= var_01;
			var_00++;
			if(var_00 > 100)
			{
				var_00 = 0;
				wait 0.05;
			}
		}

		if(level.createfxent.size == 0)
		{
			wait 0.05;
		}
	}
}

//Function Number: 23
createfx_autosave()
{
	for(;;)
	{
		wait 300;
		common_scripts\utility::flag_waitopen("createfx_saving");
		generate_fx_log(1);
	}
}

//Function Number: 24
rotate_over_time(param_00,param_01)
{
	level endon("new_ent_selection");
	var_02 = 0.1;
	for(var_03 = 0;var_03 < var_02 * 20;var_03++)
	{
		if(level.var_85B != 0)
		{
			param_00 addpitch(level.var_85B);
		}
		else if(level.var_85D != 0)
		{
			param_00 addyaw(level.var_85D);
		}
		else
		{
			param_00 addroll(level.var_85C);
		}

		wait 0.05;
		param_00 draw_axis();
		for(var_04 = 0;var_04 < level.var_81F.size;var_04++)
		{
			var_05 = level.var_81F[var_04];
			if(isdefined(var_05.model))
			{
				continue;
			}

			var_05.v["origin"] = param_01[var_04].origin;
			var_05.v["angles"] = param_01[var_04].angles;
		}
	}
}

//Function Number: 25
delete_pressed()
{
	if(level.var_832)
	{
		remove_selected_option();
		return;
	}

	delete_selection();
}

//Function Number: 26
remove_selected_option()
{
	if(!isdefined(level.var_837))
	{
		return;
	}

	var_00 = level.var_82A[level.var_837]["name"];
	for(var_01 = 0;var_01 < level.createfxent.size;var_01++)
	{
		var_02 = level.createfxent[var_01];
		if(!ent_is_selected(var_02))
		{
			continue;
		}

		var_02 remove_option(var_00);
	}

	update_selected_entities();
	reset_fx_hud_colors();
}

//Function Number: 27
remove_option(param_00)
{
	self.v[param_00] = undefined;
}

//Function Number: 28
delete_selection()
{
	var_00 = [];
	for(var_01 = 0;var_01 < level.createfxent.size;var_01++)
	{
		var_02 = level.createfxent[var_01];
		if(ent_is_selected(var_02))
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
	level.var_85E = [];
	level.var_81F = [];
	clear_fx_hudelements();
}

//Function Number: 29
move_selection_to_cursor()
{
	var_00 = level.var_865["position"];
	if(level.var_81F.size <= 0)
	{
		return;
	}

	var_01 = get_center_of_array(level.var_81F);
	var_02 = var_01 - var_00;
	for(var_03 = 0;var_03 < level.var_81F.size;var_03++)
	{
		var_04 = level.var_81F[var_03];
		if(isdefined(var_04.model))
		{
			continue;
		}

		var_04.v["origin"] = var_04.v["origin"] - var_02;
	}
}

//Function Number: 30
insert_effect()
{
	common_scripts\_createfxmenu::setmenu("creation");
	level.var_822 = 0;
	clear_fx_hudelements();
	set_fx_hudelement("Pick effect type to create:");
	set_fx_hudelement("1. One Shot fx");
	set_fx_hudelement("2. Looping fx");
	set_fx_hudelement("3. Looping sound");
	set_fx_hudelement("4. Exploder");
	set_fx_hudelement("5. One Shot Sound");
	set_fx_hudelement("(c) Cancel");
	set_fx_hudelement("(x) Exit");
}

//Function Number: 31
show_help()
{
	clear_fx_hudelements();
	set_fx_hudelement("Help:");
	set_fx_hudelement("Insert          Insert entity");
	set_fx_hudelement("L               Drop selected entities to the ground");
	set_fx_hudelement("A               Add option to the selected entities");
	set_fx_hudelement("P               Reset the rotation of the selected entities");
	set_fx_hudelement("V               Copy the angles from the most recently selected fx onto all selected fx.");
	set_fx_hudelement("Delete          Kill the selected entities");
	set_fx_hudelement("ESCAPE          Cancel out of option-modify-mode, must have console open");
	set_fx_hudelement("Ctrl-C          Copy");
	set_fx_hudelement("Ctrl-V          Paste");
	set_fx_hudelement("F2              Toggle createfx dot and text drawing");
	set_fx_hudelement("F5              SAVES your work");
	set_fx_hudelement("Dpad            Move selected entitise on X/Y or rotate pitch/yaw");
	set_fx_hudelement("A button        Toggle the selection of the current entity");
	set_fx_hudelement("X button        Toggle entity rotation mode");
	set_fx_hudelement("Y button        Move selected entites up or rotate roll");
	set_fx_hudelement("B button        Move selected entites down or rotate roll");
	set_fx_hudelement("R Shoulder      Move selected entities to the cursor");
	set_fx_hudelement("L Shoulder      Hold to select multiple entites");
	set_fx_hudelement("L JoyClick      Copy");
	set_fx_hudelement("R JoyClick      Paste");
	set_fx_hudelement("N               UFO");
	set_fx_hudelement("T               Toggle Timescale FAST");
	set_fx_hudelement("Y               Toggle Timescale SLOW");
	set_fx_hudelement("[               Toggle FX Visibility");
	set_fx_hudelement("]               Toggle ShowTris");
	set_fx_hudelement("F11             Toggle FX Profile");
}

//Function Number: 32
select_last_entity()
{
	select_entity(level.createfxent.size - 1,level.createfxent[level.createfxent.size - 1]);
}

//Function Number: 33
select_all_exploders_of_currently_selected(param_00)
{
	var_01 = [];
	foreach(var_03 in level.var_81F)
	{
		if(!isdefined(var_03.v[param_00]))
		{
			continue;
		}

		var_04 = var_03.v[param_00];
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

			if(!isdefined(var_03.v[param_00]))
			{
				continue;
			}

			if(var_03.v[param_00] != var_04)
			{
				continue;
			}

			select_entity(var_09,var_03);
		}
	}

	update_selected_entities();
}

//Function Number: 34
copy_ents()
{
	if(level.var_81F.size <= 0)
	{
		return;
	}

	var_00 = [];
	for(var_01 = 0;var_01 < level.var_81F.size;var_01++)
	{
		var_02 = level.var_81F[var_01];
		var_03 = spawnstruct();
		var_03.v = var_02.v;
		var_03 post_entity_creation_function();
		var_00[var_00.size] = var_03;
	}

	level.var_87D = var_00;
}

//Function Number: 35
post_entity_creation_function()
{
	self.var_87E = 0;
	self.var_845 = 1;
}

//Function Number: 36
paste_ents()
{
	if(!isdefined(level.var_87D))
	{
		return;
	}

	clear_entity_selection();
	for(var_00 = 0;var_00 < level.var_87D.size;var_00++)
	{
		add_and_select_entity(level.var_87D[var_00]);
	}

	move_selection_to_cursor();
	update_selected_entities();
	level.var_87D = [];
	copy_ents();
}

//Function Number: 37
add_and_select_entity(param_00)
{
	level.createfxent[level.createfxent.size] = param_00;
	select_last_entity();
}

//Function Number: 38
get_center_of_array(param_00)
{
	var_01 = (0,0,0);
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_01 = (var_01[0] + param_00[var_02].v["origin"][0],var_01[1] + param_00[var_02].v["origin"][1],var_01[2] + param_00[var_02].v["origin"][2]);
	}

	return (var_01[0] / param_00.size,var_01[1] / param_00.size,var_01[2] / param_00.size);
}

//Function Number: 39
ent_draw_axis()
{
	self endon("death");
	for(;;)
	{
		draw_axis();
		wait 0.05;
	}
}

//Function Number: 40
rotation_is_occuring()
{
	if(level.var_85C != 0)
	{
		return 1;
	}

	if(level.var_85B != 0)
	{
		return 1;
	}

	return level.var_85D != 0;
}

//Function Number: 41
print_fx_options(param_00,param_01,param_02,param_03)
{
	for(var_04 = 0;var_04 < level.var_82A.size;var_04++)
	{
		var_05 = level.var_82A[var_04];
		var_06 = var_05["name"];
		if(!isdefined(param_00.v[var_06]))
		{
			continue;
		}

		if(!common_scripts\_createfxmenu::mask(var_05["mask"],param_00.v["type"]))
		{
			continue;
		}

		if(!level.mp_createfx)
		{
			if(common_scripts\_createfxmenu::mask("fx",param_00.v["type"]) && var_06 == "fxid")
			{
				continue;
			}

			if(param_00.v["type"] == "exploder" && var_06 == "exploder")
			{
				continue;
			}

			var_07 = param_00.v["type"] + "/" + var_06;
			if(isdefined(level.var_885[var_07]) && level.var_885[var_07] == param_00.v[var_06])
			{
				continue;
			}
		}

		if(var_05["type"] == "string")
		{
			var_08 = param_00.v[var_06] + "";
			if(var_08 == "nil")
			{
				continue;
			}

			cfxprintln(param_02,param_01 + "ent.v[ \" + var_06 + "\" ] = \" + param_00.v[var_06] + "\";");
			continue;
		}

		cfxprintln(param_02,param_01 + "ent.v[ \" + var_06 + "\" ] = " + param_00.v[var_06] + ";");
	}
}

//Function Number: 42
entity_highlight_disable()
{
	self notify("highlight change");
	self endon("highlight change");
	for(;;)
	{
		self.var_87E = self.var_87E * 0.85;
		self.var_87E = self.var_87E - 0.05;
		if(self.var_87E < 0)
		{
			break;
		}

		wait 0.05;
	}

	self.var_87E = 0;
}

//Function Number: 43
entity_highlight_enable()
{
	self notify("highlight change");
	self endon("highlight change");
	for(;;)
	{
		self.var_87E = self.var_87E + 0.05;
		self.var_87E = self.var_87E * 1.25;
		if(self.var_87E > 1)
		{
			break;
		}

		wait 0.05;
	}

	self.var_87E = 1;
}

//Function Number: 44
toggle_createfx_drawing()
{
	level.var_860 = !level.var_860;
}

//Function Number: 45
manipulate_createfx_ents(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!level.var_860)
	{
		return;
	}

	for(var_06 = 0;var_06 < level.createfxent.size;var_06++)
	{
		var_07 = level.createfxent[var_06];
		if(!var_07.var_845)
		{
			continue;
		}

		var_08 = getdvarfloat("createfx_scaleid");
		if(isdefined(param_00) && var_07 == param_00)
		{
			if(!common_scripts\_createfxmenu::entities_are_selected())
			{
				common_scripts\_createfxmenu::display_fx_info(var_07);
			}

			if(param_01)
			{
				var_09 = index_is_selected(var_06);
				level.var_864 = !var_09;
				if(!param_03)
				{
					var_0A = level.var_81F.size;
					clear_entity_selection();
					if(var_09 && var_0A == 1)
					{
						select_entity(var_06,var_07);
					}
				}

				toggle_entity_selection(var_06,var_07);
			}
			else if(param_02)
			{
				if(param_03)
				{
					if(level.var_864)
					{
						select_entity(var_06,var_07);
					}

					if(!level.var_864)
					{
						deselect_entity(var_06,var_07);
					}
				}
			}

			var_0B = "highlighted";
			if(index_is_selected(var_06))
			{
				var_0B = "selected";
			}

			if(var_07.var_87E > 0)
			{
				var_0C = param_05 * var_07.v["fxid"].size * -2.93 * var_08;
			}

			continue;
		}

		var_0B = "default";
		if(index_is_selected(var_06))
		{
			var_0B = "selected";
		}

		if(var_07.var_87E > 0)
		{
			var_0C = param_05 * var_07.v["fxid"].size * -2.93;
		}
	}
}

//Function Number: 46
reset_fx_hud_colors()
{
	level.var_832 = 0;
	level.var_837 = undefined;
	show_hud_elements();
}

//Function Number: 47
show_hud_elements()
{
	for(var_00 = 0;var_00 < level.var_83E;var_00++)
	{
		level.var_833[var_00][0].color = (1,1,1);
	}
}

//Function Number: 48
button_is_held(param_00,param_01)
{
	if(isdefined(param_01))
	{
		if(isdefined(level.var_861[param_01]))
		{
			return 1;
		}
	}

	return isdefined(level.var_861[param_00]);
}

//Function Number: 49
button_is_clicked(param_00,param_01)
{
	if(isdefined(param_01))
	{
		if(isdefined(level.var_866[param_01]))
		{
			return 1;
		}
	}

	return isdefined(level.var_866[param_00]);
}

//Function Number: 50
toggle_entity_selection(param_00,param_01)
{
	if(isdefined(level.var_85E[param_00]))
	{
		deselect_entity(param_00,param_01);
		return;
	}

	select_entity(param_00,param_01);
}

//Function Number: 51
select_entity(param_00,param_01)
{
	if(isdefined(level.var_85E[param_00]))
	{
		return;
	}

	reset_fx_hud_colors();
	level notify("new_ent_selection");
	param_01 thread entity_highlight_enable();
	level.var_85E[param_00] = 1;
	level.var_81F[level.var_81F.size] = param_01;
}

//Function Number: 52
ent_is_highlighted(param_00)
{
	if(!isdefined(level.var_868))
	{
		return 0;
	}

	return param_00 == level.var_868;
}

//Function Number: 53
deselect_entity(param_00,param_01)
{
	if(!isdefined(level.var_85E[param_00]))
	{
		return;
	}

	reset_fx_hud_colors();
	level notify("new_ent_selection");
	level.var_85E[param_00] = undefined;
	if(!ent_is_highlighted(param_01))
	{
		param_01 thread entity_highlight_disable();
	}

	var_02 = [];
	for(var_03 = 0;var_03 < level.var_81F.size;var_03++)
	{
		if(level.var_81F[var_03] != param_01)
		{
			var_02[var_02.size] = level.var_81F[var_03];
		}
	}

	level.var_81F = var_02;
}

//Function Number: 54
index_is_selected(param_00)
{
	return isdefined(level.var_85E[param_00]);
}

//Function Number: 55
ent_is_selected(param_00)
{
	for(var_01 = 0;var_01 < level.var_81F.size;var_01++)
	{
		if(level.var_81F[var_01] == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 56
clear_entity_selection()
{
	for(var_00 = 0;var_00 < level.var_81F.size;var_00++)
	{
		if(!ent_is_highlighted(level.var_81F[var_00]))
		{
			level.var_81F[var_00] thread entity_highlight_disable();
		}
	}

	level.var_85E = [];
	level.var_81F = [];
}

//Function Number: 57
draw_axis()
{
	var_00 = 25 * getdvarfloat("createfx_scaleid");
	var_01 = anglestoforward(self.v["angles"]);
	var_01 = var_01 * var_00;
	var_02 = anglestoright(self.v["angles"]);
	var_02 = var_02 * var_00;
	var_03 = anglestoup(self.v["angles"]);
	var_03 = var_03 * var_00;
}

//Function Number: 58
clear_fx_hudelements()
{
	level.var_857 clearalltextafterhudelem();
	for(var_00 = 0;var_00 < level.var_83E;var_00++)
	{
		for(var_01 = 0;var_01 < 1;var_01++)
		{
			level.var_833[var_00][var_01] settext("");
		}
	}

	level.var_893 = 0;
}

//Function Number: 59
set_fx_hudelement(param_00)
{
	for(var_01 = 0;var_01 < 1;var_01++)
	{
		level.var_833[level.var_893][var_01] settext(param_00);
	}

	level.var_893++;
}

//Function Number: 60
createfx_centerprint(param_00)
{
	thread createfx_centerprint_thread(param_00);
}

//Function Number: 61
createfx_centerprint_thread(param_00)
{
	level notify("new_createfx_centerprint");
	level endon("new_createfx_centerprint");
	for(var_01 = 0;var_01 < 5;var_01++)
	{
		level.createfx_centerprint[var_01] settext(param_00);
	}

	wait 4.5;
	for(var_01 = 0;var_01 < 5;var_01++)
	{
		level.createfx_centerprint[var_01] settext("");
	}
}

//Function Number: 62
buttondown(param_00,param_01)
{
	return buttonpressed_internal(param_00) || buttonpressed_internal(param_01);
}

//Function Number: 63
buttonpressed_internal(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(kb_locked(param_00))
	{
		return 0;
	}

	return level.player buttonpressed(param_00);
}

//Function Number: 64
get_selected_move_vector()
{
	var_00 = level.player getplayerangles()[1];
	var_01 = (0,var_00,0);
	var_02 = anglestoright(var_01);
	var_03 = anglestoforward(var_01);
	var_04 = anglestoup(var_01);
	var_05 = 0;
	var_06 = 1;
	if(buttondown("kp_uparrow","DPAD_UP"))
	{
		if(level.var_859 < 0)
		{
			level.var_859 = 0;
		}

		level.var_859 = level.var_859 + var_06;
	}
	else if(buttondown("kp_downarrow","DPAD_DOWN"))
	{
		if(level.var_859 > 0)
		{
			level.var_859 = 0;
		}

		level.var_859 = level.var_859 - var_06;
	}
	else
	{
		level.var_859 = 0;
	}

	if(buttondown("kp_rightarrow","DPAD_RIGHT"))
	{
		if(level.var_85A < 0)
		{
			level.var_85A = 0;
		}

		level.var_85A = level.var_85A + var_06;
	}
	else if(buttondown("kp_leftarrow","DPAD_LEFT"))
	{
		if(level.var_85A > 0)
		{
			level.var_85A = 0;
		}

		level.var_85A = level.var_85A - var_06;
	}
	else
	{
		level.var_85A = 0;
	}

	if(buttondown("BUTTON_Y"))
	{
		if(level.var_858 < 0)
		{
			level.var_858 = 0;
		}

		level.var_858 = level.var_858 + var_06;
	}
	else if(buttondown("BUTTON_B"))
	{
		if(level.var_858 > 0)
		{
			level.var_858 = 0;
		}

		level.var_858 = level.var_858 - var_06;
	}
	else
	{
		level.var_858 = 0;
	}

	var_07 = (0,0,0);
	var_07 = var_07 + var_03 * level.var_859;
	var_07 = var_07 + var_02 * level.var_85A;
	var_07 = var_07 + var_04 * level.var_858;
	return var_07;
}

//Function Number: 65
process_button_held_and_clicked()
{
	add_button("mouse1");
	add_kb_button("shift");
	add_kb_button("ctrl");
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
	add_kb_button("escape");
	add_kb_button("a");
	add_kb_button("g");
	add_button("F1");
	add_button("F5");
	add_button("F2");
	add_kb_button("c");
	add_kb_button("h");
	add_kb_button("i");
	add_kb_button("k");
	add_kb_button("l");
	add_kb_button("m");
	add_kb_button("p");
	add_kb_button("x");
	add_button("del");
	add_kb_button("end");
	add_kb_button("tab");
	add_kb_button("ins");
	add_kb_button("add");
	add_kb_button("space");
	add_kb_button("enter");
	add_kb_button("v");
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
}

//Function Number: 66
locked(param_00)
{
	if(isdefined(level.var_85F[param_00]))
	{
		return 0;
	}

	return kb_locked(param_00);
}

//Function Number: 67
kb_locked(param_00)
{
	return level.var_832 && isdefined(level.var_867[param_00]);
}

//Function Number: 68
add_button(param_00)
{
	if(locked(param_00))
	{
		return;
	}

	if(!isdefined(level.var_861[param_00]))
	{
		if(level.player buttonpressed(param_00))
		{
			level.var_861[param_00] = 1;
			level.var_866[param_00] = 1;
			return;
		}

		return;
	}

	if(!level.player buttonpressed(param_00))
	{
		level.var_861[param_00] = undefined;
	}
}

//Function Number: 69
add_kb_button(param_00)
{
	level.var_867[param_00] = 1;
	add_button(param_00);
}

//Function Number: 70
set_anglemod_move_vector()
{
	var_00 = 2;
	if(buttondown("kp_uparrow","DPAD_UP"))
	{
		if(level.var_85B < 0)
		{
			level.var_85B = 0;
		}

		level.var_85B = level.var_85B + var_00;
	}
	else if(buttondown("kp_downarrow","DPAD_DOWN"))
	{
		if(level.var_85B > 0)
		{
			level.var_85B = 0;
		}

		level.var_85B = level.var_85B - var_00;
	}
	else
	{
		level.var_85B = 0;
	}

	if(buttondown("kp_leftarrow","DPAD_LEFT"))
	{
		if(level.var_85D < 0)
		{
			level.var_85D = 0;
		}

		level.var_85D = level.var_85D + var_00;
	}
	else if(buttondown("kp_rightarrow","DPAD_RIGHT"))
	{
		if(level.var_85D > 0)
		{
			level.var_85D = 0;
		}

		level.var_85D = level.var_85D - var_00;
	}
	else
	{
		level.var_85D = 0;
	}

	if(buttondown("BUTTON_Y"))
	{
		if(level.var_85C < 0)
		{
			level.var_85C = 0;
		}

		level.var_85C = level.var_85C + var_00;
		return;
	}

	if(buttondown("BUTTON_B"))
	{
		if(level.var_85C > 0)
		{
			level.var_85C = 0;
		}

		level.var_85C = level.var_85C - var_00;
		return;
	}

	level.var_85C = 0;
}

//Function Number: 71
cfxprintlnstart()
{
	common_scripts\utility::fileprint_launcher_start_file();
}

//Function Number: 72
cfxprintln(param_00,param_01)
{
	common_scripts\utility::fileprint_launcher(param_01);
	if(param_00 == -1)
	{
	}
}

//Function Number: 73
cfxprintlnend(param_00,param_01,param_02)
{
	var_03 = 1;
	if(param_02 != "" || param_01)
	{
		var_03 = 0;
	}

	var_04 = common_scripts\utility::get_template_level() + param_02 + "_fx.gsc";
	if(param_01)
	{
		var_04 = "backup.gsc";
	}

	common_scripts\utility::fileprint_launcher_end_file("/share/raw/maps/createfx/" + var_04,var_03);
}

//Function Number: 74
update_selected_entities()
{
	for(var_00 = 0;var_00 < level.var_81F.size;var_00++)
	{
		var_01 = level.var_81F[var_00];
		var_01 [[ level.func_updatefx ]]();
	}
}

//Function Number: 75
hack_start(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "painter_mp";
	}

	precachemenu(param_00);
	wait 0.05;
	if(param_00 == "painter_mp")
	{
		return;
	}

	level.player openpopupmenu(param_00);
	level.player closepopupmenu(param_00);
}

//Function Number: 76
get_player()
{
	return getentarray("player","classname")[0];
}

//Function Number: 77
createfx_orgranize_array()
{
	var_00 = [];
	var_01 = [];
	foreach(var_04, var_03 in var_7B)
	{
		var_01[var_04] = [];
	}

	foreach(var_06 in level.createfxent)
	{
		var_07 = 0;
		foreach(var_04, var_09 in var_7B)
		{
			if(var_06.v["type"] != var_09)
			{
				continue;
			}

			var_07 = 1;
			var_01[var_04][var_01[var_04].size] = var_06;
			break;
		}
	}

	var_0B = [];
	for(var_0C = 0;var_0C < var_7B.size;var_0C++ = var_7B[4])
	{
		foreach(var_06 in var_01[var_0C])
		{
			var_0B[var_0B.size] = var_06;
		}
	}

	level.createfxent = var_0B;
}

//Function Number: 78
stop_fx_looper()
{
	if(isdefined(self.looper))
	{
		self.looper delete();
	}

	stop_loopsound();
}

//Function Number: 79
stop_loopsound()
{
	self notify("stop_loop");
}

//Function Number: 80
func_get_level_fx()
{
	if(!isdefined(level.var_8AA))
	{
		var_00 = getarraykeys(level._effect);
	}
	else
	{
		var_00 = getarraykeys(level._effect);
		if(var_00.size == level.var_8AA.size)
		{
			return level.var_8AA;
		}
	}

	var_00 = common_scripts\utility::alphabetize(var_00);
	level.var_8AA = var_00;
	return var_00;
}

//Function Number: 81
restart_fx_looper()
{
	stop_fx_looper();
	set_forward_and_up_vectors();
	if(self.v["type"] == "loopfx")
	{
		common_scripts\_fx::create_looper();
	}

	if(self.v["type"] == "oneshotfx")
	{
		common_scripts\_fx::create_triggerfx();
	}

	if(self.v["type"] == "soundfx")
	{
		common_scripts\_fx::create_loopsound();
	}

	if(self.v["type"] == "soundfx_interval")
	{
		common_scripts\_fx::create_interval_sound();
	}
}

//Function Number: 82
process_fx_rotater()
{
	if(level.var_863)
	{
		return;
	}

	set_anglemod_move_vector();
	if(!rotation_is_occuring())
	{
		return;
	}

	level.var_863 = 1;
	if(level.var_81F.size > 1)
	{
		var_00 = get_center_of_array(level.var_81F);
		var_01 = spawn("script_origin",var_00);
		var_01.v["angles"] = level.var_81F[0].v["angles"];
		var_01.v["origin"] = var_00;
		var_02 = [];
		for(var_03 = 0;var_03 < level.var_81F.size;var_03++)
		{
			var_02[var_03] = spawn("script_origin",level.var_81F[var_03].v["origin"]);
			var_02[var_03].angles = level.var_81F[var_03].v["angles"];
			var_02[var_03] linkto(var_01);
		}

		rotate_over_time(var_01,var_02);
		var_01 delete();
		for(var_03 = 0;var_03 < var_02.size;var_03++)
		{
			var_02[var_03] delete();
		}
	}
	else if(level.var_81F.size == 1)
	{
		var_04 = level.var_81F[0];
		var_02 = spawn("script_origin",(0,0,0));
		var_02.angles = var_04.v["angles"];
		if(level.var_85B != 0)
		{
			var_02 addpitch(level.var_85B);
		}
		else if(level.var_85D != 0)
		{
			var_02 addyaw(level.var_85D);
		}
		else
		{
			var_02 addroll(level.var_85C);
		}

		var_04.v["angles"] = var_02.angles;
		var_02 delete();
		wait 0.05;
	}

	level.var_863 = 0;
}

//Function Number: 83
generate_fx_log(param_00)
{
}