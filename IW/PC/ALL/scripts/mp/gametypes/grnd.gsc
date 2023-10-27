/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\gametypes\grnd.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 385 ms
 * Timestamp: 10/27/2023 12:12:34 AM
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
		scripts\mp\_utility::func_DF09(level.gametype,0,0,9);
		scripts\mp\_utility::func_DF11(level.gametype,10);
		scripts\mp\_utility::func_DF0B(level.gametype,7500);
		scripts\mp\_utility::func_DF08(level.gametype,1);
		scripts\mp\_utility::func_DF1A(level.gametype,1);
		scripts\mp\_utility::func_DF02(level.gametype,0);
		scripts\mp\_utility::func_DEF4(level.gametype,0);
		level.var_B40A = 0;
		level.var_B410 = 0;
	}

	func_12E9F();
	level.teambased = 1;
	level.var_C5A4 = ::func_C5A4;
	level.var_8136 = ::scripts\mp\gametypes\koth::func_8136;
	level.var_C577 = ::scripts\mp\gametypes\koth::func_C577;
	level.var_C583 = ::scripts\mp\gametypes\koth::func_80E9;
	if(level.var_B40A || level.var_B410)
	{
		level.var_B93A = ::scripts\mp\_damage::func_7678;
	}

	game["dialog"]["gametype"] = "dropzone";
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
	thread scripts\mp\gametypes\koth::func_C56E();
	level.var_4D82["drop_zone"] = 1200;
	level.var_4D83["drop_zone"] = 1190;
	level.var_4D81["drop_zone"] = 0;
	level.var_4D84["drop_zone"] = 1;
}

//Function Number: 2
func_987C()
{
	scripts\mp\_utility::func_F69D();
	setdynamicdvar("scr_grnd_dropTime",getmatchrulesdata("grndData","dropTime"));
	setdynamicdvar("scr_grnd_enableVariantDZ",getmatchrulesdata("grndData","enableVariantDZ"));
	setdynamicdvar("scr_grnd_zoneLifetime",getmatchrulesdata("kothData","zoneLifetime"));
	setdynamicdvar("scr_grnd_zoneCaptureTime",getmatchrulesdata("kothData","zoneCaptureTime"));
	setdynamicdvar("scr_grnd_zoneActivationDelay",getmatchrulesdata("kothData","zoneActivationDelay"));
	setdynamicdvar("scr_grnd_randomLocationOrder",getmatchrulesdata("kothData","randomLocationOrder"));
	setdynamicdvar("scr_grnd_additiveScoring",getmatchrulesdata("kothData","additiveScoring"));
	setdynamicdvar("scr_grnd_pauseTime",getmatchrulesdata("kothData","pauseTime"));
	setdynamicdvar("scr_grnd_delayPlayer",getmatchrulesdata("kothData","delayPlayer"));
	setdynamicdvar("scr_grnd_useHQRules",getmatchrulesdata("kothData","useHQRules"));
	setdynamicdvar("scr_grnd_halftime",0);
	scripts\mp\_utility::func_DEF4("grnd",0);
	setdynamicdvar("scr_grnd_promode",0);
}

//Function Number: 3
func_C5A4()
{
	setclientnamemode("auto_change");
	if(!isdefined(game["switchedsides"]))
	{
		game["switchedsides"] = 0;
	}

	scripts\mp\_utility::func_F7C1("allies",&"OBJECTIVES_GRND");
	scripts\mp\_utility::func_F7C1("axis",&"OBJECTIVES_GRND");
	if(level.splitscreen)
	{
		scripts\mp\_utility::func_F7C0("allies",&"OBJECTIVES_GRND");
		scripts\mp\_utility::func_F7C0("axis",&"OBJECTIVES_GRND");
	}
	else
	{
		scripts\mp\_utility::func_F7C0("allies",&"OBJECTIVES_GRND_SCORE");
		scripts\mp\_utility::func_F7C0("axis",&"OBJECTIVES_GRND_SCORE");
	}

	scripts\mp\_utility::func_F7BE("allies",&"OBJECTIVES_DOM_HINT");
	scripts\mp\_utility::func_F7BE("axis",&"OBJECTIVES_DOM_HINT");
	var_00[0] = level.gametype;
	var_00[1] = "tdm";
	var_00[2] = "hardpoint";
	scripts\mp\_gameobjects::main(var_00);
	level thread scripts\mp\gametypes\koth::func_FB01();
	level thread scripts\mp\gametypes\koth::func_FAFF();
	scripts\mp\gametypes\koth::func_98CE();
	level thread scripts\mp\gametypes\koth::func_8B4E();
	if(level.var_5EED > 0)
	{
		level thread func_DCAC();
	}
}

//Function Number: 4
func_12E9F()
{
	scripts\mp\gametypes\common::func_12E9F();
	level.var_5EED = scripts\mp\_utility::dvarfloatvalue("dropTime",15,0,60);
	level.var_13FBF = scripts\mp\_utility::dvarfloatvalue("zoneLifetime",60,0,300);
	level.var_13FBC = scripts\mp\_utility::dvarfloatvalue("zoneCaptureTime",0,0,30);
	level.var_13FBA = scripts\mp\_utility::dvarfloatvalue("zoneActivationDelay",0,0,60);
	level.var_13FC3 = scripts\mp\_utility::dvarintvalue("randomLocationOrder",0,0,1);
	level.var_13FBB = scripts\mp\_utility::dvarintvalue("additiveScoring",0,0,1);
	level.var_C9D5 = scripts\mp\_utility::dvarintvalue("pauseTime",1,0,1);
	level.var_5117 = scripts\mp\_utility::dvarintvalue("delayPlayer",0,0,1);
	level.var_13097 = scripts\mp\_utility::dvarintvalue("useHQRules",0,0,1);
	level.enablevariantdrops = scripts\mp\_utility::dvarintvalue("enableVariantDZ",0,0,1);
}

//Function Number: 5
func_DCAC()
{
	level endon("game_ended");
	scripts\mp\_utility::func_7670("prematch_done");
	level.var_8619 = [];
	for(;;)
	{
		var_00 = func_7DFF();
		var_01 = 1;
		if(isdefined(var_00) && scripts\mp\_utility::func_4BD7() < scripts\mp\_utility::func_B4D2() && level.var_6BAA + var_01 < scripts\mp\_utility::func_B4D2() && level.var_C223 < 8)
		{
			scripts\mp\_utility::playsoundonplayers("mp_dropzone_obj_taken",var_00.team);
			scripts\mp\_utility::playsoundonplayers("mp_dropzone_obj_lost",level.var_C74B[var_00.team]);
			var_02 = function_00B7(level.var_13FB0.var_767B.trigger);
			var_03 = randomintrange(0,var_02.size);
			var_04 = var_02[var_03];
			var_05 = getclosestpointonnavmesh3d(var_04.origin);
			var_06 = var_04.origin;
			var_07 = var_05;
			var_08 = scripts\common\trace::func_48BC(0,1,1,1,0,1,0);
			var_09 = [];
			var_0A = scripts\common\trace::func_DCED(var_06,var_07,var_09,var_08);
			var_04.droporigin = var_0A["position"];
			var_0B = func_7E88();
			level scripts\mp\killstreaks\_airdrop::func_581F(var_00,var_04,randomfloat(360),"dronedrop_grnd");
			var_0C = level.var_5EED;
		}
		else
		{
			var_0C = 0.5;
		}

		scripts\mp\_hostmigration::func_13708(var_0C);
	}
}

//Function Number: 6
func_7DFF()
{
	var_00 = undefined;
	var_01 = 0;
	var_02 = level.var_13FB0.var_767B scripts\mp\_gameobjects::func_803E();
	if(var_02 == "neutral")
	{
		return var_00;
	}

	foreach(var_04 in level.var_13FB0.var_767B.touchlist[var_02])
	{
		if(var_01 == 0 || var_01 > var_04.var_10DFF)
		{
			var_01 = var_04.var_10DFF;
			var_00 = var_04.player;
		}
	}

	return var_00;
}

//Function Number: 7
func_7E88()
{
	var_00 = undefined;
	if(!isdefined(level.var_8619["mega"]) && level.var_C223 == 0 && randomintrange(0,100) < 5)
	{
		var_00 = "mega";
	}
	else
	{
		if(level.var_8619.size)
		{
			for(var_01 = 200;var_01;var_01--)
			{
				var_00 = scripts\mp\killstreaks\_airdrop::func_80B6("dronedrop_grnd");
				if(isdefined(level.var_8619[var_00]))
				{
					var_00 = undefined;
					continue;
				}

				break;
			}
		}

		if(!isdefined(var_00))
		{
			var_00 = scripts\mp\killstreaks\_airdrop::func_80B6("dronedrop_grnd");
		}
	}

	level.var_8619[var_00] = 1;
	if(level.var_8619.size == 15)
	{
		level.var_8619 = [];
	}

	return var_00;
}