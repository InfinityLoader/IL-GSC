
#include common_scripts\utility;
#include maps\_utility;
#include maps\_zombiemode_utility;
#using_animtree ( "zombie_coast" );
main()
{
	level.flinger_anims = [];
	level.flinger_anims["player_fling_stand_crouch"] = %pb_rifle_stand_flinger_flail;
	level.flinger_anims["player_fling_prone"] = %pb_rifle_prone_flinger_flail;
	level.flinger_animtree = #animtree;
}
init_flinger()
{
	flag_wait("all_players_spawned");
	blocker = getent("flipper_pathblock","targetname");
	blocker connectpaths();
	blocker trigger_off();
	gate = getent("flinger_player_gate","targetname");
	gate notsolid();
	level thread start_flinger_in_open_position();
	level thread flinger_think();
}
start_flinger_in_open_position()
{
	blocker = getent("flipper_pathblock","targetname");
	gate = getent("flinger_player_gate","targetname");
	flinger_trig = getent("flinger_activate","targetname");
	flinger_trig.flipper = getent("flipper","targetname");
	flinger_trig.flipper_closed_struct = getstruct("flipper_closed","targetname");
	flinger_trig.flipper_open_struct = getstruct("flipper_open","targetname");
	flinger_trig.flipper_anchor = spawn("script_origin",flinger_trig.flipper_closed_struct.origin);
	flinger_trig.flipper_anchor.angles = flinger_trig.flipper_closed_struct.angles;
	flinger_trig.flipper linkto(flinger_trig.flipper_anchor);
	angles_dif = flinger_trig.flipper_open_struct.angles - flinger_trig.flipper_closed_struct.angles;
	flinger_trig.flipper_anchor rotatepitch(angles_dif[0] ,.2);
	flag_wait("power_on");
	flag_wait("residence_beach_group");
	wait_for_flinger_area_to_be_clear();
	blocker trigger_on();
	blocker disconnectpaths();
	blocker trigger_off();
	flinger_trig.flipper PlaySound( "zmb_flinger_close" );
	angles_dif = flinger_trig.flipper_closed_struct.angles - flinger_trig.flipper_open_struct.angles;
	flinger_trig.flipper_anchor rotatepitch(angles_dif[0] ,.2);
	wait(.3);
	flinger_trig.flipper unlink();
	flinger_trig.flipper_anchor delete();
	blocker trigger_on();
	blocker connectpaths();
	blocker trigger_off();
	level notify("flinger_in_place");
}
flinger_think()
{
	flag_wait("power_on");
	flag_wait("residence_beach_group");
	level waittill("flinger_in_place");
	flinger_trig = getent("flinger_activate","targetname");
	flinger_poi = getent(flinger_trig.target,"targetname");
	flinger_poi create_zombie_point_of_interest( undefined, 30, 0, false );
	flinger_poi thread create_zombie_point_of_interest_attractor_positions( 4, 45 );
	while(1)
	{
		flinger_trig waittill("trigger",who);
		if( !IsDefined( who ) )
		{
			continue;
		}
		if(isDefined(who.sessionstate) && is_true(who.sessionstate == "spectator"))
		{
			continue;
		}
		flinger_trig.flipper = getent("flipper","targetname");
		flinger_trig.flipper PlaySound( "zmb_flinger_activate" );
		flinger_trig.flipper thread play_delayed_activate_sound();
		wait(2);
		flinger_trig flinger_fling();
		if(isDefined(who))
		{
			who._triggered_flinger = false;
		}
	}
}
play_delayed_activate_sound()
{
	wait(1.9);
	self PlaySound( "zmb_flinger_activate" );
}
flinger_fling()
{
	players_reviving = true;
	while(players_reviving)
	{
		reviving = 0;
		players = get_players();
		for(i = 0; i < players.size; i++)
		{
			if(!isDefined(players[i].revivetrigger))
			{
				continue;
			}
			if(is_true(players[i].revivetrigger.beingRevived ))
			{
				reviving = 1;
			}
		}
		if(!reviving)
		{
			players_reviving = false;
		}
		wait(.5);
	}
	blocker = getent("flipper_pathblock","targetname");
	gate = getent("flinger_player_gate","targetname");
	self.flipper_closed_struct = getstruct("flipper_closed","targetname");
	self.flipper_open_struct = getstruct("flipper_open","targetname");
	self.flipper_anchor = spawn("script_origin",self.flipper_closed_struct.origin);
	self.flipper_anchor.angles = self.flipper_closed_struct.angles;
	self.flipper linkto(self.flipper_anchor);
	angles_dif = self.flipper_open_struct.angles - self.flipper_closed_struct.angles;
	self.flipper_anchor rotatepitch(angles_dif[0] ,.2);
	self.flipper PlaySound( "zmb_flinger_fling_add" );
	self.zombies_flinged = false;
	level thread player_launch(self,gate);
	PlayFX(level._effect["large_ceiling_dust"],self.flipper.origin + (100,0, 0) );
	self thread flipper_second_dust();
	do_flipper_corpse_cleanup(self);
	zombs = GetAIArray();
	for ( i = 0; i < zombs.size; i++ )
	{
		if ( zombs[i] istouching(self) )
		{
			if(isdefined(zombs[i].animname) && zombs[i].animname == "director_zombie")
			{
				zombs[i] thread boss_launch(self);
			}
			else
			{
				zombs[i] thread fling_zombie(getstruct("fling_angles","script_noteworthy").angles );
				self.zombies_flinged = true;
			}
		}
	}
	wait( 2 );
	wait_for_flinger_area_to_be_clear();
	blocker trigger_on();
	blocker disconnectpaths();
	blocker trigger_off();
	self.flipper PlaySound( "zmb_flinger_close" );
	self.zombies_flinged = false;
	angles_dif = self.flipper_closed_struct.angles - self.flipper_open_struct.angles;
	self.flipper_anchor rotatepitch(angles_dif[0] ,.2);
	self notify ("trap_done");
	do_flipper_corpse_cleanup(self);
	self.flipper_anchor waittill("rotatedone");
	self.flipper unlink();
	self.flipper_anchor delete();
	blocker trigger_on();
	blocker connectpaths();
	blocker trigger_off();
}
wait_for_flinger_area_to_be_clear()
{
	area = getent("flinger_check_clear","targetname");
	if(!isDefined(area))
	{
		return;
	}
	area_clear = false;
	while(!area_clear)
	{
		touching = false;
		ai = getaiarray();
		players = get_players();
		for(i=0;i<ai.size;i++)
		{
			if(ai[i] istouching(area))
			{
				touching = true;
			}
		}
		for(i=0;i<players.size;i++)
		{
			if (!isAlive(players[i]) || is_true(players[i].sessionstate == "spectator"))
			{
				continue;
			}
			if(players[i] istouching(area))
			{
				touching = true;
			}
		}
		if(!touching)
		{
			area_clear = true;
		}
		wait(.25);
	}
}
fling_zombie(fling_dir)
{
	self.no_powerups = true;
	self StartRagdoll();
	self setclientflag(level._ZOMBIE_ACTOR_FLAG_LAUNCH_RAGDOLL);
	self PlaySound( "zmb_zombie_flinger_death" );
	wait(.5);
	self dodamage(self.health + 100,self.origin );
	level.zombie_total++;
}
unlink_later(link_ent)
{
	if( isplayer(self))
	{
		self endon("disconnect");
	}
	prevorigin = self.origin;
	wait .15;
	while ( 144 < Distance2DSquared( self.origin, prevorigin ) )
	{
		prevorigin = self.origin;
		wait(.05);
	}
	self Unlink();
	if( isplayer(self))
	{
		self clearclientflag(self.fling_anim);
		wait_network_frame();
		self show();
	}
	self StopLoopSound( .75 );
	self PlaySound( "zmb_player_flinger_land" );
	link_ent delete();
	if( isplayer(self))
	{
		if(!self maps\_laststand::player_is_in_laststand() )
		{
			self decrement_is_drinking();
		}
		self._being_flung = undefined;
		wait(.2);
		if ( self HasPerk( "specialty_flakjacket" ) && self.fling_anim == level._CF_PLAYER_FLINGER_FAKE_PLAYER_SETUP_PRONE)
		{
			self setstance("prone");
			wait(.1);
			self.divetoprone = 1;
			RadiusDamage( self.origin, 40, 5, 5, self, "MOD_FALLING");
			wait_network_frame();
			self.divetoprone = 0;
		}
	}
}
player_launch(flipper_area, gate)
{
	launch_spots = getstructarray("player_launch_spot","targetname");
	players = get_players();
	for(i = 0; i < players.size; i++)
	{
		if(is_true(players[i]._being_flung) || is_true(players[i].sessionstate == "spectator"))
		{
			continue;
		}
		if ( players[i] istouching(flipper_area) || players[i] istouching(gate) )
		{
			players[i] thread fling_player(launch_spots[i]);
		}
	}
}
fling_player(launch_spot)
{
	self endon("death");
	self endon("disconnect");
	players = get_players();
	if(self maps\_laststand::player_is_in_laststand() )
	{
		self.fling_anim = level._CF_PLAYER_FLINGER_FAKE_PLAYER_SETUP_PRONE;
	}
	else if( self GetStance() == "prone")
	{
		self setclientflag(level._CF_PLAYER_FLINGER_FAKE_PLAYER_SETUP_PRONE);
		self.fling_anim = level._CF_PLAYER_FLINGER_FAKE_PLAYER_SETUP_PRONE;
	}
	else
	{
		self setclientflag(level._CF_PLAYER_FLINGER_FAKE_PLAYER_SETUP_STAND);
		self.fling_anim = level._CF_PLAYER_FLINGER_FAKE_PLAYER_SETUP_STAND;
	}
	if(!is_true( self.has_powerup_weapon))
	{
		weap = self getcurrentweapon();
		if(is_placeable_mine(weap) || self isswitchingweapons() )
		{
			primaryWeapons = self GetWeaponsListPrimaries();
			if( IsDefined( primaryWeapons ) && primaryWeapons.size > 0 )
			{
				self SwitchToWeapon( primaryWeapons[0] );
			}
		}
	}
	self maps\_zombiemode_audio::create_and_play_dialog( "catapult", "self" );
	self._being_flung = true;
	self hide();
	self Allowstand(true);
	self allowcrouch(true);
	self allowprone(true);
	self PlayLoopSound( "zmb_player_flinger_airrush", .25 );
	if(!is_true( self.has_powerup_weapon))
	{
		weap = self getcurrentweapon();
		if(is_placeable_mine(weap) || self isswitchingweapons() )
		{
			primaryWeapons = self GetWeaponsListPrimaries();
			if( IsDefined( primaryWeapons ) && primaryWeapons.size > 0 )
			{
				self SwitchToWeapon( primaryWeapons[0] );
			}
		}
	}
	if(!self maps\_laststand::player_is_in_laststand())
	{
		self increment_is_drinking();
	}
	wait_network_frame();
	org1 = spawn ("script_origin", self.origin + (0,0,20) );
	self PlayerLinkTo ( org1 );
	org1 Fake_PhysicsLaunch ( launch_spot.origin, randomintrange(890,920));
	self thread unlink_later(org1 );
	all_players_flung = true;
	for(x = 0; x < players.size; x++)
	{
		if(!is_true(players[x]._being_flung))
		{
			all_players_flung = false;
		}
	}
	if(all_players_flung)
	{
		flinger_trig = getent("flinger_activate","targetname");
		flinger_poi = getent(flinger_trig.target,"targetname");
		flinger_poi activate_zombie_point_of_interest();
		flinger_poi thread wait_for_flung_players_to_land();
	}
}
wait_for_flung_players_to_land()
{
	players_landed = false;
	while(!players_landed)
	{
		players = get_players();
		for(i=0;i<players.size;i++)
		{
			if(!is_true(players[i]._being_flung))
			{
				players_landed = true;
			}
		}
		wait(.2);
	}
	self deactivate_zombie_point_of_interest();
}
boss_launch(flipper_area)
{
	launch_spots = getstructarray("engineer_launch_spot","targetname");
	if ( self istouching(flipper_area) )
	{
		dest = random( launch_spots );
		wait_network_frame();
		if ( isDefined( self.flinger_func ) )
		{
			self thread [[ self.flinger_func ]]( dest.origin );
		}
		org1 = spawn ("script_origin", self.origin );
		self Linkto ( org1 );
		org1 Fake_PhysicsLaunch ( dest.origin, 900 );
		self thread unlink_later(org1 );
	}
}
flipper_second_dust()
{
	wait( 0.2 );
	PlayFX(level._effect["rise_dust"],self.flipper.origin + (-100,0,0) );
}
do_flipper_corpse_cleanup(area)
{
	corpses = GetCorpseArray();
	if(IsDefined(corpses))
	{
		for ( i = 0; i < corpses.size; i++ )
		{
			if( corpses[i] istouching(area) )
			{
				corpses[i] thread remove_corpse();
			}
		}
	}
}
remove_corpse()
{
	PlayFX(level._effect[ "corpse_burst" ]	, self.origin);
	self Delete();
}	
















































































 