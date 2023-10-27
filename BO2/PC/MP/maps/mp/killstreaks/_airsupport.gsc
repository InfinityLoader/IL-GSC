/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_airsupport.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 53
 * Decompile Time: 192 ms
 * Timestamp: 10/27/2023 3:00:34 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/gametypes/_weapons;

//Function Number: 1
initairsupport()
{
	if(!(IsDefined(level.airsupportheightscale)))
	{
		level.airsupportheightscale = 1;
	}

	level.airsupportheightscale = getdvarintdefault("scr_airsupportHeightScale",level.airsupportheightscale);
	level.noflyzones = [];
	level.noflyzones = getentarray("no_fly_zone","targetname");
	airsupport_heights = getstructarray("air_support_height","targetname");
/#
	error("Found more then one \'air_support_height\' structs in the map");
airsupport_heights.size > 1
#/
	airsupport_heights = getentarray("air_support_height","targetname");
/#
	error("Found an entity in the map with an \'air_support_height\' targetname.  There should be only structs.");
airsupport_heights.size > 0
#/
	heli_height_meshes = getentarray("heli_height_lock","classname");
/#
	error("Found more then one \'heli_height_lock\' classname in the map");
heli_height_meshes.size > 1
#/
}

//Function Number: 2
finishhardpointlocationusage(location,usedcallback)
{
	self notify("used");
	wait(0.05);
	return self [[ usedcallback ]](location);
}

//Function Number: 3
finishdualhardpointlocationusage(locationstart,locationend,usedcallback)
{
	self notify("used");
	wait(0.05);
	return self [[ usedcallback ]](locationstart,locationend);
}

//Function Number: 4
endselectionongameend()
{
	self endon("death");
	self endon("disconnect");
	self endon("cancel_location");
	self endon("used");
	self endon("host_migration_begin");
	level waittill("game_ended");
	self notify("game_ended");
}

//Function Number: 5
endselectiononhostmigration()
{
	self endon("death");
	self endon("disconnect");
	self endon("cancel_location");
	self endon("used");
	self endon("game_ended");
	level waittill("host_migration_begin");
	self notify("cancel_location");
}

//Function Number: 6
endselectionthink()
{
/#
	assert(isplayer(self));
#/
/#
	assert(isalive(self));
#/
/#
	assert(IsDefined(self.selectinglocation));
#/
/#
	assert(self.selectinglocation == 1);
#/
	self thread endselectionongameend();
	self thread endselectiononhostmigration();
	event = self waittill_any_return("death","disconnect","cancel_location","game_ended","used","weapon_change","emp_jammed");
	if(event != "disconnect")
	{
		self endlocationselection();
		self.selectinglocation = undefined;
	}

	if(event != "used")
	{
		self notify("confirm_location",undefined,undefined);
	}
}

//Function Number: 7
stoploopsoundaftertime(time)
{
	self endon("death");
	wait(time);
	self stoploopsound(2);
}

//Function Number: 8
calculatefalltime(flyheight)
{
	gravity = GetDvarInt(#"55F139D3");
	time = sqrt(2 * flyheight / gravity);
	return time;
}

//Function Number: 9
calculatereleasetime(flytime,flyheight,flyspeed,bombspeedscale)
{
	falltime = calculatefalltime(flyheight);
	bomb_x = flyspeed * bombspeedscale * falltime;
	release_time = bomb_x / flyspeed;
	return flytime * 0.5 - release_time;
}

//Function Number: 10
getminimumflyheight()
{
	airsupport_height = getstruct("air_support_height","targetname");
	if(IsDefined(airsupport_height))
	{
		planeflyheight = airsupport_height.origin[2];
	}
	else
	{
/#
		println("WARNING:  Missing air_support_height entity in the map.  Using default height.");
#/
		planeflyheight = 850;
		if(IsDefined(level.airsupportheightscale))
		{
			level.airsupportheightscale = getdvarintdefault("scr_airsupportHeightScale",level.airsupportheightscale);
			planeflyheight = planeflyheight * getdvarintdefault("scr_airsupportHeightScale",level.airsupportheightscale);
		}

		if(IsDefined(level.forceairsupportmapheight))
		{
			planeflyheight = planeflyheight + level.forceairsupportmapheight;
		}
	}

	return planeflyheight;
}

//Function Number: 11
callstrike(flightplan)
{
	level.bomberdamagedents = [];
	level.bomberdamagedentscount = 0;
	level.bomberdamagedentsindex = 0;
/#
	assert(flightplan.distance != 0,"callStrike can not be passed a zero fly distance");
#/
	planehalfdistance = flightplan.distance / 2;
	path = getstrikepath(flightplan.target,flightplan.height,planehalfdistance);
	startpoint = path["start"];
	endpoint = path["end"];
	flightplan.height = path["height"];
	direction = path["direction"];
	d = length(startpoint - endpoint);
	flytime = d / flightplan.speed;
	bombtime = calculatereleasetime(flytime,flightplan.height,flightplan.speed,flightplan.bombspeedscale);
	if(bombtime < 0)
	{
		bombtime = 0;
	}

/#
	assert(flytime > bombtime);
#/
	flightplan.owner endon("disconnect");
	requireddeathcount = flightplan.owner.deathcount;
	side = vectorcross(AnglesToForward(direction),(0,0,1));
	plane_seperation = 25;
	side_offset = VectorScale(side);
	level thread planestrike(flightplan.owner,requireddeathcount,startpoint,endpoint,bombtime,flytime,flightplan.speed,flightplan.bombspeedscale,direction,flightplan.planespawncallback);
	wait(flightplan.planespacing);
	level thread planestrike(flightplan.owner,requireddeathcount,startpoint + side_offset,endpoint + side_offset,bombtime,flytime,flightplan.speed,flightplan.bombspeedscale,direction,flightplan.planespawncallback);
	wait(flightplan.planespacing);
	side_offset = VectorScale(side);
	level thread planestrike(flightplan.owner,requireddeathcount,startpoint + side_offset,endpoint + side_offset,bombtime,flytime,flightplan.speed,flightplan.bombspeedscale,direction,flightplan.planespawncallback);
}

//Function Number: 12
planestrike(owner,requireddeathcount,pathstart,pathend,bombtime,flytime,flyspeed,bombspeedscale,direction,planespawnedfunction)
{
	if(!(IsDefined(owner)))
	{
		return;
	}

	plane = spawnplane(owner,"script_model",pathstart);
	plane.angles = direction;
	plane moveto(pathend,flytime,0,0);
	thread debug_plane_line(flytime,flyspeed,pathstart,pathend);
	if(IsDefined(planespawnedfunction))
	{
		plane [[ planespawnedfunction ]](owner,requireddeathcount,pathstart,pathend,bombtime,bombspeedscale,flytime,flyspeed);
	}

	wait(flytime);
	plane notify("delete");
	plane delete();
}

//Function Number: 13
determinegroundpoint(player,position)
{
	ground = (position[0],position[1],player.origin[2]);
	trace = bullettrace(10000 + VectorScale((0,0,1)),ground,ground,0);
	return trace["position"];
}

//Function Number: 14
determinetargetpoint(player,position)
{
	point = determinegroundpoint(player,position);
	return clamptarget(point);
}

//Function Number: 15
getmintargetheight()
{
	return level.spawnmins[2] - 500;
}

//Function Number: 16
getmaxtargetheight()
{
	return level.spawnmaxs[2] + 500;
}

//Function Number: 17
clamptarget(target)
{
	min = getmintargetheight();
	max = getmaxtargetheight();
	if(target[2] < min)
	{
		target[2] = min;
	}

	if(target[2] > max)
	{
		target[2] = max;
	}

	return target;
}

//Function Number: 18
_insidecylinder(point,base,radius,height)
{
	if(IsDefined(height))
	{
		if(point[2] > base[2] + height)
		{
			return 0;
		}
	}

	dist = distance2d(point,base);
	if(dist < radius)
	{
		return 1;
	}

	return 0;
}

//Function Number: 19
_insidenoflyzonebyindex(point,index,disregardheight)
{
	height = level.noflyzones[index].height;
	if(IsDefined(disregardheight))
	{
		height = undefined;
	}

	return _insidecylinder(point,level.noflyzones[index].origin,level.noflyzones[index].radius,height);
}

//Function Number: 20
getnoflyzoneheight(point)
{
	height = point[2];
	origin = undefined;
	for(i = 0;i < level.noflyzones.size;i++)
	{
		if(_insidenoflyzonebyindex(point,i))
		{
			if(height < level.noflyzones[i].height)
			{
				height = level.noflyzones[i].height;
				origin = level.noflyzones[i].origin;
			}
		}
	}

	if(!(IsDefined(origin)))
	{
		return point[2];
	}

	return origin[2] + height;
}

//Function Number: 21
insidenoflyzones(point,disregardheight)
{
	noflyzones = [];
	for(i = 0;i < level.noflyzones.size;i++)
	{
		if(_insidenoflyzonebyindex(point,i,disregardheight))
		{
			noflyzones[noflyzones.size] = i;
		}
	}

	return noflyzones;
}

//Function Number: 22
crossesnoflyzone(start,end)
{
	for(i = 0;i < level.noflyzones.size;i++)
	{
		point = closestpointonline(level.noflyzones[i].origin + (0,0,0.5 * level.noflyzones[i].height),start,end);
		dist = distance2d(point,level.noflyzones[i].origin);
		if(point[2] > level.noflyzones[i].origin[2] + level.noflyzones[i].height)
		{
		}
		else if(dist < level.noflyzones[i].radius)
		{
			return i;
		}
	}

	return undefined;
}

//Function Number: 23
crossesnoflyzones(start,end)
{
	zones = [];
	for(i = 0;i < level.noflyzones.size;i++)
	{
		point = closestpointonline(level.noflyzones[i].origin,start,end);
		dist = distance2d(point,level.noflyzones[i].origin);
		if(point[2] > level.noflyzones[i].origin[2] + level.noflyzones[i].height)
		{
		}
		else if(dist < level.noflyzones[i].radius)
		{
			zones[zones.size] = i;
		}
	}

	return zones;
}

//Function Number: 24
getnoflyzoneheightcrossed(start,end,minheight)
{
	height = minheight;
	for(i = 0;i < level.noflyzones.size;i++)
	{
		point = closestpointonline(level.noflyzones[i].origin,start,end);
		dist = distance2d(point,level.noflyzones[i].origin);
		if(dist < level.noflyzones[i].radius)
		{
			if(height < level.noflyzones[i].height)
			{
				height = level.noflyzones[i].height;
			}
		}
	}

	return height;
}

//Function Number: 25
_shouldignorenoflyzone(noflyzone,noflyzones)
{
	if(!(IsDefined(noflyzone)))
	{
		return 1;
	}

	for(i = 0;i < noflyzones.size;i++)
	{
		if(IsDefined(noflyzones[i]) && noflyzones[i] == noflyzone)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 26
_shouldignorestartgoalnoflyzone(noflyzone,startnoflyzones,goalnoflyzones)
{
	if(!(IsDefined(noflyzone)))
	{
		return 1;
	}

	if(_shouldignorenoflyzone(noflyzone,startnoflyzones))
	{
		return 1;
	}

	if(_shouldignorenoflyzone(noflyzone,goalnoflyzones))
	{
		return 1;
	}

	return 0;
}

//Function Number: 27
gethelipath(start,goal)
{
	startnoflyzones = insidenoflyzones(start,1);
	thread debug_line(start,goal,(1,1,1));
	goalnoflyzones = insidenoflyzones(goal);
	if(goalnoflyzones.size)
	{
		goal = (goal[0],goal[1],getnoflyzoneheight(goal));
	}

	goal_points = calculatepath(start,goal,startnoflyzones,goalnoflyzones);
	if(!(IsDefined(goal_points)))
	{
		return undefined;
	}

/#
	assert(goal_points.size >= 1);
#/
	return goal_points;
}

//Function Number: 28
followpath(path,donenotify,stopatgoal)
{
	for(i = 0;i < path.size - 1;i++)
	{
		self setvehgoalpos(path[i],0);
		thread debug_line(self.origin,path[i],(1,1,0));
		self waittill("goal");
	}

	self setvehgoalpos(path[path.size - 1],stopatgoal);
	thread debug_line(self.origin,path[i],(1,1,0));
	self waittill("goal");
	if(IsDefined(donenotify))
	{
		self notify(donenotify);
	}
}

//Function Number: 29
setgoalposition(goal,donenotify,stopatgoal)
{
	if(!(IsDefined(stopatgoal)))
	{
		stopatgoal = 1;
	}

	start = self.origin;
	goal_points = gethelipath(start,goal);
	if(!(IsDefined(goal_points)))
	{
		goal_points = [];
		goal_points[0] = goal;
	}

	followpath(goal_points,donenotify,stopatgoal);
}

//Function Number: 30
clearpath(start,end,startnoflyzone,goalnoflyzone)
{
	noflyzones = crossesnoflyzones(start,end);
	for(i = 0;i < noflyzones.size;i++)
	{
		if(!(_shouldignorestartgoalnoflyzone(noflyzones[i],startnoflyzone,goalnoflyzone)))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 31
append_array(dst,src)
{
	for(i = 0;i < src.size;i++)
	{
		dst[dst.size] = src[i];
	}
}

//Function Number: 32
calculatepath_r(start,end,points,startnoflyzones,goalnoflyzones,depth)
{
	depth--;
	if(depth <= 0)
	{
		points[points.size] = end;
		return points;
	}

	noflyzones = crossesnoflyzones(start,end);
	for(i = 0;i < noflyzones.size;i++)
	{
		noflyzone = noflyzones[i];
		if(!(_shouldignorestartgoalnoflyzone(noflyzone,startnoflyzones,goalnoflyzones)))
		{
			return undefined;
		}
	}

	points[points.size] = end;
	return points;
}

//Function Number: 33
calculatepath(start,end,startnoflyzones,goalnoflyzones)
{
	points = [];
	points = calculatepath_r(start,end,points,startnoflyzones,goalnoflyzones,3);
	if(!(IsDefined(points)))
	{
		return undefined;
	}

/#
	assert(points.size >= 1);
#/
	debug_sphere(points[points.size - 1],10,(1,0,0),1,1000);
	point = start;
	for(i = 0;i < points.size;i++)
	{
		thread debug_line(point,points[i],(0,1,0));
		debug_sphere(points[i],10,(0,0,1),1,1000);
		point = points[i];
	}

	return points;
}

//Function Number: 34
_getstrikepathstartandend(goal,yaw,halfdistance)
{
	direction = (0,yaw,0);
	startpoint = -1 * halfdistance + VectorScale(AnglesToForward(direction));
	endpoint = halfdistance + VectorScale(AnglesToForward(direction));
	noflyzone = crossesnoflyzone(startpoint,endpoint);
	path = [];
	if(IsDefined(noflyzone))
	{
		path["noFlyZone"] = noflyzone;
		startpoint = (startpoint[0],startpoint[1],level.noflyzones[noflyzone].origin[2] + level.noflyzones[noflyzone].height);
		endpoint = (endpoint[0],endpoint[1],startpoint[2]);
	}
	else
	{
		path["noFlyZone"] = undefined;
	}

	path["start"] = startpoint;
	path["end"] = endpoint;
	path["direction"] = direction;
	return path;
}

//Function Number: 35
getstrikepath(target,height,halfdistance,yaw)
{
	noflyzoneheight = getnoflyzoneheight(target);
	worldheight = target[2] + height;
	if(noflyzoneheight > worldheight)
	{
		worldheight = noflyzoneheight;
	}

	goal = (target[0],target[1],worldheight);
	path = [];
	if(!IsDefined(yaw) || yaw != "random")
	{
		for(i = 0;i < 3;i++)
		{
			path = _getstrikepathstartandend(goal,randomint(360),halfdistance);
			if(!(IsDefined(path["noFlyZone"])))
			{
				break;
			}
		}
	}
	else
	{
		path = _getstrikepathstartandend(goal,yaw,halfdistance);
	}

	path["height"] = worldheight - target[2];
	return path;
}

//Function Number: 36
doglassdamage(pos,radius,max,min,mod)
{
	wait(randomfloatrange(0.05,0.15));
	glassradiusdamage(pos,radius,max,min,mod);
}

//Function Number: 37
entlosradiusdamage(ent,pos,radius,max,min,owner,einflictor)
{
	dist = distance(pos,ent.damagecenter);
	if(ent.isplayer || ent.isactor)
	{
		assumed_ceiling_height = 800;
		eye_position = ent.entity geteye();
		head_height = eye_position[2];
		debug_display_time = 4000;
		trace = maps/mp/gametypes/_weapons::weapondamagetrace(ent.entity.origin,ent.entity.origin + (0,0,assumed_ceiling_height),0,undefined);
		indoors = trace["fraction"] != 1;
		if(indoors)
		{
			test_point = trace["position"];
			debug_star(test_point,(0,1,0),debug_display_time);
			trace = maps/mp/gametypes/_weapons::weapondamagetrace((test_point[0],test_point[1],head_height),(pos[0],pos[1],head_height),0,undefined);
			indoors = trace["fraction"] != 1;
			if(indoors)
			{
				debug_star((pos[0],pos[1],head_height),(0,1,0),debug_display_time);
				dist = dist * 4;
				if(dist > radius)
				{
					return 0;
				}
			}
			else
			{
				debug_star((pos[0],pos[1],head_height),(1,0,0),debug_display_time);
				trace = maps/mp/gametypes/_weapons::weapondamagetrace((pos[0],pos[1],head_height),pos,0,undefined);
				indoors = trace["fraction"] != 1;
				if(indoors)
				{
					debug_star(pos,(0,1,0),debug_display_time);
					dist = dist * 4;
					if(dist > radius)
					{
						return 0;
					}
				}
				else
				{
					debug_star(pos,(1,0,0),debug_display_time);
				}
			}
		}
		else
		{
			debug_star(ent.entity.origin + (0,0,assumed_ceiling_height),(1,0,0),debug_display_time);
		}
	}

	ent.damage = int(max + min - max * dist / radius);
	ent.pos = pos;
	ent.damageowner = owner;
	ent.einflictor = einflictor;
	return 1;
}

//Function Number: 38
debug_no_fly_zones()
{
/#
	i = 0;
	for(;;)
	{
		debug_cylinder(level.noflyzones[i].origin,level.noflyzones[i].radius,level.noflyzones[i].height,(1,1,1),undefined,5000);
		i++;
	}
i < level.noflyzones.size
#/
}

//Function Number: 39
debug_plane_line(flytime,flyspeed,pathstart,pathend)
{
	thread debug_line(pathstart,pathend,(1,1,1));
	delta = vectornormalize(pathend - pathstart);
	for(i = 0;i < flytime;i++)
	{
		thread debug_star(i * flyspeed + VectorScale(delta),pathstart);
	}
}

//Function Number: 40
debug_draw_bomb_explosion(prevpos)
{
	self notify("draw_explosion");
	wait(0.05);
	self endon("draw_explosion");
	self waittill("projectile_impact",weapon,position);
	thread debug_line(prevpos,position,(0.5,1,0));
	thread debug_star(position,(1,0,0));
}

//Function Number: 41
debug_draw_bomb_path(projectile,color,time)
{
/#
	self endon("death");
	level.airsupport_debug = getdvarintdefault("scr_airsupport_debug",0);
	color = (0.5,1,0);
	prevpos = self.origin;
	for(;;)
	{
		thread debug_line(prevpos,self.origin,color,time);
		prevpos = self.origin;
		thread debug_draw_bomb_explosion(prevpos);
		wait(0.2);
	}
IsDefined(projectile) && projectile
IsDefined(self.origin)
IsDefined(level.airsupport_debug) && level.airsupport_debug == 1
IsDefined(color)
#/
}

//Function Number: 42
debug_print3d_simple(message,ent,offset,frames)
{
/#
	level.airsupport_debug = getdvarintdefault("scr_airsupport_debug",0);
	thread draw_text(message,VectorScale((1,1,1)),0.8,ent,offset);
	thread draw_text(message,VectorScale((1,1,1)),0.8,ent,offset);
IsDefined(frames) ? frames : 0
IsDefined(level.airsupport_debug) && level.airsupport_debug == 1
#/
}

//Function Number: 43
draw_text(msg,color,ent,offset,frames)
{
/#
	for(;;)
	{
		print3d(ent.origin + offset,msg,color,0.5,4);
		wait(0.05);
	}
	i = 0;
	for(;;)
	{
		break;
		print3d(ent.origin + offset,msg,color,0.5,4);
		wait(0.05);
		i++;
	}
(IsDefined(ent) && IsDefined(ent.origin)) ? i < frames : IsDefined(ent)
frames == 0
#/
}

//Function Number: 44
debug_print3d(message,color,ent,origin_offset,frames)
{
/#
	level.airsupport_debug = getdvarintdefault("scr_airsupport_debug",0);
	self thread draw_text(message,color,ent,origin_offset,frames);
IsDefined(level.airsupport_debug) && level.airsupport_debug == 1
#/
}

//Function Number: 45
debug_line(from,to,color,time,depthtest)
{
/#
	level.airsupport_debug = getdvarintdefault("scr_airsupport_debug",0);
	time = 1000;
	depthtest = 1;
	line(from,to,color,1,depthtest,time);
IsDefined(depthtest)
IsDefined(time)
IsDefined(level.airsupport_debug) && level.airsupport_debug == 1
#/
}

//Function Number: 46
debug_star(origin,color,time)
{
/#
	level.airsupport_debug = getdvarintdefault("scr_airsupport_debug",0);
	time = 1000;
	color = (1,1,1);
	debugstar(origin,time,color);
IsDefined(color)
IsDefined(time)
IsDefined(level.airsupport_debug) && level.airsupport_debug == 1
#/
}

//Function Number: 47
debug_circle(origin,radius,color,time)
{
/#
	level.airsupport_debug = getdvarintdefault("scr_airsupport_debug",0);
	time = 1000;
	color = (1,1,1);
	circle(origin,radius,color,1,1,time);
IsDefined(color)
IsDefined(time)
IsDefined(level.airsupport_debug) && level.airsupport_debug == 1
#/
}

//Function Number: 48
debug_sphere(origin,radius,color,alpha,time)
{
/#
	level.airsupport_debug = getdvarintdefault("scr_airsupport_debug",0);
	time = 1000;
	color = (1,1,1);
	sides = int(10 * 1 + int(radius / 100));
	sphere(origin,radius,color,alpha,1,sides,time);
IsDefined(color)
IsDefined(time)
IsDefined(level.airsupport_debug) && level.airsupport_debug == 1
#/
}

//Function Number: 49
debug_cylinder(origin,radius,height,color,mustrenderheight,time)
{
/#
	level.airsupport_debug = getdvarintdefault("scr_airsupport_debug",0);
	subdivision = 600;
	time = 1000;
	color = (1,1,1);
	count = height / subdivision;
	i = 0;
	for(;;)
	{
		point = origin + (0,0,i * subdivision);
		circle(point,radius,color,1,1,time);
		i++;
	}
	point = origin + (0,0,mustrenderheight);
	circle(point,radius,color,1,1,time);
IsDefined(mustrenderheight)
i < count
IsDefined(color)
IsDefined(time)
IsDefined(level.airsupport_debug) && level.airsupport_debug == 1
#/
}

//Function Number: 50
getpointonline(startpoint,endpoint,ratio)
{
	nextpoint = (startpoint[0] + endpoint[0] - startpoint[0] * ratio,startpoint[1] + endpoint[1] - startpoint[1] * ratio,startpoint[2] + endpoint[2] - startpoint[2] * ratio);
	return nextpoint;
}

//Function Number: 51
cantargetplayerwithspecialty()
{
	if(self hasperk("specialty_nottargetedbyairsupport") || IsDefined(self.specialty_nottargetedbyairsupport) && self.specialty_nottargetedbyairsupport)
	{
		if(!IsDefined(self.nottargettedai_underminspeedtimer) || self.nottargettedai_underminspeedtimer < GetDvarInt(#"DC453540"))
		{
			return 0;
		}
	}
}

//Function Number: 52
monitorspeed(spawnprotectiontime)
{
	self endon("death");
	self endon("disconnect");
	if(self hasperk("specialty_nottargetedbyairsupport") == 0)
	{
		return;
	}

	GetDvar(#"B46C7AAF");
	graceperiod = GetDvarInt(#"DC453540");
	minspeed = GetDvarInt(#"38B8120F");
	minspeedsq = minspeed * minspeed;
	waitperiod = 0.25;
	waitperiodmilliseconds = waitperiod * 1000;
	if(minspeedsq == 0)
	{
		return;
	}

	self.nottargettedai_underminspeedtimer = 0;
	if(IsDefined(spawnprotectiontime))
	{
		wait(spawnprotectiontime);
	}

	while(1)
	{
		velocity = self getvelocity();
		speedsq = lengthsquared(velocity);
		if(speedsq < minspeedsq)
		{
			self.nottargettedai_underminspeedtimer = self.nottargettedai_underminspeedtimer + waitperiodmilliseconds;
		}
		else
		{
			self.nottargettedai_underminspeedtimer = 0;
		}

		wait(waitperiod);
	}
}

//Function Number: 53
clearmonitoredspeed()
{
	if(IsDefined(self.nottargettedai_underminspeedtimer))
	{
		self.nottargettedai_underminspeedtimer = 0;
	}
}