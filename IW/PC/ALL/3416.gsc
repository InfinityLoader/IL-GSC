/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3416.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 3 ms
 * Timestamp: 10/27/2023 12:27:09 AM
*******************************************************************/

//Function Number: 1
func_9642()
{
	var_00 = scripts\common\utility::getstructarray("jaroslav_machine","script_noteworthy");
	level.var_A43A = level.interactions["jaroslav_machine"].cost;
	level.var_732C = 3000;
	level.var_732D = 6000;
	foreach(var_02 in var_00)
	{
		var_03 = getentarray(var_02.target,"targetname");
		foreach(var_05 in var_03)
		{
			if(var_05.script_noteworthy == "fnf_machine")
			{
				var_02.var_B141 = var_05;
				continue;
			}

			if(var_05.script_noteworthy == "fnf_jaw")
			{
				var_02.var_A44A = var_05;
				continue;
			}

			if(var_05.script_noteworthy == "fnf_light")
			{
				if(!isdefined(var_02.var_ACC9))
				{
					var_02.var_ACC9 = [];
				}

				var_02.var_ACC9[var_02.var_ACC9.size] = var_05;
			}
		}

		var_02.var_B141 setscriptablepartstate("teller","safe_off");
		var_02.var_A44A setmodel("zmb_fortune_teller_machine_jaw_01");
		var_02 thread func_D748();
	}
}

//Function Number: 2
func_FFB1()
{
	if(getdvarint("loc_language") != 15 && getdvarint("loc_language") != 1)
	{
		return 0;
	}

	return 0;
}

//Function Number: 3
func_D748()
{
	foreach(var_01 in self.var_ACC9)
	{
		var_01 setlightintensity(0);
		if(scripts\common\utility::istrue(self.var_E1B9))
		{
			var_01 thread func_12986(self);
		}
	}
}

//Function Number: 4
func_12986(param_00)
{
	for(;;)
	{
		var_01 = level scripts\common\utility::func_13734("power_on",param_00.var_D71C + " power_on","power_off");
		if(var_01 == "power_off")
		{
			self setlightintensity(0);
			param_00.var_D776 = 0;
			continue;
		}

		self setlightintensity(0.65);
		param_00.var_B141 setscriptablepartstate("machine","default_on");
		param_00.var_B141 setscriptablepartstate("teller","safe_on");
		if(!param_00.var_D776)
		{
			level thread scripts\cp\_music_and_dialog::func_1752("jaroslav_anc_attract",param_00.var_A44A.origin,120,120,250000,100);
		}

		param_00.var_D776 = 1;
	}
}

//Function Number: 5
func_9A2D(param_00,param_01)
{
	level thread func_BC3A(param_00,3);
	param_01 notify("stop_interaction_logic");
	param_01.var_A8D3 = undefined;
	var_02 = getarraykeys(param_01.var_456B);
	param_01 notify("cards_replenished");
	if(param_01 scripts\cp\_utility::func_212D())
	{
		foreach(var_04 in var_02)
		{
			param_01 notify(var_04 + "_exited_early");
		}
	}

	wait(0.5);
	param_01 lib_0D59::reset_meter();
	param_01.var_3A52 = param_01.var_3A52 + 1;
	param_01 thread lib_0D59::func_1297A();
	param_01 thread lib_0D59::func_B69D();
	param_01 scripts\cp\_merits::func_D9AD("mt_faf_refill_deck");
	playsoundatpos(param_00.origin,"jaroslav_anc_activate_use");
	level thread func_A439(param_01);
	scripts\cp\zombies\zombie_analytics::func_AF6D(1,level.wave_num,param_01);
	level thread scripts\cp\_vo::func_E01F("nag_need_fateandfort");
	param_01 scripts\cp\_interaction::func_DE6E();
}

//Function Number: 6
func_A439(param_00)
{
	param_00 endon("disconnect");
	param_00 endon("last_stand");
	wait(2);
	param_00 thread scripts\cp\_vo::try_to_play_vo("wonder_restock","zmb_comment_vo","low",10,0,0,0,50);
}

//Function Number: 7
func_BC3A(param_00,param_01)
{
	if(isdefined(param_00.var_A44A.var_BD30))
	{
		return;
	}

	if(!scripts\common\utility::istrue(param_00.var_B141.hidden))
	{
		param_00.var_B141 setscriptablepartstate("mouth","smoke");
	}

	for(var_02 = 0;var_02 < param_01;var_02++)
	{
		param_00.var_A44A.var_BD30 = 1;
		param_00.var_A44A movez(-1,0.2);
		param_00.var_A44A waittill("movedone");
		wait(1);
		param_00.var_A44A movez(1,0.2);
		param_00.var_A44A waittill("movedone");
	}

	param_00.var_A44A.var_BD30 = undefined;
}

//Function Number: 8
func_A438(param_00,param_01)
{
	if(scripts\common\utility::istrue(param_00.var_B141.hidden))
	{
		return "";
	}

	if(param_00.var_E1B9 && !param_00.var_D776)
	{
		if(isdefined(level.needspowerstring))
		{
			return level.needspowerstring;
		}
		else
		{
			return &"COOP_INTERACTIONS_REQUIRES_POWER";
		}
	}

	level thread func_BC3A(param_00,1);
	if(param_01 scripts\cp\_utility::func_212D())
	{
		var_02 = &"COOP_INTERACTIONS_FNF_WHILE_ACTIVE";
	}
	else
	{
		var_02 = level.interaction_hintstrings[param_01.script_noteworthy];
	}

	if(scripts\common\utility::istrue(level.meph_fight_started))
	{
		return level.interaction_hintstrings[param_00.script_noteworthy];
	}

	if(scripts\common\utility::istrue(level.unlimited_fnf))
	{
		return var_02;
	}

	switch(param_01.var_3A52)
	{
		case 1:
		case 0:
			return var_02;

		default:
			return &"COOP_INTERACTIONS_NO_MORE_CARDS_OWNED";
	}
}

//Function Number: 9
func_D0F6(param_00)
{
	param_00.var_732F = 0;
	param_00.var_3A52 = 0;
}

//Function Number: 10
register_interactions()
{
	level.interaction_hintstrings["jaroslav_machine"] = &"COOP_INTERACTIONS_FNF";
	scripts\cp\_interaction::func_DEBB("jaroslav_machine","wondercard_machine",1,::func_A438,::func_9A2D,3000,1,::func_9642);
}