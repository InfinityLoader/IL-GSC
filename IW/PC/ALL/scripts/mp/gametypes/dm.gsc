/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\gametypes\dm.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 34
 * Decompile Time: 1828 ms
 * Timestamp: 10/27/2023 12:12:27 AM
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
		scripts\mp\_utility::func_DF11(level.gametype,10);
		scripts\mp\_utility::func_DF0B(level.gametype,30);
		scripts\mp\_utility::func_DF1A(level.gametype,1);
		scripts\mp\_utility::func_DF08(level.gametype,1);
		scripts\mp\_utility::func_DF02(level.gametype,0);
		scripts\mp\_utility::func_DEF4(level.gametype,0);
		level.var_B40A = 0;
		level.var_B410 = 0;
	}

	func_12E9F();
	level.var_C5A4 = ::func_C5A4;
	level.var_8136 = ::func_8136;
	level.onspawnplayer = ::onspawnplayer;
	level.var_C55E = ::func_C55E;
	level.var_C579 = ::func_C579;
	if(level.var_B40A || level.var_B410)
	{
		level.var_B93A = ::scripts\mp\_damage::func_7678;
	}

	level.var_54BB = 0;
	function_01CC("ffa");
	if(scripts\mp\_utility::func_9FB3(level.var_204B))
	{
		level.ignorekdrstats = 1;
		level.var_3328 = ::func_1D5F;
		setomnvar("ui_skip_loadout",1);
		func_F855();
		game["dialog"]["gametype"] = "allornothing";
	}
	else
	{
		game["dialog"]["gametype"] = "freeforall";
	}

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

	game["dialog"]["ffa_lead_second"] = "ffa_lead_second";
	game["dialog"]["ffa_lead_third"] = "ffa_lead_third";
	game["dialog"]["ffa_lead_last"] = "ffa_lead_last";
	game["dialog"]["offense_obj"] = "killall_intro";
	game["dialog"]["defense_obj"] = "ffa_intro";
	thread func_C56E();
}

//Function Number: 2
func_1D5F()
{
	return "gamemode";
}

//Function Number: 3
func_987C()
{
	scripts\mp\_utility::func_F69D(1);
	setdynamicdvar("scr_dm_aonrules",getmatchrulesdata("dmData","aonRules"));
	setdynamicdvar("scr_dm_winlimit",1);
	scripts\mp\_utility::func_DF1A("dm",1);
	setdynamicdvar("scr_dm_roundlimit",1);
	scripts\mp\_utility::func_DF08("dm",1);
	setdynamicdvar("scr_dm_halftime",0);
	scripts\mp\_utility::func_DEF4("dm",0);
}

//Function Number: 4
func_C5A4()
{
	setclientnamemode("auto_change");
	scripts\mp\_utility::func_F7C1("allies",&"OBJECTIVES_DM");
	scripts\mp\_utility::func_F7C1("axis",&"OBJECTIVES_DM");
	if(level.splitscreen)
	{
		scripts\mp\_utility::func_F7C0("allies",&"OBJECTIVES_DM");
		scripts\mp\_utility::func_F7C0("axis",&"OBJECTIVES_DM");
	}
	else
	{
		scripts\mp\_utility::func_F7C0("allies",&"OBJECTIVES_DM_SCORE");
		scripts\mp\_utility::func_F7C0("axis",&"OBJECTIVES_DM_SCORE");
	}

	scripts\mp\_utility::func_F7BE("allies",&"OBJECTIVES_DM_HINT");
	scripts\mp\_utility::func_F7BE("axis",&"OBJECTIVES_DM_HINT");
	scripts\mp\_spawnlogic::func_F62D("FreeForAll");
	level.var_108E4 = (0,0,0);
	level.var_108E2 = (0,0,0);
	scripts\mp\_spawnlogic::func_182D("mp_dm_spawn_start",1);
	scripts\mp\_spawnlogic::func_1829("allies","mp_dm_spawn");
	scripts\mp\_spawnlogic::func_1829("allies","mp_dm_spawn_secondary",1,1);
	scripts\mp\_spawnlogic::func_1829("axis","mp_dm_spawn");
	scripts\mp\_spawnlogic::func_1829("axis","mp_dm_spawn_secondary",1,1);
	level.var_B32E = scripts\mp\_spawnlogic::func_6CAF(level.var_108E4,level.var_108E2);
	function_01B4(level.var_B32E);
	var_00[0] = "dm";
	scripts\mp\_gameobjects::main(var_00);
	level.var_DB9E = 1;
}

//Function Number: 5
func_12E9F()
{
	scripts\mp\gametypes\common::func_12E9F();
	level.var_204B = scripts\mp\_utility::dvarintvalue("aonRules",0,0,20);
	if(level.var_204B > 0)
	{
		level.var_2BBE = 1;
		level.var_1CAA = setdvar("scr_dm_allowSupers",0);
		level.gesture_explode = loadfx("vfx/iw7/_requests/mp/power/vfx_exploding_drone_explode");
		return;
	}

	level notify("cancel_loadweapons");
}

//Function Number: 6
func_8136()
{
	var_00 = undefined;
	if(level.ingraceperiod)
	{
		var_01 = scripts\mp\_spawnlogic::func_8140("mp_dm_spawn_start");
		if(var_01.size > 0)
		{
			var_00 = scripts\mp\_spawnlogic::func_813F(var_01,1);
		}

		if(!isdefined(var_00))
		{
			var_01 = scripts\mp\_spawnlogic::func_81BA(self.team);
			var_00 = scripts\mp\_spawnscoring::func_8167(var_01);
		}
	}
	else
	{
		var_01 = scripts\mp\_spawnlogic::func_81BA(self.team);
		var_02 = scripts\mp\_spawnlogic::func_81A9(self.team);
		var_00 = scripts\mp\_spawnscoring::func_8136(var_01,var_02);
	}

	return var_00;
}

//Function Number: 7
onspawnplayer()
{
	if(level.var_204B > 0)
	{
		thread func_C59E();
	}

	level notify("spawned_player");
}

//Function Number: 8
func_C55E(param_00,param_01,param_02,param_03,param_04)
{
	scripts\mp\gametypes\common::func_C55E(param_00,param_01,param_02,param_03,param_04);
	if(level.var_204B > 0)
	{
		if(param_01 scripts\mp\_utility::_hasperk("passive_aon_perks"))
		{
			param_01 thread scripts\mp\perks\_weaponpassives::func_8974(param_01,param_00);
		}
	}

	var_05 = 0;
	foreach(var_07 in level.players)
	{
		if(isdefined(var_07.var_278) && var_07.var_278 > var_05)
		{
			var_05 = var_07.var_278;
		}
	}

	if(!level.var_54BB)
	{
		if(param_01.var_278 >= int(level.var_EC3B * level.var_4BFF - level.var_EC3B / 2))
		{
			thread func_58C8(param_01);
		}
	}

	if(param_01.var_278 == level.var_EC3B - 2)
	{
		level.kick_afk_check = 1;
	}

	var_09 = param_01 scripts\mp\_utility::getpersstat("killChains");
	param_01 scripts\mp\_utility::func_F6FB(var_09);
}

//Function Number: 9
func_C579(param_00,param_01,param_02)
{
	param_01 scripts\mp\_utility::func_93DF("gamemodeScore",param_02,1);
	var_03 = param_01 scripts\mp\_utility::getpersstat("gamemodeScore");
	param_01 scripts\mp\_persistence::func_10E56("round","gamemodeScore",var_03);
	if(param_01.pers["cur_kill_streak"] > param_01 scripts\mp\_utility::getpersstat("killChains"))
	{
		param_01 scripts\mp\_utility::setpersstat("killChains",param_01.pers["cur_kill_streak"]);
		param_01 scripts\mp\_utility::func_F6FB(param_01.pers["cur_kill_streak"]);
	}

	if(issubstr(param_00,"super_"))
	{
		return 0;
	}

	if(issubstr(param_00,"kill_ss"))
	{
		return 0;
	}

	if(issubstr(param_00,"kill"))
	{
		var_04 = scripts\mp\_rank::func_8104("score_increment");
		if(scripts\mp\_utility::func_9FB3(level.var_204B))
		{
			param_01 thread scripts\mp\_rank::func_839A("kill",50,undefined);
			param_01 scripts\mp\_utility::displayscoreeventpoints(50,"kill");
		}

		return var_04;
	}
	else if(param_01 == "assist_ffa")
	{
		param_02 scripts\mp\_utility::func_316C("earned_score_buffered",var_03);
	}

	return 0;
}

//Function Number: 10
func_58C8(param_00)
{
	param_00 scripts\mp\_utility::func_AAEC("halfway_friendly_boost");
	var_01 = scripts\common\utility::func_22C3(level.players,::func_445C);
	if(isdefined(var_01[1]))
	{
		var_01[1] scripts\mp\_utility::func_AAEC("ffa_lead_second");
	}

	if(isdefined(var_01[2]) && var_01.size > 2)
	{
		var_01[2] scripts\mp\_utility::func_AAEC("ffa_lead_third");
	}

	if(isdefined(var_01[var_01.size - 1]) && var_01.size > 3)
	{
		var_01[var_01.size - 1] scripts\mp\_utility::func_AAEC("ffa_lead_last");
	}

	level.var_54BB = 1;
}

//Function Number: 11
func_445C(param_00,param_01)
{
	return param_00.var_278 >= param_01.var_278;
}

//Function Number: 12
func_C59E()
{
	self endon("death");
	self endon("disconnect");
	self waittill("giveLoadout");
	func_E839();
}

//Function Number: 13
func_E839()
{
	giveextraaonperks();
	if(level.var_204B == 2)
	{
		self.var_AE62 = "archetype_assassin";
	}

	if(!scripts\mp\_utility::func_9FB3(level.tactical))
	{
		func_8114(self.var_AE62);
	}

	self.var_2049 = 0;
	self.var_204A = 0;
	var_00 = self.var_AE6C;
	self method_83B7();
	waittillframeend;
	if(level.var_204B >= 3)
	{
		self notify("gesture_rockPaperScissorsThink()");
		self notify("gesture_coinFlipThink()");
		self setclientomnvar("ui_gesture_reticle",-1);
		self.var_55C9 = 0;
		self giveweapon("iw7_g18_mpr_aon_fixed");
		self method_817C("iw7_g18_mpr_aon_fixed");
		scripts\mp\_utility::func_8387("specialty_sprintfire");
		var_01 = "secondary";
		var_02 = scripts\mp\_powers::func_808C(var_01);
		if(isdefined(var_02))
		{
			scripts\mp\_powers::func_E15E(var_02);
		}

		if(level.var_204B == 3)
		{
			if(!isbot(self))
			{
				randomizegesture();
			}
		}
	}
	else
	{
		self giveweapon("iw7_g18_mpr_aon_fixed");
		self giveweapon("iw7_knife_mp_aon");
		self method_84E8("iw7_knife_mp_aon");
		self giveweapon("iw7_knife_mp_aon2");
		self method_817C("iw7_g18_mpr_aon_fixed");
		if(isdefined(var_00))
		{
			scripts\mp\_utility::func_12C6(var_00);
			self method_8541(var_00);
			self.var_77C2 = var_00;
		}
	}

	var_01 = "primary";
	var_02 = scripts\mp\_powers::func_808C(var_01);
	if(isdefined(var_02))
	{
		scripts\mp\_powers::func_E15E(var_02);
	}

	if(level.var_204B == 2)
	{
		scripts\mp\_powers::func_8397("power_blinkKnife",var_01,0);
	}
	else
	{
		scripts\mp\_powers::func_8397("power_throwingKnife",var_01,0);
	}

	scripts\mp\_utility::func_11383("iw7_g18_mpr_aon_fixed",1);
	if(level.var_204B > 2)
	{
		thread gesturewatcher(self.var_77C2);
	}
}

//Function Number: 14
devforcegestures(param_00,param_01)
{
	if(level.var_204B == 4)
	{
		param_00 = "ges_plyr_gesture010";
		scripts\mp\_powers::func_8397("power_transponder",param_01,0);
	}
	else if(level.var_204B == 5)
	{
		param_00 = "ges_plyr_gesture042";
		scripts\mp\_powers::func_8397("power_bouncingBetty",param_01,0);
	}
	else if(level.var_204B == 6)
	{
		param_00 = "ges_plyr_gesture002";
		scripts\mp\_powers::func_8397("power_gasGrenade",param_01,0);
	}
	else if(level.var_204B == 7)
	{
		param_00 = "ges_plyr_gesture006";
		scripts\mp\_powers::func_8397("power_siegeMode",param_01,0);
	}
	else if(level.var_204B == 8)
	{
		param_00 = "ges_plyr_gesture038";
		scripts\mp\_powers::func_8397("power_sensorGrenade",param_01,0);
	}
	else if(level.var_204B == 9)
	{
		param_00 = "ges_plyr_gesture053";
		scripts\mp\_powers::func_8397("power_proxyBomb",param_01,0);
	}
	else if(level.var_204B == 10)
	{
		param_00 = "ges_plyr_gesture051";
		scripts\mp\_powers::func_8397("power_phaseSplit",param_01,0);
	}
	else if(level.var_204B == 11)
	{
		param_00 = "ges_plyr_gesture040";
		scripts\mp\_powers::func_8397("power_discMarker",param_01,0);
	}
	else if(level.var_204B == 12)
	{
		param_00 = "ges_plyr_gesture049";
		scripts\mp\_powers::func_8397("power_caseBomb",param_01,0);
	}
	else if(level.var_204B == 13)
	{
		param_00 = "ges_plyr_gesture001";
		scripts\mp\_powers::func_8397("power_adrenalineMist",param_01,0);
	}
	else if(level.var_204B == 14)
	{
		param_00 = "ges_plyr_gesture041";
		scripts\mp\_powers::func_8397("power_thermobaric",param_01,0);
	}

	scripts\mp\_utility::func_12C6(param_00);
	self method_8541(param_00);
	self.var_77C2 = param_00;
}

//Function Number: 15
randomizegesture()
{
	var_00 = "ges_plyr_gesture010";
	var_01 = "power_transponder";
	var_02 = "secondary";
	if(self.gestureindex >= self.gesturelist.size)
	{
		self.gesturelist = scripts\common\utility::array_randomize(self.gesturelist);
		self.gestureindex = 0;
	}

	var_00 = self.gesturelist[self.gestureindex];
	var_01 = getpowerfromgesture(var_00);
	scripts\mp\_powers::func_8397(var_01,var_02,0);
	if(isdefined(self.var_77C2) && self.var_77C2 != "none")
	{
		scripts\mp\_utility::func_141E(self.var_77C2);
	}

	scripts\mp\_utility::func_12C6(var_00);
	self method_8541(var_00);
	self.var_77C2 = var_00;
	return var_01;
}

//Function Number: 16
getpowerfromgesture(param_00)
{
	switch(param_00)
	{
		case "ges_plyr_gesture010":
			var_01 = "power_transponder";
			break;

		case "ges_plyr_gesture042":
			var_01 = "power_bouncingBetty";
			break;

		case "ges_plyr_gesture002":
			var_01 = "power_gasGrenade";
			break;

		case "ges_plyr_gesture006":
			var_01 = "power_siegeMode";
			break;

		case "ges_plyr_gesture038":
			var_01 = "power_sensorGrenade";
			break;

		case "ges_plyr_gesture053":
			var_01 = "power_proxyBomb";
			break;

		case "ges_plyr_gesture051":
			var_01 = "power_phaseSplit";
			break;

		case "ges_plyr_gesture040":
			var_01 = "power_discMarker";
			break;

		case "ges_plyr_gesture049":
			var_01 = "power_caseBomb";
			break;

		case "ges_plyr_gesture001":
			var_01 = "power_adrenalineMist";
			break;

		case "ges_plyr_gesture041":
			var_01 = "power_thermobaric";
			break;

		default:
			var_01 = "power_transponder";
			break;
	}

	return var_01;
}

//Function Number: 17
gesturewatcher(param_00)
{
	self endon("death");
	for(;;)
	{
		self waittill("offhand_pullback",param_00);
		if(param_00 == "throwingknife_mp")
		{
			continue;
		}

		var_01 = undefined;
		var_02 = undefined;
		var_03 = undefined;
		var_04 = undefined;
		var_05 = 1;
		var_06 = undefined;
		var_07 = 1200;
		switch(param_00)
		{
			case "power_bang_mp":
			case "ges_plyr_gesture010":
				param_00 = "ges_plyr_gesture010";
				var_01 = 0.65;
				var_02 = 0.3;
				break;
	
			case "power_crush_mp":
			case "ges_plyr_gesture042":
				scripts\mp\_utility::func_8387("passive_gore");
				param_00 = "ges_plyr_gesture042";
				var_01 = 0.8;
				var_02 = 0.1;
				var_03 = 0.1;
				break;
	
			case "power_headcrush_mp":
			case "ges_plyr_gesture002":
				scripts\mp\_utility::func_8387("passive_gore");
				param_00 = "ges_plyr_gesture002";
				var_01 = 1.15;
				var_02 = 0.65;
				var_03 = 0.3;
				break;
	
			case "power_throatcut_mp":
			case "ges_plyr_gesture006":
				scripts\mp\_utility::func_8387("passive_gore");
				param_00 = "ges_plyr_gesture006";
				var_01 = 0.85;
				var_02 = 0.1;
				var_03 = 0.1;
				var_05 = 1;
				var_06 = 55;
				break;
	
			case "power_boom_mp":
			case "ges_plyr_gesture038":
				param_00 = "ges_plyr_gesture038";
				var_01 = 1.15;
				break;
	
			case "power_lighter_mp":
			case "ges_plyr_gesture053":
				param_00 = "ges_plyr_gesture053";
				var_01 = 1.65;
				var_06 = 55;
				break;
	
			case "power_rc8_mp":
			case "ges_plyr_gesture051":
				param_00 = "ges_plyr_gesture051";
				var_01 = 1.45;
				var_02 = 0.6;
				var_03 = 0.15;
				var_06 = 55;
				break;
	
			case "power_chinflick_mp":
			case "ges_plyr_gesture040":
				param_00 = "ges_plyr_gesture040";
				var_01 = 0.95;
				break;
	
			case "power_jackal_mp":
			case "ges_plyr_gesture049":
				param_00 = "ges_plyr_gesture049";
				var_01 = 1.5;
				var_02 = 0.9;
				var_03 = 0.9;
				break;
	
			case "power_no_mp":
			case "ges_plyr_gesture001":
				param_00 = "ges_plyr_gesture001";
				var_01 = 0.75;
				var_02 = 0.2;
				var_03 = 0.1;
				var_04 = 0.1;
				break;
	
			case "power_begone_mp":
			case "ges_plyr_gesture041":
				param_00 = "ges_plyr_gesture041";
				var_01 = 0.35;
				var_02 = 0.3;
				var_03 = 0.1;
				var_06 = 55;
				break;
	
			default:
				param_00 = "ges_plyr_gesture010";
				var_01 = 0.65;
				var_02 = 0.3;
				break;
		}

		if(scripts\mp\_utility::func_766C("prematch_done"))
		{
			thread use_gesture_weapon(param_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07);
		}
	}
}

//Function Number: 18
gesturedumbfirekillwatcher(param_00)
{
	self notify("finger_gun_used");
	self endon("finger_gun_used");
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self waittill("got_a_kill",var_01,var_02,var_03);
	if(var_02 == "cluster_grenade_mp" || var_02 == "iw7_chargeshot_mp" || var_02 == "iw7_glprox_mp")
	{
		self.gesturekill = 1;
		incrementgestureindex(param_00);
	}
}

//Function Number: 19
use_gesture_weapon(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	self endon("disconnect");
	self endon("death");
	scripts\mp\_utility::func_1C47(0);
	scripts\common\utility::func_1C58(0);
	self.gesturekill = 0;
	var_08 = self.gestureindex;
	if(isdefined(param_01))
	{
		scripts\mp\_utility::func_8387("specialty_radarblip");
		self setclientomnvar("ui_gesture_reticle",0);
		wait(param_01);
		var_09 = get_enemies_within_fov(param_06,param_07,param_05);
		if(var_09.size == 0)
		{
			thread gesturedumbfirekillwatcher(var_08);
			self setclientomnvar("ui_gesture_reticle",1);
			var_0A = getdumbfirepos(self);
			if(param_00 == "ges_plyr_gesture049")
			{
				firejackalmissiles(undefined,1,var_0A);
			}
			else if(param_00 == "ges_plyr_gesture040")
			{
				self.var_DA5A = scripts\mp\_utility::func_1309("iw7_blackholegun_mp",self gettagorigin("j_wrist_le"),var_0A,self);
				self.gesturekill = 1;
				incrementgestureindex(var_08);
			}
			else if(param_00 == "ges_plyr_gesture010")
			{
				scripts\mp\_utility::func_1309("iw7_atomizer_mp",self gettagorigin("j_wrist_le"),var_0A,self);
			}
			else if(param_00 == "ges_plyr_gesture038" || param_00 == "ges_plyr_gesture053")
			{
				self radiusdamage(var_0A + (0,0,40),256,150,100,self,"MOD_IMPACT","cluster_grenade_mp");
				playfx(level.gesture_explode,var_0A + (0,0,40));
				playsoundatpos(var_0A,"frag_grenade_explode");
			}
		}
		else
		{
			self setclientomnvar("ui_gesture_reticle",2);
			foreach(var_0C in var_09)
			{
				if(param_00 == "ges_plyr_gesture049")
				{
					firejackalmissiles(var_0C,1);
				}
				else if(param_00 == "ges_plyr_gesture040")
				{
					self.var_DA5A = scripts\mp\_utility::func_1309("iw7_blackholegun_mp",self gettagorigin("j_wrist_le"),var_0C gettagorigin("j_spine4"),self);
					self.var_DA5A missile_settargetent(var_0C,var_0C gettargetoffset());
				}
				else if(param_00 == "ges_plyr_gesture010")
				{
					scripts\mp\_utility::func_1309("iw7_atomizer_mp",self gettagorigin("j_wrist_le"),var_0C gettagorigin("j_spine4"),self);
					thread dogesturedamage(var_0C,"iw7_atomizer_mp",param_00,1);
				}
				else
				{
					thread dogesturedamage(var_0C,"iw7_g18_mpr_aon_fixed",param_00,1);
				}

				self.gesturekill = 1;
				incrementgestureindex(var_08);
			}
		}
	}

	if(isdefined(param_02))
	{
		scripts\mp\_utility::func_E150("specialty_radarblip");
		wait(0.1);
		self setclientomnvar("ui_gesture_reticle",0);
		wait(param_02);
		scripts\mp\_utility::func_8387("specialty_radarblip");
		var_09 = get_enemies_within_fov(param_06,param_07,1);
		if(var_09.size == 0)
		{
			thread gesturedumbfirekillwatcher(var_08);
			self setclientomnvar("ui_gesture_reticle",1);
			var_0A = getdumbfirepos(self);
			if(param_00 == "ges_plyr_gesture049")
			{
				firejackalmissiles(undefined,2,var_0A);
			}
			else if(param_00 == "ges_plyr_gesture010")
			{
				scripts\mp\_utility::func_1309("iw7_atomizer_mp",self gettagorigin("j_wrist_le"),var_0A,self);
			}
		}
		else
		{
			self setclientomnvar("ui_gesture_reticle",2);
			foreach(var_0C in var_09)
			{
				if(param_00 == "ges_plyr_gesture049")
				{
					firejackalmissiles(var_0C,2);
				}
				else if(param_00 == "ges_plyr_gesture010")
				{
					scripts\mp\_utility::func_1309("iw7_atomizer_mp",self gettagorigin("j_wrist_le"),var_0C gettagorigin("j_spine4"),self);
					thread dogesturedamage(var_0C,"iw7_atomizer_mp",param_00,2);
				}
				else
				{
					thread dogesturedamage(var_0C,"iw7_g18_mpr_aon_fixed",param_00,2);
				}

				self.gesturekill = 1;
				incrementgestureindex(var_08);
			}
		}
	}

	if(isdefined(param_03))
	{
		scripts\mp\_utility::func_E150("specialty_radarblip");
		wait(0.1);
		self setclientomnvar("ui_gesture_reticle",0);
		wait(param_03);
		scripts\mp\_utility::func_8387("specialty_radarblip");
		var_09 = get_enemies_within_fov(param_06,param_07,1);
		if(var_09.size == 0)
		{
			thread gesturedumbfirekillwatcher(var_08);
			self setclientomnvar("ui_gesture_reticle",1);
			var_0A = getdumbfirepos(self);
			if(param_00 == "ges_plyr_gesture049")
			{
				firejackalmissiles(undefined,3,var_0A);
			}
		}
		else
		{
			self setclientomnvar("ui_gesture_reticle",2);
			foreach(var_0C in var_09)
			{
				if(param_00 == "ges_plyr_gesture049")
				{
					firejackalmissiles(var_0C,3);
				}
				else
				{
					thread dogesturedamage(var_0C,"iw7_g18_mpr_aon_fixed",param_00,3);
				}

				self.gesturekill = 1;
				incrementgestureindex(var_08);
			}
		}
	}

	if(isdefined(param_04))
	{
		scripts\mp\_utility::func_E150("specialty_radarblip");
		wait(0.1);
		self setclientomnvar("ui_gesture_reticle",0);
		wait(param_04);
		scripts\mp\_utility::func_8387("specialty_radarblip");
		var_09 = get_enemies_within_fov(param_06,param_07,1);
		if(var_09.size == 0)
		{
			self setclientomnvar("ui_gesture_reticle",1);
		}
		else
		{
			self setclientomnvar("ui_gesture_reticle",2);
			foreach(var_0C in var_09)
			{
				thread dogesturedamage(var_0C,"iw7_g18_mpr_aon_fixed",param_00,4);
				self.gesturekill = 1;
				incrementgestureindex(var_08);
			}
		}
	}

	wait(0.1);
	scripts\mp\_utility::func_E150("specialty_radarblip");
	self setclientomnvar("ui_gesture_reticle",-1);
	wait_for_gesture_length(param_00);
	powerrecharge();
}

//Function Number: 20
incrementgestureindex(param_00)
{
	if(param_00 == self.gestureindex)
	{
		self.gestureindex++;
	}
}

//Function Number: 21
wait_for_gesture_length(param_00)
{
	self endon("disconnect");
	self endon("death");
	while(self isgestureplaying(param_00))
	{
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 22
firejackalmissiles(param_00,param_01,param_02)
{
	var_03 = 0;
	if(!isdefined(param_00))
	{
		var_03 = 1;
	}

	var_04 = self gettagorigin("j_wrist_le");
	var_05 = self gettagorigin("j_wrist_le");
	var_06 = self gettagorigin("j_wrist_le");
	if(var_03)
	{
		var_07 = param_02;
		var_08 = var_07;
		var_09 = var_08;
	}
	else
	{
		var_07 = var_03 gettagorigin("j_spine4");
		var_08 = param_02 gettagorigin("j_spineupper");
		var_09 = param_01 geteye();
		var_0A = scripts\mp\_utility::func_1309("iw7_lockon_mp",var_04,var_07,self);
		var_0A missile_settargetent(param_00,param_00 gettargetoffset());
		var_0B = scripts\mp\_utility::func_1309("iw7_lockon_mp",var_05,var_08,self);
		var_0B missile_settargetent(param_00,param_00 gettargetoffset());
	}

	if(param_01 == 3)
	{
		scripts\mp\_utility::func_1309("iw7_chargeshot_mp",var_06,var_09,self);
		return;
	}

	scripts\mp\_utility::func_1309("iw7_glprox_mp",var_06,var_09,self);
}

//Function Number: 23
getdumbfirepos(param_00)
{
	var_01 = param_00 getplayerangles();
	var_01 = (clamp(var_01[0],-85,85),var_01[1],var_01[2]);
	var_02 = anglestoforward(var_01);
	var_03 = param_00 gettagorigin("j_wrist_le");
	var_04 = vectornormalize(var_02) * 500;
	var_05 = ["physicscontents_clipshot","physicscontents_corpseclipshot","physicscontents_missileclip","physicscontents_solid","physicscontents_vehicle","physicscontents_player","physicscontents_actor","physicscontents_glass","physicscontents_itemclip"];
	var_06 = physics_createcontents(var_05);
	var_07 = scripts\common\trace::func_DCED(var_03,var_03 + var_04,param_00,var_06);
	if(var_07["fraction"] < 1)
	{
		var_04 = vectornormalize(var_02) * 500 * var_07["fraction"];
	}
	else
	{
		var_04 = vectornormalize(var_02) * 500;
	}

	return var_03 + var_04;
}

//Function Number: 24
gettargetoffset()
{
	var_00 = gettargetorigin();
	return (0,0,var_00[2] - self.origin[2]);
}

//Function Number: 25
gettargetorigin()
{
	var_00 = 10;
	switch(self getstance())
	{
		case "crouch":
			var_00 = 15;
			break;

		case "prone":
			var_00 = 5;
			break;
	}

	var_01 = self getworldupreferenceangles();
	var_02 = anglestoup(var_01);
	var_03 = self gettagorigin("j_spinelower",1,1);
	var_04 = var_03 + var_02 * var_00;
	return var_04;
}

//Function Number: 26
powerrecharge()
{
	if(level.var_204B == 3 && self.gesturekill)
	{
		var_00 = "secondary";
		var_01 = scripts\mp\_powers::func_808C(var_00);
		if(isdefined(var_01))
		{
			scripts\mp\_powers::func_E15E(var_01);
		}

		var_02 = randomizegesture();
	}
	else
	{
		var_02 = scripts\mp\_powers::func_808C("secondary");
		scripts\mp\_powers::func_D74C(var_02);
	}

	if(scripts\mp\_utility::_hasperk("passive_gore"))
	{
		scripts\mp\_utility::func_E150("passive_gore");
	}

	scripts\mp\_utility::func_1C47(1);
	scripts\common\utility::func_1C58(1);
}

//Function Number: 27
dogesturedamage(param_00,param_01,param_02,param_03)
{
	if(param_02 == "ges_plyr_gesture038" || param_02 == "ges_plyr_gesture053")
	{
		self radiusdamage(param_00.origin + (0,0,40),256,150,100,self,"MOD_IMPACT","cluster_grenade_mp");
		playfx(level.var_B761,param_00.origin + (0,0,40));
		playsoundatpos(param_00.origin + (0,0,40),"frag_grenade_explode");
		return;
	}

	if(param_02 == "ges_plyr_gesture010" || param_02 == "ges_plyr_gesture006")
	{
		wait(0.05);
		if(isdefined(self) && isdefined(param_00))
		{
			param_00 dodamage(param_00.health + 1000,self.origin,self,self,"MOD_UNKNOWN",param_01);
			return;
		}

		return;
	}

	if(param_02 == "ges_plyr_gesture051" || param_02 == "ges_plyr_gesture041" || param_02 == "ges_plyr_gesture001")
	{
		var_04 = vectortoangles(param_00.origin - self.origin);
		var_05 = anglestoright(var_04);
		var_06 = vectornormalize(var_05) * 500;
		if(param_02 == "ges_plyr_gesture041" || param_02 == "ges_plyr_gesture001" && param_03 == 2 || param_02 == "ges_plyr_gesture001" && param_03 == 4)
		{
			var_06 = var_06 * -1;
		}

		param_00 method_84DC(var_06 + (0,0,500),750);
	}
	else
	{
		param_00 method_84DC(vectornormalize(param_00.origin - self.origin) * 500 + (0,0,800),750);
	}

	wait(0.05);
	if(isdefined(self) && isdefined(param_00))
	{
		param_00 dodamage(param_00.health + 1000,self.origin,self,self,"MOD_CRUSH",param_01);
		return;
	}
}

//Function Number: 28
get_enemies_within_fov(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 3;
	}

	var_03 = [];
	var_04 = level.players;
	var_05 = scripts\common\utility::func_782F(self.origin,var_04,undefined,17,param_01,1);
	var_06 = anglestoforward(self.angles);
	var_07 = vectornormalize(var_06) * -35;
	var_08 = 0;
	var_09 = 50;
	if(isdefined(param_00))
	{
		var_09 = param_00;
	}

	foreach(var_0B in var_05)
	{
		if(!scripts\mp\_utility::func_9F19(var_0B))
		{
			continue;
		}

		var_0C = var_0B.origin;
		var_0D = distance2d(self.origin,var_0C);
		if(var_0D < 100)
		{
			var_09 = 120;
		}

		var_0E = 0;
		var_0F = 0;
		var_10 = 0;
		var_11 = 0;
		var_12 = 0;
		var_13 = 0;
		var_14 = [];
		var_14[var_14.size] = self;
		var_14[var_14.size] = var_0B;
		var_15 = ["physicscontents_clipshot","physicscontents_corpseclipshot","physicscontents_missileclip","physicscontents_solid","physicscontents_vehicle","physicscontents_player","physicscontents_actor","physicscontents_itemclip"];
		var_16 = physics_createcontents(var_15);
		var_17 = self method_8409(var_0B geteye(),65,var_09);
		if(var_17)
		{
			var_17 = 0;
			if(scripts\common\trace::func_DCF1(self geteye(),var_0B geteye(),var_14,var_16))
			{
				var_17 = 1;
			}
		}

		if(!var_17)
		{
			var_17 = self method_8409(var_0B.origin,65,var_09);
			if(var_17)
			{
				var_17 = 0;
				if(scripts\common\trace::func_DCF1(self geteye(),var_0B.origin,var_14,var_16))
				{
					var_17 = 1;
				}
			}
		}

		if(!var_17)
		{
			var_17 = self method_8409(var_0B gettagorigin("j_spinelower"),65,var_09);
			if(var_17)
			{
				var_17 = 0;
				if(scripts\common\trace::func_DCF1(self geteye(),var_0B gettagorigin("j_spinelower"),var_14,var_16))
				{
					var_17 = 1;
				}
			}
		}

		if(!var_17)
		{
			var_17 = self method_8409(var_0B gettagorigin("j_elbow_le"),65,var_09);
			if(var_17)
			{
				var_17 = 0;
				if(scripts\common\trace::func_DCF1(self geteye(),var_0B gettagorigin("j_elbow_le"),var_14,var_16))
				{
					var_17 = 1;
				}
			}
		}

		if(!var_17)
		{
			var_17 = self method_8409(var_0B gettagorigin("j_elbow_ri"),65,var_09);
			if(var_17)
			{
				var_17 = 0;
				if(scripts\common\trace::func_DCF1(self geteye(),var_0B gettagorigin("j_elbow_ri"),var_14,var_16))
				{
					var_17 = 1;
				}
			}
		}

		if(var_17)
		{
			if(isdefined(param_01))
			{
				var_0D = distance2d(self.origin,var_0C);
				if(var_0D < param_01)
				{
					var_0E = 1;
				}
			}
			else
			{
				var_0E = 1;
			}
		}

		if(var_0E && var_03.size < param_02)
		{
			var_03[var_03.size] = var_0B;
			var_05 = scripts\common\utility::func_22A9(var_05,var_0B);
		}

		if(var_03.size >= param_02)
		{
			var_08 = 1;
			break;
		}
	}

	return var_03;
}

//Function Number: 29
giveextraaonperks()
{
	var_00 = ["specialty_blindeye","specialty_gpsjammer","specialty_falldamage","specialty_sharp_focus","specialty_stalker","passive_aon_perks"];
	foreach(var_02 in var_00)
	{
		scripts\mp\_utility::func_8387(var_02);
	}
}

//Function Number: 30
func_8114(param_00)
{
	switch(param_00)
	{
		case "archetype_assault":
			param_00 = "assault_mp";
			break;

		case "archetype_heavy":
			param_00 = "armor_mp";
			break;

		case "archetype_scout":
			param_00 = "scout_mp";
			break;

		case "archetype_assassin":
			param_00 = "assassin_mp";
			break;

		case "archetype_engineer":
			param_00 = "engineer_mp";
			break;

		case "archetype_sniper":
			param_00 = "sniper_mp";
			break;

		default:
			if(!isdefined(level.var_204B) || level.var_204B == 0)
			{
			}
	
			param_00 = "assault_mp";
			break;
	}

	self method_845A(param_00 + "_classic");
	if(scripts\mp\_utility::func_9FB3(level.var_112C1))
	{
		self method_8434(0,200);
		self method_8430(0,1800);
	}
}

//Function Number: 31
func_C56E()
{
	level endon("cancel_loadweapons");
	var_00 = 1;
	for(;;)
	{
		level waittill("connected",var_01);
		if(level.var_204B > 0)
		{
			if(var_00)
			{
				level notify("lethal_delay_end");
				level.var_ABBF = 0;
				level.var_1C98 = 0;
				var_00 = 0;
			}

			var_01.pers["class"] = "gamemode";
			var_01.pers["lastClass"] = "";
			var_01.var_4004 = var_01.pers["class"];
			var_01.var_A95C = var_01.pers["lastClass"];
			var_01.pers["gamemodeLoadout"] = level.aon_loadouts["allies"];
			var_01 loadweaponsforplayer(["iw7_g18_mpr_aon_fixed","iw7_knife_mp_aon","iw7_knife_mp_aon2"]);
		}

		if(level.var_204B == 3)
		{
			var_01 thread hintnotify();
			var_01.gesturelist = [];
			var_01.gesturelist[var_01.gesturelist.size] = "ges_plyr_gesture042";
			var_01.gesturelist[var_01.gesturelist.size] = "ges_plyr_gesture002";
			var_01.gesturelist[var_01.gesturelist.size] = "ges_plyr_gesture006";
			var_01.gesturelist[var_01.gesturelist.size] = "ges_plyr_gesture038";
			var_01.gesturelist[var_01.gesturelist.size] = "ges_plyr_gesture053";
			var_01.gesturelist[var_01.gesturelist.size] = "ges_plyr_gesture051";
			var_01.gesturelist[var_01.gesturelist.size] = "ges_plyr_gesture040";
			var_01.gesturelist[var_01.gesturelist.size] = "ges_plyr_gesture049";
			var_01.gesturelist[var_01.gesturelist.size] = "ges_plyr_gesture001";
			var_01.gesturelist[var_01.gesturelist.size] = "ges_plyr_gesture041";
			var_01.gesturelist = scripts\common\utility::array_randomize(var_01.gesturelist);
			var_01.gesturelist = scripts\common\utility::func_229C(var_01.gesturelist,"ges_plyr_gesture010",0);
			var_01.gestureindex = 0;
		}
	}
}

//Function Number: 32
hintnotify()
{
	level endon("game_ended");
	self endon("disconnect");
	var_00 = 1;
	var_01 = 0;
	for(;;)
	{
		if(var_00)
		{
			self waittill("giveLoadout");
		}
		else
		{
			self waittill("spawned");
		}

		wait(4);
		var_01++;
		if(var_01 < 3)
		{
			thread givehintmessage();
			continue;
		}

		break;
	}
}

//Function Number: 33
givehintmessage()
{
	self notify("practiceMessage");
	self endon("practiceMessage");
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	if(scripts\common\utility::func_9C70())
	{
		self iprintlnbold(&"PLATFORM_GESTURE_MODE_HINT_SLOT3");
		return;
	}

	self iprintlnbold(&"PLATFORM_GESTURE_MODE_HINT_SLOT7");
}

//Function Number: 34
func_F855()
{
	level.aon_loadouts["allies"]["loadoutPrimary"] = "iw7_g18";
	level.aon_loadouts["allies"]["loadoutPrimaryAttachment"] = "none";
	level.aon_loadouts["allies"]["loadoutPrimaryAttachment2"] = "none";
	level.aon_loadouts["allies"]["loadoutPrimaryCamo"] = "none";
	level.aon_loadouts["allies"]["loadoutPrimaryReticle"] = "none";
	level.aon_loadouts["allies"]["loadoutSecondary"] = "none";
	level.aon_loadouts["allies"]["loadoutSecondaryAttachment"] = "none";
	level.aon_loadouts["allies"]["loadoutSecondaryAttachment2"] = "none";
	level.aon_loadouts["allies"]["loadoutSecondaryCamo"] = "none";
	level.aon_loadouts["allies"]["loadoutSecondaryReticle"] = "none";
	level.aon_loadouts["allies"]["loadoutPowerPrimary"] = "power_throwingKnife";
	level.aon_loadouts["allies"]["loadoutPowerSecondary"] = "none";
	level.aon_loadouts["allies"]["loadoutSuper"] = "none";
	level.aon_loadouts["allies"]["loadoutStreakType"] = "assault";
	level.aon_loadouts["allies"]["loadoutKillstreak1"] = "none";
	level.aon_loadouts["allies"]["loadoutKillstreak2"] = "none";
	level.aon_loadouts["allies"]["loadoutKillstreak3"] = "none";
	level.aon_loadouts["allies"]["loadoutJuggernaut"] = 0;
	level.aon_loadouts["allies"]["loadoutPerks"] = ["specialty_fastreload"];
	level.aon_loadouts["allies"]["loadoutGesture"] = "playerData";
	level.aon_loadouts["axis"] = level.aon_loadouts["allies"];
}