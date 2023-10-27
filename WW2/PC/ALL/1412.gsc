/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1412.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 3:26:05 AM
*******************************************************************/

//Function Number: 1
func_9434()
{
	common_scripts\utility::func_92C("storm_plasma_stable","vfx/trail/zmb_tesla_storm_trail");
	common_scripts\utility::func_92C("storm_plasma_unstable","vfx/trail/zmb_tesla_storm_trail_unstable");
	common_scripts\utility::func_92C("head_sparks","vfx/explosion/zmb_tesla_storm_body_gib");
	common_scripts\utility::func_92C("tesla_storm_ambience","vfx/zombie/tesla_guns/zmb_npc_tesla_tube_storm_idle");
	lib_0580::func_98FA("teslagun_zm_storm",::func_433D,::func_433F,::func_4210,::func_9431);
}

//Function Number: 2
func_4134()
{
	var_00 = self;
	var_01 = func_43EB();
	var_02 = var_00.var_116 - (0,0,var_01 * 0.5);
	return var_02;
}

//Function Number: 3
func_AAED()
{
	var_00 = self;
	var_00 endon("death");
	var_01 = "tag_origin";
	for(;;)
	{
		wait(func_4218());
		var_02 = lib_0547::func_43F0(var_00 func_4134(),func_43EB(),func_43EC(),0);
		if(!var_02.size)
		{
			continue;
		}

		var_03 = var_02[randomint(var_02.size)];
		var_04 = "j_head";
		playfxontag(common_scripts\utility::func_44F5("storm_plasma_unstable"),var_00,"tag_origin");
		var_00 lib_0378::func_8D74("aud_ww_projectile_zap");
		physicsexplosioncylinder(var_00.var_116,func_43EC(),0,1);
		var_00 lib_0580::func_98F7(var_03);
		var_00 lib_0580::func_98F8(var_03,"head_sparks");
		var_00 func_9430();
		var_00 notify("scr_storm_slow_speed");
	}
}

//Function Number: 4
func_9430()
{
	var_00 = self;
	var_01 = func_4345();
	var_02 = distance(var_00.var_116,var_00.var_2DA7);
	var_03 = var_02 / var_01;
	var_04 = func_405C();
	if(var_04 > var_03)
	{
		var_04 = var_03;
	}

	if(var_03 > 0)
	{
		var_00 moveto(var_00.var_2DA7,var_03,var_04,0);
	}

	var_00.var_2A92 = lib_0580::func_4385() + var_03;
}

//Function Number: 5
func_9435()
{
	var_00 = self;
	for(;;)
	{
		var_01 = lib_0580::func_4385();
		if(var_00.var_2A92 <= var_01)
		{
			break;
		}

		var_02 = var_00.var_2A92 - var_01;
		var_00.var_2A92 = var_00.var_2A92 - var_02;
		wait(var_02);
	}

	lib_0580::func_98E9(var_00.var_116,func_43EC(),var_00.var_721C,undefined,var_00.var_953E,(0.1686275,0.2941177,0.4352941));
	playfxontag(common_scripts\utility::func_44F5("storm_plasma_unstable"),var_00,"tag_origin");
	var_00 lib_0378::func_8D74("aud_storm_proj_loop_end");
	if(var_00.var_9B7F < 1)
	{
		wait(func_4192());
	}

	var_00 delete();
}

//Function Number: 6
func_9431()
{
	var_00 = self;
	playfxontag(common_scripts\utility::func_44F5("storm_plasma_stable"),var_00,"tag_origin");
	var_00 lib_0378::func_8D74("aud_storm_proj_loop_strt");
	var_00 func_9430();
	var_00 thread func_AAED();
	var_00 thread func_9435();
}

//Function Number: 7
func_43EC()
{
	return 130;
}

//Function Number: 8
func_43EB()
{
	return 150;
}

//Function Number: 9
func_4210()
{
	return 1000;
}

//Function Number: 10
func_4218()
{
	return 0.45;
}

//Function Number: 11
func_433D()
{
	return 42;
}

//Function Number: 12
func_433F()
{
	return -8;
}

//Function Number: 13
func_4345()
{
	return 130;
}

//Function Number: 14
func_405C()
{
	return 1;
}

//Function Number: 15
func_4192()
{
	return 1.6;
}