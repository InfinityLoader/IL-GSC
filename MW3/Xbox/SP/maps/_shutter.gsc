/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_shutter.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 12
 * Decompile Time: 191 ms
 * Timestamp: 10/27/2023 2:35:24 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(!isdefined(level.windstrength))
	{
		level.windstrength = 0.2;
	}

	level.animrate["awning"] = 1;
	level.animrate["palm"] = 1;
	level.var_1961 = level.windstrength - 0.5;
	level.animweightmax = level.windstrength + 0.2;
	if(level.var_1961 < 0.1)
	{
		level.var_1961 = 0.1;
	}

	if(level.animweightmax > 1)
	{
		level.animweightmax = 1;
	}

	level.inc = 0;
	func_196F();
	palmtree_anims();
	thread new_style_shutters();
	common_scripts\utility::array_levelthread(getentarray("wire","targetname"),::wirewander);
	common_scripts\utility::array_levelthread(getentarray("awning","targetname"),::awningwander);
	common_scripts\utility::array_levelthread(getentarray("palm","targetname"),::func_1972);
	var_00 = [];
	var_01 = getentarray("shutter_left","targetname");
	var_00 = common_scripts\utility::array_combine(var_00,var_01);
	var_01 = getentarray("shutter_right_open","targetname");
	var_00 = common_scripts\utility::array_combine(var_00,var_01);
	var_01 = getentarray("shutter_left_closed","targetname");
	var_00 = common_scripts\utility::array_combine(var_00,var_01);
	foreach(var_03 in var_00)
	{
		var_03 addyaw(180);
	}

	var_05 = [];
	var_01 = getentarray("shutter_right","targetname");
	var_05 = common_scripts\utility::array_combine(var_05,var_01);
	var_01 = getentarray("shutter_left_open","targetname");
	var_05 = common_scripts\utility::array_combine(var_05,var_01);
	var_01 = getentarray("shutter_right_closed","targetname");
	var_05 = common_scripts\utility::array_combine(var_05,var_01);
	wait 0.05;
	var_01 = common_scripts\utility::array_combine(var_00,var_05);
	foreach(var_03 in var_01)
	{
		var_03 thread shuttersound();
		var_03.startyaw = var_03.angles[1];
	}

	var_01 = undefined;
	var_08 = "left";
	level endon("stop_shutters");
	for(;;)
	{
		common_scripts\utility::array_levelthread(var_00,::func_196B,var_08);
		common_scripts\utility::array_levelthread(var_05,::shutterwanderright,var_08);
		level waittill("wind blows",var_08);
	}
}

//Function Number: 2
windcontroller()
{
	for(;;)
	{
		var_00 = "left";
		if(randomint(100) > 50)
		{
			var_00 = "right";
		}

		level notify("wind blows",var_00);
		wait 2 + randomfloat(10);
	}
}

//Function Number: 3
new_style_shutters()
{
	var_00 = getentarray("shutter","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = getent(var_02.target,"targetname");
		var_04 = spawn("script_origin",var_02.origin);
		var_04.angles = var_03.angles;
		var_04.startyaw = var_04.angles[1];
		var_02.pivot = var_04;
		var_02 linkto(var_04);
		var_04 addyaw(randomfloatrange(-90,90));
		var_02 thread shuttersound();
	}

	level endon("stop_shutters");
	var_06 = "left";
	for(;;)
	{
		common_scripts\utility::array_levelthread(var_00,::shutterwander,var_06);
		level waittill("wind blows",var_06);
	}
}

//Function Number: 4
shutterwander(param_00,param_01)
{
	level endon("stop_shutters");
	level endon("wind blows");
	var_02 = param_00.pivot;
	var_03 = randomint(3) + 1;
	var_04 = 1;
	if(common_scripts\utility::cointoss())
	{
		var_04 = var_04 * -1;
	}

	var_05 = 80;
	var_06 = 80;
	if(isdefined(param_00.var_1969))
	{
		var_06 = param_00.var_1969;
	}

	if(isdefined(param_00.var_196A))
	{
		var_05 = param_00.var_196A;
	}

	for(;;)
	{
		param_00 notify("shutterSound");
		var_07 = randomintrange(50,80);
		var_03--;
		if(!var_03)
		{
			var_03 = randomint(3) + 1;
			var_04 = var_04 * -1;
		}

		var_07 = var_07 * var_04;
		if(var_04 > 0)
		{
			if(var_07 > var_05)
			{
				var_07 = var_05;
			}
		}
		else if(var_07 > var_06)
		{
			var_07 = var_06;
		}

		var_08 = var_02.startyaw + var_07;
		var_09 = abs(var_02.angles[1] - var_08);
		var_0A = var_09 * 0.05 + randomfloat(1) + 0.25;
		if(var_0A < 0.25)
		{
			var_0A = 0.25;
		}

		var_02 rotateto((0,var_08,0),var_0A,var_0A * 0.5,var_0A * 0.5);
		wait var_0A;
	}
}

//Function Number: 5
func_196B(param_00,param_01)
{
	level endon("stop_shutters");
	level.inc++;
	level endon("wind blows");
	var_02 = param_00.startyaw;
	if(param_01 == "left")
	{
		var_02 = var_02 + 179.9;
	}

	var_03 = 0.2;
	param_00 rotateto((param_00.angles[0],var_02,param_00.angles[2]),var_03);
	wait var_03 + 0.1;
	for(;;)
	{
		param_00 notify("shutterSound");
		var_04 = randomint(80);
		if(common_scripts\utility::cointoss())
		{
			var_04 = var_04 * -1;
		}

		var_02 = param_00.angles[1] + var_04;
		var_05 = param_00.angles[1] + var_04 * -1;
		if(var_02 < param_00.startyaw || var_02 > param_00.startyaw + 179)
		{
			var_02 = var_05;
		}

		var_06 = abs(param_00.angles[1] - var_02);
		var_03 = var_06 * 0.02 + randomfloat(2);
		if(var_03 < 0.3)
		{
			var_03 = 0.3;
		}

		param_00 rotateto((param_00.angles[0],var_02,param_00.angles[2]),var_03,var_03 * 0.5,var_03 * 0.5);
		wait var_03;
	}
}

//Function Number: 6
shutterwanderright(param_00,param_01)
{
	level endon("stop_shutters");
	level.inc++;
	level endon("wind blows");
	var_02 = param_00.startyaw;
	if(param_01 == "left")
	{
		var_02 = var_02 + 179.9;
	}

	var_03 = 0.2;
	param_00 rotateto((param_00.angles[0],var_02,param_00.angles[2]),var_03);
	wait var_03 + 0.1;
	for(;;)
	{
		param_00 notify("shutterSound");
		var_04 = randomint(80);
		if(randomint(100) > 50)
		{
			var_04 = var_04 * -1;
		}

		var_02 = param_00.angles[1] + var_04;
		var_05 = param_00.angles[1] + var_04 * -1;
		if(var_02 < param_00.startyaw || var_02 > param_00.startyaw + 179)
		{
			var_02 = var_05;
		}

		var_06 = abs(param_00.angles[1] - var_02);
		var_03 = var_06 * 0.02 + randomfloat(2);
		if(var_03 < 0.3)
		{
			var_03 = 0.3;
		}

		param_00 rotateto((param_00.angles[0],var_02,param_00.angles[2]),var_03,var_03 * 0.5,var_03 * 0.5);
		wait var_03;
	}
}

//Function Number: 7
shuttersound()
{
	for(;;)
	{
		self waittill("shutterSound");
		self waittill("sounddone");
		wait randomfloat(2);
	}
}

//Function Number: 8
wirewander(param_00)
{
	var_01 = getentarray(param_00.target,"targetname");
	var_02 = var_01[0].origin;
	var_03 = var_01[1].origin;
	var_04 = vectortoangles(var_02 - var_03);
	var_05 = spawn("script_model",(0,0,0));
	var_05.origin = var_02 * 0.5 + var_03 * 0.5;
	var_05.angles = var_04;
	param_00 linkto(var_05);
	var_06 = 2;
	var_07 = 0.9;
	var_08 = 4 + randomfloat(2);
	var_05 rotateroll(var_08 * 0.5,0.2);
	wait 0.2;
	for(;;)
	{
		var_09 = var_06 + randomfloat(var_07) - var_07 * 0.5;
		var_05 rotateroll(var_08,var_09,var_09 * 0.5,var_09 * 0.5);
		wait var_09;
		var_05 rotateroll(var_08 * -1,var_09,var_09 * 0.5,var_09 * 0.5);
		wait var_09;
	}
}

//Function Number: 9
func_196F()
{
}

//Function Number: 10
awningwander(param_00)
{
}

//Function Number: 11
palmtree_anims()
{
}

//Function Number: 12
func_1972(param_00)
{
	param_00 useanimtree(#animtree);
	switch(param_00.model)
	{
		case "tree_desertpalm01":
			param_00.animname = "ree_desertpalm01";
			break;

		case "tree_desertpalm02":
			param_00.animname = "tree_desertpalm02";
			break;

		case "tree_desertpalm03":
			param_00.animname = "tree_desertpalm03";
			break;
	}

	if(!isdefined(param_00.animname))
	{
		return;
	}

	wait randomfloat(2);
	for(;;)
	{
		var_01 = level.var_1961 + randomfloat(level.animweightmax - level.var_1961);
		var_02 = 4;
		param_00 setanim(level.scr_anim[param_00.animname]["wind"][0],var_01,var_02,level.animrate["palm"]);
		param_00 setanim(level.scr_anim[param_00.animname]["wind"][1],1 - var_01,var_02,level.animrate["palm"]);
		wait 1 + randomfloat(3);
	}
}