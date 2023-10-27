/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_raid_tesla_gun_moon.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 244 ms
 * Timestamp: 10/27/2023 3:10:35 AM
*******************************************************************/

//Function Number: 1
func_6402()
{
	common_scripts\utility::func_92C("moon_plasma","vfx/trail/zmb_tesla_moon_trail");
	common_scripts\utility::func_92C("tesla_moon_explosion","vfx/explosion/zmb_tesla_moon_body_gib");
	common_scripts\utility::func_92C("moon_plasma_unstable","vfx/trail/zmb_tesla_moon_trail_unstable");
	common_scripts\utility::func_92C("tesla_moon_ambience","vfx/zombie/tesla_guns/zmb_npc_tesla_tube_moon_idle");
	maps/mp/gametypes/_raid_tesla_gun::func_98FA("teslagun_war_moon_mp",::func_433D,::func_433F,::func_4210,::func_63FF);
	level.var_5A61["raid_tesla_moon"] = ::tryuseteslamoon;
	level.var_5A7D["teslagun_war_moon_mp"] = "raid_tesla_moon";
}

//Function Number: 2
tryuseteslamoon(param_00)
{
	var_01 = tryuseteslamooninternal();
	return var_01;
}

//Function Number: 3
tryuseteslamooninternal()
{
	if(maps\mp\_utility::func_57A0(self))
	{
		maps\mp\_matchdata::func_5E9A("raid_tesla_moon",self.var_116);
		return 1;
	}

	return 0;
}

//Function Number: 4
killstreak_init()
{
	level.var_5A7D["teslagun_war_moon_mp"] = "raid_tesla_moon";
}

//Function Number: 5
func_63FF()
{
	var_00 = self;
	var_00 endon("death");
	var_01 = func_4344();
	var_02 = distance(var_00.var_116,var_00.var_2DA7);
	var_03 = var_02 / var_01;
	if(var_03 > 0)
	{
		var_00 moveto(var_00.var_2DA7,var_03,0,0);
	}

	var_00 childthread func_AAED();
	playfxontag(common_scripts\utility::func_44F5("moon_plasma"),var_00,"tag_origin");
	var_00 lib_0378::func_8D74("aud_moon_projectile_strt");
	wait(var_03);
	var_00 notify("moon_travel_end");
	var_00 lib_0378::func_8D74("aud_moon_projectile_end");
	wait(func_4319());
	var_04 = func_40AA() / 2;
	playfx(common_scripts\utility::func_44F5("tesla_moon_explosion"),var_00.var_116);
	var_00 delete();
}

//Function Number: 6
func_AAED()
{
	var_00 = self;
	var_00 endon("moon_travel_end");
	for(;;)
	{
		var_01 = maps/mp/gametypes/_raid_tesla_gun::get_all_enemies(var_00.var_721C);
		var_02 = func_43EC();
		var_03 = common_scripts\utility::func_4461(var_00.var_116,var_01,var_02);
		if(isdefined(var_03))
		{
			playfx(common_scripts\utility::func_44F5("tesla_moon_explosion"),var_03.var_116 + (0,0,54));
			playfxontag(common_scripts\utility::func_44F5("moon_plasma_unstable"),var_00,"tag_origin");
			var_03 lib_0378::func_8D74("aud_ww_projectile_zap");
			wait 0.05;
			maps/mp/gametypes/_raid_tesla_gun::func_98E9(var_03.var_116,func_40AA(),var_00.var_721C,undefined,var_00.var_953E,(0.1882353,0.2352941,0.454902));
		}

		wait(max(0.05,func_4319()));
	}
}

//Function Number: 7
func_63FC(param_00)
{
	var_01 = self;
	playfx(common_scripts\utility::func_44F5("tesla_moon_explosion"),param_00.var_116 + (0,0,54));
	playfxontag(common_scripts\utility::func_44F5("moon_plasma_unstable"),var_01,"tag_origin");
	param_00 lib_0378::func_8D74("aud_ww_projectile_zap");
	wait 0.05;
	var_02 = 200;
	maps/mp/gametypes/_raid_tesla_gun::func_98E9(param_00.var_116,func_40AA(),var_01.var_721C,undefined,var_01.var_953E,(0.1882353,0.2352941,0.454902),var_02);
}

//Function Number: 8
func_4319()
{
	var_00 = func_4217();
	var_01 = func_4344();
	var_02 = var_00 / max(1,var_01);
	return var_02;
}

//Function Number: 9
func_43EC()
{
	return 50;
}

//Function Number: 10
func_4210()
{
	return 1000;
}

//Function Number: 11
func_4217()
{
	return 100;
}

//Function Number: 12
func_433D()
{
	return 45;
}

//Function Number: 13
func_433F()
{
	return -8;
}

//Function Number: 14
func_4344()
{
	return 350;
}

//Function Number: 15
func_40AA()
{
	return 120;
}