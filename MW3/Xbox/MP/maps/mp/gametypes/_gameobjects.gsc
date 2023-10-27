/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_gameobjects.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 86
 * Decompile Time: 1320 ms
 * Timestamp: 10/27/2023 2:25:28 AM
*******************************************************************/

//Function Number: 1
main(param_00)
{
	var_01 = getentarray();
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(isdefined(var_01[var_02].script_gameobjectname))
		{
			var_03 = 1;
			var_04 = strtok(var_01[var_02].script_gameobjectname," ");
			for(var_05 = 0;var_05 < var_41.size;var_05++ = "airdrop_pallet")
			{
				var_06 = 0;
				while(var_06 < var_04.size)
				{
					if(var_04[var_06] == var_41[var_05])
					{
						var_03 = 0;
						break;
					}

					var_06++ = var_41[param_00.size];
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
init()
{
	level.numgametypereservedobjectives = 0;
	precacheitem("briefcase_bomb_mp");
	precacheitem("briefcase_bomb_defuse_mp");
	precachemodel("prop_suitcase_bomb");
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
		var_00 thread func_29A7();
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

		thread ondeath();
		self.touchtriggers = [];
		self.carryobject = undefined;
		self.claimtrigger = undefined;
		self.canpickupobject = 1;
		self.killedinuse = undefined;
	}
}

//Function Number: 5
ondeath()
{
	level endon("game_ended");
	self waittill("death");
	if(isdefined(self.carryobject))
	{
		self.carryobject thread setdropped();
	}
}

//Function Number: 6
func_29A7()
{
	level endon("game_ended");
	self waittill("disconnect");
	if(isdefined(self.carryobject))
	{
		self.carryobject thread setdropped();
	}
}

//Function Number: 7
func_29A8(param_00,param_01,param_02,param_03)
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
	var_04.objidallies = func_2A31();
	var_04.objidaxis = func_2A31();
	var_04.objidpingfriendly = 0;
	var_04.objidpingenemy = 0;
	level.objidstart = level.objidstart + 2;
	objective_add(var_04.objidallies,"invisible",var_04.curorigin);
	objective_add(var_04.objidaxis,"invisible",var_04.curorigin);
	objective_team(var_04.objidallies,"allies");
	objective_team(var_04.objidaxis,"axis");
	var_04.objpoints["allies"] = maps\mp\gametypes\_objpoints::func_2996("objpoint_allies_" + var_04.entnum,var_04.curorigin + param_03,"allies",undefined);
	var_04.objpoints["axis"] = maps\mp\gametypes\_objpoints::func_2996("objpoint_axis_" + var_04.entnum,var_04.curorigin + param_03,"axis",undefined);
	var_04.objpoints["allies"].alpha = 0;
	var_04.objpoints["axis"].alpha = 0;
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
		var_04 thread carryobjectproxthink();
	}

	var_04 thread func_29D4();
	return var_04;
}

//Function Number: 8
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

		if(!maps\mp\_utility::isreallyalive(var_00))
		{
			continue;
		}

		if(!func_2A2D(var_00.pers["team"]))
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

		if(var_00 maps\mp\_utility::isusingremote())
		{
			continue;
		}

		func_29D2(var_00);
	}
}

//Function Number: 9
carryobjectproxthink()
{
	thread func_29CE();
}

//Function Number: 10
carryobjectproxthinkinstant()
{
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

		if(!func_2A2D(var_00.pers["team"]))
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

		func_29D2(var_00);
	}
}

//Function Number: 11
func_29CE()
{
	level endon("game_ended");
	thread proxtriggerthink();
	for(;;)
	{
		if(self.usetime && self.curprogress >= self.usetime)
		{
			self.curprogress = 0;
			var_00 = func_29F0();
			if(isdefined(self.onenduse))
			{
				self [[ self.onenduse ]](func_29F8(),var_00,isdefined(var_00));
			}

			if(isdefined(var_00))
			{
				func_29D2(var_00);
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
						self [[ self.onenduse ]](func_29F8(),self.claimplayer,0);
					}

					setclaimteam("none");
					self.claimplayer = undefined;
				}
				else
				{
					self.curprogress = self.curprogress + 50 * self.userate;
					if(isdefined(self.onuseupdate))
					{
						self [[ self.onuseupdate ]](func_29F8(),self.curprogress / self.usetime,50 * self.userate / self.usetime);
					}
				}
			}
			else
			{
				if(maps\mp\_utility::isreallyalive(self.claimplayer))
				{
					func_29D2(self.claimplayer);
				}

				setclaimteam("none");
				self.claimplayer = undefined;
			}
		}

		wait 0.05;
		maps\mp\gametypes\_hostmigration::func_273E();
	}
}

//Function Number: 12
func_29D1(param_00)
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

		wait 0.2;
	}

	self.canpickupobject = 1;
}

//Function Number: 13
func_29D2(param_00)
{
	if(isdefined(param_00.carryobject))
	{
		if(isdefined(self.onpickupfailed))
		{
			self [[ self.onpickupfailed ]](param_00);
		}

		return;
	}

	param_00 func_29D6(self);
	func_29DE(param_00);
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

	func_2A0E();
	func_2A0B();
}

//Function Number: 14
func_29D4()
{
	level endon("game_ended");
	var_00 = 5;
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
					self.objpoints["allies"] fadeovertime(var_00 + 1);
					self.objpoints["allies"].alpha = 0;
				}

				objective_position(self.objidallies,self.curorigin);
			}
			else if((self.visibleteam == "friendly" || self.visibleteam == "any") && isfriendlyteam("axis") && self.objidpingfriendly)
			{
				if(self.objpoints["axis"].isshown)
				{
					self.objpoints["axis"].alpha = self.objpoints["axis"].basealpha;
					self.objpoints["axis"] fadeovertime(var_00 + 1);
					self.objpoints["axis"].alpha = 0;
				}

				objective_position(self.objidaxis,self.curorigin);
			}

			if((self.visibleteam == "enemy" || self.visibleteam == "any") && !isfriendlyteam("allies") && self.objidpingenemy)
			{
				if(self.objpoints["allies"].isshown)
				{
					self.objpoints["allies"].alpha = self.objpoints["allies"].basealpha;
					self.objpoints["allies"] fadeovertime(var_00 + 1);
					self.objpoints["allies"].alpha = 0;
				}

				objective_position(self.objidallies,self.curorigin);
			}
			else if((self.visibleteam == "enemy" || self.visibleteam == "any") && !isfriendlyteam("axis") && self.objidpingenemy)
			{
				if(self.objpoints["axis"].isshown)
				{
					self.objpoints["axis"].alpha = self.objpoints["axis"].basealpha;
					self.objpoints["axis"] fadeovertime(var_00 + 1);
					self.objpoints["axis"].alpha = 0;
				}

				objective_position(self.objidaxis,self.curorigin);
			}

			maps\mp\_utility::func_29D5(var_00,"dropped","reset");
			continue;
		}

		self.objpoints["allies"] maps\mp\gametypes\_objpoints::updateorigin(self.curorigin + self.offset3d);
		self.objpoints["axis"] maps\mp\gametypes\_objpoints::updateorigin(self.curorigin + self.offset3d);
		wait 0.05;
	}
}

//Function Number: 15
func_80F4()
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

//Function Number: 16
func_29D6(param_00)
{
	self.carryobject = param_00;
	thread trackcarrier();
	if(!param_00.allowweapons)
	{
		common_scripts\utility::_disableweapon();
		thread func_29E4();
	}

	if(isdefined(param_00.carryicon))
	{
		if(level.splitscreen)
		{
			self.carryicon = maps\mp\gametypes\_hud_util::createicon(param_00.carryicon,33,33);
			self.carryicon maps\mp\gametypes\_hud_util::setpoint("BOTTOM RIGHT","BOTTOM RIGHT",-50,-78);
		}
		else
		{
			self.carryicon = maps\mp\gametypes\_hud_util::createicon(param_00.carryicon,50,50);
			self.carryicon maps\mp\gametypes\_hud_util::setpoint("BOTTOM RIGHT","BOTTOM RIGHT",-50,-65);
		}

		self.carryicon.hidewheninmenu = 1;
		thread func_80F4();
	}
}

//Function Number: 17
func_29D7()
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
	func_2A0B();
	func_2A0E();
	self.isresetting = 0;
}

//Function Number: 18
func_29D8()
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

//Function Number: 19
func_29D9(param_00,param_01)
{
	self.isresetting = 1;
	for(var_02 = 0;var_02 < self.visuals.size;var_02++)
	{
		self.visuals[var_02].origin = self.origin;
		self.visuals[var_02].angles = self.angles;
		self.visuals[var_02] show();
	}

	self.trigger.origin = param_00;
	self.curorigin = self.trigger.origin;
	clearcarrier();
	func_2A0B();
	func_2A0E();
	self.isresetting = 0;
}

//Function Number: 20
func_29DA()
{
	if(isdefined(self.carryobject))
	{
		self.carryobject thread setdropped();
	}
}

//Function Number: 21
setdropped()
{
	self.isresetting = 1;
	self notify("dropped");
	if(isdefined(self.carrier) && self.carrier.team != "spectator")
	{
		var_00 = playerphysicstrace(self.carrier.origin + (0,0,20),self.carrier.origin - (0,0,2000),0,self.carrier.body);
		var_01 = bullettrace(self.carrier.origin + (0,0,20),self.carrier.origin - (0,0,2000),0,self.carrier.body);
	}
	else
	{
		var_00 = playerphysicstrace(self.safeorigin + (0,0,20),self.safeorigin - (0,0,20),0,undefined);
		var_01 = bullettrace(self.safeorigin + (0,0,20),self.safeorigin - (0,0,20),0,undefined);
	}

	var_02 = self.carrier;
	var_03 = 0;
	if(isdefined(var_00))
	{
		var_04 = randomfloat(360);
		var_05 = var_00;
		if(var_01["fraction"] < 1 && distance(var_01["position"],var_00) < 10)
		{
			var_06 = (cos(var_04),sin(var_04),0);
			var_06 = vectornormalize(var_06 - var_01["normal"] * vectordot(var_06,var_01["normal"]));
			var_07 = vectortoangles(var_06);
		}
		else
		{
			var_07 = (0,var_05,0);
		}

		for(var_08 = 0;var_08 < self.visuals.size;var_08++)
		{
			self.visuals[var_08].origin = var_05;
			self.visuals[var_08].angles = var_07;
			self.visuals[var_08] show();
		}

		self.trigger.origin = var_05;
		self.curorigin = self.trigger.origin;
		thread pickuptimeout();
	}

	if(!isdefined(var_00))
	{
		for(var_08 = 0;var_08 < self.visuals.size;var_08++)
		{
			self.visuals[var_08].origin = self.visuals[var_08].baseorigin;
			self.visuals[var_08].angles = self.visuals[var_08].baseangles;
			self.visuals[var_08] show();
		}

		self.trigger.origin = self.trigger.baseorigin;
		self.curorigin = self.trigger.baseorigin;
	}

	if(isdefined(self.ondrop))
	{
		self [[ self.ondrop ]](var_02);
	}

	clearcarrier();
	func_2A0E();
	func_2A0B();
	self.isresetting = 0;
}

//Function Number: 22
func_29DE(param_00)
{
	self.carrier = param_00;
	thread func_2A13();
}

//Function Number: 23
clearcarrier()
{
	if(!isdefined(self.carrier))
	{
		return;
	}

	self.carrier func_29E2(self);
	self.carrier = undefined;
	self notify("carrier_cleared");
}

//Function Number: 24
pickuptimeout()
{
	self endon("pickup_object");
	self endon("stop_pickup_timeout");
	wait 0.05;
	var_00 = getentarray("minefield","targetname");
	var_01 = getentarray("trigger_hurt","classname");
	var_02 = getentarray("radiation","targetname");
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(!self.visuals[0] istouching(var_02[var_03]))
		{
			continue;
		}

		func_29D7();
		return;
	}

	for(var_03 = 0;var_03 < var_00.size;var_03++)
	{
		if(!self.visuals[0] istouching(var_00[var_03]))
		{
			continue;
		}

		func_29D7();
		return;
	}

	for(var_03 = 0;var_03 < var_01.size;var_03++)
	{
		if(!self.visuals[0] istouching(var_01[var_03]))
		{
			continue;
		}

		func_29D7();
		return;
	}

	if(isdefined(self.autoresettime))
	{
		wait self.autoresettime;
		if(!isdefined(self.carrier))
		{
			func_29D7();
		}
	}
}

//Function Number: 25
func_29E2(param_00)
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
		thread func_29D1(param_00.trigger.origin);
	}

	if(maps\mp\_utility::isreallyalive(self) && !param_00.allowweapons)
	{
		common_scripts\utility::_enableweapon();
	}
}

//Function Number: 26
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

		wait 0.05;
	}
}

//Function Number: 27
func_29E4()
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

//Function Number: 28
deleteuseobject()
{
	maps\mp\_utility::_objective_delete(self.objidallies);
	maps\mp\_utility::_objective_delete(self.objidaxis);
	maps\mp\gametypes\_objpoints::deleteobjpoint(self.objpoints["allies"]);
	maps\mp\gametypes\_objpoints::deleteobjpoint(self.objpoints["axis"]);
	self.trigger = undefined;
	self notify("deleted");
}

//Function Number: 29
func_29E7(param_00,param_01,param_02,param_03)
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
	var_04.objidallies = func_2A31();
	var_04.objidaxis = func_2A31();
	objective_add(var_04.objidallies,"invisible",var_04.curorigin);
	objective_add(var_04.objidaxis,"invisible",var_04.curorigin);
	objective_team(var_04.objidallies,"allies");
	objective_team(var_04.objidaxis,"axis");
	var_04.objpoints["allies"] = maps\mp\gametypes\_objpoints::func_2996("objpoint_allies_" + var_04.entnum,var_04.curorigin + param_03,"allies",undefined);
	var_04.objpoints["axis"] = maps\mp\gametypes\_objpoints::func_2996("objpoint_axis_" + var_04.entnum,var_04.curorigin + param_03,"axis",undefined);
	var_04.objpoints["allies"].alpha = 0;
	var_04.objpoints["axis"].alpha = 0;
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
		var_04.numtouching["axis"] = 0;
		var_04.numtouching["allies"] = 0;
		var_04.numtouching["none"] = 0;
		var_04.touchlist["neutral"] = [];
		var_04.touchlist["axis"] = [];
		var_04.touchlist["allies"] = [];
		var_04.touchlist["none"] = [];
		var_04.userate = 0;
		var_04.claimteam = "none";
		var_04.claimplayer = undefined;
		var_04.lastclaimteam = "none";
		var_04.lastclaimtime = 0;
		var_04 thread func_29F2();
	}
	else
	{
		var_04.userate = 1;
		var_04 thread func_29ED();
	}

	return var_04;
}

//Function Number: 30
func_29EC(param_00)
{
	self.keyobject = param_00;
}

//Function Number: 31
func_29ED()
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

		if(!func_2A2D(var_00.pers["team"]))
		{
			continue;
		}

		if(!var_00 isonground())
		{
			continue;
		}

		if(!var_00 maps\mp\_utility::isjuggernaut() && maps\mp\_utility::func_2829(var_00 getcurrentweapon()))
		{
			continue;
		}

		if(isdefined(self.keyobject) && !isdefined(var_00.carryobject) || var_00.carryobject != self.keyobject)
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

		var_01 = 1;
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

			var_02 = var_00.pers["team"];
			var_01 = func_2A04(var_00);
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

//Function Number: 32
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

		if(!func_2A2D(var_00.pers["team"]))
		{
			continue;
		}

		if(isdefined(self.oncantuse))
		{
			self [[ self.oncantuse ]](var_00);
		}
	}
}

//Function Number: 33
func_29F0()
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

//Function Number: 34
func_29F2()
{
	level endon("game_ended");
	self endon("deleted");
	thread proxtriggerthink();
	for(;;)
	{
		if(self.usetime && self.curprogress >= self.usetime)
		{
			self.curprogress = 0;
			var_00 = func_29F0();
			if(isdefined(self.onenduse))
			{
				self [[ self.onenduse ]](func_29F8(),var_00,isdefined(var_00));
			}

			if(isdefined(var_00) && isdefined(self.onuse))
			{
				self [[ self.onuse ]](var_00);
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
						self [[ self.onenduse ]](func_29F8(),self.claimplayer,0);
					}

					setclaimteam("none");
					self.claimplayer = undefined;
				}
				else
				{
					self.curprogress = self.curprogress + 50 * self.userate;
					if(isdefined(self.onuseupdate))
					{
						self [[ self.onuseupdate ]](func_29F8(),self.curprogress / self.usetime,50 * self.userate / self.usetime);
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
		maps\mp\gametypes\_hostmigration::func_273E();
	}
}

//Function Number: 35
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

		if(isdefined(self.carrier))
		{
			continue;
		}

		if(var_01 maps\mp\_utility::isusingremote() || isdefined(var_01.spawningafterremotedeath))
		{
			continue;
		}

		if(isdefined(var_01.classname) && var_01.classname == "script_vehicle")
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

		if(func_2A2D(var_01.pers["team"],var_01) && self.claimteam == "none")
		{
			if(!isdefined(self.keyobject) || isdefined(var_01.carryobject) && var_01.carryobject == self.keyobject)
			{
				if(!func_29F5(var_01))
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

		if(self.usetime && maps\mp\_utility::isreallyalive(var_01) && !isdefined(var_01.touchtriggers[var_00]))
		{
			var_01 thread triggertouchthink(self);
		}
	}
}

//Function Number: 36
func_29F5(param_00)
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

//Function Number: 37
setclaimteam(param_00)
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
	func_29FF();
}

//Function Number: 38
func_29F8()
{
	return self.claimteam;
}

//Function Number: 39
triggertouchthink(param_00)
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
	param_00 func_29FF();
	while(maps\mp\_utility::isreallyalive(self) && isdefined(param_00.trigger) && self istouching(param_00.trigger) && !level.gameended && param_00.usetime)
	{
		func_29FA(param_00,0);
		wait 0.05;
	}

	if(isdefined(self))
	{
		func_29FA(param_00,1);
		self.touchtriggers[param_00.entnum] = undefined;
	}

	if(level.gameended)
	{
		return;
	}

	param_00.touchlist[var_01][var_02] = undefined;
	param_00.numtouching[var_01]--;
	param_00 func_29FF();
}

//Function Number: 40
func_29FA(param_00,param_01)
{
	if(param_01 || !param_00 func_2A2D(self.pers["team"]) || self.pers["team"] != param_00.claimteam || param_00.nousebar)
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
		self.proxbar maps\mp\gametypes\_hud_util::func_26BD();
		self.proxbar.lastuserate = -1;
		self.proxbar.lasthostmigrationstate = 0;
	}

	if(!isdefined(self.proxbartext))
	{
		self.proxbartext = maps\mp\gametypes\_hud_util::createprimaryprogressbartext();
		var_02 = param_00 getrelativeteam(self.pers["team"]);
		if(isdefined(param_00.teamusetexts[var_02]))
		{
			self.proxbartext settext(param_00.teamusetexts[var_02]);
		}
		else
		{
			self.proxbartext settext(param_00.usetext);
		}
	}

	if(self.proxbartext.hidden)
	{
		self.proxbartext maps\mp\gametypes\_hud_util::func_26BD();
		var_02 = param_00 getrelativeteam(self.pers["team"]);
		if(isdefined(param_00.teamusetexts[var_02]))
		{
			self.proxbartext settext(param_00.teamusetexts[var_02]);
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

		var_03 = param_00.curprogress / param_00.usetime;
		var_04 = 1000 / param_00.usetime * param_00.userate;
		if(isdefined(level.hostmigrationtimer))
		{
			var_04 = 0;
		}

		self.proxbar maps\mp\gametypes\_hud_util::updatebar(var_03,var_04);
		self.proxbar.lastuserate = param_00.userate;
		self.proxbar.lasthostmigrationstate = isdefined(level.hostmigrationtimer);
	}
}

//Function Number: 41
func_29FF()
{
	var_00 = self.numtouching[self.claimteam];
	var_01 = 0;
	var_02 = 0;
	if(self.claimteam != "axis")
	{
		var_01 = var_01 + self.numtouching["axis"];
	}

	if(self.claimteam != "allies")
	{
		var_01 = var_01 + self.numtouching["allies"];
	}

	foreach(var_04 in self.touchlist[self.claimteam])
	{
		if(var_04.player.pers["team"] != self.claimteam)
		{
			continue;
		}

		if(var_04.player.objectivescaler == 1)
		{
			continue;
		}

		var_00 = var_00 * var_04.player.objectivescaler;
		var_02 = var_04.player.objectivescaler;
	}

	self.userate = 0;
	if(var_00 && !var_01)
	{
		self.userate = min(var_00,4);
	}

	if(isdefined(self.isarena) && self.isarena && var_02 != 0)
	{
		self.userate = 1 * var_02;
		return;
	}

	if(isdefined(self.isarena) && self.isarena)
	{
		self.userate = 1;
	}
}

//Function Number: 42
attachusemodel()
{
	self endon("death");
	self endon("disconnect");
	self endon("done_using");
	wait 1.3;
	self attach("prop_suitcase_bomb","tag_inhand",1);
	self.attachedusemodel = "prop_suitcase_bomb";
}

//Function Number: 43
func_2A04(param_00)
{
	param_00 notify("use_hold");
	param_00 playerlinkto(self.trigger);
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
		param_00 thread attachusemodel();
	}
	else
	{
		param_00 common_scripts\utility::_disableweapon();
	}

	self.curprogress = 0;
	self.inuse = 1;
	self.userate = 0;
	param_00 thread personalusebar(self);
	var_03 = func_2A08(param_00,var_02);
	if(isdefined(param_00))
	{
		param_00 detachusemodels();
		param_00 notify("done_using");
	}

	if(isdefined(var_01) && isdefined(param_00))
	{
		param_00 thread func_2A07(var_01);
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
				param_00 switchtoweapon(var_02);
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

//Function Number: 44
detachusemodels()
{
	if(isdefined(self.attachedusemodel))
	{
		self detach(self.attachedusemodel,"tag_inhand");
		self.attachedusemodel = undefined;
	}
}

//Function Number: 45
func_2A07(param_00)
{
	self endon("use_hold");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	while(self getcurrentweapon() == param_00 && !isdefined(self.throwinggrenade))
	{
		wait 0.05;
	}

	self takeweapon(param_00);
}

//Function Number: 46
func_2A08(param_00,param_01)
{
	level endon("game_ended");
	self endon("disabled");
	var_02 = self.useweapon;
	var_03 = 1;
	var_04 = 0;
	var_05 = 1.5;
	while(maps\mp\_utility::isreallyalive(param_00) && param_00 istouching(self.trigger) && param_00 usebuttonpressed() && !isdefined(param_00.throwinggrenade) && !param_00 meleebuttonpressed() && self.curprogress < self.usetime && self.userate || var_03 && !var_03 && var_04 > var_05)
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
					param_00 switchtoweapon(param_01);
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

		wait 0.05;
		maps\mp\gametypes\_hostmigration::func_273E();
	}

	return 0;
}

//Function Number: 47
personalusebar(param_00)
{
	self endon("disconnect");
	var_01 = maps\mp\gametypes\_hud_util::createprimaryprogressbar();
	var_02 = maps\mp\gametypes\_hud_util::createprimaryprogressbartext();
	var_02 settext(param_00.usetext);
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

			var_01 maps\mp\gametypes\_hud_util::updatebar(var_05,var_06);
			if(!param_00.userate)
			{
				var_01 maps\mp\gametypes\_hud_util::hideelem();
				var_02 maps\mp\gametypes\_hud_util::hideelem();
			}
			else
			{
				var_01 maps\mp\gametypes\_hud_util::func_26BD();
				var_02 maps\mp\gametypes\_hud_util::func_26BD();
			}
		}

		var_03 = param_00.userate;
		var_04 = isdefined(level.hostmigrationtimer);
		wait 0.05;
	}

	var_01 maps\mp\gametypes\_hud_util::destroyelem();
	var_02 maps\mp\gametypes\_hud_util::destroyelem();
}

//Function Number: 48
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

//Function Number: 49
func_2A0B()
{
	if(self.visibleteam == "any")
	{
		updateworldicon("friendly",1);
		updateworldicon("enemy",1);
		return;
	}

	if(self.visibleteam == "friendly")
	{
		updateworldicon("friendly",1);
		updateworldicon("enemy",0);
		return;
	}

	if(self.visibleteam == "enemy")
	{
		updateworldicon("friendly",0);
		updateworldicon("enemy",1);
		return;
	}

	updateworldicon("friendly",0);
	updateworldicon("enemy",0);
}

//Function Number: 50
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
		var_05 = maps\mp\gametypes\_objpoints::func_299C(var_04);
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

//Function Number: 51
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

//Function Number: 52
updatetimer(param_00,param_01)
{
}

//Function Number: 53
func_2A0E()
{
	if(self.visibleteam == "any")
	{
		updatecompassicon("friendly",1);
		updatecompassicon("enemy",1);
		return;
	}

	if(self.visibleteam == "friendly")
	{
		updatecompassicon("friendly",1);
		updatecompassicon("enemy",0);
		return;
	}

	if(self.visibleteam == "enemy")
	{
		updatecompassicon("friendly",0);
		updatecompassicon("enemy",1);
		return;
	}

	updatecompassicon("friendly",0);
	updatecompassicon("enemy",0);
}

//Function Number: 54
updatecompassicon(param_00,param_01)
{
	var_02 = getupdateteams(param_00);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_04 = param_01;
		if(!var_04 && func_2A12(var_02[var_03]))
		{
			var_04 = 1;
		}

		var_05 = self.objidallies;
		if(var_02[var_03] == "axis")
		{
			var_05 = self.objidaxis;
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

			objective_position(var_05,self.curorigin);
		}
	}
}

//Function Number: 55
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

//Function Number: 56
getupdateteams(param_00)
{
	var_01 = [];
	if(param_00 == "friendly")
	{
		if(isfriendlyteam("allies"))
		{
		}
		else if(isfriendlyteam("axis"))
		{
		}
	}
	else if(var_01 == "enemy")
	{
		if(!isfriendlyteam("allies"))
		{
		}

		if(!isfriendlyteam("axis"))
		{
		}
	}

	return var_41;
}

//Function Number: 57
func_2A12(param_00)
{
	if(!isdefined(self.carrier))
	{
		return 0;
	}

	if(self.carrier maps\mp\_utility::func_27AF("specialty_gpsjammer"))
	{
		return 0;
	}

	return getteamradar(param_00);
}

//Function Number: 58
func_2A13()
{
	self endon("death");
	self endon("carrier_cleared");
	for(;;)
	{
		level waittill("radar_status_change");
		func_2A0E();
	}
}

//Function Number: 59
setownerteam(param_00)
{
	self.ownerteam = param_00;
	updatetrigger();
	func_2A0E();
	func_2A0B();
}

//Function Number: 60
func_2A15()
{
	return self.ownerteam;
}

//Function Number: 61
setusetime(param_00)
{
	self.usetime = int(param_00 * 1000);
}

//Function Number: 62
setusetext(param_00)
{
	self.usetext = param_00;
}

//Function Number: 63
func_2A18(param_00,param_01)
{
	self.teamusetimes[param_00] = int(param_01 * 1000);
}

//Function Number: 64
setteamusetext(param_00,param_01)
{
	self.teamusetexts[param_00] = param_01;
}

//Function Number: 65
setusehinttext(param_00)
{
	self.trigger sethintstring(param_00);
}

//Function Number: 66
allowcarry(param_00)
{
	self.interactteam = param_00;
}

//Function Number: 67
allowuse(param_00)
{
	self.interactteam = param_00;
	updatetrigger();
}

//Function Number: 68
setvisibleteam(param_00)
{
	self.visibleteam = param_00;
	func_2A0E();
	func_2A0B();
}

//Function Number: 69
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

				self.visuals[var_01] thread func_2A20();
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

//Function Number: 70
func_2A20()
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

		wait 0.05;
	}
}

//Function Number: 71
setcarriervisible(param_00)
{
	self.carriervisible = param_00;
}

//Function Number: 72
setcanuse(param_00)
{
	self.useteam = param_00;
}

//Function Number: 73
set2dicon(param_00,param_01)
{
	self.compassicons[param_00] = param_01;
	func_2A0E();
}

//Function Number: 74
func_2A25(param_00,param_01)
{
	self.worldicons[param_00] = param_01;
	func_2A0B();
}

//Function Number: 75
func_2A26(param_00,param_01)
{
	self.worlduseicons[param_00] = param_01;
}

//Function Number: 76
setcarryicon(param_00)
{
	self.carryicon = param_00;
}

//Function Number: 77
disableobject()
{
	self notify("disabled");
	if(self.type == "carryObject")
	{
		if(isdefined(self.carrier))
		{
			self.carrier func_29E2(self);
		}

		for(var_00 = 0;var_00 < self.visuals.size;var_00++)
		{
			self.visuals[var_00] hide();
		}
	}

	self.trigger common_scripts\utility::trigger_off();
	setvisibleteam("none");
}

//Function Number: 78
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

//Function Number: 79
getrelativeteam(param_00)
{
	if(param_00 == self.ownerteam)
	{
		return "friendly";
	}

	return "enemy";
}

//Function Number: 80
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

	return 0;
}

//Function Number: 81
func_2A2D(param_00,param_01)
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

//Function Number: 82
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

	return 0;
}

//Function Number: 83
func_2A2F(param_00)
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

//Function Number: 84
getenemyteam(param_00)
{
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

//Function Number: 85
func_2A31()
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

//Function Number: 86
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