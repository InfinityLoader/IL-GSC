/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_damagefeedback.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 496 ms
 * Timestamp: 10/27/2023 12:15:05 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_9040 = [];
	level.var_9040["low_damage"] = 25;
	level.var_9040["standard"] = 50;
	level.var_9040["standard_cp"] = 50;
	level.var_9040["high_damage"] = 75;
}

//Function Number: 2
func_12E84(param_00,param_01,param_02,param_03,param_04)
{
	if(!isplayer(self) && !scripts\mp\_utility::func_9EF0(self))
	{
		return;
	}

	if(!isdefined(param_03))
	{
		param_03 = "standard";
	}

	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	if((!isdefined(level.var_4D4E) || !level.var_4D4E) && !param_04)
	{
		if(!isdefined(self.var_903F))
		{
			self.var_903F = 0;
		}

		self.var_903F++;
		self setclientomnvar("ui_hitmarker_audio_events",self.var_903F % 16);
	}

	switch(param_00)
	{
		case "none":
			break;

		case "hitmotionsensor":
		case "hitbulletstorm":
		case "hiticontrophysystem":
		case "hiticonarmorup":
		case "hithealthshield":
		case "hiticonempimmune":
		case "hitspawnprotection":
		case "hitlowdamage":
		case "hitcritical":
		case "hitmorehealth":
		case "hitblastshield":
		case "hittacresist":
		case "thermobaric_debuff":
		case "hitjuggernaut":
		case "hitlightarmor":
		case "hitequip":
			self setclientomnvar("damage_feedback_icon",param_00);
			self setclientomnvar("damage_feedback_icon_notify",gettime());
			func_12EA8(param_03,param_01,param_02);
			break;

		default:
			func_12EA8(param_03,param_01,param_02);
			break;
	}
}

//Function Number: 3
func_12EA8(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	param_02 = 0;
	var_03 = func_7F03(param_00);
	if(isdefined(self.var_A99E) && self.var_A99E == gettime() && var_03 <= self.var_A99D && !param_01)
	{
		return;
	}

	self.var_A99E = gettime();
	self.var_A99D = var_03;
	self setclientomnvar("damage_feedback",param_00);
	self setclientomnvar("damage_feedback_notify",gettime());
	if(param_01)
	{
		self setclientomnvar("damage_feedback_kill",1);
	}
	else
	{
		self setclientomnvar("damage_feedback_kill",0);
	}

	if(param_02)
	{
		self setclientomnvar("damage_feedback_headshot",1);
		return;
	}

	self setclientomnvar("damage_feedback_headshot",0);
}

//Function Number: 4
func_7F03(param_00)
{
	if(!isdefined(level.var_9040[param_00]))
	{
		return 0;
	}

	return level.var_9040[param_00];
}

//Function Number: 5
func_917F(param_00)
{
	var_01 = 0;
	if(isdefined(level.var_4D4E) && level.var_4D4E)
	{
		var_01 = 1;
	}

	if(!isplayer(self))
	{
		return;
	}

	switch(param_00)
	{
		case "throwingknife":
		case "scavenger":
			if(!var_01)
			{
				self playlocalsound("scavenger_pack_pickup");
			}
	
			if(!level.var_8B38)
			{
				self setclientomnvar("damage_feedback_other",param_00);
			}
			break;

		case "scavenger_eqp":
			if(!var_01)
			{
				self playlocalsound("scavenger_pack_pickup");
			}
	
			if(!level.var_8B38)
			{
				self setclientomnvar("damage_feedback_other",param_00);
			}
			break;

		case "boxofguns":
			if(!var_01)
			{
				self playlocalsound("mp_box_guns_ammo");
			}
	
			if(!level.var_8B38)
			{
				self setclientomnvar("damage_feedback_other",param_00);
			}
			break;

		case "eqp_ping":
			if(!var_01)
			{
				self playsoundtoplayer("mp_cranked_countdown",self);
			}
	
			if(!level.var_8B38)
			{
				self setclientomnvar("damage_feedback_other",param_00);
			}
			break;
	}
}