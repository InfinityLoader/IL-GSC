/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\gametypes\gun.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 35
 * Decompile Time: 1704 ms
 * Timestamp: 10/27/2023 12:12:36 AM
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
		scripts\mp\_utility::func_DF08(level.gametype,1);
		scripts\mp\_utility::func_DF1A(level.gametype,0);
		scripts\mp\_utility::func_DF02(level.gametype,0);
		scripts\mp\_utility::func_DEF4(level.gametype,0);
		level.var_B40A = 0;
		level.var_B410 = 0;
	}

	func_F855();
	func_12E9F();
	func_F733();
	function_01CC("ffa");
	level.teambased = 0;
	level.ignorekdrstats = 1;
	level.var_5A62 = 1;
	level.var_112C2 = 0;
	level.var_112C4 = 0;
	level.var_C580 = ::func_C580;
	level.var_C5A4 = ::func_C5A4;
	level.onspawnplayer = ::onspawnplayer;
	level.var_8136 = ::func_8136;
	level.var_C577 = ::func_C577;
	level.var_C5B2 = ::func_C5B2;
	level.var_C579 = ::func_C579;
	level.var_3328 = ::func_1D5F;
	level.modifyunifiedpointscallback = ::modifyunifiedpointscallback;
	if(level.var_B40A || level.var_B410)
	{
		level.var_B93A = ::scripts\mp\_damage::func_7678;
	}

	game["dialog"]["gametype"] = "gungame";
	game["dialog"]["offense_obj"] = "killall_intro";
	game["dialog"]["defense_obj"] = "ffa_intro";
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
	setdynamicdvar("scr_gun_setback",getmatchrulesdata("gunData","setback"));
	setdynamicdvar("scr_gun_setbackStreak",getmatchrulesdata("gunData","setbackStreak"));
	setdynamicdvar("scr_gun_killsPerWeapon",getmatchrulesdata("gunData","killsPerWeapon"));
	setdynamicdvar("scr_gun_ladderIndex",getmatchrulesdata("gunData","ladderIndex"));
	setdynamicdvar("scr_gun_promode",0);
}

//Function Number: 4
func_C580()
{
}

//Function Number: 5
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
	func_F736();
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
	var_00 = [];
	scripts\mp\_gameobjects::main(var_00);
	level.var_DB9E = 1;
	level.var_2BBE = 1;
	level thread func_C56E();
}

//Function Number: 6
func_12E9F()
{
	scripts\mp\gametypes\common::func_12E9F();
	level.var_F654 = scripts\mp\_utility::dvarintvalue("setback",1,0,5);
	level.var_F656 = scripts\mp\_utility::dvarintvalue("setbackStreak",0,0,5);
	level.var_A681 = scripts\mp\_utility::dvarintvalue("killsPerWeapon",1,1,5);
	level.var_A7A4 = scripts\mp\_utility::dvarintvalue("ladderIndex",1,1,4);
}

//Function Number: 7
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_A581();
		var_00.var_86D1 = 1;
		var_00.pers["class"] = "gamemode";
		var_00.pers["lastClass"] = "";
		var_00.var_4004 = var_00.pers["class"];
		var_00.var_A95C = var_00.pers["lastClass"];
		var_00.pers["gamemodeLoadout"] = level.var_86D6["axis"];
		var_00.var_86FB = 0;
		var_00.var_86FC = 0;
		var_00 thread func_DE4B();
		var_00 thread func_DE4F();
		var_00 scripts\mp\_utility::func_F6FF(level.var_86D4[0],1);
	}
}

//Function Number: 8
func_A581()
{
	self loadweaponsforplayer([level.var_86D4[0],level.var_86D4[1]]);
	var_00 = [];
	for(;;)
	{
		self waittill("update_loadweapons");
		var_00[0] = level.var_86D4[int(max(0,self.var_86FB - level.var_F654))];
		var_00[1] = level.var_86D4[self.var_86FB];
		var_00[2] = level.var_86D4[self.var_86FB + 1];
		self loadweaponsforplayer(var_00);
	}
}

//Function Number: 9
func_8136()
{
	if(isplayer(self) && self.var_86D1)
	{
		self.var_86D1 = 0;
		if(scripts\common\utility::func_4347())
		{
			scripts\mp\_menus::func_185F("axis",1);
		}
		else
		{
			scripts\mp\_menus::func_185F("allies",1);
		}
	}

	if(level.ingraceperiod)
	{
		var_00 = undefined;
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

		return var_00;
	}

	var_01 = scripts\mp\_spawnlogic::func_81BA(self.pers["team"]);
	var_02 = scripts\mp\_spawnlogic::func_81A9(self.pers["team"]);
	var_00 = scripts\mp\_spawnscoring::func_8136(var_01,var_02);
	return var_02;
}

//Function Number: 10
onspawnplayer()
{
	thread func_13706();
	level notify("spawned_player");
}

//Function Number: 11
func_13706()
{
	level endon("game_ended");
	self endon("disconnect");
	self waittill("spawned_player");
	if(level.var_7669 && self.var_86FB == level.var_86D4.size)
	{
		self.var_86FB = self.var_86FC;
	}

	scripts\mp\_utility::func_8387("specialty_bling");
	thread func_8381(1);
}

//Function Number: 12
func_C577(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(level.var_7669)
	{
		return;
	}

	if(param_03 == "MOD_FALLING" || isdefined(param_01) && isplayer(param_01))
	{
		var_0A = scripts\mp\_weapons::func_9F2D(param_04);
		var_0B = scripts\mp\_weapons::func_9E6D(param_04) || scripts\mp\_weapons::isaxeweapon(param_04);
		if(!isdefined(self.var_A7A3))
		{
			self.var_A7A3 = 1;
		}
		else
		{
			self.var_A7A3++;
		}

		if(param_03 == "MOD_FALLING" || param_01 == self || param_03 == "MOD_MELEE" && var_0B || self.var_A7A3 == level.var_F656)
		{
			self.var_A7A3 = 0;
			self playlocalsound("mp_war_objective_lost");
			self notify("update_loadweapons");
			self.var_86FC = self.var_86FB;
			self.var_86FB = int(max(0,self.var_86FB - level.var_F654));
			if(self.var_86FC > self.var_86FB)
			{
				scripts\mp\_utility::func_93DF("setbacks",1);
				scripts\mp\_persistence::func_10E56("round","setbacks",self.pers["setbacks"]);
				if(isplayer(self))
				{
					scripts\mp\_utility::func_F6FB(self.pers["setbacks"]);
				}

				thread scripts\mp\_utility::func_83B4("dropped_gun_score",param_04,undefined,0,1);
				scripts\mp\_utility::func_F6FF(level.var_86D4[self.var_86FB],1);
			}

			if(param_03 == "MOD_MELEE")
			{
				if(self.var_86FC)
				{
					param_01 thread scripts\mp\_utility::func_83B4("dropped_enemy_gun_rank");
				}

				param_01 updateknivesperminute();
				param_01 scripts\mp\_awards::func_8380("mode_gun_melee");
				param_01 scripts\mp\_utility::func_93DF("stabs",1);
				param_01 scripts\mp\_persistence::func_10E56("round","stabs",param_01.pers["stabs"]);
				if(isplayer(param_01))
				{
					param_01 scripts\mp\_utility::func_F6FA(param_01.pers["stabs"]);
				}
			}

			if(param_01 == self)
			{
				return;
			}
		}

		if((param_01 != self && param_03 == "MOD_PISTOL_BULLET") || param_03 == "MOD_RIFLE_BULLET" || param_03 == "MOD_HEAD_SHOT" || param_03 == "MOD_PROJECTILE" || param_03 == "MOD_PROJECTILE_SPLASH" || param_03 == "MOD_IMPACT" || param_03 == "MOD_GRENADE" || param_03 == "MOD_GRENADE_SPLASH" || param_03 == "MOD_EXPLOSIVE" || param_03 == "MOD_MELEE" && !var_0B)
		{
			var_0C = getweaponbasename(param_04);
			var_0D = getweaponbasename(param_01.var_D8E1);
			if(var_0C != var_0D && !param_01 func_9FE8(param_04))
			{
				return;
			}

			if(!isdefined(param_01.var_A7A5))
			{
				param_01.var_A7A5 = 1;
			}
			else
			{
				param_01.var_A7A5++;
			}

			if(param_01.var_A7A5 != level.var_A681)
			{
				return;
			}

			param_01.var_A7A5 = 0;
			param_01.var_A7A3 = 0;
			param_01.var_86FC = param_01.var_86FB;
			param_01.var_86FB++;
			param_01 notify("update_loadweapons");
			param_01 thread scripts\mp\_utility::func_83B4("gained_gun_score",param_04,undefined,0,1);
			if(param_01.var_86FB == level.var_86D4.size - 2)
			{
				level.kick_afk_check = 1;
			}

			if(param_01.var_86FB == level.var_86D4.size - 1)
			{
				scripts\mp\_utility::playsoundonplayers("mp_enemy_obj_captured");
				level thread scripts\mp\_utility::func_115DE("callout_top_gun_rank",param_01);
			}

			if(param_01.var_86FB < level.var_86D4.size)
			{
				var_0E = scripts\mp\_rank::func_8104("gained_gun_rank");
				param_01 thread scripts\mp\_rank::func_EC42(var_0E);
				param_01 thread scripts\mp\_rank::func_EC2D("gained_gun_rank");
				param_01 playlocalsound("mp_war_objective_taken");
				param_01 thread func_8381(0);
				param_01 scripts\mp\_utility::func_F6FF(level.var_86D4[param_01.var_86FB],1);
			}

			if(isdefined(param_01.lastgunrankincreasetime) && gettime() - param_01.lastgunrankincreasetime < 5000)
			{
				param_01 scripts\mp\_awards::func_8380("mode_gun_quick_kill");
			}

			param_01.lastgunrankincreasetime = gettime();
		}
	}
}

//Function Number: 13
func_8381(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(!param_00)
	{
		scripts\common\utility::func_1C76(0);
	}

	var_01 = func_7FE5();
	var_01 = scripts\mp\_weapons::func_12E5C(var_01);
	scripts\mp\_utility::func_12C6(var_01);
	if(param_00)
	{
		self method_833B(var_01);
		foreach(var_03 in self.var_13CA0)
		{
			if(var_03 != var_01)
			{
				thread scripts\mp\_utility::func_11494(var_03);
			}
		}
	}

	self.pers["primaryWeapon"] = var_01;
	self.var_D8E1 = var_01;
	scripts\mp\_utility::_switchtoweapon(var_01);
	var_05 = scripts\mp\_weapons::isaxeweapon(var_01);
	if(var_05)
	{
		self setweaponammoclip(var_01,1);
		thread func_11495("iw7_knife_mp_gg",0);
	}
	else if(self.var_86FB != level.var_86D4.size - 1)
	{
		self method_817C(var_01);
		self giveweapon("iw7_knife_mp_gg");
		self method_84E8("iw7_knife_mp_gg");
	}

	if(!param_00)
	{
		var_06 = self.var_A978;
		thread func_11495(var_06,1);
	}

	func_8385(var_01);
	scripts\mp\_weapons::func_12F48(var_01);
	self.var_86FC = self.var_86FB;
}

//Function Number: 14
func_11495(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		if(!scripts\mp\_utility::func_9DA5(param_00))
		{
			break;
		}

		scripts\common\utility::func_136F7();
	}

	scripts\mp\_utility::func_141E(param_00);
	if(param_01)
	{
		scripts\common\utility::func_1C76(1);
	}
}

//Function Number: 15
func_7FE5()
{
	var_00 = level.var_86D4[self.var_86FB];
	return var_00;
}

//Function Number: 16
func_C5B2()
{
	var_00 = func_7EFF();
	if(!isdefined(var_00) || !var_00.size)
	{
		thread scripts\mp\_gamelogic::endgame("tie",game["end_reason"]["time_limit_reached"]);
		return;
	}

	if(var_00.size == 1)
	{
		thread scripts\mp\_gamelogic::endgame(var_00[0],game["end_reason"]["time_limit_reached"]);
		return;
	}

	if(var_00[var_00.size - 1].var_86FB > var_00[var_00.size - 2].var_86FB)
	{
		thread scripts\mp\_gamelogic::endgame(var_00[var_00.size - 1],game["end_reason"]["time_limit_reached"]);
		return;
	}

	thread scripts\mp\_gamelogic::endgame("tie",game["end_reason"]["time_limit_reached"]);
}

//Function Number: 17
func_7EFF()
{
	var_00 = -1;
	var_01 = [];
	foreach(var_03 in level.players)
	{
		if(isdefined(var_03.var_86FB) && var_03.var_86FB >= var_00)
		{
			var_00 = var_03.var_86FB;
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 18
func_DE4B()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("reload");
		self method_817C(self.var_D8E1);
	}
}

//Function Number: 19
func_DE4F()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		if(scripts\mp\_utility::func_9F19(self) && self.team != "spectator" && isdefined(self.var_D8E1) && self method_80FB(self.var_D8E1) == 0)
		{
			if(getweaponbasename(self.var_D8E1) == "iw7_glprox_mp")
			{
				self givemaxammo(self.var_D8E1);
			}
			else
			{
				wait(2);
				self notify("reload");
				wait(1);
			}

			continue;
		}

		wait(0.05);
	}
}

//Function Number: 20
func_F733()
{
	level.var_86D4 = [];
	level.var_F1C3 = [];
	switch(level.var_A7A4)
	{
		case 1:
			level.var_86D4[0] = "rand_pistol";
			level.var_86D4[1] = "rand_shotgun";
			level.var_86D4[2] = "rand_smg";
			level.var_86D4[3] = "rand_assault";
			level.var_86D4[4] = "rand_lmg";
			level.var_86D4[5] = "rand_sniper";
			level.var_86D4[6] = "rand_smg";
			level.var_86D4[7] = "rand_assault";
			level.var_86D4[8] = "rand_lmg";
			level.var_86D4[9] = "rand_launcher";
			level.var_86D4[10] = "rand_shotgun";
			level.var_86D4[11] = "rand_smg";
			level.var_86D4[12] = "rand_assault";
			level.var_86D4[13] = "rand_shotgun";
			level.var_86D4[14] = "rand_assault";
			level.var_86D4[15] = "rand_sniper";
			level.var_86D4[16] = "iw7_g18_mpr";
			level.var_86D4[17] = "iw7_knife_mp";
			break;

		case 2:
			level.var_86D4[0] = "rand_pistol";
			level.var_86D4[1] = "rand_shotgun";
			level.var_86D4[2] = "rand_smg";
			level.var_86D4[3] = "rand_assault";
			level.var_86D4[4] = "rand_pistol";
			level.var_86D4[5] = "rand_shotgun";
			level.var_86D4[6] = "rand_smg";
			level.var_86D4[7] = "rand_assault";
			level.var_86D4[8] = "rand_pistol";
			level.var_86D4[9] = "rand_shotgun";
			level.var_86D4[10] = "rand_smg";
			level.var_86D4[11] = "rand_assault";
			level.var_86D4[12] = "rand_pistol";
			level.var_86D4[13] = "rand_shotgun";
			level.var_86D4[14] = "rand_smg";
			level.var_86D4[15] = "rand_assault";
			level.var_86D4[16] = "iw7_g18_mpr";
			level.var_86D4[17] = "iw7_knife_mp";
			break;

		case 3:
			level.var_86D4[0] = "rand_pistol";
			level.var_86D4[1] = "rand_assault";
			level.var_86D4[2] = "rand_lmg";
			level.var_86D4[3] = "rand_launcher";
			level.var_86D4[4] = "rand_sniper";
			level.var_86D4[5] = "rand_assault";
			level.var_86D4[6] = "rand_lmg";
			level.var_86D4[7] = "rand_launcher";
			level.var_86D4[8] = "rand_sniper";
			level.var_86D4[9] = "rand_assault";
			level.var_86D4[10] = "rand_lmg";
			level.var_86D4[11] = "rand_launcher";
			level.var_86D4[12] = "rand_sniper";
			level.var_86D4[13] = "rand_assault";
			level.var_86D4[14] = "rand_sniper";
			level.var_86D4[15] = "rand_assault";
			level.var_86D4[16] = "iw7_g18_mpl_single";
			level.var_86D4[17] = "iw7_knife_mp";
			break;

		case 4:
			level.var_86D4[0] = "rand_pistol_epic";
			level.var_86D4[1] = "rand_shotgun";
			level.var_86D4[2] = "rand_smg";
			level.var_86D4[3] = "rand_assault";
			level.var_86D4[4] = "rand_lmg";
			level.var_86D4[5] = "rand_sniper";
			level.var_86D4[6] = "rand_smg";
			level.var_86D4[7] = "rand_assault";
			level.var_86D4[8] = "rand_lmg";
			level.var_86D4[9] = "rand_smg";
			level.var_86D4[10] = "rand_shotgun";
			level.var_86D4[11] = "rand_smg";
			level.var_86D4[12] = "rand_assault";
			level.var_86D4[13] = "rand_shotgun";
			level.var_86D4[14] = "rand_assault";
			level.var_86D4[15] = "rand_sniper";
			level.var_86D4[16] = "rand_pistol_epic2";
			level.var_86D4[17] = "rand_melee_end_epic";
			break;
	}

	var_00 = level.var_86D4.size;
	setdynamicdvar("scr_gun_scorelimit",var_00);
	scripts\mp\_utility::func_DF0B(level.gametype,var_00);
}

//Function Number: 21
func_F736()
{
	level.var_F1C3 = [];
	func_3218();
	for(var_00 = 0;var_00 < level.var_86D4.size;var_00++)
	{
		var_01 = level.var_86D4[var_00];
		if(scripts\mp\_utility::isstrstart(var_01,"rand_"))
		{
			level.var_86D4[var_00] = func_80C7(var_01);
			continue;
		}

		var_02 = scripts\mp\_utility::func_8234(level.var_86D4[var_00]);
		level.var_F1C3[var_02] = 1;
		var_03 = var_02;
		var_04 = 0;
		var_03 = func_B93E(var_03,var_04);
		level.var_86D4[var_00] = var_03;
	}

	level.var_F1C3 = undefined;
}

//Function Number: 22
func_80AF()
{
	var_00 = randomint(120);
	if(var_00 > 100)
	{
		return "archetype_heavy";
	}

	if(var_00 > 80)
	{
		return "archetype_scout";
	}

	if(var_00 > 60)
	{
		return "archetype_assassin";
	}

	if(var_00 > 40)
	{
		return "archetype_engineer";
	}

	if(var_00 > 20)
	{
		return "archetype_sniper";
	}

	return "archetype_assault";
}

//Function Number: 23
func_F855()
{
	level.var_86D6["axis"]["loadoutPrimary"] = "iw7_revolver";
	level.var_86D6["axis"]["loadoutPrimaryAttachment"] = "none";
	level.var_86D6["axis"]["loadoutPrimaryAttachment2"] = "none";
	level.var_86D6["axis"]["loadoutPrimaryCamo"] = "none";
	level.var_86D6["axis"]["loadoutPrimaryReticle"] = "none";
	level.var_86D6["axis"]["loadoutSecondary"] = "none";
	level.var_86D6["axis"]["loadoutSecondaryAttachment"] = "none";
	level.var_86D6["axis"]["loadoutSecondaryAttachment2"] = "none";
	level.var_86D6["axis"]["loadoutSecondaryCamo"] = "none";
	level.var_86D6["axis"]["loadoutSecondaryReticle"] = "none";
	level.var_86D6["axis"]["loadoutEquipment"] = "specialty_null";
	level.var_86D6["axis"]["loadoutOffhand"] = "none";
	level.var_86D6["axis"]["loadoutStreakType"] = "assault";
	level.var_86D6["axis"]["loadoutKillstreak1"] = "none";
	level.var_86D6["axis"]["loadoutKillstreak2"] = "none";
	level.var_86D6["axis"]["loadoutKillstreak3"] = "none";
	level.var_86D6["axis"]["loadoutPerks"] = [];
	level.var_86D6["axis"]["loadoutGesture"] = "playerData";
	level.var_86D6["axis"]["loadoutJuggernaut"] = 0;
	level.var_86D6["allies"] = level.var_86D6["axis"];
}

//Function Number: 24
func_3218()
{
	level.var_13C7C = [];
	var_00 = 0;
	for(;;)
	{
		var_01 = tablelookupbyrow("mp/gunGameWeapons.csv",var_00,0);
		if(var_01 == "")
		{
			break;
		}

		if(!isdefined(level.var_13C7C[var_01]))
		{
			level.var_13C7C[var_01] = [];
		}

		var_02 = tablelookupbyrow("mp/gunGameWeapons.csv",var_00,5);
		if(var_02 == "" || getdvarint(var_02,0) == 1)
		{
			var_03 = [];
			var_03["weapon"] = tablelookupbyrow("mp/gunGameWeapons.csv",var_00,1);
			var_03["min"] = int(tablelookupbyrow("mp/gunGameWeapons.csv",var_00,2));
			var_03["max"] = int(tablelookupbyrow("mp/gunGameWeapons.csv",var_00,3));
			var_03["perk"] = tablelookupbyrow("mp/gunGameWeapons.csv",var_00,4);
			var_03["variant"] = getlootvariant(var_03["weapon"]);
			var_03["allowed"] = int(tablelookupbyrow("mp/gunGameWeapons.csv",var_00,7));
			if(level.var_A7A4 == 4 && var_03["variant"] == "")
			{
				var_00++;
				continue;
			}

			level.var_13C7C[var_01][level.var_13C7C[var_01].size] = var_03;
		}

		var_00++;
	}
}

//Function Number: 25
func_80C7(param_00)
{
	var_01 = level.var_13C7C[param_00];
	if(isdefined(var_01) && var_01.size > 0)
	{
		var_02 = "";
		var_03 = undefined;
		var_04 = 0;
		for(;;)
		{
			var_05 = randomintrange(0,var_01.size);
			var_03 = var_01[var_05];
			var_06 = scripts\mp\_utility::func_8234(var_03["weapon"]);
			var_07 = 1;
			if(level.var_A7A4 == 4)
			{
				var_07 = var_03["allowed"];
			}

			if((!isdefined(level.var_F1C3[var_06]) && var_07) || var_04 > var_01.size)
			{
				level.var_F1C3[var_06] = 1;
				var_02 = var_03["weapon"];
				for(var_08 = 0;var_08 < level.var_13C7C[param_00].size;var_08++)
				{
					if(level.var_13C7C[param_00][var_08]["weapon"] == var_02)
					{
						level.var_13C7C[param_00] = scripts\mp\_utility::func_22B0(level.var_13C7C[param_00],var_08);
						break;
					}
				}

				break;
			}

			var_04++;
		}

		if(var_02 == var_06)
		{
			var_09 = randomintrange(var_03["min"],var_03["max"] + 1);
			var_02 = func_B93E(var_02,var_09,var_03);
		}

		return var_02;
	}

	return "none";
}

//Function Number: 26
getlootvariant(param_00)
{
	var_01 = [];
	var_02 = "";
	var_03 = scripts\mp\_utility::func_8234(param_00);
	var_01 = tablelookup("mp/gunGameWeapons.csv",1,var_03,6);
	if(var_01.size > 0)
	{
		if(var_01.size > 1)
		{
			var_01 = strtok(var_01,"+");
			var_02 = scripts\common\utility::random(var_01);
		}
		else
		{
			var_02 = var_01[0];
		}

		var_04 = "mp/loot/weapon/" + var_03 + ".csv";
		var_05 = tablelookup(var_04,0,int(var_02),1);
		var_06 = tablelookup("mp/loot/iw7_weapon_loot_master.csv",1,var_05,1);
		if(var_06 == "")
		{
			var_02 = "";
		}
	}

	return var_02;
}

//Function Number: 27
checkmk2variant(param_00,param_01)
{
	var_02 = tablelookup(param_00,0,int(param_01),1);
	if(issubstr(var_02,"mk2stub"))
	{
		return param_01;
	}

	var_03 = randomint(100);
	if(var_03 < 25)
	{
		var_04 = int(param_01);
		var_04 = var_04 + 32;
		param_01 = tablelookup(param_00,0,var_04,0);
	}

	return param_01;
}

//Function Number: 28
func_B93E(param_00,param_01,param_02)
{
	var_03 = [];
	var_04 = 0;
	var_05 = level.var_A7A4 == 4;
	var_06 = "";
	if(isdefined(param_02) && param_02["variant"] != "")
	{
		var_06 = param_02["variant"];
	}

	var_07 = var_06 != "";
	var_08 = "mp/loot/weapon/" + param_00 + ".csv";
	if(param_01 > 0)
	{
		var_09 = scripts\mp\_utility::func_8217(param_00);
		if(var_09.size > 0)
		{
			var_0A = func_81F5(var_09,var_05,param_00,var_08,var_06);
			var_0B = var_0A.size;
			for(var_0C = 0;var_0C < param_01;var_0C++)
			{
				var_0D = "";
				while(var_0D == "" && var_0B > 0)
				{
					var_0B--;
					var_0E = randomint(var_0A.size);
					if(func_248A(var_0A[var_0E],var_03))
					{
						var_0D = var_0A[var_0E];
						var_03[var_03.size] = var_0D;
						if(scripts\mp\_utility::getattachmenttype(var_0D) == "rail")
						{
							var_04 = 1;
						}
					}
				}
			}
		}
	}

	var_0F = "none";
	var_10 = "none";
	if(scripts\mp\_utility::func_9FB3(var_05) && var_07)
	{
		var_11 = scripts\mp\_class::func_3224(param_00,var_03,var_0F,var_10,int(var_06));
	}
	else
	{
		var_11 = scripts\mp\_class::func_3224(param_01,var_04,var_10,var_11);
	}

	return var_11;
}

//Function Number: 29
func_248A(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_01.size;var_02++)
	{
		if(param_00 == param_01[var_02] || !scripts\mp\_utility::func_249D(param_00,param_01[var_02]))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 30
func_81F5(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = [];
	var_06 = [];
	var_07 = [];
	if(scripts\mp\_utility::func_9FB3(param_01) && param_04 != "")
	{
		var_06 = tablelookup(param_03,0,int(param_04),17);
		var_06 = strtok(var_06,"+");
		var_07 = tablelookup(param_03,0,int(param_04),18);
		var_07 = strtok(var_07,"+");
		for(var_08 = 0;var_08 < var_06.size;var_08++)
		{
			var_06[var_08] = scripts\mp\_utility::func_2494(var_06[var_08]);
		}
	}

	foreach(var_0A in param_00)
	{
		var_0B = scripts\mp\_utility::getattachmenttype(var_0A);
		if(var_07.size > 0 && scripts\common\utility::func_2286(var_07,var_0B))
		{
			continue;
		}

		if(var_06.size > 0 && scripts\common\utility::func_2286(var_06,var_0A))
		{
			continue;
		}

		switch(var_0A)
		{
			case "silencer":
				break;

			default:
				var_05[var_05.size] = var_0A;
				break;
		}
	}

	return var_05;
}

//Function Number: 31
func_8385(param_00)
{
	var_01 = "primary";
	var_02 = scripts\mp\_powers::func_808C(var_01);
	if(isdefined(var_02))
	{
		scripts\mp\_powers::func_E15E(var_02);
	}

	if(scripts\mp\_weapons::func_9E6D(param_00) || scripts\mp\_weapons::isaxeweapon(param_00))
	{
		scripts\mp\_utility::func_8387("specialty_scavenger");
		scripts\mp\_utility::func_8387("specialty_pitcher");
		scripts\mp\_powers::func_8397("power_bioSpike",var_01,undefined,undefined,1);
	}
}

//Function Number: 32
func_9FE8(param_00)
{
	return param_00 == "throwingknifec4_mp";
}

//Function Number: 33
func_C579(param_00,param_01,param_02)
{
	param_01 scripts\mp\_utility::func_93DF("gamemodeScore",param_02,1);
	var_03 = param_01 scripts\mp\_utility::getpersstat("gamemodeScore");
	param_01 scripts\mp\_persistence::func_10E56("round","gamemodeScore",var_03);
	var_04 = 0;
	if(param_00 == "gained_gun_score")
	{
		var_04 = 1;
	}
	else if(param_00 == "dropped_gun_score")
	{
		var_05 = level.var_F654;
		var_04 = var_05 * -1;
	}
	else if(param_00 == "assist_ffa" || param_00 == "kill")
	{
		param_01 scripts\mp\_utility::func_316C("earned_score_buffered",param_02);
	}

	return var_04;
}

//Function Number: 34
updateknivesperminute()
{
	if(!isdefined(self.knivesperminute))
	{
		self.numknives = 0;
		self.knivesperminute = 0;
	}

	self.numknives++;
	if(scripts\mp\_utility::func_7FB9() < 1)
	{
		return;
	}

	self.knivesperminute = self.numknives / scripts\mp\_utility::func_7FB9();
}

//Function Number: 35
modifyunifiedpointscallback(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03) && param_03 == "iw7_knife_mp_gg" || param_03 == "iw7_knife_mp")
	{
		if(isdefined(param_02) && isdefined(param_02.knivesperminute) && param_02.knivesperminute >= 10)
		{
			return 0;
		}
	}

	return param_00;
}