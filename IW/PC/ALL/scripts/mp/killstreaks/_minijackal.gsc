/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_minijackal.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 38
 * Decompile Time: 1948 ms
 * Timestamp: 10/27/2023 12:29:05 AM
*******************************************************************/

//Function Number: 1
init()
{
	scripts\mp\killstreaks\_killstreaks::func_DEFB("minijackal",::func_12889,undefined,undefined,undefined,::func_13C16,undefined,::invalid_use_minijackal);
	level._effect["miniJackal_eyeglow"] = loadfx("vfx/iw7/_requests/mp/vfx_venom_glint");
	level._effect["miniJackal_explosion"] = loadfx("vfx/iw7/core/mp/killstreaks/vfx_apex_dest_exp.vfx");
	level._effect["miniJackal_hover_thrusters"] = loadfx("vfx/iw7/core/mp/killstreaks/vfx_apex_thrusters.vfx");
	level._effect["miniJackal_antenna_enemy"] = loadfx("vfx/iw7/core/mp/killstreaks/vfx_apex_light_ping_en.vfx");
	level._effect["miniJackal_antenna_friendly"] = loadfx("vfx/iw7/core/mp/killstreaks/vfx_apex_light_ping_fr.vfx");
	level._effect["miniJackal_boost_thrusters"] = loadfx("vfx/iw7/core/mp/killstreaks/vfx_apex_thrusters_boost.vfx");
	level._effect["miniJackal_hover_thrusters_light"] = loadfx("vfx/iw7/core/mp/killstreaks/vfx_apex_thrusters_light.vfx");
	level._effect["miniJackal_boost_thrusters_light"] = loadfx("vfx/iw7/core/mp/killstreaks/vfx_apex_thrusters_boost_light.vfx");
	level.var_B7AD = [];
	var_00 = ["passive_increased_armor","passive_decreased_duration","passive_auto_missiles","passive_long_reload","passive_twin_dragons","passive_armor_duration"];
	scripts\mp\_killstreak_loot::func_DF07("minijackal",var_00);
	level.minijackalsincoming = [];
}

//Function Number: 2
func_13C16(param_00)
{
	var_01 = 0;
	var_02 = 0;
	foreach(var_04 in level.minijackalsincoming)
	{
		if(level.teambased)
		{
			if(self.team == var_04.team)
			{
				var_01++;
			}

			continue;
		}

		var_02++;
	}

	if(var_01 >= 1)
	{
		scripts\mp\_hud_message::func_10122("KILLSTREAKS_MINIJACKAL_MAX");
		return 0;
	}

	if(var_02 >= 2)
	{
		scripts\mp\_hud_message::func_10122("KILLSTREAKS_MINIJACKAL_MAX");
		return 0;
	}

	if(isdefined(level.var_B7AD))
	{
		var_06 = 0;
		var_07 = 0;
		foreach(var_09 in level.var_B7AD)
		{
			if(level.teambased)
			{
				if(self.team == var_09.var_222.team)
				{
					var_06++;
				}

				continue;
			}

			var_07++;
		}

		if(var_06 + var_01 >= 1)
		{
			scripts\mp\_hud_message::func_10122("KILLSTREAKS_MINIJACKAL_MAX");
			return 0;
		}

		if(var_07 + var_02 >= 2)
		{
			scripts\mp\_hud_message::func_10122("KILLSTREAKS_MINIJACKAL_MAX");
			return 0;
		}
	}

	self setclientomnvar("ui_remote_control_sequence",1);
	incrementminijackalsincoming(self);
}

//Function Number: 3
invalid_use_minijackal(param_00)
{
	decrementminijackalsincoming(self);
}

//Function Number: 4
incrementminijackalsincoming(param_00)
{
	var_01 = "ent_" + param_00 getentitynumber();
	level.minijackalsincoming[var_01] = param_00;
	param_00 thread watchforinterrupt(var_01);
}

//Function Number: 5
watchforinterrupt(param_00)
{
	self endon("received_playremote_result");
	level endon("game_ended");
	scripts\common\utility::waittill_any_3("death","disconnect");
	decrementminijackalsincoming(param_00);
}

//Function Number: 6
decrementminijackalsincoming(param_00)
{
	var_01 = undefined;
	if(isplayer(param_00))
	{
		var_01 = "ent_" + param_00 getentitynumber();
	}
	else
	{
		var_01 = param_00;
	}

	level.minijackalsincoming[var_01] = undefined;
}

//Function Number: 7
func_12889(param_00)
{
	var_01 = scripts\mp\killstreaks\_killstreaks::func_D507(param_00);
	self notify("received_playremote_result");
	if(!var_01)
	{
		decrementminijackalsincoming(self);
		return 0;
	}

	var_02 = func_6C9B(80,35,20);
	if(!isdefined(var_02))
	{
		decrementminijackalsincoming(self);
		scripts\mp\_hud_message::func_10122("KILLSTREAKS_NOT_ENOUGH_SPACE");
		thread scripts\mp\killstreaks\_killstreaks::func_11086();
		return 0;
	}

	scripts\common\utility::func_1C6E(0);
	scripts\common\utility::func_1C76(0);
	var_03 = "veh_mil_air_ca_oblivion_drone_mp";
	var_04 = "veh_minijackal_mp";
	var_05 = "used_minijackal";
	var_06 = 60;
	var_07 = "minijackal_strike_mp";
	var_08 = 1;
	var_09 = scripts\mp\_killstreak_loot::getrarityforlootitem(param_00.var_1318B);
	if(var_09 != "")
	{
		var_03 = var_03 + "_" + var_09;
		var_05 = var_05 + "_" + var_09;
	}

	if(scripts\mp\killstreaks\_utility::func_A69F(param_00,"passive_armor_duration"))
	{
		var_06 = var_06 - 5;
	}

	if(scripts\mp\killstreaks\_utility::func_A69F(param_00,"passive_twin_dragons"))
	{
		var_07 = "minijackal_assault_mp";
		var_04 = "veh_minijackal_beam_mp";
		var_08 = 2;
	}

	var_0A = spawnvehicle(var_03,"minijackal",var_04,var_02,self.angles,self);
	level.var_B7AD[level.var_B7AD.size] = var_0A;
	decrementminijackalsincoming(self);
	var_0A method_8317(1);
	var_0A method_80C7();
	var_0A.var_13CC3 = [];
	var_0A.var_13CC3["hover"] = "minijackal_assault_mp";
	var_0A.var_13CC3["fly"] = var_07;
	var_0A.var_13CC3["land"] = var_0A.var_13CC3["hover"];
	var_0A method_84BE("minijackal_mp");
	var_0A method_849E(var_0A.var_13CC3["fly"]);
	lib_0BCE::func_A2B2(var_0A,undefined,"hover");
	self method_8490("disable_mode_switching",1);
	self method_8490("disable_juke",1);
	self method_8490("disable_guns",0);
	self method_8490("disable_boost",0);
	self.var_E2D7 = self getplayerangles();
	self.ignoreme = 0;
	self method_85A2("apex_mp");
	var_0A.var_10E4C = func_495B();
	var_0A.var_EDD7 = 2250;
	var_0A.var_B43C = 2250;
	var_0A.var_11A34 = 0;
	var_0A.var_110EA = param_00.var_110EA;
	var_0A.var_222 = self;
	var_0A.team = self.team;
	var_0A.var_B8B0 = 4;
	var_0A.var_110E8 = param_00;
	self.var_B7AA = var_0A;
	var_0A scripts\mp\killstreaks\_utility::func_1843(param_00.var_110EA,"Killstreak_Ground",var_0A.var_222,1);
	var_0A scripts\mp\killstreaks\_utility::func_FAE4("minijackal_end","apex_mp");
	var_0A thread func_B9A4(self);
	var_0A thread func_B9A5(self);
	var_0A thread func_B97F(self);
	var_0A thread func_B95F(self);
	var_0A thread func_B961(self);
	var_0A thread func_B95E(self);
	var_0A thread func_B9A9(var_06);
	var_0A thread func_B968(self);
	var_0A thread func_B963(self);
	var_0A thread func_B969(self);
	var_0A thread func_5119(self);
	var_0A setscriptablepartstate("thrusters","hover",0);
	var_0A setscriptablepartstate("team_light","idle",0);
	var_0A setscriptablepartstate("dust","active",0);
	var_0A setscriptablepartstate("hud","active",0);
	scripts\mp\_matchdata::func_AFC9(param_00.var_110EA,var_0A.origin);
	level thread scripts\mp\_utility::func_115DE(var_05,self);
	self setclientomnvar("ui_minijackal_controls",var_08);
	self setclientomnvar("ui_killstreak_countdown",gettime() + int(var_06 * 1000));
	self setclientomnvar("ui_killstreak_health",var_0A.var_EDD7 / var_0A.var_B43C);
	self thermalvisionfofoverlayon();
	self.var_209D = gettime();
	return 1;
}

//Function Number: 8
func_B9A4(param_00)
{
	param_00 endon("disconnect");
	level endon("game_ended");
	self endon("minijackal_end");
	for(;;)
	{
		param_00 waittill("engage boost");
		self setscriptablepartstate("thrusters","boost",0);
	}
}

//Function Number: 9
func_B9A5(param_00)
{
	param_00 endon("disconnect");
	level endon("game_ended");
	self endon("minijackal_end");
	for(;;)
	{
		param_00 waittill("disengage boost");
		self method_8491("hover");
		self setscriptablepartstate("thrusters","hover",0);
	}
}

//Function Number: 10
func_B9AF(param_00)
{
	param_00 endon("disconnect");
	level endon("game_ended");
	self endon("minijackal_end");
	param_00 notifyonplayercommand("ks_switch_weapons","+weapnext");
	var_01 = self.var_13CC3["hover"];
	for(;;)
	{
		param_00 waittill("ks_switch_weapons");
		self method_849E(var_01);
		if(var_01 == self.var_13CC3["fly"])
		{
			var_01 = self.var_13CC3["hover"];
			continue;
		}

		var_01 = self.var_13CC3["fly"];
	}
}

//Function Number: 11
func_B978(param_00)
{
	param_00 endon("disconnect");
	level endon("game_ended");
	self endon("minijackal_end");
	for(;;)
	{
		var_01 = float(float(self.var_11A34) / float(self.var_B43C));
		var_01 = clamp(var_01,0,1);
		self.var_10E4C.alpha = var_01;
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 12
func_B97A(param_00)
{
	param_00 endon("disconnect");
	level endon("game_ended");
	self endon("minijackal_end");
	param_00 notifyonplayercommand("ks_lockon","+speed_throw");
	param_00 notifyonplayercommand("ks_lockoff","-speed_throw");
	for(;;)
	{
		param_00 waittill("ks_lockon");
		self method_849E(self.var_13CC3["hover"]);
		param_00 waittill("ks_lockoff");
		self method_849E(self.var_13CC3["fly"]);
	}
}

//Function Number: 13
func_B97F(param_00)
{
	param_00 endon("disconnect");
	level endon("game_ended");
	self endon("minijackal_end");
	param_00 notifyonplayercommand("minijackal_missile_fire","+frag");
	var_01 = ["tag_missile1","tag_missile2","tag_missile3","tag_missile4"];
	var_02 = "ui_minijackal_reload";
	if(scripts\mp\killstreaks\_utility::func_A69F(self.var_110E8,"passive_auto_missiles"))
	{
		var_02 = "ui_minijackal_reload_long";
	}

	for(;;)
	{
		param_00 waittill("minijackal_missile_fire");
		if(scripts\mp\_utility::func_9FB3(self.var_DF58))
		{
			continue;
		}

		var_03 = self.var_B8B0;
		param_00 setclientomnvar(var_02,1);
		for(var_04 = 0;var_04 < var_03;var_04++)
		{
			var_05 = self gettagorigin(var_01[var_04]);
			var_06 = self gettagorigin("tag_camera") + anglestoforward(self.angles) * 1000;
			var_07 = scripts\mp\_utility::func_1309("shockproj_mp",var_05,var_06,param_00);
			var_07.var_110E8 = self.var_110E8;
			var_07 method_82DD(self);
			if(scripts\mp\killstreaks\_utility::func_A69F(self.var_110E8,"passive_auto_missiles"))
			{
				var_07 trackmissiletargetinview(var_05,self);
			}

			self setscriptablepartstate("missile_pod_" + var_04 + 1,"fire",0);
			var_07 thread func_13A22();
			var_07 thread scripts\mp\killstreaks\_utility::watchsupertrophynotify(param_00);
			self.var_B8B0--;
			scripts\mp\_hostmigration::func_13708(0.2);
		}

		thread func_B894(param_00);
	}
}

//Function Number: 14
trackmissiletargetinview(param_00,param_01)
{
	var_02 = scripts\mp\killstreaks\_utility::func_7E92(param_01.var_222);
	var_03 = undefined;
	var_04 = 999999999;
	var_05 = param_00;
	var_06 = anglestoforward(param_01.angles);
	var_07 = [self,param_01,param_01.var_222];
	var_08 = physics_createcontents(["physicscontents_solid","physicscontents_glass","physicscontents_water","physicscontents_vehicle","physicscontents_item"]);
	foreach(var_0A in var_02)
	{
		if(!scripts\mp\killstreaks\_utility::manualmissilecantracktarget(var_0A))
		{
			continue;
		}

		if(scripts\mp\_utility::func_9FB3(var_0A.apextargetted))
		{
			continue;
		}

		var_0B = var_0A.origin;
		var_0C = vectornormalize(var_0B - var_05);
		var_07[var_07.size] = var_0A;
		var_0D = distance2d(var_05,var_0B);
		if(scripts\common\trace::func_DCF1(var_05,var_0B,var_07,var_08) && vectordot(var_06,var_0C) > 0.75 && var_0D <= var_04)
		{
			var_04 = var_0D;
			var_03 = var_0A;
		}
	}

	if(isdefined(var_03))
	{
		self missile_settargetent(var_03,(0,0,40));
		self missile_setflightmodedirect();
		var_03.apextargetted = 1;
		var_03 thread watchtarget(self);
	}
}

//Function Number: 15
watchtarget(param_00)
{
	self endon("disconnect");
	for(;;)
	{
		if(!scripts\mp\killstreaks\_utility::manualmissilecantracktarget(self))
		{
			break;
		}

		if(!isdefined(param_00))
		{
			break;
		}

		scripts\common\utility::func_136F7();
	}

	self.apextargetted = undefined;
	if(isdefined(param_00))
	{
		param_00 missile_cleartarget();
	}
}

//Function Number: 16
func_13A22()
{
	self waittill("explode",var_00);
	playsoundatpos(var_00,"wrist_rocket_explode");
}

//Function Number: 17
func_B894(param_00)
{
	param_00 endon("disconnect");
	level endon("game_ended");
	self endon("minijackal_end");
	self.var_DF58 = 1;
	var_01 = 0.8;
	var_02 = "ui_minijackal_reload";
	if(scripts\mp\killstreaks\_utility::func_A69F(self.var_110E8,"passive_auto_missiles"))
	{
		var_01 = 1.05;
		var_02 = "ui_minijackal_reload_long";
	}

	while(self.var_B8B0 < 4)
	{
		scripts\mp\_hostmigration::func_13708(var_01);
		self.var_B8B0++;
		self setscriptablepartstate("missile_pod_" + self.var_B8B0,"neutral",0);
	}

	param_00 setclientomnvar(var_02,0);
	self.var_DF58 = undefined;
}

//Function Number: 18
func_B95F(param_00)
{
	param_00 endon("disconnect");
	level endon("game_ended");
	self endon("minijackal_end");
	var_01 = 3;
	var_02 = 4;
	var_03 = 5;
	if(scripts\mp\killstreaks\_utility::func_A69F(self.var_110E8,"passive_armor_duration"))
	{
		var_01++;
		var_02++;
		var_03++;
	}

	for(;;)
	{
		self waittill("damage",var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D,var_0E,var_0F,var_10,var_11);
		var_0D = scripts\mp\_utility::func_13CA1(var_0D,var_11);
		if(isdefined(var_05) && var_05.classname != "trigger_hurt")
		{
			if(isdefined(var_05.var_222))
			{
				var_05 = var_05.var_222;
			}

			if(isdefined(var_05.team) && var_05.team == self.team && var_05 != self.var_222)
			{
				continue;
			}
		}

		if(lib_0DF8::func_9DDF(var_05))
		{
			continue;
		}

		if(isdefined(var_0D))
		{
			var_04 = scripts\mp\killstreaks\_utility::func_7FBD(var_05,var_0D,var_08,var_04,self.var_B43C,var_01,var_02,var_03,1);
			if(scripts\mp\killstreaks\_utility::func_A69F(self.var_110E8,"passive_armor_duration"))
			{
				if(scripts\mp\killstreaks\_utility::isexplosiveantikillstreakweapon(var_0D))
				{
					var_05 scripts\mp\_damagefeedback::func_12E84("hitblastshield");
				}
			}
		}

		self.var_EDD7 = self.var_EDD7 - var_04;
		self.var_11A34 = self.var_11A34 + var_04;
		if(self.var_EDD7 < 0)
		{
			self.var_EDD7 = 0;
		}

		param_00 setclientomnvar("ui_killstreak_health",self.var_EDD7 / self.var_B43C);
		if(isdefined(var_08))
		{
			param_00 func_4CF1(self,var_08);
		}

		if(isplayer(var_05))
		{
			var_05 scripts\mp\_damagefeedback::func_12E84("");
			scripts\mp\killstreaks\_killstreaks::func_A6A0(var_05,var_0D,self,var_08);
			scripts\mp\_damage::func_AF96(self,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D);
			if(self.var_EDD7 <= 0)
			{
				var_05 notify("destroyed_killstreak",var_0D);
				var_12 = "callout_destroyed_" + self.var_110EA;
				var_13 = scripts\mp\_killstreak_loot::getrarityforlootitem(self.var_110E8.var_1318B);
				if(var_13 != "")
				{
					var_12 = var_12 + "_" + var_13;
				}

				scripts\mp\_damage::func_C548("minijackal",var_05,var_0D,var_08,var_04,"destroyed_" + self.var_110EA,self.var_110EA + "_destroy",var_12,1);
			}
		}

		if(self.var_EDD7 <= 0)
		{
			self notify("minijackal_end");
		}
	}
}

//Function Number: 19
func_4CF1(param_00,param_01)
{
	switch(param_01)
	{
		case "MOD_GRENADE_SPLASH":
		case "MOD_GRENADE":
		case "MOD_PROJECTILE":
		case "MOD_EXPLOSIVE_BULLET":
		case "MOD_PISTOL_BULLET":
		case "MOD_RIFLE_BULLET":
			func_3239(param_00);
			break;

		case "MOD_PROJECTILE_SPLASH":
		case "MOD_IMPACT":
		case "MOD_EXPLOSIVE":
			func_69E6(param_00);
			break;

		default:
			break;
	}
}

//Function Number: 20
func_3239(param_00)
{
	self earthquakeforplayer(0.2,0.25,param_00.origin,50);
	self playrumbleonentity("damage_light");
	thread func_1349D(param_00,0.4);
}

//Function Number: 21
func_69E6(param_00)
{
	self earthquakeforplayer(0.5,0.45,param_00.origin,1000);
	self playrumbleonentity("damage_heavy");
	thread func_1349D(param_00,0.7);
}

//Function Number: 22
func_1349D(param_00,param_01)
{
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("minijackal_end");
	param_00.var_10E4C.alpha = param_01;
	while(param_01 > 0)
	{
		scripts\common\utility::func_136F7();
		param_01 = param_01 - 0.1;
		param_00.var_10E4C.alpha = param_01;
	}
}

//Function Number: 23
func_495B()
{
	var_00 = newclienthudelem(self);
	var_00.x = 0;
	var_00.y = 0;
	var_00 setshader("white",640,480);
	var_00.alignx = "left";
	var_00.aligny = "top";
	var_00.sort = 1;
	var_00.horzalign = "fullscreen";
	var_00.vertalign = "fullscreen";
	var_00.alpha = 0;
	var_00.foreground = 1;
	return var_00;
}

//Function Number: 24
func_B961(param_00)
{
	level endon("game_ended");
	self waittill("minijackal_end");
	self stoploopsound();
	var_01 = self.origin + anglestoforward(self.angles) * 100;
	playsoundatpos(self.origin,"frag_grenade_explode");
	playfx(scripts\common\utility::getfx("miniJackal_explosion"),self.origin);
	if(isdefined(param_00))
	{
		if(scripts\mp\_utility::func_9F19(param_00))
		{
			param_00 earthquakeforplayer(0.6,1,self.origin,500);
		}

		param_00 lib_0BCE::func_A2B1(self);
		param_00 setclientomnvar("ui_minijackal_controls",0);
		param_00 setclientomnvar("ui_killstreak_missile_warn",0);
		param_00 setclientomnvar("ui_killstreak_countdown",0);
		param_00 setclientomnvar("ui_killstreak_health",0);
		param_00 setclientomnvar("ui_minijackal_reload",0);
		param_00 setclientomnvar("ui_minijackal_reload_long",0);
		param_00 setplayerangles(param_00.var_E2D7);
		param_00 method_85A2("");
		param_00 thermalvisionfofoverlayoff();
		param_00 thread scripts\mp\killstreaks\_killstreaks::func_11086();
		param_00 scripts\common\utility::func_1C6E(1);
		param_00 scripts\common\utility::func_1C76(1);
		var_02 = gettime() - param_00.var_209D / 1000;
		param_00 scripts\mp\_missions::func_D991("ch_apex_pilot",int(var_02));
	}

	if(isdefined(self.var_115D6))
	{
		self.var_115D6 delete();
	}

	if(isdefined(self.var_C7FF))
	{
		self.var_C7FF delete();
	}

	if(isdefined(self.var_10E4C))
	{
		self.var_10E4C destroy();
	}

	scripts\mp\_utility::func_D915("killstreak ended - minijackal",param_00);
	self delete();
	level.var_B7AD = scripts\common\utility::func_22BC(level.var_B7AD);
}

//Function Number: 25
func_B95E(param_00)
{
	param_00 endon("disconnect");
	level endon("game_ended");
	self endon("minijackal_end");
	for(;;)
	{
		self waittill("spaceship_collision",var_01,var_02,var_03,var_04);
		var_05 = param_00 getnormalizedmovement();
		var_06 = var_05[0] + 1 / 2;
		var_07 = 16 + 19 * var_06;
		var_08 = var_02 - 4 / var_07 - 4;
		if(var_08 > 1)
		{
			var_08 = 1;
		}
		else if(var_08 < 0)
		{
			var_08 = 0;
		}

		var_09 = var_08 * var_01;
		if(var_09 > 0)
		{
			param_00 earthquakeforplayer(var_09,0.5,self.origin,100);
			var_0A = 10 + 240 * var_09;
			if(self.var_EDD7 - var_0A < 150)
			{
				var_0A = self.var_EDD7 - 150;
			}
		}
	}
}

//Function Number: 26
func_B9A9(param_00)
{
	self.var_222 endon("disconnect");
	level endon("game_ended");
	self endon("host_migration_lifetime_update");
	self endon("minijackal_end");
	thread scripts\mp\killstreaks\_utility::watchhostmigrationlifetime("minijackal_end",param_00,::func_B9A9);
	scripts\mp\_hostmigration::func_13708(param_00);
	self.var_222 scripts\mp\_utility::func_D4B6("minijackal_timeout",undefined,undefined,self.var_222.origin);
	self notify("minijackal_end");
}

//Function Number: 27
func_B968(param_00)
{
	param_00 endon("disconnect");
	level endon("game_ended");
	self endon("minijackal_end");
	thread scripts\mp\killstreaks\_killstreaks::func_1CA5("minijackal_end");
	self waittill("killstreakExit");
	self notify("minijackal_end");
}

//Function Number: 28
func_B963(param_00)
{
	level endon("game_ended");
	self endon("minijackal_end");
	param_00 scripts\common\utility::waittill_any_3("joined_team","disconnect","joined_spectators");
	self notify("minijackal_end");
}

//Function Number: 29
func_B969(param_00)
{
	level endon("game_ended");
	self endon("minijackal_end");
	for(;;)
	{
		self waittill("emp_damage",var_01,var_02,var_03,var_04,var_05);
		scripts\mp\killstreaks\_utility::dodamagetokillstreak(100,var_01,var_01,self.team,var_03,var_05,var_04);
		if(!scripts\mp\_utility::func_9FB3(self.var_55BA))
		{
			thread disable_minijackal(var_02);
		}
	}
}

//Function Number: 30
disable_minijackal(param_00)
{
	level endon("game_ended");
	self endon("minijackal_end");
	self.var_55BA = 1;
	self setscriptablepartstate("team_light","neutral",0);
	playfxontag(scripts\common\utility::getfx("emp_stun"),self,"tag_origin");
	scripts\mp\_hostmigration::func_13708(param_00);
	self setscriptablepartstate("team_light","idle",0);
	stopfxontag(scripts\common\utility::getfx("emp_stun"),self,"tag_origin");
	self.var_55BA = undefined;
}

//Function Number: 31
func_C77B(param_00)
{
	param_00 endon("disconnect");
	level endon("game_ended");
	self endon("minijackal_end");
	scripts\mp\_hostmigration::func_13708(1);
	var_01 = scripts\mp\_utility::func_C794(param_00,"cyan",param_00,0,0,"killstreak");
	thread func_E066(var_01,param_00);
}

//Function Number: 32
func_E066(param_00,param_01,param_02)
{
	if(isdefined(param_01))
	{
		param_01 endon("disconnect");
	}

	level endon("game_ended");
	var_03 = ["leave","death"];
	if(isdefined(param_02))
	{
		scripts\common\utility::func_1372F(var_03,param_02);
	}
	else
	{
		scripts\common\utility::func_13731(var_03);
	}

	if(isdefined(param_01))
	{
		scripts\mp\_utility::func_C78F(param_00,param_01);
	}
}

//Function Number: 33
func_B7AC(param_00)
{
	scripts\mp\_utility::func_FB09(param_00);
}

//Function Number: 34
func_B7AB()
{
	if(isdefined(self))
	{
		scripts\mp\_utility::func_41E9();
	}
}

//Function Number: 35
func_6C9B(param_00,param_01,param_02)
{
	var_03 = anglestoforward(self.angles);
	var_04 = anglestoright(self.angles);
	var_05 = self geteye();
	var_06 = var_05 + (0,0,param_01);
	var_07 = var_06 + param_00 * var_03;
	if(func_3DCF(var_05,var_07,param_02))
	{
		return var_07;
	}

	var_07 = var_06 - param_00 * var_03;
	if(func_3DCF(var_05,var_07,param_02))
	{
		return var_07;
	}

	var_07 = var_07 + param_00 * var_04;
	if(func_3DCF(var_05,var_07,param_02))
	{
		return var_07;
	}

	var_07 = var_06 - param_00 * var_04;
	if(func_3DCF(var_05,var_07,param_02))
	{
		return var_07;
	}

	var_07 = var_06;
	if(func_3DCF(var_05,var_07,param_02))
	{
		return var_07;
	}

	scripts\common\utility::func_136F7();
	var_07 = var_06 + 0.707 * param_00 * var_03 + var_04;
	if(func_3DCF(var_05,var_07,param_02))
	{
		return var_07;
	}

	var_07 = var_06 + 0.707 * param_00 * var_03 - var_04;
	if(func_3DCF(var_05,var_07,param_02))
	{
		return var_07;
	}

	var_07 = var_06 + 0.707 * param_00 * var_04 - var_03;
	if(func_3DCF(var_05,var_07,param_02))
	{
		return var_07;
	}

	var_07 = var_06 + 0.707 * param_00 * -1 * var_03 - var_04;
	if(func_3DCF(var_05,var_07,param_02))
	{
		return var_07;
	}

	return undefined;
}

//Function Number: 36
func_3DCF(param_00,param_01,param_02)
{
	var_03 = 0;
	if(capsuletracepassed(param_01,param_02,param_02 * 2 + 0.01,undefined,1,1))
	{
		var_04 = [self];
		var_05 = physics_createcontents(["physicscontents_solid","physicscontents_glass","physicscontents_vehicleclip","physicscontents_missileclip","physicscontents_clipshot"]);
		var_06 = function_0287(param_00,param_01,var_05,var_04,0,"physicsquery_closest");
		if(var_06.size == 0)
		{
			var_03 = 1;
		}
	}

	return var_03;
}

//Function Number: 37
func_5119(param_00)
{
	param_00 endon("disconnect");
	level endon("game_ended");
	self endon("minijackal_end");
	self.var_C7FF = function_01E1(level._effect["thor_fisheye"],param_00 geteye(),param_00);
	triggerfx(self.var_C7FF);
	self.var_C7FF method_82EC();
	thread killfxongameend(self.var_C7FF);
}

//Function Number: 38
killfxongameend(param_00)
{
	self endon("minijackal_end");
	level waittill("game_ended");
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}