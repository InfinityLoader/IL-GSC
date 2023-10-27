/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_weather.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 15
 * Decompile Time: 241 ms
 * Timestamp: 10/27/2023 1:38:06 AM
*******************************************************************/

//Function Number: 1
func_62EB(param_00)
{
	level notify("rain_change","hard",param_00);
	level thread raineffectchange(10,param_00);
	wait(param_00 * 0.5);
	level.var_CC0["rain"] = "";
	wait(param_00 * 0.5);
}

//Function Number: 2
func_62F2(param_00)
{
	level notify("rain_change","hard",param_00);
	level thread raineffectchange(8,param_00);
	wait(param_00 * 0.5);
	level.var_CC0["rain"] = "";
	wait(param_00 * 0.5);
}

//Function Number: 3
func_62F1(param_00)
{
	level notify("rain_change","light",param_00);
	level thread raineffectchange(5,param_00);
	wait(param_00 * 0.5);
	level.var_CC0["rain"] = "light";
	wait(param_00 * 0.5);
}

//Function Number: 4
func_62F3(param_00)
{
	level notify("rain_change","none",param_00);
	level thread raineffectchange(0,param_00);
	wait(param_00 * 0.5);
	level.var_CC0["rain"] = "norain";
	wait(param_00 * 0.5);
}

//Function Number: 5
func_62ED(param_00)
{
	common_scripts\utility::func_3385("_weather_lightning_enabled");
	common_scripts\utility::flag_set("_weather_lightning_enabled");
	if(param_00 == "none")
	{
		level.var_62EE = 0;
		level._effect["rain_drops"] = level._effect["rain_" + level.var_62EE];
		func_62F3(0.1);
	}

	if(param_00 == "light")
	{
		level.var_62EE = 5;
		level._effect["rain_drops"] = level._effect["rain_" + level.var_62EE];
		func_62F1(0.1);
	}

	level.var_62EE = 10;
	level._effect["rain_drops"] = level._effect["rain_" + level.var_62EE];
	func_62EB(0.1);
}

//Function Number: 6
func_4DFF(param_00,param_01)
{
	[[ param_00 ]]();
	waittillframeend;
	lightningthink(param_00,param_01);
}

//Function Number: 7
raineffectchange(param_00,param_01)
{
	level notify("rain_level_change");
	level endon("rain_level_change");
	if(level.var_62EE > param_00)
	{
		var_02 = level.var_62EE - param_00;
		param_01 = param_01 / var_02;
		for(var_03 = 0;var_03 < var_02;var_03++)
		{
			wait(param_01);
			level.var_62EE--;
			level._effect["rain_drops"] = level._effect["rain_" + level.var_62EE];
		}
	}

	if(level.var_62EE < param_00)
	{
		var_02 = param_00 - level.var_62EE;
		param_01 = param_01 / var_02;
		for(var_03 = 0;var_03 < var_02;var_03++)
		{
			wait(param_01);
			level.var_62EE++;
			level._effect["rain_drops"] = level._effect["rain_" + level.var_62EE];
		}
	}
}

//Function Number: 8
func_0935(param_00)
{
	if(!isdefined(level.lightningexploder))
	{
		level.lightningexploder = [];
		level.lightningexploderindex = 0;
	}

	level.lightningexploder[level.lightningexploder.size] = param_00;
}

//Function Number: 9
func_5FFF()
{
	var_00 = getentarray("player","classname")[0];
	for(;;)
	{
		playfx(level._effect["rain_drops"],var_00.origin + (0,0,650),var_00.origin + (0,0,680));
		wait(0.3);
	}
}

//Function Number: 10
func_62EF()
{
	if(level.var_62EE == 0)
	{
		return randomfloat(30);
	}

	if(level.var_62EE == 1)
	{
		return randomfloat(24);
	}

	if(level.var_62EE == 2)
	{
		return randomfloat(20);
	}

	if(level.var_62EE == 3)
	{
		return randomfloat(15);
	}

	if(level.var_62EE == 4)
	{
		return randomfloat(12);
	}

	if(level.var_62EE == 5)
	{
		return randomfloat(9);
	}

	if(level.var_62EE == 6)
	{
		return randomfloat(8);
	}

	if(level.var_62EE == 7)
	{
		return randomfloat(8);
	}

	if(level.var_62EE == 8)
	{
		return randomfloat(7);
	}

	if(level.var_62EE == 9)
	{
		return randomfloat(6);
	}

	if(level.var_62EE == 10)
	{
		return randomfloat(5);
	}
}

//Function Number: 11
func_62F0()
{
	if(level.var_62EE == 0)
	{
		return 20;
	}

	if(level.var_62EE == 1)
	{
		return 18;
	}

	if(level.var_62EE == 2)
	{
		return 16;
	}

	if(level.var_62EE == 3)
	{
		return 14;
	}

	if(level.var_62EE == 4)
	{
		return 12;
	}

	if(level.var_62EE == 5)
	{
		return 10;
	}

	if(level.var_62EE == 6)
	{
		return 9;
	}

	if(level.var_62EE == 7)
	{
		return 8;
	}

	if(level.var_62EE == 8)
	{
		return 7;
	}

	if(level.var_62EE == 9)
	{
		return 6;
	}

	if(level.var_62EE == 10)
	{
		return 5;
	}
}

//Function Number: 12
lightningthink(param_00,param_01)
{
	level endon("rain_change");
	var_02 = gettime() + func_62F0() + func_62EF() * 1000;
	if(var_02 < level.var_55ED)
	{
		level.var_55ED = var_02;
	}

	for(;;)
	{
		common_scripts\utility::flag_wait("_weather_lightning_enabled");
		var_03 = level.var_55ED - gettime() * 0.001;
		if(var_03 > 0)
		{
			wait(var_03);
		}

		if(!common_scripts\utility::flag("_weather_lightning_enabled"))
		{
			continue;
		}

		func_4E04(param_00,param_01);
		level.var_55ED = gettime() + func_62F0() + func_62EF() * 1000;
	}
}

//Function Number: 13
func_3485(param_00)
{
	if(isdefined(level.lightningexploderindex))
	{
		common_scripts\utility::exploder(level.lightningexploder[level.lightningexploderindex]);
	}

	[[ param_00 ]]();
}

//Function Number: 14
func_4E04(param_00,param_01,param_02)
{
	var_03[0] = "quick";
	var_03[1] = "double";
	var_03[2] = "triple";
	thread func_80C9();
	if(!isdefined(param_02))
	{
		param_02 = randomint(var_03.size);
	}

	var_04 = 0;
	if(isdefined(level.lightningexploderindex))
	{
		while(var_04 == level.lightningexploderindex)
		{
			var_04 = randomint(level.lightningexploder.size);
		}

		level.lightningexploderindex = var_04;
	}

	switch(var_03[param_02])
	{
		case "quick":
			func_3485(param_01);
			break;

		case "double":
			func_3485(param_01);
			wait(0.05);
			func_3485(param_01);
			break;

		case "triple":
			func_3485(param_01);
			wait(0.05);
			func_3485(param_01);
			wait(0.5);
			func_3485(param_01);
			break;
	}
}

//Function Number: 15
func_80C9()
{
	if(level.var_62EE == 0)
	{
		wait(6 + randomfloat(2));
	}
	else if(level.var_62EE == 1)
	{
		wait(5 + randomfloat(1.8));
	}
	else if(level.var_62EE == 2)
	{
		wait(4.5 + randomfloat(1.6));
	}
	else if(level.var_62EE == 3)
	{
		wait(4 + randomfloat(1.6));
	}
	else if(level.var_62EE == 4)
	{
		wait(3.5 + randomfloat(1.5));
	}
	else if(level.var_62EE == 5)
	{
		wait(3 + randomfloat(1.5));
	}
	else if(level.var_62EE == 6)
	{
		wait(2.5 + randomfloat(1.2));
	}
	else if(level.var_62EE == 7)
	{
		wait(2 + randomfloat(1));
	}
	else if(level.var_62EE == 8)
	{
		wait(1.9 + randomfloat(0.5));
	}
	else if(level.var_62EE == 9)
	{
		wait(1.5);
	}
	else if(level.var_62EE == 10)
	{
		wait(1);
	}

	var_00 = spawn("script_origin",(0,0,0));
	var_00.origin = level.player.origin + (0,0,60);
	var_00 linkto(level.player);
	if(level.var_62EE <= 8)
	{
		var_00 playsound("elm_thunder_distant","sounddone");
	}
	else
	{
		var_00 playsound("elm_thunder_distant","sounddone");
		var_00 thread maps\_utility::func_5D23("elm_thunder_strike");
	}

	var_00 waittill("sounddone");
	var_00 delete();
}