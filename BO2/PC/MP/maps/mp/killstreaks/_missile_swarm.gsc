/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_missile_swarm.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 24
 * Decompile Time: 252 ms
 * Timestamp: 10/27/2023 3:00:47 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_challenges;
#include maps/mp/_scoreevents;
#include maps/mp/_utility;
#include maps/mp/killstreaks/_airsupport;
#include maps/mp/killstreaks/_dogs;
#include maps/mp/killstreaks/_killstreakrules;
#include maps/mp/killstreaks/_killstreaks;

//Function Number: 1
init()
{
	level.missile_swarm_max = 6;
	level.missile_swarm_flyheight = 3000;
	level.missile_swarm_flydist = 5000;
	set_dvar_float_if_unset("scr_missile_swarm_lifetime",40);
	precacheitem("missile_swarm_projectile_mp");
	level.swarm_fx["swarm"] = loadfx("weapon/harpy_swarm/fx_hrpy_swrm_os_circle_neg_x");
	level.swarm_fx["swarm_tail"] = loadfx("weapon/harpy_swarm/fx_hrpy_swrm_exhaust_trail_close");
	level.missiledronesoundstart = "mpl_hk_scan";
	registerkillstreak("missile_swarm_mp","missile_swarm_mp","killstreak_missile_swarm","missile_swarm_used",::swarm_killstreak,1);
	registerkillstreakaltweapon("missile_swarm_mp","missile_swarm_projectile_mp");
	registerkillstreakstrings("missile_swarm_mp",&"KILLSTREAK_EARNED_MISSILE_SWARM",&"KILLSTREAK_MISSILE_SWARM_NOT_AVAILABLE",&"KILLSTREAK_MISSILE_SWARM_INBOUND");
	registerkillstreakdialog("missile_swarm_mp","mpl_killstreak_missile_swarm","kls_swarm_used","","kls_swarm_enemy","","kls_swarm_ready");
	registerkillstreakdevdvar("missile_swarm_mp","scr_givemissileswarm");
	setkillstreakteamkillpenaltyscale("missile_swarm_mp",0);
	maps/mp/killstreaks/_killstreaks::createkillstreaktimer("missile_swarm_mp");
	registerclientfield("world","missile_swarm",1,2,"int");
/#
	set_dvar_int_if_unset("scr_missile_swarm_cam",0);
#/
}

//Function Number: 2
swarm_killstreak(hardpointtype)
{
/#
	assert(hardpointtype == "missile_swarm_mp");
#/
	level.missile_swarm_origin = level.mapcenter + (0,0,level.missile_swarm_flyheight);
	if(level.script == "mp_drone")
	{
		level.missile_swarm_origin = level.missile_swarm_origin + (-5000,0,2000);
	}

	if(level.script == "mp_la")
	{
		level.missile_swarm_origin = 2000 + VectorScale((0,0,1));
	}

	if(level.script == "mp_turbine")
	{
		level.missile_swarm_origin = 1500 + VectorScale((0,0,1));
	}

	if(level.script == "mp_downhill")
	{
		level.missile_swarm_origin = level.missile_swarm_origin + (4000,0,1000);
	}

	if(level.script == "mp_hydro")
	{
		level.missile_swarm_origin = 5000 + VectorScale((0,0,1));
	}

	if(level.script == "mp_magma")
	{
		level.missile_swarm_origin = level.missile_swarm_origin + (0,-6000,3000);
	}

	if(level.script == "mp_uplink")
	{
		level.missile_swarm_origin = level.missile_swarm_origin + (-6000,0,2000);
	}

	if(level.script == "mp_bridge")
	{
		level.missile_swarm_origin = 2000 + VectorScale((0,0,1));
	}

	if(level.script == "mp_paintball")
	{
		level.missile_swarm_origin = 1000 + VectorScale((0,0,1));
	}

	if(level.script == "mp_dig")
	{
		level.missile_swarm_origin = level.missile_swarm_origin + (-2000,-2000,1000);
	}

	killstreak_id = self maps/mp/killstreaks/_killstreakrules::killstreakstart("missile_swarm_mp",self.team,0,1);
	if(killstreak_id == -1)
	{
		return 0;
	}

	level thread swarm_killstreak_start(self,killstreak_id);
	return 1;
}

//Function Number: 3
swarm_killstreak_start(owner,killstreak_id)
{
	level endon("swarm_end");
	missiles = getentarray("swarm_missile","targetname");
	foreach(missile in missiles)
	{
		if(IsDefined(missile))
		{
			missile detonate();
			wait(0.1);
		}
	}

	if(IsDefined(level.missile_swarm_fx))
	{
		for(i = 0;i < level.missile_swarm_fx.size;i++)
		{
			if(IsDefined(level.missile_swarm_fx[i]))
			{
				level.missile_swarm_fx[i] delete();
			}
		}
	}

	level.missile_swarm_fx = undefined;
	level.missile_swarm_team = owner.team;
	level.missile_swarm_owner = owner;
	owner maps/mp/killstreaks/_killstreaks::playkillstreakstartdialog("missile_swarm_mp",owner.pers["team"]);
	level create_player_targeting_array(owner,owner.team);
	level.globalkillstreakscalled++;
	owner addweaponstat("missile_swarm_mp","used",1);
	level thread swarm_killstreak_abort(owner,killstreak_id);
	level thread swarm_killstreak_watch_for_emp(owner,killstreak_id);
	level thread swarm_killstreak_fx();
	wait(2);
	level thread swarm_think(owner,killstreak_id);
}

//Function Number: 4
swarm_killstreak_end(owner,detonate,killstreak_id)
{
	level notify("swarm_end");
	if(IsDefined(detonate) && detonate)
	{
		level setclientfield("missile_swarm",2);
	}
	else
	{
		level setclientfield("missile_swarm",0);
	}

	missiles = getentarray("swarm_missile","targetname");
	if(is_true(detonate))
	{
		for(i = 0;i < level.missile_swarm_fx.size;i++)
		{
			if(IsDefined(level.missile_swarm_fx[i]))
			{
				level.missile_swarm_fx[i] delete();
			}
		}

		foreach(missile in missiles)
		{
			if(IsDefined(missile))
			{
				missile detonate();
				wait(0.1);
			}
		}
	}
	else
	{
		foreach(missile in missiles)
		{
			if(IsDefined(missile))
			{
				yaw = randomintrange(0,360);
				angles = (0,yaw,0);
				forward = AnglesToForward(angles);
				if(IsDefined(missile.goal))
				{
					missile.goal.origin = missile.origin + forward * level.missile_swarm_flydist * 1000;
				}
			}
		}
	}

	wait(1);
	level.missile_swarm_sound stoploopsound(2);
	wait(2);
	level.missile_swarm_sound delete();
	recordstreakindex = level.killstreakindices[level.killstreaks["missile_swarm_mp"].menuname];
	if(IsDefined(recordstreakindex))
	{
		owner recordkillstreakendevent(recordstreakindex);
	}

	maps/mp/killstreaks/_killstreakrules::killstreakstop("missile_swarm_mp",level.missile_swarm_team,killstreak_id);
	level.missile_swarm_owner = undefined;
	wait(4);
	missiles = getentarray("swarm_missile","targetname");
	foreach(missile in missiles)
	{
		if(IsDefined(missile))
		{
			missile delete();
			wait(0.1);
		}
	}

	wait(6);
	for(i = 0;i < level.missile_swarm_fx.size;i++)
	{
		if(IsDefined(level.missile_swarm_fx[i]))
		{
			level.missile_swarm_fx[i] delete();
		}
	}
}

//Function Number: 5
swarm_killstreak_abort(owner,killstreak_id)
{
	level endon("swarm_end");
	owner waittill_any("disconnect","joined_team","joined_spectators","emp_jammed");
	level thread swarm_killstreak_end(owner,1,killstreak_id);
}

//Function Number: 6
swarm_killstreak_watch_for_emp(owner,killstreak_id)
{
	level endon("swarm_end");
	owner waittill("emp_destroyed_missile_swarm",attacker);
	maps/mp/_scoreevents::processscoreevent("destroyed_missile_swarm",attacker,owner,"emp_mp");
	attacker maps/mp/_challenges::addflyswatterstat("emp_mp");
	level thread swarm_killstreak_end(owner,1,killstreak_id);
}

//Function Number: 7
swarm_killstreak_fx()
{
	level endon("swarm_end");
	level.missile_swarm_fx = [];
	yaw = randomint(360);
	level.missile_swarm_fx[0] = spawn("script_model",level.missile_swarm_origin);
	level.missile_swarm_fx[0] setmodel("tag_origin");
	level.missile_swarm_fx[0].angles = (-90,yaw,0);
	level.missile_swarm_fx[1] = spawn("script_model",level.missile_swarm_origin);
	level.missile_swarm_fx[1] setmodel("tag_origin");
	level.missile_swarm_fx[1].angles = (-90,yaw,0);
	level.missile_swarm_fx[2] = spawn("script_model",level.missile_swarm_origin);
	level.missile_swarm_fx[2] setmodel("tag_origin");
	level.missile_swarm_fx[2].angles = (-90,yaw,0);
	level.missile_swarm_fx[3] = spawn("script_model",level.missile_swarm_origin);
	level.missile_swarm_fx[3] setmodel("tag_origin");
	level.missile_swarm_fx[3].angles = (-90,yaw,0);
	level.missile_swarm_fx[4] = spawn("script_model",level.missile_swarm_origin);
	level.missile_swarm_fx[4] setmodel("tag_origin");
	level.missile_swarm_fx[4].angles = (-90,yaw,0);
	level.missile_swarm_fx[5] = spawn("script_model",level.missile_swarm_origin);
	level.missile_swarm_fx[5] setmodel("tag_origin");
	level.missile_swarm_fx[5].angles = (-90,yaw,0);
	level.missile_swarm_fx[6] = spawn("script_model",level.missile_swarm_origin);
	level.missile_swarm_fx[6] setmodel("tag_origin");
	level.missile_swarm_fx[6].angles = (-90,yaw,0);
	level.missile_swarm_sound = spawn("script_model",level.missile_swarm_origin);
	level.missile_swarm_sound setmodel("tag_origin");
	level.missile_swarm_sound.angles = (0,0,0);
	wait(0.1);
	playfxontag(level.swarm_fx["swarm"],level.missile_swarm_fx[0],"tag_origin");
	wait(2);
	level.missile_swarm_sound playloopsound("veh_harpy_drone_swarm_lp",3);
	level setclientfield("missile_swarm",1);
	current = 1;
	while(1)
	{
		if(!(IsDefined(level.missile_swarm_fx[current])))
		{
			level.missile_swarm_fx[current] = spawn("script_model",level.missile_swarm_origin);
			level.missile_swarm_fx[current] setmodel("tag_origin");
		}

		yaw = randomint(360);
		if(IsDefined(level.missile_swarm_fx[current]))
		{
			level.missile_swarm_fx[current].angles = (-90,yaw,0);
		}

		wait(0.1);
		if(IsDefined(level.missile_swarm_fx[current]))
		{
			playfxontag(level.swarm_fx["swarm"],level.missile_swarm_fx[current],"tag_origin");
		}

		current = current + 1 % 7;
		wait(1.9);
	}
}

//Function Number: 8
swarm_think(owner,killstreak_id)
{
	level endon("swarm_end");
	lifetime = GetDvarFloat(#"4FEEA279");
	end_time = GetTime() + lifetime * 1000;
	level.missile_swarm_count = 0;
	while(GetTime() < end_time)
	{
/#
		assert(level.missile_swarm_count >= 0);
#/
		if(level.missile_swarm_count >= level.missile_swarm_max)
		{
			wait(0.5);
			continue;
		}

		count = 1;
		level.missile_swarm_count = level.missile_swarm_count + count;
		for(i = 0;i < count;i++)
		{
			self thread projectile_spawn(owner);
		}

		wait(level.missile_swarm_count / level.missile_swarm_max + 0.4);
	}

	level thread swarm_killstreak_end(owner,undefined,killstreak_id);
}

//Function Number: 9
projectile_cam(player)
{
/#
	player.swarm_cam = 1;
	wait(0.05);
	forward = AnglesToForward(self.angles);
	cam = spawn("script_model",300 + VectorScale((0,0,1)) + forward * -200);
	cam setmodel("tag_origin");
	cam linkto(self);
	player camerasetposition(cam);
	player camerasetlookat(self);
	player cameraactivate(1);
	self waittill(self.origin,"death");
	wait(1);
	player cameraactivate(0);
	cam delete();
	player.swarm_cam = 0;
#/
}

//Function Number: 10
projectile_goal_move()
{
	self endon("death");
	for(;;)
	{
		wait(0.25);
		if(distancesquared(self.origin,self.goal.origin) < 65536)
		{
			if(distancesquared(self.origin,level.missile_swarm_origin) > level.missile_swarm_flydist * level.missile_swarm_flydist)
			{
				self.goal.origin = level.missile_swarm_origin;
				continue;
			}

			enemy = projectile_find_random_player(self.owner,self.team);
			if(IsDefined(enemy))
			{
				self.goal.origin = enemy.origin + (0,0,self.origin[2]);
			}
			else
			{
				pitch = randomintrange(-45,45);
				yaw = randomintrange(0,360);
				angles = (0,yaw,0);
				forward = AnglesToForward(angles);
				self.goal.origin = self.origin + forward * level.missile_swarm_flydist;
			}

			nfz = crossesnoflyzone(self.origin,self.goal.origin);
			tries = 20;
			while(IsDefined(nfz) && tries > 0)
			{
				tries--;
				pitch = randomintrange(-45,45);
				yaw = randomintrange(0,360);
				angles = (0,yaw,0);
				forward = AnglesToForward(angles);
				self.goal.origin = self.origin + forward * level.missile_swarm_flydist;
				nfz = crossesnoflyzone(self.origin,self.goal.origin);
			}
		}
	}
}

//Function Number: 11
projectile_target_search(acceptskyexposure,acquiretime,allowplayeroffset)
{
	self endon("death");
	wait(acquiretime);
	for(;;)
	{
		wait(randomfloatrange(0.5,1));
		target = self projectile_find_target(acceptskyexposure);
		if(IsDefined(target))
		{
			self.swarm_target = target["entity"];
			target["entity"].swarm = self;
			if(allowplayeroffset)
			{
				self missile_settarget(target["entity"],target["offset"]);
				self missile_dronesetvisible(1);
			}
			else
			{
				self missile_settarget(target["entity"]);
				self missile_dronesetvisible(1);
			}

			self playsound("veh_harpy_drone_swarm_incomming");
			if(!IsDefined(target["entity"].swarmsound) || target["entity"].swarmsound == 0)
			{
				self thread target_sounds(target["entity"]);
			}

			target["entity"] waittill_any("death","disconnect","joined_team");
			self missile_settarget(self.goal);
			self missile_dronesetvisible(0);
			continue;
		}
	}
}

//Function Number: 12
target_sounds(targetent)
{
	targetent endon("death");
	targetent endon("disconnect");
	targetent endon("joined_team");
	self endon("death");
	dist = 3000;
	if(IsDefined(self.warningsounddist))
	{
		dist = self.warningsounddist;
	}

	while(distancesquared(self.origin,targetent.origin) > dist * dist)
	{
		wait(0.05);
	}

	if(IsDefined(targetent.swarmsound) && targetent.swarmsound == 1)
	{
		return;
	}

	targetent.swarmsound = 1;
	self thread reset_sound_blocker(targetent);
	self thread target_stop_sounds(targetent);
	if(isplayer(targetent))
	{
		targetent playlocalsound(level.missiledronesoundstart);
	}

	self playsound(level.missiledronesoundstart);
}

//Function Number: 13
target_stop_sounds(targetent)
{
	targetent waittill_any("disconnect","death","joined_team");
	if(IsDefined(targetent) && isplayer(targetent))
	{
		targetent stoplocalsound(level.missiledronesoundstart);
	}
}

//Function Number: 14
reset_sound_blocker(target)
{
	wait(2);
	if(IsDefined(target))
	{
		target.swarmsound = 0;
	}
}

//Function Number: 15
projectile_spawn(owner)
{
	level endon("swarm_end");
	upvector = (0,0,randomintrange(level.missile_swarm_flyheight - 1500,level.missile_swarm_flyheight - 1000));
	yaw = randomintrange(0,360);
	angles = (0,yaw,0);
	forward = AnglesToForward(angles);
	origin = level.mapcenter + upvector + forward * level.missile_swarm_flydist * -1;
	target = level.mapcenter + upvector + forward * level.missile_swarm_flydist;
	enemy = projectile_find_random_player(owner,owner.team);
	if(IsDefined(enemy))
	{
		target = enemy.origin + upvector;
	}

	projectile = projectile_spawn_utility(owner,target,origin,"missile_swarm_projectile_mp","swarm_missile",1);
	projectile thread projectile_abort_think();
	projectile thread projectile_target_search(cointoss(),1,1);
	projectile thread projectile_death_think();
	projectile thread projectile_goal_move();
	wait(0.1);
	if(IsDefined(projectile))
	{
		projectile setclientfield("missile_drone_projectile_animate",1);
	}
}

//Function Number: 16
projectile_spawn_utility(owner,target,origin,weapon,targetname,movegoal)
{
	goal = spawn("script_model",target);
	goal setmodel("tag_origin");
	p = magicbullet(weapon,origin,target,owner,goal);
	p.owner = owner;
	p.team = owner.team;
	p.goal = goal;
	p.targetname = "swarm_missile";
/#
	p thread projectile_cam(owner);
!is_true(owner.swarm_cam) && GetDvarInt(#"492656A6") == 1
#/
	return p;
}

//Function Number: 17
projectile_death_think()
{
	self waittill("death");
	level.missile_swarm_count--;
	self.goal delete();
}

//Function Number: 18
projectile_abort_think()
{
	self endon("death");
	self.owner waittill_any("disconnect","joined_team");
	self detonate();
}

//Function Number: 19
projectile_find_target(acceptskyexposure)
{
	ks = projectile_find_target_killstreak(acceptskyexposure);
	player = projectile_find_target_player(acceptskyexposure);
	if(IsDefined(ks) && !IsDefined(player))
	{
		return ks;
	}
	else if(!IsDefined(ks) && IsDefined(player))
	{
		return player;
	}
	else if(IsDefined(ks) && IsDefined(player))
	{
		if(cointoss())
		{
			return ks;
		}

		return player;
	}
}

//Function Number: 20
projectile_find_target_killstreak(acceptskyexposure)
{
	ks = [];
	ks["offset"] = VectorScale((0,0,-1));
	targets = target_getarray();
	rcbombs = getentarray("rcbomb","targetname");
	satellites = getentarray("satellite","targetname");
	dogs = maps/mp/killstreaks/_dogs::dog_manager_get_dogs();
	targets = arraycombine(targets,rcbombs,1,0);
	targets = arraycombine(targets,satellites,1,0);
	targets = arraycombine(targets,dogs,1,0);
	if(targets.size <= 0)
	{
		return undefined;
	}

	targets = arraysort(targets,self.origin);
	foreach(target in targets)
	{
		if(IsDefined(target.owner) && target.owner == self.owner)
		{
		}
		else if(IsDefined(target.script_owner) && target.script_owner == self.owner)
		{
		}
		else if(level.teambased && IsDefined(target.team))
		{
			if(target.team == self.team)
			{
			}
			else if(level.teambased && IsDefined(target.aiteam))
			{
				if(target.aiteam == self.team)
				{
				}
				else
				{
					if(bullettracepassed(self.origin,target.origin,0,target))
					{
						ks["entity"] = target;
						return ks;
					}

					if(acceptskyexposure && cointoss())
					{
						end = 2048 + VectorScale((0,0,1));
						if(bullettracepassed(target.origin,end,0,target))
						{
							ks["entity"] = target;
							return ks;
						}
					}
				}
			}
		}
	}

	return undefined;
}

//Function Number: 21
projectile_find_target_player(acceptexposedtosky)
{
	target = [];
	players = get_players();
	players = arraysort(players,self.origin);
	foreach(player in players)
	{
		if(!(player_valid_target(player,self.team,self.owner)))
		{
		}
		else
		{
			if(bullettracepassed(self.origin,player.origin,0,player))
			{
				target["entity"] = player;
				target["offset"] = (0,0,0);
				return target;
			}

			if(bullettracepassed(self.origin,player geteye(),0,player))
			{
				target["entity"] = player;
				target["offset"] = VectorScale((0,0,1));
				return target;
			}

			if(acceptexposedtosky && cointoss())
			{
				end = 2048 + VectorScale((0,0,1));
				if(bullettracepassed(player.origin,end,0,player))
				{
					target["entity"] = player;
					target["offset"] = VectorScale((0,0,1));
					return target;
				}
			}
		}
	}

	return undefined;
}

//Function Number: 22
create_player_targeting_array(owner,team)
{
	level.playertargetedtimes = [];
	players = get_players();
	foreach(player in players)
	{
		if(!(player_valid_target(player,team,owner)))
		{
		}
		else
		{
			level.playertargetedtimes[player.clientid] = 0;
		}
	}
}

//Function Number: 23
projectile_find_random_player(owner,team)
{
	players = get_players();
	lowest = 10000;
	foreach(player in players)
	{
		if(!(player_valid_target(player,team,owner)))
		{
		}
		else
		{
			if(!(IsDefined(level.playertargetedtimes[player.clientid])))
			{
				level.playertargetedtimes[player.clientid] = 0;
			}

			if(level.playertargetedtimes[player.clientid] < lowest || level.playertargetedtimes[player.clientid] == lowest && randomint(100) > 50)
			{
				target = player;
				lowest = level.playertargetedtimes[player.clientid];
			}
		}
	}

	if(IsDefined(target))
	{
		level.playertargetedtimes[target.clientid] = level.playertargetedtimes[target.clientid] + 1;
		return target;
	}
}

//Function Number: 24
player_valid_target(player,team,owner)
{
	if(player.sessionstate != "playing")
	{
		return 0;
	}

	if(!(isalive(player)))
	{
		return 0;
	}

	if(player == owner)
	{
		return 0;
	}

	if(level.teambased)
	{
		if(team == player.team)
		{
			return 0;
		}
	}

	if(player cantargetplayerwithspecialty() == 0)
	{
		return 0;
	}

	if(IsDefined(player.lastspawntime) && GetTime() - player.lastspawntime < 3000)
	{
		return 0;
	}

/#
	return 0;
player isinmovemode("ufo","noclip")
#/
}