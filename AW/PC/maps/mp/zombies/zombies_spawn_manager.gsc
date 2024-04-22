/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\zombies_spawn_manager.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 22
 * Decompile Time: 332 ms
 * Timestamp: 4/22/2024 2:15:17 AM
*******************************************************************/

//Function Number: 1
init(param_00)
{
	while(!isdefined(level.struct_class_names))
	{
		wait(0.05);
	}

	if(!isdefined(level.zombies_spawners_zombie))
	{
		level.zombies_spawners_zombie = [];
	}

	level.zombies_spawners_zombie = common_scripts\utility::array_combine(level.zombies_spawners_zombie,common_scripts\utility::getstructarray("zombie_spawner","targetname"));
	level.zombies_spawners_zombie = common_scripts\utility::array_combine(level.zombies_spawners_zombie,common_scripts\utility::getstructarray("Spawner_A","targetname"));
	level.zombie_spawning_active = 0;
	level.zombie_wave_running = 0;
	level.maxenemycount = 0;
	level.getspawntypefunc = [];
	level.candroppickupsfunc = [];
	level.roundstartfunc = [];
	level.roundendfunc = [];
	level.numenemiesthisroundfunc = [];
	level.roundspawndelayfunc = [];
	level.mutatorfunc = [];
	level.movemodefunc = [];
	level.moveratescalefunc = [];
	level.nonmoveratescalefunc = [];
	level.traverseratescalefunc = [];
	if(isdefined(level.mutatortablesetupfunc))
	{
		[[ level.mutatortablesetupfunc ]]();
		return;
	}

	defaultmutatorsetup();
}

//Function Number: 2
defaultmutatorsetup()
{
	level.special_mutators["emz"] = [::emzmutatorshouldapply,2];
	level.special_mutators["fast"] = [::fastmutatorshouldapply,1];
	level.special_mutators["exploder"] = [::explodermutatorshouldapply,1];
}

//Function Number: 3
getsolowaveoffset()
{
	return 2;
}

//Function Number: 4
shouldwaveend(param_00,param_01)
{
	if(isdefined(level.shouldwaveendoverridefunc))
	{
		return [[ level.shouldwaveendoverridefunc ]](param_00,param_01);
	}

	return param_00 >= param_01;
}

//Function Number: 5
calculatemaxenemycount(param_00)
{
	if(isdefined(level.nummaxenemiesthisroundfunc) && isdefined(level.nummaxenemiesthisroundfunc[level.roundtype]))
	{
		return [[ level.nummaxenemiesthisroundfunc[level.roundtype] ]](param_00);
	}

	return param_00;
}

//Function Number: 6
spawnzombies(param_00,param_01,param_02)
{
	level endon("zombie_stop_spawning");
	var_03 = undefined;
	var_04 = undefined;
	if(isdefined(param_02))
	{
		var_03 = param_02["overrideSpawnType"];
		var_04 = param_02["mutatorFunc"];
	}

	var_05 = isdefined(param_02) && maps\mp\zombies\_util::is_true(param_02["limitedSpawns"]);
	var_06 = isdefined(param_02) && maps\mp\zombies\_util::is_true(param_02["forceSpawnDelay"]);
	for(var_07 = 0;!shouldwaveend(var_07,param_00);var_07++)
	{
		while(maps\mp\zombies\_util::iszombiegamepaused())
		{
			wait 0.05;
		}

		while(maps\mp\agents\_agent_utility::getnumactiveagents() >= level.maxenemycount)
		{
			wait(0.1);
		}

		while(getnumberofzombies() >= param_00 && !var_05)
		{
			wait(0.1);
		}

		while(isdefined(level.zombie_pause_spawning_count) && level.zombie_pause_spawning_count > 0)
		{
			wait(0.1);
		}

		if(isdefined(var_03))
		{
			var_08 = var_03;
		}
		else
		{
			var_08 = getenemytypetospawn(var_07,param_00);
		}

		if(isdefined(level.zombiesnextspawntype))
		{
			var_08 = level.zombiesnextspawntype;
			level.zombiesnextspawntype = undefined;
		}

		var_0A = spawnzombietype(var_08,undefined,var_04);
		if(!var_06 && isdefined(level.roundspawndelayfunc[level.roundtype]))
		{
			param_01 = [[ level.roundspawndelayfunc[level.roundtype] ]](var_07,param_00);
		}

		level.totalaispawned++;
		level common_scripts\utility::waittill_notify_or_timeout("end_spawn_wait",param_01);
	}

	if(isdefined(param_02) && isdefined(param_02["notifyWhenFinished"]))
	{
		level notify(param_02["notifyWhenFinished"]);
	}
}

//Function Number: 7
getmaxenemycount()
{
	if(level.nextgen)
	{
		return calculatemaxenemycount(24);
	}

	return calculatemaxenemycount(20);
}

//Function Number: 8
runwave(param_00)
{
	level endon("zombie_wave_interrupt");
	level.zombie_spawning_active = 1;
	level.zombie_wave_running = 1;
	level.totaldesiredai = calculatetotalai();
	level.totalaispawned = 0;
	level.maxenemycount = getmaxenemycount();
	var_01 = calculatespawndelay();
	if(isdefined(level.spawnzombiesoverridefunc))
	{
		[[ level.spawnzombiesoverridefunc ]](level.totaldesiredai,var_01);
	}
	else
	{
		spawnzombies(level.totaldesiredai,var_01);
	}

	level.zombie_spawning_active = 0;
	wait(2);
	while(zombiesarealive())
	{
		wait 0.05;
	}

	level.zombie_wave_running = 0;
	level notify("zombie_wave_ended");
}

//Function Number: 9
zombiesarealive(param_00)
{
	if(isdefined(level.recyclezombierequestspending) && level.recyclezombierequestspending > 0)
	{
		return 1;
	}

	var_01 = "all";
	if(isdefined(param_00))
	{
		var_01 = param_00;
	}

	var_02 = maps\mp\agents\_agent_utility::getactiveagentsoftype(var_01);
	foreach(var_04 in var_02)
	{
		if(!isscriptedagent(var_04))
		{
			continue;
		}

		if(var_04.team == level.enemyteam)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 10
getnumberofzombies()
{
	var_00 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
	var_01 = 0;
	foreach(var_03 in var_00)
	{
		if(var_03.team == level.enemyteam)
		{
			var_01++;
		}
	}

	return var_01;
}

//Function Number: 11
getenemytypetospawn(param_00,param_01)
{
	if(isdefined(level.getspawntypefunc[level.roundtype]))
	{
		return [[ level.getspawntypefunc[level.roundtype] ]](param_00,param_01);
	}

	return "zombie_generic";
}

//Function Number: 12
calculatetotalai()
{
	var_00 = 24;
	var_01 = 6;
	var_02 = level.wavecounter / 5;
	if(var_02 < 1)
	{
		var_02 = 1;
	}

	if(level.wavecounter >= 10)
	{
		var_02 = var_02 * level.wavecounter * 0.15;
	}

	var_03 = maps\mp\zombies\_util::getnumplayers();
	if(var_03 == 1)
	{
		var_00 = var_00 + 0.5 * var_01 * var_02;
	}
	else
	{
		var_00 = var_00 + var_03 - 1 * var_01 * var_02;
	}

	switch(level.wavecounter)
	{
		case 1:
			var_00 = var_00 * 0.25;
			break;

		case 2:
			var_00 = var_00 * 0.3;
			break;

		case 3:
			var_00 = var_00 * 0.7;
			break;

		case 4:
			var_00 = var_00 * 0.9;
			break;
	}

	if(isdefined(level.numenemiesthisroundfunc[level.roundtype]))
	{
		var_00 = [[ level.numenemiesthisroundfunc[level.roundtype] ]](var_00);
	}

	return int(var_00);
}

//Function Number: 13
calculatespawndelay(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 2;
	}

	if(level.wavecounter == 1)
	{
		return param_00;
	}

	var_01 = param_00 * pow(0.95,level.wavecounter - 1);
	if(var_01 < 0.08)
	{
		var_01 = 0.08;
	}

	return var_01;
}

//Function Number: 14
spawnzombietype(param_00,param_01,param_02,param_03)
{
	var_04 = maps\mp\zombies\_zombies::spawnzombie(param_00,param_01,param_03);
	if(!isdefined(var_04))
	{
		return;
	}

	if(isdefined(param_02))
	{
		var_05 = param_02;
	}
	else if(isdefined(level.mutatorfunc[param_01]))
	{
		var_05 = level.mutatorfunc[param_01];
	}
	else
	{
		var_05 = ::applyzombiemutator;
	}

	[[ var_05 ]](var_04);
	var_06 = param_00;
	if(isdefined(var_04.activemutators))
	{
		foreach(var_09, var_08 in var_04.activemutators)
		{
			var_06 = var_06 + "_" + var_09;
		}
	}

	if(var_04.agent_type == var_06 && isdefined(level.agentclasses[var_06]))
	{
		var_04 thread maps\mp\zombies\_zombies_audio::do_zombies_playvocals("spawn",var_04.agent_type);
	}

	if(isscriptedagent(var_04))
	{
		var_04 scragentsetzombietype(var_06);
	}

	return var_04;
}

//Function Number: 15
exomutatorshouldapply(param_00)
{
	if(level.currentgen)
	{
		if(cg_calculatemutatoractivecount() >= 10)
		{
			return 0;
		}
	}

	if(!isscriptedagent(self))
	{
		return 0;
	}

	if(isdefined(level.mutators_disabled[self.agent_type]))
	{
		if(isdefined(level.mutators_disabled[self.agent_type]["exo"]) && level.mutators_disabled[self.agent_type]["exo"])
		{
			return 0;
		}
	}

	var_01 = 0;
	if(level.players.size < 2)
	{
		var_01 = 2;
	}

	var_02 = 3 + var_01;
	if(param_00 >= var_02)
	{
		var_03 = var_02;
		var_04 = 0.1;
		var_05 = 18 + var_01;
		var_06 = 1;
		var_07 = var_04;
		if(param_00 >= var_05)
		{
			var_07 = var_06;
		}
		else
		{
			var_08 = param_00 - var_03 / var_05 - var_03;
			var_07 = var_04 + var_08 * var_06 - var_04;
		}

		if(randomfloat(1) < var_07)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 16
cg_calculatemutatoractivecount()
{
	var_00 = 0;
	if(isdefined(level.activemutators["exo"]))
	{
		var_00 = level.activemutators["exo"];
	}

	return var_00;
}

//Function Number: 17
emzmutatorshouldapply(param_00)
{
	var_01 = 0;
	if(level.players.size < 2)
	{
		var_01 = 2;
	}

	var_02 = 4 + var_01;
	return param_00 >= var_02;
}

//Function Number: 18
fastmutatorshouldapply(param_00)
{
	var_01 = 0;
	if(level.players.size < 2)
	{
		var_01 = 2;
	}

	var_02 = 5 + var_01;
	var_03 = 20 + var_01;
	return param_00 >= var_02 && param_00 < var_03;
}

//Function Number: 19
explodermutatorshouldapply(param_00)
{
	if(level.roundtype == "zombie_dog")
	{
		return level.specialroundcounter < 6;
	}

	var_01 = 0;
	if(level.players.size < 2)
	{
		var_01 = 2;
	}

	var_02 = 6 + var_01;
	return param_00 >= var_02;
}

//Function Number: 20
specialmutatorshouldapplydoground(param_00)
{
	if(level.specialroundcounter < 3)
	{
		return 0;
	}

	var_01 = 1;
	if(level.specialroundcounter < 5)
	{
		var_01 = 0.5;
	}

	if(randomfloat(1) < var_01)
	{
		return 1;
	}

	return 0;
}

//Function Number: 21
specialmutatorshouldapply(param_00)
{
	if(!isscriptedagent(self))
	{
		return 0;
	}

	if(isdefined(level.shouldspecialmutatorapplyfunc))
	{
		var_01 = self [[ level.shouldspecialmutatorapplyfunc ]](param_00);
		if(isdefined(var_01))
		{
			return var_01;
		}
	}

	if(level.roundtype == "zombie_dog")
	{
		return specialmutatorshouldapplydoground(param_00);
	}

	if(level.currentgen)
	{
		if(cg_calculatemutatoractivecount() >= 10)
		{
			return 0;
		}
	}

	var_02 = 0;
	if(isdefined(level.specialmutatorstartingroundoverridefunc))
	{
		var_03 = [[ level.specialmutatorstartingroundoverridefunc ]]();
	}
	else
	{
		if(level.players.size < 2)
		{
			var_03 = 2;
		}

		var_03 = 4;
	}

	var_04 = var_03 + var_02;
	var_05 = 0.05;
	var_06 = 20 + var_02;
	var_07 = 0.25;
	var_08 = var_07 - var_05 / var_06 - var_04;
	var_09 = 0.5;
	if(param_00 >= var_04)
	{
		var_0A = min(var_09,var_05 + var_08 * float(param_00 - var_04));
		if(randomfloat(1) < var_0A)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 22
applyzombiemutator(param_00)
{
	if(!isscriptedagent(param_00))
	{
		return;
	}

	var_01 = param_00 specialmutatorshouldapply(level.wavecounter);
	var_02 = [];
	var_03 = param_00 exomutatorshouldapply(level.wavecounter) || var_01;
	if(var_03)
	{
		param_00 thread maps\mp\zombies\_mutators::mutator_apply("exo");
	}

	if(var_01)
	{
		var_07 = [];
		var_08 = 0;
		foreach(var_0C, var_05 in level.special_mutators)
		{
			var_0A = var_05[0];
			var_0B = var_05[1];
			if(isdefined(level.mutators_disabled[param_00.agent_type]))
			{
				if(isdefined(level.mutators_disabled[param_00.agent_type][var_0C]) && level.mutators_disabled[param_00.agent_type][var_0C])
				{
					continue;
				}
			}

			if(param_00 [[ var_0A ]](level.wavecounter))
			{
				var_07[var_07.size] = var_0C;
				var_08 = var_08 + var_0B;
			}
		}

		var_0D = randomfloat(var_08);
		var_0E = 0;
		foreach(var_0C in var_07)
		{
			var_0B = level.special_mutators[var_0C][1];
			if(var_0D > var_0E && var_0D <= var_0E + var_0B)
			{
				param_00 thread maps\mp\zombies\_mutators::mutator_apply(var_0C);
				break;
			}

			var_0E = var_0E + var_0B;
		}
	}
}