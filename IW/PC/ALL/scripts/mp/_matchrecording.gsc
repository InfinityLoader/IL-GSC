/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_matchrecording.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 22
 * Decompile Time: 871 ms
 * Timestamp: 10/27/2023 12:20:52 AM
*******************************************************************/

//Function Number: 1
init()
{
	var_00 = getdvarint("scr_match_recording",0);
	if(!func_B408(var_00))
	{
		return;
	}
	else
	{
		level.var_B406 = var_00;
	}

	level.var_B3EE = 0;
	level.var_B3EF = [];
	level.var_B3FB = ::func_B3FB;
	level.var_B3FC = ::func_B3FC;
	level.var_B3FD = ::func_B3FD;
	level.var_B3F0 = ::func_B3F0;
	level.var_B3F3 = ::func_B3F3;
	level.var_B407 = ::func_B407;
	if(level.var_B406 == 1)
	{
		func_B3F5();
	}
	else if(level.var_B406 == 3)
	{
		func_B402(1);
	}

	level thread func_B3FA();
	level thread func_B400();
	level thread func_B3FE();
}

//Function Number: 2
func_B408(param_00)
{
	var_01 = 1;
	if(param_00 == 0)
	{
		var_01 = 0;
	}
	else if(param_00 < 0 || param_00 > 4)
	{
		var_01 = 0;
	}
	else if(param_00 == 3 || param_00 == 4)
	{
		var_02 = 0;
		if(!var_02)
		{
			var_01 = 0;
		}
	}
	else if(param_00 == 1 || param_00 == 2)
	{
		var_03 = getdvarint("g_logEnable",0);
		var_01 = var_03 == 1;
	}

	return var_01;
}

//Function Number: 3
func_B3F9()
{
	return isdefined(level.var_B406) && level.var_B406 > 0;
}

//Function Number: 4
func_B405(param_00)
{
	if(isdefined(level.teambased) && !level.teambased)
	{
		var_01 = 2;
	}
	else if(!isdefined(var_01) || var_01 == "allies")
	{
		var_01 = 2;
	}
	else
	{
		var_01 = 3;
	}

	return var_01;
}

//Function Number: 5
func_B3F1(param_00)
{
	var_01 = undefined;
	switch(param_00)
	{
		case "PATH":
			var_01 = "p";
			break;

		case "SPAWN":
			var_01 = "s";
			break;

		case "DEATH":
			var_01 = "d";
			break;

		case "BULLET":
			var_01 = "b";
			break;

		case "EXPLOSION":
			var_01 = "e";
			break;

		case "ANCHOR":
			var_01 = "t";
			break;

		case "FRONT_LINE":
			var_01 = "l";
			break;

		case "FRONT_LINE_ALLIES":
			var_01 = "[";
			break;

		case "FRONT_LINE_AXIS":
			var_01 = "]";
			break;

		case "FLAG_A":
			var_01 = "A";
			break;

		case "FLAG_B":
			var_01 = "B";
			break;

		case "FLAG_C":
			var_01 = "C";
			break;

		case "SPAWN_ENTITY":
			var_01 = "S";
			break;

		case "PORTAL":
			var_01 = "O";
			break;

		case "LOG_BAD_SPAWN":
			var_01 = "!";
			break;

		case "LOG_GENERIC_MESSAGE":
			var_01 = "m";
			break;

		case "LOG_USER_EVENT":
			var_01 = "u";
			break;

		case "LOG_STAT":
			var_01 = "?";
			break;

		case "PLAYER_NAME":
			var_01 = "n";
			break;

		case "BEST_SPAWN_ALLIES":
			var_01 = "+";
			break;

		case "BEST_SPAWN_AXIS":
			var_01 = "^";
			break;

		default:
			break;
	}

	return var_01;
}

//Function Number: 6
func_B3F4()
{
	var_00 = [];
	var_00[var_00.size] = "<mrec_map> " + level.script + "\n";
	var_00[var_00.size] = "<mrec_game_type> " + level.gametype + "\n";
	var_00[var_00.size] = "<mrec_event_def> PATH p\n";
	var_00[var_00.size] = "<mrec_event_def> PATH_SPAWN s\n";
	var_00[var_00.size] = "<mrec_event_def> PATH_DEATH d\n";
	var_00[var_00.size] = "<mrec_event_def> PATH_BULLET b\n";
	var_00[var_00.size] = "<mrec_event_def> PATH_EXPLOSION e\n";
	var_00[var_00.size] = "<mrec_event_def> ANCHOR t\n";
	var_00[var_00.size] = "<mrec_event_def> GENERIC_LINE l 255,0,0,0\n";
	var_00[var_00.size] = "<mrec_event_def> GENERIC_LINE [ 255,255,127,0\n";
	var_00[var_00.size] = "<mrec_event_def> GENERIC_LINE ] 255,0,255,255\n";
	var_00[var_00.size] = "<mrec_event_def> GENERIC_IMAGE A flagA.tga flagAallies.tga flagAaxis.tga\n";
	var_00[var_00.size] = "<mrec_event_def> GENERIC_IMAGE B flagB.tga flagBallies.tga flagBaxis.tga\n";
	var_00[var_00.size] = "<mrec_event_def> GENERIC_IMAGE C flagC.tga flagCallies.tga flagCaxis.tga\n";
	var_00[var_00.size] = "<mrec_event_def> SPAWN_ENTITY S\n";
	var_00[var_00.size] = "<mrec_event_def> GENERIC_IMAGE O flagAallies.tga flagAaxis.tga\n";
	var_00[var_00.size] = "<mrec_event_def> LOG_MESSAGE ! \"No good spawns found. Using bad spawn.\" \n";
	var_00[var_00.size] = "<mrec_event_def> LOG_MESSAGE m \"MSG: \" \n";
	var_00[var_00.size] = "<mrec_event_def> LOG_MESSAGE u \"User Event From \" \n";
	var_00[var_00.size] = "<mrec_event_def> LOG_MESSAGE ? \"STAT: \" \n";
	var_00[var_00.size] = "<mrec_event_def> PLAYER_NAME n\n";
	var_00[var_00.size] = "<mrec_event_def> GENERIC_IMAGE + bestSpawnAllies.tga\n";
	var_00[var_00.size] = "<mrec_event_def> GENERIC_IMAGE ^ bestSpawnAxis.tga\n";
	return var_00;
}

//Function Number: 7
func_B3FB(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!func_B3F9())
	{
		return;
	}

	func_B3F7();
	var_09 = func_B405(param_01);
	var_0A = int(param_03) + "," + int(param_04);
	var_0B = func_B3F1(param_02);
	if(param_02 == "BULLET" || param_02 == "FRONT_LINE" || param_02 == "FRONT_LINE_ALLIES" || param_02 == "FRONT_LINE_AXIS")
	{
	}

	var_0C = "";
	if(isdefined(param_06))
	{
		var_0C = " s:" + param_06;
	}

	var_0D = "";
	if(isdefined(param_07) && isdefined(param_08))
	{
		var_0D = " " + int(param_07) + "," + int(param_08);
	}

	var_0E = "|" + param_00 + " " + var_09 + " " + var_0B + " " + var_0A + " " + param_05 + var_0D + var_0C;
	level.var_B3EF[level.var_B3EF.size - 1] = level.var_B3EF[level.var_B3EF.size - 1] + var_0E;
}

//Function Number: 8
func_B3FC(param_00,param_01,param_02)
{
	if(!func_B3F9())
	{
		return;
	}

	func_B3F7();
	var_03 = func_B3F1(param_00);
	if(param_02 != "")
	{
		if(!isdefined(param_02))
		{
			param_02 = "";
		}
		else
		{
			param_02 = " \" + param_02 + "\";
		}
	}

	var_04 = "|0 0 " + var_03 + " " + param_01 + param_02;
	level.var_B3EF[level.var_B3EF.size - 1] = level.var_B3EF[level.var_B3EF.size - 1] + var_04;
}

//Function Number: 9
func_B3FD(param_00,param_01,param_02)
{
	if(!func_B3F9())
	{
		return;
	}

	func_B3F7();
	var_03 = func_B405(param_01);
	var_04 = func_B3F1("PLAYER_NAME");
	var_05 = "|" + param_00 + " " + var_03 + " " + var_04 + " " + "\" + param_02 + "\";
	level.var_B3EF[level.var_B3EF.size - 1] = level.var_B3EF[level.var_B3EF.size - 1] + var_05;
}

//Function Number: 10
func_B3F7()
{
	level.var_B3EE++;
	if(level.var_B3EF.size == 0)
	{
		level.var_B3EF[level.var_B3EF.size] = "<mrec_events> ";
		level.var_B3EE = 0;
		return;
	}

	if(level.var_B3EE > 30 || level.var_B3EF[level.var_B3EF.size - 1].size > 800)
	{
		if(level.var_B406 == 1 || level.var_B406 == 3)
		{
			func_B3F0();
		}

		level.var_B3EF[level.var_B3EF.size] = "<mrec_events> ";
		level.var_B3EE = 0;
	}
}

//Function Number: 11
func_B3F0()
{
	if(!func_B3F9())
	{
		return;
	}

	if(!isdefined(level.var_B3EF) || level.var_B3EF.size == 0)
	{
		return;
	}

	switch(level.var_B406)
	{
		case 2:
		case 1:
			func_B3F6();
			break;

		case 4:
		case 3:
			func_B401();
			break;

		default:
			break;
	}
}

//Function Number: 12
func_B3F6()
{
	if(level.var_B406 == 2)
	{
		func_B3F5();
	}

	foreach(var_01 in level.var_B3EF)
	{
		function_0131(var_01 + "\n");
	}

	level.var_B3EF = [];
}

//Function Number: 13
func_B3F5()
{
	var_00 = func_B3F4();
	foreach(var_02 in var_00)
	{
		function_0131(var_02);
	}
}

//Function Number: 14
func_B404()
{
}

//Function Number: 15
func_B403()
{
}

//Function Number: 16
func_B402(param_00)
{
}

//Function Number: 17
func_B401()
{
}

//Function Number: 18
func_B3FA()
{
	if(!func_B3F9())
	{
		return;
	}

	level endon("game_ended");
	scripts\mp\_utility::func_7670("prematch_done");
	for(;;)
	{
		var_00 = gettime();
		var_01 = level.players;
		foreach(var_03 in var_01)
		{
			var_04 = gettime();
			if(isdefined(var_03) && scripts\mp\_utility::func_9F19(var_03))
			{
				func_B3FB(var_03.var_41F0,var_03.team,"PATH",var_03.origin[0],var_03.origin[1],var_04);
				scripts\common\utility::func_136F7();
			}
		}

		wait(max(0.05,1.5 - gettime() - var_00 / 1000));
	}
}

//Function Number: 19
func_B400()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_B407();
	}
}

//Function Number: 20
func_B3FE()
{
	level waittill("game_ended");
	var_00 = 0;
	var_01 = 0;
	var_02 = 0;
	var_03 = 0;
	var_04 = 0;
	foreach(var_06 in level.players)
	{
		if(isdefined(var_06.var_D37E))
		{
			foreach(var_08 in var_06.var_D37E)
			{
				var_02 = var_02 + var_08;
				var_01++;
				if(var_08 > 75)
				{
					var_00++;
				}
			}
		}

		if(isdefined(var_06.var_658E))
		{
			foreach(var_0B in var_06.var_658E)
			{
				var_04 = var_04 + var_0B;
				var_03++;
			}
		}
	}

	if(var_01 > 0)
	{
		func_B3FC("LOG_STAT",gettime(),"Shot in the back percent: " + var_00 / var_01 * 100 + "%");
		func_B3FC("LOG_STAT",gettime(),"Avg. Death Angle: " + var_02 / var_01);
	}

	if(var_03 > 0)
	{
		func_B3FC("LOG_STAT",gettime(),"Avg. Engagement Length: " + var_04 / var_03 / 1000 + "s");
	}

	if(isdefined(level.var_744D) && isdefined(level.var_744D.var_12F92) && isdefined(level.var_744D.var_5AFE))
	{
		var_0E = level.var_744D.var_12F92 + level.var_744D.var_5AFE;
		if(var_0E > 0)
		{
			func_B3FC("LOG_STAT",gettime(),"Frontline Uptime: " + level.var_744D.var_12F92 / var_0E * 100 + "%");
		}
	}
}

//Function Number: 21
func_B407()
{
	self endon("disconnect");
	level endon("game_ended");
	if(isai(self))
	{
		return;
	}

	self notifyonplayercommand("log_user_event_start","+actionslot 3");
	self notifyonplayercommand("log_user_event_end","-actionslot 3");
	self notifyonplayercommand("log_user_event_generic_event","+gostand");
	for(;;)
	{
		self waittill("log_user_event_start");
		var_00 = scripts\common\utility::func_13734("log_user_event_end","log_user_event_generic_event");
		if(var_00 == "log_user_event_generic_event")
		{
			self iprintlnbold("Event Logged");
			func_B3FC("LOG_USER_EVENT",gettime(),self.name);
		}
	}
}

//Function Number: 22
func_B3F3()
{
	if(!isdefined(game["matchRecording_nextID"]))
	{
		game["matchRecording_nextID"] = 100;
	}

	var_00 = game["matchRecording_nextID"];
	game["matchRecording_nextID"]++;
	return var_00;
}