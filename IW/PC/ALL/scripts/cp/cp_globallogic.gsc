/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\cp_globallogic.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 80
 * Decompile Time: 4032 ms
 * Timestamp: 10/27/2023 12:09:20 AM
*******************************************************************/

//Function Number: 1
init()
{
	scripts\common\utility::func_1115B();
	func_F6BD();
	func_F6BA();
	scripts\cp\_utility::func_F305();
	func_FA99();
	scripts\cp\_utility::func_980B();
	scripts\cp\_utility::func_9892();
	func_FAAB();
	func_F6BB();
	func_F6BF();
	func_F6BC();
	func_AE18();
	func_10958();
	func_97F7();
	func_FAAA();
	func_9817();
	func_988B();
	scripts\common\fx::func_980A();
	scripts\mp\_callbacksetup::func_FAA2();
	scripts\cp\_movers::init();
	scripts\cp\_fx::main();
	scripts\cp\_merits::func_3214();
	scripts\cp\_endgame::init();
	scripts\cp\_laststand::func_9654();
	if(func_100BC())
	{
		level thread func_132A3();
	}

	level.var_108E4 = (0,0,0);
	level.var_108E2 = (0,0,0);
	level.var_B32E = func_6CAF(level.var_108E4,level.var_108E2);
	function_01B4(level.var_B32E);
}

//Function Number: 2
func_6CAF(param_00,param_01)
{
	var_02 = (0,0,0);
	var_02 = param_01 - param_00;
	var_02 = (var_02[0] / 2,var_02[1] / 2,var_02[2] / 2) + param_00;
	return var_02;
}

//Function Number: 3
func_F6BD()
{
	level.var_1307 = 1;
	level.splitscreen = function_0114();
	level.onlinegame = getdvarint("onlinegame");
	level.rankedmatch = (level.onlinegame && !getdvarint("xblive_privatematch")) || getdvarint("force_ranking");
	level.script = tolower(getdvar("mapname"));
	level.gametype = tolower(getdvar("ui_gametype"));
	level.teamnamelist = ["axis","allies"];
	level.var_C74B["allies"] = "axis";
	level.var_C74B["axis"] = "allies";
	level.multiteambased = 0;
	level.teambased = 1;
	level.var_C2A1 = 0;
	level.var_74C2 = [];
	level.createfx_enabled = getdvar("createfx") != "";
	level.var_108E4 = (0,0,0);
	level.var_108E2 = (0,0,0);
	level.var_8B38 = 0;
	level.var_C22E = 0;
	level.var_DDDA = [];
}

//Function Number: 4
func_F6BA()
{
	setdvar("ui_inhostmigration",0);
	setdvar("camera_thirdPerson",getdvarint("scr_thirdPerson"));
	setdvar("sm_sunShadowScale",1);
	setdvar("r_specularcolorscale",2.5);
	setdvar("r_diffusecolorscale",1);
	setdvar("r_lightGridEnableTweaks",0);
	setdvar("r_lightGridIntensity",1);
	setdvar("bg_compassShowEnemies",getdvar("scr_game_forceuav"));
	setdvar("isMatchMakingGame",scripts\cp\_utility::func_B3EC());
	setdvar("ui_overtime",0);
	setdvar("ui_allow_teamchange",1);
	setdvar("g_deadChat",1);
	setdvar("min_wait_for_players",5);
	setdvar("ui_friendlyfire",0);
	setdvar("cg_drawFriendlyHUDGrenades",0);
	setdvar("cg_drawCrosshair",scripts\common\utility::func_116D7(level.var_8B38 == 1,0,1));
	setdvar("cg_drawCrosshairNames",1);
	setdvar("cg_drawFriendlyNamesAlways",0);
}

//Function Number: 5
func_FA99()
{
	level.var_3768 = ::func_4631;
	level.var_375F = ::func_5043;
	level.var_3761 = ::func_5045;
	level.callbackplayerdamage = ::func_5044;
	level.var_3763 = ::func_5046;
	level.var_3766 = ::func_5049;
	level.var_375E = ::func_503E;
	level.var_8136 = ::func_503B;
	level.onspawnplayer = ::func_2B53;
	level.var_C580 = ::func_2B53;
	level.var_C5A4 = ::func_2B53;
	level.var_D3D5 = ::func_5048;
	level.var_97C2 = ::scripts\cp\_agent_utils::func_97C2;
	level.var_F635 = ::scripts\cp\_agent_utils::func_F290;
	level.var_190A = ::scripts\cp\_agent_utils::func_1313C;
	level.var_1908 = ::scripts\cp\_agent_utils::func_1908;
	level.var_7EC5 = ::scripts\cp\_agent_utils::func_7EC5;
	level.var_184B = ::scripts\cp\_agent_utils::func_184B;
	level.var_3764 = ::scripts\cp\_laststand::func_373E;
	level.endgame = ::scripts\cp\_endgame::endgame;
	level.var_72BF = ::scripts\cp\_endgame::func_72BF;
}

//Function Number: 6
func_AE18()
{
	level._effect["slide_dust"] = loadfx("vfx/core/screen/vfx_scrnfx_tocam_slidedust_m");
}

//Function Number: 7
func_5044(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
}

//Function Number: 8
func_5046(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
}

//Function Number: 9
func_FAAB()
{
	var_00 = ["trigger_multiple","trigger_once","trigger_use","trigger_radius","trigger_lookat","trigger_damage"];
	foreach(var_02 in var_00)
	{
		var_03 = getentarray(var_02,"classname");
		for(var_04 = 0;var_04 < var_03.size;var_04++)
		{
			if(isdefined(var_03[var_04].var_EE89))
			{
				var_03[var_04].var_ED84 = var_03[var_04].var_EE89;
			}

			if(isdefined(var_03[var_04].var_ED84))
			{
				level thread func_69AA(var_03[var_04]);
			}
		}
	}
}

//Function Number: 10
func_10958()
{
	level thread func_11ADC();
	level thread func_11B00();
	level thread func_11ACB();
}

//Function Number: 11
func_11ADC()
{
	for(;;)
	{
		level.var_85D5 = getentarray("grenade","classname");
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 12
func_11B00()
{
	for(;;)
	{
		level.var_B898 = getentarray("rocket","classname");
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 13
func_11ACB()
{
	for(;;)
	{
		level.var_3A59 = getentarray("care_package","targetname");
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 14
func_5048()
{
	if(scripts\common\utility::istrue(self.keep_perks))
	{
		if(scripts\cp\_utility::has_zombie_perk("perk_machine_tough"))
		{
			return 200;
		}

		return 100;
	}

	return 100;
}

//Function Number: 15
func_F6BB()
{
	game["thermal_vision"] = "thermal_mp";
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["allies_outfit"] = "urban";
	game["axis_outfit"] = "woodland";
	game["clientid"] = 0;
	game["roundsPlayed"] = 0;
	game["state"] = "playing";
	game["status"] = "normal";
	game["roundsWon"] = [];
}

//Function Number: 16
func_F6BF()
{
	function_0237("",0);
	function_0238("default_night_mp");
	function_0236("missilecam");
	function_023A(game["thermal_vision"]);
	function_0239("",0);
}

//Function Number: 17
func_F6BC()
{
	function_01BC(0);
	function_01BD(0);
}

//Function Number: 18
func_503B()
{
	return func_7DDA(scripts\common\utility::getstructarray("default_player_start","targetname"));
}

//Function Number: 19
func_7DDA(param_00)
{
	var_01 = self getentitynumber();
	if(var_01 == 4)
	{
		var_01 = 1;
	}

	return param_00[var_01];
}

//Function Number: 20
func_5038()
{
	level.var_7669 = 1;
	setomnvar("allow_server_pause",0);
	level notify("game_ended","allies");
	scripts\common\utility::func_136F7();
	exitlevel(0);
}

//Function Number: 21
func_4631()
{
	[[ level.var_C580 ]]();
	func_E256();
	func_E255();
	lib_0CFE::func_98B1();
	lib_0CFF::func_98C0();
	scripts\cp\_weaponrank::init();
	scripts\cp\_relics::init();
	thread scripts\cp\powers\coop_powers::init();
	scripts\cp\_merits::init();
	thread scripts\cp\contracts_coop::init();
	level thread func_E896();
	level thread func_8489();
	level thread func_10D9F();
	game["gamestarted"] = 1;
}

//Function Number: 22
func_E256()
{
	level.var_115C6["allies"] = 0;
	level.var_115C6["axis"] = 0;
	level.var_115C6["spectator"] = 0;
	level.var_8C2A["allies"] = 0;
	level.var_8C2A["axis"] = 0;
	level.var_6BAA = 0;
	level.var_7669 = 0;
	level.var_72B3 = 0;
	level.var_90A1 = 0;
	level.var_8487 = 10;
	level.ingraceperiod = level.var_8487;
	level.var_C08A = getentarray("noragdoll","targetname");
	level.var_740A = 0;
	level.var_10DFF = gettime();
}

//Function Number: 23
func_E255()
{
	level.players = [];
	level.var_C928 = [];
	level.var_3CB5 = [];
	level.var_8DD3 = [];
	level.var_12A83 = [];
	level.var_935F = [];
	level.var_12B14 = [];
	level.var_27EF = [];
}

//Function Number: 24
func_E896()
{
	level notify("coop_pre_match");
	level endon("game_ended");
	level endon("coop_pre_match");
	scripts\cp\_utility::func_766E("prematch_done",0);
	setomnvar("ui_prematch_period",1);
	if(isdefined(level.var_D84B))
	{
		[[ level.var_D84B ]]();
	}

	scripts\cp\_utility::func_766F("prematch_done");
	setomnvar("ui_prematch_period",0);
}

//Function Number: 25
func_8489()
{
	level notify("coop_grace_period");
	level endon("game_ended");
	level endon("coop_grace_period");
	while(function_0071() == 0)
	{
		scripts\common\utility::func_136F7();
	}

	while(level.ingraceperiod > 0)
	{
		wait(1);
		level.ingraceperiod--;
	}

	level.ingraceperiod = 0;
}

//Function Number: 26
func_10D9F()
{
	[[ level.var_C5A4 ]]();
}

//Function Number: 27
func_100BC()
{
	return !level.console && getdvar("dedicated") == "dedicated LAN server" || getdvar("dedicated") == "dedicated internet server";
}

//Function Number: 28
func_132A3()
{
	for(;;)
	{
		if(level.rankedmatch)
		{
			exitlevel(0);
		}

		if(!getdvarint("xblive_privatematch"))
		{
			exitlevel(0);
		}

		if(getdvar("dedicated") != "dedicated LAN server" && getdvar("dedicated") != "dedicated internet server")
		{
			exitlevel(0);
		}

		wait(5);
	}
}

//Function Number: 29
func_5043()
{
	self endon("disconnect");
	self.var_2C7 = "hud_status_connecting";
	self waittill("begin");
	self.var_2C7 = "";
	var_00 = gettime();
	level notify("connected",self);
	game["clientid"]++;
	func_98BC();
	func_F7F0();
	func_97E9();
	func_FAE7();
	func_98B9();
	func_988E();
	lib_0CFF::func_98BA();
	lib_0CFC::func_95C1();
	self.var_C016 = 0;
	self.var_C004 = 0;
	if(scripts\cp\_utility::func_462B("outline"))
	{
		thread scripts\cp\_outline::func_D3DF();
	}

	thread scripts\cp\_vo::func_97CC();
	thread scripts\cp\_merits::func_12ED0();
	if(self ishost())
	{
		level.player = self;
	}

	if(!level.teambased)
	{
		game["roundsWon"][self.var_86BD] = 0;
	}

	waittillframeend;
	func_1810(self);
	if(game["state"] == "postgame")
	{
		self.var_4530 = 1;
		self setclientdvars("cg_drawSpectatorMessages",0);
		func_108DD();
		return;
	}

	if(isai(self) && isdefined(level.var_2D9E) && isdefined(level.var_2D9E["think"]))
	{
		self thread [[ level.var_2D9E["think"] ]]();
	}

	level endon("game_ended");
	if(isdefined(level.var_90A9))
	{
		thread scripts\cp\_hostmigration::func_90AA();
	}

	if(isdefined(level.var_C56F))
	{
		[[ level.var_C56F ]]();
	}

	if(!isai(self))
	{
		func_D3D9();
	}

	func_108F2();
}

//Function Number: 30
func_D3D9()
{
	thread func_102EC();
	thread func_72C1();
}

//Function Number: 31
func_F7F0()
{
	self.var_86BD = scripts\cp\_utility::func_81EC();
	self.var_41F0 = game["clientid"];
	self.var_13114 = self isusingonlinedataoffline();
	self.var_452B = 1;
	self.var_8C2A = 0;
	self.var_136FF = 0;
	self.var_138DD = 0;
	self.var_BCF6 = 1;
	self.var_C2AD = 1;
	self.inlaststand = 0;
}

//Function Number: 32
func_97E9()
{
	func_97EA();
	self setclientdvars("cg_drawSpectatorMessages",1,"cg_deadChatWithDead",0,"cg_deadChatWithTeam",1,"cg_deadHearTeamLiving",1,"cg_deadHearAllLiving",0,"ui_altscene",0);
	if(level.teambased)
	{
		self setclientdvar("cg_everyonehearseveryone",0);
	}
}

//Function Number: 33
func_97EA()
{
	if(level.splitscreen || self issplitscreenplayer())
	{
		self setclientdvars("cg_fovscale","0.75");
		setdvar("r_materialBloomHQScriptMasterEnable",0);
		return;
	}

	self setclientdvars("cg_fovscale","1");
}

//Function Number: 34
func_FAE7()
{
	self.var_EB6A = [];
	for(var_00 = 1;var_00 <= 4;var_00++)
	{
		self.var_EB6A[var_00] = spawnstruct();
		self.var_EB6A[var_00].type = "";
		self.var_EB6A[var_00].var_195 = undefined;
	}

	if(!level.console)
	{
		for(var_00 = 5;var_00 <= 8;var_00++)
		{
			self.var_EB6A[var_00] = spawnstruct();
			self.var_EB6A[var_00].type = "";
			self.var_EB6A[var_00].var_195 = undefined;
		}
	}
}

//Function Number: 35
func_98B9()
{
	self.var_CA5B = [];
	self.var_CA61 = [];
}

//Function Number: 36
func_102EC()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("sprint_slide_begin");
		self playfx(level._effect["slide_dust"],self geteye());
	}
}

//Function Number: 37
func_72C1()
{
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 == "arcade_off")
		{
			self notify("adjustedStance");
		}

		if(var_00 == "end_game")
		{
			level thread [[ level.var_72BF ]]();
			self notify("disconnect");
		}
	}
}

//Function Number: 38
func_108DD(param_00)
{
	func_F726();
	var_01 = self.var_72E0;
	func_108F2();
	self setclientdvar("cg_everyoneHearsEveryone",1);
	self setdepthoffield(0,128,512,4000,6,1.8);
	if(level.console)
	{
		self setclientdvar("cg_fov","90");
	}

	scripts\cp\_utility::func_12F19("intermission");
}

//Function Number: 39
func_F726()
{
	var_00 = func_7ED8();
	func_F717(var_00.origin,var_00.angles);
}

//Function Number: 40
func_F717(param_00,param_01)
{
	self.var_72E2 = param_00;
	self.var_72E0 = param_01;
}

//Function Number: 41
func_7ED8()
{
	var_00 = getentarray("mp_global_intermission","classname");
	return var_00[0];
}

//Function Number: 42
func_108F2(param_00)
{
	thread func_108F4(param_00);
}

//Function Number: 43
func_108F4(param_00)
{
	self endon("disconnect");
	self endon("joined_spectators");
	level endon("game_ended");
	if(self.var_136FF)
	{
		return;
	}

	func_136E9();
	func_108F3(param_00);
}

//Function Number: 44
func_136E9()
{
	self.var_136FF = 1;
	if(scripts\cp\_utility::func_9FC6())
	{
		self waittill("stopped_using_remote");
	}

	self.var_136FF = 0;
}

//Function Number: 45
func_108F3(param_00)
{
	self notify("spawned");
	self notify("started_spawnPlayer");
	if(level.var_7669)
	{
		self spawn(func_8135(self,1),func_8132(self));
	}
	else
	{
		self spawn(func_8135(self),func_8132(self));
	}

	func_E262();
	func_E261();
	func_E263();
	resetplayerdamagemodifiers();
	param_00 = scripts\common\utility::func_116D7(isdefined(param_00),param_00,0);
	if(!param_00)
	{
		func_C07F();
	}

	if(isai(self))
	{
		func_10828(param_00);
	}

	[[ level.onspawnplayer ]]();
	if(!scripts\common\utility::flag("introscreen_over"))
	{
		scripts\cp\_utility::func_7385(1);
	}

	self [[ level.var_4C55 ]](param_00);
	if(getdvarint("camera_thirdPerson"))
	{
		scripts\cp\_utility::setthirdpersondof(1);
	}

	if(func_1001B())
	{
		scripts\cp\_utility::func_7385(1);
	}

	waittillframeend;
	self notify("spawned_player");
	level notify("player_spawned",self);
}

//Function Number: 46
func_E262()
{
	self setclientomnvar("ui_options_menu",0);
	self setclientomnvar("ui_hud_shake",0);
}

//Function Number: 47
func_E261()
{
	self stopshellshock();
	self stoprumble("damage_heavy");
	self setdepthoffield(0,0,512,512,4,0);
	if(level.console)
	{
		self setclientdvar("cg_fov","65");
	}
}

//Function Number: 48
resetplayerdamagemodifiers()
{
	if(isdefined(self.var_17DF))
	{
		var_00 = getarraykeys(self.var_17DF);
		foreach(var_02 in var_00)
		{
			scripts\cp\_utility::func_E0E6(var_02,1);
		}
	}

	if(isdefined(self.var_BDC8))
	{
		var_00 = getarraykeys(self.var_BDC8);
		foreach(var_02 in var_00)
		{
			scripts\cp\_utility::func_E0E6(var_02,0);
		}
	}
}

//Function Number: 49
func_E263()
{
	var_00 = func_8144();
	self.team = var_00;
	self.sessionteam = var_00;
	self.pers["team"] = var_00;
	self.var_6BA7 = undefined;
	self.var_BCF6 = 1;
	self.var_55E6 = 0;
	self.var_55D9 = 0;
	self.var_8C1F = 0;
	self.var_8C1E = 0;
}

//Function Number: 50
func_8144()
{
	if(isdefined(level.var_D425))
	{
		return [[ level.var_D425 ]](self);
	}

	return "allies";
}

//Function Number: 51
func_C07F()
{
	func_E25B();
	scripts\cp\_utility::func_12F19("playing");
}

//Function Number: 52
func_E25B()
{
	self.maxhealth = self [[ level.var_D3D5 ]]();
	self.health = self.maxhealth;
	self.var_26B9 = 5;
	self.var_7408 = undefined;
	self.var_8C2A = 1;
	self.var_10916 = gettime();
	self.var_C2AD = 1;
}

//Function Number: 53
func_10828(param_00)
{
	scripts\cp\_utility::func_7385(1);
	if(!param_00)
	{
		if(isdefined(level.var_2D9E) && isdefined(level.var_2D9E["player_spawned"]))
		{
			self [[ level.var_2D9E["player_spawned"] ]]();
		}
	}
}

//Function Number: 54
func_8135(param_00,param_01)
{
	var_02 = undefined;
	if(isdefined(param_00.var_72E2))
	{
		var_02 = param_00.var_72E2;
		var_02 = getclosestpointonnavmesh(var_02);
		if(isdefined(param_01))
		{
			var_02 = param_00.var_72E2;
		}

		param_00.var_72E2 = undefined;
	}
	else
	{
		var_03 = param_00 [[ level.var_8136 ]]();
		var_02 = scripts\common\utility::func_116D7(scripts\common\utility::istrue(level.disable_start_spawn_on_navmesh),scripts\common\utility::func_5D14(var_03.origin,0,-100),getclosestpointonnavmesh(var_03.origin));
		if(isdefined(param_01))
		{
			var_02 = var_03;
		}

		if(level.script == "cp_disco")
		{
			var_02 = var_03.origin;
		}
	}

	return var_02;
}

//Function Number: 55
func_8132(param_00)
{
	var_01 = undefined;
	if(isdefined(param_00.var_72E0))
	{
		var_01 = param_00.var_72E0;
		param_00.var_72E0 = undefined;
	}
	else
	{
		var_02 = param_00 [[ level.var_8136 ]]();
		var_01 = scripts\common\utility::func_116D7(isdefined(var_02.angles),var_02.angles,(0,0,0));
	}

	return var_01;
}

//Function Number: 56
func_1001B()
{
	if(game["state"] == "postgame")
	{
		return 1;
	}

	return 0;
}

//Function Number: 57
func_662C()
{
	var_00 = func_7ED8();
	self setspectatedefaults(var_00.origin,var_00.angles);
	func_F717(var_00.origin,var_00.angles);
	func_F858();
	scripts\cp\_utility::func_12F19("spectator");
}

//Function Number: 58
func_F858()
{
	if(isdefined(level.var_10979))
	{
		[[ level.var_10979 ]](self);
		return;
	}

	func_504C(self);
}

//Function Number: 59
func_504C(param_00)
{
	param_00 allowspectateteam("allies",1);
	param_00 allowspectateteam("axis",1);
	param_00 allowspectateteam("freelook",0);
	param_00 allowspectateteam("none",1);
}

//Function Number: 60
func_5045(param_00)
{
	if(!isdefined(self.var_452B))
	{
		return;
	}

	scripts\cp\_analytics::on_player_disconnect(param_00);
	func_E15A(self);
	if(func_563B())
	{
		level thread [[ level.var_72BF ]]();
	}

	if(isdefined(level.var_C574))
	{
		level thread [[ level.var_C574 ]](self,param_00);
	}
}

//Function Number: 61
func_563B()
{
	if(level.splitscreen)
	{
		return level.players.size <= 1;
	}

	var_00 = 0;
	foreach(var_02 in level.players)
	{
		if(scripts\cp\_laststand::player_in_laststand(var_02))
		{
			var_00 = scripts\cp\_laststand::func_7682(var_02);
		}
	}

	return var_00;
}

//Function Number: 62
func_1810(param_00)
{
	level.players[level.players.size] = param_00;
	level.var_C928[level.var_C928.size] = param_00;
	level.var_3CB5[level.var_3CB5.size] = param_00;
}

//Function Number: 63
func_E15A(param_00)
{
	level.players = scripts\common\utility::func_22A9(level.players,param_00);
	level.var_C928 = scripts\common\utility::func_22A9(level.var_C928,param_00);
	level.var_3CB5 = scripts\common\utility::func_22A9(level.var_3CB5,param_00);
}

//Function Number: 64
func_5049()
{
	if(self ishost())
	{
		func_97EA();
	}

	if(func_9E39(self))
	{
		var_00 = 0;
		foreach(var_02 in level.players)
		{
			if(func_9E39(var_02))
			{
				var_00++;
			}
		}

		level.var_90A8++;
		if(level.var_90A8 >= var_00 * 2 / 3)
		{
			level notify("hostmigration_enoughplayers");
		}
	}
}

//Function Number: 65
func_9E39(param_00)
{
	return !isdefined(param_00.pers["isBot"]) || param_00.pers["isBot"] == 0;
}

//Function Number: 66
func_503E()
{
	if(level.var_7669)
	{
		return;
	}

	if(isdefined(level.var_C53D))
	{
		level thread [[ level.var_C53D ]]();
	}

	level.var_90A8 = 0;
	foreach(var_01 in level.var_3CB5)
	{
		var_01.var_90A6 = 0;
	}

	level.var_90A9 = 1;
	setdvar("ui_inhostmigration",1);
	level notify("host_migration_begin");
	foreach(var_01 in level.var_3CB5)
	{
		if(isdefined(var_01))
		{
			var_01 thread scripts\cp\_hostmigration::func_90AA();
		}

		if(isplayer(var_01))
		{
			var_01 setclientomnvar("ui_session_state",var_01.sessionstate);
		}
	}

	setdvar("ui_game_state",game["state"]);
	level endon("host_migration_begin");
	scripts\cp\_hostmigration::func_90AC();
	level.var_90A9 = undefined;
	setdvar("ui_inhostmigration",0);
	if(isdefined(level.hostmigrationend))
	{
		level thread [[ level.hostmigrationend ]]();
	}

	level notify("host_migration_end");
}

//Function Number: 67
func_97F7()
{
	var_00 = getentarray("destructable","targetname");
	if(getdvar("scr_destructables") == "0")
	{
		for(var_01 = 0;var_01 < var_00.size;var_01++)
		{
			var_00[var_01] delete();
		}

		return;
	}

	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] thread func_5335();
	}
}

//Function Number: 68
func_5335()
{
	var_00 = 40;
	var_01 = 0;
	if(isdefined(self.var_ECE4))
	{
		var_00 = self.var_ECE4;
	}

	if(isdefined(self.var_EEE3))
	{
		var_01 = self.var_EEE3;
	}

	if(isdefined(self.script_fxid))
	{
		self.var_7542 = loadfx(self.script_fxid);
	}

	var_02 = 0;
	self setcandamage(1);
	for(;;)
	{
		self waittill("damage",var_03,var_04);
		if(var_03 >= var_01)
		{
			var_02 = var_02 + var_03;
			if(var_02 >= var_00)
			{
				thread func_5334();
				return;
			}
		}
	}
}

//Function Number: 69
func_5334()
{
	var_00 = self;
	if(isdefined(var_00.var_7542))
	{
		playfx(var_00.var_7542,var_00.origin + (0,0,6));
	}

	var_00 delete();
}

//Function Number: 70
func_FAAA()
{
	var_00 = getentarray("script_brushmodel","classname");
	var_01 = getentarray("script_model","classname");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_00[var_00.size] = var_01[var_02];
	}

	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		if(isdefined(var_00[var_02].var_EE89))
		{
			var_00[var_02].var_ED84 = var_00[var_02].var_EE89;
		}

		if(isdefined(var_00[var_02].var_ED84))
		{
			if(var_00[var_02].model == "fx" && !isdefined(var_00[var_02].var_336) || var_00[var_02].var_336 != "exploderchunk")
			{
				var_00[var_02] hide();
				continue;
			}

			if(isdefined(var_00[var_02].var_336) && var_00[var_02].var_336 == "exploder")
			{
				var_00[var_02] hide();
				var_00[var_02] notsolid();
				continue;
			}

			if(isdefined(var_00[var_02].var_336) && var_00[var_02].var_336 == "exploderchunk")
			{
				var_00[var_02] hide();
				var_00[var_02] notsolid();
			}
		}
	}

	var_03 = [];
	var_04 = getentarray("script_brushmodel","classname");
	for(var_02 = 0;var_02 < var_04.size;var_02++)
	{
		if(isdefined(var_04[var_02].var_EE89))
		{
			var_04[var_02].var_ED84 = var_04[var_02].var_EE89;
		}

		if(isdefined(var_04[var_02].var_ED84))
		{
			var_03[var_03.size] = var_04[var_02];
		}
	}

	var_04 = getentarray("script_model","classname");
	for(var_02 = 0;var_02 < var_04.size;var_02++)
	{
		if(isdefined(var_04[var_02].var_EE89))
		{
			var_04[var_02].var_ED84 = var_04[var_02].var_EE89;
		}

		if(isdefined(var_04[var_02].var_ED84))
		{
			var_03[var_03.size] = var_04[var_02];
		}
	}

	var_04 = getentarray("item_health","classname");
	for(var_02 = 0;var_02 < var_04.size;var_02++)
	{
		if(isdefined(var_04[var_02].var_EE89))
		{
			var_04[var_02].var_ED84 = var_04[var_02].var_EE89;
		}

		if(isdefined(var_04[var_02].var_ED84))
		{
			var_03[var_03.size] = var_04[var_02];
		}
	}

	if(!isdefined(level.var_49C9))
	{
		level.var_49C9 = [];
	}

	var_05 = [];
	var_05["exploderchunk visible"] = 1;
	var_05["exploderchunk"] = 1;
	var_05["exploder"] = 1;
	for(var_02 = 0;var_02 < var_03.size;var_02++)
	{
		var_06 = var_03[var_02];
		var_07 = scripts\common\utility::func_49AE(var_06.script_fxid);
		var_07.var_13125 = [];
		var_07.var_13125["origin"] = var_06.origin;
		var_07.var_13125["angles"] = var_06.angles;
		var_07.var_13125["delay"] = var_06.script_delay;
		var_07.var_13125["firefx"] = var_06.var_ED93;
		var_07.var_13125["firefxdelay"] = var_06.var_ED94;
		var_07.var_13125["firefxsound"] = var_06.var_ED95;
		var_07.var_13125["firefxtimeout"] = var_06.var_ED96;
		var_07.var_13125["earthquake"] = var_06.var_ED76;
		var_07.var_13125["damage"] = var_06.var_ED41;
		var_07.var_13125["damage_radius"] = var_06.var_EE8F;
		var_07.var_13125["soundalias"] = var_06.var_EEB1;
		var_07.var_13125["repeat"] = var_06.var_EE94;
		var_07.var_13125["delay_min"] = var_06.var_ED50;
		var_07.var_13125["delay_max"] = var_06.var_ED4F;
		var_07.var_13125["target"] = var_06.target;
		var_07.var_13125["ender"] = var_06.var_ED78;
		var_07.var_13125["type"] = "exploder";
		if(!isdefined(var_06.script_fxid))
		{
			var_07.var_13125["fxid"] = "No FX";
		}
		else
		{
			var_07.var_13125["fxid"] = var_06.script_fxid;
		}

		var_07.var_13125["exploder"] = var_06.var_ED84;
		if(!isdefined(var_07.var_13125["delay"]))
		{
			var_07.var_13125["delay"] = 0;
		}

		if(isdefined(var_06.target))
		{
			var_08 = getent(var_07.var_13125["target"],"targetname").origin;
			var_07.var_13125["angles"] = vectortoangles(var_08 - var_07.var_13125["origin"]);
		}

		if(var_06.classname == "script_brushmodel" || isdefined(var_06.model))
		{
			var_07.model = var_06;
			var_07.model.var_5635 = var_06.var_ED5D;
		}

		if(isdefined(var_06.var_336) && isdefined(var_05[var_06.var_336]))
		{
			var_07.var_13125["exploder_type"] = var_06.var_336;
		}
		else
		{
			var_07.var_13125["exploder_type"] = "normal";
		}

		var_07 scripts\common\createfx::func_D6CF();
	}
}

//Function Number: 71
func_9817()
{
	level.uiparent = spawnstruct();
	level.uiparent.horzalign = "left";
	level.uiparent.vertalign = "top";
	level.uiparent.alignx = "left";
	level.uiparent.aligny = "top";
	level.uiparent.x = 0;
	level.uiparent.y = 0;
	level.uiparent.width = 0;
	level.uiparent.height = 0;
	level.uiparent.children = [];
	level.fontheight = 12;
	level.var_912F["allies"] = spawnstruct();
	level.var_912F["axis"] = spawnstruct();
	level.primaryprogressbary = -61;
	level.primaryprogressbarx = 0;
	level.primaryprogressbarheight = 9;
	level.primaryprogressbarwidth = 120;
	level.primaryprogressbartexty = -75;
	level.primaryprogressbartextx = 0;
	level.primaryprogressbarfontsize = 1.2;
	level.teamprogressbary = 32;
	level.teamprogressbarheight = 14;
	level.teamprogressbarwidth = 192;
	level.teamprogressbartexty = 8;
	level.teamprogressbarfontsize = 1.65;
	level.var_B0E6 = "BOTTOM";
	level.var_B0E5 = -140;
	level.var_B0E4 = 1.2;
}

//Function Number: 72
func_69AA(param_00)
{
	level endon("killexplodertridgers" + param_00.var_ED84);
	param_00 waittill("trigger");
	if(isdefined(param_00.var_ED28) && randomfloat(1) > param_00.var_ED28)
	{
		if(isdefined(param_00.script_delay))
		{
			wait(param_00.script_delay);
		}
		else
		{
			wait(4);
		}

		level thread func_69AA(param_00);
		return;
	}

	scripts\common\utility::exploder(param_00.var_ED84);
	level notify("killexplodertridgers" + param_00.var_ED84);
}

//Function Number: 73
func_D0FB()
{
	self.var_DE8E = 1;
}

//Function Number: 74
func_D0FC()
{
	self.var_8C4C = 1;
}

//Function Number: 75
func_D0F9()
{
	self.var_4D69 = gettime();
}

//Function Number: 76
func_2B53(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
}

//Function Number: 77
func_98BC()
{
	self setplayerdata("cp","alienSession","team_shots",0);
	self setplayerdata("cp","alienSession","team_kills",0);
	self setplayerdata("cp","alienSession","team_hives",0);
	self setplayerdata("cp","alienSession","downed",0);
	self setplayerdata("cp","alienSession","hivesDestroyed",0);
	self setplayerdata("cp","alienSession","prestigenerfs",0);
	self setplayerdata("cp","alienSession","repairs",0);
	self setplayerdata("cp","alienSession","drillPlants",0);
	self setplayerdata("cp","alienSession","deployables",0);
	self setplayerdata("cp","alienSession","challengesCompleted",0);
	self setplayerdata("cp","alienSession","challengesAttempted",0);
	self setplayerdata("cp","alienSession","trapKills",0);
	self setplayerdata("cp","alienSession","currencyTotal",0);
	self setplayerdata("cp","alienSession","currencySpent",0);
	self setplayerdata("cp","alienSession","kills",0);
	self setplayerdata("cp","alienSession","revives",0);
	self setplayerdata("cp","alienSession","time",0);
	self setplayerdata("cp","alienSession","score",0);
	self setplayerdata("cp","alienSession","shots",0);
	self setplayerdata("cp","alienSession","last_stand_count",0);
	self setplayerdata("cp","alienSession","deaths",0);
	self setplayerdata("cp","alienSession","headShots",0);
	self setplayerdata("cp","alienSession","hits",0);
	self setplayerdata("cp","alienSession","resources",0);
	self setplayerdata("cp","alienSession","waveNum",0);
}

//Function Number: 78
func_988E()
{
	if(isdefined(level.var_D0FE))
	{
		[[ level.var_D0FE ]]();
		return;
	}

	scripts\cp\_laststand::func_500D();
}

//Function Number: 79
func_988B()
{
	level.var_A6CB = scripts\common\utility::getstructarray("respawn_edge","targetname");
}

//Function Number: 80
func_7F56()
{
	return scripts\common\utility::getclosest(self.origin,level.var_A6CB);
}