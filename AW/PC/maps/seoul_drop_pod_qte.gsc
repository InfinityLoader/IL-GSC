/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: seoul_drop_pod_qte.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 54 ms
 * Timestamp: 4/22/2024 2:36:55 AM
*******************************************************************/

//Function Number: 1
anim_single_droppod_custom(param_00,param_01,param_02)
{
	thread maps\_anim::anim_single(param_00,param_02);
	var_03 = getanimlength(param_01 maps\_utility::getanim(param_02));
	var_04 = 9.3;
	var_05 = 14.6666;
	wait(var_04);
	level.player notify("start_droppod_qte");
	thread process_buttonmash(param_01);
	wait(var_05 - var_04);
	level.player notify("end_process_buttonmash");
	param_01 setanimlimited(%seo_pod_phase3_vm_root,0,0.5,1);
	if(param_01.buttonmash_value >= 1)
	{
		wait(var_03 - var_05);
		level.player notify("end_droppod_qte");
		return 1;
	}

	return 0;
}

//Function Number: 2
process_buttonmash(param_00)
{
	level.player endon("end_process_buttonmash");
	param_00.buttonmash_decay_per_frame = 0.025;
	param_00.buttonmash_value = 0;
	param_00.buttonmash_add_per_press = 0.15;
	param_00.buttonmash_max = 1.2;
	level.player notifyonplayercommand("x_pressed","+usereload");
	level.player notifyonplayercommand("x_pressed","+activate");
	param_00 setanimlimited(%seo_pod_phase3_vm_root,0.01,0,1);
	param_00 setanimlimited(%seo_pod_phase3_vm_add,1);
	param_00 setanimtime(%seo_pod_phase3_vm_add,1);
	if(level.player common_scripts\utility::is_player_gamepad_enabled())
	{
		level.player thread maps\_shg_utility::button_mash_dynamic_hint(&"SEOUL_TAP_X_TO_PULL_LEVER","+usereload","end_process_buttonmash","+activate");
	}
	else
	{
		level.player thread maps\_shg_utility::button_mash_dynamic_hint(&"SEOUL_TAP_X_TO_PULL_LEVER","+reload","end_process_buttonmash","+activate");
	}

	thread animation_process(param_00,"x_pressed","b_pressed","a_pressed");
	for(;;)
	{
		level.player common_scripts\utility::waittill_any("x_pressed","b_pressed","a_pressed");
		param_00.buttonmash_value = param_00.buttonmash_value + param_00.buttonmash_add_per_press;
		if(param_00.buttonmash_value > param_00.buttonmash_max)
		{
			param_00.buttonmash_value = param_00.buttonmash_max;
		}
	}
}

//Function Number: 3
animation_process(param_00,param_01,param_02,param_03)
{
	level.player endon("end_process_buttonmash");
	level.player endon(param_01);
	level.player endon(param_02);
	level.player endon(param_03);
	var_04 = 0.05;
	var_05 = param_00.buttonmash_value;
	if(param_00.buttonmash_value > 0.95)
	{
		var_05 = 1;
	}

	param_00 setanimlimited(%seo_pod_phase3_vm_root,var_05,var_04,1);
	wait(var_04);
	for(;;)
	{
		param_00.buttonmash_value = param_00.buttonmash_value - param_00.buttonmash_decay_per_frame;
		if(param_00.buttonmash_value < 0)
		{
			param_00.buttonmash_value = 0;
		}

		var_05 = param_00.buttonmash_value;
		if(param_00.buttonmash_value <= 0)
		{
			var_05 = 0.01;
		}

		param_00 setanimlimited(%seo_pod_phase3_vm_root,var_05,var_04,1);
		wait(var_04);
	}
}