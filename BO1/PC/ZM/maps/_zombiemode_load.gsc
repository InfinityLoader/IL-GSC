#include common_scripts\utility;
#include maps\_utility;
#include maps\_hud_util;
#include maps\_load_common;
#include maps\_zombiemode_utility;
#using_animtree("generic_human");
main( bScriptgened,bCSVgened,bsgenabled )
{
	level.SPAWNFLAG_MODEL_DYNAMIC_PATH = 1;
	level.SPAWNFLAG_TRIGGER_AI_AXIS = 1;
	level.SPAWNFLAG_TRIGGER_AI_ALLIES = 2;
	level.SPAWNFLAG_TRIGGER_AI_NEUTRAL = 4;
	level.SPAWNFLAG_TRIGGER_NOT_PLAYER = 8;
	level.SPAWNFLAG_TRIGGER_VEHICLE = 16;
	level.SPAWNFLAG_TRIGGER_SPAWN = 32;
	level.SPAWNFLAG_TRIGGER_TOUCH_ONCE = 64;
	level.SPAWNFLAG_TRIGGER_SPAWN_MANAGER	= 512;
	level.SPAWNFLAG_TRIGGER_TRIGGER_ONCE	= 1024;
	level.SPAWNFLAG_ACTOR_SPAWNER = 1;
	level.SPAWNFLAG_ACTOR_SCRIPTFORCESPAWN	= 16;
	level.SPAWNFLAG_ACTOR_SM_PRIORITY = 32;
	level.SPAWNFLAG_VEHICLE_NODE_START_NODE	= 1;
	level.SPAWNFLAG_VEHICLE_USEABLE = 1;
	level.SPAWNFLAG_VEHICLE_SPAWNER = 2;
	level.SPAWNFLAG_TURRET_PREPLACED = 1;
	level.SPAWNFLAG_PATH_NOT_CHAIN = 2;
	level.SPAWNFLAG_PATH_DONT_STAND = 4;
	level.SPAWNFLAG_PATH_DONT_CROUCH = 8;
	level.SPAWNFLAG_PATH_DONT_PRONE = 16;
	level.SPAWNFLAG_PATH_DISABLED = 512;
	level.SPAWNFLAG_PATH_DONT_LEFT = 1024;
	level.SPAWNFLAG_PATH_BALCONY = 1024;
	level.SPAWNFLAG_PATH_DONT_RIGHT = 2048;
	level.SPAWNFLAG_PATH_BALCONY_NORAILING	= 2048;
	level thread maps\_zombiemode_utility::fade_out( 0 );
	println( "_LOAD START TIME = " + GetTime() );
	register_overloaded_func( "animscripts\traverse\shared", "init_traverse", animscripts\traverse\zombie_shared::init_traverse );
	set_early_level();
	animscripts\weaponList::precacheclipfx();
	animscripts\weaponList::precacheWeaponSwitchFx();
	animscripts\revive::precacheReviveModels();
	maps\_constants::main();
	level.scr_anim[ "generic" ][ "signal_onme" ]	= %CQB_stand_wave_on_me;
	level.scr_anim[ "generic" ][ "signal_go" ] = %CQB_stand_wave_go_v1;
	level.scr_anim[ "generic" ][ "signal_stop" ]	= %CQB_stand_signal_stop;
	level.scr_anim[ "generic" ][ "signal_moveup" ]	= %CQB_stand_signal_move_up;
	level.scr_anim[ "generic" ][ "signal_moveout" ]	= %CQB_stand_signal_move_out;
	if( !IsDefined( level.script_gen_dump_reasons ) )
	{
		level.script_gen_dump_reasons = [];
	}
	if( !IsDefined( bsgenabled ) )
	{
		level.script_gen_dump_reasons[level.script_gen_dump_reasons.size] = "First run";
	}
	if( !IsDefined( bCSVgened ) )
	{
		bCSVgened = false;
	}
	level.bCSVgened = bCSVgened;
	if( !IsDefined( bScriptgened ) )
	{
		bScriptgened = false;
	}
	else
	{
		bScriptgened = true;
	}
	level.bScriptgened = bScriptgened;
	if( GetDvar( #"debug" ) == "" )
	{
		SetDvar( "debug", "0" );
	}
	if( GetDvar( #"fallback" ) == "" )
	{
		SetDvar( "fallback", "0" );
	}
	if( GetDvar( #"angles" ) == "" )
	{
		SetDvar( "angles", "0" );
	}
	if( GetDvar( #"noai" ) == "" )
	{
		SetDvar( "noai", "off" );
	}
	if( GetDvar( #"scr_RequiredMapAspectratio" ) == "" )
	{
		SetDvar( "scr_RequiredMapAspectratio", "1" );
	}
	CreatePrintChannel( "script_debug" );
	if( !IsDefined( anim.notetracks ) )
	{
		anim.notetracks = [];
		animscripts\zombie_shared::registerNoteTracks();
	}
	level._loadStarted = true;
	level.first_frame = true;
	level.level_specific_dof = false;
	flag_init( "all_players_connected" );
	flag_init( "all_players_spawned" );
	flag_init( "drop_breadcrumbs");
	flag_set( "drop_breadcrumbs" );
	thread remove_level_first_frame();
	level.wait_any_func_array = [];
	level.run_func_after_wait_array = [];
	level.do_wait_endons_array = [];
	level.script = Tolower( GetDvar( #"mapname" ) );
	level.radiation_totalpercent = 0;
	level.clientscripts = ( GetDvar( #"cg_usingClientScripts" ) != "" );;
	level._client_exploders = [];
	level._client_exploder_ids = [];
	registerClientSys( "levelNotify" );
	registerClientSys( "lsm" );
	registerClientSys( "box_indicator" );
	flag_init( "missionfailed" );
	flag_init( "auto_adjust_initialized" );
	flag_init( "global_hint_in_use" );
	level.default_run_speed = 190;
	SetSavedDvar( "g_speed", level.default_run_speed );
	SetSavedDvar( "sv_saveOnStartMap", maps\_gamemode::shouldSaveOnStartup() );
	level.dronestruct = [];
	struct_class_init();
	if( !IsDefined( level.flag ) )
	{
		level.flag = [];
		level.flags_lock = [];
	}
	else
	{
		flags = GetArrayKeys( level.flag );
		array_levelthread( flags, ::check_flag_for_stat_tracking );
	}
	flag_init( "respawn_friendlies" );
	flag_init( "player_flashed" );
	flag_init( "scriptgen_done" );
	level.script_gen_dump_reasons = [];
	if( !IsDefined( level.script_gen_dump ) )
	{
		level.script_gen_dump = [];
		level.script_gen_dump_reasons[0] = "First run";
	}
	if( !IsDefined( level.script_gen_dump2 ) )
	{
		level.script_gen_dump2 = [];
	}
	if( IsDefined( level.createFXent ) )
	{
		script_gen_dump_addline( "maps\\createfx\\"+level.script+"_fx::main(); ", level.script+"_fx" );
	}
	if( IsDefined( level.script_gen_dump_preload ) )
	{
		for( i = 0; i < level.script_gen_dump_preload.size; i++ )
		{
			script_gen_dump_addline( level.script_gen_dump_preload[i].string, level.script_gen_dump_preload[i].signature );
		}
	}
	level.last_mission_sound_time = -5000;
	level.hero_list = [];
	level.ai_array = [];
	thread precache_script_models();
	PrecacheHeadIcon( "headicon_american" );
	PrecacheModel( "tag_origin" );
	PrecacheModel( "tag_origin_animate" );
	PrecacheShellShock( "level_end" );
	PrecacheShellShock( "default" );
	PrecacheShellShock( "flashbang" );
	PrecacheShellShock( "dog_bite" );
	PrecacheShellShock( "pain" );
	PrecacheRumble( "damage_heavy" );
	precacherumble( "dtp_rumble" );
	precacherumble( "slide_rumble" );
	PrecacheRumble( "damage_light" );
	PrecacheRumble( "grenade_rumble" );
	PrecacheRumble( "artillery_rumble" );
	PrecacheRumble( "reload_small" );
	PrecacheRumble( "reload_medium" );
	PrecacheRumble( "reload_large" );
	PrecacheRumble( "reload_clipin" );
	PrecacheRumble( "reload_clipout" );
	PrecacheRumble( "reload_rechamber" );
	PrecacheRumble( "pullout_small" );
	PrecacheString( &"GAME_GET_TO_COVER" );
	PrecacheString( &"SCRIPT_GRENADE_DEATH" );
	PrecacheString( &"SCRIPT_GRENADE_SUICIDE_LINE1" );
	PrecacheString( &"SCRIPT_GRENADE_SUICIDE_LINE2" );
	PrecacheString( &"SCRIPT_EXPLODING_VEHICLE_DEATH" );
	PrecacheString( &"SCRIPT_EXPLODING_BARREL_DEATH" );
	PrecacheString( &"STARTS_AVAILABLE_STARTS" );
	PrecacheString( &"STARTS_CANCEL" );
	PrecacheString( &"STARTS_DEFAULT" );
	if ( GetDvar( #"zombiemode" ) != "1" )
	{
		PreCacheShader( "overlay_low_health_splat" );
	}
	PrecacheShader( "overlay_low_health" );
	PrecacheShader( "overlay_low_health_compass" );
	PrecacheShader( "hud_grenadeicon" );
	PrecacheShader( "hud_grenadepointer" );
	PrecacheShader( "hud_burningcaricon" );
	PrecacheShader( "hud_burningbarrelicon" );
	PrecacheShader( "black" );
	PrecacheShader( "white" );
	PreCacheShellShock( "death" );
	PreCacheShellShock( "explosion" );
	PreCacheShellShock( "tank_mantle" );
	if(isdefined(level._gamemode_precache))
	{
		[[level._gamemode_precache]]();
	}
	WaterSimEnable( false );
	level.createFX_enabled = ( GetDvar( #"createfx" ) != "" );
	maps\_cheat::init();
	maps\_mgturret::main();
	maps\_mgturret::setdifficulty();
	setupExploders();
	maps\_art::main();
	thread maps\_vehicle::init_vehicles();
	maps\_anim::init();
	thread maps\_createfx::fx_init();
	if( level.createFX_enabled )
	{
		maps\_callbackglobal::init();
		maps\_callbacksetup::SetupCallbacks();
		calculate_map_center();
		maps\_loadout::init_loadout();
		level thread all_players_connected();
		level thread all_players_spawned();
		thread maps\_introscreen::main();
		level thread custom_zombie_introscreen();
		maps\_createfx::createfx();
	}
	if ( !isDefined(level.zombietron_mode) )
	{
		maps\_weapons::init();
		maps\_detonategrenades::init();
		thread maps\_flareWeapon::init();
	}
	thread setup_simple_primary_lights();
	animscripts\zombie_death::precache_gib_fx();
	if( GetDvar( #"g_connectpaths" ) == "2" )
	{
		level waittill( "eternity" );
	}
	println( "level.script: ", level.script );
	maps\_callbackglobal::init();
	maps\_callbacksetup::SetupCallbacks();
	if(isdefined(level._gamemode_initcallbacks))
	{
		[[level._gamemode_initcallbacks]]();
	}
	maps\_autosave::main();
	maps\_anim::init();
	maps\_busing::businit();
	maps\_music::music_init();
	maps\_dds::dds_init();
	if(!IsDefined(level.reviveFeature))
		level.reviveFeature = true;
	anim.useFacialAnims = false;
	if( !IsDefined( level.missionfailed ) )
	{
		level.missionfailed = false;
	}
	if( !IsDefined( level.blindfireTimeMin ) )
	{
		level.blindfireTimeMin = 3000;
	}
	if( !IsDefined( level.blindfireTimeMax ) )
	{
		level.blindfireTimeMax = 12000;
	}
	if( !IsDefined( level.secondBlindfireChance ) )
	{
		level.secondBlindfireChance = 50;
	}
	if(isDefined(level.skill_override))
	{
		maps\_gameskill::setSkill(undefined,level.skill_override);
	}
	else
	{
		maps\_gameskill::setSkill();
	}
	if ( isdefined( level.zombiemode_precache_player_model_override ) )
	{
		if( !IsDefined( level.player_loadout ) )
		{
			level.player_loadout = [];
			level.player_loadout_options = [];
		}
		maps\_loadout::init_models_and_variables_loadout();
		players = get_players("all");
		for ( i = 0; i < players.size; i++ )
		{
			players[i] maps\_loadout::give_loadout();
			players[i].pers["class"] = "closequarters";
		}
		level.loadoutComplete = true;
		level notify("loadout complete");
		[[ level.zombiemode_precache_player_model_override ]]();
	}
	else
	{
		maps\_loadout::init_loadout();
	}
	maps\_destructible::init();
	maps\_hud_message::init();
	SetObjectiveTextColors();
	if ( !isDefined(level.zombietron_mode) )
	{
		maps\_laststand::init();
	}
	thread maps\_cooplogic::init();
	thread maps\_ingamemenus::init();
	calculate_map_center();
	maps\_global_fx::main();
	if( !IsDefined( level.campaign ) )
	{
		level.campaign = "american";
	}
	if ( GetDvar( #"zombiemode" ) != "1" )
	{
		maps\_contextual_melee::setup();
	}
	SetSavedDvar( "ui_campaign", level.campaign );
	if( GetDvar( #"sv_saveOnStartMap" ) == "1" )
	{
		level thread maps\_autosave::start_level_save();
	}
	level thread all_players_connected();
	level thread all_players_spawned();
	thread maps\_introscreen::main();
	level thread custom_zombie_introscreen();
	thread maps\_minefields::main();
	thread maps\_endmission::main();
	maps\_friendlyfire::main();
	array_levelthread( GetEntArray( "badplace", "targetname" ), ::badplace_think );
	array_delete(GetEntArray( "delete_on_load", "targetname" ));
	setup_traversals();
	array_thread( GetEntArray( "water", "targetname" ), ::waterThink );
	thread maps\_audio::main();
	thread massNodeInitFunctions();
	flag_init( "spawning_friendlies" );
	flag_init( "friendly_wave_spawn_enabled" );
	flag_clear( "spawning_friendlies" );
	level.spawn_funcs = [];
	level.spawn_funcs["allies"] = [];
	level.spawn_funcs["axis"] = [];
	level.spawn_funcs["neutral"] = [];
	thread maps\_spawner::goalVolumes();
	level.trigger_hint_string = [];
	level.trigger_hint_func = [];
	level.fog_trigger_current = undefined;
	if( !IsDefined( level.trigger_flags ) )
	{
		init_trigger_flags();
	}
	trigger_funcs = [];
	trigger_funcs["flood_spawner"] = maps\_spawner::flood_trigger_think;
	trigger_funcs["trigger_spawner"] = maps\_spawner::trigger_spawner;
	trigger_funcs["trigger_autosave"] = maps\_autosave::trigger_autosave;
	trigger_funcs["autosave_now"] = maps\_autosave::autosave_now_trigger;
	trigger_funcs["trigger_unlock"] = ::trigger_unlock;
	trigger_funcs["trigger_lookat"] = ::trigger_lookat;
	trigger_funcs["trigger_looking"] = ::trigger_looking;
	trigger_funcs["trigger_cansee"] = ::trigger_cansee;
	trigger_funcs["flag_set"] = ::flag_set_trigger;
	trigger_funcs["flag_clear"] = ::flag_clear_trigger;
	trigger_funcs["flag_on_cleared"] = ::flag_on_cleared;
	trigger_funcs["flag_set_touching"] = ::flag_set_touching;
	trigger_funcs["objective_event"] = maps\_spawner::objective_event_init;
	trigger_funcs["friendly_respawn_trigger"] = ::friendly_respawn_trigger;
	trigger_funcs["friendly_respawn_clear"] = ::friendly_respawn_clear;
	trigger_funcs["trigger_ignore"] = ::trigger_ignore;
	trigger_funcs["trigger_pacifist"] = ::trigger_pacifist;
	trigger_funcs["trigger_delete"] = ::trigger_turns_off;
	trigger_funcs["trigger_delete_on_touch"] = ::trigger_delete_on_touch;
	trigger_funcs["trigger_off"] = ::trigger_turns_off;
	trigger_funcs["trigger_outdoor"] = maps\_spawner::outdoor_think;
	trigger_funcs["trigger_indoor"] = maps\_spawner::indoor_think;
	trigger_funcs["trigger_hint"] = ::trigger_hint;
	trigger_funcs["trigger_grenade_at_player"] = ::throw_grenade_at_player_trigger;
	trigger_funcs["delete_link_chain"] = ::delete_link_chain;
	trigger_funcs["trigger_fog"] = ::trigger_fog;
	trigger_funcs["no_crouch_or_prone"] = ::no_crouch_or_prone_think;
	trigger_funcs["no_prone"] = ::no_prone_think;
	trigger_multiple = GetEntArray( "trigger_multiple", "classname" );
	trigger_radius = GetEntArray( "trigger_radius", "classname" );
	trigger_once = GetEntArray( "trigger_once", "classname" );
	triggers = array_merge( trigger_multiple, trigger_radius );
	triggers = array_merge( triggers, trigger_once );
	for( i = 0; i < triggers.size; i++ )
	{
		if( triggers[i] has_spawnflag(level.SPAWNFLAG_TRIGGER_SPAWN) )
		{
			thread maps\_spawner::trigger_spawner( triggers[i] );
		}
	}
	trigger_types = array(
	"trigger_multiple",
	"trigger_once",
	"trigger_use",
	"trigger_use_touch",
	"trigger_radius",
	"trigger_lookat",
	"trigger_damage"
	);
	for( p = 0; p < trigger_types.size; p++ )
	{
		triggertype = trigger_types[p];
		triggers = GetEntArray( triggertype, "classname" );
		for( i = 0; i < triggers.size; i++ )
		{
			if ((triggertype != "trigger_once") && triggers[i] has_spawnflag(level.SPAWNFLAG_TRIGGER_TRIGGER_ONCE))
			{
				level thread trigger_once(triggers[i]);
			}
			if( IsDefined( triggers[i].script_flag_true ) )
			{
				level thread script_flag_true_trigger( triggers[i] );
			}
			if( IsDefined( triggers[i].script_flag_set ) )
			{
				level thread flag_set_trigger( triggers[i], triggers[i].script_flag_set );
			}
			if( IsDefined( triggers[i].script_flag_clear ) )
			{
				level thread flag_clear_trigger( triggers[i], triggers[i].script_flag_clear );
			}
			if( IsDefined( triggers[i].script_flag_false ) )
			{
				level thread script_flag_false_trigger( triggers[i] );
			}
			if( IsDefined( triggers[i].script_autosavename ) || IsDefined( triggers[i].script_autosave ) )
			{
				level thread maps\_autosave::autosave_name_think( triggers[i] );
			}
			if( IsDefined( triggers[i].script_fallback ) )
			{
				level thread maps\_spawner::fallback_think( triggers[i] );
			}
			if( IsDefined( triggers[i].script_mgTurretauto ) )
			{
				level thread maps\_mgturret::mgTurret_auto( triggers[i] );
			}
			if( IsDefined( triggers[i].script_killspawner ) )
			{
				level thread maps\_spawner::kill_spawner_trigger( triggers[i] );
			}
			if( IsDefined( triggers[i].script_emptyspawner ) )
			{
				level thread maps\_spawner::empty_spawner( triggers[i] );
			}
			if( IsDefined( triggers[i].script_prefab_exploder ) )
			{
				triggers[i].script_exploder = triggers[i].script_prefab_exploder;
			}
			if( IsDefined( triggers[i].script_exploder ) )
			{
				level thread exploder_load( triggers[i] );
			}
			if( IsDefined( triggers[i].script_bctrigger ) )
			{
				level thread bctrigger( triggers[i] );
			}
			if( IsDefined( triggers[i].script_trigger_group ) )
			{
				triggers[i] thread trigger_group();
			}
			if( IsDefined( triggers[i].script_notify ) )
			{
				level thread trigger_notify( triggers[i], triggers[i].script_notify );
			}
			if( IsDefined( triggers[i].targetname ) )
			{
				targetname = triggers[i].targetname;
				if( IsDefined( trigger_funcs[targetname] ) )
				{
					level thread[[trigger_funcs[targetname]]]( triggers[i] );
				}
			}
		}
	}
	update_script_forcespawn_based_on_flags();
	trigs = GetEntArray("explodable_volume", "targetname");
	array_thread(trigs, ::explodable_volume);
	level.ai_number = 0;
	level.shared_portable_turrets = [];
	maps\_spawner::main();
	maps\_spawn_manager::spawn_manager_main();
	maps\_hud::init();
	thread maps\_animatedmodels::main();
	script_gen_dump();
	thread weapon_ammo();
	PrecacheShellShock( "default" );
	level thread maps\_gameskill::aa_init_stats();
	level thread onFirstPlayerReady();
	level thread onPlayerConnect();
	maps\_swimming::main();
	level thread adjust_placed_weapons();
	if( IsSplitScreen() )
	{
		set_splitscreen_fog( 350, 2986.33, 10000, -480, 0.805, 0.715, 0.61, 0.0, 10000 );
	}
	level notify( "load main complete" );
	if(level.zombie_anim_intro && IsDefined(level.zombiemode_anim_intro_scenes) && IsDefined(level.zombiemode_animated_intro))
	{
		[[level.zombiemode_animated_intro]](level.zombiemode_anim_intro_scenes);
	}
	if(IsDefined(level.zombiemode_sidequest_init))
	{
		[[level.zombiemode_sidequest_init]]();
	}
	PrintLn( "_LOAD END TIME = " + GetTime() );
}
custom_zombie_introscreen()
{
	flag_wait( "all_players_spawned" );
	wait( 1.5 );
	level thread maps\_zombiemode_utility::fade_in();
}
onPlayerConnect()
{
	for( ;; )
	{
		level waittill( "connecting", player );
		if( !IsDefined( player.a ) )
		{
			player.a = SpawnStruct();
		}
		player thread animscripts\zombie_init::onPlayerConnect();
		player thread onPlayerSpawned();
		player thread onPlayerDisconnect();
		if( IsSplitScreen() )
		{
			SetDvar( "r_watersim", false );
		}
	}
}
onPlayerDisconnect()
{
	self waittill( "disconnect" );
	if( IsSplitScreen() )
	{
		SetDvar( "r_watersim", true );
	}
}
onPlayerSpawned()
{
	self endon( "disconnect" );
	for( ;; )
	{
		self GiveWeapon( "m1911_zm" );
		self SetSpawnWeapon( "m1911_zm" );
		self waittill( "spawned_player" );
		if( level.mutators[ "mutator_susceptible" ] )
		{
			self.maxhealth	= 50;
			self.health = 50;
		}
		else
		{
			self.maxhealth = 100;
		}
		self.attackeraccuracy = 1;
		self.pers["class"] = "closequarters";
		self.pers["team"] = "allies";
		println( "player health: "+self.health );
		if( level.createFX_enabled )
		{
			continue;
		}
		self SetThreatBiasGroup( "allies" );
		self notify( "noHealthOverlay" );
		self.starthealth = self.maxhealth;
		self.shellshocked = false;
		self.inWater = false;
		self DetachAll();
		players = get_players();
		if( players.size == 1 && (1 != GetDvarInt( #"zombiefive_norandomchar" )) )
		{
			self.zm_random_char = RandomInt( 4 );
		}
		if ( isdefined( level.zombiemode_give_player_model_override ) )
		{
			self [[ level.zombiemode_give_player_model_override ]]( self GetEntityNumber() );
			if( IsDefined( level.player_viewmodel ) )
			{
				self SetViewModel( level.player_viewmodel );
			}
		}
		else
		{
			self maps\_loadout::give_model( self.pers["class"] );
		}
		maps\_loadout::give_loadout( true );
		self notify ( "CAC_loadout");
		if ( !isDefined(level.zombietron_mode) )
		{
			players = get_players();
			if( players.size == 1 && IsDefined( self.zm_random_char ) )
			{
				self player_set_viewmodel( self.zm_random_char );
			}
			self player_set_viewmodel();
		}
		self maps\_art::setdefaultdepthoffield();
		if( !IsDefined( self.player_inited ) || !self.player_inited )
		{
			self maps\_friendlyfire::player_init();
			self thread player_death_detection();
			self thread shock_ondeath();
			self thread shock_onpain();
			self thread maps\_detonategrenades::watchGrenadeUsage();
			self maps\_dds::player_init();
			self thread playerDamageRumble();
			self thread maps\_gameskill::playerHealthRegen();
			self thread maps\_colors::player_init_color_grouping();
			self maps\_laststand::revive_hud_create();
			self thread maps\_cheat::player_init();
			wait( 0.05 );
			self.player_inited = true;
		}
	}
}
player_set_viewmodel( zm_random_solo_char )
{
	if( IsDefined( zm_random_solo_char ) )
	{
		self.entity_num = zm_random_solo_char;
	}
	if( !IsDefined( self.entity_num ) )
	{
		self.entity_num = self GetEntityNumber();
	}
	if ( isdefined( level.zombiemode_player_set_viewmodel_override ) )
	{
		[[ level.zombiemode_player_set_viewmodel_override ]]( self.entity_num );
	}
	else if( IsSubStr( level.script, "zombie_theater" ) )
	{
		switch( self.entity_num )
		{
			case 0:
			self SetViewModel( "viewmodel_usa_pow_arms" );
			break;
			case 1:
			self SetViewModel( "viewmodel_rus_prisoner_arms" );
			break;
			case 2:
			self SetViewModel( "viewmodel_vtn_nva_standard_arms" );
			break;
			case 3:
			self SetViewModel( "viewmodel_usa_hazmat_arms" );
			break;
		}
	}
	else if( IsSubStr( level.script, "zombie_pentagon" ) )
	{
		switch( self.entity_num )
		{
			case 0:
			self SetViewModel( "viewmodel_usa_pow_arms" );
			break;
			case 1:
			self SetViewModel( "viewmodel_usa_pow_arms" );
			break;
			case 2:
			self SetViewModel( "viewmodel_usa_pow_arms" );
			break;
			case 3:
			self SetViewModel( "viewmodel_usa_pow_arms" );
			break;
		}
	}
	else
	{
		self SetViewModel( "viewmodel_usa_pow_arms" );
	}
} 