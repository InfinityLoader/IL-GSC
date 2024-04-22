/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\traps\_trap_water_floor.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 124 ms
 * Timestamp: 4/22/2024 2:13:21 AM
*******************************************************************/

//Function Number: 1
init()
{
	thread maps\mp\zombies\_traps::trap_setup_custom_function("water_floor_trap","active",::begintrap);
	thread maps\mp\zombies\_traps::trap_setup_custom_hints("water_floor_trap",&"ZOMBIES_TRAP_READY",&"ZOMBIES_TRAP_COOLDOWN");
}

//Function Number: 2
begintrap(param_00)
{
	param_00 thread trapwaterfloorlogic();
	return 1;
}

//Function Number: 3
trapwaterfloorlogic()
{
	self notify("trapWaterFloorLogic");
	self endon("trapWaterFloorLogic");
	self endon("cooldown");
	activateclientexploder(57);
	thread trapwaterfloorcleanup();
	var_00 = trapgetwatervolume();
	var_01 = 0;
	for(;;)
	{
		if(var_01 >= 2)
		{
			wait 0.05;
			var_01 = 0;
			continue;
		}

		var_02 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
		foreach(var_04 in var_02)
		{
			if(var_04.team != level.enemyteam)
			{
				continue;
			}

			if(isdefined(var_04.watertrapcooldown) && gettime() < var_04.watertrapcooldown)
			{
				continue;
			}

			if(!isalive(var_04))
			{
				continue;
			}

			if(maps\mp\zombies\_util::is_true(var_04.inpain) || maps\mp\zombies\_util::is_true(var_04.flungbywatertrap))
			{
				continue;
			}

			if(isdefined(var_04.birthtime) && var_04.birthtime == gettime())
			{
				continue;
			}

			if(var_04 maps\mp\zombies\_util::istrapresistant())
			{
				continue;
			}

			if(ispointinvolume(var_04.origin,var_00))
			{
				thread trapwaterlaunch(var_04,var_04.origin);
				var_01++;
				if(var_01 >= 2)
				{
					break;
				}
			}
		}

		if(var_01 >= 2)
		{
			wait 0.05;
			var_01 = 0;
			continue;
		}

		foreach(var_07 in level.players)
		{
			if(!isalive(var_07) || maps\mp\zombies\_util::isplayerinlaststand(var_07))
			{
				continue;
			}

			if(isdefined(var_07.watertrapcooldown) && gettime() < var_07.watertrapcooldown)
			{
				continue;
			}

			if(ispointinvolume(var_07.origin,var_00))
			{
				thread trapwaterlaunch(var_07,var_07.origin);
				if(var_01 >= 2)
				{
					break;
				}
			}
		}

		wait 0.05;
	}
}

//Function Number: 4
trapwaterfloorcleanup()
{
	self endon("trapWaterFloorLogic");
	self waittill("cooldown");
	stopclientexploder(57);
	foreach(var_01 in level.players)
	{
		var_01.watertrapcooldown = undefined;
	}
}

//Function Number: 5
trapwaterlaunch(param_00,param_01)
{
	playfx(common_scripts\utility::getfx("water_trap_jet"),param_01);
	playsoundatpos(param_01,"steam_burst_trap");
	var_02 = param_00 getvelocity();
	var_03 = param_00.origin;
	if(isplayer(param_00))
	{
		var_04 = (var_02[0],var_02[1],700);
		param_00 setvelocity(var_04);
		earthquake(0.4,1,var_03,500,param_00);
		param_00.watertrapcooldown = gettime() + 3000;
		return;
	}

	if(param_00.agent_type == "zombie_generic")
	{
		playsoundatpos(param_00.origin,"zmb_gen_steam_burst_death");
	}

	param_00.watervelocity = (var_02[0],var_02[1],800);
	var_05 = level.wavecounter * randomintrange(100,120);
	param_00 dodamage(var_05,var_03 + (0,0,-1),self.owner,undefined,"MOD_EXPLOSIVE","zombie_water_trap_mp");
	if(isalive(param_00) && isscriptedagent(param_00) && !param_00 maps\mp\agents\_scripted_agent_anim_util::isstatelocked() && !param_00 maps\mp\agents\humanoid\_humanoid_util::iscrawling() && isdefined(param_00.agent_type) && param_00.agent_type != "zombie_dog" && param_00.agent_type != "ranged_elite_soldier" && param_00.agent_type != "ranged_elite_soldier_goliath")
	{
		level thread trapflingzombie(param_00);
	}
	else
	{
		param_00.watertrapcooldown = gettime() + 3000;
	}

	wait(0.1);
	physicsexplosionsphere(var_03,60,0,10,0);
}

//Function Number: 6
trapflingzombie(param_00)
{
	param_00 endon("death");
	param_00.flungbywatertrap = 1;
	param_00 scragentsetanimmode("anim deltas");
	param_00 scragentsetanimscale(1,1);
	param_00 scragentsetphysicsmode("no_gravity");
	param_00 scragentsetorientmode("face angle abs",param_00.angles);
	var_01 = "water_trap_victim";
	var_02 = param_00 getanimentrycount(var_01);
	var_03 = randomint(4);
	param_00 scragentsetscripted(1);
	param_00 maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1,"WaterTrapAnim");
	param_00 maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_01,var_03,1,"scripted_anim");
	param_00 scragentsetphysicsmode("gravity");
	param_00 scragentsetscripted(0);
	param_00 maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0,"WaterTrapAnim");
	param_00.flungbywatertrap = undefined;
}

//Function Number: 7
trapgetwatervolume()
{
	var_00 = getentarray(self.target,"targetname");
	var_01 = common_scripts\utility::getstructarray(self.target,"targetname");
	var_02 = common_scripts\utility::array_combine(var_00,var_01);
	foreach(var_04 in var_02)
	{
		if(!isdefined(var_04.script_noteworthy))
		{
			continue;
		}

		if(var_04.script_noteworthy == "floor")
		{
			return var_04;
		}
	}
}