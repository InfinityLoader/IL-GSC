/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\maps\mp_metropolis\mp_metropolis.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 731 ms
 * Timestamp: 10/27/2023 12:13:50 AM
*******************************************************************/

//Function Number: 1
main()
{
	lib_0FCD::main();
	scripts\mp\maps\mp_metropolis\gen\mp_metropolis_art::main();
	lib_0FCC::main();
	scripts\mp\_load::main();
	level.var_C7B3 = getentarray("OutOfBounds","targetname");
	scripts\mp\_compass::func_FACD("compass_map_mp_metropolis");
	setdvar("r_lightGridEnableTweaks",1);
	setdvar("r_lightGridIntensity",1.33);
	setdvar("r_umbraMinObjectContribution",5);
	setdvar("r_umbraMinObjectContribution",8);
	setdvar("r_sdfShadowPenumbra",0.2);
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["allies_outfit"] = "urban";
	game["axis_outfit"] = "woodland";
	level thread func_CDA4("mp_metropolis_news_v2");
	thread scripts\mp\_animation_suite::func_1FAA();
	thread trainanims();
	thread fix_collision();
	thread move_hardpoint_startspawns();
	thread move_ball_startspawns();
	thread spawn_ball_allowed_trigger();
	thread spawn_oob_trigger();
	thread runmodespecifictriggers();
}

//Function Number: 2
fix_collision()
{
	var_00 = getent("clip128x128x8","targetname");
	var_01 = spawn("script_model",(535.5,-727,72));
	var_01.angles = (90,37.2594,-7.74062);
	var_01 clonebrushmodeltoscriptmodel(var_00);
	var_02 = getent("player256x256x8","targetname");
	var_03 = spawn("script_model",(-2046,-236,402));
	var_03.angles = (89.2967,0,0);
	var_03 clonebrushmodeltoscriptmodel(var_02);
	var_04 = spawn("script_model",(-973.5,1159.5,119));
	var_04.angles = (0,40,90);
	var_04 setmodel("fixture_exposed_air_vent_cover_mp_metropolis_patch");
	var_05 = spawn("script_model",(-960,1171,119));
	var_05.angles = (0,40,90);
	var_05 setmodel("fixture_exposed_air_vent_cover_mp_metropolis_patch");
	var_06 = spawn("script_model",(0,0,0));
	var_06.angles = (0,0,0);
	var_06 setmodel("mp_metropolis_nosight_all_01");
	var_07 = spawn("script_model",(0,0,0));
	var_07.angles = (0,0,0);
	var_07 setmodel("mp_metropolis_player_concrete_all");
	var_08 = getent("clip128x128x128","targetname");
	var_09 = spawn("script_model",(-2192,452,184));
	var_09.angles = (0,0,-14.0003);
	var_09 clonebrushmodeltoscriptmodel(var_08);
	var_0A = getent("player32x32x128","targetname");
	var_0B = spawn("script_model",(-2600,-680,344));
	var_0B.angles = (0,0,0);
	var_0B clonebrushmodeltoscriptmodel(var_0A);
	var_0C = getent("clip128x128x8","targetname");
	var_0D = spawn("script_model",(-52,2032,64));
	var_0D.angles = (0,0,-99.4002);
	var_0D clonebrushmodeltoscriptmodel(var_0C);
	var_0E = getent("player64x64x256","targetname");
	var_0F = spawn("script_model",(-176,-1716,372));
	var_0F.angles = (0,0,0);
	var_0F clonebrushmodeltoscriptmodel(var_0E);
	var_10 = getent("player256x256x8","targetname");
	var_11 = spawn("script_model",(443,528,19));
	var_11.angles = (30,0,0);
	var_11 clonebrushmodeltoscriptmodel(var_10);
	var_12 = getent("player32x32x8","targetname");
	var_13 = spawn("script_model",(-928,-1881,202));
	var_13.angles = (330,0,-90);
	var_13 clonebrushmodeltoscriptmodel(var_12);
	var_14 = getent("clip256x256x8","targetname");
	var_15 = spawn("script_model",(-712,706,32));
	var_15.angles = (0,0,90);
	var_15 clonebrushmodeltoscriptmodel(var_14);
	var_16 = getent("player512x512x8","targetname");
	var_17 = spawn("script_model",(-1320,-592,552));
	var_17.angles = (270,0,0);
	var_17 clonebrushmodeltoscriptmodel(var_16);
	var_18 = getent("player32x32x8","targetname");
	var_19 = spawn("script_model",(-2596,-240,318));
	var_19.angles = (75,0,0);
	var_19 clonebrushmodeltoscriptmodel(var_18);
	var_1A = spawn("script_model",(784,-112,108));
	var_1A.angles = (180,0,0);
	var_1A setmodel("mp_desert_uplink_col_01");
	var_1B = spawn("script_model",(1092,20,68));
	var_1B.angles = (0,90,0);
	var_1B setmodel("mp_desert_uplink_col_01");
	var_1C = getent("clip32x32x256","targetname");
	var_1D = spawn("script_model",(-146,-472,252));
	var_1D.angles = (0,0,-3.00007);
	var_1D clonebrushmodeltoscriptmodel(var_1C);
	var_1E = getent("clip32x32x256","targetname");
	var_1F = spawn("script_model",(300,44,256));
	var_1F.angles = (0,0,4.99991);
	var_1F clonebrushmodeltoscriptmodel(var_1E);
	var_20 = spawn("script_model",(-920,432,200));
	var_20.angles = (0,0,0);
	var_20 setmodel("mp_metropolis_missile_clip_1");
	var_21 = getent("clip256x256x8","targetname");
	var_22 = spawn("script_model",(-3248,488,96));
	var_22.angles = (0,345,90);
	var_22 clonebrushmodeltoscriptmodel(var_21);
	var_23 = getent("clip256x256x8","targetname");
	var_24 = spawn("script_model",(-3248,488,352));
	var_24.angles = (0,345,90);
	var_24 clonebrushmodeltoscriptmodel(var_23);
	var_25 = getent("clip128x128x8","targetname");
	var_26 = spawn("script_model",(-1792,-64,-84));
	var_26.angles = (0,0,0);
	var_26 clonebrushmodeltoscriptmodel(var_25);
	var_27 = getent("clip512x512x8","targetname");
	var_28 = spawn("script_model",(616,-1748,124));
	var_28.angles = (270,180,180);
	var_28 clonebrushmodeltoscriptmodel(var_27);
	var_29 = getent("clip64x64x128","targetname");
	var_2A = spawn("script_model",(760,264,80));
	var_2A.angles = (0,0,0);
	var_2A clonebrushmodeltoscriptmodel(var_29);
}

//Function Number: 3
func_CDA4(param_00)
{
	wait(30);
	function_030E(param_00);
}

//Function Number: 4
trainanims()
{
	precachemodel("veh_civ_train_fn_01");
	wait(3);
	var_00 = getentarray("train","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_03 = spawn("script_model",var_02.origin);
		var_03 setmodel("veh_civ_train_fn_01");
		var_03 show();
		var_03 linkto(var_02);
		var_02 thread animatetraincar();
		if(var_02.var_336 == "train01" || var_02.var_336 == "train03" || var_02.var_336 == "train05")
		{
			var_02 thread animatetraincaraudio();
		}
	}
}

//Function Number: 5
animatetraincar()
{
	level endon("game_ended");
	var_00 = self.origin;
	for(;;)
	{
		wait(5);
		self movey(11000,20,10,0);
		wait(20);
		self movez(-1000,0.1);
		wait(1);
		self hide();
		wait(1);
		self movey(-28000,0.1);
		wait(1);
		self show();
		self movez(1000,0.1);
		wait(1);
		self moveto(var_00 + (0,randomintrange(-50,50),0),20,0,6);
		wait(20);
	}
}

//Function Number: 6
animatetraincaraudio()
{
	level endon("game_ended");
	var_00 = self.origin;
	for(;;)
	{
		wait(5);
		self movey(11000,20,10,0);
		self playsound("mp_met_train_start");
		wait(0.5);
		self stoploopsound("");
		wait(0.5);
		self playloopsound("mp_met_train_move_lp");
		wait(19);
		self stoploopsound("");
		self movez(-1000,0.1);
		wait(1);
		self hide();
		wait(1);
		self movey(-28000,0.1);
		wait(1);
		self show();
		self movez(1000,0.1);
		wait(1);
		self moveto(var_00 + (0,randomintrange(-50,50),0),20,0,6);
		wait(2);
		self playloopsound("mp_met_train_move_lp");
		wait(16);
		self playsoundonmovingent("mp_met_train_stop");
		wait(0.5);
		self stoploopsound("");
		wait(0.5);
		self playloopsound("mp_met_train_idle_lp");
		wait(1);
	}
}

//Function Number: 7
traininit()
{
	var_00 = getentarray("train","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 setmodel("veh_civ_train_fn_01");
	}

	return var_00;
}

//Function Number: 8
move_hardpoint_startspawns()
{
	if(level.gametype == "koth" || level.gametype == "grnd")
	{
		wait(1);
		var_00 = scripts\mp\_spawnlogic::func_8140("mp_koth_spawn_allies_start");
		var_01 = scripts\mp\_spawnlogic::func_8140("mp_koth_spawn_axis_start");
		foreach(var_03 in var_00)
		{
			if(distance(var_03.origin,(-584,-2112,0.121567)) < 10)
			{
				var_03.origin = (-1728,-1552,-72);
				var_03.angles = (0,30,0);
			}

			if(distance(var_03.origin,(-448,-2112,0.121567)) < 10)
			{
				var_03.origin = (-1664,-1584,-72);
				var_03.angles = (0,45,0);
			}

			if(distance(var_03.origin,(-376,-2120,0.121567)) < 10)
			{
				var_03.origin = (-1696,-1648,-72);
				var_03.angles = (0,45,0);
			}

			if(distance(var_03.origin,(-584,-2040,0.121567)) < 10)
			{
				var_03.origin = (-1632,-1680,-72);
				var_03.angles = (0,90,0);
			}

			if(distance(var_03.origin,(-520,-2040,0.121567)) < 10)
			{
				var_03.origin = (-1600,-1616,-64);
				var_03.angles = (0,90,0);
			}

			if(distance(var_03.origin,(-480,-1912,0.121567)) < 10)
			{
				var_03.origin = (-1536,-1648,-64);
				var_03.angles = (0,90,0);
			}

			if(distance(var_03.origin,(-448,-2040,0.121567)) < 10)
			{
				var_03.origin = (-1568,-1712,-64);
				var_03.angles = (0,90,0);
			}

			if(distance(var_03.origin,(-552,-1976,0.121567)) < 10)
			{
				var_03.origin = (-1504,-1744,-64);
				var_03.angles = (0,120,0);
			}

			if(distance(var_03.origin,(-416,-1976,0.121567)) < 10)
			{
				var_03.origin = (-1472,-1680,-64);
				var_03.angles = (0,120,0);
			}

			if(distance(var_03.origin,(-488,-1976,0.121567)) < 10)
			{
				var_03.origin = (-1435,-1620,-64);
				var_03.angles = (0,120,0);
			}

			if(distance(var_03.origin,(-520,-2112,0.121567)) < 10)
			{
				var_03.origin = (-1500,-1590,-64);
				var_03.angles = (0,120,0);
			}

			if(distance(var_03.origin,(-376,-2048,0.121567)) < 10)
			{
				var_03.origin = (-1570,-1556,-64);
				var_03.angles = (0,120,0);
			}
		}

		foreach(var_03 in var_01)
		{
			if(distance(var_03.origin,(-1692,2116,-15.8765)) < 10)
			{
				var_03.origin = (928,1056,48);
				var_03.angles = (0,180,0);
			}

			if(distance(var_03.origin,(-1658,2180,-15.8765)) < 10)
			{
				var_03.origin = (928,1120,48);
				var_03.angles = (0,180,0);
			}

			if(distance(var_03.origin,(-1704,2052,-15.8765)) < 10)
			{
				var_03.origin = (928,1184,48);
				var_03.angles = (0,180,0);
			}

			if(distance(var_03.origin,(-1742,2188,-15.8765)) < 10)
			{
				var_03.origin = (992,1056,48);
				var_03.angles = (0,180,0);
			}

			if(distance(var_03.origin,(-1890,2188,-15.8765)) < 10)
			{
				var_03.origin = (992,1120,48);
				var_03.angles = (0,180,0);
			}

			if(distance(var_03.origin,(-1810,2188,-15.8765)) < 10)
			{
				var_03.origin = (992,1184,48);
				var_03.angles = (0,180,0);
			}

			if(distance(var_03.origin,(-1788,2120,-15.8765)) < 10)
			{
				var_03.origin = (1056,1056,48);
				var_03.angles = (0,180,0);
			}

			if(distance(var_03.origin,(-1888,2124,-15.8765)) < 10)
			{
				var_03.origin = (1056,1120,48);
				var_03.angles = (0,180,0);
			}

			if(distance(var_03.origin,(-1784,2052,-15.8765)) < 10)
			{
				var_03.origin = (1056,1184,48);
				var_03.angles = (0,180,0);
			}

			if(distance(var_03.origin,(-1884,2052,-15.8765)) < 10)
			{
				var_03.origin = (870,1184,48);
				var_03.angles = (0,180,0);
			}

			if(distance(var_03.origin,(-1872,1980,-15.8765)) < 10)
			{
				var_03.origin = (870,1120,48);
				var_03.angles = (0,180,0);
			}

			if(distance(var_03.origin,(-1760,1964,-15.8765)) < 10)
			{
				var_03.origin = (870,1056,48);
				var_03.angles = (0,180,0);
			}
		}

		filterstartspawns();
	}
}

//Function Number: 9
move_ball_startspawns()
{
	if(level.gametype == "ball")
	{
		wait(1);
		var_00 = scripts\mp\_spawnlogic::func_8140("mp_ball_spawn_axis_start");
		foreach(var_02 in var_00)
		{
			if(distance(var_02.origin,(-2418.9,-457.3,-73.8721)) < 10)
			{
				var_02.origin = (-2528,-1072,68);
				var_02.angles = (0,60,0);
			}

			if(distance(var_02.origin,(-2470.6,-542.3,-73.8721)) < 10)
			{
				var_02.origin = (-2528,-992,64);
				var_02.angles = (0,60,0);
			}

			if(distance(var_02.origin,(-2405,-553.4,-73.8721)) < 10)
			{
				var_02.origin = (-2528,-912,64);
				var_02.angles = (0,60,0);
			}

			if(distance(var_02.origin,(-2542.8,-601.9,-73.8721)) < 10)
			{
				var_02.origin = (-2448,-1024,64);
				var_02.angles = (0,60,0);
			}

			if(distance(var_02.origin,(-2470.6,-462.3,-73.8721)) < 10)
			{
				var_02.origin = (-2448,-944,64);
				var_02.angles = (0,60,0);
			}

			if(distance(var_02.origin,(-2547.8,-519.9,-73.8721)) < 10)
			{
				var_02.origin = (-2128,-1520,64);
				var_02.angles = (0,0,0);
			}

			if(distance(var_02.origin,(-2549.1,-439.9,-73.8721)) < 10)
			{
				var_02.origin = (-2128,-1456,64);
				var_02.angles = (0,0,0);
			}

			if(distance(var_02.origin,(-2474.9,-388.4,-71.8755)) < 10)
			{
				var_02.origin = (-2128,-1392,64);
				var_02.angles = (0,0,0);
			}

			if(distance(var_02.origin,(-2477,-607.4,-73.8721)) < 10)
			{
				var_02.origin = (-2048,-1424,64);
				var_02.angles = (0,0,0);
			}

			if(distance(var_02.origin,(-2545,-358.4,-71.8755)) < 10)
			{
				var_02.origin = (-2048,-1488,64);
				var_02.angles = (0,0,0);
			}
		}

		filterstartspawns();
	}
}

//Function Number: 10
filterstartspawns()
{
	var_00 = level.var_10DF1;
	level.var_10DF1 = [];
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] scripts\mp\_spawnlogic::func_108FA();
		var_00[var_01].var_F1AE = 0;
		var_00[var_01].var_94C6 = 0;
		level.var_10DF1[level.var_10DF1.size] = var_00[var_01];
	}

	if(level.teambased)
	{
		foreach(var_03 in var_00)
		{
			var_03.var_94C6 = 1;
			var_04 = anglestoforward(var_03.angles);
			foreach(var_06 in var_00)
			{
				if(var_03 == var_06)
				{
					continue;
				}

				var_07 = vectornormalize(var_06.origin - var_03.origin);
				var_08 = vectordot(var_04,var_07);
				if(var_08 > 0.86)
				{
					var_03.var_94C6 = 0;
					break;
				}
			}
		}
	}
}

//Function Number: 11
spawn_ball_allowed_trigger()
{
	wait(1);
	var_00 = spawn("trigger_radius",(-990,427,550),0,4000,400);
	var_01 = spawn("trigger_radius",(-2201,-746,370),0,200,500);
	var_02 = spawn("trigger_radius",(-2352,-1417,290),0,250,500);
	var_03 = spawn("trigger_radius",(-1882,-1342,370),0,200,500);
	var_04 = spawn("trigger_radius",(-1898,-859,370),0,200,500);
	var_05 = spawn("trigger_radius",(-1894,-1082,521),0,200,500);
	var_06 = spawn("trigger_radius",(-1155,1846,260),0,380,400);
	var_07 = spawn("trigger_radius",(30,-1250,150),0,140,400);
	var_08 = spawn("trigger_radius",(-140,-1450,250),0,300,400);
	var_09 = spawn("trigger_radius",(-1947,16,254),0,150,400);
	var_0A = spawn("trigger_radius",(-2351,200,364),0,700,400);
	level.ballallowedtriggers = getentarray("uplinkAllowedOOB","targetname");
	level.ballallowedtriggers[level.ballallowedtriggers.size] = var_00;
	level.ballallowedtriggers[level.ballallowedtriggers.size] = var_01;
	level.ballallowedtriggers[level.ballallowedtriggers.size] = var_02;
	level.ballallowedtriggers[level.ballallowedtriggers.size] = var_03;
	level.ballallowedtriggers[level.ballallowedtriggers.size] = var_04;
	level.ballallowedtriggers[level.ballallowedtriggers.size] = var_05;
	level.ballallowedtriggers[level.ballallowedtriggers.size] = var_06;
	level.ballallowedtriggers[level.ballallowedtriggers.size] = var_07;
	level.ballallowedtriggers[level.ballallowedtriggers.size] = var_08;
	level.ballallowedtriggers[level.ballallowedtriggers.size] = var_09;
	level.ballallowedtriggers[level.ballallowedtriggers.size] = var_0A;
}

//Function Number: 12
spawn_oob_trigger()
{
	wait(1);
	var_00 = spawn("trigger_radius",(400,1235,160),0,35,20);
	var_01 = spawn("trigger_radius",(400,1210,55),0,40,20);
	var_02 = spawn("trigger_radius",(-2310,-175,-60),0,30,10);
	var_03 = spawn("trigger_radius",(-2310,-227,-60),0,30,10);
	var_00 hide();
	var_01 hide();
	var_02 hide();
	var_03 hide();
	level.var_C7B3[level.var_C7B3.size] = var_00;
	level.var_C7B3[level.var_C7B3.size] = var_01;
	level.var_C7B3[level.var_C7B3.size] = var_02;
	level.var_C7B3[level.var_C7B3.size] = var_03;
}

//Function Number: 13
runmodespecifictriggers()
{
	if(level.gametype == "ball" || level.gametype == "tdef")
	{
		wait(1);
		var_00 = spawn("trigger_radius",(-2600,-70,-70),0,70,50);
		var_00.var_336 = "uplink_nozone";
		var_00 hide();
		var_01 = spawn("trigger_radius",(-2580,-60,-20),0,50,40);
		var_01.var_336 = "uplink_nozone";
		var_01 hide();
		var_02 = spawn("trigger_radius",(-2580,-155,-70),0,40,40);
		var_02.var_336 = "uplink_nozone";
		var_02 hide();
		var_03 = spawn("trigger_radius",(367,1360,700),0,130,10);
		var_03.var_336 = "uplink_nozone";
		var_03 hide();
		var_04 = spawn("trigger_radius",(54,1340,700),0,150,10);
		var_04.var_336 = "uplink_nozone";
		var_04 hide();
		var_05 = spawn("trigger_radius",(-1015,94,720),0,140,10);
		var_05.var_336 = "uplink_nozone";
		var_05 hide();
		var_06 = spawn("trigger_radius",(-760,-320,720),0,500,10);
		var_06.var_336 = "uplink_nozone";
		var_06 hide();
		var_07 = spawn("trigger_radius",(-1425,-427,315),0,150,5);
		var_07.var_336 = "uplink_nozone";
		var_07 hide();
		level.nozonetriggers[level.nozonetriggers.size] = var_00;
		level.nozonetriggers[level.nozonetriggers.size] = var_01;
		level.nozonetriggers[level.nozonetriggers.size] = var_02;
		level.nozonetriggers[level.nozonetriggers.size] = var_03;
		level.nozonetriggers[level.nozonetriggers.size] = var_04;
		level.nozonetriggers[level.nozonetriggers.size] = var_05;
		level.nozonetriggers[level.nozonetriggers.size] = var_06;
		level.nozonetriggers[level.nozonetriggers.size] = var_07;
	}
}