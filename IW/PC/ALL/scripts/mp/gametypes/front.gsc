/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\gametypes\front.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 30
 * Decompile Time: 1535 ms
 * Timestamp: 10/27/2023 12:12:31 AM
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
		scripts\mp\_utility::func_DF0B(level.gametype,100);
		scripts\mp\_utility::func_DF08(level.gametype,2);
		scripts\mp\_utility::func_DF1A(level.gametype,0);
		scripts\mp\_utility::func_DF02(level.gametype,0);
		scripts\mp\_utility::func_DEF4(level.gametype,0);
		level.var_B40A = 0;
		level.var_B410 = 0;
	}

	func_12E9F();
	level.teambased = 1;
	level.var_C5A4 = ::func_C5A4;
	level.var_8136 = ::func_8136;
	level.var_C55E = ::func_C55E;
	level.onspawnplayer = ::onspawnplayer;
	if(level.var_B40A || level.var_B410)
	{
		level.var_B93A = ::scripts\mp\_damage::func_7678;
	}

	game["dialog"]["gametype"] = "frontline";
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

	game["strings"]["overtime_hint"] = &"MP_FIRST_BLOOD";
	thread func_C56E();
}

//Function Number: 2
func_987C()
{
	scripts\mp\_utility::func_F69D();
	setdynamicdvar("scr_front_enemyBaseKillReveal",getmatchrulesdata("frontData","enemyBaseKillReveal"));
	setdynamicdvar("scr_front_friendlyBaseScore",getmatchrulesdata("frontData","friendlyBaseScore"));
	setdynamicdvar("scr_front_midfieldScore",getmatchrulesdata("frontData","midfieldScore"));
	setdynamicdvar("scr_front_enemyBaseScore",getmatchrulesdata("frontData","enemyBaseScore"));
	setdynamicdvar("scr_front_promode",0);
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

	scripts\mp\_utility::func_F7C1("allies",&"OBJECTIVES_FRONT");
	scripts\mp\_utility::func_F7C1("axis",&"OBJECTIVES_FRONT");
	if(level.splitscreen)
	{
		scripts\mp\_utility::func_F7C0("allies",&"OBJECTIVES_FRONT");
		scripts\mp\_utility::func_F7C0("axis",&"OBJECTIVES_FRONT");
	}
	else
	{
		scripts\mp\_utility::func_F7C0("allies",&"OBJECTIVES_FRONT_SCORE");
		scripts\mp\_utility::func_F7C0("axis",&"OBJECTIVES_FRONT_SCORE");
	}

	scripts\mp\_utility::func_F7BE("allies",&"OBJECTIVES_FRONT_HINT");
	scripts\mp\_utility::func_F7BE("axis",&"OBJECTIVES_FRONT_HINT");
	level.var_92AD = "waypoint_capture_kill";
	level.var_92AC = "waypoint_capture_kill";
	func_98CE();
	var_02[0] = level.gametype;
	scripts\mp\_gameobjects::main(var_02);
	func_2892();
	thread func_FA91();
	thread setupbaseareabrushes();
	level.var_112BF = 0;
}

//Function Number: 4
func_12E9F()
{
	scripts\mp\gametypes\common::func_12E9F();
	level.var_654C = scripts\mp\_utility::dvarfloatvalue("enemyBaseKillReveal",5,0,60);
	level.friendlybasescore = scripts\mp\_utility::dvarfloatvalue("friendlyBaseScore",1,0,25);
	level.midfieldscore = scripts\mp\_utility::dvarfloatvalue("midfieldScore",2,0,25);
	level.enemybasescore = scripts\mp\_utility::dvarfloatvalue("enemyBaseScore",1,0,25);
}

//Function Number: 5
func_98CE()
{
	level.var_108E4 = (0,0,0);
	level.var_108E2 = (0,0,0);
	scripts\mp\_spawnlogic::func_F62D("TDM");
	scripts\mp\_spawnlogic::func_1829("allies","mp_front_spawn_allies");
	scripts\mp\_spawnlogic::func_1829("axis","mp_front_spawn_axis");
	level.var_B32E = scripts\mp\_spawnlogic::func_6CAF(level.var_108E4,level.var_108E2);
	function_01B4(level.var_B32E);
}

//Function Number: 6
onspawnplayer()
{
	if(isplayer(self))
	{
		scripts\mp\gametypes\common::onspawnplayer();
		self setclientomnvar("ui_uplink_carrier_hud",0);
		self.var_940C = 0;
		self.var_94C5 = 0;
		self.var_C7B1 = 0;
		if(isdefined(self.var_C79D))
		{
			scripts\mp\_utility::func_C78F(self.var_C79D,self);
		}

		self.var_130B7 = 0;
		self.var_C79D = undefined;
		thread func_7402();
		thread func_654F();
		foreach(var_01 in level.var_13FC4)
		{
			var_01 func_10110(self);
		}
	}
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
		var_01 = scripts\mp\_spawnlogic::func_81BA(var_00);
		var_02 = scripts\mp\_spawnscoring::func_8136(var_01);
	}
	else
	{
		var_01 = scripts\mp\_spawnlogic::func_81BA(var_02);
		var_03 = scripts\mp\_spawnlogic::func_81A9(var_01);
		var_02 = scripts\mp\_spawnscoring::func_8136(var_01,var_03);
	}

	return var_02;
}

//Function Number: 8
func_C55E(param_00,param_01,param_02,param_03,param_04)
{
	scripts\mp\gametypes\common::func_C55E(param_00,param_01,param_02,param_03,param_04);
	var_05 = 0;
	if(param_00.var_94C5 || param_01.var_940C)
	{
		param_01 thread scripts\mp\_utility::func_83B4("enemy_base_kill",param_04);
		var_05 = level.enemybasescore;
	}
	else if(param_01.var_94C5 || param_00.var_940C)
	{
		param_01 thread scripts\mp\_utility::func_83B4("friendly_base_kill",param_04);
		var_05 = level.friendlybasescore;
	}
	else
	{
		param_01 thread scripts\mp\_utility::func_83B4("midfield_kill",param_04);
		var_05 = level.midfieldscore;
	}

	var_06 = game["teamScores"][param_01.pers["team"]] + var_05;
	var_07 = var_06 >= level.var_E763;
	if(var_07 && level.var_E763 != 0)
	{
		var_05 = level.var_E763 - game["teamScores"][param_01.pers["team"]];
	}

	if(var_05 > 0)
	{
		scripts\mp\_gamescore::func_83B0(param_01.pers["team"],var_05,0);
		param_01 thread scripts\mp\_rank::func_EC2D("teamscore_notify_" + var_05);
	}
}

//Function Number: 9
func_654C()
{
	level endon("game_ended");
	self endon("death");
	self notify("EnemyBaseKillReveal");
	self endon("EnemyBaseKillReveal");
	if(isdefined(self.var_28A5))
	{
		scripts\mp\_utility::func_C78F(self.var_28A5,self);
	}

	self.var_28A5 = scripts\mp\_utility::func_C795(self,"orange",scripts\mp\_utility::getotherteam(self.team),0,0,"perk");
	if(!isbot(self))
	{
		scripts\mp\_utility::func_12E5(5,0,0);
	}

	self sethudtutorialmessage(&"MP_FRONT_REVEALED");
	wait(level.var_654C);
	scripts\mp\_utility::func_C78F(self.var_28A5,self);
	scripts\mp\_utility::func_12E4();
	self clearhudtutorialmessage(0);
}

//Function Number: 10
func_FA91()
{
	level.var_13FC4 = [];
	if(game["switchedsides"])
	{
		level.var_1C30 = getentarray("frontline_zone_allies","targetname");
		foreach(var_01 in level.var_1C30)
		{
			var_01.team = "axis";
			var_01 thread func_7402();
			var_01 thread func_654F();
			var_01 thread func_654D();
		}

		thread func_FAF5(level.var_1C30[0]);
		level.var_13FC4[level.var_13FC4.size] = level.var_1C30[0];
		level.var_26FE = getentarray("frontline_zone_axis","targetname");
		if(level.var_B335 == "mp_junk")
		{
			var_03 = spawn("trigger_radius",(-1410,-2080,240),0,1000,600);
			level.var_26FE[level.var_26FE.size] = var_03;
		}

		foreach(var_01 in level.var_26FE)
		{
			var_01.team = "allies";
			var_01 thread func_7402();
			var_01 thread func_654F();
			var_01 thread func_654D();
		}

		thread func_FAF5(level.var_26FE[0]);
		level.var_13FC4[level.var_13FC4.size] = level.var_26FE[0];
		return;
	}

	level.var_1C30 = getentarray("frontline_zone_allies","targetname");
	foreach(var_01 in level.var_1C30)
	{
		var_01.team = "allies";
		var_01 thread func_7402();
		var_01 thread func_654F();
		var_01 thread func_654D();
	}

	thread func_FAF5(level.var_1C30[0]);
	level.var_13FC4[level.var_13FC4.size] = level.var_1C30[0];
	level.var_26FE = getentarray("frontline_zone_axis","targetname");
	if(level.var_B335 == "mp_junk")
	{
		var_03 = spawn("trigger_radius",(-1410,-2080,240),0,1000,600);
		level.var_26FE[level.var_26FE.size] = var_03;
	}

	foreach(var_01 in level.var_26FE)
	{
		var_01.team = "axis";
		var_01 thread func_7402();
		var_01 thread func_654F();
		var_01 thread func_654D();
	}

	thread func_FAF5(level.var_26FE[0]);
	level.var_13FC4[level.var_13FC4.size] = level.var_26FE[0];
}

//Function Number: 11
func_FAF5(param_00)
{
	var_01 = [];
	var_01[0] = param_00;
	if(isdefined(param_00.target))
	{
		var_02 = getentarray(param_00.target,"targetname");
		for(var_03 = 0;var_03 < var_02.size;var_03++)
		{
			var_01[var_01.size] = var_02[var_03];
		}
	}

	var_01 = mappatchborders(var_01,param_00.target);
	param_00.visuals = var_01;
}

//Function Number: 12
mappatchborders(param_00,param_01)
{
	if(level.var_B335 == "mp_parkour" && param_01 == "front_vis_axis")
	{
		var_02 = spawn("script_origin",(-1088,-1504,136));
		var_02.angles = (0,180,0);
		var_02.var_336 = param_01;
		param_00[param_00.size] = var_02;
		var_03 = spawn("script_origin",(-1088,-1440,136));
		var_03.angles = (0,180,0);
		var_02.var_336 = param_01;
		param_00[param_00.size] = var_03;
	}

	return param_00;
}

//Function Number: 13
func_7402()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("trigger",var_00);
		if(!isplayer(var_00))
		{
			continue;
		}

		if(var_00.team != self.team)
		{
			continue;
		}

		if(var_00.var_94C5)
		{
			continue;
		}

		var_00 thread func_7401(self);
	}
}

//Function Number: 14
func_7401(param_00)
{
	self notify("friendlyTriggerWatcher");
	self endon("friendlyTriggerWatcher");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(game["switchedsides"])
	{
		if(self.team == "allies")
		{
			var_01 = level.var_26FE;
		}
		else
		{
			var_01 = level.var_1C30;
		}
	}
	else if(self.team == "allies")
	{
		var_01 = level.var_1C30;
	}
	else
	{
		var_01 = level.var_26FE;
	}

	for(;;)
	{
		self.var_94C5 = 0;
		foreach(param_00 in var_01)
		{
			if(self istouching(param_00))
			{
				self.var_94C5 = 1;
				break;
			}
		}

		if(!self.var_94C5 || scripts\mp\_utility::isinarbitraryup())
		{
			if(scripts\mp\_utility::func_9FB3(self.var_10902))
			{
				scripts\mp\gametypes\common::func_E171();
			}

			break;
		}

		wait(0.05);
	}
}

//Function Number: 15
func_654F()
{
	level endon("game_ended");
	for(;;)
	{
		self waittill("trigger",var_00);
		if(isdefined(var_00.team) && var_00.team == self.team)
		{
			continue;
		}

		if((isalive(var_00) && isdefined(var_00.sessionstate) && var_00.sessionstate != "spectator") || func_D376(var_00))
		{
			var_00.var_940C = 1;
			var_00 thread func_654E(self);
		}
	}
}

//Function Number: 16
func_654E(param_00)
{
	self endon("death");
	level endon("game_ended");
	if(scripts\mp\_utility::func_9FB3(self.var_130B7))
	{
		return;
	}

	for(;;)
	{
		if(isdefined(self) && self istouching(param_00))
		{
			if(!scripts\mp\_utility::func_9FB3(self.var_130B7))
			{
				thread func_6267();
			}
		}
		else
		{
			self.var_130B7 = 0;
			self.var_940C = 0;
			if(isdefined(self.var_C79D))
			{
				thread func_55EB();
			}

			break;
		}

		wait(0.05);
	}
}

//Function Number: 17
func_6267()
{
	self.var_130B7 = 1;
	self.var_C7B1 = gettime();
	self.var_C79D = scripts\mp\_utility::func_C795(self,"orange",scripts\mp\_utility::getotherteam(self.team),0,1,"perk");
	if(!isbot(self))
	{
		if(isplayer(self))
		{
			scripts\mp\_utility::func_12E5(5,0,0);
		}
	}
}

//Function Number: 18
func_55EB()
{
	self.var_130B7 = 0;
	scripts\mp\_utility::func_C78F(self.var_C79D,self);
	self.var_C79D = undefined;
	if(!isbot(self) && isplayer(self))
	{
		scripts\mp\_utility::func_12E4();
	}
}

//Function Number: 19
func_654D()
{
	level endon("game_ended");
	for(;;)
	{
		if(level.var_12A83.size > 0)
		{
			foreach(var_01 in level.var_12A83)
			{
				func_89CD(var_01);
			}
		}

		if(level.var_27EF.size > 0)
		{
			foreach(var_04 in level.var_27EF)
			{
				func_89CD(var_04);
			}
		}

		wait(0.1);
	}
}

//Function Number: 20
func_89CD(param_00)
{
	if(param_00.var_222.team == self.team)
	{
		return;
	}

	if(param_00 istouching(self))
	{
		if(!isdefined(param_00.var_C79D))
		{
			param_00.var_C79D = scripts\mp\_utility::func_C795(param_00,"orange",self.team,0,0,"lowest");
			return;
		}

		return;
	}

	if(isdefined(param_00.var_C79D))
	{
		scripts\mp\_utility::func_C78F(param_00.var_C79D,param_00);
		param_00.var_C79D = undefined;
		return;
	}
}

//Function Number: 21
func_D376(param_00)
{
	if(isdefined(param_00.var_110EA))
	{
		switch(param_00.var_110EA)
		{
			case "remote_c8":
			case "venom":
			case "minijackal":
				return 1;

			default:
				return 0;
		}
	}

	return 0;
}

//Function Number: 22
func_10110(param_00)
{
	var_01 = self.team;
	var_02 = undefined;
	var_03 = param_00.team;
	if(!isdefined(var_03))
	{
		var_03 = "allies";
	}

	var_04 = param_00 ismlgspectator();
	if(var_04)
	{
		var_03 = param_00 method_813B();
	}
	else if(var_03 == "spectator")
	{
		var_03 = "allies";
	}

	var_05 = level.var_28A0["friendly"];
	var_06 = level.var_28A0["enemy"];
	if(var_03 == var_01)
	{
		func_1012A(self.var_1196,param_00);
		func_8EC1(self.var_1195,param_00);
		return;
	}

	func_1012A(self.var_1195,param_00);
	func_8EC1(self.var_1196,param_00);
}

//Function Number: 23
func_1012A(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		param_00[var_02] showtoplayer(param_01);
	}
}

//Function Number: 24
func_8EC1(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		param_00[var_02] method_8429(param_01);
	}
}

//Function Number: 25
func_108CC()
{
	self.var_1196 = [];
	self.var_1195 = [];
	for(var_00 = 1;var_00 < self.visuals.size;var_00++)
	{
		var_01 = anglestoforward(self.visuals[var_00].angles);
		self.var_1196[self.var_1196.size] = spawnfx(level.var_28A0["friendly"],self.visuals[var_00].origin,var_01);
		self.var_1196[self.var_1196.size - 1] method_82EC();
		triggerfx(self.var_1196[self.var_1196.size - 1]);
	}

	for(var_00 = 1;var_00 < self.visuals.size;var_00++)
	{
		var_01 = anglestoforward(self.visuals[var_00].angles);
		self.var_1195[self.var_1195.size] = spawnfx(level.var_28A0["enemy"],self.visuals[var_00].origin,var_01);
		self.var_1195[self.var_1195.size - 1] method_82EC();
		triggerfx(self.var_1195[self.var_1195.size - 1]);
	}
}

//Function Number: 26
func_2892()
{
	level.var_28A0["friendly"] = loadfx("vfx/core/mp/core/vfx_front_border_cyan.vfx");
	level.var_28A0["enemy"] = loadfx("vfx/core/mp/core/vfx_front_border_orng.vfx");
}

//Function Number: 27
func_C56E()
{
	var_00 = 1;
	for(;;)
	{
		level waittill("connected",var_01);
		if(var_00)
		{
			foreach(var_03 in level.var_13FC4)
			{
				var_03 func_108CC();
			}

			var_00 = 0;
		}

		foreach(var_03 in level.var_13FC4)
		{
			var_03 func_10110(var_01);
		}
	}
}

//Function Number: 28
setupbaseareabrushes()
{
	var_00 = getbasearray("front_zone_visual_allies_contest");
	var_01 = getbasearray("front_zone_visual_axis_contest");
	var_02 = getbasearray("front_zone_visual_allies_friend");
	var_03 = getbasearray("front_zone_visual_axis_friend");
	var_04 = getbasearray("front_zone_visual_allies_enemy");
	var_05 = getbasearray("front_zone_visual_axis_enemy");
	hidebasebrushes(var_00);
	hidebasebrushes(var_01);
	hidebasebrushes(var_02);
	hidebasebrushes(var_03);
	hidebasebrushes(var_04);
	hidebasebrushes(var_05);
}

//Function Number: 29
hidebasebrushes(param_00)
{
	if(isdefined(param_00))
	{
		for(var_01 = 0;var_01 < param_00.size;var_01++)
		{
			param_00[var_01] hide();
		}
	}
}

//Function Number: 30
getbasearray(param_00)
{
	var_01 = getentarray(param_00,"targetname");
	if(!isdefined(var_01) || var_01.size == 0)
	{
		return undefined;
	}

	return var_01;
}