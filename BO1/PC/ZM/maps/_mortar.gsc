#include maps\_utility;
#include common_scripts\utility;
main()
{
}
init_mortars()
{
	level._explosion_max_range = [];
	level._explosion_min_range = [];
	level._explosion_blast_radius = [];
	level._explosion_max_damage = [];
	level._explosion_min_damage = [];
	level._explosion_quake_power = [];
	level._explosion_quake_time = [];
	level._explosion_quake_radius = [];
	level._explosion_min_delay = [];
	level._explosion_max_delay = [];
	level._explosion_barrage_min_delay = [];
	level._explosion_barrage_max_delay = [];
	level._explosion_view_chance = [];
	level._explosion_dust_range = [];
	level._explosion_dust_name = [];
}
set_mortar_range( mortar_name, min_range, max_range, set_default )
{
	if( !IsDefined( level._explosion_min_range ) )
	{
		init_mortars();
	}
	if( IsDefined( set_default ) && set_default )
	{
		if( !IsDefined( level._explosion_min_range[mortar_name] ) )
		{
			level._explosion_min_range[mortar_name] = min_range;
		}
		if( !IsDefined( level._explosion_max_range[mortar_name] ) )
		{
			level._explosion_max_range[mortar_name] = max_range;
		}
	}
	else
	{
		level._explosion_min_range[mortar_name] = min_range;
		level._explosion_max_range[mortar_name] = max_range;
	}
}
set_mortar_damage( mortar_name, blast_radius, min_damage, max_damage, set_default )
{
	if( !IsDefined( level._explosion_blast_radius ) )
	{
		init_mortars();
	}
	if( IsDefined( set_default ) && set_default )
	{
		if( !IsDefined( level._explosion_blast_radius[mortar_name] ) )
		{
			level._explosion_blast_radius[mortar_name] = blast_radius;
		}
		if( !IsDefined( level._explosion_min_damage[mortar_name] ) )
		{
			level._explosion_min_damage[mortar_name] = min_damage;
		}
		if( !IsDefined( level._explosion_max_damage[mortar_name] ) )
		{
			level._explosion_max_damage[mortar_name] = max_damage;
		}
	}
	else
	{
		level._explosion_blast_radius[mortar_name] = blast_radius;
		level._explosion_min_damage[mortar_name] = min_damage;
		level._explosion_max_damage[mortar_name] = max_damage;
	}
}
set_mortar_quake( mortar_name, quake_power, quake_time, quake_radius, set_default )
{
	if( !IsDefined( level._explosion_quake_power ) )
	{
		init_mortars();
	}
	if( IsDefined( set_default ) && set_default )
	{
		if( !IsDefined( level._explosion_quake_power[mortar_name] ) )
		{
			level._explosion_quake_power[mortar_name] = quake_power;
		}
		if( !IsDefined( level._explosion_quake_power[mortar_name] ) )
		{
			level._explosion_quake_time[mortar_name] = quake_time;
		}
		if( !IsDefined( level._explosion_quake_radius[mortar_name] ) )
		{
			level._explosion_quake_radius[mortar_name] = quake_radius;
		}
	}
	else
	{
		level._explosion_quake_power[mortar_name] = quake_power;
		level._explosion_quake_time[mortar_name] = quake_time;
		level._explosion_quake_radius[mortar_name] = quake_radius;
	}
}
set_mortar_delays( mortar_name, min_delay, max_delay, barrage_min_delay, barrage_max_delay, set_default )
{
	if( !IsDefined( level._explosion_min_delay ) )
	{
		init_mortars();
	}
	if( IsDefined( set_default ) && set_default )
	{
		if( !IsDefined( level._explosion_min_delay[mortar_name] ) && IsDefined( min_delay ) )
		{
			level._explosion_min_delay[mortar_name] = min_delay;
		}
		if( !IsDefined( level._explosion_max_delay[mortar_name] ) && IsDefined( min_delay ) )
		{
			level._explosion_max_delay[mortar_name] = max_delay;
		}
		if( !IsDefined( level._explosion_barrage_min_delay[mortar_name] ) && IsDefined( barrage_min_delay ) )
		{
			level._explosion_barrage_min_delay[mortar_name] = barrage_min_delay;
		}
		if( !IsDefined( level._explosion_barrage_max_delay[mortar_name] ) && IsDefined( barrage_max_delay ) )
		{
			level._explosion_barrage_max_delay[mortar_name] = barrage_max_delay;
		}
	}
	else
	{
		if( IsDefined( min_delay ) )
		{
			level._explosion_min_delay[mortar_name] = min_delay;
		}
		if( IsDefined( min_delay ) )
		{
			level._explosion_max_delay[mortar_name] = max_delay;
		}
		if( IsDefined( barrage_min_delay ) )
		{
			level._explosion_barrage_min_delay[mortar_name] = barrage_min_delay;
		}
		if( IsDefined( barrage_max_delay ) )
		{
			level._explosion_barrage_max_delay[mortar_name] = barrage_max_delay;
		}
	}
}
set_mortar_chance( mortar_name, chance, set_default )
{
	if( !IsDefined( level._explosion_view_chance ) )
	{
		init_mortars();
	}
	assertex( chance <= 1, "_mortar::set_mortar_chance(), the chance parameter needs to be between 0 and 1" );
	if( IsDefined( set_default ) && set_default )
	{
		if( !IsDefined( level._explosion_view_chance[mortar_name] ) )
		{
			level._explosion_view_chance[mortar_name] = chance;
		}
	}
	else
	{
		level._explosion_view_chance[mortar_name] = chance;
	}
}
set_mortar_dust( mortar_name, dust_name, range )
{
	if( !IsDefined( level._explosion_dust_range ) )
	{
		init_mortars();
	}
	level._explosion_dust_name[mortar_name] = dust_name;
	if( !IsDefined( range ) )
	{
		range = 512;
	}
	level._explosion_dust_range[mortar_name] = range;
}
mortar_loop( mortar_name, barrage_amount, no_terrain )
{
	level endon( "stop_all_mortar_loops" );
	assertex( ( IsDefined( mortar_name ) &&( mortar_name != "" ) ), "mortar_name not passed. pass in level script" );
	assertex( ( IsDefined( level._effect ) && IsDefined( level._effect[mortar_name] ) ), "level._effect[strMortars] not defined. define in level script" );
	last_explosion = -1;
	set_mortar_range( mortar_name, 300, 2200, true );
	set_mortar_delays( mortar_name, 5, 7, 5, 7, true );
	set_mortar_chance( mortar_name, 0, true );
	if( !IsDefined( barrage_amount ) || barrage_amount < 1 )
	{
		barrage_amount = 1;
	}
	if( !IsDefined( no_terrain ) )
	{
		no_terrain = false;
	}
	if( IsDefined( level._explosion_stopNotify ) && IsDefined( level._explosion_stopNotify[mortar_name] ) )
	{
		level endon( level._explosion_stopNotify[mortar_name] );
	}
	if( !IsDefined( level._explosion_stop_barrage ) || !IsDefined( level._explosion_stop_barrage[mortar_name] ) )
	{
		level._explosion_stop_barrage[mortar_name] = false;
	}
	explosion_points = [];
	explosion_points = GetEntArray( mortar_name, "targetname" );
	explosion_points_structs = [];
	explosion_points_structs = getstructarray( mortar_name, "targetname" );
	for( i = 0; i < explosion_points_structs.size; i++ )
	{
		explosion_points_structs[i].is_struct = true;
		explosion_points = add_to_array( explosion_points, explosion_points_structs[i] );
	}
	explosion_points_structs = [];
	dust_points = [];
	if( IsDefined( level._explosion_dust_name[mortar_name] ) )
	{
		dust_name = level._explosion_dust_name[mortar_name];
		dust_points = GetEntArray( dust_name, "targetname" );
		dust_points_structs = [];
		dust_points_structs = getstructarray( dust_name, "targetname" );
		for( i = 0; i < dust_points_structs.size; i++ )
		{
			dust_points_structs[i].is_struct = true;
			dust_points = add_to_array( dust_points, dust_points_structs[i] );
		}
		dust_points_structs = [];
	}
	for( i = 0; i < explosion_points.size; i++ )
	{
		if( IsDefined( explosion_points[i].target ) &&( !no_terrain ) )
		{
			explosion_points[i] setup_mortar_terrain();
		}
	}
	if( IsDefined( level._explosion_start_notify ) && IsDefined( level._explosion_start_notify[mortar_name] ) )
	{
		level waittill( level._explosion_start_notify[mortar_name] );
	}
	while( true )
	{
		while( !level._explosion_stop_barrage[mortar_name] )
		{
			do_mortar = false;
			for( j = 0; j < barrage_amount; j++ )
			{
				max_rangeSQ = level._explosion_max_range[mortar_name] * level._explosion_max_range[mortar_name];
				min_rangeSQ = level._explosion_min_range[mortar_name] * level._explosion_min_range[mortar_name];
				random_num = RandomInt( explosion_points.size );
				for( i = 0; i < explosion_points.size; i++ )
				{
					num = ( i + random_num ) % explosion_points.size;
					do_mortar = false;
					players = get_players();
					for( q = 0; q < players.size; q++ )
					{
						dist = DistanceSquared( players[q] GetOrigin(), explosion_points[num].origin );
						if( num != last_explosion && dist < max_rangeSQ && dist > min_rangeSQ )
						{
							if( level._explosion_view_chance[mortar_name] > 0 )
							{
								if( players[q] player_view_chance( level._explosion_view_chance[mortar_name], explosion_points[num].origin ) )
								{
									do_mortar = true;
									break;
								}
								else
								{
									do_mortar = false;
								}
							}
							else
							{
								do_mortar = true;
								break;
							}
						}
						else
						{
							do_mortar = false;
						}
					}
					if( do_mortar )
					{
						explosion_points[num] thread explosion_activate( mortar_name, undefined, undefined, undefined, undefined, undefined, undefined, dust_points );
						last_explosion = num;
						break;
					}
				}
				last_explosion = -1;
				if( do_mortar )
				{
					if( IsDefined( level._explosion_delay ) && IsDefined( level._explosion_delay[mortar_name] ) )
					{
						wait( level._explosion_delay[mortar_name] );
					}
					else
					{
						wait( RandomFloatRange( level._explosion_min_delay[mortar_name], level._explosion_max_delay[mortar_name] ) );
					}
				}
				else
				{
					j--;
					wait( 0.25 );
				}
			}
			if( barrage_amount > 1 )
			{
				if( IsDefined( level._explosion_barrage_delay ) && IsDefined( level._explosion_barrage_delay[mortar_name] ) )
				{
					wait( level._explosion_barrage_delay[mortar_name] );
				}
				else
				{
					wait( RandomFloatRange( level._explosion_barrage_min_delay[mortar_name], level._explosion_barrage_max_delay[mortar_name] ) );
				}
			}
		}
		wait( 0.05 );
	}
}
player_view_chance( view_chance, explosion_point )
{
	chance = RandomFloat( 1 );
	if( chance <= view_chance )
	{
		if( within_fov( self GetEye(), self GetPlayerAngles(), explosion_point, cos( 30 ) ) )
		{
			return true;
		}
	}
	return false;
}
explosion_activate( mortar_name, blast_radius, min_damage, max_damage, quake_power, quake_time, quake_radius, dust_points )
{
	set_mortar_damage( mortar_name, 256, 25, 400, true );
	set_mortar_quake( mortar_name, 0.15, 2, 850, true );
	if( !IsDefined( blast_radius ) )
	{
		blast_radius = level._explosion_blast_radius[mortar_name];
	}
	if( !IsDefined( min_damage ) )
	{
		min_damage = level._explosion_min_damage[mortar_name];
	}
	if( !IsDefined( max_damage ) )
	{
		max_damage = level._explosion_max_damage[mortar_name];
	}
	if( !IsDefined( quake_power ) )
	{
		quake_power = level._explosion_quake_power[mortar_name];
	}
	if( !IsDefined( quake_time ) )
	{
		quake_time = level._explosion_quake_time[mortar_name];
	}
	if( !IsDefined( quake_radius ) )
	{
		quake_radius = level._explosion_quake_radius[mortar_name];
	}
	is_struct = IsDefined( self.is_struct ) && self.is_struct;
	temp_ent = undefined;
	if( is_struct )
	{
		temp_ent = Spawn( "script_origin", self.origin );
	}
	if( is_struct )
	{
		temp_ent explosion_incoming( mortar_name );
	}
	else
	{
		self explosion_incoming( mortar_name );
	}
	level notify( "explosion", mortar_name );
	RadiusDamage( self.origin, blast_radius, max_damage, min_damage );
	if( ( IsDefined( self.has_terrain ) && self.has_terrain == true ) && ( IsDefined( self.terrain ) ) )
	{
		for( i = 0; i < self.terrain.size; i++ )
		{
			if( IsDefined( self.terrain[i] ) )
			{
				self.terrain[i] Delete();
			}
		}
	}
	if( IsDefined( self.hidden_terrain ) )
	{
		self.hidden_terrain Show();
	}
	self.has_terrain = false;
	if( is_struct )
	{
		temp_ent explosion_boom( mortar_name, quake_power, quake_time, quake_radius );
	}
	else
	{
		self explosion_boom( mortar_name, quake_power, quake_time, quake_radius );
	}
	if( IsDefined( dust_points ) && dust_points.size > 0 )
	{
		max_range = 384;
		if( IsDefined( level._explosion_dust_range ) && IsDefined( level._explosion_dust_range[mortar_name] ) )
		{
			max_range = level._explosion_dust_range[mortar_name];
		}
		for( i = 0; i < dust_points.size; i++ )
		{
			if( DistanceSquared( dust_points[i].origin, self.origin ) < max_range * max_range )
			{
				if( IsDefined( dust_points[i].script_fxid ) )
				{
					PlayFx( level._effect[dust_points[i].script_fxid], dust_points[i].origin );
				}
				else
				{
					PlayFx( level._effect[level._explosion_dust_name[mortar_name]], dust_points[i].origin );
				}
			}
		}
	}
	if( is_struct )
	{
		temp_ent thread delete_temp_ent();
	}
}
delete_temp_ent()
{
	wait( 5 );
	self Delete();
}
explosion_boom( mortar_name, power, time, radius, is_struct )
{
	if( !IsDefined( power ) )
	{
		power = 0.15;
	}
	if( !IsDefined( time ) )
	{
		time = 2;
	}
	if( !IsDefined( radius ) )
	{
		radius = 850;
	}
	if (!isdefined(is_struct))
	{
		explosion_sound( mortar_name );
	}
	else
	{
		temp_ent = Spawn( "script_origin", self.origin );
		temp_ent explosion_sound( mortar_name );
		temp_ent thread delete_temp_ent();
	}
	explosion_origin = self.origin;
	PlayFx( level._effect[mortar_name], explosion_origin );
	Earthquake( power, time, explosion_origin, radius );
	thread mortar_rumble_on_all_players("damage_light","damage_heavy", explosion_origin, radius * 0.75, radius * 1.25);
	physRadius = radius;
	if( physRadius > 500 )
	{
		physRadius = 500;
	}
	if(!isDefined(level.no_explosion_physics) || isDefined(level.no_explosion_physics) && level.no_explosion_physics )
	{
		PhysicsExplosionSphere( explosion_origin, physRadius, physRadius * 0.25, 0.75 );
	}
	players = get_players();
	player_count = 0;
	for( q = 0; q < players.size; q++ )
	{
		if( Distancesquared( players[q].origin, explosion_origin ) > 300 * 300 )
		{
			player_count++;
		}
	}
	if( player_count == players.size )
	{
		return;
	}
	level.playerMortar = true;
	level notify( "shell shock player", time * 4 );
	max_damage = level._explosion_max_damage[mortar_name];
	min_damage = level._explosion_max_damage[mortar_name];
	maps\_shellshock::main( explosion_origin, time * 4, undefined, max_damage, 1, min_damage );
}
explosion_sound( mortar_name )
{
	if( level._effectType[mortar_name] == "mortar" )
	{
		self PlaySound( "exp_mortar_dirt" );
	}
	if( level._effectType[mortar_name] == "mortar_water" )
	{
		self PlaySound( "exp_mortar_water" );
	}
	else if( level._effectType[mortar_name] == "artillery" )
	{
		self PlaySound( "exp_mortar_dirt" );
	}
	else if( level._effectType[mortar_name] == "bomb" )
	{
		self PlaySound( "exp_mortar_dirt" );
	}
}
explosion_incoming( mortar_name )
{
	if( level._effectType[mortar_name] == "mortar" )
	{
		self PlaySound( "prj_mortar_incoming", "sounddone" );
	}
	if( level._effectType[mortar_name] == "mortar_water" )
	{
		self PlaySound( "prj_mortar_incoming", "sounddone" );
	}
	else if( level._effectType[mortar_name] == "artillery" )
	{
		self PlaySound( "prj_mortar_incoming", "sounddone" );
	}
	else if( level._effectType[mortar_name] == "bomb" )
	{
		self PlaySound( "prj_mortar_incoming", "sounddone");
	}
	self waittill ("sounddone");
}
setup_mortar_terrain()
{
	self.has_terrain = false;
	if( IsDefined( self.target ) )
	{
		self.terrain = GetEntArray( self.target, "targetname" );
		self.has_terrain = true;
	}
	else
	{
		println( "z:          mortar entity has no target: ", self.origin );
	}
	if( !IsDefined( self.terrain ) )
	{
		println( "z:          mortar entity has target, but target doesnt exist: ", self.origin );
	}
	if( IsDefined( self.script_hidden ) )
	{
		if( IsDefined( self.script_hidden ) )
		{
			self.hidden_terrain = GetEnt( self.script_hidden, "targetname" );
		}
		else if( ( IsDefined( self.terrain ) ) &&( IsDefined( self.terrain[0].target ) ) )
		{
			self.hidden_terrain = GetEnt( self.terrain[0].target, "targetname" );
		}
		if( IsDefined( self.hidden_terrain ) )
		{
			self.hidden_terrain Hide();
		}
	}
	else if( IsDefined( self.has_terrain ) )
	{
		if( IsDefined( self.terrain ) && IsDefined( self.terrain[0].target ) )
		{
			self.hidden_terrain = GetEnt( self.terrain[0].target, "targetname" );
		}
		if( IsDefined( self.hidden_terrain ) )
		{
			self.hidden_terrain Hide();
		}
	}
}
activate_mortar( range, max_damage, min_damage, quake_power, quake_time, quake_radius, bIsstruct, effect, bShellShock )
{
	incoming_sound( undefined, bIsstruct );
	level notify( "mortar" );
	self notify( "mortar" );
	if( !IsDefined( range ) )
	{
		range = 256;
	}
	if( !IsDefined( max_damage ) )
	{
		max_damage = 400;
	}
	if( !IsDefined( min_damage ) )
	{
		min_damage = 25;
	}
	if ( !IsDefined( effect ))
	{
		effect = level.mortar;
	}
	if ( !IsDefined( bShellShock ))
	{
		bShellShock = true;
	}
	RadiusDamage( self.origin, range, max_damage, min_damage );
	if( ( IsDefined( self.has_terrain ) && self.has_terrain == true ) &&( IsDefined( self.terrain ) ) )
	{
		for( i = 0; i < self.terrain.size; i++ )
		{
			if( IsDefined( self.terrain[i] ) )
			{
				self.terrain[i] Delete();
			}
		}
	}
	if( IsDefined( self.hidden_terrain ) )
	{
		self.hidden_terrain Show();
	}
	self.has_terrain = false;
	mortar_boom( self.origin, quake_power, quake_time, quake_radius, effect, bIsstruct, bShellShock );
}
mortar_boom( origin, power, time, radius, effect, bIsstruct, bShellShock )
{
	if( !IsDefined( power ) )
	{
		power = 0.15;
	}
	if( !IsDefined( time ) )
	{
		time = 2;
	}
	if( !IsDefined( radius ) )
	{
		radius = 850;
	}
	if ( !IsDefined( bShellShock ))
	{
		bShellShock = true;
	}
	thread mortar_sound( bIsstruct );
	if( IsDefined( effect ) )
	{
		PlayFx( effect, origin );
	}
	else
	{
		PlayFx( level.mortar, origin );
	}
	Earthquake( power, time, origin, radius );
	thread mortar_rumble_on_all_players("damage_light","damage_heavy", origin, radius * 0.75, radius * 1.25);
	physRadius = radius;
	if(!isDefined(level.no_mortar_physics)|| isDefined(level.no_mortar_physics) && level.no_mortar_physics )
	{
		phys_origin = ( origin[0], origin[1], origin[2] - 0.5*physRadius );
		PhysicsExplosionSphere( phys_origin, physRadius, physRadius * 0.25, 3.0 );
	}
	if( IsDefined( level.playerMortar ) )
	{
		return;
	}
	players = get_players();
	players = get_players();
	player_count = 0;
	for( q = 0; q < players.size; q++ )
	{
		if( Distancesquared( players[q].origin, origin ) > 300 * 300 )
		{
			player_count++;
		}
	}
	if( player_count == players.size )
	{
		return;
	}
	if( level.script == "carchase" || level.script == "breakout" )
	{
		return;
	}
	if( bShellShock )
	{
		level.playerMortar = true;
		level notify( "shell shock player", time*4 );
		maps\_shellshock::main( origin, time * 4 );
	}
}
mortar_sound( bIsstruct )
{
	if( isdefined(bIsstruct) && bIsstruct == true )
	{
		temp_ent = Spawn( "script_origin", self.origin );
		temp_ent PlaySound( "exp_mortar_dirt" );
		temp_ent thread delete_temp_ent();
	}
	else
	{
		self PlaySound( "exp_mortar_dirt" );
	}
}
incoming_sound( soundnum , bIsstruct )
{
	currenttime = GetTime();
	if( !IsDefined( level.lastmortarincomingtime ) )
	{
		level.lastmortarincomingtime = currenttime;
	}
	else if( ( currenttime-level.lastmortarincomingtime ) < 1000 )
	{
		wait( 1 );
		return;
	}
	else
	{
		level.lastmortarincomingtime = currenttime;
	}
	if( IsDefined(bIsstruct) && bIsstruct == true )
	{
		temp_ent = Spawn( "script_origin", self.origin );
		temp_ent PlaySound( "prj_mortar_incoming", "sounddone" );
		temp_ent waittill( "sounddone" );
		level notify("mortar_inc_done");
		temp_ent thread delete_temp_ent();
	}
	else
	{
		self PlaySound( "prj_mortar_incoming", "sounddone" );
		self waittill( "sounddone" );
		level notify("mortar_inc_done");
	}
}
mortar_rumble_on_all_players(high_rumble_string, low_rumble_string, rumble_org, high_rumble_range, low_rumble_range)
{
	players = get_players();
	for (i = 0; i < players.size; i++)
	{
		if (isdefined (high_rumble_range) && isdefined (low_rumble_range) && isdefined(rumble_org))
		{
			if (distance (players[i].origin, rumble_org) < high_rumble_range)
			{
				players[i] playrumbleonentity(high_rumble_string);
			}
			else if (distance (players[i].origin, rumble_org) < low_rumble_range)
			{
				players[i] playrumbleonentity(low_rumble_string);
			}
		}
		else
		{
			players[i] playrumbleonentity(high_rumble_string);
		}
	}
} 