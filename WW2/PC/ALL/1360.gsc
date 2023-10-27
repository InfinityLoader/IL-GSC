/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1360.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 3:25:46 AM
*******************************************************************/

//Function Number: 1
assert_collectible_table_valid()
{
	var_00 = function_027A("mp/zombieS2CollectibleTable.csv");
}

//Function Number: 2
func_5543(param_00)
{
	return common_scripts\utility::func_562E(param_00.var_5543);
}

//Function Number: 3
func_24D4(param_00)
{
	assert_collectible_table_valid();
	var_01 = tablelookupbyrow("mp/zombieS2CollectibleTable.csv",param_00,3);
	var_02 = tablelookupbyrow("mp/zombieS2CollectibleTable.csv",param_00,0);
	var_03 = spawnstruct();
	var_03.var_2A3C = tablelookupbyrow("mp/zombieS2CollectibleTable.csv",param_00,0);
	var_03.var_1B9 = tablelookupbyrow("mp/zombieS2CollectibleTable.csv",param_00,2);
	var_03.unlocks = strtok(var_01," ");
	var_03.var_24D1 = tablelookupbyrow("mp/zombieS2CollectibleTable.csv",param_00,1);
	var_03.var_5543 = 1;
	var_03.var_2A3C = int(var_02);
	return var_03;
}

//Function Number: 4
func_24D3(param_00)
{
	assert_collectible_table_valid();
	var_01 = tablelookuprownum("mp/zombieS2CollectibleTable.csv",1,param_00);
	return func_24D4(var_01);
}

//Function Number: 5
func_4083()
{
	assert_collectible_table_valid();
	var_00 = [];
	for(var_01 = 0;var_01 < function_027A("mp/zombieS2CollectibleTable.csv");var_01++)
	{
		var_02 = func_24D4(var_01);
		var_00 = common_scripts\utility::func_F6F(var_00,var_02);
	}

	return var_00;
}

//Function Number: 6
func_410C(param_00)
{
	var_01 = func_4083();
	var_02 = [];
	foreach(var_04 in var_01)
	{
		if(!func_415C(param_00,var_04))
		{
			continue;
		}

		var_02 = common_scripts\utility::func_F6F(var_02,var_04);
	}

	return var_02;
}

//Function Number: 7
func_410D()
{
	return common_scripts\utility::func_46A8();
}

//Function Number: 8
func_415C(param_00,param_01)
{
	return param_00 getrankedplayerdata(func_410D(),"hasS2ZombieCollectibles",param_01.var_2A3C);
}

//Function Number: 9
func_8470(param_00,param_01,param_02)
{
	param_00 setrankedplayerdata(func_410D(),"hasS2ZombieCollectibles",param_01.var_2A3C,param_02);
}