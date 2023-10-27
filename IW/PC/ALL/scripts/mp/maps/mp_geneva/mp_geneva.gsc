/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\maps\mp_geneva\mp_geneva.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 729 ms
 * Timestamp: 10/27/2023 12:13:37 AM
*******************************************************************/

//Function Number: 1
main()
{
	lib_0FB1::main();
	scripts\mp\maps\mp_geneva\gen\mp_geneva_art::main();
	lib_0FB0::main();
	scripts\mp\_load::main();
	scripts\mp\_compass::func_FACD("compass_map_mp_geneva");
	setdvar("r_lightGridEnableTweaks",1);
	setdvar("r_lightGridIntensity",1.33);
	setdvar("r_umbraMinObjectContribution",8);
	setdvar("r_umbraAccurateOcclusionThreshold",1024);
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["allies_outfit"] = "urban";
	game["axis_outfit"] = "woodland";
	level.var_C7B3 = getentarray("OutOfBounds","targetname");
	thread apex_not_outofbounds();
	thread oceaninmotion();
	thread setup_vista_driving_boats();
	thread func_F9BA();
	thread fix_collision();
}

//Function Number: 2
fix_collision()
{
	var_00 = getent("player128x128x256","targetname");
	var_01 = spawn("script_model",(-560,-2752,384));
	var_01.angles = (0,0,0);
	var_01 clonebrushmodeltoscriptmodel(var_00);
	var_02 = getent("player32x32x256","targetname");
	var_03 = spawn("script_model",(-512,-1536,464));
	var_03.angles = (0,45,0);
	var_03 clonebrushmodeltoscriptmodel(var_02);
	var_04 = spawn("script_model",(-512,-1536,720));
	var_04.angles = (0,45,0);
	var_04 clonebrushmodeltoscriptmodel(var_02);
	var_05 = spawn("script_model",(-1088,-510,0));
	var_05.angles = (0,0,0);
	var_05 setmodel("mp_geneva_wallrun_clip_brick_01");
	var_06 = getent("player32x32x8","targetname");
	var_07 = spawn("script_model",(-512,-2416,284));
	var_07.angles = (75,0,0);
	var_07 clonebrushmodeltoscriptmodel(var_06);
	var_08 = spawn("script_model",(-512,-3080,284));
	var_08.angles = (75,0,0);
	var_08 clonebrushmodeltoscriptmodel(var_06);
	var_09 = spawn("script_model",(122,1740,0));
	var_09.angles = (0,0,0);
	var_09 setmodel("mp_skyway_nosight_v1");
}

//Function Number: 3
apex_not_outofbounds()
{
	level.outofboundstriggerpatches = [];
	var_00 = getent("apex_unoutofbounds","targetname");
	level.outofboundstriggerpatches[level.outofboundstriggerpatches.size] = var_00;
	level waittill("game_ended");
	foreach(var_00 in level.outofboundstriggerpatches)
	{
		if(isdefined(var_00))
		{
			var_00 delete();
		}
	}
}

//Function Number: 4
oceaninmotion()
{
	var_00 = getentarray("bobbing_boat","targetname");
	foreach(var_02 in var_00)
	{
		thread bobbingboat(var_02);
	}
}

//Function Number: 5
bobbingboat(param_00)
{
	param_00.var_2C5 = param_00.origin;
	param_00.var_10D6C = param_00.angles;
	if(isdefined(param_00.target))
	{
		param_00.var_BE10 = getentarray(param_00.target,"targetname");
		foreach(var_02 in param_00.var_BE10)
		{
			var_02.deltapos = var_02.origin - param_00.origin;
		}
	}

	thread boatbob(param_00);
}

//Function Number: 6
boatbob(param_00)
{
	level endon("game_ended");
	for(;;)
	{
		var_01 = randomfloatrange(4,7);
		param_00.var_15B = param_00.var_2C5 + (randomintrange(-2,2),randomintrange(-2,2),randomintrange(-3,3));
		param_00 moveto(param_00.var_15B,var_01,var_01 * 0.25,var_01 * 0.25);
		if(isdefined(param_00.target))
		{
			foreach(var_03 in param_00.var_BE10)
			{
				var_03.var_15B = param_00.var_15B + var_03.deltapos;
				var_03 moveto(var_03.var_15B,var_01,var_01 * 0.25,var_01 * 0.25);
			}
		}

		wait(var_01);
	}
}

//Function Number: 7
setup_vista_driving_boats()
{
	var_00 = getentarray("boat_vista","targetname");
	var_01 = 0.01;
	var_02 = 0.01666667;
	wait(5);
	foreach(var_04 in var_00)
	{
		if(isdefined(var_04.script_label))
		{
			thread vista_boat_drive(var_04,var_02);
			playfxontag(scripts\common\utility::getfx("vfx_gn_bg_sail_boat_wake"),var_04,"tag_origin");
			continue;
		}

		thread vista_boat_drive(var_04,var_01);
		playfxontag(scripts\common\utility::getfx("vfx_gn_bg_boat_wake_rear"),var_04,"tag_origin");
	}
}

//Function Number: 8
vista_boat_drive(param_00,param_01)
{
	level endon("game_ended");
	var_02 = scripts\common\utility::getstruct(param_00.target,"targetname");
	for(;;)
	{
		var_03 = abs(distance(param_00.origin,var_02.origin) * param_01);
		param_00 moveto(var_02.origin,var_03,0,0);
		param_00 rotateto(var_02.angles,var_03,0,0);
		var_02 = scripts\common\utility::getstruct(var_02.target,"targetname");
		wait(var_03);
	}
}

//Function Number: 9
func_F9BA()
{
	level.var_A582 = 600;
	level.var_A583 = 1200;
	level.var_BF47 = -1;
	var_00 = getentarray("wine_keg","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread func_13957();
	}
}

//Function Number: 10
func_13957()
{
	self setcandamage(1);
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04);
		if(!issubstr(var_04,"BULLET"))
		{
			continue;
		}

		if(!func_3827())
		{
			continue;
		}

		var_05 = func_7A63(var_01,var_02,var_03);
		if(!isdefined(var_05))
		{
			continue;
		}

		func_B27C();
		var_05 = vectortoangles(var_05);
		playfx(level._effect["vfx_gn_imp_wine_cask"],var_03,anglestoforward(var_05),anglestoup(var_05));
		playfx(level._effect["vfx_gn_wine_barrel_stream"],var_03,anglestoforward(var_05),anglestoup(var_05));
	}
}

//Function Number: 11
func_7A63(param_00,param_01,param_02)
{
	var_03 = param_00.origin;
	var_04 = param_02 - var_03;
	var_05 = bullettrace(var_03,var_03 + 1.5 * var_04,0,param_00,0);
	if(isdefined(var_05["normal"]) && isdefined(var_05["entity"]) && var_05["entity"] == self)
	{
		return var_05["normal"];
	}

	return undefined;
}

//Function Number: 12
func_3827()
{
	if(gettime() < level.var_BF47)
	{
		return 0;
	}

	return 1;
}

//Function Number: 13
func_B27C()
{
	level.var_BF47 = gettime() + randomfloatrange(level.var_A582,level.var_A583);
}