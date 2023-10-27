/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3409.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 3 ms
 * Timestamp: 10/27/2023 12:27:07 AM
*******************************************************************/

//Function Number: 1
func_96F4()
{
	wait(5);
	level.var_773B = [];
	level.var_773B = scripts\common\utility::getstructarray("generator","script_noteworthy");
	scripts\common\utility::flag_init("power_on");
	level.var_D743 = ::func_D744;
	foreach(var_01 in level.var_773B)
	{
		func_95FC(var_01);
	}
}

//Function Number: 2
func_95FC(param_00)
{
	var_01 = getentarray(param_00.target,"targetname");
	var_02 = scripts\common\utility::getstruct(param_00.target,"targetname");
	param_00.var_889B = undefined;
	param_00.var_2F12 = undefined;
	foreach(var_04 in var_01)
	{
		if(var_04.model == "icbm_electricpanel_switch_02")
		{
			param_00.var_889B = var_04;
			continue;
		}

		if(var_04.script_noteworthy == "box")
		{
			param_00.var_2F12 = var_04;
		}
	}
}

//Function Number: 3
func_D744(param_00,param_01)
{
	var_02 = level.var_773B;
	foreach(var_04 in var_02)
	{
		if(scripts\common\utility::istrue(var_04.var_D776))
		{
			level thread func_7736(var_04);
		}
	}

	level notify("power_off");
}

//Function Number: 4
func_7736(param_00)
{
	while(!isdefined(level.current_interaction_structs))
	{
		wait(1);
	}

	thread func_7758(param_00);
	var_01 = param_00.var_EE79;
	var_02 = strtok(var_01,",");
	foreach(var_04 in var_02)
	{
		if(var_04 == "power_all")
		{
			scripts\common\utility::func_6E2A("power_on");
			continue;
		}

		if(scripts\common\utility::func_6E34(var_04 + " power_on"))
		{
			scripts\common\utility::func_6E2A(var_04 + " power_on");
		}
	}

	param_00.var_D776 = undefined;
	scripts\cp\_interaction::add_to_current_interaction_list(param_00);
}

//Function Number: 5
func_7758(param_00)
{
	if(param_00.var_889B.script_noteworthy == "roll")
	{
		param_00.var_889B rotateroll(-60,0.5);
	}
	else if(param_00.var_889B.script_noteworthy == "-roll")
	{
		param_00.var_889B rotateroll(60,0.5);
	}
	else if(param_00.var_889B.script_noteworthy == "pitch")
	{
		param_00.var_889B rotatepitch(-60,0.5);
	}
	else if(param_00.var_889B.script_noteworthy == "-pitch")
	{
		param_00.var_889B rotatepitch(60,0.5);
	}

	if(isdefined(param_00.var_7735))
	{
		param_00.var_7735 delete();
	}
}

//Function Number: 6
func_129A2(param_00)
{
	scripts\cp\zombies\zombie_analytics::func_AF8E(param_00,level.wave_num);
}

//Function Number: 7
func_7757(param_00,param_01)
{
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	if(isdefined(param_01))
	{
		param_01 thread scripts\cp\_utility::firegesturegrenade(param_01,"iw7_powerlever_zm");
	}

	if(!isdefined(param_01))
	{
		param_01 = level.players[0];
	}

	if(isdefined(param_00.target))
	{
		func_7759(param_00,param_01);
	}

	var_02 = param_00.var_EE79;
	var_03 = strtok(var_02,",");
	func_129A2(var_03[0]);
	level notify("power_on_scriptable_and_light",var_02,param_01);
	wait(2.5);
	foreach(var_05 in var_03)
	{
		if(!isdefined(var_05))
		{
		}

		if(var_05 == "power_all")
		{
			level notify("power_on");
			scripts\common\utility::flag_set("power_on");
			level.var_D746 = 1;
			continue;
		}

		level notify(var_05 + " power_on");
		if(scripts\common\utility::func_6E34(var_05 + " power_on"))
		{
			scripts\common\utility::flag_set(var_05 + " power_on");
		}
	}

	scripts\common\utility::func_136F7();
	level notify("activate_power");
	if(!scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight())
	{
		param_01 thread scripts\cp\_vo::try_to_play_vo("activate_power","zmb_comment_vo","medium",4,0,0,0,50);
		if(isdefined(level.power_vo_func))
		{
			thread [[ level.power_vo_func ]](param_01);
		}
	}

	wait(0.5);
	level thread func_DE6F();
}

//Function Number: 8
func_DE6F()
{
	foreach(var_01 in level.players)
	{
		if(isdefined(var_01.var_A8D3) && isdefined(var_01.var_A8D3.var_E1B9))
		{
			var_01 notify("stop_interaction_logic");
			var_01.var_9A3F makeunusable();
			var_01.var_A8D3 = undefined;
		}

		wait(0.05);
	}
}

//Function Number: 9
func_7759(param_00,param_01)
{
	level endon("power_off");
	wait(0.2);
	if(param_00.var_889B.script_noteworthy == "roll")
	{
		param_00.var_889B rotateroll(75,0.15);
	}
	else if(param_00.var_889B.script_noteworthy == "-roll")
	{
		param_00.var_889B rotateroll(-75,0.15);
	}
	else if(param_00.var_889B.script_noteworthy == "pitch")
	{
		param_00.var_889B rotatepitch(75,0.15);
	}
	else if(param_00.var_889B.script_noteworthy == "-pitch")
	{
		param_00.var_889B rotatepitch(-75,0.15);
	}

	if(isdefined(param_00.var_2F12))
	{
		param_00.var_2F12 setscriptablepartstate("box","on");
	}

	param_00.var_D776 = 1;
}

//Function Number: 10
register_interactions()
{
	level.interaction_hintstrings["generator"] = &"COOP_INTERACTIONS_GENERATOR_ON";
	scripts\cp\_interaction::func_DEBB("generator","generator",1,undefined,::func_7757,0);
}