/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3415.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 5 ms
 * Timestamp: 10/27/2023 12:27:09 AM
*******************************************************************/

//Function Number: 1
func_9538()
{
	var_00 = scripts\common\utility::getstructarray("atm_deposit","script_noteworthy");
	var_01 = scripts\common\utility::getstructarray("atm_withdrawal","script_noteworthy");
	var_02 = scripts\common\utility::array_combine(var_00,var_01);
	level.var_2416 = 0;
	level.var_2417 = 1000;
	foreach(var_04 in var_02)
	{
		var_04 func_3C5A(var_04);
		var_04.var_5237 = 0;
	}
}

//Function Number: 2
func_3C5A(param_00)
{
	switch(param_00.script_noteworthy)
	{
		case "atm_deposit":
			var_01 = scripts\common\utility::getstruct("atm_deposit_machine","targetname");
			var_01 thread func_1131B(param_00,var_01,"zmb_atm_machine");
			var_02 = scripts\common\utility::getstructarray("atm_deposit_screen","targetname");
			var_02 = sortbydistance(var_02,param_00.origin);
			var_03 = var_02[0];
			var_04 = spawn("script_model",var_03.origin);
			var_04 setmodel("tag_origin");
			param_00 thread func_2419(var_03,var_04);
			param_00 thread func_136D2(var_03,var_04,"deposit_made");
			break;

		case "atm_withdrawal":
			var_05 = scripts\common\utility::getstruct("atm_withdrawal_machine","targetname");
			var_05 thread func_1131B(param_00,var_05,"zmb_atm_withdraw");
			var_02 = scripts\common\utility::getstructarray("atm_withdrawal_screen","targetname");
			var_02 = sortbydistance(var_02,param_00.origin);
			var_03 = var_02[0];
			var_04 = spawn("script_model",var_03.origin);
			var_04 setmodel("tag_origin");
			param_00 thread func_2428(var_03,var_04);
			param_00 thread func_136DB(var_03,var_04,"withdrawal_made");
			break;
	}
}

//Function Number: 3
func_136D2(param_00,param_01,param_02)
{
	level scripts\common\utility::func_13734("power_on",self.var_D71C + " power_on","power_off");
	for(;;)
	{
		self waittill(param_02);
		param_00.var_DDC4 = 1;
		for(var_03 = 0;var_03 < 4;var_03++)
		{
			wait(0.25);
			param_01 setmodel("zmb_atm_screen_03a");
			wait(0.25);
			param_01 setmodel("zmb_atm_screen_03b");
			wait(0.25);
		}

		param_00.var_DDC4 = undefined;
	}
}

//Function Number: 4
func_136DB(param_00,param_01,param_02)
{
	level scripts\common\utility::func_13734("power_on",self.var_D71C + " power_on","power_off");
	for(;;)
	{
		self waittill(param_02);
		param_00.var_DDC4 = 1;
		for(var_03 = 0;var_03 < 4;var_03++)
		{
			wait(0.25);
			param_01 setmodel("zmb_atm_screen_04a");
			wait(0.25);
			param_01 setmodel("zmb_atm_screen_04b");
			wait(0.25);
		}

		param_00.var_DDC4 = undefined;
	}
}

//Function Number: 5
func_2419(param_00,param_01)
{
	level scripts\common\utility::func_13734("power_on",self.var_D71C + " power_on","power_off");
	param_01 setmodel("zmb_atm_screen_01a");
	param_01.origin = param_00.origin;
	param_01.angles = param_00.angles;
	for(;;)
	{
		wait(1);
		if(scripts\common\utility::istrue(param_00.var_DDC4))
		{
			continue;
		}

		param_01 setmodel("zmb_atm_screen_01a");
		wait(0.5);
		if(scripts\common\utility::istrue(param_00.var_DDC4))
		{
			continue;
		}

		param_01 setmodel("zmb_atm_screen_01b");
	}
}

//Function Number: 6
func_2428(param_00,param_01)
{
	level scripts\common\utility::func_13734("power_on",self.var_D71C + " power_on","power_off");
	param_01 setmodel("zmb_atm_screen_02a");
	param_01.origin = param_00.origin;
	param_01.angles = param_00.angles;
	for(;;)
	{
		wait(1);
		if(scripts\common\utility::istrue(param_00.var_DDC4))
		{
			continue;
		}

		param_01 setmodel("zmb_atm_screen_02b");
		wait(0.5);
		if(scripts\common\utility::istrue(param_00.var_DDC4))
		{
			continue;
		}

		param_01 setmodel("zmb_atm_screen_02a");
	}
}

//Function Number: 7
func_1131B(param_00,param_01,param_02)
{
	var_03 = spawn("script_model",param_01.origin);
	var_03.origin = param_01.origin;
	var_03.angles = param_01.angles;
	var_03 setmodel(param_02);
	var_04 = param_02 + "_on";
	for(;;)
	{
		var_05 = level scripts\common\utility::func_13734("power_on",param_00.var_D71C + " power_on","power_off");
		if(var_05 != "power_off")
		{
			param_00.var_D776 = 1;
			var_03 setmodel(var_04);
			continue;
		}

		if(var_05 == "power_off")
		{
			param_00.var_D776 = 0;
			var_03 setmodel(param_02);
		}
	}
}

//Function Number: 8
func_9A0A(param_00,param_01)
{
	param_01 notify("stop_interaction_logic");
	param_01.var_A8D3 = undefined;
	level.var_2416 = level.var_2416 + 1000;
	scripts\cp\_interaction::increase_total_deposit_amount(param_01,1000);
	param_00 notify("deposit_made",param_01);
	param_01 thread scripts\cp\_vo::try_to_play_vo("atm_deposit","zmb_comment_vo","low",10,0,0,1,40);
	scripts\cp\zombies\zombie_analytics::func_AF5D(1,level.wave_num,param_01);
	if(scripts\cp\_interaction::exceed_deposit_limit(param_01))
	{
		scripts\cp\_interaction::func_E01A(param_00,param_01);
	}
}

//Function Number: 9
func_9A0B(param_00,param_01)
{
	if(level.var_2416 < 1000)
	{
		return;
	}

	playfx(level._effect["atm_withdrawal"],param_00.origin + (-4,0,51));
	var_02 = 1000;
	param_01 scripts\cp\_persistence::func_82F9(var_02,undefined,undefined,undefined,"atm");
	param_01 notify("stop_interaction_logic");
	param_01.var_A8D3 = undefined;
	level.var_2416 = level.var_2416 - var_02;
	param_01 thread scripts\cp\_utility::func_1308C(param_01,"iw7_pickup_zm");
	param_00 notify("withdrawal_made",param_01);
	scripts\cp\zombies\zombie_analytics::func_AF5D(1,level.wave_num,param_01);
	param_01 thread scripts\cp\_vo::try_to_play_vo("withdraw_cash","zmb_comment_vo","low",10,0,1,0,40);
}

//Function Number: 10
func_2418(param_00,param_01)
{
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

	if(isdefined(level.var_2416) && level.var_2416 < 1000)
	{
		return &"CP_ZMB_INTERACTIONS_ATM_INSUFFICIENT_FUNDS";
	}

	return level.interaction_hintstrings[param_00.script_noteworthy];
}