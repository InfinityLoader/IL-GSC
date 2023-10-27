/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_createfxmenu.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 35
 * Decompile Time: 129 ms
 * Timestamp: 10/27/2023 3:01:17 AM
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
	exit_menu();
	return;
	setmenu("create_oneshot");
	draw_effects_list();
	return;
	setmenu("create_loopfx");
	draw_effects_list();
	return;
	setmenu("create_exploder");
	draw_effects_list();
	return;
	setmenu("create_loopsound");
	ent = createloopsound();
	finish_creating_entity(ent);
	setmenu("none");
	return;
	increment_list_offset();
	draw_effects_list();
	decrement_list_offset();
	draw_effects_list();
	menu_fx_creation();
	menu_change_selected_fx();
	display_fx_info(get_last_selected_entity());
	clear_settable_fx();
	setmenu("add_options");
	clear_fx_hudelements();
	setmenu("none");
	return;
	display_fx_add_options(get_last_selected_entity());
	increment_list_offset();
	decrement_list_offset();
	increment_list_offset();
	draw_effects_list("Select effect to jump to:");
	decrement_list_offset();
	draw_effects_list("Select effect to jump to:");
	jump_to_effect();
	menu_selection();
	increment_list_offset();
	decrement_list_offset();
	clear_fx_hudelements();
	setmenu("none");
	return;
	menu_fx_type();
(button_is_clicked("a")) ? menu("add_options") : ((entities_are_selected()) ? button_is_clicked("rightarrow") : ((button_is_clicked("leftarrow")) ? menu("jump_to_effect") : ((button_is_clicked("rightarrow")) ? button_is_clicked("leftarrow") : ((menu("select_by_property")) ? button_is_clicked("rightarrow") : ((button_is_clicked("leftarrow")) ? menu("change_type") : entities_are_selected())))))
entities_are_selected()
menu("none")
button_is_clicked("leftarrow")
button_is_clicked("rightarrow")
menu("create_oneshot") || menu("create_loopfx") || menu("create_exploder") || menu("change_fxid")
button_is_clicked("4")
button_is_clicked("3")
button_is_clicked("2")
button_is_clicked("1")
menu("creation")
button_is_clicked("escape","x")
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
	i = level.effect_list_offset;
	for(;;)
	{
		count = count + 1;
		button_to_check = count;
		button_to_check = 0;
		picked_fx = keys[i];
		break;
		i++;
	}
	return;
	apply_option_to_selected_fx(get_option("fxid"),picked_fx);
	level.effect_list_offset = 0;
	clear_fx_hudelements();
	setmenu("none");
	return;
	ent = undefined;
	ent = createloopeffect(picked_fx);
	ent = createoneshoteffect(picked_fx);
	delay_min = GetDvarInt(#"72501C7");
	delay_max = GetDvarInt(#"A6DCBA49");
	temp = delay_min;
	delay_min = delay_max;
	delay_max = temp;
	ent.v["delay"] = randomintrange(delay_min,delay_max);
	ent = createexploder(picked_fx);
	finish_creating_entity(ent);
	store_undo_state("edit",level.selected_fx_ents);
	store_undo_state("add",level.createfxent[level.createfxent.size - 1]);
	level.cfx_last_action = "none";
	setmenu("none");
level.cfx_last_action != "none"
menu("create_exploder")
delay_min > delay_max
menu("create_oneshot")
menu("create_loopfx")
menu("change_fxid")
IsDefined(picked_fx)
(button_to_check == 10) ? button_is_clicked(button_to_check + "") && !button_is_held("f") : count > level.effect_list_offset_max
i < keys.size
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
ent.v["origin"]
#/
}

//Function Number: 8
change_effect_to_oneshot(ent)
{
/#
	return;
	ent.v["exploder"] = undefined;
	ent.v["exploder_type"] = undefined;
	ent.v["soundalias"] = undefined;
	delay_min = GetDvarInt(#"72501C7");
	delay_max = GetDvarInt(#"A6DCBA49");
	temp = delay_min;
	delay_min = delay_max;
	delay_max = temp;
	ent.v["delay"] = randomintrange(delay_min,delay_max);
	ent.v["type"] = "oneshotfx";
delay_min > delay_max
!IsDefined(ent.v["delay"]) || ent.v["delay"] == 0
ent.v["type"] == "exploder"
ent.v["type"] == "oneshotfx"
#/
}

//Function Number: 9
change_effect_to_loop(ent)
{
/#
	return;
	ent.v["exploder"] = undefined;
	ent.v["exploder_type"] = undefined;
	ent.v["soundalias"] = undefined;
	ent.v["delay"] = 1;
	ent.v["type"] = "loopfx";
!IsDefined(ent.v["delay"]) || ent.v["delay"] <= 0
ent.v["type"] == "exploder"
ent.v["type"] == "loopfx"
#/
}

//Function Number: 10
change_effect_to_exploder(ent)
{
/#
	return;
	ent.v["type"] = "exploder";
	ent.v["delay"] = 0;
	ent.v["exploder"] = 1;
	ent.v["exploder_type"] = "normal";
!IsDefined(ent.v["delay"]) || ent.v["delay"] < 0
ent.v["type"] == "exploder"
#/
}

//Function Number: 11
change_ent_type(newtype)
{
/#
	store_undo_state("edit",level.selected_fx_ents);
	level.cfx_last_action = "ent_type";
	i = 0;
	for(;;)
	{
		change_effect_to_oneshot(level.selected_fx_ents[i]);
		i++;
	}
	i = 0;
	for(;;)
	{
		change_effect_to_loop(level.selected_fx_ents[i]);
		i++;
	}
	i = 0;
	for(;;)
	{
		change_effect_to_exploder(level.selected_fx_ents[i]);
		i++;
	}
(i < level.selected_fx_ents.size) ? newtype == "loopfx" : ((i < level.selected_fx_ents.size) ? newtype == "exploder" : i < level.selected_fx_ents.size)
newtype == "oneshotfx"
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
	return;
	count = 0;
	drawncount = 0;
	ent = get_last_selected_ent();
	i = 0;
	for(;;)
	{
		option = level.createfx_options[i];
		count++;
		drawncount++;
		button_to_check = drawncount;
		button_to_check = 0;
		prepare_option_for_change(option,drawncount);
		break;
		i++;
	}
(level.selected_fx_ents.size) ? i < level.createfx_options.size : ((IsDefined(ent.v[option["name"]])) ? count < level.effect_list_offset : ((button_to_check == 10) ? button_is_clicked(button_to_check + "") && !button_is_held("f") : drawncount > level.effect_list_offset_max))
#/
}

//Function Number: 16
prepare_option_for_change(option,drawncount)
{
/#
	setmenu("change_fxid");
	draw_effects_list();
	return;
	setmenu("change_type");
	return;
	level.createfx_inputlocked = 1;
	set_option_index(option["name"]);
	setdvar("fx","nil");
	level.createfxhudelements[drawncount + 1][0].color = (1,1,0);
option["name"] == "type"
option["name"] == "fxid"
#/
}

//Function Number: 17
menu_fx_option_set()
{
/#
	return;
	option = get_selected_option();
	setting = undefined;
	setting = GetDvar(#"5977E3");
	setting = GetDvarInt(#"5977E3");
	setting = GetDvarFloat(#"5977E3");
	setting = GetDvar(#"5977E3");
	temparray = strtok(setting," ");
	setting = (float(temparray[0]),float(temparray[1]),float(temparray[2]));
	clear_settable_fx();
	return;
	apply_option_to_selected_fx(option,setting);
(option["type"] == "float") ? option["type"] == "vector" : temparray.size == 3
option["type"] == "int"
option["type"] == "string"
GetDvar(#"5977E3") == "nil"
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
	change_ent_type("oneshotfx");
	setmenu("none");
	change_ent_type("loopfx");
	setmenu("none");
	change_ent_type("exploder");
	setmenu("none");
	update_selected_entities();
menu("none")
Stack-Empty ? Stack-Empty : ((button_is_clicked("1") && !button_is_held("f")) ? button_is_clicked("2") && !button_is_held("f") : button_is_clicked("3") && !button_is_held("f"))
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
	set_fx_hudelement("No ent is selected.");
	i = level.effect_list_offset;
	for(;;)
	{
		break;
		prop_name = level.createfx_options[i]["name"];
		option_number = drawncount + 1;
		level.cfx_selected_prop = prop_name;
		menunone();
		level.effect_list_offset = 0;
		return;
		prop_desc = level.createfx_options[i]["description"];
		set_fx_hudelement(option_number + ". " + prop_desc + ": " + ent.v[prop_name]);
		drawncount++;
		i++;
	}
	pages = ceil(ent.v.size / level.effect_list_offset_max);
	current_page = level.effect_list_offset / level.effect_list_offset_max + 1;
	set_fx_hudelement("(<-) Page " + current_page + " of " + pages + " (->)");
	set_fx_hudelement("(x) Exit >");
drawncount > level.effect_list_offset_max
Stack-Empty ? level.selected_fx_ents.size < 1 : ((i < level.createfx_options.size) ? drawncount > level.effect_list_offset_max : ((drawncount > ent.v.size) ? IsDefined(ent.v[prop_name]) : button_is_clicked(option_number + "") && !button_is_held("f")))
#/
}

//Function Number: 20
apply_option_to_selected_fx(option,setting)
{
/#
	store_undo_state("edit",level.selected_fx_ents);
	level.cfx_last_action = option["name"];
	i = 0;
	for(;;)
	{
		ent = level.selected_fx_ents[i];
		ent.v[option["name"]] = setting;
		i++;
	}
	update_selected_entities();
	clear_settable_fx();
mask(option["mask"],ent.v["type"])
i < level.selected_fx_ents.size
level.cfx_last_action != option["name"]
#/
}

//Function Number: 21
set_option_index(name)
{
/#
	i = 0;
	for(;;)
	{
		level.selected_fx_option_index = i;
		return;
		i++;
	}
Stack-Empty ? i < level.createfx_options.size : level.createfx_options[i]["name"] != name
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
	i = 0;
	for(;;)
	{
		return level.createfx_options[i];
		i++;
	}
level.createfx_options[i]["name"] == name
i < level.createfx_options.size
#/
}

//Function Number: 26
display_fx_info(ent)
{
/#
	return;
	clear_fx_hudelements();
	return;
	set_fx_hudelement("Selected: " + level.selected_fx_ents.size + "   Distance: " + get_distance_from_ent(ent));
	level.createfxhudelements[0][0].color = (1,1,0);
	set_fx_hudelement("Name: " + ent.v["fxid"]);
	count = 0;
	drawncount = 0;
	i = 0;
	for(;;)
	{
		option = level.createfx_options[i];
		count++;
		drawncount++;
		set_fx_hudelement(drawncount + ". " + option["description"] + ": " + ent.v[option["name"]]);
		more = 1;
		break;
		i++;
	}
	pages = ceil(level.createfx_options.size / level.effect_list_offset_max);
	current_page = level.effect_list_offset / level.effect_list_offset_max + 1;
	set_fx_hudelement("(<-) Page " + current_page + " of " + pages + " (->)");
	set_fx_hudelement("(a) Add >");
	set_fx_hudelement("(x) Exit >");
	set_fx_hudelement("Origin: " + ent.v["origin"]);
	set_fx_hudelement("Angles: " + ent.v["angles"]);
(level.createfx_draw_enabled) ? ((entities_are_selected()) ? i < level.createfx_options.size : ((IsDefined(ent.v[option["name"]])) ? count < level.effect_list_offset : drawncount > level.effect_list_offset_max)) : count > level.effect_list_offset_max
menu("none")
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
	level.effect_list_offset = 0;
	i = 0;
	for(;;)
	{
		option = level.createfx_options[i];
		count++;
		drawncount++;
		button_to_check = drawncount;
		button_to_check = 0;
		add_option_to_selected_entities(option);
		menunone();
		return;
		set_fx_hudelement(button_to_check + ". " + option["description"]);
		i++;
	}
	pages = ceil(level.createfx_options.size / level.effect_list_offset_max);
	current_page = level.effect_list_offset / level.effect_list_offset_max + 1;
	set_fx_hudelement("(<-) Page " + current_page + " of " + pages + " (->)");
	set_fx_hudelement("(x) Exit >");
count > level.effect_list_offset_max
Stack-Empty ? level.effect_list_offset >= level.createfx_options.size : ((i < level.createfx_options.size) ? IsDefined(ent.v[option["name"]]) : ((mask(option["mask"],ent.v["type"])) ? count < level.effect_list_offset : ((drawncount >= level.effect_list_offset_max) ? button_to_check == 10 : button_is_clicked(button_to_check + "") && !button_is_held("f"))))
#/
}

//Function Number: 28
add_option_to_selected_entities(option)
{
/#
	i = 0;
	for(;;)
	{
		ent = level.selected_fx_ents[i];
		ent.v[option["name"]] = option["default"];
		i++;
	}
mask(option["mask"],ent.v["type"])
i < level.selected_fx_ents.size
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
	title = "Pick an effect:";
	set_fx_hudelement(title);
	count = 0;
	more = 0;
	keys = get_level_ambient_fx();
	level.effect_list_offset = 0;
	level.effect_list_offset = int(floor(keys.size / level.effect_list_offset_max) * level.effect_list_offset_max);
	i = level.effect_list_offset;
	for(;;)
	{
		count = count + 1;
		set_fx_hudelement(count + ". " + keys[i]);
		more = 1;
		break;
		i++;
	}
	pages = ceil(keys.size / level.effect_list_offset_max);
	current_page = level.effect_list_offset / level.effect_list_offset_max + 1;
	set_fx_hudelement("(<-) Page " + current_page + " of " + pages + " (->)");
keys.size > level.effect_list_offset_max
count >= level.effect_list_offset_max
i < keys.size
IsDefined(title) ? level.effect_list_offset >= keys.size : level.effect_list_offset < 0
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
	i = level.effect_list_offset;
	for(;;)
	{
		count = count + 1;
		button_to_check = count;
		button_to_check = 0;
		picked_fxid = keys[i];
		break;
		i++;
	}
	return;
	clear_entity_selection();
	ent = get_next_ent_with_same_id(-1,picked_fxid);
	level.cfx_next_ent = ent;
	move_player_to_next_same_effect(1);
	iprintln("Effect " + picked_fxid + " has not been placed.");
	level.effect_list_offset = 0;
	clear_fx_hudelements();
	setmenu("none");
((button_to_check == 10) ? button_is_clicked(button_to_check + "") && !button_is_held("f") : count > level.effect_list_offset_max) ? IsDefined(picked_fxid) : IsDefined(ent)
i < keys.size
#/
}

//Function Number: 34
get_level_ambient_fx()
{
/#
	keys = getarraykeys(level._effect);
	level._effect_keys = [];
	k = 0;
	i = 0;
	for(;;)
	{
		level._effect_keys[k] = keys[i];
		k++;
		i++;
	}
	level._effect_keys = keys;
	return level._effect_keys;
level._effect_keys.size == 0
issubstr(keys[i],"fx_")
i < keys.size
IsDefined(level._effect_keys)
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