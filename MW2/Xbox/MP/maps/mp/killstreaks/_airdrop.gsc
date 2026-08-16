/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_airdrop.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

init()
{
	precachevehicle("littlebird_mp");
	precachemodel("com_plasticcase_friendly");
	precachemodel("com_plasticcase_enemy");
	precachemodel("vehicle_little_bird_armed");
	precachemodel("vehicle_ac130_low_mp");
	precachemodel("sentry_minigun_folded");
	precachestring(&"PLATFORM_RESUPPLY");
	precachestring(&"PLATFORM_GET_RANDOM");
	precachestring(&"PLATFORM_GET_KILLSTREAK");
	precachestring(&"PLATFORM_CALL_NUKE");
	precachestring(&"MP_CAPTURING_CRATE");
	precachestring(&"MP_CIVILIAN_AIR_TRAFFIC");
	precachemodel(maps\mp\gametypes\_teams::getteamcratemodel("allies"));
	precachemodel(maps\mp\gametypes\_teams::getteamcratemodel("axis"));
	precacheshader(maps\mp\gametypes\_teams::getteamhudicon("allies"));
	precacheshader(maps\mp\gametypes\_teams::getteamhudicon("axis"));
	precacheshader("waypoint_ammo_friendly");
	precacheshader("compass_objpoint_ammo_friendly");
	precacheshader("compass_objpoint_ammo_enemy");
	precacheminimapicon("compass_objpoint_c130_friendly");
	precacheminimapicon("compass_objpoint_c130_enemy");
	game["strings"]["ammo_hint"] = &"MP_AMMO_PICKUP";
	game["strings"]["uav_hint"] = &"MP_UAV_PICKUP";
	game["strings"]["counter_uav_hint"] = &"MP_COUNTER_UAV_PICKUP";
	game["strings"]["sentry_hint"] = &"MP_SENTRY_PICKUP";
	game["strings"]["predator_missile_hint"] = &"MP_PREDATOR_MISSILE_PICKUP";
	game["strings"]["airstrike_hint"] = &"MP_AIRSTRIKE_PICKUP";
	game["strings"]["precision_airstrike_hint"] = &"MP_PRECISION_AIRSTRIKE_PICKUP";
	game["strings"]["harrier_airstrike_hint"] = &"MP_HARRIER_AIRSTRIKE_PICKUP";
	game["strings"]["helicopter_hint"] = &"MP_HELICOPTER_PICKUP";
	game["strings"]["helicopter_flares_hint"] = &"MP_HELICOPTER_FLARES_PICKUP";
	game["strings"]["stealth_airstrike_hint"] = &"MP_STEALTH_AIRSTRIKE_PICKUP";
	game["strings"]["helicopter_minigun_hint"] = &"MP_HELICOPTER_MINIGUN_PICKUP";
	game["strings"]["ac130_hint"] = &"MP_AC130_PICKUP";
	game["strings"]["emp_hint"] = &"MP_EMP_PICKUP";
	game["strings"]["nuke_hint"] = &"MP_NUKE_PICKUP";
	level.airdropcrates = getentarray("care_package", "targetname");
	level.oldairdropcrates = getentarray("airdrop_crate", "targetname");
	if(!level.airdropcrates.size)
	{
		level.airdropcrates = level.oldairdropcrates;
		level.airdropcratecollision = getent(level.airdropcrates[0].target, "targetname");
	}
	else
	{
		foreach(crate in level.oldairdropcrates)
		{
			crate delete();
		}

		level.airdropcratecollision = getent(level.airdropcrates[0].target, "targetname");
		level.oldairdropcrates = getentarray("airdrop_crate", "targetname");
	}

	if(level.airdropcrates.size)
	{
		foreach(crate in level.airdropcrates)
		{
			crate delete();
		}
	}

	level.killstreakfuncs["airdrop"] = ::tryuseairdrop;
	level.killstreakfuncs["airdrop_predator_missile"] = ::tryuseairdroppredatormissile;
	level.killstreakfuncs["airdrop_sentry_minigun"] = ::tryuseairdropsentryminigun;
	level.killstreakfuncs["airdrop_mega"] = ::tryusemegaairdrop;
	level.littlebirds = 0;
	level.littlebird = [];
	level.cratetypes = [];
	addcratetype("airdrop", "ammo", getdvarint("scr_airdrop_ammo", 17), ::ammocratethink);
	addcratetype("airdrop", "uav", getdvarint("scr_airdrop_uav", 17), ::killstreakcratethink);
	addcratetype("airdrop", "counter_uav", getdvarint("scr_airdrop_counter_uav", 15), ::killstreakcratethink);
	addcratetype("airdrop", "sentry", getdvarint("scr_airdrop_sentry", 12), ::killstreakcratethink);
	addcratetype("airdrop", "predator_missile", getdvarint("scr_airdrop_predator_missile", 12), ::killstreakcratethink);
	addcratetype("airdrop", "precision_airstrike", getdvarint("scr_airdrop_precision_airstrike", 11), ::killstreakcratethink);
	addcratetype("airdrop", "harrier_airstrike", getdvarint("scr_airdrop_harrier_airstrike", 7), ::killstreakcratethink);
	addcratetype("airdrop", "helicopter", getdvarint("scr_airdrop_helicopter", 7), ::killstreakcratethink);
	addcratetype("airdrop", "helicopter_flares", getdvarint("scr_airdrop_helicopter_flares", 5), ::killstreakcratethink);
	addcratetype("airdrop", "stealth_airstrike", getdvarint("scr_airdrop_stealth_airstrike", 5), ::killstreakcratethink);
	addcratetype("airdrop", "helicopter_minigun", getdvarint("scr_airdrop_helicopter_minigun", 3), ::killstreakcratethink);
	addcratetype("airdrop", "ac130", getdvarint("scr_airdrop_ac130", 3), ::killstreakcratethink);
	addcratetype("airdrop", "emp", getdvarint("scr_airdrop_emp", 1), ::killstreakcratethink);
	addcratetype("airdrop", "nuke", getdvarint("scr_airdrop_nuke", 0), ::killstreakcratethink);
	addcratetype("airdrop_mega", "ammo", getdvarint("scr_airdrop_mega_ammo", 12), ::ammocratethink);
	addcratetype("airdrop_mega", "uav", getdvarint("scr_airdrop_mega_uav", 12), ::killstreakcratethink);
	addcratetype("airdrop_mega", "counter_uav", getdvarint("scr_airdrop_mega_counter_uav", 16), ::killstreakcratethink);
	addcratetype("airdrop_mega", "sentry", getdvarint("scr_airdrop_mega_sentry", 16), ::killstreakcratethink);
	addcratetype("airdrop_mega", "predator_missile", getdvarint("scr_airdrop_mega_predator_missile", 14), ::killstreakcratethink);
	addcratetype("airdrop_mega", "precision_airstrike", getdvarint("scr_airdrop_mega_precision_airstrike", 10), ::killstreakcratethink);
	addcratetype("airdrop_mega", "harrier_airstrike", getdvarint("scr_airdrop_mega_harrier_airstrike", 5), ::killstreakcratethink);
	addcratetype("airdrop_mega", "helicopter", getdvarint("scr_airdrop_mega_helicopter", 5), ::killstreakcratethink);
	addcratetype("airdrop_mega", "helicopter_flares", getdvarint("scr_airdrop_mega_helicopter_flares", 3), ::killstreakcratethink);
	addcratetype("airdrop_mega", "stealth_airstrike", getdvarint("scr_airdrop_mega_stealth_airstrike", 3), ::killstreakcratethink);
	addcratetype("airdrop_mega", "helicopter_minigun", getdvarint("scr_airdrop_mega_helicopter_minigun", 2), ::killstreakcratethink);
	addcratetype("airdrop_mega", "ac130", getdvarint("scr_airdrop_mega_ac130", 2), ::killstreakcratethink);
	addcratetype("airdrop_mega", "emp", getdvarint("scr_airdrop_mega_emp", 0), ::killstreakcratethink);
	addcratetype("airdrop_mega", "nuke", getdvarint("scr_airdrop_mega_nuke", 0), ::killstreakcratethink);
	addcratetype("airdrop_sentry_minigun", "sentry", 0, ::killstreakcratethink);
	addcratetype("nuke_drop", "nuke", 100, ::nukecratethink);
	foreach(droptype, cratetypes in level.cratetypes)
	{
		level.cratemaxval[droptype] = 0;
		foreach(cratetype, crateweight in level.cratetypes[droptype])
		{
			if(!crateweight)
			{
				continue;
			}

			level.cratemaxval[droptype] = level.cratemaxval[droptype] + crateweight;
			level.cratetypes[droptype][cratetype] = level.cratemaxval[droptype];
		}
	}

	tdmspawns = getentarray("mp_tdm_spawn", "classname");
	lowspawn = undefined;
	foreach(lspawn in tdmspawns)
	{
		if(!isdefined(lowspawn) || lspawn.origin[2] < lowspawn.origin[2])
		{
			lowspawn = lspawn;
		}
	}

	level.lowspawn = lowspawn;
}

addcratetype(droptype, cratetype, crateweight, cratefunc)
{
	level.cratetypes[droptype][cratetype] = crateweight;
	level.cratefuncs[droptype][cratetype] = cratefunc;
}

getrandomcratetype(droptype)
{
	value = randomint(level.cratemaxval[droptype]);
	selectedcratetype = undefined;
	foreach(cratetype, crateweight in level.cratetypes[droptype])
	{
		if(!crateweight)
		{
			continue;
		}

		selectedcratetype = cratetype;
		if(crateweight > value)
		{
			break;
		}
	}

	return selectedcratetype;
}

getcratetypefordroptype(droptype)
{
	switch(droptype)
	{
		case "airdrop_sentry_minigun":
			return "sentry";

		case "airdrop_predator_missile":
			return "predator_missile";

		case "airdrop":
			return getrandomcratetype("airdrop");

		case "airdrop_mega":
			return getrandomcratetype("airdrop_mega");

		case "nuke_drop":
			return "nuke";

		default:
			return getrandomcratetype("airdrop");
	}
}

drawline(start, end, timeslice)
{
	drawtime = int(timeslice * 20);
	for(time = 0;time < drawtime;time++)
	{
		wait 0.05;
	}
}

tryuseairdroppredatormissile(lifeid, kid)
{
	return tryuseairdrop(lifeid, kid, "airdrop_predator_missile");
}

tryuseairdropsentryminigun(lifeid, kid)
{
	return tryuseairdrop(lifeid, kid, "airdrop_sentry_minigun");
}

tryusemegaairdrop(lifeid, kid)
{
	return tryuseairdrop(lifeid, kid, "airdrop_mega");
}

tryuseairdrop(lifeid, kid, droptype)
{
	result = undefined;
	if(!isdefined(droptype))
	{
		droptype = "airdrop";
	}

	if(!isdefined(self.pers["kIDs_valid"][kid]))
	{
		return 1;
	}

	if(level.littlebirds >= 3 && droptype != "airdrop_mega")
	{
		self iprintlnbold(&"MP_AIR_SPACE_TOO_CROWDED");
		return 0;
	}

	if(isdefined(level.civilianjetflyby))
	{
		self iprintlnbold(&"MP_CIVILIAN_AIR_TRAFFIC");
		return 0;
	}

	if(maps\mp\_utility::isusingremote())
	{
		return 0;
	}

	if(droptype != "airdrop_mega")
	{
		level.littlebirds++;
		thread watchdisconnect();
	}

	result = beginairdropviamarker(lifeid, kid, droptype);
	if((!isdefined(result) || !result) && isdefined(self.pers["kIDs_valid"][kid]))
	{
		self notify("markerDetermined");
		if(droptype != "airdrop_mega")
		{
			decrementlittlebirdcount();
		}

		return 0;
	}

	if(droptype == "airdrop_mega")
	{
		thread maps\mp\_utility::teamplayercardsplash("used_airdrop_mega", self);
	}

	self notify("markerDetermined");
	return 1;
}

watchdisconnect()
{
	self endon("markerDetermined");
	self waittill("disconnect");
	decrementlittlebirdcount();
}

beginairdropviamarker(lifeid, kid, droptype)
{
	self endon("death");
	self endon("grenade_fire");
	self.airdropmarker = undefined;
	thread watchairdropmarkerusage(droptype, kid);
	while(maps\mp\_utility::ischangingweapon())
	{
		wait 0.05;
	}

	currentweapon = self getcurrentweapon();
	if(isairdropmarker(currentweapon))
	{
		airdropmarkerweapon = currentweapon;
	}
	else
	{
		airdropmarkerweapon = undefined;
	}

	while(isairdropmarker(currentweapon))
	{
		self waittill("weapon_change", currentweapon);
		if(isairdropmarker(currentweapon))
		{
			airdropmarkerweapon = currentweapon;
		}
	}

	self notify("stopWatchingAirDropMarker");
	if(!isdefined(airdropmarkerweapon))
	{
		return 0;
	}

	return !self getammocount(airdropmarkerweapon) && self hasweapon(airdropmarkerweapon);
}

watchairdropmarkerusage(droptype, kid)
{
	self notify("watchAirDropMarkerUsage");
	self endon("disconnect");
	self endon("watchAirDropMarkerUsage");
	self endon("stopWatchingAirDropMarker");
	thread watchairdropmarker(droptype, kid);
	for(;;)
	{
		self waittill("grenade_pullback", weaponname);
		if(!isairdropmarker(weaponname))
		{
			continue;
		}

		common_scripts\utility::_disableusability();
		beginairdropmarkertracking();
	}
}

watchairdropmarker(droptype, kid)
{
	self notify("watchAirDropMarker");
	self endon("watchAirDropMarker");
	self endon("spawned_player");
	self endon("disconnect");
	for(;;)
	{
		self waittill("grenade_fire", airdropweapon, weapname);
		if(!isairdropmarker(weapname))
		{
			continue;
		}

		if(!isdefined(self.pers["kIDs_valid"][kid]))
		{
			airdropweapon delete();
			continue;
		}

		self.pers["kIDs_valid"][kid] = undefined;
		airdropweapon thread airdropdetonateonstuck();
		airdropweapon.owner = self;
		airdropweapon.weaponname = weapname;
		self.airdropmarker = airdropweapon;
		airdropweapon thread airdropmarkeractivate(droptype);
	}
}

beginairdropmarkertracking()
{
	self notify("beginAirDropMarkerTracking");
	self endon("beginAirDropMarkerTracking");
	self endon("death");
	self endon("disconnect");
	common_scripts\utility::waittill_any("grenade_fire", "weapon_change");
	common_scripts\utility::_enableusability();
}

airdropmarkeractivate(droptype)
{
	self notify("airDropMarkerActivate");
	self endon("airDropMarkerActivate");
	self waittill("explode", position);
	owner = self.owner;
	if(!isdefined(owner))
	{
		return;
	}

	if(owner maps\mp\_utility::isemped())
	{
		return;
	}

	if(droptype != "airdrop_mega")
	{
		owner maps\mp\_matchdata::logkillstreakevent(droptype, position);
	}

	wait 0.05;
	if(droptype != "airdrop_mega")
	{
		level doflyby(owner, position, randomfloat(360), droptype);
		return;
	}

	level doc130flyby(owner, position, randomfloat(360), droptype);
}

initairdropcrate()
{
	self.inuse = 0;
	self hide();
	if(isdefined(self.target))
	{
		self.collision = getent(self.target, "targetname");
		self.collision notsolid();
		return;
	}

	self.collision = undefined;
}

deleteonownerdeath(owner)
{
	wait 0.25;
	self linkto(owner, "tag_origin", (0,0,0), (0,0,0));
	owner waittill("death");
	self delete();
}

cratemodelteamupdater(showforteam)
{
	self endon("death");
	self hide();
	foreach(player in level.players)
	{
		if(player.team == showforteam)
		{
			self showtoplayer(player);
		}
	}

	for(;;)
	{
		level waittill("joined_team");
		self hide();
		foreach(player in level.players)
		{
			if(player.team == showforteam)
			{
				self showtoplayer(player);
			}
		}
	}
}

createairdropcrate(owner, droptype, cratetype, startpos)
{
	dropcrate = spawn("script_model", startpos);
	dropcrate.curprogress = 0;
	dropcrate.usetime = 0;
	dropcrate.userate = 0;
	dropcrate.team = self.team;
	if(isdefined(owner))
	{
		dropcrate.owner = owner;
	}
	else
	{
		dropcrate.owner = undefined;
	}

	dropcrate.cratetype = cratetype;
	dropcrate.droptype = droptype;
	dropcrate.targetname = "care_package";
	dropcrate setmodel(maps\mp\gametypes\_teams::getteamcratemodel(dropcrate.team));
	dropcrate.friendlymodel = spawn("script_model", startpos);
	dropcrate.friendlymodel setmodel("com_plasticcase_friendly");
	dropcrate.enemymodel = spawn("script_model", startpos);
	dropcrate.enemymodel setmodel("com_plasticcase_enemy");
	dropcrate.friendlymodel thread deleteonownerdeath(dropcrate);
	dropcrate.friendlymodel thread cratemodelteamupdater(dropcrate.team);
	dropcrate.enemymodel thread deleteonownerdeath(dropcrate);
	dropcrate.enemymodel thread cratemodelteamupdater(level.otherteam[dropcrate.team]);
	dropcrate.inuse = 0;
	dropcrate clonebrushmodeltoscriptmodel(level.airdropcratecollision);
	return dropcrate;
}

cratesetupforuse(param_CF5, mode, icon)
{
	if(mode != "nukeDrop")
	{
		self setcursorhint("HINT_NOICON");
		self sethintstring(param_CF5);
		self makeusable();
	}

	self.mode = mode;
	if(level.teambased)
	{
		curobjid = maps\mp\gametypes\_gameobjects::getnextobjid();
		objective_add(curobjid, "invisible", (0,0,0));
		objective_position(curobjid, self.origin);
		objective_state(curobjid, "active");
		objective_team(curobjid, self.team);
		objective_icon(curobjid, "compass_objpoint_ammo_friendly");
		self.objidfriendly = curobjid;
		curobjid = maps\mp\gametypes\_gameobjects::getnextobjid();
		objective_add(curobjid, "invisible", (0,0,0));
		objective_position(curobjid, self.origin);
		objective_state(curobjid, "active");
		objective_team(curobjid, level.otherteam[self.team]);
		objective_icon(curobjid, "compass_objpoint_ammo_enemy");
		self.objidenemy = curobjid;
	}

	if(!level.teambased)
	{
		curobjid = maps\mp\gametypes\_gameobjects::getnextobjid();
		objective_add(curobjid, "invisible", (0,0,0));
		objective_position(curobjid, self.origin);
		objective_state(curobjid, "active");
		objective_icon(curobjid, "compass_objpoint_ammo_friendly");
		self.objidfriendly = curobjid;
		if(isdefined(self.owner))
		{
			maps\mp\_entityheadicons::setheadicon(self.owner, icon, (0,0,24), 14, 14);
			return;
		}

		return;
	}

	if(mode == "single" && isdefined(self.owner))
	{
		setselfandenemyusable(self.owner);
		maps\mp\_entityheadicons::setheadicon(self.owner, icon, (0,0,24), 14, 14);
		return;
	}

	if(mode == "team")
	{
		setusableoncebyteam(self.team);
		thread checkchange(self.team);
		maps\mp\_entityheadicons::setheadicon(self.team, icon, (0,0,24), 14, 14);
		return;
	}

	if(mode == "nukeDrop")
	{
		maps\mp\_entityheadicons::setheadicon(self.team, icon, (0,0,24), 14, 14);
		maps\mp\_entityheadicons::setheadicon(maps\mp\_utility::getotherteam(self.team), icon, (0,0,24), 14, 14);
		level.nukecrate = self;
		level.nukecrate notify("nukeLanded");
		return;
	}

	setusablebyteam();
	maps\mp\_entityheadicons::setheadicon(self.team, icon, (0,0,24), 14, 14);
}

checkchange(team)
{
	self endon("death");
	for(;;)
	{
		level waittill("joined_team");
		setunusable(team);
		wait 0.25;
	}
}

setselfandenemyusable(owner)
{
	foreach(player in level.players)
	{
		if(player != owner && player.team == self.team)
		{
			self disableplayeruse(player);
			continue;
		}

		self enableplayeruse(player);
	}
}

setunusable(team)
{
	foreach(player in level.players)
	{
		if(team != player.team)
		{
			self disableplayeruse(player);
		}
	}
}

setusablebyteam(team)
{
	foreach(player in level.players)
	{
		if(!isdefined(team))
		{
			self enableplayeruse(player);
			continue;
		}

		if(team == player.team)
		{
			self enableplayeruse(player);
			continue;
		}

		self disableplayeruse(player);
	}
}

setusableoncebyteam(team)
{
	foreach(player in level.players)
	{
		if(isdefined(self.usedby[player.guid]))
		{
			self disableplayeruse(player);
			continue;
		}

		if(!isdefined(team))
		{
			self enableplayeruse(player);
			continue;
		}

		if(team == player.team)
		{
			self enableplayeruse(player);
			continue;
		}

		self disableplayeruse(player);
	}
}

dropthecrate(droppoint, droptype, lbheight, dropimmediately, crateoverride, startpos)
{
	dropcrate = [];
	self.owner endon("disconnect");
	if(!isdefined(crateoverride))
	{
		cratetype = getcratetypefordroptype(droptype);
	}
	else
	{
		cratetype = crateoverride;
	}

	dropcrate = createairdropcrate(self.owner, droptype, cratetype, startpos);
	if(droptype == "airdrop_mega" || droptype == "nuke_drop")
	{
		dropcrate linkto(self, "tag_ground", (64,32,-128), (0,0,0));
	}
	else
	{
		dropcrate linkto(self, "tag_ground", (32,0,5), (0,0,0));
	}

	dropcrate.angles = (0,0,0);
	dropcrate show();
	dropspeed = self.veh_speed;
	self waittill("drop_crate");
	dropcrate unlink();
	dropcrate physicslaunchserver((0,0,0), (randomint(5),randomint(5),randomint(5)));
	dropcrate thread physicswaiter(droptype, cratetype);
}

physicswaiter(droptype, cratetype)
{
	self waittill("physics_finished");
	self thread [[ level.cratefuncs[droptype][cratetype] ]](droptype);
	level thread droptimeout(self, self.owner);
	if(abs(self.origin[2] - level.lowspawn.origin[2]) > 3000)
	{
		if(isdefined(self.objidfriendly))
		{
			maps\mp\_utility::_objective_delete(self.objidfriendly);
		}

		if(isdefined(self.objidenemy))
		{
			maps\mp\_utility::_objective_delete(self.objidenemy);
		}

		self delete();
		return;
	}
}

droptimeout(dropcrate, owner)
{
	level endon("game_ended");
	dropcrate endon("death");
	if(dropcrate.droptype == "nuke_drop")
	{
		return;
	}

	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(90);
	while(dropcrate.curprogress != 0)
	{
		wait 1;
	}

	if(isdefined(dropcrate.objidfriendly))
	{
		maps\mp\_utility::_objective_delete(dropcrate.objidfriendly);
	}

	if(isdefined(dropcrate.objidenemy))
	{
		maps\mp\_utility::_objective_delete(dropcrate.objidenemy);
	}

	dropcrate delete();
}

getpathstart(param_C40, yaw)
{
	pathrandomness = 100;
	lbhalfdistance = 15000;
	direction = (0,yaw,0);
	startpoint = param_C40 + common_scripts\utility::vector_multiply(anglestoforward(direction), -1 * lbhalfdistance);
	startpoint = startpoint + (randomfloat(2) - 1 * pathrandomness,randomfloat(2) - 1 * pathrandomness,0);
	return startpoint;
}

getpathend(param_C40, yaw)
{
	pathrandomness = 150;
	lbhalfdistance = 15000;
	direction = (0,yaw,0);
	endpoint = param_C40 + common_scripts\utility::vector_multiply(anglestoforward(direction + (0,90,0)), lbhalfdistance);
	endpoint = endpoint + (randomfloat(2) - 1 * pathrandomness,randomfloat(2) - 1 * pathrandomness,0);
	return endpoint;
}

getflyheightoffset(dropsite)
{
	lbflyheight = 850;
	heightent = getent("airstrikeheight", "targetname");
	if(!isdefined(heightent))
	{
		if(isdefined(level.airstrikeheightscale))
		{
			if(level.airstrikeheightscale > 2)
			{
				lbflyheight = 1500;
				return lbflyheight * level.airstrikeheightscale;
			}

			return lbflyheight * level.airstrikeheightscale + 256 + dropsite[2];
		}

		return lbflyheight + dropsite[2];
	}

	return heightent.origin[2];
}

doflyby(owner, dropsite, dropyaw, droptype, param_D06)
{
	flyheight = getflyheightoffset(dropsite);
	if(!isdefined(param_D06))
	{
		param_D06 = 0;
	}

	flyheight = flyheight + param_D06;
	if(!isdefined(owner))
	{
		return;
	}

	pathgoal = dropsite * (1,1,0) + (0,0,flyheight);
	pathstart = getpathstart(pathgoal, dropyaw);
	pathend = getpathend(pathgoal, dropyaw);
	pathgoal = pathgoal + common_scripts\utility::vector_multiply(anglestoforward((0,dropyaw,0)), -50);
	chopper = helisetup(owner, pathstart, pathgoal);
	chopper endon("death");
	chopper.droptype = droptype;
	chopper setvehgoalpos(pathgoal, 1);
	chopper thread dropthecrate(dropsite, droptype, flyheight, 0, undefined, pathstart);
	wait 2;
	chopper vehicle_setspeed(75, 40);
	chopper setyawspeed(180, 180, 180, 0.3);
	chopper waittill("goal");
	wait 0.1;
	chopper notify("drop_crate");
	chopper setvehgoalpos(pathend, 1);
	chopper vehicle_setspeed(300, 75);
	chopper.leaving = 1;
	chopper waittill("goal");
	chopper notify("leaving");
	chopper trimactivebirdlist();
	decrementlittlebirdcount();
	chopper notify("delete");
	chopper delete();
}

domegaflyby(owner, dropsite, dropyaw, droptype)
{
	level thread doflyby(owner, dropsite, dropyaw, droptype, 0);
	wait randomintrange(1, 2);
	level thread doflyby(owner, dropsite + (128,128,0), dropyaw, droptype, 128);
	wait randomintrange(1, 2);
	level thread doflyby(owner, dropsite + (172,256,0), dropyaw, droptype, 256);
	wait randomintrange(1, 2);
	level thread doflyby(owner, dropsite + (64,0,0), dropyaw, droptype, 0);
}

doc130flyby(owner, dropsite, dropyaw, droptype)
{
	planehalfdistance = 24000;
	planeflyspeed = 2000;
	yaw = vectortoyaw(dropsite - owner.origin);
	direction = (0,yaw,0);
	flyheight = getflyheightoffset(dropsite);
	pathstart = dropsite + common_scripts\utility::vector_multiply(anglestoforward(direction), -1 * planehalfdistance);
	pathstart = pathstart * (1,1,0) + (0,0,flyheight);
	pathend = dropsite + common_scripts\utility::vector_multiply(anglestoforward(direction), planehalfdistance);
	pathend = pathend * (1,1,0) + (0,0,flyheight);
	d = length(pathstart - pathend);
	flytime = d / planeflyspeed;
	c130 = c130setup(owner, pathstart, pathend);
	c130.veh_speed = planeflyspeed;
	c130.droptype = droptype;
	c130 playloopsound("veh_ac130_dist_loop");
	c130.angles = direction;
	forward = anglestoforward(direction);
	c130 moveto(pathend, flytime, 0, 0);
	mindist = distance2d(c130.origin, dropsite);
	boomplayed = 0;
	for(;;)
	{
		dist = distance2d(c130.origin, dropsite);
		if(dist < mindist)
		{
			mindist = dist;
		}
		else if(dist > mindist)
		{
			break;
		}

		if(dist < 256)
		{
			break;
		}
		else if(dist < 768)
		{
			earthquake(0.15, 1.5, dropsite, 1500);
			if(!boomplayed)
			{
				c130 playsound("veh_ac130_sonic_boom");
				boomplayed = 1;
			}
		}

		wait 0.05;
	}

	wait 0.05;
	c130 thread dropthecrate(dropsite, droptype, flyheight, 0, undefined, pathstart);
	wait 0.05;
	c130 notify("drop_crate");
	wait 0.05;
	c130 thread dropthecrate(dropsite, droptype, flyheight, 0, undefined, pathstart);
	wait 0.05;
	c130 notify("drop_crate");
	wait 0.05;
	c130 thread dropthecrate(dropsite, droptype, flyheight, 0, undefined, pathstart);
	wait 0.05;
	c130 notify("drop_crate");
	wait 0.05;
	c130 thread dropthecrate(dropsite, droptype, flyheight, 0, undefined, pathstart);
	wait 0.05;
	c130 notify("drop_crate");
	wait 4;
	c130 delete();
}

dropnuke(dropsite, owner, droptype)
{
	planehalfdistance = 24000;
	planeflyspeed = 2000;
	yaw = randomint(360);
	direction = (0,yaw,0);
	flyheight = getflyheightoffset(dropsite);
	pathstart = dropsite + common_scripts\utility::vector_multiply(anglestoforward(direction), -1 * planehalfdistance);
	pathstart = pathstart * (1,1,0) + (0,0,flyheight);
	pathend = dropsite + common_scripts\utility::vector_multiply(anglestoforward(direction), planehalfdistance);
	pathend = pathend * (1,1,0) + (0,0,flyheight);
	d = length(pathstart - pathend);
	flytime = d / planeflyspeed;
	c130 = c130setup(owner, pathstart, pathend);
	c130.veh_speed = planeflyspeed;
	c130.droptype = droptype;
	c130 playloopsound("veh_ac130_dist_loop");
	c130.angles = direction;
	forward = anglestoforward(direction);
	c130 moveto(pathend, flytime, 0, 0);
	boomplayed = 0;
	mindist = distance2d(c130.origin, dropsite);
	for(;;)
	{
		dist = distance2d(c130.origin, dropsite);
		if(dist < mindist)
		{
			mindist = dist;
		}
		else if(dist > mindist)
		{
			break;
		}

		if(dist < 256)
		{
			break;
		}
		else if(dist < 768)
		{
			earthquake(0.15, 1.5, dropsite, 1500);
			if(!boomplayed)
			{
				c130 playsound("veh_ac130_sonic_boom");
				boomplayed = 1;
			}
		}

		wait 0.05;
	}

	c130 thread dropthecrate(dropsite, droptype, flyheight, 0, "nuke", pathstart);
	wait 0.05;
	c130 notify("drop_crate");
	wait 4;
	c130 delete();
}

stoploopafter(delay)
{
	self endon("death");
	wait delay;
	self stoploopsound();
}

playlooponent(alias)
{
	soundorg = spawn("script_origin", (0,0,0));
	soundorg hide();
	soundorg endon("death");
	thread common_scripts\utility::delete_on_death(soundorg);
	soundorg.origin = self.origin;
	soundorg.angles = self.angles;
	soundorg linkto(self);
	soundorg playloopsound(alias);
	self waittill("stop sound" + alias);
	soundorg stoploopsound(alias);
	soundorg delete();
}

c130setup(owner, pathstart, pathgoal)
{
	forward = vectortoangles(pathgoal - pathstart);
	c130 = spawnplane(owner, "script_model", pathstart, "compass_objpoint_c130_friendly", "compass_objpoint_c130_enemy");
	c130 setmodel("vehicle_ac130_low_mp");
	if(!isdefined(c130))
	{
		return;
	}

	c130.owner = owner;
	c130.team = owner.team;
	level.c130 = c130;
	return c130;
}

helisetup(owner, pathstart, pathgoal)
{
	forward = vectortoangles(pathgoal - pathstart);
	chopper = spawnhelicopter(owner, pathstart, forward, "littlebird_mp", "vehicle_little_bird_armed");
	if(!isdefined(chopper))
	{
		return;
	}

	chopper.health = 500;
	chopper setcandamage(1);
	chopper.owner = owner;
	chopper.team = owner.team;
	chopper thread heli_existence();
	chopper thread helidestroyed();
	chopper setmaxpitchroll(45, 85);
	chopper vehicle_setspeed(250, 175);
	level.littlebird[level.littlebird.size] = chopper;
	chopper.damagecallback = ::callback_vehicledamage;
	return chopper;
}

heli_existence()
{
	common_scripts\utility::waittill_any("crashing", "leaving");
	trimactivebirdlist();
	self notify("helicopter_gone");
}

callback_vehicledamage(inflictor, attacker, damage, dflags, meansofdeath, weapon, point, dir, hitloc, timeoffset, modelindex, partname)
{
	if((attacker == self || isdefined(attacker.pers) && attacker.pers["team"] == self.team) && attacker != self.owner || meansofdeath == "MOD_MELEE")
	{
		return;
	}

	attacker maps\mp\gametypes\_damagefeedback::updatedamagefeedback("");
	if(self.health <= damage)
	{
		attacker notify("destroyed_killstreak");
	}

	self vehicle_finishdamage(inflictor, attacker, damage, dflags, meansofdeath, weapon, point, dir, hitloc, timeoffset, modelindex, partname);
}

helidestroyed()
{
	self endon("leaving");
	self endon("helicopter_gone");
	self waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	trimactivebirdlist();
	decrementlittlebirdcount();
	self vehicle_setspeed(25, 5);
	thread lbspin(randomintrange(180, 220));
	wait randomfloatrange(0.5, 1.5);
	self notify("drop_crate");
	lbexplode();
}

lbexplode()
{
	forward = self.origin + (0,0,1) - self.origin;
	playfx(level.chopper_fx["explode"]["death"]["cobra"], self.origin, forward);
	self playsound("cobra_helicopter_crash");
	self notify("explode");
	self delete();
}

lbspin(speed)
{
	self endon("explode");
	playfxontag(level.chopper_fx["explode"]["medium"], self, "tail_rotor_jnt");
	playfxontag(level.chopper_fx["fire"]["trail"]["medium"], self, "tail_rotor_jnt");
	self setyawspeed(speed, speed, speed);
	while(isdefined(self))
	{
		self settargetyaw(self.angles[1] + speed * 0.9);
		wait 1;
	}
}

trimactivebirdlist()
{
	for(i = 0;i < level.littlebird.size;i++)
	{
		if(level.littlebird.size == 1)
		{
			level.littlebird = [];
			continue;
		}

		if(level.littlebird[i] == self)
		{
			level.littlebird[i] = level.littlebird[level.littlebird.size - 1];
			level.littlebird[level.littlebird.size - 1] = undefined;
		}
	}
}

nukecapturethink()
{
	while(isdefined(self))
	{
		self waittill("trigger", player);
		if(!player isonground())
		{
			continue;
		}

		if(!useholdthink(player))
		{
			continue;
		}

		self notify("captured", player);
	}
}

crateothercapturethink()
{
	while(isdefined(self))
	{
		self waittill("trigger", player);
		if(isdefined(self.owner) && player == self.owner)
		{
			continue;
		}

		useent = createuseent();
		result = useent useholdthink(player);
		if(isdefined(useent))
		{
			useent delete();
		}

		if(!result)
		{
			continue;
		}

		self notify("captured", player);
	}
}

crateownercapturethink()
{
	while(isdefined(self))
	{
		self waittill("trigger", player);
		if(isdefined(self.owner) && player != self.owner)
		{
			continue;
		}

		if(!useholdthink(player, 500))
		{
			continue;
		}

		self notify("captured", player);
	}
}

killstreakcratethink(droptype)
{
	self endon("death");
	if(isdefined(game["strings"][self.cratetype + "_hint"]))
	{
		cratehint = game["strings"][self.cratetype + "_hint"];
	}
	else
	{
		cratehint = &"PLATFORM_GET_KILLSTREAK";
	}

	cratesetupforuse(cratehint, "all", maps\mp\killstreaks\_killstreaks::getkillstreakcrateicon(self.cratetype));
	thread crateothercapturethink();
	thread crateownercapturethink();
	for(;;)
	{
		self waittill("captured", player);
		if(isdefined(self.owner) && player != self.owner)
		{
			if(!level.teambased || player.team != self.team)
			{
				if(droptype == "airdrop")
				{
					player thread maps\mp\gametypes\_missions::genericchallenge("hijacker_airdrop");
					player thread hijacknotify(self, "airdrop");
				}
				else
				{
					player thread maps\mp\gametypes\_missions::genericchallenge("hijacker_airdrop_mega");
					player thread hijacknotify(self, "emergency_airdrop");
				}
			}
			else
			{
				self.owner thread maps\mp\gametypes\_rank::giverankxp("killstreak_giveaway", maps\mp\killstreaks\_killstreaks::getstreakcost(self.cratetype) * 50);
				self.owner thread maps\mp\gametypes\_hud_message::splashnotifydelayed("sharepackage", maps\mp\killstreaks\_killstreaks::getstreakcost(self.cratetype) * 50);
			}
		}

		player playlocalsound("ammo_crate_use");
		player thread maps\mp\killstreaks\_killstreaks::givekillstreak(self.cratetype, 0, 0, self.owner);
		player maps\mp\gametypes\_hud_message::killstreaksplashnotify(self.cratetype, undefined, "pickup");
		deletecrate();
	}
}

nukecratethink(droptype)
{
	self endon("death");
	cratesetupforuse(&"PLATFORM_CALL_NUKE", "nukeDrop", maps\mp\killstreaks\_killstreaks::getkillstreakcrateicon(self.cratetype));
	thread nukecapturethink();
	for(;;)
	{
		self waittill("captured", player);
		player thread [[ level.killstreakfuncs[self.cratetype] ]](level.gtnw);
		level notify("nukeCaptured", player);
		if(isdefined(level.gtnw) && level.gtnw)
		{
			player.capturednuke = 1;
		}

		player playlocalsound("ammo_crate_use");
		deletecrate();
	}
}

sentrycratethink(droptype)
{
	self endon("death");
	cratesetupforuse(game["strings"]["sentry_hint"], "all", maps\mp\killstreaks\_killstreaks::getkillstreakcrateicon(self.cratetype));
	thread crateothercapturethink();
	thread crateownercapturethink();
	for(;;)
	{
		self waittill("captured", player);
		if(isdefined(self.owner) && player != self.owner)
		{
			if(!level.teambased || player.team != self.team)
			{
				if(issubstr(droptype, "airdrop_sentry"))
				{
					player thread hijacknotify(self, "sentry");
				}
				else
				{
					player thread hijacknotify(self, "emergency_airdrop");
				}
			}
			else
			{
				self.owner thread maps\mp\gametypes\_rank::giverankxp("killstreak_giveaway", maps\mp\killstreaks\_killstreaks::getstreakcost("sentry") * 50);
				self.owner maps\mp\gametypes\_hud_message::playercardsplashnotify("giveaway_sentry", player);
			}
		}

		player playlocalsound("ammo_crate_use");
		player thread sentryusetracker();
		deletecrate();
	}
}

deletecrate()
{
	if(isdefined(self.objidfriendly))
	{
		maps\mp\_utility::_objective_delete(self.objidfriendly);
	}

	if(isdefined(self.objidenemy))
	{
		maps\mp\_utility::_objective_delete(self.objidenemy);
	}

	self delete();
}

sentryusetracker()
{
	if(!maps\mp\killstreaks\_autosentry::givesentry("sentry_minigun"))
	{
		maps\mp\killstreaks\_killstreaks::givekillstreak("sentry");
		return;
	}
}

ammocratethink(droptype)
{
	self endon("death");
	self.usedby = [];
	if(droptype == "airdrop" || !level.teambased)
	{
		cratesetupforuse(&"PLATFORM_RESUPPLY", "all", "waypoint_ammo_friendly");
	}
	else
	{
		cratesetupforuse(&"PLATFORM_RESUPPLY", "all", "waypoint_ammo_friendly");
	}

	thread crateothercapturethink();
	thread crateownercapturethink();
	for(;;)
	{
		self waittill("captured", player);
		if(isdefined(self.owner) && player != self.owner)
		{
			if(!level.teambased || player.team != self.team)
			{
				if(droptype == "airdrop")
				{
					player thread hijacknotify(self, "airdrop");
				}
				else
				{
					player thread hijacknotify(self, "emergency_airdrop");
				}
			}
		}

		player playlocalsound("ammo_crate_use");
		player refillammo();
		deletecrate();
	}
}

hijacknotify(crate, cratetype)
{
	self notify("hijacker", cratetype, crate.owner);
}

refillammo()
{
	weaponlist = self getweaponslistall();
	if(maps\mp\_utility::_hasperk("specialty_tacticalinsertion") && self getammocount("flare_mp") < 1)
	{
		maps\mp\_utility::_setperk("specialty_tacticalinsertion");
	}

	foreach(weaponname in weaponlist)
	{
		if(issubstr(weaponname, "grenade"))
		{
			if(self getammocount(weaponname) >= 1)
			{
				continue;
			}
		}

		self givemaxammo(weaponname);
	}
}

useholdthink(player, usetime)
{
	player playerlinkto(self);
	player playerlinkedoffsetenable();
	player common_scripts\utility::_disableweapon();
	self.curprogress = 0;
	self.inuse = 1;
	self.userate = 0;
	if(isdefined(usetime))
	{
		self.usetime = usetime;
	}
	else
	{
		self.usetime = 3000;
	}

	player thread personalusebar(self);
	result = useholdthinkloop(player);
	if(isalive(player))
	{
		player common_scripts\utility::_enableweapon();
		player unlink();
	}

	if(!isdefined(self))
	{
		return 0;
	}

	self.inuse = 0;
	self.curprogress = 0;
	return result;
}

personalusebar(object)
{
	self endon("disconnect");
	usebar = maps\mp\gametypes\_hud_util::createprimaryprogressbar(-25);
	usebartext = maps\mp\gametypes\_hud_util::createprimaryprogressbartext(-25);
	usebartext settext(&"MP_CAPTURING_CRATE");
	lastrate = -1;
	while(maps\mp\_utility::isreallyalive(self) && isdefined(object) && object.inuse && !level.gameended)
	{
		if(lastrate != object.userate)
		{
			if(object.curprogress > object.usetime)
			{
				object.curprogress = object.usetime;
			}

			usebar maps\mp\gametypes\_hud_util::updatebar(object.curprogress / object.usetime, 1000 / object.usetime * object.userate);
			if(!object.userate)
			{
				usebar maps\mp\gametypes\_hud_util::hideelem();
				usebartext maps\mp\gametypes\_hud_util::hideelem();
			}
			else
			{
				usebar maps\mp\gametypes\_hud_util::showelem();
				usebartext maps\mp\gametypes\_hud_util::showelem();
			}
		}

		lastrate = object.userate;
		wait 0.05;
	}

	usebar maps\mp\gametypes\_hud_util::destroyelem();
	usebartext maps\mp\gametypes\_hud_util::destroyelem();
}

useholdthinkloop(player)
{
	while(!level.gameended && isdefined(self) && maps\mp\_utility::isreallyalive(player) && player usebuttonpressed() && self.curprogress < self.usetime)
	{
		self.curprogress = self.curprogress + 50 * self.userate;
		if(isdefined(self.objectivescaler))
		{
			self.userate = 1 * self.objectivescaler;
		}
		else
		{
			self.userate = 1;
		}

		if(self.curprogress >= self.usetime)
		{
			return maps\mp\_utility::isreallyalive(player);
		}

		wait 0.05;
	}

	return 0;
}

isairdropmarker(weaponname)
{
	switch(weaponname)
	{
		case "airdrop_mega_marker_mp":
		case "airdrop_sentry_marker_mp":
		case "airdrop_marker_mp":
			return 1;

		default:
			return 0;
	}
}

createuseent()
{
	useent = spawn("script_origin", self.origin);
	useent.curprogress = 0;
	useent.usetime = 0;
	useent.userate = 3000;
	useent.inuse = 0;
	useent thread deleteuseent(self);
	return useent;
}

deleteuseent(owner)
{
	self endon("death");
	owner waittill("death");
	self delete();
}

airdropdetonateonstuck()
{
	self endon("death");
	self waittill("missile_stuck");
	self detonate();
}

decrementlittlebirdcount()
{
	level.littlebirds--;
	level.littlebirds = int(max(level.littlebirds, 0));
}