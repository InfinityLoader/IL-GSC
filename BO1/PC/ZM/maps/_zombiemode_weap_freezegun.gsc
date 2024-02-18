#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;
#using_animtree( "generic_human" );
init()
{
	if ( !maps\_zombiemode_weapons::is_weapon_included( "freezegun_zm" ) )
	{
		return;
	}
	level._ZOMBIE_ACTOR_FLAG_FREEZEGUN_EXTREMITY_DAMAGE_FX = 15;
	level._ZOMBIE_ACTOR_FLAG_FREEZEGUN_TORSO_DAMAGE_FX = 14;
	set_zombie_var( "freezegun_cylinder_radius", 120 );
	set_zombie_var( "freezegun_inner_range", 60 );
	set_zombie_var( "freezegun_outer_range", 600 );
	set_zombie_var( "freezegun_inner_damage", 1000 );
	set_zombie_var( "freezegun_outer_damage", 500 );
	set_zombie_var( "freezegun_shatter_range", 180 );
	set_zombie_var( "freezegun_shatter_inner_damage", 500 );
	set_zombie_var( "freezegun_shatter_outer_damage", 250 );
	set_zombie_var( "freezegun_cylinder_radius_upgraded", 180 );
	set_zombie_var( "freezegun_inner_range_upgraded", 120 );
	set_zombie_var( "freezegun_outer_range_upgraded", 900 );
	set_zombie_var( "freezegun_inner_damage_upgraded", 1500 );
	set_zombie_var( "freezegun_outer_damage_upgraded", 750 );
	set_zombie_var( "freezegun_shatter_range_upgraded", 300 );
	set_zombie_var( "freezegun_shatter_inner_damage_upgraded",	750 );
	set_zombie_var( "freezegun_shatter_outer_damage_upgraded",	500 );
	level._effect[ "freezegun_shatter" ] = LoadFX( "weapon/freeze_gun/fx_freezegun_shatter" );
	level._effect[ "freezegun_crumple" ] = LoadFX( "weapon/freeze_gun/fx_freezegun_crumple" );
	level._effect[ "freezegun_smoke_cloud" ] = loadfx( "weapon/freeze_gun/fx_freezegun_smoke_cloud" );
	level._effect[ "freezegun_damage_torso" ] = LoadFX( "maps/zombie/fx_zombie_freeze_torso" );
	level._effect[ "freezegun_damage_sm" ] = LoadFX( "maps/zombie/fx_zombie_freeze_md" );
	level._effect[ "freezegun_shatter_upgraded" ] = LoadFX( "weapon/freeze_gun/fx_exp_freezegun_impact" );
	level._effect[ "freezegun_crumple_upgraded" ] = LoadFX( "weapon/freeze_gun/fx_exp_freezegun_impact" );
	level._effect[ "freezegun_shatter_gib_fx" ] = LoadFX( "weapon/bullet/fx_flesh_gib_fatal_01" );
	level._effect[ "freezegun_shatter_gibtrail_fx" ]	= LoadFX( "weapon/freeze_gun/fx_trail_freezegun_blood_streak" );
	level._effect[ "freezegun_crumple_gib_fx" ] = LoadFX( "system_elements/fx_null" );
	level._effect[ "freezegun_crumple_gibtrail_fx" ]	= LoadFX( "system_elements/fx_null" );
	level thread freezegun_on_player_connect();
}
freezegun_on_player_connect()
{
	for( ;; )
	{
		level waittill( "connecting", player );
		player thread wait_for_thundergun_fired();
	}
}
wait_for_thundergun_fired()
{
	self endon( "disconnect" );
	self waittill( "spawned_player" );
	for( ;; )
	{
		self waittill( "weapon_fired" );
		currentweapon = self GetCurrentWeapon();
		if( ( currentweapon == "freezegun_zm" ) || ( currentweapon == "freezegun_upgraded_zm" ) )
		{
			self thread freezegun_fired( currentweapon == "freezegun_upgraded_zm" );
			view_pos = self GetTagOrigin( "tag_flash" ) - self GetPlayerViewHeight();
			view_angles = self GetTagAngles( "tag_flash" );
			playfx( level._effect["freezegun_smoke_cloud"], view_pos, AnglesToForward( view_angles ), AnglesToUp( view_angles ) );
		}
	}
}
freezegun_fired( upgraded )
{
	if ( !IsDefined( level.freezegun_enemies ) )
	{
		level.freezegun_enemies = [];
		level.freezegun_enemies_dist_ratio = [];
	}
	self freezegun_get_enemies_in_range( upgraded );
	for ( i = 0; i < level.freezegun_enemies.size; i++ )
	{
		level.freezegun_enemies[i] thread freezegun_do_damage( upgraded, self, level.freezegun_enemies_dist_ratio[i] );
	}
	level.freezegun_enemies = [];
	level.freezegun_enemies_dist_ratio = [];
}
freezegun_get_cylinder_radius( upgraded )
{
	if ( upgraded )
	{
		return level.zombie_vars["freezegun_cylinder_radius_upgraded"];
	}
	else
	{
		return level.zombie_vars["freezegun_cylinder_radius"];
	}
}
freezegun_get_inner_range( upgraded )
{
	if ( upgraded )
	{
		return level.zombie_vars["freezegun_inner_range_upgraded"];
	}
	else
	{
		return level.zombie_vars["freezegun_inner_range"];
	}
}
freezegun_get_outer_range( upgraded )
{
	if ( upgraded )
	{
		return level.zombie_vars["freezegun_outer_range_upgraded"];
	}
	else
	{
		return level.zombie_vars["freezegun_outer_range"];
	}
}
freezegun_get_inner_damage( upgraded )
{
	if ( upgraded )
	{
		return level.zombie_vars["freezegun_inner_damage_upgraded"];
	}
	else
	{
		return level.zombie_vars["freezegun_inner_damage"];
	}
}
freezegun_get_outer_damage( upgraded )
{
	if ( upgraded )
	{
		return level.zombie_vars["freezegun_outer_damage_upgraded"];
	}
	else
	{
		return level.zombie_vars["freezegun_outer_damage"];
	}
}
freezegun_get_shatter_range( upgraded )
{
	if ( upgraded )
	{
		return level.zombie_vars["freezegun_shatter_range_upgraded"];
	}
	else
	{
		return level.zombie_vars["freezegun_shatter_range"];
	}
}
freezegun_get_shatter_inner_damage( upgraded )
{
	if ( upgraded )
	{
		return level.zombie_vars["freezegun_shatter_inner_damage_upgraded"];
	}
	else
	{
		return level.zombie_vars["freezegun_shatter_inner_damage"];
	}
}
freezegun_get_shatter_outer_damage( upgraded )
{
	if ( upgraded )
	{
		return level.zombie_vars["freezegun_shatter_outer_damage_upgraded"];
	}
	else
	{
		return level.zombie_vars["freezegun_shatter_outer_damage"];
	}
}
freezegun_get_enemies_in_range( upgraded )
{
	inner_range = freezegun_get_inner_range( upgraded );
	outer_range = freezegun_get_outer_range( upgraded );
	cylinder_radius = freezegun_get_cylinder_radius( upgraded );
	view_pos = self GetWeaponMuzzlePoint();
	zombies = get_array_of_closest( view_pos, GetAiSpeciesArray( "axis", "all" ), undefined, undefined, (outer_range * 1.1) );
	if ( !isDefined( zombies ) )
	{
		return;
	}
	freezegun_inner_range_squared = inner_range * inner_range;
	freezegun_outer_range_squared = outer_range * outer_range;
	cylinder_radius_squared = cylinder_radius * cylinder_radius;
	forward_view_angles = self GetWeaponForwardDir();
	end_pos = view_pos + vector_scale( forward_view_angles, outer_range );
	for ( i = 0; i < zombies.size; i++ )
	{
		if ( !IsDefined( zombies[i] ) || !IsAlive( zombies[i] ) )
		{
			continue;
		}
		test_origin = zombies[i] getcentroid();
		test_range_squared = DistanceSquared( view_pos, test_origin );
		if ( test_range_squared > freezegun_outer_range_squared )
		{
			zombies[i] freezegun_debug_print( "range", (1, 0, 0) );
			return;
		}
		normal = VectorNormalize( test_origin - view_pos );
		dot = VectorDot( forward_view_angles, normal );
		if ( 0 > dot )
		{
			zombies[i] freezegun_debug_print( "dot", (1, 0, 0) );
			continue;
		}
		radial_origin = PointOnSegmentNearestToPoint( view_pos, end_pos, test_origin );
		if ( DistanceSquared( test_origin, radial_origin ) > cylinder_radius_squared )
		{
			zombies[i] freezegun_debug_print( "cylinder", (1, 0, 0) );
			continue;
		}
		if ( 0 == zombies[i] DamageConeTrace( view_pos, self ) )
		{
			zombies[i] freezegun_debug_print( "cone", (1, 0, 0) );
			continue;
		}
		level.freezegun_enemies[level.freezegun_enemies.size] = zombies[i];
		level.freezegun_enemies_dist_ratio[level.freezegun_enemies_dist_ratio.size] = (freezegun_outer_range_squared - test_range_squared) / (freezegun_outer_range_squared - freezegun_inner_range_squared);
	}
}
freezegun_debug_print( msg, color )
{
}
freezegun_do_damage( upgraded, player, dist_ratio )
{
	damage = Int( LerpFloat( freezegun_get_outer_damage( upgraded ), freezegun_get_inner_damage( upgraded ), dist_ratio ) );
	self DoDamage( damage, player.origin, player, undefined, "projectile" );
	self freezegun_debug_print( damage, (0, 1, 0) );
}
freezegun_set_extremity_damage_fx()
{
	self setclientflag( level._ZOMBIE_ACTOR_FLAG_FREEZEGUN_EXTREMITY_DAMAGE_FX );
}
freezegun_clear_extremity_damage_fx()
{
	self clearclientflag( level._ZOMBIE_ACTOR_FLAG_FREEZEGUN_EXTREMITY_DAMAGE_FX );
}
freezegun_set_torso_damage_fx()
{
	self setclientflag( level._ZOMBIE_ACTOR_FLAG_FREEZEGUN_TORSO_DAMAGE_FX );
}
freezegun_clear_torso_damage_fx()
{
	self clearclientflag( level._ZOMBIE_ACTOR_FLAG_FREEZEGUN_TORSO_DAMAGE_FX );
}
freezegun_damage_response( player, amount )
{
	if ( IsDefined( self.freezegun_damage_response_func ) )
	{
		if ( self [[ self.freezegun_damage_response_func ]]( player, amount ) )
		{
			return;
		}
	}
	self.freezegun_damage += amount;
	new_move_speed = self.zombie_move_speed;
	percent_dmg = self enemy_percent_damaged_by_freezegun();
	if ( 0.66 <= percent_dmg )
	{
		new_move_speed = "walk";
	}
	else if ( 0.33 <= percent_dmg )
	{
		if ( "sprint" == self.zombie_move_speed )
		{
			new_move_speed = "run";
		}
		else
		{
			new_move_speed = "walk";
		}
	}
	if ( !self.isdog && self.zombie_move_speed != new_move_speed )
	{
		maps\_zombiemode_spawner::set_zombie_run_cycle( new_move_speed );
	}
	self thread freezegun_set_extremity_damage_fx();
}
freezegun_do_gib( gib_type, upgraded )
{
	gibArray = [];
	gibArray[gibArray.size] = level._ZOMBIE_GIB_PIECE_INDEX_ALL;
	if ( upgraded )
	{
		gibArray[gibArray.size] = 7;
	}
	self gib( gib_type, gibArray );
	self hide();
	wait( 0.1 );
	self self_delete();
}
freezegun_do_shatter( player, weap, shatter_trigger, crumple_trigger )
{
	freezegun_debug_print( "shattered" );
	self freezegun_cleanup_freezegun_triggers( shatter_trigger, crumple_trigger );
	upgraded = (weap == "freezegun_upgraded_zm");
	self radiusDamage( self.origin, freezegun_get_shatter_range( upgraded ), freezegun_get_shatter_inner_damage( upgraded ), freezegun_get_shatter_outer_damage( upgraded ), player, "MOD_EXPLOSIVE", weap );
	if ( is_mature() )
	{
		self thread freezegun_do_gib( "up", upgraded );
	}
	else
	{
		self StartRagdoll();
	}
}
freezegun_wait_for_shatter( player, weap, shatter_trigger, crumple_trigger )
{
	shatter_trigger endon( "cleanup_freezegun_triggers" );
	orig_attacker = self.attacker;
	shatter_trigger waittill( "damage", amount, attacker, dir, org, mod );
	if ( isDefined( attacker ) && attacker == orig_attacker && "MOD_PROJECTILE" == mod && ("freezegun_zm" == attacker GetCurrentWeapon() || "freezegun_upgraded_zm" == attacker GetCurrentWeapon()) )
	{
		self thread freezegun_do_crumple( weap, shatter_trigger, crumple_trigger );
	}
	else
	{
		self thread freezegun_do_shatter( player, weap, shatter_trigger, crumple_trigger );
	}
}
freezegun_do_crumple( weap, shatter_trigger, crumple_trigger )
{
	freezegun_debug_print( "crumpled" );
	self freezegun_cleanup_freezegun_triggers( shatter_trigger, crumple_trigger );
	upgraded = (weap == "freezegun_upgraded_zm");
	if ( is_mature() )
	{
		self thread freezegun_do_gib( "freeze", upgraded );
	}
	else
	{
		self StartRagdoll();
	}
}
freezegun_wait_for_crumple( weap, shatter_trigger, crumple_trigger )
{
	crumple_trigger endon( "cleanup_freezegun_triggers" );
	crumple_trigger waittill( "trigger" );
	self thread freezegun_do_crumple( weap, shatter_trigger, crumple_trigger );
}
freezegun_cleanup_freezegun_triggers( shatter_trigger, crumple_trigger )
{
	self notify( "cleanup_freezegun_triggers" );
	shatter_trigger notify( "cleanup_freezegun_triggers" );
	crumple_trigger notify( "cleanup_freezegun_triggers" );
	shatter_trigger self_delete();
	crumple_trigger self_delete();
}
freezegun_run_skipped_death_events()
{
	self thread maps\_zombiemode_audio::do_zombies_playvocals( "death", self.animname );
	self thread maps\_zombiemode_spawner::zombie_eye_glow_stop();
}
freezegun_death( hit_location, hit_origin, player )
{
	if ( self.isdog )
	{
		self freezegun_run_skipped_death_events();
		return;
	}
	if ( !self.has_legs )
	{
		if ( !isDefined( level._zombie_freezegun_death_missing_legs[self.animname] ) )
		{
			self freezegun_run_skipped_death_events();
			return;
		}
		self.deathanim = random( level._zombie_freezegun_death_missing_legs[self.animname] );
	}
	else
	{
		if ( !isDefined( level._zombie_freezegun_death[self.animname] ) )
		{
			self freezegun_run_skipped_death_events();
			return;
		}
		self.deathanim = random( level._zombie_freezegun_death[self.animname] );
	}
	self.freezegun_death = true;
	self.skip_death_notetracks = true;
	self.nodeathragdoll = true;
	self PlaySound( "wpn_freezegun_impact_zombie" );
	if( RandomIntRange(0,101) >= 88 )
	{
		player maps\_zombiemode_audio::create_and_play_dialog( "kill", "freeze" );
	}
	anim_len = getanimlength( self.deathanim );
	self thread freezegun_set_extremity_damage_fx();
	self thread freezegun_set_torso_damage_fx();
	shatter_trigger = spawn( "trigger_damage", self.origin, 0, 15, 72 );
	shatter_trigger enablelinkto();
	shatter_trigger linkto( self );
	spawnflags = 1 + 2 + 4 + 16 + 64;
	crumple_trigger = spawn( "trigger_radius", self.origin, spawnflags, 15, 72 );
	crumple_trigger enablelinkto();
	crumple_trigger linkto( self );
	weap = self.damageweapon;
	self thread freezegun_wait_for_shatter( player, weap, shatter_trigger, crumple_trigger );
	self thread freezegun_wait_for_crumple( weap, shatter_trigger, crumple_trigger );
	self endon( "cleanup_freezegun_triggers" );
	wait( anim_len );
	self thread freezegun_do_crumple( weap, shatter_trigger, crumple_trigger );
}
is_freezegun_damage( mod )
{
	return (("MOD_EXPLOSIVE" == mod || "MOD_PROJECTILE" == mod) && IsDefined( self.damageweapon ) && (self.damageweapon == "freezegun_zm" || self.damageweapon == "freezegun_upgraded_zm"));
}
is_freezegun_shatter_damage( mod )
{
	return ("MOD_EXPLOSIVE" == mod && IsDefined( self.damageweapon ) && (self.damageweapon == "freezegun_zm" || self.damageweapon == "freezegun_upgraded_zm"));
}
should_do_freezegun_death( mod )
{
	return is_freezegun_damage( mod );
}
enemy_damaged_by_freezegun()
{
	return 0 < self.freezegun_damage;
}
enemy_percent_damaged_by_freezegun()
{
	return self.freezegun_damage / self.maxhealth;
}
enemy_killed_by_freezegun()
{
	return ( IsDefined( self.freezegun_death ) && self.freezegun_death == true );
}
 