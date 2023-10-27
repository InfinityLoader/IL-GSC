/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_load.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 171
 * Decompile Time: 2904 ms
 * Timestamp: 10/27/2023 2:33:49 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(!isdefined(level.func))
	{
		level.func = [];
	}

	level.func["setsaveddvar"] = ::setsaveddvar;
	level.func["useanimtree"] = ::useanimtree;
	level.func["setanim"] = ::setanim;
	level.func["setanimknob"] = ::setanimknob;
	level.func["clearanim"] = ::clearanim;
	level.func["kill"] = ::kill;
	set_early_level();
	level.global_callbacks = [];
	level.global_callbacks["_autosave_stealthcheck"] = ::global_empty_callback;
	level.global_callbacks["_patrol_endon_spotted_flag"] = ::global_empty_callback;
	level.global_callbacks["_spawner_stealth_default"] = ::global_empty_callback;
	level.global_callbacks["_idle_call_idle_func"] = ::global_empty_callback;
	if(!isdefined(level.visionthermaldefault))
	{
		level.visionthermaldefault = "cheat_bw";
	}

	visionsetthermal(level.visionthermaldefault);
	visionsetpain("near_death");
	level.func["damagefeedback"] = ::maps\_damagefeedback::updatedamagefeedback;
	common_scripts\utility::array_thread(getentarray("script_model_pickup_claymore","classname"),::claymore_pickup_think_global);
	common_scripts\utility::array_thread(getentarray("ammo_cache","targetname"),::ammo_cache_think_global);
	maps\_utility::array_delete(getentarray("trigger_multiple_softlanding","classname"));
	if(getdvar("debug") == "")
	{
		setdvar("debug","0");
	}

	if(getdvar("fallback") == "")
	{
		setdvar("fallback","0");
	}

	if(getdvar("angles") == "")
	{
		setdvar("angles","0");
	}

	if(getdvar("noai") == "")
	{
		setdvar("noai","off");
	}

	if(getdvar("scr_RequiredMapAspectratio") == "")
	{
		setdvar("scr_RequiredMapAspectratio","1");
	}

	setdvar("ac130_player_num",-1);
	maps\_utility::clear_custom_eog_summary();
	setdvar("ui_remotemissile_playernum",0);
	setdvar("ui_pmc_won",0);
	if(!isdefined(level.notetracks))
	{
		anim.notetracks = [];
		animscripts/notetracks::registernotetracks();
	}

	maps\_utility::add_start("no_game",::start_nogame);
	add_no_game_starts();
	level._loadstarted = 1;
	level.first_frame = 1;
	level.level_specific_dof = 0;
	thread remove_level_first_frame();
	level.wait_any_func_array = [];
	level.var_1A14 = [];
	level.run_call_after_wait_array = [];
	level.var_1A16 = [];
	level.var_1A17 = [];
	level.var_1A18 = [];
	if(!isdefined(level.script))
	{
		level.script = tolower(getdvar("mapname"));
	}

	maps\_specialops::func_13B3();
	if(maps\_utility::is_specialop() && issplitscreen() || getdvar("coop") == "1")
	{
		setdvar("solo_play","");
	}

	if(issubstr(level.script,"so_survival_"))
	{
	}
	else
	{
	}

	level.xp_enable = 0;
	if(maps\_utility::is_specialop())
	{
		level.xp_enable = 1;
		if(maps\_utility::is_survival())
		{
			level.var_1658 = 2;
		}
		else
		{
			level.var_1658 = 1;
		}
	}
	else
	{
		level.var_1658 = 0;
	}

	level.dirteffectmenu["center"] = "dirt_effect_center";
	level.dirteffectmenu["left"] = "dirt_effect_left";
	level.dirteffectmenu["right"] = "dirt_effect_right";
	precachemenu(level.dirteffectmenu["center"]);
	precachemenu(level.dirteffectmenu["left"]);
	precachemenu(level.dirteffectmenu["right"]);
	precacheshader("fullscreen_dirt_bottom_b");
	precacheshader("fullscreen_dirt_bottom");
	precacheshader("fullscreen_dirt_left");
	precacheshader("fullscreen_dirt_right");
	precacheshader("fullscreen_bloodsplat_bottom");
	precacheshader("fullscreen_bloodsplat_left");
	precacheshader("fullscreen_bloodsplat_right");
	level.var_1A1A = 0;
	if(!isdefined(level.flag))
	{
		common_scripts\utility::init_flags();
	}
	else
	{
		var_00 = getarraykeys(level.flag);
		common_scripts\utility::array_levelthread(var_00,::check_flag_for_stat_tracking);
	}

	init_level_players();
	if(maps\_utility::func_E89())
	{
		maps\_coop::main();
	}

	if(maps\_utility::laststand_enabled())
	{
		maps\_laststand::main();
	}

	if(issplitscreen())
	{
		setsaveddvar("cg_fovScale","0.75");
	}
	else
	{
		setsaveddvar("cg_fovScale","1");
	}

	level.radiation_totalpercent = 0;
	common_scripts\utility::flag_init("missionfailed");
	common_scripts\utility::flag_init("auto_adjust_initialized");
	common_scripts\utility::flag_init("_radiation_poisoning");
	common_scripts\utility::flag_init("gameskill_selected");
	common_scripts\utility::flag_init("battlechatter_on_thread_waiting");
	thread maps\_gameskill::func_1A1C();
	thread player_death_detection();
	level.default_run_speed = 190;
	setsaveddvar("g_speed",level.default_run_speed);
	if(maps\_utility::is_specialop())
	{
		setsaveddvar("sv_saveOnStartMap",0);
	}
	else if(maps\_utility::arcademode())
	{
		setsaveddvar("sv_saveOnStartMap",0);
		thread arcademode_save();
	}
	else if(isdefined(level.credits_active))
	{
		setsaveddvar("sv_saveOnStartMap",0);
	}
	else
	{
		setsaveddvar("sv_saveOnStartMap",1);
	}

	common_scripts\utility::create_lock("mg42_drones");
	common_scripts\utility::create_lock("mg42_drones_target_trace");
	level.dronestruct = [];
	foreach(var_03, var_02 in level.struct)
	{
		if(!isdefined(var_02.targetname))
		{
			continue;
		}

		if(var_02.targetname == "delete_on_load")
		{
			level.struct[var_03] = undefined;
		}
	}

	common_scripts\utility::struct_class_init();
	common_scripts\utility::flag_init("respawn_friendlies");
	common_scripts\utility::flag_init("player_flashed");
	level.var_1A1E = ::maps\_utility::arcademode_kill;
	level.connectpathsfunction = ::connectpaths;
	level.disconnectpathsfunction = ::disconnectpaths;
	level.badplace_cylinder_func = ::badplace_cylinder;
	level.badplace_delete_func = ::badplace_delete;
	level.isaifunc = ::isai;
	level.createclientfontstring_func = ::maps\_hud_util::createclientfontstring;
	level.hudsetpoint_func = ::maps\_hud_util::setpoint;
	level.makeentitysentient_func = ::makeentitysentient;
	level.freeentitysentient_func = ::freeentitysentient;
	level.laseron_func = ::laserforceon;
	level.laseroff_func = ::laserforceoff;
	level.var_1A25 = ::maps\_player_stats::register_kill;
	level.stat_track_damage_func = ::maps\_player_stats::register_shot_hit;
	level.dopickyautosavechecks = 1;
	level.autosave_threat_check_enabled = 1;
	level.getnodefunction = ::getnode;
	level.getnodearrayfunction = ::getnodearray;
	if(!isdefined(level._notetrackfx))
	{
		level._notetrackfx = [];
	}

	foreach(var_05 in level.players)
	{
		var_05.maxhealth = level.player.health;
		var_05.shellshocked = 0;
		var_05.inwater = 0;
		var_05 thread watchweaponchange();
	}

	level.last_mission_sound_time = -5000;
	level.hero_list = [];
	thread precache_script_models();
	for(var_07 = 0;var_07 < level.players.size;var_07++)
	{
		var_05 = level.players[var_07];
		var_05 thread maps\_utility::flashmonitor();
		var_05 thread maps\_utility::shock_ondeath();
	}

	precachemodel("fx");
	precachemodel("tag_origin");
	precacheshellshock("victoryscreen");
	precacheshellshock("default");
	precacheshellshock("flashbang");
	precacheshellshock("dog_bite");
	precacherumble("damage_heavy");
	precacherumble("damage_light");
	precacherumble("grenade_rumble");
	precacherumble("artillery_rumble");
	precachestring(&"GAME_GET_TO_COVER");
	precachestring(&"GAME_LAST_STAND_GET_BACK_UP");
	precachestring(&"SCRIPT_GRENADE_DEATH");
	precachestring(&"SCRIPT_GRENADE_SUICIDE_LINE1");
	precachestring(&"SCRIPT_GRENADE_SUICIDE_LINE2");
	precachestring(&"SCRIPT_EXPLODING_VEHICLE_DEATH");
	precachestring(&"SCRIPT_EXPLODING_DESTRUCTIBLE_DEATH");
	precachestring(&"SCRIPT_EXPLODING_BARREL_DEATH");
	precacheshader("hud_grenadeicon");
	precacheshader("hud_grenadepointer");
	precacheshader("hud_burningcaricon");
	precacheshader("death_juggernaut");
	precacheshader("death_friendly_fire");
	precacheshader("hud_destructibledeathicon");
	precacheshader("hud_burningbarrelicon");
	precacheshader("waypoint_ammo");
	level._effect["deathfx_bloodpool_generic"] = loadfx("impacts/deathfx_bloodpool_generic");
	animscripts/pain::initpainfx();
	animscripts/melee::melee_init();
	level.createfx_enabled = getdvar("createfx") != "";
	slowmo_system_init();
	maps\_mgturret::main();
	setupexploders();
	maps\_art::main();
	maps\_noder::main();
	common_scripts\_painter::main();
	maps\_gameskill::setskill();
	maps\_anim::init();
	thread common_scripts\_fx::initfx();
	if(level.createfx_enabled)
	{
		level.var_1750 = 1;
		maps\_createfx::createfx();
	}

	maps\_global_fx::main();
	maps\_detonategrenades::init();
	thread setup_simple_primary_lights();
	maps\_names::setup_names();
	if(isdefined(level.handle_starts_endons))
	{
		thread [[ level.handle_starts_endons ]]();
	}
	else
	{
		thread func_1AB5();
	}

	if(!isdefined(level.trigger_flags))
	{
		common_scripts\utility::init_trigger_flags();
	}

	level.killspawn_groups = [];
	init_script_triggers();
	setsaveddvar("ufoHitsTriggers","0");
	func_1B7A();
	if(getdvar("g_connectpaths") == "2")
	{
		level waittill("eternity");
	}

	maps\_autosave::main();
	if(!isdefined(level.animsounds))
	{
		thread maps\_debug::func_1599();
	}

	maps\_anim::init();
	maps\_audio::aud_init();
	if(isdefined(level.audio_stringtable_mapname))
	{
		maps\_audio::set_stringtable_mapname(level.audio_stringtable_mapname);
	}

	anim.usefacialanims = 0;
	if(!isdefined(level.var_1291))
	{
		level.var_1291 = 0;
	}

	maps\_loadout::init_loadout();
	common_scripts\_destructible::init();
	thread common_scripts\_elevator::init();
	thread common_scripts\_pipes::main();
	thread maps\_vehicle::init_vehicles();
	setobjectivetextcolors();
	common_scripts\_dynamic_world::init();
	setsaveddvar("ui_campaign",level.campaign);
	thread maps\_introscreen::main();
	thread maps\_quotes::main();
	thread maps\_shutter::main();
	thread maps\_endmission::main();
	thread maps\_damagefeedback::init();
	thread maps\_escalator::init();
	maps\_friendlyfire::main();
	common_scripts\utility::array_levelthread(getentarray("badplace","targetname"),::badplace_think);
	common_scripts\utility::array_levelthread(getentarray("delete_on_load","targetname"),::maps\_utility::deleteent);
	common_scripts\utility::array_thread(getnodearray("traverse","targetname"),::func_1A97);
	common_scripts\utility::array_thread(getentarray("piano_key","targetname"),::func_1A9A);
	common_scripts\utility::array_thread(getentarray("piano_damage","targetname"),::func_1A99);
	common_scripts\utility::array_thread(getentarray("water","targetname"),::waterthink);
	common_scripts\utility::array_thread(getentarray("kill_all_players","targetname"),::kill_all_players_trigger);
	common_scripts\utility::flag_init("allow_ammo_pickups");
	common_scripts\utility::flag_set("allow_ammo_pickups");
	common_scripts\utility::array_thread(getentarray("ammo_pickup_grenade_launcher","targetname"),::ammo_pickup,"grenade_launcher");
	common_scripts\utility::array_thread(getentarray("ammo_pickup_rpg","targetname"),::ammo_pickup,"rpg");
	common_scripts\utility::array_thread(getentarray("ammo_pickup_c4","targetname"),::ammo_pickup,"c4");
	common_scripts\utility::array_thread(getentarray("ammo_pickup_claymore","targetname"),::ammo_pickup,"claymore");
	common_scripts\utility::array_thread(getentarray("ammo_pickup_556","targetname"),::ammo_pickup,"556");
	common_scripts\utility::array_thread(getentarray("ammo_pickup_762","targetname"),::ammo_pickup,"762");
	common_scripts\utility::array_thread(getentarray("ammo_pickup_45","targetname"),::ammo_pickup,"45");
	common_scripts\utility::array_thread(getentarray("ammo_pickup_pistol","targetname"),::ammo_pickup,"pistol");
	thread maps\_interactive_objects::main();
	thread maps\_intelligence::main();
	thread maps\_gameskill::func_1A32();
	for(var_07 = 0;var_07 < level.players.size;var_07++)
	{
		var_05 = level.players[var_07];
		var_05 thread maps\_gameskill::playerhealthregen();
		var_05 thread playerdamagerumble();
	}

	thread player_special_death_hint();
	thread func_1AA3();
	common_scripts\utility::flag_init("spawning_friendlies");
	common_scripts\utility::flag_init("friendly_wave_spawn_enabled");
	common_scripts\utility::flag_clear("spawning_friendlies");
	level.friendly_spawner["rifleguy"] = getentarray("rifle_spawner","script_noteworthy");
	level.friendly_spawner["smgguy"] = getentarray("smg_spawner","script_noteworthy");
	level.var_1A35 = [];
	level.var_1A35["allies"] = [];
	level.var_1A35["axis"] = [];
	level.var_1A35["team3"] = [];
	level.var_1A35["neutral"] = [];
	thread maps\_spawner::goalvolumes();
	thread maps\_spawner::func_1A37();
	thread maps\_spawner::friendlychain_ondeath();
	common_scripts\utility::array_thread(getentarray("friendly_spawn","targetname"),::maps\_spawner::friendlyspawnwave);
	common_scripts\utility::array_thread(getentarray("flood_and_secure","targetname"),::maps\_spawner::func_1A3A);
	common_scripts\utility::array_thread(getentarray("window_poster","targetname"),::func_1B6B);
	if(!isdefined(level.trigger_hint_string))
	{
		level.trigger_hint_string = [];
		level.var_1A3C = [];
	}

	level.shared_portable_turrets = [];
	level.spawn_groups = [];
	maps\_spawner::main();
	common_scripts\utility::array_thread(getentarray("background_block","targetname"),::background_block);
	maps\_hud::init();
	thread func_1B2A();
	thread maps\_animatedmodels::main();
	if(maps\_utility::func_E89())
	{
		thread maps\_loadout::coop_gamesetup_menu();
	}

	thread weapon_ammo();
	if(maps\_utility::is_specialop())
	{
		maps\_specialops::specialops_init();
	}

	if(level.script == level.missionsettings.var_14AA[0].name && !level.player getlocalplayerprofiledata("hasEverPlayed_SP"))
	{
		level.player setlocalplayerprofiledata("hasEverPlayed_SP",1);
		updategamerprofile();
	}

	level notify("load_finished");
}

//Function Number: 2
get_load_trigger_classes()
{
	var_00 = [];
	if(!maps\_utility::func_17D7())
	{
	}

	return var_41;
}

//Function Number: 3
get_load_trigger_funcs()
{
	var_00 = [];
	if(!maps\_utility::func_17D7())
	{
	}

	if(maps\_utility::func_E89())
	{
	}

	return var_41;
}

//Function Number: 4
init_script_triggers()
{
	var_00 = get_load_trigger_classes();
	var_01 = get_load_trigger_funcs();
	foreach(var_05, var_03 in var_00)
	{
		var_04 = getentarray(var_05,"classname");
		common_scripts\utility::array_levelthread(var_04,var_03);
	}

	var_06 = getentarray("trigger_multiple","classname");
	var_07 = getentarray("trigger_radius","classname");
	var_04 = maps\_utility::array_merge(var_06,var_07);
	var_08 = getentarray("trigger_disk","classname");
	var_04 = maps\_utility::array_merge(var_04,var_08);
	var_09 = getentarray("trigger_once","classname");
	var_04 = maps\_utility::array_merge(var_04,var_09);
	if(!maps\_utility::func_17D7())
	{
		for(var_0A = 0;var_0A < var_04.size;var_0A++)
		{
			if(var_04[var_0A].spawnflags & 32)
			{
				thread maps\_spawner::func_1A40(var_04[var_0A]);
			}
		}
	}

	for(var_0B = 0;var_0B < 7;var_0B++)
	{
		switch(var_0B)
		{
			case 0:
				var_0C = "trigger_multiple";
				break;

			case 1:
				var_0C = "trigger_once";
				break;

			case 2:
				var_0C = "trigger_use";
				break;

			case 3:
				var_0C = "trigger_radius";
				break;

			case 4:
				var_0C = "trigger_lookat";
				break;

			case 5:
				var_0C = "trigger_disk";
				break;

			default:
				var_0C = "trigger_damage";
				break;
		}

		var_04 = getentarray(var_0C,"code_classname");
		for(var_0A = 0;var_0A < var_04.size;var_0A++)
		{
			if(isdefined(var_04[var_0A].script_flag_true))
			{
				level thread script_flag_true_trigger(var_04[var_0A]);
			}

			if(isdefined(var_04[var_0A].script_flag_false))
			{
				level thread func_1AE3(var_04[var_0A]);
			}

			if(isdefined(var_04[var_0A].script_autosavename) || isdefined(var_04[var_0A].script_autosave))
			{
				level thread maps\_autosave::autosavenamethink(var_04[var_0A]);
			}

			if(isdefined(var_04[var_0A].script_fallback))
			{
				level thread maps\_spawner::fallback_think(var_04[var_0A]);
			}

			if(isdefined(var_04[var_0A].script_mgturretauto))
			{
				level thread maps\_mgturret::mgturret_auto(var_04[var_0A]);
			}

			if(isdefined(var_04[var_0A].var_13F6))
			{
				level thread maps\_spawner::kill_spawner(var_04[var_0A]);
			}

			if(isdefined(var_04[var_0A].script_kill_vehicle_spawner))
			{
				level thread maps\_vehicle::func_1A53(var_04[var_0A]);
			}

			if(isdefined(var_04[var_0A].script_emptyspawner))
			{
				level thread maps\_spawner::empty_spawner(var_04[var_0A]);
			}

			if(isdefined(var_04[var_0A].script_prefab_exploder))
			{
				var_04[var_0A].script_exploder = var_04[var_0A].script_prefab_exploder;
			}

			if(isdefined(var_04[var_0A].script_exploder))
			{
				level thread exploder_load(var_04[var_0A]);
			}

			if(isdefined(var_04[var_0A].ambient))
			{
				var_04[var_0A] thread maps\_audio::trigger_multiple_audio_trigger(1);
			}

			if(isdefined(var_04[var_0A].script_audio_zones) || isdefined(var_04[var_0A].script_audio_enter_msg) || isdefined(var_04[var_0A].script_audio_exit_msg) || isdefined(var_04[var_0A].script_audio_progress_msg) || isdefined(var_04[var_0A].script_audio_enter_func) || isdefined(var_04[var_0A].script_audio_exit_func) || isdefined(var_04[var_0A].script_audio_progress_func) || isdefined(var_04[var_0A].script_audio_point_func))
			{
				var_04[var_0A] thread maps\_audio::trigger_multiple_audio_trigger();
			}

			if(isdefined(var_04[var_0A].script_triggered_playerseek))
			{
				level thread triggered_playerseek(var_04[var_0A]);
			}

			if(isdefined(var_04[var_0A].script_bctrigger))
			{
				level thread func_1A9B(var_04[var_0A]);
			}

			if(isdefined(var_04[var_0A].script_trigger_group))
			{
				var_04[var_0A] thread trigger_group();
			}

			if(isdefined(var_04[var_0A].script_random_killspawner))
			{
				level thread maps\_spawner::func_1A5B(var_04[var_0A]);
			}

			if(isdefined(var_04[var_0A].targetname))
			{
				var_0D = var_04[var_0A].targetname;
				if(isdefined(var_01[var_0D]))
				{
					level thread [[ var_01[var_0D] ]](var_04[var_0A]);
				}
			}
		}
	}
}

//Function Number: 5
set_early_level()
{
	level.var_1A5D = [];
	level.var_1A5D["intro"] = 1;
	level.var_1A5D["sp_ny_harbor"] = 1;
	level.var_1A5D["sp_ny_manhattan"] = 1;
	level.var_1A5D["warlord"] = 1;
	level.var_1A5D["london"] = 1;
}

//Function Number: 6
trigger_slide(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		var_01 thread slidetriggerplayerthink(param_00);
	}
}

//Function Number: 7
slidetriggerplayerthink(param_00)
{
	if(isdefined(self.vehicle))
	{
		return;
	}

	if(maps\_utility::func_1A60())
	{
		return;
	}

	thread maps\_audio::func_121F("start_player_slide_trigger",self);
	if(isdefined(self.player_view))
	{
		return;
	}

	self endon("death");
	if(soundexists("SCN_cliffhanger_player_hillslide"))
	{
		self playsound("SCN_cliffhanger_player_hillslide");
	}

	var_01 = undefined;
	if(isdefined(param_00.script_accel))
	{
		var_01 = param_00.script_accel;
	}

	maps\_utility::func_1A63(undefined,var_01);
	for(;;)
	{
		if(!self istouching(param_00))
		{
			break;
		}

		wait 0.05;
	}

	if(isdefined(level.end_slide_delay))
	{
		wait level.end_slide_delay;
	}

	maps\_utility::endsliding();
	thread maps\_audio::func_121F("end_player_slide_trigger",self);
}

//Function Number: 8
setup_simple_primary_lights()
{
	var_00 = getentarray("generic_flickering","targetname");
	var_01 = getentarray("generic_pulsing","targetname");
	var_02 = getentarray("generic_double_strobe","targetname");
	common_scripts\utility::array_thread(var_00,::maps\_lights::generic_flickering);
	common_scripts\utility::array_thread(var_01,::maps\_lights::generic_pulsing);
	common_scripts\utility::array_thread(var_02,::maps\_lights::generic_double_strobe);
}

//Function Number: 9
weapon_ammo()
{
	var_00 = getentarray();
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(isdefined(var_00[var_01].classname) && getsubstr(var_00[var_01].classname,0,7) == "weapon_")
		{
			var_02 = var_00[var_01];
			var_03 = getsubstr(var_02.classname,7);
			if(isdefined(var_02.script_ammo_max))
			{
				var_04 = weaponclipsize(var_03);
				var_05 = weaponmaxammo(var_03);
				var_02 itemweaponsetammo(var_04,var_05,var_04,0);
				var_06 = weaponaltweaponname(var_03);
				if(var_06 != "none")
				{
					var_07 = weaponclipsize(var_06);
					var_08 = weaponmaxammo(var_06);
					var_02 itemweaponsetammo(var_07,var_08,var_07,1);
				}

				continue;
			}

			var_09 = 0;
			var_04 = undefined;
			var_0A = undefined;
			var_0B = 0;
			var_0C = undefined;
			var_0D = undefined;
			if(isdefined(var_02.var_1A69))
			{
				var_04 = var_02.var_1A69;
				var_09 = 1;
			}

			if(isdefined(var_02.script_ammo_extra))
			{
				var_0A = var_02.script_ammo_extra;
				var_09 = 1;
			}

			if(isdefined(var_02.script_ammo_alt_clip))
			{
				var_0C = var_02.script_ammo_alt_clip;
				var_0B = 1;
			}

			if(isdefined(var_02.script_ammo_alt_extra))
			{
				var_0D = var_02.script_ammo_alt_extra;
				var_0B = 1;
			}

			if(var_09)
			{
				if(!isdefined(var_04))
				{
				}

				if(!isdefined(var_0A))
				{
				}

				var_02 itemweaponsetammo(var_04,var_0A);
			}

			if(var_0B)
			{
				if(!isdefined(var_0C))
				{
				}

				if(!isdefined(var_0D))
				{
				}

				var_02 itemweaponsetammo(var_0C,var_0D,0,1);
			}
		}
	}
}

//Function Number: 10
trigger_group()
{
	thread trigger_group_remove();
	level endon("trigger_group_" + self.script_trigger_group);
	self waittill("trigger");
	level notify("trigger_group_" + self.script_trigger_group,self);
}

//Function Number: 11
trigger_group_remove()
{
	level waittill("trigger_group_" + self.script_trigger_group,var_00);
	if(self != var_00)
	{
		self delete();
	}
}

//Function Number: 12
exploder_load(param_00)
{
	level endon("killexplodertridgers" + param_00.script_exploder);
	param_00 waittill("trigger");
	if(isdefined(param_00.script_chance) && randomfloat(1) > param_00.script_chance)
	{
		if(!param_00 maps\_utility::script_delay())
		{
			wait 4;
		}

		level thread exploder_load(param_00);
		return;
	}

	if(!param_00 maps\_utility::script_delay() && isdefined(param_00.script_exploder_delay))
	{
		wait param_00.script_exploder_delay;
	}

	common_scripts\utility::exploder(param_00.script_exploder);
	level notify("killexplodertridgers" + param_00.script_exploder);
}

//Function Number: 13
shock_onpain()
{
	precacheshellshock("pain");
	precacheshellshock("default");
	level.player endon("death");
	setdvarifuninitialized("blurpain","on");
	for(;;)
	{
		var_00 = level.player.health;
		level.player waittill("damage");
		if(getdvar("blurpain") == "on")
		{
			if(var_00 - level.player.health < 129)
			{
				continue;
			}

			level.player shellshock("default",5);
		}
	}
}

//Function Number: 14
usedanimations()
{
	setdvar("usedanim","");
	for(;;)
	{
		if(getdvar("usedanim") == "")
		{
			wait 2;
			continue;
		}

		var_00 = getdvar("usedanim");
		setdvar("usedanim","");
		if(!isdefined(level.completedanims[var_00]))
		{
			continue;
		}

		for(var_01 = 0;var_01 < level.completedanims[var_00].size;var_01++)
		{
		}
	}
}

//Function Number: 15
badplace_think(param_00)
{
	if(!isdefined(level.badplaces))
	{
		level.badplaces = 0;
	}

	level.badplaces++;
	badplace_cylinder("badplace" + level.badplaces,-1,param_00.origin,param_00.radius,1024);
}

//Function Number: 16
setup_individual_exploder(param_00)
{
	var_01 = param_00.script_exploder;
	if(!isdefined(level.exploders[var_01]))
	{
		level.exploders[var_01] = [];
	}

	var_02 = param_00.targetname;
	if(!isdefined(var_02))
	{
		var_02 = "";
	}

	level.exploders[var_01][level.exploders[var_01].size] = param_00;
	if(maps\_utility::exploder_model_starts_hidden(param_00))
	{
		param_00 hide();
		return;
	}

	if(maps\_utility::func_1A79(param_00))
	{
		param_00 hide();
		param_00 notsolid();
		if(isdefined(param_00.spawnflags) && param_00.spawnflags & 1)
		{
			if(isdefined(param_00.script_disconnectpaths))
			{
				param_00 connectpaths();
			}
		}

		return;
	}

	if(maps\_utility::func_1A7B(param_00))
	{
		param_00 hide();
		param_00 notsolid();
		if(isdefined(param_00.spawnflags) && param_00.spawnflags & 1)
		{
			param_00 connectpaths();
		}
	}
}

//Function Number: 17
setupexploders()
{
	level.exploders = [];
	var_00 = getentarray("script_brushmodel","classname");
	var_01 = getentarray("script_model","classname");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_00[var_00.size] = var_01[var_02];
	}

	foreach(var_04 in var_00)
	{
		if(isdefined(var_04.script_prefab_exploder))
		{
			var_04.script_exploder = var_04.script_prefab_exploder;
		}

		if(isdefined(var_04.masked_exploder))
		{
			continue;
		}

		if(isdefined(var_04.script_exploder))
		{
			setup_individual_exploder(var_04);
		}
	}

	var_06 = [];
	var_07 = getentarray("script_brushmodel","classname");
	for(var_02 = 0;var_02 < var_07.size;var_02++)
	{
		if(isdefined(var_07[var_02].script_prefab_exploder))
		{
			var_07[var_02].script_exploder = var_07[var_02].script_prefab_exploder;
		}

		if(isdefined(var_07[var_02].script_exploder))
		{
			var_06[var_06.size] = var_07[var_02];
		}
	}

	var_07 = getentarray("script_model","classname");
	for(var_02 = 0;var_02 < var_07.size;var_02++)
	{
		if(isdefined(var_07[var_02].script_prefab_exploder))
		{
			var_07[var_02].script_exploder = var_07[var_02].script_prefab_exploder;
		}

		if(isdefined(var_07[var_02].script_exploder))
		{
			var_06[var_06.size] = var_07[var_02];
		}
	}

	var_07 = getentarray("item_health","classname");
	for(var_02 = 0;var_02 < var_07.size;var_02++)
	{
		if(isdefined(var_07[var_02].script_prefab_exploder))
		{
			var_07[var_02].script_exploder = var_07[var_02].script_prefab_exploder;
		}

		if(isdefined(var_07[var_02].script_exploder))
		{
			var_06[var_06.size] = var_07[var_02];
		}
	}

	if(isdefined(level.enable_struct_exploders))
	{
		var_07 = level.struct;
		for(var_02 = 0;var_02 < var_07.size;var_02++)
		{
			if(!isdefined(var_07[var_02]))
			{
				continue;
			}

			if(isdefined(var_07[var_02].script_prefab_exploder))
			{
				var_07[var_02].script_exploder = var_07[var_02].script_prefab_exploder;
			}

			if(isdefined(var_07[var_02].script_exploder))
			{
				if(!isdefined(var_07[var_02].angles))
				{
					var_07[var_02].angles = (0,0,0);
				}

				var_06[var_06.size] = var_07[var_02];
			}
		}
	}

	if(!isdefined(level.createfxent))
	{
		level.createfxent = [];
	}

	var_08 = [];
	thread setup_flag_exploders();
	var_03 = 0;
	while(var_03 < var_07.size)
	{
		var_09 = var_07[var_03];
		var_05 = common_scripts\utility::createexploder(var_09.script_fxid);
		var_05.v = [];
		var_05.v["origin"] = var_09.origin;
		var_05.v["angles"] = var_09.angles;
		var_05.v["delay"] = var_09.script_delay;
		var_05.v["delay_post"] = var_09.var_1A7F;
		var_05.v["firefx"] = var_09.script_firefx;
		var_05.v["firefxdelay"] = var_09.script_firefxdelay;
		var_05.v["firefxsound"] = var_09.script_firefxsound;
		var_05.v["firefxtimeout"] = var_09.script_firefxtimeout;
		var_05.v["earthquake"] = var_09.script_earthquake;
		var_05.v["rumble"] = var_09.var_1A80;
		var_05.v["damage"] = var_09.script_damage;
		var_05.v["damage_radius"] = var_09.script_radius;
		var_05.v["soundalias"] = var_09.script_soundalias;
		var_05.v["repeat"] = var_09.script_repeat;
		var_05.v["delay_min"] = var_09.script_delay_min;
		var_05.v["delay_max"] = var_09.script_delay_max;
		var_05.v["target"] = var_09.target;
		var_05.v["ender"] = var_09.script_ender;
		var_05.v["physics"] = var_09.script_physics;
		var_05.v["type"] = "exploder";
		if(!isdefined(var_09.script_fxid))
		{
			var_05.v["fxid"] = "No FX";
		}
		else
		{
			var_05.v["fxid"] = var_09.script_fxid;
		}

		var_05.v["exploder"] = var_09.script_exploder;
		if(isdefined(level.createfxexploders))
		{
			var_0A = level.createfxexploders[var_05.v["exploder"]];
			if(!isdefined(var_0A))
			{
				var_0A = [];
			}

			level.createfxexploders[var_05.v["exploder"]] = var_0A;
		}

		if(!isdefined(var_05.v["delay"]))
		{
			var_05.v["delay"] = 0;
		}

		if(isdefined(var_09.target))
		{
			var_0B = getentarray(var_05.v["target"],"targetname")[0];
			if(isdefined(var_0B))
			{
				var_0C = var_0B.origin;
				var_05.v["angles"] = vectortoangles(var_0C - var_05.v["origin"]);
			}
			else
			{
				var_0B = common_scripts\utility::get_target_ent(var_05.v["target"]);
				if(isdefined(var_0B))
				{
					var_0C = var_0B.origin;
					var_05.v["angles"] = vectortoangles(var_0C - var_05.v["origin"]);
				}
			}
		}

		if(!isdefined(level.enable_struct_exploders))
		{
			if(var_09.code_classname == "script_brushmodel" || isdefined(var_09.model))
			{
				var_05.model = var_09;
				var_05.model.disconnect_paths = var_09.script_disconnectpaths;
			}
		}
		else
		{
			var_05.model = var_09;
			if(isdefined(var_05.model.var_563))
			{
				precachemodel(var_05.model.var_563);
			}
		}

		if(isdefined(var_09.targetname) && isdefined(var_41[var_09.targetname]))
		{
			var_05.v["exploder_type"] = var_09.targetname;
		}
		else
		{
			var_05.v["exploder_type"] = "normal";
		}

		if(isdefined(var_09.masked_exploder))
		{
			var_05.v["masked_exploder"] = var_09.model;
			var_05.v["masked_exploder_spawnflags"] = var_09.spawnflags;
			var_05.v["masked_exploder_script_disconnectpaths"] = var_09.script_disconnectpaths;
			var_09 delete();
		}

		var_05 common_scripts\_createfx::post_entity_creation_function();
		var_03++ = var_41[var_0A.size];
	}
}

//Function Number: 18
setup_flag_exploders()
{
	waittillframeend;
	waittillframeend;
	waittillframeend;
	var_00 = [];
	foreach(var_02 in level.createfxent)
	{
		if(var_02.v["type"] != "exploder")
		{
			continue;
		}

		var_03 = var_02.v["flag"];
		if(!isdefined(var_03))
		{
			continue;
		}

		if(var_03 == "nil")
		{
			var_02.v["flag"] = undefined;
		}

		var_00[var_03] = 1;
	}

	foreach(var_07, var_06 in var_00)
	{
		thread exploder_flag_wait(var_07);
	}
}

//Function Number: 19
exploder_flag_wait(param_00)
{
	if(!common_scripts\utility::flag_exist(param_00))
	{
		common_scripts\utility::flag_init(param_00);
	}

	common_scripts\utility::flag_wait(param_00);
	foreach(var_02 in level.createfxent)
	{
		if(var_02.v["type"] != "exploder")
		{
			continue;
		}

		var_03 = var_02.v["flag"];
		if(!isdefined(var_03))
		{
			continue;
		}

		if(var_03 != param_00)
		{
			continue;
		}

		var_02 common_scripts\utility::activate_individual_exploder();
	}
}

//Function Number: 20
nearairushesplayer()
{
	if(isalive(level.enemyseekingplayer))
	{
		return;
	}

	var_00 = maps\_utility::get_closest_ai(level.player.origin,"bad_guys");
	if(!isdefined(var_00))
	{
		return;
	}

	if(distance(var_00.origin,level.player.origin) > 400)
	{
		return;
	}

	level.enemyseekingplayer = var_00;
	var_00 setgoalentity(level.player);
	var_00.goalradius = 512;
}

//Function Number: 21
playerdamagerumble()
{
	for(;;)
	{
		self waittill("damage",var_00);
		if(isdefined(self.var_1A89))
		{
			continue;
		}

		self playrumbleonentity("damage_heavy");
	}
}

//Function Number: 22
playerdamageshellshock()
{
	for(;;)
	{
		level.player waittill("damage",var_00,var_01,var_02,var_03,var_04);
		if(var_04 == "MOD_EXPLOSIVE" || var_04 == "MOD_GRENADE" || var_04 == "MOD_GRENADE_SPLASH" || var_04 == "MOD_PROJECTILE" || var_04 == "MOD_PROJECTILE_SPLASH")
		{
			var_05 = 0;
			var_06 = level.player.maxhealth / 100;
			var_07 = var_00 * var_06;
			if(var_07 >= 90)
			{
				var_05 = 4;
			}
			else if(var_07 >= 50)
			{
				var_05 = 3;
			}
			else if(var_07 >= 25)
			{
				var_05 = 2;
			}
			else if(var_07 > 10)
			{
				var_05 = 1;
			}

			if(var_05)
			{
				level.player shellshock("default",var_05);
			}
		}
	}
}

//Function Number: 23
map_is_early_in_the_game()
{
	if(isdefined(level.var_1A5D[level.script]))
	{
		return level.var_1A5D[level.script];
	}

	return 0;
}

//Function Number: 24
func_14D0()
{
	self endon("death");
	self.lastgrenadetime = 0;
	for(;;)
	{
		while(!self isthrowinggrenade())
		{
			wait 0.05;
		}

		self.lastgrenadetime = gettime();
		while(self isthrowinggrenade())
		{
			wait 0.05;
		}
	}
}

//Function Number: 25
player_special_death_hint()
{
	if(maps\_utility::is_specialop())
	{
		return;
	}

	if(isalive(level.player))
	{
		thread maps\_quotes::setdeadquote();
	}

	level.player thread func_14D0();
	level.player waittill("death",var_00,var_01,var_02);
	if(var_01 != "MOD_GRENADE" && var_01 != "MOD_GRENADE_SPLASH" && var_01 != "MOD_SUICIDE" && var_01 != "MOD_EXPLOSIVE")
	{
		return;
	}

	if(level.gameskill >= 2)
	{
		if(!map_is_early_in_the_game())
		{
			return;
		}
	}

	if(var_01 == "MOD_SUICIDE")
	{
		if(level.player.lastgrenadetime - gettime() > 3500)
		{
			return;
		}

		level notify("new_quote_string");
		thread grenade_death_text_hudelement(&"SCRIPT_GRENADE_SUICIDE_LINE1",&"SCRIPT_GRENADE_SUICIDE_LINE2");
		return;
	}

	if(var_01 == "MOD_EXPLOSIVE")
	{
		if(level.player destructible_death(var_00))
		{
			return;
		}

		if(level.player exploding_barrel_death_af_chase(var_00))
		{
			return;
		}

		if(level.player vehicle_death(var_00))
		{
			return;
		}

		if(level.player exploding_barrel_death(var_00))
		{
			return;
		}
	}

	if(var_01 == "MOD_GRENADE" || var_01 == "MOD_GRENADE_SPLASH")
	{
		if(isdefined(var_02) && !isweapondetonationtimed(var_02))
		{
			return;
		}

		level notify("new_quote_string");
		setdvar("ui_deadquote","@SCRIPT_GRENADE_DEATH");
		thread func_1A93();
	}
}

//Function Number: 26
vehicle_death(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(param_00.code_classname != "script_vehicle")
	{
		return 0;
	}

	level notify("new_quote_string");
	setdvar("ui_deadquote","@SCRIPT_EXPLODING_VEHICLE_DEATH");
	thread special_death_indicator_hudelement("hud_burningcaricon",96,96);
	return 1;
}

//Function Number: 27
destructible_death(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(!isdefined(param_00.destructible_type))
	{
		return 0;
	}

	level notify("new_quote_string");
	if(issubstr(param_00.destructible_type,"vehicle"))
	{
		setdvar("ui_deadquote","@SCRIPT_EXPLODING_VEHICLE_DEATH");
		thread special_death_indicator_hudelement("hud_burningcaricon",96,96);
	}
	else
	{
		setdvar("ui_deadquote","@SCRIPT_EXPLODING_DESTRUCTIBLE_DEATH");
		thread special_death_indicator_hudelement("hud_destructibledeathicon",96,96);
	}

	return 1;
}

//Function Number: 28
exploding_barrel_death_af_chase(param_00)
{
	if(level.script != "af_chase")
	{
		return 0;
	}

	return exploding_barrel_death(param_00);
}

//Function Number: 29
exploding_barrel_death(param_00)
{
	if(isdefined(level.lastexplodingbarrel))
	{
		if(gettime() != level.lastexplodingbarrel["time"])
		{
			return 0;
		}

		var_01 = distance(self.origin,level.lastexplodingbarrel["origin"]);
		if(var_01 > level.lastexplodingbarrel["radius"])
		{
			return 0;
		}

		level notify("new_quote_string");
		setdvar("ui_deadquote","@SCRIPT_EXPLODING_BARREL_DEATH");
		thread special_death_indicator_hudelement("hud_burningbarrelicon",64,64);
		return 1;
	}

	return 0;
}

//Function Number: 30
grenade_death_text_hudelement(param_00,param_01)
{
	level.player.var_1A92 = 1;
	setdvar("ui_deadquote","");
	wait 1.5;
	var_02 = newhudelem();
	var_02.elemtype = "font";
	var_02.font = "default";
	var_02.fontscale = 1.5;
	var_02.x = 0;
	var_02.y = -30;
	var_02.alignx = "center";
	var_02.aligny = "middle";
	var_02.horzalign = "center";
	var_02.vertalign = "middle";
	var_02 settext(param_00);
	var_02.foreground = 1;
	var_02.alpha = 0;
	var_02 fadeovertime(1);
	var_02.alpha = 1;
	if(isdefined(param_01))
	{
		var_02 = newhudelem();
		var_02.elemtype = "font";
		var_02.font = "default";
		var_02.fontscale = 1.5;
		var_02.x = 0;
		var_02.y = -25 + level.fontheight * var_02.fontscale;
		var_02.alignx = "center";
		var_02.aligny = "middle";
		var_02.horzalign = "center";
		var_02.vertalign = "middle";
		var_02 settext(param_01);
		var_02.foreground = 1;
		var_02.alpha = 0;
		var_02 fadeovertime(1);
		var_02.alpha = 1;
	}
}

//Function Number: 31
func_1A93()
{
	wait 1.5;
	var_00 = newhudelem();
	var_00.x = 0;
	var_00.y = 68;
	var_00 setshader("hud_grenadeicon",50,50);
	var_00.alignx = "center";
	var_00.aligny = "middle";
	var_00.horzalign = "center";
	var_00.vertalign = "middle";
	var_00.foreground = 1;
	var_00.alpha = 0;
	var_00 fadeovertime(1);
	var_00.alpha = 1;
	var_00 = newhudelem();
	var_00.x = 0;
	var_00.y = 25;
	var_00 setshader("hud_grenadepointer",50,25);
	var_00.alignx = "center";
	var_00.aligny = "middle";
	var_00.horzalign = "center";
	var_00.vertalign = "middle";
	var_00.foreground = 1;
	var_00.alpha = 0;
	var_00 fadeovertime(1);
	var_00.alpha = 1;
}

//Function Number: 32
special_death_indicator_hudelement(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 1.5;
	}

	wait param_03;
	var_04 = newhudelem();
	var_04.x = 0;
	var_04.y = 40;
	var_04 setshader(param_00,param_01,param_02);
	var_04.alignx = "center";
	var_04.aligny = "middle";
	var_04.horzalign = "center";
	var_04.vertalign = "middle";
	var_04.foreground = 1;
	var_04.alpha = 0;
	var_04 fadeovertime(1);
	var_04.alpha = 1;
}

//Function Number: 33
triggered_playerseek(param_00)
{
	var_01 = param_00.script_triggered_playerseek;
	param_00 waittill("trigger");
	var_02 = getaiarray();
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(!isalive(var_02[var_03]))
		{
			continue;
		}

		if(isdefined(var_02[var_03].script_triggered_playerseek) && var_02[var_03].script_triggered_playerseek == var_01)
		{
			var_02[var_03].goalradius = 800;
			var_02[var_03] setgoalentity(level.player);
			level thread maps\_spawner::func_1A96(var_02[var_03]);
		}
	}
}

//Function Number: 34
func_1A97()
{
	var_00 = getent(self.target,"targetname");
	self.var_1A98 = var_00.origin[2];
	var_00 delete();
}

//Function Number: 35
func_1A99()
{
	var_00 = self getorigin();
	var_01[0] = "large";
	for(;;)
	{
		self waittill("small",var_41[1],"trigger");
		thread common_scripts\utility::play_sound_in_space("bullet_" + common_scripts\utility::random(var_41) + "_piano",var_01);
	}
}

//Function Number: 36
func_1A9A()
{
	var_00 = self getorigin();
	var_01 = "piano_" + self.script_noteworthy;
	self sethintstring(&"SCRIPT_PLATFORM_PIANO");
	for(;;)
	{
		self waittill("trigger");
		thread common_scripts\utility::play_sound_in_space(var_01,var_00);
	}
}

//Function Number: 37
func_1A9B(param_00)
{
	var_01 = undefined;
	if(isdefined(param_00.target))
	{
		var_02 = getentarray(param_00.target,"targetname");
		if(issubstr(var_02[0].classname,"trigger"))
		{
			var_01 = var_02[0];
		}
	}

	if(isdefined(var_01))
	{
		var_01 waittill("trigger",var_03);
	}
	else
	{
		var_01 waittill("trigger",var_03);
	}

	var_04 = undefined;
	if(isdefined(var_01))
	{
		if(var_03.team != level.player.team && level.player istouching(param_00))
		{
			var_04 = level.player animscripts/battlechatter::getclosestfriendlyspeaker("custom");
		}
		else if(var_03.team == level.player.team)
		{
			var_05 = "axis";
			if(level.player.team == "axis")
			{
				var_05 = "allies";
			}

			var_06 = animscripts/battlechatter::getspeakers("custom",var_05);
			var_06 = maps\_utility::get_array_of_farthest(level.player.origin,var_06);
			foreach(var_08 in var_06)
			{
				if(var_08 istouching(param_00))
				{
					var_04 = var_08;
					if(bctrigger_validate_distance(var_08.origin))
					{
						break;
					}
				}
			}
		}
	}
	else if(isplayer(var_03))
	{
		var_04 = var_03 animscripts/battlechatter::getclosestfriendlyspeaker("custom");
	}
	else
	{
		var_04 = var_03;
	}

	if(!isdefined(var_04))
	{
		return;
	}

	if(!bctrigger_validate_distance(var_04.origin))
	{
		return;
	}

	var_0A = var_04 maps\_utility::func_1A9C(param_00.script_bctrigger);
	if(!var_0A)
	{
		level maps\_utility::func_614(0.25,::func_1A9B,param_00);
		return;
	}

	param_00 notify("custom_battlechatter_done");
}

//Function Number: 38
bctrigger_validate_distance(param_00)
{
	if(distance(param_00,level.player getorigin()) <= 512)
	{
		return 1;
	}

	return 0;
}

//Function Number: 39
waterthink()
{
	var_00 = getent(self.target,"targetname");
	var_01 = var_00.origin[2];
	var_00 = undefined;
	level.var_1A9F = 8;
	level.var_1AA0 = 33;
	level.depth_allow_stand = 50;
	var_02 = 0;
	for(;;)
	{
		wait 0.05;
		if(!level.player.inwater && var_02)
		{
			var_02 = 0;
			level.player allowprone(1);
			level.player allowcrouch(1);
			level.player allowstand(1);
			thread waterthink_rampspeed(level.default_run_speed);
		}

		self waittill("trigger");
		level.player.inwater = 1;
		var_02 = 1;
		while(level.player istouching(self))
		{
			level.player.inwater = 1;
			var_03 = level.player getorigin();
			var_04 = var_03[2] - var_01;
			if(var_04 > 0)
			{
				break;
			}

			var_05 = int(level.default_run_speed - abs(var_04 * 5));
			if(var_05 < 50)
			{
				var_05 = 50;
			}

			thread waterthink_rampspeed(var_05);
			if(abs(var_04) > level.var_1AA0)
			{
				level.player allowcrouch(0);
			}
			else
			{
				level.player allowcrouch(1);
			}

			if(abs(var_04) > level.var_1A9F)
			{
				level.player allowprone(0);
				continue;
			}

			level.player allowprone(1);
			wait 0.5;
		}

		level.player.inwater = 0;
		wait 0.05;
	}
}

//Function Number: 40
waterthink_rampspeed(param_00)
{
	level notify("ramping_water_movement_speed");
	level endon("ramping_water_movement_speed");
	var_01 = 0.5;
	var_02 = int(var_01 * 20);
	var_03 = getdvarint("g_speed");
	var_04 = 0;
	if(param_00 < var_03)
	{
		var_04 = 1;
	}

	var_05 = int(abs(var_03 - param_00));
	var_06 = int(var_05 / var_02);
	for(var_07 = 0;var_07 < var_02;var_07++)
	{
		var_03 = getdvarint("g_speed");
		if(var_04)
		{
			setsaveddvar("g_speed",var_03 - var_06);
		}
		else
		{
			setsaveddvar("g_speed",var_03 + var_06);
		}

		wait 0.05;
	}

	setsaveddvar("g_speed",param_00);
}

//Function Number: 41
func_1AA3()
{
	var_00 = getallnodes();
	thread maps\_mgturret::func_1AA4(var_00);
	thread maps\_mgturret::saw_mgturretlink(var_00);
	thread maps\_colors::func_F05(var_00);
}

//Function Number: 42
trigger_unlock(param_00)
{
	var_01 = "not_set";
	if(isdefined(param_00.script_noteworthy))
	{
		var_01 = param_00.script_noteworthy;
	}

	var_02 = getentarray(param_00.target,"targetname");
	param_00 thread func_1AA8(param_00.target);
	for(;;)
	{
		common_scripts\utility::array_thread(var_02,::common_scripts\utility::trigger_off);
		param_00 waittill("trigger");
		common_scripts\utility::array_thread(var_02,::common_scripts\utility::trigger_on);
		wait_for_an_unlocked_trigger(var_02,var_01);
		maps\_utility::array_notify(var_02,"relock");
	}
}

//Function Number: 43
func_1AA8(param_00)
{
	self waittill("death");
	var_01 = getentarray(param_00,"targetname");
	common_scripts\utility::array_thread(var_01,::common_scripts\utility::trigger_off);
}

//Function Number: 44
wait_for_an_unlocked_trigger(param_00,param_01)
{
	level endon("unlocked_trigger_hit" + param_01);
	var_02 = spawnstruct();
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		param_00[var_03] thread report_trigger(var_02,param_01);
	}

	var_02 waittill("trigger");
	level notify("unlocked_trigger_hit" + param_01);
}

//Function Number: 45
report_trigger(param_00,param_01)
{
	self endon("relock");
	level endon("unlocked_trigger_hit" + param_01);
	self waittill("trigger");
	param_00 notify("trigger");
}

//Function Number: 46
func_1AAB()
{
	var_00 = [];
	var_01 = undefined;
	if(isdefined(self.target))
	{
		var_02 = getentarray(self.target,"targetname");
		var_03 = [];
		foreach(var_05 in var_02)
		{
			if(var_05.classname == "script_origin")
			{
				var_03[var_03.size] = var_05;
			}

			if(issubstr(var_05.classname,"trigger"))
			{
				var_00[var_00.size] = var_05;
			}
		}

		var_02 = common_scripts\utility::getstructarray(self.target,"targetname");
		foreach(var_05 in var_02)
		{
			var_03[var_03.size] = var_05;
		}

		if(var_03.size == 1)
		{
			var_09 = var_03[0];
			var_01 = var_09.origin;
			if(isdefined(var_09.code_classname))
			{
				var_09 delete();
			}
		}
	}

	var_0A = [];
	return var_41;
}

//Function Number: 47
trigger_lookat(param_00)
{
	trigger_lookat_think(param_00,1);
}

//Function Number: 48
trigger_looking(param_00)
{
	trigger_lookat_think(param_00,0);
}

//Function Number: 49
func_1AAE(param_00)
{
	var_01 = 3;
	if(isdefined(param_00.script_delay))
	{
		var_01 = param_00.script_delay;
	}

	for(;;)
	{
		param_00 waittill("trigger");
		maps\_utility::set_vision_set(param_00.script_visionset,var_01);
		wait var_01;
	}
}

//Function Number: 50
trigger_lookat_think(param_00,param_01)
{
	var_02 = 0.78;
	if(isdefined(param_00.script_dot))
	{
		var_02 = param_00.script_dot;
	}

	var_03 = param_00 func_1AAB();
	var_04 = var_03["triggers"];
	var_05 = var_03["target_origin"];
	var_06 = isdefined(param_00.script_flag) || isdefined(param_00.script_noteworthy);
	var_07 = undefined;
	if(var_06)
	{
		var_07 = param_00 maps\_utility::func_F89();
		if(!isdefined(level.flag[var_07]))
		{
			common_scripts\utility::flag_init(var_07);
		}
	}
	else if(!var_04.size)
	{
	}

	if(param_01 && var_06)
	{
		level endon(var_07);
	}

	param_00 endon("death");
	var_08 = 0;
	if(isdefined(param_00.script_parameters))
	{
		var_08 = !issubstr("no_sight",param_00.script_parameters);
	}

	for(;;)
	{
		if(var_06)
		{
			common_scripts\utility::flag_clear(var_07);
		}

		param_00 waittill("trigger",var_09);
		var_0A = [];
		while(var_09 istouching(param_00))
		{
			if(var_08 && !sighttracepassed(var_09 geteye(),var_05,0,undefined))
			{
				if(var_06)
				{
					common_scripts\utility::flag_clear(var_07);
				}

				wait 0.5;
				continue;
			}

			var_0B = vectornormalize(var_05 - var_09.origin);
			var_0C = var_09 getplayerangles();
			var_0D = anglestoforward(var_0C);
			var_0E = vectordot(var_0D,var_0B);
			if(var_0E >= var_02)
			{
				common_scripts\utility::array_thread(var_04,::maps\_utility::send_notify,"trigger");
				if(var_06)
				{
					common_scripts\utility::flag_set(var_07,var_09);
				}

				if(param_01)
				{
					return;
				}

				wait 2;
			}
			else if(var_06)
			{
				common_scripts\utility::flag_clear(var_07);
			}

			if(var_08)
			{
				wait 0.5;
				continue;
			}

			wait 0.05;
		}
	}
}

//Function Number: 51
trigger_cansee(param_00)
{
	var_01 = [];
	var_02 = undefined;
	var_03 = param_00 func_1AAB();
	var_01 = var_03["triggers"];
	var_02 = var_03["target_origin"];
	var_04 = isdefined(param_00.script_flag) || isdefined(param_00.script_noteworthy);
	var_05 = undefined;
	if(var_04)
	{
		var_05 = param_00 maps\_utility::func_F89();
		if(!isdefined(level.flag[var_05]))
		{
			common_scripts\utility::flag_init(var_05);
		}
	}
	else if(!var_01.size)
	{
	}

	param_00 endon("death");
	var_06 = 12;
	var_07 = [];
	for(;;)
	{
		if(var_05)
		{
			common_scripts\utility::flag_clear(var_06);
		}

		var_01 waittill((0,0,0),var_41[var_07.size],(var_07,0,0),var_41[var_41.size],(var_07 * -1,0,0),var_41[var_41.size],(0,var_07,0),var_41[var_41.size],(0,var_07 * -1,0),var_41[var_41.size],(0,0,var_07),var_41[var_41.size],"trigger",var_08);
		while(level.player istouching(var_01))
		{
			if(!var_08 cantraceto(var_03,var_41))
			{
				if(var_05)
				{
					common_scripts\utility::flag_clear(var_06);
				}

				wait 0.1;
				continue;
			}

			if(var_05)
			{
				common_scripts\utility::flag_set(var_06);
			}

			common_scripts\utility::array_thread(var_02,::maps\_utility::send_notify,"trigger");
			wait 0.5;
		}
	}
}

//Function Number: 52
cantraceto(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_01.size;var_02++)
	{
		if(sighttracepassed(self geteye(),param_00 + param_01[var_02],1,self))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 53
indicate_start(param_00)
{
	var_01 = newhudelem();
	var_01.alignx = "left";
	var_01.aligny = "middle";
	var_01.x = 10;
	var_01.y = 400;
	var_01 settext(param_00);
	var_01.alpha = 0;
	var_01.fontscale = 3;
	wait 1;
	var_01 fadeovertime(1);
	var_01.alpha = 1;
	wait 5;
	var_01 fadeovertime(1);
	var_01.alpha = 0;
	wait 1;
	var_01 destroy();
}

//Function Number: 54
func_1AB5()
{
	common_scripts\utility::create_dvar("start","");
	if(getdvar("scr_generateClipModels") != "" && getdvar("scr_generateClipModels") != "0")
	{
		return;
	}

	if(!isdefined(level.var_1AB6))
	{
		level.var_1AB6 = [];
	}

	var_00 = tolower(getdvar("start"));
	var_01 = get_start_dvars();
	if(isdefined(level.start_point))
	{
		var_00 = level.start_point;
	}

	var_02 = 0;
	for(var_03 = 0;var_03 < var_01.size;var_03++)
	{
		if(var_00 == var_01[var_03])
		{
			var_02 = var_03;
			level.start_point = var_01[var_03];
			break;
		}
	}

	if(isdefined(level.default_start_override) && !isdefined(level.start_point))
	{
		foreach(var_06, var_05 in var_01)
		{
			if(level.default_start_override == var_05)
			{
				var_02 = var_06;
				level.start_point = var_05;
				break;
			}
		}
	}

	if(!isdefined(level.start_point))
	{
		if(isdefined(level.default_start))
		{
			level.start_point = "default";
		}
		else if(maps\_utility::level_has_start_points())
		{
			level.start_point = level.var_1AB6[0]["name"];
		}
		else
		{
			level.start_point = "default";
		}
	}

	waittillframeend;
	thread start_menu();
	if(level.start_point == "default")
	{
		if(isdefined(level.default_start))
		{
			level thread [[ level.default_start ]]();
		}
	}
	else
	{
		var_07 = level.var_1ABB[level.start_point];
		thread [[ var_07["start_func"] ]]();
	}

	if(maps\_utility::is_default_start())
	{
		var_08 = get_string_for_starts(var_01);
		setdvar("start",var_08);
	}

	waittillframeend;
	var_09 = [];
	for(var_03 = var_02;var_03 < level.var_1AB6.size;var_03++)
	{
		var_07 = level.var_1AB6[var_03];
		if(!isdefined(var_07["logic_func"]))
		{
			continue;
		}

		if(already_ran_function(var_07["logic_func"],var_09))
		{
			continue;
		}

		[[ var_07["logic_func"] ]]();
		var_09[var_09.size] = var_07["logic_func"];
	}
}

//Function Number: 55
already_ran_function(param_00,param_01)
{
	foreach(var_03 in param_01)
	{
		if(var_03 == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 56
get_string_for_starts(param_00)
{
	var_01 = " ** No starts have been set up for this map with maps_utility::add_start().";
	if(param_00.size)
	{
		var_01 = " ** ";
		for(var_02 = param_00.size - 1;var_02 >= 0;var_02--)
		{
			var_01 = var_01 + param_00[var_02] + " ";
		}
	}

	setdvar("start",var_01);
	return var_01;
}

//Function Number: 57
create_start(param_00,param_01)
{
	var_02 = 1;
	var_03 = (0.9,0.9,0.9);
	if(param_01 != -1)
	{
		var_04 = 5;
		if(param_01 != var_04)
		{
			var_02 = 1 - abs(var_04 - param_01) / var_04;
		}
		else
		{
			var_03 = (1,1,0);
		}
	}

	if(var_02 == 0)
	{
		var_02 = 0.05;
	}

	var_05 = newhudelem();
	var_05.alignx = "left";
	var_05.aligny = "middle";
	var_05.x = 80;
	var_05.y = 80 + param_01 * 18;
	var_05 settext(param_00);
	var_05.alpha = 0;
	var_05.foreground = 1;
	var_05.color = var_03;
	var_05.fontscale = 1.75;
	var_05 fadeovertime(0.5);
	var_05.alpha = var_02;
	return var_05;
}

//Function Number: 58
start_menu()
{
}

//Function Number: 59
start_nogame()
{
	common_scripts\utility::array_call(getaiarray(),::delete);
	common_scripts\utility::array_call(getspawnerarray(),::delete);
}

//Function Number: 60
get_start_dvars()
{
	var_00 = [];
	for(var_01 = 0;var_01 < level.var_1AB6.size;var_01++)
	{
		var_00[var_00.size] = level.var_1AB6[var_01]["name"];
	}

	return var_00;
}

//Function Number: 61
display_starts()
{
	level.display_starts_pressed = 1;
	if(level.var_1AB6.size <= 0)
	{
		return;
	}

	var_00 = get_start_dvars();
	var_01 = start_list_menu();
	var_02 = create_start("Selected Start:",-1);
	var_02.color = (1,1,1);
	var_03 = [];
	var_04 = 0;
	while(var_04 < var_41.size)
	{
		var_05 = var_41[var_04];
		var_06 = "[" + var_41[var_04] + "]";
		if(var_05 != "cancel" && var_05 != "default")
		{
			if(isdefined(level.var_1ABB[var_05]["start_loc_string"]))
			{
				var_06 = var_06 + " -> ";
				var_06 = var_06 + level.var_1ABB[var_05]["start_loc_string"];
			}
		}

		var_03[var_03.size] = var_06;
		var_04++ = var_41[var_41.size];
	}

	var_07 = var_41.size - 1;
	var_08 = 0;
	var_09 = 0;
	var_0A = 0;
	while(var_07 > 0)
	{
		if(var_41[var_07] == level.start_point)
		{
			var_0A = 1;
			break;
		}

		var_07-- = "cancel";
	}

	if(!var_0A)
	{
		var_07 = var_41.size - 1;
	}

	func_1AC5(var_01,var_03,var_07);
	var_0B = var_07;
	for(;;)
	{
		if(!level.player buttonpressed("F10"))
		{
			level.display_starts_pressed = 0;
		}

		if(var_0B != var_07)
		{
			func_1AC5(var_01,var_03,var_07);
			var_0B = var_07;
		}

		if(!var_08)
		{
			if(level.player buttonpressed("UPARROW") || level.player buttonpressed("DPAD_UP") || level.player buttonpressed("APAD_UP"))
			{
				var_08 = 1;
				var_07-- = var_41[var_00.size];
			}
		}
		else if(!level.player buttonpressed("UPARROW") && !level.player buttonpressed("DPAD_UP") && !level.player buttonpressed("APAD_UP"))
		{
			var_08 = 0;
		}

		if(!var_09)
		{
			if(level.player buttonpressed("DOWNARROW") || level.player buttonpressed("DPAD_DOWN") || level.player buttonpressed("APAD_DOWN"))
			{
				var_09 = 1;
				var_07++ = "default";
			}
		}
		else if(!level.player buttonpressed("DOWNARROW") && !level.player buttonpressed("DPAD_DOWN") && !level.player buttonpressed("APAD_DOWN"))
		{
			var_09 = 0;
		}

		if(var_07 < 0)
		{
			var_07 = var_41.size - 1;
		}

		if(var_07 >= var_41.size)
		{
			var_07 = 0;
		}

		if(level.player buttonpressed("BUTTON_B"))
		{
			start_display_cleanup(var_01,var_02);
			break;
		}

		if(level.player buttonpressed("kp_enter") || level.player buttonpressed("BUTTON_A") || level.player buttonpressed("enter"))
		{
			if(var_41[var_07] == "cancel")
			{
				start_display_cleanup(var_01,var_02);
				break;
			}

			setdvar("start",var_41[var_07]);
			level.player openpopupmenu("start");
		}

		wait 0.05;
	}
}

//Function Number: 62
start_list_menu()
{
	var_00 = [];
	for(var_01 = 0;var_01 < 11;var_01++)
	{
		var_02 = create_start("",var_01);
		var_00[var_00.size] = var_02;
	}

	return var_00;
}

//Function Number: 63
func_1AC5(param_00,param_01,param_02)
{
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		var_04 = var_03 + param_02 - 5;
		if(isdefined(param_01[var_04]))
		{
			var_05 = param_01[var_04];
		}
		else
		{
			var_05 = "";
		}

		param_00[var_03] settext(var_05);
	}
}

//Function Number: 64
start_display_cleanup(param_00,param_01)
{
	param_01 destroy();
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		param_00[var_02] destroy();
	}
}

//Function Number: 65
devhelp_hudelements(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		for(var_03 = 0;var_03 < 5;var_03++)
		{
			param_00[var_02][var_03].alpha = param_01;
		}
	}
}

//Function Number: 66
func_1AC8()
{
}

//Function Number: 67
flag_set_player_trigger(param_00)
{
	if(maps\_utility::func_E89())
	{
		thread func_1AD3(param_00);
		return;
	}

	var_01 = param_00 maps\_utility::func_F89();
	if(!isdefined(level.flag[var_01]))
	{
		common_scripts\utility::flag_init(var_01);
	}

	for(;;)
	{
		param_00 waittill("trigger",var_02);
		if(!isplayer(var_02))
		{
			continue;
		}

		param_00 maps\_utility::script_delay();
		common_scripts\utility::flag_set(var_01);
	}
}

//Function Number: 68
trigger_nobloodpool(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(!isalive(var_01))
		{
			continue;
		}

		var_01.var_AB6 = 1;
		var_01 thread set_wait_then_clear_skipbloodpool();
	}
}

//Function Number: 69
set_wait_then_clear_skipbloodpool()
{
	self notify("notify_wait_then_clear_skipBloodPool");
	self endon("notify_wait_then_clear_skipBloodPool");
	self endon("death");
	wait 2;
	self.var_AB6 = undefined;
}

//Function Number: 70
func_1ACC(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(getdvarint("sm_sunenable") == 1)
		{
			continue;
		}

		setsaveddvar("sm_sunenable",1);
	}
}

//Function Number: 71
sun_off(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(getdvarint("sm_sunenable") == 0)
		{
			continue;
		}

		setsaveddvar("sm_sunenable",0);
	}
}

//Function Number: 72
flag_set_trigger(param_00)
{
	var_01 = param_00 maps\_utility::func_F89();
	if(!isdefined(level.flag[var_01]))
	{
		common_scripts\utility::flag_init(var_01);
	}

	for(;;)
	{
		param_00 waittill("trigger",var_02);
		param_00 maps\_utility::script_delay();
		common_scripts\utility::flag_set(var_01,var_02);
	}
}

//Function Number: 73
flag_set_trigger_specialops(param_00)
{
	var_01 = param_00 maps\_utility::func_F89();
	if(!isdefined(level.flag[var_01]))
	{
		common_scripts\utility::flag_init(var_01);
	}

	param_00.player_touched_arr = level.players;
	param_00 thread flag_set_trigger_specialops_clear(var_01);
	for(;;)
	{
		param_00 waittill("trigger",var_02);
		param_00.player_touched_arr = common_scripts\utility::array_remove(param_00.player_touched_arr,var_02);
		if(param_00.player_touched_arr.size)
		{
			continue;
		}

		param_00 maps\_utility::script_delay();
		common_scripts\utility::flag_set(var_01,var_02);
	}
}

//Function Number: 74
flag_set_trigger_specialops_clear(param_00)
{
	for(;;)
	{
		level waittill(param_00);
		if(common_scripts\utility::flag(param_00))
		{
			self.player_touched_arr = [];
			continue;
		}

		self.player_touched_arr = level.players;
	}
}

//Function Number: 75
trigger_damage_player_flag_set(param_00)
{
	var_01 = param_00 maps\_utility::func_F89();
	if(!isdefined(level.flag[var_01]))
	{
		common_scripts\utility::flag_init(var_01);
	}

	for(;;)
	{
		param_00 waittill("trigger",var_02);
		if(!isalive(var_02))
		{
			continue;
		}

		if(!isplayer(var_02))
		{
			continue;
		}

		param_00 maps\_utility::script_delay();
		common_scripts\utility::flag_set(var_01,var_02);
	}
}

//Function Number: 76
func_1AD3(param_00)
{
	var_01 = param_00 maps\_utility::func_F89();
	if(!isdefined(level.flag[var_01]))
	{
		common_scripts\utility::flag_init(var_01);
	}

	var_02 = [];
	for(;;)
	{
		param_00 waittill("trigger",var_03);
		if(!isplayer(var_03))
		{
			continue;
		}

		var_04 = [];
		var_03 = maps\_utility::array_merge(var_03,var_41);
		if(var_03.size == level.players.size)
		{
			break;
		}
	}

	var_01 maps\_utility::script_delay();
	common_scripts\utility::flag_set(var_02);
}

//Function Number: 77
flag_unset_trigger(param_00)
{
	var_01 = param_00 maps\_utility::func_F89();
	if(!isdefined(level.flag[var_01]))
	{
		common_scripts\utility::flag_init(var_01);
	}

	for(;;)
	{
		param_00 waittill("trigger");
		param_00 maps\_utility::script_delay();
		common_scripts\utility::flag_clear(var_01);
	}
}

//Function Number: 78
eq_trigger(param_00)
{
	level.set_eq_func[1] = ::set_eq_on;
	level.set_eq_func[0] = ::set_eq_off;
	var_01 = getent(param_00.target,"targetname");
	for(;;)
	{
		param_00 waittill("trigger");
		var_02 = getaiarray("allies");
		for(var_03 = 0;var_03 < var_02.size;var_03++)
		{
			var_02[var_03] [[ level.set_eq_func[var_02[var_03] istouching(var_01)] ]]();
		}

		while(level.player istouching(param_00))
		{
			wait 0.05;
		}

		var_02 = getaiarray("allies");
		for(var_03 = 0;var_03 < var_02.size;var_03++)
		{
			var_02[var_03] [[ level.set_eq_func[0] ]]();
		}
	}
}

//Function Number: 79
func_1AD7()
{
	self endon("death");
	self.ignoretriggers = 1;
	wait 1;
	self.ignoretriggers = 0;
}

//Function Number: 80
func_1AD8(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < level.eq_trigger_table[var_01].size;var_02++ = var_41[0])
	{
		var_41[var_41.size] = level.eq_trigger_table[var_01][var_02];
	}

	return var_41;
}

//Function Number: 81
player_touched_eq_trigger(param_00,param_01)
{
	self endon("death");
	var_02 = func_1AD8(param_00);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		self.eq_table[var_02[var_03]] = 1;
		self.eq_touching[var_02[var_03]] = 1;
	}

	thread func_1AD7();
	var_04 = getaiarray();
	for(var_05 = 0;var_05 < var_04.size;var_05++)
	{
		var_06 = var_04[var_05];
		for(var_03 = 0;var_03 < var_02.size;var_03++)
		{
			if(var_06.eq_table[var_02[var_03]])
			{
				var_06 eqoff();
				break;
			}
		}
	}

	while(self istouching(param_01))
	{
		wait 0.05;
	}

	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		self.eq_table[var_02[var_03]] = 0;
		self.eq_touching[var_02[var_03]] = undefined;
	}

	var_04 = getaiarray();
	for(var_05 = 0;var_05 < var_04.size;var_05++)
	{
		var_06 = var_04[var_05];
		var_07 = 0;
		for(var_03 = 0;var_03 < var_02.size;var_03++)
		{
			if(var_06.eq_table[var_02[var_03]])
			{
				var_07 = 1;
			}
		}

		if(!var_07)
		{
			continue;
		}

		var_08 = getarraykeys(self.eq_touching);
		var_09 = 0;
		for(var_0A = 0;var_0A < var_08.size;var_0A++)
		{
			if(!var_06.eq_table[var_08[var_0A]])
			{
				continue;
			}

			var_09 = 1;
			break;
		}

		if(!var_09)
		{
			var_06 eqon();
		}
	}
}

//Function Number: 82
ai_touched_eq_trigger(param_00,param_01)
{
	self endon("death");
	var_02 = func_1AD8(param_00);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		self.eq_table[var_02[var_03]] = 1;
		self.eq_touching[var_02[var_03]] = 1;
	}

	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(level.player.eq_table[var_02[var_03]])
		{
			self eqoff();
			break;
		}
	}

	self.ignoretriggers = 1;
	wait 1;
	self.ignoretriggers = 0;
	while(self istouching(param_01))
	{
		wait 0.5;
	}

	var_02 = func_1AD8(param_00);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		self.eq_table[var_02[var_03]] = 0;
		self.eq_touching[var_02[var_03]] = undefined;
	}

	var_04 = getarraykeys(self.eq_touching);
	for(var_05 = 0;var_05 < var_04.size;var_05++)
	{
		if(level.player.eq_table[var_04[var_05]])
		{
			return;
		}
	}

	self eqon();
}

//Function Number: 83
func_1ADE()
{
	level.set_eq_func[0] = ::set_eq_on;
	level.set_eq_func[1] = ::set_eq_off;
	var_00 = 0;
	for(;;)
	{
		while(!level.ai_array.size)
		{
			wait 0.05;
		}

		waittillframeend;
		waittillframeend;
		var_01 = getarraykeys(level.ai_array);
		var_00++;
		if(var_00 >= var_01.size)
		{
			var_00 = 0;
		}

		var_02 = level.ai_array[var_01[var_00]];
		var_02 [[ level.set_eq_func[sighttracepassed(level.player geteye(),var_02 geteye(),0,undefined)] ]]();
		wait 0.05;
	}
}

//Function Number: 84
set_eq_on()
{
	self eqon();
}

//Function Number: 85
set_eq_off()
{
	self eqoff();
}

//Function Number: 86
add_tokens_to_trigger_flags(param_00)
{
	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		var_02 = param_00[var_01];
		if(!isdefined(level.trigger_flags[var_02]))
		{
			level.trigger_flags[var_02] = [];
		}

		level.trigger_flags[var_02][level.trigger_flags[var_02].size] = self;
	}
}

//Function Number: 87
func_1AE3(param_00)
{
	var_01 = common_scripts\utility::create_flags_and_return_tokens(param_00.script_flag_false);
	param_00 add_tokens_to_trigger_flags(var_01);
	param_00 common_scripts\utility::update_trigger_based_on_flags();
}

//Function Number: 88
script_flag_true_trigger(param_00)
{
	var_01 = common_scripts\utility::create_flags_and_return_tokens(param_00.script_flag_true);
	param_00 add_tokens_to_trigger_flags(var_01);
	param_00 common_scripts\utility::update_trigger_based_on_flags();
}

//Function Number: 89
wait_for_flag(param_00)
{
	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		level endon(param_00[var_01]);
	}

	level waittill("foreverrr");
}

//Function Number: 90
func_1AE6(param_00)
{
	var_01 = [];
	var_02 = common_scripts\utility::getstructarray(param_00.target,"targetname");
	var_03 = getentarray(param_00.target,"targetname");
	foreach(var_05 in var_03)
	{
		var_06 = spawnstruct();
		var_06.origin = var_05.origin;
		var_06.script_parameters = var_05.script_parameters;
		var_06.script_damage = var_05.script_damage;
		var_06.radius = var_05.radius;
		var_02[var_02.size] = var_06;
		var_05 delete();
	}

	param_00.var_1AE7 = var_02[0].origin;
	param_00 waittill("trigger");
	param_00 maps\_utility::script_delay();
	foreach(var_06 in var_02)
	{
		var_09 = var_06.radius;
		var_0A = var_06.script_parameters;
		var_0B = var_06.script_damage;
		if(!isdefined(var_09))
		{
			var_09 = 350;
		}

		if(!isdefined(var_0A))
		{
			var_0A = 0.25;
		}

		setdvar("tempdvar",var_0A);
		var_0A = getdvarfloat("tempdvar");
		if(isdefined(var_0B))
		{
			radiusdamage(var_06.origin,var_09,var_0B,var_0B * 0.5);
		}

		physicsexplosionsphere(var_06.origin,var_09,var_09 * 0.5,var_0A);
	}
}

//Function Number: 91
trigger_multiple_friendly_stop_respawn(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger");
		common_scripts\utility::flag_clear("respawn_friendlies");
	}
}

//Function Number: 92
trigger_multiple_friendly_respawn(param_00)
{
	param_00 endon("death");
	var_01 = getent(param_00.target,"targetname");
	var_02 = undefined;
	if(isdefined(var_01))
	{
		var_02 = var_01.origin;
		var_01 delete();
	}
	else
	{
		var_01 = common_scripts\utility::getstruct(param_00.target,"targetname");
		var_02 = var_01.origin;
	}

	for(;;)
	{
		param_00 waittill("trigger");
		level.respawn_spawner_org = var_02;
		common_scripts\utility::flag_set("respawn_friendlies");
		wait 0.5;
	}
}

//Function Number: 93
func_1AEA(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger");
		common_scripts\utility::flag_clear("respawn_friendlies");
		wait 0.5;
	}
}

//Function Number: 94
func_1AEB(param_00)
{
	param_00 waittill("trigger");
	param_00 do_radius_damage_from_target();
}

//Function Number: 95
do_radius_damage_from_target()
{
	var_00 = 80;
	if(isdefined(self.radius))
	{
		var_00 = self.radius;
	}

	var_01 = maps\_utility::func_1AED();
	foreach(var_03 in var_01)
	{
		radiusdamage(var_03.origin,var_00,5000,5000);
	}

	self delete();
}

//Function Number: 96
trigger_damage_do_radius_damage(param_00)
{
	for(;;)
	{
		param_00 waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07);
		if(!isalive(var_02))
		{
			continue;
		}

		if(distance(var_02.origin,param_00.origin) > 940)
		{
			continue;
		}

		break;
	}

	param_00 do_radius_damage_from_target();
}

//Function Number: 97
func_1AEF(param_00)
{
	param_00 waittill("trigger");
	maps\_utility::func_DDF(param_00.script_noteworthy);
}

//Function Number: 98
background_block()
{
	self.origin = self.origin - self.var_1AF1;
}

//Function Number: 99
func_1AF2(param_00)
{
	thread func_1AF7(param_00,::maps\_utility::set_ignoreme,::maps\_utility::get_ignoreme);
}

//Function Number: 100
trigger_pacifist(param_00)
{
	thread func_1AF7(param_00,::maps\_utility::func_1AF6,::maps\_utility::func_1AF5);
}

//Function Number: 101
func_1AF7(param_00,param_01,param_02)
{
	for(;;)
	{
		param_00 waittill("trigger",var_03);
		if(!isalive(var_03))
		{
			continue;
		}

		if(var_03 [[ param_02 ]]())
		{
			continue;
		}

		var_03 thread touched_trigger_runs_func(param_00,param_01);
	}
}

//Function Number: 102
touched_trigger_runs_func(param_00,param_01)
{
	self endon("death");
	self.ignoreme = 1;
	[[ param_01 ]](1);
	self.ignoretriggers = 1;
	wait 1;
	self.ignoretriggers = 0;
	while(self istouching(param_00))
	{
		wait 1;
	}

	[[ param_01 ]](0);
}

//Function Number: 103
trigger_turns_off(param_00)
{
	param_00 waittill("trigger");
	param_00 common_scripts\utility::trigger_off();
	if(!isdefined(param_00.script_linkto))
	{
		return;
	}

	var_01 = strtok(param_00.script_linkto," ");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		common_scripts\utility::array_thread(getentarray(var_01[var_02],"script_linkname"),::common_scripts\utility::trigger_off);
	}
}

//Function Number: 104
set_player_viewhand_model(param_00)
{
	level.var_1AFB = param_00;
	precachemodel(level.var_1AFB);
}

//Function Number: 105
func_1AFC(param_00)
{
	if(!isdefined(level.var_1AFD))
	{
		level.var_1AFD = [];
	}

	waittillframeend;
	var_01 = param_00.script_hint;
	param_00 waittill("trigger",var_02);
	if(isdefined(level.var_1AFD[var_01]))
	{
		return;
	}

	level.var_1AFD[var_01] = 1;
	var_02 maps\_utility::display_hint(var_01);
}

//Function Number: 106
stun_test()
{
	if(getdvar("stuntime") == "")
	{
		setdvar("stuntime","1");
	}

	level.player.allowads = 1;
	for(;;)
	{
		self waittill("damage");
		if(getdvarint("stuntime") == 0)
		{
			continue;
		}

		thread func_1B02(self playerads());
	}
}

//Function Number: 107
func_1B02(param_00)
{
	self notify("stun_player");
	self endon("stun_player");
	if(param_00 > 0.3)
	{
		if(level.player.allowads == 1)
		{
			level.player playsound("player_hit_while_ads");
		}

		level.player.allowads = 0;
		level.player allowads(0);
	}

	level.player setspreadoverride(20);
	wait getdvarint("stuntime");
	level.player allowads(1);
	level.player.allowads = 1;
	level.player resetspreadoverride();
}

//Function Number: 108
func_1B03(param_00)
{
	param_00 endon("death");
	param_00 waittill("trigger");
	maps\_utility::throwgrenadeatplayerasap();
}

//Function Number: 109
func_1B04(param_00)
{
	var_01 = param_00 maps\_utility::func_F89();
	if(!isdefined(level.flag[var_01]))
	{
		common_scripts\utility::flag_init(var_01);
	}

	for(;;)
	{
		param_00 waittill("trigger");
		wait 1;
		if(param_00 found_toucher())
		{
			continue;
		}

		break;
	}

	common_scripts\utility::flag_set(var_01);
}

//Function Number: 110
found_toucher()
{
	var_00 = getaiarray("bad_guys");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_02 = var_00[var_01];
		if(!isalive(var_02))
		{
			continue;
		}

		if(var_02 istouching(self))
		{
			return 1;
		}

		wait 0.1;
	}

	var_00 = getaiarray("bad_guys");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_02 = var_00[var_01];
		if(var_02 istouching(self))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 111
func_1B06(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(isdefined(var_01))
		{
			var_01 delete();
		}
	}
}

//Function Number: 112
flag_set_touching(param_00)
{
	var_01 = param_00 maps\_utility::func_F89();
	if(!isdefined(level.flag[var_01]))
	{
		common_scripts\utility::flag_init(var_01);
	}

	for(;;)
	{
		param_00 waittill("trigger",var_02);
		param_00 maps\_utility::script_delay();
		if(isalive(var_02) && var_02 istouching(param_00) && isdefined(param_00))
		{
			common_scripts\utility::flag_set(var_01);
		}

		while(isalive(var_02) && var_02 istouching(param_00) && isdefined(param_00))
		{
			wait 0.25;
		}

		common_scripts\utility::flag_clear(var_01);
	}
}

//Function Number: 113
setobjectivetextcolors()
{
	var_00 = "1.0 1.0 1.0";
	var_01 = "0.9 0.9 0.9";
	var_02 = "0.85 0.85 0.85";
	if(level.script == "armada")
	{
		setsaveddvar("con_typewriterColorBase",var_01);
		return;
	}

	setsaveddvar("con_typewriterColorBase",var_00);
}

//Function Number: 114
ammo_pickup(param_00)
{
	var_01 = [];
	if(param_00 == "grenade_launcher")
	{
	}
	else if(var_01 == "rpg")
	{
	}
	else if(var_01 == "c4")
	{
	}
	else if(var_01 == "claymore")
	{
	}
	else if(var_01 == "556")
	{
	}
	else if(var_01 == "762")
	{
	}
	else if(var_01 == "45")
	{
	}
	else if(var_01 == "pistol")
	{
	}

	var_02 = spawn("trigger_radius",self.origin,0,25,32);
	for(;;)
	{
		common_scripts\utility::flag_wait("allow_ammo_pickups");
		var_02 waittill("alt_m4_grenadier",var_41[var_01.size],"alt_m4m203_acog",var_41[var_41.size],"alt_m4m203_acog_payback",var_41[var_41.size],"alt_m4m203_eotech",var_41[var_41.size],"alt_m4m203_motion_tracker",var_41[var_41.size],"alt_m4m203_reflex",var_41[var_41.size],"alt_m4m203_reflex_arctic",var_41[var_41.size],"alt_m4m203_silencer",var_41[var_41.size],"alt_m4m203_silencer_reflex",var_41[var_41.size],"alt_m16_grenadier",var_41[var_41.size],"alt_ak47_grenadier",var_41[var_41.size],"alt_ak47_desert_grenadier",var_41[var_41.size],"alt_ak47_digital_grenadier",var_41[var_41.size],"alt_ak47_fall_grenadier",var_41[var_41.size],"alt_ak47_woodland_grenadier",var_41[var_41.size],"rpg",var_41[var_41.size],"rpg_player",var_41[var_41.size],"rpg_straight",var_41[var_41.size],"c4",var_41[var_41.size],"claymore",var_41[var_41.size],"m4_grenadier",var_41[var_41.size],"m4_grunt",var_41[var_41.size],"m4_sd_cloth",var_41[var_41.size],"m4_shotgun",var_41[var_41.size],"m4_silencer",var_41[var_41.size],"m4_silencer_acog",var_41[var_41.size],"m4m203_acog",var_41[var_41.size],"m4m203_acog_payback",var_41[var_41.size],"m4m203_eotech",var_41[var_41.size],"m4m203_motion_tracker",var_41[var_41.size],"m4m203_reflex",var_41[var_41.size],"m4m203_reflex_arctic",var_41[var_41.size],"m4m203_silencer",var_41[var_41.size],"m4m203_silencer_reflex",var_41[var_41.size],"m4m203_silencer",var_41[var_41.size],"ak47",var_41[var_41.size],"ak47_acog",var_41[var_41.size],"ak47_eotech",var_41[var_41.size],"ak47_grenadier",var_41[var_41.size],"ak47_reflex",var_41[var_41.size],"ak47_shotgun",var_41[var_41.size],"ak47_silencer",var_41[var_41.size],"ak47_thermal",var_41[var_41.size],"ak47_desert",var_41[var_41.size],"ak47_desert_acog",var_41[var_41.size],"ak47_desert_eotech",var_41[var_41.size],"ak47_desert_grenadier",var_41[var_41.size],"ak47_desert_reflex",var_41[var_41.size],"ak47_digital",var_41[var_41.size],"ak47_digital_acog",var_41[var_41.size],"ak47_digital_eotech",var_41[var_41.size],"ak47_digital_grenadier",var_41[var_41.size],"ak47_digital_reflex",var_41[var_41.size],"ak47_fall",var_41[var_41.size],"ak47_fall_acog",var_41[var_41.size],"ak47_fall_eotech",var_41[var_41.size],"ak47_fall_grenadier",var_41[var_41.size],"ak47_fall_reflex",var_41[var_41.size],"ak47_woodland",var_41[var_41.size],"ak47_woodland_acog",var_41[var_41.size],"ak47_woodland_eotech",var_41[var_41.size],"ak47_woodland_grenadier",var_41[var_41.size],"ak47_woodland_reflex",var_41[var_41.size],"ump45",var_41[var_41.size],"ump45_acog",var_41[var_41.size],"ump45_eotech",var_41[var_41.size],"ump45_reflex",var_41[var_41.size],"ump45_silencer",var_41[var_41.size],"ump45_arctic",var_41[var_41.size],"ump45_arctic_acog",var_41[var_41.size],"ump45_arctic_eotech",var_41[var_41.size],"ump45_arctic_reflex",var_41[var_41.size],"ump45_digital",var_41[var_41.size],"ump45_digital_acog",var_41[var_41.size],"ump45_digital_eotech",var_41[var_41.size],"ump45_digital_reflex",var_41[var_41.size],"beretta",var_41[var_41.size],"beretta393",var_41[var_41.size],"usp",var_41[var_41.size],"usp_scripted",var_41[var_41.size],"usp_silencer",var_41[var_41.size],"glock",var_41[var_41.size],"trigger",var_03);
		if(!common_scripts\utility::flag("allow_ammo_pickups"))
		{
			continue;
		}

		if(!isdefined(var_03))
		{
			continue;
		}

		if(!isplayer(var_03))
		{
			continue;
		}

		var_04 = undefined;
		var_05 = undefined;
		var_06 = var_03 getweaponslistall();
		for(var_07 = 0;var_07 < var_06.size;var_07++)
		{
			for(var_08 = 0;var_08 < var_41.size;var_08++)
			{
				if(var_06[var_07] == var_41[var_08])
				{
					var_04 = var_06[var_07];
				}
			}
		}

		if(!isdefined(var_04) && var_01 == "claymore")
		{
			var_05 = 1;
			var_04 = "claymore";
			break;
		}

		if(!isdefined(var_04) && var_01 == "c4")
		{
			var_05 = 1;
			var_04 = "c4";
			break;
		}

		if(!isdefined(var_04))
		{
			continue;
		}

		if(var_03 getfractionmaxammo(var_04) >= 1)
		{
			continue;
		}

		break;
	}

	if(isdefined(var_05))
	{
		var_03 giveweapon(var_04);
	}
	else
	{
		var_09 = 1;
		if(var_01 == "556" || var_01 == "762")
		{
			var_09 = 30;
		}
		else if(var_01 == "45")
		{
			var_09 = 25;
		}
		else if(var_01 == "pistol")
		{
			var_09 = 15;
		}

		var_03 setweaponammostock(var_04,var_03 getweaponammostock(var_04) + var_09);
	}

	var_03 playlocalsound("grenade_pickup");
	var_02 delete();
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 115
get_script_linkto_targets()
{
	var_00 = [];
	if(!isdefined(self.script_linkto))
	{
		return var_00;
	}

	var_01 = strtok(self.script_linkto," ");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = var_01[var_02];
		var_04 = getent(var_03,"script_linkname");
		if(isdefined(var_04))
		{
			var_00[var_00.size] = var_04;
		}
	}

	return var_00;
}

//Function Number: 116
delete_link_chain(param_00)
{
	param_00 waittill("trigger");
	var_01 = param_00 get_script_linkto_targets();
	common_scripts\utility::array_thread(var_01,::func_1B0C);
}

//Function Number: 117
func_1B0C()
{
	var_00 = get_script_linkto_targets();
	common_scripts\utility::array_thread(var_00,::func_1B0C);
	self delete();
}

//Function Number: 118
trigger_fog(param_00)
{
	waittillframeend;
	var_01 = param_00.script_fogset_start;
	var_02 = param_00.script_fogset_end;
	param_00.sunfog_enabled = 0;
	if(isdefined(var_01) && isdefined(var_02))
	{
		var_03 = maps\_utility::get_fog(var_01);
		var_04 = maps\_utility::get_fog(var_02);
		param_00.var_1B12 = var_03.var_1688;
		param_00.start_fardist = var_03.var_1689;
		param_00.start_color = (var_03.red,var_03.green,var_03.blue);
		param_00.start_opacity = var_03.maxopacity;
		param_00.sunfog_enabled = isdefined(var_03.var_168E) || isdefined(var_04.var_168E);
		if(isdefined(var_03.var_168E))
		{
			param_00.var_1B16 = (var_03.var_168E,var_03.sungreen,var_03.sunblue);
			param_00.var_1B17 = var_03.sundir;
			param_00.start_sunbeginfadeangle = var_03.sunbeginfadeangle;
			param_00.start_sunendfadeangle = var_03.var_1693;
			param_00.start_sunfogscale = var_03.normalfogscale;
		}
		else if(param_00.sunfog_enabled)
		{
			param_00.var_1B16 = param_00.start_color;
			param_00.var_1B17 = (0,0,0);
			param_00.start_sunbeginfadeangle = 0;
			param_00.start_sunendfadeangle = 90;
			param_00.start_sunfogscale = 1;
		}

		param_00.end_neardist = var_04.var_1688;
		param_00.end_fardist = var_04.var_1689;
		param_00.end_color = (var_03.red,var_03.green,var_03.blue);
		param_00.end_opacity = var_04.maxopacity;
		if(isdefined(var_04.var_168E))
		{
			param_00.end_suncolor = (var_04.var_168E,var_04.sungreen,var_04.sunblue);
			param_00.end_sundir = var_04.sundir;
			param_00.end_sunbeginfadeangle = var_04.sunbeginfadeangle;
			param_00.var_1B22 = var_04.var_1693;
			param_00.var_1B23 = var_04.normalfogscale;
		}
		else if(param_00.sunfog_enabled)
		{
			param_00.end_suncolor = param_00.end_color;
			param_00.end_sundir = (0,0,0);
			param_00.end_sunbeginfadeangle = 0;
			param_00.var_1B22 = 90;
			param_00.var_1B23 = 1;
		}
	}

	var_05 = getent(param_00.target,"targetname");
	var_06 = var_05.origin;
	var_07 = undefined;
	if(isdefined(var_05.target))
	{
		var_08 = getent(var_05.target,"targetname");
		var_07 = var_08.origin;
	}
	else
	{
		var_07 = var_06 + param_00.origin - var_06 * 2;
	}

	var_09 = distance(var_06,var_07);
	for(;;)
	{
		param_00 waittill("trigger",var_0A);
		var_0B = 0;
		while(var_0A istouching(param_00))
		{
			var_0B = maps\_utility::get_progress(var_06,var_07,var_0A.origin,var_09);
			var_0B = clamp(var_0B,0,1);
			param_00 set_fog_progress(var_0B);
			wait 0.05;
		}

		if(var_0B > 0.5)
		{
			var_0B = 1;
		}
		else
		{
			var_0B = 0;
		}

		param_00 set_fog_progress(var_0B);
	}
}

//Function Number: 119
set_fog_progress(param_00)
{
	var_01 = 1 - param_00;
	var_02 = self.var_1B12 * var_01 + self.end_neardist * param_00;
	var_03 = self.start_fardist * var_01 + self.end_fardist * param_00;
	var_04 = self.start_color * var_01 + self.end_color * param_00;
	var_05 = self.start_opacity;
	var_06 = self.end_opacity;
	if(!isdefined(var_05))
	{
		var_05 = 1;
	}

	if(!isdefined(var_06))
	{
		var_06 = 1;
	}

	var_07 = var_05 * var_01 + var_06 * param_00;
	if(self.sunfog_enabled)
	{
		var_08 = self.var_1B16 * var_01 + self.end_suncolor * param_00;
		var_09 = self.var_1B17 * var_01 + self.end_sundir * param_00;
		var_0A = self.start_sunbeginfadeangle * var_01 + self.end_sunbeginfadeangle * param_00;
		var_0B = self.start_sunendfadeangle * var_01 + self.var_1B22 * param_00;
		var_0C = self.start_sunfogscale * var_01 + self.var_1B23 * param_00;
		setexpfog(var_02,var_03,var_04[0],var_04[1],var_04[2],var_07,0.4,var_08[0],var_08[1],var_08[2],var_09,var_0A,var_0B,var_0C);
		return;
	}

	setexpfog(var_02,var_03,var_04[0],var_04[1],var_04[2],var_07,0.4);
}

//Function Number: 120
remove_level_first_frame()
{
	wait 0.05;
	level.first_frame = -1;
}

//Function Number: 121
no_crouch_or_prone_think(param_00)
{
	common_scripts\utility::array_thread(level.players,::no_crouch_or_prone_think_for_player,param_00);
}

//Function Number: 122
no_crouch_or_prone_think_for_player(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(!isdefined(var_01))
		{
			continue;
		}

		if(var_01 != self)
		{
			continue;
		}

		while(var_01 istouching(param_00))
		{
			var_01 allowprone(0);
			var_01 allowcrouch(0);
			wait 0.05;
		}

		var_01 allowprone(1);
		var_01 allowcrouch(1);
	}
}

//Function Number: 123
no_prone_think(param_00)
{
	common_scripts\utility::array_thread(level.players,::func_1B29,param_00);
}

//Function Number: 124
func_1B29(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(!isdefined(var_01))
		{
			continue;
		}

		if(var_01 != self)
		{
			continue;
		}

		while(var_01 istouching(param_00))
		{
			var_01 allowprone(0);
			wait 0.05;
		}

		var_01 allowprone(1);
	}
}

//Function Number: 125
func_1B2A()
{
	if(isdefined(game["total characters"]))
	{
		var_00 = game["total characters"];
	}
	else
	{
		return;
	}

	var_01 = getaiarray("allies");
	var_02 = var_01.size;
	var_03 = 0;
	var_04 = getspawnerteamarray("allies");
	var_05 = var_04.size;
	var_06 = 0;
	for(;;)
	{
		if((var_02 <= 0 && var_05 <= 0) || var_00 <= 0)
		{
			return;
		}

		if(var_02 > 0)
		{
			if(isdefined(var_01[var_03].script_friendname))
			{
				var_02--;
				var_03++;
				continue;
			}

			var_01[var_03] codescripts\character::func_19FB();
			var_01[var_03] thread codescripts\character::load(game["character" + var_00 - 1]);
			var_02--;
			var_03++;
			var_00--;
			continue;
		}

		if(var_05 > 0)
		{
			if(isdefined(var_04[var_06].script_friendname))
			{
				var_05--;
				var_06++;
				continue;
			}

			var_07 = game["character" + var_00 - 1];
			maps\_utility::precache(var_07["model"]);
			maps\_utility::precache(var_07["model"]);
			var_04[var_06] thread maps\_utility::spawn_setcharacter(game["character" + var_00 - 1]);
			var_05--;
			var_06++;
			var_00--;
			continue;
		}
	}
}

//Function Number: 126
check_flag_for_stat_tracking(param_00)
{
	if(!common_scripts\utility::issuffix(param_00,"aa_"))
	{
		return;
	}

	[[ level.sp_stat_tracking_func ]](param_00);
}

//Function Number: 127
precache_script_models()
{
	waittillframeend;
	if(!isdefined(level.var_1B2E))
	{
		return;
	}

	var_00 = getarraykeys(level.var_1B2E);
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(isarray(level.var_1B2E[var_00[var_01]]))
		{
			for(var_02 = 0;var_02 < level.var_1B2E[var_00[var_01]].size;var_02++)
			{
				precachemodel(level.var_1B2E[var_00[var_01]][var_02]);
			}

			continue;
		}

		precachemodel(level.var_1B2E[var_00[var_01]]);
	}
}

//Function Number: 128
arcademode_save()
{
	var_00 = [];
	if(var_41[level.script])
	{
		return;
	}

	wait 2.5;
	var_01 = "levelshots / autosave / autosave_" + level.script + "start";
	savegame("levelstart",&"AUTOSAVE_LEVELSTART",var_01,1);
}

//Function Number: 129
player_death_detection()
{
	setdvar("player_died_recently","0");
	thread player_died_recently_degrades();
	level maps\_utility::add_wait(::common_scripts\utility::flag_wait,"missionfailed");
	level.player maps\_utility::add_wait(::maps\_utility::waittill_msg,"death");
	maps\_utility::do_wait_any();
	var_00 = [];
	setdvar("player_died_recently",var_41[level.gameskill]);
}

//Function Number: 130
player_died_recently_degrades()
{
	for(;;)
	{
		var_00 = getdvarint("player_died_recently",0);
		if(var_00 > 0)
		{
			var_00 = var_00 - 5;
			setdvar("player_died_recently",var_00);
		}

		wait 5;
	}
}

//Function Number: 131
trigger_spawngroup(param_00)
{
	waittillframeend;
	var_01 = param_00.var_1B33;
	if(!isdefined(level.spawn_groups[var_01]))
	{
		return;
	}

	param_00 waittill("trigger");
	var_02 = common_scripts\utility::random(level.spawn_groups[var_01]);
	foreach(var_04 in var_02)
	{
		var_04 maps\_utility::spawn_ai();
	}
}

//Function Number: 132
recon_player()
{
	self notify("new_recon_player");
	self endon("new_recon_player");
	self waittill("death",var_00,var_01,var_02);
	if(!isdefined(var_02))
	{
		var_02 = "script_kill";
	}

	var_03 = 0;
	var_04 = "none";
	var_05 = (0,0,0);
	if(isdefined(var_00))
	{
		var_04 = var_00.classname;
		var_05 = var_00.origin;
		var_06 = vectornormalize(var_05 - self.origin);
		var_07 = anglestoforward(self getplayerangles());
		var_03 = vectordot(var_06,var_07);
	}

	reconspatialevent(self.origin,"script_player_death: playerid %s, enemy %s, enemyposition %v, enemydotproduct %f, cause %s, weapon %s",self.unique_id,var_04,var_05,var_03,var_01,var_02);
	if(isdefined(var_00))
	{
		reconspatialevent(var_00.origin,"script_player_killer: playerid %s, enemy %s, playerposition %v, enemydotproduct %f, cause %s, weapon %s",self.unique_id,var_04,self.origin,var_03,var_01,var_02);
	}
}

//Function Number: 133
recon_player_downed()
{
	self notify("new_player_downed_recon");
	self endon("new_player_downed_recon");
	self endon("death");
	for(;;)
	{
		self waittill("player_downed");
		var_00 = getlevelticks() * 0.05;
		var_01 = var_00;
		if(isdefined(self.last_downed_time))
		{
			var_00 = var_01 - self.last_downed_time;
		}

		self.last_downed_time = var_01;
		reconspatialevent(self.origin,"script_player_downed: playerid %s, leveltime %d, deltatime %d",self.unique_id,var_01,var_00);
	}
}

//Function Number: 134
init_level_players()
{
	level.players = getentarray("player","classname");
	for(var_00 = 0;var_00 < level.players.size;var_00++)
	{
		level.players[var_00].unique_id = "player" + var_00;
	}

	level.player = level.players[0];
	if(level.players.size > 1)
	{
		level.player2 = level.players[1];
	}

	level notify("level.players initialized");
	foreach(var_02 in level.players)
	{
		var_02 thread recon_player();
		if(maps\_utility::is_specialop())
		{
			var_02 thread recon_player_downed();
		}
	}
}

//Function Number: 135
kill_all_players_trigger()
{
	self waittill("trigger",var_00);
	maps\_utility::kill_wrapper();
}

//Function Number: 136
trigger_vehicle_spline_spawn(param_00)
{
	param_00 waittill("trigger");
	var_01 = getentarray(param_00.target,"targetname");
	foreach(var_03 in var_01)
	{
		var_03 thread maps\_vehicle::spawn_vehicle_and_attach_to_spline_path(70);
		wait 0.05;
	}
}

//Function Number: 137
trigger_vehicle_spawn(param_00)
{
	param_00 waittill("trigger");
	var_01 = getentarray(param_00.target,"targetname");
	foreach(var_03 in var_01)
	{
		var_03 thread maps\_vehicle::func_1B3C();
		wait 0.05;
	}
}

//Function Number: 138
trigger_dooropen(param_00)
{
	param_00 waittill("trigger");
	var_01 = getentarray(param_00.target,"targetname");
	var_02 = [];
	foreach(var_04 in var_02)
	{
		var_05 = var_41[var_04.script_noteworthy];
		var_04 connectpaths();
		var_04 rotateyaw(var_05,1,0,0.5);
	}
}

//Function Number: 139
trigger_glass_break(param_00)
{
	var_01 = getglassarray(param_00.target);
	if(!isdefined(var_01) || var_01.size == 0)
	{
		return;
	}

	for(;;)
	{
		level waittill("glass_break",var_02);
		if(var_02 istouching(param_00))
		{
			var_03 = var_02.origin;
			wait 0.05;
			var_04 = var_02.origin;
			var_05 = undefined;
			if(var_03 != var_04)
			{
				var_05 = var_04 - var_03;
			}

			if(isdefined(var_05))
			{
				foreach(var_07 in var_01)
				{
					destroyglass(var_07,var_05);
				}

				break;
			}
			else
			{
				foreach(var_07 in var_01)
				{
					destroyglass(var_07);
				}

				break;
			}
		}
	}

	param_00 delete();
}

//Function Number: 140
trigger_vehicle_getin_spawn(param_00)
{
	var_01 = getentarray(param_00.target,"targetname");
	foreach(var_03 in var_01)
	{
		var_04 = getentarray(var_03.target,"targetname");
		foreach(var_06 in var_04)
		{
			if(!issubstr(var_06.code_classname,"actor"))
			{
				continue;
			}

			if(!var_06.spawnflags & 1)
			{
				continue;
			}

			var_06.var_1B40 = 1;
		}
	}

	param_00 waittill("trigger");
	var_01 = getentarray(param_00.target,"targetname");
	common_scripts\utility::array_thread(var_01,::maps\_utility::add_spawn_function,::vehicle_spawns_targets_and_rides);
	common_scripts\utility::array_thread(var_01,::maps\_utility::func_1B41);
}

//Function Number: 141
vehicle_spawns_targets_and_rides()
{
	var_00 = getentarray(self.target,"targetname");
	var_01 = [];
	foreach(var_03 in var_00)
	{
		if(var_03.code_classname == "info_vehicle_node")
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	var_01 = maps\_utility::get_array_of_closest(self.origin,var_01);
	foreach(var_07, var_06 in var_01)
	{
		var_06 thread maps\_utility::add_spawn_function(::guy_spawns_and_gets_in_vehicle,self,var_07);
	}

	common_scripts\utility::array_thread(var_01,::maps\_utility::spawn_ai);
	self waittill("guy_entered");
	wait 3;
	thread maps\_vehicle::vehicle_becomes_crashable();
	if(!self.riders.size)
	{
		return;
	}

	maps\_vehicle::func_1B44();
	maps\_vehicle::func_1B45();
}

//Function Number: 142
guy_spawns_and_gets_in_vehicle(param_00,param_01)
{
	maps\_vehicle::mount_snowmobile(param_00,param_01);
}

//Function Number: 143
watchweaponchange()
{
	if(!isdefined(level.friendly_thermal_reflector_effect))
	{
		level.friendly_thermal_reflector_effect = loadfx("misc/thermal_tapereflect_inverted");
	}

	self endon("death");
	var_00 = self getcurrentweapon();
	if(weap_has_thermal(var_00))
	{
		thread func_1B4B();
	}

	for(;;)
	{
		self waittill("weapon_change",var_01);
		if(weap_has_thermal(var_01))
		{
			thread func_1B4B();
			continue;
		}

		self notify("acogThermalTracker");
	}
}

//Function Number: 144
weap_has_thermal(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(param_00 == "none")
	{
		return 0;
	}

	if(weaponhasthermalscope(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 145
func_1B4B()
{
	self endon("death");
	self notify("acogThermalTracker");
	self endon("acogThermalTracker");
	var_00 = 0;
	for(;;)
	{
		var_01 = var_00;
		var_00 = self playerads();
		if(turn_thermal_on(var_00,var_01))
		{
			thermal_effectson();
		}
		else if(turn_thermal_off(var_00,var_01))
		{
			func_1B51();
		}

		wait 0.05;
	}
}

//Function Number: 146
turn_thermal_on(param_00,param_01)
{
	if(param_00 <= param_01)
	{
		return 0;
	}

	if(param_00 <= 0.65)
	{
		return 0;
	}

	return !isdefined(self.is_in_thermal_vision);
}

//Function Number: 147
turn_thermal_off(param_00,param_01)
{
	if(param_00 >= param_01)
	{
		return 0;
	}

	if(param_00 >= 0.8)
	{
		return 0;
	}

	return isdefined(self.is_in_thermal_vision);
}

//Function Number: 148
thermal_effectson()
{
	self.is_in_thermal_vision = 1;
	var_00 = getaiarray("allies");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.has_thermal_fx))
		{
			continue;
		}

		var_02.has_thermal_fx = 1;
		var_02 thread func_1B52(self.unique_id);
	}

	if(maps\_utility::func_E89())
	{
		var_04 = maps\_utility::get_other_player(self);
		if(!isdefined(var_04.has_thermal_fx))
		{
			var_04.has_thermal_fx = 1;
			var_04 thread func_1B52(self.unique_id,self);
		}
	}
}

//Function Number: 149
func_1B51()
{
	self.is_in_thermal_vision = undefined;
	level notify("thermal_fx_off" + self.unique_id);
	var_00 = getaiarray("allies");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01].has_thermal_fx = undefined;
	}

	if(maps\_utility::func_E89())
	{
		var_02 = maps\_utility::get_other_player(self);
		var_02.has_thermal_fx = undefined;
	}
}

//Function Number: 150
func_1B52(param_00,param_01)
{
	if(isdefined(self.has_no_ir))
	{
		return;
	}

	level endon("thermal_fx_off" + param_00);
	self endon("death");
	for(;;)
	{
		if(isdefined(param_01))
		{
			playfxontagforclients(level.friendly_thermal_reflector_effect,self,"J_Spine4",param_01);
		}
		else
		{
			playfxontag(level.friendly_thermal_reflector_effect,self,"J_Spine4");
		}

		wait 0.2;
	}
}

//Function Number: 151
claymore_pickup_think_global()
{
	precacheitem("claymore");
	self endon("deleted");
	self setcursorhint("HINT_NOICON");
	self sethintstring(&"WEAPON_CLAYMORE_PICKUP");
	self makeusable();
	var_00 = weaponmaxammo("claymore") + weaponclipsize("claymore");
	if(isdefined(self.var_1A69))
	{
		var_00 = self.var_1A69;
	}

	while(var_00 > 0)
	{
		self waittill("trigger",var_01);
		var_01 playsound("weap_pickup");
		var_02 = 0;
		if(!var_01 hasweapon("claymore"))
		{
			var_01 giveweapon("claymore");
		}
		else
		{
			var_02 = var_01 getammocount("claymore");
		}

		if(isdefined(var_00) && var_00 > 0)
		{
			var_00 = var_02 + var_00;
			var_03 = weaponmaxammo("claymore");
			var_04 = weaponclipsize("claymore");
			if(var_00 >= var_04)
			{
				var_00 = var_00 - var_04;
				var_01 setweaponammoclip("claymore",var_04);
			}

			if(var_00 >= var_03)
			{
				var_00 = var_00 - var_03;
				var_01 setweaponammostock("claymore",var_03);
			}
			else if(var_00 > 0)
			{
				var_01 setweaponammostock("claymore",var_00);
				var_00 = 0;
			}
		}
		else
		{
			var_01 givemaxammo("claymore");
		}

		var_05 = 4;
		if(isdefined(var_01.var_1B54) && var_01.var_1B54 == 4)
		{
			var_05 = 2;
		}

		var_01 setactionslot(var_05,"weapon","claymore");
		var_01 switchtoweapon("claymore");
	}

	if(isdefined(self.target))
	{
		var_06 = getentarray(self.target,"targetname");
		foreach(var_08 in var_06)
		{
			var_08 delete();
		}
	}

	self makeunusable();
	self delete();
}

//Function Number: 152
ammo_cache_think_global()
{
	self.use_trigger = spawn("script_model",self.origin + (0,0,28));
	self.use_trigger setmodel("tag_origin");
	self.use_trigger makeusable();
	self.use_trigger setcursorhint("HINT_NOICON");
	self.use_trigger sethintstring(&"WEAPON_CACHE_USE_HINT");
	thread func_1B57();
	for(;;)
	{
		self.use_trigger waittill("trigger",var_00);
		self.use_trigger makeunusable();
		var_00 playsound("player_refill_all_ammo");
		var_00 disableweapons();
		var_01 = var_00 getweaponslistall();
		foreach(var_03 in var_01)
		{
			if(var_03 == "claymore")
			{
				continue;
			}

			if(var_03 == "c4")
			{
				continue;
			}

			var_00 givemaxammo(var_03);
			var_04 = weaponclipsize(var_03);
			if(isdefined(var_04))
			{
				if(var_00 getweaponammoclip(var_03) < var_04)
				{
					var_00 setweaponammoclip(var_03,var_04);
				}
			}
		}

		wait 1.5;
		var_00 enableweapons();
		self.use_trigger makeusable();
	}
}

//Function Number: 153
func_1B57()
{
	var_00 = spawn("trigger_radius",self.origin,0,320,72);
	var_01 = newhudelem();
	var_01 setshader("waypoint_ammo",1,1);
	var_01.alpha = 0;
	var_01.color = (1,1,1);
	var_01.x = self.origin[0];
	var_01.y = self.origin[1];
	var_01.z = self.origin[2] + 16;
	var_01 setwaypoint(1,1);
	self.var_1B58 = var_01;
	self.ammo_icon_trig = var_00;
	if(isdefined(self.var_1B5A) && self.var_1B5A)
	{
		ammo_icon_fade_in(var_01);
		return;
	}

	wait 0.05;
	for(;;)
	{
		var_00 waittill("trigger",var_02);
		if(!isplayer(var_02))
		{
			continue;
		}

		while(var_02 istouching(var_00))
		{
			var_03 = 1;
			var_04 = var_02 getcurrentweapon();
			if(var_04 == "none")
			{
				var_03 = 0;
			}
			else if(var_02 getfractionmaxammo(var_04) > 0.9)
			{
				var_03 = 0;
			}

			if(maps\_utility::player_looking_at(self.origin,0.8,1) && var_03)
			{
				ammo_icon_fade_in(var_01);
				continue;
			}

			func_1B5D(var_01);
			wait 0.25;
		}

		func_1B5D(var_01);
	}
}

//Function Number: 154
ammo_icon_fade_in(param_00)
{
	if(param_00.alpha != 0)
	{
		return;
	}

	param_00 fadeovertime(0.2);
	param_00.alpha = 0.3;
	wait 0.2;
}

//Function Number: 155
func_1B5D(param_00)
{
	if(param_00.alpha == 0)
	{
		return;
	}

	param_00 fadeovertime(0.2);
	param_00.alpha = 0;
	wait 0.2;
}

//Function Number: 156
func_1B5E(param_00)
{
	var_01 = 0;
	var_02 = undefined;
	var_03 = undefined;
	var_04 = undefined;
	if(isdefined(param_00.script_visionset_start) && isdefined(param_00.script_visionset_end))
	{
		var_01 = 1;
		var_03 = getent(param_00.target,"targetname");
		if(!isdefined(var_03))
		{
			var_03 = common_scripts\utility::getstruct(param_00.target,"targetname");
		}

		var_04 = getent(var_03.target,"targetname");
		if(!isdefined(var_04))
		{
			var_04 = common_scripts\utility::getstruct(var_03.target,"targetname");
		}

		var_03 = var_03.origin;
		var_04 = var_04.origin;
		var_02 = distance(var_03,var_04);
		param_00 init_visionset_progress_trigger();
	}

	var_05 = -1;
	for(;;)
	{
		param_00 waittill("trigger",var_06);
		if(isplayer(var_06))
		{
			if(var_01)
			{
				var_07 = 0;
				while(var_06 istouching(param_00))
				{
					var_07 = maps\_utility::get_progress(var_03,var_04,var_06.origin,var_02);
					var_07 = clamp(var_07,0,1);
					if(var_07 != var_05)
					{
						var_05 = var_07;
						var_06 func_1B69(param_00,var_07);
					}

					wait 0.05;
				}

				if(var_07 < 0.5)
				{
					var_06 maps\_utility::vision_set_fog_changes(param_00.script_visionset_start,param_00.script_delay);
				}
				else
				{
					var_06 maps\_utility::vision_set_fog_changes(param_00.script_visionset_end,param_00.script_delay);
				}

				continue;
			}

			var_06 maps\_utility::vision_set_fog_changes(param_00.script_visionset,param_00.script_delay);
		}
	}
}

//Function Number: 157
init_visionset_progress_trigger()
{
	if(!isdefined(self.script_delay))
	{
		self.script_delay = 2;
	}

	var_00 = maps\_utility::get_vision_set_fog(self.script_visionset_start);
	var_01 = maps\_utility::get_vision_set_fog(self.script_visionset_end);
	if(!isdefined(var_00) || !isdefined(var_01))
	{
		return;
	}

	var_02 = spawnstruct();
	var_02.var_1688 = var_01.var_1688 - var_00.var_1688;
	var_02.var_1689 = var_01.var_1689 - var_00.var_1689;
	var_02.red = var_01.red - var_00.red;
	var_02.blue = var_01.blue - var_00.blue;
	var_02.green = var_01.green - var_00.green;
	var_02.maxopacity = var_01.maxopacity - var_00.maxopacity;
	var_02.sunfogenabled = isdefined(var_00.sunfogenabled) || isdefined(var_01.sunfogenabled);
	var_03 = 0;
	if(isdefined(var_00.var_168E))
	{
		var_03 = var_00.var_168E;
	}

	var_04 = 0;
	if(isdefined(var_01.var_168E))
	{
		var_04 = var_01.var_168E;
	}

	var_02.sunred_start = var_03;
	var_02.var_168E = var_04 - var_03;
	var_05 = 0;
	if(isdefined(var_00.sungreen))
	{
		var_05 = var_00.sungreen;
	}

	var_06 = 0;
	if(isdefined(var_01.sungreen))
	{
		var_06 = var_01.sungreen;
	}

	var_02.sungreen_start = var_05;
	var_02.sungreen = var_06 - var_05;
	var_07 = 0;
	if(isdefined(var_00.sunblue))
	{
		var_07 = var_00.sunblue;
	}

	var_08 = 0;
	if(isdefined(var_01.sunblue))
	{
		var_08 = var_01.sunblue;
	}

	var_02.sunblue_start = var_07;
	var_02.sunblue = var_08 - var_07;
	var_09 = (0,0,0);
	if(isdefined(var_00.sundir))
	{
		var_09 = var_00.sundir;
	}

	var_0A = (0,0,0);
	if(isdefined(var_01.sundir))
	{
		var_0A = var_01.sundir;
	}

	var_02.sundir_start = var_09;
	var_02.sundir = var_0A - var_09;
	var_0B = 0;
	if(isdefined(var_00.sunbeginfadeangle))
	{
		var_0B = var_00.sunbeginfadeangle;
	}

	var_0C = 0;
	if(isdefined(var_01.sunbeginfadeangle))
	{
		var_0C = var_01.sunbeginfadeangle;
	}

	var_02.sunbeginfadeangle_start = var_0B;
	var_02.sunbeginfadeangle = var_0C - var_0B;
	var_0D = 0;
	if(isdefined(var_00.var_1693))
	{
		var_0D = var_00.var_1693;
	}

	var_0E = 0;
	if(isdefined(var_01.var_1693))
	{
		var_0E = var_01.var_1693;
	}

	var_02.sunendfadeangle_start = var_0D;
	var_02.var_1693 = var_0E - var_0D;
	var_0F = 0;
	if(isdefined(var_00.normalfogscale))
	{
		var_0F = var_00.normalfogscale;
	}

	var_10 = 0;
	if(isdefined(var_01.normalfogscale))
	{
		var_10 = var_01.normalfogscale;
	}

	var_02.var_1B67 = var_0F;
	var_02.normalfogscale = var_10 - var_0F;
	self.visionset_diff = var_02;
}

//Function Number: 158
func_1B69(param_00,param_01)
{
	maps\_utility::init_self_visionset();
	if(param_01 < 0.5)
	{
		self.vision_set_transition_ent.vision_set = param_00.script_visionset_start;
	}
	else
	{
		self.vision_set_transition_ent.vision_set = param_00.script_visionset_end;
	}

	self.vision_set_transition_ent.time = 0;
	if(param_00.script_visionset_start == param_00.script_visionset_end)
	{
		return;
	}

	self visionsetnakedforplayer_lerp(param_00.script_visionset_start,param_00.script_visionset_end,param_01);
	var_02 = maps\_utility::get_vision_set_fog(param_00.script_visionset_start);
	var_03 = maps\_utility::get_vision_set_fog(param_00.script_visionset_end);
	var_04 = param_00.visionset_diff;
	var_05 = spawnstruct();
	var_05.var_1688 = var_02.var_1688 + var_04.var_1688 * param_01;
	var_05.var_1689 = var_02.var_1689 + var_04.var_1689 * param_01;
	var_05.var_1689 = max(1,var_05.var_1689);
	var_05.red = var_02.red + var_04.red * param_01;
	var_05.green = var_02.green + var_04.green * param_01;
	var_05.blue = var_02.blue + var_04.blue * param_01;
	var_05.maxopacity = var_02.maxopacity + var_04.maxopacity * param_01;
	if(var_04.sunfogenabled)
	{
		var_05.sunfogenabled = 1;
		var_05.var_168E = var_04.sunred_start + var_04.var_168E * param_01;
		var_05.sungreen = var_04.sungreen_start + var_04.sungreen * param_01;
		var_05.sunblue = var_04.sunblue_start + var_04.sunblue * param_01;
		var_05.sundir = var_04.sundir_start + var_04.sundir * param_01;
		var_05.sunbeginfadeangle = var_04.sunbeginfadeangle_start + var_04.sunbeginfadeangle * param_01;
		var_05.var_1693 = var_04.sunendfadeangle_start + var_04.var_1693 * param_01;
		var_05.normalfogscale = var_04.var_1B67 + var_04.normalfogscale * param_01;
	}

	maps\_utility::set_fog_to_ent_values(var_05,0.05);
}

//Function Number: 159
func_1B6B()
{
	var_00 = getglass(self.target);
	if(!isdefined(var_00))
	{
		return;
	}

	level waittillmatch(var_00,"glass_destroyed");
	self delete();
}

//Function Number: 160
global_empty_callback(param_00,param_01,param_02,param_03,param_04)
{
}

//Function Number: 161
trigger_multiple_compass(param_00)
{
	var_01 = param_00.script_parameters;
	if(!isdefined(level.var_1A08))
	{
		level.var_1A08 = "";
	}

	for(;;)
	{
		param_00 waittill("trigger");
		if(level.var_1A08 != var_01)
		{
			maps\_compass::setupminimap(var_01);
		}
	}
}

//Function Number: 162
func_1B6E(param_00,param_01,param_02)
{
	if(isdefined(param_00.v["soundalias"]) && param_00.v["soundalias"] != "nil")
	{
		if(!isdefined(param_00.v["stopable"]) || !param_00.v["stopable"])
		{
			return;
		}
	}

	param_02.origin = param_00.v["origin"];
	if(param_02 istouching(param_01))
	{
		param_01.fx[param_01.fx.size] = param_00;
	}
}

//Function Number: 163
trigger_multiple_fx_volume(param_00)
{
	var_01 = spawn("script_origin",(0,0,0));
	param_00.fx = [];
	foreach(var_03 in level.createfxent)
	{
		func_1B6E(var_03,param_00,var_01);
	}

	var_01 delete();
	if(!isdefined(param_00.target))
	{
		return;
	}

	var_05 = getentarray(param_00.target,"targetname");
	foreach(var_07 in var_05)
	{
		switch(var_07.classname)
		{
			case "trigger_multiple_fx_volume_on":
				var_07 thread trigger_multiple_fx_trigger_on_think(param_00);
				break;

			case "trigger_multiple_fx_volume_off":
				var_07 thread func_1B71(param_00);
				break;

			default:
				break;
		}
	}
}

//Function Number: 164
trigger_multiple_fx_trigger_on_think(param_00)
{
	for(;;)
	{
		self waittill("trigger");
		common_scripts\utility::array_thread(param_00.fx,::maps\_utility::restarteffect);
		wait 1;
	}
}

//Function Number: 165
func_1B71(param_00)
{
	wait 1;
	common_scripts\utility::array_thread(param_00.fx,::common_scripts\utility::pauseeffect);
	for(;;)
	{
		self waittill("trigger");
		common_scripts\utility::array_thread(param_00.fx,::common_scripts\utility::pauseeffect);
		wait 1;
	}
}

//Function Number: 166
func_1B72()
{
	common_scripts\utility::create_dvar("weaponlist","0");
	if(!getdvarint("weaponlist"))
	{
		return;
	}

	var_00 = getentarray();
	var_01 = [];
	foreach(var_03 in var_00)
	{
		if(!isdefined(var_03.code_classname))
		{
			continue;
		}

		if(issubstr(var_03.code_classname,"weapon"))
		{
			var_01[var_03.classname] = 1;
		}
	}

	foreach(var_06 in var_01)
	{
	}

	var_08 = getspawnerarray();
	var_09 = [];
	foreach(var_0B in var_08)
	{
		var_09[var_0B.code_classname] = 1;
	}

	foreach(var_06 in var_09)
	{
	}
}

//Function Number: 167
slowmo_system_init()
{
	level.slowmo = spawnstruct();
	slowmo_system_defaults();
	notifyoncommand("_cheat_player_press_slowmo","+melee");
	notifyoncommand("_cheat_player_press_slowmo","+melee_breath");
	notifyoncommand("_cheat_player_press_slowmo","+melee_zoom");
}

//Function Number: 168
slowmo_system_defaults()
{
	level.slowmo.var_1B75 = 0;
	level.slowmo.lerp_time_out = 0.25;
	level.slowmo.speed_slow = 0.4;
	level.slowmo.speed_norm = 1;
}

//Function Number: 169
add_no_game_starts()
{
	var_00 = getentarray("script_origin_start_nogame","classname");
	if(!var_00.size)
	{
		return;
	}

	foreach(var_02 in var_00)
	{
		if(!isdefined(var_02.var_1B79))
		{
			continue;
		}

		maps\_utility::add_start("no_game_" + var_02.var_1B79,::start_nogame);
	}
}

//Function Number: 170
func_1B7A()
{
	if(!maps\_utility::func_17D7())
	{
		return;
	}

	setsaveddvar("ufoHitsTriggers","1");
	level.var_1750 = 1;
	if(isdefined(level.custom_no_game_setupfunc))
	{
		level [[ level.custom_no_game_setupfunc ]]();
	}

	maps\_loadout::init_loadout();
	thread maps\_audio::aud_init();
	maps\_global_fx::main();
	do_no_game_start_teleport();
	common_scripts\utility::array_call(getentarray("truckjunk","targetname"),::delete);
	common_scripts\utility::array_call(getentarray("truckjunk","script_noteworthy"),::delete);
	level waittill("eternity");
}

//Function Number: 171
do_no_game_start_teleport()
{
	var_00 = getentarray("script_origin_start_nogame","classname");
	if(!var_00.size)
	{
		return;
	}

	var_00 = sortbydistance(var_00,level.player.origin);
	if(level.start_point == "no_game")
	{
		level.player maps\_utility::teleport_player(var_00[0]);
		return;
	}

	var_01 = getsubstr(level.start_point,8);
	var_02 = 0;
	foreach(var_04 in var_00)
	{
		if(!isdefined(var_04.var_1B79))
		{
			continue;
		}

		if(var_01 != var_04.var_1B79)
		{
			continue;
		}

		if(isdefined(var_04.script_visionset))
		{
			maps\_utility::vision_set_fog_changes(var_04.script_visionset,0);
		}

		level.player maps\_utility::teleport_player(var_04);
		var_02 = 1;
		break;
	}

	if(!var_02)
	{
		level.player maps\_utility::teleport_player(var_00[0]);
	}
}