/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_mrsiartillery.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 5
 * Decompile Time: 79 ms
 * Timestamp: 10/27/2023 1:32:57 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.killstreakfuncs["mrsiartillery"] = ::func_8456;
	var_00 = addstruct();
	var_00.weaponname = "airdrop_marker_mp";
	var_00.projectilename = "mrsiartillery_projectile_mp";
	var_00.numstrikes = 6;
	var_00.initialdelay = 1;
	var_00.minfiredelay = 0.375;
	var_00.maxfiredelay = 0.5;
	var_00.strikeradius = 150;
	if(!isdefined(level.killstreakconfigdata))
	{
		level.killstreakconfigdata = [];
	}

	level.killstreakconfigdata["mrsiartillery"] = var_00;
}

//Function Number: 2
func_8456(param_00,param_01)
{
	var_02 = level.killstreakconfigdata["mrsiartillery"];
	var_03 = maps\mp\killstreaks\_designator_grenade::designator_start("mrsiartillery",var_02.weaponname,::func_597E);
	if(!isdefined(var_03) || !var_03)
	{
		return 0;
	}

	return 1;
}

//Function Number: 3
func_597E(param_00,param_01)
{
	var_02 = level.killstreakconfigdata[param_00];
	var_03 = param_01.owner;
	var_04 = param_01.origin;
	param_01 detonate();
	dostrike(var_03,param_00,var_03.origin,var_04);
}

//Function Number: 4
dostrike(param_00,param_01,param_02,param_03)
{
	var_04 = level.killstreakconfigdata[param_01];
	var_05 = param_03 - param_02;
	var_06 = (var_05[0],var_05[1],0);
	var_05 = vectornormalize(var_05);
	var_07 = param_03;
	var_08 = maps\mp\killstreaks\_killstreaks::findunobstructedfiringpoint(param_00,param_03 + (0,0,10),10000);
	if(isdefined(var_08))
	{
		iprintln("Firing Motar!");
		wait(var_04.initialdelay);
		wait(randomfloatrange(var_04.minfiredelay,var_04.maxfiredelay));
		var_09 = magicbullet(var_04.projectilename,var_08,var_07,param_00);
		for(var_0A = 1;var_0A < var_04.numstrikes;var_0A++)
		{
			wait(randomfloatrange(var_04.minfiredelay,var_04.maxfiredelay));
			var_0B = func_5BF6(var_07,var_04.strikeradius);
			var_09 = magicbullet(var_04.projectilename,var_08,var_0B,param_00);
		}
	}

	iprintln("Mortar LOS blocked!");
}

//Function Number: 5
func_5BF6(param_00,param_01)
{
	var_02 = randomfloatrange(-1 * param_01,param_01);
	var_03 = randomfloatrange(-1 * param_01,param_01);
	return param_00 + (var_02,var_03,0);
}