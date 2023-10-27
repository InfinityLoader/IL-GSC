/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2821.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 12:23:45 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.var_1E5B = spawnstruct();
	level.var_1E5B.var_B8D3 = level.player method_84C6("totalGameplayTime");
	level.var_1E5B.var_10DB5 = func_7E73();
	setdvar("scr_analytics_playerJustDied",0);
	thread func_1E6C();
}

//Function Number: 2
func_1E6C()
{
	for(;;)
	{
		if(function_0110() || getdvarint("scr_analytics_playerJustDied"))
		{
			setdvar("scr_analytics_playerJustDied",0);
			setdvar("scr_analytics_playerStartTime",gettime());
		}

		wait(0.5);
	}
}

//Function Number: 3
func_B8CE(param_00)
{
	var_01 = func_12F49();
	func_F230(param_00,var_01);
}

//Function Number: 4
func_D37D()
{
	func_12F49();
	setdvar("scr_analytics_playerJustDied",1);
}

//Function Number: 5
func_F230(param_00,param_01)
{
	if(!isdefined(level.var_1E5B))
	{
		return;
	}

	var_02 = param_01 - level.var_1E5B.var_B8D3;
	var_03 = func_7E73();
	self method_84C9(param_00,int(var_02),level.var_1E5B.var_10DB5,var_03);
}

//Function Number: 6
func_12F49()
{
	var_00 = level.player method_84C6("totalGameplayTime");
	var_01 = int(gettime() - getdvarint("scr_analytics_playerStartTime") / 1000);
	if(var_01 > 0)
	{
		var_00 = var_00 + var_01;
		level.player method_84C7("totalGameplayTime",var_00);
	}

	return var_00;
}

//Function Number: 7
func_7E73()
{
	var_00 = getdvarint("g_gameskill") + 1;
	if(scripts\sp\_utility::func_93A6())
	{
		var_00 = 5;
	}
	else if(scripts\sp\_utility::func_93AB())
	{
		var_00 = 6;
	}

	return var_00;
}