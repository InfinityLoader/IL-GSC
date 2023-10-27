/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_rave\cp_rave_crafting.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 26
 * Decompile Time: 1395 ms
 * Timestamp: 10/27/2023 12:06:15 AM
*******************************************************************/

//Function Number: 1
init_crafting()
{
	level.crafting_table = "scripts/cp/maps/cp_rave/cp_rave_crafting.csv";
	level.var_B426 = 1;
	level.var_C1E2 = 0;
	level.var_A89F = gettime();
	level.var_47C1 = 25000;
	level.var_47C0 = -5536;
	level.var_BF36 = gettime() + 180000;
	level.var_47BE = ::func_13F02;
	level.var_47BD = ::func_13F01;
	level.var_47C2 = func_78F1(level.crafting_table);
	level.var_47A7 = func_78EA(level.crafting_table);
	level.var_47C3 = level.var_47C2;
	level.var_CC0C = [];
	level.interaction_post_activate_update_func = ::rave_post_activate_update_func;
	level.crafting_totem_areas = [];
	level.crafting_totem_uses = 0;
	level.crafting_icon_create_func = ::func_4939;
}

//Function Number: 2
set_crafting_starting_location(param_00)
{
	level.crafting_totem_starting_location = param_00;
	level.last_crafting_totem_area = param_00;
}

//Function Number: 3
activate_crafting_totem(param_00)
{
	self.var_D776 = 1;
	self.var_6261 = 1;
	level.crafting_totem_uses = 0;
	self.var_269F = 3;
	scripts\cp\_interaction::add_to_current_interaction_list(self);
	self.totem setscriptablepartstate("eyes","eyes_on");
	self.totem setscriptablepartstate("hideshow","show");
}

//Function Number: 4
deactivate_crafting_totem(param_00)
{
	self.var_D776 = 1;
	self.var_6261 = 0;
	self.var_269F = 3;
	scripts\cp\_interaction::remove_from_current_interaction_list(self);
	self.totem setscriptablepartstate("eyes","eyes_off");
}

//Function Number: 5
move_crafting_totem_to_new_location()
{
	for(;;)
	{
		var_00 = scripts\common\utility::random(level.crafting_totem_areas);
		if(var_00 != level.last_crafting_totem_area)
		{
			level.current_crafting_totem.totem setscriptablepartstate("hideshow","off");
			move_crafting_totem(var_00);
			return;
		}
	}
}

//Function Number: 6
move_crafting_totem(param_00)
{
	level.last_crafting_totem_area = param_00;
	foreach(var_02 in level.crafting_totems)
	{
		var_02 activate_crafting_totem(param_00);
	}
}

//Function Number: 7
func_9596()
{
	level.crafting_totems = scripts\common\utility::getstructarray("crafting_station","script_noteworthy");
	foreach(var_01 in level.crafting_totems)
	{
		var_01 thread init_crafting_totem();
	}

	wait(6);
	move_crafting_totem(level.crafting_totem_starting_location);
}

//Function Number: 8
func_7828(param_00)
{
	var_01 = getentarray("spawn_volume","targetname");
	foreach(var_03 in var_01)
	{
		if(function_010F(param_00.origin + (0,0,50),var_03))
		{
			if(isdefined(var_03.var_28AB))
			{
				return var_03.var_28AB;
			}
		}
	}

	return undefined;
}

//Function Number: 9
init_crafting_totem()
{
	wait(5);
	var_00 = getentarray(self.target,"targetname");
	self.totem = undefined;
	foreach(var_02 in var_00)
	{
		if(var_02.classname == "scriptable")
		{
			self.totem = var_02;
		}
	}

	var_00 = scripts\common\utility::getstructarray(self.target,"targetname");
	foreach(var_02 in var_00)
	{
		if(var_02.script_noteworthy == "crafting_item_spot")
		{
			self.craft_item_spot = var_02;
		}
	}

	self.var_2135 = func_7828(self);
	level.crafting_totem_areas[level.crafting_totem_areas.size] = self.var_2135;
	self.var_D776 = 1;
	self.var_6261 = 0;
	self.var_269F = 3;
	self.totem setscriptablepartstate("eyes","eyes_off");
}

//Function Number: 10
func_12FBE(param_00,param_01)
{
	if(!scripts\common\utility::func_2286(level.current_interaction_structs,param_00))
	{
		return;
	}

	if(param_00.var_269F > 0)
	{
		if(!isdefined(param_01.var_4B5E))
		{
			return;
		}

		if(getweaponbasename(param_01 getcurrentweapon()) != "iw7_penetrationrail_mp")
		{
			param_01 setweaponammostock("iw7_souvenircoin_zm",1);
			param_01 giveandfireoffhand("iw7_souvenircoin_zm");
		}

		var_02 = "orange";
		switch(param_01.var_4B5E.var_47C9)
		{
			case "cp_rave_crafting_totem_gem_topaz":
				var_02 = "blue";
				break;

			case "cp_rave_crafting_totem_gem_amethyst":
				var_02 = "purple";
				break;
		}

		switch(param_00.var_269F)
		{
			case 3:
				param_00.totem setscriptablepartstate("socket_0",var_02);
				break;

			case 2:
				param_00.totem setscriptablepartstate("socket_1",var_02);
				break;

			case 1:
				param_00.totem setscriptablepartstate("socket_2",var_02);
				break;
		}

		if(!isdefined(param_00.var_94CA))
		{
			param_00.var_94CA = [];
		}

		param_00.var_94CA[3 - param_00.var_269F] = param_01.var_4B5E.var_47C9;
		playsoundatpos(param_00.origin,"zmb_rave_crafting_totem_item_place");
		param_01 setclientomnvar("zombie_souvenir_piece_index",0);
		param_01.var_A8D3 = undefined;
		param_01.var_4B5E = undefined;
		param_00.var_269F--;
		param_01 scripts\cp\_merits::func_D9AD("mt_used_crafting");
		if(param_00.var_269F > 0)
		{
			return;
		}

		scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
		param_00.craft_item_fx = spawnfx(level._effect["altar_item_flame"],param_00.craft_item_spot.origin + (0,0,5));
		playfx(level._effect["crafting_souvenir"],param_00.craft_item_spot.origin + (0,0,5));
		playsoundatpos(param_00.craft_item_spot.origin,"zmb_rave_crafting_totem_item_craft");
		wait(1);
		param_00.totem setscriptablepartstate("eyes","active");
		func_47A5(param_00,param_01);
		if(isdefined(param_01))
		{
			param_01 thread scripts\cp\_vo::try_to_play_vo("souvenir_craft_success","zmb_comment_vo","low",10,0,0,0,50);
		}

		triggerfx(param_00.craft_item_fx);
		scripts\cp\_interaction::add_to_current_interaction_list(param_00);
		while(isdefined(param_00.var_10485))
		{
			wait(0.1);
		}

		param_00.totem setscriptablepartstate("eyes","eyes_on");
		scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
		playsoundatpos(param_00.origin,"zmb_rave_crafting_totem_item_pickup");
		if(isdefined(param_01))
		{
			param_01 playlocalsound("zmb_item_pickup");
		}

		playfx(level._effect["souvenir_pickup"],param_00.craft_item_spot.origin);
		param_00.var_269F = 3;
		param_00.var_94CA = [];
		if(isdefined(param_01))
		{
			param_01.var_A8D3 = undefined;
		}

		level.crafting_totem_uses++;
		wait(1);
		scripts\cp\_interaction::add_to_current_interaction_list(param_00);
	}
}

//Function Number: 11
func_13F02(param_00,param_01,param_02)
{
	if(!func_FF3B(param_01))
	{
		return 0;
	}

	level thread func_10697(param_01);
	return 1;
}

//Function Number: 12
func_13F01(param_00,param_01)
{
	switch(param_01)
	{
		case "zmb_coin_alien":
			param_01 = "cp_rave_crafting_totem_gem_amber";
			break;

		case "zmb_coin_space":
			param_01 = "cp_rave_crafting_totem_gem_amethyst";
			break;

		case "zmb_coin_ice":
			param_01 = "cp_rave_crafting_totem_gem_topaz";
			break;
	}

	level thread func_10697(param_00,param_01);
}

//Function Number: 13
func_10697(param_00,param_01)
{
	level.var_C1E2++;
	level.var_A89F = gettime();
	level.var_BF36 = level.var_A89F + 30000 + randomintrange(level.var_47C1,level.var_47C0);
	var_02 = spawn("script_model",param_00 + (0,0,45));
	var_02.angles = (90,0,0);
	var_02.var_C378 = (90,0,0);
	var_03 = scripts\common\utility::random(level.var_47C3);
	if(isdefined(param_01))
	{
		var_03 = param_01;
	}

	var_02 setmodel(var_03);
	var_02.script_noteworthy = "crafting_item";
	var_04 = "purple";
	if(var_02.model == "cp_rave_crafting_totem_gem_amber")
	{
		var_04 = "orange";
	}
	else if(var_02.model == "cp_rave_crafting_totem_gem_topaz")
	{
		var_04 = "blue";
	}

	var_02 setscriptablepartstate("fx",var_04);
	var_02.glow_type = var_04;
	var_05 = func_48C2(var_02,25);
	var_02 thread func_47C6(var_05);
}

//Function Number: 14
func_48C2(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.script_noteworthy = "crafting_pickup";
	var_02.origin = param_00.origin - (0,0,45);
	var_02.var_195 = param_00;
	var_02.var_E1B9 = 0;
	var_02.var_D776 = 1;
	var_02.var_EE79 = "crafting_pickup";
	var_02.name = "crafting_pickup";
	var_02.var_118D7 = param_01;
	var_02.var_47C9 = param_00.model;
	var_02.var_47BA = "";
	var_02.var_109DA = "souvenir_coin";
	scripts\cp\_interaction::add_to_current_interaction_list(var_02);
	return var_02;
}

//Function Number: 15
func_47C4(param_00,param_01)
{
	if(!isdefined(param_00.var_195))
	{
		return;
	}

	if(isdefined(param_00.var_195.var_2A89))
	{
		return;
	}

	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	if(!isdefined(level.var_4376))
	{
		level.var_4376 = 1;
		if(scripts\cp\_utility::map_check(0))
		{
			level thread scripts\cp\_vo::func_1769("dj_souvenircoin_collect_nag","zmb_dj_vo",60,60,2);
		}
	}

	var_02 = param_00.origin + (0,0,45);
	param_00.var_195 setscriptablepartstate("fx","pickup_" + param_00.var_195.glow_type);
	scripts\common\utility::func_136F7();
	if(isdefined(param_01.var_4B5E))
	{
		param_01 playlocalsound("zmb_crystal_swap");
		var_03 = spawnstruct();
		var_03.script_noteworthy = "crafting_pickup";
		var_03.origin = param_00.origin;
		var_03.var_195 = spawn("script_model",var_02);
		var_03.var_195.angles = (90,0,0);
		var_03.var_195.var_C378 = (90,0,0);
		var_03.var_E1B9 = 0;
		var_03.var_D776 = 1;
		var_03.var_EE79 = param_01.var_4B5E.var_EE79;
		var_03.name = param_01.var_4B5E.name;
		var_03.var_118D7 = param_00.var_118D7;
		var_03.var_47C9 = param_01.var_4B5E.var_47C9;
		var_03.var_47BA = "";
		var_03.var_195 setmodel(var_03.var_47C9);
		param_01.var_4B5E = param_00;
		param_01 func_4939(param_00);
		var_03.var_195 thread func_47C6(var_03);
		scripts\cp\_interaction::add_to_current_interaction_list(var_03);
		wait(0.3);
		var_04 = "purple";
		if(var_03.var_195.model == "cp_rave_crafting_totem_gem_amber")
		{
			var_04 = "orange";
		}
		else if(var_03.var_195.model == "cp_rave_crafting_totem_gem_topaz")
		{
			var_04 = "blue";
		}

		var_03.var_195 setscriptablepartstate("fx",var_04);
		var_03.var_195.glow_type = var_04;
	}
	else
	{
		param_01 playlocalsound("zmb_crystal_pickup");
		level.var_C1E2--;
		param_01.var_4B5E = param_00;
		param_01 thread scripts\cp\_vo::try_to_play_vo("pillage_craft","zmb_comment_vo","low",10,0,1,0,40);
		param_01 func_4939(param_00);
	}

	wait(1);
	if(isdefined(param_00.var_195))
	{
		param_00.var_195 delete();
	}

	if(isdefined(param_00))
	{
		param_00 = undefined;
	}
}

//Function Number: 16
func_4939(param_00)
{
	var_01 = func_7A27(param_00.var_47C9);
	self setclientomnvar("zombie_souvenir_piece_index",int(var_01));
}

//Function Number: 17
func_7A27(param_00)
{
	return tablelookup("scripts/cp/maps/cp_rave/cp_rave_crafting.csv",1,param_00,0);
}

//Function Number: 18
func_47C6(param_00)
{
	self endon("death");
	self endon("vacuum");
	self notify("timeout");
	self endon("timeout");
	var_01 = 25;
	if(isdefined(param_00.var_118D7))
	{
		var_01 = int(param_00.var_118D7);
	}

	var_02 = gettime() + var_01 * 1000;
	var_03 = 0;
	var_04 = 0;
	while(gettime() < var_02)
	{
		if(var_04 == 0)
		{
			self rotateyaw(360,2);
			self movez(5,2);
		}

		if(var_04 == 2)
		{
			self rotateyaw(360,2);
			self movez(-5,2);
		}

		if(var_04 == 4)
		{
			var_04 = 0;
			continue;
		}

		wait(1);
		var_04++;
		param_00.var_118D7 = param_00.var_118D7 - 1;
	}

	playsoundatpos(self.origin,"zmb_crystal_disappear");
	param_00.var_195 setscriptablepartstate("fx","pickup_" + param_00.var_195.glow_type);
	level.var_C1E2--;
	if(level.var_C1E2 < 0)
	{
		level.var_C1E2 = 0;
	}

	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	scripts\common\utility::func_136F7();
	self delete();
}

//Function Number: 19
func_FF3B(param_00)
{
	if(level.var_C1E2 >= level.var_B426)
	{
		return 0;
	}

	if(!self.entered_playspace)
	{
		return 0;
	}

	foreach(var_02 in level.var_10816)
	{
		if(var_02.var_28AB != "island")
		{
			continue;
		}

		if(function_010F(param_00,var_02))
		{
			return 0;
		}
	}

	if(isdefined(level.var_164B))
	{
		if(![[ level.var_164B ]](param_00))
		{
			return 0;
		}
	}

	if(isdefined(level.var_9B0B))
	{
		if(!scripts\cp\_weapon::func_9E54(param_00,level.var_9B0B,undefined,undefined,1))
		{
			return 0;
		}
	}
	else if(!scripts\cp\_weapon::func_9E54(param_00,undefined,undefined,undefined,1))
	{
		return 0;
	}

	if(randomint(100) < 30)
	{
		return 0;
	}

	if(level.var_BF36 > gettime())
	{
		return 0;
	}

	return 1;
}

//Function Number: 20
func_47A5(param_00,param_01)
{
	var_02 = func_78EC(param_00);
	if(!isdefined(var_02))
	{
		var_02 = "money";
	}

	switch(var_02)
	{
		case "crafted_trap_balloon":
		case "crafted_trap_mower":
		case "crafted_gascan":
		case "crafted_revocator":
		case "crafted_boombox":
		case "crafted_electric_trap":
		case "crafted_medusa":
		case "crafted_ims":
		case "crafted_autosentry":
		case "crafted_windowtrap":
			param_00.script_noteworthy = var_02;
			param_00.var_109DA = "craftable";
			param_00.var_E1B9 = 0;
			param_00.var_D776 = 1;
			param_00.var_EE79 = var_02;
			param_00.name = var_02;
			param_00.var_10485 = 1;
			param_00.var_D6B3 = 1;
			param_00.var_47B2 = 1;
			break;

		default:
			foreach(param_01 in level.players)
			{
				param_01 scripts\cp\_persistence::func_82F9(500);
				break;
			}
	
			break;
	}

	scripts\cp\zombies\zombie_analytics::func_AF77(level.wave_num,var_02);
	if(isdefined(param_01))
	{
		param_01.var_A039 = var_02;
	}
}

//Function Number: 21
func_78EC(param_00)
{
	foreach(var_02 in level.var_47A7)
	{
		var_03 = 0;
		var_04 = var_02;
		foreach(var_06 in param_00.var_94CA)
		{
			if(scripts\common\utility::func_2286(var_04,var_06))
			{
				var_03++;
				var_04 = func_E040(var_04,var_06);
			}
		}

		if(var_03 == 3)
		{
			return var_02[0];
		}
	}

	return undefined;
}

//Function Number: 22
func_E040(param_00,param_01)
{
	var_02 = 0;
	var_03 = [];
	for(var_04 = 0;var_04 < param_00.size;var_04++)
	{
		if(!var_02 && param_00[var_04] == param_01)
		{
			var_02 = 1;
			continue;
		}

		var_03[var_03.size] = param_00[var_04];
	}

	return var_03;
}

//Function Number: 23
func_78F1(param_00)
{
	var_01 = [];
	for(var_02 = 1;var_02 < 99;var_02++)
	{
		var_03 = func_113C5(param_00,var_02,1);
		if(var_03 == "")
		{
			break;
		}

		var_01[var_01.size] = var_03;
	}

	return var_01;
}

//Function Number: 24
func_78EA(param_00)
{
	var_01 = 1;
	var_02 = 2;
	var_03 = [];
	for(var_04 = 100;var_04 <= 199;var_04++)
	{
		var_05 = undefined;
		var_05 = func_113C5(param_00,var_04,var_01);
		if(var_05 == "")
		{
			break;
		}

		var_06 = strtok(func_113C5(param_00,var_04,var_02)," ");
		var_06 = scripts\common\utility::func_229C(var_06,var_05,0);
		var_03[var_03.size] = var_06;
	}

	return var_03;
}

//Function Number: 25
func_113C5(param_00,param_01,param_02)
{
	return tablelookup(param_00,0,param_01,param_02);
}

//Function Number: 26
rave_post_activate_update_func(param_00,param_01)
{
	if(isdefined(param_00.var_10485))
	{
		param_00.script_noteworthy = "crafting_station";
		param_00.var_E1B9 = 1;
		param_00.var_D776 = 1;
		param_00.var_EE79 = "requires_power";
		param_00.name = "crafting_station";
		if(isdefined(param_00.var_10486))
		{
			param_00.var_10486 delete();
		}

		param_00.var_10485 = undefined;
		param_00.var_D6B3 = undefined;
		param_00.var_D742 = undefined;
		param_00.var_47B2 = undefined;
		param_00.craft_item_fx delete();
		if(param_01 scripts\cp\_utility::is_valid_player())
		{
			param_01 playlocalsound("zmb_item_pickup");
		}

		param_00.totem setscriptablepartstate("socket_0","empty");
		param_00.totem setscriptablepartstate("socket_1","empty");
		param_00.totem setscriptablepartstate("socket_2","empty");
	}
}