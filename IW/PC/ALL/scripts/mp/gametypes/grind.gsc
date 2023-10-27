/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\gametypes\grind.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 28
 * Decompile Time: 1446 ms
 * Timestamp: 10/27/2023 12:12:34 AM
*******************************************************************/

//Function Number: 1
main()
{
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
		scripts\mp\_utility::func_DF0B(level.gametype,85);
		scripts\mp\_utility::func_DF08(level.gametype,1);
		scripts\mp\_utility::func_DF1A(level.gametype,1);
		scripts\mp\_utility::func_DF02(level.gametype,0);
		scripts\mp\_utility::func_DEF4(level.gametype,0);
	}

	func_12E9F();
	level.var_1C26 = [];
	level.var_26F2 = [];
	level.var_58C4 = [];
	scripts\mp\gametypes\obj_grindzone::init();
	level.teambased = 1;
	level.var_C5A4 = ::func_C5A4;
	level.var_8136 = ::func_8136;
	level.var_C55E = ::func_C55E;
	level.onspawnplayer = ::onspawnplayer;
	level.var_4507["vanish"] = loadfx("vfx/core/impacts/small_snowhit");
}

//Function Number: 2
func_987C()
{
	scripts\mp\_utility::func_F69D();
	setdynamicdvar("scr_grind_bankTime",getmatchrulesdata("grindData","bankTime"));
	setdynamicdvar("scr_grind_bankRate",getmatchrulesdata("grindData","bankRate"));
	setdynamicdvar("scr_grind_bankCaptureTime",getmatchrulesdata("grindData","bankCaptureTime"));
	setdynamicdvar("scr_grind_megaBankLimit",getmatchrulesdata("grindData","megaBankLimit"));
	setdynamicdvar("scr_grind_bankBonus",getmatchrulesdata("grindData","megaBankBonus"));
	setdynamicdvar("scr_grind_halftime",0);
	scripts\mp\_utility::func_DEF4("grind",0);
	setdynamicdvar("scr_grind_promode",0);
}

//Function Number: 3
func_C5A4()
{
	setclientnamemode("auto_change");
	if(!isdefined(game["switchedsides"]))
	{
		game["switchedsides"] = 0;
	}

	scripts\mp\_utility::func_F7C1("allies",&"OBJECTIVES_WAR");
	scripts\mp\_utility::func_F7C1("axis",&"OBJECTIVES_WAR");
	if(level.splitscreen)
	{
		scripts\mp\_utility::func_F7C0("allies",&"OBJECTIVES_WAR");
		scripts\mp\_utility::func_F7C0("axis",&"OBJECTIVES_WAR");
	}
	else
	{
		scripts\mp\_utility::func_F7C0("allies",&"OBJECTIVES_WAR_SCORE");
		scripts\mp\_utility::func_F7C0("axis",&"OBJECTIVES_WAR_SCORE");
	}

	scripts\mp\_utility::func_F7BE("allies",&"OBJECTIVES_WAR_HINT");
	scripts\mp\_utility::func_F7BE("axis",&"OBJECTIVES_WAR_HINT");
	func_98CE();
	func_4A1E();
	level.var_58BE = ::func_58BE;
	var_00[0] = level.gametype;
	var_00[1] = "dom";
	scripts\mp\_gameobjects::main(var_00);
	func_4A31();
	level thread func_C56E();
	level thread func_E179();
}

//Function Number: 4
func_12E9F()
{
	scripts\mp\gametypes\common::func_12E9F();
	level.var_2811 = scripts\mp\_utility::dvarfloatvalue("bankTime",2,0,10);
	level.var_2810 = scripts\mp\_utility::dvarintvalue("bankRate",1,1,10);
	level.var_280F = scripts\mp\_utility::dvarintvalue("bankCaptureTime",0,0,10);
	level.var_B550 = scripts\mp\_utility::dvarintvalue("megaBankLimit",5,5,15);
	level.var_B54F = scripts\mp\_utility::dvarintvalue("megaBankBonus",150,0,750);
}

//Function Number: 5
onspawnplayer()
{
	if(isdefined(self.var_11422))
	{
		self setclientomnvar("ui_grind_tags",self.var_11422);
	}
}

//Function Number: 6
func_4A1E()
{
	level.var_58C0 = [];
	for(var_00 = 0;var_00 < 30;var_00++)
	{
		var_01[0] = spawn("script_model",(0,0,0));
		var_01[0] setmodel("dogtags_iw7_foe");
		var_01[1] = spawn("script_model",(0,0,0));
		var_01[1] setmodel("dogtags_iw7_friend");
		var_01[0] scriptmodelplayanim("mp_dogtag_spin");
		var_01[1] scriptmodelplayanim("mp_dogtag_spin");
		var_01[0] hide();
		var_01[1] hide();
		var_01[0] method_8588();
		var_01[1] method_8588();
		var_02 = spawn("trigger_radius",(0,0,0),0,32,32);
		var_02.var_336 = "trigger_dogtag";
		var_02 hide();
		var_03 = spawnstruct();
		var_03.type = "useObject";
		var_03.var_4B2C = var_02.origin;
		var_03.var_664A = var_02 getentitynumber();
		var_03.var_AA3E = 0;
		var_03.visuals = var_01;
		var_03.var_C363 = (0,0,16);
		var_03.trigger = var_02;
		var_03.triggertype = "proximity";
		var_03 scripts\mp\_gameobjects::func_1CAF("none");
		level.var_58C0[level.var_58C0.size] = var_03;
	}
}

//Function Number: 7
func_8191()
{
	var_00 = level.var_58C0[0];
	var_01 = gettime();
	foreach(var_03 in level.var_58C0)
	{
		if(!isdefined(var_03.var_AA3E))
		{
			continue;
		}

		if(var_03.interactteam == "none")
		{
			var_00 = var_03;
			break;
		}

		if(var_03.var_AA3E < var_01)
		{
			var_01 = var_03.var_AA3E;
			var_00 = var_03;
		}
	}

	var_00 notify("reset");
	var_00 scripts\mp\_gameobjects::initializetagpathvariables();
	var_00.var_AA3E = gettime();
	return var_00;
}

//Function Number: 8
func_10915(param_00,param_01)
{
	var_02 = param_00 + (0,0,14);
	var_03 = (0,randomfloat(360),0);
	var_04 = anglestoforward(var_03);
	var_05 = randomfloatrange(30,150);
	var_06 = var_02 + var_05 * var_04;
	var_02 = playerphysicstrace(var_02,var_06);
	var_07 = func_8191();
	var_07.var_4B2C = var_02;
	var_07.trigger.origin = var_02;
	var_07.visuals[0].origin = var_02;
	var_07.visuals[1].origin = var_02;
	var_07.trigger show();
	var_07 scripts\mp\_gameobjects::func_1CAF("any");
	var_07.visuals[0] thread func_10159(var_07,scripts\mp\_utility::getotherteam(param_01));
	var_07.visuals[1] thread func_10159(var_07,param_01);
	var_07.visuals[0] method_8588();
	var_07.visuals[1] method_8588();
	playsoundatpos(var_02,"mp_grind_token_drop");
	return var_07;
}

//Function Number: 9
func_10159(param_00,param_01)
{
	param_00 endon("death");
	param_00 endon("reset");
	self hide();
	foreach(var_03 in level.players)
	{
		if(func_D36B(var_03))
		{
			if(var_03.team == param_01)
			{
				self showtoplayer(var_03);
			}

			if(var_03.team == "spectator" && param_01 == "allies")
			{
				self showtoplayer(var_03);
			}
		}
	}

	for(;;)
	{
		level scripts\common\utility::waittill_any_3("joined_team","update_phase_visibility");
		self hide();
		foreach(var_03 in level.players)
		{
			if(func_D36B(var_03))
			{
				if(var_03.team == param_01)
				{
					self showtoplayer(var_03);
				}
			}

			if(var_03.team == "spectator" && param_01 == "allies")
			{
				self showtoplayer(var_03);
			}

			if(param_00.var_13383 == var_03.team && var_03 == param_00.var_4F)
			{
				scripts\mp\objidpoolmanager::minimap_objective_state(param_00.var_C2B5,"invisible");
			}
		}
	}
}

//Function Number: 10
func_D36B(param_00)
{
	if(lib_0DF8::func_9DDF(param_00))
	{
		return 0;
	}

	return 1;
}

//Function Number: 11
func_BA31(param_00)
{
	level endon("game_ended");
	param_00 endon("deleted");
	param_00 endon("reset");
	for(;;)
	{
		param_00.trigger waittill("trigger",var_01);
		if(!scripts\mp\_utility::func_9F19(var_01))
		{
			continue;
		}

		if(var_01 scripts\mp\_utility::func_9FC6() || isdefined(var_01.var_108DB))
		{
			continue;
		}

		if(isdefined(var_01.classname) && var_01.classname == "script_vehicle")
		{
			continue;
		}

		if(isagent(var_01) && isdefined(var_01.var_222))
		{
			var_01 = var_01.var_222;
		}

		if(!lib_0DF8::func_213D(param_00,var_01))
		{
			continue;
		}

		param_00.visuals[0] hide();
		param_00.visuals[1] hide();
		param_00.trigger hide();
		param_00.var_4B2C = (0,0,1000);
		param_00.trigger.origin = (0,0,1000);
		param_00.visuals[0].origin = (0,0,1000);
		param_00.visuals[1].origin = (0,0,1000);
		param_00 scripts\mp\_gameobjects::func_1CAF("none");
		if(param_00.team != var_01.team)
		{
			var_01 func_D414(var_01.var_11422 + 1);
			var_01 thread scripts\mp\_utility::func_83B4("tag_collected");
		}

		var_01 playsound("mp_killconfirm_tags_pickup");
		if(isdefined(level.var_112C0) && level.var_112C0)
		{
			if(isdefined(var_01.var_47ED) && var_01.var_47ED)
			{
				var_01 scripts\mp\_utility::func_F6A8("kill");
			}
			else
			{
				var_01 scripts\mp\_utility::func_C4DB(undefined,var_01);
			}
		}

		playsoundatpos(var_01.origin,"mp_grind_token_pickup");
		break;
	}
}

//Function Number: 12
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.var_9F36 = 0;
		var_00 thread func_B9E5();
	}
}

//Function Number: 13
func_D414(param_00)
{
	self.var_11422 = param_00;
	self.var_150 = param_00;
	if(param_00 > 999)
	{
		param_00 = 999;
	}

	self setclientomnvar("ui_grind_tags",param_00);
}

//Function Number: 14
func_B9E5()
{
	self endon("disconnect");
	for(;;)
	{
		scripts\common\utility::waittill_any_3("joined_team","joined_spectators");
		func_D414(0);
		if(self.team == "allies")
		{
			level.var_1C26 = scripts\common\utility::array_add(level.var_1C26,self);
			continue;
		}

		if(self.team == "axis")
		{
			level.var_26F2 = scripts\common\utility::array_add(level.var_26F2,self);
		}
	}
}

//Function Number: 15
func_8EC5(param_00)
{
	level waittill("game_ended");
	if(isdefined(param_00))
	{
		param_00.alpha = 0;
	}
}

//Function Number: 16
func_4A31()
{
	level.var_13FC1 = [];
	var_00 = getentarray("grind_location","targetname");
	foreach(var_02 in var_00)
	{
		level.var_13FC1[level.var_13FC1.size] = var_02;
	}

	level.var_C2A8 = level.var_13FC1;
	for(var_04 = 0;var_04 < level.var_13FC1.size;var_04++)
	{
		var_05 = scripts\mp\gametypes\obj_grindzone::func_FAD5(var_04);
		var_05 thread func_E8DD();
		level.var_13FC1[var_04].var_130AC = var_05;
		var_05.var_ABF0 = level.var_13FC1[var_04];
	}
}

//Function Number: 17
func_9E57(param_00,param_01)
{
	if(scripts\mp\_utility::func_9F19(param_00) && param_00 istouching(param_01.trigger) && param_01.ownerteam == param_00.team)
	{
		return 1;
	}

	return 0;
}

//Function Number: 18
func_E8DD()
{
	level endon("game_ended");
	self endon("stop_trigger" + self.label);
	for(;;)
	{
		self.trigger waittill("trigger",var_00);
		if(self.var_10B51)
		{
			continue;
		}

		if(isagent(var_00))
		{
			continue;
		}

		if(!isplayer(var_00))
		{
			continue;
		}

		if(var_00.var_9F36)
		{
			continue;
		}

		var_00.var_9F36 = 1;
		level thread func_D9B4(var_00,self);
	}
}

//Function Number: 19
func_E179()
{
	level waittill("game_ended");
	foreach(var_01 in level.players)
	{
		if(!isdefined(var_01))
		{
			continue;
		}

		if(!isdefined(var_01.var_11422))
		{
			continue;
		}

		var_01.var_11422 = 0;
	}
}

//Function Number: 20
func_D9B4(param_00,param_01)
{
	while(param_00.var_11422 && func_9E57(param_00,param_01) && !param_01.var_10B51)
	{
		param_00 playsoundtoplayer("mp_grind_token_banked",param_00);
		if(param_00.var_11422 >= level.var_B550)
		{
			func_EC23(param_00,level.var_B550);
			var_02 = scripts\mp\_rank::func_8104("tag_score");
			var_02 = var_02 * level.var_B550;
			param_00 thread scripts\mp\_utility::func_83B4("mega_bank",param_00.var_394,var_02 + level.var_B54F);
			param_00 scripts\mp\_missions::func_D991("ch_mega_bank");
		}
		else
		{
			var_03 = level.var_2810;
			if(var_03 > param_00.var_11422)
			{
				var_03 = param_00.var_11422;
			}

			func_EC23(param_00,var_03);
			for(var_04 = 0;var_04 < var_03;var_04++)
			{
				param_00 thread scripts\mp\_utility::func_83B4("tag_score");
			}
		}

		if(isdefined(level.var_112C0) && level.var_112C0 && isdefined(param_00.var_47ED) && param_00.var_47ED)
		{
			param_00 scripts\mp\_utility::func_F6A8("kill");
		}

		param_00 scripts\mp\_missions::func_D992("ch_grinder");
		wait(level.var_2811);
	}

	param_01 scripts\mp\gametypes\obj_grindzone::func_F7AE();
	param_00.var_9F36 = 0;
}

//Function Number: 21
func_EC23(param_00,param_01)
{
	param_00 func_D414(param_00.var_11422 - param_01);
	scripts\mp\_gamescore::func_83B0(param_00.team,param_01,0);
	param_00 scripts\mp\_utility::func_93DF("confirmed",param_01);
	param_00 scripts\mp\_persistence::func_10E56("round","confirmed",param_00.pers["confirmed"]);
	param_00 scripts\mp\_utility::func_F6FA(param_00.pers["confirmed"]);
}

//Function Number: 22
func_98CE()
{
	scripts\mp\_spawnlogic::func_F62D("TDM");
	level.var_108E4 = (0,0,0);
	level.var_108E2 = (0,0,0);
	scripts\mp\_spawnlogic::func_182D("mp_tdm_spawn_allies_start");
	scripts\mp\_spawnlogic::func_182D("mp_tdm_spawn_axis_start");
	scripts\mp\_spawnlogic::func_1829("allies","mp_tdm_spawn");
	scripts\mp\_spawnlogic::func_1829("axis","mp_tdm_spawn");
	level.var_B32E = scripts\mp\_spawnlogic::func_6CAF(level.var_108E4,level.var_108E2);
	function_01B4(level.var_B32E);
}

//Function Number: 23
func_8136()
{
	var_00 = self.pers["team"];
	if(game["switchedsides"])
	{
		var_00 = scripts\mp\_utility::getotherteam(var_00);
	}

	if(scripts\mp\_spawnlogic::func_100BA())
	{
		var_01 = scripts\mp\_spawnlogic::func_8140("mp_tdm_spawn_" + var_00 + "_start");
		var_02 = scripts\mp\_spawnlogic::func_813F(var_01);
	}
	else
	{
		var_01 = scripts\mp\_spawnlogic::func_81BA(var_02);
		var_02 = scripts\mp\_spawnscoring::func_8136(var_02);
	}

	return var_02;
}

//Function Number: 24
func_C55E(param_00,param_01,param_02,param_03,param_04)
{
	scripts\mp\gametypes\common::func_C55E(param_00,param_01,param_02,param_03,param_04);
	level thread func_5EEB(param_00,param_01);
}

//Function Number: 25
func_5EEB(param_00,param_01)
{
	if(isagent(param_00))
	{
		return;
	}

	if(param_00.var_11422 > 9)
	{
		var_02 = 10;
	}
	else if(param_01.var_11422 > 0)
	{
		var_02 = param_01.var_11422;
	}
	else
	{
		var_02 = 0;
	}

	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		var_04 = func_10915(param_00.origin,param_00.team);
		var_04.team = param_00.team;
		var_04.var_13372 = param_00;
		var_04.var_4F = param_01;
		level notify("new_tag_spawned",var_04);
		level thread func_BA31(var_04);
	}

	var_05 = param_00.var_11422 - var_02;
	var_05 = int(max(0,var_05));
	param_00 func_D414(var_05);
}

//Function Number: 26
func_58BE(param_00)
{
	if(isplayer(param_00))
	{
		param_00 scripts\mp\_utility::func_F6FB(param_00.pers["denied"]);
	}
}

//Function Number: 27
func_E15D()
{
	self endon("game_ended");
	for(;;)
	{
		if(getdvar("scr_devRemoveDomFlag","") != "")
		{
			var_00 = getdvar("scr_devRemoveDomFlag","");
			foreach(var_02 in level.var_13FC1)
			{
				if(isdefined(var_02.var_130AC.label) && var_02.var_130AC.label == var_00)
				{
					var_02.var_130AC notify("stop_trigger" + var_02.var_130AC.label);
					var_02.var_130AC scripts\mp\_gameobjects::func_1CAF("none");
					var_02.var_130AC.trigger = undefined;
					var_02.var_130AC notify("deleted");
					var_02.var_130AC.visibleteam = "none";
					var_02.var_130AC scripts\mp\_gameobjects::func_F283("friendly",undefined);
					var_02.var_130AC scripts\mp\_gameobjects::func_F284("friendly",undefined);
					var_02.var_130AC scripts\mp\_gameobjects::func_F283("enemy",undefined);
					var_02.var_130AC scripts\mp\_gameobjects::func_F284("enemy",undefined);
					var_03 = [];
					for(var_04 = 0;var_04 < level.var_C2A8.size;var_04++)
					{
						if(level.var_C2A8[var_04].script_label != var_00)
						{
							var_03[var_03.size] = level.var_C2A8[var_04];
						}
					}

					level.var_C2A8 = var_03;
					var_03 = [];
					for(var_04 = 0;var_04 < level.var_13FC1.size;var_04++)
					{
						if(level.var_13FC1[var_04].var_130AC.label != var_00)
						{
							var_03[var_03.size] = level.var_13FC1[var_04];
						}
					}

					level.var_13FC1 = var_03;
					break;
				}
			}

			setdynamicdvar("scr_devRemoveDomFlag","");
		}

		wait(1);
	}
}

//Function Number: 28
func_CC27()
{
	self endon("game_ended");
	for(;;)
	{
		if(getdvar("scr_devPlaceDomFlag","") != "")
		{
			var_00 = getdvar("scr_devPlaceDomFlag","");
			var_01 = undefined;
			var_02 = getentarray("grind_location","targetname");
			foreach(var_04 in var_02)
			{
				if("_" + var_04.script_label == var_00)
				{
					var_01 = var_04;
				}
			}

			var_01.origin = level.players[0].origin;
			var_01.ownerteam = "neutral";
			var_06 = var_01.origin + (0,0,32);
			var_07 = var_01.origin + (0,0,-32);
			var_08 = bullettrace(var_06,var_07,0,undefined);
			var_01.origin = var_08["position"];
			var_01.var_12D77 = vectortoangles(var_08["normal"]);
			var_01.var_143 = anglestoforward(var_01.var_12D77);
			var_01.var_267 = anglestoright(var_01.var_12D77);
			var_09[0] = spawn("script_model",var_01.origin);
			var_09[0].angles = var_01.angles;
			level.var_C2A8[level.var_C2A8.size] = var_01;
			level.var_13FC1[level.var_13FC1.size] = var_01;
			var_0A = spawn("trigger_radius",var_01.origin,0,90,128);
			var_0A.script_label = var_01.script_label;
			var_01 = var_0A;
			var_0B = scripts\mp\_gameobjects::func_4A2E("neutral",var_01,var_09,(0,0,100));
			var_0C = var_00;
			var_0B.label = var_0C;
			var_0B thread func_E8DD();
			var_0B scripts\mp\_gameobjects::func_1CAF("enemy");
			var_0B scripts\mp\_gameobjects::func_FB08(level.var_280F);
			var_0B scripts\mp\_gameobjects::func_FB07(&"MP_SECURING_POSITION");
			var_0B scripts\mp\_gameobjects::func_F283("friendly","waypoint_defend" + var_0C);
			var_0B scripts\mp\_gameobjects::func_F284("friendly","waypoint_defend" + var_0C);
			var_0B scripts\mp\_gameobjects::func_F283("enemy","waypoint_captureneutral" + var_0C);
			var_0B scripts\mp\_gameobjects::func_F284("enemy","waypoint_captureneutral" + var_0C);
			var_0B scripts\mp\_gameobjects::setvisibleteam("any");
			var_0B scripts\mp\_gameobjects::cancontestclaim(1);
			var_0B.var_C5BB = ::scripts\mp\gametypes\obj_grindzone::func_13FB6;
			var_0B.var_C4CB = ::scripts\mp\gametypes\obj_grindzone::func_13FB7;
			var_0B.var_C5BA = ::scripts\mp\gametypes\obj_grindzone::func_13FB5;
			var_0B.var_C4D9 = ::scripts\mp\gametypes\obj_grindzone::func_13FB3;
			var_0B.var_C5B9 = ::scripts\mp\gametypes\obj_grindzone::func_13FB4;
			var_0B.var_3FF7 = level.var_280F * 1000;
			var_06 = var_0B.visuals[0].origin + (0,0,32);
			var_07 = var_0B.visuals[0].origin + (0,0,-32);
			var_0D = scripts\common\trace::func_48BC(1,1,1,1,0,1,1);
			var_0E = [];
			var_08 = scripts\common\trace::func_DCED(var_06,var_07,var_0E,var_0D);
			var_0B.var_289D = var_08["position"];
			var_0F = vectortoangles(var_08["normal"]);
			var_0F = -1 * var_0F;
			var_0B.var_289C = anglestoforward(var_0F);
			var_0B scripts\mp\gametypes\obj_grindzone::func_F7AD();
			for(var_10 = 0;var_10 < level.var_C2A8.size;var_10++)
			{
				level.var_C2A8[var_10].var_130AC = var_0B;
				var_0B.var_ABF0 = level.var_C2A8[var_10];
			}

			level.var_13FC1[level.var_13FC1.size].var_130AC = var_0B;
			setdynamicdvar("scr_devPlaceDomFlag","");
		}

		wait(1);
	}
}