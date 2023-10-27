/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_player_limp.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 19
 * Decompile Time: 255 ms
 * Timestamp: 10/27/2023 1:37:23 AM
*******************************************************************/

//Function Number: 1
init_player_limp()
{
	precacheshellshock("player_limp");
	precachematerial("black");
}

//Function Number: 2
func_4535()
{
	level.var_5E81 = [];
	level.var_5E81["pitch"]["min"] = 2;
	level.var_5E81["pitch"]["max"] = 5;
	level.var_5E81["yaw"]["min"] = -8;
	level.var_5E81["yaw"]["max"] = 5;
	level.var_5E81["roll"]["min"] = 3;
	level.var_5E81["roll"]["max"] = 5;
}

//Function Number: 3
func_6E71(param_00,param_01,param_02)
{
	if(isdefined(param_00))
	{
		level.var_5E81["pitch"]["min"] = param_00["min"];
		level.var_5E81["pitch"]["max"] = param_00["max"];
	}

	if(isdefined(param_01))
	{
		level.var_5E81["yaw"]["min"] = param_01["min"];
		level.var_5E81["yaw"]["max"] = param_01["max"];
	}

	if(isdefined(param_02))
	{
		level.var_5E81["roll"]["min"] = param_02["min"];
		level.var_5E81["roll"]["max"] = param_02["max"];
	}
}

//Function Number: 4
func_65E3(param_00,param_01,param_02)
{
	if(!isdefined(param_00) && !isdefined(param_01) && !isdefined(param_02))
	{
		level.var_5E81["pitch"]["min"] = 2;
		level.var_5E81["pitch"]["max"] = 5;
		level.var_5E81["yaw"]["min"] = -8;
		level.var_5E81["yaw"]["max"] = 5;
		level.var_5E81["roll"]["min"] = 3;
		level.var_5E81["roll"]["max"] = 5;
	}

	if(isdefined(param_00))
	{
		level.var_5E81["pitch"]["min"] = 2;
		level.var_5E81["pitch"]["max"] = 5;
	}

	if(isdefined(param_01))
	{
		level.var_5E81["yaw"]["min"] = -8;
		level.var_5E81["yaw"]["max"] = 5;
	}

	if(isdefined(param_02))
	{
		level.var_5E81["roll"]["min"] = 3;
		level.var_5E81["roll"]["max"] = 5;
	}
}

//Function Number: 5
enable_limp(param_00,param_01)
{
	if(!maps\_utility::ent_flag_exist("fall"))
	{
		maps\_utility::func_2F47("fall");
		maps\_utility::func_2F47("collapse");
	}

	if(!isdefined(level.var_5E81))
	{
		func_4535();
	}

	self.var_4E14 = 1;
	self.var_7982 = undefined;
	self.allow_fall = 1;
	self.var_4E15 = 1;
	level.default_heartbeat_rate = 0.75;
	func_2082();
	level.var_59FE = self.var_8A06.var_89FF;
	if(!isdefined(param_00))
	{
		param_00 = 75;
	}

	maps\_utility::func_5F1D(param_00,0.05);
	self.player_speed = param_00;
	thread func_4E14();
	if(isdefined(param_01))
	{
		thread func_313A(param_01);
	}
}

//Function Number: 6
func_2770(param_00,param_01)
{
	self notify("stop_limp");
	self notify("stop_random_blur");
	self fadeoutshellshock();
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(isdefined(param_00))
	{
		self playersetgroundreferenceent(undefined);
		function_0168("player_sprintUnlimited","0");
		self notify("stop_limp_forgood");
	}
	else
	{
		var_02 = randomfloatrange(0.65,1.25);
		var_03 = adjust_angles_to_player((0,0,0));
		self.ground_ref_ent rotateto(var_03,var_02,0,var_02 / 2);
		self.ground_ref_ent waittill("rotatedone");
	}

	level.player maps\_utility::func_8A02(level.var_59FE,0);
	function_0195(0,randomfloatrange(0.5,0.75));
	self method_8272(1);
	self method_8273(1);
	self method_8274(1);
	self allowsprint(1);
	self allowjump(1);
}

//Function Number: 7
func_313A(param_00)
{
	self endon("stop_limp");
	wait(param_00);
	thread func_2770();
}

//Function Number: 8
func_4E14(param_00)
{
	self endon("stop_limp");
	self shellshock("player_limp",9999);
	self allowsprint(0);
	self allowjump(0);
	thread func_5ED5();
	thread func_5E40();
	level waittill("blah blah blah");
	var_01 = 0;
	var_02 = self.var_8A06.var_89FF;
	for(;;)
	{
		if(self playerads() > 0.3)
		{
			wait(0.05);
			continue;
		}

		var_03 = level.player getstance();
		if(var_03 == "crouch" || var_03 == "prone")
		{
			wait(0.05);
			continue;
		}

		var_04 = self getvelocity();
		var_05 = abs(var_04[0]) + abs(var_04[1]);
		if(var_05 < 10)
		{
			wait(0.05);
			continue;
		}

		var_06 = var_05 / self.player_speed;
		var_07 = randomfloatrange(level.var_5E81["pitch"]["min"],level.var_5E81["pitch"]["max"]);
		if(randomint(100) < 20)
		{
			var_07 = var_07 * 1.5;
		}

		var_08 = randomfloatrange(level.var_5E81["roll"]["min"],level.var_5E81["roll"]["max"]);
		var_09 = randomfloatrange(level.var_5E81["yaw"]["min"],level.var_5E81["yaw"]["max"]);
		var_0A = (var_07,var_09,var_08);
		var_0A = var_0A * var_06;
		var_0A = var_0A * self.var_4E15;
		var_0B = randomfloatrange(0.15,0.45);
		var_0C = randomfloatrange(0.65,1.25);
		if(self.var_8A06.var_89FF != "aftermath_pain")
		{
			var_02 = self.var_8A06.var_89FF;
		}

		thread maps\_utility::func_8A02("aftermath_pain",3);
		thread func_7D11(var_0A,var_0B,var_0C);
		wait(var_0B);
		thread maps\_utility::func_8A02(var_02,var_0C);
		self waittill("recovered");
	}
}

//Function Number: 9
func_7D11(param_00,param_01,param_02,param_03)
{
	self endon("stop_stumble");
	self endon("stop_limp");
	if(maps\_utility::ent_flag("collapse"))
	{
	}

	param_00 = adjust_angles_to_player(param_00);
	self notify("stumble");
	func_2082();
	self.ground_ref_ent rotateto(param_00,param_01,param_01 / 4 * 3,param_01 / 4);
	self.ground_ref_ent waittill("rotatedone");
	var_04 = (randomfloat(4) - 4,randomfloat(5),0);
	var_04 = adjust_angles_to_player(var_04);
	self.ground_ref_ent rotateto(var_04,param_02,0,param_02 / 2);
	self.ground_ref_ent waittill("rotatedone");
	if(!isdefined(param_03))
	{
		self notify("recovered");
	}
}

//Function Number: 10
player_random_sway()
{
	self endon("stop_random_sway");
	for(;;)
	{
		var_00 = self getvelocity();
		if(var_00 > 0)
		{
			wait(0.05);
			continue;
		}

		wait(0.05);
	}
}

//Function Number: 11
func_5ED5()
{
	self endon("dying");
	self endon("stop_random_blur");
	for(;;)
	{
		wait(0.05);
		if(randomint(100) > 10)
		{
			continue;
		}

		var_00 = randomint(3) + 4;
		var_01 = randomfloatrange(0.1,0.3);
		var_02 = randomfloatrange(0.3,1);
		function_0195(var_00 * 1.2,var_01);
		wait(var_01);
		function_0195(0,var_02);
		wait(var_02);
		wait(randomfloatrange(0,1.5));
		common_scripts\utility::waittill_notify_or_timeout("blur",5);
	}
}

//Function Number: 12
func_5E40()
{
	self endon("stop_limp");
	for(;;)
	{
		if(func_5EC0())
		{
			wait(0.05);
			continue;
		}

		self notify("blur");
		common_scripts\utility::func_5D1F("breathing_limp_start");
		common_scripts\utility::func_5D1F("breathing_limp_better");
		wait(randomfloatrange(0,1));
		common_scripts\utility::waittill_notify_or_timeout("stumble",randomintrange(5,7));
	}
}

//Function Number: 13
func_5E2A()
{
	self endon("stop_limp");
	level.player_heartbeat_rate = 0.75;
	for(;;)
	{
		common_scripts\utility::func_5D1F("breathing_limp_heartbeat");
		wait(level.player_heartbeat_rate);
	}
}

//Function Number: 14
set_player_hearbeat_rate(param_00)
{
	if(!isdefined(param_00) || isstring(param_00))
	{
		level.player_heartbeat_rate = 0.75;
	}

	level.player_heartbeat_rate = param_00;
}

//Function Number: 15
func_5EC0()
{
	if(level.player.health < 50)
	{
		return 1;
	}

	return 0;
}

//Function Number: 16
func_5E6D()
{
	self endon("stop_limp_forgood");
	wait(1);
	for(;;)
	{
		wait(0.05);
		if(self isonground())
		{
			continue;
		}

		wait(0.2);
		if(self isonground())
		{
			continue;
		}

		for(;;)
		{
			if(self isonground())
			{
				break;
			}
			else
			{
				wait(0.05);
			}
		}

		self notify("stop_stumble");
		wait(0.2);
		func_4E14();
		self notify("start_limp");
	}
}

//Function Number: 17
func_640F()
{
	var_00 = adjust_angles_to_player((-5,-5,0));
	self.ground_ref_ent rotateto(var_00,0.4,0.4,0);
	self.ground_ref_ent waittill("rotatedone");
	var_00 = adjust_angles_to_player((-15,-20,0));
	self.ground_ref_ent rotateto(var_00,1,0,1);
	self.ground_ref_ent waittill("rotatedone");
	var_00 = adjust_angles_to_player((5,5,0));
	self.ground_ref_ent rotateto(var_00,0.9,0.7,0.1);
	self.ground_ref_ent waittill("rotatedone");
	self.ground_ref_ent rotateto((0,0,0),1,0.2,0.8);
}

//Function Number: 18
adjust_angles_to_player(param_00)
{
	var_01 = param_00[0];
	var_02 = param_00[2];
	var_03 = anglestoright(self.angles);
	var_04 = anglestoforward(self.angles);
	var_05 = (var_03[0],0,var_03[1] * -1);
	var_06 = (var_04[0],0,var_04[1] * -1);
	var_07 = var_05 * var_01;
	var_07 = var_07 + var_06 * var_02;
	return var_07 + (0,param_00[1],0);
}

//Function Number: 19
func_2082()
{
	if(isdefined(self.ground_ref_ent))
	{
	}

	self.ground_ref_ent = spawn("script_model",(0,0,0));
	self playersetgroundreferenceent(self.ground_ref_ent);
}