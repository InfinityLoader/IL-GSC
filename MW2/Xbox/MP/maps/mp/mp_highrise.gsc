/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_highrise.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	maps\mp\mp_highrise_precache::main();
	maps\createart\mp_highrise_art::main();
	maps\mp\mp_highrise_fx::main();
	maps\mp\_explosive_barrels::main();
	maps\mp\_load::main();
	maps\mp\_compass::setupminimap("compass_map_mp_highrise");
	setdvar("r_lightGridEnableTweaks", 1);
	setdvar("r_lightGridIntensity", 1.11);
	setdvar("r_lightGridContrast", 0.9);
	visionsetnaked("mp_highrise");
	ambientplay("embient_mp_highrise");
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	level.airstrikeheightscale = 3;
	setdvar("compassmaxrange", "2100");
}

elevator(elevatorid)
{
	elevator = getent(elevatorid, "targetname");
	elevfloors = [];
	elevfloors[0] = getent(elevatorid + "_floor1", "targetname").origin;
	elevfloors[1] = getent(elevatorid + "_floor2", "targetname").origin;
	movespeed = 192;
	waittime = 2;
	floorindex = 0;
	for(;;)
	{
		newpos = elevfloors[floorindex];
		movedist = distance(elevator.origin, newpos);
		if(movedist <= 0)
		{
			floorindex = floorindex + 1 % elevfloors.size;
			continue;
		}

		movetime = movedist / movespeed;
		elevator moveto(newpos, movetime, movetime * 0.25, movetime * 0.25);
		floorindex = floorindex + 1 % elevfloors.size;
		wait movetime + waittime;
	}
}

setuprappel()
{
	trigs = getentarray("rappeltrigger", "targetname");
	foreach(trig in trigs)
	{
		org = getent(trig.target, "targetname");
		trig.rappelpoint = org.origin;
		trig.dir = anglestoforward(org.angles);
		org delete();
		trig thread rappelthink();
	}

	foreach(trig in trigs)
	{
		org = getent(trig.target, "targetname");
		if(isdefined(org))
		{
			org delete();
		}
	}
}

rappelthink()
{
	for(;;)
	{
		self waittill("trigger", player);
		if(!isplayer(player))
		{
			continue;
		}

		if(!player isonground())
		{
			continue;
		}

		if(isdefined(player.rapelling))
		{
			continue;
		}

		player thread rappel(self);
	}
}

rappel(trig)
{
	torappelpoint = trig.rappelpoint - self.origin;
	rappelpoint = self.origin + vectordot(torappelpoint, trig.dir) * trig.dir;
	rappelpoint = (rappelpoint[0],rappelpoint[1],trig.rappelpoint[2]);
	uptime = 0.5;
	overtime = 0.75;
	downspeed = 512;
	uppoint = self.origin;
	uppoint = (uppoint[0],uppoint[1],rappelpoint[2]);
	overpoint = rappelpoint + trig.dir * 20;
	traceposition = playerphysicstrace(overpoint, overpoint + (0,0,-10000), 0, self);
	downpoint = traceposition + (0,0,16);
	org = spawn("script_origin", self.origin);
	org hide();
	self.rapelling = 1;
	common_scripts\utility::_disableweapon();
	self linkto(org);
	self playerlinkedoffsetenable();
	org moveto(uppoint, uptime, 0, 0);
	org waittill("movedone");
	org moveto(overpoint, overtime, 0, 0);
	org waittill("movedone");
	downtime = distance(overpoint, downpoint) / downspeed;
	org moveto(downpoint, downtime, 0, 0);
	org waittill("movedone");
	common_scripts\utility::_enableweapon();
	self unlink();
	org delete();
	self.rapelling = undefined;
}