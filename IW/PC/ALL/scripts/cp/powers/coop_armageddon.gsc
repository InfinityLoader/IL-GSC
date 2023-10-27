/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\powers\coop_armageddon.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 731 ms
 * Timestamp: 10/27/2023 12:26:34 AM
*******************************************************************/

//Function Number: 1
init_armageddon()
{
	scripts\common\utility::flag_init("armageddon_active");
	func_E1D2();
	func_952E();
	level.var_B756 = 0.2;
	level.var_B46F = 0.4;
	level.var_5FCC = 10;
	level.var_2174 = 20;
	level.var_2175 = 0.15;
}

//Function Number: 2
func_2179()
{
	func_1755(level.var_2174);
	level thread func_576A(level.var_2174);
	if(scripts\common\utility::flag("armageddon_active"))
	{
		return;
	}

	scripts\common\utility::flag_set("armageddon_active");
	level thread func_2178();
	level thread func_10BA5(self);
}

//Function Number: 3
func_1755(param_00)
{
	level.var_2177 = level.var_2177 + param_00;
}

//Function Number: 4
func_2178()
{
	level endon("game_ended");
	while(level.var_2177 > 0)
	{
		wait(1);
		level.var_2177--;
	}

	func_E1D2();
	scripts\common\utility::func_6E2A("armageddon_active");
	level notify("armageddon_timeout");
}

//Function Number: 5
func_10BA5(param_00)
{
	level endon("game_ended");
	level endon("armageddon_timeout");
	for(;;)
	{
		var_01 = func_DCB4();
		foreach(var_03 in var_01)
		{
			func_5CFA(var_03,param_00);
			wait(randomfloatrange(level.var_B756,level.var_B46F));
		}
	}
}

//Function Number: 6
func_DCB4()
{
	var_00 = scripts\common\utility::array_randomize(level.var_2173);
	var_01 = [];
	var_02 = [];
	foreach(var_04 in var_00)
	{
		if(func_2131(var_04))
		{
			var_01[var_01.size] = var_04;
			continue;
		}

		var_02[var_02.size] = var_04;
	}

	var_00 = scripts\common\utility::array_combine(var_01,var_02);
	return var_00;
}

//Function Number: 7
func_2131(param_00)
{
	var_01 = min(param_00[0][0],param_00[1][0]);
	var_02 = max(param_00[0][0],param_00[1][0]);
	var_03 = min(param_00[0][1],param_00[1][1]);
	var_04 = max(param_00[0][1],param_00[1][1]);
	foreach(var_06 in level.spawned_enemies)
	{
		if(var_01 <= var_06.origin[0] && var_06.origin[0] <= var_02 && var_03 <= var_06.origin[1] && var_06.origin[1] <= var_04)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 8
func_5CFA(param_00,param_01)
{
	var_02 = func_796B(param_00);
	if(isdefined(param_01) && isplayer(param_01))
	{
		magicbullet("iw7_armageddonmeteor_mp",var_02.var_10B89,var_02.var_62A3,param_01);
		return;
	}

	magicbullet("iw7_armageddonmeteor_mp",var_02.var_10B89,var_02.var_62A3,level.players[0]);
}

//Function Number: 9
func_796B(param_00)
{
	if(func_2131(param_00))
	{
		return func_7982(param_00);
	}

	return func_7BE6(param_00);
}

//Function Number: 10
func_7982(param_00)
{
	var_01 = spawnstruct();
	var_02 = min(param_00[0][0],param_00[1][0]);
	var_03 = max(param_00[0][0],param_00[1][0]);
	var_04 = min(param_00[0][1],param_00[1][1]);
	var_05 = max(param_00[0][1],param_00[1][1]);
	foreach(var_07 in level.spawned_enemies)
	{
		if(var_02 <= var_07.origin[0] && var_07.origin[0] <= var_03 && var_04 <= var_07.origin[1] && var_07.origin[1] <= var_05)
		{
			var_01.var_10B89 = (var_07.origin[0] + randomfloatrange(-2000,2000),var_07.origin[1] + randomfloatrange(-2000,2000),8000 + randomfloatrange(-1000,1000));
			var_01.var_62A3 = var_07.origin;
			return var_01;
		}
	}
}

//Function Number: 11
func_7BE6(param_00)
{
	var_01 = spawnstruct();
	var_02 = min(param_00[0][0],param_00[1][0]);
	var_03 = max(param_00[0][0],param_00[1][0]);
	var_04 = min(param_00[0][1],param_00[1][1]);
	var_05 = max(param_00[0][1],param_00[1][1]);
	var_06 = randomfloatrange(var_02,var_03);
	var_07 = randomfloatrange(var_04,var_05);
	var_01.var_10B89 = (var_06,var_07,8000 + randomfloatrange(-1000,1000));
	var_01.var_62A3 = scripts\common\utility::func_5D14((var_06 + randomfloatrange(-2000,2000),var_07 + randomfloatrange(-2000,2000),-8000),72,-100) + (0,0,16);
	return var_01;
}

//Function Number: 12
func_E1D2()
{
	level.var_2177 = 0;
}

//Function Number: 13
func_9DF5(param_00)
{
	if(!isdefined(param_00) && param_00 == "iw7_armageddonmeteor_mp")
	{
		return 0;
	}

	return !scripts\common\utility::istrue(self.var_6F2D);
}

//Function Number: 14
func_6F33(param_00,param_01,param_02)
{
	if(scripts\common\utility::istrue(self.var_6F2D))
	{
		return;
	}

	self endon("death");
	self.var_6F2D = 1;
	self.do_immediate_ragdoll = 1;
	self.var_4C87 = 1;
	var_03 = self.origin - param_00 * (1,1,0);
	var_03 = vectornormalize(var_03);
	var_03 = vectornormalize(var_03 + (0,0,1)) * 600;
	self setvelocity(var_03);
	wait(0.5);
	self.var_6F2D = 0;
	self dodamage(self.maxhealth + 10000,param_01);
}

//Function Number: 15
func_576A(param_00)
{
	wait(1.5);
	earthquake(level.var_2175,param_00 + level.var_5FCC,(742,-853,-85),5000);
}

//Function Number: 16
func_952E()
{
	level.var_2173 = [];
	var_00 = scripts\common\utility::getstructarray("armageddon_area_marker","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = [];
		var_04 = scripts\common\utility::getstruct(var_02.target,"targetname");
		var_03[var_03.size] = var_02.origin;
		var_03[var_03.size] = var_04.origin;
		level.var_2173[level.var_2173.size] = var_03;
	}
}