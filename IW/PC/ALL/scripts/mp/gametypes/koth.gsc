/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\gametypes\koth.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 43
 * Decompile Time: 2138 ms
 * Timestamp: 10/27/2023 12:12:41 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(getdvar("mapname") == "mp_background")
	{
		return;
	}

	scripts\mp\_globallogic::init();
	scripts\mp\_globallogic::func_FA99();
	if(function_011C())
	{
		level.var_987C = ::func_987C;
		[[ level.var_987C ]]();
		level thread scripts\mp\_utility::func_DF2D();
	}
	else
	{
		scripts\mp\_utility::func_DF11(level.gametype,30);
		scripts\mp\_utility::func_DF0B(level.gametype,300);
		scripts\mp\_utility::func_DF08(level.gametype,1);
		scripts\mp\_utility::func_DF1A(level.gametype,1);
		scripts\mp\_utility::func_DF02(level.gametype,0);
		scripts\mp\_utility::func_DEF4(level.gametype,0);
		level.var_B40A = 0;
		level.var_B410 = 0;
	}

	func_12E9F();
	level.var_9120 = 0;
	level.var_EC40 = undefined;
	level.teambased = 1;
	if(scripts\mp\_utility::func_9D46())
	{
		level.var_112BF = 0;
	}

	level.var_C5A4 = ::func_C5A4;
	level.var_8136 = ::func_8136;
	level.onspawnplayer = ::onspawnplayer;
	level.var_C577 = ::func_C577;
	level.var_C583 = ::func_80E9;
	level.var_A94F = gettime();
	level.var_1C28 = [];
	level.var_26F4 = [];
	level.var_A950 = undefined;
	level.var_D8AB = undefined;
	if(level.var_B40A || level.var_B410)
	{
		level.var_B93A = ::scripts\mp\_damage::func_7678;
	}

	game["dialog"]["gametype"] = "hardpoint";
	if(getdvarint("g_hardcore"))
	{
		game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
	}
	else if(getdvarint("camera_thirdPerson"))
	{
		game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
	}
	else if(getdvarint("scr_diehard"))
	{
		game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
	}
	else if(getdvarint("scr_" + level.gametype + "_promode"))
	{
		game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";
	}

	game["dialog"]["offense_obj"] = "capture_obj";
	game["dialog"]["defense_obj"] = "capture_obj";
	game["dialog"]["obj_destroyed"] = "obj_destroyed";
	game["dialog"]["obj_captured"] = "obj_captured";
	thread func_C56E();
	thread writeplayerrotationscoretomatchdataongameend();
}

//Function Number: 2
func_987C()
{
	scripts\mp\_utility::func_F69D();
	setdynamicdvar("scr_koth_zoneLifetime",getmatchrulesdata("kothData","zoneLifetime"));
	setdynamicdvar("scr_koth_zoneCaptureTime",getmatchrulesdata("kothData","zoneCaptureTime"));
	setdynamicdvar("scr_koth_zoneActivationDelay",getmatchrulesdata("kothData","zoneActivationDelay"));
	setdynamicdvar("scr_koth_randomLocationOrder",getmatchrulesdata("kothData","randomLocationOrder"));
	setdynamicdvar("scr_koth_additiveScoring",getmatchrulesdata("kothData","additiveScoring"));
	setdynamicdvar("scr_koth_pauseTime",getmatchrulesdata("kothData","pauseTime"));
	setdynamicdvar("scr_koth_delayPlayer",getmatchrulesdata("kothData","delayPlayer"));
	setdynamicdvar("scr_koth_useHQRules",getmatchrulesdata("kothData","useHQRules"));
	setdynamicdvar("scr_koth_halftime",0);
	scripts\mp\_utility::func_DEF4("koth",0);
}

//Function Number: 3
func_C5A4()
{
	scripts\mp\_utility::func_F7C1("allies",&"OBJECTIVES_KOTH");
	scripts\mp\_utility::func_F7C1("axis",&"OBJECTIVES_KOTH");
	if(level.splitscreen)
	{
		scripts\mp\_utility::func_F7C0("allies",&"OBJECTIVES_KOTH");
		scripts\mp\_utility::func_F7C0("axis",&"OBJECTIVES_KOTH");
	}
	else
	{
		scripts\mp\_utility::func_F7C0("allies",&"OBJECTIVES_KOTH_SCORE");
		scripts\mp\_utility::func_F7C0("axis",&"OBJECTIVES_KOTH_SCORE");
	}

	scripts\mp\_utility::func_F7BE("allies",&"OBJECTIVES_KOTH_HINT");
	scripts\mp\_utility::func_F7BE("axis",&"OBJECTIVES_KOTH_HINT");
	setclientnamemode("auto_change");
	var_00[0] = "hardpoint";
	var_00[1] = "tdm";
	scripts\mp\_gameobjects::main(var_00);
	level thread func_FB01();
	level thread func_FAFF();
	func_98CE();
	level thread func_8B4E();
}

//Function Number: 4
func_12E9F()
{
	scripts\mp\gametypes\common::func_12E9F();
	level.var_13FBF = scripts\mp\_utility::dvarfloatvalue("zoneLifetime",60,0,300);
	level.var_13FBC = scripts\mp\_utility::dvarfloatvalue("zoneCaptureTime",0,0,30);
	level.var_13FBA = scripts\mp\_utility::dvarfloatvalue("zoneActivationDelay",0,0,60);
	level.var_13FC3 = scripts\mp\_utility::dvarintvalue("randomLocationOrder",0,0,1);
	level.var_13FBB = scripts\mp\_utility::dvarintvalue("additiveScoring",0,0,1);
	level.var_C9D5 = scripts\mp\_utility::dvarintvalue("pauseTime",1,0,1);
	level.var_5117 = scripts\mp\_utility::dvarintvalue("delayPlayer",0,0,1);
	level.var_13097 = scripts\mp\_utility::dvarintvalue("useHQRules",0,0,1);
}

//Function Number: 5
seticonnames()
{
	level.icontarget = "waypoint_hardpoint_target";
	level.iconneutral = "koth_neutral";
	level.iconcapture = "koth_enemy";
	level.icondefend = "koth_friendly";
	level.iconcontested = "waypoint_hardpoint_contested";
	level.icontaking = "waypoint_taking_chevron";
	level.iconlosing = "waypoint_hardpoint_losing";
}

//Function Number: 6
func_8B4E()
{
	level endon("game_ended");
	seticonnames();
	setomnvar("ui_uplink_timer_stopped",1);
	setomnvar("ui_hardpoint_timer",0);
	level.var_13FB0 = func_7EB8();
	level.kothhillrotation = 0;
	level.var_13FB0.var_767B scripts\mp\gametypes\obj_zonecapture::func_1619();
	level.var_6BAC = level.var_13FB0;
	level.var_13FB0.var_767B.var_19 = 1;
	level.var_13FB0.var_767B scripts\mp\_gameobjects::setvisibleteam("any");
	level.var_13FB0.var_767B scripts\mp\_gameobjects::setzonestatusicons(level.icontarget);
	level.var_13FB0.var_767B thread scripts\mp\_matchdata::func_AFBA("hill_moved",level.var_13FB0.origin);
	scripts\mp\_utility::func_7670("prematch_done");
	level.zoneendtime = int(gettime() + 5000);
	setomnvar("ui_hardpoint_timer",level.zoneendtime);
	setomnvar("ui_uplink_timer_stopped",0);
	wait(5);
	scripts\mp\_utility::func_10E60("hp_new_location","allies");
	scripts\mp\_utility::func_10E60("hp_new_location","axis");
	scripts\mp\_utility::playsoundonplayers("mp_killstreak_radar");
	for(;;)
	{
		if(!isdefined(level.mapcalloutsready))
		{
			level thread func_FB00();
		}

		level.var_C2AE = 1;
		waittillframeend;
		level.var_13FB0.var_767B scripts\mp\_gameobjects::enableobject();
		level.var_13FB0.var_767B.var_3A3D = 0;
		if(getdvarint("com_codcasterEnabled",0) == 1)
		{
			level.var_13FB0.var_767B thread scripts\mp\gametypes\obj_zonecapture::func_11ADB();
		}

		scripts\mp\_spawnlogic::clearlastteamspawns();
		func_9121();
		scripts\mp\_spawnlogic::clearlastteamspawns();
		func_911F();
		var_00 = level.var_13FB0.var_767B scripts\mp\_gameobjects::func_803E();
		if(level.var_11920 && level.var_C9D5)
		{
			level scripts\mp\_gamelogic::func_E2FF();
		}

		level.var_A950 = undefined;
		level.var_13FB0.var_767B func_A664();
		level.var_13FB0.var_767B.var_19 = 0;
		if(level.var_13095)
		{
			foreach(var_02 in level.players)
			{
				level.var_13FB0.var_767B scripts\mp\gametypes\obj_zonecapture::func_8ED5(var_02);
			}
		}

		level.var_13FB0.var_767B scripts\mp\_gameobjects::disableobject();
		level.var_13FB0.var_767B scripts\mp\_gameobjects::func_1CAF("none");
		level.var_13FB0.var_767B scripts\mp\_gameobjects::func_F7D4("neutral");
		func_12F17("zone_shift",0);
		level notify("zone_reset");
		func_1077E();
		if(level.gametype == "grnd" && level.kothhillrotation == 1)
		{
			scripts\mp\killstreaks\_airdrop::dropzoneaddcratetypes();
		}

		wait(0.5);
		if(level.var_13097)
		{
			thread forcespawnplayers();
		}

		wait(0.5);
	}
}

//Function Number: 7
func_A664()
{
	foreach(var_01 in level.players)
	{
		foreach(var_03 in var_01.var_12D5)
		{
			var_01.var_12D5 = scripts\common\utility::func_22A9(var_01.var_12D5,var_03);
			if(isdefined(var_03))
			{
				var_03 delete();
			}
		}
	}

	if(isdefined(self.var_BEF3) && self.var_BEF3.size > 0)
	{
		foreach(var_03 in self.var_BEF3)
		{
			var_03 delete();
		}
	}

	self.var_BEF3 = [];
}

//Function Number: 8
func_7EB8()
{
	var_00 = level.var_13FC4[0];
	level.var_D8C8 = 0;
	return var_00;
}

//Function Number: 9
func_7FEF()
{
	if(level.var_13FC3)
	{
		var_13["allies"] = (0,0,0);
		var_13["axis"] = (0,0,0);
		var_01 = scripts\mp\_utility::func_808A();
		foreach(var_03 in var_01)
		{
			if(var_03.team == "spectator")
			{
				continue;
			}

			var_13[var_03.team] = var_13[var_03.team] + var_03.origin;
		}

		var_05 = scripts\mp\_utility::func_81A0("allies");
		var_06 = max(var_05.size,1);
		var_07 = scripts\mp\_utility::func_81A0("axis");
		var_08 = max(var_07.size,1);
		var_09["allies"] = var_13["allies"] / var_06;
		var_09["axis"] = var_13["axis"] / var_08;
		if(!isdefined(level.var_D8C9) || isdefined(level.var_D8C9) && level.var_D8C9.size == level.var_13FC4.size - 1)
		{
			level.var_D8C9 = [];
		}

		level.var_D8C9[level.var_D8C9.size] = level.var_D8C8;
		var_0A = 0.7;
		var_0B = 0.3;
		var_0C = undefined;
		var_0D = undefined;
		for(var_0E = 0;var_0E < level.var_13FC4.size;var_0E++)
		{
			var_0F = 0;
			foreach(var_11 in level.var_D8C9)
			{
				if(var_0E == var_11)
				{
					var_0F = 1;
					break;
				}
			}

			if(var_0F)
			{
				continue;
			}

			var_13 = level.var_13FC4[var_0E];
			var_14 = distance2dsquared(var_13.var_767B.var_4B2C,var_09["allies"]);
			var_15 = distance2dsquared(var_13.var_767B.var_4B2C,var_09["axis"]);
			var_16 = distance2dsquared(var_13.var_767B.var_4B2C,level.var_13FB0.var_767B.var_4B2C);
			var_17 = var_14 + var_15 * var_0A + var_16 * var_0B;
			if(!isdefined(var_0D) || var_17 > var_0D)
			{
				var_0D = var_17;
				var_0C = var_0E;
			}
		}

		var_13 = level.var_13FC4[var_0C];
		level.var_D8C8 = var_0C;
	}
	else
	{
		var_18 = level.var_D8C8 + 1 % level.var_13FC4.size;
		var_13 = level.var_13FC4[var_18];
		level.var_D8C8 = var_18;
	}

	return var_13;
}

//Function Number: 10
func_1077E()
{
	writecurrentrotationteamscore();
	scripts\mp\_utility::func_F79E(5,"free");
	level.var_13FB0.var_767B scripts\mp\gametypes\obj_zonecapture::func_4DE2();
	level.var_13FB0 = func_7FEF();
	level.kothhillrotation++;
	level.var_13FB0.var_767B scripts\mp\gametypes\obj_zonecapture::func_1619();
	level.var_6BAC = level.var_13FB0;
	level.var_13FB0.var_767B.var_19 = 1;
	level.var_13FB0.var_767B.var_A931 = gettime();
	var_00 = int(level.var_13FB0.script_label);
	level.var_13FB0.var_767B.var_BEEE = level.var_BEF6[var_00 - 1];
	level.var_13FB0.var_767B.var_7403 = level.var_7428[var_00 - 1];
	level.var_13FB0.var_767B.var_6550 = level.var_657A[var_00 - 1];
	level.var_13FB0.var_767B.var_457E = level.var_4581[var_00 - 1];
	if(level.var_13FBA > 0)
	{
		level.var_13FB0.var_767B scripts\mp\_gameobjects::setzonestatusicons(level.icontarget);
	}
	else
	{
		level.var_13FB0.var_767B scripts\mp\_gameobjects::setzonestatusicons(level.iconneutral);
	}

	level.var_13FB0.var_767B thread scripts\mp\_matchdata::func_AFBA("hill_moved",level.var_13FB0.origin);
}

//Function Number: 11
func_9121()
{
	scripts\mp\_utility::func_10E60("hp_new_location","allies");
	scripts\mp\_utility::func_10E60("hp_new_location","axis");
	scripts\mp\_utility::playsoundonplayers("mp_killstreak_radar");
	level.var_13FB0.var_767B thread scripts\mp\gametypes\obj_zonecapture::func_8B49();
	level.var_13FB0.var_767B scripts\mp\_gameobjects::func_1CAF("none");
	if(level.var_13FBA)
	{
		level.var_13FB0.var_767B scripts\mp\_gameobjects::setzonestatusicons(level.icontarget);
		func_12F17("zone_activation_delay",0);
		level.zoneendtime = int(gettime() + 1000 * level.var_13FBA);
		setomnvar("ui_hardpoint_timer",level.zoneendtime);
	}

	wait(level.var_13FBA);
	level.var_13FB0.var_767B scripts\mp\_gameobjects::setzonestatusicons(level.iconneutral);
	func_12F17("neutral",0);
	if(level.var_13FBF)
	{
		func_12F17("neutral",0);
		if(level.var_13097)
		{
			thread func_AF36();
			return;
		}

		thread func_BD2F(level.var_13FBF);
		level.zoneendtime = int(gettime() + 1000 * level.var_13FBF);
		setomnvar("ui_hardpoint_timer",level.zoneendtime);
		return;
	}

	level.var_13FBE = 0;
}

//Function Number: 12
func_AF36()
{
	level endon("zone_captured");
	for(;;)
	{
		level.zoneendtime = int(gettime() + 1000 * level.var_13FBF);
		setomnvar("ui_hardpoint_timer",level.zoneendtime);
		wait(0.05);
	}
}

//Function Number: 13
func_911F()
{
	level endon("game_ended");
	level endon("zone_moved");
	level.var_9120 = gettime();
	for(;;)
	{
		level.var_13FB0.var_767B scripts\mp\_gameobjects::func_1CAF("enemy");
		level.var_13FB0.var_767B scripts\mp\_gameobjects::setvisibleteam("any");
		level.var_13FB0.var_767B scripts\mp\_gameobjects::func_FB07(&"MP_SECURING_POSITION");
		if(!level.var_13097)
		{
			level.var_13FB0.var_767B thread scripts\mp\gametypes\obj_zonecapture::func_8B49();
			level.var_13FB0.var_767B scripts\mp\_gameobjects::cancontestclaim(1);
		}

		if(isdefined(level.var_B40B) && level.var_B40B)
		{
			level thread scripts\mp\gametypes\grnd::func_DCAC();
		}

		var_00 = level scripts\common\utility::func_13734("zone_captured","zone_destroyed");
		if(var_00 == "zone_destroyed")
		{
			continue;
		}

		var_01 = level.var_13FB0.var_767B scripts\mp\_gameobjects::func_803E();
		thread func_12F03();
		if(level.var_13097 && level.var_13FBF > 0)
		{
			thread func_BD2F(level.var_13FBF);
		}

		level waittill("zone_destroyed",var_02);
		level.var_10846 = undefined;
		if(isdefined(var_02))
		{
			level.var_13FB0.var_767B scripts\mp\_gameobjects::func_F7D4(var_02);
		}
		else
		{
			level.var_13FB0.var_767B scripts\mp\_gameobjects::func_F7D4("none");
		}

		if(level.var_13097)
		{
			break;
		}
	}
}

//Function Number: 14
func_12F03()
{
	level endon("game_ended");
	level endon("zone_moved");
	level endon("zone_destroyed");
	var_00 = gettime();
	if(level.var_13FBF > 0)
	{
		var_01 = var_00 + level.var_13FBF * 1000;
	}
	else
	{
		var_01 = var_01 + scripts\mp\_utility::func_81CA() * 60 * 1000 - scripts\mp\_utility::func_81CB();
	}

	var_02 = var_00;
	while(var_02 < var_01)
	{
		var_02 = gettime();
		level.var_10846 = var_01 - var_02 / 1000;
		wait(0.05);
	}
}

//Function Number: 15
func_98CE()
{
	scripts\mp\_spawnlogic::func_F62D("Hardpoint");
	level.var_108E4 = (0,0,0);
	level.var_108E2 = (0,0,0);
	scripts\mp\_spawnlogic::func_182D("mp_koth_spawn_allies_start");
	scripts\mp\_spawnlogic::func_182D("mp_koth_spawn_axis_start");
	scripts\mp\_spawnlogic::func_1829("allies","mp_koth_spawn",1);
	scripts\mp\_spawnlogic::func_1829("allies","mp_koth_spawn_secondary",1,1);
	scripts\mp\_spawnlogic::func_1829("axis","mp_koth_spawn",1);
	scripts\mp\_spawnlogic::func_1829("axis","mp_koth_spawn_secondary",1,1);
	if(!isdefined(level.var_108FB))
	{
		scripts\mp\_spawnlogic::func_1829("allies","mp_tdm_spawn");
		scripts\mp\_spawnlogic::func_1829("allies","mp_tdm_spawn_secondary",1,1);
		scripts\mp\_spawnlogic::func_1829("axis","mp_tdm_spawn");
		scripts\mp\_spawnlogic::func_1829("axis","mp_tdm_spawn_secondary",1,1);
	}

	level.var_B32E = scripts\mp\_spawnlogic::func_6CAF(level.var_108E4,level.var_108E2);
	function_01B4(level.var_B32E);
	var_00 = [];
	foreach(var_02 in level.var_13FC4)
	{
		var_02.var_74E2 = 0;
		var_02.var_108FB = [];
		var_02.var_6B6D = [];
		var_00[var_02.script_label] = var_02;
	}

	foreach(var_05 in level.var_108FB)
	{
		func_371F(var_05);
		var_06 = scripts\mp\_spawnlogic::getoriginidentifierstring(var_05);
		if(isdefined(level.kothextraprimaryspawnpoints) && isdefined(level.kothextraprimaryspawnpoints[var_06]))
		{
			foreach(var_08 in level.kothextraprimaryspawnpoints[var_06])
			{
				var_02 = var_00[var_08];
				var_02.var_108FB[var_02.var_108FB.size] = var_05;
			}
		}

		var_0A = 0;
		var_0B = var_05.classname == "mp_koth_spawn";
		var_0C = var_05.classname == "mp_koth_spawn_secondary";
		if(var_0B || var_0C)
		{
			if(isdefined(var_05.script_noteworthy) && var_05.script_noteworthy != "")
			{
				var_0A = 1;
				var_0D = strtok(var_05.script_noteworthy," ");
				foreach(var_08 in var_0D)
				{
					if(!postshipmodifiedzones(var_08))
					{
						var_02 = var_00[var_08];
						if(var_0B)
						{
							var_02.var_108FB[var_02.var_108FB.size] = var_05;
							continue;
						}

						var_02.var_6B6D[var_02.var_6B6D.size] = var_05;
					}
				}
			}
		}

		if(!var_0A)
		{
			foreach(var_02 in level.var_13FC4)
			{
				if(var_0B)
				{
					var_02.var_108FB[var_02.var_108FB.size] = var_05;
					continue;
				}

				var_02.var_6B6D[var_02.var_6B6D.size] = var_05;
			}
		}
	}
}

//Function Number: 16
func_371F(param_00)
{
	param_00.var_571F = [];
	foreach(var_02 in level.var_13FC4)
	{
		var_03 = function_00C0(param_00.origin,var_02.var_28AC,5000);
		if(var_03 < 0)
		{
			var_03 = scripts\common\utility::func_56F4(param_00.origin,var_02.var_28AC);
		}
		else
		{
			var_03 = var_03 * var_03;
		}

		param_00.var_571F[var_02 getentitynumber()] = var_03;
		if(var_03 > var_02.var_74E2)
		{
			var_02.var_74E2 = var_03;
		}
	}
}

//Function Number: 17
func_4462(param_00,param_01)
{
	var_02 = int(param_00.script_label);
	var_03 = int(param_01.script_label);
	if(!isdefined(var_02) && !isdefined(var_03))
	{
		return 0;
	}

	if(!isdefined(var_02) && isdefined(var_03))
	{
		return 1;
	}

	if(isdefined(var_02) && !isdefined(var_03))
	{
		return 0;
	}

	if(var_02 > var_03)
	{
		return 1;
	}

	return 0;
}

//Function Number: 18
func_8255(param_00)
{
	var_01 = getentarray(param_00,"targetname");
	if(!isdefined(var_01) || var_01.size == 0)
	{
		return undefined;
	}

	var_02 = 1;
	for(var_03 = var_01.size;var_02;var_03--)
	{
		var_02 = 0;
		for(var_04 = 0;var_04 < var_03 - 1;var_04++)
		{
			if(func_4462(var_01[var_04],var_01[var_04 + 1]))
			{
				var_05 = var_01[var_04];
				var_01[var_04] = var_01[var_04 + 1];
				var_01[var_04 + 1] = var_05;
				var_02 = 1;
			}
		}
	}

	return var_01;
}

//Function Number: 19
func_FB01()
{
	scripts\mp\_utility::func_98D3();
	level.var_13FC4 = [];
	level.var_13FC6 = [];
	var_00 = func_8255("hardpoint_zone");
	if(level.var_B335 == "mp_fallen")
	{
		var_00 = scripts\common\utility::func_22A9(var_00,var_00[var_00.size - 1]);
	}

	level.var_13FC4 = [];
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		level.var_13FC4[level.var_13FC4.size] = var_00[var_01];
	}

	level.var_C2A8 = level.var_13FC4;
	for(var_01 = 0;var_01 < level.var_13FC4.size;var_01++)
	{
		var_02 = scripts\mp\gametypes\obj_zonecapture::func_8B4A(var_01);
		level.var_13FC4[var_01].var_130AC = var_02;
		var_02.var_ABF0 = level.var_13FC4[var_01];
		level.var_13FC6[level.var_13FC6.size] = var_02;
	}

	level.var_1BEB = level.var_13FC4;
	var_03 = scripts\mp\_spawnlogic::func_8140("mp_koth_spawn_axis_start");
	var_04 = scripts\mp\_spawnlogic::func_8140("mp_koth_spawn_allies_start");
	level.var_2C5["allies"] = var_04[0].origin;
	level.var_2C5["axis"] = var_03[0].origin;
	return 1;
}

//Function Number: 20
func_FAFF()
{
	level.var_BEF6 = [];
	level.var_7428 = [];
	level.var_657A = [];
	level.var_4581 = [];
	var_00 = func_8255("hardpoint_zone_visual");
	var_01 = func_8255("hardpoint_zone_visual_contest");
	var_02 = func_8255("hardpoint_zone_visual_friend");
	var_03 = func_8255("hardpoint_zone_visual_enemy");
	if(!isdefined(var_00))
	{
		level.var_13095 = 0;
	}
	else
	{
		level.var_13095 = 1;
	}

	if(level.var_13095)
	{
		for(var_04 = 0;var_04 < var_00.size;var_04++)
		{
			level.var_BEF6[level.var_BEF6.size] = var_00[var_04];
			level.var_BEF6[var_04] hide();
		}

		for(var_04 = 0;var_04 < var_01.size;var_04++)
		{
			level.var_4581[level.var_4581.size] = var_01[var_04];
			level.var_4581[var_04] hide();
		}

		for(var_04 = 0;var_04 < var_02.size;var_04++)
		{
			level.var_7428[level.var_7428.size] = var_02[var_04];
			level.var_7428[var_04] hide();
		}

		for(var_04 = 0;var_04 < var_03.size;var_04++)
		{
			level.var_657A[level.var_657A.size] = var_03[var_04];
			level.var_657A[var_04] hide();
		}

		postshipmodifiedzonebrushes();
		thread func_B3DE();
	}
}

//Function Number: 21
postshipmodifiedzonebrushes()
{
	if(level.var_B335 == "mp_parkour")
	{
		for(var_00 = 0;var_00 < level.var_BEF6.size;var_00++)
		{
			if(level.var_BEF6[var_00].script_label == "1")
			{
				level.var_BEF6[var_00] hide();
				var_01 = spawn("script_model",(0,0,0));
				var_01 setmodel("mp_parkour_hardpoint_floor_01");
				var_01.angles = (0,0,0);
				var_01.script_label = "1";
				level.var_BEF6[var_00] = var_01;
			}
		}

		for(var_00 = 0;var_00 < level.var_4581.size;var_00++)
		{
			if(level.var_4581[var_00].script_label == "1")
			{
				level.var_4581[var_00] hide();
				var_02 = spawn("script_model",(0,0,0));
				var_02 setmodel("mp_parkour_hardpoint_floor_01_contest");
				var_02.angles = (0,0,0);
				var_02.script_label = "1";
				level.var_4581[var_00] = var_02;
			}
		}

		for(var_00 = 0;var_00 < level.var_7428.size;var_00++)
		{
			if(level.var_7428[var_00].script_label == "1")
			{
				level.var_7428[var_00] hide();
				var_03 = spawn("script_model",(0,0,0));
				var_03 setmodel("mp_parkour_hardpoint_floor_01_friend");
				var_03.angles = (0,0,0);
				var_03.script_label = "1";
				level.var_7428[var_00] = var_03;
			}
		}

		for(var_00 = 0;var_00 < level.var_657A.size;var_00++)
		{
			if(level.var_657A[var_00].script_label == "1")
			{
				level.var_657A[var_00] hide();
				var_04 = spawn("script_model",(0,0,0));
				var_04 setmodel("mp_parkour_hardpoint_floor_01_enemy");
				var_04.angles = (0,0,0);
				var_04.script_label = "1";
				level.var_657A[var_00] = var_04;
			}
		}
	}
}

//Function Number: 22
func_B3DE()
{
	for(var_00 = 0;var_00 < level.var_13FC4.size;var_00++)
	{
		var_01 = level.var_13FC4[var_00];
		var_01.var_767B.var_BEEE = level.var_BEF6[var_00];
		var_01.var_767B.var_6550 = level.var_657A[var_00];
		var_01.var_767B.var_457E = level.var_4581[var_00];
		var_01.var_767B.var_7403 = level.var_7428[var_00];
	}
}

//Function Number: 23
func_FB00()
{
	var_00 = undefined;
	var_01 = undefined;
	var_02 = level.var_13FB0.var_767B.visuals[0];
	if(level.var_B335 == "mp_afghan")
	{
		if(var_02.script_label == "1")
		{
			var_02.script_noteworthy = "crash_middle";
		}
	}

	foreach(var_04 in level.var_377C.var_213C)
	{
		var_00 = function_010F(var_02.var_28AC,var_04);
		var_01 = isdefined(var_02.script_noteworthy) && isdefined(var_04.script_noteworthy) && var_02.script_noteworthy == var_04.script_noteworthy;
		if(var_00 || var_01)
		{
			var_05 = level.var_377C.var_2138[var_04.script_noteworthy];
			foreach(var_07 in level.players)
			{
				if(isdefined(var_05))
				{
					var_07 setclientomnvar("ui_hp_callout_id",var_05);
				}
			}

			break;
		}
	}
}

//Function Number: 24
forcespawnplayers()
{
	var_00 = level.players;
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_02 = var_00[var_01];
		if(!isdefined(var_02) || isalive(var_02))
		{
			continue;
		}

		var_02 notify("force_spawn");
		wait(0.1);
	}
}

//Function Number: 25
func_8136()
{
	var_00 = self.pers["team"];
	if(scripts\mp\_spawnlogic::func_100BA())
	{
		var_01 = scripts\mp\_spawnlogic::func_8140("mp_koth_spawn_" + var_00 + "_start");
		var_02 = scripts\mp\_spawnlogic::func_813F(var_01);
	}
	else
	{
		var_01 = func_E172(level.var_13FB0.var_108FB);
		var_03 = func_E172(level.var_13FB0.var_6B6D);
		var_04 = func_7F57();
		var_05 = [];
		var_05["activeKOTHZoneNumber"] = level.var_13FB0 getentitynumber();
		var_05["maxSquaredDistToObjective"] = level.var_13FB0.var_74E2;
		var_05["kothZoneDeadzoneDistSq"] = var_04 * var_04;
		var_05["closestEnemyInfluenceDistSq"] = 12250000;
		var_02 = scripts\mp\_spawnscoring::func_8136(var_01,var_03,var_05);
	}

	return var_02;
}

//Function Number: 26
func_7F57()
{
	return 1000;
}

//Function Number: 27
func_E172(param_00)
{
	var_01 = [];
	if(isdefined(param_00))
	{
		foreach(var_03 in param_00)
		{
			if(!function_010F(var_03.origin,level.var_13FB0))
			{
				var_01[var_01.size] = var_03;
			}
		}
	}

	return var_01;
}

//Function Number: 28
onspawnplayer()
{
	scripts\mp\_utility::clearlowermessage("hq_respawn");
	self.var_72E1 = undefined;
}

//Function Number: 29
func_BD2F(param_00)
{
	level endon("game_ended");
	level endon("zone_reset");
	level endon("dev_force_zone");
	level.var_13FC2 = param_00;
	level.var_13FBE = 0;
	scripts\mp\gametypes\obj_zonecapture::func_13FC7();
	level.var_13FBE = 1;
	level notify("zone_moved");
	level notify("zone_destroyed");
}

//Function Number: 30
func_C577(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!isplayer(param_01) || param_01.team == self.team)
	{
		return;
	}

	if(param_01 == self)
	{
		return;
	}

	if(!isdefined(level.var_13FB0))
	{
		return;
	}

	var_0A = level.var_13FB0.var_767B.ownerteam;
	if(!isdefined(var_0A))
	{
		return;
	}

	if(isdefined(param_04) && scripts\mp\_utility::func_9E6C(param_04))
	{
		return;
	}

	var_0B = self;
	var_0C = 0;
	var_0D = param_01.team;
	if(level.var_13FBC > 0 && param_01 istouching(level.var_13FB0.var_767B.trigger))
	{
		if(var_0A != var_0D)
		{
			var_0C = 1;
		}
	}

	if(var_0D != var_0A)
	{
		if(var_0B istouching(level.var_13FB0.var_767B.trigger))
		{
			param_01.lastkilltime = gettime();
			if(var_0C)
			{
				param_01 thread scripts\mp\_utility::func_83B4("capture_kill");
			}

			param_01 thread scripts\mp\_awards::func_8380("mode_x_assault");
			thread scripts\mp\_matchdata::func_AFC5(param_09,"defending");
			return;
		}

		return;
	}

	if(param_01 istouching(level.var_13FB0.var_767B.trigger))
	{
		if(var_0C)
		{
			param_01 thread scripts\mp\_utility::func_83B4("capture_kill");
		}

		param_01 thread scripts\mp\_awards::func_8380("mode_x_defend");
		param_01 scripts\mp\_utility::func_93DF("defends",1);
		param_01 scripts\mp\_persistence::func_10E56("round","defends",param_01.pers["defends"]);
		param_01 scripts\mp\_utility::func_F6FB(param_01.pers["defends"]);
	}
}

//Function Number: 31
func_82AE(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	level.var_A94F = gettime();
	var_04 = level.var_13FB0.var_767B scripts\mp\_gameobjects::func_7E8B();
	if(isdefined(var_04.var_222))
	{
		var_04 = var_04.var_222;
	}

	if(isplayer(var_04))
	{
		if(!func_9F35(var_04))
		{
			var_04 thread scripts\mp\_matchdata::func_AFBA("capture",var_04.origin);
			var_04 thread scripts\mp\_awards::func_8380("mode_hp_secure");
			if(isdefined(level.var_13FB0.var_767B.var_A931) && gettime() - level.var_13FB0.var_767B.var_A931 <= 2100)
			{
				var_04 thread scripts\mp\_awards::func_8380("mode_hp_quick_cap");
			}

			if(var_04.lastkilltime + 500 > gettime())
			{
			}
			else
			{
				var_04 scripts\mp\gametypes\obj_zonecapture::func_F6AA(var_04);
			}
		}
	}

	var_05 = getarraykeys(param_00);
	for(var_06 = 0;var_06 < var_05.size;var_06++)
	{
		var_07 = param_00[var_05[var_06]].player;
		var_07 func_12E6E(param_03);
		if(!func_9F35(var_07))
		{
			var_07 scripts\mp\_utility::func_93DF("captures",1);
			var_07 scripts\mp\_persistence::func_10E56("round","captures",var_07.pers["captures"]);
		}
		else
		{
		}

		wait(0.05);
	}
}

//Function Number: 32
func_26CE()
{
	level endon("game_ended");
	level endon("zone_reset");
	level endon("zone_moved");
	level notify("awardCapturePointsRunning");
	level endon("awardCapturePointsRunning");
	var_00 = 1;
	var_01 = 1;
	while(!level.var_7669)
	{
		var_02 = 0;
		while(var_02 < var_00)
		{
			wait(0.05);
			scripts\mp\_hostmigration::func_13834();
			var_02 = var_02 + 0.05;
			if(level.var_13FB0.var_767B.var_10B51)
			{
				var_02 = 0;
			}
		}

		var_03 = level.var_13FB0.var_767B scripts\mp\_gameobjects::func_803E();
		if(var_03 == "neutral")
		{
			continue;
		}

		if(level.var_13097)
		{
			if(level.var_13FBB)
			{
				var_01 = level.var_13FB0.var_767B.touchlist[var_03].size;
			}

			scripts\mp\_gamescore::func_83B0(var_03,var_01,0);
			continue;
		}

		if(!level.var_13FB0.var_767B.var_10B51 && !level.var_7669)
		{
			if(level.var_13FBB)
			{
				var_01 = level.var_13FB0.var_767B.touchlist[var_03].size;
			}

			scripts\mp\_gamescore::func_83B0(var_03,var_01,0);
			foreach(var_05 in level.var_13FB0.var_767B.touchlist[var_03])
			{
				var_05.player scripts\mp\_utility::func_93DF("objTime",1);
				if(isdefined(var_05.player.timebyrotation[level.kothhillrotation]))
				{
					var_05.player.timebyrotation[level.kothhillrotation]++;
				}
				else
				{
					var_05.player.timebyrotation[level.kothhillrotation] = 1;
				}

				var_05.player scripts\mp\_persistence::func_10E56("round","objTime",var_05.player.pers["objTime"]);
				var_05.player scripts\mp\_utility::func_F6FA(var_05.player.pers["objTime"]);
				var_05.player scripts\mp\_gamescore::func_8392("koth_in_obj",10);
			}
		}
	}
}

//Function Number: 33
func_12E6E(param_00)
{
	if(!isdefined(self.var_3A07))
	{
		self.var_C21D = 0;
		self.var_3A07 = 0;
	}

	if(!isdefined(param_00) || param_00 == "neutral")
	{
		return;
	}

	self.var_C21D++;
	var_01 = scripts\mp\_utility::func_81CB() / -5536;
	if(isplayer(self) && isdefined(self.var_1190E["total"]))
	{
		var_01 = self.var_1190E["total"] / 60;
	}

	self.var_3A07 = self.var_C21D / var_01;
	if(self.var_3A07 > self.var_C21D)
	{
		self.var_3A07 = self.var_C21D;
	}
}

//Function Number: 34
func_9F35(param_00)
{
	if(!level.rankedmatch)
	{
		return 0;
	}

	if(param_00.var_3A07 > 6)
	{
		return 1;
	}

	return 0;
}

//Function Number: 35
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.var_12D5 = [];
		var_00.var_C21D = 0;
		var_00.var_3A07 = 0;
		var_00.timebyrotation = [];
		var_00 scripts\mp\_utility::func_F6FA(0);
		if(isdefined(var_00.pers["objTime"]))
		{
			var_00 scripts\mp\_utility::func_F6FA(var_00.pers["objTime"]);
		}

		var_00 scripts\mp\_utility::func_F6FB(0);
		if(isdefined(var_00.pers["defends"]))
		{
			var_00 scripts\mp\_utility::func_F6FB(var_00.pers["defends"]);
		}

		thread func_C57B(var_00);
		foreach(var_02 in level.var_13FC4)
		{
			if(level.var_13095)
			{
				var_02.var_767B scripts\mp\gametypes\obj_zonecapture::func_8ED5(var_00);
			}
		}

		var_00 thread func_DE74();
	}
}

//Function Number: 36
func_C57B(param_00)
{
	for(;;)
	{
		param_00 waittill("spawned");
		foreach(var_02 in level.var_13FC4)
		{
			if(isdefined(var_02.var_767B.var_19) && var_02.var_767B.var_19)
			{
				if(var_02.var_767B.ownerteam == "neutral")
				{
					var_02.var_767B scripts\mp\gametypes\obj_zonecapture::func_D493();
					continue;
				}

				var_02.var_767B scripts\mp\gametypes\obj_zonecapture::func_10114(var_02.var_767B.ownerteam,param_00);
			}
		}
	}
}

//Function Number: 37
func_12F17(param_00,param_01)
{
	var_02 = -1;
	if(param_01)
	{
		var_02 = -2;
	}
	else
	{
		switch(param_00)
		{
			case "allies":
			case "axis":
				var_03 = thread func_803F(param_00);
				if(isdefined(var_03))
				{
					var_02 = var_03 getentitynumber();
				}
				break;

			case "zone_activation_delay":
				var_02 = -3;
				break;

			case "zone_shift":
			default:
				break;
		}
	}

	setomnvar("ui_hardpoint",var_02);
}

//Function Number: 38
func_803F(param_00)
{
	var_01 = undefined;
	foreach(var_03 in level.players)
	{
		if(var_03.team == param_00)
		{
			var_01 = var_03;
			break;
		}
	}

	return var_01;
}

//Function Number: 39
func_DE74()
{
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 == "mlg_view_change")
		{
			foreach(var_03 in level.var_13FC4)
			{
				if(var_03.var_767B.ownerteam != "neutral")
				{
					var_03.var_767B scripts\mp\gametypes\obj_zonecapture::func_10114(var_03.var_767B.ownerteam,self);
				}
			}
		}
	}
}

//Function Number: 40
func_80E9()
{
	if(!level.var_5117)
	{
		return undefined;
	}

	var_00 = level.var_13FB0.var_767B.ownerteam;
	if(isdefined(var_00))
	{
		if(self.pers["team"] == var_00)
		{
			if(!level.var_10846)
			{
				return undefined;
			}

			return level.var_10846;
		}
	}
}

//Function Number: 41
postshipmodifiedzones(param_00)
{
	if(level.var_B335 == "mp_fallen" && param_00 == "5")
	{
		return 1;
	}

	return 0;
}

//Function Number: 42
writeplayerrotationscoretomatchdataongameend()
{
	level waittill("game_ended");
	foreach(var_01 in level.players)
	{
		if(isdefined(var_01))
		{
			foreach(var_04, var_03 in var_01.timebyrotation)
			{
				if(var_04 < 14)
				{
					if(var_03 > 255)
					{
						var_03 = 255;
					}

					setmatchdata("players",var_01.var_41F0,"kothRotationScores",var_04,var_03);
				}
			}
		}
	}

	writecurrentrotationteamscore();
}

//Function Number: 43
writecurrentrotationteamscore()
{
	if(level.kothhillrotation < 24)
	{
		setmatchdata("alliesRoundScore",level.kothhillrotation,getteamscore("allies"));
		setmatchdata("axisRoundScore",level.kothhillrotation,getteamscore("axis"));
	}
}