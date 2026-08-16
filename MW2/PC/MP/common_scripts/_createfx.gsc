/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_createfx.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

createeffect(type, fxid)
{
	ent = spawnstruct();
	if(!isdefined(level.createfxent))
	{
		level.createfxent = [];
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

add_effect(name, effect)
{
	if(!isdefined(level._effect))
	{
		level._effect = [];
	}

	level._effect[name] = loadfx(effect);
}

createloopsound()
{
	ent = spawnstruct();
	if(!isdefined(level.createfxent))
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

createnewexploder()
{
	ent = spawnstruct();
	if(!isdefined(level.createfxent))
	{
		level.createfxent = [];
	}

	level.createfxent[level.createfxent.size] = ent;
	ent.v = [];
	ent.v["type"] = "exploder";
	ent.v["fxid"] = "No FX";
	ent.v["soundalias"] = "nil";
	ent.v["loopsound"] = "nil";
	ent.v["angles"] = (0,0,0);
	ent.v["origin"] = (0,0,0);
	ent.v["exploder"] = 1;
	ent.v["flag"] = "nil";
	ent.v["exploder_type"] = "normal";
	ent.drawn = 1;
	return ent;
}

set_forward_and_up_vectors()
{
	self.v["up"] = anglestoup(self.v["angles"]);
	self.v["forward"] = anglestoforward(self.v["angles"]);
}

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

	level.createfx_loopcounter = 0;
	triggers = getentarray("trigger_multiple", "classname");
	for(i = 0;i < triggers.size;i++)
	{
		triggers[i] delete();
	}

	triggers = getentarray("trigger_radius", "classname");
	for(i = 0;i < triggers.size;i++)
	{
		triggers[i] delete();
	}
}

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
	else if(getdvar("createfx_map") == level.script)
	{
		[[ level.func_position_player ]]();
	}

	level.createfxhudelements = [];
	level.createfx_hudelements = 30;
	stroffsetx = [];
	stroffsety = [];
	stroffsetx[0] = 0;
	stroffsety[0] = 0;
	stroffsetx[1] = 1;
	stroffsety[1] = 1;
	stroffsetx[2] = -2;
	stroffsety[2] = 1;
	stroffsetx[3] = 1;
	stroffsety[3] = -1;
	stroffsetx[4] = -2;
	stroffsety[4] = -1;
	crosshair = newhudelem();
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
	level.cleartextmarker = newhudelem();
	level.cleartextmarker.alpha = 0;
	level.cleartextmarker settext("marker");
	for(i = 0;i < level.createfx_hudelements;i++)
	{
		newstrarray = [];
		for(p = 0;p < 1;p++)
		{
			newstr = newhudelem();
			newstr.alignx = "left";
			newstr.location = 0;
			newstr.foreground = 1;
			newstr.fontscale = 1.4;
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

	newstrarray = [];
	for(p = 0;p < 5;p++)
	{
		newstr = newhudelem();
		newstr.alignx = "center";
		newstr.location = 0;
		newstr.foreground = 1;
		newstr.fontscale = 1.4;
		newstr.sort = 20 - p;
		newstr.alpha = 1;
		newstr.x = 320 + stroffsetx[p];
		newstr.y = 80 + stroffsety[p];
		if(p > 0)
		{
			newstr.color = (0,0,0);
		}

		newstrarray[newstrarray.size] = newstr;
	}

	level.createfx_centerprint = newstrarray;
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
	level.last_displayed_ent = undefined;
	level.buttonisheld = [];
	axismode = 0;
	lastplayerorigin = (0,0,0);
	if(!level.mp_createfx)
	{
		lastplayerorigin = level.player.origin;
	}

	colors = [];
	colors["loopfx"]["selected"] = (1,1,0.2);
	colors["loopfx"]["highlighted"] = (0.4,0.95,1);
	colors["loopfx"]["default"] = (0.3,0.8,1);
	colors["oneshotfx"]["selected"] = (1,1,0.2);
	colors["oneshotfx"]["highlighted"] = (0.4,0.95,1);
	colors["oneshotfx"]["default"] = (0.3,0.8,1);
	colors["exploder"]["selected"] = (1,1,0.2);
	colors["exploder"]["highlighted"] = (1,0.2,0.2);
	colors["exploder"]["default"] = (1,0.1,0.1);
	colors["rainfx"]["selected"] = (1,1,0.2);
	colors["rainfx"]["highlighted"] = (0.95,0.4,0.95);
	colors["rainfx"]["default"] = (0.78,0,0.73);
	colors["soundfx"]["selected"] = (1,1,0.2);
	colors["soundfx"]["highlighted"] = (0.5,1,0.75);
	colors["soundfx"]["default"] = (0.2,0.9,0.2);
	lasthighlightedent = undefined;
	level.fx_rotating = 0;
	common_scripts\_createfxmenu::setmenu("none");
	level.createfx_selecting = 0;
	black = newhudelem();
	black.x = -120;
	black.y = 200;
	black.foreground = 0;
	black setshader("black", 250, 160);
	black.alpha = 0;
	level.createfx_inputlocked = 0;
	for(i = 0;i < level.createfxent.size;i++)
	{
		ent = level.createfxent[i];
		ent post_entity_creation_function();
	}

	thread draw_distance();
	lastselectentity = undefined;
	thread createfx_autosave();
	for(;;)
	{
		changedselectedents = 0;
		right = anglestoright(level.player getplayerangles());
		forward = anglestoforward(level.player getplayerangles());
		up = anglestoup(level.player getplayerangles());
		dot = 0.85;
		placeent_vector = common_scripts\utility::vector_multiply(forward, 750);
		level.createfxcursor = bullettrace(level.player geteye(), level.player geteye() + placeent_vector, 0, undefined);
		highlightedent = undefined;
		level.buttonclick = [];
		level.button_is_kb = [];
		process_button_held_and_clicked();
		ctrlheld = button_is_held("ctrl", "BUTTON_LSHLDR");
		leftclick = button_is_clicked("mouse1", "BUTTON_A");
		leftheld = button_is_held("mouse1", "BUTTON_A");
		common_scripts\_createfxmenu::create_fx_menu();
		if(button_is_clicked("shift", "BUTTON_X"))
		{
			axismode = !axismode;
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

		if(button_is_clicked("end", "l"))
		{
			drop_selection_to_ground();
			changedselectedents = 1;
		}

		if(button_is_clicked("escape"))
		{
			clear_settable_fx();
		}

		if(button_is_clicked("space"))
		{
			set_off_exploders();
		}

		if(button_is_clicked("g"))
		{
			select_all_exploders_of_currently_selected("exploder");
			select_all_exploders_of_currently_selected("flag");
		}

		if(button_is_clicked("tab", "BUTTON_RSHLDR"))
		{
			move_selection_to_cursor();
			changedselectedents = 1;
		}

		if(button_is_held("h", "F1"))
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

		if(ctrlheld)
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

		if(isdefined(level.selected_fx_option_index))
		{
			common_scripts\_createfxmenu::menu_fx_option_set();
		}

		for(i = 0;i < level.createfxent.size;i++)
		{
			ent = level.createfxent[i];
			difference = vectornormalize(ent.v["origin"] - level.player.origin + (0,0,55));
			newdot = vectordot(forward, difference);
			if(newdot < dot)
			{
				continue;
			}

			dot = newdot;
			highlightedent = ent;
		}

		level.fx_highlightedent = highlightedent;
		if(isdefined(highlightedent))
		{
			if(isdefined(lasthighlightedent))
			{
				if(lasthighlightedent != highlightedent)
				{
					if(!ent_is_selected(lasthighlightedent))
					{
						lasthighlightedent thread entity_highlight_disable();
					}

					if(!ent_is_selected(highlightedent))
					{
						highlightedent thread entity_highlight_enable();
					}
				}
			}
			else if(!ent_is_selected(highlightedent))
			{
				highlightedent thread entity_highlight_enable();
			}
		}

		manipulate_createfx_ents(highlightedent, leftclick, leftheld, ctrlheld, colors, right);
		if(axismode && level.selected_fx_ents.size > 0)
		{
			thread [[ level.func_process_fx_rotater ]]();
			if(button_is_clicked("enter", "p"))
			{
				reset_axis_of_selected_ents();
			}

			if(button_is_clicked("v"))
			{
				copy_angles_of_selected_ents();
			}

			for(i = 0;i < level.selected_fx_ents.size;i++)
			{
				level.selected_fx_ents[i] draw_axis();
			}

			if(level.selectedrotate_pitch != 0 || level.selectedrotate_yaw != 0 || level.selectedrotate_roll != 0)
			{
				changedselectedents = 1;
			}

			wait 0.05;
		}
		else
		{
			selectedmove_vector = get_selected_move_vector();
			for(i = 0;i < level.selected_fx_ents.size;i++)
			{
				ent = level.selected_fx_ents[i];
				if(isdefined(ent.model))
				{
					continue;
				}

				ent.v["origin"] = ent.v["origin"] + selectedmove_vector;
			}

			if(distance((0,0,0), selectedmove_vector) > 0)
			{
				changedselectedents = 1;
			}

			wait 0.05;
		}

		if(changedselectedents)
		{
			update_selected_entities();
		}

		if(!level.mp_createfx)
		{
			lastplayerorigin = [[ level.func_position_player_get ]](lastplayerorigin);
		}

		lasthighlightedent = highlightedent;
		if(last_selected_entity_has_changed(lastselectentity))
		{
			level.effect_list_offset = 0;
			clear_settable_fx();
			common_scripts\_createfxmenu::setmenu("none");
		}

		if(level.selected_fx_ents.size)
		{
			lastselectentity = level.selected_fx_ents[level.selected_fx_ents.size - 1];
			continue;
		}

		lastselectentity = undefined;
	}
}

copy_angles_of_selected_ents()
{
	level notify("new_ent_selection");
	for(i = 0;i < level.selected_fx_ents.size;i++)
	{
		ent = level.selected_fx_ents[i];
		ent.v["angles"] = level.selected_fx_ents[level.selected_fx_ents.size - 1].v["angles"];
		ent set_forward_and_up_vectors();
	}

	update_selected_entities();
}

reset_axis_of_selected_ents()
{
	level notify("new_ent_selection");
	for(i = 0;i < level.selected_fx_ents.size;i++)
	{
		ent = level.selected_fx_ents[i];
		ent.v["angles"] = (0,0,0);
		ent set_forward_and_up_vectors();
	}

	update_selected_entities();
}

last_selected_entity_has_changed(lastselectentity)
{
	if(isdefined(lastselectentity))
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

	return lastselectentity != level.selected_fx_ents[level.selected_fx_ents.size - 1];
}

createfx_showorigin(id, org, delay, org2, type, exploder, id2, firefx, firefxdelay, firefxsound, fxsound, fxquake, fxdamage, soundalias, repeat, delay_min, delay_max, damage_radius, firefxtimeout)
{
}

drop_selection_to_ground()
{
	for(i = 0;i < level.selected_fx_ents.size;i++)
	{
		ent = level.selected_fx_ents[i];
		trace = bullettrace(ent.v["origin"], ent.v["origin"] + (0,0,-2048), 0, undefined);
		ent.v["origin"] = trace["position"];
	}
}

set_off_exploders()
{
	level notify("createfx_exploder_reset");
	exploders = [];
	for(i = 0;i < level.selected_fx_ents.size;i++)
	{
		ent = level.selected_fx_ents[i];
		if(isdefined(ent.v["exploder"]))
		{
			exploders[ent.v["exploder"]] = 1;
		}
	}

	keys = getarraykeys(exploders);
	for(i = 0;i < keys.size;i++)
	{
		common_scripts\utility::exploder(keys[i]);
	}
}

draw_distance()
{
	count = 0;
	if(getdvarint("createfx_drawdist") == 0)
	{
	}

	for(;;)
	{
		maxdist = getdvarint("createfx_drawdist");
		for(i = 0;i < level.createfxent.size;i++)
		{
			ent = level.createfxent[i];
			ent.drawn = distance(level.player.origin, ent.v["origin"]) <= maxdist;
			count++;
			if(count > 100)
			{
				count = 0;
				wait 0.05;
			}
		}

		if(level.createfxent.size == 0)
		{
			wait 0.05;
		}
	}
}

createfx_autosave()
{
	for(;;)
	{
		wait 300;
		common_scripts\utility::flag_waitopen("createfx_saving");
		generate_fx_log(1);
	}
}

rotate_over_time(org, rotater)
{
	level endon("new_ent_selection");
	timer = 0.1;
	for(p = 0;p < timer * 20;p++)
	{
		if(level.selectedrotate_pitch != 0)
		{
			org addpitch(level.selectedrotate_pitch);
		}
		else if(level.selectedrotate_yaw != 0)
		{
			org addyaw(level.selectedrotate_yaw);
		}
		else
		{
			org addroll(level.selectedrotate_roll);
		}

		wait 0.05;
		org draw_axis();
		for(i = 0;i < level.selected_fx_ents.size;i++)
		{
			ent = level.selected_fx_ents[i];
			if(isdefined(ent.model))
			{
				continue;
			}

			ent.v["origin"] = rotater[i].origin;
			ent.v["angles"] = rotater[i].angles;
		}
	}
}

delete_pressed()
{
	if(level.createfx_inputlocked)
	{
		remove_selected_option();
		return;
	}

	delete_selection();
}

remove_selected_option()
{
	if(!isdefined(level.selected_fx_option_index))
	{
		return;
	}

	name = level.createfx_options[level.selected_fx_option_index]["name"];
	for(i = 0;i < level.createfxent.size;i++)
	{
		ent = level.createfxent[i];
		if(!ent_is_selected(ent))
		{
			continue;
		}

		ent remove_option(name);
	}

	update_selected_entities();
	clear_settable_fx();
}

remove_option(name)
{
	self.v[name] = undefined;
}

delete_selection()
{
	newarray = [];
	for(i = 0;i < level.createfxent.size;i++)
	{
		ent = level.createfxent[i];
		if(ent_is_selected(ent))
		{
			if(isdefined(ent.looper))
			{
				ent.looper delete();
			}

			ent notify("stop_loop");
			continue;
		}

		newarray[newarray.size] = ent;
	}

	level.createfxent = newarray;
	level.selected_fx = [];
	level.selected_fx_ents = [];
	clear_fx_hudelements();
}

move_selection_to_cursor()
{
	origin = level.createfxcursor["position"];
	if(level.selected_fx_ents.size <= 0)
	{
		return;
	}

	center = get_center_of_array(level.selected_fx_ents);
	difference = center - origin;
	for(i = 0;i < level.selected_fx_ents.size;i++)
	{
		ent = level.selected_fx_ents[i];
		if(isdefined(ent.model))
		{
			continue;
		}

		ent.v["origin"] = ent.v["origin"] - difference;
	}
}

insert_effect()
{
	common_scripts\_createfxmenu::setmenu("creation");
	level.effect_list_offset = 0;
	clear_fx_hudelements();
	set_fx_hudelement("Pick effect type to create:");
	set_fx_hudelement("1. One Shot fx");
	set_fx_hudelement("2. Looping fx");
	set_fx_hudelement("3. Looping sound");
	set_fx_hudelement("4. Exploder");
	set_fx_hudelement("(c) Cancel");
	set_fx_hudelement("(x) Exit");
}

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

select_last_entity()
{
	select_entity(level.createfxent.size - 1, level.createfxent[level.createfxent.size - 1]);
}

select_all_exploders_of_currently_selected(key)
{
	selected_exploders = [];
	foreach(ent in level.selected_fx_ents)
	{
		if(!isdefined(ent.v[key]))
		{
			continue;
		}

		value = ent.v[key];
		selected_exploders[value] = 1;
	}

	foreach(value, _ in selected_exploders)
	{
		foreach(index, ent in level.createfxent)
		{
			if(index_is_selected(index))
			{
				continue;
			}

			if(!isdefined(ent.v[key]))
			{
				continue;
			}

			if(ent.v[key] != value)
			{
				continue;
			}

			select_entity(index, ent);
		}
	}

	update_selected_entities();
}

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

post_entity_creation_function()
{
	self.textalpha = 0;
	self.drawn = 1;
}

paste_ents()
{
	if(!isdefined(level.stored_ents))
	{
		return;
	}

	clear_entity_selection();
	for(i = 0;i < level.stored_ents.size;i++)
	{
		add_and_select_entity(level.stored_ents[i]);
	}

	move_selection_to_cursor();
	update_selected_entities();
	level.stored_ents = [];
	copy_ents();
}

add_and_select_entity(ent)
{
	level.createfxent[level.createfxent.size] = ent;
	select_last_entity();
}

get_center_of_array(array)
{
	center = (0,0,0);
	for(i = 0;i < array.size;i++)
	{
		center = (center[0] + array[i].v["origin"][0],center[1] + array[i].v["origin"][1],center[2] + array[i].v["origin"][2]);
	}

	return (center[0] / array.size,center[1] / array.size,center[2] / array.size);
}

ent_draw_axis()
{
	self endon("death");
	for(;;)
	{
		draw_axis();
		wait 0.05;
	}
}

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

print_fx_options(ent, tab, file, autosave)
{
	for(i = 0;i < level.createfx_options.size;i++)
	{
		option = level.createfx_options[i];
		if(!isdefined(ent.v[option["name"]]))
		{
			continue;
		}

		if(!common_scripts\_createfxmenu::mask(option["mask"], ent.v["type"]))
		{
			continue;
		}

		if(option["type"] == "string")
		{
			cfxprintln(file, tab + "ent.v[ \"" + option["name"] + "\" ] = \"" + ent.v[option["name"]] + "\";");
			continue;
		}

		cfxprintln(file, tab + "ent.v[ \"" + option["name"] + "\" ] = " + ent.v[option["name"]] + ";");
	}
}

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

		wait 0.05;
	}

	self.textalpha = 0;
}

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

		wait 0.05;
	}

	self.textalpha = 1;
}

toggle_createfx_drawing()
{
	level.createfx_draw_enabled = !level.createfx_draw_enabled;
}

manipulate_createfx_ents(highlightedent, leftclick, leftheld, ctrlheld, colors, right)
{
	if(!level.createfx_draw_enabled)
	{
		return;
	}

	for(i = 0;i < level.createfxent.size;i++)
	{
		ent = level.createfxent[i];
		if(!ent.drawn)
		{
			continue;
		}

		scale = getdvarfloat("createfx_scaleid");
		if(isdefined(highlightedent) && ent == highlightedent)
		{
			if(!common_scripts\_createfxmenu::entities_are_selected())
			{
				common_scripts\_createfxmenu::display_fx_info(ent);
			}

			if(leftclick)
			{
				entwasselected = index_is_selected(i);
				level.createfx_selecting = !entwasselected;
				if(!ctrlheld)
				{
					selectedsize = level.selected_fx_ents.size;
					clear_entity_selection();
					if(entwasselected && selectedsize == 1)
					{
						select_entity(i, ent);
					}
				}

				toggle_entity_selection(i, ent);
			}
			else if(leftheld)
			{
				if(ctrlheld)
				{
					if(level.createfx_selecting)
					{
						select_entity(i, ent);
					}

					if(!level.createfx_selecting)
					{
						deselect_entity(i, ent);
					}
				}
			}

			colorindex = "highlighted";
			if(index_is_selected(i))
			{
				colorindex = "selected";
			}

			if(ent.textalpha > 0)
			{
				printright = common_scripts\utility::vector_multiply(right, ent.v["fxid"].size * -2.93 * scale);
			}

			continue;
		}

		colorindex = "default";
		if(index_is_selected(i))
		{
			colorindex = "selected";
		}

		if(ent.textalpha > 0)
		{
			printright = common_scripts\utility::vector_multiply(right, ent.v["fxid"].size * -2.93);
		}
	}
}

clear_settable_fx()
{
	level.createfx_inputlocked = 0;
	level.selected_fx_option_index = undefined;
	reset_fx_hud_colors();
}

reset_fx_hud_colors()
{
	for(i = 0;i < level.createfx_hudelements;i++)
	{
		level.createfxhudelements[i][0].color = (1,1,1);
	}
}

button_is_held(name, name2)
{
	if(isdefined(name2))
	{
		if(isdefined(level.buttonisheld[name2]))
		{
			return 1;
		}
	}

	return isdefined(level.buttonisheld[name]);
}

button_is_clicked(name, name2)
{
	if(isdefined(name2))
	{
		if(isdefined(level.buttonclick[name2]))
		{
			return 1;
		}
	}

	return isdefined(level.buttonclick[name]);
}

toggle_entity_selection(index, ent)
{
	if(isdefined(level.selected_fx[index]))
	{
		deselect_entity(index, ent);
		return;
	}

	select_entity(index, ent);
}

select_entity(index, ent)
{
	if(isdefined(level.selected_fx[index]))
	{
		return;
	}

	clear_settable_fx();
	level notify("new_ent_selection");
	ent thread entity_highlight_enable();
	level.selected_fx[index] = 1;
	level.selected_fx_ents[level.selected_fx_ents.size] = ent;
}

ent_is_highlighted(ent)
{
	if(!isdefined(level.fx_highlightedent))
	{
		return 0;
	}

	return ent == level.fx_highlightedent;
}

deselect_entity(index, ent)
{
	if(!isdefined(level.selected_fx[index]))
	{
		return;
	}

	clear_settable_fx();
	level notify("new_ent_selection");
	level.selected_fx[index] = undefined;
	if(!ent_is_highlighted(ent))
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

index_is_selected(index)
{
	return isdefined(level.selected_fx[index]);
}

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

clear_entity_selection()
{
	for(i = 0;i < level.selected_fx_ents.size;i++)
	{
		if(!ent_is_highlighted(level.selected_fx_ents[i]))
		{
			level.selected_fx_ents[i] thread entity_highlight_disable();
		}
	}

	level.selected_fx = [];
	level.selected_fx_ents = [];
}

draw_axis()
{
	range = 25 * getdvarfloat("createfx_scaleid");
	forward = anglestoforward(self.v["angles"]);
	forward = common_scripts\utility::vector_multiply(forward, range);
	right = anglestoright(self.v["angles"]);
	right = common_scripts\utility::vector_multiply(right, range);
	up = anglestoup(self.v["angles"]);
	up = common_scripts\utility::vector_multiply(up, range);
}

clear_fx_hudelements()
{
	level.cleartextmarker clearalltextafterhudelem();
	for(i = 0;i < level.createfx_hudelements;i++)
	{
		for(p = 0;p < 1;p++)
		{
			level.createfxhudelements[i][p] settext("");
		}
	}

	level.fxhudelements = 0;
}

set_fx_hudelement(text)
{
	for(p = 0;p < 1;p++)
	{
		level.createfxhudelements[level.fxhudelements][p] settext(text);
	}

	level.fxhudelements++;
}

createfx_centerprint(text)
{
	thread createfx_centerprint_thread(text);
}

createfx_centerprint_thread(text)
{
	level notify("new_createfx_centerprint");
	level endon("new_createfx_centerprint");
	for(p = 0;p < 5;p++)
	{
		level.createfx_centerprint[p] settext(text);
	}

	wait 4.5;
	for(p = 0;p < 5;p++)
	{
		level.createfx_centerprint[p] settext("");
	}
}

buttondown(button, button2)
{
	return buttonpressed_internal(button) || buttonpressed_internal(button2);
}

buttonpressed_internal(button)
{
	if(!isdefined(button))
	{
		return 0;
	}

	if(kb_locked(button))
	{
		return 0;
	}

	return level.player method_00F9(button);
}

get_selected_move_vector()
{
	yaw = level.player getplayerangles()[1];
	angles = (0,yaw,0);
	right = anglestoright(angles);
	forward = anglestoforward(angles);
	up = anglestoup(angles);
	keypressed = 0;
	rate = 1;
	if(buttondown("kp_uparrow", "DPAD_UP"))
	{
		if(level.selectedmove_forward < 0)
		{
			level.selectedmove_forward = 0;
		}

		level.selectedmove_forward = level.selectedmove_forward + rate;
	}
	else if(buttondown("kp_downarrow", "DPAD_DOWN"))
	{
		if(level.selectedmove_forward > 0)
		{
			level.selectedmove_forward = 0;
		}

		level.selectedmove_forward = level.selectedmove_forward - rate;
	}
	else
	{
		level.selectedmove_forward = 0;
	}

	if(buttondown("kp_rightarrow", "DPAD_RIGHT"))
	{
		if(level.selectedmove_right < 0)
		{
			level.selectedmove_right = 0;
		}

		level.selectedmove_right = level.selectedmove_right + rate;
	}
	else if(buttondown("kp_leftarrow", "DPAD_LEFT"))
	{
		if(level.selectedmove_right > 0)
		{
			level.selectedmove_right = 0;
		}

		level.selectedmove_right = level.selectedmove_right - rate;
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

		level.selectedmove_up = level.selectedmove_up + rate;
	}
	else if(buttondown("BUTTON_B"))
	{
		if(level.selectedmove_up > 0)
		{
			level.selectedmove_up = 0;
		}

		level.selectedmove_up = level.selectedmove_up - rate;
	}
	else
	{
		level.selectedmove_up = 0;
	}

	vector = (0,0,0);
	vector = vector + common_scripts\utility::vector_multiply(forward, level.selectedmove_forward);
	vector = vector + common_scripts\utility::vector_multiply(right, level.selectedmove_right);
	vector = vector + common_scripts\utility::vector_multiply(up, level.selectedmove_up);
	return vector;
}

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

locked(name)
{
	if(isdefined(level.createfx_lockedlist[name]))
	{
		return 0;
	}

	return kb_locked(name);
}

kb_locked(name)
{
	return level.createfx_inputlocked && isdefined(level.button_is_kb[name]);
}

add_button(name)
{
	if(locked(name))
	{
		return;
	}

	if(!isdefined(level.buttonisheld[name]))
	{
		if(level.player method_00F9(name))
		{
			level.buttonisheld[name] = 1;
			level.buttonclick[name] = 1;
			return;
		}

		return;
	}

	if(!level.player method_00F9(name))
	{
		level.buttonisheld[name] = undefined;
		return;
	}
}

add_kb_button(name)
{
	level.button_is_kb[name] = 1;
	add_button(name);
}

set_anglemod_move_vector()
{
	rate = 2;
	if(buttondown("kp_uparrow", "DPAD_UP"))
	{
		if(level.selectedrotate_pitch < 0)
		{
			level.selectedrotate_pitch = 0;
		}

		level.selectedrotate_pitch = level.selectedrotate_pitch + rate;
	}
	else if(buttondown("kp_downarrow", "DPAD_DOWN"))
	{
		if(level.selectedrotate_pitch > 0)
		{
			level.selectedrotate_pitch = 0;
		}

		level.selectedrotate_pitch = level.selectedrotate_pitch - rate;
	}
	else
	{
		level.selectedrotate_pitch = 0;
	}

	if(buttondown("kp_leftarrow", "DPAD_LEFT"))
	{
		if(level.selectedrotate_yaw < 0)
		{
			level.selectedrotate_yaw = 0;
		}

		level.selectedrotate_yaw = level.selectedrotate_yaw + rate;
	}
	else if(buttondown("kp_rightarrow", "DPAD_RIGHT"))
	{
		if(level.selectedrotate_yaw > 0)
		{
			level.selectedrotate_yaw = 0;
		}

		level.selectedrotate_yaw = level.selectedrotate_yaw - rate;
	}
	else
	{
		level.selectedrotate_yaw = 0;
	}

	if(buttondown("BUTTON_Y"))
	{
		if(level.selectedrotate_roll < 0)
		{
			level.selectedrotate_roll = 0;
		}

		level.selectedrotate_roll = level.selectedrotate_roll + rate;
		return;
	}

	if(buttondown("BUTTON_B"))
	{
		if(level.selectedrotate_roll > 0)
		{
			level.selectedrotate_roll = 0;
		}

		level.selectedrotate_roll = level.selectedrotate_roll - rate;
		return;
	}

	level.selectedrotate_roll = 0;
}

cfxprintlnstart()
{
	common_scripts\utility::fileprint_launcher_start_file();
}

cfxprintln(file, string)
{
	common_scripts\utility::fileprint_launcher(string);
	if(file == -1)
	{
		return;
	}
}

cfxprintlnend(file, autosave, radiant_exploder_add_string)
{
	bp4add = 1;
	if(radiant_exploder_add_string != "" || autosave)
	{
		bp4add = 0;
	}

	scriptname = level.script + radiant_exploder_add_string + "_fx.gsc";
	if(autosave)
	{
		scriptname = "backup.gsc";
	}

	common_scripts\utility::fileprint_launcher_end_file("/share/raw/maps/createfx/" + scriptname, bp4add);
}

update_selected_entities()
{
	for(i = 0;i < level.selected_fx_ents.size;i++)
	{
		ent = level.selected_fx_ents[i];
		ent [[ level.func_updatefx ]]();
	}
}

hack_start(painter_spmp)
{
	if(!isdefined(painter_spmp))
	{
		painter_spmp = "painter_mp";
	}

	precachemenu(painter_spmp);
	if(painter_spmp == "painter_mp")
	{
		return;
	}

	wait 0.05;
	level.player openpopupmenu(painter_spmp);
	level.player closepopupmenu(painter_spmp);
}

get_player()
{
	return getentarray("player", "classname")[0];
}

createfx_orgranize_array()
{
	types = [];
	types[0] = "soundfx";
	types[1] = "loopfx";
	types[2] = "oneshotfx";
	types[3] = "exploder";
	array = [];
	foreach(index, _ in types)
	{
		array[index] = [];
	}

	foreach(ent in level.createfxent)
	{
		found_type = 0;
		foreach(index, type in types)
		{
			if(ent.v["type"] != type)
			{
				continue;
			}

			found_type = 1;
			array[index][array[index].size] = ent;
			break;
		}
	}

	new_array = [];
	for(i = 0;i < types.size;i++)
	{
		foreach(ent in array[i])
		{
			new_array[new_array.size] = ent;
		}
	}

	level.createfxent = new_array;
}

stop_fx_looper()
{
	if(isdefined(self.looper))
	{
		self.looper delete();
	}

	stop_loopsound();
}

stop_loopsound()
{
	self notify("stop_loop");
}

func_get_level_fx()
{
	if(!isdefined(level._effect_keys))
	{
		keys = getarraykeys(level._effect);
	}
	else
	{
		keys = getarraykeys(level._effect);
		if(keys.size == level._effect_keys.size)
		{
			return level._effect_keys;
		}
	}

	keys = common_scripts\utility::alphabetize(keys);
	level._effect_keys = keys;
	return keys;
}

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
		return;
	}
}

process_fx_rotater()
{
	if(level.fx_rotating)
	{
		return;
	}

	set_anglemod_move_vector();
	if(!rotation_is_occuring())
	{
		return;
	}

	level.fx_rotating = 1;
	if(level.selected_fx_ents.size > 1)
	{
		center = get_center_of_array(level.selected_fx_ents);
		org = spawn("script_origin", center);
		org.v["angles"] = level.selected_fx_ents[0].v["angles"];
		org.v["origin"] = center;
		rotater = [];
		for(i = 0;i < level.selected_fx_ents.size;i++)
		{
			rotater[i] = spawn("script_origin", level.selected_fx_ents[i].v["origin"]);
			rotater[i].angles = level.selected_fx_ents[i].v["angles"];
			rotater[i] linkto(org);
		}

		rotate_over_time(org, rotater);
		org delete();
		for(i = 0;i < rotater.size;i++)
		{
			rotater[i] delete();
		}
	}
	else if(level.selected_fx_ents.size == 1)
	{
		ent = level.selected_fx_ents[0];
		rotater = spawn("script_origin", (0,0,0));
		rotater.angles = ent.v["angles"];
		if(level.selectedrotate_pitch != 0)
		{
			rotater addpitch(level.selectedrotate_pitch);
		}
		else if(level.selectedrotate_yaw != 0)
		{
			rotater addyaw(level.selectedrotate_yaw);
		}
		else
		{
			rotater addroll(level.selectedrotate_roll);
		}

		ent.v["angles"] = rotater.angles;
		rotater delete();
		wait 0.05;
	}

	level.fx_rotating = 0;
}

generate_fx_log(autosave)
{
}