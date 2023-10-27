/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_damagefeedback.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 29 ms
 * Timestamp: 10/27/2023 2:41:15 AM
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
			break;

		case "hitjuggernaut":
		case "hitlightarmor":
		case "hitblastshield":
			break;

		case "mp_solar":
			break;

		case "laser":
			break;

		case "headshot":
			break;

		case "hitmorehealth":
			break;

		case "killshot":
			break;

		case "killshot_headshot":
			break;

		case "none":
			break;

		default:
			break;
	}
}