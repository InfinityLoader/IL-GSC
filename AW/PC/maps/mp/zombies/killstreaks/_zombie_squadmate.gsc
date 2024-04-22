/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\killstreaks\_zombie_squadmate.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 20
 * Decompile Time: 298 ms
 * Timestamp: 4/22/2024 2:13:16 AM
*******************************************************************/

//Function Number: 1
init()
{
	maps\mp\zombies\ranged_elite_soldier::init_ally();
	level.squadmateduration = 45;
	level.killstreakfuncs["zm_squadmate"] = ::tryusezombiesquadmate;
	level.agent_funcs["zm_squadmate"] = level.agent_funcs["zombie"];
	level.agent_funcs["zm_squadmate"]["think"] = ::squadmate_agent_think;
	level.agent_funcs["zm_squadmate"]["spawn"] = ::maps\mp\zombies\ranged_elite_soldier::onsoldierspawned;
	level.agent_funcs["zm_squadmate"]["onAIConnect"] = ::onsquadmateconnect;
	level.agent_funcs["zm_squadmate"]["on_damaged_finished"] = ::maps\mp\agents\_agents::agent_damage_finished;
	level.agent_funcs["zm_squadmate"]["on_killed"] = ::maps\mp\agents\_agents::on_agent_player_killed;
	level.shouldignoreplayerrevive = ::shouldnotreviveplayer;
}

//Function Number: 2
tryusezombiesquadmate(param_00,param_01)
{
	if(maps\mp\zombies\_util::arekillstreaksdisabled())
	{
		return 0;
	}

	if(maps\mp\agents\_agent_utility::getnumactiveagents("zm_squadmate") >= 1 || isdefined(level.zm_squadmate_waiting_spawn))
	{
		self iprintlnbold(&"ZOMBIE_SQUADMATE_AGENT_MAX");
		return 0;
	}

	if(isdefined(level.shouldignoreplayercallback))
	{
		if([[ level.shouldignoreplayercallback ]](self))
		{
			return 0;
		}
	}

	if(maps\mp\zombies\_util::isplayerteleporting(self))
	{
		return 0;
	}

	level.zm_squadmate_waiting_spawn = 1;
	thread resetvarsondeath();
	self iprintlnbold(&"ZOMBIE_SQUADMATE_SQUADMATE_REQUEST");
	var_02 = 0;
	var_03 = [];
	var_04 = 0;
	while(!var_04)
	{
		var_05 = maps\mp\zombies\_util::getenemyagents();
		var_06 = maps\mp\zombies\_util::getnumagentswaitingtodeactivate();
		var_02 = var_05.size + var_06 - maps\mp\zombies\zombies_spawn_manager::getmaxenemycount() - 4;
		var_03 = maps\mp\zombies\_util::getarrayofoffscreenagentstorecycle(var_05);
		if(var_03.size >= var_02)
		{
			var_04 = 1;
			continue;
		}

		wait(0.05);
	}

	if(var_02 > 0)
	{
		var_03 = common_scripts\utility::array_randomize(var_03);
		while(var_02 > 0)
		{
			var_07 = var_03[var_02 - 1];
			var_07 suicide();
			var_02--;
		}
	}

	level.maxenemycount = maps\mp\zombies\zombies_spawn_manager::getmaxenemycount() - 4;
	wait(0.5);
	var_08 = getvalidspawnnodesforsquadmate(4);
	if(var_08.size < 4)
	{
		level.zm_squadmate_waiting_spawn = undefined;
		level.maxenemycount = maps\mp\zombies\zombies_spawn_manager::getmaxenemycount();
		return 0;
	}

	var_09 = self.origin;
	var_0A = self.team;
	var_0B = [];
	while(var_0B.size < 4)
	{
		var_0C = var_08[var_0B.size];
		var_0D = var_0C.origin;
		var_0E = vectortoangles(var_09 - var_0C.origin);
		var_0F = maps\mp\agents\_agent_common::connectnewagent("zm_squadmate",var_0A);
		var_0F.overridebodymodel = "sentinel_udt_strike_body_a";
		var_0F.overrideheadmodel = "sentinel_udt_strike_head_a";
		var_0F maps\mp\agents\_agents::spawn_agent_player(var_0D,var_0E,self);
		var_0F thread soldierhandlevo();
		var_0B[var_0B.size] = var_0F;
		playfx(common_scripts\utility::getfx("npc_teleport_ally"),var_0D,(1,0,0),(0,0,1));
		wait(0.05);
	}

	self notify("squadmate_succeeded");
	level thread watchsquaddeath(var_0B);
	level.zm_squadmate_waiting_spawn = undefined;
	return 1;
}

//Function Number: 3
resetvarsondeath()
{
	level endon("game_ended");
	self endon("squadmate_succeeded");
	self waittill("death");
	level.zm_squadmate_waiting_spawn = undefined;
	level.maxenemycount = maps\mp\zombies\zombies_spawn_manager::getmaxenemycount();
}

//Function Number: 4
watchsquaddeath(param_00)
{
	level endon("game_ended");
	var_01 = 0;
	while(!var_01)
	{
		wait(0.05);
		var_01 = 1;
		foreach(var_03 in param_00)
		{
			if(isalive(var_03) && var_03.agent_type == "zm_squadmate")
			{
				var_01 = 0;
			}
		}
	}

	level.maxenemycount = maps\mp\zombies\zombies_spawn_manager::getmaxenemycount();
}

//Function Number: 5
onsquadmateconnect()
{
	self.agentname = &"ZOMBIE_SQUADMATE_SENTINEL";
}

//Function Number: 6
destroyonownerdisconnect(param_00)
{
	self endon("death");
	self endon("disconnect");
	param_00 common_scripts\utility::waittill_any("death","disconnect");
	self notify("owner_disconnect");
	if(maps\mp\gametypes\_hostmigration::waittillhostmigrationdone())
	{
		wait(0.05);
	}

	self suicide();
}

//Function Number: 7
squadmate_agent_think()
{
	self endon("death");
	self endon("disconnect");
	self endon("owner_disconnect");
	level endon("game_ended");
	maps\mp\_utility::giveperk("specialty_coldblooded",0);
	childthread maps\mp\zombies\ranged_elite_soldier::ammorefillprimary();
	childthread maps\mp\zombies\ranged_elite_soldier::ammorefillsecondary();
	childthread maps\mp\bots\_bots::bot_think_revive();
	childthread stay_in_playspace();
	childthread monitorteleporttraversals();
	thread destroyonownerdisconnect(self.owner);
	self.onlydamagedbylargeenemies = 1;
	var_00 = 0;
	var_01 = 0;
	var_02 = 0;
	while(var_02 < level.squadmateduration)
	{
		var_03 = [];
		if(isdefined(level.get_breached_zones_func))
		{
			var_03 = [[ level.get_breached_zones_func ]]();
		}

		if(var_03.size > 0 && !maps\mp\bots\_bots_strategy::bot_has_tactical_goal("defuse"))
		{
			var_04 = undefined;
			foreach(var_06 in var_03)
			{
				if(isdefined(self.owner.currentzone) && self.owner.currentzone == var_06)
				{
					var_04 = var_06;
				}
			}

			var_08 = undefined;
			if(isdefined(var_04))
			{
				foreach(var_0A in level.breachzones[var_04].defuseobjs)
				{
					if(var_0A.visuals[0].enabled)
					{
						var_08 = var_0A;
						break;
					}
				}
			}

			if(isdefined(var_08))
			{
				var_0C = spawnstruct();
				var_0C.object = var_08;
				var_0C.should_abort = ::zone_no_longer_breached;
				var_0C.action_thread = ::defuse_bomb;
				var_0C.end_thread = ::stop_defusing;
				maps\mp\bots\_bots_strategy::bot_new_tactical_goal("defuse",var_08.curorigin,50,var_0C);
			}
		}

		if(float(self.owner.health) / self.owner.maxhealth < 0.5 && gettime() > var_01)
		{
			var_0D = getnodesinradiussorted(self.owner.origin,256,0);
			if(var_0D.size >= 2)
			{
				self.defense_force_next_node_goal = var_0D[1];
				self notify("defend_force_node_recalculation");
				var_01 = gettime() + 1000;
			}
		}
		else if(float(self.health) / self.maxhealth >= 0.6)
		{
			var_00 = 0;
		}
		else if(!var_00)
		{
			var_0E = maps\mp\bots\_bots_util::bot_find_node_to_guard_player(self.owner.origin,350,1);
			if(isdefined(var_0E))
			{
				self.defense_force_next_node_goal = var_0E;
				self notify("defend_force_node_recalculation");
				var_00 = 1;
			}
		}

		if(!maps\mp\bots\_bots_util::bot_is_guarding_player(self.owner))
		{
			var_0F["override_goal_type"] = "critical";
			var_0F["min_goal_time"] = 20;
			var_0F["max_goal_time"] = 30;
			maps\mp\bots\_bots_strategy::bot_guard_player(self.owner,350,var_0F);
		}

		wait(0.05);
		var_02 = var_02 + 0.05;
	}

	self suicide();
}

//Function Number: 8
stay_in_playspace()
{
	self endon("death");
	level endon("game_ended");
	self endon("owner_disconnect");
	for(;;)
	{
		if(isdefined(level.zone_data) && !maps\mp\zombies\_zombies_zone_manager::iszombieinanyzone(self))
		{
			var_00 = self.owner getvalidspawnnodesforsquadmate(1);
			if(var_00.size > 0)
			{
				var_01 = var_00[0];
				playfx(common_scripts\utility::getfx("npc_teleport_ally"),self.origin,(1,0,0),(0,0,1));
				self setorigin(var_01.origin,1);
				self setplayerangles(var_01.angles);
				playfx(common_scripts\utility::getfx("npc_teleport_ally"),var_01.origin,(1,0,0),(0,0,1));
			}
		}

		wait(0.05);
	}
}

//Function Number: 9
monitorteleporttraversals()
{
	if(maps\mp\zombies\_util::getzombieslevelnum() < 4)
	{
		return;
	}

	for(;;)
	{
		var_00 = undefined;
		var_01 = self botgetnodesonpath();
		for(var_02 = 0;var_02 < var_01.size - 1;var_02++)
		{
			if(var_01[var_02].type == "Begin" && var_01[var_02 + 1].type == "End" && var_01[var_02].animscript == "climbup_shaft")
			{
				var_00 = var_01[var_02];
				break;
			}
		}

		if(isdefined(var_00) && distancesquared(self.origin,var_00.origin) < 256)
		{
			var_03 = getnode(var_00.target,"targetname");
			playfx(common_scripts\utility::getfx("npc_teleport_ally"),self.origin,(1,0,0),(0,0,1));
			self setorigin(var_03.origin,1);
			self setplayerangles(var_03.angles);
			playfx(common_scripts\utility::getfx("npc_teleport_ally"),var_03.origin,(1,0,0),(0,0,1));
		}

		wait(0.05);
	}
}

//Function Number: 10
zone_no_longer_breached(param_00)
{
	if(![[ level.zone_is_breached_func ]](param_00.object.zonename))
	{
		return 1;
	}

	return 0;
}

//Function Number: 11
defuse_bomb(param_00)
{
	if(!param_00.object.visuals[0].enabled)
	{
		return;
	}

	if(isagent(self))
	{
		common_scripts\utility::_enableusability();
		param_00.object.visuals[0] enableplayeruse(self);
		wait(0.05);
	}

	var_01 = self.team;
	thread soldierplayvo("defuse");
	maps\mp\bots\_bots_gametype_sd::sd_press_use(level.defusetime + 2,"bomb_defused",1,0);
	if(isagent(self))
	{
		common_scripts\utility::_disableusability();
		if(isdefined(param_00.object))
		{
			param_00.object.visuals[0] disableplayeruse(self);
		}
	}
}

//Function Number: 12
stop_defusing(param_00)
{
	self botclearscriptgoal();
}

//Function Number: 13
getvalidspawnnodesforsquadmate(param_00)
{
	var_01 = self.origin;
	if(isplayer(self))
	{
		var_02 = self getnearestnode();
	}
	else
	{
		var_02 = getclosestnodeinsight(var_02);
	}

	if(!isdefined(var_02))
	{
		var_03 = getnodesinradius(var_01,350,64,128,"Path");
		var_02 = var_03[0];
	}

	var_04 = undefined;
	if(isdefined(level.zone_data))
	{
		var_04 = maps\mp\zombies\_zombies_zone_manager::getlocationzone(var_01);
		if(!isdefined(var_04))
		{
			var_04 = maps\mp\zombies\_zombies_zone_manager::getlocationzone(var_01 + (randomfloatrange(-1,1),randomfloatrange(-1,1),0));
		}
	}

	var_05 = getnodesinradius(var_01,400,64,128,"Path");
	if(var_05.size < param_00)
	{
		return [];
	}

	for(var_06 = 0;var_06 < var_05.size;var_06++)
	{
		if(isdefined(level.zone_data) && maps\mp\zombies\_util::nodeisinspawncloset(var_05[var_06]))
		{
			var_05[var_06] = var_05[var_05.size - 1];
			var_05[var_05.size - 1] = undefined;
			var_06--;
		}
	}

	if(var_05.size < param_00)
	{
		return [];
	}

	var_07 = [];
	var_08 = nodegetsplitgroup(var_02);
	foreach(var_0A in var_05)
	{
		if(!var_0A doesnodeallowstance("stand"))
		{
			continue;
		}

		if(maps\mp\zombies\_util::is_true(var_0A.nosoldierspawn))
		{
			continue;
		}

		var_0B = nodegetsplitgroup(var_0A);
		if(var_08 != var_0B)
		{
			continue;
		}

		if(isdefined(level.zone_data) && var_04 != var_0A.zombieszone)
		{
			continue;
		}

		var_07[var_07.size] = var_0A;
	}

	if(var_07.size < param_00)
	{
		return [];
	}

	var_0D = [];
	var_0E = (0,0,64);
	for(var_0F = 0;var_0F < param_00;var_0F++)
	{
		var_10 = common_scripts\utility::array_randomize(var_07);
		while(var_10.size > 5)
		{
			var_10[var_10.size - 1] = undefined;
		}

		var_11 = sortarraybyclosesttoobjects(var_10,var_0D);
		for(var_06 = var_11.size - 1;var_06 >= 0;var_06--)
		{
			var_12 = var_11[var_06];
			if(!self aiphysicstracepassed(var_12.origin + var_0E,var_12.origin,24,80,1))
			{
				var_12.nosoldierspawn = 1;
				continue;
			}

			var_0D[var_0D.size] = var_12;
			break;
		}
	}

	while(var_0D.size < param_00)
	{
		var_0D[var_0D.size] = common_scripts\utility::random(var_0D);
	}

	return var_0D;
}

//Function Number: 14
sortarraybyclosesttoobjects(param_00,param_01)
{
	if(param_01.size == 0)
	{
		return param_00;
	}

	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		param_00[var_02].temp_distance = 0;
		foreach(var_04 in param_01)
		{
			param_00[var_02].temp_distance = param_00[var_02].temp_distance + distance(param_00[var_02].origin,var_04.origin);
		}
	}

	var_06 = maps\mp\_utility::quicksort(param_00,::comparedistancestoobjects);
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		param_00[var_02].temp_distance = undefined;
	}

	return var_06;
}

//Function Number: 15
comparedistancestoobjects(param_00,param_01)
{
	return param_00.temp_distance <= param_01.temp_distance;
}

//Function Number: 16
soldierhandlevo()
{
	self endon("death");
	wait(1);
	if(!isdefined(level.sentineldebouncevo))
	{
		return;
	}

	var_00 = soldierplayvo("spawn");
	if(var_00)
	{
		level thread dosentinelconv(self);
	}

	thread soldierdochatter();
	for(;;)
	{
		var_00 = common_scripts\utility::waittill_any_return_no_endon_death("bot_reviving","killed_enemy");
		if(var_00 == "bot_reviving")
		{
			soldierplayvo("revive");
			continue;
		}

		soldierplayvo("kill");
	}
}

//Function Number: 17
soldierdochatter()
{
	self endon("death");
	var_00 = 90000;
	for(;;)
	{
		wait(randomintrange(5,10));
		var_01 = 0;
		var_02 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
		foreach(var_04 in var_02)
		{
			if(var_04.team == level.playerteam)
			{
				continue;
			}

			var_05 = distancesquared(self.origin,var_04.origin);
			if(var_05 <= var_00)
			{
				soldierplayvo("chatter");
				break;
			}
		}
	}
}

//Function Number: 18
soldierplayvo(param_00)
{
	self endon("death");
	if(!isdefined(self.zmbvoxid))
	{
		self.zmbvoxid = "sentinel";
	}

	if(!isdefined(level.sentineldebouncevo))
	{
		return 0;
	}

	if(isdefined(level.sentineldebouncevo[param_00]) && level.sentineldebouncevo[param_00] > gettime())
	{
		return 0;
	}

	if(maps\mp\zombies\_zombies_audio::create_and_play_dialog("general",param_00))
	{
		if(isdefined(level.sentineldebouncevo[param_00]))
		{
			level.sentineldebouncevo[param_00] = gettime() + 10000;
		}

		return 1;
	}

	return 0;
}

//Function Number: 19
dosentinelconv(param_00)
{
	if(maps\mp\zombies\_util::is_true(level.zmbplayedsentinelconv))
	{
		return;
	}

	param_00 common_scripts\utility::waittill_notify_or_timeout("done_speaking",3);
	var_01 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("pilot");
	if(!isdefined(var_01))
	{
		return;
	}

	var_02 = var_01 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","sentinel_conv");
	if(var_02)
	{
		level.zmbplayedsentinelconv = 1;
		var_01 common_scripts\utility::waittill_notify_or_timeout("done_speaking",8);
	}
	else
	{
		return;
	}

	if(level.players.size > 1)
	{
		var_03 = param_00.owner;
		if(!isdefined(var_03) || isdefined(var_01) && var_03 == var_01)
		{
			var_04 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("guard");
			var_05 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("exec");
			var_06 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("it");
			var_03 = var_04;
			if(!isdefined(var_03) || isdefined(var_05) && common_scripts\utility::cointoss())
			{
				var_03 = var_05;
			}

			if(!isdefined(var_03) || isdefined(var_06) && common_scripts\utility::cointoss())
			{
				var_03 = var_06;
			}

			if(!isdefined(var_03) || isdefined(var_04) && common_scripts\utility::cointoss())
			{
				var_03 = var_04;
			}
		}

		var_03 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","sentinel_conv");
	}
}

//Function Number: 20
shouldnotreviveplayer(param_00)
{
	if(maps\mp\zombies\_util::getnumplayers() == 1)
	{
		if(isdefined(param_00.curprogress) && isdefined(param_00.usetime) && param_00.curprogress < param_00.usetime)
		{
			return 1;
		}
	}

	return 0;
}