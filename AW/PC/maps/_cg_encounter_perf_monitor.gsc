/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _cg_encounter_perf_monitor.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 228 ms
 * Timestamp: 4/22/2024 2:20:11 AM
*******************************************************************/

//Function Number: 1
cg_spawn_perf_monitor(param_00,param_01,param_02,param_03,param_04)
{
	level endon(param_00);
	if(isdefined(param_01))
	{
		cg_spawn_perf_monitor_setup(param_01);
	}

	if(isdefined(param_04))
	{
		cg_never_delete_setup(param_04);
	}

	var_05 = maps\_sarray::sarray_spawn();
	if(isdefined(param_03) && param_03 == 1)
	{
		thread debug_draw_living_ai(param_00);
	}

	for(;;)
	{
		wait(0.2);
		var_05 maps\_sarray::sarray_clear();
		var_06 = getaiarray();
		foreach(var_08 in var_06)
		{
			if(!isdefined(var_08.neverdelete) && var_08.team == "allies")
			{
				var_08.neverdelete = 1;
			}

			if(!isdefined(var_08.neverdelete) && var_08.team != "allies")
			{
				var_08.neverdelete = 0;
			}

			if(isdefined(var_08.neverdelete) && var_08.neverdelete == 0)
			{
				var_05 maps\_sarray::sarray_push(var_08);
			}
		}

		var_0A = var_06.size;
		if(var_0A > param_02)
		{
			score_and_sort_current_spawns(var_05);
			var_0B = var_0A - param_02;
			foreach(var_0D in var_05.array)
			{
				if(var_0B == 0)
				{
					break;
				}

				if(isalive(var_0D) && isdefined(var_0D.magic_bullet_shield))
				{
					var_0D maps\_utility::stop_magic_bullet_shield();
				}

				if(var_0D.deleteme == 1)
				{
					var_0D delete();
				}
				else
				{
					var_0D kill();
				}

				var_0B--;
				wait(0.05);
			}
		}
	}
}

//Function Number: 2
cg_spawn_perf_monitor_setup(param_00)
{
	foreach(var_02 in param_00)
	{
		maps\_utility::array_spawn_function_noteworthy(var_02,::trackailifespawn);
	}
}

//Function Number: 3
cg_never_delete_setup(param_00)
{
	foreach(var_02 in param_00)
	{
		maps\_utility::array_spawn_function_noteworthy(var_02,::settoneverdelete);
	}
}

//Function Number: 4
score_and_sort_current_spawns(param_00)
{
	foreach(var_02 in param_00.array)
	{
		var_02.killnowscore = 0;
		if(!isdefined(var_02.lifetimer))
		{
			var_02.lifetimer = 0;
		}

		if(!isdefined(var_02.deleteme))
		{
			var_02 thread trackkillordelete();
		}

		var_02.killnowscore = var_02.killnowscore + var_02.lifetimer;
		if(!checktargetisinfrontofplayer(level.player,var_02))
		{
			var_02.killnowscore = var_02.killnowscore + 10;
		}

		var_03 = level.player geteye();
		if(var_02 sightconetrace(var_03) == 0)
		{
			var_02.killnowscore = var_02.killnowscore + 10;
		}
		else
		{
			var_02.killnowscore = var_02.killnowscore - var_02.lifetimer;
		}

		var_04 = distance(var_02.origin,level.player.origin);
		if(var_04 > 1024)
		{
			var_02.killnowscore = var_02.killnowscore + 10;
		}
	}

	maps\_sarray::sarray_sort_by_handler(param_00,maps\_sarray::sarray_create_func_obj(::compare_killnow_score));
}

//Function Number: 5
trackailifespawn()
{
	self endon("death");
	self.lifetimer = 0;
	for(;;)
	{
		wait(0.5);
		self.lifetimer = self.lifetimer + 0.5;
	}
}

//Function Number: 6
trackkillordelete()
{
	self endon("death");
	self.deleteme = 1;
	for(;;)
	{
		var_00 = level.player geteye();
		if(self sightconetrace(var_00) == 1)
		{
			self.deleteme = 0;
			return;
		}

		wait(0.2);
	}
}

//Function Number: 7
compare_time_since_birth(param_00,param_01)
{
	if(!isdefined(param_00.lifetimer))
	{
		param_00.lifetimer = 0;
	}

	if(!isdefined(param_01.lifetimer))
	{
		param_01.lifetimer = 0;
	}

	return param_00.lifetimer > param_01.lifetimer;
}

//Function Number: 8
compare_killnow_score(param_00,param_01)
{
	return param_00.killnowscore > param_01.killnowscore;
}

//Function Number: 9
checktargetisinfrontofplayer(param_00,param_01)
{
	var_02 = anglestoforward(param_00.angles);
	var_03 = param_01.origin - param_00.origin;
	var_04 = vectordot(var_02,var_03);
	return var_04 > 0;
}

//Function Number: 10
settoneverdelete()
{
	self.neverdelete = 1;
}

//Function Number: 11
debug_draw_living_ai(param_00)
{
	level endon(param_00);
	var_01 = setupdebughudelem();
	thread deletedebughudelem(param_00,var_01);
	for(;;)
	{
		wait(0.05);
		var_02 = getaiarray();
		var_01 settext("" + var_02.size);
		foreach(var_04 in var_02)
		{
			var_05 = (0,1,0);
			if(isdefined(var_04.team) && var_04.team != "allies")
			{
				var_05 = (1,0,0);
			}
		}
	}
}

//Function Number: 12
deletedebughudelem(param_00,param_01)
{
	level waittill(param_00);
	param_01 destroy();
}

//Function Number: 13
setupdebughudelem()
{
	var_00 = newhudelem();
	var_00.alignx = "left";
	var_00.aligny = "top";
	var_00.x = 40;
	var_00.y = 40;
	var_00.alpha = 0.6;
	var_00.fontscale = 1.5;
	var_00.foreground = 1;
	var_00.horzalign = "fullscreen";
	var_00.vertalign = "fullscreen";
	return var_00;
}