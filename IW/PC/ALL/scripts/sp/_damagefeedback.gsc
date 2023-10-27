/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\sp\_damagefeedback.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 383 ms
 * Timestamp: 10/27/2023 12:24:00 AM
*******************************************************************/

//Function Number: 1
init()
{
	precacheshader("damage_feedback_thin");
	setdvar("scr_damagefeedback","1");
	if(getdvar("scr_damagefeedback") == "")
	{
		setdvar("scr_damagefeedback","0");
	}

	if(!getdvarint("scr_damagefeedback",0))
	{
		return;
	}

	level.var_9040 = [];
	level.var_9040["low_damage"] = 35;
	level.var_9040["standard"] = 50;
	level.var_9040["standard_cp"] = 50;
	level.var_9040["high_damage"] = 85;
}

//Function Number: 2
func_B9C6()
{
	if(!getdvarint("scr_damagefeedback",0))
	{
		return;
	}

	if(isdefined(level.var_4D4D))
	{
		return;
	}

	if(scripts\sp\_utility::func_93A6())
	{
		return;
	}

	scripts\sp\_utility::func_16B7(::func_4D4C);
}

//Function Number: 3
func_4D4C(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!getdvarint("scr_damagefeedback",0))
	{
		return;
	}

	if(!isdefined(param_01) || !isplayer(param_01) && !param_01 func_9EF8() || param_01 == self || param_00 <= 0)
	{
		return;
	}

	var_0A = "standard";
	var_0B = "standard";
	if(isdefined(param_09))
	{
		if(param_00 <= function_0294(param_09))
		{
			var_0B = "low_damage";
		}
		else if(param_00 >= function_0293(param_09))
		{
			var_0B = "high_damage";
		}
	}

	var_0C = 0;
	var_0D = 0;
	if(isai(self))
	{
		var_0C = !isalive(self);
		var_0D = func_9E27(param_07);
	}

	level.player thread func_12E84(var_0A,var_0C,var_0D,var_0B,self);
}

//Function Number: 4
func_9EF8()
{
	if(isdefined(self.var_12BA4) && self.var_12BA4 == "seeker")
	{
		if(isdefined(self.var_222) && self.var_222 == level.player)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 5
func_4D4B(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!isdefined(level.var_D127) || !isdefined(param_01) || param_01 != level.var_D127)
	{
		return;
	}

	func_4D4C(param_00,level.player,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
}

//Function Number: 6
func_12E84(param_00,param_01,param_02,param_03,param_04)
{
	if(!isplayer(self))
	{
		return;
	}

	if(!isdefined(param_03))
	{
		param_03 = "standard";
	}

	switch(param_00)
	{
		case "hithealthshield":
		case "hitlifelink":
		case "hitbulletstorm":
		case "hitcritical":
		case "hitmotionsensor":
		case "hitmorehealth":
		case "hitjuggernaut":
		case "hitlightarmor":
		case "hitblastshield":
		case "thermobaric_debuff":
			setomnvar("damage_feedback_icon",param_00);
			self setclientomnvar("damage_feedback_icon_notify",gettime());
			func_12EA8(param_03,param_01,param_02);
			break;

		case "none":
			break;

		default:
			func_12EA8(param_03,param_01,param_02,param_04);
			break;
	}
}

//Function Number: 7
func_12EA8(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(isdefined(param_03) && param_03.team == "allies")
	{
		return;
	}

	var_04 = func_7F03(param_00);
	if(isdefined(self.var_A99E) && self.var_A99E == gettime() && var_04 <= self.var_A99D && !param_01)
	{
		return;
	}

	self.var_A99E = gettime();
	self.var_A99D = var_04;
	setomnvar("damage_feedback",param_00);
	self setclientomnvar("damage_feedback_notify",gettime());
	if(param_01)
	{
		setomnvar("damage_feedback_kill",1);
	}
	else
	{
		setomnvar("damage_feedback_kill",0);
	}

	if(param_02)
	{
		setomnvar("damage_feedback_headshot",1);
		return;
	}

	setomnvar("damage_feedback_headshot",0);
}

//Function Number: 8
func_7F03(param_00)
{
	if(!isdefined(level.var_9040[param_00]))
	{
		return 0;
	}

	return level.var_9040[param_00];
}

//Function Number: 9
func_9E27(param_00)
{
	switch(param_00)
	{
		case "j_head_pv_horizontal":
		case "j_head_pv_z":
		case "j_head":
		case "j_neck":
			return 1;

		default:
			return 0;
	}

	return 0;
}