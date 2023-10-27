/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\gametypes\infect.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 42
 * Decompile Time: 2069 ms
 * Timestamp: 10/27/2023 12:12:39 AM
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
		scripts\mp\_utility::setoverridewatchdvar("scorelimit",0);
		scripts\mp\_utility::func_DF08(level.gametype,1);
		scripts\mp\_utility::func_DF1A(level.gametype,1);
		scripts\mp\_utility::func_DF02(level.gametype,0);
		scripts\mp\_utility::func_DEF4(level.gametype,0);
		level.var_C233 = 1;
		level.var_B40A = 0;
		level.var_112E8 = "iw7_spasc";
	}

	func_12E9F();
	level thread func_F856();
	level.ignorekdrstats = 1;
	level.teambased = 1;
	level.var_112C2 = 0;
	level.var_55EE = 1;
	level.var_C024 = 1;
	level.var_C5A4 = ::func_C5A4;
	level.onspawnplayer = ::onspawnplayer;
	level.var_8136 = ::func_8136;
	level.var_C577 = ::func_C577;
	level.var_C4E8 = ::func_C4E8;
	level.var_C5B2 = ::func_C5B2;
	level.var_3328 = ::func_1D5F;
	if(level.var_B40A)
	{
		level.var_B93A = ::scripts\mp\_damage::func_7678;
	}

	game["dialog"]["gametype"] = "infected";
	if(getdvarint("g_hardcore"))
	{
		game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
	}

	game["dialog"]["offense_obj"] = "survive";
}

//Function Number: 2
func_987C()
{
	scripts\mp\_utility::func_F69D();
	setdynamicdvar("scr_infect_numInitialInfected",getmatchrulesdata("infectData","numInitialInfected"));
	setdynamicdvar("scr_infect_weaponSurvivorPrimary",getmatchrulesdata("infectData","weaponSurvivorPrimary"));
	setdynamicdvar("scr_infect_weaponSurvivorSecondary",getmatchrulesdata("infectData","weaponSurvivorSecondary"));
	setdynamicdvar("scr_infect_lethalSurvivor",getmatchrulesdata("infectData","lethalSurvivor"));
	setdynamicdvar("scr_infect_tacticalSurvivor",getmatchrulesdata("infectData","tacticalSurvivor"));
	setdynamicdvar("scr_infect_superSurvivor",getmatchrulesdata("infectData","superSurvivor"));
	setdynamicdvar("scr_infect_weaponInfectPrimary",getmatchrulesdata("infectData","weaponInfectPrimary"));
	setdynamicdvar("scr_infect_weaponInfectSecondary",getmatchrulesdata("infectData","weaponInfectSecondary"));
	setdynamicdvar("scr_infect_lethalInfect",getmatchrulesdata("infectData","lethalInfect"));
	setdynamicdvar("scr_infect_tacticalInfect",getmatchrulesdata("infectData","tacticalInfect"));
	setdynamicdvar("scr_infect_weaponInitialPrimary",getmatchrulesdata("infectData","weaponInitialPrimary"));
	setdynamicdvar("scr_infect_weaponInitialSecondary",getmatchrulesdata("infectData","weaponInitialSecondary"));
	setdynamicdvar("scr_infect_superInfect",getmatchrulesdata("infectData","superInfect"));
	setdynamicdvar("scr_infect_infectExtraTimePerKill",getmatchrulesdata("infectData","infectExtraTimePerKill"));
	setdynamicdvar("scr_infect_survivorAliveScore",getmatchrulesdata("infectData","survivorAliveScore"));
	setdynamicdvar("scr_infect_survivorScoreTime",getmatchrulesdata("infectData","survivorScoreTime"));
	setdynamicdvar("scr_infect_survivorScorePerTick",getmatchrulesdata("infectData","survivorScorePerTick"));
	setdynamicdvar("scr_infect_infectStreakBonus",getmatchrulesdata("infectData","infectStreakBonus"));
	setdynamicdvar("scr_infect_enableInfectedTracker",getmatchrulesdata("infectData","enableInfectedTracker"));
	setdynamicdvar("scr_infect_enablePing",getmatchrulesdata("infectData","enablePing"));
	setdynamicdvar("scr_team_fftype",0);
	setdynamicdvar("scr_infect_promode",0);
}

//Function Number: 3
func_C5A4()
{
	setclientnamemode("auto_change");
	scripts\mp\_utility::func_F7C1("allies",&"OBJECTIVES_INFECT");
	scripts\mp\_utility::func_F7C1("axis",&"OBJECTIVES_INFECT");
	if(level.splitscreen)
	{
		scripts\mp\_utility::func_F7C0("allies",&"OBJECTIVES_INFECT");
		scripts\mp\_utility::func_F7C0("axis",&"OBJECTIVES_INFECT");
	}
	else
	{
		scripts\mp\_utility::func_F7C0("allies",&"OBJECTIVES_INFECT_SCORE");
		scripts\mp\_utility::func_F7C0("axis",&"OBJECTIVES_INFECT_SCORE");
	}

	scripts\mp\_utility::func_F7BE("allies",&"OBJECTIVES_INFECT_HINT");
	scripts\mp\_utility::func_F7BE("axis",&"OBJECTIVES_INFECT_HINT");
	func_98CE();
	var_00[0] = level.gametype;
	scripts\mp\_gameobjects::main(var_00);
	level.var_DB9E = 1;
	level.var_2BBE = 1;
	level.var_940D = 0;
	level.var_9415 = 0;
	level.var_9410 = 0;
	level.var_940F = 0;
	level.var_940E = 0;
	level.var_9411 = 0;
	level.var_9417["axis"] = 0;
	level.var_9417["allies"] = 0;
	level.var_9414 = [];
	level thread func_C56E();
}

//Function Number: 4
func_12E9F()
{
	scripts\mp\gametypes\common::func_12E9F();
	level.var_C233 = scripts\mp\_utility::dvarintvalue("numInitialInfected",1,1,6);
	level.var_112E8 = getdvar("scr_infect_weaponSurvivorPrimary","iw7_spasc");
	level.var_112EC = getdvar("scr_infect_weaponSurvivorSecondary","iw7_g18");
	level.var_112E7 = getdvar("scr_infect_lethalSurvivor","power_tripMine");
	level.var_112EE = getdvar("scr_infect_tacticalSurvivor","power_concussionGrenade");
	level.var_112ED = getdvar("scr_infect_superSurvivor","super_phaseshift");
	level.var_941C = getdvar("scr_infect_weaponInfectPrimary","iw7_knife");
	level.var_941E = getdvar("scr_infect_weaponInfectSecondary","iw7_fists");
	level.var_987F = getdvar("scr_infect_weaponInitialPrimary","iw7_spasc");
	level.var_9880 = getdvar("scr_infect_weaponInitialSecondary","iw7_g18");
	level.var_941B = getdvar("scr_infect_lethalInfect","power_throwingKnife");
	level.var_9420 = getdvar("scr_infect_tacticalInfect","power_tacInsert");
	level.var_941F = getdvar("scr_infect_superInfect","super_reaper");
	level.var_9422 = scripts\mp\_utility::dvarfloatvalue("infectExtraTimePerKill",30,0,60);
	level.var_112E6 = scripts\mp\_utility::dvarintvalue("survivorAliveScore",25,0,100);
	level.var_112EB = scripts\mp\_utility::dvarfloatvalue("survivorScoreTime",30,0,60);
	level.var_112EA = scripts\mp\_utility::dvarintvalue("survivorScorePerTick",50,0,100);
	level.var_9423 = scripts\mp\_utility::dvarintvalue("infectStreakBonus",50,0,100);
	level.var_626A = scripts\mp\_utility::dvarintvalue("enableInfectedTracker",0,0,1);
	level.var_6277 = scripts\mp\_utility::dvarintvalue("enablePing",0,0,1);
	level.allweapons = [];
	level.allweapons[level.allweapons.size] = level.var_112E8;
	level.allweapons[level.allweapons.size] = level.var_112EC;
	level.allweapons[level.allweapons.size] = level.var_941C;
	level.allweapons[level.allweapons.size] = level.var_941E;
	level.allweapons[level.allweapons.size] = level.var_987F;
	level.allweapons[level.allweapons.size] = level.var_9880;
	level.var_112E8 = func_11153(level.var_112E8);
	level.var_112EC = func_11153(level.var_112EC);
	level.var_941C = func_11153(level.var_941C);
	level.var_941E = func_11153(level.var_941E);
	level.var_987F = func_11153(level.var_987F);
	level.var_9880 = func_11153(level.var_9880);
}

//Function Number: 5
func_11153(param_00)
{
	if(issubstr(param_00,"mpr"))
	{
		param_00 = scripts\mp\_utility::strip_suffix(param_00,"_mpr");
	}
	else if(issubstr(param_00,"mpl"))
	{
		param_00 = scripts\mp\_utility::strip_suffix(param_00,"_mpl");
	}
	else
	{
		param_00 = scripts\mp\_utility::strip_suffix(param_00,"_mp");
	}

	return param_00;
}

//Function Number: 6
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.var_7675 = 1;
		var_00.var_7676 = 1;
		var_00.var_941D = 0;
		var_00.waitedtospawn = 0;
		if(!scripts\mp\_utility::func_766C("prematch_done") || level.var_9411)
		{
			var_00.waitedtospawn = 1;
		}

		var_00.pers["class"] = "gamemode";
		var_00.pers["lastClass"] = "";
		var_00.var_4004 = var_00.pers["class"];
		var_00.var_A95C = var_00.pers["lastClass"];
		var_00 loadweaponsforplayer(level.allweapons);
		if(scripts\mp\_utility::func_766C("prematch_done"))
		{
			var_00.var_7676 = 0;
			if(isdefined(level.var_9410) && level.var_9410)
			{
				var_00.var_112E1 = gettime();
			}
		}

		if(isdefined(level.var_9414[var_00.name]))
		{
			var_00.var_941D = 1;
		}

		if(isdefined(var_00.var_9E49))
		{
			var_00.pers["gamemodeLoadout"] = level.var_9413["axis_initial"];
		}
		else if(var_00.var_941D)
		{
			var_00.pers["gamemodeLoadout"] = level.var_9413["axis"];
		}
		else
		{
			var_00.pers["gamemodeLoadout"] = level.var_9413["allies"];
			var_00 setrandomrigifscout();
		}

		var_00 thread func_BA2E();
	}
}

//Function Number: 7
func_83AB()
{
	level endon("game_ended");
	for(;;)
	{
		wait(level.var_112EB);
		foreach(var_01 in level.players)
		{
			if(var_01.team == "allies")
			{
				var_01 thread scripts\mp\_utility::func_83B4("survivor",undefined,level.var_112EA);
			}
		}
	}
}

//Function Number: 8
func_98CE()
{
	scripts\mp\_spawnlogic::func_F62D("TDM");
	level.var_108E4 = (0,0,0);
	level.var_108E2 = (0,0,0);
	scripts\mp\_spawnlogic::func_1829("allies","mp_tdm_spawn");
	scripts\mp\_spawnlogic::func_1829("allies","mp_tdm_spawn_secondary",1,1);
	scripts\mp\_spawnlogic::func_1829("axis","mp_tdm_spawn");
	scripts\mp\_spawnlogic::func_1829("axis","mp_tdm_spawn_secondary",1,1);
	level.var_B32E = scripts\mp\_spawnlogic::func_6CAF(level.var_108E4,level.var_108E2);
	function_01B4(level.var_B32E);
}

//Function Number: 9
func_1D5F()
{
	return "gamemode";
}

//Function Number: 10
func_8136()
{
	if(isplayer(self) && self.var_7675)
	{
		self.var_7675 = 0;
		self.pers["class"] = "gamemode";
		self.pers["lastClass"] = "";
		self.var_4004 = self.pers["class"];
		self.var_A95C = self.pers["lastClass"];
		var_00 = "allies";
		if(self.var_941D)
		{
			var_00 = "axis";
		}

		scripts\mp\_menus::func_185F(var_00,1);
		thread func_B9C9();
	}

	if(level.ingraceperiod)
	{
		var_01 = scripts\mp\_spawnlogic::func_8140("mp_tdm_spawn");
		var_02 = scripts\mp\_spawnlogic::func_813C(var_01);
	}
	else
	{
		var_01 = scripts\mp\_spawnlogic::func_81BA(self.pers["team"]);
		var_03 = scripts\mp\_spawnlogic::func_81A9(self.pers["team"]);
		var_02 = scripts\mp\_spawnscoring::func_8136(var_01,var_03);
	}

	return var_02;
}

//Function Number: 11
onspawnplayer()
{
	self.var_115C5 = undefined;
	self.var_9416 = self.origin;
	self.var_941A = 0;
	func_12F3C();
	if(!level.var_940F)
	{
		level.var_940F = 1;
		level thread func_3ED9();
	}

	if(!scripts\mp\_utility::func_766C("prematch_done") || level.var_9411)
	{
		self.waitedtospawn = 0;
	}

	if(self.var_941D)
	{
		if(!level.var_940D)
		{
			level notify("infect_stopCountdown");
			level.var_9410 = 1;
			level.var_940D = 1;
			foreach(var_01 in level.players)
			{
				if(isdefined(var_01.var_9412))
				{
					var_01.var_9412 = undefined;
				}
			}
		}

		foreach(var_01 in level.players)
		{
			if(isdefined(var_01.var_9E49))
			{
				var_01 thread func_F75B();
			}
		}

		if(level.var_9417["axis"] == 1)
		{
			self.var_9E49 = 1;
		}

		func_98D6(1);
	}

	thread func_C59E();
	level notify("spawned_player");
}

//Function Number: 12
func_10924()
{
	var_00 = self getweaponslistprimaries();
	var_01 = self getcurrentprimaryweapon();
	if(var_00.size > 1)
	{
		if(scripts\mp\_weapons::func_9E6D(var_01))
		{
			foreach(var_03 in var_00)
			{
				if(var_03 != var_01)
				{
					self method_833B(var_03);
				}
			}
		}
	}
}

//Function Number: 13
func_F6B6(param_00)
{
	var_01 = 1;
	if(isdefined(self.var_9E49))
	{
		if(scripts\mp\_utility::func_9FC2(param_00,1))
		{
			var_01 = 0;
		}
	}
	else if(scripts\mp\_utility::func_9FC2(param_00,0))
	{
		var_01 = 0;
	}

	return var_01;
}

//Function Number: 14
func_C59E()
{
	self endon("death");
	self endon("disconnect");
	self waittill("giveLoadout");
	if(scripts\mp\_utility::func_9FB3(self.waitedtospawn))
	{
		self.waitedtospawn = 0;
		wait(0.1);
		self suicide();
	}

	self.var_A8D0 = self.var_9419;
	self.var_2049 = 0;
	self.var_204A = 0;
	if(self.pers["team"] == "allies")
	{
		if(level.var_6277)
		{
			scripts\mp\_utility::func_8387("specialty_boom");
		}

		func_10924();
		var_00 = "primary";
		var_01 = scripts\mp\_powers::func_808C(var_00);
		if(isdefined(var_01))
		{
			scripts\mp\_powers::func_E15E(var_01);
		}

		scripts\mp\_powers::func_8397(level.var_112E7,var_00,0);
		var_00 = "secondary";
		var_01 = scripts\mp\_powers::func_808C(var_00);
		if(isdefined(var_01))
		{
			scripts\mp\_powers::func_E15E(var_01);
		}

		scripts\mp\_powers::func_8397(level.var_112EE,var_00,0);
		managefists(level.var_112E8,level.var_112EC);
	}
	else if(self.pers["team"] == "axis")
	{
		if(level.var_6277)
		{
			scripts\mp\_utility::func_8387("specialty_boom");
		}

		refundinfectedsuper();
		thread func_F757();
		if(!level.var_112C1)
		{
			var_02 = 1.1;
		}
		else
		{
			var_02 = 1.05;
		}

		var_03 = int(floor(level.var_9417["axis"] / 3));
		var_03 = var_03 * 0.012;
		var_02 = var_02 - var_03;
		self.var_C829 = var_02;
		scripts\mp\_weapons::func_12ED5();
		var_00 = "primary";
		var_01 = scripts\mp\_powers::func_808C(var_00);
		if(isdefined(var_01))
		{
			scripts\mp\_powers::func_E15E(var_01);
		}

		scripts\mp\_powers::func_8397(level.var_941B,var_00,0);
		if(level.var_9420 != "power_tacInsert")
		{
			var_00 = "secondary";
			var_01 = scripts\mp\_powers::func_808C(var_00);
			if(isdefined(var_01))
			{
				scripts\mp\_powers::func_E15E(var_01);
			}

			scripts\mp\_powers::func_8397(level.var_9420,var_00,0);
		}
		else
		{
			scripts\mp\_utility::func_8387("specialty_tacticalinsertion");
		}

		if(scripts\mp\_utility::func_9FB3(self.var_9E49))
		{
			managefists(level.var_987F,level.var_9880);
		}
		else
		{
			managefists(level.var_941C,level.var_941E);
		}

		self setscriptablepartstate("infected","active",0);
	}

	giveextrainfectedperks();
	var_04 = scripts\mp\_utility::func_8234(self.var_AE7F);
	if(var_04 != "iw7_knife")
	{
		self giveweapon("iw7_knife_mp_infect");
		self method_84E8("iw7_knife_mp_infect");
		if(self.var_AE94 == "iw7_knife")
		{
			scripts\mp\_utility::func_11494("iw7_knife_mp");
			self giveweapon("iw7_knife_mp_infect2");
		}
	}

	self.var_6BA5 = undefined;
}

//Function Number: 15
managefists(param_00,param_01)
{
	if(param_00 != "iw7_fists" || param_01 != "iw7_fists")
	{
		if(param_00 == "none" && param_01 == "none")
		{
			return;
		}

		scripts\mp\_utility::func_11494("iw7_fists_mp");
	}
}

//Function Number: 16
giveextrainfectedperks()
{
	if(self.pers["team"] == "allies")
	{
		var_00 = ["specialty_fastreload","passive_gore","passive_nuke","passive_refresh"];
	}
	else if(scripts\mp\_utility::func_9FB3(self.var_9E49))
	{
		var_00 = ["specialty_longersprint","specialty_quickdraw","specialty_falldamage","specialty_bulletaccuracy","specialty_quickswap"];
	}
	else
	{
		var_00 = ["specialty_longersprint","specialty_quickdraw","specialty_falldamage"];
	}

	foreach(var_02 in var_00)
	{
		scripts\mp\_utility::func_8387(var_02);
	}
}

//Function Number: 17
func_F756()
{
}

//Function Number: 18
func_F757()
{
	if(isdefined(self.var_9E49))
	{
		if(!isdefined(self.var_1013F) || !self.var_1013F)
		{
			thread scripts\mp\_rank::func_EC2D("first_infected");
			self.var_1013F = 1;
			return;
		}

		return;
	}

	if(isdefined(self.var_3C62))
	{
		self.var_3C62 = undefined;
		if(isdefined(self.var_3C63))
		{
			self.var_3C63 = undefined;
			thread scripts\mp\_utility::func_83B4("first_infected");
			return;
		}

		return;
	}

	if(!isdefined(self.var_1013F) || !self.var_1013F)
	{
		thread scripts\mp\_rank::func_EC2D("got_infected");
		self.var_1013F = 1;
		return;
	}
}

//Function Number: 19
func_3ED9()
{
	level endon("game_ended");
	level endon("infect_stopCountdown");
	level endon("force_end");
	level.var_940D = 0;
	scripts\mp\_utility::func_7670("prematch_done");
	level.var_9411 = 1;
	scripts\mp\_hostmigration::func_13708(1);
	setomnvar("ui_match_start_text","first_infected_in");
	var_00 = 15;
	while(var_00 > 0 && !level.var_7669)
	{
		setomnvar("ui_match_start_countdown",var_00);
		var_00--;
		scripts\mp\_hostmigration::func_13708(1);
	}

	setomnvar("ui_match_start_countdown",0);
	level.var_9411 = 0;
	var_01 = [];
	foreach(var_03 in level.players)
	{
		if(scripts\mp\_utility::func_B3EC() && level.players.size > 1 && var_03 ishost())
		{
			continue;
		}

		if(var_03.team == "spectator")
		{
			continue;
		}

		if(!var_03.var_8C2A)
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	var_05 = undefined;
	if(var_01.size <= level.var_C233 && var_01.size > 1)
	{
		level.var_C233 = var_01.size - 1;
	}

	for(var_06 = 0;var_06 < level.var_C233;var_06++)
	{
		var_05 = var_01[randomint(var_01.size)];
		var_05 func_F707(1);
		var_01 = scripts\common\utility::func_22A9(var_01,var_05);
	}

	level.var_940D = 1;
	foreach(var_03 in level.players)
	{
		if(var_03 == var_05)
		{
			continue;
		}

		var_03.var_112E1 = gettime();
	}
}

//Function Number: 20
func_F707(param_00)
{
	self endon("disconnect");
	self endon("death");
	if(param_00)
	{
		self.var_9412 = 1;
	}

	while(!scripts\mp\_utility::func_9F19(self) || scripts\mp\_utility::func_9FC6())
	{
		wait(0.05);
	}

	if(isdefined(self.var_9D81) && self.var_9D81 == 1)
	{
		self notify("force_cancel_placement");
		wait(0.05);
	}

	while(self ismantling())
	{
		wait(0.05);
	}

	if(scripts\mp\_utility::func_9E59())
	{
		self notify("lost_juggernaut");
		wait(0.05);
	}

	while(!isalive(self))
	{
		scripts\common\utility::func_136F7();
	}

	if(param_00)
	{
		scripts\mp\_menus::func_185F("axis",undefined,1);
		thread func_B9C9();
		level.var_9410 = 1;
		self.var_9412 = undefined;
		func_12F3C();
		self playlocalsound("breathing_better_c6");
	}

	self.var_9E49 = 1;
	self.pers["gamemodeLoadout"] = level.var_9413["axis_initial"];
	if(isdefined(self.var_F851))
	{
		scripts\mp\perks\_perkfunctions::func_51D7(self.var_F851);
	}

	var_01 = spawn("script_model",self.origin);
	var_01.angles = self.angles;
	var_01.var_D424 = self.origin;
	var_01.var_C188 = 1;
	self.var_F851 = var_01;
	self notify("faux_spawn");
	self.var_6BA6 = self getstance();
	self.var_6BA5 = 1;
	waittillframeend;
	thread scripts\mp\_playerlogic::func_108F2(1);
	if(param_00)
	{
		level.var_9414[self.name] = 1;
	}

	foreach(var_03 in level.players)
	{
		var_03 thread scripts\mp\_hud_message::func_10151("first_infected");
	}

	level thread scripts\mp\_utility::func_115DE("callout_first_infected",self);
	if(!level.var_9415)
	{
		scripts\mp\_utility::playsoundonplayers("mp_enemy_obj_captured");
		level.var_9415 = 1;
	}

	self iprintlnbold(&"SPLASHES_INFECT_ALL");
	func_98D6(1);
}

//Function Number: 21
func_F75B(param_00,param_01)
{
	level endon("game_ended");
	self endon("death");
	self.var_9E49 = undefined;
	self.var_3C62 = 1;
	if(isdefined(param_00))
	{
		self.var_3C63 = 1;
	}

	while(!scripts\mp\_utility::func_9F19(self))
	{
		wait(0.05);
	}

	if(isdefined(self.var_9D81) && self.var_9D81 == 1)
	{
		self notify("force_cancel_placement");
		wait(0.05);
	}

	while(self ismantling())
	{
		wait(0.05);
	}

	if(scripts\mp\_utility::func_9E59())
	{
		self notify("lost_juggernaut");
		wait(0.05);
	}

	while(self ismeleeing())
	{
		wait(0.05);
	}

	while(!scripts\mp\_utility::func_9F19(self))
	{
		wait(0.05);
	}

	self.pers["gamemodeLoadout"] = level.var_9413["axis"];
	if(isdefined(self.var_F851))
	{
		scripts\mp\perks\_perkfunctions::func_51D7(self.var_F851);
	}

	var_02 = spawn("script_model",self.origin);
	var_02.angles = self.angles;
	var_02.var_D424 = self.origin;
	var_02.var_C188 = 1;
	self.var_F851 = var_02;
	self notify("faux_spawn");
	self.var_6BA6 = self getstance();
	self.var_6BA5 = 1;
	scripts\common\utility::func_136F7();
	thread scripts\mp\_playerlogic::func_108F2(1);
}

//Function Number: 22
func_C577(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(level.var_7669)
	{
		return;
	}

	var_0A = 0;
	var_0B = 0;
	if(self.team == "axis")
	{
		self setscriptablepartstate("infected","neutral",0);
	}

	if(self.team == "allies" && isdefined(param_01))
	{
		if(isplayer(param_01) && param_01 != self)
		{
			var_0A = 1;
		}
		else if(level.var_940D && param_01 == self || !isplayer(param_01))
		{
			var_0A = 1;
			var_0B = 1;
		}
	}

	if(isplayer(param_01) && param_01.team == "allies" && param_01 != self)
	{
		param_01 thread scripts\mp\perks\_weaponpassives::func_8974(param_01,self);
		param_01 scripts\mp\_utility::func_93DF("killsAsSurvivor",1);
		param_01 scripts\mp\_persistence::func_10E56("round","killsAsSurvivor",param_01.pers["killsAsSurvivor"]);
	}
	else if(isplayer(param_01) && param_01.team == "axis" && param_01 != self)
	{
		param_01 scripts\mp\_utility::func_93DF("killsAsInfected",1);
		param_01 scripts\mp\_persistence::func_10E56("round","killsAsInfected",param_01.pers["killsAsInfected"]);
		if(isplayer(param_01))
		{
			param_01 scripts\mp\_utility::func_F6FB(param_01.pers["killsAsInfected"]);
		}
	}

	if(var_0A)
	{
		thread delayedprocesskill(param_01,var_0B);
		if(var_0B)
		{
			foreach(var_0D in level.players)
			{
				if(isdefined(var_0D.var_9E49))
				{
					var_0D thread func_F75B();
				}
			}
		}
		else if(isdefined(param_01.var_9E49))
		{
			foreach(var_0D in level.players)
			{
				if(isdefined(var_0D.var_9E49))
				{
					var_0D thread func_F75B(1);
				}
			}
		}
		else if(level.var_9423 > 0)
		{
			if(!isdefined(param_01.var_941A))
			{
				param_01.var_941A = 1;
			}
			else
			{
				param_01.var_941A++;
			}

			param_01 thread scripts\mp\_utility::func_83B4("infected_survivor",undefined,level.var_9423 * param_01.var_941A);
		}
		else
		{
			param_01 thread scripts\mp\_utility::func_83B4("infected_survivor");
		}

		if(scripts\mp\_utility::getwatcheddvar("timelimit") != 0)
		{
			if(!isdefined(level.var_6A53))
			{
				level.var_6A53 = level.var_9422 / 60;
			}
			else
			{
				level.var_6A53 = level.var_6A53 + level.var_9422 / 60;
			}
		}

		func_F86E(1);
		return;
	}

	if(isbot(self))
	{
		self.var_4009 = "gamemode";
	}

	if(isdefined(self.var_9E49))
	{
		self.pers["gamemodeLoadout"] = level.var_9413["axis_initial"];
		self.var_9419 = "axis_initial";
	}
	else
	{
		self.pers["gamemodeLoadout"] = level.var_9413[self.pers["team"]];
		self.var_9419 = self.pers["team"];
	}

	if(self.pers["team"] == "allies")
	{
		setrandomrigifscout();
	}
}

//Function Number: 23
delayedprocesskill(param_00,param_01)
{
	wait(0.15);
	self.var_115C5 = 1;
	scripts\mp\_menus::func_185F("axis");
	func_12F3C();
	level.var_9414[self.name] = 1;
	thread func_B9C9();
	if(level.var_9417["allies"] > 1)
	{
		scripts\mp\_utility::playsoundonplayers("mp_enemy_obj_captured","allies");
		scripts\mp\_utility::playsoundonplayers("mp_war_objective_taken","axis");
		thread scripts\mp\_utility::func_115DE("callout_got_infected",self,"allies");
		if(!param_01)
		{
			thread scripts\mp\_utility::func_115DE("callout_infected",param_00,"axis");
			if(!isdefined(level.var_112E9))
			{
				level.var_112E9 = scripts\mp\_rank::func_8104("survivor");
			}
			else
			{
				level.var_112E9 = level.var_112E9 + level.var_112E6;
			}

			foreach(var_03 in level.players)
			{
				if(!scripts\mp\_utility::func_9F19(var_03) || self.sessionstate == "spectator")
				{
					continue;
				}

				if(var_03.team == "allies" && var_03 != self && distance(var_03.var_9416,var_03.origin) > 32)
				{
					var_03 thread scripts\mp\_utility::func_83B4("survivor",undefined,level.var_112E9);
				}

				if(var_03.team == "axis" && var_03 != param_00 && var_03 != self)
				{
					var_03 thread scripts\mp\_utility::func_83B4("assist",undefined,50);
				}
			}
		}
	}
	else if(level.var_9417["allies"] == 1)
	{
		func_C527();
	}
	else if(level.var_9417["allies"] == 0)
	{
		func_C5AB();
	}

	if(isbot(self))
	{
		self.var_4009 = "gamemode";
	}

	if(isdefined(self.var_9E49))
	{
		self.pers["gamemodeLoadout"] = level.var_9413["axis_initial"];
		self.var_9419 = "axis_initial";
		return;
	}

	self.pers["gamemodeLoadout"] = level.var_9413[self.pers["team"]];
	self.var_9419 = self.pers["team"];
}

//Function Number: 24
func_C527()
{
	scripts\mp\_utility::playsoundonplayers("mp_obj_captured");
	foreach(var_01 in level.players)
	{
		if(!isdefined(var_01))
		{
			continue;
		}

		if(var_01.team == "allies")
		{
			var_01 thread scripts\mp\_rank::func_EC2D("final_survivor");
			if(!level.var_940E)
			{
				if(var_01.var_7676 && isdefined(var_01.var_9416) && distance(var_01.var_9416,var_01.origin) > 32)
				{
					var_01 thread scripts\mp\_utility::func_83B4("final_survivor");
				}

				level.var_940E = 1;
			}

			thread scripts\mp\_utility::func_115DE("callout_final_survivor",var_01);
			if(!var_01 scripts\mp\_utility::func_9E59())
			{
				level thread func_6C72(var_01);
			}

			break;
		}
	}
}

//Function Number: 25
func_6C72(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("eliminated");
	level endon("infect_lateJoiner");
	level thread func_6396(param_00);
	var_01 = 0;
	level.var_254["axis"] = "normal_radar";
	foreach(var_03 in level.players)
	{
		if(var_03.team == "axis")
		{
			var_03.var_254 = "normal_radar";
		}
	}

	var_05 = getuavstrengthlevelneutral();
	scripts\mp\killstreaks\_uav::_setteamradarstrength("axis",var_05 + 1);
	for(;;)
	{
		var_06 = param_00.origin;
		wait(4);
		if(var_01)
		{
			setteamradar("axis",0);
			var_01 = 0;
		}

		wait(6);
		if(distance(var_06,param_00.origin) < 200)
		{
			setteamradar("axis",1);
			var_01 = 1;
			foreach(var_03 in level.players)
			{
				var_03 playlocalsound("recondrone_tag");
			}
		}
	}
}

//Function Number: 26
func_6396(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("eliminated");
	for(;;)
	{
		if(level.var_9417["allies"] > 1)
		{
			level notify("infect_lateJoiner");
			wait(0.05);
			setteamradar("axis",0);
			break;
		}

		wait(0.05);
	}
}

//Function Number: 27
func_B9C9()
{
	level endon("game_ended");
	self endon("eliminated");
	self notify("infect_monitor_disconnect");
	self endon("infect_monitor_disconnect");
	var_00 = self.team;
	if(!isdefined(var_00) && isdefined(self.var_2EAC))
	{
		var_00 = self.var_2EAC;
	}

	self waittill("disconnect");
	func_12F3C();
	if(isdefined(self.var_9412) || level.var_9410)
	{
		if(level.var_9417["axis"] && level.var_9417["allies"])
		{
			if(var_00 == "allies" && level.var_9417["allies"] == 1)
			{
				func_C527();
			}
			else if(var_00 == "axis" && level.var_9417["axis"] == 1)
			{
				foreach(var_02 in level.players)
				{
					if(var_02 != self && var_02.team == "axis")
					{
						var_02 func_F707(0);
					}
				}
			}
		}
		else if(level.var_9417["allies"] == 0)
		{
			if(scripts\mp\_utility::func_9FB3(level.var_90A4))
			{
				scripts\mp\_hostmigration::func_13834();
			}

			func_C5AB();
		}
		else if(level.var_9417["axis"] == 0)
		{
			if(level.var_9417["allies"] == 1)
			{
				level thread scripts\mp\_gamelogic::endgame("allies",game["end_reason"]["axis_eliminated"]);
			}
			else if(level.var_9417["allies"] > 1)
			{
				level.var_9410 = 0;
				level thread func_3ED9();
			}
		}
	}
	else if(level.var_9411 && level.var_9417["allies"] == 0 && level.var_9417["axis"] == 0)
	{
		level notify("infect_stopCountdown");
		level.var_940F = 0;
		setomnvar("ui_match_start_countdown",0);
	}

	self.var_9E49 = undefined;
}

//Function Number: 28
func_C4E8(param_00)
{
}

//Function Number: 29
func_C5B2()
{
	level thread scripts\mp\_gamelogic::endgame("allies",game["end_reason"]["time_limit_reached"]);
}

//Function Number: 30
func_C5AB()
{
	level thread scripts\mp\_gamelogic::endgame("axis",game["end_reason"]["allies_eliminated"]);
}

//Function Number: 31
func_81B8(param_00)
{
	var_01 = 0;
	foreach(var_03 in level.players)
	{
		if(var_03.sessionstate == "spectator" && !var_03.var_2B0)
		{
			continue;
		}

		if(var_03.team == param_00)
		{
			var_01++;
		}
	}

	return var_01;
}

//Function Number: 32
func_12F3C()
{
	level.var_9417["allies"] = func_81B8("allies");
	game["teamScores"]["allies"] = level.var_9417["allies"];
	setteamscore("allies",level.var_9417["allies"]);
	level.var_9417["axis"] = func_81B8("axis");
	game["teamScores"]["axis"] = level.var_9417["axis"];
	setteamscore("axis",level.var_9417["axis"]);
}

//Function Number: 33
func_F856()
{
	wait(0.05);
	if(!isdefined(level.var_112E8) || level.var_112E8 == "")
	{
		level.var_112E8 = "iw7_spasc";
	}

	if(!isdefined(level.var_112EC) || level.var_112EC == "")
	{
		level.var_112EC = "iw7_g18";
	}

	if(!isdefined(level.var_941C) || level.var_941C == "")
	{
		level.var_941C = "iw7_knife";
	}

	if(!isdefined(level.var_941E) || level.var_941E == "")
	{
		level.var_941E = "iw7_fists";
	}

	if(!isdefined(level.var_987F) || level.var_987F == "")
	{
		level.var_987F = "iw7_spasc";
	}

	if(isdefined(level.var_941C) && level.var_941C == "iw7_knife")
	{
		level.var_941C = "iw7_knife_mp_infect2";
		if(isdefined(level.var_941E) && level.var_941E == "iw7_knife")
		{
			level.var_941E = "none";
		}
	}

	if(!isdefined(level.var_9880) || level.var_9880 == "")
	{
		level.var_9880 = "iw7_g18";
	}

	addsurvivorattachmentsprimary(level.var_112E8);
	addsurvivorattachmentssecondary(level.var_112EC);
	addinitialattachmentsprimary(level.var_987F);
	addinitialattachmentssecondary(level.var_9880);
	if(!isdefined(level.var_112E7) || level.var_112E7 == "")
	{
		level.var_112E7 = "power_tripMine";
	}

	if(!isdefined(level.var_112EE) || level.var_112EE == "")
	{
		level.var_112EE = "power_concussionGrenade";
	}

	if(!isdefined(level.var_941B) || level.var_941B == "")
	{
		level.var_941B = "power_throwingKnife";
	}

	if(!isdefined(level.var_9420) || level.var_9420 == "")
	{
		level.var_9420 = "none";
	}

	level.infect_allyrigs = [];
	level.infect_allyrigs[level.infect_allyrigs.size] = "archetype_assault";
	level.infect_allyrigs[level.infect_allyrigs.size] = "archetype_heavy";
	level.infect_allyrigs[level.infect_allyrigs.size] = "archetype_engineer";
	level.infect_allyrigs[level.infect_allyrigs.size] = "archetype_sniper";
	level.infect_allyrigs[level.infect_allyrigs.size] = "archetype_assassin";
	if(scripts\mp\_utility::func_9FC2("allies",0))
	{
		level.var_9413["allies"] = scripts\mp\_utility::func_7F92("allies",0);
	}
	else
	{
		level.var_9413["allies"]["loadoutPrimary"] = level.var_112E8;
		level.var_9413["allies"]["loadoutPrimaryAttachment"] = level.attachmentsurvivorprimary;
		level.var_9413["allies"]["loadoutPrimaryAttachment2"] = "none";
		level.var_9413["allies"]["loadoutPrimaryCamo"] = "none";
		level.var_9413["allies"]["loadoutPrimaryReticle"] = "none";
		level.var_9413["allies"]["loadoutSecondary"] = level.var_112EC;
		level.var_9413["allies"]["loadoutSecondaryAttachment"] = level.attachmentsurvivorsecondary;
		level.var_9413["allies"]["loadoutSecondaryAttachment2"] = level.attachmentsurvivorsecondarytwo;
		level.var_9413["allies"]["loadoutSecondaryCamo"] = "none";
		level.var_9413["allies"]["loadoutSecondaryReticle"] = "none";
		level.var_9413["allies"]["loadoutPowerPrimary"] = level.var_112E7;
		level.var_9413["allies"]["loadoutPowerSecondary"] = level.var_112EE;
		level.var_9413["allies"]["loadoutSuper"] = level.var_112ED;
		level.var_9413["allies"]["loadoutStreakType"] = "assault";
		level.var_9413["allies"]["loadoutKillstreak1"] = "none";
		level.var_9413["allies"]["loadoutKillstreak2"] = "none";
		level.var_9413["allies"]["loadoutKillstreak3"] = "none";
		level.var_9413["allies"]["loadoutJuggernaut"] = 0;
		level.var_9413["allies"]["loadoutPerks"] = ["specialty_scavenger","specialty_quieter"];
		level.var_9413["allies"]["loadoutGesture"] = "playerData";
		level.var_9413["allies"]["loadoutRigTrait"] = "specialty_null";
		if(level.var_6277)
		{
			level.var_9413["allies"]["loadoutRigTrait"] = "specialty_boom";
		}
	}

	if(scripts\mp\_utility::func_9FC2("axis",1))
	{
		level.var_9413["axis_initial"] = scripts\mp\_utility::func_7F92("axis",1);
		level.var_9413["axis_initial"]["loadoutStreakType"] = "assault";
		level.var_9413["axis_initial"]["loadoutKillstreak1"] = "none";
		level.var_9413["axis_initial"]["loadoutKillstreak2"] = "none";
		level.var_9413["axis_initial"]["loadoutKillstreak3"] = "none";
	}
	else
	{
		level.var_9413["axis_initial"]["loadoutArchetype"] = "archetype_scout";
		level.var_9413["axis_initial"]["loadoutPrimary"] = level.var_987F;
		level.var_9413["axis_initial"]["loadoutPrimaryAttachment"] = level.attachmentinitialprimary;
		level.var_9413["axis_initial"]["loadoutPrimaryAttachment2"] = "none";
		level.var_9413["axis_initial"]["loadoutPrimaryCamo"] = "none";
		level.var_9413["axis_initial"]["loadoutPrimaryReticle"] = "none";
		level.var_9413["axis_initial"]["loadoutSecondary"] = level.var_9880;
		level.var_9413["axis_initial"]["loadoutSecondaryAttachment"] = level.attachmentinitialsecondary;
		level.var_9413["axis_initial"]["loadoutSecondaryAttachment2"] = level.attachmentinitialsecondarytwo;
		level.var_9413["axis_initial"]["loadoutSecondaryCamo"] = "none";
		level.var_9413["axis_initial"]["loadoutSecondaryReticle"] = "none";
		level.var_9413["axis_initial"]["loadoutPowerPrimary"] = level.var_941B;
		level.var_9413["axis_initial"]["loadoutPowerSecondary"] = level.var_9420;
		level.var_9413["axis_initial"]["loadoutSuper"] = level.var_941F;
		level.var_9413["axis_initial"]["loadoutStreakType"] = "assault";
		level.var_9413["axis_initial"]["loadoutKillstreak1"] = "none";
		level.var_9413["axis_initial"]["loadoutKillstreak2"] = "none";
		level.var_9413["axis_initial"]["loadoutKillstreak3"] = "none";
		level.var_9413["axis_initial"]["loadoutJuggernaut"] = 0;
		level.var_9413["axis_initial"]["loadoutPerks"] = ["specialty_quieter"];
		level.var_9413["axis_initial"]["loadoutGesture"] = "playerData";
		level.var_9413["axis_initial"]["loadoutRigTrait"] = "specialty_null";
		if(level.var_626A)
		{
			level.var_9413["axis_initial"]["loadoutPerks"][level.var_9413["axis_initial"]["loadoutPerks"].size] = "specialty_tracker";
		}
	}

	if(scripts\mp\_utility::func_9FC2("axis",0))
	{
		level.var_9413["axis"] = scripts\mp\_utility::func_7F92("axis",0);
		level.var_9413["axis"]["loadoutStreakType"] = "assault";
		level.var_9413["axis"]["loadoutKillstreak1"] = "none";
		level.var_9413["axis"]["loadoutKillstreak2"] = "none";
		level.var_9413["axis"]["loadoutKillstreak3"] = "none";
		return;
	}

	level.var_9413["axis"]["loadoutArchetype"] = "archetype_scout";
	level.var_9413["axis"]["loadoutPrimary"] = level.var_941C;
	level.var_9413["axis"]["loadoutPrimaryAttachment"] = "none";
	level.var_9413["axis"]["loadoutPrimaryAttachment2"] = "none";
	level.var_9413["axis"]["loadoutPrimaryCamo"] = "none";
	level.var_9413["axis"]["loadoutPrimaryReticle"] = "none";
	level.var_9413["axis"]["loadoutSecondary"] = level.var_941E;
	level.var_9413["axis"]["loadoutSecondaryAttachment"] = "none";
	level.var_9413["axis"]["loadoutSecondaryAttachment2"] = "none";
	level.var_9413["axis"]["loadoutSecondaryCamo"] = "none";
	level.var_9413["axis"]["loadoutSecondaryReticle"] = "none";
	level.var_9413["axis"]["loadoutPowerPrimary"] = level.var_941B;
	level.var_9413["axis"]["loadoutPowerSecondary"] = level.var_9420;
	level.var_9413["axis"]["loadoutSuper"] = level.var_941F;
	level.var_9413["axis"]["loadoutStreakType"] = "assault";
	level.var_9413["axis"]["loadoutKillstreak1"] = "none";
	level.var_9413["axis"]["loadoutKillstreak2"] = "none";
	level.var_9413["axis"]["loadoutKillstreak3"] = "none";
	level.var_9413["axis"]["loadoutJuggernaut"] = 0;
	level.var_9413["axis"]["loadoutPerks"] = ["specialty_quieter"];
	level.var_9413["axis"]["loadoutGesture"] = "playerData";
	level.var_9413["axis"]["loadoutRigTrait"] = "specialty_null";
	if(level.var_626A)
	{
		level.var_9413["axis"]["loadoutPerks"][level.var_9413["axis"]["loadoutPerks"].size] = "specialty_tracker";
	}
}

//Function Number: 34
addsurvivorattachmentsprimary(param_00)
{
	level.attachmentsurvivorprimary = "none";
	var_01 = scripts\mp\_utility::func_8225(param_00);
	if(var_01 == "weapon_shotgun")
	{
		level.attachmentsurvivorprimary = "barrelrange";
		return;
	}

	if(var_01 == "weapon_assault" || var_01 == "weapon_smg" || var_01 == "weapon_lmg" || var_01 == "weapon_pistol" || param_00 == "iw7_m1c")
	{
		level.attachmentsurvivorprimary = "highcal";
	}
}

//Function Number: 35
addinitialattachmentsprimary(param_00)
{
	level.attachmentinitialprimary = "none";
	var_01 = scripts\mp\_utility::func_8225(param_00);
	if(var_01 == "weapon_shotgun")
	{
		level.attachmentinitialprimary = "barrelrange";
		return;
	}

	if(var_01 == "weapon_assault" || var_01 == "weapon_smg" || var_01 == "weapon_lmg" || var_01 == "weapon_pistol" || param_00 == "iw7_m1c")
	{
		level.attachmentinitialprimary = "highcal";
	}
}

//Function Number: 36
addsurvivorattachmentssecondary(param_00)
{
	level.attachmentsurvivorsecondary = "none";
	level.attachmentsurvivorsecondarytwo = "none";
	var_01 = scripts\mp\_utility::func_8225(param_00);
	if(var_01 == "weapon_pistol")
	{
		level.attachmentsurvivorsecondary = "highcal";
	}

	if(scripts\mp\_utility::func_B3EC())
	{
		if(param_00 == "iw7_g18c")
		{
			level.attachmentsurvivorsecondary = "akimbo";
			level.attachmentsurvivorsecondarytwo = "highcal";
		}
	}
}

//Function Number: 37
addinitialattachmentssecondary(param_00)
{
	level.attachmentinitialsecondary = "none";
	level.attachmentinitialsecondarytwo = "none";
	var_01 = scripts\mp\_utility::func_8225(param_00);
	if(var_01 == "weapon_pistol")
	{
		level.attachmentinitialsecondary = "highcal";
	}

	if(scripts\mp\_utility::func_B3EC())
	{
		if(param_00 == "iw7_g18c")
		{
			level.attachmentinitialsecondary = "akimbo";
			level.attachmentinitialsecondarytwo = "highcal";
		}
	}
}

//Function Number: 38
func_BA2E()
{
	self endon("death");
	self endon("disconnect");
	self endon("infected");
	level endon("game_ended");
	for(;;)
	{
		if(!level.var_9410 || !isdefined(self.var_112E1) || !isalive(self))
		{
			wait(0.05);
			continue;
		}

		func_F86E(0);
		wait(1);
	}
}

//Function Number: 39
func_98D6(param_00)
{
	scripts\mp\_utility::func_F6FA(0);
	if(isdefined(param_00) && param_00)
	{
		self notify("infected");
	}
}

//Function Number: 40
func_F86E(param_00)
{
	if(!isdefined(self.var_112E1))
	{
		self.var_112E1 = self.var_10916;
	}

	var_01 = int(gettime() - self.var_112E1 / 1000);
	if(var_01 > 999)
	{
		var_01 = 999;
	}

	scripts\mp\_utility::func_F6FA(var_01);
	if(isdefined(param_00) && param_00)
	{
		self notify("infected");
	}
}

//Function Number: 41
refundinfectedsuper()
{
	var_00 = self.var_11234;
	if(isdefined(var_00))
	{
		var_01 = scripts\mp\_supers::getsupermaxcooldownmsec() / 10;
		scripts\mp\_supers::func_DE3A(var_01);
	}
}

//Function Number: 42
setrandomrigifscout()
{
	self.infected_archtype = "archetype_scout";
	if(!isbot(self))
	{
		self.infected_archtype = scripts\mp\_class::func_3676();
	}

	if(self.infected_archtype == "archetype_scout")
	{
		self.pers["gamemodeLoadout"]["loadoutArchetype"] = level.infect_allyrigs[randomint(level.infect_allyrigs.size)];
	}
}