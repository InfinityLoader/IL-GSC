/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\gametypes\_damagefeedback.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 63 ms
 * Timestamp: 4/22/2024 2:09:16 AM
*******************************************************************/

//Function Number: 1
init()
{
}

//Function Number: 2
updatedamagefeedback(param_00,param_01)
{
	if(!isplayer(self) || !isdefined(param_00))
	{
		return;
	}

	switch(param_00)
	{
		case "scavenger":
			self playlocalsound("scavenger_pack_pickup");
			if(!level.hardcoremode)
			{
				setdamagefeedbackclientomnvar(param_00);
			}
			break;

		case "hitspecialarmor":
			setdamagefeedbackclientomnvar("hitspecialarmor");
			break;

		case "hitjuggernaut":
		case "hitlightarmor":
		case "hitblastshield":
			self playlocalsound("mp_hit_armor");
			setdamagefeedbackclientomnvar(param_00);
			break;

		case "mp_solar":
			if(!isdefined(self.shouldloopdamagefeedback))
			{
				if(isdefined(level.mapkillstreakdamagefeedbacksound))
				{
					self thread [[ level.mapkillstreakdamagefeedbacksound ]]();
				}
			}
			else
			{
				self.damagefeedbacktimer = 10;
			}
			break;

		case "laser":
			if(isdefined(level.sentrygun))
			{
				if(!isdefined(self.shouldloopdamagefeedback))
				{
					if(isdefined(level.mapkillstreakdamagefeedbacksound))
					{
						self thread [[ level.mapkillstreakdamagefeedbacksound ]](level.sentrygun);
					}
				}
			}
			break;

		case "headshot":
			self playlocalsound("mp_hit_headshot");
			setdamagefeedbackclientomnvar("headshot");
			break;

		case "hitmorehealth":
			self playlocalsound("mp_hit_armor");
			setdamagefeedbackclientomnvar("hitmorehealth");
			break;

		case "killshot":
			self playlocalsound("mp_hit_kill");
			setdamagefeedbackclientomnvar("killshot");
			break;

		case "killshot_headshot":
			self playlocalsound("mp_hit_kill_headshot");
			setdamagefeedbackclientomnvar("killshot_headshot");
			break;

		case "nosound":
			setdamagefeedbackclientomnvar("standard");
			break;

		case "none":
			break;

		default:
			self playlocalsound("mp_hit_default");
			setdamagefeedbackclientomnvar("standard");
			break;
	}
}

//Function Number: 3
setdamagefeedbackclientomnvar(param_00)
{
	var_01 = gettime();
	if(isdefined(self.damagefeedbacktime))
	{
		var_02 = self.damagefeedbacktime;
	}
	else
	{
		var_02 = 0;
	}

	if(var_01 - var_02 < 300 && self getclientomnvar("damage_feedback") == param_00)
	{
		return;
	}

	self.damagefeedbacktime = var_01;
	self setclientomnvar("damage_feedback",param_00);
}