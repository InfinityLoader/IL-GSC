/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\killstreaks\streak_mp_comeback.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 218 ms
 * Timestamp: 4/22/2024 2:12:29 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.killstreakwieldweapons["killstreak_comeback_mp"] = "mp_comeback";
	level.killstreakfuncs["mp_comeback"] = ::tryusekillstreak;
	level.mapkillstreak = "mp_comeback";
	level.mapkillstreakpickupstring = &"MP_COMEBACK_MAP_KILLSTREAK_PICKUP";
	level.mapcustombotkillstreakfunc = ::setupbotsformapkillstreak;
	level.killstreak_tank_groups = [];
	level.killstreak_tanks = getentarray("walker_tank","targetname");
	common_scripts\utility::array_thread(level.killstreak_tanks,::init_tank);
	level.killstreak_tank_groups = common_scripts\utility::array_randomize(level.killstreak_tank_groups);
	level.sky_nodes = [];
	var_00 = getallnodes();
	foreach(var_02 in var_00)
	{
		if(nodeexposedtosky(var_02,1))
		{
			level.sky_nodes[level.sky_nodes.size] = var_02;
		}
	}

	level.missile_start_offset = 20;
	precachempanim("mp_comeback_spider_tank_idle");
	precachempanim("mp_comeback_spider_tank_fire");
}

//Function Number: 2
setupbotsformapkillstreak()
{
	level thread maps\mp\bots\_bots_ks::bot_register_killstreak_func("mp_comeback",::maps\mp\bots\_bots_ks::bot_killstreak_simple_use);
}

//Function Number: 3
tryusekillstreak(param_00,param_01)
{
	var_02 = undefined;
	foreach(var_04 in level.killstreak_tank_groups)
	{
		var_05 = !isdefined(var_02) || var_04.last_run_time < var_02.last_run_time;
		if(!var_04.active && var_05)
		{
			var_02 = var_04;
		}
	}

	if(!isdefined(var_02))
	{
		iprintlnbold(&"MP_COMEBACK_MAP_KILLSTREAK_NOT_AVAILABLE");
		return 0;
	}

	var_02 thread group_run(self);
	return 1;
}

//Function Number: 4
init_tank()
{
	self.start_origin = self.origin;
	self.start_angles = self.angles;
	self.objids = [];
	var_00 = ["allies","axis"];
	foreach(var_02 in var_00)
	{
		self.objids[var_02] = maps\mp\gametypes\_gameobjects::getnextobjid();
		objective_add(self.objids[var_02],"invisible",(0,0,0));
		objective_icon(self.objids[var_02],common_scripts\utility::ter_op(var_02 == "allies","compass_objpoint_tank_friendly","compass_objpoint_tank_enemy"));
	}

	self.group = self.script_noteworthy;
	if(!isdefined(self.group))
	{
		self.group = "default";
	}

	if(!isdefined(level.killstreak_tank_groups[self.group]))
	{
		level.killstreak_tank_groups[self.group] = init_new_tank_group();
	}

	var_04 = level.killstreak_tank_groups[self.group].tanks.size;
	level.killstreak_tank_groups[self.group].tanks[var_04] = self;
	tank_idle(self);
}

//Function Number: 5
init_new_tank_group()
{
	var_00 = spawnstruct();
	var_00.active = 0;
	var_00.tanks = [];
	var_00.last_run_time = 0;
	return var_00;
}

//Function Number: 6
group_run(param_00)
{
	self.active = 1;
	self.owner_team = param_00.team;
	self.owner = param_00;
	self.last_run_time = gettime();
	self.tank_count = self.tanks.size;
	foreach(var_02 in self.tanks)
	{
		thread tank_run(var_02);
	}

	self waittill("all_tanks_done");
	self.active = 0;
}

//Function Number: 7
tank_run(param_00,param_01)
{
	tank_show_icon(param_00);
	tank_attack(param_00);
	tank_idle(param_00);
	tank_end(param_00);
}

//Function Number: 8
tank_show_icon(param_00)
{
	foreach(var_03, var_02 in param_00.objids)
	{
		objective_state(var_02,"active");
		if(var_03 == "allies")
		{
			objective_playerteam(var_02,self.owner getentitynumber());
		}
		else
		{
			objective_playerenemyteam(var_02,self.owner getentitynumber());
		}

		objective_onentitywithrotation(var_02,param_00);
	}
}

//Function Number: 9
tank_hide_icon(param_00)
{
	foreach(var_02 in param_00.objids)
	{
		objective_state(var_02,"invisible");
	}
}

//Function Number: 10
tank_idle(param_00)
{
	param_00 scriptmodelplayanimdeltamotion("mp_comeback_spider_tank_idle");
}

//Function Number: 11
tank_attack(param_00)
{
	self.owner endon("disconnect");
	param_00 endon("tank_destroyed");
	param_00 playsound("walker_start");
	param_00 scriptmodelplayanimdeltamotion("mp_comeback_spider_tank_fire","comeback_tank");
	var_01 = 0;
	var_02 = 0;
	for(;;)
	{
		param_00 waittill("comeback_tank",var_03);
		switch(var_03)
		{
			case "fire_right":
				var_01++;
				var_04 = "tag_missile_" + var_01 + "_r";
				tank_fire_missile(param_00,var_04);
				break;
	
			case "fire_left":
				var_02++;
				var_04 = "tag_missile_" + var_02 + "_l";
				tank_fire_missile(param_00,var_04);
				break;
	
			case "end":
				break;
		}
	}
}

//Function Number: 12
tank_fire_missile(param_00,param_01)
{
	var_02 = param_00 gettagorigin(param_01);
	var_03 = param_00 gettagangles(param_01);
	var_04 = anglestoforward(var_03);
	var_05 = var_02 + var_04 * level.missile_start_offset;
	var_06 = var_05 + var_04;
	var_07 = magicbullet("killstreak_comeback_mp",var_05,var_06,self.owner);
	thread tank_missile_set_target(var_07);
}

//Function Number: 13
tank_missile_set_target(param_00)
{
	param_00 endon("death");
	wait(randomfloatrange(0.2,0.4));
	var_01 = undefined;
	var_02 = randomfloatrange(0.5,1);
	var_03 = gettime() + var_02 * 1000;
	var_04 = maps\mp\_utility::getotherteam(self.owner_team);
	while(gettime() < var_03 && !isdefined(var_01))
	{
		var_05 = common_scripts\utility::array_randomize(level.players);
		foreach(var_07 in var_05)
		{
			if(var_07.team != var_04)
			{
				continue;
			}

			if(!maps\mp\_utility::isreallyalive(var_07))
			{
				continue;
			}

			if(isdefined(var_07.tank_no_target_time) && var_07.tank_no_target_time > gettime())
			{
				continue;
			}

			if(isdefined(var_07.spawntime) && var_07.spawntime + 3000 > gettime())
			{
				continue;
			}

			if(sighttracepassed(param_00.origin,var_07.origin + (0,0,40),0,param_00,var_07,0))
			{
				var_01 = var_07;
				break;
			}
		}

		wait(0.05);
	}

	if(isdefined(var_01))
	{
		var_01.tank_no_target_time = gettime() + 3000;
		param_00 missile_settargetent(var_01);
		return;
	}

	var_09 = 250;
	var_0A = var_09 * var_09;
	var_0B = common_scripts\utility::random(level.sky_nodes);
	if(isdefined(self.owner))
	{
		for(var_0C = 0;var_0C < 10 && distancesquared(var_0B.origin,self.owner.origin) < var_0A;var_0C++)
		{
			var_0B = common_scripts\utility::random(level.sky_nodes);
		}
	}

	param_00 missile_settargetpos(var_0B.origin);
}

//Function Number: 14
tank_end(param_00)
{
	tank_hide_icon(param_00);
	self.tank_count--;
	if(self.tank_count == 0)
	{
		self notify("all_tanks_done");
	}
}