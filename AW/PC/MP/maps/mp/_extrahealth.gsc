/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/_extrahealth.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 160 ms
 * Timestamp: 10/27/2023 1:48:58 AM
*******************************************************************/

//Function Number: 1
watchextrahealthusage()
{
	self notify("exo_health_taken");
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self endon("joined_team");
	self endon("faux_spawn");
	self endon("exo_health_taken");
	if(!self hasweapon("extra_health_mp"))
	{
		return;
	}

	extrahealthinit();
	thread monitorplayerdeath();
	thread wait_for_game_end();
	for(;;)
	{
		self waittill("exo_ability_activate",var_00);
		if(var_00 == "extra_health_mp")
		{
			if(!isalive(self))
			{
				return;
			}

			thread tryuseextrahealth();
		}
	}
}

//Function Number: 2
extrahealthinit()
{
	self.exo_health_on = 0;
	self batterysetdischargescale("extra_health_mp",1);
	var_00 = self batterygetsize("extra_health_mp");
	if(self gettacticalweapon() == "extra_health_mp")
	{
		self setclientomnvar("exo_ability_nrg_req0",0);
		self setclientomnvar("exo_ability_nrg_total0",var_00);
		self setclientomnvar("ui_exo_battery_level0",var_00);
	}
	else if(self getlethalweapon() == "extra_health_mp")
	{
		self setclientomnvar("exo_ability_nrg_req1",0);
		self setclientomnvar("exo_ability_nrg_total1",var_00);
		self setclientomnvar("ui_exo_battery_level1",var_00);
	}

	if(!isdefined(level.exo_health_le_inactive_vfx))
	{
		level.exo_health_le_inactive_vfx = loadfx("vfx/unique/exo_health_le_inactive");
	}

	if(!isdefined(level.exo_health_le_active_vfx))
	{
		level.exo_health_le_active_vfx = loadfx("vfx/unique/exo_health_le_active");
	}

	if(!isdefined(level.exo_health_rt_inactive_vfx))
	{
		level.exo_health_rt_inactive_vfx = loadfx("vfx/unique/exo_health_rt_inactive");
	}

	if(!isdefined(level.exo_health_rt_active_vfx))
	{
		level.exo_health_rt_active_vfx = loadfx("vfx/unique/exo_health_rt_active");
	}

	wait(0.05);
	if(!maps\mp\_utility::invirtuallobby())
	{
		playfxontag(level.exo_health_le_inactive_vfx,self,"J_Shoulder_LE");
		playfxontag(level.exo_health_rt_inactive_vfx,self,"J_Shoulder_RI");
	}
}

//Function Number: 3
tryuseextrahealth()
{
	self endon("exo_health_taken");
	if(self.exo_health_on == 1)
	{
		thread stopextrahealth(1);
		return;
	}

	thread startextrahealth();
}

//Function Number: 4
killstimfx()
{
	if(isdefined(self.stim_fx_l))
	{
		self.stim_fx_l delete();
		self.stim_fx_l = undefined;
	}

	if(isdefined(self.stim_fx_r))
	{
		self.stim_fx_r delete();
		self.stim_fx_r = undefined;
	}
}

//Function Number: 5
startextrahealth()
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("faux_spawn");
	self endon("exo_health_taken");
	self endon("EndExtraHealth");
	self.exo_health_on = 1;
	self.maxhealth = int(self.maxhealth * 1.4);
	self.ignoreregendelay = 1;
	self.healthregenlevel = 0.99;
	self notify("damage");
	self batterydischargebegin("extra_health_mp");
	maps\mp\_exo_battery::set_exo_ability_hud_omnvar("extra_health_mp","ui_exo_battery_toggle",1);
	thread maps\mp\_exo_battery::update_exo_battery_hud("extra_health_mp");
	thread monitory_health_battery_charge();
	maps\mp\_snd_common_mp::snd_message("mp_exo_health_activate");
	killstimfx();
	wait(0.05);
	if(!self.exo_health_on)
	{
		return;
	}

	if(!isdefined(self.exo_cloak_on) || self.exo_cloak_on == 0)
	{
		self.stim_fx_l = spawnlinkedfx(level.exo_health_le_active_vfx,self,"J_Shoulder_LE");
		self.stim_fx_r = spawnlinkedfx(level.exo_health_rt_active_vfx,self,"J_Shoulder_RI");
		triggerfx(self.stim_fx_l);
		triggerfx(self.stim_fx_r);
	}
}

//Function Number: 6
stopextrahealth(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("faux_spawn");
	self endon("exo_health_taken");
	if(!isdefined(self.exo_health_on) || !self.exo_health_on)
	{
		return;
	}

	self notify("EndExtraHealth");
	self endon("EndExtraHealth");
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	self.exo_health_on = 0;
	if(isdefined(level.ishorde))
	{
		self.maxhealth = self.classmaxhealth + self.hordearmor * 40;
	}
	else
	{
		self.maxhealth = int(self.maxhealth / 1.4);
	}

	if(self.health > self.maxhealth)
	{
		self.health = self.maxhealth;
	}

	self.healthregenlevel = undefined;
	self batterydischargeend("extra_health_mp");
	maps\mp\_exo_battery::set_exo_ability_hud_omnvar("extra_health_mp","ui_exo_battery_toggle",0);
	killstimfx();
	if(param_00 == 1)
	{
		maps\mp\_snd_common_mp::snd_message("mp_exo_health_deactivate");
		wait(0.05);
		if(!isdefined(self.exo_cloak_on) || self.exo_cloak_on == 0)
		{
			self.stim_fx_l = spawnlinkedfx(level.exo_health_le_inactive_vfx,self,"J_Shoulder_LE");
			self.stim_fx_r = spawnlinkedfx(level.exo_health_rt_inactive_vfx,self,"J_Shoulder_RI");
			triggerfx(self.stim_fx_l);
			triggerfx(self.stim_fx_r);
		}
	}
}

//Function Number: 7
monitorplayerdeath()
{
	level endon("game_ended");
	self endon("disconnect");
	common_scripts\utility::waittill_any("death","joined_team","faux_spawn","exo_health_taken");
	thread stopextrahealth(0);
}

//Function Number: 8
monitory_health_battery_charge()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("faux_spawn");
	self endon("exo_health_taken");
	while(self.exo_health_on == 1)
	{
		if(self batterygetcharge("extra_health_mp") <= 0)
		{
			thread stopextrahealth(1);
		}

		wait(0.05);
	}
}

//Function Number: 9
take_exo_health()
{
	self notify("kill_battery");
	self notify("exo_health_taken");
	self takeweapon("extra_health_mp");
}

//Function Number: 10
give_exo_health()
{
	self giveweapon("extra_health_mp");
	thread watchextrahealthusage();
}

//Function Number: 11
wait_for_game_end()
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("faux_spawn");
	self endon("exo_health_taken");
	level waittill("game_ended");
	thread stopextrahealth(0);
}