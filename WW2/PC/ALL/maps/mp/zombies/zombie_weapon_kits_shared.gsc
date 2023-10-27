/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\zombie_weapon_kits_shared.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 117 ms
 * Timestamp: 10/27/2023 3:14:38 AM
*******************************************************************/

//Function Number: 1
weaponkitsinitshared()
{
	level.var_A9CB = [];
	var_00 = function_027A("mp/zombieWeaponKitTable.csv");
	for(var_01 = 0;var_01 < var_00;var_01++)
	{
		var_02 = tablelookupbyrow("mp/zombieWeaponKitTable.csv",var_01,0);
		var_03 = getitemguidfromref(var_02);
		if(var_03 != 0)
		{
			level.var_A9CB[var_02] = 1;
			continue;
		}
	}
}

//Function Number: 2
weaponkitsgetpaintjobfrombaseweaponrefmp(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		return 0;
	}

	var_02 = param_00 getrankedplayerdata(common_scripts\utility::func_46A8(),"weaponBuildKits",param_01,"paintjob");
	return var_02;
}

//Function Number: 3
getweaponkitmp(param_00,param_01)
{
	var_02 = param_00 getrankedplayerdata(common_scripts\utility::func_46A8(),"weaponBuildKits",param_01,"weapon");
	var_03 = param_00 getrankedplayerdata(common_scripts\utility::func_46A8(),"weaponBuildKits",param_01,"reticle");
	var_04 = param_00 getrankedplayerdata(common_scripts\utility::func_46A8(),"weaponBuildKits",param_01,"camo");
	var_05 = param_00 getrankedplayerdata(common_scripts\utility::func_46A8(),"weaponBuildKits",param_01,"charm");
	var_06 = param_00 getrankedplayerdata(common_scripts\utility::func_46A8(),"weaponBuildKits",param_01,"customization");
	var_07 = param_00 getrankedplayerdata(common_scripts\utility::func_46A8(),"weaponBuildKits",param_01,"paintjob");
	var_08 = [];
	for(var_09 = 0;var_09 < 4;var_09++)
	{
		var_0A = param_00 getrankedplayerdata(common_scripts\utility::func_46A8(),"weaponBuildKits",param_01,"attachment",var_09);
		if(!var_0A)
		{
			continue;
		}

		var_08 = common_scripts\utility::func_F6F(var_08,var_0A);
	}

	var_0B = var_02;
	if(isguidaweapon(var_0B))
	{
		var_0B = getbaseweaponguid(var_02);
	}

	var_0C = level.weaponguidoverrides[var_0B + ""];
	if(isdefined(var_0C) && !common_scripts\utility::func_562E(level.promisenottogiveweapon))
	{
		var_02 = var_0C;
	}

	var_0E = spawnstruct();
	var_0E.var_A9F8 = var_02;
	var_0E.var_7E18 = var_03;
	var_0E.var_1EC0 = var_04;
	var_0E.charmguid = var_05;
	var_0E.var_297C = var_06;
	var_0E.var_114C = var_08;
	var_0E.paintjobdwfileslot = var_07;
	return var_0E;
}

//Function Number: 4
func_4736()
{
	return getarraykeys(level.var_A9CB);
}

//Function Number: 5
func_5842(param_00)
{
	return common_scripts\utility::func_562E(level.var_A9CB[param_00]);
}

//Function Number: 6
isvalidguid(param_00)
{
	var_01 = !common_scripts\utility::func_F79([0,-1],param_00);
	return var_01;
}