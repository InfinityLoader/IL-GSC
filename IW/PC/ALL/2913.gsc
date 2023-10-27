/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2913.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 7 ms
 * Timestamp: 10/27/2023 12:24:54 AM
*******************************************************************/

//Function Number: 1
func_95A4()
{
	level.var_D1D4 = [];
	level.var_D1D4["pitch"]["min"] = 2;
	level.var_D1D4["pitch"]["max"] = 5;
	level.var_D1D4["yaw"]["min"] = -8;
	level.var_D1D4["yaw"]["max"] = 5;
	level.var_D1D4["roll"]["min"] = 3;
	level.var_D1D4["roll"]["max"] = 5;
	level.player.var_ACDE = 0;
}

//Function Number: 2
func_F324(param_00,param_01,param_02)
{
	if(isdefined(param_00))
	{
		level.var_D1D4["pitch"]["min"] = param_00["min"];
		level.var_D1D4["pitch"]["max"] = param_00["max"];
	}

	if(isdefined(param_01))
	{
		level.var_D1D4["yaw"]["min"] = param_01["min"];
		level.var_D1D4["yaw"]["max"] = param_01["max"];
	}

	if(isdefined(param_02))
	{
		level.var_D1D4["roll"]["min"] = param_02["min"];
		level.var_D1D4["roll"]["max"] = param_02["max"];
	}
}

//Function Number: 3
func_554E()
{
	level.player notify("stop_limp");
	if(isdefined(level.player.var_8632))
	{
		var_00 = level.player func_186F((0,0,0));
		level.player.var_8632 rotateto(var_00,0.05,0,0.05);
		level.player.var_8632 waittill("rotatedone");
		level.player method_823F(undefined);
		level.player.var_8632 delete();
	}

	level.player.var_ACDE = 0;
}

//Function Number: 4
func_ACDE(param_00,param_01,param_02,param_03)
{
	self endon("stop_limp");
	self.var_ACDE = 1;
	func_48F7();
	thread func_3DB3(param_00,param_01);
	for(;;)
	{
		if(level.player getstance() == "prone")
		{
			wait(0.05);
			continue;
		}

		func_36DC(param_00,param_02,param_01,param_03);
		if(param_01)
		{
			if(param_00 == "leg_left")
			{
				param_00 = "leg_right";
			}
			else
			{
				param_00 = "leg_left";
			}
		}

		param_03 = 0;
		param_02 = 0;
		wait(0.05);
	}
}

//Function Number: 5
func_3DB3(param_00,param_01)
{
	self endon("stop_limp");
	var_02 = 1;
	var_03 = level.player getvelocity();
	var_04 = func_7B8E();
	for(;;)
	{
		if(var_02)
		{
			var_02 = 0;
			wait(0.05);
			continue;
		}

		if(level.player getstance() == "prone")
		{
			wait(0.05);
			continue;
		}

		if(func_9BBB(var_04))
		{
			thread func_E2AC(param_00,param_01,1.5,0);
			break;
		}

		if(func_9D0D(var_03))
		{
			thread func_E2AC(param_00,param_01,1,0);
			break;
		}

		var_03 = level.player getvelocity();
		var_04 = func_7B8E();
		wait(0.05);
	}
}

//Function Number: 6
func_9BBB(param_00)
{
	if(func_7B8E() != param_00)
	{
		return 1;
	}

	return 0;
}

//Function Number: 7
func_7B8E()
{
	var_00 = vectortoangles(level.player getnormalizedmovement())[1];
	if(var_00 >= 315 || var_00 <= 45)
	{
		var_01 = "forward";
	}
	else if(var_01 > 45 && var_01 < 135)
	{
		var_01 = "right";
	}
	else if(var_01 > 225 && var_01 < 315)
	{
		var_01 = "left";
	}
	else
	{
		var_01 = "backward";
	}

	return var_01;
}

//Function Number: 8
func_9D0D(param_00)
{
	var_01 = length(param_00);
	param_00 = length(level.player getvelocity());
	return param_00 - var_01 >= 20;
}

//Function Number: 9
func_E2AC(param_00,param_01,param_02,param_03)
{
	self notify("stop_limp");
	var_04 = [];
	self.var_ACDE = 0;
	var_05 = func_7B8E();
	if(var_05 == "forward")
	{
		var_04["pitch"]["min"] = 1;
		var_04["pitch"]["max"] = 1.5;
		var_04["yaw"]["min"] = -1.5;
		var_04["yaw"]["max"] = -1;
		var_04["roll"]["min"] = 2.25;
		var_04["roll"]["max"] = 3;
	}
	else if(var_05 == "right")
	{
		var_04["pitch"]["min"] = 1.7;
		var_04["pitch"]["max"] = 2;
		var_04["yaw"]["min"] = 2;
		var_04["yaw"]["max"] = 4;
		var_04["roll"]["min"] = -4;
		var_04["roll"]["max"] = -3;
	}
	else if(var_05 == "left")
	{
		var_04["pitch"]["min"] = 1.7;
		var_04["pitch"]["max"] = 2;
		var_04["yaw"]["min"] = 2;
		var_04["yaw"]["max"] = 4;
		var_04["roll"]["min"] = -4;
		var_04["roll"]["max"] = -3;
	}
	else if(var_05 == "backward")
	{
		var_04["pitch"]["min"] = 2;
		var_04["pitch"]["max"] = 4;
		var_04["yaw"]["min"] = 4;
		var_04["yaw"]["max"] = 5;
		var_04["roll"]["min"] = -5;
		var_04["roll"]["max"] = -3;
	}

	scripts\common\utility::func_136F7();
	func_F324(var_04["pitch"],var_04["yaw"],var_04["roll"]);
	func_ACDE(param_00,param_01,param_02,param_03);
}

//Function Number: 10
func_36DC(param_00,param_01,param_02,param_03)
{
	self endon("stop_limp");
	var_04 = level.player getstance();
	var_05 = func_D2CC();
	if(length(level.player getnormalizedmovement()) <= 0.1 && !param_03)
	{
		return;
	}

	var_06 = randomfloatrange(level.var_D1D4["pitch"]["min"],level.var_D1D4["pitch"]["max"]);
	var_07 = randomfloatrange(level.var_D1D4["roll"]["min"],level.var_D1D4["roll"]["max"]);
	var_08 = randomfloatrange(level.var_D1D4["yaw"]["min"],level.var_D1D4["yaw"]["max"]);
	if(randomint(100) < 20 && !param_01)
	{
		var_06 = var_06 * 1.25;
		var_07 = var_07 * 1.25;
		var_08 = var_08 * 1.25;
	}

	var_09 = (var_06,var_08,var_07);
	if(param_00 == "leg_left")
	{
		var_09 = (var_09[0] * -1.5,var_09[1] * -1.5,var_09[2]);
	}

	if((param_01 && !level.player method_822E()) || param_03)
	{
		var_05 = param_01;
		var_0A = 0.75;
		var_0B = var_0A / 2.5;
	}
	else
	{
		var_0B = var_07 * 0.5;
		var_0B = 1 - clamp(var_0B,0,0.7);
		var_0A = var_0B * 1.5;
		if(func_7B8E() == "backwards")
		{
			var_0B = var_0B * 6;
			var_0A = var_0A * 3;
		}
	}

	var_09 = var_09 * var_05;
	if(level.player method_822E())
	{
		var_09 = var_09 * 0.65;
		var_0A = var_0A * 1.35;
	}

	if(param_02)
	{
		var_0A = var_0A * 0.5;
	}

	func_11182(var_09,var_0B,var_0A,var_05);
}

//Function Number: 11
func_11182(param_00,param_01,param_02,param_03)
{
	self endon("stop_stumble");
	self endon("stop_limp");
	param_00 = func_186F(param_00);
	self.var_8632 rotateto(param_00,param_01,param_01 / 4 * 3,param_01 / 4);
	self.var_8632 waittill("rotatedone");
	if(isdefined(self.var_883D) && self.var_883D != "none")
	{
		thread func_D0E5(param_03);
	}
	else
	{
		thread func_D0E6(param_03);
	}

	var_04 = (randomfloat(4) - 4,randomfloat(5),0);
	var_04 = func_186F(var_04);
	self.var_8632 rotateto(var_04,param_02,0,param_02 / 2);
	self.var_8632 waittill("rotatedone");
}

//Function Number: 12
func_D2CC()
{
	var_00 = length(level.player getvelocity());
	return var_00 / 100;
}

//Function Number: 13
func_D0E5(param_00)
{
	if(isdefined(self.var_883B) && soundexists(self.var_883B))
	{
		self playsound(self.var_883B);
	}
}

//Function Number: 14
func_D0E6(param_00)
{
	if(param_00 > randomfloatrange(0.7,1))
	{
		level.player playrumbleonentity("damage_light");
		thread scripts\common\utility::play_sound_in_space("breathing_limp");
		scripts\common\utility::play_sound_in_space("breathing_heartbeat");
		return;
	}

	scripts\common\utility::play_sound_in_space("breathing_limp_better");
}

//Function Number: 15
func_D221()
{
	level.player playsound("player_death_generic");
	thread scripts\sp\_utility::func_D020();
	wait(0.75);
	level.player method_83AD();
}

//Function Number: 16
func_186F(param_00)
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

//Function Number: 17
func_48F7()
{
	if(isdefined(self.var_8632))
	{
		return;
	}

	self.var_8632 = spawn("script_model",(0,0,0));
	self method_823F(self.var_8632);
}