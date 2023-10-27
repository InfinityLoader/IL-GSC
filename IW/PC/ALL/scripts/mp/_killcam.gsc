/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_killcam.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 26
 * Decompile Time: 1061 ms
 * Timestamp: 10/27/2023 12:20:43 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_A636 = scripts\mp\_tweakables::func_81E7("game","allowkillcam");
	level.var_A63F = [];
	var_00 = 0;
	for(;;)
	{
		var_01 = tablelookupbyrow("mp/miscKillcamItems.csv",var_00,0);
		if(!isdefined(var_01) || var_01 == "")
		{
			break;
		}

		var_01 = int(var_01);
		var_02 = tablelookupbyrow("mp/miscKillcamItems.csv",var_00,1);
		if(!isdefined(var_02) || var_02 == "")
		{
			break;
		}

		level.var_A63F[var_02] = var_01;
		var_00++;
	}
}

//Function Number: 2
func_F68F(param_00,param_01,param_02)
{
	self setclientomnvar("cam_scene_name",param_00);
	self setclientomnvar("cam_scene_lead",param_01);
	self setclientomnvar("cam_scene_support",param_02);
}

//Function Number: 3
func_7F32(param_00,param_01,param_02)
{
	if(!isdefined(param_00) || !isdefined(param_01) || param_00 == param_01 && !isagent(param_00))
	{
		return undefined;
	}

	if(scripts\mp\_utility::func_9FB3(param_01.israllytrap))
	{
		return param_01.var_A63A;
	}

	switch(param_02)
	{
		case "hashima_missiles_mp":
		case "sentry_shock_grenade_mp":
		case "jackal_fast_cannon_mp":
		case "sentry_shock_missile_mp":
		case "bombproj_mp":
		case "sentry_shock_mp":
		case "heli_pilot_turret_mp":
		case "iw7_c8landing_mp":
		case "super_trophy_mp":
		case "micro_turret_gun_mp":
		case "bouncingbetty_mp":
		case "player_trophy_system_mp":
		case "trophy_mp":
		case "power_exploding_drone_mp":
		case "trip_mine_mp":
		case "bomb_site_mp":
			return scripts\common\utility::func_116D7(isdefined(param_01.var_A63A),param_01.var_A63A,param_01);

		case "remote_tank_projectile_mp":
		case "jackal_turret_mp":
		case "hind_missile_mp":
		case "hind_bomb_mp":
		case "aamissile_projectile_mp":
		case "jackal_cannon_mp":
			if(isdefined(param_01.var_131D8) && isdefined(param_01.var_131D8.var_A63A))
			{
				return param_01.var_131D8.var_A63A;
			}
			else if(isdefined(param_01.var_131D8))
			{
				return param_01.var_131D8;
			}
			break;

		case "iw7_minigun_c8_mp":
		case "iw7_chargeshot_c8_mp":
		case "iw7_c8offhandshield_mp":
			if(isdefined(param_00) && isdefined(param_00.var_4BE1) && param_00.var_4BE1 == "MANUAL")
			{
				return undefined;
			}
			break;

		case "ball_drone_projectile_mp":
		case "ball_drone_gun_mp":
			if(isplayer(param_00) && isdefined(param_00.var_27D3) && isdefined(param_00.var_27D3.var_129B9) && isdefined(param_00.var_27D3.var_129B9.var_A63A))
			{
				return param_00.var_27D3.var_129B9.var_A63A;
			}
			break;

		case "shockproj_mp":
			if(isdefined(param_00.var_B7AA.var_A63A))
			{
				return param_00.var_B7AA.var_A63A;
			}
			break;

		case "artillery_mp":
		case "none":
			if((isdefined(param_01.var_336) && param_01.var_336 == "care_package") || isdefined(param_01.var_A63A) && param_01.classname == "script_brushmodel" || param_01.classname == "trigger_multiple" || param_01.classname == "script_model")
			{
				return param_01.var_A63A;
			}
			break;

		case "switch_blade_child_mp":
		case "drone_hive_projectile_mp":
			if(isdefined(param_00.extraeffectkillcam))
			{
				return param_00.extraeffectkillcam;
			}
			else
			{
				return undefined;
			}
	
			break;

		case "alt_iw7_venomx_mp+venomxalt_burst":
		case "remote_turret_mp":
		case "ugv_turret_mp":
		case "remotemissile_projectile_mp":
		case "osprey_player_minigun_mp":
		case "minijackal_assault_mp":
		case "minijackal_strike_mp":
		case "venomproj_mp":
		case "iw7_venomx_mp+venomxalt_burst":
			return undefined;
	}

	if(scripts\common\utility::func_9DC1(param_02) || scripts\mp\_utility::func_9D6E(param_02))
	{
		if(isdefined(param_01.var_A63A) && !param_00 scripts\mp\_utility::func_24ED())
		{
			return param_01.var_A63A;
		}
		else
		{
			return undefined;
		}
	}

	return param_01;
}

//Function Number: 4
func_F76C(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	param_05.var_37CC = "unknown";
	if(isdefined(param_01) && isdefined(param_01.agent_type))
	{
		if(param_01.agent_type == "dog" || param_01.agent_type == "wolf")
		{
			func_F68F("killcam_dog",param_00 getentitynumber(),param_03 getentitynumber());
			param_05.var_37CC = "killcam_dog";
		}
		else if(param_01.agent_type == "remote_c8")
		{
			func_F68F("killcam_rc8",param_00 getentitynumber(),param_03 getentitynumber());
			param_05.var_37CC = "killcam_rc8";
		}
		else
		{
			func_F68F("killcam_agent",param_00 getentitynumber(),param_03 getentitynumber());
			param_05.var_37CC = "killcam_agent";
		}

		return 1;
	}
	else if(isdefined(param_06) && param_06 == "nuke_mp")
	{
		func_F68F("killcam_nuke",param_03 getentitynumber(),param_03 getentitynumber());
		param_05.var_37CC = "killcam_nuke";
		return 1;
	}
	else if(param_04 > 0)
	{
		func_F68F("unknown",-1,-1);
		return 0;
	}
	else
	{
		func_F68F("unknown",-1,-1);
		return 0;
	}

	return 0;
}

//Function Number: 5
func_127CF(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = param_05 + param_06;
	if(isdefined(param_08) && var_09 > param_08)
	{
		if(param_08 < 2)
		{
			return;
		}

		if(param_08 - param_05 >= 1)
		{
			param_06 = param_08 - param_05;
		}
		else
		{
			param_06 = 1;
			param_05 = param_08 - 1;
		}

		var_09 = param_05 + param_06;
	}

	var_0A = param_05 + param_07;
	if(isdefined(param_01) && isdefined(param_01.var_A9F6))
	{
		var_0B = param_01.var_A9F6;
	}
	else
	{
		var_0B = param_03.var_A9F6;
		if(isdefined(param_02.var_4E72))
		{
			if(gettime() - param_02.var_4E72 < param_06 * 1000)
			{
				param_06 = 1;
				param_06 = param_06 - 0.05;
				var_09 = param_05 + param_06;
			}
		}
	}

	var_0C = gettime() - var_0B / 1000;
	if(var_0A > var_0C && var_0C > param_07)
	{
		var_0D = var_0C - param_07;
		if(param_05 > var_0D)
		{
			param_05 = var_0D;
			var_09 = param_05 + param_06;
			var_0A = param_05 + param_07;
		}
	}

	var_0E = spawnstruct();
	var_0E.var_37F1 = param_05;
	var_0E.var_D6F8 = param_06;
	var_0E.var_A63E = var_09;
	var_0E.var_A640 = var_0A;
	return var_0E;
}

//Function Number: 6
func_D83E(param_00,param_01)
{
	if(isdefined(param_01) && !isagent(param_01))
	{
		if(isdefined(self.var_4004))
		{
			var_02 = spawnstruct();
			scripts\mp\_playerlogic::func_806C(var_02,self.var_4004);
			scripts\mp\_playerlogic::func_AEAD(var_02,1);
		}

		self method_81E6(param_01);
	}
}

//Function Number: 7
func_A636(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D,param_0E,param_0F,param_10)
{
	self endon("disconnect");
	self endon("spawned");
	level endon("game_ended");
	if(level.var_10130)
	{
		function_02A9("atmosphere","killcam",0.1);
		foreach(var_12 in level.players)
		{
			self playlocalsound("final_killcam_in");
			self method_82C2("killcam","mix");
		}
	}

	if(param_02 < 0 || !isdefined(param_0C))
	{
		return;
	}

	level.var_C23C++;
	var_14 = 0.05 * level.var_C23C - 1;
	level.var_B4A7 = var_14;
	if(level.var_C23C > 1)
	{
		wait(var_14);
	}

	wait(0.05);
	level.var_C23C--;
	if(getdvar("scr_killcam_time") == "")
	{
		if(param_07 == "artillery_mp" || param_07 == "stealth_bomb_mp" || param_07 == "warhawk_mortar_mp")
		{
			var_15 = gettime() - param_04 / 1000 - param_08 - 0.1;
		}
		else if(param_08 == "remote_mortar_missile_mp")
		{
			var_15 = 6.5;
		}
		else if(level.var_10130)
		{
			var_15 = 4 + level.var_B4A7 - var_15;
		}
		else if(param_08 == "apache_minigun_mp")
		{
			var_15 = 3;
		}
		else if(param_08 == "javelin_mp")
		{
			var_15 = 8;
		}
		else if(param_08 == "iw7_niagara_mp")
		{
			var_15 = 5;
		}
		else if(issubstr(param_08,"remotemissile_"))
		{
			var_15 = 5;
		}
		else if(isdefined(param_01.var_F26E) && param_01.var_F26E == "multiturret")
		{
			var_15 = 2;
		}
		else if(!param_0B || param_0B > 5)
		{
			var_15 = 5;
		}
		else if(param_08 == "frag_grenade_mp" || param_08 == "frag_grenade_short_mp" || param_08 == "semtex_mp" || param_08 == "semtexproj_mp" || param_08 == "mortar_shell__mp" || param_08 == "cluster_grenade_mp")
		{
			var_15 = 4.25;
		}
		else
		{
			var_15 = 2.5;
		}
	}
	else
	{
		var_15 = getdvarfloat("scr_killcam_time");
	}

	if(isdefined(param_0B))
	{
		if(var_15 > param_0B)
		{
			var_15 = param_0B;
		}

		if(var_15 < 0.05)
		{
			var_15 = 0.05;
		}
	}

	if(getdvar("scr_killcam_posttime") == "")
	{
		if(isdefined(param_00) && param_00 == param_0C)
		{
			var_16 = 3.5;
		}
		else
		{
			var_16 = 2;
		}
	}
	else
	{
		var_16 = getdvarfloat("scr_killcam_posttime");
		if(var_16 < 0.05)
		{
			var_16 = 0.05;
		}
	}

	if(param_02 < 0 || !isdefined(param_0C))
	{
		return;
	}

	var_17 = func_127CF(param_00,param_01,param_0C,param_0D,param_03,var_15,var_16,param_08,param_0B);
	if(!isdefined(var_17))
	{
		return;
	}

	self setclientomnvar("ui_killcam_end_milliseconds",0);
	if(level.var_10130)
	{
		self setclientomnvar("post_game_state",3);
	}

	if(isplayer(param_0C))
	{
		self setclientomnvar("ui_killcam_killedby_id",param_0C getentitynumber());
		self setclientomnvar("ui_killcam_victim_id",param_0D getentitynumber());
		self method_81E6(param_0C);
	}

	if(scripts\mp\_utility::func_9E6C(param_07))
	{
		func_F76E(param_07,param_10);
	}
	else
	{
		scripts\mp\perks\_perks::func_F7C5("ui_killcam_killedby_perk",param_0F);
	}

	var_18 = getdvarint("scr_player_forcerespawn");
	if((param_0A && !level.var_7669) || isdefined(self) && isdefined(self.var_28CC) && !level.var_7669 || var_18 == 0 && !level.var_7669)
	{
		self setclientomnvar("ui_killcam_text","skip");
	}
	else if(!level.var_7669)
	{
		self setclientomnvar("ui_killcam_text","respawn");
	}
	else
	{
		self setclientomnvar("ui_killcam_text","none");
	}

	var_19 = gettime();
	self notify("begin_killcam",var_19);
	scripts\mp\_utility::func_12F19("spectator");
	self.var_2B0 = 1;
	if(isagent(param_0C) || isagent(param_00))
	{
		param_02 = param_0D getentitynumber();
		param_09 = param_09 - 25;
	}

	self.var_140 = param_02;
	self.var_1A9 = -1;
	var_1A = func_F76C(param_00,param_01,param_02,param_0D,param_03,var_17,param_07);
	if(!var_1A)
	{
		thread func_F76B(param_03,var_17.var_A640,param_04,param_05,param_06);
	}

	self.var_4A = var_17.var_A640;
	self.var_A63E = var_17.var_A63E;
	self.var_252 = param_09;
	self allowspectateteam("allies",1);
	self allowspectateteam("axis",1);
	self allowspectateteam("freelook",1);
	self allowspectateteam("none",1);
	if(level.multiteambased)
	{
		foreach(var_1C in level.teamnamelist)
		{
			self allowspectateteam(var_1C,1);
		}
	}

	thread func_6315();
	wait(0.05);
	if(!isdefined(self))
	{
		return;
	}

	if(self.var_4A < var_17.var_A640)
	{
		var_1E = var_17.var_A640 - self.var_4A;
		if(game["truncated_killcams"] < 32)
		{
			game["truncated_killcams"]++;
		}
	}

	var_17.var_37F1 = self.var_4A - 0.05 - param_08;
	var_17.var_A63E = var_17.var_37F1 + var_17.var_D6F8;
	self.var_A63E = var_17.var_A63E;
	if(var_17.var_37F1 <= 0)
	{
		scripts\mp\_utility::func_12F19("dead");
		scripts\mp\_utility::func_41BF();
		self notify("killcam_ended");
		return;
	}

	var_1F = level.var_10130;
	self setclientomnvar("ui_killcam_end_milliseconds",int(var_17.var_A63E * 1000) + gettime());
	if(var_1F)
	{
		self setclientomnvar("ui_killcam_victim_or_attacker",1);
	}

	if(var_1F)
	{
		thread scripts\mp\_final_killcam::func_5854(var_17,self.var_1A9,param_0C,param_0D,param_0E);
	}

	self.var_A636 = 1;
	if(isdefined(self.var_28CC) && !level.var_7669)
	{
		self.var_28CD = gettime();
	}

	thread func_10855();
	if(!level.var_10130)
	{
		thread func_13715(param_0A);
	}
	else
	{
		self notify("showing_final_killcam");
	}

	thread func_635D();
	func_13836();
	if(level.var_10130)
	{
		thread scripts\mp\_playerlogic::func_10857();
		return;
	}

	thread func_A639(1);
}

//Function Number: 8
func_F770(param_00,param_01,param_02)
{
	var_03 = getweaponbasename(param_00);
	if(!isdefined(var_03) || var_03 == "none")
	{
		func_41BD();
		return;
	}

	var_04 = scripts\mp\_utility::func_7E9D(var_03);
	if(isdefined(scripts\mp\_supers::func_7F0D(var_03)))
	{
		func_F772(var_03);
		return;
	}

	if(isdefined(var_04) && var_04 == "lethal" || var_04 == "tactical")
	{
		func_F771(var_03);
		return;
	}

	if(isdefined(level.var_A63F[var_03]))
	{
		func_F76F(level.var_A63F[var_03]);
		return;
	}

	func_F773(param_00,param_02);
}

//Function Number: 9
func_13836()
{
	self endon("abort_killcam");
	if(level.var_10130)
	{
		thread scripts\mp\_utility::func_F8A0(1,self.var_A63E - 0.5);
	}

	wait(self.var_A63E - 0.05);
	if(level.var_10130)
	{
		function_02A9("atmosphere","",0.5);
		self playlocalsound("final_killcam_out");
		self method_8070(4);
	}
}

//Function Number: 10
func_F76B(param_00,param_01,param_02,param_03,param_04)
{
	self endon("disconnect");
	self endon("killcam_ended");
	var_05 = gettime() - param_01 * 1000;
	if(param_02 > var_05)
	{
		wait(0.05);
		param_01 = self.var_4A;
		var_05 = gettime() - param_01 * 1000;
		if(param_02 > var_05)
		{
			wait(param_02 - var_05 / 1000);
		}
	}

	self.var_1A9 = param_00;
	if(isdefined(param_03))
	{
		self.var_1AA = param_03;
	}

	if(isdefined(param_04))
	{
		self method_85C4(param_04);
	}
}

//Function Number: 11
func_13715(param_00)
{
	self endon("disconnect");
	self endon("killcam_ended");
	if(!isai(self))
	{
		self notifyonplayercommand("kc_respawn","+usereload");
		self notifyonplayercommand("kc_respawn","+activate");
		if(scripts\mp\killstreaks\_orbital_deployment::func_D39C("orbital_deployment"))
		{
			thread func_1CA0(param_00);
		}

		self waittill("kc_respawn");
		self.var_3881 = 1;
		if(param_00 <= 0)
		{
			scripts\mp\_utility::clearlowermessage("kc_info");
		}

		self notify("abort_killcam");
	}
}

//Function Number: 12
func_1CA0(param_00)
{
	self notifyonplayercommand("orbital_deployment_action","+attack");
	self notifyonplayercommand("orbital_deployment_action","+attack_akimbo_accessible");
	self setclientomnvar("ui_orbital_deployment_killcam_text",1);
	var_01 = scripts\common\utility::func_13734("orbital_deployment_action","spawned_player");
	if(var_01 == "spawned_player")
	{
		self setclientomnvar("ui_orbital_deployment_killcam_text",0);
		return;
	}

	self.var_3881 = 1;
	if(param_00 <= 0)
	{
		scripts\mp\_utility::clearlowermessage("kc_info");
	}

	self notify("abort_killcam");
	self waittill("spawned_player");
	self setclientomnvar("ui_orbital_deployment_killcam_text",0);
	var_02 = scripts\mp\killstreaks\_killstreaks::func_8207("orbital_deployment");
	if(isdefined(var_02))
	{
		var_03 = scripts\mp\killstreaks\_killstreaks::func_7F45(var_02);
		var_03.var_98F2 = 1;
		scripts\mp\killstreaks\_killstreaks::func_A69A(var_03);
	}
}

//Function Number: 13
func_635D()
{
	self endon("disconnect");
	self endon("killcam_ended");
	for(;;)
	{
		if(self.var_4A <= 0)
		{
			break;
		}

		wait(0.05);
	}

	self notify("abort_killcam");
}

//Function Number: 14
func_10855()
{
	self endon("disconnect");
	self endon("killcam_ended");
	self waittill("spawned");
	thread func_A639(0);
}

//Function Number: 15
func_6315()
{
	self endon("disconnect");
	self endon("killcam_ended");
	level waittill("game_ended");
	thread func_A639(1);
}

//Function Number: 16
clearkillcamomnvars()
{
	func_41BE();
	self setclientomnvar("ui_killcam_end_milliseconds",0);
	self setclientomnvar("ui_killcam_killedby_id",-1);
	self setclientomnvar("ui_killcam_victim_id",-1);
	self setclientomnvar("ui_killcam_killedby_loot_variant_id",-1);
	self setclientomnvar("ui_killcam_killedby_weapon_rarity",-1);
	func_41BD();
	for(var_00 = 0;var_00 < 6;var_00++)
	{
		self setclientomnvar("ui_killcam_killedby_perk" + var_00,-1);
	}
}

//Function Number: 17
func_A639(param_00)
{
	clearkillcamomnvars();
	if(level.var_10130)
	{
		setomnvarforallclients("post_game_state",1);
	}

	self.var_A636 = undefined;
	var_01 = level.var_10130;
	if(!var_01)
	{
		func_F68F("unknown",-1,-1);
	}

	if(!level.var_7669)
	{
		scripts\mp\_utility::clearlowermessage("kc_info");
	}

	thread scripts\mp\_spectating::func_F857();
	self notify("killcam_ended");
	if(!param_00)
	{
		return;
	}

	scripts\mp\_utility::func_12F19("dead");
	scripts\mp\_utility::func_41BF();
}

//Function Number: 18
clearlootweaponomnvars()
{
	self setclientomnvar("ui_killcam_killedby_loot_variant_id",-1);
	self setclientomnvar("ui_killcam_killedby_weapon_rarity",-1);
}

//Function Number: 19
func_41BE()
{
	self setclientomnvar("ui_killcam_killedby_item_type",-1);
	self setclientomnvar("ui_killcam_killedby_item_id",-1);
}

//Function Number: 20
func_F76D(param_00,param_01)
{
	self setclientomnvar("ui_killcam_killedby_item_type",param_00);
	self setclientomnvar("ui_killcam_killedby_item_id",param_01);
}

//Function Number: 21
func_F773(param_00,param_01)
{
	param_00 = scripts\mp\_utility::func_13CA1(param_00,param_01);
	var_02 = scripts\mp\_utility::func_8234(param_00);
	var_03 = tablelookuprownum("mp/statsTable.csv",4,var_02);
	if(!isdefined(var_03) || var_03 < 0)
	{
		func_F76D(-1,-1);
		return;
	}

	var_04 = scripts\mp\_loot::func_7F82(param_00);
	if(isdefined(var_04))
	{
		self setclientomnvar("ui_killcam_killedby_loot_variant_id",var_04.var_1318B);
		self setclientomnvar("ui_killcam_killedby_weapon_rarity",var_04.var_DB52 - 1);
	}
	else
	{
		self setclientomnvar("ui_killcam_killedby_loot_variant_id",-1);
		self setclientomnvar("ui_killcam_killedby_weapon_rarity",-1);
	}

	self setclientomnvar("ui_killcam_killedby_weapon_rarity_notify",gettime());
	func_F76D(0,var_03);
	if(var_02 != "iw7_knife")
	{
		var_05 = function_00E3(param_00);
		if(!isdefined(var_05))
		{
			var_05 = [];
		}

		var_06 = 0;
		for(var_07 = 0;var_07 < var_05.size;var_07++)
		{
			var_08 = var_05[var_07];
			var_09 = scripts\mp\_utility::func_2494(var_08);
			if(scripts\mp\_weapons::func_9F3C(var_02,var_09))
			{
				if(var_06 >= 6)
				{
					break;
				}

				var_0A = tablelookuprownum("mp/attachmentTable.csv",4,var_08);
				self setclientomnvar("ui_killcam_killedby_attachment" + var_06 + 1,var_0A);
				var_06++;
			}
		}

		for(var_07 = var_06;var_07 < 6;var_07++)
		{
			self setclientomnvar("ui_killcam_killedby_attachment" + var_07 + 1,-1);
		}
	}
}

//Function Number: 22
func_F772(param_00)
{
	var_01 = scripts\mp\_supers::func_7F0D(param_00);
	func_F76D(2,var_01);
	clearlootweaponomnvars();
	func_41BD();
}

//Function Number: 23
func_F76E(param_00,param_01)
{
	var_02 = scripts\mp\_utility::func_7F44(level.var_A6C5[param_00]);
	if(isdefined(param_01))
	{
		var_02 = param_01.var_92B8;
		var_03 = param_01.rarity;
		self setclientomnvar("ui_killcam_killedby_item_type",1);
		self setclientomnvar("ui_killcam_killedby_loot_variant_id",var_02);
		self setclientomnvar("ui_killcam_killedby_weapon_rarity",var_03 - 1);
	}
	else
	{
		func_F76D(1,var_02);
		clearlootweaponomnvars();
	}

	func_41BD();
}

//Function Number: 24
func_F771(param_00)
{
	var_01 = level.var_D7A4[param_00];
	var_02 = level.var_D782[var_01].var_92B8;
	func_F76D(3,var_02);
	clearlootweaponomnvars();
	func_41BD();
}

//Function Number: 25
func_F76F(param_00)
{
	func_F76D(4,param_00);
	clearlootweaponomnvars();
	func_41BD();
}

//Function Number: 26
func_41BD()
{
	for(var_00 = 0;var_00 < 6;var_00++)
	{
		self setclientomnvar("ui_killcam_killedby_attachment" + var_00 + 1,-1);
	}
}