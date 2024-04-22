/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\_area_invalidation.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 63
 * Decompile Time: 974 ms
 * Timestamp: 4/22/2024 2:13:33 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["zone_explode"] = loadfx("fx/explosions/helicopter_explosion_secondary_small");
	level._effect["pickup_camo"] = loadfx("vfx/gameplay/mp/zombie/dlc_pickup_zombies_01_camo");
	level.breachzones = [];
	level.breachtimers = [];
	level.get_breached_zones_func = ::get_breached_zones;
	level.zone_is_breached_func = ::zone_is_breached;
	level.zone_is_contaminated_func = ::zone_is_contaminated;
	level.defusedamagemultiplier = 2;
	level.breachmapfunc = ::breach_map_func;
	level.bombsdefused = 0;
	var_00 = getentarray("zombies_defuse_bomb","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = maps\mp\zombies\_zombies_zone_manager::getlocationzone(var_02.origin);
		if(!isdefined(level.breachzones[var_03]))
		{
			level.breachzones[var_03] = spawnstruct();
			level.breachzones[var_03].status = 0;
			level.breachzones[var_03].lastfixtime = 0;
			level.breachzones[var_03].defuseobjs = [];
		}

		var_04 = var_02 initdefuseobject();
		var_04.zonename = var_03;
		level.breachzones[var_03].defuseobjs[level.breachzones[var_03].defuseobjs.size] = var_04;
	}

	level thread run_breach_logic();
	level thread initsaboteurdata();
	level thread monitordefusetime();
}

//Function Number: 2
breach_map_func(param_00)
{
	if(!isdefined(param_00.script_flag_true))
	{
		return;
	}

	if(!common_scripts\utility::flag_exist(param_00.script_flag_true))
	{
		return;
	}

	level endon("game_ended");
	for(;;)
	{
		param_00 ghost();
		common_scripts\utility::flag_wait(param_00.script_flag_true);
		param_00 show();
		common_scripts\utility::flag_waitopen(param_00.script_flag_true);
	}
}

//Function Number: 3
monitordefusetime()
{
	level endon("game_ended");
	for(;;)
	{
		if(maps\mp\zombies\_util::getnumplayers() == 1)
		{
			level.defusetime = 2;
		}
		else
		{
			level.defusetime = 5;
		}

		wait(1);
	}
}

//Function Number: 4
initsaboteurdata()
{
	while(!isdefined(level.agent_funcs) || !isdefined(level.agent_funcs["ranged_elite_soldier"]))
	{
		wait(0.05);
	}

	level.area_invalidation_soldier_type = "ranged_elite_soldier_saboteur";
	level.agent_funcs[level.area_invalidation_soldier_type] = level.agent_funcs["ranged_elite_soldier"];
	level.agent_funcs[level.area_invalidation_soldier_type]["think"] = ::soldier_think;
	var_00 = level.agentclasses["ranged_elite_soldier"];
	maps\mp\zombies\_util::agentclassregister(var_00,level.area_invalidation_soldier_type);
	while(!isdefined(level.agent_funcs["ranged_elite_soldier_goliath"]))
	{
		wait(0.05);
	}

	level.area_invalidation_goliath_type = "ranged_elite_soldier_goliath_saboteur";
	level.agent_funcs[level.area_invalidation_goliath_type] = level.agent_funcs["ranged_elite_soldier_goliath"];
	level.agent_funcs[level.area_invalidation_goliath_type]["think"] = ::soldier_think;
	level.getloadout[level.area_invalidation_goliath_type] = level.getloadout["ranged_elite_soldier_goliath"];
	level.onspawnfinished[level.area_invalidation_goliath_type] = level.onspawnfinished["ranged_elite_soldier_goliath"];
	var_01 = level.agentclasses["ranged_elite_soldier_goliath"];
	maps\mp\zombies\_util::agentclassregister(var_01,level.area_invalidation_goliath_type);
}

//Function Number: 5
initdefuseobject()
{
	self setcursorhint("HINT_NOICON");
	self sethintstring(&"AREA_INVALIDATION_BOMB_DEFUSE");
	var_00 = getent(self.target,"targetname");
	var_00 makeunusable();
	self.trigger = var_00;
	var_01 = maps\mp\gametypes\_gameobjects::createuseobject("allies",var_00,[self],(0,0,32),1);
	var_01 maps\mp\gametypes\_gameobjects::allowuse("friendly");
	var_01 maps\mp\gametypes\_gameobjects::setusetext(&"MP_DEFUSING_EXPLOSIVE");
	var_01.onbeginuse = ::defuseonbeginuse;
	var_01.onenduse = ::defuseonenduse;
	var_01.onuse = ::onusedefuseobject;
	var_01.nousebar = 1;
	var_01.id = "defuseObject";
	var_01.useweapon = "search_dstry_bomb_defuse_mp";
	var_01.visuals[0] hide();
	var_01.visuals[0].enabled = 0;
	return var_01;
}

//Function Number: 6
activatedefuseobject()
{
	maps\mp\gametypes\_gameobjects::setusetime(level.defusetime);
	self.visuals[0] hudoutlineenable(0,0);
	self.visuals[0] setbombenabled(1);
	self.visuals[0] thread defusethink();
	self.hudicon = newhudelem();
	self.hudicon setshader("hud_waypoint_bomb",8,8);
	self.hudicon setwaypoint(1,1);
	self.hudicon.x = self.visuals[0].origin[0];
	self.hudicon.y = self.visuals[0].origin[1];
	self.hudicon.z = self.visuals[0].origin[2] + 40;
}

//Function Number: 7
deactivatedefuseobject()
{
	self.visuals[0] setbombenabled(0);
	self.visuals[0] notify("bomb_exploded");
	if(isdefined(self.hudicon))
	{
		self.hudicon destroy();
	}
}

//Function Number: 8
defusethink()
{
	level endon("game_ended");
	level endon("defuse_completed");
	self endon("bomb_exploded");
	for(;;)
	{
		self waittill("trigger",var_00);
		self.trigger notify("trigger",var_00);
	}
}

//Function Number: 9
defuseonbeginuse(param_00)
{
	param_00 notifysoldiersbombbeingused("defuse");
	param_00 playsound("mp_bomb_defuse");
	param_00.isdefusing = 1;
	self.visuals[0] setbombenabled(0);
	self.hudicon setshader("hud_waypoint_bomb_defuse",8,8);
	self.hudicon setwaypoint(1,1);
}

//Function Number: 10
defuseonenduse(param_00,param_01,param_02)
{
	if(level.breachzones[self.zonename].status != 2)
	{
		self.visuals[0] setbombenabled(1);
		self.hudicon setshader("hud_waypoint_bomb",8,8);
		self.hudicon setwaypoint(1,1);
	}

	if(isdefined(param_01))
	{
		param_01.isdefusing = 0;
		param_01.isplanting = 0;
	}
}

//Function Number: 11
onusedefuseobject(param_00)
{
	param_00 notify("bomb_defused");
	self.visuals[0] setbombenabled(0);
	var_01 = param_00;
	if(!isplayer(var_01) && isplayer(var_01.owner))
	{
		var_01 = var_01.owner;
	}

	var_01 maps\mp\gametypes\zombies::givepointsforevent("breach_fix");
	if(isplayer(param_00))
	{
		givedefuseachievement(param_00);
	}

	level.bombsdefused++;
	var_02 = param_00;
	if(!isplayer(param_00))
	{
		var_02 = level.players[0];
	}

	if(isdefined(var_02))
	{
		var_02 thread maps\mp\_matchdata::loggameevent("zm_bomb_defuse",self.curorigin);
	}

	if(maps\mp\zombies\_util::is_true(level.breachinitial))
	{
		var_03 = maps\mp\gametypes\zombies::selectnextvalidpickupavoid("ammo");
		maps\mp\gametypes\zombies::createpickup(var_03,param_00.origin,"Defuse Bomb");
	}

	level thread clean_zone(self.zonename);
	self.hudicon destroy();
	level thread dodefusefailvo();
}

//Function Number: 12
dodefusefailvo()
{
	wait(1);
	waittilldonespeaking();
	wait(1);
	var_00 = [];
	foreach(var_02 in level.participants)
	{
		if(isai(var_02) && var_02.team != level.playerteam)
		{
			var_02 notify("fail_gas");
			var_00[var_00.size] = var_02;
		}
	}

	var_04 = gettime() + 5000;
	while(var_04 > gettime() && var_00.size > 0)
	{
		if(var_00[0] soldierplayvo("fail"))
		{
			break;
		}

		wait(0.1);
		var_00 = common_scripts\utility::array_removeundefined(var_00);
	}
}

//Function Number: 13
waittilldonespeaking()
{
	while(anyplayersspeaking() || maps\mp\zombies\_zombies_audio_announcer::isannouncerspeaking())
	{
		wait(0.1);
	}
}

//Function Number: 14
anyplayersspeaking()
{
	foreach(var_01 in level.players)
	{
		if(maps\mp\zombies\_util::is_true(var_01.isspeaking))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 15
givedefuseachievement(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(!isdefined(param_00.bombdefusecount))
	{
		param_00.bombdefusecount = 0;
	}

	param_00.bombdefusecount++;
	if(param_00.bombdefusecount == 5)
	{
		param_00 maps\mp\gametypes\zombies::givezombieachievement("DLC3_ZOMBIE_DEFUSEBOMBS");
	}
}

//Function Number: 16
setbombenabled(param_00)
{
	if(param_00)
	{
		self show();
		self makeusable();
		self.enabled = 1;
		return;
	}

	self hide();
	self makeunusable();
	self.enabled = 0;
}

//Function Number: 17
notifysoldiersbombbeingused(param_00)
{
	foreach(var_02 in level.participants)
	{
		if(!isai(var_02) || isalliedsentient(self,var_02))
		{
			continue;
		}

		var_03 = 0;
		if(param_00 == "plant")
		{
			var_03 = 300 + var_02 botgetdifficultysetting("strategyLevel") * 100;
		}
		else if(param_00 == "defuse")
		{
			var_03 = 500 + var_02 botgetdifficultysetting("strategyLevel") * 500;
		}

		if(distancesquared(var_02.origin,self.origin) < squared(var_03))
		{
			var_02.player_defuse_time = gettime();
			var_02 soldierplayvo("trydefuse");
		}
	}
}

//Function Number: 18
setupzone(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	level.breachzones[param_00].exploderid = param_01;
	level.breachzones[param_00].omnvarid = param_02;
	level.breachzones[param_00].locname = param_03;
	level.breachzones[param_00].splashname = param_04;
	level.breachzones[param_00].defusesplashname = param_05;
	level.breachzones[param_00].detonatesplashname = param_06;
	level.breachzones[param_00].hascurestation = param_07;
	common_scripts\utility::flag_init("breach_" + param_00);
}

//Function Number: 19
clean_zone_splash_delayed(param_00)
{
	level endon("game_ended");
	if(maps\mp\zombies\_util::is_true(level.breachinitial))
	{
		wait(1);
	}

	if(isdefined(level.breachzones[param_00].defusesplashname))
	{
		maps\mp\gametypes\zombies::showteamsplashzombies(level.breachzones[param_00].defusesplashname);
	}

	level thread dobreachclearedvo(param_00);
}

//Function Number: 20
clean_zone(param_00)
{
	if(level.breachzones[param_00].status == 0)
	{
		return;
	}

	if(level.breachzones[param_00].status == 1)
	{
		level thread clean_zone_splash_delayed(param_00);
		playsoundatpos((0,0,0),"event_gas_success");
		var_01 = get_soldiers_breaching_zone(param_00);
		foreach(var_03 in var_01)
		{
			var_03.bomb_guarding = undefined;
		}
	}
	else
	{
		stopclientexploder(level.breachzones[param_00].exploderid);
	}

	remove_breach_timer(param_00);
	level.breachzones[param_00].status = 0;
	level.breachzones[param_00].lastfixtime = gettime();
	common_scripts\utility::flag_clear("breach_" + param_00);
	level notify("clean" + param_00);
	foreach(var_06 in level.breachzones[param_00].defuseobjs)
	{
		var_06.soldiers = [];
	}
}

//Function Number: 21
try_continue_breach(param_00,param_01)
{
	if(param_00.size > 0)
	{
		var_02 = common_scripts\utility::getstructarray("soldier_teleport_struct","targetname");
		for(var_03 = 0;var_03 < param_00.size;var_03++)
		{
			var_04 = param_00[var_03];
			thread playteleportspawnfx(var_04.origin,1);
			var_04 hide_soldier_and_make_invulnerable(1);
			var_04 setorigin(var_02[var_03].origin,1);
		}

		wait(5);
		var_05 = get_contaminated_zones();
		var_06 = 0;
		if(var_05.size < 3)
		{
			var_06 = do_breach(param_00,param_01);
			if(!var_06)
			{
				var_06 = do_breach(param_00);
			}
		}

		if(!var_06)
		{
			foreach(var_04 in param_00)
			{
				var_04 suicide();
			}
		}
	}
}

//Function Number: 22
hide_soldier_and_make_invulnerable(param_00)
{
	if(param_00)
	{
		self hide();
	}
	else
	{
		self show();
	}

	self.ignoreme = param_00;
	self.ignoreall = param_00;
	self.godmode = param_00;
	self botsetflag("disable_movement",param_00);
}

//Function Number: 23
breach_zone_timer(param_00)
{
	level endon("game_ended");
	level endon("clean" + param_00);
	level endon("contaminate" + param_00);
	var_01 = gettime() + get_breach_time();
	for(;;)
	{
		var_02 = max(0,var_01 - gettime()) / 1000;
		var_03 = int(var_02 + 0.5);
		if(var_03 == 0)
		{
			break;
		}

		if(var_03 <= 10 || var_03 <= 30 && var_03 % 2 == 0)
		{
			playsoundatpos((0,0,0),"ui_mp_timer_countdown");
		}

		if(var_02 - floor(var_02) >= 0.05)
		{
			wait(var_02 - floor(var_02));
		}

		maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(1);
	}

	while(some_player_is_defusing())
	{
		wait(0.05);
	}

	level thread contaminate_zone(param_00);
}

//Function Number: 24
some_player_is_defusing()
{
	foreach(var_01 in level.participants)
	{
		if(var_01.team == level.playerteam)
		{
			if(maps\mp\zombies\_util::is_true(var_01.isdefusing))
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 25
get_active_bomb_ent(param_00)
{
	foreach(var_02 in level.breachzones[param_00].defuseobjs)
	{
		if(var_02.visuals[0].enabled)
		{
			return var_02;
		}
	}

	return undefined;
}

//Function Number: 26
breach_zone(param_00,param_01)
{
	if(level.breachzones[param_00].status == 1)
	{
		return;
	}

	if(level.breachzones[param_00].status == 2)
	{
		clean_zone(param_00);
	}

	var_02 = level.breachzones[param_00].defuseobjs[randomint(level.breachzones[param_00].defuseobjs.size)];
	if(isdefined(param_01))
	{
		movesoldierstonewzone(var_02,param_01);
	}
	else
	{
		spawnsoldiers(var_02,getnumsoldierstospawn());
	}

	var_02 activatedefuseobject();
	if(isdefined(level.players[0]))
	{
		level.players[0] thread maps\mp\_matchdata::loggameevent("zm_bomb_plant",var_02.curorigin);
	}

	if(isdefined(level.breachzones[param_00].splashname))
	{
		maps\mp\gametypes\zombies::showteamsplashzombies(level.breachzones[param_00].splashname);
	}

	level thread maps\mp\zombies\_zombies_audio_announcer::announcerglobaldialogdelay("global_priority","exp_" + param_00,1.5,undefined,undefined,undefined,undefined,level.players);
	playsoundatpos((0,0,0),"event_gas_start");
	level.breachzones[param_00].status = 1;
	level.breachinitial = !isdefined(param_01);
	add_breach_timer(param_00);
	level thread breach_zone_timer(param_00);
	common_scripts\utility::flag_set("breach_" + param_00);
	level notify("breach" + param_00);
}

//Function Number: 27
getnumsoldierstospawn()
{
	var_00 = maps\mp\zombies\_util::getnumplayers();
	if(var_00 == 2)
	{
		return 3;
	}
	else if(var_00 == 1)
	{
		return 2;
	}

	return 4;
}

//Function Number: 28
movesoldierstonewzone(param_00,param_01)
{
	var_02 = param_00.visuals[0] maps\mp\zombies\killstreaks\_zombie_squadmate::getvalidspawnnodesforsquadmate(param_01.size);
	param_00.soldiers = param_01;
	for(var_03 = 0;var_03 < param_01.size;var_03++)
	{
		param_01[var_03] setorigin(var_02[var_03].origin);
		param_01[var_03] setplayerangles(vectortoangles(param_00.curorigin - var_02[var_03].origin));
		param_01[var_03].bomb_guarding = param_00;
		param_01[var_03] hide_soldier_and_make_invulnerable(0);
		param_01[var_03] thread soldier_think();
		thread playteleportspawnfx(var_02[var_03].origin,3);
	}
}

//Function Number: 29
spawnsoldiers(param_00,param_01)
{
	var_02 = 0;
	var_03 = [];
	var_04 = 0;
	while(!var_04)
	{
		var_05 = level.players[0] maps\mp\zombies\_util::getenemyagents();
		var_06 = maps\mp\zombies\_util::getnumagentswaitingtodeactivate();
		var_02 = var_05.size + var_06 - maps\mp\zombies\zombies_spawn_manager::getmaxenemycount() - param_01;
		var_03 = maps\mp\zombies\_util::getarrayofoffscreenagentstorecycle(var_05);
		if(var_03.size >= var_02)
		{
			var_04 = 1;
			continue;
		}

		wait(0.05);
	}

	var_07 = 0;
	if(var_02 > 0)
	{
		maps\mp\zombies\_util::pausezombiespawning(1);
		var_07 = 1;
		var_03 = common_scripts\utility::array_randomize(var_03);
		var_08 = [];
		for(var_09 = 0;var_09 < var_02;var_09++)
		{
			var_08[var_09] = var_03[var_09];
		}

		foreach(var_0B in var_08)
		{
			var_0B suicide();
		}

		wait(0.5);
	}

	var_0F = param_00.visuals[0] maps\mp\zombies\killstreaks\_zombie_squadmate::getvalidspawnnodesforsquadmate(param_01);
	param_00.soldiers = [];
	for(var_09 = 0;var_09 < param_01;var_09++)
	{
		var_10 = var_0F[var_09].origin;
		var_11 = vectortoangles(param_00.curorigin - var_0F[var_09].origin);
		var_12 = level.area_invalidation_soldier_type;
		if(level.wavecounter >= 20 && var_09 == 0)
		{
			var_12 = level.area_invalidation_goliath_type;
		}

		var_13 = maps\mp\agents\_agent_common::connectnewagent(var_12,level.enemyteam);
		var_13.bomb_guarding = param_00;
		var_13 maps\mp\agents\_agents::spawn_agent_player(var_10,var_11);
		param_00.soldiers[param_00.soldiers.size] = var_13;
		var_13 thread soldierhandlevo();
		var_14 = int(maps\mp\gametypes\zombies::calculatezombiehealth(level.agentclasses[var_12]));
		if(var_12 == level.area_invalidation_goliath_type)
		{
			var_14 = int(var_14 * 0.5 * maps\mp\zombies\_util::getnumplayers());
		}

		var_13 maps\mp\agents\_agent_common::set_agent_health(var_14);
		thread playteleportspawnfx(var_10,3);
		wait(0.05);
	}

	if(var_07)
	{
		maps\mp\zombies\_util::pausezombiespawning(0);
	}
}

//Function Number: 30
playteleportspawnfx(param_00,param_01)
{
	playfx(common_scripts\utility::getfx("npc_teleport_enemy"),param_00,(1,0,0),(0,0,1));
}

//Function Number: 31
soldier_think()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self notify("soldier_think");
	self endon("soldier_think");
	childthread maps\mp\zombies\ranged_elite_soldier::ammorefillprimary();
	childthread maps\mp\zombies\ranged_elite_soldier::ammorefillsecondary();
	childthread maps\mp\zombies\_zombies::monitorbadzombieai();
	childthread disableattacksandmovement();
	thread dropcamoondeath();
	for(;;)
	{
		if(isdefined(self.bomb_guarding))
		{
			if(isdefined(self.player_defuse_time) && gettime() - self.player_defuse_time < 3000)
			{
				if(maps\mp\bots\_bots_util::bot_is_defending())
				{
					maps\mp\bots\_bots_strategy::bot_defend_stop();
				}

				self botsetscriptgoal(self.bomb_guarding.curorigin,0,"guard");
			}
			else if(!maps\mp\bots\_bots_util::bot_is_defending_point(self.bomb_guarding.curorigin))
			{
				var_00["score_flags"] = "strict_los";
				maps\mp\bots\_bots_strategy::bot_protect_point(self.bomb_guarding.curorigin,725,var_00);
			}
		}
		else
		{
			maps\mp\bots\_bots_strategy::bot_defend_stop();
			childthread maps\mp\zombies\_util::locateenemypositions();
			break;
		}

		wait(0.05);
	}
}

//Function Number: 32
disableattacksandmovement()
{
	self botsetflag("disable_attack",1);
	self botsetflag("disable_movement",1);
	self botsetflag("disable_rotation",1);
	wait(3);
	self botsetflag("disable_attack",0);
	self botsetflag("disable_movement",0);
	self botsetflag("disable_rotation",0);
}

//Function Number: 33
dropcamoondeath()
{
	self endon("disconnect");
	level endon("game_ended");
	self notify("dropCamoOnDeath");
	self endon("dropCamoOnDeath");
	self waittill("death");
	var_00 = 0;
	if(self.agent_type == "ranged_elite_soldier_goliath_saboteur")
	{
		var_00 = 1;
	}
	else if(maps\mp\agents\_agent_utility::getactiveagentsoftype("ranged_elite_soldier_saboteur").size == 1)
	{
		var_00 = 1;
	}
	else if(randomfloat(1) < 0.25)
	{
		var_00 = 1;
	}

	if(var_00 && isdefined(level.zone_data) && !maps\mp\zombies\_zombies_zone_manager::iszombieinenabledzone(self))
	{
		var_00 = 0;
	}

	if(var_00)
	{
		maps\mp\gametypes\zombies::spawnpickupmodel(self.origin + (0,0,22),undefined,undefined,"pickup_camo",::camopickup,::canactivatecamopickup,0);
	}
}

//Function Number: 34
canactivatecamopickup(param_00)
{
	if(isdefined(param_00) && isagent(param_00))
	{
		return 0;
	}

	if(maps\mp\zombies\_util::isplayerinlaststand(param_00))
	{
		return 0;
	}

	return 1;
}

//Function Number: 35
camopickup(param_00)
{
	var_01 = 8;
	if(maps\mp\zombies\_util::getnumplayers() == 1)
	{
		var_01 = 10;
	}

	param_00 thread maps\mp\zombies\killstreaks\_zombie_camouflage::playercamouflagemode(var_01);
	level thread maps\mp\gametypes\zombies::removepickup(self);
}

//Function Number: 36
infectplayersinzone(param_00)
{
	level endon("game_ended");
	level endon("clean" + param_00);
	var_01 = gettime();
	for(;;)
	{
		foreach(var_03 in level.players)
		{
			if(!isalive(var_03))
			{
				continue;
			}

			if(maps\mp\zombies\_util::isplayerinlaststand(var_03))
			{
				continue;
			}

			if(var_03 isgod())
			{
				continue;
			}

			if(maps\mp\zombies\_util::isplayerteleporting(var_03))
			{
				continue;
			}

			if(maps\mp\zombies\_util::is_true(var_03.onisland))
			{
				continue;
			}

			if(var_03.sessionstate == "spectator" || var_03.sessionstate == "intermission")
			{
				continue;
			}

			if(!isdefined(var_03.currentzone) || var_03.currentzone != param_00)
			{
				continue;
			}

			if(maps\mp\zombies\_util::isplayerinfected(var_03))
			{
				if(!isdefined(var_03.lastinfectdamagetime))
				{
					var_03.lastinfectdamagetime = gettime();
					continue;
				}

				if(gettime() - var_03.lastinfectdamagetime < 2500)
				{
					continue;
				}

				if(gettime() - var_01 < 10000)
				{
					continue;
				}

				var_03 dodamage(25,var_03.origin,undefined,undefined,"MOD_TRIGGER_HURT");
				var_03.lastinfectdamagetime = gettime();
				continue;
			}
			else
			{
				var_04 = 1000;
				var_05 = 1500;
				if(!isdefined(var_03.lastalmostinfecttime) || gettime() - var_03.lastalmostinfecttime > var_05)
				{
					var_03.lastalmostinfecttime = gettime();
				}

				if(gettime() - var_03.lastalmostinfecttime < var_04)
				{
					continue;
				}
			}

			var_03 thread maps\mp\zombies\_zombies_laststand::hostzombielaststand();
			var_03.lastinfectdamagetime = gettime();
		}

		wait(0.1);
	}
}

//Function Number: 37
contaminate_zone(param_00)
{
	if(level.breachzones[param_00].status == 2)
	{
		return;
	}

	if(isdefined(level.breachzones[param_00].detonatesplashname))
	{
		maps\mp\gametypes\zombies::showteamsplashzombies(level.breachzones[param_00].detonatesplashname);
	}

	var_01 = get_contaminated_zones();
	var_02 = var_01.size + 1;
	level thread maps\mp\zombies\_zombies_audio_announcer::announcerglobaldialogdelay("global_priority","exp_fail" + var_02,1.5,undefined,undefined,undefined,undefined,level.players);
	var_03 = get_active_bomb_ent(param_00);
	if(!isdefined(var_03))
	{
		var_03 = level.breachzones[param_00].defuseobjs[0];
	}

	var_03 deactivatedefuseobject();
	playsoundatpos(var_03.curorigin,"event_gas_fail");
	earthquake(0.5,1,var_03.curorigin,10000);
	playfx(common_scripts\utility::getfx("zone_explode"),var_03.curorigin);
	if(isdefined(level.players[0]))
	{
		level.players[0] thread maps\mp\_matchdata::loggameevent("zm_bomb_explode",var_03.curorigin);
	}

	activatepersistentclientexploder(level.breachzones[param_00].exploderid);
	level thread infectplayersinzone(param_00);
	contaminate_breach_timer(param_00);
	level notify("contaminate" + param_00);
	level.breachzones[param_00].status = 2;
	foreach(var_05 in level.participants)
	{
		var_05 notify("stop_useHoldThinkLoop");
	}

	var_07 = get_soldiers_breaching_zone(param_00);
	thread try_continue_breach(var_07,param_00);
	var_03.soldiers = [];
}

//Function Number: 38
get_soldiers_breaching_zone(param_00)
{
	var_01 = [];
	foreach(var_03 in level.breachzones[param_00].defuseobjs)
	{
		if(isdefined(var_03.soldiers))
		{
			foreach(var_05 in var_03.soldiers)
			{
				if(isalive(var_05) && var_05.agent_type == level.area_invalidation_soldier_type || var_05.agent_type == level.area_invalidation_goliath_type)
				{
					var_01[var_01.size] = var_05;
				}
			}
		}
	}

	return var_01;
}

//Function Number: 39
find_breach_timer_index(param_00)
{
	for(var_01 = 0;var_01 < level.breachtimers.size;var_01++)
	{
		if(level.breachtimers[var_01].zonename == param_00)
		{
			return var_01;
		}
	}

	return -1;
}

//Function Number: 40
add_breach_timer(param_00)
{
	var_01 = spawnstruct();
	var_01.zonename = param_00;
	var_01.endtime = gettime() + get_breach_time();
	var_01.status = 0;
	level.breachtimers[level.breachtimers.size] = var_01;
	update_breach_timer_omnvars();
	level thread maps\mp\gametypes\zombies::setendtimeomnvarwithhostmigration("ui_zm_bomb",var_01.endtime);
}

//Function Number: 41
get_breach_time()
{
	var_00 = 60000;
	var_01 = 5000;
	if(level.wavecounter >= 30)
	{
		var_00 = 20000;
		var_01 = 3333;
	}
	else if(level.wavecounter >= 20)
	{
		var_00 = 25000;
		var_01 = 3333;
	}
	else if(level.wavecounter >= 10)
	{
		var_00 = 45000;
		var_01 = 5000;
	}

	var_02 = 4 - maps\mp\zombies\_util::getnumplayers();
	return var_00 + var_02 * var_01;
}

//Function Number: 42
contaminate_breach_timer(param_00)
{
	var_01 = find_breach_timer_index(param_00);
	if(var_01 == -1)
	{
		var_01 = level.breachtimers.size;
		var_02 = spawnstruct();
		var_02.zonename = param_00;
		var_02.endtime = gettime() + get_breach_time();
		var_02.status = 1;
		level.breachtimers[level.breachtimers.size] = var_02;
	}

	level.breachtimers[var_01].status = 1;
	update_breach_timer_omnvars();
	setomnvar("ui_zm_bomb",0);
	level notify("ui_zm_bomb_cancel");
}

//Function Number: 43
remove_breach_timer(param_00)
{
	var_01 = find_breach_timer_index(param_00);
	if(var_01 == -1)
	{
		return;
	}

	level.breachtimers = maps\mp\zombies\_util::array_remove_index(level.breachtimers,var_01);
	update_breach_timer_omnvars();
	setomnvar("ui_zm_bomb",0);
	level notify("ui_zm_bomb_cancel");
}

//Function Number: 44
update_breach_timer_omnvars()
{
	var_00 = [0,0,0];
	var_01 = 0;
	var_02 = 1;
	for(var_03 = 0;var_03 < level.breachtimers.size;var_03++)
	{
		var_04 = level.breachtimers[var_03].zonename;
		var_05 = level.breachzones[var_04].omnvarid;
		var_00[var_03] = level.breachtimers[var_03].endtime;
		var_01 = var_01 + var_05 * var_02;
		var_02 = var_02 * 10;
		if(level.breachtimers[var_03].status > 0)
		{
			var_01 = var_01 + var_02;
		}

		var_02 = var_02 * 10;
	}

	setomnvar("ui_zm_zone_timer_1",var_00[0]);
	setomnvar("ui_zm_zone_timer_2",var_00[1]);
	setomnvar("ui_zm_zone_timer_3",var_00[2]);
	setomnvar("ui_zm_zone_identifier",var_01);
}

//Function Number: 45
do_breach(param_00,param_01)
{
	level notify("do_breach");
	level endon("do_breach");
	var_02 = [];
	var_03 = getarraykeys(level.breachzones);
	if(isdefined(param_01))
	{
		var_03 = getarraykeys(level.zone_data.zones[param_01].adjacent_zones);
	}

	var_04 = 0;
	var_05 = get_contaminated_zones();
	foreach(var_07 in var_05)
	{
		if(maps\mp\zombies\_util::is_true(level.breachzones[var_07].hascurestation))
		{
			var_04++;
		}
	}

	foreach(var_0A in var_03)
	{
		if(!isdefined(level.breachzones[var_0A]))
		{
			continue;
		}

		if(level.breachzones[var_0A].status != 0)
		{
			continue;
		}

		if(gettime() - level.breachzones[var_0A].lastfixtime < 30000)
		{
			continue;
		}

		if(!maps\mp\zombies\_zombies_zone_manager::iszoneenabled(var_0A))
		{
			continue;
		}

		if(var_04 > 0 && maps\mp\zombies\_util::is_true(level.breachzones[var_0A].hascurestation))
		{
			continue;
		}

		var_02[var_02.size] = var_0A;
	}

	if(var_02.size > 0)
	{
		var_0C = var_02[randomint(var_02.size)];
		breach_zone(var_0C,param_00);
		return 1;
	}

	return 0;
}

//Function Number: 46
get_breach_min_wave()
{
	var_00 = 6;
	if(maps\mp\zombies\_util::getnumplayers() <= 1)
	{
		var_00 = var_00 + 2;
	}

	return var_00;
}

//Function Number: 47
get_breach_max_wave()
{
	var_00 = 20;
	if(maps\mp\zombies\_util::getnumplayers() <= 1)
	{
		var_00 = var_00 + 2;
	}

	return var_00;
}

//Function Number: 48
some_player_has_exo_suit()
{
	foreach(var_01 in level.players)
	{
		if(isalive(var_01) && maps\mp\zombies\_util::is_true(var_01.exosuitonline))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 49
run_breach_logic()
{
	level.prevbreachwave = 0;
	childthread handle_round_end_breach_logic();
	for(;;)
	{
		level waittill("zombie_wave_started");
		if(level.wavecounter >= get_breach_min_wave())
		{
			if(!some_player_has_exo_suit())
			{
				if(level.wavecounter < get_breach_min_wave() + 2)
				{
					continue;
				}
			}

			break;
		}
	}

	var_00 = randomfloatrange(15,30);
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_00);
	while(maps\mp\zombies\_util::iszombiegamepaused())
	{
		wait 0.05;
	}

	for(;;)
	{
		while(!can_do_breach())
		{
			wait(60);
		}

		level thread do_breach();
		level.prevbreachwave = level.wavecounter;
		var_01 = undefined;
		var_02 = undefined;
		if(level.wavecounter >= get_breach_max_wave())
		{
			var_01 = 270;
			var_02 = 30;
		}
		else if(level.wavecounter <= get_breach_min_wave())
		{
			var_01 = 360;
			var_02 = 60;
		}
		else
		{
			var_03 = level.wavecounter - get_breach_min_wave() / get_breach_max_wave() - get_breach_min_wave();
			var_01 = maps\mp\zombies\_util::lerp(var_03,360,270);
			var_02 = maps\mp\zombies\_util::lerp(var_03,60,30);
		}

		var_04 = randomfloatrange(var_01 - var_02,var_01 + var_02);
		maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_04);
		while(maps\mp\zombies\_util::iszombiegamepaused())
		{
			wait 0.05;
		}
	}
}

//Function Number: 50
can_do_breach()
{
	if(level.roundtype == "zombie_host")
	{
		return 0;
	}

	if(maps\mp\agents\_agent_utility::getactiveagentsoftype("zombie_melee_goliath").size > 0)
	{
		return 0;
	}

	var_00 = get_breached_zones();
	if(var_00.size != 0)
	{
		return 0;
	}

	var_01 = get_contaminated_zones();
	if(var_01.size >= 3)
	{
		return 0;
	}

	var_02 = level.totalaispawned / level.totaldesiredai;
	if(var_02 >= 0.8)
	{
		return 0;
	}

	return 1;
}

//Function Number: 51
handle_round_end_breach_logic()
{
	for(;;)
	{
		level waittill("zombie_wave_ended");
		waittillframeend;
		var_00 = get_contaminated_zones();
		if(var_00.size > 0)
		{
			var_01 = get_breached_zones();
			if(var_01.size == 0)
			{
				foreach(var_03 in var_00)
				{
					clean_zone(var_03);
				}

				if(var_00.size >= 3)
				{
					maps\mp\gametypes\zombies::showteamsplashzombies("zombie_vent_goliath");
					maps\mp\zombies\zombie_melee_goliath::spawnenhancedgoliath();
					level thread handle_round_transition_vo(1);
				}
				else
				{
					maps\mp\gametypes\zombies::showteamsplashzombies("zombie_vent_gas");
					level thread handle_round_transition_vo(0);
				}
			}
		}
	}
}

//Function Number: 52
handle_round_transition_vo(param_00)
{
	var_01 = "exp_round";
	if(param_00)
	{
		var_01 = var_01 + "_gol";
	}

	wait(1.5);
	maps\mp\zombies\_zombies_audio_announcer::waittillannouncerdonespeaking();
	maps\mp\zombies\_zombies_audio_announcer::announcerglobaldialog("global_priority",var_01,undefined,undefined,undefined,undefined,level.players);
	maps\mp\zombies\_zombies_audio_announcer::waittillannouncerdonespeaking();
	if(param_00)
	{
		foreach(var_03 in level.players)
		{
			var_03 playlocalsound("zmb_gol_round_start_front");
		}

		wait(2);
	}

	level notify("area_invalidation_vo_complete");
}

//Function Number: 53
is_next_round_transition_venting()
{
	var_00 = get_breached_zones();
	var_01 = get_contaminated_zones();
	return var_00.size == 0 && var_01.size > 0;
}

//Function Number: 54
is_next_round_zombie_goliath_round()
{
	var_00 = get_breached_zones();
	var_01 = get_contaminated_zones();
	return var_00.size == 0 && var_01.size >= 3;
}

//Function Number: 55
get_contaminated_zones()
{
	var_00 = [];
	foreach(var_03, var_02 in level.breachzones)
	{
		if(var_02.status == 2)
		{
			var_00[var_00.size] = var_03;
		}
	}

	return var_00;
}

//Function Number: 56
get_breached_zones()
{
	var_00 = [];
	foreach(var_03, var_02 in level.breachzones)
	{
		if(var_02.status == 1)
		{
			var_00[var_00.size] = var_03;
		}
	}

	return var_00;
}

//Function Number: 57
zone_is_breached(param_00)
{
	return level.breachzones[param_00].status == 1;
}

//Function Number: 58
zone_is_contaminated(param_00)
{
	if(!isdefined(level.breachzones) || !isdefined(level.breachzones[param_00]))
	{
		return 0;
	}

	return level.breachzones[param_00].status == 2;
}

//Function Number: 59
soldierhandlevo()
{
	self endon("death");
	wait(1);
	if(!isdefined(level.atlasdebouncevo))
	{
		return;
	}

	thread soldierdochatter();
	thread soldierdogoliathvo();
}

//Function Number: 60
soldierdogoliathvo()
{
	var_00 = 250000;
	if(!isdefined(self.agent_type) || !issubstr(self.agent_type,"goliath"))
	{
		return;
	}

	for(;;)
	{
		foreach(var_02 in level.players)
		{
			var_03 = distancesquared(self.origin,var_02.origin);
			if(var_03 <= var_00 && soldierplayvo("goliath"))
			{
				return;
			}
		}

		wait(1);
	}
}

//Function Number: 61
soldierdochatter()
{
	self endon("death");
	self endon("fail_gas");
	var_00 = 250000;
	for(;;)
	{
		foreach(var_02 in level.players)
		{
			var_03 = distancesquared(self.origin,var_02.origin);
			if(var_03 <= var_00)
			{
				if(soldierplayvo("chatter"))
				{
					wait(10);
				}
			}
		}

		wait(1);
	}
}

//Function Number: 62
soldierplayvo(param_00)
{
	if(!isdefined(self.zmbvoxid))
	{
		self.zmbvoxid = "atlas";
	}

	if(!isdefined(level.atlasdebouncevo))
	{
		return 0;
	}

	if(isdefined(level.atlasdebouncevo[param_00]) && level.atlasdebouncevo[param_00] > gettime())
	{
		return 0;
	}

	if(maps\mp\zombies\_zombies_audio::create_and_play_dialog("general",param_00))
	{
		if(isdefined(level.atlasdebouncevo[param_00]))
		{
			level.atlasdebouncevo[param_00] = gettime() + 30000;
		}

		return 1;
	}

	return 0;
}

//Function Number: 63
dobreachclearedvo(param_00)
{
	maps\mp\zombies\_zombies_audio_announcer::announcerglobaldialogdelay("global_priority","exp_win",2,undefined,undefined,undefined,undefined,level.players);
	if(!maps\mp\zombies\_util::is_true(level.zmbaudioplayedatlasconv))
	{
		level.zmbaudioplayedatlasconv = 0;
		maps\mp\zombies\_zombies_audio_announcer::waittillallannouncersdonespeaking();
		wait(0.5);
		var_01 = get_soldiers_breaching_zone(param_00);
		if(var_01.size == 0)
		{
			var_02 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("pilot");
			if(isdefined(var_02))
			{
				var_03 = var_02 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","atlas_conv");
				if(var_03)
				{
					level.zmbaudioplayedatlasconv = 1;
					var_02 common_scripts\utility::waittill_notify_or_timeout("done_speaking",8);
				}
			}

			var_04 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("guard");
			if(isdefined(var_04))
			{
				var_03 = var_04 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","atlas_conv");
				if(var_03)
				{
					level.zmbaudioplayedatlasconv = 1;
					var_04 common_scripts\utility::waittill_notify_or_timeout("done_speaking",8);
				}
			}

			var_05 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("exec");
			if(isdefined(var_05))
			{
				var_03 = var_05 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","atlas_conv");
				if(var_03)
				{
					level.zmbaudioplayedatlasconv = 1;
					var_05 common_scripts\utility::waittill_notify_or_timeout("done_speaking",8);
				}
			}

			var_06 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("it");
			if(isdefined(var_06))
			{
				var_03 = var_06 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","atlas_conv");
				if(var_03)
				{
					level.zmbaudioplayedatlasconv = 1;
					var_06 common_scripts\utility::waittill_notify_or_timeout("done_speaking",8);
					return;
				}

				return;
			}
		}
	}
}