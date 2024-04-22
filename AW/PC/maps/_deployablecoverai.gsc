/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _deployablecoverai.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 164 ms
 * Timestamp: 4/22/2024 2:20:42 AM
*******************************************************************/

//Function Number: 1
battle_deployable_cover_setup()
{
	deployable_cover_anims();
	level.deployablecover = [];
	var_00 = common_scripts\utility::getstructarray("deployable_cover_animnode","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = getent(var_02.target,"targetname");
		var_03.contents = var_03 setcontents(0);
		var_03 hide();
		var_04 = getent(var_03.target,"targetname");
		var_04 notsolid();
		var_04 connectpaths();
		var_05 = getentarray(var_04.target,"targetname");
		foreach(var_07 in var_05)
		{
			var_07 disconnectnode();
		}

		level.deployablecover[level.deployablecover.size] = var_02;
	}
}

//Function Number: 2
handle_deployable_cover(param_00,param_01)
{
	thread deployable_cover_think();
	if(isdefined(param_01))
	{
		common_scripts\utility::flag_wait(param_01);
	}

	if(!isdefined(level.deployablecoverinuse))
	{
		level.deployablecoverinuse = 0;
	}
	else
	{
		level.deployablecoverinuse++;
		if(level.deployablecoverinuse >= level.deployablecover.size)
		{
			level.deployablecoverinuse = 0;
		}
	}

	var_02 = 0;
	if(isdefined(param_00))
	{
		for(;;)
		{
			var_03 = getent(param_00,"targetname");
			if(isdefined(var_03) && ispointinvolume(level.deployablecover[level.deployablecoverinuse].origin,var_03) && !isdefined(level.deployablecover[level.deployablecoverinuse].isused))
			{
				break;
			}
			else
			{
				level.deployablecoverinuse++;
				if(level.deployablecoverinuse >= level.deployablecover.size)
				{
					level.deployablecoverinuse = 0;
					var_02++;
					wait(5);
					if(var_02 > 3)
					{
						return;
					}
				}
			}

			wait(0.25);
			if(!isalive(self))
			{
				return;
			}
		}
	}

	if(isalive(self) && isdefined(level.deployablecover[level.deployablecoverinuse].isused))
	{
		handle_deployable_cover(param_00,param_01);
		return;
	}

	var_04 = level.deployablecoverinuse;
	level.deployablecover[var_04].isused = 1;
	var_05 = level.deployablecover[var_04];
	var_06 = getent(var_05.target,"targetname");
	var_07 = getent(var_06.target,"targetname");
	var_08 = getentarray(var_07.target,"targetname");
	if(isalive(self))
	{
		self.animname = "generic";
		self.ignoreme = 1;
		self.ignoresuppression = 1;
		thread deployable_cover_focus_goal();
		thread deployable_cover_watch_death(var_04);
		var_05 maps\_anim::anim_reach_solo(self,"deployable_cover_deploy");
	}

	var_09 = maps\_utility::spawn_anim_model("deployable_cover",(0,0,0));
	var_09 show();
	if(isalive(self))
	{
		thread deployable_cover_kill(var_09);
		thread deployable_cover_cleanup(var_09,var_06,var_07,var_08,var_04);
		self notify("placing_deployable_cover");
		var_0A = [self,var_09];
		var_05 thread maps\_anim::anim_single(var_0A,"deployable_cover_deploy");
	}

	if(isalive(self))
	{
		wait(2.3);
	}

	if(isalive(self))
	{
		self notify("deployable_start");
	}

	if(isalive(self))
	{
		wait(2.5);
	}

	if(isdefined(var_09))
	{
		var_09.set = 1;
		var_09 waittillmatch("end","single anim");
	}

	if(isdefined(self))
	{
		self notify("deployable_cleanup");
		self notify("deployable_finished");
	}
}

//Function Number: 3
deployable_cover_think()
{
	var_00 = spawn("script_model",self gettagorigin("j_SpineUpper") + (0,0,0));
	var_00.angles = self gettagangles("j_SpineUpper") + (0,0,0);
	var_00.animname = "deployable_cover";
	var_00 setmodel("deployable_cover");
	var_00 maps\_anim::setanimtree();
	var_00 maps\_anim::anim_first_frame_solo(var_00,"deployable_cover_closed_idle");
	var_00 linkto(self,"j_SpineUpper");
	self waittill("placing_deployable_cover");
	var_00 delete();
}

//Function Number: 4
deployable_cover_focus_goal()
{
	self endon("death");
	self endon("placing_deployable_cover");
	for(;;)
	{
		self.goalradius = 16;
		wait 0.05;
	}
}

//Function Number: 5
deployable_cover_watch_death(param_00)
{
	self endon("placing_deployable_cover");
	self waittill("damage");
	level.deployablecover[param_00].isused = undefined;
}

//Function Number: 6
deployable_cover_kill(param_00)
{
	self endon("deployable_finished");
	self endon("deployable_double");
	self waittill("damage");
	if(isdefined(self) && isalive(self))
	{
		maps\_utility::anim_stopanimscripted();
		self kill();
	}

	param_00 maps\_utility::anim_stopanimscripted();
	self notify("deployable_cleanup");
}

//Function Number: 7
deployable_cover_cleanup(param_00,param_01,param_02,param_03,param_04)
{
	self endon("deployable_double");
	common_scripts\utility::waittill_any("deployable_start","death");
	wait 0.05;
	if(isalive(self))
	{
		param_02 solid();
		param_02 disconnectpaths();
	}

	if(isalive(self))
	{
		common_scripts\utility::waittill_any("deployable_cleanup","death");
	}

	if(isalive(self) || isdefined(param_00.set))
	{
		param_01 setcontents(param_01.contents);
		param_01 show();
		foreach(var_06 in param_03)
		{
			var_06 connectnode();
		}
	}
	else
	{
		param_02 notsolid();
		param_02 connectpaths();
		level.deployablecover[param_04].isused = undefined;
	}

	wait 0.05;
	self notify("goal");
	param_00 delete();
}

//Function Number: 8
deployable_cover_anims()
{
	deployable_cover_ai();
	deployable_cover_model();
}

//Function Number: 9
deployable_cover_ai()
{
	level.scr_anim["generic"]["deployable_cover_deploy"] = %fusion_lift_deploy_cover_carter_enter;
	level.scr_anim["generic"]["deployable_cover_deploy_idle"][0] = %fusion_lift_deploy_cover_carter_idle;
}

//Function Number: 10
deployable_cover_model()
{
	level.scr_animtree["deployable_cover"] = #animtree;
	level.scr_model["deployable_cover"] = "deployable_cover";
	level.scr_anim["deployable_cover"]["deployable_cover_deploy"] = %fusion_lift_deploy_cover_deployable_cover_prop_enter;
	level.scr_anim["deployable_cover"]["deployable_cover_closed_idle"] = %fusion_lift_deploy_cover_idle_closed;
	level.scr_anim["deployable_cover"]["deployable_cover_open_idle"] = %fusion_lift_deploy_cover_idle_opened;
}

//Function Number: 11
print3d_over_target()
{
	self endon("death");
	wait(1);
}