/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_weather.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 234 ms
 * Timestamp: 10/27/2023 2:50:15 AM
*******************************************************************/

//Function Number: 1
rainhard(param_00)
{
	level notify("rain_change","hard",param_00);
	level thread raineffectchange(10,param_00);
	wait(param_00 * 0.5);
	level.ambient_modifier["rain"] = "";
	wait(param_00 * 0.5);
}

//Function Number: 2
rainmedium(param_00)
{
	level notify("rain_change","hard",param_00);
	level thread raineffectchange(8,param_00);
	wait(param_00 * 0.5);
	level.ambient_modifier["rain"] = "";
	wait(param_00 * 0.5);
}

//Function Number: 3
rainlight(param_00)
{
	level notify("rain_change","light",param_00);
	level thread raineffectchange(5,param_00);
	wait(param_00 * 0.5);
	level.ambient_modifier["rain"] = "light";
	wait(param_00 * 0.5);
}

//Function Number: 4
rainnone(param_00)
{
	level notify("rain_change","none",param_00);
	level thread raineffectchange(0,param_00);
	wait(param_00 * 0.5);
	level.ambient_modifier["rain"] = "norain";
	wait(param_00 * 0.5);
}

//Function Number: 5
raininit(param_00)
{
	common_scripts\utility::flag_init("_weather_lightning_enabled");
	common_scripts\utility::flag_set("_weather_lightning_enabled");
	common_scripts\utility::flag_init("player_weather_enabled");
	common_scripts\utility::flag_set("player_weather_enabled");
	if(param_00 == "none")
	{
		level.rainlevel = 0;
		level._effect["rain_drops"] = level._effect["rain_" + level.rainlevel];
		rainnone(0.1);
		return;
	}

	if(param_00 == "light")
	{
		level.rainlevel = 5;
		level._effect["rain_drops"] = level._effect["rain_" + level.rainlevel];
		rainlight(0.1);
		return;
	}

	level.rainlevel = 10;
	level._effect["rain_drops"] = level._effect["rain_" + level.rainlevel];
	rainhard(0.1);
}

//Function Number: 6
lightning(param_00,param_01)
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
	if(level.rainlevel > param_00)
	{
		var_02 = level.rainlevel - param_00;
		param_01 = param_01 / var_02;
		for(var_03 = 0;var_03 < var_02;var_03++)
		{
			wait(param_01);
			level.rainlevel--;
			level._effect["rain_drops"] = level._effect["rain_" + level.rainlevel];
		}
	}

	if(level.rainlevel < param_00)
	{
		var_02 = param_00 - level.rainlevel;
		param_01 = param_01 / var_02;
		for(var_03 = 0;var_03 < var_02;var_03++)
		{
			wait(param_01);
			level.rainlevel++;
			level._effect["rain_drops"] = level._effect["rain_" + level.rainlevel];
		}
	}
}

//Function Number: 8
addlightningexploder(param_00)
{
	if(!isdefined(level.lightningexploder))
	{
		level.lightningexploder = [];
		level.lightningexploderindex = 0;
	}

	level.lightningexploder[level.lightningexploder.size] = param_00;
}

//Function Number: 9
playerweather()
{
	var_00 = getentarray("player","classname")[0];
	var_01 = common_scripts\utility::spawn_tag_origin();
	for(;;)
	{
		while(common_scripts\utility::flag("player_weather_enabled"))
		{
			var_02 = var_00.angles;
			var_01 moveto(var_00.origin + (0,0,650),0.1);
			var_01 rotateto((-90,var_02[1],180),0.1);
			playfxontag(level._effect["rain_drops"],var_01,"tag_origin");
			wait(0.3);
		}

		common_scripts\utility::flag_wait("player_weather_enabled");
	}
}

//Function Number: 10
rainlevelrandomwait()
{
	if(level.rainlevel == 0)
	{
		return randomfloat(30);
	}

	if(level.rainlevel == 1)
	{
		return randomfloat(24);
	}

	if(level.rainlevel == 2)
	{
		return randomfloat(20);
	}

	if(level.rainlevel == 3)
	{
		return randomfloat(15);
	}

	if(level.rainlevel == 4)
	{
		return randomfloat(12);
	}

	if(level.rainlevel == 5)
	{
		return randomfloat(9);
	}

	if(level.rainlevel == 6)
	{
		return randomfloat(8);
	}

	if(level.rainlevel == 7)
	{
		return randomfloat(8);
	}

	if(level.rainlevel == 8)
	{
		return randomfloat(7);
	}

	if(level.rainlevel == 9)
	{
		return randomfloat(6);
	}

	if(level.rainlevel == 10)
	{
		return randomfloat(5);
	}
}

//Function Number: 11
rainlevelwait()
{
	if(level.rainlevel == 0)
	{
		return 20;
	}

	if(level.rainlevel == 1)
	{
		return 18;
	}

	if(level.rainlevel == 2)
	{
		return 16;
	}

	if(level.rainlevel == 3)
	{
		return 14;
	}

	if(level.rainlevel == 4)
	{
		return 12;
	}

	if(level.rainlevel == 5)
	{
		return 10;
	}

	if(level.rainlevel == 6)
	{
		return 9;
	}

	if(level.rainlevel == 7)
	{
		return 8;
	}

	if(level.rainlevel == 8)
	{
		return 7;
	}

	if(level.rainlevel == 9)
	{
		return 6;
	}

	if(level.rainlevel == 10)
	{
		return 5;
	}
}

//Function Number: 12
lightningthink(param_00,param_01)
{
	level endon("rain_change");
	var_02 = gettime() + rainlevelwait() + rainlevelrandomwait() * 1000;
	if(var_02 < level.nextlightning)
	{
		level.nextlightning = var_02;
	}

	for(;;)
	{
		common_scripts\utility::flag_wait("_weather_lightning_enabled");
		var_03 = level.nextlightning - gettime() * 0.001;
		if(var_03 > 0)
		{
			wait(var_03);
		}

		if(!common_scripts\utility::flag("_weather_lightning_enabled"))
		{
			continue;
		}

		lightningflash(param_00,param_01);
		level.nextlightning = gettime() + rainlevelwait() + rainlevelrandomwait() * 1000;
	}
}

//Function Number: 13
fogflash(param_00)
{
	if(isdefined(level.lightningexploderindex))
	{
		common_scripts\_exploder::exploder(level.lightningexploder[level.lightningexploderindex]);
	}

	[[ param_00 ]]();
}

//Function Number: 14
lightningflash(param_00,param_01,param_02)
{
	var_03[0] = "quick";
	var_03[1] = "double";
	var_03[2] = "triple";
	thread thunder();
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
			break;

		case "double":
			break;

		case "triple":
			break;
	}
}

//Function Number: 15
thunder()
{
	if(level.rainlevel == 0)
	{
		wait(6 + randomfloat(2));
	}
	else if(level.rainlevel == 1)
	{
		wait(5 + randomfloat(1.8));
	}
	else if(level.rainlevel == 2)
	{
		wait(4.5 + randomfloat(1.6));
	}
	else if(level.rainlevel == 3)
	{
		wait(4 + randomfloat(1.6));
	}
	else if(level.rainlevel == 4)
	{
		wait(3.5 + randomfloat(1.5));
	}
	else if(level.rainlevel == 5)
	{
		wait(3 + randomfloat(1.5));
	}
	else if(level.rainlevel == 6)
	{
		wait(2.5 + randomfloat(1.2));
	}
	else if(level.rainlevel == 7)
	{
		wait(2 + randomfloat(1));
	}
	else if(level.rainlevel == 8)
	{
		wait(1.9 + randomfloat(0.5));
	}
	else if(level.rainlevel == 9)
	{
		wait(1.5);
	}
	else if(level.rainlevel == 10)
	{
		wait(1);
	}

	var_00 = spawn("script_origin",(0,0,0));
	var_00.origin = level.player.origin + (0,0,80);
	var_00 linkto(level.player);
	if(level.rainlevel <= 8)
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