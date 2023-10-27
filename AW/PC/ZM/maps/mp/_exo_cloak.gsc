/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/_exo_cloak.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 179 ms
 * Timestamp: 10/27/2023 2:08:14 AM
*******************************************************************/

//Function Number: 1
give_exo_cloak()
{
	var_00 = get_exo_cloak_weapon();
	if(self hasweapon(var_00))
	{
		return;
	}

	self giveweapon(var_00);
	self batterysetdischargescale(var_00,1);
	self.exo_cloak_on = 0;
	self.exo_cloak_off_time = undefined;
	if(self gettacticalweapon() == var_00)
	{
		self setclientomnvar("ui_exo_battery_level0",self batterygetcharge(var_00));
		self setclientomnvar("exo_ability_nrg_req0",batteryreqtouse(var_00));
		self setclientomnvar("exo_ability_nrg_total0",self batterygetsize(var_00));
	}
	else if(self getlethalweapon() == var_00)
	{
		self setclientomnvar("ui_exo_battery_level1",self batterygetcharge(var_00));
		self setclientomnvar("exo_ability_nrg_req1",batteryreqtouse(var_00));
		self setclientomnvar("exo_ability_nrg_total1",self batterygetsize(var_00));
	}

	if(!isdefined(self.exocloak))
	{
		self.exocloak = spawnstruct();
	}

	self.exocloak.costume = [];
	self.exocloak.costume["viewmodel"] = self getviewmodel();
	self.exocloak.costume["body"] = self getmodelfromentity();
	self notify("exo_cloak_reset");
	thread wait_for_exocloak_cancel();
	thread wait_for_exocloak_pressed();
	thread wait_for_player_death();
	thread wait_for_game_end();
}

//Function Number: 2
wait_for_exocloak_pressed()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self endon("joined_team");
	self endon("exo_cloak_reset");
	for(;;)
	{
		self waittill("exo_ability_activate",var_00);
		if(var_00 == level.cloakweapon)
		{
			if(!self iscloaked())
			{
				thread handle_exocloak();
			}
			else
			{
				active_cloaking_disable(1);
			}

			continue;
		}

		if(!maps\mp\_utility::is_exo_ability_weapon(var_00))
		{
			active_cloaking_disable(1);
		}
	}
}

//Function Number: 3
wait_for_exocloak_cancel()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self endon("joined_team");
	self endon("exo_cloak_reset");
	for(;;)
	{
		common_scripts\utility::waittill_any("using_remote","weapon_fired","melee_fired","ground_slam","grenade_fire");
		active_cloaking_disable(1);
	}
}

//Function Number: 4
wait_for_player_death()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("exo_cloak_reset");
	common_scripts\utility::waittill_any("death","faux_spawn","joined_team");
	active_cloaking_disable(1);
}

//Function Number: 5
handle_exocloak()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self endon("faux_spawn");
	self endon("joined_team");
	self endon("exo_cloak_disabled");
	self endon("exo_cloak_reset");
	if(self batterygetcharge(level.cloakweapon) > 0)
	{
		active_cloaking_enable();
		while(self batterygetcharge(level.cloakweapon) > 0)
		{
			wait(0.05);
		}

		active_cloaking_disable(1);
	}
}

//Function Number: 6
active_cloaking_enable()
{
	self.exo_cloak_on = 1;
	self.exo_cloak_off_time = undefined;
	self cloakingenable();
	hideattachmentswhilecloaked();
	self batterydischargebegin(level.cloakweapon);
	maps\mp\_exo_battery::set_exo_ability_hud_omnvar(level.cloakweapon,"ui_exo_battery_toggle",1);
	thread maps\mp\_exo_battery::update_exo_battery_hud(level.cloakweapon);
	maps\mp\_snd_common_mp::snd_message("mp_exo_cloak_activate");
	self.pers["numberOfTimesCloakingUsed"]++;
	if(isdefined(level.ishorde))
	{
		wait(2);
		self.ignoreme = 1;
	}
}

//Function Number: 7
active_cloaking_disable(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	if(!self iscloaked())
	{
		return;
	}

	self.exo_cloak_on = 0;
	self.exo_cloak_off_time = gettime();
	self cloakingdisable();
	showattachmentsaftercloak();
	if(isdefined(level.ishorde))
	{
		self.ignoreme = 0;
	}

	self batterydischargeend(level.cloakweapon);
	maps\mp\_exo_battery::set_exo_ability_hud_omnvar(level.cloakweapon,"ui_exo_battery_toggle",0);
	if(param_00)
	{
		maps\mp\_snd_common_mp::snd_message("mp_exo_cloak_deactivate");
	}

	self notify("exo_cloak_disabled");
}

//Function Number: 8
take_exo_cloak()
{
	var_00 = get_exo_cloak_weapon();
	self notify("kill_battery");
	active_cloaking_disable(0);
	self takeweapon(var_00);
	self notify("exo_cloak_reset");
}

//Function Number: 9
wait_for_game_end()
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("faux_spawn");
	self endon("exo_cloak_reset");
	level waittill("game_ended");
	active_cloaking_disable(1);
}

//Function Number: 10
hideattachmentswhilecloaked()
{
	if(self hasweapon("adrenaline_mp"))
	{
		if(isdefined(self.overclock_on) && self.overclock_on == 1)
		{
			killfxontag(level.exo_overclock_vfx_le_active,self,"J_Hip_LE");
			killfxontag(level.exo_overclock_vfx_ri_active,self,"J_Hip_RI");
		}
		else
		{
			killfxontag(level.exo_overclock_vfx_le_inactive,self,"J_Hip_LE");
			killfxontag(level.exo_overclock_vfx_ri_inactive,self,"J_Hip_RI");
		}
	}

	if(self hasweapon("exorepulsor_equipment_mp"))
	{
		if(isdefined(self.repulsoractive) && self.repulsoractive == 1)
		{
			killfxontag(level.exo_repulsor_player_vfx_active,self,"TAG_JETPACK");
		}
		else
		{
			killfxontag(level.exo_repulsor_player_vfx_inactive,self,"TAG_JETPACK");
		}
	}

	if(self hasweapon("exoping_equipment_mp"))
	{
		if(isdefined(self.exo_ping_on) && self.exo_ping_on == 1)
		{
			killfxontag(level.exo_ping_vfx_active,self,"J_SpineUpper");
		}
		else
		{
			killfxontag(level.exo_ping_vfx_inactive,self,"J_SpineUpper");
		}
	}

	if(self hasweapon("extra_health_mp"))
	{
		if(isdefined(self.exo_health_on) && self.exo_health_on == 1)
		{
			killfxontag(level.exo_health_le_active_vfx,self,"J_Shoulder_LE");
			killfxontag(level.exo_health_rt_active_vfx,self,"J_Shoulder_RI");
			return;
		}

		killfxontag(level.exo_health_le_inactive_vfx,self,"J_Shoulder_LE");
		killfxontag(level.exo_health_rt_inactive_vfx,self,"J_Shoulder_RI");
	}
}

//Function Number: 11
showattachmentsaftercloak()
{
	if(self hasweapon("adrenaline_mp"))
	{
		if(isdefined(self.overclock_on) && self.overclock_on == 1)
		{
			playfxontag(level.exo_overclock_vfx_le_active,self,"J_Hip_LE");
			playfxontag(level.exo_overclock_vfx_ri_active,self,"J_Hip_RI");
		}
		else
		{
			playfxontag(level.exo_overclock_vfx_le_inactive,self,"J_Hip_LE");
			playfxontag(level.exo_overclock_vfx_ri_inactive,self,"J_Hip_RI");
		}
	}

	if(self hasweapon("exorepulsor_equipment_mp"))
	{
		if(isdefined(self.repulsoractive) && self.repulsoractive == 1)
		{
			playfxontag(level.exo_repulsor_player_vfx_active,self,"TAG_JETPACK");
		}
		else
		{
			playfxontag(level.exo_repulsor_player_vfx_inactive,self,"TAG_JETPACK");
		}
	}

	if(self hasweapon("exoping_equipment_mp"))
	{
		if(isdefined(self.exo_ping_on) && self.exo_ping_on == 1)
		{
			playfxontag(level.exo_ping_vfx_active,self,"J_SpineUpper");
		}
		else
		{
			playfxontag(level.exo_ping_vfx_inactive,self,"J_SpineUpper");
		}
	}

	if(self hasweapon("extra_health_mp"))
	{
		if(isdefined(self.exo_health_on) && self.exo_health_on == 1)
		{
			playfxontag(level.exo_health_le_active_vfx,self,"J_Shoulder_LE");
			playfxontag(level.exo_health_rt_active_vfx,self,"J_Shoulder_RI");
			return;
		}

		playfxontag(level.exo_health_le_inactive_vfx,self,"J_Shoulder_LE");
		playfxontag(level.exo_health_rt_inactive_vfx,self,"J_Shoulder_RI");
	}
}

//Function Number: 12
get_exo_cloak_weapon()
{
	if(isdefined(level.cloakweapon))
	{
		return level.cloakweapon;
	}

	level.cloakweapon = "exocloak_equipment_mp";
	if(isdefined(level.ishorde))
	{
		level.cloakweapon = "exocloakhorde_equipment_mp";
	}

	return level.cloakweapon;
}