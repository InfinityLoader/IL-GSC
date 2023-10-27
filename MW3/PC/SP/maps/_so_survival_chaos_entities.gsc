/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_so_survival_chaos_entities.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 24
 * Decompile Time: 453 ms
 * Timestamp: 10/27/2023 2:19:12 AM
*******************************************************************/

//Function Number: 1
get_level(param_00)
{
	return tablelookup(level.chaos_entity_table,0,param_00,1);
}

//Function Number: 2
get_level_weapon(param_00)
{
	return tablelookup(level.chaos_entity_table,0,param_00,2);
}

//Function Number: 3
get_level_weapon_position(param_00)
{
	return tablelookup(level.chaos_entity_table,0,param_00,3);
}

//Function Number: 4
get_level_drop_location(param_00)
{
	return tablelookup(level.chaos_drop_location_table,0,param_00,2);
}

//Function Number: 5
get_level_drop_item(param_00)
{
	return tablelookup(level.chaos_drop_item_table,0,param_00,3);
}

//Function Number: 6
get_level_drop_wave(param_00)
{
	return tablelookup(level.chaos_drop_item_table,0,param_00,2);
}

//Function Number: 7
get_level_ai_size_wave(param_00)
{
	return tablelookup(level.constant_ai_size_table,0,param_00,2);
}

//Function Number: 8
get_level_ai_size(param_00)
{
	return tablelookup(level.constant_ai_size_table,0,param_00,3);
}

//Function Number: 9
get_ai_size_level(param_00)
{
	return tablelookup(level.constant_ai_size_table,0,param_00,1);
}

//Function Number: 10
get_drop_distance_level(param_00)
{
	return tablelookup(level.desired_drop_distance_table,0,param_00,1);
}

//Function Number: 11
get_level_desired_drop_distance(param_00)
{
	return tablelookup(level.desired_drop_distance_table,0,param_00,2);
}

//Function Number: 12
get_level_starting_lives_remaining(param_00)
{
	return tablelookup(level.desired_drop_distance_table,0,param_00,3);
}

//Function Number: 13
chaos_entities_precache()
{
	if(!isdefined(level.chaos_entity_table))
	{
		level.chaos_entity_table = "sp/survival_chaos_entities.csv";
	}

	var_00 = getdvar("mapname");
	for(var_01 = 100;var_01 <= 1700;var_01++)
	{
		var_02 = get_level(var_01);
		if(!isdefined(var_02) || var_02 == "" || var_02 != var_00)
		{
			continue;
		}

		var_03 = get_level_weapon(var_01);
		if(!isdefined(var_03) || var_03 == "")
		{
			continue;
		}

		var_04 = get_level_weapon_position(var_01);
		if(!isdefined(var_04) || var_04 == "")
		{
			continue;
		}

		var_05 = strtok(var_04,",");
		if(!isdefined(var_05) || var_05.size != 3)
		{
			continue;
		}

		if(!isdefined(level.chaos_weapon_locations))
		{
			level.chaos_weapon_locations = [];
		}

		precacheitem(var_03);
		level.chaos_weapon_locations[var_03] = (float(var_05[0]),float(var_05[1]),float(var_05[2]));
	}
}

//Function Number: 14
chaos_entities_place()
{
	level.chaos_entities = [];
	foreach(var_09, var_01 in level.chaos_weapon_locations)
	{
		var_02 = getweaponmodel(var_09);
		var_03 = common_scripts\utility::spawn_tag_origin();
		var_03.origin = var_01 + (0,0,48);
		var_03.var_5C39 = var_09;
		var_03.trigger = spawn("trigger_radius",var_03.origin,0,48,48);
		var_04 = (8,0,0);
		var_05 = (0,0,0);
		if(issubstr(var_09,"akimbo"))
		{
			var_03.akimbo = 1;
			var_06 = var_04 + (0,-6,0);
			var_07 = var_04 + (0,6,0);
			var_03.weapon_models[0] = spawn("script_model",var_03.origin);
			var_03.weapon_models[0] setmodel(var_02);
			var_03.weapon_models[0] linkto(var_03,"tag_origin",var_06,var_05 + (15,0,0));
			var_03.weapon_models[1] = spawn("script_model",var_03.origin);
			var_03.weapon_models[1] setmodel(var_02);
			var_03.weapon_models[1] linkto(var_03,"tag_origin",var_07,var_05 + (15,0,0));
		}
		else
		{
			var_03.akimbo = 0;
			var_03.weapon_models[0] = spawn("script_model",var_03.origin);
			var_03.weapon_models[0] setmodel(var_02);
			var_03.weapon_models[0] linkto(var_03,"tag_origin",var_04,var_05);
		}

		var_03 thread chaos_entity_rotate();
		var_03.display_name = get_weapon_display_name(var_09);
		var_08 = chaos_get_weapon_class(var_09);
		var_03.hud_icon = get_weapon_hud_icon(var_08);
		var_03 thread chaos_weapon_collect();
		var_03.headiconforplayer = [];
		level.chaos_entities[level.chaos_entities.size] = var_03;
	}

	level.chaos_weapon_locations = undefined;
}

//Function Number: 15
get_weapon_hud_icon(param_00)
{
	var_01 = "";
	if(param_00 == "FG")
	{
		var_01 = "specops_ui_equipmentstore";
	}
	else if(param_00 == "SG")
	{
		var_01 = "specops_ui_weaponstore";
	}
	else if(param_00 == "AR")
	{
		var_01 = "specops_ui_weaponstore";
	}
	else if(param_00 == "SN")
	{
		var_01 = "specops_ui_weaponstore";
	}
	else if(param_00 == "Akimbo")
	{
		var_01 = "specops_ui_weaponstore";
	}
	else if(param_00 == "LMG")
	{
		var_01 = "specops_ui_weaponstore";
	}
	else if(param_00 == "SMG")
	{
		var_01 = "specops_ui_weaponstore";
	}
	else if(param_00 == "HG")
	{
		var_01 = "specops_ui_weaponstore";
	}
	else if(param_00 == "RPG")
	{
		var_01 = "specops_ui_weaponstore";
	}

	return var_01;
}

//Function Number: 16
chaos_get_weapon_class(param_00)
{
	var_01 = "";
	if(issubstr(param_00,"claymore"))
	{
		var_01 = "FG";
	}
	else if(issubstr(param_00,"c4"))
	{
		var_01 = "FG";
	}
	else if(issubstr(param_00,"flash"))
	{
		var_01 = "FG";
	}
	else if(issubstr(param_00,"1887"))
	{
		var_01 = "SG";
	}
	else if(issubstr(param_00,"aa12"))
	{
		var_01 = "SG";
	}
	else if(issubstr(param_00,"acr"))
	{
		var_01 = "AR";
	}
	else if(issubstr(param_00,"ak47"))
	{
		var_01 = "AR";
	}
	else if(issubstr(param_00,"as50"))
	{
		var_01 = "SN";
	}
	else if(issubstr(param_00,"cm901"))
	{
		var_01 = "AR";
	}
	else if(issubstr(param_00,"fad"))
	{
		var_01 = "AR";
	}
	else if(issubstr(param_00,"fmg9"))
	{
		var_01 = "Akimbo";
	}
	else if(issubstr(param_00,"g18"))
	{
		var_01 = "Akimbo";
	}
	else if(issubstr(param_00,"mg36"))
	{
		var_01 = "LMG";
	}
	else if(issubstr(param_00,"g36"))
	{
		var_01 = "AR";
	}
	else if(issubstr(param_00,"m16"))
	{
		var_01 = "AR";
	}
	else if(issubstr(param_00,"m4"))
	{
		var_01 = "AR";
	}
	else if(issubstr(param_00,"m60"))
	{
		var_01 = "LMG";
	}
	else if(issubstr(param_00,"m9"))
	{
		var_01 = "SMG";
	}
	else if(issubstr(param_00,"mk14"))
	{
		var_01 = "AR";
	}
	else if(issubstr(param_00,"mk46"))
	{
		var_01 = "LMG";
	}
	else if(issubstr(param_00,"mp5"))
	{
		var_01 = "SMG";
	}
	else if(issubstr(param_00,"mp7"))
	{
		var_01 = "SMG";
	}
	else if(issubstr(param_00,"mp9"))
	{
		var_01 = "Akimbo";
	}
	else if(issubstr(param_00,"pp90"))
	{
		var_01 = "SMG";
	}
	else if(issubstr(param_00,"p90"))
	{
		var_01 = "SMG";
	}
	else if(issubstr(param_00,"pecheneg"))
	{
		var_01 = "LMG";
	}
	else if(issubstr(param_00,"rsass"))
	{
		var_01 = "SN";
	}
	else if(issubstr(param_00,"sa80"))
	{
		var_01 = "LMG";
	}
	else if(issubstr(param_00,"scar"))
	{
		var_01 = "AR";
	}
	else if(issubstr(param_00,"skorpion"))
	{
		var_01 = "Akimbo";
	}
	else if(issubstr(param_00,"striker"))
	{
		var_01 = "SG";
	}
	else if(issubstr(param_00,"type95"))
	{
		var_01 = "AR";
	}
	else if(issubstr(param_00,"usp45"))
	{
		var_01 = "HG";
	}
	else if(issubstr(param_00,"ump45"))
	{
		var_01 = "SMG";
	}
	else if(issubstr(param_00,"usas12"))
	{
		var_01 = "SG";
	}
	else if(issubstr(param_00,"rpg"))
	{
		var_01 = "RPG";
	}

	return var_01;
}

//Function Number: 17
get_weapon_display_name(param_00)
{
	var_01 = undefined;
	if(issubstr(param_00,"claymore"))
	{
		var_01 = &"SO_SURVIVAL_CHAOS_PICKUP_CLAYMORE";
	}
	else if(issubstr(param_00,"c4"))
	{
		var_01 = &"SO_SURVIVAL_CHAOS_PICKUP_C4";
	}
	else if(issubstr(param_00,"flash"))
	{
		var_01 = &"SO_SURVIVAL_CHAOS_PICKUP_FLASH";
	}
	else if(issubstr(param_00,"1887"))
	{
		var_01 = &"SO_SURVIVAL_CHAOS_PICKUP_1887";
	}
	else if(issubstr(param_00,"aa12"))
	{
		var_01 = &"SO_SURVIVAL_CHAOS_PICKUP_AA12";
	}
	else if(issubstr(param_00,"acr"))
	{
		var_01 = &"SO_SURVIVAL_CHAOS_PICKUP_ACR";
	}
	else if(issubstr(param_00,"ak47"))
	{
		var_01 = &"SO_SURVIVAL_CHAOS_PICKUP_AK47";
	}
	else if(issubstr(param_00,"as50"))
	{
		var_01 = &"SO_SURVIVAL_CHAOS_PICKUP_AS50";
	}
	else if(issubstr(param_00,"cm901"))
	{
		var_01 = &"SO_SURVIVAL_CHAOS_PICKUP_CM901";
	}
	else if(issubstr(param_00,"fad"))
	{
		var_01 = &"SO_SURVIVAL_CHAOS_PICKUP_FAD";
	}
	else if(issubstr(param_00,"fmg9"))
	{
		var_01 = &"SO_SURVIVAL_CHAOS_PICKUP_FMG9";
	}
	else if(issubstr(param_00,"g18"))
	{
		var_01 = &"SO_SURVIVAL_CHAOS_PICKUP_G18";
	}
	else if(issubstr(param_00,"mg36"))
	{
		var_01 = &"SO_SURVIVAL_CHAOS_PICKUP_MG36";
	}
	else if(issubstr(param_00,"g36"))
	{
		var_01 = &"SO_SURVIVAL_CHAOS_PICKUP_G36";
	}
	else if(issubstr(param_00,"m16"))
	{
		var_01 = &"SO_SURVIVAL_CHAOS_PICKUP_M16";
	}
	else if(issubstr(param_00,"m4"))
	{
		var_01 = &"SO_SURVIVAL_CHAOS_PICKUP_M4";
	}
	else if(issubstr(param_00,"m60"))
	{
		var_01 = &"SO_SURVIVAL_CHAOS_PICKUP_M60";
	}
	else if(issubstr(param_00,"m9"))
	{
		var_01 = &"SO_SURVIVAL_CHAOS_PICKUP_M9";
	}
	else if(issubstr(param_00,"mk14"))
	{
		var_01 = &"SO_SURVIVAL_CHAOS_PICKUP_MK14";
	}
	else if(issubstr(param_00,"mk46"))
	{
		var_01 = &"SO_SURVIVAL_CHAOS_PICKUP_MK46";
	}
	else if(issubstr(param_00,"mp5"))
	{
		var_01 = &"SO_SURVIVAL_CHAOS_PICKUP_MP5";
	}
	else if(issubstr(param_00,"mp7"))
	{
		var_01 = &"SO_SURVIVAL_CHAOS_PICKUP_MP7";
	}
	else if(issubstr(param_00,"mp9"))
	{
		var_01 = &"SO_SURVIVAL_CHAOS_PICKUP_MP9";
	}
	else if(issubstr(param_00,"pp90"))
	{
		var_01 = &"SO_SURVIVAL_CHAOS_PICKUP_PP90";
	}
	else if(issubstr(param_00,"p90"))
	{
		var_01 = &"SO_SURVIVAL_CHAOS_PICKUP_P90";
	}
	else if(issubstr(param_00,"pecheneg"))
	{
		var_01 = &"SO_SURVIVAL_CHAOS_PICKUP_PECHENEG";
	}
	else if(issubstr(param_00,"rsass"))
	{
		var_01 = &"SO_SURVIVAL_CHAOS_PICKUP_RSASS";
	}
	else if(issubstr(param_00,"sa80"))
	{
		var_01 = &"SO_SURVIVAL_CHAOS_PICKUP_SA80";
	}
	else if(issubstr(param_00,"scar"))
	{
		var_01 = &"SO_SURVIVAL_CHAOS_PICKUP_SCAR";
	}
	else if(issubstr(param_00,"skorpion"))
	{
		var_01 = &"SO_SURVIVAL_CHAOS_PICKUP_SKORPION";
	}
	else if(issubstr(param_00,"striker"))
	{
		var_01 = &"SO_SURVIVAL_CHAOS_PICKUP_STRIKER";
	}
	else if(issubstr(param_00,"type95"))
	{
		var_01 = &"SO_SURVIVAL_CHAOS_PICKUP_TYPE95";
	}
	else if(issubstr(param_00,"usp45"))
	{
		var_01 = &"SO_SURVIVAL_CHAOS_PICKUP_USP45";
	}
	else if(issubstr(param_00,"ump45"))
	{
		var_01 = &"SO_SURVIVAL_CHAOS_PICKUP_UMP45";
	}
	else if(issubstr(param_00,"usas12"))
	{
		var_01 = &"SO_SURVIVAL_CHAOS_PICKUP_USAS12";
	}
	else if(issubstr(param_00,"rpg"))
	{
		var_01 = &"SO_SURVIVAL_CHAOS_PICKUP_RPG";
	}

	return var_01;
}

//Function Number: 18
chaos_entity_rotate()
{
	self endon("death");
	for(;;)
	{
		self rotateyaw(360,3,0,0);
		wait 3;
	}
}

//Function Number: 19
chaos_weapon_collect()
{
	self endon("death");
	self.trigger endon("death");
	level endon("special_op_terminated");
	self.weapon_in_use = 0;
	for(;;)
	{
		self.trigger waittill("trigger",var_00);
		if(isplayer(var_00) && !maps\_utility::is_player_down(var_00))
		{
			var_00 maps/_so_survival_chaos::chaoseventpopup(self.display_name,(1,1,1));
		}

		if(!isplayer(var_00) || maps\_utility::is_player_down(var_00) || !var_00 usebuttonpressed())
		{
			continue;
		}

		var_01 = 0;
		var_02 = 0;
		if(!var_00 hasweapon(self.var_5C39) && self.var_5C39 != "claymore")
		{
			var_03 = var_00 getweaponslistprimaries();
			foreach(var_05 in var_03)
			{
				if((isdefined(level.coop_incap_weapon) && var_05 == level.coop_incap_weapon) || weaponclass(var_05) == "item" || weaponclass(var_05) == "none" || weaponinventorytype(var_05) == "altmode")
				{
					continue;
				}

				var_00 takeweapon(var_05);
			}

			var_00 maps/_so_survival_chaos::chaos_give_weapon(self.var_5C39);
			var_01 = 1;
			if(!isdefined(var_00.weapon_already_used))
			{
				var_00.weapon_already_used = [];
			}

			if(!isdefined(var_00.weapon_already_used[self.var_5C39]))
			{
				maps/_so_survival_chaos::chaos_score_event_raise("new_weapon_collect");
				var_02 = 1;
				var_00.weapon_already_used[self.var_5C39] = 1;
				var_00.game_performance["new_weapon_collected"]++;
			}
			else
			{
				maps/_so_survival_chaos::chaos_score_event_raise("old_weapon_collect");
			}
		}
		else
		{
			var_07 = 0;
			if(self.var_5C39 == "claymore" || self.var_5C39 == "c4")
			{
				if(!var_00 hasweapon(self.var_5C39))
				{
					var_00 giveweapon(self.var_5C39);
					var_07 = 1;
				}
				else
				{
					var_07 = var_00 getweaponammoclip(self.var_5C39) + 1;
				}
			}
			else
			{
				var_07 = weaponclipsize(self.var_5C39);
			}

			if(issubstr(self.var_5C39,"akimbo"))
			{
				var_00 setweaponammoclip(self.var_5C39,var_07,"left");
				var_00 setweaponammoclip(self.var_5C39,var_07,"right");
			}
			else
			{
				var_00 setweaponammoclip(self.var_5C39,var_07);
			}

			var_08 = 0;
			if(var_00 getweaponammostock(self.var_5C39) < weaponmaxammo(self.var_5C39))
			{
				var_08 = 1;
			}

			var_09 = weaponaltweaponname(self.var_5C39);
			if(var_09 != "none" && var_00 getweaponammostock(var_09) < weaponmaxammo(var_09))
			{
				var_08 = 1;
			}

			if(self.var_5C39 == "flash_grenade" || self.var_5C39 == "claymore" || self.var_5C39 == "c4")
			{
				var_08 = 1;
				maps/_so_survival_chaos::chaos_score_event_raise("old_weapon_collect");
			}

			if(var_08)
			{
				if(self.var_5C39 != "claymore" && self.var_5C39 != "c4")
				{
					var_00 setweaponammostock(self.var_5C39,weaponmaxammo(self.var_5C39));
				}

				var_09 = weaponaltweaponname(self.var_5C39);
				if(var_09 != "none")
				{
					var_00 setweaponammostock(var_09,weaponmaxammo(var_09));
				}

				maps/_so_survival_chaos::chaos_score_event_raise("weapon_ammo");
				if(self.var_5C39 != "flash_grenade" && self.var_5C39 != "claymore" && self.var_5C39 != "c4")
				{
					var_00 switchtoweapon(self.var_5C39);
				}

				var_01 = 1;
			}
		}

		if(var_01)
		{
			common_scripts\utility::array_call(self.weapon_models,::hide);
			foreach(var_0B in level.players)
			{
				if(isdefined(self.headiconforplayer[var_0B.unique_id]))
				{
					self.headiconforplayer[var_0B.unique_id] destroy();
				}
			}

			self.weapon_in_use = 1;
			if(var_02 == 1)
			{
				maps/_so_survival_chaos::radio_dialogue_to_player(var_00,"chaos_new_weapon",1);
			}

			wait 25;
			if(self.var_5C39 == "flash_grenade" || self.var_5C39 == "claymore" || self.var_5C39 == "c4")
			{
				if(self.var_5C39 == "claymore" || self.var_5C39 == "c4")
				{
					var_0D = weaponclipsize(self.var_5C39) - 5;
				}
				else
				{
					var_0D = weaponclipsize(self.var_5C39);
				}

				for(;;)
				{
					var_0E = 0;
					foreach(var_0B in level.players)
					{
						if(var_0B getammocount(self.var_5C39) < var_0D)
						{
							var_0E = 1;
						}
					}

					if(var_0E == 0)
					{
						wait 0.5;
						continue;
					}

					break;
				}
			}
			else
			{
				for(;;)
				{
					var_11 = 0;
					foreach(var_0B in level.players)
					{
						if(var_0B hasweapon(self.var_5C39))
						{
							var_11 = 1;
						}
					}

					if(var_11 == 1)
					{
						wait 0.5;
						continue;
					}

					break;
				}
			}

			common_scripts\utility::array_call(self.weapon_models,::show);
			self.weapon_in_use = 0;
		}
	}
}

//Function Number: 20
chaos_load_drop_location()
{
	if(!isdefined(level.chaos_drop_location_table))
	{
		level.chaos_drop_location_table = "sp/survival_chaos_drop_locations.csv";
	}

	var_00 = getdvar("mapname");
	for(var_01 = 100;var_01 <= 1700;var_01++)
	{
		var_02 = get_level(var_01);
		if(!isdefined(var_02) || var_02 == "" || var_02 != var_00)
		{
			continue;
		}

		var_03 = get_level_drop_location(var_01);
		if(!isdefined(var_03) || var_03 == "")
		{
			continue;
		}

		var_04 = strtok(var_03,",");
		if(!isdefined(var_04) || var_04.size != 3)
		{
			continue;
		}

		if(!isdefined(level.chaos_drop_locations))
		{
			level.chaos_drop_locations = [];
		}

		level.chaos_drop_locations[level.chaos_drop_locations.size] = (float(var_04[0]),float(var_04[1]),float(var_04[2]));
	}
}

//Function Number: 21
chaos_load_drop_item()
{
	if(!isdefined(level.chaos_drop_item_table))
	{
		level.chaos_drop_item_table = "sp/survival_chaos_drop_items.csv";
	}

	var_00 = getdvar("mapname");
	for(var_01 = 100;var_01 <= 1700;var_01++)
	{
		var_02 = get_level(var_01);
		if(!isdefined(var_02) || var_02 == "" || var_02 != var_00)
		{
			continue;
		}

		var_03 = get_level_drop_wave(var_01);
		var_04 = "wave_" + var_03;
		var_05 = get_level_drop_item(var_01);
		if(!isdefined(var_05) || var_05 == "")
		{
			continue;
		}

		var_06 = strtok(var_05,";");
		if(!isdefined(level.chaos_drop_items))
		{
			level.chaos_drop_items = [];
		}

		level.chaos_drop_items[var_04] = var_06;
	}
}

//Function Number: 22
chaos_load_desired_drop_distance()
{
	if(!isdefined(level.desired_drop_distance_table))
	{
		level.desired_drop_distance_table = "sp/survival_chaos_drop_distance.csv";
	}

	var_00 = getdvar("mapname");
	for(var_01 = 100;var_01 <= 1700;var_01++)
	{
		var_02 = get_drop_distance_level(var_01);
		if(isdefined(var_02) && var_02 == var_00)
		{
			var_03 = get_level_desired_drop_distance(var_01);
			level.map_specific_desired_drop_distance = float(var_03);
			var_04 = get_level_starting_lives_remaining(var_01);
			if(chaos_is_coop())
			{
				level.map_specific_starting_lives_remaining = 3;
			}
			else
			{
				level.map_specific_starting_lives_remaining = float(var_04);
			}
		}
	}
}

//Function Number: 23
chaos_is_coop()
{
	if(issplitscreen() || getdvar("coop") == "1")
	{
		return 1;
	}

	return 0;
}

//Function Number: 24
chaos_load_ai_size()
{
	if(!isdefined(level.constant_ai_size_table))
	{
		level.constant_ai_size_table = "sp/survival_chaos_constant_ai_size.csv";
	}

	var_00 = getdvar("mapname");
	for(var_01 = 100;var_01 <= 1700;var_01++)
	{
		var_02 = get_ai_size_level(var_01);
		if(isdefined(var_02) && var_02 == var_00)
		{
			var_03 = get_level_ai_size_wave(var_01);
			var_04 = get_level_ai_size(var_01);
			if(!isdefined(level.map_specific_ai_size))
			{
				level.map_specific_ai_size = [];
			}

			var_05 = "wave_" + var_03;
			level.map_specific_ai_size[var_05] = float(var_04);
		}
	}
}