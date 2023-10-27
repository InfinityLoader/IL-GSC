/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_createfx.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 98
 * Decompile Time: 520 ms
 * Timestamp: 10/27/2023 3:03:41 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_createfxmenu;
#include maps/mp/_createfxundo;
#include maps/mp/_fx;
#include maps/mp/_script_gen;
#include maps/mp/_utility;

//Function Number: 1
createfx()
{
/#
	println("^2Running CreateFX 2.0");
#/
	if(ismp())
	{
		init_mp_paths();
		level.timelimitoverride = 1;
	}
	else
	{
		init_sp_paths();
	}

	precachemodel("fx_axis_createfx");
	precacheshader("black");
	if(GetDvar(#"D0C4376B") == "")
	{
		setdvar("createfx_scaleid","0.5");
	}

	if(GetDvar(#"5A7DE640") == "")
	{
		setdvar("createfx_print_frames","3");
	}

	if(GetDvar(#"94DE57D9") == "")
	{
		setdvar("createfx_drawaxis","1");
	}

	if(GetDvar(#"74012625") == "")
	{
		setdvar("createfx_drawaxis_range","2000");
	}

	if(GetDvar(#"6AC13DAC") == "")
	{
		setdvar("createfx_autosave_time","300");
	}

	if(GetDvar(#"72501C7") == "")
	{
		setdvar("createfx_oneshot_min_delay","-100");
	}

	if(GetDvar(#"A6DCBA49") == "")
	{
		setdvar("createfx_oneshot_max_delay","-15");
	}

	flag_init("createfx_saving");
	if(!(IsDefined(level.createfx)))
	{
		level.createfx = [];
	}

	if(!(IsDefined(level.cfx_uniqueid)))
	{
		level.cfx_uniqueid = 0;
	}

	level.cfx_last_action = "none";
	if(!(ismp()))
	{
		level thread [[ level.cfx_func_run_gump_func ]]();
	}

	if(IsDefined(level.createfx_callback_thread))
	{
		level thread [[ level.createfx_callback_thread ]]();
	}

	if(ismp())
	{
		level.callbackplayerdisconnect = ::empty;
		level.callbackplayerdamage = ::damage_void;
		level.callbackplayerkilled = ::empty;
		level.callbackplayerconnect = ::callback_playerconnect;
		while(!(IsDefined(level.player)))
		{
			wait(0.05);
		}

		thread createfxdelay();
	}

	level.is_camera_on = 0;
	thread createfxlogic();
	level waittill("eternity");
}

//Function Number: 2
fx_init()
{
	if(ismp())
	{
		init_client_mp_variables();
	}
	else
	{
		init_client_sp_variables();
	}

	level.exploderfunction = level.cfx_exploder_before;
	waittillframeend;
	waittillframeend;
	level.exploderfunction = level.cfx_exploder_after;
	level.non_fx_ents = 0;
	if(level.createfx_enabled)
	{
		triggers = getentarray("trigger_multiple","classname");
		for(i = 0;i < triggers.size;i++)
		{
			triggers[i] delete();
		}

		triggers = getentarray("trigger_once","classname");
		for(i = 0;i < triggers.size;i++)
		{
			triggers[i] delete();
		}

		triggers = getentarray("trigger_box","classname");
		for(i = 0;i < triggers.size;i++)
		{
			triggers[i] delete();
		}

		triggers = getentarray("trigger_radius","classname");
		for(i = 0;i < triggers.size;i++)
		{
			triggers[i] delete();
		}

		triggers = getentarray("trigger_lookat","classname");
		for(i = 0;i < triggers.size;i++)
		{
			triggers[i] delete();
		}

		triggers = getentarray("trigger_damage","classname");
		for(i = 0;i < triggers.size;i++)
		{
			triggers[i] delete();
		}

		sm = getentarray("spawn_manager","classname");
		for(i = 0;i < sm.size;i++)
		{
			sm[i] delete();
		}

		delete_spawns();
		if(!(ismp()))
		{
			delete_arrays_in_sp();
/#
			println("We\'re not in MP!");
#/
		}
	}

	for(i = 0;i < level.createfxent.size;i++)
	{
		ent = level.createfxent[i];
		ent set_forward_and_up_vectors();
		if(level.clientscripts)
		{
			if(!(level.createfx_enabled))
			{
			}
			else
			{
				if(IsDefined(ent.model))
				{
					level.non_fx_ents++;
				}

				if(ent.v["type"] == "loopfx")
				{
					ent thread [[ level.cfx_func_loopfx ]]();
				}

				if(ent.v["type"] == "oneshotfx")
				{
					ent thread [[ level.cfx_func_oneshotfx ]]();
				}

				if(ent.v["type"] == "soundfx")
				{
					ent thread [[ level.cfx_func_soundfx ]]();
				}
			}
		}
	}
}

//Function Number: 3
add_effect(name,effect)
{
	if(!(IsDefined(level._effect)))
	{
		level._effect = [];
	}

	level._effect[name] = loadfx(effect);
}

//Function Number: 4
createeffect(type,fxid)
{
	ent = undefined;
	if(!(IsDefined(level.createfx_enabled)))
	{
		level.createfx_enabled = GetDvar(#"134D5297") != "";
	}

	if(!(IsDefined(level.createfxent)))
	{
		level.createfxent = [];
	}

	if(level.createfx_enabled)
	{
		if(!(IsDefined(level.cfx_uniqueid)))
		{
			level.cfx_uniqueid = 0;
		}

		ent = spawnstruct();
		ent.uniqueid = level.cfx_uniqueid;
		level.cfx_uniqueid++;
	}
	else if(type == "exploder")
	{
		ent = spawnstruct();
	}
	else
	{
		if(!(IsDefined(level._fake_createfx_struct)))
		{
			level._fake_createfx_struct = spawnstruct();
		}

		ent = level._fake_createfx_struct;
	}

	level.createfxent[level.createfxent.size] = ent;
	ent.v = [];
	ent.v["type"] = type;
	ent.v["fxid"] = fxid;
	ent.v["angles"] = (0,0,0);
	ent.v["origin"] = (0,0,0);
	ent.drawn = 1;
	return ent;
}

//Function Number: 5
createloopsound()
{
	ent = spawnstruct();
	if(!(IsDefined(level.createfxent)))
	{
		level.createfxent = [];
	}

	level.createfxent[level.createfxent.size] = ent;
	ent.v = [];
	ent.v["type"] = "soundfx";
	ent.v["fxid"] = "No FX";
	ent.v["soundalias"] = "nil";
	ent.v["angles"] = (0,0,0);
	ent.v["origin"] = (0,0,0);
	ent.drawn = 1;
	return ent;
}

//Function Number: 6
set_forward_and_up_vectors()
{
	self.v["up"] = AnglesToUp(self.v["angles"]);
	self.v["forward"] = AnglesToForward(self.v["angles"]);
}

//Function Number: 7
createfxlogic()
{
	waittillframeend;
	menu_init();
	if(!(ismp()))
	{
		players = get_players();
		if(!IsDefined(players) || players.size == 0)
		{
			level waittill("first_player_ready");
		}
	}

/#
	adddebugcommand("noclip");
#/
	if(!(IsDefined(level._effect)))
	{
		level._effect = [];
	}

	if(GetDvar(#"C888BAB4") == "")
	{
		setdvar("createfx_map",level.script);
	}
	else if(GetDvar(#"C888BAB4") == level.script)
	{
		if(!(ismp()))
		{
			playerpos = [];
			playerpos[0] = GetDvarInt(#"274F266C");
			playerpos[1] = GetDvarInt(#"274F266D");
			playerpos[2] = GetDvarInt(#"274F266E");
			player = get_players()[0];
			player setorigin((playerpos[0],playerpos[1],playerpos[2]));
		}
	}

/#
	filename = level.cfx_server_scriptdata + level.script + "_fx.gsc";
	file = openfile(filename,"append");
	level.write_error = "";
	level.write_error = filename;
	closefile(file);
Stack-Empty ? Stack-Empty : file == -1
#/
	level.createfxhudelements = [];
	level.createfx_hudelements = 100;
	stroffsetx = [];
	stroffsety = [];
	stroffsetx[0] = 0;
	stroffsety[0] = 0;
	stroffsetx[1] = 1;
	stroffsety[1] = 1;
	stroffsetx[2] = -2;
	stroffsety[2] = 1;
	setdvar("fx","nil");
	crosshair = newdebughudelem();
	crosshair.location = 0;
	crosshair.alignx = "center";
	crosshair.aligny = "middle";
	crosshair.foreground = 1;
	crosshair.fontscale = 2;
	crosshair.sort = 20;
	crosshair.alpha = 1;
	crosshair.x = 320;
	crosshair.y = 233;
	crosshair settext(".");
	center_text_init();
	level.cleartextmarker = newdebughudelem();
	level.cleartextmarker.alpha = 0;
	level.cleartextmarker settext("marker");
	for(i = 0;i < level.createfx_hudelements;i++)
	{
		newstrarray = [];
		for(p = 0;p < 2;p++)
		{
			newstr = newhudelem();
			newstr.alignx = "left";
			newstr.location = 0;
			newstr.foreground = 1;
			newstr.fontscale = 1.1;
			newstr.sort = 20 - p;
			newstr.alpha = 1;
			newstr.x = 0 + stroffsetx[p];
			newstr.y = 60 + stroffsety[p] + i * 15;
			if(p > 0)
			{
				newstr.color = (0,0,0);
			}

			newstrarray[newstrarray.size] = newstr;
		}

		level.createfxhudelements[i] = newstrarray;
	}

	level.selectedmove_up = 0;
	level.selectedmove_forward = 0;
	level.selectedmove_right = 0;
	level.selectedrotate_pitch = 0;
	level.selectedrotate_roll = 0;
	level.selectedrotate_yaw = 0;
	level.selected_fx = [];
	level.selected_fx_ents = [];
	level.createfx_lockedlist = [];
	level.createfx_lockedlist["escape"] = 1;
	level.createfx_lockedlist["BUTTON_LSHLDR"] = 1;
	level.createfx_lockedlist["BUTTON_RSHLDR"] = 1;
	level.createfx_lockedlist["mouse1"] = 1;
	level.createfx_lockedlist["ctrl"] = 1;
	level.createfx_draw_enabled = 1;
	level.buttonisheld = [];
	axismode = 0;
	colors = [];
	colors["loopfx"]["selected"] = (1,1,0.2);
	colors["loopfx"]["highlighted"] = (0.4,0.95,1);
	colors["loopfx"]["default"] = (0.3,0.5,1);
	colors["oneshotfx"]["selected"] = (1,1,0.2);
	colors["oneshotfx"]["highlighted"] = (0.33,0.97,1);
	colors["oneshotfx"]["default"] = (0.1,0.73,0.73);
	colors["exploder"]["selected"] = (1,1,0.2);
	colors["exploder"]["highlighted"] = (1,0.1,0.1);
	colors["exploder"]["default"] = (1,0.1,0.1);
	colors["rainfx"]["selected"] = (1,1,0.2);
	colors["rainfx"]["highlighted"] = (0.95,0.4,0.95);
	colors["rainfx"]["default"] = (0.78,0,0.73);
	colors["soundfx"]["selected"] = (1,1,0.2);
	colors["soundfx"]["highlighted"] = (0.5,1,0.75);
	colors["soundfx"]["default"] = (0.2,0.9,0.2);
	lasthighlightedent = undefined;
	level.fx_rotating = 0;
	setmenu("none");
	level.createfx_selecting = 0;
	level.createfx_last_player_origin = (0,0,0);
	level.createfx_last_player_forward = (0,0,0);
	level.createfx_last_view_change_test = 0;
	player = get_players()[0];
	black = newdebughudelem();
	black.x = -120;
	black.y = 200;
	black.foreground = 0;
	black setshader("black",250,160);
	black.alpha = 0;
	level.createfx_inputlocked = 0;
	help_on_last_frame = 0;
	for(i = 0;i < level.createfxent.size;i++)
	{
		ent = level.createfxent[i];
		ent post_entity_creation_function();
	}

	thread draw_distance();
	lastselectentity = undefined;
	thread createfx_autosave();
	if(!(ismp()))
	{
		make_sp_player_invulnerable(player);
	}

	for(;;)
	{
		player = get_players()[0];
		changedselectedents = 0;
		right = AnglesToRight(player getplayerangles());
		forward = AnglesToForward(player getplayerangles());
		up = AnglesToUp(player getplayerangles());
		dot = 0.85;
		placeent_vector = VectorScale(forward);
		level.createfxcursor = bullettrace(player geteye(),player geteye() + placeent_vector,0,undefined);
		highlightedent = undefined;
		level.buttonclick = [];
		level.button_is_kb = [];
		process_button_held_and_clicked();
		ctrlheld = button_is_held("ctrl","BUTTON_LSHLDR");
		shiftheld = button_is_held("shift");
		functionheld = button_is_held("f");
		leftclick = button_is_clicked("mouse1","BUTTON_A");
		leftheld = button_is_held("mouse1","BUTTON_A");
		create_fx_menu();
		if(button_is_clicked("BUTTON_X") || shiftheld && button_is_clicked("x"))
		{
			axismode = !axismode;
		}

		if(button_is_clicked("F2") || functionheld && button_is_clicked("2"))
		{
			toggle_createfx_drawing();
		}

		if(button_is_clicked("F3") || functionheld && button_is_clicked("3"))
		{
			print_ambient_fx_inventory();
		}

		if(button_is_clicked("F5") || functionheld && button_is_clicked("5"))
		{
			createfx_save();
		}

		if(button_is_clicked("ins","i"))
		{
			insert_effect();
		}

		if(button_is_clicked("c"))
		{
			if(level.is_camera_on == 0)
			{
/#
				adddebugcommand("noclip");
#/
				level thread handle_camera();
				level.is_camera_on = 1;
			}
			else if(level.is_camera_on == 1)
			{
/#
				adddebugcommand("noclip");
#/
				level notify("new_camera",750);
				level.is_camera_on = 0;
				axismode = 0;
			}
		}

		if(button_is_held("BUTTON_RTRIG") && level.is_camera_on)
		{
			axismode = 1;
		}
		else if(!button_is_held("BUTTON_RTRIG") && level.is_camera_on)
		{
			axismode = 0;
		}

		if(button_is_clicked("del") || !shiftheld && button_is_clicked("d"))
		{
			delete_pressed();
		}

		if(button_is_clicked("end") || shiftheld && button_is_clicked("d"))
		{
			drop_selection_to_ground();
			changedselectedents = 1;
		}

		if(button_is_clicked("s"))
		{
			setmenu("select_by_property");
			wait(0.05);
		}

		if(IsDefined(level.cfx_selected_prop))
		{
			if(ctrlheld)
			{
				select_ents_by_property(level.cfx_selected_prop,1);
			}
			else
			{
				select_ents_by_property(level.cfx_selected_prop);
			}

			level.cfx_selected_prop = undefined;
		}

		if(button_is_clicked("j"))
		{
			setmenu("jump_to_effect");
			draw_effects_list("Select effect to jump to:");
		}

		if(button_is_clicked("escape"))
		{
			clear_settable_fx();
		}

		if(button_is_clicked("space") && !shiftheld)
		{
			set_off_exploders();
		}

		if(button_is_clicked("space") && shiftheld)
		{
			turn_off_exploders();
		}

		if(button_is_clicked("tab","BUTTON_RSHLDR"))
		{
			move_selection_to_cursor();
			changedselectedents = 1;
		}

		if(button_is_clicked("z"))
		{
			if(shiftheld)
			{
			}
			else
			{
				undo();
			}
		}

		if(button_is_held("q","F1"))
		{
			help_on_last_frame = 1;
			show_help();
			wait(0.05);
			continue;
		}
		else if(help_on_last_frame == 1)
		{
			clear_fx_hudelements();
			help_on_last_frame = 0;
		}

		if(button_is_clicked("BUTTON_LSTICK") && !ctrlheld)
		{
			copy_ents();
		}

		if(button_is_clicked("BUTTON_RSTICK"))
		{
			if(ctrlheld)
			{
				paste_ents_onto_ents();
			}
			else
			{
				paste_ents();
			}
		}

		if(IsDefined(level.selected_fx_option_index))
		{
			menu_fx_option_set();
		}

		if(button_is_held("BUTTON_RTRIG") && button_is_held("BUTTON_LTRIG"))
		{
			move_player_around_map_fast();
			wait(0.25);
			continue;
		}

		if(menu("none"))
		{
			if(button_is_clicked("rightarrow"))
			{
				move_player_to_next_same_effect(1,lastselectentity);
			}
			else if(button_is_clicked("leftarrow"))
			{
				move_player_to_next_same_effect(0,lastselectentity);
			}
		}

		if(level.write_error != "")
		{
			level notify("write_error");
			thread write_error_msg(level.write_error);
			level.write_error = "";
		}

		highlightedent = level.fx_highlightedent;
		if(leftclick || GetTime() - level.createfx_last_view_change_test > 250)
		{
			if(leftclick || vector_changed(level.createfx_last_player_origin,player.origin) || dot_changed(level.createfx_last_player_forward,forward))
			{
				for(i = 0;i < level.createfxent.size;i++)
				{
					ent = level.createfxent[i];
					if(!(ent.drawn))
					{
					}
					else
					{
						difference = vectornormalize(player.origin - 55 + VectorScale((0,0,1)));
						newdot = vectordot(forward,difference);
						if(newdot < dot)
						{
						}
						else if(newdot == dot)
						{
							if(ent_is_selected(ent))
							{
							}
							else
							{
								dot = newdot;
								highlightedent = ent;
								highlightedent.last_fx_index = i;
							}
						}
					}
				}

				level.fx_highlightedent = highlightedent;
				level.createfx_last_player_origin = player.origin;
				level.createfx_last_player_forward = forward;
			}

			level.createfx_last_view_change_test = GetTime();
		}

		if(IsDefined(highlightedent))
		{
			if(IsDefined(lasthighlightedent))
			{
				if(lasthighlightedent != highlightedent)
				{
					if(!(ent_is_selected(lasthighlightedent)))
					{
						lasthighlightedent thread entity_highlight_disable();
					}

					if(!(ent_is_selected(highlightedent)))
					{
						highlightedent thread entity_highlight_enable();
					}
				}
			}
			else if(!(ent_is_selected(highlightedent)))
			{
				highlightedent thread entity_highlight_enable();
			}
		}

		manipulate_createfx_ents(highlightedent,leftclick,leftheld,ctrlheld,colors,right);
		if(axismode && level.selected_fx_ents.size > 0)
		{
			thread process_fx_rotater();
			if(button_is_clicked("enter","r"))
			{
				reset_axis_of_selected_ents();
			}

			if(button_is_clicked("v"))
			{
				copy_angles_of_selected_ents();
			}

			if(GetDvarInt(#"94DE57D9") == 1)
			{
				for(i = 0;i < level.selected_fx_ents.size;i++)
				{
					level.selected_fx_ents[i] draw_axis();
				}
			}

			if(level.selectedrotate_pitch != 0 || level.selectedrotate_yaw != 0 || level.selectedrotate_roll != 0)
			{
				changedselectedents = 1;
			}

			wait(0.05);
		}
		else
		{
			stop_drawing_axis_models();
			selectedmove_vector = get_selected_move_vector();
			if(distancesquared((0,0,0),selectedmove_vector) > 0)
			{
				changedselectedents = 1;
				if(level.cfx_last_action != "translate")
				{
					store_undo_state("edit",level.selected_fx_ents);
					level.cfx_last_action = "translate";
				}
			}

			for(i = 0;i < level.selected_fx_ents.size;i++)
			{
				ent = level.selected_fx_ents[i];
				if(IsDefined(ent.model))
				{
				}
				else
				{
					ent.v["origin"] = ent.v["origin"] + selectedmove_vector;
				}
			}

			wait(0.05);
		}

		if(changedselectedents)
		{
			update_selected_entities();
		}

		lasthighlightedent = highlightedent;
		if(last_selected_entity_has_changed(lastselectentity))
		{
			level.effect_list_offset = 0;
			clear_settable_fx();
			setmenu("none");
		}

		if(level.selected_fx_ents.size)
		{
			lastselectentity = level.selected_fx_ents[level.selected_fx_ents.size - 1];
			continue;
		}

		lastselectentity = undefined;
	}
}

//Function Number: 8
toggle_createfx_drawing()
{
	level.createfx_draw_enabled = !level.createfx_draw_enabled;
}

//Function Number: 9
manipulate_createfx_ents(highlightedent,leftclick,leftheld,ctrlheld,colors,right)
{
	if(!(level.createfx_draw_enabled))
	{
		clear_fx_hudelements();
		return;
	}

	scale = GetDvarFloat(#"D0C4376B");
	print_frames = GetDvarInt(#"5A7DE640");
	if(!(IsDefined(level.createfx_manipulate_offset)))
	{
		level.createfx_manipulate_offset = 0;
	}

	offset = level.createfx_manipulate_offset;
	level.createfx_manipulate_offset = level.createfx_manipulate_offset + 1 % print_frames;
	i = offset;
	while(i < level.createfxent.size)
	{
		ent = level.createfxent[i];
		if(!(ent.drawn))
		{
		}
		else if(IsDefined(highlightedent) && ent == highlightedent)
		{
		}
		else
		{
			colorindex = "default";
			if(index_is_selected(i))
			{
				colorindex = "selected";
			}

/#
				print3d(ent.v["origin"],".",colors[ent.v["type"]][colorindex],1,scale,print_frames);
#/
			if(ent.textalpha > 0)
			{
				printright = VectorScale(right);
				printup = (0,0,15 * scale);
/#
					print3d(ent.v["origin"] + printright + printup,ent.v["fxid"],colors[ent.v["type"]][colorindex],ent.textalpha,scale,print_frames);
#/
			}
		}

		i = Stack-Empty ? ent.v["fxid"].size * -2.93 * scale : i + print_frames;
	}

	if(IsDefined(highlightedent))
	{
		if(!(entities_are_selected()))
		{
			display_fx_info(highlightedent);
		}

		if(leftclick)
		{
			entwasselected = index_is_selected(highlightedent.last_fx_index);
			level.createfx_selecting = !entwasselected;
			if(!(ctrlheld))
			{
				selectedsize = level.selected_fx_ents.size;
				clear_entity_selection();
				if(entwasselected && selectedsize == 1)
				{
					select_entity(highlightedent.last_fx_index,highlightedent);
				}
			}

			toggle_entity_selection(highlightedent.last_fx_index,highlightedent);
		}
		else if(leftheld)
		{
			if(ctrlheld)
			{
				if(level.createfx_selecting)
				{
					select_entity(highlightedent.last_fx_index,highlightedent);
				}

				if(!(level.createfx_selecting))
				{
					deselect_entity(highlightedent.last_fx_index,highlightedent);
				}
			}
		}

		colorindex = "highlighted";
		if(index_is_selected(highlightedent.last_fx_index))
		{
			colorindex = "selected";
		}

/#
		print3d(highlightedent.v["origin"],".",colors[highlightedent.v["type"]][colorindex],1,scale,1);
#/
		if(highlightedent.textalpha > 0)
		{
			printright = VectorScale(right);
			printup = (0,0,15 * scale);
/#
			print3d(highlightedent.v["origin"] + printright + printup,highlightedent.v["fxid"],colors[highlightedent.v["type"]][colorindex],highlightedent.textalpha,scale,1);
#/
		}
	}
}

//Function Number: 10
clear_settable_fx()
{
	level.createfx_inputlocked = 0;
	setdvar("fx","nil");
	level.selected_fx_option_index = undefined;
	reset_fx_hud_colors();
}

//Function Number: 11
reset_fx_hud_colors()
{
	for(i = 0;i < level.createfx_hudelements;i++)
	{
		level.createfxhudelements[i][0].color = (1,1,1);
	}
}

//Function Number: 12
button_is_held(name,name2)
{
	if(IsDefined(name2))
	{
		if(IsDefined(level.buttonisheld[name2]))
		{
			return 1;
		}
	}

	return IsDefined(level.buttonisheld[name]);
}

//Function Number: 13
button_is_clicked(name,name2)
{
	if(IsDefined(name2))
	{
		if(IsDefined(level.buttonclick[name2]))
		{
			return 1;
		}
	}

	return IsDefined(level.buttonclick[name]);
}

//Function Number: 14
toggle_entity_selection(index,ent)
{
	if(IsDefined(level.selected_fx[index]))
	{
		deselect_entity(index,ent);
	}
	else
	{
		select_entity(index,ent);
	}
}

//Function Number: 15
select_entity(index,ent,skip_undo)
{
	if(IsDefined(level.selected_fx[index]))
	{
		return;
	}

	ent.last_fx_index = index;
	if(!IsDefined(skip_undo) && level.cfx_last_action != "none")
	{
		store_undo_state("edit",level.selected_fx_ents);
		level.cfx_last_action = "none";
	}

	clear_settable_fx();
	level notify("new_ent_selection");
	ent thread entity_highlight_enable();
	level.selected_fx[index] = 1;
	level.selected_fx_ents[level.selected_fx_ents.size] = ent;
}

//Function Number: 16
ent_is_highlighted(ent)
{
	if(!(IsDefined(level.fx_highlightedent)))
	{
		return 0;
	}

	return ent == level.fx_highlightedent;
}

//Function Number: 17
deselect_entity(index,ent)
{
	if(!(IsDefined(level.selected_fx[index])))
	{
		return;
	}

	if(level.cfx_last_action != "none")
	{
		store_undo_state("edit",level.selected_fx_ents);
		level.cfx_last_action = "none";
	}

	clear_settable_fx();
	level notify("new_ent_selection");
	level.selected_fx[index] = undefined;
	if(!(ent_is_highlighted(ent)))
	{
		ent thread entity_highlight_disable();
	}

	newarray = [];
	for(i = 0;i < level.selected_fx_ents.size;i++)
	{
		if(level.selected_fx_ents[i] != ent)
		{
			newarray[newarray.size] = level.selected_fx_ents[i];
		}
	}

	level.selected_fx_ents = newarray;
}

//Function Number: 18
index_is_selected(index)
{
	return IsDefined(level.selected_fx[index]);
}

//Function Number: 19
ent_is_selected(ent)
{
	for(i = 0;i < level.selected_fx_ents.size;i++)
	{
		if(level.selected_fx_ents[i] == ent)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 20
clear_entity_selection(skip_undo)
{
	if(!IsDefined(skip_undo) && level.cfx_last_action != "none")
	{
		store_undo_state("edit",level.selected_fx_ents);
		level.cfx_last_action = "none";
	}

	for(i = 0;i < level.selected_fx_ents.size;i++)
	{
		if(!(ent_is_highlighted(level.selected_fx_ents[i])))
		{
			level.selected_fx_ents[i] thread entity_highlight_disable();
		}
	}

	level.selected_fx = [];
	level.selected_fx_ents = [];
}

//Function Number: 21
draw_axis()
{
	if(IsDefined(self.draw_axis_model))
	{
		return;
	}

	self.draw_axis_model = spawn_axis_model(self.v["origin"],self.v["angles"]);
	level thread draw_axis_think(self);
	if(!(IsDefined(level.draw_axis_models)))
	{
		level.draw_axis_models = [];
	}

	level.draw_axis_models[level.draw_axis_models.size] = self.draw_axis_model;
}

//Function Number: 22
spawn_axis_model(origin,angles)
{
	model = spawn("script_model",origin);
	model setmodel("fx_axis_createfx");
	model.angles = angles;
	return model;
}

//Function Number: 23
draw_axis_think(axis_parent)
{
	axis_model = axis_parent.draw_axis_model;
	axis_model endon("death");
	player = get_players()[0];
	range = GetDvarInt(#"74012625");
	i = 0;
	while(1)
	{
		if(!(IsDefined(axis_parent)))
		{
			break;
		}

		if(distancesquared(axis_model.origin,player.origin) > range * range)
		{
			if(IsDefined(axis_model))
			{
				axis_model delete();
				arrayremovevalue(level.draw_axis_models,undefined);
			}
		}
		else if(!(IsDefined(axis_model)))
		{
			axis_model = spawn_axis_model(axis_parent.v["origin"],axis_parent.v["angles"]);
			axis_parent.draw_axis_model = axis_model;
			level.draw_axis_models[level.draw_axis_models.size] = axis_model;
		}

		axis_model.origin = axis_parent.v["origin"];
		axis_model.angles = axis_parent.v["angles"];
		wait(0.1);
		i++;
		if(i >= 10)
		{
			range = GetDvarInt(#"74012625");
			i = 0;
		}
	}

	if(IsDefined(axis_model))
	{
		axis_model delete();
	}
}

//Function Number: 24
stop_drawing_axis_models()
{
	if(IsDefined(level.draw_axis_models))
	{
		for(i = 0;i < level.draw_axis_models.size;i++)
		{
			if(IsDefined(level.draw_axis_models[i]))
			{
				level.draw_axis_models[i] delete();
			}
		}

		arrayremovevalue(level.draw_axis_models,undefined);
	}
}

//Function Number: 25
clear_fx_hudelements()
{
	level.cfx_center_text[level.cfx_center_text_max - 1] clearalltextafterhudelem();
	for(i = 0;i < level.createfx_hudelements;i++)
	{
		for(p = 0;p < 2;p++)
		{
			level.createfxhudelements[i][p] settext("");
		}
	}

	level.fxhudelements = 0;
}

//Function Number: 26
set_fx_hudelement(text)
{
	if(ismp() && !IsDefined(level.createfx_delay_done))
	{
		return;
	}

	if(level.fxhudelements < level.createfx_hudelements)
	{
		for(p = 0;p < 2;p++)
		{
			level.createfxhudelements[level.fxhudelements][p] settext(text);
		}

		level.fxhudelements++;
	}
}

//Function Number: 27
buttondown(button,button2)
{
	return buttonpressed_internal(button) || buttonpressed_internal(button2);
}

//Function Number: 28
buttonpressed_internal(button)
{
	if(!(IsDefined(button)))
	{
		return 0;
	}

	if(kb_locked(button))
	{
		return 0;
	}

	player = get_players()[0];
	return player buttonpressed(button);
}

//Function Number: 29
get_selected_move_vector()
{
	player = get_players()[0];
	yaw = player getplayerangles()[1];
	angles = (0,yaw,0);
	right = AnglesToRight(angles);
	forward = AnglesToForward(angles);
	up = AnglesToUp(angles);
	ctrlheld = button_is_held("ctrl","BUTTON_LSHLDR");
	if(buttondown("kp_uparrow","DPAD_UP"))
	{
		if(level.selectedmove_forward < 0)
		{
			level.selectedmove_forward = 0;
		}

		if(ctrlheld)
		{
			level.selectedmove_forward = 0.1;
			wait(0.05);
		}
		else
		{
			level.selectedmove_forward = level.selectedmove_forward + 1;
		}
	}
	else if(buttondown("kp_downarrow","DPAD_DOWN"))
	{
		if(level.selectedmove_forward > 0)
		{
			level.selectedmove_forward = 0;
		}

		if(ctrlheld)
		{
			level.selectedmove_forward = -1 * 0.1;
			wait(0.05);
		}
		else
		{
			level.selectedmove_forward = level.selectedmove_forward - 1;
		}
	}
	else
	{
		level.selectedmove_forward = 0;
	}

	if(buttondown("kp_rightarrow","DPAD_RIGHT"))
	{
		if(level.selectedmove_right < 0)
		{
			level.selectedmove_right = 0;
		}

		if(ctrlheld)
		{
			level.selectedmove_right = 0.1;
			wait(0.05);
		}
		else
		{
			level.selectedmove_right = level.selectedmove_right + 1;
		}
	}
	else if(buttondown("kp_leftarrow","DPAD_LEFT"))
	{
		if(level.selectedmove_right > 0)
		{
			level.selectedmove_right = 0;
		}

		if(ctrlheld)
		{
			level.selectedmove_right = -1 * 0.1;
			wait(0.05);
		}
		else
		{
			level.selectedmove_right = level.selectedmove_right - 1;
		}
	}
	else
	{
		level.selectedmove_right = 0;
	}

	if(buttondown("BUTTON_Y"))
	{
		if(level.selectedmove_up < 0)
		{
			level.selectedmove_up = 0;
		}

		if(ctrlheld)
		{
			level.selectedmove_up = 0.1;
			wait(0.05);
		}
		else
		{
			level.selectedmove_up = level.selectedmove_up + 1;
		}
	}
	else if(buttondown("BUTTON_B"))
	{
		if(level.selectedmove_up > 0)
		{
			level.selectedmove_up = 0;
		}

		if(ctrlheld)
		{
			level.selectedmove_up = -1 * 0.1;
			wait(0.05);
		}
		else
		{
			level.selectedmove_up = level.selectedmove_up - 1;
		}
	}
	else
	{
		level.selectedmove_up = 0;
	}

	vector = (0,0,0);
	vector = level.selectedmove_forward + VectorScale(forward);
	vector = level.selectedmove_right + VectorScale(right);
	vector = level.selectedmove_up + VectorScale(up);
	return vector;
}

//Function Number: 30
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
	add_button("BUTTON_RTRIG");
	add_button("BUTTON_LTRIG");
	add_kb_button("a");
	add_button("F1");
	add_button("F5");
	add_button("F2");
	add_kb_button("c");
	add_kb_button("d");
	add_kb_button("f");
	add_kb_button("h");
	add_kb_button("i");
	add_kb_button("j");
	add_kb_button("k");
	add_kb_button("l");
	add_kb_button("m");
	add_kb_button("p");
	add_kb_button("q");
	add_kb_button("r");
	add_kb_button("s");
	add_kb_button("v");
	add_kb_button("x");
	add_kb_button("z");
	add_button("del");
	add_kb_button("end");
	add_kb_button("tab");
	add_kb_button("ins");
	add_kb_button("add");
	add_kb_button("space");
	add_kb_button("enter");
	add_kb_button("leftarrow");
	add_kb_button("rightarrow");
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
	add_kb_button("~");
}

//Function Number: 31
locked(name)
{
	if(IsDefined(level.createfx_lockedlist[name]))
	{
		return 0;
	}

	return kb_locked(name);
}

//Function Number: 32
kb_locked(name)
{
	return level.createfx_inputlocked && IsDefined(level.button_is_kb[name]);
}

//Function Number: 33
add_button(name)
{
	player = get_players()[0];
	if(locked(name))
	{
		return;
	}

	if(!(IsDefined(level.buttonisheld[name])))
	{
		if(player buttonpressed(name))
		{
			level.buttonisheld[name] = 1;
			level.buttonclick[name] = 1;
		}
	}
	else if(!(player buttonpressed(name)))
	{
		level.buttonisheld[name] = undefined;
	}
}

//Function Number: 34
add_kb_button(name)
{
	level.button_is_kb[name] = 1;
	add_button(name);
}

//Function Number: 35
set_anglemod_move_vector()
{
/#
	ctrlheld = button_is_held("ctrl","BUTTON_LSHLDR");
	players = get_players();
	newmovement = players[0] getnormalizedmovement();
	dolly_movement = players[0] getnormalizedcameramovement();
	level.selectedrotate_yaw = level.selectedrotate_yaw - 1;
	level.selectedrotate_yaw = level.selectedrotate_yaw + 1;
	level.selectedrotate_yaw = 0;
	level.selectedrotate_yaw = level.selectedrotate_yaw + 0.1;
	level.selectedrotate_yaw = 0;
	level.selectedrotate_yaw = level.selectedrotate_yaw - 0.1;
	level.selectedrotate_yaw = 0;
	level.selectedrotate_pitch = level.selectedrotate_pitch + 1;
	level.selectedrotate_pitch = level.selectedrotate_pitch - 1;
	level.selectedrotate_pitch = 0;
	level.selectedrotate_pitch = level.selectedrotate_pitch + 0.1;
	level.selectedrotate_pitch = 0;
	level.selectedrotate_pitch = level.selectedrotate_pitch - 0.1;
	level.selectedrotate_pitch = 0;
	level.selectedrotate_roll = 0;
	level.selectedrotate_roll = level.selectedrotate_roll + 0.1;
	level.selectedrotate_roll = 0;
	level.selectedrotate_roll = level.selectedrotate_roll - 0.1;
	level.selectedrotate_roll = 0;
	level.selectedrotate_pitch = 0;
	level.selectedrotate_pitch = 0.1;
	wait(0.05);
	level.selectedrotate_pitch = level.selectedrotate_pitch + 1;
	level.selectedrotate_pitch = 0;
	level.selectedrotate_pitch = -1 * 0.1;
	wait(0.05);
	level.selectedrotate_pitch = level.selectedrotate_pitch - 1;
	level.selectedrotate_pitch = 0;
	level.selectedrotate_yaw = 0;
	level.selectedrotate_yaw = 0.1;
	wait(0.05);
	level.selectedrotate_yaw = level.selectedrotate_yaw + 1;
	level.selectedrotate_yaw = 0;
	level.selectedrotate_yaw = -1 * 0.1;
	wait(0.05);
	level.selectedrotate_yaw = level.selectedrotate_yaw - 1;
	level.selectedrotate_yaw = 0;
	level.selectedrotate_roll = 0;
	level.selectedrotate_roll = 0.1;
	wait(0.05);
	level.selectedrotate_roll = level.selectedrotate_roll + 1;
	level.selectedrotate_roll = 0;
	level.selectedrotate_roll = -1 * 0.1;
	wait(0.05);
	level.selectedrotate_roll = level.selectedrotate_roll - 1;
	level.selectedrotate_roll = 0;
Stack-Empty ? Stack-Empty : (Stack-Empty ? Stack-Empty : ((Stack-Empty ? Stack-Empty : ((Stack-Empty ? Stack-Empty : (((Stack-Empty ? Stack-Empty : ((Stack-Empty ? Stack-Empty : ((level.is_camera_on == 1) ? newmovement[1] <= -0.3 : ((newmovement[1] >= 0.3) ? buttondown("kp_leftarrow","DPAD_LEFT") : ((level.selectedrotate_yaw < 0) ? buttondown("kp_rightarrow","DPAD_RIGHT") : level.selectedrotate_yaw > 0)))) ? dolly_movement[0] <= -0.2 : ((dolly_movement[0] >= 0.2) ? buttondown("kp_uparrow","DPAD_UP") : ((level.selectedrotate_pitch < 0) ? buttondown("kp_downarrow","DPAD_DOWN") : level.selectedrotate_pitch > 0)))) ? buttondown("BUTTON_Y") : ((level.selectedrotate_roll < 0) ? buttondown("BUTTON_B") : level.selectedrotate_roll > 0)) ? ((buttondown("kp_uparrow","DPAD_UP")) ? level.selectedrotate_pitch < 0 : ctrlheld) : ((buttondown("kp_downarrow","DPAD_DOWN")) ? level.selectedrotate_pitch > 0 : ctrlheld))) ? ((buttondown("kp_leftarrow","DPAD_LEFT")) ? level.selectedrotate_yaw < 0 : ctrlheld) : ((buttondown("kp_rightarrow","DPAD_RIGHT")) ? level.selectedrotate_yaw > 0 : ctrlheld))) ? ((buttondown("BUTTON_Y")) ? level.selectedrotate_roll < 0 : ctrlheld) : ((buttondown("BUTTON_B")) ? level.selectedrotate_roll > 0 : ctrlheld)))
#/
}

//Function Number: 36
cfxprintln(file,string)
{
/#
	return;
	fprintln(file,string);
file == -1
#/
}

//Function Number: 37
update_save_bar(number)
{
	level notify("saving_start");
	level endon("saving_start");
	level.current_saving_number = 0;
	while(level.current_saving_number < level.createfxent.size)
	{
		center_text_clear();
		center_text_add("Saving Createfx to File");
		center_text_add("Saving effect " + level.current_saving_number + "/" + level.createfxent.size);
		center_text_add("Do not reset Xenon until saving is complete.");
		wait(0.05);
		center_text_clear();
	}

	center_text_add("Saving Complete.");
	center_text_add(level.createfxent.size + " effects saved to files.");
}

//Function Number: 38
generate_fx_log(type,autosave)
{
/#
	autosave = IsDefined(autosave);
	filename = level.cfx_server_scriptdata + level.script + "_fx.gsc";
	filename = level.cfx_server_scriptdata + "backup.gsc";
	call_loop = level.cfx_server_loop;
	call_oneshot = level.cfx_server_oneshot;
	call_exploder = level.cfx_server_exploder;
	call_loopsound = level.cfx_server_loopsound;
	filename = level.cfx_client_scriptdata + level.script + "_fx.csc";
	filename = level.cfx_client_scriptdata + "backup.csc";
	call_loop = level.cfx_client_loop;
	call_oneshot = level.cfx_client_oneshot;
	call_exploder = level.cfx_client_exploder;
	call_loopsound = level.cfx_client_loopsound;
	println("^1Error: Improper type in generate_fx_log()");
	return;
	file = openfile(filename,"write");
	level.write_error = filename;
	return 1;
	return 2;
	return 3;
	cfxprintln(file,"//_createfx generated. Do not touch!!");
	cfxprintln(file,"main()");
	cfxprintln(file,"{");
	p = 0;
	for(;;)
	{
		ent = level.createfxent[p];
		origin = [];
		angles = [];
		i = 0;
		for(;;)
		{
			origin[i] = ent.v["origin"][i];
			angles[i] = ent.v["angles"][i];
			origin[i] = 0;
			angles[i] = 0;
			i++;
		}
		ent.v["origin"] = (origin[0],origin[1],origin[2]);
		ent.v["angles"] = (angles[0],angles[1],angles[2]);
		p++;
	}
	println(" *** CREATING EFFECT, COPY THESE LINES TO ",level.script,"_fx.gsc *** ");
	cfxprintln(file,"// CreateFX entities placed: " + level.createfxent.size - level.non_fx_ents);
	breather = 0;
	breather_pause = 1;
	breather_pause = 5;
	i = 0;
	for(;;)
	{
		e = level.createfxent[i];
/#
		assert(IsDefined(e.v["type"]),"effect at origin " + e.v["origin"] + " has no type");
#/
		output_name = "\t";
		output_props = "\t";
		ent_type = e.v["type"];
		output_name = output_name + "ent = " + call_loop + "( \" + e.v["fxid"] + "\" );";
		output_name = output_name + "ent = " + call_oneshot + "( \" + e.v["fxid"] + "\" );";
		output_name = output_name + "ent = " + call_exploder + "( \" + e.v["fxid"] + "\" );";
		output_name = output_name + "ent = " + call_loopsound + "();";
		output_props = output_props + get_fx_options(e);
		cfxprintln(file,output_name);
		cfxprintln(file,output_props);
		cfxprintln(file,"\t");
		breather++;
		wait(0.05);
		breather = 0;
		i++;
	}
	script_gen_dump_addline(level.cfx_server_scriptgendump,level.script + "_fx");
	[[ level.cfx_func_script_gen_dump ]]();
	cfxprintln(file,"}");
	saved = closefile(file);
/#
	assert(saved == 1,"File not saved (see above message?): " + filename);
#/
	println("CreateFX entities placed: " + level.createfxent.size - level.non_fx_ents);
	return 0;
(e.v["fxid"] == "No FX") ? (ent_type == "loopfx" ? ent_type == "oneshotfx" : ((ent_type == "exploder") ? ent_type == "soundfx" : breather >= breather_pause)) : level.bscriptgened
IsDefined(e.model)
i < level.createfxent.size
(angles[i] < 0.1 && angles[i] > 0.1 * -1) ? autosave : autosave
origin[i] < 0.1 && origin[i] > 0.1 * -1
i < 3
p < level.createfxent.size
Stack-Empty ? (Stack-Empty ? Stack-Empty : (Stack-Empty ? Stack-Empty : ((Stack-Empty ? type == "server" : autosave) ? type == "client" : autosave))) : (file == -1 ? type == "server" : type == "client")
#/
}

//Function Number: 39
get_fx_options(ent)
{
	output_props = "";
	for(i = 0;i < level.createfx_options.size;i++)
	{
		option = level.createfx_options[i];
		if(!(IsDefined(ent.v[option["name"]])))
		{
		}
		else if(!(mask(option["mask"],ent.v["type"])))
		{
		}
		else if(option["type"] == "string")
		{
			if(option["name"] == "fxid")
			{
			}
			else
			{
				output_props = output_props + "ent.v[ \" + option["name"] + "\" ] = \" + ent.v[option["name"]] + "\"; ";
				output_props = output_props + "ent.v[ \" + option["name"] + "\" ] = " + ent.v[option["name"]] + "; ";
			}
		}
	}

	return output_props;
}

//Function Number: 40
entity_highlight_disable()
{
	self notify("highlight change");
	self endon("highlight change");
	for(;;)
	{
		self.textalpha = self.textalpha - 0.05;
		if(self.textalpha < 0.4)
		{
			break;
		}

		wait(0.05);
	}

	self.textalpha = 0.4;
}

//Function Number: 41
entity_highlight_enable()
{
	self notify("highlight change");
	self endon("highlight change");
	for(;;)
	{
		self.textalpha = self.textalpha + 0.05;
		if(self.textalpha > 1)
		{
			break;
		}

		wait(0.05);
	}

	self.textalpha = 1;
}

//Function Number: 42
get_center_of_array(array)
{
	center = (0,0,0);
	for(i = 0;i < array.size;i++)
	{
		center = (center[0] + array[i].v["origin"][0],center[1] + array[i].v["origin"][1],center[2] + array[i].v["origin"][2]);
	}

	return (center[0] / array.size,center[1] / array.size,center[2] / array.size);
}

//Function Number: 43
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

//Function Number: 44
process_fx_rotater()
{
	if(level.fx_rotating)
	{
		return;
	}

	set_anglemod_move_vector();
	if(!(rotation_is_occuring()))
	{
		return;
	}

	level.fx_rotating = 1;
	if(level.cfx_last_action != "rotate")
	{
		store_undo_state("edit",level.selected_fx_ents);
		level.cfx_last_action = "rotate";
	}

	if(level.selected_fx_ents.size > 1)
	{
		center = get_center_of_array(level.selected_fx_ents);
		org = spawn("script_origin",center);
		org.v["angles"] = level.selected_fx_ents[0].v["angles"];
		org.v["origin"] = center;
		rotater = [];
		for(i = 0;i < level.selected_fx_ents.size;i++)
		{
			rotater[i] = spawn("script_origin",level.selected_fx_ents[i].v["origin"]);
			rotater[i].angles = level.selected_fx_ents[i].v["angles"];
			rotater[i] linkto(org);
		}

		rotate_over_time(org,rotater);
		org delete();
		for(i = 0;i < rotater.size;i++)
		{
			rotater[i] delete();
		}
	}
	else if(level.selected_fx_ents.size == 1)
	{
		ent = level.selected_fx_ents[0];
		rotater = spawn("script_origin",(0,0,0));
		rotater.angles = ent.v["angles"];
		if(level.selectedrotate_pitch != 0)
		{
			rotater devaddpitch(level.selectedrotate_pitch);
		}
		else if(level.selectedrotate_yaw != 0)
		{
			rotater devaddyaw(level.selectedrotate_yaw);
		}
		else
		{
			rotater devaddroll(level.selectedrotate_roll);
		}

		ent.v["angles"] = rotater.angles;
		rotater delete();
		wait(0.05);
	}

	level.fx_rotating = 0;
}

//Function Number: 45
rotate_over_time(org,rotater)
{
	level endon("new_ent_selection");
	for(p = 0;p < 2;p++)
	{
		if(level.selectedrotate_pitch != 0)
		{
			org devaddpitch(level.selectedrotate_pitch);
		}
		else if(level.selectedrotate_yaw != 0)
		{
			org devaddyaw(level.selectedrotate_yaw);
		}
		else
		{
			org devaddroll(level.selectedrotate_roll);
		}

		wait(0.05);
		for(i = 0;i < level.selected_fx_ents.size;i++)
		{
			ent = level.selected_fx_ents[i];
			if(IsDefined(ent.model))
			{
			}
			else
			{
				ent.v["origin"] = rotater[i].origin;
				ent.v["angles"] = rotater[i].angles;
			}
		}
	}
}

//Function Number: 46
delete_pressed()
{
	if(level.createfx_inputlocked)
	{
		remove_selected_option();
		return;
	}

	delete_selection();
}

//Function Number: 47
remove_selected_option()
{
	if(!(IsDefined(level.selected_fx_option_index)))
	{
		return;
	}

	name = level.createfx_options[level.selected_fx_option_index]["name"];
	for(i = 0;i < level.createfxent.size;i++)
	{
		ent = level.createfxent[i];
		if(!(ent_is_selected(ent)))
		{
		}
		else
		{
			ent remove_option(name);
		}
	}

	update_selected_entities();
	clear_settable_fx();
}

//Function Number: 48
remove_option(name)
{
	self.v[name] = undefined;
}

//Function Number: 49
delete_selection()
{
	newarray = [];
	if(level.selected_fx_ents.size < 1)
	{
		return;
	}

	store_undo_state("delete",level.selected_fx_ents);
	level.cfx_last_action = "none";
	for(i = 0;i < level.createfxent.size;i++)
	{
		ent = level.createfxent[i];
		if(ent_is_selected(ent))
		{
			if(IsDefined(ent.looper))
			{
				ent.looper delete();
			}

			level.fx_highlightedent = undefined;
			ent notify("stop_loop");
		}
		else
		{
			newarray[newarray.size] = ent;
		}
	}

	level.createfxent = newarray;
	level.selected_fx = [];
	level.selected_fx_ents = [];
	clear_fx_hudelements();
}

//Function Number: 50
move_selection_to_cursor(skip_undo)
{
	origin = level.createfxcursor["position"];
	if(level.selected_fx_ents.size <= 0)
	{
		return;
	}

	if(!IsDefined(skip_undo) && level.cfx_last_action != "move_to_cursor")
	{
		store_undo_state("edit",level.selected_fx_ents);
		level.cfx_last_action = "move_to_cursor";
	}

	center = get_center_of_array(level.selected_fx_ents);
	difference = center - origin;
	for(i = 0;i < level.selected_fx_ents.size;i++)
	{
		ent = level.selected_fx_ents[i];
		if(IsDefined(ent.model))
		{
		}
		else
		{
			ent.v["origin"] = ent.v["origin"] - difference;
		}
	}
}

//Function Number: 51
insert_effect()
{
	setmenu("creation");
	level.effect_list_offset = 0;
	clear_fx_hudelements();
	set_fx_hudelement("Pick effect type to create:");
	set_fx_hudelement("1. One Shot fx");
	set_fx_hudelement("2. Looping fx");
	set_fx_hudelement("3. Exploder");
	set_fx_hudelement("4. Looping sound");
	set_fx_hudelement("(c) Cancel");
	set_fx_hudelement("(x) Exit");
}

//Function Number: 52
show_help()
{
	clear_fx_hudelements();
	set_fx_hudelement("Help:");
	set_fx_hudelement("I                Insert effect");
	set_fx_hudelement("Shift + D        Delete selected effects");
	set_fx_hudelement("F + 5            Save");
	set_fx_hudelement("A button         Toggle the selection of the current effect");
	set_fx_hudelement("X button         Toggle effect rotation mode");
	set_fx_hudelement("Y button         Move selected effects up or rotate X axis");
	set_fx_hudelement("B button         Move selected effects down or rotate X axis");
	set_fx_hudelement("D-pad Up/Down    Move selected effects Forward/Backward or rotate Y axis");
	set_fx_hudelement("D-pad Left/Right Move selected effects Left/Right or rotate Z axis");
	set_fx_hudelement("R Shoulder       Move selected effects to the cursor");
	set_fx_hudelement("L Shoulder       Hold to select multiple effects");
	set_fx_hudelement("Right Arrow      Next page in options menu");
	set_fx_hudelement("Left Arrow       Previous page in options menu");
	set_fx_hudelement("A                Add option to the selected effects");
	set_fx_hudelement("X                Exit effect options menu");
	set_fx_hudelement("Shift + D        Drop selected effects to the ground");
	set_fx_hudelement("R                Reset the rotation of the selected effects");
	set_fx_hudelement("L Stick          Copy effects");
	set_fx_hudelement("R Stick          Paste effects");
	set_fx_hudelement("V                Copy the angles from the most recently selected fx onto all selected fx.");
	set_fx_hudelement("F + 2            Toggle CreateFX dot and menu drawing");
	set_fx_hudelement("U                UFO");
	set_fx_hudelement("N                Noclip");
	set_fx_hudelement("R Trig + L Trig  Jump forward 8000 units");
	set_fx_hudelement("T                Toggle Timescale FAST");
	set_fx_hudelement("Y                Toggle Timescale SLOW");
	set_fx_hudelement("H                Toggle FX Visibility");
	set_fx_hudelement("W                Toggle effect wireframe");
	set_fx_hudelement("P                Toggle FX Profile");
}

//Function Number: 53
center_text_init()
{
	level.cfx_center_text = [];
	level.cfx_center_text_index = 0;
	level.cfx_center_text_max = 3;
	new_array = [];
	for(p = 0;p < level.cfx_center_text_max;p++)
	{
		center_hud = newdebughudelem();
		center_hud settext(" ");
		center_hud.horzalign = "center";
		center_hud.vertalign = "middle";
		center_hud.alignx = "center";
		center_hud.aligny = "middle";
		center_hud.foreground = 1;
		center_hud.fontscale = 1.1;
		center_hud.sort = 21;
		center_hud.alpha = 1;
		center_hud.color = (1,0,0);
		center_hud.y = p * 25;
		new_array[p] = center_hud;
	}

	level.cfx_center_text = new_array;
}

//Function Number: 54
center_text_add(text)
{
	if(IsDefined(text) && IsDefined(level.cfx_center_text))
	{
		level.cfx_center_text[level.cfx_center_text_index] settext(text);
		level.cfx_center_text_index++;
		if(level.cfx_center_text_index >= level.cfx_center_text_max)
		{
			level.cfx_center_text_index = level.cfx_center_text_max - 1;
		}
	}
}

//Function Number: 55
center_text_clear()
{
	for(p = 0;p < level.cfx_center_text_max;p++)
	{
		level.cfx_center_text[p] settext(" ");
	}

	level.cfx_center_text_index = 0;
}

//Function Number: 56
write_error_msg(filename)
{
	level notify("write_error");
	level endon("write_error");
	if(IsDefined(filename))
	{
		center_text_clear();
		center_text_add("File " + filename + " is not writeable.");
		center_text_add("If it\'s checked out, restart your computer!");
		center_text_add("Hold the A Button to dismiss.");
		for(;;)
		{
			player = get_players()[0];
			if(player buttonpressed("BUTTON_A"))
			{
				center_text_clear();
				level.write_error = "";
				break;
			}

			wait(0.25);
		}
	}
}

//Function Number: 57
select_last_entity(skip_undo)
{
	select_entity(level.createfxent.size - 1,level.createfxent[level.createfxent.size - 1],skip_undo);
}

//Function Number: 58
post_entity_creation_function()
{
	self.textalpha = 0;
	self.drawn = 1;
}

//Function Number: 59
copy_ents()
{
	if(level.selected_fx_ents.size <= 0)
	{
		return;
	}

	array = [];
	for(i = 0;i < level.selected_fx_ents.size;i++)
	{
		ent = level.selected_fx_ents[i];
		newent = spawnstruct();
		newent.v = ent.v;
		newent post_entity_creation_function();
		array[array.size] = newent;
	}

	level.stored_ents = array;
}

//Function Number: 60
paste_ents()
{
	delay_min = GetDvarInt(#"72501C7");
	delay_max = GetDvarInt(#"A6DCBA49");
	if(delay_min > delay_max)
	{
		temp = delay_min;
		delay_min = delay_max;
		delay_max = temp;
	}

	if(!(IsDefined(level.stored_ents)))
	{
		return;
	}

	clear_entity_selection();
	if(level.cfx_last_action != "none")
	{
		store_undo_state("edit",level.selected_fx_ents);
	}

	level.cfx_last_action = "none";
	for(i = 0;i < level.stored_ents.size;i++)
	{
		level.stored_ents[i].uniqueid = level.cfx_uniqueid;
		level.cfx_uniqueid++;
		if(level.stored_ents[i].v["type"] == "oneshotfx")
		{
			level.stored_ents[i].v["delay"] = randomintrange(delay_min,delay_max);
		}

		add_and_select_entity(level.stored_ents[i],"skip_undo");
	}

	move_selection_to_cursor("skip_undo");
	update_selected_entities();
	store_undo_state("add",level.stored_ents);
	level.stored_ents = [];
	copy_ents();
}

//Function Number: 61
paste_ents_onto_ents()
{
	if(!IsDefined(level.stored_ents) || !IsDefined(level.selected_fx_ents))
	{
		return;
	}

	if(level.stored_ents.size < 1 || level.selected_fx_ents.size < 1)
	{
		return;
	}

	if(level.stored_ents.size != level.selected_fx_ents.size)
	{
/#
		println("^2CreateFX: Number of source ents must match the number of destination ents for Paste Into to work.");
#/
		return;
	}

	if(level.cfx_last_action != "none")
	{
		store_undo_state("edit",level.selected_fx_ents);
	}

	level.cfx_last_action = "none";
	selected_ents_temp = level.selected_fx_ents;
	for(i = 0;i < level.stored_ents.size;i++)
	{
		source_ent = level.stored_ents[i];
		target_ent = level.selected_fx_ents[i];
		source_ent.uniqueid = level.cfx_uniqueid;
		level.cfx_uniqueid++;
		source_ent.v["angles"] = target_ent.v["angles"];
		source_ent.v["origin"] = target_ent.v["origin"];
		add_and_select_entity(source_ent,"skip_undo");
	}

	for(i = 0;i < selected_ents_temp.size;i++)
	{
		deselect_entity(selected_ents_temp[i].last_fx_index,selected_ents_temp[i]);
	}

	update_selected_entities();
	store_undo_state("add",level.stored_ents);
	level.stored_ents = [];
	copy_ents();
}

//Function Number: 62
add_and_select_entity(ent,skip_undo)
{
	level.createfxent[level.createfxent.size] = ent;
	select_last_entity(skip_undo);
}

//Function Number: 63
stop_fx_looper()
{
	if(IsDefined(self.looper))
	{
		self.looper delete();
	}

	self [[ level.cfx_func_stop_loopsound ]]();
}

//Function Number: 64
restart_fx_looper()
{
	stop_fx_looper();
	self set_forward_and_up_vectors();
	if(self.v["type"] == "loopfx")
	{
		self [[ level.cfx_func_create_looper ]]();
	}

	if(self.v["type"] == "oneshotfx")
	{
		self [[ level.cfx_func_create_triggerfx ]]();
	}

	if(self.v["type"] == "soundfx")
	{
		self [[ level.cfx_func_create_loopsound ]]();
	}
}

//Function Number: 65
update_selected_entities()
{
	for(i = 0;i < level.selected_fx_ents.size;i++)
	{
		ent = level.selected_fx_ents[i];
		ent restart_fx_looper();
	}
}

//Function Number: 66
copy_angles_of_selected_ents()
{
	level notify("new_ent_selection");
	if(level.cfx_last_action != "copy_angles")
	{
		store_undo_state("edit",level.selected_fx_ents);
		level.cfx_last_action = "copy_angles";
	}

	for(i = 0;i < level.selected_fx_ents.size;i++)
	{
		ent = level.selected_fx_ents[i];
		ent.v["angles"] = level.selected_fx_ents[level.selected_fx_ents.size - 1].v["angles"];
		ent set_forward_and_up_vectors();
	}

	update_selected_entities();
}

//Function Number: 67
reset_axis_of_selected_ents()
{
	level notify("new_ent_selection");
	if(level.cfx_last_action != "reset_axis")
	{
		store_undo_state("edit",level.selected_fx_ents);
		level.cfx_last_action = "reset_axis";
	}

	for(i = 0;i < level.selected_fx_ents.size;i++)
	{
		ent = level.selected_fx_ents[i];
		ent.v["angles"] = (0,0,0);
		ent set_forward_and_up_vectors();
	}

	update_selected_entities();
}

//Function Number: 68
last_selected_entity_has_changed(lastselectentity)
{
	if(IsDefined(lastselectentity))
	{
		if(!(entities_are_selected()))
		{
			return 1;
		}
	}
	else
	{
		return entities_are_selected();
	}

	return lastselectentity != level.selected_fx_ents[level.selected_fx_ents.size - 1];
}

//Function Number: 69
createfx_showorigin(id,org,delay,org2,type,exploder,id2,firefx,firefxdelay,firefxsound,fxsound,fxquake,fxdamage,soundalias,repeat,delay_min,delay_max,damage_radius,firefxtimeout)
{
}

//Function Number: 70
drop_selection_to_ground()
{
	if(level.cfx_last_action != "drop_to_ground")
	{
		store_undo_state("edit",level.selected_fx_ents);
		level.cfx_last_action = "drop_to_ground";
	}

	for(i = 0;i < level.selected_fx_ents.size;i++)
	{
		ent = level.selected_fx_ents[i];
		trace = bullettrace(ent.v["origin"],2048 + VectorScale((0,0,-1)),ent.v["origin"],0);
		ent.v["origin"] = trace["position"];
	}
}

//Function Number: 71
set_off_exploders()
{
	level notify("createfx_exploder_reset");
	exploders = [];
	for(i = 0;i < level.selected_fx_ents.size;i++)
	{
		ent = level.selected_fx_ents[i];
		if(IsDefined(ent.v["exploder"]))
		{
			exploders[ent.v["exploder"]] = 1;
		}
	}

	keys = getarraykeys(exploders);
	for(i = 0;i < keys.size;i++)
	{
		exploder(keys[i]);
	}
}

//Function Number: 72
turn_off_exploders()
{
	level notify("createfx_exploder_reset");
	exploders = [];
	for(i = 0;i < level.selected_fx_ents.size;i++)
	{
		ent = level.selected_fx_ents[i];
		if(IsDefined(ent.v["exploder"]))
		{
			exploders[ent.v["exploder"]] = 1;
		}
	}

	keys = getarraykeys(exploders);
	for(i = 0;i < keys.size;i++)
	{
		stop_exploder(keys[i]);
	}
}

//Function Number: 73
draw_distance()
{
	count = 0;
	last_pos = (0,0,0);
	if(GetDvarInt(#"94DFBE78") == 0)
	{
		setdvar("createfx_drawdist","1500");
	}

	player = get_players()[0];
	for(;;)
	{
		maxdist = GetDvarInt(#"94DFBE78");
		maxdistsqr = maxdist * maxdist;
/#
		println("Waiting for createfx to save...");
	flag("createfx_saving")
#/
		flag_waitopen("createfx_saving");
		for(i = 0;i < level.createfxent.size;i++)
		{
			ent = level.createfxent[i];
			if(ent_is_selected(ent))
			{
				ent.drawn = 1;
			}
			else
			{
				ent.drawn = distancesquared(player.origin,ent.v["origin"]) <= maxdistsqr;
			}

			count++;
			if(count > 50)
			{
				count = 0;
				wait(0.05);
			}
		}

		wait(0.1);
		while(distancesquared(player.origin,last_pos) < 2500)
		{
			wait(0.1);
		}

		last_pos = player.origin;
	}
}

//Function Number: 74
createfx_save(autosave)
{
	flag_waitopen("createfx_saving");
	flag_set("createfx_saving");
	resettimeout();
	if(IsDefined(autosave))
	{
		savemode = "AUTOSAVE";
	}
	else
	{
		savemode = "USER SAVE";
	}

	type = "server";
	old_time = GetTime();
/#
	println("\n^3#### CREATEFX SERVER " + savemode + " BEGIN ####");
#/
	file_error = generate_fx_log(type,autosave);
/#
	println("^3#### CREATEFX SERVER " + savemode + " END (Time: " + GetTime() - old_time * 0.001 + " seconds)####");
#/
	if(file_error)
	{
/#
		println("^3#### CREATEFX " + savemode + " CANCELLED ####");
#/
		createfx_emergency_backup();
	}
	else
	{
		if(level.clientscripts && !IsDefined(autosave))
		{
			old_time = GetTime();
/#
			println("\n^3#### CREATEFX CLIENT " + savemode + " BEGIN ####");
#/
			file_error = generate_fx_log("client");
/#
			println("^3#### CREATEFX CLIENT " + savemode + " END (Time: " + GetTime() - old_time * 0.001 + " seconds)####");
#/
			if(file_error)
			{
/#
				iprintln("CreateFX clientscript file is not writeable! Aborting save.");
#/
/#
				println("^3#### CREATEFX " + savemode + " CANCELLED ####");
#/
				return;
			}
		}

		flag_clear("createfx_saving");
	}
}

//Function Number: 75
createfx_autosave()
{
	for(;;)
	{
		wait_time = GetDvarInt(#"6AC13DAC");
		if(wait_time < 120 || isstring(wait_time))
		{
			wait_time = 120;
		}

		wait(wait_time);
		if(!(flag("createfx_saving")))
		{
			createfx_save(1);
		}
	}
}

//Function Number: 76
createfx_emergency_backup()
{
/#
	println("^5#### CREATEFX EMERGENCY BACKUP BEGIN ####");
#/
	file_error = generate_fx_log("server",1);
	if(file_error)
	{
/#
		iprintln("Error saving to backup.gsc.  All is lost!");
#/
	}
	else
	{
/#
		println("^5#### CREATEFX EMERGENCY BACKUP END ####");
#/
	}

	flag_clear("createfx_saving");
}

//Function Number: 77
move_player_around_map_fast()
{
	player = get_players()[0];
	direction = player getplayerangles();
	direction_vec = AnglesToForward(direction);
	eye = player geteye();
	trace = bullettrace(eye,20000 + VectorScale(direction_vec),eye,0);
	dist = distance(eye,trace["position"]);
	position = dist - 64 + VectorScale(direction_vec);
	player setorigin(position);
}

//Function Number: 78
move_player_to_next_same_effect(forward_search,lastselectentity)
{
	player = get_players()[0];
	direction = player getplayerangles();
	direction_vec = AnglesToForward(direction);
	if(!(IsDefined(forward_search)))
	{
		forward_search = 1;
	}

	ent = level.selected_fx_ents[level.selected_fx_ents.size - 1];
	start_index = 0;
	if(level.selected_fx_ents.size <= 0)
	{
		if(forward_search)
		{
			ent = level.cfx_next_ent;
		}
		else
		{
			ent = level.cfx_previous_ent;
		}

		if(IsDefined(ent))
		{
			index = get_ent_index(ent);
			if(index >= 0)
			{
				select_entity(index,ent);
				position = 175 - VectorScale(direction_vec);
				player setorigin(position);
				level.cfx_previous_ent = ent;
				level.cfx_next_ent = get_next_ent_with_same_id(index,ent.v["fxid"]);
			}
			else if(forward_search)
			{
				level.cfx_next_ent = undefined;
			}
			else
			{
				level.cfx_previous_ent = undefined;
			}
		}

		return;
	}

	if(level.selected_fx_ents.size == 1)
	{
		for(i = 0;i < level.createfxent.size;i++)
		{
			if(IsDefined(level.selected_fx[i]))
			{
				start_index = i;
				deselect_entity(i,ent);
				break;
			}
		}

		if(forward_search)
		{
			level.cfx_previous_ent = ent;
			ent = get_next_ent_with_same_id(i,ent.v["fxid"]);
			select_entity(level.ent_found_index,ent);
			position = 175 - VectorScale(direction_vec);
			player setorigin(position);
			level.cfx_next_ent = get_next_ent_with_same_id(level.ent_found_index,ent.v["fxid"]);
			return;
		}
		else
		{
			level.cfx_next_ent = ent;
			ent = get_previous_ent_with_same_id(i,ent.v["fxid"]);
			select_entity(level.ent_found_index,ent);
			position = 175 - VectorScale(direction_vec);
			player setorigin(position);
			level.cfx_previous_ent = get_previous_ent_with_same_id(level.ent_found_index,ent.v["fxid"]);
			return;
		}
	}
	else
	{
		if(IsDefined(level.last_ent_moved_to) && !last_selected_entity_has_changed(lastselectentity))
		{
			ent = level.last_ent_moved_to;
		}

		for(i = 0;i < level.selected_fx_ents.size;i++)
		{
			if(ent == level.selected_fx_ents[i])
			{
				break;
			}
		}

		if(forward_search)
		{
			if(i < level.selected_fx_ents.size - 1)
			{
				i++;
				ent = level.selected_fx_ents[i];
			}
			else
			{
				ent = level.selected_fx_ents[0];
			}
		}
		else if(i > 0)
		{
			ent = level.selected_fx_ents[i - 1];
		}
		else
		{
			ent = level.selected_fx_ents[level.selected_fx_ents.size - 1];
		}

		level.last_ent_moved_to = ent;
		position = 175 - VectorScale(direction_vec);
		player setorigin(position);
	}
}

//Function Number: 79
get_next_ent_with_same_id(index,ent_id)
{
	for(i = index + 1;i < level.createfxent.size;i++)
	{
		if(ent_id == level.createfxent[i].v["fxid"])
		{
			level.ent_found_index = i;
			return level.createfxent[i];
		}
	}

	for(i = 0;i < index;i++)
	{
		if(ent_id == level.createfxent[i].v["fxid"])
		{
			level.ent_found_index = i;
			return level.createfxent[i];
		}
	}

	level.ent_found_index = index;
	return level.createfxent[index];
}

//Function Number: 80
get_previous_ent_with_same_id(index,ent_id)
{
	for(i = index - 1;i > 0;i--)
	{
		if(ent_id == level.createfxent[i].v["fxid"])
		{
			level.ent_found_index = i;
			return level.createfxent[i];
		}
	}

	for(i = level.createfxent.size - 1;i > index;i--)
	{
		if(ent_id == level.createfxent[i].v["fxid"])
		{
			level.ent_found_index = i;
			return level.createfxent[i];
		}
	}

	level.ent_found_index = index;
	return level.createfxent[index];
}

//Function Number: 81
get_ent_index(ent)
{
	for(i = 0;i < level.createfxent.size;i++)
	{
		if(ent == level.createfxent[i])
		{
			return i;
		}
	}

	return -1;
}

//Function Number: 82
select_ents_by_property(property,add_to_selection)
{
	ent = level.selected_fx_ents[level.selected_fx_ents.size - 1];
	prop_to_match = ent.v[property];
	if(!(IsDefined(add_to_selection)))
	{
		clear_entity_selection();
	}

	for(i = 0;i < level.createfxent.size;i++)
	{
		if(IsDefined(level.createfxent[i].v[property]))
		{
			if(level.createfxent[i].v[property] == prop_to_match)
			{
				select_entity(i,level.createfxent[i]);
			}
		}
	}
}

//Function Number: 83
print_ambient_fx_inventory()
{
/#
	fx_list = get_level_ambient_fx();
	ent_list = [];
	fx_list_count = [];
	println("\n\n^2INVENTORY OF AMBIENT EFFECTS: ");
	i = 0;
	for(;;)
	{
		ent_list[i] = level.createfxent[i].v["fxid"];
		i++;
	}
	i = 0;
	for(;;)
	{
		count = 0;
		j = 0;
		for(;;)
		{
			count++;
			ent_list[j] = "";
			j++;
		}
		fx_list_count[i] = count;
		i++;
	}
	i = 0;
	for(;;)
	{
		j = i + 1;
		for(;;)
		{
			temp_count = fx_list_count[i];
			temp_id = fx_list[i];
			fx_list_count[i] = fx_list_count[j];
			fx_list[i] = fx_list[j];
			fx_list_count[j] = temp_count;
			fx_list[j] = temp_id;
			j++;
		}
		i++;
	}
	i = 0;
	for(;;)
	{
		switch(fx_list_count[i])
		{
			case "0":
				print("^1");
				break;
			case "1":
				print("^3");
				break;
			default:
				break;
		}
		print(fx_list_count[i] + "\t" + fx_list[i] + "\n");
		i++;
	}
	print("\n");
i < fx_list_count.size
fx_list_count[j] < fx_list_count[i]
j < fx_list_count.size
i < fx_list_count.size - 1
fx_list[i] == ent_list[j]
j < ent_list.size
i < fx_list.size
i < level.createfxent.size
#/
}

//Function Number: 84
vector_changed(old,new)
{
	if(distancesquared(old,new) >= 1)
	{
		return 1;
	}
}

//Function Number: 85
dot_changed(old,new)
{
	dot = vectordot(old,new);
	if(dot < 1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 86
damage_void(einflictor,eattacker,idamage,idflags,smeansofdeath,sweapon,vpoint,vdir,shitloc,timeoffset,boneindex)
{
}

//Function Number: 87
handle_camera()
{
/#
	level notify("new_camera");
	level endon("new_camera");
	movement = (0,0,0);
	level.camera = spawn("script_origin",(0,0,0));
	level.camera setmodel("tag_origin");
	players = get_players();
	players[0] playerlinktodelta(level.camera,"tag_origin",1,0,0,0,0,1);
	players[0] disableweapons();
	level.camera_snapto = 1;
	level.stick_camera = 1;
	level.camera_prev_snapto = 0;
	level.cameravec = (90,150,20);
	model = undefined;
	n_y_vector = 0;
	n_x_vector = 0;
	zoom_level = 300;
	b_changes_x = 0;
	b_changes_z = 0;
	b_changes_y = 0;
	test_string = "";
	for(;;)
	{
		for(;;)
		{
			originoffset = VectorScale(level.cameravec);
			temp_offset = 60 + VectorScale((0,0,-1));
			anglesoffset = VectorToAngles(temp_offset);
			players = get_players();
			newmovement = players[0] getnormalizedmovement();
			dolly_movement = players[0] getnormalizedcameramovement();
			continue;
			n_y_vector = n_y_vector + -0.2;
			b_changes_y = 1;
			n_y_vector = n_y_vector + 0.2;
			b_changes_y = 1;
			b_changes_y = 0;
			n_x_vector = n_x_vector + -0.4;
			b_changes_x = 1;
			n_x_vector = n_x_vector + 0.4;
			b_changes_x = 1;
			b_changes_x = 0;
			zoom_level = zoom_level + 30;
			b_changes_z = 1;
			zoom_level = zoom_level + -30;
			b_changes_z = 1;
			b_changes_z = 0;
			newmovement = (n_x_vector,n_y_vector,newmovement[2]);
			movement = (0,0,0);
			movement = 1 - 0.8 + VectorScale(newmovement);
			tilt = max(0,10 + movement[0] * 160);
			level.cameravec = (cos(movement[1] * 180) * zoom_level,sin(movement[1] * 180) * zoom_level,tilt);
			iprintln(level.cameravec[0] + " " + level.cameravec[1] + " " + level.cameravec[2]);
			level.camera_prev_snapto = level.camera_snapto;
			originoffset = VectorScale(level.cameravec);
			temp_offset = 60 + VectorScale((0,0,-1));
			anglesoffset = VectorToAngles(temp_offset);
			model = spawn("script_origin",level.current_select_ent.v["origin"]);
			model setmodel("tag_origin");
			model.origin = level.current_select_ent.v["origin"];
			level.camera linkto(model,"tag_origin",level.cameravec,anglesoffset);
			break;
			wait(0.05);
		}
		level.camera unlink();
		wait(0.05);
	}
originoffset ? IsDefined(model) : model.origin != level.current_select_ent.v["origin"]
-1
IsDefined(level.current_select_ent)
(b_changes_z || b_changes_x || b_changes_y) ? 0.8 : VectorScale(movement)
1 ? level.camera_snapto > 0 : ((level.stick_camera ? -1 : ((originoffset ? level.camera_prev_snapto == level.camera_snapto : ((button_is_held("BUTTON_LTRIG") || button_is_held("BUTTON_RTRIG")) ? newmovement[1] <= -0.4 : newmovement[1] >= 0.4)) ? newmovement[0] <= -0.4 : newmovement[0] >= 0.4)) ? dolly_movement[0] <= -0.4 : dolly_movement[0] >= 0.4)
IsDefined(level.camera)
#/
}

//Function Number: 88
camera_hud_toggle(text)
{
	if(IsDefined(level.camera_hud))
	{
		level.camera_hud destroy();
	}

	level.camera_hud = newdebughudelem();
	level.camera_hud settext(text);
	level.camera_hud.horzalign = "left";
	level.camera_hud.vertalign = "bottom";
	level.camera_hud.alignx = "left";
	level.camera_hud.aligny = "bottom";
	level.camera_hud.foreground = 1;
	level.camera_hud.fontscale = 1.1;
	level.camera_hud.sort = 21;
	level.camera_hud.alpha = 1;
	level.camera_hud.color = (1,1,1);
}

//Function Number: 89
init_sp_paths()
{
}

//Function Number: 90
make_sp_player_invulnerable(player)
{
}

//Function Number: 91
delete_arrays_in_sp()
{
}

//Function Number: 92
used_in_animation(sp)
{
}

//Function Number: 93
init_client_sp_variables()
{
}

//Function Number: 94
init_mp_paths()
{
	level.cfx_server_scriptdata = "mpcreatefx/";
	level.cfx_client_scriptdata = "mpclientcreatefx/";
	level.cfx_server_loop = "maps\\mp\\_utility::createLoopEffect";
	level.cfx_server_oneshot = "maps\\mp\\_utility::createOneshotEffect";
	level.cfx_server_exploder = "maps\\mp\\_utility::createExploder";
	level.cfx_server_loopsound = "maps\\mp\\_createfx::createLoopSound";
	level.cfx_server_scriptgendump = "maps\\mp\\createfx\\" + level.script + "_fx::main();";
	level.cfx_client_loop = "clientscripts\\mp\\_fx::createLoopEffect";
	level.cfx_client_oneshot = "clientscripts\\mp\\_fx::createOneshotEffect";
	level.cfx_client_exploder = "clientscripts\\mp\\_fx::createExploder";
	level.cfx_client_loopsound = "clientscripts\\mp\\_fx::createLoopSound";
	level.cfx_client_scriptgendump = "clientscripts\\mp\\_createfx\\" + level.script + "_fx::main();";
	level.cfx_func_run_gump_func = ::empty;
	level.cfx_func_loopfx = maps/mp/_fx::loopfxthread;
	level.cfx_func_oneshotfx = maps/mp/_fx::oneshotfxthread;
	level.cfx_func_soundfx = maps/mp/_fx::create_loopsound;
	level.cfx_func_script_gen_dump = maps/mp/_script_gen::script_gen_dump;
	level.cfx_func_stop_loopsound = maps/mp/_fx::stop_loopsound;
	level.cfx_func_create_looper = maps/mp/_fx::create_looper;
	level.cfx_func_create_triggerfx = maps/mp/_fx::create_triggerfx;
	level.cfx_func_create_loopsound = maps/mp/_fx::create_loopsound;
}

//Function Number: 95
callback_playerconnect()
{
	self waittill("begin");
	if(!(IsDefined(level.hasspawned)))
	{
		spawnpoints = getentarray("mp_global_intermission","classname");
		if(!(spawnpoints.size))
		{
			spawnpoints = getentarray("info_player_start","classname");
		}

/#
		assert(spawnpoints.size);
#/
		spawnpoint = spawnpoints[0];
		self.sessionteam = "none";
		self.sessionstate = "playing";
		if(!(level.teambased))
		{
			self.ffateam = "none";
		}

		self spawn(spawnpoint.origin,spawnpoint.angles);
		level.player = self;
		level.hasspawned = 1;
	}
	else
	{
		kick(self.name);
	}
}

//Function Number: 96
delete_spawns()
{
	spawn_classes = [];
	spawn_classes[spawn_classes.size] = "mp_dm_spawn";
	spawn_classes[spawn_classes.size] = "mp_tdm_spawn";
	spawn_classes[spawn_classes.size] = "mp_dom_spawn";
	spawn_classes[spawn_classes.size] = "mp_dom_spawn_axis_start";
	spawn_classes[spawn_classes.size] = "mp_dom_spawn_allies_start";
	spawn_classes[spawn_classes.size] = "mp_res_spawn_allies";
	spawn_classes[spawn_classes.size] = "mp_res_spawn_axis";
	spawn_classes[spawn_classes.size] = "mp_res_spawn_axis_start";
	spawn_classes[spawn_classes.size] = "mp_dem_spawn_attacker";
	spawn_classes[spawn_classes.size] = "mp_dem_spawn_attacker_a";
	spawn_classes[spawn_classes.size] = "mp_dem_spawn_attacker_b";
	spawn_classes[spawn_classes.size] = "mp_dem_spawn_attacker_c";
	spawn_classes[spawn_classes.size] = "mp_dem_spawn_attacker_start";
	spawn_classes[spawn_classes.size] = "mp_dem_spawn_attackerOT_start";
	spawn_classes[spawn_classes.size] = "mp_dem_spawn_defender";
	spawn_classes[spawn_classes.size] = "mp_dem_spawn_defender_a";
	spawn_classes[spawn_classes.size] = "mp_dem_spawn_defender_b";
	spawn_classes[spawn_classes.size] = "mp_dem_spawn_defender_c";
	spawn_classes[spawn_classes.size] = "mp_dem_spawn_defender_start";
	spawn_classes[spawn_classes.size] = "mp_dem_spawn_defenderOT_start";
	foreach(class in spawn_classes)
	{
		spawns = getentarray(class,"classname");
		foreach(spawn in spawns)
		{
			spawn delete();
		}
	}
}

//Function Number: 97
createfxdelay()
{
	wait(10);
	level.createfx_delay_done = 1;
}

//Function Number: 98
init_client_mp_variables()
{
	level.cfx_exploder_before = maps/mp/_utility::exploder_before_load;
	level.cfx_exploder_after = maps/mp/_utility::exploder_after_load;
}