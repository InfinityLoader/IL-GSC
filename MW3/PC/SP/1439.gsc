/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1439.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 21 ms
 * Timestamp: 10/27/2023 2:20:30 AM
*******************************************************************/

//Function Number: 1
func_43E6(param_00)
{
	level notify("rain_change","hard",param_00);
	level thread func_43EE(10,param_00);
	wait param_00 * 0.5;
	level.var_43E7["rain"] = "";
	wait param_00 * 0.5;
}

//Function Number: 2
func_43E8(param_00)
{
	level notify("rain_change","hard",param_00);
	level thread func_43EE(8,param_00);
	wait param_00 * 0.5;
	level.var_43E7["rain"] = "";
	wait param_00 * 0.5;
}

//Function Number: 3
func_43E9(param_00)
{
	level notify("rain_change","light",param_00);
	level thread func_43EE(5,param_00);
	wait param_00 * 0.5;
	level.var_43E7["rain"] = "light";
	wait param_00 * 0.5;
}

//Function Number: 4
func_43EA(param_00)
{
	level notify("rain_change","none",param_00);
	level thread func_43EE(0,param_00);
	wait param_00 * 0.5;
	level.var_43E7["rain"] = "norain";
	wait param_00 * 0.5;
}

//Function Number: 5
func_43EB(param_00)
{
	common_scripts\utility::flag_init("_weather_lightning_enabled");
	common_scripts\utility::flag_set("_weather_lightning_enabled");
	if(param_00 == "none")
	{
		level.var_43EC = 0;
		level._effect["rain_drops"] = level._effect["rain_" + level.var_43EC];
		func_43EA(0.1);
		return;
	}

	if(param_00 == "light")
	{
		level.var_43EC = 5;
		level._effect["rain_drops"] = level._effect["rain_" + level.var_43EC];
		func_43E9(0.1);
		return;
	}

	level.var_43EC = 10;
	level._effect["rain_drops"] = level._effect["rain_" + level.var_43EC];
	func_43E6(0.1);
}

//Function Number: 6
func_43ED(param_00,param_01)
{
	[[ param_00 ]]();
	waittillframeend;
	func_43F5(param_00,param_01);
}

//Function Number: 7
func_43EE(param_00,param_01)
{
	level notify("rain_level_change");
	level endon("rain_level_change");
	if(level.var_43EC > param_00)
	{
		var_02 = level.var_43EC - param_00;
		param_01 = param_01 / var_02;
		for(var_03 = 0;var_03 < var_02;var_03++)
		{
			wait param_01;
			level.var_43EC--;
			level._effect["rain_drops"] = level._effect["rain_" + level.var_43EC];
		}
	}

	if(level.var_43EC < param_00)
	{
		var_02 = param_00 - level.var_43EC;
		param_01 = param_01 / var_02;
		for(var_03 = 0;var_03 < var_02;var_03++)
		{
			wait param_01;
			level.var_43EC++;
			level._effect["rain_drops"] = level._effect["rain_" + level.var_43EC];
		}
	}
}

//Function Number: 8
func_43EF(param_00)
{
	if(!isdefined(level.var_43F0))
	{
		level.var_43F0 = [];
		level.var_43F1 = 0;
	}

	level.var_43F0[level.var_43F0.size] = param_00;
}

//Function Number: 9
func_43F2()
{
	var_00 = getentarray("player","classname")[0];
	for(;;)
	{
		playfx(level._effect["rain_drops"],var_00.origin + (0,0,650),var_00.origin + (0,0,680));
		wait 0.3;
	}
}

//Function Number: 10
func_43F3()
{
	if(level.var_43EC == 0)
	{
		return randomfloat(30);
	}

	if(level.var_43EC == 1)
	{
		return randomfloat(24);
	}

	if(level.var_43EC == 2)
	{
		return randomfloat(20);
	}

	if(level.var_43EC == 3)
	{
		return randomfloat(15);
	}

	if(level.var_43EC == 4)
	{
		return randomfloat(12);
	}

	if(level.var_43EC == 5)
	{
		return randomfloat(9);
	}

	if(level.var_43EC == 6)
	{
		return randomfloat(8);
	}

	if(level.var_43EC == 7)
	{
		return randomfloat(8);
	}

	if(level.var_43EC == 8)
	{
		return randomfloat(7);
	}

	if(level.var_43EC == 9)
	{
		return randomfloat(6);
	}

	if(level.var_43EC == 10)
	{
		return randomfloat(5);
	}
}

//Function Number: 11
func_43F4()
{
	if(level.var_43EC == 0)
	{
		return 20;
	}

	if(level.var_43EC == 1)
	{
		return 18;
	}

	if(level.var_43EC == 2)
	{
		return 16;
	}

	if(level.var_43EC == 3)
	{
		return 14;
	}

	if(level.var_43EC == 4)
	{
		return 12;
	}

	if(level.var_43EC == 5)
	{
		return 10;
	}

	if(level.var_43EC == 6)
	{
		return 9;
	}

	if(level.var_43EC == 7)
	{
		return 8;
	}

	if(level.var_43EC == 8)
	{
		return 7;
	}

	if(level.var_43EC == 9)
	{
		return 6;
	}

	if(level.var_43EC == 10)
	{
		return 5;
	}
}

//Function Number: 12
func_43F5(param_00,param_01)
{
	level endon("rain_change");
	var_02 = gettime() + func_43F4() + func_43F3() * 1000;
	if(var_02 < level.var_43F6)
	{
		level.var_43F6 = var_02;
	}

	for(;;)
	{
		common_scripts\utility::flag_wait("_weather_lightning_enabled");
		var_03 = level.var_43F6 - gettime() * 0.001;
		if(var_03 > 0)
		{
			wait var_03;
		}

		if(!common_scripts\utility::flag("_weather_lightning_enabled"))
		{
			continue;
		}

		func_43F8(param_00,param_01);
		level.var_43F6 = gettime() + func_43F4() + func_43F3() * 1000;
	}
}

//Function Number: 13
func_43F7(param_00)
{
	if(isdefined(level.var_43F1))
	{
		common_scripts\utility::exploder(level.var_43F0[level.var_43F1]);
	}

	[[ param_00 ]]();
}

//Function Number: 14
func_43F8(param_00,param_01,param_02)
{
	var_03[0] = "quick";
	thread func_43F9();
	if(!isdefined(var_03))
	{
		var_03 = randomint(var_7B.size);
	}

	var_04 = 0;
	if(isdefined(level.var_43F1))
	{
		while(var_04 == level.var_43F1)
		{
			var_04 = randomint(level.var_43F0.size);
		}

		level.var_43F1 = var_04;
	}

	switch(var_7B[var_03])
	{
		case "quick":
			func_43F7(param_02);
			break;

		case "double":
			func_43F7(param_02);
			wait 0.05;
			func_43F7(param_02);
			break;

		case "triple":
			func_43F7(param_02);
			wait 0.05;
			func_43F7(param_02);
			wait 0.5;
			func_43F7(param_02);
			break;
	}
}

//Function Number: 15
func_43F9()
{
	if(level.var_43EC == 0)
	{
		wait 6 + randomfloat(2);
	}
	else if(level.var_43EC == 1)
	{
		wait 5 + randomfloat(1.8);
	}
	else if(level.var_43EC == 2)
	{
		wait 4.5 + randomfloat(1.6);
	}
	else if(level.var_43EC == 3)
	{
		wait 4 + randomfloat(1.6);
	}
	else if(level.var_43EC == 4)
	{
		wait 3.5 + randomfloat(1.5);
	}
	else if(level.var_43EC == 5)
	{
		wait 3 + randomfloat(1.5);
	}
	else if(level.var_43EC == 6)
	{
		wait 2.5 + randomfloat(1.2);
	}
	else if(level.var_43EC == 7)
	{
		wait 2 + randomfloat(1);
	}
	else if(level.var_43EC == 8)
	{
		wait 1.9 + randomfloat(0.5);
	}
	else if(level.var_43EC == 9)
	{
		wait 1.5;
	}
	else if(level.var_43EC == 10)
	{
		wait 1;
	}

	var_00 = spawn("script_origin",(0,0,0));
	var_00.origin = level.player.origin + (0,0,60);
	var_00 linkto(level.player);
	if(level.var_43EC <= 8)
	{
		var_00 playsound("elm_thunder_distant","sounddone");
	}
	else
	{
		var_00 playsound("elm_thunder_distant","sounddone");
		var_00 thread maps\_utility::play_sound_on_entity("elm_thunder_strike");
	}

	var_00 waittill("sounddone");
	var_00 delete();
}