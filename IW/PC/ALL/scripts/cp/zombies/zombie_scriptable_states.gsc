/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\zombies\zombie_scriptable_states.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 397 ms
 * Timestamp: 10/27/2023 12:27:08 AM
*******************************************************************/

//Function Number: 1
applyzombiescriptablestate(param_00,param_01)
{
	param_00 notify("applyZombieScriptableState");
	param_00 endon("applyZombieScriptableState");
	param_00 endon("death");
	var_02 = 1;
	var_03 = 0;
	var_04 = 0;
	var_05 = 0;
	var_06 = 0;
	var_07 = 0;
	var_08 = 0;
	var_09 = 0;
	while(var_02)
	{
		var_0A = scripts\common\utility::istrue(param_00.var_9B51);
		var_0B = scripts\common\utility::istrue(param_00.var_9B81);
		var_0C = scripts\common\utility::istrue(param_00.var_11196);
		var_0D = scripts\common\utility::istrue(param_00.var_9E0C);
		var_0E = scripts\common\utility::istrue(param_00.var_9B8A);
		var_0F = scripts\common\utility::istrue(param_00.var_9BC9);
		var_10 = isdefined(param_00.var_7455);
		if(var_0D)
		{
			if(!var_05)
			{
				var_05 = 1;
				var_03 = 0;
				var_04 = 0;
				var_06 = 0;
				var_07 = 0;
				var_08 = 0;
				var_09 = 0;
				param_00.var_EF42 = 1;
				func_5554(param_00,"frozen");
			}

			continue;
		}

		if(var_10)
		{
			if(!var_09)
			{
				var_09 = 1;
				var_05 = 0;
				var_03 = 0;
				var_04 = 0;
				var_06 = 0;
				var_07 = 0;
				var_08 = 0;
				param_00.var_EF42 = 1;
				if(isalive(param_00))
				{
					param_00 setscriptablepartstate("cold","active",1);
					func_5554(param_00,"cold");
					param_00 thread func_1887(param_00,param_01);
				}
			}

			continue;
		}

		if(var_0A)
		{
			if(!var_08)
			{
				var_08 = 1;
				var_03 = 0;
				var_04 = 0;
				var_05 = 0;
				var_06 = 0;
				var_07 = 0;
				var_09 = 0;
				param_00.var_EF42 = 1;
				if(isalive(param_00))
				{
					param_00 setscriptablepartstate("arcane_white","active",1);
					func_5554(param_00,"arcane_white");
				}
			}

			continue;
		}

		if(var_0E)
		{
			if(!var_06)
			{
				var_06 = 1;
				var_03 = 0;
				var_04 = 0;
				var_05 = 0;
				var_07 = 0;
				var_08 = 0;
				var_09 = 0;
				param_00.var_EF42 = 1;
				if(isalive(param_00))
				{
					param_00 setscriptablepartstate("chemburn","active",1);
					func_5554(param_00,"chemburn");
				}
			}

			continue;
		}

		if(var_0B)
		{
			if(!var_03)
			{
				var_03 = 1;
				var_04 = 0;
				var_05 = 0;
				var_06 = 0;
				var_07 = 0;
				var_08 = 0;
				var_09 = 0;
				param_00.var_EF42 = 1;
				if(isalive(param_00))
				{
					param_00 setscriptablepartstate("burning","active",1);
					func_5554(param_00,"burning");
				}
			}

			continue;
		}

		if(var_0F)
		{
			if(!var_07)
			{
				var_07 = 1;
				var_03 = 0;
				var_04 = 0;
				var_05 = 0;
				var_06 = 0;
				var_08 = 0;
				var_09 = 0;
				param_00.var_EF42 = 1;
				if(isalive(param_00))
				{
					param_00 setscriptablepartstate("shocked","active",1);
					func_5554(param_00,"electrified");
				}
			}

			continue;
		}

		if(var_0C)
		{
			if(!var_04)
			{
				var_04 = 1;
				var_03 = 0;
				var_05 = 0;
				var_06 = 0;
				var_07 = 0;
				var_08 = 0;
				var_09 = 0;
				param_00.var_EF42 = 1;
				if(isalive(param_00))
				{
					param_00 setscriptablepartstate("shocked","active",1);
					func_5554(param_00,"shocked");
				}
			}

			continue;
		}

		param_00.var_EF42 = undefined;
		param_00 func_12973(param_00,var_05);
		var_02 = 0;
		wait(0.1);
	}
}

//Function Number: 2
func_1887(param_00,param_01)
{
	param_00 endon("death");
	if(scripts\common\utility::istrue(param_00.allowpain))
	{
		param_00 dodamage(1,param_00.origin);
		param_00.allowpain = 0;
	}

	if(scripts\common\utility::istrue(param_00.var_1031A))
	{
		param_00.var_1031A = undefined;
	}
	else
	{
		return;
	}

	if(!isdefined(param_00.var_2303.var_4B12))
	{
		var_02 = self.var_1F5;
	}
	else
	{
		var_02 = param_01.var_2303.var_4B12;
	}

	var_02 = param_00.var_2303.var_4B12;
	switch(var_02)
	{
		case "slow_walk":
			break;

		case "walk":
			param_00 lib_0A1B::func_2968("slow_walk");
			break;

		case "run":
			param_00 lib_0A1B::func_2968("walk");
			break;

		case "sprint":
			param_00 lib_0A1B::func_2968("run");
			break;
	}

	param_00 waittill("defrosted");
	param_00 lib_0A1B::func_2968(var_02);
}

//Function Number: 3
func_E123(param_00)
{
	param_00 notify("frozen_tick_updated");
	param_00 endon("frozen_tick_updated");
	param_00 endon("death");
	wait(1);
	if(isdefined(param_00.var_7455))
	{
		param_00.var_7455 = undefined;
	}

	param_00 notify("defrosted");
	param_00 thread applyzombiescriptablestate(param_00);
}

//Function Number: 4
func_7383(param_00)
{
	param_00 endon("death");
	param_00.var_9E0C = 1;
	param_00.var_180 = 1;
	param_00.nocorpse = 1;
	param_00.full_gib = 1;
	param_00.var_C189 = 1;
	if(isdefined(param_00.var_7387) && issubstr(param_00.var_7387,"window"))
	{
		param_00 setscriptablepartstate("frozen","frozen_traverse");
	}
	else if(scripts\common\utility::istrue(param_00.var_565C))
	{
		param_00 setscriptablepartstate("frozen","frozen_crawl");
	}
	else
	{
		param_00 setscriptablepartstate("frozen","frozen",1);
	}

	wait(10.1);
	param_00.var_9E0C = undefined;
}

//Function Number: 5
func_12B9A(param_00)
{
	param_00 endon("death");
	param_00 setscriptablepartstate("frozen","unfrozen",1);
	if(!isalive(param_00))
	{
		return;
	}

	param_00 playsound("forge_freeze_shatter");
	param_00.var_180 = 0;
	param_00.nocorpse = undefined;
	param_00.full_gib = undefined;
	param_00.var_C189 = undefined;
}

//Function Number: 6
func_5554(param_00,param_01)
{
	switch(param_01)
	{
		case "frozen":
			param_00 setscriptablepartstate("cold","inactive",1);
			param_00 setscriptablepartstate("burning","inactive",1);
			param_00 setscriptablepartstate("shocked","inactive",1);
			param_00 setscriptablepartstate("chemburn","inactive",1);
			param_00 setscriptablepartstate("arcane_white","inactive",1);
			param_00 setscriptablepartstate("eyes","eye_glow_off",1);
			break;

		case "cold":
			param_00 setscriptablepartstate("burning","inactive",1);
			param_00 setscriptablepartstate("shocked","inactive",1);
			param_00 setscriptablepartstate("chemburn","inactive",1);
			param_00 setscriptablepartstate("arcane_white","inactive",1);
			param_00 setscriptablepartstate("eyes","eye_glow_off",1);
			break;

		case "arcane_white":
			param_00 setscriptablepartstate("cold","inactive",1);
			param_00 setscriptablepartstate("burning","inactive",1);
			param_00 setscriptablepartstate("shocked","inactive",1);
			param_00 setscriptablepartstate("chemburn","inactive",1);
			param_00 setscriptablepartstate("eyes","eye_glow_off",1);
			break;

		case "chemburn":
			param_00 setscriptablepartstate("cold","inactive",1);
			param_00 setscriptablepartstate("burning","inactive",1);
			param_00 setscriptablepartstate("shocked","inactive",1);
			param_00 setscriptablepartstate("arcane_white","inactive",1);
			param_00 setscriptablepartstate("eyes","eye_glow_off",1);
			break;

		case "burning":
			param_00 setscriptablepartstate("cold","inactive",1);
			param_00 setscriptablepartstate("shocked","inactive",1);
			param_00 setscriptablepartstate("chemburn","inactive",1);
			param_00 setscriptablepartstate("arcane_white","inactive",1);
			param_00 setscriptablepartstate("eyes","eye_glow_off",1);
			break;

		case "electrified":
		case "shocked":
			param_00 setscriptablepartstate("cold","inactive",1);
			param_00 setscriptablepartstate("burning","inactive",1);
			param_00 setscriptablepartstate("chemburn","inactive",1);
			param_00 setscriptablepartstate("arcane_white","inactive",1);
			param_00 setscriptablepartstate("eyes","eye_glow_off",1);
			break;

		default:
			break;
	}
}

//Function Number: 7
func_12973(param_00,param_01)
{
	if(isdefined(param_00.agent_type) && param_00.agent_type == "c6")
	{
		return;
	}

	if(!func_FFAA(param_00))
	{
		return;
	}

	if(isalive(param_00))
	{
		param_00 setscriptablepartstate("burning","inactive",1);
		param_00 setscriptablepartstate("shocked","inactive",1);
		param_00 setscriptablepartstate("chemburn","inactive",1);
		param_00 setscriptablepartstate("arcane_white","inactive",1);
		param_00 setscriptablepartstate("cold","inactive",1);
	}

	if(scripts\common\utility::istrue(param_01))
	{
		param_00.var_9E0C = undefined;
	}
}

//Function Number: 8
func_1296F(param_00)
{
	if(isdefined(param_00.agent_type) && param_00.agent_type == "c6" || param_00.agent_type == "zombie_brute" || param_00.agent_type == "zombie_grey" || param_00.agent_type == "zombie_ghost")
	{
		return;
	}

	if(!func_FFAA(param_00))
	{
		return;
	}

	param_00 setscriptablepartstate("burning","inactive",1);
	param_00 setscriptablepartstate("pet","inactive",1);
	param_00 setscriptablepartstate("shocked","inactive",1);
	param_00 setscriptablepartstate("corrosive","inactive",1);
	param_00 setscriptablepartstate("chemburn","inactive",1);
	param_00 setscriptablepartstate("arcane_white","inactive",1);
	param_00 setscriptablepartstate("cold","inactive",1);
	if(isdefined(param_00.var_8B66))
	{
		param_00 setscriptablepartstate("backpack","hide",1);
	}

	param_00 method_80BB(2,0);
}

//Function Number: 9
func_FFAA(param_00)
{
	if(!isdefined(param_00.var_1096F))
	{
		return 0;
	}

	if(isdefined(level.the_hoff) && param_00 == level.the_hoff)
	{
		return 0;
	}

	if(isdefined(param_00.electrocuted))
	{
		return 0;
	}

	switch(param_00.var_1096F)
	{
		case "zombie_grey":
		case "zombie_brute":
			return 0;

		default:
			return 1;
	}
}