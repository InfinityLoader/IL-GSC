/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3341.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 3 ms
 * Timestamp: 10/27/2023 12:26:35 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["slam_sml"] = loadfx("vfx/old/_requests/archetypes/vfx_heavy_slam_s");
	level._effect["slam_lrg"] = loadfx("vfx/old/_requests/archetypes/vfx_heavy_slam_l");
}

//Function Number: 2
func_83A4(param_00)
{
	thread func_102C9(param_00);
}

//Function Number: 3
func_E16C(param_00)
{
	param_00 notify("removeSlam");
}

//Function Number: 4
func_102C9(param_00)
{
	if(isbot(param_00))
	{
		return;
	}

	param_00 endon("removeSlam");
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00 notifyonplayercommand("slamButtonPressed","+stance");
	for(;;)
	{
		param_00 waittill("slamButtonPressed");
		if(!func_102CB(param_00))
		{
			continue;
		}

		var_01 = func_102C5(param_00);
		func_102C7(param_00,var_01);
	}
}

//Function Number: 5
func_102CB(param_00)
{
	return param_00 isonground() == 0 && param_00 getstance() != "prone";
}

//Function Number: 6
func_102C5(param_00)
{
	var_01 = anglestoright(param_00.angles);
	var_02 = rotatepointaroundvector(var_01,(0,0,-1),45);
	var_03 = param_00.origin + var_02 * 600;
	return param_00 method_8007(param_00.origin,var_03,16,80,1,0);
}

//Function Number: 7
func_102C7(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		var_03 = lengthsquared(param_00.origin - param_01);
		if(var_03 < 576)
		{
			return;
		}

		if(var_03 > squared(600))
		{
			return;
		}
	}

	var_04 = param_00 scripts\common\utility::spawn_tag_origin();
	thread func_102C6(param_00,var_04);
	func_102C8(param_00,param_01,var_04,param_02);
	param_00 notify("slam_finished");
}

//Function Number: 8
func_102C8(param_00,param_01,param_02,param_03)
{
	var_04 = lengthsquared(param_00.origin - param_01);
	var_05 = 0;
	var_06 = 0;
	var_07 = 0;
	if(var_04 >= 28224)
	{
		var_06 = 20736;
		var_05 = 1;
	}
	else if(var_04 >= 7056)
	{
		var_06 = 5184;
		var_07 = 20736;
	}
	else
	{
		var_07 = 11664;
	}

	param_00 setstance("crouch");
	param_00 playerlinkto(param_02,"tag_origin");
	param_02 moveto(param_01,0.25,0.1,0);
	wait(0.25);
	param_00 thread scripts\cp\_weapon::func_858A(0);
	if(!isdefined(param_03))
	{
		param_00 playsound("detpack_explo_metal");
		var_08 = scripts\common\utility::func_116D7(var_05,scripts\common\utility::getfx("slam_lrg"),scripts\common\utility::getfx("slam_sml"));
		playfx(var_08,param_01);
	}
	else
	{
	}

	thread func_102CA(param_01);
	var_09 = scripts\cp\_agent_utils::func_7DB0("axis");
	foreach(var_0B in var_09)
	{
		if(!isdefined(var_0B) || var_0B == param_00 || !scripts\cp\_utility::func_9F19(var_0B))
		{
			continue;
		}

		var_0C = undefined;
		var_0D = distancesquared(param_01,var_0B.origin);
		if(var_0D <= var_06)
		{
			var_0C = 250;
		}
		else if(var_0D <= var_07)
		{
			var_0C = 100;
		}
		else
		{
			continue;
		}

		var_0B scripts\cp\_weapon::func_FC6A("MOD_EXPLOSIVE",var_0C);
		if(var_0C >= var_0B.health)
		{
			var_0B.var_4C87 = 1;
		}

		var_0B dodamage(var_0C,param_01,param_00,param_00,"MOD_CRUSH");
	}

	wait(0.5);
	param_00 unlink();
	param_00 setstance("stand");
}

//Function Number: 9
func_102CA(param_00)
{
	wait(0.1);
	physicsexplosionsphere(param_00 - (0,0,60),240,140,3.5);
}

//Function Number: 10
func_102C6(param_00,param_01)
{
	param_00 scripts\common\utility::waittill_any_3("death","disconnect","slam_finished");
	scripts\common\utility::func_136F7();
	if(isdefined(param_01))
	{
		param_01 delete();
	}
}

//Function Number: 11
func_102CC(param_00,param_01)
{
	param_00 endon("disconnect");
	param_00 endon("death");
	wait(param_01);
	return 1;
}