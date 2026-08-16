/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_harrier.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

beginharrier(lifeid, startpoint, pos)
{
	heightent = getent("airstrikeheight", "targetname");
	if(isdefined(heightent))
	{
		trueheight = heightent.origin[2];
	}
	else if(isdefined(level.airstrikeheightscale))
	{
		trueheight = 850 * level.airstrikeheightscale;
	}
	else
	{
		trueheight = 850;
	}

	pos = pos * (1,1,0);
	pathgoal = pos + (0,0,trueheight);
	harrier = spawndefensiveharrier(lifeid, self, startpoint, pathgoal);
	harrier.pathgoal = pathgoal;
	return harrier;
}

getcorrectheight(x, y, rand)
{
	offgroundheight = 1200;
	groundheight = tracegroundpoint(x, y);
	trueheight = groundheight + offgroundheight;
	if(isdefined(level.airstrikeheightscale) && trueheight < 850 * level.airstrikeheightscale)
	{
		trueheight = 950 * level.airstrikeheightscale;
	}

	trueheight = trueheight + randomint(rand);
	return trueheight;
}

spawndefensiveharrier(lifeid, owner, pathstart, pathgoal)
{
	forward = vectortoangles(pathgoal - pathstart);
	if(owner.team == "allies")
	{
		harrier = spawnhelicopter(owner, pathstart, forward, "harrier_mp", "vehicle_av8b_harrier_jet_mp");
	}
	else
	{
		harrier = spawnhelicopter(owner, pathstart, forward, "harrier_mp", "vehicle_av8b_harrier_jet_opfor_mp");
	}

	if(!isdefined(harrier))
	{
		return;
	}

	harrier addtohelilist();
	harrier thread removefromhelilistondeath();
	harrier.speed = 250;
	harrier.accel = 175;
	harrier.health = 3000;
	harrier.maxhealth = harrier.health;
	harrier.team = owner.team;
	harrier.owner = owner;
	harrier setcandamage(1);
	harrier.owner = owner;
	harrier thread harrierdestroyed();
	harrier setmaxpitchroll(0, 90);
	harrier vehicle_setspeed(harrier.speed, harrier.accel);
	harrier thread playharrierfx();
	harrier setdamagestage(3);
	harrier.missiles = 6;
	harrier.pers["team"] = harrier.team;
	harrier sethoverparams(50, 100, 50);
	harrier setturningability(0.05);
	harrier setyawspeed(45, 25, 25, 0.5);
	harrier.defendloc = pathgoal;
	harrier.lifeid = lifeid;
	harrier.damagecallback = ::callback_vehicledamage;
	level.harriers = common_scripts\utility::remove_undefined_from_array(level.harriers);
	level.harriers[level.harriers.size] = harrier;
	return harrier;
}

defendlocation(harrier)
{
	harrier endon("death");
	harrier thread harriertimer();
	harrier setvehgoalpos(harrier.pathgoal, 1);
	harrier thread closetogoalcheck(harrier.pathgoal);
	harrier waittill("goal");
	harrier stopharrierwingfx();
	harrier engageground();
}

closetogoalcheck(pathgoal)
{
	self endon("goal");
	self endon("death");
	for(;;)
	{
		if(distance2d(self.origin, pathgoal) < 768)
		{
			self setmaxpitchroll(45, 25);
			break;
		}

		wait 0.05;
	}
}

engageground()
{
	self notify("engageGround");
	self endon("engageGround");
	self endon("death");
	thread harriergettargets();
	thread randomharriermovement();
	pathgoal = self.defendloc;
	self vehicle_setspeed(15, 5);
	self setvehgoalpos(pathgoal, 1);
	self waittill("goal");
}

harrierleave()
{
	self endon("death");
	self setmaxpitchroll(0, 0);
	self notify("leaving");
	breaktarget(1);
	self notify("stopRand");
	for(;;)
	{
		self vehicle_setspeed(35, 25);
		pathgoal = self.origin + common_scripts\utility::vector_multiply(anglestoforward((0,randomint(360),0)), 500);
		pathgoal = pathgoal + (0,0,900);
		leavetrace = bullettrace(self.origin, self.origin + (0,0,900), 0, self);
		if(leavetrace["surfacetype"] == "none")
		{
			break;
		}

		wait 0.1;
	}

	self setvehgoalpos(pathgoal, 1);
	thread startharrierwingfx();
	self waittill("goal");
	self playsound("harrier_fly_away");
	pathend = getpathend();
	self vehicle_setspeed(250, 75);
	self setvehgoalpos(pathend, 1);
	self waittill("goal");
	level.airplane[level.airplane.size - 1] = undefined;
	self notify("harrier_gone");
	thread harrierdelete();
}

harrierdelete()
{
	self delete();
}

harriertimer()
{
	self endon("death");
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(45);
	harrierleave();
}

randomharriermovement()
{
	self notify("randomHarrierMovement");
	self endon("randomHarrierMovement");
	self endon("stopRand");
	self endon("death");
	self endon("acquiringTarget");
	self endon("leaving");
	pos = self.defendloc;
	for(;;)
	{
		newpos = getnewpoint(self.origin);
		self setvehgoalpos(newpos, 1);
		self waittill("goal");
		wait randomintrange(3, 6);
		self notify("randMove");
	}
}

getnewpoint(pos, targ)
{
	self endon("stopRand");
	self endon("death");
	self endon("acquiringTarget");
	self endon("leaving");
	if(!isdefined(targ))
	{
		enemypoints = [];
		foreach(player in level.players)
		{
			if(player == self)
			{
				continue;
			}

			if(!level.teambased || player.team != self.team)
			{
				enemypoints[enemypoints.size] = player.origin;
			}
		}

		if(enemypoints.size > 0)
		{
			gotopoint = averagepoint(enemypoints);
			pointx = gotopoint[0];
			pointy = gotopoint[1];
		}
		else
		{
			center = level.mapcenter;
			movementdist = level.mapsize / 6 - 200;
			pointx = randomfloatrange(center[0] - movementdist, center[0] + movementdist);
			pointy = randomfloatrange(center[1] - movementdist, center[1] + movementdist);
		}

		newheight = getcorrectheight(pointx, pointy, 20);
	}
	else if(common_scripts\utility::cointoss())
	{
		directvector = self.origin - self.besttarget.origin;
		pointx = directvector[0];
		pointy = directvector[1] * -1;
		newheight = getcorrectheight(pointx, pointy, 20);
		perpendicularvector = (pointy,pointx,newheight);
		if(distance2d(self.origin, perpendicularvector) > 1200)
		{
			pointy = pointy * 0.5;
			pointx = pointx * 0.5;
			perpendicularvector = (pointy,pointx,newheight);
		}
	}
	else
	{
		if(distance2d(self.origin, self.besttarget.origin) < 200)
		{
			return;
		}

		yaw = self.angles[1];
		direction = (0,yaw,0);
		movetopoint = self.origin + common_scripts\utility::vector_multiply(anglestoforward(direction), randomintrange(200, 400));
		newheight = getcorrectheight(movetopoint[0], movetopoint[1], 20);
		pointx = movetopoint[0];
		pointy = movetopoint[1];
	}

	for(;;)
	{
		point = tracenewpoint(pointx, pointy, newheight);
		if(point != 0)
		{
			return point;
		}

		pointx = randomfloatrange(pos[0] - 1200, pos[0] + 1200);
		pointy = randomfloatrange(pos[1] - 1200, pos[1] + 1200);
		newheight = getcorrectheight(pointx, pointy, 20);
	}
}

tracenewpoint(x, y, z)
{
	self endon("stopRand");
	self endon("death");
	self endon("acquiringTarget");
	self endon("leaving");
	self endon("randMove");
	for(i = 1;i <= 10;i++)
	{
		switch(i)
		{
			case 1:
				trc = bullettrace(self.origin, (x,y,z), 0, self);
				break;

			case 2:
				trc = bullettrace(self gettagorigin("tag_left_wingtip"), (x,y,z), 0, self);
				break;

			case 3:
				trc = bullettrace(self gettagorigin("tag_right_wingtip"), (x,y,z), 0, self);
				break;

			case 4:
				trc = bullettrace(self gettagorigin("tag_engine_left2"), (x,y,z), 0, self);
				break;

			case 5:
				trc = bullettrace(self gettagorigin("tag_engine_right2"), (x,y,z), 0, self);
				break;

			case 6:
				trc = bullettrace(self gettagorigin("tag_right_alamo_missile"), (x,y,z), 0, self);
				break;

			case 7:
				trc = bullettrace(self gettagorigin("tag_left_alamo_missile"), (x,y,z), 0, self);
				break;

			case 8:
				trc = bullettrace(self gettagorigin("tag_right_archer_missile"), (x,y,z), 0, self);
				break;

			case 9:
				trc = bullettrace(self gettagorigin("tag_left_archer_missile"), (x,y,z), 0, self);
				break;

			case 10:
				trc = bullettrace(self gettagorigin("tag_light_tail"), (x,y,z), 0, self);
				break;

			default:
				trc = bullettrace(self.origin, (x,y,z), 0, self);
				break;
		}

		if(trc["surfacetype"] != "none")
		{
			return 0;
		}

		wait 0.05;
	}

	pathgoal = (x,y,z);
	return pathgoal;
}

tracegroundpoint(x, y)
{
	self endon("death");
	self endon("acquiringTarget");
	self endon("leaving");
	hightrace = -9999999;
	lowtrace = 9999999;
	z = -9999999;
	highz = self.origin[2];
	trace = undefined;
	ltrace = undefined;
	for(i = 1;i <= 5;i++)
	{
		switch(i)
		{
			case 1:
				trc = bullettrace((x,y,highz), (x,y,z), 0, self);
				break;

			case 2:
				trc = bullettrace((x + 20,y + 20,highz), (x + 20,y + 20,z), 0, self);
				break;

			case 3:
				trc = bullettrace((x - 20,y - 20,highz), (x - 20,y - 20,z), 0, self);
				break;

			case 4:
				trc = bullettrace((x + 20,y - 20,highz), (x + 20,y - 20,z), 0, self);
				break;

			case 5:
				trc = bullettrace((x - 20,y + 20,highz), (x - 20,y + 20,z), 0, self);
				break;

			default:
				trc = bullettrace(self.origin, (x,y,z), 0, self);
				break;
		}

		if(trc["position"][2] > hightrace)
		{
			hightrace = trc["position"][2];
			trace = trc;
		}
		else if(trc["position"][2] < lowtrace)
		{
			lowtrace = trc["position"][2];
			ltrace = trc;
		}

		wait 0.05;
	}

	return hightrace;
}

playharrierfx()
{
	self endon("death");
	wait 0.2;
	playfxontag(level.fx_airstrike_contrail, self, "tag_right_wingtip");
	playfxontag(level.fx_airstrike_contrail, self, "tag_left_wingtip");
	wait 0.2;
	playfxontag(level.harrier_afterburnerfx, self, "tag_engine_right");
	playfxontag(level.harrier_afterburnerfx, self, "tag_engine_left");
	wait 0.2;
	playfxontag(level.harrier_afterburnerfx, self, "tag_engine_right2");
	playfxontag(level.harrier_afterburnerfx, self, "tag_engine_left2");
	wait 0.2;
	playfxontag(level.chopper_fx["light"]["left"], self, "tag_light_L_wing");
	wait 0.2;
	playfxontag(level.chopper_fx["light"]["right"], self, "tag_light_R_wing");
	wait 0.2;
	playfxontag(level.chopper_fx["light"]["belly"], self, "tag_light_belly");
	wait 0.2;
	playfxontag(level.chopper_fx["light"]["tail"], self, "tag_light_tail");
}

stopharrierwingfx()
{
	stopfxontag(level.fx_airstrike_contrail, self, "tag_right_wingtip");
	stopfxontag(level.fx_airstrike_contrail, self, "tag_left_wingtip");
}

startharrierwingfx()
{
	wait 3;
	if(!isdefined(self))
	{
		return;
	}

	playfxontag(level.fx_airstrike_contrail, self, "tag_right_wingtip");
	playfxontag(level.fx_airstrike_contrail, self, "tag_left_wingtip");
}

getpathstart(param_C40)
{
	pathrandomness = 100;
	harrierhalfdistance = 15000;
	harrierflyheight = 850;
	yaw = randomfloat(360);
	direction = (0,yaw,0);
	startpoint = param_C40 + common_scripts\utility::vector_multiply(anglestoforward(direction), -1 * harrierhalfdistance);
	startpoint = startpoint + (randomfloat(2) - 1 * pathrandomness,randomfloat(2) - 1 * pathrandomness,0);
	return startpoint;
}

getpathend()
{
	pathrandomness = 150;
	harrierhalfdistance = 15000;
	harrierflyheight = 850;
	yaw = self.angles[1];
	direction = (0,yaw,0);
	endpoint = self.origin + common_scripts\utility::vector_multiply(anglestoforward(direction), harrierhalfdistance);
	return endpoint;
}

fireontarget(facingtolerance, zoffset)
{
	self endon("leaving");
	self endon("stopfiring");
	self endon("explode");
	self endon("death");
	self.besttarget endon("death");
	acquiredtime = gettime();
	missiletime = gettime();
	missileready = 0;
	self setvehweapon("harrier_20mm_mp");
	if(!isdefined(zoffset))
	{
		zoffset = 50;
	}

	for(;;)
	{
		if(isreadytofire(facingtolerance))
		{
			break;
		}
		else
		{
			wait 0.25;
		}
	}

	self setturrettargetent(self.besttarget, (0,0,50));
	numshots = 25;
	for(;;)
	{
		if(numshots == 25)
		{
			self playloopsound("weap_cobra_20mm_fire_npc");
		}

		numshots--;
		self fireweapon("tag_flash", self.besttarget, (0,0,0), 0.05);
		wait 0.1;
		if(numshots <= 0)
		{
			self stoploopsound();
			wait 1;
			numshots = 25;
		}
	}
}

isreadytofire(tolerance)
{
	self endon("death");
	self endon("leaving");
	if(!isdefined(tolerance))
	{
		tolerance = 10;
	}

	harrierforwardvector = anglestoforward(self.angles);
	harriertotarget = self.besttarget.origin - self.origin;
	harrierforwardvector = harrierforwardvector * (1,1,0);
	harriertotarget = harriertotarget * (1,1,0);
	harriertotarget = vectornormalize(harriertotarget);
	harrierforwardvector = vectornormalize(harrierforwardvector);
	targetcosine = vectordot(harriertotarget, harrierforwardvector);
	facingcosine = cos(tolerance);
	if(targetcosine >= facingcosine)
	{
		return 1;
	}

	return 0;
}

acquiregroundtarget(targets)
{
	self endon("death");
	self endon("leaving");
	if(targets.size == 1)
	{
		self.besttarget = targets[0];
	}
	else
	{
		self.besttarget = getbesttarget(targets);
	}

	backtodefendlocation(0);
	self notify("acquiringTarget");
	self setturrettargetent(self.besttarget);
	self setlookatent(self.besttarget);
	newpos = getnewpoint(self.origin, 1);
	self setvehgoalpos(newpos, 1);
	thread watchtargetdeath();
	thread watchtargetlos();
	self setvehweapon("harrier_20mm_mp");
	thread fireontarget();
}

backtodefendlocation(forced)
{
	self setvehgoalpos(self.defendloc, 1);
	if(isdefined(forced) && forced)
	{
		self waittill("goal");
		return;
	}
}

wouldcollide(destination)
{
	trace = bullettrace(self.origin, destination, 1, self);
	if(trace["position"] == destination)
	{
		return 0;
	}

	return 1;
}

watchtargetdeath()
{
	self notify("watchTargetDeath");
	self endon("watchTargetDeath");
	self endon("newTarget");
	self endon("death");
	self endon("leaving");
	self.besttarget waittill("death");
	thread breaktarget();
}

watchtargetlos(tolerance)
{
	self endon("death");
	self.besttarget endon("death");
	self.besttarget endon("disconnect");
	self endon("leaving");
	self endon("newTarget");
	losttime = undefined;
	if(!isdefined(tolerance))
	{
		tolerance = 1000;
	}

	for(;;)
	{
		if(!istarget(self.besttarget))
		{
			thread breaktarget();
			return;
		}

		if(!isdefined(self.besttarget))
		{
			thread breaktarget();
			return;
		}

		if(self.besttarget sightconetrace(self.origin, self) < 1)
		{
			if(!isdefined(losttime))
			{
				losttime = gettime();
			}

			if(gettime() - losttime > tolerance)
			{
				thread breaktarget();
				return;
			}
		}
		else
		{
			losttime = undefined;
		}

		wait 0.25;
	}
}

breaktarget(nonewtarget)
{
	self endon("death");
	self clearlookatent();
	self stoploopsound();
	self notify("stopfiring");
	if(isdefined(nonewtarget) && nonewtarget)
	{
		return;
	}

	thread randomharriermovement();
	self notify("newTarget");
	thread harriergettargets();
}

harriergettargets()
{
	self notify("harrierGetTargets");
	self endon("harrierGetTargets");
	self endon("death");
	self endon("leaving");
	targets = [];
	for(;;)
	{
		targets = [];
		players = level.players;
		if(isdefined(level.chopper) && level.chopper.team != self.team && isalive(level.chopper))
		{
			if(!isdefined(level.chopper.nontarget) || isdefined(level.chopper.nontarget) && !level.chopper.nontarget)
			{
				thread engagevehicle(level.chopper);
				return;
			}
			else
			{
				backtodefendlocation(1);
			}
		}

		for(i = 0;i < players.size;i++)
		{
			potentialtarget = players[i];
			if(istarget(potentialtarget))
			{
				if(isdefined(players[i]))
				{
					targets[targets.size] = players[i];
				}
			}
			else
			{
				continue;
			}

			wait 0.05;
		}

		if(targets.size > 0)
		{
			acquiregroundtarget(targets);
			return;
		}

		wait 1;
	}
}

istarget(potentialtarget)
{
	self endon("death");
	if(!isalive(potentialtarget) || potentialtarget.sessionstate != "playing")
	{
		return 0;
	}

	if(isdefined(self.owner) && potentialtarget == self.owner)
	{
		return 0;
	}

	if(distance(potentialtarget.origin, self.origin) > 8192)
	{
		return 0;
	}

	if(distance2d(potentialtarget.origin, self.origin) < 768)
	{
		return 0;
	}

	if(!isdefined(potentialtarget.pers["team"]))
	{
		return 0;
	}

	if(level.teambased && potentialtarget.pers["team"] == self.team)
	{
		return 0;
	}

	if(potentialtarget.pers["team"] == "spectator")
	{
		return 0;
	}

	if(isdefined(potentialtarget.spawntime) && gettime() - potentialtarget.spawntime / 1000 <= 5)
	{
		return 0;
	}

	if(potentialtarget maps\mp\_utility::_hasperk("specialty_coldblooded"))
	{
		return 0;
	}

	harrier_centroid = self.origin + (0,0,-160);
	harrier_forward_norm = anglestoforward(self.angles);
	harrier_turret_point = harrier_centroid + 144 * harrier_forward_norm;
	harrier_canseetarget = potentialtarget sightconetrace(self.origin, self);
	if(harrier_canseetarget < 1)
	{
		return 0;
	}

	return 1;
}

getbesttarget(targets)
{
	self endon("death");
	maingunpointorigin = self gettagorigin("tag_flash");
	harrierorigin = self.origin;
	harrier_forward_norm = anglestoforward(self.angles);
	bestyaw = undefined;
	besttarget = undefined;
	targethasrocket = 0;
	foreach(targ in targets)
	{
		angle = abs(vectortoangles(targ.origin - self.origin)[1]);
		noseangle = abs(self gettagangles("tag_flash")[1]);
		angle = abs(angle - noseangle);
		weaponsarray = targ getweaponslistitems();
		foreach(weapon in weaponsarray)
		{
			if(issubstr(weapon, "at4") || issubstr(weapon, "stinger") || issubstr(weapon, "jav"))
			{
				angle = angle - 40;
			}
		}

		if(distance(self.origin, targ.origin) > 2000)
		{
			angle = angle + 40;
		}

		if(!isdefined(bestyaw))
		{
			bestyaw = angle;
			besttarget = targ;
			continue;
		}

		if(bestyaw > angle)
		{
			bestyaw = angle;
			besttarget = targ;
		}
	}

	return besttarget;
}

firemissile(missiletarget)
{
	self endon("death");
	self endon("leaving");
	if(self.missiles <= 0)
	{
		return;
	}

	friendlyinradius = checkforfriendlies(missiletarget, 256);
	if(!isdefined(missiletarget))
	{
		return;
	}

	if(distance2d(self.origin, missiletarget.origin) < 512)
	{
		return;
	}

	if(isdefined(friendlyinradius) && friendlyinradius)
	{
		return;
	}

	self.missiles--;
	self setvehweapon("harrier_FFAR_mp");
	if(isdefined(missiletarget.targetent))
	{
		missile = self fireweapon("tag_flash", missiletarget.targetent, (0,0,-250));
	}
	else
	{
		missile = self fireweapon("tag_flash", missiletarget, (0,0,-250));
	}

	missile missile_setflightmodedirect();
	missile missile_settargetent(missiletarget);
}

checkforfriendlies(missiletarget, radiussize)
{
	self endon("death");
	self endon("leaving");
	targets = [];
	players = level.players;
	strikeposition = missiletarget.origin;
	for(i = 0;i < players.size;i++)
	{
		potentialcollateral = players[i];
		if(potentialcollateral.team != self.team)
		{
			continue;
		}

		potentialposition = potentialcollateral.origin;
		if(distance2d(potentialposition, strikeposition) < 512)
		{
			return 1;
		}
	}

	return 0;
}

callback_vehicledamage(inflictor, attacker, damage, dflags, meansofdeath, weapon, point, dir, hitloc, timeoffset, modelindex, partname)
{
	if((attacker == self || isdefined(attacker.pers) && attacker.pers["team"] == self.team && level.teambased) && attacker != self.owner)
	{
		return;
	}

	if(self.health <= 0)
	{
		return;
	}

	switch(weapon)
	{
		case "javelin_mp":
		case "stinger_mp":
		case "remotemissile_projectile_mp":
		case "ac130_40mm_mp":
		case "ac130_105mm_mp":
			self.largeprojectiledamage = 1;
			damage = self.maxhealth + 1;
			break;

		case "rpg_mp":
		case "at4_mp":
			self.largeprojectiledamage = 1;
			damage = self.maxhealth - 900;
			break;

		default:
			if(weapon != "none")
			{
				damage = int(damage / 2);
			}
	
			self.largeprojectiledamage = 0;
			break;
	}

	attacker maps\mp\gametypes\_damagefeedback::updatedamagefeedback("");
	if(isplayer(attacker) && attacker maps\mp\_utility::_hasperk("specialty_armorpiercing"))
	{
		damageadd = int(damage * level.armorpiercingmod);
		damage = damage + damageadd;
	}

	if(self.health <= damage)
	{
		if(isplayer(attacker) && !isdefined(self.owner) || attacker != self.owner)
		{
			thread maps\mp\_utility::teamplayercardsplash("callout_destroyed_harrier", attacker);
			attacker thread maps\mp\gametypes\_rank::giverankxp("kill", 300);
			thread maps\mp\gametypes\_missions::vehiclekilled(self.owner, self, undefined, attacker, damage, meansofdeath);
			attacker notify("destroyed_killstreak");
		}

		self notify("death");
	}

	if(self.health - damage <= 900 && !isdefined(self.smoking) || !self.smoking)
	{
		thread playdamageefx();
		self.smoking = 1;
	}

	self vehicle_finishdamage(inflictor, attacker, damage, dflags, meansofdeath, weapon, point, dir, hitloc, timeoffset, modelindex, partname);
}

playdamageefx()
{
	self endon("death");
	stopfxontag(level.harrier_afterburnerfx, self, "tag_engine_left");
	playfxontag(level.harrier_smoke, self, "tag_engine_left");
	stopfxontag(level.harrier_afterburnerfx, self, "tag_engine_right");
	playfxontag(level.harrier_smoke, self, "tag_engine_right");
	wait 0.15;
	stopfxontag(level.harrier_afterburnerfx, self, "tag_engine_left2");
	playfxontag(level.harrier_smoke, self, "tag_engine_left2");
	stopfxontag(level.harrier_afterburnerfx, self, "tag_engine_right2");
	playfxontag(level.harrier_smoke, self, "tag_engine_right2");
	playfxontag(level.chopper_fx["damage"]["heavy_smoke"], self, "tag_engine_left");
}

harrierdestroyed()
{
	self endon("harrier_gone");
	self waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	if(!isdefined(self.largeprojectiledamage))
	{
		self vehicle_setspeed(25, 5);
		thread harrierspin(randomintrange(180, 220));
		wait randomfloatrange(0.5, 1.5);
	}

	harrierexplode();
}

harrierexplode()
{
	self playsound("harrier_jet_crash");
	level.airplane[level.airplane.size - 1] = undefined;
	deathangles = self gettagangles("tag_deathfx");
	playfx(level.harrier_deathfx, self gettagorigin("tag_deathfx"), anglestoforward(deathangles), anglestoup(deathangles));
	self notify("explode");
	wait 0.05;
	thread harrierdelete();
}

harrierspin(speed)
{
	self endon("explode");
	playfxontag(level.chopper_fx["explode"]["medium"], self, "tag_origin");
	self setyawspeed(speed, speed, speed);
	while(isdefined(self))
	{
		self settargetyaw(self.angles[1] + speed * 0.9);
		wait 1;
	}
}

engagevehicle(vehtarget)
{
	vehtarget endon("death");
	vehtarget endon("leaving");
	vehtarget endon("crashing");
	self endon("death");
	acquirevehicletarget(vehtarget);
	thread fireonvehicletarget();
}

fireonvehicletarget()
{
	self endon("leaving");
	self endon("stopfiring");
	self endon("explode");
	self.besttarget endon("crashing");
	self.besttarget endon("leaving");
	self.besttarget endon("death");
	acquiredtime = gettime();
	if(isdefined(self.besttarget) && self.besttarget.classname == "script_vehicle")
	{
		self setturrettargetent(self.besttarget);
		for(;;)
		{
			curdist = distance2d(self.origin, self.besttarget.origin);
			if(gettime() - acquiredtime > 2500 && curdist > 1000)
			{
				firemissile(self.besttarget);
				acquiredtime = gettime();
			}

			wait 0.1;
		}

		return;
	}
}

acquirevehicletarget(vehtarget)
{
	self endon("death");
	self endon("leaving");
	self notify("newTarget");
	self.besttarget = vehtarget;
	self notify("acquiringVehTarget");
	self setlookatent(self.besttarget);
	thread watchvehtargetdeath();
	thread watchvehtargetcrash();
	self setturrettargetent(self.besttarget);
}

watchvehtargetcrash()
{
	self endon("death");
	self endon("leaving");
	self.besttarget endon("death");
	self.besttarget endon("drop_crate");
	self.besttarget waittill("crashing");
	breakvehtarget();
}

watchvehtargetdeath()
{
	self endon("death");
	self endon("leaving");
	self.besttarget endon("crashing");
	self.besttarget endon("drop_crate");
	self.besttarget waittill("death");
	breakvehtarget();
}

breakvehtarget()
{
	self clearlookatent();
	if(isdefined(self.besttarget) && !isdefined(self.besttarget.nontarget))
	{
		self.besttarget.nontarget = 1;
	}

	self notify("stopfiring");
	self notify("newTarget");
	thread stopharrierwingfx();
	thread engageground();
}

evasivemanuverone()
{
	self setmaxpitchroll(15, 80);
	self vehicle_setspeed(50, 100);
	self setyawspeed(90, 30, 30, 0.5);
	curorg = self.origin;
	yaw = self.angles[1];
	if(common_scripts\utility::cointoss())
	{
		direction = (0,yaw + 90,0);
	}
	else
	{
		direction = (0,yaw - 90,0);
	}

	movetopoint = self.origin + common_scripts\utility::vector_multiply(anglestoforward(direction), 500);
	self setvehgoalpos(movetopoint, 1);
	self waittill("goal");
}

drawline(start, end, timeslice, color)
{
	if(!isdefined(color))
	{
		color = (1,1,1);
	}

	drawtime = int(timeslice * 20);
	for(time = 0;time < drawtime;time++)
	{
		wait 0.05;
	}
}

addtohelilist()
{
	level.helis[self getentitynumber()] = self;
}

removefromhelilistondeath()
{
	entitynumber = self getentitynumber();
	self waittill("death");
	level.helis[entitynumber] = undefined;
}