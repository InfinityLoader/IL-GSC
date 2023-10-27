/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_horde_util.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 15
 * Decompile Time: 218 ms
 * Timestamp: 10/27/2023 1:31:01 AM
*******************************************************************/

//Function Number: 1
func_4934(param_00)
{
	return isdefined(param_00.laststand) && param_00.laststand;
}

//Function Number: 2
isonhumanteam(param_00)
{
	return param_00.team == level.playerteam;
}

//Function Number: 3
func_3B5B()
{
	var_00 = 0;
	if(!isdefined(level.players))
	{
		return 0;
	}

	foreach(var_02 in level.players)
	{
		if(isonhumanteam(var_02))
		{
			var_00++;
		}
	}

	return var_00;
}

//Function Number: 4
func_496C(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = level.currentroundnumber;
	}

	if(!level.enablespecialround)
	{
		return 0;
	}

	if(param_00 % 5 == 1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 5
func_48AE()
{
	return level.chancetospawndog > 0;
}

//Function Number: 6
func_7527(param_00)
{
	foreach(var_02 in level.players)
	{
		if(isonhumanteam(var_02) && maps\mp\_utility::func_4945(var_02))
		{
			var_02 thread maps\mp\gametypes\_hud_message::func_794C(param_00);
		}
	}
}

//Function Number: 7
func_3FF9(param_00)
{
	var_01 = 0;
	if(isbot(param_00))
	{
		return var_01;
	}

	foreach(var_03 in param_00.pers["killstreaks"])
	{
		if(isdefined(var_03) && isdefined(var_03.streakname) && var_03.available && var_03.streakname == "agent")
		{
			var_01 = 1;
			break;
		}
	}

	return var_01;
}

//Function Number: 8
getplayerweaponhorde(param_00)
{
	var_01 = param_00 getcurrentprimaryweapon();
	if(isdefined(param_00.changingweapon))
	{
		var_01 = param_00.changingweapon;
	}

	if(!maps\mp\gametypes\_weapons::isprimaryweapon(var_01))
	{
		var_01 = param_00 common_scripts\utility::func_3B0A();
	}

	if(!param_00 hasweapon(var_01))
	{
		var_01 = param_00 maps\mp\killstreaks\_killstreaks::func_3AAA();
	}

	return var_01;
}

//Function Number: 9
func_6047(param_00)
{
	level endon("game_ended");
	foreach(var_02 in level.players)
	{
		if(!maps\mp\_utility::func_4945(var_02))
		{
			continue;
		}

		if(!isonhumanteam(var_02))
		{
			continue;
		}

		var_02 playsoundtoplayer(param_00,var_02);
	}
}

//Function Number: 10
func_93E8(param_00)
{
	var_01 = param_00 getweaponslistall();
	foreach(var_03 in var_01)
	{
		param_00 givemaxammo(var_03);
		if(var_03 == level.intelminigun)
		{
			var_04 = weaponclipsize(level.intelminigun);
			param_00 setweaponammoclip(level.intelminigun,var_04);
		}
	}
}

//Function Number: 11
func_8F93(param_00)
{
	param_00 maps\mp\gametypes\_persistence::func_7B28("round","squardKills",param_00.killz + 1);
	param_00.killz = castint(min(param_00.killz + 1,999));
	param_00.kills = param_00.killz;
	param_00 maps\mp\_utility::func_7093("hordeKills",param_00.killz);
}

//Function Number: 12
func_8F94(param_00)
{
	param_00 maps\mp\gametypes\_persistence::func_7B28("round","squardRevives",param_00.numrevives + 1);
	param_00.numrevives = castint(min(param_00.numrevives + 1,999));
	param_00.assists = param_00.numrevives;
	param_00 maps\mp\_utility::func_7093("hordeRevives",param_00.numrevives);
}

//Function Number: 13
func_8F92(param_00)
{
	param_00 maps\mp\gametypes\_persistence::func_7B28("round","squardCrates",param_00.numcrtaescaptured + 1);
	param_00.numcrtaescaptured = castint(min(param_00.numcrtaescaptured + 1,999));
	param_00 maps\mp\_utility::setextrascore0(param_00.numcrtaescaptured);
	param_00 maps\mp\_utility::func_7093("hordeCrates",param_00.numcrtaescaptured);
}

//Function Number: 14
func_8F95(param_00,param_01)
{
	param_00 maps\mp\gametypes\_persistence::func_7B28("round","sguardWave",param_01);
	param_00 maps\mp\_utility::func_7093("hordeRound",param_01);
}

//Function Number: 15
func_8F96(param_00,param_01)
{
	param_00 maps\mp\gametypes\_persistence::func_7B28("round","sguardWeaponLevel",param_01);
	param_00 maps\mp\_utility::func_7093("hordeWeapon",param_01);
}