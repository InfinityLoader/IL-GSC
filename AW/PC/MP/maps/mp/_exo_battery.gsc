/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/_exo_battery.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 81 ms
 * Timestamp: 10/27/2023 1:48:43 AM
*******************************************************************/

//Function Number: 1
update_exo_battery_hud(param_00)
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("faux_spawn");
	self endon("kill_battery");
	if(!isplayer(self))
	{
		return;
	}

	while(get_exo_ability_hud_omnvar_value(param_00,"ui_exo_battery_toggle") == 1)
	{
		var_01 = self batterygetcharge(param_00);
		set_exo_ability_hud_omnvar(param_00,"ui_exo_battery_level",var_01);
		wait(0.05);
	}
}

//Function Number: 2
set_exo_ability_hud_omnvar(param_00,param_01,param_02)
{
	if(self gettacticalweapon() == param_00)
	{
		self setclientomnvar(param_01 + "0",param_02);
		if(param_01 == "ui_exo_battery_toggle")
		{
			if(param_02 == 1)
			{
				self setclientomnvar("ui_exo_battery_iconA",param_00);
				return;
			}

			return;
		}

		return;
	}

	if(self getlethalweapon() == param_00)
	{
		self setclientomnvar(param_01 + "1",param_02);
		if(param_01 == "ui_exo_battery_toggle")
		{
			if(param_02 == 1)
			{
				self setclientomnvar("ui_exo_battery_iconB",param_00);
				return;
			}

			return;
		}

		return;
	}

	self setclientomnvar("ui_exo_battery_iconA","reset");
	self setclientomnvar("ui_exo_battery_iconB","reset");
	self setclientomnvar("ui_exo_battery_toggle0",0);
	self setclientomnvar("ui_exo_battery_toggle1",0);
}

//Function Number: 3
get_exo_ability_hud_omnvar_value(param_00,param_01)
{
	if(self gettacticalweapon() == param_00)
	{
		return self getclientomnvar(param_01 + "0");
	}
	else if(self getlethalweapon() == param_00)
	{
		return self getclientomnvar(param_01 + "1");
	}

	return -1;
}

//Function Number: 4
play_insufficient_tactical_energy_sfx()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self endon("faux_spawn");
	self endon("joined_team");
	self endon("kill_battery");
	self notifyonplayercommandremove("tried_left_exo_ability","+smoke");
	wait(0.05);
	self notifyonplayercommand("tried_left_exo_ability","+smoke");
	for(;;)
	{
		self waittill("tried_left_exo_ability");
		var_00 = self gettacticalweapon();
		if(maps\mp\_utility::is_exo_ability_weapon(var_00))
		{
			if(self batterygetcharge(var_00) < batteryreqtouse(var_00))
			{
				self playlocalsound("mp_exo_bat_empty");
			}
		}
	}
}

//Function Number: 5
play_insufficient_lethal_energy_sfx()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self endon("faux_spawn");
	self endon("joined_team");
	self endon("kill_battery");
	self notifyonplayercommandremove("tried_right_exo_ability","+frag");
	wait(0.05);
	self notifyonplayercommand("tried_right_exo_ability","+frag");
	for(;;)
	{
		self waittill("tried_right_exo_ability");
		var_00 = self getlethalweapon();
		if(maps\mp\_utility::is_exo_ability_weapon(var_00))
		{
			if(self batterygetcharge(var_00) < batteryreqtouse(var_00))
			{
				self playlocalsound("mp_exo_bat_empty");
			}
		}
	}
}