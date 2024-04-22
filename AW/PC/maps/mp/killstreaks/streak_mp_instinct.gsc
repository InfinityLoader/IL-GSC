/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\killstreaks\streak_mp_instinct.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 226 ms
 * Timestamp: 4/22/2024 2:12:33 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.killstreakfuncs["mp_instinct"] = ::tryusempinstinct;
	level.mapkillstreak = "mp_instinct";
	level.instinctdogs = [];
	precachemodel("animal_iw6_dog_a");
	level.killstreakwieldweapons["killstreak_instinct_mp"] = "mp_instinct";
	level.instinctdogspawnpoints = [];
	var_00 = getnodearray("InstinctDogSpawnPoint","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = spawnstruct();
		var_03.spawnpoint = var_02;
		var_03.weight = 0;
		level.instinctdogspawnpoints = common_scripts\utility::add_to_array(level.instinctdogspawnpoints,var_03);
	}

	onplayerconnect();
}

//Function Number: 2
tryusempinstinct(param_00,param_01)
{
	return spawninstinctdogs();
}

//Function Number: 3
setmpinstinctplayer(param_00)
{
	level.mp_instinct_owner = param_00;
	thread maps\mp\_utility::teamplayercardsplash("used_mp_instinct",param_00);
	return 1;
}

//Function Number: 4
onplayerconnect()
{
	var_00 = 0;
	for(;;)
	{
		level waittill("connected",var_01);
		if(var_00 == 0)
		{
			if(!isdefined(level.ishorde) || !level.ishorde)
			{
				level.agent_funcs["dog"]["think"] = ::maps\mp\agents\dog\_instinct_dog_think::main;
				level.agent_funcs["dog"]["on_killed"] = ::on_agent_dog_killed;
			}
		}

		var_00++;
		var_01 thread onplayerspawned();
	}
}

//Function Number: 5
onplayerspawned()
{
	self endon("disconnect");
	self waittill("spawned_player");
	thread monitorkills();
}

//Function Number: 6
spawninstinctdogs()
{
	if(maps\mp\agents\_agent_utility::getnumactiveagents("dog") >= 3)
	{
		self iprintlnbold(&"KILLSTREAKS_TOO_MANY_DOGS");
		return 0;
	}

	if(maps\mp\agents\_agent_utility::getnumownedactiveagentsbytype(self,"dog") >= 3)
	{
		self iprintlnbold(&"KILLSTREAKS_ALREADY_HAVE_DOG");
		return 0;
	}

	if(maps\mp\agents\_agent_utility::getnumownedactiveagents(self) >= 3)
	{
		self iprintlnbold(&"KILLSTREAKS_AGENT_MAX");
		return 0;
	}

	var_00 = getmaxagents();
	if(maps\mp\agents\_agent_utility::getnumactiveagents() >= var_00)
	{
		self iprintlnbold(&"KILLSTREAKS_UNAVAILABLE");
		return 0;
	}

	if(!maps\mp\_utility::isreallyalive(self))
	{
		return 0;
	}

	connectandspawninstinctdogpack();
	return 1;
}

//Function Number: 7
sortinstinctdogspawnpoints()
{
	foreach(var_01 in level.instinctdogspawnpoints)
	{
		var_01.weight = 0;
		var_02 = distance(var_01.spawnpoint.origin,self.origin);
		if(var_02 < 1500)
		{
			var_01.weight = 1;
		}
		else if(var_02 > 1500 && var_02 < 2000)
		{
			var_01.weight = 2;
		}
		else if(var_02 > 2000 && var_02 < 2500)
		{
			var_01.weight = 3;
		}
		else if(var_02 > 2500)
		{
			var_01.weight = 4;
		}

		foreach(var_04 in level.players)
		{
			var_05 = var_01.spawnpoint.origin;
			var_06 = var_04.origin;
			var_07 = sighttracepassed(var_05,var_06,0,var_04);
			if(var_07)
			{
				var_01.weight--;
			}

			var_02 = distance(var_01.spawnpoint.origin,var_04.origin);
			if(var_02 < 256)
			{
				var_01.weight--;
			}
		}
	}

	level.instinctdogspawnpoints = common_scripts\utility::array_sort_with_func(level.instinctdogspawnpoints,::ispointascoredhigherthanb);
}

//Function Number: 8
pickinstinctdogspawnpoint()
{
	var_00 = level.instinctdogspawnpoints[0];
	level.instinctdogspawnpoints = common_scripts\utility::array_remove(level.instinctdogspawnpoints,level.instinctdogspawnpoints[0]);
	return var_00;
}

//Function Number: 9
ispointascoredhigherthanb(param_00,param_01)
{
	return param_00.weight > param_01.weight;
}

//Function Number: 10
waitfortimeout()
{
	common_scripts\utility::waittill_any_timeout(60,"KillCountMet");
	self notify("retreat");
	var_00 = getnodearray("DeletePoint","targetname");
	var_01 = common_scripts\utility::getclosest(self.origin,var_00);
	self notify("timeoutRetreat");
	self scragentsetgoalpos(var_01.origin);
	common_scripts\utility::waittill_any_timeout(20,"stop_soon");
	self suicide();
	self notify("death");
}

//Function Number: 11
connectandspawninstinctdogpack()
{
	sortinstinctdogspawnpoints();
	for(var_00 = 0;var_00 < 3;var_00++)
	{
		var_01 = pickinstinctdogspawnpoint();
		if(!isdefined(var_01))
		{
			return 0;
		}

		var_02 = maps\mp\agents\_agent_common::connectnewagent("dog",self.team);
		if(!isdefined(var_02))
		{
			return 0;
		}

		var_03 = self.health;
		var_04 = 25;
		self.agenthealth = var_04;
		self.health = var_04;
		self.maxhealth = var_04;
		level.instinctdogs = common_scripts\utility::array_add(level.instinctdogs,var_02);
		var_02 thread waitfordeath(var_01);
		var_02 maps\mp\agents\_agent_utility::set_agent_team(self.team,self);
		var_05 = var_01.spawnpoint.origin;
		var_06 = vectortoangles(self.origin - var_01.spawnpoint.origin);
		var_02 thread [[ var_02 maps\mp\agents\_agent_utility::agentfunc("spawn") ]](var_05,var_06,self);
		if(isdefined(self.balldrone) && self.balldrone.balldronetype == "ball_drone_backup")
		{
			maps\mp\gametypes\_missions::processchallenge("ch_twiceasdeadly");
		}

		var_02 thread waitfortimeout();
	}
}

//Function Number: 12
waitfordeath(param_00)
{
	common_scripts\utility::waittill_any("death","retreat");
	level.instinctdogspawnpoints = common_scripts\utility::array_add(level.instinctdogspawnpoints,param_00);
	level.instinctdogs = common_scripts\utility::array_remove(level.instinctdogs,self);
}

//Function Number: 13
monitorkills()
{
	for(;;)
	{
		self waittill("death",var_00);
		foreach(var_02 in level.instinctdogs)
		{
			if(var_00 == var_02)
			{
				if(!isdefined(var_02.enemykills))
				{
					var_02.enemykills = 0;
				}

				var_02.enemykills++;
				if(var_02.enemykills >= 2)
				{
					var_02 notify("KillCountMet");
				}
			}
		}
	}
}

//Function Number: 14
on_agent_dog_killed(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	self.isactive = 0;
	self.hasdied = 0;
	param_01.lastkilldogtime = gettime();
	if(isdefined(self.animcbs.onexit[self.aistate]))
	{
		self [[ self.animcbs.onexit[self.aistate] ]]();
	}

	if(isplayer(param_01) && isdefined(self.owner) && param_01 != self.owner)
	{
		self.owner maps\mp\_utility::leaderdialogonplayer("dog_kia_mp_instinct");
		maps\mp\gametypes\_damage::onkillstreakkilled(param_01,param_04,param_03,param_02,"destroyed_guard_dog");
		if(isplayer(param_01))
		{
			param_01 maps\mp\gametypes\_missions::processchallenge("ch_notsobestfriend");
			if(!self isonground())
			{
				param_01 maps\mp\gametypes\_missions::processchallenge("ch_hoopla");
			}
		}
	}

	self setanimstate("death");
	var_09 = self getanimentry();
	var_0A = getanimlength(var_09);
	param_08 = int(var_0A * 1000);
	self.body = self finishagentdamage(param_08);
	self playsound("anml_dog_shot_death");
	maps\mp\agents\_agent_utility::deactivateagent();
	self notify("killanimscript");
}