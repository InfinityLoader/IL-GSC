/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\cp_interaction.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 104
 * Decompile Time: 5119 ms
 * Timestamp: 10/27/2023 12:09:29 AM
*******************************************************************/

//Function Number: 1
func_4627()
{
	func_96E3();
	level thread func_23D8();
	if(scripts\cp\_utility::func_462B("guided_interaction"))
	{
		level thread func_23CB();
	}
}

//Function Number: 2
init()
{
	scripts\common\utility::flag_init("init_interaction_done");
	if(!scripts\common\utility::flag("init_spawn_volumes_done"))
	{
		scripts\common\utility::flag_wait("init_spawn_volumes_done");
	}

	level.interactions = [];
	level.interaction_hintstrings = [];
	level.var_1BEC = scripts\common\utility::getstructarray("interaction","targetname");
	level.current_interaction_structs = level.var_1BEC;
	level.var_9A46 = 0;
	level.var_13C1B = ::func_502F;
	level.var_13C63 = ::func_5030;
	level thread func_9A3D();
	foreach(var_01 in level.current_interaction_structs)
	{
		if(!isdefined(var_01.name))
		{
			var_01.name = var_01.script_noteworthy;
		}

		if(!isdefined(var_01.var_EE79))
		{
			var_01.var_EE79 = "default";
		}

		if(var_01.var_EE79 == "requires_power")
		{
			var_01.var_E1B9 = 1;
			var_01.var_D776 = 0;
			var_01.var_D71C = func_7829(var_01);
			continue;
		}

		var_01.var_E1B9 = 0;
		var_01.var_D776 = 0;
	}

	level thread func_5CF3();
	if(isdefined(level.var_768C))
	{
		[[ level.var_768C ]]();
	}

	if(isdefined(level.map_interaction_func))
	{
		[[ level.map_interaction_func ]]();
	}

	var_03 = getarraykeys(level.interactions);
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		if(isdefined(level.interactions[var_03[var_04]].var_95F2))
		{
			level thread [[ level.interactions[var_03[var_04]].var_95F2 ]]();
		}

		scripts\common\utility::func_136F7();
	}

	scripts\common\utility::flag_set("init_interaction_done");
	foreach(var_06 in level.players)
	{
		var_07 = var_06 getcurrentweapon();
		if(isdefined(level.wave_num) && isdefined(var_07))
		{
			self.var_13BE8 = [level.wave_num][var_07];
		}
	}

	level thread func_C00C();
	level thread func_4616();
}

//Function Number: 3
func_5CF3()
{
	if(!scripts\common\utility::func_6E34("wall_buy_setup_done"))
	{
		scripts\common\utility::flag_init("wall_buy_setup_done");
	}

	if(!scripts\common\utility::flag("wall_buy_setup_done"))
	{
		scripts\common\utility::flag_wait("wall_buy_setup_done");
	}

	foreach(var_01 in level.var_1BEC)
	{
		if(isdefined(var_01.var_86A2) && var_01.var_86A2 == "locOverride")
		{
			continue;
		}

		var_02 = scripts\common\utility::func_5D14(var_01.origin,10,-200);
		var_01.origin = var_02 + (0,0,1);
		wait(0.05);
	}
}

//Function Number: 4
func_7829(param_00)
{
	var_01 = getentarray("spawn_volume","targetname");
	foreach(var_03 in var_01)
	{
		if(function_010F(param_00.origin,var_03))
		{
			if(isdefined(var_03.var_28AB))
			{
				return var_03.var_28AB;
			}
		}
	}

	return undefined;
}

//Function Number: 5
func_96E3()
{
	var_00 = getentarray("player_use_trigger","targetname");
	foreach(var_02 in var_00)
	{
		var_02.var_93A8 = 0;
		var_02 scripts\common\utility::trigger_off();
	}
}

//Function Number: 6
func_23CB()
{
	level endon("game_ended");
	wait(5);
	for(;;)
	{
		var_00 = getentarray("interactionEnt","targetname");
		foreach(var_02 in level.players)
		{
			if(!scripts\common\utility::istrue(var_02.var_23DE))
			{
				var_02.var_23DE = 1;
				var_03 = spawn("script_model",var_02.origin);
				var_02.guidedinteractionent = var_03;
				var_03 thread func_DF3C(var_02);
				var_03 thread func_BC88(var_02);
				var_02 setclientomnvar("zm_interaction_cost",-1);
				var_02 setclientomnvar("zm_interaction_ent",var_03);
				if(scripts\cp\_utility::isplayingsolo() || level.only_one_player)
				{
					var_02 thread scripts\cp\zombies\interaction_magicwheel::magic_wheel_tutorial();
					var_02 thread lib_0D4C::func_59FA();
				}
			}
		}

		level waittill("player_spawned",var_02);
	}
}

//Function Number: 7
func_BC88(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	var_01 = undefined;
	var_02 = undefined;
	var_03 = -1;
	var_04 = 0;
	var_05 = squared(75);
	for(;;)
	{
		if(scripts\common\utility::istrue(param_00.inlaststand) || scripts\common\utility::istrue(param_00.var_101BF) || scripts\common\utility::istrue(param_00.flung))
		{
			var_01 = undefined;
			func_12E34(param_00,-1,undefined,undefined);
		}
		else if(!param_00 scripts\cp\_utility::func_213E())
		{
			var_01 = undefined;
			func_12E34(param_00,-1,undefined,undefined);
		}
		else
		{
			var_06 = [];
			level.current_interaction_structs = scripts\common\utility::func_22BC(level.current_interaction_structs);
			var_07 = scripts\common\utility::func_782F(param_00.origin,level.current_interaction_structs,undefined,10,750,1);
			foreach(var_09 in param_00.var_55BB)
			{
				var_07 = scripts\common\utility::func_22A9(var_07,var_09);
			}

			foreach(var_09 in var_07)
			{
				if(func_9C64(param_00,var_09,var_01))
				{
					var_06[var_06.size] = var_09;
				}
			}

			if(scripts\common\utility::istrue(param_00.resetguidedinteraction))
			{
				var_01 = undefined;
				func_12E34(param_00,-1,undefined,undefined);
				param_00.resetguidedinteraction = undefined;
				wait(0.05);
				continue;
			}

			var_06 = scripts\common\utility::func_22BC(var_06);
			var_06 = scripts\common\utility::func_22AF(var_06);
			if(var_06.size < 1)
			{
				var_01 = undefined;
				func_12E34(param_00,-1,undefined,undefined);
				wait(0.05);
				continue;
			}

			var_06 = sortbydistance(var_06,param_00.origin);
			foreach(var_0E in var_06)
			{
				var_04 = 0;
				if(param_00 adsbuttonpressed())
				{
					func_12E34(param_00,-1,undefined,undefined);
					var_01 = undefined;
					while(param_00 adsbuttonpressed())
					{
						wait(0.05);
					}
				}

				if(distancesquared(param_00.origin,var_0E.origin) <= var_05)
				{
					func_12E34(param_00,-1,undefined,undefined);
					var_01 = undefined;
					continue;
				}
				else if(isdefined(var_01) && var_0E == var_01)
				{
					break;
				}
				else
				{
					var_02 = func_7A4A(var_0E,param_00);
					var_03 = func_7A48(var_0E,param_00);
					var_01 = var_0E;
					var_04 = 1;
					break;
				}
			}

			if(var_04)
			{
				func_12E34(param_00,var_03,var_02,var_01);
			}
		}

		wait(0.1);
	}
}

//Function Number: 8
func_7A4A(param_00,param_01)
{
	var_02 = (0,0,68);
	var_03 = param_00.origin;
	if(func_9A28(param_00))
	{
		if(isdefined(param_00.target))
		{
			var_04 = scripts\common\utility::getstruct(param_00.target,"targetname");
			if(isdefined(var_04))
			{
				var_03 = var_04.origin;
			}
			else
			{
				var_03 = param_00.origin;
			}
		}
	}
	else if(!isdefined(var_03))
	{
		var_03 = param_00.origin;
	}

	if(isdefined(level.guided_interaction_offset_func))
	{
		var_02 = [[ level.guided_interaction_offset_func ]](param_00,param_01);
	}
	else
	{
		var_05 = func_7829(param_00);
		if(isdefined(param_00.name))
		{
			var_06 = param_00.script_noteworthy;
			switch(var_06)
			{
				case "iw7_ripper_zm+ripperscope_zm":
				case "iw7_ripper_zmr":
				case "shooting_gallery":
					var_02 = (0,0,12);
					break;

				case "iw7_ake_zm":
				case "iw7_ake_zml":
					if(var_05 == "swamp_stage")
					{
						var_02 = (0,0,12);
					}
					break;

				case "zfreeze_semtex_mp":
					var_02 = (0,0,20);
					break;

				case "iw7_sonic_zmr":
				case "iw7_sonic_zm":
					if(var_05 == "moon")
					{
						var_02 = (0,0,30);
					}
					else
					{
						var_02 = (0,0,56);
					}
					break;

				default:
					var_02 = (0,0,56);
					break;
			}
		}
	}

	var_07 = scripts\common\utility::func_5D14(var_03,12) + var_02;
	return var_07;
}

//Function Number: 9
func_7A48(param_00,param_01)
{
	var_02 = 1;
	var_03 = int(level.interactions[param_00.script_noteworthy].cost);
	if(func_9A28(param_00))
	{
		if(param_01 scripts\cp\_weapon::func_8BBB(param_00.script_noteworthy))
		{
			var_04 = scripts\cp\_utility::func_80D8(param_00.script_noteworthy);
			var_05 = param_01 scripts\cp\_weapon::func_7D62(var_04);
			if(var_05 > 1)
			{
				var_03 = 4500;
			}
			else
			{
				var_02 = 0.5;
				var_03 = int(var_03 * var_02);
			}
		}
		else
		{
			var_03 = int(var_03 * var_02);
		}
	}
	else if(func_9A29(param_00))
	{
		var_06 = param_01 getcurrentweapon();
		if(param_01 scripts\cp\_weapon::func_385F(var_06))
		{
			var_05 = param_01 scripts\cp\_weapon::func_7D62(var_06);
			var_03 = scripts\common\utility::func_116D7(var_05 > 1,10000,5000);
		}
		else
		{
			var_03 = 0;
		}

		if(scripts\common\utility::istrue(level.has_picked_up_fuses) && !isdefined(level.placed_alien_fuses))
		{
			var_03 = 0;
		}
	}
	else if(func_9CDB(param_00))
	{
		if(isdefined(param_00.name) && !param_01 func_3867(param_00))
		{
			var_03 = 0;
		}
		else if((scripts\cp\_utility::isplayingsolo() || level.only_one_player) && isdefined(param_00.name) && param_00.name == "perk_machine_revive")
		{
			var_03 = 500;
		}
		else
		{
			var_03 = func_7B78(param_00);
		}
	}
	else if(func_9A1A(param_00))
	{
		if(param_01.var_3A52 >= 1)
		{
			var_03 = level.var_732D;
		}
		else
		{
			var_03 = level.var_732C;
		}
	}

	if(param_01 scripts\cp\_utility::func_9BA0("next_purchase_free"))
	{
		var_03 = 0;
	}

	return var_03;
}

//Function Number: 10
func_9CDB(param_00)
{
	if(!isdefined(param_00.name))
	{
		return 0;
	}

	if(param_00.name == "perk_machine_more" || param_00.name == "perk_machine_rat_a_tat" || param_00.name == "perk_machine_revive" || param_00.name == "perk_machine_run" || param_00.name == "perk_machine_smack" || param_00.name == "perk_machine_tough" || param_00.name == "perk_machine_flash" || param_00.name == "perk_machine_boom" || param_00.name == "perk_machine_fwoosh" || param_00.name == "perk_machine_deadeye" || param_00.name == "perk_machine_change" || param_00.name == "perk_machine_zap")
	{
		return 1;
	}

	return 0;
}

//Function Number: 11
func_7B78(param_00)
{
	switch(param_00.var_CA4C)
	{
		case "perk_machine_deadeye":
		case "perk_machine_zap":
		case "perk_machine_fwoosh":
		case "perk_machine_boom":
		case "perk_machine_change":
		case "perk_machine_revive":
			return 1500;

		case "perk_machine_flash":
			return 3000;

		case "perk_machine_tough":
			return 2500;

		case "perk_machine_run":
		case "perk_machine_more":
		case "perk_machine_rat_a_tat":
		case "perk_machine_smack":
			return 2000;
	}
}

//Function Number: 12
func_9C64(param_00,param_01,param_02)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	if(!isdefined(param_01))
	{
		return 0;
	}

	var_03 = undefined;
	if(isdefined(param_01.name))
	{
		var_03 = param_01.name;
	}
	else
	{
		return 0;
	}

	if(scripts\common\utility::istrue(param_01.out_of_order) || isdefined(param_01.var_4622))
	{
		return 0;
	}

	if(isdefined(param_01.var_CA4C) && param_01.var_CA4C == "perk_machine_revive" && param_00.var_F1E7 >= param_00.max_self_revive_machine_use)
	{
		return 0;
	}

	if(!scripts\cp\_utility::func_462B("wall_buys"))
	{
		if(func_9A28(param_01) || func_9A1B(param_01) || func_9A24(param_01) || interaction_is_chi_door(param_01) || isdefined(param_01.var_EE79) && param_01.var_EE79 == "tickets")
		{
			return 0;
		}
	}

	if(func_9A1A(param_01))
	{
		if(!scripts\common\utility::istrue(level.unlimited_fnf))
		{
			if(param_00.var_3A52 >= 2)
			{
				return 0;
			}
		}
	}

	if(var_03 == "secure_window" || var_03 == "white_ark" || var_03 == "wor_standee" || var_03 == "generator" || var_03 == "center_speaker_locs" || var_03 == "fourth_speaker" || var_03 == "ark_quest_station" || var_03 == "dj_quest_part_1" || var_03 == "dj_quest_part_2" || var_03 == "dj_quest_part_3" || var_03 == "dj_quest_door" || var_03 == "dj_quest_speaker" || var_03 == "lost_and_found" || var_03 == "fast_travel" || var_03 == "crafting_pickup" || var_03 == "pap_quest" || var_03 == "team_door" || var_03 == "neil_head" || var_03 == "neil_battery" || var_03 == "neil_repair" || var_03 == "neil_firmware" || var_03 == "barnstorming_group" || var_03 == "demon_group" || var_03 == "starmaster_group" || var_03 == "group_cosmicarc" || var_03 == "group_pitfall" || var_03 == "group_riverraid" || var_03 == "spider_arcade_group" || var_03 == "robottank_group" || var_03 == "gator_teeth_placement" || var_03 == "atm_withdrawal" && isdefined(level.var_2416) && level.var_2416 < 1000 || var_03 == "crafting_station" && !isdefined(param_00.var_4B5E))
	{
		return 0;
	}

	if(isdefined(level.guidedinteractionexclusion))
	{
		if(![[ level.guidedinteractionexclusion ]](param_01,param_00,var_03))
		{
			return 0;
		}
	}

	if(scripts\common\utility::istrue(param_01.var_E1B9) && !scripts\common\utility::istrue(param_01.var_D776))
	{
		return 0;
	}

	if(var_03 == "boss_fight_activation")
	{
		if(scripts\common\utility::func_6E34("boss_fight_ready_soon") && scripts\common\utility::flag("boss_fight_ready_soon"))
		{
			return 0;
		}
		else
		{
			return 1;
		}
	}

	if(isdefined(level.var_164B))
	{
		if(var_03 == "weapon_upgrade")
		{
			return 1;
		}
		else if(!self [[ level.var_164B ]](param_01.origin))
		{
			return 0;
		}
	}

	var_04 = param_01.origin;
	if(isdefined(level.guidedinteractionendposoverride))
	{
		var_04 = [[ level.guidedinteractionendposoverride ]](param_00,param_01);
	}

	if(!scripts\common\utility::func_13D90(param_00.origin,param_00 getplayerangles(),var_04,cos(25)))
	{
		return 0;
	}

	if(func_9A18(param_01) || interaction_is_chi_door(param_01))
	{
		var_05 = func_7C82(0,undefined,param_00);
		foreach(var_07 in var_05)
		{
			var_08 = var_07 func_77D3();
			foreach(var_0A in var_08)
			{
				if(function_010F(param_01.origin,var_0A))
				{
					return 0;
				}
			}
		}
	}

	var_0D = physics_createcontents(["physicscontents_clipshot","physicscontents_corpseclipshot","physicscontents_missileclip","physicscontents_solid"]);
	if(param_01.script_noteworthy == "trap_hydrant")
	{
		var_04 = param_01.origin + (0,0,50);
	}

	if(scripts\common\trace::func_DCF1(param_00 geteye(),var_04,[param_00],var_0D))
	{
		return 1;
	}

	return 0;
}

//Function Number: 13
func_77D3()
{
	if(isdefined(level.var_186E[self.var_28AB]))
	{
		var_00 = [];
		foreach(var_02 in level.var_186E[self.var_28AB])
		{
			var_00[var_00.size] = level.var_10817[var_02];
		}

		return var_00;
	}

	return [];
}

//Function Number: 14
func_9C0F(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(!isdefined(param_00.var_186E))
	{
		return 0;
	}

	foreach(var_02 in param_00.var_186E)
	{
		if(!var_02.var_19)
		{
			continue;
		}

		if(self istouching(var_02))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 15
func_7C82(param_00,param_01,param_02)
{
	if(isdefined(level.var_7C80))
	{
		return [[ level.var_7C80 ]]();
	}

	var_03 = [];
	var_04 = level.var_10816;
	foreach(var_06 in var_04)
	{
		if(!var_06.var_19)
		{
			continue;
		}

		var_07 = 0;
		if(isdefined(param_01) && !param_02 scripts\cp\_utility::is_valid_player())
		{
			continue;
		}

		if(param_02 istouching(var_06))
		{
			var_07 = 1;
		}
		else if(scripts\common\utility::istrue(param_00) && param_02 func_9C0F(var_06))
		{
			var_07 = 1;
		}

		if(var_07)
		{
			var_03[var_03.size] = var_06;
		}
	}

	return var_03;
}

//Function Number: 16
func_12E34(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_01))
	{
		param_01 = -1;
	}

	if(isdefined(param_02) && param_02 != self.origin)
	{
		param_00 setclientomnvar("zm_interaction_cost",-1);
		wait(0.1);
		self dontinterpolate();
		self.origin = param_02;
		wait(0.1);
	}

	if(isdefined(param_03) && param_03.var_EE79 == "tickets")
	{
		param_01 = 2;
	}

	if(isdefined(param_03) && interaction_is_sliding_door(param_03) && scripts\common\utility::istrue(param_03.player_opened))
	{
		param_01 = 0;
	}

	param_00 setclientomnvar("zm_interaction_cost",param_01);
}

//Function Number: 17
func_79D0(param_00)
{
	foreach(var_02 in param_00)
	{
		if(!scripts\common\utility::istrue(var_02.var_93A8))
		{
			var_02.var_93A8 = 1;
			var_02 setmodel("tag_origin");
			return var_02;
		}
	}
}

//Function Number: 18
func_DF3C(param_00)
{
	param_00 waittill("disconnect");
	self.var_93A8 = 0;
	self notify("interaction_ent_released");
}

//Function Number: 19
func_23D8()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("player_spawned",var_00);
		var_00.var_9A3F = func_7B99();
		if(!isdefined(var_00.var_9A3F))
		{
			break;
		}

		func_E1F8();
		if(!isdefined(var_00.var_9A3F))
		{
			iprintlnbold("NO TRIGGER FOUND!");
		}

		var_00.var_A8D3 = undefined;
		var_00.var_9A3F makeunusable();
		var_00 thread func_DF3F();
		var_00 thread player_interaction_monitor();
		var_00 thread func_D104();
	}
}

//Function Number: 20
func_D104()
{
	self endon("disconnect");
	self endon("death");
	for(;;)
	{
		scripts\common\utility::waittill_any_3("weapon_switch_started","weapon_change","weaponchange");
		self.var_A8D3 = undefined;
		self.resetguidedinteraction = 1;
		self notify("stop_interaction_logic");
	}
}

//Function Number: 21
func_7B99()
{
	var_00 = getentarray("player_use_trigger","targetname");
	var_01 = undefined;
	foreach(var_03 in var_00)
	{
		if(!var_03.var_93A8)
		{
			var_03.var_93A8 = 1;
			var_03 scripts\common\utility::trigger_on();
			return var_03;
		}
	}

	return undefined;
}

//Function Number: 22
func_DF3F()
{
	var_00 = self.var_9A3F;
	scripts\common\utility::waittill_any_3("death","disconnect");
	var_00.var_93A8 = 0;
}

//Function Number: 23
func_DEBB(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = spawnstruct();
	var_09.name = param_00;
	var_09.var_8FFA = param_03;
	var_09.var_109DA = param_01;
	var_09.var_12AA2 = param_02;
	var_09.var_161A = param_04;
	var_09.var_6261 = 1;
	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	var_09.cost = param_05;
	if(isdefined(param_06))
	{
		var_09.var_E1B9 = param_06;
	}
	else
	{
		var_09.var_E1B9 = 0;
	}

	var_09.var_95F2 = param_07;
	var_09.var_3865 = param_08;
	level.interactions[param_00] = var_09;
}

//Function Number: 24
func_15BC(param_00,param_01)
{
	level thread [[ level.interactions[param_00].var_161A ]](param_01);
}

//Function Number: 25
func_E1F8()
{
	foreach(var_01 in level.players)
	{
		if(isdefined(var_01.var_9A3F))
		{
			func_8E90(var_01);
		}
	}
}

//Function Number: 26
func_8E90(param_00)
{
	foreach(var_02 in level.players)
	{
		if(var_02 == param_00)
		{
			param_00.var_9A3F enableplayeruse(param_00);
			continue;
		}

		param_00.var_9A3F disableplayeruse(var_02);
	}
}

//Function Number: 27
func_13D07(param_00,param_01)
{
	for(;;)
	{
		thread scripts\common\utility::func_5B44(param_01,0.1,(1,0,0),1,0.1);
		wait(0.1);
	}
}

//Function Number: 28
player_interaction_monitor()
{
	self notify("player_interaction_monitor");
	self endon("player_interaction_monitor");
	self endon("disconnect");
	self endon("death");
	while(!isdefined(level.current_interaction_structs))
	{
		wait(1);
	}

	if(isdefined(level.player_interaction_monitor))
	{
		self thread [[ level.player_interaction_monitor ]]();
	}
}

//Function Number: 29
func_6EB9()
{
	self endon("window_trap_placed");
	self endon("death");
	if(!isdefined(self.var_BF46))
	{
		self.var_BF46 = gettime() + 2500;
	}
	else if(gettime() < self.var_BF46)
	{
		return;
	}

	self.var_BF46 = gettime() + 2500;
	self setclientomnvar("zom_crafted_weapon",0);
	wait(0.5);
	self setclientomnvar("zom_crafted_weapon",8);
	wait(1.5);
}

//Function Number: 30
func_3863(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(self.var_9D81))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(param_00.var_55BA) || !scripts\cp\_utility::func_213E() || self method_84D9())
	{
		return 0;
	}

	if(self secondaryoffhandbuttonpressed() || self method_81C6() || self fragbuttonpressed())
	{
		return 0;
	}

	if(!self isonground())
	{
		return 0;
	}

	if(param_00.script_noteworthy == "game_race" && distancesquared(self.origin,param_00.origin) > 576)
	{
		return 0;
	}

	if(param_00.script_noteworthy == "ritual_stone" && scripts\common\utility::istrue(self.var_DCEB))
	{
		return 0;
	}

	return 1;
}

//Function Number: 31
func_E1F6()
{
	if(isdefined(self.var_9A3F.name))
	{
		scripts\cp\zombies\zombie_analytics::func_AF74(self.var_9A3F.name,0);
	}

	wait(0.2);
	self notify("stop_interaction_logic");
	self.var_9A3F makeunusable();
	self.var_A8D3 = undefined;
	self setclientomnvar("zm_tutorial_num",0);
}

//Function Number: 32
func_F421(param_00,param_01)
{
	if(scripts\common\utility::istrue(self.var_9A3F.var_55F3))
	{
		return;
	}

	self.var_9A3F dontinterpolate();
	self.var_A8D3 = param_00;
	var_02 = self geteye();
	self.var_9A3F.origin = (param_00.origin[0],param_00.origin[1],var_02[2]);
	if(!isdefined(level.interactions[param_00.script_noteworthy].var_109DA))
	{
		level.interactions[param_00.script_noteworthy].var_109DA = "null";
	}

	var_03 = level.interactions[param_00.script_noteworthy].var_109DA;
	var_04 = undefined;
	if(scripts\cp\_utility::isplayingsolo() || level.only_one_player)
	{
		if(var_03 == "wall_buy")
		{
			var_04 = scripts\cp\_hud_message::func_79FC("wall_buy");
		}

		if(!scripts\common\utility::istrue(var_04))
		{
			if(isdefined(level.interactions[param_00.script_noteworthy].var_12AA2))
			{
				thread scripts\cp\_hud_message::func_12AAE(var_03);
			}
		}
	}

	if(func_9A28(param_00))
	{
		if(!scripts\cp\_weapon::func_8BBB(param_00.script_noteworthy))
		{
			var_05 = func_8228(param_00.script_noteworthy);
			var_06 = func_8220(param_00.script_noteworthy);
			self.var_9A3F method_852E(var_05,var_06);
		}
	}
	else if(func_9A29(param_00))
	{
		var_07 = self getcurrentweapon();
		var_05 = func_8228(var_07);
		if(scripts\cp\_weapon::func_385F(var_07))
		{
			if(isdefined(var_05))
			{
				var_08 = scripts\cp\_weapon::func_7D62(var_07);
				var_06 = scripts\common\utility::func_116D7(var_08 > 1,int(10000),int(5000));
				self.var_9A3F method_852E(var_05,var_06);
			}
		}
		else if(isdefined(var_05))
		{
			self.var_9A3F method_852E(var_05);
		}
	}
	else if(func_9A16(param_00))
	{
		if(!isdefined(self.var_4B5E))
		{
			level thread [[ level.interactions[param_00.script_noteworthy].var_161A ]](param_00,self);
			func_9A34(param_00);
			self notify("new_power","souvenir_pickup");
			if(scripts\cp\_utility::map_check(0))
			{
				thread scripts\cp\_vo::func_1769("nag_use_souvenircoin","zmb_comment_vo",60,180,6,1);
			}

			return;
		}

		self.var_9A3F.origin = param_00.origin;
	}
	else if(func_9A26(param_00))
	{
		self.var_9A3F.origin = (param_00.origin[0],param_00.origin[1],var_02[2] - 15);
	}
	else if(func_9A15(param_00) && param_00.script_noteworthy == "atm_withdrawal")
	{
		self.var_9A3F method_852E(level.var_2416);
	}
	else if(func_9A1A(param_00))
	{
		if(self.var_3A52 >= 1)
		{
			self.var_9A3F method_852E(level.var_732D);
		}
		else
		{
			self.var_9A3F method_852E(level.var_732C);
		}
	}
	else if(param_00.script_noteworthy == "spawned_essence")
	{
		self.var_9A3F.origin = param_00.origin;
	}

	func_F422(self.var_9A3F,param_00);
	if(!isdefined(param_01))
	{
		thread func_135DF(param_00);
	}

	self.var_9A3F makeusable();
}

//Function Number: 33
func_8228(param_00)
{
	if(!isdefined(param_00))
	{
		return undefined;
	}

	var_01 = scripts\cp\_utility::func_7DF7(param_00);
	if(!isdefined(var_01))
	{
		return undefined;
	}

	switch(var_01)
	{
		case "iw7_wylerdagger":
			return &"CP_QUEST_WOR_PURCHASE_SPEAKER";

		case "iw7_udm45":
			return &"CP_ZMB_WEAPONS_UDM45";

		case "iw7_rvn":
			return &"CP_ZMB_WEAPONS_RVN";

		case "iw7_ake":
			return &"CP_ZMB_WEAPONS_AKE";

		case "iw7_lmg03":
			return &"CP_ZMB_WEAPONS_LMG03";

		case "iw7_ar57":
			return &"CP_ZMB_WEAPONS_AR57";

		case "iw7_arclassic":
			return &"CP_ZMB_WEAPONS_ARCLASSIC";

		case "iw7_axe":
			return &"CP_ZMB_WEAPONS_AXE";

		case "iw7_lockon":
			return &"CP_ZMB_WEAPONS_LOCKON";

		case "iw7_chargeshot":
			return &"CP_ZMB_WEAPONS_CHARGESHOT";

		case "iw7_cheytacc":
			return &"CP_ZMB_WEAPONS_CHEYTACC";

		case "iw7_cheytac":
			return &"CP_ZMB_WEAPONS_CHEYTAC";

		case "iw7_crb":
			return &"CP_ZMB_WEAPONS_CRB";

		case "iw7_devastator":
			return &"CP_ZMB_WEAPONS_DEVASTATOR";

		case "iw7_dischord":
			return &"CP_ZMB_WEAPONS_DISCHORD";

		case "iw7_emc":
			return &"CP_ZMB_WEAPONS_EMC";

		case "iw7_erad":
			return &"CP_ZMB_WEAPONS_ERAD";

		case "iw7_facemelter":
			return &"CP_ZMB_WEAPONS_FACE_MELTER";

		case "iw7_fhr":
			return &"CP_ZMB_WEAPONS_FHR";

		case "iw7_fmg":
			return &"CP_ZMB_WEAPONS_FMG";

		case "iw7_forgefreeze":
			return &"CP_ZMB_WEAPONS_FORGE_FREEZE";

		case "iw7_g18c":
			return &"CP_ZMB_WEAPONS_G18C";

		case "iw7_g18":
			return &"CP_ZMB_WEAPONS_G18";

		case "iw7_glprox":
			return &"CP_ZMB_WEAPONS_GLPROX";

		case "iw7_headcutter":
			return &"CP_ZMB_WEAPONS_HEAD_CUTTER";

		case "iw7_kbs":
			return &"CP_ZMB_WEAPONS_KBS";

		case "iw7_m1":
			return &"CP_ZMB_WEAPONS_M1";

		case "iw7_m1c":
			return &"CP_ZMB_WEAPONS_M1C";

		case "iw7_m4":
			return &"CP_ZMB_WEAPONS_M4";

		case "iw7_m8":
			return &"CP_ZMB_WEAPONS_M8";

		case "iw7_mauler":
			return &"CP_ZMB_WEAPONS_MAULER";

		case "iw7_nrg":
			return &"CP_ZMB_WEAPONS_NRG";

		case "iw7_revolver":
			return &"CP_ZMB_WEAPONS_REVOLVER";

		case "iw7_ripper":
			return &"CP_ZMB_WEAPONS_RIPPER";

		case "iw7_sdfar":
			return &"CP_ZMB_WEAPONS_SDFAR";

		case "iw7_sdflmg":
			return &"CP_ZMB_WEAPONS_SDFLMG";

		case "iw7_sdfshotty":
			return &"CP_ZMB_WEAPONS_SDFSHOTTY";

		case "iw7_shredder":
			return &"CP_ZMB_WEAPONS_SHREDDER";

		case "iw7_sonic":
			return &"CP_ZMB_WEAPONS_SONIC";

		case "iw7_spasc":
			return &"CP_ZMB_WEAPONS_SPASC";

		case "iw7_spas":
			return &"CP_ZMB_WEAPONS_SPAS";

		case "iw7_steeldragon":
			return &"CP_ZMB_WEAPONS_STEEL_DRAGON";

		case "iw7_ump45c":
			return &"CP_ZMB_WEAPONS_UMP45C";

		case "iw7_ump45":
			return &"CP_ZMB_WEAPONS_UMP45";

		case "iw7_vr":
			return &"CP_ZMB_WEAPONS_VR";

		case "iw7_crdb":
			return &"CP_ZMB_WEAPONS_CRDB";

		case "iw7_minilmg":
			return &"CP_ZMB_WEAPONS_MINILMG";

		case "iw7_mp28":
			return &"CP_ZMB_WEAPONS_MP28";

		case "iw7_mod2187":
			return &"CP_ZMB_WEAPONS_MOD2187";

		case "iw7_ba50cal":
			return &"CP_ZMB_WEAPONS_BA50CAL";

		case "iw7_longshot":
			return &"CP_ZMB_WEAPONS_LONGSHOT";

		case "iw7_gauss":
			return &"CP_ZMB_WEAPONS_GAUSS";

		case "iw7_tacburst":
			return &"CP_ZMB_WEAPONS_TACBURST";

		case "iw7_unsalmg":
			return &"CP_ZMB_WEAPONS_UNSALMG";

		case "iw7_mag":
			return &"CP_ZMB_WEAPONS_MAG";

		case "iw7_cutie":
		case "iw7_cutier_zm":
		case "iw7_cutie_zm":
			return &"CP_ZMB_WEAPONS_MAD";

		case "iw7_venomx":
		case "iw7_venomx_zm_pap2":
		case "iw7_venomx_zm_pap1":
		case "iw7_venomx_zm":
			return &"CP_FINAL_VENOMX";

		default:
			if(isdefined(level.custom_weaponnamestring_func))
			{
				return [[ level.custom_weaponnamestring_func ]](var_01,param_00);
			}
			return &"CP_ZMB_WEAPONS_GENERIC";
	}
}

//Function Number: 34
func_8220(param_00)
{
	return int(level.interactions[param_00].cost);
}

//Function Number: 35
func_F422(param_00,param_01)
{
	var_02 = func_7A49(param_01,self);
	if(isdefined(var_02))
	{
		self.var_9A3F sethintstring(var_02);
	}

	if(param_01.script_noteworthy == "weapon_purchase" && isdefined(self.weapon_purchase_looking_at))
	{
		if(scripts\cp\zombies\direct_boss_fight::is_kung_fu(self.weapon_purchase_looking_at.var_39C))
		{
			self.var_9A3F method_852E(scripts\cp\zombies\direct_boss_fight::get_kung_fu_string(self.weapon_purchase_looking_at.var_39C));
		}
		else
		{
			var_03 = func_8228(self.weapon_purchase_looking_at.var_39C);
			self.var_9A3F method_852E(var_03,int(scripts\cp\zombies\direct_boss_fight::get_weapon_cost(self.weapon_purchase_looking_at.var_39C)));
		}
	}
	else if(func_9A28(param_01))
	{
		if(isdefined(var_02) && !isstring(var_02) && var_02 == &"COOP_INTERACTIONS_PURCHASE_AMMO")
		{
			var_04 = scripts\cp\_utility::func_80D8(param_01.script_noteworthy);
			var_05 = scripts\cp\_weapon::func_7D62(var_04);
			var_03 = func_8228(param_01.script_noteworthy);
			if(var_05 > 1)
			{
				self.var_9A3F method_852E(int(4500),var_03);
			}
			else
			{
				self.var_9A3F method_852E(int(0.5 * level.interactions[param_01.script_noteworthy].cost),var_03);
			}
		}
	}
	else if(interactionislostandfound(param_01) && scripts\common\utility::istrue(self.var_8C46))
	{
		if(isdefined(self.var_B0A2) && self.var_B0A2 == param_01)
		{
			func_F474(self);
		}
	}
	else if(func_9A2B(param_01) || func_9A19(param_01) || func_9A1C(param_01) || func_9A1E(param_01) || func_9A29(param_01) || func_9A16(param_01))
	{
		self.var_9A3F method_83D6(0);
		self.var_9A3F method_84A5(360);
	}
	else if(param_01.script_noteworthy == "coaster")
	{
		self.var_9A3F method_83D6(1);
		self.var_9A3F method_84A5(245);
	}
	else if(param_01.script_noteworthy == "dj_quest_speaker_mid" || param_01.script_noteworthy == "dj_quest_speaker" || param_01.script_noteworthy == "weapon_purchase" || param_01.script_noteworthy == "boss_fight_activation")
	{
		self.var_9A3F method_83D6(0);
		self.var_9A3F method_84A5(360);
	}
	else if(param_01.script_noteworthy == "spawned_essence")
	{
		self.var_9A3F method_83D6(1);
		self.var_9A3F method_84A5(360);
	}
	else if(param_01.script_noteworthy == "dj_quest_part_1" || param_01.script_noteworthy == "dj_quest_part_2" || param_01.script_noteworthy == "dj_quest_part_3")
	{
		self.var_9A3F method_83D6(0);
		self.var_9A3F method_84A5(245);
	}
	else
	{
		self.var_9A3F method_83D6(1);
		self.var_9A3F method_84A5(160);
	}

	if(isdefined(level.interaction_trigger_properties_func))
	{
		[[ level.interaction_trigger_properties_func ]](param_00,param_01,var_02);
	}
}

//Function Number: 36
func_F474(param_00)
{
	if(isdefined(param_00.var_B0A1))
	{
		var_01 = [];
		foreach(var_03 in param_00.var_B0A1)
		{
			if(scripts\cp\_utility::isstrstart(var_03,"alt_"))
			{
				continue;
			}

			if(!scripts\common\utility::func_2286(var_01,var_03))
			{
				var_01 = scripts\common\utility::array_add(var_01,var_03);
			}
		}

		if(var_01.size > 2)
		{
			var_05 = func_8228(var_01[1]);
			var_06 = func_8228(var_01[2]);
			param_00.var_9A3F method_852E(var_05,var_06);
			return;
		}

		var_05 = func_8228(var_02[1]);
		param_00.var_9A3F method_852E(var_05);
	}
}

//Function Number: 37
func_7A49(param_00,param_01)
{
	if(isdefined(level.interactions[param_00.script_noteworthy].var_8FFA))
	{
		return [[ level.interactions[param_00.script_noteworthy].var_8FFA ]](param_00,param_01);
	}

	if(isdefined(param_00.var_4622))
	{
		return &"COOP_INTERACTIONS_COOLDOWN";
	}

	if(param_00.var_E1B9 && !param_00.var_D776)
	{
		if(isdefined(level.needspowerstring))
		{
			return level.needspowerstring;
		}
		else
		{
			return &"COOP_INTERACTIONS_REQUIRES_POWER";
		}
	}

	if(func_9A28(param_00))
	{
		if(!scripts\cp\_utility::func_462B("wall_buys"))
		{
			return undefined;
		}
	}

	if(func_9A17(param_00))
	{
		if(!isdefined(param_01.var_4B5E) && param_00.var_269F > 0)
		{
			return level.interaction_hintstrings["crafting_nopiece"];
		}
	}

	if(func_9A16(param_00))
	{
		return level.interaction_hintstrings["crafting_item_swap"];
	}

	return level.interaction_hintstrings[param_00.script_noteworthy];
}

//Function Number: 38
func_C00C()
{
	self endon("game_ended");
	for(;;)
	{
		level waittill("player_accessed_nonpowered_interaction",var_00,var_01);
		if(scripts\cp\_utility::map_check(4))
		{
			if(issubstr(var_01.script_noteworthy,"_trap"))
			{
				var_00 thread scripts\cp\_vo::try_to_play_vo("trap_not_avail","zmb_comment_vo");
			}
			else
			{
				var_00 thread scripts\cp\_vo::try_to_play_vo("no_power","zmb_comment_vo","high",30,0,0,1,50);
			}

			continue;
		}

		var_00 thread scripts\cp\_vo::try_to_play_vo("no_power","zmb_comment_vo","high",30,0,0,1,50);
	}
}

//Function Number: 39
func_4616()
{
	self endon("game_ended");
	for(;;)
	{
		level waittill("player_accessed_interaction_on_cooldown",var_00,var_01);
		if(scripts\cp\_utility::map_check(4))
		{
			if(issubstr(var_01.script_noteworthy,"_trap"))
			{
				var_00 thread scripts\cp\_vo::try_to_play_vo("trap_cooldown","zmb_comment_vo");
			}
			else
			{
				var_00 thread scripts\cp\_vo::try_to_play_vo("round_cooldown","zmb_comment_vo","high",30,0,0,1,50);
			}

			continue;
		}

		var_00 thread scripts\cp\_vo::try_to_play_vo("round_cooldown","zmb_comment_vo","high",30,0,0,1,50);
	}
}

//Function Number: 40
func_135DF(param_00)
{
	if(isdefined(level.wait_for_interaction_func))
	{
		self thread [[ level.wait_for_interaction_func ]](param_00);
	}
}

//Function Number: 41
func_CE96(param_00,param_01)
{
	var_02 = param_00.script_noteworthy;
	var_03 = getweaponbasename(var_02);
	switch(var_03)
	{
		case "iw7_cutier_zm":
		case "iw7_cutie_zm":
			param_01 thread scripts\cp\_vo::try_to_play_vo("player_purchase_wonder","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_nunchucks_zm":
			param_01 thread scripts\cp\_vo::try_to_play_vo("magicwheel_nunchucks","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_katana_zm":
			if(randomint(100) > 50)
			{
				param_01 thread scripts\cp\_vo::try_to_play_vo("player_purchase_wonder","zmb_comment_vo","low",10,0,1,0,40);
			}
			else
			{
				param_01 thread scripts\cp\_vo::try_to_play_vo("magicwheel_katana","zmb_comment_vo","low",10,0,1,0,40);
			}
			break;

		case "iw7_harpoon3_zm":
		case "iw7_harpoon_zm":
		case "iw7_harpoon4_zm":
		case "iw7_harpoon2_zm":
		case "iw7_harpoon1_zm":
			param_01 thread scripts\cp\_vo::try_to_play_vo("player_purchase_wonder","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_ake_zm":
		case "iw7_ake_zml":
			param_01 thread scripts\cp\_vo::try_to_play_vo("player_purchase_assault","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_ameli_zm":
		case "iw7_lmg03_zm":
			param_01 thread scripts\cp\_vo::try_to_play_vo("purchase_weapon","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_ar57_zm":
			param_01 thread scripts\cp\_vo::try_to_play_vo("player_purchase_assault","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_axe_zm_pap2":
		case "iw7_axe_zm_pap1":
		case "iw7_axe_zm":
			param_01 thread scripts\cp\_vo::try_to_play_vo("purchase_weapon","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_chargeshot_zm":
			param_01 thread scripts\cp\_vo::try_to_play_vo("player_purchase_launcher","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_cheytac_zm":
			param_01 thread scripts\cp\_vo::try_to_play_vo("player_purchase_sniper","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_crb_zml":
		case "iw7_crb_zm":
			param_01 thread scripts\cp\_vo::try_to_play_vo("player_purchase_smg","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_devastator_zm":
			param_01 thread scripts\cp\_vo::try_to_play_vo("player_purchase_shotgun","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_dischord_zm_pap1":
		case "iw7_dischord_zm":
			param_01 thread scripts\cp\_vo::try_to_play_vo("player_purchase_wonder","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_emc_zm":
			param_01 thread scripts\cp\_vo::try_to_play_vo("player_purchase_pistol","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_erad_zm":
			param_01 thread scripts\cp\_vo::try_to_play_vo("player_purchase_smg","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_facemelter_zm_pap1":
		case "iw7_facemelter_zm":
			param_01 thread scripts\cp\_vo::try_to_play_vo("player_purchase_wonder","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_fhr_zm":
			param_01 thread scripts\cp\_vo::try_to_play_vo("player_purchase_smg","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_fmg_zm":
			param_01 thread scripts\cp\_vo::try_to_play_vo("player_purchase_smg","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_forgefreeze_zm_pap2":
		case "iw7_forgefreeze_zm_pap1":
		case "iw7_forgefreeze_zm":
			param_01 thread scripts\cp\_vo::try_to_play_vo("player_purchase_wonder","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_g18_zm":
		case "iw7_g18_zmr":
			param_01 thread scripts\cp\_vo::try_to_play_vo("player_purchase_pistol","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_lockon_zm":
			param_01 thread scripts\cp\_vo::try_to_play_vo("player_purchase_launcher","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_glprox_zm":
			param_01 thread scripts\cp\_vo::try_to_play_vo("player_purchase_launcher","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_headcutter_zm_pap1":
		case "iw7_headcutter_zm":
			param_01 thread scripts\cp\_vo::try_to_play_vo("player_purchase_wonder","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_kbs_zm":
			param_01 thread scripts\cp\_vo::try_to_play_vo("player_purchase_sniper","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_m1c_zm":
		case "iw7_m1_zm":
			param_01 thread scripts\cp\_vo::try_to_play_vo("player_purchase_sniper","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_m4_zm":
			param_01 thread scripts\cp\_vo::try_to_play_vo("player_purchase_assault","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_m8_zm":
			param_01 thread scripts\cp\_vo::try_to_play_vo("player_purchase_assault","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_mauler_zm":
			param_01 thread scripts\cp\_vo::try_to_play_vo("purchase_weapon","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_nrg_zm":
			param_01 thread scripts\cp\_vo::try_to_play_vo("player_purchase_pistol","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_revolver_zm":
			param_01 thread scripts\cp\_vo::try_to_play_vo("player_purchase_pistol","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_ripper_zm":
		case "iw7_ripper_zmr":
			param_01 thread scripts\cp\_vo::try_to_play_vo("player_purchase_smg","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_sdfar_zm":
			param_01 thread scripts\cp\_vo::try_to_play_vo("player_purchase_assault","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_sdflmg_zm":
			param_01 thread scripts\cp\_vo::try_to_play_vo("purchase_weapon","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_sdfshotty_zm":
			param_01 thread scripts\cp\_vo::try_to_play_vo("player_purchase_shotgun","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_shredder_zm_pap1":
		case "iw7_shredder_zm":
			param_01 thread scripts\cp\_vo::try_to_play_vo("player_purchase_wonder","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_sonic_zmr":
		case "iw7_sonic_zm":
			param_01 thread scripts\cp\_vo::try_to_play_vo("player_purchase_shotgun","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_spas_zm":
			param_01 thread scripts\cp\_vo::try_to_play_vo("player_purchase_shotgun","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_steeldragon_zm":
			param_01 thread scripts\cp\_vo::try_to_play_vo("player_purchase_wonder","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_ump45_zml":
			param_01 thread scripts\cp\_vo::try_to_play_vo("player_purchase_smg","zmb_comment_vo","low",10,0,1,0,40);
			break;

		case "iw7_spasc_zm":
			param_01 thread scripts\cp\_vo::try_to_play_vo("player_purchase_shotgun","zmb_comment_vo","low",10,0,1,0,40);
			break;

		default:
			param_01 thread scripts\cp\_vo::try_to_play_vo("purchase_weapon","zmb_comment_vo","low",10,0,1,0,40);
			break;
	}
}

//Function Number: 42
func_383D(param_00)
{
	var_01 = self getweaponslistall();
	var_02 = undefined;
	var_03 = undefined;
	var_04 = scripts\cp\_utility::func_80D8(param_00);
	foreach(var_06 in var_01)
	{
		var_03 = scripts\cp\_utility::func_80D8(var_06);
		if(var_03 == var_04)
		{
			var_02 = var_06;
			break;
		}
	}

	if(isdefined(var_02))
	{
		var_08 = self getweaponammostock(var_02);
		var_09 = function_0249(var_02);
		var_0A = lib_0CFF::func_D876();
		var_0B = int(var_0A * var_09);
		if(var_08 < var_0B)
		{
			return 1;
		}
		else if(function_0249(var_02) == weaponclipsize(var_02) && self getweaponammoclip(var_02) < weaponclipsize(var_02))
		{
			return 1;
		}
		else
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 43
func_9A33(param_00)
{
	self endon("disconnect");
	if(isdefined(level.should_post_activate_delay_func))
	{
		if(![[ level.should_post_activate_delay_func ]](param_00))
		{
			return;
		}
	}

	if(func_9A18(param_00))
	{
		return;
	}

	if(func_9A15(param_00))
	{
		return;
	}

	scripts\cp\_utility::func_1C5D(0);
	wait(1.5);
	if(!scripts\cp\_utility::func_213E())
	{
		scripts\cp\_utility::func_1C5D(1);
	}
}

//Function Number: 44
func_50FA()
{
	wait(0.25);
	self.var_127BA = undefined;
}

//Function Number: 45
remove_from_current_interaction_list(param_00)
{
	if(scripts\common\utility::func_2286(level.current_interaction_structs,param_00))
	{
		level.current_interaction_structs = scripts\common\utility::func_22A9(level.current_interaction_structs,param_00);
	}
}

//Function Number: 46
add_to_current_interaction_list(param_00)
{
	if(!scripts\common\utility::func_2286(level.current_interaction_structs,param_00))
	{
		level.current_interaction_structs = scripts\common\utility::array_add(level.current_interaction_structs,param_00);
	}
}

//Function Number: 47
func_E01A(param_00,param_01)
{
	param_01.var_55BB = scripts\common\utility::array_add(param_01.var_55BB,param_00);
}

//Function Number: 48
func_175D(param_00,param_01)
{
	param_01.var_55BB = scripts\common\utility::func_22A9(param_01.var_55BB,param_00);
}

//Function Number: 49
func_383E(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_00.var_EE04) && param_00.var_EE04 == "afterlife")
	{
		return 1;
	}

	if(lib_0D12::func_9DDF(self))
	{
		return 0;
	}

	if(isdefined(param_01))
	{
		var_04 = param_01;
	}
	else if(interaction_is_sliding_door(param_01))
	{
		var_04 = 0;
	}
	else
	{
		var_04 = level.interactions[param_01.script_noteworthy].cost;
	}

	if(func_9A1A(param_00))
	{
		switch(self.var_3A52)
		{
			case 0:
				var_04 = level.var_732C;
				break;

			default:
				var_04 = level.var_732D;
				break;
		}
	}
	else if(func_9A29(param_00) && !scripts\cp\_weapon::func_385F(self getcurrentweapon()))
	{
		if(scripts\common\utility::istrue(level.has_picked_up_fuses) && !isdefined(level.placed_alien_fuses))
		{
			return 1;
		}
		else
		{
			return 0;
		}
	}
	else if(func_9A1D(param_00))
	{
		if((scripts\cp\_utility::isplayingsolo() || level.only_one_player) && param_00.var_CA4C == "perk_machine_revive" && !scripts\cp\_utility::has_zombie_perk("perk_machine_revive") && self.var_F1E7 >= self.max_self_revive_machine_use)
		{
			return 0;
		}
	}
	else if(func_9A22(param_00))
	{
		var_05 = 0;
		switch(param_00.script_side)
		{
			case "moon":
						if(!isdefined(level.moon_donations) || level.moon_donations < 3)
						{
							var_05 = 1;
						}
						break;

			case "kepler":
						if(!isdefined(level.kepler_donations) || level.kepler_donations < 3)
						{
							var_05 = 1;
						}
						break;

			case "triton":
						if(!isdefined(level.triton_donations) || level.triton_donations < 3)
						{
							var_05 = 1;
						}
						break;
		}

		if(!var_05)
		{
			return 0;
		}
	}
	else if(interaction_is_chi_door(param_00))
	{
		switch(param_00.script_noteworthy)
		{
			case "chi_0":
							if(param_01 != 0)
							{
								break;
							}

							if(!isdefined(level.kungfu_weapons) || !isdefined(scripts\common\utility::func_2291(level.kungfu_weapons[0],param_03)))
							{
								break;
							}
							return 1;

			case "chi_1":
							if(param_01 != 1)
							{
								break;
							}

							if(!isdefined(level.kungfu_weapons) || !isdefined(scripts\common\utility::func_2291(level.kungfu_weapons[1],param_03)))
							{
								break;
							}
							return 1;

			case "chi_2":
							if(param_01 != 2)
							{
								break;
							}

							if(!isdefined(level.kungfu_weapons) || !isdefined(scripts\common\utility::func_2291(level.kungfu_weapons[2],param_03)))
							{
								break;
							}
							return 1;
		}

		return 0;
	}
	else if(func_9A28(param_00))
	{
		var_06 = param_00.script_noteworthy;
		if(param_00.var_EE79 == "tickets")
		{
			if(self hasweapon(var_06))
			{
				return 0;
			}

			self.var_A035 = param_00.script_noteworthy;
			level.var_12631 = randomint(100);
			scripts\cp\zombies\zombie_analytics::func_AF75(level.wave_num,self.var_A035,level.var_12631);
		}

		var_07 = function_0249(param_00.script_noteworthy);
		var_08 = lib_0CFF::func_D876();
		var_09 = int(var_08 * var_07);
		var_0A = self getweaponammostock(var_06);
		if(var_0A >= var_09)
		{
			return 0;
		}
	}

	if(param_00.var_EE79 == "tickets")
	{
		if(self.num_tickets >= var_04)
		{
			return 1;
		}

		return 0;
	}

	if(scripts\cp\_persistence::func_D0BB(var_04,param_02))
	{
		return 1;
	}

	return 0;
}

//Function Number: 50
func_11449(param_00,param_01)
{
	scripts\cp\_persistence::func_11445(param_00,1,param_01);
}

//Function Number: 51
func_FF5A(param_00)
{
	if(!isdefined(param_00))
	{
	}

	switch(param_00)
	{
		case "wondercard_machine":
		case "atm":
		case "bleedoutPenalty":
			return 0;

		default:
			return 1;
	}
}

//Function Number: 52
func_5030(param_00,param_01)
{
}

//Function Number: 53
func_7DBA(param_00,param_01)
{
	var_02 = level.interactions[param_00.script_noteworthy].cost;
	var_03 = scripts\cp\_utility::func_80D8(param_00.script_noteworthy);
	var_04 = param_01 getcurrentweapon();
	var_05 = scripts\cp\_utility::func_7DF7(var_04);
	var_06 = function_0249(var_04);
	var_07 = param_01 lib_0CFF::func_D876();
	var_08 = int(var_07 * var_06);
	var_09 = param_01 getweaponammostock(var_04);
	var_0A = self getweaponslistall();
	foreach(var_0C in var_0A)
	{
		var_0D = scripts\cp\_utility::func_80D8(var_0C);
		if(var_0D == scripts\cp\_utility::func_80D8(param_00.script_noteworthy))
		{
			var_0E = var_0C;
			var_09 = self getweaponammostock(var_0E);
			var_06 = function_0249(var_0E);
			var_08 = int(var_07 * var_06);
		}
	}

	if(param_00.var_EE79 == "tickets")
	{
		return level.interaction_hintstrings[param_00.script_noteworthy];
	}

	switch(var_02)
	{
		case 250:
			return &"CP_ZMB_INTERACTIONS_TICKETS_AMMO";

		case 1500:
		case 1250:
		case 1000:
		case 500:
			return &"COOP_INTERACTIONS_PURCHASE_AMMO";

		default:
			return &"COOP_INTERACTIONS_PURCHASE_AMMO";
	}
}

//Function Number: 54
func_502F(param_00,param_01)
{
	if(param_01 scripts\cp\_weapon::func_8BBB(param_00.script_noteworthy))
	{
		return func_7DBA(param_00,param_01);
	}

	return undefined;
}

//Function Number: 55
func_9A3D()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("interaction",var_00,var_01,var_02);
		switch(var_00)
		{
			case "wall_buy":
				if(isdefined(var_02.var_DB02))
				{
					if(soundexists("purchase_ammo"))
					{
						var_02 playlocalsound("purchase_ammo");
					}
				}
				else if(isdefined(var_01))
				{
					if(isdefined(var_01.script_noteworthy) && var_01.script_noteworthy == "iw7_venomx_zm")
					{
						if(scripts\common\utility::func_6E34("completepuzzles_step4") && scripts\common\utility::flag("completepuzzles_step4"))
						{
							if(soundexists("purchase_weapon"))
							{
								var_02 playlocalsound("purchase_weapon");
							}
						}
					}
					else if(soundexists("purchase_weapon"))
					{
						var_02 playlocalsound("purchase_weapon");
					}
				}
				else if(soundexists("purchase_weapon"))
				{
					var_02 playlocalsound("purchase_weapon");
				}
				break;
	
			case "purchase":
				var_03 = func_7A4B(var_01,var_02);
				if(isdefined(var_03) && soundexists(var_03))
				{
					var_02 playlocalsound(var_03);
				}
				break;
	
			case "purchase_denied":
				if(var_01.name == "jaroslav_machine" && soundexists("ui_consumable_purchase_deny"))
				{
					var_02 playlocalsound("ui_consumable_purchase_deny");
				}
				else if(var_01.name == "lost_and_found" && soundexists("lost_and_found_deny"))
				{
					var_02 playlocalsound("lost_and_found_deny");
				}
				else if((soundexists("trap_control_panel_deny") && var_01.name == "beamtrap") || var_01.name == "interaction_discoballtrap" || var_01.name == "scrambler" || var_01.name == "blackhole_trap" || var_01.name == "rockettrap")
				{
					var_02 playlocalsound("trap_control_panel_deny");
				}
				else if(soundexists("purchase_deny"))
				{
					var_02 playlocalsound("purchase_deny");
				}
				break;
		}
	}
}

//Function Number: 56
func_7A4B(param_00,param_01)
{
	var_02 = [];
	switch(param_00.name)
	{
		case "secure_window":
			return undefined;

		case "lost_and_found":
			var_02 = ["lost_and_found_purchase"];
			break;

		case "rockettrap":
		case "blackhole_trap":
		case "scrambler":
		case "interaction_discoballtrap":
		case "beamtrap":
			var_02 = ["trap_control_panel_purchase"];
			break;

		case "sliding_door":
		case "facility_sliding_door_2000":
		case "facility_sliding_door_1500":
		case "facility_sliding_door_1250":
		case "facility_sliding_door_1000":
		case "facility_sliding_door_750":
		case "debris":
			var_02 = ["purchase_door"];
			break;

		case "team_door_switch":
			var_02 = ["purchase_door"];
			break;

		case "atm_deposit":
			var_02 = ["atm_deposit"];
			break;

		case "atm_withdrawal":
			var_02 = ["atm_withdrawal"];
			break;

		case "repair_kevin":
		case "kevin_battery":
		case "kevin_head":
		case "souvenir_pickup":
			var_02 = ["zmb_item_pickup"];
			break;

		case "medium_ticket_prize":
		case "small_ticket_prize":
		case "iw7_forgefreeze_zm+forgefreezealtfire":
		case "zfreeze_semtex_mp":
			var_02 = ["purchase_ticket"];
			break;

		case "large_ticket_prize":
			var_02 = ["ark_purchase"];
			break;

		case "ark_quest_station":
			var_02 = ["ark_turn_in"];
			break;
	}

	if(!var_02.size)
	{
		return undefined;
	}

	return scripts\common\utility::random(var_02);
}

//Function Number: 57
func_9A34(param_00)
{
	if(!isdefined(param_00.var_D6B3))
	{
		return;
	}

	if(isdefined(level.interaction_post_activate_update_func))
	{
		level thread [[ level.interaction_post_activate_update_func ]](param_00,self);
		return;
	}

	if(isdefined(param_00.var_10485))
	{
		param_00.var_1048E delete();
		param_00.var_1048E = spawn("script_model",param_00.var_1048A);
		param_00.var_1048E setmodel(param_00.var_10489);
		param_00.script_noteworthy = "crafting_station";
		param_00.var_E1B9 = 1;
		param_00.var_D776 = 1;
		param_00.var_EE79 = "requires_power";
		param_00.name = "crafting_station";
		if(isdefined(param_00.var_10486))
		{
			param_00.var_10486 delete();
		}

		if(scripts\cp\_utility::is_valid_player())
		{
			self playlocalsound("zmb_item_pickup");
		}

		param_00.var_10485 = undefined;
		param_00.var_D6B3 = undefined;
		param_00.var_D742 = undefined;
		param_00.var_47B2 = undefined;
	}
}

//Function Number: 58
func_9A26(param_00)
{
	return param_00.script_noteworthy == "trap_electric" || param_00.script_noteworthy == "trap_firebarrel";
}

//Function Number: 59
func_9A2A(param_00)
{
	return param_00.script_noteworthy == "white_ark";
}

//Function Number: 60
func_9A14(param_00)
{
	return param_00.script_noteworthy == "ark_quest_station";
}

//Function Number: 61
func_9A15(param_00)
{
	return param_00.script_noteworthy == "atm_withdrawal" || param_00.script_noteworthy == "atm_deposit";
}

//Function Number: 62
func_9A1C(param_00)
{
	return param_00.script_noteworthy == "neil_head";
}

//Function Number: 63
interactionislostandfound(param_00)
{
	if(isdefined(param_00.script_noteworthy) && param_00.script_noteworthy == "lost_and_found")
	{
		return 1;
	}

	if(isdefined(param_00.name) && param_00.name == "lost_and_found")
	{
		return 1;
	}

	return 0;
}

//Function Number: 64
func_9A2B(param_00)
{
	return param_00.script_noteworthy == "secure_window";
}

//Function Number: 65
func_9A1E(param_00)
{
	return param_00.script_noteworthy == "pillage_item";
}

//Function Number: 66
func_9A19(param_00)
{
	return param_00.script_noteworthy == "fast_travel";
}

//Function Number: 67
func_9A17(param_00)
{
	return param_00.script_noteworthy == "crafting_station";
}

//Function Number: 68
func_9A1B(param_00)
{
	return param_00.script_noteworthy == "power_bioSpike" || param_00.script_noteworthy == "power_c4";
}

//Function Number: 69
func_9A16(param_00)
{
	return param_00.script_noteworthy == "crafting_pickup";
}

//Function Number: 70
func_9A1A(param_00)
{
	return param_00.script_noteworthy == "jaroslav_machine";
}

//Function Number: 71
func_9A1D(param_00)
{
	return isdefined(param_00.var_CA4C);
}

//Function Number: 72
func_9A42(param_00)
{
	return param_00.var_E1B9 && !param_00.var_D776;
}

//Function Number: 73
func_9A21(param_00)
{
	return isdefined(param_00.var_47B2);
}

//Function Number: 74
func_D0C5(param_00,param_01)
{
	if(isdefined(param_01.var_4B5C))
	{
		return param_01.var_4B5C.var_195 == param_00.script_noteworthy;
	}

	return 0;
}

//Function Number: 75
func_9A2C(param_00)
{
	return param_00.script_noteworthy == "crafted_windowtrap";
}

//Function Number: 76
interaction_is_challenge_station(param_00)
{
	return isdefined(param_00.var_86A2) && param_00.var_86A2 == "challenge";
}

//Function Number: 77
func_9A27(param_00,param_01)
{
	if(param_01 method_84D9())
	{
		return 0;
	}

	if(isdefined(param_00.var_127BA))
	{
		return 0;
	}

	if(!scripts\common\utility::func_2286(level.current_interaction_structs,param_00))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(param_00.out_of_order))
	{
		level notify("player_accessed_interaction_on_cooldown",param_01);
		return 0;
	}

	if(scripts\common\utility::istrue(param_00.var_93A8))
	{
		return 0;
	}

	if(func_9A42(param_00))
	{
		level notify("player_accessed_nonpowered_interaction",param_01,param_00);
		if(isdefined(param_00.var_CA4C) && soundexists("perk_machine_deny"))
		{
			param_01 playlocalsound("perk_machine_deny");
		}
		else
		{
			param_01 playlocalsound("purchase_deny");
		}

		return 0;
	}

	if(isdefined(param_00.var_4622))
	{
		level notify("player_accessed_interaction_on_cooldown",param_01,param_00);
		return 0;
	}

	if(scripts\common\utility::func_2286(param_01.var_55BB,param_00))
	{
		return 0;
	}

	return 1;
}

//Function Number: 78
func_9A29(param_00)
{
	return param_00.script_noteworthy == "weapon_upgrade";
}

//Function Number: 79
interaction_is_sliding_door(param_00)
{
	return isdefined(param_00.script_noteworthy) && param_00.script_noteworthy == "facility_sliding_door_750" || param_00.script_noteworthy == "facility_sliding_door_1000" || param_00.script_noteworthy == "facility_sliding_door_1250" || param_00.script_noteworthy == "facility_sliding_door_1500" || param_00.script_noteworthy == "facility_sliding_door_2000";
}

//Function Number: 80
func_9A28(param_00)
{
	if(isdefined(param_00.name))
	{
		return param_00.name == "wall_buy";
	}

	return 0;
}

//Function Number: 81
func_9A18(param_00)
{
	return param_00.script_noteworthy == "debris_350" || param_00.script_noteworthy == "debris_750" || param_00.script_noteworthy == "debris_1000" || param_00.script_noteworthy == "debris_1250" || param_00.script_noteworthy == "debris_1500" || param_00.script_noteworthy == "debris_2000" || param_00.script_noteworthy == "team_door_switch" || param_00.script_noteworthy == "team_door";
}

//Function Number: 82
func_9A22(param_00)
{
	return param_00.script_noteworthy == "power_door_sliding" || param_00.script_noteworthy == "team_door_switch" || param_00.script_noteworthy == "team_door";
}

//Function Number: 83
interaction_is_chi_door(param_00)
{
	return param_00.script_noteworthy == "chi_0" || param_00.script_noteworthy == "chi_1" || param_00.script_noteworthy == "chi_2";
}

//Function Number: 84
func_9A24(param_00)
{
	return param_00.script_noteworthy == "small_ticket_prize" || param_00.script_noteworthy == "medium_ticket_prize" || param_00.script_noteworthy == "arcade_counter_grenade" || param_00.script_noteworthy == "arcade_counter_ammo" || param_00.script_noteworthy == "large_ticket_prize" || param_00.script_noteworthy == "zfreeze_semtex_mp" || param_00.script_noteworthy == "iw7_forgefreeze_zm+forgefreezealtfire" || param_00.script_noteworthy == "gold_teeth";
}

//Function Number: 85
func_9A1F(param_00)
{
	return isdefined(param_00.var_D742);
}

//Function Number: 86
func_D0C3(param_00)
{
	return scripts\cp\powers\coop_powers::func_8C17(param_00.var_D742);
}

//Function Number: 87
func_3867(param_00)
{
	if(scripts\cp\_utility::has_zombie_perk(param_00.var_CA4C))
	{
		return 0;
	}
	else if(self.var_F1E7 >= self.max_self_revive_machine_use && param_00.var_CA4C == "perk_machine_revive")
	{
		return 0;
	}
	else if(isdefined(self.var_13FA4) && self.var_13FA4.size > 4 && !scripts\common\utility::istrue(self.have_permanent_perks))
	{
		return 0;
	}

	return 1;
}

//Function Number: 88
func_9A3C(param_00,param_01,param_02,param_03)
{
	thread interaction_fail_internal(param_00,param_01,param_02,param_03);
}

//Function Number: 89
interaction_fail_internal(param_00,param_01,param_02,param_03)
{
	self endon("disconnect");
	level notify("interaction","purchase_denied",level.interactions[param_00.script_noteworthy],self);
	self.var_50BC = 1;
	self.var_9A3F sethintstring(param_01);
	wait(1);
	self.var_50BC = undefined;
	func_F422(self.var_9A3F,param_00);
}

//Function Number: 90
func_554F(param_00)
{
	var_01 = scripts\common\utility::getstructarray(param_00.script_noteworthy,"script_noteworthy");
	foreach(var_03 in var_01)
	{
		if(var_03.target == param_00.target)
		{
			scripts\cp\zombies\zombie_analytics::func_AF74(var_03.name,0);
			remove_from_current_interaction_list(var_03);
		}
	}
}

//Function Number: 91
func_6214(param_00)
{
	var_01 = scripts\common\utility::getstructarray(param_00.script_noteworthy,"script_noteworthy");
	foreach(var_03 in var_01)
	{
		if(var_03.target == param_00.target)
		{
			scripts\cp\zombies\zombie_analytics::func_AF74(var_03.name,1);
			add_to_current_interaction_list(var_03);
		}
	}
}

//Function Number: 92
disable_like_interactions(param_00)
{
	var_01 = scripts\common\utility::getstructarray(param_00.script_noteworthy,"script_noteworthy");
	foreach(var_03 in var_01)
	{
		scripts\cp\zombies\zombie_analytics::func_AF74(var_03.name,0);
		remove_from_current_interaction_list(var_03);
	}
}

//Function Number: 93
enable_like_interactions(param_00)
{
	var_01 = scripts\common\utility::getstructarray(param_00.script_noteworthy,"script_noteworthy");
	foreach(var_03 in var_01)
	{
		scripts\cp\zombies\zombie_analytics::func_AF74(var_03.name,1);
		add_to_current_interaction_list(var_03);
	}
}

//Function Number: 94
func_9A0D(param_00,param_01)
{
	var_02 = scripts\common\utility::getstructarray(param_00.script_noteworthy,"script_noteworthy");
	foreach(var_04 in var_02)
	{
		if(var_04.target == param_00.target)
		{
			var_04.var_4622 = 1;
		}
	}

	if(scripts\common\utility::istrue(level.var_4614))
	{
		wait(1);
	}
	else
	{
		level scripts\common\utility::waittill_any_timeout_1(param_01,"override_cooldowns");
	}

	foreach(var_04 in var_02)
	{
		if(var_04.target == param_00.target)
		{
			var_04.var_4622 = undefined;
		}
	}

	var_08 = 5184;
	foreach(var_0A in level.players)
	{
		foreach(var_04 in var_02)
		{
			if(distancesquared(var_0A.origin,var_04.origin) >= var_08)
			{
				continue;
			}

			var_0A func_DE6E();
		}
	}
}

//Function Number: 95
func_7A90(param_00)
{
	var_01 = [];
	var_02 = scripts\common\utility::getstructarray(param_00.script_noteworthy,"script_noteworthy");
	foreach(var_04 in var_02)
	{
		if(var_04.target == param_00.target)
		{
			var_01[var_01.size] = var_04;
		}
	}

	return var_01;
}

//Function Number: 96
func_DE6E()
{
	if(isdefined(self.var_9A3F.name))
	{
		scripts\cp\zombies\zombie_analytics::func_AF74(self.var_9A3F.name,0);
	}

	self notify("stop_interaction_logic");
	self.var_A8D3 = undefined;
	self.var_9A3F method_852E();
	self setclientomnvar("zm_interaction_cost",-1);
}

//Function Number: 97
func_9A3A(param_00)
{
	return scripts\common\utility::istrue(param_00.var_E1B9) && isdefined(param_00.var_D71C);
}

//Function Number: 98
func_55A2()
{
	var_00 = scripts\common\utility::getstructarray("interaction","targetname");
	foreach(var_02 in var_00)
	{
		if(func_9A28(var_02) || func_9A1B(var_02) || func_9A24(var_02) || isdefined(var_02.var_EE79) && var_02.var_EE79 == "tickets")
		{
			var_02.var_55BA = 1;
			scripts\cp\zombies\zombie_analytics::func_AF74(var_02.name,0);
			continue;
		}
	}
}

//Function Number: 99
func_55A3(param_00)
{
	var_01 = scripts\common\utility::getstructarray("interaction","targetname");
	foreach(var_03 in var_01)
	{
		if(func_9A28(var_03) || func_9A1B(var_03) || func_9A24(var_03) || isdefined(var_03.var_EE79) && var_03.var_EE79 == "tickets")
		{
			scripts\cp\zombies\zombie_analytics::func_AF74(var_03.name,0);
			func_E01A(var_03,param_00);
			continue;
		}
	}
}

//Function Number: 100
func_6255(param_00)
{
	var_01 = scripts\common\utility::getstructarray("interaction","targetname");
	foreach(var_03 in var_01)
	{
		if(func_9A28(var_03) || func_9A1B(var_03) || func_9A24(var_03) || isdefined(var_03.var_EE79) && var_03.var_EE79 == "tickets")
		{
			scripts\cp\zombies\zombie_analytics::func_AF74(var_03.name,1);
			func_175D(var_03,param_00);
			continue;
		}
	}
}

//Function Number: 101
func_1048D(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		var_03 thread scripts\cp\_hud_message::func_10151(param_00,undefined,param_01);
		wait(0.1);
	}
}

//Function Number: 102
atm_deposit_hint(param_00,param_01)
{
	if(exceed_deposit_limit(param_01))
	{
		return "";
	}

	return level.interaction_hintstrings[param_00.script_noteworthy];
}

//Function Number: 103
exceed_deposit_limit(param_00)
{
	var_01 = -15536;
	if(!isdefined(level.atm_total_deposit_amount))
	{
		level.atm_total_deposit_amount = [];
	}

	var_02 = param_00.name;
	if(!isdefined(level.atm_total_deposit_amount[var_02]))
	{
		level.atm_total_deposit_amount[var_02] = 0;
	}

	return level.atm_total_deposit_amount[var_02] >= var_01;
}

//Function Number: 104
increase_total_deposit_amount(param_00,param_01)
{
	var_02 = param_00.name;
	level.atm_total_deposit_amount[var_02] = level.atm_total_deposit_amount[var_02] + param_01;
}