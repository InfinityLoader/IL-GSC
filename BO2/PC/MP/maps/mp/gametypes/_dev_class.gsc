/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_dev_class.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 22
 * Decompile Time: 5 ms
 * Timestamp: 10/28/2023 12:10:29 AM
*******************************************************************/

#include maps/mp/_utility;
#include maps/mp/gametypes/_dev;

//Function Number: 1
dev_cac_init()
{
/#
	dev_cac_overlay = 0;
	dev_cac_camera_on = 0;
	level thread dev_cac_gdt_update_think();
	for(;;)
	{
		wait(0.5);
		reset = 1;
		if(GetDvar(#"E6D8B517") != "")
		{
			continue;
		}

		host = gethostplayer();
		if(!(IsDefined(level.dev_cac_player)))
		{
			level.dev_cac_player = host;
		}

		switch(GetDvar(#"CA7B9CD"))
		{
			case "":
				reset = 0;
				break;
	
			case "dpad_body":
				host thread dev_cac_dpad_think("body",::dev_cac_cycle_body,"");
				break;
	
			case "dpad_head":
				host thread dev_cac_dpad_think("head",::dev_cac_cycle_head,"");
				break;
	
			case "dpad_character":
				host thread dev_cac_dpad_think("character",::dev_cac_cycle_character,"");
				break;
	
			case "next_player":
				dev_cac_cycle_player(1);
				break;
	
			case "prev_player":
				dev_cac_cycle_player(0);
				break;
	
			case "cac_overlay":
				level notify("dev_cac_overlay_think");
				level thread dev_cac_overlay_think();
				dev_cac_overlay = !dev_cac_overlay;
				break;
		dev_cac_overlay
				break;
	
			case "best_bullet_armor":
				dev_cac_set_model_range(::sort_greatest,"armor_bullet");
				break;
	
			case "worst_bullet_armor":
				dev_cac_set_model_range(::sort_least,"armor_bullet");
				break;
	
			case "best_explosive_armor":
				dev_cac_set_model_range(::sort_greatest,"armor_explosive");
				break;
	
			case "worst_explosive_armor":
				dev_cac_set_model_range(::sort_least,"armor_explosive");
				break;
	
			case "best_mobility":
				dev_cac_set_model_range(::sort_greatest,"mobility");
				break;
	
			case "worst_mobility":
				dev_cac_set_model_range(::sort_least,"mobility");
				break;
	
			case "camera":
				dev_cac_camera_on = !dev_cac_camera_on;
				dev_cac_camera(dev_cac_camera_on);
				break;
	
			case "dpad_camo":
				host thread dev_cac_dpad_think("camo",::dev_cac_cycle_render_options,"camo");
				break;
	
			case "dpad_meleecamo":
				host thread dev_cac_dpad_think("meleecamo",::dev_cac_cycle_render_options,"meleecamo");
				break;
	
			case "dpad_lens":
				host thread dev_cac_dpad_think("lens",::dev_cac_cycle_render_options,"lens");
				break;
	
			case "dpad_reticle":
				host thread dev_cac_dpad_think("reticle",::dev_cac_cycle_render_options,"reticle");
				break;
	
			case "dpad_reticle_color":
				host thread dev_cac_dpad_think("reticle color",::dev_cac_cycle_render_options,"reticle_color");
				break;
	
			case "dpad_emblem":
				host thread dev_cac_dpad_think("emblem",::dev_cac_cycle_render_options,"emblem");
				break;
	
			case "dpad_tag":
				host thread dev_cac_dpad_think("tag",::dev_cac_cycle_render_options,"tag");
				break;
	
			case "dpad_facepaint_pattern":
				host thread dev_cac_dpad_think("facepaint pattern",::dev_cac_cycle_render_options,"facepaint_pattern");
				break;
	
			case "dpad_facepaint_color":
				host thread dev_cac_dpad_think("facepaint color",::dev_cac_cycle_render_options,"facepaint_color");
				break;
	
			case "dpad_reset":
				host notify("dev_cac_dpad_think");
				break;
		}

		if(reset)
		{
			setdvar("devgui_dev_cac","");
		}
	}
#/
}

//Function Number: 2
dev_cac_camera(on)
{
/#
	if(on)
	{
		self setclientthirdperson(1);
		setdvar("cg_thirdPersonAngle","185");
		setdvar("cg_thirdPersonRange","138");
		setdvar("cg_fov","20");
	}
	else
	{
		self setclientthirdperson(0);
		setdvar("cg_fov",GetDvar(#"55DDAF3D"));
	}
#/
}

//Function Number: 3
dev_cac_dpad_think(part_name,cycle_function,tag)
{
/#
	self notify("dev_cac_dpad_think");
	self endon("dev_cac_dpad_think");
	self endon("disconnect");
	iprintln("Previous " + part_name + " bound to D-Pad Left");
	iprintln("Next " + part_name + " bound to D-Pad Right");
	dpad_left = 0;
	dpad_right = 0;
	level.dev_cac_player thread highlight_player();
	for(;;)
	{
		self setactionslot(3,"");
		self setactionslot(4,"");
		if(!dpad_left && self buttonpressed("DPAD_LEFT"))
		{
			[[ cycle_function ]](0,tag);
			dpad_left = 1;
		}
		else if(!(self buttonpressed("DPAD_LEFT")))
		{
			dpad_left = 0;
		}

		if(!dpad_right && self buttonpressed("DPAD_RIGHT"))
		{
			[[ cycle_function ]](1,tag);
			dpad_right = 1;
		}
		else if(!(self buttonpressed("DPAD_RIGHT")))
		{
			dpad_right = 0;
		}

		wait(0.05);
	}
#/
}

//Function Number: 4
next_in_list(value,list)
{
/#
	if(!(IsDefined(value)))
	{
		return list[0];
	}

	for(i = 0;i < list.size;i++)
	{
		if(value == list[i])
		{
			if(IsDefined(list[i + 1]))
			{
				value = list[i + 1];
				continue;
			}

			value = list[0];
			break;
		}
	}

	return value;
#/
}

//Function Number: 5
prev_in_list(value,list)
{
/#
	if(!(IsDefined(value)))
	{
		return list[0];
	}

	for(i = 0;i < list.size;i++)
	{
		if(value == list[i])
		{
			if(IsDefined(list[i - 1]))
			{
				value = list[i - 1];
				continue;
			}

			value = list[list.size - 1];
			break;
		}
	}

	return value;
#/
}

//Function Number: 6
dev_cac_set_player_model()
{
/#
	self.tag_stowed_back = undefined;
	self.tag_stowed_hip = undefined;
#/
}

//Function Number: 7
dev_cac_cycle_body(forward,tag)
{
/#
	if(!(dev_cac_player_valid()))
	{
		return;
	}

	player = level.dev_cac_player;
	keys = getarraykeys(level.cac_functions["set_body_model"]);
	if(forward)
	{
		player.cac_body_type = next_in_list(player.cac_body_type,keys);
	}
	else
	{
		player.cac_body_type = prev_in_list(player.cac_body_type,keys);
	}

	player dev_cac_set_player_model();
#/
}

//Function Number: 8
dev_cac_cycle_head(forward,tag)
{
/#
	if(!(dev_cac_player_valid()))
	{
		return;
	}

	player = level.dev_cac_player;
	keys = getarraykeys(level.cac_functions["set_head_model"]);
	if(forward)
	{
		player.cac_head_type = next_in_list(player.cac_head_type,keys);
	}
	else
	{
		player.cac_head_type = prev_in_list(player.cac_head_type,keys);
	}

	player.cac_hat_type = "none";
	player dev_cac_set_player_model();
#/
}

//Function Number: 9
dev_cac_cycle_character(forward,tag)
{
/#
	if(!(dev_cac_player_valid()))
	{
		return;
	}

	player = level.dev_cac_player;
	keys = getarraykeys(level.cac_functions["set_body_model"]);
	if(forward)
	{
		player.cac_body_type = next_in_list(player.cac_body_type,keys);
	}
	else
	{
		player.cac_body_type = prev_in_list(player.cac_body_type,keys);
	}

	player.cac_hat_type = "none";
	player dev_cac_set_player_model();
#/
}

//Function Number: 10
dev_cac_cycle_render_options(forward,tag)
{
/#
	if(!(dev_cac_player_valid()))
	{
		return;
	}

	level.dev_cac_player nextplayerrenderoption(tag,forward);
#/
}

//Function Number: 11
dev_cac_player_valid()
{
/#
	return IsDefined(level.dev_cac_player) && level.dev_cac_player.sessionstate == "playing";
#/
}

//Function Number: 12
dev_cac_cycle_player(forward)
{
/#
	players = get_players();
	for(i = 0;i < players.size;i++)
	{
		if(forward)
		{
			level.dev_cac_player = next_in_list(level.dev_cac_player,players);
		}
		else
		{
			level.dev_cac_player = prev_in_list(level.dev_cac_player,players);
		}

		if(dev_cac_player_valid())
		{
			level.dev_cac_player thread highlight_player();
			return;
		}
	}

	level.dev_cac_player = undefined;
#/
}

//Function Number: 13
highlight_player()
{
/#
	self sethighlighted(1);
	wait(1);
	self sethighlighted(0);
#/
}

//Function Number: 14
dev_cac_overlay_think()
{
/#
	hud = dev_cac_overlay_create();
	level thread dev_cac_overlay_update(hud);
	level waittill("dev_cac_overlay_think");
	dev_cac_overlay_destroy(hud);
#/
}

//Function Number: 15
dev_cac_overlay_update(hud)
{
/#
#/
}

//Function Number: 16
dev_cac_overlay_destroy(hud)
{
/#
	for(i = 0;i < hud.menu.size;i++)
	{
		hud.menu[i] destroy();
	}

	hud destroy();
	setdvar("player_debugSprint","0");
#/
}

//Function Number: 17
dev_cac_overlay_create()
{
/#
	x = -80;
	y = 140;
	menu_name = "dev_cac_debug";
	hud = maps/mp/gametypes/_dev::new_hud(menu_name,undefined,x,y,1);
	hud setshader("white",185,285);
	hud.alignx = "left";
	hud.aligny = "top";
	hud.sort = 10;
	hud.alpha = 0.6;
	hud.color = VectorScale((0,0,1));
	x_offset = 100;
	hud.menu[0] = maps/mp/gametypes/_dev::new_hud(menu_name,"NAME",x + 5,y + 10,1.3);
	hud.menu[1] = maps/mp/gametypes/_dev::new_hud(menu_name,"MODELS",x + 5,y + 25,1);
	hud.menu[2] = maps/mp/gametypes/_dev::new_hud(menu_name,"  Body:",x + 5,y + 35,1);
	hud.menu[3] = maps/mp/gametypes/_dev::new_hud(menu_name,"  Head:",x + 5,y + 45,1);
	hud.menu[4] = maps/mp/gametypes/_dev::new_hud(menu_name,"  Head Gear:",x + 5,y + 55,1);
	hud.menu[5] = maps/mp/gametypes/_dev::new_hud(menu_name,"MOBILITY",x + 5,y + 70,1);
	hud.menu[6] = maps/mp/gametypes/_dev::new_hud(menu_name,"  Body:",x + 5,y + 80,1);
	hud.menu[7] = maps/mp/gametypes/_dev::new_hud(menu_name,"  Head Gear:",x + 5,y + 90,1);
	hud.menu[8] = maps/mp/gametypes/_dev::new_hud(menu_name,"  Speed Scale:",x + 5,y + 100,1);
	hud.menu[9] = maps/mp/gametypes/_dev::new_hud(menu_name,"  Sprint Duration:",x + 5,y + 110,1);
	hud.menu[10] = maps/mp/gametypes/_dev::new_hud(menu_name,"  Sprint Cooldown:",x + 5,y + 120,1);
	hud.menu[11] = maps/mp/gametypes/_dev::new_hud(menu_name,"ARMOR - BULLET",x + 5,y + 135,1);
	hud.menu[12] = maps/mp/gametypes/_dev::new_hud(menu_name,"  Body:",x + 5,y + 145,1);
	hud.menu[13] = maps/mp/gametypes/_dev::new_hud(menu_name,"  Head Gear:",x + 5,y + 155,1);
	hud.menu[14] = maps/mp/gametypes/_dev::new_hud(menu_name,"ARMOR - EXPLOSIVE",x + 5,y + 170,1);
	hud.menu[15] = maps/mp/gametypes/_dev::new_hud(menu_name,"  Body:",x + 5,y + 180,1);
	hud.menu[16] = maps/mp/gametypes/_dev::new_hud(menu_name,"  Head Gear:",x + 5,y + 190,1);
	hud.menu[17] = maps/mp/gametypes/_dev::new_hud(menu_name,"DAMAGE",x + 5,y + 205,1);
	hud.menu[18] = maps/mp/gametypes/_dev::new_hud(menu_name,"  Type:",x + 5,y + 215,1);
	hud.menu[19] = maps/mp/gametypes/_dev::new_hud(menu_name,"  Original:",x + 5,y + 225,1);
	hud.menu[20] = maps/mp/gametypes/_dev::new_hud(menu_name,"  Final:",x + 5,y + 235,1);
	hud.menu[21] = maps/mp/gametypes/_dev::new_hud(menu_name,"  Gain/Loss:",x + 5,y + 245,1);
	hud.menu[22] = maps/mp/gametypes/_dev::new_hud(menu_name,"  Location:",x + 5,y + 255,1);
	hud.menu[23] = maps/mp/gametypes/_dev::new_hud(menu_name,"  Weapon:",x + 5,y + 265,1);
	hud.menu[24] = maps/mp/gametypes/_dev::new_hud(menu_name,"  Range:",x + 5,y + 275,1);
	x_offset = 65;
	hud.menu[25] = maps/mp/gametypes/_dev::new_hud(menu_name,"",x + x_offset,y + 35,1);
	hud.menu[26] = maps/mp/gametypes/_dev::new_hud(menu_name,"",x + x_offset,y + 45,1);
	hud.menu[27] = maps/mp/gametypes/_dev::new_hud(menu_name,"",x + x_offset,y + 55,1);
	x_offset = 100;
	hud.menu[28] = maps/mp/gametypes/_dev::new_hud(menu_name,"",x + x_offset,y + 80,1);
	hud.menu[29] = maps/mp/gametypes/_dev::new_hud(menu_name,"",x + x_offset,y + 90,1);
	hud.menu[30] = maps/mp/gametypes/_dev::new_hud(menu_name,"",x + x_offset,y + 100,1);
	hud.menu[31] = maps/mp/gametypes/_dev::new_hud(menu_name,"",x + x_offset,y + 110,1);
	hud.menu[32] = maps/mp/gametypes/_dev::new_hud(menu_name,"",x + x_offset,y + 120,1);
	hud.menu[33] = maps/mp/gametypes/_dev::new_hud(menu_name,"",x + x_offset,y + 145,1);
	hud.menu[34] = maps/mp/gametypes/_dev::new_hud(menu_name,"",x + x_offset,y + 155,1);
	hud.menu[35] = maps/mp/gametypes/_dev::new_hud(menu_name,"",x + x_offset,y + 180,1);
	hud.menu[36] = maps/mp/gametypes/_dev::new_hud(menu_name,"",x + x_offset,y + 190,1);
	x_offset = 65;
	hud.menu[37] = maps/mp/gametypes/_dev::new_hud(menu_name,"",x + x_offset,y + 215,1);
	hud.menu[38] = maps/mp/gametypes/_dev::new_hud(menu_name,"",x + x_offset,y + 225,1);
	hud.menu[39] = maps/mp/gametypes/_dev::new_hud(menu_name,"",x + x_offset,y + 235,1);
	hud.menu[40] = maps/mp/gametypes/_dev::new_hud(menu_name,"",x + x_offset,y + 245,1);
	hud.menu[41] = maps/mp/gametypes/_dev::new_hud(menu_name,"",x + x_offset,y + 255,1);
	hud.menu[42] = maps/mp/gametypes/_dev::new_hud(menu_name,"",x + x_offset,y + 265,1);
	hud.menu[43] = maps/mp/gametypes/_dev::new_hud(menu_name,"",x + x_offset,y + 275,1);
	return hud;
#/
}

//Function Number: 18
color(value)
{
/#
	r = 1;
	g = 1;
	b = 0;
	color = (0,0,0);
	if(value > 0)
	{
		r = r - value;
	}
	else
	{
		g = g + value;
	}

	c = (r,g,b);
	return c;
#/
}

//Function Number: 19
dev_cac_gdt_update_think()
{
/#
	for(;;)
	{
		level waittill("gdt_update",asset,keyvalue);
		keyvalue = strtok(keyvalue,"\\");
		key = keyvalue[0];
		switch(key)
		{
			case "armorBullet":
				key = "armor_bullet";
				break;
	
			case "armorExplosive":
				key = "armor_explosive";
				break;
	
			case "moveSpeed":
				key = "mobility";
				break;
	
			case "sprintTimeTotal":
				key = "sprint_time_total";
				break;
	
			case "sprintTimeCooldown":
				key = "sprint_time_cooldown";
				break;
	
			default:
				key = undefined;
				break;
		}

		if(!(IsDefined(key)))
		{
			continue;
		}

		value = float(keyvalue[1]);
		level.cac_attributes[key][asset] = value;
		players = get_players();
		for(i = 0;i < players.size;i++)
		{
		}
	}
#/
}

//Function Number: 20
sort_greatest(function,attribute,greatest)
{
/#
	keys = getarraykeys(level.cac_functions[function]);
	greatest = keys[0];
	for(i = 0;i < keys.size;i++)
	{
		if(level.cac_attributes[attribute][keys[i]] > level.cac_attributes[attribute][greatest])
		{
			greatest = keys[i];
		}
	}

	return greatest;
#/
}

//Function Number: 21
sort_least(function,attribute,least)
{
/#
	keys = getarraykeys(level.cac_functions[function]);
	least = keys[0];
	for(i = 0;i < keys.size;i++)
	{
		if(level.cac_attributes[attribute][keys[i]] < level.cac_attributes[attribute][least])
		{
			least = keys[i];
		}
	}

	return least;
#/
}

//Function Number: 22
dev_cac_set_model_range(sort_function,attribute)
{
/#
	if(!(dev_cac_player_valid()))
	{
		return;
	}

	player = level.dev_cac_player;
	player.cac_body_type = [[ sort_function ]]("set_body_model",attribute);
	player.cac_head_type = [[ sort_function ]]("set_head_model",attribute);
	player.cac_hat_type = [[ sort_function ]]("set_hat_model",attribute);
	player dev_cac_set_player_model();
#/
}