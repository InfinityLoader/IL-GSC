/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\_power.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 182 ms
 * Timestamp: 4/22/2024 2:13:51 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["power_station_main_fx"] = loadfx("vfx/props/dlc_prop_power_station_fx_main");
	level._effect["power_station_exhaust_fx"] = loadfx("vfx/props/dlc_prop_power_station_fx_exhaust");
	level._effect["power_station_beacon_fx"] = loadfx("vfx/props/dlc_prop_power_station_fx_beacon");
	level._effect["power_station_fx_off"] = loadfx("vfx/props/dlc_prop_power_station_fx_off");
	precachempanim("dlc_power_station_activate");
	level.power_switches = [];
	level.roundpowerstations = [];
	var_00 = common_scripts\utility::getstructarray("power_switch","targetname");
	common_scripts\utility::array_thread(var_00,::power_switch_init);
	var_01 = getentarray("power_show","targetname");
	common_scripts\utility::array_thread(var_01,::power_show_ent_run);
	var_02 = getentarray("power_hide","targetname");
	common_scripts\utility::array_thread(var_02,::power_hide_ent_run);
}

//Function Number: 2
power_switch_init()
{
	if(!isdefined(self.script_flag))
	{
		power_error("Power switch at " + self.origin + " missing use script_flag.");
		return;
	}

	common_scripts\utility::flag_init(self.script_flag);
	self.showents = [];
	self.hideents = [];
	var_00 = getentarray(self.target,"targetname");
	foreach(var_02 in var_00)
	{
		power_switch_ent_init(var_02);
	}

	if(!isdefined(self.trigger))
	{
		power_error("Power switch at " + self.origin + " missing use trigger.");
		return;
	}

	self.power_switch_index = level.power_switches.size;
	level.power_switches[level.power_switches.size] = self;
	thread power_switch_run();
	thread power_switch_button_run();
	thread power_anim_model_run();
}

//Function Number: 3
power_switch_ent_init(param_00)
{
	var_01 = param_00.script_noteworthy;
	if(!isdefined(var_01))
	{
		switch(param_00.classname)
		{
			case "script_model":
				var_01 = "anim_model";
				break;

			case "script_brushmodel":
				var_01 = "button";
				break;

			case "trigger_use_touch":
			case "trigger_use":
				var_01 = "trigger";
				break;

			default:
				var_01 = "undefined";
				break;
		}
	}

	switch(var_01)
	{
		case "trigger":
			self.trigger = param_00;
			break;

		case "button":
			self.button = param_00;
			break;

		case "anim_model":
			self.modelent = param_00;
			break;

		case "show":
			self.showents[self.showents.size] = param_00;
			break;

		case "hide":
			self.hideents[self.hideents.size] = param_00;
			break;

		default:
			power_error("Unknown ent type \'" + var_01 + "\' on entity at " + param_00.origin + ".");
			break;
	}
}

//Function Number: 4
power_switch_run()
{
	for(;;)
	{
		foreach(var_01 in self.showents)
		{
			var_01 hide();
		}

		foreach(var_01 in self.hideents)
		{
			var_01 show();
		}

		self.trigger setcursorhint("HINT_NOICON");
		self.trigger sethintstring(&"ZOMBIES_POWER_ON");
		for(;;)
		{
			self.trigger waittill("trigger",var_05);
			if(!isdefined(level.poweroffpenalty))
			{
				break;
			}
		}

		if(isdefined(var_05))
		{
			if(!maps\mp\zombies\_util::is_true(self.nopoints))
			{
				var_05 maps\mp\gametypes\zombies::givepointsforevent("power_on");
			}

			if(maps\mp\zombies\_util::getzombieslevelnum() == 1 || maps\mp\zombies\_util::getzombieslevelnum() == 3 || maps\mp\zombies\_util::getzombieslevelnum() == 4)
			{
				var_05 maps\mp\zombies\_zombies_audio_announcer::announcerpoweronlinedialog(self.script_flag);
			}
			else
			{
				var_05 maps\mp\zombies\_zombies_audio::playerpoweronvo();
			}
		}

		level.roundpowerstations[level.roundpowerstations.size] = self.power_switch_index;
		self.trigger sethintstring("");
		self notify("on");
		common_scripts\utility::flag_set(self.script_flag);
		foreach(var_01 in self.showents)
		{
			var_01 show();
		}

		foreach(var_01 in self.hideents)
		{
			var_01 hide();
		}

		if(level.currentgen)
		{
			var_0A = maps\mp\zombies\_util::getzombieslevelnum();
			if(var_0A == 3)
			{
				self.trigger delete();
			}
		}

		var_0B = power_switch_on_wait();
		self notify("off");
		common_scripts\utility::flag_clear(self.script_flag);
		if(isdefined(var_0B) && var_0B == "zombie_power_penalty_start")
		{
			foreach(var_01 in self.showents)
			{
				var_01 hide();
			}

			foreach(var_01 in self.hideents)
			{
				var_01 show();
			}

			level waittill("zombie_power_penalty_end");
		}
	}
}

//Function Number: 5
power_switch_on_wait()
{
	if(isdefined(self.trigger))
	{
		self.trigger endon("trigger_off");
	}

	level waittill("zombie_power_penalty_start");
	return "zombie_power_penalty_start";
}

//Function Number: 6
power_switch_button_run()
{
	if(!isdefined(self.button))
	{
		return;
	}

	var_00 = 0.4;
	var_01 = self.button.origin;
	var_02 = var_01 + (0,0,16);
	for(;;)
	{
		self waittill("on");
		self.button moveto(var_02,var_00);
		self waittill("off");
		self.button moveto(var_01,var_00);
	}
}

//Function Number: 7
power_anim_model_run()
{
	if(!isdefined(self.modelent))
	{
		return;
	}

	for(;;)
	{
		thread power_anim_model_fx(0);
		self waittill("on");
		self.modelent playsound("interact_generator_start");
		self.modelent playloopsound("interact_generator_lp");
		self.modelent scriptmodelplayanim("dlc_power_station_activate");
		thread power_anim_model_fx(1);
		self waittill("off");
		self.modelent scriptmodelclearanim();
		self.modelent stoploopsound();
	}
}

//Function Number: 8
power_anim_model_fx(param_00)
{
	self endon("off");
	self endon("on");
	var_01["TAG_ORIGIN"] = "power_station_exhaust_fx";
	var_01["TAG_POWERSTATION_TURBINE_FX1"] = "power_station_main_fx";
	var_01["TAG_POWERSTATION_BEACON_FX1"] = "power_station_beacon_fx";
	var_01["TAG_POWERSTATION_BEACON_FX2"] = "power_station_beacon_fx";
	var_02["TAG_ORIGIN"] = "power_station_fx_off";
	if(!isdefined(self.modelent.firstfx))
	{
		self.modelent.firstfx = 1;
	}

	if(param_00)
	{
		if(!self.modelent.firstfx)
		{
			foreach(var_05, var_04 in var_02)
			{
				maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx(var_04),self.modelent,var_05);
			}
		}

		foreach(var_05, var_04 in var_01)
		{
			maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx(var_04),self.modelent,var_05);
		}
	}
	else
	{
		if(!self.modelent.firstfx)
		{
			foreach(var_05, var_05 in var_04)
			{
				maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx(var_05),self.modelent,var_07);
			}
		}

		foreach(var_05, var_04 in var_02)
		{
			maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx(var_04),self.modelent,var_05);
		}
	}

	self.modelent.firstfx = 0;
}

//Function Number: 9
power_show_ent_run()
{
	self endon("death");
	if(!isdefined(self.script_flag))
	{
		power_error("Power show entity at " + self.origin + " missing script_flag.");
		return;
	}

	for(;;)
	{
		self hide();
		common_scripts\utility::flag_wait(self.script_flag);
		self show();
		common_scripts\utility::flag_waitopen(self.script_flag);
	}
}

//Function Number: 10
power_hide_ent_run()
{
	self endon("death");
	if(!isdefined(self.script_flag))
	{
		power_error("Power hide entity at " + self.origin + " missing script_flag.");
		return;
	}

	for(;;)
	{
		self show();
		common_scripts\utility::flag_wait(self.script_flag);
		self hide();
		common_scripts\utility::flag_waitopen(self.script_flag);
	}
}

//Function Number: 11
power_error(param_00)
{
}