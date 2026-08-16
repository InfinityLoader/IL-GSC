/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_gameobjects.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main(allowed)
{
	allowed[allowed.size] = "airdrop_pallet";
	entitytypes = getentarray();
	for(i = 0;i < entitytypes.size;i++)
	{
		if(isdefined(entitytypes[i].script_gameobjectname))
		{
			dodelete = 1;
			gameobjectnames = strtok(entitytypes[i].script_gameobjectname, " ");
			for(j = 0;j < allowed.size;j++)
			{
				for(k = 0;k < gameobjectnames.size;k++)
				{
					if(gameobjectnames[k] == allowed[j])
					{
						dodelete = 0;
						break;
					}
				}

				if(!dodelete)
				{
					break;
				}
			}

			if(dodelete)
			{
				entitytypes[i] delete();
			}
		}
	}
}

init()
{
	level.numgametypereservedobjectives = 0;
	precacheitem("briefcase_bomb_mp");
	precacheitem("briefcase_bomb_defuse_mp");
	precachemodel("prop_suitcase_bomb");
	level.objidstart = 0;
	level thread onplayerconnect();
}

onplayerconnect()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("connected", player);
		player thread onplayerspawned();
		player thread ondisconnect();
	}
}

onplayerspawned()
{
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("spawned_player");
		thread ondeath();
		self.touchtriggers = [];
		self.carryobject = undefined;
		self.claimtrigger = undefined;
		self.canpickupobject = 1;
		self.killedinuse = undefined;
	}
}

ondeath()
{
	level endon("game_ended");
	self waittill("death");
	if(isdefined(self.carryobject))
	{
		self.carryobject thread setdropped();
		return;
	}
}

ondisconnect()
{
	level endon("game_ended");
	self waittill("disconnect");
	if(isdefined(self.carryobject))
	{
		self.carryobject thread setdropped();
		return;
	}
}

createcarryobject(ownerteam, trigger, visuals, offset)
{
	carryobject = spawnstruct();
	carryobject.type = "carryObject";
	carryobject.curorigin = trigger.origin;
	carryobject.ownerteam = ownerteam;
	carryobject.entnum = trigger getentitynumber();
	if(issubstr(trigger.classname, "use"))
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
	if(!isdefined(offset))
	{
		offset = (0,0,0);
	}

	carryobject.offset3d = offset;
	for(index = 0;index < visuals.size;index++)
	{
		visuals[index].baseorigin = visuals[index].origin;
		visuals[index].baseangles = visuals[index].angles;
	}

	carryobject.visuals = visuals;
	carryobject.compassicons = [];
	carryobject.objidallies = getnextobjid();
	carryobject.objidaxis = getnextobjid();
	carryobject.objidpingfriendly = 0;
	carryobject.objidpingenemy = 0;
	level.objidstart = level.objidstart + 2;
	objective_add(carryobject.objidallies, "invisible", carryobject.curorigin);
	objective_add(carryobject.objidaxis, "invisible", carryobject.curorigin);
	objective_team(carryobject.objidallies, "allies");
	objective_team(carryobject.objidaxis, "axis");
	carryobject.objpoints["allies"] = maps\mp\gametypes\_objpoints::createteamobjpoint("objpoint_allies_" + carryobject.entnum, carryobject.curorigin + offset, "allies", undefined);
	carryobject.objpoints["axis"] = maps\mp\gametypes\_objpoints::createteamobjpoint("objpoint_axis_" + carryobject.entnum, carryobject.curorigin + offset, "axis", undefined);
	carryobject.objpoints["allies"].alpha = 0;
	carryobject.objpoints["axis"].alpha = 0;
	carryobject.carrier = undefined;
	carryobject.isresetting = 0;
	carryobject.interactteam = "none";
	carryobject.allowweapons = 0;
	carryobject.worldicons = [];
	carryobject.carriervisible = 0;
	carryobject.visibleteam = "none";
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
		carryobject.curprogress = 0;
		carryobject.usetime = 0;
		carryobject.userate = 0;
		carryobject.teamusetimes = [];
		carryobject.teamusetexts = [];
		carryobject.numtouching["neutral"] = 0;
		carryobject.numtouching["axis"] = 0;
		carryobject.numtouching["allies"] = 0;
		carryobject.numtouching["none"] = 0;
		carryobject.touchlist["neutral"] = [];
		carryobject.touchlist["axis"] = [];
		carryobject.touchlist["allies"] = [];
		carryobject.touchlist["none"] = [];
		carryobject.claimteam = "none";
		carryobject.claimplayer = undefined;
		carryobject.lastclaimteam = "none";
		carryobject.lastclaimtime = 0;
		carryobject thread carryobjectproxthink();
	}

	carryobject thread updatecarryobjectorigin();
	return carryobject;
}

carryobjectusethink()
{
	level endon("game_ended");
	for(;;)
	{
		self.trigger waittill("trigger", player);
		if(self.isresetting)
		{
			continue;
		}

		if(!maps\mp\_utility::isreallyalive(player))
		{
			continue;
		}

		if(!caninteractwith(player.pers["team"]))
		{
			continue;
		}

		if(!player.canpickupobject)
		{
			continue;
		}

		if(isdefined(player.throwinggrenade))
		{
			continue;
		}

		if(isdefined(self.carrier))
		{
			continue;
		}

		if(player maps\mp\_utility::isusingremote())
		{
			continue;
		}

		setpickedup(player);
	}
}

carryobjectproxthink()
{
	thread carryobjectproxthinkdelayed();
}

carryobjectproxthinkinstant()
{
	level endon("game_ended");
	for(;;)
	{
		self.trigger waittill("trigger", player);
		if(self.isresetting)
		{
			continue;
		}

		if(!maps\mp\_utility::isreallyalive(player))
		{
			continue;
		}

		if(!caninteractwith(player.pers["team"]))
		{
			continue;
		}

		if(!player.canpickupobject)
		{
			continue;
		}

		if(isdefined(player.throwinggrenade))
		{
			continue;
		}

		if(isdefined(self.carrier))
		{
			continue;
		}

		setpickedup(player);
	}
}

carryobjectproxthinkdelayed()
{
	level endon("game_ended");
	thread proxtriggerthink();
	for(;;)
	{
		if(self.usetime && self.curprogress >= self.usetime)
		{
			self.curprogress = 0;
			creditplayer = getearliestclaimplayer();
			if(isdefined(self.onenduse))
			{
				self [[ self.onenduse ]](getclaimteam(), creditplayer, isdefined(creditplayer));
			}

			if(isdefined(creditplayer))
			{
				setpickedup(creditplayer);
			}

			setclaimteam("none");
			self.claimplayer = undefined;
		}

		if(self.claimteam != "none")
		{
			if(self.usetime)
			{
				if(!self.numtouching[self.claimteam])
				{
					if(isdefined(self.onenduse))
					{
						self [[ self.onenduse ]](getclaimteam(), self.claimplayer, 0);
					}

					setclaimteam("none");
					self.claimplayer = undefined;
				}
				else
				{
					self.curprogress = self.curprogress + 50 * self.userate;
					if(isdefined(self.onuseupdate))
					{
						self [[ self.onuseupdate ]](getclaimteam(), self.curprogress / self.usetime, 50 * self.userate / self.usetime);
					}
				}
			}
			else
			{
				if(maps\mp\_utility::isreallyalive(self.claimplayer))
				{
					setpickedup(self.claimplayer);
				}

				setclaimteam("none");
				self.claimplayer = undefined;
			}
		}

		wait 0.05;
		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	}
}

pickupobjectdelay(origin)
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self.canpickupobject = 0;
	for(;;)
	{
		if(distancesquared(self.origin, origin) > 4096)
		{
			break;
		}

		wait 0.2;
	}

	self.canpickupobject = 1;
}

setpickedup(player)
{
	if(isdefined(player.carryobject))
	{
		if(isdefined(self.onpickupfailed))
		{
			self [[ self.onpickupfailed ]](player);
		}

		return;
	}

	player giveobject(self);
	setcarrier(player);
	for(index = 0;index < self.visuals.size;index++)
	{
		self.visuals[index] hide();
	}

	self.trigger.origin = self.trigger.origin + (0,0,10000);
	self notify("pickup_object");
	if(isdefined(self.onpickup))
	{
		self [[ self.onpickup ]](player);
	}

	updatecompassicons();
	updateworldicons();
}

updatecarryobjectorigin()
{
	level endon("game_ended");
	objpingdelay = 5;
	for(;;)
	{
		if(isdefined(self.carrier))
		{
			self.curorigin = self.carrier.origin + (0,0,75);
			self.objpoints["allies"] maps\mp\gametypes\_objpoints::updateorigin(self.curorigin);
			self.objpoints["axis"] maps\mp\gametypes\_objpoints::updateorigin(self.curorigin);
			if((self.visibleteam == "friendly" || self.visibleteam == "any") && isfriendlyteam("allies") && self.objidpingfriendly)
			{
				if(self.objpoints["allies"].isshown)
				{
					self.objpoints["allies"].alpha = self.objpoints["allies"].basealpha;
					self.objpoints["allies"] fadeovertime(objpingdelay + 1);
					self.objpoints["allies"].alpha = 0;
				}

				objective_position(self.objidallies, self.curorigin);
			}
			else if((self.visibleteam == "friendly" || self.visibleteam == "any") && isfriendlyteam("axis") && self.objidpingfriendly)
			{
				if(self.objpoints["axis"].isshown)
				{
					self.objpoints["axis"].alpha = self.objpoints["axis"].basealpha;
					self.objpoints["axis"] fadeovertime(objpingdelay + 1);
					self.objpoints["axis"].alpha = 0;
				}

				objective_position(self.objidaxis, self.curorigin);
			}

			if((self.visibleteam == "enemy" || self.visibleteam == "any") && !isfriendlyteam("allies") && self.objidpingenemy)
			{
				if(self.objpoints["allies"].isshown)
				{
					self.objpoints["allies"].alpha = self.objpoints["allies"].basealpha;
					self.objpoints["allies"] fadeovertime(objpingdelay + 1);
					self.objpoints["allies"].alpha = 0;
				}

				objective_position(self.objidallies, self.curorigin);
			}
			else if((self.visibleteam == "enemy" || self.visibleteam == "any") && !isfriendlyteam("axis") && self.objidpingenemy)
			{
				if(self.objpoints["axis"].isshown)
				{
					self.objpoints["axis"].alpha = self.objpoints["axis"].basealpha;
					self.objpoints["axis"] fadeovertime(objpingdelay + 1);
					self.objpoints["axis"].alpha = 0;
				}

				objective_position(self.objidaxis, self.curorigin);
			}

			maps\mp\_utility::wait_endon(objpingdelay, "dropped", "reset");
			continue;
		}

		self.objpoints["allies"] maps\mp\gametypes\_objpoints::updateorigin(self.curorigin + self.offset3d);
		self.objpoints["axis"] maps\mp\gametypes\_objpoints::updateorigin(self.curorigin + self.offset3d);
		wait 0.05;
	}
}

giveobject(object)
{
	self.carryobject = object;
	thread trackcarrier();
	if(!object.allowweapons)
	{
		common_scripts\utility::_disableweapon();
		thread manualdropthink();
	}

	if(isdefined(object.carryicon))
	{
		if(level.splitscreen)
		{
			self.carryicon = maps\mp\gametypes\_hud_util::createicon(object.carryicon, 33, 33);
			self.carryicon maps\mp\gametypes\_hud_util::setpoint("BOTTOM RIGHT", "BOTTOM RIGHT", 0, -78);
		}
		else
		{
			self.carryicon = maps\mp\gametypes\_hud_util::createicon(object.carryicon, 50, 50);
			self.carryicon maps\mp\gametypes\_hud_util::setpoint("BOTTOM", "BOTTOM", 85, -62);
		}

		self.carryicon.hidewheninmenu = 1;
		return;
	}
}

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
	if(isdefined(self.onreset))
	{
		self [[ self.onreset ]]();
	}

	clearcarrier();
	updateworldicons();
	updatecompassicons();
	self.isresetting = 0;
}

ishome()
{
	if(isdefined(self.carrier))
	{
		return 0;
	}

	if(self.curorigin != self.trigger.baseorigin)
	{
		return 0;
	}

	return 1;
}

setposition(origin, angles)
{
	self.isresetting = 1;
	for(index = 0;index < self.visuals.size;index++)
	{
		self.visuals[index].origin = self.origin;
		self.visuals[index].angles = self.angles;
		self.visuals[index] show();
	}

	self.trigger.origin = origin;
	self.curorigin = self.trigger.origin;
	clearcarrier();
	updateworldicons();
	updatecompassicons();
	self.isresetting = 0;
}

onplayerlaststand()
{
	if(isdefined(self.carryobject))
	{
		self.carryobject thread setdropped();
		return;
	}
}

setdropped()
{
	self.isresetting = 1;
	self notify("dropped");
	if(isdefined(self.carrier))
	{
		trace = playerphysicstrace(self.carrier.origin + (0,0,20), self.carrier.origin - (0,0,2000), 0, self.carrier.body);
		angletrace = bullettrace(self.carrier.origin + (0,0,20), self.carrier.origin - (0,0,2000), 0, self.carrier.body);
	}
	else
	{
		trace = playerphysicstrace(self.safeorigin + (0,0,20), self.safeorigin - (0,0,20), 0, undefined);
		angletrace = bullettrace(self.safeorigin + (0,0,20), self.safeorigin - (0,0,20), 0, undefined);
	}

	droppingplayer = self.carrier;
	touchingbadtrigger = 0;
	if(isdefined(trace))
	{
		tempangle = randomfloat(360);
		droporigin = trace;
		if(angletrace["fraction"] < 1 && distance(angletrace["position"], trace) < 10)
		{
			forward = (cos(tempangle),sin(tempangle),0);
			forward = vectornormalize(forward - common_scripts\utility::vector_multiply(angletrace["normal"], vectordot(forward, angletrace["normal"])));
			dropangles = vectortoangles(forward);
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
		thread pickuptimeout();
	}

	if(!isdefined(trace))
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

	if(isdefined(self.ondrop))
	{
		self [[ self.ondrop ]](droppingplayer);
	}

	clearcarrier();
	updatecompassicons();
	updateworldicons();
	self.isresetting = 0;
}

setcarrier(carrier)
{
	self.carrier = carrier;
	thread updatevisibilityaccordingtoradar();
}

clearcarrier()
{
	if(!isdefined(self.carrier))
	{
		return;
	}

	self.carrier takeobject(self);
	self.carrier = undefined;
	self notify("carrier_cleared");
}

pickuptimeout()
{
	self endon("pickup_object");
	self endon("stop_pickup_timeout");
	wait 0.05;
	minetriggers = getentarray("minefield", "targetname");
	hurttriggers = getentarray("trigger_hurt", "classname");
	radtriggers = getentarray("radiation", "targetname");
	for(index = 0;index < radtriggers.size;index++)
	{
		if(!self.visuals[0] istouching(radtriggers[index]))
		{
			continue;
		}

		returnhome();
		return;
	}

	for(index = 0;index < minetriggers.size;index++)
	{
		if(!self.visuals[0] istouching(minetriggers[index]))
		{
			continue;
		}

		returnhome();
		return;
	}

	for(index = 0;index < hurttriggers.size;index++)
	{
		if(!self.visuals[0] istouching(hurttriggers[index]))
		{
			continue;
		}

		returnhome();
		return;
	}

	if(isdefined(self.autoresettime))
	{
		wait self.autoresettime;
		if(!isdefined(self.carrier))
		{
			returnhome();
			return;
		}

		return;
	}
}

takeobject(object)
{
	if(isdefined(self.carryicon))
	{
		self.carryicon maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(self))
	{
		self.carryobject = undefined;
	}

	self notify("drop_object");
	if(object.triggertype == "proximity")
	{
		thread pickupobjectdelay(object.trigger.origin);
	}

	if(maps\mp\_utility::isreallyalive(self) && !object.allowweapons)
	{
		common_scripts\utility::_enableweapon();
		return;
	}
}

trackcarrier()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self endon("drop_object");
	while(isdefined(self.carryobject) && maps\mp\_utility::isreallyalive(self))
	{
		if(self isonground())
		{
			trace = bullettrace(self.origin + (0,0,20), self.origin - (0,0,20), 0, undefined);
			if(trace["fraction"] < 1)
			{
				self.carryobject.safeorigin = trace["position"];
			}
		}

		wait 0.05;
	}
}

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
			wait 0.05;
		}

		while(!self attackbuttonpressed() && !self fragbuttonpressed() && !self secondaryoffhandbuttonpressed() && !self meleebuttonpressed())
		{
			wait 0.05;
		}

		if(isdefined(self.carryobject) && !self usebuttonpressed())
		{
			self.carryobject thread setdropped();
		}
	}
}

deleteuseobject()
{
	objective_delete(self.objidallies);
	objective_delete(self.objidaxis);
	maps\mp\gametypes\_objpoints::deleteobjpoint(self.objpoints["allies"]);
	maps\mp\gametypes\_objpoints::deleteobjpoint(self.objpoints["axis"]);
	self.trigger = undefined;
	self notify("deleted");
}

createuseobject(ownerteam, trigger, visuals, offset)
{
	useobject = spawnstruct();
	useobject.type = "useObject";
	useobject.curorigin = trigger.origin;
	useobject.ownerteam = ownerteam;
	useobject.entnum = trigger getentitynumber();
	useobject.keyobject = undefined;
	if(issubstr(trigger.classname, "use"))
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
	if(!isdefined(offset))
	{
		offset = (0,0,0);
	}

	useobject.offset3d = offset;
	useobject.compassicons = [];
	useobject.objidallies = getnextobjid();
	useobject.objidaxis = getnextobjid();
	objective_add(useobject.objidallies, "invisible", useobject.curorigin);
	objective_add(useobject.objidaxis, "invisible", useobject.curorigin);
	objective_team(useobject.objidallies, "allies");
	objective_team(useobject.objidaxis, "axis");
	useobject.objpoints["allies"] = maps\mp\gametypes\_objpoints::createteamobjpoint("objpoint_allies_" + useobject.entnum, useobject.curorigin + offset, "allies", undefined);
	useobject.objpoints["axis"] = maps\mp\gametypes\_objpoints::createteamobjpoint("objpoint_axis_" + useobject.entnum, useobject.curorigin + offset, "axis", undefined);
	useobject.objpoints["allies"].alpha = 0;
	useobject.objpoints["axis"].alpha = 0;
	useobject.interactteam = "none";
	useobject.worldicons = [];
	useobject.visibleteam = "none";
	useobject.onuse = undefined;
	useobject.oncantuse = undefined;
	useobject.usetext = "default";
	useobject.usetime = 10000;
	useobject.curprogress = 0;
	if(useobject.triggertype == "proximity")
	{
		useobject.teamusetimes = [];
		useobject.teamusetexts = [];
		useobject.numtouching["neutral"] = 0;
		useobject.numtouching["axis"] = 0;
		useobject.numtouching["allies"] = 0;
		useobject.numtouching["none"] = 0;
		useobject.touchlist["neutral"] = [];
		useobject.touchlist["axis"] = [];
		useobject.touchlist["allies"] = [];
		useobject.touchlist["none"] = [];
		useobject.userate = 0;
		useobject.claimteam = "none";
		useobject.claimplayer = undefined;
		useobject.lastclaimteam = "none";
		useobject.lastclaimtime = 0;
		useobject thread useobjectproxthink();
	}
	else
	{
		useobject.userate = 1;
		useobject thread useobjectusethink();
	}

	return useobject;
}

setkeyobject(object)
{
	self.keyobject = object;
}

useobjectusethink()
{
	level endon("game_ended");
	self endon("deleted");
	for(;;)
	{
		self.trigger waittill("trigger", player);
		if(!maps\mp\_utility::isreallyalive(player))
		{
			continue;
		}

		if(!caninteractwith(player.pers["team"]))
		{
			continue;
		}

		if(!player isonground())
		{
			continue;
		}

		if(issubstr(player getcurrentweapon(), "killstreak"))
		{
			continue;
		}

		if(isdefined(self.keyobject) && !isdefined(player.carryobject) || player.carryobject != self.keyobject)
		{
			if(isdefined(self.oncantuse))
			{
				self [[ self.oncantuse ]](player);
			}

			continue;
		}

		if(!player common_scripts\utility::isweaponenabled())
		{
			continue;
		}

		result = 1;
		if(self.usetime > 0)
		{
			if(isdefined(self.onbeginuse))
			{
				self [[ self.onbeginuse ]](player);
			}

			if(!isdefined(self.keyobject))
			{
				thread cantusehintthink();
			}

			team = player.pers["team"];
			result = useholdthink(player);
			self notify("finished_use");
			if(isdefined(self.onenduse))
			{
				self [[ self.onenduse ]](team, player, result);
			}
		}

		if(!result)
		{
			continue;
		}

		if(isdefined(self.onuse))
		{
			self [[ self.onuse ]](player);
		}
	}
}

cantusehintthink()
{
	level endon("game_ended");
	self endon("deleted");
	self endon("finished_use");
	for(;;)
	{
		self.trigger waittill("trigger", player);
		if(!maps\mp\_utility::isreallyalive(player))
		{
			continue;
		}

		if(!caninteractwith(player.pers["team"]))
		{
			continue;
		}

		if(isdefined(self.oncantuse))
		{
			self [[ self.oncantuse ]](player);
		}
	}
}

getearliestclaimplayer()
{
	team = self.claimteam;
	if(maps\mp\_utility::isreallyalive(self.claimplayer))
	{
		earliestplayer = self.claimplayer;
	}
	else
	{
		earliestplayer = undefined;
	}

	if(self.touchlist[team].size > 0)
	{
		earliesttime = undefined;
		players = getarraykeys(self.touchlist[team]);
		for(index = 0;index < players.size;index++)
		{
			touchdata = self.touchlist[team][players[index]];
			if(maps\mp\_utility::isreallyalive(players[index]) && !isdefined(earliesttime) || touchdata.starttime < earliesttime)
			{
				earliestplayer = touchdata.player;
				earliesttime = touchdata.starttime;
			}
		}
	}

	return earliestplayer;
}

useobjectproxthink()
{
	level endon("game_ended");
	self endon("deleted");
	thread proxtriggerthink();
	for(;;)
	{
		if(self.usetime && self.curprogress >= self.usetime)
		{
			self.curprogress = 0;
			creditplayer = getearliestclaimplayer();
			if(isdefined(self.onenduse))
			{
				self [[ self.onenduse ]](getclaimteam(), creditplayer, isdefined(creditplayer));
			}

			if(isdefined(creditplayer) && isdefined(self.onuse))
			{
				self [[ self.onuse ]](creditplayer);
			}

			setclaimteam("none");
			self.claimplayer = undefined;
		}

		if(self.claimteam != "none")
		{
			if(self.usetime)
			{
				if(!self.numtouching[self.claimteam])
				{
					if(isdefined(self.onenduse))
					{
						self [[ self.onenduse ]](getclaimteam(), self.claimplayer, 0);
					}

					setclaimteam("none");
					self.claimplayer = undefined;
				}
				else
				{
					self.curprogress = self.curprogress + 50 * self.userate;
					if(isdefined(self.onuseupdate))
					{
						self [[ self.onuseupdate ]](getclaimteam(), self.curprogress / self.usetime, 50 * self.userate / self.usetime);
					}
				}
			}
			else
			{
				if(isdefined(self.onuse))
				{
					self [[ self.onuse ]](self.claimplayer);
				}

				setclaimteam("none");
				self.claimplayer = undefined;
			}
		}

		wait 0.05;
		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	}
}

proxtriggerthink()
{
	level endon("game_ended");
	self endon("deleted");
	entitynumber = self.entnum;
	for(;;)
	{
		self.trigger waittill("trigger", player);
		if(!maps\mp\_utility::isreallyalive(player))
		{
			continue;
		}

		if(isdefined(self.carrier))
		{
			continue;
		}

		if(player maps\mp\_utility::isusingremote())
		{
			continue;
		}

		if(caninteractwith(player.pers["team"], player) && self.claimteam == "none")
		{
			if(!isdefined(self.keyobject) || isdefined(player.carryobject) && player.carryobject == self.keyobject)
			{
				setclaimteam(player.pers["team"]);
				self.claimplayer = player;
				relativeteam = getrelativeteam(player.pers["team"]);
				if(isdefined(self.teamusetimes[relativeteam]))
				{
					self.usetime = self.teamusetimes[relativeteam];
				}

				if(self.usetime && isdefined(self.onbeginuse))
				{
					self [[ self.onbeginuse ]](self.claimplayer);
				}
			}
			else if(isdefined(self.oncantuse))
			{
				self [[ self.oncantuse ]](player);
			}
		}

		if(self.usetime && maps\mp\_utility::isreallyalive(player) && !isdefined(player.touchtriggers[entitynumber]))
		{
			player thread triggertouchthink(self);
		}
	}
}

setclaimteam(param_BD5)
{
	if(self.claimteam == "none" && gettime() - self.lastclaimtime > 1000)
	{
		self.curprogress = 0;
	}
	else if(param_BD5 != "none" && param_BD5 != self.lastclaimteam)
	{
		self.curprogress = 0;
	}

	self.lastclaimteam = self.claimteam;
	self.lastclaimtime = gettime();
	self.claimteam = param_BD5;
	updateuserate();
}

getclaimteam()
{
	return self.claimteam;
}

triggertouchthink(object)
{
	team = self.pers["team"];
	object.numtouching[team]++;
	touchname = self.guid;
	struct = spawnstruct();
	struct.player = self;
	struct.starttime = gettime();
	object.touchlist[team][touchname] = struct;
	if(!isdefined(object.nousebar))
	{
		object.nousebar = 0;
	}

	self.touchtriggers[object.entnum] = object.trigger;
	object updateuserate();
	while(maps\mp\_utility::isreallyalive(self) && isdefined(object.trigger) && self istouching(object.trigger) && !level.gameended && object.usetime)
	{
		updateproxbar(object, 0);
		wait 0.05;
	}

	if(isdefined(self))
	{
		updateproxbar(object, 1);
		self.touchtriggers[object.entnum] = undefined;
	}

	if(level.gameended)
	{
		return;
	}

	object.touchlist[team][touchname] = undefined;
	object.numtouching[team]--;
	object updateuserate();
}

updateproxbar(object, param_BD7)
{
	if(param_BD7 || !object caninteractwith(self.pers["team"]) || self.pers["team"] != object.claimteam || object.nousebar)
	{
		if(isdefined(self.proxbar))
		{
			self.proxbar maps\mp\gametypes\_hud_util::hideelem();
		}

		if(isdefined(self.proxbartext))
		{
			self.proxbartext maps\mp\gametypes\_hud_util::hideelem();
		}

		return;
	}

	if(!isdefined(self.proxbar))
	{
		self.proxbar = maps\mp\gametypes\_hud_util::createprimaryprogressbar();
		self.proxbar.lastuserate = -1;
		self.proxbar.lasthostmigrationstate = 0;
	}

	if(self.proxbar.hidden)
	{
		self.proxbar maps\mp\gametypes\_hud_util::showelem();
		self.proxbar.lastuserate = -1;
		self.proxbar.lasthostmigrationstate = 0;
	}

	if(!isdefined(self.proxbartext))
	{
		self.proxbartext = maps\mp\gametypes\_hud_util::createprimaryprogressbartext();
		relativeteam = object getrelativeteam(self.pers["team"]);
		if(isdefined(object.teamusetexts[relativeteam]))
		{
			self.proxbartext settext(object.teamusetexts[relativeteam]);
		}
		else
		{
			self.proxbartext settext(object.usetext);
		}
	}

	if(self.proxbartext.hidden)
	{
		self.proxbartext maps\mp\gametypes\_hud_util::showelem();
		relativeteam = object getrelativeteam(self.pers["team"]);
		if(isdefined(object.teamusetexts[relativeteam]))
		{
			self.proxbartext settext(object.teamusetexts[relativeteam]);
		}
		else
		{
			self.proxbartext settext(object.usetext);
		}
	}

	if(self.proxbar.lastuserate != object.userate || self.proxbar.lasthostmigrationstate != isdefined(level.hostmigrationtimer))
	{
		if(object.curprogress > object.usetime)
		{
			object.curprogress = object.usetime;
		}

		progress = object.curprogress / object.usetime;
		rate = 1000 / object.usetime * object.userate;
		if(isdefined(level.hostmigrationtimer))
		{
			rate = 0;
		}

		self.proxbar maps\mp\gametypes\_hud_util::updatebar(progress, rate);
		self.proxbar.lastuserate = object.userate;
		self.proxbar.lasthostmigrationstate = isdefined(level.hostmigrationtimer);
		return;
	}
}

updateuserate()
{
	numclaimants = self.numtouching[self.claimteam];
	numother = 0;
	hasobjscale = 0;
	if(self.claimteam != "axis")
	{
		numother = numother + self.numtouching["axis"];
	}

	if(self.claimteam != "allies")
	{
		numother = numother + self.numtouching["allies"];
	}

	foreach(struct in self.touchlist[self.claimteam])
	{
		if(struct.player.pers["team"] != self.claimteam)
		{
			continue;
		}

		if(struct.player.objectivescaler == 1)
		{
			continue;
		}

		numclaimants = numclaimants * struct.player.objectivescaler;
		hasobjscale = struct.player.objectivescaler;
	}

	self.userate = 0;
	if(numclaimants && !numother)
	{
		self.userate = min(numclaimants, 4);
	}

	if(isdefined(self.isarena) && self.isarena && hasobjscale != 0)
	{
		self.userate = 1 * hasobjscale;
		return;
	}

	if(isdefined(self.isarena) && self.isarena)
	{
		self.userate = 1;
		return;
	}
}

attachusemodel()
{
	self endon("death");
	self endon("disconnect");
	self endon("done_using");
	wait 1.3;
	self attach("prop_suitcase_bomb", "tag_inhand", 1);
	self.attachedusemodel = "prop_suitcase_bomb";
}

useholdthink(player)
{
	player notify("use_hold");
	player playerlinkto(self.trigger);
	player playerlinkedoffsetenable();
	player clientclaimtrigger(self.trigger);
	player.claimtrigger = self.trigger;
	useweapon = self.useweapon;
	lastweapon = player getcurrentweapon();
	if(isdefined(useweapon))
	{
		if(lastweapon == useweapon)
		{
			lastweapon = player.lastnonuseweapon;
		}

		player.lastnonuseweapon = lastweapon;
		player maps\mp\_utility::_giveweapon(useweapon);
		player setweaponammostock(useweapon, 0);
		player setweaponammoclip(useweapon, 0);
		player switchtoweapon(useweapon);
		player thread attachusemodel();
	}
	else
	{
		player common_scripts\utility::_disableweapon();
	}

	self.curprogress = 0;
	self.inuse = 1;
	self.userate = 0;
	player thread personalusebar(self);
	result = useholdthinkloop(player, lastweapon);
	if(isdefined(player))
	{
		player detachusemodels();
		player notify("done_using");
	}

	if(isdefined(useweapon) && isdefined(player))
	{
		player thread takeuseweapon(useweapon);
	}

	if(isdefined(result) && result)
	{
		return 1;
	}

	if(isdefined(player))
	{
		player.claimtrigger = undefined;
		if(isdefined(useweapon))
		{
			if(lastweapon != "none")
			{
				player switchtoweapon(lastweapon);
			}
			else
			{
				player takeweapon(useweapon);
			}
		}
		else
		{
			player common_scripts\utility::_enableweapon();
		}

		player unlink();
		if(!maps\mp\_utility::isreallyalive(player))
		{
			player.killedinuse = 1;
		}
	}

	self.inuse = 0;
	self.trigger releaseclaimedtrigger();
	return 0;
}

detachusemodels()
{
	if(isdefined(self.attachedusemodel))
	{
		self detach(self.attachedusemodel, "tag_inhand");
		self.attachedusemodel = undefined;
		return;
	}
}

takeuseweapon(useweapon)
{
	self endon("use_hold");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	while(self getcurrentweapon() == useweapon && !isdefined(self.throwinggrenade))
	{
		wait 0.05;
	}

	self takeweapon(useweapon);
}

useholdthinkloop(player, lastweapon)
{
	level endon("game_ended");
	self endon("disabled");
	useweapon = self.useweapon;
	waitforweapon = 1;
	timedout = 0;
	maxwaittime = 1.5;
	while(maps\mp\_utility::isreallyalive(player) && player istouching(self.trigger) && player usebuttonpressed() && !isdefined(player.throwinggrenade) && !player meleebuttonpressed() && self.curprogress < self.usetime && self.userate || waitforweapon && !waitforweapon && timedout > maxwaittime)
	{
		timedout = timedout + 0.05;
		if(!isdefined(useweapon) || player getcurrentweapon() == useweapon)
		{
			self.curprogress = self.curprogress + 50 * self.userate;
			self.userate = 1 * player.objectivescaler;
			waitforweapon = 0;
		}
		else
		{
			self.userate = 0;
		}

		if(self.curprogress >= self.usetime)
		{
			self.inuse = 0;
			player clientreleasetrigger(self.trigger);
			player.claimtrigger = undefined;
			if(isdefined(useweapon))
			{
				player setweaponammostock(useweapon, 1);
				player setweaponammoclip(useweapon, 1);
				if(lastweapon != "none")
				{
					player switchtoweapon(lastweapon);
				}
				else
				{
					player takeweapon(useweapon);
				}
			}
			else
			{
				player common_scripts\utility::_enableweapon();
			}

			player unlink();
			return maps\mp\_utility::isreallyalive(player);
		}

		wait 0.05;
		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	}

	return 0;
}

personalusebar(object)
{
	self endon("disconnect");
	usebar = maps\mp\gametypes\_hud_util::createprimaryprogressbar();
	usebartext = maps\mp\gametypes\_hud_util::createprimaryprogressbartext();
	usebartext settext(object.usetext);
	lastrate = -1;
	lasthostmigrationstate = isdefined(level.hostmigrationtimer);
	while(maps\mp\_utility::isreallyalive(self) && object.inuse && !level.gameended)
	{
		if(lastrate != object.userate || lasthostmigrationstate != isdefined(level.hostmigrationtimer))
		{
			if(object.curprogress > object.usetime)
			{
				object.curprogress = object.usetime;
			}

			progress = object.curprogress / object.usetime;
			rate = 1000 / object.usetime * object.userate;
			if(isdefined(level.hostmigrationtimer))
			{
				rate = 0;
			}

			usebar maps\mp\gametypes\_hud_util::updatebar(progress, rate);
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
		lasthostmigrationstate = isdefined(level.hostmigrationtimer);
		wait 0.05;
	}

	usebar maps\mp\gametypes\_hud_util::destroyelem();
	usebartext maps\mp\gametypes\_hud_util::destroyelem();
}

updatetrigger()
{
	if(self.triggertype != "use")
	{
		return;
	}

	if(self.interactteam == "none")
	{
		self.trigger.origin = self.trigger.origin - (0,0,50000);
		return;
	}

	if(self.interactteam == "any")
	{
		self.trigger.origin = self.curorigin;
		self.trigger setteamfortrigger("none");
		return;
	}

	if(self.interactteam == "friendly")
	{
		self.trigger.origin = self.curorigin;
		if(self.ownerteam == "allies")
		{
			self.trigger setteamfortrigger("allies");
			return;
		}

		if(self.ownerteam == "axis")
		{
			self.trigger setteamfortrigger("axis");
			return;
		}

		self.trigger.origin = self.trigger.origin - (0,0,50000);
		return;
	}

	if(self.interactteam == "enemy")
	{
		self.trigger.origin = self.curorigin;
		if(self.ownerteam == "allies")
		{
			self.trigger setteamfortrigger("axis");
			return;
		}

		if(self.ownerteam == "axis")
		{
			self.trigger setteamfortrigger("allies");
			return;
		}

		self.trigger setteamfortrigger("none");
		return;
	}
}

updateworldicons()
{
	if(self.visibleteam == "any")
	{
		updateworldicon("friendly", 1);
		updateworldicon("enemy", 1);
		return;
	}

	if(self.visibleteam == "friendly")
	{
		updateworldicon("friendly", 1);
		updateworldicon("enemy", 0);
		return;
	}

	if(self.visibleteam == "enemy")
	{
		updateworldicon("friendly", 0);
		updateworldicon("enemy", 1);
		return;
	}

	updateworldicon("friendly", 0);
	updateworldicon("enemy", 0);
}

updateworldicon(relativeteam, param_BE5)
{
	if(!isdefined(self.worldicons[relativeteam]))
	{
		param_BE5 = 0;
	}

	updateteams = getupdateteams(relativeteam);
	for(index = 0;index < updateteams.size;index++)
	{
		opname = "objpoint_" + updateteams[index] + "_" + self.entnum;
		objpoint = maps\mp\gametypes\_objpoints::getobjpointbyname(opname);
		objpoint notify("stop_flashing_thread");
		objpoint thread maps\mp\gametypes\_objpoints::stopflashing();
		if(param_BE5)
		{
			objpoint setshader(self.worldicons[relativeteam], level.objpointsize, level.objpointsize);
			objpoint fadeovertime(0.05);
			objpoint.alpha = objpoint.basealpha;
			objpoint.isshown = 1;
			if(isdefined(self.compassicons[relativeteam]))
			{
				objpoint setwaypoint(1, 1);
			}
			else
			{
				objpoint setwaypoint(1, 0);
			}

			if(self.type == "carryObject")
			{
				if(isdefined(self.carrier) && !shouldpingobject(relativeteam))
				{
					objpoint settargetent(self.carrier);
				}
				else
				{
					objpoint cleartargetent();
				}
			}

			continue;
		}

		objpoint fadeovertime(0.05);
		objpoint.alpha = 0;
		objpoint.isshown = 0;
		objpoint cleartargetent();
	}
}

updatetimer(seconds, param_BE5)
{
}

updatecompassicons()
{
	if(self.visibleteam == "any")
	{
		updatecompassicon("friendly", 1);
		updatecompassicon("enemy", 1);
		return;
	}

	if(self.visibleteam == "friendly")
	{
		updatecompassicon("friendly", 1);
		updatecompassicon("enemy", 0);
		return;
	}

	if(self.visibleteam == "enemy")
	{
		updatecompassicon("friendly", 0);
		updatecompassicon("enemy", 1);
		return;
	}

	updatecompassicon("friendly", 0);
	updatecompassicon("enemy", 0);
}

updatecompassicon(relativeteam, param_BE5)
{
	updateteams = getupdateteams(relativeteam);
	for(index = 0;index < updateteams.size;index++)
	{
		showiconthisteam = param_BE5;
		if(!showiconthisteam && shouldshowcompassduetoradar(updateteams[index]))
		{
			showiconthisteam = 1;
		}

		objid = self.objidallies;
		if(updateteams[index] == "axis")
		{
			objid = self.objidaxis;
		}

		if(!isdefined(self.compassicons[relativeteam]) || !showiconthisteam)
		{
			objective_state(objid, "invisible");
			continue;
		}

		objective_icon(objid, self.compassicons[relativeteam]);
		objective_state(objid, "active");
		if(self.type == "carryObject")
		{
			if(maps\mp\_utility::isreallyalive(self.carrier) && !shouldpingobject(relativeteam))
			{
				objective_onentity(objid, self.carrier);
				continue;
			}

			objective_position(objid, self.curorigin);
		}
	}
}

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

	return 0;
}

getupdateteams(relativeteam)
{
	updateteams = [];
	if(relativeteam == "friendly")
	{
		if(isfriendlyteam("allies"))
		{
			updateteams[0] = "allies";
		}
		else if(isfriendlyteam("axis"))
		{
			updateteams[0] = "axis";
		}
	}
	else if(relativeteam == "enemy")
	{
		if(!isfriendlyteam("allies"))
		{
			updateteams[updateteams.size] = "allies";
		}

		if(!isfriendlyteam("axis"))
		{
			updateteams[updateteams.size] = "axis";
		}
	}

	return updateteams;
}

shouldshowcompassduetoradar(team)
{
	if(!isdefined(self.carrier))
	{
		return 0;
	}

	if(self.carrier hasperk("specialty_gpsjammer", 1))
	{
		return 0;
	}

	return getteamradar(team);
}

updatevisibilityaccordingtoradar()
{
	self endon("death");
	self endon("carrier_cleared");
	for(;;)
	{
		level waittill("radar_status_change");
		updatecompassicons();
	}
}

setownerteam(team)
{
	self.ownerteam = team;
	updatetrigger();
	updatecompassicons();
	updateworldicons();
}

getownerteam()
{
	return self.ownerteam;
}

setusetime(time)
{
	self.usetime = int(time * 1000);
}

setusetext(text)
{
	self.usetext = text;
}

setteamusetime(relativeteam, time)
{
	self.teamusetimes[relativeteam] = int(time * 1000);
}

setteamusetext(relativeteam, text)
{
	self.teamusetexts[relativeteam] = text;
}

setusehinttext(text)
{
	self.trigger sethintstring(text);
}

allowcarry(relativeteam)
{
	self.interactteam = relativeteam;
}

allowuse(relativeteam)
{
	self.interactteam = relativeteam;
	updatetrigger();
}

setvisibleteam(relativeteam)
{
	self.visibleteam = relativeteam;
	updatecompassicons();
	updateworldicons();
}

setmodelvisibility(param_BEC)
{
	if(param_BEC)
	{
		for(index = 0;index < self.visuals.size;index++)
		{
			self.visuals[index] show();
			if(self.visuals[index].classname == "script_brushmodel" || self.visuals[index].classname == "script_model")
			{
				foreach(player in level.players)
				{
					if(player istouching(self.visuals[index]))
					{
						player maps\mp\_utility::_suicide();
					}
				}

				self.visuals[index] thread makesolid();
			}
		}

		return;
	}

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

makesolid()
{
	self endon("death");
	self notify("changing_solidness");
	self endon("changing_solidness");
	for(;;)
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

		wait 0.05;
	}
}

setcarriervisible(relativeteam)
{
	self.carriervisible = relativeteam;
}

setcanuse(relativeteam)
{
	self.useteam = relativeteam;
}

set2dicon(relativeteam, shader)
{
	self.compassicons[relativeteam] = shader;
	updatecompassicons();
}

set3dicon(relativeteam, shader)
{
	self.worldicons[relativeteam] = shader;
	updateworldicons();
}

set3duseicon(relativeteam, shader)
{
	self.worlduseicons[relativeteam] = shader;
}

setcarryicon(shader)
{
	self.carryicon = shader;
}

disableobject()
{
	self notify("disabled");
	if(self.type == "carryObject")
	{
		if(isdefined(self.carrier))
		{
			self.carrier takeobject(self);
		}

		for(index = 0;index < self.visuals.size;index++)
		{
			self.visuals[index] hide();
		}
	}

	self.trigger common_scripts\utility::trigger_off();
	setvisibleteam("none");
}

enableobject()
{
	if(self.type == "carryObject")
	{
		for(index = 0;index < self.visuals.size;index++)
		{
			self.visuals[index] show();
		}
	}

	self.trigger common_scripts\utility::trigger_on();
	setvisibleteam("any");
}

getrelativeteam(team)
{
	if(team == self.ownerteam)
	{
		return "friendly";
	}

	return "enemy";
}

isfriendlyteam(team)
{
	if(self.ownerteam == "any")
	{
		return 1;
	}

	if(self.ownerteam == team)
	{
		return 1;
	}

	return 0;
}

caninteractwith(team, player)
{
	switch(self.interactteam)
	{
		case "none":
			return 0;

		case "any":
			return 1;

		case "friendly":
			if(team == self.ownerteam)
			{
				return 1;
			}
			else
			{
				return 0;
			}
	
			break;

		case "enemy":
			if(team != self.ownerteam)
			{
				return 1;
			}
			else
			{
				return 0;
			}
	
			break;

		default:
			return 0;
	}
}

isteam(team)
{
	if(team == "neutral")
	{
		return 1;
	}

	if(team == "allies")
	{
		return 1;
	}

	if(team == "axis")
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

	return 0;
}

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

	return 0;
}

getenemyteam(team)
{
	if(team == "neutral")
	{
		return "none";
	}

	if(team == "allies")
	{
		return "axis";
	}

	return "allies";
}

getnextobjid()
{
	if(!isdefined(level.reclaimedreservedobjectives) || level.reclaimedreservedobjectives.size < 1)
	{
		nextid = level.numgametypereservedobjectives;
		level.numgametypereservedobjectives++;
	}
	else
	{
		nextid = level.reclaimedreservedobjectives[level.reclaimedreservedobjectives.size - 1];
		level.reclaimedreservedobjectives[level.reclaimedreservedobjectives.size - 1] = undefined;
	}

	if(nextid > 31)
	{
		nextid = 31;
	}

	return nextid;
}

getlabel()
{
	label = self.trigger.script_label;
	if(!isdefined(label))
	{
		label = "";
		return label;
	}

	if(label[0] != "_")
	{
		return "_" + label;
	}

	return label;
}