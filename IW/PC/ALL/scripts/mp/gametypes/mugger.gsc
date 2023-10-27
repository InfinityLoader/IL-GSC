/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\gametypes\mugger.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 47
 * Decompile Time: 2350 ms
 * Timestamp: 10/27/2023 12:12:45 AM
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
		scripts\mp\_utility::func_DF11(level.gametype,7);
		scripts\mp\_utility::func_DF0B(level.gametype,2500);
		scripts\mp\_utility::func_DF08(level.gametype,1);
		scripts\mp\_utility::func_DF1A(level.gametype,1);
		scripts\mp\_utility::func_DF02(level.gametype,0);
		scripts\mp\_utility::func_DEF4(level.gametype,0);
		level.var_B40A = 0;
		level.var_B410 = 0;
		level.var_BD7D = getdvarint("scr_mugger_bank_limit",10);
	}

	function_01CC("ffa");
	level.var_C580 = ::func_C580;
	level.var_C5A4 = ::func_C5A4;
	level.onspawnplayer = ::onspawnplayer;
	level.var_8136 = ::func_8136;
	level.var_C55E = ::func_C55E;
	level.var_C579 = ::func_C579;
	level.var_C5B2 = ::func_C5B2;
	level.var_C5CC = ::func_C5CC;
	level.var_4C85 = ::func_49F2;
	level.var_23E9 = 1;
	if(level.var_B40A || level.var_B410)
	{
		level.var_B93A = ::scripts\mp\_damage::func_7678;
	}

	level.var_BD84["vanish"] = loadfx("impacts/small_snowhit");
	level.var_BD84["smoke"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
	level.var_BDA5 = loadfx("misc/ui_flagbase_red");
	level thread func_C56E();
}

//Function Number: 2
func_987C()
{
	scripts\mp\_utility::func_F69D();
	setdynamicdvar("scr_mugger_roundswitch",0);
	scripts\mp\_utility::func_DF09("mugger",0,0,9);
	setdynamicdvar("scr_mugger_roundlimit",1);
	scripts\mp\_utility::func_DF08("mugger",1);
	setdynamicdvar("scr_mugger_winlimit",1);
	scripts\mp\_utility::func_DF1A("mugger",1);
	setdynamicdvar("scr_mugger_halftime",0);
	scripts\mp\_utility::func_DEF4("mugger",0);
	setdynamicdvar("scr_mugger_promode",0);
	level.var_BD7D = getmatchrulesdata("muggerData","bankLimit");
	setdynamicdvar("scr_mugger_bank_limit",level.var_BD7D);
	level.var_BD8D = getmatchrulesdata("muggerData","jackpotLimit");
	setdynamicdvar("scr_mugger_jackpot_limit",level.var_BD8D);
	level.var_BDA6 = getmatchrulesdata("muggerData","throwKnifeFrac");
	setdynamicdvar("scr_mugger_throwing_knife_mug_frac",level.var_BDA6);
}

//Function Number: 3
func_C580()
{
	precachemodel("dogtags_iw7_foe");
	precachemodel("lethal_smoke_grenade_wm");
	precachempanim("mp_dogtag_spin");
	precacheshader("waypoint_dogtags2");
	precacheshader("waypoint_dogtag_pile");
	precacheshader("waypoint_jackpot");
	precacheshader("hud_tagcount");
	precachesound("mugger_mugging");
	precachesound("mugger_mega_mugging");
	precachesound("mugger_you_mugged");
	precachesound("mugger_got_mugged");
	precachesound("mugger_mega_drop");
	precachesound("mugger_muggernaut");
	precachesound("mugger_tags_banked");
	precachestring(&"MPUI_MUGGER_JACKPOT");
}

//Function Number: 4
func_C5A4()
{
	setclientnamemode("auto_change");
	scripts\mp\_utility::func_F7C1("allies",&"OBJECTIVES_MUGGER");
	scripts\mp\_utility::func_F7C1("axis",&"OBJECTIVES_MUGGER");
	if(level.splitscreen)
	{
		scripts\mp\_utility::func_F7C0("allies",&"OBJECTIVES_MUGGER");
		scripts\mp\_utility::func_F7C0("axis",&"OBJECTIVES_MUGGER");
	}
	else
	{
		scripts\mp\_utility::func_F7C0("allies",&"OBJECTIVES_MUGGER_SCORE");
		scripts\mp\_utility::func_F7C0("axis",&"OBJECTIVES_MUGGER_SCORE");
	}

	scripts\mp\_utility::func_F7BE("allies",&"OBJECTIVES_MUGGER_HINT");
	scripts\mp\_utility::func_F7BE("axis",&"OBJECTIVES_MUGGER_HINT");
	scripts\mp\_spawnlogic::func_F62D("FreeForAll");
	level.var_108E4 = (0,0,0);
	level.var_108E2 = (0,0,0);
	scripts\mp\_spawnlogic::func_1829("allies","mp_dm_spawn");
	scripts\mp\_spawnlogic::func_1829("axis","mp_dm_spawn");
	level.var_B32E = scripts\mp\_spawnlogic::func_6CAF(level.var_108E4,level.var_108E2);
	function_01B4(level.var_B32E);
	level.var_58C0 = [];
	var_00[0] = level.gametype;
	var_00[1] = "dm";
	scripts\mp\_gameobjects::main(var_00);
	level.var_BDA7 = getdvarint("scr_mugger_timelimit",7);
	setdynamicdvar("scr_mugger_timeLimit",level.var_BDA7);
	scripts\mp\_utility::func_DF11("mugger",level.var_BDA7);
	level.var_BDA1 = getdvarint("scr_mugger_scorelimit",2500);
	if(level.var_BDA1 == 0)
	{
		level.var_BDA1 = 2500;
	}

	setdynamicdvar("scr_mugger_scoreLimit",level.var_BDA1);
	scripts\mp\_utility::func_DF0B("mugger",level.var_BDA1);
	level.var_BD7D = getdvarint("scr_mugger_bank_limit",10);
	level.var_BD9E = getdvarint("scr_mugger_muggernaut_window",3000);
	level.var_BD9D = getdvarint("scr_mugger_muggernaut_muggings_needed",3);
	level.var_BD9A = squared(getdvarfloat("mugger_min_spawn_dist",350));
	level.var_BD8D = getdvarint("scr_mugger_jackpot_limit",0);
	level.var_BD96 = getdvarfloat("scr_mugger_jackpot_wait_sec",10);
	level.var_BDA6 = getdvarfloat("scr_mugger_throwing_knife_mug_frac",1);
	level func_BD87();
	level thread func_BD9C();
	level thread func_BD9B();
	level.var_A42A = spawn("script_model",(0,0,0));
	level.var_A42A.origin = (0,0,0);
	level.var_A42A.angles = (90,0,0);
	level.var_A42A setmodel("lethal_smoke_grenade_wm");
	level.var_A42A hide();
	level.var_A42A.var_BD85 = 0;
	level thread func_BD97();
}

//Function Number: 5
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.var_1141D = 0;
		var_00.var_11A2F = 0;
		var_00.var_4D = var_00.var_11A2F;
		var_00.pers["assists"] = var_00.var_11A2F;
		var_00.var_150 = var_00.var_1141D;
		var_00.var_BDAA = [];
		if(isplayer(var_00) && !isbot(var_00))
		{
			var_00.var_58C3 = var_00 scripts\mp\_hud_util::createicon("hud_tagcount",48,48);
			var_00.var_58C3 scripts\mp\_hud_util::setpoint("TOP LEFT","TOP LEFT",200,0);
			var_00.var_58C3.alpha = 1;
			var_00.var_58C3.hidewheninmenu = 1;
			var_00.var_58C3.archived = 1;
			level thread func_8EC5(var_00.var_58C3);
			var_00.var_58C5 = var_00 scripts\mp\_hud_util::createfontstring("bigfixed",1);
			var_00.var_58C5 scripts\mp\_hud_util::setparent(var_00.var_58C3);
			var_00.var_58C5 scripts\mp\_hud_util::setpoint("CENTER","CENTER",-24);
			var_00.var_58C5 setvalue(var_00.var_1141D);
			var_00.var_58C5.alpha = 1;
			var_00.var_58C5.color = (1,1,0.5);
			var_00.var_58C5.var_153 = 1;
			var_00.var_58C5.sort = 1;
			var_00.var_58C5.hidewheninmenu = 1;
			var_00.var_58C5.archived = 1;
			var_00.var_58C5 scripts\mp\_hud::func_7251(3);
			level thread func_8EC5(var_00.var_58C5);
		}
	}
}

//Function Number: 6
onspawnplayer()
{
	self.var_BDAA = [];
	if(!isagent(self))
	{
		thread func_1370C();
	}
}

//Function Number: 7
func_8EC5(param_00)
{
	level waittill("game_ended");
	if(isdefined(param_00))
	{
		param_00.alpha = 0;
	}
}

//Function Number: 8
func_8136()
{
	var_00 = scripts\mp\_spawnlogic::func_81BA(self.pers["team"]);
	var_01 = scripts\mp\_spawnscoring::func_8136(var_00);
	return var_01;
	return var_01;
}

//Function Number: 9
func_C5CC(param_00)
{
	if(isdefined(param_00) && param_00 == "suicide")
	{
		level thread func_10849(self,self);
	}
}

//Function Number: 10
func_C55E(param_00,param_01,param_02,param_03,param_04)
{
	scripts\mp\gametypes\common::func_C55E(param_00,param_01,param_02,param_03,param_04);
	level thread func_10849(param_00,param_01);
}

//Function Number: 11
func_BD87()
{
	level.var_BD99 = getdvarint("scr_mugger_max_extra_tags",50);
	level.var_BD82 = [];
}

//Function Number: 12
func_10849(param_00,param_01)
{
	if(isagent(param_01))
	{
		param_01 = param_01.var_222;
	}

	var_02 = 0;
	var_03 = 0;
	if(isdefined(param_01))
	{
		if(param_00 == param_01)
		{
			if(param_00.var_1141D > 0)
			{
				var_02 = param_00.var_1141D;
				param_00.var_1141D = 0;
				param_00.var_150 = 0;
				if(isplayer(param_00) && !isbot(param_00))
				{
					param_00.var_58C5 setvalue(param_00.var_1141D);
					param_00.var_58C5 thread scripts\mp\_hud::func_7250(param_00);
					param_00 thread scripts\mp\_hud_message::func_10151("mugger_suicide",var_02);
				}
			}
		}
		else if(isdefined(param_00.var_24E5) && param_00.var_24E5.size > 0)
		{
			if(isplayer(param_01) && isdefined(param_00.var_24E5) && isdefined(param_01.var_86BD) && isdefined(param_00.var_24E5[param_01.var_86BD]))
			{
				var_04 = param_00.var_24E5[param_01.var_86BD];
				if(isdefined(var_04) && isdefined(var_04.var_24E7) && var_04.var_24E7 == param_01)
				{
					if(isdefined(var_04.var_10367) && var_04.var_10367 == "MOD_MELEE" || (var_04.var_394 == "throwingknife_mp" || var_04.var_394 == "throwingknifejugg_mp") && level.var_BDA6 > 0)
					{
						var_03 = 1;
						if(param_00.var_1141D > 0)
						{
							var_02 = param_00.var_1141D;
							if((var_04.var_394 == "throwingknife_mp" || var_04.var_394 == "throwingknifejugg_mp") && level.var_BDA6 < 1)
							{
								var_02 = int(ceil(param_00.var_1141D * level.var_BDA6));
							}

							param_00.var_1141D = param_00.var_1141D - var_02;
							param_00.var_150 = param_00.var_1141D;
							if(isplayer(param_00) && !isbot(param_00))
							{
								param_00.var_58C5 setvalue(param_00.var_1141D);
								param_00.var_58C5 thread scripts\mp\_hud::func_7250(param_00);
								param_00 thread scripts\mp\_hud_message::func_10151("callout_mugged",var_02);
								param_00 playlocalsound("mugger_got_mugged");
							}

							playsoundatpos(param_00.origin,"mugger_mugging");
							param_01 thread scripts\mp\_hud_message::func_10151("callout_mugger",var_02);
							if(var_04.var_394 == "throwingknife_mp" || var_04.var_394 == "throwingknifejugg_mp")
							{
								param_01 playlocalsound("mugger_you_mugged");
							}
						}

						param_01.var_BDAA[param_01.var_BDAA.size] = gettime();
						param_01 thread func_BD7F();
					}
				}
			}
		}
	}

	if(isagent(param_00))
	{
		var_05 = param_00.origin + (0,0,14);
		playsoundatpos(var_05,"mp_killconfirm_tags_drop");
		level notify("mugger_jackpot_increment");
		var_06 = func_BDA4(param_00.origin,40,160);
		var_06.var_13372 = param_00.var_222;
		if(isdefined(param_01) && param_00 != param_01)
		{
			var_06.var_4F = param_01;
		}
		else
		{
			var_06.var_4F = undefined;
		}

		return;
	}
	else if(isdefined(level.var_58C0[var_02.var_86BD]))
	{
		playfx(level.var_BD84["vanish"],level.var_58C0[var_02.var_86BD].var_4B2C);
		level.var_58C0[var_02.var_86BD] notify("reset");
	}
	else
	{
		var_07[0] = spawn("script_model",(0,0,0));
		var_07[0] setmodel("dogtags_iw7_foe");
		var_08 = spawn("trigger_radius",(0,0,0),0,32,32);
		var_08.var_336 = "trigger_dogtag";
		var_08 hide();
		level.var_58C0[var_02.var_86BD] = scripts\mp\_gameobjects::func_4A2E("any",var_08,var_07,(0,0,16));
		scripts\mp\_objpoints::func_51BC(level.var_58C0[var_02.var_86BD].var_C2C2["allies"]);
		scripts\mp\_objpoints::func_51BC(level.var_58C0[var_02.var_86BD].var_C2C2["axis"]);
		level.var_58C0[var_02.var_86BD] scripts\mp\_gameobjects::func_FB08(0);
		level.var_58C0[var_02.var_86BD].var_C5BB = ::func_C5BB;
		var_08.var_58BD = level.var_58C0[var_02.var_86BD];
		level.var_58C0[var_02.var_86BD].var_13372 = var_02;
		level.var_58C0[var_02.var_86BD].var_C2B5 = scripts\mp\objidpoolmanager::requestminimapid(99);
		if(level.var_58C0[var_02.var_86BD].var_C2B5 != -1)
		{
			scripts\mp\objidpoolmanager::minimap_objective_add(level.var_58C0[var_02.var_86BD].var_C2B5,"invisible",(0,0,0));
			scripts\mp\objidpoolmanager::minimap_objective_icon(level.var_58C0[var_02.var_86BD].var_C2B5,"waypoint_dogtags2");
		}

		level.var_58C0[var_02.var_86BD].visuals[0] scriptmodelplayanim("mp_dogtag_spin");
		level thread func_41C9(var_02);
	}

	var_05 = var_02.origin + (0,0,14);
	level.var_58C0[param_01.var_86BD].var_4B2C = var_06;
	level.var_58C0[param_01.var_86BD].trigger.origin = var_06;
	level.var_58C0[param_01.var_86BD].visuals[0].origin = var_06;
	level.var_58C0[param_01.var_86BD] scripts\mp\_gameobjects::initializetagpathvariables();
	level.var_58C0[param_01.var_86BD] scripts\mp\_gameobjects::func_1CAF("any");
	level.var_58C0[param_01.var_86BD].visuals[0] show();
	if(isdefined(var_02) && param_01 != var_02)
	{
		level.var_58C0[param_01.var_86BD].var_4F = var_02;
	}
	else
	{
		level.var_58C0[param_01.var_86BD].var_4F = undefined;
	}

	level.var_58C0[param_01.var_86BD] thread func_11901();
	if(var_03 < 5)
	{
		scripts\mp\objidpoolmanager::minimap_objective_position(level.var_58C0[param_01.var_86BD].var_C2B5,var_06);
		scripts\mp\objidpoolmanager::minimap_objective_state(level.var_58C0[param_01.var_86BD].var_C2B5,"active");
	}
	else
	{
		func_BDA3(var_06,"mugger_megadrop",var_03,param_01,var_02);
	}

	playsoundatpos(var_06,"mp_killconfirm_tags_drop");
	level.var_58C0[param_01.var_86BD].var_116BD = 0;
	if(var_03 == 0)
	{
		level notify("mugger_jackpot_increment");
	}

	var_09 = 0;
	while(var_06 < var_02)
	{
		var_09 = func_BDA4(param_00.origin,40,160);
		var_09.var_13372 = param_00;
		if(isdefined(param_01) && param_00 != param_01)
		{
			var_09.var_4F = param_01;
			continue;
		}

		var_09.var_4F = undefined;
		var_06++;
	}
}

//Function Number: 13
func_BDA2()
{
	level endon("game_ended");
	self endon("reset");
	self endon("reused");
	self endon("deleted");
	for(;;)
	{
		self.trigger waittill("trigger",var_00);
		if(!scripts\mp\_utility::func_9F19(var_00))
		{
			continue;
		}

		if(var_00 scripts\mp\_utility::func_9FC6() || isdefined(var_00.var_108DB))
		{
			continue;
		}

		if(isdefined(var_00.classname) && var_00.classname == "script_vehicle")
		{
			continue;
		}

		thread func_C5BB(var_00);
	}
}

//Function Number: 14
func_BD7C(param_00)
{
	var_01[0] = spawn("script_model",(0,0,0));
	var_01[0] setmodel("dogtags_iw7_foe");
	var_02 = spawn("trigger_radius",(0,0,0),0,32,32);
	var_02.var_336 = "trigger_dogtag";
	var_02 hide();
	level.var_BD82[param_00] = spawnstruct();
	var_03 = level.var_BD82[param_00];
	var_03.type = "useObject";
	var_03.var_4B2C = var_02.origin;
	var_03.var_664A = var_02 getentitynumber();
	var_03.trigger = var_02;
	var_03.triggertype = "proximity";
	var_03 scripts\mp\_gameobjects::func_1CAF("any");
	var_01[0].var_28AC = var_01[0].origin;
	var_03.visuals = var_01;
	var_03.var_C363 = (0,0,16);
	var_03.var_116BD = 1;
	var_03.var_A924 = 0;
	var_03.visuals[0] scriptmodelplayanim("mp_dogtag_spin");
	var_03 thread func_BDA2();
	return var_03;
}

//Function Number: 15
func_BD83()
{
	var_00 = undefined;
	var_01 = -1;
	foreach(var_03 in level.var_BD82)
	{
		if(var_03.interactteam == "none")
		{
			var_03.var_A924 = gettime();
			var_03.visuals[0] show();
			return var_03;
		}

		if(!isdefined(var_00) || var_03.var_A924 < var_01)
		{
			var_01 = var_03.var_A924;
			var_00 = var_03;
		}
	}

	if(level.var_BD82.size < level.var_BD99)
	{
		var_05 = func_BD7C(level.var_BD82.size);
		if(isdefined(var_05))
		{
			var_05.var_A924 = gettime();
			return var_05;
		}
	}

	var_00.var_A924 = gettime();
	var_00 notify("reused");
	playfx(level.var_BD84["vanish"],var_00.var_4B2C);
	return var_00;
}

//Function Number: 16
func_BDA4(param_00,param_01,param_02)
{
	var_03 = func_BD83();
	var_04 = param_00 + (0,0,14);
	var_05 = (0,randomfloat(360),0);
	var_06 = anglestoforward(var_05);
	var_07 = randomfloatrange(40,160);
	var_08 = var_04 + var_07 * var_06;
	var_08 = var_08 + (0,0,40);
	var_09 = playerphysicstrace(var_04,var_08);
	var_04 = var_09;
	var_08 = var_04 + (0,0,-100);
	var_09 = playerphysicstrace(var_04,var_08);
	if(var_09[2] != var_08[2])
	{
		var_09 = var_09 + (0,0,14);
	}

	var_03.var_4B2C = var_09;
	var_03.trigger.origin = var_09;
	var_03.visuals[0].origin = var_09;
	var_03 scripts\mp\_gameobjects::initializetagpathvariables();
	var_03 scripts\mp\_gameobjects::func_1CAF("any");
	var_03 thread func_BDA2();
	var_03 thread func_11901();
	return var_03;
}

//Function Number: 17
func_BDA3(param_00,param_01,param_02,param_03,param_04)
{
	level notify("mugger_tag_pile",param_00);
	var_05 = scripts\mp\objidpoolmanager::requestminimapid(99);
	if(var_05 != -1)
	{
		scripts\mp\objidpoolmanager::minimap_objective_add(var_05,"active",param_00);
		scripts\mp\objidpoolmanager::minimap_objective_icon(var_05,"waypoint_dogtag_pile");
	}

	level scripts\common\utility::func_5127(5,::func_BDA0,var_05);
	if(param_02 >= 10)
	{
		level.var_BD98 = gettime();
		level.var_BD8E = 0;
		foreach(var_07 in level.players)
		{
			var_07 playsoundtoplayer("mp_defcon_one",var_07);
			if(isdefined(param_03) && var_07 == param_03)
			{
				continue;
			}

			if(isdefined(param_04) && var_07 == param_04)
			{
				continue;
			}

			var_07 thread scripts\mp\_hud_message::func_10151(param_01,param_02);
		}

		var_09 = newhudelem();
		var_09 setshader("waypoint_dogtag_pile",10,10);
		var_09 setwaypoint(0,1,0,0);
		var_09.x = param_00[0];
		var_09.y = param_00[1];
		var_09.var_3A6 = param_00[2] + 32;
		var_09.alpha = 1;
		var_09 fadeovertime(5);
		var_09.alpha = 0;
		var_09 scripts\common\utility::func_5127(5,::func_917D);
	}
}

//Function Number: 18
func_917D()
{
	if(isdefined(self))
	{
		self destroy();
	}
}

//Function Number: 19
func_BD9C()
{
	level endon("game_ended");
	for(;;)
	{
		var_00 = getentarray("remote_tank","targetname");
		var_01 = getentarray("trigger_dogtag","targetname");
		foreach(var_03 in level.players)
		{
			if(isdefined(var_03.var_13106) && var_03.var_13106 == 1)
			{
				foreach(var_05 in var_00)
				{
					if(isdefined(var_05) && isdefined(var_05.var_222) && var_05.var_222 == var_03)
					{
						foreach(var_07 in var_01)
						{
							if(isdefined(var_07) && isdefined(var_07.var_58BD))
							{
								if(isdefined(var_07.var_58BD.interactteam) && var_07.var_58BD.interactteam != "none")
								{
									if(var_05 istouching(var_07))
									{
										var_07.var_58BD func_C5BB(var_05.var_222);
									}
								}
							}
						}
					}
				}
			}
		}

		wait(0.2);
	}
}

//Function Number: 20
func_BD9B()
{
	level endon("game_ended");
	for(;;)
	{
		var_00 = getentarray("trigger_dogtag","targetname");
		foreach(var_02 in level.players)
		{
			if(isdefined(var_02) && isdefined(var_02.var_DF8A))
			{
				foreach(var_04 in var_00)
				{
					if(isdefined(var_04) && isdefined(var_04.var_58BD))
					{
						if(isdefined(var_04.var_58BD.interactteam) && var_04.var_58BD.interactteam != "none")
						{
							if(var_02.var_DF8A istouching(var_04))
							{
								var_04.var_58BD func_C5BB(var_02);
							}
						}
					}
				}
			}
		}

		wait(0.2);
	}
}

//Function Number: 21
func_BD7F()
{
	level endon("game_ended");
	self endon("disconnect");
	self notify("checking_muggernaut");
	self endon("checking_muggernaut");
	wait(2);
	if(self.var_BDAA.size < level.var_BD9D)
	{
		return;
	}

	var_00 = self.var_BDAA[self.var_BDAA.size - 1];
	var_01 = var_00 - level.var_BD9E;
	var_02 = [];
	foreach(var_04 in self.var_BDAA)
	{
		if(var_04 >= var_01)
		{
			var_02[var_02.size] = var_04;
		}
	}

	if(var_02.size >= level.var_BD9D)
	{
		thread scripts\mp\_utility::func_83B4("muggernaut");
		func_BD7E(1,1);
		self.var_BDAA = [];
		return;
	}

	self.var_BDAA = var_02;
}

//Function Number: 22
func_BDA0(param_00)
{
	scripts\mp\objidpoolmanager::returnminimapid(param_00);
}

//Function Number: 23
func_12D9(param_00)
{
	self hide();
	foreach(var_02 in level.players)
	{
		if(var_02 != param_00)
		{
			self showtoplayer(var_02);
		}
	}
}

//Function Number: 24
func_C5BB(param_00)
{
	if(isdefined(param_00.var_222))
	{
		param_00 = param_00.var_222;
	}

	if(self.var_116BD)
	{
		self.trigger playsound("mp_killconfirm_tags_deny");
	}
	else if(isdefined(self.var_4F) && param_00 == self.var_4F)
	{
		self.trigger playsound("mp_killconfirm_tags_pickup");
		param_00 scripts\mp\_utility::func_93DF("confirmed",1);
		param_00 scripts\mp\_persistence::func_10E56("round","confirmed",param_00.pers["confirmed"]);
	}
	else
	{
		self.trigger playsound("mp_killconfirm_tags_deny");
		param_00 scripts\mp\_utility::func_93DF("denied",1);
		param_00 scripts\mp\_persistence::func_10E56("round","denied",param_00.pers["denied"]);
	}

	param_00 thread func_C566();
	func_E277(1);
}

//Function Number: 25
func_C566()
{
	level endon("game_ended");
	self endon("disconnect");
	while(!isdefined(self.pers))
	{
		wait(0.05);
	}

	thread func_BD80();
}

//Function Number: 26
func_BD80()
{
	self notify("banking");
	self endon("banking");
	level endon("banking_all");
	self.var_1141D++;
	self.var_150 = self.var_1141D;
	if(isplayer(self) && !isbot(self))
	{
		self.var_58C5 setvalue(self.var_1141D);
		self.var_58C5 thread scripts\mp\_hud::func_7250(self);
	}

	wait(1.5);
	var_00 = level.var_BD7D - self.var_1141D;
	if(var_00 > 0 && var_00 <= 5)
	{
		var_01 = undefined;
		switch(var_00)
		{
			case 1:
				var_01 = "mugger_1more";
				break;

			case 2:
				var_01 = "mugger_2more";
				break;

			case 3:
				var_01 = "mugger_3more";
				break;

			case 4:
				var_01 = "mugger_4more";
				break;

			case 5:
				var_01 = "mugger_5more";
				break;
		}

		if(isdefined(var_01))
		{
			self playsoundtoplayer(var_01,self);
		}
	}

	wait(0.5);
	func_BD7E(0);
}

//Function Number: 27
func_BD7E(param_00,param_01)
{
	var_02 = 0;
	if(param_00 == 1)
	{
		var_02 = self.var_1141D;
	}
	else
	{
		var_03 = self.var_1141D % level.var_BD7D;
		var_02 = self.var_1141D - var_03;
	}

	if(var_02 > 0)
	{
		self.var_11421 = var_02;
		if(!isdefined(param_01))
		{
			thread scripts\mp\_hud_message::func_10151("callout_tags_banked",var_02);
		}

		thread scripts\mp\_utility::func_83B4("tags_banked",undefined,self.var_11421 * scripts\mp\_rank::func_8104("kill_confirmed"));
		self.var_11A2F = self.var_11A2F + var_02;
		self.var_1141D = self.var_1141D - var_02;
		self.var_150 = self.var_1141D;
		if(isplayer(self) && !isbot(self))
		{
			self.var_58C5 setvalue(self.var_1141D);
			self.var_58C5 thread scripts\mp\_hud::func_7250(self);
		}

		self.var_4D = self.var_11A2F;
		self.pers["assists"] = self.var_11A2F;
	}
}

//Function Number: 28
func_C579(param_00,param_01)
{
	if(param_00 == "tags_banked" && isdefined(param_01) && isdefined(param_01.var_11421) && param_01.var_11421 > 0)
	{
		var_02 = param_01.var_11421 * scripts\mp\_rank::func_8104("kill_confirmed");
		param_01.var_11421 = 0;
		return var_02;
	}

	return 0;
}

//Function Number: 29
func_E277(param_00)
{
	if(!param_00)
	{
		level notify("mugger_jackpot_increment");
	}

	self.var_4F = undefined;
	self notify("reset");
	self.visuals[0] hide();
	self.var_4B2C = (0,0,1000);
	self.trigger.origin = (0,0,1000);
	self.visuals[0].origin = (0,0,1000);
	scripts\mp\_gameobjects::func_1CAF("none");
	if(isdefined(self.var_A428) && self.var_A428 == 1)
	{
		level.var_BD92--;
	}

	if(!self.var_116BD)
	{
		scripts\mp\objidpoolmanager::minimap_objective_state(self.var_C2B5,"invisible");
	}
}

//Function Number: 30
func_11901()
{
	level endon("game_ended");
	self endon("death");
	self endon("deleted");
	self endon("reset");
	self endon("reused");
	self notify("timeout_start");
	self endon("timeout_start");
	level scripts\mp\_hostmigration::func_13708(27);
	var_00 = 3;
	while(var_00 > 0)
	{
		self.visuals[0] hide();
		wait(0.25);
		self.visuals[0] show();
		wait(0.25);
		var_00 = var_00 - 0.5;
	}

	playfx(level.var_BD84["vanish"],self.var_4B2C);
	thread func_E277(0);
}

//Function Number: 31
func_41C9(param_00)
{
	level endon("game_ended");
	var_01 = param_00.var_86BD;
	param_00 waittill("disconnect");
	if(isdefined(level.var_58C0[var_01]))
	{
		level.var_58C0[var_01] scripts\mp\_gameobjects::func_1CAF("none");
		playfx(level.var_BD84["vanish"],level.var_58C0[var_01].var_4B2C);
		level.var_58C0[var_01] notify("reset");
		wait(0.05);
		if(isdefined(level.var_58C0[var_01]))
		{
			scripts\mp\objidpoolmanager::returnminimapid(level.var_58C0[var_01].var_C2B5);
			level.var_58C0[var_01].trigger delete();
			for(var_02 = 0;var_02 < level.var_58C0[var_01].visuals.size;var_02++)
			{
				level.var_58C0[var_01].visuals[var_02] delete();
			}

			level.var_58C0[var_01] notify("deleted");
			level.var_58C0[var_01] = undefined;
		}
	}
}

//Function Number: 32
func_C5B2()
{
	level notify("banking_all");
	foreach(var_01 in level.players)
	{
		var_01 func_BD7E(1);
	}

	wait(0.1);
	scripts\mp\_gamelogic::func_500A();
}

//Function Number: 33
func_BD97()
{
	level endon("game_ended");
	level endon("jackpot_stop");
	if(level.var_BD8D <= 0)
	{
		return;
	}

	level.var_BD8E = 0;
	level.var_BD93 = 0;
	level.var_BD8E = 0;
	level thread func_BD95();
	for(;;)
	{
		level waittill("mugger_jackpot_increment");
		var_00 = 1;
		if(var_00)
		{
			level.var_BD8E++;
			var_01 = clamp(float(level.var_BD8E / level.var_BD8D),0,1);
			if(level.var_BD8E >= level.var_BD8D)
			{
				if(isdefined(level.var_BD94))
				{
					level.var_BD94 thread scripts\mp\_hud::func_7250(level.players[0]);
				}

				level.var_BD8E = 15 + randomintrange(0,3) * 5;
				level thread func_BD8A();
				break;
			}
		}
	}
}

//Function Number: 34
func_BD95()
{
	level endon("game_ended");
	level endon("jackpot_stop");
	scripts\mp\_utility::func_7670("prematch_done");
	for(;;)
	{
		wait(level.var_BD96);
		level notify("mugger_jackpot_increment");
	}
}

//Function Number: 35
func_BD8A()
{
	level endon("game_ended");
	level notify("reset_airdrop");
	level endon("reset_airdrop");
	var_00 = level.var_BD81[level.script][randomint(level.var_BD81[level.script].size)];
	var_00 = var_00 + (randomintrange(-50,50),randomintrange(-50,50),0);
	for(;;)
	{
		var_01 = level.players[0];
		var_02 = 1;
		if(isdefined(var_01) && scripts\mp\_utility::func_4BD7() < scripts\mp\_utility::func_B4D2() && level.var_6BAA + var_02 < scripts\mp\_utility::func_B4D2() && level.var_C223 < 8)
		{
			foreach(var_04 in level.players)
			{
				var_04 thread scripts\mp\_hud_message::func_10151("mugger_jackpot_incoming");
			}

			scripts\mp\_utility::func_93FA();
			level thread scripts\mp\killstreaks\_airdrop::func_5857(var_01,var_00,randomfloat(360),"airdrop_mugger",0,"airdrop_jackpot");
			break;
		}
		else
		{
			wait(0.5);
			continue;
		}
	}

	level.var_BD93 = level.var_BD8E;
	level thread func_BD91(var_00);
}

//Function Number: 36
func_BD8F(param_00,param_01,param_02)
{
	if(!isdefined(level.var_A42C))
	{
		level.var_A42C = scripts\mp\objidpoolmanager::requestminimapid(99);
		if(level.var_A42C != -1)
		{
			scripts\mp\objidpoolmanager::minimap_objective_add(level.var_A42C,"active",param_00);
			scripts\mp\objidpoolmanager::minimap_objective_icon(level.var_A42C,"waypoint_jackpot");
		}
	}
	else if(level.var_A42C != -1)
	{
		scripts\mp\objidpoolmanager::minimap_objective_position(level.var_A42C,param_00);
	}

	if(param_02 >= 10)
	{
		foreach(var_04 in level.players)
		{
			var_04 playlocalsound(game["music"]["victory_" + var_04.pers["team"]]);
		}

		if(!isdefined(level.var_A42B))
		{
			level.var_A42B = newhudelem();
			level.var_A42B setshader("waypoint_jackpot",64,64);
			level.var_A42B setwaypoint(0,1,0,0);
		}

		level.var_A42B.x = param_00[0];
		level.var_A42B.y = param_00[1];
		level.var_A42B.var_3A6 = param_00[2] + 12;
		level.var_A42B.alpha = 0.75;
	}
}

//Function Number: 37
func_BD90()
{
	if(level.var_A42C != -1)
	{
		scripts\mp\objidpoolmanager::minimap_objective_state(level.var_A42C,"invisible");
	}

	level.var_A42B fadeovertime(2);
	level.var_A42B.alpha = 0;
	level.var_A42B scripts\common\utility::func_5127(2,::func_917D);
}

//Function Number: 38
func_BD8B(param_00)
{
	func_BD8C();
	var_01 = param_00 + (0,0,30);
	var_02 = param_00 + (0,0,-1000);
	var_03 = bullettrace(var_01,var_02,0,undefined);
	level.var_A42A.origin = var_03["position"] + (0,0,1);
	level.var_A42A show();
	var_04 = vectortoangles(var_03["normal"]);
	var_05 = anglestoforward(var_04);
	var_06 = anglestoright(var_04);
	thread func_108CD(var_03["position"],var_05,var_06,0.5);
	wait(0.1);
	playfxontag(level.var_BD84["smoke"],level.var_A42A,"tag_fx");
	foreach(var_08 in level.players)
	{
		var_08.var_BD85 = 1;
	}

	level.var_A42A.var_BD85 = 1;
}

//Function Number: 39
func_BD8C()
{
	stopfxontag(level.var_BD84["smoke"],level.var_A42A,"tag_fx");
	level.var_A42A hide();
	if(isdefined(level.var_A429))
	{
		level.var_A429 delete();
	}

	if(level.var_A42A.var_BD85)
	{
		level.var_A42A.var_BD85 = 0;
		stopfxontag(level.var_BD84["smoke"],level.var_A42A,"tag_fx");
		wait(0.05);
	}
}

//Function Number: 40
func_108CD(param_00,param_01,param_02,param_03)
{
	if(isdefined(level.var_A429))
	{
		level.var_A429 delete();
	}

	wait(param_03);
	level.var_A429 = spawnfx(level.var_BDA5,param_00,param_01,param_02);
	triggerfx(level.var_A429);
}

//Function Number: 41
func_1370C()
{
	level endon("game_ended");
	self endon("disconnect");
	scripts\mp\_utility::func_7670("prematch_done");
	wait(0.5);
	if(level.var_A42A.var_BD85 == 1 && !isdefined(self.var_BD85))
	{
		playfxontagforclients(level.var_BD84["smoke"],level.var_A42A,"tag_fx",self);
		self.var_BD85 = 1;
	}
}

//Function Number: 42
func_BD91(param_00)
{
	level endon("game_ended");
	level endon("jackpot_timeout");
	level notify("jackpot_stop");
	func_BD8F(param_00,"mugger_jackpot",level.var_BD93);
	level thread func_BD8B(param_00);
	level thread func_BD88(30);
	level waittill("airdrop_jackpot_landed",param_00);
	if(level.var_A42C != -1)
	{
		scripts\mp\objidpoolmanager::minimap_objective_position(level.var_A42C,param_00);
	}

	level.var_A42B.x = param_00[0];
	level.var_A42B.y = param_00[1];
	level.var_A42B.var_3A6 = param_00[2] + 32;
	foreach(var_02 in level.players)
	{
		var_02 playsoundtoplayer("mp_defcon_one",var_02);
		var_02 thread scripts\mp\_hud_message::func_10151("mugger_jackpot",level.var_BD93);
	}

	level.var_BD92 = 0;
	while(level.var_BD93 > 0)
	{
		if(level.var_BD92 < 10)
		{
			level.var_BD93--;
			var_04 = func_BDA4(param_00,0,400);
			var_04.var_A428 = 1;
			level.var_BD92++;
			level thread func_BD88(90);
			wait(0.1);
			continue;
		}

		wait(0.5);
	}

	level.var_BD8E = 0;
	while(level.var_BD92 > 0)
	{
		wait(1);
	}

	func_BD89();
}

//Function Number: 43
func_BD89()
{
	level notify("jackpot_cleanup");
	func_BD90();
	func_BD8C();
	level thread func_BD97();
}

//Function Number: 44
func_BD88(param_00)
{
	level endon("jackpot_cleanup");
	level notify("jackpot_abort_after_time");
	level endon("jackpot_abort_after_time");
	wait(param_00);
	level notify("jackpot_timeout");
}

//Function Number: 45
func_49F2(param_00,param_01)
{
	scripts\mp\killstreaks\_airdrop::func_17BF("airdrop_mugger","airdrop_jackpot",1,::func_BDA8);
}

//Function Number: 46
func_BDA8(param_00)
{
	self endon("death");
	level notify("airdrop_jackpot_landed",self.origin);
	wait(0.5);
	scripts\mp\killstreaks\_airdrop::func_51AA();
}

//Function Number: 47
func_49A7()
{
	level.var_BD81 = [];
	var_00 = undefined;
	if(isdefined(var_00) && var_00.size)
	{
		var_01 = 0;
		foreach(var_03 in var_00)
		{
			level.var_BD81[level.script][var_01] = var_03.origin;
			var_01++;
		}

		return;
	}

	level.var_BD81["mp_seatown"][0] = (-665,-209,226);
	level.var_BD81["mp_seatown"][1] = (-2225,1573,260);
	level.var_BD81["mp_seatown"][2] = (1275,-747,292);
	level.var_BD81["mp_seatown"][3] = (1210,963,225);
	level.var_BD81["mp_seatown"][4] = (-2343,-811,226);
	level.var_BD81["mp_seatown"][5] = (-1125,-1610,184);
	level.var_BD81["mp_dome"][0] = (649,1096,-250);
	level.var_BD81["mp_dome"][1] = (953,-501,-328);
	level.var_BD81["mp_dome"][2] = (-37,2099,-231);
	level.var_BD81["mp_dome"][3] = (-716,1100,-296);
	level.var_BD81["mp_dome"][4] = (-683,-51,-352);
	level.var_BD81["mp_plaza2"][0] = (266,-212,708);
	level.var_BD81["mp_plaza2"][1] = (295,1842,668);
	level.var_BD81["mp_plaza2"][2] = (-1449,1833,692);
	level.var_BD81["mp_plaza2"][3] = (835,-1815,668);
	level.var_BD81["mp_plaza2"][4] = (-1116,76,729);
	level.var_BD81["mp_plaza2"][5] = (-399,951,676);
	level.var_BD81["mp_mogadishu"][0] = (552,1315,8);
	level.var_BD81["mp_mogadishu"][1] = (990,3248,144);
	level.var_BD81["mp_mogadishu"][2] = (-879,2643,135);
	level.var_BD81["mp_mogadishu"][3] = (-68,-995,16);
	level.var_BD81["mp_mogadishu"][4] = (1499,-1206,15);
	level.var_BD81["mp_mogadishu"][5] = (2387,1786,61);
	level.var_BD81["mp_paris"][0] = (-150,-80,63);
	level.var_BD81["mp_paris"][1] = (-947,-1088,107);
	level.var_BD81["mp_paris"][2] = (1052,-614,50);
	level.var_BD81["mp_paris"][3] = (1886,648,24);
	level.var_BD81["mp_paris"][4] = (628,2096,30);
	level.var_BD81["mp_paris"][5] = (-2033,1082,308);
	level.var_BD81["mp_paris"][6] = (-1230,1836,295);
	level.var_BD81["mp_exchange"][0] = (904,441,-77);
	level.var_BD81["mp_exchange"][1] = (-1056,1435,141);
	level.var_BD81["mp_exchange"][2] = (800,1543,148);
	level.var_BD81["mp_exchange"][3] = (2423,1368,141);
	level.var_BD81["mp_exchange"][4] = (596,-1870,89);
	level.var_BD81["mp_exchange"][5] = (-1241,-821,30);
	level.var_BD81["mp_bootleg"][0] = (-444,-114,-8);
	level.var_BD81["mp_bootleg"][1] = (1053,-1051,-13);
	level.var_BD81["mp_bootleg"][2] = (889,1184,-28);
	level.var_BD81["mp_bootleg"][3] = (-994,1877,-41);
	level.var_BD81["mp_bootleg"][4] = (-1707,-1333,63);
	level.var_BD81["mp_bootleg"][5] = (-334,-2155,61);
	level.var_BD81["mp_carbon"][0] = (-1791,-3892,3813);
	level.var_BD81["mp_carbon"][1] = (-338,-4978,3964);
	level.var_BD81["mp_carbon"][2] = (-82,-2941,3990);
	level.var_BD81["mp_carbon"][3] = (-3198,-2829,3809);
	level.var_BD81["mp_carbon"][4] = (-3673,-3893,3610);
	level.var_BD81["mp_carbon"][5] = (-2986,-4863,3648);
	level.var_BD81["mp_hardhat"][0] = (1187,-322,238);
	level.var_BD81["mp_hardhat"][1] = (2010,-1379,357);
	level.var_BD81["mp_hardhat"][2] = (1615,1245,366);
	level.var_BD81["mp_hardhat"][3] = (-371,825,436);
	level.var_BD81["mp_hardhat"][4] = (-820,-927,348);
	level.var_BD81["mp_alpha"][0] = (-239,1315,52);
	level.var_BD81["mp_alpha"][1] = (-1678,-219,55);
	level.var_BD81["mp_alpha"][2] = (235,-369,60);
	level.var_BD81["mp_alpha"][3] = (-201,2138,60);
	level.var_BD81["mp_alpha"][4] = (-1903,2433,198);
	level.var_BD81["mp_village"][0] = (990,-821,331);
	level.var_BD81["mp_village"][1] = (658,2155,337);
	level.var_BD81["mp_village"][2] = (-559,1882,310);
	level.var_BD81["mp_village"][3] = (-1999,1184,343);
	level.var_BD81["mp_village"][4] = (215,-2875,384);
	level.var_BD81["mp_village"][5] = (1731,-483,290);
	level.var_BD81["mp_lambeth"][0] = (712,217,-196);
	level.var_BD81["mp_lambeth"][1] = (1719,-1095,-196);
	level.var_BD81["mp_lambeth"][2] = (2843,1034,-269);
	level.var_BD81["mp_lambeth"][3] = (1251,2645,-213);
	level.var_BD81["mp_lambeth"][4] = (-1114,1301,-200);
	level.var_BD81["mp_lambeth"][5] = (-693,-823,-132);
	level.var_BD81["mp_radar"][0] = (-5052,2371,1223);
	level.var_BD81["mp_radar"][1] = (-4550,4199,1268);
	level.var_BD81["mp_radar"][2] = (-7149,4449,1376);
	level.var_BD81["mp_radar"][3] = (-6350,1528,1302);
	level.var_BD81["mp_radar"][4] = (-3333,992,1222);
	level.var_BD81["mp_radar"][5] = (-4040,-361,1222);
	level.var_BD81["mp_interchange"][0] = (662,-513,142);
	level.var_BD81["mp_interchange"][1] = (674,1724,112);
	level.var_BD81["mp_interchange"][2] = (-1003,1103,30);
	level.var_BD81["mp_interchange"][3] = (385,-2910,209);
	level.var_BD81["mp_interchange"][4] = (2004,-1760,144);
	level.var_BD81["mp_interchange"][5] = (2458,-300,147);
	level.var_BD81["mp_underground"][0] = (31,1319,-196);
	level.var_BD81["mp_underground"][1] = (165,-940,60);
	level.var_BD81["mp_underground"][2] = (-747,143,4);
	level.var_BD81["mp_underground"][3] = (-1671,1666,-216);
	level.var_BD81["mp_underground"][4] = (-631,3158,-68);
	level.var_BD81["mp_underground"][5] = (500,2865,-89);
	level.var_BD81["mp_bravo"][0] = (-39,-119,1280);
	level.var_BD81["mp_bravo"][1] = (1861,-563,1229);
	level.var_BD81["mp_bravo"][2] = (-1548,-366,1007);
	level.var_BD81["mp_bravo"][3] = (-678,1272,1273);
	level.var_BD81["mp_bravo"][4] = (1438,842,1272);
}