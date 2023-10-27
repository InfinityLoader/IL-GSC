/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\undead.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 54
 * Decompile Time: 984 ms
 * Timestamp: 10/27/2023 3:11:54 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	if(getdvar("1673") == "mp_background")
	{
		return;
	}

	setdvarifuninitialized("spv_enableHPBroadcasterMesh",1);
	setdvarifuninitialized("spv_undead_alternate_scoring",0);
	if(getdvarint("spv_undead_alternate_scoring",0) == 1)
	{
		setdvar("scr_undead_scorelimit",100);
	}

	maps\mp\gametypes\_globallogic::func_D5();
	lib_01DD::func_8A0C();
	maps\mp\gametypes\_globallogic::func_8A0C();
	thread maps/mp/_zombie_mp::func_D5();
	if(isusingmatchrulesdata())
	{
		level.var_5300 = ::func_5300;
		[[ level.var_5300 ]]();
		level thread maps\mp\_utility::func_7C13();
	}
	else
	{
		maps\mp\_utility::func_7BFA(level.var_3FDC,30);
		maps\mp\_utility::func_7BF9(level.var_3FDC,300);
		maps\mp\_utility::func_7BF7(level.var_3FDC,1);
		maps\mp\_utility::func_7C04(level.var_3FDC,1);
		maps\mp\_utility::func_7BF1(level.var_3FDC,0);
		maps\mp\_utility::func_7BE5(level.var_3FDC,0);
		level.var_6031 = 0;
		level.var_6035 = 0;
	}

	setdvarifuninitialized("spv_tesla_mp_active",0);
	maps\mp\_utility::func_873B(1);
	level.var_7A62 = maps\mp\_utility::func_4529("scr_hp_radom_selection",0);
	level.var_4F04 = 0;
	level.var_ACA0 = 60;
	level.var_530D = maps\mp\_utility::func_4529("scr_hp_zone_delay",0);
	level.var_73C0 = 6;
	level.var_80AD = 0;
	level.var_6BAF = ::func_6BAF;
	level.var_6B7B = ::func_6B7B;
	level.var_6B86 = ::func_6B86;
	level.var_6BA7 = ::func_6BA7;
	level.valid_spawn_viewer = ::valid_spawn_viewer;
	level.var_2FAB = 1;
	level.disabledivisionstats = 1;
	level.var_2F8B = 1;
	level.disableallplayerstats = 1;
	level.disableweaponchallenges = 0;
	level.disabledivisionchallenges = 0;
	level.disablewinlossstats = 1;
	level.mgnestsdisabled = 1;
	level.var_611["hp_neutral"] = loadfx("vfx/unique/hardpoint_chevron_neutral");
	level.var_611["hp_neutral_vertical"] = loadfx("vfx/unique/hardpoint_chevron_neutral_vertical");
	level.var_611["hp_friendly"] = loadfx("vfx/unique/hardpoint_chevron_friendly");
	level.var_611["hp_friendly_vertical"] = loadfx("vfx/unique/hardpoint_chevron_friendly_vertical");
	level.var_611["hp_enemy"] = loadfx("vfx/unique/hardpoint_chevron_enemy");
	level.var_611["hp_enemy_vertical"] = loadfx("vfx/unique/hardpoint_chevron_enemy_vertical");
	level.var_611["hp_contested"] = loadfx("vfx/unique/hardpoint_chevron_contested");
	level.var_611["hp_contested_vertical"] = loadfx("vfx/unique/hardpoint_chevron_contested_vertical");
	level.var_611["tesla_gun_glow"] = loadfx("vfx/unique/mp_loot_ray_01");
	game["dialog"]["gametype"] = "hpt_intro";
	if(getdvarint("2043"))
	{
		game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
	}

	game["objective_active"] = "mp_hp_new_hardpoint_active";
	game["objective_gained_sound"] = "mp_obj_notify_pos_sml";
	game["objective_lost_sound"] = "mp_obj_notify_neg_sml";
	game["objective_contested_sound"] = "mp_obj_notify_neg_sml";
	level.var_5B91 = 0;
	level.var_ACB9 = [];
}

//Function Number: 2
func_5300()
{
	maps\mp\_utility::func_8653();
	maps\mp\_utility::func_7BF7(level.var_3FDC,1);
	maps\mp\_utility::func_7C04(level.var_3FDC,1);
	maps\mp\_utility::func_7BE5(level.var_3FDC,0);
	setdynamicdvar("scr_hp_radom_selection",getmatchrulesdata("hpData","randomZones"));
	setdynamicdvar("scr_hp_zone_delay",getmatchrulesdata("hpData","initDelay"));
}

//Function Number: 3
func_6B86()
{
	level.var_6947 = &"MP_CONTROL_KOTH";
	level.var_6945 = &"MP_CAPTURE_KOTH";
	level.var_6946 = &"MP_DEFEND_KOTH";
	level.iconneutral = "waypoint_captureneutral";
	level.iconcapture = "waypoint_capture";
	level.icondefend = "waypoint_defend";
	level.iconcontested = "waypoint_contested";
	level.var_5023 = "waypoint_caster_hardpoint";
	level.var_5009 = "waypoint_caster_contested";
	level.var_ACB8 = &"MP_KOTH_AVAILABLE_IN";
	level.var_AC9F = &"MP_KOTH_MOVING_IN";
}

//Function Number: 4
func_A141(param_00,param_01)
{
	game["strings"]["objective_hint_allies"] = param_00;
	game["strings"]["objective_hint_axis"] = param_01;
}

//Function Number: 5
func_A140(param_00)
{
	func_A141(param_00,param_00);
}

//Function Number: 6
func_6BAF()
{
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

	maps\mp\_utility::func_86DC("allies",&"OBJECTIVES_KOTH");
	maps\mp\_utility::func_86DC("axis",&"OBJECTIVES_KOTH");
	if(level.var_910F)
	{
		maps\mp\_utility::func_86DB("allies",&"OBJECTIVES_KOTH");
		maps\mp\_utility::func_86DB("axis",&"OBJECTIVES_KOTH");
	}
	else
	{
		maps\mp\_utility::func_86DB("allies",&"OBJECTIVES_KOTH_SCORE");
		maps\mp\_utility::func_86DB("axis",&"OBJECTIVES_KOTH_SCORE");
	}

	if(level.var_530D)
	{
		func_A140(level.var_6947);
	}
	else
	{
		func_A140(level.var_6945);
	}

	setclientnamemode("auto_change");
	lib_050D::func_10E4();
	var_02[0] = "hp";
	var_02[1] = "blocker_hp";
	maps\mp\gametypes\_gameobjects::func_F9(var_02);
	setomnvar("ui_broadcaster_game_mode_status_1",0);
	setomnvar("ui_broadcaster_game_mode_status_2",0);
	level thread func_6B6C();
	level thread func_8A55();
	level thread func_4B1C();
	level thread func_5E9C();
	var_03 = getentarray("hp_broadcaster_placeholder","targetname");
	foreach(var_05 in var_03)
	{
		var_05 method_805C();
	}

	if(function_037E() && maps\mp\_utility::func_5380() && !isdefined(level.var_501A))
	{
		func_6B86();
	}
}

//Function Number: 7
valid_spawn_viewer(param_00)
{
	return !isdefined(param_00.var_A4B) && param_00.var_A4B == "mp_zombie_generic";
}

//Function Number: 8
func_6BA7()
{
	if(isdefined(self.var_2319) && issubstr(self.var_2319,"custom"))
	{
		return;
	}

	thread func_A6F3();
}

//Function Number: 9
func_A6F3()
{
	level endon("game_ended");
	self endon("disconnect");
	level waittill("player_spawned");
	maps\mp\_utility::func_47A2("specialty_twoprimaries");
	maps\mp\_utility::func_47A2("specialty_overkill");
	maps\mp\_utility::func_47A2("specialty_quickswap");
}

//Function Number: 10
giveundeadloadout()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self notify("giveUndeadLoadout");
	self endon("giveUndeadLoadout");
	waittillframeend;
	var_00 = self.var_835A;
	self takeweapon(var_00);
	self.var_835A = "alt+" + var_00;
	self giveweapon(self.var_835A);
	self switchtoweaponimmediate(self.var_835A);
	self setweaponammostock(var_00,0);
	var_01 = weaponclipsize(self.var_835A);
	var_02 = var_01;
	var_03 = 0;
	if(var_01 > 2)
	{
		var_02 = 6;
	}
	else
	{
		var_03 = 4;
	}

	self method_82FA(self.var_835A,var_02);
	self setweaponammostock(self.var_835A,var_03);
	self switchtoweapon(self.var_7704);
}

//Function Number: 11
spawnzombiesnearhardpointloop(param_00,param_01)
{
	level endon("game_ended");
	level endon("zone_destroyed");
	level endon("zone_moved");
	self notify("spawnZombiesNearHardpointLoop");
	self endon("spawnZombiesNearHardpointLoop");
	while(!level.var_3F9D)
	{
		wait(2);
		maps\mp\gametypes\_hostmigration::func_A782();
		thread spawnzombiesnearhardpoint(param_00,param_01);
	}
}

//Function Number: 12
spawnzombiesnearhardpoint(param_00,param_01)
{
	level endon("game_ended");
	self notify("spawnZombiesNearHardpoint");
	self endon("spawnZombiesNearHardpoint");
	var_02 = getnodesinradiussorted(param_01,600,300,200,"Path");
	if(isdefined(var_02) && var_02.size > 0)
	{
		var_03 = randomint(var_02.size);
		var_04 = var_02[var_03].var_116;
		var_05 = var_02[var_03].var_1D;
		var_06 = getnodesinradiussorted(var_04,200,40,200,"Path");
		var_06 = common_scripts\utility::func_F92(var_06);
		var_07 = "hostile";
		var_08 = 1;
		if(level.zombiearray.size == 0)
		{
			var_08 = 2;
		}

		for(var_09 = 0;var_09 < var_08;var_09++)
		{
			for(var_09 = 0;var_09 < 5;var_09++)
			{
				if(var_09 > 0)
				{
					if(isdefined(var_06) && var_06.size > var_09 + 1)
					{
						maps/mp/_zombie_mp::spawnzombiesforteam(var_06[var_09 - 1],1,var_07);
						lib_0378::func_8D74("aud_zombie_spawn",var_04);
					}
					else
					{
						break;
					}
				}

				wait(0.2);
			}
		}
	}
}

//Function Number: 13
func_6B6C()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.var_3FCC = 0;
		var_00.var_112 = 0;
		var_00.var_9AC5 = [];
		var_00 thread ticket_item_outlined();
		var_00.var_4B1D = [];
		var_00.touchinghardpoint = 0;
		var_00 thread maps\mp\gametypes\_weapons::initteslagun();
	}
}

//Function Number: 14
ticket_item_outlined()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_team");
		func_8A6F();
	}
}

//Function Number: 15
func_4F05()
{
	level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_A190();
	setomnvar("ui_broadcaster_game_mode_status_1",level.var_AC7C.var_3FCA.var_689F["allies"]);
	setomnvar("ui_broadcaster_game_mode_status_2",level.var_AC7C.var_3FCA.var_689F["axis"]);
}

//Function Number: 16
func_8FDD()
{
	func_5A87();
	if(isdefined(level.var_AC7C.broadcastermesh))
	{
		level.var_AC7C.broadcastermesh method_805C();
	}

	if(level.var_7A62)
	{
		level.var_AC7C = func_45B0();
	}
	else
	{
		level.var_AC7C = func_45AF();
	}

	func_8A70();
	func_86D4();
	maps\mp\gametypes\_gamelogic::func_7DFC();
	setgameendtime(gettime() + int(maps\mp\gametypes\_gamelogic::func_46E5()),1);
	maps\mp\_matchdata::func_5E91(game["roundsPlayed"],getteamscore("axis"),getteamscore("allies"));
	game["roundsPlayed"]++;
	level notify("round_switch","next_zone");
	if(isdefined(level.var_AC7C.var_5E5D))
	{
		setomnvar("ui_hardpoint_minimap_location_callout",level.var_AC7C.var_5E5D);
	}

	maps\mp\_utility::func_863E(5,"free");
	maps/mp/_zombie_mp::killallzombies();
}

//Function Number: 17
func_4484()
{
	return level.var_AC7C;
}

//Function Number: 18
func_4F03()
{
	level endon("game_ended");
	level endon("zone_moved");
	level.var_4F04 = gettime();
	var_00 = "none";
	for(;;)
	{
		level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_C30("any");
		level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_8A5A(0);
		level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_8A59(&"MP_CAPTURING_OBJECTIVE");
		level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_8A60("any");
		level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_86CD(1);
		level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_65BF(0);
		level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_1F49(1);
		level.var_AC7C.var_3FCA.var_6BBF = ::func_6BD8;
		var_01 = gettime();
		var_02 = level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_45F7();
		function_00F5("script_mp_hp: gameTime %d, hp_origin %v, owner %s",var_01,level.var_AC7C.var_116,var_02);
		var_03 = level common_scripts\utility::func_A715("zone_captured","zone_destroyed");
		if(var_03 == "zone_destroyed")
		{
			continue;
		}

		var_04 = level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_45F7();
		var_01 = gettime();
		if(isdefined(var_04))
		{
			var_02 = var_04;
		}

		function_00F5("script_mp_hp: gameTime %d, hp_origin %v, owner %s",var_01,level.var_AC7C.var_116,var_02);
		if(var_00 != "none" && var_00 != var_04)
		{
			if(isdefined(game["objectiveFlipCount"]))
			{
				game["objectiveFlipCount"]++;
			}
			else
			{
				game["objectiveFlipCount"] = 1;
			}
		}

		var_00 = var_04;
		if(var_04 == "allies")
		{
			func_A141(level.var_6946,level.var_6945);
		}
		else if(var_04 == "axis")
		{
			func_A141(level.var_6945,level.var_6946);
		}
		else
		{
			func_A141(level.var_6945,level.var_6945);
		}

		level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_C30("none");
		level.var_AC7C.var_3FCA.var_6BBF = undefined;
		level.var_AC7C.var_3FCA.var_6BBD = ::func_6BDB;
		level.var_AC7C.var_3FCA.var_6AD0 = ::func_6BD9;
		level.var_AC7C.var_3FCA.var_6BBB = ::func_6BDA;
		level waittill("zone_destroyed",var_05);
		thread func_3E2D(var_04);
		if(isdefined(var_05))
		{
			level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_86EC(var_05);
			continue;
		}

		level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_86EC("none");
	}
}

//Function Number: 19
func_A11F()
{
	for(;;)
	{
		foreach(var_01 in level.var_744A)
		{
			var_02 = var_01;
			if(!isdefined(var_01.var_1A7) || !isdefined(var_01.var_178))
			{
				continue;
			}

			if(var_01.var_1A7 == "spectator" || var_01.var_178 == "spectator")
			{
				var_02 = var_01 getspectatingplayer();
			}

			if(var_01 method_8436())
			{
				if(var_01.var_1E99.var_A4A8 == "third_person")
				{
					var_01 func_868F(var_01,0);
					continue;
				}
			}

			if(!maps\mp\_utility::func_57A0(var_02))
			{
				var_01 func_868F(var_01,0);
				continue;
			}

			if(var_02.var_9AC5.size == 0)
			{
				var_01 func_868F(var_01,0);
				continue;
			}

			foreach(var_04 in var_02.var_9AC5)
			{
				if(var_04 == level.var_AC7C.var_3FCA.var_9D65)
				{
					var_01 func_868F(var_01,1);
					break;
				}

				var_01 func_868F(var_01,0);
			}
		}

		wait 0.05;
	}
}

//Function Number: 20
func_868F(param_00,param_01)
{
	var_02 = 0;
	if(param_01)
	{
		var_02 = 1;
		if(isdefined(level.var_AC7C.var_3FCA.var_56B7) && level.var_AC7C.var_3FCA.var_56B7)
		{
			var_02 = 2;
		}

		if(!param_00.touchinghardpoint)
		{
			thread maps\mp\_matchdata::func_5E93("hp_enter",param_00.var_116,level.var_AC7C.var_81E1);
			param_00.touchinghardpoint = 1;
		}
	}
	else if(param_00.touchinghardpoint)
	{
		thread maps\mp\_matchdata::func_5E93("hp_exit",param_00.var_116,level.var_AC7C.var_81E1);
		param_00.touchinghardpoint = 0;
	}

	if(var_02 != param_00.var_3FCC)
	{
		param_00 setclientomnvar("ui_hardpoint",var_02);
		param_00.var_3FCC = var_02;
		param_00.var_112 = var_02;
	}
}

//Function Number: 21
func_4B1C()
{
	level endon("game_ended");
	level.var_ACB2 = -100000;
	level.var_AC7C = func_44DE();
	func_8A70();
	setomnvar("ui_hardpoint_minimap_location_callout",level.var_AC7C.var_5E5D);
	var_00 = 1;
	maps\mp\_utility::func_3FA5("prematch_done");
	level childthread func_A11F();
	for(;;)
	{
		maps\mp\_utility::func_74D9("mp_suitcase_pickup");
		maps\mp\_utility::func_3D8C("gamemode_objective");
		level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_86CD(1);
		level.var_AC7C.var_3FCA.var_6BBE = ::func_4F05;
		level.var_ACB2 = gettime();
		if(level.var_530D)
		{
			func_8A63(level.var_AC7C);
			level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_8A60("any");
			func_A140(level.var_6947);
			setomnvar("ui_hardpoint_timer",gettime() + 1000 * level.var_530D);
			wait(level.var_530D);
		}

		if(var_00)
		{
			var_00 = 0;
			wait(5);
			maps\mp\_utility::func_863E(5,"free");
			foreach(var_02 in level.var_744A)
			{
				if(var_02 method_8436() && getdvarint("spv_enableHPBroadcasterMesh") != 0 && isdefined(var_02.var_1E99.var_A4A8) && var_02.var_1E99.var_A4A8 == "third_person")
				{
					if(isdefined(level.var_AC7C.broadcastermesh))
					{
						level.var_AC7C.broadcastermesh showtoclient(var_02);
					}
				}
			}
		}

		waittillframeend;
		func_86D4(level.var_AC7C);
		maps\mp\_utility::func_5C39("hp_online",undefined,"gamemode_objective");
		func_A140(level.var_6945);
		level thread maps\mp\_utility::func_74D9(game["objective_active"]);
		level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_365D();
		level.var_AC7C.var_3FCA.var_1FB6 = 0;
		level.var_AC7C.var_3FCA thread maps\mp\gametypes\_gameobjects::func_9BA8();
		if(level.var_ACA0)
		{
			thread func_64E2(level.var_ACA0);
			setomnvar("ui_hardpoint_timer",gettime() + 1000 * level.var_ACA0);
		}
		else
		{
			level.var_AC9E = 0;
		}

		func_4F03();
		var_04 = level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_45F7();
		level.var_AC7C.var_3FCA.var_5B78 = undefined;
		level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_2F93();
		level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_C30("none");
		level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_86EC("neutral");
		level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_86CD(0);
		level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_65BF(0);
		level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_860A("broadcaster",undefined);
		level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_860E("broadcaster",undefined);
		level notify("zone_reset");
		if(isdefined(level.var_4F01) && level.var_4F01 == 1)
		{
			level waittill("ready_for_next_hp_zone");
		}

		func_8FDD();
		wait(0.5);
		thread func_3E2D(var_04);
		wait(0.5);
	}
}

//Function Number: 22
func_3E2D(param_00)
{
	var_01 = level.var_744A;
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = var_01[var_02];
		if(!isdefined(var_03))
		{
			continue;
		}

		if(var_03.var_12C["team"] == param_00)
		{
			var_03 notify("force_spawn");
			wait(0.1);
		}
	}
}

//Function Number: 23
func_6BD8(param_00)
{
	var_01 = param_00.var_12C["team"];
	var_02 = maps\mp\_utility::func_45DE(var_01);
	var_03 = gettime();
	param_00 method_802B("zone captured");
	level.var_AC7C.var_3FCA.var_56B7 = 0;
	level.var_A239 = 0;
	func_873D(var_01);
	maps\mp\gametypes\_gamelogic::func_6F27();
	setgameendtime(gettime() + int(maps\mp\gametypes\_gamelogic::func_46E5()),1);
	if(!isdefined(self.var_5B78) || self.var_5B78 != var_01)
	{
		var_04 = [];
		var_05 = getarraykeys(self.var_9AC3[var_01]);
		for(var_06 = 0;var_06 < var_05.size;var_06++)
		{
			var_04[var_05[var_06]] = self.var_9AC3[var_01][var_05[var_06]];
		}

		level thread func_4756(var_04,var_03,var_01,self.var_5B78);
		level thread maps\mp\_utility::func_5C39("hp_secured",var_01,"gamemode_objective");
		level thread maps\mp\_utility::func_5C39("hp_lost",var_02,"gamemode_objective");
	}

	level thread maps\mp\_utility::func_74D9(game["objective_gained_sound"],var_01);
	level thread maps\mp\_utility::func_74D9(game["objective_lost_sound"],var_02);
	level.var_4F02 = var_01;
	if(!isdefined(level.var_5B78) || var_01 != level.var_5B78)
	{
		maps\mp\_utility::func_863E(6,var_01,param_00 getentitynumber());
	}

	maps\mp\gametypes\_gameobjects::func_86EC(var_01);
	if(isdefined(self.var_5B78) && self.var_5B78 != var_01)
	{
		for(var_07 = 0;var_07 < level.var_744A.size;var_07++)
		{
			param_00 = level.var_744A[var_07];
			if(param_00.var_12C["team"] == var_01)
			{
				if(isdefined(param_00.var_5BAF) && param_00.var_5BAF + 500 > gettime())
				{
					param_00 maps\mp\gametypes\_missions::func_7750("ch_hp_killedLastContester");
				}
			}
		}
	}

	level thread func_1455(var_01,self.var_5B78);
	level thread spawnzombiesnearhardpointloop(var_01,level.var_AC7C.var_116);
	self.var_1FB6++;
	self.var_5B78 = var_01;
	maps\mp\gametypes\_gameobjects::func_65BF(1);
	level notify("zone_captured");
	level notify("zone_captured" + var_01);
}

//Function Number: 24
func_4756(param_00,param_01,param_02,param_03)
{
	var_04 = getarraykeys(param_00);
	for(var_05 = 0;var_05 < var_04.size;var_05++)
	{
		var_06 = param_00[var_04[var_05]].var_721C;
		var_06 func_A0F0(param_03);
		if(!func_57B8(var_06))
		{
			var_06 maps\mp\gametypes\_missions::func_7750("ch_hp_capturedObjective");
			if(level.var_4F04 + 500 > param_01)
			{
				var_06 maps\mp\gametypes\_missions::func_7750("ch_hp_immediateCapture");
			}

			var_06 thread maps\mp\_events::func_836D(level.var_AC7C.var_81E1);
			var_06 notify("ch_capture",level.var_AC7C);
		}
		else
		{
		}

		wait 0.05;
	}
}

//Function Number: 25
func_6BDB()
{
	level notify("zone_destroyed");
	level.var_4F02 = "neutral";
	level.var_AC7C.var_3FCA.var_56B7 = 0;
	if(self.var_689F["axis"] == 0 && self.var_689F["allies"] == 0)
	{
		level.var_AC7C.var_3FCA.var_A873 = 1;
		func_86D4();
		if(isdefined(level.var_9A13) && level.var_9A13)
		{
			maps\mp\gametypes\_gamelogic::func_7DFC();
			setgameendtime(gettime() + int(maps\mp\gametypes\_gamelogic::func_46E5()),1);
		}
	}
}

//Function Number: 26
func_6BD9()
{
	maps\mp\_utility::func_863E(7,"free");
	var_00 = level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_45F7();
	level.var_AC7C.var_3FCA.var_A86C = 1;
	level.var_AC7C.var_3FCA.var_56B7 = 1;
	func_8654();
	if(isdefined(level.var_9A13) && level.var_9A13)
	{
		maps\mp\gametypes\_gamelogic::func_7DFC();
		setgameendtime(gettime() + int(maps\mp\gametypes\_gamelogic::func_46E5()),1);
	}

	level thread maps\mp\_utility::func_74D9(game["objective_contested_sound"]);
	maps\mp\_utility::func_5C39("hp_contested",undefined,"gamemode_objective");
	var_01 = gettime();
	var_02 = "contested";
	function_00F5("script_mp_hp: gameTime %d, hp_origin %v, owner %s",var_01,level.var_AC7C.var_116,var_02);
}

//Function Number: 27
func_6BDA(param_00)
{
	level.var_AC7C.var_3FCA.var_56B7 = 0;
	func_873D(param_00);
	maps\mp\gametypes\_gamelogic::func_6F27();
	setgameendtime(gettime() + int(maps\mp\gametypes\_gamelogic::func_46E5()),1);
	level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_864E(param_00);
	var_01 = gettime();
	var_02 = param_00;
	function_00F5("script_mp_hp: gameTime %d, hp_origin %v, owner %s",var_01,level.var_AC7C.var_116,var_02);
}

//Function Number: 28
func_86D4(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = level.var_AC7C;
	}

	if(!isdefined(level.var_AC7C) || param_00 == level.var_AC7C)
	{
		thread func_74EF(0);
		setomnvar("ui_hardpoint_status",0);
		thread setbroadcastermesh("neutral");
	}

	param_00.var_3FCA maps\mp\gametypes\_gameobjects::func_860A("friendly",level.iconneutral);
	param_00.var_3FCA maps\mp\gametypes\_gameobjects::func_860E("friendly",level.iconneutral);
	param_00.var_3FCA maps\mp\gametypes\_gameobjects::func_860A("enemy",level.iconneutral);
	param_00.var_3FCA maps\mp\gametypes\_gameobjects::func_860E("enemy",level.iconneutral);
	maps\mp\_utility::func_863F(param_00.var_3FCA,level.iconneutral,0,1);
}

//Function Number: 29
func_8A63(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = level.var_AC7C;
	}

	var_01 = "waypoint_waitfor_flag_neutral";
	param_00.var_3FCA maps\mp\gametypes\_gameobjects::func_860A("friendly",var_01);
	param_00.var_3FCA maps\mp\gametypes\_gameobjects::func_860E("friendly",var_01);
	param_00.var_3FCA maps\mp\gametypes\_gameobjects::func_860A("enemy",var_01);
	param_00.var_3FCA maps\mp\gametypes\_gameobjects::func_860E("enemy",var_01);
	maps\mp\_utility::func_863F(param_00.var_3FCA,var_01,0,1);
}

//Function Number: 30
func_8654()
{
	thread func_74EF(-1);
	thread setbroadcastermesh("contested");
	setomnvar("ui_hardpoint_status",-1);
	level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_860A("friendly",level.iconcontested);
	level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_860E("friendly",level.iconcontested);
	level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_860A("enemy",level.iconcontested);
	level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_860E("enemy",level.iconcontested);
	maps\mp\_utility::func_863F(level.var_AC7C.var_3FCA,level.iconcontested,3,1);
}

//Function Number: 31
func_873D(param_00)
{
	level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_860A("friendly",level.icondefend);
	level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_860E("friendly",level.icondefend);
	level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_860A("enemy",level.iconcapture);
	level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_860E("enemy",level.iconcapture);
	if(param_00 == "allies")
	{
		thread func_74EF(2);
		thread setbroadcastermesh("allies");
		setomnvar("ui_hardpoint_status",2);
		maps\mp\_utility::func_863F(level.var_AC7C.var_3FCA,level.iconcapture,2,1);
		return;
	}

	thread func_74EF(1);
	thread setbroadcastermesh("axis");
	setomnvar("ui_hardpoint_status",1);
	maps\mp\_utility::func_863F(level.var_AC7C.var_3FCA,level.iconcapture,1,1);
}

//Function Number: 32
func_8A70()
{
	if(!isdefined(level.var_AC7C) || !isdefined(level.var_AC7C.var_356F))
	{
		return;
	}

	foreach(var_01 in level.var_744A)
	{
		var_01 func_8A6F();
	}
}

//Function Number: 33
func_8A6F()
{
	if(!isdefined(level.var_AC7C) || !isdefined(level.var_AC7C.var_356F))
	{
		return;
	}

	if(!isdefined(self))
	{
		return;
	}

	if(!isdefined(self.var_1A7))
	{
		return;
	}

	foreach(var_01 in getarraykeys(level.var_AC7C.var_356F))
	{
		foreach(var_03 in level.var_AC7C.var_356F[var_01])
		{
			if(var_01 == self.var_1A7)
			{
				var_03 showtoclient(self);
				continue;
			}

			var_03 hidefromclient(self);
		}
	}

	if(self method_8436() && isdefined(self.var_1E99.var_A4A8) && self.var_1E99.var_A4A8 == "third_person")
	{
		if(isdefined(level.var_AC7C.broadcastermesh) && getdvarint("spv_enableHPBroadcasterMesh") != 0)
		{
			level.var_AC7C.broadcastermesh showtoclient(self);
		}
	}
}

//Function Number: 34
func_5A87()
{
	if(!isdefined(level.var_AC7C) || !isdefined(level.var_AC7C.var_356F))
	{
		return;
	}

	foreach(var_01 in level.var_AC7C.var_356F)
	{
		foreach(var_03 in var_01)
		{
			var_03 method_805C();
		}
	}
}

//Function Number: 35
func_74EF(param_00)
{
	level notify("zoneFxChanged");
	level endon("zoneFxChanged");
	if(!isdefined(level.var_AC7C) || !isdefined(level.var_AC7C.var_356F))
	{
		return;
	}

	foreach(var_02 in getarraykeys(level.var_AC7C.var_356F))
	{
		foreach(var_04 in level.var_AC7C.var_356F[var_02])
		{
			var_05 = isdefined(var_04.var_A419) && var_04.var_A419;
			if(param_00 == 0)
			{
				if(var_05)
				{
					var_04 fxentity_play(common_scripts\utility::func_44F5("hp_neutral_vertical"));
				}
				else
				{
					var_04 fxentity_play(common_scripts\utility::func_44F5("hp_neutral"));
				}

				continue;
			}

			if(param_00 == -1)
			{
				if(var_05)
				{
					var_04 fxentity_play(common_scripts\utility::func_44F5("hp_contested_vertical"));
				}
				else
				{
					var_04 fxentity_play(common_scripts\utility::func_44F5("hp_contested"));
				}

				continue;
			}

			if((param_00 == 1 && var_02 == "allies") || (param_00 == 2 && var_02 == "axis") || var_02 == "spectator" && param_00 == 1)
			{
				if(var_05)
				{
					var_04 fxentity_play(common_scripts\utility::func_44F5("hp_enemy_vertical"));
				}
				else
				{
					var_04 fxentity_play(common_scripts\utility::func_44F5("hp_enemy"));
				}

				continue;
			}

			if((param_00 == 1 && var_02 == "axis") || (param_00 == 2 && var_02 == "allies") || var_02 == "spectator" && param_00 == 2)
			{
				if(var_05)
				{
					var_04 fxentity_play(common_scripts\utility::func_44F5("hp_friendly_vertical"));
					continue;
				}

				var_04 fxentity_play(common_scripts\utility::func_44F5("hp_friendly"));
			}
		}
	}
}

//Function Number: 36
func_64E2(param_00)
{
	level endon("game_ended");
	level endon("zone_reset");
	level.var_ACAF = gettime() + param_00 * 1000;
	level.var_AC9E = 0;
	wait(param_00);
	if(!isdefined(level.var_AC7C.var_3FCA.var_A86C) || level.var_AC7C.var_3FCA.var_A86C == 0)
	{
		if(!isdefined(level.var_AC7C.var_3FCA.var_A873) || level.var_AC7C.var_3FCA.var_A873 == 0)
		{
			var_01 = level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_45F7();
			foreach(var_03 in level.var_744A)
			{
				if(var_03.var_12C["team"] == var_01)
				{
					var_03 maps\mp\gametypes\_missions::func_7750("ch_hp_controlZoneEntirely");
				}
			}
		}
	}

	level.var_AC9E = 1;
	level notify("zone_moved");
}

//Function Number: 37
quicksort_hardpoint_compare(param_00,param_01)
{
	return param_00.var_99DE > param_01.var_99DE;
}

//Function Number: 38
func_1455(param_00,param_01)
{
	level endon("game_ended");
	level endon("zone_destroyed");
	level endon("zone_moved");
	level notify("awardCapturePointsRunning");
	level endon("awardCapturePointsRunning");
	var_02 = 1;
	var_03 = 5;
	var_04 = 1;
	var_05 = 1;
	var_06 = [];
	while(!level.var_3F9D)
	{
		wait(var_02);
		maps\mp\gametypes\_hostmigration::func_A782();
		if(level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_45F7() != "neutral")
		{
			if(!level.var_AC7C.var_3FCA.var_56B7)
			{
				if(level.var_80AD)
				{
					var_05 = level.var_AC7C.var_3FCA.var_689F[param_00];
				}

				if(getdvarint("spv_undead_alternate_scoring",0) == 0)
				{
					maps\mp\gametypes\_gamescore::func_47BD(param_00,var_05,1);
				}

				var_07 = [];
				foreach(var_09 in level.var_744A)
				{
					if(var_09.var_12C["team"] != param_00)
					{
						continue;
					}

					if(var_09 istouching(level.var_AC7C.var_9D5E))
					{
						if(!isdefined(var_09.var_99DE))
						{
							var_09.var_99DE = 0;
						}

						if(!isdefined(var_09.var_4B1D[level.var_AC7C.var_81E1]))
						{
							var_09.var_4B1D[level.var_AC7C.var_81E1] = 0;
						}

						var_09.var_4B1D[level.var_AC7C.var_81E1] = var_09.var_4B1D[level.var_AC7C.var_81E1] + 1;
						var_09.var_99DE = var_09.var_99DE + 1;
						var_09.var_12C["time"] = var_09.var_99DE;
						var_09 maps\mp\_utility::func_867B(var_09.var_12C["time"]);
						if(var_09.var_12C["time"] == 60)
						{
							var_09 lib_0468::func_A22("hordepoint1Min");
						}

						if(isdefined(var_06) && var_06.size > 0 && common_scripts\utility::func_F79(var_06,var_09))
						{
							if(isdefined(var_09.custom_onspawnplayer_func) && var_09.custom_onspawnplayer_func + var_03 * 1000 <= gettime())
							{
								if(var_04)
								{
									var_09 thread maps\mp\_events::func_4C68();
								}

								var_09.custom_onspawnplayer_func = gettime();
							}
						}
						else
						{
							var_09.custom_onspawnplayer_func = gettime() - 1000;
						}

						var_07[var_07.size] = var_09;
					}
				}

				var_06 = var_07;
				if(var_06.size > 0)
				{
					foreach(var_0C in level.zombiearray)
					{
						var_0C maps/mp/_zombie_mp::handlezombieaggro(var_06,::quicksort_hardpoint_compare);
					}
				}
			}
			else
			{
				var_06 = [];
				foreach(var_0C in level.zombiearray)
				{
					var_0C maps/mp/_zombie_mp::handlezombieaggro(level.var_744A,::maps/mp/_zombie_mp::quicksort_hardpoint_dist_compare);
				}
			}

			continue;
		}

		foreach(var_0C in level.zombiearray)
		{
			var_0C maps/mp/_zombie_mp::handlezombieaggro(level.var_744A,::maps/mp/_zombie_mp::quicksort_hardpoint_dist_compare);
		}
	}
}

//Function Number: 39
func_255D(param_00,param_01)
{
	var_02 = param_00.var_81E1;
	var_03 = param_01.var_81E1;
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

//Function Number: 40
func_4749(param_00)
{
	var_01 = getentarray(param_00,"targetname");
	if(!isdefined(var_01))
	{
		return undefined;
	}

	var_02 = 1;
	for(var_03 = var_01.size;var_02;var_03--)
	{
		var_02 = 0;
		for(var_04 = 0;var_04 < var_03 - 1;var_04++)
		{
			if(func_255D(var_01[var_04],var_01[var_04 + 1]))
			{
				var_05 = var_01[var_04];
				var_01[var_04] = var_01[var_04 + 1];
				var_01[var_04 + 1] = var_05;
				var_02 = 1;
			}
		}
	}

	return var_01;
}

//Function Number: 41
func_8A55()
{
	var_00 = func_4749("hp_zone_center");
	var_01 = getentarray("hp_zone_trigger","targetname");
	level.var_ACB3 = func_603B(var_00,var_01);
	level.var_BCF = level.var_ACB3;
	return 1;
}

//Function Number: 42
func_603B(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_03 = 0;
		var_04 = param_00[var_02];
		var_04.var_9D5E = undefined;
		for(var_05 = 0;var_05 < param_01.size;var_05++)
		{
			if(param_01[var_05] method_858B(var_04.var_116))
			{
				if(isdefined(var_04.var_9D5E))
				{
					var_03 = 1;
					break;
				}

				var_04.var_9D5E = param_01[var_05];
				break;
			}
		}

		if(!isdefined(var_04.var_9D5E))
		{
			if(!var_03)
			{
				continue;
			}
		}

		var_04.var_9DC6 = var_04.var_9D5E.var_116;
		var_06 = [];
		var_06[0] = var_04;
		if(isdefined(var_04.var_1A2))
		{
			var_07 = getentarray(var_04.var_1A2,"targetname");
			for(var_05 = 0;var_05 < var_07.size;var_05++)
			{
				if(isdefined(var_07[var_05].var_165) && var_07[var_05].var_165 == "broadcaster_visual")
				{
					var_04.broadcastermesh = var_07[var_05];
					var_07[var_05] method_805C();
					var_07[var_05] method_80B1();
					continue;
				}

				var_06[var_06.size] = var_07[var_05];
			}
		}

		var_08 = [];
		var_08["allies"] = [];
		var_08["axis"] = [];
		var_08["spectator"] = [];
		var_09 = common_scripts\utility::func_46B7(var_04.var_1A2,"targetname");
		foreach(var_0B in var_09)
		{
			var_0C = undefined;
			var_0D = 0;
			if(isdefined(var_0B.var_165) && var_0B.var_165 == "vertical")
			{
				var_0D = 1;
			}

			if(var_0D)
			{
				var_0C = common_scripts\utility::func_44F5("hp_neutral_vertical");
			}
			else
			{
				var_0C = common_scripts\utility::func_44F5("hp_neutral");
			}

			var_0E = anglestoforward(var_0B.var_1D);
			var_0F = anglestoup(var_0B.var_1D);
			var_10 = spawnfx(var_0C,var_0B.var_116,var_0E,var_0F);
			var_11 = spawnfx(var_0C,var_0B.var_116,var_0E,var_0F);
			var_12 = spawnfx(var_0C,var_0B.var_116,var_0E,var_0F);
			if(var_0D)
			{
				var_10.var_A419 = 1;
				var_11.var_A419 = 1;
				var_12.var_A419 = 1;
			}

			var_10 method_805C();
			var_11 method_805C();
			var_08["allies"][var_08["allies"].size] = var_10;
			var_08["axis"][var_08["axis"].size] = var_11;
			var_08["spectator"][var_08["spectator"].size] = var_12;
		}

		var_04.var_356F = var_08;
		var_04.var_3FCA = maps\mp\gametypes\_gameobjects::func_2837("neutral",var_04.var_9D5E,var_06,(0,0,0));
		var_04.var_3FCA maps\mp\gametypes\_gameobjects::func_2F93();
		func_86D4(var_04);
		maps\mp\_utility::func_863F(var_04.var_3FCA,undefined);
		var_04.var_3FCA maps\mp\gametypes\_gameobjects::func_86CD(0);
		var_04.var_9D5E.var_A222 = var_04.var_3FCA;
		var_04.var_3FCA.var_6996["allies"] sethidetrigger(var_04.var_9D5E);
		var_04.var_3FCA.var_6996["axis"] sethidetrigger(var_04.var_9D5E);
		var_04 func_8A33();
		if(isdefined(var_04.var_9D5E.var_165))
		{
			var_04.var_5E5D = int(var_04.var_9D5E.var_165);
			continue;
		}

		var_04.var_5E5D = -1;
	}

	return param_00;
}

//Function Number: 43
func_8A33()
{
	var_00 = lib_050D::func_448A();
	if(var_00.size == 0)
	{
		return;
	}

	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01].var_3046 = distancesquared(var_00[var_01].var_116,self.var_116);
	}

	for(var_01 = 1;var_01 < var_00.size;var_01++)
	{
		var_02 = var_00[var_01];
		for(var_03 = var_01 - 1;var_03 >= 0 && var_02.var_3046 < var_00[var_03].var_3046;var_03--)
		{
			var_00[var_03 + 1] = var_00[var_03];
		}

		var_00[var_03 + 1] = var_02;
	}

	var_04 = [];
	var_05 = [];
	var_06 = [];
	var_07 = [];
	var_08 = var_00.size / 3;
	for(var_01 = 0;var_01 <= var_08;var_01++)
	{
		var_04[var_04.size] = var_00[var_01];
	}

	while(var_01 < var_00.size)
	{
		var_07[var_07.size] = var_00[var_01];
		if(var_01 <= var_08 * 2)
		{
			var_05[var_05.size] = var_00[var_01];
			continue;
		}

		var_06[var_06.size] = var_00[var_01];
		var_01++;
	}

	self.var_3FCA.var_663F = var_04;
	self.var_3FCA.var_6163 = var_05;
	self.var_3FCA.var_3A51 = var_06;
	self.var_3FCA.var_6C70 = var_07;
}

//Function Number: 44
func_44DE()
{
	var_00 = level.var_ACB3[0];
	level.var_76EE = 0;
	level.currentzoneindex = 0;
	return var_00;
}

//Function Number: 45
func_45AF()
{
	var_00 = level.var_76EE + 1 % level.var_ACB3.size;
	var_01 = level.var_ACB3[var_00];
	level.var_76EE = var_00;
	level.currentzoneindex = var_00;
	return var_01;
}

//Function Number: 46
func_8C31()
{
	level.var_ACB9 = common_scripts\utility::func_F92(level.var_ACB3);
	if(level.var_AC7C == level.var_ACB9[0])
	{
		level.var_ACB9 = common_scripts\utility::func_9530(level.var_ACB9,0,randomintrange(1,level.var_ACB9.size));
	}
}

//Function Number: 47
func_45B0()
{
	if(level.var_ACB9.size == 0)
	{
		func_8C31();
	}

	var_00 = level.var_ACB9[0];
	for(var_01 = 0;var_01 < level.var_ACB3.size;var_01++)
	{
		if(var_00 == level.var_ACB3[var_01])
		{
			level.currentzoneindex = var_01;
		}
	}

	var_02 = [];
	for(var_01 = 1;var_01 < level.var_ACB9.size;var_01++)
	{
		var_02[var_01 - 1] = level.var_ACB9[var_01];
	}

	level.var_ACB9 = var_02;
	return var_00;
}

//Function Number: 48
attemptdropteslagun(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(getdvarint("spv_tesla_mp_active",0) == 1)
	{
		level thread maps\mp\gametypes\_weapons::potentiallyspawnteslagun(param_00,5);
	}
}

//Function Number: 49
func_6B7B(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!isplayer(param_01))
	{
		return;
	}

	if(maps\mp\gametypes\_damage::func_56FA(self,param_01))
	{
		return;
	}

	if(param_01 == self)
	{
		return;
	}

	if(!isdefined(level.var_AC7C))
	{
		return;
	}

	var_0A = level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_45F7();
	if(!isdefined(var_0A) || var_0A == "neutral")
	{
		return;
	}

	self.touchinghardpoint = 0;
	var_0B = 0;
	var_0C = self;
	if(!level.var_AC7C.var_3FCA.var_56B7 && param_01 istouching(level.var_AC7C.var_9D5E))
	{
		var_0B = 1;
		param_01 thread maps\mp\_events::func_5A82(self,param_09,param_04,level.var_AC7C.var_81E1);
		param_01.var_62A1["assaultObjective"] = level.var_AC7C;
	}

	if(var_0C istouching(level.var_AC7C.var_9D5E))
	{
		var_0C.var_2EF1 = 1;
		param_01.var_5BAF = gettime();
		param_01 thread maps\mp\gametypes\_missions::func_80BB(param_04,param_03);
		var_0C thread maps\mp\_matchdata::func_5E96(var_0C.var_5CC6,"in_hardpoint");
		if(var_0B)
		{
			return;
		}

		if(var_0C.var_1A7 == var_0A)
		{
			param_01 thread maps\mp\_events::func_10BA(var_0C,param_09,param_04);
			param_01.var_62A1["assaultObjective"] = level.var_AC7C;
			return;
		}

		param_01 maps\mp\gametypes\_missions::func_7750("ch_hp_zoneDefense");
		param_01 thread maps\mp\_events::func_2C80(self,param_09,param_04,level.var_AC7C.var_81E1);
		param_01.var_62A1["defendObjective"] = level.var_AC7C;
		return;
	}

	var_0C.var_2EF1 = 0;
}

//Function Number: 50
func_6AF9(param_00)
{
	for(var_01 = 0;var_01 < level.var_ACB3.size;var_01++)
	{
		level.var_ACB3[var_01].var_3FCA maps\mp\gametypes\_gameobjects::func_C30("none");
	}
}

//Function Number: 51
func_5E9C()
{
	level waittill("game_ended");
	foreach(var_01 in level.var_744A)
	{
		foreach(var_05, var_03 in var_01.var_4B1D)
		{
			if(var_05 > 0 && var_05 < 6)
			{
				var_04 = getmatchdata("players",var_01.var_2418,"hardpointScore",var_05);
				var_04 = var_04 + var_03;
				setmatchdata("players",var_01.var_2418,"hardpointScore",var_05,var_04);
			}
		}
	}
}

//Function Number: 52
func_A0F0(param_00)
{
	if(!isdefined(self.var_1FAB))
	{
		self.var_6885 = 0;
		self.var_1FAB = 0;
	}

	if(!isdefined(param_00) || param_00 == "neutral")
	{
		return;
	}

	self.var_6885++;
	var_01 = maps\mp\_utility::func_46E3() / -5536;
	if(isplayer(self) && isdefined(self.var_9A06["total"]))
	{
		var_01 = max(self.var_9A06["total"],1) / 60;
	}

	self.var_1FAB = self.var_6885 / var_01;
	if(self.var_1FAB > self.var_6885)
	{
		self.var_1FAB = self.var_6885;
	}
}

//Function Number: 53
func_57B8(param_00)
{
	if(!level.var_7A67)
	{
		return 0;
	}

	if(param_00.var_1FAB > level.var_73C0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 54
setbroadcastermesh(param_00)
{
	if(getdvarint("spv_enableHPBroadcasterMesh") == 0)
	{
		return;
	}

	if(!isdefined(level.var_AC7C) || !isdefined(level.var_AC7C.broadcastermesh))
	{
		return;
	}

	if(!isdefined(level.broadcastercolorindexallies) || !isdefined(level.broadcastercolorindexaxis))
	{
		return;
	}

	waittillframeend;
	var_01 = maps\mp\_utility::func_4571();
	if(issubstr(var_01,"carentan_s2_winter"))
	{
		var_01 = "mp_carentan_s2";
	}

	if(param_00 == "allies")
	{
		level.var_AC7C.broadcastermesh setmodel(var_01 + "_hp_zone_" + level.currentzoneindex + 1 + "_" + level.broadcastercolorindexallies);
		return;
	}

	if(param_00 == "axis")
	{
		level.var_AC7C.broadcastermesh setmodel(var_01 + "_hp_zone_" + level.currentzoneindex + 1 + "_" + level.broadcastercolorindexaxis);
		return;
	}

	if(param_00 == "contested")
	{
		level.var_AC7C.broadcastermesh setmodel(var_01 + "_hp_zone_" + level.currentzoneindex + 1 + "_contested");
		return;
	}

	level.var_AC7C.broadcastermesh setmodel(var_01 + "_hp_zone_" + level.currentzoneindex + 1);
}