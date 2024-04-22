/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\_exo_hover.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 130 ms
 * Timestamp: 4/22/2024 2:15:42 AM
*******************************************************************/

//Function Number: 1
exo_hover_think()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("faux_spawn");
	self endon("exo_hover_taken");
	if(!self hasweapon(level.hoverweapon))
	{
		return;
	}

	exo_hover_init();
	for(;;)
	{
		if(self batteryisinuse(level.hoverweapon) == 0)
		{
			self waittillmatch(level.hoverweapon,"battery_discharge_begin");
		}

		self.exo_hover_on = 1;
		maps\mp\gametypes\_gamelogic::sethasdonecombat(self,1);
		self.pers["numberOfTimesHoveringUsed"]++;
		maps\mp\_exo_battery::set_exo_ability_hud_omnvar(level.hoverweapon,"ui_exo_battery_toggle",1);
		thread maps\mp\_exo_battery::update_exo_battery_hud(level.hoverweapon);
		thread exo_hover_update();
		thread play_exo_hover_vfx();
		if(maps\mp\_utility::_hasperk("specialty_exo_blastsuppressor"))
		{
			maps\mp\_snd_common_mp::snd_message("mp_suppressed_exo_hover");
		}
		else
		{
			maps\mp\_snd_common_mp::snd_message("mp_regular_exo_hover");
		}

		thread end_exo_hover_on_notifies();
		if(self batteryisinuse(level.hoverweapon) == 1)
		{
			self waittillmatch(level.hoverweapon,"battery_discharge_end");
		}

		maps\mp\_exo_battery::set_exo_ability_hud_omnvar(level.hoverweapon,"ui_exo_battery_toggle",0);
		self.exo_hover_on = 0;
		self notify("stop_exo_hover_effects");
	}
}

//Function Number: 2
exo_hover_init()
{
	self batterysetdischargescale(level.hoverweapon,1);
	var_00 = self batterygetsize(level.hoverweapon);
	if(self gettacticalweapon() == level.hoverweapon)
	{
		self setclientomnvar("exo_ability_nrg_req0",0);
		self setclientomnvar("exo_ability_nrg_total0",var_00);
		self setclientomnvar("ui_exo_battery_level0",var_00);
	}
	else if(self getlethalweapon() == level.hoverweapon)
	{
		self setclientomnvar("exo_ability_nrg_req1",0);
		self setclientomnvar("exo_ability_nrg_total1",var_00);
		self setclientomnvar("ui_exo_battery_level1",var_00);
	}

	if(!isdefined(level.regular_exo_hover_vfx))
	{
		level.regular_exo_hover_vfx = loadfx("vfx/smoke/exohover_exhaust_continuous");
	}

	if(!isdefined(level.suppressed_exo_hover_vfx))
	{
		level.suppressed_exo_hover_vfx = loadfx("vfx/smoke/exohover_exhaust_continuous_suppressed");
	}

	if(level.gametype == "horde")
	{
		setdynamicdvar("hover_max_travel_distance",1000);
		return;
	}

	setdynamicdvar("hover_max_travel_distance",350);
}

//Function Number: 3
end_exo_hover_on_notifies()
{
	self endon("stop_exo_hover_effects");
	common_scripts\utility::waittill_any("death","disconnect","joined_team","faux_spawn","exo_hover_taken");
	maps\mp\_exo_battery::set_exo_ability_hud_omnvar(level.hoverweapon,"ui_exo_battery_toggle",0);
	self.exo_hover_on = 0;
	self notify("stop_exo_hover_effects");
}

//Function Number: 4
take_exo_hover()
{
	level.hoverweapon = "exohover_equipment_mp";
	if(isdefined(level.ishorde))
	{
		level.hoverweapon = "exohoverhorde_equipment_mp";
	}

	self notify("kill_battery");
	self notify("exo_hover_taken");
	self takeweapon(level.hoverweapon);
}

//Function Number: 5
give_exo_hover()
{
	level.hoverweapon = "exohover_equipment_mp";
	if(isdefined(level.ishorde))
	{
		level.hoverweapon = "exohoverhorde_equipment_mp";
	}

	self giveweapon(level.hoverweapon);
	thread exo_hover_think();
}

//Function Number: 6
exo_hover_update()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self endon("joined_team");
	self endon("faux_spawn");
	self endon("exo_hover_taken");
	self endon("stop_exo_hover_effects");
	var_00 = self batterygetdischargerate(level.hoverweapon);
	var_01 = self batterygetsize(level.hoverweapon);
	for(;;)
	{
		self playrumbleonentity("damage_heavy");
		var_02 = self getvelocity();
		var_03 = length2d(var_02);
		var_04 = 1;
		if(level.gametype == "horde")
		{
			if(isdefined(self.hordeexobattery))
			{
				var_04 = 1 + self.hordeexobattery * -0.1;
			}
		}

		self batterysetdischargescale(level.hoverweapon,max(var_04,var_01 * var_03 / getdvarint("hover_max_travel_distance",350) * var_00));
		wait(0.1);
	}
}

//Function Number: 7
play_exo_hover_vfx()
{
	level endon("game_ended");
	var_00 = 0;
	if(maps\mp\_utility::_hasperk("specialty_exo_blastsuppressor"))
	{
		var_00 = 1;
		var_01 = spawnlinkedfx(level.suppressed_exo_hover_vfx,self,"tag_jetpack");
	}
	else
	{
		var_01 = spawnlinkedfx(level.regular_exo_hover_vfx,self,"tag_jetpack");
	}

	triggerfx(var_01);
	common_scripts\utility::waittill_any("disconnect","death","joined_team","faux_spawn","exo_hover_taken","stop_exo_hover_effects");
	if(isdefined(var_01))
	{
		var_01 delete();
	}
}