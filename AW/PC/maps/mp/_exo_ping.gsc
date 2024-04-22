/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\_exo_ping.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 177 ms
 * Timestamp: 4/22/2024 2:15:44 AM
*******************************************************************/

//Function Number: 1
exo_ping_think()
{
	self notify("exo_ping_taken");
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("faux_spawn");
	self endon("exo_ping_taken");
	if(!self hasweapon("exoping_equipment_mp"))
	{
		return;
	}

	exo_ping_init();
	thread toggle_exo_ping();
	thread wait_for_player_death();
	thread wait_for_game_end();
}

//Function Number: 2
exo_ping_init()
{
	self.exo_ping_on = 0;
	self batterysetdischargescale("exoping_equipment_mp",1);
	var_00 = self batterygetsize("exoping_equipment_mp");
	if(self gettacticalweapon() == "exoping_equipment_mp")
	{
		self setclientomnvar("ui_exo_battery_level0",var_00);
		self setclientomnvar("exo_ability_nrg_req0",batteryreqtouse("exoping_equipment_mp"));
		self setclientomnvar("exo_ability_nrg_total0",var_00);
	}
	else if(self getlethalweapon() == "exoping_equipment_mp")
	{
		self setclientomnvar("ui_exo_battery_level1",var_00);
		self setclientomnvar("exo_ability_nrg_req1",batteryreqtouse("exoping_equipment_mp"));
		self setclientomnvar("exo_ability_nrg_total1",var_00);
	}

	if(!isdefined(level.exo_ping_vfx_inactive))
	{
		level.exo_ping_vfx_inactive = loadfx("vfx/unique/exo_ping_inactive");
	}

	if(!isdefined(level.exo_ping_vfx_active))
	{
		level.exo_ping_vfx_active = loadfx("vfx/unique/exo_ping_active");
	}

	wait(0.05);
	if(!maps\mp\_utility::invirtuallobby())
	{
		playfxontag(level.exo_ping_vfx_inactive,self,"J_SpineUpper");
	}
}

//Function Number: 3
toggle_exo_ping()
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("faux_spawn");
	self endon("exo_ping_taken");
	for(;;)
	{
		self waittill("exo_ability_activate",var_00);
		if(var_00 != "exoping_equipment_mp")
		{
			continue;
		}

		if(self.exo_ping_on == 1)
		{
			thread stop_exo_ping();
			continue;
		}

		if(self hasweapon("exoping_equipment_mp"))
		{
			if(self batterygetcharge("exoping_equipment_mp") > 0)
			{
				start_exo_ping();
			}
		}
	}
}

//Function Number: 4
monitor_exoping_battery_charge()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("faux_spawn");
	self endon("exo_ping_taken");
	self endon("stop_exo_ping");
	while(self.exo_ping_on == 1)
	{
		if(self batterygetcharge("exoping_equipment_mp") <= 0)
		{
			thread stop_exo_ping();
		}

		wait(0.05);
	}
}

//Function Number: 5
take_exo_ping()
{
	self notify("kill_battery");
	self notify("exo_ping_taken");
	self takeweapon("exoping_equipment_mp");
}

//Function Number: 6
give_exo_ping()
{
	self giveweapon("exoping_equipment_mp");
	thread exo_ping_think();
}

//Function Number: 7
killpingfx()
{
	if(isdefined(self.ping_fx))
	{
		self.ping_fx delete();
		self.ping_fx = undefined;
	}
}

//Function Number: 8
start_exo_ping()
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("faux_spawn");
	self endon("exo_ping_taken");
	self endon("stop_exo_ping");
	self.exo_ping_on = 1;
	self.highlight_effect = maps\mp\_threatdetection::detection_highlight_hud_effect_on(self,-1);
	self setperk("specialty_exo_ping",1,0);
	self batterydischargeonce("exoping_equipment_mp",batteryusepershot("exoping_equipment_mp"));
	self batterydischargebegin("exoping_equipment_mp");
	maps\mp\_exo_battery::set_exo_ability_hud_omnvar("exoping_equipment_mp","ui_exo_battery_toggle",1);
	thread maps\mp\_exo_battery::update_exo_battery_hud("exoping_equipment_mp");
	thread monitor_exoping_battery_charge();
	maps\mp\_snd_common_mp::snd_message("mp_exo_ping_activate");
	killpingfx();
	if(!isdefined(self.exo_cloak_on) || self.exo_cloak_on == 0)
	{
		self.ping_fx = spawnlinkedfx(level.exo_ping_vfx_active,self,"J_SpineUpper");
		triggerfx(self.ping_fx);
	}
}

//Function Number: 9
stop_exo_ping(param_00)
{
	if(!isdefined(self.exo_ping_on) || !self.exo_ping_on)
	{
		return;
	}

	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	self notify("stop_exo_ping");
	self.exo_ping_on = 0;
	if(isdefined(self.highlight_effect))
	{
		maps\mp\_threatdetection::detection_highlight_hud_effect_off(self.highlight_effect);
	}

	self unsetperk("specialty_exo_ping",1);
	self batterydischargeend("exoping_equipment_mp");
	maps\mp\_exo_battery::set_exo_ability_hud_omnvar("exoping_equipment_mp","ui_exo_battery_toggle",0);
	killpingfx();
	if(param_00 == 1)
	{
		maps\mp\_snd_common_mp::snd_message("mp_exo_ping_deactivate");
		wait(0.05);
		if(!isdefined(self.exo_cloak_on) || self.exo_cloak_on == 0)
		{
			self.ping_fx = spawnlinkedfx(level.exo_ping_vfx_inactive,self,"J_SpineUpper");
			triggerfx(self.ping_fx);
		}
	}
}

//Function Number: 10
wait_for_player_death()
{
	level endon("game_ended");
	self endon("disconnect");
	common_scripts\utility::waittill_any("death","joined_team","faux_spawn","exo_ping_taken");
	thread stop_exo_ping(0);
}

//Function Number: 11
wait_for_game_end()
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("faux_spawn");
	self endon("exo_ping_taken");
	level waittill("game_ended");
	thread stop_exo_ping(0);
}