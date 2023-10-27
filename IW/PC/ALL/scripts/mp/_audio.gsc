/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_audio.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 339 ms
 * Timestamp: 10/27/2023 12:14:28 AM
*******************************************************************/

//Function Number: 1
func_9539()
{
	if(!isdefined(level.var_2578))
	{
		level.var_2578 = spawnstruct();
	}

	func_970C();
	level.var_C56F = ::func_C56F;
}

//Function Number: 2
func_C56F()
{
	func_20B1("default");
}

//Function Number: 3
func_970C()
{
	func_1736("default","generic",0.15,0.9,2);
}

//Function Number: 4
func_1736(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = [];
	func_9CAB(param_01);
	var_05["roomtype"] = param_01;
	var_05["wetlevel"] = param_02;
	var_05["drylevel"] = param_03;
	var_05["fadetime"] = param_04;
	level.var_2578.var_E490[param_00] = var_05;
}

//Function Number: 5
func_9CAB(param_00)
{
}

//Function Number: 6
func_20B1(param_00)
{
	if(!isdefined(level.var_2578.var_E490[param_00]))
	{
		var_01 = level.var_2578.var_E490["default"];
		return;
	}

	var_01 = level.var_2578.var_E490[var_01];
}