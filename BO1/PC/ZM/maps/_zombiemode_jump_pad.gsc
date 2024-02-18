#include common_scripts\utility;
#include maps\_utility;
#include maps\_zombiemode_utility;
init()
{
	if( is_true( level._uses_jump_pads ) )
	{
		level jump_pad_init();
	}
}
jump_pad_init()
{
	level._jump_pad_override = [];
	jump_pad_triggers = GetEntArray( "trig_jump_pad", "targetname" );
	if( !IsDefined( jump_pad_triggers ) )
	{
		return;
	}
	for( i = 0; i < jump_pad_triggers.size; i++ )
	{
		jump_pad_triggers[i].start = getstruct( jump_pad_triggers[i].target, "targetname" );
		jump_pad_triggers[i].destination = getstructarray( jump_pad_triggers[i].start.target, "targetname" );
		if( IsDefined( jump_pad_triggers[i].script_string ) )
		{
			jump_pad_triggers[i].overrides = StrTok( jump_pad_triggers[i].script_string, "," );
		}
		jump_pad_triggers[i] thread jump_pad_think();
	}
	level thread jump_pad_player_variables();
}
jump_pad_player_variables()
{
	flag_wait( "all_players_connected" );
	players = GetPlayers();
	for( j = 0; j < players.size; j++ )
	{
		players[j]._padded = false;
		players[j].lander = false;
	}
}
jump_pad_think()
{
	self endon( "destroyed" );
	end_point = undefined;
	start_point = undefined;
	z_velocity = undefined;
	z_dist = undefined;
	fling_this_way = undefined;
	jump_time = undefined;
	world_gravity = GetDvarInt( "bg_gravity" );
	gravity_pulls = 13.3 * -1;
	top_velocity_sq = 900 * 900;
	forward_scaling = 1.0;
	if( IsDefined( self.script_flag_wait ) )
	{
		if( !IsDefined( level.flag[ self.script_flag_wait ] ) )
		{
			flag_init( self.script_flag_wait );
		}
		flag_wait( self.script_flag_wait );
	}
	while( IsDefined( self ) )
	{
		self waittill( "trigger", who );
		if( IsPlayer( who ) )
		{
			self thread trigger_thread( who, ::jump_pad_start, ::jump_pad_cancel );
		}
	}
}
jump_pad_start( ent_player, endon_condition )
{
	self endon( "endon_condition" );
	ent_player endon( "left_jump_pad" );
	ent_player endon("death");
	ent_player endon("disconnect");
	end_point = undefined;
	start_point = undefined;
	z_velocity = undefined;
	z_dist = undefined;
	fling_this_way = undefined;
	jump_time = undefined;
	world_gravity = GetDvarInt( "bg_gravity" );
	gravity_pulls = 13.3 * -1;
	top_velocity_sq = 900 * 900;
	forward_scaling = 1.0;
	start_point = self.start;
	if( IsDefined( self.name ) )
	{
		self._action_overrides = StrTok( self.name, "," );
		if( IsDefined( self._action_overrides ) )
		{
			for( i = 0; i < self._action_overrides.size; i++ )
			{
				ent_player jump_pad_player_overrides( self._action_overrides[i] );
			}
		}
	}
	if( IsDefined( self.script_wait ) )
	{
		if( self.script_wait < 1 )
		{
			self playsound( "evt_jump_pad_charge_short" );
		}
		else
		{
			self playsound( "evt_jump_pad_charge" );
		}
		wait( self.script_wait );
	}
	else
	{
		self playsound( "evt_jump_pad_charge" );
		wait( 1.0 );
	}
	if( IsDefined( self.script_parameters ) && IsDefined( level._jump_pad_override[ self.script_parameters ] ) )
	{
		end_point = self [[ level._jump_pad_override[ self.script_parameters ] ]]( ent_player );
	}
	if( !IsDefined( end_point ) )
	{
		end_point = self.destination[ RandomInt( self.destination.size ) ];
	}
	if( IsDefined( self.script_string ) && IsDefined( level._jump_pad_override[ self.script_string ] ) )
	{
		info_array = self [[ level._jump_pad_override[ self.script_string ] ]]( start_point, end_point );
		fling_this_way = info_array[0];
		jump_time = info_array[1];
	}
	else
	{
		end_spot = end_point.origin;
		if( !is_true( self.script_airspeed ) )
		{
			rand_end = ( RandomFloat( -1, 1 ), RandomFloat( -1, 1 ), 0 );
			rand_scale = RandomInt( 100 );
			rand_spot = vector_scale( rand_end, rand_scale );
			end_spot = end_point.origin + rand_spot;
		}
		pad_dist = Distance( start_point.origin, end_spot );
		z_dist = end_spot[2] - start_point.origin[2];
		jump_velocity = end_spot - start_point.origin;
		if( z_dist > 40 && z_dist < 135 )
		{
			z_dist *= 2.5;
			forward_scaling = 1.1;
		}
		else if( z_dist >= 135 )
		{
			z_dist *= 2.7;
			forward_scaling = 1.3;
		}
		else if( z_dist < 0 )
		{
			z_dist *= 2.4;
			forward_scaling = 1.0;
		}
		z_velocity = 2 * z_dist * world_gravity;
		if( z_velocity < 0 )
		{
			z_velocity *= -1;
		}
		if( z_dist < 0 )
		{
			z_dist *= -1;
		}
		jump_time = Sqrt( 2 * pad_dist / world_gravity );
		jump_time_2 = Sqrt( 2 * z_dist / world_gravity );
		jump_time = jump_time + jump_time_2;
		if( jump_time < 0 )
		{
			jump_time *= -1;
		}
		x = jump_velocity[0] * forward_scaling / jump_time;
		y = jump_velocity[1] * forward_scaling / jump_time;
		z = z_velocity / jump_time;
		fling_this_way = ( x, y, z );
	}
	if( IsDefined( end_point.target ) )
	{
		poi_spot = getstruct( end_point.target, "targetname" );
	}
	else
	{
		poi_spot = end_point;
	}
	if( !IsDefined( self.script_index ) )
	{
		ent_player.script_index = undefined;
	}
	else
	{
		ent_player.script_index = self.script_index;
	}
	if( IsDefined( self.script_start ) && self.script_start == 1 )
	{
		if( !is_true( ent_player._padded ) )
		{
			self playsound( "evt_jump_pad_launch" );
			playfx(level._effect["jump_pad_jump"],self.origin);
			ent_player thread jump_pad_move( fling_this_way, jump_time, poi_spot );
			if( IsDefined( self.script_label ) )
			{
				level notify( self.script_label );
			}
		}
	}
	else
	{
		if( ent_player IsOnGround() && !is_true( ent_player._padded ) )
		{
			self playsound( "evt_jump_pad_launch" );
			playfx(level._effect["jump_pad_jump"],self.origin);
			ent_player thread jump_pad_move( fling_this_way, jump_time, poi_spot );
			if( IsDefined( self.script_label ) )
			{
				level notify( self.script_label );
			}
		}
	}
}
jump_pad_cancel( ent_player )
{
	ent_player notify( "left_jump_pad" );
	if( IsDefined( ent_player.poi_spot ) && !is_true( ent_player._padded ) )
	{
	}
	if( IsDefined( self.name ) )
	{
		self._action_overrides = StrTok( self.name, "," );
		if( IsDefined( self._action_overrides ) )
		{
			for( i = 0; i < self._action_overrides.size; i++ )
			{
				ent_player jump_pad_player_overrides( self._action_overrides[i] );
			}
		}
	}
}
jump_pad_move( vec_direction, flt_time, struct_poi )
{
	self endon( "death" );
	self endon( "disconnect" );
	start_time = GetTime();
	jump_time = flt_time * 500;
	attract_dist = undefined;
	num_attractors = 30;
	added_poi_value = 0;
	start_turned_on = true;
	poi_start_func = undefined;
	while( is_true( self.divetoprone ) || is_true( self._padded ) )
	{
		wait( 0.05 );
	}
	self._padded = 1;
	self.lander = 1;
	self SetStance( "stand" );
	wait( 0.1 );
	if( IsDefined( self.poi_spot ) )
	{
		level jump_pad_ignore_poi_cleanup( self.poi_spot );
		self.poi_spot deactivate_zombie_point_of_interest();
		self.poi_spot Delete();
	}
	if( IsDefined( struct_poi ) )
	{
		self.poi_spot = Spawn( "script_origin", struct_poi.origin );
		if( IsDefined( level._pad_poi_ignore ) )
		{
			level [[level._pad_poi_ignore]]( self.poi_spot );
		}
		self thread jump_pad_enemy_follow_or_ignore( self.poi_spot );
		if( IsDefined( level._jump_pad_poi_start_override ) && !is_true( self.script_index ) )
		{
			poi_start_func = level._jump_pad_poi_start_override;
		}
		if( IsDefined( level._jump_pad_poi_end_override ) )
		{
			poi_end_func = level._jump_pad_poi_end_override;
		}
		self.poi_spot create_zombie_point_of_interest( attract_dist, num_attractors, added_poi_value, start_turned_on, poi_start_func );
	}
	self SetOrigin( self.origin + ( 0, 0, 1 ) );
	if( 20 >= randomintrange( 0, 101 ) )
	{
		self thread maps\_zombiemode_audio::create_and_play_dialog( "general", "jumppad" );
	}
	while( GetTime() - start_time < jump_time )
	{
		self SetVelocity( vec_direction );
		wait( 0.05 );
	}
	while( !self IsOnGround() )
	{
		wait( 0.05 );
	}
	self._padded = 0;
	self.lander = 0;
	jump_pad_triggers = GetEntArray( "trig_jump_pad", "targetname" );
	for( i = 0; i < jump_pad_triggers.size; i++ )
	{
		if( self IsTouching( jump_pad_triggers[i] ) )
		{
			level thread failsafe_pad_poi_clean( jump_pad_triggers[i], self.poi_spot );
			return;
		}
	}
	if( IsDefined( self.poi_spot ) )
	{
		level jump_pad_ignore_poi_cleanup( self.poi_spot );
		self.poi_spot Delete();
	}
}
failsafe_pad_poi_clean( ent_trig, ent_poi )
{
	if( IsDefined( ent_trig.script_wait ) )
	{
		wait( ent_trig.script_wait );
	}
	else
	{
		wait( 0.5 );
	}
	if( IsDefined( ent_poi ) )
	{
		level jump_pad_ignore_poi_cleanup( ent_poi );
		ent_poi deactivate_zombie_point_of_interest();
		ent_poi Delete();
	}
}
jump_pad_enemy_follow_or_ignore( ent_poi )
{
	self endon( "death" );
	self endon( "disconnect" );
	zombies = GetAIArray( "axis" );
	for( i = 0; i < zombies.size; i++ )
	{
		players = GetPlayers();
		if( IsDefined( zombies[i] ) && IsDefined( zombies[i].enemy ) && zombies[i].enemy != self && players.size > 1 )
		{
			zombies[i] thread add_poi_to_ignore_list( ent_poi );
		}
		else
		{
			zombies[i].ignore_distance_tracking = true;
			zombies[i]._pad_follow = 1;
			zombies[i] thread stop_chasing_the_sky( ent_poi );
		}
	}
}
jump_pad_ignore_poi_cleanup( ent_poi )
{
	zombies = GetAIArray( "axis" );
	for( i = 0; i < zombies.size; i++ )
	{
		if( IsDefined( zombies[i] ) )
		{
			if( is_true( zombies[i]._pad_follow ) )
			{
				zombies[i]._pad_follow = 0;
				zombies[i] notify( "stop_chasing_the_sky" );
				zombies[i].ignore_distance_tracking = false;
			}
			if( IsDefined( ent_poi ) )
			{
				zombies[i] thread remove_poi_from_ignore_list( ent_poi );
			}
		}
	}
}
stop_chasing_the_sky( ent_poi )
{
	self endon( "death" );
	self endon( "stop_chasing_the_sky" );
	while( is_true( self._pad_follow ) )
	{
		flesh = get_closest_valid_player( self.origin );
		if( IsDefined( flesh ) && Distance2D( flesh.origin, self.origin ) < 10 * 10
		&& IsDefined( self.favoriteenemy ) && flesh != self.favoriteenemy )
		{
			self add_poi_to_ignore_list( ent_poi );
			return;
		}
		wait( 0.1 );
	}
	self._pad_follow = 0;
	self.ignore_distance_tracking = false;
	self notify( "stop_chasing_the_sky" );
}
jump_pad_player_overrides( st_behavior, int_clean )
{
	if( !IsDefined( st_behavior ) || !IsString( st_behavior ) )
	{
		return;
	}
	if( !IsDefined( int_clean ) )
	{
		int_clean = 0;
	}
	switch( st_behavior )
	{
		case "no_sprint":
		if( !int_clean )
		{
		}
		else
		{
		}
		break;
		default:
		if( IsDefined( level._jump_pad_level_behavior ) )
		{
			self [[ level._jump_pad_level_behavior ]]( st_behavior, int_clean );
		}
		else
		{
		}
		break;
	}
} 