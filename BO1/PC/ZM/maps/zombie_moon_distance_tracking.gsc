#include common_scripts\utility;
#include maps\_utility;
#include maps\_zombiemode_utility;
zombie_tracking_init()
{
	flag_wait( "all_players_connected" );
	while(true)
	{
		zombies = GetAIArray("axis");
		if(!IsDefined(zombies) || level.on_the_moon == false || is_true(level.ignore_distance_tracking))
		{
			wait( 10.0 );
			continue;
		}
		else
		{
			for (i = 0; i < zombies.size; i++)
			{
				if( IsDefined( zombies[i] ) && !is_true( zombies[i].ignore_distance_tracking ) )
				{
					zombies[i] thread delete_zombie_noone_looking(1500);
				}
			}
		}
		wait(10);
	}
}
delete_zombie_noone_looking(how_close)
{
	self endon( "death" );
	if ( is_true( self.ignore_distance_tracking ) )
	{
		return;
	}
	if(!IsDefined(how_close))
	{
		how_close = 1000;
	}
	self.inview = 0;
	self.player_close = 0;
	players = getplayers();
	for ( i = 0; i < players.size; i++ )
	{
		if(players[i].sessionstate == "spectator")
		{
			continue;
		}
		can_be_seen = self player_can_see_me(players[i]);
		if(can_be_seen)
		{
			self.inview++;
		}
		else
		{
			dist = Distance(self.origin, players[i].origin);
			if(dist < how_close)
			{
				self.player_close++;
			}
		}
	}
	wait_network_frame();
	if(self.inview == 0 && self.player_close == 0 )
	{
		if(!IsDefined(self.animname) || (IsDefined(self.animname) && self.animname != "zombie"))
		{
			return;
		}
		if(IsDefined(self.electrified) && self.electrified == true)
		{
			return;
		}
		if(self.health != level.zombie_health)
		{
			return;
		}
		else
		{
			if(IsDefined(self.in_the_ground) && self.in_the_ground == true)
			{
				return;
			}
			level.zombie_total++;
			self maps\_zombiemode_spawner::reset_attack_spot();
			self notify("zombie_delete");
			self Delete();
		}
	}
}
player_can_see_me( player )
{
	playerAngles = player getplayerangles();
	playerForwardVec = AnglesToForward( playerAngles );
	playerUnitForwardVec = VectorNormalize( playerForwardVec );
	banzaiPos = self.origin;
	playerPos = player GetOrigin();
	playerToBanzaiVec = banzaiPos - playerPos;
	playerToBanzaiUnitVec = VectorNormalize( playerToBanzaiVec );
	forwardDotBanzai = VectorDot( playerUnitForwardVec, playerToBanzaiUnitVec );
	angleFromCenter = ACos( forwardDotBanzai );
	playerFOV = GetDvarFloat( #"cg_fov" );
	banzaiVsPlayerFOVBuffer = GetDvarFloat( #"g_banzai_player_fov_buffer" );
	if ( banzaiVsPlayerFOVBuffer <= 0 )
	{
		banzaiVsPlayerFOVBuffer = 0.2;
	}
	playerCanSeeMe = ( angleFromCenter <= ( playerFOV * 0.5 * ( 1 - banzaiVsPlayerFOVBuffer ) ) );
	return playerCanSeeMe;
} 