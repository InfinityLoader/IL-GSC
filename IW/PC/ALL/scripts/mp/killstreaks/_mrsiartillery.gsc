/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_mrsiartillery.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 239 ms
 * Timestamp: 10/27/2023 12:29:07 AM
*******************************************************************/

//Function Number: 1
init()
{
	scripts\mp\killstreaks\_killstreaks::func_DEFB("mrsiartillery",::func_12906);
	var_00 = spawnstruct();
	var_00.var_39C = "airdrop_marker_mp";
	var_00.var_DA62 = "mrsiartillery_projectile_mp";
	var_00.var_C244 = 6;
	var_00.var_9831 = 1;
	var_00.var_B782 = 0.375;
	var_00.var_B49A = 0.5;
	var_00.var_11141 = 150;
	if(!isdefined(level.var_A692))
	{
		level.var_A692 = [];
	}

	level.var_A692["mrsiartillery"] = var_00;
}

//Function Number: 2
func_12906(param_00,param_01)
{
	var_02 = level.var_A692["mrsiartillery"];
	var_03 = scripts\mp\killstreaks\_designator_grenade::func_526C("mrsiartillery",var_02.var_39C,::func_C5AF);
	if(!isdefined(var_03) || !var_03)
	{
		return 0;
	}

	return 1;
}

//Function Number: 3
func_C5AF(param_00,param_01)
{
	var_02 = level.var_A692[param_00];
	var_03 = param_01.var_222;
	var_04 = param_01.origin;
	param_01 method_8099();
	func_5AB7(var_03,param_00,var_03.origin,var_04);
}

//Function Number: 4
func_5AB7(param_00,param_01,param_02,param_03)
{
	var_04 = level.var_A692[param_01];
	var_05 = param_03 - param_02;
	var_06 = (var_05[0],var_05[1],0);
	var_05 = vectornormalize(var_05);
	var_07 = param_03;
	var_08 = scripts\mp\killstreaks\_killstreaks::func_6CC9(param_00,param_03 + (0,0,10),10000);
	if(isdefined(var_08))
	{
		iprintln("Firing Motar!");
		wait(var_04.var_9831);
		wait(randomfloatrange(var_04.var_B782,var_04.var_B49A));
		var_09 = scripts\mp\_utility::func_1309(var_04.var_DA62,var_08,var_07,param_00);
		for(var_0A = 1;var_0A < var_04.var_C244;var_0A++)
		{
			wait(randomfloatrange(var_04.var_B782,var_04.var_B49A));
			var_0B = func_CB2F(var_07,var_04.var_11141);
			var_09 = scripts\mp\_utility::func_1309(var_04.var_DA62,var_08,var_0B,param_00);
		}

		return;
	}

	iprintln("Mortar LOS blocked!");
}

//Function Number: 5
func_CB2F(param_00,param_01)
{
	var_02 = randomfloatrange(-1 * param_01,param_01);
	var_03 = randomfloatrange(-1 * param_01,param_01);
	return param_00 + (var_02,var_03,0);
}