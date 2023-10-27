/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes_zm\_gameobjects.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 99
 * Decompile Time: 235 ms
 * Timestamp: 10/27/2023 3:02:28 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/gametypes_zm/_hostmigration;
#include maps/mp/gametypes_zm/_hud_util;
#include maps/mp/gametypes_zm/_tweakables;
#include maps/mp/gametypes_zm/_weapons;

//Function Number: 1
main(allowed)
{
	level.vehiclesenabled = getgametypesetting("vehiclesEnabled");
	level.vehiclestimed = getgametypesetting("vehiclesTimed");
	level.objectivepingdelay = getgametypesetting("objectivePingTime");
	level.nonteambasedteam = "allies";
/#
	level.vehiclesenabled = 1;
level.script == "mp_vehicle_test"
#/
	if(level.vehiclesenabled)
	{
		allowed[allowed.size] = "vehicle";
		filter_script_vehicles_from_vehicle_descriptors(allowed);
	}

	entities = getentarray();
	for(entity_index = entities.size - 1;entity_index >= 0;entity_index--)
	{
		entity = entities[entity_index];
		if(!(entity_is_allowed(entity,allowed)))
		{
			entity delete();
		}
	}
}

//Function Number: 2
entity_is_allowed(entity,allowed_game_modes)
{
	if(IsDefined(level.createfx_enabled) && level.createfx_enabled)
	{
		return 1;
	}

	allowed = 1;
	if(IsDefined(entity.script_gameobjectname) && entity.script_gameobjectname != "[all_modes]")
	{
		allowed = 0;
		gameobjectnames = strtok(entity.script_gameobjectname," ");
		for(i = 0;i < allowed_game_modes.size && !allowed;i++)
		{
			for(j = 0;j < gameobjectnames.size && !allowed;j++)
			{
				allowed = gameobjectnames[j] == allowed_game_modes[i];
			}
		}
	}

	return allowed;
}

//Function Number: 3
location_is_allowed(entity,location)
{
	allowed = 1;
	location_list = undefined;
	if(IsDefined(entity.script_noteworthy))
	{
		location_list = entity.script_noteworthy;
	}

	if(IsDefined(entity.script_location))
	{
		location_list = entity.script_location;
	}

	if(IsDefined(location_list))
	{
		if(location_list == "[all_modes]")
		{
			allowed = 1;
		}
		else
		{
			allowed = 0;
			gameobjectlocations = strtok(location_list," ");
			for(j = 0;j < gameobjectlocations.size;j++)
			{
				if(gameobjectlocations[j] == location)
				{
					allowed = 1;
					break;
				}
			}
		}
	}

	return allowed;
}

//Function Number: 4
filter_script_vehicles_from_vehicle_descriptors(allowed_game_modes)
{
	vehicle_descriptors = getentarray("vehicle_descriptor","targetname");
	script_vehicles = getentarray("script_vehicle","classname");
	vehicles_to_remove = [];
	for(descriptor_index = 0;descriptor_index < vehicle_descriptors.size;descriptor_index++)
	{
		descriptor = vehicle_descriptors[descriptor_index];
		closest_distance_sq = 1E+12;
		closest_vehicle = undefined;
		for(vehicle_index = 0;vehicle_index < script_vehicles.size;vehicle_index++)
		{
			vehicle = script_vehicles[vehicle_index];
			dsquared = distancesquared(vehicle getorigin(),descriptor getorigin());
			if(dsquared < closest_distance_sq)
			{
				closest_distance_sq = dsquared;
				closest_vehicle = vehicle;
			}
		}

		if(IsDefined(closest_vehicle))
		{
			if(!(entity_is_allowed(descriptor,allowed_game_modes)))
			{
				vehicles_to_remove[vehicles_to_remove.size] = closest_vehicle;
			}
		}
	}

	for(vehicle_index = 0;vehicle_index < vehicles_to_remove.size;vehicle_index++)
	{
		vehicles_to_remove[vehicle_index] delete();
	}
}

//Function Number: 5
init()
{
	level.numgametypereservedobjectives = 0;
	level.releasedobjectives = [];
	if(!(sessionmodeiszombiesgame()))
	{
		precacheitem("briefcase_bomb_mp");
		precacheitem("briefcase_bomb_defuse_mp");
	}

	level thread onplayerconnect();
}

//Function Number: 6
onplayerconnect()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("connecting",player);
		player thread onplayerspawned();
		player thread ondisconnect();
	}
}

//Function Number: 7
onplayerspawned()
{
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("spawned_player");
		self thread ondeath();
		self.touchtriggers = [];
		self.carryobject = undefined;
		self.claimtrigger = undefined;
		self.canpickupobject = 1;
		self.disabledweapon = 0;
		self.killedinuse = undefined;
	}
}

//Function Number: 8
ondeath()
{
	level endon("game_ended");
	self endon("spawned_player");
	self waittill("death");
	if(IsDefined(self.carryobject))
	{
		self.carryobject thread setdropped();
	}
}

//Function Number: 9
ondisconnect()
{
	level endon("game_ended");
	self waittill("disconnect");
	if(IsDefined(self.carryobject))
	{
		self.carryobject thread setdropped();
	}
}

//Function Number: 10
createcarryobject(ownerteam,trigger,visuals,offset,objectivename)
{
	carryobject = spawnstruct();
	carryobject.type = "carryObject";
	carryobject.curorigin = trigger.origin;
	carryobject.ownerteam = ownerteam;
	carryobject.entnum = trigger getentitynumber();
	if(issubstr(trigger.classname,"use"))
	{
		carryobject.triggertype = "use";
	}
	else
	{
		carryobject.triggertype = "proximity";
	}

	trigger.baseorigin = trigger.origin;
	carryobject.trigger = trigger;
	carryobject.useweapon = undefined;
	if(!(IsDefined(offset)))
	{
		offset = (0,0,0);
	}

	carryobject.offset3d = offset;
	carryobject.newstyle = 0;
	if(IsDefined(objectivename))
	{
		carryobject.newstyle = 1;
	}
	else
	{
		objectivename = &"";
	}

	for(index = 0;index < visuals.size;index++)
	{
		visuals[index].baseorigin = visuals[index].origin;
		visuals[index].baseangles = visuals[index].angles;
	}

	carryobject.visuals = visuals;
	carryobject.compassicons = [];
	carryobject.objid = [];
	if(!(carryobject.newstyle))
	{
		foreach(team in level.teams)
		{
			carryobject.objid[team] = getnextobjid();
		}
	}

	carryobject.objidpingfriendly = 0;
	carryobject.objidpingenemy = 0;
	level.objidstart = level.objidstart + 2;
	carryobject.objectiveid = getnextobjid();
	objective_add(carryobject.objectiveid,"invisible",carryobject.curorigin,objectivename);
	carryobject.carrier = undefined;
	carryobject.isresetting = 0;
	carryobject.interactteam = "none";
	carryobject.allowweapons = 0;
	carryobject.visiblecarriermodel = undefined;
	carryobject.worldicons = [];
	carryobject.carriervisible = 0;
	carryobject.visibleteam = "none";
	carryobject.worldiswaypoint = [];
	carryobject.carryicon = undefined;
	carryobject.ondrop = undefined;
	carryobject.onpickup = undefined;
	carryobject.onreset = undefined;
	if(carryobject.triggertype == "use")
	{
		carryobject thread carryobjectusethink();
	}
	else
	{
		carryobject thread carryobjectproxthink();
	}

	carryobject thread updatecarryobjectorigin();
	carryobject thread updatecarryobjectobjectiveorigin();
	return carryobject;
}

//Function Number: 11
carryobjectusethink()
{
	level endon("game_ended");
	self.trigger endon("destroyed");
	while(1)
	{
		self.trigger waittill("trigger",player);
		if(self.isresetting)
		{
			continue;
		}

		if(!(isalive(player)))
		{
			continue;
		}

		if(IsDefined(player.laststand) && player.laststand)
		{
			continue;
		}

		if(!(self caninteractwith(player)))
		{
			continue;
		}

		if(!(player.canpickupobject))
		{
			continue;
		}

		if(player.throwinggrenade)
		{
			continue;
		}

		if(IsDefined(self.carrier))
		{
			continue;
		}

		if(player isinvehicle())
		{
			continue;
		}

		if(player isweaponviewonlylinked())
		{
			continue;
		}

		if(!(player istouching(self.trigger)))
		{
			continue;
		}

		self setpickedup(player);
	}
}

//Function Number: 12
carryobjectproxthink()
{
	level endon("game_ended");
	self.trigger endon("destroyed");
	while(1)
	{
		self.trigger waittill("trigger",player);
		if(self.isresetting)
		{
			continue;
		}

		if(!(isalive(player)))
		{
			continue;
		}

		if(IsDefined(player.laststand) && player.laststand)
		{
			continue;
		}

		if(!(self caninteractwith(player)))
		{
			continue;
		}

		if(!(player.canpickupobject))
		{
			continue;
		}

		if(player.throwinggrenade)
		{
			continue;
		}

		if(IsDefined(self.carrier))
		{
			continue;
		}

		if(player isinvehicle())
		{
			continue;
		}

		if(player isweaponviewonlylinked())
		{
			continue;
		}

		if(!(player istouching(self.trigger)))
		{
			continue;
		}

		self setpickedup(player);
	}
}

//Function Number: 13
pickupobjectdelay(origin)
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self.canpickupobject = 0;
	for(;;)
	{
		if(distancesquared(self.origin,origin) > 4096)
		{
			break;
		}

		wait(0.2);
	}

	self.canpickupobject = 1;
}

//Function Number: 14
setpickedup(player)
{
	if(IsDefined(player.carryobject))
	{
		if(IsDefined(player.carryobject.swappable) && player.carryobject.swappable)
		{
			player.carryobject thread setdropped();
		}
		else
		{
			if(IsDefined(self.onpickupfailed))
			{
				self [[ self.onpickupfailed ]](player);
			}

			return;
		}
	}

	player giveobject(self);
	self setcarrier(player);
	for(index = 0;index < self.visuals.size;index++)
	{
		self.visuals[index] thread hideobject();
	}

	self.trigger.origin = 10000 + VectorScale((0,0,1));
	self notify("pickup_object",self.trigger.origin);
	if(IsDefined(self.onpickup))
	{
		self [[ self.onpickup ]](player);
	}

	self updatecompassicons();
	self updateworldicons();
	self updateobjective();
}

//Function Number: 15
hideobject()
{
	radius = 32;
	origin = self.origin;
	grenades = getentarray("grenade","classname");
	radiussq = radius * radius;
	linkedgrenades = [];
	linkedgrenadesindex = 0;
	self hide();
	for(i = 0;i < grenades.size;i++)
	{
		if(distancesquared(origin,grenades[i].origin) < radiussq)
		{
			if(grenades[i] islinkedto(self))
			{
				linkedgrenades[linkedgrenadesindex] = grenades[i];
				linkedgrenades[linkedgrenadesindex] unlink();
				linkedgrenadesindex++;
			}
		}
	}

	self.origin = 10000 + VectorScale((0,0,1));
	waittillframeend;
	for(i = 0;i < linkedgrenadesindex;i++)
	{
		linkedgrenades[i] launch(VectorScale((1,1,1)));
	}
}

//Function Number: 16
updatecarryobjectorigin()
{
	level endon("game_ended");
	self.trigger endon("destroyed");
	if(self.newstyle)
	{
		return;
	}

	objpingdelay = level.objectivepingdelay;
	for(;;)
	{
		if(IsDefined(self.carrier) && level.teambased)
		{
			self.curorigin = 75 + VectorScale((0,0,1));
			if((self.visibleteam == "friendly" || self.visibleteam == "any") && self.objidpingfriendly)
			{
				foreach(team in level.teams)
				{
					if(self isfriendlyteam(team))
					{
						if(self.objpoints[team].isshown)
						{
							self.objpoints[team].alpha = self.objpoints[team].basealpha;
							self.objpoints[team] fadeovertime(objpingdelay + 1);
							self.objpoints[team].alpha = 0;
						}

						objective_position(self.objid[team],self.curorigin);
					}
				}
			}

			if((self.visibleteam == "enemy" || self.visibleteam == "any") && self.objidpingenemy)
			{
				if(!(self isfriendlyteam(team)))
				{
					if(self.objpoints[team].isshown)
					{
						self.objpoints[team].alpha = self.objpoints[team].basealpha;
						self.objpoints[team] fadeovertime(objpingdelay + 1);
						self.objpoints[team].alpha = 0;
					}

					objective_position(self.objid[team],self.curorigin);
				}
			}

			self wait_endon(objpingdelay,"dropped","reset");
			continue;
		}

		if(IsDefined(self.carrier))
		{
			self.curorigin = 75 + VectorScale((0,0,1));
			wait(0.05);
			continue;
		}

		wait(0.05);
	}
}

//Function Number: 17
updatecarryobjectobjectiveorigin()
{
	level endon("game_ended");
	self.trigger endon("destroyed");
	if(!(self.newstyle))
	{
		return;
	}

	objpingdelay = level.objectivepingdelay;
	for(;;)
	{
		if(IsDefined(self.carrier))
		{
			self.curorigin = self.carrier.origin;
			objective_position(self.objectiveid,self.curorigin);
			self wait_endon(objpingdelay,"dropped","reset");
			continue;
		}

		objective_position(self.objectiveid,self.curorigin);
		wait(0.05);
	}
}

//Function Number: 18
giveobject(object)
{
/#
	assert(!IsDefined(self.carryobject));
#/
	self.carryobject = object;
	self thread trackcarrier();
	if(!(object.allowweapons))
	{
		self _disableweapon();
		self thread manualdropthink();
	}

	self.disallowvehicleusage = 1;
	if(IsDefined(object.visiblecarriermodel))
	{
		self maps/mp/gametypes_zm/_weapons::forcestowedweaponupdate();
	}

	if(!(object.newstyle))
	{
		if(IsDefined(object.carryicon))
		{
			if(self issplitscreen())
			{
				self.carryicon = createicon(object.carryicon,35,35);
				self.carryicon.x = -130;
				self.carryicon.y = -90;
				self.carryicon.horzalign = "right";
				self.carryicon.vertalign = "bottom";
			}
			else
			{
				self.carryicon = createicon(object.carryicon,50,50);
				if(!(object.allowweapons))
				{
					self.carryicon setpoint("CENTER","CENTER",0,60);
				}
				else
				{
					self.carryicon.x = 130;
					self.carryicon.y = -60;
					self.carryicon.horzalign = "user_left";
					self.carryicon.vertalign = "user_bottom";
				}
			}

			self.carryicon.alpha = 0.75;
			self.carryicon.hidewhileremotecontrolling = 1;
			self.carryicon.hidewheninkillcam = 1;
		}
	}
}

//Function Number: 19
returnhome()
{
	self.isresetting = 1;
	self notify("reset");
	for(index = 0;index < self.visuals.size;index++)
	{
		self.visuals[index].origin = self.visuals[index].baseorigin;
		self.visuals[index].angles = self.visuals[index].baseangles;
		self.visuals[index] show();
	}

	self.trigger.origin = self.trigger.baseorigin;
	self.curorigin = self.trigger.origin;
	if(IsDefined(self.onreset))
	{
		self [[ self.onreset ]]();
	}

	self clearcarrier();
	updateworldicons();
	updatecompassicons();
	updateobjective();
	self.isresetting = 0;
}

//Function Number: 20
isobjectawayfromhome()
{
	if(IsDefined(self.carrier))
	{
		return 1;
	}

	if(distancesquared(self.trigger.origin,self.trigger.baseorigin) > 4)
	{
		return 1;
	}
}

//Function Number: 21
setposition(origin,angles)
{
	self.isresetting = 1;
	for(index = 0;index < self.visuals.size;index++)
	{
		visual = self.visuals[index];
		visual.origin = origin;
		visual.angles = angles;
		visual show();
	}

	self.trigger.origin = origin;
	self.curorigin = self.trigger.origin;
	self clearcarrier();
	updateworldicons();
	updatecompassicons();
	updateobjective();
	self.isresetting = 0;
}

//Function Number: 22
onplayerlaststand()
{
	if(IsDefined(self.carryobject))
	{
		self.carryobject thread setdropped();
	}
}

//Function Number: 23
setdropped()
{
	self.isresetting = 1;
	self notify("dropped");
	startorigin = (0,0,0);
	endorigin = (0,0,0);
	body = undefined;
	if(IsDefined(self.carrier) && self.carrier.team != "spectator")
	{
		startorigin = 20 + VectorScale((0,0,1));
		endorigin = 2000 - VectorScale((0,0,1));
		body = self.carrier.body;
		self.visuals[0].origin = self.carrier.origin;
	}
	else
	{
		startorigin = 20 + VectorScale((0,0,1));
		endorigin = 20 - VectorScale((0,0,1));
	}

	trace = playerphysicstrace(startorigin,endorigin);
	angletrace = bullettrace(startorigin,endorigin,0,body);
	droppingplayer = self.carrier;
	if(IsDefined(trace))
	{
		tempangle = randomfloat(360);
		droporigin = trace;
		if(angletrace["fraction"] < 1 && distance(angletrace["position"],trace) < 10)
		{
			forward = (cos(tempangle),sin(tempangle),0);
			forward = vectornormalize(vectordot(forward,angletrace["normal"]) - VectorScale(angletrace["normal"]));
			dropangles = VectorToAngles(forward);
		}
		else
		{
			dropangles = (0,tempangle,0);
		}

		for(index = 0;index < self.visuals.size;index++)
		{
			self.visuals[index].origin = droporigin;
			self.visuals[index].angles = dropangles;
			self.visuals[index] show();
		}

		self.trigger.origin = droporigin;
		self.curorigin = self.trigger.origin;
		self thread pickuptimeout(trace[2],startorigin[2]);
	}
	else
	{
		for(index = 0;index < self.visuals.size;index++)
		{
			self.visuals[index].origin = self.visuals[index].baseorigin;
			self.visuals[index].angles = self.visuals[index].baseangles;
			self.visuals[index] show();
		}

		self.trigger.origin = self.trigger.baseorigin;
		self.curorigin = self.trigger.baseorigin;
	}

	if(IsDefined(self.ondrop))
	{
		self [[ self.ondrop ]](droppingplayer);
	}

	self clearcarrier();
	self updatecompassicons();
	self updateworldicons();
	self updateobjective();
	self.isresetting = 0;
}

//Function Number: 24
setcarrier(carrier)
{
	self.carrier = carrier;
	objective_setplayerusing(self.objectiveid,carrier);
	self thread updatevisibilityaccordingtoradar();
}

//Function Number: 25
clearcarrier()
{
	if(!(IsDefined(self.carrier)))
	{
		return;
	}

	self.carrier takeobject(self);
	objective_clearplayerusing(self.objectiveid,self.carrier);
	self.carrier = undefined;
	self notify("carrier_cleared");
}

//Function Number: 26
shouldbereset(minz,maxz)
{
	minetriggers = getentarray("minefield","targetname");
	hurttriggers = getentarray("trigger_hurt","classname");
	elevators = getentarray("script_elevator","targetname");
	for(index = 0;index < minetriggers.size;index++)
	{
		if(self.visuals[0] istouchingswept(minetriggers[index],minz,maxz))
		{
			return 1;
		}
	}

	for(index = 0;index < hurttriggers.size;index++)
	{
		if(self.visuals[0] istouchingswept(hurttriggers[index],minz,maxz))
		{
			return 1;
		}
	}

	for(index = 0;index < elevators.size;index++)
	{
/#
		assert(IsDefined(elevators[index].occupy_volume));
#/
		if(self.visuals[0] istouchingswept(elevators[index].occupy_volume,minz,maxz))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 27
pickuptimeout(minz,maxz)
{
	self endon("pickup_object");
	self endon("stop_pickup_timeout");
	wait(0.05);
	if(self shouldbereset(minz,maxz))
	{
		self returnhome();
		return;
	}

	if(IsDefined(self.autoresettime))
	{
		wait(self.autoresettime);
		if(!(IsDefined(self.carrier)))
		{
			self returnhome();
		}
	}
}

//Function Number: 28
takeobject(object)
{
	if(IsDefined(self.carryicon))
	{
		self.carryicon destroyelem();
	}

	if(IsDefined(object.visiblecarriermodel))
	{
		self maps/mp/gametypes_zm/_weapons::detach_all_weapons();
	}

	self.carryobject = undefined;
	if(!(isalive(self)))
	{
		return;
	}

	self notify("drop_object");
	self.disallowvehicleusage = 0;
	if(object.triggertype == "proximity")
	{
		self thread pickupobjectdelay(object.trigger.origin);
	}

	if(IsDefined(object.visiblecarriermodel))
	{
		self maps/mp/gametypes_zm/_weapons::forcestowedweaponupdate();
	}

	if(!(object.allowweapons))
	{
		self _enableweapon();
	}
}

//Function Number: 29
trackcarrier()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self endon("drop_object");
	while(IsDefined(self.carryobject) && isalive(self))
	{
		if(self isonground())
		{
			trace = bullettrace(20 + VectorScale((0,0,1)),self.origin,20 - VectorScale((0,0,1)),self.origin);
			if(trace["fraction"] < 1)
			{
				self.carryobject.safeorigin = trace["position"];
			}
		}

		wait(0.05);
	}
}

//Function Number: 30
manualdropthink()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self endon("drop_object");
	for(;;)
	{
		while(self attackbuttonpressed() || self fragbuttonpressed() || self secondaryoffhandbuttonpressed() || self meleebuttonpressed())
		{
			wait(0.05);
		}

		while(!self attackbuttonpressed() && !self fragbuttonpressed() && !self secondaryoffhandbuttonpressed() && !self meleebuttonpressed())
		{
			wait(0.05);
		}

		if(IsDefined(self.carryobject) && !self usebuttonpressed())
		{
			self.carryobject thread setdropped();
		}
	}
}

//Function Number: 31
createuseobject(ownerteam,trigger,visuals,offset,objectivename)
{
	useobject = spawnstruct();
	useobject.type = "useObject";
	useobject.curorigin = trigger.origin;
	useobject.ownerteam = ownerteam;
	useobject.entnum = trigger getentitynumber();
	useobject.keyobject = undefined;
	if(issubstr(trigger.classname,"use"))
	{
		useobject.triggertype = "use";
	}
	else
	{
		useobject.triggertype = "proximity";
	}

	useobject.trigger = trigger;
	for(index = 0;index < visuals.size;index++)
	{
		visuals[index].baseorigin = visuals[index].origin;
		visuals[index].baseangles = visuals[index].angles;
	}

	useobject.visuals = visuals;
	if(!(IsDefined(offset)))
	{
		offset = (0,0,0);
	}

	useobject.offset3d = offset;
	useobject.newstyle = 0;
	if(IsDefined(objectivename))
	{
		useobject.newstyle = 1;
	}
	else
	{
		objectivename = &"";
	}

	useobject.compassicons = [];
	useobject.objid = [];
	if(!(useobject.newstyle))
	{
		foreach(team in level.teams)
		{
			useobject.objid[team] = getnextobjid();
		}

		if(level.teambased)
		{
			foreach(team in level.teams)
			{
				objective_add(useobject.objid[team],"invisible",useobject.curorigin);
				objective_team(useobject.objid[team],team);
			}
		}
		else
		{
			objective_add(useobject.objid[level.nonteambasedteam],"invisible",useobject.curorigin);
		}
	}

	useobject.objectiveid = getnextobjid();
	objective_add(useobject.objectiveid,"invisible",useobject.curorigin,objectivename);
	useobject.interactteam = "none";
	useobject.worldicons = [];
	useobject.visibleteam = "none";
	useobject.worldiswaypoint = [];
	useobject.onuse = undefined;
	useobject.oncantuse = undefined;
	useobject.usetext = "default";
	useobject.usetime = 10000;
	useobject clearprogress();
	useobject.decayprogress = 0;
	if(useobject.triggertype == "proximity")
	{
		useobject.numtouching["neutral"] = 0;
		useobject.numtouching["none"] = 0;
		useobject.touchlist["neutral"] = [];
		useobject.touchlist["none"] = [];
		foreach(team in level.teams)
		{
			useobject.numtouching[team] = 0;
			useobject.touchlist[team] = [];
		}

		useobject.userate = 0;
		useobject.claimteam = "none";
		useobject.claimplayer = undefined;
		useobject.lastclaimteam = "none";
		useobject.lastclaimtime = 0;
		useobject.claimgraceperiod = 1;
		useobject.mustmaintainclaim = 0;
		useobject.cancontestclaim = 0;
		useobject thread useobjectproxthink();
	}
	else
	{
		useobject.userate = 1;
		useobject thread useobjectusethink();
	}

	return useobject;
}

//Function Number: 32
setkeyobject(object)
{
	if(!(IsDefined(object)))
	{
		self.keyobject = undefined;
		return;
	}

	if(!(IsDefined(self.keyobject)))
	{
		self.keyobject = [];
	}

	self.keyobject[self.keyobject.size] = object;
}

//Function Number: 33
haskeyobject(use)
{
	for(x = 0;x < use.keyobject.size;x++)
	{
		if(IsDefined(self.carryobject) && IsDefined(use.keyobject[x]) && self.carryobject == use.keyobject[x])
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 34
useobjectusethink()
{
	level endon("game_ended");
	self.trigger endon("destroyed");
	while(1)
	{
		self.trigger waittill("trigger",player);
		if(!(isalive(player)))
		{
			continue;
		}

		if(!(self caninteractwith(player)))
		{
			continue;
		}

		if(!(player isonground()))
		{
			continue;
		}

		if(player isinvehicle())
		{
			continue;
		}

		if(IsDefined(self.keyobject) && !IsDefined(player.carryobject) || !player haskeyobject(self))
		{
			if(IsDefined(self.oncantuse))
			{
				self [[ self.oncantuse ]](player);
			}

			continue;
		}

		result = 1;
		if(self.usetime > 0)
		{
			if(IsDefined(self.onbeginuse))
			{
				self [[ self.onbeginuse ]](player);
			}

			team = player.pers["team"];
			result = self useholdthink(player);
			if(IsDefined(self.onenduse))
			{
				self [[ self.onenduse ]](team,player,result);
			}
		}

		if(!(result))
		{
			continue;
		}

		if(IsDefined(self.onuse))
		{
			self [[ self.onuse ]](player);
		}
	}
}

//Function Number: 35
getearliestclaimplayer()
{
/#
	assert(self.claimteam != "none");
#/
	team = self.claimteam;
	earliestplayer = self.claimplayer;
	if(self.touchlist[team].size > 0)
	{
		earliesttime = undefined;
		players = getarraykeys(self.touchlist[team]);
		for(index = 0;index < players.size;index++)
		{
			touchdata = self.touchlist[team][players[index]];
			if(!IsDefined(earliesttime) || touchdata.starttime < earliesttime)
			{
				earliestplayer = touchdata.player;
				earliesttime = touchdata.starttime;
			}
		}
	}

	return earliestplayer;
}

//Function Number: 36
useobjectproxthink()
{
	level endon("game_ended");
	self.trigger endon("destroyed");
	self thread proxtriggerthink();
	while(1)
	{
		if(self.usetime && self.curprogress >= self.usetime)
		{
			self clearprogress();
			creditplayer = getearliestclaimplayer();
			if(IsDefined(self.onenduse))
			{
				self [[ self.onenduse ]](self getclaimteam(),creditplayer,IsDefined(creditplayer));
			}

			if(IsDefined(creditplayer) && IsDefined(self.onuse))
			{
				self [[ self.onuse ]](creditplayer);
			}

			self setclaimteam("none");
			self.claimplayer = undefined;
		}

		if(self.claimteam != "none")
		{
			if(self useobjectlockedforteam(self.claimteam))
			{
				if(IsDefined(self.onenduse))
				{
					self [[ self.onenduse ]](self getclaimteam(),self.claimplayer,0);
				}

				self setclaimteam("none");
				self.claimplayer = undefined;
				self clearprogress();
				continue;
			}

			if(self.usetime)
			{
				if(self.decayprogress && !self.numtouching[self.claimteam])
				{
					if(IsDefined(self.claimplayer))
					{
						if(IsDefined(self.onenduse))
						{
							self [[ self.onenduse ]](self getclaimteam(),self.claimplayer,0);
						}

						self.claimplayer = undefined;
					}

					decayscale = 0;
					if(self.decaytime)
					{
						decayscale = self.usetime / self.decaytime;
					}

					self.curprogress = self.curprogress - 50 * self.userate * decayscale;
					if(self.curprogress <= 0)
					{
						self clearprogress();
					}

					self updatecurrentprogress();
					if(IsDefined(self.onuseupdate))
					{
						self [[ self.onuseupdate ]](self getclaimteam(),self.curprogress / self.usetime,50 * self.userate * decayscale / self.usetime);
					}

					if(self.curprogress == 0)
					{
						self setclaimteam("none");
					}

					continue;
				}

				if(!(self.numtouching[self.claimteam]))
				{
					if(IsDefined(self.onenduse))
					{
						self [[ self.onenduse ]](self getclaimteam(),self.claimplayer,0);
					}

					self setclaimteam("none");
					self.claimplayer = undefined;
					continue;
				}

				self.curprogress = self.curprogress + 50 * self.userate;
				self updatecurrentprogress();
				if(IsDefined(self.onuseupdate))
				{
					self [[ self.onuseupdate ]](self getclaimteam(),self.curprogress / self.usetime,50 * self.userate / self.usetime);
				}

				continue;
			}

			if(!(self.mustmaintainclaim))
			{
				if(IsDefined(self.onuse))
				{
					self [[ self.onuse ]](self.claimplayer);
				}

				if(!(self.mustmaintainclaim))
				{
					self setclaimteam("none");
					self.claimplayer = undefined;
				}

				continue;
			}

			if(!(self.numtouching[self.claimteam]))
			{
				if(IsDefined(self.onunoccupied))
				{
					self [[ self.onunoccupied ]]();
				}

				self setclaimteam("none");
				self.claimplayer = undefined;
				continue;
			}

			if(self.cancontestclaim)
			{
				numother = getnumtouchingexceptteam(self.claimteam);
				if(numother > 0)
				{
					if(IsDefined(self.oncontested))
					{
						self [[ self.oncontested ]]();
					}

					self setclaimteam("none");
					self.claimplayer = undefined;
				}
			}
		}
		else if(self.curprogress > 0 && GetTime() - self.lastclaimtime > self.claimgraceperiod * 1000)
		{
			self clearprogress();
		}

		wait(0.05);
		maps/mp/gametypes_zm/_hostmigration::waittillhostmigrationdone();
	}
}

//Function Number: 37
useobjectlockedforteam(team)
{
	if(IsDefined(self.teamlock) && IsDefined(level.teams[team]))
	{
		return self.teamlock[team];
	}
}

//Function Number: 38
canclaim(player)
{
	if(self.cancontestclaim)
	{
		numother = getnumtouchingexceptteam(player.pers["team"]);
		if(numother != 0)
		{
			return 0;
		}
	}

	if(!IsDefined(self.keyobject) || IsDefined(player.carryobject) && player haskeyobject(self))
	{
		return 1;
	}

	return 0;
}

//Function Number: 39
proxtriggerthink()
{
	level endon("game_ended");
	self.trigger endon("destroyed");
	entitynumber = self.entnum;
	while(1)
	{
		self.trigger waittill("trigger",player);
		if(!isalive(player) || self useobjectlockedforteam(player.pers["team"]))
		{
			continue;
		}

		if(player isinvehicle())
		{
			continue;
		}

		if(player isweaponviewonlylinked())
		{
			continue;
		}

		if(self caninteractwith(player) && self.claimteam == "none")
		{
			if(self canclaim(player))
			{
				setclaimteam(player.pers["team"]);
				self.claimplayer = player;
				if(self.usetime && IsDefined(self.onbeginuse))
				{
					self [[ self.onbeginuse ]](self.claimplayer);
				}
			}
			else if(IsDefined(self.oncantuse))
			{
				self [[ self.oncantuse ]](player);
			}
		}

		if(isalive(player) && !IsDefined(player.touchtriggers[entitynumber]))
		{
			player thread triggertouchthink(self);
		}
	}
}

//Function Number: 40
clearprogress()
{
	self.curprogress = 0;
	self updatecurrentprogress();
	if(IsDefined(self.onuseclear))
	{
		self [[ self.onuseclear ]]();
	}
}

//Function Number: 41
setclaimteam(newteam)
{
/#
	assert(newteam != self.claimteam);
#/
	if(self.claimteam == "none" && GetTime() - self.lastclaimtime > self.claimgraceperiod * 1000)
	{
		self clearprogress();
	}
	else if(newteam != "none" && newteam != self.lastclaimteam)
	{
		self clearprogress();
	}

	self.lastclaimteam = self.claimteam;
	self.lastclaimtime = GetTime();
	self.claimteam = newteam;
	self updateuserate();
}

//Function Number: 42
getclaimteam()
{
	return self.claimteam;
}

//Function Number: 43
continuetriggertouchthink(team,object)
{
	if(!(isalive(self)))
	{
		return 0;
	}

	if(self useobjectlockedforteam(team))
	{
		return 0;
	}

	if(self isinvehicle())
	{
		return 0;
	}

	if(!(self istouching(object.trigger)))
	{
		return 0;
	}

	return 1;
}

//Function Number: 44
triggertouchthink(object)
{
	team = self.pers["team"];
	score = 1;
	object.numtouching[team] = object.numtouching[team] + score;
	if(object.usetime)
	{
		object updateuserate();
	}

	touchname = "player" + self.clientid;
	struct = spawnstruct();
	struct.player = self;
	struct.starttime = GetTime();
	object.touchlist[team][touchname] = struct;
	objective_setplayerusing(object.objectiveid,self);
	self.touchtriggers[object.entnum] = object.trigger;
	if(IsDefined(object.ontouchuse))
	{
		object [[ object.ontouchuse ]](self);
	}

	while(self continuetriggertouchthink(team,object))
	{
		if(object.usetime)
		{
			self updateproxbar(object,0);
		}

		wait(0.05);
	}

	if(IsDefined(self))
	{
		if(object.usetime)
		{
			self updateproxbar(object,1);
		}

		self.touchtriggers[object.entnum] = undefined;
		objective_clearplayerusing(object.objectiveid,self);
	}

	if(level.gameended)
	{
		return;
	}

	object.touchlist[team][touchname] = undefined;
	object.numtouching[team] = object.numtouching[team] - score;
	if(object.numtouching[team] < 1)
	{
		object.numtouching[team] = 0;
	}

	if(object.usetime)
	{
		if(object.numtouching[team] <= 0 && object.curprogress >= object.usetime)
		{
			object.curprogress = object.usetime - 1;
			object updatecurrentprogress();
		}
	}

	if(IsDefined(self) && IsDefined(object.onendtouchuse))
	{
		object [[ object.onendtouchuse ]](self);
	}

	object updateuserate();
}

//Function Number: 45
updateproxbar(object,forceremove)
{
	if(object.newstyle)
	{
		return;
	}

	if(!forceremove && object.decayprogress)
	{
		if(!(object caninteractwith(self)))
		{
			if(IsDefined(self.proxbar))
			{
				self.proxbar hideelem();
			}

			if(IsDefined(self.proxbartext))
			{
				self.proxbartext hideelem();
			}

			return;
		}
		else
		{
			if(!(IsDefined(self.proxbar)))
			{
				self.proxbar = createprimaryprogressbar();
				self.proxbar.lastuserate = -1;
			}

			if(self.pers["team"] == object.claimteam)
			{
				if(self.proxbar.bar.color != (1,1,1))
				{
					self.proxbar.bar.color = (1,1,1);
					self.proxbar.lastuserate = -1;
				}
			}
			else if(self.proxbar.bar.color != (1,0,0))
			{
				self.proxbar.bar.color = (1,0,0);
				self.proxbar.lastuserate = -1;
			}
		}
	}
	else if(forceremove || !object caninteractwith(self) || self.pers["team"] != object.claimteam)
	{
		if(IsDefined(self.proxbar))
		{
			self.proxbar hideelem();
		}

		if(IsDefined(self.proxbartext))
		{
			self.proxbartext hideelem();
		}

		return;
	}

	if(!(IsDefined(self.proxbar)))
	{
		self.proxbar = self createprimaryprogressbar();
		self.proxbar.lastuserate = -1;
		self.proxbar.lasthostmigrationstate = 0;
	}

	if(self.proxbar.hidden)
	{
		self.proxbar showelem();
		self.proxbar.lastuserate = -1;
		self.proxbar.lasthostmigrationstate = 0;
	}

	if(!(IsDefined(self.proxbartext)))
	{
		self.proxbartext = self createprimaryprogressbartext();
		self.proxbartext settext(object.usetext);
	}

	if(self.proxbartext.hidden)
	{
		self.proxbartext showelem();
		self.proxbartext settext(object.usetext);
	}

	if(self.proxbar.lastuserate != object.userate || self.proxbar.lasthostmigrationstate != IsDefined(level.hostmigrationtimer))
	{
		if(object.curprogress > object.usetime)
		{
			object.curprogress = object.usetime;
		}

		if(object.decayprogress && self.pers["team"] != object.claimteam)
		{
			if(object.curprogress > 0)
			{
				progress = object.curprogress / object.usetime;
				rate = 1000 / object.usetime * object.userate * -1;
				if(IsDefined(level.hostmigrationtimer))
				{
					rate = 0;
				}

				self.proxbar updatebar(progress,rate);
			}
		}
		else
		{
			progress = object.curprogress / object.usetime;
			rate = 1000 / object.usetime * object.userate;
			if(IsDefined(level.hostmigrationtimer))
			{
				rate = 0;
			}

			self.proxbar updatebar(progress,rate);
		}

		self.proxbar.lasthostmigrationstate = IsDefined(level.hostmigrationtimer);
		self.proxbar.lastuserate = object.userate;
	}
}

//Function Number: 46
getnumtouchingexceptteam(ignoreteam)
{
	numtouching = 0;
	foreach(team in level.teams)
	{
		if(ignoreteam == team)
		{
		}
		else
		{
			numtouching = numtouching + self.numtouching[team];
		}
	}

	return numtouching;
}

//Function Number: 47
updateuserate()
{
	numclaimants = self.numtouching[self.claimteam];
	numother = 0;
	numother = getnumtouchingexceptteam(self.claimteam);
	self.userate = 0;
	if(self.decayprogress)
	{
		if(numclaimants && !numother)
		{
			self.userate = numclaimants;
		}
		else if(!numclaimants && numother)
		{
			self.userate = numother;
		}
		else if(!numclaimants && !numother)
		{
			self.userate = 0;
		}
	}
	else if(numclaimants && !numother)
	{
		self.userate = numclaimants;
	}

	if(IsDefined(self.onupdateuserate))
	{
		self [[ self.onupdateuserate ]]();
	}
}

//Function Number: 48
useholdthink(player)
{
	player notify("use_hold");
	if(!(IsDefined(self.dontlinkplayertotrigger) && self.dontlinkplayertotrigger))
	{
		player playerlinkto(self.trigger);
		player playerlinkedoffsetenable();
	}

	player clientclaimtrigger(self.trigger);
	player.claimtrigger = self.trigger;
	useweapon = self.useweapon;
	lastweapon = player getcurrentweapon();
	if(IsDefined(useweapon))
	{
/#
		assert(IsDefined(lastweapon));
#/
		if(lastweapon == useweapon)
		{
/#
			assert(IsDefined(player.lastnonuseweapon));
#/
			lastweapon = player.lastnonuseweapon;
		}

/#
		assert(lastweapon != useweapon);
#/
		player.lastnonuseweapon = lastweapon;
		player giveweapon(useweapon);
		player setweaponammostock(useweapon,0);
		player setweaponammoclip(useweapon,0);
		player switchtoweapon(useweapon);
	}
	else
	{
		player _disableweapon();
	}

	self clearprogress();
	self.inuse = 1;
	self.userate = 0;
	objective_setplayerusing(self.objectiveid,player);
	player thread personalusebar(self);
	result = useholdthinkloop(player,lastweapon);
	if(IsDefined(player))
	{
		objective_clearplayerusing(self.objectiveid,player);
		self clearprogress();
		if(IsDefined(player.attachedusemodel))
		{
			player detach(player.attachedusemodel,"tag_inhand");
			player.attachedusemodel = undefined;
		}

		player notify("done_using");
	}

	if(IsDefined(useweapon) && IsDefined(player))
	{
		player thread takeuseweapon(useweapon);
	}

	if(IsDefined(result) && result)
	{
		return 1;
	}

	if(IsDefined(player))
	{
		player.claimtrigger = undefined;
		if(IsDefined(useweapon))
		{
			ammo = player getweaponammoclip(lastweapon);
			if(lastweapon != "none" && !isweaponequipment(lastweapon) && player getweaponammoclip(lastweapon) == 0)
			{
				player switchtoweapon(lastweapon);
			}
			else
			{
				player takeweapon(useweapon);
			}
		}
		else if(isalive(player))
		{
			player _enableweapon();
		}

		if(!(IsDefined(self.dontlinkplayertotrigger) && self.dontlinkplayertotrigger))
		{
			player unlink();
		}

		if(!(isalive(player)))
		{
			player.killedinuse = 1;
		}
	}

	self.inuse = 0;
	if(self.trigger.classname == "trigger_radius_use")
	{
		player clientreleasetrigger(self.trigger);
	}
	else
	{
		self.trigger releaseclaimedtrigger();
	}

	return 0;
}

//Function Number: 49
takeuseweapon(useweapon)
{
	self endon("use_hold");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	while(self getcurrentweapon() == useweapon && !self.throwinggrenade)
	{
		wait(0.05);
	}

	self takeweapon(useweapon);
}

//Function Number: 50
continueholdthinkloop(player,waitforweapon,timedout,usetime)
{
	maxwaittime = 1.5;
	if(!(isalive(player)))
	{
		return 0;
	}

	if(IsDefined(player.laststand) && player.laststand)
	{
		return 0;
	}

	if(self.curprogress >= usetime)
	{
		return 0;
	}

	if(!(player usebuttonpressed()))
	{
		return 0;
	}

	if(player.throwinggrenade)
	{
		return 0;
	}

	if(player meleebuttonpressed())
	{
		return 0;
	}

	if(player isinvehicle())
	{
		return 0;
	}

	if(player isremotecontrolling())
	{
		return 0;
	}

	if(player isweaponviewonlylinked())
	{
		return 0;
	}

	if(!(player istouching(self.trigger)))
	{
		return 0;
	}

	if(!self.userate && !waitforweapon)
	{
		return 0;
	}

	if(waitforweapon && timedout > maxwaittime)
	{
		return 0;
	}

	return 1;
}

//Function Number: 51
updatecurrentprogress()
{
	if(self.usetime)
	{
		progress = float(self.curprogress) / self.usetime;
		objective_setprogress(self.objectiveid,clamp(progress,0,1));
	}
}

//Function Number: 52
useholdthinkloop(player,lastweapon)
{
	level endon("game_ended");
	self endon("disabled");
	useweapon = self.useweapon;
	waitforweapon = 1;
	timedout = 0;
	usetime = self.usetime;
	while(self continueholdthinkloop(player,waitforweapon,timedout,usetime))
	{
		timedout = timedout + 0.05;
		if(!IsDefined(useweapon) || player getcurrentweapon() == useweapon)
		{
			self.curprogress = self.curprogress + 50 * self.userate;
			self updatecurrentprogress();
			self.userate = 1;
			waitforweapon = 0;
		}
		else
		{
			self.userate = 0;
		}

		if(self.curprogress >= usetime)
		{
			self.inuse = 0;
			player clientreleasetrigger(self.trigger);
			player.claimtrigger = undefined;
			if(IsDefined(useweapon))
			{
				player setweaponammostock(useweapon,1);
				player setweaponammoclip(useweapon,1);
				if(lastweapon != "none" && !isweaponequipment(lastweapon) && player getweaponammoclip(lastweapon) == 0)
				{
					player switchtoweapon(lastweapon);
					continue;
				}

				player takeweapon(useweapon);
			}
			else
			{
				player _enableweapon();
			}

			if(!(IsDefined(self.dontlinkplayertotrigger) && self.dontlinkplayertotrigger))
			{
				player unlink();
			}

			wait(0.05);
			return isalive(player);
		}

		wait(0.05);
		maps/mp/gametypes_zm/_hostmigration::waittillhostmigrationdone();
	}

	return 0;
}

//Function Number: 53
personalusebar(object)
{
	self endon("disconnect");
	if(object.newstyle)
	{
		return;
	}

	if(IsDefined(self.usebar))
	{
		return;
	}

	self.usebar = self createprimaryprogressbar();
	self.usebartext = self createprimaryprogressbartext();
	self.usebartext settext(object.usetext);
	usetime = object.usetime;
	lastrate = -1;
	lasthostmigrationstate = IsDefined(level.hostmigrationtimer);
	while(isalive(self) && object.inuse && !level.gameended)
	{
		if(lastrate != object.userate || lasthostmigrationstate != IsDefined(level.hostmigrationtimer))
		{
			if(object.curprogress > usetime)
			{
				object.curprogress = usetime;
			}

			if(object.decayprogress && self.pers["team"] != object.claimteam)
			{
				if(object.curprogress > 0)
				{
					progress = object.curprogress / usetime;
					rate = 1000 / usetime * object.userate * -1;
					if(IsDefined(level.hostmigrationtimer))
					{
						rate = 0;
					}

					self.proxbar updatebar(progress,rate);
				}
			}
			else
			{
				progress = object.curprogress / usetime;
				rate = 1000 / usetime * object.userate;
				if(IsDefined(level.hostmigrationtimer))
				{
					rate = 0;
				}

				self.usebar updatebar(progress,rate);
			}

			if(!(object.userate))
			{
				self.usebar hideelem();
				self.usebartext hideelem();
			}
			else
			{
				self.usebar showelem();
				self.usebartext showelem();
			}
		}

		lastrate = object.userate;
		lasthostmigrationstate = IsDefined(level.hostmigrationtimer);
		wait(0.05);
	}

	self.usebar destroyelem();
	self.usebartext destroyelem();
}

//Function Number: 54
updatetrigger()
{
	if(self.triggertype != "use")
	{
		return;
	}

	if(self.interactteam == "none")
	{
		self.trigger.origin = 50000 - VectorScale((0,0,1));
	}
	else if(self.interactteam == "any" || !level.teambased)
	{
		self.trigger.origin = self.curorigin;
		self.trigger setteamfortrigger("none");
	}
	else if(self.interactteam == "friendly")
	{
		self.trigger.origin = self.curorigin;
		if(IsDefined(level.teams[self.ownerteam]))
		{
			self.trigger setteamfortrigger(self.ownerteam);
		}
		else
		{
			self.trigger.origin = 50000 - VectorScale((0,0,1));
		}
	}
	else if(self.interactteam == "enemy")
	{
		self.trigger.origin = self.curorigin;
		self.trigger setexcludeteamfortrigger(self.ownerteam);
	}
}

//Function Number: 55
updateobjective()
{
	if(!(self.newstyle))
	{
		return;
	}

	objective_team(self.objectiveid,self.ownerteam);
	if(self.visibleteam == "any")
	{
		objective_state(self.objectiveid,"active");
		objective_visibleteams(self.objectiveid,level.spawnsystem.ispawn_teammask["all"]);
	}
	else if(self.visibleteam == "friendly")
	{
		objective_state(self.objectiveid,"active");
		objective_visibleteams(self.objectiveid,level.spawnsystem.ispawn_teammask[self.ownerteam]);
	}
	else if(self.visibleteam == "enemy")
	{
		objective_state(self.objectiveid,"active");
		objective_visibleteams(self.objectiveid,level.spawnsystem.ispawn_teammask["all"] & ~level.spawnsystem.ispawn_teammask[self.ownerteam]);
	}
	else
	{
		objective_state(self.objectiveid,"invisible");
		objective_visibleteams(self.objectiveid,0);
	}

	if(self.type == "carryObject")
	{
		if(isalive(self.carrier))
		{
			objective_onentity(self.objectiveid,self.carrier);
		}
		else
		{
			objective_clearentity(self.objectiveid);
		}
	}
}

//Function Number: 56
updateworldicons()
{
	if(self.visibleteam == "any")
	{
		updateworldicon("friendly",1);
		updateworldicon("enemy",1);
	}
	else if(self.visibleteam == "friendly")
	{
		updateworldicon("friendly",1);
		updateworldicon("enemy",0);
	}
	else if(self.visibleteam == "enemy")
	{
		updateworldicon("friendly",0);
		updateworldicon("enemy",1);
	}
	else
	{
		updateworldicon("friendly",0);
		updateworldicon("enemy",0);
	}
}

//Function Number: 57
updateworldicon(relativeteam,showicon)
{
}

//Function Number: 58
updatecompassicons()
{
	if(self.visibleteam == "any")
	{
		updatecompassicon("friendly",1);
		updatecompassicon("enemy",1);
	}
	else if(self.visibleteam == "friendly")
	{
		updatecompassicon("friendly",1);
		updatecompassicon("enemy",0);
	}
	else if(self.visibleteam == "enemy")
	{
		updatecompassicon("friendly",0);
		updatecompassicon("enemy",1);
	}
	else
	{
		updatecompassicon("friendly",0);
		updatecompassicon("enemy",0);
	}
}

//Function Number: 59
updatecompassicon(relativeteam,showicon)
{
	if(self.newstyle)
	{
		return;
	}

	updateteams = getupdateteams(relativeteam);
	for(index = 0;index < updateteams.size;index++)
	{
		showiconthisteam = showicon;
		if(!showiconthisteam && shouldshowcompassduetoradar(updateteams[index]))
		{
			showiconthisteam = 1;
		}

		if(level.teambased)
		{
			objid = self.objid[updateteams[index]];
		}
		else
		{
			objid = self.objid[level.nonteambasedteam];
		}

		if(!IsDefined(self.compassicons[relativeteam]) || !showiconthisteam)
		{
			objective_state(objid,"invisible");
		}
		else
		{
			objective_icon(objid,self.compassicons[relativeteam]);
			objective_state(objid,"active");
			if(self.type == "carryObject")
			{
				if(isalive(self.carrier) && !shouldpingobject(relativeteam))
				{
					objective_onentity(objid,self.carrier);
				}
				else
				{
					objective_position(objid,self.curorigin);
				}
			}
		}
	}
}

//Function Number: 60
shouldpingobject(relativeteam)
{
	if(relativeteam == "friendly" && self.objidpingfriendly)
	{
		return 1;
	}
	else if(relativeteam == "enemy" && self.objidpingenemy)
	{
		return 1;
	}
}

//Function Number: 61
getupdateteams(relativeteam)
{
	updateteams = [];
	if(level.teambased)
	{
		if(relativeteam == "friendly")
		{
			foreach(team in level.teams)
			{
				if(self isfriendlyteam(team))
				{
					updateteams[updateteams.size] = team;
				}
			}
		}
		else if(relativeteam == "enemy")
		{
			foreach(team in level.teams)
			{
				if(!(self isfriendlyteam(team)))
				{
					updateteams[updateteams.size] = team;
				}
			}
		}
	}
	else if(relativeteam == "friendly")
	{
		updateteams[updateteams.size] = level.nonteambasedteam;
	}
	else
	{
		updateteams[updateteams.size] = "axis";
	}

	return updateteams;
}

//Function Number: 62
shouldshowcompassduetoradar(team)
{
	showcompass = 0;
	return showcompass;
}

//Function Number: 63
updatevisibilityaccordingtoradar()
{
	self endon("death");
	self endon("carrier_cleared");
	while(1)
	{
		level waittill("radar_status_change");
		self updatecompassicons();
	}
}

//Function Number: 64
setownerteam(team)
{
	self.ownerteam = team;
	self updatetrigger();
	self updatecompassicons();
	self updateworldicons();
	self updateobjective();
}

//Function Number: 65
getownerteam()
{
	return self.ownerteam;
}

//Function Number: 66
setdecaytime(time)
{
	self.decaytime = int(time * 1000);
}

//Function Number: 67
setusetime(time)
{
	self.usetime = int(time * 1000);
}

//Function Number: 68
setusetext(text)
{
	self.usetext = text;
}

//Function Number: 69
setusehinttext(text)
{
	self.trigger sethintstring(text);
}

//Function Number: 70
allowcarry(relativeteam)
{
	self.interactteam = relativeteam;
}

//Function Number: 71
allowuse(relativeteam)
{
	self.interactteam = relativeteam;
	updatetrigger();
}

//Function Number: 72
setvisibleteam(relativeteam)
{
	self.visibleteam = relativeteam;
	if(!(maps/mp/gametypes_zm/_tweakables::gettweakablevalue("hud","showobjicons")))
	{
		self.visibleteam = "none";
	}

	updatecompassicons();
	updateworldicons();
	updateobjective();
}

//Function Number: 73
setmodelvisibility(visibility)
{
	if(visibility)
	{
		for(index = 0;index < self.visuals.size;index++)
		{
			self.visuals[index] show();
			if(self.visuals[index].classname == "script_brushmodel" || self.visuals[index].classname == "script_model")
			{
				self.visuals[index] thread makesolid();
			}
		}
	}
	else
	{
		for(index = 0;index < self.visuals.size;index++)
		{
			self.visuals[index] hide();
			if(self.visuals[index].classname == "script_brushmodel" || self.visuals[index].classname == "script_model")
			{
				self.visuals[index] notify("changing_solidness");
				self.visuals[index] notsolid();
			}
		}
	}
}

//Function Number: 74
makesolid()
{
	self endon("death");
	self notify("changing_solidness");
	self endon("changing_solidness");
	while(1)
	{
		for(i = 0;i < level.players.size;i++)
		{
			if(level.players[i] istouching(self))
			{
				break;
			}
		}

		if(i == level.players.size)
		{
			self solid();
			break;
		}

		wait(0.05);
	}
}

//Function Number: 75
setcarriervisible(relativeteam)
{
	self.carriervisible = relativeteam;
}

//Function Number: 76
setcanuse(relativeteam)
{
	self.useteam = relativeteam;
}

//Function Number: 77
set2dicon(relativeteam,shader)
{
	self.compassicons[relativeteam] = shader;
	updatecompassicons();
}

//Function Number: 78
set3dicon(relativeteam,shader)
{
	self.worldicons[relativeteam] = shader;
	updateworldicons();
}

//Function Number: 79
set3duseicon(relativeteam,shader)
{
	self.worlduseicons[relativeteam] = shader;
}

//Function Number: 80
set3diswaypoint(relativeteam,waypoint)
{
	self.worldiswaypoint[relativeteam] = waypoint;
}

//Function Number: 81
setcarryicon(shader)
{
	self.carryicon = shader;
}

//Function Number: 82
setvisiblecarriermodel(visiblemodel)
{
	self.visiblecarriermodel = visiblemodel;
}

//Function Number: 83
getvisiblecarriermodel()
{
	return self.visiblecarriermodel;
}

//Function Number: 84
destroyobject(deletetrigger,forcehide)
{
	if(!(IsDefined(forcehide)))
	{
		forcehide = 1;
	}

	self disableobject(forcehide);
	foreach(visual in self.visuals)
	{
		visual hide();
		visual delete();
	}

	self.trigger notify("destroyed",_k2742);
	if(IsDefined(deletetrigger) && deletetrigger)
	{
		self.trigger delete();
	}
	else
	{
		self.trigger triggeron();
	}
}

//Function Number: 85
disableobject(forcehide)
{
	self notify("disabled");
	if(self.type == "carryObject" || IsDefined(forcehide) && forcehide)
	{
		if(IsDefined(self.carrier))
		{
			self.carrier takeobject(self);
		}

		for(index = 0;index < self.visuals.size;index++)
		{
			self.visuals[index] hide();
		}
	}

	self.trigger triggeroff();
	self setvisibleteam("none");
}

//Function Number: 86
enableobject(forceshow)
{
	if(self.type == "carryObject" || IsDefined(forceshow) && forceshow)
	{
		for(index = 0;index < self.visuals.size;index++)
		{
			self.visuals[index] show();
		}
	}

	self.trigger triggeron();
	self setvisibleteam("any");
}

//Function Number: 87
getrelativeteam(team)
{
	if(self.ownerteam == "any")
	{
		return "friendly";
	}

	if(team == self.ownerteam)
	{
		return "friendly";
	}
	else if(team == getenemyteam(self.ownerteam))
	{
		return "enemy";
	}
	else
	{
		return "neutral";
	}
}

//Function Number: 88
isfriendlyteam(team)
{
	if(!(level.teambased))
	{
		return 1;
	}

	if(self.ownerteam == "any")
	{
		return 1;
	}

	if(self.ownerteam == team)
	{
		return 1;
	}
}

//Function Number: 89
caninteractwith(player)
{
	team = player.pers["team"];
	switch(self.interactteam)
	{
		case "none":
			return 0;

		case "any":
			return 1;

		case "friendly":
			return 1;
			return 0;
			return 1;
			return 0;
	Stack-Empty ? Stack-Empty : (Stack-Empty ? (Stack-Empty ? level.teambased : team == self.ownerteam) : player == self.ownerteam)
			break;

		case "enemy":
			return 1;
			return 1;
			return 0;
			return 1;
			return 0;
	Stack-Empty ? Stack-Empty : (Stack-Empty ? (Stack-Empty ? Stack-Empty : (level.teambased ? team != self.ownerteam : IsDefined(self.decayprogress) && self.decayprogress && self.curprogress > 0)) : player != self.ownerteam)
			break;

		default:
	/#
			assert(0,"invalid interactTeam");
	#/
			return 0;
	}
}

//Function Number: 90
isteam(team)
{
	if(team == "neutral")
	{
		return 1;
	}

	if(IsDefined(level.teams[team]))
	{
		return 1;
	}

	if(team == "any")
	{
		return 1;
	}

	if(team == "none")
	{
		return 1;
	}
}

//Function Number: 91
isrelativeteam(relativeteam)
{
	if(relativeteam == "friendly")
	{
		return 1;
	}

	if(relativeteam == "enemy")
	{
		return 1;
	}

	if(relativeteam == "any")
	{
		return 1;
	}

	if(relativeteam == "none")
	{
		return 1;
	}
}

//Function Number: 92
getenemyteam(team)
{
	if(team == "neutral")
	{
		return "none";
	}
	else if(team == "allies")
	{
		return "axis";
	}
	else
	{
		return "allies";
	}
}

//Function Number: 93
getnextobjid()
{
	nextid = 0;
	if(level.releasedobjectives.size > 0)
	{
		nextid = level.releasedobjectives[level.releasedobjectives.size - 1];
		level.releasedobjectives[level.releasedobjectives.size - 1] = undefined;
	}
	else
	{
		nextid = level.numgametypereservedobjectives;
		level.numgametypereservedobjectives++;
	}

/#
	assert(nextid < 32,"Ran out of objective IDs");
#/
	return nextid;
}

//Function Number: 94
releaseobjid(objid)
{
/#
	assert(objid < level.numgametypereservedobjectives);
#/
	for(i = 0;i < level.releasedobjectives.size;i++)
	{
		if(objid == level.releasedobjectives[i] && objid == 31)
		{
			return;
		}

/#
/#
		assert(objid != level.releasedobjectives[i]);
#/
#/
	}

	level.releasedobjectives[level.releasedobjectives.size] = objid;
}

//Function Number: 95
getlabel()
{
	label = self.trigger.script_label;
	if(!(IsDefined(label)))
	{
		label = "";
		return label;
	}

	if(label[0] != "_")
	{
		return "_" + label;
	}
}

//Function Number: 96
mustmaintainclaim(enabled)
{
	self.mustmaintainclaim = enabled;
}

//Function Number: 97
cancontestclaim(enabled)
{
	self.cancontestclaim = enabled;
}

//Function Number: 98
setflags(flags)
{
	objective_setgamemodeflags(self.objectiveid,flags);
}

//Function Number: 99
getflags(flags)
{
	return objective_getgamemodeflags(self.objectiveid);
}