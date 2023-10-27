/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3022.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 23 ms
 * Timestamp: 10/27/2023 12:26:04 AM
*******************************************************************/

//Function Number: 1
main(param_00)
{
	if(!isdefined(level.var_A3B9))
	{
		level.var_A3B9 = spawnstruct();
		level.var_A3B9.var_11888 = loadfx("vfx/iw7/core/vehicle/jackal/vfx_jackal_rear_thrust_fly_atmosphere.vfx");
		level.var_A3B9.var_10573 = loadfx("vfx/old/space_fighter/space_particulate_player_oneshot.vfx");
		level.var_A3B9.var_375D = param_00;
		level.var_A3B9.var_375D.var_444F = ::init;
		func_A22F(param_00);
	}
}

//Function Number: 2
func_A22F(param_00)
{
	var_01 = getentarray("script_vehicle","code_classname");
	foreach(var_03 in var_01)
	{
		if(isspawner(var_03) || !function_00FD(var_03) || !func_1312C(var_03))
		{
			continue;
		}

		var_03 init();
	}
}

//Function Number: 3
func_1312C(param_00)
{
	var_01 = ["script_vehicle_jackal_friendly","script_vehicle_jackal_friendly_moon","script_vehicle_jackal_friendly_heist","script_vehicle_jackal_friendly_pearl","script_vehicle_jackal_friendly_marsbase_cheap","script_vehicle_jackal_enemy","script_vehicle_jackal_enemy_marsbase_cheap","script_vehicle_jackal_fake_friendly","script_vehicle_jackal_fake_enemy"];
	if(scripts\common\utility::func_2286(var_01,param_00.classname))
	{
		return 1;
	}

	return 0;
}

//Function Number: 4
init()
{
	if(isdefined(level.var_A3B9) && !isdefined(self.var_A3B9))
	{
		var_00 = level.var_A3B9.var_375D;
		self.var_A3B9 = spawnstruct();
		self.var_A3B9.var_375D = var_00;
		func_9639();
		self [[ var_00.init ]]();
	}
}

//Function Number: 5
func_9639()
{
	self.var_5958 = 1;
	self.var_C1DB = 0;
	self method_8455(self.origin);
}

//Function Number: 6
func_A2B2(param_00,param_01,param_02)
{
	param_00 notify("enter_jackal");
	self setplayerangles(param_00.angles);
	param_00.var_222 = self;
	self.ignoreme = 1;
	self method_825C(param_00);
	param_00 method_81F1(self.team,0);
	param_00 method_8364(self.team);
	if(isdefined(param_01))
	{
		self.var_E473 = self getorigin();
		self setorigin(param_01);
	}

	if(!isdefined(param_02))
	{
		param_02 = "fly";
	}

	param_00 method_8491(param_02);
	self method_8490("disable_pilot_move_assist",1);
	thread func_B9C1(param_00,self);
}

//Function Number: 7
func_A2B1(param_00)
{
	self notify("exit_jackal");
	self method_825D();
	if(isdefined(self.var_E473))
	{
		self setorigin(self.var_E473);
	}

	self.ignoreme = 0;
	param_00.var_222 = undefined;
}

//Function Number: 8
func_104FE()
{
	level notify("stop_particulates");
	level endon("stop_particulates");
	thread func_104FF();
	for(;;)
	{
		var_00 = anglestoforward(level.var_D127.angles) * 300;
		playfx(scripts\common\utility::getfx("space_particulate_player"),level.var_D127.origin + var_00);
		wait(0.6);
	}
}

//Function Number: 9
func_104FF()
{
	level endon("stop_particulates");
	for(;;)
	{
		var_00 = level.var_D127.origin;
		wait(0.1);
		if(distance(var_00,level.var_D127.origin) > 1)
		{
			var_01 = vectortoangles(level.var_D127.origin - var_00);
			var_02 = anglestoforward(var_01) * 256;
			playfx(scripts\common\utility::getfx("space_particulate_player"),level.var_D127.origin + var_02);
		}
	}
}

//Function Number: 10
func_B9C1(param_00,param_01)
{
	level endon("game_ended");
	param_01 endon("disconnect");
	param_01 endon("exit_jackal");
	param_00 endon("death");
	for(;;)
	{
		while(!param_00.var_2A8)
		{
			scripts\common\utility::func_136F7();
		}

		param_01 notify("engage boost");
		while(param_00.var_2A8)
		{
			scripts\common\utility::func_136F7();
		}

		param_01 notify("disengage boost");
	}
}

//Function Number: 11
func_7DB5()
{
	var_00 = [];
	var_01 = vehicle_getarray();
	foreach(var_03 in var_01)
	{
		if(function_00FD(var_03))
		{
			var_00[var_00.size] = var_03;
		}
	}

	return var_00;
}

//Function Number: 12
func_10056()
{
	if(isdefined(level.var_241D) && level.var_241D)
	{
		return 0;
	}

	return 1;
}