/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/killstreaks/_drone_common.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 24
 * Decompile Time: 390 ms
 * Timestamp: 10/27/2023 2:09:21 AM
*******************************************************************/

//Function Number: 1
dronegetspawnpoint(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 50;
	}

	var_01 = 75;
	var_02 = 23;
	var_03 = var_02 * 2;
	var_04 = self.origin + (0,0,param_00);
	var_05 = self getplayerangles();
	var_06 = anglestoforward(common_scripts\utility::flat_angle(var_05));
	var_07 = var_04 + var_06 * var_01;
	var_08 = var_07;
	var_09 = self.angles;
	var_0A = 1;
	var_0B = getspawninwateroffset(var_08 + (0,0,-30));
	if(isdefined(var_0B) && var_0B > 0)
	{
		var_08 = var_08 + (0,0,var_0B);
		var_04 = var_04 + (0,0,var_0B);
	}
	else if(!isdefined(var_0B))
	{
		var_0A = 0;
	}

	if(var_0A && !sighttracepassed(var_04,var_07,1,self))
	{
		var_0A = 0;
	}

	if(var_0A)
	{
		var_0C = bullettrace(var_04,var_07,1,self,1,0,1,1,1);
		if(var_0C["fraction"] < 1)
		{
			var_0A = 0;
		}
	}

	if(var_0A)
	{
		var_0D = var_04 + (0,0,var_03 * -0.5);
		var_07 = var_07 + (0,0,var_03 * -0.5);
		var_0C = self aiphysicstrace(var_0D,var_07,var_02,var_03,0,1);
		if(var_0C["fraction"] < 1)
		{
			var_0A = 0;
		}
	}

	var_0E = spawnstruct();
	var_0E.placementok = var_0A;
	var_0E.origin = var_08;
	var_0E.angles = var_09;
	return var_0E;
}

//Function Number: 2
getspawninwateroffset(param_00)
{
	var_01 = getentarray("trigger_underwater","targetname");
	if(var_01.size == 0)
	{
		return 0;
	}

	var_02 = 200;
	var_03 = 0;
	var_04 = spawn("script_origin",param_00);
	var_05 = 0;
	while(var_03 < var_02)
	{
		if(touchingwatertriggers(var_04,var_01))
		{
			var_03 = var_03 + 10;
			var_04.origin = var_04.origin + (0,0,10);
			continue;
		}

		break;
	}

	var_04 delete();
	if(var_03 >= var_02)
	{
		return undefined;
	}

	return var_03;
}

//Function Number: 3
touchingwatertriggers(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_01.size;var_02++)
	{
		var_03 = param_01[var_02];
		if(param_00 istouching(var_03))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 4
droneaddtogloballist(param_00)
{
	level.ugvs[param_00] = self;
}

//Function Number: 5
droneremovefromgloballist(param_00)
{
	level.ugvs[param_00] = undefined;
}

//Function Number: 6
droneinitcloakomnvars()
{
}

//Function Number: 7
dronesetupcloaking(param_00,param_01)
{
	param_00 endon("death");
	droneinitcloakomnvars();
	param_00.cloakstate = 0;
	param_00.cloakcooldown = 0;
	dronecloakingtransition(param_00,1,1);
	maps\mp\killstreaks\_killstreaks::playerwaittillridekillstreakcomplete();
	if(isdefined(param_01) && param_01)
	{
		thread dronemonitordamagewhilecloaking(param_00);
		self setclientomnvar("ui_drone_cloak",2);
		var_02 = 10000;
		var_03 = gettime() + var_02;
		self setclientomnvar("ui_drone_cloak_time",var_03);
		param_00.cloakcooldown = 5;
		thread cloakcooldown(param_00);
		thread dronecloakwaitforexit(param_00);
		return;
	}

	param_00 playsound("recon_drn_cloak_deactivate");
	dronecloakingtransition(param_00,0);
}

//Function Number: 8
droneiscloaked(param_00)
{
	return param_00.hascloak && param_00.cloakstate >= 0;
}

//Function Number: 9
dronecloakready(param_00,param_01)
{
	param_00 endon("death");
	if(isdefined(param_01) && param_01)
	{
		thread dronecloakcooldown(param_00);
		self waittill("CloakCharged");
	}

	for(;;)
	{
		self setclientomnvar("ui_drone_cloak",1);
		thread dronecloakactivated(param_00);
		thread dronecloakcooldown(param_00);
		if(param_00.cloakcooldown != 0)
		{
			self setclientomnvar("ui_drone_cloak",3);
			wait(param_00.cloakcooldown);
		}

		if(param_00.hascloak)
		{
			self setclientomnvar("ui_drone_cloak",1);
		}

		param_00 waittill("Cloak");
		param_00 notify("ActivateCloak");
		param_00 playsound("recon_drn_cloak_activate");
		self waittill("CloakCharged");
	}
}

//Function Number: 10
dronecloakactivated(param_00)
{
	param_00 endon("death");
	param_00 waittill("ActivateCloak");
	thread dronecloakingtransition(param_00,1);
	thread dronemonitordamagewhilecloaking(param_00);
	var_01 = 10000;
	var_02 = gettime() + var_01;
	self setclientomnvar("ui_drone_cloak_time",var_02);
	self setclientomnvar("ui_drone_cloak",2);
	param_00.cloakcooldown = 5;
	thread cloakcooldown(param_00);
	thread dronecloakwaitforexit(param_00);
}

//Function Number: 11
dronecloakcooldown(param_00)
{
	param_00 endon("death");
	self waittill("UnCloak");
	param_00 playsound("recon_drn_cloak_deactivate");
	thread dronecloakingtransition(param_00,0);
	self setclientomnvar("ui_drone_cloak",3);
	thread dronecloakdeactivateddialog(param_00);
}

//Function Number: 12
cloakcooldown(param_00)
{
	param_00 endon("death");
	self waittill("UnCloak");
	while(param_00.cloakcooldown > 0)
	{
		param_00.cloakcooldown = param_00.cloakcooldown - 0.5;
		wait(0.5);
	}

	param_00.cloakcooldown = 0;
	self notify("CloakCharged");
}

//Function Number: 13
dronecloakwaitforexit(param_00)
{
	param_00 endon("death");
	var_01 = gettime();
	common_scripts\utility::waittill_any_timeout_no_endon_death(10,"ForceUncloak","Cloak");
	var_02 = gettime();
	var_03 = max(var_02 - var_01,5000);
	param_00.cloakcooldown = var_03 / 1000;
	var_04 = gettime() + var_03;
	self setclientomnvar("ui_drone_cloak_cooldown",var_04);
	self notify("UnCloak");
}

//Function Number: 14
dronecloakingtransition(param_00,param_01,param_02)
{
	param_00 notify("cloaking_transition");
	param_00 endon("cloaking_transition");
	param_00 endon("death");
	if(param_01)
	{
		if(param_00.cloakstate == -2)
		{
			return;
		}

		param_00.cloakstate = -1;
		param_00 cloakingenable();
		if(isdefined(param_00.mgturret))
		{
			param_00.mgturret cloakingenable();
		}

		param_00 vehicle_setminimapvisible(0);
		if(!isdefined(param_02) || !param_02)
		{
			wait(2.2);
		}
		else
		{
			wait(1.5);
		}

		param_00 show();
		if(isdefined(param_00.mgturret))
		{
			param_00.mgturret show();
		}

		param_00.cloakstate = -2;
		return;
	}

	if(param_00.cloakstate == 2)
	{
		return;
	}

	param_00.cloakstate = 1;
	param_00 cloakingdisable();
	param_00 vehicle_setminimapvisible(1);
	if(isdefined(param_00.mgturret))
	{
		param_00.mgturret cloakingdisable();
	}

	wait(2.2);
	param_00.cloakstate = 2;
}

//Function Number: 15
dronecloakdeactivateddialog(param_00)
{
	param_00 endon("death");
	self endon("CloakCharged");
	for(;;)
	{
		self waittill("Cloak");
		self playlocalsound("recon_drn_cloak_notready");
		wait(1);
	}
}

//Function Number: 16
dronemonitordamagewhilecloaking(param_00)
{
	param_00 endon("death");
	self endon("UnCloak");
	wait(1);
	param_00 waittill("damage");
	self notify("ForceUncloak");
}

//Function Number: 17
updateshootinglocation(param_00,param_01,param_02)
{
	param_00 endon("death");
	self endon("disconnect");
	param_00 endon("stopShootLocationUpdate");
	param_00.targetent = spawn("script_model",(0,0,0));
	param_00.targetent setmodel("tag_origin");
	param_00.targetent.angles = (-90,0,0);
	if(isdefined(param_00.mgturret) && !isdefined(param_02) || !param_02)
	{
		param_00.mgturret settargetentity(param_00.targetent);
		param_00.mgturret turretsetgroundaimentity(param_00.targetent);
	}
	else
	{
		param_00 setotherent(param_00.targetent);
	}

	thread _cleanupshootinglocationondeath(param_00,param_01);
	if(isdefined(param_01))
	{
		playfxontagforclients(param_01,param_00.targetent,"tag_origin",self);
		param_00 thread showreticletoenemies(param_01);
	}

	if(isdefined(param_00.hasaioption) && param_00.hasaioption)
	{
		return;
	}

	for(;;)
	{
		var_03 = self getvieworigin();
		var_04 = self getplayerangles();
		var_05 = anglestoforward(var_04);
		var_06 = var_03 + var_05 * 8000;
		var_07 = bullettrace(var_03,var_06,0,param_00);
		param_00.targetent.origin = var_07["position"];
		wait 0.05;
	}
}

//Function Number: 18
showreticletoenemies(param_00)
{
	self endon("death");
	self endon("end_remote");
	if(!level.hardcoremode)
	{
		foreach(var_02 in level.players)
		{
			if(self.owner maps\mp\_utility::isenemy(var_02))
			{
				wait 0.05;
				playfxontagforclients(param_00,self.targetent,"tag_origin",var_02);
			}
		}
	}
}

//Function Number: 19
_cleanupshootinglocationondeath(param_00,param_01)
{
	param_00 common_scripts\utility::waittill_any("death","stopShootLocationUpdate");
	if(isdefined(param_00.targetent))
	{
		var_02 = param_00.targetent;
		if(isdefined(param_01))
		{
			stopfxontag(param_01,var_02,"tag_origin");
		}

		wait 0.05;
		var_02 delete();
	}
}

//Function Number: 20
playerhandleexhaustfx(param_00,param_01,param_02,param_03)
{
	param_00 endon("death");
	if(isdefined(param_03))
	{
		self endon(param_03);
	}

	playfxontag(common_scripts\utility::getfx(param_01),param_00,param_02);
	thread playerdeleteexhaustfxonvehicledeath(param_00,param_01,param_02);
	if(!param_00.hascloak)
	{
		return;
	}

	for(;;)
	{
		self waittill("Cloak");
		stopfxontag(common_scripts\utility::getfx(param_01),param_00,param_02);
		wait 0.05;
		playfxontagforclients(common_scripts\utility::getfx(param_01),param_00,param_02,self);
		self waittill("UnCloak");
		stopfxontag(common_scripts\utility::getfx(param_01),param_00,param_02);
		wait 0.05;
		playfxontag(common_scripts\utility::getfx(param_01),param_00,param_02);
	}
}

//Function Number: 21
playerdeleteexhaustfxonvehicledeath(param_00,param_01,param_02)
{
	param_00 waittill("death");
	killfxontag(common_scripts\utility::getfx(param_01),param_00,param_02);
}

//Function Number: 22
setdronevisionandlightsetpermap(param_00,param_01)
{
	self endon("disconnect");
	param_01 endon("death");
	wait(param_00);
	if(isdefined(level.dronevisionset))
	{
		self setclienttriggervisionset(level.dronevisionset,0);
	}

	if(isdefined(level.dronelightset))
	{
		self lightsetforplayer(level.dronelightset);
	}
}

//Function Number: 23
removedronevisionandlightsetpermap(param_00)
{
	self setclienttriggervisionset("",param_00);
	self lightsetforplayer("");
}

//Function Number: 24
playerwatchfordroneemp(param_00)
{
	level endon("game_ended");
	param_00 endon("death");
	self endon("assaultDroneHunterKiller");
	param_00 waittill("emp_damage");
	param_00 notify("death");
}