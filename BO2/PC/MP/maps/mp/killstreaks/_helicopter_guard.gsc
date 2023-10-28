/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_helicopter_guard.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 33
 * Decompile Time: 13 ms
 * Timestamp: 10/28/2023 12:10:43 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_heatseekingmissile;
#include maps/mp/_utility;
#include maps/mp/gametypes/_hostmigration;
#include maps/mp/gametypes/_spawning;
#include maps/mp/killstreaks/_airsupport;
#include maps/mp/killstreaks/_helicopter;
#include maps/mp/killstreaks/_killstreakrules;
#include maps/mp/killstreaks/_killstreaks;

//Function Number: 1
init()
{
	precachestring(&"MP_CIVILIAN_AIR_TRAFFIC");
	precachestring(&"MP_AIR_SPACE_TOO_CROWDED");
	precachevehicle("heli_guard_mp");
	precachemodel("veh_t6_drone_overwatch_light");
	precachemodel("veh_t6_drone_overwatch_dark");
	precacheturret("littlebird_guard_minigun_mp");
	precachemodel("veh_iw_littlebird_minigun_left");
	precachemodel("veh_iw_littlebird_minigun_right");
	registerkillstreak("helicopter_guard_mp","helicopter_guard_mp","killstreak_helicopter_guard","helicopter_used",::tryuseheliguardsupport,1);
	registerkillstreakaltweapon("helicopter_guard_mp","littlebird_guard_minigun_mp");
	registerkillstreakstrings("helicopter_guard_mp",&"KILLSTREAK_EARNED_HELICOPTER_GUARD",&"KILLSTREAK_HELICOPTER_GUARD_NOT_AVAILABLE",&"KILLSTREAK_HELICOPTER_GUARD_INBOUND");
	registerkillstreakdialog("helicopter_guard_mp","mpl_killstreak_lbguard_strt","kls_littlebird_used","","kls_littlebird_enemy","","kls_littlebird_ready");
	registerkillstreakdevdvar("helicopter_guard_mp","scr_givehelicopterguard");
	setkillstreakteamkillpenaltyscale("helicopter_guard_mp",0);
	shouldtimeout = setdvar("scr_heli_guard_no_timeout",0);
	debuglittlebird = setdvar("scr_heli_guard_debug",0);
	level._effect["heli_guard_light"]["friendly"] = loadfx("light/fx_vlight_mp_escort_eye_grn");
	level._effect["heli_guard_light"]["enemy"] = loadfx("light/fx_vlight_mp_escort_eye_red");
/#
	set_dvar_float_if_unset("scr_lbguard_timeout",60);
#/
	level.heliguardflyovernfz = 0;
	if(level.script == "mp_hydro")
	{
		level.heliguardflyovernfz = 1;
	}
}

//Function Number: 2
register()
{
	registerclientfield("helicopter","vehicle_is_firing",1,1,"int");
}

//Function Number: 3
tryuseheliguardsupport(lifeid)
{
	if(IsDefined(level.civilianjetflyby))
	{
		self iprintlnbold(&"MP_CIVILIAN_AIR_TRAFFIC");
		return 0;
	}

	if(self isremotecontrolling())
	{
		return 0;
	}

	if(!IsDefined(level.heli_paths) || level.heli_paths.size <= 0)
	{
		self iprintlnbold(&"MP_UNAVAILABLE_IN_LEVEL");
		return 0;
	}

	killstreak_id = self maps/mp/killstreaks/_killstreakrules::killstreakstart("helicopter_guard_mp",self.team,0,1);
	if(killstreak_id == -1)
	{
		return 0;
	}

	heliguard = createheliguardsupport(lifeid,killstreak_id);
	if(!(IsDefined(heliguard)))
	{
		return 0;
	}

	self thread startheliguardsupport(heliguard,lifeid);
	return 1;
}

//Function Number: 4
createheliguardsupport(lifeid,killstreak_id)
{
	hardpointtype = "helicopter_guard_mp";
	closeststartnode = heliguardsupport_getcloseststartnode(self.origin);
	if(IsDefined(closeststartnode.angles))
	{
		startang = closeststartnode.angles;
	}
	else
	{
		startang = (0,0,0);
	}

	closestnode = heliguardsupport_getclosestnode(self.origin);
	flyheight = max(self.origin[2] + 1600,getnoflyzoneheight(self.origin));
	forward = AnglesToForward(self.angles);
	targetpos = self.origin * (1,1,0) + (0,0,1) * flyheight + forward * -100;
	startpos = closeststartnode.origin;
	heliguard = spawnhelicopter(self,startpos,startang,"heli_guard_mp","veh_t6_drone_overwatch_light");
	if(!(IsDefined(heliguard)))
	{
		return;
	}

	target_set(heliguard,VectorScale((0,0,-1)));
	heliguard setenemymodel("veh_t6_drone_overwatch_dark");
	heliguard.speed = 150;
	heliguard.followspeed = 40;
	heliguard setcandamage(1);
	heliguard.owner = self;
	heliguard.team = self.team;
	heliguard setmaxpitchroll(45,45);
	heliguard setspeed(heliguard.speed,100,40);
	heliguard setyawspeed(120,60);
	heliguard setneargoalnotifydist(512);
	heliguard thread heliguardsupport_attacktargets();
	heliguard.killcount = 0;
	heliguard.streakname = "littlebird_support";
	heliguard.helitype = "littlebird";
	heliguard.targettingradius = 2000;
	heliguard.targetpos = targetpos;
	heliguard.currentnode = closestnode;
	heliguard.attract_strength = 10000;
	heliguard.attract_range = 150;
	heliguard.attractor = missile_createattractorent(heliguard,heliguard.attract_strength,heliguard.attract_range);
	heliguard.health = 999999;
	heliguard.maxhealth = level.heli_maxhealth;
	heliguard.rocketdamageoneshot = heliguard.maxhealth + 1;
	heliguard.crashtype = "explode";
	heliguard.destroyfunc = ::lbexplode;
	heliguard.targeting_delay = level.heli_targeting_delay;
	heliguard.hasdodged = 0;
	heliguard setdrawinfrared(1);
	self thread maps/mp/killstreaks/_helicopter::announcehelicopterinbound(hardpointtype);
	heliguard thread maps/mp/killstreaks/_helicopter::heli_targeting(0,hardpointtype);
	heliguard thread maps/mp/killstreaks/_helicopter::heli_damage_monitor(hardpointtype);
	heliguard thread maps/mp/killstreaks/_helicopter::heli_kill_monitor(hardpointtype);
	heliguard thread maps/mp/killstreaks/_helicopter::heli_health(hardpointtype,self,undefined);
	heliguard maps/mp/gametypes/_spawning::create_helicopter_influencers(heliguard.team);
	heliguard thread heliguardsupport_watchtimeout();
	heliguard thread heliguardsupport_watchownerloss();
	heliguard thread heliguardsupport_watchownerdamage();
	heliguard thread heliguardsupport_watchroundend();
	heliguard.numflares = 1;
	heliguard.flareoffset = (0,0,0);
	heliguard thread maps/mp/_heatseekingmissile::missiletarget_proximitydetonateincomingmissile("explode","death");
	heliguard thread create_flare_ent(VectorScale((0,0,-1)));
	heliguard.killstreak_id = killstreak_id;
	level.littlebirdguard = heliguard;
	return heliguard;
}

//Function Number: 5
getmeshheight(littlebird,owner)
{
	if(!(owner isinsideheightlock()))
	{
		return maps/mp/killstreaks/_airsupport::getminimumflyheight();
	}

	maxmeshheight = littlebird getheliheightlockheight(owner.origin);
	return max(maxmeshheight,owner.origin[2]);
}

//Function Number: 6
startheliguardsupport(littlebird,lifeid)
{
	level endon("game_ended");
	littlebird endon("death");
	littlebird setlookatent(self);
	maxmeshheight = getmeshheight(littlebird,self);
	height = getnoflyzoneheight((self.origin[0],self.origin[1],maxmeshheight));
	playermeshorigin = (self.origin[0],self.origin[1],height);
	vectostart = vectornormalize(littlebird.origin - littlebird.targetpos);
	dist = 1500;
	target = littlebird.targetpos + vectostart * dist;
	for(collide = crossesnoflyzone(target,playermeshorigin);IsDefined(collide) && dist > 0;collide = crossesnoflyzone(target,playermeshorigin))
	{
		dist = dist - 500;
		target = littlebird.targetpos + vectostart * dist;
	}

	littlebird setvehgoalpos(target,1);
	target_setturretaquire(littlebird,0);
	littlebird waittill("near_goal");
	target_setturretaquire(littlebird,1);
	littlebird setvehgoalpos(playermeshorigin,1);
	littlebird waittill("near_goal");
	littlebird setspeed(littlebird.speed,80,30);
	littlebird waittill("goal");
/#
	if(GetDvar(#"2CF8CBA6") == "1")
	{
		debug_no_fly_zones();
	}
#/
	littlebird thread heliguardsupport_followplayer();
}

//Function Number: 7
heliguardsupport_followplayer()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	if(!(IsDefined(self.owner)))
	{
		self thread heliguardsupport_leave();
		return;
	}

	self.owner endon("disconnect");
	self.owner endon("joined_team");
	self.owner endon("joined_spectators");
	self setspeed(self.followspeed,20,20);
	while(1)
	{
		if(IsDefined(self.owner) && isalive(self.owner))
		{
			heliguardsupport_movetoplayer();
		}

		wait(3);
	}
}

//Function Number: 8
heliguardsupport_movetoplayer()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.owner endon("death");
	self.owner endon("disconnect");
	self.owner endon("joined_team");
	self.owner endon("joined_spectators");
	self notify("heliGuardSupport_moveToPlayer");
	self endon("heliGuardSupport_moveToPlayer");
	maxmeshheight = getmeshheight(self,self.owner);
	hovergoal = (self.owner.origin[0],self.owner.origin[1],maxmeshheight);
/#
	littlebird_debug_line(self.origin,hovergoal,(1,0,0));
#/
	zoneindex = crossesnoflyzone(self.origin,hovergoal);
	if(IsDefined(zoneindex) && level.heliguardflyovernfz)
	{
		self.intransit = 1;
		noflyzoneheight = getnoflyzoneheightcrossed(hovergoal,self.origin,maxmeshheight);
		self setvehgoalpos((hovergoal[0],hovergoal[1],noflyzoneheight),1);
		self waittill("goal");
		return;
	}

	if(IsDefined(zoneindex))
	{
/#
		littlebird_debug_text("NO FLY ZONE between heli and hoverGoal");
#/
		dist = distance2d(self.owner.origin,level.noflyzones[zoneindex].origin);
		zoneorgtoplayer2d = self.owner.origin - level.noflyzones[zoneindex].origin;
		zoneorgtoplayer2d = zoneorgtoplayer2d * (1,1,0);
		zoneorgtochopper2d = self.origin - level.noflyzones[zoneindex].origin;
		zoneorgtochopper2d = zoneorgtochopper2d * (1,1,0);
		zoneorgatmeshheight = (level.noflyzones[zoneindex].origin[0],level.noflyzones[zoneindex].origin[1],maxmeshheight);
		zoneorgtoadjpos = VectorScale(vectornormalize(zoneorgtoplayer2d));
		adjacentgoalpos = zoneorgtoadjpos + level.noflyzones[zoneindex].origin;
		adjacentgoalpos = (adjacentgoalpos[0],adjacentgoalpos[1],maxmeshheight);
		zoneorgtoperpendicular = (zoneorgtoadjpos[1],zoneorgtoadjpos[0] * -1,0);
		zoneorgtooppositeperpendicular = (zoneorgtoadjpos[1] * -1,zoneorgtoadjpos[0],0);
		perpendiculargoalpos = zoneorgtoperpendicular + zoneorgatmeshheight;
		oppositeperpendiculargoalpos = zoneorgtooppositeperpendicular + zoneorgatmeshheight;
/#
		littlebird_debug_line(self.origin,perpendiculargoalpos,(0,0,1));
		littlebird_debug_line(self.origin,oppositeperpendiculargoalpos,(0.2,0.6,1));
#/
		if(dist < level.noflyzones[zoneindex].radius)
		{
/#
			littlebird_debug_text("Owner is in a no fly zone, find perimeter hover goal");
			littlebird_debug_line(self.origin,adjacentgoalpos,(0,1,0));
#/
			zoneindex = undefined;
			zoneindex = crossesnoflyzone(self.origin,adjacentgoalpos);
			if(IsDefined(zoneindex))
			{
/#
				littlebird_debug_text("adjacentGoalPos is through no fly zone, move to perpendicular edge of cyl");
#/
				hovergoal = perpendiculargoalpos;
			}
			else
			{
/#
				littlebird_debug_text("adjacentGoalPos is NOT through fly zone, move to edge closest to player");
#/
				hovergoal = adjacentgoalpos;
			}
		}
		else
		{
/#
			littlebird_debug_text("Owner outside no fly zone, navigate around perimeter");
			littlebird_debug_line(self.origin,perpendiculargoalpos,(0,0,1));
#/
			hovergoal = perpendiculargoalpos;
		}
	}

	zoneindex = undefined;
	zoneindex = crossesnoflyzone(self.origin,hovergoal);
	if(IsDefined(zoneindex))
	{
/#
		littlebird_debug_text("Try opposite perimeter goal");
#/
		hovergoal = oppositeperpendiculargoalpos;
	}

	self.intransit = 1;
	self setvehgoalpos((hovergoal[0],hovergoal[1],maxmeshheight),1);
	self waittill(level.noflyzones[zoneindex].radius + 150,"goal");
}

//Function Number: 9
heliguardsupport_movetoplayervertical(maxmeshheight)
{
	height = getnoflyzoneheightcrossed(self.origin,self.owner.origin,maxmeshheight);
	upperheight = max(self.origin[2],height);
	acquireupperheight = (self.origin[0],self.origin[1],upperheight);
	hoveroverplayer = (self.owner.origin[0],self.owner.origin[1],upperheight);
	hovercorrectheight = (self.owner.origin[0],self.owner.origin[1],height);
	self.intransit = 1;
	self setvehgoalpos(acquireupperheight,1);
	self waittill("goal");
	self setvehgoalpos(hoveroverplayer,1);
	self waittill("goal");
	self setvehgoalpos(hovercorrectheight,1);
	self waittill("goal");
	self.intransit = 0;
}

//Function Number: 10
heliguardsupport_watchtimeout()
{
	level endon("game_ended");
	self endon("death");
	self.owner endon("disconnect");
	self.owner endon("joined_team");
	self.owner endon("joined_spectators");
	timeout = 60;
/#
	timeout = GetDvarFloat(#"E449EBB3");
#/
	maps/mp/gametypes/_hostmigration::waitlongdurationwithhostmigrationpause(timeout);
	shouldtimeout = GetDvar(#"C2866782");
	if(shouldtimeout == "1")
	{
		return;
	}

	self thread heliguardsupport_leave();
}

//Function Number: 11
heliguardsupport_watchownerloss()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.owner waittill_any("disconnect","joined_team","joined_spectators");
	self thread heliguardsupport_leave();
}

//Function Number: 12
heliguardsupport_watchownerdamage()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.owner endon("disconnect");
	self.owner endon("joined_team");
	self.owner endon("joined_spectators");
	while(1)
	{
		self.owner waittill("damage",damage,attacker,direction_vec,point,meansofdeath,modelname,tagname,partname,weapon,idflags);
		if(isplayer(attacker))
		{
			if(attacker != self.owner && distance2d(attacker.origin,self.origin) <= self.targettingradius && attacker cantargetplayerwithspecialty())
			{
				self setlookatent(attacker);
				self setgunnertargetent(attacker,VectorScale((0,0,1)),50);
				self setturrettargetent(attacker,VectorScale((0,0,1)));
			}
		}
	}
}

//Function Number: 13
heliguardsupport_watchroundend()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.owner endon("disconnect");
	self.owner endon("joined_team");
	self.owner endon("joined_spectators");
	level waittill("round_end_finished");
	self thread heliguardsupport_leave();
}

//Function Number: 14
heliguardsupport_leave()
{
	self endon("death");
	self notify("leaving");
	level.littlebirdguard = undefined;
	self cleargunnertarget(0);
	self clearturrettarget();
	self clearlookatent();
	flyheight = getnoflyzoneheight(self.origin);
	targetpos = self.origin + AnglesToForward(self.angles) * 1500 + (0,0,flyheight);
	collide = crossesnoflyzone(self.origin,targetpos);
	for(tries = 5;IsDefined(collide) && tries > 0;tries--)
	{
		yaw = randomint(360);
		targetpos = self.origin + AnglesToForward((self.angles[0],yaw,self.angles[2])) * 1500 + (0,0,flyheight);
		collide = crossesnoflyzone(self.origin,targetpos);
	}

	if(tries == 0)
	{
		targetpos = self.origin + (0,0,flyheight);
	}

	self setspeed(self.speed,80);
	self setmaxpitchroll(45,180);
	self setvehgoalpos(targetpos);
	self waittill("goal");
	targetpos = targetpos + AnglesToForward((0,self.angles[1],self.angles[2])) * 14000;
	self setvehgoalpos(targetpos);
	self waittill("goal");
	self notify("gone");
	self removelittlebird();
}

//Function Number: 15
helidestroyed()
{
	level.littlebirdguard = undefined;
	if(!(IsDefined(self)))
	{
		return;
	}

	self setspeed(25,5);
	self thread lbspin(randomintrange(180,220));
	wait(randomfloatrange(0.5,1.5));
	lbexplode();
}

//Function Number: 16
lbexplode()
{
	self notify("explode");
	self removelittlebird();
}

//Function Number: 17
lbspin(speed)
{
	self endon("explode");
	playfxontag(level.chopper_fx["explode"]["large"],self,"tail_rotor_jnt");
	self thread trail_fx(level.chopper_fx["smoke"]["trail"],"tail_rotor_jnt","stop tail smoke");
	self setyawspeed(speed,speed,speed);
	while(IsDefined(self))
	{
		self settargetyaw(self.angles[1] + speed * 0.9);
		wait(1);
	}
}

//Function Number: 18
trail_fx(trail_fx,trail_tag,stop_notify)
{
	self notify(stop_notify);
	self endon(stop_notify);
	self endon("death");
	for(;;)
	{
		playfxontag(trail_fx,self,trail_tag);
		wait(0.05);
	}
}

//Function Number: 19
removelittlebird()
{
	level.lbstrike = 0;
	maps/mp/killstreaks/_killstreakrules::killstreakstop("helicopter_guard_mp",self.team,self.killstreak_id);
	if(IsDefined(self.marker))
	{
		self.marker delete();
	}

	self delete();
}

//Function Number: 20
heliguardsupport_watchsamproximity(player,missileteam,missiletarget,missilegroup)
{
	level endon("game_ended");
	missiletarget endon("death");
	for(i = 0;i < missilegroup.size;i++)
	{
		if(IsDefined(missilegroup[i]) && !missiletarget.hasdodged)
		{
			missiletarget.hasdodged = 1;
			newtarget = spawn("script_origin",missiletarget.origin);
			newtarget.angles = missiletarget.angles;
			newtarget movegravity(AnglesToRight(missilegroup[i].angles) * -1000,0.05);
			for(j = 0;j < missilegroup.size;j++)
			{
				if(IsDefined(missilegroup[j]))
				{
					missilegroup[j] settargetentity(newtarget);
				}
			}

			dodgepoint = missiletarget.origin + AnglesToRight(missilegroup[i].angles) * 200;
			missiletarget setspeed(missiletarget.speed,100,40);
			missiletarget setvehgoalpos(dodgepoint,1);
			wait(2);
			missiletarget setspeed(missiletarget.followspeed,20,20);
			break;
		}
	}
}

//Function Number: 21
heliguardsupport_getcloseststartnode(pos)
{
	closestnode = undefined;
	closestdistance = 999999;
	foreach(path in level.heli_paths)
	{
		foreach(loc in path)
		{
			nodedistance = distance(loc.origin,pos);
			if(nodedistance < closestdistance)
			{
				closestnode = loc;
				closestdistance = nodedistance;
			}
		}
	}

	return closestnode;
}

//Function Number: 22
heliguardsupport_getclosestnode(pos)
{
	closestnode = undefined;
	closestdistance = 999999;
	foreach(loc in level.heli_loop_paths)
	{
		nodedistance = distance(loc.origin,pos);
		if(nodedistance < closestdistance)
		{
			closestnode = loc;
			closestdistance = nodedistance;
		}
	}

	return closestnode;
}

//Function Number: 23
littlebird_debug_text(string)
{
/#
	if(GetDvar(#"2CF8CBA6") == "1")
	{
		iprintln(string);
	}
#/
}

//Function Number: 24
littlebird_debug_line(start,end,color)
{
/#
	if(GetDvar(#"2CF8CBA6") == "1")
	{
		line(start,end,color,1,1,300);
	}
#/
}

//Function Number: 25
heli_path_debug()
{
/#
	foreach(path in level.heli_paths)
	{
		foreach(loc in path)
		{
			prev = loc;
			target = loc.target;
			while(IsDefined(target))
			{
				target = getent(target,"targetname");
				line(prev.origin,target.origin,(1,0,0),1,0,50000);
				debugstar(prev.origin,50000,(0,1,0));
				prev = target;
				target = prev.target;
			}
		}
	}

	foreach(loc in level.heli_loop_paths)
	{
		prev = loc;
		target = loc.target;
		first = loc;
		while(IsDefined(target))
		{
			target = getent(target,"targetname");
			line(prev.origin,target.origin,(0,1,0),1,0,50000);
			debugstar(prev.origin,50000,(1,0,0));
			prev = target;
			target = prev.target;
			if(prev == first)
			{
				break;
			}
		}
	}
#/
}

//Function Number: 26
heliguardsupport_getclosestlinkednode(pos)
{
	closestnode = undefined;
	totaldistance = distance2d(self.currentnode.origin,pos);
	closestdistance = totaldistance;
	target = self.currentnode.target;
	while(IsDefined(target))
	{
		nextnode = getent(target,"targetname");
		if(nextnode == self.currentnode)
		{
			break;
		}

		nodedistance = distance2d(nextnode.origin,pos);
		if(nodedistance < totaldistance && nodedistance < closestdistance)
		{
			closestnode = nextnode;
			closestdistance = nodedistance;
		}

		target = nextnode.target;
	}

	return closestnode;
}

//Function Number: 27
heliguardsupport_arraycontains(array,compare)
{
	if(array.size <= 0)
	{
		return 0;
	}

	foreach(member in array)
	{
		if(member == compare)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 28
heliguardsupport_getlinkedstructs()
{
	array = [];
	return array;
}

//Function Number: 29
heliguardsupport_setairstartnodes()
{
	level.air_start_nodes = getstructarray("chopper_boss_path_start","targetname");
	foreach(loc in level.air_start_nodes)
	{
		loc.neighbors = loc heliguardsupport_getlinkedstructs();
	}
}

//Function Number: 30
heliguardsupport_setairnodemesh()
{
	level.air_node_mesh = getstructarray("so_chopper_boss_path_struct","script_noteworthy");
	foreach(loc in level.air_node_mesh)
	{
		loc.neighbors = loc heliguardsupport_getlinkedstructs();
		foreach(other_loc in level.air_node_mesh)
		{
			if(loc == other_loc)
			{
			}
			else if(!heliguardsupport_arraycontains(loc.neighbors,other_loc) && heliguardsupport_arraycontains(other_loc heliguardsupport_getlinkedstructs(),loc))
			{
				loc.neighbors[loc.neighbors.size] = other_loc;
			}
		}
	}
}

//Function Number: 31
heliguardsupport_attacktargets()
{
	self endon("death");
	level endon("game_ended");
	self endon("leaving");
	self heliguardsupport_firestart();
}

//Function Number: 32
heliguardsupport_firestart()
{
	self endon("death");
	self endon("leaving");
	self endon("stop_shooting");
	level endon("game_ended");
	for(;;)
	{
		numshots = randomintrange(10,21);
		if(!(IsDefined(self.primarytarget)))
		{
			self waittill("primary acquired");
		}

		if(IsDefined(self.primarytarget))
		{
			targetent = self.primarytarget;
			self thread heliguardsupport_firestop(targetent);
			self setlookatent(targetent);
			self setgunnertargetent(targetent,VectorScale((0,0,1)),50);
			self setturrettargetent(targetent,VectorScale((0,0,1)));
			self waittill(0,50,"turret_on_target");
			wait(0.2);
			self setclientfield("vehicle_is_firing",1);
			for(i = 0;i < numshots;i++)
			{
				self firegunnerweapon(0,self);
				self fireweapon();
				wait(0.15);
			}
		}

		self setclientfield("vehicle_is_firing",0);
		self clearturrettarget();
		self cleargunnertarget(0);
		wait(randomfloatrange(1,2));
	}
}

//Function Number: 33
heliguardsupport_firestop(targetent)
{
	self endon("death");
	self endon("leaving");
	self notify("heli_guard_target_death_watcher");
	self endon("heli_guard_target_death_watcher");
	targetent waittill_any("death","disconnect");
	self setclientfield("vehicle_is_firing",0);
	self notify("stop_shooting");
	self.primarytarget = undefined;
	self setlookatent(self.owner);
	self cleargunnertarget(0);
	self clearturrettarget();
}