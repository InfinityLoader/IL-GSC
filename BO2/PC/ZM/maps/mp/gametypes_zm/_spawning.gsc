/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes_zm\_spawning.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 49
 * Decompile Time: 162 ms
 * Timestamp: 10/27/2023 3:02:43 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/gametypes_zm/_spawnlogic;

//Function Number: 1
init()
{
	if(!(IsDefined(level.gamemodespawndvars)))
	{
		level.gamemodespawndvars = ::default_gamemodespawndvars;
	}

	level init_spawn_system();
	level.recently_deceased = [];
	foreach(team in level.teams)
	{
		level.recently_deceased[team] = spawn_array_struct();
	}

	level thread onplayerconnect();
	if(GetDvar(#"AD6C19FE") == "")
	{
		level.spawn_visibility_check_max = 20;
	}
	else
	{
		level.spawn_visibility_check_max = GetDvarInt(#"AD6C19FE");
	}

	level.spawnprotectiontime = getgametypesetting("spawnprotectiontime");
/#
	setdvar("scr_debug_spawn_player","");
	setdvar("scr_debug_render_spawn_data","1");
	setdvar("scr_debug_render_snapshotmode","0");
	setdvar("scr_spawn_point_test_mode","0");
	level.test_spawn_point_index = 0;
	setdvar("scr_debug_render_spawn_text","1");
#/
}

//Function Number: 2
default_gamemodespawndvars(reset_dvars)
{
}

//Function Number: 3
init_spawn_system()
{
	level.spawnsystem = spawnstruct();
	spawnsystem = level.spawnsystem;
	level get_player_spawning_dvars(1);
	level thread initialize_player_spawning_dvars();
	spawnsystem.einfluencer_shape_sphere = 0;
	spawnsystem.einfluencer_shape_cylinder = 1;
	spawnsystem.einfluencer_type_normal = 0;
	spawnsystem.einfluencer_type_player = 1;
	spawnsystem.einfluencer_type_weapon = 2;
	spawnsystem.einfluencer_type_dog = 3;
	spawnsystem.einfluencer_type_vehicle = 4;
	spawnsystem.einfluencer_type_game_mode = 6;
	spawnsystem.einfluencer_type_enemy_spawned = 7;
	spawnsystem.einfluencer_curve_constant = 0;
	spawnsystem.einfluencer_curve_linear = 1;
	spawnsystem.einfluencer_curve_steep = 2;
	spawnsystem.einfluencer_curve_inverse_linear = 3;
	spawnsystem.einfluencer_curve_negative_to_positive = 4;
	spawnsystem.ispawn_teammask = [];
	spawnsystem.ispawn_teammask_free = 1;
	spawnsystem.ispawn_teammask["free"] = spawnsystem.ispawn_teammask_free;
	all = spawnsystem.ispawn_teammask_free;
	count = 1;
	foreach(team in level.teams)
	{
		spawnsystem.ispawn_teammask[team] = 1 << count;
		all = all | spawnsystem.ispawn_teammask[team];
		count++;
	}

	spawnsystem.ispawn_teammask["all"] = all;
}

//Function Number: 4
onplayerconnect()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("connecting",player);
		player setentertime(GetTime());
		player thread onplayerspawned();
		player thread ondisconnect();
		player thread onteamchange();
		player thread ongrenadethrow();
	}
}

//Function Number: 5
onplayerspawned()
{
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("spawned_player");
		self thread initialspawnprotection("specialty_nottargetedbyairsupport",1);
		self thread initialspawnprotection("specialty_nokillstreakreticle",0);
		self thread initialspawnprotection("specialty_nottargettedbysentry",0);
		if(IsDefined(self.pers["hasRadar"]) && self.pers["hasRadar"])
		{
			self.hasspyplane = 1;
		}

		self enable_player_influencers(1);
		self thread ondeath();
	}
}

//Function Number: 6
ondeath()
{
	self endon("disconnect");
	level endon("game_ended");
	self waittill("death");
	self enable_player_influencers(0);
	self create_body_influencers();
}

//Function Number: 7
onteamchange()
{
	self endon("disconnect");
	level endon("game_ended");
	while(1)
	{
		self waittill("joined_team");
		self player_influencers_set_team();
		wait(0.05);
	}
}

//Function Number: 8
ongrenadethrow()
{
	self endon("disconnect");
	level endon("game_ended");
	while(1)
	{
		self waittill("grenade_fire",grenade,weaponname);
		level thread create_grenade_influencers(self.pers["team"],weaponname,grenade);
		wait(0.05);
	}
}

//Function Number: 9
ondisconnect()
{
	level endon("game_ended");
	self waittill("disconnect");
}

//Function Number: 10
get_score_curve_index(curve)
{
	switch(curve)
	{
		case "linear":
			return level.spawnsystem.einfluencer_curve_linear;

		case "steep":
			return level.spawnsystem.einfluencer_curve_steep;

		case "inverse_linear":
			return level.spawnsystem.einfluencer_curve_linear;

		case "negative_to_positive":
			return level.spawnsystem.einfluencer_curve_negative_to_positive;

		case "constant":
		default:
			return level.spawnsystem.einfluencer_curve_constant;
	}
}

//Function Number: 11
get_influencer_type_index(curve)
{
}

//Function Number: 12
create_player_influencers()
{
/#
	assert(!IsDefined(self.influencer_enemy_sphere));
#/
/#
	assert(!IsDefined(self.influencer_weapon_cylinder));
#/
/#
	assert(!level.teambased || !IsDefined(self.influencer_friendly_sphere));
#/
/#
	assert(!level.teambased || !IsDefined(self.influencer_friendly_cylinder));
#/
	if(!(level.teambased))
	{
		team_mask = level.spawnsystem.ispawn_teammask_free;
		other_team_mask = level.spawnsystem.ispawn_teammask_free;
		weapon_team_mask = level.spawnsystem.ispawn_teammask_free;
	}
	else if(IsDefined(self.pers["team"]))
	{
		team = self.pers["team"];
		team_mask = getteammask(team);
		other_team_mask = getotherteamsmask(team);
		weapon_team_mask = getotherteamsmask(team);
	}
	else
	{
		team_mask = 0;
		other_team_mask = 0;
		weapon_team_mask = 0;
	}

	if(level.hardcoremode)
	{
		weapon_team_mask = weapon_team_mask | team_mask;
	}

	angles = self.angles;
	origin = self.origin;
	up = (0,0,1);
	forward = (1,0,0);
	cylinder_forward = up;
	cylinder_up = forward;
	self.influencer_enemy_sphere = addsphereinfluencer(level.spawnsystem.einfluencer_type_player,origin,level.spawnsystem.enemy_influencer_radius,level.spawnsystem.enemy_influencer_score,other_team_mask,"enemy,r,s",get_score_curve_index(level.spawnsystem.enemy_influencer_score_curve),0,self);
	if(level.teambased)
	{
		cylinder_up = -1 * forward;
		self.influencer_friendly_sphere = addsphereinfluencer(level.spawnsystem.einfluencer_type_player,origin,level.spawnsystem.friend_weak_influencer_radius,level.spawnsystem.friend_weak_influencer_score,team_mask,"friend_weak,r,s",get_score_curve_index(level.spawnsystem.friend_weak_influencer_score_curve),0,self);
	}

	self.spawn_influencers_created = 1;
	if(!IsDefined(self.pers["team"]) || self.pers["team"] == "spectator")
	{
		self enable_player_influencers(0);
	}
}

//Function Number: 13
remove_player_influencers()
{
	if(level.teambased && IsDefined(self.influencer_friendly_sphere))
	{
		removeinfluencer(self.influencer_friendly_sphere);
		self.influencer_friendly_sphere = undefined;
	}

	if(level.teambased && IsDefined(self.influencer_friendly_cylinder))
	{
		removeinfluencer(self.influencer_friendly_cylinder);
		self.influencer_friendly_cylinder = undefined;
	}

	if(IsDefined(self.influencer_enemy_sphere))
	{
		removeinfluencer(self.influencer_enemy_sphere);
		self.influencer_enemy_sphere = undefined;
	}

	if(IsDefined(self.influencer_weapon_cylinder))
	{
		removeinfluencer(self.influencer_weapon_cylinder);
		self.influencer_weapon_cylinder = undefined;
	}
}

//Function Number: 14
enable_player_influencers(enabled)
{
	if(!(IsDefined(self.spawn_influencers_created)))
	{
		self create_player_influencers();
	}

	if(IsDefined(self.influencer_friendly_sphere))
	{
		enableinfluencer(self.influencer_friendly_sphere,enabled);
	}

	if(IsDefined(self.influencer_friendly_cylinder))
	{
		enableinfluencer(self.influencer_friendly_cylinder,enabled);
	}

	if(IsDefined(self.influencer_enemy_sphere))
	{
		enableinfluencer(self.influencer_enemy_sphere,enabled);
	}

	if(IsDefined(self.influencer_weapon_cylinder))
	{
		enableinfluencer(self.influencer_weapon_cylinder,enabled);
	}
}

//Function Number: 15
player_influencers_set_team()
{
	if(!(level.teambased))
	{
		team_mask = level.spawnsystem.ispawn_teammask_free;
		other_team_mask = level.spawnsystem.ispawn_teammask_free;
		weapon_team_mask = level.spawnsystem.ispawn_teammask_free;
	}
	else
	{
		team = self.pers["team"];
		team_mask = getteammask(team);
		other_team_mask = getotherteamsmask(team);
		weapon_team_mask = getotherteamsmask(team);
	}

	if(level.friendlyfire != 0 && level.teambased)
	{
		weapon_team_mask = weapon_team_mask | team_mask;
	}

	if(IsDefined(self.influencer_friendly_sphere))
	{
		setinfluencerteammask(self.influencer_friendly_sphere,team_mask);
	}

	if(IsDefined(self.influencer_friendly_cylinder))
	{
		setinfluencerteammask(self.influencer_friendly_cylinder,team_mask);
	}

	if(IsDefined(self.influencer_enemy_sphere))
	{
		setinfluencerteammask(self.influencer_enemy_sphere,other_team_mask);
	}

	if(IsDefined(self.influencer_weapon_cylinder))
	{
		setinfluencerteammask(self.influencer_weapon_cylinder,weapon_team_mask);
	}
}

//Function Number: 16
create_body_influencers()
{
	if(level.teambased)
	{
		team_mask = getteammask(self.pers["team"]);
	}
	else
	{
		team_mask = level.spawnsystem.ispawn_teammask_free;
	}

	addsphereinfluencer(level.spawnsystem.einfluencer_type_normal,self.origin,level.spawnsystem.dead_friend_influencer_radius,level.spawnsystem.dead_friend_influencer_score,team_mask,"dead_friend,r,s",get_score_curve_index(level.spawnsystem.dead_friend_influencer_score_curve),level.spawnsystem.dead_friend_influencer_timeout_seconds);
}

//Function Number: 17
create_grenade_influencers(parent_team,weaponname,grenade)
{
	pixbeginevent("create_grenade_influencers");
	if(!(level.teambased))
	{
		weapon_team_mask = level.spawnsystem.ispawn_teammask_free;
	}
	else
	{
		weapon_team_mask = getotherteamsmask(parent_team);
		if(level.friendlyfire)
		{
			weapon_team_mask = weapon_team_mask | getteammask(parent_team);
		}
	}

	if(issubstr(weaponname,"napalmblob") || issubstr(weaponname,"gl_"))
	{
		pixendevent();
		return;
	}

	timeout = 0;
	if(weaponname == "tabun_gas_mp")
	{
		timeout = 7;
	}

	if(IsDefined(grenade.origin))
	{
		if(weaponname == "claymore_mp" || weaponname == "bouncingbetty_mp")
		{
			addsphereinfluencer(level.spawnsystem.einfluencer_type_normal,grenade.origin,level.spawnsystem.claymore_influencer_radius,level.spawnsystem.claymore_influencer_score,weapon_team_mask,"claymore,r,s",get_score_curve_index(level.spawnsystem.claymore_influencer_score_curve),timeout,grenade);
		}
		else
		{
			addsphereinfluencer(level.spawnsystem.einfluencer_type_normal,grenade.origin,level.spawnsystem.grenade_influencer_radius,level.spawnsystem.grenade_influencer_score,weapon_team_mask,"grenade,r,s",get_score_curve_index(level.spawnsystem.grenade_influencer_score_curve),timeout,grenade);
		}
	}

	pixendevent();
}

//Function Number: 18
create_napalm_fire_influencers(point,direction,parent_team,duration)
{
	timeout = duration;
	weapon_team_mask = 0;
	offset = VectorScale(AnglesToForward(direction));
	addsphereinfluencer(level.spawnsystem.einfluencer_type_normal,point + 2 * offset,level.spawnsystem.napalm_influencer_radius,level.spawnsystem.napalm_influencer_score,weapon_team_mask,"napalm,r,s",get_score_curve_index(level.spawnsystem.napalm_influencer_score_curve),timeout);
	addsphereinfluencer(level.spawnsystem.einfluencer_type_normal,point + offset,level.spawnsystem.napalm_influencer_radius,level.spawnsystem.napalm_influencer_score,weapon_team_mask,"napalm,r,s",get_score_curve_index(level.spawnsystem.napalm_influencer_score_curve),timeout);
	addsphereinfluencer(level.spawnsystem.einfluencer_type_normal,point,level.spawnsystem.napalm_influencer_radius,level.spawnsystem.napalm_influencer_score,weapon_team_mask,"napalm,r,s",get_score_curve_index(level.spawnsystem.napalm_influencer_score_curve),timeout);
	addsphereinfluencer(level.spawnsystem.einfluencer_type_normal,point - offset,level.spawnsystem.napalm_influencer_radius,level.spawnsystem.napalm_influencer_score,weapon_team_mask,"napalm,r,s",get_score_curve_index(level.spawnsystem.napalm_influencer_score_curve),timeout);
}

//Function Number: 19
create_auto_turret_influencer(point,parent_team,angles)
{
	if(!(level.teambased))
	{
		weapon_team_mask = level.spawnsystem.ispawn_teammask_free;
	}
	else
	{
		weapon_team_mask = getotherteamsmask(parent_team);
	}

	projected_point = level.spawnsystem.auto_turret_influencer_radius * 0.7 + VectorScale(AnglesToForward(angles));
	influencerid = addsphereinfluencer(level.spawnsystem.einfluencer_type_normal,projected_point,level.spawnsystem.auto_turret_influencer_radius,level.spawnsystem.auto_turret_influencer_score,weapon_team_mask,"auto_turret,r,s",get_score_curve_index(level.spawnsystem.auto_turret_influencer_score_curve));
	return influencerid;
}

//Function Number: 20
create_dog_influencers()
{
	if(!(level.teambased))
	{
		dog_enemy_team_mask = level.spawnsystem.ispawn_teammask_free;
	}
	else
	{
		dog_enemy_team_mask = getotherteamsmask(self.aiteam);
	}

	addsphereinfluencer(level.spawnsystem.einfluencer_type_dog,self.origin,level.spawnsystem.dog_influencer_radius,level.spawnsystem.dog_influencer_score,dog_enemy_team_mask,"dog,r,s",get_score_curve_index(level.spawnsystem.dog_influencer_score_curve),0,self);
}

//Function Number: 21
create_helicopter_influencers(parent_team)
{
	if(!(level.teambased))
	{
		team_mask = level.spawnsystem.ispawn_teammask_free;
	}
	else
	{
		team_mask = getotherteamsmask(parent_team);
	}

	self.influencer_helicopter_cylinder = addcylinderinfluencer(level.spawnsystem.einfluencer_type_normal,self.origin,(0,0,0),(0,0,0),level.spawnsystem.helicopter_influencer_radius,level.spawnsystem.helicopter_influencer_length,level.spawnsystem.helicopter_influencer_score,team_mask,"helicopter,r,s",get_score_curve_index(level.spawnsystem.helicopter_influencer_score_curve),0,self);
}

//Function Number: 22
remove_helicopter_influencers()
{
	if(IsDefined(self.influencer_helicopter_cylinder))
	{
		removeinfluencer(self.influencer_helicopter_cylinder);
	}

	self.influencer_helicopter_cylinder = undefined;
}

//Function Number: 23
create_tvmissile_influencers(parent_team)
{
	if(!level.teambased || is_hardcore())
	{
		team_mask = level.spawnsystem.ispawn_teammask_free;
	}
	else
	{
		team_mask = getotherteamsmask(parent_team);
	}

	self.influencer_tvmissile_cylinder = addcylinderinfluencer(level.spawnsystem.einfluencer_type_normal,self.origin,(0,0,0),(0,0,0),level.spawnsystem.tvmissile_influencer_radius,level.spawnsystem.tvmissile_influencer_length,level.spawnsystem.tvmissile_influencer_score,team_mask,"tvmissile,r,s",get_score_curve_index(level.spawnsystem.tvmissile_influencer_score_curve),0,self);
}

//Function Number: 24
remove_tvmissile_influencers()
{
	if(IsDefined(self.influencer_tvmissile_cylinder))
	{
		removeinfluencer(self.influencer_tvmissile_cylinder);
	}

	self.influencer_tvmissile_cylinder = undefined;
}

//Function Number: 25
create_artillery_influencers(point,radius)
{
	weapon_team_mask = 0;
	if(radius < 0)
	{
		thisradius = level.spawnsystem.artillery_influencer_radius;
	}
	else
	{
		thisradius = radius;
	}

	return addcylinderinfluencer(level.spawnsystem.einfluencer_type_normal,2000 + VectorScale((0,0,-1)),point,(1,0,0),(0,0,1),thisradius,5000,level.spawnsystem.artillery_influencer_score,weapon_team_mask,"artillery,s,r",get_score_curve_index(level.spawnsystem.artillery_influencer_score_curve));
}

//Function Number: 26
create_vehicle_influencers()
{
	weapon_team_mask = 0;
	vehicleradius = 144;
	cylinderlength = level.spawnsystem.vehicle_influencer_lead_seconds;
	up = (0,0,1);
	forward = (1,0,0);
	cylinder_forward = up;
	cylinder_up = forward;
	return addcylinderinfluencer(level.spawnsystem.einfluencer_type_vehicle,self.origin,cylinder_forward,cylinder_up,vehicleradius,cylinderlength,level.spawnsystem.vehicle_influencer_score,weapon_team_mask,"vehicle,s",get_score_curve_index(level.spawnsystem.vehicle_influencer_score_curve),0,self);
}

//Function Number: 27
create_rcbomb_influencers(team)
{
	if(!(level.teambased))
	{
		other_team_mask = level.spawnsystem.ispawn_teammask_free;
	}
	else
	{
		other_team_mask = getotherteamsmask(team);
	}

	return addsphereinfluencer(level.spawnsystem.einfluencer_type_normal,self.origin,level.spawnsystem.rcbomb_influencer_radius,level.spawnsystem.rcbomb_influencer_score,other_team_mask,"rcbomb,r,s",get_score_curve_index(level.spawnsystem.rcbomb_influencer_score_curve),0,self);
}

//Function Number: 28
create_qrdrone_influencers(team)
{
	if(!(level.teambased))
	{
		other_team_mask = level.spawnsystem.ispawn_teammask_free;
	}
	else
	{
		other_team_mask = getotherteamsmask(team);
	}

	self.influencer_qrdrone_cylinder = addcylinderinfluencer(level.spawnsystem.einfluencer_type_normal,self.origin,(0,0,0),(0,0,0),level.spawnsystem.qrdrone_cylinder_influencer_radius,level.spawnsystem.qrdrone_cylinder_influencer_length,level.spawnsystem.qrdrone_cylinder_influencer_score,other_team_mask,"qrdrone_cyl,r,s",get_score_curve_index(level.spawnsystem.qrdrone_cylinder_influencer_score_curve),0,self);
	return addsphereinfluencer(level.spawnsystem.einfluencer_type_normal,self.origin,level.spawnsystem.qrdrone_influencer_radius,level.spawnsystem.qrdrone_influencer_score,other_team_mask,"qrdrone,r,s",get_score_curve_index(level.spawnsystem.qrdrone_influencer_score_curve),0,self);
}

//Function Number: 29
create_aitank_influencers(team)
{
	if(!(level.teambased))
	{
		other_team_mask = level.spawnsystem.ispawn_teammask_free;
	}
	else
	{
		other_team_mask = getotherteamsmask(team);
	}

	return addsphereinfluencer(level.spawnsystem.einfluencer_type_normal,self.origin,level.spawnsystem.aitank_influencer_radius,level.spawnsystem.aitank_influencer_score,other_team_mask,"aitank,r,s",get_score_curve_index(level.spawnsystem.aitank_influencer_score_curve),0,self);
}

//Function Number: 30
create_pegasus_influencer(origin,team)
{
	if(!(level.teambased))
	{
		other_team_mask = level.spawnsystem.ispawn_teammask_free;
	}
	else
	{
		other_team_mask = getotherteamsmask(team);
	}

	return addsphereinfluencer(level.spawnsystem.einfluencer_type_normal,origin,level.spawnsystem.pegasus_influencer_radius,level.spawnsystem.pegasus_influencer_score,other_team_mask,"pegasus,r,s",get_score_curve_index(level.spawnsystem.pegasus_influencer_score_curve),0);
}

//Function Number: 31
create_map_placed_influencers()
{
	staticinfluencerents = getentarray("mp_uspawn_influencer","classname");
	for(i = 0;i < staticinfluencerents.size;i++)
	{
		staticinfluencerent = staticinfluencerents[i];
		if(IsDefined(staticinfluencerent.script_gameobjectname) && staticinfluencerent.script_gameobjectname == "twar")
		{
		}
		else
		{
			create_map_placed_influencer(staticinfluencerent);
		}
	}
}

//Function Number: 32
create_map_placed_influencer(influencer_entity,optional_score_override)
{
	influencer_id = -1;
	if(IsDefined(influencer_entity.script_shape) && IsDefined(influencer_entity.script_score) && IsDefined(influencer_entity.script_score_curve))
	{
		switch(influencer_entity.script_shape)
		{
			case "sphere":
				score = optional_score_override;
				score = influencer_entity.script_score;
				influencer_id = addsphereinfluencer(level.spawnsystem.einfluencer_type_game_mode,influencer_entity.origin,influencer_entity.radius,score,getteammask(influencer_entity.script_team),"*map_defined",get_score_curve_index(influencer_entity.script_score_curve));
				continue;
	/#
				assertmsg("Radiant-placed sphere spawn influencers require \'radius\' parameter");
	#/
				break;
	Stack-Empty ? IsDefined(influencer_entity.radius) : IsDefined(optional_score_override)
				break;

			case "cylinder":
				score = optional_score_override;
				score = influencer_entity.script_score;
				influencer_id = addcylinderinfluencer(level.spawnsystem.einfluencer_type_game_mode,influencer_entity.origin,AnglesToForward(influencer_entity.angles),AnglesToUp(influencer_entity.angles),influencer_entity.radius,influencer_entity.height,score,getteammask(influencer_entity.script_team),"*map_defined",get_score_curve_index(influencer_entity.script_score_curve));
				continue;
	/#
				assertmsg("Radiant-placed cylinder spawn influencers require \'radius\' and \'height\' parameters");
	#/
				break;
	Stack-Empty ? IsDefined(influencer_entity.radius) && IsDefined(influencer_entity.height) : IsDefined(optional_score_override)
				break;

			default:
	/#
				assertmsg("Unsupported script_shape value (\" + influencer_entity.script_shape + "\") for unified spawning system static influencer.  Supported shapes are \"cylinder\" and \"sphere\".");
	#/
				break;
		}
	}
	else
	{
/#
		assertmsg("Radiant-placed spawn influencers require \'script_shape\', \'script_score\' and \'script_score_curve\' parameters");
#/
	}

	return influencer_id;
}

//Function Number: 33
create_enemy_spawned_influencers(origin,team)
{
	if(!(level.teambased))
	{
		other_team_mask = level.spawnsystem.ispawn_teammask_free;
	}
	else
	{
		other_team_mask = getotherteamsmask(team);
	}

	return addsphereinfluencer(level.spawnsystem.einfluencer_type_enemy_spawned,origin,level.spawnsystem.enemy_spawned_influencer_radius,level.spawnsystem.enemy_spawned_influencer_score,other_team_mask,"enemy_spawned,r,s",get_score_curve_index(level.spawnsystem.enemy_spawned_influencer_score_curve),7);
}

//Function Number: 34
updateallspawnpoints()
{
	foreach(team in level.teams)
	{
		gatherspawnentities(team);
	}

	clearspawnpoints();
	if(level.teambased)
	{
		foreach(team in level.teams)
		{
			addspawnpoints(team,level.unified_spawn_points[team].a);
		}
	}
	else
	{
		foreach(team in level.teams)
		{
			addspawnpoints("free",level.unified_spawn_points[team].a);
		}
	}

	remove_unused_spawn_entities();
}

//Function Number: 35
initialize_player_spawning_dvars()
{
/#
	reset_dvars = 1;
	for(;;)
	{
		get_player_spawning_dvars(reset_dvars);
		reset_dvars = 0;
		wait(2);
	}
1
#/
}

//Function Number: 36
get_player_spawning_dvars(reset_dvars)
{
	k_player_height = get_player_height();
	player_height_times_10 = "" + 10 * k_player_height;
	ss = level.spawnsystem;
	player_influencer_radius = 15 * k_player_height;
	player_influencer_score = 150;
	dog_influencer_radius = 10 * k_player_height;
	dog_influencer_score = 150;
	ss.script_based_influencer_system = set_dvar_int_if_unset("scr_script_based_influencer_system","0",reset_dvars);
	ss.randomness_range = set_dvar_float_if_unset("scr_spawn_randomness_range","10",reset_dvars);
	ss.objective_facing_bonus = set_dvar_float_if_unset("scr_spawn_objective_facing_bonus","50",reset_dvars);
	ss.friend_weak_influencer_score = set_dvar_float_if_unset("scr_spawn_friend_weak_influencer_score","10",reset_dvars);
	ss.friend_weak_influencer_score_curve = set_dvar_if_unset("scr_spawn_friend_weak_influencer_score_curve","steep",reset_dvars);
	ss.friend_weak_influencer_radius = set_dvar_float_if_unset("scr_spawn_friend_weak_influencer_radius",player_height_times_10,reset_dvars);
	ss.enemy_influencer_score = set_dvar_float_if_unset("scr_spawn_enemy_influencer_score","-150",reset_dvars);
	ss.enemy_influencer_score_curve = set_dvar_if_unset("scr_spawn_enemy_influencer_score_curve","steep",reset_dvars);
	ss.enemy_influencer_radius = set_dvar_float_if_unset("scr_spawn_enemy_influencer_radius","2600",reset_dvars);
	ss.dead_friend_influencer_timeout_seconds = set_dvar_float_if_unset("scr_spawn_dead_friend_influencer_timeout_seconds","15",reset_dvars);
	ss.dead_friend_influencer_count = set_dvar_float_if_unset("scr_spawn_dead_friend_influencer_count","7",reset_dvars);
	ss.dead_friend_influencer_score = set_dvar_float_if_unset("scr_spawn_dead_friend_influencer_score","-100",reset_dvars);
	ss.dead_friend_influencer_score_curve = set_dvar_if_unset("scr_spawn_dead_friend_influencer_score_curve","steep",reset_dvars);
	ss.dead_friend_influencer_radius = set_dvar_float_if_unset("scr_spawn_dead_friend_influencer_radius",player_height_times_10,reset_dvars);
	ss.vehicle_influencer_score = set_dvar_float_if_unset("scr_spawn_vehicle_influencer_score","-50",reset_dvars);
	ss.vehicle_influencer_score_curve = set_dvar_if_unset("scr_spawn_vehicle_influencer_score_curve","linear",reset_dvars);
	ss.vehicle_influencer_lead_seconds = set_dvar_float_if_unset("scr_spawn_vehicle_influencer_lead_seconds","3",reset_dvars);
	ss.dog_influencer_score = set_dvar_float_if_unset("scr_spawn_dog_influencer_score","-150",reset_dvars);
	ss.dog_influencer_score_curve = set_dvar_if_unset("scr_spawn_dog_influencer_score_curve","steep",reset_dvars);
	ss.dog_influencer_radius = set_dvar_float_if_unset("scr_spawn_dog_influencer_radius","" + 15 * k_player_height,reset_dvars);
	ss.artillery_influencer_score = set_dvar_float_if_unset("scr_spawn_artillery_influencer_score","-600",reset_dvars);
	ss.artillery_influencer_score_curve = set_dvar_if_unset("scr_spawn_artillery_influencer_score_curve","linear",reset_dvars);
	ss.artillery_influencer_radius = set_dvar_float_if_unset("scr_spawn_artillery_influencer_radius","1200",reset_dvars);
	ss.grenade_influencer_score = set_dvar_float_if_unset("scr_spawn_grenade_influencer_score","-300",reset_dvars);
	ss.grenade_influencer_score_curve = set_dvar_if_unset("scr_spawn_grenade_influencer_score_curve","linear",reset_dvars);
	ss.grenade_influencer_radius = set_dvar_float_if_unset("scr_spawn_grenade_influencer_radius","" + 8 * k_player_height,reset_dvars);
	ss.grenade_endpoint_influencer_score = set_dvar_float_if_unset("scr_spawn_grenade_endpoint_influencer_score","-300",reset_dvars);
	ss.grenade_endpoint_influencer_score_curve = set_dvar_if_unset("scr_spawn_grenade_endpoint_influencer_score_curve","linear",reset_dvars);
	ss.grenade_endpoint_influencer_radius = set_dvar_float_if_unset("scr_spawn_grenade_endpoint_influencer_radius","" + 8 * k_player_height,reset_dvars);
	ss.claymore_influencer_score = set_dvar_float_if_unset("scr_spawn_claymore_influencer_score","-150",reset_dvars);
	ss.claymore_influencer_score_curve = set_dvar_if_unset("scr_spawn_claymore_influencer_score_curve","steep",reset_dvars);
	ss.claymore_influencer_radius = set_dvar_float_if_unset("scr_spawn_claymore_influencer_radius","" + 9 * k_player_height,reset_dvars);
	ss.napalm_influencer_score = set_dvar_float_if_unset("scr_spawn_napalm_influencer_score","-500",reset_dvars);
	ss.napalm_influencer_score_curve = set_dvar_if_unset("scr_spawn_napalm_influencer_score_curve","linear",reset_dvars);
	ss.napalm_influencer_radius = set_dvar_float_if_unset("scr_spawn_napalm_influencer_radius","" + 750,reset_dvars);
	ss.auto_turret_influencer_score = set_dvar_float_if_unset("scr_spawn_auto_turret_influencer_score","-650",reset_dvars);
	ss.auto_turret_influencer_score_curve = set_dvar_if_unset("scr_spawn_auto_turret_influencer_score_curve","linear",reset_dvars);
	ss.auto_turret_influencer_radius = set_dvar_float_if_unset("scr_spawn_auto_turret_influencer_radius","" + 1200,reset_dvars);
	ss.rcbomb_influencer_score = set_dvar_float_if_unset("scr_spawn_rcbomb_influencer_score","-200",reset_dvars);
	ss.rcbomb_influencer_score_curve = set_dvar_if_unset("scr_spawn_rcbomb_influencer_score_curve","steep",reset_dvars);
	ss.rcbomb_influencer_radius = set_dvar_float_if_unset("scr_spawn_rcbomb_influencer_radius","" + 25 * k_player_height,reset_dvars);
	ss.qrdrone_influencer_score = set_dvar_float_if_unset("scr_spawn_qrdrone_influencer_score","-200",reset_dvars);
	ss.qrdrone_influencer_score_curve = set_dvar_if_unset("scr_spawn_qrdrone_influencer_score_curve","steep",reset_dvars);
	ss.qrdrone_influencer_radius = set_dvar_float_if_unset("scr_spawn_qrdrone_influencer_radius","" + 25 * k_player_height,reset_dvars);
	ss.qrdrone_cylinder_influencer_score = set_dvar_float_if_unset("scr_spawn_qrdrone_cylinder_influencer_score","-300",reset_dvars);
	ss.qrdrone_cylinder_influencer_score_curve = set_dvar_if_unset("scr_spawn_qrdrone_cylinder_influencer_score_curve","linear",reset_dvars);
	ss.qrdrone_cylinder_influencer_radius = set_dvar_float_if_unset("scr_spawn_qrdrone_cylinder_influencer_radius",1000,reset_dvars);
	ss.qrdrone_cylinder_influencer_length = set_dvar_float_if_unset("scr_spawn_qrdrone_cylinder_influencer_length",2000,reset_dvars);
	ss.aitank_influencer_score = set_dvar_float_if_unset("scr_spawn_aitank_influencer_score","-200",reset_dvars);
	ss.aitank_influencer_score_curve = set_dvar_if_unset("scr_spawn_aitank_influencer_score_curve","linear",reset_dvars);
	ss.aitank_influencer_radius = set_dvar_float_if_unset("scr_spawn_aitank_influencer_radius","" + 25 * k_player_height,reset_dvars);
	ss.enemy_spawned_influencer_score_curve = set_dvar_if_unset("scr_spawn_enemy_spawned_influencer_score_curve","constant",reset_dvars);
	if(level.teambased)
	{
		ss.enemy_spawned_influencer_score = set_dvar_float_if_unset("scr_spawn_enemy_spawned_influencer_score","-200",reset_dvars);
		ss.enemy_spawned_influencer_radius = set_dvar_float_if_unset("scr_spawn_enemy_spawned_influencer_radius","" + 1100,reset_dvars);
	}
	else
	{
		ss.enemy_spawned_influencer_score = set_dvar_float_if_unset("scr_spawn_enemy_spawned_influencer_score","-100",reset_dvars);
		ss.enemy_spawned_influencer_radius = set_dvar_float_if_unset("scr_spawn_enemy_spawned_influencer_radius","" + 400,reset_dvars);
	}

	ss.helicopter_influencer_score = set_dvar_float_if_unset("scr_spawn_helicopter_influencer_score","-500",reset_dvars);
	ss.helicopter_influencer_score_curve = set_dvar_if_unset("scr_spawn_helicopter_influencer_score_curve","linear",reset_dvars);
	ss.helicopter_influencer_radius = set_dvar_float_if_unset("scr_spawn_helicopter_influencer_radius","" + 2000,reset_dvars);
	ss.helicopter_influencer_length = set_dvar_float_if_unset("scr_spawn_helicopter_influencer_length","" + 3500,reset_dvars);
	ss.tvmissile_influencer_score = set_dvar_float_if_unset("scr_spawn_tvmissile_influencer_score","-400",reset_dvars);
	ss.tvmissile_influencer_score_curve = set_dvar_if_unset("scr_spawn_tvmissile_influencer_score_curve","linear",reset_dvars);
	ss.tvmissile_influencer_radius = set_dvar_float_if_unset("scr_spawn_tvmissile_influencer_radius","" + 2000,reset_dvars);
	ss.tvmissile_influencer_length = set_dvar_float_if_unset("scr_spawn_tvmissile_influencer_length","" + 3000,reset_dvars);
	ss.pegasus_influencer_score = set_dvar_float_if_unset("scr_spawn_pegasus_influencer_score","-250",reset_dvars);
	ss.pegasus_influencer_score_curve = set_dvar_if_unset("scr_spawn_pegasus_influencer_score_curve","linear",reset_dvars);
	ss.pegasus_influencer_radius = set_dvar_float_if_unset("scr_spawn_pegasus_influencer_radius","" + 20 * k_player_height,reset_dvars);
	if(!(IsDefined(ss.unifiedsideswitching)))
	{
		ss.unifiedsideswitching = 1;
	}

	set_dvar_int_if_unset("spawnsystem_allow_non_team_spawns","0",reset_dvars);
	[[ level.gamemodespawndvars ]](reset_dvars);
	if(IsDefined(level.levelspawndvars))
	{
		[[ level.levelspawndvars ]](reset_dvars);
	}

	setspawnpointrandomvariation(ss.randomness_range);
}

//Function Number: 37
level_use_unified_spawning(use)
{
}

//Function Number: 38
onspawnplayer_unified(predictedspawn)
{
	if(!(IsDefined(predictedspawn)))
	{
		predictedspawn = 0;
	}

/#
	spawn_point = get_debug_spawnpoint(self);
	self spawn(spawn_point.origin,spawn_point.angles);
GetDvarInt(#"24A61F21") != 0
#/
	use_new_spawn_system = 0;
	initial_spawn = 1;
	if(IsDefined(self.uspawn_already_spawned))
	{
		initial_spawn = !self.uspawn_already_spawned;
	}

	if(level.usestartspawns)
	{
		use_new_spawn_system = 0;
	}

	if(level.gametype == "sd")
	{
		use_new_spawn_system = 0;
	}

	set_dvar_if_unset("scr_spawn_force_unified","0");
	[[ level.onspawnplayer ]](predictedspawn);
	if(!(predictedspawn))
	{
		self.uspawn_already_spawned = 1;
	}
}

//Function Number: 39
getspawnpoint(player_entity,predictedspawn)
{
	if(!(IsDefined(predictedspawn)))
	{
		predictedspawn = 0;
	}

	if(level.teambased)
	{
		point_team = player_entity.pers["team"];
		influencer_team = player_entity.pers["team"];
	}
	else
	{
		point_team = "free";
		influencer_team = "free";
	}

	if(level.teambased && IsDefined(game["switchedsides"]) && game["switchedsides"] && level.spawnsystem.unifiedsideswitching)
	{
		point_team = getotherteam(point_team);
	}

	best_spawn_entity = get_best_spawnpoint(point_team,influencer_team,player_entity,predictedspawn);
	if(!(predictedspawn))
	{
		player_entity.last_spawn_origin = best_spawn_entity.origin;
	}

	return best_spawn_entity;
}

//Function Number: 40
get_debug_spawnpoint(player)
{
	if(level.teambased)
	{
		team = player.pers["team"];
	}
	else
	{
		team = "free";
	}

	index = level.test_spawn_point_index;
	level.test_spawn_point_index++;
	if(team == "free")
	{
		spawn_counts = 0;
		foreach(team in level.teams)
		{
			spawn_counts = spawn_counts + level.unified_spawn_points[team].a.size;
		}

		if(level.test_spawn_point_index >= spawn_counts)
		{
			level.test_spawn_point_index = 0;
		}

		count = 0;
		foreach(team in level.teams)
		{
			size = level.unified_spawn_points[team].a.size;
			if(level.test_spawn_point_index < count + size)
			{
				return level.unified_spawn_points[team].a[level.test_spawn_point_index - count];
			}

			count = count + size;
		}
	}
	else
	{
		if(level.test_spawn_point_index >= level.unified_spawn_points[team].a.size)
		{
			level.test_spawn_point_index = 0;
		}

		return level.unified_spawn_points[team].a[level.test_spawn_point_index];
	}
}

//Function Number: 41
get_best_spawnpoint(point_team,influencer_team,player,predictedspawn)
{
	if(level.teambased)
	{
		vis_team_mask = getotherteamsmask(player.pers["team"]);
	}
	else
	{
		vis_team_mask = level.spawnsystem.ispawn_teammask_free;
	}

	scored_spawn_points = getsortedspawnpoints(point_team,influencer_team,vis_team_mask,player,predictedspawn);
/#
	assert(scored_spawn_points.size > 0);
#/
/#
	assert(scored_spawn_points.size == 1);
#/
	if(!(predictedspawn))
	{
		bbprint("mpspawnpointsused","reason %s x %d y %d z %d","point used",scored_spawn_points[0].origin);
	}

	return scored_spawn_points[0];
}

//Function Number: 42
gatherspawnentities(player_team)
{
	if(!(IsDefined(level.unified_spawn_points)))
	{
		level.unified_spawn_points = [];
	}
	else if(IsDefined(level.unified_spawn_points[player_team]))
	{
		return level.unified_spawn_points[player_team];
	}

	spawn_entities_s = spawn_array_struct();
	spawn_entities_s.a = getentarray("mp_uspawn_point","classname");
	if(!(IsDefined(spawn_entities_s.a)))
	{
		spawn_entities_s.a = [];
	}

	legacy_spawn_points = maps/mp/gametypes_zm/_spawnlogic::getteamspawnpoints(player_team);
	for(legacy_spawn_index = 0;legacy_spawn_index < legacy_spawn_points.size;legacy_spawn_index++)
	{
		spawn_entities_s.a[spawn_entities_s.a.size] = legacy_spawn_points[legacy_spawn_index];
	}

	level.unified_spawn_points[player_team] = spawn_entities_s;
	return spawn_entities_s;
}

//Function Number: 43
is_hardcore()
{
	return IsDefined(level.hardcoremode) && level.hardcoremode;
}

//Function Number: 44
teams_have_enmity(team1,team2)
{
	if(!IsDefined(team1) || !IsDefined(team2) || level.gametype == "dm")
	{
		return 1;
	}

	return team1 != "neutral" && team2 != "neutral" && team1 != team2;
}

//Function Number: 45
remove_unused_spawn_entities()
{
	spawn_entity_types = [];
	spawn_entity_types[spawn_entity_types.size] = "mp_dm_spawn";
	spawn_entity_types[spawn_entity_types.size] = "mp_tdm_spawn_allies_start";
	spawn_entity_types[spawn_entity_types.size] = "mp_tdm_spawn_axis_start";
	spawn_entity_types[spawn_entity_types.size] = "mp_tdm_spawn";
	spawn_entity_types[spawn_entity_types.size] = "mp_ctf_spawn_allies_start";
	spawn_entity_types[spawn_entity_types.size] = "mp_ctf_spawn_axis_start";
	spawn_entity_types[spawn_entity_types.size] = "mp_ctf_spawn_allies";
	spawn_entity_types[spawn_entity_types.size] = "mp_ctf_spawn_axis";
	spawn_entity_types[spawn_entity_types.size] = "mp_dom_spawn_allies_start";
	spawn_entity_types[spawn_entity_types.size] = "mp_dom_spawn_axis_start";
	spawn_entity_types[spawn_entity_types.size] = "mp_dom_spawn";
	spawn_entity_types[spawn_entity_types.size] = "mp_sab_spawn_allies_start";
	spawn_entity_types[spawn_entity_types.size] = "mp_sab_spawn_axis_start";
	spawn_entity_types[spawn_entity_types.size] = "mp_sab_spawn_allies";
	spawn_entity_types[spawn_entity_types.size] = "mp_sab_spawn_axis";
	spawn_entity_types[spawn_entity_types.size] = "mp_sd_spawn_attacker";
	spawn_entity_types[spawn_entity_types.size] = "mp_sd_spawn_defender";
	spawn_entity_types[spawn_entity_types.size] = "mp_twar_spawn_axis_start";
	spawn_entity_types[spawn_entity_types.size] = "mp_twar_spawn_allies_start";
	spawn_entity_types[spawn_entity_types.size] = "mp_twar_spawn";
	for(i = 0;i < spawn_entity_types.size;i++)
	{
		if(spawn_point_class_name_being_used(spawn_entity_types[i]))
		{
		}
		else
		{
			spawnpoints = maps/mp/gametypes_zm/_spawnlogic::getspawnpointarray(spawn_entity_types[i]);
			delete_all_spawns(spawnpoints);
		}
	}
}

//Function Number: 46
delete_all_spawns(spawnpoints)
{
	for(i = 0;i < spawnpoints.size;i++)
	{
		spawnpoints[i] delete();
	}
}

//Function Number: 47
spawn_point_class_name_being_used(name)
{
	if(!(IsDefined(level.spawn_point_class_names)))
	{
		return 0;
	}

	for(i = 0;i < level.spawn_point_class_names.size;i++)
	{
		if(level.spawn_point_class_names[i] == name)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 48
codecallback_updatespawnpoints()
{
	foreach(team in level.teams)
	{
		maps/mp/gametypes_zm/_spawnlogic::rebuildspawnpoints(team);
	}

	level.unified_spawn_points = undefined;
	updateallspawnpoints();
}

//Function Number: 49
initialspawnprotection(specialtyname,spawnmonitorspeed)
{
	self endon("death");
	self endon("disconnect");
	if(!IsDefined(level.spawnprotectiontime) || level.spawnprotectiontime == 0)
	{
		return;
	}

	if(specialtyname == "specialty_nottargetedbyairsupport")
	{
		self.specialty_nottargetedbyairsupport = 1;
		wait(level.spawnprotectiontime);
		self.specialty_nottargetedbyairsupport = undefined;
	}
	else if(!(self hasperk(specialtyname)))
	{
		self setperk(specialtyname);
		wait(level.spawnprotectiontime);
		self unsetperk(specialtyname);
	}
}