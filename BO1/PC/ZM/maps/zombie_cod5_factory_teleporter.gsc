#include common_scripts\utility;
#include maps\_utility;
#include maps\_zombiemode_utility;
teleporter_init()
{
	PreCacheModel("collision_wall_128x128x10");
	level.dog_melee_range = 130;
	level thread dog_blocker_clip();
	level.teleport = [];
	level.active_links = 0;
	level.countdown = 0;
	level.teleport_delay = 2;
	level.teleport_cost = 1500;
	level.teleport_cooldown = 5;
	level.is_cooldown = false;
	level.active_timer = -1;
	level.teleport_time = 0;
	flag_init( "teleporter_pad_link_1" );
	flag_init( "teleporter_pad_link_2" );
	flag_init( "teleporter_pad_link_3" );
	wait_for_all_players();
	for ( i=0; i<3; i++ )
	{
		trig = GetEnt( "trigger_teleport_pad_" + i, "targetname");
		if ( IsDefined(trig) )
		{
			level.teleporter_pad_trig[i] = trig;
		}
	}
	thread teleport_pad_think( 0 );
	thread teleport_pad_think( 1 );
	thread teleport_pad_think( 2 );
	thread teleport_core_think();
	thread start_black_room_fx();
	thread init_pack_door();
	SetDvar( "factoryAftereffectOverride", "-1" );
	SetSavedDvar( "zombiemode_path_minz_bias", 13 );
	level.no_dog_clip = true;
	packapunch_see = getent( "packapunch_see", "targetname" );
	if(isdefined( packapunch_see ) )
	{
		packapunch_see thread play_packa_see_vox();
	}
	level.teleport_ae_funcs = [];
	if( !IsSplitscreen() )
	{
		level.teleport_ae_funcs[level.teleport_ae_funcs.size] = maps\zombie_cod5_factory_teleporter::teleport_aftereffect_fov;
	}
	level.teleport_ae_funcs[level.teleport_ae_funcs.size] = maps\zombie_cod5_factory_teleporter::teleport_aftereffect_shellshock;
	level.teleport_ae_funcs[level.teleport_ae_funcs.size] = maps\zombie_cod5_factory_teleporter::teleport_aftereffect_shellshock_electric;
	level.teleport_ae_funcs[level.teleport_ae_funcs.size] = maps\zombie_cod5_factory_teleporter::teleport_aftereffect_bw_vision;
	level.teleport_ae_funcs[level.teleport_ae_funcs.size] = maps\zombie_cod5_factory_teleporter::teleport_aftereffect_red_vision;
	level.teleport_ae_funcs[level.teleport_ae_funcs.size] = maps\zombie_cod5_factory_teleporter::teleport_aftereffect_flashy_vision;
	level.teleport_ae_funcs[level.teleport_ae_funcs.size] = maps\zombie_cod5_factory_teleporter::teleport_aftereffect_flare_vision;
}
init_pack_door()
{
	collision = spawn("script_model", (-56, 467, 157));
	collision setmodel("collision_wall_128x128x10");
	collision.angles = (0, 0, 0);
	collision Hide();
	door = getent( "pack_door", "targetname" );
	door movez( -50, 0.05, 0 );
	wait(1.0);
	flag_wait( "all_players_connected" );
	door movez( 50, 1.5, 0 );
	door playsound( "packa_door_1" );
	wait(2);
	collision Delete();
	flag_wait( "teleporter_pad_link_1" );
	door movez( -35, 1.5, 1 );
	door playsound( "packa_door_2" );
	door thread packa_door_reminder();
	wait(2);
	flag_wait( "teleporter_pad_link_2" );
	door movez( -25, 1.5, 1 );
	door playsound( "packa_door_2" );
	wait(2);
	flag_wait( "teleporter_pad_link_3" );
	door movez( -60, 1.5, 1 );
	door playsound( "packa_door_2" );
	clip = getentarray( "pack_door_clip", "targetname" );
	for ( i = 0; i < clip.size; i++ )
	{
		clip[i] connectpaths();
		clip[i] delete();
	}
}
pad_manager()
{
	for ( i = 0; i < level.teleporter_pad_trig.size; i++ )
	{
		level.teleporter_pad_trig[i] sethintstring( &"WAW_ZOMBIE_TELEPORT_COOLDOWN" );
		level.teleporter_pad_trig[i] teleport_trigger_invisible( false );
	}
	level.is_cooldown = true;
	wait( level.teleport_cooldown );
	level.is_cooldown = false;
	for ( i = 0; i < level.teleporter_pad_trig.size; i++ )
	{
		if ( level.teleporter_pad_trig[i].teleport_active )
		{
			level.teleporter_pad_trig[i] sethintstring( &"WAW_ZOMBIE_TELEPORT_TO_CORE" );
		}
		else
		{
			level.teleporter_pad_trig[i] sethintstring( &"WAW_ZOMBIE_LINK_TPAD" );
		}
	}
}
start_black_room_fx()
{
	for ( i = 901; i <= 904; i++ )
	{
		wait( 1 );
		exploder( i );
	}
}
teleport_pad_think( index )
{
	tele_help = getent( "tele_help_" + index, "targetname" );
	if(isdefined( tele_help ) )
	{
		tele_help thread play_tele_help_vox();
	}
	active = false;
	level.teleport[index] = "waiting";
	trigger = level.teleporter_pad_trig[ index ];
	trigger setcursorhint( "HINT_NOICON" );
	trigger sethintstring( &"WAW_ZOMBIE_FLAMES_UNAVAILABLE" );
	flag_wait( "power_on" );
	trigger sethintstring( &"WAW_ZOMBIE_POWER_UP_TPAD" );
	trigger.teleport_active = false;
	if ( isdefined( trigger ) )
	{
		while ( !active )
		{
			trigger waittill( "trigger" );
			if ( level.active_links < 3 )
			{
				trigger_core = getent( "trigger_teleport_core", "targetname" );
				trigger_core teleport_trigger_invisible( false );
			}
			for ( i=0; i<level.teleporter_pad_trig.size; i++ )
			{
				level.teleporter_pad_trig[ i ] teleport_trigger_invisible( true );
			}
			level.teleport[index] = "timer_on";
			trigger thread teleport_pad_countdown( index, 30 );
			teleporter_vo( "countdown", trigger );
			while ( level.teleport[index] == "timer_on" )
			{
				wait( .05 );
			}
			if ( level.teleport[index] == "active" )
			{
				active = true;
				ClientNotify( "pw" + index );
				ClientNotify( "tp" + index );
				teleporter_wire_wait( index );
				trigger thread player_teleporting( index );
			}
			else
			{
				for ( i=0; i<level.teleporter_pad_trig.size; i++ )
				{
					level.teleporter_pad_trig[ i ] teleport_trigger_invisible( false );
				}
			}
			wait( .05 );
		}
		if ( level.is_cooldown )
		{
			trigger sethintstring( &"WAW_ZOMBIE_TELEPORT_COOLDOWN" );
			trigger teleport_trigger_invisible( false );
			trigger.teleport_active = true;
		}
		else
		{
			trigger thread teleport_pad_active_think( index );
		}
	}
}
teleport_pad_countdown( index, time )
{
	self endon( "stop_countdown" );
	if ( level.active_timer < 0 )
	{
		level.active_timer = index;
	}
	level.countdown++;
	ClientNotify( "pac" + index );
	ClientNotify( "TRf" );
	players = get_players();
	for( i = 0; i < players.size; i++ )
	{
		players[i] thread maps\_zombiemode_timer::start_timer( time+1, "stop_countdown" );
	}
	wait( time+1 );
	if ( level.active_timer == index )
	{
		level.active_timer = -1;
	}
	level.teleport[index] = "timer_off";
	ClientNotify( "TRs" );
	level.countdown--;
}
teleport_pad_active_think( index )
{
	self setcursorhint( "HINT_NOICON" );
	self.teleport_active = true;
	user = undefined;
	while ( 1 )
	{
		self waittill( "trigger", user );
		if ( is_player_valid( user ) && user.score >= level.teleport_cost && !level.is_cooldown )
		{
			for ( i = 0; i < level.teleporter_pad_trig.size; i++ )
			{
				level.teleporter_pad_trig[i] teleport_trigger_invisible( true );
			}
			user maps\_zombiemode_score::minus_to_player_score( level.teleport_cost );
			self player_teleporting( index );
		}
	}
}
player_teleporting( index )
{
	time_since_last_teleport = GetTime() - level.teleport_time;
	teleport_pad_start_exploder( index );
	exploder( 105 );
	ClientNotify( "tpw" + index );
	self thread teleport_pad_player_fx( level.teleport_delay );
	self thread teleport_2d_audio();
	self thread teleport_nuke( 20, 300);
	wait( level.teleport_delay );
	self notify( "fx_done" );
	teleport_pad_end_exploder( index );
	self teleport_players();
	ClientNotify( "tpc" + index );
	if ( level.is_cooldown == false )
	{
		thread pad_manager();
	}
	wait( 2.0 );
	ss = getstruct( "teleporter_powerup", "targetname" );
	if ( IsDefined( ss ) )
	{
		ss thread maps\_zombiemode_powerups::special_powerup_drop(ss.origin);
	}
	if ( time_since_last_teleport < 60000 && level.active_links == 3 && level.round_number > 20 )
	{
		dog_spawners = GetEntArray( "special_dog_spawner", "targetname" );
		maps\_zombiemode_ai_dogs::special_dog_spawn( undefined, 4 );
		thread play_sound_2d( "sam_nospawn" );
	}
	level.teleport_time = GetTime();
}
teleport_pad_start_exploder( index )
{
	switch ( index )
	{
		case 0:
		exploder( 202 );
		break;
		case 1:
		exploder( 302 );
		break;
		case 2:
		exploder( 402 );
		break;
	}
}
teleport_pad_end_exploder( index )
{
	switch ( index )
	{
		case 0:
		exploder( 201 );
		break;
		case 1:
		exploder( 301 );
		break;
		case 2:
		exploder( 401 );
		break;
	}
}
teleport_trigger_invisible( enable )
{
	players = getplayers();
	for ( i = 0; i < players.size; i++ )
	{
		if ( isdefined( players[i] ) )
		{
			self SetInvisibleToPlayer( players[i], enable );
		}
	}
}
player_is_near_pad( player )
{
	radius = 88;
	scale_factor = 2;
	dist = Distance2D( player.origin, self.origin );
	dist_touching = radius * scale_factor;
	if ( dist < dist_touching )
	{
		return true;
	}
	return false;
}
teleport_pad_player_fx( delay )
{
	self endon( "fx_done" );
	while ( 1 )
	{
		players = getplayers();
		for ( i = 0; i < players.size; i++ )
		{
			if ( isdefined( players[i] ) )
			{
				if ( self player_is_near_pad( players[i] ) )
				{
					players[i] SetTransported( delay );
				}
				else
				{
					players[i] SetTransported( 0 );
				}
			}
		}
		wait ( .05 );
	}
}
teleport_players()
{
	player_radius = 16;
	players = getplayers();
	core_pos = [];
	occupied = [];
	image_room = [];
	players_touching = [];
	player_idx = 0;
	prone_offset = (0, 0, 49);
	crouch_offset = (0, 0, 20);
	stand_offset = (0, 0, 0);
	for ( i = 0; i < 4; i++ )
	{
		core_pos[i] = getent( "origin_teleport_player_" + i, "targetname" );
		occupied[i] = false;
		image_room[i] = getent( "teleport_room_" + i, "targetname" );
		if ( isdefined( players[i] ) )
		{
			players[i] settransported( 0 );
			if ( self player_is_near_pad( players[i] ) )
			{
				players_touching[player_idx] = i;
				player_idx++;
				if ( isdefined( image_room[i] ) )
				{
					players[i] disableOffhandWeapons();
					players[i] disableweapons();
					if( players[i] getstance() == "prone" )
					{
						desired_origin = image_room[i].origin + prone_offset;
					}
					else if( players[i] getstance() == "crouch" )
					{
						desired_origin = image_room[i].origin + crouch_offset;
					}
					else
					{
						desired_origin = image_room[i].origin + stand_offset;
					}
					players[i].teleport_origin = spawn( "script_origin", players[i].origin );
					players[i].teleport_origin.angles = players[i].angles;
					players[i] linkto( players[i].teleport_origin );
					players[i].teleport_origin.origin = desired_origin;
					players[i] FreezeControls( true );
					wait_network_frame();
					if( IsDefined( players[i] ) )
					{
						setClientSysState( "levelNotify", "black_box_start", players[i] );
						players[i].teleport_origin.angles = image_room[i].angles;
					}
				}
			}
		}
	}
	wait( 2 );
	core = GetEnt( "trigger_teleport_core", "targetname" );
	core thread teleport_nuke( undefined, 300);
	for ( i = 0; i < players.size; i++ )
	{
		if ( isdefined( players[i] ) )
		{
			for ( j = 0; j < 4; j++ )
			{
				if ( !occupied[j] )
				{
					dist = Distance2D( core_pos[j].origin, players[i].origin );
					if ( dist < player_radius )
					{
						occupied[j] = true;
					}
				}
			}
			setClientSysState( "levelNotify", "black_box_end", players[i] );
		}
	}
	wait_network_frame();
	for ( i = 0; i < players_touching.size; i++ )
	{
		player_idx = players_touching[i];
		player = players[player_idx];
		if ( !IsDefined( player ) )
		{
			continue;
		}
		slot = i;
		start = 0;
		while ( occupied[slot] && start < 4 )
		{
			start++;
			slot++;
			if ( slot >= 4 )
			{
				slot = 0;
			}
		}
		occupied[slot] = true;
		pos_name = "origin_teleport_player_" + slot;
		teleport_core_pos = getent( pos_name, "targetname" );
		player unlink();
		assert( IsDefined( player.teleport_origin ) );
		player.teleport_origin delete();
		player.teleport_origin = undefined;
		player enableweapons();
		player enableoffhandweapons();
		player setorigin( core_pos[slot].origin );
		player setplayerangles( core_pos[slot].angles );
		player FreezeControls( false );
		player thread teleport_aftereffects();
		vox_rand = randomintrange(1,100);
		if( vox_rand <= 2 )
		{
		}
		else
		{
		}
	}
	exploder( 106 );
}
teleport_core_hint_update()
{
	self setcursorhint( "HINT_NOICON" );
	while ( 1 )
	{
		if ( !flag( "power_on" ) )
		{
			self sethintstring( &"WAW_ZOMBIE_FLAMES_UNAVAILABLE" );
		}
		else if ( teleport_pads_are_active() )
		{
			self sethintstring( &"WAW_ZOMBIE_LINK_TPAD" );
		}
		else if ( level.active_links == 0 )
		{
			self sethintstring( &"WAW_ZOMBIE_INACTIVE_TPAD" );
		}
		else
		{
			self sethintstring( "" );
		}
		wait( .05 );
	}
}
teleport_core_think()
{
	trigger = getent( "trigger_teleport_core", "targetname" );
	if ( isdefined( trigger ) )
	{
		trigger thread teleport_core_hint_update();
		flag_wait( "power_on" );
		while ( 1 )
		{
			if ( teleport_pads_are_active() )
			{
				cheat = false;
				if ( !cheat )
				{
					trigger waittill( "trigger" );
				}
				for ( i = 0; i < level.teleport.size; i++ )
				{
					if ( isdefined( level.teleport[i] ) )
					{
						if ( level.teleport[i] == "timer_on" )
						{
							level.teleport[i] = "active";
							level.active_links++;
							flag_set( "teleporter_pad_link_"+level.active_links );
							ClientNotify( "scd" + i );
							teleport_core_start_exploder( i );
							if ( level.active_links == 3 )
							{
								exploder( 101 );
								ClientNotify( "pap1" );
								teleporter_vo( "linkall", trigger );
								Earthquake( 0.3, 2.0, trigger.origin, 3700 );
							}
							pad = "trigger_teleport_pad_" + i;
							trigger_pad = getent( pad, "targetname" );
							trigger_pad stop_countdown();
							ClientNotify( "TRs" );
							level.active_timer = -1;
						}
					}
				}
			}
			wait( .05 );
		}
	}
}
stop_countdown()
{
	self notify( "stop_countdown" );
	players = get_players();
	for( i = 0; i < players.size; i++ )
	{
		players[i] notify( "stop_countdown" );
	}
}
teleport_pads_are_active()
{
	if ( isdefined( level.teleport ) )
	{
		for ( i = 0; i < level.teleport.size; i++ )
		{
			if ( isdefined( level.teleport[i] ) )
			{
				if ( level.teleport[i] == "timer_on" )
				{
					return true;
				}
			}
		}
	}
	return false;
}
teleport_core_start_exploder( index )
{
	switch ( index )
	{
		case 0:
		exploder( 102 );
		break;
		case 1:
		exploder( 103 );
		break;
		case 2:
		exploder( 104 );
		break;
	}
}
teleport_2d_audio()
{
	self endon( "fx_done" );
	while ( 1 )
	{
		players = getplayers();
		wait(1.7);
		for ( i = 0; i < players.size; i++ )
		{
			if ( isdefined( players[i] ) )
			{
				if ( self player_is_near_pad( players[i] ) )
				{
					setClientSysState("levelNotify", "t2d", players[i]);
				}
			}
		}
	}
}
teleport_nuke( max_zombies, range )
{
	zombies = getaispeciesarray("axis");
	zombies = get_array_of_closest( self.origin, zombies, undefined, max_zombies, range );
	for (i = 0; i < zombies.size; i++)
	{
		wait (randomfloatrange(0.2, 0.3));
		if( !IsDefined( zombies[i] ) )
		{
			continue;
		}
		if( is_magic_bullet_shield_enabled( zombies[i] ) )
		{
			continue;
		}
		if( !( zombies[i].isdog ) )
		{
			zombies[i] maps\_zombiemode_spawner::zombie_head_gib();
		}
		zombies[i] dodamage( 10000, zombies[i].origin );
		playsoundatposition( "nuked", zombies[i].origin );
	}
}
teleporter_vo( tele_vo_type, location )
{
	if( !isdefined( location ))
	{
		self thread teleporter_vo_play( tele_vo_type, 2 );
	}
	else
	{
		players = get_players();
		for (i = 0; i < players.size; i++)
		{
			if (distance (players[i].origin, location.origin) < 64)
			{
				switch ( tele_vo_type )
				{
					case "linkall":
					players[i] thread teleporter_vo_play( "tele_linkall" );
					break;
					case "countdown":
					players[i] thread teleporter_vo_play( "tele_count", 3 );
					break;
				}
			}
		}
	}
}
teleporter_vo_play( vox_type, pre_wait )
{
	if(!isdefined( pre_wait ))
	{
		pre_wait = 0;
	}
	wait(pre_wait);
	self maps\_zombiemode_audio::create_and_play_dialog( "level", vox_type );
}
play_tele_help_vox()
{
	level endon( "tele_help_end" );
	while(1)
	{
		self waittill("trigger", who);
		if( flag( "power_on" ) )
		{
			who thread teleporter_vo_play( "tele_help" );
			level notify( "tele_help_end" );
		}
		while(IsDefined (who) && (who) IsTouching (self))
		{
			wait(0.1);
		}
	}
}
play_packa_see_vox()
{
	wait(10);
	if( !flag( "teleporter_pad_link_3" ) )
	{
		self waittill("trigger", who);
		who thread teleporter_vo_play( "perk_packa_see" );
	}
}
teleporter_wire_wait( index )
{
	targ = getstruct( "pad_"+index+"_wire" ,"targetname");
	if ( !IsDefined( targ ) )
	{
		return;
	}
	while(isDefined(targ))
	{
		if(isDefined(targ.target))
		{
			target = getstruct(targ.target,"targetname");
			wait( 0.1 );
			targ = target;
		}
		else
		{
			break;
		}
	}
}
teleport_aftereffects()
{
	if( GetDvar( "factoryAftereffectOverride" ) == "-1" )
	{
		self thread [[ level.teleport_ae_funcs[RandomInt(level.teleport_ae_funcs.size)] ]]();
	}
	else
	{
		self thread [[ level.teleport_ae_funcs[int(GetDvar( "factoryAftereffectOverride" ))] ]]();
	}
}
teleport_aftereffect_shellshock()
{
	println( "*** Explosion Aftereffect***\n" );
	self shellshock( "explosion", 4 );
}
teleport_aftereffect_shellshock_electric()
{
	println( "***Electric Aftereffect***\n" );
	self shellshock( "electrocution", 4 );
}
teleport_aftereffect_fov()
{
	setClientSysState( "levelNotify", "tae", self );
}
teleport_aftereffect_bw_vision( localClientNum )
{
	setClientSysState( "levelNotify", "tae", self );
}
teleport_aftereffect_red_vision( localClientNum )
{
	setClientSysState( "levelNotify", "tae", self );
}
teleport_aftereffect_flashy_vision( localClientNum )
{
	setClientSysState( "levelNotify", "tae", self );
}
teleport_aftereffect_flare_vision( localClientNum )
{
	setClientSysState( "levelNotify", "tae", self );
}
packa_door_reminder()
{
	while( !flag( "teleporter_pad_link_3" ) )
	{
		rand = randomintrange(4,16);
		self playsound( "packa_door_hitch" );
		wait(rand);
	}
}
dog_blocker_clip()
{
	collision = spawn("script_model", (-106, -2294, 216));
	collision setmodel("collision_wall_128x128x10");
	collision.angles = (0, 37.2, 0);
	collision Hide();
	collision = spawn("script_model", (-1208, -439, 363));
	collision setmodel("collision_wall_128x128x10");
	collision.angles = (0, 0, 0);
	collision Hide();
}	 