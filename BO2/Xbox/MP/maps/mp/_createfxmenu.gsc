/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_createfxmenu.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 35
 * Decompile Time: 8 ms
 * Timestamp: 10/28/2023 12:13:44 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_createfx;
#include maps/mp/_createfxundo;
#include maps/mp/_utility;

//Function Number: 1
menu(name)
{
/#
	return level.create_fx_menu == name;
#/
}

//Function Number: 2
setmenu(name)
{
/#
	level.create_fx_menu = name;
#/
}

//Function Number: 3
create_fx_menu()
{
/#
	if(button_is_clicked("escape","x"))
	{
		exit_menu();
		return;
	}

	if(menu("creation"))
	{
		if(button_is_clicked("1"))
		{
			setmenu("create_oneshot");
			draw_effects_list();
			return;
		}

		if(button_is_clicked("2"))
		{
			setmenu("create_loopfx");
			draw_effects_list();
			return;
		}

		if(button_is_clicked("3"))
		{
			setmenu("create_exploder");
			draw_effects_list();
			return;
		}

		if(button_is_clicked("4"))
		{
			setmenu("create_loopsound");
			ent = createloopsound();
			finish_creating_entity(ent);
			setmenu("none");
			return;
		}
	}

	if(menu("create_oneshot") || menu("create_loopfx") || menu("create_exploder") || menu("change_fxid"))
	{
		if(button_is_clicked("rightarrow"))
		{
			increment_list_offset();
			draw_effects_list();
		}

		if(button_is_clicked("leftarrow"))
		{
			decrement_list_offset();
			draw_effects_list();
		}

		menu_fx_creation();
	}
	else if(menu("none"))
	{
		menu_change_selected_fx();
		if(entities_are_selected())
		{
			display_fx_info(get_last_selected_entity());
			if(button_is_clicked("a"))
			{
				clear_settable_fx();
				setmenu("add_options");
			}
		}
	}
	else if(menu("add_options"))
	{
		if(!(entities_are_selected()))
		{
			clear_fx_hudelements();
			setmenu("none");
			return;
		}

		display_fx_add_options(get_last_selected_entity());
		if(button_is_clicked("rightarrow"))
		{
			increment_list_offset();
		}

		if(button_is_clicked("leftarrow"))
		{
			decrement_list_offset();
		}
	}
	else if(menu("jump_to_effect"))
	{
		if(button_is_clicked("rightarrow"))
		{
			increment_list_offset();
			draw_effects_list("Select effect to jump to:");
		}

		if(button_is_clicked("leftarrow"))
		{
			decrement_list_offset();
			draw_effects_list("Select effect to jump to:");
		}

		jump_to_effect();
	}
	else if(menu("select_by_property"))
	{
		menu_selection();
		if(button_is_clicked("rightarrow"))
		{
			increment_list_offset();
		}

		if(button_is_clicked("leftarrow"))
		{
			decrement_list_offset();
		}
	}
	else if(menu("change_type"))
	{
		if(!(entities_are_selected()))
		{
			clear_fx_hudelements();
			setmenu("none");
			return;
		}
		else
		{
			menu_fx_type();
		}
	}
#/
}

//Function Number: 4
exit_menu()
{
/#
	clear_fx_hudelements();
	clear_entity_selection();
	update_selected_entities();
	setmenu("none");
#/
}

//Function Number: 5
get_last_selected_entity()
{
/#
	return level.selected_fx_ents[level.selected_fx_ents.size - 1];
#/
}

//Function Number: 6
menu_fx_creation()
{
/#
	count = 0;
	picked_fx = undefined;
	keys = get_level_ambient_fx();
	for(i = level.effect_list_offset;i < keys.size;i++)
	{
		count = count + 1;
		button_to_check = count;
		if(button_to_check == 10)
		{
			button_to_check = 0;
		}

		if(button_is_clicked(button_to_check + "") && !button_is_held("f"))
		{
			picked_fx = keys[i];
			break;
		}

		if(count > level.effect_list_offset_max)
		{
			break;
		}
	}

	if(!(IsDefined(picked_fx)))
	{
		return;
	}

	if(menu("change_fxid"))
	{
		apply_option_to_selected_fx(get_option("fxid"),picked_fx);
		level.effect_list_offset = 0;
		clear_fx_hudelements();
		setmenu("none");
		return;
	}

	ent = undefined;
	if(menu("create_loopfx"))
	{
		ent = createloopeffect(picked_fx);
	}

	if(menu("create_oneshot"))
	{
		ent = createoneshoteffect(picked_fx);
		delay_min = GetDvarInt(#"72501C7");
		delay_max = GetDvarInt(#"A6DCBA49");
		if(delay_min > delay_max)
		{
			temp = delay_min;
			delay_min = delay_max;
			delay_max = temp;
		}

		ent.v["delay"] = randomintrange(delay_min,delay_max);
	}

	if(menu("create_exploder"))
	{
		ent = createexploder(picked_fx);
	}

	finish_creating_entity(ent);
	if(level.cfx_last_action != "none")
	{
		store_undo_state("edit",level.selected_fx_ents);
	}

	store_undo_state("add",level.createfxent[level.createfxent.size - 1]);
	level.cfx_last_action = "none";
	setmenu("none");
#/
}

//Function Number: 7
finish_creating_entity(ent)
{
/#
	ent.v["angles"] = VectorToAngles(100 + VectorScale((0,0,1)) - ent.v["origin"]);
/#
	assert(IsDefined(ent));
#/
	ent post_entity_creation_function();
	clear_entity_selection();
	select_last_entity("skip_undo");
	move_selection_to_cursor("skip_undo");
	update_selected_entities();
#/
}

//Function Number: 8
change_effect_to_oneshot(ent)
{
/#
	if(ent.v["type"] == "oneshotfx")
	{
		return;
	}

	if(ent.v["type"] == "exploder")
	{
		ent.v["exploder"] = undefined;
		ent.v["exploder_type"] = undefined;
		ent.v["soundalias"] = undefined;
	}

	if(!IsDefined(ent.v["delay"]) || ent.v["delay"] == 0)
	{
		delay_min = GetDvarInt(#"72501C7");
		delay_max = GetDvarInt(#"A6DCBA49");
		if(delay_min > delay_max)
		{
			temp = delay_min;
			delay_min = delay_max;
			delay_max = temp;
		}

		ent.v["delay"] = randomintrange(delay_min,delay_max);
	}

	ent.v["type"] = "oneshotfx";
#/
}

//Function Number: 9
change_effect_to_loop(ent)
{
/#
	if(ent.v["type"] == "loopfx")
	{
		return;
	}

	if(ent.v["type"] == "exploder")
	{
		ent.v["exploder"] = undefined;
		ent.v["exploder_type"] = undefined;
		ent.v["soundalias"] = undefined;
	}

	if(!IsDefined(ent.v["delay"]) || ent.v["delay"] <= 0)
	{
		ent.v["delay"] = 1;
	}

	ent.v["type"] = "loopfx";
#/
}

//Function Number: 10
change_effect_to_exploder(ent)
{
/#
	if(ent.v["type"] == "exploder")
	{
		return;
	}

	ent.v["type"] = "exploder";
	if(!IsDefined(ent.v["delay"]) || ent.v["delay"] < 0)
	{
		ent.v["delay"] = 0;
	}

	ent.v["exploder"] = 1;
	ent.v["exploder_type"] = "normal";
#/
}

//Function Number: 11
change_ent_type(newtype)
{
/#
	store_undo_state("edit",level.selected_fx_ents);
	level.cfx_last_action = "ent_type";
	if(newtype == "oneshotfx")
	{
		for(i = 0;i < level.selected_fx_ents.size;i++)
		{
			change_effect_to_oneshot(level.selected_fx_ents[i]);
		}
	}
	else if(newtype == "loopfx")
	{
		for(i = 0;i < level.selected_fx_ents.size;i++)
		{
			change_effect_to_loop(level.selected_fx_ents[i]);
		}
	}
	else if(newtype == "exploder")
	{
		for(i = 0;i < level.selected_fx_ents.size;i++)
		{
			change_effect_to_exploder(level.selected_fx_ents[i]);
		}
	}
#/
}

//Function Number: 12
menu_init()
{
/#
	level.createfx_options = [];
	addoption("string","type","Type","oneshotfx","fx");
	addoption("string","fxid","Name","nil","fx");
	addoption("vector","origin","Origin",(0,0,0),"fx");
	addoption("vector","angles","Angles",(0,0,0),"fx");
	addoption("float","delay","Repeat rate/start delay",0.5,"fx");
	addoption("int","repeat","Number of times to repeat",5,"exploder");
	addoption("float","primlightfrac","Primary light fraction",1,"fx");
	addoption("int","lightoriginoffs","Light origin offset",64,"fx");
	addoption("float","delay_min","Minimum time between repeats",1,"exploder");
	addoption("float","delay_max","Maximum time between repeats",2,"exploder");
	addoption("float","fire_range","Fire damage range",0,"fx");
	addoption("string","firefx","2nd FX id","nil","exploder");
	addoption("float","firefxdelay","2nd FX id repeat rate",0.5,"exploder");
	addoption("float","firefxtimeout","2nd FX timeout",5,"exploder");
	addoption("string","firefxsound","2nd FX soundalias","nil","exploder");
	addoption("string","ender","Level notify for ending 2nd FX","nil","exploder");
	addoption("string","rumble","Rumble","nil","exploder");
	addoption("float","damage","Radius damage",150,"exploder");
	addoption("float","damage_radius","Radius of radius damage",250,"exploder");
	addoption("int","exploder","Exploder",1,"exploder");
	addoption("string","earthquake","Earthquake","nil","exploder");
	addoption("string","soundalias","Soundalias","nil","all");
	addoption("int","stoppable","Can be stopped from script","1","all");
	level.effect_list_offset = 0;
	level.effect_list_offset_max = 9;
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
#/
}

//Function Number: 13
get_last_selected_ent()
{
/#
	return level.selected_fx_ents[level.selected_fx_ents.size - 1];
#/
}

//Function Number: 14
entities_are_selected()
{
/#
	return level.selected_fx_ents.size > 0;
#/
}

//Function Number: 15
menu_change_selected_fx()
{
/#
	if(!(level.selected_fx_ents.size))
	{
		return;
	}

	count = 0;
	drawncount = 0;
	ent = get_last_selected_ent();
	for(i = 0;i < level.createfx_options.size;i++)
	{
		option = level.createfx_options[i];
		if(!(IsDefined(ent.v[option["name"]])))
		{
		}
		else
		{
			count++;
			if(count < level.effect_list_offset)
			{
			}
			else
			{
				drawncount++;
				button_to_check = drawncount;
				if(button_to_check == 10)
				{
					button_to_check = 0;
				}

				if(button_is_clicked(button_to_check + "") && !button_is_held("f"))
				{
					prepare_option_for_change(option,drawncount);
					break;
				}

				if(drawncount > level.effect_list_offset_max)
				{
					break;
				}
			}
		}
	}
#/
}

//Function Number: 16
prepare_option_for_change(option,drawncount)
{
/#
	if(option["name"] == "fxid")
	{
		setmenu("change_fxid");
		draw_effects_list();
		return;
	}

	if(option["name"] == "type")
	{
		setmenu("change_type");
		return;
	}

	level.createfx_inputlocked = 1;
	set_option_index(option["name"]);
	setdvar("fx","nil");
	level.createfxhudelements[drawncount + 1][0].color = (1,1,0);
#/
}

//Function Number: 17
menu_fx_option_set()
{
/#
	if(GetDvar(#"5977E3") == "nil")
	{
		return;
	}

	option = get_selected_option();
	setting = undefined;
	if(option["type"] == "string")
	{
		setting = GetDvar(#"5977E3");
	}

	if(option["type"] == "int")
	{
		setting = GetDvarInt(#"5977E3");
	}

	if(option["type"] == "float")
	{
		setting = GetDvarFloat(#"5977E3");
	}

	if(option["type"] == "vector")
	{
		setting = GetDvar(#"5977E3");
		temparray = strtok(setting," ");
		if(temparray.size == 3)
		{
			setting = (float(temparray[0]),float(temparray[1]),float(temparray[2]));
		}
		else
		{
			clear_settable_fx();
			return;
		}
	}

	apply_option_to_selected_fx(option,setting);
#/
}

//Function Number: 18
menu_fx_type()
{
/#
	clear_fx_hudelements();
	set_fx_hudelement("Change effect type to:");
	set_fx_hudelement(" (1) Oneshot");
	set_fx_hudelement(" (2) Looped");
	set_fx_hudelement(" (3) Exploder");
	set_fx_hudelement("(x) Exit >");
	if(button_is_clicked("1") && !button_is_held("f"))
	{
		change_ent_type("oneshotfx");
		setmenu("none");
	}
	else if(button_is_clicked("2") && !button_is_held("f"))
	{
		change_ent_type("loopfx");
		setmenu("none");
	}
	else if(button_is_clicked("3") && !button_is_held("f"))
	{
		change_ent_type("exploder");
		setmenu("none");
	}

	if(menu("none"))
	{
		update_selected_entities();
	}
#/
}

//Function Number: 19
menu_selection()
{
/#
	clear_fx_hudelements();
	set_fx_hudelement("Select all by property:");
	drawncount = 0;
	option_number = 0;
	ent = level.selected_fx_ents[level.selected_fx_ents.size - 1];
	if(level.selected_fx_ents.size < 1)
	{
		set_fx_hudelement("No ent is selected.");
	}
	else
	{
		for(i = level.effect_list_offset;i < level.createfx_options.size;i++)
		{
			if(drawncount > level.effect_list_offset_max)
			{
				break;
			}

			if(drawncount > ent.v.size)
			{
				break;
			}

			prop_name = level.createfx_options[i]["name"];
			option_number = drawncount + 1;
			if(IsDefined(ent.v[prop_name]))
			{
				if(button_is_clicked(option_number + "") && !button_is_held("f"))
				{
					level.cfx_selected_prop = prop_name;
					menunone();
					level.effect_list_offset = 0;
					return;
				}

				prop_desc = level.createfx_options[i]["description"];
				set_fx_hudelement(option_number + ". " + prop_desc + ": " + ent.v[prop_name]);
				drawncount++;
			}
			else
			{
			}
		}
	}

	if(drawncount > level.effect_list_offset_max)
	{
		pages = ceil(ent.v.size / level.effect_list_offset_max);
		current_page = level.effect_list_offset / level.effect_list_offset_max + 1;
		set_fx_hudelement("(<-) Page " + current_page + " of " + pages + " (->)");
	}

	set_fx_hudelement("(x) Exit >");
#/
}

//Function Number: 20
apply_option_to_selected_fx(option,setting)
{
/#
	if(level.cfx_last_action != option["name"])
	{
		store_undo_state("edit",level.selected_fx_ents);
		level.cfx_last_action = option["name"];
	}

	for(i = 0;i < level.selected_fx_ents.size;i++)
	{
		ent = level.selected_fx_ents[i];
		if(mask(option["mask"],ent.v["type"]))
		{
			ent.v[option["name"]] = setting;
		}
	}

	update_selected_entities();
	clear_settable_fx();
#/
}

//Function Number: 21
set_option_index(name)
{
/#
	for(i = 0;i < level.createfx_options.size;i++)
	{
		if(level.createfx_options[i]["name"] != name)
		{
		}
		else
		{
			level.selected_fx_option_index = i;
			return;
		}
	}
#/
}

//Function Number: 22
get_selected_option()
{
/#
	return level.createfx_options[level.selected_fx_option_index];
#/
}

//Function Number: 23
mask(type,name)
{
/#
	return IsDefined(level.createfxmasks[type][name]);
#/
}

//Function Number: 24
addoption(type,name,description,defaultsetting,mask)
{
/#
	option = [];
	option["type"] = type;
	option["name"] = name;
	option["description"] = description;
	option["default"] = defaultsetting;
	option["mask"] = mask;
	level.createfx_options[level.createfx_options.size] = option;
#/
}

//Function Number: 25
get_option(name)
{
/#
	for(i = 0;i < level.createfx_options.size;i++)
	{
		if(level.createfx_options[i]["name"] == name)
		{
			return level.createfx_options[i];
		}
	}
#/
}

//Function Number: 26
display_fx_info(ent)
{
/#
	if(!(menu("none")))
	{
		return;
	}

	clear_fx_hudelements();
	if(!(level.createfx_draw_enabled))
	{
		return;
	}

	set_fx_hudelement("Selected: " + level.selected_fx_ents.size + "   Distance: " + get_distance_from_ent(ent));
	level.createfxhudelements[0][0].color = (1,1,0);
	set_fx_hudelement("Name: " + ent.v["fxid"]);
	if(entities_are_selected())
	{
		count = 0;
		drawncount = 0;
		for(i = 0;i < level.createfx_options.size;i++)
		{
			option = level.createfx_options[i];
			if(!(IsDefined(ent.v[option["name"]])))
			{
			}
			else
			{
				count++;
				if(count < level.effect_list_offset)
				{
				}
				else
				{
					drawncount++;
					set_fx_hudelement(drawncount + ". " + option["description"] + ": " + ent.v[option["name"]]);
					if(drawncount > level.effect_list_offset_max)
					{
						more = 1;
						break;
					}
				}
			}
		}

		if(count > level.effect_list_offset_max)
		{
			pages = ceil(level.createfx_options.size / level.effect_list_offset_max);
			current_page = level.effect_list_offset / level.effect_list_offset_max + 1;
			set_fx_hudelement("(<-) Page " + current_page + " of " + pages + " (->)");
		}

		set_fx_hudelement("(a) Add >");
		set_fx_hudelement("(x) Exit >");
	}
	else
	{
		set_fx_hudelement("Origin: " + ent.v["origin"]);
		set_fx_hudelement("Angles: " + ent.v["angles"]);
	}
#/
}

//Function Number: 27
display_fx_add_options(ent)
{
/#
/#
	assert(menu("add_options"));
#/
/#
	assert(entities_are_selected());
#/
	clear_fx_hudelements();
	set_fx_hudelement("Selected: " + level.selected_fx_ents.size + "   Distance: " + get_distance_from_ent(ent));
	level.createfxhudelements[0][0].color = (1,1,0);
	set_fx_hudelement("Name: " + ent.v["fxid"]);
	set_fx_hudelement("Origin: " + ent.v["origin"]);
	set_fx_hudelement("Angles: " + ent.v["angles"]);
	count = 0;
	drawncount = 0;
	if(level.effect_list_offset >= level.createfx_options.size)
	{
		level.effect_list_offset = 0;
	}

	for(i = 0;i < level.createfx_options.size;i++)
	{
		option = level.createfx_options[i];
		if(IsDefined(ent.v[option["name"]]))
		{
		}
		else if(!(mask(option["mask"],ent.v["type"])))
		{
		}
		else
		{
			count++;
			if(count < level.effect_list_offset)
			{
			}
			else if(drawncount >= level.effect_list_offset_max)
			{
			}
			else
			{
				drawncount++;
				button_to_check = drawncount;
				if(button_to_check == 10)
				{
					button_to_check = 0;
				}

				if(button_is_clicked(button_to_check + "") && !button_is_held("f"))
				{
					add_option_to_selected_entities(option);
					menunone();
					return;
				}

				set_fx_hudelement(button_to_check + ". " + option["description"]);
			}
		}
	}

	if(count > level.effect_list_offset_max)
	{
		pages = ceil(level.createfx_options.size / level.effect_list_offset_max);
		current_page = level.effect_list_offset / level.effect_list_offset_max + 1;
		set_fx_hudelement("(<-) Page " + current_page + " of " + pages + " (->)");
	}

	set_fx_hudelement("(x) Exit >");
#/
}

//Function Number: 28
add_option_to_selected_entities(option)
{
/#
	for(i = 0;i < level.selected_fx_ents.size;i++)
	{
		ent = level.selected_fx_ents[i];
		if(mask(option["mask"],ent.v["type"]))
		{
			ent.v[option["name"]] = option["default"];
		}
	}
#/
}

//Function Number: 29
menunone()
{
/#
	level.effect_list_offset = 0;
	clear_fx_hudelements();
	setmenu("none");
#/
}

//Function Number: 30
draw_effects_list(title)
{
/#
	clear_fx_hudelements();
	if(!(IsDefined(title)))
	{
		title = "Pick an effect:";
	}

	set_fx_hudelement(title);
	count = 0;
	more = 0;
	keys = get_level_ambient_fx();
	if(level.effect_list_offset >= keys.size)
	{
		level.effect_list_offset = 0;
	}
	else if(level.effect_list_offset < 0)
	{
		level.effect_list_offset = int(floor(keys.size / level.effect_list_offset_max) * level.effect_list_offset_max);
	}

	for(i = level.effect_list_offset;i < keys.size;i++)
	{
		count = count + 1;
		set_fx_hudelement(count + ". " + keys[i]);
		if(count >= level.effect_list_offset_max)
		{
			more = 1;
			break;
		}
	}

	if(keys.size > level.effect_list_offset_max)
	{
		pages = ceil(keys.size / level.effect_list_offset_max);
		current_page = level.effect_list_offset / level.effect_list_offset_max + 1;
		set_fx_hudelement("(<-) Page " + current_page + " of " + pages + " (->)");
	}
#/
}

//Function Number: 31
increment_list_offset()
{
/#
	level.effect_list_offset = level.effect_list_offset + level.effect_list_offset_max;
#/
}

//Function Number: 32
decrement_list_offset()
{
/#
	level.effect_list_offset = level.effect_list_offset - level.effect_list_offset_max;
#/
}

//Function Number: 33
jump_to_effect()
{
/#
	count = 0;
	picked_fxid = undefined;
	keys = get_level_ambient_fx();
	for(i = level.effect_list_offset;i < keys.size;i++)
	{
		count = count + 1;
		button_to_check = count;
		if(button_to_check == 10)
		{
			button_to_check = 0;
		}

		if(button_is_clicked(button_to_check + "") && !button_is_held("f"))
		{
			picked_fxid = keys[i];
			break;
		}

		if(count > level.effect_list_offset_max)
		{
			break;
		}
	}

	if(!(IsDefined(picked_fxid)))
	{
		return;
	}

	clear_entity_selection();
	ent = get_next_ent_with_same_id(-1,picked_fxid);
	if(IsDefined(ent))
	{
		level.cfx_next_ent = ent;
		move_player_to_next_same_effect(1);
	}
	else
	{
		iprintln("Effect " + picked_fxid + " has not been placed.");
	}

	level.effect_list_offset = 0;
	clear_fx_hudelements();
	setmenu("none");
#/
}

//Function Number: 34
get_level_ambient_fx()
{
/#
	if(!(IsDefined(level._effect_keys)))
	{
		keys = getarraykeys(level._effect);
		level._effect_keys = [];
		k = 0;
		for(i = 0;i < keys.size;i++)
		{
			if(issubstr(keys[i],"fx_"))
			{
				level._effect_keys[k] = keys[i];
				k++;
			}
		}

		if(level._effect_keys.size == 0)
		{
			level._effect_keys = keys;
		}
	}

	return level._effect_keys;
#/
}

//Function Number: 35
get_distance_from_ent(ent)
{
/#
	player = get_players()[0];
	return distance(player geteye(),ent.v["origin"]);
#/
}