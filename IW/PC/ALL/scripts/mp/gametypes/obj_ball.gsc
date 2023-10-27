/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\gametypes\obj_ball.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 106
 * Decompile Time: 5410 ms
 * Timestamp: 10/27/2023 12:12:50 AM
*******************************************************************/

//Function Number: 1
func_2782()
{
	level.var_4FF4 = [];
	level.var_134 = getentarray("flag_primary","targetname");
	foreach(var_01 in level.var_134)
	{
		switch(var_01.script_label)
		{
			case "_a":
				level.var_4FF4[game["attackers"]] = var_01.origin;
				break;

			case "_b":
				level.var_4FDB = var_01.origin;
				break;

			case "_c":
				level.var_4FF4[game["defenders"]] = var_01.origin;
				break;
		}
	}
}

//Function Number: 2
func_279C()
{
	level.var_27A0 = (1000,1000,1000);
	level.var_279F = (-1000,-1000,-1000);
	var_00 = function_0076();
	if(var_00.size > 0)
	{
		foreach(var_02 in var_00)
		{
			level.var_27A0 = scripts\mp\_spawnlogic::func_6988(level.var_27A0,var_02.origin);
			level.var_279F = scripts\mp\_spawnlogic::func_6987(level.var_279F,var_02.origin);
		}

		return;
	}

	level.var_27A0 = level.var_108E4;
	level.var_279F = level.var_108E2;
}

//Function Number: 3
func_277F()
{
	if(!isdefined(level.var_53E1))
	{
		level.var_53E1 = 0;
	}

	var_00 = func_7DF3();
	level.var_27CA = func_7DF4();
	checkpostshipballspawns(var_00);
	if(var_00.size > 1 && level.var_EB50 > 1)
	{
		for(var_01 = 0;var_01 < level.var_EB50;var_01++)
		{
			var_02 = func_7DF2(var_00[var_01]);
			func_276F(var_02);
		}
	}
	else
	{
		var_03 = [];
		var_03[0] = (0,0,0);
		var_03[1] = (50,0,0);
		var_03[2] = (-50,0,0);
		var_03[3] = (0,50,0);
		var_03[4] = (0,-50,0);
		for(var_01 = 0;var_01 < level.var_EB50;var_01++)
		{
			var_02 = func_7DF2(var_00[var_01]);
			func_276F(var_02 + var_03[var_01]);
		}
	}

	level thread scripts\mp\_utility::func_83DA();
}

//Function Number: 4
checkpostshipballspawns(param_00)
{
	if(level.var_B335 == "mp_divide")
	{
		param_00[0].origin = (-261,235,610);
		param_00[1].origin = (-211,235,610);
		param_00[2].origin = (-311,235,610);
		param_00[3].origin = (-311,500,610);
		param_00[4].origin = (-211,500,610);
	}
}

//Function Number: 5
func_7DF3()
{
	var_00 = undefined;
	if(level.gametype == "tdef")
	{
		var_00 = scripts\common\utility::getstructarray("tdef_ball_start","targetname");
	}

	if(!isdefined(var_00) || !var_00.size)
	{
		var_00 = scripts\common\utility::getstructarray("ball_start","targetname");
	}

	if(level.var_EB50 > 1)
	{
		var_00 = func_10435(var_00);
	}

	return var_00;
}

//Function Number: 6
func_7DF4()
{
	var_00 = undefined;
	if(level.gametype == "tdef")
	{
		var_00 = getentarray("tdef_ball_pickup","targetname");
	}

	if(!isdefined(var_00) || !var_00.size)
	{
		var_00 = getentarray("ball_pickup","targetname");
	}

	if(level.var_EB50 > 1)
	{
		var_00 = func_10435(var_00);
	}

	return var_00;
}

//Function Number: 7
func_7DF2(param_00)
{
	if(isdefined(param_00))
	{
		var_01 = param_00.origin;
	}
	else if(level.var_53E1)
	{
		var_01 = level.players[0].origin + (0,0,30);
	}
	else
	{
		var_01 = level.var_4FDB;
	}

	return var_01;
}

//Function Number: 8
func_276F(param_00)
{
	var_01 = 30;
	var_02 = spawnstruct();
	var_02.origin = param_00;
	var_03 = param_00;
	var_02 func_278A();
	var_02.origin = var_02.var_862F + (0,0,var_01);
	var_02.var_93A8 = 0;
	if(level.var_B335 == "mp_desert")
	{
		var_03 = var_02.var_862F;
	}

	if(level.var_B335 == "mp_divide")
	{
		var_03 = var_02.var_862F;
	}

	if(level.gametype == "tdef")
	{
		level.var_27D2[level.var_27D2.size] = func_4985(var_03);
	}

	level.var_27C6[level.var_27C6.size] = var_02;
}

//Function Number: 9
func_278A(param_00)
{
	var_01 = self.origin + (0,0,32);
	var_02 = self.origin + (0,0,-1000);
	var_03 = scripts\common\trace::func_48BC(1,1,1,1,0,1,1);
	var_04 = [];
	var_05 = scripts\common\trace::func_DCED(var_01,var_02,var_04,var_03);
	self.var_862F = var_05["position"];
	return var_05["fraction"] != 0 && var_05["fraction"] != 1;
}

//Function Number: 10
func_4985(param_00)
{
	var_01 = spawn("script_model",param_00);
	var_01 setmodel("ctf_game_flag_unsa_base_wm");
	var_01 method_8588();
	var_01.var_289D = param_00;
	return var_01;
}

//Function Number: 11
func_1010F(param_00)
{
	if(isdefined(param_00.var_1194[0]))
	{
		param_00.var_1194[0] delete();
	}

	var_01 = undefined;
	var_02 = param_00.team;
	var_03 = param_00 ismlgspectator();
	if(var_03)
	{
		var_02 = param_00 method_813B();
	}
	else if(var_02 == "spectator")
	{
		var_02 = "allies";
	}

	var_04 = function_01E1(level._effect["ball_base_glow"],self.var_289D,param_00);
	var_04 method_82EC();
	param_00.var_1194[0] = var_04;
	triggerfx(var_04);
}

//Function Number: 12
func_27C4(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	var_01 = level.var_27C6[level.var_2800.size];
	var_02 = spawn("script_model",var_01.origin);
	var_02 method_8588();
	if(level.gametype == "ball" || getdvarint("scr_uplink_create_ball") == 1)
	{
		var_02 setmodel("uplink_ball_drone_wm");
		var_02 method_8318(1);
		level.var_2809 = "iw7_uplinkball_mp";
		level.var_27F8 = 1000000;
	}
	else
	{
		var_02 setmodel("tdef_ball_drone_wm");
		var_02 method_8318(1);
		level.var_2809 = "iw7_tdefball_mp";
		level.var_27F8 = 250000;
	}

	var_03 = 32;
	var_04 = undefined;
	if(isdefined(level.var_27CA) && level.var_27CA.size > 0)
	{
		var_04 = level.var_27CA[param_00];
		var_04.origin = var_02.origin;
	}
	else
	{
		var_04 = spawn("trigger_radius",var_02.origin - (0,0,var_03 / 2),0,var_03,var_03);
	}

	var_04 enablelinkto();
	var_04 linkto(var_02);
	var_04.var_C000 = 1;
	var_04.var_AD48 = 1;
	var_04.var_28AC = var_04.origin;
	var_04.var_C000 = 1;
	var_05 = [var_02];
	var_06 = scripts\mp\_gameobjects::func_4993("any",var_04,var_05,(0,0,32));
	var_06.var_C2A6 = 1;
	var_06 scripts\mp\_gameobjects::func_1C7C("any");
	var_06 func_27CE();
	var_06.var_1CB3 = 0;
	var_06.var_3B01 = level.var_2809;
	var_06.var_A575 = 0;
	var_06.var_1349F = (0,0,30);
	var_06.var_393A = ::func_2776;
	var_06.var_C566 = ::func_27A4;
	var_06.var_F6D8 = ::func_27C1;
	var_06.var_C581 = ::func_27A7;
	var_06.var_3B02 = ::func_27A9;
	var_06.var_9398 = 0;
	var_06.var_A957 = 0;
	var_06.var_C930 = 0;
	var_06.var_E1BA = 1;
	var_06.var_A958 = "none";
	var_06.var_27F4 = level.var_2800.size;
	var_06.playeroutlineid = undefined;
	var_06.playeroutlined = undefined;
	var_06.passtargetoutlineid = undefined;
	var_06.passtargetent = undefined;
	var_06.visuals[0] method_858F(1);
	var_06.visuals[0] method_8317(1);
	if(isdefined(level.var_10120))
	{
		switch(level.var_10120)
		{
			case 0:
				var_06 scripts\mp\_gameobjects::setvisibleteam("friendly");
				var_06.var_C2BE = 0;
				var_06.var_C2BD = 1;
				var_06.var_C2BF = 60;
				break;

			case 1:
				var_06 scripts\mp\_gameobjects::setvisibleteam("any");
				var_06.var_C2BE = 0;
				var_06.var_C2BD = 0;
				var_06.var_C2BF = 0.05;
				break;

			case 2:
				var_06 scripts\mp\_gameobjects::setvisibleteam("any");
				var_06.var_C2BE = 0;
				var_06.var_C2BD = 1;
				var_06.var_C2BF = 1;
				break;

			case 3:
				var_06 scripts\mp\_gameobjects::setvisibleteam("any");
				var_06.var_C2BE = 0;
				var_06.var_C2BD = 1;
				var_06.var_C2BF = 1.5;
				break;

			case 4:
				var_06 scripts\mp\_gameobjects::setvisibleteam("any");
				var_06.var_C2BE = 0;
				var_06.var_C2BD = 1;
				var_06.var_C2BF = 2;
				break;

			case 5:
				var_06 scripts\mp\_gameobjects::setvisibleteam("any");
				var_06.var_C2BE = 0;
				var_06.var_C2BD = 1;
				var_06.var_C2BF = 3;
				break;

			case 6:
				var_06 scripts\mp\_gameobjects::setvisibleteam("any");
				var_06.var_C2BE = 0;
				var_06.var_C2BD = 1;
				var_06.var_C2BF = 4;
				break;
		}
	}
	else
	{
		var_06 scripts\mp\_gameobjects::setvisibleteam("any");
		var_06.var_C2BE = 0;
		var_06.var_C2BD = 1;
		var_06.var_C2BF = 3;
	}

	var_06 func_2772(var_01);
	level.var_2800[level.var_2800.size] = var_06;
	if(level.gametype == "tdef")
	{
		level.var_2800[0] thread func_10DA5();
	}

	if(!scripts\mp\_utility::func_9FB3(level.var_53E1))
	{
		var_06 thread func_278D(1,1);
	}

	var_06 thread func_279E();
	var_06.visuals[0] playloopsound("uplink_ball_hum_lp");
	var_07 = ["physicscontents_clipshot","physicscontents_corpseclipshot","physicscontents_missileclip","physicscontents_solid","physicscontents_vehicle","physicscontents_player","physicscontents_actor","physicscontents_glass","physicscontents_itemclip"];
	var_08 = physics_createcontents(var_07);
	level.ballphysicscontentoverride = var_08;
	level.balltraceradius = 10;
	if(level.gametype == "tdef")
	{
		level.balltraceradius = 20;
	}
}

//Function Number: 13
func_2776(param_00)
{
	if(isdefined(self.var_5EED) && self.var_5EED >= gettime())
	{
		return 0;
	}

	if(isplayer(param_00))
	{
		if(!param_00 scripts\common\utility::func_9FFD())
		{
			return 0;
		}

		if(isdefined(param_00.var_B31D) && param_00.var_B31D)
		{
			return 0;
		}

		if(scripts\mp\_utility::func_9FB3(param_00.var_9D81))
		{
			return 0;
		}

		if(scripts\mp\_utility::func_9FB3(param_00.var_13107))
		{
			return 0;
		}

		if(!func_1312E(param_00))
		{
			return 0;
		}

		var_01 = param_00 getcurrentweapon();
		if(isdefined(var_01))
		{
			if(!func_1312D(var_01))
			{
				return 0;
			}
		}

		var_02 = param_00.var_3C64;
		if(isdefined(var_02) && param_00 method_81C2())
		{
			if(!func_1312D(var_02))
			{
				return 0;
			}
		}

		if(param_00 scripts\mp\_utility::func_9D47())
		{
			var_02 = param_00 scripts\mp\_utility::func_7E4D();
			if(!func_1312D(var_02))
			{
				return 0;
			}
		}

		if(param_00 scripts\mp\_utility::func_9FC6())
		{
			return 0;
		}

		if(param_00 func_D207())
		{
			return 0;
		}
	}
	else
	{
		return 0;
	}

	return 1;
}

//Function Number: 14
func_27A4(param_00)
{
	param_00 notify("obj_picked_up");
	param_00 thread checkgesturethread();
	var_01 = 0;
	if(level.var_27FC)
	{
		if(func_836A(param_00))
		{
			param_00 thread scripts\mp\_utility::func_83B4("ball_grab");
		}

		level.var_27F9 = gettime();
		level.var_27FC = 0;
		if(isdefined(level.var_D6AF) && level.var_D6AF == 1 && scripts\mp\_utility::func_9FB3(level.var_D6B0))
		{
			var_01 = 1;
		}

		param_00 notify("ball_grab");
	}

	if(isdefined(level.var_D6AF) && level.var_D6AF == 2 && scripts\mp\_utility::func_9FB3(level.var_D6B0) && isdefined(self.var_A956) && self.var_A956 != param_00)
	{
		var_01 = 1;
	}

	if(level.gametype == "tdef")
	{
		param_00 scripts\mp\gametypes\tdef::func_8116();
		level thread scripts\mp\gametypes\tdef::func_26CE(param_00.team);
		if(!level.var_11920)
		{
			level scripts\mp\_gamelogic::func_C9D6();
		}
	}

	if(scripts\mp\_utility::func_9FB3(level.var_D6AF))
	{
		level func_12F46(param_00.team,0,0,var_01);
	}

	level.var_130DD = 0;
	level.codcasterball = undefined;
	level.codcasterballinitialforcevector = undefined;
	var_02 = self.visuals[0] getlinkedparent();
	if(isdefined(var_02))
	{
		self.visuals[0] unlink();
	}

	if(!scripts\mp\_utility::func_9FB3(level.var_53E1))
	{
		param_00 scripts\mp\_utility::func_8387("specialty_ballcarrier");
	}

	param_00.var_2777 = self;
	param_00.var_C274 = 1;
	self.carrier scripts\mp\_utility::func_8387("specialty_sprintfire");
	self.carrier.var_8C10 = 1;
	if(!scripts\mp\_utility::func_9FB3(level.var_53E1))
	{
		param_00 scripts\mp\_lightarmor::func_F786(param_00,level.var_3AEC);
	}

	if(!scripts\mp\_utility::func_9FB3(level.var_53E1))
	{
		thread func_27B8(param_00.team,"mp_uplink_ball_pickedup_friendly","mp_uplink_ball_pickedup_enemy");
	}

	param_00 scripts\common\utility::func_1C6E(0);
	foreach(var_05, var_04 in param_00.var_D782)
	{
		param_00 scripts\mp\_powers::func_D727(var_05);
	}

	self.visuals[0] physicslaunchserver(self.visuals[0].origin,(0,0,0));
	self.visuals[0] method_851B();
	self.visuals[0] scripts\mp\_movers::func_C13B();
	self.var_C930 = 0;
	self.visuals[0] func_10FF6();
	self.visuals[0] show();
	self.visuals[0] hide(1);
	self.visuals[0] linkto(param_00,"j_wrist_ri",(0,0,0),param_00.angles);
	self.visuals[0] setscriptablepartstate("uplink_drone_hide","hide",0);
	self.trigger scripts\mp\_movers::func_11001();
	self.var_4BBD.var_93A8 = 0;
	var_06 = 0;
	if(isdefined(self.var_DA5A))
	{
		var_06 = 1;
		self.var_DA5A delete();
	}

	var_07 = param_00.team;
	var_08 = scripts\mp\_utility::getotherteam(param_00.team);
	self.visuals[0] method_831F(param_00);
	if(var_06)
	{
		if(self.var_A958 == param_00.team)
		{
			if(!scripts\mp\_utility::func_9FB3(level.var_53E1))
			{
				scripts\mp\_utility::func_10E60("pass_complete",var_07);
			}

			param_00.var_C94C = gettime();
			param_00.var_C94A = self.var_A956;
		}
		else
		{
			if(!scripts\mp\_utility::func_9FB3(level.var_53E1))
			{
				scripts\mp\_utility::func_10E60("pass_intercepted",var_08);
			}

			param_00 thread scripts\mp\_awards::func_8380("mode_uplink_intercept");
			if(isplayer(param_00))
			{
				param_00 thread scripts\mp\_matchdata::func_AFBA("pickup_interception",param_00.origin);
			}
		}
	}
	else
	{
		if(!scripts\mp\_utility::func_9FB3(level.var_53E1) && self.var_A958 != param_00.team)
		{
			scripts\mp\_utility::func_10E60("ally_own_drone",var_07);
			scripts\mp\_utility::func_10E60("enemy_own_drone",var_08);
		}

		if(isplayer(param_00))
		{
			param_00 thread scripts\mp\_matchdata::func_AFBA("pickup",param_00.origin);
		}
	}

	if(!scripts\mp\_utility::func_9FB3(level.var_53E1))
	{
		func_278F();
	}

	self.var_A957 = 0;
	self.var_A956 = param_00;
	self.var_A958 = param_00.team;
	self.ownerteam = param_00.team;
	func_27CD(self.ownerteam);
	scripts\mp\_utility::func_F79E(12,param_00.team,param_00 getentitynumber());
	param_00 setweaponammoclip(level.var_2809,1);
	if(getdvarint("com_codcasterEnabled",0) == 1)
	{
		param_00 method_80C1(1);
	}

	param_00 thread func_D314(self);
	if(!scripts\mp\_utility::func_9FB3(level.var_53E1))
	{
		scripts\mp\_gamelogic::func_F73B(param_00,1);
	}

	self notify("physics_timeout");
}

//Function Number: 15
checkgesturethread()
{
	self endon("death");
	self endon("disconnect");
	self endon("drop_object");
	wait(0.05);
	if(isdefined(self.var_77C2) && self isgestureplaying(self.var_77C2))
	{
		self stopgestureviewmodel(self.var_77C2,0.05,1);
	}
}

//Function Number: 16
func_53D1()
{
	var_00 = spawn("script_model",self.var_4B2C);
	var_00 setmodel("tag_origin");
	var_01 = self.var_A956 scripts\mp\_utility::func_1302("blackhole_grenade_mp",self.var_4B2C,(0,0,0));
	var_01 linkto(var_00,"tag_origin");
	var_01.var_222 = self.var_A956;
	var_01 hide(1);
	var_01.var_222 thread scripts\mp\_blackholegrenade::func_2B3E(var_01);
}

//Function Number: 17
func_836A(param_00)
{
	if(level.gametype == "tdef")
	{
		var_01 = 15000;
	}
	else
	{
		var_01 = 10000;
	}

	var_02 = param_00 func_12E69();
	if(var_02)
	{
		return 0;
	}

	if(isdefined(self.var_A956) && param_00.team == self.var_A956.team && gettime() < level.var_27F9 + var_01)
	{
		return 0;
	}

	return 1;
}

//Function Number: 18
func_12E69()
{
	if(!isdefined(self.var_2F37))
	{
		self.var_C230 = 0;
		self.var_2F37 = 0;
	}

	self.var_C230++;
	if(scripts\mp\_utility::func_7FB9() < 1)
	{
		return 0;
	}

	self.var_2F37 = self.var_C230 / scripts\mp\_utility::func_7FB9();
	if(self.var_2F37 < 4)
	{
		return 0;
	}

	return 1;
}

//Function Number: 19
func_27B8(param_00,param_01,param_02)
{
	var_03 = scripts\mp\_utility::getotherteam(param_00);
	foreach(var_05 in level.players)
	{
		if(var_05.team == param_00)
		{
			var_05 playlocalsound(param_01);
			continue;
		}

		if(var_05.team == var_03)
		{
			var_05 playlocalsound(param_02);
		}
	}
}

//Function Number: 20
func_27C1(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	var_04 = 0;
	self.var_9F24 = 1;
	self.var_5EED = gettime();
	self notify("dropped");
	var_05 = (0,0,0);
	var_06 = self.carrier;
	if(isdefined(var_06) && var_06.team != "spectator")
	{
		var_07 = var_06.origin;
		var_05 = var_06.angles;
		var_06 notify("ball_dropped");
	}
	else if(isdefined(param_02))
	{
		var_07 = param_02;
	}
	else
	{
		var_07 = self.var_EA28;
	}

	var_07 = var_07 + (0,0,40);
	if(isdefined(self.var_DA5A))
	{
		self.var_DA5A delete();
	}

	for(var_08 = 0;var_08 < self.visuals.size;var_08++)
	{
		self.visuals[var_08].origin = var_07;
		self.visuals[var_08].angles = var_05;
		self.visuals[var_08] show();
		var_09 = self.visuals[var_08] getlinkedparent();
		if(isdefined(var_09))
		{
			self.visuals[var_08] unlink();
		}

		self.visuals[var_08] setscriptablepartstate("uplink_drone_hide","show",0);
	}

	if(scripts\mp\_utility::func_9FB3(param_03) || scripts\mp\_utility::func_9FB3(param_02))
	{
		var_04 = 1;
	}

	func_2778(var_04);
	if(!isdefined(level.var_EC39))
	{
		level.var_EC39 = 0;
	}

	if(level.var_EC39 > 0)
	{
		self.trigger.origin = self.trigger.origin - (0,0,10000);
	}
	else
	{
		self.trigger.origin = var_07;
	}

	func_2783();
	self.var_4B2C = self.trigger.origin;
	if(!scripts\mp\_utility::func_9FB3(level.var_53E1))
	{
		thread func_278D(0);
	}

	self.ownerteam = "any";
	func_27CE();
	scripts\mp\_gameobjects::func_41A0();
	if(isdefined(var_06))
	{
		var_06 func_D315();
	}

	scripts\mp\_gameobjects::updatecompassicons();
	scripts\mp\_gameobjects::updateworldicons();
	self.var_9F24 = 0;
	if(!param_00)
	{
		var_0A = self.var_A958;
		var_0B = scripts\mp\_utility::getotherteam(var_0A);
		if(!scripts\mp\_utility::func_9FB3(level.var_53E1) && !isdefined(param_01) && !scripts\mp\_utility::func_9FB3(param_02))
		{
			scripts\mp\_utility::func_10E60("ally_drop_drone",var_0A);
			scripts\mp\_utility::func_10E60("enemy_drop_drone",var_0B);
		}

		var_0C = (0,var_05[1],0);
		var_0D = anglestoforward(var_0C);
		if(isdefined(param_01))
		{
			var_0E = var_0D * 20 + (0,0,80);
		}
		else
		{
			var_0E = var_0E * 200 + (0,0,80);
		}

		func_27B1(var_0E);
	}

	var_0F = spawnstruct();
	var_0F.var_3AF7 = self;
	var_0F.var_4E53 = ::func_27A8;
	self.trigger thread scripts\mp\_movers::func_892F(var_0F);
	if(level.var_11920)
	{
		level scripts\mp\_gamelogic::func_E2FF();
	}

	return 1;
}

//Function Number: 21
func_2778(param_00)
{
	if(isdefined(self.carrier))
	{
		if(level.gametype == "tdef")
		{
			self.carrier scripts\mp\gametypes\tdef::func_8116();
		}

		self.carrier.var_27F3 = undefined;
		self.carrier.var_C087 = gettime() + 500;
		self.carrier func_CFCA();
		self.carrier notify("cancel_update_pass_target");
		self.carrier.var_2777 = undefined;
		if(!scripts\mp\_utility::func_9FB3(level.var_53E1))
		{
			self.carrier scripts\mp\_utility::func_E150("specialty_ballcarrier");
			self.carrier scripts\mp\_lightarmor::func_ACAC(self.carrier);
		}

		if(self.carrier.var_8C10)
		{
			self.carrier scripts\mp\_utility::func_E150("specialty_sprintfire");
		}

		self.carrier.var_8C10 = 0;
		if(getdvarint("com_codcasterEnabled",0) == 1)
		{
			self.carrier method_80C1(0);
		}

		self.carrier scripts\common\utility::func_1C6E(1);
		if(scripts\mp\_utility::func_9FB3(param_00))
		{
			foreach(var_03, var_02 in self.carrier.var_D782)
			{
				self.carrier scripts\mp\_powers::func_D72D(var_03);
			}
		}

		self.carrier method_851A(0);
		self.carrier.var_C274 = 0;
		self.visuals[0] method_831F(undefined);
	}
}

//Function Number: 22
func_27A7()
{
	func_2772(level.var_27C6[self.var_27F4]);
	func_27BC();
	var_00 = self.visuals[0];
	var_00 scripts\mp\_movers::func_C13B();
	var_01 = var_00 getlinkedparent();
	if(isdefined(var_01))
	{
		var_00 unlink();
	}

	self.visuals[0] func_10FF6();
	var_00 physicslaunchserver(var_00.origin,(0,0,0));
	var_00 method_851B();
	func_2783();
	if(isdefined(self.var_DA5A))
	{
		self.var_DA5A delete();
	}

	var_02 = "none";
	var_03 = self.var_A958;
	if(isdefined(var_03))
	{
		var_02 = scripts\mp\_utility::getotherteam(var_03);
	}

	self.var_A958 = "none";
	func_2778(1);
	self.trigger scripts\mp\_movers::func_11001();
	func_27CC();
	if(level.gametype != "tdef")
	{
		scripts\mp\_gameobjects::func_F806(var_00.var_28AC + (0,0,4000),(0,0,0));
		var_00 moveto(var_00.var_28AC,3,0,3);
		var_00 rotatevelocity((0,720,0),3,0,3);
	}
	else
	{
		if(!level.var_11920)
		{
			level scripts\mp\_gamelogic::func_C9D6();
		}

		var_00 hide(1);
		self.visuals[0] setscriptablepartstate("uplink_drone_hide","hide",0);
		thread func_136E1(var_00);
	}

	if(!scripts\mp\_utility::func_9FB3(level.var_53E1))
	{
		playsoundatpos(var_00.var_28AC,"mp_uplink_ball_reset");
	}

	if(!self.var_A957 && isdefined(var_03) && isdefined(var_02))
	{
		if(!scripts\mp\_utility::func_9FB3(level.var_53E1) && var_03 != "none")
		{
			scripts\mp\_utility::func_10E60("drone_reset",var_03);
			scripts\mp\_utility::func_10E60("drone_reset",var_02);
		}

		if(isdefined(self.var_A956))
		{
		}
	}

	self.ownerteam = "any";
	if(level.gametype == "ball" || level.var_53E1)
	{
		thread func_2785(3);
	}

	if(!scripts\mp\_utility::func_9FB3(level.var_53E1))
	{
		thread func_2784(var_00,3);
	}

	thread scripts\mp\_matchdata::func_AFBA("obj_return",var_00.var_28AC);
}

//Function Number: 23
func_277C()
{
	self.visuals[0].var_C3B7 = self.visuals[0] method_82C7(0);
}

//Function Number: 24
func_27A9()
{
	self endon("disconnect");
	thread func_27AD();
	thread func_27C3();
	thread func_27D0();
	self.var_3AF7 waittill("dropped");
}

//Function Number: 25
func_27AD()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self endon("drop_object");
	for(;;)
	{
		self waittill("ball_pass",var_00);
		if(var_00 != level.var_2809)
		{
			continue;
		}

		if(!isdefined(self.var_C935))
		{
			self iprintlnbold("No Pass Target");
			continue;
		}

		self.var_3AF7.var_C930 = 1;
		break;
	}

	if(isdefined(self.var_3AF7))
	{
		thread func_27AA();
		var_01 = self.var_C935;
		var_02 = self.var_C935.origin;
		wait(0.15);
		if(isdefined(self.var_C935))
		{
			var_01 = self.var_C935;
		}

		self.var_3AF7 thread func_27AB(self,var_01,var_02);
	}
}

//Function Number: 26
func_27C3()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self endon("drop_object");
	if(level.gametype != "tdef")
	{
		var_00 = getdvarfloat("scr_ball_shoot_extra_pitch",0);
		var_01 = getdvarfloat("scr_ball_shoot_force",825);
	}
	else
	{
		var_00 = getdvarfloat("scr_tdef_shoot_extra_pitch",-3);
		var_01 = getdvarfloat("scr_tdef_shoot_force",450);
	}

	for(;;)
	{
		self waittill("weapon_fired",var_02);
		if(var_02 != level.var_2809)
		{
			continue;
		}

		self setweaponammoclip(level.var_2809,0);
		break;
	}

	if(isdefined(self.var_3AF7))
	{
		thread scripts\mp\_matchdata::func_AFBA("pass",self.origin);
		if(!scripts\mp\_utility::func_9FB3(level.var_53E1))
		{
			self playsound("mp_uplink_ball_pass");
		}

		wait(0.15);
		if(self method_81BE())
		{
			var_00 = -12;
			if(level.gametype == "tdef")
			{
				var_01 = var_01 + 200;
			}
		}

		var_03 = self getplayerangles();
		var_03 = var_03 + (var_00,0,0);
		var_03 = (clamp(var_03[0],-85,85),var_03[1],var_03[2]);
		var_04 = anglestoforward(var_03);
		thread func_27AA();
		thread func_277B(self.var_3AF7);
		self.var_3AF7 func_2780();
		self.var_3AF7 thread func_27B2(var_04 * var_01,self);
	}
}

//Function Number: 27
func_27D0()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self endon("drop_object");
	thread func_11237();
	var_00 = level.var_2809;
	for(;;)
	{
		if(var_00 == self getcurrentweapon())
		{
			break;
		}

		self waittill("weapon_change");
	}

	for(;;)
	{
		self waittill("weapon_change",var_01);
		var_02 = self.var_11234;
		var_03 = var_02.var_10E47.var_130F8;
		if(!isdefined(var_03))
		{
			continue;
		}

		if(isdefined(var_01) && var_01 == var_03)
		{
			break;
		}
	}

	var_04 = self getplayerangles();
	var_04 = (clamp(var_04[0],-85,85),scripts\common\utility::func_152F(var_04[1] + 20),var_04[2]);
	var_05 = anglestoforward(var_04);
	var_06 = 90;
	self.var_3AF7 thread func_27B2(var_05 * var_06,self,1);
}

//Function Number: 28
func_11237()
{
	self endon("death");
	self endon("disconnect");
	self endon("drop_object");
	self endon("unsetBallCarrier");
	self waittill("super_started");
	var_00 = self.var_11234;
	switch(var_00.var_10E47.var_DE3F)
	{
		case "super_chargemode":
		case "super_phaseshift":
			ball_drop_on_ability();
			break;

		case "super_teleport":
		case "super_rewind":
			scripts\common\utility::waittill_any_3("teleport_success","rewind_success");
			ball_drop_on_ability();
			break;
	}
}

//Function Number: 29
ball_drop_on_ability()
{
	var_00 = self getplayerangles();
	var_00 = (clamp(var_00[0],-85,85),scripts\common\utility::func_152F(var_00[1] + 20),var_00[2]);
	var_01 = anglestoforward(var_00);
	var_02 = 90;
	self.var_3AF7 thread func_27B2(var_01 * var_02,self,1);
}

//Function Number: 30
func_27AA()
{
	self endon("death");
	self endon("disconnect");
	self.var_C933 = 1;
	self allowmelee(0);
	while(level.var_2809 == self getcurrentweapon())
	{
		scripts\common\utility::func_136F7();
	}

	self allowmelee(1);
	self.var_C933 = 0;
	foreach(var_02, var_01 in self.var_D782)
	{
		scripts\mp\_powers::func_D72D(var_02);
	}
}

//Function Number: 31
func_27B2(param_00,param_01,param_02)
{
	func_27C1(1,undefined,0,param_02);
	func_27B1(param_00,param_01);
}

//Function Number: 32
func_27AB(param_00,param_01,param_02)
{
	func_27C1(1);
	if(isdefined(param_01))
	{
		param_02 = param_01.origin;
	}

	var_03 = param_00 getpasserorigin();
	var_04 = param_00 getpasserdirection();
	if(!validatepasstarget(self,param_00,param_01))
	{
		var_03 = self.lastvalidpassorg;
		var_04 = self.lastvalidpassdir;
	}

	var_05 = var_04 * 30;
	var_06 = var_04 * 60;
	var_07 = var_03 + var_05;
	var_08 = param_01 gettargetorigin();
	var_09 = scripts\common\trace::func_109DD(var_07,var_08,level.balltraceradius,param_00,level.ballphysicscontentoverride,0);
	var_0A = 1;
	if(var_09["fraction"] < 1 || !scripts\mp\_utility::func_9F19(param_01))
	{
		if(var_09["hittype"] == "hittype_entity" && isdefined(var_09["entity"]) && isplayer(var_09["entity"]))
		{
			var_0A = max(0.1,0.7 * var_09["fraction"]);
		}
		else
		{
			var_0A = 0.7 * var_09["fraction"];
		}

		scripts\mp\_gameobjects::func_F806(var_07 + var_05 * var_0A,self.visuals[0].angles);
	}
	else
	{
		scripts\mp\_gameobjects::func_F806(var_09["position"],self.visuals[0].angles);
	}

	if(isdefined(param_01))
	{
		self.var_DA5A = scripts\mp\_utility::func_1309("uplinkball_tracking_mp",var_07 + var_06 * var_0A,var_08,param_00);
		self.var_DA5A missile_settargetent(param_01,param_01 gettargetoffset());
	}

	self.trigger.origin = self.trigger.origin - (0,0,10000);
	param_01 thread func_1878(self.var_DA5A);
	self.visuals[0] linkto(self.var_DA5A);
	func_2783();
	func_2780();
	func_277C();
	level.codcasterball = self.visuals[0];
	thread func_27A6();
	thread func_27A5();
	thread func_27A3();
	thread ball_track_pass_velocity(param_01);
	thread ball_track_pass_lifetime();
	thread ball_track_target(param_01);
	if(level.gametype == "ball")
	{
		thread scripts\mp\gametypes\ball::func_27AC();
	}
}

//Function Number: 33
func_D314(param_00)
{
	self endon("disconnect");
	self endon("cancel_update_pass_target");
	func_D315();
	childthread func_D1A5();
	for(;;)
	{
		var_01 = undefined;
		if(!self method_81B5())
		{
			var_02 = [];
			foreach(var_04 in level.players)
			{
				if(!isdefined(var_04.team))
				{
					continue;
				}

				if(var_04.team != self.team)
				{
					continue;
				}

				if(!scripts\mp\_utility::func_9F19(var_04))
				{
					continue;
				}

				if(!param_00 func_2776(var_04))
				{
					continue;
				}

				if(validatepasstarget(param_00,self,var_04))
				{
					var_02[var_02.size] = var_04;
				}
			}

			if(isdefined(var_02) && var_02.size > 0)
			{
				var_02 = scripts\mp\_utility::func_DB9F(var_02,::func_445B);
				var_06 = self geteye();
				foreach(var_04 in var_02)
				{
					var_08 = var_04 gettargetorigin();
					if(sighttracepassed(var_06,var_08,0,self,var_04))
					{
						var_01 = var_04;
						break;
					}
				}
			}
		}

		func_D289(var_01);
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 34
validatepasstarget(param_00,param_01,param_02)
{
	var_03 = 0.85;
	var_04 = param_01 getpasserorigin();
	var_05 = param_01 getpasserdirection();
	var_06 = param_02 gettargetorigin();
	var_07 = distancesquared(var_06,var_04);
	if(var_07 > level.var_27F8)
	{
		return 0;
	}

	var_08 = vectornormalize(var_06 - var_04);
	var_09 = vectordot(var_05,var_08);
	if(var_09 > var_03)
	{
		var_0A = var_05 * 30;
		var_0B = var_04 + var_0A;
		var_0C = scripts\common\trace::func_109DD(var_0B,var_06,level.balltraceradius,param_01,level.ballphysicscontentoverride,0);
		if((isdefined(var_0C["entity"]) && isplayer(var_0C["entity"])) || var_0C["fraction"] > 0.8)
		{
			param_02.var_C931 = var_09;
			param_00.lastvalidpassorg = var_04;
			param_00.lastvalidpassdir = var_05;
			return 1;
		}
	}

	return 0;
}

//Function Number: 35
func_D315()
{
	if(!isdefined(self))
	{
		return;
	}

	if(!isdefined(self.var_3AF7))
	{
		return;
	}

	if(isdefined(self.var_3AF7.passtargetoutlineid) && isdefined(self.var_3AF7.passtargetent))
	{
		scripts\mp\_utility::func_C78F(self.var_3AF7.passtargetoutlineid,self.var_3AF7.passtargetent);
		self.var_3AF7.passtargetoutlineid = undefined;
		self.var_3AF7.passtargetent = undefined;
	}

	if(isdefined(self.var_3AF7.playeroutlineid) && isdefined(self.var_3AF7.playeroutlined))
	{
		scripts\mp\_utility::func_C78F(self.var_3AF7.playeroutlineid,self.var_3AF7.playeroutlined);
		self.var_3AF7.playeroutlineid = undefined;
		self.var_3AF7.playeroutlined = undefined;
	}

	if(self.var_3AF7.var_9F24)
	{
		return;
	}

	var_00 = [];
	var_01 = [];
	var_02 = scripts\mp\_utility::getotherteam(self.team);
	var_03 = undefined;
	var_04 = undefined;
	foreach(var_06 in level.players)
	{
		if(var_06 == self)
		{
			continue;
		}

		if(var_06.team == self.team)
		{
			var_00[var_00.size] = var_06;
			continue;
		}

		if(var_06.team == var_02)
		{
			var_01[var_01.size] = var_06;
		}
	}

	foreach(var_06 in var_00)
	{
		var_09 = isdefined(self.var_C935) && self.var_C935 == var_06;
	}

	if(isdefined(self.var_C935))
	{
		var_03 = scripts\mp\_utility::func_C794(self.var_C935,"cyan",self,1,0,"level_script");
	}

	self.var_3AF7.passtargetoutlineid = var_03;
	self.var_3AF7.passtargetent = self.var_C935;
	if(level.gametype == "tdef" && var_00.size > 0)
	{
		var_04 = scripts\mp\_utility::func_C795(self,"cyan",self.team,0,1,"level_script");
	}

	self.var_3AF7.playeroutlineid = var_04;
	self.var_3AF7.playeroutlined = self;
}

//Function Number: 36
func_1878(param_00)
{
	var_01 = self;
	param_00 endon("pass_end");
	while(isdefined(var_01) && isdefined(param_00))
	{
		param_00 missile_settargetent(var_01,var_01 gettargetoffset());
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 37
func_445B(param_00,param_01)
{
	return param_00.var_C931 >= param_01.var_C931;
}

//Function Number: 38
func_D1A5()
{
	for(;;)
	{
		level waittill("joined_team",var_00);
		func_D315();
	}
}

//Function Number: 39
func_D289(param_00)
{
	var_01 = 80;
	var_02 = 0;
	if(isdefined(param_00))
	{
		switch(param_00 getstance())
		{
			case "crouch":
				var_01 = 60;
				break;

			case "prone":
				var_01 = 35;
				break;
		}

		if(!isdefined(self.pass_icon_offset) || self.pass_icon_offset != var_01)
		{
			var_02 = 1;
			self.pass_icon_offset = var_01;
		}
	}

	var_03 = (0,0,var_01);
	if(isdefined(self.var_C935) && isdefined(param_00) && self.var_C935 == param_00)
	{
		if(var_02)
		{
			self.var_C932 = param_00 scripts\mp\_entityheadicons::func_F73D(self,"waypoint_ball_pass",var_03,10,10,0,0.05,0,1,0,0);
		}

		return;
	}

	if(!isdefined(self.var_C935) && !isdefined(param_00))
	{
		return;
	}

	func_CFCA();
	if(isdefined(param_00))
	{
		self.var_C932 = param_00 scripts\mp\_entityheadicons::func_F73D(self,"waypoint_ball_pass",var_03,10,10,0,0.05,0,1,0,0);
		self.var_C935 = param_00;
		var_04 = [];
		foreach(var_06 in level.players)
		{
			if(var_06.team == self.team && var_06 != self && var_06 != param_00)
			{
				var_04[var_04.size] = var_06;
			}
		}

		self method_851A(1);
	}

	func_D315();
}

//Function Number: 40
func_CFCA()
{
	if(isdefined(self.var_C932))
	{
		self.var_C932 destroy();
	}

	var_00 = [];
	foreach(var_02 in level.players)
	{
		if(var_02.team == self.team && var_02 != self)
		{
			var_00[var_00.size] = var_02;
		}
	}

	self.var_C935 = undefined;
	self method_851A(0);
	func_D315();
}

//Function Number: 41
func_D207()
{
	return (isdefined(self.var_C087) && self.var_C087 > gettime()) || isdefined(self.var_2777);
}

//Function Number: 42
func_1312E(param_00)
{
	if(!isdefined(param_00.var_11234))
	{
		return 1;
	}

	if(!isdefined(param_00.var_11234.var_9E53) || !param_00.var_11234.var_9E53)
	{
		return 1;
	}

	if(param_00.var_11234.var_10E47.var_DE3F == "super_phaseshift")
	{
		return 0;
	}

	return 1;
}

//Function Number: 43
func_1312D(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	if(param_00 == level.var_2809)
	{
		return 0;
	}

	if(param_00 == "ks_remote_map_mp")
	{
		return 0;
	}

	if(param_00 == "ks_remote_device_mp")
	{
		return 0;
	}

	if(scripts\mp\_utility::func_9E6C(param_00))
	{
		return 0;
	}

	return 1;
}

//Function Number: 44
func_27A3()
{
	self.visuals[0] endon("pass_end");
	level waittill("host_migration_begin");
	if(isdefined(self.var_DA5A))
	{
		if(!isdefined(self.var_C935) && !isdefined(self.carrier) && !self.var_9398)
		{
			if(self.visuals[0].origin != self.visuals[0].var_28AC + (0,0,4000))
			{
				func_27BC();
				if(!isdefined(self.lastpassdir))
				{
					self.lastpassdir = (0,0,1);
				}

				func_27B1(self.lastpassdir * 400);
				return;
			}
		}
	}
}

//Function Number: 45
ball_track_pass_velocity(param_00)
{
	self.visuals[0] endon("pass_end");
	self.var_DA5A endon("projectile_impact_player");
	self.var_DA5A endon("death");
	self.lastpassdir = vectornormalize(param_00.origin - self.var_DA5A.origin);
	var_01 = undefined;
	for(;;)
	{
		if(isdefined(var_01))
		{
			self.lastpassdir = vectornormalize(self.var_DA5A.origin - var_01);
		}

		var_01 = self.var_DA5A.origin;
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 46
ball_track_pass_lifetime()
{
	self.visuals[0] endon("pass_end");
	self.var_DA5A endon("projectile_impact_player");
	self.var_DA5A endon("death");
	var_00 = gettime();
	for(var_01 = var_00;var_01 < var_00 + 2000;var_01 = gettime())
	{
		scripts\common\utility::func_136F7();
	}

	self.var_DA5A delete();
}

//Function Number: 47
ball_track_target(param_00)
{
	self.visuals[0] endon("pass_end");
	self.var_DA5A endon("projectile_impact_player");
	self.var_DA5A endon("death");
	for(;;)
	{
		if(!isdefined(param_00))
		{
			break;
		}

		if(!scripts\mp\_utility::func_9F19(param_00))
		{
			break;
		}

		if(isdefined(param_00.var_11234) && scripts\mp\_utility::func_9FB3(param_00.var_11234.var_9E53))
		{
			if(param_00.var_11234.var_10E47.var_DE3F == "super_phaseshift")
			{
				break;
			}
		}

		scripts\common\utility::func_136F7();
	}

	self.var_DA5A delete();
}

//Function Number: 48
func_27A5()
{
	self endon("reset");
	self.var_DA5A waittill("death");
	waittillframeend;
	if(!isdefined(self.carrier))
	{
		self.trigger.origin = self.var_4B2C;
	}

	var_00 = self.visuals[0];
	if(!isdefined(self.carrier) && !self.var_9398)
	{
		if(var_00.origin != var_00.var_28AC + (0,0,4000))
		{
			func_27BC();
			if(!isdefined(self.lastpassdir))
			{
				self.lastpassdir = (0,0,1);
			}

			func_27B1(self.lastpassdir * 400);
		}
	}

	func_27BC();
	var_00 notify("pass_end");
}

//Function Number: 49
func_27A6()
{
	self.visuals[0] endon("pass_end");
	self.var_DA5A waittill("projectile_impact_player",var_00);
	self.trigger.origin = self.visuals[0].origin;
	self.trigger notify("trigger",var_00);
}

//Function Number: 50
func_27B1(param_00,param_01)
{
	var_02 = self.visuals[0];
	var_02.var_C71B = undefined;
	var_03 = var_02.origin;
	var_04 = var_02;
	if(isdefined(param_01))
	{
		var_04 = param_01;
		var_03 = param_01 geteye();
		var_05 = anglestoright(param_00);
		var_03 = var_03 + (var_05[0],var_05[1],0) * 7;
		if(param_01 method_81BE())
		{
			var_03 = var_03 + (0,0,10);
		}

		var_06 = var_03;
		var_07 = vectornormalize(param_00) * 80;
		var_08 = ["physicscontents_clipshot","physicscontents_corpseclipshot","physicscontents_missileclip","physicscontents_solid","physicscontents_vehicle","physicscontents_player","physicscontents_actor","physicscontents_glass","physicscontents_itemclip"];
		var_09 = physics_createcontents(var_08);
		var_0A = scripts\common\trace::func_109DD(var_06,var_06 + var_07,38,param_01,var_09);
		if(var_0A["fraction"] < 1)
		{
			var_0B = 0.7 * var_0A["fraction"];
			scripts\mp\_gameobjects::func_F806(var_06 + var_07 * var_0B,var_02.angles);
		}
		else
		{
			scripts\mp\_gameobjects::func_F806(var_0A["position"],var_02.angles);
		}
	}

	self.visuals[0] physicslaunchserver(var_02.origin,param_00);
	self.visuals[0] thread scripts\mp\_utility::func_DED0();
	self.visuals[0] method_84D1();
	scripts\mp\_utility::func_DECF(self.visuals[0],::func_279A);
	self.visuals[0].origin = self.trigger.origin;
	self.trigger linkto(self.visuals[0]);
	level.codcasterball = self.visuals[0];
	level.codcasterballowner = var_04;
	level.codcasterballinitialforcevector = param_00;
	thread func_27B4(param_01);
	thread func_27AF();
	thread func_27B3();
	if(level.gametype == "ball")
	{
		thread scripts\mp\gametypes\ball::func_27B6();
	}

	thread func_27B5(param_01);
}

//Function Number: 51
func_27B5(param_00)
{
	var_01 = self.visuals[0];
	var_02 = self.trigger;
	self.visuals[0] endon("physics_finished");
	self endon("physics_timeout");
	self endon("pickup_object");
	self endon("reset");
	self endon("score_event");
	for(;;)
	{
		var_02 waittill("trigger",var_03);
		if(scripts\mp\_utility::func_9F22(var_03))
		{
			continue;
		}

		if(!isplayer(var_03) && !isagent(var_03))
		{
			continue;
		}

		if(isdefined(param_00) && param_00 == var_03 && var_03 func_D207())
		{
			continue;
		}

		if(self.var_5EED >= gettime())
		{
			continue;
		}

		if(var_01.origin == var_01.var_28AC + (0,0,4000))
		{
			continue;
		}

		if(!func_2776(var_03))
		{
			if(var_03 func_D207())
			{
				continue;
			}

			var_03.var_C087 = gettime() + 500;
			thread func_27B0();
		}
	}
}

//Function Number: 52
func_27B0(param_00)
{
	var_01 = self.visuals[0];
	var_02 = var_01 method_8419(0);
	var_03 = function_026E(var_02);
	if(isdefined(param_00) && param_00)
	{
		var_04 = length(var_03) * 0.4;
		thread func_13B69();
	}
	else
	{
		var_04 = length(var_04) / 10;
	}

	var_05 = vectornormalize(var_03);
	var_05 = (-1,-1,-0.5) * var_05;
	var_01 physicslaunchserver(var_01.origin,(0,0,0));
	var_01 method_851B();
	var_01 physicslaunchserver(var_01.origin,var_05 * var_04);
	var_01.var_CB0B = 1;
}

//Function Number: 53
func_CAFC()
{
	self endon("death");
	for(;;)
	{
		self waittill("projectile_impact",var_00,var_01,var_02,var_03);
		var_04 = level._effect["ball_physics_impact"];
		if(isdefined(var_03) && isdefined(level._effect["ball_physics_impact_" + var_03]))
		{
			var_04 = level._effect["ball_physics_impact_" + var_03];
		}

		if(!scripts\mp\_utility::func_9FB3(level.var_53E1))
		{
			playfx(var_04,var_00,var_01);
		}

		wait(0.3);
	}
}

//Function Number: 54
func_279A(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = param_00 method_8419(0);
	var_0A = function_026E(var_09);
	var_0B = length(var_0A);
	if(isdefined(param_00.var_D4A9) || var_0B < 70)
	{
		return;
	}

	param_00 endon("death");
	param_00.var_D4A9 = 1;
	var_0C = "mp_uplink_ball_bounce";
	param_00 playsound(var_0C);
	var_0D = lookupsoundlength(var_0C);
	wait(0.1);
	param_00.var_D4A9 = undefined;
}

//Function Number: 55
func_27BD(param_00,param_01)
{
	self.var_278C = 0;
	if(scripts\mp\_utility::func_9FB3(level.var_69A1) && scripts\mp\_utility::func_9FB3(param_00))
	{
		func_53D1();
	}

	if(scripts\mp\_utility::func_9FB3(level.var_D6AF))
	{
		if(scripts\mp\_utility::func_9FB3(level.var_27D1))
		{
			level func_12F46("neutral",0,1);
		}
		else
		{
			level func_12F46("neutral",1,1);
		}
	}

	level.codcasterball = undefined;
	level.codcasterballinitialforcevector = undefined;
	level.var_27FC = 1;
	self.var_9398 = 0;
	var_02 = self.visuals[0];
	var_02 physicslaunchserver(var_02.origin,(0,0,0));
	var_02 method_851B();
	if(!scripts\mp\_utility::func_9FB3(level.var_53E1))
	{
		playsoundatpos(var_02.origin,"mp_uplink_ball_out_of_bounds");
		playfx(scripts\common\utility::getfx("ball_teleport"),var_02.origin);
	}

	if(param_01)
	{
		scripts\mp\_utility::func_F79E(2,"free");
	}

	if(isdefined(self.carrier))
	{
		self.carrier scripts\common\utility::func_5127(0.05,::func_D315);
	}

	self.visuals[0] setscriptablepartstate("uplink_drone_hide","show",0);
	thread scripts\mp\_gameobjects::func_E472();
}

//Function Number: 56
func_27A8(param_00)
{
	param_00.var_3AF7 func_27BD(0,1);
}

//Function Number: 57
func_2785(param_00)
{
	self endon("pickup_object");
	scripts\mp\_gameobjects::func_1C7C("none");
	self.var_9F24 = 1;
	wait(param_00);
	self.var_9F24 = 0;
	func_27CE();
	scripts\mp\_gameobjects::func_1C7C("any");
	self notify("ball_ready");
	if(!scripts\mp\_utility::func_9FB3(level.var_53E1))
	{
		playfx(level._effect["ball_download_end"],self.var_4B2C);
		thread func_278D(0,1);
	}

	if(level.gametype == "tdef")
	{
		level func_12F46("neutral",1,1);
		level.var_2800[0] thread func_10DA5();
	}
}

//Function Number: 58
func_136E1(param_00)
{
	self endon("pickup_object");
	self endon("game_ended");
	scripts\mp\_gameobjects::func_1C7C("none");
	if(level.var_27D1 != 0)
	{
		scripts\mp\_hostmigration::func_13708(level.var_27D1);
	}

	if(level.var_11920)
	{
		level scripts\mp\_gamelogic::func_E2FF();
	}

	scripts\mp\_gameobjects::func_F806(param_00.var_28AC,(0,0,0));
	self.visuals[0] setscriptablepartstate("uplink_drone_hide","show",0);
	thread func_2785(0);
	param_00 rotatevelocity((0,720,0),3,0,3);
}

//Function Number: 59
func_10DA5()
{
	self endon("death");
	self endon("reset");
	self endon("pickup_object");
	self notify("hoverAnimStart");
	self endon("hoverAnimStart");
	var_00 = self.visuals[0].origin;
	self.visuals[0] rotateyaw(2000,60,0.2,0.2);
	for(;;)
	{
		self.visuals[0] moveto(var_00 + (0,0,5),1,0.5,0.5);
		wait(1);
		self.visuals[0] moveto(var_00 - (0,0,5),1,0.5,0.5);
		wait(1);
	}
}

//Function Number: 60
func_27B3()
{
	self endon("reset");
	self endon("pickup_object");
	var_00 = self.visuals[0];
	var_01[0] = 200;
	var_01[1] = 200;
	var_01[2] = 1000;
	var_02[0] = 200;
	var_02[1] = 200;
	var_02[2] = 200;
	for(;;)
	{
		for(var_03 = 0;var_03 < 2;var_03++)
		{
			if(var_00.origin[var_03] > level.var_279F[var_03] + var_01[var_03])
			{
				func_27BD(1,1);
				return;
			}

			if(var_00.origin[var_03] < level.var_27A0[var_03] - var_02[var_03])
			{
				func_27BD(1,1);
				return;
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 61
func_27B4(param_00)
{
	self endon("reset");
	self endon("pickup_object");
	self endon("score_event");
	if(!isdefined(level.var_92F7))
	{
		level.var_92F7 = 15;
	}

	var_01 = level.var_92F7;
	var_02 = 10;
	var_03 = 3;
	if(var_01 >= var_02)
	{
		wait(var_03);
		var_01 = var_01 - var_03;
	}

	wait(var_01);
	self notify("physics_timeout");
	func_27BD(1,1);
}

//Function Number: 62
func_27AF()
{
	self.visuals[0] endon("physics_finished");
	self endon("physics_timeout");
	self endon("pickup_object");
	self endon("reset");
	self endon("score_event");
	thread func_27AE();
	for(;;)
	{
		if(self.visuals[0] func_11A43())
		{
			thread func_27B0(1);
		}

		if(!self.visuals[0] scripts\mp\_utility::touchingballallowedtrigger())
		{
			if(self.visuals[0] scripts\mp\_utility::touchingbadtrigger() || self.visuals[0] scripts\mp\_utility::func_11A44())
			{
				func_27BD(0,1);
				return;
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 63
func_11A43()
{
	if(level.nozonetriggers.size > 0)
	{
		foreach(var_01 in level.nozonetriggers)
		{
			if(self istouching(var_01))
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 64
func_13B69()
{
	self.visuals[0] endon("physics_finished");
	self endon("physics_timeout");
	self endon("pickup_object");
	self endon("reset");
	self endon("score_event");
	var_00 = gettime();
	var_01 = var_00 + 500;
	for(;;)
	{
		if(self.visuals[0] func_11A43() && var_01 < var_00)
		{
			func_27BD(1,1);
			return;
		}

		wait(0.05);
		var_00 = gettime();
	}
}

//Function Number: 65
func_27AE()
{
	self endon("pickup_object");
	self endon("reset");
	self endon("score_event");
	var_00 = self.visuals[0];
	var_00 endon("death");
	var_00 waittill("physics_finished");
	if(scripts\mp\_utility::touchingbadtrigger())
	{
		func_27BD(1,1);
	}
}

//Function Number: 66
func_279E()
{
	for(;;)
	{
		var_00 = scripts\common\utility::func_13734("pickup_object","dropped","reset","ball_ready");
		switch(var_00)
		{
			case "pickup_object":
				setomnvar("ui_uplink_ball_carrier",self.carrier getentitynumber());
				setomnvar("ui_uplink_timer_text",1);
				break;
	
			case "dropped":
				setomnvar("ui_uplink_ball_carrier",-2);
				break;
	
			case "reset":
				setomnvar("ui_uplink_ball_carrier",-3);
				setomnvar("ui_uplink_timer_text",2);
				break;
	
			case "ball_ready":
				setomnvar("ui_uplink_timer_text",1);
				setomnvar("ui_uplink_ball_carrier",-1);
				break;
	
			default:
				break;
		}
	}
}

//Function Number: 67
func_277B(param_00)
{
	self endon("death");
	self endon("disconnect");
	param_00 endon("reset");
	var_01 = spawnstruct();
	var_01 endon("timer_done");
	var_01 thread func_11918(1.5);
	param_00 waittill("pickup_object");
	var_01 func_11913();
	if(!isdefined(param_00.carrier) || param_00.carrier.team == self.team)
	{
		return;
	}

	param_00.carrier endon("disconnect");
	var_01 thread func_11918(5);
	param_00.carrier waittill("death",var_02);
	var_01 func_11913();
	if(!isdefined(var_02) || var_02 != self)
	{
		return;
	}

	var_01 thread func_11918(2);
	param_00 waittill("pickup_object");
	var_01 func_11913();
	if(isdefined(param_00.carrier) && param_00.carrier == self)
	{
		thread scripts\mp\_utility::func_83B4("ball_pass_kill");
	}
}

//Function Number: 68
func_11918(param_00)
{
	self endon("cancel_timer");
	wait(param_00);
	self notify("timer_done");
}

//Function Number: 69
func_11913()
{
	self notify("cancel_timer");
}

//Function Number: 70
func_27CE()
{
	scripts\mp\_gameobjects::func_F283("friendly","waypoint_neutral_ball");
	scripts\mp\_gameobjects::func_F283("enemy","waypoint_neutral_ball");
	scripts\mp\_gameobjects::func_F284("friendly","waypoint_neutral_ball");
	scripts\mp\_gameobjects::func_F284("enemy","waypoint_neutral_ball");
}

//Function Number: 71
func_27CD(param_00)
{
	if(level.gametype == "ball")
	{
		var_01 = "waypoint_escort";
	}
	else
	{
		var_01 = "waypoint_defend_round";
	}

	scripts\mp\_gameobjects::func_F283("friendly",var_01);
	scripts\mp\_gameobjects::func_F283("enemy","waypoint_capture_kill_round");
	scripts\mp\_gameobjects::func_F284("friendly",var_01);
	scripts\mp\_gameobjects::func_F284("enemy","waypoint_capture_kill_round");
}

//Function Number: 72
func_27CC()
{
	if(level.gametype == "ball")
	{
		var_00 = "waypoint_ball_download";
	}
	else
	{
		var_00 = "waypoint_reset_marker";
	}

	scripts\mp\_gameobjects::func_F283("friendly",var_00);
	scripts\mp\_gameobjects::func_F283("enemy",var_00);
	scripts\mp\_gameobjects::func_F284("friendly",var_00);
	scripts\mp\_gameobjects::func_F284("enemy",var_00);
}

//Function Number: 73
func_27CF()
{
	scripts\mp\_gameobjects::func_F283("friendly","waypoint_ball_upload");
	scripts\mp\_gameobjects::func_F283("enemy","waypoint_ball_upload");
	scripts\mp\_gameobjects::func_F284("friendly","waypoint_ball_upload");
	scripts\mp\_gameobjects::func_F284("enemy","waypoint_ball_upload");
}

//Function Number: 74
func_27BC()
{
	if(isdefined(self.visuals[0].var_C3B7))
	{
		self.visuals[0] method_82C7(self.visuals[0].var_C3B7);
		self.visuals[0].var_C3B7 = undefined;
	}
}

//Function Number: 75
func_2783()
{
	self.visuals[0] dontinterpolate();
	self.var_278C = 0;
}

//Function Number: 76
func_2772(param_00)
{
	foreach(var_02 in self.visuals)
	{
		var_02.var_28AC = param_00.origin;
	}

	self.trigger.var_28AC = param_00.origin;
	self.var_4BBD = param_00;
	param_00.var_93A8 = 1;
}

//Function Number: 77
func_2780()
{
	if(isdefined(self.var_A63A))
	{
		self.var_A63A delete();
	}

	self.var_A63A = spawn("script_model",self.visuals[0].origin);
	self.var_A63A linkto(self.visuals[0]);
	self.var_A63A method_82C7(0);
	self.var_A63A setscriptmoverkillcam("explosive");
}

//Function Number: 78
func_97D6()
{
	level.var_2803 = level.var_D6B0;
	level.var_2804 = 1;
	level.var_2805 = 0;
	if(isdefined(level.var_D6AF) && level.var_D6AF != 0)
	{
		setomnvar("ui_uplink_timer_show",1);
		setomnvar("ui_uplink_timer_text",1);
		thread func_49D6();
		return;
	}

	setomnvar("ui_uplink_timer_show",0);
}

//Function Number: 79
func_49D6()
{
	level endon("game_ended");
	scripts\mp\_utility::func_7670("prematch_done");
	func_12F46("neutral",1,1);
}

//Function Number: 80
func_12F46(param_00,param_01,param_02,param_03)
{
	if(!scripts\mp\_utility::func_9FB3(level.var_D6AF))
	{
		return;
	}

	var_04 = undefined;
	var_05 = 1000 * level.var_D6B0;
	if(scripts\mp\_utility::func_9FB3(param_02))
	{
		if(scripts\mp\_utility::func_9FB3(level.var_27D1) && !scripts\mp\_utility::func_9FB3(level.var_27FC))
		{
			var_05 = 1000 * level.var_27D1;
		}
	}

	if(scripts\mp\_utility::func_9FB3(param_02) || scripts\mp\_utility::func_9FB3(param_03))
	{
		level.var_2803 = level.var_D6B0;
		level.ballendtime = int(gettime() + var_05);
	}
	else
	{
		level.ballendtime = int(gettime() + 1000 * level.var_2803);
	}

	setomnvar("ui_hardpoint_timer",level.ballendtime);
	if(var_05 > 0 && scripts\mp\_utility::func_9FB3(param_03) || !param_01 && level.var_2804)
	{
		level.var_276E thread func_27FD(param_00,var_04);
	}

	if(level.var_2803 > 1)
	{
		if(param_01)
		{
			level func_C9CD();
		}
	}
}

//Function Number: 81
func_27FD(param_00,param_01)
{
	level endon("game_ended");
	level endon("reset");
	level endon("pause_ball_timer");
	level notify("ballRunTimer");
	level endon("ballRunTimer");
	level.var_2804 = 0;
	func_2806(param_00,param_01);
	if(isdefined(level.var_276E) && isdefined(level.var_276E.carrier))
	{
		self.carrier scripts\mp\_missions::func_27FA();
	}

	if(!scripts\mp\_utility::func_9FB3(level.var_27FC))
	{
		scripts\mp\_gameobjects::func_1C7C("none");
		func_27C1(1,self.trigger.origin,1);
		func_27BD(1,1);
	}
}

//Function Number: 82
func_2806(param_00,param_01)
{
	level endon("game_ended");
	level endon("pause_ball_timer");
	var_02 = scripts\common\utility::func_116D7(isdefined(param_01),param_01,int(level.var_2803 * 1000 + gettime()));
	level func_E2FD(param_01);
	thread func_13B80();
	level thread func_89B4(var_02);
	func_136A0(level.var_2803);
}

//Function Number: 83
func_136A0(param_00)
{
	level endon("game_ended");
	level endon("pause_ball_timer");
	if(param_00 == 0)
	{
		return;
	}

	var_01 = gettime();
	var_02 = gettime() + param_00 * 1000;
	while(gettime() < var_02)
	{
		func_13829(var_02 - gettime() / 1000);
		while(isdefined(level.var_90A9))
		{
			var_02 = var_02 + 1000;
			function_01AF(int(var_02));
			wait(1);
		}
	}

	while(isdefined(level.var_90A9))
	{
		var_02 = var_02 + 1000;
		function_01AF(int(var_02));
		wait(1);
	}

	return gettime() - var_01;
}

//Function Number: 84
func_13829(param_00)
{
	level endon("game_ended");
	level endon("pause_ball_timer");
	if(isdefined(level.var_90A9))
	{
		return;
	}

	level endon("host_migration_begin");
	wait(param_00);
}

//Function Number: 85
func_89B4(param_00)
{
	level endon("game_ended");
	level endon("disconnect");
	level waittill("host_migration_begin");
	setomnvar("ui_uplink_timer_stopped",1);
	var_01 = scripts\mp\_hostmigration::func_13834();
	if(!level.var_2805)
	{
		setomnvar("ui_uplink_timer_stopped",0);
	}

	if(var_01 > 0)
	{
		setomnvar("ui_hardpoint_timer",level.ballendtime + var_01);
		return;
	}

	setomnvar("ui_hardpoint_timer",level.ballendtime);
}

//Function Number: 86
func_13B80()
{
	level endon("game_ended");
	level notify("watchResetSoon");
	level endon("watchResetSoon");
	var_00 = 0;
	var_01 = undefined;
	while(level.var_2803 > 0 && !level.var_2804)
	{
		var_02 = gettime();
		if(!var_00 && level.var_2803 < 10)
		{
			level scripts\mp\_utility::func_10E60("drone_reset_soon","allies");
			level scripts\mp\_utility::func_10E60("drone_reset_soon","axis");
			var_00 = 1;
		}

		if(isdefined(level.var_2800[0].carrier) && level.var_2803 < 5)
		{
			if(!isdefined(var_01) || var_02 > var_01 + 1000)
			{
				var_01 = var_02;
				level.var_2800[0].carrier playsoundtoplayer("mp_cranked_countdown",level.var_2800[0].carrier);
			}
		}

		var_03 = 0.05;
		wait(var_03);
		level.var_2803 = level.var_2803 - var_03;
	}

	if(level.var_2804)
	{
		level notify("pause_ball_timer");
	}
}

//Function Number: 87
func_12E62(param_00)
{
	var_01 = level.var_2804 || isdefined(level.var_90A9);
	if(!scripts\mp\_utility::func_766C("prematch_done"))
	{
		var_01 = 0;
	}

	if(!level.var_2805 && var_01)
	{
		level.var_2805 = 1;
		setomnvar("ui_uplink_timer_stopped",1);
		return;
	}

	if(level.var_2805 && !var_01)
	{
		level.var_2805 = 0;
		setomnvar("ui_uplink_timer_stopped",0);
	}
}

//Function Number: 88
func_C9CD()
{
	level.var_2804 = 1;
	func_12E62();
}

//Function Number: 89
func_E2FD(param_00)
{
	level.var_2804 = 0;
	func_12E62(param_00);
}

//Function Number: 90
func_27BA()
{
	if(!scripts\mp\_utility::func_9FB3(level.var_53E1))
	{
		foreach(var_01 in level.var_2800)
		{
			var_01 func_278E(self);
		}
	}
}

//Function Number: 91
func_278E(param_00)
{
	if(func_278C())
	{
		self.visuals[0] setscriptablepartstate("uplink_drone_idle","normal",0);
		self.visuals[0] setscriptablepartstate("uplink_drone_tail","normal",0);
	}
}

//Function Number: 92
func_278D(param_00,param_01)
{
	self endon("reset");
	self endon("pickup_object");
	if(scripts\mp\_utility::func_9FB3(param_00))
	{
		wait(0.2);
	}
	else
	{
		wait(0.05);
	}

	if(!func_278C())
	{
		self.visuals[0] setscriptablepartstate("uplink_drone_idle","normal",0);
		self.visuals[0] setscriptablepartstate("uplink_drone_tail","normal",0);
		self.var_278C = 1;
	}
}

//Function Number: 93
func_278C()
{
	return isdefined(self.var_278C) && self.var_278C;
}

//Function Number: 94
func_278F()
{
	if(func_278C())
	{
		self.visuals[0] func_10FF6();
	}

	self.var_278C = 0;
}

//Function Number: 95
func_10FF6()
{
	self setscriptablepartstate("uplink_drone_idle","off",0);
	self setscriptablepartstate("uplink_drone_tail","off",0);
}

//Function Number: 96
func_2784(param_00,param_01)
{
	scripts\common\utility::waittill_notify_or_timeout("pickup_object",param_01);
	level.var_EC39 = 0;
	level notify("goal_ready");
}

//Function Number: 97
func_BCA9()
{
	level notify("practice");
	level endon("practice");
	level endon("game_ended");
	wait(5);
	for(;;)
	{
		self waittill("call_ball");
		if(!isdefined(level.var_2800[0].carrier))
		{
			level.var_2800[0].visuals[0] physicslaunchserver(level.var_2800[0].visuals[0].origin,(0,0,0));
			level.var_2800[0].visuals[0] method_851B();
			while(!isdefined(level.var_2800[0].carrier))
			{
				var_00 = 40;
				switch(self getstance())
				{
					case "crouch":
						var_00 = 30;
						break;
	
					case "prone":
						var_00 = 15;
						break;
				}

				level.var_2800[0].visuals[0] moveto(self.origin + (0,0,var_00),0.3,0.15,0.1);
				wait(0.1);
			}
		}

		wait(1);
	}
}

//Function Number: 98
func_D7A7()
{
	level endon("game_ended");
	self endon("disconnect");
	var_00 = 1;
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

		var_00 = 0;
		if(var_00)
		{
			wait(20);
		}
		else
		{
			wait(2);
		}

		thread givepracticemessage();
	}
}

//Function Number: 99
givepracticemessage()
{
	self notify("practiceMessage");
	self endon("practiceMessage");
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	if(scripts\common\utility::func_9C70())
	{
		self notifyonplayercommand("call_ball","+actionslot 3");
		self iprintlnbold(&"PLATFORM_UPLINK_PRACTICE_SLOT3");
	}
	else
	{
		self notifyonplayercommand("call_ball","+actionslot 7");
		self iprintlnbold(&"PLATFORM_UPLINK_PRACTICE_SLOT7");
	}

	level.var_2800[0] waittill("score_event");
	wait(5);
	thread givepracticemessage();
}

//Function Number: 100
func_10435(param_00)
{
	if(!isdefined(param_00) || param_00.size == 0)
	{
		return undefined;
	}

	var_01 = 1;
	for(var_02 = param_00.size;var_01;var_02--)
	{
		var_01 = 0;
		for(var_03 = 0;var_03 < var_02 - 1;var_03++)
		{
			if(func_4460(param_00[var_03],param_00[var_03 + 1]))
			{
				var_04 = param_00[var_03];
				param_00[var_03] = param_00[var_03 + 1];
				param_00[var_03 + 1] = var_04;
				var_01 = 1;
			}
		}
	}

	return param_00;
}

//Function Number: 101
func_4460(param_00,param_01)
{
	var_02 = int(param_00.script_label);
	var_03 = int(param_01.script_label);
	if(!isdefined(var_02) && !isdefined(var_03))
	{
		return 0;
	}

	if(!isdefined(var_02) && isdefined(var_03))
	{
		return 1;
	}

	if(isdefined(var_02) && !isdefined(var_03))
	{
		return 0;
	}

	if(var_02 > var_03)
	{
		return 1;
	}

	return 0;
}

//Function Number: 102
getpasserorigin()
{
	var_00 = 0;
	switch(self getstance())
	{
		case "crouch":
			var_00 = 5;
			break;

		case "prone":
			var_00 = 10;
			break;
	}

	var_01 = self getworldupreferenceangles();
	var_02 = anglestoup(var_01);
	var_03 = self geteye() + var_02 * var_00;
	return var_03;
}

//Function Number: 103
getpasserdirection()
{
	var_00 = self getplayerangles();
	var_01 = anglestoforward(var_00);
	return var_01;
}

//Function Number: 104
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

//Function Number: 105
gettargetoffset()
{
	var_00 = gettargetorigin();
	return (0,0,var_00[2] - self.origin[2]);
}

//Function Number: 106
hideballsongameended()
{
	level waittill("bro_shot_start");
	foreach(var_01 in level.var_2800)
	{
		var_01.visuals[0] setscriptablepartstate("uplink_drone_hide","hide",0);
		var_01.visuals[0] setscriptablepartstate("uplink_drone_idle","off",0);
		var_01.visuals[0] setscriptablepartstate("uplink_drone_tail","off",0);
	}
}