/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_load.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 77
 * Decompile Time: 1202 ms
 * Timestamp: 10/27/2023 2:48:15 AM
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
	level.func["setflaggedanimknob"] = ::setflaggedanimknob;
	level.func["setflaggedanimknobrestart"] = ::setflaggedanimknobrestart;
	level.func["setanimlimited"] = ::setanimlimited;
	level.func["setanimtime"] = ::setanimtime;
	level.func["getanimtime"] = ::getanimtime;
	level.func["getanimlength"] = ::getanimlength;
	level.func["clearanim"] = ::clearanim;
	level.func["kill"] = ::kill;
	level.func["magicgrenade"] = ::magicgrenade;
	set_early_level();
	maps\_utility::set_console_status();
	level.global_callbacks = [];
	level.global_callbacks["_autosave_stealthcheck"] = ::global_empty_callback;
	level.global_callbacks["_patrol_endon_spotted_flag"] = ::global_empty_callback;
	level.global_callbacks["_spawner_stealth_default"] = ::global_empty_callback;
	level.global_callbacks["_idle_call_idle_func"] = ::global_empty_callback;
	common_scripts\utility::flag_init("_cloaked_stealth_enabled");
	if(!isdefined(level.visionthermaldefault))
	{
		level.visionthermaldefault = "default";
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

	if(getdvar("music_enable") == "")
	{
		setdvar("music_enable","1");
	}

	setdvar("ac130_player_num",-1);
	setdvar("ui_remotemissile_playernum",0);
	setdvar("ui_pmc_won",0);
	setdvar("ui_actionSlot_1_forceActive","off");
	setdvar("ui_actionSlot_2_forceActive","off");
	setdvar("ui_actionSlot_3_forceActive","off");
	setdvar("ui_actionSlot_4_forceActive","off");
	setdvar("ui_dog_grenade",0);
	setdvar("ui_securing","");
	setdvar("ui_securing_progress",0);
	setdvar("hud_showObjectives",1);
	setdvar("hud_showIntel",1);
	setdvar("minimap_sp",0);
	setdvar("minimap_full_sp",0);
	if(!isdefined(level.notetracks))
	{
		anim.notetracks = [];
		animscripts\notetracks::registernotetracks();
	}

	common_scripts\utility::flag_init("introscreen_complete");
	maps\_utility::add_start("no_game",::start_nogame);
	add_no_game_starts();
	level._loadstarted = 1;
	level.first_frame = 1;
	level.level_specific_dof = 0;
	thread remove_level_first_frame();
	level.wait_any_func_array = [];
	level.run_func_after_wait_array = [];
	level.run_call_after_wait_array = [];
	level.run_noself_call_after_wait_array = [];
	level.do_wait_endons_array = [];
	level.abort_wait_any_func_array = [];
	if(!isdefined(level.script))
	{
		level.script = tolower(getdvar("mapname"));
	}

	set_dynent_playerwakeupradius();
	precacheshader("black");
	precacheshader("white");
	precacheshader("overlay_low_health_alt");
	precacheshader("overlay_low_health");
	precacheshader("overlay_low_health_compass");
	precachestring(&"GAME_GET_TO_COVER");
	level.ai_number = 0;
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
	if(issplitscreen())
	{
		setsaveddvar("cg_fovScale","0.75");
	}
	else
	{
		setsaveddvar("cg_fovScale","1");
	}

	level.radiation_totalpercent = 0;
	common_scripts\utility::flag_init("respawn_friendlies");
	common_scripts\utility::flag_init("missionfailed");
	common_scripts\utility::flag_init("auto_adjust_initialized");
	level.player maps\_utility::ent_flag_init("_radiation_poisoning");
	common_scripts\utility::flag_init("gameskill_selected");
	common_scripts\utility::flag_init("battlechatter_on_thread_waiting");
	common_scripts\utility::flag_init("start_is_set");
	thread maps\_gameskill::aa_init_stats();
	thread player_death_detection();
	level.default_run_speed = 190;
	setsaveddvar("g_speed",level.default_run_speed);
	if(maps\_utility::is_specialop())
	{
		setsaveddvar("sv_saveOnStartMap",0);
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
	common_scripts\utility::flag_init("player_flashed");
	level.connectpathsfunction = ::connectpaths;
	level.disconnectpathsfunction = ::disconnectpaths;
	level.badplace_cylinder_func = ::badplace_cylinder;
	level.badplace_delete_func = ::badplace_delete;
	level.isaifunc = ::isai;
	level.createclientfontstring_func = ::maps\_hud_util::createclientfontstring;
	level.hudsetpoint_func = ::maps\_hud_util::setpoint;
	level.makeentitysentient_func = ::makeentitysentient;
	level.freeentitysentient_func = ::freeentitysentient;
	level.laseron_func = ::laseron;
	level.laseroff_func = ::laseroff;
	level.stat_track_kill_func = ::maps\_player_stats::register_kill;
	level.stat_track_damage_func = ::maps\_player_stats::register_shot_hit;
	level.dopickyautosavechecks = 1;
	level.autosave_threat_check_enabled = 1;
	level.getnodefunction = ::getnode;
	level.getnodearrayfunction = ::getnodearray;
	level.addaieventlistener_func = ::addaieventlistener;
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
		var_05 thread maps\_utility::never_saw_it_coming();
	}

	precachemodel("fx");
	precachemodel("tag_origin");
	precachemodel("tag_ik_target");
	precacheshellshock("default");
	precacheshellshock("flashbang");
	precacheshellshock("dog_bite");
	precacheshellshock("dog_bite_hit_shield");
	precacherumble("damage_heavy");
	precacherumble("damage_light");
	precacherumble("grenade_rumble");
	precacherumble("artillery_rumble");
	precacherumble("slide_start");
	precacherumble("slide_loop");
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
	precacheshader("hud_destructibledeathicon");
	precacheshader("hud_burningbarrelicon");
	precacheshader("waypoint_ammo");
	precachestring(&"init_hud");
	precachestring(&"close_hud");
	precachelaser("nvg_laser");
	level._effect["deathfx_bloodpool_generic"] = loadfx("vfx/weaponimpact/deathfx_bloodpool_generic");
	animscripts\pain::initpainfx();
	animscripts\melee::melee_init();
	animscripts\death::init_headshot_helmet();
	level.createfx_enabled = getdvar("createfx") != "";
	level.navigatemodels_enabled = 0;
	slowmo_system_init();
	level.spawn_funcs = [];
	level.spawn_funcs["allies"] = [];
	level.spawn_funcs["axis"] = [];
	level.spawn_funcs["team3"] = [];
	level.spawn_funcs["neutral"] = [];
	maps\_cheat::init();
	maps\_mgturret::main();
	common_scripts\_exploder::setupexploders();
	maps\_exploderanim::main();
	maps\_art::main();
	maps\_gameskill::setskill();
	maps\_anim::init();
	thread common_scripts\_fx::initfx();
	if(level.createfx_enabled)
	{
	}

	maps\_global_fx_code::init();
	maps\_global_fx::main();
	maps\_global_fx::create_custom_global_fx();
	default_footsteps();
	maps\_detonategrenades::init();
	maps\_lighting::light_init();
	maps\_lights::init2();
	maps\_names::setup_names();
	if(isdefined(level.handle_starts_endons))
	{
		thread [[ level.handle_starts_endons ]]();
	}
	else
	{
		thread handle_starts();
	}

	if(getdvar("functional_test_starts") == "1")
	{
		thread functional_tester_load_next_start();
	}

	if(!isdefined(level.trigger_flags))
	{
		common_scripts\utility::init_trigger_flags();
	}

	level.killspawn_groups = [];
	soundscripts\_audio::aud_init();
	soundscripts\_snd::snd_init();
	maps\_trigger::init_script_triggers();
	setsaveddvar("ufoHitsTriggers","0");
	maps\_hud::init();
	do_no_game_start();
	if(getdvar("g_connectpaths") == "2")
	{
		level waittill("eternity");
	}

	maps\_autosave::main();
	thread maps\_sp_matchdata::init();
	if(!isdefined(level.animsounds))
	{
		thread init_animsounds();
	}

	maps\_anim::init();
	if(isdefined(level.audio_stringtable_mapname))
	{
		soundscripts\_audio::set_stringtable_mapname(level.audio_stringtable_mapname);
	}

	anim.usefacialanims = 0;
	if(!isdefined(level.missionfailed))
	{
		level.missionfailed = 0;
	}

	if(!maps\_utility::is_specialop())
	{
		maps\_loadout::init_loadout();
		setsaveddvar("ui_campaign",level.campaign);
	}

	common_scripts\_static_destructible::main();
	common_scripts\_destructible::init();
	thread maps\_vehicle::init_vehicles();
	thread maps\_introscreen::main();
	thread maps\_endmission::main();
	thread maps\_damagefeedback::init();
	maps\_friendlyfire::main();
	common_scripts\utility::array_levelthread(getentarray("badplace","targetname"),::badplace_think);
	common_scripts\utility::array_levelthread(getentarray("delete_on_load","targetname"),::maps\_utility::deleteent);
	common_scripts\utility::array_thread(getnodearray("traverse","targetname"),::traversethink);
	common_scripts\utility::array_thread(getentarray("piano_key","targetname"),::pianothink);
	common_scripts\utility::array_thread(getentarray("piano_damage","targetname"),::pianodamagethink);
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
	for(var_07 = 0;var_07 < level.players.size;var_07++)
	{
		var_05 = level.players[var_07];
		if(!getdvarint("disable_player_regen") == 1)
		{
			var_05 thread maps\_gameskill::playerhealthregen();
		}

		var_05 thread playerdamagerumble();
	}

	thread maps\_player_death::main();
	thread massnodeinitfunctions();
	common_scripts\utility::flag_init("spawning_friendlies");
	common_scripts\utility::flag_init("friendly_wave_spawn_enabled");
	common_scripts\utility::flag_clear("spawning_friendlies");
	level.friendly_spawner["rifleguy"] = getentarray("rifle_spawner","script_noteworthy");
	level.friendly_spawner["smgguy"] = getentarray("smg_spawner","script_noteworthy");
	thread maps\_spawner::goalvolumes();
	thread maps\_spawner::friendlychains();
	thread maps\_spawner::friendlychain_ondeath();
	common_scripts\utility::array_thread(getentarray("friendly_spawn","targetname"),::maps\_spawner::friendlyspawnwave);
	common_scripts\utility::array_thread(getentarray("flood_and_secure","targetname"),::maps\_spawner::flood_and_secure);
	common_scripts\utility::array_thread(getentarray("window_poster","targetname"),::window_destroy);
	if(!isdefined(level.trigger_hint_string))
	{
		level.trigger_hint_string = [];
		level.trigger_hint_func = [];
		level.trigger_hint_doubleline = [];
	}

	level.shared_portable_turrets = [];
	level.spawn_groups = [];
	maps\_spawner::main();
	common_scripts\utility::array_thread(getentarray("background_block","targetname"),::background_block);
	thread load_friendlies();
	thread maps\_animatedmodels::main();
	thread maps\_cagedchickens::initchickens();
	thread weapon_ammo();
	foreach(var_0A, var_09 in level.missionsettings.levels)
	{
		if(var_09.name == level.script)
		{
			setsaveddvar("ui_currentLevelIndex",var_0A);
			break;
		}
	}

	if(level.script == level.missionsettings.levels[0].name && !level.player getlocalplayerprofiledata("hasEverPlayed_SP"))
	{
		maps\_utility::delaythread(0.1,::update_gamer_profile);
	}

	var_0B = level.player getplayersetting("gameskill");
	var_0C = level.difficultytype[int(var_0B)];
	setspmatchdata("start_difficulty",var_0C);
	setspmatchdata("final_difficulty",var_0C);
	level thread maps\_achievements::achievements_init();
	thread maps\_dragunov_lightset::dragunov_scope_init();
	level thread maps\_utility::start_monitor_escape_artist();
	level notify("load_finished");
	run_post_function();
	level.player thread maps\_utility::logbreadcrumbdatasp();
}

//Function Number: 2
update_gamer_profile()
{
	level.player setlocalplayerprofiledata("hasEverPlayed_SP",1);
	updategamerprofile();
}

//Function Number: 3
run_post_function()
{
	if(isdefined(level.post_load_funcs))
	{
		foreach(var_01 in level.post_load_funcs)
		{
			[[ var_01 ]]();
		}
	}
}

//Function Number: 4
set_dynent_playerwakeupradius()
{
	switch(level.script)
	{
		case "village_defend":
		case "village_assault":
		case "sniperescape":
		case "scoutsniper":
		case "launchfacility_b":
		case "launchfacility_a":
		case "killhouse":
		case "jeepride":
		case "icbm":
		case "hunted":
		case "cargoship":
		case "bog_b":
		case "bog_a":
		case "blackout":
		case "ambush":
		case "airplane":
		case "airlift":
		case "armada":
			break;
	}
}

//Function Number: 5
set_early_level()
{
	level.early_level = [];
	level.early_level["killhouse"] = 1;
	level.early_level["cargoship"] = 1;
	level.early_level["coup"] = 1;
	level.early_level["blackout"] = 1;
	level.early_level["armada"] = 1;
	level.early_level["bog_a"] = 0;
	level.early_level["hunted"] = 0;
	level.early_level["ac130"] = 0;
	level.early_level["bog_b"] = 0;
	level.early_level["airlift"] = 0;
	level.early_level["aftermath"] = 0;
	level.early_level["village_assault"] = 0;
	level.early_level["ca_village_assault"] = 0;
	level.early_level["scoutsniper"] = 0;
	level.early_level["sniperescape"] = 0;
	level.early_level["village_defend"] = 0;
	level.early_level["ambush"] = 0;
	level.early_level["icbm"] = 0;
	level.early_level["launchfacility_a"] = 0;
	level.early_level["launchfacility_b"] = 0;
	level.early_level["jeepride"] = 0;
	level.early_level["airplane"] = 0;
}

//Function Number: 6
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
			if(isdefined(var_02.script_ammo_clip))
			{
				var_04 = var_02.script_ammo_clip;
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

//Function Number: 7
exploder_load(param_00)
{
	level endon("killexplodertridgers" + param_00.script_exploder);
	param_00 waittill("trigger");
	if(isdefined(param_00.script_chance) && randomfloat(1) > param_00.script_chance)
	{
		if(!param_00 maps\_utility::script_delay())
		{
			wait(4);
		}

		level thread exploder_load(param_00);
		return;
	}

	if(!param_00 maps\_utility::script_delay() && isdefined(param_00.script_exploder_delay))
	{
		wait(param_00.script_exploder_delay);
	}

	common_scripts\_exploder::exploder(param_00.script_exploder);
	level notify("killexplodertridgers" + param_00.script_exploder);
}

//Function Number: 8
badplace_think(param_00)
{
	if(!isdefined(level.badplaces))
	{
		level.badplaces = 0;
	}

	level.badplaces++;
	badplace_cylinder("badplace" + level.badplaces,-1,param_00.origin,param_00.radius,1024);
}

//Function Number: 9
playerdamagerumble()
{
	for(;;)
	{
		self waittill("damage",var_00);
		if(isdefined(self.specialdamage))
		{
			continue;
		}

		self playrumbleonentity("damage_heavy");
	}
}

//Function Number: 10
map_is_early_in_the_game()
{
	if(isdefined(level.early_level[level.script]))
	{
		return level.early_level[level.script];
	}

	return 0;
}

//Function Number: 11
traversethink()
{
	var_00 = getent(self.target,"targetname");
	self.traverse_height = var_00.origin[2];
	self.traverse_height_delta = var_00.origin[2] - self.origin[2];
	var_00 delete();
}

//Function Number: 12
pianodamagethink()
{
	var_00 = self getorigin();
	var_01[0] = "large";
	var_01[1] = "small";
	for(;;)
	{
		self waittill("trigger");
		thread common_scripts\utility::play_sound_in_space("bullet_" + common_scripts\utility::random(var_01) + "_piano",var_00);
	}
}

//Function Number: 13
pianothink()
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

//Function Number: 14
waterthink()
{
	var_00 = getent(self.target,"targetname");
	var_01 = var_00.origin[2];
	var_00 = undefined;
	level.depth_allow_prone = 8;
	level.depth_allow_crouch = 33;
	level.depth_allow_stand = 50;
	var_02 = 0;
	for(;;)
	{
		wait(0.05);
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
			if(abs(var_04) > level.depth_allow_crouch)
			{
				level.player allowcrouch(0);
			}
			else
			{
				level.player allowcrouch(1);
			}

			if(abs(var_04) > level.depth_allow_prone)
			{
				level.player allowprone(0);
				continue;
			}

			level.player allowprone(1);
			wait(0.5);
		}

		level.player.inwater = 0;
		wait(0.05);
	}
}

//Function Number: 15
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

		wait(0.05);
	}

	setsaveddvar("g_speed",param_00);
}

//Function Number: 16
massnodeinitfunctions()
{
	var_00 = getallnodes();
	thread maps\_mgturret::auto_mgturretlink(var_00);
	thread maps\_mgturret::saw_mgturretlink(var_00);
	thread maps\_colors::init_color_grouping(var_00);
}

//Function Number: 17
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
	wait(1);
	var_01 fadeovertime(1);
	var_01.alpha = 1;
	wait(5);
	var_01 fadeovertime(1);
	var_01.alpha = 0;
	wait(1);
	var_01 destroy();
}

//Function Number: 18
handle_starts()
{
	level.start_struct = spawnstruct();
	common_scripts\utility::create_dvar("start","");
	if(getdvar("scr_generateClipModels") != "" && getdvar("scr_generateClipModels") != "0")
	{
		return;
	}

	if(!isdefined(level.start_functions))
	{
		level.start_functions = [];
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
			level.start_point = level.start_functions[0]["name"];
		}
		else
		{
			level.start_point = "default";
		}
	}

	var_07 = getdvarint("sv_loadingsavegame",0);
	if(var_07 != 0)
	{
		var_08 = getdvar("sv_savegametransients","");
		if(var_08 == "")
		{
			loadstartpointtransient("");
		}
		else
		{
			var_09 = strtok(var_08,",");
			loadstartpointtransient(var_09);
		}
	}
	else if(level.start_point != "default")
	{
		var_0A = level.start_arrays[level.start_point];
		if(isdefined(var_0A["transients_to_load"]))
		{
			var_0B = var_0A["transients_to_load"];
			if(var_0B.size > 0)
			{
				loadstartpointtransient(var_0B);
			}
			else
			{
				loadstartpointtransient("");
			}
		}
	}

	waittillframeend;
	common_scripts\utility::flag_set("start_is_set");
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
		var_0A = level.start_arrays[level.start_point];
		thread [[ var_0A["start_func"] ]]();
	}

	if(maps\_utility::is_default_start())
	{
		var_0C = get_string_for_starts(var_01);
		setdvar("start",var_0C);
	}

	waittillframeend;
	if(var_07 != 0)
	{
		wait(0.1);
	}

	var_0D = [];
	if(!maps\_utility::is_default_start() && level.start_point != "no_game")
	{
		var_0E = gettime();
		for(var_03 = 0;var_03 < level.start_functions.size;var_03++)
		{
			var_0A = level.start_functions[var_03];
			if(var_0A["name"] == level.start_point)
			{
				break;
			}

			if(!isdefined(var_0A["catchup_function"]))
			{
				continue;
			}

			[[ var_0A["catchup_function"] ]]();
		}
	}

	for(var_03 = var_02;var_03 < level.start_functions.size;var_03++)
	{
		var_0A = level.start_functions[var_03];
		if(!isdefined(var_0A["logic_func"]))
		{
			continue;
		}

		if(already_ran_function(var_0A["logic_func"],var_0D))
		{
			continue;
		}

		level.start_struct [[ var_0A["logic_func"] ]]();
		var_0D[var_0D.size] = var_0A["logic_func"];
	}
}

//Function Number: 19
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

//Function Number: 20
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

//Function Number: 21
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

//Function Number: 22
start_menu()
{
}

//Function Number: 23
start_nogame()
{
	common_scripts\utility::array_call(getaiarray(),::delete);
	common_scripts\utility::array_call(getspawnerarray(),::delete);
}

//Function Number: 24
get_start_dvars()
{
	var_00 = [];
	for(var_01 = 0;var_01 < level.start_functions.size;var_01++)
	{
		var_00[var_00.size] = level.start_functions[var_01]["name"];
	}

	return var_00;
}

//Function Number: 25
display_starts()
{
	level.display_starts_pressed = 1;
	if(level.start_functions.size <= 0)
	{
		return;
	}

	var_00 = get_start_dvars();
	var_00[var_00.size] = "default";
	var_00[var_00.size] = "cancel";
	var_01 = start_list_menu();
	var_02 = create_start("Selected Start:",-1);
	var_02.color = (1,1,1);
	var_03 = [];
	for(var_04 = 0;var_04 < var_00.size;var_04++)
	{
		var_05 = var_00[var_04];
		var_06 = "[" + var_00[var_04] + "]";
		if(var_05 != "cancel" && var_05 != "default")
		{
			if(isdefined(level.start_arrays[var_05]["start_loc_string"]))
			{
				var_06 = var_06 + " -> ";
				var_06 = var_06 + level.start_arrays[var_05]["start_loc_string"];
			}
		}

		var_03[var_03.size] = var_06;
	}

	var_07 = var_00.size - 1;
	var_08 = 0;
	var_09 = 0;
	var_0A = 0;
	while(var_07 > 0)
	{
		if(var_00[var_07] == level.start_point)
		{
			var_0A = 1;
			break;
		}

		var_07--;
	}

	if(!var_0A)
	{
		var_07 = var_00.size - 1;
	}

	start_list_settext(var_01,var_03,var_07);
	var_0B = var_07;
	for(;;)
	{
		if(!level.player buttonpressed("F10"))
		{
			level.display_starts_pressed = 0;
		}

		if(var_0B != var_07)
		{
			start_list_settext(var_01,var_03,var_07);
			var_0B = var_07;
		}

		if(!var_08)
		{
			if(level.player buttonpressed("UPARROW") || level.player buttonpressed("DPAD_UP") || level.player buttonpressed("APAD_UP"))
			{
				var_08 = 1;
				var_07--;
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
				var_07++;
			}
		}
		else if(!level.player buttonpressed("DOWNARROW") && !level.player buttonpressed("DPAD_DOWN") && !level.player buttonpressed("APAD_DOWN"))
		{
			var_09 = 0;
		}

		if(var_07 < 0)
		{
			var_07 = var_00.size - 1;
		}

		if(var_07 >= var_00.size)
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
			if(var_00[var_07] == "cancel")
			{
				start_display_cleanup(var_01,var_02);
				break;
			}

			setdvar("start",var_00[var_07]);
		}

		wait(0.05);
	}
}

//Function Number: 26
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

//Function Number: 27
start_list_settext(param_00,param_01,param_02)
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

//Function Number: 28
start_display_cleanup(param_00,param_01)
{
	param_01 destroy();
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		param_00[var_02] destroy();
	}
}

//Function Number: 29
background_block()
{
	self.origin = self.origin - self.script_bg_offset;
}

//Function Number: 30
set_player_viewhand_model(param_00)
{
	level.player_viewhand_model = param_00;
	precachemodel(level.player_viewhand_model);
}

//Function Number: 31
ammo_pickup(param_00)
{
	var_01 = [];
	if(param_00 == "grenade_launcher")
	{
		var_01[var_01.size] = "alt_m4_grenadier";
		var_01[var_01.size] = "alt_m4m203_acog";
		var_01[var_01.size] = "alt_m4m203_acog_payback";
		var_01[var_01.size] = "alt_m4m203_eotech";
		var_01[var_01.size] = "alt_m4m203_motion_tracker";
		var_01[var_01.size] = "alt_m4m203_reflex";
		var_01[var_01.size] = "alt_m4m203_reflex_arctic";
		var_01[var_01.size] = "alt_m4m203_silencer";
		var_01[var_01.size] = "alt_m4m203_silencer_reflex";
		var_01[var_01.size] = "alt_m16_grenadier";
		var_01[var_01.size] = "alt_ak47_grenadier";
		var_01[var_01.size] = "alt_ak47_desert_grenadier";
		var_01[var_01.size] = "alt_ak47_digital_grenadier";
		var_01[var_01.size] = "alt_ak47_fall_grenadier";
		var_01[var_01.size] = "alt_ak47_woodland_grenadier";
	}
	else if(param_00 == "rpg")
	{
		var_01[var_01.size] = "rpg";
		var_01[var_01.size] = "rpg_player";
		var_01[var_01.size] = "rpg_straight";
	}
	else if(param_00 == "c4")
	{
		var_01[var_01.size] = "c4";
	}
	else if(param_00 == "claymore")
	{
		var_01[var_01.size] = "claymore";
	}
	else if(param_00 == "556")
	{
		var_01[var_01.size] = "m4_grenadier";
		var_01[var_01.size] = "m4_grunt";
		var_01[var_01.size] = "m4_sd_cloth";
		var_01[var_01.size] = "m4_shotgun";
		var_01[var_01.size] = "m4_silencer";
		var_01[var_01.size] = "m4_silencer_acog";
		var_01[var_01.size] = "m4m203_acog";
		var_01[var_01.size] = "m4m203_acog_payback";
		var_01[var_01.size] = "m4m203_eotech";
		var_01[var_01.size] = "m4m203_motion_tracker";
		var_01[var_01.size] = "m4m203_reflex";
		var_01[var_01.size] = "m4m203_reflex_arctic";
		var_01[var_01.size] = "m4m203_silencer";
		var_01[var_01.size] = "m4m203_silencer_reflex";
		var_01[var_01.size] = "m4m203_silencer";
	}
	else if(param_00 == "762")
	{
		var_01[var_01.size] = "ak47";
		var_01[var_01.size] = "ak47_acog";
		var_01[var_01.size] = "ak47_eotech";
		var_01[var_01.size] = "ak47_grenadier";
		var_01[var_01.size] = "ak47_reflex";
		var_01[var_01.size] = "ak47_shotgun";
		var_01[var_01.size] = "ak47_silencer";
		var_01[var_01.size] = "ak47_thermal";
		var_01[var_01.size] = "ak47_desert";
		var_01[var_01.size] = "ak47_desert_acog";
		var_01[var_01.size] = "ak47_desert_eotech";
		var_01[var_01.size] = "ak47_desert_grenadier";
		var_01[var_01.size] = "ak47_desert_reflex";
		var_01[var_01.size] = "ak47_digital";
		var_01[var_01.size] = "ak47_digital_acog";
		var_01[var_01.size] = "ak47_digital_eotech";
		var_01[var_01.size] = "ak47_digital_grenadier";
		var_01[var_01.size] = "ak47_digital_reflex";
		var_01[var_01.size] = "ak47_fall";
		var_01[var_01.size] = "ak47_fall_acog";
		var_01[var_01.size] = "ak47_fall_eotech";
		var_01[var_01.size] = "ak47_fall_grenadier";
		var_01[var_01.size] = "ak47_fall_reflex";
		var_01[var_01.size] = "ak47_woodland";
		var_01[var_01.size] = "ak47_woodland_acog";
		var_01[var_01.size] = "ak47_woodland_eotech";
		var_01[var_01.size] = "ak47_woodland_grenadier";
		var_01[var_01.size] = "ak47_woodland_reflex";
	}
	else if(param_00 == "45")
	{
		var_01[var_01.size] = "ump45";
		var_01[var_01.size] = "ump45_acog";
		var_01[var_01.size] = "ump45_eotech";
		var_01[var_01.size] = "ump45_reflex";
		var_01[var_01.size] = "ump45_silencer";
		var_01[var_01.size] = "ump45_arctic";
		var_01[var_01.size] = "ump45_arctic_acog";
		var_01[var_01.size] = "ump45_arctic_eotech";
		var_01[var_01.size] = "ump45_arctic_reflex";
		var_01[var_01.size] = "ump45_digital";
		var_01[var_01.size] = "ump45_digital_acog";
		var_01[var_01.size] = "ump45_digital_eotech";
		var_01[var_01.size] = "ump45_digital_reflex";
	}
	else if(param_00 == "pistol")
	{
		var_01[var_01.size] = "beretta";
		var_01[var_01.size] = "beretta393";
		var_01[var_01.size] = "usp";
		var_01[var_01.size] = "usp_scripted";
		var_01[var_01.size] = "usp_silencer";
		var_01[var_01.size] = "glock";
	}

	var_02 = spawn("trigger_radius",self.origin,0,25,32);
	for(;;)
	{
		common_scripts\utility::flag_wait("allow_ammo_pickups");
		var_02 waittill("trigger",var_03);
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
			for(var_08 = 0;var_08 < var_01.size;var_08++)
			{
				if(var_06[var_07] == var_01[var_08])
				{
					var_04 = var_06[var_07];
				}
			}
		}

		if(!isdefined(var_04) && param_00 == "claymore")
		{
			var_05 = 1;
			var_04 = "claymore";
			break;
		}

		if(!isdefined(var_04) && param_00 == "c4")
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
		if(param_00 == "556" || param_00 == "762")
		{
			var_09 = 30;
		}
		else if(param_00 == "45")
		{
			var_09 = 25;
		}
		else if(param_00 == "pistol")
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

//Function Number: 32
remove_level_first_frame()
{
	wait(0.05);
	level.first_frame = -1;
}

//Function Number: 33
load_friendlies()
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

			var_01[var_03] codescripts\character::new();
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

//Function Number: 34
check_flag_for_stat_tracking(param_00)
{
	if(!common_scripts\utility::issuffix(param_00,"aa_"))
	{
		return;
	}

	[[ level.sp_stat_tracking_func ]](param_00);
}

//Function Number: 35
precache_script_models()
{
	waittillframeend;
	if(!isdefined(level.scr_model))
	{
		return;
	}

	var_00 = getarraykeys(level.scr_model);
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(isarray(level.scr_model[var_00[var_01]]))
		{
			for(var_02 = 0;var_02 < level.scr_model[var_00[var_01]].size;var_02++)
			{
				precachemodel(level.scr_model[var_00[var_01]][var_02]);
			}

			continue;
		}

		precachemodel(level.scr_model[var_00[var_01]]);
	}
}

//Function Number: 36
player_death_detection()
{
	setdvar("player_died_recently","0");
	thread player_died_recently_degrades();
	level maps\_utility::add_wait(::common_scripts\utility::flag_wait,"missionfailed");
	level.player maps\_utility::add_wait(::maps\_utility::waittill_msg,"death");
	maps\_utility::do_wait_any();
	var_00 = [];
	var_00[0] = 70;
	var_00[1] = 30;
	var_00[2] = 0;
	var_00[3] = 0;
	setdvar("player_died_recently",var_00[level.gameskill]);
}

//Function Number: 37
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

		wait(5);
	}
}

//Function Number: 38
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

//Function Number: 39
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

//Function Number: 40
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

//Function Number: 41
kill_all_players_trigger()
{
	self waittill("trigger",var_00);
	var_00 maps\_utility::kill_wrapper();
}

//Function Number: 42
watchweaponchange()
{
	if(!isdefined(level.friendly_thermal_reflector_effect))
	{
		level.friendly_thermal_reflector_effect = loadfx("vfx/unique/thermal_beacon_inverted");
	}

	self endon("death");
	var_00 = self getcurrentweapon();
	if(weap_has_thermal(var_00))
	{
		thread thermal_tracker();
	}
	else if(weap_is_em1(var_00))
	{
		thread em1_heat_meter();
	}
	else if(weap_is_hbra3(var_00))
	{
		thread hbra3_signature();
	}
	else if(player_has_printing_himar())
	{
		thread himar_print_ammo();
	}

	for(;;)
	{
		self waittill("weapon_change",var_01);
		if(weap_has_thermal(var_01))
		{
			thread thermal_tracker();
		}
		else
		{
			self notify("acogThermalTracker");
		}

		if(weap_is_em1(var_01))
		{
			thread em1_heat_meter();
		}

		if(weap_is_hbra3(var_01))
		{
			thread hbra3_signature();
		}

		if(player_has_printing_himar())
		{
			thread himar_print_ammo();
		}
	}
}

//Function Number: 43
em1_heat_meter_off()
{
	common_scripts\utility::waittill_any("death","weapon_change","em1_heat_meter");
	setomnvar("ui_em1",0);
	setomnvar("ui_em1_heat",0);
}

//Function Number: 44
em1_heat_meter()
{
	self endon("death");
	self endon("weapon_change");
	self notify("em1_heat_meter");
	self endon("em1_heat_meter");
	thread em1_heat_meter_off();
	setomnvar("ui_em1",1);
	setomnvar("ui_em1_heat",0);
	for(;;)
	{
		var_00 = self getcurrentweapon();
		var_01 = self getweaponheatlevel(var_00);
		setomnvar("ui_em1_heat",var_01);
		wait(0.05);
	}
}

//Function Number: 45
weap_is_em1(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(weaponclass(param_00) == "beam" && issubstr(param_00,"_em1"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 46
hbra3_signature_off()
{
	common_scripts\utility::waittill_any("death","weapon_change","hbra3_signature");
	setomnvar("ui_hbra3",0);
}

//Function Number: 47
hbra3_signature()
{
	self endon("death");
	self endon("weapon_change");
	self notify("hbra3_signature");
	self endon("hbra3_signature");
	thread hbra3_signature_off();
	setomnvar("ui_hbra3",1);
}

//Function Number: 48
weap_is_hbra3(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(weaponclass(param_00) == "rifle" && issubstr(param_00,"_hbra3"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 49
himar_print_ammo()
{
	self endon("death");
	self endon("himar_print_ammo_stop");
	if(isdefined(self.himar_printer_equipped) && self.himar_printer_equipped)
	{
		return;
	}

	self.himar_printer_equipped = 1;
	self notify("himar_print_ammo");
	self endon("himar_print_ammo");
	setomnvar("ui_himar",1);
	setomnvar("ui_himar_printing",0);
	var_00 = undefined;
	foreach(var_02 in self getweaponslistprimaries())
	{
		if(issubstr(var_02,"himar"))
		{
			var_00 = var_02;
			break;
		}
	}

	if(!isdefined(var_00))
	{
		return;
	}

	for(;;)
	{
		var_04 = self getfractionmaxammo(var_00);
		setomnvar("ui_himar_printing",var_04);
		if(var_04 < 1)
		{
			thread himar_printing_ammo_full_check(var_00);
			common_scripts\utility::waittill_notify_or_timeout("himar_ammo_full",30);
			self notify("stop_himar_printing_ammo_full_check");
			var_05 = self getweaponammostock(var_00);
			var_06 = weaponmaxammo(var_00);
			var_07 = var_05 + weaponclipsize(var_00);
			if(var_07 > var_06)
			{
				var_07 = var_06;
			}

			self setweaponammostock(var_00,var_07);
			continue;
		}

		wait(1);
	}
}

//Function Number: 50
himar_printing_ammo_full_check(param_00)
{
	self endon("stop_himar_printing_ammo_full_check");
	while(self getfractionmaxammo(param_00) != 1)
	{
		wait(0.5);
	}

	self notify("himar_ammo_full");
}

//Function Number: 51
weap_is_himar(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(weaponclass(param_00) == "rifle" && issubstr(param_00,"_himar"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 52
player_has_printing_himar()
{
	foreach(var_01 in self getweaponslistprimaries())
	{
		if(issubstr(var_01,"iw5_himar_sp") && issubstr(var_01,"himarscope"))
		{
			return 1;
		}
	}

	self.himar_printer_equipped = undefined;
	self notify("himar_print_ammo_stop");
	setomnvar("ui_himar",0);
	setomnvar("ui_himar_printing",0);
	return 0;
}

//Function Number: 53
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

//Function Number: 54
thermal_tracker()
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
			thermal_effectsoff();
		}

		wait(0.05);
	}
}

//Function Number: 55
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

//Function Number: 56
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

//Function Number: 57
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
		var_02 thread loop_friendly_thermal_reflector_effect(self.unique_id);
	}

	if(maps\_utility::is_coop())
	{
		var_04 = maps\_utility::get_other_player(self);
		if(!isdefined(var_04.has_thermal_fx))
		{
			var_04.has_thermal_fx = 1;
			var_04 thread loop_friendly_thermal_reflector_effect(self.unique_id,self);
		}
	}
}

//Function Number: 58
thermal_effectsoff()
{
	self.is_in_thermal_vision = undefined;
	level notify("thermal_fx_off" + self.unique_id);
	var_00 = getaiarray("allies");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01].has_thermal_fx = undefined;
	}

	if(maps\_utility::is_coop())
	{
		var_02 = maps\_utility::get_other_player(self);
		var_02.has_thermal_fx = undefined;
	}
}

//Function Number: 59
loop_friendly_thermal_reflector_effect(param_00,param_01)
{
	if(!isdefined(self.has_ir))
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

		wait(0.2);
	}
}

//Function Number: 60
claymore_pickup_think_global()
{
	precacheitem("claymore");
	self endon("deleted");
	self setcursorhint("HINT_NOICON");
	self sethintstring(&"WEAPON_CLAYMORE_PICKUP");
	self makeusable();
	var_00 = weaponmaxammo("claymore") + weaponclipsize("claymore");
	if(isdefined(self.script_ammo_clip))
	{
		var_00 = self.script_ammo_clip;
	}

	while(var_00 > 0)
	{
		self waittill("trigger",var_01);
		var_01 playsound("null");
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
		if(isdefined(var_01.remotemissile_actionslot) && var_01.remotemissile_actionslot == 4)
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

//Function Number: 61
ammo_cache_think_global(param_00)
{
	self endon("remove_ammo_cache");
	self.use_trigger = spawn("script_model",self.origin + (0,0,28));
	self.use_trigger setmodel("tag_origin");
	self.use_trigger makeusable();
	self.use_trigger setcursorhint("HINT_NOICON");
	var_01 = &"WEAPON_CACHE_USE_HINT";
	if(getdvar("consoleGame") == "true")
	{
		var_01 = &"WEAPON_CACHE_USE_CONTROLLER_HINT";
	}

	self.use_trigger sethintstring(var_01);
	if(!isdefined(param_00) || isdefined(param_00) && param_00)
	{
		thread ammo_icon_think();
	}

	for(;;)
	{
		self.use_trigger waittill("trigger",var_02);
		if(isdefined(var_02.dont_allow_ammo_cache))
		{
			continue;
		}

		var_02.using_ammo_cache = 1;
		self notify("used_ammo_cache");
		self.use_trigger makeunusable();
		var_02 playsound("player_refill_all_ammo");
		var_02 disableweapons();
		wait(0.1);
		var_03 = var_02 getweaponslistall();
		foreach(var_05 in var_03)
		{
			if(var_05 == "claymore")
			{
				continue;
			}

			if(var_05 == "c4")
			{
				continue;
			}

			var_02 givemaxammo(var_05);
			var_06 = weaponclipsize(var_05);
			if(isdefined(var_06))
			{
				if(var_02 getweaponammoclip(var_05) < var_06)
				{
					var_02 setweaponammoclip(var_05,var_06);
				}
			}
		}

		wait(1.4);
		var_02 enableweapons();
		self.use_trigger makeusable();
		var_02.using_ammo_cache = undefined;
	}
}

//Function Number: 62
ammo_icon_think()
{
	self endon("remove_ammo_cache");
	var_00 = spawn("trigger_radius",self.origin,0,320,72);
	var_01 = newhudelem();
	var_01 setshader("waypoint_ammo",1,1);
	var_01.alpha = 0;
	var_01.color = (1,1,1);
	var_01.x = self.origin[0];
	var_01.y = self.origin[1];
	var_01.z = self.origin[2] + 16;
	var_01 setwaypoint(1,1);
	self.ammo_icon = var_01;
	self.ammo_icon_trig = var_00;
	if(isdefined(self.icon_always_show) && self.icon_always_show)
	{
		ammo_icon_fade_in(var_01);
		return;
	}

	wait(0.05);
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

			ammo_icon_fade_out(var_01);
			wait(0.25);
		}

		ammo_icon_fade_out(var_01);
	}
}

//Function Number: 63
ammo_icon_fade_in(param_00)
{
	if(param_00.alpha != 0)
	{
		return;
	}

	param_00 fadeovertime(0.2);
	param_00.alpha = 0.3;
	wait(0.2);
}

//Function Number: 64
ammo_icon_fade_out(param_00)
{
	if(param_00.alpha == 0)
	{
		return;
	}

	param_00 fadeovertime(0.2);
	param_00.alpha = 0;
	wait(0.2);
}

//Function Number: 65
window_destroy()
{
	var_00 = getglass(self.target);
	if(!isdefined(var_00))
	{
		return;
	}

	if(isdefined(self.script_noteworthy))
	{
		if(self.script_noteworthy == "ondamage" || self.script_noteworthy == "ondamage_appear")
		{
			if(self.script_noteworthy == "ondamage_appear")
			{
				self hide();
			}

			level waittillmatch(var_00,"glass_damaged");
			if(self.script_noteworthy == "ondamage_appear")
			{
				self show();
				level waittillmatch(var_00,"glass_destroyed");
			}

			self delete();
			return;
		}

		level waittillmatch(var_00,"glass_destroyed");
		self delete();
		return;
	}

	level waittillmatch(var_00,"glass_destroyed");
	self delete();
}

//Function Number: 66
global_empty_callback(param_00,param_01,param_02,param_03,param_04)
{
}

//Function Number: 67
weapon_list_debug()
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

//Function Number: 68
slowmo_system_init()
{
	level.slowmo = spawnstruct();
	slowmo_system_defaults();
	notifyoncommand("_cheat_player_press_slowmo","+melee");
	notifyoncommand("_cheat_player_press_slowmo","+melee_breath");
	notifyoncommand("_cheat_player_press_slowmo","+melee_zoom");
}

//Function Number: 69
slowmo_system_defaults()
{
	level.slowmo.lerp_time_in = 0;
	level.slowmo.lerp_time_out = 0.25;
	level.slowmo.speed_slow = 0.4;
	level.slowmo.speed_norm = 1;
}

//Function Number: 70
add_no_game_starts()
{
	var_00 = getentarray("script_origin_start_nogame","classname");
	if(!var_00.size)
	{
		return;
	}

	foreach(var_02 in var_00)
	{
		if(!isdefined(var_02.script_startname))
		{
			continue;
		}

		maps\_utility::add_start("no_game_" + var_02.script_startname,::start_nogame);
	}
}

//Function Number: 71
do_no_game_start()
{
	if(!maps\_utility::is_no_game_start())
	{
		return;
	}

	setsaveddvar("ufoHitsTriggers","1");
	level.stop_load = 1;
	if(isdefined(level.custom_no_game_setupfunc))
	{
		level [[ level.custom_no_game_setupfunc ]]();
	}

	maps\_loadout::init_loadout();
	soundscripts\_audio::aud_init();
	soundscripts\_snd::snd_init();
	maps\_global_fx::main();
	thread maps\_sp_matchdata::init();
	do_no_game_start_teleport();
	common_scripts\utility::array_call(getentarray("truckjunk","targetname"),::delete);
	common_scripts\utility::array_call(getentarray("truckjunk","script_noteworthy"),::delete);
	level waittill("eternity");
}

//Function Number: 72
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
		if(!isdefined(var_04.script_startname))
		{
			continue;
		}

		if(var_01 != var_04.script_startname)
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

//Function Number: 73
init_animsounds()
{
	level.animsounds = [];
	level.animsound_aliases = [];
	waittillframeend;
	waittillframeend;
	var_00 = getarraykeys(level.scr_notetrack);
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		init_notetracks_for_animname(var_00[var_01]);
	}

	var_00 = getarraykeys(level.scr_animsound);
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		init_animsounds_for_animname(var_00[var_01]);
	}
}

//Function Number: 74
init_animsounds_for_animname(param_00)
{
	var_01 = getarraykeys(level.scr_animsound[param_00]);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = var_01[var_02];
		var_04 = level.scr_animsound[param_00][var_03];
		level.animsound_aliases[param_00][var_03]["#" + var_03]["soundalias"] = var_04;
		level.animsound_aliases[param_00][var_03]["#" + var_03]["created_by_animSound"] = 1;
	}
}

//Function Number: 75
init_notetracks_for_animname(param_00)
{
	foreach(var_0A, var_02 in level.scr_notetrack[param_00])
	{
		foreach(var_09, var_04 in var_02)
		{
			foreach(var_06 in var_04)
			{
				var_07 = var_06["sound"];
				if(!isdefined(var_07))
				{
					continue;
				}

				level.animsound_aliases[param_00][var_0A][var_09]["soundalias"] = var_07;
				if(isdefined(var_06["created_by_animSound"]))
				{
					level.animsound_aliases[param_00][var_0A][var_09]["created_by_animSound"] = 1;
				}
			}
		}
	}
}

//Function Number: 76
default_footsteps()
{
	animscripts\utility::setfootstepeffect("default",loadfx("vfx/unique/no_fx"));
	animscripts\utility::setfootstepeffect("asphalt",loadfx("vfx/unique/no_fx"));
	animscripts\utility::setfootstepeffect("brick",loadfx("vfx/unique/no_fx"));
	animscripts\utility::setfootstepeffect("carpet",loadfx("vfx/unique/no_fx"));
	animscripts\utility::setfootstepeffect("cloth",loadfx("vfx/unique/no_fx"));
	animscripts\utility::setfootstepeffect("concrete",loadfx("vfx/unique/no_fx"));
	animscripts\utility::setfootstepeffect("cushion",loadfx("vfx/unique/no_fx"));
	animscripts\utility::setfootstepeffect("dirt",loadfx("vfx/treadfx/footstep_dust"));
	animscripts\utility::setfootstepeffect("foliage",loadfx("vfx/unique/no_fx"));
	animscripts\utility::setfootstepeffect("grass",loadfx("vfx/unique/no_fx"));
	animscripts\utility::setfootstepeffect("gravel",loadfx("vfx/unique/no_fx"));
	animscripts\utility::setfootstepeffect("mud",loadfx("vfx/treadfx/footstep_mud"));
	animscripts\utility::setfootstepeffect("rock",loadfx("vfx/unique/no_fx"));
	animscripts\utility::setfootstepeffect("sand",loadfx("vfx/unique/no_fx"));
	animscripts\utility::setfootstepeffect("wood",loadfx("vfx/unique/no_fx"));
	animscripts\utility::setfootstepeffect("water_waist",loadfx("vfx/treadfx/footstep_water"));
	animscripts\utility::setfootstepeffect("water_ankle",loadfx("vfx/treadfx/footstep_water"));
	animscripts\utility::setfootstepeffect("water_knee",loadfx("vfx/treadfx/footstep_water"));
	animscripts\utility::setfootstepeffect("snow",loadfx("vfx/unique/no_fx"));
	animscripts\utility::setfootstepeffect("ice",loadfx("vfx/unique/no_fx"));
	animscripts\utility::setfootstepeffectsmall("default",loadfx("vfx/unique/no_fx"));
	animscripts\utility::setfootstepeffectsmall("asphalt",loadfx("vfx/unique/no_fx"));
	animscripts\utility::setfootstepeffectsmall("brick",loadfx("vfx/unique/no_fx"));
	animscripts\utility::setfootstepeffectsmall("carpet",loadfx("vfx/unique/no_fx"));
	animscripts\utility::setfootstepeffectsmall("cloth",loadfx("vfx/unique/no_fx"));
	animscripts\utility::setfootstepeffectsmall("concrete",loadfx("vfx/unique/no_fx"));
	animscripts\utility::setfootstepeffectsmall("cushion",loadfx("vfx/unique/no_fx"));
	animscripts\utility::setfootstepeffectsmall("dirt",loadfx("vfx/treadfx/footstep_dust"));
	animscripts\utility::setfootstepeffectsmall("foliage",loadfx("vfx/unique/no_fx"));
	animscripts\utility::setfootstepeffectsmall("grass",loadfx("vfx/unique/no_fx"));
	animscripts\utility::setfootstepeffectsmall("gravel",loadfx("vfx/unique/no_fx"));
	animscripts\utility::setfootstepeffectsmall("mud",loadfx("vfx/treadfx/footstep_mud"));
	animscripts\utility::setfootstepeffectsmall("rock",loadfx("vfx/unique/no_fx"));
	animscripts\utility::setfootstepeffectsmall("sand",loadfx("vfx/unique/no_fx"));
	animscripts\utility::setfootstepeffectsmall("wood",loadfx("vfx/unique/no_fx"));
	animscripts\utility::setfootstepeffectsmall("water_waist",loadfx("vfx/treadfx/footstep_water"));
	animscripts\utility::setfootstepeffectsmall("water_ankle",loadfx("vfx/treadfx/footstep_water"));
	animscripts\utility::setfootstepeffectsmall("water_knee",loadfx("vfx/treadfx/footstep_water"));
	animscripts\utility::setfootstepeffectsmall("snow",loadfx("vfx/unique/no_fx"));
	animscripts\utility::setfootstepeffectsmall("ice",loadfx("vfx/unique/no_fx"));
	var_00 = "bodyfall small";
	var_01 = "J_SpineLower";
	var_02 = "bodyfall_";
	var_03 = "_small";
	animscripts\utility::setnotetrackeffect(var_00,var_01,"dirt",loadfx("vfx/treadfx/bodyfall_default_runner"),var_02,var_03);
	animscripts\utility::setnotetrackeffect(var_00,var_01,"concrete",loadfx("vfx/treadfx/bodyfall_default_runner"),var_02,var_03);
	animscripts\utility::setnotetrackeffect(var_00,var_01,"asphalt",loadfx("vfx/treadfx/bodyfall_default_runner"),var_02,var_03);
	animscripts\utility::setnotetrackeffect(var_00,var_01,"rock",loadfx("vfx/treadfx/bodyfall_default_runner"),var_02,var_03);
	var_04 = ["brick","carpet","foliage","grass","gravel","ice","metal","painted metal","mud","plaster","sand","snow","slush","water","wood","ceramic"];
	foreach(var_06 in var_04)
	{
		animscripts\utility::setnotetracksound(var_00,var_06,var_02,var_03);
	}

	var_00 = "bodyfall small";
	var_01 = "J_SpineLower";
	var_02 = "bodyfall_";
	var_03 = "_large";
	animscripts\utility::setnotetrackeffect(var_00,var_01,"dirt",loadfx("vfx/treadfx/bodyfall_default_runner"),var_02,var_03);
	animscripts\utility::setnotetrackeffect(var_00,var_01,"concrete",loadfx("vfx/treadfx/bodyfall_default_runner"),var_02,var_03);
	animscripts\utility::setnotetrackeffect(var_00,var_01,"asphalt",loadfx("vfx/treadfx/bodyfall_default_runner"),var_02,var_03);
	animscripts\utility::setnotetrackeffect(var_00,var_01,"rock",loadfx("vfx/treadfx/bodyfall_default_runner"),var_02,var_03);
	foreach(var_06 in var_04)
	{
		animscripts\utility::setnotetracksound(var_00,var_06,var_02,var_03);
	}
}

//Function Number: 77
functional_tester_load_next_start()
{
	wait(3);
	if(level.start_functions.size <= 0)
	{
		return;
	}

	var_00 = get_start_dvars();
	if(!isdefined(var_00) || !isdefined(level.start_point))
	{
		return;
	}

	var_01 = 0;
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(var_00[var_01] == level.start_point)
		{
			var_01++;
			break;
		}
	}

	if(var_01 >= var_00.size)
	{
		return;
	}

	setdvar("start",var_00[var_01]);
}