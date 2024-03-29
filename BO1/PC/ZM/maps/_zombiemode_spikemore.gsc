#include common_scripts\utility;
#include maps\_utility;
#include maps\_zombiemode_utility;
init()
{
	level.spikemore_detonate_radius = 96.0;
	level.spikemore_fire_radius = 200.0;
	level.spikemore_projectile_damage = 1500;
	level.spikemore_projectile_speed = 1500;
	level thread _update_spikemore_fires();
	PrecacheItem("spikemore_zm");
	PrecacheModel("t5_weapon_bamboo_spear_spikemore_small");
	trigs = getentarray("spikemore_purchase","targetname");
	for(i=0; i<trigs.size; i++)
	{
		model = getent( trigs[i].target, "targetname" );
		model hide();
	}
	array_thread(trigs,::buy_spikemores);
	level thread give_spikemores_after_rounds();
	level.pickup_spikemores = ::pickup_spikemores;
	level.pickup_spikemores_trigger_listener = ::pickup_spikemores_trigger_listener;
	level.spikemore_detectionDot = cos( 70 );
	level.spikemore_detectionMinDist = 20;
	maps\_zombiemode_utility::register_placeable_mine_for_level("spikemore_zm");
	level._CF_SCRIPTMOVER_CLIENT_FLAG_SPIKEMORE = 5;
	level._spikeable_objects = [];
	maps\_weaponobjects::create_retrievable_hint( "spikemore", &"ZOMBIE_TEMPLE_WEAPON_SPIKEMORE_PICKUP");
	level.create_level_specific_weaponobject_watchers = ::create_spikemore_watcher_zm;
}
create_spikemore_watcher_zm()
{
	watcher = self maps\_weaponobjects::create_use_weapon_object_watcher( "spikemore", "spikemore_zm", self.team );
	watcher.pickup = level.pickup_spikemores;
	watcher.pickup_trigger_listener = level.pickup_spikemores_trigger_listener;
	watcher.skip_weapon_object_damage = true;
}
add_spikeable_object(ent)
{
	level._spikeable_objects = add_to_array(level._spikeable_objects, ent, false);
}
remove_spikeable_object(ent)
{
	level._spikeable_objects = array_remove(level._spikeable_objects, ent);
}
buy_spikemores()
{
	self.zombie_cost = 1000;
	self sethintstring( &"ZOMBIE_TEMPLE_SPIKEMORE_PURCHASE" );
	self setCursorHint( "HINT_NOICON" );
	level thread set_spikemore_visible();
	self.spikemores_triggered = false;
	while(1)
	{
		self waittill("trigger",who);
		if( who in_revive_trigger() )
		{
			continue;
		}
		if( who has_powerup_weapon() )
		{
			wait( 0.1 );
			continue;
		}
		if( is_player_valid( who ) )
		{
			if( who.score >= self.zombie_cost )
			{
				if ( !who is_player_placeable_mine( "spikemore_zm" ) )
				{
					play_sound_at_pos( "purchase", self.origin );
					who maps\_zombiemode_score::minus_to_player_score( self.zombie_cost );
					who maps\_zombiemode_weapons::check_collector_achievement( "spikemore_zm" );
					who thread spikemore_setup();
					who thread show_spikemore_hint("spikemore_purchased");
					who thread maps\_zombiemode_audio::create_and_play_dialog( "weapon_pickup", "spikemore" );
					if( self.spikemores_triggered == false )
					{
						model = getent( self.target, "targetname" );
						model thread maps\_zombiemode_weapons::weapon_show( who );
						self.spikemores_triggered = true;
					}
					trigs = getentarray("spikemore_purchase","targetname");
					for(i = 0; i < trigs.size; i++)
					{
						trigs[i] SetInvisibleToPlayer(who);
					}
				}
				else
				{
					who thread show_spikemore_hint("already_purchased");
				}
			}
			else
			{
				who maps\_zombiemode_audio::create_and_play_dialog( "general", "no_money", undefined, 1 );
			}
		}
	}
}
set_spikemore_visible()
{
	players = getplayers();
	trigs = getentarray("spikemore_purchase","targetname");
	while(1)
	{
		for(j = 0; j < players.size; j++)
		{
			if( !players[j] is_player_placeable_mine( "spikemore_zm" ) )
			{
				for(i = 0; i < trigs.size; i++)
				{
					trigs[i] SetInvisibleToPlayer(players[j], false);
				}
			}
		}
		wait(1);
		players = getplayers();
	}
}
spikemore_watch()
{
	self endon("death");
	while(1)
	{
		self waittill("grenade_fire",spikemore,weapname);
		if(weapname == "spikemore_zm")
		{
			spikemore.owner = self;
			if ( is_true( self.is_on_minecart ) )
			{
				spikemore maps\_zombiemode_spikemore::_spikemore_SmallSpearActivate();
			}
			else
			{
				spikemore thread spikemore_detonation();
			}
			self notify( "zmb_enable_spikemore_prompt" );
		}
	}
}
spikemore_setup()
{
	self thread spikemore_watch();
	self giveweapon("spikemore_zm");
	self set_player_placeable_mine("spikemore_zm");
	self setactionslot(4,"weapon","spikemore_zm");
	self setweaponammostock("spikemore_zm",4);
}
pickup_spikemores()
{
	player = self.owner;
	if ( !player hasweapon( "spikemore_zm" ) )
	{
		player thread spikemore_watch();
		player giveweapon("spikemore_zm");
		player set_player_placeable_mine("spikemore_zm");
		player setactionslot(4,"weapon","spikemore_zm");
		player setweaponammoclip("spikemore_zm",0);
		player notify( "zmb_enable_spikemore_prompt" );
	}
	else
	{
		clip_ammo = player GetWeaponAmmoClip( self.name );
		clip_max_ammo = WeaponClipSize( self.name );
		if ( clip_ammo >= clip_max_ammo )
		{
			player notify( "zmb_disable_spikemore_prompt" );
			return;
		}
	}
	self maps\_weaponobjects::pick_up();
	clip_ammo = player GetWeaponAmmoClip( self.name );
	clip_max_ammo = WeaponClipSize( self.name );
	if ( clip_ammo >= clip_max_ammo )
	{
		player notify( "zmb_disable_spikemore_prompt" );
	}
}
pickup_spikemores_trigger_listener( trigger, player )
{
	self thread pickup_spikemores_trigger_listener_enable( trigger, player );
	self thread pickup_spikemores_trigger_listener_disable( trigger, player );
}
pickup_spikemores_trigger_listener_enable( trigger, player )
{
	self endon( "delete" );
	self endon( "death" );
	while ( true )
	{
		player waittill_any( "zmb_enable_spikemore_prompt", "spawned_player" );
		if ( !isDefined( trigger ) )
		{
			return;
		}
		trigger trigger_on();
		trigger linkto( self );
	}
}
pickup_spikemores_trigger_listener_disable( trigger, player )
{
	self endon( "delete" );
	self endon( "death" );
	while ( true )
	{
		player waittill( "zmb_disable_spikemore_prompt" );
		if ( !isDefined( trigger ) )
		{
			return;
		}
		trigger unlink();
		trigger trigger_off();
	}
}
shouldAffectWeaponObject( object )
{
	pos = self.origin + (0,0,32);
	dirToPos = pos - object.origin;
	objectForward = anglesToForward( object.angles );
	dist = vectorDot( dirToPos, objectForward );
	if ( dist < level.spikemore_detectionMinDist )
		return false;
	dirToPos = vectornormalize( dirToPos );
	dot = vectorDot( dirToPos, objectForward );
	return ( dot > level.spikemore_detectionDot );
}
spikemore_detonation()
{
	self endon("death");
	self waittill_not_moving();
	detonateRadius = 96;
	spawnFlag = 1;
	playerTeamToAllow = "axis";
	if( isDefined( self.owner ) && isDefined( self.owner.pers["team"] ) && self.owner.pers["team"] == "axis" )
	{
		spawnFlag = 2;
		playerTeamToAllow = "allies";
	}
	damagearea = spawn("trigger_radius", self.origin + (0,0,0-detonateRadius), spawnFlag, detonateRadius, detonateRadius*2);
	damagearea enablelinkto();
	damagearea linkto( self );
	self thread delete_spikemores_on_death( damagearea );
	if(!isdefined(level.spikemores))
		level.spikemores = [];
	level.spikemores = array_add( level.spikemores, self );
	if( level.spikemores.size > 15 && GetDvar( #"player_sustainAmmo") != "0" )
		level.spikemores[0] delete();
	while(1)
	{
		damagearea waittill( "trigger", ent );
		if ( isdefined( self.owner ) && ent == self.owner )
			continue;
		if( isDefined( ent.pers ) && isDefined( ent.pers["team"] ) && ent.pers["team"] != playerTeamToAllow )
			continue;
		if ( !ent shouldAffectWeaponObject( self ) )
			continue;
		if ( ent damageConeTrace(self.origin, self) > 0 )
		{
			self _spikemore_SmallSpearActivate();
			return;
		}
	}
}
delete_spikemores_on_death(ent)
{
	self waittill("death");
	level.spikemores = array_remove_nokeys( level.spikemores, self );
	wait .05;
	if ( isdefined( ent ) )
		ent delete();
}
give_spikemores_after_rounds()
{
	while(1)
	{
		level waittill( "between_round_over" );
		{
			players = get_players();
			for(i=0;i<players.size;i++)
			{
				if ( players[i] is_player_placeable_mine( "spikemore_zm" ) )
				{
					players[i] giveweapon("spikemore_zm");
					players[i] set_player_placeable_mine("spikemore_zm");
					players[i] setactionslot(4,"weapon","spikemore_zm");
					players[i] setweaponammoclip("spikemore_zm",2);
				}
			}
		}
	}
}
init_hint_hudelem(x, y, alignX, alignY, fontscale, alpha)
{
	self.x = x;
	self.y = y;
	self.alignX = alignX;
	self.alignY = alignY;
	self.fontScale = fontScale;
	self.alpha = alpha;
	self.sort = 20;
}
setup_client_hintelem()
{
	self endon("death");
	self endon("disconnect");
	if(!isDefined(self.hintelem))
	{
		self.hintelem = newclienthudelem(self);
	}
	self.hintelem init_hint_hudelem(320, 220, "center", "bottom", 1.6, 1.0);
}
show_spikemore_hint(string)
{
	self endon("death");
	self endon("disconnect");
	if(string == "spikemore_purchased")
	{
		text = &"ZOMBIE_TEMPLE_SPIKEMORE_HOWTO";
	}
	else
	{
		text = &"ZOMBIE_TEMPLE_SPIKEMORE_ALREADY_PURCHASED";
	}
	self setup_client_hintelem();
	self.hintelem setText(text);
	wait(3.5);
	self.hintelem settext("");
}
_getZombiesInRange(range)
{
	ret = [];
	range2 = range * range;
	zombies = GetAiArray("axis");
	zombies = array_merge(zombies, level._spikeable_objects);
	for ( i = 0; i < zombies.size; i++ )
	{
		checkDist2 = DistanceSquared( zombies[i].origin, self.origin );
		if ( checkDist2 < range2 )
		{
			zombie = zombies[i];
			if ( is_true(zombie.nuked) || is_true(zombie.marked_for_death) || (IsAI(zombie) && zombie.health <= 0) )
			{
				continue;
			}
			ret[ret.size] = zombie;
		}
	}
	return ret;
}
_spikemore_TargetInFOV( target )
{
	toTarget = target.origin - self.origin;
	toTarget = (toTarget[0], toTarget[1], 0.0);
	toTarget = VectorNormalize(toTarget);
	forward = AnglesToForward( (0.0, self.angles[1], 0.0) );
	dot = VectorDot( toTarget, forward );
	return dot >= level.spikemore_detectionDot;
}
_spikemore_filterTargetsByFOV( targets )
{
	ret = [];
	for ( i = 0; i < targets.size; i++ )
	{
		if ( self _spikemore_TargetInFOV(targets[i]) )
		{
			ret[ret.size] = targets[i];
		}
	}
	return ret;
}
_spikemore_SmallSpearActivate()
{
	_wait_to_fire_spikemore();
	targets = self _getZombiesInRange(level.spikemore_fire_radius);
	targets = self _spikemore_FilterTargetsByFOV(targets);
	if ( !IsDefined( targets ) )
	{
		targets = [];
	}
	self _spikemore_SmallSpearDetonate(targets);
	self Delete();
}
_spikemore_SmallSpearDetonate(targets)
{
	self playsound ("claymore_activated_SP");
	wait 0.4;
	self SetClientFlag( level._CF_SCRIPTMOVER_CLIENT_FLAG_SPIKEMORE );
	self playsound( "wpn_spikemore_exp" );
	for ( i = 0; i < targets.size; i++ )
	{
		if(IsAI(targets[i]))
		{
			targets[i] thread _spikemore_damage(self.origin, self.owner);
		}
		else
		{
			targets[i] notify("spiked", self.owner);
		}
	}
	wait(0.1);
}
_spikemore_damage(fromOrigin, fromOwner)
{
	numSpikes = 2;
	if ( RandomInt(10) == 0 )
	{
		numSpikes++;
	}
	zombieDamage = level.spikemore_projectile_damage * numSpikes;
	dist = Distance(fromOrigin, self.origin);
	time = dist / level.spikemore_projectile_speed;
	wait(time);
	if(self.animname != "napalm_zombie")
	{
		self.no_gib = true;
		if( randomintrange(0,101) <= 75 )
		{
			fromOwner thread maps\_zombiemode_audio::create_and_play_dialog( "kill", "spikemore" );
		}
		self DoDamage( zombieDamage, fromOrigin, fromOwner, -1, "projectile", "torso_upper" );
		self SetClientFlag( level._CF_ACTOR_CLIENT_FLAG_SPIKEMORE );
	}
}
_update_spikemore_fires()
{
	while ( true )
	{
		level.hasSpikemoreFiredRecently = false;
		wait(0.2);
	}
}
_wait_to_fire_spikemore()
{
	while ( level.hasSpikemoreFiredRecently )
	{
		wait_network_frame();
	}
	level.hasSpikemoreFiredRecently = true;
}
 