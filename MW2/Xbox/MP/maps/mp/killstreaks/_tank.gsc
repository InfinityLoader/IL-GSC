/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_tank.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

init()
{
}

spawnarmor(owner, vehicletype, model)
{
	armor = self vehicle_dospawn("tank", owner);
	armor.health = 3000;
	armor.targeting_delay = 1;
	armor.team = owner.team;
	armor.pers["team"] = armor.team;
	armor.owner = owner;
	armor setcandamage(1);
	armor.standardspeed = 12;
	armor thread deleteonz();
	armor addtotanklist();
	armor.damagecallback = ::callback_vehicledamage;
	return armor;
}

deleteonz()
{
	self endon("death");
	originalz = self.origin[2];
	for(;;)
	{
		if(originalz - self.origin[2] > 2048)
		{
			self.health = 0;
			self notify("death");
			return;
		}

		wait 1;
	}
}

usetank(lifeid)
{
	return tryusetank();
}

tryusetank()
{
	if(isdefined(level.tankinuse) && level.tankinuse)
	{
		self iprintlnbold("Armor support unavailable.");
		return 0;
	}

	if(!isdefined(getvehiclenode("startnode", "targetname")))
	{
		self iprintlnbold("Tank is currently not supported in this level, bug your friendly neighborhood LD.");
		return 0;
	}

	if(!vehicle_getspawnerarray().size)
	{
		return 0;
	}

	if(self.team == "allies")
	{
		tank = level.tankspawner["allies"] spawnarmor(self, "vehicle_bradley");
	}
	else
	{
		tank = level.tankspawner["axis"] spawnarmor(self, "vehicle_bmp");
	}

	tank starttank();
	return 1;
}

starttank(param_DB1)
{
	startnode = getvehiclenode("startnode", "targetname");
	waitnode = getvehiclenode("waitnode", "targetname");
	self.nodes = getvehiclenodearray("info_vehicle_node", "classname");
	level.tankinuse = 1;
	thread tankupdate(startnode, waitnode);
	thread tankdamagemonitor();
	level.tank = self;
	if(level.teambased)
	{
		objidallies = maps\mp\gametypes\_gameobjects::getnextobjid();
		objective_add(objidallies, "invisible", (0,0,0));
		objective_team(objidallies, "allies");
		level.tank.objid["allies"] = objidallies;
		objidaxis = maps\mp\gametypes\_gameobjects::getnextobjid();
		objective_add(objidaxis, "invisible", (0,0,0));
		objective_team(objidaxis, "axis");
		level.tank.objid["axis"] = objidaxis;
		team = self.team;
		level.tank.team = team;
		level.tank.pers["team"] = team;
	}

	mgturret = spawnturret("misc_turret", self.origin, "abrams_minigun_mp");
	mgturret linkto(self, "tag_engine_left", (0,0,-20), (0,0,0));
	mgturret setmodel("sentry_minigun");
	mgturret.angles = self.angles;
	mgturret.owner = self.owner;
	mgturret maketurretinoperable();
	self.mgturret = mgturret;
	self.mgturret setdefaultdroppitch(0);
	oldangles = self.angles;
	self.angles = (0,0,0);
	tankturretpoint = self gettagorigin("tag_flash");
	self.angles = oldangles;
	offset = tankturretpoint - self.origin;
	thread waitforchangeteams();
	thread waitfordisco();
	self.timelastfired = gettime();
	neutraltargetent = spawn("script_origin", self gettagorigin("tag_flash"));
	neutraltargetent linkto(self, "tag_origin", offset, (0,0,0));
	neutraltargetent hide();
	self.neutraltarget = neutraltargetent;
	thread tankgettargets();
	thread destroytank();
	thread tankgetminitargets();
	thread checkdanger();
	thread watchforthreat();
}

waitforchangeteams()
{
	self endon("death");
	self.owner endon("disconnect");
	self.owner waittill("joined_team");
	self.health = 0;
	self notify("death");
}

waitfordisco()
{
	self endon("death");
	self.owner waittill("disconnect");
	self.health = 0;
	self notify("death");
}

setdirection(direction)
{
	if(self.veh_pathdir != direction)
	{
		if(direction == "forward")
		{
			stoptoforward();
			return;
		}

		stoptoreverse();
		return;
	}
}

setengagementspeed()
{
	self endon("death");
	self notify("path_abandoned");
	while(isdefined(self.changingdirection))
	{
		wait 0.05;
	}

	newspeed = 2;
	self vehicle_setspeed(newspeed, 10, 10);
	self.speedtype = "engage";
}

setminiengagementspeed()
{
	self endon("death");
	self notify("path_abandoned");
	while(isdefined(self.changingdirection))
	{
		wait 0.05;
	}

	newspeed = 2;
	self vehicle_setspeed(newspeed, 10, 10);
	self.speedtype = "engage";
}

setstandardspeed()
{
	self endon("death");
	while(isdefined(self.changingdirection))
	{
		wait 0.05;
	}

	self vehicle_setspeed(self.standardspeed, 10, 10);
	self.speedtype = "standard";
}

setevadespeed()
{
	self endon("death");
	while(isdefined(self.changingdirection))
	{
		wait 0.05;
	}

	self vehicle_setspeed(15, 15, 15);
	self.speedtype = "evade";
	wait 1.5;
	self vehicle_setspeed(self.standardspeed, 10, 10);
}

setdangerspeed()
{
	self endon("death");
	while(isdefined(self.changingdirection))
	{
		wait 0.05;
	}

	self vehicle_setspeed(5, 5, 5);
	self.speedtype = "danger";
}

stoptoreverse()
{
	debugprintln2("tank changing direction at " + gettime());
	self vehicle_setspeed(0, 5, 6);
	self.changingdirection = 1;
	while(self.veh_speed > 0)
	{
		wait 0.05;
	}

	wait 0.25;
	self.changingdirection = undefined;
	debugprintln2("tank done changing direction");
	self.veh_transmission = "reverse";
	self.veh_pathdir = "reverse";
	self vehicle_setspeed(self.standardspeed, 5, 6);
}

stoptoforward()
{
	debugprintln2("tank changing direction at " + gettime());
	self vehicle_setspeed(0, 5, 6);
	self.changingdirection = 1;
	while(self.veh_speed > 0)
	{
		wait 0.05;
	}

	wait 0.25;
	self.changingdirection = undefined;
	debugprintln2("tank done changing direction");
	self.veh_transmission = "forward";
	self.veh_pathdir = "forward";
	self vehicle_setspeed(self.standardspeed, 5, 6);
}

checkdanger()
{
	self endon("death");
	targets = [];
	players = level.players;
	self.numenemiesclose = 0;
	for(;;)
	{
		foreach(potentialtarget in players)
		{
			if(!isdefined(potentialtarget))
			{
				continue;
			}

			if(potentialtarget.team == self.team)
			{
				wait 0.05;
				continue;
			}

			dist = distance2d(potentialtarget.origin, self.origin);
			if(dist < 2048)
			{
				self.numenemiesclose++;
			}

			wait 0.05;
		}

		if(isdefined(self.speedtype) && self.speedtype == "evade" || self.speedtype == "engage")
		{
			self.numenemiesclose = 0;
			continue;
		}

		if(self.numenemiesclose > 1)
		{
			thread setdangerspeed();
		}
		else
		{
			thread setstandardspeed();
		}

		self.numenemiesclose = 0;
		wait 0.05;
	}
}

tankupdate(startnode, waitnode)
{
	self endon("tankDestroyed");
	self endon("death");
	if(!isdefined(level.graphnodes))
	{
		self startpath(startnode);
		return;
	}

	self attachpath(startnode);
	self startpath(startnode);
	startnode notify("trigger", self, 1);
	wait 0.05;
	for(;;)
	{
		while(isdefined(self.changingdirection))
		{
			wait 0.05;
		}

		endnode = getnodenearenemies();
		if(isdefined(endnode))
		{
			self.endnode = endnode;
		}
		else
		{
			self.endnode = undefined;
		}

		wait 0.65;
	}
}

callback_vehicledamage(inflictor, attacker, damage, dflags, meansofdeath, weapon, point, dir, hitloc, timeoffset, modelindex, partname)
{
	if((attacker == self || attacker == self.mgturret || isdefined(attacker.pers) && attacker.pers["team"] == self.team) && attacker != self.owner || meansofdeath == "MOD_MELEE")
	{
		return;
	}

	tankdamage = modifydamage(meansofdeath, damage, attacker);
	self vehicle_finishdamage(inflictor, attacker, tankdamage, dflags, meansofdeath, weapon, point, dir, hitloc, timeoffset, modelindex, partname);
}

tankdamagemonitor()
{
	self endon("death");
	self.damagetaken = 0;
	speed = self vehicle_getspeed();
	maxhealth = self.health;
	stage1 = 0;
	stage2 = 0;
	stage3 = 0;
	for(;;)
	{
		self waittill("damage", amount, attacker, direction_vec, point, damagetype);
		if(isdefined(attacker.classname) && attacker.classname == "script_vehicle")
		{
			if(isdefined(self.besttarget) && self.besttarget != attacker)
			{
				self.forcedtarget = attacker;
				thread explicitabandontarget();
			}
		}
		else if(isplayer(attacker))
		{
			attacker maps\mp\gametypes\_damagefeedback::updatedamagefeedback("hitHelicopter");
			if(attacker maps\mp\_utility::_hasperk("specialty_armorpiercing"))
			{
				damageadd = amount * level.armorpiercingmod;
				self.health = self.health - int(damageadd);
			}
		}

		if(self.health <= 0)
		{
			self notify("death");
			return;
		}
		else if(self.health < maxhealth / 4 && stage3 == 0)
		{
			stage3 = 1;
		}
		else if(self.health < maxhealth / 2 && stage2 == 0)
		{
			stage2 = 1;
		}
		else if(self.health < maxhealth / 1.5 && stage1 == 0)
		{
			stage1 = 1;
		}

		if(amount > 1000)
		{
			handlethreat(attacker);
		}
	}
}

handlethreat(attacker)
{
	self endon("death");
	rand = randomint(100);
	if(isdefined(self.besttarget) && self.besttarget != attacker && rand > 30)
	{
		targ = [];
		targ[0] = self.besttarget;
		explicitabandontarget(1, self.besttarget);
		thread acquiretarget(targ);
		return;
	}

	if(!isdefined(self.besttarget) && rand > 30)
	{
		targ = [];
		targ[0] = attacker;
		thread acquiretarget(targ);
		return;
	}

	if(rand < 30)
	{
		playfx(level.tankcover, self.origin);
		thread setevadespeed();
		return;
	}

	self fireweapon();
	self playsound("bmp_fire");
}

handlepossiblethreat(attacker)
{
	self endon("death");
	position = relativeangle(attacker);
	distance = distance(self.origin, attacker.origin);
	if(randomint(4) < 3)
	{
		return;
	}

	if(position == "front" && distance < 768)
	{
		thread setevadespeed();
		return;
	}

	if(position == "rear_side" || position == "rear" && distance >= 768)
	{
		playfx(level.tankcover, self.origin);
		thread setevadespeed();
		return;
	}

	if(position == "rear" && distance < 768)
	{
		stoptoreverse();
		setevadespeed();
		wait 4;
		stoptoforward();
		return;
	}

	if(position == "front_side" || position == "front")
	{
		playfx(level.tankcover, self.origin);
		stoptoreverse();
		setevadespeed();
		wait 8;
		stoptoforward();
		return;
	}
}

relativeangle(ent1)
{
	self endon("death");
	ent1 endon("death");
	ent1 endon("disconnect");
	tankforwardvector = anglestoforward(self.angles);
	tanktoent = ent1.origin - self.origin;
	tankforwardvector = tankforwardvector * (1,1,0);
	tanktoent = tanktoent * (1,1,0);
	tanktoent = vectornormalize(tanktoent);
	tankforwardvector = vectornormalize(tankforwardvector);
	targetcosine = vectordot(tanktoent, tankforwardvector);
	if(targetcosine > 0)
	{
		if(targetcosine > 0.9)
		{
			return "front";
		}
		else
		{
			return "front_side";
		}
	}
	else if(targetcosine < -0.9)
	{
		return "rear";
	}
	else
	{
		return "rear_side";
	}

	ent1 iprintlnbold(targetcosine);
}

watchforthreat()
{
	self endon("death");
	for(;;)
	{
		targets = [];
		players = level.players;
		foreach(player in players)
		{
			if(!isdefined(player))
			{
				wait 0.05;
				continue;
			}

			if(!istarget(player))
			{
				wait 0.05;
				continue;
			}

			currentweapon = player getcurrentweapon();
			if(issubstr(currentweapon, "at4") || issubstr(currentweapon, "stinger") || issubstr(currentweapon, "javelin"))
			{
				thread handlepossiblethreat(player);
				wait 8;
			}

			wait 0.15;
		}
	}
}

checkowner()
{
	if(!isdefined(self.owner) || !isdefined(self.owner.pers["team"]) || self.owner.pers["team"] != self.team)
	{
		self notify("abandoned");
		return 0;
	}

	return 1;
}

drawline(start, end, timeslice, color)
{
	drawtime = int(timeslice * 20);
	for(time = 0;time < drawtime;time++)
	{
		wait 0.05;
	}
}

modifydamage(damagetype, amount, attacker)
{
	if(damagetype == "MOD_RIFLE_BULLET")
	{
		return amount;
	}

	if(damagetype == "MOD_PISTOL_BULLET")
	{
		return amount;
	}

	if(damagetype == "MOD_IMPACT")
	{
		return amount;
	}

	if(damagetype == "MOD_MELEE")
	{
		return 0;
	}

	if(damagetype == "MOD_EXPLOSIVE_BULLET")
	{
		return amount;
	}

	if(damagetype == "MOD_GRENADE")
	{
		return amount * 5;
	}

	if(damagetype == "MOD_GRENADE_SPLASH")
	{
		return amount * 5;
	}

	return amount * 10;
}

destroytank()
{
	self waittill("death");
	if(level.teambased)
	{
		team = level.tank.team;
		objective_state(level.tank.objid[team], "invisible");
		objective_state(level.tank.objid[level.otherteam[team]], "invisible");
	}

	self notify("tankDestroyed");
	self vehicle_setspeed(0, 10, 10);
	level.tankinuse = 0;
	playfx(level.spawnfire, self.origin);
	playfx(level.tankfire, self.origin);
	removefromtanklist();
	destroyedtank = spawn("script_model", self.origin);
	destroyedtank setmodel("vehicle_m1a1_abrams_d_static");
	destroyedtank.angles = self.angles;
	self.mgturret delete();
	self delete();
	wait 4;
	destroyedtank delete();
}

onhitpitchclamp()
{
	self notify("onTargOrTimeOut");
	self endon("onTargOrTimeOut");
	self endon("turret_on_target");
	self waittill("turret_pitch_clamped");
	thread explicitabandontarget(0, self.besttarget);
}

fireontarget()
{
	self endon("abandonedTarget");
	self endon("killedTarget");
	self endon("death");
	self endon("targetRemoved");
	self endon("lostLOS");
	for(;;)
	{
		onhitpitchclamp();
		if(!isdefined(self.besttarget))
		{
			continue;
		}

		flashorigin = self gettagorigin("tag_flash");
		trace = bullettrace(self.origin, flashorigin, 0, self);
		if(trace["position"] != flashorigin)
		{
			thread explicitabandontarget(0, self.besttarget);
		}

		trace = bullettrace(flashorigin, self.besttarget.origin, 1, self);
		distance = distance(self.origin, trace["position"]);
		realdistance = distance(self.besttarget.origin, self.origin);
		if(distance < 384 || distance + 256 < realdistance)
		{
			wait 0.5;
			if(distance > 384)
			{
				waitforturretready();
				self fireweapon();
				self playsound("bmp_fire");
				self.timelastfired = gettime();
			}

			position = relativeangle(self.besttarget);
			thread explicitabandontarget(0, self.besttarget);
			return;
		}

		waitforturretready();
		self fireweapon();
		self playsound("bmp_fire");
		self.timelastfired = gettime();
	}
}

waitforturretready()
{
	self endon("abandonedTarget");
	self endon("killedTarget");
	self endon("death");
	self endon("targetRemoved");
	self endon("lostLOS");
	timewaited = gettime() - self.timelastfired;
	if(timewaited < 1499)
	{
		wait 1.5 - timewaited / 1000;
		return;
	}
}

tankgettargets(badtarget)
{
	self endon("death");
	self endon("leaving");
	targets = [];
	for(;;)
	{
		targets = [];
		players = level.players;
		if(isdefined(self.forcedtarget))
		{
			targets = [];
			targets[0] = self.forcedtarget;
			acquiretarget(targets);
			self.forcedtarget = undefined;
		}

		if(isdefined(level.harrier) && level.harrier.team != self.team && isalive(level.harrier))
		{
			if(isvehicletarget(level.tank))
			{
				targets[targets.size] = level.tank;
			}
		}

		if(isdefined(level.chopper) && level.chopper.team != self.team && isalive(level.chopper))
		{
			if(isvehicletarget(level.chopper))
			{
				targets[targets.size] = level.chopper;
			}
		}

		foreach(potentialtarget in players)
		{
			if(!isdefined(potentialtarget))
			{
				wait 0.05;
				continue;
			}

			if(isdefined(badtarget) && potentialtarget == badtarget)
			{
				continue;
			}

			if(istarget(potentialtarget))
			{
				if(isdefined(potentialtarget))
				{
					targets[targets.size] = potentialtarget;
				}

				continue;
			}

			continue;
		}

		if(targets.size > 0)
		{
			acquiretarget(targets);
			continue;
		}

		wait 1;
	}
}

acquiretarget(targets)
{
	self endon("death");
	if(targets.size == 1)
	{
		self.besttarget = targets[0];
	}
	else
	{
		self.besttarget = getbesttarget(targets);
	}

	thread setengagementspeed();
	thread watchtargetdeath(targets);
	self setturrettargetent(self.besttarget);
	fireontarget();
	thread setnotarget();
}

setnotarget()
{
	self endon("death");
	setstandardspeed();
	removetarget();
	self setturrettargetent(self.neutraltarget);
}

getbesttarget(targets)
{
	self endon("death");
	maingunpointorigin = self gettagorigin("tag_flash");
	tankorigin = self.origin;
	bestyaw = undefined;
	besttarget = undefined;
	targethasrocket = 0;
	foreach(targ in targets)
	{
		angle = abs(vectortoangles(targ.origin - self.origin)[1]);
		cannonangle = abs(self gettagangles("tag_flash")[1]);
		angle = abs(angle - cannonangle);
		if(isdefined(level.chopper) && targ == level.chopper)
		{
			return targ;
		}

		if(isdefined(level.harrier) && targ == level.harrier)
		{
			return targ;
		}

		weaponsarray = targ getweaponslistitems();
		foreach(weapon in weaponsarray)
		{
			if(issubstr(weapon, "at4") || issubstr(weapon, "jav") || issubstr(weapon, "c4"))
			{
				angle = angle - 40;
			}
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

watchtargetdeath(targets)
{
	self endon("abandonedTarget");
	self endon("lostLOS");
	self endon("death");
	self endon("targetRemoved");
	besttarg = self.besttarget;
	besttarg endon("disconnect");
	besttarg waittill("death");
	self notify("killedTarget");
	removetarget();
	setstandardspeed();
	thread setnotarget();
}

explicitabandontarget(nonewtarget, targ)
{
	self endon("death");
	self notify("abandonedTarget");
	setstandardspeed();
	thread setnotarget();
	removetarget();
	if(isdefined(targ))
	{
		self.badtarget = targ;
		badtargetreset();
	}

	if(isdefined(nonewtarget) && nonewtarget)
	{
		return;
	}
}

badtargetreset()
{
	self endon("death");
	wait 1.5;
	self.badtarget = undefined;
}

removetarget()
{
	self notify("targetRemoved");
	self.besttarget = undefined;
	self.lastlosttime = undefined;
}

isvehicletarget(potentialtarget)
{
	if(distance2d(potentialtarget.origin, self.origin) > 4096)
	{
		return 0;
	}

	if(distance(potentialtarget.origin, self.origin) < 512)
	{
		return 0;
	}

	return turretsighttrace(potentialtarget, 0);
}

istarget(potentialtarget)
{
	self endon("death");
	dist = distancesquared(potentialtarget.origin, self.origin);
	if(!level.teambased && isdefined(self.owner) && potentialtarget == self.owner)
	{
		return 0;
	}

	if(!isalive(potentialtarget) || potentialtarget.sessionstate != "playing")
	{
		return 0;
	}

	if(dist > 16777216)
	{
		return 0;
	}

	if(dist < 262144)
	{
		return 0;
	}

	if(!isdefined(potentialtarget.pers["team"]))
	{
		return 0;
	}

	if(potentialtarget == self.owner)
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

	return self vehicle_canturrettargetpoint(potentialtarget.origin, 1, self);
}

turretsighttrace(targ, debug)
{
	turretcanseetarget = targ sightconetrace(self gettagorigin("tag_turret"), self);
	if(turretcanseetarget < 0.7)
	{
		return 0;
	}

	if(isdefined(debug) && debug)
	{
		thread drawline(targ.origin, self gettagorigin("tag_turret"), 10, (1,0,0));
	}

	return 1;
}

isminitarget(potentialtarget)
{
	self endon("death");
	if(!isalive(potentialtarget) || potentialtarget.sessionstate != "playing")
	{
		return 0;
	}

	if(!isdefined(potentialtarget.pers["team"]))
	{
		return 0;
	}

	if(potentialtarget == self.owner)
	{
		return 0;
	}

	if(distancesquared(potentialtarget.origin, self.origin) > 1048576)
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

	if(isdefined(self))
	{
		minturreteye = self.mgturret.origin + (0,0,64);
		minturretcanseetarget = potentialtarget sightconetrace(minturreteye, self);
		if(minturretcanseetarget < 1)
		{
			return 0;
		}
	}

	return 1;
}

tankgetminitargets()
{
	self endon("death");
	self endon("leaving");
	minitargets = [];
	for(;;)
	{
		minitargets = [];
		players = level.players;
		for(i = 0;i <= players.size;i++)
		{
			if(isminitarget(players[i]))
			{
				if(isdefined(players[i]))
				{
					minitargets[minitargets.size] = players[i];
				}
			}
			else
			{
				continue;
			}

			wait 0.05;
		}

		if(minitargets.size > 0)
		{
			acquireminitarget(minitargets);
			return;
		}
		else
		{
			wait 0.5;
		}
	}
}

getbestminitarget(targets)
{
	self endon("death");
	tankorigin = self.origin;
	closest = undefined;
	besttarget = undefined;
	foreach(targ in targets)
	{
		curdist = distance(self.origin, targ.origin);
		curweaon = targ getcurrentweapon();
		if(issubstr(curweaon, "at4") || issubstr(curweaon, "jav") || issubstr(curweaon, "c4") || issubstr(curweaon, "smart") || issubstr(curweaon, "grenade"))
		{
			curdist = curdist - 200;
		}

		if(!isdefined(closest))
		{
			closest = curdist;
			besttarget = targ;
			continue;
		}

		if(closest > curdist)
		{
			closest = curdist;
			besttarget = targ;
		}
	}

	return besttarget;
}

acquireminitarget(targets)
{
	self endon("death");
	if(targets.size == 1)
	{
		self.bestminitarget = targets[0];
	}
	else
	{
		self.bestminitarget = getbestminitarget(targets);
	}

	if(distance2d(self.origin, self.bestminitarget.origin) > 768)
	{
		thread setminiengagementspeed();
	}

	self notify("acquiringMiniTarget");
	self.mgturret settargetentity(self.bestminitarget, (0,0,64));
	wait 0.15;
	thread fireminiontarget();
	thread watchminitargetdeath(targets);
	thread watchminitargetdistance(targets);
	thread watchminitargetthreat(self.bestminitarget);
}

fireminiontarget()
{
	self endon("death");
	self endon("abandonedMiniTarget");
	self endon("killedMiniTarget");
	notargtime = undefined;
	miniacquiredtime = gettime();
	if(!isdefined(self.bestminitarget))
	{
		return;
	}

	for(;;)
	{
		if(!isdefined(self.mgturret getturrettarget(1)))
		{
			if(!isdefined(notargtime))
			{
				notargtime = gettime();
			}

			curtime = gettime();
			if(notargtime - curtime > 1)
			{
				notargtime = undefined;
				thread explicitabandonminitarget();
				return;
			}

			wait 0.5;
			continue;
		}

		if(gettime() > miniacquiredtime + 1000 && !isdefined(self.besttarget))
		{
			if(distance2d(self.origin, self.bestminitarget.origin) > 768)
			{
				targets[0] = self.bestminitarget;
				acquiretarget(targets);
			}
		}

		numshots = randomintrange(10, 16);
		for(i = 0;i < numshots;i++)
		{
			self.mgturret shootturret();
			wait 0.1;
		}

		wait randomfloatrange(0.5, 3);
	}
}

watchminitargetdeath(targets)
{
	self endon("abandonedMiniTarget");
	self endon("death");
	if(!isdefined(self.bestminitarget))
	{
		return;
	}

	self.bestminitarget waittill("death");
	self notify("killedMiniTarget");
	self.bestminitarget = undefined;
	self.mgturret cleartargetentity();
	tankgetminitargets();
}

watchminitargetdistance(targets)
{
	self endon("abandonedMiniTarget");
	self endon("death");
	for(;;)
	{
		if(!isdefined(self.bestminitarget))
		{
			return;
		}

		trace = bullettrace(self.mgturret.origin, self.bestminitarget.origin, 0, self);
		tracedistance = distance(self.origin, trace["position"]);
		if(tracedistance > 1024)
		{
			thread explicitabandonminitarget();
			return;
		}

		wait 2;
	}
}

watchminitargetthreat(curtarget)
{
	self endon("abandonedMiniTarget");
	self endon("death");
	self endon("killedMiniTarget");
	for(;;)
	{
		minitargets = [];
		players = level.players;
		for(i = 0;i <= players.size;i++)
		{
			if(isminitarget(players[i]))
			{
				if(!isdefined(players[i]))
				{
					continue;
				}

				if(!isdefined(curtarget))
				{
					return;
				}

				traceoldtarg = distance(self.origin, curtarget.origin);
				tracenewtarg = distance(self.origin, players[i].origin);
				if(tracenewtarg < traceoldtarg)
				{
					thread explicitabandonminitarget();
					return;
				}
			}

			wait 0.05;
		}

		wait 0.25;
	}
}

explicitabandonminitarget(nonewtarget)
{
	self notify("abandonedMiniTarget");
	self.bestminitarget = undefined;
	self.mgturret cleartargetentity();
	if(isdefined(nonewtarget) && nonewtarget)
	{
		return;
	}

	thread tankgetminitargets();
}

addtotanklist()
{
	level.tanks[self getentitynumber()] = self;
}

removefromtanklist()
{
	level.tanks[self getentitynumber()] = undefined;
}

getnodenearenemies()
{
	validenemies = [];
	foreach(player in level.players)
	{
		if(player.team == "spectator")
		{
			continue;
		}

		if(player.team == self.team)
		{
			continue;
		}

		if(!isalive(player))
		{
			continue;
		}

		player.dist = 0;
		validenemies[validenemies.size] = player;
	}

	if(!validenemies.size)
	{
		return undefined;
	}

	for(i = 0;i < validenemies.size;i++)
	{
		for(j = i + 1;j < validenemies.size;j++)
		{
			dist = distancesquared(validenemies[i].origin, validenemies[j].origin);
			validenemies[i].dist = validenemies[i].dist + dist;
			validenemies[j].dist = validenemies[j].dist + dist;
		}
	}

	bestplayer = validenemies[0];
	foreach(player in validenemies)
	{
		if(player.dist < bestplayer.dist)
		{
			bestplayer = player;
		}
	}

	bestorigin = bestplayer.origin;
	sortednodes = sortbydistance(level.graphnodes, bestorigin);
	return sortednodes[0];
}

setuppaths()
{
	tanknodes = [];
	startnodes = [];
	endnodes = [];
	astargraphnodes = [];
	tanknode = getvehiclenode("startnode", "targetname");
	tanknodes[tanknodes.size] = tanknode;
	startnodes[startnodes.size] = tanknode;
	while(isdefined(tanknode.target))
	{
		lastnode = tanknode;
		tanknode = getvehiclenode(tanknode.target, "targetname");
		tanknode.prev = lastnode;
		if(tanknode == tanknodes[0])
		{
			break;
		}

		tanknodes[tanknodes.size] = tanknode;
		if(!isdefined(tanknode.target))
		{
			return;
		}
	}

	tanknodes[0].branchnodes = [];
	tanknodes[0] thread handlebranchnode("forward");
	astargraphnodes[astargraphnodes.size] = tanknodes[0];
	branchnodes = getvehiclenodearray("branchnode", "targetname");
	foreach(branchnode in branchnodes)
	{
		tanknode = branchnode;
		tanknodes[tanknodes.size] = tanknode;
		startnodes[startnodes.size] = tanknode;
		while(isdefined(tanknode.target))
		{
			lastnode = tanknode;
			tanknode = getvehiclenode(tanknode.target, "targetname");
			tanknodes[tanknodes.size] = tanknode;
			tanknode.prev = lastnode;
			if(!isdefined(tanknode.target))
			{
				endnodes[endnodes.size] = tanknode;
			}
		}
	}

	foreach(tanknode in tanknodes)
	{
		isbranchnode = 0;
		foreach(startnode in startnodes)
		{
			if(startnode == tanknode)
			{
				continue;
			}

			if(startnode.target == tanknode.targetname)
			{
				continue;
			}

			if(isdefined(tanknode.target) && tanknode.target == startnode.targetname)
			{
				continue;
			}

			if(distance2d(tanknode.origin, startnode.origin) > 80)
			{
				continue;
			}

			startnode thread handlecapnode(tanknode, "reverse");
			startnode.prev = tanknode;
			if(!isdefined(tanknode.branchnodes))
			{
				tanknode.branchnodes = [];
			}

			tanknode.branchnodes[tanknode.branchnodes.size] = startnode;
			isbranchnode = 1;
		}

		if(isbranchnode)
		{
			tanknode thread handlebranchnode("forward");
		}

		isjoinnode = 0;
		foreach(endnode in endnodes)
		{
			if(endnode == tanknode)
			{
				continue;
			}

			if(!isdefined(tanknode.target))
			{
				continue;
			}

			if(tanknode.target == endnode.targetname)
			{
				continue;
			}

			if(isdefined(endnode.target) && endnode.target == tanknode.targetname)
			{
				continue;
			}

			if(distance2d(tanknode.origin, endnode.origin) > 80)
			{
				continue;
			}

			endnode thread handlecapnode(tanknode, "forward");
			endnode.next = getvehiclenode(tanknode.targetname, "targetname");
			endnode.length = distance(endnode.origin, tanknode.origin);
			if(!isdefined(tanknode.branchnodes))
			{
				tanknode.branchnodes = [];
			}

			tanknode.branchnodes[tanknode.branchnodes.size] = endnode;
			isjoinnode = 1;
		}

		if(isjoinnode)
		{
			tanknode thread handlebranchnode("reverse");
		}

		if(isjoinnode || isbranchnode)
		{
			astargraphnodes[astargraphnodes.size] = tanknode;
		}
	}

	if(astargraphnodes.size < 3)
	{
		level notify("end_tankPathHandling");
		return;
	}

	segmentnodes = [];
	foreach(tanknode in tanknodes)
	{
		if(!isdefined(tanknode.branchnodes))
		{
			continue;
		}

		segmentnodes[segmentnodes.size] = tanknode;
	}

	foreach(segmentnode in segmentnodes)
	{
		tanknode = segmentnode;
		pathlength = 0;
		while(isdefined(tanknode.target))
		{
			prevnode = tanknode;
			tanknode = getvehiclenode(tanknode.target, "targetname");
			pathlength = pathlength + distance(tanknode.origin, prevnode.origin);
			if(tanknode == segmentnode)
			{
				break;
			}

			if(isdefined(tanknode.branchnodes))
			{
				break;
			}
		}

		if(pathlength > 1000)
		{
			tanknode = segmentnode;
			curlength = 0;
			while(isdefined(tanknode.target))
			{
				prevnode = tanknode;
				tanknode = getvehiclenode(tanknode.target, "targetname");
				curlength = curlength + distance(tanknode.origin, prevnode.origin);
				if(curlength < pathlength / 2)
				{
					continue;
				}

				tanknode.branchnodes = [];
				tanknode thread handlebranchnode("forward");
				astargraphnodes[astargraphnodes.size] = tanknode;
				break;
			}
		}
	}

	level.graphnodes = initnodegraph(astargraphnodes);
	foreach(tanknode in tanknodes)
	{
		if(!isdefined(tanknode.graphid))
		{
			tanknode thread nodetracker();
		}
	}
}

getrandombranchnode(direction)
{
	branchnodes = [];
	foreach(graphid, linknode in self.links)
	{
		if(self.linkdirs[graphid] != direction)
		{
			continue;
		}

		branchnodes[branchnodes.size] = linknode;
	}

	return branchnodes[randomint(branchnodes.size)];
}

getnextnodeforendnode(endnode, direction)
{
	graphnode = level.graphnodes[self.graphid];
	continuepath = generatepath(graphnode, endnode, undefined, direction);
	continueg = continuepath[0].g;
	changepath = generatepath(graphnode, endnode, undefined, level.otherdir[direction]);
	changeg = changepath[0].g;
	if(!getdvarint("tankDebug"))
	{
		changeg = 9999999;
	}

	if(continueg <= changeg)
	{
		return continuepath[1];
	}
}

handlebranchnode(direction)
{
	level endon("end_tankPathHandling");
	for(;;)
	{
		self waittill("trigger", tank, wasforced);
		graphnode = level.graphnodes[self.graphid];
		tank.node = self;
		nextgraphnode = undefined;
		if(isdefined(tank.endnode) && tank.endnode != graphnode)
		{
			nextgraphnode = getnextnodeforendnode(tank.endnode, tank.veh_pathdir);
			if(!isdefined(nextgraphnode))
			{
				tank thread setdirection(level.otherdir[tank.veh_pathdir]);
			}
		}

		if(!isdefined(nextgraphnode) || nextgraphnode == graphnode)
		{
			nextgraphnode = graphnode getrandombranchnode(tank.veh_pathdir);
		}

		goalnode = graphnode.linkstartnodes[nextgraphnode.graphid];
		if(tank.veh_pathdir == "forward")
		{
			nextlinknode = getnextnode();
		}
		else
		{
			nextlinknode = getprevnode();
		}

		if(nextlinknode != goalnode)
		{
			tank startpath(goalnode);
		}
	}
}

handlecapnode(joinnode, direction)
{
	for(;;)
	{
		self waittill("trigger", tank);
		if(tank.veh_pathdir != direction)
		{
			continue;
		}

		debugprintln2("tank starting path at join node: " + joinnode.graphid);
		tank startpath(joinnode);
	}
}

nodetracker()
{
	self.forwardgraphid = getforwardgraphnode().graphid;
	self.reversegraphid = getreversegraphnode().graphid;
	for(;;)
	{
		self waittill("trigger", tank, wasforced);
		tank.node = self;
		tank.forwardgraphid = self.forwardgraphid;
		tank.reversegraphid = self.reversegraphid;
		if(!isdefined(self.target) || self.targetname == "branchnode")
		{
			nodetype = "TRANS";
		}
		else
		{
			nodetype = "NODE";
		}

		if(isdefined(wasforced))
		{
			debugprint3d(self.origin, nodetype, (1,0.5,0), 1, 2, 100);
			continue;
		}

		debugprint3d(self.origin, nodetype, (0,1,0), 1, 2, 100);
	}
}

forcetrigger(prevnode, nextnode, tank)
{
	nextnode endon("trigger");
	prevnode endon("trigger");
	tank endon("death");
	mindist = distancesquared(tank.origin, nextnode.origin);
	tankdir = tank.veh_pathdir;
	debugprint3d(prevnode.origin + (0,0,30), "LAST", (0,0,1), 0.5, 1, 100);
	debugprint3d(nextnode.origin + (0,0,60), "NEXT", (0,1,0), 0.5, 1, 100);
	timeoutnextframe = 0;
	for(;;)
	{
		wait 0.05;
		if(tankdir != tank.veh_pathdir)
		{
			debugprintln2("tank missed node: reversing direction");
			tank thread forcetrigger(nextnode, prevnode, tank);
			return;
		}

		if(timeoutnextframe)
		{
			debugprintln2("... sending notify.");
			nextnode notify("trigger", tank, 1);
			return;
		}

		curdist = distancesquared(tank.origin, nextnode.origin);
		if(curdist > mindist)
		{
			timeoutnextframe = 1;
			debugprintln2("tank missed node: forcing notify in one frame...");
		}

		mindist = curdist;
	}
}

getforwardgraphnode()
{
	checknode = self;
	while(!isdefined(checknode.graphid))
	{
		checknode = checknode getnextnode();
	}

	return checknode;
}

getreversegraphnode()
{
	checknode = self;
	while(!isdefined(checknode.graphid))
	{
		checknode = checknode getprevnode();
	}

	return checknode;
}

getnextnode()
{
	if(isdefined(self.target))
	{
		return getvehiclenode(self.target, "targetname");
	}

	return self.next;
}

getprevnode()
{
	return self.prev;
}

initnodegraph(astarbasenodes)
{
	graphnodes = [];
	foreach(pathnode in astarbasenodes)
	{
		graphnode = spawnstruct();
		graphnode.linkinfos = [];
		graphnode.links = [];
		graphnode.linklengths = [];
		graphnode.linkdirs = [];
		graphnode.linkstartnodes = [];
		graphnode.node = pathnode;
		graphnode.origin = pathnode.origin;
		graphnode.graphid = graphnodes.size;
		pathnode.graphid = graphnodes.size;
		debugprint3d(graphnode.origin + (0,0,80), graphnode.graphid, (1,1,1), 0.65, 2, 100000);
		graphnodes[graphnodes.size] = graphnode;
	}

	foreach(pathnode in astarbasenodes)
	{
		graphid = pathnode.graphid;
		checknode = getvehiclenode(pathnode.target, "targetname");
		linklength = distance(pathnode.origin, checknode.origin);
		linkstartnode = checknode;
		while(!isdefined(checknode.graphid))
		{
			linklength = linklength + distance(checknode.origin, checknode.prev.origin);
			if(isdefined(checknode.target))
			{
				checknode = getvehiclenode(checknode.target, "targetname");
				continue;
			}

			checknode = checknode.next;
		}

		graphnodes[graphid] addlinknode(graphnodes[checknode.graphid], linklength, "forward", linkstartnode);
		checknode = pathnode.prev;
		linklength = distance(pathnode.origin, checknode.origin);
		linkstartnode = checknode;
		while(!isdefined(checknode.graphid))
		{
			linklength = linklength + distance(checknode.origin, checknode.prev.origin);
			checknode = checknode.prev;
		}

		graphnodes[graphid] addlinknode(graphnodes[checknode.graphid], linklength, "reverse", linkstartnode);
		foreach(branchnode in pathnode.branchnodes)
		{
			checknode = branchnode;
			linklength = distance(pathnode.origin, checknode.origin);
			linkstartnode = checknode;
			if(checknode.targetname == "branchnode")
			{
				while(!isdefined(checknode.graphid))
				{
					if(isdefined(checknode.target))
					{
						nextnode = getvehiclenode(checknode.target, "targetname");
					}
					else
					{
						nextnode = checknode.next;
					}

					linklength = linklength + distance(checknode.origin, nextnode.origin);
					checknode = nextnode;
				}

				graphnodes[graphid] addlinknode(graphnodes[checknode.graphid], linklength, "forward", linkstartnode);
				continue;
			}

			while(!isdefined(checknode.graphid))
			{
				linklength = linklength + distance(checknode.origin, checknode.prev.origin);
				checknode = checknode.prev;
			}

			graphnodes[graphid] addlinknode(graphnodes[checknode.graphid], linklength, "reverse", linkstartnode);
		}
	}

	return graphnodes;
}

addlinknode(graphnode, linklength, param_E1D, linkstartnode)
{
	self.links[graphnode.graphid] = graphnode;
	self.linklengths[graphnode.graphid] = linklength;
	self.linkdirs[graphnode.graphid] = param_E1D;
	self.linkstartnodes[graphnode.graphid] = linkstartnode;
	linkinfo = spawnstruct();
	linkinfo.tographnode = graphnode;
	linkinfo.tographid = graphnode.graphid;
	linkinfo.length = linklength;
	linkinfo.direction = param_E1D;
	linkinfo.startnode = linkstartnode;
	self.linkinfos[graphnode.graphid] = linkinfo;
}

generatepath(destnode, startnode, blockednodes, direction)
{
	level.openlist = [];
	level.closedlist = [];
	foundpath = 0;
	pathnodes = [];
	if(!isdefined(blockednodes))
	{
		blockednodes = [];
	}

	startnode.g = 0;
	startnode.h = gethvalue(startnode, destnode);
	startnode.f = startnode.g + startnode.h;
	addtoclosedlist(startnode);
	curnode = startnode;
	for(;;)
	{
		foreach(checknode in curnode.links)
		{
			if(is_in_array(blockednodes, checknode))
			{
				continue;
			}

			if(is_in_array(level.closedlist, checknode))
			{
				continue;
			}

			if(isdefined(direction) && checknode.linkdirs[curnode.graphid] != direction)
			{
				continue;
			}

			if(!is_in_array(level.openlist, checknode))
			{
				addtoopenlist(checknode);
				checknode.parentnode = curnode;
				checknode.g = getgvalue(checknode, curnode);
				checknode.h = gethvalue(checknode, destnode);
				checknode.f = checknode.g + checknode.h;
				if(checknode == destnode)
				{
					foundpath = 1;
				}

				continue;
			}

			if(checknode.g < getgvalue(curnode, checknode))
			{
				continue;
			}

			checknode.parentnode = curnode;
			checknode.g = getgvalue(checknode, curnode);
			checknode.f = checknode.g + checknode.h;
		}

		if(foundpath)
		{
			break;
		}

		addtoclosedlist(curnode);
		bestnode = level.openlist[0];
		foreach(testnode in level.openlist)
		{
			if(testnode.f > bestnode.f)
			{
				continue;
			}

			bestnode = testnode;
		}

		addtoclosedlist(bestnode);
		curnode = bestnode;
	}

	curnode = destnode;
	while(curnode != startnode)
	{
		pathnodes[pathnodes.size] = curnode;
		curnode = curnode.parentnode;
	}

	pathnodes[pathnodes.size] = curnode;
	return pathnodes;
}

addtoopenlist(node)
{
	node.openlistid = level.openlist.size;
	level.openlist[level.openlist.size] = node;
	node.closedlistid = undefined;
}

addtoclosedlist(node)
{
	if(isdefined(node.closedlistid))
	{
		return;
	}

	node.closedlistid = level.closedlist.size;
	level.closedlist[level.closedlist.size] = node;
	if(!is_in_array(level.openlist, node))
	{
		return;
	}

	level.openlist[node.openlistid] = level.openlist[level.openlist.size - 1];
	level.openlist[node.openlistid].openlistid = node.openlistid;
	level.openlist[level.openlist.size - 1] = undefined;
	node.openlistid = undefined;
}

gethvalue(node1, node2)
{
	return distance(node1.node.origin, node2.node.origin);
}

getgvalue(node1, node2)
{
	return node1.parentnode.g + node1.linklengths[node2.graphid];
}

is_in_array(aecollection, efindee)
{
	for(i = 0;i < aecollection.size;i++)
	{
		if(aecollection[i] == efindee)
		{
			return 1;
		}
	}

	return 0;
}

drawpath(pathnodes)
{
	for(i = 1;i < pathnodes.size;i++)
	{
		startnode = pathnodes[i - 1];
		endnode = pathnodes[i];
		if(startnode.linkdirs[endnode.graphid] == "reverse")
		{
			level thread drawlink(startnode.node.origin, endnode.node.origin, (1,0,0));
		}
		else
		{
			level thread drawlink(startnode.node.origin, endnode.node.origin, (0,1,0));
		}

		vehnode = startnode.linkstartnodes[endnode.graphid];
		level thread drawlink(startnode.node.origin + (0,0,4), vehnode.origin + (0,0,4), (0,0,1));
		if(startnode.linkdirs[endnode.graphid] == "reverse")
		{
			while(!isdefined(vehnode.graphid))
			{
				lastvehnode = vehnode;
				vehnode = vehnode.prev;
				level thread drawlink(lastvehnode.origin + (0,0,4), vehnode.origin + (0,0,4), (0,1,1));
			}

			continue;
		}

		while(!isdefined(vehnode.graphid))
		{
			lastvehnode = vehnode;
			if(isdefined(vehnode.target))
			{
				vehnode = getvehiclenode(vehnode.target, "targetname");
				continue;
			}

			vehnode = vehnode.next;
			level thread drawlink(lastvehnode.origin + (0,0,4), vehnode.origin + (0,0,4), (0,1,1));
		}
	}
}

drawgraph(pathnodes)
{
}

drawlink(start, end, color)
{
	level endon("endpath");
	wait 0.05;
}

debugprintln2(printstring)
{
}

debugprint(printstring)
{
}

debugprint3d(origin, printstring, color, alpha, scale, duration)
{
}

drawtankgraphids()
{
}