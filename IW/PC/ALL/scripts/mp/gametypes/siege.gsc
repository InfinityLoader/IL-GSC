/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\gametypes\siege.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 64
 * Decompile Time: 3220 ms
 * Timestamp: 10/27/2023 12:13:04 AM
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
		scripts\mp\_utility::func_DF09(level.gametype,3,0,9);
		scripts\mp\_utility::func_DF11(level.gametype,5);
		scripts\mp\_utility::func_DF0B(level.gametype,1);
		scripts\mp\_utility::func_DF08(level.gametype,0);
		scripts\mp\_utility::func_DF1A(level.gametype,4);
		scripts\mp\_utility::func_DF02(level.gametype,1);
		scripts\mp\_utility::func_DEF4(level.gametype,0);
		scripts\mp\_utility::func_DF18(level.gametype,1);
		scripts\mp\_utility::func_DF19(level.gametype,4);
		level.var_B40A = 0;
		level.var_B410 = 0;
	}

	func_12E9F();
	level.var_C2A1 = 1;
	level.teambased = 1;
	level.var_C024 = 1;
	level.var_7672 = 0;
	level.var_C5A4 = ::func_C5A4;
	level.var_8136 = ::func_8136;
	level.onspawnplayer = ::onspawnplayer;
	level.var_C577 = ::func_C577;
	level.var_C4E8 = ::func_C4E8;
	level.var_C564 = ::func_C564;
	level.var_C5B2 = ::func_C5B2;
	level.var_A94F = gettime();
	level.var_1C2C = 0;
	level.var_26FA = 0;
	level.var_1C9A = 0;
	level.var_7688 = 0;
	level.var_E8E1 = "none";
	level.var_101D7 = [];
	if(level.var_B40A || level.var_B410)
	{
		level.var_B93A = ::scripts\mp\_damage::func_7678;
	}

	game["dialog"]["gametype"] = "reinforce";
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

	game["dialog"]["offense_obj"] = "capture_objs";
	game["dialog"]["defense_obj"] = "capture_objs";
	game["dialog"]["revived"] = "sr_rev";
	game["dialog"]["enemy_captured_2"] = "enemy_captured_2";
	game["dialog"]["friendly_captured_2"] = "friendly_captured_2";
	game["dialog"]["lastalive_zones"] = "lastalive_zones";
	setomnvar("ui_allies_alive",0);
	setomnvar("ui_axis_alive",0);
	thread func_C56E();
	thread func_C57C();
}

//Function Number: 2
func_987C()
{
	scripts\mp\_utility::func_F69D();
	setdynamicdvar("scr_siege_rushTimer",getmatchrulesdata("siegeData","rushTimer"));
	setdynamicdvar("scr_siege_rushTimerAmount",getmatchrulesdata("siegeData","rushTimerAmount"));
	setdynamicdvar("scr_siege_sharedRushTimer",getmatchrulesdata("siegeData","sharedRushTimer"));
	setdynamicdvar("scr_siege_preCapPoints",getmatchrulesdata("siegeData","preCapPoints"));
	setdynamicdvar("scr_siege_capRate",getmatchrulesdata("siegeData","capRate"));
	setdynamicdvar("scr_siege_halftime",0);
	scripts\mp\_utility::func_DEF4("siege",0);
	setdynamicdvar("scr_siege_promode",0);
}

//Function Number: 3
seticonnames()
{
	level.iconneutral = "waypoint_captureneutral";
	level.iconcapture = "waypoint_capture";
	level.icondefend = "waypoint_defend";
	level.iconcontested = "waypoint_contested";
	level.icontaking = "waypoint_taking";
	level.iconlosing = "waypoint_losing";
}

//Function Number: 4
func_C5A4()
{
	seticonnames();
	if(!isdefined(game["switchedsides"]))
	{
		game["switchedsides"] = 0;
	}

	if(game["switchedsides"])
	{
		var_00 = game["attackers"];
		var_01 = game["defenders"];
		game["attackers"] = var_01;
		game["defenders"] = var_00;
	}

	scripts\mp\_utility::func_F7C1("allies",&"OBJECTIVES_DOM");
	scripts\mp\_utility::func_F7C1("axis",&"OBJECTIVES_DOM");
	if(level.splitscreen)
	{
		scripts\mp\_utility::func_F7C0("allies",&"OBJECTIVES_DOM");
		scripts\mp\_utility::func_F7C0("axis",&"OBJECTIVES_DOM");
	}
	else
	{
		scripts\mp\_utility::func_F7C0("allies",&"OBJECTIVES_DOM_SCORE");
		scripts\mp\_utility::func_F7C0("axis",&"OBJECTIVES_DOM_SCORE");
	}

	scripts\mp\_utility::func_F7BE("allies",&"OBJECTIVES_DOM_HINT");
	scripts\mp\_utility::func_F7BE("axis",&"OBJECTIVES_DOM_HINT");
	func_98CE();
	var_02[0] = "dom";
	scripts\mp\_gameobjects::main(var_02);
	thread func_5913();
	thread func_13A27();
	thread func_13A87();
	thread func_13A88();
	thread func_E0F2();
	thread func_CC13();
}

//Function Number: 5
func_12E9F()
{
	scripts\mp\gametypes\common::func_12E9F();
	level.var_E8DF = scripts\mp\_utility::dvarintvalue("rushTimer",1,0,1);
	level.var_E8E0 = scripts\mp\_utility::dvarfloatvalue("rushTimerAmount",45,30,120);
	level.var_FC5F = scripts\mp\_utility::dvarfloatvalue("sharedRushTimer",0,0,1);
	level.var_D814 = scripts\mp\_utility::dvarintvalue("preCapPoints",0,0,1);
	level.var_3A00 = scripts\mp\_utility::dvarfloatvalue("capRate",7.5,1,10);
}

//Function Number: 6
func_98CE()
{
	scripts\mp\_spawnlogic::func_F62D("Domination");
	level.var_108E4 = (0,0,0);
	level.var_108E2 = (0,0,0);
	scripts\mp\_spawnlogic::func_182D("mp_dom_spawn_allies_start");
	scripts\mp\_spawnlogic::func_182D("mp_dom_spawn_axis_start");
	scripts\mp\_spawnlogic::func_1829("allies","mp_dom_spawn");
	scripts\mp\_spawnlogic::func_1829("axis","mp_dom_spawn");
	level.var_B32E = scripts\mp\_spawnlogic::func_6CAF(level.var_108E4,level.var_108E2);
	function_01B4(level.var_B32E);
}

//Function Number: 7
func_8136()
{
	var_00 = self.pers["team"];
	var_01 = scripts\mp\_utility::getotherteam(var_00);
	if(level.var_130DD)
	{
		if(game["switchedsides"])
		{
			var_02 = scripts\mp\_spawnlogic::func_8140("mp_dom_spawn_" + var_01 + "_start");
			var_03 = scripts\mp\_spawnlogic::func_813F(var_02);
		}
		else
		{
			var_02 = scripts\mp\_spawnlogic::func_8140("mp_dom_spawn_" + var_02 + "_start");
			var_03 = scripts\mp\_spawnlogic::func_813F(var_03);
		}
	}
	else
	{
		var_04 = func_81A7(var_02);
		var_05 = scripts\mp\_utility::getotherteam(var_00);
		var_06 = func_81A7(var_05);
		var_07 = func_8056(var_04,var_06);
		var_02 = scripts\mp\_spawnlogic::func_81BA(var_00);
		var_08 = [];
		var_08["preferredDomPoints"] = var_07;
		var_03 = scripts\mp\_spawnscoring::func_8136(var_02,undefined,var_08);
	}

	return var_03;
}

//Function Number: 8
func_81A7(param_00)
{
	var_01 = [];
	foreach(var_03 in level.var_5913)
	{
		if(var_03.ownerteam == param_00)
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 9
func_8056(param_00,param_01)
{
	var_02 = [];
	var_02[0] = 0;
	var_02[1] = 0;
	var_02[2] = 0;
	var_03 = self.pers["team"];
	if(param_00.size == level.var_5913.size)
	{
		var_04 = var_03;
		var_05 = level.var_2A99[var_03];
		var_02[var_05.var_130AC.var_5922] = 1;
		return var_02;
	}

	if(var_02.size > 0)
	{
		foreach(var_07 in var_02)
		{
			var_04[var_07.var_5922] = 1;
		}

		return var_04;
	}

	if(var_05.size == 0)
	{
		var_04 = var_08;
		var_05 = level.var_2A99[var_08];
		if(var_04.size > 0 && var_04.size < level.var_5913.size)
		{
			var_08 = func_81EF(var_07,undefined);
			level.var_2A99[var_07] = var_08;
		}

		var_05[var_08.var_130AC.var_5922] = 1;
		return var_05;
	}

	return var_07;
}

//Function Number: 10
func_81CF(param_00)
{
	return gettime() - param_00.var_3A40;
}

//Function Number: 11
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.var_11E8 = [];
		var_00.var_11E9 = [];
		var_00.var_12B1D = undefined;
		var_00.var_12B1E = undefined;
		var_00 thread func_C57B();
		var_00 thread scripts\mp\gametypes\obj_dom::func_C4F5();
		var_00.var_101D9 = 1;
		var_00 thread func_C574();
	}
}

//Function Number: 12
func_C574()
{
	for(;;)
	{
		self waittill("disconnect");
		foreach(var_01 in self.var_11E8)
		{
			if(isdefined(var_01))
			{
				var_01 delete();
			}
		}

		func_12E58();
	}
}

//Function Number: 13
func_C57B()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned");
		scripts\mp\_utility::func_F6FA(0);
		if(isdefined(self.pers["captures"]))
		{
			scripts\mp\_utility::func_F6FA(self.pers["captures"]);
		}

		scripts\mp\_utility::func_F6FB(0);
		if(isdefined(self.pers["rescues"]))
		{
			scripts\mp\_utility::func_F6FB(self.pers["rescues"]);
		}
	}
}

//Function Number: 14
func_C57C()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("joined_team",var_00);
		if(scripts\mp\_utility::func_7672())
		{
			var_00.var_101D9 = 1;
		}
	}
}

//Function Number: 15
onspawnplayer()
{
	func_12E58();
	level notify("spawned_player");
}

//Function Number: 16
func_3DE9()
{
	wait(0.05);
	var_00 = 0;
	if(!level.var_1BE6[game["attackers"]])
	{
		level.var_10978[game["attackers"]].var_1C90 = 1;
		var_00 = 1;
	}

	if(!level.var_1BE6[game["defenders"]])
	{
		level.var_10978[game["defenders"]].var_1C90 = 1;
		var_00 = 1;
	}

	if(var_00)
	{
		scripts\mp\_spectating::func_12F21();
	}
}

//Function Number: 17
func_5913()
{
	level endon("game_ended");
	level.var_AA1D["allies"] = 0;
	level.var_AA1D["axis"] = 0;
	var_00 = getentarray("flag_primary","targetname");
	var_01 = getentarray("flag_secondary","targetname");
	if(var_00.size + var_01.size < 2)
	{
		return;
	}

	level.var_134 = [];
	var_02 = "mp/siegeFlagPos.csv";
	var_03 = scripts\mp\_utility::func_7F8B();
	var_04 = 1;
	for(var_05 = 2;var_05 < 11;var_05++)
	{
		var_06 = tablelookup(var_02,var_04,var_03,var_05);
		if(var_06 != "")
		{
			func_F70E(var_05,float(var_06));
		}
	}

	for(var_07 = 0;var_07 < var_00.size;var_07++)
	{
		level.var_134[level.var_134.size] = var_00[var_07];
	}

	for(var_07 = 0;var_07 < var_01.size;var_07++)
	{
		level.var_134[level.var_134.size] = var_01[var_07];
	}

	level.var_5913 = [];
	for(var_07 = 0;var_07 < level.var_134.size;var_07++)
	{
		var_08 = level.var_134[var_07];
		var_08.origin = func_7EBA(var_08.script_label,var_08.origin);
		if(isdefined(var_08.target))
		{
			var_09[0] = getent(var_08.target,"targetname");
		}
		else
		{
			var_09[0] = spawn("script_model",var_08.origin);
			var_09[0].angles = var_08.angles;
		}

		var_0A = scripts\mp\_gameobjects::func_4A2E("neutral",var_08,var_09,(0,0,100));
		var_0A scripts\mp\_gameobjects::func_1CAF("enemy");
		var_0A scripts\mp\_gameobjects::func_FB08(level.var_3A00);
		var_0A scripts\mp\_gameobjects::func_FB07(&"MP_SECURING_POSITION");
		var_0B = var_0A scripts\mp\_gameobjects::getlabel();
		var_0A.label = var_0B;
		var_0A scripts\mp\_gameobjects::func_F283("friendly","waypoint_defend" + var_0B);
		var_0A scripts\mp\_gameobjects::func_F284("friendly","waypoint_defend" + var_0B);
		var_0A scripts\mp\_gameobjects::func_F283("enemy","waypoint_captureneutral" + var_0B);
		var_0A scripts\mp\_gameobjects::func_F284("enemy","waypoint_captureneutral" + var_0B);
		var_0A scripts\mp\_gameobjects::setvisibleteam("any");
		var_0A scripts\mp\_gameobjects::cancontestclaim(1);
		var_0A.var_C5BB = ::func_C5BB;
		var_0A.var_C4CB = ::func_C4CB;
		var_0A.var_C5C8 = ::func_C5C8;
		var_0A.var_C50D = ::func_C50D;
		var_0A.var_C4D9 = ::func_C4D9;
		var_0A.var_C5B9 = ::func_C5B9;
		var_0A.var_C18B = 1;
		var_0A.var_92B8 = "domFlag";
		var_0A.var_6DE3 = 1;
		var_0A.var_D8C3 = "neutral";
		var_0A.var_6E64 = 0;
		var_0A.var_D42A = 0;
		var_0A.var_3FF7 = level.var_3A00 * 1000;
		var_0C = var_09[0].origin + (0,0,32);
		var_0D = var_09[0].origin + (0,0,-32);
		var_0E = bullettrace(var_0C,var_0D,0,undefined);
		var_0F = scripts\mp\gametypes\obj_dom::checkmapoffsets(var_0A.label);
		var_0A.var_289D = var_0E["position"] + var_0F;
		var_10 = vectortoangles(var_0E["normal"]);
		var_11 = scripts\mp\gametypes\obj_dom::checkmapfxangles(var_0A.label,var_10);
		var_0A.var_289C = anglestoforward(var_11);
		var_12 = spawn("script_model",var_0A.var_289D);
		var_12 setmodel("dom_flag_scriptable");
		var_12.angles = function_02D7(var_0A.var_289C,var_12.angles);
		var_0A.var_289 = var_12;
		var_0A.vfxnamemod = "";
		if(var_0A.trigger.var_257 == 160)
		{
			var_0A.vfxnamemod = "_160";
		}
		else if(var_0A.trigger.var_257 == 90)
		{
			var_0A.vfxnamemod = "_90";
		}

		var_0A scripts\common\utility::func_5127(1,::func_F7AD);
		level.var_134[var_07].var_130AC = var_0A;
		var_0A.var_ABF0 = level.var_134[var_07];
		level.var_5913[level.var_5913.size] = var_0A;
	}

	var_13 = scripts\mp\_spawnlogic::func_8140("mp_dom_spawn_axis_start");
	var_14 = scripts\mp\_spawnlogic::func_8140("mp_dom_spawn_allies_start");
	level.var_2C5["allies"] = var_14[0].origin;
	level.var_2C5["axis"] = var_13[0].origin;
	level.var_2A99 = [];
	level.var_2A99["allies"] = func_81EF("allies",undefined);
	level.var_2A99["axis"] = func_81EF("axis",level.var_2A99["allies"]);
	if(level.var_D814)
	{
		func_110AB();
		var_15 = [];
		var_15[var_15.size] = level.var_3BB4;
		if(game["switchedsides"])
		{
			level.var_429F = func_81EF("axis",level.var_3BB4);
			var_15[var_15.size] = level.var_429F;
			level.var_42A0 = func_81EF("allies",var_15);
		}
		else
		{
			level.var_429F = func_81EF("allies",level.var_3BB4);
			var_15[var_15.size] = level.var_429F;
			level.var_42A0 = func_81EF("axis",var_15);
		}

		level scripts\common\utility::func_5127(1.5,::precap);
	}

	func_6E70();
}

//Function Number: 18
precap()
{
	level.var_429F.var_130AC func_F70C("allies","neutral",undefined,1);
	level.var_42A0.var_130AC func_F70C("axis","neutral",undefined,1);
}

//Function Number: 19
func_F7AD()
{
	thread scripts\mp\gametypes\obj_dom::func_5912();
}

//Function Number: 20
func_F70E(param_00,param_01)
{
	switch(param_00)
	{
		case 2:
			level.var_101BC = param_01;
			break;

		case 3:
			level.var_101BD = param_01;
			break;

		case 4:
			level.var_101BE = param_01;
			break;

		case 5:
			level.var_101C0 = param_01;
			break;

		case 6:
			level.var_101C1 = param_01;
			break;

		case 7:
			level.var_101C2 = param_01;
			break;

		case 8:
			level.var_101C4 = param_01;
			break;

		case 9:
			level.var_101C5 = param_01;
			break;

		case 10:
			level.var_101C6 = param_01;
			break;
	}
}

//Function Number: 21
func_7EBA(param_00,param_01)
{
	var_02 = param_01;
	if(param_00 == "_a")
	{
		if(isdefined(level.var_101BC) && isdefined(level.var_101BD) && isdefined(level.var_101BE))
		{
			var_02 = (level.var_101BC,level.var_101BD,level.var_101BE);
		}
	}
	else if(param_00 == "_b")
	{
		if(isdefined(level.var_101C0) && isdefined(level.var_101C1) && isdefined(level.var_101C2))
		{
			var_02 = (level.var_101C0,level.var_101C1,level.var_101C2);
		}
	}
	else if(isdefined(level.var_101C4) && isdefined(level.var_101C5) && isdefined(level.var_101C6))
	{
		var_02 = (level.var_101C4,level.var_101C5,level.var_101C6);
	}

	return var_02;
}

//Function Number: 22
func_110AB()
{
	var_00 = undefined;
	foreach(var_02 in level.var_134)
	{
		if(var_02.script_label == "_b")
		{
			level.var_3BB4 = var_02;
		}
	}
}

//Function Number: 23
func_13A27()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("flag_capturing",var_00);
		if(level.var_E8DF)
		{
			var_01 = scripts\mp\_utility::getotherteam(var_00.var_D8C3);
			if(var_00.var_D8C3 != "neutral" && isdefined(level.var_101DD) && level.var_101DD != "pause" && !func_A00C(var_01))
			{
				level.var_7688 = 0;
				level.var_101DD = "pause";
				func_C9CE();
				if(!func_6E69(var_00.var_D8C3))
				{
					func_FB20(var_01,var_00.var_D8C3 + "_eliminated");
				}
			}
		}
	}
}

//Function Number: 24
func_A00C(param_00)
{
	var_01 = 0;
	var_02 = func_7EB9(param_00);
	if(var_02 == 2)
	{
		var_01 = 1;
	}

	return var_01;
}

//Function Number: 25
func_6E69(param_00)
{
	var_01 = 0;
	foreach(var_03 in level.var_C928)
	{
		if(isdefined(var_03) && var_03.team == param_00 && scripts\mp\_utility::func_9F19(var_03) || var_03.pers["lives"] > 0)
		{
			var_01 = 1;
			break;
		}
	}

	return var_01;
}

//Function Number: 26
func_C9CE()
{
	if(!level.var_11920)
	{
		var_00 = level.var_E8E0;
		if(isdefined(level.var_101DC))
		{
			var_00 = level.var_101DC;
		}

		var_01 = int(gettime() + var_00 * 1000);
		scripts\mp\_gamelogic::func_C9D6(var_01);
	}

	level notify("siege_timer_paused");
}

//Function Number: 27
func_E2FE(param_00)
{
	var_01 = level.var_E8E0;
	if(level.var_11920)
	{
		if(isdefined(level.var_101DC))
		{
			var_01 = level.var_101DC;
		}

		var_02 = int(gettime() + var_01 * 1000);
		function_01AF(var_02);
		scripts\mp\_gamelogic::func_E2FF(var_02);
		if(!isdefined(level.var_101DD) || level.var_101DD == "pause")
		{
			level.var_101DD = "start";
		}

		thread func_13A89(var_01);
		if(scripts\mp\_utility::func_9FB3(param_00))
		{
			if(level.var_101D7.size > 0)
			{
				level notify("flag_capturing",self);
				return;
			}
		}
	}
}

//Function Number: 28
func_13A26(param_00)
{
	level endon("game_ended");
	var_01 = 0;
	var_02 = 0;
	var_03 = level.var_E8E1;
	var_01 = func_7EB9("allies");
	var_02 = func_7EB9("axis");
	if(level.var_E8E1 != "none")
	{
		if(level.var_FC5F || var_01 == 1 && var_02 == 1)
		{
			level.var_101DD = "start";
			func_C16E("siege_timer_start");
			func_E2FE(1);
			return;
		}
	}

	if(var_01 == 2 || var_02 == 2)
	{
		level.var_E8E1 = scripts\common\utility::func_116D7(var_01 > var_02,"allies","axis");
		if(var_03 != level.var_E8E1)
		{
			if(level.var_E8DF)
			{
				if(isdefined(level.var_101DD) && level.var_101DD != "reset")
				{
					level.var_7688 = 0;
					level.var_101DC = undefined;
					level.var_101DD = "reset";
					func_C16E("siege_timer_reset");
				}

				if(!isdefined(level.var_101DD) || level.var_101DD != "start")
				{
					var_04 = level.var_E8E0;
					if(isdefined(level.var_101DC))
					{
						var_04 = level.var_101DC;
					}

					var_05 = int(gettime() + var_04 * 1000);
					foreach(var_07 in level.players)
					{
						var_07 setclientomnvar("ui_bomb_timer",0);
					}

					level.var_118FA = 1;
					scripts\mp\_gamelogic::func_C9D6(var_05);
					function_01AF(var_05);
					scripts\mp\_gamelogic::func_E2FF(var_05);
					if(!isdefined(level.var_101DD) || level.var_101DD == "pause")
					{
						level.var_101DD = "start";
						func_C16E("siege_timer_start");
					}

					if(!level.var_7688)
					{
						thread func_13A89(var_04);
					}
				}
			}
		}
		else if((var_03 == level.var_E8E1 && var_01 == 1) || var_03 == level.var_E8E1 && var_02 == 1)
		{
			func_E2FE(1);
		}
		else
		{
			level.var_7688 = 0;
			level.var_101DC = undefined;
			level.var_101DD = "reset";
			func_C16E("siege_timer_reset");
			func_E2FE(1);
		}
	}
	else if(var_01 == 3)
	{
		func_FB20("allies","score_limit_reached");
	}
	else if(var_02 == 3)
	{
		func_FB20("axis","score_limit_reached");
	}

	self.var_D8C3 = self.ownerteam;
}

//Function Number: 29
func_13A87()
{
	level endon("game_ended");
	level endon("flag_capturing");
	var_00 = getdvarfloat("scr_siege_timelimit");
	if(var_00 > 0)
	{
		var_01 = var_00 * 60 - 1;
		while(var_01 > 0)
		{
			var_01 = var_01 - 1;
			wait(1);
		}

		level.var_101D8 = 1;
	}
}

//Function Number: 30
func_13A88()
{
	level endon("game_ended");
	scripts\mp\_utility::func_7670("prematch_done");
	while(!func_8C51())
	{
		scripts\common\utility::func_136F7();
	}

	level.var_7672 = 1;
}

//Function Number: 31
func_8C51()
{
	if(level.teambased)
	{
		return level.var_8C2A["axis"] && level.var_8C2A["allies"];
	}

	return level.var_B4BC > 1;
}

//Function Number: 32
func_13A89(param_00)
{
	level endon("game_ended");
	level endon("siege_timer_paused");
	level endon("siege_timer_reset");
	var_01 = param_00;
	var_02 = spawn("script_origin",(0,0,0));
	var_02 hide();
	level.var_7688 = 1;
	while(var_01 > 0)
	{
		var_01 = var_01 - 1;
		level.var_101DC = var_01;
		if(var_01 <= 30)
		{
			if(var_01 != 0)
			{
				var_02 playsound("ui_mp_timer_countdown");
			}
		}

		wait(1);
	}

	func_C5B2();
}

//Function Number: 33
func_7EB9(param_00)
{
	var_01 = 0;
	foreach(var_03 in level.var_5913)
	{
		if(var_03.ownerteam == param_00 && !func_9D69(var_03))
		{
			var_01 = var_01 + 1;
		}
	}

	return var_01;
}

//Function Number: 34
func_9D69(param_00)
{
	var_01 = 0;
	if(isdefined(param_00))
	{
		if(level.var_101D7.size > 0)
		{
			foreach(var_03 in level.var_101D7)
			{
				if(param_00.label == var_03)
				{
					var_01 = 1;
				}
			}
		}
	}

	return var_01;
}

//Function Number: 35
func_FB20(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		if(!isai(var_03))
		{
			var_03 setclientomnvar("ui_objective_state",0);
			var_03 setclientomnvar("ui_bomb_timer",0);
		}
	}

	thread scripts\mp\_gamelogic::endgame(param_00,game["end_reason"][param_01]);
}

//Function Number: 36
func_C4CB(param_00)
{
	var_01 = scripts\mp\_gameobjects::func_803E();
	self.var_54C5 = 0;
	scripts\mp\_gameobjects::func_FB08(level.var_3A00);
	level.var_101D7[level.var_101D7.size] = self.label;
	level notify("flag_capturing",self);
	thread scripts\mp\_gameobjects::func_130AE(param_00.team);
}

//Function Number: 37
func_C5BB(param_00)
{
	var_01 = param_00.team;
	var_02 = scripts\mp\_gameobjects::func_803E();
	self.var_3A40 = gettime();
	func_F70C(var_01,var_02,param_00);
	level.var_130DD = 0;
	if(var_02 == "neutral")
	{
		var_03 = scripts\mp\_utility::getotherteam(var_01);
		thread scripts\mp\_utility::printandsoundoneveryone(var_01,var_03,undefined,undefined,"mp_dom_flag_captured",undefined,param_00);
		var_04 = func_81AB(var_01);
		if(var_04 < level.var_134.size)
		{
			if(var_04 == 2)
			{
				scripts\mp\_utility::func_10E60("friendly_captured_2",var_01);
				scripts\mp\_utility::func_10E60("enemy_captured_2",var_03,1);
			}
			else
			{
				scripts\mp\_utility::func_10E60("secured" + self.label,var_01);
				scripts\mp\_utility::func_10E60("enemy_has" + self.label,var_03,1);
			}
		}
	}

	thread func_8366(self.touchlist[var_01],var_02);
}

//Function Number: 38
func_C5C8(param_00,param_01,param_02,param_03)
{
	var_04 = scripts\mp\_gameobjects::func_803E();
	if(param_01 > 0.05 && param_02 && !self.var_54C5)
	{
		if(var_04 == "neutral")
		{
			scripts\mp\_utility::func_10E60("securing" + self.label,param_00);
			self.var_D8BA = scripts\mp\_utility::getotherteam(param_00);
		}
		else
		{
			scripts\mp\_utility::func_10E60("losing" + self.label,var_04,1);
			scripts\mp\_utility::func_10E60("securing" + self.label,param_00);
		}

		if(!isagent(param_03))
		{
			scripts\mp\gametypes\obj_dom::updateflagcapturestate(param_00);
		}

		scripts\mp\_gameobjects::setzonestatusicons(level.iconlosing + self.label,level.icontaking + self.label);
		self.var_54C5 = 1;
	}
}

//Function Number: 39
func_C50D(param_00,param_01,param_02)
{
	func_3E07();
	if(isplayer(param_01))
	{
		param_01 setclientomnvar("ui_objective_state",0);
		param_01.var_12B1D = undefined;
	}

	if(param_02)
	{
		self.var_6E64 = 1;
	}
	else
	{
		self.var_6E64 = 0;
		func_E2FE();
	}

	var_03 = scripts\mp\_gameobjects::func_803E();
	if(var_03 == "neutral")
	{
		scripts\mp\_gameobjects::setzonestatusicons(level.iconneutral + self.label);
		scripts\mp\gametypes\obj_dom::updateflagstate("idle",0);
	}
	else
	{
		scripts\mp\_gameobjects::setzonestatusicons(level.icondefend + self.label,level.iconcapture + self.label);
		scripts\mp\gametypes\obj_dom::updateflagstate(var_03,0);
	}

	level.var_101D7 = scripts\common\utility::func_22A9(level.var_101D7,self.label);
}

//Function Number: 40
func_C4D9()
{
	scripts\mp\_gameobjects::setzonestatusicons(level.iconcontested + self.label);
	scripts\mp\gametypes\obj_dom::updateflagstate("contested",0);
	if(level.var_E8E1 == self.ownerteam)
	{
		func_E2FE();
	}
}

//Function Number: 41
func_C5B9(param_00)
{
	func_3E07();
	var_01 = scripts\mp\_gameobjects::func_803E();
	if(param_00 == "none" || var_01 == "neutral")
	{
		scripts\mp\_gameobjects::setzonestatusicons(level.iconneutral + self.label);
		self.var_54C5 = 0;
	}
	else
	{
		scripts\mp\_gameobjects::setzonestatusicons(level.icondefend + self.label,level.iconcapture + self.label);
	}

	var_02 = scripts\common\utility::func_116D7(var_01 == "neutral","idle",var_01);
	scripts\mp\gametypes\obj_dom::updateflagstate(var_02,0);
}

//Function Number: 42
func_81EF(param_00,param_01)
{
	var_02 = undefined;
	var_03 = undefined;
	var_04 = undefined;
	foreach(var_06 in level.var_134)
	{
		if(var_06.var_130AC func_7EBB() != "neutral")
		{
			continue;
		}

		var_07 = distancesquared(var_06.origin,level.var_2C5[param_00]);
		if(isdefined(param_01))
		{
			if(!func_9DF8(var_06,param_01) && !isdefined(var_02) || var_07 < var_03)
			{
				var_03 = var_07;
				var_02 = var_06;
			}

			continue;
		}

		if(!isdefined(var_02) || var_07 < var_03)
		{
			var_03 = var_07;
			var_02 = var_06;
		}
	}

	return var_02;
}

//Function Number: 43
func_9DF8(param_00,param_01)
{
	var_02 = 0;
	if(isarray(param_01))
	{
		foreach(var_04 in param_01)
		{
			if(param_00 == var_04)
			{
				var_02 = 1;
				break;
			}
		}
	}
	else if(param_00 == param_01)
	{
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 44
func_C4E8(param_00)
{
	if(scripts\mp\_utility::func_7672())
	{
		if(param_00 == "all")
		{
			func_C5B2();
			return;
		}

		if(param_00 == game["attackers"])
		{
			if(func_7EB9(param_00) == 2)
			{
				return;
			}

			func_FB20(game["defenders"],game["attackers"] + "_eliminated");
			return;
		}

		if(param_00 == game["defenders"])
		{
			if(func_7EB9(param_00) == 2)
			{
				return;
			}

			func_FB20(game["attackers"],game["defenders"] + "_eliminated");
			return;
		}

		return;
	}
}

//Function Number: 45
func_C564(param_00)
{
	var_01 = scripts\mp\_utility::func_7F5E(param_00);
	var_01 thread func_8378();
}

//Function Number: 46
func_12E58()
{
	if(isdefined(level.var_1BE5["allies"]))
	{
		setomnvar("ui_allies_alive",level.var_1BE5["allies"].size);
	}

	if(isdefined(level.var_1BE5["axis"]))
	{
		setomnvar("ui_axis_alive",level.var_1BE5["axis"].size);
	}
}

//Function Number: 47
func_C577(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	func_12E58();
	if(!isplayer(param_01) || param_01.team == self.team)
	{
		return;
	}

	if(!func_6E69(self.team) && func_81AB(self.team) == 2)
	{
		scripts\mp\_utility::func_10E60("objs_capture",param_01.team,1);
	}

	var_0A = 0;
	var_0B = 0;
	var_0C = 0;
	var_0D = self;
	var_0E = var_0D.team;
	var_0F = var_0D.origin;
	var_10 = param_01.team;
	var_11 = param_01.origin;
	var_12 = 0;
	if(isdefined(param_00))
	{
		var_11 = param_00.origin;
		var_12 = param_00 == param_01;
	}

	foreach(var_14 in param_01.var_11A46)
	{
		if(var_14 != level.var_134[0] && var_14 != level.var_134[1] && var_14 != level.var_134[2])
		{
			continue;
		}

		var_15 = var_14.var_130AC.ownerteam;
		if(var_10 != var_15)
		{
			if(!var_0A)
			{
				var_0A = 1;
			}

			continue;
		}
	}

	foreach(var_14 in level.var_134)
	{
		var_15 = var_14.var_130AC.ownerteam;
		if(var_15 == "neutral")
		{
			var_18 = param_01 istouching(var_14);
			var_19 = var_0D istouching(var_14);
			if(var_18 || var_19)
			{
				if(var_14.var_130AC.claimteam == var_0E)
				{
					if(!var_0B)
					{
						if(var_0A)
						{
							param_01 thread scripts\mp\_utility::func_83B4("capture_kill");
						}

						var_0B = 1;
						param_01 thread scripts\mp\_awards::func_8380("mode_x_assault");
						thread scripts\mp\_matchdata::func_AFC5(param_09,"assaulting");
						continue;
					}
				}
				else if(var_14.var_130AC.claimteam == var_10)
				{
					if(!var_0C)
					{
						if(var_0A)
						{
							param_01 thread scripts\mp\_utility::func_83B4("capture_kill");
						}

						var_0C = 1;
						param_01 thread scripts\mp\_awards::func_8380("mode_x_defend");
						param_01 scripts\mp\_utility::func_93DF("defends",1);
						param_01 scripts\mp\_persistence::func_10E56("round","defends",param_01.pers["defends"]);
						thread scripts\mp\_matchdata::func_AFC5(param_09,"defending");
						continue;
					}
				}
			}

			continue;
		}

		if(var_15 != var_10)
		{
			if(!var_0B)
			{
				var_1A = func_5720(var_14,var_11,var_0F);
				if(var_1A)
				{
					if(var_0A)
					{
						param_01 thread scripts\mp\_utility::func_83B4("capture_kill");
					}

					var_0B = 1;
					param_01 thread scripts\mp\_awards::func_8380("mode_x_assault");
					thread scripts\mp\_matchdata::func_AFC5(param_09,"assaulting");
					continue;
				}
			}

			continue;
		}

		if(!var_0C)
		{
			var_1B = func_5720(var_14,var_11,var_0F);
			if(var_1B)
			{
				if(var_0A)
				{
					param_01 thread scripts\mp\_utility::func_83B4("capture_kill");
				}

				var_0C = 1;
				param_01 thread scripts\mp\_awards::func_8380("mode_x_defend");
				param_01 scripts\mp\_utility::func_93DF("defends",1);
				param_01 scripts\mp\_persistence::func_10E56("round","defends",param_01.pers["defends"]);
				thread scripts\mp\_matchdata::func_AFC5(param_09,"defending");
				continue;
			}
		}
	}
}

//Function Number: 48
func_5720(param_00,param_01,param_02)
{
	var_03 = distancesquared(param_00.origin,param_01);
	var_04 = distancesquared(param_00.origin,param_02);
	if(var_03 < 105625 || var_04 < 105625)
	{
		if(!isdefined(param_00.var_B92D))
		{
			return 1;
		}

		if(param_01[2] - param_00.origin[2] < 100 || param_02[2] - param_00.origin[2] < 100)
		{
			return 1;
		}

		return 0;
	}

	return 0;
}

//Function Number: 49
func_8378()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	scripts\mp\_utility::func_1383E(3);
	var_00 = scripts\mp\_utility::getotherteam(self.pers["team"]);
	level thread scripts\mp\_utility::func_115DE("callout_lastteammemberalive",self,self.pers["team"]);
	level thread scripts\mp\_utility::func_115DE("callout_lastenemyalive",self,var_00);
	scripts\mp\_music_and_dialog::func_C54B(self);
	scripts\mp\_missions::func_A9B5();
}

//Function Number: 50
func_C5B2()
{
	if(isdefined(level.var_101D8))
	{
		level thread scripts\mp\_gamelogic::func_72BE();
		return;
	}

	var_00 = func_7EB9("allies");
	var_01 = func_7EB9("axis");
	if(var_00 > var_01)
	{
		func_FB20("allies","time_limit_reached");
		return;
	}

	if(var_01 > var_00)
	{
		func_FB20("axis","time_limit_reached");
		return;
	}

	if(var_01 == var_00)
	{
		var_02 = scripts\mp\_gamelogic::func_7E07();
		func_FB20(var_02,"time_limit_reached");
		return;
	}

	func_FB20("tie","time_limit_reached");
}

//Function Number: 51
func_115E6(param_00,param_01)
{
	var_02 = scripts\mp\_utility::func_81A0(param_01.team).size;
	if(!isdefined(param_01.var_E1C0))
	{
		param_01.var_E1C0 = [];
	}

	foreach(var_04 in level.var_C928)
	{
		if(isdefined(var_04) && var_04.team == param_00 && !scripts\mp\_utility::func_9F19(var_04) && !scripts\common\utility::func_2286(level.var_1BE5[var_04.team],var_04) && !isdefined(var_04.var_136FE) || !var_04.var_136FE)
		{
			if(isdefined(var_04.var_101D9) && var_04.var_101D9)
			{
				var_04.var_101D9 = 0;
			}

			if(!scripts\mp\_utility::func_9FB3(var_04.pers["teamKillPunish"]))
			{
				var_04 scripts\mp\_playerlogic::func_93F8(var_04.team);
				var_04.var_1D40 = 1;
				var_04 thread func_136F9();
				var_04 func_12E58();
				var_04 thread scripts\mp\_hud_message::func_10151("sr_respawned");
				level notify("sr_player_respawned",var_04);
				var_04 scripts\mp\_utility::func_AAEC("revived");
			}

			param_01 scripts\mp\_missions::func_D992("ch_rescuer");
			param_01.var_E1C0[var_04.var_86BD] = 1;
			if(param_01.var_E1C0.size == 4)
			{
				param_01 scripts\mp\_missions::func_D992("ch_helpme");
			}
		}
	}

	if(param_01.var_E1C0.size == var_02 - 1)
	{
		param_01 scripts\mp\_missions::func_D991("ch_clutch_revives");
	}

	self.var_D42A = param_01.var_E1C0.size;
}

//Function Number: 52
func_136F9()
{
	self endon("started_spawnPlayer");
	for(;;)
	{
		wait(0.05);
		if(isdefined(self) && self.sessionstate == "spectator" || !scripts\mp\_utility::func_9F19(self))
		{
			self.pers["lives"] = 1;
			scripts\mp\_playerlogic::func_1083A();
			continue;
		}
	}
}

//Function Number: 53
func_C16E(param_00)
{
	foreach(var_02 in level.players)
	{
		var_02 thread scripts\mp\_hud_message::func_10151(param_00);
	}

	level notify("match_ending_soon","time");
	level notify(param_00);
}

//Function Number: 54
func_81AB(param_00)
{
	var_01 = 0;
	for(var_02 = 0;var_02 < level.var_134.size;var_02++)
	{
		if(level.var_5913[var_02] scripts\mp\_gameobjects::func_803E() == param_00)
		{
			var_01++;
		}
	}

	return var_01;
}

//Function Number: 55
func_7EBB()
{
	return scripts\mp\_gameobjects::func_803E();
}

//Function Number: 56
func_6E70()
{
	foreach(var_01 in level.var_5913)
	{
		switch(var_01.label)
		{
			case "_a":
				var_01.var_5922 = 0;
				break;

			case "_b":
				var_01.var_5922 = 1;
				break;

			case "_c":
				var_01.var_5922 = 2;
				break;
		}
	}

	var_03 = scripts\mp\_spawnlogic::func_8140("mp_dom_spawn");
	foreach(var_05 in var_03)
	{
		var_05.var_591F = 0;
		var_05.var_5920 = 0;
		var_05.var_5921 = 0;
		var_05.var_BE82 = func_7FDC(var_05);
		switch(var_05.var_BE82.var_130AC.var_5922)
		{
			case 0:
				var_05.var_591F = 1;
				break;

			case 1:
				var_05.var_5920 = 1;
				break;

			case 2:
				var_05.var_5921 = 1;
				break;
		}
	}
}

//Function Number: 57
func_7FDC(param_00)
{
	var_01 = scripts\mp\_spawnlogic::func_9ED7();
	var_02 = undefined;
	var_03 = undefined;
	foreach(var_05 in level.var_5913)
	{
		var_06 = undefined;
		if(var_01)
		{
			var_06 = function_00C0(param_00.origin,var_05.var_ABF0.origin,999999);
		}

		if(!isdefined(var_06) || var_06 == -1)
		{
			var_06 = distancesquared(var_05.var_ABF0.origin,param_00.origin);
		}

		if(!isdefined(var_02) || var_06 < var_03)
		{
			var_02 = var_05;
			var_03 = var_06;
		}
	}

	return var_02.var_ABF0;
}

//Function Number: 58
func_8366(param_00,param_01)
{
	level endon("game_ended");
	var_02 = scripts\mp\_gameobjects::func_7E8B();
	if(isdefined(var_02.var_222))
	{
		var_02 = var_02.var_222;
	}

	level.var_A94F = gettime();
	if(isplayer(var_02))
	{
		level thread scripts\mp\_utility::func_115DE("callout_securedposition" + self.label,var_02);
		var_02 thread scripts\mp\_matchdata::func_AFBA("capture",var_02.origin);
	}

	var_03 = getarraykeys(param_00);
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		var_05 = param_00[var_03[var_04]].player;
		if(isdefined(var_05.var_222))
		{
			var_05 = var_05.var_222;
		}

		if(!isplayer(var_05))
		{
			continue;
		}

		var_05 thread func_12E7F();
		if(var_05.var_4784 > 3)
		{
			var_06 = 0;
			var_07 = 0;
		}
		else if(var_05.var_C21D > 5)
		{
			var_06 = 125;
			var_07 = 50;
		}
		else if(self.label == "_b" || param_01 != "neutral" || self.var_D42A > 0)
		{
			var_06 = undefined;
			var_07 = undefined;
		}
		else
		{
			var_06 = 125;
			var_07 = 50;
		}

		var_05 thread scripts\mp\_awards::func_8380("mode_siege_secure",var_07,var_06);
		var_05 scripts\mp\_utility::func_93DF("captures",1);
		var_05 scripts\mp\_persistence::func_10E56("round","captures",var_05.pers["captures"]);
		var_05 scripts\mp\_missions::func_D992("ch_domcap");
		var_05 scripts\mp\_utility::func_F6FA(var_05.pers["captures"]);
		var_05 scripts\mp\_utility::func_93DF("rescues",self.var_D42A);
		var_05 scripts\mp\_persistence::func_10E56("round","rescues",var_05.pers["rescues"]);
		var_05 scripts\mp\_utility::func_F6FB(var_05.pers["rescues"]);
		wait(0.05);
	}

	self.var_D42A = 0;
}

//Function Number: 59
func_7E1A()
{
	if(self.var_4784 < 4)
	{
		return 1;
	}

	return 0.25;
}

//Function Number: 60
func_12E7F()
{
	if(!isdefined(self.var_4784))
	{
		self.var_C21D = 0;
		self.var_4784 = 0;
	}

	self.var_C21D++;
	if(scripts\mp\_utility::func_7FB9() < 1)
	{
		return;
	}

	self.var_4784 = self.var_C21D / scripts\mp\_utility::func_7FB9();
}

//Function Number: 61
func_F70C(param_00,param_01,param_02,param_03)
{
	scripts\mp\_gameobjects::func_F7D4(param_00);
	scripts\mp\_gameobjects::setzonestatusicons(level.icondefend + self.label,level.iconcapture + self.label);
	scripts\mp\gametypes\obj_dom::updateflagstate(param_00,0);
	func_13A26(param_00);
	if(!isdefined(param_03))
	{
		if(param_01 != "neutral")
		{
			var_04 = func_81AB(param_00);
			if(var_04 == 2)
			{
				scripts\mp\_utility::func_10E60("friendly_captured_2",param_00);
				scripts\mp\_utility::func_10E60("enemy_captured_2",param_01,1);
			}
			else
			{
				scripts\mp\_utility::func_10E60("secured" + self.label,param_00);
				scripts\mp\_utility::func_10E60("lost" + self.label,param_01,1);
			}

			scripts\mp\_utility::playsoundonplayers("mp_dom_flag_lost",param_01);
			level.var_A94F = gettime();
		}

		func_115E6(param_00,param_02);
		self.var_6DE3 = 0;
	}
}

//Function Number: 62
func_3E07()
{
	var_00 = func_7EB9("allies");
	var_01 = func_7EB9("axis");
	if(var_00 == 3)
	{
		func_FB20("allies","score_limit_reached");
		return;
	}

	if(var_01 == 3)
	{
		func_FB20("axis","score_limit_reached");
	}
}

//Function Number: 63
func_E0F2()
{
	self endon("game_ended");
	for(;;)
	{
		if(getdvar("scr_devRemoveDomFlag","") != "")
		{
			var_00 = getdvar("scr_devRemoveDomFlag","");
			foreach(var_02 in level.var_5913)
			{
				if(isdefined(var_02.label) && var_02.label == var_00)
				{
					var_02 scripts\mp\_gameobjects::func_1CAF("none");
					var_02.trigger = undefined;
					var_02 notify("deleted");
					if(isdefined(var_02.var_BEEF))
					{
						var_02.var_BEEF delete();
					}

					foreach(var_04 in level.players)
					{
						foreach(var_06 in var_04.var_11E8)
						{
							if(isdefined(var_06))
							{
								var_06 delete();
							}
						}

						foreach(var_09 in var_04.var_11E9)
						{
							if(isdefined(var_09))
							{
								var_09 delete();
							}
						}
					}

					var_02.visibleteam = "none";
					var_02 scripts\mp\_gameobjects::func_F283("friendly",undefined);
					var_02 scripts\mp\_gameobjects::func_F284("friendly",undefined);
					var_02 scripts\mp\_gameobjects::func_F283("enemy",undefined);
					var_02 scripts\mp\_gameobjects::func_F284("enemy",undefined);
					var_0C = [];
					for(var_0D = 0;var_0D < level.var_134.size;var_0D++)
					{
						if(level.var_134[var_0D].script_label != var_00)
						{
							var_0C[var_0C.size] = level.var_134[var_0D];
						}
					}

					level.var_134 = var_0C;
					level.var_C2A8 = level.var_134;
					var_0C = [];
					for(var_0D = 0;var_0D < level.var_5913.size;var_0D++)
					{
						if(level.var_5913[var_0D].label != var_00)
						{
							var_0C[var_0C.size] = level.var_5913[var_0D];
						}
					}

					level.var_5913 = var_0C;
					break;
				}
			}

			setdynamicdvar("scr_devRemoveDomFlag","");
		}

		wait(1);
	}
}

//Function Number: 64
func_CC13()
{
	self endon("game_ended");
	for(;;)
	{
		if(getdvar("scr_devPlaceDomFlag","") != "")
		{
			var_00 = getdvar("scr_devPlaceDomFlag","");
			var_01 = spawnstruct();
			var_01.origin = level.players[0].origin;
			var_01.angles = level.players[0].angles;
			var_02 = spawn("trigger_radius",var_01.origin,0,120,128);
			var_01.trigger = var_02;
			var_01.trigger.script_label = var_00;
			var_01.ownerteam = "neutral";
			var_03 = var_01.origin + (0,0,32);
			var_04 = var_01.origin + (0,0,-32);
			var_05 = bullettrace(var_03,var_04,0,undefined);
			var_01.origin = var_05["position"];
			var_01.var_12D77 = vectortoangles(var_05["normal"]);
			var_01.var_143 = anglestoforward(var_01.var_12D77);
			var_01.var_267 = anglestoright(var_01.var_12D77);
			var_01.visuals[0] = spawn("script_model",var_01.origin);
			var_01.visuals[0].angles = var_01.angles;
			level.var_134[level.var_134.size] = var_01;
			level.var_C2A8 = level.var_134;
			var_06 = scripts\mp\_gameobjects::func_4A2E("neutral",var_01.trigger,var_01.visuals,(0,0,100));
			var_06 scripts\mp\_gameobjects::func_1CAF("enemy");
			var_06 scripts\mp\_gameobjects::func_FB08(level.var_3A00);
			var_06 scripts\mp\_gameobjects::func_FB07(&"MP_SECURING_POSITION");
			var_07 = var_00;
			var_06.label = var_07;
			var_06 scripts\mp\_gameobjects::func_F283("friendly","waypoint_defend" + var_07);
			var_06 scripts\mp\_gameobjects::func_F284("friendly","waypoint_defend" + var_07);
			var_06 scripts\mp\_gameobjects::func_F283("enemy","waypoint_captureneutral" + var_07);
			var_06 scripts\mp\_gameobjects::func_F284("enemy","waypoint_captureneutral" + var_07);
			var_06 scripts\mp\_gameobjects::setvisibleteam("any");
			var_06 scripts\mp\_gameobjects::cancontestclaim(1);
			var_06.var_C5BB = ::func_C5BB;
			var_06.var_C4CB = ::func_C4CB;
			var_06.var_C5C8 = ::func_C5C8;
			var_06.var_C50D = ::func_C50D;
			var_06.var_C4D9 = ::func_C4D9;
			var_06.var_C5B9 = ::func_C5B9;
			var_06.var_C18B = 1;
			var_06.var_92B8 = "domFlag";
			var_06.var_6DE3 = 1;
			var_06.var_3FF7 = 10000;
			var_06.var_4F5F = 50;
			var_03 = var_01.visuals[0].origin + (0,0,32);
			var_04 = var_01.visuals[0].origin + (0,0,-32);
			var_08 = scripts\common\trace::func_48BC(1,1,1,1,0,1,1);
			var_09 = [];
			var_05 = scripts\common\trace::func_DCED(var_03,var_04,var_09,var_08);
			var_06.var_289D = var_05["position"];
			var_0A = vectortoangles(var_05["normal"]);
			var_06.var_289C = anglestoforward(var_0A);
			var_06 scripts\mp\gametypes\obj_dom::func_987B();
			var_06 scripts\common\utility::func_5127(1,::func_F7AD);
			for(var_0B = 0;var_0B < level.var_134.size;var_0B++)
			{
				level.var_134[var_0B].var_130AC = var_06;
				var_06.var_ABF0 = level.var_134[var_0B];
			}

			level.var_5913[level.var_5913.size] = var_06;
			setdynamicdvar("scr_devPlaceDomFlag","");
		}

		wait(1);
	}
}