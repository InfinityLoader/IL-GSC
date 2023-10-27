/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_damagefeedback.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 65 ms
 * Timestamp: 10/27/2023 1:18:04 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
}

//Function Number: 2
func_86E0(param_00)
{
	var_01 = 0;
	if(isdefined(level.damagefeedbacknosound) && level.damagefeedbacknosound)
	{
		var_01 = 1;
	}

	if(!isplayer(self))
	{
	}

	switch(param_00)
	{
		case "hitaliensoft":
		case "hitalienarmor":
		case "hitkill":
		case "hitcritical":
		case "hitdeadeyekill":
		case "hitmorehealth":
		case "hitjuggernaut":
		case "hitkilljugg":
		case "hitlightarmor":
		case "hitblastshield":
		case "hitkillblast":
		case "thermobaric_debuff":
		case "thermodebuff_kill":
		case "hitmotionsensor":
			if(!var_01)
			{
				self playlocalsound("MP_hit_alert");
			}
	
			self setclientomnvar("damage_feedback",param_00);
			break;

		case "none":
			break;

		case "meleestun":
			if(!isdefined(self.meleestun))
			{
				if(!var_01)
				{
					self playlocalsound("crate_impact");
				}
	
				self.meleestun = 1;
			}
	
			self setclientomnvar("damage_feedback","hitcritical");
			wait(0.2);
			self.meleestun = undefined;
			break;

		default:
			if(!var_01)
			{
				self playlocalsound("MP_hit_alert");
			}
	
			self setclientomnvar("damage_feedback","standard");
			break;
	}
}

//Function Number: 3
hudicontype(param_00)
{
	var_01 = 0;
	if(isdefined(level.damagefeedbacknosound) && level.damagefeedbacknosound)
	{
		var_01 = 1;
	}

	if(!isplayer(self))
	{
	}

	switch(param_00)
	{
		case "scavenger":
		case "throwingknife":
			if(!var_01)
			{
				self playlocalsound("scavenger_pack_pickup");
			}
	
			if(!level.hardcoremode)
			{
				self setclientomnvar("damage_feedback_other",param_00);
			}
			break;

		case "boxofguns":
			if(!var_01)
			{
				self playlocalsound("mp_box_guns_ammo");
			}
	
			if(!level.hardcoremode)
			{
				self setclientomnvar("damage_feedback_other",param_00);
			}
			break;

		case "oracle":
			if(!var_01)
			{
				self playlocalsound("oracle_radar_pulse_plr");
			}
	
			if(!level.hardcoremode)
			{
				self setclientomnvar("damage_feedback_other",param_00);
			}
			break;
	}
}