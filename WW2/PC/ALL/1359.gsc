/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1359.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 1 ms
 * Timestamp: 10/27/2023 3:25:46 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	level.var_24DC = [];
	var_0C = getentarray("lore_primary","script_noteworthy");
	foreach(var_0E in var_0C)
	{
		var_0F = spawnstruct();
		var_0F.var_378F = var_0E;
		var_0F.var_24D1 = var_0E.var_8260;
		var_0F.var_9D64 = "use";
		func_7BA2(var_0F);
	}
}

//Function Number: 2
func_7BA2(param_00)
{
	if(getdvarint("scr_zombieAllowNestCollectibles",0) == 1)
	{
		param_00.var_24D2 = lib_0550::func_24D3(param_00.var_24D1);
		var_01 = [];
		if(!isdefined(param_00.var_9D64))
		{
			param_00.var_9D64 = "use";
		}

		if(param_00.var_9D64 == "use")
		{
			var_01 = getentarray(param_00.var_378F.var_1A2,"targetname");
			var_01[0].var_378F = param_00.var_378F;
			var_01[0].var_5F13 = param_00;
			thread maps\mp\_utility::func_6F74(::func_5F11,var_01[0]);
		}

		foreach(var_03 in var_01)
		{
			var_03 usetriggerrequirelookat(1);
			param_00 thread func_5F10(var_03);
		}

		level.var_24DC[param_00.var_24D1] = param_00;
		return;
	}

	var_01 = getentarray(var_01.var_378F.var_1A2,"targetname");
	var_01[0] makeunusable();
	param_00.var_378F method_805C();
}

//Function Number: 3
func_86B3(param_00,param_01,param_02)
{
	param_00 [[ common_scripts\utility::func_98E7(param_02,::showtoclient,::hidefromclient) ]](param_01);
}

//Function Number: 4
func_86B2(param_00,param_01,param_02)
{
	param_00 [[ common_scripts\utility::func_98E7(param_02,::enableplayeruse,::disableplayeruse) ]](param_01);
}

//Function Number: 5
func_5F0F(param_00)
{
	var_01 = self;
}

//Function Number: 6
func_5F0E(param_00)
{
	var_01 = self;
	param_00 func_5F11(var_01);
}

//Function Number: 7
func_5F11(param_00)
{
	var_01 = param_00.var_5F13;
	var_02 = var_01.var_24D2;
	var_03 = param_00.var_378F;
	var_04 = lib_0550::func_415C(self,var_02);
	func_86B3(var_03,self,!var_04);
	func_86B2(param_00,self,!var_04);
}

//Function Number: 8
func_5F12(param_00)
{
	var_01 = self;
	var_02 = var_01.var_24D2;
	if(isdefined(level.var_744A))
	{
		foreach(var_04 in level.var_744A)
		{
			var_04 func_5F11(param_00);
		}
	}

	for(;;)
	{
		level waittill("connected",var_04);
		var_04 func_5F11(param_00);
	}
}

//Function Number: 9
func_5F10(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(!isplayer(var_01))
		{
			continue;
		}

		self.var_378F hidefromclient(var_01);
		param_00 disableplayeruse(var_01);
		if(isdefined(self.var_6FC0))
		{
			self thread [[ self.var_6FC0 ]](var_01);
		}

		if(lib_0550::func_415C(var_01,self.var_24D2))
		{
			continue;
		}

		lib_0550::func_8470(var_01,self.var_24D2,1);
		var_01 lib_0378::func_8D74("found_collectible");
	}
}