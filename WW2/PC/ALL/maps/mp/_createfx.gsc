/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_createfx.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 71 ms
 * Timestamp: 10/27/2023 3:21:06 AM
*******************************************************************/

//Function Number: 1
func_27EE()
{
	level.var_3F0C = ::common_scripts\utility::func_A60A;
	level.var_3F0D = ::func_3F0D;
	level.var_3F09 = ::common_scripts\_fx::func_5EF5;
	level.var_3F0A = ::common_scripts\_fx::func_6B11;
	level.var_3F04 = ::common_scripts\_fx::func_27A8;
	level.var_3F10 = ::common_scripts\_createfx::func_7DCD;
	level.var_3F0E = ::common_scripts\_createfx::func_774A;
	level.var_3F0B = ::func_3F0B;
	level.var_3F0F = ::func_3F0F;
	level.var_64F8 = 1;
	level.var_1E7F = ::common_scripts\utility::func_A60A;
	level.var_1E77 = ::common_scripts\utility::func_A60A;
	level.var_1E79 = ::common_scripts\utility::func_A60A;
	level.var_1E78 = ::common_scripts\utility::func_A60A;
	level.var_1E7B = ::common_scripts\utility::func_A60A;
	level.var_1E73 = ::common_scripts\utility::func_A60A;
	level.var_1E71 = ::common_scripts\utility::func_A60A;
	level.var_1E7C = ::common_scripts\utility::func_A60A;
	level.var_1E77 = ::func_1E67;
	level.var_1E7D = ::common_scripts\utility::func_A60A;
	maps\mp\gametypes\_gameobjects::func_F9([]);
	if(isdefined(level.var_27F3))
	{
		[[ level.var_27F3 ]]();
	}

	thread common_scripts\_createfx::func_3F06();
	common_scripts\_createfx::func_27F4();
	level waittill("eternity");
}

//Function Number: 2
func_3F0D(param_00)
{
	return level.var_721C.var_116;
}

//Function Number: 3
func_1E67()
{
	self waittill("begin");
	if(!isdefined(level.var_721C))
	{
		var_00 = getentarray("mp_global_intermission","classname");
		var_01 = (var_00[0].var_1D[0],var_00[0].var_1D[1],0);
		self spawn_0(var_00[0].var_116,var_01);
		maps\mp\_utility::func_A165("playing");
		self.var_FB = 10000000;
		self.var_BC = 10000000;
		level.var_721C = self;
		thread common_scripts\_createfx::func_2808();
		return;
	}

	kick(self getentitynumber());
}

//Function Number: 4
func_3F0B()
{
	var_00 = level.var_5ED.var_7332 / 190;
	level.var_721C method_81E1(var_00);
}

//Function Number: 5
func_3F0F()
{
}