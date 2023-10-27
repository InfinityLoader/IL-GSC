/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_hub_stats.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 63
 * Decompile Time: 1050 ms
 * Timestamp: 10/27/2023 3:23:20 AM
*******************************************************************/

//Function Number: 1
func_4F3E()
{
	if(getdvarint("233") == 1)
	{
		return;
	}

	maps\mp\gametypes\_hub_unk1::func_4F43();
	maps\mp\gametypes\_hub_unk1::removeunusedpatchclip();
	level.var_75DF = ::func_6B85;
	level.var_A592 = ::func_6BA6;
	level.var_A5A0 = ::func_A596;
	level.var_A7A2 = ::maps\mp\gametypes\_hub_unk1::func_4F45;
	if(getdvarint("3645",0) == 1)
	{
		level.var_13AC = ::func_13AB;
	}

	level.var_1728 = 65;
	level.var_1726 = 356;
	level.var_1727 = 18;
	level.var_3EF2 = 65;
	level.var_3EF0 = 180;
	level.var_3EF1 = 3;
	level.var_2BC8 = getdvarfloat("3380");
	level.var_2BC7 = getdvarfloat("1920");
	level.var_ACCA = 1.54;
	level.var_ACC9 = 62.5;
	level.var_2BC6 = (10,-25,65);
	level.var_2746 = (-25,-50,60);
	level.var_611["level_up"] = loadfx("vfx/level_up/level_up_flag");
	level.var_611["prestige_lensflare"] = loadfx("vfx/level_up/prestige_lensflare");
	level.var_611["prestige_flag_1"] = loadfx("vfx/level_up/prestige_flag_1");
	level.var_611["prestige_flag_2"] = loadfx("vfx/level_up/prestige_flag_2");
	level.var_611["prestige_flag_3"] = loadfx("vfx/level_up/prestige_flag_3");
	level.var_611["prestige_flag_4"] = loadfx("vfx/level_up/prestige_flag_4");
	level.var_611["prestige_flag_5"] = loadfx("vfx/level_up/prestige_flag_5");
	level.var_611["prestige_flag_6"] = loadfx("vfx/level_up/prestige_flag_6");
	level.var_611["prestige_flag_7"] = loadfx("vfx/level_up/prestige_flag_7");
	level.var_611["prestige_flag_8"] = loadfx("vfx/level_up/prestige_flag_8");
	level.var_611["prestige_flag_9"] = loadfx("vfx/level_up/prestige_flag_9");
	level.var_611["prestige_flag_10"] = loadfx("vfx/level_up/prestige_flag_10");
	level.var_611["prestige_icon_1"] = loadfx("vfx/level_up/prestige_icon_vfx/prestige_level_1_icon");
	level.var_611["prestige_icon_2"] = loadfx("vfx/level_up/prestige_icon_vfx/prestige_level_2_icon");
	level.var_611["prestige_icon_3"] = loadfx("vfx/level_up/prestige_icon_vfx/prestige_level_3_icon");
	level.var_611["prestige_icon_4"] = loadfx("vfx/level_up/prestige_icon_vfx/prestige_level_4_icon");
	level.var_611["prestige_icon_5"] = loadfx("vfx/level_up/prestige_icon_vfx/prestige_level_5_icon");
	level.var_611["prestige_icon_6"] = loadfx("vfx/level_up/prestige_icon_vfx/prestige_level_6_icon");
	level.var_611["prestige_icon_7"] = loadfx("vfx/level_up/prestige_icon_vfx/prestige_level_7_icon");
	level.var_611["prestige_icon_8"] = loadfx("vfx/level_up/prestige_icon_vfx/prestige_level_8_icon");
	level.var_611["prestige_icon_9"] = loadfx("vfx/level_up/prestige_icon_vfx/prestige_level_9_icon");
	level.var_611["prestige_icon_10"] = loadfx("vfx/level_up/prestige_icon_vfx/prestige_level_10_icon");
	level.var_611["prestige_icon_11"] = loadfx("vfx/level_up/prestige_icon_vfx/prestige_level_11_icon");
	level.var_611["hub_granadier_tag_effect"] = loadfx("vfx/map/mp_hub/hub_granadier_tag_effect");
	level.var_4F50 = 0;
	level.var_2D6D = ::maps\mp\gametypes\_hub_notifications::func_2D6D;
	setdvarifuninitialized("hub_noPSDPlayerLock",0);
	setdvarifuninitialized("hub_emote","mp_emote_salute");
	setdvarifuninitialized("hub_setThirdPerson",1);
	setdvarifuninitialized("spv_hub_firingrange_kswitch",1);
	setdvarifuninitialized("spv_hub_vendors_kswitch",1);
	setdvarifuninitialized("spv_hub_1v1_kswitch",1);
	setdvarifuninitialized("spv_hub_dueling_kswitch",1);
	setdvarifuninitialized("spv_hub_psd_kswitch",1);
	setdvarifuninitialized("spv_hub_planes_kswitch",1);
	setdvarifuninitialized("spv_hub_quickchat_kswitch",1);
	setdvarifuninitialized("spv_hub_zombiesVendor_kswitch",1);
	setdvarifuninitialized("spv_hub_raidsVendor_kswitch",1);
	setdvarifuninitialized("spv_hub_requisitionsVendor_kswitch",1);
	setdvarifuninitialized("spv_hub_quartermasterVendor_kswitch",1);
	setdvarifuninitialized("spv_hub_prestigeVendor_kswitch",1);
	setdvarifuninitialized("spv_hub_scorestreakVendor_kswitch",1);
	setdvarifuninitialized("spv_hub_gunsmithVendor_kswitch",1);
	setdvarifuninitialized("spv_hub_payrollVendor_kswitch",1);
	setdvarifuninitialized("spv_hub_theater_kswitch",1);
	setdvarifuninitialized("spv_hub_winter_event_enabled",0);
	setdvarifuninitialized("spv_hub_timer_tag_kswitch",1);
	setdvarifuninitialized("spv_hub_prestigeAEFailsafes_kswitch",1);
	setdvarifuninitialized("spv_hub_rankAEIrregularityLogging_kswitch",1);
	setdvarifuninitialized("spv_hub_masterPrestigeDrops_kswitch",0);
	setdvarifuninitialized("spv_hub_1v1_weapon_mode",0);
	setdvarifuninitialized("spv_supplydrop_timeout",15);
	setdvarifuninitialized("spv_hub_riotshield_kswitch",0);
	setdvarifuninitialized("hub_cam_preset_1",1);
	setdvarifuninitialized("hub_cam_preset_2",0);
	setdvarifuninitialized("hub_cam_preset_3",0);
	setdvarifuninitialized("hub_cam_preset_4",0);
	setdvarifuninitialized("hub_cam_preset_5",0);
	setdvarifuninitialized("hub_cameraAdjustMode",0);
	thread maps\mp\gametypes\_hub_unk1::func_636B();
	setdvar("250",1);
	setdvar("5679",1);
	setdvar("3386",1);
	setdvar("2903",0);
	setdvar("31",0.8);
	thread func_4F3F();
	if(!level.var_A220)
	{
		func_A598();
	}
	else
	{
		func_669F();
	}

	level.var_4F49 = ["ch_daily_2","ch_daily_3","ch_daily_4","ch_daily_5"];
}

//Function Number: 2
waitfor_loadmain()
{
	while(!isdefined(level.var_947C))
	{
		wait 0.05;
	}
}

//Function Number: 3
func_4F3F()
{
	level.var_5E0C = 0;
	maps\mp\gametypes\_hub_unk1::func_4F45("mp_hub_range_2_tr");
	func_4F40();
	if(function_03AE() == 0 && !common_scripts\utility::func_562E(level.var_AC5A))
	{
		waitfor_loadmain();
		level.var_5E0C = 1;
		maps\mp\gametypes\_hub_unk1::func_4F45("mp_hub_spawn_5_tr");
		func_4F41();
		level.var_5E0C = 2;
		maps\mp\gametypes\_hub_unk1::func_4F45("mp_hub_main_2_tr");
		func_4F42();
	}
}

//Function Number: 4
func_4F40()
{
	thread maps\mp\gametypes\_hub_range::func_52B9();
	func_87B2();
}

//Function Number: 5
func_4F41()
{
	maps\mp\gametypes\_hub_crate::func_D5();
	thread maps\mp\gametypes\_hub_unk2::func_D5();
	thread maps\mp\gametypes\_hub_unk1::func_532E();
	thread func_89D4();
}

//Function Number: 6
func_4F42()
{
	thread maps\mp\_1v1::func_D5();
	if(!getdvarint("1258",0))
	{
		thread maps\mp\gametypes\_hub_streaks::func_85BE();
	}
}

//Function Number: 7
func_87B2()
{
	level.var_5A61 = [];
	maps\mp\gametypes\_missions::func_1D41();
	level.var_47EE = ["SHG-BParker"];
}

//Function Number: 8
func_89D4()
{
	level.var_9956 = [];
	foreach(var_01 in getentarray("interactive_chair_trigger","targetname"))
	{
		var_01 thread maps\mp\_dynamic_world::func_9DC3(::func_37B9,::func_38EF);
		level.var_9956[level.var_9956.size] = var_01;
	}
}

//Function Number: 9
func_37B9(param_00)
{
	if(!isdefined(param_00.var_745E))
	{
		param_00.var_745E = 0;
	}

	param_00.var_745E++;
}

//Function Number: 10
func_38EF(param_00)
{
	param_00.var_745E--;
}

//Function Number: 11
func_63F3()
{
	wait(5);
	for(;;)
	{
		var_00 = 0;
		var_01 = [];
		if(isdefined(level.var_A012))
		{
			foreach(var_03 in level.var_A012.var_21F6)
			{
				if(isdefined(var_03))
				{
					var_01 = common_scripts\utility::func_F6F(var_01,var_03);
					var_00++;
				}
			}
		}

		level.var_687C = var_00;
		level.var_FBE = var_01;
		wait(1);
	}
}

//Function Number: 12
func_5302()
{
	if(common_scripts\utility::func_562E(self.var_4F3D))
	{
		return;
	}

	self.var_4F3D = 1;
	var_00 = function_03AE() != 0 || common_scripts\utility::func_562E(level.var_AC5A);
	var_01 = !function_03B0();
	var_02 = "hq";
	if(common_scripts\utility::func_562E(level.var_AC5A))
	{
		var_02 = "zm";
	}
	else if(function_03AE() != 0)
	{
		var_02 = "vl";
	}

	thread lib_0468::func_A1B();
	func_A125();
	self.var_4F4C = function_003E();
	var_03 = self getrankedplayerdata(common_scripts\utility::func_46AA(),"hubLifetimeStats","lifetimeHubSessions") + 1;
	self setrankedplayerdata(common_scripts\utility::func_46AA(),"hubLifetimeStats","lifetimeHubSessions",var_03);
	self setrankedplayerdata(common_scripts\utility::func_46AB(),"hubStats","lifetimeSessions",var_03);
	function_00F5("script_mp_hub_event: game_time %d, player_name %s, player_id %d, event_category %s, event_name %s, event_value_int %d, event_value_float %f, event_value_string %s, player_count %d",gettime(),self.var_109,self.var_2418,"hub_session_info","entered_hub",1,-1,"NA",level.var_744A.size);
	maps\mp\gametypes\_hub_unk1::func_5E88("join","hq_session_info",0,["join_type",var_02]);
	maps\mp\gametypes\_hub_unk1::func_531B();
	maps\mp\gametypes\_missions::func_A0F3();
	thread func_75D7();
	if(!common_scripts\utility::func_562E(level.var_AC5A) && function_03AE() == 0)
	{
		thread func_63B7();
	}

	thread lib_0468::func_2565();
	thread func_A77F();
}

//Function Number: 13
func_A77F()
{
	self endon("disconnect");
	self waittill("spawned_player");
	self luinotifyevent(&"hub_fade_in");
	thread afktimer();
	if(getdvarint("spv_hub_special_qm",0) == 1)
	{
		activateclientexploder(15,self);
	}
}

//Function Number: 14
afktimer()
{
	level endon("game_ended");
	self endon("disconnect");
	setdvarifuninitialized("spv_hub_afk_timeout",-1);
	var_00 = 5;
	for(;;)
	{
		while(getdvarint("spv_hub_afk_timeout",300) < 0)
		{
			wait(var_00);
		}

		var_01 = getdvarint("spv_hub_afk_timeout",300);
		var_02 = var_01 / var_00;
		while(var_01 == getdvarint("spv_hub_afk_timeout",300))
		{
			wait(1);
			var_03 = 1;
			var_04 = undefined;
			for(var_05 = 0;var_05 < var_02;var_05++)
			{
				if(!isdefined(var_04))
				{
					var_04 = self.var_116;
				}

				if(var_04 == self.var_116 && self getclientomnvar("ui_hub_is_preoccupied") == 0 && self.var_537B == 0)
				{
					wait(var_00);
					continue;
				}

				var_03 = 0;
				break;
			}

			if(var_03)
			{
				kick(self getentitynumber(),"EXE_PLAYERKICKED_INACTIVE");
			}
		}
	}
}

//Function Number: 15
func_715F()
{
	function_0290(self,"mp/fte_capture",1,0);
}

//Function Number: 16
func_52A1()
{
	if(function_0367() && !isdefined(self.var_5520))
	{
		if(level.var_A220)
		{
			thread maps\mp\gametypes\_hub_unk3::func_636A(self);
			thread maps\mp\gametypes\_hub_unk3::func_62F5();
		}
		else
		{
			thread maps/mp/hub_vl_camera::func_6BA9();
		}

		self.var_5520 = 1;
	}

	setdvar("5666","1");
}

//Function Number: 17
func_13AB(param_00)
{
	var_01 = ["headquarters_npc","blacksmith_npc","raid_npc","mail_npc","zombie_npc","playlist_npc","general_npc","commander_npc","scorestreak_training_npc","1v1_npc","quartermaster_npc"];
	var_02 = [];
	foreach(var_04 in var_01)
	{
		var_05 = common_scripts\utility::func_44BD(var_04,"targetname");
		var_02[var_02.size] = var_05;
	}

	var_02 = common_scripts\utility::func_F73(var_02,lib_050D::func_46A0());
	var_07 = param_00 getentitynumber();
	var_07 = var_07 + randomint(5) % var_02.size;
	return var_02[var_07];
}

//Function Number: 18
func_A596(param_00)
{
	var_01 = level.var_3C3F[0];
	if(!isdefined(var_01))
	{
		var_02 = common_scripts\utility::func_46B7("hub_lobby_avatar_spawn","script_noteworthy");
		var_01 = var_02[0];
	}

	param_00 method_805C();
	return var_01;
}

//Function Number: 19
func_6B85()
{
	var_00 = function_03AE() != 0 || common_scripts\utility::func_562E(level.var_AC5A);
	var_01 = !function_03B0();
	setdvar("2766",level.var_1728);
	setdvar("3711",level.var_1727);
	self setclientomnvar("ui_hide_1v1scores",1);
	self setclientomnvar("ui_hub_1v1_queueposition",-1);
	if(function_0367() && !isdefined(self.var_5520))
	{
		if(level.var_A220)
		{
			self setclientomnvar("char_scene_state",3);
		}
	}

	maps\mp\gametypes\_hub_unk1::func_870B(0);
	if(!isdefined(level.var_4F50))
	{
		level.var_4F50 = 0;
	}

	if(!function_025F() && level.var_744A.size <= 1 && function_02A3() && getdvarint("2568",0) == 0)
	{
		if(maps\mp\gametypes\_hud_util::shoulddohubtutorialflow() && getdvarint("5740",0) || !maps\mp\gametypes\_hub_unk1::func_4B90())
		{
			level.var_4F50 = 1;
		}
	}

	if(level.var_4F50 && getdvarint("intro_anim_debug",0) != 1)
	{
		self setclientomnvar("ui_fte_welcome_message_status",1);
		for(;;)
		{
			self waittill("luinotifyserver",var_02,var_03);
			if(var_02 == "hub_fte")
			{
				break;
			}
		}

		self setclientomnvar("ui_fte_welcome_message_status",0);
		self freezecontrols(1);
		thread func_715F();
		lib_0378::func_8D74("theater_cinematic_started");
		wait 0.05;
		self setclientomnvar("ui_show_fte_division_select",1);
		wait(52);
		lib_0378::func_8D74("theater_cinematic_stopped");
		thread maps\mp\gametypes\_hub_unk0::func_6380();
	}
	else if(function_02A3())
	{
		lib_0468::func_A1F();
	}

	self.var_572A = 0;
	self.var_6B25 = ::maps\mp\_1v1::func_6FB8;
	self.var_5721 = 0;
	self.var_7891 = 0;
	self.var_5722 = 0;
	self.var_5692 = 0;
	self.var_572F = 0;
	self.var_4E03 = [];
	self.var_537B = 0;
	thread maps\mp\gametypes\_hub_unk2::func_639F();
	if(!var_00 && !var_01)
	{
		thread func_6385();
		thread maps\mp\gametypes\_hub_unk1::func_63C0();
		thread func_63C6();
		thread maps\mp\gametypes\_hub_unk1::func_637C();
		thread maps\mp\gametypes\_hub_unk1::func_639E();
	}
	else
	{
		thread monitorplayerusewithhubkillswitched();
		if(function_03AE() && !common_scripts\utility::func_562E(level.var_AC5A))
		{
			self.var_537A = 0;
			thread func_63F8();
		}
	}

	thread func_637D();
	thread func_52A1();
	thread maps\mp\gametypes\_hub_notifications::monitorsocialrankup();
	thread maps\mp\gametypes\_hub_crate::monitorsupplydropawarded();
	thread maps\mp\gametypes\_hub_notifications::monitorsocialmaxrankreward();
}

//Function Number: 20
func_6BA6()
{
	func_5302();
	if(!isdefined(self.var_572A))
	{
		self.var_572A = 0;
	}

	var_00 = undefined;
	self.var_12C["class"] = "gamemode";
	self.var_12C["lastClass"] = "";
	var_00 = [];
	var_00["loadoutDivision"] = 5;
	var_00["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::func_473C(16994304,0);
	for(var_01 = 0;var_01 < 6;var_01++)
	{
		var_00["loadoutPrimaryAttachmentsGUID"][var_01] = 0;
	}

	var_00["loadoutPrimaryBuff"] = "specialty_null";
	var_00["loadoutPrimaryCamoGUID"] = 0;
	var_00["loadoutPrimaryCamo2GUID"] = 0;
	var_00["loadoutPrimaryReticleGUID"] = 0;
	var_00["loadoutPrimaryPaintjobId"] = 0;
	var_00["loadoutPrimaryCharmGUID"] = 0;
	var_00["loadoutSecondaryWeaponStruct"] = maps\mp\_utility::func_473C(16994304,0);
	for(var_01 = 0;var_01 < 6;var_01++)
	{
		var_00["loadoutSecondaryAttachmentsGUID"][var_01] = 0;
	}

	var_00["loadoutSecondaryBuff"] = "specialty_null";
	var_00["loadoutSecondaryCamoGUID"] = 0;
	var_00["loadoutSecondaryCamo2GUID"] = 0;
	var_00["loadoutSecondaryReticleGUID"] = 0;
	var_00["loadoutSecondaryPaintjobId"] = 0;
	var_00["loadoutSecondaryCharmGUID"] = 0;
	var_00["loadoutEquipmentStruct"] = maps\mp\_utility::func_44CE(0,0);
	var_00["loadoutOffhandStruct"] = maps\mp\_utility::func_44CE(0,0);
	for(var_01 = 0;var_01 < 4;var_01++)
	{
		var_00["loadoutKillstreaksGUID"][var_01] = 0;
	}

	var_00["ignoreMeleeSlotWeapon"] = 1;
	var_00["loadoutJuggernaut"] = 0;
	for(var_01 = 0;var_01 < 9;var_01++)
	{
		var_00["loadoutPerksGUID"][var_01] = 0;
	}

	self.var_12C["gamemodeLoadout"] = var_00;
	self.var_2319 = self.var_12C["class"];
	self.var_5B84 = self.var_12C["lastClass"];
	maps\mp\gametypes\_class::func_4790(level.var_746E,self.var_2319);
	level.var_2BCB = self.var_2319;
	self.var_FB = 100;
	self.var_BC = self.var_FB;
	if(!isdefined(self.var_12C["killstreaks"]))
	{
		self.var_12C["killstreaks"] = [];
	}

	if(!isdefined(self.var_12C["kID"]))
	{
		self.var_12C["kID"] = 10;
	}

	self setclientomnvar("send_map_load_phase",-1);
	thread func_6372();
	thread func_6371();
	thread func_6373();
}

//Function Number: 21
func_6373()
{
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 == "send_lobby_in_lobby_type")
		{
			if(var_01 == 3)
			{
				self.inrankedlobby = 1;
				var_01 = 1;
			}
			else
			{
				self.inrankedlobby = 0;
			}

			self.var_537B = var_01;
		}
	}
}

//Function Number: 22
func_6372()
{
	self.var_2419 = -1;
	self setclientomnvar("send_map_load_phase",1);
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 == "map_load_phase")
		{
			self.var_2419 = var_01;
			if(var_01 == 2)
			{
				self setclientomnvar("send_map_load_phase",0);
				return;
			}
		}
	}
}

//Function Number: 23
func_4B5B(param_00)
{
	return isdefined(self.var_2419) && self.var_2419 >= param_00;
}

//Function Number: 24
func_A779(param_00)
{
	while(!func_4B5B(param_00))
	{
		wait 0.05;
	}
}

//Function Number: 25
func_A77E()
{
	func_A779(0);
}

//Function Number: 26
func_A791()
{
	func_A779(1);
}

//Function Number: 27
func_A777()
{
	func_A779(2);
}

//Function Number: 28
func_6371()
{
	self endon("disconnect");
	self notify("monitorBeachZoneLoaded");
	self endon("monitorBeachZoneLoaded");
	if(isdefined(self.var_16F0) && self.var_16F0)
	{
		return;
	}

	if(isbot(self) || function_026D(self))
	{
		return;
	}

	var_00 = getentarray("transient_load_guard","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setplayercollision(self,1);
	}

	var_04 = getentarray("transient_load_hint","targetname");
	foreach(var_06 in var_04)
	{
		var_06 thread func_63F0();
	}

	func_A777();
	self.var_16F0 = 1;
	foreach(var_02 in var_00)
	{
		var_02 setplayercollision(self,0);
	}
}

//Function Number: 29
func_63F0()
{
	level endon("game_ended");
	self endon("deleted");
	for(;;)
	{
		self waittill("trigger",var_00);
		if(!isplayer(var_00) && !isdefined(var_00.var_3BAA))
		{
			continue;
		}

		if(!isalive(var_00))
		{
			continue;
		}

		if(isdefined(var_00.var_2419) && var_00.var_2419 >= 2)
		{
			continue;
		}

		if(!isdefined(var_00.var_9C65))
		{
			var_00.var_9C65 = 1;
			var_00 thread maps\mp\gametypes\_hud_util::func_3005("Area loading...",0,1,"remove_transient_hint");
			var_00 thread func_2396(self);
		}
	}
}

//Function Number: 30
func_2396(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	while(isdefined(param_00))
	{
		if(isdefined(self.var_2419) && self.var_2419 >= 2)
		{
			break;
		}

		if(!self istouching(param_00))
		{
			break;
		}

		wait 0.05;
	}

	self notify("remove_transient_hint");
	self.var_9C65 = undefined;
}

//Function Number: 31
func_64BC()
{
	if(getdvarint("5866",0) == 1)
	{
		return;
	}

	if(isdefined(self.var_64A4) && self.var_64A4)
	{
		return;
	}

	var_00 = common_scripts\utility::func_46B5("player_spawn_intermission","targetname");
	if(isdefined(var_00))
	{
		self setorigin(var_00.var_116,1);
		self.var_64A4 = 1;
	}
}

//Function Number: 32
func_75D7()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		maps\mp\gametypes\_hub_unk1::func_870B(0);
		if(self method_86BE() && !isdefined(self.var_64A4))
		{
			self method_86BF(0);
			func_64BC();
		}

		if(!function_03B0())
		{
			self freezecontrols(1);
		}

		if(getdvarint("986") == 0)
		{
			self method_85C7();
		}

		self setclientomnvar("ui_hide_1v1scores",1);
		self setanimoverride(0,"mp_emote_salute");
		self.var_99FD = getsystemtime();
		if(isdefined(self.var_162C))
		{
			maps\mp\gametypes\_hub_unk1::func_2DD2("hub_baseNameHudElem");
		}

		if(isdefined(self.var_ACA4))
		{
			maps\mp\gametypes\_hub_unk1::func_2DD2("hub_zoneHudElem");
		}

		if(isdefined(self.var_177F))
		{
			self.var_177F destroy();
		}

		maps\mp\_utility::func_47A2("specialty_marathon");
		maps\mp\_utility::func_47A2("specialty_falldamage");
		self.var_6CCE = 0;
		self.var_1EB2 = 1;
		self.var_542B = 1;
		self.var_6CCE = 0;
		self.var_572B = 0;
		self.var_4B84 = 0;
		self.var_5721 = 0;
		self.var_7891 = 0;
		self.var_5722 = 0;
		self.var_5692 = 0;
		self.var_584B = 0;
		self.var_5791 = 0;
		self.var_34D2 = undefined;
		self.var_295A = "spawn_zone_trigger";
		self.var_56C8 = 0;
		self.var_1387 = 0;
		self.var_8C8F = 0;
		self.var_579F = 1;
		self.var_8B93 = 0;
		self.var_56A4 = 0;
		self.var_155F = undefined;
		self.var_5734 = 0;
		self.var_572F = 0;
		self.var_57E0 = 0;
		self.var_5733 = 0;
		self.gator_light = "none";
		self.primarypaintjobid = 0;
		self.primarycharmguid = 0;
		self.var_835C = "none";
		self.secondarypaintjobid = 0;
		self.secondarycharmguid = 0;
		self.var_60FB = "none";
		self.isintimertag = 0;
		self.tagchallenger = undefined;
		self.hastagbomb = 0;
		self method_8114(0);
		self method_8112(1);
		self method_8113(1);
		self method_812A(0);
		self method_85BE(0);
		self.var_537B = 0;
		if(function_03AE())
		{
			maps\mp\gametypes\_hub_unk1::func_2FA2();
		}
		else
		{
			maps\mp\gametypes\_hub_unk1::func_3663();
		}

		self.var_162C = maps\mp\gametypes\_hub_unk1::func_2811("hub_baseNameHudElem",&"HUB_ALLIES_BASENAME",[40,-35],1,"BOTTOM LEFT");
		self.var_ACA4 = maps\mp\gametypes\_hub_unk1::func_2811("hub_zoneHudElem",&"HUB_ZONE_SPAWN",[40,-46],1.5,"BOTTOM LEFT");
		self.var_ACA4.var_18 = 0;
		self.var_162C.var_18 = 0;
		self.var_ACA4.var_56 = (0.7,0.62,0.42);
		self.var_162C.var_56 = (0.81,0.79,0.69);
		self.var_162C.var_9A = "default";
		if(!self.var_572A)
		{
			thread maps\mp\gametypes\_hub_unk1::func_4F44(self.var_295A);
			self method_85BF(0);
		}

		self.var_177F = newclienthudelem(self);
		self.var_177F.maxsightdistsqrd = 0;
		self.var_177F.var_1D7 = 0;
		self.var_177F.var_C6 = "fullscreen";
		self.var_177F.var_1CA = "fullscreen";
		self.var_177F setshader("black",640,480);
		self.var_177F.var_18 = 0;
		self.var_177F.var_35B2 = "icon";
		self.var_177F.var_6E74 = level.var_A012;
		self.var_177F.var_6E74 maps\mp\gametypes\_hud_util::func_9A6(self.var_177F);
		self.var_177F.var_109 = "blackout";
		if(getdvarint("intro_anim_debug",0) == 1)
		{
		}
		else
		{
			maps\mp\gametypes\_hub_unk0::cleanuphubtutorialents();
		}

		if(function_03AE() == 0)
		{
			thread maps\mp\gametypes\_hub_unk1::func_63EA();
		}

		self method_84B4();
		self method_84B7(50,29,20,20);
		thread maps\mp\gametypes\_hub_top_player::func_1E53();
		if(self.var_572A == 1)
		{
			maps\mp\gametypes\_hub_unk1::func_870B(1);
			maps\mp\_1v1::func_8A11(self.var_2922);
			continue;
		}

		self.var_2922 = undefined;
		self.var_4E03 = [];
		thread maps\mp\gametypes\_hub_unk1::func_7B90();
		self method_8326();
		lib_0378::func_8D74("start_hub_music");
	}
}

//Function Number: 33
func_63B7()
{
	self endon("disconnect");
	level endon("game_ended");
	var_00 = getentarray("officer_tower_collision","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(isdefined(var_00[var_01]))
		{
			var_00[var_01] setplayercollision(self,1);
		}
	}

	for(;;)
	{
		if(isdefined(self.var_56D5) && self.var_56D5)
		{
			if(isdefined(level.var_4F51))
			{
				foreach(var_03 in level.var_4F51)
				{
					if(var_03.var_6113 == "overlook_menu")
					{
						self removehubkiosk(var_03);
						break;
					}
				}
			}

			return;
		}

		var_05 = func_21BE();
		if(!isdefined(self.var_56D5))
		{
			if(var_05)
			{
				for(var_01 = 0;var_01 < var_00.size;var_01++)
				{
					if(isdefined(var_00[var_01]))
					{
						var_00[var_01] setplayercollision(self,0);
					}
				}

				self.var_56D5 = 1;
			}
			else
			{
				self.var_56D5 = 0;
			}
		}
		else if(var_05)
		{
			for(var_01 = 0;var_01 < var_00.size;var_01++)
			{
				if(isdefined(var_00[var_01]))
				{
					var_00[var_01] setplayercollision(self,0);
				}
			}

			self.var_56D5 = 1;
		}

		wait(3);
	}
}

//Function Number: 34
func_21BE()
{
	var_00 = maps\mp\gametypes\_rank::func_4639();
	var_01 = maps\mp\gametypes\_rank::func_46EC();
	var_02 = maps\mp\gametypes\_rank::func_4657(level.var_609A);
	if(var_01 >= var_02 || var_00 > 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 35
func_4ADC()
{
	level endon("game_ended");
	if(!isdefined(level.var_6CB4))
	{
		level.var_6CB4 = getent("officer_tower_trigger","targetname");
	}

	if(!isdefined(level.var_6CB4))
	{
		return;
	}

	wait(5);
	var_00 = common_scripts\utility::func_46B5("officer_tower_spawn_1","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	level.var_6CB3 = spawn("script_model",var_00.var_116);
	level.var_6CB3 setcostumemodels([500,500,0,0,0]);
	level.var_6CB3.var_1D = var_00.var_1D;
	level.var_6CB3 scriptmodelplayanim("mp_hub_doorman_idle");
	level.var_6CB3.var_74B8 = 0;
	level.var_6CB3.var_74B7 = 0;
	level.var_6CB4 thread maps\mp\_dynamic_world::func_9DC3(::func_37BC,::func_38F1);
}

//Function Number: 36
func_37BC(param_00)
{
	if(!level.var_6CB3.var_74B8 && !level.var_6CB3.var_74B7)
	{
		if(self.var_56D5)
		{
			level.var_6CB3.var_74B8 = 1;
			var_01 = "mp_hub_doorman_salute";
		}
		else
		{
			level.var_6CB3.var_74B7 = 1;
			var_01 = "mp_hub_doorman_decline";
			maps\mp\gametypes\_hub_unk1::func_3010("OverlookDoNotEnter",&"","Must be level 55 to enter",200,1.5);
		}

		level.var_6CB3 scriptmodelplayanim(var_01,"animEnded");
		level thread maps\mp\gametypes\_hub_unk1::func_7889(level.var_6CB3,"mp_hub_doorman_idle","animEnded");
		return;
	}

	if(level.var_6CB3.var_74B8)
	{
		return;
	}

	if(level.var_6CB3.var_74B7)
	{
		if(self.var_56D5)
		{
			level.var_6CB3.var_74B8 = 1;
			level.var_6CB3 scriptmodelplayanim("mp_hub_doorman_salute","animEnded");
			level thread maps\mp\gametypes\_hub_unk1::func_7889(level.var_6CB3,"mp_hub_doorman_idle","animEnded");
			return;
		}

		return;
	}
}

//Function Number: 37
func_38F1(param_00)
{
	if(isdefined(self.var_308C["OverlookDoNotEnter"]))
	{
		maps\mp\gametypes\_hub_unk1::func_2DD2("OverlookDoNotEnter");
	}
}

//Function Number: 38
func_6B78(param_00,param_01)
{
	var_02 = 0;
	if(!param_01 maps\mp\gametypes\_hub_unk1::func_5790(var_02))
	{
		param_01 notify("end_existing_interacts");
		if(param_00 == 0)
		{
			param_01.var_53DB = 0;
			param_01 thread maps\mp\gametypes\_hub_notifications::func_4AE0(self);
		}
	}
}

//Function Number: 39
monitorplayerusewithhubkillswitched()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01,var_02,var_03);
		if(!isdefined(var_03) || var_02 == var_03)
		{
			switch(var_00)
			{
				case "quartermaster_menu":
					maps\mp\gametypes\_hub_unk2::func_6B88(var_01,var_02,0);
					break;
	
				case "headquarters_menu":
					maps\mp\gametypes\_hub_unk2::func_6B43(var_01,var_02,0);
					break;
	
				case "blacksmith_menu":
					var_03 maps\mp\gametypes\_hub_unk2::func_6AC1(var_01,var_02,0);
					break;
	
				case "general_menu":
					var_03 maps\mp\gametypes\_hub_unk2::func_6BCC(var_01,var_02,var_00);
					break;
	
				case "mail_officer_menu":
					var_03 maps\mp\gametypes\_hub_unk2::func_6B55(var_01,var_02);
					break;
	
				case "cs_drop_opened":
					lib_0468::func_A29("openSD",0);
					break;
	
				case "cod_tv":
				case "theater_menu":
					var_03 maps\mp\gametypes\_hub_unk2::ontheateropenvlonly(var_01,var_02);
					break;
			}

			continue;
		}
	}
}

//Function Number: 40
func_63C6()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01,var_02,var_03);
		if(!isdefined(var_02) || var_02 != self || !isplayer(var_02))
		{
			continue;
		}

		if(!isdefined(var_03) || var_02 == var_03)
		{
			switch(var_00)
			{
				case "quartermaster_menu":
					maps\mp\gametypes\_hub_unk2::func_6B88(var_01,var_02,0);
					break;
			}

			continue;
		}

		if(var_00 == "player_interact_menu")
		{
			if(getdvarint("spv_hub_timer_tag_kswitch",1) == 0 && var_02.isintimertag && var_03.isintimertag && isdefined(var_02.tagchallenger) && var_02.tagchallenger == var_03)
			{
				var_02 maps\mp\gametypes\_hub_notifications::attemptpasstagbomb(var_03);
			}
			else
			{
				var_03 func_6B78(var_01,var_02);
			}

			continue;
		}

		switch(var_00)
		{
			case "quartermaster_menu":
				var_04 = 0;
				var_03 maps\mp\gametypes\_hub_unk2::func_6B88(var_01,var_02,var_04);
				break;
	
			case "headquarters_menu":
				var_03 maps\mp\gametypes\_hub_unk2::func_6B43(var_01,var_02);
				break;
	
			case "blacksmith_menu":
				var_03 maps\mp\gametypes\_hub_unk2::func_6AC1(var_01,var_02);
				break;
	
			case "general_menu":
			case "overlook_menu":
				var_03 maps\mp\gametypes\_hub_unk2::func_6B40(var_01,var_02);
				break;
	
			case "mail_officer_menu":
				var_03 maps\mp\gametypes\_hub_unk2::func_6B55(var_01,var_02);
				break;
	
			case "onevone_officer_menu":
				var_03 maps\mp\gametypes\_hub_unk2::func_6B5F(var_01,var_02);
				break;
	
			case "zombie_officer_menu":
				var_03 maps\mp\gametypes\_hub_unk2::func_6BD6(var_01,var_02);
				break;
	
			case "cod_tv":
			case "theater_menu":
				var_03 maps\mp\gametypes\_hub_unk2::func_6BB5(var_01,var_02);
				break;
	
			case "r_and_r_menu":
				var_03 maps\mp\gametypes\_hub_unk2::func_6B8F(var_01,var_02);
				break;
	
			case "ranked_playlist_menu":
			case "war_playlist_menu":
			case "dom_playlist_menu":
			case "tdm_playlist_menu":
				var_03 maps\mp\gametypes\_hub_unk2::onleaderboardinteract(var_00,var_01,var_02);
				break;
	
			default:
				var_03 maps\mp\gametypes\_hub_unk2::func_6BCC(var_01,var_02,var_00);
				break;
		}
	}
}

//Function Number: 41
func_577F()
{
	if(isdefined(self.var_2068))
	{
		return 1;
	}

	return 0;
}

//Function Number: 42
func_44B2(param_00)
{
	var_01 = common_scripts\utility::func_46AF();
	if(!function_03AC())
	{
		var_01 = common_scripts\utility::func_46AC();
	}

	var_02 = self getrankedplayerdata(var_01,"emotes",param_00,"emote");
	return var_02;
}

//Function Number: 43
checkplayemote()
{
	var_00 = function_02D4(self,1);
	var_01 = self method_856A();
	if(func_577F())
	{
		return 0;
	}

	if(maps\mp\gametypes\_hub_unk1::func_5790())
	{
		return 0;
	}

	if(self getstance() != "stand" && !capsuletracepassed(self.var_116 + (0,0,6),var_01,var_00,self))
	{
		return 0;
	}

	return 1;
}

//Function Number: 44
func_7219(param_00)
{
	if(param_00 != 0)
	{
		var_01 = function_0330(param_00);
		return maps\mp\gametypes\_hub_unk1::func_721A(var_01);
	}

	return 0;
}

//Function Number: 45
func_6385()
{
	self endon("disconnect");
	level endon("game_ended");
	if(!isbot(self))
	{
		self.var_537A = 0;
		thread func_63F4();
		thread func_6382();
		thread func_63A9();
		thread func_63D7();
		thread func_63F8();
		thread func_63AA();
		thread func_63E7();
		thread func_63CE();
		thread monitortriangle();
	}
}

//Function Number: 46
func_63F4()
{
	self endon("disconnect");
	self endon("releasepadmonitors");
	level endon("game_ended");
	self notifyonplayercommand("upDpad","+actionslot 1");
	self notifyonplayercommand("upDpadRelease","-actionslot 1");
	for(;;)
	{
		self waittill("upDpad");
		if(checkplayemote())
		{
			var_00 = func_44B2(0);
			if(func_7219(var_00))
			{
				wait(1);
			}
		}
	}
}

//Function Number: 47
func_6382()
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("releasepadmonitors");
	self notifyonplayercommand("downDpad","+actionslot 2");
	self notifyonplayercommand("downDpadRelease","-actionslot 2");
	for(;;)
	{
		self waittill("downDpad");
		if(checkplayemote())
		{
			var_00 = func_44B2(1);
			if(func_7219(var_00))
			{
				wait(1);
			}
		}
	}
}

//Function Number: 48
func_63A9()
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("releasepadmonitors");
	var_00 = ["","mp_emote_salute","mp_emote_clap_cheer","mp_emote_clap_jump","mp_emote_chicken_dance_loop"];
	self notifyonplayercommand("leftDpad","+actionslot 3");
	var_01 = 1;
	for(;;)
	{
		self waittill("leftDpad");
		if(checkplayemote())
		{
			var_02 = func_44B2(2);
			if(func_7219(var_02))
			{
				wait(1);
			}
		}
	}
}

//Function Number: 49
func_63D7()
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("releasepadmonitors");
	self notifyonplayercommand("rightDpad","+actionslot 4");
	setdvarifuninitialized("hub_reveal_num_planes",2);
	setdvarifuninitialized("hub_reveal_cam",0);
	for(;;)
	{
		self waittill("rightDpad");
		if(getdvarint("hub_reveal_cam",0) == 0)
		{
			if(checkplayemote())
			{
				var_00 = func_44B2(3);
				if(func_7219(var_00))
				{
					wait(1);
				}
			}

			continue;
		}

		if(getdvarint("hub_reveal_cam",0) == 1)
		{
			thread func_906B();
			wait(1);
		}
	}
}

//Function Number: 50
func_63AA()
{
	level endon("game_ended");
	self endon("disconnect");
	self notifyonplayercommand("leftTrigger","+speed_throw");
}

//Function Number: 51
func_63F9()
{
	level endon("game_ended");
	self endon("disconnect");
	if(self.var_537A == 0 && function_0367() && !isdefined(self.var_572B) || !self.var_572B)
	{
		maps\mp\gametypes\_hub_unk1::func_7471("cao_background_camera");
		if(isdefined(self.var_56A4) && self.var_56A4)
		{
			if(isdefined(self.var_155F))
			{
				self.var_155F maps\mp\gametypes\_hub_unk1::func_1543((0,0,80),self);
			}
		}

		for(;;)
		{
			self waittill("luinotifyserver",var_00,var_01);
			if(var_00 == "hub_move_player_to_hub")
			{
				while(!isdefined(self.var_9092))
				{
					wait 0.05;
				}

				if(isdefined(self.var_64A4) && self.var_64A4 == 1)
				{
					if(!isdefined(self.warpingtosupplydrop))
					{
						self setorigin(self.var_9092);
					}
				}

				self.var_64A4 = 0;
				self.warpingtosupplydrop = undefined;
				self luinotifyevent(&"hub_player_moved_to_hub_spawn");
				maps\mp\gametypes\_hub_unk1::func_870B(maps\mp\gametypes\_hub_unk1::func_5790(1));
				continue;
			}

			if(var_00 == "hub_vl_menu_active" && var_01 == 0)
			{
				maps\mp\gametypes\_hub_unk1::func_115E();
				maps\mp\gametypes\_hub_unk1::func_7472();
				break;
			}
		}

		return;
	}

	if(isdefined(self.var_572B) && self.var_572B)
	{
	}
}

//Function Number: 52
func_63F8()
{
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self setclientomnvar("ui_vl_monitor_started",1);
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 != "hub_is_menu_open")
		{
			continue;
		}

		if(var_01 == 2)
		{
			func_64BC();
		}

		if(var_01 >= 1)
		{
			func_63F9();
		}
	}
}

//Function Number: 53
func_63E7()
{
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 != "hub_supply_drop_selection")
		{
			continue;
		}

		var_02 = tablelookup("mp/supplyDropTypes.csv",1,var_01,0);
		if(var_02 != "")
		{
			thread maps\mp\gametypes\_hub_crate::func_11BF(var_01);
		}
	}
}

//Function Number: 54
func_63CE()
{
	self endon("disconnect");
	self endon("releasepadmonitors");
	level endon("game_ended");
	func_A791();
	self notifyonplayercommand("beginSupplyDrop_Input","+attack");
	self notifyonplayercommand("beginSupplyDrop_Input","+attack_akimbo_accessible");
	if(!level.var_258F)
	{
		self notifyonplayercommand("beginSupplyDrop_Input_KBM","+smoke");
	}

	for(;;)
	{
		var_00 = common_scripts\utility::func_A715("beginSupplyDrop_Input","beginSupplyDrop_Input_KBM");
		if(!isdefined(var_00))
		{
			continue;
		}

		var_01 = level.var_258F || common_scripts\utility::func_55E0();
		if(var_01 != var_00 == "beginSupplyDrop_Input")
		{
			continue;
		}

		if(level.var_4F50)
		{
			continue;
		}

		if(isdefined(self.var_56A4) && self.var_56A4)
		{
			continue;
		}

		var_02 = self getclientomnvar("ui_hub_in_shootout");
		if(!maps\mp\gametypes\_hub_unk1::func_5790() && !var_02)
		{
			self setclientomnvar("ui_show_supply_drop_selection",1);
		}

		wait(0.1);
	}
}

//Function Number: 55
monitortriangle()
{
	self endon("disconnect");
	self endon("releasepadmonitors");
	level endon("game_ended");
	func_A791();
	self notifyonplayercommand("beginFriends_Input","+weapnext");
	for(;;)
	{
		self waittill("beginFriends_Input");
		if(!level.var_258F && !common_scripts\utility::func_55E0())
		{
			continue;
		}

		if(level.var_4F50)
		{
			continue;
		}

		if(!maps\mp\gametypes\_hub_unk1::func_5790())
		{
			self setclientomnvar("ui_hub_show_social_pause",1);
		}

		wait(1);
	}
}

//Function Number: 56
func_63CD()
{
	self endon("death");
	self endon("disconnect");
	self endon("quickchat_client_speak");
	var_00 = ["anyDpadPressed"];
	thread maps\mp\gametypes\_hub_unk1::func_8636(int(tablelookupbyrow("mp/quickchat.csv",0,2)) / 1000,"startChatTimeout",var_00);
	var_01 = common_scripts\utility::func_A715("anyDpadPressed","startChatTimeout");
	if(var_01 == "anyDpadPressed")
	{
		thread maps\mp\gametypes\_hub_unk1::func_8636(int(tablelookupbyrow("mp/quickchat.csv",0,3)) / 1000,"chatSelectTimeout",var_00);
	}
	else if(var_01 == "startChatTimeout")
	{
		thread maps\mp\gametypes\_hub_unk1::func_3010("startChatTO",&"HUB_QUICKCHAT_TO",undefined,-100,0.6,2);
		return;
	}

	var_02 = common_scripts\utility::func_A715("anyDpadPressed","chatSelectTimeout");
	if(var_02 == "chatSelectTimeout")
	{
		thread maps\mp\gametypes\_hub_unk1::func_3010("chatSelectTO",&"HUB_QUICKCHAT_TO",undefined,-100,0.6,2);
	}
}

//Function Number: 57
func_669F()
{
	level.var_6EA3 = ::maps\mp\gametypes\_hub_unk3::func_6EA2;
	level thread maps\mp\gametypes\_hub_unk3::endgame();
}

//Function Number: 58
func_A598()
{
	level.var_6EA3 = ::maps/mp/hub_vl_camera::func_6EA2;
	level.var_A595 = [];
	level.var_AAE2 = [];
	level.var_13B8 = [];
	var_00 = 48;
	for(var_01 = 0;var_01 < var_00;var_01++)
	{
		level.var_13B8[var_01] = spawnstruct();
		level.var_13B8[var_01].var_9A1A = 0;
		level.var_13B8[var_01].var_1D6 = "";
	}

	level.var_6077 = var_00;
	thread maps/mp/hub_vl_camera::endgame();
	setdvar("1999",0);
	level.var_6871 = 4;
	maps/mp/hub_vl_camera::func_8774();
}

//Function Number: 59
func_A124(param_00)
{
	self endon("disconnect");
	if(!isdefined(self.var_20A9))
	{
		self.var_20A9 = [];
	}

	if(!isdefined(game["challengeStruct"]))
	{
		game["challengeStruct"] = [];
	}

	if(!isdefined(game["challengeStruct"]["limitedChallengesReset"]))
	{
		game["challengeStruct"]["limitedChallengesReset"] = [];
	}

	if(!isdefined(game["challengeStruct"]["challengesCompleted"]))
	{
		game["challengeStruct"]["challengesCompleted"] = [];
	}

	var_01 = maps\mp\gametypes\_hud_util::func_2098(param_00);
	if(var_01 == 2)
	{
		maps\mp\gametypes\_hud_util::func_209F(param_00,1);
		maps\mp\gametypes\_hud_util::func_209E(param_00,0);
	}

	self.var_20A9[param_00] = 1;
}

//Function Number: 60
func_A125()
{
	foreach(var_01 in level.var_4F49)
	{
		var_02 = maps\mp\gametypes\_hud_util::func_2098(var_01);
		if(var_02 == 0)
		{
			var_02 = 1;
			maps\mp\gametypes\_hud_util::func_209F(var_01,1);
		}

		self.var_20A9[var_01] = var_02;
	}
}

//Function Number: 61
func_8C6D(param_00)
{
	self endon("disconnect");
	level endon("level_ended");
	if(!isdefined(param_00))
	{
		var_01 = function_01AC(level.var_9956,self.var_116);
		foreach(var_03 in var_01)
		{
			if(!isdefined(var_03.var_745E) || var_03.var_745E == 0)
			{
				param_00 = var_03;
				break;
			}
		}
	}

	if(!isdefined(param_00))
	{
		return;
	}

	self setorigin(param_00.var_116 + (0,5,0));
	self setangles(param_00.var_1D + (0,90,0));
	wait(0.15);
	self method_85C9(1);
	wait 0.05;
	self method_85C9(0);
	self freezecontrols(1);
	maps\mp\gametypes\_hub_unk1::func_721A("mp_emote_sitting_loop");
}

//Function Number: 62
func_637D()
{
	self waittill("disconnect");
	level endon("game_ended");
	if(isdefined(self.var_572A) && !self.var_572A)
	{
		if(isdefined(level.var_4F38))
		{
			level.var_4F38.var_787F = common_scripts\utility::func_F93(level.var_4F38.var_787F,self);
		}

		self notify("luinotifyserver","enter_1v1",0);
	}
	else if(isdefined(self.var_572A) && self.var_572A)
	{
		self.var_2922 maps\mp\_1v1::func_3E22();
	}

	maps\mp\gametypes\_hub_unk1::func_2386(1);
	if(isdefined(self.var_34CD))
	{
		self.var_34CD maps\mp\gametypes\_hub_unk1::func_2DD2("duelChallenge");
		self.var_34CD notifyonplayercommandremove("accept_duel_challenge","+usereload");
		self.var_34CD notifyonplayercommandremove("reject_duel_challenge","+stance");
	}

	if(isdefined(self.var_A405))
	{
		if(isdefined(self.var_A405.var_1739))
		{
			self.var_A405.var_1739 delete();
			self.var_A405.var_1739 = undefined;
		}

		self.var_A405 delete();
		self.var_A405 = undefined;
	}

	if(isdefined(self.var_9B66))
	{
		self.var_9B66 delete();
	}

	foreach(var_01 in level.var_744A)
	{
		if(isdefined(var_01.var_746C))
		{
			if(!isdefined(self))
			{
				var_01.var_746C = common_scripts\utility::func_FA0(var_01.var_746C);
			}
			else
			{
				var_01.var_746C = common_scripts\utility::func_F98(self,var_01.var_746C);
			}

			var_01 nametagvisibleto(var_01.var_746C);
		}
	}

	if(isdefined(self.var_8B24))
	{
		self.var_8B24 thread maps\mp\gametypes\_hub_range::func_4B07(undefined,undefined,1);
	}
}

//Function Number: 63
func_906B()
{
	var_00 = [];
	var_01 = getdvarint("hub_reveal_num_planes",2);
	for(var_02 = 0;var_02 < var_01;var_02++)
	{
		var_03 = spawn("script_model",(400,-880,656));
		var_03.var_1D = (0,90,0);
		var_03 setmodel("usa_fighter_thunderbolt");
		var_03 method_8278("mp_hub_teaser_thunderbolt");
		var_00[var_02] = var_03;
		wait(0.5);
	}

	wait(15);
	foreach(var_03 in var_00)
	{
		var_03 delete();
	}
}