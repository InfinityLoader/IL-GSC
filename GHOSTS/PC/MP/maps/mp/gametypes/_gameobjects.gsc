/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_gameobjects.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 94
 * Decompile Time: 1728 ms
 * Timestamp: 10/27/2023 1:18:18 AM
*******************************************************************/

//Function Number: 1
func_4FDD(param_00)
{
	param_00[param_00.size] = "airdrop_pallet";
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
				var_01[var_02] delete();
			}
		}
	}
}

//Function Number: 2
func_44DF()
{
	level.numgametypereservedobjectives = 0;
	level thread func_595D();
}

//Function Number: 3
func_595D()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread onplayerspawned();
		var_00 thread func_5918();
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

		func_4589();
	}
}

//Function Number: 5
func_4589()
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
		self.carryobject thread func_7025();
	}
}

//Function Number: 7
func_5918()
{
	level endon("game_ended");
	self waittill("disconnect");
	if(isdefined(self.carryobject))
	{
		self.carryobject thread func_7025();
	}
}

//Function Number: 8
func_20CC(param_00,param_01,param_02,param_03)
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
	if(!isdefined(param_01.linktoenabledflag))
	{
		param_01.linktoenabledflag = 1;
		param_01 enablelinkto();
	}

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
	var_04.objidpingfriendly = 0;
	var_04.objidpingenemy = 0;
	foreach(var_07 in level.teamnamelist)
	{
		var_04.teamobjids[var_07] = getnextobjid();
		objective_add(var_04.teamobjids[var_07],"invisible",var_04.curorigin);
		objective_team(var_04.teamobjids[var_07],var_07);
		var_04.objpoints[var_07] = maps\mp\gametypes\_objpoints::createteamobjpoint("objpoint_" + var_07 + "_" + var_04.entnum,var_04.curorigin + param_03,var_07,undefined);
		var_04.objpoints[var_07].alpha = 0;
	}

	var_04.carrier = undefined;
	var_04.isresetting = 0;
	var_04.interactteam = "none";
	var_04.allowweapons = 0;
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
		var_04.teamusetimes = [];
		var_04.teamusetexts = [];
		var_04.numtouching["neutral"] = 0;
		var_04.touchlist["neutral"] = [];
		var_04.numtouching["none"] = 0;
		var_04.touchlist["none"] = [];
		foreach(var_0A in level.teamnamelist)
		{
			var_04.numtouching[var_0A] = 0;
			var_04.touchlist[var_0A] = [];
		}

		var_04.claimteam = "none";
		var_04.claimplayer = undefined;
		var_04.lastclaimteam = "none";
		var_04.lastclaimtime = 0;
		var_04 thread carryobjectproxthink();
	}

	var_04 thread func_86D2();
	return var_04;
}

//Function Number: 9
carryobjectusethink()
{
	level endon("game_ended");
	for(;;)
	{
		self.trigger waittill("trigger",var_00);
		if(self.isresetting)
		{
			continue;
		}

		if(!maps\mp\_utility::func_4945(var_00))
		{
			continue;
		}

		if(!func_19CA(var_00.pers["team"]))
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

		if(var_00 maps\mp\_utility::func_4995())
		{
			continue;
		}

		func_7094(var_00);
	}
}

//Function Number: 10
carryobjectproxthink()
{
	thread carryobjectproxthinkdelayed();
}

//Function Number: 11
func_1A5D()
{
	level endon("game_ended");
	for(;;)
	{
		self.trigger waittill("trigger",var_00);
		if(self.isresetting)
		{
			continue;
		}

		if(!maps\mp\_utility::func_4945(var_00))
		{
			continue;
		}

		if(!func_19CA(var_00.pers["team"]))
		{
			continue;
		}

		if(!var_00.canpickupobject)
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

		func_7094(var_00);
	}
}

//Function Number: 12
carryobjectproxthinkdelayed()
{
	level endon("game_ended");
	thread func_622E();
	for(;;)
	{
		if(self.usetime && self.curprogress >= self.usetime)
		{
			self.curprogress = 0;
			var_00 = getearliestclaimplayer();
			if(isdefined(self.onenduse))
			{
				self [[ self.onenduse ]](func_3A53(),var_00,isdefined(var_00));
			}

			if(isdefined(var_00))
			{
				func_7094(var_00);
			}

			func_7002("none");
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
						self [[ self.onenduse ]](func_3A53(),self.claimplayer,0);
					}

					func_7002("none");
					self.claimplayer = undefined;
				}
				else
				{
					self.curprogress = self.curprogress + 50 * self.userate;
					if(isdefined(self.onuseupdate))
					{
						self [[ self.onuseupdate ]](func_3A53(),self.curprogress / self.usetime,50 * self.userate / self.usetime);
					}
				}
			}
			else
			{
				if(maps\mp\_utility::func_4945(self.claimplayer))
				{
					func_7094(self.claimplayer);
				}

				func_7002("none");
				self.claimplayer = undefined;
			}
		}

		wait(0.05);
		maps\mp\gametypes\_hostmigration::func_8BBA();
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
func_7094(param_00)
{
	if(isai(param_00) && isdefined(param_00.owner))
	{
	}

	if(isdefined(param_00.carryobject))
	{
		if(isdefined(self.onpickupfailed))
		{
			self [[ self.onpickupfailed ]](param_00);
		}
	}

	param_00 giveobject(self);
	func_6FF7(param_00);
	if(isdefined(self.trigger getlinkedparent()))
	{
		for(var_01 = 0;var_01 < self.visuals.size;var_01++)
		{
			self.visuals[var_01] unlink();
		}

		self.trigger unlink();
	}

	for(var_01 = 0;var_01 < self.visuals.size;var_01++)
	{
		self.visuals[var_01] hide();
	}

	self.trigger.origin = self.trigger.origin + (0,0,10000);
	self.trigger maps\mp\_movers::func_7C2C();
	self notify("pickup_object");
	if(isdefined(self.onpickup))
	{
		self [[ self.onpickup ]](param_00);
	}

	func_86DD();
	updateworldicons();
}

//Function Number: 15
func_86D2()
{
	level endon("game_ended");
	var_00 = 5;
	for(;;)
	{
		if(isdefined(self.carrier))
		{
			self.curorigin = self.carrier.origin + (0,0,75);
			foreach(var_02 in level.teamnamelist)
			{
				self.objpoints[var_02] maps\mp\gametypes\_objpoints::func_870A(self.curorigin);
			}

			foreach(var_02 in level.teamnamelist)
			{
				if((self.visibleteam == "friendly" || self.visibleteam == "any") && isfriendlyteam(var_02) && self.objidpingfriendly)
				{
					if(self.objpoints[var_02].isshown)
					{
						self.objpoints[var_02].alpha = self.objpoints[var_02].basealpha;
						self.objpoints[var_02] fadeovertime(var_00 + 1);
						self.objpoints[var_02].alpha = 0;
					}

					objective_position(self.teamobjids[var_02],self.curorigin);
				}
			}

			foreach(var_02 in level.teamnamelist)
			{
				if((self.visibleteam == "enemy" || self.visibleteam == "any") && !isfriendlyteam(var_02) && self.objidpingenemy)
				{
					if(self.objpoints[var_02].isshown)
					{
						self.objpoints[var_02].alpha = self.objpoints[var_02].basealpha;
						self.objpoints[var_02] fadeovertime(var_00 + 1);
						self.objpoints[var_02].alpha = 0;
					}

					objective_position(self.teamobjids[var_02],self.curorigin);
				}
			}

			maps\mp\_utility::wait_endon(var_00,"dropped","reset");
			continue;
		}

		self.curorigin = self.trigger.origin;
		foreach(var_02 in level.teamnamelist)
		{
			self.objpoints[var_02] maps\mp\gametypes\_objpoints::func_870A(self.curorigin + self.offset3d);
		}

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
	thread func_8212();
	if(!param_00.allowweapons)
	{
		common_scripts\utility::_disableweapon();
		thread manualdropthink();
	}

	if(isdefined(param_00.carryicon))
	{
		if(level.splitscreen)
		{
			self.carryicon = maps\mp\gametypes\_hud_util::func_20FC(param_00.carryicon,33,33);
			self.carryicon maps\mp\gametypes\_hud_util::func_70A4("BOTTOM RIGHT","BOTTOM RIGHT",-50,-78);
		}
		else
		{
			self.carryicon = maps\mp\gametypes\_hud_util::func_20FC(param_00.carryicon,50,50);
			self.carryicon maps\mp\gametypes\_hud_util::func_70A4("BOTTOM RIGHT","BOTTOM RIGHT",-50,-65);
		}

		self.carryicon.hidewheninmenu = 1;
		thread hidecarryiconongameend();
	}
}

//Function Number: 18
func_6686()
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

	func_1D37();
	updateworldicons();
	func_86DD();
	self.isresetting = 0;
}

//Function Number: 19
func_48D9()
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
func_70A9(param_00,param_01)
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
	func_1D37();
	updateworldicons();
	func_86DD();
	self.isresetting = 0;
}

//Function Number: 21
func_5967()
{
	if(isdefined(self.carryobject))
	{
		self.carryobject thread func_7025();
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
	param_00.carryobject func_6686();
}

//Function Number: 23
func_7025()
{
	self.isresetting = 1;
	self.resetnow = undefined;
	self notify("dropped");
	foreach(var_01 in self.visuals)
	{
		var_01.prev_contents = var_01 setcontents(0);
	}

	if(isdefined(self.carrier) && self.carrier.team != "spectator")
	{
		var_03 = playerphysicstrace(self.carrier.origin + (0,0,20),self.carrier.origin - (0,0,2000),0,self.carrier.body);
		var_04 = bullettrace(self.carrier.origin + (0,0,20),self.carrier.origin - (0,0,2000),0,self.carrier.body,1,0,1);
	}
	else
	{
		var_03 = playerphysicstrace(self.safeorigin + (0,0,20),self.safeorigin - (0,0,20),0,undefined);
		var_04 = bullettrace(self.safeorigin + (0,0,20),self.safeorigin - (0,0,20),0,undefined,1,0,1);
	}

	foreach(var_01 in self.visuals)
	{
		var_01 setcontents(var_01.prev_contents);
	}

	var_07 = self.carrier;
	var_08 = 0;
	if(isdefined(var_03))
	{
		var_09 = randomfloat(360);
		var_0A = var_03;
		if(var_04["fraction"] < 1 && distance(var_04["position"],var_03) < 10)
		{
			var_0B = (cos(var_09),sin(var_09),0);
			var_0B = vectornormalize(var_0B - var_04["normal"] * vectordot(var_0B,var_04["normal"]));
			var_0C = vectortoangles(var_0B);
		}
		else
		{
			var_0C = (0,var_0A,0);
		}

		for(var_0D = 0;var_0D < self.visuals.size;var_0D++)
		{
			self.visuals[var_0D].origin = var_0A;
			self.visuals[var_0D].angles = var_0C;
			self.visuals[var_0D] show();
		}

		self.trigger.origin = var_0A;
		self.curorigin = self.trigger.origin;
		var_0E = var_04["entity"];
		if(isdefined(var_0E) && isdefined(var_0E.owner))
		{
			var_0E = var_0E getlinkedparent();
		}

		if(isdefined(var_0E))
		{
			if(isdefined(var_0E.invalid_gameobject_mover) && var_0E.invalid_gameobject_mover == 1)
			{
				self.resetnow = 1;
			}
			else
			{
				for(var_0D = 0;var_0D < self.visuals.size;var_0D++)
				{
					self.visuals[var_0D] linkto(var_0E);
				}

				self.trigger linkto(var_0E);
				var_0F = spawnstruct();
				var_0F.carryobject = self;
				var_0F.deathoverridecallback = ::carryobject_overridemovingplatformdeath;
				self.trigger thread maps\mp\_movers::func_3F25(var_0F);
			}
		}

		thread func_5C02();
	}
	else
	{
		for(var_0D = 0;var_0D < self.visuals.size;var_0D++)
		{
			self.visuals[var_0D].origin = self.visuals[var_0D].baseorigin;
			self.visuals[var_0D].angles = self.visuals[var_0D].baseangles;
			self.visuals[var_0D] show();
		}

		self.trigger.origin = self.trigger.baseorigin;
		self.curorigin = self.trigger.baseorigin;
	}

	if(isdefined(self.ondrop))
	{
		self [[ self.ondrop ]](var_07);
	}

	func_1D37();
	func_86DD();
	updateworldicons();
	self.isresetting = 0;
}

//Function Number: 24
func_6FF7(param_00)
{
	self.carrier = param_00;
	thread func_8753();
}

//Function Number: 25
func_1D37()
{
	if(!isdefined(self.carrier))
	{
	}

	self.carrier func_7E89(self);
	self.carrier = undefined;
	self notify("carrier_cleared");
}

//Function Number: 26
func_5C02()
{
	self endon("pickup_object");
	self endon("stop_pickup_timeout");
	wait(0.05);
	if(isdefined(self.resetnow))
	{
		self.resetnow = undefined;
		func_6686();
	}

	var_00 = getentarray("minefield","targetname");
	var_01 = getentarray("trigger_hurt","classname");
	var_02 = getentarray("radiation","targetname");
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(!self.visuals[0] istouching(var_02[var_03]))
		{
			continue;
		}

		func_6686();
	}

	for(var_03 = 0;var_03 < var_00.size;var_03++)
	{
		if(!self.visuals[0] istouching(var_00[var_03]))
		{
			continue;
		}

		func_6686();
	}

	for(var_03 = 0;var_03 < var_01.size;var_03++)
	{
		if(!self.visuals[0] istouching(var_01[var_03]))
		{
			continue;
		}

		func_6686();
	}

	if(isdefined(self.autoresettime))
	{
		wait(self.autoresettime);
		if(!isdefined(self.carrier))
		{
			func_6686();
		}
	}
}

//Function Number: 27
func_7E89(param_00)
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

	if(maps\mp\_utility::func_4945(self) && !param_00.allowweapons)
	{
		common_scripts\utility::_enableweapon();
	}
}

//Function Number: 28
func_8212()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self endon("drop_object");
	while(isdefined(self.carryobject) && maps\mp\_utility::func_4945(self))
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

//Function Number: 29
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
			self.carryobject thread func_7025();
		}
	}
}

//Function Number: 30
deleteuseobject()
{
	foreach(var_01 in level.teamnamelist)
	{
		objective_delete(self.teamobjids[var_01]);
		maps\mp\gametypes\_objpoints::deleteobjpoint(self.objpoints[var_01]);
	}

	self.trigger = undefined;
	self notify("deleted");
}

//Function Number: 31
func_212D(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04.type = "useObject";
	var_04.curorigin = param_01.origin;
	var_04.ownerteam = param_00;
	var_04.entnum = param_01 getentitynumber();
	var_04.keyobject = undefined;
	if(issubstr(param_01.classname,"use"))
	{
		var_04.triggertype = "use";
	}
	else
	{
		var_04.triggertype = "proximity";
	}

	var_04.trigger = param_01;
	for(var_05 = 0;var_05 < param_02.size;var_05++)
	{
		param_02[var_05].baseorigin = param_02[var_05].origin;
		param_02[var_05].baseangles = param_02[var_05].angles;
	}

	var_04.visuals = param_02;
	if(!isdefined(param_03))
	{
		param_03 = (0,0,0);
	}

	var_04.offset3d = param_03;
	var_04.compassicons = [];
	foreach(var_07 in level.teamnamelist)
	{
		var_04.teamobjids[var_07] = getnextobjid();
		objective_add(var_04.teamobjids[var_07],"invisible",var_04.curorigin);
		objective_team(var_04.teamobjids[var_07],var_07);
		var_04.objpoints[var_07] = maps\mp\gametypes\_objpoints::createteamobjpoint("objpoint_" + var_07 + "_" + var_04.entnum,var_04.curorigin + param_03,var_07,undefined);
		var_04.objpoints[var_07].alpha = 0;
	}

	var_04.interactteam = "none";
	var_04.worldicons = [];
	var_04.visibleteam = "none";
	var_04.onuse = undefined;
	var_04.oncantuse = undefined;
	var_04.usetext = "default";
	var_04.usetime = 10000;
	var_04.curprogress = 0;
	if(var_04.triggertype == "proximity")
	{
		var_04.teamusetimes = [];
		var_04.teamusetexts = [];
		var_04.numtouching["neutral"] = 0;
		var_04.touchlist["neutral"] = [];
		var_04.numtouching["none"] = 0;
		var_04.touchlist["none"] = [];
		foreach(var_0A in level.teamnamelist)
		{
			var_04.numtouching[var_0A] = 0;
			var_04.touchlist[var_0A] = [];
		}

		var_04.userate = 0;
		var_04.claimteam = "none";
		var_04.claimplayer = undefined;
		var_04.lastclaimteam = "none";
		var_04.lastclaimtime = 0;
		var_04 thread func_87C7();
	}
	else
	{
		var_04.userate = 1;
		var_04 thread func_87C9();
	}

	return var_04;
}

//Function Number: 32
func_705C(param_00)
{
	self.keyobject = param_00;
}

//Function Number: 33
func_87C9()
{
	level endon("game_ended");
	self endon("deleted");
	for(;;)
	{
		self.trigger waittill("trigger",var_00);
		if(!maps\mp\_utility::func_4945(var_00))
		{
			continue;
		}

		if(!func_19CA(var_00.pers["team"]))
		{
			continue;
		}

		if(!var_00 isonground())
		{
			continue;
		}

		if(!var_00 maps\mp\_utility::isjuggernaut() && maps\mp\_utility::func_48F7(var_00 getcurrentweapon()))
		{
			continue;
		}

		if(isdefined(self.usecondition))
		{
			if(!self [[ self.usecondition ]](var_00))
			{
				continue;
			}
		}

		if(isdefined(self.keyobject) && !isdefined(var_00.carryobject) || var_00.carryobject != self.keyobject)
		{
			if(isdefined(self.oncantuse))
			{
				self [[ self.oncantuse ]](var_00);
			}

			continue;
		}

		if(!var_00 common_scripts\utility::func_49B6())
		{
			continue;
		}

		var_01 = 1;
		if(self.usetime > 0)
		{
			if(isdefined(self.onbeginuse))
			{
				var_00 func_874E(self,0);
				self [[ self.onbeginuse ]](var_00);
			}

			if(!isdefined(self.keyobject))
			{
				thread func_1A08();
			}

			var_02 = var_00.pers["team"];
			var_01 = func_87BF(var_00);
			self notify("finished_use");
			if(isdefined(self.onenduse))
			{
				self [[ self.onenduse ]](var_02,var_00,var_01);
			}
		}

		if(!var_01)
		{
			continue;
		}

		if(isdefined(self.onuse))
		{
			self [[ self.onuse ]](var_00);
		}
	}
}

//Function Number: 34
func_1A08()
{
	level endon("game_ended");
	self endon("deleted");
	self endon("finished_use");
	for(;;)
	{
		self.trigger waittill("trigger",var_00);
		if(!maps\mp\_utility::func_4945(var_00))
		{
			continue;
		}

		if(!func_19CA(var_00.pers["team"]))
		{
			continue;
		}

		if(isdefined(self.oncantuse))
		{
			self [[ self.oncantuse ]](var_00);
		}
	}
}

//Function Number: 35
getearliestclaimplayer()
{
	var_00 = self.claimteam;
	if(maps\mp\_utility::func_4945(self.claimplayer))
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
			if(maps\mp\_utility::func_4945(var_05.player) && !isdefined(var_02) || var_05.starttime < var_02)
			{
				var_01 = var_05.player;
				var_02 = var_05.starttime;
			}
		}
	}

	return var_01;
}

//Function Number: 36
func_87C7()
{
	level endon("game_ended");
	self endon("deleted");
	thread func_622E();
	for(;;)
	{
		if(self.usetime && self.curprogress >= self.usetime)
		{
			self.curprogress = 0;
			var_00 = getearliestclaimplayer();
			if(isdefined(self.onenduse))
			{
				self [[ self.onenduse ]](func_3A53(),var_00,isdefined(var_00));
			}

			if(isdefined(var_00) && isdefined(self.onuse))
			{
				self [[ self.onuse ]](var_00);
			}

			func_7002("none");
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
						self [[ self.onenduse ]](func_3A53(),self.claimplayer,0);
					}

					func_7002("none");
					self.claimplayer = undefined;
				}
				else
				{
					self.curprogress = self.curprogress + 50 * self.userate;
					if(isdefined(self.onuseupdate))
					{
						self [[ self.onuseupdate ]](func_3A53(),self.curprogress / self.usetime,50 * self.userate / self.usetime);
					}
				}
			}
			else
			{
				if(isdefined(self.onuse))
				{
					self [[ self.onuse ]](self.claimplayer);
				}

				func_7002("none");
				self.claimplayer = undefined;
			}
		}

		wait(0.05);
		maps\mp\gametypes\_hostmigration::func_8BBA();
	}
}

//Function Number: 37
func_622E()
{
	level endon("game_ended");
	self endon("deleted");
	var_00 = self.entnum;
	for(;;)
	{
		self.trigger waittill("trigger",var_01);
		if(!maps\mp\_utility::func_4945(var_01))
		{
			continue;
		}

		if(!maps\mp\_utility::func_48CE(var_01))
		{
			continue;
		}

		if(isdefined(self.carrier))
		{
			continue;
		}

		if(var_01 maps\mp\_utility::func_4995() || isdefined(var_01.var_78A7))
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

		if(level.gametype == "ctfpro")
		{
			if(isdefined(self.type) && self.type == "carryObject" && isdefined(var_01.carryflag))
			{
				continue;
			}
		}

		if(func_19CA(var_01.pers["team"],var_01) && self.claimteam == "none")
		{
			if(!isdefined(self.keyobject) || isdefined(var_01.carryobject) && var_01.carryobject == self.keyobject)
			{
				if(!func_622D(var_01))
				{
					continue;
				}

				func_7002(var_01.pers["team"]);
				self.claimplayer = var_01;
				var_02 = func_3BD1(var_01.pers["team"]);
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

		if(self.usetime && maps\mp\_utility::func_4945(var_01) && !isdefined(var_01.touchtriggers[var_00]))
		{
			var_01 thread func_83BD(self);
		}
	}
}

//Function Number: 38
func_622D(param_00)
{
	if(!isdefined(self.requireslos))
	{
		return 1;
	}

	var_01 = param_00 geteye();
	var_02 = self.trigger.origin + (0,0,32);
	var_03 = bullettrace(var_01,var_02,0,undefined);
	if(var_03["fraction"] != 1)
	{
		var_02 = self.trigger.origin + (0,0,16);
		var_03 = bullettrace(var_01,var_02,0,undefined);
	}

	if(var_03["fraction"] != 1)
	{
		var_02 = self.trigger.origin + (0,0,0);
		var_03 = bullettrace(var_01,var_02,0,undefined);
	}

	return var_03["fraction"] == 1;
}

//Function Number: 39
func_7002(param_00)
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
	self.lastclaimtime = gettime();
	self.claimteam = param_00;
	func_8752();
}

//Function Number: 40
func_3A53()
{
	return self.claimteam;
}

//Function Number: 41
func_83BD(param_00)
{
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
	param_00 func_8752();
	while(maps\mp\_utility::func_4945(self) && isdefined(param_00.trigger) && self istouching(param_00.trigger) && !level.gameended && param_00.usetime)
	{
		if(isplayer(self))
		{
			func_874E(param_00,1);
			func_8717(param_00,0);
		}

		wait(0.05);
	}

	if(isdefined(self))
	{
		if(isplayer(self))
		{
			func_874E(param_00,0);
			func_8717(param_00,1);
		}

		self.touchtriggers[param_00.entnum] = undefined;
	}

	if(level.gameended)
	{
	}

	param_00.touchlist[var_01][var_02] = undefined;
	param_00.numtouching[var_01]--;
	param_00 func_8752();
}

//Function Number: 42
func_8717(param_00,param_01)
{
	var_02 = self.pers["team"];
	if(param_01 || !param_00 func_19CA(var_02) || var_02 != param_00.claimteam || param_00.nousebar)
	{
		if(isdefined(self.proxbar))
		{
			self.proxbar maps\mp\gametypes\_hud_util::func_4203();
		}

		if(isdefined(self.proxbartext))
		{
			self.proxbartext maps\mp\gametypes\_hud_util::func_4203();
		}
	}

	if(!isdefined(self.proxbar))
	{
		self.proxbar = maps\mp\gametypes\_hud_util::createprimaryprogressbar();
		self.proxbar.lastuserate = -1;
		self.proxbar.lasthostmigrationstate = 0;
	}

	if(self.proxbar.hidden)
	{
		self.proxbar maps\mp\gametypes\_hud_util::func_750E();
		self.proxbar.lastuserate = -1;
		self.proxbar.lasthostmigrationstate = 0;
	}

	if(!isdefined(self.proxbartext))
	{
		self.proxbartext = maps\mp\gametypes\_hud_util::createprimaryprogressbartext();
		var_03 = param_00 func_3BD1(var_02);
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
		self.proxbartext maps\mp\gametypes\_hud_util::func_750E();
		var_03 = param_00 func_3BD1(var_02);
		if(isdefined(param_00.teamusetexts[var_03]))
		{
			self.proxbartext settext(param_00.teamusetexts[var_03]);
		}
		else
		{
			self.proxbartext settext(param_00.usetext);
		}
	}

	if(self.proxbar.lastuserate != param_00.userate || self.proxbar.lasthostmigrationstate != isdefined(level.hostmigrationtimer))
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

		self.proxbar maps\mp\gametypes\_hud_util::func_86CD(var_04,var_05);
		self.proxbar.lastuserate = param_00.userate;
		self.proxbar.lasthostmigrationstate = isdefined(level.hostmigrationtimer);
	}
}

//Function Number: 43
migrationcapturereset(param_00)
{
	param_00.migrationcapturereset = 1;
	level waittill("host_migration_begin");
	if(!isdefined(param_00) || !isdefined(self))
	{
	}

	param_00 setclientomnvar("ui_securing",0);
	param_00 setclientomnvar("ui_securing_progress",0);
	self.migrationcapturereset = undefined;
}

//Function Number: 44
func_874E(param_00,param_01)
{
	if(!isdefined(level.hostmigrationtimer))
	{
		if(param_00.curprogress > param_00.usetime)
		{
			param_00.curprogress = param_00.usetime;
		}

		var_02 = param_00.curprogress / param_00.usetime;
		if(hasdomflags() && isdefined(param_00.id) && param_00.id == "domFlag")
		{
			var_03 = 0;
			if(param_00.label == "_a")
			{
				var_03 = 1;
			}
			else if(param_00.label == "_b")
			{
				var_03 = 2;
			}
			else if(param_00.label == "_c")
			{
				var_03 = 3;
			}

			if(param_01 && isdefined(param_00.stalemate) && param_00.stalemate)
			{
				if(!isdefined(self.ui_dom_stalemate))
				{
					if(!isdefined(self.ui_dom_securing))
					{
						self setclientomnvar("ui_dom_securing",var_03);
						self.ui_dom_securing = 1;
					}

					self setclientomnvar("ui_dom_stalemate",1);
					self.ui_dom_stalemate = 1;
				}

				var_02 = 0.01;
			}
			else
			{
				if(!param_01 && isdefined(self.ui_dom_stalemate))
				{
					self setclientomnvar("ui_dom_securing",0);
					self.ui_dom_securing = undefined;
				}

				if(param_01 && !isdefined(self.ui_dom_stalemate) && param_00.ownerteam == self.team)
				{
					self setclientomnvar("ui_dom_securing",0);
					self.ui_dom_securing = undefined;
				}

				if(param_01 && !isdefined(self.ui_dom_securing) && param_00.ownerteam != self.team)
				{
					self setclientomnvar("ui_dom_securing",var_03);
					self.ui_dom_securing = 1;
				}

				self setclientomnvar("ui_dom_stalemate",0);
				self.ui_dom_stalemate = undefined;
			}

			if(!param_01)
			{
				var_02 = 0.01;
				self setclientomnvar("ui_dom_securing",0);
				self.ui_dom_securing = undefined;
			}

			if(var_02 != 0)
			{
				self setclientomnvar("ui_dom_progress",var_02);
			}
		}

		if((level.gametype == "sd" || level.gametype == "sr") && isdefined(param_00.id) && param_00.id == "bomb_zone" || param_00.id == "defuse_object")
		{
			if(param_01)
			{
				if(!isdefined(self.ui_bomb_planting_defusing))
				{
					var_04 = 0;
					if(param_00.id == "bomb_zone")
					{
						var_04 = 1;
					}
					else if(param_00.id == "defuse_object")
					{
						var_04 = 2;
					}

					self setclientomnvar("ui_bomb_planting_defusing",var_04);
					self.ui_bomb_planting_defusing = 1;
				}
			}
			else
			{
				self setclientomnvar("ui_bomb_planting_defusing",0);
				self.ui_bomb_planting_defusing = undefined;
				var_02 = 0.01;
			}

			if(var_02 != 0)
			{
				self setclientomnvar("ui_planting_defusing_progress",var_02);
			}
		}

		if(isdefined(param_00.id))
		{
			var_04 = 0;
			switch(param_00.id)
			{
				case "care_package":
					var_04 = 1;
					break;

				case "intel":
					var_04 = 2;
					break;

				case "deployable_vest":
					var_04 = 3;
					break;

				case "deployable_weapon_crate":
					var_04 = 4;
					break;

				case "last_stand":
					var_04 = 5;
					if(isdefined(self.var_465B) && self.var_465B)
					{
						var_04 = 6;
					}
					break;

				case "breach":
					var_04 = 7;
					break;

				case "use":
					var_04 = 8;
					break;
			}

			func_8750(var_02,param_01,var_04,param_00);
		}
	}
}

//Function Number: 45
hasdomflags()
{
	if(level.gametype == "dom" || level.gametype == "siege")
	{
		return 1;
	}

	return 0;
}

//Function Number: 46
func_8750(param_00,param_01,param_02,param_03)
{
	if(param_01)
	{
		if(!isdefined(param_03.usedby))
		{
			param_03.usedby = [];
		}

		if(!isdefined(self.migrationcapturereset))
		{
			param_03 thread migrationcapturereset(self);
		}

		if(!func_3084(self,param_03.usedby))
		{
			param_03.usedby[param_03.usedby.size] = self;
		}

		if(!isdefined(self.ui_securing))
		{
			self setclientomnvar("ui_securing",param_02);
			self.ui_securing = 1;
		}
	}
	else
	{
		if(isdefined(param_03.usedby) && func_3084(self,param_03.usedby))
		{
			param_03.usedby = common_scripts\utility::array_remove(param_03.usedby,self);
		}

		self setclientomnvar("ui_securing",0);
		self.ui_securing = undefined;
		param_00 = 0.01;
	}

	if(param_00 != 0)
	{
		self setclientomnvar("ui_securing_progress",param_00);
	}
}

//Function Number: 47
func_3084(param_00,param_01)
{
	if(param_01.size > 0)
	{
		foreach(var_03 in param_01)
		{
			if(var_03 == param_00)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 48
func_8752()
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

	if(isdefined(self.isarena) && self.isarena)
	{
		self.userate = 1;
	}
}

//Function Number: 49
func_87BF(param_00)
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
		param_00 switchtoweapon(var_01);
	}
	else
	{
		param_00 common_scripts\utility::_disableweapon();
	}

	self.curprogress = 0;
	self.inuse = 1;
	self.userate = 0;
	var_03 = useholdthinkloop(param_00,var_02);
	if(isdefined(param_00))
	{
		param_00 detachusemodels();
		param_00 notify("done_using");
	}

	if(isdefined(var_01) && isdefined(param_00))
	{
		param_00 thread func_7E8E(var_01);
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
				param_00 maps\mp\_utility::func_7E17(var_02);
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
		if(!maps\mp\_utility::func_4945(param_00))
		{
			param_00.killedinuse = 1;
		}
	}

	self.inuse = 0;
	self.trigger releaseclaimedtrigger();
	return 0;
}

//Function Number: 50
detachusemodels()
{
	if(isdefined(self.attachedusemodel))
	{
		self detach(self.attachedusemodel,"tag_inhand");
		self.attachedusemodel = undefined;
	}
}

//Function Number: 51
func_7E8E(param_00)
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

//Function Number: 52
func_87DA(param_00,param_01,param_02,param_03)
{
	if(!maps\mp\_utility::func_4945(param_00))
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

//Function Number: 53
useholdthinkloop(param_00,param_01)
{
	level endon("game_ended");
	self endon("disabled");
	var_02 = self.useweapon;
	var_03 = 1;
	if(isdefined(self.waitforweapononuse))
	{
		var_03 = self.waitforweapononuse;
	}

	if(!var_03)
	{
		self.userate = 1 * param_00.objectivescaler;
	}

	var_04 = 0;
	var_05 = 1.5;
	while(func_87DA(param_00,var_03,var_04,var_05))
	{
		var_04 = var_04 + 0.05;
		if(!var_03 || !isdefined(var_02) || param_00 getcurrentweapon() == var_02)
		{
			self.curprogress = self.curprogress + 50 * self.userate;
			self.userate = 1 * param_00.objectivescaler;
			var_03 = 0;
		}
		else
		{
			self.userate = 0;
		}

		param_00 func_874E(self,1);
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
					param_00 maps\mp\_utility::func_7E17(param_01);
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
			return maps\mp\_utility::func_4945(param_00);
		}

		wait(0.05);
		maps\mp\gametypes\_hostmigration::func_8BBA();
	}

	param_00 func_874E(self,0);
	return 0;
}

//Function Number: 54
func_874A()
{
	if(self.triggertype != "use")
	{
	}

	if(self.interactteam == "none")
	{
		self.trigger.origin = self.trigger.origin - (0,0,50000);
	}

	if(self.interactteam == "any")
	{
		self.trigger.origin = self.curorigin;
		self.trigger setteamfortrigger("none");
	}

	if(self.interactteam == "friendly")
	{
		self.trigger.origin = self.curorigin;
		if(self.ownerteam == "allies")
		{
			self.trigger setteamfortrigger("allies");
		}

		if(self.ownerteam == "axis")
		{
			self.trigger setteamfortrigger("axis");
		}

		self.trigger.origin = self.trigger.origin - (0,0,50000);
	}

	if(self.interactteam == "enemy")
	{
		self.trigger.origin = self.curorigin;
		if(self.ownerteam == "allies")
		{
			self.trigger setteamfortrigger("axis");
		}

		if(self.ownerteam == "axis")
		{
			self.trigger setteamfortrigger("allies");
		}

		self.trigger setteamfortrigger("none");
	}
}

//Function Number: 55
updateworldicons()
{
	if(self.visibleteam == "any")
	{
		func_8759("friendly",1);
		func_8759("enemy",1);
	}

	if(self.visibleteam == "friendly")
	{
		func_8759("friendly",1);
		func_8759("enemy",0);
	}

	if(self.visibleteam == "enemy")
	{
		func_8759("friendly",0);
		func_8759("enemy",1);
	}

	func_8759("friendly",0);
	func_8759("enemy",0);
}

//Function Number: 56
func_8759(param_00,param_01)
{
	if(!isdefined(self.worldicons[param_00]))
	{
		param_01 = 0;
	}

	var_02 = func_3C5F(param_00);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_04 = "objpoint_" + var_02[var_03] + "_" + self.entnum;
		var_05 = maps\mp\gametypes\_objpoints::getobjpointbyname(var_04);
		var_05 notify("stop_flashing_thread");
		var_05 thread maps\mp\gametypes\_objpoints::func_7C5F();
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
				if(isdefined(self.carrier) && !func_74B8(param_00))
				{
					var_05 settargetent(self.carrier);
				}
				else
				{
					var_05 cleartargetent();
				}
			}
			else if(isdefined(self.objiconent))
			{
				var_05 settargetent(self.objiconent);
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

//Function Number: 57
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

//Function Number: 58
func_8747(param_00,param_01)
{
}

//Function Number: 59
func_86DD()
{
	if(self.visibleteam == "any")
	{
		func_86DC("friendly",1);
		func_86DC("enemy",1);
	}

	if(self.visibleteam == "friendly")
	{
		func_86DC("friendly",1);
		func_86DC("enemy",0);
	}

	if(self.visibleteam == "enemy")
	{
		func_86DC("friendly",0);
		func_86DC("enemy",1);
	}

	func_86DC("friendly",0);
	func_86DC("enemy",0);
}

//Function Number: 60
func_86DC(param_00,param_01)
{
	var_02 = func_3C5F(param_00);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_04 = var_02[var_03];
		var_05 = param_01;
		if(!var_05 && func_74C1(var_04))
		{
			var_05 = 1;
		}

		var_06 = self.teamobjids[var_04];
		if(!isdefined(self.compassicons[param_00]) || !var_05)
		{
			objective_state(var_06,"invisible");
			continue;
		}

		objective_icon(var_06,self.compassicons[param_00]);
		objective_state(var_06,"active");
		if(self.type == "carryObject")
		{
			if(maps\mp\_utility::func_4945(self.carrier) && !func_74B8(param_00))
			{
				objective_onentity(var_06,self.carrier);
			}
			else if(isdefined(self.visuals[0]) && isdefined(self.visuals[0] getlinkedparent()))
			{
				objective_onentity(var_06,self.visuals[0]);
			}
			else
			{
				objective_position(var_06,self.curorigin);
			}

			continue;
		}

		if(isdefined(self.objiconent))
		{
			objective_onentity(var_06,self.objiconent);
		}
	}
}

//Function Number: 61
func_74B8(param_00)
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

//Function Number: 62
func_3C5F(param_00)
{
	var_01 = [];
	foreach(var_03 in level.teamnamelist)
	{
		if(param_00 == "friendly")
		{
			if(isfriendlyteam(var_03))
			{
				var_01[var_01.size] = var_03;
			}

			continue;
		}

		if(param_00 == "enemy")
		{
			if(!isfriendlyteam(var_03))
			{
				var_01[var_01.size] = var_03;
			}
		}
	}

	return var_01;
}

//Function Number: 63
func_74C1(param_00)
{
	if(!isdefined(self.carrier))
	{
		return 0;
	}

	if(self.carrier maps\mp\_utility::_hasperk("specialty_gpsjammer"))
	{
		return 0;
	}

	return getteamradar(param_00);
}

//Function Number: 64
func_8753()
{
	self endon("death");
	self endon("carrier_cleared");
	for(;;)
	{
		level waittill("radar_status_change");
		func_86DD();
	}
}

//Function Number: 65
func_708D(param_00)
{
	self.ownerteam = param_00;
	func_874A();
	func_86DD();
	updateworldicons();
	if(param_00 != "neutral")
	{
		self.prevownerteam = param_00;
	}
}

//Function Number: 66
func_3B78()
{
	return self.ownerteam;
}

//Function Number: 67
func_720E(param_00)
{
	self.usetime = int(param_00 * 1000);
}

//Function Number: 68
setwaitweaponchangeonuse(param_00)
{
	self.waitforweapononuse = param_00;
}

//Function Number: 69
func_720D(param_00)
{
	self.usetext = param_00;
}

//Function Number: 70
func_70E3(param_00,param_01)
{
	self.teamusetimes[param_00] = int(param_01 * 1000);
}

//Function Number: 71
func_70E2(param_00,param_01)
{
	self.teamusetexts[param_00] = param_01;
}

//Function Number: 72
func_720C(param_00)
{
	self.trigger sethintstring(param_00);
}

//Function Number: 73
func_0B9E(param_00)
{
	self.interactteam = param_00;
}

//Function Number: 74
allowuse(param_00)
{
	self.interactteam = param_00;
	func_874A();
}

//Function Number: 75
func_7212(param_00)
{
	self.visibleteam = param_00;
	func_86DD();
	updateworldicons();
}

//Function Number: 76
func_7074(param_00)
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

				self.visuals[var_01] thread func_501E();
			}
		}
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

//Function Number: 77
func_501E()
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

//Function Number: 78
setcarriervisible(param_00)
{
	self.carriervisible = param_00;
}

//Function Number: 79
func_6FF5(param_00)
{
	self.useteam = param_00;
}

//Function Number: 80
func_6E14(param_00,param_01)
{
	self.compassicons[param_00] = param_01;
	func_86DD();
}

//Function Number: 81
func_6E15(param_00,param_01)
{
	self.worldicons[param_00] = param_01;
	updateworldicons();
}

//Function Number: 82
set3duseicon(param_00,param_01)
{
	self.worlduseicons[param_00] = param_01;
}

//Function Number: 83
setcarryicon(param_00)
{
	self.carryicon = param_00;
}

//Function Number: 84
func_27B7()
{
	self notify("disabled");
	if(self.type == "carryObject")
	{
		if(isdefined(self.carrier))
		{
			self.carrier func_7E89(self);
		}

		for(var_00 = 0;var_00 < self.visuals.size;var_00++)
		{
			self.visuals[var_00] hide();
		}
	}

	self.trigger common_scripts\utility::trigger_off();
	func_7212("none");
}

//Function Number: 85
func_2CEA()
{
	if(self.type == "carryObject")
	{
		for(var_00 = 0;var_00 < self.visuals.size;var_00++)
		{
			self.visuals[var_00] show();
		}
	}

	self.trigger common_scripts\utility::func_837B();
	func_7212("any");
}

//Function Number: 86
func_3BD1(param_00)
{
	if(param_00 == self.ownerteam)
	{
		return "friendly";
	}

	return "enemy";
}

//Function Number: 87
isfriendlyteam(param_00)
{
	if(self.ownerteam == "any")
	{
		return 1;
	}

	if(self.ownerteam == param_00)
	{
		return 1;
	}

	if(self.ownerteam == "neutral" && isdefined(self.prevownerteam) && self.prevownerteam == param_00)
	{
		return 1;
	}

	return 0;
}

//Function Number: 88
func_19CA(param_00,param_01)
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

//Function Number: 89
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

//Function Number: 90
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

//Function Number: 91
func_3A9A(param_00)
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

//Function Number: 92
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
		var_00 = 31;
	}

	return var_00;
}

//Function Number: 93
func_3B06()
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

//Function Number: 94
func_4629()
{
	self.nearest_node = undefined;
	self.calculated_nearest_node = 0;
	self.on_path_grid = undefined;
}