/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_leprechauns.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 19
 * Decompile Time: 344 ms
 * Timestamp: 10/27/2023 3:15:00 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	thread func_87A7();
}

//Function Number: 2
func_87A7()
{
	setdvarifuninitialized("leprechauns_enabled",0);
	setdvarifuninitialized("spv_min_lep_kills",30);
	setdvarifuninitialized("spv_lep_chance",30);
	setdvarifuninitialized("spv_lep_health",700);
	setdvarifuninitialized("spv_lep_cap",6);
	if(getdvarint("leprechauns_enabled",0) == 1 && !function_03A9())
	{
		level.leprechaun_model = "usa_leprechaun_mtx7";
		level.var_611["leprechaun_spawn_fx"] = loadfx("vfx/unique/st_patricks_day_leprechaun_spawn");
		level.var_611["leprechaun_death_fx"] = loadfx("vfx/unique/st_patricks_day_leprechaun_death");
		level.var_A41["leprechauns"] = [];
		level.var_A41["leprechauns"]["spawn"] = ::spawn_leprechaun;
		level.var_A41["leprechauns"]["think"] = ::leprechaun_think;
		level.var_A41["leprechauns"]["on_killed"] = ::on_leprechaun_killed;
		while(!isdefined(level.var_A41) || !isdefined(level.var_A41["player"]))
		{
			wait 0.05;
		}

		level.var_A41["leprechauns"]["on_damaged"] = level.var_A41["player"]["on_damaged"];
		level.var_A41["leprechauns"]["on_damaged_finished"] = level.var_A41["player"]["on_damaged_finished"];
		level.leprechaun_spawns = [];
		level.total_leprechauns = 0;
		level.spawns_without_leprechaun = 0;
		var_00 = randomint(2);
		if(var_00 == 0)
		{
			level.leprechauns_team = "axis";
		}
		else
		{
			level.leprechauns_team = "allies";
		}

		level thread try_spawn_leprechauns();
	}
}

//Function Number: 3
try_spawn_leprechauns()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("normal_enemy_kill");
		if(!maps\mp\_utility::func_3FA0("prematch_done"))
		{
			continue;
		}

		if(level.total_leprechauns >= getdvarint("spv_lep_cap",6))
		{
			return;
		}

		if(isdefined(level.leprechaun) || isalive(level.leprechaun))
		{
			continue;
		}

		var_00 = maps/mp/agents/_agent_utility::get_max_agents();
		if(maps/mp/agents/_agent_utility::func_45BB() >= var_00)
		{
			continue;
		}

		var_01 = getdvarint("spv_lep_chance",30);
		if(var_01 <= 0)
		{
			var_01 = 1;
		}

		var_02 = randomint(var_01);
		if(var_02 != 0 && level.spawns_without_leprechaun < getdvarint("spv_min_lep_kills",30))
		{
			level.spawns_without_leprechaun++;
			continue;
		}

		level.spawns_without_leprechaun = 0;
		var_03 = randomint(3) + 2;
		wait(var_03);
		var_04 = undefined;
		var_05 = [];
		foreach(var_07 in level.var_744A)
		{
			if(maps\mp\_utility::func_57A0(var_07))
			{
				var_05[var_05.size] = var_07;
			}
		}

		if(isdefined(var_05) && var_05.size > 0)
		{
			var_09 = randomint(var_05.size);
			if(isdefined(var_05[var_09]))
			{
				var_04 = var_05[var_09].var_116;
			}
		}

		if(isdefined(var_04))
		{
			level.leprechaun_spawns = getnodesinradiussorted(var_04,2000,1000,500,"Path");
			if(level.leprechaun_spawns.size > 0)
			{
				level spawn_leprechaun_handler();
			}
		}
	}
}

//Function Number: 4
spawn_leprechaun_handler()
{
	level endon("game_ended");
	var_00 = randomint(level.leprechaun_spawns.size);
	var_01 = level.leprechaun_spawns[var_00].var_116;
	var_02 = level.leprechaun_spawns[var_00].var_1D;
	level.leprechaun = [[ level.var_A4D ]]("leprechauns",level.leprechauns_team,undefined,var_01,var_02,undefined,0,0,"veteran");
}

//Function Number: 5
spawn_leprechaun(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("disconnect");
	while(!isdefined(level.var_4696))
	{
		wait 0.05;
	}

	if(self.var_4B60)
	{
		wait(randomintrange(6,10));
	}

	maps/mp/agents/_agent_utility::func_5334(1);
	if(isdefined(param_00) && isdefined(param_01))
	{
		var_07 = param_00;
		var_08 = param_01;
		self.var_5BE0 = spawnstruct();
		self.var_5BE0.var_116 = var_07;
		self.var_5BE0.var_1D = var_08;
	}
	else
	{
		self method_856C();
		var_09 = [[ level.var_4696 ]]();
		var_07 = var_09.var_116;
		var_08 = var_09.var_1D;
		self.var_5BE0 = var_09;
	}

	maps/mp/agents/_agent_utility::func_8A7();
	self.var_5CC6 = maps/mp/agents/_agent_utility::func_45AE(self.var_109);
	self.var_5BE2 = gettime();
	var_0A = var_07 + (0,0,25);
	var_0B = var_07;
	var_0C = playerphysicstrace(var_0A,var_0B);
	if(distancesquared(var_0C,var_0A) > 1)
	{
		var_07 = var_0C;
	}

	self method_838F(var_07,var_08);
	self [[ level.var_19D5["bot_set_difficulty"] ]]("veteran");
	self [[ level.var_19D5["bot_set_personality"] ]]("run_and_gun");
	maps/mp/agents/_agent_common::func_83FD(getdvarint("spv_lep_health",700));
	if(isdefined(param_04) && param_04)
	{
		self.var_7DAD = 1;
	}

	if(isdefined(param_02))
	{
		maps/mp/agents/_agent_utility::func_83FE(param_02.var_1A7,param_02);
	}
	else
	{
		maps/mp/agents/_agent_utility::func_83FE(level.leprechauns_team);
	}

	if(isdefined(self.var_117))
	{
		self thread [[ level.var_A55 ]](self.var_117);
	}

	thread maps\mp\_flashgrenades::func_6394();
	self method_83D6(0);
	maps\mp\_utility::func_47A2("specialty_silentmovement");
	maps\mp\_utility::func_47A2("specialty_plainsight");
	maps\mp\_utility::func_47A2("specialty_coldblooded");
	maps\mp\_utility::func_47A2("specialty_spygame");
	maps\mp\_utility::func_47A2("specialty_heartbreaker");
	maps\mp\_utility::func_47A2("specialty_uavhidden");
	maps\mp\_utility::func_47A2("specialty_delaymine");
	self thread [[ level.var_19D5["bot_think_watch_enemy"] ]](1);
	self thread [[ level.var_19D5["bot_think_tactical_goals"] ]]();
	self thread [[ maps/mp/agents/_agent_utility::func_A59("think") ]]();
	if(!self.var_4B60)
	{
		lib_050D::func_9FA();
	}

	thread maps\mp\gametypes\_weapons::func_9B90();
	self.var_4B60 = 0;
	thread maps\mp\gametypes\_healthoverlay::func_73FC();
	self.var_9 = undefined;
	self setmodel(level.leprechaun_model);
	waittillframeend;
	playfx(common_scripts\utility::func_44F5("leprechaun_spawn_fx"),self.var_116);
	self botsetflag("disable_attack",1);
	self botsetflag("force_sprint",1);
	self botsetflag("melee_critical_path",1);
	self botsetflag("no_enemy_search",1);
	self botsetflag("dont_path_to_enemy",1);
	self method_85BE(0);
	self method_85BD(0);
	self method_8113(0);
	self method_8114(0);
	thread leprechaun_behavior_loop();
	thread start_leprechaun_audio();
	thread setup_leprechaun_aim_assist();
	self takeallweapons();
	self giveweapon("emote_weapon_mp");
	level notify("spawned_agent_player",self);
	level notify("spawned_agent",self);
	self notify("spawned_player");
	thread watch_leprechaun_damage();
	level.total_leprechauns++;
	if(level.leprechauns_team == "allies")
	{
		level.leprechauns_team = "axis";
	}
	else if(level.leprechauns_team == "axis")
	{
		level.leprechauns_team = "allies";
	}

	thread message_leprechaun_arrival();
}

//Function Number: 6
message_leprechaun_arrival()
{
	level endon("game_ended");
	foreach(var_01 in level.var_744A)
	{
		var_01 iclientprintlnbold(&"SPLASHES_MTX3_5_LEPRECHAUN_SPAWN");
	}
}

//Function Number: 7
message_leprechaun_death()
{
	level endon("game_ended");
	wait(1);
	foreach(var_01 in level.var_744A)
	{
		var_01 iclientprintlnbold(&"SPLASHES_MTX3_5_LEPRECHAUN_DEATH");
	}
}

//Function Number: 8
leprechaun_behavior_loop()
{
	level endon("game_ended");
	self endon("death");
	var_00 = 0;
	for(;;)
	{
		var_00 = !var_00;
		self botsetflag("no_enemy_search",var_00);
		self botsetflag("dont_path_to_enemy",var_00);
		if(var_00 == 1)
		{
			wait(7);
			continue;
		}

		wait(2);
	}
}

//Function Number: 9
setup_leprechaun_aim_assist()
{
	level endon("game_ended");
	self endon("death");
	if(!level.var_984D)
	{
		return;
	}

	foreach(var_01 in level.var_744A)
	{
		if(isdefined(var_01.var_1A7) && var_01.var_1A7 == self.var_1A7)
		{
			var_01 sethubopponentent(self);
		}
	}

	for(;;)
	{
		level waittill("player_spawned",var_01);
		if(isdefined(var_01.var_1A7) && var_01.var_1A7 == self.var_1A7)
		{
			var_01 sethubopponentent(self);
		}
	}
}

//Function Number: 10
leprechaun_think()
{
	self notify("leprechaun_think");
	self endon("leprechaun_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("owner_disconnect");
	for(;;)
	{
		self [[ self.var_6F7F ]]();
		wait 0.05;
	}
}

//Function Number: 11
on_leprechaun_killed(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	playfx(common_scripts\utility::func_44F5("leprechaun_death_fx"),self.var_116);
	thread message_leprechaun_death();
	thread leprechaun_death_sfx();
	self [[ level.var_A5D ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,1);
	var_09 = maps\mp\_events::func_43D6(param_04,param_03);
	level thread all_player_card_splash("leprechaun_killed",param_01);
	if(isplayer(param_01))
	{
		level thread maps\mp\gametypes\_rank::func_1457("leprechaun_killed",param_01,param_04,undefined,param_03);
		param_01 thread give_leprechaun_score_over_time();
		param_01 thread lib_0468::func_A22("lepKill");
	}

	if(isdefined(level.var_6A75))
	{
		[[ level.var_6A75 ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	}

	if(self.var_565F)
	{
		self.var_4B60 = 1;
		if(maps\mp\_utility::func_44FC() != 1 && isdefined(self.var_7DAD) && self.var_7DAD)
		{
			self thread [[ maps/mp/agents/_agent_utility::func_A59("spawn") ]]();
		}
		else
		{
			maps/mp/agents/_agent_utility::func_2A73();
		}
	}

	level.leprechaun = undefined;
}

//Function Number: 12
get_highest_streak_cost()
{
	if(!isdefined(self.var_5A71))
	{
		return 0;
	}

	var_00 = 0;
	foreach(var_02 in self.var_5A71)
	{
		var_03 = maps\mp\killstreaks\_killstreaks::func_46B4(var_02);
		if(var_03 > var_00)
		{
			var_00 = var_03;
		}
	}

	return var_00;
}

//Function Number: 13
give_leprechaun_score_over_time()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	var_00 = 0;
	var_01 = get_highest_streak_cost();
	if(maps\mp\_utility::func_649("specialty_killstreaks"))
	{
		var_00 = 1;
	}
	else
	{
		var_00 = 100;
		var_01 = int(var_01 / var_00);
	}

	for(var_02 = 0;var_02 < var_01;var_02++)
	{
		maps\mp\killstreaks\_killstreaks::func_4771(var_00);
		wait 0.05;
	}
}

//Function Number: 14
is_valid_leprechaun_attacker(param_00)
{
	var_01 = undefined;
	if(isdefined(param_00) && isdefined(self.var_117))
	{
		if(isdefined(param_00.var_117) && isplayer(param_00.var_117))
		{
			param_00 = param_00.var_117;
		}

		if(param_00 == self.var_117)
		{
			return;
		}

		if(issentient(self.var_117) && issentient(param_00))
		{
			if(!isalliedsentient(self.var_117,param_00))
			{
				var_01 = param_00;
			}
		}
		else if(level.var_984D)
		{
			if(self.var_117.var_1A7 != param_00.var_1A7)
			{
				var_01 = param_00;
			}
		}
		else if(self.var_117 != param_00)
		{
			var_01 = param_00;
		}
	}

	return var_01;
}

//Function Number: 15
all_player_card_splash(param_00,param_01,param_02)
{
	if(level.var_4B17)
	{
		return;
	}

	foreach(var_04 in level.var_744A)
	{
		if(!isdefined(var_04))
		{
			continue;
		}

		if(!isplayer(var_04))
		{
			continue;
		}

		var_04 thread maps\mp\gametypes\_hud_message::func_73C2(param_00,param_01,param_02);
	}
}

//Function Number: 16
watch_leprechaun_damage()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		thread leprechaun_hit_sfx();
		var_0A = var_00;
	}
}

//Function Number: 17
start_leprechaun_audio()
{
	var_00 = 2;
	var_01 = 5;
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	lib_0380::func_6844("mp_st_pattys_lepre_appearance",undefined,self);
	self.leprechaun_vo = lib_0380::func_6846("mp_st_pattys_lepre_vo_intro",undefined,self);
	if(isdefined(self.leprechaun_vo))
	{
		self.leprechaun_vo registersoundentitydonenotify(self,"leprechaun_vo_done");
		self waittill("leprechaun_vo_done");
		self.leprechaun_vo = undefined;
	}

	for(;;)
	{
		var_02 = randomfloatrange(var_00,var_01);
		wait(var_02);
		if(!isdefined(self.leprechaun_hit_vo))
		{
			self.leprechaun_vo = lib_0380::func_6846("mp_st_pattys_lepre_vo_run",undefined,self);
			if(isdefined(self.leprechaun_vo))
			{
				self.leprechaun_vo registersoundentitydonenotify(self,"leprechaun_vo_done");
				self waittill("leprechaun_vo_done");
				self.leprechaun_vo = undefined;
			}
		}
	}
}

//Function Number: 18
leprechaun_hit_sfx()
{
	if(isdefined(self.leprechaun_vo))
	{
		lib_0380::func_6850(self.leprechaun_vo,0.05);
		self.leprechaun_vo = undefined;
	}

	if(!isdefined(self.leprechaun_hit_vo))
	{
		self.leprechaun_hit_vo = lib_0380::func_6846("mp_st_pattys_lepre_vo_hit",undefined,self);
		if(isdefined(self.leprechaun_hit_vo))
		{
			self.leprechaun_hit_vo registersoundentitydonenotify(self,"leprechaun_hit_vo_done");
			self waittill("leprechaun_hit_vo_done");
			wait(4);
			self.leprechaun_hit_vo = undefined;
		}
	}
}

//Function Number: 19
leprechaun_death_sfx()
{
	if(isdefined(self.leprechaun_vo))
	{
		lib_0380::func_6850(self.leprechaun_vo,0.05);
		self.leprechaun_vo = undefined;
	}

	if(isdefined(self.leprechaun_hit_vo))
	{
		lib_0380::func_6850(self.leprechaun_hit_vo,0.05);
		self.leprechaun_hit_vo = undefined;
	}

	lib_0380::func_6842("mp_st_pattys_lepre_vo_outro",undefined,self.var_116);
	lib_0380::func_6842("mp_st_pattys_lepre_explo",undefined,self.var_116);
	lib_0380::func_6842("mp_st_pattys_lepre_explo_coins",undefined,self.var_116);
	lib_0380::func_6842("mp_st_pattys_lepre_explo_debris",undefined,self.var_116);
}