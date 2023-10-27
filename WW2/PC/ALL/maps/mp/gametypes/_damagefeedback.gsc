/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_damagefeedback.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 97 ms
 * Timestamp: 10/27/2023 3:22:48 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
}

//Function Number: 2
func_A102(param_00,param_01)
{
	if(!isplayer(self) || !isdefined(param_00))
	{
		return;
	}

	switch(param_00)
	{
		case "resupply_equipment":
		case "resupply_bullets":
		case "resupply_throwingknife":
		case "resupply_launcher":
		case "resupply_scorestreak":
		case "resupply_intel":
		case "escalation_activated":
			if(!level.var_4B17)
			{
				setdamagepickupclientomnvar(param_00);
			}
			break;

		case "killshot_deadeye_headshot":
		case "killshot_deadeye":
		case "hitdeadeye_headshot":
		case "hitdeadeye":
		case "standard_nosound":
		case "killshot_nosound":
		case "hitjuggernaut":
		case "hitlightarmor":
		case "hitriotshield":
		case "hittacticalmask":
		case "hitfireshield":
		case "hitblastshield":
			func_865B(param_00);
			break;

		case "weakpoint":
			if(isdefined(level.var_585D) && level.var_585D)
			{
				func_865B("headshot");
			}
			break;

		case "headshot":
			if(isdefined(level.var_585D) && level.var_585D)
			{
				func_865B("headshot");
			}
			else if(!level.var_258F)
			{
				func_865B("standard");
			}
			else
			{
				func_865B("headshot");
			}
			break;

		case "hitmorehealth":
			func_865B("hitmorehealth");
			break;

		case "killshot":
			func_865B("killshot");
			break;

		case "killshot_headshot":
			func_865B("killshot_headshot");
			break;

		case "minor":
			if(isdefined(level.var_585D) && level.var_585D)
			{
				func_865B("minor");
			}
			else
			{
				func_865B("standard");
			}
			break;

		case "raid_buildable":
			func_865B("raid_buildable");
			break;

		case "raid_buildable_kill":
			func_865B("raid_buildable_kill");
			break;

		case "raid_fighter":
			func_865B("raid_fighter");
			break;

		case "raid_fighter_killshot":
			func_865B("raid_fighter_killshot");
			break;

		case "throwingknife":
			func_865B("throwingknife");
			break;

		case "none":
			break;

		default:
			func_865B("standard");
			break;
	}
}

//Function Number: 3
func_865B(param_00)
{
	self setclientomnvar("damage_feedback",param_00);
	thread func_7D5B();
}

//Function Number: 4
func_7D5B()
{
	self notify("reset_feedback_omnvar");
	self endon("reset_feedback_omnvar");
	wait(1);
	waittillframeend;
	if(isdefined(self))
	{
		self setclientomnvar("damage_feedback","none");
	}
}

//Function Number: 5
setdamagepickupclientomnvar(param_00)
{
	self setclientomnvar("damage_pickup",param_00);
	thread resetdamagepickup();
}

//Function Number: 6
resetdamagepickup()
{
	self notify("reset_pickup_omnvar");
	self endon("reset_pickup_omnvar");
	wait(1);
	waittillframeend;
	if(isdefined(self))
	{
		self setclientomnvar("damage_pickup","none");
	}
}