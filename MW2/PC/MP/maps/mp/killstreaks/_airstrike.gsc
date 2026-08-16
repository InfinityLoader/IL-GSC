/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_airstrike.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

init()
{
	precachelocationselector("map_artillery_selector");
	precachestring(&"MP_WAR_AIRSTRIKE_INBOUND_NEAR_YOUR_POSITION");
	precachestring(&"MP_WAR_AIRSTRIKE_INBOUND");
	precachestring(&"MP_CIVILIAN_AIR_TRAFFIC");
	precachestring(&"MP_AIR_SPACE_TOO_CROWDED");
	precacheitem("stealth_bomb_mp");
	precacheitem("artillery_mp");
	precacheitem("harrier_missile_mp");
	precachemodel("vehicle_av8b_harrier_jet_mp");
	precachemodel("vehicle_av8b_harrier_jet_opfor_mp");
	precachemodel("weapon_minigun");
	precachemodel("vehicle_b2_bomber");
	precachevehicle("harrier_mp");
	precacheturret("harrier_FFAR_mp");
	precacheminimapicon("compass_objpoint_airstrike_friendly");
	precacheminimapicon("compass_objpoint_airstrike_busy");
	precacheminimapicon("compass_objpoint_b2_airstrike_friendly");
	precacheminimapicon("compass_objpoint_b2_airstrike_enemy");
	precacheminimapicon("hud_minimap_harrier_green");
	precacheminimapicon("hud_minimap_harrier_red");
	level.onfirefx = loadfx("fire/fire_smoke_trail_L");
	level.airstrikefx = loadfx("explosions/clusterbomb");
	level.mortareffect = loadfx("explosions/artilleryExp_dirt_brown");
	level.bombstrike = loadfx("explosions/wall_explosion_pm_a");
	level.stealthbombfx = loadfx("explosions/stealth_bomb_mp");
	level.airplane = [];
	level.harriers = [];
	level.planes = 0;
	level.harrier_smoke = loadfx("fire/jet_afterburner_harrier_damaged");
	level.harrier_deathfx = loadfx("explosions/aerial_explosion_harrier");
	level.harrier_afterburnerfx = loadfx("fire/jet_afterburner_harrier");
	level.fx_airstrike_afterburner = loadfx("fire/jet_afterburner");
	level.fx_airstrike_contrail = loadfx("smoke/jet_contrail");
	level.dangermaxradius["stealth"] = 900;
	level.dangerminradius["stealth"] = 750;
	level.dangerforwardpush["stealth"] = 1;
	level.dangerovalscale["stealth"] = 6;
	level.dangermaxradius["default"] = 550;
	level.dangerminradius["default"] = 300;
	level.dangerforwardpush["default"] = 1.5;
	level.dangerovalscale["default"] = 6;
	level.dangermaxradius["precision"] = 550;
	level.dangerminradius["precision"] = 300;
	level.dangerforwardpush["precision"] = 2;
	level.dangerovalscale["precision"] = 6;
	level.dangermaxradius["harrier"] = 550;
	level.dangerminradius["harrier"] = 300;
	level.dangerforwardpush["harrier"] = 1.5;
	level.dangerovalscale["harrier"] = 6;
	level.artillerydangercenters = [];
	level.killstreakfuncs["airstrike"] = ::tryuseairstrike;
	level.killstreakfuncs["precision_airstrike"] = ::tryuseprecisionairstrike;
	level.killstreakfuncs["super_airstrike"] = ::tryusesuperairstrike;
	level.killstreakfuncs["harrier_airstrike"] = ::tryuseharrierairstrike;
	level.killstreakfuncs["stealth_airstrike"] = ::tryusestealthairstrike;
}

tryuseprecisionairstrike(lifeid)
{
	return tryuseairstrike(lifeid, "precision");
}

tryusestealthairstrike(lifeid)
{
	return tryuseairstrike(lifeid, "stealth");
}

tryusesuperairstrike(lifeid)
{
	return tryuseairstrike(lifeid, "super");
}

tryuseharrierairstrike(lifeid)
{
	return tryuseairstrike(lifeid, "harrier");
}

tryuseairstrike(lifeid, airstriketype)
{
	if(isdefined(level.civilianjetflyby))
	{
		self iprintlnbold(&"MP_CIVILIAN_AIR_TRAFFIC");
		return 0;
	}

	if(maps\mp\_utility::isusingremote())
	{
		return 0;
	}

	if(!isdefined(airstriketype))
	{
		airstriketype = "none";
	}

	switch(airstriketype)
	{
		case "precision":
			break;

		case "stealth":
			break;

		case "harrier":
			if(level.planes > 1)
			{
				self iprintlnbold(&"MP_AIR_SPACE_TOO_CROWDED");
				return 0;
			}
			break;

		case "super":
			break;
	}

	result = selectairstrikelocation(lifeid, airstriketype);
	if(!isdefined(result) || !result)
	{
		return 0;
	}

	return 1;
}

doairstrike(lifeid, origin, yaw, owner, team)
{
	if(isdefined(self.airstriketype))
	{
		airstriketype = self.airstriketype;
	}
	else
	{
		airstriketype = "default";
	}

	if(airstriketype == "harrier")
	{
		level.planes++;
	}

	if(isdefined(level.airstrikeinprogress))
	{
		while(isdefined(level.airstrikeinprogress))
		{
			level waittill("begin_airstrike");
		}

		level.airstrikeinprogress = 1;
		wait 2;
	}

	if(!isdefined(owner))
	{
		if(airstriketype == "harrier")
		{
			level.planes--;
		}

		return;
	}

	level.airstrikeinprogress = 1;
	num = 17 + randomint(3);
	trace = bullettrace(origin, origin + (0,0,-1000000), 0, undefined);
	targetpos = trace["position"];
	if(level.teambased)
	{
		players = level.players;
		for(i = 0;i < level.players.size;i++)
		{
			player = level.players[i];
			playerteam = player.pers["team"];
			if(isdefined(playerteam))
			{
				if(playerteam == team && self.airstriketype != "stealth")
				{
					player iprintln(&"MP_WAR_AIRSTRIKE_INBOUND", owner);
				}
			}
		}
	}
	else if(!level.hardcoremode)
	{
		if(pointisinairstrikearea(owner.origin, targetpos, yaw, airstriketype))
		{
			owner iprintlnbold(&"MP_WAR_AIRSTRIKE_INBOUND_NEAR_YOUR_POSITION");
		}
	}

	dangercenter = spawnstruct();
	dangercenter.origin = targetpos;
	dangercenter.forward = anglestoforward((0,yaw,0));
	dangercenter.airstriketype = airstriketype;
	level.artillerydangercenters[level.artillerydangercenters.size] = dangercenter;
	harrierent = callstrike(lifeid, owner, targetpos, yaw);
	wait 1;
	level.airstrikeinprogress = undefined;
	owner notify("begin_airstrike");
	level notify("begin_airstrike");
	wait 7.5;
	found = 0;
	newarray = [];
	for(i = 0;i < level.artillerydangercenters.size;i++)
	{
		if(!found && level.artillerydangercenters[i].origin == targetpos)
		{
			found = 1;
			continue;
		}

		newarray[newarray.size] = level.artillerydangercenters[i];
	}

	level.artillerydangercenters = newarray;
	if(airstriketype != "harrier")
	{
		return;
	}

	while(isdefined(harrierent))
	{
		wait 0.1;
	}

	level.planes--;
}

clearprogress(delay)
{
	wait 2;
	level.airstrikeinprogress = undefined;
}

getairstrikedanger(point)
{
	danger = 0;
	for(i = 0;i < level.artillerydangercenters.size;i++)
	{
		origin = level.artillerydangercenters[i].origin;
		forward = level.artillerydangercenters[i].forward;
		airstriketype = level.artillerydangercenters[i].airstriketype;
		danger = danger + getsingleairstrikedanger(point, origin, forward, airstriketype);
	}

	return danger;
}

getsingleairstrikedanger(point, origin, forward, airstriketype)
{
	center = origin + level.dangerforwardpush[airstriketype] * level.dangermaxradius[airstriketype] * forward;
	diff = point - center;
	diff = (diff[0],diff[1],0);
	forwardpart = vectordot(diff, forward) * forward;
	perpendicularpart = diff - forwardpart;
	circlepos = perpendicularpart + forwardpart / level.dangerovalscale[airstriketype];
	distsq = lengthsquared(circlepos);
	if(distsq > level.dangermaxradius[airstriketype] * level.dangermaxradius[airstriketype])
	{
		return 0;
	}

	if(distsq < level.dangerminradius[airstriketype] * level.dangerminradius[airstriketype])
	{
		return 1;
	}

	dist = sqrt(distsq);
	distfrac = dist - level.dangerminradius[airstriketype] / level.dangermaxradius[airstriketype] - level.dangerminradius[airstriketype];
	return 1 - distfrac;
}

pointisinairstrikearea(point, targetpos, yaw, airstriketype)
{
	return distance2d(point, targetpos) <= level.dangermaxradius[airstriketype] * 1.25;
}

losradiusdamage(pos, radius, max, min, owner, einflictor, sweapon)
{
	ents = maps\mp\gametypes\_weapons::getdamageableents(pos, radius, 1);
	glassradiusdamage(pos, radius, max, min);
	for(i = 0;i < ents.size;i++)
	{
		if(ents[i].entity == self)
		{
			continue;
		}

		dist = distance(pos, ents[i].damagecenter);
		if(ents[i].isplayer || isdefined(ents[i].issentry) && ents[i].issentry)
		{
			indoors = !bullettracepassed(ents[i].entity.origin, ents[i].entity.origin + (0,0,130), 0, undefined);
			if(indoors)
			{
				indoors = !bullettracepassed(ents[i].entity.origin + (0,0,130), pos + (0,0,114), 0, undefined);
				if(indoors)
				{
					dist = dist * 4;
					if(dist > radius)
					{
						continue;
					}
				}
			}
		}

		ents[i].damage = int(max + min - max * dist / radius);
		ents[i].pos = pos;
		ents[i].damageowner = owner;
		ents[i].einflictor = einflictor;
		level.airstrikedamagedents[level.airstrikedamagedentscount] = ents[i];
		level.airstrikedamagedentscount++;
	}

	thread airstrikedamageentsthread(sweapon);
}

airstrikedamageentsthread(sweapon)
{
	self notify("airstrikeDamageEntsThread");
	self endon("airstrikeDamageEntsThread");
	while(level.airstrikedamagedentsindex < level.airstrikedamagedentscount)
	{
		if(!isdefined(level.airstrikedamagedents[level.airstrikedamagedentsindex]))
		{
			continue;
		}

		ent = level.airstrikedamagedents[level.airstrikedamagedentsindex];
		if(!isdefined(ent.entity))
		{
			continue;
		}

		if(!ent.isplayer || isalive(ent.entity))
		{
			ent maps\mp\gametypes\_weapons::damageent(ent.einflictor, ent.damageowner, ent.damage, "MOD_PROJECTILE_SPLASH", sweapon, ent.pos, vectornormalize(ent.damagecenter - ent.pos));
			level.airstrikedamagedents[level.airstrikedamagedentsindex] = undefined;
			if(ent.isplayer)
			{
				wait 0.05;
			}

			continue;
		}

		level.airstrikedamagedents[level.airstrikedamagedentsindex] = undefined;
		level.airstrikedamagedentsindex++;
	}
}

radiusartilleryshellshock(pos, radius, maxduration, minduration, team)
{
	players = level.players;
	foreach(player in level.players)
	{
		if(!isalive(player))
		{
			continue;
		}

		if(player.team == team || player.team == "spectator")
		{
			continue;
		}

		playerpos = player.origin + (0,0,32);
		dist = distance(pos, playerpos);
		if(dist > radius)
		{
			continue;
		}

		duration = int(maxduration + minduration - maxduration * dist / radius);
		player thread artilleryshellshock("default", duration);
	}
}

artilleryshellshock(type, duration)
{
	self endon("disconnect");
	if(isdefined(self.beingartilleryshellshocked) && self.beingartilleryshellshocked)
	{
		return;
	}

	self.beingartilleryshellshocked = 1;
	self shellshock(type, duration);
	wait duration + 1;
	self.beingartilleryshellshocked = 0;
}

dobomberstrike(lifeid, owner, requireddeathcount, bombsite, startpoint, endpoint, bombtime, flytime, direction, airstriketype)
{
	if(!isdefined(owner))
	{
		return;
	}

	startpathrandomness = 100;
	endpathrandomness = 150;
	pathstart = startpoint + (randomfloat(2) - 1 * startpathrandomness,randomfloat(2) - 1 * startpathrandomness,0);
	pathend = endpoint + (randomfloat(2) - 1 * endpathrandomness,randomfloat(2) - 1 * endpathrandomness,0);
	plane = spawnplane(owner, "script_model", pathstart, "compass_objpoint_b2_airstrike_friendly", "compass_objpoint_b2_airstrike_enemy");
	plane playloopsound("veh_b2_dist_loop");
	plane setmodel("vehicle_b2_bomber");
	plane thread handleemp(owner);
	plane.lifeid = lifeid;
	plane.angles = direction;
	forward = anglestoforward(direction);
	plane moveto(pathend, flytime, 0, 0);
	thread stealthbomber_killcam(plane, pathend, flytime, airstriketype);
	thread bomberdropbombs(plane, bombsite, owner);
	wait flytime;
	plane notify("delete");
	plane delete();
}

bomberdropbombs(plane, bombsite, owner)
{
	while(!targetisclose(plane, bombsite, 5000))
	{
		wait 0.05;
	}

	showfx = 1;
	sonicboom = 0;
	plane notify("start_bombing");
	plane thread playbombfx();
	dist = targetgetdist(plane, bombsite);
	while(dist < 5000)
	{
		if(dist < 1500 && !sonicboom)
		{
			plane playsound("veh_b2_sonic_boom");
			sonicboom = 1;
		}

		showfx = !showfx;
		if(dist < 4500)
		{
			plane thread callstrike_bomb(plane.origin, owner, (0,0,0), showfx);
		}

		wait 0.1;
		dist = targetgetdist(plane, bombsite);
	}

	plane notify("stop_bombing");
}

playbombfx()
{
	self endon("stop_bombing");
	for(;;)
	{
		playfxontag(level.stealthbombfx, self, "tag_left_alamo_missile");
		playfxontag(level.stealthbombfx, self, "tag_right_alamo_missile");
		wait 0.5;
	}
}

stealthbomber_killcam(plane, pathend, flytime, typeofstrike)
{
	plane waittill("start_bombing");
	planedir = anglestoforward(plane.angles);
	killcament = spawn("script_model", plane.origin + (0,0,100) - planedir * 200);
	plane.killcament = killcament;
	plane.airstriketype = typeofstrike;
	killcament.starttime = gettime();
	killcament thread deleteaftertime(15);
	killcament linkto(plane, "tag_origin", (-256,768,768), (0,0,0));
}

callstrike_bomb(coord, owner, offset, showfx)
{
	if(!isdefined(owner) || owner maps\mp\_utility::isemped())
	{
		self notify("stop_bombing");
		return;
	}

	accuracyradius = 512;
	randvec = (0,randomint(360),0);
	bombpoint = coord + common_scripts\utility::vector_multiply(anglestoforward(randvec), randomfloat(accuracyradius));
	trace = bullettrace(bombpoint, bombpoint + (0,0,-10000), 0, undefined);
	bombpoint = trace["position"];
	bombheight = distance(coord, bombpoint);
	if(bombheight > 5000)
	{
		return;
	}

	wait 0.85 * bombheight / 2000;
	if(!isdefined(owner) || owner maps\mp\_utility::isemped())
	{
		self notify("stop_bombing");
		return;
	}

	if(showfx)
	{
		playfx(level.mortareffect, bombpoint);
		print3d("grenade_rumble", bombpoint);
		earthquake(1, 0.6, bombpoint, 2000);
	}

	thread maps\mp\_utility::playsoundinspace("exp_airstrike_bomb", bombpoint);
	radiusartilleryshellshock(bombpoint, 512, 8, 4, owner.team);
	losradiusdamage(bombpoint + (0,0,16), 896, 300, 50, owner, self, "stealth_bomb_mp");
}

doplanestrike(lifeid, owner, requireddeathcount, bombsite, startpoint, endpoint, bombtime, flytime, direction, typeofstrike)
{
	if(!isdefined(owner))
	{
		return;
	}

	startpathrandomness = 100;
	endpathrandomness = 150;
	pathstart = startpoint + (randomfloat(2) - 1 * startpathrandomness,randomfloat(2) - 1 * startpathrandomness,0);
	pathend = endpoint + (randomfloat(2) - 1 * endpathrandomness,randomfloat(2) - 1 * endpathrandomness,0);
	if(typeofstrike == "harrier")
	{
		plane = spawnplane(owner, "script_model", pathstart, "hud_minimap_harrier_green", "hud_minimap_harrier_red");
	}
	else
	{
		plane = spawnplane(owner, "script_model", pathstart, "compass_objpoint_airstrike_friendly", "compass_objpoint_airstrike_busy");
	}

	if(typeofstrike == "harrier")
	{
		if(owner.team == "allies")
		{
			plane setmodel("vehicle_av8b_harrier_jet_mp");
		}
		else
		{
			plane setmodel("vehicle_av8b_harrier_jet_opfor_mp");
		}
	}
	else
	{
		plane setmodel("vehicle_mig29_desert");
	}

	plane playloopsound("veh_mig29_dist_loop");
	plane thread handleemp(owner);
	plane.lifeid = lifeid;
	plane.angles = direction;
	forward = anglestoforward(direction);
	plane thread playplanefx();
	plane moveto(pathend, flytime, 0, 0);
	thread callstrike_bombeffect(plane, pathend, flytime, bombtime - 1, owner, requireddeathcount, typeofstrike);
	wait flytime;
	plane notify("delete");
	plane delete();
}

callstrike_bombeffect(plane, pathend, flytime, launchtime, owner, requireddeathcount, typeofstrike)
{
	wait launchtime;
	if(!isdefined(owner) || owner maps\mp\_utility::isemped())
	{
		return;
	}

	plane playsound("veh_mig29_sonic_boom");
	planedir = anglestoforward(plane.angles);
	bomb = spawnbomb(plane.origin, plane.angles);
	bomb movegravity(common_scripts\utility::vector_multiply(anglestoforward(plane.angles), 4666.667), 3);
	bomb.lifeid = requireddeathcount;
	killcament = spawn("script_model", plane.origin + (0,0,100) - planedir * 200);
	bomb.killcament = killcament;
	bomb.airstriketype = typeofstrike;
	killcament.starttime = gettime();
	killcament thread deleteaftertime(15);
	killcament.angles = planedir;
	killcament moveto(pathend + (0,0,100), flytime, 0, 0);
	wait 0.4;
	killcament moveto(killcament.origin + planedir * 4000, 1, 0, 0);
	wait 0.45;
	killcament moveto(killcament.origin + planedir + (0,0,-0.2) * 3500, 2, 0, 0);
	wait 0.15;
	newbomb = spawn("script_model", bomb.origin);
	newbomb setmodel("tag_origin");
	newbomb.origin = bomb.origin;
	newbomb.angles = bomb.angles;
	bomb setmodel("tag_origin");
	wait 0.1;
	bomborigin = newbomb.origin;
	bombangles = newbomb.angles;
	playfxontag(level.airstrikefx, newbomb, "tag_origin");
	wait 0.05;
	killcament moveto(killcament.origin + planedir + (0,0,-0.25) * 2500, 2, 0, 0);
	wait 0.25;
	killcament moveto(killcament.origin + planedir + (0,0,-0.35) * 2000, 2, 0, 0);
	wait 0.2;
	killcament moveto(killcament.origin + planedir + (0,0,-0.45) * 1500, 2, 0, 0);
	wait 0.5;
	repeat = 12;
	minangles = 5;
	maxangles = 55;
	anglediff = maxangles - minangles / repeat;
	hitpos = (0,0,0);
	for(i = 0;i < repeat;i++)
	{
		tracedir = anglestoforward(bombangles + (maxangles - anglediff * i,randomint(10) - 5,0));
		traceend = bomborigin + common_scripts\utility::vector_multiply(tracedir, 10000);
		trace = bullettrace(bomborigin, traceend, 0, undefined);
		tracehit = trace["position"];
		hitpos = hitpos + tracehit;
		thread losradiusdamage(tracehit + (0,0,16), 512, 200, 30, owner, bomb, "artillery_mp");
		if(i % 3 == 0)
		{
			thread maps\mp\_utility::playsoundinspace("exp_airstrike_bomb", tracehit);
			print3d("artillery_rumble", tracehit);
			earthquake(0.7, 0.75, tracehit, 1000);
		}

		wait 0.05;
	}

	hitpos = hitpos / repeat + (0,0,128);
	killcament moveto(bomb.killcament.origin * 0.35 + hitpos * 0.65, 1.5, 0, 0.5);
	wait 5;
	newbomb delete();
	bomb delete();
}

spawnbomb(origin, angles)
{
	bomb = spawn("script_model", origin);
	bomb.angles = angles;
	bomb setmodel("projectile_cbu97_clusterbomb");
	return bomb;
}

deleteaftertime(time)
{
	self endon("death");
	wait 10;
	self delete();
}

playplanefx()
{
	self endon("death");
	wait 0.5;
	playfxontag(level.fx_airstrike_afterburner, self, "tag_engine_right");
	wait 0.5;
	playfxontag(level.fx_airstrike_afterburner, self, "tag_engine_left");
	wait 0.5;
	playfxontag(level.fx_airstrike_contrail, self, "tag_right_wingtip");
	wait 0.5;
	playfxontag(level.fx_airstrike_contrail, self, "tag_left_wingtip");
}

callstrike(lifeid, owner, coord, yaw)
{
	heightent = undefined;
	planebombexplodedistance = 0;
	direction = (0,yaw,0);
	heightent = getent("airstrikeheight", "targetname");
	if(self.airstriketype == "stealth")
	{
		thread maps\mp\_utility::teamplayercardsplash("used_stealth_airstrike", owner, owner.team);
		planehalfdistance = 12000;
		planeflyspeed = 2000;
		if(!isdefined(heightent))
		{
			planeflyheight = 950;
			planebombexplodedistance = 1500;
			if(isdefined(level.airstrikeheightscale))
			{
				planeflyheight = planeflyheight * level.airstrikeheightscale;
			}
		}
		else
		{
			planeflyheight = heightent.origin[2];
			planebombexplodedistance = getexplodedistance(planeflyheight);
		}
	}
	else
	{
		planehalfdistance = 24000;
		planeflyspeed = 7000;
		if(!isdefined(heightent))
		{
			planeflyheight = 850;
			planebombexplodedistance = 1500;
			if(isdefined(level.airstrikeheightscale))
			{
				planeflyheight = planeflyheight * level.airstrikeheightscale;
			}
		}
		else
		{
			planeflyheight = heightent.origin[2];
			planebombexplodedistance = getexplodedistance(planeflyheight);
		}
	}

	startpoint = coord + common_scripts\utility::vector_multiply(anglestoforward(direction), -1 * planehalfdistance);
	if(isdefined(heightent))
	{
		startpoint = startpoint * (1,1,0);
	}

	startpoint = startpoint + (0,0,planeflyheight);
	if(self.airstriketype == "stealth")
	{
		endpoint = coord + common_scripts\utility::vector_multiply(anglestoforward(direction), planehalfdistance * 4);
	}
	else
	{
		endpoint = coord + common_scripts\utility::vector_multiply(anglestoforward(direction), planehalfdistance);
	}

	if(isdefined(heightent))
	{
		endpoint = endpoint * (1,1,0);
	}

	endpoint = endpoint + (0,0,planeflyheight);
	d = length(startpoint - endpoint);
	flytime = d / planeflyspeed;
	d = abs(d / 2 + planebombexplodedistance);
	bombtime = d / planeflyspeed;
	owner endon("disconnect");
	requireddeathcount = lifeid;
	level.airstrikedamagedents = [];
	level.airstrikedamagedentscount = 0;
	level.airstrikedamagedentsindex = 0;
	if(self.airstriketype == "harrier")
	{
		level thread doplanestrike(lifeid, owner, requireddeathcount, coord, startpoint + (0,0,randomint(500)), endpoint + (0,0,randomint(500)), bombtime, flytime, direction, self.airstriketype);
		wait randomfloatrange(1.5, 2.5);
		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
		level thread doplanestrike(lifeid, owner, requireddeathcount, coord, startpoint + (0,0,randomint(200)), endpoint + (0,0,randomint(200)), bombtime, flytime, direction, self.airstriketype);
		wait randomfloatrange(1.5, 2.5);
		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
		harrier = maps\mp\killstreaks\_harrier::beginharrier(lifeid, startpoint, coord);
		owner thread maps\mp\killstreaks\_harrier::defendlocation(harrier);
		return harrier;
	}

	if(self.airstriketype == "stealth")
	{
		level thread dobomberstrike(lifeid, owner, requireddeathcount, coord, startpoint + (0,0,randomint(1000)), endpoint + (0,0,randomint(1000)), bombtime, flytime, direction, self.airstriketype);
		return;
	}

	level thread doplanestrike(lifeid, owner, requireddeathcount, coord, startpoint + (0,0,randomint(500)), endpoint + (0,0,randomint(500)), bombtime, flytime, direction, self.airstriketype);
	wait randomfloatrange(1.5, 2.5);
	maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	level thread doplanestrike(lifeid, owner, requireddeathcount, coord, startpoint + (0,0,randomint(200)), endpoint + (0,0,randomint(200)), bombtime, flytime, direction, self.airstriketype);
	wait randomfloatrange(1.5, 2.5);
	maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	level thread doplanestrike(lifeid, owner, requireddeathcount, coord, startpoint + (0,0,randomint(200)), endpoint + (0,0,randomint(200)), bombtime, flytime, direction, self.airstriketype);
	if(self.airstriketype == "super")
	{
		wait randomfloatrange(2.5, 3.5);
		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
		level thread doplanestrike(lifeid, owner, requireddeathcount, coord, startpoint + (0,0,randomint(200)), endpoint + (0,0,randomint(200)), bombtime, flytime, direction, self.airstriketype);
		return;
	}
}

getexplodedistance(height)
{
	standardheight = 850;
	standarddistance = 1500;
	distancefrac = standardheight / height;
	newdistance = distancefrac * standarddistance;
	return newdistance;
}

targetgetdist(other, target)
{
	infront = targetisinfront(other, target);
	if(infront)
	{
		dir = 1;
	}
	else
	{
		dir = -1;
	}

	a = common_scripts\utility::flat_origin(other.origin);
	b = a + common_scripts\utility::vector_multiply(anglestoforward(common_scripts\utility::flat_angle(other.angles)), dir * 100000);
	point = pointonsegmentnearesttopoint(a, b, target);
	dist = distance(a, point);
	return dist;
}

targetisclose(other, target, closedist)
{
	if(!isdefined(closedist))
	{
		closedist = 3000;
	}

	infront = targetisinfront(other, target);
	if(infront)
	{
		dir = 1;
	}
	else
	{
		dir = -1;
	}

	a = common_scripts\utility::flat_origin(other.origin);
	b = a + common_scripts\utility::vector_multiply(anglestoforward(common_scripts\utility::flat_angle(other.angles)), dir * 100000);
	point = pointonsegmentnearesttopoint(a, b, target);
	dist = distance(a, point);
	if(dist < closedist)
	{
		return 1;
	}

	return 0;
}

targetisinfront(other, target)
{
	forwardvec = anglestoforward(common_scripts\utility::flat_angle(other.angles));
	normalvec = vectornormalize(common_scripts\utility::flat_origin(target) - other.origin);
	dot = vectordot(forwardvec, normalvec);
	if(dot > 0)
	{
		return 1;
	}

	return 0;
}

waitforairstrikecancel()
{
	self waittill("cancel_location");
	self setblurforplayer(0, 0.3);
}

selectairstrikelocation(lifeid, airstriketype)
{
	self.airstriketype = airstriketype;
	if(airstriketype == "precision" || airstriketype == "stealth")
	{
		choosedirection = 1;
	}
	else
	{
		choosedirection = 0;
	}

	targetsize = level.mapsize / 5.625;
	if(level.splitscreen)
	{
		targetsize = targetsize * 1.5;
	}

	self beginlocationselection("map_artillery_selector", choosedirection, targetsize);
	self.selectinglocation = 1;
	self setblurforplayer(4, 0.3);
	thread waitforairstrikecancel();
	thread endselectionon("cancel_location");
	thread endselectionon("death");
	thread endselectionon("disconnect");
	thread endselectionon("used");
	thread endselectionongameend();
	thread endselectiononemp();
	self endon("stop_location_selection");
	self waittill("confirm_location", location, directionyaw);
	if(!choosedirection)
	{
		directionyaw = randomint(360);
	}

	self setblurforplayer(0, 0.3);
	if(airstriketype == "harrier" && level.planes > 1)
	{
		self notify("cancel_location");
		self iprintlnbold(&"MP_AIR_SPACE_TOO_CROWDED");
		return 0;
	}

	thread finishairstrikeusage(lifeid, location, directionyaw);
	return 1;
}

finishairstrikeusage(lifeid, location, directionyaw)
{
	self notify("used");
	trace = bullettrace(level.mapcenter + (0,0,1000000), level.mapcenter, 0, undefined);
	location = (location[0],location[1],trace["position"][2] - 514);
	thread doairstrike(lifeid, location, directionyaw, self, self.pers["team"]);
}

endselectionon(waitfor)
{
	self endon("stop_location_selection");
	self waittill(waitfor);
	thread stopairstrikelocationselection(waitfor == "disconnect");
}

endselectionongameend()
{
	self endon("stop_location_selection");
	level waittill("game_ended");
	thread stopairstrikelocationselection(0);
}

endselectiononemp()
{
	self endon("stop_location_selection");
	for(;;)
	{
		level waittill("emp_update");
		if(!maps\mp\_utility::isemped())
		{
			continue;
		}

		thread stopairstrikelocationselection(0);
		return;
	}
}

stopairstrikelocationselection(disconnected)
{
	if(!disconnected)
	{
		self setblurforplayer(0, 0.3);
		self endlocationselection();
		self.selectinglocation = undefined;
	}

	self notify("stop_location_selection");
}

useairstrike(lifeid, pos, yaw)
{
}

handleemp(owner)
{
	self endon("death");
	if(owner maps\mp\_utility::isemped())
	{
		playfxontag(level.onfirefx, self, "tag_engine_right");
		playfxontag(level.onfirefx, self, "tag_engine_left");
		return;
	}

	for(;;)
	{
		level waittill("emp_update");
		if(!owner maps\mp\_utility::isemped())
		{
			continue;
		}

		playfxontag(level.onfirefx, self, "tag_engine_right");
		playfxontag(level.onfirefx, self, "tag_engine_left");
	}
}