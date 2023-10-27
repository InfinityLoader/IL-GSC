/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_hub_top_player.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 121 ms
 * Timestamp: 10/27/2023 3:23:30 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	level.var_9A9B = spawnstruct();
	level.var_9A9B.var_3F48 = loadfx("vfx/unique/hub_top_player_loop");
	level.var_9A9B.var_3F52 = loadfx("vfx/unique/hub_top_player_spawn");
	level.var_9A9B.var_5022 = ["headicon_1st_place","headicon_2nd_place","headicon_3rd_place"];
	thread func_6B6C();
	thread func_A17F();
}

//Function Number: 2
func_6B6C()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_9A99();
	}
}

//Function Number: 3
func_9A99()
{
	self endon("disconnect");
	level endon("game_ended");
	wait(60);
	self.var_56D6 = 1;
}

//Function Number: 4
func_A17F()
{
	level endon("game_ended");
	for(;;)
	{
		wait(30);
		func_A17E();
	}
}

//Function Number: 5
func_A17E()
{
	level endon("game_ended");
	level.var_9A9B.var_7420 = common_scripts\utility::func_FA5(level.var_744A,::func_255A);
	func_A17D();
}

//Function Number: 6
func_A17D()
{
	for(var_00 = 0;var_00 < 3;var_00++)
	{
		if(!isdefined(level.var_9A9B.var_7420[var_00]))
		{
			break;
		}

		var_01 = level.var_9A9B.var_7420[var_00];
		if(isdefined(var_01.var_9A9A))
		{
			if(var_01.var_9A9C == var_00 + 1)
			{
				continue;
			}

			var_01.var_9A9A destroy();
		}

		var_02 = newhudelem();
		var_02 setshader(level.var_9A9B.var_5022[var_00]);
		var_02.maxsightdistsqrd = var_01.var_116[0];
		var_02.var_1D7 = var_01.var_116[1];
		var_02.var_1D9 = var_01.var_116[2] + 90;
		var_02 setwaypoint(1,0,0);
		var_02 settargetent(var_01);
		var_02.var_6E74 = level.var_A012;
		var_02.var_6E74 maps\mp\gametypes\_hud_util::func_9A6(var_02);
		var_02.var_109 = "topPlayerElem";
		var_01.var_9A9A = var_02;
		var_01.var_9A9C = var_00 + 1;
		if(var_00 == 0)
		{
			foreach(var_04 in level.var_744A)
			{
				var_04 iclientprintln(var_01.var_109 + " is the new top player with a K/D of " + var_01.var_1FF4);
			}
		}
	}

	for(var_00 = 3;var_00 < level.var_744A.size;var_00++)
	{
		if(isdefined(level.var_9A9B.var_7420[var_00].var_9A9A))
		{
			level.var_9A9B.var_7420[var_00].var_9A9A destroy();
			level.var_9A9B.var_7420[var_00].var_9A9C = -1;
		}
	}
}

//Function Number: 7
func_255A(param_00,param_01)
{
	return !isdefined(param_01) || !isdefined(param_01.var_56D6) || isdefined(param_00) && param_00.var_1FF4 > param_01.var_1FF4 && isdefined(param_00.var_56D6);
}

//Function Number: 8
func_1E53()
{
	var_00 = self getrankedplayerdata(common_scripts\utility::func_46AE(),"kills");
	var_01 = self getrankedplayerdata(common_scripts\utility::func_46AE(),"deaths");
	if(!isdefined(var_00))
	{
		var_00 = 0;
	}

	if(!isdefined(var_01))
	{
		var_01 = 1;
	}

	if(var_01 == 0)
	{
		var_01 = 1;
	}

	self.var_1FF4 = var_00 / var_01;
}