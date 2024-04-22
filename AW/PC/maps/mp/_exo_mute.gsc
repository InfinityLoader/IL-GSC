/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\_exo_mute.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 170 ms
 * Timestamp: 4/22/2024 2:15:43 AM
*******************************************************************/

//Function Number: 1
exo_mute_think()
{
	self notify("exo_mute_taken");
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("faux_spawn");
	self endon("exo_mute_taken");
	if(!self hasweapon("exomute_equipment_mp"))
	{
		return;
	}

	exo_mute_init();
	thread monitor_player_death();
	thread wait_for_game_end();
	for(;;)
	{
		self waittill("exo_ability_activate",var_00);
		if(var_00 == "exomute_equipment_mp")
		{
			thread try_use_exo_mute();
		}
	}
}

//Function Number: 2
exo_mute_init()
{
	self.mute_on = 0;
	self batterysetdischargescale("exomute_equipment_mp",1);
	var_00 = self batterygetsize("exomute_equipment_mp");
	if(self gettacticalweapon() == "exomute_equipment_mp")
	{
		self setclientomnvar("exo_ability_nrg_req0",0);
		self setclientomnvar("exo_ability_nrg_total0",var_00);
		self setclientomnvar("ui_exo_battery_level0",var_00);
	}
	else if(self getlethalweapon() == "exomute_equipment_mp")
	{
		self setclientomnvar("exo_ability_nrg_req1",0);
		self setclientomnvar("exo_ability_nrg_total1",var_00);
		self setclientomnvar("ui_exo_battery_level1",var_00);
	}

	if(!isdefined(level.exo_mute_3p))
	{
		level.exo_mute_3p = loadfx("vfx/unique/exo_mute_3p");
	}

	wait(0.05);
	if(!maps\mp\_utility::invirtuallobby())
	{
	}
}

//Function Number: 3
try_use_exo_mute()
{
	self endon("exo_mute_taken");
	if(self.mute_on == 1)
	{
		thread stop_exo_mute(1);
		return;
	}

	thread start_exo_mute();
}

//Function Number: 4
killmutefx()
{
	if(isdefined(self.mute_fx))
	{
		self.mute_fx delete();
		self.mute_fx = undefined;
	}
}

//Function Number: 5
start_exo_mute()
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("faux_spawn");
	self endon("exo_mute_taken");
	self endon("end_exo_mute");
	self.mute_on = 1;
	maps\mp\_utility::giveperk("specialty_quieter",0);
	self batterydischargebegin("exomute_equipment_mp");
	maps\mp\_exo_battery::set_exo_ability_hud_omnvar("exomute_equipment_mp","ui_exo_battery_toggle",1);
	thread maps\mp\_exo_battery::update_exo_battery_hud("exomute_equipment_mp");
	thread monitor_mute_battery_charge();
	maps\mp\_snd_common_mp::snd_message("mp_exo_mute_activate");
	wait(0.05);
	if(!self.mute_on)
	{
		return;
	}

	if(!isdefined(self.exo_cloak_on) || self.exo_cloak_on == 0)
	{
		self.mute_fx = spawnlinkedfx(level.exo_mute_3p,self,"TAG_ORIGIN");
		triggerfx(self.mute_fx);
	}
}

//Function Number: 6
stop_exo_mute(param_00)
{
	if(!isdefined(self.mute_on) || !self.mute_on)
	{
		return;
	}

	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	self notify("end_exo_mute");
	self.mute_on = 0;
	self unsetperk("specialty_quieter",1);
	self batterydischargeend("exomute_equipment_mp");
	maps\mp\_exo_battery::set_exo_ability_hud_omnvar("exomute_equipment_mp","ui_exo_battery_toggle",0);
	killmutefx();
	if(param_00 == 1)
	{
		maps\mp\_snd_common_mp::snd_message("mp_exo_mute_deactivate");
		wait(0.05);
		if(!isdefined(self.exo_cloak_on) || self.exo_cloak_on == 0)
		{
		}
	}
}

//Function Number: 7
monitor_player_death()
{
	self endon("disconnect");
	common_scripts\utility::waittill_any("death","joined_team","faux_spawn","exo_mute_taken");
	thread stop_exo_mute(0);
}

//Function Number: 8
monitor_mute_battery_charge()
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("faux_spawn");
	self endon("exo_mute_taken");
	self endon("end_exo_mute");
	while(self.mute_on == 1)
	{
		if(self batterygetcharge("exomute_equipment_mp") <= 0)
		{
			thread stop_exo_mute(1);
		}

		wait(0.05);
	}
}

//Function Number: 9
take_exo_mute()
{
	self notify("kill_battery");
	self notify("exo_mute_taken");
	self takeweapon("exomute_equipment_mp");
}

//Function Number: 10
give_exo_mute()
{
	self giveweapon("exomute_equipment_mp");
	thread exo_mute_think();
}

//Function Number: 11
wait_for_game_end()
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("faux_spawn");
	self endon("exo_mute_taken");
	level waittill("game_ended");
	thread stop_exo_mute(0);
}