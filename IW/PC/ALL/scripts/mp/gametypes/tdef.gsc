/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\gametypes\tdef.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 903 ms
 * Timestamp: 10/27/2023 12:13:12 AM
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
		setdynamicdvar("scr_tdef_possessionResetCondition",1);
		setdynamicdvar("scr_tdef_possessionResetTime",60);
		level.var_B40C = 1;
		level.var_B40A = 0;
		level.var_B410 = 0;
	}

	level.var_3AEC = 100;
	level.var_EB50 = 1;
	func_12E9F();
	level.teambased = 1;
	level.var_C5A4 = ::func_C5A4;
	level.var_8136 = ::func_8136;
	level.var_C577 = ::func_C577;
	level.var_C583 = ::func_80E9;
	level.var_27FC = 1;
	level.var_27C6 = [];
	level.var_2800 = [];
	level.var_27D2 = [];
	level.var_EC39 = 0;
	level.var_27F9 = 0;
	if(level.var_B40A || level.var_B410)
	{
		level.var_B93A = ::scripts\mp\_damage::func_7678;
	}

	game["dialog"]["gametype"] = "team_defender";
	if(getdvarint("g_hardcore"))
	{
		game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
	}

	game["strings"]["overtime_hint"] = &"MP_FIRST_BLOOD";
	game["dialog"]["drone_reset"] = "defender_obj_respawned";
	game["dialog"]["ally_own_drone"] = "tdef_ally_own_drone";
	game["dialog"]["enemy_own_drone"] = "tdef_enemy_own_drone";
	game["dialog"]["ally_throw_score"] = "ally_throw_score";
	game["dialog"]["ally_carry_score"] = "ally_carry_score";
	game["dialog"]["enemy_throw_score"] = "enemy_throw_score";
	game["dialog"]["enemy_carry_score"] = "enemy_carry_score";
	game["dialog"]["pass_complete"] = "friendly_pass";
	game["dialog"]["pass_intercepted"] = "tdef_pass_intercepted";
	game["dialog"]["ally_drop_drone"] = "tdef_ally_drop_drone";
	game["dialog"]["enemy_drop_drone"] = "tdef_enemy_drop_drone";
	game["dialog"]["drone_reset_soon"] = "team_defender_reset";
	game["bomb_dropped_sound"] = "mp_uplink_ball_pickedup_enemy";
	game["bomb_recovered_sound"] = "mp_uplink_ball_pickedup_friendly";
	game["dialog"]["offense_obj"] = "capture_obj";
	game["dialog"]["defense_obj"] = "capture_obj";
	thread func_C56E();
}

//Function Number: 2
func_987C()
{
	scripts\mp\_utility::func_F69D();
	setdynamicdvar("scr_tdef_scoringTime",getmatchrulesdata("tdefData","scoringTime"));
	setdynamicdvar("scr_tdef_scorePerTick",getmatchrulesdata("tdefData","scorePerTick"));
	setdynamicdvar("scr_tdef_carrierBonusTime",getmatchrulesdata("tdefData","carrierBonusTime"));
	setdynamicdvar("scr_tdef_carrierBonusScore",getmatchrulesdata("tdefData","carrierBonusScore"));
	setdynamicdvar("scr_tdef_delayplayer",getmatchrulesdata("tdefData","delayPlayer"));
	setdynamicdvar("scr_tdef_spawndelay",getmatchrulesdata("tdefData","spawnDelay"));
	setdynamicdvar("scr_tdef_ballActivationDelay",getmatchrulesdata("tdefData","ballActivationDelay"));
	setdynamicdvar("scr_tdef_possessionResetCondition",getmatchrulesdata("ballCommonData","possessionResetCondition"));
	setdynamicdvar("scr_tdef_possessionResetTime",getmatchrulesdata("ballCommonData","possessionResetTime"));
	setdynamicdvar("scr_tdef_idleResetTime",getmatchrulesdata("ballCommonData","idleResetTime"));
	setdynamicdvar("scr_tdef_explodeOnExpire",getmatchrulesdata("ballCommonData","explodeOnExpire"));
	setdynamicdvar("scr_tdef_armorMod",getmatchrulesdata("ballCommonData","armorMod"));
	setdynamicdvar("scr_tdef_showEnemyCarrier",getmatchrulesdata("ballCommonData","showEnemyCarrier"));
	setdynamicdvar("scr_tdef_halftime",0);
	scripts\mp\_utility::func_DEF4("tdef",0);
	setdynamicdvar("scr_tdef_promode",0);
}

//Function Number: 3
func_C5A4()
{
	setclientnamemode("auto_change");
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

	scripts\mp\_utility::func_F7C1("allies",&"OBJECTIVES_TDEF");
	scripts\mp\_utility::func_F7C1("axis",&"OBJECTIVES_TDEF");
	if(level.splitscreen)
	{
		scripts\mp\_utility::func_F7C0("allies",&"OBJECTIVES_TDEF");
		scripts\mp\_utility::func_F7C0("axis",&"OBJECTIVES_TDEF");
	}
	else
	{
		scripts\mp\_utility::func_F7C0("allies",&"OBJECTIVES_TDEF_SCORE");
		scripts\mp\_utility::func_F7C0("axis",&"OBJECTIVES_TDEF_SCORE");
	}

	scripts\mp\_utility::func_F7BE("allies",&"OBJECTIVES_TDEF_ATTACKER_HINT");
	scripts\mp\_utility::func_F7BE("axis",&"OBJECTIVES_TDEF_ATTACKER_HINT");
	func_49B4();
	scripts\mp\gametypes\obj_ball::func_2782();
	scripts\mp\gametypes\obj_ball::func_279C();
	scripts\mp\gametypes\obj_ball::func_277F();
	scripts\mp\gametypes\obj_ball::func_27C4(0);
	thread scripts\mp\gametypes\obj_ball::hideballsongameended();
	thread baseeffectwatchgameended();
	func_98CE();
	var_02[0] = level.gametype;
	var_02[1] = "tdm";
	var_02[2] = "ball";
	scripts\mp\_gameobjects::main(var_02);
	func_1159E();
	if(level.var_D6AF != 0)
	{
		scripts\mp\gametypes\obj_ball::func_97D6();
	}
}

//Function Number: 4
func_12E9F()
{
	scripts\mp\gametypes\common::func_12E9F();
	level.var_EC54 = scripts\mp\_utility::dvarfloatvalue("scoringTime",1,1,10);
	level.var_EC41 = scripts\mp\_utility::dvarintvalue("scorePerTick",1,1,25);
	level.var_3AEE = scripts\mp\_utility::dvarfloatvalue("carrierBonusTime",4,0,10);
	level.var_3AED = scripts\mp\_utility::dvarintvalue("carrierBonusScore",25,0,250);
	level.var_5117 = scripts\mp\_utility::dvarintvalue("delayPlayer",1,0,1);
	level.var_10846 = scripts\mp\_utility::dvarfloatvalue("spawnDelay",2.5,0,30);
	level.var_27D1 = scripts\mp\_utility::dvarfloatvalue("ballActivationDelay",10,0,30);
	level.var_D6AF = scripts\mp\_utility::dvarintvalue("possessionResetCondition",0,0,2);
	level.var_D6B0 = scripts\mp\_utility::dvarfloatvalue("possessionResetTime",0,0,150);
	level.var_69A1 = scripts\mp\_utility::dvarintvalue("explodeOnExpire",0,0,1);
	level.var_92F7 = scripts\mp\_utility::dvarfloatvalue("idleResetTime",15,0,60);
	level.var_218A = scripts\mp\_utility::dvarfloatvalue("armorMod",1,0,2);
	level.var_10120 = scripts\mp\_utility::dvarintvalue("showEnemyCarrier",5,0,6);
	level.var_3AEC = int(level.var_3AEC * level.var_218A);
}

//Function Number: 5
func_98CE()
{
	level.var_108E4 = (0,0,0);
	level.var_108E2 = (0,0,0);
	scripts\mp\_spawnlogic::func_F62D("TDef");
	scripts\mp\_spawnlogic::func_182D("mp_ball_spawn_allies_start");
	scripts\mp\_spawnlogic::func_182D("mp_ball_spawn_axis_start");
	scripts\mp\_spawnlogic::func_1829("allies","mp_tdm_spawn");
	scripts\mp\_spawnlogic::func_1829("allies","mp_tdm_spawn_secondary",1,1);
	scripts\mp\_spawnlogic::func_1829("axis","mp_tdm_spawn");
	scripts\mp\_spawnlogic::func_1829("axis","mp_tdm_spawn_secondary",1,1);
	level.var_B32E = scripts\mp\_spawnlogic::func_6CAF(level.var_108E4,level.var_108E2);
	function_01B4(level.var_B32E);
	foreach(var_01 in level.var_108FB)
	{
		func_371E(var_01);
	}
}

//Function Number: 6
func_371E(param_00)
{
	param_00.var_571E = undefined;
	var_01 = function_00C0(param_00.origin,level.var_27C6[0].var_862F,1000);
	if(var_01 < 0)
	{
		var_01 = scripts\common\utility::func_56F4(param_00.origin,level.var_27C6[0].var_862F);
	}
	else
	{
		var_01 = var_01 * var_01;
	}

	param_00.var_571E = var_01;
}

//Function Number: 7
func_8136()
{
	var_00 = self.pers["team"];
	if(game["switchedsides"])
	{
		var_00 = scripts\mp\_utility::getotherteam(var_00);
	}

	if(scripts\mp\_spawnlogic::func_100BA())
	{
		var_01 = scripts\mp\_spawnlogic::func_8140("mp_ball_spawn_" + var_00 + "_start");
		var_02 = scripts\mp\_spawnlogic::func_813F(var_01);
	}
	else
	{
		var_01 = level.var_108FB;
		var_03 = var_02;
		var_04 = [];
		var_04["ballPosition"] = level.var_2800[0].visuals[0].origin;
		if(isdefined(level.var_2800[0].carrier))
		{
			var_04["activeCarrierPosition"] = level.var_2800[0].carrier.origin;
		}
		else
		{
			var_04["activeCarrierPosition"] = var_04["ballPosition"];
		}

		var_04["avoidBallDeadZoneDistSq"] = 1000000;
		var_02 = scripts\mp\_spawnscoring::func_8136(var_01,var_03,var_04);
	}

	return var_02;
}

//Function Number: 8
func_49B4()
{
	level._effect["ball_trail"] = loadfx("vfx/core/mp/core/vfx_uplink_ball_trail.vfx");
	level._effect["ball_idle"] = loadfx("vfx/core/mp/core/vfx_uplink_ball_idle_tdef.vfx");
	level._effect["ball_download"] = loadfx("vfx/core/mp/core/vfx_uplink_ball_download.vfx");
	level._effect["ball_download_end"] = loadfx("vfx/core/mp/core/vfx_uplink_ball_download_end_tdef.vfx");
	level._effect["ball_teleport"] = loadfx("vfx/core/mp/core/vfx_uplink_ball_teleport.vfx");
	level._effect["ball_base_glow"] = loadfx("vfx/core/mp/core/vfx_uplink_base_glow.vfx");
}

//Function Number: 9
func_1159E()
{
	level.var_92A9 = "waypoint_blitz_defend_round";
	level.var_92A8 = "waypoint_blitz_defend_round";
	level.var_92AD = "waypoint_capture_kill_round";
	level.var_92AC = "waypoint_capture_kill_round";
	level.var_929C = "waypoint_capture_take";
	level.var_929B = "waypoint_capture_take";
	scripts\mp\_utility::func_98D3();
	level.var_276E = level.var_2800[0];
}

//Function Number: 10
func_C577(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = self;
	var_0B = param_01.origin;
	var_0C = 0;
	if(isdefined(param_00))
	{
		var_0B = param_00.origin;
		var_0C = param_00 == param_01;
	}

	if(isdefined(self.var_3AF7) && isdefined(self.var_3AF7.passtargetoutlineid) && isdefined(self.var_3AF7.passtargetent))
	{
		scripts\mp\_utility::func_C78F(self.var_3AF7.passtargetoutlineid,self.var_3AF7.passtargetent);
		self.var_3AF7.passtargetoutlineid = undefined;
		self.var_3AF7.passtargetent = undefined;
	}

	if(isdefined(self.var_3AF7) && isdefined(self.var_3AF7.playeroutlineid) && isdefined(self.var_3AF7.playeroutlined))
	{
		scripts\mp\_utility::func_C78F(self.var_3AF7.playeroutlineid,self.var_3AF7.playeroutlined);
		self.var_3AF7.playeroutlineid = undefined;
		self.var_3AF7.playeroutlined = undefined;
	}

	if(isdefined(level.var_276E.carrier))
	{
		if(isdefined(param_01) && isplayer(param_01) && param_01.pers["team"] != var_0A.pers["team"])
		{
			if(isdefined(param_01.var_2777) && var_0C)
			{
				param_01 thread scripts\mp\_awards::func_8380("mode_uplink_kill_with_ball");
			}
			else if(isdefined(var_0A.var_2777))
			{
				param_01 thread scripts\mp\_awards::func_8380("mode_uplink_kill_carrier");
				thread scripts\mp\_matchdata::func_AFC5(param_09,"carrying");
				scripts\mp\gametypes\obj_ball::func_12F46("neutral",1,0);
			}

			if(param_01.pers["team"] == level.var_276E.ownerteam && param_01 != level.var_276E.carrier)
			{
				var_0D = distancesquared(level.var_276E.carrier.origin,var_0B);
				if(var_0D < 90000)
				{
					param_01 thread scripts\mp\_awards::func_8380("mode_x_defend");
					param_01 scripts\mp\_utility::func_93DF("defends",1);
					param_01 scripts\mp\_persistence::func_10E56("round","defends",param_01.pers["defends"]);
					param_01 scripts\mp\_utility::func_F6FB(param_01.pers["defends"]);
					thread scripts\mp\_matchdata::func_AFC5(param_09,"defending");
					return;
				}

				return;
			}
		}
	}
}

//Function Number: 11
func_26CE(param_00)
{
	level endon("game_ended");
	level.var_276E endon("dropped");
	level.var_276E endon("reset");
	level notify("awardCapturePointsRunning");
	level endon("awardCapturePointsRunning");
	if(level.var_3AED > 0)
	{
		level.var_276E.carrier thread func_3AEF();
	}

	var_01 = level.var_EC54;
	var_02 = level.var_EC41;
	while(!level.var_7669)
	{
		wait(var_01);
		scripts\mp\_hostmigration::func_13834();
		if(!level.var_7669)
		{
			scripts\mp\_gamescore::func_83B0(param_00,var_02,0);
			level.var_276E.carrier scripts\mp\_utility::func_93DF("objTime",1);
			level.var_276E.carrier scripts\mp\_persistence::func_10E56("round","objTime",level.var_276E.carrier.pers["objTime"]);
			level.var_276E.carrier scripts\mp\_utility::func_F6FA(level.var_276E.carrier.pers["objTime"]);
			level.var_276E.carrier scripts\mp\_gamescore::func_8392("tdef_hold_obj",10);
		}
	}
}

//Function Number: 12
func_3AEF()
{
	level endon("game_ended");
	self endon("death");
	level.var_276E endon("dropped");
	level.var_276E endon("reset");
	for(;;)
	{
		wait(level.var_3AEE);
		thread scripts\mp\_utility::func_83B4("ball_carry",undefined,level.var_3AED);
	}
}

//Function Number: 13
func_13A3C()
{
	self endon("dropped_flag");
	self endon("disconnect");
	level waittill("game_ended");
	if(isdefined(self))
	{
		if(isdefined(self.var_1159F))
		{
			var_00 = int(gettime() - self.var_1159F);
			if(var_00 / 100 / 60 < 1)
			{
				var_01 = 0;
			}
			else
			{
				var_01 = int(var_01 / 100 / 60);
			}

			scripts\mp\_utility::func_93DF("destructions",var_01);
			scripts\mp\_persistence::func_10E56("round","destructions",self.pers["destructions"]);
		}
	}
}

//Function Number: 14
func_80E9()
{
	var_00 = level.var_276E scripts\mp\_gameobjects::func_803E();
	if(isdefined(var_00))
	{
		if(self.pers["team"] == var_00)
		{
			if(!level.var_10846)
			{
				return undefined;
			}

			if(level.var_5117)
			{
				return level.var_10846;
			}
		}
	}
}

//Function Number: 15
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.var_1194 = [];
		thread func_C57B(var_00);
	}
}

//Function Number: 16
func_C57B(param_00)
{
	for(;;)
	{
		param_00 waittill("spawned");
		level.var_27D2[0] scripts\mp\gametypes\obj_ball::func_1010F(param_00);
		if(level.var_D6AF != 0)
		{
			param_00 setclientomnvar("ui_uplink_timer_hud",0);
		}

		param_00 scripts\mp\_utility::func_F6FA(0);
		if(isdefined(param_00.pers["objTime"]))
		{
			param_00 scripts\mp\_utility::func_F6FA(param_00.pers["objTime"]);
		}

		param_00 scripts\mp\_utility::func_F6FB(0);
		if(isdefined(param_00.pers["defends"]))
		{
			param_00 scripts\mp\_utility::func_F6FB(param_00.pers["defends"]);
		}
	}
}

//Function Number: 17
func_8116()
{
	if(scripts\mp\_utility::func_9FB3(self.var_115A0))
	{
		if(scripts\mp\_utility::_hasperk("specialty_afterburner"))
		{
			self method_8434(0,scripts\common\utility::func_116D7(scripts\mp\_utility::func_9D46(),600,2000));
			self method_8430(0,scripts\common\utility::func_116D7(scripts\mp\_utility::func_9D46(),750,650));
		}
		else
		{
			self method_8434(0,400);
			self method_8430(0,900);
		}

		self.var_115A0 = 0;
		return;
	}

	if(scripts\mp\_utility::_hasperk("specialty_afterburner"))
	{
		self method_8434(0,250);
		self method_8430(0,1350);
	}
	else
	{
		self method_8434(0,200);
		self method_8430(0,1800);
	}

	self.var_115A0 = 1;
}

//Function Number: 18
baseeffectwatchgameended()
{
	level waittill("bro_shot_start");
	foreach(var_01 in level.players)
	{
		if(isdefined(var_01.var_1194) && isdefined(var_01.var_1194[0]))
		{
			var_01.var_1194[0] delete();
		}
	}
}