/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/_exo_shield_sp.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 331 ms
 * Timestamp: 10/27/2023 1:58:50 AM
*******************************************************************/

//Function Number: 1
init()
{
	precacheitem("s1_exo_shield_sp");
	precacheshader("dpad_icon_shield");
	precacheshader("dpad_icon_shield_off");
	level.player maps\_utility::set_unstorable_weapon("s1_exo_shield_sp");
	precachestring(&"GAME_CROUCH_BLOCKED_WEAPON");
	maps\_utility::add_hint_string("EXO_SHIELD_CROUCH_BLOCKED_WEAPON",&"GAME_CROUCH_BLOCKED_WEAPON");
	if(!isdefined(level.player.exoparams))
	{
		level.player.exoparams = [];
	}

	level.player.exoparams["shield"] = spawnstruct();
	var_00 = level.player.exoparams["shield"];
	var_00.weapon_name = "s1_exo_shield_sp";
	var_00.activation_cost = 1;
	var_00.state = "disabled";
	var_00.return_after_offhand = 1;
	var_00.duration = 15;
	level.player thread monitor_unauthorized_shield();
	level.player thread monitor_failed_switchback();
	if(!level.player maps\_utility::ent_flag_exist("exo_shield_on"))
	{
		level.player maps\_utility::ent_flag_init("exo_shield_on");
	}
}

//Function Number: 2
get_exo_shield_params()
{
	return level.player.exoparams["shield"];
}

//Function Number: 3
state_change(param_00)
{
	var_01 = get_exo_shield_params();
	var_02 = is_shield_up_state(var_01.state);
	var_03 = is_shield_up_state(param_00);
	var_01.state = param_00;
	if(!var_02 && var_03)
	{
		on_shield_up();
		return;
	}

	if(var_02 && !var_03)
	{
		on_shield_down();
	}
}

//Function Number: 4
is_shield_up_state(param_00)
{
	return isdefined(param_00) && param_00 == "raised";
}

//Function Number: 5
on_shield_up()
{
	var_00 = get_exo_shield_params();
	level.player maps\_utility::playerallowalternatemelee(0,"exo_shield");
	level.player.forcealtmeleedeaths = 1;
}

//Function Number: 6
on_shield_down()
{
	var_00 = get_exo_shield_params();
	level.player maps\_utility::playerallowalternatemelee(1,"exo_shield");
	level.player.forcealtmeleedeaths = undefined;
}

//Function Number: 7
enable_shield_ability()
{
	level.player endon("exo_shield_disabled");
	level.player notify("exo_shield_enabled");
	state_change("idle");
	var_00 = get_exo_shield_params();
	update_exo_shield_icon();
	level.player notifyonplayercommand("exo_shield_toggle","+actionslot 2");
	level.player waittill("exo_shield_toggle");
	switch(var_00.state)
	{
		case "equipping":
		case "raised":
			break;

		case "idle":
			break;
	}
}

//Function Number: 8
disable_shield_ability()
{
	var_00 = get_exo_shield_params();
	level.player setweaponhudiconoverride("actionslot2","dpad_icon_shield_off");
	switch(var_00.state)
	{
		case "equipping":
		case "raised":
			break;
	}
}

//Function Number: 9
try_raise_shield()
{
	var_00 = get_exo_shield_params();
	var_01 = 0;
	if(level.player getstance() == "prone")
	{
		level.player setstance("crouch");
	}

	if(level.player getstance() == "prone")
	{
		maps\_utility::display_hint("EXO_SHIELD_CROUCH_BLOCKED_WEAPON",undefined,undefined,undefined,200);
		var_01 = 1;
	}
	else if(level.player isthrowinggrenade() || level.player isonladder())
	{
		var_01 = 1;
	}
	else if(maps\_player_exo::batteryspend(var_00.activation_cost))
	{
		raise_shield();
	}

	if(var_01)
	{
		maps\_player_exo::exofailfx();
	}
}

//Function Number: 10
raise_shield()
{
	level.player endon("exo_shield_disabled");
	level.player endon("exo_shield_lower");
	level.player endon("exo_shield_removed");
	level.player maps\_utility::ent_flag_set("exo_shield_on");
	var_00 = get_exo_shield_params();
	state_change("equipping");
	var_00.previous_weapon = level.player getcurrentprimaryweapon();
	level.player giveweapon(var_00.weapon_name);
	soundscripts\_snd::snd_message("exo_raise_shield");
	level.player thread monitor_equip_interrupt();
	level.player switchtoweapon(var_00.weapon_name);
	var_01 = undefined;
	var_02 = level.player getcurrentweapon(1);
	while(!isdefined(var_01) || var_01 || var_02 == "none")
	{
		level.player waittill("weapon_change");
		var_01 = level.player isonladder();
		var_02 = level.player getcurrentweapon(1);
	}

	var_03 = level.player getcurrentweapon(0) == var_00.weapon_name;
	if(!var_03)
	{
		var_02 = level.player getcurrentweapon();
		if(var_02 == var_00.weapon_name || var_02 == "none")
		{
			switch_to_previous_weapon();
		}

		_remove_shield();
		return;
	}

	level.player notify("exo_shield_equipped");
	state_change("raised");
	thread monitor_shield_switchout();
	thread monitor_shield_timeout();
}

//Function Number: 11
monitor_equip_interrupt()
{
	level.player endon("exo_shield_equipped");
	level.player endon("exo_shield_removed");
	level.player childthread monitor_shield_stolen();
	level.player common_scripts\utility::waittill_any("exo_shield_disabled","exo_shield_lower");
	_remove_shield();
}

//Function Number: 12
monitor_shield_stolen()
{
	level.player endon("exo_shield_disabled");
	level.player endon("exo_shield_lower");
	var_00 = get_exo_shield_params();
	for(;;)
	{
		level.player waittill("weapon_taken",var_01);
		if(issubstr(var_01,var_00.weapon_name))
		{
			state_change("idle");
			level.player notify("exo_shield_removed");
		}
	}
}

//Function Number: 13
lower_shield(param_00)
{
	var_01 = get_exo_shield_params();
	level.player notify("exo_shield_lower");
	soundscripts\_snd::snd_message("exo_lower_shield");
	level.player maps\_utility::ent_flag_clear("exo_shield_on");
	var_02 = level.player getcurrentweapon();
	if(var_02 == "none" || var_02 == var_01.weapon_name || var_01.state == "equipping")
	{
		switch_to_previous_weapon(param_00);
	}
}

//Function Number: 14
_remove_shield()
{
	var_00 = get_exo_shield_params();
	level.player takeweapon(var_00.weapon_name);
	state_change("idle");
	level.player notify("exo_shield_removed");
}

//Function Number: 15
switch_to_previous_weapon(param_00)
{
	var_01 = get_exo_shield_params();
	var_02 = undefined;
	if(isdefined(var_01.previous_weapon) && level.player hasweapon(var_01.previous_weapon))
	{
		var_02 = var_01.previous_weapon;
	}
	else
	{
		var_02 = level.player maps\_utility::get_first_storable_weapon();
	}

	if(!isdefined(var_02) && var_02 != "none")
	{
	}

	if(isdefined(var_02))
	{
		if(isdefined(param_00) && param_00)
		{
			level.player switchtoweaponimmediate(var_02);
			return;
		}

		level.player switchtoweapon(var_02);
	}
}

//Function Number: 16
monitor_shield_timeout()
{
	var_00 = get_exo_shield_params();
	level.player endon("exo_shield_removed");
	var_00.start_time = gettime();
	wait(var_00.duration);
	if(var_00.state == "raised")
	{
		if(level.player isusingoffhand())
		{
			offhand_switchout();
			return;
		}

		var_02 = level.player getcurrentweapon(0) == var_00.weapon_name;
		lower_shield(!var_02);
	}
}

//Function Number: 17
monitor_shield_switchout()
{
	var_00 = get_exo_shield_params();
	level.player endon("exo_shield_removed");
	var_01 = 0;
	if(!var_01)
	{
		level.player common_scripts\utility::waittill_any("weapon_switch_started","weapon_change","exo_shield_toggle");
		var_02 = level.player getcurrentweapon(0) == var_00.weapon_name;
		var_03 = !var_02 && level.player getcurrentweapon(1) == var_00.weapon_name;
		var_04 = level.player isusingoffhand() || level.player isthrowinggrenade();
		var_05 = level.player hasweapon(var_00.weapon_name);
		var_06 = !var_03 && var_05 && level.player isonladder();
		switch(var_00.state)
		{
			case "raised":
				break;

			default:
				break;
		}
	}
}

//Function Number: 18
monitor_failed_switchback()
{
	var_00 = get_exo_shield_params();
	level.player endon("death");
	for(;;)
	{
		level.player waittill("weapon_switch_invalid",var_01,var_02);
		if(isdefined(var_01) && var_01 == var_00.weapon_name)
		{
			switch_to_previous_weapon(var_02);
		}
	}
}

//Function Number: 19
monitor_unauthorized_shield()
{
	var_00 = get_exo_shield_params();
	level.player endon("death");
	for(;;)
	{
		level.player waittill("weapon_switch_started",var_01);
		if((var_00.state == "disabled" || var_00.state == "idle") && level.player hasweapon(var_00.weapon_name))
		{
			level.player takeweapon(var_00.weapon_name);
			if(isdefined(var_01) && var_01 == var_00.weapon_name)
			{
				switch_to_previous_weapon(0);
			}
		}
	}
}

//Function Number: 20
offhand_switchout()
{
	var_00 = get_exo_shield_params();
	var_01 = level.player isusingoffhand();
	while(!var_01)
	{
		wait 0.05;
		var_01 = level.player isusingoffhand();
	}

	lower_shield(1);
	_remove_shield();
}

//Function Number: 21
update_exo_shield_icon()
{
	if(!maps\_player_exo::player_exo_is_active())
	{
		level.player setweaponhudiconoverride("actionslot2","none");
		return;
	}

	if(maps\_player_exo::get_exo_battery_percent() > 0)
	{
		level.player setweaponhudiconoverride("actionslot2","dpad_icon_shield");
		return;
	}

	level.player setweaponhudiconoverride("actionslot2","dpad_icon_shield_off");
}