/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_nuke.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 29
 * Decompile Time: 498 ms
 * Timestamp: 10/27/2023 1:21:17 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.nukevisionset = "aftermath_post";
	level._effect["nuke_player"] = loadfx("fx/explosions/player_death_nuke");
	level._effect["nuke_flash"] = loadfx("fx/explosions/player_death_nuke_flash");
	level._effect["nuke_aftermath"] = loadfx("fx/dust/nuke_aftermath_mp");
	level.killstreakfuncs["nuke"] = ::func_8442;
	setdvarifuninitialized("scr_nukeTimer",10);
	setdvarifuninitialized("scr_nukeCancelMode",0);
	level.nuketimer = getdvarint("scr_nukeTimer");
	level.cancelmode = getdvarint("scr_nukeCancelMode");
	if(level.multiteambased)
	{
		for(var_00 = 0;var_00 < level.teamnamelist.size;var_00++)
		{
			level.teamnukeemped[level.teamnamelist[var_00]] = 0;
		}
	}
	else
	{
		level.teamnukeemped["allies"] = 0;
		level.teamnukeemped["axis"] = 0;
	}

	level.nukeemptimeout = 60;
	level.nukeemptimeremaining = int(level.nukeemptimeout);
	level.nukeinfo = spawnstruct();
	level.nukeinfo.xpscalar = 2;
	level.nukedetonated = undefined;
	level thread func_595D();
}

//Function Number: 2
func_8442(param_00,param_01,param_02)
{
	if(isdefined(level.nukeincoming))
	{
		self iprintlnbold(&"KILLSTREAKS_NUKE_ALREADY_INBOUND");
		return 0;
	}

	if(maps\mp\_utility::func_4995() && !isdefined(level.gtnw) || !level.gtnw)
	{
		return 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	thread func_29B6(param_02);
	self notify("used_nuke");
	maps\mp\_matchdata::func_4F1D("nuke",self.origin);
	return 1;
}

//Function Number: 3
delaythread_nuke(param_00,param_01)
{
	level endon("nuke_cancelled");
	maps\mp\gametypes\_hostmigration::func_8B0D(param_00);
	thread [[ param_01 ]]();
}

//Function Number: 4
func_29B6(param_00)
{
	level endon("nuke_cancelled");
	level.nukeinfo.player = self;
	level.nukeinfo.team = self.pers["team"];
	level.nukeincoming = 1;
	level.prevuibombtimer = int(getomnvar("ui_bomb_timer"));
	setomnvar("ui_bomb_timer",4);
	if(level.teambased)
	{
		thread maps\mp\_utility::func_7FA0("used_nuke",self,self.team);
	}
	else if(!level.hardcoremode)
	{
		self iprintlnbold(&"KILLSTREAKS_FRIENDLY_TACTICAL_NUKE");
	}

	if(!isdefined(level.donuke_fx) || ![[ level.donuke_fx ]]())
	{
		if(!isdefined(level.nuke_soundobject))
		{
			level.nuke_soundobject = spawn("script_origin",(0,0,1));
			level.nuke_soundobject hide();
		}

		level thread delaythread_nuke(level.nuketimer - 3.3,::func_5767);
		level thread delaythread_nuke(level.nuketimer,::func_5766);
		level thread delaythread_nuke(level.nuketimer,::nukeslowmo);
		level thread delaythread_nuke(level.nuketimer,::func_575D);
		level thread delaythread_nuke(level.nuketimer + 0.25,::func_5769);
		level thread delaythread_nuke(level.nuketimer + 1.5,::func_5758);
		level thread delaythread_nuke(level.nuketimer + 1.5,::func_575B);
		level thread func_5751();
		if(level.cancelmode && param_00)
		{
			level thread cancelnukeondeath(self);
		}
	}

	level thread func_86BA();
	if(!isdefined(level.nuke_clockobject))
	{
		level.nuke_clockobject = spawn("script_origin",(0,0,0));
		level.nuke_clockobject hide();
	}

	for(var_01 = level.nuketimer;var_01 > 0;var_01--)
	{
		level.nuke_clockobject playsound("ui_mp_kem_timer");
		wait(1);
	}
}

//Function Number: 5
donukesimple()
{
	level.nukeinfo.player = self;
	level.nukeinfo.team = self.pers["team"];
	level.nukeincoming = 1;
	level thread delaythread_nuke(level.nuketimer - 3.3,::func_5767);
	level thread delaythread_nuke(level.nuketimer,::func_5766);
	level thread delaythread_nuke(level.nuketimer,::nukeslowmo);
	level thread delaythread_nuke(level.nuketimer,::func_575D);
	level thread delaythread_nuke(level.nuketimer + 0.25,::func_5769);
	level thread delaythread_nuke(level.nuketimer + 1.5,::nukedeathsimple);
	level thread delaythread_nuke(level.nuketimer + 1.5,::func_575B);
	if(!isdefined(level.nuke_soundobject))
	{
		level.nuke_soundobject = spawn("script_origin",(0,0,1));
		level.nuke_soundobject hide();
	}
}

//Function Number: 6
nukedeathsimple()
{
	level notify("nuke_death");
}

//Function Number: 7
cancelnukeondeath(param_00)
{
	param_00 common_scripts\utility::func_8B2A("death","disconnect");
	if(isdefined(param_00) && level.cancelmode == 2)
	{
		param_00 thread maps\mp\killstreaks\_emp::emp_use(0,0);
	}

	func_5755();
	level.nukeincoming = undefined;
	level notify("nuke_cancelled");
}

//Function Number: 8
func_5767()
{
	level endon("nuke_cancelled");
	if(isdefined(level.nuke_soundobject))
	{
		level.nuke_soundobject playsound("nuke_incoming");
	}
}

//Function Number: 9
func_5766()
{
	level endon("nuke_cancelled");
	if(isdefined(level.nuke_soundobject))
	{
		level.nuke_soundobject playsound("nuke_explosion");
		level.nuke_soundobject playsound("nuke_wave");
	}
}

//Function Number: 10
func_5755()
{
	var_00 = 0;
	if(isdefined(level.prevuibombtimer))
	{
		var_00 = level.prevuibombtimer;
	}

	setomnvar("ui_bomb_timer",var_00);
}

//Function Number: 11
func_575D()
{
	level endon("nuke_cancelled");
	func_5755();
	level.nukedetonated = 1;
	foreach(var_01 in level.players)
	{
		level thread func_575C(var_01);
	}
}

//Function Number: 12
func_575C(param_00)
{
	level endon("nuke_cancelled");
	param_00 endon("disconnect");
	common_scripts\utility::func_8AFE();
	var_01 = undefined;
	var_02 = undefined;
	if(!isdefined(level.nukeloc))
	{
		var_03 = (0,param_00.angles[1],0);
		var_02 = anglestoforward(var_03);
		var_04 = 5000;
		var_01 = param_00.origin + var_02 * var_04;
	}
	else
	{
		var_01 = level.nukeloc;
	}

	var_05 = undefined;
	var_06 = (0,0,1);
	if(!isdefined(level.nukeangles))
	{
		var_05 = anglestoright((0,param_00.angles[1] + 180,0));
	}
	else
	{
		var_05 = anglestoforward(level.nukeangles);
		var_06 = anglestoup(level.nukeangles);
	}

	var_07 = spawnfxforclient(level._effect["nuke_flash"],var_01,param_00,var_06,var_05);
	triggerfx(var_07);
	param_00 thread cleanupnukeeffect(var_07,30);
}

//Function Number: 13
cleanupnukeeffect(param_00,param_01)
{
	maps\mp\_utility::waitfortimeornotify(param_01,"disconnect");
	param_00 delete();
}

//Function Number: 14
func_5751()
{
	level endon("nuke_cancelled");
	level waittill("spawning_intermission");
	var_00 = getentarray("mp_global_intermission","classname");
	var_00 = var_00[0];
	var_01 = anglestoup(var_00.angles);
	var_02 = anglestoright(var_00.angles);
	playfx(level._effect["nuke_aftermath"],var_00.origin,var_01,var_02);
}

//Function Number: 15
nukeslowmo()
{
	level endon("nuke_cancelled");
	setslowmotion(1,0.25,0.5);
	level waittill("nuke_death");
	setslowmotion(0.25,1,2);
}

//Function Number: 16
func_5769()
{
	level endon("nuke_cancelled");
	level.nukevisioninprogress = 1;
	visionsetpostapply("mpnuke",3);
	maps\mp\gametypes\_hostmigration::func_8B0D(2);
	visionsetpostapply("nuke_global_flash",0.1);
	setexpfog(0,956,0.72,0.61,0.39,0.968,0.85,1,0.298,0.273,0.266,0.25,(0,0,-1),84,118,2.75,0.984,124,100);
	setdvar("r_materialBloomHQScriptMasterEnable",0);
	maps\mp\gametypes\_hostmigration::func_8B0D(0.5);
	level notify("nuke_aftermath_post_started");
	visionsetpostapply("aftermath_post",0.5);
	level waittill("nuke_death");
	level thread func_9557();
	level func_9453(5);
}

//Function Number: 17
func_5758()
{
	level endon("nuke_cancelled");
	level endon("game_ended");
	level notify("nuke_death");
	maps\mp\gametypes\_hostmigration::func_8BBA();
	foreach(var_01 in level.characters)
	{
		if(nukecankill(var_01))
		{
			if(isplayer(var_01))
			{
				var_01.nuked = 1;
				if(maps\mp\_utility::func_4945(var_01))
				{
					var_01 thread maps\mp\gametypes\_damage::func_329F(level.nukeinfo.player,level.nukeinfo.player,999999,0,"MOD_EXPLOSIVE","nuke_mp",var_01.origin,(0,0,1),"none",0,0);
				}

				continue;
			}

			var_01 maps/mp/agents/_agents::agent_damage_finished(level.nukeinfo.player,level.nukeinfo.player,999999,0,"MOD_EXPLOSIVE","nuke_mp",var_01.origin,(0,0,1),"none",0);
		}
	}

	level thread nuke_empjam();
	level.nukeincoming = undefined;
}

//Function Number: 18
nukecankill(param_00)
{
	if(!isdefined(level.nukeinfo))
	{
		return 0;
	}

	if(level.teambased)
	{
		if(isdefined(level.nukeinfo.team) && param_00.team == level.nukeinfo.team)
		{
			return 0;
		}
	}
	else
	{
		var_01 = isdefined(level.nukeinfo.player) && param_00 == level.nukeinfo.player;
		var_02 = isdefined(level.nukeinfo.player) && isdefined(param_00.owner) && param_00.owner == level.nukeinfo.player;
		if(var_01 || var_02)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 19
func_575B()
{
	level endon("nuke_cancelled");
	level waittill("nuke_death");
}

//Function Number: 20
nuke_empjam()
{
	level endon("game_ended");
	if(level.teambased)
	{
		level func_575F(maps\mp\_utility::getotherteam(level.nukeinfo.team));
	}

	level.teamnukeemped[level.nukeinfo.team] = 1;
	level.teamnukeemped[maps\mp\_utility::getotherteam(level.nukeinfo.team)] = 1;
	func_575E(level.nukeinfo.player);
}

//Function Number: 21
func_575F(param_00)
{
	level endon("game_ended");
	level notify("nuke_EMPJam");
	level endon("nuke_EMPJam");
	level.teamnukeemped[param_00] = 1;
	foreach(var_02 in level.players)
	{
		if(var_02 lib_05FE::func_74B9())
		{
			var_02 lib_05FE::applyperplayerempeffects();
		}
	}

	level notify("nuke_emp_update");
	level maps\mp\killstreaks\_jammer::func_2654(level.nukeinfo.player,param_00);
	level maps\mp\killstreaks\_air_superiority::func_2640(level.nukeinfo.player,param_00);
	level thread keepnukeemptimeremaining();
	maps\mp\gametypes\_hostmigration::func_8B0D(level.nukeemptimeout);
	level.teamnukeemped[param_00] = 0;
	foreach(var_02 in level.players)
	{
		if(var_02.team == param_00 && !var_02 lib_05FE::func_74B9())
		{
			var_02 lib_05FE::func_65A7();
			var_02.nuked = undefined;
		}
	}

	level notify("nuke_emp_update");
	level notify("nuke_emp_ended");
}

//Function Number: 22
func_575E(param_00)
{
	level notify("nuke_EMPJam");
	level endon("nuke_EMPJam");
	if(!isdefined(param_00))
	{
	}

	foreach(var_02 in level.players)
	{
		if(var_02 lib_05FE::func_74B9())
		{
			var_02 lib_05FE::applyperplayerempeffects();
		}
	}

	level notify("nuke_emp_update");
	level maps\mp\killstreaks\_jammer::func_2654(level.nukeinfo.player);
	level maps\mp\killstreaks\_air_superiority::func_2640(level.nukeinfo.player);
	level thread keepnukeemptimeremaining();
	maps\mp\gametypes\_hostmigration::func_8B0D(level.nukeemptimeout);
	level.nukeinfo.player = undefined;
	foreach(var_02 in level.players)
	{
		if((!isdefined(param_00) || var_02 != param_00) && !var_02 lib_05FE::func_74B9())
		{
			var_02 lib_05FE::func_65A7();
		}
	}

	level notify("nuke_emp_update");
	level notify("nuke_emp_ended");
}

//Function Number: 23
keepnukeemptimeremaining()
{
	level notify("keepNukeEMPTimeRemaining");
	level endon("keepNukeEMPTimeRemaining");
	level endon("nuke_emp_ended");
	level.nukeemptimeremaining = int(level.nukeemptimeout);
	while(level.nukeemptimeremaining)
	{
		wait(1);
		level.nukeemptimeremaining--;
	}
}

//Function Number: 24
func_595D()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread onplayerspawned();
	}
}

//Function Number: 25
onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		if(isdefined(level.nukedetonated))
		{
			thread func_7213();
		}
	}
}

//Function Number: 26
func_7213()
{
	wait(0.1);
	self visionsetpostapplyforplayer(level.nukevisionset,0);
}

//Function Number: 27
func_86BA()
{
	level endon("game_ended");
	level endon("disconnect");
	level endon("nuke_cancelled");
	level endon("nuke_death");
	var_00 = level.nuketimer * 1000 + gettime();
	setomnvar("ui_nuke_end_milliseconds",var_00);
	level waittill("host_migration_begin");
	var_01 = maps\mp\gametypes\_hostmigration::func_8BBA();
	if(var_01 > 0)
	{
		setomnvar("ui_nuke_end_milliseconds",var_00 + var_01);
	}
}

//Function Number: 28
func_9557()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("host_migration_end");
		level func_9453(0);
	}
}

//Function Number: 29
func_9453(param_00)
{
	if(isdefined(level.nukedeathvisionfunc))
	{
		level thread [[ level.nukedeathvisionfunc ]]();
	}

	visionsetpostapply(level.nukevisionset,param_00);
}