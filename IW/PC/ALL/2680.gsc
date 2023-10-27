/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2680.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 1 ms
 * Timestamp: 10/27/2023 12:23:44 AM
*******************************************************************/

//Function Number: 1
func_744A(param_00,param_01)
{
	level.var_37A6 = spawn("script_model",param_00);
	level.var_37A6 setmodel("tag_origin");
	level.var_37A6.angles = param_01;
}

//Function Number: 2
func_37B1(param_00,param_01,param_02)
{
	level.var_D460 predictstreampos(param_00.origin);
	var_03 = distance(level.var_37A6.origin,param_00.origin);
	var_04 = var_03 / param_01;
	if(var_04 < 0.05)
	{
		var_04 = 0.05;
	}

	var_05 = 0;
	if(param_02)
	{
		var_05 = var_04 * 0.1;
	}

	level.var_37A6.var_BC77 = param_00;
	level.var_37A6 moveto(param_00.origin,var_04,var_05,var_05);
	level.var_37A6 rotateto(param_00.angles,var_04,var_05,var_05);
	wait(var_04);
}

//Function Number: 3
func_7449(param_00,param_01,param_02,param_03,param_04)
{
	level endon("game_ended");
	self endon("disconnect");
	if(isdefined(level.var_37A6.var_BC77))
	{
		level.var_37A6.origin = level.var_37A6.var_BC77.origin;
		level.var_37A6.angles = level.var_37A6.var_BC77.angles;
	}

	level notify("camera_move");
	level endon("camera_move");
	if(!isdefined(param_01))
	{
		param_01 = 900;
	}

	var_05 = param_00;
	if(param_02)
	{
		level.var_37A6.origin = var_05.origin;
		level.var_37A6.angles = var_05.angles;
	}
	else
	{
		func_37B1(var_05,param_01,param_03);
	}

	while(isdefined(var_05.target))
	{
		if(!isdefined(var_05.target))
		{
			return;
		}

		var_05 = getent(var_05.target,"targetname");
		func_37B1(var_05,param_01,param_03);
	}

	level.var_37A6.var_BC77 = undefined;
	if(isdefined(param_04))
	{
		self thread [[ param_04 ]]();
	}
}

//Function Number: 4
func_744B(param_00,param_01,param_02,param_03,param_04,param_05)
{
	level endon("game_ended");
	self endon("disconnect");
	level notify("camera_teleport");
	level endon("camera_teleport");
	level.var_D460 predictstreampos(param_00.origin);
	level.transition_interrupted = 1;
	frontendscenecamerafade(0,param_03);
	wait(param_03 + 0.05);
	frontendscenecamerafov(param_01,0);
	level.var_37A6 dontinterpolate();
	level.var_37A6.origin = param_00.origin;
	level.var_37A6.angles = param_00.angles;
	level.var_37A6.var_BC77 = undefined;
	if(isdefined(param_02))
	{
		frontendscenecameracinematic(param_02);
	}

	wait(0.1);
	if(isdefined(param_05))
	{
		[[ param_05 ]]();
	}

	frontendscenecamerafade(1,param_04);
	level.transition_interrupted = 0;
}

//Function Number: 5
func_744C(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	self cameralinkto(level.var_37A6,"tag_origin");
	level.var_1642 = frontendscenegetactivesection();
	[[ param_00 ]](level.var_1642);
	scripts\common\utility::func_136F7();
	for(;;)
	{
		var_01 = frontendscenegetactivesection();
		if(var_01.name == level.var_1642.name && var_01.index == level.var_1642.index)
		{
			scripts\common\utility::func_136F7();
			continue;
		}

		level.var_1642 = var_01;
		[[ param_00 ]](var_01);
	}
}