/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_spawner.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 202
 * Decompile Time: 3521 ms
 * Timestamp: 10/27/2023 1:25:15 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	precachemodel("grenade_bag");
	createthreatbiasgroup("allies");
	createthreatbiasgroup("axis");
	createthreatbiasgroup("team3");
	createthreatbiasgroup("civilian");
	maps\_anim::addnotetrack_customfunction("generic","rappel_pushoff_initial_npc",::maps\_utility::func_2C95);
	maps\_anim::addnotetrack_customfunction("generic","ps_rappel_pushoff_initial_npc",::maps\_utility::func_2C95);
	maps\_anim::addnotetrack_customfunction("generic","feet_on_ground",::maps\_utility::disable_achievement_harder_they_fall_guy);
	maps\_anim::addnotetrack_customfunction("generic","ps_rappel_clipout_npc",::maps\_utility::disable_achievement_harder_they_fall_guy);
	foreach(var_01 in level.players)
	{
		var_01 setthreatbiasgroup("allies");
	}

	level._nextcoverprint = 0;
	level._ai_group = [];
	level.killedaxis = 0;
	level.ffpoints = 0;
	level.var_52F1 = 0;
	level.var_376B = [];
	level.smoke_thrown = [];
	if(!isdefined(level.deathflags))
	{
		level.deathflags = [];
	}

	level.var_7874 = 0;
	level.var_3D5A = [];
	if(!isdefined(level.var_7D28))
	{
		level.var_7D28 = [];
	}

	level.var_7D28["regular"] = ::func_7D27;
	level.var_7D28["elite"] = ::func_7D26;
	level.var_7F88 = [];
	level.var_7F88["axis"] = ::func_783D;
	level.var_7F88["allies"] = ::func_783C;
	level.var_7F88["team3"] = ::func_783F;
	level.var_7F88["neutral"] = ::func_783E;
	level.var_55D5 = 0;
	level.var_3E68 = randomintrange(1,4);
	if(!isdefined(level.var_2497))
	{
		level.var_2497 = 2048;
	}

	if(!isdefined(level.default_goalheight))
	{
		level.default_goalheight = 512;
	}

	level.var_60A3 = "J_Shoulder_RI";
	level.var_51F8 = 1024;
	if(!isdefined(level.var_5103))
	{
		level.var_5103 = 11;
	}

	level.var_6C2 = 0;
	var_03 = getaispeciesarray();
	common_scripts\utility::func_F1B(var_03,::living_ai_prethink);
	level.ai_classname_in_level = [];
	level.var_2AFA = [];
	var_04 = getspawnerarray();
	for(var_05 = 0;var_05 < var_04.size;var_05++)
	{
		var_04[var_05] thread func_7810();
	}

	level.var_2AFA = undefined;
	thread process_deathflags();
	common_scripts\utility::func_F1B(var_03,::func_7840);
	level.var_9E5 = getarraykeys(level.ai_classname_in_level);
	for(var_05 = 0;var_05 < level.var_9E5.size;var_05++)
	{
		var_06 = tolower(level.var_9E5[var_05]);
		if(!issubstr(var_06,"panzerfaust3") && !issubstr(var_06,"rpg"))
		{
			continue;
		}

		precacheitem("panzerfaust3_player");
		break;
	}

	level.var_9E5 = undefined;
}

//Function Number: 2
aitype_check()
{
}

//Function Number: 3
check_script_char_group_ratio(param_00)
{
	if(param_00.size <= 16)
	{
	}

	var_01 = 0;
	var_02 = 0;
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		if(!param_00[var_03].team != "axis")
		{
			continue;
		}

		var_01++;
		if(!param_00[var_03] has_char_group())
		{
			continue;
		}

		var_02++;
	}
}

//Function Number: 4
has_char_group()
{
	if(isdefined(self.script_char_group))
	{
		return 1;
	}

	return isdefined(self.script_char_index);
}

//Function Number: 5
process_deathflags()
{
	foreach(var_02, var_01 in level.deathflags)
	{
		if(!isdefined(level.flag[var_02]))
		{
			common_scripts\utility::func_3385(var_02);
		}
	}
}

//Function Number: 6
spawn_guys_until_death_or_no_count()
{
	self endon("death");
	for(;;)
	{
		if(self.count > 0)
		{
			self waittill("spawned");
		}

		waittillframeend;
		if(!self.count)
		{
		}
	}
}

//Function Number: 7
ai_deathflag()
{
	level.deathflags[self.var_6B78]["ai"][self.unique_id] = self;
	var_00 = self.unique_id;
	var_01 = self.var_6B78;
	if(isdefined(self.script_deathflag_longdeath))
	{
		func_8BB3();
	}
	else
	{
		self waittill("death");
	}

	level.deathflags[var_01]["ai"][var_00] = undefined;
	func_866B(var_01);
}

//Function Number: 8
func_88A9()
{
	var_00 = self.unique_id;
	var_01 = self.var_6B78;
	if(!isdefined(level.deathflags) || !isdefined(level.deathflags[self.var_6B78]))
	{
		waittillframeend;
		if(!isdefined(self))
		{
		}
	}

	level.deathflags[var_01]["vehicles"][var_00] = self;
	self waittill("death");
	level.deathflags[var_01]["vehicles"][var_00] = undefined;
	func_866B(var_01);
}

//Function Number: 9
func_786F()
{
	level.deathflags[self.var_6B78] = [];
	waittillframeend;
	if(!isdefined(self) || self.count == 0)
	{
	}

	self.var_7874 = level.var_7874;
	level.var_7874++;
	level.deathflags[self.var_6B78]["spawners"][self.var_7874] = self;
	var_00 = self.var_6B78;
	var_01 = self.var_7874;
	spawn_guys_until_death_or_no_count();
	level.deathflags[var_00]["spawners"][var_01] = undefined;
	func_866B(var_00);
}

//Function Number: 10
func_892D()
{
	level.deathflags[self.var_6B78] = [];
	waittillframeend;
	if(!isdefined(self))
	{
	}

	self.var_7874 = level.var_7874;
	level.var_7874++;
	level.deathflags[self.var_6B78]["vehicle_spawners"][self.var_7874] = self;
	var_00 = self.var_6B78;
	var_01 = self.var_7874;
	spawn_guys_until_death_or_no_count();
	level.deathflags[var_00]["vehicle_spawners"][var_01] = undefined;
	func_866B(var_00);
}

//Function Number: 11
func_866B(param_00)
{
	level notify("updating_deathflag_" + param_00);
	level endon("updating_deathflag_" + param_00);
	waittillframeend;
	foreach(var_02 in level.deathflags[param_00])
	{
		if(getarraykeys(var_02).size > 0)
		{
		}
	}

	common_scripts\utility::flag_set(param_00);
}

//Function Number: 12
func_5A2A(param_00)
{
	param_00 endon("death");
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(!isai(var_01))
		{
			continue;
		}

		var_01 thread maps\_utility::func_4405(0.15);
		var_01 maps\_utility::disable_cqbwalk();
		var_01.var_8C03 = 0;
	}
}

//Function Number: 13
indoor_think(param_00)
{
	param_00 endon("death");
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(!isai(var_01))
		{
			continue;
		}

		var_01 thread maps\_utility::func_4405(0.15);
		var_01 maps\_utility::enable_cqbwalk();
		var_01.var_8C03 = 1;
	}
}

//Function Number: 14
func_285A(param_00)
{
	param_00 endon("death");
	self endon("death");
	for(;;)
	{
		self waittill("trigger");
		if(!param_00.count)
		{
		}

		if(self.target != param_00.targetname)
		{
		}

		if(isdefined(param_00.var_83BF))
		{
		}

		var_01 = param_00 maps\_utility::func_7766();
		if(maps\_utility::func_77BE(var_01))
		{
			param_00 notify("spawn_failed");
		}

		if(isdefined(self.wait) && self.wait > 0)
		{
			wait(self.wait);
		}
	}
}

//Function Number: 15
func_839A(param_00)
{
	var_01 = param_00.var_6315;
	var_02 = param_00.target;
	param_00 waittill("trigger");
	param_00 maps\_utility::script_delay();
	if(isdefined(var_01))
	{
		waittillframeend;
	}

	var_03 = getentarray(var_02,"targetname");
	foreach(var_05 in var_03)
	{
		if(var_05.code_classname == "script_vehicle")
		{
			if((isdefined(var_05.var_6C36) && var_05.var_6C36 == 1) || !isdefined(var_05.target))
			{
				thread maps\_vehicle::func_8927(var_05);
			}
			else
			{
				var_05 thread maps\_vehicle::func_784D();
			}

			continue;
		}

		var_05 thread func_839C();
	}

	if(isdefined(level.var_780E))
	{
		func_8386(var_02);
	}
}

//Function Number: 16
func_8386(param_00)
{
	var_01 = common_scripts\utility::func_3C1A(param_00,"targetname");
	if(getentarray(param_00,"target").size <= 1)
	{
		maps\_utility::deletestructarray_ref(var_01);
	}

	var_02 = func_395B(var_01);
	common_scripts\utility::func_F1B(var_02,::func_839C);
}

//Function Number: 17
func_395B(param_00)
{
	var_01 = [];
	var_02 = [];
	foreach(var_04 in param_00)
	{
		if(!isdefined(var_04.var_6CAF))
		{
			continue;
		}

		if(!isdefined(var_02[var_04.var_6CAF]))
		{
			var_02[var_04.var_6CAF] = [];
		}

		var_02[var_04.var_6CAF][var_02[var_04.var_6CAF].size] = var_04;
	}

	foreach(var_07 in var_02)
	{
		foreach(var_04 in var_07)
		{
			var_09 = func_39A7(var_04,var_07.size);
			var_01[var_01.size] = var_09;
		}
	}

	return var_01;
}

//Function Number: 18
func_39A7(param_00,param_01)
{
	if(!isdefined(level.var_7875))
	{
		level.var_7875 = [];
	}

	if(!isdefined(level.var_7875[param_00.var_6CAF]))
	{
		level.var_7875[param_00.var_6CAF] = create_new_spawner_pool(param_00.var_6CAF);
	}

	var_02 = level.var_7875[param_00.var_6CAF];
	var_03 = var_02.var_6094[var_02.poolindex];
	var_02.poolindex++;
	var_02.poolindex = var_02.poolindex % var_02.var_6094.size;
	var_03.origin = param_00.origin;
	if(isdefined(param_00.angles))
	{
		var_03.angles = param_00.angles;
	}
	else if(isdefined(param_00.target))
	{
		var_04 = getnode(param_00.target,"targetname");
		if(isdefined(var_04))
		{
			var_03.angles = vectortoangles(var_04.origin - var_03.origin);
		}
	}

	if(isdefined(level.var_780D))
	{
		var_03 [[ level.var_780D ]](param_00);
	}

	if(isdefined(param_00.target))
	{
		var_03.target = param_00.target;
	}

	var_03.count = 1;
	return var_03;
}

//Function Number: 19
create_new_spawner_pool(param_00)
{
	var_01 = getspawnerarray();
	var_02 = spawnstruct();
	var_03 = [];
	foreach(var_05 in var_01)
	{
		if(!isdefined(var_05.var_6CAF))
		{
			continue;
		}

		if(var_05.var_6CAF != param_00)
		{
			continue;
		}

		var_03[var_03.size] = var_05;
	}

	var_02.poolindex = 0;
	var_02.var_6094 = var_03;
	return var_02;
}

//Function Number: 20
func_839C()
{
	self endon("death");
	maps\_utility::script_delay();
	if(!isdefined(self))
	{
		return undefined;
	}

	if(isdefined(self.var_6B97))
	{
		var_00 = maps\_utility::func_2B2A(self);
		return undefined;
	}
	else if(!issubstr(self.classname,"actor"))
	{
		return undefined;
	}

	var_01 = isdefined(self.var_6CC2) && common_scripts\utility::flag("_stealth_enabled") && !common_scripts\utility::flag("_stealth_spotted");
	if(isdefined(self.var_6BD5))
	{
		var_00 = self stalingradspawn(var_01);
	}
	else
	{
		var_00 = self dospawn(var_01);
	}

	if(!maps\_utility::func_77BE(var_01))
	{
		if(isdefined(self.var_6B6B))
		{
			if(self.var_6B6B == "heat")
			{
				var_01 maps\_utility::func_2CB6();
			}

			if(self.var_6B6B == "cqb")
			{
				var_01 maps\_utility::enable_cqbwalk();
			}
		}
	}

	return var_01;
}

//Function Number: 21
func_839B(param_00)
{
	var_01 = param_00.target;
	var_02 = 0;
	var_03 = getentarray(var_01,"targetname");
	foreach(var_05 in var_03)
	{
		if(!isdefined(var_05.target))
		{
			continue;
		}

		var_06 = getent(var_05.target,"targetname");
		if(!isdefined(var_06))
		{
			if(!isdefined(var_05.script_linkto))
			{
				continue;
			}

			var_06 = var_05 common_scripts\utility::func_38D7();
			if(!isdefined(var_06))
			{
				continue;
			}

			if(!isspawner(var_06))
			{
				continue;
			}
		}

		var_02 = 1;
		break;
	}

	param_00 waittill("trigger");
	param_00 maps\_utility::script_delay();
	var_03 = getentarray(var_01,"targetname");
	foreach(var_05 in var_03)
	{
		var_05 thread func_838F();
	}
}

//Function Number: 22
func_838F()
{
	var_00 = func_838E();
	var_01 = func_839C();
	if(!isdefined(var_01))
	{
		self delete();
		if(isdefined(var_00))
		{
			var_01 = var_00 func_839C();
			var_00 delete();
			if(!isdefined(var_01))
			{
			}
		}
		else
		{
		}
	}

	if(!isdefined(var_00))
	{
	}

	var_01 waittill("death");
	if(!isdefined(var_00))
	{
	}

	if(!isdefined(var_00.count))
	{
		var_00.count = 1;
	}

	for(;;)
	{
		if(!isdefined(var_00))
		{
			break;
		}

		var_02 = var_00 thread func_839C();
		if(!isdefined(var_02))
		{
			var_00 delete();
			break;
		}

		var_02 thread reincrement_count_if_deleted(var_00);
		var_02 waittill("death",var_03);
		if(!player_saw_kill(var_02,var_03))
		{
			if(!isdefined(var_00))
			{
				break;
			}

			var_00.count++;
		}

		if(!isdefined(var_02))
		{
			continue;
		}

		if(!isdefined(var_00))
		{
			break;
		}

		if(!isdefined(var_00.count))
		{
			break;
		}

		if(var_00.count <= 0)
		{
			break;
		}

		if(!maps\_utility::func_6D02())
		{
			wait(randomfloatrange(1,3));
		}
	}

	if(isdefined(var_00))
	{
		var_00 delete();
	}
}

//Function Number: 23
func_838E()
{
	if(isdefined(self.target))
	{
		var_00 = getent(self.target,"targetname");
		if(isdefined(var_00) && isspawner(var_00))
		{
			return var_00;
		}
	}

	if(isdefined(self.script_linkto))
	{
		var_00 = common_scripts\utility::func_38D7();
		if(isdefined(var_00) && isspawner(var_00))
		{
			return var_00;
		}
	}

	return undefined;
}

//Function Number: 24
flood_spawner_scripted(param_00)
{
	common_scripts\utility::func_F1B(param_00,::func_3461);
	common_scripts\utility::func_F1B(param_00,::flood_spawner_think);
}

//Function Number: 25
reincrement_count_if_deleted(param_00)
{
	param_00 endon("death");
	if(isdefined(self.var_6BCE))
	{
		if(self.var_6BCE)
		{
		}
	}

	self waittill("death");
	if(!isdefined(self))
	{
		param_00.count++;
	}
}

//Function Number: 26
delete_start(param_00)
{
	for(var_01 = 0;var_01 < 2;var_01++)
	{
		switch(var_01)
		{
			case 0:
				var_02 = "axis";
				break;

			default:
				var_02 = "allies";
				break;
		}

		var_03 = getentarray(var_02,"team");
		for(var_04 = 0;var_04 < var_03.size;var_04++)
		{
			if(isdefined(var_03[var_04].var_6CBB))
			{
				if(var_03[var_04].var_6CBB == param_00)
				{
					var_03[var_04] thread delete_me();
				}
			}
		}
	}
}

//Function Number: 27
kill_trigger(param_00)
{
	if(!isdefined(param_00))
	{
	}

	if(isdefined(param_00.targetname) && param_00.targetname != "flood_spawner")
	{
	}

	param_00 delete();
}

//Function Number: 28
func_6315(param_00)
{
	param_00 endon("death");
	var_01 = param_00.var_6C88;
	waittillframeend;
	if(!isdefined(level.var_4B2C[var_01]))
	{
	}

	param_00 waittill("trigger");
	cull_spawners_from_killspawner(var_01);
}

//Function Number: 29
cull_spawners_from_killspawner(param_00)
{
	if(!isdefined(level.var_4B2C[param_00]))
	{
	}

	var_01 = level.var_4B2C[param_00];
	var_02 = getarraykeys(var_01);
	if(var_02.size <= 1)
	{
	}

	var_03 = common_scripts\utility::func_6306(var_02);
	var_01[var_03] = undefined;
	foreach(var_09, var_05 in var_01)
	{
		foreach(var_07 in var_05)
		{
			if(isdefined(var_07))
			{
				var_07 delete();
			}
		}

		level.var_4B2C[param_00][var_09] = undefined;
	}
}

//Function Number: 30
func_4B2D(param_00)
{
	var_01 = getspawnerarray();
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(isdefined(var_01[var_02].var_6C08) && param_00 == var_01[var_02].var_6C08)
		{
			var_01[var_02] delete();
		}
	}
}

//Function Number: 31
func_4AFC(param_00)
{
	var_01 = param_00.var_6C08;
	param_00 waittill("trigger");
	waittillframeend;
	waittillframeend;
	func_4B2D(var_01);
	kill_trigger(param_00);
}

//Function Number: 32
empty_spawner(param_00)
{
	var_01 = param_00.var_6BA0;
	param_00 waittill("trigger");
	var_02 = getspawnerarray();
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(!isdefined(var_02[var_03].var_6BA0))
		{
			continue;
		}

		if(var_01 != var_02[var_03].var_6BA0)
		{
			continue;
		}

		if(isdefined(var_02[var_03].var_6BC7))
		{
			level notify("stop_flanker_behavior" + var_02[var_03].var_6BC7);
		}

		var_02[var_03] maps\_utility::func_6E67(0);
		var_02[var_03] notify("emptied spawner");
	}

	param_00 notify("deleted spawners");
}

//Function Number: 33
kill_spawnernum(param_00)
{
	var_01 = getspawnerarray();
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(!isdefined(var_01[var_02].var_6C08))
		{
			continue;
		}

		if(param_00 != var_01[var_02].var_6C08)
		{
			continue;
		}

		var_01[var_02] delete();
	}
}

//Function Number: 34
func_8399(param_00)
{
}

//Function Number: 35
spawn_grenade(param_00,param_01)
{
	if(!isdefined(level.var_3DA2) || !isdefined(level.var_3DA2[param_01]))
	{
		level.grenade_cache_index[param_01] = 0;
		level.var_3DA2[param_01] = [];
	}

	var_02 = level.grenade_cache_index[param_01];
	var_03 = level.var_3DA2[param_01][var_02];
	if(isdefined(var_03))
	{
		var_03 delete();
	}

	var_03 = spawn("weapon_fraggrenade",param_00);
	level.var_3DA2[param_01][var_02] = var_03;
	level.grenade_cache_index[param_01] = var_02 + 1 % 16;
	return var_03;
}

//Function Number: 36
func_8BB3()
{
	self endon("death");
	self waittill("pain_death");
}

//Function Number: 37
func_2B3A()
{
	var_00 = self.team;
	func_8BB3();
	if(!isdefined(self))
	{
	}

	if(isdefined(self.var_565D))
	{
	}

	self.ignoreforfixednodesafecheck = 1;
	if(self.grenadeammo <= 0)
	{
	}

	level.nextgrenadedrop--;
	if(level.nextgrenadedrop > 0)
	{
	}

	level.nextgrenadedrop = 2 + randomint(2);
	var_01 = 25;
	var_02 = 12;
	var_03 = self.origin + (randomint(var_01) - var_02,randomint(var_01) - var_02,2) + (0,0,42);
	var_04 = (0,randomint(360),90);
	thread func_77CD(var_03,var_04,self.team);
}

//Function Number: 38
func_77CD(param_00,param_01,param_02)
{
	var_03 = spawn_grenade(param_00,param_02);
	var_03 setmodel("grenade_bag");
	var_03.angles = param_01;
	var_03 hide();
	wait(0.7);
	if(!isdefined(var_03))
	{
	}

	var_03 show();
}

//Function Number: 39
dronespawner_init()
{
	maps\_drone_base::drone_init_path();
}

//Function Number: 40
empty()
{
}

//Function Number: 41
func_7810()
{
	level.ai_classname_in_level[self.classname] = 1;
	if(isdefined(self.var_6B89))
	{
		switch(self.var_6B89)
		{
			case "easy":
				if(level.gameskill > 1)
				{
					maps\_utility::func_6E67(0);
				}
				break;

			case "hard":
				if(level.gameskill < 2)
				{
					maps\_utility::func_6E67(0);
				}
				break;
		}
	}

	if(isdefined(self.var_6B97))
	{
		thread dronespawner_init();
	}

	if(isdefined(self.var_6B1E))
	{
		var_00 = self.var_6B1E;
		if(!isdefined(level._ai_group[var_00]))
		{
			aigroup_create(var_00);
		}

		thread aigroup_spawnerthink(level._ai_group[var_00]);
	}

	if(isdefined(self.var_6B83))
	{
		var_01 = 0;
		if(isdefined(level._ai_delete))
		{
			if(isdefined(level._ai_delete[self.var_6B83]))
			{
				var_01 = level._ai_delete[self.var_6B83].size;
			}
		}

		level._ai_delete[self.var_6B83][var_01] = self;
	}

	if(isdefined(self.script_health))
	{
		if(self.script_health > level.var_6C2)
		{
			level.var_6C2 = self.script_health;
		}

		var_01 = 0;
		if(isdefined(level._ai_health))
		{
			if(isdefined(level._ai_health[self.script_health]))
			{
				var_01 = level._ai_health[self.script_health].size;
			}
		}

		level._ai_health[self.script_health][var_01] = self;
	}

	if(isdefined(self.var_6B78))
	{
		thread func_786F();
	}

	if(isdefined(self.target))
	{
		crawl_through_targets_to_init_flags();
	}

	if(isdefined(self.var_6CB0))
	{
		add_to_spawngroup();
	}

	if(isdefined(self.var_6C88))
	{
		add_random_killspawner_to_spawngroup();
	}

	if(!isdefined(self.var_77C7))
	{
		self.var_77C7 = [];
	}

	for(;;)
	{
		var_02 = undefined;
		self waittill("spawned",var_02);
		if(!isalive(var_02))
		{
			continue;
		}

		if(isdefined(level.var_7877))
		{
			self thread [[ level.var_7877 ]](var_02);
		}

		if(isdefined(self.var_6B83))
		{
			for(var_03 = 0;var_03 < level._ai_delete[self.var_6B83].size;var_03++)
			{
				if(level._ai_delete[self.var_6B83][var_03] != self)
				{
					level._ai_delete[self.var_6B83][var_03] delete();
				}
			}
		}

		var_02.var_77C6 = self.var_77C7;
		var_02.spawner = self;
		if(isdefined(self.targetname))
		{
			var_02 thread func_7840(self.targetname);
			continue;
		}

		var_02 thread func_7840();
	}
}

//Function Number: 42
func_7840(param_00)
{
	level.ai_classname_in_level[self.classname] = 1;
	func_7841(param_00);
	self endon("death");
	if(func_74B7())
	{
		self delete();
	}

	thread run_spawn_functions();
	self.finished_spawning = 1;
	self notify("finished spawning");
	if(self.team == "allies" && !isdefined(self.script_nofriendlywave))
	{
		thread func_3572();
	}
}

//Function Number: 43
func_74B7()
{
	if(!isdefined(self.var_6B89))
	{
		return 0;
	}

	var_00 = 0;
	switch(self.var_6B89)
	{
		case "easy":
			if(level.gameskill > 1)
			{
				var_00 = 1;
			}
			break;

		case "hard":
			if(level.gameskill < 2)
			{
				var_00 = 1;
			}
			break;
	}

	return var_00;
}

//Function Number: 44
run_spawn_functions()
{
	if(!isdefined(self.var_77C6))
	{
		self.spawner = undefined;
	}

	for(var_00 = 0;var_00 < self.var_77C6.size;var_00++)
	{
		var_01 = self.var_77C6[var_00];
		if(isdefined(var_01["param5"]))
		{
			thread [[ var_01["function"] ]](var_01["param1"],var_01["param2"],var_01["param3"],var_01["param4"],var_01["param5"]);
			continue;
		}

		if(isdefined(var_01["param4"]))
		{
			thread [[ var_01["function"] ]](var_01["param1"],var_01["param2"],var_01["param3"],var_01["param4"]);
			continue;
		}

		if(isdefined(var_01["param3"]))
		{
			thread [[ var_01["function"] ]](var_01["param1"],var_01["param2"],var_01["param3"]);
			continue;
		}

		if(isdefined(var_01["param2"]))
		{
			thread [[ var_01["function"] ]](var_01["param1"],var_01["param2"]);
			continue;
		}

		if(isdefined(var_01["param1"]))
		{
			thread [[ var_01["function"] ]](var_01["param1"]);
			continue;
		}

		thread [[ var_01["function"] ]]();
	}

	var_02 = common_scripts\utility::func_803F(isdefined(level.var_8928) && level.var_8928 && self.code_classname == "script_vehicle",self.script_team,self.team);
	if(isdefined(var_02))
	{
		for(var_00 = 0;var_00 < level.var_77C6[var_02].size;var_00++)
		{
			var_01 = level.var_77C6[var_02][var_00];
			if(isdefined(var_01["param5"]))
			{
				thread [[ var_01["function"] ]](var_01["param1"],var_01["param2"],var_01["param3"],var_01["param4"],var_01["param5"]);
				continue;
			}

			if(isdefined(var_01["param4"]))
			{
				thread [[ var_01["function"] ]](var_01["param1"],var_01["param2"],var_01["param3"],var_01["param4"]);
				continue;
			}

			if(isdefined(var_01["param3"]))
			{
				thread [[ var_01["function"] ]](var_01["param1"],var_01["param2"],var_01["param3"]);
				continue;
			}

			if(isdefined(var_01["param2"]))
			{
				thread [[ var_01["function"] ]](var_01["param1"],var_01["param2"]);
				continue;
			}

			if(isdefined(var_01["param1"]))
			{
				thread [[ var_01["function"] ]](var_01["param1"]);
				continue;
			}

			thread [[ var_01["function"] ]]();
		}
	}

	self.var_77C6 = undefined;
	self.spawner = undefined;
}

//Function Number: 45
func_78FB()
{
	if(!maps\_utility::func_4840())
	{
	}

	maps\_utility::add_damage_function(::func_78F9);
	thread func_5528();
}

//Function Number: 46
func_5528()
{
	self waittill("death",var_00,var_01,var_02);
	if(!isdefined(self))
	{
	}

	if(!self isbadguy())
	{
	}

	if(!isdefined(var_00))
	{
	}

	if(!isplayer(var_00))
	{
	}

	if(!isdefined(var_02))
	{
		var_00.var_5527 = undefined;
	}

	if(!isdefined(var_00.var_5527))
	{
		var_00.var_5527 = 1;
	}
	else
	{
		var_00.var_5527++;
	}

	if(maps\_utility::is_survival() && var_00.var_5527 >= 4)
	{
		var_00 notify("sur_ch_quadkill");
	}

	waittillframeend;
	var_00.var_5527 = undefined;
}

//Function Number: 47
func_78F9(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(self))
	{
	}

	if(isdefined(param_01) && isplayer(param_01))
	{
		self.var_4BF5 = param_01;
		self.var_4BF6 = param_04;
	}
}

//Function Number: 48
func_237C()
{
	self waittill("death",var_00,var_01,var_02);
	level notify("ai_killed",self);
	if(!isdefined(self))
	{
	}

	if(isdefined(var_00))
	{
		if(self.team == "axis" || self.team == "team3")
		{
			var_03 = undefined;
			if(isdefined(var_00.attacker))
			{
				if(isdefined(var_00.issentrygun) && var_00.issentrygun)
				{
					var_03 = "sentry";
				}

				if(isdefined(var_00.destructible_type))
				{
					var_03 = "destructible";
				}

				var_00 = var_00.attacker;
			}
			else if(isdefined(var_00.owner))
			{
				if(isai(var_00) && isplayer(var_00.owner))
				{
					var_03 = "friendly";
				}

				var_00 = var_00.owner;
			}
			else if(isdefined(var_00.damageowner))
			{
				if(isdefined(var_00.destructible_type))
				{
					var_03 = "destructible";
				}

				var_00 = var_00.damageowner;
			}

			var_04 = 0;
			if(isplayer(var_00))
			{
				var_04 = 1;
			}

			if(isdefined(level.var_6084) && level.var_6084)
			{
				var_04 = 1;
			}

			if(var_04)
			{
				var_00 maps\_player_stats::func_6454(self,var_01,var_02,var_03);
			}
		}
	}

	for(var_05 = 0;var_05 < self.deathfuncs.size;var_05++)
	{
		var_06 = self.deathfuncs[var_05];
		switch(var_06["params"])
		{
			case 0:
				[[ var_06["func"] ]](var_00);
				break;

			case 1:
				[[ var_06["func"] ]](var_00,var_06["param1"]);
				break;

			case 2:
				[[ var_06["func"] ]](var_00,var_06["param1"],var_06["param2"]);
				break;

			case 3:
				[[ var_06["func"] ]](var_00,var_06["param1"],var_06["param2"],var_06["param3"]);
				break;
		}
	}
}

//Function Number: 49
ai_damage_think()
{
	self.damage_functions = [];
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06);
		if(isdefined(var_01) && isplayer(var_01))
		{
			var_07 = var_01 getcurrentweapon();
			if(isdefined(var_07) && maps\_utility::isprimaryweapon(var_07) && isdefined(var_04) && var_04 == "MOD_PISTOL_BULLET" || var_04 == "MOD_RIFLE_BULLET")
			{
				var_01 thread maps\_player_stats::func_6461();
			}
		}

		foreach(var_09 in self.damage_functions)
		{
			thread [[ var_09 ]](var_00,var_01,var_02,var_03,var_04,var_05,var_06);
		}

		if(!isalive(self) || self.delayeddeath)
		{
			break;
		}
	}
}

//Function Number: 50
living_ai_prethink()
{
	if(isdefined(self.var_6B78))
	{
		level.deathflags[self.var_6B78] = 1;
	}

	if(isdefined(self.target))
	{
		crawl_through_targets_to_init_flags();
	}
}

//Function Number: 51
crawl_through_targets_to_init_flags()
{
	var_00 = get_node_funcs_based_on_target();
	if(isdefined(var_00))
	{
		var_01 = var_00["destination"];
		var_02 = var_00["get_target_func"];
		for(var_03 = 0;var_03 < var_01.size;var_03++)
		{
			crawl_target_and_init_flags(var_01[var_03],var_02);
		}
	}
}

//Function Number: 52
func_783C()
{
	self.usechokepoints = 0;
}

//Function Number: 53
func_783D()
{
	if(isdefined(level.var_8E6B) && level.var_8E6B && isdefined(level.var_8E6A))
	{
		self thread [[ level.var_8E6A ]]();
	}

	if(self.type == "human" && !isdefined(level.disablegeardrop))
	{
		thread func_2B3A();
	}

	maps\_utility::add_damage_function(::maps\_gameskill::func_11A6);
	if(isdefined(self.var_6B6C))
	{
		self.combatmode = self.var_6B6C;
	}
}

//Function Number: 54
func_783F()
{
	func_783D();
}

//Function Number: 55
func_783E()
{
}

//Function Number: 56
func_7D26()
{
	self endon("death");
	self.var_2C70 = 1;
	self.var_29F3 = 0.5;
	if(!isdefined(self.var_6B1C))
	{
		self.baseaccuracy = 2;
	}

	self.aggressivemode = 1;
	if(maps\_utility::func_3FEE())
	{
		var_00 = undefined;
		switch(level.gameskill)
		{
			case 0:
				var_00 = 0;
				break;

			case 1:
				var_00 = 2;
				break;

			case 2:
				var_00 = 3;
				break;

			case 3:
				var_00 = 4;
				break;
		}

		if(level.gameskill > 0)
		{
			self.grenadeweapon = "flash_grenade";
			self.grenadeammo = var_00;
		}
	}
}

//Function Number: 57
func_7D27()
{
}

//Function Number: 58
pain_resistance(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("death");
	if(self.health <= 0)
	{
	}

	if(param_00 >= self.minpaindamage)
	{
		var_07 = self.minpaindamage;
		self.minpaindamage = var_07 * 3;
		wait(5);
		self.minpaindamage = var_07;
	}
}

//Function Number: 59
bullet_resistance(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(self) || self.health <= 0)
	{
	}

	if(isdefined(self.magic_bullet_shield) && self.magic_bullet_shield)
	{
	}

	if(!issubstr(param_04,"BULLET"))
	{
	}

	var_07 = self.bullet_resistance;
	if(param_00 < self.bullet_resistance)
	{
		var_07 = param_00;
	}

	self.health = self.health + var_07;
}

//Function Number: 60
func_7842()
{
	maps\_gameskill::default_door_node_flashbang_frequency();
	maps\_gameskill::grenadeawareness();
}

//Function Number: 61
ai_lasers()
{
	if(!isalive(self))
	{
	}

	if(self.health <= 1)
	{
	}

	self laserforceon();
	self waittill("death");
	if(!isdefined(self))
	{
	}

	self laserforceoff();
}

//Function Number: 62
func_7843()
{
	if(isdefined(self.var_6B94))
	{
		self.dontshootwhilemoving = 1;
	}

	if(isdefined(self.var_6B78))
	{
		thread ai_deathflag();
	}

	if(isdefined(self.var_6B37))
	{
		self.attackeraccuracy = self.var_6B37;
	}

	if(isdefined(self.var_6CC0))
	{
		thread start_off_running();
	}

	if(isdefined(self.var_6B7B))
	{
		thread deathtime();
	}

	if(isdefined(self.script_nosurprise))
	{
		maps\_utility::func_2788();
	}

	if(isdefined(self.var_6C59))
	{
		self.var_757E = 1;
	}

	if(isdefined(self.var_6C0D))
	{
		thread ai_lasers();
	}

	if(isdefined(self.var_6B73))
	{
		var_00 = self.var_6B73;
		if(var_00 == 1)
		{
			var_00 = 8;
		}

		maps\_utility::enable_danger_react(var_00);
	}

	if(isdefined(self.var_6BAF))
	{
		self.maxfaceenemydist = self.var_6BAF;
	}
	else
	{
		self.maxfaceenemydist = 512;
	}

	if(isdefined(self.var_6BCF))
	{
		maps\_utility::func_6EDF(self.var_6BCF);
	}

	if(isdefined(self.dontdropweapon))
	{
		self.dropweapon = 0;
	}

	if(isdefined(self.script_fixednode))
	{
		self.fixednode = self.script_fixednode == 1;
	}
	else
	{
		self.fixednode = self.team == "allies";
	}

	self.providecoveringfire = self.team == "allies" && self.fixednode;
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "mgpair")
	{
		thread maps\_mg_penetration::func_209B();
	}

	if(isdefined(self.script_goalvolume) && !(isdefined(self.var_6C36) && self.var_6C36 == 1) || isdefined(self.var_6CC2))
	{
		thread set_goal_volume();
	}

	if(isdefined(self.var_6CD3))
	{
		self setthreatbiasgroup(self.var_6CD3);
	}
	else if(self.team == "neutral")
	{
		self setthreatbiasgroup("civilian");
	}
	else
	{
		self setthreatbiasgroup(self.team);
	}

	if(isdefined(self.var_6B51))
	{
		maps\_utility::func_6E54(self.var_6B51);
	}

	if(isdefined(self.var_6B1C))
	{
		self.baseaccuracy = self.var_6B1C;
	}

	if(isdefined(self.var_6BFE))
	{
		self.ignoreme = 1;
	}

	if(isdefined(self.script_ignore_suppression))
	{
		self.ignoresuppression = 1;
	}

	if(isdefined(self.var_6BFD))
	{
		self.ignoreall = 1;
		self clearenemy();
	}

	if(isdefined(self.var_6CA4))
	{
		self.maxsightdistsqrd = self.var_6CA4;
	}

	if(isdefined(self.script_favoriteenemy))
	{
		if(self.script_favoriteenemy == "player")
		{
			self.favoriteenemy = level.player;
			level.player.targetname = "player";
		}
	}

	if(isdefined(self.var_6BB4))
	{
		self.pathenemyfightdist = self.var_6BB4;
	}

	if(isdefined(self.var_6C1C))
	{
		self.pathenemylookahead = self.var_6C1C;
	}

	if(isdefined(self.script_longdeath))
	{
		self.a.disablelongdeath = 1;
	}

	if(isdefined(self.var_6B88))
	{
		self.diequietly = 1;
	}

	if(isdefined(self.var_6BC8))
	{
		self.grenadeweapon = "flash_grenade";
		self.grenadeammo = self.var_6BC8;
	}

	if(isdefined(self.var_6C72))
	{
		self.pacifist = 1;
	}

	if(isdefined(self.var_6CBC))
	{
		self.health = self.var_6CBC;
	}

	if(isdefined(self.var_6C5C))
	{
		self.var_565D = self.var_6C5C;
	}
}

//Function Number: 63
func_7841(param_00)
{
	thread ai_damage_think();
	thread func_7F35();
	thread death_achievements();
	thread func_78FB();
	if(!isdefined(level.ai_dont_glow_in_thermal))
	{
		self thermaldrawenable();
	}

	self.var_7874 = undefined;
	if(!isdefined(self.unique_id))
	{
		maps\_utility::func_6E21();
	}

	if(!isdefined(self.deathfuncs))
	{
		self.deathfuncs = [];
	}

	thread func_237C();
	level thread maps\_friendlyfire::func_3535(self);
	self.walkdist = 16;
	func_4598();
	func_7842();
	func_7843();
	[[ level.var_7F88[self.team] ]]();
	thread [[ level.var_7D28[self.var_7D25] ]]();
	thread maps\_damagefeedback::func_537B();
	common_scripts\_dynamic_world::ai_init();
	func_6EF8();
	if(isdefined(self.var_6C82))
	{
		self setgoalentity(level.player);
	}

	if(isdefined(self.var_6CC2))
	{
		if(isdefined(self.var_6CC4))
		{
			var_01 = level.var_7B78[self.var_6CC4];
			self thread [[ var_01 ]]();
		}
		else
		{
			self thread [[ level.global_callbacks["_spawner_stealth_default"] ]]();
		}
	}

	if(isdefined(self.script_idleanim))
	{
		self thread [[ level.global_callbacks["_idle_call_idle_func"] ]]();
	}

	if(isdefined(self.var_6BFB) && !isdefined(self.var_6C36))
	{
		self thread [[ level.global_callbacks["_idle_call_idle_func"] ]]();
	}

	if(isdefined(self.var_6C79) && !isdefined(self.var_6C36))
	{
		thread maps\_patrol::func_5B3C();
	}

	if(isdefined(self.var_6C8A) && self.var_6C8A == 1)
	{
		maps\_utility::func_2CC4();
	}

	if(isdefined(self.script_delayed_playerseek))
	{
		if(!isdefined(self.script_radius))
		{
			self.goalradius = 800;
		}

		self setgoalentity(level.player);
		level thread delayed_player_seek_think(self);
	}

	if(isdefined(self.var_87AC))
	{
	}

	if(isdefined(self.var_6C36) && self.var_6C36 == 1)
	{
		set_goal_from_settings();
		self setgoalpos(self.origin);
	}

	if(!isdefined(self.var_6CC2))
	{
	}

	set_goal_from_settings();
	if(isdefined(self.target))
	{
		thread go_to_node();
	}
}

//Function Number: 64
func_4598()
{
	maps\_utility::func_6E81();
	if(isdefined(self.var_6BF0))
	{
		self.grenadeammo = self.var_6BF0;
	}
	else
	{
		self.grenadeammo = 3;
	}

	if(isdefined(self.primaryweapon))
	{
		self.noattackeraccuracymod = animscripts/combat_utility::issniper();
	}

	if(!maps\_utility::func_4840())
	{
		self.var_55A9 = 1;
	}
}

//Function Number: 65
func_6D19()
{
	if(self.team == "neutral")
	{
		self setthreatbiasgroup("civilian");
	}
	else
	{
		self setthreatbiasgroup(self.team);
	}

	func_4598();
	self.baseaccuracy = 1;
	maps\_gameskill::grenadeawareness();
	maps\_utility::func_1D0F();
	self.interval = 96;
	self.var_279A = undefined;
	self.ignoreme = 0;
	self.threatbias = 0;
	self.pacifist = 0;
	self.pacifistwait = 20;
	self.ignorerandombulletdamage = 0;
	self.pushable = 1;
	self.script_pushable = 1;
	self.allowdeath = 0;
	self.anglelerprate = 540;
	self.badplaceawareness = 0.75;
	self.dontavoidplayer = 0;
	self.drawoncompass = 1;
	self.dropweapon = 1;
	self.goalradius = level.var_2497;
	self.goalheight = level.default_goalheight;
	self.ignoresuppression = 0;
	self pushplayer(0);
	if(isdefined(self.magic_bullet_shield) && self.magic_bullet_shield)
	{
		maps\_utility::func_7C38();
	}

	maps\_utility::func_277B();
	self.maxsightdistsqrd = 67108864;
	self.script_forcegrenade = 0;
	self.walkdist = 16;
	maps\_utility::func_85C5();
	self.pushable = 1;
	self.script_pushable = 1;
	animscripts/init::func_6E33();
	self.fixednode = self.team == "allies";
}

//Function Number: 66
delayed_player_seek_think(param_00)
{
	param_00 endon("death");
	while(isalive(param_00))
	{
		if(param_00.goalradius > 200)
		{
			param_00.goalradius = param_00.goalradius - 200;
		}

		wait(6);
	}
}

//Function Number: 67
func_3393(param_00)
{
	self endon("death");
	if(!self.var_33A5)
	{
		param_00.var_87AC = 1;
		self.var_33A5 = 1;
		param_00 waittill("death");
		self.var_33A5 = 0;
		self notify("get new user");
	}
}

//Function Number: 68
set_goal_volume()
{
	self endon("death");
	waittillframeend;
	if(isdefined(self.team) && self.team == "allies")
	{
		self.fixednode = 0;
	}

	var_00 = level.var_3D6E[self.script_goalvolume];
	if(!isdefined(var_00))
	{
	}

	if(isdefined(var_00.target))
	{
		var_01 = getnode(var_00.target,"targetname");
		var_02 = getent(var_00.target,"targetname");
		var_03 = common_scripts\utility::func_3C18(var_00.target,"targetname");
		var_04 = undefined;
		if(isdefined(var_01))
		{
			var_04 = var_01;
			self setgoalnode(var_04);
		}
		else if(isdefined(var_02))
		{
			var_04 = var_02;
			self setgoalpos(var_04.origin);
		}
		else if(isdefined(var_03))
		{
			var_04 = var_03;
			self setgoalpos(var_04.origin);
		}

		if(isdefined(var_04.radius) && var_04.radius != 0)
		{
			self.goalradius = var_04.radius;
		}

		if(isdefined(var_04.goalheight) && var_04.goalheight != 0)
		{
			self.goalheight = var_04.goalheight;
		}
	}

	if(isdefined(self.target))
	{
		self setgoalvolume(var_00);
	}

	self setgoalvolumeauto(var_00);
}

//Function Number: 69
get_target_ents(param_00)
{
	return getentarray(param_00,"targetname");
}

//Function Number: 70
func_39C3(param_00)
{
	return getnodearray(param_00,"targetname");
}

//Function Number: 71
func_39C4(param_00)
{
	return common_scripts\utility::func_3C1A(param_00,"targetname");
}

//Function Number: 72
func_5644(param_00)
{
	return isdefined(param_00.radius) && param_00.radius != 0;
}

//Function Number: 73
func_3D60(param_00,param_01)
{
	go_to_node(param_00,"origin",param_01);
}

//Function Number: 74
go_to_struct(param_00,param_01)
{
	go_to_node(param_00,"struct",param_01);
}

//Function Number: 75
go_to_node(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(self.var_87AC))
	{
	}

	var_05 = get_node_funcs_based_on_target(param_00,param_01);
	if(!isdefined(var_05))
	{
		self notify("reached_path_end");
	}

	func_3D5E(var_05["destination"],var_05["get_target_func"],var_05["set_goal_func_quits"],param_02,param_03,param_04);
}

//Function Number: 76
func_38D1(param_00)
{
	if(param_00.size == 1)
	{
		return param_00[0];
	}

	var_01 = param_00[0].targetname;
	if(!isdefined(level.var_3D5A[var_01]))
	{
		level.var_3D5A[var_01] = param_00;
	}

	param_00 = level.var_3D5A[var_01];
	var_02 = param_00[0];
	var_03 = [];
	for(var_04 = 0;var_04 < param_00.size - 1;var_04++)
	{
		var_03[var_04] = param_00[var_04 + 1];
	}

	var_03[param_00.size - 1] = param_00[0];
	level.var_3D5A[var_01] = var_03;
	return var_02;
}

//Function Number: 77
func_3D5E(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self notify("stop_going_to_node");
	self endon("stop_going_to_node");
	self endon("death");
	for(;;)
	{
		param_00 = func_38D1(param_00);
		var_06 = param_04;
		if(isdefined(param_00.var_6C8C))
		{
			if(param_00.var_6C8C > 1)
			{
				var_06 = param_00.var_6C8C;
			}

			param_00.var_6C8C = 0;
		}

		if(func_5644(param_00))
		{
			self.goalradius = param_00.radius;
		}
		else
		{
			self.goalradius = level.var_2497;
		}

		if(isdefined(param_00.height))
		{
			self.goalheight = param_00.height;
		}
		else
		{
			self.goalheight = level.default_goalheight;
		}

		[[ param_02 ]](param_00);
		if(maps\_utility::ent_flag_exist("_stealth_override_goalpos"))
		{
			for(;;)
			{
				self waittill("goal");
				if(!maps\_utility::ent_flag("_stealth_override_goalpos"))
				{
					break;
				}

				maps\_utility::ent_flag_waitopen("_stealth_override_goalpos");
			}
		}
		else
		{
			self waittill("goal");
		}

		param_00 notify("trigger",self);
		if(isdefined(param_03))
		{
			[[ param_03 ]](param_00);
		}

		if(isdefined(param_00.script_flag_set))
		{
			common_scripts\utility::flag_set(param_00.script_flag_set);
		}

		if(isdefined(param_00.var_6BA6))
		{
			maps\_utility::func_2F48(param_00.var_6BA6);
		}

		if(isdefined(param_00.script_flag_clear))
		{
			common_scripts\utility::func_337C(param_00.script_flag_clear);
		}

		if(func_7F6D(param_00))
		{
			return 1;
		}

		param_00 maps\_utility::script_delay();
		if(isdefined(param_00.var_6BC4))
		{
			common_scripts\utility::flag_wait(param_00.var_6BC4);
		}

		param_00 maps\_utility::func_6D02();
		if(isdefined(param_00.script_delay_post))
		{
			wait(param_00.script_delay_post);
		}

		while(isdefined(param_00.var_6C8C))
		{
			param_00.var_6C8C = 0;
			if(func_3D5F(param_00,param_01,var_06))
			{
				param_00.var_6C8C = 1;
				param_00 notify("script_requires_player");
				break;
			}

			wait(0.1);
		}

		if(isdefined(param_05))
		{
			[[ param_05 ]](param_00);
		}

		if(!isdefined(param_00.target))
		{
			break;
		}

		var_07 = [[ param_01 ]](param_00.target);
		if(!var_07.size)
		{
			break;
		}

		param_00 = var_07;
	}

	self notify("reached_path_end");
	if(isdefined(self.var_6BD2))
	{
	}

	if(isdefined(self getgoalvolume()))
	{
		self setgoalvolumeauto(self getgoalvolume());
	}

	self.goalradius = level.var_2497;
}

//Function Number: 78
func_3D5F(param_00,param_01,param_02)
{
	foreach(var_04 in level.players)
	{
		if(distancesquared(var_04.origin,param_00.origin) < distancesquared(self.origin,param_00.origin))
		{
			return 1;
		}
	}

	var_06 = anglestoforward(self.angles);
	if(isdefined(param_00.target))
	{
		var_07 = [[ param_01 ]](param_00.target);
		if(var_07.size == 1)
		{
			var_06 = vectornormalize(var_07[0].origin - param_00.origin);
		}
		else if(isdefined(param_00.angles))
		{
			var_06 = anglestoforward(param_00.angles);
		}
	}
	else if(isdefined(param_00.angles))
	{
		var_06 = anglestoforward(param_00.angles);
	}

	var_08 = [];
	foreach(var_04 in level.players)
	{
		var_08[var_08.size] = vectornormalize(var_04.origin - self.origin);
	}

	foreach(var_0C in var_08)
	{
		if(vectordot(var_06,var_0C) > 0)
		{
			return 1;
		}
	}

	var_0E = param_02 * param_02;
	foreach(var_04 in level.players)
	{
		if(distancesquared(var_04.origin,self.origin) < var_0E)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 79
func_3D5B(param_00)
{
	if(param_00.classname == "info_volume")
	{
		self setgoalvolumeauto(param_00);
		self notify("go_to_node_new_goal");
	}

	func_3D5D(param_00);
}

//Function Number: 80
func_3D5D(param_00)
{
	maps\_utility::func_6EF4(param_00);
	self notify("go_to_node_new_goal");
}

//Function Number: 81
go_to_node_set_goal_node(param_00)
{
	maps\_utility::func_6EF9(param_00);
	self notify("go_to_node_new_goal");
}

//Function Number: 82
func_7F6D(param_00)
{
	if(!isdefined(param_00.target))
	{
		return 0;
	}

	var_01 = getentarray(param_00.target,"targetname");
	if(!var_01.size)
	{
		return 0;
	}

	var_02 = var_01[0];
	if(var_02.classname != "misc_turret")
	{
		return 0;
	}

	thread func_8774(var_02);
	return 1;
}

//Function Number: 83
func_6517(param_00)
{
	waittillframeend;
	if(isdefined(param_00))
	{
		param_00.var_2058 = undefined;
	}
}

//Function Number: 84
crawl_target_and_init_flags(param_00,param_01)
{
	var_02 = 0;
	var_03 = [];
	var_04 = 0;
	for(;;)
	{
		if(!isdefined(param_00.var_2058))
		{
			param_00.var_2058 = 1;
			level thread func_6517(param_00);
			if(isdefined(param_00.script_flag_set))
			{
				if(!isdefined(level.flag[param_00.script_flag_set]))
				{
					common_scripts\utility::func_3385(param_00.script_flag_set);
				}
			}

			if(isdefined(param_00.var_6BC4))
			{
				if(!isdefined(level.flag[param_00.var_6BC4]))
				{
					common_scripts\utility::func_3385(param_00.var_6BC4);
				}
			}

			if(isdefined(param_00.script_flag_clear))
			{
				if(!isdefined(level.flag[param_00.script_flag_clear]))
				{
					common_scripts\utility::func_3385(param_00.script_flag_clear);
				}
			}

			if(isdefined(param_00.target))
			{
				var_05 = [[ param_01 ]](param_00.target);
				var_03 = common_scripts\utility::add_to_array(var_03,var_05);
			}
		}

		var_04++;
		if(var_04 >= var_03.size)
		{
			break;
		}

		param_00 = var_03[var_04];
	}
}

//Function Number: 85
get_node_funcs_based_on_target(param_00,param_01)
{
	var_02["entity"] = ::get_target_ents;
	var_02["node"] = ::func_39C3;
	var_02["struct"] = ::func_39C4;
	var_03["entity"] = ::func_3D5B;
	var_03["struct"] = ::func_3D5D;
	var_03["node"] = ::go_to_node_set_goal_node;
	if(!isdefined(param_01))
	{
		param_01 = "node";
	}

	var_04 = [];
	if(isdefined(param_00))
	{
		var_04["destination"][0] = param_00;
	}
	else
	{
		param_00 = getentarray(self.target,"targetname");
		if(param_00.size > 0)
		{
			param_01 = "entity";
		}

		if(param_01 == "node")
		{
			param_00 = getnodearray(self.target,"targetname");
			if(!param_00.size)
			{
				param_00 = common_scripts\utility::func_3C1A(self.target,"targetname");
				if(!param_00.size)
				{
				}

				param_01 = "struct";
			}
		}

		var_04["destination"] = param_00;
	}

	var_04["get_target_func"] = var_02[param_01];
	var_04["set_goal_func_quits"] = var_03[param_01];
	return var_04;
}

//Function Number: 86
func_6EF8()
{
	if(isdefined(self.var_6BEA))
	{
		self.goalheight = self.var_6BEA;
	}

	self.goalheight = level.default_goalheight;
}

//Function Number: 87
set_goal_from_settings(param_00)
{
	if(isdefined(self.script_radius))
	{
		self.goalradius = self.script_radius;
	}

	if(isdefined(self.var_6BD2))
	{
		if(isdefined(param_00) && isdefined(param_00.radius))
		{
			self.goalradius = param_00.radius;
		}
	}

	if(!isdefined(self getgoalvolume()))
	{
		if(self.type == "civilian")
		{
			self.goalradius = 128;
		}

		self.goalradius = level.var_2497;
	}
}

//Function Number: 88
autotarget(param_00)
{
	for(;;)
	{
		var_01 = self getturretowner();
		if(!isalive(var_01))
		{
			wait(1.5);
			continue;
		}

		if(!isdefined(var_01.enemy))
		{
			self settargetentity(common_scripts\utility::func_6306(param_00));
			self notify("startfiring");
			self startfiring();
		}

		wait(2 + randomfloat(1));
	}
}

//Function Number: 89
func_5094(param_00)
{
	for(;;)
	{
		self settargetentity(common_scripts\utility::func_6306(param_00));
		self notify("startfiring");
		self startfiring();
		wait(2 + randomfloat(1));
	}
}

//Function Number: 90
func_8774(param_00)
{
	if(self isbadguy() && self.health == 150)
	{
		self.health = 100;
		self.a.disablelongdeath = 1;
	}

	self useturret(param_00);
	if(isdefined(param_00.target) && param_00.target != param_00.targetname)
	{
		var_01 = getentarray(param_00.target,"targetname");
		var_02 = [];
		for(var_03 = 0;var_03 < var_01.size;var_03++)
		{
			if(var_01[var_03].classname == "script_origin")
			{
				var_02[var_02.size] = var_01[var_03];
			}
		}

		if(isdefined(param_00.var_6B48))
		{
			param_00 thread autotarget(var_02);
		}
		else if(isdefined(param_00.var_6C15))
		{
			param_00 setmode("manual_ai");
			param_00 thread func_5094(var_02);
		}
		else if(var_02.size > 0)
		{
			if(var_02.size == 1)
			{
				param_00.var_508F = var_02[0];
				param_00 settargetentity(var_02[0]);
				thread maps\_mgturret::func_5090(param_00);
			}
			else
			{
				param_00 thread maps\_mgturret::mg42_suppressionfire(var_02);
			}
		}
	}

	thread maps\_mgturret::func_51F5(param_00);
	param_00 notify("startfiring");
}

//Function Number: 91
func_31C7(param_00,param_01)
{
	self endon("death");
	level.current_fallbackers[param_00] = level.current_fallbackers[param_00] + self.count;
	var_02 = 1;
	while(self.count > 0)
	{
		self waittill("spawned",var_03);
		if(var_02)
		{
			if(getdvar("fallback","0") == "1")
			{
			}

			level notify("fallback_firstspawn" + param_00);
			var_02 = 0;
		}

		common_scripts\utility::func_8AFE();
		if(maps\_utility::func_77BE(var_03))
		{
			level notify("fallbacker_died" + param_00);
			level.current_fallbackers[param_00]--;
			continue;
		}

		var_03 thread fallback_ai_think(param_00,param_01,"is spawner");
	}
}

//Function Number: 92
func_31C1(param_00,param_01)
{
	param_00 waittill("death");
	level.current_fallbackers[param_01]--;
	level notify("fallbacker_died" + param_01);
}

//Function Number: 93
fallback_ai_think(param_00,param_01,param_02)
{
	if(!isdefined(self.var_31BE) || !isdefined(self.var_31BE[param_00]))
	{
		self.var_31BE[param_00] = 1;
	}
	else
	{
	}

	self.var_6BB0 = param_00;
	if(!isdefined(param_02))
	{
		level.current_fallbackers[param_00]++;
	}

	if(isdefined(param_01) && level.fallback_initiated[param_00])
	{
		thread fallback_ai(param_00,param_01);
	}

	level thread func_31C1(self,param_00);
}

//Function Number: 94
func_31C3(param_00,param_01)
{
	param_00 waittill("death");
	level notify("fallback_reached_goal" + param_01);
}

//Function Number: 95
func_31C4()
{
	self waittill("goal");
	self.ignoresuppression = 0;
	self notify("fallback_notify");
	self notify("stop_coverprint");
}

//Function Number: 96
fallback_ai(param_00,param_01)
{
	self notify("stop_going_to_node");
	self stopuseturret();
	self.ignoresuppression = 1;
	self setgoalnode(param_01);
	if(func_5644(param_01))
	{
		self.goalradius = param_01.radius;
	}

	self endon("death");
	level thread func_31C3(self,param_00);
	thread func_31C4();
	if(getdvar("fallback","0") == "1")
	{
		thread func_1FCD(param_01.origin);
	}

	self waittill("fallback_notify");
	level notify("fallback_reached_goal" + param_00);
}

//Function Number: 97
func_1FCD(param_00)
{
	self endon("fallback_notify");
	self endon("stop_coverprint");
	common_scripts\utility::func_8AFE();
}

//Function Number: 98
newfallback_overmind(param_00,param_01)
{
	var_02 = undefined;
	var_03 = getallnodes();
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		if(isdefined(var_03[var_04].var_6BB0) && var_03[var_04].var_6BB0 == param_00)
		{
			var_02 = common_scripts\utility::add_to_array(var_02,var_03[var_04]);
		}
	}

	if(!isdefined(var_02))
	{
	}

	level.current_fallbackers[param_00] = 0;
	level.var_7871[param_00] = 0;
	level.fallback_initiated[param_00] = 0;
	var_05 = getspawnerarray();
	for(var_04 = 0;var_04 < var_05.size;var_04++)
	{
		if(isdefined(var_05[var_04].var_6BB0) && var_05[var_04].var_6BB0 == param_00)
		{
			if(var_05[var_04].count > 0)
			{
				var_05[var_04] thread func_31C7(param_00,var_02[randomint(var_02.size)]);
				level.var_7871[param_00]++;
			}
		}
	}

	var_06 = getaiarray();
	for(var_04 = 0;var_04 < var_06.size;var_04++)
	{
		if(isdefined(var_06[var_04].var_6BB0) && var_06[var_04].var_6BB0 == param_00)
		{
			var_06[var_04] thread fallback_ai_think(param_00);
		}
	}

	if(!level.current_fallbackers[param_00] && !level.var_7871[param_00])
	{
	}

	var_05 = undefined;
	var_06 = undefined;
	thread func_31CA(param_00,param_01);
	level waittill("fallbacker_trigger" + param_00);
	if(getdvar("fallback","0") == "1")
	{
	}

	level.fallback_initiated[param_00] = 1;
	var_07 = undefined;
	var_06 = getaiarray();
	for(var_04 = 0;var_04 < var_06.size;var_04++)
	{
		if((isdefined(var_06[var_04].var_6BB0) && var_06[var_04].var_6BB0 == param_00) || isdefined(var_06[var_04].var_6BB1) && isdefined(param_01) && var_06[var_04].var_6BB1 == param_01)
		{
			var_07 = common_scripts\utility::add_to_array(var_07,var_06[var_04]);
		}
	}

	var_06 = undefined;
	if(!isdefined(var_07))
	{
	}

	var_08 = var_07.size * 0.4;
	var_08 = int(var_08);
	level notify("fallback initiated " + param_00);
	fallback_text(var_07,0,var_08);
	for(var_04 = 0;var_04 < var_08;var_04++)
	{
		var_07[var_04] thread fallback_ai(param_00,var_02[randomint(var_02.size)]);
	}

	for(var_04 = 0;var_04 < var_08;var_04++)
	{
		level waittill("fallback_reached_goal" + param_00);
	}

	fallback_text(var_07,var_08,var_07.size);
	for(var_04 = var_08;var_04 < var_07.size;var_04++)
	{
		if(isalive(var_07[var_04]))
		{
			var_07[var_04] thread fallback_ai(param_00,var_02[randomint(var_02.size)]);
		}
	}
}

//Function Number: 99
fallback_text(param_00,param_01,param_02)
{
	if(gettime() <= level._nextcoverprint)
	{
	}

	var_03 = param_01;
	while(var_03 < param_02)
	{
		if(!isalive(param_00[var_03]))
		{
			continue;
		}

		level._nextcoverprint = gettime() + 2500 + randomint(2000);
		var_04 = param_00.size;
		var_05 = int(var_04 * 0.4);
		if(randomint(100) > 50)
		{
			if(var_04 - var_05 > 1)
			{
				if(randomint(100) > 66)
				{
					var_06 = "dawnville_defensive_german_1";
				}
				else if(randomint(100) > 66)
				{
					var_06 = "dawnville_defensive_german_2";
				}
				else
				{
					var_06 = "dawnville_defensive_german_3";
				}
			}
			else if(randomint(100) > 66)
			{
				var_06 = "dawnville_defensive_german_4";
			}
			else if(randomint(100) > 66)
			{
				var_06 = "dawnville_defensive_german_5";
			}
			else
			{
				var_06 = "dawnville_defensive_german_1";
			}
		}
		else if(var_06 > 1)
		{
			if(randomint(100) > 66)
			{
				var_06 = "dawnville_defensive_german_2";
			}
			else if(randomint(100) > 66)
			{
				var_06 = "dawnville_defensive_german_3";
			}
			else
			{
				var_06 = "dawnville_defensive_german_4";
			}
		}
		else if(randomint(100) > 66)
		{
			var_06 = "dawnville_defensive_german_5";
		}
		else if(randomint(100) > 66)
		{
			var_06 = "dawnville_defensive_german_1";
		}
		else
		{
			var_06 = "dawnville_defensive_german_2";
		}

		param_00[var_03] animscripts/face::func_6AB5(undefined,var_06,1);
		var_06++;
	}
}

//Function Number: 100
func_31CA(param_00,param_01)
{
	level endon("fallbacker_trigger" + param_00);
	if(getdvar("fallback","0") == "1")
	{
	}

	for(var_02 = 0;var_02 < level.var_7871[param_00];var_02++)
	{
		if(getdvar("fallback","0") == "1")
		{
		}

		level waittill("fallback_firstspawn" + param_00);
	}

	if(getdvar("fallback","0") == "1")
	{
	}

	var_03 = getaiarray();
	for(var_02 = 0;var_02 < var_03.size;var_02++)
	{
		if((isdefined(var_03[var_02].var_6BB0) && var_03[var_02].var_6BB0 == param_00) || isdefined(var_03[var_02].var_6BB1) && isdefined(param_01) && var_03[var_02].var_6BB1 == param_01)
		{
			var_03[var_02] thread fallback_ai_think(param_00);
		}
	}

	var_03 = undefined;
	var_04 = level.current_fallbackers[param_00];
	for(var_05 = 0;level.current_fallbackers[param_00] > var_04 * 0.5;var_05++)
	{
		if(getdvar("fallback","0") == "1")
		{
		}

		level waittill("fallbacker_died" + param_00);
	}

	level notify("fallbacker_trigger" + param_00);
}

//Function Number: 101
func_31C9(param_00)
{
	if(!isdefined(level.var_31BE) || !isdefined(level.var_31BE[param_00.var_6BB0]))
	{
		level thread newfallback_overmind(param_00.var_6BB0,param_00.var_6BB1);
	}

	param_00 waittill("trigger");
	level notify("fallbacker_trigger" + param_00.var_6BB0);
	kill_trigger(param_00);
}

//Function Number: 102
arrive(param_00)
{
	self waittill("goal");
	if(func_5644(param_00))
	{
		self.goalradius = param_00.radius;
	}

	self.goalradius = level.var_2497;
}

//Function Number: 103
fallback_coverprint()
{
	self endon("fallback");
	self endon("fallback_clear_goal");
	self endon("fallback_clear_death");
	for(;;)
	{
		if(isdefined(self.var_1FCB))
		{
		}

		common_scripts\utility::func_8AFE();
	}
}

//Function Number: 104
func_31C6()
{
	self endon("fallback_clear_goal");
	self endon("fallback_clear_death");
	for(;;)
	{
		if(isdefined(self.var_1FCB))
		{
		}

		common_scripts\utility::func_8AFE();
	}
}

//Function Number: 105
func_31BE()
{
	var_00 = getnode(self.target,"targetname");
	self.var_1FCB = var_00;
	self setgoalnode(var_00);
	if(isdefined(self.var_6C95))
	{
		thread arrive(var_00);
	}
	else if(func_5644(var_00))
	{
		self.goalradius = var_00.radius;
	}
	else
	{
		self.goalradius = level.var_2497;
	}

	for(;;)
	{
		self waittill("fallback");
		self.interval = 20;
		level thread func_31C3(self);
		if(getdvar("fallback","0") == "1")
		{
			thread func_31C6();
		}

		if(isdefined(var_00.target))
		{
			var_00 = getnode(var_00.target,"targetname");
			self.var_1FCB = var_00;
			self setgoalnode(var_00);
			thread func_31C4();
			if(func_5644(var_00))
			{
				self.goalradius = var_00.radius;
			}

			continue;
		}

		level notify("fallback_arrived" + self.var_6BB0);
	}
}

//Function Number: 106
delete_me()
{
	common_scripts\utility::func_8AFE();
	self delete();
}

//Function Number: 107
func_8A22(param_00,param_01)
{
	var_02 = param_00[0] - param_01[0];
	var_03 = param_00[1] - param_01[1];
	var_04 = param_00[2] - param_01[2];
	var_02 = var_02 * var_02;
	var_03 = var_03 * var_03;
	var_04 = var_04 * var_04;
	var_05 = var_02 + var_03 + var_04;
	return var_05;
}

//Function Number: 108
specialcheck(param_00)
{
	wait(0.05);
}

//Function Number: 109
func_3569(param_00)
{
	if(!isdefined(level.var_356A))
	{
		thread friendly_wave_masterthread();
	}

	for(;;)
	{
		param_00 waittill("trigger");
		level notify("friendly_died");
		if(param_00.targetname == "friendly_wave")
		{
			level.friendly_wave_trigger = param_00;
		}
		else
		{
			level.friendly_wave_trigger = undefined;
		}

		wait(1);
	}
}

//Function Number: 110
func_6F97(param_00)
{
	if(!isdefined(self.target))
	{
	}

	var_01 = getentarray(self.target,"targetname");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_01[var_02] maps\_utility::func_6E67(param_00);
	}
}

//Function Number: 111
func_3572()
{
	if(!isdefined(level.var_8183))
	{
		level.var_8183 = 0;
	}

	level.var_8183++;
	self waittill("death");
	level notify("friendly_died");
	level.var_8183--;
}

//Function Number: 112
friendly_wave_masterthread()
{
	level.var_356A = 1;
	var_00 = getentarray("friendly_wave","targetname");
	common_scripts\utility::func_F1B(var_00,::func_6F97,0);
	if(!isdefined(level.var_5103))
	{
		level.var_5103 = 7;
	}

	var_01 = 1;
	for(;;)
	{
		if(isdefined(level.friendly_wave_trigger) && isdefined(level.friendly_wave_trigger.target))
		{
			var_02 = level.friendly_wave_trigger;
			var_03 = getentarray(level.friendly_wave_trigger.target,"targetname");
			if(!var_03.size)
			{
				level waittill("friendly_died");
				continue;
			}

			var_04 = 0;
			var_05 = isdefined(level.friendly_wave_trigger.script_delay);
			while(isdefined(level.friendly_wave_trigger) && level.var_8183 < level.var_5103)
			{
				if(var_02 != level.friendly_wave_trigger)
				{
					var_05 = isdefined(level.friendly_wave_trigger.script_delay);
					var_02 = level.friendly_wave_trigger;
					var_03 = getentarray(level.friendly_wave_trigger.target,"targetname");
				}
				else if(!var_05)
				{
					var_04 = randomint(var_03.size);
				}
				else if(var_04 == var_03.size)
				{
					var_04 = 0;
				}

				var_03[var_04] maps\_utility::func_6E67(1);
				var_06 = isdefined(var_03[var_04].var_6CC2) && common_scripts\utility::flag("_stealth_enabled") && !common_scripts\utility::flag("_stealth_spotted");
				if(isdefined(var_03[var_04].var_6BD5))
				{
					var_07 = var_03[var_04] stalingradspawn(var_06);
				}
				else
				{
					var_07 = var_03[var_04] dospawn(var_06);
				}

				var_03[var_04] maps\_utility::func_6E67(0);
				if(maps\_utility::func_77BE(var_07))
				{
					wait(0.2);
					continue;
				}

				if(isdefined(var_03[var_04].var_6B6B))
				{
					if(var_03[var_04].combatbehavior == "heat")
					{
						var_07 maps\_utility::func_2CB6();
					}

					if(var_03[var_04].combatbehavior == "cqb")
					{
						var_07 maps\_utility::enable_cqbwalk();
					}
				}

				if(isdefined(level.friendlywave_thread))
				{
					level thread [[ level.friendlywave_thread ]](var_07);
				}
				else
				{
					var_07 setgoalentity(level.player);
				}

				if(var_05)
				{
					if(level.friendly_wave_trigger.script_delay == 0)
					{
						waittillframeend;
					}
					else
					{
						wait(level.friendly_wave_trigger.script_delay);
					}

					var_04++;
					continue;
				}

				wait(randomfloat(5));
			}
		}

		level waittill("friendly_died");
	}
}

//Function Number: 113
friendly_mgturret(param_00)
{
	var_01 = getnode(param_00.target,"targetname");
	var_02 = getent(var_01.target,"targetname");
	var_02 setmode("auto_ai");
	var_02 cleartargetentity();
	var_03 = 0;
	for(;;)
	{
		param_00 waittill("trigger",var_04);
		if(!isai(var_04))
		{
			continue;
		}

		if(!isdefined(var_04.team))
		{
			continue;
		}

		if(var_04.team != "allies")
		{
			continue;
		}

		if(isdefined(var_04.var_6CEA) && var_04.var_6CEA == 0)
		{
			continue;
		}

		if(var_04 thread func_3549(var_02,var_01))
		{
			var_04 thread func_3548(var_02,var_01);
			var_02 waittill("friendly_finished_using_mg42");
			if(isalive(var_04))
			{
				var_04.var_851B = gettime() + 10000;
			}
		}

		wait(1);
	}
}

//Function Number: 114
func_3544(param_00,param_01)
{
	param_01 endon("friendly_finished_using_mg42");
	param_00 waittill("death");
	param_01 notify("friendly_finished_using_mg42");
}

//Function Number: 115
func_354A(param_00)
{
	param_00 endon("friendly_finished_using_mg42");
	self.useable = 1;
	self setcursorhint("HINT_NOICON");
	self sethintstring(&"PLATFORM_USEAIONMG42");
	self waittill("trigger");
	self.useable = 0;
	self sethintstring("");
	self stopuseturret();
	self notify("stopped_use_turret");
	param_00 notify("friendly_finished_using_mg42");
}

//Function Number: 116
func_3549(param_00,param_01)
{
	if(self.useable)
	{
		return 0;
	}

	if(isdefined(self.var_851B) && gettime() < self.var_851B)
	{
		return 0;
	}

	if(distance(level.player.origin,param_01.origin) < 100)
	{
		return 0;
	}

	return 1;
}

//Function Number: 117
friendly_mg42_endtrigger(param_00,param_01)
{
	param_00 endon("friendly_finished_using_mg42");
	self waittill("trigger");
	param_00 notify("friendly_finished_using_mg42");
}

//Function Number: 118
func_3547()
{
	if(!isdefined(self.var_3542))
	{
	}

	self.var_3542 notify("friendly_finished_using_mg42");
}

//Function Number: 119
nofour()
{
	self endon("death");
	self waittill("goal");
	self.goalradius = self.oldradius;
	if(self.goalradius < 32)
	{
		self.goalradius = 400;
	}
}

//Function Number: 120
func_3548(param_00,param_01)
{
	self endon("death");
	param_00 endon("friendly_finished_using_mg42");
	level thread func_3544(self,param_00);
	self.oldradius = self.goalradius;
	self.goalradius = 28;
	thread nofour();
	self setgoalnode(param_01);
	self.ignoresuppression = 1;
	self waittill("goal");
	self.goalradius = self.oldradius;
	if(self.goalradius < 32)
	{
		self.goalradius = 400;
	}

	self.ignoresuppression = 0;
	self.goalradius = self.oldradius;
	if(distance(level.player.origin,param_01.origin) < 32)
	{
		param_00 notify("friendly_finished_using_mg42");
	}

	self.var_3542 = param_00;
	thread func_354A(param_00);
	thread func_3543(param_00);
	self useturret(param_00);
	if(isdefined(param_00.target))
	{
		var_02 = getent(param_00.target,"targetname");
		if(isdefined(var_02))
		{
			var_02 thread friendly_mg42_endtrigger(param_00,self);
		}
	}

	for(;;)
	{
		if(distance(self.origin,param_01.origin) < 32)
		{
			self useturret(param_00);
		}
		else
		{
			break;
		}

		wait(1);
	}

	param_00 notify("friendly_finished_using_mg42");
}

//Function Number: 121
func_3543(param_00)
{
	self endon("death");
	param_00 waittill("friendly_finished_using_mg42");
	friendly_mg42_doneusingturret();
}

//Function Number: 122
friendly_mg42_doneusingturret()
{
	self endon("death");
	var_00 = self.var_3542;
	self.var_3542 = undefined;
	self stopuseturret();
	self notify("stopped_use_turret");
	self.useable = 0;
	self.goalradius = self.oldradius;
	if(!isdefined(var_00))
	{
	}

	if(!isdefined(var_00.target))
	{
	}

	var_01 = getnode(var_00.target,"targetname");
	var_02 = self.goalradius;
	self.goalradius = 8;
	self setgoalnode(var_01);
	wait(2);
	self.goalradius = 384;
	self waittill("goal");
	if(isdefined(self.target))
	{
		var_01 = getnode(self.target,"targetname");
		if(isdefined(var_01.target))
		{
			var_01 = getnode(var_01.target,"targetname");
		}

		if(isdefined(var_01))
		{
			self setgoalnode(var_01);
		}
	}

	self.goalradius = var_02;
}

//Function Number: 123
func_7F35()
{
	if(isdefined(level.var_568B))
	{
	}

	if(isdefined(level.levelhasvehicles) && !level.levelhasvehicles)
	{
	}

	maps\_utility::add_damage_function(::func_7F36);
}

//Function Number: 124
func_7F36(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(self))
	{
	}

	if(isalive(self))
	{
	}

	if(!isalive(param_01))
	{
	}

	if(!isdefined(param_01.vehicletype))
	{
	}

	if(param_01 maps\_vehicle::ishelicopter())
	{
	}

	if(!isdefined(self.var_5674))
	{
		self startragdoll();
	}

	if(!isdefined(self))
	{
	}

	maps\_utility::func_6518(::func_7F36);
}

//Function Number: 125
func_5AD2(param_00,param_01,param_02,param_03,param_04)
{
	param_00 endon("death");
	param_00.var_5AD0 = param_01;
	if(isdefined(param_01.script_delay))
	{
		param_00.var_5ACD = param_01.script_delay;
	}

	if(isdefined(param_03) && isdefined(param_04))
	{
		param_00.var_5ACE = param_03;
		param_00.var_5ACF = param_04;
	}
	else
	{
		param_00.var_5AD1 = param_02;
	}

	param_00 setgoalpos(param_00.origin);
	param_00 setgoalnode(param_01);
	param_00.goalradius = 12;
	param_00 waittill("goal");
	param_00.goalradius = 28;
	param_00 waittill("shot_at_target");
	param_00.var_5ACE = undefined;
	param_00.var_5AD1 = undefined;
	param_00.var_5ACD = undefined;
}

//Function Number: 126
func_7523(param_00,param_01,param_02)
{
	var_03 = getstartorigin(param_00,param_01,param_02);
	wait(0.05);
}

//Function Number: 127
spawnwaypointfriendlies()
{
	maps\_utility::func_6E67(1);
	if(isdefined(self.var_6BD5))
	{
		var_00 = self stalingradspawn();
	}
	else
	{
		var_00 = self dospawn();
	}

	if(maps\_utility::func_77BE(var_00))
	{
	}

	if(isdefined(self.var_6B6B))
	{
		if(self.var_6B6B == "heat")
		{
			var_00 maps\_utility::func_2CB6();
		}

		if(self.var_6B6B == "cqb")
		{
			var_00 maps\_utility::enable_cqbwalk();
		}
	}

	var_00.friendlywaypoint = 1;
}

//Function Number: 128
func_8BB2()
{
	self endon("death");
	self waittill("leaveSquad");
}

//Function Number: 129
friendlyspawnwave()
{
	common_scripts\utility::func_F1B(getentarray(self.target,"targetname"),::friendlyspawnwave_triggerthink,self);
	for(;;)
	{
		self waittill("trigger",var_02);
		if(func_0856() && func_3AB7() == self)
		{
			func_8621();
		}

		self waittill("friendly_wave_start",var_03);
		func_703D(var_03,self);
		if(!isdefined(var_03.target))
		{
			continue;
		}

		var_04 = getent(var_03.target,"targetname");
		var_04 thread func_78C6(self);
	}
}

//Function Number: 130
func_3437(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "instant_respawn")
	{
		param_00 = 1;
	}

	level.var_787A = [];
	var_01 = getentarray(self.target,"targetname");
	common_scripts\utility::func_F1B(var_01,::flood_and_secure_spawner,param_00);
	var_02 = 0;
	var_03 = 0;
	for(;;)
	{
		self waittill("trigger",var_04);
		if(!func_57DA())
		{
			continue;
		}

		if(!var_03)
		{
			var_03 = 1;
			maps\_utility::script_delay();
		}

		if(self istouching(level.player))
		{
			var_02 = 1;
		}
		else
		{
			if(!isalive(var_04))
			{
				continue;
			}

			if(isplayer(var_04))
			{
				var_02 = 1;
			}
			else if(!isdefined(var_04.var_496D) || !var_04.var_496D)
			{
				continue;
			}
		}

		var_01 = getentarray(self.target,"targetname");
		if(isdefined(var_01[0]))
		{
			if(isdefined(var_01[0].var_6C89))
			{
				cull_spawners_from_killspawner(var_01[0].var_6C89);
			}
		}

		var_01 = getentarray(self.target,"targetname");
		for(var_05 = 0;var_05 < var_01.size;var_05++)
		{
			var_01[var_05].var_5FE8 = var_02;
			var_01[var_05] notify("flood_begin");
		}

		if(var_02)
		{
			wait(5);
			continue;
		}

		wait(0.1);
	}
}

//Function Number: 131
func_2190(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_01[param_00[var_02].var_6C89] = 1;
	}

	var_03 = getarraykeys(var_01);
	var_04 = common_scripts\utility::func_6306(var_03);
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		if(param_00[var_02].var_6C89 != var_04)
		{
			param_00[var_02] delete();
		}
	}
}

//Function Number: 132
flood_and_secure_spawner(param_00)
{
	if(isdefined(self.var_6D5C))
	{
	}

	self.var_6D5C = 1;
	self.var_83BF = 1;
	var_01 = self.target;
	var_02 = self.targetname;
	if(!isdefined(var_01) && !isdefined(self.var_6C36))
	{
		waittillframeend;
	}

	var_03 = [];
	if(isdefined(var_01))
	{
		var_04 = getentarray(var_01,"targetname");
		for(var_05 = 0;var_05 < var_04.size;var_05++)
		{
			if(!issubstr(var_04[var_05].classname,"actor"))
			{
				continue;
			}

			var_03[var_03.size] = var_04[var_05];
		}
	}

	var_06 = spawnstruct();
	var_07 = self.origin;
	flood_and_secure_spawner_think(var_06,var_03.size > 0,param_00);
	if(isalive(var_06.var_9D6))
	{
		var_06.var_9D6 waittill("death");
	}

	if(!isdefined(var_01))
	{
	}

	var_04 = getentarray(var_01,"targetname");
	if(!var_04.size)
	{
	}

	for(var_05 = 0;var_05 < var_04.size;var_05++)
	{
		if(!issubstr(var_04[var_05].classname,"actor"))
		{
			continue;
		}

		var_04[var_05].targetname = var_02;
		var_08 = var_01;
		if(isdefined(var_04[var_05].target))
		{
			var_09 = getent(var_04[var_05].target,"targetname");
			if(!isdefined(var_09) || !issubstr(var_09.classname,"actor"))
			{
				var_08 = var_04[var_05].target;
			}
		}

		var_04[var_05].target = var_08;
		var_04[var_05] thread flood_and_secure_spawner(param_00);
		var_04[var_05].var_5FE8 = 1;
		var_04[var_05] notify("flood_begin");
	}
}

//Function Number: 133
flood_and_secure_spawner_think(param_00,param_01,param_02)
{
	self endon("death");
	var_03 = self.count;
	if(!param_01)
	{
		param_01 = isdefined(self.script_noteworthy) && self.script_noteworthy == "delete";
	}

	maps\_utility::func_6E67(2);
	if(isdefined(self.script_delay))
	{
		var_04 = self.script_delay;
	}
	else
	{
		var_04 = 0;
	}

	for(;;)
	{
		self waittill("flood_begin");
		if(self.var_5FE8)
		{
			break;
		}

		if(var_04)
		{
			continue;
		}

		break;
	}

	var_05 = distance(level.player.origin,self.origin);
	while(var_03)
	{
		self.var_83E2 = var_03;
		maps\_utility::func_6E67(2);
		wait(var_04);
		var_06 = isdefined(self.var_6CC2) && common_scripts\utility::flag("_stealth_enabled") && !common_scripts\utility::flag("_stealth_spotted");
		if(isdefined(self.var_6BD5))
		{
			var_07 = self stalingradspawn(var_06);
		}
		else
		{
			var_07 = self dospawn(var_06);
		}

		if(maps\_utility::func_77BE(var_07))
		{
			var_08 = 0;
			if(var_04 < 2)
			{
				wait(2);
			}

			continue;
		}
		else
		{
			if(isdefined(self.var_6B6B))
			{
				if(self.var_6B6B == "heat")
				{
					var_07 maps\_utility::func_2CB6();
				}

				if(self.var_6B6B == "cqb")
				{
					var_07 maps\_utility::enable_cqbwalk();
				}
			}

			thread func_09A0(var_07);
			var_07 thread flood_and_secure_spawn(self);
			if(isdefined(self.var_6B1C))
			{
				var_07.baseaccuracy = self.var_6B1C;
			}

			param_00.var_9D6 = var_07;
			param_00 notify("got_ai");
			self waittill("spawn_died",var_09,var_08);
			if(var_04 > 2)
			{
				var_04 = randomint(4) + 2;
			}
			else
			{
				var_04 = 0.5 + randomfloat(0.5);
			}
		}

		if(var_09)
		{
			func_8BC0(var_05);
			continue;
		}

		if(func_5FFA(var_08 || param_01,param_00.var_9D6))
		{
			var_03--;
		}

		if(!param_02)
		{
			waituntilwaverelease();
		}
	}

	self delete();
}

//Function Number: 134
func_8BB4(param_00)
{
	self endon("death");
	param_00 waittill("death");
}

//Function Number: 135
func_09A0(param_00)
{
	var_01 = self.targetname;
	if(!isdefined(level.var_787A[var_01]))
	{
		level.var_787A[var_01] = spawnstruct();
		level.var_787A[var_01] maps\_utility::func_6E67(0);
		level.var_787A[var_01].var_8174 = 0;
	}

	if(!isdefined(self.addedtowave))
	{
		self.addedtowave = 1;
		level.var_787A[var_01].var_8174++;
	}

	level.var_787A[var_01].count++;
	func_8BB4(param_00);
	level.var_787A[var_01].count--;
	if(!isdefined(self))
	{
		level.var_787A[var_01].var_8174--;
	}

	if(level.var_787A[var_01].var_8174)
	{
		if(level.var_787A[var_01].count / level.var_787A[var_01].var_8174 < 0.32)
		{
			level.var_787A[var_01] notify("waveReady");
		}
	}
}

//Function Number: 136
func_2432(param_00)
{
	self endon("debug_stop");
	self endon("death");
	wait(0.05);
}

//Function Number: 137
waituntilwaverelease()
{
	var_00 = self.targetname;
	if(level.var_787A[var_00].count)
	{
		level.var_787A[var_00] waittill("waveReady");
	}
}

//Function Number: 138
func_5FFA(param_00,param_01)
{
	if(param_00)
	{
		return 1;
	}

	if(isdefined(param_01) && isdefined(param_01.origin))
	{
		var_02 = param_01.origin;
	}
	else
	{
		var_02 = self.origin;
	}

	if(distance(level.player.origin,var_02) < 700)
	{
		return 1;
	}

	return bullettracepassed(level.player geteye(),param_01 geteye(),0,undefined);
}

//Function Number: 139
func_8BC0(param_00)
{
	self endon("flood_begin");
	param_00 = param_00 * 0.75;
	while(distance(level.player.origin,self.origin) > param_00)
	{
		wait(1);
	}
}

//Function Number: 140
flood_and_secure_spawn(param_00)
{
	thread flood_and_secure_spawn_goal();
	self waittill("death",var_01);
	var_02 = isalive(var_01) && isplayer(var_01);
	if(!var_02 && isdefined(var_01) && var_01.classname == "worldspawn")
	{
		var_02 = 1;
	}

	var_03 = !isdefined(self);
	param_00 notify("spawn_died",var_03,var_02);
}

//Function Number: 141
flood_and_secure_spawn_goal()
{
	if(isdefined(self.var_6C36))
	{
	}

	self endon("death");
	var_00 = getnode(self.target,"targetname");
	if(isdefined(var_00))
	{
		self setgoalnode(var_00);
	}
	else
	{
		var_00 = getent(self.target,"targetname");
		if(isdefined(var_00))
		{
			self setgoalpos(var_00.origin);
		}
	}

	if(isdefined(level.fightdist))
	{
		self.pathenemyfightdist = level.fightdist;
		self.pathenemylookahead = level.var_50F9;
	}

	if(isdefined(var_00.radius) && var_00.radius >= 0)
	{
		self.goalradius = var_00.radius;
	}
	else
	{
		self.goalradius = 256;
	}

	self waittill("goal");
	while(isdefined(var_00.target))
	{
		var_01 = getnode(var_00.target,"targetname");
		if(isdefined(var_01))
		{
			var_00 = var_01;
		}
		else
		{
			break;
		}

		self setgoalnode(var_00);
		if(func_5644(var_00))
		{
			self.goalradius = var_00.radius;
		}
		else
		{
			self.goalradius = 256;
		}

		self waittill("goal");
	}

	if(isdefined(self.script_noteworthy))
	{
		if(self.script_noteworthy == "delete")
		{
			self kill();
		}
	}

	if(isdefined(var_00.target))
	{
		var_02 = getent(var_00.target,"targetname");
		if(isdefined(var_02) && var_02.code_classname == "misc_mgturret" || var_02.code_classname == "misc_turret")
		{
			self setgoalnode(var_00);
			self.goalradius = 4;
			self waittill("goal");
			if(!isdefined(self.var_6BD2))
			{
				self.goalradius = level.var_2497;
			}

			func_8774(var_02);
		}
	}

	if(isdefined(self.script_noteworthy))
	{
		if(isdefined(self.var_6C64))
		{
			if(self.var_6C64 == "furniture_push")
			{
				thread furniturepushsound();
			}
		}

		if(self.script_noteworthy == "hide")
		{
			thread maps\_utility::func_6E54(0);
		}
	}

	if(!isdefined(self.var_6BD2) && !isdefined(self getgoalvolume()))
	{
		self.goalradius = level.var_2497;
	}
}

//Function Number: 142
furniturepushsound()
{
	var_00 = getent(self.target,"targetname").origin;
	common_scripts\utility::func_5D1F("furniture_slide",var_00);
	wait(0.9);
	if(isdefined(level.whisper))
	{
		common_scripts\utility::func_5D1F(common_scripts\utility::func_6306(level.whisper),var_00);
	}
}

//Function Number: 143
func_356D()
{
	waittillframeend;
	var_00 = getentarray(self.target,"targetname");
	if(!var_00.size)
	{
		var_01 = getnode(self.target,"targetname");
		for(;;)
		{
			self waittill("trigger");
			if(isdefined(level.var_4C65) && level.var_4C65 == self)
			{
				wait(0.5);
				continue;
			}

			if(!func_57DA())
			{
				wait(0.5);
				continue;
			}

			level notify("new_friendly_trigger");
			level.var_4C65 = self;
			var_02 = !isdefined(self.var_6B4E) || self.var_6B4E == 0;
			func_7078(var_01,var_02);
		}
	}

	for(;;)
	{
		self waittill("trigger");
		while(level.player istouching(self))
		{
			wait(0.05);
		}

		if(!func_57DA())
		{
			wait(0.05);
			continue;
		}

		if(isdefined(level.var_4C65) && level.var_4C65 == self)
		{
			continue;
		}

		level notify("new_friendly_trigger");
		level.var_4C65 = self;
		common_scripts\utility::func_F1B(var_00,::friendlytrigger);
		wait(0.5);
	}
}

//Function Number: 144
func_57DA()
{
	var_00 = 1;
	if(isdefined(self.var_6C6A))
	{
		var_00 = 0;
		for(var_01 = 0;var_01 < level.active_objective.size;var_01++)
		{
			if(!issubstr(self.var_6C6A,level.active_objective[var_01]))
			{
				continue;
			}

			var_00 = 1;
			break;
		}

		if(!var_00)
		{
			return 0;
		}
	}

	if(!isdefined(self.script_objective_inactive))
	{
		return var_00;
	}

	var_02 = 0;
	for(var_01 = 0;var_01 < level.var_4457.size;var_01++)
	{
		if(!issubstr(self.script_objective_inactive,level.var_4457[var_01]))
		{
			continue;
		}

		var_02++;
	}

	var_03 = strtok(self.script_objective_inactive," ");
	return var_02 == var_03.size;
}

//Function Number: 145
friendlytrigger(param_00)
{
	level endon("new_friendly_trigger");
	self waittill("trigger");
	param_00 = getnode(self.target,"targetname");
	var_01 = !isdefined(self.var_6B4E) || self.var_6B4E == 0;
	func_7078(param_00,var_01);
}

//Function Number: 146
func_8BB1()
{
	self endon("death");
	var_00 = self.script_deathchain;
	while(self.count)
	{
		self waittill("spawned",var_01);
		var_01 thread deathchainainotify(var_00);
	}
}

//Function Number: 147
deathchainainotify(param_00)
{
	level.var_2387[param_00]++;
	self waittill("death");
	level.var_2387[param_00]--;
	level notify("spawner_expired" + param_00);
}

//Function Number: 148
deathchainspawnerlogic()
{
	var_00 = self.script_deathchain;
	level.var_2387[var_00]++;
	var_01 = self.origin;
	func_8BB1();
	level notify("spawner dot" + var_01);
	level.var_2387[var_00]--;
	level notify("spawner_expired" + var_00);
}

//Function Number: 149
func_356E()
{
	var_00 = getentarray("friendly_chain_on_death","targetname");
	var_01 = getspawnerarray();
	level.var_2387 = [];
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(!isdefined(var_01[var_02].script_deathchain))
		{
			continue;
		}

		var_03 = var_01[var_02].script_deathchain;
		if(!isdefined(level.var_2387[var_03]))
		{
			level.var_2387[var_03] = 0;
		}

		var_01[var_02] thread deathchainspawnerlogic();
	}

	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		if(!isdefined(var_00[var_02].script_deathchain))
		{
		}

		var_00[var_02] thread func_356F();
	}
}

//Function Number: 150
func_356F()
{
	while(level.var_2387[self.script_deathchain] > 0)
	{
		level waittill("spawner_expired" + self.script_deathchain);
	}

	level endon("start_chain");
	var_00 = getnode(self.target,"targetname");
	for(;;)
	{
		self waittill("trigger");
		func_7078(var_00,1);
		iprintlnbold("Area secured, move up!");
		wait(5);
	}
}

//Function Number: 151
func_7078(param_00,param_01)
{
	level notify("new_escort_trigger");
	level notify("new_escort_debug");
	level notify("start_chain",param_01);
}

//Function Number: 152
friendlychains()
{
	level.friendlyspawnorg = [];
	level.var_358E = [];
	common_scripts\utility::func_F1B(getentarray("friendlychain","targetname"),::func_356D);
}

//Function Number: 153
func_8621()
{
	var_00 = [];
	var_01 = [];
	for(var_02 = 0;var_02 < level.friendlyspawnorg.size;var_02++)
	{
		var_00[var_00.size] = level.friendlyspawnorg[var_02];
		var_01[var_01.size] = level.var_358E[var_02];
	}

	level.friendlyspawnorg = var_00;
	level.var_358E = var_01;
	if(func_0856())
	{
	}

	common_scripts\utility::func_337C("spawning_friendlies");
}

//Function Number: 154
getfriendlyspawnstart()
{
	return level.friendlyspawnorg[level.friendlyspawnorg.size - 1];
}

//Function Number: 155
func_0856()
{
	return level.friendlyspawnorg.size > 0;
}

//Function Number: 156
func_3AB7()
{
	return level.var_358E[level.var_358E.size - 1];
}

//Function Number: 157
func_703D(param_00,param_01)
{
	level.friendlyspawnorg[level.friendlyspawnorg.size] = param_00.origin;
	level.var_358E[level.var_358E.size] = param_01;
	common_scripts\utility::flag_set("spawning_friendlies");
}

//Function Number: 158
func_2527()
{
	self endon("death");
	self endon("leaveSquad");
	wait(0.5);
	self setgoalentity(level.player);
}

//Function Number: 159
func_78C6(param_00)
{
	self notify("stopTrigger");
	self endon("stopTrigger");
	self waittill("trigger");
	if(func_3AB7() != param_00)
	{
	}

	func_8621();
}

//Function Number: 160
friendlyspawnwave_triggerthink(param_00)
{
	var_01 = getent(self.target,"targetname");
	for(;;)
	{
		self waittill("trigger");
		param_00 notify("friendly_wave_start",var_01);
		if(!isdefined(var_01.target))
		{
			continue;
		}
	}
}

//Function Number: 161
func_3D6E()
{
	var_00 = getentarray("info_volume","classname");
	level.deathchain_goalvolume = [];
	level.var_3D6E = [];
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_02 = var_00[var_01];
		if(isdefined(var_02.script_deathchain))
		{
			level.deathchain_goalvolume[var_02.script_deathchain] = var_02;
		}

		if(isdefined(var_02.script_goalvolume))
		{
			level.var_3D6E[var_02.script_goalvolume] = var_02;
		}
	}
}

//Function Number: 162
func_2429(param_00,param_01,param_02)
{
	if(1)
	{
	}

	var_03 = self getorigin();
	var_04 = 40 * sin(var_03[0] + var_03[1]) - 40;
	var_03 = (var_03[0],var_03[1],var_03[2] + var_04);
	level endon(param_01);
	self endon("new_color");
	if(!isdefined(param_02))
	{
		param_02 = (0,0.8,0.6);
	}

	var_05 = 0;
	for(;;)
	{
		var_05 = var_05 + 12;
		var_06 = sin(var_05) * 0.4;
		if(var_06 < 0)
		{
			var_06 = var_06 * -1;
		}

		var_06 = var_06 + 1;
		wait(0.05);
	}
}

//Function Number: 163
aigroup_create(param_00)
{
	level._ai_group[param_00] = spawnstruct();
	level._ai_group[param_00].aicount = 0;
	level._ai_group[param_00].var_7878 = 0;
	level._ai_group[param_00].var_9D6 = [];
	level._ai_group[param_00].var_7879 = [];
}

//Function Number: 164
aigroup_spawnerthink(param_00)
{
	self endon("death");
	self.var_2469 = 0;
	param_00.var_7878++;
	thread aigroup_spawnerdeath(param_00);
	thread aigroup_spawnerempty(param_00);
	while(self.count)
	{
		self waittill("spawned",var_01);
		if(maps\_utility::func_77BE(var_01))
		{
			continue;
		}

		var_01 thread aigroup_soldierthink(param_00);
	}

	waittillframeend;
	if(self.var_2469)
	{
	}

	self.var_2469 = 1;
	param_00.var_7878--;
}

//Function Number: 165
aigroup_spawnerdeath(param_00)
{
	self waittill("death");
	if(self.var_2469)
	{
	}

	param_00.var_7878--;
}

//Function Number: 166
aigroup_spawnerempty(param_00)
{
	self endon("death");
	self waittill("emptied spawner");
	waittillframeend;
	if(self.var_2469)
	{
	}

	self.var_2469 = 1;
	param_00.var_7878--;
}

//Function Number: 167
aigroup_soldierthink(param_00)
{
	param_00.aicount++;
	param_00.var_9D6[param_00.var_9D6.size] = self;
	if(isdefined(self.script_deathflag_longdeath))
	{
		func_8BB3();
	}
	else
	{
		self waittill("death");
	}

	param_00.aicount--;
}

//Function Number: 168
camper_trigger_think(param_00)
{
	var_01 = strtok(param_00.script_linkto," ");
	var_02 = [];
	var_03 = [];
	for(var_04 = 0;var_04 < var_01.size;var_04++)
	{
		var_05 = var_01[var_04];
		var_06 = getent(var_05,"script_linkname");
		if(isdefined(var_06))
		{
			var_02 = common_scripts\utility::add_to_array(var_02,var_06);
			continue;
		}

		var_07 = getnode(var_05,"script_linkname");
		if(!isdefined(var_07))
		{
			continue;
		}

		var_03 = common_scripts\utility::add_to_array(var_03,var_07);
	}

	param_00 waittill("trigger");
	var_03 = common_scripts\utility::array_randomize(var_03);
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		var_03[var_04].claimed = 0;
	}

	var_08 = 0;
	for(var_04 = 0;var_04 < var_02.size;var_04++)
	{
		var_09 = var_02[var_04];
		if(!isdefined(var_09))
		{
			continue;
		}

		if(isdefined(var_09.var_6CAD))
		{
			continue;
		}

		while(isdefined(var_03[var_08].script_noteworthy) && var_03[var_08].script_noteworthy == "dont_spawn")
		{
			var_08++;
		}

		var_09.origin = var_03[var_08].origin;
		var_09.angles = var_03[var_08].angles;
		var_09 maps\_utility::add_spawn_function(::func_1C90,var_03[var_08]);
		var_08++;
	}

	common_scripts\utility::func_F1B(var_02,::maps\_utility::add_spawn_function,::camper_guy);
	common_scripts\utility::func_F1B(var_02,::maps\_utility::add_spawn_function,::func_5470,var_03);
	common_scripts\utility::func_F1B(var_02,::maps\_utility::func_7766);
}

//Function Number: 169
camper_guy()
{
	self.goalradius = 8;
	self.fixednode = 1;
}

//Function Number: 170
func_5470(param_00)
{
	self endon("death");
	var_01 = 0;
	for(;;)
	{
		if(!isalive(self.enemy))
		{
			self waittill("enemy");
			var_01 = 0;
			continue;
		}

		if(isplayer(self.enemy))
		{
			if(self.enemy maps\_utility::ent_flag("player_has_red_flashing_overlay") || common_scripts\utility::flag("player_flashed"))
			{
				self.fixednode = 0;
				for(;;)
				{
					self.goalradius = 180;
					self setgoalpos(level.player.origin);
					wait(1);
				}
			}
		}

		if(var_01)
		{
			if(self cansee(self.enemy))
			{
				wait(0.05);
				continue;
			}

			var_01 = 0;
		}
		else
		{
			if(self cansee(self.enemy))
			{
				var_01 = 1;
			}

			wait(0.05);
			continue;
		}

		if(randomint(3) > 0)
		{
			var_02 = func_327B(param_00);
			if(isdefined(var_02))
			{
				func_1C90(var_02,self.claimed_node);
				self waittill("goal");
			}
		}
	}
}

//Function Number: 171
func_1C90(param_00,param_01)
{
	self setgoalnode(param_00);
	self.claimed_node = param_00;
	param_00.claimed = 1;
	if(isdefined(param_01))
	{
		param_01.claimed = 0;
	}
}

//Function Number: 172
func_327B(param_00)
{
	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		if(param_00[var_01].claimed)
		{
			continue;
		}
		else
		{
			return param_00[var_01];
		}
	}

	return undefined;
}

//Function Number: 173
func_3466(param_00)
{
	var_01 = getentarray(param_00.target,"targetname");
	common_scripts\utility::func_F1B(var_01,::func_3461);
	param_00 waittill("trigger");
	var_01 = getentarray(param_00.target,"targetname");
	common_scripts\utility::func_F1B(var_01,::flood_spawner_think,param_00);
}

//Function Number: 174
func_3461(param_00)
{
}

//Function Number: 175
func_8390(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	return isdefined(param_00.var_6C8C);
}

//Function Number: 176
func_854E(param_00)
{
	var_01 = getent(param_00.target,"targetname");
	waittillframeend;
	var_02 = getentarray(var_01.target,"targetname");
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_02[var_03].var_6C36 = 1;
		var_02[var_03] maps\_utility::add_spawn_function(::func_8AC0,var_01);
	}

	param_00 waittill("trigger");
	var_02 = getentarray(var_01.target,"targetname");
	common_scripts\utility::func_F1B(var_02,::maps\_utility::func_7766);
}

//Function Number: 177
func_8AC0(param_00)
{
	param_00 endon("death");
	self endon("death");
	self.goalradius = 8;
	param_00 waittill("trigger");
	thread go_to_node();
}

//Function Number: 178
flood_spawner_think(param_00)
{
	if(!isdefined(level.var_780E) || isspawner(self))
	{
		self endon("death");
	}

	self notify("stop current floodspawner");
	self endon("stop current floodspawner");
	if(func_4831())
	{
		func_625A(param_00);
	}

	var_01 = func_8390(param_00);
	maps\_utility::script_delay();
	if(isdefined(level.var_780E))
	{
		if(!isspawner(self))
		{
			self.count = 1;
		}
	}

	while(self.count > 0)
	{
		while(var_01 && !level.player istouching(param_00))
		{
			wait(0.5);
		}

		var_02 = isdefined(self.var_6CC2) && common_scripts\utility::flag("_stealth_enabled") && !common_scripts\utility::flag("_stealth_spotted");
		var_03 = self;
		if(isdefined(level.var_780E))
		{
			if(!isspawner(self))
			{
				var_03 = func_39A7(self,1);
			}
		}

		if(isdefined(self.var_6BD5))
		{
			var_04 = var_03 stalingradspawn(var_02);
		}
		else
		{
			var_04 = var_03 dospawn(var_02);
		}

		if(maps\_utility::func_77BE(var_04))
		{
			wait(2);
			continue;
		}

		if(isdefined(self.var_6B6B))
		{
			if(self.var_6B6B == "heat")
			{
				var_04 maps\_utility::func_2CB6();
			}

			if(self.var_6B6B == "cqb")
			{
				var_04 maps\_utility::enable_cqbwalk();
			}
		}

		var_04 thread reincrement_count_if_deleted(self);
		var_04 thread expand_goalradius(param_00);
		var_04 waittill("death",var_05);
		if(!player_saw_kill(var_04,var_05))
		{
			self.count++;
		}
		else if(isdefined(level.ac130_flood_respawn))
		{
			if(isdefined(level.ac130gunner) && var_05 == level.ac130gunner)
			{
				if(randomint(2) == 0)
				{
					self.count++;
				}
			}
		}

		if(!isdefined(var_04))
		{
			continue;
		}

		if(!maps\_utility::func_6D02())
		{
			wait(randomfloatrange(5,9));
		}
	}
}

//Function Number: 179
flood_spawner_stop()
{
	self notify("stop current floodspawner");
}

//Function Number: 180
player_saw_kill(param_00,param_01)
{
	if(isdefined(self.var_6BCE))
	{
		if(self.var_6BCE)
		{
			return 1;
		}
	}

	if(!isdefined(param_00))
	{
		return 0;
	}

	if(isalive(param_01))
	{
		if(isplayer(param_01))
		{
			return 1;
		}

		if(distance(param_01.origin,level.player.origin) < 200)
		{
			return 1;
		}
	}
	else if(isdefined(param_01))
	{
		if(param_01.classname == "worldspawn")
		{
			return 0;
		}

		if(distance(param_01.origin,level.player.origin) < 200)
		{
			return 1;
		}
	}

	if(distance(param_00.origin,level.player.origin) < 200)
	{
		return 1;
	}

	return bullettracepassed(level.player geteye(),param_00 geteye(),0,undefined);
}

//Function Number: 181
func_4831()
{
	if(!isdefined(self.target))
	{
		return 0;
	}

	var_00 = getentarray(self.target,"targetname");
	if(!var_00.size)
	{
		return 0;
	}

	return issubstr(var_00[0].classname,"actor");
}

//Function Number: 182
func_6259(param_00)
{
	param_00.var_775E waittill("death");
	self notify("death_report");
}

//Function Number: 183
func_625A(param_00)
{
	self endon("death");
	var_01 = func_8390(param_00);
	maps\_utility::script_delay();
	if(var_01)
	{
		while(!level.player istouching(param_00))
		{
			wait(0.5);
		}
	}

	var_02 = getentarray(self.target,"targetname");
	self.var_7879 = 0;
	common_scripts\utility::func_F1B(var_02,::func_625B,self);
	var_04 = randomint(var_02.size);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(self.count <= 0)
		{
		}

		var_04++;
		if(var_04 >= var_02.size)
		{
			var_04 = 0;
		}

		var_05 = var_02[var_04];
		var_05 maps\_utility::func_6E67(1);
		var_06 = var_05 maps\_utility::func_7766();
		if(maps\_utility::func_77BE(var_06))
		{
			wait(2);
			continue;
		}

		self.count--;
		var_05.var_775E = var_06;
		var_06 thread reincrement_count_if_deleted(self);
		var_06 thread expand_goalradius(param_00);
		thread func_6259(var_05);
	}

	var_07 = 0.01;
	while(self.count > 0)
	{
		self waittill("death_report");
		maps\_utility::func_6D02();
		wait(var_07);
		var_07 = var_07 + 2.5;
		var_04 = randomint(var_02.size);
		for(var_03 = 0;var_03 < var_02.size;var_03++)
		{
			var_02 = common_scripts\utility::array_removeundefined(var_02);
			if(!var_02.size)
			{
				if(isdefined(self))
				{
					self delete();
				}
			}

			var_04++;
			if(var_04 >= var_02.size)
			{
				var_04 = 0;
			}

			var_05 = var_02[var_04];
			if(isalive(var_05.var_775E))
			{
				continue;
			}

			if(isdefined(var_05.target))
			{
				self.target = var_05.target;
			}
			else
			{
				self.target = undefined;
			}

			var_06 = maps\_utility::func_7766();
			if(maps\_utility::func_77BE(var_06))
			{
				wait(2);
				continue;
			}

			var_06 thread reincrement_count_if_deleted(self);
			var_06 thread expand_goalradius(param_00);
			var_05.var_775E = var_06;
			thread func_6259(var_05);
			if(self.count <= 0)
			{
			}
		}
	}
}

//Function Number: 184
func_625B(param_00)
{
	param_00 endon("death");
	param_00.var_7879++;
	self waittill("death");
	param_00.var_7879--;
	if(!param_00.var_7879)
	{
		param_00 delete();
	}
}

//Function Number: 185
expand_goalradius(param_00)
{
	if(isdefined(self.var_6BD2))
	{
	}

	var_01 = level.var_2497;
	if(isdefined(param_00))
	{
		if(isdefined(param_00.script_radius))
		{
			if(param_00.script_radius == -1)
			{
			}

			var_01 = param_00.script_radius;
		}
	}

	if(isdefined(self.var_6BD2))
	{
	}

	self endon("death");
	self waittill("goal");
	self.goalradius = var_01;
}

//Function Number: 186
drop_health_timeout_thread()
{
	self endon("death");
	wait(95);
	self notify("timeout");
}

//Function Number: 187
func_2B3F()
{
	self endon("timeout");
	thread drop_health_timeout_thread();
	self waittill("trigger");
	maps\_utility::func_1AD7(1);
}

//Function Number: 188
func_81E4(param_00)
{
	wait(0.05);
}

//Function Number: 189
func_74D5()
{
}

//Function Number: 190
func_6326(param_00)
{
	param_00 waittill("trigger");
	var_01 = getentarray(param_00.target,"targetname");
	if(!var_01.size)
	{
	}

	var_02 = common_scripts\utility::func_6306(var_01);
	var_01 = [];
	var_01[var_01.size] = var_02;
	if(isdefined(var_02.script_linkto))
	{
		var_03 = strtok(var_02.script_linkto," ");
		for(var_04 = 0;var_04 < var_03.size;var_04++)
		{
			var_01[var_01.size] = getent(var_03[var_04],"script_linkname");
		}
	}

	waittillframeend;
	common_scripts\utility::func_F1B(var_01,::maps\_utility::add_spawn_function,::blowout_goalradius_on_pathend);
	common_scripts\utility::func_F1B(var_01,::maps\_utility::func_7766);
}

//Function Number: 191
blowout_goalradius_on_pathend()
{
	if(isdefined(self.var_6BD2))
	{
	}

	self endon("death");
	self waittill("reached_path_end");
	if(!isdefined(self getgoalvolume()))
	{
		self.goalradius = level.var_2497;
	}
}

//Function Number: 192
func_57CD(param_00)
{
	var_01 = param_00 maps\_utility::func_39D6();
	common_scripts\utility::func_3385(var_01);
	while(level.var_2387[param_00.script_deathchain] > 0)
	{
		level waittill("spawner_expired" + param_00.script_deathchain);
	}

	common_scripts\utility::flag_set(var_01);
}

//Function Number: 193
func_70F4()
{
	self endon("death");
	waittillframeend;
	self.var_4847 = isplayer(self);
	self.eq_table = [];
	self.var_2F8F = [];
	for(var_00 = 0;var_00 < level.eq_trigger_num;var_00++)
	{
		self.eq_table[var_00] = 0;
	}
}

//Function Number: 194
ai_array()
{
	level.ai_array[level.unique_id] = self;
	self waittill("death");
	waittillframeend;
	level.ai_array[level.unique_id] = undefined;
}

//Function Number: 195
func_7870(param_00)
{
	var_01 = param_00 spawndrone();
	var_01 useanimtree(#animtree);
	if(var_01.weapon != "one")
	{
		var_02 = getweaponmodel(var_01.weapon);
		var_01 attach(var_02,"tag_weapon_right");
		var_03 = getweaponhidetags(var_01.weapon);
		for(var_04 = 0;var_04 < var_03.size;var_04++)
		{
			var_01 hidepart(var_03[var_04],var_02);
		}
	}

	var_01.spawner = param_00;
	var_01.var_2ADC = isdefined(param_00.script_noteworthy) && param_00.script_noteworthy == "drone_delete_on_unload";
	param_00 notify("drone_spawned",var_01);
	return var_01;
}

//Function Number: 196
func_7873(param_00)
{
	if(!isdefined(param_00.spawner))
	{
	}

	var_01 = param_00.spawner.origin;
	var_02 = param_00.spawner.angles;
	param_00.spawner.origin = param_00.origin;
	param_00.spawner.angles = param_00.angles;
	param_00.spawner.count = param_00.spawner.count + 1;
	var_03 = param_00.spawner stalingradspawn();
	var_04 = maps\_utility::func_77BE(var_03);
	if(var_04)
	{
	}

	var_03.var_88DC = param_00.var_88DC;
	var_03.var_890C = param_00.var_890C;
	var_03.standing = param_00.standing;
	var_03.var_34C5 = param_00.var_34C5;
	param_00.spawner.origin = var_01;
	param_00.spawner.angles = var_02;
	param_00 delete();
	return var_03;
}

//Function Number: 197
death_achievements()
{
	self waittill("death",var_00,var_01,var_02);
	if(!isdefined(self))
	{
	}

	if(!self isbadguy())
	{
	}

	if(!isdefined(var_00))
	{
	}

	if(!isplayer(var_00))
	{
	}

	if(isdefined(self.var_4BF6))
	{
		var_01 = self.var_4BF6;
	}
}

//Function Number: 198
death_achievements_rappel(param_00)
{
}

//Function Number: 199
add_random_killspawner_to_spawngroup()
{
	var_00 = self.var_6C88;
	var_01 = self.var_6C89;
	if(!isdefined(level.var_4B2C[var_00]))
	{
		level.var_4B2C[var_00] = [];
	}

	if(!isdefined(level.var_4B2C[var_00][var_01]))
	{
		level.var_4B2C[var_00][var_01] = [];
	}

	level.var_4B2C[var_00][var_01][self.var_30F7] = self;
}

//Function Number: 200
add_to_spawngroup()
{
	var_00 = self.var_6CB0;
	var_01 = self.script_spawnsubgroup;
	if(!isdefined(level.var_77D2[var_00]))
	{
		level.var_77D2[var_00] = [];
	}

	if(!isdefined(level.var_77D2[var_00][var_01]))
	{
		level.var_77D2[var_00][var_01] = [];
	}

	level.var_77D2[var_00][var_01][self.var_30F7] = self;
}

//Function Number: 201
start_off_running()
{
	self endon("death");
	self.disableexits = 1;
	wait(3);
	self.disableexits = 0;
}

//Function Number: 202
deathtime()
{
	self endon("death");
	wait(self.var_6B7B);
	wait(randomfloat(10));
	self kill();
}