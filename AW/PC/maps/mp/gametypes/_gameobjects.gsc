/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\gametypes\_gameobjects.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 102
 * Decompile Time: 1606 ms
 * Timestamp: 4/22/2024 2:09:30 AM
*******************************************************************/

//Function Number: 1
main(param_00)
{
	param_00[param_00.size] = "airdrop_pallet";
	if(maps\mp\_utility::isaugmentedgamemode())
	{
		param_00[param_00.size] = "boost_add";
	}
	else
	{
		param_00[param_00.size] = "boost_remove";
	}

	var_01 = getentarray();
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(isdefined(var_01[var_02].script_gameobjectname))
		{
			var_03 = 1;
			var_04 = strtok(var_01[var_02].script_gameobjectname," ");
			for(var_05 = 0;var_05 < param_00.size;var_05++)
			{
				for(var_06 = 0;var_06 < var_04.size;var_06++)
				{
					if(var_04[var_06] == param_00[var_05])
					{
						var_03 = 0;
						break;
					}
				}

				if(!var_03)
				{
					break;
				}
			}

			if(var_03)
			{
				if(isdefined(var_01[var_02].script_exploder))
				{
					common_scripts\_createfx::removefxentwithentity(var_01[var_02]);
				}

				var_01[var_02] delete();
			}
		}
	}

	var_07 = getentarray("boost_jump_border","targetname");
	if(isdefined(var_07))
	{
		foreach(var_09 in var_07)
		{
			var_09 delete();
		}
	}
}

//Function Number: 2
init()
{
	level.numgametypereservedobjectives = 0;
	level.objidstart = 0;
	level thread onplayerconnect();
}

//Function Number: 3
onplayerconnect()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread onplayerspawned();
		var_00 thread ondisconnect();
	}
}

//Function Number: 4
onplayerspawned()
{
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("spawned_player");
		if(isdefined(self.gameobject_fauxspawn))
		{
			self.gameobject_fauxspawn = undefined;
			continue;
		}

		init_player_gameobjects();
	}
}

//Function Number: 5
init_player_gameobjects()
{
	thread ondeath();
	self.touchtriggers = [];
	self.carryobject = undefined;
	self.claimtrigger = undefined;
	self.canpickupobject = 1;
	self.killedinuse = undefined;
	self.initialized_gameobject_vars = 1;
}

//Function Number: 6
ondeath()
{
	level endon("game_ended");
	self waittill("death");
	if(isdefined(self.carryobject))
	{
		self.carryobject thread setdropped();
	}
}

//Function Number: 7
ondisconnect()
{
	level endon("game_ended");
	self waittill("disconnect");
	if(isdefined(self.carryobject))
	{
		self.carryobject thread setdropped();
	}
}

//Function Number: 8
createcarryobject(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04.type = "carryObject";
	var_04.curorigin = param_01.origin;
	var_04.ownerteam = param_00;
	var_04.entnum = param_01 getentitynumber();
	if(issubstr(param_01.classname,"use"))
	{
		var_04.triggertype = "use";
	}
	else
	{
		var_04.triggertype = "proximity";
	}

	param_01.baseorigin = param_01.origin;
	var_04.trigger = param_01;
	var_04.useweapon = undefined;
	if(!isdefined(param_03))
	{
		param_03 = (0,0,0);
	}

	var_04.offset3d = param_03;
	for(var_05 = 0;var_05 < param_02.size;var_05++)
	{
		param_02[var_05].baseorigin = param_02[var_05].origin;
		param_02[var_05].baseangles = param_02[var_05].angles;
	}

	var_04.visuals = param_02;
	var_04.compassicons = [];
	var_04.objidallies = getnextobjid();
	var_04.objidaxis = getnextobjid();
	var_04.objidmlgspectator = getnextobjid();
	var_04.objidpingfriendly = 0;
	var_04.objidpingenemy = 0;
	var_04.objpingdelay = 5;
	level.objidstart = level.objidstart + 2;
	objective_add(var_04.objidallies,"invisible",var_04.curorigin);
	objective_add(var_04.objidaxis,"invisible",var_04.curorigin);
	objective_add(var_04.objidmlgspectator,"invisible",var_04.curorigin);
	objective_team(var_04.objidallies,"allies");
	objective_team(var_04.objidaxis,"axis");
	objective_mlgspectator(var_04.objidmlgspectator);
	var_04.objpoints["allies"] = maps\mp\gametypes\_objpoints::createteamobjpoint("objpoint_allies_" + var_04.entnum,var_04.curorigin + param_03,"allies",undefined);
	var_04.objpoints["axis"] = maps\mp\gametypes\_objpoints::createteamobjpoint("objpoint_axis_" + var_04.entnum,var_04.curorigin + param_03,"axis",undefined);
	var_04.objpoints["mlg"] = maps\mp\gametypes\_objpoints::createteamobjpoint("objpoint_mlg_" + var_04.entnum,var_04.curorigin + param_03,"mlg",undefined);
	var_04.objpoints["mlg"].archived = 0;
	var_04.objpoints["allies"].alpha = 0;
	var_04.objpoints["axis"].alpha = 0;
	var_04.carrier = undefined;
	var_04.isresetting = 0;
	var_04.interactteam = "none";
	var_04.allowweapons = 0;
	var_04.waterbadtrigger = 0;
	var_04.keepprogress = 0;
	var_04.worldicons = [];
	var_04.carriervisible = 0;
	var_04.visibleteam = "none";
	var_04.carryicon = undefined;
	var_04.ondrop = undefined;
	var_04.onpickup = undefined;
	var_04.onreset = undefined;
	if(var_04.triggertype == "use")
	{
		var_04 thread carryobjectusethink();
	}
	else
	{
		var_04.curprogress = 0;
		var_04.usetime = 0;
		var_04.userate = 0;
		var_04.mustmaintainclaim = 0;
		var_04.cancontestclaim = 0;
		var_04.teamusetimes = [];
		var_04.teamusetexts = [];
		var_04.numtouching["neutral"] = 0;
		var_04.numtouching["axis"] = 0;
		var_04.numtouching["allies"] = 0;
		var_04.numtouching["none"] = 0;
		var_04.touchlist["neutral"] = [];
		var_04.touchlist["axis"] = [];
		var_04.touchlist["allies"] = [];
		var_04.touchlist["none"] = [];
		var_04.claimteam = "none";
		var_04.claimplayer = undefined;
		var_04.lastclaimteam = "none";
		var_04.lastclaimtime = 0;
		if(level.multiteambased)
		{
			foreach(var_07 in level.teamnamelist)
			{
				var_04.numtouching[var_07] = 0;
				var_04.touchlist[var_07] = [];
			}
		}

		var_04 thread carryobjectproxthink();
	}

	var_04 thread updatecarryobjectorigin();
	return var_04;
}

//Function Number: 9
deletecarryobject()
{
	if(self.type != "carryObject")
	{
		return;
	}

	var_00 = self;
	var_00.type = undefined;
	var_00.curorigin = undefined;
	var_00.ownerteam = undefined;
	var_00.entnum = undefined;
	var_00.triggertype = undefined;
	var_00.trigger unlink();
	var_00.trigger = undefined;
	var_00.useweapon = undefined;
	var_00.offset3d = undefined;
	foreach(var_02 in var_00.visuals)
	{
		var_02 delete();
	}

	var_00.visuals = undefined;
	maps\mp\_utility::_objective_delete(var_00.objidallies);
	maps\mp\_utility::_objective_delete(var_00.objidaxis);
	maps\mp\_utility::_objective_delete(var_00.objidmlgspectator);
	var_00.compassicons = undefined;
	var_00.objidallies = undefined;
	var_00.objidaxis = undefined;
	var_00.objidmlgspectator = undefined;
	var_00.objidpingfriendly = undefined;
	var_00.objidpingenemy = undefined;
	var_00.objpingdelay = undefined;
	maps\mp\gametypes\_objpoints::deleteobjpoint(var_00.objpoints["allies"]);
	maps\mp\gametypes\_objpoints::deleteobjpoint(var_00.objpoints["axis"]);
	maps\mp\gametypes\_objpoints::deleteobjpoint(var_00.objpoints["mlg"]);
	var_00.objpoints = undefined;
	var_00.carrier = undefined;
	var_00.isresetting = undefined;
	var_00.interactteam = undefined;
	var_00.allowweapons = undefined;
	var_00.waterbadtrigger = undefined;
	var_00.keepprogress = undefined;
	var_00.worldicons = undefined;
	var_00.carriervisible = undefined;
	var_00.visibleteam = undefined;
	var_00.carryicon = undefined;
	var_00.ondrop = undefined;
	var_00.onpickup = undefined;
	var_00.onreset = undefined;
	var_00.curprogress = undefined;
	var_00.usetime = undefined;
	var_00.userate = undefined;
	var_00.mustmaintainclaim = undefined;
	var_00.cancontestclaim = undefined;
	var_00.teamusetimes = undefined;
	var_00.teamusetexts = undefined;
	var_00.numtouching = undefined;
	var_00.touchlist = undefined;
	var_00.claimteam = undefined;
	var_00.claimplayer = undefined;
	var_00.lastclaimteam = undefined;
	var_00.lastclaimtime = undefined;
	var_00 notify("death");
	var_00 notify("deleted");
}

//Function Number: 10
carryobjectusethink()
{
	if(isdefined(level.ishorde) && level.ishorde)
	{
		self endon("death");
	}

	level endon("game_ended");
	for(;;)
	{
		self.trigger waittill("trigger",var_00);
		if(self.isresetting)
		{
			continue;
		}

		if(!maps\mp\_utility::isreallyalive(var_00))
		{
			continue;
		}

		if(!caninteractwith(var_00.pers["team"]))
		{
			continue;
		}

		if(!var_00.canpickupobject)
		{
			continue;
		}

		if(!isdefined(var_00.initialized_gameobject_vars))
		{
			continue;
		}

		if(isdefined(var_00.throwinggrenade))
		{
			continue;
		}

		if(isdefined(self.carrier))
		{
			continue;
		}

		if(var_00 maps\mp\_utility::isusingremote() || var_00 maps\mp\_utility::isinremotetransition())
		{
			continue;
		}

		setpickedup(var_00);
	}
}

//Function Number: 11
carryobjectproxthink()
{
	if(isdefined(level.ishorde) && level.ishorde)
	{
		self endon("death");
	}

	thread carryobjectproxthinkdelayed();
}

//Function Number: 12
carryobjectproxthinkdelayed()
{
	if(isdefined(level.ishorde) && level.ishorde)
	{
		self endon("death");
	}

	level endon("game_ended");
	thread proxtriggerthink();
	for(;;)
	{
		waittillframeend;
		if(self.usetime && self.curprogress >= self.usetime)
		{
			self.curprogress = 0;
			var_00 = getearliestclaimplayer();
			if(isdefined(self.onenduse))
			{
				self [[ self.onenduse ]](getclaimteam(),var_00,isdefined(var_00));
			}

			if(isdefined(var_00))
			{
				setpickedup(var_00);
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
						self [[ self.onenduse ]](getclaimteam(),self.claimplayer,0);
					}

					setclaimteam("none");
					self.claimplayer = undefined;
				}
				else
				{
					self.curprogress = self.curprogress + 50 * self.userate;
					if(isdefined(self.onuseupdate))
					{
						self [[ self.onuseupdate ]](getclaimteam(),self.curprogress / self.usetime,50 * self.userate / self.usetime);
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

		wait(0.05);
		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	}
}

//Function Number: 13
pickupobjectdelay(param_00)
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self.canpickupobject = 0;
	for(;;)
	{
		if(distancesquared(self.origin,param_00) > 4096)
		{
			break;
		}

		wait(0.2);
	}

	self.canpickupobject = 1;
}

//Function Number: 14
setpickedup(param_00)
{
	if(isai(param_00) && isdefined(param_00.owner))
	{
		return;
	}

	if(isdefined(param_00.carryobject))
	{
		if(isdefined(self.onpickupfailed))
		{
			self [[ self.onpickupfailed ]](param_00);
		}

		return;
	}

	param_00 giveobject(self);
	setcarrier(param_00);
	for(var_01 = 0;var_01 < self.visuals.size;var_01++)
	{
		self.visuals[var_01] hide();
	}

	self.trigger.origin = self.trigger.origin + (0,0,10000);
	self notify("pickup_object");
	if(isdefined(self.onpickup))
	{
		self [[ self.onpickup ]](param_00);
	}

	updatecompassicons();
	updateworldicons();
}

//Function Number: 15
updatecarryobjectorigin()
{
	if(isdefined(level.ishorde) && level.ishorde)
	{
		self endon("death");
	}

	level endon("game_ended");
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
					self.objpoints["allies"] fadeovertime(self.objpingdelay + 1);
					self.objpoints["allies"].alpha = 0;
				}

				objective_position(self.objidallies,self.curorigin);
			}
			else if((self.visibleteam == "friendly" || self.visibleteam == "any") && isfriendlyteam("axis") && self.objidpingfriendly)
			{
				if(self.objpoints["axis"].isshown)
				{
					self.objpoints["axis"].alpha = self.objpoints["axis"].basealpha;
					self.objpoints["axis"] fadeovertime(self.objpingdelay + 1);
					self.objpoints["axis"].alpha = 0;
				}

				objective_position(self.objidaxis,self.curorigin);
			}

			if((self.visibleteam == "enemy" || self.visibleteam == "any") && !isfriendlyteam("allies") && self.objidpingenemy)
			{
				if(self.objpoints["allies"].isshown)
				{
					self.objpoints["allies"].alpha = self.objpoints["allies"].basealpha;
					self.objpoints["allies"] fadeovertime(self.objpingdelay + 1);
					self.objpoints["allies"].alpha = 0;
				}

				objective_position(self.objidallies,self.curorigin);
			}
			else if((self.visibleteam == "enemy" || self.visibleteam == "any") && !isfriendlyteam("axis") && self.objidpingenemy)
			{
				if(self.objpoints["axis"].isshown)
				{
					self.objpoints["axis"].alpha = self.objpoints["axis"].basealpha;
					self.objpoints["axis"] fadeovertime(self.objpingdelay + 1);
					self.objpoints["axis"].alpha = 0;
				}

				objective_position(self.objidaxis,self.curorigin);
			}

			maps\mp\_utility::wait_endon(self.objpingdelay,"dropped","reset");
			continue;
		}

		self.objpoints["allies"] maps\mp\gametypes\_objpoints::updateorigin(self.curorigin + self.offset3d);
		self.objpoints["axis"] maps\mp\gametypes\_objpoints::updateorigin(self.curorigin + self.offset3d);
		wait(0.05);
	}
}

//Function Number: 16
hidecarryiconongameend()
{
	self endon("disconnect");
	self endon("death");
	self endon("drop_object");
	level waittill("game_ended");
	if(isdefined(self.carryicon))
	{
		self.carryicon.alpha = 0;
	}
}

//Function Number: 17
giveobject(param_00)
{
	self.carryobject = param_00;
	thread trackcarrier();
	if(isdefined(param_00.carryweapon))
	{
		param_00.carrierweaponcurrent = self getcurrentprimaryweapon();
		param_00.carrierhascarryweaponinloadout = self hasweapon(param_00.carryweapon);
		if(isdefined(param_00.carryweaponthink))
		{
			self thread [[ param_00.carryweaponthink ]]();
		}

		self giveweapon(param_00.carryweapon);
		self switchtoweaponimmediate(param_00.carryweapon);
		self disableweaponpickup();
		common_scripts\utility::_disableweaponswitch();
	}
	else if(!param_00.allowweapons)
	{
		common_scripts\utility::_disableweapon();
		if(isdefined(param_00.manualdropthink))
		{
			self thread [[ param_00.manualdropthink ]]();
		}
		else
		{
			thread manualdropthink();
		}
	}

	if(isdefined(param_00.carryicon) && isplayer(self))
	{
		if(level.splitscreen)
		{
			self.carryicon = maps\mp\gametypes\_hud_util::createicon(param_00.carryicon,33,33);
			self.carryicon maps\mp\gametypes\_hud_util::setpoint("BOTTOM RIGHT","BOTTOM RIGHT",-50,-78);
		}
		else
		{
			self.carryicon = maps\mp\gametypes\_hud_util::createicon(param_00.carryicon,50,50);
			self.carryicon maps\mp\gametypes\_hud_util::setpoint("BOTTOM RIGHT","BOTTOM RIGHT",-90,-110);
		}

		self.carryicon.hidewheninmenu = 1;
		thread hidecarryiconongameend();
	}

	if(isdefined(param_00.goliaththink))
	{
		self thread [[ param_00.goliaththink ]]();
	}
}

//Function Number: 18
returnhome()
{
	self.isresetting = 1;
	self notify("reset");
	for(var_00 = 0;var_00 < self.visuals.size;var_00++)
	{
		self.visuals[var_00].origin = self.visuals[var_00].baseorigin;
		self.visuals[var_00].angles = self.visuals[var_00].baseangles;
		self.visuals[var_00] show();
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

//Function Number: 19
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

//Function Number: 20
setposition(param_00,param_01)
{
	self.isresetting = 1;
	for(var_02 = 0;var_02 < self.visuals.size;var_02++)
	{
		self.visuals[var_02].origin = param_00;
		self.visuals[var_02].angles = param_01;
		self.visuals[var_02] show();
	}

	self.trigger.origin = param_00;
	self.curorigin = self.trigger.origin;
	clearcarrier();
	updateworldicons();
	updatecompassicons();
	self.isresetting = 0;
}

//Function Number: 21
onplayerlaststand()
{
	if(isdefined(self.carryobject))
	{
		self.carryobject thread setdropped();
	}
}

//Function Number: 22
carryobject_overridemovingplatformdeath(param_00)
{
	for(var_01 = 0;var_01 < param_00.carryobject.visuals.size;var_01++)
	{
		param_00.carryobject.visuals[var_01] unlink();
	}

	param_00.carryobject.trigger unlink();
	param_00.carryobject notify("stop_pickup_timeout");
	param_00.carryobject returnhome();
}

//Function Number: 23
setdropped()
{
	if(isdefined(self.setdropped))
	{
		if([[ self.setdropped ]]())
		{
			return;
		}
	}

	self.isresetting = 1;
	self notify("dropped");
	if(isdefined(self.carrier) && self.carrier.team != "spectator")
	{
		if(isdefined(self.carrier.body))
		{
			var_00 = playerphysicstrace(self.carrier.origin + (0,0,20),self.carrier.origin - (0,0,2000),self.carrier.body);
			var_01 = bullettrace(self.carrier.origin + (0,0,20),self.carrier.origin - (0,0,2000),0,self.carrier.body);
		}
		else
		{
			var_00 = playerphysicstrace(self.carrier.origin + (0,0,20),self.carrier.origin - (0,0,2000));
			var_01 = bullettrace(self.carrier.origin + (0,0,20),self.carrier.origin - (0,0,2000),0);
		}
	}
	else
	{
		var_00 = playerphysicstrace(self.safeorigin + (0,0,20),self.safeorigin - (0,0,20));
		var_01 = bullettrace(self.safeorigin + (0,0,20),self.safeorigin - (0,0,20),0,undefined);
	}

	var_02 = self.carrier;
	if(isdefined(var_00))
	{
		var_03 = randomfloat(360);
		var_04 = var_00;
		if(isdefined(self.visualgroundoffset))
		{
			var_04 = var_04 + self.visualgroundoffset;
		}

		if(var_01["fraction"] < 1 && distance(var_01["position"],var_00) < 10)
		{
			var_05 = (cos(var_03),sin(var_03),0);
			var_05 = vectornormalize(var_05 - var_01["normal"] * vectordot(var_05,var_01["normal"]));
			var_06 = vectortoangles(var_05);
		}
		else
		{
			var_06 = (0,var_04,0);
		}

		for(var_07 = 0;var_07 < self.visuals.size;var_07++)
		{
			self.visuals[var_07].origin = var_04;
			self.visuals[var_07].angles = var_06;
			self.visuals[var_07] show();
		}

		self.trigger.origin = var_04;
		self.curorigin = self.trigger.origin;
		var_08 = spawnstruct();
		var_08.carryobject = self;
		var_08.deathoverridecallback = ::carryobject_overridemovingplatformdeath;
		self.trigger thread maps\mp\_movers::handle_moving_platforms(var_08);
		thread pickuptimeout();
	}

	if(!isdefined(var_00))
	{
		for(var_07 = 0;var_07 < self.visuals.size;var_07++)
		{
			self.visuals[var_07].origin = self.visuals[var_07].baseorigin;
			self.visuals[var_07].angles = self.visuals[var_07].baseangles;
			self.visuals[var_07] show();
		}

		self.trigger.origin = self.trigger.baseorigin;
		self.curorigin = self.trigger.baseorigin;
	}

	if(isdefined(self.ondrop))
	{
		self [[ self.ondrop ]](var_02);
	}

	clearcarrier();
	updatecompassicons();
	updateworldicons();
	self.isresetting = 0;
}

//Function Number: 24
setcarrier(param_00)
{
	self.carrier = param_00;
	thread updatevisibilityaccordingtoradar();
}

//Function Number: 25
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

//Function Number: 26
pickuptimeout()
{
	self endon("pickup_object");
	self endon("stop_pickup_timeout");
	wait(0.05);
	if(istouchingbadtrigger())
	{
		returnhome();
		return;
	}

	if(isdefined(self.autoresettime))
	{
		wait(self.autoresettime);
		if(!isdefined(self.carrier))
		{
			returnhome();
		}
	}
}

//Function Number: 27
istouchingbadtrigger()
{
	var_00 = getentarray("out_of_bounds","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(!self.visuals[0] istouching(var_00[var_01]))
		{
			continue;
		}

		return 1;
	}

	if(!self.visuals[0] physicsisactive())
	{
		var_00 = getentarray("out_of_bounds_at_rest","targetname");
		for(var_01 = 0;var_01 < var_00.size;var_01++)
		{
			if(!self.visuals[0] istouching(var_00[var_01]))
			{
				continue;
			}

			return 1;
		}
	}

	var_02 = getentarray("trigger_hurt","classname");
	for(var_01 = 0;var_01 < var_02.size;var_01++)
	{
		if(!self.visuals[0] istouching(var_02[var_01]))
		{
			continue;
		}

		return 1;
	}

	if(self.waterbadtrigger)
	{
		var_03 = getentarray("trigger_underwater","targetname");
		for(var_01 = 0;var_01 < var_03.size;var_01++)
		{
			if(!self.visuals[0] istouching(var_03[var_01]))
			{
				continue;
			}

			return 1;
		}
	}

	return 0;
}

//Function Number: 28
getcarrierweaponcurrent(param_00)
{
	if(isdefined(param_00.carrierweaponcurrent) && self hasweapon(param_00.carrierweaponcurrent))
	{
		return param_00.carrierweaponcurrent;
	}

	var_01 = self getweaponslistprimaries();
	return var_01[0];
}

//Function Number: 29
takeobject(param_00)
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
	if(param_00.triggertype == "proximity")
	{
		thread pickupobjectdelay(param_00.trigger.origin);
	}

	if(maps\mp\_utility::isreallyalive(self))
	{
		if(isdefined(param_00.carryweapon))
		{
			var_01 = isdefined(param_00.keepcarryweapon) && param_00.keepcarryweapon;
			if(!param_00.carrierhascarryweaponinloadout && !var_01)
			{
				self takeweapon(param_00.carryweapon);
			}

			var_02 = getcarrierweaponcurrent(param_00);
			self switchtoweapon(var_02);
			self enableweaponpickup();
			common_scripts\utility::_enableweaponswitch();
			return;
		}

		if(!param_00.allowweapons)
		{
			common_scripts\utility::_enableweapon();
			return;
		}
	}
}

//Function Number: 30
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
			var_00 = bullettrace(self.origin + (0,0,20),self.origin - (0,0,20),0,undefined);
			if(var_00["fraction"] < 1)
			{
				self.carryobject.safeorigin = var_00["position"];
			}
		}

		wait(0.05);
	}
}

//Function Number: 31
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

		if(isdefined(self.carryobject) && !self usebuttonpressed())
		{
			self.carryobject thread setdropped();
		}
	}
}

//Function Number: 32
deleteuseobject()
{
	if(isdefined(self.objidallies) && isdefined(self.objidaxis))
	{
		maps\mp\_utility::_objective_delete(self.objidallies);
		maps\mp\_utility::_objective_delete(self.objidaxis);
		maps\mp\_utility::_objective_delete(self.objidmlgspectator);
	}

	if(isdefined(self.objpoints))
	{
		maps\mp\gametypes\_objpoints::deleteobjpoint(self.objpoints["allies"]);
		maps\mp\gametypes\_objpoints::deleteobjpoint(self.objpoints["axis"]);
		maps\mp\gametypes\_objpoints::deleteobjpoint(self.objpoints["mlg"]);
	}

	self.trigger = undefined;
	self notify("deleted");
}

//Function Number: 33
createuseobject(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = spawnstruct();
	var_05.type = "useObject";
	var_05.curorigin = param_01.origin;
	var_05.ownerteam = param_00;
	var_05.entnum = param_01 getentitynumber();
	var_05.keyobject = undefined;
	if(issubstr(param_01.classname,"use"))
	{
		var_05.triggertype = "use";
	}
	else
	{
		var_05.triggertype = "proximity";
	}

	var_05.trigger = param_01;
	for(var_06 = 0;var_06 < param_02.size;var_06++)
	{
		param_02[var_06].baseorigin = param_02[var_06].origin;
		param_02[var_06].baseangles = param_02[var_06].angles;
	}

	var_05.visuals = param_02;
	if(!isdefined(param_03))
	{
		param_03 = (0,0,0);
	}

	var_05.offset3d = param_03;
	if(!isdefined(param_04) || !param_04)
	{
		var_05.compassicons = [];
		var_05.objidallies = getnextobjid();
		var_05.objidaxis = getnextobjid();
		var_05.objidmlgspectator = getnextobjid();
		objective_add(var_05.objidallies,"invisible",var_05.curorigin);
		objective_add(var_05.objidaxis,"invisible",var_05.curorigin);
		objective_add(var_05.objidmlgspectator,"invisible",var_05.curorigin);
		objective_team(var_05.objidallies,"allies");
		objective_team(var_05.objidaxis,"axis");
		objective_mlgspectator(var_05.objidmlgspectator);
		var_05.objpoints["allies"] = maps\mp\gametypes\_objpoints::createteamobjpoint("objpoint_allies_" + var_05.entnum,var_05.curorigin + param_03,"allies",undefined);
		var_05.objpoints["axis"] = maps\mp\gametypes\_objpoints::createteamobjpoint("objpoint_axis_" + var_05.entnum,var_05.curorigin + param_03,"axis",undefined);
		var_05.objpoints["mlg"] = maps\mp\gametypes\_objpoints::createteamobjpoint("objpoint_mlg_" + var_05.entnum,var_05.curorigin + param_03,"mlg",undefined);
		var_05.objpoints["mlg"].archived = 0;
		var_05.objpoints["allies"].alpha = 0;
		var_05.objpoints["axis"].alpha = 0;
		var_05.objpoints["mlg"].alpha = 0;
	}

	var_05.interactteam = "none";
	var_05.keepprogress = 0;
	var_05.worldicons = [];
	var_05.visibleteam = "none";
	var_05.onuse = undefined;
	var_05.oncantuse = undefined;
	var_05.usetext = "default";
	var_05.usetime = 10000;
	var_05.curprogress = 0;
	if(var_05.triggertype == "proximity")
	{
		var_05.teamusetimes = [];
		var_05.teamusetexts = [];
		var_05.numtouching["neutral"] = 0;
		var_05.numtouching["axis"] = 0;
		var_05.numtouching["allies"] = 0;
		var_05.numtouching["none"] = 0;
		var_05.touchlist["neutral"] = [];
		var_05.touchlist["axis"] = [];
		var_05.touchlist["allies"] = [];
		var_05.touchlist["none"] = [];
		var_05.userate = 0;
		var_05.claimteam = "none";
		var_05.claimplayer = undefined;
		var_05.lastclaimteam = "none";
		var_05.lastclaimtime = 0;
		var_05.mustmaintainclaim = 0;
		var_05.cancontestclaim = 0;
		if(level.multiteambased)
		{
			foreach(var_08 in level.teamnamelist)
			{
				var_05.numtouching[var_08] = 0;
				var_05.touchlist[var_08] = [];
			}
		}

		var_05 thread useobjectproxthink();
	}
	else
	{
		var_05.userate = 1;
		var_05 thread useobjectusethink();
	}

	return var_05;
}

//Function Number: 34
move_use_object(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = (0,0,0);
	}

	if(isdefined(self.trigger))
	{
		self.trigger dontinterpolate();
		self.trigger.origin = param_00;
	}

	if(isdefined(self.trigger.baseorigin))
	{
		self.trigger.baseorigin = param_00;
	}

	if(isdefined(self.levelflag))
	{
		self.levelflag dontinterpolate();
		self.levelflag.origin = param_00;
	}

	if(isdefined(self.visuals))
	{
		foreach(var_03 in self.visuals)
		{
			var_03 dontinterpolate();
			var_03.origin = param_00;
			var_03.baseorigin = param_00;
		}
	}

	if(isdefined(self.origin))
	{
		self.origin = param_00;
	}

	if(isdefined(self.curorigin))
	{
		self.curorigin = param_00;
	}

	if(isdefined(self.goal))
	{
		if(isdefined(self.goal.score_fx))
		{
			foreach(var_06 in self.goal.score_fx)
			{
				var_06.origin = param_00;
			}
		}

		if(isdefined(self.goal.origin))
		{
			self.goal.origin = param_00;
		}
	}

	if(isdefined(self.objpoints))
	{
		foreach(var_09 in self.objpoints)
		{
			var_09 maps\mp\gametypes\_objpoints::updateorigin(param_00 + param_01);
		}
	}

	if(isdefined(self.objidallies))
	{
		objective_position(self.objidallies,param_00);
	}

	if(isdefined(self.objidaxis))
	{
		objective_position(self.objidaxis,param_00);
	}

	if(isdefined(self.objidmlgspectator))
	{
		objective_position(self.objidmlgspectator,param_00);
	}

	if(isdefined(self.baseeffect))
	{
		self.baseeffect delete();
		var_0B = self.visuals[0].origin + (0,0,32);
		var_0C = self.visuals[0].origin + (0,0,-32);
		var_0D = bullettrace(var_0B,var_0C,0,undefined);
		var_0E = vectortoangles(var_0D["normal"]);
		self.baseeffectforward = anglestoforward(var_0E);
		self.baseeffectright = anglestoright(var_0E);
		self.baseeffectpos = var_0D["position"];
		if(level.gametype == "dom")
		{
			maps\mp\gametypes\dom::updatevisuals();
		}
	}
}

//Function Number: 35
setkeyobject(param_00)
{
	self.keyobject = param_00;
}

//Function Number: 36
useobjectusethink()
{
	level endon("game_ended");
	self endon("deleted");
	for(;;)
	{
		self.trigger waittill("trigger",var_00);
		if(!maps\mp\_utility::isreallyalive(var_00))
		{
			continue;
		}

		if(!caninteractwith(var_00.pers["team"]))
		{
			continue;
		}

		if(!var_00 isonground())
		{
			continue;
		}

		if(var_00 isdodging())
		{
			continue;
		}

		var_01 = var_00 getcurrentprimaryweapon();
		if(!var_00 maps\mp\_utility::isjuggernaut() && maps\mp\_utility::iskillstreakweapon(var_01) && !issubstr(var_01,"turrethead"))
		{
			continue;
		}

		if(!checkkeyobject(var_00))
		{
			if(isdefined(self.oncantuse))
			{
				self [[ self.oncantuse ]](var_00);
			}

			continue;
		}

		if(!var_00 common_scripts\utility::isweaponenabled())
		{
			continue;
		}

		var_02 = 1;
		if(self.usetime > 0)
		{
			if(isdefined(self.onbeginuse))
			{
				self [[ self.onbeginuse ]](var_00);
			}

			if(!isdefined(self.keyobject))
			{
				thread cantusehintthink();
			}

			var_03 = var_00.pers["team"];
			var_02 = useholdthink(var_00);
			self notify("finished_use");
			if(isdefined(self.onenduse))
			{
				self [[ self.onenduse ]](var_03,var_00,var_02);
			}
		}

		if(!var_02)
		{
			continue;
		}

		if(isdefined(self.onuse))
		{
			self [[ self.onuse ]](var_00);
		}
	}
}

//Function Number: 37
checkkeyobject(param_00)
{
	if(!isdefined(self.keyobject))
	{
		return 1;
	}

	if(!isdefined(param_00.carryobject))
	{
		return 0;
	}

	var_01 = self.keyobject;
	if(!isarray(var_01))
	{
		var_01 = [var_01];
	}

	foreach(var_03 in var_01)
	{
		if(var_03 == param_00.carryobject)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 38
cantusehintthink()
{
	level endon("game_ended");
	self endon("deleted");
	self endon("finished_use");
	for(;;)
	{
		self.trigger waittill("trigger",var_00);
		if(!maps\mp\_utility::isreallyalive(var_00))
		{
			continue;
		}

		if(!caninteractwith(var_00.pers["team"]))
		{
			continue;
		}

		if(isdefined(self.oncantuse))
		{
			self [[ self.oncantuse ]](var_00);
		}
	}
}

//Function Number: 39
getearliestclaimplayer()
{
	var_00 = self.claimteam;
	if(maps\mp\_utility::isreallyalive(self.claimplayer))
	{
		var_01 = self.claimplayer;
	}
	else
	{
		var_01 = undefined;
	}

	if(self.touchlist[var_00].size > 0)
	{
		var_02 = undefined;
		var_03 = getarraykeys(self.touchlist[var_00]);
		for(var_04 = 0;var_04 < var_03.size;var_04++)
		{
			var_05 = self.touchlist[var_00][var_03[var_04]];
			if(maps\mp\_utility::isreallyalive(var_05.player) && !isdefined(var_02) || var_05.starttime < var_02)
			{
				var_01 = var_05.player;
				var_02 = var_05.starttime;
			}
		}
	}

	return var_01;
}

//Function Number: 40
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
			var_00 = getearliestclaimplayer();
			if(isdefined(self.onenduse))
			{
				self [[ self.onenduse ]](getclaimteam(),var_00,isdefined(var_00));
			}

			if(isdefined(var_00) && isdefined(self.onuse))
			{
				self [[ self.onuse ]](var_00);
			}

			if(!self.mustmaintainclaim)
			{
				setclaimteam("none");
				self.claimplayer = undefined;
			}
		}

		if(self.claimteam != "none")
		{
			if(self.usetime && !self.mustmaintainclaim || getownerteam() != getclaimteam())
			{
				if(!self.numtouching[self.claimteam])
				{
					if(isdefined(self.onenduse))
					{
						self [[ self.onenduse ]](getclaimteam(),self.claimplayer,0);
					}

					setclaimteam("none");
					self.claimplayer = undefined;
				}
				else
				{
					self.curprogress = self.curprogress + 50 * self.userate;
					if(self.curprogress <= 0)
					{
						self.curprogress = self.curprogress * -1;
						self.lastclaimteam = self.claimteam;
						updateuserate();
					}

					if(isdefined(self.onuseupdate))
					{
						self [[ self.onuseupdate ]](getclaimteam(),self.curprogress / self.usetime,50 * self.userate / self.usetime);
					}
				}
			}
			else if(!self.mustmaintainclaim)
			{
				if(isdefined(self.onuse))
				{
					self [[ self.onuse ]](self.claimplayer);
				}

				if(!self.mustmaintainclaim)
				{
					setclaimteam("none");
					self.claimplayer = undefined;
				}
			}
			else if(!self.numtouching[self.claimteam])
			{
				if(isdefined(self.onunoccupied))
				{
					self [[ self.onunoccupied ]]();
				}

				setclaimteam("none");
				self.claimplayer = undefined;
			}
			else if(self.cancontestclaim)
			{
				var_01 = getnumtouchingexceptteam(self.claimteam);
				if(var_01 > 0)
				{
					if(isdefined(self.oncontested))
					{
						self [[ self.oncontested ]]();
					}

					setclaimteam("none");
					self.claimplayer = undefined;
				}
			}
		}
		else if(self.mustmaintainclaim && getownerteam() != "none")
		{
			if(!self.numtouching[getownerteam()])
			{
				if(isdefined(self.onunoccupied))
				{
					self [[ self.onunoccupied ]]();
				}
			}
			else if(self.cancontestclaim && self.lastclaimteam != "none" && self.numtouching[self.lastclaimteam])
			{
				var_01 = getnumtouchingexceptteam(self.lastclaimteam);
				if(var_01 == 0)
				{
					if(isdefined(self.onuncontested))
					{
						self [[ self.onuncontested ]](self.lastclaimteam);
					}
				}
			}
		}

		wait(0.05);
		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	}
}

//Function Number: 41
canclaim(param_00)
{
	if(isdefined(self.carrier))
	{
		return 0;
	}

	if(self.cancontestclaim)
	{
		var_01 = getnumtouchingexceptteam(param_00.pers["team"]);
		if(var_01 != 0)
		{
			return 0;
		}
	}

	if(checkkeyobject(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 42
proxtriggerthink()
{
	level endon("game_ended");
	self endon("deleted");
	var_00 = self.entnum;
	for(;;)
	{
		self.trigger waittill("trigger",var_01);
		if(!maps\mp\_utility::isreallyalive(var_01))
		{
			continue;
		}

		if(!maps\mp\_utility::isgameparticipant(var_01))
		{
			continue;
		}

		if(isdefined(self.carrier))
		{
			continue;
		}

		if(var_01 maps\mp\_utility::isusingremote() || isdefined(var_01.spawningafterremotedeath) || var_01 maps\mp\_utility::isinremotetransition())
		{
			continue;
		}

		if(isdefined(var_01.classname) && var_01.classname == "script_vehicle")
		{
			continue;
		}

		if(!isdefined(var_01.initialized_gameobject_vars))
		{
			continue;
		}

		if(isdefined(self.nextusetime) && self.nextusetime > gettime())
		{
			continue;
		}

		if(isdefined(self.canuseobject) && ![[ self.canuseobject ]](var_01))
		{
			continue;
		}

		if(caninteractwith(var_01.pers["team"],var_01) && self.claimteam == "none")
		{
			if(canclaim(var_01))
			{
				if(!proxtriggerlos(var_01,self.visuals))
				{
					continue;
				}

				setclaimteam(var_01.pers["team"]);
				self.claimplayer = var_01;
				var_02 = getrelativeteam(var_01.pers["team"]);
				if(isdefined(self.teamusetimes[var_02]))
				{
					self.usetime = self.teamusetimes[var_02];
				}

				if(self.usetime && isdefined(self.onbeginuse))
				{
					self [[ self.onbeginuse ]](self.claimplayer);
				}
			}
			else if(isdefined(self.oncantuse))
			{
				self [[ self.oncantuse ]](var_01);
			}
		}

		if(maps\mp\_utility::isreallyalive(var_01) && !isdefined(var_01.touchtriggers[var_00]))
		{
			var_01 thread triggertouchthink(self);
		}
	}
}

//Function Number: 43
proxtriggerlos(param_00,param_01)
{
	if(!isdefined(self.requireslos) || !self.requireslos)
	{
		return 1;
	}

	var_02 = [32,16,0];
	var_03 = undefined;
	if(isdefined(param_01) && param_01.size)
	{
		if(param_01.size > 1)
		{
		}

		var_03 = param_01[0];
	}

	var_04 = param_00.origin - self.trigger.origin;
	var_04 = (var_04[0],var_04[1],0);
	var_04 = vectornormalize(var_04);
	var_04 = var_04 * 5;
	foreach(var_06 in var_02)
	{
		var_07 = param_00 geteye();
		var_08 = self.trigger.origin + var_04 + (0,0,var_06);
		var_09 = bullettrace(var_07,var_08,0,var_03,0,0,0,0,1,0,0);
		if(var_09["fraction"] == 1)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 44
setclaimteam(param_00)
{
	if(self.keepprogress)
	{
		if(self.lastclaimteam == "none")
		{
			self.lastclaimteam = param_00;
		}

		self.claimteam = param_00;
	}
	else
	{
		if(self.claimteam == "none" && gettime() - self.lastclaimtime > 1000)
		{
			self.curprogress = 0;
		}
		else if(param_00 != "none" && param_00 != self.lastclaimteam)
		{
			self.curprogress = 0;
		}

		self.lastclaimteam = self.claimteam;
	}

	self.lastclaimtime = gettime();
	self.claimteam = param_00;
	updateuserate();
}

//Function Number: 45
getclaimteam()
{
	return self.claimteam;
}

//Function Number: 46
triggertouchthink(param_00)
{
	if(isdefined(level.ishorde) && level.ishorde)
	{
		level endon("game_ended");
		param_00 endon("deleted");
	}

	var_01 = self.pers["team"];
	param_00.numtouching[var_01]++;
	var_02 = self.guid;
	var_03 = spawnstruct();
	var_03.player = self;
	var_03.starttime = gettime();
	param_00.touchlist[var_01][var_02] = var_03;
	if(!isdefined(param_00.nousebar))
	{
		param_00.nousebar = 0;
	}

	self.touchtriggers[param_00.entnum] = param_00.trigger;
	param_00 updateuserate();
	while(maps\mp\_utility::isreallyalive(self) && isdefined(param_00.trigger) && self istouching(param_00.trigger) || isboostingabovetriggerradius(param_00.trigger) && !level.gameended)
	{
		if(isplayer(self) && param_00.usetime)
		{
			updateuiprogress(param_00,1);
			updateproxbar(param_00,0);
		}

		wait(0.05);
	}

	if(isdefined(self) && isdefined(self.touchtriggers))
	{
		if(isplayer(self) && param_00.usetime)
		{
			updateuiprogress(param_00,0);
			updateproxbar(param_00,1);
		}

		self.touchtriggers[param_00.entnum] = undefined;
	}

	if(level.gameended)
	{
		return;
	}

	param_00.touchlist[var_01][var_02] = undefined;
	param_00.numtouching[var_01]--;
	param_00 updateuserate();
}

//Function Number: 47
isboostingabovetriggerradius(param_00)
{
	if(!isdefined(level.allowboostingabovetriggerradius) || !level.allowboostingabovetriggerradius)
	{
		return 0;
	}

	if(!maps\mp\_utility::isaugmentedgamemode())
	{
		return 0;
	}

	if(!self ishighjumping())
	{
		return 0;
	}

	var_01 = distance2dsquared(self.origin,param_00.origin);
	if(var_01 < param_00.radius * param_00.radius)
	{
		return 1;
	}

	return 0;
}

//Function Number: 48
updateproxbar(param_00,param_01)
{
	var_02 = self.pers["team"];
	if(param_01 || !param_00 caninteractwith(var_02) || var_02 != param_00.claimteam || param_00.nousebar)
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
		self.proxbar.lastuserate = undefined;
		self.proxbar.lasthostmigrationstate = 0;
	}

	if(self.proxbar.hidden)
	{
		self.proxbar maps\mp\gametypes\_hud_util::showelem();
		self.proxbar.lastuserate = undefined;
		self.proxbar.lasthostmigrationstate = 0;
	}

	if(!isdefined(self.proxbartext))
	{
		self.proxbartext = maps\mp\gametypes\_hud_util::createprimaryprogressbartext();
		var_03 = param_00 getrelativeteam(var_02);
		if(isdefined(param_00.teamusetexts[var_03]))
		{
			self.proxbartext settext(param_00.teamusetexts[var_03]);
		}
		else
		{
			self.proxbartext settext(param_00.usetext);
		}
	}

	if(self.proxbartext.hidden)
	{
		self.proxbartext maps\mp\gametypes\_hud_util::showelem();
		var_03 = param_00 getrelativeteam(var_02);
		if(isdefined(param_00.teamusetexts[var_03]))
		{
			self.proxbartext settext(param_00.teamusetexts[var_03]);
		}
		else
		{
			self.proxbartext settext(param_00.usetext);
		}
	}

	if(!isdefined(self.proxbar.lastuserate) || self.proxbar.lastuserate != param_00.userate || self.proxbar.lasthostmigrationstate != isdefined(level.hostmigrationtimer))
	{
		if(param_00.curprogress > param_00.usetime)
		{
			param_00.curprogress = param_00.usetime;
		}

		var_04 = param_00.curprogress / param_00.usetime;
		var_05 = 1000 / param_00.usetime * param_00.userate;
		if(isdefined(level.hostmigrationtimer))
		{
			var_05 = 0;
		}

		if(param_00.keepprogress && !var_04 && var_05 < 0)
		{
			var_05 = 0;
		}

		self.proxbar maps\mp\gametypes\_hud_util::updatebar(var_04,var_05);
		self.proxbar.lastuserate = param_00.userate;
		self.proxbar.lasthostmigrationstate = isdefined(level.hostmigrationtimer);
	}
}

//Function Number: 49
getnumtouchingexceptteam(param_00)
{
	return self.numtouching[maps\mp\_utility::getotherteam(param_00)];
}

//Function Number: 50
updateuiprogress(param_00,param_01)
{
	var_02 = level.gametype;
	var_03 = param_00.id;
	var_04 = 0;
	if(!isdefined(level.hostmigrationtimer))
	{
		if(param_00.curprogress > param_00.usetime)
		{
			param_00.curprogress = param_00.usetime;
		}

		var_05 = param_00.curprogress / param_00.usetime;
		if(var_02 == "dom" && isdefined(var_03) && var_03 == "domFlag")
		{
			if(param_01 && isdefined(param_00.stalemate) && param_00.stalemate)
			{
				var_06 = param_00 getearliestclaimplayer();
				var_04 = 1;
				if(isdefined(var_06) && var_06.team != self.team)
				{
					var_05 = 0.01;
				}
			}

			if(!param_01)
			{
				var_05 = 0.01;
			}

			if(var_05 != 0)
			{
				self setclientomnvar("ui_capture_progress",var_05);
			}
		}

		if((var_02 == "sd" || var_02 == "sr") && isdefined(var_03) && var_03 == "bombZone" || var_03 == "defuseObject")
		{
			if(!param_01)
			{
				var_05 = 0;
			}

			var_05 = max(0.01,var_05);
			if(var_05 != 0)
			{
				self setclientomnvar("ui_capture_progress",var_05);
			}
		}

		if(var_02 == "twar" && isdefined(var_03) && var_03 == "twarZone")
		{
			if(!param_01)
			{
				var_05 = 0;
			}

			var_05 = max(0.01,var_05);
			if(var_05 != 0)
			{
				self setclientomnvar("ui_capture_progress",var_05);
			}
		}

		if(var_02 == "zombies" && isdefined(var_03) && var_03 == "defuseObject")
		{
			if(!param_01)
			{
				var_05 = 0;
			}

			var_05 = max(0.01,var_05);
			if(var_05 != 0)
			{
				self setclientomnvar("ui_capture_progress",var_05);
			}
		}
	}

	if(var_02 == "dom" && isdefined(var_03) && var_03 == "domFlag")
	{
		if(param_01 && param_00.ownerteam == self.team)
		{
			param_01 = 0;
		}

		if(!param_01)
		{
			self setclientomnvar("ui_capture_icon",0);
		}
		else if(!var_04)
		{
			if(param_00.label == "_a")
			{
				self setclientomnvar("ui_capture_icon",1);
			}
			else if(param_00.label == "_b")
			{
				self setclientomnvar("ui_capture_icon",2);
			}
			else if(param_00.label == "_c")
			{
				self setclientomnvar("ui_capture_icon",3);
			}
		}
		else
		{
			self setclientomnvar("ui_capture_icon",4);
		}
	}

	if((var_02 == "sd" || var_02 == "sr") && isdefined(var_03) && var_03 == "bombZone" || var_03 == "defuseObject")
	{
		if(!param_01)
		{
			self setclientomnvar("ui_capture_icon",0);
		}
		else if(param_00 isfriendlyteam(self.pers["team"]))
		{
			self setclientomnvar("ui_capture_icon",2);
		}
		else
		{
			self setclientomnvar("ui_capture_icon",1);
		}
	}

	if(var_02 == "twar" && isdefined(var_03) && var_03 == "twarZone")
	{
		if(!param_01 || isdefined(param_00.stalemate) && param_00.stalemate)
		{
			self setclientomnvar("ui_capture_icon",0);
		}
		else
		{
			self setclientomnvar("ui_capture_icon",1);
		}
	}

	if(var_02 == "zombies" && isdefined(var_03) && var_03 == "defuseObject")
	{
		if(!param_01)
		{
			self setclientomnvar("ui_capture_icon",0);
			return;
		}

		self setclientomnvar("ui_capture_icon",1);
	}
}

//Function Number: 51
updateuserate()
{
	if(isdefined(self.onupdateuserate))
	{
		self [[ self.onupdateuserate ]]();
		return;
	}

	updateuserate_internal();
}

//Function Number: 52
updateuserate_internal()
{
	var_00 = self.numtouching[self.claimteam];
	var_01 = 0;
	var_02 = 0;
	if(level.multiteambased)
	{
		foreach(var_04 in level.teamnamelist)
		{
			if(self.claimteam != var_04)
			{
				var_01 = var_01 + self.numtouching[var_04];
			}
		}
	}
	else
	{
		if(self.claimteam != "axis")
		{
			var_01 = var_01 + self.numtouching["axis"];
		}

		if(self.claimteam != "allies")
		{
			var_01 = var_01 + self.numtouching["allies"];
		}
	}

	foreach(var_07 in self.touchlist[self.claimteam])
	{
		if(!isdefined(var_07.player))
		{
			continue;
		}

		if(var_07.player.pers["team"] != self.claimteam)
		{
			continue;
		}

		if(var_07.player.objectivescaler == 1)
		{
			continue;
		}

		var_00 = var_00 * var_07.player.objectivescaler;
		var_02 = var_07.player.objectivescaler;
	}

	self.userate = 0;
	self.stalemate = var_00 && var_01;
	if(var_00 && !var_01)
	{
		self.userate = min(var_00,4);
	}

	if(isdefined(self.isarena) && self.isarena && var_02 != 0)
	{
		self.userate = 1 * var_02;
	}
	else if(isdefined(self.isarena) && self.isarena)
	{
		self.userate = 1;
	}

	if(self.keepprogress && self.lastclaimteam != self.claimteam)
	{
		self.userate = self.userate * -1;
	}
}

//Function Number: 53
attachusemodel()
{
	self endon("death");
	self endon("disconnect");
	self endon("done_using");
	wait(0.7);
	self attach("npc_search_dstry_bomb","tag_inhand",1);
	self.attachedusemodel = "npc_search_dstry_bomb";
}

//Function Number: 54
useholdthink(param_00)
{
	param_00 notify("use_hold");
	if(isplayer(param_00))
	{
		param_00 playerlinkto(self.trigger);
	}
	else
	{
		param_00 linkto(self.trigger);
	}

	param_00 playerlinkedoffsetenable();
	param_00 clientclaimtrigger(self.trigger);
	param_00.claimtrigger = self.trigger;
	var_01 = self.useweapon;
	var_02 = param_00 getcurrentweapon();
	if(isdefined(var_01))
	{
		if(var_02 == var_01)
		{
			var_02 = param_00.lastnonuseweapon;
		}

		param_00.lastnonuseweapon = var_02;
		param_00 maps\mp\_utility::_giveweapon(var_01);
		param_00 setweaponammostock(var_01,0);
		param_00 setweaponammoclip(var_01,0);
		param_00 switchtoweaponimmediate(var_01);
		if(!isdefined(self.attachdefault3pmodel) || self.attachdefault3pmodel == 1)
		{
			param_00 thread attachusemodel();
		}
	}
	else
	{
		param_00 common_scripts\utility::_disableweapon();
	}

	self.curprogress = 0;
	self.inuse = 1;
	self.userate = 0;
	if(isplayer(param_00))
	{
		param_00 thread personalusebar(self);
	}

	var_03 = useholdthinkloop(param_00,var_02);
	if(isdefined(param_00))
	{
		param_00 detachusemodels();
		param_00 notify("done_using");
	}

	if(isdefined(var_01) && isdefined(param_00))
	{
		param_00 thread takeuseweapon(var_01);
	}

	if(isdefined(var_03) && var_03)
	{
		return 1;
	}

	if(isdefined(param_00))
	{
		param_00.claimtrigger = undefined;
		if(isdefined(var_01))
		{
			if(var_02 != "none")
			{
				param_00 maps\mp\_utility::switch_to_last_weapon(var_02);
			}
			else
			{
				param_00 takeweapon(var_01);
			}
		}
		else
		{
			param_00 common_scripts\utility::_enableweapon();
		}

		param_00 unlink();
		if(!maps\mp\_utility::isreallyalive(param_00))
		{
			param_00.killedinuse = 1;
		}
	}

	self.inuse = 0;
	self.trigger releaseclaimedtrigger();
	return 0;
}

//Function Number: 55
detachusemodels()
{
	if(isdefined(self.attachedusemodel))
	{
		self detach(self.attachedusemodel,"tag_inhand");
		self.attachedusemodel = undefined;
	}
}

//Function Number: 56
takeuseweapon(param_00)
{
	self endon("use_hold");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	while(self getcurrentweapon() == param_00 && !isdefined(self.throwinggrenade))
	{
		wait(0.05);
	}

	self takeweapon(param_00);
}

//Function Number: 57
usetest(param_00,param_01,param_02,param_03)
{
	if(!maps\mp\_utility::isreallyalive(param_00))
	{
		return 0;
	}

	if(!param_00 istouching(self.trigger))
	{
		return 0;
	}

	if(!param_00 usebuttonpressed())
	{
		return 0;
	}

	if(isdefined(param_00.throwinggrenade))
	{
		return 0;
	}

	if(param_00 meleebuttonpressed())
	{
		return 0;
	}

	if(self.curprogress >= self.usetime)
	{
		return 0;
	}

	if(!self.userate && !param_01)
	{
		return 0;
	}

	if(param_01 && param_02 > param_03)
	{
		return 0;
	}

	return 1;
}

//Function Number: 58
useholdthinkloop(param_00,param_01)
{
	level endon("game_ended");
	self endon("disabled");
	param_00 endon("stop_useHoldThinkLoop");
	var_02 = self.useweapon;
	var_03 = 1;
	var_04 = 0;
	var_05 = 1.5;
	while(usetest(param_00,var_03,var_04,var_05))
	{
		var_04 = var_04 + 0.05;
		if(!isdefined(var_02) || param_00 getcurrentweapon() == var_02)
		{
			self.curprogress = self.curprogress + 50 * self.userate;
			self.userate = 1 * param_00.objectivescaler;
			var_03 = 0;
		}
		else
		{
			self.userate = 0;
		}

		if(self.curprogress >= self.usetime)
		{
			self.inuse = 0;
			param_00 clientreleasetrigger(self.trigger);
			param_00.claimtrigger = undefined;
			if(isdefined(var_02))
			{
				param_00 setweaponammostock(var_02,1);
				param_00 setweaponammoclip(var_02,1);
				if(param_01 != "none")
				{
					param_00 maps\mp\_utility::switch_to_last_weapon(param_01);
				}
				else
				{
					param_00 takeweapon(var_02);
				}
			}
			else
			{
				param_00 common_scripts\utility::_enableweapon();
			}

			param_00 unlink();
			return maps\mp\_utility::isreallyalive(param_00);
		}

		wait(0.05);
		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	}

	return 0;
}

//Function Number: 59
personalusebar(param_00)
{
	self endon("disconnect");
	var_01 = undefined;
	if(!isdefined(param_00.nousebar) || !param_00.nousebar)
	{
		var_01 = maps\mp\gametypes\_hud_util::createprimaryprogressbar();
	}

	var_02 = undefined;
	if(isdefined(var_01) && isdefined(param_00.usetext))
	{
		var_02 = maps\mp\gametypes\_hud_util::createprimaryprogressbartext();
		var_02 settext(param_00.usetext);
	}

	var_03 = -1;
	var_04 = isdefined(level.hostmigrationtimer);
	while(maps\mp\_utility::isreallyalive(self) && param_00.inuse && !level.gameended)
	{
		if(var_03 != param_00.userate || var_04 != isdefined(level.hostmigrationtimer))
		{
			if(param_00.curprogress > param_00.usetime)
			{
				param_00.curprogress = param_00.usetime;
			}

			var_05 = param_00.curprogress / param_00.usetime;
			var_06 = 1000 / param_00.usetime * param_00.userate;
			if(isdefined(level.hostmigrationtimer))
			{
				var_06 = 0;
			}

			if(isdefined(var_01))
			{
				var_01 maps\mp\gametypes\_hud_util::updatebar(var_05,var_06);
				if(!param_00.userate)
				{
					var_01 maps\mp\gametypes\_hud_util::hideelem();
					if(isdefined(var_02))
					{
						var_02 maps\mp\gametypes\_hud_util::hideelem();
					}
				}
				else
				{
					var_01 maps\mp\gametypes\_hud_util::showelem();
					if(isdefined(var_02))
					{
						var_02 maps\mp\gametypes\_hud_util::showelem();
					}
				}
			}
		}

		var_03 = param_00.userate;
		var_04 = isdefined(level.hostmigrationtimer);
		updateuiprogress(param_00,1);
		wait(0.05);
	}

	updateuiprogress(param_00,0);
	if(isdefined(var_01))
	{
		var_01 maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(var_02))
	{
		var_02 maps\mp\gametypes\_hud_util::destroyelem();
	}
}

//Function Number: 60
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

//Function Number: 61
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

	updateworldicon("mlg",1);
}

//Function Number: 62
updateworldicon(param_00,param_01)
{
	if(!isdefined(self.worldicons[param_00]))
	{
		param_01 = 0;
	}

	var_02 = getupdateteams(param_00);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_04 = "objpoint_" + var_02[var_03] + "_" + self.entnum;
		var_05 = maps\mp\gametypes\_objpoints::getobjpointbyname(var_04);
		var_05 notify("stop_flashing_thread");
		var_05 thread maps\mp\gametypes\_objpoints::stopflashing();
		if(param_01)
		{
			var_05 setshader(self.worldicons[param_00],level.objpointsize,level.objpointsize);
			var_05 fadeovertime(0.05);
			var_05.alpha = var_05.basealpha;
			var_05.isshown = 1;
			if(isdefined(self.compassicons[param_00]))
			{
				var_05 setwaypoint(1,1);
			}
			else
			{
				var_05 setwaypoint(1,0);
			}

			if(self.type == "carryObject")
			{
				if(isdefined(self.carrier) && !shouldpingobject(param_00))
				{
					var_05 settargetent(self.carrier);
				}
				else if(!isdefined(self.carrier) && isdefined(self.objectiveonvisuals) && self.objectiveonvisuals)
				{
					var_05 settargetent(self.visuals[0]);
				}
				else
				{
					var_05 cleartargetent();
				}
			}
		}
		else
		{
			var_05 fadeovertime(0.05);
			var_05.alpha = 0;
			var_05.isshown = 0;
			var_05 cleartargetent();
		}

		var_05 thread hideworldiconongameend();
	}
}

//Function Number: 63
hideworldiconongameend()
{
	self notify("hideWorldIconOnGameEnd");
	self endon("hideWorldIconOnGameEnd");
	self endon("death");
	level waittill("game_ended");
	if(isdefined(self))
	{
		self.alpha = 0;
	}
}

//Function Number: 64
updatetimer(param_00,param_01)
{
}

//Function Number: 65
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

	updatecompassicon("mlg",1);
}

//Function Number: 66
updatecompassicon(param_00,param_01)
{
	if(!isdefined(self.compassicons))
	{
		return;
	}

	var_02 = getupdateteams(param_00);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_04 = param_01;
		if(!var_04 && shouldshowcompassduetoradar(var_02[var_03]))
		{
			var_04 = 1;
		}

		var_05 = self.objidallies;
		if(var_02[var_03] == "axis")
		{
			var_05 = self.objidaxis;
		}

		if(var_02[var_03] == "mlg")
		{
			var_05 = self.objidmlgspectator;
		}

		if(!isdefined(self.compassicons[param_00]) || !var_04)
		{
			objective_state(var_05,"invisible");
			continue;
		}

		objective_icon(var_05,self.compassicons[param_00]);
		objective_state(var_05,"active");
		if(self.type == "carryObject")
		{
			if(maps\mp\_utility::isreallyalive(self.carrier) && !shouldpingobject(param_00))
			{
				objective_onentity(var_05,self.carrier);
				continue;
			}

			if(isdefined(self.objectiveonvisuals) && self.objectiveonvisuals)
			{
				objective_onentity(var_05,self.visuals[0]);
				continue;
			}

			objective_position(var_05,self.curorigin);
		}
	}
}

//Function Number: 67
shouldpingobject(param_00)
{
	if(param_00 == "friendly" && self.objidpingfriendly)
	{
		return 1;
	}
	else if(param_00 == "enemy" && self.objidpingenemy)
	{
		return 1;
	}

	return 0;
}

//Function Number: 68
getupdateteams(param_00)
{
	var_01 = [];
	if(param_00 == "friendly")
	{
		if(isfriendlyteam("allies"))
		{
			var_01[var_01.size] = "allies";
		}

		if(isfriendlyteam("axis"))
		{
			var_01[var_01.size] = "axis";
		}
	}
	else if(param_00 == "enemy")
	{
		if(!isfriendlyteam("allies"))
		{
			var_01[var_01.size] = "allies";
		}

		if(!isfriendlyteam("axis"))
		{
			var_01[var_01.size] = "axis";
		}
	}
	else if(param_00 == "mlg")
	{
		var_01[var_01.size] = "mlg";
	}

	return var_01;
}

//Function Number: 69
shouldshowcompassduetoradar(param_00)
{
	if(param_00 == "mlg")
	{
		return 0;
	}

	if(!isdefined(self.carrier))
	{
		return 0;
	}

	if(self.carrier maps\mp\_utility::_hasperk("specialty_radarimmune"))
	{
		return 0;
	}

	return getteamradar(param_00);
}

//Function Number: 70
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

//Function Number: 71
setownerteam(param_00)
{
	self.ownerteam = param_00;
	updatetrigger();
	updatecompassicons();
	updateworldicons();
}

//Function Number: 72
getownerteam()
{
	return self.ownerteam;
}

//Function Number: 73
setusetime(param_00)
{
	self.usetime = int(param_00 * 1000);
}

//Function Number: 74
setusetext(param_00)
{
	self.usetext = param_00;
}

//Function Number: 75
setteamusetime(param_00,param_01)
{
	self.teamusetimes[param_00] = int(param_01 * 1000);
}

//Function Number: 76
setteamusetext(param_00,param_01)
{
	self.teamusetexts[param_00] = param_01;
}

//Function Number: 77
setusehinttext(param_00)
{
	self.trigger sethintstring(param_00);
}

//Function Number: 78
allowcarry(param_00)
{
	self.interactteam = param_00;
}

//Function Number: 79
allowuse(param_00)
{
	self.interactteam = param_00;
	updatetrigger();
}

//Function Number: 80
setvisibleteam(param_00)
{
	self.visibleteam = param_00;
	updatecompassicons();
	updateworldicons();
}

//Function Number: 81
setmodelvisibility(param_00)
{
	if(param_00)
	{
		for(var_01 = 0;var_01 < self.visuals.size;var_01++)
		{
			self.visuals[var_01] show();
			if(self.visuals[var_01].classname == "script_brushmodel" || self.visuals[var_01].classname == "script_model")
			{
				foreach(var_03 in level.players)
				{
					if(var_03 istouching(self.visuals[var_01]))
					{
						var_03 maps\mp\_utility::_suicide();
					}
				}

				self.visuals[var_01] thread makesolid();
			}
		}

		return;
	}

	for(var_01 = 0;var_01 < self.visuals.size;var_01++)
	{
		self.visuals[var_01] hide();
		if(self.visuals[var_01].classname == "script_brushmodel" || self.visuals[var_01].classname == "script_model")
		{
			self.visuals[var_01] notify("changing_solidness");
			self.visuals[var_01] notsolid();
		}
	}
}

//Function Number: 82
makesolid()
{
	self endon("death");
	self notify("changing_solidness");
	self endon("changing_solidness");
	for(;;)
	{
		for(var_00 = 0;var_00 < level.players.size;var_00++)
		{
			if(level.players[var_00] istouching(self))
			{
				break;
			}
		}

		if(var_00 == level.players.size)
		{
			self solid();
			break;
		}

		wait(0.05);
	}
}

//Function Number: 83
setcarriervisible(param_00)
{
	self.carriervisible = param_00;
}

//Function Number: 84
setcanuse(param_00)
{
	self.useteam = param_00;
}

//Function Number: 85
set2dicon(param_00,param_01)
{
	self.compassicons[param_00] = param_01;
	updatecompassicons();
}

//Function Number: 86
set3dicon(param_00,param_01)
{
	self.worldicons[param_00] = param_01;
	updateworldicons();
}

//Function Number: 87
set3duseicon(param_00,param_01)
{
	self.worlduseicons[param_00] = param_01;
}

//Function Number: 88
setcarryicon(param_00)
{
	self.carryicon = param_00;
}

//Function Number: 89
disableobject()
{
	self notify("disabled");
	if(self.type == "carryObject")
	{
		if(isdefined(self.carrier))
		{
			self.carrier takeobject(self);
		}

		for(var_00 = 0;var_00 < self.visuals.size;var_00++)
		{
			self.visuals[var_00] hide();
		}
	}

	self.trigger common_scripts\utility::trigger_off();
	setvisibleteam("none");
}

//Function Number: 90
enableobject()
{
	if(self.type == "carryObject")
	{
		for(var_00 = 0;var_00 < self.visuals.size;var_00++)
		{
			self.visuals[var_00] show();
		}
	}

	self.trigger common_scripts\utility::trigger_on();
	setvisibleteam("any");
}

//Function Number: 91
getrelativeteam(param_00)
{
	if(param_00 == self.ownerteam)
	{
		return "friendly";
	}

	return "enemy";
}

//Function Number: 92
isfriendlyteam(param_00)
{
	var_01 = getclaimteam();
	if(self.ownerteam == "neutral" && var_01 != "none" && var_01 != param_00)
	{
		return 1;
	}

	if(self.ownerteam == "any")
	{
		return 1;
	}

	if(self.ownerteam == param_00)
	{
		return 1;
	}

	return 0;
}

//Function Number: 93
caninteractwith(param_00,param_01)
{
	switch(self.interactteam)
	{
		case "none":
			return 0;

		case "any":
			return 1;

		case "friendly":
			if(param_00 == self.ownerteam)
			{
				return 1;
			}
			else
			{
				return 0;
			}
	
			break;

		case "enemy":
			if(param_00 != self.ownerteam)
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

//Function Number: 94
isteam(param_00)
{
	if(param_00 == "neutral")
	{
		return 1;
	}

	if(param_00 == "allies")
	{
		return 1;
	}

	if(param_00 == "axis")
	{
		return 1;
	}

	if(param_00 == "any")
	{
		return 1;
	}

	if(param_00 == "none")
	{
		return 1;
	}

	foreach(var_02 in level.teamnamelist)
	{
		if(param_00 == var_02)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 95
isrelativeteam(param_00)
{
	if(param_00 == "friendly")
	{
		return 1;
	}

	if(param_00 == "enemy")
	{
		return 1;
	}

	if(param_00 == "any")
	{
		return 1;
	}

	if(param_00 == "none")
	{
		return 1;
	}

	return 0;
}

//Function Number: 96
getenemyteam(param_00)
{
	if(level.multiteambased)
	{
	}

	if(param_00 == "neutral")
	{
		return "none";
	}

	if(param_00 == "allies")
	{
		return "axis";
	}

	return "allies";
}

//Function Number: 97
getnextobjid()
{
	if(!isdefined(level.reclaimedreservedobjectives) || level.reclaimedreservedobjectives.size < 1)
	{
		var_00 = level.numgametypereservedobjectives;
		level.numgametypereservedobjectives++;
	}
	else
	{
		var_00 = level.reclaimedreservedobjectives[level.reclaimedreservedobjectives.size - 1];
		level.reclaimedreservedobjectives[level.reclaimedreservedobjectives.size - 1] = undefined;
	}

	if(var_00 > 31)
	{
		if(isdefined(level.ishorde) && level.ishorde)
		{
		}

		var_00 = 31;
	}

	return var_00;
}

//Function Number: 98
getlabel()
{
	var_00 = self.trigger.script_label;
	if(!isdefined(var_00))
	{
		var_00 = "";
		return var_00;
	}

	if(var_00[0] != "_")
	{
		return "_" + var_00;
	}

	return var_00;
}

//Function Number: 99
initializetagpathvariables()
{
	self.nearest_node = undefined;
	self.calculated_nearest_node = 0;
	self.on_path_grid = undefined;
}

//Function Number: 100
mustmaintainclaim(param_00)
{
	self.mustmaintainclaim = param_00;
}

//Function Number: 101
cancontestclaim(param_00)
{
	self.cancontestclaim = param_00;
}

//Function Number: 102
fake_loot_dispensation_logic()
{
	self endon("disconnect");
	level endon("game_ended");
	var_00 = 120;
	var_01 = randomintrange(30,90);
	var_00 = var_00 + var_01;
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_00);
	self waittill("show_loot_notification");
}