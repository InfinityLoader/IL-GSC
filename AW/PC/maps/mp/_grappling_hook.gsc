/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\_grappling_hook.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 181 ms
 * Timestamp: 4/22/2024 2:15:56 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(maps\mp\_utility::isgrapplinghookgamemode())
	{
		level thread grappling_hook_on_player_connect();
	}
}

//Function Number: 2
grappling_hook_on_player_connect()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread grappling_hook_on_loadout_given();
	}
}

//Function Number: 3
grappling_hook_on_loadout_given()
{
	level endon("game_ended");
	for(;;)
	{
		self waittill("applyLoadout");
		if(!maps\mp\_utility::isjuggernaut())
		{
			give_grappling_hook();
			thread grappling_hook_wait_for_death();
			thread grappling_hook_wait_for_game_end();
		}
	}
}

//Function Number: 4
grappling_hook_wait_for_death()
{
	level endon("game_ended");
	self endon("disconnect");
	common_scripts\utility::waittill_any("death","joined_team","faux_spawn","grappling_hook_reset","entering_juggernaut");
	maps\mp\_exo_battery::set_exo_ability_hud_omnvar(level.grapplinghookweapon,"ui_exo_battery_toggle",0);
}

//Function Number: 5
grappling_hook_wait_for_game_end()
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("faux_spawn");
	self endon("grappling_hook_reset");
	self endon("grappling_hook_battery_hud_reset");
	level waittill("game_ended");
	maps\mp\_exo_battery::set_exo_ability_hud_omnvar(level.grapplinghookweapon,"ui_exo_battery_toggle",0);
}

//Function Number: 6
give_grappling_hook()
{
	var_00 = get_grappling_hook_weapon();
	if(self hasweapon(var_00))
	{
		return;
	}

	self settacticalweapon(var_00);
	self giveweapon(var_00);
	self notify("grappling_hook_reset");
	var_01 = spawn("script_model",(0,0,0));
	var_01 setentityowner(self);
	var_01 setotherent(self);
	self setgrapplinghooktarget(var_01);
	thread common_scripts\utility::delete_on_death(var_01);
	thread delete_on_reset(var_01);
	var_02 = self batterygetsize(level.grapplinghookweapon);
	self setclientomnvar("ui_exo_battery_level0",var_02);
	self setclientomnvar("exo_ability_nrg_req0",batteryreqtouse(level.grapplinghookweapon));
	self setclientomnvar("exo_ability_nrg_total0",var_02);
	self setclientomnvar("ui_invalid_grapple",0);
	thread wait_for_grappling_hook_pressed();
}

//Function Number: 7
wait_for_full_battery()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self endon("joined_team");
	self endon("grappling_hook_reset");
	self endon("grappling_hook_battery_hud_reset");
	var_00 = self batterygetsize(level.grapplinghookweapon);
	for(;;)
	{
		var_01 = self batterygetcharge(level.grapplinghookweapon);
		if(var_01 >= var_00)
		{
			maps\mp\_exo_battery::set_exo_ability_hud_omnvar(level.grapplinghookweapon,"ui_exo_battery_toggle",0);
			return;
		}

		wait(0.1);
	}
}

//Function Number: 8
wait_for_grappling_hook_pressed()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self endon("joined_team");
	self endon("grappling_hook_reset");
	for(;;)
	{
		self waittill("exo_ability_activate",var_00,var_01);
		if(var_00 == level.grapplinghookweapon && isdefined(var_01))
		{
			if(var_01 == 1)
			{
				self notify("grappling_hook_battery_hud_reset");
				if(isdefined(self.last_grapple_time))
				{
					self.last_grapple_time_prev = self.last_grapple_time;
				}

				self.last_grapple_time = gettime();
				maps\mp\_exo_battery::set_exo_ability_hud_omnvar(level.grapplinghookweapon,"ui_exo_battery_toggle",1);
				thread maps\mp\_exo_battery::update_exo_battery_hud(level.grapplinghookweapon);
				thread wait_for_full_battery();
				maps\mp\gametypes\_missions::processchallenge("ch_tier2_2_iw5_dlcgun12");
				if(isdefined(self.lastdamagedtime) && isdefined(self.last_grapple_time))
				{
					if(self.last_grapple_time - self.lastdamagedtime < 1500)
					{
						maps\mp\gametypes\_missions::processchallenge("ch_tier2_5_iw5_dlcgun12");
					}
				}

				continue;
			}

			if(var_01 == 0)
			{
				thread pulse_grapple_hud_message(2);
				continue;
			}

			if(var_01 == -1)
			{
				thread pulse_grapple_hud_message(1);
			}
		}
	}
}

//Function Number: 9
pulse_grapple_hud_message(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	self setclientomnvar("ui_invalid_grapple",param_00);
	if(param_00 == 1)
	{
		self setclientomnvar("ui_border_warning_toggle",0);
		wait(0.6);
	}
	else if(param_00 == 2)
	{
		wait(1);
	}

	self setclientomnvar("ui_invalid_grapple",0);
}

//Function Number: 10
take_grappling_hook()
{
	var_00 = get_grappling_hook_weapon();
	self settacticalweapon("none");
	self takeweapon(var_00);
	self notify("grappling_hook_reset");
}

//Function Number: 11
get_grappling_hook_weapon()
{
	if(isdefined(level.grapplinghookweapon))
	{
		return level.grapplinghookweapon;
	}

	level.grapplinghookweapon = "iw5_dlcgun12loot7_mp";
	return level.grapplinghookweapon;
}

//Function Number: 12
delete_on_reset(param_00)
{
	param_00 endon("death");
	self waittill("grappling_hook_reset");
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}