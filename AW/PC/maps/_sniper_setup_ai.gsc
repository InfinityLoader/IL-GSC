/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _sniper_setup_ai.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 118 ms
 * Timestamp: 4/22/2024 2:22:46 AM
*******************************************************************/

//Function Number: 1
alertai(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(maps\_utility::is_in_array(level.alertedenemies,self))
	{
		return;
	}

	self notify("guy_alerted");
	self notify("end_patrol");
	self notify("new_anim_reach");
	self notify("stop_talking");
	self endon("disableAlert");
	if(isdefined(self.disable_alert) && self.disable_alert == 1)
	{
		return;
	}

	if(isdefined(self.default_health))
	{
		self.health = self.default_health;
		self.default_health = undefined;
	}

	maps\_utility::enable_arrivals();
	maps\_utility::enable_exits();
	maps\greece_code::enableawareness();
	maps\_stealth_utility::disable_stealth_for_ai();
	maps\_utility::clear_run_anim();
	maps\_utility::clear_generic_idle_anim();
	maps\_utility::clear_generic_run_anim();
	waittillframeend;
	maps\greece_code::setalertoutline();
	maps\greece_conf_center::markdronetargetenemy();
	level.alertedenemies = common_scripts\utility::add_to_array(level.alertedenemies,self);
	common_scripts\utility::flag_set("FlagDisableAutosave");
	maps\greece_conf_center::aiidleloopdisable(1);
	thread _reactionanimation();
	thread _normalbehavior(param_01);
	if(param_00 && !isdefined(self.alertgroup) || self.alertgroup)
	{
		thread alertaigroup();
	}

	self waittill("death");
	level.alertedenemies = maps\_utility::array_removedead_or_dying(level.alertedenemies);
	if(!common_scripts\utility::flag("FlagAlarmMissionEnd") && level.alertedenemies.size == 0)
	{
		common_scripts\utility::flag_clear("FlagDisableAutosave");
	}
}

//Function Number: 2
alertaigroup()
{
	self endon("death");
	self endon("disableAlert");
	level endon("alarm_mission_end");
	if(isdefined(self.script_stealthgroup))
	{
		var_00 = maps\_stealth_shared_utilities::group_get_ai_in_group(self.script_stealthgroup);
		var_00 = maps\_utility::array_removedead_or_dying(var_00);
		foreach(var_02 in var_00)
		{
			if(var_02 != self)
			{
				wait(randomfloat(0.1));
				if(isdefined(var_02) && isalive(var_02))
				{
					var_02 thread alertai(0);
				}
			}
		}
	}
}

//Function Number: 3
sawcorpse()
{
	if(isdefined(self.disablecorpsealert))
	{
		return;
	}

	if(isdefined(self.script_noteworthy))
	{
		maps\_hms_utility::printlnscreenandconsole(self.script_noteworthy + "saw a CORPSE...");
	}
	else
	{
		maps\_hms_utility::printlnscreenandconsole("A guy saw a CORPSE...");
	}

	thread alertai();
	maps\_stealth_corpse_enemy::enemy_corpse_saw_behavior();
}

//Function Number: 4
waitforplayerbulletwhizby()
{
	self endon("death");
	self endon("disableAlert");
	level endon("alarm_mission_end");
	for(;;)
	{
		self waittill("bulletwhizby",var_00);
		wait 0.05;
		if(isai(var_00) || !isplayer(var_00))
		{
			continue;
		}

		if(isdefined(self.script_noteworthy))
		{
			maps\_hms_utility::printlnscreenandconsole(self.script_noteworthy + "got a WHIZBY...");
		}
		else
		{
			maps\_hms_utility::printlnscreenandconsole("A guy got a WHIZBY...");
		}

		if(isdefined(self.disablebulletwhizbyreaction))
		{
			continue;
		}

		thread alertai();
	}
}

//Function Number: 5
_reactionanimation()
{
	var_00 = self.customreactanime;
	if(isdefined(var_00) && maps\_utility::hasanim(var_00))
	{
		maps\_anim::anim_single_solo(self,var_00);
	}
}

//Function Number: 6
_normalbehavior(param_00)
{
	self endon("death");
	self endon("dying");
	self endon("disableAlert");
	level endon("alarm_mission_end");
	self notify("customAlert");
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	if(!isdefined(self.isalerted))
	{
		self.isalerted = 1;
		if(isdefined(self.script_noteworthy))
		{
			maps\_hms_utility::printlnscreenandconsole(self.script_noteworthy + "is now ALERTED...");
		}
		else
		{
			maps\_hms_utility::printlnscreenandconsole("A guy is now ALERTED...");
		}

		if(param_00 == 1)
		{
			if(isdefined(self.noalarm) && self.noalarm == 1)
			{
				return;
			}

			if(isdefined(self.overridealerttimedelay))
			{
				var_01 = self.overridealerttimedelay;
			}
			else
			{
				var_01 = float(level.alerttimedelay);
			}

			wait(var_01);
			if(isdefined(self.disable_alert) && self.disable_alert == 1)
			{
				return;
			}

			if(common_scripts\utility::flag_exist("_stealth_enabled") && !common_scripts\utility::flag("_stealth_enabled"))
			{
				return;
			}

			if(isdefined(self.script_noteworthy))
			{
				maps\_hms_utility::printlnscreenandconsole("Alarm sounded by... " + self.script_noteworthy + "!!!");
			}
			else
			{
				maps\_hms_utility::printlnscreenandconsole("Alarm sounded by... A NAMELESS GUY!!!");
			}

			if(isalive(self) && maps\_utility::is_in_array(level.alertedenemies,self))
			{
				if(isdefined(self.script_noteworthy))
				{
					maps\_hms_utility::printlnscreenandconsole("Alarm sounded by... " + self.script_noteworthy + "!!!");
				}
				else
				{
					maps\_hms_utility::printlnscreenandconsole("Alarm sounded by... A NAMELESS GUY!!!");
				}

				common_scripts\utility::flag_set("FlagAlarmMissionEnd");
				maps\greece_conf_center::destroyatriumfighttimer();
				level notify("alarm_mission_end");
				return;
			}
		}
	}
}

//Function Number: 7
displayalertcountdowntimer(param_00)
{
	if(!isdefined(level.hudalerttimer))
	{
		level endon("AlertTimerFreeze");
		level.hudalerttimer = maps\_hud_util::get_countdown_hud();
		level.hudalerttimer.label = "Time until alarm ";
		level.hudalerttimer.x = -110;
		level.hudalerttimer.y = 45;
		level.hudalerttimer.alignx = "left";
		level.hudalerttimer.horzalign = "center";
		level.hudalerttimer.color = (0.95,0.95,1);
		level.hudalerttimer settenthstimer(param_00);
		level.hudalerttimer setpulsefx(30,900000,700);
		common_scripts\utility::waittill_any_timeout(param_00,"disableAlert","death");
		level.hudalerttimer destroy();
	}
}