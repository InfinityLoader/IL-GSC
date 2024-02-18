#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;
#include animscripts\zombie_Utility;
#using_animtree( "generic_human" );
init()
{
	PrecacheRumble( "explosion_generic" );
	director_precache_models();
	init_director_zombie_anims();
	level._effect["director_groundhit"] = loadfx("maps/zombie/fx_zombie_boss_grnd_hit");
	level._effect["director_spawn"] = loadfx("maps/zombie/fx_zombie_boss_spawn");
	level._effect["director_weapon_light"] = loadfx("maps/zombie/fx_zombie_boss_weapon_light");
	level._effect["director_weapon_light_big"] = loadfx("maps/zombie/fx_zombie_boss_weapon_light_big");
	level._effect["director_weapon_light_blink"] = loadfx("maps/zombie/fx_zombie_boss_weapon_light_blink");
	level._effect["director_weapon_docile"] = loadfx("maps/zombie/fx_zombie_boss_weapon_docile");
	level._effect["director_death_head"] = loadfx("maps/zombie/fx_zombie_boss_death_head");
	level._effect["director_death_torso"] = loadfx("maps/zombie/fx_zombie_boss_death_torso");
	level._effect["director_death_weapon"] = loadfx("maps/zombie/fx_zombie_boss_weapon_defeat");
	level._effect["director_impact_humangun"] = loadfx("weapon/human_gun/fx_hgun_impact_exp_lrg");
	level._effect["director_impact_humangun_upgraded"] = loadfx("weapon/human_gun/fx_hgun_impact_exp_lrg_ug");
	if( !isDefined( level.director_zombie_spawn_heuristic ) )
	{
		level.director_zombie_spawn_heuristic = maps\_zombiemode_ai_director::director_zombie_default_spawn_heuristic;
	}
	if( !isDefined( level.director_zombie_pathfind_heuristic ) )
	{
		level.director_zombie_pathfind_heuristic = maps\_zombiemode_ai_director::director_zombie_default_pathfind_heuristic;
	}
	if ( !isDefined( level.director_zombie_enter_level ) )
	{
		level.director_zombie_enter_level = maps\_zombiemode_ai_director::director_zombie_default_enter_level;
	}
	if ( !isDefined( level.director_reenter_level ) )
	{
		level.director_reenter_level = ::director_reenter_level;
	}
	if ( !isDefined( level.director_exit_level ) )
	{
		level.director_exit_level = ::director_exit_level;
	}
	if ( !isDefined( level.director_find_exit ) )
	{
		level.director_find_exit = ::director_find_exit;
	}
	if ( !isDefined( level.director_devgui_health ) )
	{
		level.director_devgui_health = ::director_devgui_health;
	}
	precacheshellshock( "electrocution" );
	level.num_director_zombies = 0;
	level.director_zombie_spawners = GetEntArray( "boss_zombie_spawner", "targetname" );
	array_thread( level.director_zombie_spawners, ::add_spawn_function, maps\_zombiemode_ai_director::director_prespawn );
	if( !isDefined( level.max_director_zombies ) )
	{
		level.max_director_zombies = 1;
	}
	if( !isDefined( level.director_zombie_health_mult ) )
	{
		level.director_zombie_health_mult = 7;
	}
	if( !isDefined( level.director_zombie_max_health ) )
	{
		level.director_zombie_max_health = 1000000;
	}
	if( !isDefined( level.director_zombie_scream_a_chance ) )
	{
		level.director_zombie_scream_a_chance = 100;
	}
	if( !isDefined( level.director_zombie_scream_a_radius ) )
	{
		level.director_zombie_scream_a_radius_sq = 1024*1024;
	}
	if( !isDefined( level.director_zombie_scream_b_chance ) )
	{
		level.director_zombie_scream_b_chance = 0;
	}
	if( !isDefined( level.director_zombie_scream_b_radius ) )
	{
		level.director_zombie_scream_b_radius_sq = 512*512;
	}
	if( !isDefined( level.director_zombie_groundhit_damage ) )
	{
		level.director_zombie_groundhit_damage = 90;
	}
	if( !isDefined( level.director_zombie_groundhit_radius ) )
	{
		level.director_zombie_groundhit_radius = 256;
	}
	if( !isDefined( level.director_zombie_proximity_wake ) )
	{
		level.director_zombie_proximity_wake = 1296;
	}
	if( !isDefined( level.director_ground_attack_delay ) )
	{
		level.director_ground_attack_delay = 5000;
	}
	if( !isDefined( level.director_max_ammo_chance_default ) )
	{
		level.director_max_ammo_chance_default = 10;
	}
	if( !isDefined( level.director_max_ammo_chance_inc ) )
	{
		level.director_max_ammo_chance_inc = 5;
	}
	if( !isDefined( level.director_max_damage_taken ) )
	{
		level.director_max_damage_taken = 250000;
		level.director_max_damage_taken_easy = 1000;
	}
	if( !isDefined( level.director_max_speed_buff ) )
	{
		level.director_max_speed_buff = 2;
	}
	level thread director_zombie_manager();
	level.director_death = 0;
	level.director_health_reduce = 0.7;
	level.scr_anim["zombie"]["sprint5"] = %ai_zombie_fast_sprint_01;
	level.scr_anim["zombie"]["sprint6"] = %ai_zombie_fast_sprint_02;
	level.director_zombie_range = 480 * 480;
	level.director_enemy_range = 900 * 900;
	level.director_speed_buff_range = 300;
	level.director_speed_buff_range_sq = level.director_speed_buff_range * level.director_speed_buff_range;
	level.director_electric_buff_range = 256;
	level.director_electric_buff_range_sq = level.director_electric_buff_range * level.director_electric_buff_range;
	level.director_electrify_range_sq = 1024 * 1024;
	level.director_speed_buff = 0;
	level thread setup_player_damage_watchers();
	level thread director_max_ammo_watcher();
}
director_precache_models()
{
	PrecacheModel( "t5_weapon_engineer_club" );
	PrecacheModel( "c_zom_george_romero_zombiefied_fb" );
}
#using_animtree( "generic_human" );
director_prespawn()
{
	self.animname = "director_zombie";
	self.custom_idle_setup = maps\_zombiemode_ai_director::director_zombie_idle_setup;
	self.a.idleAnimOverrideArray = [];
	self.a.idleAnimOverrideArray["stand"] = [];
	self.a.idleAnimOverrideWeights["stand"] = [];
	self.a.idleAnimOverrideArray["stand"][0][0] = %ai_zombie_boss_idle_a_coast;
	self.a.idleAnimOverrideWeights["stand"][0][0] = 10;
	self.a.idleAnimOverrideArray["stand"][0][1] = %ai_zombie_boss_idle_b_coast;
	self.a.idleAnimOverrideWeights["stand"][0][1] = 10;
	self.ignoreall = true;
	self.allowdeath = true;
	self.is_zombie = true;
	self.has_legs = true;
	self allowedStances( "stand" );
	self.gibbed = false;
	self.head_gibbed = false;
	self.disableArrivals = true;
	self.disableExits = true;
	self.grenadeawareness = 0;
	self.badplaceawareness = 0;
	self.ignoreSuppression = true;
	self.suppressionThreshold = 1;
	self.noDodgeMove = true;
	self.dontShootWhileMoving = true;
	self.pathenemylookahead = 0;
	self.badplaceawareness = 0;
	self.chatInitialized = false;
	self.a.disablePain = true;
	self disable_react();
	self.freezegun_damage = 0;
	self.dropweapon = false;
	self thread maps\_zombiemode_spawner::zombie_damage_failsafe();
	self thread maps\_zombiemode_spawner::delayed_zombie_eye_glow();
	self.flame_damage_time = 0;
	self.meleeDamage = 50;
	self.no_powerups = true;
	self.custom_damage_func = ::director_custom_damage;
	self.nuke_damage_func = ::director_nuke_damage;
	self.tesla_damage_func = ::director_tesla_damage;
	self.actor_full_damage_func = ::director_full_damage;
	self.instakill_func = ::director_instakill;
	self.humangun_hit_response = ::director_humangun_hit_response;
	self.melee_anim_func = ::director_melee_anim;
	self.set_animarray_standing_override = ::director_set_animarray_standing;
	self.melee_miss_func = ::director_melee_miss;
	self.flinger_func = ::director_fling;
	self.non_attacker_func = ::director_non_attacker;
	self.noChangeDuringMelee = true;
	self.ignore_enemy_count = true;
	self.ignore_water_damage = true;
	self.ignore_speed_buff = true;
	self.ignore_devgui_death = true;
	self.no_damage_points = true;
	self.electrified = true;
	self.ground_hit = false;
	self.nextGroundHit = 0;
	self.can_move_with_bolt = true;
	self.ignore_all_poi = true;
	self.check_melee_path = true;
	self.allowpain = false;
	self setTeamForEntity( "axis" );
	if ( isDefined( level.director_init_done ) )
	{
		self thread [[ level.director_init_done ]]();
	}
	level.zombie_director = self;
	self notify( "zombie_init_done" );
}
director_health_watch()
{
	self endon( "death" );
	while ( 1 )
	{
		wait( 1 );
	}
}
director_zombie_idle_setup()
{
	self.a.array["turn_left_45"] = %exposed_tracking_turn45L;
	self.a.array["turn_left_90"] = %exposed_tracking_turn90L;
	self.a.array["turn_left_135"] = %exposed_tracking_turn135L;
	self.a.array["turn_left_180"] = %exposed_tracking_turn180L;
	self.a.array["turn_right_45"] = %exposed_tracking_turn45R;
	self.a.array["turn_right_90"] = %exposed_tracking_turn90R;
	self.a.array["turn_right_135"] = %exposed_tracking_turn135R;
	self.a.array["turn_right_180"] = %exposed_tracking_turn180L;
	self.a.array["exposed_idle"] = array( %ai_zombie_boss_idle_a_coast, %ai_zombie_boss_idle_b_coast );
	self.a.array["straight_level"] = %ai_zombie_boss_idle_a_coast;
	self.a.array["stand_2_crouch"] = %ai_zombie_shot_leg_right_2_crawl;
}
init_director_zombie_anims()
{
	level.scr_anim["director_zombie"]["death1"] = %ai_zombie_boss_death_coast;
	level.scr_anim["director_zombie"]["death2"] = %ai_zombie_boss_death_a_coast;
	level.scr_anim["director_zombie"]["death3"] = %ai_zombie_boss_death_explode_coast;
	level.scr_anim["director_zombie"]["death4"] = %ai_zombie_boss_death_mg_coast;
	level.scr_anim["director_zombie"]["walk1"] = %ai_zombie_boss_walk_slow_coast;
	level.scr_anim["director_zombie"]["walk2"] = %ai_zombie_boss_walk_a_coast;
	level.scr_anim["director_zombie"]["run1"] = %ai_zombie_walk_fast_v1;
	level.scr_anim["director_zombie"]["run2"] = %ai_zombie_walk_fast_v2;
	level.scr_anim["director_zombie"]["run3"] = %ai_zombie_walk_fast_v3;
	level.scr_anim["director_zombie"]["run4"] = %ai_zombie_run_v2;
	level.scr_anim["director_zombie"]["run5"] = %ai_zombie_run_v4;
	level.scr_anim["director_zombie"]["run6"] = %ai_zombie_run_v3;
	level.scr_anim["director_zombie"]["sprint1"] = %ai_zombie_boss_sprint_a_coast;
	level.scr_anim["director_zombie"]["sprint2"] = %ai_zombie_boss_sprint_a_coast;
	level.scr_anim["director_zombie"]["sprint3"] = %ai_zombie_boss_sprint_b_coast;
	level.scr_anim["director_zombie"]["sprint4"] = %ai_zombie_boss_sprint_b_coast;
	level.scr_anim["director_zombie"]["crawl1"] = %ai_zombie_crawl;
	level.scr_anim["director_zombie"]["crawl2"] = %ai_zombie_crawl_v1;
	level.scr_anim["director_zombie"]["crawl3"] = %ai_zombie_crawl_v2;
	level.scr_anim["director_zombie"]["crawl4"] = %ai_zombie_crawl_v3;
	level.scr_anim["director_zombie"]["crawl5"] = %ai_zombie_crawl_v4;
	level.scr_anim["director_zombie"]["crawl6"] = %ai_zombie_crawl_v5;
	level.scr_anim["director_zombie"]["crawl_hand_1"] = %ai_zombie_walk_on_hands_a;
	level.scr_anim["director_zombie"]["crawl_hand_2"] = %ai_zombie_walk_on_hands_b;
	level.scr_anim["director_zombie"]["crawl_sprint1"] = %ai_zombie_crawl_sprint;
	level.scr_anim["director_zombie"]["crawl_sprint2"] = %ai_zombie_crawl_sprint_1;
	level.scr_anim["director_zombie"]["crawl_sprint3"] = %ai_zombie_crawl_sprint_2;
	level.scr_anim["director_zombie"]["walk2sprint"] = %ai_zombie_boss_walk_2_sprint_coast;
	level.scr_anim["director_zombie"]["sprint2walk"] = %ai_zombie_boss_sprint_2_walk_coast;
	if( !isDefined( level._zombie_melee ) )
	{
		level._zombie_melee = [];
	}
	if( !isDefined( level._zombie_walk_melee ) )
	{
		level._zombie_walk_melee = [];
	}
	if( !isDefined( level._zombie_run_melee ) )
	{
		level._zombie_run_melee = [];
	}
	level._zombie_melee["director_zombie"] = [];
	level._zombie_walk_melee["director_zombie"] = [];
	level._zombie_run_melee["director_zombie"] = [];
	level._zombie_melee["director_zombie"][0] = %ai_zombie_boss_attack_multiswing_a_coast;
	level._zombie_melee["director_zombie"][1] = %ai_zombie_boss_attack_multiswing_b_coast;
	level._zombie_melee["director_zombie"][2] = %ai_zombie_boss_attack_swing_overhead_coast;
	level._zombie_melee["director_zombie"][3] = %ai_zombie_boss_attack_swing_swipe_coast;
	if( isDefined( level.director_zombie_anim_override ) )
	{
		[[ level.director_zombie_anim_override ]]();
	}
	level._zombie_run_melee["director_zombie"][0] =	%ai_zombie_boss_attack_running_coast;
	level._zombie_run_melee["director_zombie"][1] =	%ai_zombie_boss_attack_sprinting_coast;
	level._zombie_run_melee["director_zombie"][2] =	%ai_zombie_boss_attack_running_coast;
	if( !isDefined( level._zombie_melee_crawl ) )
	{
		level._zombie_melee_crawl = [];
	}
	level._zombie_melee_crawl["director_zombie"] = [];
	level._zombie_melee_crawl["director_zombie"][0] = %ai_zombie_attack_crawl;
	level._zombie_melee_crawl["director_zombie"][1] = %ai_zombie_attack_crawl_lunge;
	if( !isDefined( level._zombie_stumpy_melee ) )
	{
		level._zombie_stumpy_melee = [];
	}
	level._zombie_stumpy_melee["director_zombie"] = [];
	level._director_zombie_stumpy_melee["director_zombie"][0] = %ai_zombie_walk_on_hands_shot_a;
	level._director_zombie_stumpy_melee["director_zombie"][1] = %ai_zombie_walk_on_hands_shot_b;
	if( !isDefined( level._zombie_tesla_deaths ) )
	{
		level._zombie_tesla_deaths = [];
	}
	level._zombie_tesla_death["director_zombie"] = [];
	level._zombie_tesla_death["director_zombie"][0] = %ai_zombie_boss_tesla_death_a_coast;
	level._zombie_tesla_death["director_zombie"][1] = %ai_zombie_boss_tesla_death_a_coast;
	level._zombie_tesla_death["director_zombie"][2] = %ai_zombie_boss_tesla_death_a_coast;
	level._zombie_tesla_death["director_zombie"][3] = %ai_zombie_boss_tesla_death_a_coast;
	level._zombie_tesla_death["director_zombie"][4] = %ai_zombie_boss_tesla_death_a_coast;
	if( !isDefined( level._zombie_tesla_crawl_death ) )
	{
		level._zombie_tesla_crawl_death = [];
	}
	level._zombie_tesla_crawl_death["director_zombie"] = [];
	level._zombie_tesla_crawl_death["director_zombie"][0] = %ai_zombie_tesla_crawl_death_a;
	level._zombie_tesla_crawl_death["director_zombie"][1] = %ai_zombie_tesla_crawl_death_b;
	if( !isDefined( level._zombie_deaths ) )
	{
		level._zombie_deaths = [];
	}
	level._zombie_deaths["director_zombie"] = [];
	level._zombie_deaths["director_zombie"][0] = %ai_zombie_boss_death_coast;
	level._zombie_deaths["director_zombie"][1] = %ai_zombie_boss_death_a_coast;
	level._zombie_deaths["director_zombie"][2] = %ai_zombie_boss_death_explode_coast;
	level._zombie_deaths["director_zombie"][3] = %ai_zombie_boss_death_mg_coast;
	if( !isDefined( level._zombie_rise_anims ) )
	{
		level._zombie_rise_anims = [];
	}
	level._zombie_rise_anims["director_zombie"] = [];
	level._zombie_rise_anims["director_zombie"][1]["walk"][0] = %ai_zombie_traverse_ground_v1_walk;
	level._zombie_rise_anims["director_zombie"][1]["run"][0] = %ai_zombie_traverse_ground_v1_run;
	level._zombie_rise_anims["director_zombie"][1]["sprint"][0]	= %ai_zombie_traverse_ground_climbout_fast;
	level._zombie_rise_anims["director_zombie"][2]["walk"][0] = %ai_zombie_traverse_ground_v2_walk_altA;
	if( !isDefined( level._zombie_rise_death_anims ) )
	{
		level._zombie_rise_death_anims = [];
	}
	level._zombie_rise_death_anims["director_zombie"] = [];
	level._zombie_rise_death_anims["director_zombie"][1]["in"][0] = %ai_zombie_traverse_ground_v1_deathinside;
	level._zombie_rise_death_anims["director_zombie"][1]["in"][1] = %ai_zombie_traverse_ground_v1_deathinside_alt;
	level._zombie_rise_death_anims["director_zombie"][1]["out"][0] = %ai_zombie_traverse_ground_v1_deathoutside;
	level._zombie_rise_death_anims["director_zombie"][1]["out"][1] = %ai_zombie_traverse_ground_v1_deathoutside_alt;
	level._zombie_rise_death_anims["director_zombie"][2]["in"][0] = %ai_zombie_traverse_ground_v2_death_low;
	level._zombie_rise_death_anims["director_zombie"][2]["in"][1] = %ai_zombie_traverse_ground_v2_death_low_alt;
	level._zombie_rise_death_anims["director_zombie"][2]["out"][0] = %ai_zombie_traverse_ground_v2_death_high;
	level._zombie_rise_death_anims["director_zombie"][2]["out"][1] = %ai_zombie_traverse_ground_v2_death_high_alt;
	if( !isDefined( level._zombie_run_taunt ) )
	{
		level._zombie_run_taunt = [];
	}
	if( !isDefined( level._zombie_board_taunt ) )
	{
		level._zombie_board_taunt = [];
	}
	level._zombie_run_taunt["director_zombie"] = [];
	level._zombie_board_taunt["director_zombie"] = [];
	level._zombie_board_taunt["director_zombie"][0] = %ai_zombie_taunts_4;
	level._zombie_board_taunt["director_zombie"][1] = %ai_zombie_taunts_7;
	level._zombie_board_taunt["director_zombie"][2] = %ai_zombie_taunts_9;
	level._zombie_board_taunt["director_zombie"][3] = %ai_zombie_taunts_5b;
	level._zombie_board_taunt["director_zombie"][4] = %ai_zombie_taunts_5c;
	level._zombie_board_taunt["director_zombie"][5] = %ai_zombie_taunts_5d;
	level._zombie_board_taunt["director_zombie"][6] = %ai_zombie_taunts_5e;
	level._zombie_board_taunt["director_zombie"][7] = %ai_zombie_taunts_5f;
}
director_zombie_spawn()
{
	self.script_moveoverride = true;
	if( !isDefined( level.num_director_zombies ) )
	{
		level.num_director_zombies = 0;
	}
	level.num_director_zombies++;
	director_zombie = self maps\_zombiemode_net::network_safe_stalingrad_spawn( "boss_zombie_spawn", 1 );
	director_zombie Hide();
	self.count = 666;
	self.last_spawn_time = GetTime();
	if( !spawn_failed( director_zombie ) )
	{
		director_zombie.script_noteworthy = self.script_noteworthy;
		director_zombie.targetname = self.targetname;
		director_zombie.target = self.target;
		director_zombie.deathFunction = maps\_zombiemode_ai_director::director_zombie_die;
		director_zombie.animname = "director_zombie";
		director_zombie thread director_zombie_think();
	}
	else
	{
		level.num_director_zombies--;
	}
}
director_zombie_manager()
{
	start_boss = getent( "start_boss_spawner", "script_noteworthy" );
	if ( isDefined( start_boss ) )
	{
		while ( true )
		{
			if ( level.num_director_zombies < level.max_director_zombies )
			{
				start_boss director_zombie_spawn();
				break;
			}
			wait( 0.5 );
		}
	}
	while( true )
	{
		AssertEx( isDefined( level.num_director_zombies ) && isDefined( level.max_director_zombies ), "Either max_director_zombies or num_director_zombies not defined, this should never be the case!" );
		while( level.num_director_zombies < level.max_director_zombies )
		{
			spawner = director_zombie_pick_best_spawner();
			if( isDefined( spawner ) )
			{
				spawner director_zombie_spawn();
			}
			wait( 10 );
		}
		wait( 10 );
	}
}
director_zombie_pick_best_spawner()
{
	best_spawner = undefined;
	best_score = -1;
	for( i = 0; i < level.director_zombie_spawners.size; i++ )
	{
		score = [[ level.director_zombie_spawn_heuristic ]]( level.director_zombie_spawners[i] );
		if( score > best_score )
		{
			best_spawner = level.director_zombie_spawners[i];
			best_score = score;
		}
	}
	return best_spawner;
}
show_damage()
{
	while ( 1 )
	{
		iprintln( "damage = " + self.dmg_taken );
		wait( 1 );
	}
}
director_display_damage()
{
	self endon( "death" );
	while ( 1 )
	{
		display = GetDvarInt( #"scr_director_display_damage" );
		if ( display )
		{
			print3d( self.origin + ( 0, 0, 72 ), "Damage " + self.dmg_taken, ( 1, 1, 1 ), 1, 1, 10 );
		}
		wait( .5 );
	}
}
director_devgui_health()
{
	if ( isDefined( level.zombie_director ) )
	{
		level.zombie_director director_reset_health( true );
	}
}
director_reset_health( easy )
{
	players = getplayers();
	num_players = players.size;
	self.max_damage_taken = level.director_max_damage_taken * num_players;
	if ( is_true( easy ) )
	{
		self.max_damage_taken = level.director_max_damage_taken_easy * num_players;
	}
	self.damage_one = self.max_damage_taken * .33;
	self.damage_two = self.max_damage_taken * .66;
	director_print( "reset damage " + self.max_damage_taken );
}
director_flip_light_flag()
{
	if ( !is_true( self.director_light_set ) )
	{
		self.director_light_set = true;
		self setclientflag( level._ZOMBIE_ACTOR_FLAG_DIRECTOR_LIGHT );
	}
	else
	{
		self.director_light_set = undefined;
		self clearclientflag( level._ZOMBIE_ACTOR_FLAG_DIRECTOR_LIGHT );
	}
}
director_reset_light_flag()
{
	self endon( "death" );
	if ( self.health_state == "pristine" )
	{
		self director_flip_light_flag();
		wait( 0.25 );
		self director_flip_light_flag();
		wait( 0.25 );
		self director_flip_light_flag();
		wait( 0.25 );
		self director_flip_light_flag();
	}
	else if ( self.health_state == "full" )
	{
		self director_flip_light_flag();
		wait( 0.25 );
		self director_flip_light_flag();
		wait( 0.25 );
		self director_flip_light_flag();
	}
	else if ( self.health_state == "damage_one" )
	{
		self director_flip_light_flag();
		wait( 0.25 );
		self director_flip_light_flag();
	}
	else if ( self.health_state == "damage_two" )
	{
		self director_flip_light_flag();
	}
}
director_watch_damage()
{
	self endon( "death" );
	self endon( "humangun_leave" );
	self.dmg_taken = 0;
	self director_reset_health( false );
	self.health_state = "pristine";
	while ( 1 )
	{
		self waittill( "damage", amount, attacker, direction, point, method );
		if ( !is_true( self.start_zombies ) )
		{
			self.start_zombies = true;
			self notify( "director_spawn_zombies" );
		}
		if ( is_true( self.leaving_level ) )
		{
			return;
		}
		self.dmg_taken += amount;
		if ( self.health_state == "pristine" )
		{
			self.health_state = "full";
			self director_flip_light_flag();
		}
		else if ( self.health_state == "full" && self.dmg_taken >= self.damage_one )
		{
			self.health_state = "damage_one";
			self director_flip_light_flag();
			if( IsDefined( level._audio_director_vox_play ) )
			{
				rand = RandomIntRange( 0, 5 );
				self thread [[ level._audio_director_vox_play ]]( "vox_romero_weaken_" + rand, .25 );
			}
			if( IsDefined( attacker ) && IsPlayer( attacker ) )
			{
				attacker thread maps\_zombiemode_audio::create_and_play_dialog( "director", "weaken" );
			}
		}
		else if ( self.health_state == "damage_one" && self.dmg_taken >= self.damage_two )
		{
			self.health_state = "damage_two";
			self.light StopLoopSound(2);
			self director_flip_light_flag();
			if( IsDefined( level._audio_director_vox_play ) )
			{
				rand = RandomIntRange( 0, 5 );
				self thread [[ level._audio_director_vox_play ]]( "vox_romero_weaken_" + rand, .25 );
			}
			if( IsDefined( attacker ) && IsPlayer( attacker ) )
			{
				attacker thread maps\_zombiemode_audio::create_and_play_dialog( "director", "weaken" );
			}
		}
		if ( self.dmg_taken >= self.max_damage_taken )
		{
			self director_flip_light_flag();
			break;
		}
		if ( is_true( self.in_water ) )
		{
			wait_network_frame();
			if ( !is_true( self.leaving_level ) && !is_true( self.entering_level ) && !is_true( self.sprint2walk ) )
			{
				self thread director_scream_in_water();
			}
		}
	}
	self setclientflag( level._ZOMBIE_ACTOR_FLAG_DIRECTOR_DEATH );
	if ( is_true( self.is_sliding ) )
	{
		self.skip_stumble = true;
		self waittill( "zombie_end_traverse" );
	}
	self notify( "director_exit" );
	self.defeated = true;
	self notify( "disable_activation" );
	self notify( "disable_buff" );
	self notify( "stop_find_flesh" );
	self notify( "zombie_acquire_enemy" );
	self.ignoreall = true;
	if ( is_true( self.is_traversing ) )
	{
		self.skip_stumble = true;
		self waittill( "zombie_end_traverse" );
	}
	level notify( "director_submerging_audio" );
	if( IsDefined( level._audio_director_vox_play ) )
	{
		self thread [[ level._audio_director_vox_play ]]( "vox_director_die", .25, true );
	}
	if ( is_true( self.skip_stumble ) )
	{
		self.skip_stumble = undefined;
	}
	else
	{
		self animcustom( ::director_custom_stumble );
		self waittill_notify_or_timeout( "stumble_done", 7.2 );
	}
	if ( isdefined( level.director_should_drop_special_powerup ) && [[level.director_should_drop_special_powerup]]() )
	{
		level thread maps\_zombiemode_powerups::specific_powerup_drop( "tesla", self.origin );
	}
	else
	{
		level thread maps\_zombiemode_powerups::specific_powerup_drop( "minigun", self.origin );
	}
	forward = VectorNormalize( AnglesToForward( self.angles ) );
	end_pos = self.origin - vector_scale( forward, 32 );
	level thread maps\_zombiemode_powerups::specific_powerup_drop( "free_perk", end_pos );
	level notify( "quiet_on_the_set_achieved" );
	exit = self thread [[ level.director_find_exit ]]();
	self thread director_leave_map( exit, self.in_water );
}
director_custom_stumble()
{
	director_print( "custom stumble" );
	stumble_anim = %ai_zombie_boss_stumble_coast;
	self thread director_stumble_watcher( "stumble_anim" );
	self SetFlaggedAnimKnobAllRestart( "stumble_anim", stumble_anim, %body, 1, .1, 1 );
	animscripts\traverse\zombie_shared::wait_anim_length( stumble_anim, .02 );
	self notify( "stumble_done" );
}
director_stumble_watcher( animname )
{
	self endon( "death" );
	self waittillmatch( animname, "weapon_fx" );
	playfxontag( level._effect["director_death_weapon"], self, "tag_light" );
}
director_scream_in_water()
{
	self endon( "death" );
	if ( !isDefined( self.water_scream ) )
	{
		self.water_scream = true;
		if ( is_true( self.is_melee ) )
		{
			while ( 1 )
			{
				if ( !is_true( self.is_melee ) )
				{
					break;
				}
				wait_network_frame();
			}
		}
		if( IsDefined( level._audio_director_vox_play ) )
		{
			self thread [[ level._audio_director_vox_play ]]( "vox_director_pain_yell", .25, true );
		}
		scream_anim = %ai_zombie_boss_nuke_react_coast;
		self thread director_scream_delay();
		self thread director_zombie_sprint_watcher( "scream_anim" );
		self director_animscripted( scream_anim, "scream_anim" );
		wait( 3 );
		self.water_scream = undefined;
	}
}
director_scream_delay()
{
	wait( 2.6 );
	clientnotify( "ZDA" );
	self thread director_blur();
}
director_blur()
{
	self endon( "death" );
	players = getplayers();
	for ( i = 0; i < players.size; i++ )
	{
		player = players[i];
		player ShellShock( "electrocution", 1.7, true );
	}
}
director_zombie_think()
{
	self endon( "death" );
	self.pathEnemyFightDist = 96;
	self.meleeAttackDist = 96;
	self.maxhealth = level.director_zombie_max_health;
	self.health = level.director_zombie_max_health;
	self.maxsightdistsqrd = 96 * 96;
	self.is_activated = false;
	self.entering_level = true;
	self.zombie_move_speed = "walk";
	self director_zombie_choose_buff();
	self [[ level.director_zombie_enter_level ]]();
	level notify( "audio_begin_director_vox" );
	self thread director_watch_damage();
	self thread zombie_melee_watcher();
	self thread director_zombie_update_goal_radius();
	self thread director_kill_prone();
	self.ignoreall = false;
	if ( isDefined( level.director_zombie_custom_think ) )
	{
		self thread [[ level.director_zombie_custom_think ]]();
	}
	self thread director_zombie_check_for_buff();
	self thread director_zombie_choose_run();
	self thread director_zombie_health_manager();
	self SetClientFlag( level._ZOMBIE_ACTOR_FLAG_DIRECTORS_STEPS );
	self.entering_level = undefined;
	self BloodImpact( "hero" );
	self thread director_zombie_update();
}
director_zombie_update()
{
	self endon( "death" );
	self endon( "director_exit" );
	while( true )
	{
		if ( is_true( self.custom_think ) )
		{
			wait_network_frame();
			continue;
		}
		else if ( is_true( self.defeated ) )
		{
			wait( 5 );
			continue;
		}
		else if ( is_true( self.performing_activation ) )
		{
			wait_network_frame();
			continue;
		}
		else if ( is_true( self.ground_hit ) )
		{
			wait_network_frame();
			continue;
		}
		else if ( !is_true( self.following_player ) )
		{
			self thread maps\_zombiemode_spawner::find_flesh();
			self.following_player = true;
		}
		wait( 1 );
	}
}
director_add_weapon()
{
	self Attach( "t5_weapon_engineer_club", "tag_weapon_right" );
	self.light = Spawn( "script_model", self GetTagOrigin( "tag_light" ) );
	self.light PlayLoopSound("zmb_director_light_docile_loop", 2 );
	self.light.angles = self GetTagAngles( "tag_light" );
	self.light SetModel( "tag_origin" );
	self.light LinkTo( self, "tag_light" );
	wait_network_frame();
	wait_network_frame();
	self director_flip_light_flag();
}
director_zombie_choose_buff()
{
	if ( is_true( self.ground_hit ) || GetTime() < self.nextGroundHit || !self.is_activated )
	{
		self.buff = "speed";
	}
	else
	{
		rand = RandomInt( 100 );
		if ( rand < 50 )
		{
			self.buff = "electric";
		}
		else
		{
			self.buff = "speed";
		}
	}
}
director_zombie_default_pathfind_heuristic( node )
{
	if( !isDefined( node.targetname ) || !isDefined( level.zones[node.targetname] ) )
	{
		return -1;
	}
	players = get_players();
	score = 0;
	for( i = 0; i < players.size; i++ )
	{
		dist = distanceSquared( node.origin, players[i].origin );
		if( dist > 10000*10000 )
		{
			dist = 10000*10000;
		}
		if( dist <= 1 )
		{
			score += 10000*10000;
			continue;
		}
		score += int( 10000*10000/dist );
	}
	return score;
}
director_zombie_default_spawn_heuristic( spawner )
{
	if( isDefined( spawner.last_spawn_time ) && (GetTime() - spawner.last_spawn_time < 30000) )
	{
		return -1;
	}
	if( !isDefined( spawner.script_noteworthy ) )
	{
		return -1;
	}
	if( !isDefined( level.zones ) || !isDefined( level.zones[ spawner.script_noteworthy ] ) || !level.zones[ spawner.script_noteworthy ].is_enabled )
	{
		return -1;
	}
	score = 0;
	players = get_players();
	for( i = 0; i < players.size; i++ )
	{
		score = int( distanceSquared( spawner.origin, players[i].origin ) );
	}
	return score;
}
director_zombie_choose_run()
{
	self endon( "death" );
	while( true )
	{
		if ( isDefined( self.choose_run ) )
		{
			if ( self thread [[ self.choose_run ]]() )
			{
				wait_network_frame();
				continue;
			}
		}
		if ( is_true( self.walk2sprint ) )
		{
			transition_anim = level.scr_anim["director_zombie"]["walk2sprint"];
			self set_run_anim( "walk2sprint" );
			self.run_combatanim = transition_anim;
			self.crouchRunAnim = transition_anim;
			self.crouchrun_combatanim = transition_anim;
			self.needs_run_update = true;
			time = getAnimLength( transition_anim );
			wait( time );
			self.walk2sprint = undefined;
		}
		if ( is_true( self.sprint2walk ) )
		{
			self animcustom( ::director_sprint2walk );
			self waittill_notify_or_timeout( "transition_done", 1.74 );
			self.sprint2walk = undefined;
		}
		if( self.is_activated )
		{
			self.zombie_move_speed = "sprint";
			rand = randomIntRange( 1, 4 );
			self set_run_anim( "sprint"+rand );
			self.run_combatanim = level.scr_anim["director_zombie"]["sprint"+rand];
			self.crouchRunAnim = level.scr_anim["director_zombie"]["sprint"+rand];
			self.crouchrun_combatanim = level.scr_anim["director_zombie"]["sprint"+rand];
			self.needs_run_update = true;
			self director_wait_for_run_change();
		}
		else
		{
			walk_version = "walk1";
			self.zombie_move_speed = "walk";
			self set_run_anim( walk_version );
			self.run_combatanim = level.scr_anim["director_zombie"][walk_version];
			self.crouchRunAnim = level.scr_anim["director_zombie"][walk_version];
			self.crouchrun_combatanim = level.scr_anim["director_zombie"][walk_version];
			self.needs_run_update = true;
		}
		wait_network_frame();
	}
}
director_wait_for_run_change()
{
	self endon( "death" );
	self endon( "director_calmed" );
	self endon( "director_exit" );
	self endon( "director_run_change" );
	randf = randomFloatRange( 2, 3 );
	wait( randf );
}
director_zombie_health_manager()
{
	self endon( "death" );
	while ( 1 )
	{
		self waittill( "damage" );
		self.maxhealth = level.director_zombie_max_health;
		self.health = level.director_zombie_max_health;
		director_print( "health = " + self.health );
	}
}
director_zombie_update_goal_radius()
{
	self endon( "death" );
	self endon( "director_exit" );
	while ( 1 )
	{
		if ( is_true( self.leaving_level ) )
		{
			self.pathEnemyFightDist = 48;
			self.meleeAttackDist = 48;
			self.goalradius = 32;
			return;
		}
		if ( isDefined( self.enemy ) )
		{
			heightDiff = abs( self.enemy.origin[2] - self.origin[2] );
			in_zone = self maps\_zombiemode_zone_manager::entity_in_zone( "residence_roof_zone" );
			canMelee = animscripts\zombie_melee::CanMeleeDesperate();
			if ( heightDiff < 24 && !is_true( self.is_activated ) && !in_zone && canMelee )
			{
				self.pathEnemyFightDist = 96;
				self.meleeAttackDist = 96;
				self.goalradius = 90;
			}
			else
			{
				self.pathEnemyFightDist = 48;
				self.meleeAttackDist = 48;
				self.goalradius = 32;
			}
		}
		wait( .5 );
	}
}
director_kill_prone()
{
	self endon( "death" );
	_KILL_DIST = 144;
	_HEIGHT_DIST = 48;
	while ( 1 )
	{
		if ( isdefined( self.enemy ) )
		{
			if ( is_true( self.is_activated ) )
			{
				d = Distance2DSquared( self.enemy.origin, self.origin );
				h = self.enemy.origin[2] - self.origin[2];
				if ( d < _KILL_DIST && h < _HEIGHT_DIST )
				{
					self.enemy DoDamage( self.enemy.health * 10, self.enemy.origin, self );
				}
			}
		}
		wait( 0.5 );
	}
}
director_zombie_check_player_proximity()
{
	self endon( "death" );
	while ( 1 )
	{
		if ( isdefined( self.performing_activation ) && self.performing_activation )
		{
			break;
		}
		players = getplayers();
		for ( i = 0; i < players.size; i++ )
		{
			dist = DistanceSquared( self.origin, players[i].origin );
			if ( dist < level.director_zombie_proximity_wake )
			{
				self notify( "hit_player" );
				break;
			}
		}
		wait_network_frame();
	}
}
director_zombie_update_proximity_wake()
{
	while ( !isdefined( level.round_number ) )
	{
		wait( 1 );
	}
	while ( 1 )
	{
		if ( level.round_number >= 20 )
		{
			level.director_zombie_proximity_wake = 120;
			break;
		}
		else if ( level.round_number >= 15 )
		{
			level.director_zombie_proximity_wake = 102;
		}
		else if ( level.round_number >= 10 )
		{
			level.director_zombie_proximity_wake = 84;
		}
		wait( 1 );
	}
}
director_activation_damage()
{
	self endon( "death" );
	self endon( "disable_activation" );
	self endon( "hit_player" );
	self waittill( "activation_damage", attacker, weapon );
	if ( isDefined( attacker ) && IsPlayer( attacker ) )
	{
		attacker maps\_zombiemode_score::player_add_points( "damage" );
		attacker thread maps\_zombiemode_audio::create_and_play_dialog( "director", "anger" );
	}
	self notify( "director_aggro" );
}
director_activation_hit_player()
{
	self endon( "death" );
	self endon( "disable_activation" );
	self endon( "damage" );
	self waittill( "hit_player" );
	self notify( "director_aggro" );
}
director_zombie_check_for_activation()
{
	self endon( "death" );
	self endon( "disable_activation" );
	self.is_activated = false;
	self thread director_activation_damage();
	self thread director_activation_hit_player();
	self waittill( "director_aggro" );
	self notify( "director_spawn_zombies" );
	self.is_activated = true;
	if ( is_true( self.is_traversing ) )
	{
		self waittill( "zombie_end_traverse" );
	}
	self notify( "stop_find_flesh" );
	self.following_player = false;
	self.performing_activation = true;
	self.ground_hit = true;
	self thread scream_a_watcher( "aggro_anim" );
	self thread groundhit_watcher( "aggro_anim" );
	self thread director_zombie_sprint_watcher( "aggro_anim" );
	self thread director_zombified_watcher( "aggro_anim" );
	if( IsDefined( level._audio_director_vox_play ) )
	{
		self thread [[ level._audio_director_vox_play ]]( "vox_director_angered", .25, true );
	}
	self playsound("zmb_director_light_start");
	aggro_anim = %ai_zombie_boss_enrage_start_coast;
	if ( RandomInt( 100 ) < 50 )
	{
		aggro_anim = %ai_zombie_boss_enrage_start_a_coast;
	}
	if( IsDefined( level._audio_director_vox_play ) )
	{
		self thread [[ level._audio_director_vox_play ]]( "vox_director_slam", .25, true );
	}
	self director_animscripted( aggro_anim, "aggro_anim", true );
	self.performing_activation = false;
	self.ground_hit = false;
	self.delay_time = undefined;
	self notify( "director_activated" );
	if ( !is_true( self.is_traversing ) )
	{
		self director_transition( "sprint" );
	}
	self thread director_zombie_ground_hit_think();
}
director_zombified_watcher( animname )
{
	self endon( "death" );
	self waittillmatch( animname, "scream_a" );
	if ( !is_true( self.director_zombified ) )
	{
		self setmodel( "c_zom_george_romero_zombiefied_fb" );
		self.director_zombified = true;
	}
}
director_zombie_check_for_buff()
{
	self endon( "death" );
	self endon( "disable_buff" );
	wait( 5 );
	while ( 1 )
	{
		if ( is_true( self.performing_activation ) )
		{
			wait( 3 );
			continue;
		}
		if ( is_true( self.is_transition ) )
		{
			wait( 1 );
			continue;
		}
		if ( self.buff == "speed" )
		{
			if ( level.round_number < 6 )
			{
				self director_zombie_choose_buff();
				wait( 3 );
				continue;
			}
			num = director_zombie_get_num_speed_buff();
			if ( num >= level.director_max_speed_buff )
			{
				self director_zombie_choose_buff();
				wait( 3 );
				continue;
			}
		}
		{
			zombies_in_range = director_get_zombies_to_buff();
			if ( zombies_in_range.size )
			{
				self thread director_zombie_apply_buff( zombies_in_range );
				self.buff_cooldown = GetTime() + ( zombies_in_range.size * 5000 );
				self director_buff_cooldown();
			}
		}
		wait( 1 );
	}
}
director_buff_cooldown()
{
	self endon( "death" );
	while ( 1 )
	{
		t = GetTime();
		if ( t >= self.buff_cooldown )
		{
			break;
		}
		wait( 0.1 );
	}
}
director_get_zombies_to_buff()
{
	zombies_in_range = [];
	zombies = GetAiSpeciesArray( "axis", "all" );
	for ( i = 0; i < zombies.size; i++ )
	{
		if ( !self director_zombie_can_buff( zombies[i] ) )
		{
			continue;
		}
		zombies_in_range = add_to_array( zombies_in_range, zombies[i] );
	}
	return zombies_in_range;
}
director_zombie_enemy_is_far()
{
	self endon( "death" );
	far_enough = false;
	if ( isDefined( self.favoriteenemy ) )
	{
		height = Abs( self.origin[2] - self.favoriteenemy.origin[2] );
		if ( height > 72 )
		{
			far_enough = true;
		}
		dist_enemy = DistanceSquared( self.origin, self.favoriteenemy.origin );
		if ( dist_enemy > level.director_enemy_range )
		{
			far_enough = true;
		}
	}
	return far_enough;
}
director_zombie_can_buff( zombie )
{
	self endon( "death" );
	if ( is_true( zombie.ignoreme ) )
	{
		return false;
	}
	range = level.director_speed_buff_range_sq;
	if ( self.buff == "electric" )
	{
		range = level.director_electric_buff_range_sq;
		if ( is_true( zombie.electrified ) )
		{
			return false;
		}
	}
	else if ( self.buff == "speed" )
	{
		if ( is_true( zombie.ignore_speed_buff ) )
		{
			return false;
		}
		if ( is_true( zombie.speed_buff ) )
		{
			return false;
		}
		if ( is_true( zombie.in_water ) )
		{
			return false;
		}
	}
	height = Abs( self.origin[2] - zombie.origin[2] );
	if ( height > 72 )
	{
		return false;
	}
	dist = DistanceSquared( self.origin, zombie.origin );
	if ( dist > range )
	{
		return false;
	}
	forward = VectorNormalize( AnglesToForward( self.angles ) );
	zombie_dir = VectorNormalize( zombie.origin - self.origin );
	dot = VectorDot( forward, zombie_dir );
	if ( dot < 0.5 )
	{
		return false;
	}
	return true;
}
director_zombie_apply_buff( zombies )
{
	self endon( "death" );
	if ( self.buff == "electric" )
	{
		self director_zombie_electric_buff( zombies );
	}
	else if ( self.buff == "speed" )
	{
		enrage_anim = %ai_zombie_boss_enrage_start_scream_coast;
		self director_zombie_speed_buff( zombies, enrage_anim );
	}
	self director_zombie_choose_buff();
}
director_zombie_speed_buff( zombies, enrage_anim )
{
	self endon( "death" );
	director_print( "apply speed buff " + zombies.size );
	if( IsDefined( level._audio_director_vox_play ) )
	{
		self thread [[ level._audio_director_vox_play ]]( "vox_director_speed_buff", .25, true );
	}
	if ( IsDefined( enrage_anim ) )
	{
		self director_animscripted( enrage_anim, "enrage_anim" );
	}
	level.director_speed_buff = director_zombie_get_num_speed_buff();
	speed_count = level.director_max_speed_buff - level.director_speed_buff;
	director_print( "speed buff current = " + level.director_speed_buff + " adding " + speed_count );
	if ( speed_count > zombies.size )
	{
		speed_count = zombies.size;
	}
	for ( i = 0; i < speed_count; i++ )
	{
		if ( isDefined( zombies[i] ) )
		{
			zombies[i] thread zombie_speed_buff();
		}
	}
	players = getplayers();
	for(i=0;i<players.size;i++)
	{
		if( DistanceSquared( self.origin, players[i].origin ) <= 600 * 600 )
		{
			players[i] thread maps\_zombiemode_audio::create_and_play_dialog( "general", "react_sprinters" );
			break;
		}
	}
}
director_zombie_get_num_speed_buff()
{
	num = 0;
	zombies = GetAiSpeciesArray( "axis", "all" );
	for ( i = 0; i < zombies.size; i++ )
	{
		if ( is_true( zombies[i].speed_buff ) )
		{
			num++;
		}
	}
	return num;
}
zombie_speed_buff()
{
	self endon( "death" );
	self.speed_buff = true;
	fast_sprint = "sprint5";
	if ( RandomInt( 100 ) < 50 )
	{
		fast_sprint = "sprint6";
	}
	self.zombie_move_speed = "sprint";
	self set_run_anim( fast_sprint );
	self.run_combatanim = level.scr_anim[ self.animname ][ fast_sprint ];
	self.needs_run_update = true;
}
zombie_speed_debuff()
{
	self endon( "death" );
	self.speed_buff = false;
	switch( self.zombie_move_speed )
	{
		case "walk":
		var = randomintrange( 1, 9 );
		self set_run_anim( "walk" + var );
		self.run_combatanim = level.scr_anim[ self.animname ][ "walk" + var ];
		break;
		case "run":
		var = randomintrange( 1, 7 );
		self set_run_anim( "run" + var );
		self.run_combatanim = level.scr_anim[ self.animname ][ "run" + var ];
		break;
		case "sprint":
		var = randomintrange( 1, 5 );
		self set_run_anim( "sprint" + var );
		self.run_combatanim = level.scr_anim[ self.animname ][ "sprint" + var ];
		break;
	}
	self.needs_run_update = true;
}
groundhit_fx_watcher( animname )
{
	self endon( "death" );
	self waittillmatch( animname, "wrench_hit" );
	playfxontag( level._effect["director_groundhit"], self, "tag_origin" );
}
director_zombie_electric_buff( zombies )
{
	self endon( "death" );
	director_print( "apply electric buff " + zombies.size );
	if( IsDefined( level._audio_director_vox_play ) )
	{
		self thread [[ level._audio_director_vox_play ]]( "vox_director_slam", .25, true );
	}
	if ( is_true( self.is_activated ) )
	{
		self animcustom( ::director_zombie_ground_hit );
		self waittill( "ground_hit_done" );
		return;
	}
	hit_anim = %ai_zombie_boss_enrage_start_slamground_coast;
	self thread groundhit_fx_watcher( "hit_anim" );
	self director_animscripted( hit_anim, "hit_anim" );
	if( IsDefined( level._audio_director_vox_play ) )
	{
		self thread [[ level._audio_director_vox_play ]]( "vox_director_electric_buff", .25, true );
	}
	for ( i = 0; i < zombies.size; i++ )
	{
		if ( isDefined( zombies[i] ) )
		{
			zombies[i] thread zombie_set_electric_buff();
		}
	}
	players = getplayers();
	for(i=0;i<players.size;i++)
	{
		if( DistanceSquared( self.origin, players[i].origin ) <= 600 * 600 )
		{
			players[i] thread maps\_zombiemode_audio::create_and_play_dialog( "general", "react_sparkers" );
			break;
		}
	}
}
director_sprint2walk()
{
	self endon( "death" );
	transition_anim = level.scr_anim["director_zombie"]["sprint2walk"];
	self thread director_sprint2walk_watcher( "transition_anim" );
	time = getAnimLength( transition_anim );
	self SetFlaggedAnimKnobAllRestart( "transition_anim", transition_anim, %body, 1, .1, 1 );
	wait( time );
	self notify( "transition_done" );
}
director_sprint2walk_watcher( animname )
{
	self endon( "death" );
	self waittillmatch( animname, "swap_fx" );
	Playfx( level._effect["director_water_burst_sm"], self.origin );
	self setmodel( "c_zom_george_romero_light_fb" );
	self.director_zombified = undefined;
}
director_zombie_ground_hit()
{
	self endon( "death" );
	if ( self.ground_hit )
	{
		return;
	}
	self.ground_hit = true;
	self thread groundhit_watcher( "groundhit_anim" );
	groundhit_anim = %ai_zombie_boss_run_hitground_coast;
	self SetFlaggedAnimKnobAllRestart( "groundhit_anim", groundhit_anim, %body, 1, .1, 1 );
	animscripts\traverse\zombie_shared::wait_anim_length( groundhit_anim, .02 );
	self.ground_hit = false;
	self.nextGroundHit = GetTime() + level.director_ground_attack_delay;
	self notify( "ground_hit_done" );
}
director_zombie_update_next_groundhit()
{
	self.nextGroundHit = GetTime() + level.director_ground_attack_delay;
}
director_zombie_ground_hit_think()
{
	self endon( "death" );
	self endon( "director_calmed" );
	self endon( "director_exit" );
	self.ground_hit = false;
	self.nextGroundHit = GetTime() + level.director_ground_attack_delay;
	while( 1 )
	{
		if ( is_true( self.is_traversing ) )
		{
			self waittill( "zombie_end_traverse" );
			continue;
		}
		if ( is_true( self.is_fling ) )
		{
			wait( 2 );
			continue;
		}
		if ( !self.ground_hit && GetTime() >= self.nextGroundHit )
		{
			players = GetPlayers();
			closeEnough = false;
			origin = self GetEye();
			for ( i = 0; i < players.size; i++ )
			{
				if ( players[i] maps\_laststand::player_is_in_laststand() )
				{
					continue;
				}
				if ( is_true( players[i].divetoprone ) )
				{
					continue;
				}
				stance = players[i] GetStance();
				if ( stance == "prone" )
				{
					continue;
				}
				test_origin = players[i] GetEye();
				d = DistanceSquared( origin, test_origin );
				if ( d > level.director_zombie_groundhit_radius * level.director_zombie_groundhit_radius )
				{
					continue;
				}
				if ( !BulletTracePassed( origin, test_origin, false, undefined ) )
				{
					continue;
				}
				closeEnough = true;
				break;
			}
			if ( closeEnough )
			{
				if( IsDefined( level._audio_director_vox_play ) )
				{
					self thread [[ level._audio_director_vox_play ]]( "vox_director_slam", .25, true );
				}
				self animcustom( ::director_zombie_ground_hit );
			}
		}
		wait_network_frame();
	}
}
scream_a_watcher( animname )
{
	self endon( "death" );
	self waittillmatch( animname, "scream_a" );
	clientnotify( "ZDA" );
	self thread director_blur();
}
director_zombie_sprint_watcher( animname )
{
	self endon( "death" );
	self waittillmatch( animname, "scream_a" );
	origin = self GetEye();
	zombies = get_array_of_closest( origin, GetAiSpeciesArray( "axis", "all" ), undefined, undefined, level.director_speed_buff_range );
	if ( IsDefined( zombies ) )
	{
		zombies_in_range = [];
		for ( i = 0; i < zombies.size; i++ )
		{
			if ( !IsDefined( zombies[i] ) )
			{
				continue;
			}
			if ( is_true( zombies[i].ignore_speed_buff ) )
			{
				continue;
			}
			if ( is_true( zombies[i].speed_buff ) )
			{
				continue;
			}
			if ( is_true( zombies[i].in_water ) )
			{
				continue;
			}
			height = Abs( self.origin[2] - zombies[i].origin[2] );
			if ( height > 72 )
			{
				continue;
			}
			if ( zombies[i] == self )
			{
				continue;
			}
			forward = VectorNormalize( AnglesToForward( self.angles ) );
			zombie_dir = VectorNormalize( zombies[i].origin - self.origin );
			dot = VectorDot( forward, zombie_dir );
			if ( dot < 0.5 )
			{
				continue;
			}
			zombies_in_range = add_to_array( zombies_in_range, zombies[i] );
		}
		if ( zombies_in_range.size > 0 )
		{
			self director_zombie_speed_buff( zombies_in_range );
		}
	}
}
groundhit_watcher( animname )
{
	self endon( "death" );
	self waittillmatch( animname, "wrench_hit" );
	playfxontag(level._effect["director_groundhit"],self,"tag_origin");
	origin = self GetEye();
	zombies = get_array_of_closest( origin, GetAiSpeciesArray( "axis", "all" ), undefined, undefined, level.director_electric_buff_range );
	electrified = 0;
	if ( IsDefined( zombies ) )
	{
		for ( i = 0; i < zombies.size; i++ )
		{
			if ( !IsDefined( zombies[i] ) )
			{
				continue;
			}
			if ( is_true( zombies[i].electrified ) )
			{
				continue;
			}
			test_origin = zombies[i] GetEye();
			if ( !BulletTracePassed( origin, test_origin, false, undefined ) )
			{
				continue;
			}
			if ( zombies[i] == self )
			{
				continue;
			}
			zombies[i] zombie_set_electric_buff();
			electrified++;
		}
	}
	director_print( "apply electric buff " + electrified );
	players = get_players();
	affected_players = [];
	for( i = 0; i < players.size; i++ )
	{
		test_origin = players[i] GetEye();
		d = DistanceSquared( origin, test_origin );
		if( d > level.director_electrify_range_sq )
		{
			continue;
		}
		heightDiff = abs( origin[2] - test_origin[2] );
		if ( heightDiff > 96 )
		{
			continue;
		}
		if ( !BulletTracePassed( origin, test_origin, false, undefined ) )
		{
			continue;
		}
		affected_players = array_add( affected_players, players[i] );
	}
	for( i = 0; i < affected_players.size; i++ )
	{
		if ( affected_players[i] IsOnGround() )
		{
			affected_players[i] player_electrify();
		}
	}
}
scream_b_watcher( animname )
{
	self endon( "death" );
	rand = RandomInt( 100 );
	if( rand > level.director_zombie_scream_b_chance )
	{
		return;
	}
	self waittillmatch( animname, "scream_b" );
	players = get_players();
	affected_players = [];
	for( i = 0; i < players.size; i++ )
	{
		if( distanceSquared( players[i].origin, self.origin ) < level.director_zombie_scream_b_radius_sq )
		{
			affected_players = array_add( affected_players, players[i] );
		}
	}
	for( i = 0; i < affected_players.size; i++ )
	{
		affected_players[i] ShellShock( "electrocution", 1.5, true );
	}
}
director_zombie_die()
{
	return true;
}
director_custom_damage( player )
{
	self endon( "death" );
	if ( isDefined( self.ground_hit ) && self.ground_hit )
	{
		return level.director_zombie_groundhit_damage;
	}
	return self.meleeDamage;
}
director_nuke_damage()
{
	self endon( "death" );
	if ( is_true( self.is_traversing ) )
	{
		return;
	}
	if ( is_true( self.leaving_level ) )
	{
		return;
	}
	if ( !isDefined( self.nuke_react ) )
	{
		self.nuke_react = true;
		nuke_anim = %ai_zombie_boss_nuke_react_coast;
		self director_animscripted( nuke_anim, "nuke_anim" );
		self.nuke_react = undefined;
	}
}
director_tesla_damage( origin, player )
{
	self.zombie_tesla_hit = false;
	if ( is_true( self.leaving_level ) )
	{
		return;
	}
	if ( !is_true( self.is_activated ) )
	{
		self notify( "activation_damage", player, "tesla_gun_zm" );
	}
}
director_full_damage( inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, sHitLoc, modelIndex, psOffsetTime )
{
	self endon( "death" );
	self notify( "activation_damage", attacker, weapon );
	if ( sHitLoc == "head" || sHitLoc == "helmet" || sHitLoc == "neck" )
	{
		return damage;
	}
	switch ( weapon )
	{
		case "aug_acog_mk_upgraded_zm":
		case "commando_upgraded_zm":
		damage *= 4.75;
		break;
		case "galil_upgraded_zm":
		case "fnfal_upgraded_zm":
		damage *= 3.5;
		break;
		case "famas_upgraded_zm":
		damage *= 9.25;
		break;
		case "zombie_nesting_doll_single":
		damage /= 20;
		break;
	}
	return damage;
}
director_zombie_default_enter_level()
{
	Playfx( level._effect["director_spawn"], self.origin );
	playsoundatposition( "zmb_bolt", self.origin );
	PlayRumbleOnPosition("explosion_generic", self.origin);
}
setup_player_damage_watchers()
{
	flag_wait( "all_players_connected" );
	players = getplayers();
	for ( i = 0; i < players.size; i++ )
	{
		players[i].player_damage_override = ::player_damage_watcher;
	}
}
player_damage_watcher( eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, modelIndex, psOffsetTime )
{
	if ( IsPlayer( eAttacker ) )
	{
		return;
	}
	if ( is_true( eAttacker.electrified ) )
	{
		self player_electrify();
	}
}
player_electrify()
{
	self endon( "death" );
	self endon( "disconnect" );
	SHOCK_TIME = 0.25;
	if ( !IsDefined( self.electrified ) )
	{
		self.electrified = true;
		self setelectrified( SHOCK_TIME );
		self ShellShock( "electrocution", 0.5, true );
		self PlaySound("zmb_director_damage_zort");
		self setclientflag( level._CF_PLAYER_ELECTRIFIED );
		wait( SHOCK_TIME );
		self clearclientflag( level._CF_PLAYER_ELECTRIFIED );
		self.electrified = undefined;
	}
}
zombie_set_electric_buff()
{
	self.electrified = true;
	self setclientflag( level._ZOMBIE_ACTOR_FLAG_ELECTRIFIED );
	self playloopsound("zmb_electric_zombie_loop");
	self thread zombie_melee_watcher(true);
	self.actor_killed_override = ::zombie_clear_electric_buff;
}
zombie_melee_watcher(is_zombie)
{
	self endon( "death" );
	if(is_true(is_zombie))
	{
		self endon("stop_melee_watch");
	}
	while ( 1 )
	{
		self waittill( "damage", amount, attacker, direction, point, method );
		if ( IsPlayer( attacker ) )
		{
			if ( method == "MOD_MELEE" )
			{
				attacker player_electrify();
				attacker thread maps\_zombiemode_audio::create_and_play_dialog( "general", "damage_shocked" );
			}
		}
	}
}
zombie_clear_electric_buff( eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime )
{
	self clearclientflag( level._ZOMBIE_ACTOR_FLAG_ELECTRIFIED );
	self StopLoopSound(3);
	if ( IsDefined( sMeansOfDeath ) && IsDefined( attacker ) && IsPlayer( attacker ))
	{
		if ( sMeansOfDeath == "MOD_MELEE" )
		{
			attacker player_electrify();
		}
	}
	if ( IsDefined( sMeansOfDeath ) )
	{
		if ( is_true( level.director_max_ammo_available ) && !is_true( self.ignoreme ) )
		{
			self zombie_drop_max_ammo();
		}
	}
	self.electrified = undefined;
}
zombie_drop_max_ammo()
{
	chance = RandomInt( 100 );
	director_print( "chance " + chance + " < " + level.director_max_ammo_chance );
	if ( chance < level.director_max_ammo_chance )
	{
		level.director_max_ammo_available = false;
		level.director_max_ammo_chance = level.director_max_ammo_chance_default;
		level thread maps\_zombiemode_powerups::specific_powerup_drop( "full_ammo", self.origin );
		level notify( "director_max_ammo_drop" );
	}
	else
	{
		level.director_max_ammo_chance += level.director_max_ammo_chance_inc;
	}
}
director_max_ammo_watcher()
{
	level.director_max_ammo_available = false;
	level.director_max_ammo_chance = level.director_max_ammo_chance_default;
	flag_wait( "power_on" );
	level.director_max_ammo_round = level.round_number + randomintrange( 1, 4 );
	director_print( "next max ammo round " + level.director_max_ammo_round );
	while ( 1 )
	{
		level waittill( "between_round_over" );
		if ( level.round_number >= level.director_max_ammo_round )
		{
			level.director_max_ammo_available = true;
			level waittill( "director_max_ammo_drop" );
			level.director_max_ammo_round = level.round_number + randomintrange( 4, 6 );
			director_print( "next max ammo round " + level.director_max_ammo_round );
		}
	}
}
director_instakill()
{
}
director_humangun_hit_response( upgraded )
{
	if ( is_true( self.defeated ) || is_true( self.leaving_level ) || is_true( self.entering_level ) )
	{
		return;
	}
	if ( upgraded )
	{
		if ( !is_true( self.impact_humangun_upgraded ) )
		{
			self.impact_humangun_upgraded = true;
			self setclientflag( level._ZOMBIE_ACTOR_FLAG_HUMANGUN_UPGRADED_HIT_RESPONSE );
		}
		else
		{
			self.impact_humangun_upgraded = undefined;
			self clearclientflag( level._ZOMBIE_ACTOR_FLAG_HUMANGUN_UPGRADED_HIT_RESPONSE );
		}
		if ( isDefined( self.water_trigger ) && isDefined( self.water_trigger.target ) )
		{
			self notify( "disable_activation" );
			self notify( "disable_buff" );
			self notify( "stop_find_flesh" );
			self notify( "zombie_acquire_enemy" );
			self notify( "humangun_leave" );
			self.ignoreall = true;
			self setclientflag( level._ZOMBIE_ACTOR_FLAG_DIRECTOR_DEATH );
			exit = getstruct( self.water_trigger.target, "targetname" );
			self thread director_leave_map( exit, true );
		}
		else
		{
			self director_humangun_react();
			self director_calmed( undefined, true );
		}
	}
	else
	{
		if ( !is_true( self.impact_humangun ) )
		{
			self.impact_humangun = true;
			self setclientflag( level._ZOMBIE_ACTOR_FLAG_HUMANGUN_HIT_RESPONSE );
		}
		else
		{
			self.impact_humangun = undefined;
			self clearclientflag( level._ZOMBIE_ACTOR_FLAG_HUMANGUN_HIT_RESPONSE );
		}
		if ( is_true( self.in_water ) )
		{
			return;
		}
		self director_humangun_react();
		self director_calmed( 10, true );
	}
}
director_humangun_react()
{
	if ( is_true( self.is_activated ) )
	{
		self notify( "disable_activation" );
		self.finish_anim = undefined;
	}
	self animcustom( ::director_custom_idle );
	self thread director_delay_melee( 0.6 );
}
director_delay_melee( time )
{
	self endon( "death" );
	self.cant_melee = true;
	wait( time );
	self.cant_melee = false;
}
director_custom_idle()
{
	self endon( "death" );
	idle_anim = %ai_zombie_boss_idle_b_coast;
	self SetFlaggedAnimKnobAllRestart( "idle_anim", idle_anim, %body, 1, .1, 1 );
	wait( 0.5 );
}
director_leave_map( exit, calm )
{
	self endon( "death" );
	self.leaving_level = true;
	self [[ level.director_exit_level ]]( exit, calm );
	self.leaving_level = undefined;
	if ( !is_true( self.defeated ) )
	{
		self thread director_reset_light_flag();
	}
	self thread director_reenter_map();
}
director_reenter_map()
{
	r = RandomInt( 100 );
	devgui_timeaway = 0;
	if ( devgui_timeaway > 0 )
	{
		director_print( "devgui leave for " + devgui_timeaway );
		wait( devgui_timeaway );
	}
	else if ( is_true( self.defeated ) || r > 50 )
	{
		director_print( "leaving for the round" );
		level waittill( "between_round_over" );
		wait( 1 );
		level waittill( "between_round_over" );
	}
	else
	{
		s = RandomIntRange( 60, 300 );
		director_print( "leaving for " + s + " seconds" );
		wait( s );
	}
	self.entering_level = true;
	self [[ level.director_reenter_level ]]();
	self.performing_activation = false;
	self.ground_hit = false;
	self.following_player = false;
	self.defeated = undefined;
	level notify( "audio_begin_director_vox" );
	self thread director_zombie_check_for_buff();
	self thread director_watch_damage();
	self thread director_zombie_update_goal_radius();
	self thread director_zombie_update();
	self.entering_level = undefined;
}
director_reenter_level()
{
}
director_exit_level()
{
}
director_find_exit()
{
}
director_transition( type )
{
	self endon( "death" );
	if ( !is_true( self.is_traversing ) )
	{
		if ( type == "walk" )
		{
			self.sprint2walk = true;
			director_print( "sprint2walk" );
		}
		else if ( type == "sprint" )
		{
			self.walk2sprint = true;
			director_print( "walk2sprint" );
		}
		self notify( "director_run_change" );
	}
}
director_calmed( delay, humangun )
{
	if ( is_true( self.is_activated ) )
	{
		director_print( "director_calmed" );
		self.is_activated = false;
		self notify( "director_calmed" );
		if ( !is_true( self.in_water ) )
		{
			self thread director_zombie_check_for_activation();
		}
		if ( !is_true( humangun ) && !is_true( self.is_traversing ) && !is_true( self.ignore_transition ) )
		{
			self director_transition( "walk" );
		}
		else
		{
			self setmodel( "c_zom_george_romero_light_fb" );
			self.director_zombified = undefined;
		}
	}
	if ( isDefined( delay ) )
	{
		if ( isDefined( self.delay_time ) )
		{
			self.delay_time += delay * 1000;
		}
		else
		{
			self.delay_time = GetTime() + delay * 1000;
			self thread director_delayed_activation();
		}
	}
}
director_delayed_activation()
{
	self endon( "death" );
	self endon( "disable_activation" );
	while ( 1 )
	{
		if ( !isDefined( self.delay_time ) )
		{
			return;
		}
		if ( GetTime() >= self.delay_time )
		{
			if ( !self.is_activated )
			{
				self notify( "hit_player" );
			}
			self.delay_time = undefined;
			return;
		}
		wait_network_frame();
	}
}
director_melee_anim( attack_anim )
{
	self endon( "death" );
	if ( !isDefined( self.is_melee ) )
	{
		self.is_melee = true;
		time = getAnimLength( attack_anim );
		wait( time );
		self.is_melee = undefined;
	}
}
director_set_animarray_standing()
{
	self.a.array["exposed_idle"]	= array( %ai_zombie_boss_idle_a_coast, %ai_zombie_boss_idle_b_coast );
	self.a.array["straight_level"]	= %ai_zombie_boss_idle_a_coast;
	self.a.array["stand_2_crouch"]	= %ai_zombie_boss_idle_a_coast;
}
director_melee_miss()
{
	self endon( "death" );
	if ( isDefined( self.enemy ) )
	{
		d = Distance( self.origin, self.enemy.origin );
		heightDiff = abs( self.enemy.origin[2] - self.origin[2] );
		if ( d <= self.meleeAttackDist && heightDiff < 96 )
		{
			if ( is_true( self.enemy.is_frozen ) )
			{
				if ( isDefined( self.enemy.ice_trigger ) )
				{
					self.enemy.ice_trigger notify( "damage" );
				}
			}
			else
			{
				self.enemy DoDamage( self.meleeDamage, self.origin, self, 0, "MOD_MELEE" );
			}
		}
	}
}
director_fling( pos )
{
	self endon( "death" );
	self.is_fling = true;
	self animcustom( ::director_custom_fling );
	self.is_fling = undefined;
}
director_custom_fling()
{
	self endon( "death" );
	fling_anim = %ai_zombie_boss_flinger_flail_coast;
	self SetFlaggedAnimKnobAllRestart( "fling_anim", fling_anim, %body, 1, .1, 1 );
	animscripts\traverse\zombie_shared::wait_anim_length( fling_anim, .02 );
}
director_non_attacker( damage, weapon )
{
	if ( is_true( self.leaving_level ) )
	{
		return damage;
	}
	if ( !is_true( self.is_activated ) )
	{
		self notify( "activation_damage", undefined, weapon );
	}
	return damage;
}
director_animscripted( director_anim, director_notify, finish_anim )
{
	if ( !is_true( self.finish_anim ) )
	{
		if ( is_true( finish_anim ) )
		{
			self.finish_anim = true;
		}
		self.is_animscripted = true;
		time = getAnimLength( director_anim );
		self animscripted( director_notify, self.origin, self.angles, director_anim, "normal", %body, 1, 0.1 );
		wait( time );
		self.is_animscripted = undefined;
		self.finish_anim = undefined;
	}
	else
	{
		director_print( "animscripted never played" );
	}
}
director_print( str )
{
} 