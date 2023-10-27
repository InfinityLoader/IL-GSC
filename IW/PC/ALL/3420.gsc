/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3420.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 4 ms
 * Timestamp: 10/27/2023 12:27:11 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_1636 = [];
	level.var_1636["disco"] = 0;
	level.var_1636["beam"] = 0;
	level.var_1636["blackhole"] = 0;
	level.var_1636["rocket"] = 0;
	var_00 = getent("pap_room_mini_ufo_trigger","targetname");
	var_01 = scripts\common\utility::getstructarray("pap_room_mini_ufos","targetname");
	var_00.var_B7BF = [];
	level thread func_136DA(var_00);
	var_02 = scripts\common\utility::array_randomize(["yellow","blue","green","red"]);
	foreach(var_05, var_04 in var_01)
	{
		level thread func_B788(var_04,var_00,var_02[var_05]);
		wait(0.05);
	}

	scripts\common\utility::flag_init("mini_ufo_blue_ready");
	scripts\common\utility::flag_init("mini_ufo_red_ready");
	scripts\common\utility::flag_init("mini_ufo_yellow_ready");
	scripts\common\utility::flag_init("mini_ufo_green_ready");
	scripts\common\utility::flag_init("mini_ufo_blue_collecting");
	scripts\common\utility::flag_init("mini_ufo_red_collecting");
	scripts\common\utility::flag_init("mini_ufo_yellow_collecting");
	scripts\common\utility::flag_init("mini_ufo_green_collecting");
}

//Function Number: 2
func_B788(param_00,param_01,param_02)
{
	var_03 = spawn("script_model",param_00.origin);
	if(isdefined(param_00.angles))
	{
		var_03.angles = param_00.angles;
	}

	var_03 setmodel("park_ufo_statue_toy");
	param_01.var_B7BF[param_01.var_B7BF.size] = var_03;
	var_03.var_5FDF = param_02;
	var_03.color = strtok(param_02,"_")[0];
	var_03.var_C94F = [];
	switch(param_02)
	{
		case "blue":
			level.var_E5CE = var_03;
			break;

		case "green":
			level.var_562C = var_03;
			break;

		case "yellow":
			level.var_10F72 = var_03;
			break;

		case "red":
			level.var_3F2A = var_03;
			break;

		default:
			break;
	}

	level thread func_7FB5(param_00,var_03);
}

//Function Number: 3
func_7FB5(param_00,param_01)
{
	param_01.var_10DB8 = param_00;
	var_02 = param_00;
	var_03 = undefined;
	var_04 = undefined;
	for(;;)
	{
		if(isdefined(var_03))
		{
			var_04 = var_03;
			var_03 = undefined;
		}
		else if(isdefined(var_02.target))
		{
			var_05 = scripts\common\utility::getstructarray(var_02.target,"targetname");
			if(var_05.size > 1)
			{
				foreach(var_07 in var_05)
				{
					if(isdefined(var_07.script_noteworthy) && var_07.script_noteworthy == param_01.color)
					{
						var_04 = var_07;
						break;
					}
				}
			}
			else
			{
				var_04 = var_05[0];
			}
		}
		else
		{
			break;
		}

		if(scripts\common\utility::func_2286(param_01.var_C94F,var_04))
		{
			break;
		}

		param_01.var_C94F[param_01.var_C94F.size] = var_04;
		if(isdefined(var_04.script_noteworthy) && var_04.script_noteworthy == "mini_ufo_teleport_to_center")
		{
			var_03 = scripts\common\utility::getstruct("mini_ufo_center_struct","targetname");
		}

		var_02 = var_04;
	}
}

//Function Number: 4
func_136DA(param_00)
{
	if(scripts\cp\_utility::is_codxp())
	{
		return;
	}

	param_00 waittill("trigger",var_01);
	var_02 = 0;
	foreach(var_04 in param_00.var_B7BF)
	{
		level thread func_1091A(var_04);
		var_02++;
		wait(randomfloatrange(0.25,1));
	}
}

//Function Number: 5
func_56F6(param_00)
{
	level endon("game_ended");
	self endon("death");
	scripts\common\utility::flag_wait("mini_ufo_" + param_00 + "_ready");
	if(!scripts\common\utility::istrue(self.var_CF2E))
	{
		self.var_CF2E = 0;
	}

	while(scripts\common\utility::flag("mini_ufo_" + param_00 + "_ready"))
	{
		var_01 = scripts\common\utility::func_782F(self.origin,level.players,undefined,10,1000);
		foreach(var_03 in var_01)
		{
			if(sighttracepassed(self.origin,var_03 geteye(),0,self))
			{
				if(!scripts\cp\_utility::func_13C90(var_03 getcurrentweapon(),"arcane_base") && !self.var_CF2E)
				{
					var_03 thread scripts\cp\_vo::try_to_play_vo("quest_arcane_nocore_start","zmb_comment_vo");
					self.var_CF2E = 1;
					continue;
				}
				else
				{
					var_03 thread scripts\cp\_vo::try_to_play_vo("quest_arcane_ufo_question","zmb_comment_vo");
					self.var_CF2E = 1;
					continue;
				}
			}
		}

		wait(randomfloatrange(10,30));
	}
}

//Function Number: 6
func_1091A(param_00,param_01)
{
	param_00 setmodel("tag_origin_mini_ufo");
	param_01 = param_00.var_5FDF;
	param_00 setscriptablepartstate("miniufo",param_01);
	thread func_12E41(param_00,param_01);
	var_02 = param_00.var_10DB8;
	var_03 = func_7B1B(param_00,var_02,param_01);
	var_04 = 300;
	param_00 thread func_56F6(param_01);
	for(;;)
	{
		if(scripts\common\utility::flag("mini_ufo_" + param_01 + "_collecting"))
		{
			scripts\common\utility::func_6E5A("mini_ufo_" + param_01 + "_collecting");
			param_00 setscriptablepartstate("miniufo","mini_ufo");
		}

		if(scripts\common\utility::flag("mini_ufo_" + param_01 + "_ready"))
		{
			var_04 = 150;
		}
		else if(isdefined(var_02.var_EEBE))
		{
			var_04 = var_02.var_EEBE;
		}

		var_05 = var_03;
		var_05 = func_7B1B(param_00,var_05,param_01);
		if(isdefined(var_02.script_noteworthy) && var_02.script_noteworthy == "mini_ufo_teleport_to_center")
		{
			param_00 dontinterpolate();
			param_00.origin = var_03.origin;
			param_00.angles = var_03.angles;
			wait(0.05);
		}
		else
		{
			var_06 = func_7AF8(param_00,var_02.origin,var_03.origin,var_04);
			thread func_3C51(param_00,var_06,var_05,var_02,var_03);
			param_00 moveto(var_03.origin,var_06);
			param_00 waittill("movedone");
			if(isdefined(var_03.script_noteworthy) && var_03.script_noteworthy == "mini_ufo_ready")
			{
				var_04 = 150;
				scripts\common\utility::flag_set("mini_ufo_" + param_01 + "_ready");
				param_00 setscriptablepartstate("miniufo","mini_ufo");
			}
		}

		var_02 = var_03;
		var_03 = var_05;
	}
}

//Function Number: 7
func_12E41(param_00,param_01)
{
	for(;;)
	{
		if(scripts\common\utility::flag("mini_ufo_" + param_01 + "_collecting"))
		{
			scripts\common\utility::func_6E5A("mini_ufo_" + param_01 + "_collecting");
		}

		param_00 waittill("next_position_found",var_02,var_03);
		var_04 = vectortoangles(var_03.origin - var_02.origin) + (180,0,0);
		param_00 rotateto(var_04,0.5,0.05,0.05);
	}
}

//Function Number: 8
func_3C51(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_02.script_noteworthy) && param_02.script_noteworthy == "mini_ufo_teleport_to_center")
	{
		wait(param_01 + 0.1);
	}
	else
	{
		wait(max(0.05,param_01 - 0.35));
	}

	param_00 notify("next_position_found",param_04,param_02);
}

//Function Number: 9
func_7B1B(param_00,param_01,param_02)
{
	var_03 = scripts\common\utility::getstructarray(param_01.target,"targetname");
	var_04 = [];
	var_05 = undefined;
	foreach(var_07 in var_03)
	{
		if(isdefined(var_07.script_noteworthy) && var_07.script_noteworthy == param_02)
		{
			var_05 = var_07;
			break;
		}
		else
		{
			var_05 = scripts\common\utility::random(var_03);
		}
	}

	return var_05;
}

//Function Number: 10
func_10DEC(param_00,param_01,param_02)
{
	var_03 = param_01;
	var_04 = 0.5;
	if(param_01 > 0.3)
	{
		var_03 = param_01 - 0.25;
		var_04 = min(max(var_03 / 10,0.5),param_01);
	}

	wait(var_03);
	param_00 rotateto(param_02,var_04,0.05,0.05);
}

//Function Number: 11
func_7AF8(param_00,param_01,param_02,param_03)
{
	var_04 = distance(param_01,param_02);
	var_05 = var_04 / param_03;
	if(var_05 < 0.05)
	{
		var_05 = 0.05;
	}

	return var_05;
}