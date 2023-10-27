/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\gametypes\obj_bombzone.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 36
 * Decompile Time: 1920 ms
 * Timestamp: 10/27/2023 12:12:52 AM
*******************************************************************/

//Function Number: 1
func_2C78(param_00)
{
	var_01 = undefined;
	var_02 = undefined;
	if(isdefined(level.var_4B29))
	{
		level.var_4B29 scripts\mp\_gameobjects::func_51DA();
	}

	var_03 = level.var_C2A8[param_00];
	if(isdefined(var_03.var_C732))
	{
		var_03.origin = var_03.var_C732;
	}
	else
	{
		var_03.var_C732 = var_03.origin;
	}

	var_04 = getentarray(var_03.target,"targetname");
	if(level.gametype == "dd")
	{
		var_02 = var_03.script_label;
		var_05 = getent("dd_bombzone_clip" + var_02,"targetname");
		if(scripts\mp\_utility::func_9900())
		{
			if(var_02 == "_a" || var_02 == "_b")
			{
				var_03 delete();
				var_04[0] delete();
				var_05 delete();
				return;
			}

			var_01 = scripts\mp\_gameobjects::func_4A2E("neutral",var_03,var_04,(0,0,64));
			var_01 scripts\mp\_gameobjects::func_1CAF("any");
			var_01.trigger.script_label = "_a";
		}
		else
		{
			if(var_02 == "_c")
			{
				var_03 delete();
				var_04[0] delete();
				var_05 delete();
				return;
			}

			if(level.var_B335 == "mp_desert" && var_02 == "_b")
			{
				var_03.origin = var_03.origin + (0,0,8);
				var_04[0].origin = var_04[0].origin + (0,0,8);
				var_05.origin = var_05.origin + (0,0,8);
			}
		}
	}
	else
	{
		var_03 = postshipmodifiedbombzones(var_04,var_03);
	}

	if(!isdefined(var_01))
	{
		var_01 = scripts\mp\_gameobjects::func_4A2E(game["defenders"],var_03,var_04,(0,0,64));
		var_01 scripts\mp\_gameobjects::func_1CAF("enemy");
	}

	var_01.var_92B8 = "bomb_zone";
	var_01.trigger method_8360();
	var_01 scripts\mp\_gameobjects::func_FB08(level.var_CC52);
	var_01 scripts\mp\_gameobjects::func_FB14(0);
	var_01 scripts\mp\_gameobjects::func_FB07(&"MP_PLANTING_EXPLOSIVE");
	var_01 scripts\mp\_gameobjects::func_FB06(&"PLATFORM_HOLD_TO_PLANT_EXPLOSIVES");
	if(!level.var_BDC1)
	{
		var_01 scripts\mp\_gameobjects::func_F76A(level.var_F013);
	}

	var_02 = var_01 scripts\mp\_gameobjects::getlabel();
	if(level.gametype == "dd" && scripts\mp\_utility::func_9900())
	{
		var_02 = "_a";
		var_01 scripts\mp\_gameobjects::func_F283("friendly","waypoint_target" + var_02);
		var_01 scripts\mp\_gameobjects::func_F284("friendly","waypoint_target" + var_02);
		var_01 scripts\mp\_gameobjects::func_F283("enemy","waypoint_target" + var_02);
		var_01 scripts\mp\_gameobjects::func_F284("enemy","waypoint_target" + var_02);
	}
	else
	{
		var_01 scripts\mp\_gameobjects::func_F283("friendly","waypoint_defend" + var_02);
		var_01 scripts\mp\_gameobjects::func_F284("friendly","waypoint_defend" + var_02);
		var_01 scripts\mp\_gameobjects::func_F283("enemy","waypoint_target" + var_02);
		var_01 scripts\mp\_gameobjects::func_F284("enemy","waypoint_target" + var_02);
	}

	var_01.label = var_02;
	var_01 scripts\mp\_gameobjects::setvisibleteam("any");
	var_01.var_C4CB = ::func_2C71;
	var_01.var_C50D = ::func_2C74;
	var_01.var_C5BB = ::func_2C76;
	var_01.var_C4D4 = ::func_2C73;
	var_01.var_130F8 = "briefcase_bomb_mp";
	var_01.var_2C5C = 0;
	var_01.var_2C58 = undefined;
	for(var_06 = 0;var_06 < var_04.size;var_06++)
	{
		if(isdefined(var_04[var_06].var_ED84))
		{
			var_01.var_69B6 = var_04[var_06].var_ED84;
			var_04[var_06] thread func_FAC9(var_01);
			break;
		}
	}

	var_01.var_2C4B = getent(var_04[0].target,"targetname");
	var_01.var_2C4B.origin = var_01.var_2C4B.origin + (0,0,-10000);
	var_01.var_2C4B.label = var_02;
	var_01.noweapondropallowedtrigger = spawn("trigger_radius",var_01.trigger.origin,0,140,100);
	return var_01;
}

//Function Number: 2
func_FAC9(param_00)
{
	var_01 = spawn("script_origin",self.origin);
	var_01.angles = self.angles;
	var_01 rotateyaw(-45,0.05);
	wait(0.05);
	var_02 = undefined;
	var_03 = self.origin + (0,0,45);
	var_04 = self.origin + anglestoforward(var_01.angles) * 100 + (0,0,128);
	var_05 = ["physicscontents_clipshot","physicscontents_corpseclipshot","physicscontents_missileclip","physicscontents_solid","physicscontents_vehicle"];
	var_06 = physics_createcontents(var_05);
	var_07 = scripts\common\trace::func_DCED(var_03,var_04,self,var_06);
	var_02 = var_07["position"];
	if(scripts\mp\_utility::func_7F8B() == "mp_skyway" && param_00.label == "_b")
	{
		var_02 = (326,595,85);
	}

	self.var_A63A = spawn("script_model",var_02);
	self.var_A63A setscriptmoverkillcam("explosive");
	param_00.var_A63C = self.var_A63A getentitynumber();
	var_01 delete();
}

//Function Number: 3
func_1C8E(param_00)
{
	scripts\common\utility::func_1C53(param_00);
	scripts\common\utility::allow_jump(param_00);
	scripts\mp\_utility::func_1C47(param_00);
	if(param_00)
	{
		scripts\common\utility::waittill_any_timeout_1(0.8,"bomb_allow_offhands");
	}

	scripts\common\utility::func_1C58(param_00);
}

//Function Number: 4
func_2C71(param_00)
{
	param_00 thread func_1C8E(0);
	if(scripts\mp\_gameobjects::isfriendlyteam(param_00.pers["team"]))
	{
		if(getdvarint("com_codcasterEnabled",0) == 1)
		{
			param_00 method_80C1(1);
		}

		param_00 scripts\mp\_utility::func_C131("defuse");
		param_00 notify("super_obj_drain");
		param_00.var_9DBC = 1;
		setomnvar("ui_bomb_defuser",param_00 getentitynumber());
		scripts\mp\_utility::func_F79E(4,param_00.team,param_00 getentitynumber());
		if(isdefined(level.var_F014))
		{
			level.var_F014 hide();
		}
		else if(isdefined(level.var_4DA4[self.label]))
		{
			level.var_4DA4[self.label] hide();
		}

		param_00 thread func_10DD0("briefcase_bomb_defuse_mp","weap_suitcase_defuse_button");
		return;
	}

	var_01 = 2;
	if(self.label == "_a")
	{
		var_01 = 1;
	}

	scripts\mp\_utility::func_F79E(14,param_00.team,param_00 getentitynumber(),var_01);
	param_00 scripts\mp\_utility::func_C131("plant");
	param_00 notify("super_obj_drain");
	param_00.var_9EE6 = 1;
	param_00.var_2C5E = self.var_130F8;
	param_00 thread func_10DD0("briefcase_bomb_mp","weap_suitcase_raise_button");
}

//Function Number: 5
func_2C74(param_00,param_01,param_02)
{
	setomnvar("ui_bomb_defuser",-1);
	if(!isdefined(param_01))
	{
		return;
	}

	param_01 thread func_1C8E(1);
	param_01.var_2C5E = undefined;
	if(isalive(param_01))
	{
		param_01.var_9DBC = 0;
		param_01.var_9EE6 = 0;
	}

	if(isplayer(param_01))
	{
		param_01 setclientomnvar("ui_objective_state",0);
		param_01.var_12B1A = undefined;
	}

	if(scripts\mp\_gameobjects::isfriendlyteam(param_01.pers["team"]))
	{
		if(getdvarint("com_codcasterEnabled",0) == 1)
		{
			param_01 method_80C1(0);
		}

		if(isdefined(level.var_F014) && !param_02)
		{
			level.var_F014 show();
			return;
		}

		if(isdefined(level.var_4DA4))
		{
			if(isdefined(level.var_4DA4[self.label]) && !param_02)
			{
				level.var_4DA4[self.label] show();
				return;
			}

			return;
		}
	}
}

//Function Number: 6
func_10DD0(param_00,param_01)
{
	self endon("death");
	self endon("stopNpcBombSound");
	if(scripts\mp\_utility::func_9D46() || scripts\mp\_utility::func_9FB3(level.var_101F7) || scripts\mp\_utility::_hasperk("specialty_engineer"))
	{
		return;
	}

	var_02 = "";
	while(var_02 != param_00)
	{
		self waittill("weapon_change",var_02);
	}

	self playsoundtoteam(param_01,self.team,self);
	var_03 = scripts\mp\_utility::getotherteam(self.team);
	self playsoundtoteam(param_01,var_03);
	self waittill("weapon_change");
	self notify("stopNpcBombSound");
}

//Function Number: 7
func_2C73(param_00)
{
}

//Function Number: 8
func_2C76(param_00)
{
	if((scripts\mp\_utility::func_9900() && self.var_2C5C == 0) || !scripts\mp\_gameobjects::isfriendlyteam(param_00.pers["team"]))
	{
		level thread func_2C72(self,param_00);
		param_00 playsound("mp_bomb_plant");
		param_00 notify("bomb_planted");
		param_00 setclientomnvar("ui_objective_progress",0.01);
		var_01 = 2;
		if(self.label == "_a")
		{
			var_01 = 1;
		}

		scripts\mp\_utility::func_F79E(3,param_00.team,param_00 getentitynumber(),var_01);
		param_00 scripts\mp\_utility::func_93DF("plants",1);
		param_00 scripts\mp\_persistence::func_10E56("round","plants",param_00.pers["plants"]);
		param_00 scripts\mp\_utility::func_F6FA(param_00.pers["plants"]);
		if(isdefined(level.var_F004) && isdefined(level.var_F004[param_00.team]))
		{
			param_00 thread func_E0D7();
		}

		if(scripts\mp\_utility::func_9900())
		{
			scripts\mp\_utility::func_10E60("enemy_bomb_planted",level.var_C74B[param_00.team],1);
		}
		else
		{
			scripts\mp\_utility::func_10E60("enemy_bomb" + self.label,level.var_C74B[param_00.team],1);
		}

		scripts\mp\_utility::func_10E60("bomb_planted",param_00.team,1);
		level thread scripts\mp\_utility::func_115DE("callout_bombplanted",param_00);
		level.var_2C5B = param_00;
		param_00 thread scripts\mp\_utility::func_83B4("plant");
		param_00.var_2C5D = gettime();
		if(isplayer(param_00))
		{
			param_00 thread scripts\mp\_matchdata::func_AFBA("plant",param_00.origin);
		}
	}
}

//Function Number: 9
func_2C75(param_00)
{
	var_01 = 0;
	param_00 setclientomnvar("ui_objective_progress",0.01);
	foreach(var_03 in level.var_2C7A)
	{
		if(var_03.label == self.label)
		{
			param_00 notify("bomb_defused" + var_03.label);
			level thread func_2C4A(var_03);
			break;
		}
	}

	scripts\mp\_gameobjects::disableobject();
	if(!level.var_8B38)
	{
		iprintln(&"MP_EXPLOSIVES_DEFUSED_BY",param_00);
	}

	scripts\mp\_utility::func_10E60("enemy_bomb_defused",level.var_C74B[param_00.team],1);
	scripts\mp\_utility::func_10E60("bomb_defused",param_00.team,1);
	level thread scripts\mp\_utility::func_115DE("callout_bombdefused",param_00);
	var_05 = "ninja_defuse";
	if(scripts\mp\_utility::func_7ECE() >= 1)
	{
		var_06 = scripts\mp\_utility::func_808A();
		if(var_06.size == 1 && var_06[0] == param_00)
		{
			param_00 thread scripts\mp\_awards::func_8380("mode_sd_last_defuse");
			var_01 = 1;
		}
	}

	if(!var_01)
	{
		param_00 thread scripts\mp\_awards::func_8380("mode_sd_defuse");
	}

	param_00 scripts\mp\_utility::func_93DF("defuses",1);
	param_00 scripts\mp\_persistence::func_10E56("round","defuses",param_00.pers["defuses"]);
	if(level.gametype != "sr")
	{
		param_00 scripts\mp\_utility::func_F6FB(param_00.pers["defuses"]);
	}

	if(isplayer(param_00))
	{
		param_00 thread scripts\mp\_matchdata::func_AFBA("defuse",param_00.origin);
	}
}

//Function Number: 10
func_2C72(param_00,param_01)
{
	level notify("bomb_planted",param_00);
	var_02 = param_01.team;
	level.var_2C4A = 0;
	param_00.var_2C4A = 0;
	if(level.gametype == "dd")
	{
		scripts\mp\_gamelogic::func_C9D6();
		level.var_1190A = gettime();
	}

	level.var_2C5C = 1;
	level.var_2C64 = level.var_2C64 + 1;
	level.var_118FA = 1;
	level.var_50A7 = int(gettime() + level.var_2C6C * 1000);
	if(param_00.label == "_a")
	{
		level.var_209F = 1;
	}
	else
	{
		level.var_2F35 = 1;
	}

	func_F66F(param_01.team);
	level.var_52D9 = param_00;
	level.var_52D9.var_2C5C = 1;
	if(level.gametype != "dd")
	{
		param_01 setclientomnvar("ui_carrying_bomb",0);
		setomnvar("ui_bomb_carrier",-1);
		function_01AF(level.var_50A7);
	}

	param_00.visuals[0] thread scripts\mp\_gamelogic::func_D54F();
	level.var_118A0 = param_00.visuals[0];
	if(!level.var_BDC1)
	{
		level.var_F013 scripts\mp\_gameobjects::func_1C7C("none");
		level.var_F013 scripts\mp\_gameobjects::setvisibleteam("none");
		level.var_F013 scripts\mp\_gameobjects::func_F6D8();
		level.var_F014 = level.var_F013.visuals[0];
		level.var_F014 method_8588();
	}
	else if(level.gametype == "dd")
	{
		level.var_4DA4[param_00.label] = spawn("script_model",param_01.origin);
		level.var_4DA4[param_00.label].angles = param_01.angles;
		level.var_4DA4[param_00.label] setmodel("suitcase_bomb_iw7_wm");
		level.var_4DA4[param_00.label] method_8588();
	}
	else
	{
		level.var_F014 = spawn("script_model",param_01.origin);
		level.var_F014.angles = param_01.angles;
		level.var_F014 setmodel("suitcase_bomb_iw7_wm");
		level.var_F014 method_8588();
	}

	if(level.gametype != "dd")
	{
		param_00 scripts\mp\_gameobjects::func_1CAF("none");
		param_00 scripts\mp\_gameobjects::setvisibleteam("none");
	}

	var_03 = param_00 scripts\mp\_gameobjects::getlabel();
	var_04 = [];
	if(level.gametype == "dd")
	{
		var_05 = param_00.trigger;
		var_05.origin = param_00.visuals[0].origin;
		var_06 = level.var_C74B[param_01.team];
		var_07 = param_00;
	}
	else
	{
		var_05 = var_03.var_2C4B;
		var_07.origin = level.var_F014.origin;
		var_06 = game["defenders"];
		var_07 = scripts\mp\_gameobjects::func_4A2E(var_07,var_06,var_05,(0,0,32));
	}

	var_07.var_92B8 = "defuse_object";
	var_07.trigger method_8360();
	var_07 scripts\mp\_gameobjects::func_1CAF("friendly");
	if(scripts\mp\_utility::func_9900())
	{
		param_00 scripts\mp\_gameobjects::func_F7D4(level.var_C74B[param_01.team]);
	}

	var_07 scripts\mp\_gameobjects::func_FB08(level.var_50AB);
	var_07 scripts\mp\_gameobjects::func_FB14(0);
	var_07 scripts\mp\_gameobjects::func_FB07(&"MP_DEFUSING_EXPLOSIVE");
	var_07 scripts\mp\_gameobjects::func_FB06(&"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES");
	var_07 scripts\mp\_gameobjects::setvisibleteam("any");
	var_07 scripts\mp\_gameobjects::func_F283("friendly","waypoint_defuse" + var_03);
	var_07 scripts\mp\_gameobjects::func_F283("enemy","waypoint_defend" + var_03);
	var_07 scripts\mp\_gameobjects::func_F284("friendly","waypoint_defuse" + var_03);
	var_07 scripts\mp\_gameobjects::func_F284("enemy","waypoint_defend" + var_03);
	var_07.label = var_03;
	var_07.var_C4CB = ::func_2C71;
	var_07.var_C50D = ::func_2C74;
	var_07.var_C5BB = ::func_2C75;
	var_07.var_130F8 = "briefcase_bomb_mp";
	func_2C6D(param_00);
	param_00.visuals[0] scripts\mp\_gamelogic::func_11094();
	if(level.var_7669)
	{
		return;
	}
	else if((level.gametype == "sd" && level.var_2C4A) || level.gametype == "sr" && level.var_2C4A)
	{
		var_07 scripts\mp\_gameobjects::func_51DA();
		return;
	}

	if(level.gametype == "dd")
	{
		if(param_00.var_2C4A)
		{
			param_00.var_2C5C = 0;
			param_00 thread scripts\mp\gametypes\dd::func_2C59(param_01,"defused");
			param_00.var_C5BB = ::func_2C76;
			level.var_4DA4[param_00.label] delete();
			return;
		}
		else
		{
			level.var_2C58 = level.var_2C58 + 1;
			param_00 thread scripts\mp\gametypes\dd::func_2C59(param_01,"explode",var_02);
		}
	}
	else
	{
		level.var_2C58 = level.var_2C58 + 1;
	}

	level notify("bomb_exploded" + param_00.label);
	param_01 thread scripts\mp\_awards::func_8380("mode_sd_detonate");
	if(isdefined(level.var_F007))
	{
		level thread [[ level.var_F007 ]]();
	}

	if(level.gametype == "dd")
	{
		var_08 = level.var_4DA4[param_00.label].origin;
		level.var_4DA4[param_00.label] delete();
	}
	else
	{
		var_08 = level.var_F014.origin;
		level.var_F014 delete();
	}

	if(isdefined(param_01))
	{
		param_00.visuals[0] radiusdamage(var_08,512,200,20,param_01,"MOD_EXPLOSIVE","bomb_site_mp");
		param_01 scripts\mp\_utility::func_93DF("destructions",1);
		param_01 scripts\mp\_persistence::func_10E56("round","destructions",param_01.pers["destructions"]);
	}
	else
	{
		param_00.visuals[0] radiusdamage(var_08,512,200,20,undefined,"MOD_EXPLOSIVE","bomb_site_mp");
	}

	var_09 = randomfloat(360);
	if(isdefined(param_00.trigger.var_5FDF))
	{
		var_0A = param_00.trigger.var_5FDF;
	}
	else
	{
		var_0A = "bomb_explosion";
	}

	var_0B = var_08 + (0,0,50);
	var_0C = spawnfx(level._effect[var_0A],var_0B,(0,0,1),(cos(var_09),sin(var_09),0));
	triggerfx(var_0C);
	physicsexplosionsphere(var_0B,200,100,3);
	scripts\mp\_shellshock::func_13B9("grenade_rumble",var_08);
	scripts\mp\_shellshock::func_1245(0.75,2,var_08,2000);
	thread scripts\mp\_utility::func_D52A("exp_suitcase_bomb_main",var_08);
	if(isdefined(param_00.var_69B6))
	{
		scripts\common\utility::exploder(param_00.var_69B6);
	}

	var_07 scripts\mp\_gameobjects::disableobject();
	if(isdefined(level.var_C561))
	{
		[[ level.var_C561 ]]("bombzone",self.label,param_01,game["attackers"],undefined);
	}
}

//Function Number: 11
func_98A9(param_00)
{
	var_01 = undefined;
	var_02 = getentarray("sd_bombcam_start","targetname");
	foreach(var_04 in var_02)
	{
		if(var_04.script_label == param_00.label)
		{
			var_01 = var_04;
			break;
		}
	}

	var_06 = [];
	if(isdefined(var_01) && isdefined(var_01.target))
	{
		var_07 = getent(var_01.target,"targetname");
		while(isdefined(var_07))
		{
			var_06[var_06.size] = var_07;
			if(isdefined(var_07.target))
			{
				var_07 = getent(var_07.target,"targetname");
				continue;
			}

			break;
		}
	}

	if(isdefined(var_01) && var_06.size)
	{
		var_08 = spawn("script_model",var_01.origin);
		var_08.origin = var_01.origin;
		var_08.angles = var_01.angles;
		var_08.var_C94F = var_06;
		var_08 setmodel("tag_origin");
		var_08 hide();
		return var_08;
	}

	return undefined;
}

//Function Number: 12
func_E882()
{
	level notify("objective_cam");
	foreach(var_01 in level.players)
	{
		if(!isai(var_01))
		{
			var_01 scripts\mp\_utility::func_7385(1);
			var_01 visionsetnakedforplayer("black_bw",0.5);
		}
	}

	wait(0.5);
	foreach(var_01 in level.players)
	{
		if(!isai(var_01))
		{
			if(isdefined(var_01.var_55D9))
			{
				var_01 scripts\mp\_utility::func_FB09("objective_cam");
				var_01 scripts\common\utility::allow_weapon(0);
			}

			var_01 playerlinkweaponviewtodelta(self,"tag_player",1,180,180,180,180,1);
			var_01 scripts\mp\_utility::func_7385(1);
			var_01 setplayerangles(self.angles);
			var_01 visionsetnakedforplayer("",0.5);
		}
	}

	for(var_05 = 0;var_05 < self.var_C94F.size;var_05++)
	{
		var_06 = 0;
		if(var_05 == 0)
		{
			var_06 = 5 / self.var_C94F.size / 2;
		}

		var_07 = 0;
		if(var_05 == self.var_C94F.size - 1)
		{
			var_07 = 5 / self.var_C94F.size / 2;
		}

		self moveto(self.var_C94F[var_05].origin,5 / self.var_C94F.size,var_06,var_07);
		self rotateto(self.var_C94F[var_05].angles,5 / self.var_C94F.size,var_06,var_07);
		wait(5 / self.var_C94F.size);
	}
}

//Function Number: 13
func_2C6D(param_00)
{
	level endon("game_ended");
	level endon("bomb_defused" + param_00.label);
	var_01 = int(level.var_2C6C * 1000 + gettime());
	setomnvar("ui_bomb_timer_endtime" + param_00.label,var_01);
	level thread func_89B4(var_01,param_00);
	scripts\mp\_hostmigration::func_13707(level.var_2C6C);
}

//Function Number: 14
func_89B4(param_00,param_01)
{
	level endon("game_ended");
	level endon("bomb_defused" + param_01.label);
	level endon("game_ended");
	level endon("disconnect");
	level waittill("host_migration_begin");
	setomnvar("ui_bomb_timer_endtime" + param_01.label,0);
	var_02 = scripts\mp\_hostmigration::func_13834();
	if(var_02 > 0)
	{
		setomnvar("ui_bomb_timer_endtime" + param_01.label,param_00 + var_02);
	}
}

//Function Number: 15
func_2C4A(param_00)
{
	if(level.gametype != "dd")
	{
		level.var_2C4A = 1;
	}

	param_00.var_2C4A = 1;
	func_F66F();
	level notify("bomb_defused" + param_00.label);
	if(isdefined(level.var_C561))
	{
		[[ level.var_C561 ]]("bombzone",self.label,undefined,game["defenders"],undefined);
	}
}

//Function Number: 16
func_12E67(param_00)
{
	if(isdefined(param_00))
	{
		if(param_00 == "allies")
		{
			setomnvar("ui_bomb_owner_team",2);
		}
		else
		{
			setomnvar("ui_bomb_owner_team",1);
		}
	}

	if(level.var_209F)
	{
		setomnvar("ui_bomb_planted_a",1);
	}
	else
	{
		setomnvar("ui_bomb_planted_a",0);
	}

	if(level.var_2F35)
	{
		setomnvar("ui_bomb_planted_b",1);
		return;
	}

	setomnvar("ui_bomb_planted_b",0);
}

//Function Number: 17
func_F66F(param_00)
{
	func_12E67(param_00);
}

//Function Number: 18
func_2C77(param_00)
{
	level.var_2C5C = 0;
	level.var_2C4A = 0;
	level.var_2C58 = 0;
	var_01 = getent(param_00 + "_pickup_trig","targetname");
	if(!isdefined(var_01))
	{
		scripts\common\utility::func_66BD("No " + param_00 + "_pickup_trig trigger found in map.");
		return;
	}

	var_01 = postshipadjustbombtriggerspawn(var_01);
	var_02[0] = getent(param_00,"targetname");
	if(!isdefined(var_02[0]))
	{
		scripts\common\utility::func_66BD("No " + param_00 + " script_model found in map.");
		return;
	}

	var_02[0] = postshipadjustbombcasespawn(var_02[0]);
	var_02[0] setmodel("suitcase_bomb_iw7_wm");
	if(!level.var_BDC1)
	{
		level.var_F013 = scripts\mp\_gameobjects::func_4993(game["attackers"],var_01,var_02,(0,0,32));
		level.var_F013 scripts\mp\_gameobjects::func_1C7C("friendly");
		level.var_F013 scripts\mp\_gameobjects::func_F283("friendly","waypoint_bomb");
		level.var_F013 scripts\mp\_gameobjects::func_F284("friendly","waypoint_bomb");
		level.var_F013 scripts\mp\_gameobjects::setvisibleteam("friendly");
		level.var_F013.var_1CB3 = 1;
		level.var_F013.var_C566 = ::func_C566;
		level.var_F013.var_C4F9 = ::func_C4F9;
		level thread func_2C63();
		level.var_2C61 = level.var_F013.visuals[0].origin;
		level.var_2C60 = level.var_F013.visuals[0].angles;
		level.var_F013.var_1349F = (0,0,2);
		return;
	}

	var_01 delete();
	var_02[0] delete();
}

//Function Number: 19
func_BCAB(param_00,param_01)
{
	if(isdefined(level.var_F013))
	{
		level.var_F013.trigger.origin = param_00;
		level.var_F013.visuals[0].origin = param_00;
		level.var_F013.visuals[0].angles = param_01;
		level.var_F013.visuals[0] show();
		level.var_F013 scripts\mp\_gameobjects::func_1C7C("friendly");
		level.var_F013 scripts\mp\_gameobjects::func_F283("friendly","waypoint_bomb");
		level.var_F013 scripts\mp\_gameobjects::func_F284("friendly","waypoint_bomb");
		level.var_F013 scripts\mp\_gameobjects::setvisibleteam("friendly");
		level.var_F013.var_1CB3 = 1;
		level.var_F013.var_C566 = ::func_C566;
		level.var_F013.var_C4F9 = ::func_C4F9;
	}
}

//Function Number: 20
func_2C63()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("bomb_pickup");
		foreach(var_01 in level.var_2C7A)
		{
			var_01.trigger enableplayeruse(level.var_F013.carrier);
		}

		wait(0.05);
	}
}

//Function Number: 21
func_C566(param_00)
{
	param_00.var_9D6C = 1;
	if(isplayer(param_00))
	{
		param_00 thread scripts\mp\_matchdata::func_AFBA("pickup",param_00.origin);
		scripts\mp\_utility::func_F79E(15,param_00.team,param_00 getentitynumber());
	}

	param_00 setclientomnvar("ui_carrying_bomb",1);
	setomnvar("ui_bomb_carrier",param_00 getentitynumber());
	scripts\mp\_gameobjects::func_F283("friendly","waypoint_escort");
	scripts\mp\_gameobjects::func_F284("friendly","waypoint_escort");
	if(isdefined(level.var_F004) && isdefined(level.var_F004[param_00.team]))
	{
		param_00 thread func_20BE();
	}

	if(!level.var_2C4A)
	{
		scripts\mp\_utility::func_115DE("callout_bombtaken",param_00,param_00.team);
		scripts\mp\_utility::func_AAE7("bomb_taken",param_00.pers["team"]);
	}

	scripts\mp\_utility::playsoundonplayers(game["bomb_recovered_sound"],game["attackers"]);
	if(getdvarint("com_codcasterEnabled",0) == 1)
	{
		param_00 method_80C1(1);
	}

	level notify("bomb_pickup");
}

//Function Number: 22
func_C4F9(param_00)
{
	level notify("bomb_dropped");
	setomnvar("ui_bomb_carrier",-1);
	if(getdvarint("com_codcasterEnabled",0) == 1)
	{
		if(isdefined(param_00))
		{
			param_00 method_80C1(0);
		}
	}

	scripts\mp\_gameobjects::func_F283("friendly","waypoint_bomb");
	scripts\mp\_gameobjects::func_F284("friendly","waypoint_bomb");
	scripts\mp\_utility::playsoundonplayers(game["bomb_dropped_sound"],game["attackers"]);
	if(!level.var_2C5C && isdefined(level.var_2C5F) && level.var_2C5F > 0)
	{
		thread func_136AD(level.var_2C5F);
	}
}

//Function Number: 23
func_136AD(param_00)
{
	level endon("game_ended");
	level endon("bomb_pickup");
	wait(param_00);
	playfx(loadfx("vfx/core/mp/killstreaks/vfx_ballistic_vest_death"),self.visuals[0].origin,self.visuals[0].angles);
	func_BCAB(level.var_2C61,level.var_2C60);
}

//Function Number: 24
func_6273()
{
	foreach(var_01 in level.players)
	{
		if(!isai(var_01))
		{
			var_01 setclientomnvar("ui_carrying_bomb",var_01.pers["team"] == game["attackers"]);
		}
	}
}

//Function Number: 25
func_E294()
{
	level endon("game_ended");
	wait(5);
	if(level.var_BDC1)
	{
		func_6273();
		return;
	}

	func_BCAB(level.var_2C61,level.var_2C60);
}

//Function Number: 26
func_18CF()
{
	level.var_2C5C = 0;
	level.var_2C4A = 0;
	level.var_2C61 = level.var_4B29.visuals[0].origin + (0,0,48);
	level.var_2C60 = level.var_4B29.visuals[0].angles;
	if(level.var_BDC1)
	{
		func_6273();
		return;
	}

	func_BCAB(level.var_2C61,level.var_2C60);
}

//Function Number: 27
func_20BE()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(isdefined(self.var_9D81) && self.var_9D81 == 1)
	{
		self notify("force_cancel_placement");
		wait(0.05);
	}

	while(self ismantling())
	{
		wait(0.05);
	}

	while(!self isonground())
	{
		wait(0.05);
	}

	if(scripts\mp\_utility::func_9E59())
	{
		self notify("lost_juggernaut");
		wait(0.05);
	}

	self.pers["gamemodeLoadout"] = level.var_F004[self.team];
	if(isdefined(self.var_F851))
	{
		scripts\mp\perks\_perkfunctions::func_51D7(self.var_F851);
	}

	var_00 = spawn("script_model",self.origin);
	var_00.angles = self.angles;
	var_00.var_D424 = self.origin;
	var_00.var_C188 = 1;
	self.var_F851 = var_00;
	self.var_7673 = self.var_4004;
	self.pers["class"] = "gamemode";
	self.pers["lastClass"] = "gamemode";
	self.var_4004 = "gamemode";
	self.var_A95C = "gamemode";
	self notify("faux_spawn");
	self.var_767C = 1;
	self.var_6BA6 = self getstance();
	thread scripts\mp\_playerlogic::func_108F2(1);
}

//Function Number: 28
func_E0D7()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(isdefined(self.var_9D81) && self.var_9D81 == 1)
	{
		self notify("force_cancel_placement");
		wait(0.05);
	}

	while(self ismantling())
	{
		wait(0.05);
	}

	while(!self isonground())
	{
		wait(0.05);
	}

	if(scripts\mp\_utility::func_9E59())
	{
		self notify("lost_juggernaut");
		wait(0.05);
	}

	self.pers["gamemodeLoadout"] = undefined;
	if(isdefined(self.var_F851))
	{
		scripts\mp\perks\_perkfunctions::func_51D7(self.var_F851);
	}

	var_00 = spawn("script_model",self.origin);
	var_00.angles = self.angles;
	var_00.var_D424 = self.origin;
	var_00.var_C188 = 1;
	self.var_F851 = var_00;
	self notify("faux_spawn");
	self.var_6BA6 = self getstance();
	thread scripts\mp\_playerlogic::func_108F2(1);
}

//Function Number: 29
func_2C6F(param_00,param_01)
{
	foreach(var_03 in level.var_2C7A)
	{
		if(!isdefined(var_03.var_2C4B.origin))
		{
			continue;
		}

		var_04 = scripts\mp\_utility::func_9FB3(var_03.var_2C5C);
		var_05 = func_5720(param_00.origin,param_01.origin,scripts\common\utility::func_116D7(var_04,var_03.var_2C4B.origin,var_03.trigger.origin));
		if(var_05)
		{
			if(param_01.team == game["defenders"])
			{
				param_00 thread scripts\mp\_awards::func_8380(scripts\common\utility::func_116D7(var_04,"mode_x_defend","mode_x_assault"));
				continue;
			}

			param_00 thread scripts\mp\_awards::func_8380(scripts\common\utility::func_116D7(var_04,"mode_x_assault","mode_x_defend"));
		}
	}
}

//Function Number: 30
func_5720(param_00,param_01,param_02)
{
	var_03 = distancesquared(param_02,param_00);
	var_04 = distancesquared(param_02,param_01);
	if(var_03 < 90000 || var_04 < 90000)
	{
		return 1;
	}

	return 0;
}

//Function Number: 31
postshipmodifiedbombzones(param_00,param_01)
{
	var_02 = param_01.origin;
	var_03 = modifiedbombzones(param_01,var_02,param_00);
	return var_03;
}

//Function Number: 32
modifiedbombzones(param_00,param_01,param_02)
{
	if(level.var_B335 == "mp_desert" && param_00.script_label == "_b")
	{
		param_02[0].origin = (-928,552,352);
		param_02[0].angles = (0,0,0);
		param_00.var_C732 = (-928,552,361);
		param_00.origin = param_00.var_C732;
		param_00.angles = (0,90,0);
		setmodifiedbombzonescollision((0,0,35),(0,90,0),param_01,param_02);
		setexplodermodel(param_01,param_02);
		return param_00;
	}

	if(level.var_B335 == "mp_metropolis" && param_00.script_label == "_b")
	{
		param_02[0].origin = (-1570,-785,-64);
		param_02[0].angles = (0,90,0);
		param_00.var_C732 = (-1570,-785,-64);
		param_00.origin = param_00.var_C732;
		param_00.angles = (0,0,0);
		setmodifiedbombzonescollision((0,0,27),(0,180,0),param_01,param_02);
		setexplodermodel(param_01,param_02);
		return param_00;
	}

	if(level.var_B335 == "mp_fallen" && param_00.script_label == "_a")
	{
		param_02[0].origin = (408,-70,760);
		param_02[0].angles = (0,0,0);
		param_00.var_C732 = (408,-70,760);
		param_00.origin = param_00.var_C732;
		param_00.angles = (0,90,0);
		setmodifiedbombzonescollision((0,0,27),(0,90,0),param_01,param_02);
		setexplodermodel(param_01,param_02);
		return param_00;
	}

	if(level.var_B335 == "mp_fallen" && param_00.script_label == "_b")
	{
		param_02[0].origin = (-270,2387,927);
		param_02[0].angles = (0,0,0);
		param_00.var_C732 = (-270,2387,927);
		param_00.origin = param_00.var_C732;
		param_00.angles = (0,90,0);
		setmodifiedbombzonescollision((0,0,27),(0,270,0),param_01,param_02);
		setexplodermodel(param_01,param_02);
		return param_00;
	}

	if(level.var_B335 == "mp_riot" && param_00.script_label == "_a")
	{
		param_02[0].origin = (514,669,250);
		param_02[0].angles = (13,90,1);
		param_00.var_C732 = (514,669,250);
		param_00.origin = param_00.var_C732;
		param_00.angles = (13,90,1);
		setmodifiedbombzonescollision((0,5,30),(13,90,1),param_01,param_02);
		setexplodermodel(param_01,param_02);
		return param_00;
	}

	if(level.var_B335 == "mp_proto" && param_00.script_label == "_a")
	{
		param_02[0].origin = (-90,1825,480);
		param_02[0].angles = (0,0,0);
		param_00.var_C732 = (-90,1825,480);
		param_00.origin = param_00.var_C732;
		param_00.angles = (0,90,0);
		setmodifiedbombzonescollision((0,0,27),(0,270,0),param_01,param_02);
		setexplodermodel(param_01,param_02);
		return param_00;
	}

	if(level.var_B335 == "mp_divide" && param_00.script_label == "_b")
	{
		param_02[0].origin = (-510,-560,585);
		param_02[0].angles = (0,180,0);
		param_00.var_C732 = (-527,-560,585);
		param_00.origin = param_00.var_C732;
		param_00.angles = (0,135,0);
		setmodifiedbombzonescollision((0,0,27),(0,-45,0),param_01,param_02);
		setexplodermodel(param_01,param_02);
		return param_00;
	}

	if(level.var_B335 == "mp_parkour" && param_00.script_label == "_a")
	{
		param_02[0].origin = (-1602,3,184);
		param_02[0].angles = (0,90,0);
		param_00.var_C732 = (-1602,3,186);
		param_00.origin = param_00.var_C732;
		param_00.angles = (0,0,0);
		setmodifiedbombzonescollision((0,0,27),(0,180,0),param_01,param_02);
		setexplodermodel(param_01,param_02);
		return param_00;
	}

	if(level.var_B335 == "mp_parkour" && param_00.script_label == "_b")
	{
		param_02[0].origin = (489,-1408,249);
		param_02[0].angles = (0,90,0);
		param_00.var_C732 = (489,-1408,249);
		param_00.origin = param_00.var_C732;
		param_00.angles = (0,90,0);
		setmodifiedbombzonescollision((0,0,27),(0,270,0),param_01,param_02);
		setexplodermodel(param_01,param_02);
		return param_00;
	}

	return param_00;
}

//Function Number: 33
setmodifiedbombzonescollision(param_00,param_01,param_02,param_03)
{
	var_04 = getentarray("script_brushmodel","classname");
	foreach(var_06 in var_04)
	{
		if(isdefined(var_06.var_EDBF) && var_06.var_EDBF == "bombzone")
		{
			if(distance(var_06.origin,param_02) < 100)
			{
				var_07 = spawn("script_model",param_03[0].origin + param_00);
				var_07.angles = param_01;
				var_07 clonebrushmodeltoscriptmodel(var_06);
				var_07 disconnectpaths();
				var_06 delete();
				break;
			}
		}
	}
}

//Function Number: 34
setexplodermodel(param_00,param_01)
{
	var_02 = getentarray("script_model","classname");
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(isdefined(var_02[var_03].var_ED84))
		{
			if(isdefined(var_02[var_03].var_336) && var_02[var_03].var_336 == "exploder" && distance(var_02[var_03].origin,param_00) < 100)
			{
				var_02[var_03].origin = param_01[0].origin;
				var_02[var_03].angles = param_01[0].angles;
			}
		}
	}
}

//Function Number: 35
postshipadjustbombcasespawn(param_00)
{
	if(level.var_B335 == "mp_fallen")
	{
		param_00.origin = (2655,1260,930);
		return param_00;
	}

	if(level.var_B335 == "mp_divide")
	{
		param_00.origin = param_00.origin - (0,0,2);
		return param_00;
	}

	if(level.var_B335 == "mp_parkour")
	{
		param_00.origin = (-56,3139,170);
		return param_00;
	}

	if(level.var_B335 == "mp_quarry")
	{
		param_00.origin = (-2067,1214,242);
		return param_00;
	}

	if(level.var_B335 == "mp_frontier")
	{
		param_00.origin = param_00.origin + (0,0,1);
		return param_00;
	}

	if(level.var_B335 == "mp_desert")
	{
		param_00.origin = param_00.origin + (0,0,1);
		return param_00;
	}

	if(level.var_B335 == "mp_metropolis")
	{
		param_00.origin = param_00.origin + (0,0,2);
		return param_00;
	}

	if(level.var_B335 == "mp_proto")
	{
		param_00.origin = (2349,228,530);
		return param_00;
	}

	if(level.var_B335 == "mp_rivet")
	{
		param_00.origin = param_00.origin + (0,0,1);
		return param_00;
	}

	if(level.var_B335 == "mp_breakneck")
	{
		param_00.origin = param_00.origin + (0,0,2);
		return param_00;
	}

	if(level.var_B335 == "mp_dome_iw")
	{
		param_00.origin = param_00.origin + (0,0,2);
		return param_00;
	}

	if(level.var_B335 == "mp_skyway")
	{
		param_00.origin = param_00.origin + (0,0,2);
		return param_00;
	}

	return param_00;
}

//Function Number: 36
postshipadjustbombtriggerspawn(param_00)
{
	if(level.var_B335 == "mp_proto")
	{
		param_00.origin = (2349,228,530);
		return param_00;
	}

	if(level.var_B335 == "mp_fallen")
	{
		param_00.origin = (2655,1260,930);
		return param_00;
	}

	if(level.var_B335 == "mp_quarry")
	{
		param_00.origin = (-2067,1214,242);
		return param_00;
	}

	if(level.var_B335 == "mp_parkour")
	{
		param_00.origin = (-56,3139,170);
		return param_00;
	}

	return param_00;
}