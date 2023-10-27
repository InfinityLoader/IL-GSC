/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\gametypes\zombie.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 78
 * Decompile Time: 3791 ms
 * Timestamp: 10/27/2023 12:03:33 AM
*******************************************************************/

//Function Number: 1
main()
{
	scripts\cp\_globallogic::init();
	level thread func_C56E();
	func_9569();
	func_97B3();
	func_97B4();
	scripts\cp\_music_and_dialog::init();
	if(getdvarint("gnet_build",0) != 0)
	{
		scripts\cp\_utility::coop_mode_enable(["pillage","loot","challenge","doors","wall_buys","crafting"]);
	}
	else
	{
		scripts\cp\_utility::coop_mode_enable(["pillage","loot","challenge","doors","guided_interaction","wall_buys","crafting","outline"]);
	}

	level.var_C048 = 0;
	level.var_C047 = 0;
	level.wave_num = 0;
	level.var_A9FB = ::func_13F37;
	level.disable_zombie_exo_abilities = 1;
	level.var_93A2 = ::scripts\cp\zombies\zombies_spawning::func_9C12;
	level.var_4C55 = ::lib_0D5B::func_8361;
	level.var_BC70 = ::lib_0D5B::func_12ED5;
	level.var_7FF3 = ::function_00B4;
	level.var_D84B = ::func_5032;
	level.callbackplayerdamage = ::scripts\cp\zombies\zombie_damage::func_375A;
	level.var_3763 = ::func_13F15;
	level.var_A9FD = ::func_13F1F;
	level.var_D869 = ::func_13F4B;
	level.var_12DED = ::lib_0D5A::func_12DEC;
	level.var_DDB5 = ::lib_0D42::func_DDB4;
	level.var_B079 = ::scripts\cp\zombies\zombies_spawning::func_13FA2;
	level.var_B07A = ::scripts\cp\zombies\_powerups::func_12DB8;
	level.var_12F74 = ::lib_0D41::func_12F73;
	level.var_13D69 = ::lib_0D43::func_CC08;
	level.var_164B = ::scripts\cp\zombies\_powerups::is_in_active_volume;
	level.var_768C = ::func_13F35;
	level.var_E49D = ::func_13F50;
	level.var_10A32 = ::scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate;
	level.var_A9FF = ::func_13F20;
	level.var_C574 = ::func_13F44;
	level.var_6324 = ::func_13F1E;
	level.hostmigrationend = ::zombiehostmigrationend;
	level.var_C53D = ::zombiehostmigrationstart;
	level.var_2117 = ::scripts\cp\zombies\arcade_game_utility::func_E2CB;
	level.var_C00B = 1;
	level.var_13F5B = 1;
	level.var_4CB4 = 1;
	level.var_4CC4 = 1;
	level.var_D75C = "cp/zombies/zombie_powertable.csv";
	level.var_10E5A = "mp/statstable.csv";
	level.var_7666 = "cp/zombies/mode_string_tables/zombies_statstable.csv";
	level.var_7665 = "cp/zombies/zombie_attachmentmap.csv";
	var_00 = getdvar("ui_mapname");
	level.var_D763 = "cp/zombies/" + var_00 + "_loot.csv";
	scripts\mp\_passives::init();
	scripts\cp\_weapon::func_13CCB();
	scripts\cp\_utility::func_8CC6(0);
	if(!isdefined(level.var_D782))
	{
		level.var_D782 = [];
	}

	level.var_C7E9 = [];
	level.var_8B38 = getdvarint("scr_aliens_hardcore");
	level.var_E4DD = getdvarint("scr_aliens_ricochet");
	level.var_3B1D = getdvarint("scr_aliens_casual");
	level.var_A8E0 = 0;
	level.var_A8F7 = [];
	level.var_3B0F = 1;
	level.var_9925 = 0;
	level.var_502E = "iw7_g18_zmr";
	level.var_C8A4 = 2;
	level.var_9B1A = 0;
	level.var_69D8 = 0.1;
	level.var_FEFD = 0.1;
	level.var_218B = 0.2;
	level.var_B4B0 = 10;
	scripts\cp\_outline::func_C776();
	scripts\cp\zombies\zombie_afterlife_arcade::func_94D7();
	lib_0D5A::func_97B7();
	scripts\cp\zombies\craftables\_gascan::init();
	lib_0CBC::main();
	scripts\cp\zombies\craftables\_fireworks_trap::init();
	lib_0D52::func_9700();
	lib_0D5B::init();
	scripts\cp\zombies\directors_cut::init();
	scripts\cp\zombies\direct_boss_fight::init();
	level scripts\cp\_hud_message::init();
	level thread lib_0D5E::func_96D5();
	func_53DC();
	level thread scripts\cp\_interaction::func_4627();
	level thread scripts\cp\_utility::func_83DA();
	level thread lib_0D56::init();
	level thread func_11010();
}

//Function Number: 2
func_2B53()
{
}

//Function Number: 3
func_136D7()
{
	while(!isdefined(level.players))
	{
		wait(0.1);
	}
}

//Function Number: 4
func_13F20(param_00)
{
	param_00 scripts\cp\powers\coop_powers::func_E2D1(param_00,param_00.var_D7CD);
	param_00 lib_0D5B::func_F53F(param_00,"healthy");
	param_00.flung = undefined;
	param_00 setclientomnvar("zm_ui_player_in_laststand",0);
	param_00 method_8070(0.5);
	param_00 scripts\cp\_utility::stoplocalsound_safe("zmb_laststand_music");
	param_00 method_8070(0.3);
	if(isdefined(level.var_13445))
	{
		param_00 thread func_E20F(0.2);
	}

	param_00 visionsetnakedforplayer("",0);
	var_01 = randomintrange(1,5);
	var_02 = "zmb_revive_music_lr_0" + var_01;
	if(soundexists(var_02))
	{
		param_00 playlocalsound(var_02);
	}

	if(param_00 scripts\cp\_utility::func_9E3A())
	{
		param_00 scripts\cp\_utility::func_1C5C(0);
	}

	if(scripts\common\utility::istrue(param_00.have_permanent_perks) && !scripts\common\utility::istrue(param_00.playing_ghosts_n_skulls))
	{
		param_00 thread give_permanent_perks(param_00);
	}
}

//Function Number: 5
give_permanent_perks(param_00)
{
	param_00 endon("disconnect");
	param_00 endon("last_stand");
	var_01 = ["perk_machine_boom","perk_machine_flash","perk_machine_fwoosh","perk_machine_more","perk_machine_rat_a_tat","perk_machine_revive","perk_machine_run","perk_machine_smack","perk_machine_tough","perk_machine_zap"];
	if(isdefined(level.all_perk_list))
	{
		var_01 = level.all_perk_list;
	}

	if(isdefined(self.current_perk_list))
	{
		var_01 = self.current_perk_list;
	}

	if(scripts\cp\_utility::isplayingsolo() || level.only_one_player)
	{
		var_01 = scripts\common\utility::func_22A9(var_01,"perk_machine_revive");
	}

	wait(1);
	foreach(var_03 in var_01)
	{
		if(param_00 scripts\cp\_utility::has_zombie_perk(var_03))
		{
			continue;
		}

		param_00 lib_0D5D::func_834E(var_03,0);
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 6
func_E20F(param_00)
{
	if(param_00 > 0)
	{
		wait(param_00);
	}

	if(isdefined(level.var_13445))
	{
		self visionsetnakedforplayer(level.var_13445,0.1);
	}
}

//Function Number: 7
func_97B3()
{
	scripts\common\utility::flag_init("insta_kill");
	scripts\common\utility::flag_init("introscreen_over");
	scripts\common\utility::flag_init("intro_gesture_done");
	scripts\common\utility::flag_init("pre_game_over");
	scripts\common\utility::flag_init("interactions_initialized");
}

//Function Number: 8
func_97B4()
{
	level._effect["goon_spawn_bolt"] = loadfx("vfx/iw7/_requests/coop/vfx_clown_spawn.vfx");
	level._effect["goon_spawn_bolt_underground"] = loadfx("vfx/iw7/_requests/coop/vfx_clown_spawn_indoor.vfx");
	level._effect["brute_spawn_bolt"] = loadfx("vfx/iw7/_requests/coop/vfx_brute_spawn.vfx");
	level._effect["brute_spawn_bolt_indoor"] = loadfx("vfx/iw7/_requests/coop/vfx_brute_spawn_indoor.vfx");
	level._effect["corpse_pop"] = loadfx("vfx/iw7/_requests/mp/vfx_body_expl");
	level._effect["bloody_death"] = loadfx("vfx/iw7/core/zombie/cards/vfx_zmb_card_headshot_exp.vfx");
	level._effect["gore"] = loadfx("vfx/iw7/core/impact/flesh/vfx_flesh_hit_body_meatbag_large.vfx");
	level._effect["stun_attack"] = loadfx("vfx/iw7/core/zombie/vfx_zmb_geotrail_tesla_01.vfx");
	level._effect["stun_shock"] = loadfx("vfx/iw7/core/zombie/vfx_zmb_shock_flash.vfx");
}

//Function Number: 9
func_9569()
{
	level.var_C5A4 = ::func_13F47;
	level.onspawnplayer = ::func_13F46;
	level.var_C580 = ::func_13F45;
}

//Function Number: 10
func_13F47()
{
	lib_0D2C::init();
	scripts\cp\_persistence::func_DEB5();
	if(isdefined(level.challenge_init_func))
	{
		[[ level.challenge_init_func ]]();
	}
	else
	{
		scripts\cp\_challenge::init_coop_challenge();
	}

	scripts\cp\zombies\zombie_analytics::init();
	scripts\cp\_laststand::func_F579(3000,5000);
	level.var_68C9 = [];
	level.var_F480 = ::func_F53A;
	scripts\cp\_persistence::func_DCD1();
	level.var_4D58 = 20;
	scripts\cp\_utility::func_1B70();
	if(scripts\cp\_utility::func_462B("loot"))
	{
		scripts\cp\zombies\_powerups::func_9670();
	}

	if(scripts\cp\_utility::func_462B("pillage"))
	{
		thread lib_0D5E::func_CB5A();
	}

	level thread func_8931();
	level thread func_E4A1();
	level.var_12EFF = ::func_12EFE;
	level scripts\common\utility::func_5127(0.2,::lib_0D4D::func_97B2);
	level.var_7674 = ::lib_0D5D::func_DEE2;
	lib_0CFE::func_97B6();
	lib_0CFE::func_96CF();
	if(isdefined(level.player_respawn_locations_init))
	{
		level thread [[ level.player_respawn_locations_init ]]();
	}

	thread lib_0D59::func_9589();
	if(isdefined(level.var_10815))
	{
		level thread [[ level.var_10815 ]]();
	}

	scripts\cp\zombies\zmb_zombies_weapons::init();
	lib_0D52::func_10CEF();
	level thread func_95C9();
	level thread scripts\cp\zombies\zombies_spawning::func_6514();
	level thread scripts\cp\_interaction::init();
	level thread lib_0D4C::func_97B1();
	level thread lib_0D51::func_96F4();
	level thread scripts\cp\zombies\interaction_magicwheel::func_94EF();
	level thread validate_door_buy_setup();
	level thread scripts\cp\zombies\directors_cut::start_directors_cut();
	if(scripts\cp\_utility::func_462B("wall_buys"))
	{
		level thread lib_0D2C::func_23DA();
	}
	else
	{
		scripts\cp\_interaction::func_55A2();
	}

	if(isdefined(level.var_F9F1))
	{
		level [[ level.var_F9F1 ]]();
	}
	else
	{
		func_F9F0();
	}

	level thread reset_variables_on_wave_start();
}

//Function Number: 11
func_F9F0()
{
	level.var_C6C1 = ["iw7_venomx_zm","iw7_venomx_zm_pap1+camo32","iw7_venomx_zm_pap2+camo34"];
}

//Function Number: 12
func_95C9()
{
	lib_0D60::func_13F54();
	scripts\cp\zombies\zombies_spawning::func_6512();
}

//Function Number: 13
reset_variables_on_wave_start()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("wave_starting");
		foreach(var_01 in level.players)
		{
			var_01.can_give_revive_xp = 1;
		}
	}
}

//Function Number: 14
func_13F45()
{
}

//Function Number: 15
func_13F46()
{
	onspawnplayer();
	thread lib_0D62::func_13F11();
}

//Function Number: 16
func_8931()
{
	wait(5);
	level notify("spawn_nondeterministic_entities");
	if(isdefined(level.post_nondeterministic_func))
	{
		level thread [[ level.post_nondeterministic_func ]]();
	}
}

//Function Number: 17
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		if(!isdefined(level.special_character_count))
		{
			level.special_character_count = 0;
		}

		if(!isai(var_00))
		{
			var_00 scripts\cp\_analytics::func_C4B8();
			var_00 thread watchforluinotifyweaponreset(var_00);
			if(isdefined(var_00.var_4539))
			{
				var_00.var_452A = var_00.var_4539;
			}
			else
			{
				var_00.var_452A = gettime();
			}

			if(scripts\cp\_utility::func_462B("outline"))
			{
				var_00 thread scripts\cp\_outline::func_C77A();
			}

			var_00.var_13E26 = getdvarint("online_zombies_xpscale");
			var_00.weaponxpscale = getdvarint("online_zombie_weapon_xpscale");
			if(var_00 scripts\cp\_utility::func_DCD5())
			{
				var_01 = getdvarint("online_zombie_party_weapon_xpscale");
				var_02 = getdvarint("online_zombie_party_xpscale");
				var_03 = var_00 method_85BE() > 1;
				if(isdefined(var_01))
				{
					if(var_03 && var_01 > 1)
					{
						var_00.weaponxpscale = var_01;
					}
				}

				if(isdefined(var_02))
				{
					if(var_03 && var_02 > 1)
					{
						var_00.var_13E26 = var_02;
					}
				}
			}

			var_00 thread scripts\cp\_globallogic::func_D0FB();
			var_00 lib_0A54::func_96EB();
			var_00 scripts\cp\_persistence::func_F282();
			var_00.var_C1F6 = [];
			var_00.var_BF74 = 0;
			var_00.var_11A21 = 0;
			var_00.can_give_revive_xp = 1;
			if(!isdefined(var_00.var_C8A2))
			{
				var_00.var_C8A2 = [];
			}

			if(!isdefined(var_00.var_D7A0))
			{
				var_00.var_D7A0 = [];
			}

			if(!isdefined(var_00.var_D782))
			{
				var_00.var_D782 = [];
			}

			if(!isdefined(var_00.var_D783))
			{
				var_00.var_D783 = [];
			}

			if(!isdefined(var_00.var_55BB))
			{
				var_00.var_55BB = [];
			}

			if(!isdefined(var_00.var_C54A))
			{
				var_00.var_C54A = [];
			}

			if(!isdefined(var_00.var_C5C9))
			{
				var_00.var_C5C9 = [];
			}

			if(!isdefined(var_00.var_C4E6))
			{
				var_00.var_C4E6 = [];
			}

			var_00 thread func_13F4A();
			var_00.var_55E3 = 0;
			var_00.var_55CD = 0;
			var_00 scripts\cp\_utility::allow_player_teleport(0);
			var_00.var_D721 = 0;
			var_00.var_1189F = 0;
			var_00.var_118DE = gettime();
			var_00.var_F1E7 = 0;
			var_00.max_self_revive_machine_use = 3;
			var_00.var_3B0F = 1;
			var_00.var_DDC2 = 0;
			var_00.ignorme_count = 0;
			var_00.infiniteammocounter = 0;
			var_00 scripts\cp\zombies\zombie_afterlife_arcade::func_974F(var_00);
			if(scripts\common\utility::flag("introscreen_over"))
			{
				if(isdefined(level.var_4C6C))
				{
					var_00 thread [[ level.var_4C6C ]]();
				}
				else
				{
					var_00 thread func_D0E1();
				}

				if(scripts\cp\_challenge::func_4B4B() && scripts\cp\_utility::func_462B("challenge"))
				{
					if(isdefined(level.var_3C1A))
					{
						var_00 thread [[ level.var_3C1A ]]();
					}
				}
			}

			var_00 scripts\cp\zombies\zombie_afterlife_arcade::func_D0F7(var_00);
			var_00 scripts\cp\_persistence::func_AAC4("waveNum",level.wave_num,1);
			var_00 lib_0D58::func_D0F6(var_00);
			var_00 lib_0D2C::func_FA1D(var_00);
			var_00 scripts\cp\_persistence::func_D225();
			var_00 thread scripts\cp\zombies\zombie_analytics::func_97A4(var_00);
			var_00 thread func_1110F(var_00);
			if(isdefined(level.custom_onplayerconnect_func))
			{
				[[ level.custom_onplayerconnect_func ]](var_00);
			}

			if(!scripts\cp\_utility::map_check(0) && !scripts\cp\_utility::map_check(1))
			{
				if(!isdefined(level.kick_player_queue))
				{
					level thread kick_player_queue_loop();
				}

				var_00 thread kick_for_inactivity(var_00);
			}
		}
	}
}

//Function Number: 18
watchforluinotifyweaponreset(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("weaponplayerdatafinished");
	var_01 = "cp/cp_wall_buy_models.csv";
	if(scripts\cp\_utility::map_check(3))
	{
		var_01 = "cp/cp_town_wall_buy_models.csv";
	}
	else if(scripts\cp\_utility::map_check(2))
	{
		var_01 = "cp/cp_disco_wall_buy_models.csv";
	}
	else if(scripts\cp\_utility::map_check(4))
	{
		var_01 = "cp/cp_final_wall_buy_models.csv";
	}

	for(;;)
	{
		param_00 waittill("luinotifyserver",var_02,var_03);
		if(isdefined(var_02))
		{
			if(var_02 == "reset_weapon_player_data")
			{
				var_04 = tablelookupbyrow(var_01,var_03,1);
				if(isdefined(var_04))
				{
					var_05 = tablelookup(var_01,0,var_03,2);
					if(isdefined(var_05) && var_05 != "")
					{
						param_00 setplayerdata("cp","zombiePlayerLoadout","zombiePlayerWeaponModels",var_05,"variantID",-1);
					}
				}

				continue;
			}

			if(var_02 == "weaponplayerdatafinished")
			{
				param_00 notify("weaponplayerdatafinished");
			}
		}
	}
}

//Function Number: 19
func_1110F(param_00)
{
	param_00 endon("disconnect");
	param_00 endon("kill_weapon_stream");
	level endon("game_ended");
	param_00 scripts\common\utility::waittill_any_timeout_1(10,"player_spawned");
	scripts\common\utility::flag_wait("wall_buy_setup_done");
	var_01 = [];
	var_02 = scripts\common\utility::getstructarray("interaction","targetname");
	foreach(var_04 in var_02)
	{
		if(isdefined(var_04.name) && var_04.name == "wall_buy")
		{
			var_01[var_01.size] = var_04;
		}
	}

	var_06 = 1;
	for(;;)
	{
		var_07 = 0;
		var_08 = 0;
		var_09 = [self.var_A913];
		var_0A = scripts\common\utility::func_782F(param_00.origin,var_01,undefined,10,5000,0);
		while(var_07 <= var_06 && var_08 < var_0A.size)
		{
			var_0B = scripts\cp\_utility::func_80D8(var_0A[var_08].script_noteworthy);
			if(isdefined(param_00.var_13C00[var_0B]))
			{
				var_0C = param_00.var_13C00[var_0B];
			}
			else
			{
				var_0C = var_0A[var_08].script_noteworthy;
			}

			var_09[var_09.size] = var_0C;
			var_09 = scripts\common\utility::func_22AF(var_09);
			var_07 = var_09.size;
			var_08++;
		}

		param_00 loadweaponsforplayer(var_09);
		wait(1);
	}
}

//Function Number: 20
func_D0E1()
{
	self endon("disconnect");
	self notify("intro_done");
	self notify("stop_intro");
	self waittill("spawned");
	thread hotjoin_protection();
	self.pers["hotjoined"] = 1;
	if(isdefined(level.wave_num))
	{
		self.wave_num_when_joined = level.wave_num;
	}

	var_00 = getdvar("ui_mapname");
	if(var_00 == "cp_rave")
	{
		disablepaspeaker("pa_speaker_stage_2");
		disablepaspeaker("pa_speaker_path");
		if(!scripts\common\utility::istrue(level.slasherpa))
		{
			disablepaspeaker("pa_super_slasher");
		}
	}

	if(var_00 == "cp_disco")
	{
		if(scripts\common\utility::istrue(level.ratking_playlist))
		{
			disablepaspeaker("pa_punk_alley_1");
			disablepaspeaker("pa_punk_subway_1");
			disablepaspeaker("pa_punk_subway_2");
			disablepaspeaker("pa_punk_rooftops_2");
			disablepaspeaker("pa_punk_rooftops_3");
			disablepaspeaker("pa_disco_street_1");
			disablepaspeaker("pa_disco_street_3");
			disablepaspeaker("pa_disco_subway_2");
			disablepaspeaker("pa_disco_subway_1");
			disablepaspeaker("pa_park_1");
		}
		else
		{
			disablepaspeaker("pa_punk_alley_1");
			disablepaspeaker("pa_punk_subway_1");
			disablepaspeaker("pa_punk_subway_2");
			disablepaspeaker("pa_punk_rooftops_2");
			disablepaspeaker("pa_punk_rooftops_3");
			disablepaspeaker("pa_disco_street_1");
			disablepaspeaker("pa_disco_street_3");
			disablepaspeaker("pa_disco_subway_2");
			disablepaspeaker("pa_disco_subway_1");
			disablepaspeaker("pa_park_1");
			disablepaspeaker("pa_disco_club");
			disablepaspeaker("pa_punk_club");
			disablepaspeaker("pa_rk_arena");
		}
	}

	if(var_00 == "cp_town")
	{
		if(!scripts\common\utility::istrue(level.var_D745))
		{
			disablepaspeaker("pa_town_icecream_out");
			disablepaspeaker("pa_town_icecream_in");
			disablepaspeaker("pa_town_snackshake_out");
			disablepaspeaker("pa_town_motel_out");
			disablepaspeaker("pa_town_market_in");
			disablepaspeaker("pa_town_market_out");
			disablepaspeaker("pa_town_camper_out");
		}
	}

	if(isdefined(self.var_9AFF))
	{
		self.var_9AFF.alpha = 1;
		wait(3);
		self.var_9AFF fadeovertime(3);
		self.var_9AFF.alpha = 0;
		wait(3);
		if(isdefined(self.var_9AFF))
		{
			self.var_9AFF destroy();
		}
	}

	while(!scripts\common\utility::istrue(self.photosetup))
	{
		wait(1);
	}

	self setclientomnvar("ui_hide_hud",0);
	self.var_DDAF = 0;
	wait(3);
	lib_0D59::func_96DB();
	scripts\cp\zombies\zombie_afterlife_arcade::func_974F(self);
	if(getdvar("ui_gametype") == "zombie")
	{
		self setclientomnvar("zombie_wave_number",level.wave_num);
	}

	if(isdefined(level.char_intro_gesture))
	{
		self [[ level.char_intro_gesture ]]();
	}

	level thread reenable_zombie_emmisive();
}

//Function Number: 21
reenable_zombie_emmisive()
{
	var_00 = scripts\mp\_mp_agent::func_7DB0("axis");
	foreach(var_02 in var_00)
	{
		if(scripts\common\utility::istrue(var_02.var_9CDD))
		{
			continue;
		}
		else if(scripts\common\utility::istrue(var_02.var_9CEF))
		{
			continue;
		}

		var_02 method_80BB(1,0.1);
		wait(0.05);
	}
}

//Function Number: 22
hotjoin_protection()
{
	self endon("disconnect");
	self.ignoreme = 1;
	self.ability_invulnerable = 1;
	wait(8);
	self.ignoreme = 0;
	self.ability_invulnerable = undefined;
}

//Function Number: 23
onspawnplayer()
{
	self.pers["gamemodeLoadout"] = level.var_1B77;
	self setclientomnvar("ui_refresh_hud",1);
	self.var_5BC1 = 1;
	self.var_6D82 = 0;
	self.var_9F28 = 0;
	self.var_9F23 = 0;
	self.var_9D81 = 0;
	self.var_9D6F = undefined;
	self.var_9E29 = undefined;
	self.var_3294 = undefined;
	self.var_FE4B = undefined;
	self.var_CF3E = undefined;
	self.var_C016 = 0;
	self.var_C004 = 0;
	self.var_55E3 = 0;
	self.var_55CD = 0;
	self.var_3859 = 1;
	self.ignorme_count = 0;
	self.ignoreme = 0;
	self.var_8EB0 = 1;
	self.flung = undefined;
	self.var_9C03 = 0;
	self.var_8BAE = 0;
	self.lastkilltime = gettime();
	self.lastmultikilltime = gettime();
	self setclientomnvar("zm_ui_player_in_laststand",0);
	func_98B8();
	thread lib_0CFD::func_139D2();
	if(!scripts\common\utility::istrue(level.dont_resume_wave_after_solo_afterlife))
	{
		if(!scripts\cp\_utility::isplayingsolo() && !level.only_one_player)
		{
			scripts\common\utility::func_6E2A("pause_wave_progression");
			level.var_13FA3 = 0;
		}
	}

	if(isdefined(level.custom_onspawnplayer_func))
	{
		self [[ level.custom_onspawnplayer_func ]]();
	}

	scripts\cp\_globallogic::func_D0FC();
	scripts\cp\_globallogic::func_D0F9();
	var_00 = func_7CA5(self);
	thread scripts\cp\_persistence::func_13683(var_00);
	func_F53A(999999);
	thread func_13A8E();
	thread scripts\cp\_utility::func_D3A5();
	thread scripts\cp\zombies\zombies_spawning::func_D1F7();
	thread scripts\cp\_hud_util::func_13F0D();
	thread scripts\cp\zombies\zmb_zombies_weapons::func_13C66();
	thread scripts\cp\zombies\zmb_zombies_weapons::func_26E0();
	if(isdefined(level.katana_damage_cone_func))
	{
		self thread [[ level.katana_damage_cone_func ]]();
	}

	thread scripts\cp\zombies\zmb_zombies_weapons::func_DF57();
	if(getdvar("ui_mapname") == "cp_zmb")
	{
		thread func_9B1A();
	}

	thread func_172D();
	thread scripts\cp\_weapon::func_13BAE();
	thread scripts\cp\_weapon::func_13BA5();
	thread scripts\cp\_weapon::func_13BA8();
	thread scripts\cp\_weapon::func_13B09();
	if(scripts\cp\_utility::isplayingsolo() || level.only_one_player)
	{
		thread scripts\cp\_hud_message::func_978F();
	}

	if(isdefined(self.anchor))
	{
		self.anchor delete();
	}

	scripts\cp\_utility::func_7298();
}

//Function Number: 24
func_98B8()
{
	self setclientomnvar("zombie_arcade_game_time",-1);
	self setclientomnvar("zombie_arcade_game_ticket_earned",0);
}

//Function Number: 25
func_172D()
{
	for(var_00 = 0;var_00 < level.players.size;var_00++)
	{
		if(self == level.players[var_00])
		{
			var_01 = var_00 + 1;
			if(var_01 == 5)
			{
				return;
			}

			self method_834E("player" + var_01);
		}
	}
}

//Function Number: 26
func_AEAD(param_00)
{
	var_01 = [];
	if(isdefined(param_00.var_D8E1))
	{
		var_01[var_01.size] = param_00.var_D8E1;
	}

	if(isdefined(param_00.var_F0C4))
	{
		var_01[var_01.size] = param_00.var_F0C4;
	}

	if(var_01.size > 0)
	{
		self loadweaponsforplayer(var_01);
	}
}

//Function Number: 27
func_7CA5(param_00)
{
	var_01 = param_00.var_10DA8;
	if(isdefined(var_01))
	{
		param_00.var_10DA8 = undefined;
		return var_01;
	}

	if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight())
	{
		return scripts\cp\zombies\direct_boss_fight::get_direct_to_boss_fight_starting_currency();
	}

	if(scripts\cp\zombies\directors_cut::directors_cut_activated_for(param_00))
	{
		return scripts\cp\zombies\directors_cut::get_directors_cut_starting_currency();
	}

	return scripts\cp\_persistence::func_7CA5();
}

//Function Number: 28
func_F53A(param_00)
{
	param_00 = int(param_00);
	self.var_B48A = param_00;
}

//Function Number: 29
func_E196()
{
	level endon("game_ended");
	foreach(var_01 in level.players)
	{
		thread func_E197(var_01);
	}
}

//Function Number: 30
func_E197(param_00)
{
	if(scripts\common\utility::istrue(param_00.kung_fu_mode))
	{
		param_00.refill_powers_after_kungfu = 1;
		return;
	}

	var_01 = getarraykeys(param_00.var_D782);
	foreach(var_03 in var_01)
	{
		if(param_00.var_D782[var_03].var_10307 == "secondary")
		{
			continue;
		}

		if(scripts\cp\_laststand::player_in_laststand(param_00))
		{
			param_00 thread func_135E6();
			continue;
		}

		param_00 thread func_DDD1(var_03);
	}

	if(isdefined(param_00.var_D7AE) && isdefined(param_00.var_D7AF))
	{
		param_00.var_D7AF = level.var_D782[param_00.var_D7AE].var_B486;
	}
}

//Function Number: 31
func_135E6()
{
	self endon("disconnect");
	level endon("game_ended");
	self waittill("spawned_player");
	wait(1);
	var_00 = getarraykeys(self.var_D782);
	if(var_00.size < 1)
	{
		return;
	}

	foreach(var_02 in var_00)
	{
		if(self.var_D782[var_02].var_10307 == "secondary")
		{
			continue;
		}

		thread func_DDD1(var_02);
	}
}

//Function Number: 32
func_DDD1(param_00)
{
	var_01 = 2;
	while(scripts\common\utility::istrue(self.var_D782[param_00].var_19))
	{
		wait(0.05);
	}

	while(scripts\common\utility::istrue(self.var_D782[param_00].var_12F6A))
	{
		wait(0.05);
	}

	scripts\cp\powers\coop_powers::func_D71A(var_01,"primary");
}

//Function Number: 33
func_E4A1()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("spawn_wave_done");
		foreach(var_01 in level.players)
		{
			if(scripts\cp\_laststand::player_in_laststand(var_01))
			{
				if(scripts\common\utility::istrue(var_01.var_A623))
				{
					level thread delayed_instant_revive(var_01);
					continue;
				}

				scripts\cp\_laststand::func_992F(var_01);
				thread scripts\cp\_vo::try_to_play_vo("respawn_round","zmb_comment_vo","high",5,0,0,1,60);
			}
		}
	}
}

//Function Number: 34
delayed_instant_revive(param_00)
{
	param_00 endon("disconnect");
	param_00 endon("revive");
	wait(4);
	scripts\cp\_laststand::func_992F(param_00);
	param_00 thread scripts\cp\_vo::try_to_play_vo("respawn_round","zmb_comment_vo","high",5,0,0,1,60);
}

//Function Number: 35
func_13F4B(param_00)
{
	param_00.var_10DA8 = param_00 scripts\cp\_persistence::func_7B8B();
	lib_0D50::func_EB61(param_00);
	param_00 lib_0D5D::func_E072();
	func_E49A(param_00);
	func_F5A8(param_00);
	func_1142A(param_00);
	scripts\cp\zombies\zombie_afterlife_arcade::func_12859(param_00);
}

//Function Number: 36
func_E49A(param_00)
{
	param_00 scripts\cp\_utility::func_4191();
	var_01 = param_00.var_4BF5;
	var_02 = weaponclipsize(var_01);
	var_03 = function_0249(var_01);
	var_04 = param_00.var_501C;
	var_05 = weaponclipsize(var_04);
	var_06 = function_0249(var_04);
	var_07 = "super_default_zm";
	var_08 = weaponclipsize("super_default_zm");
	var_09 = function_0249("super_default_zm");
	var_0A = [];
	var_0B = [];
	var_0C = [];
	var_0A[var_0A.size] = var_01;
	var_0B[var_01] = var_02;
	var_0C[var_01] = var_03;
	var_0A[var_0A.size] = var_04;
	var_0B[var_04] = var_05;
	var_0C[var_04] = var_06;
	var_0A[var_0A.size] = var_07;
	var_0B[var_07] = var_08;
	var_0C[var_07] = var_09;
	param_00 scripts\cp\_utility::func_1785(var_0A,var_0B,var_0C,var_04);
	param_00.var_D7CE = var_04;
	param_00.var_D7D0 = var_06;
	param_00.var_D7CF = var_05;
	param_00.var_AA45 = var_04;
}

//Function Number: 37
func_F5A8(param_00)
{
	var_01 = func_13F26(param_00);
	param_00.var_72E2 = var_01.origin;
	param_00.var_72E0 = var_01.angles;
}

//Function Number: 38
func_13F26(param_00)
{
	if(isdefined(level.force_respawn_location))
	{
		return [[ level.force_respawn_location ]](param_00);
	}

	if(!isdefined(level.active_player_respawn_locs) || level.active_player_respawn_locs.size == 0 || level.players.size == 0)
	{
		return [[ level.var_8136 ]]();
	}

	if(isdefined(level.respawn_loc_override_func))
	{
		return [[ level.respawn_loc_override_func ]](param_00);
	}

	var_01 = get_available_players(param_00);
	var_02 = func_784D(var_01);
	if(var_02.size == 0)
	{
		return get_respawn_loc_near_team_center(param_00,var_01);
	}

	if(var_02.size == 1)
	{
		return var_02[0];
	}

	return param_00 func_7C0B(var_01,var_02);
}

//Function Number: 39
get_available_players(param_00)
{
	var_01 = [];
	foreach(var_03 in level.players)
	{
		if(var_03 == param_00)
		{
			continue;
		}

		if(scripts\cp\_laststand::player_in_laststand(var_03))
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	return var_01;
}

//Function Number: 40
func_784D(param_00)
{
	var_01 = [];
	foreach(var_03 in level.active_player_respawn_locs)
	{
		if(!canspawn(var_03.origin))
		{
			continue;
		}

		if(positionwouldtelefrag(var_03.origin))
		{
			continue;
		}

		if(func_9CA5(var_03,param_00))
		{
			continue;
		}

		if(func_9CA4(var_03))
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	return var_01;
}

//Function Number: 41
func_9CA5(param_00,param_01)
{
	var_02 = 250000;
	foreach(var_04 in param_01)
	{
		if(distancesquared(var_04.origin,param_00.origin) < var_02)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 42
func_9CA4(param_00)
{
	var_01 = 250000;
	var_02 = scripts\mp\_mp_agent::func_7DB0("axis");
	foreach(var_04 in var_02)
	{
		if(distancesquared(var_04.origin,param_00.origin) < var_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 43
get_respawn_loc_near_team_center(param_00,param_01)
{
	var_02 = 0;
	var_03 = 0;
	var_04 = 0;
	var_05 = 0;
	foreach(var_07 in param_01)
	{
		var_02 = var_02 + var_07.origin[0];
		var_03 = var_03 + var_07.origin[1];
		var_04 = var_04 + var_07.origin[2];
		var_05++;
	}

	var_09 = (var_02 / var_05,var_03 / var_05,var_04 / var_05);
	var_0A = sortbydistance(level.active_player_respawn_locs,var_09);
	return var_0A[0];
}

//Function Number: 44
func_7C0B(param_00,param_01)
{
	var_02 = scripts\common\utility::func_116D7(param_00.size == 0,1,param_00.size);
	var_03 = level.spawned_enemies.size / var_02;
	var_04 = var_03 * 2;
	var_05 = -99999999;
	var_06 = undefined;
	foreach(var_08 in param_01)
	{
		var_09 = 0;
		foreach(var_0B in param_00)
		{
			if(var_0B == self)
			{
				continue;
			}

			if(!isalive(var_0B))
			{
				continue;
			}

			if(scripts\common\utility::istrue(var_0B.inlaststand))
			{
				var_09 = var_09 - distancesquared(var_0B.origin,var_08.origin) * var_04 * 2;
				continue;
			}

			var_09 = var_09 - distancesquared(var_0B.origin,var_08.origin) * var_04;
		}

		foreach(var_0E in level.spawned_enemies)
		{
			var_09 = var_09 + distancesquared(var_0E.origin,var_08.origin);
		}

		var_09 = var_09 / 1000000;
		if(var_09 > var_05)
		{
			var_05 = var_09;
			var_06 = var_08;
		}
	}

	return var_06;
}

//Function Number: 45
func_1142A(param_00)
{
	param_00.var_10932 = undefined;
}

//Function Number: 46
func_5032()
{
	var_00 = 0;
	if(!scripts\common\utility::istrue(level.var_9AF6))
	{
		var_00 = 10;
	}

	if(scripts\common\utility::istrue(game["gamestarted"]))
	{
		var_00 = 0;
	}

	if(var_00 > 0)
	{
		var_01 = level func_135D3();
		level thread func_100EA();
		if(isdefined(level.var_9AAC))
		{
			level thread [[ level.var_9AAC ]]();
		}

		wait(var_00 - 3);
		if(isdefined(level.var_D703))
		{
			[[ level.var_D703 ]]();
		}

		scripts\common\utility::flag_set("introscreen_over");
		level.var_9AF6 = 1;
	}
	else
	{
		wait(1);
		level.var_9AF6 = 1;
		scripts\common\utility::flag_set("introscreen_over");
	}

	if(scripts\common\utility::istrue(level.var_18F))
	{
	}
}

//Function Number: 47
func_100EA()
{
	if(isdefined(level.introscreen_text_func))
	{
		[[ level.introscreen_text_func ]]();
	}
}

//Function Number: 48
func_135D3()
{
	var_00 = undefined;
	if(level.players.size == 0)
	{
		level waittill("connected",var_00);
	}
	else
	{
		var_00 = level.players[0];
	}

	return var_00;
}

//Function Number: 49
func_13F4A()
{
	self endon("disconnect");
	self endon("stop_intro");
	self setclientomnvar("ui_hide_hud",1);
	self method_80AA();
	self.var_9AFF = newclienthudelem(self);
	self.var_9AFF.x = 0;
	self.var_9AFF.y = 0;
	self.var_9AFF setshader("black",640,480);
	self.var_9AFF.alignx = "left";
	self.var_9AFF.aligny = "top";
	self.var_9AFF.sort = 1;
	self.var_9AFF.horzalign = "fullscreen";
	self.var_9AFF.vertalign = "fullscreen";
	self.var_9AFF.alpha = 1;
	self.var_9AFF.foreground = 1;
	if(!scripts\common\utility::flag("introscreen_over"))
	{
		scripts\common\utility::flag_wait("introscreen_over");
	}

	self.var_9AFF fadeovertime(2);
	self.var_9AFF.alpha = 0;
	while(!scripts\common\utility::istrue(self.photosetup))
	{
		wait(1);
	}

	var_00 = 2;
	var_01 = getdvar("ui_mapname");
	if(var_01 == "cp_town" && !self issplitscreenplayer() && !isdefined(level.cp_town_bink_played) && !scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight())
	{
		wait(2);
		self playlocalsound("mus_zombies_title_splash");
		self setclientomnvar("zm_ui_dialpad_9",1);
		var_00 = 4;
		level.cp_town_bink_played = 1;
		wait(var_00);
	}
	else
	{
		wait(var_00);
	}

	self setclientomnvar("zm_ui_dialpad_9",0);
	self setclientomnvar("ui_hide_hud",0);
	if(isdefined(level.char_intro_music))
	{
		self thread [[ level.char_intro_music ]]();
	}

	if(var_01 != "cp_town")
	{
		wait(1.5);
	}

	self.var_9AFF destroy();
	if(var_01 != "cp_town")
	{
		func_CE90();
	}

	scripts\common\utility::flag_set("intro_gesture_done");
	lib_0D59::func_96DB();
	wait(3);
	if(isdefined(level.char_intro_gesture))
	{
		self [[ level.char_intro_gesture ]]();
	}

	wait(1.5);
	scripts\cp\_utility::func_7385(0);
	self enableweapons();
	if(var_01 == "cp_town" && isdefined(level.film_grain_off))
	{
		self setclientomnvar("zm_ui_dialpad_9",2);
	}
}

//Function Number: 50
func_CE90()
{
	self setweaponammostock("iw7_walkietalkie_zm",1);
	self giveandfireoffhand("iw7_walkietalkie_zm");
}

//Function Number: 51
func_B5C6()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("shock_melee_upgrade activated");
	self.var_B648 = 1;
	var_00 = 1;
	self.var_B648 = 0;
	var_01 = gettime();
	for(;;)
	{
		var_02 = gettime();
		if(var_02 - var_01 >= level.var_D3D7)
		{
			self.var_B648 = 1;
		}
		else
		{
			self.var_B648 = 0;
		}

		if(self meleebuttonpressed() && !self method_81B8() && !self usebuttonpressed())
		{
			var_01 = gettime();
			if(var_00 == 1)
			{
				var_00 = 0;
			}
		}
		else if(!self meleebuttonpressed())
		{
			var_00 = 1;
		}
		else
		{
			var_00 = 0;
		}

		wait(0.05);
	}
}

//Function Number: 52
func_8BF4()
{
	var_00 = 0;
	var_01 = self getweaponslist("primary");
	if(var_01.size > 0)
	{
		foreach(var_03 in var_01)
		{
			if(func_9E11(var_03))
			{
				var_00 = 1;
				break;
			}
		}
	}

	return var_00;
}

//Function Number: 53
func_9E11(param_00)
{
	var_01 = getweaponbasename(param_00);
	if(!isdefined(var_01))
	{
		return 0;
	}

	return param_00 == "iw7_glprox_zm";
}

//Function Number: 54
func_13A8E()
{
	self endon("death");
	self endon("disconnect");
	self endon("endExpJump");
	level endon("game_ended");
	var_00 = undefined;
	self notifyonplayercommand("fired","+attack");
	for(;;)
	{
		scripts\common\utility::waittill_any_3("weapon_switch_started","weapon_change","weaponchange");
		self notify("stop_regen_on_weapons");
		wait(0.1);
		var_01 = self getweaponslistall();
		foreach(var_03 in var_01)
		{
			if(func_9E11(var_03))
			{
				var_00 = 1;
				continue;
			}

			var_00 = 0;
		}
	}
}

//Function Number: 55
func_13F37(param_00)
{
	var_01 = param_00 scripts\cp\_persistence::func_7B8B();
	var_01 = var_01 * 0.05;
	var_01 = int(var_01 / 10) * 10;
	return var_01;
}

//Function Number: 56
func_13F15(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	scripts\cp\zombies\zombie_analytics::func_AF84(self,param_08);
	[[ level.var_3764 ]](param_00,param_01,param_02,param_04,param_05,param_07,param_08,param_09);
}

//Function Number: 57
func_1BA3()
{
}

//Function Number: 58
func_C4AB(param_00)
{
}

//Function Number: 59
func_53DC()
{
	if(getdvarint("zm_damage_numbers",0) == 1)
	{
		setomnvar("zm_dev_damage",1);
		return;
	}

	setomnvar("zm_dev_damage",0);
}

//Function Number: 60
func_D810()
{
	var_00 = " LB_" + getdvar("ui_mapname");
	if(scripts\cp\_utility::isplayingsolo())
	{
		var_00 = var_00 + "_SOLO";
	}
	else
	{
		var_00 = var_00 + "_COOP";
	}

	precacheleaderboards(var_00);
}

//Function Number: 61
func_13F1F(param_00)
{
	param_00.var_D7CD = param_00 scripts\cp\powers\coop_powers::func_7A3C(param_00);
	param_00 scripts\cp\powers\coop_powers::func_41D0();
	var_01 = param_00 getcurrentweapon();
	var_02 = getweaponbasename(var_01);
	var_03 = param_00 method_8118();
	if(!isdefined(param_00.var_5AFC[var_02]))
	{
		param_00.var_5AFC[var_02] = 1;
	}
	else
	{
		param_00.var_5AFC[var_02]++;
	}

	if(!scripts\common\utility::istrue(level.no_laststand_music))
	{
		param_00 scripts\cp\_utility::playlocalsound_safe("zmb_laststand_music");
	}

	param_00 method_8070(0);
	if(!self issplitscreenplayer())
	{
		param_00 method_82C3("last_stand_cp",0.02,"mix","reverb","filter");
	}

	param_00.have_self_revive = param_00 scripts\cp\_utility::has_zombie_perk("perk_machine_revive") || param_00 scripts\cp\_utility::func_9BA0("self_revive") && !scripts\common\utility::istrue(param_00.disable_self_revive_fnf);
	if(isdefined(level.have_self_revive_override))
	{
		param_00.have_self_revive = [[ level.have_self_revive_override ]](param_00);
	}

	if(param_00.have_self_revive)
	{
		var_04 = (scripts\cp\_utility::isplayingsolo() || level.only_one_player) && param_00 scripts\cp\_utility::has_zombie_perk("perk_machine_revive");
		param_00 notify("player_has_self_revive",var_04);
	}

	if(isdefined(param_00.mule_weapon) && !scripts\common\utility::istrue(param_00.playing_ghosts_n_skulls))
	{
		param_00.former_mule_weapon = param_00.mule_weapon;
	}
	else
	{
		param_00.former_mule_weapon = undefined;
	}

	param_00 lib_0D5D::func_E072();
	scripts\cp\zombies\zombie_analytics::func_AF68(1,param_00,var_01,var_03,param_00.var_DDB9,param_00.origin,level.wave_num,param_00.var_1AB);
	param_00 lib_0D56::func_AFD5();
	param_00 lib_0D5B::func_F53F(param_00,"laststand");
	param_00 scripts\cp\_utility::func_1C5C(1);
	param_00 setclientomnvar("zm_ui_player_in_laststand",1);
	param_00 setclientomnvarbit("player_damaged",2,0);
	param_00 visionsetnakedforplayer("last_stand_cp_zmb",1);
}

//Function Number: 62
func_9B1A()
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("death");
	var_00 = 0;
	var_01 = 1;
	if(!scripts\cp\_utility::is_codxp())
	{
		while(var_00 < 3)
		{
			level waittill("spawn_wave_done");
			if(0 == var_01 % 2 && var_01 > 1)
			{
				foreach(var_03 in level.players)
				{
					var_03 setclientomnvar("zm_nag_text",1);
				}

				var_00 = var_00 + 1;
			}

			var_01 = var_01 + 1;
			wait(0.5);
			foreach(var_03 in level.players)
			{
				var_03 setclientomnvar("zm_nag_text",0);
			}
		}
	}
}

//Function Number: 63
func_13F35()
{
	scripts\cp\zombies\zombie_afterlife_arcade::register_interactions();
	lib_0D3D::register_interactions();
	lib_0D50::register_interactions();
	lib_0D5D::register_interactions();
	lib_0D51::register_interactions();
	lib_0D42::register_interactions();
	lib_0D58::register_interactions();
}

//Function Number: 64
func_13F50(param_00)
{
	if(scripts\common\utility::istrue(param_00.in_afterlife_arcade))
	{
		return 0;
	}

	return 1;
}

//Function Number: 65
func_12EFE(param_00,param_01)
{
	self endon("disconnect");
	level endon("game_ended");
	self notify("updateRecentKills");
	self endon("updateRecentKills");
	self.var_DDC2++;
	var_02 = getweaponbasename(param_01);
	if(param_01 == "zmb_fireworksprojectile_mp")
	{
		if(!isdefined(self.var_A6C6[self.var_A039]))
		{
			self.var_A6C6[self.var_A039] = 1;
		}
		else
		{
			self.var_A6C6[self.var_A039]++;
		}
	}

	if(!isdefined(self.var_A682[var_02]))
	{
		self.var_A682[var_02] = 1;
	}
	else
	{
		self.var_A682[var_02]++;
	}

	if(!isdefined(self.var_DDC3))
	{
		self.var_DDC3 = [];
	}

	if(!isdefined(self.var_DDC3[param_01]))
	{
		self.var_DDC3[param_01] = 1;
	}
	else
	{
		self.var_DDC3[param_01]++;
	}

	var_03 = scripts\cp\_utility::func_7E9D(param_01);
	if(isdefined(var_03) && var_03 == "lethal")
	{
		if(self.var_DDC3[param_01] > 0 && self.var_DDC3[param_01] % 2 == 0)
		{
		}
	}

	wait(1.25);
	self.var_DDC2 = 0;
	self.var_DDC3 = undefined;
}

//Function Number: 66
func_11010()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("regular_wave_starting");
		if(level.wave_num >= 6)
		{
			break;
		}
	}

	function_01BD(1);
}

//Function Number: 67
func_13F44(param_00,param_01)
{
	scripts\cp\_persistence::func_666D(param_00);
	lib_0D5B::release_character_number(param_00);
	lib_0D5B::func_F53F(param_00,"healthy");
}

//Function Number: 68
func_13F1E(param_00,param_01)
{
	lib_0D59::func_13DFE(param_00,param_01);
}

//Function Number: 69
zombiehostmigrationstart()
{
	var_00 = scripts\mp\_mp_agent::func_7DB0("axis");
	foreach(var_02 in var_00)
	{
		var_03 = isdefined(var_02.agent_type) && var_02.agent_type == "zombie_brute" || var_02.agent_type == "zombie_grey" || var_02.agent_type == "superslasher" || var_02.agent_type == "slasher" || var_02.agent_type == "zombie_ghost";
		if(!var_03 && !var_02 scripts\cp\_utility::agentisinstakillimmune())
		{
			if(scripts\common\utility::istrue(var_02.var_EF64))
			{
				var_02.var_54CB = 1;
				var_02 suicide();
				continue;
			}

			if(scripts\common\utility::istrue(var_02.ignoreme))
			{
				var_02.var_54CB = 1;
				var_02 suicide();
				continue;
			}

			if(scripts\common\utility::istrue(var_02.var_180))
			{
				var_02.var_54CB = 1;
				var_02 suicide();
				continue;
			}

			if(!scripts\common\utility::istrue(var_02.entered_playspace))
			{
				var_02.var_54CB = 1;
				var_02 suicide();
				continue;
			}
		}

		var_02.var_EF64 = 1;
		var_02 method_8286(var_02.origin);
		var_02.ignoreme = 1;
		var_02.var_180 = 1;
	}
}

//Function Number: 70
zombiehostmigrationend()
{
	reenable_zombie_emmisive();
	thread resetplayerhud();
	var_00 = scripts\mp\_mp_agent::func_7DB0("axis");
	foreach(var_02 in var_00)
	{
		var_02.var_EF64 = 0;
		var_02.ignoreme = 0;
		var_02.var_180 = 0;
	}

	if(isdefined(level.customhostmigrationend))
	{
		level thread [[ level.customhostmigrationend ]]();
	}
}

//Function Number: 71
resetplayerhud()
{
	foreach(var_01 in level.players)
	{
		var_01 setclientomnvar("zm_consumable_selection_ready",20);
		var_01 setclientomnvar("zm_dpad_up_activated",6);
		var_01 setclientomnvar("zombie_wave_number",0);
		wait(0.1);
		var_01 setclientomnvar("zm_consumables_remaining",var_01.var_1030B.size);
		var_01 setclientomnvar("zombie_wave_number",level.wave_num);
		wait(0.1);
		if(scripts\common\utility::istrue(var_01.deck_select_ready))
		{
			var_01 setclientomnvar("zm_consumable_selection_ready",1);
		}
		else
		{
			var_01 setclientomnvar("zm_consumable_selection_ready",0);
		}

		wait(0.1);
	}
}

//Function Number: 72
validate_door_buy_setup()
{
	level endon("game_ended");
	scripts\common\utility::flag_wait("introscreen_over");
	var_00 = scripts\common\utility::getstructarray("interaction","targetname");
	foreach(var_02 in var_00)
	{
		if(issubstr(var_02.script_noteworthy,"debris"))
		{
			var_03 = getentarray(var_02.target,"targetname");
			if(var_03.size < 2)
			{
			}
		}
	}
}

//Function Number: 73
kick_for_inactivity(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 thread check_for_move_change();
	param_00 thread check_for_movement();
	param_00.input_has_happened = 0;
	var_01 = gettime();
	var_02 = level.onlinegame && !getdvarint("xblive_privatematch");
	if(var_02)
	{
		param_00 notifyonplayercommand("inputReceived","+speed_throw");
		param_00 notifyonplayercommand("inputReceived","+stance");
		param_00 notifyonplayercommand("inputReceived","+goStand");
		param_00 notifyonplayercommand("inputReceived","+usereload");
		param_00 notifyonplayercommand("inputReceived","+activate");
		param_00 notifyonplayercommand("inputReceived","+melee_zoom");
		param_00 notifyonplayercommand("inputReceived","+breath_sprint");
		param_00 notifyonplayercommand("inputReceived","+attack");
		param_00 notifyonplayercommand("inputReceived","+frag");
		param_00 notifyonplayercommand("inputReceived","+smoke");
		var_03 = 120;
		var_04 = 0.1;
		for(;;)
		{
			if(isdefined(level.wave_num) && level.wave_num > 5)
			{
				break;
			}

			var_05 = scripts\common\utility::waittill_any_timeout_no_endon_death_2(var_04,"inputReceived","currency_earned");
			if(gettime() - var_01 < 30000)
			{
				continue;
			}

			if(var_05 != "timeout")
			{
				var_03 = 120;
				param_00.input_has_happened = 1;
				continue;
			}

			if(!scripts\common\utility::istrue(param_00.in_afterlife_arcade) && !scripts\common\utility::istrue(param_00.inlaststand))
			{
				var_03 = var_03 - var_04;
			}

			if(var_03 < 0)
			{
				if(level.players.size > 1)
				{
					if(param_00.input_has_happened)
					{
						param_00.input_has_happened = 0;
						continue;
					}

					add_to_kick_queue(param_00);
					break;
				}
			}
		}
	}
}

//Function Number: 74
check_for_movement()
{
	level endon("game_ended");
	self endon("disconnect");
	var_00 = level.onlinegame && !getdvarint("xblive_privatematch");
	if(var_00)
	{
		var_01 = self getnormalizedmovement();
		var_02 = gettime();
		for(;;)
		{
			wait(0.2);
			var_03 = self getnormalizedmovement();
			if(var_03[0] == var_01[0] && var_03[1] == var_01[1])
			{
				if(gettime() - var_02 > 90000 && level.players.size > 1)
				{
					add_to_kick_queue(self);
				}

				continue;
			}

			return;
		}
	}
}

//Function Number: 75
add_to_kick_queue(param_00)
{
	if(!scripts\common\utility::func_693B(level.kick_player_queue,param_00))
	{
		level.kick_player_queue = scripts\common\utility::array_add_safe(level.kick_player_queue,param_00);
	}
}

//Function Number: 76
kick_player_queue_loop()
{
	level.kick_player_queue = [];
	for(;;)
	{
		if(level.kick_player_queue.size > 0)
		{
			foreach(var_01 in level.kick_player_queue)
			{
				if(!isdefined(var_01))
				{
					continue;
				}

				if(!var_01 ishost())
				{
					kick(var_01 getentitynumber(),"EXE_PLAYERKICKED_INACTIVE");
				}
			}

			if(level.kick_player_queue.size > 0)
			{
				foreach(var_01 in level.kick_player_queue)
				{
					if(!isdefined(var_01))
					{
						continue;
					}

					kick(var_01 getentitynumber(),"EXE_PLAYERKICKED_INACTIVE");
				}
			}

			level.kick_player_queue = [];
		}

		wait(0.1);
	}
}

//Function Number: 77
check_for_move_change()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("done_inactivity_check");
	while(!isdefined(self.model))
	{
		wait(0.1);
	}

	var_00 = 1;
	var_01 = var_00;
	var_02 = var_00;
	for(;;)
	{
		var_03 = self getnormalizedmovement();
		var_01 = get_move_direction_from_vectors(var_03);
		if(var_02 != var_01)
		{
			var_02 = var_01;
			self notify("inputReceived");
		}

		wait(0.1);
	}
}

//Function Number: 78
get_move_direction_from_vectors(param_00)
{
	var_01 = 1;
	var_02 = 2;
	var_03 = 3;
	var_04 = 4;
	var_05 = 5;
	var_06 = 6;
	var_07 = 7;
	var_08 = 8;
	var_09 = var_01;
	if(param_00[0] > 0)
	{
		if(param_00[1] <= 0.7 && param_00[1] >= -0.7)
		{
			var_09 = var_01;
		}

		if(param_00[0] > 0.5 && param_00[1] > 0.7)
		{
			var_09 = var_02;
		}
		else if(param_00[0] > 0.5 && param_00[1] < -0.7)
		{
			var_09 = var_03;
		}
	}
	else if(param_00[0] < 0)
	{
		if(param_00[1] < 0.4 && param_00[1] > -0.4)
		{
			var_09 = var_04;
		}

		if(param_00[0] < -0.5 && param_00[1] > 0.5)
		{
			var_09 = var_05;
		}
		else if(param_00[0] < -0.5 && param_00[1] < -0.5)
		{
			var_09 = var_06;
		}
	}
	else if(param_00[1] > 0.4)
	{
		var_09 = var_07;
	}
	else if(param_00[1] < -0.4)
	{
		var_09 = var_08;
	}

	return var_09;
}