/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: captured_actions.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 273 ms
 * Timestamp: 4/22/2024 2:25:56 AM
*******************************************************************/

//Function Number: 1
s3_escape_gun_action(param_00,param_01)
{
	var_02 = common_scripts\utility::getstruct("s3_escape_get_weapon_marker","targetname");
	param_01 = var_02.origin;
	var_03 = maps\_shg_utility::hint_button_position("use",param_01,72);
	param_00 waittill("trigger");
	level notify("captured_action_complete");
	var_03 maps\_shg_utility::hint_button_clear();
}

//Function Number: 2
s3_escape_hack_action(param_00,param_01)
{
	var_02 = common_scripts\utility::getstruct("s3_escape_console_use_marker","targetname");
	param_01 = var_02.origin;
	level.script_button = maps\_shg_utility::hint_button_position("use",param_01,10);
	s3_escape_hack_action_switcher(param_00,param_01);
	level notify("captured_action_complete");
	if(!isremovedentity(level.script_button))
	{
		level.script_button maps\_shg_utility::hint_button_clear();
	}
}

//Function Number: 3
s3_escape_hack_action_switcher(param_00,param_01)
{
	param_00 endon("trigger");
	for(;;)
	{
		if(!common_scripts\utility::flag("flag_s3_escape_at_console"))
		{
			param_00 makeunusable();
			level.script_button maps\_shg_utility::hint_button_clear();
			level.script_button = maps\_shg_utility::hint_button_position("use",param_01,10);
		}

		common_scripts\utility::flag_wait("flag_s3_escape_at_console");
		param_00 makeusable();
		level.script_button maps\_shg_utility::hint_button_clear();
		level.script_button = maps\_shg_utility::hint_button_position("use",param_01,50);
		common_scripts\utility::flag_waitopen("flag_s3_escape_at_console");
	}
}

//Function Number: 4
s3_escape_console_gun_action(param_00,param_01,param_02)
{
	param_00 endon("s3escape_console_ender");
	level.player takeallweapons();
	level.player enableweaponpickup();
	level.player enableweapons();
	level.player waittill("pickup");
	setsaveddvar("ammoCounterHide","1");
	level.player hideviewmodel();
	common_scripts\utility::flag_set("s3_player_pickedup_console_gun");
	level.player notify("captured_action_complete");
	param_00 maps\_anim::anim_single_solo(param_01,"s3escape_console_end");
	setsaveddvar("g_friendlyNameDist",level.friendlynamedist);
	level.player unlink();
	param_01 delete();
	param_02 delete();
	level.player allowfire(1);
	level.player showviewmodel();
	level.player thread maps\captured_util::start_one_handed_gunplay("iw5_titan45pickup_sp_xmags");
	level.player setweaponammoclip("iw5_titan45_sp",0);
	level.player switchtoweaponimmediate("iw5_titan45_sp");
	level.player allowmelee(1);
	level.player allowsprint(1);
	level.player allowcrouch(1);
	level.player allowjump(1);
	level.player allowprone(1);
}

//Function Number: 5
autopsy_door_action(param_00,param_01)
{
	var_02 = common_scripts\utility::getstruct("struct_vign_autopsy_doctor_door","targetname");
	var_03 = var_02.origin + (0,-14,51);
	var_04 = maps\_shg_utility::hint_button_position("use",var_03,80);
	param_00 waittill("trigger");
	level notify("captured_action_complete");
	var_04 maps\_shg_utility::hint_button_clear();
}

//Function Number: 6
incinerator_push_action(param_00,param_01)
{
	var_02 = common_scripts\utility::getstruct("struct_anim_incinerator","targetname");
	param_01 = var_02.origin + (-40,20,-20);
	var_03 = maps\_shg_utility::hint_button_position("use",param_01,60);
	param_00 waittill("trigger");
	level notify("captured_action_complete");
	var_03 maps\_shg_utility::hint_button_clear();
}

//Function Number: 7
mech_entry_action()
{
	var_00 = common_scripts\utility::getstruct("struct_prompt_mechenter","targetname");
	var_01 = var_00.origin;
	var_02 = maps\_shg_utility::hint_button_position("use",var_01,72);
	level waittill("captured_action_complete");
	level.player disablealternatemelee();
	var_02 maps\_shg_utility::hint_button_clear();
}

//Function Number: 8
prompt_show_hide(param_00,param_01)
{
	level endon(param_01);
	if(!common_scripts\utility::flag_exist(param_00))
	{
		common_scripts\utility::flag_init(param_00);
	}

	var_02 = 0;
	for(;;)
	{
		if(!var_02 && common_scripts\utility::flag(param_00))
		{
			common_scripts\utility::trigger_on();
			var_02 = 1;
		}
		else if(!common_scripts\utility::flag(param_00) && var_02)
		{
			common_scripts\utility::trigger_off();
			var_02 = 0;
		}

		wait(0.05);
	}
}

//Function Number: 9
captured_hint_display(param_00,param_01)
{
	captured_hint_range_check(param_00,param_01) common_scripts\utility::flag_set("flag_display_hint");
}

//Function Number: 10
captured_hint_range_check(param_00,param_01)
{
	level endon("captured_hint_ender");
	for(;;)
	{
		level.player maps\_utility::waittill_in_range(self.origin,param_01);
		common_scripts\utility::flag_clear("flag_display_hint");
		maps\_utility::hintdisplayhandler(param_00);
		level.player maps\_utility::waittill_entity_out_of_range(self,param_01);
		common_scripts\utility::flag_set("flag_display_hint");
	}
}

//Function Number: 11
captured_hint_ender_function()
{
	if(common_scripts\utility::flag("flag_display_hit"))
	{
		return 1;
	}
}

//Function Number: 12
captured_use_console()
{
}

//Function Number: 13
captured_push_cart()
{
}

//Function Number: 14
captured_open_door()
{
}

//Function Number: 15
captured_take_exo()
{
}

//Function Number: 16
captured_enter_exo()
{
}

//Function Number: 17
captured_break_lock()
{
}